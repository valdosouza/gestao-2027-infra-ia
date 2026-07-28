---
name: conceptual-guardian
description: Validates the CONCEPT before any DDL or code exists. MANDATORY before creating or changing any DOMAIN OBJECT — new table, shared piece, module, or new business concept. In legacy modernization this is Phase 2 — distilling the real business concept out of the old system's shell.
---

# Skill: Conceptual Guardian (lego pieces, not scale models)

**When to use**: MANDATORY before creating or changing any DOMAIN OBJECT — a new
table, a shared piece, a module, a new business concept. This skill validates the
CONCEPT before any DDL/code exists. In legacy modernization it is Phase 2: distilling
the real business concept out of the old system's shell.
**Scope**: method

---

## The principle (lego / cloud)

A business system is highly complex and branches in infinite ways. That is why it is
NOT a scale model (a glued-together final shape); it is a box of PIECES — each piece
carries ONE stable concept, and each new piece gives more power to the whole.

> **A cloud is always a cloud**: infinite shapes, and anyone who sees one knows what
> it is. A well-conceptualized object keeps its identity in any combination.

**The scale-model test** (real situation from case zero, anonymized): a trio of tables
modeled "partnership" as a named entity with its own structure — a shape inherited
from the previous system. The REAL concept was much simpler (a direct link between two
parties with a percentage): ONE flat table — and the uniqueness rule the scale model
required ("a party can only be in 1 live partnership") **died by construction**. When
the modeling needs guards to keep from contradicting itself, be suspicious: it is
probably a scale model.

**In legacy systems, the scale model is the rule, not the exception**: 30 years of a
system accumulate the shapes of decisions that have already died. The job of Phase 2
is to ask every old structure: "which concept were you trying to express?" — and to
model THE CONCEPT, not the structure.

## Concept checklist (answer BEFORE modeling)

1. **What is the SINGLE concept of this object?** One sentence, without "and". If it
   needs an "and", it is two pieces.
2. **What does it originate from?** Every business object has a TRIGGERING FACT (the
   receivable originates from invoicing; the ledger entry originates from settlement).
   An object that "originates from creating a record", with no triggering fact, is
   suspicious.
3. **Is it a piece or a composition?** Piece: does not import other pieces.
   Composition: ONLY combines pieces. Never both.
4. **Does it survive alone and combine without being changed?** A good piece joins a
   new arrangement without gaining a column/parameter "for case X".
5. **Does any application rule exist only to keep the structure from contradicting
   itself?** → the structure is wrong; redo it until the rule dies by construction.
6. **When the sibling concept appears, does it ADD or does it REFORM?** If the answer
   is reforming this piece, the piece is in the wrong shape today.

## Piece inventory (build YOUR case's own)

Keep a living table in the knowledge base: **piece/pattern → single concept → where it
lives**. Before inventing a new piece, combine the existing ones. Patterns that repeat
across cases (seed for the new case's inventory):

| Pattern | Single concept |
|---|---|
| Single entity × roles | ONE person/company in the world; N roles per context (customer, supplier, employee) |
| Catalog × value | What is intrinsic to the product × what is each customer's/instance's choice |
| Central reference | A fact of the world that does not vary per customer (country, bank, tax code) |
| Backbone + branches | ONE operation, N natures (a single document with per-type specializations) |
| Universal detail + specialization | Generic item × attributes of the item's nature |
| Immutable history | What has legal/financial value is never deleted — it is reversed with a trail (the reversal event references the original) |
| N:N link with attributes | The relationship between two pieces is itself a piece (with its own attributes) |

## Naming checklist

- The NAME is the concept, not the shape nor the legacy origin. If the name needs a
  comment to be understood, the name is wrong.
- Role ≠ entity; catalog ≠ link ≠ process — the reader knows which one it is from the
  name/place.
- Legacy naming NEVER leaks into the new system's visible content (database, screens,
  i18n); legacy names appear only in internal mapping documentation.
- Record the case's conventions (prefixes, language, singular/plural, FKs,
  discriminators) in a standards doc — and cite it in every review.

## Expected output

A short opinion: **concept** (1 sentence) · **piece or composition** · **pieces
reused** · **what was left out** (and why) · **names**. Conceptual divergence = stop
and discuss with the product owner (their decisions are never lost — see the
`decision-rounds` skill).
