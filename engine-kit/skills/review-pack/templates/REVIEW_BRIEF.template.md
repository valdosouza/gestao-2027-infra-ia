# Template: Review Brief

**Scope**: method
**Used by**: [review-pack](../SKILL.md) step 7 (synthesis) and step 13 (round mode).
**Produces**: `<ID>_Review_Brief.md` in the change's folder. Copy the skeleton below, fill
every `<...>`, and set the copy's own Scope line (`case` for a real change).

The brief is written **for the meeting** (whoever decides, prices, schedules, tests and
builds), not for the implementer - that is the
[Dev Context](DEV_CONTEXT.template.md). It is the **only owner** of the ask summary, the
planning-sheet entries, prior art, concept verdict, placement, pipelines and collisions,
reuse, options, estimate, questions, risks, proposed decisions, rounds and tracker texts.
The requirements file hands its risks and open items over once, frozen; the context
points here and never repeats any of it.

## Skeleton

````markdown
---
id: <ID>
title: "<title>"
client: <client or "core">
version: <version>
project: <PROJECT-KEY>
area: <area>
requester: "<tracker Requester field value> (tracker field; role not confirmed unless the people register or the signed document says so)"
pack_date: <YYYY-MM-DD>
meeting_date: "<YYYY-MM-DD or blank>"
sources:
  - "<change document name and signed version>"
  - "<ID>_Requirements.md (<date>)"
  - "<planning sheet title> (<key in the sources register>), tab <tab>, read <date>"
tags: [review-pack, brief, <area-tag>]
---
# <ID> - Review Brief: <title>

**Scope**: <method|case|mixed>

## 0. Rounds
| Round | Date | What happened | Open questions after it |
|---|---|---|---|
| 1 | <YYYY-MM-DD> | pack confirmed and handed over | <n> |

### Round <N> - answers received <YYYY-MM-DD> (from round 2 on; newest block first)
| Q | As published | Answer (verbatim, who as field value, date) | Class | Consequence |
|---|---|---|---|---|
| <n> | <question text> | "<answer>" (<name>, <date>) | answered / partial / open / new | <KEY#N, section changed, still open, follow-up Qm> |

Changed in this round: <sections and what changed>. New questions: <numbers>.

## 1. The ask
<Five lines at most: what the requester wants, why, what changes for users. Cite the
signed document version. Link the requirements file; never list requirements here.>

## 2. What the planning sheets already say
Source: <sheet title> (<key>), tab <tab>, screen or process <name>. Quoted by question
text, never by row number.

| Question as written in the sheet | Answer already given | Our doubt for this change |
|---|---|---|
| "<question>" | <answer> | <the doubt a planner can answer> |

<Or "None found.">

## 3. Prior art
<Exists in <unit/screen>, since <version>; or partial prior art and what it covers; or
"No prior art.">

## 4. Concept
<Concept in one sentence - piece or composition - pieces reused - what was left out. Or
"No new domain object." A divergence is a question (section 10) or a proposed decision
(section 12).>

## 5. Placement
**Proposal: <core | per-client | split>** - <one paragraph: the reason under the case's
placement rule; what changes for every other client if core>.

## 6. Pipelines touched and collisions
| Pipeline | Status | Collides with |
|---|---|---|
| <name and link> | mapped / to map before coding | <open change, lock, partitioned key, import, report, KEY#N> |

## 7. Reuse
<Units, helpers, screens, settings to reuse instead of writing new; or "None identified.">

## 8. Options
| # | Option | What it gives | What it costs or risks |
|---|---|---|---|
| A | <option> (Recommended) | | |
| B | <option> | | |

## 9. Estimate (developer)
**Coding + developer test: <N> days** - confidence <HIGH | MEDIUM | LOW>.

| Item | Days |
|---|---|
| <server / screen / data / developer test> | <n> |

Other roles, for planning, **not part of the developer's figure**: QA <n> - analysis <n>
- configuration <n> - upgrade <n>.
Assumptions: <what would move the estimate>.

## 10. Questions for the requester
Q1. <question> - evidence: <file, document or decision> - options: <a / b>
(Recommended: <a>) - owner: <role, or a name only when the people register or the
signed document confirms the role, or "owner to be assigned at the review"> - if
unanswered: <impact>.
Q2. ...

## 11. Risks
1. <risk> - mitigation: <...>

## 12. Proposed decisions for the meeting
P1. <decision the meeting must take> - recommended: <answer>.
P2. ...

## 13. Tracker texts - prepared for a human, pasted only after the pack owner confirms

### Summary field (four to six short lines)
```text
<one line: what the change does>
Estimate (coding + developer test): <N> days, confidence <level>.
Placement: <core / per-client / split>.
<at most one line, only if something materially moves price, scope or timeline; otherwise omit the line>
Full analysis and decisions: <location in the knowledge base>
```

Round update (round 2 on; add only what is new):
```text
Update <YYYY-MM-DD>: <what changed in estimate, scope or placement, or "no change to estimate or scope">. <n> answers registered, <n> questions open.
```

### Questions field (open questions only)
```text
<n>. <question>
   Answer:
<n>. <question>
   Answer:
```
````

## Rules

- **Two pages at most.** Every section stays; write "None found." rather than dropping
  one.
- **Section 9** quotes only coding + developer test. Other roles' days are shown apart.
- **Sections 10 and 12**: every item carries one recommendation; the meeting decides.
  Question numbers continue across rounds and are never reused; proposed decisions use
  `P`, registered decisions use `KEY#N`.
- **Round mode**: answers are quoted verbatim in section 0 and in the decision register,
  never paraphrased; an answer that departs from the recommendation is marked as a
  divergence. Answered questions keep their number and point to their decision
  (`Q1 -> ORD#14`) in section 10 only. Sections 1-12 are updated in place; section 0 keeps
  the history.
- **Section 13 is a rendering, rebuilt, never edited on its own**: the summary comes from
  sections 1, 5 and 9; the questions field from the open items of section 10.
  - Audience: whoever **prices and schedules** the work - time and effort, fast. Only what
    changes price, scope or timeline; the reasoning stays in the brief, referenced by its
    location, never repeated.
  - Plain text with numbered lists (tracker rich-text fields rarely render markdown
    tables); no id, title or date header - the text lives inside the item, whose history
    keeps the date.
  - The questions field carries **only open questions**, each with an empty `Answer:`
    line; with none open, the single line "No open questions."
  - On a round, the summary gains one `Update` line and never retells the change.
- **People are not roles**: the header carries no role field for a named person; a name
  appears only as a field value or with a confirmed role source.
- **Planning-sheet entries** are cited by sheet title (and key), tab and the question text
  as written, never by row number; each ends with the doubt a planner can answer.
