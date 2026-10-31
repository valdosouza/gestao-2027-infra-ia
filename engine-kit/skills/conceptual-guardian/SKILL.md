---
name: conceptual-guardian
description: Use when a domain object - a table, a shared piece, a module, a business concept, a new pipeline entity - is about to be created, changed or named, or someone asks how to model one ("new table or column?", "what do we call it?"). It validates the concept before any schema or code exists - pieces, not scale models.
---

# Skill: Conceptual guardian (lego pieces, not scale models)

**Scope**: method
**Maturity**: proven
**When to use**: MANDATORY before creating or changing any domain object - a new table, a
shared piece, a module, a new business concept, a new pipeline entity - and before naming
one. It runs inside other flows: the framing of a new product
([`frame-greenfield`](../frame-greenfield/SKILL.md)), the review pack
([`review-pack`](../review-pack/SKILL.md), step 5), a front's guardian opinion
([`front-protocol`](../front-protocol/SKILL.md), section 4), the contract step of a change
([`change-gate`](../change-gate/SKILL.md)), a family of molds
([`mold-factory`](../mold-factory/SKILL.md)) and, in legacy modernization, Phase 2 -
distilling the real concept out of the old system's shell
([`assess-legacy-repo`](../assess-legacy-repo/SKILL.md)). People ask: "how should we model
X?", "is this a new table or a column?", "what do we call it?".
**Not for**: the schema review itself (types, keys, indexes, constraints - the case's schema
rules), deciding (a divergence is a question for
[`decision-rounds`](../decision-rounds/SKILL.md)), or writing the code.
**Real origin**: case zero - the modernization of a legacy business application into a new
product, where the guardian was born: a trio of tables modelling a "partnership" turned out
to be one flat link (the scale-model test, section 3). Its later rounds added the
occupied-words table (one word carried six senses, three of them visible to users, and the
collision showed only when two screens sat side by side in a menu), the patterns of nature
by presence vs process by act and of third-party voice vs our own effect (from an order
branch and from integrations with external parties), the transaction-aware piece, the
composition with one policy, and the rule that a decision with a condition becomes a
delivery check. Case two - a multi-developer product team - ported the guardian, runs it
inside its requirements analysis, its change-request review packs and its legacy-process
analysis, and added the new pipeline entity to the triggers.
**Parts**: the concept checklist, the scale-model test and the triggering fact, the piece
inventory, the naming checklist and the verdict are `proven` (both cases); the
occupied-words table, the four patterns case zero added (section 5) and the
decision-with-a-condition rule are `operating` (case zero, core by choice); the
new-pipeline-entity trigger is `operating` (case two). Technique T20 in the
[register](../../docs/TECHNIQUES.md); labels: [maturity](../../docs/MATURITY.md).
**Works with**: [`decision-rounds`](../decision-rounds/SKILL.md) (a divergence becomes a
question; reusing an occupied word is a decision), [`test-gate`](../test-gate/SKILL.md) and
[`delivery-gates`](../delivery-gates/SKILL.md) (where a condition is checked),
[`retain-knowledge`](../retain-knowledge/SKILL.md) (new pieces and occupied words are
retained).
**Templates**: [`OCCUPIED_WORDS`](../../templates/OCCUPIED_WORDS.template.md).
**Detail**: [references/patterns.md](references/patterns.md) - a worked example of each
pattern case zero added and of a decision with a condition.
**Changelog**: 2026-10-21 - rewritten to the kit's skill shape (wave 4): occupied words,
nature by presence vs process by act, third-party voice vs our own effect, the
transaction-aware piece, the composition with one policy, the decision with a condition, the
new pipeline entity as a trigger; 2026-10-28 - an exit test of the legacy track: a word
decision applied to a base already written is checked by a sweep with declared exceptions
(section 6); its fourth stage: the sweep's pattern covers the word's inflections, and the
row says which forms count (section 6).

---

## The principle (lego / cloud)

A business system is highly complex and branches in infinite ways. That is why it is NOT a
scale model (a glued-together final shape); it is a box of PIECES - each piece carries ONE
stable concept, and each new piece gives more power to the whole.

> **A cloud is always a cloud**: infinite shapes, and anyone who sees one knows what it is.
> A well-conceptualized object keeps its identity in any combination.

**In legacy systems, the scale model is the rule, not the exception**: decades of a system
accumulate the shapes of decisions that have already died. Ask every old structure "which
concept were you trying to express?" - and model THE CONCEPT, not the structure. A new
product meets the scale model too: the previous system the owner knew, another product's
screen, the first draft.

Words used here: a **piece** carries one concept and imports no other piece; a
**composition** only combines pieces; a **triggering fact** is the event of the world an
object originates from; an **occupied word** is a word a concept of the domain already uses;
the **verdict** is the guardian's short written opinion.

## 1. When the guardian runs

