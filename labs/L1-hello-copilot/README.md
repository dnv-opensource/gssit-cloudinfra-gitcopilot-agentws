# L1 — Lab: Hello, Copilot

**Module:** L1  
**Format:** Hands-on lab  
**Core time box:** 20 minutes  
**Stretch time:** optional 15–20 minutes  
**Goal:** Validate your local setup, then use GitHub Copilot completions and chat to build a small PowerShell utility.

This lab is intentionally small. The core path fits the Day 1 20-minute slot. If the agenda allows a longer lab window, use the stretch steps.

---

## What you will build

You will complete a PowerShell function named `New-ResourceSlug`.

The function turns infrastructure naming inputs into a safe resource slug:

> **What's a resource slug?** It's a short, URL-safe, lowercase identifier, usually derived from a resource name—for example, `payments-prod` for "Payments Production". In Azure and IaC, it helps keep names predictable and easier to make unique while avoiding spaces, special characters, and policy-unfriendly formats.

```powershell
New-ResourceSlug -Project "Cloud Platform" -Environment "Dev" -Service "API Gateway"
```

Expected result:

```text
cloud-platform-dev-api-gateway
```

The utility is simple on purpose. The learning target is the workflow:

1. Use inline completions to draft code from comments.
2. Use Copilot Chat to explain or improve the draft.
3. Run the script locally and verify behavior.

---

## Files

| Path | Purpose |
| --- | --- |
| `starter/hello-copilot.ps1` | Participant starter file with TODOs and validation checks |
| `solution/hello-copilot.ps1` | Reference solution for facilitators or post-lab review |

---

## Safety rules for this lab

- Use only synthetic examples from the starter file.
- Do not paste secrets, customer data, production resource names, or private infrastructure details into Copilot Chat.
- Verify generated code before running it.

---

## Core path — 20 minutes

### 0:00–0:05 — Setup validation

Open PowerShell 7 in the repository root and run:

```powershell
pwsh --version
git --version
gh --version
gh auth status
gh copilot -i "explain what this PowerShell command does: Get-ChildItem"
```

Open the lab in VS Code:

```powershell
code labs\L1-hello-copilot\starter\hello-copilot.ps1
```

You are ready when:

- VS Code opens the starter file.
- GitHub Copilot is signed in.
- `gh copilot -i "what is a haiku?"` returns an explanation.
- You can run PowerShell scripts locally.

If `gh copilot` is not available, continue with VS Code Copilot Chat and ask a facilitator for CLI setup help.

### 0:05–0:13 — Use completions to implement the function

In `starter/hello-copilot.ps1`, find the TODO inside `New-ResourceSlug`.

Use GitHub Copilot to suggest an implementation—either via **Copilot Chat in VS Code** (highlight the TODO and ask for help) or **Copilot CLI** (`gh copilot suggest "..."`). Accept, edit, or reject suggestions as needed.

The function should:

- Join `Project`, `Environment`, and `Service`.
- Lowercase the result.
- Replace spaces and underscores with hyphens.
- Remove characters that are not letters, numbers, or hyphens.
- Collapse repeated hyphens.
- Trim leading and trailing hyphens.

### 0:13–0:17 — Run the validation checks

From the repository root:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File labs\L1-hello-copilot\starter\hello-copilot.ps1
```

Expected result:

```text
PASS: basic resource slug
PASS: trims repeated separators
PASS: removes unsafe characters
All L1 checks passed.
```

**Note:** If you use Copilot Chat, it may offer to run this validation command for you automatically. You can allow it to run or execute the command manually yourself.

If a check fails, copy the error text and ask Copilot Chat:

```text
This PowerShell function should normalize resource names. Here is the failing check and the function. Explain the bug and suggest the smallest fix.
```

### 0:17–0:20 — Chat review

Ask Copilot Chat one of these:

```text
Explain this PowerShell function in plain language for a teammate who is new to scripting.
```

```text
Review this function for edge cases. Keep the utility simple enough for a beginner lab.
```

Make one small improvement if Copilot suggests something useful and you understand it.

---

## Optional stretch — if you have more time

Choose one:

### Stretch A — Add a maximum length

Add an optional parameter:

```powershell
[int]$MaxLength = 63
```

Trim the slug to that length without leaving a trailing hyphen.

### Stretch B — Add a prefix

Add an optional `-Prefix` parameter so the result can include a team or platform prefix:

```powershell
New-ResourceSlug -Prefix "dnv" -Project "Cloud Platform" -Environment "Dev" -Service "API Gateway"
```

Expected result:

```text
dnv-cloud-platform-dev-api-gateway
```

### Stretch C — Ask for tests first

Use Copilot Chat:

```text
Suggest three additional Pester-style test cases for this resource slug function. Do not add external dependencies.
```

Then convert one suggestion into a simple `Assert-Equal` check in the starter file.

---

## Completion checkpoint

You are done with the core lab when:

- The starter script runs without failures.
- You used at least one inline completion.
- You used Copilot Chat to explain, review, or fix the code.
- You can describe what you accepted from Copilot and what you changed manually.

Facilitator note: If time is tight, stop at the passing checks. The stretch steps are safe to skip.
