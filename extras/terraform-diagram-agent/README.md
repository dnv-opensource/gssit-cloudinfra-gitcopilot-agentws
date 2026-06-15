# Diagram-from-IaC agents (take-home extras)

Two drop-in **custom Copilot agents** that render draw.io diagrams from
different sources — your Terraform code, or your live Azure resources —
using the same configurable visual style guide. Run either, or run both and
diff for drift detection.

> **This is a bonus, not a workshop lab.** It reinforces what [L4 — Custom Agent
> & MCP Integration](../../labs/L4-custom-agent-mcp/README.md) teaches
> (a custom `.agent.md` persona + an MCP tool server) on a different surface:
> diagram generation instead of infra deployment. Take it home, customise it,
> adopt it on your real repos.

Inspired by Brian Veldman's
[*Automating Azure diagrams from Bicep using GitHub Copilot CLI Custom agents*](https://cloudtips.nl/automating-azure-diagrams-from-bicep-using-github-copilot-cli-custom-agents-%EF%B8%8F-5812005899a6).
We adapt his pattern for **Terraform** (DNV's primary IaC), add a
**parallel Azure-cloud agent**, and standardise on the
**official draw.io MCP server** ([jgraph/drawio-mcp](https://github.com/jgraph/drawio-mcp)).

> Folder is still named `terraform-diagram-agent/` for historical / link-stability
> reasons. It now hosts both agents.

---

## What's in here

```
extras/terraform-diagram-agent/
├── .github/agents/
│   ├── terraform-to-drawio.agent.md    # diagram FROM HCL (the architecture you intended)
│   └── azure-to-drawio.agent.md        # diagram FROM live Azure (the architecture you got)
├── .vscode/
│   └── mcp.json                        # wires the official draw.io MCP tool server
├── sample/
│   └── main.tf                         # multi-tier Terraform fixture to diagram
└── README.md                           # you are here
```

---

## Which agent do I pick?

| Question | Pick |
|---|---|
| *"What architecture did this PR declare?"* | **terraform-to-drawio** |
| *"What's actually deployed in `rg-app-prod` right now?"* | **azure-to-drawio** |
| *"Has anyone clicked things in the portal that aren't in Terraform?"* | **Both** — render each, eyeball the diff |
| You don't have an Azure sub but want to learn the pattern | **terraform-to-drawio** (sample/main.tf works offline) |

Each agent has a single source of truth (HCL **or** cloud — never mixed).
That's deliberate: it keeps the two diagrams independent, so the diff
between them is meaningful.

---

## Prerequisites

**For `terraform-to-drawio` (always required):**
- VS Code 1.97+ with **GitHub Copilot in agent mode**, signed in
- **Node.js 18+** (`node --version`) — needed for `npx @drawio/mcp`
- A browser (the diagrams open in a new tab via draw.io)

**Additionally for `azure-to-drawio` (optional, only if you want the
cloud-state agent):**
- **Azure CLI** signed in (`az login`) against the subscription you want to diagram
- **Azure MCP** — install the [Azure MCP Server VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azure-mcp-server) (publisher `ms-azuretools`). Covers resource-level queries within a subscription.
- **Azure Resource Manager MCP Server** — required for management-group / tenant-level diagrams (Azure MCP alone doesn't expose those). One-click install: <https://aka.ms/JoinARMMCP> (opens VS Code, prompts for Azure sign-in). See the [Azure/Azure-Resource-Manager-MCP](https://github.com/Azure/Azure-Resource-Manager-MCP) repo for the full tool list.

No Terraform CLI needed for either walkthrough — the Terraform agent only
**reads** HCL, it doesn't run it. The Azure agent only **queries**, it doesn't
mutate. Bring your own repo / subscription when you adopt it for real.

---

## Which draw.io MCP variant we use, and why

[jgraph/drawio-mcp](https://github.com/jgraph/drawio-mcp) ships **four**
integration paths. We use the **MCP Tool Server** (`@drawio/mcp` on npm):

| Variant              | Where the diagram appears   | Workshop fit |
| -------------------- | --------------------------- | ------------ |
| **MCP Tool Server** ✅ | Opens in a new draw.io browser tab | Works with any MCP-compatible client today, including VS Code Copilot. `npx`, no install. |
| MCP App Server       | Inline in chat (iframe)     | Requires the MCP **Apps** extension on the host. Not consistently supported in VS Code Copilot yet — revisit later. |
| Skill + CLI          | Local `.drawio` file        | Claude Code only. |
| Project instructions | URL via Python              | Claude.ai Projects only. |

If your host adds MCP Apps support, swap the `npx @drawio/mcp` line in
`.vscode/mcp.json` for the hosted MCP App Server (`https://mcp.draw.io`) to
get inline rendering.

---

## Quick start

1. **Open this folder as a workspace** in VS Code:
   `File → Open Folder…` → select `extras/terraform-diagram-agent/`.

   > ⚠️ **Same gotcha as L4 Track B:** `.vscode/mcp.json` is read from the
   > folder you open as the workspace. Opening the repo root means the
   > root-level MCP config wins and ours doesn't load.

2. **Start the draw.io MCP server.** VS Code shows a **Start** code-lens above
   the `"servers"` block in `.vscode/mcp.json`. Click it, or run
   Command Palette → **MCP: List Servers** → start `drawio`. The first launch
   downloads `@drawio/mcp` via `npx` (~5 s on a warm cache).

3. **Open the custom agent.** Open the Copilot chat, click the agent picker,
   pick **`terraform-to-drawio`** (or **`azure-to-drawio`** if you wired Azure
   MCP and want the live-cloud diagram). Both files auto-discover from
   `.github/agents/`.

4. **Ask for a diagram:**

   ```
   # Terraform agent
   Diagram the Terraform in ./sample.

   # Azure agent
   Diagram everything in resource group rg-app-prod.
   ```

   The agent inventories its source (`.tf` files for the Terraform agent,
   Azure REST for the Azure agent), looks up shapes via the MCP `search_shapes`
   tool, and renders one diagram via `create_diagram`. A draw.io tab opens
   with the result.

5. **Customise the style.** Edit the agent's `.agent.md` file — swap the
   "Workshop default" palette table for the "DNV-style" block (or write your
   own), tweak typography or layout rules. Ask the agent for the diagram
   again. **Keep the two agents' palettes in sync** if you plan to use them
   for drift diffs.

---

## Bring your own input

Neither agent has hardcoded knowledge of the sample. Point them at anything:

```
# Terraform agent
Diagram the Terraform in C:\repos\my-platform\environments\prod.
Group by module. Use the DNV palette.

# Azure agent
Diagram subscription "Demo", every resource group prefixed rg-app-.
Flag untagged resources with a red border.
```

The Terraform agent works on `aws_*` and `google_*` resources too — it
classifies by provider prefix and pulls the matching shape library via
`search_shapes`. The Azure agent is Azure-only (it talks to Azure MCP).

---

## Two agents, two sources of truth

`terraform-to-drawio` diagrams your **Terraform configuration** — the resources
you've *declared in code*. Good for:

- Reviewing a PR before merge ("does this match the intended architecture?")
- Onboarding ("explain this module's shape without making me read 600 lines of HCL")
- Documenting intent in an ADR

`azure-to-drawio` diagrams your **live Azure subscription** — the resources
you've *actually got*. Good for:

- Post-incident audits ("what was actually in that RG when it broke?")
- Drift detection ("which resources don't have `managed-by=terraform`?")
- Compliance snapshots (the diagram is the evidence)

### Drift detection as a diff

Run both agents on the same target. Save both `.drawio` files. The visual
diff between them **is** your drift report:

| In Terraform diagram only  | Planned but not deployed (failed apply, partial state) |
| In Azure diagram only      | Drift — created out-of-band (portal click, another team, manual fix) |
| In both, different shape   | Same resource, configuration drift (SKU, region, tier) |

You can also prompt `azure-to-drawio` directly:

> Diagram resource group `rg-app-prod`. Flag any resource whose tags don't
> include `managed-by=terraform` with a red border.

Same draw.io MCP, different upstream source. That's the pedagogical payoff of
the workshop's MCP chapter in one picture: **the agent doesn't care where the
input came from, only that it's structured data**.

---

## Customisation ideas (steal these)

Things attendees have asked for in past sessions:

- **Per-environment swimlanes.** Add a layout rule: *"Group resources by the
  `environment` tag into vertical swimlanes (dev | test | prod)."*
- **Severity colours for security findings.** Pair this agent with a static
  analysis pass (`tfsec`, `checkov`) and colour the offending nodes red.
- **Sub-diagrams per module.** Tell the agent: *"Emit one diagram per top-level
  module instead of one combined diagram."*
- **Corporate icon set.** Replace shape lookups with internal icon library
  URLs — drop a `corporate-shape-map.md` in the agent folder and reference it
  from the agent prompt.
- **Run on CI.** Wire `@drawio/mcp` into a GitHub Action that re-renders the
  diagram on every Terraform PR and posts the draw.io URL as a comment.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
| ------- | ------------ | --- |
| Agent doesn't appear in the picker | Workspace not opened at `extras/terraform-diagram-agent/` (so `.github/agents/` isn't discovered) | Re-open the folder directly. |
| Agent says *"I can't read files / no file or terminal tool"* | The `tools:` line in `.agent.md` opts out of built-in tools unless you list them. | Make sure the frontmatter includes the built-ins you need alongside MCP tools, e.g. `tools: execute, read, edit, search, 'drawio/*'`. Reload the chat after editing. |
| `drawio` MCP server shows "failed" | Node.js missing or behind a proxy that blocks npm | `node --version`; if behind a corporate proxy, set `npm_config_proxy` before launching VS Code. |
| Agent draws generic rectangles for everything | `search_shapes` returning no matches (firewall, offline) | Check the MCP server log; confirm `npx @drawio/mcp` runs cleanly from a terminal. |
| Diagram opens but is empty | Terraform directory contains only `provider`/`terraform` blocks (no resources) | Point it at a directory with actual `resource` declarations. |
| `azure-to-drawio` says it can't see any resources | Not signed in, wrong subscription, or Azure MCP extension not installed | `az login`; check `az account show`; install the Azure MCP Server extension (`ms-azuretools.vscode-azure-mcp-server`). |
| `azure-to-drawio` says it can't find management groups / tenant structure | Azure MCP only exposes resource-level tools — it does **not** include MG enumeration. | Install the **Azure Resource Manager MCP Server** as well: <https://aka.ms/JoinARMMCP> (one-click VS Code install + Azure sign-in). The agent uses its `execute_query` / `validate_query` for tenant-wide Azure Resource Graph queries. |
| Drift diff looks noisy — every resource flagged | Tag convention mismatch between Terraform and the prompt | Confirm the exact tag key/value Terraform writes (e.g. `managed_by` vs `managed-by`); update the agent prompt to match. |
| Wrong palette applied | Agent file edited but chat is using a cached persona | Start a fresh Copilot chat session — the agent file is read at chat start. |

---

## Where this fits in the workshop

- **L4 Track A** taught you to ship *your own* MCP server in PowerShell.
- **L4 Track B** taught you to chain two production MCP servers (Terraform +
  Azure) for live infra.
- **This extra** shows the same pattern on a *third* surface — diagrams — and
  pushes it one step further: **two agents, two sources of truth, one shared
  style guide**. The `.agent.md` file is itself the deliverable — a tweak-it,
  commit-it, share-it artifact your team can adopt.

See also: [M12-A Cloud MCP](../../presentations/M12A-cloud-mcp-drawio.html)
covers the broader DrawIO + cloud-MCP story.
