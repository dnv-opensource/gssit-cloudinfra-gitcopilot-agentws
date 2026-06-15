#requires -Version 7.2

Set-StrictMode -Version Latest

# Dot-source every script under Public/ so each function becomes available when the
# module is imported. You should not need to change this loader.
$publicFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public') -Filter '*.ps1' -File -ErrorAction SilentlyContinue
foreach ($file in $publicFiles) {
    . $file.FullName
}

# TODO: Export the function(s) you build under Public/ so MCPServerPS can surface them
# as tools. Keep this in sync with FunctionsToExport in WorkshopDemo.psd1.
Export-ModuleMember -Function @(
    # 'Get-WorkshopDemoServiceStatus'
)
