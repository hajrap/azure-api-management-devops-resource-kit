param apiManagement_name string
param product_name string
param product_display_name string
param product_description string
param product_state string
param subscription_name string
param subscription_display_name string
param subscription_state string

resource apiManagementProductResource 'Microsoft.ApiManagement/service/products@2021-01-01-preview' = {
  name: '${apiManagement_name}/${product_name}'
  properties: {
    displayName: product_display_name
    description: product_description
    subscriptionRequired: true
    approvalRequired: false
    state: product_state
  }
}
resource apiManagementSubscriptionResource 'Microsoft.ApiManagement/service/subscriptions@2021-01-01-preview' = {
  name: '${apiManagement_name}/${subscription_name}'
  properties: {
    scope: apiManagementProductResource.id
    displayName: subscription_display_name
    state: subscription_state
    allowTracing: true
  }
}
