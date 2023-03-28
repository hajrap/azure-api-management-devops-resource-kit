param logAnalatics_name string
param logAnalatics_retentionDays int
param region string

resource logAnalyticsResource 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: logAnalatics_name
  location: region
  tags: {
    displayName: 'Log Analytics'
    ProjectName: logAnalatics_name
  }
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: logAnalatics_retentionDays
  }
}

output logAnalyticsId string = logAnalyticsResource.id
