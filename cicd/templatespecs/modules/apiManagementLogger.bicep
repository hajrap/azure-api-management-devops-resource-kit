param apiManagement_name string
param appInsights_name string
param appInsights_key string

resource apiManagementResource 'Microsoft.ApiManagement/service/loggers@2020-12-01' = {
  name: '${apiManagement_name}/${appInsights_name}'
  properties:{
    loggerType: 'applicationInsights'
    credentials: {
      instrumentationKey: appInsights_key
    }
  }
}
output loggers_resourceId string = apiManagementResource.id
