param keyvault_name string
param secretName string

@secure()
param secretValue string
param expirySeconds int

resource keyvaultSecretResource 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${keyvault_name}/${secretName}'
  properties: {
    value: secretValue
    attributes: {
      exp: expirySeconds
    }
  }
}
