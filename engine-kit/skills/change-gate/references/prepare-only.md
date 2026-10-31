# Prepare-only for the irreversible

**Scope**: method

Companion of [the change-gate skill](../SKILL.md), section *Prepare-only for the
irreversible* - technique T29, `proven` (two cases: a multi-developer team base and a solo
modernization with parallel fronts). The release word and its list belong to
[`decision-rounds`](../../decision-rounds/SKILL.md#the-release-word); the harness twin is
[runtime/guards/HARNESS-PERMISSIONS.md](../../../runtime/guards/HARNESS-PERMISSIONS.md).

## 1. The line

The agent **prepares** everything that cannot be undone from the working copy, or that
reaches another person or system; a **human executes** it.

| Prepared by the agent, executed by a human | Free for the agent |
|---|---|
| commit, push, merge, tag, branch copy on the server, history rewrite | editing the working copy or a disposable worktree after the go |
| deployment to any environment; package, image or document publication | building, running tests, running a local server |
| any script or seed applied to a shared database | queries in a **read-only** session; writes to a disposable copy |
| tracker writes - fields, states, links; comments never | reading work items, history, comments, attachments |
| code-host writes - pull request, review thread, comment | reading pull requests and threads |
| messages to people (mail, chat, meeting invites) | drafting the text in the ticket folder |
| deleting files, branches, records | listing them |
| a version-control operation that discards or rebinds local work (revert, switch, update with merge) | status, diff, log, blame, info |

Adding a new file to version control locally (so nothing is left unversioned) is a
reversible, local step and part of the single pass; sending it anywhere is not.

## 2. How a prepared operation is handed over

One block per operation, in execution order, with everything the human needs and nothing
to guess:

```markdown
## Prepared - waits for the release word

| # | What | Where (working copy / target) | Command or text | After |
|---|---|---|---|---|
| 1 | commit of the fix | application working copy, branch `cr-123` | `git add <the 4 listed paths>` then `git commit -F TICKETS/CR-123/commit-fix.txt` | - |
| 2 | commit of the tests | test suite working copy | `git commit -F TICKETS/CR-123/commit-tests.txt` (paths listed in the file) | 1 |
| 3 | schema script 12 | shared database | `scripts/12_shipped_qty.sql`, after the dry run on a disposable copy (log: TESTS/dryrun-12.txt) | 1 |

Files in each commit: listed in the message files. Nothing else in the working copy is part of it.
```

- The exact list matters: the release word covers **what was listed when it was given**;
  an item added later needs a new word ([decision-rounds](../../decision-rounds/SKILL.md#the-release-word)).
- When the word comes, it is logged in the ticket's `WORKLOG.md` with its date, the owner's
  words and the items it released; the human executes; the agent confirms the result by
  reading (log, status), never by repeating the operation.
- A go at the code gate is **not** a release word. The go opens the working copy; the
  release word lets the result leave it.

## 3. The harness twin

A written rule depends on the agent remembering it late in a long session. The harness can
hold the same line mechanically: the write operations of the table above sit on the
permissions **ask** list, so each one stops at a confirmation prompt whatever the agent
intended - [HARNESS-PERMISSIONS.md](../../../runtime/guards/HARNESS-PERMISSIONS.md) has the
list, the neutral example and the limits (it is not a security boundary; a bypass mode
skips it). Where a harness has no such list, the session says so and the written rule
carries the whole weight.

## 4. Database sessions are read-only

- Every query the agent runs against a shared, staging or production database opens a
  **read-only session** (most engines have a session or transaction setting for it). In
  one case the developer's own database *was* production; nothing else would have been
  safe.
- **Prove it once per session**: a write that the database refuses. Choose one that would
  change nothing even if it ran (an update that matches no row, inside a transaction that
  is rolled back). A session that accepts it is closed and reopened correctly before any
  query.
- Cap the rows of exploratory queries; never select secrets or personal data the change
  does not need.
- The kit's runner does all three (guard, proven session, cap):
  [`runtime/data-probe`](../../../runtime/data-probe/README.md).
- Writes - schema scripts, seeds, data fixes - are rehearsed in a **disposable copy**
  (count, rerun idempotent, an impossible variant fails loudly; the
  [`disposable-proof`](../../disposable-proof/SKILL.md) skill), then prepared for the shared database and applied by a human with the release
  word.

## 5. The agent never types passwords

- A login is always human. In a browser walk the owner signs in; the agent drives the page
  after that.
- The agent never types, pastes, prints or stores a password, a token, a key or a
  certificate passphrase - not in a form, not in a command line, not in a file, not in a
  log. A command that needs one is prepared with a placeholder and run by the human.
- A secret seen by accident (in a config file, a log) is reported by location and kind,
  never by value.

## 6. Tracker writes - when the case sanctions one

Most cases keep the tracker read-only for the agent. A case may sanction a narrow write -
typically the development fields at the close - by its own decision, with the write tool
on the harness ask list. Then every write follows five steps:

1. **Read first.** Get the item with its fields and its current revision number.
2. **Optimistic revision test.** The update carries, as its first operation, a test that
   the revision is still the one read in step 1 (for a tracker that takes JSON Patch:
   `{"op": "test", "path": "/rev", "value": <rev>}`). If someone changed the item in
   between, the write fails instead of overwriting their change.
3. **Show and ask before replacing someone else's text.** A field that already holds text
   the agent did not write is shown to the owner, quoted, and replaced only after an
   explicit yes. Never append to or edit another person's text silently.
4. **Never post comments.** Comments notify people; they are messages, and messages are
   the human's.
5. **Confirm each field landed.** Read the response (or the item again) and report each
   field written - its name and its first words. A field that did not land is reported as
   such, not assumed.

Fields that belong to the workflow (state, dates, assignment) stay with the human unless
the case's decision names them.

## 7. A change the agent cannot write or run - the prepared patch

When the code tree is read-only for the agent, or this machine cannot build or run the
stack, the single pass of step 5 is written as patches and a person applies them. The go
on the plan is given as usual; the plan's Test plan says where the run happens
(`Runs on: a disposable instance, applied by <person> - prepared patch`).

**The person is named by the owner, never assumed.** Who applies the patches and rehearses
them is a fact only the owner has: the round that carries the go (or the next one, when the
go came without it) asks it as a fact request (`R-<NS>n`,
[`decision-rounds`](../../decision-rounds/SKILL.md#the-closing-round-carries-the-first-plan-ek26)),
and the answer becomes a row of the people registry (`_REGISTRY/PEOPLE.md`, confirmed by
the owner - [`kb-setup`](../../kb-setup/SKILL.md#4-people-are-not-roles-t25-operating)).
The hand-over, `APPLY.md`, the evidence and the closing draft name that row. Until it
exists, `<person>` reads `not named yet - R-<NS>n`: nothing is applied, every owed log
waits on the owner first, and the hand-over says the wait is the owner's to end.

```text
TICKETS/ORD-W1/PATCH/
  01-test.patch    the test only - applies cleanly to the baseline revision
  02-fix.patch     the fix only - applies on top of 01
  APPLY.md         the steps below, the baseline revision, what to send back
  .gitattributes   "* -text" - no end-of-line conversion of the patches
```

- **The patches stay byte-exact.** `.gitattributes` with `* -text` keeps version control
  from converting their line endings: a patch over a file with CRLF lines is corrupted by
  a conversion at the base's next commit, and then no longer applies.
- **No credential line inside a patch's context.** An insertion next to a line that holds
  a password, a token or a key carries that line into the patch, and the patch into the
  base. Move the insertion away from it, or cut the context (fewer context lines); check
  the context lines of every hunk before the patch is saved.
- **Read the build's treatment of each touched file before writing the patches**:
  filtering (placeholders the build replaces with literals), generation, packaging, the
  profile or target the production build selects. What the build does to a file can defeat
  the approved test. A doubt is not settled by reading alone: it becomes a probe in
  `APPLY.md`, run before the test patch (step 1b), and the rehearsal builds the artifact
  **the way production builds it** - the person's own build command and install steps, not
  a developer shortcut ([`disposable-proof`](../../disposable-proof/SKILL.md): a build path
  the daily loop never takes can be broken).

`APPLY.md` opens with `Applied by: <the people-registry row>` - or
`Applied by: not named yet - R-<NS>n (a wait the owner ends)` - then, in order:

| # | The person does | Sends back (to `TESTS/`) |
|---|---|---|
| 1 | prepares a disposable instance at the baseline revision ([`disposable-proof`](../../disposable-proof/SKILL.md), Part A - a copy that can be thrown away, never the shared one) | the revision it is at |
| 1b | runs the probes listed here, when there are any - one per doubt about how the build treats a touched file, each with the result that would confirm the doubt | each probe's output; a probe that confirms its doubt stops here - the plan turned out wrong (revised, a new gate) |
| 2 | applies `01-test.patch` alone; runs the named tests | the **red** log - an assertion failing for the production reason |
| 3 | applies `02-fix.patch`; runs the same tests | the **green** log |
| 4 | runs the whole suite; builds and installs the artifact the way production does (the person's own command and steps) | the suite log, the build output and the install's result |
| 4b | runs the plan's logged walkthrough, step by step, when the Test plan names one ([`disposable-proof`](../../disposable-proof/SKILL.md) checks included) | the walkthrough log |
| 4c | keeps the instance for the owner's walk (G4) when the delivery gates name it - or rebuilds it at the same revision with both patches; the owner walks it after the gates ran on the returned logs ([`delivery-gates`](../../delivery-gates/SKILL.md)) | the walk's observations (`P-1`, ...), in the owner's words |
| 5 | discards the instance | one line: discarded |

Each step carries its stop conditions - the observable that ends the run there - including
those recorded after the go (the plan's dated "After the go" lines).

- The agent reads the logs as its own runs ([`test-gate`](../../test-gate/SKILL.md)):
  tests found, the red read as an assertion, the baseline diff. A red that is not the
  expected assertion stops at step 2 - the fix patch is not applied, the change goes back
  to the plan.
- Until the logs come back the evidence file says `not run here: prepared patch - applied by
  <person>`, with the expected values and who owes each log in its sections 2-5
  ([template](../../../templates/TEST_EVIDENCE.template.md)); the hand-offs wait for them.
  With nobody named, the line reads `applied by not named yet - R-<NS>n`: the wait is the
  owner's to end, and the closing draft says so.
- **The closing record is drafted with the patches**: `CLOSE.md` is written when the
  patches are, marked `[DRAFT - pending the returned logs]`, with its commits and release
  list prepared; it becomes ready after the logs and the gates
  ([`close-and-retain`](../../close-and-retain/SKILL.md#drafts-while-a-gate-waits)).
- **The patches are prepared artifacts, never the suite.** The test lives in the ticket
  folder only until a person applies it; in the real tree it joins the project's suite like
  any test. Nothing runs from the ticket folder.
- At the close the same patches become the two prepared commits - fix first, then the
  tests - applied to the real working copy by a person after the release word (section 2).
- A patch that no longer applies (the tree moved) is re-prepared by the agent on the new
  baseline and its logs are owed again; when the fix itself has to change, the plan is
  revised and passes a new gate.
