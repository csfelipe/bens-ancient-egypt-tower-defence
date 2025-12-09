# Git Push Scripts

Two scripts are provided to quickly add, commit, and push changes to git:

## PowerShell Script (Recommended for Windows)
**File:** `git-push.ps1`

### Usage:
```powershell
.\git-push.ps1
```

### Features:
- Checks if you're in a git repository
- Shows current branch and git status
- Prompts for commit message (or uses default)
- Adds all files
- Commits with your message
- Pushes to remote

### If you get an execution policy error:
Run PowerShell as Administrator and execute:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Batch Script (Alternative for Windows)
**File:** `git-push.bat`

### Usage:
```cmd
git-push.bat
```

### Features:
- Same functionality as PowerShell script
- Works in Command Prompt
- No execution policy needed

## Quick Commit Script
If you want a simpler version that uses a default message:

**PowerShell:**
```powershell
git add . && git commit -m "Update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" && git push
```

**Command Prompt:**
```cmd
git add . && git commit -m "Update: %date% %time%" && git push
```

