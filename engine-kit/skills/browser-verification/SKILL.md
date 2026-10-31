---
name: browser-verification
description: Use when a change a user can see must be checked in the running application ("test the fix in the browser", "verify it in the UI", "re-run the web tests") - turns the change's test cases into one engine-agnostic spec, runs it in the built-in browser pane, the user's Chrome or the headless runner, and records PASS, FAIL, BLOCKED or MANUAL with the literal values read back. Login is always a human step.
---

# Skill: Browser verification (one spec, three engines, literal read-back)

**Scope**: method
**Maturity**: operating

**When to use**: a change that a user can see - a screen, a form, a list, a message, a
saved value - is in the working copy or on a test server, its suite is green, and it must
be shown working in the real application before the delivery gates and the review. Also
to re-run the same cases after every correction, and to write the cases of a test plan as
an executable spec.
**Not for**: unit or suite tests and their evidence (the
[`test-gate`](../test-gate/SKILL.md)); reviewing the code
([`result-review`](../result-review/SKILL.md)); the owner's acceptance walk
([`delivery-gates`](../delivery-gates/SKILL.md), gate G4 - although the walk may use these
engines once the owner has logged in); load, security or cross-browser campaigns; any
production site.
**Real origin**: one case - a multi-developer product team (2026-09 to 2026-10) verifying
bug fixes and change requests of a web client built from a shell page, content frames and
a widget library, against a local development server. One spec format was run by an agent
in the desktop app's browser pane, in the user's Chrome through the extension, and by a
headless runner; the verdicts and literal values went into the work item's evidence and
its closing text. The rules below are that case's corrections. One case, core by choice:
`operating` ([maturity](../../docs/MATURITY.md)).
**Parts**: T41 browser verification (this file); the spec format
([references/spec-format.md](references/spec-format.md)); the three engines and how one
spec maps to each ([references/engines.md](references/engines.md)); the report
([templates/BROWSER_REPORT.template.md](templates/BROWSER_REPORT.template.md)); the
headless runner and its example ([runtime/browser/](../../runtime/browser/README.md)).
Register: [docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`test-gate`](../test-gate/SKILL.md) (the Test plan lists the browser
cases; the evidence lives in the same `TESTS/` folder),
[`change-gate`](../change-gate/SKILL.md) (the folder canon, prepare-only, the human
login), [`delivery-gates`](../delivery-gates/SKILL.md) (the next gate),
[`result-review`](../result-review/SKILL.md) (the reviewer reads the report),
[`disposable-proof`](../disposable-proof/SKILL.md) (where a case would change data that
must not change), [`decision-rounds`](../decision-rounds/SKILL.md) (a FAIL that is really
a question about the expected behaviour) and
[`memory-engineering`](../memory-engineering/SKILL.md) (what the run taught about the UI).
**Changelog**: 2026-10-21 - first version (wave 2): T41 and the headless runner, from one
case's web-test skill, its agent and its runner. 2026-10-28 - from a greenfield exit test
whose boundary forbade any server: the Test plan's `Browser cases:` line and the stand-in
when no server may run here.

---

## The principle

A check in the browser is evidence only when it **names the element and the literal value
read back from where the application stored it**. "It looked fine", a screenshot nobody
read, or the value the agent typed into the field proves nothing. Everything below
protects that one sentence: one spec so the check can be repeated, read-back after a
reload so the value is the stored one, four verdicts so a missing server is not reported
as a broken fix, and a human login so no credential ever passes through the agent.

Words used here: the **spec** is the JSON file of cases; an **engine** is what drives the
browser; a **read-back** is the literal string read from the page for an assertion; the
**login-ready selector** is an element that exists only after a successful login.

## Hard rules

1. **One spec, any engine.** The cases are written once
   ([format](references/spec-format.md)) and run unchanged in the built-in pane, in the
   user's Chrome or in the headless runner ([engines](references/engines.md)). The report
   names the engine.
2. **Login is always a human step.** The agent and the runner never type, paste, read or
   store a username or a password, and never read one from a file. The agent opens the
   page, says "please log in", and waits for the login-ready selector. The runner's saved
   session is a live session: kept outside every repository, deleted when the tests are
   done.
