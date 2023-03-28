targetScope = 'subscription'

param environment string
// DEV PARAMS USED AS DEFAULT VALUES
param resourceGroup_namePrimary string
param region_primary string
// Azure Monitor
param appInsights_namePrimary string
param logAnalatics_namePrimary string
param logAnalatics_retentionDays int
// Azure Monitor Notification
param emailActionGroup_name string
param emailActionGroup_displayName string
param emailActionGroup_enabled bool
param emalActionGroup_emails array
// Storage Account
param storageAccount_namePrimary string
param storageAccount_typePrimary string
// App Service Plan
param appServicePlan_namePrimary string //DEPRECATED
param appServicePlan_sku object         //DEPRECATED
param appServicePlan_properties object  //DEPRECATED
// Function App
param funcApp_namePrimary string              //DEPRECATED
param funcApp_detailedHealthCheckReports bool //DEPRECATED
param funcApp_excludeHealthyReports bool      //DEPRECATED
// Change these to match the actual bootstrap keyvault instance used by DevOps pipelines (assumes same subscription... for now)
param kvBootstrap_name string
param kvBootstrap_rgName string
param kvBootstrap_subscriptionId string
// **** DON'T CHANGE THIS IN PARAMS FILE ****
param keyvault_secretReaderRoleId string
// **** DON'T CHANGE THIS IN PARAMS FILE ****
param keyvault_secretOfficerRoleId string
// KeyVault
param keyvault_namePrimary string
// KeyVault privateEndpoint
param keyvault_privateEndpoint_name string
// storageAccount privateEndpoint         //DEPRECATED
param storageAccount_privateEndpoint_name string
// Keyvalut secrets
// param keyvault_testSecretName string   //DEPRECATED
// param keyvault_testSecretValue string  //DEPRECATED
param keyvault_expirySeconds int
param keyvault_apimSecrets_nonEnvSpecific array
param keyvault_apimSecrets_envSpecific array
param ssl_certificate_name string
param deploy_public_cert bool
param public_ssl_certificate_name string
param keyvault_appInsKeyName string
param keyvault_funcAppHostKey string      //DEPRECATED
param keyvault_skuPropertiesPrimary object
param keyvault_retentionDays int
// APIM
param apiManagement_namePrimary string
param apiManagement_skuPropertiesPrimary object 
param apiManagement_virtualNetworkType string
param key_certificate_SWCRootCA_base64 string
param apiManagement_gatewayCustomDomainName string
param apiManagement_gatewayPublicCustomDomainName string
param apiManagement_developerPortalCustomDomainName string
param apiManagement_managementCustomDomainName string
param key_certificate_SWCIssuingCA1_base64 string
param apiManagement_publisherEmail string
param apiManagement_publisherName string
param apiManagement_customProperties object
// security related params TODO: reorganise later
param apiManagement_vnetName string
param apiManagement_vnetRGName string
param apiManagement_snetName string
param dcp_logAnalytics_subscriptionId string
param dcp_logAnalytics_rgName string
param dcp_logAnalytics_workspaceName string
param keyVault_diagnosticSettingName string
param deploy_funcApp bool
param privateEndpoints_snetName string
param apiManagement_diagnosticSettingName string
param storageAccount_cmkKeyName string
param apiManagement_productsAndsubscriptions array
// param keyvault_cryptoServiceEncryptionRoleId string // value should be e147488a-f6f5-4113-8e2d-b22465e65bf6
param keyvault_cryptoServiceEncryptionUserRoleId string // value should be e147488a-f6f5-4113-8e2d-b22465e65bf6
param jwtTokenKeyEValue string
param jwtTokenKeyNValue string
param cdcLoginSubscription string
param cdcLoginResourceGroup string
param cdcLoginFunctionName string
param cdcLoginBackendUrl string
param cdcSbIngestSubscription string
param cdcSbIngestResourceGroup string
param cdcSbIngestFunctionName string
param cdcSbIngestBackendUrl string

param sapClientValue string
param IotSewerSigAllSites string
param IotSewerSigCurrentAlarms string
param IotSewerSigEventHistory string
param IotSewerSigStateHistory string
param IotSewerSigTelemetryHistory string
param IotSewerSigTelemetryWithinBounds string
param IotSewerSigUpdateAlarm string
param IotSewerSigWetWeatherRegions string
param IotSewerSigTelemetryForSite string
param IotSewerSigAllSitesForBounds string
param bpointBillerCode string
param bpointBackendHost string
param paypalOrdersUrl string
param paypalTokenUrl string
param waterfixDB string

