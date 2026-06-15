# L4 — Custom Agent Config & MCP Integration

**Format:** Build lab (you ship a tool the agent can call)
**Core time:** 25 minutes · **Stretch:** optional +10–15 minutes
**Goal:** Watch your *own* work get called by an agent — either as a hand-built PowerShell cmdlet or as live Azure infrastructure.

L4 ships in **two tracks**. Pick **one** at the start of the slot. You will not have time for both in the live workshop.

---

## 🎯 Pick your track

| | **Track A — PowerShell MCP** | **Track B — Azure + Terraform MCP** |
|---|---|---|
| **You build** | A PowerShell cmdlet exposed as an MCP tool | A real Azure Log Analytics workspace, provisioned via Terraform |
| **MCP servers in play** | MCPServerPS (your own server) | Terraform MCP **+** Azure MCP |
| **The "wow moment"** | Your cmdlet fires from a scoped agent | Agent runs a KQL query against infra **you** just deployed |
| **Pick if you…** | …work in PowerShell, want to learn how to ship tools to Copilot | …work in cloud / IaC, want to see Terraform-MCP + Azure-MCP end-to-end |
| **Needs** | MCPServerPS module | Terraform CLI, Azure CLI, **sandbox Azure subscription** |
| **Bonus (if time)** | Add one more service to the `[ValidateSet]` allow-list | Add **DrawIO MCP** to render a diagram of the RG you just deployed |
| **Hard dependency risk** | MCP server doesn't load after reload (usually a wrong absolute path in `.vscode/mcp.json`) | Sandbox-sub permissions insufficient for `terraform apply` (e.g. can't create RG at sub scope) |
| **Cleanup at end** | None (local only) | **Mandatory `terraform destroy`** (shared sub hygiene) |
| **Walkthrough** | **[track-a-powershell-mcp/README.md](./track-a-powershell-mcp/README.md)** | **[track-b-azure-terraform/README.md](./track-b-azure-terraform/README.md)** |

> **Facilitator default:** if you have no preference, pick Track A. It has fewer moving parts and matches the M12-B InfraOps demo you just watched. Track B is the better choice if you came specifically for Azure + Terraform agent workflows.

---

## ✅ Shared prerequisites (both tracks)

Before the slot starts, confirm:

- [ ] **PowerShell 7** running (`pwsh --version`)
- [ ] **VS Code 1.124+** with GitHub Copilot in **agent mode**, signed in
- [ ] **Both Plan Mode and Agent Mode** visible in the chat mode picker

Track-specific prereqs are in each track's README. Full setup with install commands lives in [prerequisites.md](../../prerequisites.md).

---

## 🧠 What both tracks teach

> **A tool is just an interface — and the LLM only calls what you let it.**

Whether the tool is your PowerShell function (Track A) or an Azure resource query (Track B), the lesson is the same:

- **You** decide what's callable (the MCP server's tool list).
- **The LLM** decides when to call (driven by your prompt + the agent's persona).
- **Schema is the security boundary.** `[ValidateSet]` in PowerShell or `azurerm` argument names in Terraform — the model can only ask for values you allowed.

---

## 🚨 Common issues (both tracks)

| Issue | Where to look |
|-------|---------------|
| MCP servers don't appear after reload | Track-specific README → troubleshooting section |
| Agent can't see your tool | Tool-name format: `{ServerName}/{Tool_Name}` — match server casing exactly |
| Window reload didn't help | Re-open the workspace at the correct folder (each track's README says which) |

---

## 📖 Reference

- **Top-level entry-point doc:** [../L4-custom-agent-mcp.md](../L4-custom-agent-mcp.md)
- **Facilitator notes (shared):** [facilitator-notes.md](./facilitator-notes.md)
- **Track A facilitator notes:** [track-a-powershell-mcp/solution/facilitator-notes.md](./track-a-powershell-mcp/solution/facilitator-notes.md)
- **Track B facilitator notes:** [track-b-azure-terraform/facilitator-notes.md](./track-b-azure-terraform/facilitator-notes.md)
- **Theory:** [M12-A Cloud MCP](../../presentations/M12A-cloud-mcp-drawio.html) (Azure/Terraform context for Track B) · [M12-B PowerShell + DrawIO](../../presentations/M12B-mcp-powershell-drawio.html) (PowerShell MCP context for Track A)

---

**Pick your track and go.** Both end with *your* work called by an agent — that's the point.
