# Requirements pipeline (T18)

**Scope**: method

Companion of the [frame-greenfield skill](../SKILL.md), section 4 - and the shared home of
the procedure: [`review-pack`](../../review-pack/SKILL.md) step 2 runs it in the `pack`
profile. The "what was asked" of a product or a change - problem, requirements, acceptance
criteria, test scenarios - **read from the document, never from the code**. The report
follows [`templates/REQUIREMENTS.template.md`](../../../templates/REQUIREMENTS.template.md).

Maturity: `operating` - case two ran it on about fourteen change-request documents; the
`greenfield` profile applies the same roles to a product draft and has not run on one yet.

## Why it reads only the document

A requirements analysis that reads code starts describing the current implementation and
calls it a requirement. Reading only the document keeps the requester's words as the source
and turns every gap into a visible unknown - which is what the round or the meeting needs.
In a change request, the code is read by the other half (the review pack's technical
steps); in a greenfield, the design is decided in rounds. The same holds for a prototype or
another product's screens: they are an implementation, not an ask.

## Profiles

| Profile | Called by | Roles that run | Report |
|---|---|---|---|
| `greenfield` | [`frame-greenfield`](../SKILL.md) section 4 | intake -> business -> requirements -> test design -> synthesis (no solution architecture) | business and requirements; **open items go to the next round** as questions; no estimate; revised in place until the prompt closes, then frozen as the baseline |
| `full` | a standalone request on a change document, no pack planned | intake -> business -> requirements -> test design and solution architecture in parallel -> synthesis | every section, including technical impact, effort, risks, roadmap, next steps and open questions |
| `pack` | [`review-pack`](../../review-pack/SKILL.md) step 2 | intake -> business -> requirements -> test design -> synthesis (no solution architecture) | **business-only**: no technical impact, effort, roadmap, next steps or open-questions section; ends with the frozen hand-over to the Review Brief |

Why two profiles skip solution architecture: in a pack the brief owns the estimate, risks,
options and questions (one case ended with two estimates in one folder - 2.5 days in the
requirements analysis, 3.5 in the brief); in a greenfield the design belongs to the prompt
and its rounds, and an estimate before the design is decided is a guess.

## Input