3. **Never assert text you typed.** The value typed into a field proves only that typing
   works. Read it back from where it is stored: after a reload, on the record reopened,
   in the list rebuilt from the store, or in the answer of the save request.
4. **Four verdicts, with literal values**: `PASS`, `FAIL`, `BLOCKED`, `MANUAL`
   ([below](#verdicts)). Every `PASS` and every `FAIL` carries the value read back.
5. **A regression control in every spec**: at least one case for the unchanged behaviour
   the change must not break (the screen the defect was compared against, the total that
   must still add up).
6. **Semantic locators first**: role and name, label, placeholder, test id, id, visible
   text - CSS last. The same spec then survives a restyling and reads like the screen.
7. **Cleanup runs even on FAIL.** Every case that saves something has a cleanup; what a
   cleanup could not remove is written in the report.
8. **Development and test hosts only.** Localhost, or a test host registered for the
   case and named explicitly; never production. A base URL comes from the case's
   environment registry, never from this skill.
9. **Prepare and verify only.** Never start or stop the server, never install a package,
   never commit, never write to the tracker. Say what is missing; a person does it.
10. **Never retried into green, never weakened to pass.** An intermittent result is
    investigated (element state, a reload race, the save request, a cached script); an
    assertion is never loosened until the run passes.

## Verdicts

| Verdict | When | It says about the change |
|---|---|---|
| `PASS` | every step ran and every assertion held; the values read back are in the report | the behaviour is there, in this build, on this data |
| `FAIL` | an assertion did not hold, or an action could not be done (its target never appeared) | the change is wrong, incomplete or broke something - a finding |
| `BLOCKED` | a precondition - the screen, the data, the server, the session - never appeared **before the first action** | nothing: fix the environment and run again |
| `MANUAL` | the case cannot be automated (printing, a file, e-mail, touch, a native dialog the path depends on) | a person checks it with the exact steps in the spec |

The run's result: any `FAIL` -> `FAIL`; else any `BLOCKED` -> `BLOCKED`; else `PASS`. The
runner's exit codes follow the same order ([runner](../../runtime/browser/README.md#exit-codes)).

## Where it sits in the change cycle

| Before | This skill | After |
|---|---|---|
| the single pass of the code ([`change-gate`](../change-gate/SKILL.md)); the suite gate green ([`test-gate`](../test-gate/SKILL.md)) | the browser cases of the Test plan, run and reported in `TESTS/` | the delivery gates ([`delivery-gates`](../delivery-gates/SKILL.md)); the review ([`result-review`](../result-review/SKILL.md)) reads the report; the closing text quotes the paste block |

A correction made after a `FAIL` is a new pass of the code: the suite gate runs again,
then the same spec runs again, whole - not only the case that failed.

## When no server may run here

A boundary of the case may forbid opening a server on this machine (no port, no network),
and rule 9 keeps the agent from starting one anyway. The hand-off is then replaced on
purpose, never skipped in silence - and never reported as `BLOCKED` (there is no
environment to fix here) or as `PASS`:

- **The Test plan says it before the go**
  ([`test-gate`](../test-gate/SKILL.md#1-the-test-plan-t37)):
  `Browser cases: none - no server may run on this machine - stand-in: <in-process screen tests>, the owner's walk (G4)`.
  A Test plan that names browser cases this machine then cannot run gets
  `browser cases not run here: <reason>` in the evidence instead - owed, like any part of
  a suite. A Test plan approved without this line (under an older kit) gets it at its next
  revision; meanwhile the evidence carries the hand-off line below
  ([`test-gate`](../test-gate/SKILL.md#1-the-test-plan-t37)).
- **In-process screen tests** carry what an automated case would check: the page produced
  through the application's own test client inside the suite (no port, no browser),
  asserting the literal text the user would read and, after a save request, the stored
  value read back (rule 3, on the markup). They prove the server side of the screen, not
  the browser: scripts, layout and focus stay unproven, and the hand-off line says so.
- **The owner's walk carries what a person must see**
  ([`delivery-gates`](../delivery-gates/SKILL.md), G4): its script names each browser case
  it replaces and runs where a server may run (the owner's machine, a disposable instance).
- No browser report is written; the hand-off line goes into the test evidence and the
  work log - not owed, the Test plan replaced the run before the go:
  `browser check: none - <reason>; stand-in: <test ids>, G4 walk <script>; unproven: <what only a browser shows>`.

## Steps

### 0. Preconditions - stop if one fails

1. **Resolve the folder**: the work item's `TESTS/` (the
   [change-gate folder canon](../change-gate/SKILL.md)); create it without asking.
2. **Resolve the base URL** from the case's environment registry (one row per
   application, line and machine). Missing: ask once, then write the row. Refuse any URL
   that is not localhost or a registered test host.
3. **Is the server up?** One plain request; no answer, or a server error, means stop and
   say which service to start - the agent does not start it.
4. **The build under test**: the revision of the working copy and the list of locally
   modified files; an uncommitted change is said so in the report.
5. **Is that build the one loaded?** After a rebuild, a browser may keep an old script:
   check a marker of the new code before the first case
   ([engines](references/engines.md#signals-that-a-run-is-not-testing-what-it-should)).

### 1. Plan the cases

From the change's acceptance criteria, its Test plan, the bug's reproduction steps or
the change request's scenarios - keeping their numbering (`TC-1`, `TC-2`, ...):

- one case per scenario, plus the **regression control** (rule 5);
- for each case: preconditions, steps, the expected value **and where it is read back**,
  the cleanup;
- mark as `manual` what cannot be automated, with the exact steps for the tester;
- data hygiene: the case's registered test record, user or date only; no bulk
  operation; no production data. A case that would change data that must not change
  runs on a disposable copy ([`disposable-proof`](../disposable-proof/SKILL.md)).

The plan's Test plan carries them on its `Browser cases:` line (their ids, one line each)
and points to the spec; the spec is their executable form, not a second plan.

### 2. Write the spec

`TESTS/BROWSER_SPEC.json`, in the [format](references/spec-format.md). Keep the base URL as
a placeholder. Then validate it - no browser, no Playwright needed:

```
node <kit>/runtime/browser/run.mjs --spec <folder>/TESTS/BROWSER_SPEC.json --dry-run
```

Zero errors before any run. Each warning (no regression control, a case with no
assertion, an assertion on typed text, a case that does not start with a navigation) is
fixed, or kept with its reason written in the report.

### 3. Choose the engine and log in

Pick the engine ([engines](references/engines.md)) and record why. Then the **person**
logs in: in the pane, in their Chrome, or through the runner's `--login`. The agent waits
for the login-ready selector; it never types the credentials, not even when asked to.

### 4. Run every case

In order, for each case:

1. **Navigate** to the screen - the real path when the defect is about that path.
2. **Read the page before acting** (the accessibility tree, a find by role or text) -
   never a coordinate guessed from a screenshot.
3. **Act**, and **re-read after every step that changes the page**: references die on
   re-render.
4. **Read the expected value back** from the place the case names; compare literally.
5. **Collect the console errors and failed requests of this case's window only.**
6. **Give the verdict** (rules [above](#verdicts)).
7. **Run the cleanup**, even after a `FAIL`.

Screenshots are the expensive instrument: one for a `FAIL` or a visual case, saved under
`TESTS/evidence/`, and **looked at before it is described**.

### 5. Re-runs with the runner

Once the spec is stable, the headless runner repeats it after every correction:

```
node <kit>/runtime/browser/run.mjs --spec <folder>/TESTS/BROWSER_SPEC.json --base <url> --out <folder>/TESTS/evidence --report <folder>/TESTS/BROWSER_REPORT_<date>.md
```

Install, login, flags and exit codes: [runtime/browser/README.md](../../runtime/browser/README.md).

### 6. Report

`TESTS/BROWSER_REPORT_<yyyy-mm-dd>.md` from the
[template](templates/BROWSER_REPORT.template.md): the run header (engine, base URL, build
under test, session, test data), one row per case with the literal value read back, the
findings, the manual cases, console and network, deviations, cleanup, and the **paste
block** for the closing text. Show the verdict table in chat; the report stays in the
work item's folder.

### 7. Hand-off

- **A `FAIL` on the changed behaviour** goes back to implementation as a finding, written
  in the work log - not a new analysis of the problem.
- **A `FAIL` outside the change** (another screen, a server rule) is never fixed or worked
  around here. The failing case stays as the reproduction; the finding (screen, steps,
  expected and read-back values, console and network, the screenshot) goes to whoever
  analyses defects - a wrong result without a crash is a divergence hunt
  ([`change-gate`](../change-gate/SKILL.md)); a new defect becomes a new work item,
  prepared for a human to open.
- **A `BLOCKED`** is fixed in the environment and the case runs again; it is never
  reported as a result about the change.
- **What the run taught about the UI** (a selector that works, a menu path, a timing, a
  probe to ignore) goes to the area's knowledge, so the next spec starts from it
  ([`memory-engineering`](../memory-engineering/SKILL.md)).
- **A case worth keeping as a guard** - a regression that could come back - is proposed
  for the project's own end-to-end suite; the work item keeps the spec and the evidence,
  the project's repository keeps the test.

## Recorded lessons (real situations)

- **The value entered is not proof it was parsed, and the value on screen is not proof it
  was stored**: the case's fields were parsed on the client, some of them depending on the
  caret, and saved by an asynchronous request. Hence rule 3, the dry-run warning, and
  `type_into` for keystroke-dependent behaviour.
- **A list on the page after a save lagged the store**: it was built from data loaded
  before the save. Reading back means navigating away and back.
- **Scripts were cached for a week under an unchanged version tag**, so a rebuild could
  miss the browser and the run would test the previous build. Checking a marker of the new
  code became a precondition.
- **The first click after a reload was sometimes not delivered** in the pane. Read after
  every click; never chain blind clicks across a reload.
- **A native confirm dialog could not be answered** from the pane; the workaround is
  written in the report as a deviation
  ([engines](references/engines.md#native-dialogs)).
- **A test suite installed inside a work item's folder** put a dependency folder into the
  knowledge base - one per work item, had it gone on. The runner is installed once per
  machine, outside every repository.
- **A test library's login helper read the password from environment variables** in the
  case's own suite. The kit's runner does not: the person logs in, the runner saves the
  session.
- **Failing requests that were not defects**: the application probes optional services.
  They are listed as known probes, each with its reason - never a blanket silence.

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| Asserting the value the case typed | proves typing, not storage or parsing | reload or reopen, then read back |
| A case that clicks through without an `expect_*` | it can never fail | one assertion per scenario, on the stored value |
| `BLOCKED` reported as `FAIL` (or the reverse) | blames the change for the environment, or hides a broken change | precondition before the first action: `BLOCKED`; anything after: `FAIL` |
| Coordinates from a screenshot | the screenshot is scaled; the layout moves | references from the page tree; a bounding rectangle only as a last resort |
| A fixed wait between every step | slow and still racy | wait for the element, the text, or what the answer changes |
| Re-running a flaky case until green | the defect ships | investigate the race; fix the spec or the code |
| The agent typing the login "just this once" | a credential passes through the agent and its logs | the person logs in; the agent waits |
| The session file next to the spec, in the repository | a live session gets committed | the default location in the home folder, or a path outside every repository |
| A spec of CSS selectors | breaks at the first restyling | role and name, label, test id first |
| No cleanup "because it failed anyway" | leftovers poison the next case and the next person | cleanup runs on every verdict |

## Checklist before the hand-off

- [ ] The base URL came from the environment registry; it is local or a registered test host.
- [ ] The build under test is named (revision + local files) and the loaded build was checked.
- [ ] The spec has a regression control, dry-runs with zero errors, and every warning is fixed or explained.
- [ ] The person logged in; no credential passed through the agent or the runner.
- [ ] Every auto case has a verdict and, for PASS and FAIL, the literal value read back from where it is stored.
- [ ] Console errors and failed requests are per case; ignored probes are named with their reason.
- [ ] Cleanup ran for every case; leftovers are listed.
- [ ] The report is in `TESTS/`, with the paste block; the verdict table is in chat.
- [ ] Each FAIL is handed off (implementation, defect analysis or a new work item); each BLOCKED is fixed and re-run.
- [ ] The runner's session file, if one was saved for this run, is deleted when the tests are done.