| Trigger | Example (fictional) |
|---|---|
| A new table, or a column with a new meaning | `subscription`; a `paused_until` column |
| A shared piece - a function or module several callers use | an address piece, a price calculator |
| A module | a subscriptions module |
| A new business concept | a "premium customer" |
| **A new pipeline entity** - a record, event, status or document a process creates or passes through | a "packed" status, a delivery event, a pick list |
| A name for any of these - table, column, screen, menu entry, parameter | the "Contracts" screen |

The guardian runs **before** any schema or code exists, and again when a later round changes
the concept. A pipeline entity counts as much as a table: a status added "just to track it"
changes what every reader of the process must understand.

## 2. The concept checklist (answer BEFORE modeling)

1. **What is the SINGLE concept of this object?** One sentence, without "and". If it needs
   an "and", it is two pieces.
2. **What does it originate from?** Every business object has a TRIGGERING FACT (the
   receivable originates from invoicing; the ledger entry from the settlement). An object
   that "originates from creating a record", with no triggering fact, is suspicious.
3. **Is it a piece or a composition?** A piece does not import other pieces; a composition
   ONLY combines pieces. Never both.
4. **Does it survive alone and combine without being changed?** A good piece joins a new
   arrangement without gaining a column or a parameter "for case X".
5. **Does any rule exist only to keep the structure from contradicting itself?** Then the
   structure is wrong; redo it until the rule dies by construction.
6. **When the sibling concept appears, does it ADD or does it REFORM?** If it reforms this
   piece, the piece is in the wrong shape today.
7. **Is the name free?** Search the occupied words (section 4).
8. **Does the verdict or the decision carry a condition?** Then it is a delivery check
   (section 6).

## 3. The scale-model test

The real situation (case zero, anonymized): a trio of tables modelled "partnership" as a
named entity with its own structure - a shape inherited from the previous system. The REAL
concept was much simpler: a direct link between two parties with a percentage, triggered by
one party bringing in the other. ONE flat table - and the uniqueness rule the scale model
required ("a party can only be in one live partnership") **died by construction**. When the
modeling needs guards to keep from contradicting itself, be suspicious: it is probably a
scale model.

Symptoms:

- a rule that exists only to keep the structure from contradicting itself;
- an object with no triggering fact ("it exists because someone creates it");
- a column with several meanings, written by several producers;
- an identity by absence ("it is a plain sale because it has no service row");
- a composition that needs a `mode` or `blocks: true/false` parameter to fit a sibling;
- a status that our own code sets for something only a third party can say.

## 4. Occupied words

**A word already taken by a concept of the domain cannot name a new one.** A reused word is
like a column with three meanings: the reader cannot tell which. In case zero one word turned
out to carry six senses, three visible to users, and the collision showed only when two
screens sat side by side in a menu.

- Keep **one table per product** (or per area that never shares screens), from the
  [template](../../templates/OCCUPIED_WORDS.template.md): the word, every sense with where it
  lives, whether users see it, what a similar new concept is called instead, the decision
  that settled it.
- **Before naming** a table, a column, a piece, a screen, a menu entry, a parameter or a
  status, search the table. Occupied: take its "use instead", or another free word.
- A word with several senses is never used alone: **say which** (`bank_account`, never
  `account`).
- Reusing an occupied word is the **owner's decision**, never the guardian's choice; when it
  is accepted on a condition ("the screen title tells them apart"), the condition becomes a
  delivery check (section 6).
- **Rows are added** when a concept is named and whenever a collision is found in code,
  screens or documents.
- **The method's own words count too.** The kit's vocabulary - owner, decision, round,
  release, card - lands in the artifacts' language beside the domain's words; when one
  collides with a domain word (the person who decides vs the person who owns a record), the
  table gets a row and the artifacts say which sense, every time (an exit test found it on
  the legacy track).

## 5. Patterns (seed for the case's piece inventory)

Keep a living table in the knowledge base: **piece or pattern -> single concept -> where it
lives**. Before inventing a new piece, combine the existing ones. Patterns that repeat across
cases:

| Pattern | Single concept |
|---|---|
| Single entity x roles | ONE person or company in the world; N roles per context (customer, supplier, employee) |
| Catalog x value | what is intrinsic to the product x what each customer or instance chooses |
| Central reference | a fact of the world that does not vary per customer (country, bank, currency) |
| Backbone + branches | ONE operation, N natures: a single document with per-type specializations |
| Universal detail + specialization | the generic item x the attributes of the item's nature |
| Immutable history | what has legal or financial value is never deleted - it is reversed with a trail (the reversal references the original) |
| N:N link with attributes | the relationship between two pieces is itself a piece |
| **Nature by presence x process by act** | a branch says what the operation IS (present or not); a process says under which cycle it is (it exists once its act happened) - different producers, different tables |
| **Third-party voice x our own effect** | what an external party said is an append-only event of its own; only that voice changes the state of the exchange; our local effect is applied by the composition, never invented |
| **Transaction-aware piece** | a reusable rule that runs inside the caller's transaction: it receives the transaction and never opens or commits one |
| **Composition with one policy** | a composition holds the policy that must not fork between callers; a sibling that needs a flag to fit stays out |

