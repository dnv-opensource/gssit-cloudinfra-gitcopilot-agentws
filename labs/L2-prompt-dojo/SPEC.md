# L2 — Prompt Dojo · Context Engineering

**SPEC for Neo (Lab Engineer)**  
**Designed by:** Oracle (Curriculum Designer)

---

## 1. One-Line Thesis

> **What attendees believe at lab end that they didn't believe at lab start:**
>
> "A prompt that looks short isn't more elegant — it's missing context. Rich context unlocks output quality."

This pairs with M5's thesis: *"Context is the lever that reduces iteration time."* L2 is the hands-on dojo where attendees practice that.

---

## 2. Time Budget

| Duration | Mode | Context |
|----------|------|---------|
| **15 min** | Day 1 Bonus | If Day 1 finishes early (spare time after L1, before M5) |
| **25 min** | Day 2 Standard | Original slot per run-of-show (15:10–15:35 on Day 2) |

### What Gets Stripped at 15-min (Day 1 Bonus Mode)

- **2 rounds only** (skip Round 3: PowerShell)
- **No facilitator-led debrief** — attendees self-debrief by comparing their output to expected shape
- **No "design your own" stretch** — skip entirely
- Facilitator may circulate silently but does not pause for group share-out

### What Gets Added at 25-min (Day 2 Standard Mode)

- **All 3 rounds** included
- **Facilitator debrief** (3–4 min): pull 1–2 attendee prompts, highlight what context they added
- **Optional stretch** (last 3 min): "Design your own dojo round" — attendees draft a vague→specific pair in their domain for peer swap
- Facilitator reveals the "target" specific prompt for each round at debrief

---

## 3. Format: Dojo Rounds

**Shape:** 3 rounds (2 rounds in 15-min mode). Each round follows this kata:

1. **Present:** Attendee sees a deliberately vague prompt
2. **Practice:** Attendee rewrites it to be specific (using context layers learned in M5)
3. **Observe:** Attendee runs both prompts through Copilot Chat, compares output quality
4. **Reflect:** Brief note on what context dimension improved the result

**Round Timing (25-min mode):**

| Phase | Time | Description |
|-------|------|-------------|
| Intro | 2 min | Facilitator frames the dojo: "Same prompt, more context, better output" |
| Round 1 | 6 min | Terraform — variable validation |
| Round 2 | 6 min | Terraform — module structure |
| Round 3 | 6 min | PowerShell — error handling |
| Debrief | 4 min | Facilitator share-out + stretch option |
| Buffer | 1 min | Transition |

**Round Timing (15-min mode):**

| Phase | Time | Description |
|-------|------|-------------|
| Intro | 1 min | Brief frame |
| Round 1 | 6 min | Terraform — variable validation |
| Round 2 | 6 min | Terraform — module structure |
| Self-check | 2 min | Compare against expected shape in solution folder |

---

## 4. Round Content (3 Domains)

### Round 1: Terraform — Variable Validation

**Why this domain:** Aligns with DNV's daily IaC work. Validation prompts require you to think through rules — which is the actual work.

**Deliberately Vague Starter Prompt:**

```text
Add validation to my Terraform variable.
```

**Target Specific Prompt (for Neo/facilitator — NOT shown to attendees):**

```text
Add validation to this Terraform variable for an Azure resource group name:

variable "resource_group_name" {
  type = string
}

Validation rules:
1. Length must be 1-90 characters
2. Can only contain alphanumerics, hyphens, underscores, and periods
3. Cannot end with a period
4. Error message should show the invalid value and explain the constraint
```

**Why this contrast lands:**
- **Context dimension changed:** Schema (the variable declaration), constraint rules (explicit numbered list), error message behavior
- **What Copilot gets with vague prompt:** Generic validation stub, often missing the actual constraints
- **What Copilot gets with specific prompt:** Production-ready validation block with custom error message

**Expected outcome shape (rubric for self-check):**

- Contains `validation` block inside `variable` declaration
- Has `condition` with regex or length checks
- Has `error_message` that references `var.resource_group_name`

---

### Round 2: Terraform — Module Structure

**Why this domain:** Module design requires thinking about interfaces. Context surfaces those decisions explicitly.