| Profile | The document | Also |
|---|---|---|
| `greenfield` | the organised draft (owner's words, warning marks) | the decisions so far by id, the guardian verdicts; never the raw draft alone - its contradictions are already marked in the organised one |
| `full`, `pack` | the change document (usually an attachment of the work item), copied into the change's folder | the work item's id; for `full`, a short technical context given by a person (architecture, constraints, related items) |

An input note records: the id, the document and its date, the profile, the output folder,
the report language (the case's artifact language, else the document's), and any focus
areas a person flagged - the synthesis must answer them explicitly.

## The roles (one agent may play them in sequence)

Each role reads the previous outputs and adds its own; intermediate files go to the working
folder of the change or the front, never into the skill folder.

### 1. Document intake

A structured context of the document:

- type (change request, brief, notes, e-mail, transcript) and language; id and title;
- **business context** (why), **current state** (what happens today), **desired state**
  (what should happen after);
- stakeholders - name, role, `role_source: document | register | unconfirmed`, interest. A
  role is recorded only when the document states it or the case's people register confirms
  it; a name from a tracker field or an e-mail domain gets `role: ""` and `unconfirmed`
  ([`kb-setup`](../../kb-setup/SKILL.md), people are not roles);
- systems, screens and processes named; constraints; dependencies; five to ten keywords;
- **unknowns**: every absent, ambiguous or contradictory item, with an impact (HIGH blocks
  the analysis, MEDIUM reduces accuracy, LOW is a minor gap) and a specific clarification
  question. In `greenfield`, an unknown that is already a warning mark cites its question
  (`Q-SUB3`) instead of opening another;
- a confidence (HIGH, MEDIUM, LOW) per field and overall.

Gate: business context and desired state are filled; otherwise the overall confidence is
LOW and the gap is an unknown. **Never halt on a gap; never invent what the document does
not say.**

### 2. Business analysis

Executive summary (three to five sentences a sponsor can read), the business problem (its
impact, not the technical symptom), the value, the drivers (compliance, revenue, cost,
experience, risk, efficiency, strategy), **objectives** (`BO01`...) each with a measurable
outcome, stakeholders with their influence, **business risks** (probability, impact,
mitigation), assumptions of the analysis (`AS01`...), dependencies (`DEP01`...), out of
scope.

Gate: a summary, a problem and at least one objective.

### 3. Requirements engineering

Formal, atomic, testable, traceable:

- **Functional requirements** (`FR01`...): one behaviour each; a title with an imperative
  verb; the description, the rationale; testable without ambiguity; what, never how;
  MoSCoW priority (MUST, SHOULD, COULD, WONT); a **source** - an objective (`BO02`), an
  assumption (`AS01`), and in `greenfield` the draft item (`L12`) or the decision (`SUB#3`).
  Two requirements for one behaviour are merged.
- **Non-functional requirements** (`NFR01`...): measurable ("lists 1,000 open orders in
  under 2 seconds", never "fast"); a category (performance, security, usability,
  reliability, scalability, maintainability, compliance); a priority.
- **Business rules** (`BR01`...): invariants the business holds whatever the screen ("a
  shipment never exceeds the units still outstanding"), each with the requirements it
  applies to and what happens on a violation.
- **Acceptance criteria** (`AC01`...): strict Given-When-Then, at least one per FR, each
  citing its requirement, each verifiable on its own by a tester.
- **Out of scope**: what is explicitly not part of it.
- **Open items** (`OI01`...): what must be answered before building, `blocking` or not,
  with a suggested owner - a role, never a name. A HIGH unknown from intake becomes a
  blocking open item.

Risks and drivers are translated into behaviours, never copied in as requirements.

Gate: every FR has at least one AC; every AC cites its requirement.

### 4. Test design

Scenarios that cite a requirement id, with preconditions, numbered steps a newcomer can run,
an **observable** expected result (never "works correctly"), a severity, the test data and
the environments:

- **Positive** (`TC-P01`...): at least one per FR - the happy path.
- **Negative** (`TC-N01`...): at least one per MUST requirement - empty or invalid input,
  a forbidden action, a duplicate submission, an unavailable dependency.
- **Boundary** (`TC-B01`...): for numbers, lengths, dates and limits - the minimum, the
  maximum, just below, just above, zero, empty; the boundary under test is stated. For dates,
  first compute the calendar facts the draft's dates imply - the weekday of a deadline, the
  movable holidays, how a fixed period lands on the week and on closed days - and write them
  as facts: vague date rules become concrete boundary scenarios.
- **Regression** (`TC-R01`...): one per area at risk of breaking, named.

Severity: CRITICAL (a failure blocks the release), HIGH (core function broken), MEDIUM
(non-core, release with a documented risk), LOW (fix later). Each scenario says whether it
is a good automation candidate (repeatable, deterministic, valuable). Test data are listed
with the scenarios that need them. One scenario that serves two requirements cites both.

Gate: a positive scenario per FR and a negative one per MUST requirement.

### 5. Solution architecture (`full` only)

Modules, interfaces, data and security impact, performance, migration and its rollback,
deployment strategy, complexity (LOW to CRITICAL) with a one-line reason, and an effort per
discipline with its confidence.

### 6. Synthesis

The report, from the template, in the report language; ids stay as they are. No raw
intermediate data, no placeholder text, no blank mandatory section - an empty one says "No
items identified." Given-When-Then rendered with the three labels on separate lines, grouped
under their requirement; scenarios as summary tables (steps stay in the working files).

### When a gate fails

The role runs once more with the missing fields named. If it fails again, the work goes on
and the gap becomes an open item - never a silent hole.

## By profile

**`greenfield`** (in a front):

- When: after the owner's answers to Round 0 ([skill, section 3](../SKILL.md#3-round-0-and-the-rounds)).
  Before them, only the input note is written; the template is copied after them.
- Output `prompts/prompt_<front>-requirements.md`, an annex of the front prompt with the
  same writer.
- Open items and HIGH unknowns go to the next round as questions; the row says where
  (`OI02 -> Q-SUB5`); once answered, the row cites the decision.
- Until the prompt closes, a decision that changes a requirement revises its row and keeps
  the id ("revised by SUB#9"); a dropped requirement stays, "withdrawn (SUB#9)".
- At closing, the file is frozen as the product's baseline (`Status: baseline <date>`).
  Later changes are change requests with their own requirements files.

**`full`**:

- Output `<ID>_Requirements.md` in the change's folder; every section of the template,
  including technical impact, effort, risks, roadmap, next steps and open questions.

**`pack`**:

- Output `<ID>_Requirements.md` in the change's folder; business-only; the executive
  summary leaves out effort and risks; the last section is the **hand-over to the Review
  Brief**, frozen with its date: the business risks and the open items with the HIGH
  unknowns. From then on the brief owns questions, risks and estimate.
- **Never edited after the pack.** Answers, estimate revisions and new questions live in the
  brief. A new version of the change document produces a new requirements file; the old one
  is marked SUPERSEDED with a pointer ([`retain-knowledge`](../../retain-knowledge/SKILL.md)).
- **Reuse** an existing requirements file when the change document has not changed since it
  was written (compare the document's date with the file's source line). An older `full`
  file is reused as it is: its technical sections are superseded by the brief, not rewritten.

## Rules for every profile

- The ids (`FR`, `NFR`, `BR`, `AC`, `OI`, `TC-x`) are stable: briefs, prompts, test plans and
  reviews cite them; never renumber, never reuse.
- Suggested owners are roles ("the requester", "QA"), never names.
- Everything comes from the document; an inference is labelled as one, and a missing fact
  is an unknown.

## Examples

**Change request, `pack`** - CR-123, "Acme Orders: allow a partial shipment of an order":

- **FR01** (MUST) - The clerk can ship part of an order's outstanding units.
- **BR01** - A shipment never exceeds the units still outstanding on the order.
- **AC01** (FR01) - *Given* an order of 10 units with 6 in stock, *When* the clerk confirms a
  partial shipment of 6, *Then* a shipment of 6 units is created and the order shows 4
  units outstanding.
- **TC-P01** (FR01) - ship 6 of 10 -> one shipment of 6, order outstanding 4.
- **TC-N01** (FR01, BR01) - ship 11 of 10 -> refused with the over-shipment message; no
  shipment created.
- **TC-B01** (BR01) - ship exactly the 10 outstanding units -> the order closes as fully
  shipped; ship 0 -> refused.
- **TC-R01** - a full shipment of an order behaves exactly as before the change.
- **OI01** (blocking) - may a partial shipment be cancelled after dispatch? -> Q1 in the brief.

**Greenfield** - Acme Subscriptions, after Round 0 of the
[worked example](organise-the-draft.md):

- **FR05** (MUST; source L6, SUB#3) - The customer can skip the next delivery of a
  subscription.
- **BR02** (source L9) - A subscription cannot be cancelled once its box is packed; on a
  violation the cancel is refused with the code `CANCEL_AFTER_PACKED`.
- **AC07** (FR05) - *Given* a monthly subscription whose next delivery is on 10 June, *When*
  the customer skips it on 1 June, *Then* no order is created for 10 June and the next
  delivery is on 10 July.
- **TC-B03** (FR05) - skip on the day the order is created -> refused, the box is already
  an order; skip the day before -> accepted.
- **OI02** (blocking) - what makes a customer "premium" (SUB#1)? -> Q-SUB5, round 1.
