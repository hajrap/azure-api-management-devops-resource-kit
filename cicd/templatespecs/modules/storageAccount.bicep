@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
@description('Storage Account type')
param storageAccount_type string

@description('Storage account name.')
param storageAccount_name string

@description('Location for all resources.')
param region string

param vnet_snetId string

resource storageAccountResource 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccount_name
  location: region
  tags: {
    displayName: 'Storage Account'
    ProjectName: storageAccount_name
  }
  sku: {
    name: storageAccount_type
  }
  kind: 'StorageV2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    minimumTlsVersion:'TLS1_2'
    allowBlobPublicAccess: false
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: vnet_snetId
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
    }
  }
}

output identity object = storageAccountResource.identity
output storageAccountResourceName string = storageAccountResource.name
output storageAccountId string = storageAccountResource.id
output storageAccountApiVersion string = storageAccountResource.apiVersion
