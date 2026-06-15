# L5 Capstone — Facilitator Notes

> Audience: facilitators only. Not participant-facing. Pairs with the run-of-show
> (`docs/planning/phase2-run-of-show.md`, slot 17:05–17:50, 45 min).

## The one thing that matters

The **celebration moment** is: *"your customized agent read the Terraform fixture, called your customized skill, and wrote a valid ADR file."* That is the minimum-viable checkpoint. Everything else (extra `[ORG]` fields, Champion track) is bonus. Call it out loudly when the first attendee hits it.

## Timing (45 min)

| Phase | Time | What |
|---|---|---|
| Open the starter | ~5 min | Browse upstream skill + agent + terraform fixture. Notice `TODO (org)` markers |
| Customize the skill | ~10 min | Add 1–2 org extensions (front-matter field, required section, naming gate) |
| Customize the agent | ~10 min | Trim tools, add org constraints, point at `terraform/` |
| Run the agent | ~10 min | Prompt → ADR appears at `docs/adr/adr-NNNN-*.md` |
| Iterate / wrap | ~10 min | Tighten skill or agent if needed; re-run; celebrate |

This is the **capstone** — it doesn't introduce a new mechanic. It puts L4's agent + MCP + skill foundations to use on something *they* would actually want in their repo.

## Scaffolding level (L1→L5 progression)

L5 is the top of the climb. By here attendees:

- L1 — followed TODOs in a single file.
- L2 — chose between alternatives a prompt suggested.
- L3 — wrote prompts that ran multi-file refactors.
- L4 — wired MCP tools (Track A) and custom agents (Track B).
- **L5 — design the context layer**: a skill that encodes their team's standards + an agent that applies them. Not writing code — wiring organisational knowledge into a published pattern.

Lean on the framing: "you've already learned every mechanic. Today you're operating at the design layer."

## Common stumbles & fixes

| Symptom | Fix |
|---|---|
| Agent says "I can't read files / no terminal tool" | `.agent.md` `tools:` is **opt-OUT**. Make sure `'edit/editFiles'` and `'search/codebase'` are in the list. Tool names are namespaced (`<toolset>/<tool>`); bare names like `codebase` are flagged as renamed — VS Code's "Configure Tools..." button shows current canonical names |
| Skill edits not picked up | Reload window (`Ctrl+Shift+P → Developer: Reload Window`). Skills are loaded once |
| Agent re-numbers ADR (writes `0001-...` again) | Agent skipped step 1 (inventory). Reinforce "Read `docs/adr/` FIRST" in Approach |
| Agent writes outside `docs/adr/` | Tighten the constraint block. The skill says "MUST be saved in `/docs/adr/`" — agent constraint should mirror that |
| Output ignores the `[ORG]` field they added | They made it look like a note. Change `[ORG] X is required` to `MUST include X` in the skill's Requirements section |
| Agent invents non-existent MCP tools | They added tool refs without wiring the server. Tools list = security boundary; remove what isn't wired |
| Output uses the legacy `0001-*.md` naming | Seed ADRs use the old Nygard naming. The skill's `adr-NNNN-*.md` convention only applies to *new* ADRs. Both styles can coexist — call this out, don't make them migrate |

## What "good" looks like

- New file at `docs/adr/adr-0003-<slug>.md` with full front matter (title, status=Proposed, date, authors, tags).
- Context section quotes specific Terraform lines as evidence (file + ~line), not generic prose.
- At least 2 Alternatives with rejection reasons.
- At least 2 POS and 2 NEG coded bullets.
- If they added an `[ORG]` field, it's populated (not blank).

A canonical reference ships at `solution/docs/adr/adr-0003-single-region-deployment-with-paired-region-roadmap.md`. It's *one* good answer — encourage attendees to compare on **shape**, not content.

> 📸 Reference run screenshot: `labs/L5-adr-generator-capstone/images/adr-architect-run.png` — shows the agent successfully picking public-network-access as the documented decision, drafting the file, verifying it by reading back, and reporting two more candidates. Good as a "this is the target" image when introducing Part 4.

## Champion track

