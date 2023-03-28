param keyvault_name string
param certName string

@secure()
param base64 string
param expirySeconds int

resource keyvaultCertificateResource 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${keyvault_name}/${certName}'
  properties: {
    value: base64
    contentType: 'application/x-pkcs12'
    attributes: {
      exp: expirySeconds
    }
  }
}
