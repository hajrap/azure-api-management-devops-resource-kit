@description('Service Bus namespace name.')
param serviceBus_namespaces_name string 

@description('Location for all resources.')
param region string

param serviceBus_sku object

@description('private endpoints externalid.')
param privateEndpoints_pe_sb_externalid string 

resource serviceBusResource 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' = {
  name: serviceBus_namespaces_name
  location: region
  sku: serviceBus_sku
  properties: {
    disableLocalAuth: false
    zoneRedundant: true
    privateEndpointConnections: [
      {
        properties: {
          provisioningState: 'Succeeded'
          privateEndpoint: {
            id: privateEndpoints_pe_sb_externalid
          }
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
          }
        }
      }
    ]
  }
}

resource serviceBusResource_namespace_default 'Microsoft.ServiceBus/namespaces/networkRuleSets@2021-06-01-preview' = {
  parent: serviceBusResource
  name: 'default'
  properties: {
    publicNetworkAccess: 'Disabled'
    defaultAction: 'Allow'
    virtualNetworkRules: []
    ipRules: []
  }
}




output serviceBusResourceId string = serviceBusResource.id

