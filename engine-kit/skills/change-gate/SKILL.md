---
name: change-gate
description: Use when code is about to be written for a bug, change request, task or greenfield wave ("plan and implement CR-123", "spec first", "TDD this fix", "why is this result wrong") - intake, pipeline gate, then a plan, a spec or a red test, a literal STOP, the owner's go logged, one pass per file, prepare-only.
---

# Skill: Change gate (a plan, a spec or a red test before any code)

**Scope**: method
**Maturity**: operating

**When to use**: from the moment someone says "let's work on CR-123" (a bug, a change
request, a task) until the implementation is handed to the test gate - and for each wave
of a greenfield front that has no tracker
([A greenfield wave](#a-greenfield-wave-no-tracker-no-flow-to-map-no-area-yet)). Also
mid-task, when a result is wrong without a crash (divergence-point debugging) or a change
crosses tiers (contract first).
**Not for**: preparing a change request for its review meeting
([`review-pack`](../review-pack/SKILL.md)); running the suite and judging its result (the
[`test-gate`](../test-gate/SKILL.md) skill); reviewing the result
([`result-review`](../result-review/SKILL.md)); the close
([`close-and-retain`](../close-and-retain/SKILL.md)). A piece of work big enough to need
waves, a living prompt and session resume is a front
([`front-protocol`](../front-protocol/SKILL.md)); each
change inside it still passes this gate.
**Real origin**: one case - a multi-developer product team's knowledge base where three
orchestrator agents (blueprint, spec-driven, test-driven) shared one change sequence,
2026-09 to 2026-10. This skill replaces the three with one skill and three modes.
Prepare-only, the read-only database session and the human login also ran in a second case
(a solo modernization with parallel fronts). [Maturity](../../docs/MATURITY.md) per part:

| Part | Technique ([register](../../docs/TECHNIQUES.md)) | Maturity |
|---|---|---|
| [Shared intake](#step-0---shared-intake-t36-candidate) | T36 | `candidate` - optional; a case without a tracker skips it |
| [Pipeline gate](#step-2---pipeline-gate-t27) | T27 | `operating` |
| [Code gate + single pass, three modes](#choosing-the-mode) | T28 | `operating` |
| [Anti-patch](#anti-patch-t34) | T34 | `operating` |
| [Divergence-point debugging](#divergence-point-debugging-t81) | T81 | `operating` |
| [Path integrity + contract first](#path-integrity-and-contract-first-t82) | T82 | `operating` |
| [Prepare-only for the irreversible](#prepare-only-for-the-irreversible-t29-proven) | T29 | `proven` (two cases) |

**Hands off to**: the [`build-analyst`](../../agents/build-analyst.md) where the stack
compiles, then the [`test-gate`](../test-gate/SKILL.md), then
[`browser-verification`](../browser-verification/SKILL.md) for a change a user can see,
then [`delivery-gates`](../delivery-gates/SKILL.md), then
[`result-review`](../result-review/SKILL.md), then the close ([Hand-offs](#hand-offs)). The release word and the
decision ids belong to [`decision-rounds`](../decision-rounds/SKILL.md); this skill uses
them and never redefines them.
**Detail**: [references/modes.md](references/modes.md) (the three modes, spec states,
compliance table); [references/intake-and-pipeline-gate.md](references/intake-and-pipeline-gate.md)
(T36, T27); [references/debugging-and-contracts.md](references/debugging-and-contracts.md)
(T81, T82, T34); [references/prepare-only.md](references/prepare-only.md) (T29, tracker writes).
**Templates**: [`PLAN`](../../templates/PLAN.template.md),
[`SPEC`](../../templates/SPEC.template.md), [`WORKLOG`](../../templates/WORKLOG.template.md).

---

## The principle

A fix designed before anyone understood the process cascades; code written before the
owner saw what it would be is rework, or worse, a silent decision. So:

> **No code before the owner approves what the code will be.** The approved thing is a
> plan, a spec or a failing test - the mode. It is presented, the agent prints one literal
> sentence and stops, the owner's go is written down with its date and words, and then
> every file is written once. What would leave the working copy is prepared, and a human
> executes it.

Example used throughout (fictional): **CR-123, "Acme Orders: allow a partial shipment of an
order"**, area `SHIPPING`, decisions in the project namespace `ORD`.

## Vocabulary

| Term | Meaning |
|---|---|
| Change | the work item - a bug, a change request or a task; one ticket folder. With no tracker, on either track, a wave or step of the front (`ORD-W1`, `ORD-W1.2`) ([greenfield](#a-greenfield-wave-no-tracker-no-flow-to-map-no-area-yet)) |
| Owner | the human who approves the gate: the developer who owns the change, or the business owner for a spec. A role comes from the case's people register, never from a tracker field ([kb-setup, section 4](../kb-setup/SKILL.md#4-people-are-not-roles-t25-operating)) |
| Dossier | the intake's output, `DOSSIER.md` in the ticket folder |
| Plan artifact | what the gate approves: `PLAN.md`, `SPEC.md`, or the red test (with a new unit's stub) and `TESTS/TEST_PLAN.md`; a plan with test-first steps carries their reds (EK#30) |
| Gate sentence | the literal sentence printed right before the STOP |
| Go | the owner's approval of one plan artifact in one state; it opens the code working copy, nothing more |
| Release word | the owner's word that lets a result leave the working copy ([decision-rounds](../decision-rounds/SKILL.md#the-release-word)). **A go is never a release** |
| Tracker | the work-item system; read-only for the agent ([prepare-only](#prepare-only-for-the-irreversible-t29-proven)) |
| Ticket folder | `<project>/SUBJECT/<AREA>/TICKETS/<ID>/` ([kb-setup, section 2](../kb-setup/SKILL.md#2-the-domain-area-model-t02-proven)) |

## Choosing the mode

| Mode | Use when | The plan artifact | Gate sentence (literal) |
|---|---|---|---|
| **plan** (default) | a bug with a fix proposal, a task, a change request that is not a specification | `PLAN.md`: blueprint in three phases (contract and back end -> logic -> front end), impacted files, risks, Test plan | *"I have generated the architectural plan and sharded the blueprint above. Please review and approve before I execute the single-pass code implementation."* |
| **spec** | a change request whose value is in its requirements; several people must agree on behaviour | `SPEC.md` in state `draft`: numbered requirements, data contracts, UI behaviour, edge cases, Test plan, out of scope | *"I have generated and archived the technical specification (SPEC.md) in the ticket folder above. Please review and approve the spec before I write any implementation code."* |
| **test-first** | a regression or a logic fix with a clear expected result | a failing test, proven red for the expected reason (a new unit: with its stub, EK#28), and `TESTS/TEST_PLAN.md` | *"I have designed and verified the failing test (Red Phase) above. Please review and approve before I write the production implementation code."* |

- The mode is named in the plan artifact. When unsure, **plan**. The owner may ask for
  another mode; changing mode after a go is a new artifact and a new gate.
- The sentences are literal so that a search finds every gate in every log. A case may
  translate them once, in its `AGENTS.md`, and then keeps them fixed.
- Mode by mode, with a worked CR-123 excerpt each: [references/modes.md](references/modes.md).

## The sequence

| Step | What | Output | Stops when |
|---|---|---|---|
| 0 | [Shared intake](#step-0---shared-intake-t36-candidate) (T36) | `DOSSIER.md`, attachments with text extractions (none with no tracker) | - |
| 1 | [Recall and baseline](#step-1---recall-and-baseline) | context: cards by id, past logs, the state of each working copy | - |
| 1b | [Rule check](#step-1b---rule-check-projects-with-rule-files) (projects with rule files) | the rule rows quoted in the plan artifact | a Denied row would come back |
| 2 | [Pipeline gate](#step-2---pipeline-gate-t27) (T27) | a link to the process map (greenfield: the stand-in, stated) | the process is unmapped: map it first |
| 3 | [The plan artifact](#step-3---the-plan-artifact-t28) of the mode (T28) | `PLAN.md` / `SPEC.md` / red test | it is [not ready for the gate](#not-ready-for-the-gate) |
| 4 | [STOP and the go](#step-4---stop-and-the-go-t28) (T28) | the go in `WORKLOG.md` | always: it waits for the owner |
| 5 | [Single pass](#step-5---single-pass-t28) (T28) | code and tests in the working copy - or [prepared patches](#a-change-the-agent-cannot-write-or-run---prepared) when the agent cannot write or run it | the plan turns out wrong: back to 3 |
| 6 | [Hand-offs](#hand-offs) | test gate, delivery gates, result review, close | - |

### Step 0 - Shared intake (T36, candidate)

One intake serves every mode and every later step; nobody fetches the tracker twice.
Detail and the dossier skeleton: [references/intake-and-pipeline-gate.md](references/intake-and-pipeline-gate.md).

- **Reuse this week's dossier and state the source.** A dossier whose `last_updated` falls
  in the current calendar week is reused without calling the tracker; the first line of
  the summary says which: `Source: local dossier (current week, last_updated 2026-10-19)`
  or `Source: live tracker`. No `last_updated` = stale. The owner can force a refresh.
- **Filter the noise.** Access requests, permission chatter, state, assignee, sprint and
  priority moves and bare mentions stay out. Repro steps, environments, developer notes
  on the cause and impact stay in.
- **QA revert feedback first.** When the item came back from testing, the latest revert
  cycle (build tested, what was tried, expected vs actual, regressions, open questions)
  leads the dossier and its "ready to start" section.
- **Related items only when they carry developer notes** - a worked item whose
  resolution notes are filled; keyword-only matches are not listed. At most three.
- **Attachments mined to text.** Every document attachment gets a `.txt` extraction next
  to it; the relevant part is quoted in the dossier. A requirement form in an attachment
  *is* the requirement.
- The dossier also carries the recall (step 1) and the pipeline status (step 2), so the
  later steps consume it instead of searching again.

### Step 1 - Recall and baseline

- **Recall before plan** - the before-action loop of
  [`memory-engineering`](../memory-engineering/SKILL.md): query the memory for the work
  item and each entity, read the area `INDEX.md`, quote cards by id. Nothing found is
  written as "no prior knowledge" with the folders checked.
- A card that already states the rule is **quoted by id** in the plan artifact; a plan
  that contradicts a card says why (the close supersedes the card with evidence, never
  silently).
- **A dirty working copy is a stated risk.** Record the status of every working copy the
  change touches and its revision in the plan artifact's front matter; list each local
  modification in the Baseline section. Never build silently on changes nobody listed.
- Tests that already exist for the item (a test index row, a draft from an automated
  proposer) are reused or promoted, never rewritten - the `test-gate` skill owns how.

### Step 1b - Rule check (projects with rule files)

Where the project adopted rule files ([decision-rounds, T24](../decision-rounds/SKILL.md#business-rules-and-the-rule-gate-t24--candidate-optional)):
read the rules for the behaviour the change touches. A plan, spec or test that brings back
a **Denied** row with no newer **Authorised** row stops here and quotes the row; an open
question on a rule is not implemented on its open point.

### Step 2 - Pipeline gate (T27)

**No fix design on a process nobody has mapped.** The process the change touches must be
documented in the area's `PIPELINES/`. If it is not, the plan waits and the mapping comes
first (graph and source) - the principle is section 4 of
[`memory-engineering`](../memory-engineering/SKILL.md).

- Analysis may continue on an unmapped process; **design and code may not**. The dossier
  says so in capitals: `PIPELINE UNMAPPED - map before fix`.
- Check the code graph's freshness against the code before trusting what it says.
- When an earlier step already wrote or extended the map (a bug analysis that ends with a
  fix proposal), the plan links it and does not remap.
- **Prose is not a map.** An analysis that describes the touched flow in prose (an
  assessment, a dossier) does not replace its step-by-step map: a legacy pilot's first
  change found an effect of its flow, missed by the prose reading, only when mapping it.
- Every process the change touches is linked, or listed as mapped in this change; none is
  silently skipped.
- A new product has no existing flow to map: the closed prompt's design and its
  requirements stand in, and the plan says so
  ([A greenfield wave](#a-greenfield-wave-no-tracker-no-flow-to-map-no-area-yet)).

### Step 3 - The plan artifact (T28)

Every mode's artifact carries, besides its own body ([modes](references/modes.md)):

1. the dossier's source line and the pipeline link;
2. recall: cards by id, the logs that matter;
3. the baseline of every working copy (clean, or each local modification as a risk);
4. the rule rows it relies on (step 1b), when the project has rule files;
5. the impacted files and the callers that could regress (from the graph, then read);
6. the contract of every tier boundary it crosses ([T82](#path-integrity-and-contract-first-t82));
7. for a wrong result without a crash, the four points of [T81](#divergence-point-debugging-t81);
8. risks, High / Medium / Low;
9. the **anti-patch line**: "this plan silences nothing" or the finding it records ([T34](#anti-patch-t34));
10. the **Test plan**: what test pins the change, what fails on the old code and why (a new
    unit: on its stub), where it runs, and for a change a user can see its browser cases
    (`Browser cases: <ids> | none - <reason>`) - or one line `exempt: <reason>`. Its rules
    are the `test-gate` skill's;
11. out of scope; open questions and assumptions by id ([decision-rounds](../decision-rounds/SKILL.md));
    the premises, when it was written before its questions were answered (below).

**A plan written before its questions are answered** ([EK#26](../../DECISIONS.md)) - the
first plan of a front, carried by the round that closes its prompt (greenfield) or settles
the pilot's first change (legacy)
([decision-rounds](../decision-rounds/SKILL.md#the-closing-round-carries-the-first-plan-ek26)) -
is allowed when its header lists every open question it rests on with the recommended
answer it assumes, `Premises: Q-ORD7: Rec (a); Q-ORD9: Rec (b)`, and says it is rewritten
if any answer differs. The plan decides none of them; the STOP and the go of step 4 still
apply, and the go is recorded with the round's answer. A plan that also rests on a fact
still to be read or confirmed - an owner's claim about what the system does, a
confirmation the gate asked for - lists it the same way as a **fact premise**
(`Fact premises: R-ORD8; H-012`), rewritten if the read contradicts it; on the legacy
track, the open hypotheses it accepts as risks are named in its Risks section.

#### Not ready for the gate

The agent does not print the gate sentence while any of these holds:

| Condition | Then |
|---|---|
| No Test plan section (not even an `exempt:` line) | write it - **a plan without a Test plan is not ready for the gate** |
| A process the change touches is unmapped | step 2 |
| A working copy is dirty and the plan does not say so | list the modifications as risks |
| The artifact cites a file, symbol or endpoint the agent has not read | read it, or remove the citation ([T82](#path-integrity-and-contract-first-t82)) |
| The plan adds a guard, a catch or a switch that makes a symptom disappear | redesign at the cause ([T34](#anti-patch-t34)) |
| A domain object is created or altered without a verdict | [`conceptual-guardian`](../conceptual-guardian/SKILL.md) first |
| A business or architecture choice is made inside the plan | a numbered question to the owner ([decision-rounds](../decision-rounds/SKILL.md)) |
| The plan rests on an open question, or a fact still to be read, that it does not list as a premise | list it (the recommended answer assumed, or the fact as the plan reads it), or wait for the answer |
| A cross-tier change without its contract | write the contract first |

### Step 4 - STOP and the go (T28)

1. Present the artifact, the impacted files, the risks and the Test plan; print the mode's
   gate sentence **literally**; stop. No file in the code working copy is touched before
   the go (the plan artifact itself lives in the ticket folder, not in the code) - with one
   exception, test-first mode, whose artifact is code: the failing test and, for a new
   unit, its **stub** ([EK#28](../../DECISIONS.md)). The stub declares the signature the
   artifact names and returns a sentinel no expected value can equal
   ([test-gate](../test-gate/SKILL.md#a-new-unit---greenfield-no-old-code)); it carries no behaviour, is shown
   at the gate with the failing test, and is the only production file touched before the
   go. The unit itself is written once, after it (step 5). A plan may carry
   **test-first steps** ([EK#30](../../DECISIONS.md), one go per wave): each step's red -
   its failing tests and stubs, proven - is written before the gate under the same
   exception and listed in the plan's Test plan, and the plan and those reds are one
   artifact at the gate ([modes](references/modes.md#4-changing-mode-and-the-gate-after-a-revision)).
2. **What counts as a go**: an explicit approval, by the owner, of this artifact in this
   state. Silence, a go given before the artifact existed, an approval of an earlier
   version, one "ok" covering several open items, or an answer to the questions of the
   round that carried the plan is not a go - ask again. A plan and the test-first reds it
   lists are one item (EK#30): one go covers them; a go given to each of them is logged as
   that one go. The go needs no line of its own: a sentence of its own that names the
   artifact by id; it may share a message or a paragraph with answers and with gos for
   other artifacts - each covers only what it names.
3. **Log the go** in the ticket folder's `WORKLOG.md`
   ([template](../../templates/WORKLOG.template.md)), creating the file when it is missing,
   in every flow: the **date**, the owner's **words quoted literally** (translated after
   the quote when another language), the channel, and what was approved (artifact and
   state). In spec mode the spec's status becomes `approved`, with the date.
4. **A plan carried by a decision round** ([EK#26](../../DECISIONS.md)): its go is asked on
   a line of its own in the round's batch and logged with the round's answer - one WORKLOG
   row that cites the round, quotes the owner's answer once and lists the premises as
   decided. An answer that differs from a premise voids the plan, a go in the same message
   included: it is rewritten on the decision and passes a new gate
   ([decision-rounds](../decision-rounds/SKILL.md#the-closing-round-carries-the-first-plan-ek26)).
5. **A go is not a release.** It lets the agent write in the working copy; commit, push,
   merge, seed and deploy still wait for the release word
   ([decision-rounds](../decision-rounds/SKILL.md#the-release-word)).
6. **A change of mind after the go is a revision**: the artifact is revised (a spec goes to
   `revised`, dated, with what changed and why) and passes a **new gate** - same
   sentence, new go, new WORKLOG row. Never a silent drift in the code. A revision that
   the delivery gates' questions bring rides in their round: written on its
   recommendations as premises, its go asked on a line of its own - one stop for the
   answers and the new gate ([the EK#26 pattern](../decision-rounds/SKILL.md#a-round-raised-after-the-go-the-ek26-pattern)).
7. **Facts that arrive with the go** (in the answer, or a read the round asked for): re-read
   the premises and the risks. A broken premise voids the plan (item 4); a risk that
   changes what the code will be is a revision (item 6); any other is a dated `After the
   go` note in the plan, a WORKLOG row and, for a prepared change, a stop condition in
   `PATCH/APPLY.md` - the go stands.

### Step 5 - Single pass (T28)

- **Each target file is written completely, once**, after the go - not "edit, look, edit
  again" across turns. A file is written at its first run (the first test, build or suite
  run that executes it); edits before it are drafting, not second passes. A second pass
  after it that cannot be avoided gets one line in the WORKLOG with its reason.
- **Nothing beyond the approved artifact.** If the plan turns out wrong, stop and say so;
  the plan is revised and gated again (step 3). Never improvise a second plan in the code.
- **When the Test plan names a test, the order is fixed**: the test first, run red on the
  old code with its log kept, then the production files. Test-first mode arrives here
  with its red already proven. A new unit's stub goes with its test and is not a pass on
  the unit; the unit is then written completely once
  ([test-gate](../test-gate/SKILL.md#a-new-unit---greenfield-no-old-code)).
- Every new file is added to version control when it is created (a local, reversible
  step), so nothing is left unversioned at the hand-over
  ([packaging](../close-and-retain/references/packaging.md), T78). Adding is not
  releasing: it waits for no release word, which governs the commit. From level 2 the same
  holds for the knowledge base's own new documents - added by path when created, a base
  with no first commit included - unless the case decided otherwise
  ([close script](../../runtime/close/README.md): level 1 notes them once; a working copy
  with no first commit yet is one note at every level).
- Mode specifics - each requirement implemented as written and then the compliance table
  (spec); minimal code to green, then refactor on green (test-first):
  [references/modes.md](references/modes.md).

#### A change the agent cannot write or run - prepared

When the code tree is read-only for the agent (a boundary of the case) or this machine has
no build or run environment for the stack, step 5 changes hands, not order. After the go
the change is **prepared**: two patches in the ticket folder, `TICKETS/<ID>/PATCH/` - the
test first, the fix second - each written once, against the baseline revision the plan
names, with the exact steps to apply and run them. A person applies them in a **disposable
instance** ([`disposable-proof`](../disposable-proof/SKILL.md), Part A) - the test patch
alone, then the fix - and returns the logs: the build probes' output (when the plan lists
a doubt about the build), the red (test patch only), the green (both), the whole suite's
run, the build and install done the way production does them, and the walkthrough the
Test plan names. They are the evidence in `TESTS/`, read like any run
([`test-gate`](../test-gate/SKILL.md): an assertion red, the counts reconciled); until they
come back the hand-offs wait - only the closing record is drafted, with the patches
([`close-and-retain`](../close-and-retain/SKILL.md#drafts-while-a-gate-waits)). A red
that is not the expected assertion stops the fix patch and sends the change back to step 3. In test-first mode the test patch and its returned red
are the gate's artifact. Format and the hand-over: [references/prepare-only.md](references/prepare-only.md), section 7.

## Anti-patch (T34)

**Silencing a crash or a warning is a finding, not a fix.** A null guard, an empty catch,
a compiler or linter switch, a retry loop, a widened tolerance or a weakened test added to
make a symptom disappear hides the cause and moves the failure somewhere quieter.

- Trace the lifecycle - creation, ownership, destruction, concurrency - and fix the cause.
- The check happens **at step 3**: a plan that silences something is rejected at the gate,
  not discovered at the review. Every plan artifact carries the anti-patch line.
- When the cause cannot be fixed in this change, the plan says so, the finding is
  recorded, and the owner decides - a guard never enters as a quiet "fix".
- An empty catch met on the path is a finding in itself, even when it is not the bug.

Examples and what to do instead: [references/debugging-and-contracts.md](references/debugging-and-contracts.md#anti-patch-t34).

## Divergence-point debugging (T81)

For a **wrong result without a crash**, no fix is proposed before four points are written
down:

1. **Symptom** - the exact deviation: expected value vs actual value, on which input.
2. **Recall** - the memory for the units involved; cards quoted by id.
3. **State map** - the values that carry the result from input to output, step by step.
4. **First diverging statement** - the first point where the actual state departs from the
   expected one. **The fix goes there**, not where the wrong value is finally shown.

Then audit in a fixed order (undefined names, recent rule changes, side effects,
conditionals, data integrity, type conversions, swallowed errors) and report root cause,
logical trace, fix. Detail and a worked example: [references/debugging-and-contracts.md](references/debugging-and-contracts.md#divergence-point-debugging-t81).

## Path integrity and contract first (T82)

- **Never cite a symbol you have not read** - a file, a function, a page, an endpoint, a
  column. Resolve it first (code graph, search, reading); a citation the agent cannot
  open is removed, not guessed.
- **Contract first** for a change that crosses tiers: write the contract before the code -
  field names exactly as the producer emits them, types mapped across the boundary, the
  error envelope - and walk it end to end (producer type -> wire field -> consumer read).
- **A cross-tier change is done only when every tier resolves** in the same working tree:
  the handler, the data layer and the consuming page or client, each one read after the
  change. One tier green is not the change done.

Checklist and example: [references/debugging-and-contracts.md](references/debugging-and-contracts.md#path-integrity-and-contract-first-t82).

## Prepare-only for the irreversible (T29, proven)

The agent **prepares** - the exact command, the exact text, the order, the working copy -
and a **human executes**: commit, push, merge, tag, branch copy, deployment, publication,
any script applied to a shared database, any tracker write, any message to a person, any
deletion. Nothing leaves the working copy without the owner's release word
([decision-rounds](../decision-rounds/SKILL.md#the-release-word)).

- **The harness holds the same line mechanically**: those operations sit on the harness
  "ask" list - [runtime/guards/HARNESS-PERMISSIONS.md](../../runtime/guards/HARNESS-PERMISSIONS.md)
  is the executable twin of this rule.
- **Database sessions are read-only.** Every query the agent runs against a shared or
  production database opens a read-only session, proven once by a write the database
  refuses (the kit's runner: [`runtime/data-probe`](../../runtime/data-probe/README.md)).
  Writes are rehearsed in a disposable copy
  ([`disposable-proof`](../disposable-proof/SKILL.md)).
- **The agent never types passwords.** A login in a browser walk is done by a human; the
  agent never types, pastes or echoes a password, token or key.
- **Tracker writes**, where the case sanctions one (for example the closing fields): read
  the item first; send an optimistic revision test in the same update; show any text
  someone else wrote and ask before replacing it; never post comments; confirm that each
  field landed.
- Reads stay free: status, diff, log, queries in a read-only session, work-item reads.

Detail, the prepared-command format and the tracker protocol: [references/prepare-only.md](references/prepare-only.md).

## The ticket folder canon

Everything one change produces lives in its ticket folder, worked there from the first
file ([kb-setup](../kb-setup/SKILL.md)). Names are the kit's defaults; a case fixes its
own once in `AGENTS.md`.

| File | Written by | When |
|---|---|---|
| `DOSSIER.md`, `attachments/` (each document with its `.txt` extraction), repro material | intake (step 0) | first |
| The bug analysis and its fix proposal, when the case has that step | the bug analysis | before the plan |
| The review brief and implementer context of a change request | [`review-pack`](../review-pack/SKILL.md) | before the spec |
| `PLAN.md` or `SPEC.md` (each with its Test plan) | this skill, step 3 | before the gate |
| `WORKLOG.md` - the go, facts after the go, revisions, second passes, approved test updates, release words | the owner of the change (the agent writes what the owner said, quoted) | from the first gate |
| `TESTS/` - the test plan, the red log reference, suite and browser evidence | this skill (test-first red), the `test-gate` skill and [`browser-verification`](../browser-verification/SKILL.md) (the browser spec, its report and evidence) | steps 5-6 |
| `PATCH/` - prepared patches (test first, fix second) and how to apply them | this skill, step 5, when the agent cannot write or run the change | after the go |
| `BUILD_<date>.md` - the build audit | the [`build-analyst`](../../agents/build-analyst.md) agent, where the stack compiles | after step 5 |
| `REVIEW/` | [`result-review`](../result-review/SKILL.md) | after the gates |
| `CLOSE.md` - closing record: tracker text, commit messages, prepared commands, knowledge tail | [`close-and-retain`](../close-and-retain/SKILL.md) | last - a draft earlier while the owner's walk or a prepared change's logs wait |

The tests themselves live in the project's test suite, never in the knowledge base or the
ticket folder; the ticket keeps the evidence and the references. The one exception is a
**prepared patch** ([step 5](#a-change-the-agent-cannot-write-or-run---prepared)): a test
travels in `PATCH/` until a person applies it, and from then on lives in the suite - the
patch is never the suite, and nothing runs from the ticket folder.

## Flow by work-item type

| Type | Sequence |
|---|---|
| Bug | intake -> bug analysis (writes or extends the process map, ends with a fix proposal and its Test plan) -> **plan** mode from that proposal, or **test-first** when a regression test is the right proof -> hand-offs |
| Change request | review pack and its meeting -> **spec** mode when the change request is a specification, otherwise **plan** -> hand-offs |
| Task | intake -> **plan** mode -> hand-offs |
| Greenfield wave (no tracker) | the closed prompt and its requirements as the intake -> **plan** mode, or **test-first** when the requirements fix the expected result -> hand-offs ([below](#a-greenfield-wave-no-tracker-no-flow-to-map-no-area-yet)) |

## A greenfield wave (no tracker, no flow to map, no area yet)

A front framed from a draft ([`frame-greenfield`](../frame-greenfield/SKILL.md)) reaches this
gate with a closed prompt, its requirements and its decisions - and often no tracker, no
process in `PIPELINES/` and no area. The sequence is the same; three inputs have a
stand-in, and the plan artifact writes each one as what it is:

| The gate expects | On a greenfield front | Written in the plan |
|---|---|---|
| A work-item id and its dossier (step 0) | the front's wave or step, as section 5 of the prompt names it: `<NS>-W<n>`, a step `<NS>-W<n>.<m>`; the ticket folder is `TICKETS/<NS>-W<n>/`. No dossier: the prompt (the ask, the facts, the decisions) and the requirements are the intake | `work_items: [ORD-W1]`; `Dossier: none - no tracker; intake: prompt_<front>.md sections 1, 2, 5 and prompt_<front>-requirements.md` |
| A map of the process in `PIPELINES/` (step 2) | none to map - no code implements the flow yet. The design of the closed prompt (section 5) and the requirements (FR, BR, AC) stand in for the map | `Pipeline: none to map - new product; stand-in: prompt_<front>.md section 5 + FR01-FR04, BR02` |
| An area for the ticket folder | created by its first document - here the wave's plan - by the kit's rule ([`kb-setup`](../kb-setup/SKILL.md), section 3: the catalog first, else one name proposed in one line and checked against the occupied words), never before Round 0 closed. The owner's go on the plan approves the name; a name changed at the gate is a move, links fixed | `subject: <the area>`, and "new area" in the plan's first line |

- **The wave id is not greenfield-only.** Any front with no tracker - a legacy pilot's
  first change included - names its work items `<NS>-W<n>` (steps `<NS>-W<n>.<m>`) and its
  ticket folders the same way; the other stand-ins of the table stay greenfield's.
- **The stand-in holds while the flow is the one the prompt designed.** A later change to a
  built flow that no longer matches the design maps it first, as on any product (step 2).
- **Baseline**: a code tree with no commit yet is written `new - no commit` (step 1).
- **The first wave's plan rides in the framing's closing round**, written on that round's
  recommended answers as premises and gated there (step 3, step 4 item 4;
  [`frame-greenfield`](../frame-greenfield/SKILL.md), section 3).
- **Test plan**: the first test of a new unit is red on its stub; its expected values come
  from the requirements' acceptance criteria and scenarios, cited by id - never from the
  code being written ([`test-gate`](../test-gate/SKILL.md#a-new-unit---greenfield-no-old-code)).
- **Run up to the STOP once**: a greenfield exit test wrote the first wave's plan and its
  red with these stand-ins and stopped for the go; the single pass after a go is not run
  yet.

## Hand-offs

After step 5, in this order - each one is its own skill or agent, and none is replaced
by the agent's own self-review:

1. **The [`build-analyst`](../../agents/build-analyst.md) agent**, where the stack
   compiles - the registered build and the audit of its risky warnings. BROKEN, or a new
   risky item, sends the change back to step 5.
2. **The [`test-gate`](../test-gate/SKILL.md) skill** - the suite run against its
   baseline, the evidence, the coverage of the new code. A new failure sends the change
   back to step 5.
3. **The [`browser-verification`](../browser-verification/SKILL.md) skill** - for a change
   a user can see: the browser cases of the Test plan run in a real browser with literal
   read-back. A FAIL sends the change back to step 5. `Browser cases: none - <reason>` (no
   server may run here) goes into the evidence; what a user sees then waits for G4.
4. **The [`delivery-gates`](../delivery-gates/SKILL.md) skill** - the scored and
   adversarial reviews and the owner's walk through the real application.
5. **The [`result-review`](../result-review/SKILL.md) skill** - a review of the result
   (never of one revision alone), by a second person when there is one.
6. **The [`close-and-retain`](../close-and-retain/SKILL.md) skill** - the closing record
   and tracker text, the commits prepared as two groups (fix first), the retention chain
   with the card decisions, the deliverable gate, then the close script. The commits are
   the human's, after the release word.

What this skill leaves behind: the plan artifact as approved (a spec with its compliance
table), the WORKLOG with every go and every deviation, and the red log reference.

## Recorded lessons (real situations)

- **A blind fix on an unmapped process cascaded** into further defects in a team case;
  that is why the pipeline gate stops design, not analysis.
- **A freshness rule never fired** because the dossier had no date field to compare; the
  dossier template got `last_updated`, and "no date" now means stale.
- **Three orchestrators differed only in their plan artifact**, yet each carried the
  shared sequence; the case had to pull it into one shared document to keep them from
  drifting apart. One skill with three modes removes the copies.
- **In the second case every go and every release word was quoted with its date** in the
  front's log ("release word for seed N, by the roadmap of section 8"); each later session
  could tell what had been approved and what still waited.
- **In the second case the developer's database was production.** Read-only sessions,
  proven by a refused write, made every probe safe; all writes went to disposable copies
  first and to the real database only with the release word.
- **Browser walks ran with the owner signed in**: the agent drove the page, the human
  typed the password. No credential ever passed through the agent.
