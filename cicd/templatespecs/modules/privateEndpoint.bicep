param privateEndpoints_name string 
param privateLinkService_id string 
param virtualNetworks_subnet_id string 

param groupId string

param privateDnsZones_name string

// var privateDnsZoneNameId = resourceId('Microsoft.Network/privateDnsZones', privateDnsZones_name)

resource privateDnsZoneName 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZones_name
  location: 'global'
}

resource privateEndpoints_resource 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: privateEndpoints_name
  location: 'australiaeast'
  tags: {
    Description: 'Sydney Water Shared Services Dev Integration Components'
    Name: 'Sydney Water Shared Services'
  }
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_name
        properties: {
          privateLinkServiceId: privateLinkService_id
          groupIds: [
            groupId
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    subnet: {
      id: virtualNetworks_subnet_id
    }
    customDnsConfigs: []
  }
 }
 resource privateEndpoints_privateDnsZoneGroups_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = {
  parent: privateEndpoints_resource
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'dnsConfig'
        properties: {
          privateDnsZoneId: privateDnsZoneName.id
        }
      }
    ]
  }
}
