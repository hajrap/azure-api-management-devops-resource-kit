param keyvault_name string
param keyName string
param expirySeconds int

resource keyvaultKeyResource 'Microsoft.KeyVault/vaults/keys@2019-09-01' = {
  name: '${keyvault_name}/${keyName}'
  properties: {
    attributes: {
      exp: expirySeconds
    }
    kty: 'RSA'
    keySize: 2048
  }
}
