# Knowledge Base Structure (Phase 0 — building the vessel)

**Scope**: method
**Role**: before assessing any code, build the place where the knowledge will live. A
memory tool without a process becomes a pile of notes; the vessel IS the process.

---

## Principles

1. **Project ↔ knowledge symmetry**: every code project `<root>\<project>` has its
   mirror `<root>\<knowledge-base>\<project>`. No document is born loose.
2. **Rules at the root**: a single rules file for AI agents at the workspace root
   (e.g., `CLAUDE.md`) — short, pointing to the base; the base is the long-term
   memory, the rules file is the boarding pass.
3. **Central index with versioned history**: a `CENTRAL_INDEX.md` that maps
   docs/skills/agents per project AND accumulates a history table (date → what →
   version). The history is the case's episodic memory.
4. **Nothing is blindly overwritten**: a superseded instruction is not deleted — it is
   marked SUPERSEDED, pointing to the decision that replaced it.
5. **Every document carries metadata**: Status/Version, Origin, References, and
   **Scope** (`method | <case> | mixed` — see the `scope-census` skill).
6. **Pure Markdown** with `[[wiki-style]]` links when useful — the whole base opens as
   an Obsidian vault for free (visual graph included).

## Folder skeleton

```
<workspace-root>/
├── CLAUDE.md                       ← rules for AI agents (the only loose-file exception)
├── <project-1>/  <project-2>/ ...  ← code
└── <knowledge-base>/
    ├── CENTRAL_INDEX.md            ← map + versioned history (ALWAYS START HERE)
    ├── FOLDER_ORGANIZATION.md      ← decision table: where each new file goes
    ├── generic-skills/             ← the method (this kit's skills)
    ├── <project-1>/                ← mirror: docs, phase prompts, project skills
    │   ├── INDEX.md
    │   ├── prompt_phaseN_<name>.md ← CLOSED prompts (with numbered decisions)
    │   └── skills/
    ├── prompts/                    ← drafts and prompts BEING optimized
    └── HISTORY/                    ← superseded material, one-off analyses, source drafts
```

## Minimal template for the root rules file

```markdown
# <Case> — Rules for AI agents

## BEFORE ANY TASK: consult <knowledge-base>/
1. Start with CENTRAL_INDEX.md
2. Before creating/changing a domain object: the conceptual-guardian skill
3. To turn drafts into phase prompts: the decision-rounds skill
4. When finishing a task that produced new knowledge: the retain-knowledge skill
5. Mandatory scope: every new/touched file in the base gains `**Scope**: method | <case> | mixed`

## Current state of the projects (<date>)
- <project>: <phase/state, with a link to the current prompt>
```

## Minimal template for the central index

```markdown
# Central Index — <knowledge-base>
**Version**: 1.0 (follows the history)  **Last updated**: <date>
**Scope**: mixed

## Quick map per project
| Project | Docs | Skills | Status |

## Projects in detail
### <project> — purpose, docs (with a 1-line summary each), skills, agents

## Recommended workflows
### "I want to <common task>" → numbered steps with the docs to read

## Update history
| Date | What | Version |
```

## The memory triple (tool × process)

| Layer | Tool (examples) | Process (this kit) |
|---|---|---|
| Code retrieval | code indexer/graph, semantic search | Phase 1 feeds the base with the result |
| Agent memory | the AI tool's persistent memory | `retain-knowledge` decides WHAT goes in |
| Human reading | Obsidian over the base | index + history + numbered decisions |

The tool stores; the process decides what deserves to be stored, where, and how it
will be found again. Without both layers together, you either lose knowledge or drown
in it.
