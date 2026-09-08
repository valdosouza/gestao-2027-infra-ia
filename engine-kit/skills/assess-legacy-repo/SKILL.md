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
**Changelog**: 2026-09-04 — added "Lessons from legacy cases" (13 rules distilled from a Delphi/Firebird ERP case,
sessions 1–3: index validation, call density, fact × intent, rules as data, inverse process, sibling diff table, proposed modules,
vault entry door); 2026-09-04 (later) — lesson 14: owner-verified docs are hypotheses (doc × code table per batch)

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

## Lessons from legacy cases (distilled — apply in every assessment)

1. **Validate the index against a known truth before trusting it.** Graph tools that
   resolve symbols by global name pick the wrong copy when the tree contains copied
   subprojects (a "god node" list turned out to be the sum of two projects). Scope
   resolution to the corpus; check the in-degree of one function you already know is
   central.
2. **A code graph is a map of structure, not of flow.** In OO languages, calls through
   a typed field (`Obj.Method`) often produce no edge: a trunk routine showed 0 calls.
   Measure the call density of a known unit before using the graph as a census;
   inventory by imports + a regex over qualified calls + instrumented phases instead.
3. **Do not label communities with an LLM.** Cluster cohesion in a monolith is near
   zero (shared utility units glue everything) and the labels cost millions of tokens;
   module names come from the owner. A 0-token index serves navigation just as well.
4. **Photography, not comparison.** The assessment describes the legacy by itself. The
   target system appears only as a source that maps the legacy, and in a traceability
   field filled in a later phase — never as a judgment ("in the new system this
   becomes…") inside the description. The owner will make you remove it; save the rework.
5. **Record `file:line` on every fact.** It is what lets the knowledge base answer
   "where?" without reopening the source, and what makes rule ids clickable later.
6. **Before asking the owner, exhaust the code.** Split every open item into FACT (the
   code answers it — grep, read, cite the line; half of an accumulated "questions to
   the author" list closed this way in an hour) and INTENT (only the owner can say
   whether the behavior is deliberate). Only intent becomes a question — with the
   evidence and a suggested answer attached. Enumerations in code comments
   (`0 NOT SENT / 1 SENT / …`) outrank the owner's memory: read the whole legend before
   recording a decision about one value.
7. **Rules are born as data.** Business rules go into a structured catalog (id, class,
   owning module, process steps, evidence, status) and the documents are GENERATED from
   it — consistent metadata, automatic index, programmatic check that every id cited by
   a process exists. Hand-editing a generated file is forbidden.
8. **After the pilot process, map its inverse** (cancel / reverse / undo) before
   changing domain. It costs about a quarter of the pilot and tests whether the state
   model closes (document, order, stock, receivables); it also surfaces atomicity bugs
   the forward reading cannot see.
9. **A sibling process starts with a difference table** against the process already
   mapped (stock moved at the order vs at the document; single transaction vs none;
   manual vs automatic settlement). Reuse measured at ~60%; the table is the most
   useful artifact of the sibling.
10. **Modules that emerge in later processes stay "proposed"** until the owner
    validates them — never silently inserted into the current list.
11. **The knowledge base needs one entry door**: FAQ → document, clickable rule ids,
    and a test with real questions from both profiles (developer / non-developer)
    measured in "hops from the index".
12. **The pilot may be small OR the most critical unit**, as long as it is sliced into
    summarizable pieces (process phases); the anti-big-bang criterion is the slicing,
    not the size.
13. **Infra items in the status file carry their check command** (`svn propget …`,
    `git config …`), not the assumption — a "pending" item was found already done.
14. **A document "verified by the owner" is a hypothesis with priority, not a fact.**
    It is the owner's memory of the code. Close every batch with a table
    *owner's doc × code → confirms / contradicts / details*; every contradiction becomes
    a numbered question. The first such table found a direct contradiction ("soft
    delete" in the doc, physical `DELETE` in the code). Also: grep the callers before
    marking a routine as a bug — two "bugs" were dead code.

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
