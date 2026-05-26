# L1 — Hello, Copilot starter
#
# Task:
# Complete New-ResourceSlug with help from GitHub Copilot completions and chat.
# Keep the function small and readable. Run this file to validate your work.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function New-ResourceSlug {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Project,

        [Parameter(Mandatory)]
        [string]$Environment,

        [Parameter(Mandatory)]
        [string]$Service
    )

    # TODO:
    # 1. Join Project, Environment, and Service with hyphens.
    # 2. Convert to lowercase.
    # 3. Replace spaces and underscores with hyphens.
    # 4. Remove characters that are not letters, numbers, or hyphens.
    # 5. Collapse repeated hyphens.
    # 6. Trim leading and trailing hyphens.
    #
    # Copilot prompt idea:
    # "Implement this PowerShell resource slug function using the rules above.
    # Keep it simple and compatible with PowerShell 7."

    return ''
}

function Assert-Equal {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Expected,

        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Actual
    )

    if ($Expected -ne $Actual) {
        throw "FAIL: $Name — expected '$Expected' but got '$Actual'"
    }

    Write-Host "PASS: $Name" -ForegroundColor Green
}

Assert-Equal `
    -Name 'basic resource slug' `
    -Expected 'cloud-platform-dev-api-gateway' `
    -Actual (New-ResourceSlug -Project 'Cloud Platform' -Environment 'Dev' -Service 'API Gateway')

Assert-Equal `
    -Name 'trims repeated separators' `
    -Expected 'platform-prod-worker' `
    -Actual (New-ResourceSlug -Project '  Platform  ' -Environment 'PROD' -Service '__Worker__')

Assert-Equal `
    -Name 'removes unsafe characters' `
    -Expected 'team-1-test-cache' `
    -Actual (New-ResourceSlug -Project 'Team #1' -Environment 'Test' -Service 'Cache!!!')

Write-Host 'All L1 checks passed.' -ForegroundColor Cyan
