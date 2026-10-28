# The three modes - plan, spec, test-first

**Scope**: method

Companion of [the change-gate skill](../SKILL.md), sections *Choosing the mode*, *Step 3*,
*Step 4* and *Step 5* (technique T28). The common steps (intake, recall, rule check,
pipeline gate, the STOP and the go) are the same in every mode; only the plan artifact and
the implementation discipline change. Example throughout: **CR-123, "Acme Orders: allow a
partial shipment of an order"**, area `SHIPPING`, namespace `ORD`.

## 1. Plan mode (the default) - a blueprint

**Artifact**: `TICKETS/<ID>/PLAN.md`, from [`templates/PLAN.template.md`](../../../templates/PLAN.template.md).

The blueprint is written in the order the change must be built, so that each phase rests
on the one before:

| Phase | Holds | Rule |
|---|---|---|
| 1. Contract and back end | the contract as the producer emits it (field names, types, error envelope), schema changes, server-side types | a new or altered domain object goes through [`conceptual-guardian`](../../conceptual-guardian/SKILL.md) first |
| 2. Logic | the units and methods that change; the **lifecycle of every object created** - who creates it, who owns it, who destroys it, what runs concurrently | no step that only hides a symptom ([anti-patch](debugging-and-contracts.md#anti-patch-t34)) |
| 3. Front end and UI | screens, states, messages; every call handles its success and its failure path | it reads exactly the contract of phase 1 |

Then the parts every plan carries: impacted files and the callers that could regress (from
the code graph, then read), cross-tier resolution, risks High / Medium / Low per tier, the
anti-patch line, the Test plan, out of scope.

**On a bug**, the plan starts from the fix proposal of the bug analysis and its Test plan;
it links the process map that analysis wrote and does not remap it.

**Parallel version lines** (optional - only when the project maintains several active
lines of the same code): before the gate, compare each impacted unit with the same unit on
the other lines - recent history and the method the plan changes - and add a *Cross-version
drift* section: per unit *same / differs (how) / absent*, and a port line for each line
that needs the same fix, naming the tests that travel with it. A fix planned on one line
while another has already diverged is a stated risk, never a silent assumption. The
documents' side of that comparison is the [`version-diff`](../../../agents/version-diff.md)
agent's DIFF (T35): link it from the section; a line it reports as `differs` is one whose
code the plan compares.

Excerpt, CR-123:

```markdown
## Blueprint
### Phase 1 - Contract and back end
- `POST /orders/{id}/shipments` body `{ "lines": [{ "lineId": int, "qty": decimal }] }`;
  error envelope `{ "code": "QTY_EXCEEDS_OPEN", "fields": [...] }` (ORD#14).
- New column `shipped_qty` on the order line - guardian verdict in the dossier (presence
  of a quantity, not a new concept).
### Phase 2 - Logic
- `ShipmentService.ship()` creates one `Shipment` per call; owned by the order; never
  shared across requests.
### Phase 3 - Front end
- Order screen: a "Ship part" action per line; failure shows the envelope's field message.

## Anti-patch check
This plan silences nothing: the over-shipment is refused by a rule (ORD#14), not caught
and ignored.
```

## 2. Spec mode - the specification is the source of truth

**Artifact**: `TICKETS/<ID>/SPEC.md`, from [`templates/SPEC.template.md`](../../../templates/SPEC.template.md).
**Inputs**: the dossier; for a change request, the review brief and the implementer
context from [`review-pack`](../../review-pack/SKILL.md) with the decisions of its
meeting; the owner's statements, quoted.

### Content

| Section | Rule |
|---|---|
| Functional requirements | numbered `FR-1`, `FR-2`...; each one a single testable sentence; numbers are never reused, a dropped requirement stays with "withdrawn in revision N" |
| Data contracts | payloads exactly as the producer emits them, schema changes (guardian first), field mappings |
| UI behaviour | screens, modes, states, messages |
| Edge cases and errors | what fails, what the user sees, what is logged |
| Test plan | the test that will pin **each** `FR-n`, what fails on the old code, where it runs - or `exempt: <reason>` per requirement |
| Out of scope | explicit; it travels to the review and the close |

A business or architecture choice met while specifying is a numbered question
([decision-rounds](../../decision-rounds/SKILL.md)), never a sentence the spec decides.

### States - draft, approved, revised

| State | Set when | What it allows |
|---|---|---|
| `draft` | the spec is written or being written | nothing in the code |
| `approved` | the owner's go is logged in the WORKLOG (date, words) | implementation of exactly this text |
| `revised` | anything in an approved spec has to change - a requirement, a contract, a scope line | nothing in the code until the revision passes **its own gate** |

- A revision is dated and says what changed and why, in a *Status history* table; the
  previous text is kept (struck through or quoted), never silently rewritten.
- A revision prints the same gate sentence and waits for a new go; the WORKLOG gets a new
  row. After that go the status goes back to `approved` (revision N).
- The approved spec is frozen: the code follows the spec; the spec never follows the code.
  A discovery during implementation stops the pass and becomes a revision.

### The compliance table (after the single pass)

Walk the requirements one by one against the code; every row needs its evidence:

| FR | Status | Where (file:line) | Test that pins it | Note |
|---|---|---|---|---|
| FR-1 | implemented | `orders/shipment.service.ts:42` | `shipment.test.ts` "ships part of a line" | |
| FR-2 | partial | `orders/order.screen.ts:118` | - | the failure message is not shown yet |
| FR-3 | missing | - | - | |

- `partial` and `missing` send the change back to step 5 (or to a revision, when the
  requirement turns out wrong) - never a hand-off with an open row.
- A requirement with no test is either covered by the Test plan's `exempt:` line for it or
  is a gap to close before the hand-off to the [`test-gate`](../../test-gate/SKILL.md) skill.
- The table lives in `SPEC.md`; the browser verification later draws its cases from the
  same requirements (named on the Test plan's `Browser cases:` line).

## 3. Test-first mode - red, green, refactor

**Artifact**: a failing test in the project's test suite - for a new unit, with its stub -
and `TICKETS/<ID>/TESTS/TEST_PLAN.md` naming the case, the test's path, the red log and what
fails and why. The test itself never lives in the knowledge base or the ticket folder -
except as a prepared patch, when the agent cannot write or run the change
([step 5](../SKILL.md#a-change-the-agent-cannot-write-or-run---prepared)).

### Red (before the gate)

1. One test per expected behaviour, named after the behaviour. Arrange, act, assert; no
   sleeps, no real network; a fixture frees what it creates. A card that states the rule
   under test is quoted by id in the test's header comment.
2. **Prove red for the expected reason**: the test fails on an **assertion** about the
   behaviour - not a compile error, not a missing fixture, not zero tests found. Read the
   runner's tests-found count; a runner that exits green on zero tests proves nothing. A
   new unit (greenfield) is red on its stub, with expected values from the requirements
   ([test-gate](../../test-gate/SKILL.md#a-new-unit---greenfield-no-old-code)).
3. **A new unit's stub is part of the red artifact** ([EK#28](../../../DECISIONS.md)): the
   signature the test plan names, a sentinel return no expected value can equal (a test the
   stub's value satisfies is a test-plan defect), no behaviour. It is the only
   production file written before the go - the one exception to "nothing in the code
   working copy before the go" ([step 4](../SKILL.md#step-4---stop-and-the-go-t28)).
4. Keep the red log; `TEST_PLAN.md` names it.
5. A test that expects a behaviour a rule row **denies** stops at step 1b.

Then the gate: present the test, the failure output and why it fails - and, for a new
unit, the stub; print the test-first gate sentence; stop; log the go.

### Green (after the go)

- The **minimum** production code that turns the test green, one complete write per file.
  A new unit is written once here, over its stub - the stub was the red's, not a first pass.
- Run the test again and the tests around it: what was green stays green.
- **No test is weakened to pass** - that is the [anti-patch](debugging-and-contracts.md#anti-patch-t34)
  rule applied to tests.

### Refactor (only on green)

Duplication, naming, lifecycle safety, warnings in the touched files - each step re-run
green. A refactor that needs a behaviour change is a new red test, not a refactor.

## 4. Changing mode, and the gate after a revision

- A plan that turns out to need a specification (the owner keeps adding behaviour) becomes
  a spec in `draft`: a new artifact, a new gate. The approved plan stays in the folder,
  marked `SUPERSEDED` by the spec.
- A spec or a plan can name a red test as its Test plan's first step; that does not make it
  test-first mode - the order (test first, then production files) holds in every mode.
- Whatever the mode, the go covers one artifact in one state; anything else waits for its
  own go. **A plan's test-first steps are part of that artifact** when their reds are shown
  with it ([EK#30](../../../DECISIONS.md), one go per wave): the plan's Test plan lists each
  step with its `TESTS/TEST_PLAN.md` and red log, each red proven as in section 3, and one
  go covers the plan and those reds in their state. A step whose red was not ready at the
  gate is gated on its own later, in test-first mode.
- A plan written on premises - open questions with the recommended answer it assumes,
  carried by the round that closes a prompt ([EK#26](../../../DECISIONS.md)) - is in that
  state only while the premises hold: its go covers it with them decided as listed. An
  answer that differs is a new state - the plan is rewritten and gated again, a go given in
  the same message included ([SKILL.md](../SKILL.md#step-3---the-plan-artifact-t28)).
