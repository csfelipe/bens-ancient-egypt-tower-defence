@echo off
REM Git Push Script (Batch version)
REM Adds all files, commits, and pushes to git

echo === Git Push Script ===

REM Check if we're in a git repository
if not exist .git (
    echo Error: Not a git repository!
    exit /b 1
)

REM Get current branch
for /f "tokens=*" %%i in ('git branch --show-current') do set BRANCH=%%i
echo Current branch: %BRANCH%

REM Show status
echo.
echo Checking git status...
git status --short

REM Ask for commit message
echo.
echo Enter commit message (or press Enter for default):
set /p COMMIT_MESSAGE=

if "%COMMIT_MESSAGE%"=="" (
    for /f "tokens=2-4 delims=/ " %%a in ('date /t') do set DATE=%%c-%%a-%%b
    for /f "tokens=1-2 delims=: " %%a in ('time /t') do set TIME=%%a:%%b
    set COMMIT_MESSAGE=Update game files - %DATE% %TIME%
    echo Using default message: %COMMIT_MESSAGE%
)

REM Add all files
echo.
echo Adding all files...
git add .
if errorlevel 1 (
    echo Error: Failed to add files!
    exit /b 1
)

REM Commit
echo Committing changes...
git commit -m "%COMMIT_MESSAGE%"
if errorlevel 1 (
    echo Error: Failed to commit!
    exit /b 1
)

REM Push
echo Pushing to remote...
git push
if errorlevel 1 (
    echo Error: Failed to push!
    echo You may need to set upstream: git push -u origin %BRANCH%
    exit /b 1
)

echo.
echo === Success! ===
echo All changes have been committed and pushed to %BRANCH%

