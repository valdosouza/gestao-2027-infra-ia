# Shared intake and the pipeline gate

**Scope**: method

Companion of [the change-gate skill](../SKILL.md), steps 0 and 2 - techniques T36 (shared
intake, `candidate`) and T27 (pipeline gate, `operating`). Example: **CR-123, "Acme Orders:
allow a partial shipment of an order"**.

## 1. Shared intake (T36)

One intake per change, consumed by every later step. The plan, the spec, the red test, the
review and the close read the dossier; none of them calls the tracker again for the same
facts. A wave of a greenfield front with no tracker writes no dossier: its closed prompt
and requirements are the intake ([the skill](../SKILL.md#a-greenfield-wave-no-tracker-no-flow-to-map-no-area-yet)).

### Freshness - reuse this week's dossier, say where it came from

Before any tracker call, look for `TICKETS/<ID>/DOSSIER.md` and read its front-matter
`last_updated`.

| Found | Then | First line of the summary |
|---|---|---|
| `last_updated` in the current calendar week (Monday to Sunday) | reuse it: no tracker call, no new download | `Source: local dossier (current week, last_updated 2026-10-19)` |
| older, or no `last_updated` | go live, rewrite the dossier, `last_updated` = today | `Source: live tracker` |
| the owner asks for a refresh in the same request | go live | `Source: live tracker (refresh asked)` |

The source line is never omitted: a reader must know whether the facts are this week's.

### Noise filter

| Leave out | Keep |
|---|---|
| requests for access to a database, a server or an environment, and who should get credentials - unless access *is* the change | repro steps, environments and accounts used to reproduce, URLs |
| state, assignee, sprint, priority and area changes with no technical comment | developer notes on the cause, endpoints, queries, partial fixes |
| bare mentions, "moved to test", "approved" without what was fixed | impact on users, inconsistent behaviour |
| a status table at the top of the summary | the problem first: what is broken or asked, how to reproduce, what was tried |

### QA revert feedback first

When the item came back from testing (a revert to the developer, a failed test cycle):

1. Find the most recent transition into the revert state.
2. Collect every substantive comment of that cycle - from the hand-over to test through
   the revert.
3. Extract: the build or version tested, what was tried, expected vs actual, regressions
   the fix caused, open questions to the reporter.
4. Put it in its own section, **QA revert feedback**, and lead the "ready to start"
   section with what failed in the latest cycle. Several reverts: one line per cycle, the
   latest in full.

This is not workflow noise; it is the main input of the next attempt.

### Related items - only with developer notes

Search the tracker two or three ways (vary the symptom words); keep only items that were
worked (past development) **and** whose developer or resolution notes are filled. List at
most three, newest first, each with a one-line summary of its notes. Keyword-only matches
are not listed. None found: "No related worked items with developer notes".

### Attachments mined to text

- Download what has documentary value into `attachments/`; skip large binaries without it.
- Every document attachment (word processor, spreadsheet, PDF) gets a plain-text
  extraction next to it (`<name>.txt`): paragraphs and tables, sheets as rows, page text.
  The text is searchable by the memory index and by search tools.
- Quote the relevant part in the dossier. A requirement form inside an attachment is the
  requirement; it must not stay opaque.
- When the agent cannot download, it records the links and asks the owner to put the
  files in `attachments/`, then extracts the text.

### Prior knowledge, in the dossier

The before-action loop of [`memory-engineering`](../../memory-engineering/SKILL.md) runs
here: claims with their status and confidence, failed hypotheses, known collisions, open
questions. A prior claim that conflicts with this change's symptoms is marked
**possible contradiction - recheck**; the old log is never rewritten from here. Nothing
found: "No prior knowledge found" and the folders checked.

### Principles

- Never invent a link, a person, an item or a date: write "not specified" or "none found".
- A name from a tracker field is quoted as a field value, never turned into a role
  ([kb-setup, section 4](../../kb-setup/SKILL.md#4-people-are-not-roles-t25-operating)).
- The tracker is read-only during intake.
- The dossier is written in the case's artifact language; the chat summary follows the
  language the owner writes in.

### Dossier skeleton

```markdown
---
project: <KEY>
subject: <AREA>
work_items: [CR-123]
last_updated: 2026-10-19
---
# CR-123 - Acme Orders: allow a partial shipment of an order

**Scope**: <case key>

Source: live tracker

## Core issue            (2-4 sentences: symptom or ask, scope, how to reproduce, impact)
## Repro / the ask       (steps, environment, accounts; quotes from attachments)
## QA revert feedback    (only when the item came back from testing; latest cycle first)
## Timeline              (2-6 substantive events)
## Related worked items  (up to 3, each with its developer notes; or "none found")
## Attachments           (file -> its .txt -> the part that matters)
## Prior knowledge       (claims, cards by id, contradictions; or "none found" + folders)
## Pipeline              (link to PIPELINES/PIPE_<...>.md | PIPELINE UNMAPPED - map before fix)
## Ready to start?       (what to do first; after a revert, what failed last time)
```

## 2. The pipeline gate (T27)

**No fix design on a process nobody has mapped.** The rule and its reason are in section 4
of [`memory-engineering`](../../memory-engineering/SKILL.md); here is how the change gate
applies it.

### Where it sits

| Step | Allowed on an unmapped process | Not allowed |
|---|---|---|
| Intake (0), recall (1) | reading, querying, writing the dossier | - |
| Pipeline gate (2) | mapping the process | - |
| Plan artifact (3) | - | designing the fix, the spec or the red test |
| Single pass (5) | - | any code |

### How to pass it

1. Name every process the change touches (from the dossier and the code graph).
2. For each one, look in the area's `PIPELINES/` (and, in a layered project, in the base
   project's too).
3. **Mapped** -> link it in the dossier and the plan artifact. Check that the code graph it
   was drawn from is fresh against the code; a stale graph is re-checked against source
   before anyone trusts it.
4. **Unmapped** -> the dossier says `PIPELINE UNMAPPED - map before fix`, and the mapping
   comes first: trigger, steps, the settings that make it branch, collisions with other
   processes - from the graph, confirmed in source. The mapper - the
   [`pipeline-builder`](../../../agents/pipeline-builder.md) agent after the
   [`settings-mapper`](../../../agents/settings-mapper.md), or the developer by hand with the
   [pipeline template](../../../templates/PIPELINE.template.md) - writes the map; then step 3
   starts.
5. **Already mapped by an earlier step** (a bug analysis that wrote or extended the map
   and ended with a fix proposal) -> link it; do not remap.
6. **A new product** (a greenfield wave: no code implements the flow yet) -> nothing to
   map; the design of the closed prompt and its requirements stand in, and the plan says
   so: `Pipeline: none to map - new product; stand-in: prompt_<front>.md section 5 +
   <FR, BR ids>`. A later change to a built flow that departs from that design maps it
   (step 4).

### Example

```markdown
## Pipeline
- Order shipment: SUBJECT/SHIPPING/PIPELINES/PIPE_SHIPMENT_STANDARD.md (graph fresh,
  checked 2026-10-19)
- Partial invoicing on shipment: PIPELINE UNMAPPED - map before fix. The plan waits for
  PIPE_INVOICING_ON_SHIPMENT.md.
```
