# Prerequisites — Setup for Workshop Attendees

**Time estimate:** 20–30 minutes
**Target OS:** Windows 11
**All tools installable via winget** (Windows Package Manager)

---

## 📋 Pre-Workshop Checklist

Before the workshop, ensure you have:

- [ ] **Windows 11** (or latest Windows with winget available)
- [ ] **GitHub account** with an active **GitHub Copilot license**
- [ ] **VS Code** with GitHub Copilot extension
- [ ] **PowerShell 7+** (for command-line labs)
- [ ] **Git** (for cloning repos)
- [ ] **GitHub CLI** (for authentication and code operations)
- [ ] **GitHub Copilot CLI** (installed as GitHub CLI extension)
- [ ] **Basic internet connectivity** (no proxy/firewall blocks to GitHub Copilot endpoints)

Estimated total setup time: **20–30 minutes**.

---

## 🛠️ Installation Guide

### 1. Verify Windows & winget

Open **PowerShell** and check your setup:

```powershell
# Check Windows version (should be 11 or later)
[System.Environment]::OSVersion.Version

# Check if winget is available
winget --version
```

If `winget` is not available, [install Windows Package Manager](https://learn.microsoft.com/windows/package-manager/winget/).

---

### 2. Install VS Code

```powershell
winget install --id=Microsoft.VisualStudioCode -e
code --install-extension GitHub.copilot-chat
```

After installation, open VS Code and verify it launches without errors.

---

### 3. Install PowerShell 7

```powershell
winget install --id=Microsoft.PowerShell -e
```

Launch PowerShell 7:

```powershell
pwsh
```

You should see a prompt like `PS C:\>`. Verify version:

```powershell
$PSVersionTable.PSVersion
```

Should show version **7.x** or later.

---

### 4. Install Git

```powershell
winget install --id=Git.Git -e
```

Verify:

```powershell
git --version
```

---

### 5. Install GitHub CLI

```powershell
winget install --id=GitHub.cli --scope user -e
```
> Should you experience issues with the installation due to that an UAC-prompt (rather than a BeyondTrust-prompt) requires you to specify a user with local admin rights (instead of just performing elevation through BeyondTrust utilizing the *Flex*-profile for your user on your machine), then please just download the MSI (see link under the [winget install fails or times out](#winget-install-fails-or-times-out) heading later in this document) and run it manually by double-clicking on it (this would allow BeyondTrust to detect the Windows Installer requires elevation and then prompt for that).

Verify:

```powershell
gh --version
```

---

### 6. Authenticate GitHub CLI

```powershell
gh auth login
```

Follow the prompts:
- **What is your preferred protocol for Git operations?** → Choose `HTTPS` (or `SSH` if you prefer)
- **Authenticate Git with GitHub credentials?** → `Y`
- **How would you like to authenticate GitHub CLI?** → Choose `Login with a web browser`
- A browser window will open — authorize the GitHub CLI app
- Return to PowerShell; you should see **"Logged in as [your-username]"**

Verify:

```powershell
gh auth status
```

---

### 7. Verify GitHub Copilot CLI is Ready

The Copilot CLI uses your authenticated GitHub CLI session. Verify authentication:

```powershell
gh auth status
```

You should see your GitHub username and authentication status. To confirm Copilot is working end-to-end:

```powershell
gh copilot -i "explain git status"
```

You can try allowing Copilot to use powershell to help you list the files in your directory:

```powershell
gh copilot -i "list files in current directory using PowerShell" --allow-tool powershell
```

If you see a response explaining the command, **Copilot CLI is working!**

---

## 🚀 Verify Your Setup

Run these commands to confirm everything is installed and working. **Use PowerShell 7 (`pwsh`) for all commands.**

```powershell
# 1. Check Windows version
Write-Host "=== Windows Version ===" -ForegroundColor Green
Get-ComputerInfo | Select-Object OSName

# 2. Check VS Code
Write-Host "`n=== VS Code ===" -ForegroundColor Green
code --version

# 3. Check PowerShell version (we recommend at least version 7.4)
Write-Host "`n=== PowerShell ===" -ForegroundColor Green
$PSVersionTable.PSVersion

# 4. Check Git
Write-Host "`n=== Git ===" -ForegroundColor Green
git --version

# 5. Check GitHub CLI
Write-Host "`n=== GitHub CLI ===" -ForegroundColor Green
gh --version
gh auth status

# 6. Check GitHub Copilot CLI extension and verify it works
Write-Host "`n=== GitHub Copilot CLI ===" -ForegroundColor Green
gh copilot -i "explain git status"
```

**Expected output:** All tools should report their versions. GitHub auth should show your username. Copilot explain should return a response.

---

## 📂 Clone the Workshop Repository

Once authenticated, clone the workshop repository to your local machine:

```powershell
# Create a directory for the workshop (optional)
mkdir $env:USERPROFILE\Documents\workshop
cd $env:USERPROFILE\Documents\workshop

# Clone the workshop repository
git clone https://github.com/dnv-opensource/gssit-cloudinfra-gitcopilot-agentws.git

# Navigate to the repo
cd gssit-cloudinfra-gitcopilot-agentws

# Verify (you should see files in the repo)
ls
```

---

## 🧪 Quick Lab Test (Optional)

To test that GitHub Copilot is working, try a quick autocomplete in VS Code:

1. Open VS Code: `code`
2. Create a new file: `Ctrl+N`
3. Type this comment:
   ```powershell
   # Write a function that reverses a string
   ```
4. Press `Enter` and wait a moment
5. You should see a GitHub Copilot suggestion below the comment (look for the Copilot icon)
6. Press `Tab` or `Ctrl+Enter` to accept a suggestion

If you see suggestions, **Copilot is working!**

---

## 🆘 Troubleshooting

### "VS Code doesn't have the Copilot Chat extension"

1. Open VS Code
2. Press `Ctrl+Shift+X` (Extensions)
3. Search for **"GitHub Copilot Chat"** (by GitHub)
4. Click **Install**
5. After install, you may be prompted to sign in — follow the browser flow
6. Restart VS Code

---

### "Git authentication fails"

```powershell
# Clear cached credentials
gh auth logout

# Re-authenticate
gh auth login
```

Follow the prompts again, choosing `HTTPS` or `SSH` as your preference.

---

### "GitHub Copilot CLI says I'm not authenticated"

The Copilot CLI uses your GitHub CLI authentication. Re-authenticate GitHub CLI:

```powershell
gh auth logout
gh auth login
```

Follow the prompts again. Then verify Copilot can connect:

```powershell
gh copilot explain "git status"
```

---

### "winget install fails or times out"

Try installing with the full package name and source:

```powershell
winget search "PowerShell"
winget install Microsoft.PowerShell --source winget
```

Or install manually:
- **VS Code:** https://code.visualstudio.com/
- **PowerShell 7:** https://github.com/PowerShell/PowerShell/releases
- **Git:** https://git-scm.com/download/win
- **GitHub CLI:** https://cli.github.com/

---

### "Cannot connect to GitHub Copilot (firewall/proxy)"

**Note:** GitHub Copilot requires outbound HTTPS access to GitHub endpoints. If you're behind a corporate proxy or firewall:

1. Contact your IT department and confirm GitHub Copilot traffic is allowed
2. Required endpoints: `*.github.com`, `*.copilot.github.com`
3. If using a proxy, configure Git to use it:
   ```powershell
   git config --global http.proxy [your-proxy-url]
   ```

---

## ✅ Ready to Go!

Once you've completed all steps and verified your setup, you're ready for the workshop!

**Quick summary:**
- ✅ Windows 11 with WinGet
- ✅ VS Code with GitHub Copilot extension
- ✅ PowerShell 7
- ✅ Git and GitHub CLI (authenticated)
- ✅ GitHub Copilot CLI extension (authenticated)
- ✅ Workshop repository cloned

**Day-of checklist (May 26):**
- Restart your machine (clean state)
- Open VS Code and verify Copilot is active
- Test `gh auth status` (shows your username)
- Test `gh copilot explain "git status"` (shows Copilot is responding)
- Join Teams 5 minutes early

---

## 📞 Having Issues?

If you encounter problems during setup:

1. **Check this guide** — Common issues are in the Troubleshooting section above
2. **Review verification steps** — Run the verification script to narrow down the issue
3. **Contact the facilitators** — Email Jan Egil Ring or Haflidi Fridthjofsson with:
   - Your error message
   - Output of the verification script
   - Your OS and tool versions

We will also do a **technical soundcheck** on May 26 at 13:45 (15 min before start) in Teams.

---

**Last updated:** May 2026
**For questions:** Contact the facilitator team
