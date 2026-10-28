# Test-evidence integrity - proofs, counts, expected values, case tables

**Scope**: method

Companion of [the test-gate skill](../SKILL.md), section *Evidence integrity* (T76,
`operating`). Runners, languages and frameworks are examples only (a unit-test runner
with an XML report, a table-driven test attribute, a JavaScript test runner): the rules
hold for any of them.

## 1. What counts as red

| Proof | Strength | Accept? |
|---|---|---|
| The new test run on the **pre-fix** code fails with an assertion, for the production reason the change fixes | strongest | yes |
| A **mutation flip**: a deliberately wrong expected value in a copy of the test, run through a separate red runner; each flipped row fails, zero errors | the floor: it proves the assertion executes, not that it discriminates the bug | yes, when the pre-fix red is not available (an older behaviour pinned for the first time, a promoted draft) - and say which proof it is |
| The test does not compile on the old code | none: proves the test needs the new code, not that it catches the bug | **no** - for a new unit, add its stub and run again ([red on the stub](../SKILL.md#a-new-unit---greenfield-no-old-code)) |
| An exception in setup, a missing data file, a wrong path | none | **no** |
| "No tests found", or a run that exited 0 with zero tests | none | **no** |

A red that is not an assertion is fixed before anything else: the next "green" would be
just as empty.

### The flip, step by step

1. Copy the test and its table (if any) into a scratch folder of the red runner; point the
   copy at its own table, never at the accepted one.
2. In the copy, flip **one expected value per distinct kind of column** (a count, a flag,
   a date, an ordered list of events...).
3. Run: every flipped row fails, every other row passes, **zero errors** (an error means
   the flip broke parsing, not the assertion).
4. Keep the red log; name it in the evidence ("mutation flip of column X, rows a, b").
5. **Flip a pure expectation column.** A column that both configures the scenario and
   states the expectation (an "explanation" column that also primes the engine) cannot
   be probed by flipping itself: the flip changes the scenario too.

## 2. Counts as arithmetic

After every change to the suite, the evidence states:

```text
before + added - replaced = found
1185   + 12    - 3        = 1194   (found 1194: holds)
```

- **before**: "tests found" of the last accepted run on the line;
- **added**: new tests and new table rows;
- **replaced**: tests removed or converted into table rows;
- **found**: what the runner reports now - read from its output or its report, never
  assumed from the exit code.

The classic trap: a table-driven test whose registration is left out (a missing import, a
missing attribute) yields zero rows and the run still exits 0. Only the arithmetic shows it.
A suite with several parts (a back-end runner and a front-end runner) reconciles each part.

## 3. Expected values come from the code

- Read the code path and derive the value; cite it: `derived from: <file> <revision>
  L<from>-<to>`. A reviewer can then re-derive it.
- **Never paste a value from a run** into an accepted test: it pins whatever the code did
  that day, bug included, and the test then "proves" the bug.
- A **draft** (a watcher proposal, work in progress) may mark a row `TODO record from the
  run` where the value is not yet derivable. An accepted test may not: promotion resolves
  every marker by reading the code, or drops the row.
- **A new unit** (greenfield) has no code to read yet: its values come from the
  requirements' acceptance criteria and scenarios, cited by id (`derived from: AC03,
  TC-B02`) - never from the code being written.

## 4. Suspect rows and candidate tests

- A row that pins behaviour that **looks wrong** stays (it is what the code does) and
  carries a `SUSPECT: <why>` marker on the line above it, plus an entry in the suite's
  backlog. Pinned and listed - never silently "fixed" in the test.
- The **desired** behaviour lives in a candidate test, outside the accepted suite (a
  separate runner, or a block compiled only on request). It never enters the accepted
  suite until the code changes and the owner decides.

## 5. Logs

- Red and green logs (and the machine-readable report when the runner writes one) are
  kept under the suite's output folder, out of version control, and **named** in the
  evidence file and in the suite's progress record.
- A runner that overwrites its report on the next run: copy or rename the report before
  the next run, or write the log to a named file per run.
- A log that is the only proof left - a red on stubs, the logs a person returns for a
  prepared patch, a run on a machine nobody else has - travels with the evidence, in the
  work item's `TESTS/`, as `.txt` or pasted into the evidence file. Never `.log` there: a
  common global exclude (`*.log`) keeps it out of version control silently, and the close
  script, which reads version control, never sees it.

## 6. Case tables (table-driven tests)

When three or more cases share one method shape, a case table keeps them readable.
Conventions that make a table reviewable without opening the test code:

- **One table per test fixture**, next to it, named after the unit under test.
- **Header block** as comment lines: the entry point under test; the columns in parameter
  order; one line per column (meaning, unit, encoding); the defaults; `derived from:
  <file> <revision> L<from>-<to>`.
- **Encoding**: booleans `1`/`0`; dates `yyyy-mm-dd`; times `h:nn`; an ordered list as one
  quoted field separated by `;`; an empty cell is the fixture's default, stated in the
  header; a `mode` column for setup no value can express (a raised exception, an outer
  transaction): the table says what, the code says how.
- **Row names are sentences stating the pinned fact**, unique in the file (check for
  duplicates before building); the row name is the first parameter and appears in every
  assertion message, so a failing row is identifiable in the log.
- **Two shapes recur**: value tables (inputs -> outputs) and scenario tables (mode and
  flags -> an ordered list of events and a result).
- Converting existing tests into a table: the reconciliation of section 2 must hold
  (old cases - replaced + rows = found), then the flip of section 1, then the whole suite.

## 7. Other integrity rules

- **No fixed machine path in a test.** Files are found relative to the test executable or
  through per-machine configuration; every developer keeps the folders somewhere else. A
  commit hook can warn on an absolute drive path in a test file or table, and a watcher
  can refuse to publish a draft that has one.
- **A fake value must differ from the real one.** A probe that replaces a function with a
  fake proves nothing when both return the same value: make the probe a before/after
  comparison with a value the real function cannot return.
- **Assert sets where the order is not specified.** An order that is an artefact of how a
  list inserts equal keys is not behaviour; pinning it makes the test fail on a harmless
  change.
- **Characterisation scope.** Tests with in-memory fakes pin what the code does today
  through its real entry points. They do not prove database commits, driver transactions
  or cross-process locking; those stay with acceptance tests, and the evidence does not
  claim them.
- **Never edit the product to make a test pass or to make code reachable for the suite.**
  A correction the test reveals is a change of its own, red on the old code, green on the
  corrected one.