**Deliberately Vague Starter Prompt:**

```text
Create a Terraform module for storage.
```

**Target Specific Prompt (for Neo/facilitator — NOT shown to attendees):**

```text
Create a Terraform module for Azure Storage with:

Required inputs:
- storage_account_name (3-24 chars, lowercase alphanumeric only)
- resource_group_name
- location

Optional inputs with defaults:
- sku_name (default: "Standard_LRS", allowed: Standard_LRS, Standard_GRS, Standard_ZRS)
- public_network_access_enabled (default: false)

Outputs:
- storage_account_id
- primary_blob_endpoint

Include:
- A brief description comment at the top
- Use Terraform 1.5+ syntax
```

**Why this contrast lands:**
- **Context dimension changed:** Input/output contract, explicit defaults, version target, security posture (public network access)
- **What Copilot gets with vague prompt:** Generic storage module with AWS or Azure guessing, no outputs, random defaults
- **What Copilot gets with specific prompt:** Azure-targeted module with correct variable shapes, outputs wired, security-aware defaults

**Expected outcome shape (rubric for self-check):**

- Has `variable` blocks for all specified inputs with types and defaults
- Has `resource "azurerm_storage_account"` (not AWS)
- Has `output` blocks for both specified outputs
- Contains description or `#` comment at top

---

### Round 3: PowerShell — Error Handling

**Why this domain:** Familiar from L1. Bridges back to Day 1 context. Error handling is where context matters most.

**Deliberately Vague Starter Prompt:**

```text
Add error handling to this script.
```

**Target Specific Prompt (for Neo/facilitator — NOT shown to attendees):**

```text
Add error handling to this PowerShell function that copies files:

function Copy-SafeFile {
    param(
        [string]$Source,
        [string]$Destination
    )
    Copy-Item -Path $Source -Destination $Destination
}

Error handling requirements:
1. Validate that $Source exists before copying
2. Create $Destination directory if it doesn't exist
3. Use try/catch with specific error types (ItemNotFoundException, UnauthorizedAccessException)
4. Log errors to a $ErrorLog array passed by reference
5. Return $true on success, $false on failure
```

**Why this contrast lands:**
- **Context dimension changed:** The actual function code (file context), specific error types, return contract, logging pattern
- **What Copilot gets with vague prompt:** Generic try/catch wrapper, often missing pre-validation or specific catches
- **What Copilot gets with specific prompt:** Production-ready error handling with validation, specific exception types, structured logging

**Expected outcome shape (rubric for self-check):**

- Has `Test-Path` or equivalent pre-validation
- Has `try/catch` block
- Catches at least one specific exception type
- Returns boolean
- Writes to error log array

---

## 5. Scaffolding Pattern — L1→L2 Step-Down

### The Progression Principle (L1→L5)

| Lab | Scaffolding Level | What's Inline | What Attendees Must Supply |
|-----|-------------------|---------------|----------------------------|
| **L1** | Full scaffolding | Numbered TODOs (1-6), inline Copilot prompt hints | Implementation only |
| **L2** | Reduced scaffolding | Round headers, vague prompt verbatim, blank space for rewrite, expected outcome description | Context (their own specific prompt) |
| **L3** | Minimal scaffolding | Task description, entry point | Multi-step plan + implementation |
| **L4** | Goal-only | Scenario + success criteria | Agent configuration + instructions |
| **L5** | Free-form | Problem statement only | Design, implementation, validation |

### L2-Specific: What Stays Inline in Starter

- **Round headers** with timing guidance (e.g., "Round 1 — Terraform Variable Validation · 6 min")
- **Vague prompt verbatim** — shown exactly as attendees will paste to Copilot
- **Blank space** for attendee's rewrite (marked with `# YOUR SPECIFIC PROMPT HERE`)
- **Expected outcome description** (rubric, not code) — what shape should the result have?
- **Instructions for comparison** — "Run the vague prompt, then run your specific prompt, observe the difference"

### L2-Specific: What Moves to README Only

- Dojo philosophy (why vague→specific matters)
- M5 connection (context layers callback)
- Facilitator framing
- "Why this contrast lands" explanations
- The target specific prompts (solution folder only)

