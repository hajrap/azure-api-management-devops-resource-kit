param funcApp_name string
param funcApp_id string
param keyVault_url string
param appIns_name string
param apiManagement_name string

resource service_apim_lxp_int_dev_ae_name_609cbf4d63f6809c34ec1ff1 'Microsoft.ApiManagement/service/api-version-sets@2018-06-01-preview' = {
  name: '${apiManagement_name}/609cbf4d63f6809c34ec1ff1'
  properties: {
    displayName: 'Example API'
    versioningScheme: 'Segment'
  }
}

resource service_apim_lxp_int_dev_ae_name_609cbfc45d18d2d3355533cd 'Microsoft.ApiManagement/service/api-version-sets@2018-06-01-preview' = {
  name: '${apiManagement_name}/609cbfc45d18d2d3355533cd'
  properties: {
    displayName: 'Health Check API'
    versioningScheme: 'Segment'
  }
}

resource Microsoft_ApiManagement_service_apiVersionSets_service_apim_lxp_int_dev_ae_name_609cbf4d63f6809c34ec1ff1 'Microsoft.ApiManagement/service/apiVersionSets@2021-01-01-preview' = {
  name: '${apiManagement_name}/609cbf4d63f6809c34ec1ff1'
  properties: {
    displayName: 'Example API'
    versioningScheme: 'Segment'
  }
}

resource Microsoft_ApiManagement_service_apiVersionSets_service_apim_lxp_int_dev_ae_name_609cbfc45d18d2d3355533cd 'Microsoft.ApiManagement/service/apiVersionSets@2021-01-01-preview' = {
  name: '${apiManagement_name}/609cbfc45d18d2d3355533cd'
  properties: {
    displayName: 'Health Check API'
    versioningScheme: 'Segment'
  }
}

resource service_apim_lxp_int_dev_ae_name_example 'Microsoft.ApiManagement/service/products@2021-01-01-preview' = {
  name: '${apiManagement_name}/example'
  properties: {
    displayName: 'Example'
    description: 'example of an api calling through to an azure function'
    subscriptionRequired: true
    approvalRequired: false
    state: 'published'
  }
}

resource service_apim_lxp_int_dev_ae_name_healthcheck 'Microsoft.ApiManagement/service/products@2021-01-01-preview' = {
  name: '${apiManagement_name}/healthcheck'
  properties: {
    displayName: 'HealthCheck'
    description: 'End to end health check.'
    subscriptionRequired: false
    state: 'published'
  }
}

resource service_apim_lxp_int_dev_ae_name_example_api 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${apiManagement_name}/example-api'
  properties: {
    displayName: 'Example API'
    apiRevision: '1'
    description: 'Import from Function App'
    subscriptionRequired: true
    path: 'example'
    protocols: [
      'https'
    ]
    isCurrent: true
    apiVersionSetId: Microsoft_ApiManagement_service_apiVersionSets_service_apim_lxp_int_dev_ae_name_609cbf4d63f6809c34ec1ff1.id
  }
}

resource service_apim_lxp_int_dev_ae_name_example_api_v1 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${apiManagement_name}/example-api-v1'
  properties: {
    displayName: 'Example API'
    apiRevision: '1'
    description: 'Import from Function App'
    subscriptionRequired: true
    path: 'example'
    protocols: [
      'https'
    ]
    isCurrent: true
    apiVersion: 'v1'
    apiVersionSetId: Microsoft_ApiManagement_service_apiVersionSets_service_apim_lxp_int_dev_ae_name_609cbf4d63f6809c34ec1ff1.id
  }
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${apiManagement_name}/healh-check-api'
  properties: {
    displayName: 'Healh Check API'
    apiRevision: '1'
    description: 'Import from Function App'
    subscriptionRequired: true
    path: 'healthcheck'
    protocols: [
      'https'
    ]
    isCurrent: true
    apiVersionSetId: Microsoft_ApiManagement_service_apiVersionSets_service_apim_lxp_int_dev_ae_name_609cbfc45d18d2d3355533cd.id
  }
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_v1 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${apiManagement_name}/healh-check-api-v1'
  properties: {
    displayName: 'Healh Check API'
    apiRevision: '1'
    description: 'Import from Function App'
    subscriptionRequired: true
    path: 'healthcheck'
    protocols: [
      'https'
    ]
    isCurrent: true
    apiVersion: 'v1'
    apiVersionSetId: Microsoft_ApiManagement_service_apiVersionSets_service_apim_lxp_int_dev_ae_name_609cbfc45d18d2d3355533cd.id
  }
}

resource service_apim_lxp_int_dev_ae_name_example_api_get_httpexample 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api.name}/get-httpexample'
  properties: {
    displayName: 'HttpExample'
    method: 'GET'
    urlTemplate: '/HttpExample'
    templateParameters: []
    responses: []
  }
}

