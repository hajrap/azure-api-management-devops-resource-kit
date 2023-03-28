param settingName string
param apiManagementName string
param storageAccountId string
param workspaceId string

resource apiManagementDiagnosticsSettingResource 'Microsoft.ApiManagement/service/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${apiManagementName}/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    storageAccountId: storageAccountId
    logs: [
      {
        category: 'GatewayLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}