### L2-Specific: What Gets Removed Entirely

- **Numbered TODO ladders** — L2 is NOT hand-holding; attendees must think about what context to add
- **Inline Copilot prompt hints** — the point is for attendees to craft their own
- **Step-by-step implementation guidance** — this is not a coding lab, it's a prompting lab

---

## 6. Self-Check Mechanism

### L1 Pattern (for contrast)

L1's self-check: Run the script, see `PASS: ...` messages. Binary pass/fail.

### L2 Pattern (different)

L2's self-check: **Shape-based rubric comparison**, not exact match.

**How it works:**

1. Attendee runs their specific prompt through Copilot Chat
2. Attendee compares output against "Expected outcome shape" in the solution folder
3. Success = output has the structural elements listed (validation block, outputs, error handling pattern)
4. **No strict diff** — multiple correct implementations exist; the lesson is *the prompt got better*, not *the code matches exactly*

**Solution folder contains:**

- `solution/round-1-target.md` — the target specific prompt + expected shape rubric
- `solution/round-2-target.md` — same pattern
- `solution/round-3-target.md` — same pattern
- `solution/facilitator-notes.md` — debrief talking points, common attendee patterns to highlight

Attendees do NOT need passing tests. They need to observe that their specific prompt produced structurally better output than the vague prompt.

---

## 7. Facilitator Notes

**During the dojo:**

1. **Walk the room** (or monitor Teams chat if remote) — observe what context attendees are adding
2. **Don't reveal target prompts early** — let attendees struggle with "what context should I add?"
3. **Note interesting patterns** — who added schema? Who added version targets? Who added error message guidance?
4. **Time-keep ruthlessly** — each round has 6 minutes; call time even if some attendees aren't done

**At debrief (25-min mode only):**

1. Pull 1–2 attendee prompts (ask for volunteers or screenshot from Teams chat)
2. Highlight what context dimension they added (schema, constraints, version, output contract)
3. Then reveal the "target" specific prompt — show it's not magic, just explicit context
4. Ask: "What did the specific prompt include that you didn't think of?"

**Common facilitator interventions:**

- If attendee is stuck: "What information would a human need to do this task correctly? Add that."
- If attendee over-specifies: "That's great detail — but did Copilot need all of it? What was essential?"
- If attendee copies target prompt early: "Try yours first — you'll learn more from the comparison."

---

## 8. Time-Budget Summary

| Mode | Rounds | Debrief | Stretch | Self-Check |
|------|--------|---------|---------|------------|
| 15-min (Day 1 Bonus) | 2 | No | No | Attendee compares to solution folder silently |
| 25-min (Day 2 Standard) | 3 | Yes (4 min) | Yes (optional 3 min) | Attendee compares + facilitator reveals targets |

---

## 9. Dependencies — L1 and M5

### Prerequisites Confirmed

L2 can run on **Day 1 after L1** because:

- **M1:** Completed — workshop intro, environment check done
- **M2:** Completed — inline completions understood (not directly used in L2, but foundational)
- **M4:** Completed — Copilot Chat basics understood (required for L2 — attendees use chat to test prompts)
- **L1:** Completed — attendees have validated setup, written one working function with Copilot

### No Forward Dependencies

L2 does NOT require:

- M5 (Context is King) — nice to have, but L2 can run before M5 in Day 1 bonus mode. The dojo teaches context experientially; M5 provides theory afterward.
- M7 (Assistant to Agent) — not relevant to L2
- M10 (Agent Mode Deep Dive) — Day 2 only
- M12 (MCP Showcase) — not used in L2

### If Running Before M5 (Day 1 Bonus Mode)

The README should include a brief "context layers" primer (2 sentences) so attendees know what to vary. Example:

> "Copilot reads everything it can see: your active file, open tabs, and what you write in the prompt. When you add detail — like specific constraints, version targets, or expected output — Copilot produces better results."

---

## 10. Anti-Patterns for Neo

### ❌ Don't Include Numbered TODO Ladders

