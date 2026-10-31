---
name: archive-card
description: Use when a fact claim at confidence 0.8 or more will hold for the next task - at closing or in a consolidation cycle - to decide new card, strengthen or no card, to write one reusable rule per file under KNOWLEDGE/, or to supersede a card a newer fact contradicts. Never for hypotheses, inferences, narratives or one-task detail.
---

# Skill: Archive card (one rule, one file, one id)

**Scope**: method
**Maturity**: operating
**When to use**: at every closing that wrote an episodic log, for each claim with
`status: fact` and `confidence` 0.8 or more (the card decision); in every consolidation
cycle, for the rule-shaped survivors; and on request - "archive this as a card",
"strengthen card K-...", "this card is wrong now".
**Not for**: hypotheses and inferences (they stay claims in the log until confirmed),
what an area is or why a design exists (the area's `INDEX.md` or a pipeline document),
repeatable procedures (a skill), owner decisions (the decision register; a card may cite
one), or registry data such as a port or a path (the registry).
**Real origin**: case two - a multi-developer product team with one knowledge base over a
core product and many client overlays. In four weeks it wrote about 210 cards in 41
areas, at ticket closing and in six consolidation cycles; about half of them list two or
more work items. The rules below include its corrections: 13 cards grew past the 60-line
limit; nine cards were marked superseded but only four were linked from their
replacement, and its index, which did not read supersession, quoted all nine as current;
one card was marked "superseded, step 2 only"; some cards were written before their
commit existed.
**Parts**: atomic cards (T49) - `operating`: one case, core by choice
([maturity](../../docs/MATURITY.md)). Register: [docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`memory-engineering`](../memory-engineering/SKILL.md) (the claims a card
comes from, the consolidation cycle that calls this skill),
[`close-and-retain`](../close-and-retain/SKILL.md) (the closing that asks the card
decision), [`retain-knowledge`](../retain-knowledge/SKILL.md) (the update chain around
it), [`runtime/memory_index.py`](../../runtime/memory_index.py) (reads every card).
Card file: [`templates/CARD.template.md`](../../templates/CARD.template.md).
**Changelog**: 2026-10-21 - first version (wave 3), distilled from case two's card skill,
its 210 cards and its closing script.

---

## The principle

An area keeps three grains of memory: a **log** says what one session found, a **card**
states one rule the next task needs, the **INDEX** says what the area is. Cards are the
primary semantic layer; the INDEX and the pipeline documents are the map that leads to
them.

A card is **one rule, one file, one id**: the thing an agent can quote in a plan, a review
or a hand-over, and the first hit of the before-action query. It is written only from a
verified fact, it is strengthened instead of duplicated, and it is never edited into its
opposite: a contradiction makes a new card and the old one stays, marked.

## 1. When a card is written

| Moment | Who asks | What is decided |
|---|---|---|
| Closing of a task that wrote an episodic log | [`close-and-retain`](../close-and-retain/SKILL.md) | the card decision for every fact at 0.8 or more in that log |
| Consolidation cycle of one area | [`memory-engineering`](../memory-engineering/SKILL.md), section 5 | the rule-shaped survivors of the cycle become cards or strengthen cards |
| A person asks | the person | the same decision, for the claim they point at |

Never in the middle of an analysis: a claim that is still being checked is not a fact yet.

## 2. The card decision (every fact at 0.8 or more)

Every claim with `status: fact` and `confidence` 0.8 or more in the session's log gets one
of three outcomes - a new card (which may supersede an old one), a strengthened card, or
no card with the reason - said in the closing output. Silence is not an outcome.

1. **The gate.** A hypothesis or an inference never becomes a card, whatever its
   confidence; it stays a claim until new evidence makes it a fact. Below 0.8, no card.
2. **The promotion test**: *will remembering this improve a future decision?* Yes when it
   generalizes - an invariant, a contract, a registration or ordering rule, a latent
   defect pattern, a dead end nobody should re-enter, a fix pattern, an environment
   gotcha. No for one-task detail, registry data, a narrative, a procedure or a decision
   (the "Not for" line above names where those go).
3. **Search before writing.** Query the index for the claim's entities
   (`memory_index.py query --entity <name> --cards-only`) and search the area's
   `KNOWLEDGE/` folder for them. A card that already states the rule -> **strengthen**
   it (section 5). A card that states the opposite, or a fix that is now wrong ->
   **supersede** it (section 6). Nothing -> **new card**.
4. **Cite it back.** The claim's `evidence` in the log names the card id, so the log leads
   to the card and the card's Evidence leads back to the log.

The closing output carries one line per decision, in this form:

```text
Card K-20260115-1432 written -> SUBJECT/BILLING/KNOWLEDGE/1.4_InvoiceTotals_RoundOncePerInvoice_2026-01-15.md (fact 0.9, work items 1201); supersedes K-20251201-0900 (per-line rounding holds through r811 only)
Card K-20260115-1433 written -> SUBJECT/BILLING/KNOWLEDGE/1.4_TaxRate_ReadFromInvoiceDate_2026-01-15.md (fact 0.85, work items 1201)
Card K-20251203-0910 strengthened (0.85 -> 0.95, +work item 1201)
No card: "the test server answers on port 8081" - registry data
No card: "credit notes may round per line" - hypothesis 0.4, stays a claim
```

## 3. Where cards live and how they are named

- **Folder**: `SUBJECT/<AREA>/KNOWLEDGE/` of the **owning project** - the project whose
  code or behaviour the rule describes. A rule of a shared core found during a client's
  task goes to the core's area; the client's log points to it. Create `KNOWLEDGE/` when
  it is missing; do not ask.
- **Id**: `K-YYYYMMDD-HHMM`, minted at write time, unique in the whole knowledge base,
  never changed and never reused. Search the base for the id first; when the minute is
  taken, use the next free minute. Time-minted ids do not collide when several people
  write cards on parallel branches, and a card keeps its id when the rule is found to
  belong to another project. The index reports a duplicate id at every build.
- **File name**: `<version>_<Entity>_<ShortRule>_<YYYY-MM-DD>.md` - `<version>_` left out
  when the project has no version lines. The name is for people browsing the folder; the
  id is what everything cites.

## 4. The card format

Start from [`templates/CARD.template.md`](../../templates/CARD.template.md). In short:

- **Front matter**: `id`, `kind: card`, `project` (optional, otherwise derived from the
  path), `subject`, `version`, `tickets` (every work item that produced or confirmed it),
  `entities`, `status: fact`, `confidence`, `source_file`, the provenance, `supersedes`,
  `last_updated`. Comments go after a value on the same line, never on a line of their
  own.
- **Title**: the H1 is the rule, as one sentence a reader can quote. The index stores it
  as the card's claim.
- **Sections**: Problem (symptom first) / Rule (the invariant, one or two sentences) / Fix
  pattern (numbered, concrete) / Anti-patch (the tempting change that hides the cause) /
  Key files (repository-relative paths with functions and line numbers) / Evidence (the
  source logs, the revision it was verified at, the work items).
- **Size**: under 60 lines. A card that needs more is two rules (two cards) or a
  narrative (the INDEX).
- **Links**: only to markdown inside the knowledge base; source files as plain text with
  line numbers. Language: the case's language rule for artifacts.

**Provenance is VCS-neutral.** `vcs_revision` (a revision or a commit), `vcs_date` and
`vcs_author` name the change that introduced or last changed the code the rule describes;
the working-copy revision the rule was checked at goes in Evidence, with the date and
"static read" or "run". Provenance is mandatory when the rule was derived from code: a
revision survives tracker migrations, a tracker link alone does not. A rule read from a
change that is not committed yet carries `vcs_revision: pending`; the closing that
prepares the commit fills it in once the commit exists, and a card is never left pending
after its closing.

## 5. Strengthen instead of duplicating

A later task that confirms a card updates it in place:

- add the work item to `tickets`, and an Evidence line: the log, what was re-read or run,
  the revision;
- raise `confidence`: a card is born at 0.8 to 0.9; **two independent confirmations**
  raise it to 0.95. Independent means another task that went back to the primary evidence
  (the code at a revision, a run, the owner's answer) - quoting the card itself confirms
  nothing. Never 1.0;
- add entities the new task met; set `last_updated`.

Maintenance that changes no meaning is also an in-place edit, with a dated Evidence line:
line numbers that moved, a renamed file, a clearer sentence.

**What is never an in-place edit**: a change to what a reader would act on. When the Rule
or the Fix pattern is no longer right, that is a contradiction - section 6 - even when
only one step of the fix changed.

## 6. Supersession (a contradiction never edits the rule)

1. **Write the new card** with `supersedes: [<old id>]`. It restates everything of the old
   card that still holds, so a reader never needs both. Its Evidence names what
   contradicted the old rule: the log, the revision, the owner's decision.
2. **Mark the old card**: one line under its Scope line -
   `**SUPERSEDED**: see K-<new id> (<YYYY-MM-DD>, <why, one line>)`. Its front matter and
   body stay as they were. It is never deleted, moved or renamed.
3. **Temporal validity**: when both rules were true at different times, say so on both
   sides - the new Rule says "since revision X", the mark says "true through revision X".
   Dead rules are history that explains old data and old reports.
4. **Not superseded by a card** (the owner reversed a decision, the feature was removed):
   the mark names that document instead - `**SUPERSEDED**: see <KEY>#<n> (...)`.
5. **The INDEX line** of the old card keeps its place and gains the mark, so the map still
   shows where the rule went.

Both halves matter: the derived index treats a card as superseded when a newer card lists
it under `supersedes:` **or** its body carries the mark, and every build lists a mark
without a link, a link without a mark, a `supersedes` id no card has, and a duplicate id.
The closing fixes what the build lists; a mark that names a document other than a card
(step 4) is the one expected "no link" line.

## 7. The same-task chain

When a card is written, strengthened or superseded, in the same task:

1. **The area's INDEX**, section Knowledge: one line per card -
   `- K-<id> - <the rule sentence> (<link to KNOWLEDGE/<file>>)`, in the link style the
   base uses.
2. **The session's log**: the claim's `evidence` cites the card id.
3. **The memory index** is rebuilt (the closing does it), so the card is the first hit of
   the next before-action query.
4. **The card's Scope line** is there, and the closing output lists the card decisions.

## 8. How the index reads a card

The derived index ([`runtime/memory_index.py`](../../runtime/memory_index.py)) scans every
`SUBJECT/<AREA>/KNOWLEDGE/*.md`; the markdown stays the source of record.

| In the card | In the index |
|---|---|
| `id` | the card id; a file without one is counted as a pre-schema card |
| the first H1 after the front matter | the card's single claim (the rule) |
| `status`, `confidence` | the claim's status and confidence (`--status`, `--min-confidence`) |
| `tickets`, `entities` | the `--ticket` and `--entity` filters |
| `project`, `subject`, `version` | the project and area dimensions; without `project`, the path decides |
| `vcs_revision` (alias `svn_revision`) | appended to the claim's evidence |
| `supersedes`, the `**SUPERSEDED**` mark | the card is superseded; queries list live cards first, then superseded ones, then logs |
| the sections, `vcs_date`, `vcs_author`, `source_file`, `last_updated` | not indexed: the reader opens the card |

```text
python <kit>/runtime/memory_index.py build --root <kb-root> --db <outside-the-kit>/memory-index.db
python <kit>/runtime/memory_index.py query --db <...>/memory-index.db --entity <name> --cards-only
python <kit>/runtime/memory_index.py stats --db <...>/memory-index.db
```

Where the index file lives follows the profile ([EK#5](../../DECISIONS.md)): outside the
versioned knowledge base for a solo case (beside it, or in an ignored folder inside it,
[EK#27](../../DECISIONS.md)), versioned with one designated builder for a team.

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| A card from a hypothesis "because it is probably true" | the next agent quotes it as a fact | it stays a claim until new evidence |
| A second card for a rule that already has one | two answers drift apart; the index returns both | strengthen the existing card |
| The rule edited in place after a contradiction | the history and the reason disappear | a new card with `supersedes`; the old one marked |
| A superseded card deleted or moved | old data and old reports lose their explanation | mark it and keep it |
| A mark without the link, or the link without the mark | the index or the reader keeps quoting the replaced rule | both halves; fix what the build lists |
| "Superseded, step 2 only" | the reader must merge two cards to know what to do | a new card that restates what still holds |
| A card of 80 lines | two rules or a narrative | split it, or move the narrative to the INDEX |
| Provenance by a tracker link only | links rot when the tracker migrates | a revision or a commit, with date and author |
| A confirmation that quotes the card | proves nothing new | go back to the primary evidence |
| Ids numbered per area (`K-AREA-004`) | parallel writers collide on the counter | time-minted ids, unique in the base |

## Checklist (closing or cycle)

- [ ] Every fact at 0.8 or more has a decision line: written / strengthened / supersedes / no card (why).
- [ ] The index and the `KNOWLEDGE/` folder were searched before any new card.
- [ ] Each new card: from the template, one rule, under 60 lines, id unique in the base, provenance (or `pending` with its closing named).
- [ ] Each strengthened card: work item, Evidence line, confidence raised only for independent confirmations, `last_updated`.
- [ ] Each superseded card: the new card's `supersedes`, the old card's mark, both kept.
- [ ] The INDEX lines, the log's evidence and the rebuilt index agree; the build listed no mark without a link and no duplicate id.
