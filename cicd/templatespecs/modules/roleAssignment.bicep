param roleGuid string
param resourceId string
param apiVersion string

resource roleAssignmentResource 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: '${guid(resourceId)}'
  properties: {
    roleDefinitionId: '${subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleGuid)}'
    principalId: reference(resourceId, apiVersion, 'Full').identity.principalId
  }
}
