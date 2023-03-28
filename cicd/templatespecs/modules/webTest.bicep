@description('The name of the Application Insights WebTest resource.')
param webTest_name string

@description('Interval in seconds between test runs for this WebTest. Default value is 300.')
param webTest_propFrequency int = 300

@description('Seconds until this WebTest will timeout and fail. Default value is 30')
param webTest_propTimeout int = 120

@description('Is the test actively being monitored.')
param webTest_propEnabled bool = true

@description('User defined description for this WebTest.')
param webTest_propRetryEnabled bool = true

@description('The kind of web test this is, valid choices are ping, multistep, basic, and standard. - ping, multistep, basic, standard')
param webTest_propKind string = 'ping'

@description('User defined name if this WebTest.')
param webTest_propName string

@description('Resource location')
param region string

@description('A list of where to physically run the tests from to give global coverage for accessibility of your application.')
param webTest_propLocations array

param webTest_xmlConfig string

//@description('Content to look for in the return of the WebTest.')
//param webTest_propContentMatch string

//@description('Url location to test.')
//param webTest_propRequestUrl string

//@description('Validate that the WebTest returns the http status code provided.')
//param webTest_propExpectedHttpStatusCode int = 200

@description('Validate that the WebTest returns the http status code provided.')
param appInsights_resourceId string

resource webTestResource 'Microsoft.Insights/webtests@2018-05-01-preview' = {
  name: webTest_name
  location: region
  tags: {
    'hidden-link:${appInsights_resourceId}': 'Resource'
  }
  properties: {
    SyntheticMonitorId: webTest_name
    Name: webTest_propName
    Enabled: webTest_propEnabled
    Frequency: webTest_propFrequency
    Timeout: webTest_propTimeout
    Kind: webTest_propKind
    RetryEnabled: webTest_propRetryEnabled
    Locations: webTest_propLocations
    Configuration: {
      WebTest: webTest_xmlConfig
    }
    // Request: {
    //   RequestUrl: webTest_propRequestUrl
    // }
    // ContentValidation: {
    //   ContentMatch: webTest_propContentMatch
    //   IgnoreCase: true
    //   PassIfTextFound: true
    // }
    // SSLCheck: true
    // ExpectedHttpStatusCode: webTest_propExpectedHttpStatusCode
  }
}

output webTestId string = webTestResource.id
