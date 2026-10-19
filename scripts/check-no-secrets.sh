#!/usr/bin/env bash
# Scan this repo for secrets and sensitive terms before committing.
# Usage:  ./scripts/check-no-secrets.sh            (scan files)
#         ./scripts/check-no-secrets.sh --history  (also scan git history)
# Optional: list extra terms to block (customer names etc.), one per line, in
# ~/.config/jarvis-hermes/blocked-terms.txt  (kept OUTSIDE the repo on purpose).

set -euo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || (cd "$(dirname "$0")/.." && pwd))"

fail=0

echo "1/3 gitleaks"
if command -v gitleaks >/dev/null 2>&1; then
  gitleaks detect --source . --no-git --redact -q || fail=1
  if [[ "${1:-}" == "--history" ]]; then
    gitleaks detect --source . --redact -q || fail=1
  fi
else
  echo "  gitleaks not installed (brew install gitleaks); skipping"
fi

echo "2/3 common secret patterns"
patterns='(sk-[A-Za-z0-9_-]{20,}|sk-ant-[A-Za-z0-9_-]{20,}|sk-or-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|AKIA[0-9A-Z]{16}|[0-9]{8,10}:[A-Za-z0-9_-]{35}|-----BEGIN [A-Z ]*PRIVATE KEY-----)'
if grep -rEn --exclude-dir=.git --exclude="$(basename "$0")" "$patterns" . ; then
  echo "  FAIL: possible secret found above"; fail=1
else
  echo "  ok"
fi

echo "3/3 blocked terms"
terms_file="$HOME/.config/jarvis-hermes/blocked-terms.txt"
if [[ -f "$terms_file" ]]; then
  if grep -rniF --exclude-dir=.git -f "$terms_file" . ; then
    echo "  FAIL: blocked term found above"; fail=1
  else
    echo "  ok"
  fi
else
  echo "  no blocked-terms file at $terms_file; skipping"
fi

if [[ $fail -ne 0 ]]; then
  echo "Scan FAILED. Fix before committing."; exit 1
fi
echo "Scan passed."
