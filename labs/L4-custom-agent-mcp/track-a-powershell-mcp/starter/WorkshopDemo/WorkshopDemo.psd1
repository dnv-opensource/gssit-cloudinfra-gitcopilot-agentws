@{
    RootModule        = 'WorkshopDemo.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = 'b1e7c9d2-3f44-4a6b-9c10-2e5d8f0a1b22'
    Author            = 'DNV Copilot + Agents Workshop attendee'
    CompanyName       = 'DNV Copilot + Agents Workshop'
    Description       = 'A tiny demo module exposed to Copilot as MCP tools via MCPServerPS. You are building this.'
    PowerShellVersion = '7.2'

    # TODO: After you finish your cmdlet in Public/Get-WorkshopDemoServiceStatus.ps1, list it here so it is exported.
    FunctionsToExport = @(
        # 'Get-WorkshopDemoServiceStatus'
    )
    CmdletsToExport   = @()
    AliasesToExport   = @()
    VariablesToExport = @()

    PrivateData       = @{
        PSData = @{
            Tags = @('mcp', 'mcpserverps', 'workshop', 'demo')
        }
    }
}
