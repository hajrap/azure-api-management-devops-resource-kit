param region string
param appServicePlan_name string
param appServicePlan_sku object
param appServicePlan_properties object

resource appServicePlanResource 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlan_name
  location: region
  tags: {
    displayName: 'App Service Plan'
    ProjectName: appServicePlan_name
  }
  sku: appServicePlan_sku
  properties: appServicePlan_properties
}

output appServicePlanId string = appServicePlanResource.id
