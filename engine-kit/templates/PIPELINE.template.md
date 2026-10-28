---
project: <KEY>                          # the projects-registry key of the folder this file sits in
subject: <AREA>
pipeline: PIPE_<AREA>_<CONDITION>       # = the file name; kept stable, never reused for another path
layer: <base|overlay>                   # overlay = a delta against base_pipeline
base_pipeline: "<link to the base project's PIPE_<AREA>_<CONDITION>, or ->"
version: "<version line of the code read>"    # delete the line when the project has no version lines
status: <documented|partial|latent|superseded>
trigger_conditions:                     # names exactly as the settings registry writes them (no row yet: the code's own name, marked in section 1); with subject, the version diff's match
  - "<setting> = <value>"
environment: "<label of the environment investigated> - <stated|read|unknown> <YYYY-MM-DD>"
graph: "<graph id> built <YYYY-MM-DD> - <fresh|graph-stale|none>"
sources:                                # one entry per code tree read (provenance)
  - tree: <code tree, relative to the code root>
    revision: <revision or commit>
    date: <YYYY-MM-DD>
tickets: []                             # work items that asked for or extended this map
last_updated: <YYYY-MM-DD>
tags:
  - pipeline
  - <area in lowercase>
---
# PIPE_<AREA>_<CONDITION> - <the business result this path produces>

**Scope**: <method|case|mixed>
**Condition**: <one line, in words: when this path runs>
**Layer**: <base | overlay - a delta of [[<base project>/SUBJECT/<AREA>/PIPELINES/PIPE_<AREA>_<CONDITION>]]>

> Template from the engine-kit (`templates/PIPELINE.template.md`) - techniques T68 and T83
> (*operating*) and T84 (*candidate*). One document per area and condition, saved as
> `<project>/SUBJECT/<AREA>/PIPELINES/PIPE_<AREA>_<CONDITION>.md` (a client delta in the
> client overlay project). Written by the pipeline-builder agent only; a person mapping by
> hand follows the same template and the agent's rules.
> - **Required**: 1, 2a (base) or 2b (overlay), 3, 5, 7. **When it applies**: 4 (a step
>   lands on an overridden routine), 6 (the path writes state another pipeline or job
>   writes). **Optional**: 8. A required section with nothing to say keeps its explicit
>   line ("None identified - checked: ..."), never left out.
> - Only what the source confirms: every step cites `<unit>.<routine>` at file:line; the
>   rest is marked `Unverified`. An unknown cell says `unknown`, never blank.
> - Links between documents use the base's own form (wiki links as here, or relative
>   paths); source files are cited as plain text with their line, never linked.
> - The **transversal analysis** at the end of this file is a separate document: copy it to
>   `PIPELINES/TRANSVERSAL.md` when the area needs one, and delete it from a pipeline copy.
> - Replace every `<placeholder>`, delete the sections that do not apply, and delete this
>   note. Method: the `pipeline-builder` agent of the kit.

## 1. Trigger conditions

