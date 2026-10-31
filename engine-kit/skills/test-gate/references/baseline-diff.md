# Baseline-diff gate - record, compare, doors and rollout

**Scope**: method

Companion of [the test-gate skill](../SKILL.md), section *The suite gate and the baseline
diff* (T38, `operating`). Every name is neutral: a line `L`, revisions `r100`, tests
`Mod.Fixture.test`, authors `P` and `Q`.

## 1. What the baseline is

One record **per machine and per line**: the last suite result this machine recorded for
that line.

| Field | Content | Why |
|---|---|---|
| line | the line (branch) the working copy belongs to | baselines of two lines never mix |
| revision | the working-copy revision the run used | "red since" needs a revision |
| time | when the run ended | staleness is visible |
| source | which process recorded it (normally the commit watcher) | a reader can judge it |
| status | OK, FAILED | - |
| failing | **every** failing test, by **qualified name** (`Mod.Fixture.test`), every part of the suite (for example the back-end runner and the front-end runner) | a capped list (the first ten) hides the eleventh failure; a bare name lets an old failure mask a new one with the same method name in another fixture |
| red since | the revision and author where each failure first appeared, when the watcher knows it | the evidence line `pre-existing: <name> (red since r97, P)` |

Keep it in its own file per line, outside version control (it belongs to the machine),
written atomically: the last complete snapshot wins. A process that writes it must not
need any lock that a long-running process (the watcher) holds for other reasons.

## 2. Who records it, and when

| Run | Records the baseline? | Why |
|---|---|---|
| Commit watcher, **clean working copy** (no local changes) whose revision it can read | **yes** | the only run that reflects the committed state of the line |
| Commit watcher, working copy with local changes | no | the developer's unfinished breakage would become "pre-existing" |
| The suite gate of a change | **never** | its run includes the change |
| A broken build, a timeout | never | no test names: the record would claim a green it never saw |
| A run in a folder that is not a working copy | never | "no local changes" is also what a non-working-copy reports; check that the revision is readable |

Consequence: on a machine whose working copy is seldom clean, someone else's break counts
as **new** until a clean run records it. That is the safe side - the owner decides (or, at
a blocking door, the door refuses) - never a silent pass.

## 3. Comparing a run with the baseline

1. Collect the run's failing tests by qualified name, every part of the suite.
2. A name in the baseline's failing list -> `pre-existing`. Any other name -> `new`.
3. More failures than names (no machine-readable result file, a crash mid-run) -> the
   unnamed ones are `new`.
4. No baseline for this line on this machine -> everything is `new`, and the output says
   `baseline: none on this machine`.
5. Print the split **before** the summary, so a reader of the log sees it first.

The output lines the suite gate copies into the evidence file:

```text
pre-existing: Mod.Fixture.test (red since r97, P)
new: Other.Fixture.case
summary: L FAILED 1184/1186 exit 1
```

When the watcher does not know where a failure started, the text names the baseline run
instead: `(red in the baseline run at r100, watcher, <time>)`.

**Known limit.** A test already red in the baseline that the change breaks in another
way still reads as pre-existing. The pre-existing names stay in the evidence and in every
warning, so the limit is visible.

### Worked example

Baseline on this machine for `L`: r100, FAILED, failing `Mod.Fixture.test` (red since r97,
author P). The change's suite gate shows two failures:

