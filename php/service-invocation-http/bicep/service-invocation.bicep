param environment_name string
param location string 
param azureContainerRegistry string
param azureContainerRegistryUsername string
param appKey string
param daprAppId string
@secure()
param azureContainerRegistryPassword string

var logAnalyticsWorkspaceName = 'logs-${environment_name}'

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

resource environment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: environment_name
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: reference(logAnalyticsWorkspace.id, '2020-03-01-preview').customerId
        sharedKey: listKeys(logAnalyticsWorkspace.id, '2020-03-01-preview').primarySharedKey
      }
    }
  }
}

resource client 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'client'
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
        targetPort: 80
      }
      dapr: {
        enabled: true
        appId: 'client-app'
        appProtocol: 'http'
        appPort: 80
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
          image: '${azureContainerRegistry}/php-service-invocation-http-client:latest'
          name: 'php-service-invocation-http-client'
          resources: {
            cpu: '0.5'
            memory: '1.0Gi'
          }
          env: [
            {
              name: 'DAPR_APP_ID'
              value: daprAppId
            }
            {
              name: 'APP_KEY'
              value: appKey
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 1
      }
    }
  }
}

resource server 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'server'
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
        targetPort: 80
      }
      dapr: {
        enabled: true
        appId: 'server-app'
        appProtocol: 'http'
        appPort: 80
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
          image: '${azureContainerRegistry}/php-service-invocation-http-server:latest'
          name: 'php-service-invocation-http-server'
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
  dependsOn: [
    client
  ]
}
