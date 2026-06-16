# L2: Prompt Dojo — Context Engineering

**Self-paced — run on your own time.** Day 2 is time-pressured, so this lab is no longer in the live agenda. We covered the core idea in **[Module 5 — Context is King](../presentations/M5-context-is-king.html)** and practiced it in the Teams chat exercise during Day 1. The lab below remains fully runnable on your own; it deepens the muscle with three structured rounds.

> A kata-style dojo for turning vague prompts into specific ones. You take a deliberately under-specified ask, add the context Copilot actually needs, run both versions through Copilot Chat, and compare the shape of the result. This is the first scaffolding step-down from L1 — no numbered TODOs, you invent the context yourself.

In the live Day 2 schedule, **L3 — Agent Mode Playground** runs in the slot after the Module 10 — Agent Mode Deep Dive break.

---

## 🎯 What You'll Do

1. **See a vague prompt** — Start each round with a deliberately under-specified ask
2. **Add the missing context** — Rewrite it with schema, constraints, version targets, and expected output
3. **Compare the output** — Run both prompts through Copilot Chat and watch the quality shift
4. **Reflect** — Notice which context dimension made the difference

---

## ✅ Prerequisites Checklist

Before you sit down for the lab, confirm:

- [ ] **VS Code** with GitHub Copilot signed in and **Copilot Chat** available
- [ ] **GitHub CLI** authenticated (`gh auth status`)
- [ ] You can open a chat panel and send a prompt (M4 — Copilot Chat basics)

**Still setting up?** See [prerequisites.md](../prerequisites.md).

**Already done?** Open the starter folder: `code labs\L2-prompt-dojo\starter`

---

## 🔧 The Lab Flow (25 minutes core)

- **Intro: frame the dojo (2 min)** — Same task, more context, better output
- **Part 1: Round 1 — Terraform variable validation (6 min)** — Add the exact rules so validation becomes specific, not generic
- **Part 2: Round 2 — Terraform module structure (6 min)** — Define the contract so Copilot stops guessing cloud, inputs, and outputs
- **Part 3: Round 3 — PowerShell error handling (6 min)** — Supply the function, error types, and return contract
- **Debrief (4 min)** — What context did people add? Optional stretch: design your own vague→specific pair

Each round is self-contained — skip or stumble on one and the next still works. The full walkthrough, safety rules, and round-by-round instructions are in **[L2-prompt-dojo/README.md](./L2-prompt-dojo/README.md)**.

### Quick win — your first 5 minutes

Open `starter/round-1-terraform-validation.md`, paste the vague prompt into Copilot Chat exactly as written, and note the shape of what comes back. *That* generic result is your baseline — everything after is about beating it with context.

---

## 🎁 What You'll Have

After L2:
- ✅ Practised rewriting vague prompts into context-rich ones across three domains
- ✅ Seen first-hand how schema, constraints, and output contracts change Copilot's draft
- ✅ A repeatable instinct: feed Copilot what a human would need to do the task

**Success is shape, not sameness.** Multiple rewrites can be correct — the lesson is that the prompt got better.

---

## 🚨 Troubleshooting During the Lab

| Issue | Solution |
|-------|----------|
| Copilot Chat not responding | Confirm the GitHub Copilot Chat extension is signed in; reload VS Code |
| Vague and specific output look the same | Add more explicit context — schema, rules, version target, expected output shape |
| Not sure what context to add | Ask: "What would a human need to do this task correctly?" Add exactly that |
| Round feels too open-ended | That's intentional — there's no single right answer; aim for a better-shaped draft |

**Still stuck?** Raise your hand or ask the room. Check the expected-shape rubric in the solution folder — but only after your own attempt.

---

## 📖 Reference

- **Full Lab Walkthrough:** [L2-prompt-dojo/README.md](./L2-prompt-dojo/README.md)
- **Workshop README:** [README.md](../README.md)
- **Prerequisites Setup:** [prerequisites.md](../prerequisites.md)
- **Facilitator Notes:** [solution/facilitator-notes.md](./L2-prompt-dojo/solution/facilitator-notes.md)
- **Theory:** [M5 — Context is King](../presentations/M5-context-is-king.html)

---

## 💬 Questions?

- **During the lab:** Ask in Teams chat or raise your hand
- **Before the workshop:** Email Jan Egil Ring or Haflidi Fridthjofsson

---

## ➡️ After This Lab

L3 starts immediately at 15:35. You sharpened *your* prompts here; in **[L3 — Agent Mode Playground](./L3-agent-mode-playground.md)** you hand the wheel to the agent and watch it plan, execute, and self-correct.

---

**Short prompts aren't elegant — they're missing context. Let's fix that.** 🥋
