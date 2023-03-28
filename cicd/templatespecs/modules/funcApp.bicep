param region string
param appServicePlanId string
param funcApp_name string
param appInsights_key string
param storageAccount_name string
param storageAccount_id string
param storageAccount_apiVersion string
param keyVaultUri string
param keyVaultTestSecretName string
param exampleParamOne string
param exampleParamTwo string
param detailedHealthCheckReports bool
param excludeHealthyReports bool

resource funcAppResource 'Microsoft.Web/sites@2020-09-01' = {
  name: funcApp_name
  location: region
  tags: {
    displayName: 'Function App'
    ProjectName: funcApp_name
  }
  kind: 'functionapp'
  identity: {
    type:'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${funcApp_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${funcApp_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      netFrameworkVersion: 'v5.0'
      use32BitWorkerProcess: true
      webSocketsEnabled: true
      alwaysOn: false
      http20Enabled: true
      healthCheckPath: '/api/HttpHealthCheck'
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
      appSettings: [
        {
          'name': 'APPINSIGHTS_INSTRUMENTATIONKEY'
          'value': appInsights_key
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount_name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount_id, storageAccount_apiVersion).keys[0].value}'
        }
        {
          'name': 'FUNCTIONS_EXTENSION_VERSION'
          'value': '~3'
        }
        {
          'name': 'FUNCTIONS_WORKER_RUNTIME'
          'value': 'dotnet-isolated'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount_name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount_id, storageAccount_apiVersion).keys[0].value}'
        }
        {
          name: 'FuncOptions:KeyVaultUri'
          value: keyVaultUri
        }
        {
          name: 'FuncOptions:KeyVaultTestSecretName'
          value: keyVaultTestSecretName
          //value: 'testbrokenlookup'
        }
        {
          name: 'FuncOptions:ExampleParamOne'
          value: exampleParamOne
        }
        {
          name: 'FuncOptions:ExampleParamTwo'
          value: exampleParamTwo
        }
        {
          name: 'FuncOptions:DetailedHealthCheckReports'
          value: string(detailedHealthCheckReports)
        }
        {
          name: 'FuncOptions:ExcludeHealthyReports'
          value: string(excludeHealthyReports)
        }
      ]
    }
  }
}

output siteUrl string = funcAppResource.properties.hostNames[0]
output defaultHostName string = funcAppResource.properties.defaultHostName
output resourceId string = funcAppResource.id
output hostKey string = listkeys(concat(funcAppResource.id, '/host/default/'),'2016-08-01').functionKeys.default
