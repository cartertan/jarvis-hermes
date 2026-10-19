# Security

This assistant can run shell commands, read files and reach the internet. It is treated as a privileged service account, not a chatbot.

## Assets

| Asset | Why it matters |
| --- | --- |
| Mac user account | Agents run with the owner's OS permissions; profiles do not sandbox |
| Obsidian vault | Personal context and project memory |
| API keys and tokens | Telegram bot, OpenRouter, Garmin, Claude/ChatGPT logins |
| Employer and customer information | Must never reach cloud models or this repo |

## Threat model

| Threat | Example | Controls |
| --- | --- | --- |
| Unauthorised command via gateway | Stranger messages the Telegram bot | `TELEGRAM_ALLOWED_USERS` set to one ID; gateway denies all others |
| Prompt injection | Instructions hidden in a web page, email or document the agent reads | No inbox access until stable; read-only connectors; approval prompts for risky commands; no auto-run modes |
| Malicious skill or MCP server | Third-party skill that exfiltrates data | Read every SKILL.md and MCP config before install; prefer bundled or self-written skills; `hermes doctor` MCP checks |
| Memory poisoning | Agent stores a wrong or planted "fact" | Agents write only to their own vault folder; weekly `git diff` review; owner corrects |
| Data leakage to cloud | Customer material sent to Claude/ChatGPT/OpenRouter | presales has no cloud key; Never-bin rules on RAG export; leak-check grep; sanitise before any cloud step |
| Secret leakage to GitHub | Token committed in a config file | `.gitignore`, `.env.example` placeholders, `scripts/check-no-secrets.sh`, gitleaks in CI |
| Runaway cost | Unbounded review loops on paid models | Local checker; max two rework loops; cloud only on named agents |
| Supply chain on Hermes itself | Compromised update | Pin version after a working build; read release notes; `hermes update` monthly, not automatically |

## Operating rules

1. Only the owner's Telegram user ID is allowlisted.
2. Secrets live only in `.env` files, never in SOUL.md, memory, the vault or Git.
3. No customer confidential documents anywhere in this setup.
4. presales stays local-only, with no cloud model key in that profile.
5. Read every SKILL.md and MCP config before installing it.
6. Approve, don't auto-run. Read risky commands before approving.
7. No sending, purchasing, pushing or deleting without a fresh yes from the owner.
8. Agents write only inside their own `Agent-Memory/<agent>` folder.
9. Commit the vault weekly and review `git diff`.
10. Update Hermes monthly after reading release notes.
11. Claude Code and Codex never run in skip-permissions or full-auto mode from Telegram.
12. Claude Code and Codex work only on the owner's own repos.

## Before making this repo public

- [ ] `scripts/check-no-secrets.sh` passes
- [ ] gitleaks CI is green on `main`
- [ ] No real names, IDs, phone numbers or customer terms in any file (`git grep -i` for each)
- [ ] Git history scanned, not just the current files (`gitleaks detect --source .`)
