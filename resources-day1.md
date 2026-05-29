# Day 1 Resources & Links

**Last updated:** 2026-05-26 (evening, after Day 1)
**Scope:** Day 1 materials only. Day 2 resources will be added after Day 2 concludes.

This guide collects the public sources, tools, and documentation referenced in Day 1 of the workshop. Bookmark these to deepen your understanding of each topic we covered.

---

## People to Follow

Strong technical voices in AI, infrastructure, and systems architecture. These are the practitioners and thinkers we drew from.

### Scott Hanselman & Mark Russinovich

**"Scott & Mark Learn To... Have Taste"** — YouTube episode where
Hanselman and Russinovich discuss how agents amplify human judgment rather than replace it. The "taste" episode is the one M5 and M7 reference directly. **Start here** if you want to understand why design and planning stay above the line while implementation can be automated.

- **YouTube channel:** ["Scott & Mark Learn To..."](https://www.youtube.com/playlist?list=PL0M0zPgJ3HSf4XZvYgZPUXgSrfzBN26pf)
- **Relevant episode:** ["Have Taste"](https://www.youtube.com/watch?v=vdAm50t_4nU)

### John Savill

**John Savill's Technical Training** (@NTFAQGuy on YouTube)
Deep dives on Azure, AI, and now AI skills. His "Understanding and Using AI Skills" video frames the tree analogy that grounds the skills appendix. His **savill.ai** site is the hub.

- **YouTube channel:** https://www.youtube.com/@NTFAQGuy
- **Website:** https://savill.ai
- **Specific talk:** [Understanding and Using AI Skills](https://www.youtube.com/watch?v=X9n5EYoWdNk)

### Barbara Forbes (Ba4bes)

**GitHub Copilot Billing & Usage** — YouTube video
Explains the June 1 usage-based billing model clearly. Her framing: *usage-based billing makes context visible as currency*. Watch this to understand the economics of token-efficient prompting.

- **YouTube:** https://www.youtube.com/watch?v=rKckbwCxXO4

### Jeffrey Snover

**PowerShell Inventor, AI Advocate**
Co-author of the "monad to millions" thesis that influenced design thinking. Recent public statements on why Claude Opus 4.6 flipped his skepticism to enthusiasm.

- **LinkedIn:** Recent posts (search "Jeffrey Snover 2026")

### Peter Steinberger

**OpenClaw Founder, OpenAI**
The Lobster Curl story (agent in a container with no tools, writes its own curl in C). Appears on Hanselminutes discussing agents and automation at the edge.

### Doug Finke

**PowerShell + AI Community**
Voices the cadence of LLM releases and model capabilities shifting week-to-week. Known voice in PowerShell and infrastructure automation communities.

---


## Hands-On Tools We Used / Showed

The tools demonstrated during the workshop. You can use these to continue practicing.

### GitHub Copilot

**Access:** Requires a GitHub Copilot license (free with GitHub Free, or standalone Pro/Business/Enterprise plans)

- **Copilot Chat in VS Code:** Built-in; activate with `Ctrl+I` or `Ctrl+Shift+I`
- **GitHub Copilot CLI:** Command-line tool for `gh copilot suggest` and `gh copilot explain` workflows
  - Installation: `gh extension install github/gh-copilot`
  - Requires: GitHub CLI (`gh`) + active GitHub authentication

### GitHub Copilot CLI

Bring Copilot to your terminal. Useful for:
- `gh copilot suggest "your task in plain English"`
- `gh copilot explain "your shell command"`

- **Install:** `gh extension install github/gh-copilot`
- **Docs:** GitHub CLI Copilot extension documentation
- **Prerequisite:** `gh auth login` (authenticate with GitHub first)

### VS Code Copilot Extension

The GUI for GitHub Copilot in VS Code. Includes:
- Copilot Chat (interactive)
- Copilot inline completions
- Copilot Agent Mode (Day 2 focus)
- AI Skills (if you add `.github/skills/` to your workspace)

- **Get VS Code:** https://code.visualstudio.com/
- **Extension:** Built-in to VS Code; no separate install needed

### GitHub MCP Server

Enable GitHub-specific tools (repos, issues, pull requests, content access) for your AI agent.

- **GitHub MCP Server docs:** Available in the VS Code Copilot Agent documentation

### AI Skills Specification

Structured format for defining reusable task procedures that agents can discover and invoke.

- **Specification:** https://agentskills.io/specification
- **Learn more:** John Savill's talk (above) and VS Code Copilot Skills documentation

---

## GitHub Official Documentation

Authoritative sources for Copilot features, billing, governance, and security. Always check these for current details.

### Billing & Pricing

- **[GitHub Copilot Concepts: Billing](https://docs.github.com/en/copilot/concepts/billing)** — How usage-based credits work
- **[Models and Pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)** — Which models cost what
- **[GitHub Copilot Plans FAQ](https://github.com/features/copilot/plans)** — Free / Pro / Business / Enterprise differences

### Features & Capabilities

- **[GitHub Copilot Features](https://docs.github.com/en/copilot/get-started/features)** — Complete capability list
- **[AI Models Supported](https://docs.github.com/en/copilot/reference/ai-models/model-hosting)** — Which LLMs are available; where they run
- **[Introduction to Prompt Engineering with GitHub Copilot](https://learn.microsoft.com/en-us/training/modules/introduction-prompt-engineering-with-github-copilot/)** — Learn module covering effective prompt crafting, role prompting, and best practices for working with Copilot

### Governance, Security & Privacy

- **[GitHub Enterprise Trust Center](https://ghec.github.trust.page)** — Enterprise compliance, certifications, data residency
- **[GitHub Privacy Statement](https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement)** — Data handling and international transfers
- **[Content Exclusion](https://docs.github.com/en/copilot/concepts/context/content-exclusion)** — Keep sensitive code out of LLM training
- **[Code Referencing](https://docs.github.com/en/copilot/concepts/completions/code-referencing)** — How Copilot attributes similar code
- **[Audit Logs](https://docs.github.com/en/copilot/how-tos/administer-copilot/manage-for-enterprise/review-audit-logs)** — Track Copilot usage in your organization

### Customization & Agents

- **[Copilot Agent Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)** — Define and use AI skills in VS Code
- **[GitHub Copilot CLI](https://cli.github.com/manual/gh_copilot)** — Terminal integration docs

---

## Workshop Materials

The decks and labs from Day 1 are the ground truth for what we covered. Refer back to these.

### Presentation Decks

- **M1 — Welcome & The Matrix Briefing** — Intro, Snover's "hit F5," agent vision
- **M5 — Context is King** — Prompt crafting, context layers, the sculpting metaphor
- **M7 — From Assistant to Agent** — The Design/Plan/Implement/Test/Review loop, taste warning, harness principle

---

## Key Takeaways to Reference

**From M5 (Context is King):**

Context layers (in impact order):
1. Custom instructions (global, persistent)
2. Workspace context (`@workspace`)
3. Active file + selection
4. Open tabs
5. Conversation history
6. External tools (MCP)

Plan mode pattern: Ask for a plan first, review it, then implement.

**From M7 (From Assistant to Agent):**

The loop you already run (Design → Plan → Implement → Test → Review):
- **You own:** Design, Plan
- **Agent owns:** Implement, Test, Review

Harness > Model: Context, instructions, tools, and guardrails around the model matter more than the model itself.

---

## For Deep Dives (Beyond Scope of This Workshop)

These resources go deeper into topics we touched on but didn't fully cover.

### Copilot Ecosystem & Community

- **[Awesome GitHub Copilot](https://awesome-copilot.github.com/)** — Community-curated collection of custom agents, instructions, skills, hooks, workflows, and plugins; a rich ecosystem for extending your Copilot experience beyond the defaults

### Agent Architecture

- Search for Adam Jacob's public talks on agents, infrastructure automation, and the future of ops

### Infrastructure-as-Code + AI

- Terraform best practices with Copilot
- Bicep and ARM template generation
- Policy-as-code validation (OPA, Sentinel) with agents

### Prompt Engineering at Scale

- Custom instructions as team conventions (see M5)
- Reusable prompt patterns and prompt libraries
- Multi-agent orchestration

### MCP (Model Context Protocol)

- Define custom tools your agent can use
- The GitHub MCP server is just the start—you can build your own

---

## Self-Paced Learning (Between Sessions)

Three weeks until Day 2 — use this time to keep momentum with these structured, hands-on labs from Microsoft Learn. All are **optional** and targeted at different interests within our audience.

### Microsoft Learn Labs Hub

**[Microsoft Learn Labs](https://learn.microsoft.com/en-us/labs/)** — Curated, free, self-paced labs built by Microsoft advocates and community experts. No Azure subscription required (though free tier is available).

**Three labs we recommend:**

| Lab | Exercises | Why It Fits |
|-----|-----------|-----------|
| [Generative AI for Beginners](https://microsoft.github.io/generative-ai-for-beginners/) | 21 | AI fundamentals, prompt engineering, and building with LLMs—deepens the foundations from M1 and M5. |
| [GitHub Copilot CLI for Beginners](https://github.com/github/copilot-cli-for-beginners) | Practical walkthrough | Terminal-based AI-assisted development (code review, test generation, debugging, custom agents)—extends M2/M4 hands-on work and previews Day 2 agent concepts. |
| [AI Agents for Beginners](https://microsoft.github.io/ai-agents-for-beginners/) | 12 | Building AI agents with AutoGen, Semantic Kernel, and LangGraph—for those curious to dig deeper than M7's introduction and ready for Day 2's agent mode focus. |

---

## Day 2 Resources

**[Day 2 resources will be added after Day 2 concludes.]**

Expected Day 2 content:
- M10: Agent Mode Deep Dive
- Lab exercises (L3, L4, capstone)
- External sources referenced in Day 2 talks
- Hands-on tool walkthroughs (detailed agent setup, MCP configuration, etc.)

---

## Questions?

If you can't find what you're looking for:

1. Check the [GitHub Copilot docs](https://docs.github.com/en/copilot) — they're comprehensive and updated regularly
2. Search the [GitHub Copilot community discussions](https://github.com/orgs/github/discussions)
3. Review the workshop decks
4. Bring questions to Day 2 — we'll have time to dig in

---

**Next:** On to Day 2. Identify one workflow from your daily work where you currently do all five stages manually (Design → Plan → Implement → Test → Review). We'll let an agent run the bottom of the loop on Day 2.

---

*Workshop materials © 2026 Microsoft × DNV · Distributed under MIT License*
