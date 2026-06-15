<#
    Self-contained test harness for the InfraOps module.

    No external test framework required — it runs with plain PowerShell 7 so the
    lab has zero install dependencies. In agent mode, ask the agent to run this
    file and read the PASS/FAIL output; that terminal run is the "Review" stage
    of the iteration loop.

    Run it yourself with:
        pwsh -NoProfile -File labs\L3-agent-mode-playground\solution\Run-Tests.ps1
#>

$ErrorActionPreference = 'Stop'

$modulePath = Join-Path $PSScriptRoot 'InfraOps\InfraOps.psm1'
Import-Module $modulePath -Force

$script:failed = 0

function Assert-Equal {
    param($Expected, $Actual, [string]$Name)
    if ($Expected -eq $Actual) {
        Write-Host "PASS: $Name"
    }
    else {
        Write-Host "FAIL: $Name (expected '$Expected', got '$Actual')"
        $script:failed++
    }
}

function Assert-Throws {
    param([scriptblock]$Script, [string]$Name)
    try {
        & $Script | Out-Null
        Write-Host "FAIL: $Name (expected an error, none thrown)"
        $script:failed++
    }
    catch {
        Write-Host "PASS: $Name"
    }
}

Assert-Equal 7   (Get-RetentionDays -Environment dev)  'dev returns 7 days'
Assert-Equal 30  (Get-RetentionDays -Environment test) 'test returns 30 days'
Assert-Equal 365 (Get-RetentionDays -Environment prod) 'prod returns 365 days'
Assert-Equal 365 (Get-RetentionDays -Environment Prod) 'matching is case-insensitive'
Assert-Throws { Get-RetentionDays -Environment staging } 'unknown environment is rejected'

if ($script:failed -gt 0) {
    Write-Host "`n$($script:failed) check(s) failed."
    exit 1
}

Write-Host "`nAll L3 checks passed."
