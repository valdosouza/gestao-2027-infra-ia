---
project: <KEY>
subject: <AREA>
work_items: [<ID>]
mode: spec
status: <draft | approved | revised>
revision: <0 for the first text; +1 for each revision>
last_updated: <YYYY-MM-DD>
working_copies:
  - <working copy> @ <revision or commit>
tags:
  - spec
---
# Spec - <ID>: <the change in one line a user would recognise>

**Scope**: <method|case|mixed>
**Mode**: spec (change gate)
**Status**: <draft | approved (revision N, YYYY-MM-DD) | revised (revision N, YYYY-MM-DD) - waits for its gate>
**Dossier**: `DOSSIER.md` - Source: <local dossier (current week, last_updated YYYY-MM-DD) | live tracker>
**Inputs**: <review brief and implementer context of the change request, with the meeting's decisions by id; the owner's statements, quoted>
**Pipeline**: <link to `PIPELINES/PIPE_<...>.md`, one per process touched> | PIPELINE UNMAPPED - map before fix (this spec waits)

> Template from the engine-kit (`templates/SPEC.template.md`) - the spec mode of the
> `change-gate` skill (technique T28). It lives at `TICKETS/<ID>/SPEC.md`. The spec is the
> source of truth: the code follows it, never the other way round. States: `draft` ->
> `approved` (the owner's go, logged in `WORKLOG.md`) -> `revised` (any change after
> approval; it passes its own gate before the code moves). Replace every `<placeholder>`,
> delete the sections marked *(optional)* that do not apply, and delete this note. **A spec
> without its Test plan section is not ready for the gate.**

## 1. Recall and baseline

- Cards: <K-AREA-NNN - the rule it states> | none found (folders checked: <...>)
- Working copies: <path @ rev - clean | each local modification, as a risk>
- Rule rows relied on *(optional - projects with rule files)*: <<KEY>#<n>, Authorised, date>

## 2. Functional requirements

Numbered, one testable sentence each. A number is never reused; a dropped requirement stays
with "withdrawn in revision N".

- **FR-1** - <When ..., the system ...>
- **FR-2** - <...>

## 3. Data contracts

| Field (wire) | Type (producer) | Type (consumer) | Required | Rule |
|---|---|---|---|---|
| <name> | <type> | <type> | <yes / no> | <constraint, decision id> |

Schema changes: <table, column, type - guardian verdict: <link>> | none
Error envelope: <shape, codes>

## 4. UI behaviour

<Screens, modes, states, messages; what the user sees on success and on each failure.>

## 5. Edge cases and errors

| Case | What happens | What the user sees | What is logged |
|---|---|---|---|
| <case> | <behaviour> | <message> | <entry> |

## 6. Test plan

| FR | Test that will pin it (path in the project's suite) | Fails on the old code (a new unit: on its stub) because | Runs on |
|---|---|---|---|
| FR-1 | <test or case-table row> | <assertion, production reason> | <suite / branch / line> |
| FR-2 | `exempt: <reason>` | - | - |

Expected values derived from: <file, revision, lines read> | <AC, TC ids of the requirements>
(a new unit). Proposal promoted: <an existing
draft for this change> | none. Browser cases: <TC ids, spec `TESTS/BROWSER_SPEC.json`> |
none - <reason>. The section's rules belong to the `test-gate` skill;
`exempt: <reason>` waives the new test of that requirement only, never the suite run.

## 7. Out of scope

- <what this change does not do>

## 8. Questions and assumptions *(optional)*

- <Q-<NS>n - question, evidence, options, recommendation> - see the home register
- <A-<NS>n - assumption taken, where applied, how to undo>

## Gate

> I have generated and archived the technical specification (SPEC.md) in the ticket folder
> above. Please review and approve the spec before I write any implementation code.

## Status history

| Revision | Date | Status | What changed and why | Go (WORKLOG row) |
|---|---|---|---|---|
| 0 | <YYYY-MM-DD> | draft | first text | - |
| 0 | <YYYY-MM-DD> | approved | - | <row n> |
| 1 | <YYYY-MM-DD> | revised | <FR-2 narrowed: ... because ...> (old text kept below, quoted) | pending |

## Compliance (filled after the single pass)

Requirement by requirement against the code; every row needs its evidence. `partial` or
`missing` sends the change back to the implementation, or to a revision - never to the
hand-off.

| FR | Status | Where (file:line) | Test that pins it | Note |
|---|---|---|---|---|
| FR-1 | <implemented / partial / missing> | <path:line> | <test name, path> | |
| FR-2 | <...> | <...> | <exempt: reason> | |
