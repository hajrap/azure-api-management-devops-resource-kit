param apiManagement_name string
param keyVault_url string
param keyVault_secretName string

resource apiManagementKeyVaultNameValueResource 'Microsoft.ApiManagement/service/namedValues@2021-01-01-preview' = {
  name: '${apiManagement_name}/${keyVault_secretName}'
  properties: {
    displayName: keyVault_secretName
    keyVault: {
      secretIdentifier: '${keyVault_url}secrets/${keyVault_secretName}'
    }
    tags: []
    secret: true
  }
}
