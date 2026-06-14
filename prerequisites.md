# Prerequisites — Setup for Workshop Attendees

**Time estimate:** 20–30 minutes
**Target OS:** Windows 11
**All tools installable via winget** (Windows Package Manager)

---

## 📋 Pre-Workshop Checklist

Before the workshop, ensure you have:

- [ ] **Windows 11** (or latest Windows with winget available)
- [ ] **GitHub account** with an active **GitHub Copilot license**
- [ ] **Node.js LTS** (required for GitHub Copilot CLI)
- [ ] **VS Code 1.124 or later** with GitHub Copilot extension (L3 Round 1 uses **Plan Mode**, and Autopilot-on-by-default behavior is from this release)
- [ ] **PowerShell 7+** (for command-line labs)
- [ ] **Pester 5+** PowerShell module (required for L3 — Agent Mode generates Pester-based tests; pwsh 7 does not ship with Pester)
- [ ] **Git** (for cloning repos)
- [ ] **GitHub CLI** (for authentication and code operations)
- [ ] **GitHub Copilot CLI** (installed as GitHub CLI extension)
- [ ] **Basic internet connectivity** (no proxy/firewall blocks to GitHub Copilot endpoints)

Estimated total setup time: **20–30 minutes**.

---

## 🛠️ Installation Guide

### 1. Verify Windows & winget

Open **PowerShell** and check your setup:

```powershell
# Check Windows version (should be 11 or later)
[System.Environment]::OSVersion.Version

# Check if winget is available
winget --version
```

