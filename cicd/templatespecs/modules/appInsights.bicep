param region string
param appInsights_name string
param logAnalaticsResourceID string
//param appInsights_30DayPurge bool

resource appInsightsResource 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: appInsights_name
  location: region
  kind: 'string'
  tags: {
    displayName: 'AppInsights'
    ProjectName: appInsights_name
  }
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalaticsResourceID
    //ImmediatePurgeDataOn30Days: appInsights_30DayPurge
    IngestionMode: 'LogAnalytics'
  }
}

output APPINSIGHTS_INSTRUMENTATIONKEY string = appInsightsResource.properties.InstrumentationKey
output resourceId string = appInsightsResource.id
