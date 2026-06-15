#requires -Version 7.2

Set-StrictMode -Version Latest

$publicFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public') -Filter '*.ps1' -File -ErrorAction SilentlyContinue
foreach ($file in $publicFiles) {
    . $file.FullName
}

Export-ModuleMember -Function @(
    'Get-WorkshopDemoServiceStatus'
)