| Failing | Split | Next |
|---|---|---|
| `Mod.Fixture.test` | pre-existing (red since r97, P) | recorded; the change goes on; the developer who met it, Q, takes the fix next, in a separate commit, and the evidence says `taken by: Q` |
| `Other.Fixture.case` | new | an existing test, new red: **stop**, the owner decides - regression (back to the code) or intended (the test changes with the owner's go recorded) |

## 4. Results and non-results

A wrapper around the runner returns exit codes that **can never be read as a suite
result**: values the runner itself never returns.

| Outcome | Is it a result? | Exit (example only) | What the suite gate writes |
|---|---|---|---|
| Green | yes | the runner's 0 | counts, `summary:` |
| Red | yes | the runner's own non-zero code (keep it: the split lines say what to do) | `pre-existing:` / `new:`, `summary:` |
| Busy: another run holds the line's suite lock | **no** | 75 (the "temporary failure" convention) | the wait; run again later |
| Missing here: the line's head has the suite, this working copy does not | **no** | a code of its own | stop; update the working copy; run again |
| Not run here: no toolchain or runtime on this machine | **no** | a code of its own; nothing built | `not run here: <reason>` |
| Part not run here: one runner's runtime missing | partial | the other parts' result | `<part> not run here: <reason>` plus the other parts' counts |

**One lock per line.** The suite gate, the commit hook and the watcher run the suite of a
line under the same lock, waiting a bounded time before answering "busy". A run started
outside the lock (by hand, from an IDE) can still collide: a collision cannot give a false
green (same sources), but it can give a false red or a build that cannot write its output.
Run once more before sending the change back.

**Stale working copy check.** Ask the version-control server whether the line's head has
the suite folder (a remote listing is enough) before concluding "no suite": a stale copy
that reads as "no suite" passes silently - the one case nobody ever checks.

## 5. A pre-existing failure has an owner

- **Whoever meets it fixes it next**, in a separate commit after the change; the change is
  not held. The evidence names who took it (`taken by: <name>`).
- The author of the breaking revision is not automatically the owner: the person who meets
  it is already in the code and has the evidence in hand. (In the source case the
  alternative - "the author of the breaking revision owns it" - was proposed and not
  chosen.)
- Open in the source case: two people meeting the same failure. Candidate: the claim
  mechanism the commit watcher already uses (first claim wins).

## 6. Doors and rollout

| Door | Warn-only (default, [EK#6](../../../DECISIONS.md)) | Blocking (after a project decision) |
|---|---|---|
| Commit hook | does **not** run the suite; warns on: fix and tests mixed in one commit, a fix without tests, a test without its index row, a test that reads a fixed machine path, someone else's claim | runs the suite; refuses **new** failures, a broken build, a busy suite; no baseline -> every failure counts as new (a red suite is refused, a green one passes); an already-red suite passes with a strong warning naming the tests and the revision they are red since | (the case's own VCS client hook; the plugin hook stays warn-only, EK#14)
| Closing check | warns when the evidence file, the index row or the exempt line is missing, and names the `not run here:` reasons - one warning per evidence file, however often its line is repeated | refuses the same |
| Suite gate of a change | not a door: the change never goes to review with a test it broke itself | the same |

**The decision that turns a door blocking** is a numbered row in the project's register
(`decision-rounds`), for example:

| # | Date | Decision | Why |
|---|---|---|---|
| 14 | 2027-01-10 | **The commit hook of line `L` blocks new failures against the baseline from 2027-01-15.** A broken build and a busy suite block; with no baseline every failure counts as new; an already-red suite passes with a warning | four weeks of warn-only: every warning was acted on; the suite runs in under N minutes on every developer machine |

What to measure before proposing it: how often the warnings were real, how long the suite
takes at commit time, how many machines can run it, and whether contributors who do not
use an agent have another way to see a break (the watcher).

Open in the source case, and therefore open here: what ends the rollout period; whether a
**shared** baseline (one per line, not per machine) is needed once doors block - with
nothing blocking, a per-machine baseline only labels failures.

## 7. Evidence from the source case (described, not imported)

A live test on one line of about 1.2k tests, on a scratch machine profile, with a
deliberately broken expected value in one fixture:

| Run | Baseline before | Result |
|---|---|---|
| hook, suite green | none | passed; baseline recorded |
| hook, one fixture red | OK | refused, naming the one new failure; baseline unchanged |
| hook, the same red | FAILED with that test | passed with the "already red, nothing new" warning |
| suite gate | the same | the `pre-existing:` line printed before the summary |
| hook again, after qualifying the names | FAILED with the qualified name | passed; baseline recorded with the qualified name |

The qualified-name rule was found in that live test: case-table rows share one method
name across fixtures, so bare names would have hidden a new failure behind an old one.
At the time, the hook also recorded the baseline whenever it let a commit through. That
stopped the next day, when the hook stopped running the suite during the rollout (a full
run took about six minutes per commit on that line); what remains is the rule of
section 2 - a baseline comes only from a clean working copy.