//Service Bus
param serviceBus_namespaces_name string
param serviceBus_sku object
param privateEndpoints_pe_sb_externalid string
param serviceBusResource_privateEndpointConnections_name string 

param serviceBusResource_topic_subscription_maxDeliveryCount int
param serviceBus_privateEndpoint_name string

param ServiceBusTopicAndSubscription array
param deploy_serviceBus bool

module emailActionGroupModule './modules/emailActionGroup.bicep' = {
  name: 'emailActionGroupDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    emailActionGroup_name: emailActionGroup_name
    emailActionGroup_displayName: emailActionGroup_displayName
    emailActionGroup_enabled: emailActionGroup_enabled
    emalActionGroup_emails: emalActionGroup_emails
  }
}

resource kvBootstrap 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: kvBootstrap_name
  scope: resourceGroup(kvBootstrap_subscriptionId, kvBootstrap_rgName)
}

resource apiManagementSubnetResource 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' existing = {
  name: '${apiManagement_vnetName}/${apiManagement_snetName}'
  scope: resourceGroup(apiManagement_vnetRGName)
}

resource privateEndpointsSubnetResource 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' existing = {
  name: '${apiManagement_vnetName}/${privateEndpoints_snetName}'
  scope: resourceGroup(apiManagement_vnetRGName)
}

// resource dcpLogAnalyticsWorkspaceResource 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
//   name: dcp_logAnalytics_workspaceName
//   scope: resourceGroup(dcp_logAnalytics_subscriptionId, dcp_logAnalytics_rgName)
// }

module apiManagementBaseModule './modules/apiManagementBase.bicep' = {
  name: 'apiManagementBaseDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    apiManagement_name: apiManagement_namePrimary
    region: region_primary
    apiManagement_sku: apiManagement_skuPropertiesPrimary
    apiManagement_virtualNetworkType: apiManagement_virtualNetworkType
    certificate_SWCRootCA_base64: kvBootstrap.getSecret('${key_certificate_SWCRootCA_base64}')
    certificate_SWCIssuingCA1_base64: kvBootstrap.getSecret('${key_certificate_SWCIssuingCA1_base64}')
    apiManagement_publisherEmail: apiManagement_publisherEmail
    apiManagement_publisherName: apiManagement_publisherName
    apiManagement_customProperties: apiManagement_customProperties
    vnet_snetId: apiManagementSubnetResource.id 
    apiManagement_gatewayCustomDomainName: apiManagement_gatewayCustomDomainName
    apiManagement_gatewayPublicCustomDomainName: apiManagement_gatewayPublicCustomDomainName
    ssl_certificate_base64: kvBootstrap.getSecret('${ssl_certificate_name}-base64')
    ssl_certificate_password: kvBootstrap.getSecret('${ssl_certificate_name}-password')
    deploy_public_cert: deploy_public_cert
    public_ssl_certificate_base64: kvBootstrap.getSecret('${public_ssl_certificate_name}-base64')
    public_ssl_certificate_password: kvBootstrap.getSecret('${public_ssl_certificate_name}-password')
    apiManagement_developerPortalCustomDomainName: apiManagement_developerPortalCustomDomainName
    apiManagement_managementCustomDomainName: apiManagement_managementCustomDomainName
  }
}

module keyvaultPrimaryModule './modules/keyvault.bicep' = {
  name: 'keyvaultPrimaryDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    region: region_primary
    keyvault_name: keyvault_namePrimary
    keyvault_skuProperties: keyvault_skuPropertiesPrimary
    keyvault_retentionDays: keyvault_retentionDays
    // apim_identity: apiManagementBaseModule.outputs.identity
    // sa_identity: storageAccountPrimaryModule.outputs.identity
  }
}

module storageAccountPrimaryModule './modules/storageAccount.bicep' = {
  name: 'storageAccountPrimaryDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    storageAccount_name: storageAccount_namePrimary
    storageAccount_type: storageAccount_typePrimary
    region: region_primary
    vnet_snetId: apiManagementSubnetResource.id 
  }
}

