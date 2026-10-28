# Dependency-levelled incremental tests - design

**Scope**: method

Companion of [the test-gate skill](../SKILL.md), section 7 (T44).

> **Maturity: design - never run in a real case.** Case zero produced this design for the
> data sync between a legacy desktop application and a new service: a plan, a dependency
> map of a few dozen tables in about seven levels, a test-session API and a skeleton of
> the orchestrating code - and stopped there. Nothing below has been measured. The first
> case that runs it records what happened (section 6) and proposes the new label in the
> CHANGELOG ([maturity](../../../docs/MATURITY.md)).

## 1. When it applies

A **data transfer** - a sync, a migration, a seed, a replication - of many related tables
into a target that enforces references. Sending everything at once turns one bad row
into a cascade of errors in every dependent table, doubles the load on each retry and
hides the first cause. The design sends one table at a time, in dependency order, and
stops at the first error.

## 2. The dependency map

- **Level 0**: tables that reference no other transferred table. **Level n**: tables that
  reference only tables of lower levels. Ordering constraints that the target enforces at
  run time (a "dependency not synced" error when table A arrives before table B) are
  levels too, even when no foreign key declares them.
- **One row per route**, not per table: a table sent through two routes (two endpoints,
  two filters, two variants) is two rows of the map, at the level of their own
  dependencies.
- **Listed but not tested**, with the reason: inactive routes, retired modules, tables the
  target creates implicitly from a natural key (they have no step of their own).
- **Where the target de-duplicates on a natural key** (a description, a document number)
  rather than on the source id, the check counts rows without duplicates, not raw rows.
- **Where the target recalculates** something on arrival (a tree position, a balance), the
  check names the recalculated columns and leaves them out of the comparison.
- The map is **found by reading** the schema and the sending code (an agent can photograph
  it; a script re-checks it), and **a human reviews it** before the first run.

## 3. The test log

Two structures, in the target's database or beside it - shown as columns, not as DDL:

| Session | Content |
|---|---|
| id | one test round |
| started, ended | timestamps |
| status | `running`, `stopped`, `done` |
| notes, who | the round's purpose; the person who ran it |

| Table log | Content |
|---|---|
| session, table, route | which step |
| status | `pending`, `running`, `success`, `failed`, `blocked`, `reset` |
| expected | count at the source (with the same filters the route uses) |
| sent, failed | counts reported by the transfer |
| error | the literal message and its details (response, stack) |
| started, ended | timestamps |
| approved by, approved at, ready to retry | the reset approval (section 4, step 5) |

## 4. The loop

1. **Open a session.** Load the reviewed map.
2. **Level by level, table by table**: count what the source should send; mark the step
   `running`; run the **existing** transfer for that route, marked as a test so the target
   can tell (a header, a session id); record `sent` and `failed`; compare with `expected`.
3. **Success**: the step is `success`; next table.
4. **First error: stop.** The step is `failed` with the literal error; every table of a
   later level that depends on it is `blocked`; nothing else is sent. Never resend
   everything.
5. **Fix, then reset only with approval.** Diagnose from the error log, fix the code,
   rebuild. A named person approves the reset of **that one table's** test rows in the
   target; the approval (who, when) is written in the log and sets "ready to retry". The
   reset deletes only the rows of that step.
6. **Resume from the failed table**, not from the start of the round.
7. **Close the session** with a report per level: successes, failures, blocked tables,
   resets and who approved them.

## 5. Guard rails

- Run it against a **disposable copy** of the target whenever possible: a reset is a
  delete. In a shared database, the reset waits for the owner's release word
  ([`decision-rounds`](../../decision-rounds/SKILL.md), the assumption ledger and the
  release word).
- The test API (open a session, start and finish a step, list errors, reset, report) is
  a test facility: it is not exposed where the production service runs without a
  decision.
- Personal data used in a round stays in the case; the evidence names counts and errors,
  never row content.
- The run keeps the test-gate rules: the map's expected counts come from reading the
  source with the route's own filters (never pasted from the target), and a step that
  could not run on this machine is `not run here: <reason>`, not a failure.

## 6. What the first real run should record

To move from `design` to `candidate` or `operating`, the first case records, anonymised:

- the size of the map (tables, routes, levels) and how many map rows the human review
  corrected;
- how many rounds it took to reach a full pass, and where each round stopped;
- whether stopping at the first error found causes earlier than a full send did;
- how many resets were approved, and whether any reset deleted more than its step's rows;
- the time per level, and whether the log alone was enough to diagnose each failure.
