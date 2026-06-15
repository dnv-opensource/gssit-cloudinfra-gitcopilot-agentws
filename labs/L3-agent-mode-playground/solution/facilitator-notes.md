# L3 — Facilitator Notes

Use these for live facilitation and the debrief. Keep them out of the
participant view.

## The one thing this lab must land

Attendees should *see the loop run itself*: the agent plans, edits files, runs a
terminal command, reads the result, and **fixes failures without being told the
exact fix**. That self-correction is what separates agent mode from chat. If
they only watch file creation, they missed the point — push them to Round 2 so a
test actually runs.

## Why Option B (PowerShell module), not docs

A docs scaffold is lower-risk but shows only planning + file writes — no terminal
tool calls, no self-correction. L3 is the first agent-mode hands-on right after
M10, whose centerpiece is the Prompt → Plan → Observe → Execute → Review → Steer
loop. The module-with-a-test path exercises every stage, including Review and
Steer.

> **Note on the test framework.** Agent Mode reliably picks **Pester 5+** for the test in Round 1, so Pester is a Core prereq for L3 (see setup-validation block in the README). The framework-free `solution/Run-Tests.ps1` is kept as a facilitator fallback — useful for validating the canonical solution build without depending on attendees having Pester installed, and as a backup if Pester install fails for someone live.

## Timing (25 min)

| Part | Time | Watch for |
| --- | --- | --- |
| Setup validation | ~6 min (24%) | Agent Mode actually engages; can run `pwsh` in the terminal |
| Round 1 (vague → plan in **Plan Mode**) | ~7 min | Attendees read the Plan-Mode output, then switch to Agent and approve |
| Round 2 (steer + self-correct in **Agent Mode**) | ~9 min | A test runs; agent loops on failure |
| Debrief | ~3 min | "When did you steer? When did you let it run?" |

## What to listen for in the debrief

- Did the plan match their intent, or did they catch a drift and steer?
- At what moment did they feel comfortable letting it run unattended?
- Did the agent's first cmdlet pass all tests, or did it self-correct? On what?
- Did anyone over-engineer the prompt and get a bloated module back?

## Common stumbles + fast fixes

| Symptom | Fix |
| --- | --- |
| Agent finishes without running the test | Add: "Now run the test and show me the output." |
| Agent edits files outside this folder | Interrupt; restate scope: "Only work inside `labs/L3-agent-mode-playground/starter`." |
| Test can't find the function | Ensure the module is imported with `-Force` and the function is exported. |
| `ValidateSet` not used (manual `if` checks) | Fine — both pass. Mention `[ValidateSet]` as the idiomatic pattern in debrief. |
| No agent-mode tool available | Walk the `solution/` build manually on the shared screen — show each file, run the test, narrate what Agent Mode *would* have done. |

## Why Plan Mode for Round 1, Agent Mode for Round 2

Modern Agent Mode auto-executes its own todo list and only pauses for terminal commands — by the time you've "read the plan," the agent has already created files. That breaks Round 1's pedagogical intent ("read the plan **before** you approve").

**Autopilot is on by default as of VS Code 1.124 (June 2026).** Settings involved:

- `chat.permissions.default` — default permission level for new chats; tightening this restores approve-each-step behavior
- `chat.tools.global.autoApprove` — org-level visibility/usage of Autopilot
- `chat.autopilot.advanced.enabled` — opt-in: a small utility model decides when the task is truly done (max three loops)

Plan Mode produces a written plan with no side effects. Participants read it, optionally edit it, and then switch to Agent Mode to execute. This also reinforces Module 10's four-stage loop diagram (Plan → Edit → Run → Correct) — they literally use the Plan stage as its own mode.

Round 2 uses Agent Mode because the point shifts: from *seeing the plan* to *watching the loop execute and self-correct* (the test failure → fix → re-run cycle).

**Clarifying questions in Plan Mode.** Plan Mode often asks 1–3 clarifying questions before finalizing the plan (e.g., "stub vs full implementation?"). Coach attendees to pick **Stub version** for Round 1 — that keeps the scaffold minimal and leaves the real dev/test/prod logic for Round 2. Picking *Full implementation* collapses both rounds into one and removes the self-correction beat we want them to see in Round 2.

**Start Implementation vs Start with Autopilot.** When the plan is done, Plan Mode offers a row of buttons. Tell them to click **Start Implementation** — it hands the plan to Agent Mode and runs it step by step (with normal approval gates on terminal commands). **Start with Autopilot** runs the plan with the 3-loop utility-model auto-completion; great for trusted workflows, but it hides the very loop we want them to watch. *Open in Editor* dumps the plan into a markdown file for hand-editing — useful demo aside but not the default path here.

If a participant's Copilot install does not show **Plan** in the mode selector (older extension version), have them stay in Agent Mode and pre-empt the auto-execution by adding to the prompt: `Show me your plan first and wait for my approval before making any changes.`

## Reference build

`solution/InfraOps/InfraOps.psm1` + `solution/Run-Tests.ps1`. Validate with:

```powershell
pwsh -NoProfile -File labs\L3-agent-mode-playground\solution\Run-Tests.ps1
```

Expected: 5 PASS lines and `All L3 checks passed.` (exit 0).

## Stretch coaching

If a pair finishes early, push them into the stretch in the README (add a
`-Default` fallback, or convert the harness to real Pester). The point of the
stretch is **another loop iteration** — adding a requirement and watching the
agent plan/execute/review again — not just more code.