module storageAccountPrivateEndpointModule './modules/privateEndpoint.bicep' = {
  name: 'storageAccountPrivateEndpointDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params:{
    privateEndpoints_name: storageAccount_privateEndpoint_name
    privateLinkService_id: storageAccountPrimaryModule.outputs.storageAccountId
    virtualNetworks_subnet_id: privateEndpointsSubnetResource.id
    privateDnsZones_name: 'privatelink.blob.core.windows.net'
    groupId: 'blob'
  }
}

module appInsightsPrimaryModule './modules/appInsights.bicep' = {
  name: 'appInsightsPrimaryDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    region: region_primary
    appInsights_name: appInsights_namePrimary
    logAnalaticsResourceID: logAnalyticsPrimaryModule.outputs.logAnalyticsId
    //appInsights_30DayPurge: appInsights_30DayPurge
  }
}

module logAnalyticsPrimaryModule './modules/logAnalytics.bicep' = {
  name: 'logAnalyticsPrimaryDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    logAnalatics_name: logAnalatics_namePrimary
    logAnalatics_retentionDays: logAnalatics_retentionDays
    region: region_primary
  }
}

module keyvaultCMKKeyModule './modules/keyvaultKey.bicep' = {
  name: 'keyvaultCMKKeyDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    keyvault_name: keyvaultPrimaryModule.outputs.keyvaultResourceName
    keyName: storageAccount_cmkKeyName
    expirySeconds: keyvault_expirySeconds
  }
}

module keyvaultStorageAccountCryptoServiceEncryptionUserRoleModule './modules/roleAssignment.bicep' = {
  name: 'keyvaultStorageAccountCryptoServiceEncryptionUserRoleDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    roleGuid: keyvault_cryptoServiceEncryptionUserRoleId
    resourceId: storageAccountPrimaryModule.outputs.storageAccountId
    apiVersion: '2019-06-01'
  }
}

//TODO figure out why this module is hanging in QA
module keyvaultApimReaderRoleModule './modules/roleAssignment.bicep' = if (environment != 'preprod' && environment != 'prod') {
  name: 'keyvaultApimReaderRoleDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    roleGuid: keyvault_secretReaderRoleId
    resourceId: apiManagementBaseModule.outputs.resourceId
    apiVersion: '2021-01-01-preview'
  }
}

module keyvaultApimOfficerRoleModule './modules/roleAssignment.bicep' = if (environment != 'preprod' && environment != 'prod') {
  name: 'keyvaultApimOfficerRoleDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    roleGuid: keyvault_secretOfficerRoleId
    resourceId: apiManagementBaseModule.outputs.resourceId
    apiVersion: '2021-01-01-preview'
  }
}

module keyvaultApimNonEnvSpecificSecretsModule './modules/keyvaultSecret.bicep' = [for secret in keyvault_apimSecrets_nonEnvSpecific: {
  name: 'keyvault${secret}SecretDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    keyvault_name: keyvaultPrimaryModule.outputs.keyvaultResourceName
    secretName: secret
    secretValue: kvBootstrap.getSecret(secret)
    expirySeconds: keyvault_expirySeconds
  }
}]

module keyvaultApimEnvSpecificSecretsModule './modules/keyvaultSecret.bicep' = [for secret in keyvault_apimSecrets_envSpecific: {
  name: 'keyvault${secret}SecretDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    keyvault_name: keyvaultPrimaryModule.outputs.keyvaultResourceName
    secretName: secret
    secretValue: kvBootstrap.getSecret('${secret}-${environment}')
    expirySeconds: keyvault_expirySeconds
  }
}]

module keyvaultPrivateEndpointModule './modules/privateEndpoint.bicep' = {
  name: 'keyvaultPrivateEndpointDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params:{
    privateEndpoints_name: keyvault_privateEndpoint_name
    privateLinkService_id: keyvaultPrimaryModule.outputs.keyvaultResourceId
    virtualNetworks_subnet_id: privateEndpointsSubnetResource.id
    privateDnsZones_name: 'privatelink.vaultcore.azure.net'
    groupId: 'vault'
  }
}

