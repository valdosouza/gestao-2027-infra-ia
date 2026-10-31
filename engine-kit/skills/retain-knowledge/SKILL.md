---
name: retain-knowledge
description: Use when any task that produced knowledge ends - a decision, a pattern, a repeatable procedure, documentation, a lesson - even unasked: what to retain, where it goes, and the chain in the same task (index, rules, memory log, card decisions, SUPERSEDED marks), ending with the deliverable gate and the close script.
---

# Skill: Retain knowledge (the cycle that makes the engine learn)

**Scope**: method
**Maturity**: proven
**When to use**: at the END of any task that produced new knowledge - an owner decision, a
pattern, a repeatable procedure, documentation, a lesson learned, a changed project state -
even without an explicit request. "Humans are good thinkers with terrible memory": the
process compensates for the memory, and every task becomes training for the next one. The
close of a work item runs this chain as one of its steps
([`close-and-retain`](../close-and-retain/SKILL.md)).
**Not for**: defining the memory - its classes, the claim schema, the consolidation cycle
([`memory-engineering`](../memory-engineering/SKILL.md)); writing a card
([`archive-card`](../archive-card/SKILL.md)); the closing texts and the commits of a work
item ([`close-and-retain`](../close-and-retain/SKILL.md)); deciding where a new kind of
document or folder belongs in the base ([`kb-setup`](../kb-setup/SKILL.md)).
**Real origin**: case zero - the modernization of a legacy business application by one
developer - where this chain closed every task: decisions numbered in the phase prompt, a
central index with a history table, the root rules' "current state", the tool's own memory,
SUPERSEDED marks. Case two - a multi-developer product team - ported it into its team
knowledge base; it is the habit whose absence had let the registries drift from the disk
(rows saying "documented" or "not built" against a different reality), and the team
added the episodic log with claims, the card decision, the consolidation flag and a close
script to it.
**Parts**: the retention chain (T46) - `proven`: two cases
([maturity](../../docs/MATURITY.md)). The close script it ends with is
[`runtime/close/`](../../runtime/close/README.md) (T45, T88); the deliverable gate (T92) is
[`close-and-retain`](../close-and-retain/SKILL.md#7-the-deliverable-gate-t92)'s. Register:
[docs/TECHNIQUES.md](../../docs/TECHNIQUES.md).
**Works with**: [`memory-engineering`](../memory-engineering/SKILL.md) (what the memory is;
the after-action loop), [`archive-card`](../archive-card/SKILL.md) (the card decision),
[`close-and-retain`](../close-and-retain/SKILL.md) (a work item's close; the deliverable
gate), [`decision-rounds`](../decision-rounds/SKILL.md) (decisions and their registers),
[`scope-census`](../scope-census/SKILL.md) (the Scope line), [`kb-setup`](../kb-setup/SKILL.md)
(where a file goes), [`front-protocol`](../front-protocol/SKILL.md) (a front's negative
knowledge at its close).
**Levels**: steps tagged *level 2* or *level 3* are practices of that
[adoption level](../../docs/ADOPTION-LEVELS.md); untagged ones are level 1. Below its level a
tagged step is not run, and the final answer says so in one line ("episodic log: level 2,
skipped") - as the close script does with the case's `level`.
**Changelog**: 2026-10-21 - wave 3: destinations for cards, pipelines, settings and episodic
logs; claims compared with the old ones; the card decision for every fact at 0.8 or more;
the consolidation flag; root rules only when the workspace state changed; the chain ends
with the deliverable gate and the close script. 2026-10-27 - from a greenfield exit test:
steps and checklist items tagged by adoption level. 2026-10-27 - from the second round of
exit tests: the outbox's language, where a pulled line landed (piece and kit version), the
frozen draft's move at the front's close.

---

## 1. What to retain (quick test)

Retain if the answer is YES to any of these:

- Would a future session WITHOUT this conversation need it to avoid a mistake?
- Was it an owner decision that is not in the code? (decisions are never lost)
- Is it a verified fact that will hold for the next task? (-> a card, *level 3*)
- Is it a procedure that will repeat? (-> a skill)
- Did it change a project's state? (a phase completed, a structure renamed, a new endpoint,
  an area documented, a graph rebuilt)

Do NOT retain: what the code, the version control or the tracker already records by
itself; details that only matter to this conversation.

## 2. Where each type goes

| Type of knowledge | Destination | Format |
|---|---|---|
| Owner decision (architecture, business) | the home register of its namespace - the project's, or the front's while a front runs ([`decision-rounds`](../decision-rounds/SKILL.md)) | `KEY#N`, never renumbered; code and documents cite the id; the why in one line |
| *level 2* - **Episodic log** - what one session found | `<project>/SUBJECT/<AREA>/MEMORY/<YYYY-MM-DD>-<topic>.md` | front matter with claims: fact, inference or hypothesis, confidence, evidence ([`memory-engineering`](../memory-engineering/SKILL.md)) |
| *level 3* - **Reusable rule** - a fact at 0.8 or more that will hold for the next task (invariant, contract, latent-defect pattern, dead end, fix pattern) | a **card** in `SUBJECT/<AREA>/KNOWLEDGE/`, through [`archive-card`](../archive-card/SKILL.md) | one rule per file, cited by id; strengthened instead of duplicated |
| *level 2* - **Process discovered** | `SUBJECT/<AREA>/PIPELINES/`, with its line in the area `INDEX.md` and the area's row in the subjects registry (the [`pipeline-builder`](../../agents/pipeline-builder.md)) | trigger, steps, sources, the settings that steer it |
| *level 2* - **Setting or flag discovered** | handed to the [`settings-mapper`](../../agents/settings-mapper.md): its row in `<project>/_REGISTRY/SETTINGS.md`, and `SUBJECT/<AREA>/SETTINGS/<setting>.md` when it needs one | name, default, effect, where it is read |
| *level 2* - Business rule (projects with rule files) | `SUBJECT/<AREA>/RULES/RULE-<slug>.md` | current rule and an append-only history ([`decision-rounds`](../decision-rounds/SKILL.md)) |
| Permanent pattern of a whole domain | the domain's reference document (for example database standards) | the current rule only, no history |
| Repeatable procedure | a skill: the project's `skills/<verb-object>/`, or the kit's when it is valid for any project | When to use + numbered workflow + real situations |
| Module or feature documentation | the project's documentation, numbered (`NN-NAME.md`) | status, files, how to test |
| Draft or prompt being refined | `prompts/` | working version; never loose at the root |
| A front's prompt at the front's close | the project's folder (until then, closed or not, it stays in `prompts/` as the living front prompt); at the front's close, the frozen copy of its source draft to `HISTORY/` with a pointer to the closed prompt (the owner's original moves when the owner chooses) | the closed prompt |
| One-off analysis or report | the ticket folder, or `HISTORY/` with its index updated | the [deliverable gate](#4-the-end-the-deliverable-gate-and-the-close-script) |
| **Method insight** (portable) | the case's outbox for the kit, `JOURNAL-for-kit.md` at the root of the base (below): one line within one working session. The kit's author pulls it into the kit's product journal ([`JOURNAL.md`](../../JOURNAL.md)); an adopter never writes in the kit | the kit journal's columns - date, insight, origin, landed in; distilled, without case content |

**The outbox for the kit.** A case cannot write in the kit ([EK#1](../../DECISIONS.md)), so
it keeps one local file, created with its first line and listed in the root inventory. It
is a case artifact like any other: written in the case's artifact language - the column
headers and the word `open` stay as below; the kit's author distils each line into English
when pulling it. The kit's author pulls its `open` lines at the next pass and says where
each landed - the kit piece and the kit version (tag or CHANGELOG version) that carries it;
the case writes that in the last column once that piece, at that version, holds the
lesson, and otherwise keeps the line `open` with a note. The pull is a line in the kit's
journal: a CHANGELOG entry that describes the fix is not one, and the case waits for the
journal line ([JOURNAL.md](../../JOURNAL.md), rule 4). The kit's author who works in the
case writes in the kit's journal directly.

```markdown
# Journal for the kit - <case>

**Scope**: mixed

Method insights for the engine-kit's author to pull into the kit's JOURNAL.md: one per
line, append-only, method only - no names, paths or domain of this case.

| Date | Insight | Origin | Landed in |
|---|---|---|---|
| <YYYY-MM-DD> | <how to work - one sentence> | <the kind of work: framing, assessment, a front> | open |
```

## 3. The chain - in the same task

When creating or changing anything above, update IN THE SAME task:

1. **Index and registry.** The owning index lists it (the area `INDEX.md`, the central
   index and its history table: date, what, version). The registry row that indexes it -
   subjects, settings, graphs, projects - matches the disk. A row that contradicts the disk
   is a bug: fix it or flag it.
2. **Root rules - only if the workspace state changed**: a new convention, a moved folder, a
   completed phase, a project's current state. Not for every task: root rules that change
   every task stop being read. Thin adapters (`CLAUDE.md` and the like) stay untouched.
3. **Memory.**
   1. *level 2* - **The episodic log** of the session, with claims and their evidence (a
      revision, a file and line, a work item, a card id).
   2. *level 2* - **New claims are compared with the old ones**: new -> a new claim; a
      confirmation -> the old claim's confidence rises, citing the new evidence; a contradiction ->
      **never overwritten**: a temporal or scope note on both sides ("valid before revision
      X"); a refuted hypothesis stays, at about 0, with its refutation.
   3. *level 3* - **The card decision**: every claim with `status: fact` and confidence
      **0.8 or more** gets one - "will remembering this improve a future decision?" - **new card /
      strengthened card K-... / superseding card / no card (why)**, through
      [`archive-card`](../archive-card/SKILL.md). One line per claim in the final answer.
   4. *level 3* - **The consolidation flag**: count the area's unconsolidated logs
      (`consolidated: false`, and logs without front matter). **Five or more**: say it in the
      final answer - "<AREA> has N unconsolidated logs -> run the consolidation cycle"
      ([`memory-engineering`](../memory-engineering/SKILL.md)); the close script prints the
      count from the memory index.
   5. The tool's own memory, where the case uses one: the topic's file and its index.
4. **SUPERSEDED, never deleted.** An obsolete document, section, claim or card is marked
   `**SUPERSEDED**: see <replacement>` - pointing at the decision or document that replaced
   it - and kept.
5. **Scope line** on every new or touched document
   ([`scope-census`](../scope-census/SKILL.md)).
6. **Provenance**: a card or a document derived from code carries the revision of its
   source.

## 4. The end: the deliverable gate and the close script

1. **Every artifact the task leaves for someone to keep** passes the deliverable gate
   ([`close-and-retain`, step 7](../close-and-retain/SKILL.md#7-the-deliverable-gate-t92)):
   the case's artifact language (the chat follows the user), the owning folder (never the
   root), the markdown as the record with binary files as exports beside it.
2. **The close script**, one call:

   ```text
   python <kit>/runtime/close/close.py --root <kb-root>
   ```

   The case's `level` in `.engine-kit/close.json` leaves out the pieces of a higher level.

   Registries, the Scope line of the touched documents, retired locations in normative
   files, decision citations, the ledger, the memory index with its consolidation flags
   (level 3), files left unversioned. Fix what it lists and run it again. It is warn-only
   ([EK#6](../../DECISIONS.md)): read the lines, not the exit code. Where the runtime is not
   installed, say "close script not run here" and do the checks of the exit checklist by
   hand. Contract: [`runtime/close/README.md`](../../runtime/close/README.md).

## 5. Writing conventions

- File names: kebab-case for skills, UPPERCASE.md for reference documents,
  `<YYYY-MM-DD>-<topic>.md` for logs.
- Every document starts with its title and the **Scope** line (`method | <case> | mixed`),
  then status or version, origin and references.
- Decisions cite the why in one line - especially the controversial ones ("kept X - owner's
  decision, risk recorded").
- A skill born from mistakes gains a "real situations" section.

## 6. Recorded lessons (real situations)

- **The registries drifted while the chain was a separate habit.** In case two, registry
  rows said "documented" or "not built" against a different reality on disk; nobody had
  updated the row in the task that changed the disk. Hence "in the same task", and a script
  that checks the registries at the end.
- **The method insight went back to the kit distilled.** Case two sent its portable lessons
  to the kit as one changelog line each, within the working session, and ran the kit's
  linter with its own deny-list so that no case term travelled with them.

## 7. Exit checklist (copy into the task's final answer)

- [ ] New knowledge identified and classified (section 2)
- [ ] Each item in its place, with its Scope line
- [ ] Owning index and registry rows updated
- [ ] Root rules updated only if the workspace state changed (or: "unchanged")
- [ ] *level 2* - Episodic log written; new claims compared with the old ones
- [ ] *level 3* - Card decision for every fact at 0.8 or more: new / strengthened / superseding / no card (why)
- [ ] *level 3* - Areas at five or more unconsolidated logs flagged
- [ ] Nothing obsolete left without a SUPERSEDED mark
- [ ] Method insight (if any) distilled into the case's `JOURNAL-for-kit.md` within the session (the kit's [`JOURNAL.md`](../../JOURNAL.md) only for the kit's author)
- [ ] Deliverable gate passed; close script run - clean, or each line with its reason