The last four, with worked examples and their symptoms:
[references/patterns.md](references/patterns.md).

## 6. A decision with a condition becomes a delivery check

When a verdict or a decision accepts something **on a condition** - a name kept "if the
screen title tells them apart", a shared table "as long as every query filters by tenant" -
the condition is written as a check of the delivery, citing the decision's id:

- a **success criterion** of the prompt ([`front-protocol`](../front-protocol/SKILL.md),
  section 11; [`frame-greenfield`](../frame-greenfield/SKILL.md), section 7);
- a line of the **Test plan** or a **probe** ([`test-gate`](../test-gate/SKILL.md);
  [`delivery-gates`](../delivery-gates/SKILL.md), G3), or an item of the owner's walk (G4);
- and the closing does not pass while a condition has no check.

**Applied to a base already written, the check is a sweep with declared exceptions.** A
word decision with a condition ("never the word alone", "always with its qualifier") taken
after documents exist reaches every living document: a search with the pattern the
decision names, each hit outside the exceptions rewritten. The pattern covers **the word's
inflections in the artifact language** - singular and plural, and masculine and feminine
where the language inflects for gender: a decision names a word, the documents carry its
forms. The exceptions are declared with the pattern and **never rewritten**: literal
quotations (an owner's answer, a source's words), file and path names, history lines
(changelog entries, dated history sections, episodic logs) and permanent registers
(decision rows, hypothesis rows, work-log rows).
The word's row of the [occupied-words table](../../templates/OCCUPIED_WORDS.template.md)
keeps the check - the pattern, the forms it counts and the exceptions - so every later
delivery runs the same sweep, and the result is written as "0 outside the exceptions", or
the hits left and why.

The real situation (case zero, anonymized): a decision kept a poor name **in exchange for** a
condition - the screen's label had to tell the two senses apart. The delivery never checked
it; much later the confusion surfaced and looked like a modelling error. Without the check,
the trade is only its expensive half. Worked example:
[references/patterns.md](references/patterns.md#5-a-decision-with-a-condition).

## 7. Naming checklist

- The NAME is the concept, not the shape nor the legacy origin. If the name needs a comment
  to be understood, the name is wrong.
- Role is not entity; catalog is not link is not process - the reader knows which one it is
  from the name and the place.
- The name is free (section 4), or the decision that reuses it is cited.
- Legacy naming NEVER leaks into the new system's visible content (database, screens,
  translations); legacy names appear only in internal mapping documentation.
- Record the case's conventions (language, singular or plural, foreign-key and
  discriminator names, a module mirrored by its route and its screen folder) in a standards
  document - and cite it in every review.

## 8. The verdict

A short opinion, dated, written where the work lives (a front prompt's section 4, a review
brief's concept line, the framing's guardian opinion):

```markdown
**Concept**: <one sentence, no "and">. **Piece or composition**: <...>. **Reused**: <...>.
**Left out**: <... and why>. **Names**: <...> (occupied words checked: <words>).
**Conditions**: <none | <KEY>#n condition -> <its check>>.
```

A conceptual divergence - between the draft, the request or the existing model and the
verdict - **stops the design** and goes to the owner as a question with evidence, closed
options and one recommendation ([`decision-rounds`](../decision-rounds/SKILL.md)). The
guardian never re-models silently, and the owner's decisions are never lost.

## Anti-patterns

- **Keeping the old shape because the old system had it.** The trio of tables needed a rule
  to stop contradicting itself; the concept was one flat link. Ask which concept the
  structure was trying to express.
- **Reusing a word because "everyone knows it".** Six senses of one word met in one menu.
  Search the occupied words first; say which.
- **A condition accepted with no check.** The label never told the senses apart, and the
  confusion came back as if it were a modelling error. Turn the condition into a check.
- **A column with several meanings from several producers.** Nobody can say which producer
  wrote a given row. Split nature from process.
- **Our own code writing the third party's verdict.** An event recorded without a response is
  not the third party's voice. Only the voice changes the state.
- **A composition with a mode flag.** The flag forks the policy between callers. Leave the
  sibling out, or give it its own composition.
- **A status added "just to track it".** It is a new pipeline entity; it gets a verdict like
  a table.

## Checklist before the hand-off

- [ ] The trigger is named: table, piece, module, concept, pipeline entity or name.
- [ ] The concept is one sentence without "and"; its triggering fact is named.
- [ ] Piece or composition - never both; it combines without gaining a column "for case X".
- [ ] No rule exists only to keep the structure consistent; the sibling would add, not reform.
- [ ] Existing pieces and patterns were combined before a new one was invented.
- [ ] Every name was checked against the occupied words; new senses and collisions were added.
- [ ] Every condition of the verdict or of a decision is a delivery check with its id; a word
      decision applied to written documents has its sweep (pattern with the word's forms +
      declared exceptions) in the word's row.
- [ ] The verdict is written where the work lives; a divergence went to the owner as a question.
