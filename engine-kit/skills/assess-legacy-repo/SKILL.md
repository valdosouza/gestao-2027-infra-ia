---
name: assess-legacy-repo
description: Faithful assessment of a legacy repository (Phase 1 of the engine). Use on first contact with a legacy system — before any concept, decision, or new line of code. Produces faithful documentation of what is implemented, feeding the knowledge base and the next phases.
---

# Skill: Assess Legacy Repository (Phase 1 of the engine)

**When to use**: first contact of the engine with a legacy system — before any
concept, decision, or new line of code. The product of this phase is FAITHFUL
DOCUMENTATION of what is implemented, which feeds the knowledge base and the
following phases.
**Origin**: distilled from the case-zero analysis script (migration of a legacy
synchronization service) + the scale lesson from case two (~2M lines / 30 years).
**Scope**: method

---

## Role of the analyst agent

Senior software engineer specialized in legacy system analysis, data migration, and
technical documentation. The job is to **read the source code and faithfully document
what is implemented** — without inferring intentions, without suggesting improvements,
without inventing missing mappings. (Improving is the job of Phases 2–3; this phase is
photography.) See [agents/legacy-analyst.md](../../agents/legacy-analyst.md).

## Phase 1.0 — Size before reading (the scale lesson)

The first act is to measure: lines, files, languages, age, modules.

- **Small repository** (readable within a few sessions): direct analysis by agents,
  fan-out per folder/module with identical rules (the parallel-census pattern).
- **Large repository** (millions of lines): direct reading does NOT scale. Index
  first: a code graph (who calls whom, who uses which table) and/or semantic search
  (embeddings) over the source. The analysis then navigates the index and reads only
  what the index points to. Without this step, the assessment becomes sampling
  disguised as a census.
- In both: define UNITS OF ANALYSIS (module, screen, entity, integration) and keep an
  inventory with status — the assessment is incremental and resumable, never
  "big bang".

## Context to fill in per case (parameterization)

| Parameter | Example |
|---|---|
| Source stack | <legacy language/framework> + <source database> |
| Target stack | <new language/framework> + <target database/API> |
| Reading priority order | source models → target models → controllers/rules → configs/utilities |
| Discard warnings | abandoned plans in the code that must be IGNORED (e.g., abandoned framework X) |

## Mandatory structure of the generated documentation

Markdown, fixed sections. Omit none — when information is missing, write
`⚠️ Not found in the code`.

1. **System overview** — up to 10 lines: what it does, how the components connect,
   overall data flow.
2. **Component inventory** — tables per type (source models, target models,
   controllers/rules), each with responsibility, dependencies, and status
   ✅ Complete / ⚠️ Partial / ❌ Empty.
3. **Source-to-target mapping per entity** — per entity: source field, type, target
   field, type, transformation applied. Rules: source field without a target →
   `⚠️ NOT MAPPED`; target field without a source → `⚠️ NO SOURCE`; transformations
   (calculation, conversion) described objectively; **never infer** a mapping that is
   not explicit in the code.
4. **Data flow per entity** — sequential list: read → filters → transformations →
   write/send → success/error handling (or `⚠️ Not implemented`).
5. **External integrations identified** — endpoints/services/files that the legacy
   system consumes or exposes, with payload and identified authentication.
6. **Pending items and inconsistencies** — everything incomplete, commented out,
   marked TODO, or inconsistent. Objective, no solutions. Severity: 🔴 blocks the
   migration of a data set · 🟡 data loss/incorrect behavior · 🟢 debt with no
   immediate impact.
7. **Executive summary** — table of counts (entities total/complete/partial/unmapped,
   components complete/empty, critical pending items) + a 2–3 sentence conclusion:
   what is functional × what is missing.

## Rules that must never be broken

1. **Never** document something that is not in the code — if it does not exist, flag it with ⚠️
2. **Never** suggest improvements — that is the job of the following phases
3. **Never** ignore an inconsistency — everything goes to section 6
4. **Never** omit a section — fill it with ⚠️ if necessary
5. Respect the case's discard warnings (code from abandoned plans is noise)

## Output and chaining

- The documentation goes into the knowledge base, in the legacy project's mirror,
  with `**Scope**: <case>`.
- **Structures suspected of being scale models** (section 3 entries with convoluted
  mappings, odd guards, screen-mirror tables) become the input queue of the
  `conceptual-guardian` skill.
- **🔴/🟡 pending items** and route choices become questions for the
  `decision-rounds` skill.
- Whatever the analysis teaches about HOW to analyze → distill into the product
  journal.

## Final checklist before delivering

- [ ] All sections filled in
- [ ] No mapping inferred without grounding in the code
- [ ] Fields without target/source flagged with ⚠️
- [ ] All inconsistencies in section 6
- [ ] Executive summary matches the numbers in the sections
- [ ] Queue of suspected scale models and of questions handed to Phases 2–3
