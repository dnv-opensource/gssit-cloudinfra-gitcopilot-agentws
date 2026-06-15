Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Copy-SafeFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Source,

        [Parameter(Mandatory)]
        [string]$Destination,

        [Parameter(Mandatory)]
        [ref]$ErrorLog
    )

    try {
        if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
            throw [System.Management.Automation.ItemNotFoundException]::new("Source file not found: $Source")
        }

        $destinationDirectory = Split-Path -Path $Destination -Parent
        if ($destinationDirectory -and -not (Test-Path -LiteralPath $destinationDirectory -PathType Container)) {
            New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
        }

        Copy-Item -LiteralPath $Source -Destination $Destination -Force -ErrorAction Stop
        return $true
    }
    catch [System.UnauthorizedAccessException] {
        $ErrorLog.Value += "UnauthorizedAccessException: $($_.Exception.Message)"
        return $false
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        $ErrorLog.Value += "ItemNotFoundException: $($_.Exception.Message)"
        return $false
    }
    catch {
        $ErrorLog.Value += "UnexpectedError: $($_.Exception.GetType().FullName): $($_.Exception.Message)"
        return $false
    }
}

function Assert-True {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [bool]$Condition
    )

    if (-not $Condition) {
        throw "FAIL: $Name"
    }

    Write-Host "PASS: $Name" -ForegroundColor Green
}

$testRoot = Join-Path -Path $PSScriptRoot -ChildPath '_copy-safefile-test'
$sourceDirectory = Join-Path -Path $testRoot -ChildPath 'source'
$targetDirectory = Join-Path -Path $testRoot -ChildPath 'target'
$sourceFile = Join-Path -Path $sourceDirectory -ChildPath 'demo.txt'
$destinationFile = Join-Path -Path $targetDirectory -ChildPath 'demo.txt'
$errorLog = @()

try {
    if (Test-Path -LiteralPath $testRoot) {
        Remove-Item -LiteralPath $testRoot -Recurse -Force
    }

    New-Item -ItemType Directory -Path $sourceDirectory -Force | Out-Null
    Set-Content -LiteralPath $sourceFile -Value 'prompt dojo' -NoNewline

    $copySucceeded = Copy-SafeFile -Source $sourceFile -Destination $destinationFile -ErrorLog ([ref]$errorLog)
    Assert-True -Name 'copy succeeds for valid source' -Condition $copySucceeded
    Assert-True -Name 'destination file created' -Condition (Test-Path -LiteralPath $destinationFile -PathType Leaf)
    Assert-True -Name 'no errors logged on success' -Condition ($errorLog.Count -eq 0)

    $missingLog = @()
    $missingResult = Copy-SafeFile -Source (Join-Path -Path $sourceDirectory -ChildPath 'missing.txt') -Destination $destinationFile -ErrorLog ([ref]$missingLog)
    Assert-True -Name 'missing source returns false' -Condition (-not $missingResult)
    Assert-True -Name 'missing source logged' -Condition ($missingLog.Count -eq 1 -and $missingLog[0] -like 'ItemNotFoundException:*')

    Write-Host 'All L2 Round 3 checks passed.' -ForegroundColor Cyan
}
finally {
    if (Test-Path -LiteralPath $testRoot) {
        Remove-Item -LiteralPath $testRoot -Recurse -Force
    }
}
