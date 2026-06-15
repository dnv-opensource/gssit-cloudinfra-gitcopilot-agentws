# InfraOps module — STARTER STUB (intentionally incomplete)
#
# This file is a scaffold on purpose. Let GitHub Copilot Agent Mode build the
# real implementation while you observe the iteration loop. Do not finish it by
# hand — that is the agent's job in this lab.

function Get-RetentionDays {
    <#
    .SYNOPSIS
    Gets backup retention days for an environment.

    .DESCRIPTION
    Returns the standard retention period in days for supported environments.

    .EXAMPLE
    Get-RetentionDays -Environment dev
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('dev', 'test', 'prod')]
        [string]$Environment
    )

    switch ($Environment.ToLowerInvariant()) {
        'dev' { return 7 }
        'test' { return 30 }
        'prod' { return 365 }
    }
}

Export-ModuleMember -Function Get-RetentionDays
