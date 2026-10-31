---
project: <KEY>
subject: <AREA | none yet - greenfield, before the first area (set it when the area is created)>
source: <document name and version | prompts/prompt_<front>-draft.md>
profile: <greenfield | full | pack>
status: <draft | revised (round N) | baseline <YYYY-MM-DD> | frozen <YYYY-MM-DD> | superseded by <file>>
last_updated: <YYYY-MM-DD>
tags:
  - requirements
---
# <ID or front> - Requirements: <the product, module or change in one line>

**Scope**: <method|case|mixed>
**Source**: <the document and its date, read on <YYYY-MM-DD> | the organised draft of `prompt_<front>.md` and decisions <KEY>#1..<KEY>#n>
**Profile**: <greenfield | full | pack> - **Language**: <the case's artifact language>
**Confidence**: <HIGH | MEDIUM | LOW> (intake; LOW when the business context or the desired state is missing)

> Template from the engine-kit (`templates/REQUIREMENTS.template.md`) - technique T18, the
> requirements pipeline: the procedure is `skills/frame-greenfield/references/requirements.md`.
> Where it lives: `greenfield` - `prompts/prompt_<front>-requirements.md`, an annex of the
> front prompt; `full` and `pack` - `<ID>_Requirements.md` in the change's folder. Everything
> comes from the document, never from the code. Sections are marked by profile: delete the
> ones your profile does not take; never leave a kept section blank (write "No items
> identified."). Ids are stable - never renumber, never reuse. Replace every `<placeholder>`
> and delete this note.

## 1. Executive summary

<Three to five sentences: what it is, the problem it solves, who benefits, the
recommendation. `pack`: no effort and no risk paragraph.>

## 2. Business problem

<The problem and its impact on the business - not the technical symptom.>

**Current state**: <what happens today | greenfield: what the users do without the product>
**Desired state**: <what should happen after>

## 3. Objectives and success measures

| ID | Objective | Measurable outcome |
|---|---|---|
| BO01 | <...> | <"orders shipped partially without a manual note: 100%"> |

## 4. Stakeholders

| Name or role | Role | role_source | Interest | Influence |
|---|---|---|---|---|
| <name as the document writes it> | <role, only when stated> | <document \| register \| unconfirmed> | <...> | <HIGH \| MEDIUM \| LOW> |

## 5. Functional requirements

| ID | Requirement (what, never how) | Priority | Source | Status |
|---|---|---|---|---|
| FR01 | <imperative verb + subject: one behaviour> | <MUST \| SHOULD \| COULD \| WONT> | <BO01 \| AS01 \| L12 \| <KEY>#3> | <as written \| revised by <KEY>#n \| withdrawn (<KEY>#n)> |

## 6. Non-functional requirements

| ID | Requirement (measurable) | Category | Priority |
|---|---|---|---|
| NFR01 | <"lists 1,000 open orders in under 2 seconds"> | <performance \| security \| usability \| reliability \| scalability \| maintainability \| compliance> | <...> |

## 7. Business rules

| ID | Rule (holds whatever the screen) | Applies to | On a violation |
|---|---|---|---|
| BR01 | <...> | <FR01, FR03> | <refused with <message \| code from the catalog>> |

## 8. Acceptance criteria

### FR01 - <title>

**AC01 - <title>**
- **Given** <the precondition>
- **When** <the action or event>
- **Then** <the observable outcome>

## 9. Test scenarios

Steps, data and environments stay in the working files; the tables keep the report
scannable. Coverage: a positive per FR, a negative per MUST, a boundary at every limit, a
regression per area at risk.

### Positive
| ID | Requirement | Scenario -> expected result | Severity | Automate |
|---|---|---|---|---|
| TC-P01 | FR01 | <...> -> <observable result> | <CRITICAL \| HIGH \| MEDIUM \| LOW> | <yes \| no> |

### Negative
| ID | Requirement | Scenario -> expected result | Severity | Automate |
|---|---|---|---|---|
| TC-N01 | FR01, BR01 | <...> -> <refused with ...; nothing created> | <...> | <...> |

### Boundary
| ID | Requirement | Boundary under test -> expected result | Severity |
|---|---|---|---|
| TC-B01 | BR01 | <exactly the limit; just above; zero; empty> -> <...> | <...> |

### Regression
| ID | Area at risk | Scenario -> expected result | Severity |
|---|---|---|---|
| TC-R01 | <...> | <behaves exactly as before> | <...> |

**Test data**: <what must exist before the scenarios run, and which scenarios need it>
**Summary**: <N> scenarios, <N> automation candidates.

## 10. Assumptions and dependencies of the analysis

| ID | Assumption or dependency | If false |
|---|---|---|
| AS01 | <...> | <what changes> |
| DEP01 | <system, team, process, release> | <...> |

<greenfield: an assumption the work relies on becomes `A-<NS>n` in the front prompt
(decision-rounds), and this row cites it.>

## 11. Out of scope

- <item> <greenfield: -> its new home (a phase, a front)>

## 12. Open items - greenfield and full

| ID | Item | Blocking | Suggested owner (role only) | Where it is answered |
|---|---|---|---|---|
| OI01 | <...> | <yes \| no> | <the requester \| QA \| the owner> | <greenfield: Q-<NS>n -> <KEY>#n \| full: open> |

## 13. Technical impact - full only

**Complexity**: <LOW | MEDIUM | HIGH | CRITICAL> - <one or two sentences>.

| Discipline | Days |
|---|---|
| <...> | <...> |
| **Total** | <...> |

<Modules, interfaces, data, security, performance, migration and rollback, deployment
strategy; then business and technical risks (probability, impact, mitigation), an indicative
roadmap of at most four phases, and four to six next steps starting with a verb.>

## 14. Hand-over to the Review Brief (frozen <YYYY-MM-DD>) - pack only

Owned from here on by `<ID>_Review_Brief.md` (questions, risks, estimate); not maintained
after this date.

### Business risks
| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|

### Open items and HIGH-impact unknowns
| # | Item | Blocking | Suggested owner (role only) |
|---|---|---|---|
