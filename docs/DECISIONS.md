# Decision log

| ID | Date | Decision | Why | Alternatives rejected |
| --- | --- | --- | --- | --- |
| JV-D001 | 2026-10-16 | Use Hermes Agent as the runtime | Open source (MIT), profiles, built-in memory, Ollama support, skills compatible with Claude Code | OpenClaw: serious 2026 security record (one-click RCE CVE, malicious skill registry uploads) |
| JV-D002 | 2026-10-16 | Local model as every agent's brain | Cost, privacy, works offline | Claude or ChatGPT as brain: burns subscription quota, sends personal context to cloud |
| JV-D003 | 2026-10-16 | One profile per trust boundary | Isolated memory, model and keys per agent | Single agent with many skills: no data separation |
| JV-D004 | 2026-10-16 | Obsidian vault on local disk, git-tracked | Multiple agents writing to a syncing cloud folder creates conflict copies; git gives undo and audit | Vault in Google Drive or OneDrive |
| JV-D005 | 2026-10-16 | Export Nexus RAG to Markdown instead of linking ChromaDB | Collections were embedded with specific local models; a stock connector would query with a different embedding model | Live Chroma MCP connector (deferred: wrap own retriever later) |
| JV-D006 | 2026-10-19 | Route models by profile, not per-task `delegate_task` overrides | Reported bug where per-task overrides were ignored and fell back to a paid default | delegate_task model overrides |
| JV-D007 | 2026-10-19 | Claude Code and Codex used as tools via skills, not as Hermes providers | Keeps official CLIs under the owner's login and terms; keeps brain local | Anthropic / OpenAI as main provider |
| JV-D008 | 2026-10-19 | Proposal pipeline: Claude writes, Astral designs, local checker gates both (planned) | Cross-family production with an independent, private reviewer; deterministic checks where possible | One model doing everything; cloud reviewer |
