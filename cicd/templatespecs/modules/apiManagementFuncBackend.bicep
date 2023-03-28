param apiManagement_name string
param funcApp_namePrimary string
param keyvault_funcAppHostKey string

resource apiManagementFuncBackendResource 'Microsoft.ApiManagement/service/backends@2020-12-01' = {
  name: '${apiManagement_name}/${funcApp_namePrimary}'
  properties: {
    description: funcApp_namePrimary
    url: 'https://${funcApp_namePrimary}.azurewebsites.net/api'
    protocol: 'http'
    credentials: {
      query: {}
      header: {
        'x-functions-key': [
          keyvault_funcAppHostKey
        ]
      }
    }
  }
}

