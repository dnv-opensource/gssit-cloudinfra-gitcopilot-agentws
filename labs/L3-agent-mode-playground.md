# L3: Agent Mode Playground — Autonomous Tasks

**Day 2 · 15:35–16:00 (25 minutes core; optional stretch +10–15 min)**

> Your first time *driving* GitHub Copilot Agent Mode. In Module 10 — Agent Mode Deep Dive you watched the loop; here you run it — you give direction, the agent plans and executes, and you decide when to interrupt and when to let it run.

> *The function is intentionally tiny — the skill you're practicing is observing **plan → execute → review → steer**, not writing the cmdlet. The stretch tracks add depth if you finish early.*

---

## 🎯 What You'll Do

1. **Engage Agent Mode** — Switch the Copilot chat view to Agent and scope it to the lab folder
2. **Read the plan** — Start with a vague prompt and watch the agent decompose it into steps and tool calls
3. **Steer it** — Add the real contract, then watch the agent run the test and self-correct on failures
4. **Reflect** — Notice when you steered and when you let the loop run

---

## ✅ Prerequisites Checklist

Before you sit down for the lab, confirm:

- [ ] **VS Code** with GitHub Copilot signed in, and **Agent Mode** available (chat mode selector → Agent)
- [ ] **PowerShell 7** runnable in the integrated terminal (`pwsh --version`)
- [ ] **GitHub CLI** authenticated (`gh auth status`)
- [ ] You attended **M10 — Agent Mode Deep Dive** (this lab is the simulator for it)

**Still setting up?** See the Day 2 additions in [prerequisites.md](../prerequisites.md).

**Already done?** Open the starter folder: `code labs\L3-agent-mode-playground\starter`

---

## 🔧 The Lab Flow (25 minutes core)

- **Part 1: Setup validation (6 min)** — Confirm Agent Mode and the integrated terminal both work
- **Part 2: Round 1 — start vague (7 min)** — Loose prompt; *read the plan* before approving, then watch the tool calls
- **Part 3: Round 2 — steer (9 min)** — Give the real `Get-RetentionDays` contract; watch the agent run the test and fix failures on its own
- **Part 4: Debrief (3 min)** — When did you steer vs. let it run?

This is **vanilla** agent mode — file edits and a terminal run, no MCP yet. The full walkthrough, scenario, and prompts are in **[L3-agent-mode-playground/README.md](./L3-agent-mode-playground/README.md)**.

---

## 🎁 What You'll Have

After L3:
- ✅ Drove a full agent loop: plan → execute → review → steer
- ✅ Saw the agent run a test, read PASS/FAIL, and self-correct
- ✅ A working `InfraOps` module with `Get-RetentionDays`
- ✅ Confidence to know when to interrupt and when to trust the loop

**Success is the loop, not the code.** A passing test is the bonus.

---

## 🚨 Troubleshooting During the Lab

| Issue | Solution |
|-------|----------|
| Agent Mode missing from the chat mode selector | Reload VS Code; confirm the GitHub Copilot Chat extension is signed in and up to date |
| Agent edits files outside the lab folder | Interrupt it; re-scope to `starter/` and restate the boundary |
| Terminal command won't run | Confirm PowerShell 7 (`pwsh --version`) is the integrated-terminal shell |
| Agent stalls or over-engineers | Reject the plan, tighten the prompt with the explicit contract, re-run |

**Still stuck?** Raise your hand — the fallback is to watch the facilitator drive the loop on the shared screen.

---

## 📖 Reference

- **Full Lab Walkthrough:** [L3-agent-mode-playground/README.md](./L3-agent-mode-playground/README.md)
- **Workshop README:** [README.md](../README.md)
- **Prerequisites Setup:** [prerequisites.md](../prerequisites.md)
- **Facilitator Notes:** [solution/facilitator-notes.md](./L3-agent-mode-playground/solution/facilitator-notes.md)
- **Theory:** [M10 — Agent Mode Deep Dive](../presentations/M10-agent-mode-deep-dive.html)

---

## 💬 Questions?

- **During the lab:** Ask in Teams chat or raise your hand
- **Before the workshop:** Email Jan Egil Ring or Haflidi Fridthjofsson

---

**You watched the loop in M10. Now grab the wheel.** 🚀
