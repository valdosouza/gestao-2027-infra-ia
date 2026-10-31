---
project: <KEY>
subject: <AREA | <AREA> - new, created with this plan (greenfield)>
work_items: [<ID> | <NS>-W<n> - a wave of a front with no tracker, either track]
mode: plan
status: <draft | approved | revised>
last_updated: <YYYY-MM-DD>
working_copies:
  - <working copy> @ <revision or commit | new - no commit>
tags:
  - plan
---
# Plan - <ID>: <the change in one line a user would recognise>

**Scope**: <method|case|mixed>
**Mode**: plan (change gate)
**Dossier**: `DOSSIER.md` - Source: <local dossier (current week, last_updated YYYY-MM-DD) | live tracker> | none - no tracker; intake: `prompt_<front>.md` sections 1, 2, 5 and its requirements (greenfield)
**Pipeline**: <link to `PIPELINES/PIPE_<...>.md`, one per process touched> | PIPELINE UNMAPPED - map before fix (this plan waits) | none to map - new product; stand-in: `prompt_<front>.md` section 5 + <FR, BR ids> (greenfield)
**Premises (open questions this plan assumes the recommendation of)**: none | Premises: Q-<NS>n: Rec (<x>); Q-<WS>n: Rec (<x>) - written on the recommendations of round <N> of `prompt_<front>.md`; rewritten if any answer differs (the plan carried by the closing round, kit decision EK#26)
**Level**: <the case's level, in effect> | Q-<WS>n: Rec (<x>) - the move to level 2, a premise above | <WS>#n - level 2 decided, in effect when round <N> closes the prompt
**Fact premises (facts still to be read or confirmed)**: none | <R-<NS>n, H-<NNN>> - <what the plan takes them to say>; rewritten if the read, the probe or the owner's answer contradicts them

> Template from the engine-kit (`templates/PLAN.template.md`) - the plan mode of the
> `change-gate` skill (technique T28). It lives at `TICKETS/<ID>/PLAN.md`. Replace every
> `<placeholder>`, delete the sections marked *(optional)* that do not apply, and delete
> this note. **A plan without its Test plan section is not ready for the gate.** No code is
> written before the owner's go is logged in `WORKLOG.md`.

## 1. Recall

- Cards: <K-AREA-NNN - the rule it states> | none found (folders checked: <...>)
- Past logs: <MEMORY/YYYY-MM-DD-<topic>.md - what it found>
- A card this plan contradicts: <id - why> | none

## 2. Baseline (working copies)

| Working copy | Revision | Local modifications | Risk |
|---|---|---|---|
| <path> | <rev> | clean | - |
| <path> | <rev> | <file - what is modified, by whom if known> | <what it can do to this change> |

A dirty working copy is a stated risk: every local modification is listed here, never
silently built upon.

## 3. Rule check *(optional - projects with rule files)*

- <RULES/RULE-<slug>.md, row <KEY>#<n> (Authorised, <date>)> - this plan keeps it.
- No Denied row comes back; no open question is implemented.

## 4. Blueprint

### Phase 1 - Contract and back end

<The contract as the producer emits it - field names, types, the error envelope; schema
changes (guardian verdict: <link>); server-side types.>

### Phase 2 - Logic

<Units and methods that change. For every object created: who creates it, who owns it,
who destroys it, what runs concurrently.>

### Phase 3 - Front end and UI

<Screens, states, messages; each call with its success and failure path; it reads exactly
the contract of phase 1.>

## 5. Impacted files and callers

| File | Tier | Change | Callers that could regress (read) |
|---|---|---|---|
| <path> | <back end / logic / front end / test> | <what> | <path:line, ...> |

## 6. Cross-tier resolution

| Contract field (wire) | Producer | Consumer | Resolves after the change? |
|---|---|---|---|
| <name> | <path:line> | <path:line> | <to check at step 5> |

## 7. Cross-version drift *(optional - parallel version lines)*

DIFF: <link to the version-diff document> | not run: <reason>

| Unit | <line A> | <line B> | Port |
|---|---|---|---|
| <unit> | same | differs: <how> | <port line, the tests that travel with it> |

## 8. Divergence point *(only for a wrong result without a crash)*

Symptom: <expected vs actual, on which input> - State map: <values, step by step> - First
diverging statement: <path:line>. The fix goes there.

## 9. Risks

| Risk | Tier | Level | Mitigation |
|---|---|---|---|
| <risk> | <tier> | <High / Medium / Low> | <what> |

Open hypotheses accepted as risks *(legacy track)*: none | <H-<NNN> - why this change can go on with it open; what would settle it>

## 10. Anti-patch check

This plan silences nothing. <Or: the finding it records - what is silenced, why the cause
is out of reach, the owner's decision id.>

## 11. Test plan

The section's rules belong to the `test-gate` skill. Either filled in:

- Test: <the new or changed test file, or the rows added to a case table, in the project's suite>
- Fails on the old code because: <the assertion, and the production reason it fails> | Fails on the stub because: <the behaviour does not exist yet - the stub returns its sentinel, a value no expected value can equal> (a new unit)
- Runs on: <each line the change touches>; ports: <line> when the port is made | a disposable instance, applied by <person: the people-registry row | not named yet - R-<NS>n> - prepared patch (`PATCH/`, change-gate step 5)
- Expected values derived from: <file, revision, lines read> | <AC, TC ids of the requirements> (a new unit - never from the code being written)
- Proposal promoted: <an existing draft for this change> | none
- Browser cases: <TC ids - one line each, spec `TESTS/BROWSER_SPEC.json` (`browser-verification`)> | none - <reason: no screen a user sees changes | no server may run on this machine - stand-in: <in-process screen tests>, the owner's walk (G4)>
- Test-first steps (EK#30 - their reds are shown with this plan and covered by its go): <step W<n>.<m> - `TESTS/TEST_PLAN.md`, red log `TESTS/RED_<date>.md`> | none

or as one line: `exempt: <a reason a reviewer can check>` (it waives the new test only,
never the suite run).

## 12. Out of scope

- <what this change does not do>

## 13. Questions and assumptions *(optional)*

- <Q-<NS>n - question, evidence, options, recommendation> - see the home register
- <A-<NS>n - assumption taken, where applied, how to undo>

## Gate

> I have generated the architectural plan and sharded the blueprint above. Please review
> and approve before I execute the single-pass code implementation.

Go: <see WORKLOG.md, row <n> - YYYY-MM-DD> | pending | asked on its own line in round <N> of `prompt_<front>.md` (with premises: logged with the round's answer; an answer that differs from a premise voids it)

## After the go (dated) *(optional)*

Facts that arrived with the go or after it and touch no premise - appended here, never
edited into the approved sections above. A fact that breaks a premise voids the plan; one
that changes what the code will be is a revision (`status: revised`, a new gate) - neither
goes here (the `change-gate` skill, step 4). Nor does a line a newer kit version requires
of an approved plan (a `Browser cases:` line in a Test plan approved without one): it goes
into the plan's next revision, and the test evidence carries its stand-in meanwhile (the
browser hand-off line, the `test-gate` skill).

- <YYYY-MM-DD> - <the fact, with its id (R-<NS>n, H-<NNN>, F<n>)>: premises re-read - none broken; risk added: <risk, level, mitigation> | stop condition: <the observable that stops the run - in `PATCH/APPLY.md` for a prepared change>; WORKLOG row <n>
