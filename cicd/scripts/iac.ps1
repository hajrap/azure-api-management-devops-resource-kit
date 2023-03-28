param(
    [Parameter(Mandatory=$true)]$resourceGroup,
    [Parameter(Mandatory=$true)]$location,
    [Parameter(Mandatory=$true)]$name,
    [Parameter(Mandatory=$true)]$version,
    [Parameter(Mandatory=$true)]$filePath,
    [Parameter(Mandatory=$true)]$paramsPath,
    [Parameter(Mandatory=$true)]$environment,
    [Parameter(Mandatory=$true)]$isDryRun
)

# Output powershell version for debugging purposes and is probably generally good to know
$PSVersionTable.PSVersion # Assuming powershell core (7)

$ErrorActionPreference = "Stop"

if ($verbose) 
{ 
    $global:VerbosePreference = "Continue" 
} 

Install-Module -Name Az.Resources -Force -AllowClobber
Install-Module -Name Az.ApiManagement -Force -AllowClobber

try 
{
  if (!(Get-AzResourceGroup $resourceGroup -ErrorAction SilentlyContinue))
  { 
    New-AzResourceGroup `
    -Name $resourceGroup `
    -Location $location `
    -Tag @{Name="Sydney Water Shared Services";`
            Department="Digital Business";`
            Application="Common Infrastructure";`
            Version="0.1";`
            Owner="Sydney Water";`
            CostCentre="A3307";`
            ProjectCode="20037808";`
            Description="Sydney Water Shared Services ${environment} Integration Components";`
            Environment="${environment}".ToUpper();`
            Role="Integration"}
  }
}
catch 
{
  Write-Output 'Error creating resource group'
  Write-Error $Error[0]
}

try 
{  
  write-output "New AzTemplateSpec $name"
  New-AzTemplateSpec `
  -Name $name `
  -Version $version `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -TemplateFile $filePath
}
catch 
{
  Write-Output "Error creating templatespec ${filePath}"
  Write-Error $Error[0]
}

try 
{
  $id = (Get-AzTemplateSpec -ResourceGroupName $resourceGroup -Name $name -Version $version).Versions.Id
  write-output "Deploying template name: $name, version: $version and id: $id, please wait"
}
catch 
{
  Write-Output 'Error fetching templatespec'
  Write-Error $Error[0]
}

try 
{
  $deploymentName = "$resourceGroup.$version"
  
  if ($isDryRun -eq $true)
  { 
    Write-Output "Yes its dry run!"
    New-AzResourceGroupDeployment `
    -WhatIf `
    -Name $deploymentName `
    -ResourceGroupName $resourceGroup `
    -DeploymentDebugLogLevel 'All' `
    -TemplateParameterFile $paramsPath `
    -TemplateSpecId $id
  }
  else {
    Write-Output "This isn't a dry run!"
    New-AzResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $resourceGroup `
    -DeploymentDebugLogLevel 'All' `
    -TemplateParameterFile $paramsPath `
    -TemplateSpecId $id
  }
}
catch 
{
  Write-Output 'Error deploying templatespec part 1- New-AzResourceGroupDeployment'
  Write-Error $Error[0]
}

if ($isDryRun -eq $false)
{
  try 
  {
    $deploymentName = "$resourceGroup.$version"

    Get-AzResourceGroupDeployment `
      -ResourceGroupName $resourceGroup `
      -Name $deploymentName 
  }
  catch 
  {
    Write-Output 'Error deploying templatespec part 2 - Get-AzResourceGroupDeployment'
    Write-Error $Error[0]
  }
}

# try 
# {
#   Remove-AzPrivateEndpoint -Name 'pe-sb-corenonprod01-integration-03' -ResourceGroupName $resourceGroup
#   #Remove-AzServiceBusNamespace -ResourceGroup $resourceGroup -NamespaceName "sb-corenonprod01-integration-03"
# }
# catch 
# {
#   Write-Output 'remove service Bus '
#   Write-Error $Error[0]
# }

# try 
# {
#  $apimContext = New-AzApiManagementContext -ResourceGroupName $resourceGroup -ServiceName "apim-corenonprod01-integration-01"

#   Remove-AzApiManagementSubscription -Context $apimContext -SubscriptionId "60b862cb07ffd51660c929fd" 
#   Remove-AzApiManagementSubscription -Context $apimContext -SubscriptionId "60beac4107ffd51660c92ba5"
#   Remove-AzApiManagementSubscription -Context $apimContext -SubscriptionId "6111cf9c1a4189047446ce0f"  
# }
# catch 
# {
#   Write-Output 'remove subscriptions '
#   Write-Error $Error[0]
# }