---
name: disposable-proof
description: Proves a seed, migration or one-way act in a throwaway copy before it touches shared data - count, rerun idempotent, an impossible variant must fail loud, clean up; seeds by natural key, never fixed ids; a cutover window gets a runbook rehearsed on a second instance with outbound hosts blocked.
---

# Skill: Disposable proof and the cutover window

**Scope**: method
**Maturity**: operating

**When to use**: before a seed, a data migration, a schema change or any one-way act
(switching which system owns a record, retiring a store, turning a gate on) touches a
shared or production database; before asking the release word for it; and whenever the
owner's walk or a live attack would touch data that must not change.
**Not for**: unit tests of the code (those run on test doubles or a test database), or
reversible work inside the working copy.
**Real origin**: case zero (2026-10). Every seed and schema change of several fronts was
proved in a throwaway schema before it reached the shared database; the impossible
variant caught post-conditions that a happy run would never exercise. One cutover - a
service taking over records from the legacy application, with no rollback after the act -
was rehearsed end to end, abort included, on a second database instance with outbound
production hosts blocked in the process; the rehearsal broke a build path the developers'
daily loop never used, days before the window. One case, core by choice: `operating`
([maturity](../../docs/MATURITY.md)); technique T33 in the [register](../../docs/TECHNIQUES.md).
**Hands off to**: [`decision-rounds`](../decision-rounds/SKILL.md) (the release word for
each irreversible step), [`delivery-gates`](../delivery-gates/SKILL.md) (the owner's walk
and live attacks run on the disposable instance), [`fences`](../fences/SKILL.md) (a seed
of a fenced catalog ends with the fence's publish check) and the runbook template
[`templates/CUTOVER_RUNBOOK.template.md`](../../templates/CUTOVER_RUNBOOK.template.md).

---

## The principle

A seed or a migration has one chance to be right on the shared database, and the common
failures - a duplicate on the second run, a row that should have stayed deleted coming
back, a missing row nobody noticed - do not show on a happy first run. **Prove it where
failure is free**: a throwaway copy, the real script, four checks, then delete the copy.
An irreversible act gets the same treatment at a larger scale: a written runbook,
rehearsed on a second instance cut off from the outside world, before the window opens.

Example used throughout (fictional): **Acme Orders** seeds the permission pairs of its
new refunds screen, and later moves refund processing from the legacy application to the
new service in one window.

## Part A - the disposable proof

### Choose the copy

| Situation | Copy | How |
|---|---|---|
| the code and the script take the schema name as configuration | **throwaway schema** | create it, copy **only the tables the script touches** (structure + data), run the script with only the target swapped |
| schema names are fixed in the code or the script | **second instance** | the same engine and version on another port with its own data folder, bound to the local machine only, the same server settings (modes, character set, lock timeouts), restored from a read-only consistent dump - [references/rehearsal-instance.md](references/rehearsal-instance.md) |

Run **the real script with the real runner** - the same connection options, the same
multi-statement mode - changing nothing but the target. A proof of a hand-edited copy of
the script proves the copy.

The same holds for a **prepared code change** rehearsed in a disposable instance
([prepared patch](../change-gate/references/prepare-only.md#7-a-change-the-agent-cannot-write-or-run---the-prepared-patch)):
the artifact is built and installed **the way production builds it** - the person's own
build command, profile and install steps - and every doubt about what the build does to a
touched file (filtering, generation, packaging) is a probe run before the test patch. A
build path the daily loop never takes can be broken (Part B), and a build that rewrites a
file can defeat the approved test.

### The four checks

| # | Check | Passes when |
|---|---|---|
| 1 | **Count** | the shared database's count is recorded before; after the first run, the delta equals the one computed **independently** from the spec (not from the script), and a sample is checked row by row |
| 2 | **Rerun** | a second run leaves exactly the same state (idempotent); a row a person removed after the seed (soft-deleted) stays removed on a third run |
| 3 | **Impossible variant** | a copy of the script with one entry that cannot exist (a screen that does not exist, a parent that is absent) **stops with a clear error** - it never skips quietly |
| 4 | **Clean up** | the copy is dropped; the shared database's count is the same as before the proof |

The impossible variant only fails loud if the script **checks its own post-conditions**
(every expected row exists, no orphan, no screen without its required action) and stops
when one is false. A seed without post-conditions cannot pass check 3: add them. Recipe,
SQL shapes and the proof record: [references/proof-recipe.md](references/proof-recipe.md).

### The record

The proof is a table in the front's log - step, result - with the copy's name, the
script's hash and the counts. Then the real application repeats it on the shared database
after the release word: **precondition** (the catalog equals the one proved: counts, last
change, the script's hash), apply with the real runner, recount, check the effect where
the consumer reads it (read-only), keep the evidence.

## Seeds by natural key, never fixed ids

- **Rows are found by their business key** (code, slug, name), never by a numeric id:
  ids differ between environments, and a seed that assumes them breaks on the first
  database that took a different path.
- **Insert if absent, by the natural key; ids come from the target.** Relations are
  resolved by joining on the natural keys of both sides.
- **"Absent" includes soft-deleted**: an existence check that ignores removed rows revives
  what a person deleted. Decide it on purpose: a seed either respects human removals (the
  default) or restores them, and says which.
- **Flags and settings** the seed turns on: say whether a rerun re-enables one a person
  disabled. That is a behaviour, not an accident.
- **Tests never assume an id** the seed produced; they look rows up by natural key.
- **Non-transactional scripts** keep what they wrote before a failing post-check. That is
  acceptable only because the script is idempotent - fix the list, run again - and it is
  written down as a known limit.

## Part B - the cutover window

An irreversible act - after it, there is no rollback, only a forward fix - gets a runbook
and a rehearsal. Start the runbook from
[`templates/CUTOVER_RUNBOOK.template.md`](../../templates/CUTOVER_RUNBOOK.template.md).

### The runbook

- **An entry criterion**: what must be true before the window opens (gates passed,
  questions decided, rehearsal done on the current revisions, usage stopped).
- **A step list**, each step with its command, its **expected result** and its **abort
  trigger** (the observable that stops the window there).
- **The point of no return**, marked on its step. Every step before it has an abort path;
  every step after it has only forward fixes.
- **An abort path** with its own steps and expected results, valid until a named step.
- **A release-word line** for every irreversible step - the word given at that moment, not
  once for the whole window ([`decision-rounds`](../decision-rounds/SKILL.md)).
- **Post-window checks**: counts on both sides, the service's start log, the fences, the
  production state read back, cleanup.

### The rehearsal

On a **second instance** with the same names as production, never on production itself.
Recipe and the risks it closes: [references/rehearsal-instance.md](references/rehearsal-instance.md).

- **Outbound hosts blocked in the process**: a preload that refuses name lookup and
  connections to the listed production hosts (providers, payment, mail), and **refuses to
  start with an empty list**. A copy holds real records; one click on "cancel" in the
  copy must not reach a real provider.
- **A port probe before every step**: ask the database server itself which instance it is
  (its port and data folder) from the same working folder and configuration the step
  will use. Nothing runs with its execute flag unless the probe names the copy -
  configuration files in a working tree often point to production.
- **Separate keys and side channels**: own signing keys (a token minted in the rehearsal
  is invalid in production), storage and secret folders that are empty, mail pointed at a
  closed port, new passwords for the copy's users (production passwords never enter it).
- **Rehearse the whole runbook**: the dry runs, the abort's dry run, the act with its
  execute flag, the restarts in their order, and **the build and deploy of every
  artifact** - a build path the daily development loop never takes can be broken.
- **Read production back afterwards** (read-only): nothing changed.
- **Clean up**: stop the rehearsal processes by **port and command line**, never by a
  process id found by name; delete the folder, data included; remove links with the
  command that removes a link, never a recursive delete through it.

### Dry runs and the abort

- **A dry run has a written success criterion**: for example, exit 0 and a report whose
  only blocker is the one expected at that step. Exit 1 means the rehearsal did not pass:
  resolve it before the next step - never proceed by reading the blocker list alone.
- **The abort is rehearsed in the same step as the act's dry run** and must answer without
  refusal. If the abort would refuse, the window stops there.
- **The abort leaves a tombstone before it undoes anything**: a marker the new code refuses
  to start on, written first, so an abort interrupted half-way can be run again to finish.
  Coming back later removes the tombstone explicitly.
- **The abort's validity ends at a named step**, and the script itself refuses after it.
- **Re-rehearse on the day** if any repository changed since the rehearsal.

## Anti-patterns (each one happened)

- **"It ran fine once."** The first run is the only one that is easy; the rerun and the
  revived soft-deleted row are where seeds break.
- **A post-condition that cannot fail.** Without the impossible variant, a check that
  always passes looks like a check that passed.
- **A copy with another name** when the code fixes schema names: the proof ran against
  nothing the code would ever touch.
- **The working tree's configuration** pointing the rehearsal at production - caught only
  because the probe ran before the step.
- **Stopping a process by name** on a machine that also runs production.
- **A build never run outside the window**: the deploy step failed in the rehearsal, which
  is exactly where it should fail.
