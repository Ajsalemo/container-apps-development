param environment_name string
param location string 
param azureContainerRegistry string
param azureContainerRegistryUsername string
param azureRedisHost string
param azureRedisPassword string
param azureRedisEnableTLS bool
@secure()
param azureContainerRegistryPassword string

var logAnalyticsWorkspaceName = 'logs-${environment_name}'
var appInsightsName = 'appins-${environment_name}'

resource logAnalyticsWorkspace'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

resource environment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: environment_name
  location: location
  properties: {
    daprAIInstrumentationKey: reference(appInsights.id, '2020-02-02').InstrumentationKey
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: reference(logAnalyticsWorkspace.id, '2020-03-01-preview').customerId
        sharedKey: listKeys(logAnalyticsWorkspace.id, '2020-03-01-preview').primarySharedKey
      }
    }
  }
}

// Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.app/managedenvironments/daprcomponents?tabs=bicep
resource daprComponent 'Microsoft.App/managedEnvironments/daprComponents@2022-03-01' = {
  name: 'statestore'
  parent: environment
  properties: {
    componentType: 'state.redis'
    version: 'v1'
    ignoreErrors: false
    initTimeout: '5s'
    metadata: [
      {
        name: 'redisHost'
        value: azureRedisHost
      }
      {
        name: 'redisPassword'
        value: azureRedisPassword
      }
      {
        name: 'enableTLS'
        value: '${bool(azureRedisEnableTLS)}'
      }
    ]
    // This needs to match the Dapr appId
    // Or else it's return a ERR_STATE_STORES_NOT_CONFIGURED
    scopes: [
      'dapr-node-statemanagement-redis'
    ]
  }
}


resource nodestatemanagementredis 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'nodestatemanagementredis'
  location: location
  properties: {
    managedEnvironmentId: environment.id
    configuration: {
      secrets: [
        {
          name: 'containerregistrypasswordref'
          value: azureContainerRegistryPassword
        }
      ]
      ingress: {
        external: true
        targetPort: 3000
      }
      dapr: {
        enabled: true
        appId: 'dapr-node-statemanagement-redis'
        appProtocol: 'http'
        appPort: 3000
      }
      registries: [
        {
          // server is in the format of myregistry.azurecr.io
          server: azureContainerRegistry
          username: azureContainerRegistryUsername
          passwordSecretRef: 'containerregistrypasswordref'
        }
      ]
    }
    template: {
      containers: [
        {
          image: '${azureContainerRegistry}/dapr-node-statemanagement-redis:latest'
          name: 'dapr-node-statemanagement-redis'
          resources: {
            cpu: '0.5'
            memory: '1.0Gi'
          }
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 1
      }
    }
  }
}
