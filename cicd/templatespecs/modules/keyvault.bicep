param keyvault_name string
param region string
param keyvault_skuProperties object
param keyvault_retentionDays int
// param apim_identity object
// param sa_identity object

resource keyvaultResource 'Microsoft.KeyVault/vaults@2019-09-01' = {
  location: region
  name: keyvault_name
  tags: {
    displayName: 'Key Vault'
  }
  properties: {
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    sku: keyvault_skuProperties
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      virtualNetworkRules: []
    }
    enableSoftDelete: true
    softDeleteRetentionInDays: keyvault_retentionDays
    enablePurgeProtection: true
    // accessPolicies: [
    //   {
    //     tenantId: apim_identity.tenantId
    //     objectId: apim_identity.principalId
    //     permissions: {
    //       secrets: [
    //         'get'
    //         'list'
    //       ]
    //     }
    //   }
    //   {
    //     tenantId: sa_identity.tenantId
    //     objectId: sa_identity.principalId
    //     permissions: {
    //       keys: [
    //         'wrapkey'
    //         'unwrapkey'
    //         'get'
    //         'list'
    //       ]
    //     }
    //   }
    // ]
  }
}

output keyvaultResourceName string = keyvaultResource.name
output keyvaultResourceId string = keyvaultResource.id
output keyvaultUri string = keyvaultResource.properties.vaultUri