module keyvaultAppInsKeySecretModule './modules/keyvaultSecret.bicep' = {
  name: 'keyvaultAppInsKeySecretDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    keyvault_name: keyvaultPrimaryModule.outputs.keyvaultResourceName
    secretName: keyvault_appInsKeyName
    secretValue: appInsightsPrimaryModule.outputs.APPINSIGHTS_INSTRUMENTATIONKEY
    expirySeconds: keyvault_expirySeconds
  }
}

module apiManagementAppInsNameValueModule './modules/apiManagementKeyVaultNameValue.bicep' = {
  name: 'apiManagementAppInsNameValueDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    apiManagement_name: apiManagementBaseModule.outputs.name
    keyVault_url: keyvaultPrimaryModule.outputs.keyvaultUri
    keyVault_secretName: keyvault_appInsKeyName
  }
  dependsOn: [
    keyvaultApimReaderRoleModule
    keyvaultApimOfficerRoleModule
    keyvaultAppInsKeySecretModule
  ]
}

module apiManagementLoggerModule './modules/apiManagementLogger.bicep' = {
  name: 'apiManagementLoggerDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    apiManagement_name: apiManagementBaseModule.outputs.name
    appInsights_name: appInsightsPrimaryModule.name
    appInsights_key: '{{${keyvault_appInsKeyName}}}'
  }
  dependsOn: [
    apiManagementAppInsNameValueModule
  ]
}

module apiManagementLogDiagnosticModule './modules/apiManagementLogDiagonostics.bicep' = {
  name: 'apiManagementLogDiagnosticDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    apiManagement_name: apiManagementBaseModule.outputs.name
    loggers_resourceId: apiManagementLoggerModule.outputs.loggers_resourceId
  }
}

// module apiManagementDiagnosticSettingModule './modules/apimManagementDiagnosticSetting.bicep' = {
//   name: 'apiManagementDiagnosticSettingDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     settingName: apiManagement_diagnosticSettingName
//     apiManagementName: apiManagement_namePrimary
//     storageAccountId: storageAccountPrimaryModule.outputs.storageAccountId
//     workspaceId: dcpLogAnalyticsWorkspaceResource.id
//    }
//  }

 module apiManagementProductsAndSubscriptionsModule './modules/apiManagementProductsAndSubscriptions.bicep' = [for object in apiManagement_productsAndsubscriptions: {
   name: 'Product${object.product_name}And${object.subcription_name}Deploy'
   scope: resourceGroup(resourceGroup_namePrimary)
   params: {
     apiManagement_name : apiManagementBaseModule.outputs.name
     product_name: object.product_name
     product_display_name: object.product_display_name
     product_description: object.product_description
     product_state: object.product_state
     subscription_name: object.subcription_name
     subscription_display_name: object.subcription_display_name
     subscription_state: object.subcription_state
   }
 }]

module serviceBusModule './modules/serviceBus.bicep' = if (deploy_serviceBus) {
  name: 'serviceBusDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    serviceBus_namespaces_name: serviceBus_namespaces_name
    region : region_primary
    serviceBus_sku: serviceBus_sku
    privateEndpoints_pe_sb_externalid: privateEndpoints_pe_sb_externalid
   }
 }

 module serviceBusTopicAndSubscriptionModule './modules/serviceBusTopicAndSubscription.bicep' = [for object in ServiceBusTopicAndSubscription: if (deploy_serviceBus) {
  name: 'serviceBus${object.topic_name}TopicDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params: {
    serviceBus_name: serviceBus_namespaces_name
    serviceBusResource_topic_name: object.topic_name
    serviceBusResource_topic_subscription_name: object.subscription_name
    serviceBusResource_topic_subscription_maxDeliveryCount: serviceBusResource_topic_subscription_maxDeliveryCount
  }
}]

 module serviceBusPrivateEndpointModule './modules/privateEndpoint.bicep' = if (deploy_serviceBus) {
  name: 'serviceBusPrivateEndpointDeploy'
  scope: resourceGroup(resourceGroup_namePrimary)
  params:{
    privateEndpoints_name: serviceBus_privateEndpoint_name
    privateLinkService_id: serviceBusModule.outputs.serviceBusResourceId
    virtualNetworks_subnet_id: privateEndpointsSubnetResource.id
    privateDnsZones_name: 'privatelink.vaultcore.azure.net'
    groupId: 'namespace'
  }
}

