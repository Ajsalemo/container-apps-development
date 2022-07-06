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

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
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
  name: 'pubsub'
  parent: environment
  properties: {
    componentType: 'pubsub.azure.eventhubs'
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
        name: 'connectionString'
        value: 'Endpoint=sb://ansalemo-eventhub.servicebus.windows.net/;SharedAccessKeyName=ansalemo-eventhub-policy;SharedAccessKey=TgcCCTqGR5bD0qYdDVTX+Og7iDLHQj/wDc0B8KztmA4=;EntityPath=ansalemo-eventhub-partition'
      }
      {
        name: 'storageAccountName'
        value: storageAccountName
      }
      {
        name: 'storageAccountKey'
        secretRef: 'storageaccountkey'
      }
      {
        name: 'storageContainerName'
        value: storageContainerName
      }
    ]
    scopes: [
      'checkout'
      'order-processor'
    ]
  }
}

resource checkout 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'checkout'
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
        targetPort: 8000
      }
      dapr: {
        enabled: true
        appId: 'checkout'
        appProtocol: 'http'
        appPort: 8000
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
          image: '${azureContainerRegistry}/container-apps-development-pubsub-checkout:latest'
          name: 'containerappsdevelopmentpubsubcheckout'
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

resource orderprocessor 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'orderprocessor'
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
        targetPort: 8000
      }
      dapr: {
        enabled: true
        appId: 'order-processor'
        appProtocol: 'http'
        appPort: 8000
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
          image: '${azureContainerRegistry}/container-apps-development-pubsub-orderprocessor:latest'
          name: 'containerappsdevelopmentpubsuborderprocessor'
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
