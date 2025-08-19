#!/usr/bin/env bash

Path to your Neovim config repo
REPO_DIR="$HOME/.config"

Commit message: use timestamp if none provided
if [ -n "$1" ]; then
  MSG="$*"
else
  MSG="Auto-update dotfile weekly: $(date '+%d-%m-%y %H:%M:%S')"
fi

Change to repo directory
cd "$REPO_DIR" || { echo "Repo not found at $REPO_DIR"; exit 1; }

Stage all changes
git add . && \
Commit with message
git commit -m "$MSG" && \
Push to the default remote/branch
git push
