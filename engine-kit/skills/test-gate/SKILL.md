---
name: test-gate
description: Use when a plan or spec needs its Test plan (or exempt line), a test must fail red first, the suite runs before review, failures need splitting into new vs pre-existing against a baseline, test evidence is written, or tests close with their coverage lists; also data-sync tests by dependency level.
---

# Skill: Test gate (a planned test, a real red, a baseline diff, honest evidence)

**Scope**: method
**Maturity**: operating
**When to use**: whenever a change will touch code that a test suite can reach - at the
plan (the Test plan), during implementation (the test first, red), after the build (the
suite gate), and before the hand-over (evidence, coverage lists). Also when someone asks
"is the suite green?", "can this be exempt?", "whose failure is this?" or "can we make the
hook blocking?".
**Not for**: checking a fix in the running application through a browser, reviewing the
result, or the delivery scores - those are other gates of the change cycle:
[`browser-verification`](../browser-verification/SKILL.md),
[`delivery-gates`](../delivery-gates/SKILL.md) and [`result-review`](../result-review/SKILL.md).
Not for writing the commit watcher or the baseline tool: they are runtime
([`runtime/testing/`](../../runtime/testing/README.md)).
**Real origin**: case two - a multi-developer product team putting a shared
characterisation suite under a core product with several maintained lines (about 1.2k
tests on one line, scaffolds on three others, a commit watcher drafting test proposals).
The gate was added to the change workflow, then revised twice in two days after reviews:
first so that it blocks only what the change breaks, then so that nothing mechanical
blocks during the rollout. The rules below are those corrections. T44 comes from case
zero and was never run.
**Parts**: Test plan (T37), baseline-diff gate (T38), evidence integrity (T76) and
coverage completion (T77) are `operating` - one case, core by choice
([maturity](../../docs/MATURITY.md)). Dependency-levelled incremental tests (T44) are
`design`: **never run in a real case** ([section 7](#7-dependency-levelled-incremental-tests-t44---design-never-run)).
Register: [docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`decision-rounds`](../decision-rounds/SKILL.md) (the owner decides when an
existing test turns red on purpose; a project decision turns a door blocking; the rule
gate is re-read), [`memory-engineering`](../memory-engineering/SKILL.md) (recall and the
pipeline gate before the plan), [`retain-knowledge`](../retain-knowledge/SKILL.md) (what a
red run taught). Evidence file:
[`templates/TEST_EVIDENCE.template.md`](../../templates/TEST_EVIDENCE.template.md).
Detail: [baseline diff](references/baseline-diff.md),
[evidence integrity](references/evidence-integrity.md),
[coverage completion](references/coverage-completion.md),
[dependency-levelled tests](references/dependency-levelled-tests.md).
**Changelog**: 2026-10-21 - first version (wave 2): T37, T38, T76, T77 from case two's
shared suite and its three gate decisions; T44 from case zero's data-sync test design.
2026-10-27 - from a greenfield exit test: a new unit is red on its stub, with expected
values from the requirements (section 1). Its stage 3: the stub returns a sentinel no
expected value can equal; a test the stub's value satisfies is a test-plan defect. Its
stage 4: a stubbed class or a web application compares the whole result (or the status)
first; the Test plan's `Browser cases:` line, and its stand-in where no server may run.
2026-10-28 - its stage 5: a Test plan approved without that line gets it at its next
revision, and the evidence carries the browser hand-off line meanwhile.

---

## The principle

A green run is a claim, not a proof. The gate asks four questions of every change, in
this order:

1. **Was the test planned before the code?** - the Test plan (T37).
2. **Did it fail, for the production reason, before the fix?** - red first (T37, T76).
3. **Did the change break anything that was not already broken?** - the baseline diff
   (T38): a change is judged against what it found, not against perfection.
4. **Does the evidence add up?** - counts, logs, expected values, coverage lists (T76, T77).

And one discipline across all four: **what was not done is a written line** -
`exempt:`, `skip:`, `not run here:`, `coverage not rerun` - never a silence, never a pass.

Words used here: a **line** is a maintained version line (a branch) where the change
lands; the **suite** is the line's automated test suite; a **door** is a mechanical check
(a commit hook, a closing script); the **owner** is whoever decides the behaviour
([`decision-rounds`](../decision-rounds/SKILL.md)).

## Where the gate sits in the change cycle

| Step | What the test gate adds | Part |
|---|---|---|
| Recall | read the suite's **index of tested changes** and any open **test proposal** for the change: a row means the tests exist; a proposal means promote that draft, never write a second one | T37 |
| Plan, spec or red test | a **Test plan** section ([section 1](#1-the-test-plan-t37)); an artifact without it is not ready for the go | T37 |
| Go (code gate) | the owner's go requires the Test plan | T37 |
| Implementation | the test first, run red with the log kept, then the production files; one pass per file still holds (the test is its own file) | T37, T76 |
| Build | - (the [`build-analyst`](../../agents/build-analyst.md) agent, where the stack compiles) | |
| **Suite gate** | a step of its own after the build and before the delivery gates and the review, once per line the change touches ([section 2](#2-the-suite-gate-and-the-baseline-diff-t38)) | T38, T76, T77 |
| Browser check, delivery gates, result review | - | |
| Closing | the index row for the change or its `exempt:` line; the evidence file; fix and tests handed over as two commits, the fix first (the close script's `test-gate` check, warning only) | T37, T38 |

The code gate ([`change-gate`](../change-gate/SKILL.md): plan, spec or test-first, the go, the single
pass), the browser check, the delivery gates, the result review and the closing are other
skills of the change cycle; the closing is [`close-and-retain`](../close-and-retain/SKILL.md). The test gate is the first
hand-off after the single pass, and owns only what is listed in the middle column.

## 1. The Test plan (T37)

Every plan artifact - a plan, a spec, or a red test written first - carries a section
**Test plan**, either filled in:

```markdown
## Test plan
- Test: <the new or changed test file, or the rows added to a case table>
- Fails on the old code because: <the assertion, and the production reason it fails>
- Runs on: <each line the change touches>; ports: <line> when the port is made
- Expected values derived from: <file, revision, lines read>
- Proposal promoted: <the watcher's draft for this change, if one exists> | none
- Browser cases: <TC ids, spec TESTS/BROWSER_SPEC.json> | none - <reason>
```

or as one written line:

```markdown
## Test plan
exempt: <a reason a reviewer can check>
```

Rules:

- **Mandatory.** The go is not given on an artifact without a Test plan. In a test-first
  change the red is proved before the go; in a plan-first or spec-first change the test
  is still written and run red **before** the production files.
- **Red first, log kept.** Write the test, run it on the unchanged code (a new unit: on its
  stub, [below](#a-new-unit---greenfield-no-old-code)), keep the log. The
  red must be an assertion failing for the production reason - a compile error, a setup
  exception or "no tests found" is not red ([section 3](#3-evidence-integrity-t76)). Then
  the production code, then green.
- **`exempt: <reason>` waives only the new test - never the suite run.** The suite gate
  still runs on every line the change touches, as a regression check. Reasons that hold:
  the change reaches no code any suite covers (a per-client part with no suite of its
  own, a line with no suite); no automated test can reach it and a logged walkthrough
  covers it instead (name the walkthrough). "Trivial", "no time" or "tested by hand" with
  no log are not reasons.
- **The suite gate itself is skipped only where the line has no suite**, and the skip is
  a written line too: `skip: <reason>` in the evidence file.
- **Promote, never duplicate.** Where a commit watcher already drafted a test proposal for
  the change, the plan names it and promotes it (red first, like any test); a rejected
  proposal gets an index row with the reason, so nobody drafts it again.
- **Browser cases are a line of the Test plan**, for a change a user can see: their ids
  (the hand-off to [`browser-verification`](../browser-verification/SKILL.md) runs them),
  or `none - <reason>`. Where no server may run on this machine, the reason names the
  stand-in - in-process screen tests in the suite and the owner's walk
  ([browser-verification](../browser-verification/SKILL.md#when-no-server-may-run-here)).
  A Test plan approved before the line was required (under an older kit version) keeps its
  approved shape: the line goes into the plan's next revision, gated with it, and
  meanwhile the evidence carries the browser hand-off line
  (`browser check: none - <reason>; stand-in: ...; unproven: ...`, or the cases' report).
- **Closing needs the index row** (which change, which tests, which revisions) **or the
  exempt line.** The fix and the tests leave as two commits, the fix first; the closing
  step packages them ([`close-and-retain`](../close-and-retain/SKILL.md)); the close script
  warns when the evidence or the row is missing.

### A new unit - greenfield (no old code)

A product built from a closed prompt ([`frame-greenfield`](../frame-greenfield/SKILL.md))
has no old code to be red on and no code to read the expected values from. The two rules
keep their purpose and change their reading:

- **Red on the stub.** The production reason is that the behaviour does not exist yet. The
  unit is declared first as a stub with the signature the plan names, returning a
  **sentinel** - a value no expected value can equal (a marker of its own; never a zero, a
  false, an empty text or the input echoed back) - so that no test passes on the stub by
  accident; each assertion compares the result with an exact expected value (equality or
  identity), never its truthiness. The test runs against it and fails on its
  **assertion**: tests found = assertion failures. A test whose expectation the stub's
  value meets is a **test-plan defect**, fixed before the gate. Where the declared type
  leaves no value over (a plain boolean), the Test plan names the tests the stub cannot
  make red, and each is proven by the mutation flip of [section 3](#3-evidence-integrity-t76)
  (rule 6). A test that does
  not compile or import because the unit is missing is the step before the red, not the
  red ([section 3](#3-evidence-integrity-t76)): add the stub, run again, keep that log.
  The stub holds no behaviour, so it belongs with the test (in test-first mode it is part
  of the red artifact, shown with the failing test at the gate - [EK#28](../../DECISIONS.md));
  after the go the unit is written completely once - the single pass of
  [`change-gate`](../change-gate/SKILL.md) still holds.
- **A stubbed class, a request handler or a web application**: the stub's result (or the
  response it answers every request with) is the sentinel, and the red is an assertion
  only if each test **compares the whole result - or the response status - before reading
  any attribute**; a test that reads a field of the stub's result first stops on an error,
  which is the step before the red:

  ```python
  # stub: def make_invoice(order): return STUB         (STUB = "<STUB: no behaviour>")
  self.assertEqual(make_invoice(order), Invoice(number="INV-1", total=120))  # red: an assertion
  # not first: self.assertEqual(make_invoice(order).total, 120) - an error on the stub
  # a web application: self.assertEqual(response.status, 201) before the body is read
  ```
- **Expected values from the requirements**, never from the code being written: each one
  cites the acceptance criterion or scenario it comes from (`AC03`, `TC-B02` of
  `prompt_<front>-requirements.md`). A value the requirements do not fix is a question to
  the owner ([`decision-rounds`](../decision-rounds/SKILL.md)), not a guess pinned in a test.
- In the Test plan the two lines read `Fails on the stub because: <the behaviour does not
  exist yet - the stub returns its sentinel>` and `Expected values derived from: <AC, TC ids>`.
- Once the unit exists, its next change is an ordinary one: red on that code, values from
  reading it. Run up to the gate once - a greenfield exit test proved its red on stubs (every
  test found failed on its assertion) and stopped for the go; the green is not run yet.

## 2. The suite gate and the baseline diff (T38)

The suite gate runs **once per line the change touches**. A line the change will be
ported to gets its own suite gate when the port is made, not before.

### Before the run - situations that are not results

| Situation | Written in the evidence | Next |
|---|---|---|
| The line has no suite | `skip: <reason>` | next step |
| The line has a suite at its head, but this working copy does not (stale) | the stop and the update | **stop**: update the working copy and run again. A "missing here" exit is not a result |
| This machine lacks the toolchain or runtime for the suite, or for one part of it | `not run here: <reason>` (or `<part> not run here: <reason>`; the other parts still run) | the change goes on. It is **not a failure and not a pass**: closing reports it, and the run is owed by a machine that has the toolchain (the commit watcher, where one runs; or a person applying a [prepared patch](../change-gate/SKILL.md#a-change-the-agent-cannot-write-or-run---prepared), whose returned logs become the evidence) |
| Another run holds the suite (busy) | the wait and the rerun, one line each | run again later. A "busy" exit is not a result. A build that failed because another run held a file is run once more before anyone goes back to the code |

### The run

- Run the **whole** suite of the line - not only the new test - with the output written to
  a log kept with the evidence.
- **Read the runner's "tests found"**: many runners exit 0 having found zero tests.
  Reconcile **before + added - replaced = found**. Numbers that do not add up fail the
  evidence, whatever the exit code.
- **Split every failure against the line's baseline**: `pre-existing:` (the same qualified
  name is in the baseline's failing list) and `new:` (it is not, or the failure has no
  name).

### Signals

| Signal | Meaning | Next |
|---|---|---|
| The new test is red | the fix is incomplete | implementation |
| "Tests found" did not grow, or is 0 | the new test is not wired into the suite (a registration left out yields zero tests and a clean exit) | implementation |
| The test project does not build | an error in the test | implementation |
| An existing test is red and **new** against the baseline | a regression - or the change alters, on purpose, a behaviour the test pinned (suite tests are characterisation) | **stop: the owner decides.** Regression -> implementation. Intended -> the test changes only with the owner's go recorded (a decision id or a work-log line), and the rule gate of `decision-rounds` is re-read for that behaviour |
| A failure is **pre-existing** | someone else's break, found by this run | recorded **with the revision and the author it is red since**; the change goes on; **whoever meets it fixes it next, in a separate commit**; the evidence names who took it |
| Green, nothing new | - | the next gate (delivery gates, then the result review) |

### The baseline, in short

Per machine and per line, the **last recorded suite result**: working-copy revision,
time, source, status and the **full** list of failing tests by **qualified name**
(module.fixture.test - a bare test name lets an old failure mask a new one with the same
name in another fixture).

- **Recorded only from a clean working copy** (no local changes, a revision that can be
  read) - in practice by the commit watcher. The suite gate's own run **never** records
  it: that run includes the change, and would turn the change's own breakage into
  "pre-existing" at the next run.
- A broken build or a timeout never replaces it (it names no tests).
- Unnamed failures (more failures than names) count as **new**. **No baseline** on the
  machine: every failure counts as new.
- Known limit: a test that was already red and that the change breaks in another way
  reads as pre-existing. The pre-existing list stays visible in the evidence so that
  nobody forgets it.

Record format, compare output, locks and exit codes:
[references/baseline-diff.md](references/baseline-diff.md). The kit's tools for the
baseline record and compare, and the commit watcher, live in
[`runtime/testing/`](../../runtime/testing/README.md); any equivalent that keeps this
contract works.

### Rollout: warn-only first, blocking by a project decision

- **Every door ships warn-only** ([EK#6](../../DECISIONS.md)): the commit hook (the
  plugin's commit hook once `.engine-kit/guards.json` has a `commitDoor` section,
  [EK#14](../../DECISIONS.md)) and the closing check write warnings and never refuse. While warn-only, the commit hook does
  **not** run the suite; it keeps the cheap checks, as warnings: fix and tests mixed in
  one commit, a fix without tests, a test without its index row, a test that reads a fixed
  machine path, someone else's claim on the same change. The suite runs at the suite gate
  and in the commit watcher.
- **A door becomes blocking by a numbered project decision** (`KEY#N` in the project's
  register) that names the door and the date. Once blocking, it refuses only **new**
  failures against the baseline; a broken build or a busy suite also refuses (nothing can
  be said about them); a suite that was already red passes with a strong warning naming
  the failing tests and the revision they are red since.
- **This is not a switch on the change's own loop.** Warn-only or blocking, a change does
  not go to review with a test it broke itself; that is the signal table above, applied
  by the agent, not a door.

Why: in the source case, a commit hook that blocked on any red suite from its first day
stopped every commit of the team while one test was red, and held changes for failures
they had not caused. It was relaxed to "new failures only" the next day, and to
"warn-only during the rollout" the day after.

## 3. Evidence integrity (T76)

Each rule is a correction a real run needed. Detail and the case-table conventions:
[references/evidence-integrity.md](references/evidence-integrity.md).

1. **Read "tests found" and reconcile** before + added - replaced = found. A runner can
   exit 0 with zero tests.
2. **Red is an assertion** failing for the production reason - never a compile error, a
   setup exception, a missing data file or "no tests found".
3. **Keep the red log and the green log**, named in the evidence file.
4. **Expected values come from reading the code** - cite file, revision and lines - and
   are **never pasted from a run**: a value copied from a run pins whatever the code did,
   bug included. A draft may mark a row "to record from the run"; an accepted test may not.
   A new unit takes them from the requirements, cited by id ([section 1](#a-new-unit---greenfield-no-old-code)).
5. **Suspect rows go to a backlog.** A row that pins behaviour that looks wrong is marked
   `SUSPECT` where it is pinned and gets a backlog entry; the desired behaviour lives in a
   candidate test outside the accepted suite, never in it.
6. **A mutation flip is the minimum proof, not the full proof.** When a real red on the
   pre-fix code is not available, flip one expected value per distinct kind of column in a
   copy: every flipped row must fail, with zero errors. A flip proves that the assertion
   executes, not that it discriminates. Flip a pure expectation column, never one that
   also configures the scenario.
7. **"Busy" and "missing here" exit codes are not results** - run again; never read them
   as red or as green.
8. **`skip:` and `not run here:` are written lines** - never a silence, never a pass.
9. **The baseline is recorded only from a clean working copy** (section 2).
10. **Whoever meets a pre-existing failure fixes it next**, in a separate commit.
11. **A test never reads a fixed machine path**: files come relative to the test
    executable or from per-machine configuration, because every machine lays out its
    folders differently.
12. **Characterisation, not proof of everything**: these tests pin what the code does
    today through its real entry points, with in-memory fakes. They do not prove database
    commits, driver transactions or cross-process locking; those stay with acceptance
    tests.

## 4. Coverage completion gate (T77)

Before tests are marked complete, or a promoted proposal is ticked, the **shared coverage
configuration** changes in the same change:

- each production unit the accepted test exercises is in the **shared coverage list** -
  no duplicates, the real unit name, no fakes or mocks, no unlinked candidate;
- each source folder it needs is in the **runner's folder list**;
- the names resolve through those folders and appear in the build map; when coverage
  runs, the touched units appear in its **fresh** report; when it does not run, the
  evidence says `coverage not rerun` and **quotes no new percentage**;
- the hand-over says `Coverage lists: updated` or `Coverage lists: checked, no changes
  needed`, names the units and folders checked and whether coverage ran. A required update
  that is blocked leaves the work **incomplete**, with the blocker named.

**In delegated work the integrating agent owns the shared lists.** Each worker reports
the production units and source folders its test needs; the integrating agent updates the
shared files and verifies them. **A worker's green does not discharge this gate.** A
proposal-only agent (read-only boundary) lists the additions in its report and edits no
shared list. Detail: [references/coverage-completion.md](references/coverage-completion.md).

## 5. The written lines

| Line | Where | Means | Never means |
|---|---|---|---|
| `exempt: <reason>` | the Test plan | no new test for this change, for this reason | the suite is not run |
| `skip: <reason>` | the evidence file | the line has no suite; the suite gate did not run | a pass |
| `not run here: <reason>` | the evidence file | this machine cannot run the suite (or the named part); the run is owed | a failure of the code, or a pass |
| `pre-existing: <names> (red since <rev>, <author>)` | the evidence file | failures the change found, not caused; `taken by: <name>` follows | a reason to hold the change, or to forget the failure |
| `new: <names>` | the evidence file | failures the change caused (or unnamed ones) | - |
| `Coverage lists: updated` / `checked, no changes needed` | the hand-over | the shared lists were handled by the integrating agent | that a worker's green closed them |
| `coverage not rerun` | the evidence file | no fresh coverage report; no percentage quoted | coverage unchanged |
| `SUSPECT: <why>` | above the test row | pinned behaviour that looks wrong; a backlog entry exists | a desired behaviour |

## 6. The evidence file

One file per change and per line, written by the suite gate in the change's folder
(`TESTS/`, in the `change-gate` skill's folder canon), from
[`templates/TEST_EVIDENCE.template.md`](../../templates/TEST_EVIDENCE.template.md): what
was run (line, revision, command, log), the counts reconciled, the red log, the green log,
the baseline diff, the expected-value sources and suspect rows, the coverage line, the
waits and reruns, the written lines and the verdict. A skip or a not-run-here is still an
evidence file - with its one line.

## 7. Dependency-levelled incremental tests (T44 - design, never run)

> **Design - never run in a real case.** It comes from case zero, where the plan, a
> dependency map and a code skeleton were delivered and never executed. Use it as a
> proposal: the first case that runs it records what it measured and moves the label up
> ([maturity](../../docs/MATURITY.md)).

For a data transfer - a sync, a migration, a seed - of many related tables into a target
that enforces references (the direction and the self-healing order of a sync:
[`migration-direction`](../migration-direction/SKILL.md)):

1. **Map the tables in dependency levels**: level 0 references no other transferred table;
   level *n* references only lower levels. A human reviews the map before the first run.
2. **Test table by table, level by level**: count what the source should send, mark the
   start in a test log, run the existing transfer, record expected vs sent vs failed.
3. **Stop at the first error**: record it literally, mark the tables that depend on it
   `blocked`, send nothing else, never resend everything.
4. **A reset needs approval**: after the fix, a named person approves the reset of that one
   table's test rows in the target (who and when are logged); only then is it retried.
5. **Resume from the failed table**, not from the start; close with a report per level.

Run it against a disposable copy of the target whenever possible; a reset in a shared
database waits for the owner's release word
([`decision-rounds`](../decision-rounds/SKILL.md)). Map rules, log shape, the loop and
the exit criteria for a first run:
[references/dependency-levelled-tests.md](references/dependency-levelled-tests.md).

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| "All green" with zero tests found | the runner exited 0 on an empty run | read "tests found"; reconcile the counts |
| Red proved by a compile error | proves the test does not build, not that it catches the bug | red is an assertion for the production reason |
| `exempt` used to skip the suite | a regression elsewhere surfaces at commit time or later | exempt waives the new test; the suite runs |
| A change held for a failure it did not cause | one broken test stops the whole team | baseline diff; whoever meets it fixes it next |
| Baseline recorded from the gate's own run, or a dirty copy | the change's breakage becomes "pre-existing" | record only from a clean working copy |
| "Busy" or "not run here" read as red, or as green | blames the code for the machine, or passes unchecked | not results: rerun, or write the line |
| Expected values pasted from a run | pins the bug | derive them from the code; cite the lines |
| A percentage quoted after coverage did not run | an invented number | `coverage not rerun` |
| Each worker trusting its own green for the coverage lists | the shared lists stay stale | the integrating agent owns them |
| A blocking commit hook on day one | it had to be relaxed within days | warn-only; blocking by a project decision |

## Checklist before the hand-off to the next gate

- [ ] The plan artifact has a Test plan, or an `exempt: <reason>` line a reviewer can check.
- [ ] The test ran red first, as an assertion for the production reason; the red log is kept. A new unit: red on a sentinel stub, tests found = assertion failures.
- [ ] The suite gate ran on every line the change touches (or `skip:` / `not run here:` is written).
- [ ] "Tests found" read; before + added - replaced = found holds.
- [ ] Failures split against the baseline; every new failure sent back or decided by the owner; every pre-existing one recorded with revision and author, and taken by someone.
- [ ] Expected values derived from the code (a new unit: from the requirements' AC and TC ids); suspect rows in the backlog; no "record from the run" marker in accepted tests.
- [ ] Coverage lists handled by the integrating agent; the `Coverage lists:` line written; no unmeasured percentage.
- [ ] The evidence file is complete; busy waits and reruns are lines in it.
- [ ] The index row (or the exempt line) is ready; fix and tests prepared as two commits, the fix first.
