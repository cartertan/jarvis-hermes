# CLAUDE.md: rules for Claude Code in this repo

## What this repo is
Design docs, templates and scripts for a multi-agent assistant built on Hermes Agent.
It is a public repo. It never contains live agent data.

## Hard rules
- Never write real secrets, tokens, API keys, passwords, phone numbers or Telegram IDs. Use placeholders like `<TELEGRAM_BOT_TOKEN>`.
- Never copy anything from `~/.hermes/` or `~/JarvisVault/` into this repo. Templates only.
- Never add customer names, employer-confidential material, RFP content or pricing.
- Personal details in templates are replaced with placeholders such as `<YOUR_NAME>`.
- Do not commit or push. Show the diff and stop; the owner commits.

## How to work
1. Inspect first, propose a plan, wait for approval before writing.
2. Change one phase's files at a time.
3. After edits, list every file changed.
4. Run `scripts/check-no-secrets.sh` before declaring a change done.
5. Keep README.md's Progress table current when a phase completes.

## Commit convention
`JV-P<phase>: <what passed>`, for example `JV-P2: vault template and snapshot script`.

## Shared memory (Jarvis vault)
- At the end of a session in this repo, append a 5-line summary (date, what changed, decisions, open items) to `~/JarvisVault/Agent-Memory/claude-code/sessions.md`.
- Never write anywhere else in the vault.
