# Git Push Script
# Adds all files, commits, and pushes to git

Write-Host "=== Git Push Script ===" -ForegroundColor Cyan

# Check if we're in a git repository
if (-not (Test-Path .git)) {
    Write-Host "Error: Not a git repository!" -ForegroundColor Red
    exit 1
}

# Get current branch
$branch = git branch --show-current
Write-Host "Current branch: $branch" -ForegroundColor Yellow

# Show status
Write-Host "`nChecking git status..." -ForegroundColor Cyan
git status --short

# Ask for commit message
Write-Host "`nEnter commit message (or press Enter for default):" -ForegroundColor Cyan
$commitMessage = Read-Host

if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "Update game files - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    Write-Host "Using default message: $commitMessage" -ForegroundColor Yellow
}

# Add all files
Write-Host "`nAdding all files..." -ForegroundColor Cyan
git add .

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to add files!" -ForegroundColor Red
    exit 1
}

# Commit
Write-Host "Committing changes..." -ForegroundColor Cyan
git commit -m "$commitMessage"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to commit!" -ForegroundColor Red
    exit 1
}

# Push
Write-Host "Pushing to remote..." -ForegroundColor Cyan
git push

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to push!" -ForegroundColor Red
    Write-Host "You may need to set upstream: git push -u origin $branch" -ForegroundColor Yellow
    exit 1
}

Write-Host "`n=== Success! ===" -ForegroundColor Green
Write-Host "All changes have been committed and pushed to $branch" -ForegroundColor Green

