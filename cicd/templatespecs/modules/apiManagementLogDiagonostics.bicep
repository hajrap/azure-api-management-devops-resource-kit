param apiManagement_name string
param loggers_resourceId string

resource apiManagementBaseResource 'Microsoft.ApiManagement/service@2021-01-01-preview' existing = {
  name: apiManagement_name
}

resource apiManagementResource_applicationinsights 'Microsoft.ApiManagement/service/diagnostics@2021-01-01-preview' = {
  parent: apiManagementBaseResource
  name: 'applicationinsights'
  properties: {
    alwaysLog: 'allErrors'
    httpCorrelationProtocol: 'Legacy'
    verbosity: 'information'
    logClientIp: true
    loggerId: loggers_resourceId
    sampling: {
      samplingType: 'fixed'
      percentage: 100
    }
    frontend: {
      request: {
        headers: [
          'TransactionContextID'
          'ApplicationID'
          'UserID'
          'Version'
        ]
        body: {
          bytes: 8192
        }
      }
      response: {
        headers: []
        body: {
          bytes: 8192
        }
      }
    }
    backend: {
      request: {
        headers: []
        body: {
          bytes: 8192
        }
      }
      response: {
        headers: []
        body: {
          bytes: 8192
        }
      }
    }
  }
}

