param environment_name string
param location string 
param azureContainerRegistry string
param azureContainerRegistryUsername string
param storageAccountName string
param storageContainerName string
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

resource environment 'Microsoft.App/managedEnvironments@2022-01-01-preview' = {
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
resource daprComponent 'Microsoft.App/managedEnvironments/daprComponents@2022-01-01-preview' = {
  name: 'statestore'
  parent: environment
  properties: {
    componentType: 'state.azure.blobstorage'
    version: 'v1'
    ignoreErrors: false
    initTimeout: '5s'
    secrets: [
      {
        name: 'storageaccountkey'
        value: listKeys(resourceId('Microsoft.Storage/storageAccounts/', storageAccountName), '2021-09-01').keys[0].value
      }
    ]
    metadata: [
      {
        name: 'accountName'
        value: storageAccountName
      }
      {
        name: 'containerName'
        value: storageContainerName
      }
      {
        name: 'accountKey'
        secretRef: 'storageaccountkey'
      }
    ]
    // This needs to match the Dapr appId
    // Or else it's return a ERR_STATE_STORES_NOT_CONFIGURED
    scopes: [
      'dapr-node-statemanagement-http'
    ]
  }
}


resource nodestatemanagementhttpapp 'Microsoft.App/containerApps@2022-01-01-preview' = {
  name: 'nodestatemanagementhttpapp'
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
        appId: 'dapr-node-statemanagement-http'
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
          image: '${azureContainerRegistry}/dapr-node-statemanagement-http:latest'
          name: 'dapr-node-statemanagement-http'
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