Champions go to `bring-your-own-conventions/SKILL.md` after the core checkpoint. The exercise: point it at a real GitHub repo they own (org naming guide, tagging guide, even a README in their team's tooling repo), then re-prompt:

> *"Propose paired-region failover for prod. Resolve resource names from our conventions repo before writing the ADR."*

If they hit a 404 on the fetch, that's the lesson: the skill's "be explicit about staleness" rule should fire; the agent should *say* the source was unreachable, not guess.

## Ship-it track

`starter/.vscode/mcp.json` wires the **official GitHub MCP server** (hosted at `https://api.githubcopilot.com/mcp/`, OAuth via VS Code sign-in — no PAT). The agent already has `'github/*'` in its `tools:` list. Once a participant has produced a valid ADR, point them at the Ship-it section in the README:

> *"Create a branch, commit the ADR, push it, and open a **draft** PR against this repo's `main`."*

What to demo / call out:
- First `github/*` call triggers an OAuth consent dialog — pre-warn the room so it doesn't startle anyone.
- VS Code 1.101+ is required for remote MCP. Older versions silently fail to connect.
- Insist on **draft PR** so nothing accidentally lands during the workshop.
- This is also the cleanest demo of the **MCP-everywhere** thesis: same `'github/*'` wildcard works in any MCP-capable client (Cursor, Codex, Claude Desktop), not just VS Code. Contrast with the GitHub Pull Requests *extension*, which is VS Code-only.

If a participant pushes back ("why not just use the PR extension?"), the answer is: extension is great for human-driven review; MCP is the right plane when an *agent* is driving end-to-end.

> 📸 Reference screenshots for what a successful Ship-it run looks like:
> - `images/ship-it-pr-conversation.png` — Draft PR conversation with agent-authored summary; note the "Mention @copilot in a comment" affordance that hands the PR back to a coding agent for revisions.
> - `images/ship-it-pr-files.png` — Files changed tab showing the +65 line ADR.
>
> Both are from PR #36 on `janegilring/ai-coding-workshop` (the test run). If you re-test, expect a slightly different branch name unless the participant resolves all placeholders in their prompt — the test run produced `adr/-from-` because `<your-handle>` was left literal. Use it as a teachable moment about agent prompts that touch external systems.

## Reference org context (DNV — for facilitator awareness only)

Stored team memory says DNV's IaC is Terraform-first (not Bicep). The seed `0002-use-terraform-for-iac.md` models this in the lab (genericized — uses "our organisation" rather than naming DNV). If a DNV attendee asks "what would real DNV conventions look like in `bring-your-own-conventions`?", point them at their internal Terraform module repo as the source-of-truth example.

## Bonus depth (only if time)

- **Open the Agent Customizations panel** (gear icon top-right of Chat) — show attendees the workspace skills + agent appearing under their `Workspace` sections, alongside the broader counts (Skills 62, Agents 18, MCP Servers 20, etc.). Scroll down to surface the **Extensions** scope — agents like `AzqrCostOptimizeAgent`, `Azure IaC Generator`, `Azure_Static_Web_App` ship from VS Code extensions and appear here automatically. Then switch to the **MCP Servers** tab — the `github` server we wired in `.vscode/mcp.json` appears under Workspace; the L4 servers (Azure Resource Manager MCP, drawio, microsoft-docs, etc.) appear under User. Makes the "skills + agents + MCP servers all resolve from three scopes (Workspace / User / Extensions)" point tangible. The `Generate Skill` / `Generate Agent` buttons and the **Browse Marketplace** button on the MCP tab are also a nice teaser for post-workshop authoring. Screenshot references: `labs/L5-adr-generator-capstone/images/agent-customizations-panel.png` and `agent-customizations-mcp.png`.
- Show how adding `'microsoft.docs.mcp/*'` to the agent's `tools:` list (if they have it) lets the upstream Azure Principal Architect prompts ("search MS Docs for WAF Reliability guidance") work directly.
- Show how the `solution/` agent's `[ORG]` constraints flow into the `adr-0003` example — every NEG bullet has a cost annotation because the constraint demands it.

## Credits

- **`create-architectural-decision-record`** skill — [github/awesome-copilot](https://github.com/github/awesome-copilot/tree/main/skills/create-architectural-decision-record).
- **`azure-principal-architect`** agent — [github/awesome-copilot](https://github.com/github/awesome-copilot/blob/main/agents/azure-principal-architect.agent.md).
- **ADR format** — Michael Nygard, via <https://adr.github.io/>.
