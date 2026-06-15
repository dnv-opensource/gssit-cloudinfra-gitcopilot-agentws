# Round 3 — Target prompt

## Target specific prompt

```text
Add error handling to this PowerShell function that copies files:

function Copy-SafeFile {
    param(
        [string]$Source,
        [string]$Destination
    )
    Copy-Item -Path $Source -Destination $Destination
}

Error handling requirements:
1. Validate that $Source exists before copying
2. Create $Destination directory if it doesn't exist
3. Use try/catch with specific error types (ItemNotFoundException, UnauthorizedAccessException)
4. Log errors to a $ErrorLog array passed by reference
5. Return $true on success, $false on failure
```

## Sample-shape Copilot output

A strong answer usually looks like this shape:

```powershell
function Copy-SafeFile {
    param(
        [string]$Source,
        [string]$Destination,
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
}
```

See `round-3-copy-safefile.ps1` for a runnable reference.

## Self-check rubric

- `Test-Path` or equivalent validates the source first
- `try`/`catch` is present with at least one specific exception type
- Errors are appended to a log array by reference
- The function returns `$true` on success and `$false` on failure

## What context shifted

The important change is **active code + failure contract**. Showing Copilot the function body, the exception types, the logging pattern, and the return rule turns a generic wrapper into a specific operational pattern.