| Setting (registry name, or the code's own name) | Kind | Required value | Default | Value in the environment investigated | Source of that value |
|---|---|---|---|---|---|
| `<setting>` | <property / file-key / env / db / code / build> | <value> | <default from the registry> | <value, or `unknown`> | <stated by <role> <date> / read from <file or read-only query> <date> / frozen in code / unknown> |
| `<the code's own name>` - <unregistered - handed over \| unregistered - row added, unverified \| unregistered - question in section 8> | <kind> | <value> | <default read at file:line> | <...> | <...> |

A setting with no registry row is never left without a receiver: the settings mapper when it
runs; a map written by hand adds the row to the settings registry as `unverified`, or, with
no registry yet, opens a question in section 8 (the pipeline-builder agent, "A setting with
no registry row").

| Data condition | Where it is tested |
|---|---|
| <the business data that forks the path, e.g. the order's type> | `<unit>.<routine>` (<file>:<line>) |

**Default path**: <what runs when every setting is at its default - this path, another
one ([[PIPE_<AREA>_DEFAULT]]), or nothing>.
**Environment investigated**: <label>; <how the values were obtained; `unknown` values and
why the default path was mapped instead>.

## 2a. Steps (base layer)

1. **<Step name>** - `<unit>.<routine>` (<file>:<line>)
   <What it does: the input it consumes, the output it produces; the setting that forks it
   here and the branch taken.>
2. **<Step name>** - `<unit>.<routine>` (<file>:<line>)
   <...>
   > **Unverified:** <what the source did not confirm, and why>

## 2b. Steps - delta against the base pipeline (overlay layer)

Base: [[<base project>/SUBJECT/<AREA>/PIPELINES/PIPE_<AREA>_<CONDITION>]], read at
<revision>. Every step not listed here runs as in the base; the merged layer is what runs.

| Base step | Routine | In this overlay | Change | Evidence |
|---|---|---|---|---|
| <n> | `<unit>.<routine>` | `<overlay unit>.<routine>` (<file>:<line>) | <replaced / added after step <n> / removed / skipped / reordered> | <file:line, revision> |

**Trigger deltas**: <settings this overlay adds, forces in its code or reads differently -
the rows of the overlay's settings registry>.

<Or, when no overlay routine sits on the path: **No delta** - verified <YYYY-MM-DD> at
<revision>: every routine on the path resolves to the base in the merged layer.>

## 3. Output

<What the path produces: a stored record (table and fields), a response, a document, a
message, a side effect - and who consumes it.>

## 4. Override parity

| Step | Routine | Override condition (file:line, quoted) | Base condition (file:line, quoted) | Predecessor condition (file:line, quoted, or "none - written from scratch") | Parity |
|---|---|---|---|---|---|
| <n> | `<unit>.<routine>` | `<condition>` (<file>:<line>) | `<condition>` (<file>:<line>) | `<condition>` (<file>:<line>) | <same / narrower / wider / different / unknown> |

A parity other than `same` is a finding: <the question id or the `KEY#N` that settles it>.
<Or: "No step lands on an overridden routine." - checked in the merged layer.>

## 5. Collision risk

| Collides with | Shared setting or state | Same business key at the same time? | Behaviour at the collision | Evidence |
|---|---|---|---|---|
| [[PIPE_<AREA>_<OTHER>]] | `<setting>` / <table.field, cache, flag, file> | <yes / no / unknown - why> | <first-wins / last-wins / error / silent-overwrite / unknown> | <file:line> |

<Or: "None identified - checked: <the pipelines and the state checked>.">

## 6. Shared state

<"Writes <state>; the other writers and their gates: [[TRANSVERSAL]], writer matrix rows
<n>-<m>." Or: "None - no other pipeline or job writes what this path writes; checked
<how>.">

## 7. Source units

| Unit | Role in this path | Unit document |
|---|---|---|
| `<unit>` | <role> | [[<the docs writer's document>]] / none yet - handed to the docs writer |

## 8. Notes and open questions

> **Open question:** <what is not settled, and who can settle it>

> **Correction:** <a belief the mapping refuted - "the discount is not applied by the
> invoice screen" - with the evidence>

---

## Companion template - the transversal analysis

One per area, when more than one pipeline or job writes the same state, saved as
`<project>/SUBJECT/<AREA>/PIPELINES/TRANSVERSAL.md`. Copy the block below, fill it, delete
its note.

```markdown
---
project: <KEY>
subject: <AREA>
type: transversal-analysis
shared_state: [<table.field | cache | flag | file>]
version: "<version line>"          # delete when the project has no version lines
last_updated: <YYYY-MM-DD>
tags:
  - transversal
  - <area in lowercase>
---
# Transversal analysis - <AREA>: <the shared state>

**Scope**: <method|case|mixed>

> Complements the pipeline documents of the area: what runs ACROSS them on the same state.
> Every claim cites file:line; log or experiment evidence carries its date. Verdicts:
> CONFIRMED / PARTIAL (say which part) / flagged, not asserted. An unknown cell says
> `unknown`, never blank. Delete this note.

## 1. Writer matrix

| # | Writer (pipeline or job) | Moment in its flow | Inserts | Updates | Removes | Key or link it writes | Gate (settings) | Evidence |
|---|---|---|---|---|---|---|---|---|
| 1 | [[PIPE_<AREA>_<CONDITION>]] | <when> | <yes / no / unknown> | <...> | <...> | <field, or none> | `<setting> = <value>` | <file:line> |

**Consequence**: <one paragraph - who wins, what gets orphaned, which writer cannot see or
remove another's rows>.

## 2. Gate matrix per environment (read it first in any investigation)

| Question | How to check (read-only) | <environment A> (<YYYY-MM-DD>) | <environment B> (<YYYY-MM-DD>) |
|---|---|---|---|
| <is writer 2's switch on?> | <screen, configuration key, read-only query> | <yes / no / unknown> | <...> |

## 3. Crossing-failure history

| Date | Work item | Matrix rows crossed | What failed | The fix | What the fix did not cover |
|---|---|---|---|---|---|
| <YYYY-MM-DD> | <id> | <1 and 3> | <...> | <revision> | <the writer or gate combination it never met> |

**Pattern**: <one sentence - the takeaway of the chronology>.

## 4. Background consumers

- <job or service> - <how it reaches the same state, behind which gate> (<file:line>)

## 5. Overlay delta (per client overlay - the merged layer is the ground truth)

- <client overlay> - <the overridden routines in the crossing zone; the merged graph it was read in>

## 6. Open risks and recommendations

1. <risk> - <work item or `KEY#N`>

## 7. Test matrix

A fix that touches this state is tested against each writer alone and the default-gate
combination: <the cases, and where the change's Test plan lists them>.
```
