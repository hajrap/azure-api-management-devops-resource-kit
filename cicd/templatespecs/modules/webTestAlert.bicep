@minLength(1)
@description('Name of the alert')
param metricAlert_name string

@description('Description of alert')
param metricAlert_description string = 'This is a metric alert'

@allowed([
  0
  1
  2
  3
  4
])
@description('Severity of alert {0,1,2,3,4}')
param metricAlert_severity int = 3

@description('Specifies whether the alert is enabled')
param metricAlert_isEnabled bool = true

@minLength(1)
@description('Full Resource ID of the resource emitting the metric that will be used for the comparison. For example /subscriptions/00000000-0000-0000-0000-0000-00000000/resourceGroups/ResourceGroupName/providers/Microsoft.compute/virtualMachines/VM_xyz')
param metricAlert_sourceResourceId string

@minLength(1)
@description('Full Resource ID of the web test causing the alert to be created by App Insights')
param metricAlert_webTestResourceId string

@description('number of failed locations')
param metricAlert_webTestFailedLocationCount int

@allowed([
  'PT1M'
  'PT5M'
  'PT15M'
  'PT30M'
  'PT1H'
])
@description('Period of time used to monitor alert activity based on the threshold. Must be between five minutes and one hour. ISO 8601 duration format.')
param metricAlert_windowSize string = 'PT1M'

@allowed([
  'PT1M'
  'PT5M'
  'PT15M'
  'PT30M'
  'PT1H'
])
@description('how often the metric alert is evaluated represented in ISO 8601 duration format')
param metricAlert_evaluationFrequency string = 'PT1M'

@description('The ID of the action group that is triggered when the alert is activated or deactivated')
param metricAlert_actionGroupId string

resource webTestAlertResource 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: metricAlert_name
  location: 'global'
  tags: {}
  properties: {
    description: metricAlert_description
    severity: metricAlert_severity
    enabled: metricAlert_isEnabled
    scopes: [
      metricAlert_sourceResourceId
      metricAlert_webTestResourceId
    ]
    evaluationFrequency: metricAlert_evaluationFrequency
    windowSize: metricAlert_windowSize
    criteria: {
      webTestId: metricAlert_webTestResourceId
      componentId: metricAlert_sourceResourceId
      failedLocationCount: metricAlert_webTestFailedLocationCount
      'odata.type': 'Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria'
    }
    actions: [
      {
        actionGroupId: metricAlert_actionGroupId
      }
    ]
  }
}
