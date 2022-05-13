param environment_name string
param location string 
param vnetName string
param infraSubnetName string
param runtimeSubnetName string

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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: infraSubnetName
        properties: {
          addressPrefix: '10.0.16.0/21'
        }
      }
      {
        name: runtimeSubnetName
        properties: {
          addressPrefix: '10.0.8.0/21'
        }
      }
    ]
  }
}

resource environment 'Microsoft.App/managedEnvironments@2022-01-01-preview' = {
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
    vnetConfiguration: {
      internal: false
      infrastructureSubnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name, virtualNetwork.properties.subnets[0].name)
      dockerBridgeCidr: '10.2.0.1/16'
      platformReservedCidr: '10.1.0.0/16'
      platformReservedDnsIP: '10.1.0.2'
      runtimeSubnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name, virtualNetwork.properties.subnets[1].name)
    }
  }
}

resource nginxcontainerapp 'Microsoft.App/containerApps@2022-01-01-preview' = {
  name: 'nginxcontainerapp-name'
  location: location
  properties: {
    managedEnvironmentId: environment.id
    configuration: {
      ingress: {
        external: true
        targetPort: 80
      }
    }
    template: {
      containers: [
        {
          image: 'nginx'
          name: 'nginxcontainerapp'
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
