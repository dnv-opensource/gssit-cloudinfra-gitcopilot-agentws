function Get-RetentionDays {
    <#
    .SYNOPSIS
        Returns the standard backup retention period, in days, for an environment.

    .DESCRIPTION
        Maps a DNV environment tier to its standard backup retention policy.
        Used by InfraOps automation so retention values are consistent across
        runbooks instead of being hard-coded per script.

        Retention policy:
          dev  -> 7 days
          test -> 30 days
          prod -> 365 days

        The -Environment value is case-insensitive. Any value outside the
        allowed set is rejected by parameter validation before the function runs.

    .PARAMETER Environment
        The environment tier. One of: dev, test, prod.

    .EXAMPLE
        Get-RetentionDays -Environment prod

        Returns 365.

    .EXAMPLE
        Get-RetentionDays -Environment Dev

        Returns 7 (matching is case-insensitive).

    .OUTPUTS
        System.Int32
    #>
    [CmdletBinding()]
    [OutputType([int])]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('dev', 'test', 'prod')]
        [string]$Environment
    )

    switch ($Environment.ToLower()) {
        'dev'  { 7 }
        'test' { 30 }
        'prod' { 365 }
    }
}

Export-ModuleMember -Function Get-RetentionDays
