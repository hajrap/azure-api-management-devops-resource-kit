param region_primary string
param appServicePlanId string
param webApp_namePrimary string

resource webAppPrimaryResource 'Microsoft.Web/sites@2020-09-01' = {
  name: webApp_namePrimary
  location: region_primary
  kind: 'app'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${webApp_namePrimary}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${webApp_namePrimary}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: appServicePlanId
    httpsOnly: true
  }
}

output siteUrl string = webAppPrimaryResource.properties.hostNames[0]

resource webAppPrimaryConfigResource 'Microsoft.Web/sites/config@2020-09-01' = {
  name: '${webAppPrimaryResource.name}/web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$edupoint-dev-ae'
    azureStorageAccounts: {}
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: true
    minTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    PreWarmedInstanceCount: 0
  }
}

resource webAppPrimaryHostNameResource 'Microsoft.Web/sites/hostNameBindings@2020-09-01' = {
  name: '${webAppPrimaryResource.name}/${webApp_namePrimary}.azurewebsites.net'
  properties: {
    siteName: webApp_namePrimary
    hostNameType: 'Verified'
  }
}
