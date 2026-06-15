# Labs — Hands-On Exercises

Progressive hands-on labs building from **first contact** (L1) through **agent architecture** (L4–L5) and the **capstone project**. Each lab reinforces the scenarios: **Documentation**, **Terraform IaC**, and **PowerShell**.

---

## Lab Index

### **[L1: "Hello, Copilot" — First Contact](./L1-hello-copilot/README.md)** (Day 1, 15:55–16:15 · 20 min core + optional stretch up to 40 min)

**Objective:** Setup validation + first hands-on experience using Copilot completions and chat.

**What You'll Do:**
- Verify your environment is ready (VS Code, Copilot CLI, authentication)
- Complete the `New-ResourceSlug` PowerShell utility using Copilot completions
- Use Copilot Chat to ask questions about your code
- Understand the basic Copilot workflow

**Prerequisites:**
- Complete [prerequisites.md](../prerequisites.md) — Windows setup, tools installed, GitHub Copilot license verified
- Have VS Code and PowerShell 7 running and tested before the lab
- Ensure `gh auth status` shows you're authenticated to GitHub

**Acceptance Criteria:**
- ✅ Environment setup validated and Copilot working
- ✅ Write and run a small utility using Copilot guidance
- ✅ Celebrate the first interaction—this is the confidence builder for the day

**Facilitator Notes:** See [phase2-run-of-show.md](../docs/planning/phase2-run-of-show.md#l1) for timing, facilitation strategy, and contingency demos.

---

### **[L3: Agent Mode Playground — Autonomous Tasks](./L3-agent-mode-playground/README.md)** (Day 2, 15:35–16:00 · 25 min core + optional stretch)

**Objective:** First hands-on driving GitHub Copilot Agent Mode — scaffold a tiny PowerShell module and observe the multi-step iteration loop (plan, tool calls, self-correction, steering).

**What You'll Do:**
- Engage Agent Mode and read a multi-step plan before approving it
- Watch the agent make file edits and run a terminal test as tool calls
- Steer with real requirements and watch it self-correct on test failures
- Practice when to interrupt and when to let it run

**Prerequisites:**
- Sit directly after Module 10 — Agent Mode Deep Dive
- VS Code with GitHub Copilot signed in and Agent Mode available
- PowerShell 7 runnable in the integrated terminal

**Facilitator Notes:** See [solution/facilitator-notes.md](./L3-agent-mode-playground/solution/facilitator-notes.md) and [phase2-run-of-show.md](../docs/planning/phase2-run-of-show.md).

---

### **[L4: Custom Agent Config & MCP Integration](./L4-custom-agent-mcp/README.md)** (Day 2, 16:40–17:05 · 25 min core + optional bonus/stretch)

**Objective:** Watch your *own* work get called by an agent — pick **one** of two parallel tracks at the start of the slot.

**Track A — PowerShell MCP** *(default)*
- Build `Get-WorkshopDemoServiceStatus` (comment-based help + `[ValidateSet]` allow-list of three Windows services, defaulting to Spooler) with Copilot
- Wire the module as an MCP server via `.vscode/mcp.json` using MCPServerPS
- Create a scoped `@Workshop Demo Agent` persona, invoke it, watch your cmdlet fire — then see the schema reject an out-of-set value
- **Prereqs:** MCPServerPS module, PowerShell 7

**Track B — Azure + Terraform MCP**
- Scaffold a Terraform module (RG + Log Analytics workspace) with **Plan Mode + Terraform MCP**
- `terraform apply` to deploy real infra into a shared sandbox subscription
- Use **Azure MCP** in Agent Mode to inspect the deployment and run a KQL query
- Bonus: render the deployment with **DrawIO MCP**
- **Prereqs:** Terraform CLI, Azure CLI, sandbox sub access — *mandatory `terraform destroy` at end*

**Backbone:** Both tracks teach *you decide what is callable; the LLM decides when to call.* Same lesson, two surfaces. Track A mirrors M12-B (PowerShell MCP); Track B mirrors M12-A (Cloud MCP).

**Facilitator Notes:** See [README.md picker](./L4-custom-agent-mcp/README.md), [shared facilitator-notes.md](./L4-custom-agent-mcp/facilitator-notes.md), and [phase2-run-of-show.md](../docs/planning/phase2-run-of-show.md).

---

### **[L5: Capstone — ADR Architect Agent ⭐](./L5-adr-generator-capstone/README.md)** (Day 2, 17:05–17:50 · 45 min capstone)

**Objective:** Take a published Copilot skill (`create-architectural-decision-record`) and a published agent (Azure Principal Architect) from [awesome-copilot](https://github.com/github/awesome-copilot) — **customize both for your team's conventions** — then have the agent scan a Terraform fixture, spot an undocumented decision, and write a real ADR.

**What You'll Do:**
- Open the upstream skill + agent (copied into the starter)
- Customize the skill — add 1–2 org-specific requirements (front-matter field, required section, naming gate)
- Customize the agent — trim tools, add org constraints, point at *your* IaC layout
- Prompt the agent: *"find one undocumented decision in `terraform/` and write an ADR for it through my skill"*

**Minimum-viable checkpoint (celebration moment):** Your customized agent read the Terraform fixture, called your customized skill, and wrote a valid ADR at `docs/adr/adr-NNNN-<slug>.md` that reflects your customizations.

**Champion track:** Customize the `bring-your-own-conventions` skill — a thin skill that fetches naming/tagging rules from a real conventions repo your team owns. Watch the agent apply your *live* conventions.

**Prerequisites:** L4 completed (Track A taught MCP wiring; Track B taught skill/agent discovery from `.github/`). No new tooling required.

**Credits:** [awesome-copilot · create-architectural-decision-record](https://github.com/github/awesome-copilot/tree/main/skills/create-architectural-decision-record) · [awesome-copilot · azure-principal-architect](https://github.com/github/awesome-copilot/blob/main/agents/azure-principal-architect.agent.md) · ADR format by Michael Nygard via https://adr.github.io/.

**Facilitator Notes:** See [solution/facilitator-notes.md](./L5-adr-generator-capstone/solution/facilitator-notes.md) and [phase2-run-of-show.md](../docs/planning/phase2-run-of-show.md).

---

### **[L2: Prompt Dojo — Context Engineering](./L2-prompt-dojo/README.md)** (Self-paced — 25 min core; optional stretch ~3 min)

> **Note:** L2 is **not in the live Day 2 agenda** — we covered the core idea in **Module 5 — Context is King** and practiced it in the Teams chat exercise during Day 1. Run this lab on your own time to deepen the muscle.

**Objective:** Kata-style rounds turning vague prompts into specific ones; observe the output-quality difference.

**What You'll Do:**
- Start each round with a deliberately vague prompt and note the output shape
- Rewrite it with the context Copilot needs (schema, constraints, version, output contract)
- Run both through Copilot Chat and compare the result
- Reflect on which context dimension improved the draft

**Rounds:** 1) Terraform variable validation · 2) Terraform module structure · 3) PowerShell error handling

