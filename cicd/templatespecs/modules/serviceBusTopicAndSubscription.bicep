param serviceBus_name string 
param  serviceBusResource_topic_name string 
param serviceBusResource_topic_subscription_name string

param serviceBusResource_topic_subscription_maxDeliveryCount int

resource serviceBusResource 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' existing = {
  name: serviceBus_name
}

resource serviceBusResource_topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  parent: serviceBusResource
  name: serviceBusResource_topic_name
  properties: {
    maxMessageSizeInKilobytes: 1024
    defaultMessageTimeToLive: 'P14D'
    maxSizeInMegabytes: 1024
    requiresDuplicateDetection: false
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    enableBatchedOperations: true
    status: 'Active'
    supportOrdering: true
    autoDeleteOnIdle: 'P10675199DT2H48M5.4775807S'
    enablePartitioning: false
    enableExpress: false
  }
}


resource serviceBusResource_topic_subscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-06-01-preview' = {
  parent: serviceBusResource_topic
  name: serviceBusResource_topic_subscription_name
  properties: {
    isClientAffine: false
    lockDuration: 'PT30S'
    requiresSession: false
    defaultMessageTimeToLive: 'P14D'
    deadLetteringOnMessageExpiration: true
    deadLetteringOnFilterEvaluationExceptions: false
    maxDeliveryCount: serviceBusResource_topic_subscription_maxDeliveryCount
    status: 'Active'
    enableBatchedOperations: true
    autoDeleteOnIdle: 'P10675198DT2H48M5S'
  }
}

