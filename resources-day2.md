# Day 2 Resources & Links

**Last updated:** 2026-06-15
**Scope:** Day 2 materials only. Cross-links Day 1 file where topics overlap.

This guide collects the public sources, tools, and documentation referenced in Day 2 of the workshop — Agent Mode, the Model Context Protocol (MCP), safety and sandboxes, and the Build FY26 ships. For Day 1 foundations (context, prompting, the Design→Plan→Implement→Test→Review loop), see [resources-day1.md](./resources-day1.md).

---

## People to Follow

New voices from Day 2. Day 1 already covers **Scott Hanselman**, **Mark Russinovich**, and **John Savill** — see [resources-day1.md](./resources-day1.md#people-to-follow). They reappear below as cross-links rather than duplicate entries.

### Jeffrey Snover

Already introduced in [Day 1](./resources-day1.md#jeffrey-snover) for AI skills. Day 2 opens (M9) with his **PSConfEU 2026 keynote, "Navigating the AI Revolution."** The "recalibration moment" we use is Microsoft MVP **Robert Prüst's** LinkedIn reaction to it — *"I need to let go of control to gain more leverage. I need to try the orange."* **Start here** if you want the emotional permission slip: even seasoned engineers are re-learning.

- **Keynote (YouTube):** https://www.youtube.com/watch?v=_GWo9drWx5s

### Dongbo Wang (daxian-dbw)

Author of **MCPServerPS**, the PowerShell module that powers the M12-B InfraOps demo and the L4 / L5 labs. It wraps the JSON-RPC loop, schema validation, and server lifecycle so you ship a normal PowerShell module instead of plumbing. **Start here** if you want to build your own MCP server in PowerShell.

Dongbo is on the **PowerShell team at Microsoft**. MCPServerPS is currently an **incubation project** — not an officially supported product, but actively developed by a team member.

- **MCPServerPS:** https://github.com/daxian-dbw/MCPServerPS
- **Talk — *PowerShell as an MCP Tooling Host: Using MCPServerPS to Supercharge AI-Assisted Automation* (YouTube):** https://www.youtube.com/watch?v=ghwBPDdsuM4 — Dongbo's own deep-dive on the module that L4 Track A and L5 build on. Watch for the framing of *schema as the security boundary*.

### Kevin Marquette

PowerShell community veteran and prolific author (PowerShellExplained.com). Day 2's MCP-from-PowerShell story has two complementary voices: Dongbo (the module author) and Kevin (the practitioner showing what to *do* with it). **Start here** if you want a practitioner's take on building custom LLM actions on top of PowerShell + MCP.

- **Talk — *Beyond the Prompt: Leveraging MCP and PowerShell for Custom LLM Actions* (YouTube):** https://www.youtube.com/watch?v=6NtDB3Bo0jE — Pairs naturally with Dongbo's talk above. Great as a homework follow-up after L4 Track A.

---

## Topic Deep-Dives

One section per major Day 2 theme. Each link includes a brief WHY.

### Agent Mode (M10 + L3)

Agent Mode runs the bottom of the loop — Implement, Test, Review — while you keep Design and Plan. M10 also patches in two Build FY26 beats: **model choice** and **multi-model orchestration**.

- **[Use agent mode in VS Code](https://code.visualstudio.com/docs/copilot/chat/chat-agent-mode)** — How the agent plans, edits across files, runs terminal commands, and iterates on errors. The canonical reference for L3.
- **[MAI-Code-1-Flash is now available for GitHub Copilot](https://github.blog/changelog/2026-06-02-mai-code-1-flash-is-now-available-for-github-copilot/)** — Why it matters: model choice is a durable Copilot principle. MAI-Code-1-Flash is the lead model in Microsoft's new in-house family, trained directly against the production Copilot harnesses. Selectable from the model picker, no setup.
- **[Introducing MAI-Code-1-Flash (microsoft.ai)](https://microsoft.ai/news/introducingmai-code-1-flash/)** — Microsoft AI's own announcement: lightweight, inference-efficient, adaptive solution-length control (up to ~60% fewer tokens).
- **[MAI-Code-1-Flash vs Claude Haiku 4.5 (llm-stats.com)](https://llm-stats.com/models/compare/mai-code-1-flash-vs-claude-haiku-4-5-20251001)** — Side-by-side on SWE-Bench Verified, Pro, Multilingual, and Terminal Bench 2. Use this to reason about *which model for which job*.
- **[Rubber Duck Agent (Copilot CLI)](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/rubber-duck)** — A built-in critic subagent on a *different* model: two models, one task, no shared blind spots. Read-only, categorizes feedback as Blocking / Non-blocking / Suggestions; the main agent decides what to act on.

### MCP — Model Context Protocol (M12-A + M12-B + L4 + L5)

MCP is the open vocabulary that lets agents call your tools. The GitHub MCP server from [Day 1](./resources-day1.md#github-mcp-server) was the appetizer; Day 2 is where you wire up — and build — your own.

- **[Model Context Protocol (modelcontextprotocol.io)](https://modelcontextprotocol.io/)** — The official spec and SDKs. **Start here** to understand the protocol underneath every server below.
- **[MCP servers in VS Code](https://code.visualstudio.com/docs/copilot/customization/mcp-servers)** — How to register servers via `mcp.json` / `.vscode/mcp.json`. This is the mechanism L4 and L5 use.
- **[Azure MCP Server](https://github.com/Azure/azure-mcp)** — Bridges agents to Azure resource queries and operations. The M12-A demo backbone.
- **[Azure MCP catalog (mcp.azure.com)](https://mcp.azure.com/?search=Azure)** — Searchable directory of Azure-published MCP servers. Useful for discovering which Azure surfaces already have a first-party MCP server before you write your own.
- **[Introducing the Azure Resource Manager MCP Server](https://techcommunity.microsoft.com/blog/azuregovernanceandmanagementblog/introducing-the-azure-resource-manager-mcp-server/4517521)** — Azure Governance & Management team announcement. ARM-focused MCP for resource graph queries, deployments, and policy — complementary to the broader Azure MCP server above.
- **[Terraform MCP Server is now generally available (HashiCorp)](https://www.hashicorp.com/en/blog/terraform-mcp-server-is-now-generally-available)** — GA announcement for the canonical Terraform MCP. Pair this with the GitHub repo below for setup.
- **[Terraform MCP Server (HashiCorp)](https://github.com/hashicorp/terraform-mcp-server)** — Registry queries (providers, modules), workspace management, and config validation. The canonical Terraform MCP choice — and Terraform is DNV's primary IaC tool.
- **[SQL MCP Server is generally available](https://azure.microsoft.com/en-us/updates?id=564734)** — GA announcement. Gives agents a governed surface for querying and operating against SQL databases via MCP.
- **[Agent mode for GitHub Copilot in SSMS](https://azure.microsoft.com/en-us/updates?id=562637)** — Agent mode arrives inside SQL Server Management Studio: query tuning, performance investigation, configuration review, security checks, and error troubleshooting from inside the IDE DBAs already live in.
- **[MCPServerPS (Dongbo Wang)](https://github.com/daxian-dbw/MCPServerPS)** — Expose any PowerShell module as MCP tools. Powers the M12-B InfraOps demo, L4, and L5. Install: `Install-PSResource -Name MCPServerPS -Repository PSGallery`.
- **DrawIO MCP** — Visualizes what an agent discovers, then opens it in Draw.io. Official [jgraph/drawio-mcp](https://github.com/jgraph/drawio-mcp), runs on demand via `npx @drawio/mcp` (no pre-install). M12-B pairs it with PowerShell MCP: introspect the system, then draw it — same protocol, different output.

### Safety, Sandboxes & Harness (M15 + M-Bonus)

The harness — context, instructions, tools, and *guardrails* around the model — matters more than the model. M15 frames three tiers: local sandbox → cloud sandbox → enterprise harness.

- **[Cloud and local sandboxes for GitHub Copilot — public preview](https://github.blog/changelog/2026-06-02-cloud-and-local-sandboxes-for-github-copilot-now-in-public-preview/)** — The announcement. Why: lets the agent run with restricted filesystem, network, and shell access, in your seat or in an ephemeral cloud VM.
- **[About cloud and local sandboxes](https://docs.github.com/copilot/concepts/about-cloud-and-local-sandboxes)** — The docs: local MXC boundary, `/sandbox enable` / `disable`, `--cloud` for ephemeral Linux (separate meter), and MDM central enforcement.
- **Build session DEM305** — The Build FY26 sandbox session referenced in M15.
- **[Sandbox demo (YouTube)](https://www.youtube.com/watch?v=J8laUDXs08c)** — See the local/cloud toggle in action.
- **[Azure AI Foundry](https://ai.azure.com/)** — Positioned in M15 as the enterprise harness tier (no deep dive). Where agents get governed, evaluated, and deployed.
- **[Microsoft Agent 365](https://www.microsoft.com/en-us/microsoft-365/agent-365)** — Positioned alongside Foundry as enterprise agent management. Position-only in the deck.

### Build FY26 Ships (M-Bonus)

The bonus round: what shipped at Build FY26 that's worth tracking. Single source of truth for new ships is the [GitHub Changelog](https://github.blog/changelog/).

- **GitHub Copilot Desktop App** — The agent-native desktop experience.
  - Repo: https://github.com/github/app
  - [Announcement](https://github.blog/news-insights/product-news/github-copilot-app-the-agent-native-desktop-experience/)
  - [Hanselman walkthrough (YouTube)](https://www.youtube.com/watch?v=PUCYm32ZBaU)
- **Cloud Agent Automations** — Schedule and automate recurring agent tasks.
  - [Announcement](https://github.blog/changelog/2026-06-02-schedule-and-automate-tasks-with-copilot-cloud-agent/)
  - [Docs: create automations](https://docs.github.com/copilot/how-tos/use-copilot-agents/cloud-agent/create-automations)
- **Third-Party Agent Apps** — Extend GitHub with agents from the ecosystem.
  - [Announcement](https://github.blog/changelog/2026-06-02-extend-github-with-agent-apps/)
  - [Docs: use agent apps](https://docs.github.com/copilot/how-tos/use-copilot-agents/cloud-agent/use-agent-apps)
- **Copilot Code Review for Azure Repos** `TECHNICAL PREVIEW` — Agentic on-demand PR reviews in Azure Repos. DNV relevance: any Azure DevOps audience.
  - [DevBlogs announcement](https://devblogs.microsoft.com/devops/copilot-code-reviews-for-azure-repos/)
  - [Tech preview signup](https://nam.dcv.ms/VeDNq3VRhX)

---

## Recommended Build FY26 Sessions

Point, don't read. These are the sessions worth your time after the workshop.

| Session | Title / Focus | Why |
|---------|---------------|-----|
| KEY101 | Satya Nadella keynote | The strategic framing for the whole agent platform |
| BRK203 | CLI → PR workflow | The end-to-end "describe it, ship it" loop |
| DEM350 | Agentic Workflows | Live agent orchestration patterns |
| BRK201 | Multi-agent patterns | When and how to compose multiple agents |
| BRK206 | Copilot SDK multiclient | Building on the Copilot SDK across clients |
| BRK202 | Azure DevOps + GitHub | Bridging both worlds — relevant to DNV |
| BRK207 | Copilot in Visual Studio | The VS-specific agent story |
| BRK230 | Foundry models + costs | Choosing and budgeting models in Foundry |
| BRK252 | Observability → ROI | Measuring agent value, not just usage |
| BRK226 | Mark Russinovich — Azure innovations | Platform-level direction from the Azure CTO |

---

## Tools & Repos

- **This workshop repo** — Clone it after the workshop to re-run every lab and re-read every deck. (Internal source; customer mirror: https://github.com/dnv-opensource/gssit-cloudinfra-gitcopilot-agentws)
- **[Microsoft Learn Labs](https://learn.microsoft.com/en-us/labs/)** — Self-paced, free labs. Same hub recommended in [Day 1](./resources-day1.md#microsoft-learn-labs-hub).
- **[Awesome GitHub Copilot](https://awesome-copilot.github.com/)** — Community-curated agents, instructions, skills, and MCP servers. Cross-link from [Day 1](./resources-day1.md#copilot-ecosystem--community) — now doubly useful for discovering MCP servers.

---

## Official Microsoft / GitHub Sources

Authoritative references for the Day 2 features. Check these for current details.

- **[GitHub Copilot docs](https://docs.github.com/en/copilot)** — The hub for every Copilot concept.
- **[VS Code Copilot docs](https://code.visualstudio.com/docs/copilot/overview)** — Agent mode, MCP, customization.
- **[Model Context Protocol](https://modelcontextprotocol.io/)** — The open standard.
- **[GitHub Changelog](https://github.blog/changelog/)** — The single feed for new Copilot ships. **Subscribe to this** — it's how you stay current after the workshop.

---

## Try These Next

Pick one. Momentum beats completeness.

1. **Customize the ADR skill+agent for your real repo.** L5's capstone showed the customization loop on a fictional Helios workload. Now do it for your real one: copy the upstream [`create-architectural-decision-record`](https://github.com/github/awesome-copilot/tree/main/skills/create-architectural-decision-record) skill into your repo, customize it for your team's required fields, point an ADR Architect agent at your actual IaC, and let it work through your decision backlog.
2. **Build your own MCP server with MCPServerPS.** Start with a one-cmdlet module like L4 — a single function with comment-based help and `ValidateSet`. The schema *is* your security boundary. ([MCPServerPS](https://github.com/daxian-dbw/MCPServerPS))
3. **Run `/sandbox enable` on a real repo.** Feel the local MXC boundary — let the agent work with restricted filesystem, network, and shell, and watch what it can and can't touch. ([Sandbox docs](https://docs.github.com/copilot/concepts/about-cloud-and-local-sandboxes))
4. **Subscribe to the [GitHub Changelog](https://github.blog/changelog/).** New Copilot ships land here first.

---

*Workshop materials © 2026 Microsoft × DNV · Distributed under MIT License*
