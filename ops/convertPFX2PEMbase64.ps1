param(
    [Parameter(Mandatory=$true)]$pfxFilename
)

Write-Output "Reading PFX file $pfxFilename..."
#$fileContentBytes = get-content $pfxFilename -AsByteStream
$fileContentBytes = get-content $pfxFilename -Raw -Encoding Byte

$outfile = "$pfxFilename.txt"
Write-Output "Writing PEM file $outfile..."
[System.Convert]::ToBase64String($fileContentBytes) | Out-File $outfile