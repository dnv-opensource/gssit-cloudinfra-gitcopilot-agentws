function Get-WorkshopDemoServiceStatus {
    # ----------------------------------------------------------------------------
    # STARTER FILE — intentionally incomplete. This is YOUR build for L4 Track A.
    # Use Copilot (completions or Chat) to fill in the TODOs below. The goal is a
    # cmdlet that MCPServerPS can expose to your agent as a callable tool.
    #
    # What this cmdlet should do once finished:
    #   - Take a `-Name` parameter restricted to a small allow-list of Windows
    #     service names (default: 'Spooler').
    #   - Call Get-Service for that name and return a small, structured object
    #     with the runtime status, start type, and the time the query ran.
    #
    # Why each piece matters once this becomes an MCP tool:
    #   - Comment-based help (.SYNOPSIS/.DESCRIPTION/.PARAMETER) -> the TOOL DESCRIPTION
    #     the LLM reads to decide WHEN to call it.
    #   - [ValidateSet(...)] on -Name -> the INPUT SCHEMA and the security
    #     boundary. The model can only ask for services you allow.
    # ----------------------------------------------------------------------------

    <#
    .SYNOPSIS
        TODO: One line describing what this returns. The LLM uses this to decide when to call the tool.

    .DESCRIPTION
        TODO: A short paragraph. Mention that it returns the runtime status of a
        Windows service from a short allow-list, and that the data comes from
        Get-Service on the local machine.

    .PARAMETER Name
        TODO: Describe the parameter. It must accept ONLY a small allow-list of
        service names; the default is 'Spooler' (the Print Spooler service).

    .EXAMPLE
        Get-WorkshopDemoServiceStatus
        # Returns the status of the Spooler service (the default).

    .EXAMPLE
        Get-WorkshopDemoServiceStatus -Name wuauserv
    #>
    [CmdletBinding()]
    param(
        # TODO: Add [ValidateSet(...)] with a SHORT allow-list of Windows
        # service names that are reliably present on a workshop laptop. Three
        # good defaults: 'Spooler', 'wuauserv', 'BITS'. Default the parameter
        # to 'Spooler' so the agent can call the tool without naming anything.
        [Parameter()]
        [string]$Name = 'Spooler'
    )

    # TODO: Call Get-Service for $Name (use -ErrorAction Stop so missing
    # services surface as a hard error), then return a small PSCustomObject
    # with the fields the agent should see. Suggested shape:
    #   Name, DisplayName, Status, StartType, QueriedAt (ISO-8601 string).
    throw [System.NotImplementedException]::new('Get-WorkshopDemoServiceStatus is not built yet. Complete the TODOs above.')
}
