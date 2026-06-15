# Track B — Facilitator Notes

Coaching specific to the Azure + Terraform MCP track. For shared/picker-level guidance see [../facilitator-notes.md](../facilitator-notes.md).

---

## The single most important thing

**Make sure every attendee runs `terraform destroy` before L5 starts.** The shared sandbox subscription means orphaned RGs become finance's problem on Monday.

Build a hard checkpoint at minute 23:

> "Track B people — `terraform destroy` now. Drop a ✅ in chat when your RG is gone."

Anyone who hasn't ✅'d by the end of the slot gets a desk visit during the break. If they've already moved their machine to L5 mentally, walk them through `terraform destroy -auto-approve` yourself — it takes 45 seconds.

**Have a sweeper ready.** Before the workshop, write a one-liner that deletes all RGs in the sandbox sub matching `rg-l4-*` that are older than 2 hours. Run it during the M15 break as a safety net:

```powershell
az group list --query "[?starts_with(name, 'rg-l4-')].name" -o tsv |
    ForEach-Object { az group delete --name $_ --yes --no-wait }
```

---

## Track B is genuinely tighter than Track A

25 minutes is honest, not generous. Time pressure points:

| Step | Realistic time | Tightness signal |
|------|----------------|------------------|
| 1. Auth + MCP check | 2-3 min | Anyone who needs to `az login` from scratch slips here. **Pre-flight check at registration.** |
| 2. Plan Mode + scaffold | 4-7 min | If Terraform MCP didn't load, the agent invents arg names. Re-prompt with explicit "Use Terraform MCP" wording. |
| 3. `init` + `apply` | 2-4 min | `init` is the slow bit (provider download). Pre-cache providers on attendee laptops if you control them. |
| 4. Azure MCP inspect | 4-5 min | First tool-call approval surprises people. Tell them up front: "Click Allow on every prompt." |
| 5. KQL query | 4-6 min | AzureActivity may be empty (no sub-level diag setting). Have the Resource Graph fallback ready. |
| 6. Destroy | 1-3 min | Usually fast unless the workspace's soft-delete grace hits. |

**If someone's behind at minute 15:** Have them skip Step 2's "use Terraform MCP" prompt and just copy `solution/main.tf` over their `starter/main.tf`. They lose the Terraform-MCP-wow but save the slot. Steps 4-5 (the Azure-MCP-wow) are the more important payoff anyway.

---

## When Terraform MCP doesn't shine

Track B's pedagogical bet is that Plan Mode + Terraform MCP produces *better* Terraform than the LLM alone. That's mostly true but not bulletproof:

- **The `azurerm` provider is well-documented in LLM training data.** A no-MCP scaffold will *also* produce working code. Don't oversell the MCP value here.
- **Where Terraform MCP genuinely wins:** new provider versions, less-common resources, validating that an argument actually exists in the current version, and querying the registry for module suggestions.
- **What to say:** "Terraform MCP is a *fact-checker*. The model still writes the code; MCP confirms the arguments are real."

---

## Common failures specific to Track B

| Symptom | Cause | What to do |
|---------|-------|-----------|
| `terraform apply` says "AuthorizationFailed" | Sandbox sub doesn't grant Contributor at sub scope, only at an RG-scope or MG-scope | Pre-create RGs and grant Contributor on each. Update the lab to skip the RG-create resource and use a data source instead. |
| `Microsoft.OperationalInsights` not registered | Fresh sub, no LAW ever created | One-time: `az provider register --namespace Microsoft.OperationalInsights` |
| Plan Mode wrote Bicep instead of Terraform | Attendee's prompt was ambiguous | Re-prompt: "**Terraform** HCL, not Bicep, using `azurerm_resource_group`" |
| Agent says "I cannot run Terraform commands" | Confusion between IDE terminal and agent tools | Clarify: Terraform CLI runs in the **integrated terminal**. The agent helps you *write* the code, not execute the CLI. |
| Azure MCP returns "no subscriptions found" | Azure MCP authenticates separately from Azure CLI in some configs | Have the attendee re-check Azure MCP's auth — usually a `DefaultAzureCredential` chain. `az login` first, then restart the MCP server. |
| KQL query returns instantly but with zero rows | AzureActivity isn't piped into a fresh LAW by default | Pivot to Resource Graph: "Use Azure MCP's Resource Graph tool to list resources in `<rg-name>`." Same lesson, different surface. |

---

## The DrawIO MCP bonus

Don't gate the bonus on "everyone finishes Steps 1-6 first." Let fast attendees jump on it as soon as they've destroyed their RG (no point holding the diagram off — they've already deleted the resources). The diagram is conceptual, not live.

If `npx @drawio/mcp` is slow on first run (downloading the package), warn them — it's ~10 seconds the first time, instant after.

The DrawIO bonus is the strongest "look, same protocol, different output" moment in the whole workshop. Make sure at least one attendee demos theirs at the L4 debrief.

---

## Bridging to L5

Both tracks land at: *the agent called something you built.* The Track-B-specific bridge:

> "L5 ships an agent persona that calls *multiple* tools to produce a real artifact. Track B today wired two MCPs (Terraform + Azure) but used them separately. L5 stitches that pattern into a workflow."

If your attendees were mostly Track B, lean into the IaC angle for L5 — the ADR generator capstone produces architecture documentation, which pairs naturally with the infra they just deployed.

---

## When to drop Track B from a future workshop

Track B has more fragility surface than Track A. Don't run it if:

- Sandbox sub access isn't confirmed for **every** registered attendee 24h before the workshop
- The room doesn't have reliable internet (Terraform provider download + Azure API)
- Facilitators aren't comfortable with `az` / `terraform` troubleshooting

If any of those are uncertain, run Track A only. The lesson lands either way.
