---
name: memory-engineering
description: Use when starting work in an area that has past sessions (recall first), closing an analysis session (the episodic log with typed claims), designing a fix on a process nobody mapped (pipeline gate), or when an area holds five or more unconsolidated logs (the consolidation cycle); also to design or review any memory mechanism for agents.
---

# Skill: Memory engineering (remember, reflect, consolidate, improve)

**Scope**: method
**Maturity**: operating
**When to use**: before acting in an area that has past sessions (the before-action
loop), after every analysis session (the after-action loop and the episodic log), before
designing a fix on an unmapped process (the pipeline gate), and whenever an area piles up
unconsolidated logs (the consolidation cycle).
**Not for**: writing, strengthening or superseding a card - that is
[`archive-card`](../archive-card/SKILL.md), which this skill calls; the update chain of the
whole task - [`retain-knowledge`](../retain-knowledge/SKILL.md); the closing of a work
item - [`close-and-retain`](../close-and-retain/SKILL.md); building or querying the
derived index - [`runtime/memory_index.py`](../../runtime/memory_index.py).
**Real origin**: case two - a multi-developer product team with one knowledge base over a
core product and many client overlays. A four-phase memory plan was piloted on a real
bug-fixing flow in 2026-08; in the two months after it the team wrote about 300 episodic
logs with claims, consolidation cycles absorbed about two thirds of them, and closings and
cycles together wrote some 210 cards. The principles come from a "memory engineering
architect" master prompt: memory as an architectural capability, not as retrieval.
**Parts**: episodic claims and the two loops (T47) and consolidation cycles (T48) -
`operating`: one case, core by choice ([maturity](../../docs/MATURITY.md)). The pipeline
gate (T27) is owned by [`change-gate`](../change-gate/SKILL.md); its principle is
section 4 here. Register: [docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`archive-card`](../archive-card/SKILL.md) (the semantic layer),
[`retain-knowledge`](../retain-knowledge/SKILL.md) and
[`close-and-retain`](../close-and-retain/SKILL.md) (when logs are written and the flag
is counted), the [`feedback-analyst`](../../agents/feedback-analyst.md) agent (reads the
typed claims). Detail: [the consolidation cycle](references/consolidation.md).
**Changelog**: 2026-10-21 - wave 3: typed claims replace the body markers; the
consolidation cycle is complete here (it was a summary); cards are the primary semantic
layer and live in their own skill.

---

## Principle

Agents must not only *retrieve information*; they must **remember -> reflect ->
consolidate -> improve**. Memory is not chat history, not a vector database, not
retrieval-augmented generation. The question that validates any memory mechanism:

> **"Does this make the next agent better than the previous one?"** If not, it should
> not exist.

## 1. Five memory classes - map them onto what ALREADY exists

Do not create a new store: name the memory role of the structures the knowledge base
already has.

| Class | Lives in |
|---|---|
| Working (the current task) | the agent's context - never persists |
| Episodic (analysis sessions) | `SUBJECT/<AREA>/MEMORY/YYYY-MM-DD-<topic>.md` - one log per session, claims in the front matter |
| Semantic (validated knowledge) | **cards** in `SUBJECT/<AREA>/KNOWLEDGE/` - the primary layer, one rule per file ([`archive-card`](../archive-card/SKILL.md)); the area's `INDEX.md` and its pipeline documents are the **map** that leads to them |
| Procedural (how to do it) | skills and workflow documents |
| Structural (relations) | the code graph - a runtime artifact, rebuildable |

Markdown is the **source of record** (auditable, tool-neutral, survives any runtime).
Derived indexes - the memory index, a graph, a vector store - are **rebuildable** runtime
artifacts, never the source.

## 2. Episodic schema - claims at the center

Every new session log is born with front matter; the body is free commentary:

```yaml
---
subject: <AREA>
project: <KEY>                # optional; otherwise derived from the path
tickets: ["1234"]             # optional
version: "<product version>"  # optional
entities: [Unit, TABLE, screen]
claims:
  - claim: "<one verifiable statement>"
    status: fact              # fact | inference | hypothesis
    confidence: 0.9           # 0..1
    evidence: "<pointer: file:line at a revision, a query, a document, a card id>"
  - claim: "<what a person corrected in an agent's output>"
    status: fact
    confidence: 0.95
    evidence: "<who corrected it, where, when>"
    type: correction          # finding (default) | correction | missed | wrong | collision
    agent: <agent or skill>   # whose output the typed claim is about
outcome: analyzed             # fixed | analyzed | blocked | open
open_questions: []
consolidated: false           # flipped by the consolidation cycle, after its promotion is written
---
```

Vital rules: **an inference never becomes a fact without new evidence**; a refuted
hypothesis is NOT deleted - it stays with confidence near 0 and the refutation as its
evidence (it is a dead-end sign for the next agent). Migrating old logs is **lazy**: only
when a task touches them.

