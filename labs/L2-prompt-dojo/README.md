# L2 — Prompt Dojo · Context Engineering

**Format:** Dojo (kata-style rounds)  
**Core time:** 15 minutes (Day 1 bonus) or 25 minutes (Day 2 standard)  
**Goal:** Practice rewriting vague prompts into specific prompts and observe the output quality difference.

L2 is a prompting lab, not a coding lab. You will take a deliberately vague ask, add the missing context, run both versions through Copilot Chat, and compare the shape of the result.

---

## What this lab teaches

> **A prompt that looks short is not more elegant — it is usually missing context. Rich context unlocks output quality.**

Copilot works with what you feed it: your prompt, the active file, nearby code, and any explicit constraints you give it. The better you define the task, the less iteration you burn.

---

## How to use it

### Pick your mode at a glance

| Mode | Use when | Rounds | Debrief | Stretch |
| --- | --- | --- | --- | --- |
| **Day 1 bonus · 15 min** | You have spare time after L1 and want a fast dojo | Round 1 + Round 2 | No | No |
| **Day 2 standard · 25 min** | You are running the full L2 slot | Round 1 + Round 2 + Round 3 | Yes, 3-4 min | Yes, last 3 min |

### Day 1 bonus path — 15 minutes

1. Give the 30-second frame: same task, more context, better output.
2. Run **Round 1** and **Round 2** only.
3. Attendees compare their results against the solution folder on their own.
4. End without group share-out.

### Day 2 standard path — 25 minutes

1. Give the 2-minute frame: this is a dojo for turning vague prompts into usable prompts.
2. Run **Round 1**, **Round 2**, and **Round 3**.
3. Debrief for 3-4 minutes: ask what context people added.
4. If time remains, do the optional stretch: design your own vague→specific pair from your domain.

---

## Dojo philosophy

Context engineering is the practical skill of choosing what to feed the model. In this lab, the work is not "write the code"; the work is "decide which constraints, file details, conventions, and output expectations matter enough to say out loud."

If you run L2 before Module 5 — Context is King, use this simple primer: Copilot reads what it can see, not what you meant. Add the rules, target shape, version, naming expectations, and source snippet a human would need.

---

## Round-by-round overview

| Round | Title | Framing |
| --- | --- | --- |
| 1 | **Terraform — Variable Validation** | Add the exact rules Copilot needs so validation becomes specific instead of generic. |
| 2 | **Terraform — Module Structure** | Define the module contract so Copilot stops guessing cloud, inputs, and outputs. |
| 3 | **PowerShell — Error Handling** | Supply the function, error types, and return contract so the script handling becomes deliberate. |

---

## What's in the folder

| Path | Purpose |
| --- | --- |
| `starter/` | Blank round files for attendees: vague prompt, space for rewrite, and the outcome to aim for |
| `solution/round-*-target.md` | Target specific prompts, expected-shape examples, and commentary on what context changed |
| `solution/round-1-validation-example.tf` | Runnable HCL example for Round 1 shape checking |
| `solution/round-2-storage-module/` | Runnable Terraform module example for Round 2 shape checking |
| `solution/round-3-copy-safefile.ps1` | Runnable PowerShell reference for Round 3 shape checking |
| `solution/facilitator-notes.md` | Optional debrief prompts and common patterns to highlight |

Starter has your blank rounds. Solution has the target prompts and expected-shape examples.

---

## How attendees work each round

1. Open the starter file for the round.
2. Paste the vague prompt into Copilot Chat and note the output shape.
3. Rewrite the prompt with the missing context.
4. Run the rewritten prompt and compare the output.
5. Check the solution folder for the expected output shape.

---

## Self-check guidance

Do **not** diff against the solution line by line. Success here is shape, not sameness.

You got it if your rewritten prompt causes Copilot to produce the right kind of answer:

- the Terraform variable includes the right validation structure
- the Terraform module is clearly Azure-targeted with the expected interface
- the PowerShell function validates, catches, logs, and returns a boolean contract

Multiple prompt rewrites can be correct. The lesson is that the prompt shift improves the draft.

---

## Safety rules

- Use only synthetic examples from this lab.
- Do not paste secrets, customer data, or production infrastructure details into Copilot Chat.
- Treat generated code as a draft and review it before running it.
- Do not paste internal company data outside approved governance into Copilot prompts.

---

## Optional stretch

Design your own dojo round from your daily work:

1. Write one vague prompt.
2. Rewrite it with the context Copilot would actually need.
3. Swap with a partner and compare the outputs.

---

## Theory follow-up

After the lab, use `presentations/M5-context-is-king.html` for the theory framing that reinforces what attendees just practiced.
