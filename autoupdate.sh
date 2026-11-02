#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.local/share/dwm-backups"

if ! command -v git >/dev/null 2>&1; then
    echo "Error: git is not installed." >&2
    exit 1
fi

if ! git -C "$REPO_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: $REPO_DIR is not a Git repository." >&2
    exit 1
fi

if DEFAULT_REMOTE_BRANCH=$(git -C "$REPO_DIR" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null); then
    DEFAULT_REMOTE_BRANCH="${DEFAULT_REMOTE_BRANCH#origin/}"
else
    DEFAULT_REMOTE_BRANCH="$(git -C "$REPO_DIR" branch --show-current)"
fi

BRANCH="${BRANCH:-$DEFAULT_REMOTE_BRANCH}"
if [[ -z "$BRANCH" ]]; then
    echo "Error: Could not determine which branch to update." >&2
    exit 1
fi

check_updates() {
    echo "Checking GitHub for updates..."
    git -C "$REPO_DIR" fetch origin "refs/heads/$BRANCH:refs/remotes/origin/$BRANCH"

    LOCAL="$(git -C "$REPO_DIR" rev-parse HEAD)"
    REMOTE="$(git -C "$REPO_DIR" rev-parse --verify "refs/remotes/origin/$BRANCH^{commit}")"

    if [[ "$LOCAL" == "$REMOTE" ]]; then
        echo "Already up to date!"
        UPDATES_AVAILABLE=false
        return
    fi

    if git -C "$REPO_DIR" merge-base --is-ancestor "$REMOTE" "$LOCAL"; then
        echo "Local branch is ahead of origin/$BRANCH; no remote updates to apply."
        UPDATES_AVAILABLE=false
        return
    fi

    if ! git -C "$REPO_DIR" merge-base --is-ancestor "$LOCAL" "$REMOTE"; then
        echo "Error: Local branch and origin/$BRANCH have diverged; refusing to update." >&2
        exit 1
    fi

    echo
    echo "========== AVAILABLE UPDATES =========="
    git -C "$REPO_DIR" log --oneline "$LOCAL..$REMOTE"
    echo
    echo "========== CHANGED FILES =============="
    git -C "$REPO_DIR" diff --stat "$LOCAL" "$REMOTE"
    echo
    UPDATES_AVAILABLE=true
}

update_dwm() {
    if [[ -n "$(git -C "$REPO_DIR" status --porcelain)" ]]; then
        echo "Error: You have uncommitted changes." >&2
        echo "Commit or stash them before updating." >&2
        exit 1
    fi

    if ! command -v make >/dev/null 2>&1; then
        echo "Error: make is not installed." >&2
        exit 1
    fi
    if ! command -v sudo >/dev/null 2>&1; then
        echo "Error: sudo is not installed." >&2
        exit 1
    fi

    TIMESTAMP="$(date +"%Y%m%d-%H%M%S")"

    echo
    read -r -p "Proceed with update? [y/N] " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "Update cancelled."
        return
    fi

    mkdir -p "$BACKUP_DIR"
    if [[ -f "$REPO_DIR/config.h" ]]; then
        cp "$REPO_DIR/config.h" "$BACKUP_DIR/config.h-$TIMESTAMP"
        echo "Backed up config.h"
    fi

    git -C "$REPO_DIR" branch "backup/$TIMESTAMP" HEAD

    echo "Pulling latest changes..."
    git -C "$REPO_DIR" merge --ff-only "origin/$BRANCH"

    if [[ -f "$BACKUP_DIR/config.h-$TIMESTAMP" ]]; then
        cp "$BACKUP_DIR/config.h-$TIMESTAMP" "$REPO_DIR/config.h"
    fi

    echo "Building dwm..."
    make -C "$REPO_DIR" clean
    sudo make -C "$REPO_DIR" install

    echo
    echo "dwm successfully updated!"
    echo "Backup branch: backup/$TIMESTAMP"
    if [[ -f "$BACKUP_DIR/config.h-$TIMESTAMP" ]]; then
        echo "Config backup: $BACKUP_DIR/config.h-$TIMESTAMP"
    fi
}

main() {
    case "${1:-check}" in
        check)
            check_updates
            ;;
        update)
            check_updates
            if [[ "$UPDATES_AVAILABLE" == true ]]; then
                update_dwm
            fi
            ;;
        *)
            echo "Usage: $0 [check|update]" >&2
            exit 1
            ;;
    esac
}

main "$@"
