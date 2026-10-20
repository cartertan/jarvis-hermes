# RAG export rules (presales-ai-platform -> JarvisVault)

| Bin | Content | Destination |
| --- | --- | --- |
| Export | knowledge/products/*.md, knowledge/industries/*.md | ~/JarvisVault/Imported/nexus/ |
| Keep in RAG only | none at present | stays in chroma_db |
| Never | knowledge/proposals/ (customer proposals), customer names, pricing, RFP content | never leaves presales-ai-platform |

Method: copy source .md files directly; all exported sources exist on disk.
Checks: leak-check grep against a private blocked-terms list before any agent reads the import.
Refresh: re-copy after knowledge/ changes; never hand-edit Imported/.
