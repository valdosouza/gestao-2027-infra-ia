---
name: scope-census
description: Classifies the case's entire document collection as method, case-specific, or mixed. Use (a) when installing the engine in a case that already has accumulated documentation — a retroactive census of the whole collection; and (b) continuously — every new/touched file in the knowledge base is born classified.
---

# Skill: Scope Census (classifying the case's collection)

**When to use**: (a) when installing the engine in a case that ALREADY has accumulated
documentation — a retroactive census of the entire collection; (b) continuously —
every new/touched file in the knowledge base is born classified. Classifying the
repository itself is Phase 1 of the engine applied to itself (dogfooding).
**Real origin**: the retroactive census of case zero (2026-07-19) — 88 documents
classified by 4 parallel agents in minutes, with a single naming collision; it
revealed that ~40% of the collection was portable (prior estimate: 20–30%).
**Scope**: method

---

## The principle: marking ≠ separating

- **Marking** is cheap, reversible (1 line per file), and pays off immediately: the
  future physical separation becomes a FILTER, not archaeology.
- **Separating** (extracting/moving/abstracting) is expensive and goes wrong when done
  too early (the rule of three cases: an abstraction extracted from 1 case is a
  guess). Postpone the separation; never the marking.
- Leaving an existing collection unassessed = debt that grows. The retroactive census
  is mandatory at installation.

## The three values

A line in the header of every document: `**Scope**: method | <case> | mixed`

| Value | Meaning | Future destination |
|---|---|---|
| `method` | Portable to any company/legacy system (process, generic practice) | The engine kit |
| `<case>` | Case content (domain, DDL, screens, business decisions, infra setups) | Stays in the case — NEVER crosses companies |
| `mixed` | A portable principle tied to the case's stack/domain | Distillation queue: separate the principle (→ method) from the instance (stays in the case), ON DEMAND from a new case |

## Retroactive census workflow

1. **Inventory**: list every `.md` in the base. EXCLUDE copied/vendored code (study
   repositories are not knowledge documents — record the exclusion).
2. **Rules written ONCE**: the definition of the 3 values + the insertion format (the
   line goes at the END of the metadata block attached to the title; reformat nothing
   else) + the instruction "if a `**Scope**:` line already exists, skip it and
   REPORT".
3. **Parallel fan-out**: split the files into groups by folder and launch N agents
   with the SAME rules. Each agent reads only the header (~30 lines) — enough to
   classify; it reads more only when genuinely in doubt. Per-group classification
   hints help, but the agent judges by the content.
4. **Structured return**: each agent returns `file | scope | justification
   (≤8 words)` + the skipped ones. Reported naming collisions become an explicit fix
   (e.g., rename the old line that used the same name with a different meaning).
5. **Programmatic verification**: search (grep) for `^\*\*Scope\*\*:` — check for 1
   occurrence per file and sum per value. Numbers that do not match = investigate.
6. **Consolidation**: a summary table (value × count × reading of what it means) in
   the product journal + the central index's history. The `mixed` column is the named
   distillation queue.

## Continuous rule (post-census)

It enters the knowledge-retention skill and the root rules file: **every new or
touched file gains the Scope line**. No exception — it is what keeps the collection
100% classified forever.

## Recorded lessons (real situations)

- Parallel classification with identical rules is consistent: 4 agents, 88 docs,
  1 collision (and it was a real naming problem, not a divergence of judgment).
- The census changes the perception of the collection: the portable core tends to be
  LARGER than intuition estimates — without the census, product value stays invisible.
- Classic collision: "Scope" already used with a different meaning in old docs →
  rename the old field (preserving its meaning) and apply the new one.
