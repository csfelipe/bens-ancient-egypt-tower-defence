#!/bin/bash

# Script to create a release by bumping the minor version number
# Usage: ./create-release.sh

set -e  # Exit on error

VERSION_FILE="VERSION"

# Check if VERSION file exists, if not create it with 1.0.0
if [ ! -f "$VERSION_FILE" ]; then
    echo "1.0.0" > "$VERSION_FILE"
    echo "Created $VERSION_FILE with initial version 1.0.0"
fi

# Read current version
CURRENT_VERSION=$(cat "$VERSION_FILE" | tr -d '[:space:]')

# Parse version components (assuming format: MAJOR.MINOR.PATCH)
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]:-0}  # Default to 0 if patch is missing

# Bump minor version and reset patch to 0
NEW_MINOR=$((MINOR + 1))
NEW_VERSION="$MAJOR.$NEW_MINOR.0"

# Update VERSION file
echo "$NEW_VERSION" > "$VERSION_FILE"

# Get current date and time in PST timezone
# Format: 2025-11-19 08:16 AM PST
RELEASE_DATE=$(TZ='America/Los_Angeles' date '+%Y-%m-%d %I:%M %p %Z')

# Create commit message
COMMIT_MESSAGE="Release v$NEW_VERSION - $RELEASE_DATE"

# Stage the VERSION file
git add "$VERSION_FILE"

# Commit with the release message
git commit -m "$COMMIT_MESSAGE"

# Push to the repository
git push

echo "✅ Release created successfully!"
echo "   Version bumped from $CURRENT_VERSION to $NEW_VERSION"
echo "   Commit: $COMMIT_MESSAGE"
echo "   Pushed to remote repository"

