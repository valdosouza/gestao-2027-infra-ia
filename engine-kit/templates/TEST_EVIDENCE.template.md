---
project: <KEY>
work_item: <id>
line: <the line (branch) this run covers>
date: <YYYY-MM-DD>
verdict: <green | back-to-implementation | stopped-for-owner | not-run-here | skip>
tags:
  - test-evidence
---
# Test evidence - <work item> on <line> (<YYYY-MM-DD>)

**Scope**: <method|case|mixed>
**Test plan**: <link to the plan, spec or red test that holds it> - or the `exempt:` line, verbatim
**Ran by**: <name as the project writes it> on <machine label>

> Template from the engine-kit (`templates/TEST_EVIDENCE.template.md`) - techniques T37,
> T38, T76 and T77, *operating*. One file per change and per line, written by the suite
> gate in the change's folder (for example `TESTS/SUITE_<line>_<date>.md`). A skip or a
> not-run-here is still this file, with its one line in section 1. Replace every
> `<placeholder>`, delete the sections that do not apply, and delete this note. Method:
> the `test-gate` skill.

## 1. What was run

| Item | Value |
|---|---|
| Line and working-copy revision | <line> @ <revision> |
| Suite location and revision (when the suite lives apart from the code) | <path> @ <revision> |
| Test files of this change | <files, or table rows added> |
| Command (literal) | `<the exact command, with its filters>` |
| Log | `TESTS/logs/<run>.txt` - or pasted into this file |
| Started, duration | <time>, <minutes> |

Logs are kept as `.txt` (or inside this file), never `.log`: a common global exclude
(`*.log`) keeps them out of version control silently, and the close script reads version
control - an ignored log is neither reported as unversioned nor seen.

Or, instead of a run, exactly one written line - here, once (section 9 names it without
repeating it):

```text
skip: <reason - the line has no suite>
not run here: <reason - the toolchain or runtime this machine lacks; the run is owed>
```

A part of the suite that could not run, while the rest did:
`<part> not run here: <reason>`.

A prepared patch (the `change-gate` skill; the line
`not run here: <prepared patch - applied by <person>>`): sections 2-5 are still filled -
with the **expected** values: the counts (before + added - replaced), the red (each test
and the assertion message expected), the green and the baseline rule; every log cell reads
`owed by <person>`. The returned logs fill the found values and the log paths beside them;
the expected ones stay. `<person>` is the people-registry row the owner confirmed for
applying and rehearsing this change; while nobody is named it reads
`applied by not named yet - R-<NS>n`, and every `owed by` cell waits on the owner first: a
wait the owner ends, not a person's delay.

## 2. Counts reconciled

| Part | Before | Added | Replaced | Expected found | Found | Passed | Failed | Errors |
|---|---|---|---|---|---|---|---|---|
| <part> | <n> | <n> | <n> | <before + added - replaced> | <n, read from the runner> | <n> | <n> | <n> |

- Arithmetic: <holds | does not hold: why, and what was done>
- Summary line (literal): `<summary: ...>`
- "Tests found" was read from the runner's output, not assumed from its exit code: <yes>

## 3. Red log

| Test | How red was proved | Assertion message (literal) | Log |
|---|---|---|---|
| <test or row> | <real red on the pre-fix code @ revision> \| <mutation flip of column X, rows a, b - the floor, not the full proof> | `<message>` | `<path>` |
| <test> (prepared patch) | expected: the test patch alone @ <baseline revision> | expected: `<message>` | owed by <person> |

- Red is an assertion for the production reason - not a compile error, a setup
  exception, a missing file or zero tests found: <yes>

## 4. Green log

| Run | Found | Passed | Failed | Log |
|---|---|---|---|---|
| <the new tests> | <n> | <n> | <n> | `<path>` |
| <the whole suite> | <n> | <n> | <n> | `<path>` |
| <the whole suite> (prepared patch) | expected: <before + added - replaced> | expected: <n> | expected: <n> | owed by <person> |

## 5. Baseline diff

**Baseline**: <revision, time, source of the record> | `baseline: none on this machine`
(every failure counts as new)

| Failing test (qualified name) | Split | Red since (revision, author) | Verdict | Taken by |
|---|---|---|---|---|
| <Mod.Fixture.test> | pre-existing | <revision>, <author> | recorded; the change goes on | <name> - fix next, in a separate commit |
| <Mod.Fixture.test> | new | - | <regression: back to implementation> \| <intended: owner's go <KEY>#<n> or work-log line> | - |

Pre-existing and new lines, as printed (literal):

```text
pre-existing: <names> (red since <revision>, <author>)
new: <names>
```

## 6. Expected values and suspect rows

- Expected values derived from: <file, revision, lines> | <AC, TC ids of the requirements> (a new unit) (never pasted from a run)
- `SUSPECT` rows: <row> - backlog entry <link> | none
- No "record from the run" marker left in an accepted test: <yes>

## 7. Coverage lists

- `Coverage lists: updated` | `Coverage lists: checked, no changes needed`
- Units checked: <units> - folders checked: <folders>
- `coverage rerun` (touched units in the fresh report: <units and figures>) | `coverage not rerun` (no percentage quoted)
- In delegated work, the shared lists were handled by: <the integrating agent>
- Blocked: <the blocker, and the work left incomplete> | no

## 8. Waits and reruns

| Time | Outcome | A result? | Action |
|---|---|---|---|
| <time> | busy (another run held the suite) | no | ran again at <time> |
| <time> | missing here (stale working copy) | no | updated to <revision>, ran again |

## 9. Verdict

- <green: to review> | <back to implementation: <signal>> | <stopped for the owner: <test>> | <not run here - the line of section 1, owed by <person>> | <skip - the line of section 1>
- Browser check: <the cases' report> | `browser check: none - <reason>; stand-in: <test ids>, G4 walk <script>; unproven: <what only a browser shows>` (no server may run here, or a Test plan approved without its `Browser cases:` line - until its next revision) | none - no screen a user sees changes
- Index row for the change: <added: <row>> | <exempt line in the Test plan>
- Commits prepared: the fix first (<files>), then the tests (<files>)