**Claim types.** Most claims are findings about the system, and need no `type`. A claim
about an agent's own work carries one, so the self-improvement loop can find it without
reading every body:

| `type` | Write it when | Was the body marker |
|---|---|---|
| `finding` (default) | the session learned something about the system | - |
| `correction` | a person fixed an agent's output | `CORRECTION:` |
| `missed` | an agent failed to find what it should have found | `MISSED:` |
| `wrong` | an agent's output was incorrect, whoever found it | `WRONG:` |
| `collision` | a collision appeared that no process map covered | `COLLISION:` |

A typed claim is a claim like any other: status, confidence, evidence (the correction
itself - who, where, when), plus `agent:`, the agent or skill whose output it is about.
The marker lines of older logs are read as claims of the same type and rewritten into the
schema only when a task touches the log. The derived index stores the type
(`memory_index.py query --claim-type correction`).

## 3. The two loops

**Before acting**: resolve the owning area -> query the memory index (*level 3*; at level 2,
read the area's `MEMORY/` logs) for the entities
and work items (live cards come first; superseded cards follow and are never quoted as
current) -> read the area's `INDEX.md` -> pull the related items that were actually
WORKED, with their implementation notes, not title look-alikes. The semantic layer must
deliver the investigation's **entry point**, not generic context. Quote cards by id.

**After acting**: compare the findings with the existing claims and cards - new -> a new
claim; confirmation -> raise the confidence, citing the new evidence; contradiction ->
**never overwrite**: add a temporal or scope note on both sides ("valid before / after
revision X"). Failed hypotheses are claims too. Then:

- *level 3* - **the card decision** - every `fact` at 0.8 or more gets a decision: new card,
  strengthened card, superseding card, or no card with the reason
  ([`archive-card`](../archive-card/SKILL.md));
- *level 3* - **the consolidation flag** - count the area's unconsolidated logs (the index build
  prints `<< FLAG` at five or more); a flagged area gets a consolidation cycle (section
  5), now or as the next task named in the closing output.

## 4. Process-understanding gate (pipeline gate)

**No fix is designed or implemented on a process the executor does not know.** If the
affected pipeline is not documented, the fix flow STOPS and the mapping comes first
(graph + source). Analysis may proceed; code may not. Why: blind fixes on an unknown
process cause cascades - the before-action loop must deliver *understanding*, not just
facts. The gate step itself lives in [`change-gate`](../change-gate/SKILL.md).

## 5. The consolidation cycle (T48)

Episodic logs are the raw material; a cycle turns N sessions into knowledge the **next**
agent loads before acting: pattern detection -> reflection -> generalization -> reusable
knowledge. Worksheet, record formats and a worked example:
[references/consolidation.md](references/consolidation.md).

**Trigger** - any of:

- **flagged**: five or more unconsolidated logs in one area (the index build and the
  closing report it);
- **closing**: a work item closes leaving two or more sessions in one area;
- **on demand**: the owner asks for an area, whatever the count.

**Input**: the area's unconsolidated logs - `consolidated: false`, or no front matter at
all (a pre-schema log). A pre-schema log absorbed by a cycle first gets its front matter
(lazy migration): claims written from its body, each with the body line as evidence.

**One area per cycle.** A pattern that spans areas is written into each owning area by its
own cycle, never into a neighbour's INDEX; a pattern that is about the method itself, free
of case content, goes to the case's outbox for the kit (`JOURNAL-for-kit.md`, [`retain-knowledge`](../retain-knowledge/SKILL.md) section 2), which the kit's author pulls into [`JOURNAL.md`](../../JOURNAL.md).

### The steps

1. **Inventory** - list the area's unconsolidated logs
   (`memory_index.py query --subject <AREA> --unconsolidated`); read every claim (status,
   confidence, evidence, type) and every open question; list the area's live cards.
2. **Cross-log view** - group the claims by entity and theme across the logs:
   - **survivors**: facts not contradicted by a later log;
   - **chains**: hypothesis -> refuted -> replaced by. Keep the whole chain in the logs;
     promote only its end state; the refuted links become **known dead ends**;
   - **patterns**: anything true in two or more logs - a generalization candidate;
   - **contradictions**: two facts that cannot both hold - resolve by time or scope
     (before / after a revision, one client / another), with a note on both sides; never
     by overwriting one of them;
   - **open questions**: carried forward, never dropped in silence.
3. **Choose the target by knowledge type** - never a new summary document when an owning
   artifact exists:

   | What survived | Goes to |
   |---|---|
   | a rule-shaped fact at 0.8 or more (invariant, contract, ordering rule, latent defect, fix pattern) | a card - new, strengthened or superseding ([`archive-card`](../archive-card/SKILL.md)) |
   | what the area is, why a design exists, the workload it serves | the area's `INDEX.md`, section Consolidated knowledge, or the pipeline document |
   | a known dead end | the INDEX, section Known dead ends, with the refuting evidence - or the Anti-patch of the card it belongs to |
   | an open question | the INDEX, section Open questions, with the logs that raised it |
   | a procedure that repeats | a skill or a workflow document |
   | a portable method insight | the case's outbox for the kit (`JOURNAL-for-kit.md`, [`retain-knowledge`](../retain-knowledge/SKILL.md) section 2), which the kit's author pulls into [`JOURNAL.md`](../../JOURNAL.md), distilled, no case content, within one working session |

4. **Write with evidence links** - every promoted claim carries its statement, its
   confidence and **a link to every source log** (and the original primary evidence). The
   audit test: *"why do we believe this?"* is answered by following the links.
5. **Verify, then flip** - check the promotion is on disk: each card and section exists,
   the links resolve, the rebuilt index lists the new cards. **Only then** set
   `consolidated: true` in every absorbed log. Nothing else in a log changes (except the
   lazy front matter of a pre-schema log).
6. **Record the cycle** - one row in the area INDEX's Consolidation cycles table: date,
   the logs absorbed, the artifacts touched (cards written, strengthened, superseded, and
   checked but left unchanged).
7. **Close** with the retention chain ([`retain-knowledge`](../retain-knowledge/SKILL.md)):
   Scope lines, INDEX links, registry rows, SUPERSEDED marks, the index rebuilt.

**Promotion test**: *"Does remembering this improve a future decision?"* Promote what
generalizes: invariants, contracts with temporal validity, design decisions, dead ends,
latent defects, environment gotchas. One-task detail stays in the log - still retrievable,
never promoted.

### Rules of the cycle

- **Never delete.** No log is deleted, no claim is removed, no history is lost; a log is
  never rewritten beyond the flag and the lazy front matter.
- **Never a dump document.** The cycle writes into owning artifacts; its only own trace is
  the one row in the INDEX.
- **The flag flips last.** A cycle that stops half-way leaves its logs unconsolidated, and
  the next cycle sees them again; because every card is searched before it is written,
  the rerun strengthens instead of duplicating.
- **A promoted claim that later proves wrong** is superseded, not edited: a superseding
  card ([`archive-card`](../archive-card/SKILL.md)), or a `SUPERSEDED` note on the INDEX
  entry pointing to the log with the new evidence. The audit chain stays whole.

## 6. Method lessons (from the pilot, distilled)

1. Cheap primary verification kills inference chains - each refutation costs minutes and
   prevents a wrong fix.
2. Design decisions have temporal validity: "strange code" is often a decision with an
   intent; version-control archaeology (log -> diff of the introducing revision) turns it
   into *decision + context*, and the fix must honor the old intent AND the new case.
3. References rot across tracker migrations; **diffs survive** - cite durable artifacts
   (a revision, a commit) as provenance.
4. When migrating the format of data that crosses layers (a wire contract), **sweep ALL
   the readers** - a partial migration is a classic regression generator.
5. Constraints stated by the owner become scoped claims and re-scope existing claims on
   the spot (for example, "imported data is under suspicion until proven consistent").
6. Infrastructure gaps discovered in use (a missing folder, a divergent registry, a tool
   limitation) are fixed in the same task - the system grows through use, not through
   documentation projects.

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| A refuted hypothesis deleted from the log | the next agent walks into the same dead end | keep it, confidence near 0, the refutation as evidence |
| An inference raised to a fact because it "looks right" | a wrong fix built on it | new evidence first |
| Human corrections left in free text | the self-improvement loop never sees them | a typed claim with `agent:` |
| A consolidation that writes a new summary file | one more document nobody owns | the owning artifacts and one INDEX row |
| The flag flipped before the cards exist | absorbed logs whose knowledge is nowhere | verify on disk, then flip |
| One cycle across several areas | each area's INDEX loses its own patterns | one area per cycle |
| A contradiction resolved by overwriting | the reason and the old data's explanation disappear | a temporal or scope note on both sides |

## Checklist

- [ ] Before acting: memory queried for the entities and work items; cards quoted by id, or "no prior knowledge" with the folders checked.
- [ ] After acting: one log with claims; typed claims for corrections, misses, wrong outputs and collisions, each with `agent:`.
- [ ] Every fact at 0.8 or more has a card decision ([`archive-card`](../archive-card/SKILL.md)).
- [ ] The area's unconsolidated logs counted; at five or more, a cycle run or named as the next task.
- [ ] In a cycle: one area; every promoted claim links to every source log; the flag flipped only after the promotion was verified on disk; one row in the INDEX's Consolidation cycles table.
