# Contents

- [Contents](#contents)
- [Background info](#background-info)
- [Installation](#installation)
  - [New environment installation](#new-environment-installation)
  - [Azure DevOps configuration](#azure-devops-configuration)
- [Deployment Diagram](#deployment-diagram)
- [APIM infrastructure](#apim-infrastructure)
- [DNS entries](#dns-entries)
- [APIs](#apis)
  - [API publishing log](#api-publishing-log)
  - [API release log](#api-release-log)
  - [API backend service URLs](#api-backend-service-urls)
  - [APIM named value pairs](#apim-named-value-pairs)
  - [KeyVault secrets](#keyvault-secrets)
  - [KeyVault keys](#keyvault-keys)
- [DevOps pipelines and GitFlow branching strategy](#devops-pipelines-and-gitflow-branching-strategy)
- [DevOps pipelines artefacts](#devops-pipelines-artefacts)
- [DevOps process](#devops-process)
  - [GitFlow branching strategy](#gitflow-branching-strategy)
  - [How to publish an API using a GitFlow feature branch](#how-to-publish-an-api-using-a-gitflow-feature-branch)
    - [How to merge extracted APIM infrastructure changes](#how-to-merge-extracted-apim-infrastructure-changes)

# Background info

1. DCP solution 
    1. Blueprint document
    2. Solution visio diagram
2. Integration Solution Design (ISD)
# Installation

## New environment installation

1. Confirm prerequisites
    1. Azure subscription name
    2. Service connection from Azure DevOps to taregt Azure subscription
    3. APIM VNET and subnet
    4. DCP Hub Log Analytics workspace
2. Create and populate parameter files
    1. template params json
    2. api environment params json
    3. Postman environment json
3. Extend pipeline yml
    1. For dev environments...
    2. For release environments...
4. Create pipeline
    1. For dev environments...
    2. For other environments...
5. Execute pipelines
    1. Deploy infrastructure...
    2. Deploy APIs...

## Azure DevOps configuration

| Parameter     | Value                                            |
| ------------- | ------------------------------------------------ |
| Organisation  | https://dev.azure.com/SWDCP/
| Project       | https://dev.azure.com/SWDCP/DCP
| Boards        | https://dev.azure.com/DXCEclipsePS/DCP%20Implementation
| Code          | https://dev.azure.com/SWDCP/DCP/_git/SW-DCP-APIM
| Tests         | [cicd\tests](cicd\tests)
| Pipelines     | *see [DevOps pipelines](#devops-pipelines) section*

# Deployment Diagram

![Deployment_R1](/doc/Deployment_R1.png)

# APIM infrastructure

<<<<<<< HEAD
| Parameter             | Dev-00 | Dev | QA | PrePROD | PROD |
| --------------------- | ------ | --- | -- | ------- | ----- |
| **APIM service name** | apim-corenonprod01-integration-00 | apim-corenonprod01-integration-01 | apim-corenonprod01-integration-02 | 
| **APIM gateway hostname** | https://apim-corenonprod01-integration-00.azure-api.net | https://azure-apidev.swcdev | https://azure-apiqa1.swcsit
| **Resource group**    | rg-corenonprod01-integration-00 | rg-corenonprod01-integration-01 | rg-corenonprod01-integration-02 | rg-coreprod01-preprod-integration-03 | rg-coreprod01-prod-integration-04
=======
| Parameter             | Dev-00 | Dev | QA | PrePROD | PPROD |
| --------------------- | --------------------------------- | --------------------------------- | --------------------------------- | ------------------------------ | ------------------------------ |
| **APIM service name** | apim-corenonprod01-integration-00 | apim-corenonprod01-integration-01 | apim-corenonprod01-integration-02 | apim-coreprod01-integration-03 | apim-coreprod01-integration-04
| Parameter                 | Dev-00                            | Dev                               | QA                                | PrePROD                        | PROD                           |
| ------------------------- | --------------------------------- | --------------------------------- | --------------------------------- | ------------------------------ | ------------------------------ |
| **APIM service name**     | apim-corenonprod01-integration-00 | apim-corenonprod01-integration-01 | apim-corenonprod01-integration-02 | apim-coreprod01-integration-03 | apim-coreprod01-integration-04
| Purpose                   | For use by APIM integraiton team to use Azure Portal UI to manually configure | DevOps pipeline deployed DEV | DevOps pipeline deployed QA (SIT) | DevOps pipeline deployed PrePROD | DevOps pipeline deployed PROD
| Azure Portal access       | Yes                               | Yes (but only from bastion VM)    | 
| Deployments               | Azure Portal, Azue DevOps cloud   | Azure DevOps Cloud
| **Frontend connectivity** |
| Info                      | Direct connectivity to APIM       | Connect to APIM via DCP Hub App Gateway and Master Hub FW | Connect to APIM via DCP Hub App Gateway and Master Hub FW | Connect to APIM via DCP Hub App Gateway and Master Hub FW | Connect to APIM via DCP Hub App Gateway and Master Hub FW
| **Backend connectivity**  |
| Info                      | No connectivity to backend systems other than publicly internet accessible | Full secure connectivity to backend systems via DCP Hub and Master Hub routes |
| 3rd party APIs            | Yes (via open internet)           | Yes (via Bluecoat proxy)          | Yes (via Bluecoat proxy)          | Yes (via Bluecoat proxy)       | Yes (via Bluecoat proxy)
| AEM Assets API            | Temporary*                        | Yes                               | Yes                               | Yes                            | Yes
| Axway APIs                | Temporary*                        | Yes (via Netscaler)               | Yes (via Netscaler)               | Yes (via Netscaler)            | Yes (via Netscaler)
| **APIM gateway hostname** | https://apim-corenonprod01-integration-00.azure-api.net | https://azure-apidev.swcdev | https://azure-apiqa1.swcsit | https://azure-apipreprod.swct | https://azure-api.swc
| **Resource group**    | rg-corenonprod01-integration-00 | rg-corenonprod01-integration-01 | rg-corenonprod01-integration-03 | rg-coreprod01-preprod-integration-03 | rg-coreprod01-prod-integration-04
>>>>>>> origin/develop
| **Subscription**      | CoreNonProd01 | CoreNonProd01 | CoreNonProd01 | CoreProd01 | CoreProd01
| **IAM access**        | Users oysd, ozt8, ob6q | Users oysd, ozt8, ob6q | Users oysd, ozt8, ob6q | Group DCP-Prod-APIM | Group DCP-Prod-APIM
| **Config files**      
| *infra params*        | [pre.json](cicd\templatespecs\params\pre.json)
| *api params*          | [pre-api-parameters.json](cicd\apim\envparams\pre-api-parameters.json)
| *Postman params*      | [SydneyWater_PRE_APIM_ENV.postman_environment.json](cicd\tests\params\SydneyWater_PRE_APIM_ENV.postman_environment.json)
| **SSL certificates**  |
| **Root CAs**          |
| SWCIssuingCA1         | X | X | X | X | X
| SWCRootCA             | X | X | X | X | X
| SWC-Test-Issuing-CA   |   |   |   | X |  
| SWC-Test-Root-CA      |   |   |   | X |  
<<<<<<< HEAD
=======

# DNS entries

| DNS record               | Record type | DEV                             | QA                              | PrePROD                              | PROD          |
| ------------------------ | ----------- | ------------------------------- | ------------------------------- | ------------------------------------ | ------------- |
|                          |             | azure-apidev.swcdev             | azure-apiqa1.swcsit             | azure-apipreprod.swct                | azure-api.swc
| BASE_HOSTNAME            | A           | 10.96.8.4                       | 10.96.10.5                      | 10.96.12.4                           | 10.96.14.4
| developer.BASE_HOSTNAME  | A           | 10.97.240.6                     | 10.97.240.133                   | 10.97.48.5                           | 10.97.56.5
| management.BASE_HOSTNAME | A           | 10.97.240.6                     | 10.97.240.133                   | 10.97.48.5                           | 10.97.56.5
| scm.BASE_HOSTNAME        | A           | 10.97.240.6                     | 10.97.240.133                   | 10.97.48.5                           | 10.97.56.5
|                          |             | azure-apidev.sydneywater.com.au | azure-apiqa1.sydneywater.com.au | azure-apipreprod.sydneywater.com.au  | azure-api.sydneywater.com.au
| PUBLIC_HOSTNAME          |             | 
>>>>>>> origin/develop
| PUBLIC_HOSTNAME          |             | 20.211.56.66                    |

# APIs

## API publishing log
| API name              | Log description    | Current version | Last updated merged into develop | URI to approved publish pipeline | URI to test results
| --------------------- | ------------------ | --------------- | -------------------------------- | -------------------------------- | -------------------
| data-feed-api         | First publish               | v1     | 02-07-2021 | [build 691](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=691&view=results)
| billing-api           | First publish               | v1     | 02-07-2021 | [build 725](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=725&view=results)
| elastic-search-api    | First publish               | v1     | 12-07-2021 | [build 835](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=835&view=results)
| abn-lookup-api        | First publish               | v1     | 13-0?-2021 | [build 954](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=954&view=results)
| meter-api             | First publish               | v1     | 14-07-2021 | [build 986](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=986&view=results)
| leaks-and-outages-api | First publish               | v1     | 14-07-2021 | [build 990](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=990&view=results)
| property-api          | First publish               | v1     | 14-07-2021 | [build 999](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=999&view=results)
| paypal-api            | First publish               | v1     | 14-07-2021 | [build 1007](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1007&view=results)
| aem-assets-api        | First publish               | v1     | 03-08-2021 | [build 1384](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1384&view=results)
| waterfix-api          | First publish               | v1     | 09-08-2021 | [build 1395](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1395&view=results)
| abn-lookup-api        | Added HTTP proxy            | v1.0.1 | 12-08-2021 | [build 1501](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1501&view=results)
| bpoint-api            | Added HTTP proxy            | v1.0.1 | 12-08-2021 | [build 1513](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1513&view=results) 
| paypal-api            | Added HTTP proxy            | v1.0.1 | 12-08-2021 | [build 1515](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1515&view=results) 
| waterfix-api          | Added HTTP proxy            | v1.0.1 | 12-08-2021 | [build 1517](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1517&view=results) 
| data-feed-api         | ???                         | v1.0.1 | 12-08-2021 |
| elastic-search-api    | Updates to encryption logic | v1.0.1 | 16-08-2021 | [build 1542](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1542&view=results)
| sap-metadata-api      | First publish               | v1.0.0 | 31-08-2021 | [build 1660](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1660&view=results)
| ssa-account-api       | First publish               | v1.0.0 | 08-09-2021 | [build 1700](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1700&view=results)
| **20210908.2**        |
| waterfix-api          | Added decrypt propertynumber| v1.2.0 | 13-09-2021 | [build 1725](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1725&view=results)
| **20210913.7**        |
| sap-metadata-api      | changed backend url         | v1.2.0 | 13-09-2021 | [build 1719](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1719&view=results)
| **20210913.5**        |
| data-feed-api         | updated decryption policy   | v1.2.0 | 15-09-2021 | [build 1740](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1740&view=results)
| **20210913.5**        |
| ssa-dashboard-api     | first time publishing       | v1.0.0 | 17-09-2021 | [build 1746](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1746&view=results)
| **20210913.5**        |
| new subscriptions     | adding new subscriptions    | n/a    | 17-09-2021 | [build 1745](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1745&view=results)
| **20210917.1**        |
| abn-lookup-api        | Added legalName to response | v1.2.0 | 20-09-2021 | [build 1756](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1756&view=results)
| cdc-accounts-events-api | first time publishing     | v1.0.1 | 30-09-2021 | [build 1791](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1791&view=results)
| **20210917.1**        |
| ssa-account-api       | adding name value pair      | v1.2.0 | 28-09-2021 | [build 1700](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1862&view=results)
| cdc-login-event-api   | first time publishing       | v1.1.0 | 23-09-2021 | [build 1740](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1828&view=logs&j=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d&t=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d)
| **20210917.1**   
| ssa-account-api       | adding name value pair      | v1.2.0 | 28-09-2021 | [build 17862](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1862&view=results)
| cdc-accounts-api      | First publish               | v1.1.0 | 29-09-2021 | [build 1786](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1786&view=results)
| **20210922.2**        |
| ssa-accounts-api      | added new operation         | v1.3.0 | 06-10-2021 | [build 1903](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1903&view=logs&j=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d)
| **20211006.2**        |
| ssa-billing-api       | first publish               | v1.1.0 | 07-10-2021 | [build 1929](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1929&view=results)
| **20211006.1**        |
| bpoint-api            | adding biller code          | v1.2.0 | 13-10-2021 | [build 1929](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1999&view=results)
| **20211013.5**        |
| ssa-accounts-api      | update backend url          | v1.3.0 |14-10-2021 | [build 2010](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2010&view=results)
| **20211014.3**        |
| bpoint-api            | changed biller code          | v1.3.0 | 14-10-2021 | [build 2006](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2006&view=results)
| ssa-accounts-api      | update mailing address set   | v1.4.0 |19-10-2021 | [build 2068](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2068&view=results)
| waterfix-api          |  replace propertyNumber with customer_id in encryption logic      | v1.4.0 |25-10-2021 | [build 2115](https://dev.azure.com/SWDCP/DCP/_build?definitionId=41&_a=summary)
| ssa-accounts-event-api      | update set-body property for input formatting   | v1.2.0 |21-10-2021 | [build 2084](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2084&view=results)
| sap-digital-bp-api     | first publish   | v1.0.0 |3-11-2021 | [build 2229](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2229&view=logs&j=09543b06-4429-576b-9cb8-02a18819e636)
| ssa-billing-api    | added additional operations   | v1.2.0 |9-11-2021 | [build 2240](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2240&view=results)
| ssa-interactions-api    | first deployment  | v1.0.0 |29-11-2021 | [build 2343](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2343&view=results)
| ssa-usage-api    | first deployment  | v1.0.0 |29-11-2021 | [build 2344](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2344&view=results)
| ssa-billing-api    | added additional operations   | v1.3.0 |9-11-2021 | [build 2266](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2266&view=logs&j=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d&t=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d)
| ssa-accounts-api    | added additional operations   | v1.6.0 |22-11-2021 | [build 2323](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2313&view=logs&j=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d&t=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d)
| ssa-billing-api    | added additional operations   | v1.4.0 |22-11-2021 | [build 2316](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2316&view=results)
| bpoint-api    | publish new version from bpoint   | v1.4.0 |14-12-2021 | [build 2458](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2458&view=results)
| ssa-accounts-api    | added decryption logic   | v1.6.0 |16-12-2021 | [build 2472](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2472&view=results)
| cdc-accounts-api    | added new operation completeEbillMigration   | v1.5.0 |8-12-2021 | [build 2413](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2413&view=results)
| ssa-billing-api    | added new operation InvoicePDFSet   | v1.5.0 |17-12-2021 | [build 2474](https://dev.azure.com/SWDCP/DCP/_build?definitionId=54&_a=summary)
| ssa-payment-api    | first publish    | v1.3 |18-1-2021 | [build 2499](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2499&view=results)
| bpoint-api    | update backend url     | v1.5 |28-1-2022 | [build 2524](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2524&view=results)
| bpoint-api    | using same merchant num/username/pwd for all operations of BPoint api | v1.8 |06-4-2022 | [build 3016](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=3016&view=results)
| cdc-accounts-api    | removing mocked resp from CDC Acccount API getcustomerstatus | v1.6 |11-4-2022 | [build 3037](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=3037&view=results)
| ssa-interactions-api    | Re-extraction to fix assignment of product  | v1.2.0 |11-04-2022 | [build 3035](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=3035&view=results)
| iot-sewer    | Initial version of iot-sewer api  | v1.0.0 |21-04-2022 | [build 3057] (https://dev.azure.com/SWDCP/DCP/_build/results?buildId=3057&view=results)
| bpoint-api    | billerCode hard coding removed from json body and using named value, hardcoding of b/e url removed from DEL dvtokens operation | v1.9 |13-5-2022 | [build 3097](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=3097&view=results)
| bpoint-api    | b/e url overriden for DEL dvtokens operation | v1.10 |16-5-2022 | [build 3101](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=3101&view=results)
| ssa-accounts-api    | Fix $filter value in GET RegistrationSet | v1.6.0 |02-03-2023 | [build 4917](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=4917&view=results)

## API release log

| API name          | Log description             | Version | Target release tranche | URI to approved release pipeline |
| ----------------- | --------------------------- | ------- | ---------------------- | -------------------------------- |
| ssa-account-api   | First publish               | v1.0.0  | release 3              | [build 1710](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1710&view=results)
| sap-metadata-api  | changed backend url         | v1.2.0  | release 3              | [build 1739](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1739&view=results)
| ssa-dashboard-api | First publish               | v1.0.0  | release 3              | [build 1747](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1747&view=results)
| waterfix-api      | Added decrypt propertynumber| v1.2.0  | release 1              | [build 1738](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1738&view=results)
| data-feed-api     | updated decryption policy   | v1.2.0  | release 1              | [build 1744](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1743&view=results)
| abn-lookup-api    | added legalName             | v1.2.0  | release 1              | [build 1759](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1759&view=results)
| ssa-accounts-api  | added new operation         | v1.3.0  | release 3              | 
| ssa-billing-api   | first publish               | v1.1.0  | release 3              | 
| **20211006.1**        |
| bpoint-api        | adding biller code          | v1.2.0 | release 1  | [build 1929](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1999&view=results)
| **20211013.5**        |
| bpoint-api        | changed biller code         | v1.3.0  | release 1              | [build 2009](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2008&view=results)
| ssa-accounts-api      | update backend url       v1.3.0 |release 3 | [build 2010](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2010&view=results)
| **20211014.3**        |
| waterfix-api          |  replace propertyNumber with customer_id in encryption logic      | v1.4.0 |25-10-2021 | [build 2115](https://dev.azure.com/SWDCP/DCP/_build?definitionId=41&_a=summary)
| ssa-accounts-event-api      | update set-body property for input formatting   | v1.2.0 |21-10-2021 | [build 2084](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2084&view=results)
| ssa-billing-api    | added additional operations   | v1.2.0 |9-11-2021 | [build 2240](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2240&view=results)
| ssa-billing-api    | added additional operations   | v1.3.0 |9-11-2021 | [build 2266](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2266&view=logs&j=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d&t=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d)
| ssa-accounts-api    | added additional operations   | v1.6.0 |22-11-2021 | [build 2323](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2313&view=logs&j=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d&t=4b339a3d-6d2f-5ccc-043b-a06cf59f1a5d)
| ssa-billing-api    | added additional operations   | v1.4.0 |22-11-2021 | [build 2316](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2316&view=results)
| cdc-accounts-api    | added new operation completeEbillMigration   | v1.5.0 |8-12-2021 | [build 2413](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2413&view=results)
| ssa-accounts-api    | added additional operations   | v1.6.0 |10-1-2022 | [build 2479](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2479&view=results)
| ssa-accounts-api    | added additional operations   | v1.7.0 |21-1-2022 | [build 2513](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2513&view=results)

## API release log

| API name          | Log description | Current version | Target release tranche | URI to approved release pipeline |
| ----------------- | --------------- | --------------- | ---------------------- | -------------------------------- |
| abn-lookup-api    | added legalName | v1.0.1          | release 1              | [run 1759](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=1759&view=results)

## API backend service URLs

<<<<<<< HEAD
| API               | Dev-00 | Dev | QA | PrePROD | PROD |
| ----------------- | ------ | --- | -- | ------- | ---- |
| **3rd party APIs**
| abn-lookup-api    | https://abr.business.gov.au/ | " | " | " | "
| paypal-api        | https://api-m.sandbox.paypal.com/ | " | " | " | https://api-m.paypal.com/
| waterfix-api      | https://asap.dataforce.com.au/~spotless-test/ | " | " | " | https://asap.dataforce.com.au/~spotless/
| bpoint-api        | https://bpoint-uat.premier.com.au/ | " | " | " | https://bpoint.com.au/
| aem-assets-api    | https://author1australiaeast.dev.sydneywater.adobecqms.net | " | https://author1australiaeast.qa2.sydneywater.adobecqms.net | https://author1australiaeast.stage.sydneywater.adobecqms.net | https://author1australiaeast.prod.sydneywater.adobecqms.net
| **Non-self-service APIs**
| data-feed-api     | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| billing-api       | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| elastic-search    | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| meter-api         | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| leaks-and-outages | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| property-api      | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| **Self-service APIs** 
| ssa-account-api   | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| sap-metadata-api  | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
=======
| API                | Dev-00                  | Dev | QA | PrePROD | PROD |
| ------------------ | ----------------------- | --- | -- | ------- | ---- |
| **3rd party APIs**
| abn-lookup-api     | https://abr.business.gov.au/ | " | " | " | "
| paypal-api         | https://api-m.sandbox.paypal.com/ | " | " | " | https://api-m.paypal.com/
| waterfix-api       | https://asap.dataforce.com.au/~spotless-test/ | " | " | " | https://asap.dataforce.com.au/~spotless/
| bpoint-api         | https://bpoint-uat.premier.com.au/ | " | " | " | https://bpoint.com.au/
| aem-assets-api     | https://author1australiaeast.dev.sydneywater.adobecqms.net | " | https://author1australiaeast.qa2.sydneywater.adobecqms.net | https://author1australiaeast.stage.sydneywater.adobecqms.net | https://author1australiaeast.prod.sydneywater.adobecqms.net
| **Non-self-service APIs**
| data-feed-api      | https://apidev.swc:41443 | "  | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| billing-api        | https://apidev.swc:41443 | "  | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| elastic-search     | https://apidev.swc:41443 | "  | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| meter-api          | https://apidev.swc:41443 | "  | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| leaks-and-outages  | https://apidev.swc:41443 | "  | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| property-api       | https://apidev.swc:41443 | "  | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| **Self-service APIs** 
| ssa-account-api    | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| sap-metadata-api   | https://apidev.swc:41443 | " | https://apisit.ads.swc:41443 | https://apitest.adst.swct:41443 | https://apiprod.swc:41443
| cdc-accounts-api   |
| cdc-login-event-api| func-cdc-login           | " | "" | "" | ""
| ssa-billing-pai    | https://apidev.swc:41443/customer/ssa-billing/sap/opu/odata/SAP/ZHSSA_SCM_UTILITIES_SRV | " | https://apisit.swc:41443/customer/ssa-billing/sap/opu/odata/SAP/ZHSSA_SCM_UTILITIES_SRV | "" | ""

>>>>>>> origin/develop
| sap-digital-bp-api     | first publish   | v1.0.0 |3-11-2021 | [build 2229](https://dev.azure.com/SWDCP/DCP/_build/results?buildId=2229&view=logs&j=09543b06-4429-576b-9cb8-02a18819e636)

## APIM named value pairs
 
 | Name                        | Comment        | abn-lookup | paypal | waterfix | bpoint | aem-assets | data-feed | billing | elastic-search | meter | leaks-and-outages | property |
 | --------------------------- | -------------- | ---------- | ------ | -------- | ------ | ---------- | --------- | ------- | -------------- | ----- | ----------------- | -------- |
 | api-authentication-username | Axway username |            |        |          |        |            | X         | X       | X              | X     | X                 | X        |
 | api-authentication-password | Axway password |            |        |          |        |            | X         | X       | X              | X     | X                 | X        |
 | api-encryptiv               |                |            |        |          |        |            |           |         | X              | X     | X                 | X        |
 | api-encryptkey              | 

| Named value                    | Comment            | abn-lookup | paypal | waterfix | bpoint | aem-assets | data-feed | billing | elastic-search | meter | leaks-and-outages | property | sap-account-event | cdc-login-event-api | IOT-Sewer |
| ------------------------------ | ------------------ | ---------- | ------ | -------- | ------ | ---------- | --------- | ------- | -------------- | ----- | ----------------- | -------- | ----------------- | ------------------- | ----------|
| appInsKey                      | AppInsights instrumentation key
| 3rd-party-http-proxy-password  | http proxy pass    | X          | X      | X        | X
| 3rd-party-http-proxy-url       | http proxy url     | X          | X      | X        | X
| 3rd-party-http-proxy-username  | http proxy username| X          | X      | X        | X
| enable-3rd-party-http-proxy    | enable http proxy  | X          | X      | X        | X
| abn-authenticationguid         | ABR GUID           | X
| aem-api-authentication-username| Adobe usernmae     |            |        |          |        | X
| aem-api-authentication-password| Adobe password     |            |        |          |        | X
| bpoint-billercode              | BPoint biller code |            |        |          | X
| bpoint-username                | BPoint username    |            |        |          | X
| bpoint-merchantnumber          | BPoint merchant no |            |        |          | X
| bpoint-password                | BPoint password    |            |        |          | X
| waterfix-guid                  | Waterfix GUID      |            |        | X
| waterfix-database              | Waterfix database  |            |        | X
| paypal-username                | PayPal username    |            | X
| paypal-password                | PayPal password    |            | X
| api-backend-url-paypal-orders  |                    |            | X
| api-backend-url-paypal-token   |                    |            | X
| api-authentication-username    | Axway username     |            |        |          |        |            | X         | X       | X              | X     | X                 | X        |
| api-authentication-password    | Axway password     |            |        |          |        |            | X         | X       | X              | X     | X                 | X        |
| api-encryptiv                  | Encryption         |            |        | ?        |        |            | X         |         | X              | X     | X                 | X        |
| api-encryptkey                 | Encryption         |            |        | ?        |        |            | X         |         | X              | X     | X                 | X        |
| encrypt-exception-values       | Encryption         |            |        | ?        |        |            | X         |         | X              | X     | X                 | X        |
| jwt-token-key-n-value          |                    |            |        |          |        |            |           |         |                |       |                   |          | X
| jwt-token-key-e-value          |                    |            |        |          |        |            |           |         |                |       |                   |          | X
| func-cdc-login-key             |                    |            |        |          |        |            |           |         |                |       |                   |          |                  |X
| sap-client-value               |                    |            |        |          |        |            |           |         |                |       |                   |          |  X          |
| IotSewerSigAllSites            | Signature Value    |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |
| IotSewerSigCurrentAlarms       | Signature Value    |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |
| IotSewerSigEventHistory        | Signature Value    |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |
| IotSewerSigStateHistory        | Signature Value    |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |
| IotSewerSigTelemetryHistory    | Signature Value    |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |
| IotSewerSigTelemetryWithinBounds| Signature Value   |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |
| IotSewerSigUpdateAlarm         | Signature Value    |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |
| IotSewerSigWetWeatherRegions   | Signature Value    |            |        |          |        |            |           |         |                |       |                   |          |             |                              |X         |

## KeyVault secrets

| Secret name                   | Originator team    | Comment   | Used by APIM named values | Used by APIM other | Used by Storage account | 
| ----------------------------- | ------------------ | --------- | ------------------------- | ------------------ | ----------------------- |
| 3rd-party-http-proxy-password | Sydney Water infra |           | X
| 3rd-party-http-proxy-username | Sydney Water infra |           | X
| abn-authenticationguid        | Sydney Water Web   |           | X
| aem-api-authentication-password | Adobe Forms      |           | X
| aem-api-authentication-username | Adobe Forms      |           | X
| api-authentication-password   | Sydney Water Axway-Netscaler | | X
| api-authentication-username   | Sydney Water Axway-Netscaler | | X
| api-encryptiv                 | APIM               |           | X
| api-encryptkey                | APIM               | 
| appInsKey                     | APIM               | autogenerated from IaC deployment
| bpoint-merchantnumber         | Sydney Water Web   | 
| bpoint-password               | Sydney Water Web   |
| bpoint-username               | Sydney Water Web   |
| paypal-password               | Sydney Water Web   |
| paypal-username               | Sydney Water Web   |
| waterfix-guid                 | Sydney Water Web   |
| func-cdc-login-key            | CDC Team           |


## KeyVault keys

| Key name                      | Comment                        | Type | Size | Used by APIM | Used by Storage Account |
| ----------------------------- | ------------------------------ | ---- | ---- | ------------ | ----------------------- |
| cmk-SUB_NAME-int-INDEX        | Storage account encryption CMK | RSA  | 2048 |              | X

where
* SUB_NAME = Azure subcription name
* INDEX = 01 = dev, 02 = QA, 03 = PREPROD, 04 = PROD

# DevOps pipelines and GitFlow branching strategy

![Pipelines-Branching-Environments](/doc/Azure_APIM_SDLC-Pipelines.png)

| Pipelines                                                                                        | Dev-00 | Dev | QA | PrePROD | PPROD |
| ------------------------------------------------------------------------------------------------ | ------ | --- | -- | ------- | ----- |
| **[/APIM-infrastructure](https://dev.azure.com/SWDCP/DCP/_build?definitionScope=%5CAPIM-infrastructure)**                                        
| [SW-DCP-APIM.CI-00](https://dev.azure.com/SWDCP/DCP/_build?definitionId=4)                       | d      |     |    |         |       |
| [SW-DCP-APIM.CI-01](https://dev.azure.com/SWDCP/DCP/_build?definitionId=3)                       |        | d   |    |         |       |
| **[/APIM-published-APIs](https://dev.azure.com/SWDCP/DCP/_build?definitionScope=%5CAPIM-published-APIs)**
| [SW-DCP-APIM.publish-infra](https://dev.azure.com/SWDCP/DCP/_build?definitionId=38)              | e      | d   |    |         |       |
| [SW-DCP-APIM.property-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=28)               | e      | d   |    |         |       |
| [SW-DCP-APIM.paypal-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=34)                 | e      | d   |    |         |       |
| [SW-DCP-APIM.meter-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=27)                  | e      | d   |    |         |       |
| [SW-DCP-APIM.leaks-and-outages-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=29)      | e      | d   |    |         |       |
| [SW-DCP-APIM.elastic-address-search-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=31) | e      | d   |    |         |       |
| [SW-DCP-APIM.data-feed-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=7)               | e      | d   |    |         |       |
| [SW-DCP-APIM.bpoint-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=30)                 | e      | d   |    |         |       |
| [SW-DCP-APIM.aem-asset-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=39)              | e      | d   |    |         |       |
| [SW-DCP-APIM.abn-lookup-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=26)             | e      | d   |    |         |       |
| [SW-DCP-APIM.waterfix-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=41)               | e      | d   |    |         |       |
| [SW-DCP-APIM.ssa-account-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=41)            | e      | d   |    |         |       |
| [SW-DCP-APIM.sap-metadata-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=44)           | e      | d   |    |         |       |
| **[/APIM-release](https://dev.azure.com/SWDCP/DCP/_build?definitionScope=%5CAPIM-release)**
| [SW-DCP-APIM.release-infra](https://dev.azure.com/SWDCP/DCP/_build?definitionId=36)              |        |     | d  | d       | d     |
| [SW-DCP-APIM.release-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=37)                |        |     | d  | d       | d     |
| [SW-DCP-APIM.release3-api](https://dev.azure.com/SWDCP/DCP/_build?definitionId=46)               |        |     | d  | d       | d     |

where
* e = extract
* d = deploy

# DevOps pipelines artefacts

The pipelines consist of
* YML files
* JSON parameter files
  * api parameters
  * environment parameters
  * extractor configuration parameters
* IaC
  * infrastructure bicep (hand-written)
  * API ARM (extracted)
  * APIM shared configuration (hand-merged from extracted ARM)

![Pipelines-artefacts](/doc/Azure_APIM_SDLC-DevOps_detailed.png)

# DevOps process

## GitFlow branching strategy

Branches
* develop
* feature/x-api
* release/y
* master

![Pipelines-Branching-Environments](/doc/Azure_APIM_SDLC-Process.png)

## How to publish an API using a GitFlow feature branch

### How to merge extracted APIM infrastructure changes

1. Draft a PR to get a gist of the likely merge commits

2. Open the following files in the new branch

    1. cicd/apim/envparams/dev-api-parameters.json - check the new API has a key value for backend service URI

            "serviceUrl": {
                "value": {
                    "billingapi": "https://apidev.swc:41443/customer/Billing",
                    "datafeedapi": "https://apidev.swc:41443/common",
                    "elasticaddresssearchapi": "https://apidev.swc:41443/customer",
                    "abnlookupapi": "https://abr.business.gov.au"
                }

    2. cicd/apim/globalconfig/infra-namedValues.template.json - check the API handover document for required named values

            {
                "properties": {
                    "tags": [],
                    "secret": true,
                    "displayName": "abn-authenticationguid",
                    "keyVault": {
                    "secretIdentifier": "[concat(variables('kvSecretIdPrefix'), '/abn-authenticationguid')]"
                    }
                },
                "name": "[concat(parameters('ApimServiceName'), 'abn-authenticationguid')]",
                "type": "Microsoft.ApiManagement/service/namedValues",
                "apiVersion": "2021-01-01-preview"
            },

    3. cicd/pipelines/publish-api.yml - check that the new API name has been added to the apiName parameter allowed values and default value

            parameters:
            - name: apiName
              displayName: API Name
              type: string
              default: abn-lookup-api
              values:
              - billing-api
              - data-feed-api
              - elastic-address-search-api
              - abn-lookup-api

    4. cicd/templatespecs/params/dev.json - check the API handover doc for any required key vault secrets
    
            "keyvault_apimSecrets" : {
                "value": [
                    "api-authentication-password",
                    "api-authentication-username",
                    "api-encryptiv",
                    "api-encryptkey",
                    "abn-authenticationguid"
                ]
            },

    5. Check unit tests - check that the Postman collection has a folder for the new API and any variables have been added to the other ENV variables

            {
                "name": "abn-lookup-api",
                "item": [
                    {
                        "name": "ABN Lookup | Search by ABN | Response is 200 and JSON",
                        "event": [
                            {
                                "listen": "test",
                                "script": {
                                    "exec": [
                                        "pm.test(\"ABN Lookup | Search by ABN | Correct ABN Request and Expected 200 status and JSON response\", function () {    \r",
                                        "    pm.response.to.have.status(200);    \r",
                                        "    pm.response.to.be.json;\r",
                                        "});"
                                    ],
                                    "type": "text/javascript"
                                }
                            }
                        ],
                        "request": {
                            "method": "POST",
                            "header": [
                                {
                                    "key": "Content-Type",
                                    "type": "text",
                                    "value": "application/json"
                                },
                                {
                                    "key": "Ocp-Apim-Subscription-Key",
                                    "type": "text",
                                    "value": "{{APIM_SUBSCRIPTION_KEY_ABN_LOOKUP}}"
                                },
                                {
                                    "key": "",
                                    "type": "text",
                                    "value": "",
                                    "disabled": true
                                }
                            ],
                            "body": {
                                "mode": "raw",
                                "raw": "{\r\n  \"searchString\": \"51835430479\",\r\n  \"includeHistoricalDetails\": \"N\"\r\n}"
                            },
                            "url": {
                                "raw": "{{APIM_URL}}/abn-lookup/v1/SearchByABN",
                                "host": [
                                    "{{APIM_URL}}"
                                ],
                                "path": [
                                    "abn-lookup",
                                    "v1",
                                    "SearchByABN"
                                ],
                                "query": [
                                    {
                                        "key": "",
                                        "value": "",
                                        "disabled": true
                                    }
                                ]
                            }
                        },
                        "response": []
                    },
                    {
                        "name": "ABN Lookup | Search by ABN | Response is JSON and Exception Details",
                        "event": [
                            {
                                "listen": "test",
                                "script": {
                                    "exec": [
                                        "pm.test(\"ABN Lookup | Search by ABN | Wrong ABN Request and Expected Response is JSON and has Valid Exception Details\", function () {    \r",
                                        "    pm.response.to.have.status(200);    \r",
                                        "    pm.response.to.be.json;\r",
                                        "    let jsonResponse = pm.response.json();\r",
                                        "    pm.expect(jsonResponse.exception).to.be.a('object');\r",
                                        "});"
                                    ],
                                    "type": "text/javascript"
                                }
                            }
                        ],
                        "request": {
                            "method": "POST",
                            "header": [
                                {
                                    "key": "Content-Type",
                                    "type": "text",
                                    "value": "application/json"
                                },
                                {
                                    "key": "Ocp-Apim-Subscription-Key",
                                    "type": "text",
                                    "value": "{{APIM_SUBSCRIPTION_KEY_ABN_LOOKUP}}"
                                },
                                {
                                    "key": "",
                                    "type": "text",
                                    "value": "",
                                    "disabled": true
                                }
                            ],
                            "body": {
                                "mode": "raw",
                                "raw": "{\r\n  \"searchString\": \"testno\",\r\n  \"includeHistoricalDetails\": \"N\"\r\n}"
                            },
                            "url": {
                                "raw": "{{APIM_URL}}/abn-lookup/v1/SearchByABN",
                                "host": [
                                    "{{APIM_URL}}"
                                ],
                                "path": [
                                    "abn-lookup",
                                    "v1",
                                    "SearchByABN"
                                ],
                                "query": [
                                    {
                                        "key": "",
                                        "value": "",
                                        "disabled": true
                                    }
                                ]
                            }
                        },
                        "response": []
                    }
                ]
            },

# Deploying a new environment

## Pre-requisites

1. SSL certificates for custom hostnames
2. hostnames
3. root CA certs
4. Axway credentials
5. Adobe credentials


## Instructions

where ENV is [pre, dev, qa, preprod, prod]

1. Configure main environment params file

    1. Rename service names
        1. Note that kvBootstrap probably won't change
        2. Role IDs won't change
    2. External dependencies
        1. 

2. Configure environment specific variables in bootstrap key vault - remember to set expiration dates using default 2 years

    1. 3rd-party-http-proxy-password-ENV
    2. 3rd-party-http-proxy-username-ENV
    3. api-authentication-password-ENV
    4. api-authentication-username-ENV
    5. dcp-apim-public-ssl-ENV-base64
    6. dcp-apim-public-ssl-ENV-password
    7. dcp-apim-ssl-ENV-base64
    8. dcp-apim-ssl-ENV-password

3. Configure APIM env params

    1. Axway URI
    2. 3rd party URIs
        1. abn-lookup
        2. bpoint
        3. paypal
        4. waterfix
    3. Adobe AEM

4. Prepare release-infra YML

    1. Duplicate stages for new ENV

5. Prepare release-api yml

6. Prepare Postman ENV params file
