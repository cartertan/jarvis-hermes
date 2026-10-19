# Model map

Hardware: MacBook Pro M5 Pro, 64 GB unified memory. Models served by Ollama (port 11434) and optionally LM Studio (port 1234).

| Model (size) | Role | Agents |
| --- | --- | --- |
| qwen3.6:35b-a3b (22 GB) | Main brain: chat, briefs, coaching, research. Multimodal. | jarvis, coach, presales, scout (main) |
| gemma4:e4b (9.6 GB) | Fast model: auxiliary side tasks, Telegram triage, dev manager | all (auxiliary); dev (main) |
| granite4.1:30b (17 GB) | Structured output (tables, compliance matrices, XML/JSON); second opinion from another model family | presales, swapped in for structured work |
| devstral-small-2 (15 GB) | Offline coding fallback when cloud coding quota runs out | dev, fallback only |
| bge-m3 (1.2 GB) | Embeddings for an optional vector memory plugin | later, optional |
| nomic-embed-text, qwen3-embedding:4b | Used by the separate Nexus RAG | none |
| OpenRouter (cloud) | Heavy reasoning or very long documents | scout only |

## Memory budget

| Loaded together | Approx. | Verdict |
| --- | --- | --- |
| qwen3.6 + gemma4 | 32 GB | Everyday pairing |
| qwen3.6 + gemma4 + granite4.1 | 49 GB | Works; close other apps |
| qwen3.6 + granite4.1 + devstral | 54 GB | Avoid |

Check with `ollama ps`; unload with `ollama stop <model>`.

## Rules

- Each profile sets its own model (`<profile> model`). One profile's choice never changes another's.
- Hermes does not route by task complexity inside one agent; route by choosing the right agent.
- Trial a new model on one profile for a week, using the same reference prompt, before rolling it out.
- presales never uses a cloud model.