**Prerequisites:** VS Code with Copilot Chat, `gh auth status` authenticated. See [L2-prompt-dojo.md](./L2-prompt-dojo.md) for the participant entry point.

**Facilitator Notes:** See [solution/facilitator-notes.md](./L2-prompt-dojo/solution/facilitator-notes.md) and [phase2-run-of-show.md](../docs/planning/phase2-run-of-show.md).

---

## Getting Started with L1

### Before the Lab
1. **Complete setup:** Follow [prerequisites.md](../prerequisites.md) — 20–30 minutes
2. **Verify authentication:** Run `gh auth status` to confirm you're logged in
3. **Test Copilot:** Run `gh copilot -i "explain git status"` to confirm Copilot CLI is working
4. **Have VS Code ready:** Launch VS Code and confirm GitHub Copilot extensions are installed

### During the Lab (20 minutes core)
1. **Setup Validation** (5 min): Facilitator walks through the readiness checklist
2. **Core Build** (12 min): Complete `New-ResourceSlug` in `hello-copilot.ps1` with Copilot guidance
3. **Wrap-up** (3 min): Ask Copilot Chat questions about your code and capture what you learned

If the agenda allows, optional stretch work can extend L1 up to 40 minutes total.

### Outcome
✅ Everyone has a working Copilot setup and has written real code with AI guidance. Ready for Day 2 labs.

---

## Lab Repository Structure

Each lab `Lx` folder contains:
- `README.md` — Lab objectives, acceptance criteria, prerequisites
- `starter/` — Starter code or templates (if needed)
- `solution/` — Reference solution (facilitator use)

For L1 specifically: See [labs/L1-hello-copilot](./L1-hello-copilot/README.md) for participant instructions, starter code, and reference solution.

---

## Support & Questions

- **During the workshop:** Ask in Teams chat or breakout room
- **Lab timing:** Respect the run-of-show timing; facilitators will call time
- **Setup issues:** See troubleshooting in [prerequisites.md](../prerequisites.md)
- **After the lab:** Ask facilitators before moving to the next session

---

## Quick Links

- [Workshop README](../README.md) — Agenda and overview
- [Prerequisites](../prerequisites.md) — Environment setup & verification
- [Run of Show](../docs/planning/phase2-run-of-show.md) — Timing, facilitation notes, contingencies
- [Customer Workshop Repo](https://github.com/dnv-opensource/gssit-cloudinfra-gitcopilot-agentws) — Participant-facing materials