resource service_apim_lxp_int_dev_ae_name_example_api_v1_get_httpexample 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api_v1.name}/get-httpexample'
  properties: {
    displayName: 'HttpExample'
    method: 'GET'
    urlTemplate: '/HttpExample'
    templateParameters: []
    responses: []
  }
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_get_httphealthcheck 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api.name}/get-httphealthcheck'
  properties: {
    displayName: 'HttpHealthCheck'
    method: 'GET'
    urlTemplate: '/HttpHealthCheck'
    templateParameters: []
    responses: []
  }
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_v1_get_httphealthcheck 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api_v1.name}/get-httphealthcheck'
  properties: {
    displayName: 'HttpHealthCheck'
    method: 'GET'
    urlTemplate: '/HttpHealthCheck'
    templateParameters: []
    responses: []
  }
}

resource service_apim_lxp_int_dev_ae_name_example_api_post_httpexample 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api.name}/post-httpexample'
  properties: {
    displayName: 'HttpExample'
    method: 'POST'
    urlTemplate: '/HttpExample'
    templateParameters: []
    responses: []
  }
}

resource service_apim_lxp_int_dev_ae_name_example_api_v1_post_httpexample 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api_v1.name}/post-httpexample'
  properties: {
    displayName: 'HttpExample'
    method: 'POST'
    urlTemplate: '/HttpExample'
    templateParameters: []
    responses: []
  }
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_post_httphealthcheck 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api.name}/post-httphealthcheck'
  properties: {
    displayName: 'HttpHealthCheck'
    method: 'POST'
    urlTemplate: '/HttpHealthCheck'
    templateParameters: []
    responses: []
  }
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_v1_post_httphealthcheck 'Microsoft.ApiManagement/service/apis/operations@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api_v1.name}/post-httphealthcheck'
  properties: {
    displayName: 'HttpHealthCheck'
    method: 'POST'
    urlTemplate: '/HttpHealthCheck'
    templateParameters: []
    responses: []
  }
}


resource service_apim_lxp_int_dev_ae_name_example_example_api 'Microsoft.ApiManagement/service/products/apis@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example.name}/example-api'
}

resource service_apim_lxp_int_dev_ae_name_example_example_api_v1 'Microsoft.ApiManagement/service/products/apis@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example.name}/example-api-v1'
}

resource service_apim_lxp_int_dev_ae_name_healthcheck_healh_check_api 'Microsoft.ApiManagement/service/products/apis@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healthcheck.name}/healh-check-api'
}

resource service_apim_lxp_int_dev_ae_name_healthcheck_healh_check_api_v1 'Microsoft.ApiManagement/service/products/apis@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healthcheck.name}/healh-check-api-v1'
}

resource service_apim_lxp_int_dev_ae_name_example_administrators 'Microsoft.ApiManagement/service/products/groups@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example.name}/administrators'
}

resource service_apim_lxp_int_dev_ae_name_healthcheck_administrators 'Microsoft.ApiManagement/service/products/groups@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healthcheck.name}/administrators'
}


// resource service_apim_lxp_int_dev_ae_name_rhollamby 'Microsoft.ApiManagement/service/subscriptions@2021-01-01-preview' = {
//   name: '${apiManagementResource.name}/rhollamby'
//   properties: {
//     ownerId: service_apim_lxp_int_dev_ae_name_rhollamby_dxc_com.id
//     scope: '${apiManagementResource.id}/apis'
//     displayName: 'Robert Hollamby'
//     state: 'active'
//     allowTracing: true
//   }
// }

resource service_apim_lxp_int_dev_ae_name_example_api_get_httpexample_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api_get_httpexample.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_example_api
  ]
}

resource service_apim_lxp_int_dev_ae_name_example_api_post_httpexample_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api_post_httpexample.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_example_api
  ]
}

resource service_apim_lxp_int_dev_ae_name_example_api_v1_get_httpexample_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api_v1_get_httpexample.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_example_api_v1
  ]
}

resource service_apim_lxp_int_dev_ae_name_example_api_v1_post_httpexample_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_example_api_v1_post_httpexample.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_example_api_v1
  ]
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_get_httphealthcheck_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api_get_httphealthcheck.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_healh_check_api
  ]
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_post_httphealthcheck_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api_post_httphealthcheck.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_healh_check_api
  ]
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_v1_get_httphealthcheck_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api_v1_get_httphealthcheck.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_healh_check_api_v1
  ]
}

resource service_apim_lxp_int_dev_ae_name_healh_check_api_v1_post_httphealthcheck_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2021-01-01-preview' = {
  name: '${service_apim_lxp_int_dev_ae_name_healh_check_api_v1_post_httphealthcheck.name}/policy'
  properties: {
    value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="${funcApp_name}" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_lxp_int_dev_ae_name_healh_check_api_v1
  ]
}
