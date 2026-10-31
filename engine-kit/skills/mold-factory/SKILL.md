---
name: mold-factory
description: Use when a family of similar pieces (endpoints, modules, screens, data-access units) must be built or rebuilt and two of them can be written by hand first - the two hand-written pieces become molds, and parallel agents generate the rest from the mold, the real schema and a short list of non-negotiable rules. Schema first, never a translation of the legacy code; the conductor verifies every piece on disk and owns the shared files.
---

# Skill: Mold factory (two pieces by hand, the rest from the mold and the real schema)

**Scope**: method
**Maturity**: operating
**When to use**: a family of pieces that share a shape - the import endpoints of a bridge
service, the modules of a back end, the register screens of an application, the
data-access units of a set of tables - must be written or rewritten, there are enough of
them that writing each by hand is the bottleneck (in practice four or more), and the real
schema they work on can be read. Also when a family already exists and a new member is
added: it is generated from the family's molds, not written from a blank page.
**Not for**: a one-off piece (write it through [`change-gate`](../change-gate/SKILL.md));
deciding what the family is (the concept passes
[`conceptual-guardian`](../conceptual-guardian/SKILL.md) first); pieces that differ more in
behaviour than in data (a mold carries structure, not business rules - see
[When a mold does not fit](#when-a-mold-does-not-fit)); porting legacy code line by line,
which is what this skill replaces.
**Real origin**: case zero - the modernization of a legacy business application. In one
day the service that receives the legacy system's data was rewritten in six waves: two
endpoints written by hand became the molds, parallel agents generated eight more from
them, then nine. **Every agent found the legacy code it replaced broken against the real
schema** (it read columns that no longer existed): rewriting guided by the schema beat
translating the old code. The same case built its screens the same way for months - a
reference screen distilled into a written visual contract and a shared factory of search
and form pages, each new screen copied from the nearest mold module (a simple one, one
with a foreign-key lookup, one with a many-to-many list) by a dedicated builder agent,
two builders at a time. Its corrections are the rules below: a builder that ended without a
report (twice), parallel agents numbering their questions alike, shared files edited by
two builders at once.
**Parts**: T73 `operating` - one case, core by choice
([maturity](../../docs/MATURITY.md), [register](../../docs/TECHNIQUES.md)).
**Works with**: [`conceptual-guardian`](../conceptual-guardian/SKILL.md) (the family's
concept before the molds), [`change-gate`](../change-gate/SKILL.md) (the molds are gated
like any change; prepare-only), [`decision-rounds`](../decision-rounds/SKILL.md) (every
choice made while writing a mold; the agents' questions, renumbered),
[`test-gate`](../test-gate/SKILL.md) (each piece's tests, the suite gate after
integration), [`fences`](../fences/SKILL.md) (rules a script can check),
[`front-protocol`](../front-protocol/SKILL.md) (the wave block, one writer per file, the
ownership partition), [`delivery-gates`](../delivery-gates/SKILL.md), the
[`build-analyst`](../../agents/build-analyst.md) and
[`docs-writer`](../../agents/docs-writer.md) agents.
**Detail**: [references/mold-card.md](references/mold-card.md) (what a mold card holds,
with an example) and [references/agent-brief.md](references/agent-brief.md) (the agent
brief, the agent report, the conductor's verification sheet).
**Changelog**: 2026-10-21 - first version (wave 2), from case zero's bridge-service
rewrite and its screen factory.

---

## The principle

Two hand-written pieces carry the decisions; the rest is generation under constraints. A
generated piece is only as good as its three inputs:

1. **The mold** - the shape: files, layering, naming, the error envelope, validation,
   transactions, tests. Written by hand, gated, verified end to end.
2. **The real schema** - read from the live database (a read-only session) or the
   project's canonical schema file, never from the legacy code's queries. The legacy code
   says what the old system *did*; the schema says what *exists*.
3. **The non-negotiable rules** - a short numbered list that every agent applies and
   reports on, one by one.

> **Rewrite from the schema; never translate the old code.** The old code encodes its own
> drift - columns renamed or dropped, joins that no longer hold. Translating it carries the
> drift into the new system; writing from the schema exposes it.

**Why two molds and not one.** One hand-written piece mixes the family's pattern with its
own accidents; two that differ along the family's main axis of variation (the simplest
member, and one with a relationship) show the agent which parts are pattern and which are
variation. A family with another axis (a tree, a child list, a computed total) gets a mold
for it: molds cover the axes of variation, not a count.

Words used here: a **piece** is one member of the family; a **mold** is a piece written by
hand and promoted to reference; the **conductor** is the session that runs the factory -
it writes the molds, the briefs and the shared files, and verifies; an **agent** generates
pieces from a brief.

## The factory in one picture

```
1 inventory   every piece: its schema objects, its variation tags, its legacy counterpart
2 molds       one piece per axis of variation, written by hand, gated, verified end to end
3 mold cards  per mold: files, variation points, invariants, tests, known gaps
4 rules       the non-negotiable list: numbered, one line each, checkable
5 briefs      one per agent: molds + schema extract + rules + its pieces + its file set
6 generate    parallel agents on disjoint file sets; shared files stay with the conductor
7 verify      on disk, piece by piece: files, build, tests, rules, schema, diff to the mold
8 integrate   shared files, renumbered questions, mold fixes propagated, the suite
9 retain      schema findings, mold corrections, new rules
```

## 1. Inventory the family

- List every piece. For each: the schema objects it reads and writes, its **variation
  tags** (simple record, parent reference, child list, tree, computed field...), and its
  legacy counterpart if there is one - read for *behaviour* only.
- **Read the real schema first**: columns, types, nullability, keys, constraints of every
  object in the family. Write the extract once; every brief quotes it.
- **Diff the legacy code against the schema while inventorying** - it is cheap and
  decisive: every column the old code reads that does not exist, every column that exists
  and the old code ignores, every constraint it would violate. In case zero this list was
  not empty for a single piece.
- Group the pieces by variation; choose one mold per axis.
- The family's concept (a new table, a new shared piece, a new kind of endpoint) passes
  [`conceptual-guardian`](../conceptual-guardian/SKILL.md) before any mold is written.

## 2. Write the molds by hand

- Each mold is a **real member of the family**, delivered like any change: plan or test
  first, the owner's go, single pass ([`change-gate`](../change-gate/SKILL.md)); tests
  green, build clean, documented. Never a demo, never a stub.
- The mold is where the family's open points are settled: layout, naming, the error
  envelope, validation, how a relationship is loaded, paging, soft delete, logging. **Each
  choice is a numbered decision or a rule** ([`decision-rounds`](../decision-rounds/SKILL.md)),
  never a silent habit an agent has to guess from the code.
- **Verify end to end** against the real application and the real schema before the
  first brief. An unverified mold multiplies its defect by the size of the family.

## 3. The mold card

Each mold gets a short card next to the plan (the front prompt or the plan artifact):

| Part | Holds |
|---|---|
| Files | every file of the mold, with what it holds |
| Variation points | what an agent changes, and how: names, columns, the relationship block, the child list |
| Invariants | what never changes: the envelope, the guard order, the transaction shape, the test skeleton |
| Tests | the mold's tests, and the equivalent each generated piece must have |
| Known gaps | what the mold does not show (no computed field, no tree) - a piece that needs it raises a question |
| Corrections | dated: every defect later found in the mold and fixed in all its pieces |

Template and a worked example: [references/mold-card.md](references/mold-card.md).

## 4. The non-negotiable rules

Numbered, one line each, and **checkable** - a reviewer or a script can answer yes or no.
A neutral starting set:

1. A column exists only if the schema extract lists it.
2. Write from the mold and the schema; the legacy code is read for behaviour, never ported.
3. Same error envelope, validation and transaction shape as the mold.
4. A piece never imports another piece; shared code is added only by the conductor.
5. Every list is paged the way the mold pages.
6. Nothing silenced: no empty catch, no guard that hides a symptom (anti-patch, T34).
7. Each piece ships with tests equivalent to the mold's, run green.
8. Anything the mold does not show is a question in the report, never an invention.
9. Write only the files of your file set; list what you need in a shared file.

- A rule that encodes a business choice cites its decision id.
- A rule a script can check becomes a check - a [fence](../fences/SKILL.md), a lint, a
  search the conductor runs; the others are a checklist each agent answers in its report.
- A rule added after the first wave is applied to the pieces already generated.

## 5. Briefs and the parallel run

- **One brief per agent, self-contained**: the mold cards and paths, the schema extract of
  its pieces, the rules, its pieces, its **file set** (create, may modify), what it must not
  touch, and the report it returns. Template: [references/agent-brief.md](references/agent-brief.md).
- **Disjoint file sets.** Each agent writes only its pieces' files. **Shared files belong
  to the conductor**: route or menu registration, translation files, seeds, the shared
  folder, the build registry, test registration. An agent lists the lines it needs in its
  report. (In case zero two builders edited shared files "surgically" at the same time; it
  held, and it is exactly where parallel runs collide - one writer per file, as in
  [`front-protocol`](../front-protocol/SKILL.md).)
- **Small batches**: a few pieces per agent (about two in case zero), so each one finishes
  inside one context. The number of agents is bounded by what the conductor can verify,
  not by what can run.
- **Agents never** commit, write to a shared database, edit a mold or a mold card, or
  decide a question; questions come back in the report.

## 6. Verify on disk

An agent's report is a claim. For each piece, the conductor checks
([verification sheet](references/agent-brief.md#the-conductors-verification-sheet)):

- **The files are on disk** where the brief said, and match the report. An agent can end
  without a report, or with a report the disk contradicts - case zero's builder ended
  twice without one, and the screens were verified on disk.
- **Build and type check clean** ([`build-analyst`](../../agents/build-analyst.md) on a
  compiled stack); the piece's own tests green.
- **Schema conformance**: every column and table the piece names is in the extract (a
  search of the generated code against the extract, not a reading impression).
- **The rules**, one by one, with the evidence for each.
- **Diff against the mold**: everything outside the variation points is a deviation -
  justified in the report, or reverted.
- **Legacy findings** the agent reported (code broken against the schema) are kept: they
  are knowledge, not noise.

## 7. Integrate

- The conductor writes the shared files from the lines the agents asked for.
- **Questions are renumbered**: parallel agents number their questions alike; the
  conductor gives them ids in the home register and publishes a from -> to table
  ([`decision-rounds`](../decision-rounds/SKILL.md)).
- **A defect that comes from the mold is fixed in the mold first**, then in every piece
  generated from it (search for the pattern), and dated on the mold card. Patching only
  the piece where it showed leaves the rest of the family wrong.
- The suite runs on the integrated whole ([`test-gate`](../test-gate/SKILL.md)), then the
  rest of the change cycle; commits are prepared for a human.

## 8. Retain

- **Schema findings** - old code reading columns that do not exist, constraints it would
  violate - go to an episodic log with claims; in a migration they feed the mapping
  ([`memory-engineering`](../memory-engineering/SKILL.md)).
- **Mold corrections and new rules** go back into the mold cards and the brief template, so
  the next wave starts from them ([`retain-knowledge`](../retain-knowledge/SKILL.md)).
- The generated pieces are documented like any unit, by the
  [`docs-writer`](../../agents/docs-writer.md).

## When a mold does not fit

| Situation | Instead |
|---|---|
| The pieces differ in behaviour (each has its own business rules) | the mold carries the structure only; the behaviour of each piece goes through [`change-gate`](../change-gate/SKILL.md) |
| Fewer than about four similar pieces | write them by hand - the molds, cards and briefs do not pay back |
| No real schema yet (the target does not exist) | concept and decisions first; a factory without a schema generates guesses |
| A piece needs what no mold shows | a question to the owner, then a third mold or a mold correction - never an agent's invention |

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| One mold for a family with two shapes | the agents copy the mold's accidents as pattern | one mold per axis of variation |
| Translating the legacy code piece by piece | its drift moves into the new system | write from the mold and the real schema |
| The schema read from the legacy queries | the queries are the drift | the live schema or the canonical schema file |
| An unverified mold | its defect is multiplied by the family | verify the molds end to end before the first brief |
| Agents editing shared files | collisions, lost lines | the conductor writes shared files from the agents' requests |
| Trusting the agents' reports | a missing or wrong report passes as done | verify every piece on disk |
| Fixing a mold defect only where it showed | the rest of the family keeps it | fix the mold, then every piece, and date it on the card |
| Each agent's question numbers kept as they came | ids collide in the register | the conductor renumbers and publishes the mapping |

## Checklist before calling the family done

- [ ] Inventory with the schema extract and the legacy-against-schema diff.
- [ ] The family's concept passed the guardian; every mold choice is a decision or a rule.
- [ ] Molds delivered and verified end to end; a card for each.
- [ ] Rules numbered and checkable; the mechanical ones run as checks.
- [ ] Each brief self-contained, with a disjoint file set; shared files kept by the conductor.
- [ ] Every piece verified on disk: files, build, tests, rules, schema, diff to the mold.
- [ ] Questions renumbered into the home register; mold defects fixed in every piece.
- [ ] The suite green on the integrated whole; commits prepared for a human.
- [ ] Schema findings and mold corrections retained.
