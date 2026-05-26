# L1 — Hello, Copilot reference solution

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

    $slug = @($Project, $Environment, $Service) -join '-'
    $slug = $slug.ToLowerInvariant()
    $slug = $slug -replace '[\s_]+', '-'
    $slug = $slug -replace '[^a-z0-9-]', ''
    $slug = $slug -replace '-{2,}', '-'
    $slug = $slug.Trim('-')

    return $slug
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
