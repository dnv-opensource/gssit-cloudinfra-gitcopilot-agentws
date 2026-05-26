---
name: azure-automation-runbook
description: |
  Author Azure Automation PowerShell runbooks that follow Microsoft's current
  conventions: Az modules (not AzureRM), Managed Identity authentication,
  idempotent operations, structured output, and the metadata header the portal
  expects. Use this skill whenever a user asks for an Azure Automation
  runbook, a scheduled Azure task, or "code that runs in Azure Automation".
domain: azure-automation
confidence: high
source: earned
tools: []
---

## Context

Apply this skill whenever the user wants a runbook for Azure Automation. The
runbook will be deployed into an Automation Account and (likely) attached to a
schedule or webhook trigger. The user will deploy it as-is — so it must be
shape-correct out of the gate.

## Patterns

- **Import only the `Az.*` modules you actually need** with explicit version
  pins in the runbook header. Never `AzureRM.*` (deprecated 2024).
- **Authenticate via Managed Identity** unless the user explicitly says
  otherwise: `Connect-AzAccount -Identity -AccountId <client-id-if-user-assigned>
  | Out-Null`. For system-assigned MI, omit `-AccountId`.
- **Set the subscription explicitly:** `Set-AzContext -SubscriptionId
  $SubscriptionId | Out-Null`. Pass `$SubscriptionId` as a runbook parameter,
  never hardcode.
- **Use `[CmdletBinding()]` + typed parameters** with defaults pulled from
  Automation variables when sensible. Example:
  `[Parameter(Mandatory)][string]$SubscriptionId,`
  `[Parameter()][int]$LookbackHours = (Get-AutomationVariable -Name InfraOpsLookbackHours -ErrorAction SilentlyContinue ?? 24)`.
- **Structured output for downstream consumption.** Emit `[pscustomobject]`s,
  not formatted strings. The runbook's job output is JSON-friendly.
- **Always wrap the body in `try/catch`** and re-throw with context so the
  Automation job status reflects the failure.
- **Idempotent by default.** A runbook may be retried; design for that.
- **Header comment block** with `.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`,
  `.NOTES` (includes "Last reviewed", "Author", "Tags"). The Azure portal reads
  this.

## Examples

Header block:

```powershell
<#
.SYNOPSIS
    Daily InfraOps health check.

.DESCRIPTION
    Queries Get-InfraArcServiceStatus for a fixed set of services across
    allow-listed hosts and posts a summary to a Teams webhook.

.PARAMETER SubscriptionId
    Subscription containing the Arc-enabled VMs.

.PARAMETER TeamsWebhookUri
    Incoming webhook URL for the destination Teams channel.

.NOTES
    Author: <team>
    Last reviewed: <date>
    Tags: infraops, daily, observability
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$SubscriptionId,
    [Parameter(Mandatory)][string]$TeamsWebhookUri,
    [Parameter()][int]$LookbackHours = 24
)

#Requires -Modules @{ ModuleName='Az.Accounts'; ModuleVersion='3.0.0' }
```

## Anti-patterns

- Never use `Login-AzureRmAccount` or any `AzureRM.*` cmdlet.
- Never use a stored credential when MI is available.
- Never `Write-Host` — Automation job log captures the success/output streams;
  `Write-Host` bypasses both.
- Never assume any module beyond `Az.Accounts` is pre-imported. List what you
  need in a `#Requires` block.
- Never hardcode subscription IDs, resource group names, or workspace IDs in
  the runbook body — they should be parameters or Automation variables.