//DEPRECATED
// module appServicePlanPrimaryModule './modules/appServicePlan.bicep' = if (deploy_funcApp) {
//   name: 'appServicePlanPrimaryDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     appServicePlan_name: appServicePlan_namePrimary
//     appServicePlan_sku: appServicePlan_sku
//     appServicePlan_properties: appServicePlan_properties
//     region: region_primary
//   }
// }

//DEPRECATED
// module funcAppPrimaryModule './modules/funcApp.bicep' = if (deploy_funcApp) {
//   name: 'funcAppPrimaryDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     appServicePlanId: appServicePlanPrimaryModule.outputs.appServicePlanId
//     funcApp_name: funcApp_namePrimary
//     region: region_primary
//     appInsights_key: appInsightsPrimaryModule.outputs.APPINSIGHTS_INSTRUMENTATIONKEY
//     storageAccount_name: storageAccountPrimaryModule.outputs.storageAccountResourceName
//     storageAccount_id: storageAccountPrimaryModule.outputs.storageAccountId
//     storageAccount_apiVersion: storageAccountPrimaryModule.outputs.storageAccountApiVersion
//     keyVaultUri: keyvaultPrimaryModule.outputs.keyvaultUri
//     keyVaultTestSecretName: keyvault_testSecretName
//     exampleParamOne: funcApp_paramOne
//     exampleParamTwo: funcApp_paramTwo
//     detailedHealthCheckReports: funcApp_detailedHealthCheckReports
//     excludeHealthyReports: funcApp_excludeHealthyReports
//   }
// }

//DEPRECATED
// module keyvaultFuncReaderRoleModule './modules/roleAssignment.bicep' = if (deploy_funcApp) {
//   name: 'keyvaultFuncReaderRoleDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     roleGuid: keyvault_secretReaderRoleId
//     resourceId: funcAppPrimaryModule.outputs.resourceId
//     apiVersion: '2018-02-01'
//   }
// }

//DREPRECATED
// module keyvaultTestSecretModule './modules/keyvaultSecret.bicep' = if (deploy_funcApp) {
//   name: 'keyvaultTestSecretDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     keyvault_name: keyvaultPrimaryModule.outputs.keyvaultResourceName
//     secretName: keyvault_testSecretName
//     secretValue: keyvault_testSecretValue
//     expirySeconds: keyvault_expirySeconds
//   }
// }

//DEPRECATED
// module keyvaultHealthFuncApiKeySecretModule './modules/keyvaultSecret.bicep' = if (deploy_funcApp) {
//   name: 'keyvaultHealthFuncApiKeySecretDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     keyvault_name: keyvaultPrimaryModule.outputs.keyvaultResourceName
//     secretName: keyvault_funcAppHostKey
//     secretValue: funcAppPrimaryModule.outputs.hostKey
//     expirySeconds: keyvault_expirySeconds
//   }
// }

//DREPRECATED
// module apiManagementFuncHostKeyNameValueModule './modules/apiManagementKeyVaultNameValue.bicep' = if (deploy_funcApp) {
//   name: 'apiManagementFuncHostKeyNameValueDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     apiManagement_name: apiManagementBaseModule.outputs.name
//     keyVault_url: keyvaultPrimaryModule.outputs.keyvaultUri
//     keyVault_secretName: keyvault_funcAppHostKey
//   }
// }

//DREPRECATED
// module apiManagementFuncBackendModule './modules/apiManagementFuncBackend.bicep' = if (deploy_funcApp) {
//   name: 'apiManagementFuncBackendDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     apiManagement_name: apiManagementBaseModule.outputs.name
//     funcApp_namePrimary: funcApp_namePrimary
//     keyvault_funcAppHostKey: '{{${keyvault_funcAppHostKey}}}'
//   }
// }

//DREPRECATED
// module apiManagementModule './modules/apiManagement.bicep' = if (deploy_funcApp) {
//   name: 'apiManagementDeploy'
//   scope: resourceGroup(resourceGroup_namePrimary)
//   params: {
//     apiManagement_name: apiManagementBaseModule.outputs.name
//     funcApp_name: funcApp_namePrimary
//     funcApp_id:  funcAppPrimaryModule.outputs.resourceId
//     keyVault_url: keyvaultPrimaryModule.outputs.keyvaultUri
//     appIns_name: appInsightsPrimaryModule.name
//   }
// }
