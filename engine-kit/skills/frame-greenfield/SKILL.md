---
name: frame-greenfield
description: Use when a new product, module or phase starts from a draft (loose notes, an owner's master prompt, a pasted schema, a brief) and must become a closed prompt a front can start from - organised as it is, unclear points marked, Round 0 run, requirements taken from the document, never from code.
---

# Skill: Frame a greenfield project (a draft becomes a closed prompt)

**Scope**: method
**Maturity**: operating
**When to use**: a new product, module or phase begins with a draft and nothing is built
yet - the entry of the greenfield track ([profile](../../profiles/greenfield.md)). The
draft can be loose notes, a master prompt the owner wrote, a pasted schema, a brief, a
meeting transcript. Also when a large draft lands in the middle of a front and must be
absorbed without losing a line. People say: "turn my notes into a plan", "organise this
draft", "what is missing here?", "write the requirements of the new module".
**Not for**: a change request to an existing product - [`review-pack`](../review-pack/SKILL.md)
runs the same requirements procedure in its pack profile; an existing system that must be
understood first - [`assess-legacy-repo`](../assess-legacy-repo/SKILL.md); numbering and
recording questions, decisions, assumptions and the release word -
[`decision-rounds`](../decision-rounds/SKILL.md), used here and never repeated; running the
front once its prompt is closed - [`front-protocol`](../front-protocol/SKILL.md).
**Real origin**: case zero - the modernization of a legacy business application, whose new
product was framed phase by phase: a draft of about 540 lines became, in a few short
asynchronous rounds, a closed phase prompt with 21 numbered decisions, validated schema
scripts and refactored code with tests; later phases and fronts were framed the same way,
and a messages-and-validation framework was framed and settled in one round of eight owner
decisions (T19). Case two - a multi-developer product team - organised its drafts with the
same rounds (the second case of T17) and ran a six-role requirements analysis on about
fourteen change-request documents (T18). The rules below are what both cases corrected.
**Parts**: three techniques with their own labels - [Parts and maturity](#parts-and-maturity).
The skill carries the label of its weakest core part.
**Works with**: [`decision-rounds`](../decision-rounds/SKILL.md) (Round 0 and every round),
[`conceptual-guardian`](../conceptual-guardian/SKILL.md) (every domain object and every name
the draft introduces), [`front-protocol`](../front-protocol/SKILL.md) (the closed prompt
opens the front), [`review-pack`](../review-pack/SKILL.md) (the same requirements procedure
for a change request), [`test-gate`](../test-gate/SKILL.md) (the scenarios feed each
change's Test plan), [`kb-setup`](../kb-setup/SKILL.md) (where the files go),
[`retain-knowledge`](../retain-knowledge/SKILL.md) (the frozen draft to HISTORY at the front's close).
**Templates**: [`FRONT_PROMPT`](../../templates/FRONT_PROMPT.template.md) (the organised
draft and the closed prompt), [`REQUIREMENTS`](../../templates/REQUIREMENTS.template.md),
[`OCCUPIED_WORDS`](../../templates/OCCUPIED_WORDS.template.md),
[`DECISIONS`](../../templates/DECISIONS.template.md).
**Detail**: [references/organise-the-draft.md](references/organise-the-draft.md) (a worked
draft: warning marks, questions, the disposition table);
[references/requirements.md](references/requirements.md) (the six roles, the three profiles,
the quality gates); [references/validation-message-decision.md](references/validation-message-decision.md)
(the T19 pattern and its checklists).
**Changelog**: 2026-10-21 - first version (wave 4): the draft-organising procedure of T17,
the requirements pipeline of T18 (its shared home; review-pack runs the pack profile), T19 as
an optional product pattern. 2026-10-22 - from a greenfield exit test: the first question
set is Round 0; the requirements run after its answers (before them, only the input note);
facts requested from the owner (`R-SUB1`) have their own section. 2026-10-27 - from the
same exit test, stage 2: later rounds get their own subsections of section 7; the
recommendations are cross-checked before a round goes out; a wave goes through the change
gate as its work item. Then ([EK#26](../../DECISIONS.md)): the closing round carries the
move to level 2 and the first wave's plan, its go asked on a line of its own (section 3).
2026-10-27 - from the same exit test, stage 3: before the closing round goes out, the
recommendations' combined consequences and a go-live list (section 3); one moment for the
frozen draft - `HISTORY/` at the front's close, the original moved by the owner (sections 1
and 7).

---

## The principle

A draft is the owner's thinking in the order it came, not a specification. Three things go
wrong when an agent "cleans it up": a choice is made silently while the text is being
fixed, a line that looked like noise disappears with the requirement it held, and the owner
stops recognising their own words. The framing follows four rules:

1. **Organise, never correct.** The draft is moved into a standard structure in the owner's
   words; what is unclear, contradictory or missing gets a warning mark at the exact spot
   and a numbered question. The owner decides ([`decision-rounds`](../decision-rounds/SKILL.md)).
2. **Nothing is lost.** Every item of the draft ends in one of five places: a decision, a
   question, an assumption, an out-of-scope note with its new home, or the closed prompt.
   The disposition table proves it, item by item.
3. **Requirements come from the document.** Functional and non-functional requirements,
   business rules, Given-When-Then criteria and test scenarios are read from the organised
   draft and the decisions - never from code, a prototype or a similar product.
4. **The prompt is closed when nothing waits.** No pending question, no assumption to
   ratify, no draft item without a destination, no blocking open item. Then a front starts
   from it, and the code cites the decision ids.

Words used here:

| Word | Meaning |
|---|---|
| Draft | the owner's text as received; frozen, never edited |
| Draft item | one non-blank line of the frozen draft, named by its line number: `L12` (a paragraph may be disposed as one row, `L12-L15`) |
| Organised draft | the draft moved into the prompt structure, the owner's words kept, warning marks added |
| Warning mark | `(!) Q-SUB4` right after the sentence it concerns; the question id says where it is answered |
| Disposition | the destination of a draft item ([section 6](#6-the-residue-sweep---nothing-of-the-draft-is-lost)) |
| Closed prompt | the organised draft with every round applied and nothing waiting; what a front starts from |

Example used throughout (fictional): **Acme Subscriptions** - a new module of the acme
product that lets a customer subscribe to recurring deliveries of a box; namespace `SUB`.

## Parts and maturity

| Part | Technique | Maturity | Evidence and limits |
|---|---|---|---|
| Organise the draft as it is: warning marks, fact vs intent, the disposition sweep, decision ids cited in the code (sections 1-3, 6, 7) | T17 | `proven` | case zero framed its new product's phases and fronts this way; case two organises its drafts with the same rounds |
| Requirements pipeline: six roles, three profiles, one requirements file (section 4) | T18 | `operating` | case two, about fourteen change-request documents; core by choice. The `greenfield` profile runs the same roles on a product draft - its first run on one is its evidence |
| Validation vs message vs decision (section 5) | T19 | `candidate` | case zero, every screen and endpoint of one product; optional - a product with screens and an API opts in by a decision |

Labels: [maturity](../../docs/MATURITY.md); register: [techniques](../../docs/TECHNIQUES.md).

## The track

```
draft, as received -> frozen beside the prompt, items L1..Ln              section 1
   |
   v
organised draft: prompt structure, warning marks, fact vs intent,         section 2
   guardian verdicts, occupied words checked
   |
   v
Round 0, then rounds 1..N (decision-rounds)                               section 3
   |                     ^
   v                     | open items and HIGH unknowns become questions
requirements from the document: FR, NFR, BR, AC, TC-P/N/B/R               section 4
   (+ validation, message and decision - optional)                        section 5
   |
   v
residue sweep: every draft item has a destination; old names searched     section 6
   |
   v
closed prompt -> the front's waves start (front-protocol); code cites SUB#n  section 7
```

## 1. Keep the draft

1. Copy the owner's draft byte-identical (copy the file, never paste its text) to
   `prompts/prompt_<front>-draft.md` ([`kb-setup`](../kb-setup/SKILL.md)) and record its
   SHA-256 in the prompt's header; the original is the owner's to move, whenever they
   choose (the close script recognises it while it is byte-identical to the copy). The copy
   is **never edited** (a frozen source for the [`scope-census`](../scope-census/SKILL.md));
   its line numbers are the item ids. It stays beside the prompt until the front's close,
   then goes to `HISTORY/` (section 7) - not when the prompt closes. A second draft from the
   owner is a second frozen file (`-draft-2.md`, items `2:L12`).
2. Read it whole once before moving anything: the owner's vocabulary, the parts that repeat,
   the parts that contradict each other.
3. Name the namespace ([`decision-rounds`](../decision-rounds/SKILL.md), Round 0 step 0)
   and check what is already decided in its register and in the registers it inherits from:
   a draft often re-raises a settled point.

## 2. Organise it as it is (T17)

### 2.1 The structure

The organised draft follows the phase-prompt order of
[`decision-rounds`](../decision-rounds/SKILL.md) - Context, Objectives, Workflow, Grouped
specifications, Success criteria. A new product runs over several sessions, so the
organised draft is usually the **front prompt itself**, opened from
[`FRONT_PROMPT`](../../templates/FRONT_PROMPT.template.md):

| What the draft holds | Front prompt section |
|---|---|
| The ask: why the product exists, who asked | 1 The ask - the owner's key sentences quoted, the frozen draft linked |
| Statements about systems the product joins, official sources it relies on - checked | 2 Facts (evidence); objective defects as `C1`... |
| Facts only the owner has - a date, the machine it runs on, a file not handed over | 2.3 Facts requested from the owner (`R-SUB1`...) |
| The draft items and their destinations | 3 Inventory: the disposition table (the `-inventory.md` annex when long) |
| Domain objects the draft introduces | 4 Guardian opinion |
| Objectives, workflow, grouped specifications | 5 Design and waves |
| The owner's "never" | 6 Negative knowledge |
| Warning marks | 7 Questions - round 0; who owns the decisions and the release word, when no workspace round asked them, in block 7.1; later rounds in their own subsections (7.2, 7.3...) |
| "Later", "not now", "phase 2" | 10 Out of scope, each with its new home |
| Success criteria | 11 Success criteria, numbered and testable |
| Requirements (section 4) | annex `prompt_<front>-requirements.md`, cited by id |

A phase small enough for one session uses the final prompt structure of
[`decision-rounds`](../decision-rounds/SKILL.md) instead; the rules are the same.

**Move, never rewrite.** A sentence keeps the owner's words and cites its item
(`... monthly only (L3)`); headings may be added and the order changes; a repeated idea is
kept once and the other item points to it (`L40 = L12`). **Re-read the file before every
edit** - the owner answers by editing it between rounds.

### 2.2 Warning marks

| Kind | In the draft | Becomes |
|---|---|---|
| Unclear | one sentence, two readings ("they can pause": skip one delivery, or stop until resumed?) | a question |
| Contradictory | two items disagree (L3 "monthly only", L7 "weekly boxes") | a question citing both items |
| Missing | a flow with no end, a state with no exit, a field with no source, a rule with no owner | a question, or an open item of the requirements |
| A choice | valid alternatives (charge at subscription or at each delivery) | a question with closed options and one recommendation |
| Objective defect | one correct fix (a field listed twice, a total that cannot add up) | corrected and listed as `C1` with its reason - never a question |
| Already decided | the draft re-raises what a register holds | answered with the id (`SUB#3`) - never asked again |

The mark is `(!) Q-SUB4`, placed right after the sentence; it stays until the round that
answers it, then gives way to the decision id. Questions follow the decision-rounds format:
problem, evidence (the draft items, a fact), closed options, **one recommendation**.

### 2.3 Fact vs intent

Split every problem before asking (decision-rounds, Round 0 step 0). A greenfield has little
code, but it has facts: the systems the product must join (read them, read-only), the
official sources it relies on ([`official-source-archive`](../official-source-archive/SKILL.md)),
and the draft itself - that two items disagree is a fact; which one holds is intent. Many
facts of a greenfield exist only in the owner's head - the date it must be ready, the
machine it runs on, the spreadsheet in use today: they are **facts requested from the
owner** (`R-SUB1`, front prompt section 2.3), asked beside Round 0 with no options, and
their answers are recorded as facts - except a claim about what an existing system does,
which stays a hypothesis until that system is read
([`decision-rounds`](../decision-rounds/SKILL.md#recording-the-owners-answer)). Only intent
becomes a question.

### 2.4 Concepts and names

Every domain object the draft introduces - a table, a shared piece, a business concept, a
pipeline entity - gets a [`conceptual-guardian`](../conceptual-guardian/SKILL.md) verdict
before a round asks about its shape. Every new name is checked against the occupied-words
table ([template](../../templates/OCCUPIED_WORDS.template.md)). A divergence between the
draft's model and the verdict is a question; the guardian never re-models silently.

Worked example of sections 1 and 2: [references/organise-the-draft.md](references/organise-the-draft.md).

## 3. Round 0 and the rounds

Run [`decision-rounds`](../decision-rounds/SKILL.md) as it is: Round 0 on the organised
draft, then rounds 1..N - literal answers, decisions `SUB#n` in the home register,
assumptions `A-SUBn` when the work cannot wait, the index regenerated after every round.
What framing adds to each round:

- **The disposition table follows the round**: an item whose question was answered now
  points to the decision (`L3 -> SUB#1`); the warning mark in the organised draft gives way
  to the decision id.
- **The requirements run after the owner's answers to Round 0** - the answers fix what is
  in and what is out; run earlier, they describe options instead of a product. Before those
  answers only the requirements' input note is written
  ([references/requirements.md](references/requirements.md), Input); the `REQUIREMENTS`
  template is copied after them. An answer that leaves the scope open keeps them waiting for
  the round that settles it. Their open items and HIGH unknowns become the next round's
  questions; one that is already a question points to it (`OI02 -> Q-SUB3`) and is never
  asked twice.
- **A decision accepted with a condition** ("keep the name if the screen title tells them
  apart") is written as a success criterion that cites it
  ([`conceptual-guardian`](../conceptual-guardian/SKILL.md), section 6).
- **The closing round carries the first wave's plan** ([EK#26](../../DECISIONS.md)). When
  the convergence check (decision-rounds, Every round step 5, with the counts of section 6)
  shows that the next round closes the prompt, first read the recommendations' **combined
  consequences** and walk the **go-live list** of each wave it settles - recovery of
  access, data at rest and backups, open items carried over from the old practice, who
  operates it ([`decision-rounds`](../decision-rounds/SKILL.md#the-closing-round-carries-the-first-plan-ek26));
  a gap found only after the round went out reopens it. Then prepare in the same batch: the
  move to level 2 when the case is at level 1 (or, decided already, its line in the plan:
  in effect when this round closes the prompt), and the plan of the first wave of section 5 - written through
  [`change-gate`](../change-gate/SKILL.md#a-greenfield-wave-no-tracker-no-flow-to-map-no-area-yet)
  steps 0 to 3 on the requirements and on the round's recommended answers, listed as its
  premises - with the go on that plan asked on a line of its own. How the answer is read:
  [`decision-rounds`](../decision-rounds/SKILL.md#the-closing-round-carries-the-first-plan-ek26).
  On this track that round comes after Round 0, since the plan stands on the requirements;
  when Round 0's answers leave nothing to ask, the move and the plan go out together.

## 4. Requirements from the document (T18)

Procedure: [references/requirements.md](references/requirements.md), profile `greenfield`.
In short:

- **Input**: the organised draft, the decisions so far, the guardian verdicts. Not code, not
  a prototype, not another product's screens - they describe an implementation and get
  written down as if they had been asked for.
- **Roles**: document intake, business analysis, requirements engineering, test design,
  synthesis. No solution architecture and no estimate: the design lives in the prompt and
  is decided in rounds.
- **Output**: `prompts/prompt_<front>-requirements.md` from the
  [`REQUIREMENTS`](../../templates/REQUIREMENTS.template.md) template - functional (`FR`,
  MoSCoW), non-functional (`NFR`, measurable), business rules (`BR`), acceptance criteria
  (`AC`, Given-When-Then, at least one per FR), scenarios (`TC-P` per FR, `TC-N` per MUST,
  `TC-B` at every limit, `TC-R` per area at risk), out of scope, open items (`OI`).
- **Traceability**: each FR cites its source - a draft item (`L12`) or a decision
  (`SUB#3`); the disposition table records it (`L12 -> FR04`).
- **One owner**: the requirements file owns FR, NFR, BR, AC and TC; the prompt cites their
  ids and never restates them.
- **Revision**: until the prompt closes, a decision that changes a requirement revises its
  row and keeps the id ("revised by SUB#9"); a dropped one stays, "withdrawn (SUB#9)"; ids
  are never reused. At closing the file is frozen as the product's baseline; later changes
  arrive as change requests, each with its own requirements file
  ([`review-pack`](../review-pack/SKILL.md), pack profile).

## 5. Validation, message and decision (T19 - candidate, optional)

For a product with screens and an API, adopted by a decision in Round 0 (`SUB#n - the
product follows validation, message and decision`). The idea in three lines: **validation
judges** data against a rule; **a message communicates** an outcome, with the channel chosen
by severity in one place; **a decision asks** and returns a typed choice. A screen never
speaks on its own. One error envelope, `{error, code, ref, fields[]}`, and one catalog of
error codes that is the source - the table of codes is generated from it.

In the framing it shows up as: business rules that name their violation (`BR02 -> code
CANCEL_AFTER_PACKED`), non-functional requirements for the channel per severity and "one
pending item at a time", negative scenarios that assert the code and the fields rather than
a wording, and a conformance row per screen at delivery. Detail and checklists:
[references/validation-message-decision.md](references/validation-message-decision.md).

## 6. The residue sweep - nothing of the draft is lost

Two sweeps, after every round and before closing.

**The disposition sweep.** Every draft item has one destination:

| Destination | Written | Allowed when the prompt closes? |
|---|---|---|
| A decision | `SUB#7` | yes |
| The closed prompt, kept as specification | `prompt 5.2` | yes |
| A requirement | `FR04`, `BR02`, `NFR01` | yes |
| Out of scope, with its new home | `out -> phase 2`, `out -> front XY` | yes |
| The same as another item | `= L12` | yes |
| An objective defect, corrected | `C1` | yes |
| A question | `Q-SUB4` | no - answered first |
| An assumption | `A-SUB2` | no - ratified or overturned first |
| Nothing | | never |

At every save, count: items, items with a destination, items waiting for the owner
(question or assumption). The count goes in the front's State line.

**The naming sweep.** After any rename or removal, search the text for the old name, the
removed field, the dropped flow - in the prompt, the requirements, seeds, scripts and
comments; fix every hit or say why it stays ([`decision-rounds`](../decision-rounds/SKILL.md)).

## 7. The closed prompt

The prompt is closed when:

- pending questions: none; no assumption left to ratify; no fact requested left unanswered;
- the disposition table has no item waiting and none blank;
- the requirements have no blocking open item, every FR has an AC, and the scenarios cover
  what section 4 asks;
- every guardian divergence is decided, and every decision taken with a condition has its
  success criterion;
- the success criteria are numbered, testable and cite their ids (`SUB#n`, `FRn`).

Then:

1. The State line says "framing closed <date> - wave 0 may start"; the front continues
   with its waves ([`front-protocol`](../front-protocol/SKILL.md), "Lifecycle of a front"),
   each change of a wave through [`change-gate`](../change-gate/SKILL.md#a-greenfield-wave-no-tracker-no-flow-to-map-no-area-yet)
   with the wave as its work item. The first wave's plan rode in the closing round
   (section 3): with its go logged, that wave starts at the gate's single pass (step 5);
   a plan rewritten after a divergence goes back to the gate first.
2. Deliverables cite the qualified ids in comments (`-- SUB#7`, `// SUB#3`), are validated
   by a program (parser, compiler, tests) before delivery, and leave the working copy only
   with the owner's release word ([`decision-rounds`](../decision-rounds/SKILL.md)).
3. At the front's close - not when the prompt closes - the frozen copy goes to `HISTORY/`
   with a pointer to the closed prompt (the owner's original is theirs to move whenever they
   choose), and new patterns - occupied words, pieces, negative knowledge - go through
   [`retain-knowledge`](../retain-knowledge/SKILL.md).

## Anti-patterns

- **Correcting the draft silently.** The agent's choice hides inside a cleaner sentence and
  nobody sees it was a choice. Move the words; a choice is a question; only an objective
  defect is corrected, and it is listed.
- **Deferring by deleting.** "Not now" items disappear with their requirement. Out of scope
  is a destination with a new home, never a deletion.
- **Editing a stale copy.** The owner answers by editing the file between rounds; an edit
  made without re-reading overwrites the answers. Re-read before every edit.
- **Renaming without a sweep.** Old names, removed columns and orphan references survive in
  seed scripts and comments - the residues case zero's rounds searched for after every
  rename. Search the old names after every rename.
- **Asking what the evidence answers.** In a large case, half of the "questions to the
  owner" were facts that reading answered. Split fact from intent first.
- **A question without a recommendation.** In a real round, the only answer that diverged was
  the question asked without one.
- **Requirements read from an implementation.** They describe what was built, not what was
  asked. Read the document only.
- **Two owners of one content.** In case two, one folder ended with two estimates. The
  requirements file owns the requirements; the prompt owns decisions and design; each cites
  the other by id.
- **A condition with no check.** A name was kept "if the screen title tells them apart"; the
  title never did, and the confusion came back later looking like a modelling error. The
  condition is a success criterion.
- **A bare "decision 14" in the code.** Ambiguous as soon as a second register exists. Cite
  `SUB#14`.

## Checklist before the hand-off

- [ ] The draft is frozen beside the prompt; its items are its line numbers.
- [ ] The namespace is named; decisions already recorded were checked first.
- [ ] The organised draft keeps the owner's words; every warning mark carries a question id.
- [ ] Fact split from intent; objective defects corrected and listed (`C1`...), not asked.
- [ ] Every question has evidence, closed options and one recommendation; the round's recommendations were read together and against the recorded decisions - no two contradict, and their combined consequences are asked; before the closing round, the go-live list was walked.
- [ ] Every domain object has a guardian verdict; every new name was checked against the occupied words.
- [ ] The requirements come from the document; every FR has an AC and its source; the scenarios cover positive, negative, boundary and regression; every open item is a question or a decision.
- [ ] The disposition table: no item waiting, none blank; the old names searched.
- [ ] Pending questions none; assumptions ratified; out of scope with homes; conditions turned into success criteria.
- [ ] The closing round carried the move to level 2 (at level 1) and the first wave's plan with its premises; the plan's go was asked on its own line, never read from the answers.
- [ ] Nothing committed, published or deployed without the owner's release word.
