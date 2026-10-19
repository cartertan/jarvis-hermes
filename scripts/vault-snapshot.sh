#!/usr/bin/env bash
# Commit the Jarvis vault so every agent edit is a reviewable diff.
# Usage: ./scripts/vault-snapshot.sh [path-to-vault]
# Shows what changed, asks for confirmation, then commits. Never pushes.

set -euo pipefail
vault="${1:-$HOME/JarvisVault}"

if [[ ! -d "$vault/.git" ]]; then
  echo "No git repo at $vault. Run: cd $vault && git init"; exit 1
fi

cd "$vault"
if [[ -z "$(git status --porcelain)" ]]; then
  echo "Vault unchanged. Nothing to commit."; exit 0
fi

echo "Changes since last snapshot:"
git status --short
echo
git diff --stat
echo
read -r -p "Commit these changes? [y/N] " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  git add -A
  git commit -q -m "Vault snapshot $(date +%Y-%m-%d)"
  echo "Committed."
else
  echo "Not committed. Review with: git -C \"$vault\" diff"
fi
