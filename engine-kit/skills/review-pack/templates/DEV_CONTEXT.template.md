# Template: Dev Context

**Scope**: method
**Used by**: [review-pack](../SKILL.md) step 7 (synthesis) and step 13 (round mode).
**Produces**: `<ID>_Dev_Context.md` in the change's folder. Copy the skeleton below, fill
every `<...>`, and set the copy's own Scope line (`case` for a real change).

The Dev Context is written **for the implementer's own AI**, whatever the editor: a list
of things to load and limits to respect, not a narrative. It owns the decisions in force
(by id), the knowledge pointers, the steps that change per pipeline, contracts and
invariants, settings, units and call sites, the do-not-touch list and the smoke
checklist. Everything the meeting needs - estimate, options, risks, questions,
planning-sheet entries, collisions - lives in the
[Review Brief](REVIEW_BRIEF.template.md); this file points to it and never repeats it.

## Skeleton

````markdown
---
id: <ID>
title: "<title>"
client: <client or "core">
version: <version>
project: <PROJECT-KEY>
area: <area>
pack_date: <YYYY-MM-DD>
brief: "<ID>_Review_Brief.md"
requirements: "<ID>_Requirements.md"
tags: [review-pack, dev-context, <area-tag>]
---
# <ID> - Dev Context

**Scope**: <method|case|mixed>

## 0. Read first
- The case's `AGENTS.md` - the non-negotiables (language, placement, pipeline gate,
  prepare-only, retention).
- Decisions in force for this change: <KEY#N, KEY#M> (texts in the decision register;
  cite them in code comments by qualified id, e.g. `// ORD#14`).
- Still pending: <"see brief section 10 (questions) and 12 (proposed decisions)", or
  "none">. Never build on a pending item silently: proceed on its recommended answer only
  as an assumption `A-<KEY><n>` (the assumption ledger of decision-rounds: where it was
  applied, how to undo it), and never for a value the owner reserved (a price, a
  threshold, a business value).
- What the planners already answered: brief section 2.

## 1. Knowledge to load
| Document | Why |
|---|---|
| `<ID>_Requirements.md` | requirements, acceptance criteria and scenario ids |
| <area index, knowledge cards, contract docs, prior dossiers> | <why each one matters here> |

## 2. Pipelines - steps that change
Status and collisions: brief section 6. An unmapped pipeline is mapped before coding.

| Pipeline (link) | Step that changes | Unit and line |
|---|---|---|
| <name> | <step> | <unit:line> |

## 3. Contracts and invariants
- <invariant, one line> - defined in <document or KEY#N>

## 4. Settings involved
| Setting or key | Where it is read | Effect on this change |
|---|---|---|

## 5. Units and call sites
| Unit | Method or line | Change |
|---|---|---|

## 6. Do not touch
- <units, behaviours, data that stay exactly as they are>
- <other open changes whose scope must not be pulled in>

## 7. Smoke checklist (developer test)
- [ ] <scenario id from the requirements, or KEY#N, or "collision: <what>"> - observe at
      <screen, report or query> - data: <what to prepare>
- [ ] ...

## 8. Hand-off
- Closing: the case's closing step (tracker text, commit message, memory log) - cite the
  decision ids.
- Result review: the case's reviewer works from the requirements' scenario ids and this
  checklist.
- Retention: session log in the area's memory; the change's folder linked from the area
  index.
````

## Rules

- **Paths are real and current.** Open every pointer before writing it; a wrong pointer
  costs the implementer more than a missing one.
- **Lists and paths, no narrative.** The implementer's AI opens what is listed; the
  reasoning stays in the brief.
- **Section 6 (do not touch) is mandatory** - it is where scope creep is stopped. An
  answer in round mode often moves its boundary; update it every round.
- **Section 7 adds, never copies**: each item cites the scenario id (or the decision id)
  it comes from and adds only what the requirements cannot know - where to observe it and
  the data to use. The scenario's steps stay in the requirements file. Every collision in
  brief section 6 gets at least one smoke item.
- **Section 0 changes every round**: the decisions registered in the round move from
  pending to in force.
- No estimate, options, risks, questions or planning-sheet quotes here - those are the
  brief's.
