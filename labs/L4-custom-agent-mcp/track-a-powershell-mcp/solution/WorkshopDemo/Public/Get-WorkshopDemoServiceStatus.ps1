function Get-WorkshopDemoServiceStatus {
    <#
    .SYNOPSIS
        Returns the runtime status of a Windows service from a short allow-list.

    .DESCRIPTION
        Calls Get-Service for the requested service name and returns a small,
        structured object with the service name, display name, runtime status,
        start type, and the time the query ran.

        The comment-based help you are reading becomes the tool's description, and
        the [ValidateSet] on -Name becomes the tool's input schema. The model can
        only ask for service names that appear in the set — that is the
        callable-surface security boundary.

        The data returned is real (live Get-Service output) but the cmdlet only
        ever READS service state. It does not start, stop, or modify any service.

    .PARAMETER Name
        The Windows service to query. Must be one of the values declared in
        ValidateSet. Defaults to 'Spooler' (Print Spooler) so the agent can call
        the tool without naming a service explicitly.

    .EXAMPLE
        Get-WorkshopDemoServiceStatus
        # Returns the status of the Spooler service (the default).

    .EXAMPLE
        Get-WorkshopDemoServiceStatus -Name wuauserv

    .OUTPUTS
        PSCustomObject with Name, DisplayName, Status, StartType, QueriedAt.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet('Spooler', 'wuauserv', 'BITS')]
        [string]$Name = 'Spooler'
    )

    $svc = Get-Service -Name $Name -ErrorAction Stop

    [pscustomobject]@{
        Name        = $svc.Name
        DisplayName = $svc.DisplayName
        Status      = [string]$svc.Status
        StartType   = [string]$svc.StartType
        QueriedAt   = (Get-Date).ToString('o')
    }
}
