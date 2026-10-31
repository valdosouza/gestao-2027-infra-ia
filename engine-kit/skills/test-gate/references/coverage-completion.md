# Coverage completion gate - the shared lists and who owns them

**Scope**: method

Companion of [the test-gate skill](../SKILL.md), section *Coverage completion gate*
(T77, `operating`).

## 1. The shared lists

A suite that measures coverage usually depends on two files that every test change may
need to touch, and that no single test owns:

| List | Holds | Fails silently when stale |
|---|---|---|
| **Coverage units** | the production units whose coverage is measured | a tested unit is missing from the report, or a fake is reported as covered |
| **Source folders** | the folders the runner (and the coverage tool) search for sources | a unit does not resolve; the build or the report quietly leaves it out |

Some suites keep a third shared file, the project that registers every test (a test
missing from it is the "zero tests found" trap of the evidence-integrity reference).

## 2. The gate, step by step

Before tests are marked complete, or a promoted proposal is ticked, in the **same
change** as the tests:

1. Add each production unit the accepted test exercises to the coverage-units list - once,
   by its real unit name. When a test is extended, check the existing entries first.
2. Never list a fake, a mock, a test helper or a candidate that is not linked into the
   suite as accepted coverage.
3. Add each missing source folder to the runner's folder list.
4. Verify that the names resolve through those folders and appear in the build map (or the
   equivalent list of what was linked).
5. When coverage runs, verify that the touched units appear in its **fresh** report. When it
   does not run, write `coverage not rerun` and quote **no** new percentage - not even the
   old one as if it were current.
6. Record the result in the suite's progress record and in the change's evidence file.
7. The hand-over says one of:

```text
Coverage lists: updated - units: <A, B>; folders: <dir>; coverage rerun (A 81%, B 64%)
Coverage lists: checked, no changes needed - units: <A>; coverage not rerun
```

If a required update is blocked (a folder another group owns, a unit that does not
resolve), the work stays **incomplete** and the hand-over names the blocker.

## 3. Delegated work: the integrating agent owns the lists

| Role | Does | Does not |
|---|---|---|
| **Worker** (one test or fixture each) | reports the production units and source folders its test needs, with its green and red logs | edit the shared lists; declare the coverage gate passed |
| **Integrating agent** (merges the workers' results) | updates the shared lists once, verifies resolution and the build map, runs or declares coverage, writes the `Coverage lists:` line | treat the workers' green as discharge of this gate |
| **Proposal-only agent** (a commit watcher's drafter, read-only boundary) | lists the required additions in its proposal report, for whoever promotes it | edit shared lists; claim the promotion complete |

Why this split: the shared lists are exactly where parallel workers would collide, so
none of them touches them - and because none of them touches them, someone has to. When
each worker trusts its own green, the lists stay stale and the coverage report silently
drops the units that were just tested. **Green tests from every worker do not close this
gate; the integrating agent's verification does.**

## 4. Checklist

- [ ] Every production unit exercised by an accepted test is in the coverage-units list,
      once, by its real name; no fakes or candidates.
- [ ] Every source folder it needs is in the runner's folder list.
- [ ] Names resolve and appear in the build map.
- [ ] Coverage rerun with the touched units in the fresh report - or `coverage not rerun`
      and no percentage quoted.
- [ ] The `Coverage lists:` line is in the hand-over, with the units and folders checked.
- [ ] In delegated work, the integrating agent did steps 1-6; the workers only reported.