If `winget` is not available, [install Windows Package Manager](https://learn.microsoft.com/windows/package-manager/winget/).

---

### 2. Install Node.js LTS

**⚠️ Important:** The GitHub Copilot CLI requires Node.js. Install it first.

```powershell
winget install --id OpenJS.NodeJS.LTS --exact
```

Verify:

```powershell
node --version
npm --version
```

You should see versions for both `node` and `npm`. If the versions don't display, **close and reopen your PowerShell terminal** to refresh the PATH.

---

### 3. Install VS Code

```powershell
winget install --id Microsoft.VisualStudioCode --exact
code --install-extension GitHub.copilot-chat
```

After installation, open VS Code and verify it launches without errors. **Required version: 1.124 or later** (released June 10, 2026). Check with:

```powershell
code --version
```

The first line of output is the version. If it shows an older version, run `winget upgrade --id Microsoft.VisualStudioCode --exact` (or click the **⚙ → Check for Updates** menu inside VS Code).

---

### 4. Install PowerShell 7

```powershell
winget install --id Microsoft.PowerShell --exact
```

Launch PowerShell 7:

```powershell
pwsh
```

You should see a prompt like `PS C:\>`. Verify version:

```powershell
$PSVersionTable.PSVersion
```

Should show version **7.x** or later.

---

### 5. Install Git

```powershell
winget install --id Git.Git --exact
```

Verify:

```powershell
git --version
```

---

### 6. Install GitHub CLI

```powershell
winget install --id GitHub.cli --exact --scope user
```

> Should you experience issues with the installation due to that an UAC-prompt (rather than a BeyondTrust-prompt) requires you to specify a user with local admin rights (instead of just performing elevation through BeyondTrust utilizing the *Flex*-profile for your user on your machine), then please just download the MSI (see link under the [winget install fails or times out](#winget-install-fails-or-times-out) heading later in this document) and run it manually by double-clicking on it (this would allow BeyondTrust to detect the Windows Installer requires elevation and then prompt for that).

Verify:

```powershell
gh --version
```

---

### 7. Authenticate GitHub CLI

```powershell
gh auth login
```

Follow the prompts:
- **What is your preferred protocol for Git operations?** → Choose `HTTPS` (or `SSH` if you prefer)
- **Authenticate Git with GitHub credentials?** → `Y`
- **How would you like to authenticate GitHub CLI?** → Choose `Login with a web browser`
- A browser window will open — authorize the GitHub CLI app
- Return to PowerShell; you should see **"Logged in as [your-username]"**

Verify:

```powershell
gh auth status
```

---

### 8. Verify GitHub Copilot CLI is Ready

The Copilot CLI uses your authenticated GitHub CLI session. Verify authentication:

```powershell
gh auth status
```

You should see your GitHub username and authentication status. To confirm Copilot is working end-to-end:

```powershell
gh copilot -i "explain git status"
```

You can try allowing Copilot to use powershell to help you list the files in your directory:

```powershell
gh copilot -i "list files in current directory using PowerShell" --allow-tool powershell
```

If you see a response explaining the command, **Copilot CLI is working!**

---

## 🚀 Verify Your Setup

Run these commands to confirm everything is installed and working. **Use PowerShell 7 (`pwsh`) for all commands.**

```powershell
# 1. Check Windows version
Write-Host "=== Windows Version ===" -ForegroundColor Green
Get-ComputerInfo | Select-Object OSName

# 2. Check VS Code (require 1.124+)
Write-Host "`n=== VS Code ===" -ForegroundColor Green
code --version
# First line is the version; must be 1.124 or later (L3 Round 1 uses Plan Mode introduced in 1.124).

# 3. Check PowerShell version (we recommend at least version 7.4)
Write-Host "`n=== PowerShell ===" -ForegroundColor Green
$PSVersionTable.PSVersion

# 4. Check Git
Write-Host "`n=== Git ===" -ForegroundColor Green
git --version

# 5. Check GitHub CLI
Write-Host "`n=== GitHub CLI ===" -ForegroundColor Green
gh --version
gh auth status

# 6. Check GitHub Copilot CLI extension and verify it works
Write-Host "`n=== GitHub Copilot CLI ===" -ForegroundColor Green
gh copilot -i "explain git status"
```

**Expected output:** All tools should report their versions. GitHub auth should show your username. Copilot explain should return a response.

---

## 📂 Clone the Workshop Repository

Once authenticated, clone the workshop repository to your local machine:

```powershell
# Create a directory for the workshop (optional)
mkdir $env:USERPROFILE\Documents\workshop
cd $env:USERPROFILE\Documents\workshop

# Clone the workshop repository
git clone https://github.com/dnv-opensource/gssit-cloudinfra-gitcopilot-agentws.git

# Navigate to the repo
cd gssit-cloudinfra-gitcopilot-agentws

# Verify (you should see files in the repo)
ls
```

---

## 🧪 Quick Lab Test (Optional)

To test that GitHub Copilot is working, try a quick autocomplete in VS Code:

1. Open VS Code: `code`
2. Create a new file: `Ctrl+N`
3. Type this comment:
   ```powershell
   # Write a function that reverses a string
   ```
4. Press `Enter` and wait a moment
5. You should see a GitHub Copilot suggestion below the comment (look for the Copilot icon)
6. Press `Tab` or `Ctrl+Enter` to accept a suggestion

If you see suggestions, **Copilot is working!**

---

## 🆘 Troubleshooting

### "VS Code doesn't have the Copilot Chat extension"

1. Open VS Code
2. Press `Ctrl+Shift+X` (Extensions)
3. Search for **"GitHub Copilot Chat"** (by GitHub)
4. Click **Install**
5. After install, you may be prompted to sign in — follow the browser flow
6. Restart VS Code

---

### "Git authentication fails"

```powershell
# Clear cached credentials
gh auth logout

# Re-authenticate
gh auth login
```

Follow the prompts again, choosing `HTTPS` or `SSH` as your preference.

---

### "GitHub Copilot CLI installer fails: npm is not available"

**Symptom:**
```
Install GitHub Copilot CLI? (y/N): y
npm is not available or installation failed. Trying winget...
Cannot find GitHub Copilot CLI (https://docs.github.com/en/copilot/how-tos/set-up/inst...)
```

**Cause:** Node.js / npm is not installed or not in your PATH.

**Fix (Windows):**
```powershell
# Install Node.js LTS
winget install OpenJS.NodeJS.LTS

# Close and reopen your PowerShell terminal to refresh the PATH
# Then verify Node.js is available
node --version
npm --version

# Re-run the Copilot CLI installer
gh copilot -i "test"
```

**Fix (macOS):**
```bash
brew install node
```

**Fix (Linux):**
Use your package manager (e.g., `apt-get install nodejs`, `yum install nodejs`, or `nvm install node`).

---

### "GitHub Copilot CLI says I'm not authenticated"

The Copilot CLI uses your GitHub CLI authentication. Re-authenticate GitHub CLI:

```powershell
gh auth logout
gh auth login
```

Follow the prompts again. Then verify Copilot can connect:

```powershell
gh copilot explain "git status"
```

---

### "winget install fails or times out"

Try installing with the full package name and source:

```powershell
winget search "PowerShell"
winget install Microsoft.PowerShell --source winget
```

Or install manually:
- **VS Code:** https://code.visualstudio.com/
- **PowerShell 7:** https://github.com/PowerShell/PowerShell/releases
- **Git:** https://git-scm.com/download/win
- **GitHub CLI:** https://cli.github.com/

---

### "Cannot connect to GitHub Copilot (firewall/proxy)"

**Note:** GitHub Copilot requires outbound HTTPS access to GitHub endpoints. If you're behind a corporate proxy or firewall:

1. Contact your IT department and confirm GitHub Copilot traffic is allowed
2. Required endpoints: `*.github.com`, `*.copilot.github.com`
3. If using a proxy, configure Git to use it:
   ```powershell
   git config --global http.proxy [your-proxy-url]
   ```

---

## ✅ Ready to Go!

Once you've completed all steps and verified your setup, you're ready for the workshop!

**Quick summary:**
- ✅ Windows 11 with WinGet
- ✅ VS Code with GitHub Copilot extension
- ✅ PowerShell 7
- ✅ Git and GitHub CLI (authenticated)
- ✅ GitHub Copilot CLI extension (authenticated)
- ✅ Workshop repository cloned

**Day-of checklist (May 26):**
- Restart your machine (clean state)
- Open VS Code and verify Copilot is active
- Test `gh auth status` (shows your username)
- Test `gh copilot explain "git status"` (shows Copilot is responding)
- Join Teams 5 minutes early

---

## 📞 Having Issues?

If you encounter problems during setup:

1. **Check this guide** — Common issues are in the Troubleshooting section above
2. **Review verification steps** — Run the verification script to narrow down the issue
3. **Contact the facilitators** — Email Jan Egil Ring or Haflidi Fridthjofsson with:
   - Your error message
   - Output of the verification script
   - Your OS and tool versions

We will also do a **technical soundcheck** on May 26 at 13:45 (15 min before start) in Teams.

---

## Day 2 Additions (June 15)

**Day 2 introduces new hands-on modules:** Agent Mode deep dive, MCP showcases (Azure, DrawIO, PowerShell), and a capstone lab combining everything. If you completed Day 1 prereqs, you're **mostly ready**. Below are the new tools and auth steps needed for Day 2 labs.

**Estimated additional setup time:** 10–15 minutes

---

### Overview: What's New on Day 2?

| Module | New Tool | Purpose |
|--------|----------|---------|
| **M10 Agent Mode Deep Dive** | VS Code Agent Mode (already enabled Day 1) | Hands-on multi-step task automation |
| **L3 Agent Mode Playground** | VS Code Agent Mode | Autonomous scaffolding lab |
| **M12 MCP Showcase** | Azure CLI | Query Azure resources, list subscriptions |
| **M12 MCP Showcase** | Terraform CLI + Terraform MCP | Query providers/modules, plan infrastructure |
| **M12 MCP Showcase** | DrawIO + local server setup | Diagram generation and visualization |
| **M12 MCP Showcase** | PowerShell MCP | Execute PowerShell commands via agents |
| **L4 Custom Agent (Track A)** | MCPServerPS PowerShell module | Build a cmdlet, expose it as an MCP tool, scope an agent |
| **L4 Custom Agent (Track B)** | Terraform CLI + Azure CLI + sandbox sub | Deploy infra via Terraform MCP, query it via Azure MCP |
| **L5 Capstone ADR Architect** | None new — uses VS Code Copilot only | Agent customized from awesome-copilot writes a real ADR by scanning a Terraform fixture |

---

### M10: Agent Mode — Verify Already Enabled

Agent Mode should be enabled from Day 1 setup. Verify in VS Code:

1. Open VS Code
2. Press `Ctrl+Shift+D` (Run and Debug) or click the Run icon on the left
3. Look for **Copilot** in the Debug Console dropdown
4. If you see **Copilot** as an option, Agent Mode is ready

**Verification command:**

```powershell
# Open VS Code settings (GUI check)
code --file-uri "vscode://settings/extensions.ignoreRecommendations"
```

In VS Code Extensions, search for **"GitHub Copilot"** — ensure you see **GitHub.copilot** (not just Chat) installed. Agent Mode is bundled with the main Copilot extension.

**Fallback if Agent Mode is missing:**

If Agent Mode isn't available, reinstall the Copilot extension:

```powershell
code --install-extension GitHub.copilot
```

---

### M12: Azure MCP — Query Infrastructure

**What:** Query Azure resources, list subscriptions, permissions, resource groups — useful for architecture discovery tasks.

**Prerequisites:**
- Azure subscription with at least read-only access
- Azure CLI installed (typically already present in DNV environments)

#### Install Azure CLI

```powershell
winget install --id Microsoft.AzureCLI --exact
```

**Verify:**

```powershell
az --version
```

#### Authenticate Azure CLI

```powershell
az login
```

A browser window will open — authenticate with your DNV Azure credentials. Return to PowerShell; you should see a list of available subscriptions.

**Verify:**

```powershell
az account show --query name -o tsv
```

You should see your subscription name (e.g., `DNV Sandbox` or similar).

#### Install the Azure MCP Server (VS Code)

**Recommended — VS Code extension (one-click, auto-updating):**

Install the **[Azure MCP Server extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azure-mcp-server)** from the Visual Studio Code marketplace (publisher: `ms-azuretools`). The extension always tracks the latest preview, auto-updates, and picks up your `az login` credentials automatically — no `mcp.json` editing required.

Full walkthrough: [Get started using the Azure MCP Server with Visual Studio Code](https://learn.microsoft.com/en-us/azure/developer/azure-mcp-server/get-started/tools/visual-studio-code?tabs=one-click) (Microsoft Learn).

After install, open the **MCP panel** (Command Palette → **MCP: List Servers**) and confirm the `azure` server shows ✅ with tools loaded.

> **Tip — project-level pinning.** If a project needs a specific Azure MCP version (or you want the server scoped to a single workspace instead of installed globally), add it to that project's `.vscode/mcp.json` instead:
> ```json
> {
>   "servers": {
>     "azure": {
>       "type": "stdio",
>       "command": "npx",
>       "args": ["-y", "@azure/mcp@latest"]
>     }
>   }
> }
> ```
> Auth still comes from `az login` — no service principal env vars needed for the workshop.

**Graceful fallback:**

If you don't have Azure access or MCP fails to connect, the lab can proceed using mock data. Facilitators will provide a sample resource list for demonstration purposes.

---

### M12: Terraform MCP — Infrastructure Queries & Planning

**What:** Query Terraform Registry APIs, explore providers/modules, validate Terraform configurations, and plan infrastructure changes. Terraform MCP server bridges Copilot agents with Terraform IaC workflows — essential for DNV infrastructure automation tasks.

**Prerequisites:**
- Terraform CLI installed (for local workspace initialization and validation)
- Git (already installed, Day 1)

#### Install Terraform CLI

```powershell
winget install --id HashiCorp.Terraform --exact
```

**Verify:**

```powershell
terraform --version
```

Should report **Terraform v1.x** or later.

#### Initialize a Sample Terraform Module (for Day 2 Labs)

If you don't have an existing Terraform project, create a minimal module for hands-on demos:

```powershell
# Create a demo folder
mkdir $env:USERPROFILE\terraform-demo
cd $env:USERPROFILE\terraform-demo

# Create a simple Terraform file
@'
terraform {
  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}

variable "environment" {
  type    = string
  default = "dev"
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-demo-${var.environment}"
  location = "East US"
}

output "resource_group_id" {
  value = azurerm_resource_group.demo.id
}
'@ | Out-File -FilePath main.tf -Encoding UTF8

# Initialize (downloads provider plugins; doesn't deploy)
terraform init
```

**Verify the module is ready:**

```powershell
terraform validate
```

Should show **Success!** If you see provider errors, that's expected for an undeployed module — Terraform MCP can still plan and inspect it.

#### Install the Terraform MCP Server (VS Code)

The Terraform MCP server is published by HashiCorp at <https://github.com/hashicorp/terraform-mcp-server>. Two officially supported install paths — pick whichever fits your environment:

**Option A — Pre-compiled binary (recommended for the workshop, no Docker needed)**

1. Download the latest Windows release from <https://github.com/hashicorp/terraform-mcp-server/releases> (the `terraform-mcp-server_<version>_windows_amd64.zip` asset).
2. Extract `terraform-mcp-server.exe` to a folder on your PATH (e.g., `C:\tools\terraform-mcp-server\`), or note the full path for the next step.
3. Add the following to your project's `.vscode/mcp.json` (create the file if missing):

   ```json
   {
     "servers": {
       "terraform": {
         "type": "stdio",
         "command": "C:\\tools\\terraform-mcp-server\\terraform-mcp-server.exe"
       }
     }
   }
   ```

   If the binary is on PATH, you can use `"command": "terraform-mcp-server"` instead of the absolute path.

Full HashiCorp walkthrough: [Deploy Terraform MCP server to your local machine — pre-compiled binary](https://developer.hashicorp.com/terraform/mcp-server/deploy/local#pre-compiled-binary-1).

**Option B — Docker container (canonical, if you already run Docker Desktop)**

```json
{
  "servers": {
    "terraform": {
      "type": "stdio",
      "command": "docker",
      "args": ["run", "-i", "--rm", "hashicorp/terraform-mcp-server"]
    }
  }
}
```

Requires Docker Desktop installed and running. See <https://developer.hashicorp.com/terraform/mcp-server/deploy/local> for the full Docker walkthrough.

> The v0.3.0+ server supports optional `TFE_TOKEN` / `TFE_ADDRESS` env vars for HCP Terraform / Terraform Enterprise workspace queries. The DNV workshop uses only the **public Terraform Registry** (provider/module lookups, validation, plan analysis), which works without any token — omit those env vars entirely.

After saving `mcp.json`, open the **MCP panel** (Command Palette → **MCP: List Servers**) and confirm the `terraform` server shows ✅ with tools loaded.

#### Verification One-Liner

Once Terraform MCP is loaded, verify via Copilot Chat in VS Code:

> "Show me the latest Terraform AzureRM provider versions."

Copilot should query the registry through the MCP server and list provider versions. If Terraform MCP isn't available, Copilot will fall back to general knowledge — the answer will look plausible but won't cite live registry data.

#### Terraform Is the DNV Primary IaC Tool

**Critical:** Terraform is DNV's standard for Infrastructure as Code. Unlike optional tools, Terraform MCP is high-relevance for M12 and L4 (Track B uses Terraform MCP + Azure MCP to deploy and query). L5's capstone Terraform fixture is small and synthetic — no separate Terraform install needed beyond the L4 prep.

#### Graceful Fallback

If Terraform MCP doesn't connect or the registry query fails:

1. **Local validation still works:** `terraform validate` and `terraform plan` run directly without MCP
2. **Copilot fallback:** Agent will suggest Terraform commands or explain provider/module patterns from general knowledge
3. **Facilitator screenshots:** M12A deck includes fallback screenshots from a prior Terraform MCP registry query — facilitators will display these if live registry access is unavailable
4. **Manual Terraform workflow:** Attend L4 and L5 with `terraform` CLI alone; MCP integration adds agent automation, not core functionality

---

### M12: DrawIO MCP — Diagram Generation

**What:** Generate diagrams (architecture, flowcharts, network) using DrawIO MCP server. Copilot can create .drawio files on the fly.

**Prerequisites:**
- Local DrawIO MCP server running (lightweight, Node.js-based)
- `npx` available (installed with Node.js LTS from Day 1)

#### Verify Node.js is Ready

```powershell
npm --version
npx --version
```

Both should report versions. If not, [reinstall Node.js LTS from Day 1 prereqs](#2-install-nodejs-lts).

#### No Pre-Installation Required

The DrawIO MCP server runs on-demand via `npx` when wired into VS Code Copilot settings. No manual install needed now — configuration happens during **L4 Custom Agent Config & MCP Integration**.

**Verify DrawIO CLI availability:**

```powershell
npx @drawio/mcp --help
```

You should see help text. If `npx` times out, check internet connectivity and that Node.js is in your PATH (close and reopen PowerShell).

**Graceful fallback:**

If DrawIO MCP doesn't start, Copilot will suggest alternative diagram formats (Mermaid, ASCII art) instead. No blocker.

---

### M12: PowerShell MCP — Command Execution

**What:** Execute PowerShell commands safely through Copilot agents, with capture of output and error handling.

**Prerequisites:**
- PowerShell 7 (installed Day 1)
- `gh copilot` CLI extension working (verified Day 1)

#### Verify PowerShell 7

```powershell
pwsh --version
```

Should show **PowerShell 7.x** or later.

#### No Pre-Installation Required

PowerShell MCP is configured at lab time (L4). It uses your existing PowerShell 7 installation.

**Verify Copilot can execute PowerShell commands end-to-end:**

```powershell
gh copilot -i "list the current directory using PowerShell" --allow-tool powershell
```

You should see Copilot execute a PowerShell command and return results.

**Graceful fallback:**

If PowerShell MCP doesn't execute, labs can proceed with manual PowerShell commands alongside Copilot suggestions. Facilitators will provide step-by-step guidance.

---

### L3: Agent Mode Playground — Hands-On Setup

Agent Mode and VS Code Copilot are all you need. **Plan Mode is also required** — it's used in Round 1 to see the agent's plan before any files change. Plan Mode shipped in VS Code 1.124 (June 10, 2026), so confirm your VS Code is at least that version. **Pester 5+** is also required because Agent Mode usually generates Pester-based tests, and PowerShell 7 does not ship with Pester.

**Pre-lab check:**

```powershell
# Confirm VS Code Copilot is active and at the required version
code --version
# First line must be 1.124 or later — if not, run: winget upgrade --id Microsoft.VisualStudioCode --exact
code

# In VS Code: Press Ctrl+Shift+@ to open Copilot Chat
# In the mode selector at the bottom of the chat panel, confirm you see BOTH:
#   - Plan
#   - Agent
# Round 1 starts in Plan Mode; Round 2 switches to Agent Mode.

# Confirm Pester 5+ is installed (Agent Mode generates Pester tests)
(Get-Module -ListAvailable Pester | Sort-Object Version -Descending | Select-Object -First 1).Version
# If empty or < 5.0.0, install (one-time, per user — PSResourceGet is built into pwsh 7 and is much faster than Install-Module):
#   Install-PSResource -Name Pester -TrustRepository
```

> **Note:** As of VS Code 1.124, **Autopilot is enabled by default** in Agent Mode — the agent will auto-execute its todo list and only pause for terminal commands. That's expected. L3 uses Plan Mode specifically to see the plan before execution. If you want approve-each-step behavior in Agent Mode, tighten `chat.permissions.default` in settings.

---

### L4: Custom Agent Config & MCP Integration — Configuration & Wiring

**What:** L4 runs as **two parallel tracks** (you pick one at the start of the slot):
- **Track A — PowerShell MCP:** Build a tiny PowerShell cmdlet, expose it as an MCP tool with **MCPServerPS**, scope an agent to it, watch your code get called.
- **Track B — Azure + Terraform MCP:** Scaffold a Terraform module with **Plan Mode + Terraform MCP**, deploy a Log Analytics workspace to a shared sandbox subscription, then use **Azure MCP** to query it (KQL or Resource Graph). Optional bonus: **DrawIO MCP** to render the deployment.

**Shared prerequisites (both tracks):**
- PowerShell 7+ (Day 1) — `pwsh` must be on your PATH
- VS Code 1.124+ with GitHub Copilot in **Plan Mode and Agent Mode**, signed in

#### Track A prerequisites — MCPServerPS

The hard dependency for Track A. Install:

```powershell
Install-PSResource -Name MCPServerPS -Repository PSGallery
#   (or, on older setups: Install-Module MCPServerPS -Scope CurrentUser)
```

Verify:

```powershell
# 1. Module is available (should print a version)
Get-Module -ListAvailable MCPServerPS

# 2. Entry-point cmdlet exists (should return a command)
Get-Command Start-MyMCP
```

If both commands return a hit, Track A is ready. MCPServerPS does the JSON-RPC loop and schema work so you write a normal PowerShell module. By Dongbo Wang (daxian-dbw, PowerShell team): https://github.com/daxian-dbw/MCPServerPS — currently an incubation project.

#### Track B prerequisites — Azure + Terraform + sandbox subscription

- **Terraform CLI** (1.6+) — install instructions above in the M12 Terraform MCP section
- **Azure CLI** (2.50+) — install instructions above in the M12 Cloud MCP section
- **Sandbox Azure subscription access** — confirm with the facilitator which sub you'll use; you must have permission to create your own RG (pattern `rg-l4-<initials>-<random>`)
- **Terraform MCP server** loaded in VS Code (already configured per M12 prereqs)
- **Azure MCP server** loaded in VS Code (already configured per M12 prereqs)

Verify Track B readiness:

```powershell
# Tooling
terraform --version          # 1.6+
az --version                 # 2.50+

# Auth + sandbox sub
az login
az account show --query "{name:name, id:id}" -o table
# If multiple subs are shown, set the sandbox one the facilitator named:
az account set --subscription "<sandbox-sub-id-or-name>"
```

In VS Code: open the MCP panel (Command Palette → **MCP: List Servers**) and confirm both `terraform` and `azure` show ✅ tools loaded.

**Track B optional (DrawIO MCP bonus):** Node.js 18+ for `npx`. Verify with `node --version`. No install — DrawIO MCP runs on demand via `npx @drawio/mcp` (official [jgraph/drawio-mcp](https://github.com/jgraph/drawio-mcp)).

**Track B cleanup is mandatory.** The shared sandbox sub means orphaned RGs become finance's problem. Always run `terraform destroy -auto-approve` before the slot ends.

**Graceful fallback:**

- **Track A:** If MCP server wiring fails during the lab, confirm `pwsh` is on your PATH and re-check the absolute path in `.vscode/mcp.json`, then reload the VS Code window. The solution module under `track-a-powershell-mcp/solution/` is the reference if you're blocked.
- **Track B:** If `az login` or sandbox sub access fails, switch to Track A — same lesson, different surface. Don't burn the slot on auth debugging.

---

### L5: Capstone ADR Architect — Customization Lab

**What:** Take a published Copilot skill (`create-architectural-decision-record`) and a published agent (Azure Principal Architect) from [awesome-copilot](https://github.com/github/awesome-copilot) — customize both for your team's conventions — then have the agent scan a Terraform fixture, spot an undocumented decision, and write a real ADR.

**Prerequisites:**
- **VS Code with GitHub Copilot in agent mode, signed in** (same as L4).
- **L4 completed (recommended)** — Track A taught MCP wiring; Track B taught skill/agent discovery from `.github/`. This capstone reuses both.

**No new tooling required.** No MCPServerPS, no PowerShell module authoring, no Docker. The lab is markdown editing: customize the skill, customize the agent, run.

**Optional — wire MS Docs MCP / Azure MCP into the agent:**

If you wired Microsoft Docs MCP or Azure MCP in L4, you can add those tools to the agent's `tools:` list to let it look up live Azure WAF guidance during ADR drafting. Optional, not required for the core checkpoint.

**Graceful fallback:**

If your customizations get tangled, copy the upstream files from the `starter/` folder *verbatim* into your workspace — the agent will still produce an ADR; it just won't have your org extensions. The `solution/` folder is a working customized reference.

---

## 🔐 Summary: Day 2 Auth Checklist

By the start of Day 2 (June 15, 14:00), ensure:

- ✅ **GitHub CLI:** `gh auth status` shows your username (from Day 1 — verify)
- ✅ **GitHub Copilot CLI:** `gh copilot explain "git status"` works (from Day 1 — verify)
- ✅ **Azure CLI:** `az login` completed; `az account show` shows your subscription
- ✅ **VS Code Agent Mode:** Open VS Code, press `Ctrl+Shift+@`, see Copilot Chat panel
- ✅ **PowerShell 7:** `pwsh --version` shows 7.x or later
- ✅ **Node.js:** `npm --version` available (for DrawIO MCP)

---

**Last updated:** June 12, 2026
**For Day 2 questions:** Contact Jan Egil Ring or Haflidi Fridthjofsson
