# Requirements half (review-pack step 2)

**Scope**: method

The "what was asked" half of a change: problem, requirements, acceptance criteria and test
scenarios, **read from the change document, never from the code**. The "what it costs and
where it lands" half (prior art, pipelines, placement, estimate, options, questions) is
[technical-half.md](technical-half.md), and its owner is the Review Brief.

This procedure belongs to the kit's `frame-greenfield` skill (planned, wave 4: technique
T18, the requirements pipeline). Until that skill exists, the review pack runs it from this
page; when it lands, step 2 calls it with the **pack profile** and this page shrinks to a
pointer.

## Why it reads only the document

A requirements analysis that reads code starts describing the current implementation and
calls it a requirement. Reading only the document keeps the requester's words as the
source and turns every gap into a visible unknown - which is exactly what the meeting
needs. The code is read in steps 3-6, by the other half.

## Profiles

| Profile | When | Roles that run | Report |
|---|---|---|---|
| `full` | a standalone request, no pack planned | intake -> business -> requirements -> test design and solution architecture in parallel -> synthesis | every section, including technical impact and an effort estimate |
| `pack` | called by review-pack step 2 | intake -> business -> requirements -> test design -> synthesis (no solution architecture) | **business-only**: no technical impact, no effort, no roadmap, no next steps, no open-questions section; ends with the frozen hand-over |

The pack profile exists because one case ended with two estimates in the same folder (2.5
days in the requirements analysis, 3.5 in the brief). In a pack, steps 3-6 are the
technical half and the brief is the only owner of estimate, risks, options and questions.

## The roles (one agent may play them in sequence)

Each role reads the previous outputs and adds its own; intermediate files go to the
change's working folder, never into the skill folder.

1. **Document intake** - a structured context: business context, current and desired
   state, stakeholders, screens and processes named, constraints, dates.
   - Stakeholders: name, role, `role_source: document | register | unconfirmed`, interest.
     A role is recorded only when the document states it (signature block, header, body)
     or the case's people register confirms it. A name from a tracker field or an e-mail
     domain gets `role: ""` and `role_source: unconfirmed`.
   - **Unknowns**: every absent, ambiguous or contradictory item gets an entry with impact
     (HIGH blocks the analysis, MEDIUM reduces accuracy, LOW is a minor gap) and a specific
     clarification question. Proceed best-effort; never halt on a gap.
   - Gate: business context and desired state are filled; otherwise the overall
     confidence is LOW and the gap is an unknown.
2. **Business analysis** - executive summary, the business problem, objectives, success
   measures, business risks (probability, impact, mitigation), out of scope.
3. **Requirements engineering** - formal, atomic, testable, traceable:
   - **Functional requirements** (`FR01`...): one behaviour each, testable without
     ambiguity, implementation-agnostic (what, never how), MoSCoW priority (MUST, SHOULD,
     COULD, WONT).
   - **Non-functional requirements** (`NFR01`...): measurable ("answers in under 2
     seconds for 1,000 open orders", never "fast"), with a category and a priority.
   - **Business rules** (`BR01`...): invariants the business holds whatever the screen
     ("a shipment never exceeds the units still outstanding").
   - **Acceptance criteria** (`AC01`...): strict Given-When-Then, each citing its
     requirement, each verifiable on its own by a tester.
   - **Open items** (`OI01`...): what must be answered before building; a HIGH unknown
     from intake becomes a blocking open item.
4. **Test design** - scenarios that cite a requirement id, with numbered steps, an
   observable expected result (never "works correctly"), a severity, the test data and
   the environments:
   - **Positive** (`TC-P01`...): at least one per functional requirement (the happy path).
   - **Negative** (`TC-N01`...): at least one per MUST requirement (invalid input,
     unauthorised access, failure condition).
   - **Boundary** (`TC-B01`...): for numbers, lengths, dates and limits; state the
     boundary condition under test.
   - **Regression** (`TC-R01`...): one per area at risk of breaking.
5. **Solution architecture** - `full` profile only (technical impact, complexity, effort).
6. **Delivery synthesis** - the report below. No raw intermediate data, no placeholder
   text, no blank mandatory section.

## Structure of `<ID>_Requirements.md` (pack profile)

```markdown
# <ID> - Requirements: <title>

**Scope**: <method|case|mixed>
**Source**: <change document name and version, date read>  **Profile**: pack

## Executive summary            (problem, objectives, scope - no effort, no risk paragraph)
## Business problem
## Objectives and success measures
## Stakeholders                 (role + role_source on every row)
## Functional requirements      (FR, MoSCoW)
## Non-functional requirements  (NFR)
## Business rules               (BR)
## Acceptance criteria          (AC, Given-When-Then, each citing its requirement)
## Test scenarios               (TC-P / TC-N / TC-B / TC-R, each citing its requirement)
## Out of scope

## Hand-over to the Review Brief (frozen <YYYY-MM-DD>)
Owned from here on by `<ID>_Review_Brief.md` (questions, risks, estimate); not maintained
after this date.

### Business risks
| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|

### Open items and HIGH-impact unknowns
| # | Item | Blocking | Suggested owner (role only) |
|---|---|---|---|
```

## Rules

- **Never edited after the pack.** Answers, estimate revisions and new questions live in
  the brief. A new version of the change document produces a new requirements file; the
  old one gets a SUPERSEDED mark pointing at it ([retain-knowledge](../../retain-knowledge/SKILL.md)).
- **Reuse** an existing requirements file when the change document has not changed since
  it was written (compare the document's date with the file's source line). An older
  `full`-profile file is reused as it is: its technical sections are superseded by the
  brief, not rewritten.
- The ids (`FR`, `NFR`, `BR`, `AC`, `OI`, `TC-x`) are stable: the brief, the context and
  the code review cite them; never renumber.
- Suggested owners in the hand-over are roles only ("the requester", "QA"), never names.

## Example (CR-123, "Acme Orders: allow a partial shipment of an order")

- **FR01** (MUST) - The clerk can ship part of an order's outstanding units.
- **BR01** - A shipment never exceeds the units still outstanding on the order.
- **AC01** (FR01) - *Given* an order of 10 units with 6 in stock, *When* the clerk confirms
  a partial shipment of 6, *Then* a shipment of 6 units is created and the order shows 4
  units outstanding.
- **TC-P01** (FR01) - ship 6 of 10 -> one shipment of 6, order outstanding 4.
- **TC-N01** (FR01, BR01) - ship 11 of 10 -> refused with the over-shipment message; no
  shipment created.
- **TC-B01** (BR01) - ship exactly the 10 outstanding units -> the order closes as fully
  shipped; ship 0 -> refused.
- **TC-R01** - a full shipment of an order behaves exactly as before the change.
- **OI01** (blocking) - may a partial shipment be cancelled after dispatch? -> becomes Q1
  in the brief.
