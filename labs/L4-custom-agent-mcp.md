# L4: Custom Agent Config & MCP Integration

**Day 2 · 16:40–17:05 (25 minutes core; optional bonus +10 minutes)**

> Watch your *own* work get called by an agent. Pick **one** of two tracks at the start of the slot — either ship a PowerShell tool, or deploy real Azure infrastructure and query it through an agent.

---

## 🎯 Pick your track

L4 runs as **two parallel tracks**. You do **one**, not both. Pick at the start of the slot.

| | **Track A — PowerShell MCP** *(default)* | **Track B — Azure + Terraform MCP** |
|---|---|---|
| **You build** | A PowerShell cmdlet exposed as an MCP tool | A real Log Analytics workspace, deployed via Terraform |
| **MCPs in play** | MCPServerPS (your own server) | Terraform MCP + Azure MCP (+ DrawIO MCP for bonus) |
| **The wow moment** | Your cmdlet fires from a scoped agent | Agent runs KQL against infra **you** just deployed |
| **Pick if you…** | …work in PowerShell, want to ship tools to Copilot | …work in cloud / IaC, want Terraform-MCP + Azure-MCP end-to-end |
| **Extra prereqs** | MCPServerPS module | Terraform CLI, Azure CLI, **sandbox sub access** |
| **Cleanup** | None (local only) | **Mandatory `terraform destroy`** (shared sub hygiene) |

> **No preference? Pick Track A.** Fewer moving parts, matches the M12-B InfraOps demo you just watched. Track B is the right choice if you came specifically for Azure or Terraform agent workflows.

➡️ **Pick a track and open its walkthrough:**

- 🅰️ **[Track A — PowerShell MCP](./L4-custom-agent-mcp/track-a-powershell-mcp/README.md)**
- 🅱️ **[Track B — Azure + Terraform MCP](./L4-custom-agent-mcp/track-b-azure-terraform/README.md)**

The [parent picker README](./L4-custom-agent-mcp/README.md) has a more detailed comparison and shared prerequisites if you want to read both before deciding.

---

## ✅ Shared prerequisites (both tracks)

Before the slot starts, confirm:

- [ ] **PowerShell 7** running (`pwsh --version`)
- [ ] **VS Code 1.124+** with GitHub Copilot signed in
- [ ] **Both Plan Mode and Agent Mode** visible in the chat mode picker

Track-specific prereqs (MCPServerPS for A; Terraform/Azure CLI + sandbox sub for B) are listed in each track's README. Full install instructions: [prerequisites.md](../prerequisites.md).

---

## 🧠 What both tracks teach

> **A tool is just an interface — and the LLM only calls what you let it.**

Whether the "tool" is your PowerShell function (Track A) or an Azure resource query (Track B), the lesson is the same:

- **You** decide what's callable (the MCP server's tool list).
- **The LLM** decides when to call (driven by your prompt + the agent persona).
- **Schema is the security boundary.** `[ValidateSet]` in PowerShell or `azurerm` argument names in Terraform — the model can only ask for values you allowed.

---

## 🎁 What You'll Have After L4

- ✅ A working MCP integration you built (either a PowerShell server *or* real Azure infra queried by an agent)
- ✅ A live demo of *you-decide-what-is-callable* — schema rejection in A, RBAC + Terraform resource block in B
- ✅ The intuition you'll need for L5 (which stitches multiple MCP tools into a workflow)

---

## 🚨 Troubleshooting

Track-specific troubleshooting tables live in each track's README. For the most common cross-track failure — "MCP servers don't show up after reload" — confirm the `.vscode/mcp.json` file is in the workspace VS Code actually opened, then **Developer: Reload Window**.

**Still stuck?** Raise your hand. Each track has a `solution/` folder you (or the facilitator) can fall back to.

---

## 📖 Reference

- **Pick-a-track parent README:** [L4-custom-agent-mcp/README.md](./L4-custom-agent-mcp/README.md)
- **Shared facilitator notes:** [L4-custom-agent-mcp/facilitator-notes.md](./L4-custom-agent-mcp/facilitator-notes.md)
- **Workshop README:** [README.md](../README.md)
- **Prerequisites Setup:** [prerequisites.md](../prerequisites.md)
- **MCPServerPS (Track A):** https://github.com/daxian-dbw/MCPServerPS (by Dongbo Wang, PowerShell team — currently an incubation project)
- **Terraform MCP (Track B):** https://github.com/hashicorp/terraform-mcp-server
- **Azure MCP (Track B):** https://github.com/Azure/azure-mcp
- **DrawIO MCP (Track B bonus):** `npx @drawio/mcp` (official [jgraph/drawio-mcp](https://github.com/jgraph/drawio-mcp))
- **Take-home extra:** [extras/terraform-diagram-agent/](../extras/terraform-diagram-agent/) — reusable Terraform-to-diagram custom agent with editable style guide
- **Theory:** [M12-A Cloud MCP](../presentations/M12A-cloud-mcp-drawio.html) · [M12-B PowerShell + DrawIO](../presentations/M12B-mcp-powershell-drawio.html)

---

## 💬 Questions?

- **During the lab:** Ask in Teams chat or raise your hand
- **Before the workshop:** Email Jan Egil Ring or Haflidi Fridthjofsson

---

**Pick your track and go. Both end with *your* work called by an agent — that's the point.** 🚀
