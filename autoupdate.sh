#!/bin/bash

set -euo pipefail

==============================
dwm Auto Updater
==============================

REPO_DIR="(cd"(dirname "${BASH_SOURCE[0]}")" && pwd)" BACKUP_DIR="$HOME/.local/share/dwm-backups" BRANCH="master"

Change these if necessary

BUILD_CMD="make clean" INSTALL_CMD="sudo make install"

cd "$REPO_DIR"

check_dependencies() { command -v git >/dev/null || { echo "Error: git is not installed." exit 1 }

command -v make >/dev/null || {
    echo "Error: make is not installed."
    exit 1
}


}

check_updates() { echo "Checking GitHub for updates..."

git fetch origin "$BRANCH"

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse "origin/$BRANCH")

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "Already up to date!"
    exit 0
fi

echo
echo "========== AVAILABLE UPDATES =========="

git log --oneline "$LOCAL..$REMOTE"

echo
echo "========== CHANGED FILES =============="

git diff --stat "$LOCAL" "$REMOTE"

echo


}

update_dwm() { if ! git diff --quiet || ! git diff --cached --quiet; then echo "Error: You have uncommitted changes." echo "Commit or stash them before updating." exit 1 fi

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

echo
read -rp "Proceed with update? [y/N] " CONFIRM

[[ "$CONFIRM" =~ ^[Yy]$ ]] || {
    echo "Update cancelled."
    exit 0
}

# Backup config
mkdir -p "$BACKUP_DIR"

if [ -f config.h ]; then
    cp config.h "$BACKUP_DIR/config.h-$TIMESTAMP"
    echo "Backed up config.h"
fi

# Backup current commit
git branch "backup/$TIMESTAMP" HEAD

# Update
echo "Pulling latest changes..."
git merge --ff-only "origin/$BRANCH"

# Restore local config if needed
if [ -f "$BACKUP_DIR/config.h-$TIMESTAMP" ]; then
    cp "$BACKUP_DIR/config.h-$TIMESTAMP" config.h
fi

# Build and install
echo "Building dwm..."
eval "$BUILD_CMD"
eval "$INSTALL_CMD"

echo
echo "dwm successfully updated!"
echo "Backup branch: backup/$TIMESTAMP"
echo "Config backup: $BACKUP_DIR/config.h-$TIMESTAMP"


}

main() { check_dependencies

case "${1:-check}" in
    check)
        check_updates
        ;;
    update)
        check_updates
        update_dwm
        ;;
    *)
        echo "Usage: $0 [check|update]"
        exit 1
        ;;
esac


}

main "$@"
