# L1: "Hello, Copilot" — First Contact Setup Validation

**Day 1 · 15:55–16:15 (20 minutes core; optional stretch up to 40 minutes)**

> Your first hands-on with GitHub Copilot. We'll validate your environment and write a small utility together using completions and chat.

---

## 🎯 What You'll Do

1. **Verify Your Setup** — Is Copilot working end-to-end?
2. **Write a Small Utility** — A PowerShell function built with Copilot guidance
3. **Use Copilot Chat** — Ask questions about your code; understand the workflow
4. **Celebrate** — You've written real code with AI. This is the confidence builder.

---

## ✅ Prerequisites Checklist

Before you sit down for the lab, confirm:

- [ ] **Windows 11** with command-line access (PowerShell 7+)
- [ ] **VS Code** installed with GitHub Copilot Chat extension
- [ ] **GitHub CLI** installed and authenticated (`gh auth status` shows you're logged in)
- [ ] **GitHub Copilot CLI** installed as GitHub CLI extension (`gh copilot --version`)
- [ ] **PowerShell 7** running (launch `pwsh` from cmd or PowerShell)
- [ ] **Copilot license** verified in your GitHub account (Settings > Billing > GitHub Copilot)

**Still setting up?** Go to [prerequisites.md](../prerequisites.md) — 20–30 minutes to completion.

**Already done?** Test quickly:

```powershell
# In PowerShell 7, run:
gh auth status
gh copilot -i "explain git status"
```

If both work, you're ready for the lab.

---

## 🔧 The Lab Flow (20 minutes core)

### Part 1: Setup Validation (5 min)

The facilitator will walk through a quick checklist:

```powershell
# Verify each of these works:
gh auth status              # GitHub CLI authenticated
gh copilot --version        # Copilot CLI installed
code --version              # VS Code installed (or Get-Command code on Windows)
pwsh -v                     # PowerShell 7 running
git --version               # Git installed
```

**Note:** On Windows, `code --version` may open VS Code instead of printing the version. If that happens, open the Help -> About menu item to confirm current version.

✅ All working? Move to Part 2.
❌ Something failed? Raise your hand—facilitator will troubleshoot or pair you with a peer.

### Part 2: Core Build (12 min)

**Scenario:** Complete `New-ResourceSlug`, a PowerShell function that turns infrastructure naming inputs into a safe resource slug.

**Your task:**
1. Open `labs\L1-hello-copilot\starter\hello-copilot.ps1`
2. Find the TODO inside `New-ResourceSlug`
3. Use Copilot to generate a function that:
   - Joins `Project`, `Environment`, and `Service`
   - Lowercases the result
   - Replaces spaces and underscores with hyphens
   - Removes unsafe characters
   - Collapses repeated hyphens and trims leading/trailing hyphens
4. Run the starter script and confirm all checks pass

**How it works:**
- Type the function signature + comments
- Use **Ctrl+Shift+\\** (VS Code) or **Tab** (CLI autocomplete) to let Copilot suggest the body
- Edit, ask questions, iterate

**Facilitator models this first; you code along.**

### Part 3: Wrap-up (3 min)

Once your function works:

1. **In VS Code Copilot Chat:**
   - Highlight your code
   - Ask: "How does this error handling work?"
   - Ask: "What edge cases am I missing?"

2. **On the command line:**
    ```powershell
    gh copilot explain "PowerShell string replace with regular expressions"
    ```

**Goal:** Understand that Copilot is a conversation, not magic. You guide it; it suggests.

### Optional Stretch (up to 20 additional min; 40 min total)

If the agenda allows, continue in `labs\L1-hello-copilot\README.md` with one stretch: add a maximum slug length, add a prefix parameter, or ask Copilot Chat for extra test cases.

---

## 🎁 What You'll Have

After L1:
- ✅ Verified Copilot setup end-to-end
- ✅ Written a working PowerShell function with AI guidance
- ✅ Asked Copilot questions and iterated
- ✅ Confidence that Copilot works for *your* infrastructure tasks

**No perfect code required.** This is first contact. Celebrate the workflow.

---

## 🚨 Troubleshooting During the Lab

| Issue | Solution |
|-------|----------|
| `gh auth status` says "not authenticated" | Run `gh auth login` and authenticate with GitHub |
| `gh copilot` command not found | Run `gh extension install github/gh-copilot` |
| VS Code Copilot extension not working | Reload VS Code; check Extensions panel for "GitHub Copilot" |
| Copilot suggests nothing / very slow | Check internet connectivity; try a simpler prompt |
| Copilot license error | Verify your GitHub account has an active Copilot license in Settings > Billing |

**Still stuck?** Raise your hand for facilitator help. Peer pairing available if your setup needs recovery.

---

## 📖 Reference

- **Workshop README:** [README.md](../README.md)
- **Prerequisites Setup:** [prerequisites.md](../prerequisites.md)
- **Facilitator Notes:** [phase2-run-of-show.md](../docs/planning/phase2-run-of-show.md#l1)
- **Customer Repo:** [DNV Workshop Materials](https://github.com/dnv-opensource/gssit-cloudinfra-gitcopilot-agentws)

---

## 💬 Questions?

- **During the lab:** Ask in Teams chat or raise your hand
- **Before the workshop:** Email Jan Egil Ring or Haflidi Fridthjofsson
- **After:** See post-workshop support in your wrap-up email

---

**Welcome to Day 1. Let's write code with Copilot.** 🚀
