param settingName string
param vaultName string
param storageAccountId string
param workspaceId string

resource keyVaultDiagnosticsSettingResource 'Microsoft.KeyVault/vaults/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${vaultName}/Microsoft.Insights/${settingName}'
  properties: {
    workspaceId: workspaceId
    storageAccountId: storageAccountId
    logs: [
      {
        category: 'AuditEvent'
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
  dependsOn: []
}
