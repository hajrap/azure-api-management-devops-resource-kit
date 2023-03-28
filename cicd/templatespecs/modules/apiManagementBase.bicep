@description('Resource location')
param region string

@description('The name of the Application management resource.')
param apiManagement_name string

@description('The sku of the Application management resource.')
param apiManagement_sku object

param apiManagement_virtualNetworkType string

@secure()
param certificate_SWCRootCA_base64 string
@secure()
param certificate_SWCIssuingCA1_base64 string

param apiManagement_publisherEmail string
param apiManagement_publisherName string
param apiManagement_customProperties object

param vnet_snetId string

param apiManagement_gatewayCustomDomainName string
param apiManagement_gatewayPublicCustomDomainName string

@secure()
param ssl_certificate_base64 string
@secure()
param ssl_certificate_password string

param deploy_public_cert bool
@secure()
param public_ssl_certificate_base64 string
@secure()
param public_ssl_certificate_password string
param apiManagement_developerPortalCustomDomainName string
param apiManagement_managementCustomDomainName string

resource apiManagementBaseResource 'Microsoft.ApiManagement/service@2021-01-01-preview' = {
  name: apiManagement_name
  location: region
  sku: apiManagement_sku
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    virtualNetworkType: apiManagement_virtualNetworkType
    virtualNetworkConfiguration: {
      subnetResourceId: vnet_snetId
    }
    certificates: [
      {
        encodedCertificate: certificate_SWCRootCA_base64
        certificatePassword: ''
        storeName: 'Root'
      }
      {
        encodedCertificate: certificate_SWCIssuingCA1_base64
        certificatePassword: ''
        storeName: 'CertificateAuthority'
      }
    ]
    hostnameConfigurations: ((deploy_public_cert) ? [
      {
        type: 'Proxy'
        hostName: apiManagement_gatewayCustomDomainName
        negotiateClientCertificate: false
        defaultSslBinding: true
        certificateSource: 'Custom'
        encodedCertificate: ssl_certificate_base64
        certificatePassword: ssl_certificate_password
      }
      {
        type: 'DeveloperPortal'
        hostName: apiManagement_developerPortalCustomDomainName
        negotiateClientCertificate: false
        defaultSslBinding: false
        certificateSource: 'Custom'
        encodedCertificate: ssl_certificate_base64
        certificatePassword: ssl_certificate_password
      }
      {
        type: 'Management'
        hostName: apiManagement_managementCustomDomainName
        negotiateClientCertificate: false
        defaultSslBinding: false
        certificateSource: 'Custom'
        encodedCertificate: ssl_certificate_base64
        certificatePassword: ssl_certificate_password
      }
      {
        type: 'Proxy'
        hostName: apiManagement_gatewayPublicCustomDomainName
        negotiateClientCertificate: false
        defaultSslBinding: false
        certificateSource: 'Custom'
        encodedCertificate: public_ssl_certificate_base64
        certificatePassword: public_ssl_certificate_password
      }
    ] : [
      {
        type: 'Proxy'
        hostName: apiManagement_gatewayCustomDomainName
        negotiateClientCertificate: false
        defaultSslBinding: true
        certificateSource: 'Custom'
        encodedCertificate: ssl_certificate_base64
        certificatePassword: ssl_certificate_password
      }
      {
        type: 'DeveloperPortal'
        hostName: apiManagement_developerPortalCustomDomainName
        negotiateClientCertificate: false
        defaultSslBinding: false
        certificateSource: 'Custom'
        encodedCertificate: ssl_certificate_base64
        certificatePassword: ssl_certificate_password
      }
      {
        type: 'Management'
        hostName: apiManagement_managementCustomDomainName
        negotiateClientCertificate: false
        defaultSslBinding: false
        certificateSource: 'Custom'
        encodedCertificate: ssl_certificate_base64
        certificatePassword: ssl_certificate_password
      }
    ])
    publisherEmail: apiManagement_publisherEmail
    publisherName: apiManagement_publisherName
    customProperties: apiManagement_customProperties
  }
}

output identity object = apiManagementBaseResource.identity
output resourceId string = apiManagementBaseResource.id
output name string = apiManagementBaseResource.name