L1 has `# TODO: 1. ... 2. ... 3. ...` because inline TODO format IS the lesson there (rich context → good completion). L2 is different. The lesson here is that attendees must **invent** the context themselves. Numbered ladders would defeat the purpose.

### ❌ Don't Provide Sample Implementations

The starter should NOT include code snippets showing what good output looks like. The comparison is between vague-prompt output and specific-prompt output — both generated by Copilot during the lab.

### ❌ Don't Use Bicep

Per decisions.md (Terraform-primary for DNV), all IaC examples must be Terraform. No Bicep.

### ❌ Don't Include Dates

Per decisions.md (dates-out policy), no dates in any content.

### ❌ Don't Make Rounds Dependent

Each round is self-contained. Attendees can skip or fail a round and still do the next. Don't chain them.

### ❌ Don't Over-Engineer the Starter File

The starter is a simple prompt-collection document, not a script. It could be a single `.md` file per round, or one combined file with clear section breaks. Keep it lightweight.

### ❌ Don't Put Target Prompts in README

Target prompts live in `solution/` only. Attendees should not see them until they've attempted their own rewrite.

---

## 11. Folder Structure for Neo

```text
labs/L2-prompt-dojo/
├── README.md              # Lab overview, safety rules, timing, dojo philosophy
├── starter/
│   ├── round-1-terraform-validation.md    # Vague prompt + blank space for rewrite
│   ├── round-2-terraform-module.md        # Vague prompt + blank space for rewrite
│   └── round-3-powershell-errors.md       # Vague prompt + blank space for rewrite
└── solution/
    ├── round-1-target.md                  # Target specific prompt + expected shape rubric
    ├── round-2-target.md                  # Target specific prompt + expected shape rubric
    ├── round-3-target.md                  # Target specific prompt + expected shape rubric
    └── facilitator-notes.md               # Debrief talking points, common patterns
```

Alternative (simpler): Single `starter/dojo-rounds.md` with all three rounds in one file. Either works; Neo's call.

---

## 12. README Template for Neo

```markdown
# L2 — Prompt Dojo · Context Engineering

**Format:** Dojo (kata-style rounds)  
**Core time:** 15 minutes (Day 1 bonus) or 25 minutes (Day 2 standard)  
**Goal:** Practice rewriting vague prompts into specific prompts and observe the output quality difference.

This lab is the hands-on companion to M5 "Context is King." You will:

1. See a deliberately vague prompt
2. Rewrite it with rich context
3. Run both through Copilot Chat
4. Compare the results

---

## What You Will Learn

A prompt that looks short isn't more elegant — it's missing context. By adding explicit constraints, schema, version targets, and expected output shapes, you unlock dramatically better Copilot results.

---

## Safety Rules

- Use only synthetic examples from the starter files
- Do not paste secrets, customer data, or production infrastructure details into Copilot Chat
- Treat generated code as a draft; review before using

---

## Rounds

| Round | Domain | Time |
|-------|--------|------|
| 1 | Terraform — Variable Validation | 6 min |
| 2 | Terraform — Module Structure | 6 min |
| 3 | PowerShell — Error Handling | 6 min (Day 2 only) |

Open the starter file for each round. Follow the instructions inside.

---

## Self-Check

After each round, compare your Copilot output against the expected shape in `solution/`. Success means your specific prompt produced structurally better output than the vague prompt — not an exact code match.

---

## If You Finish Early

Try the "design your own dojo round" stretch: Draft a vague→specific prompt pair from your own work. Swap with a neighbor.
```

---

## Summary

L2 is the first scaffolding step-down from L1. Where L1 hand-holds with numbered TODOs (because the inline format IS the lesson), L2 removes the ladder and asks attendees to invent context themselves. The dojo format — vague prompt → rewrite → compare — makes the lesson visceral.

**Key design decisions:**

1. 3 rounds (2 in 15-min mode): Terraform validation, Terraform module, PowerShell errors
2. Scaffolding stripped: no numbered TODOs, no inline hints, no sample implementations
3. Self-check = shape rubric, not strict diff
4. Target prompts hidden in solution folder until debrief
5. No dependencies beyond L1 + M4; can run before M5 if needed

---

*Prepared by Oracle, Curriculum Designer · For Neo*
