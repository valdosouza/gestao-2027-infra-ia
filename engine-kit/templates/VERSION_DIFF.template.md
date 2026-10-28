---
project: <KEY of the base line's project>
subject: <AREA>
work_item: <ID | none>
base_line: <the line the change is planned on, or the "from" line of an upgrade>
lines: [<line>, <line>]
items: [<pipeline or unit>, <pipeline or unit>]
status: <complete | stopped | narrowed>
runs:
  - date: <YYYY-MM-DD>
    status: <complete | stopped | narrowed>
sources:                      # every document read, one entry per document and line
  - line: <line>
    document: <path relative to the knowledge-base root>
    last_updated: <as its front matter states | none stated>
    source_revision: <as its front matter states | none stated>
tags:
  - version-diff
  - <area>
---
# Version diff - <AREA or unit> - <base line> vs <line>[, <line>]

**Scope**: <method|case|mixed>
**Asked for**: <the plan of <ID> | a port decision | a review pack's prior art | an upgrade from <line> to <line>> - by <who>
**Verdict**: <same on every line | differs on <lines> | stopped: <n> documents missing | narrowed: <what was left out>>

> Template from the engine-kit (`templates/VERSION_DIFF.template.md`) - technique T35,
> *candidate*. Written by the `version-diff` agent from DOCUMENTS only: the pipeline
> documents and unit references of each line's knowledge folder, never code. With a work
> item it lives in the ticket folder; without one, in the base line's area folder, linked
> from its INDEX. A stopped diff keeps sections 1, 2 and 7 only. Replace every
> `<placeholder>`, delete the sections that do not apply, and delete this note.

## 1. Coverage

Every item against every line, before anything is compared. A cell is the counterpart
document's path, `absent (<document that says so>)`, or **MISSING** (no document: unknown).

| Item | Kind | <base line> | <line> | <line> |
|---|---|---|---|---|
| <pipeline name> | pipeline | `<path>` | `<path>` | MISSING |
| <unit> | unit | `<path>` | `<path>` (unproven: no source revision) | `<path>` |

How counterparts were matched: <pipelines by area + trigger condition; units by source
path; any rename and the document that states it>.

## 2. Missing documents (status `stopped` or `narrowed`)

| Line | Item | Missing document | Who writes it | Then |
|---|---|---|---|---|
| <line> | <item> | <pipeline document / unit reference / the line's statement that it does not exist> | <the pipeline builder / the docs writer, on that line> | run the diff again |

Narrowing, when the requester chose it: "<the requester's words, quoted>" (<date>) - not
compared: <items or lines>.

## 3. Pipelines

### Only on one side

| Pipeline | <base line> | <line> | Document that says so |
|---|---|---|---|
| <name> | present | absent | `<path>` |

### Changed: <pipeline name>

| Aspect | <base line> | <line> | How it differs |
|---|---|---|---|
| Trigger | <as documented, section> | <as documented, section> | <one line> |
| Step <n> | <...> | <...> | <added / removed / changed / moved> |
| Settings | <setting, default> | <setting, default> | <added / removed / default changed> |
| Output | <...> | <...> | <...> |
| Collisions | <...> | <...> | <new / gone> |

Wording-only differences (same behaviour, other words): <list, or none>.

## 4. Units

| Unit | <line> | How it differs, by the documents | Evidence (path, section, both sides) |
|---|---|---|---|
| <unit> | same / differs / absent | <public interface, documented behaviour, dependencies, known issues> | `<path>` section <...>; `<path>` section <...> |

## 5. Settings

| Setting | <base line> | <line> | Pipelines it bifurcates |
|---|---|---|---|
| <name> | <default, as documented> | <default / absent> | <pipeline names> |

## 6. What follows for the change

The owner decides which lines receive a port; this section only proposes.

| Line | Diff | Proposal | Tests that would travel |
|---|---|---|---|
| <line> | same | port candidate: the same fix likely applies | <test names or rows> |
| <line> | differs | stated risk for the plan: compare that line's code in the plan's drift section before the gate | - |
| <line> | absent | no port: <why> | - |

For an upgrade comparison, the notes for whoever moves between the lines: <what behaves
differently, which settings to check, which client overlays touch the changed steps>.

## 7. Provenance and not done

- Documents read: the `sources` list above; their dates and revisions copied as written,
  never checked against code.
- Every claim about code behaviour here is an inference from documents until someone
  reads the code.
- Not done: no code read, no document written or fixed, no port chosen, nothing committed.
