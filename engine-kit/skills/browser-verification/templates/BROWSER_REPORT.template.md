# Template: Browser verification report

**Scope**: method
**Used by**: [browser-verification](../SKILL.md) - step 6 (one report per run).
**Produces**: `<project>/SUBJECT/<NAME>/TICKETS/<ID>/TESTS/BROWSER_REPORT_<yyyy-mm-dd>.md`
next to the spec (`TESTS/BROWSER_SPEC.json`) and the evidence folder (`TESTS/evidence/`).
Copy the skeleton below, fill every `<...>`, delete the hints in parentheses, and set the
copy's own Scope line (`case` for a real work item). With the headless runner, start from
the report it writes with `--report` and complete the build under test, the environment
and the hand-off; the tables already match.

Every `PASS` names the element and the literal value read back; a value the case typed is
never the evidence. `result` follows the runner's exit code: any `FAIL` -> `FAIL`; no
`FAIL` but a `BLOCKED` -> `BLOCKED`; otherwise `PASS` (manual cases are listed, not
judged).

## Skeleton

````markdown
---
work_item: <ID>
run: <YYYY-MM-DD HH:MM>
engine: <built-in pane | user's Chrome (extension) | headless runner (Playwright <version>, <browser>)>
build: "<revision> + <locally modified files | no local changes>"
result: <PASS | FAIL | BLOCKED>
---
# <ID> - Browser verification <YYYY-MM-DD>

**Scope**: <method|case|mixed>

## Run header

| Item | Value |
|---|---|
| Engine | <engine, and why this one> |
| Base URL | `<url>` (from <the environment registry row>; local or a registered test host) |
| Build under test | <revision>; locally modified: `<files>`; uncommitted: <yes / no>; the loaded build checked by <marker, or "not checked"> |
| Session | <logged in by <person> in <engine> at <time> / runner session file outside the repository / none needed> |
| Test data | <the registered test record, user or date; never production data> |
| Spec | `TESTS/BROWSER_SPEC.json` (<n> cases: <a> auto, <m> manual); dry run: <0 errors, w warnings - each explained below> |

## Verdicts

| Case | Kind | Verdict | Read back (literal) | Expected | Evidence |
|---|---|---|---|---|---|
| TC-1 | fix | PASS | `<value>` in <element> after <reload / reopen / save answer> | `<value>` | console clean; network clean |
| TC-2 | fix | FAIL | `<value>` in <element> | `<value>` | `evidence/TC-2.png`; <console / network> |
| TC-3 | regression-control | PASS | `<value>` in <element> | `<value>` | <...> |
| TC-4 | fix | MANUAL | - | - | handed to <person> |

## Findings (FAIL / BLOCKED only)

### TC-2 - FAIL - <one-line defect statement>

- **Step**: <n> `<step>` on `<element>`
- **Observed**: <what the page did; the literal value read back>
- **Expected**: <value, and where the spec reads it>
- **Where it likely lives**: `<file>:<line>` or <the screen and the request>, if known (not a re-analysis)
- **Next**: <back to implementation, recorded in the work log | outside the change: a reproduction for the defect analysis | a new work item, prepared for a human>

(None: write "None" and keep the section.)

## Manual cases

### TC-4 - <title>

- <the exact steps and the expected result handed to the tester; who; the answer when it comes>

## Console and network

- Console errors: <none | per case>
- Failed requests: <none | per case>; ignored as optional probes: <hosts, each with its reason>

## Deviations and spec warnings

- <a workaround used (for example a native dialog replaced on the loaded page), a storage clear, a dry-run warning kept on purpose - each with why; or "none">

## Cleanup

- <what each case created and how it was removed; anything left behind, where, and why>

## Paste block for closing

```
**Test focus** (verified <YYYY-MM-DD>, <engine>, <revision> + <local changes>)
- TC-1 PASS - <what> : read back `<value>`
- TC-2 FAIL - <what> : read back `<value>`, expected `<value>` (see BROWSER_REPORT_<date>.md)
- TC-4 MANUAL - <what>, handed to <person>
```
````

## Filling rules

- **One report per run**, never overwritten: a re-run after a correction is a new file
  (or a new dated section when the case keeps one file per day) and cites the previous one.
- **Literal values only**: copy what was read, character for character, in backticks.
- **A screenshot is described only after it was looked at.**
- **Never invent** a revision, a date, a person or a value: write "not specified".
- **The report stays in the work item's folder**; the chat gets the verdict table and the
  path.
