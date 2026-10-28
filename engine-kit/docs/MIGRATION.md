# Migration - adoption first, by script, retired by a gate

**Scope**: method

How two stores of knowledge become one without losing a file, a fact or a person: a
developer's parallel setup joining a team knowledge base, a former shared folder that is
frozen, divergent copies of a method. Two techniques of the
[register](TECHNIQUES.md): **T61 adoption-first merge** (`operating`, core) and **T89
frozen-source retirement gate** (`operating`, optional tier: only when the old store stays
writable after the freeze) - labels in [MATURITY.md](MATURITY.md). The tools:
[`runtime/migration/`](../runtime/migration/README.md). The worked example: the kit's own
0.7.0 consolidation, done by a manifest (kept by the kit's author, outside the kit: it names the source machines and cases).

Not for business data: a legacy system's records moving into a new platform follow
[`migration-direction`](../skills/migration-direction/SKILL.md). Not for a person's local
folders of past work items either: they are not a store, and the
[`folder-importer`](../agents/folder-importer.md) agent moves them folder by folder.

Words used here: the **old store** is what is being retired; the **target** is the
knowledge base that receives it; a **counterpart** is the thing in the target that does
the job of an old item; the **owner** decides
([`decision-rounds`](../skills/decision-rounds/SKILL.md)).

## The principle

A merge is an adoption problem before it is a content problem. People stay with the store
that serves them every day; if switching costs them a reflex they rely on, they go back,
and the merged content goes stale beside them. So the order is fixed:

1. **Counterparts first** - the target gains every mechanism the adopting people would lose.
2. **Content second** - by script, from a manifest, with a dry run, without fixing content.
3. **Retirement last** - only when every old item has a counterpart (or a ruling), and only
   after a gate; never by deleting.

## 1. Counterpart before retirement

List what the adopting people use in the old store every day and what each thing gives
them - the agents and their checklists, the end-of-task reflex, the scripts, the recall
step, the build checks. Then make the target do each of them **before** the switching day.

| Old item | What it gives the people who use it | Counterpart in the target | Status |
|---|---|---|---|
| a persona with an embedded checklist | zero setup per task | an agent with the same checklist, a stub in their editor | done |
| an end-of-task archive reflex | retention without a checklist | the closing step and its script | done |
| workstation troubleshooting probes | - | - | dropped: the owner's reason |

Rules:

- **The parity table is the retirement gate for mechanisms.** The old store is retired when
  every row is `done` or `dropped` with the owner's reason - not before, and not because
  the content was copied.
- **Phases in this order**: decide (open questions answered) -> mechanisms (each tried by an
  adopting person on one real task of their own) -> content (by script) -> retire -> close
  (SUPERSEDED marks, registers, the plan's own retention).
- **The adopting person runs the exit test**, not the person who built the counterpart: one
  real task, start to finish, in the target, with the old store closed.
- **What the person gains is said on day one**: shared memory, numbered decisions, review -
  whatever the target has that the old store lacked.

## 2. Migrate by script, with a dry run

- **One manifest row per file of the old store**: where it goes, in which batch, as what
  kind. A file with no decided target stays an open row - an owner question with evidence
  and options - never a guess. The manifest is complete (every file has a target or an
  explicit drop) before anything is applied.
- **The dry run stages everything outside both stores**, with the target's relative paths,
  and writes a log: totals, blocked rows, notes by kind, unresolved links, collisions and a
  stratified sample of about 20 rows. The owner spot-checks the sample against the
  originals.
- **The dry run raises questions; each default is what the staging already applies.** The
  answers become numbered decisions; the dry run runs again until no row is blocked.
- **Case data lives beside the manifest**, never in the script: who wrote the knowledge,
  project keys, per-file target fixes, the old machine roots.
- **Apply in batches** (one area at a time), each followed by the target's registry checks;
  a person adds and commits. Before the first apply, freeze the old store and run the dry
  run once more **on the live store** - a copy taken weeks earlier has drifted.
- **Prepare-only**: the script writes into the working copy and stops there; version
  control, publication and deletion are human steps
  ([prepare-only](../skills/change-gate/references/prepare-only.md)).

## 3. Never fix content during a migration

A migration that also corrects things cannot be reviewed: nobody can tell a lost fact from
a fixed one. The script changes only what is mechanical:

| May change | Must not change |
|---|---|
| link targets that point at other migrated files | wording, headings, facts, examples |
| the old store's machine paths, rewritten as addresses | file names cited in the text, ids, numbers |
| provenance in the front matter: origin, migration date, who wrote the knowledge | an existing front-matter key |
| a missing Scope line | line endings, encoding, the file's bytes when it is not text |

Everything else that looks wrong becomes **a line in the migration log** for a later round:
an article-shaped "card" migrates as it is and is split when a task next touches it; a
missing provenance is listed, never back-filled with a machine guess; a reused id keeps its
first owner and the copies get a visible suffix (renaming nothing). When the target already
holds the file, **the target's body wins** and only the keys it lacks are added.

## 4. SUPERSEDED, never deleted

- The migration never deletes or renames. Retirement is a separate step with its own gate.
- An old document replaced by a migrated one is marked **SUPERSEDED with a pointer** to its
  replacement ([`scope-census`](../skills/scope-census/SKILL.md), T06); the old store gets a
  pointer at its entry and becomes read-only; the notes that framed the merge get
  `SUPERSEDED: see <the plan>`.
- After retirement, the retired-location guard (T88) keeps normative files - rules, agents,
  skills, registers - from pointing back at the old store, in every spelling of its path.
  The migrator, which reads the old location by design, is exempt.
- Removing the old copy, if ever, is a person's act after the gate and after the migrated
  content is committed.

## 5. The retirement gate (T89)

Needed when the old store stays visible - and therefore writable - after the freeze:
someone will edit it, and the edit is lost when it is retired.

1. **Snapshot at the freeze**: every file with its size and content hash; editor and runtime
   state excluded, nothing else, so no knowledge hides in the blind spot. Taken once.
2. **Check drift**: added, modified and deleted files since the snapshot, decided by
   content; each with its **new location** from the old-to-new map (the manifest rows,
   then folder prefixes; a part with no counterpart is named as such).
3. **A human ruling per item**: *import* (carried into the target - say where) or *discard*
   (say why), with the name of the person. Agents prepare the list; people rule. A ruling
   holds for the bytes it saw: an item edited again is open again.
4. **Retire at zero drift, or when every item is ruled.** An owner may also rule on the
   whole store at once ("nobody edits it again") - a human ruling the gate allows; record
   it with the date and keep the last snapshot.

Evidence: in case two the shared folder of an earlier knowledge base was frozen, its
snapshot taken and the drift check designed; the owner then retired it for good by a
ruling on the whole store, and the final snapshot was kept. The per-item ruling and the
content-hash comparison are the kit's generalisation and have not run in a case yet; the
technique is optional because most old stores can simply be made read-only at the freeze.

## 6. Worked example - the kit's own consolidation

The kit applied the same technique to itself in 0.7.0, when three divergent copies became
one repository, by a manifest (kept by the kit's author, outside the kit: it names the source machines and cases).

- **One row per source file**: the source copy, its path, the destination, the action
  (`already-carried`, `translate-neutralize`, `upgrade-neutralize`, `keep`, `create`, ...),
  the status (`verified` or `done`) and a note. Nothing left the old copies without a row.
- **Nothing silently dropped**: the manifest surfaced a reference file that an earlier
  conversion had lost to a broad ignore rule; it was recovered, and the ignore rule now
  carries a warning.
- **The old copies were marked, not deleted**: a copy inside a case is never edited again
  ([EK#1](../DECISIONS.md)); the case marks it SUPERSEDED with a pointer to the canonical
  repository.
- **Two differences from the method above, on purpose.** The kit's merge was small and done
  by hand, so it has a manifest but no script and no dry run. And its transforms translate
  and neutralise, because the kit's hygiene rule demands that of anything that enters it -
  for the kit that is the counterpart's definition; in a knowledge-base merge it would be a
  content fix, and it is not allowed.

## Checklist

- [ ] The parity table lists every mechanism the adopting people use; each is `done` or `dropped` with the owner's reason.
- [ ] An adopting person ran one real task end to end in the target.
- [ ] The manifest has a target (or an explicit drop) for every file; open rows went to a decision round.
- [ ] The dry run on the live, frozen old store shows no blocked row and no leftover old address; the owner ticked the spot-check sample.
- [ ] Each batch was applied, checked by the target's registry tools and committed by a person.
- [ ] No content was fixed during the migration; every problem is a line in the log.
- [ ] Replaced documents are SUPERSEDED with pointers; the old store is read-only with a pointer at its entry.
- [ ] The retirement gate is green (zero drift, or every item ruled), or the owner's whole-store ruling is recorded.
- [ ] The retired-location guard knows the old store's paths.

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| Content first, mechanisms "later" | the adopting person loses daily ergonomics and goes back to the old store | counterparts first; content second |
| Retiring because "everything was copied" | a mechanism with no counterpart disappears with the store | the parity table is the gate |
| Fixing typos, splitting files, merging duplicates while migrating | lost and fixed facts become indistinguishable; the review is impossible | migrate as is; problems become log lines for a later round |
| Back-filling missing provenance from history at migration time | a machine guess presented as evidence | list it; add it when a task confirms the file |
| Applying from a copy taken weeks earlier | edits made since are silently lost | freeze, then a last dry run on the live store |
| Guessing the target of an unmapped file | a wrong home that nobody reviews | an open row and an owner question |
| Deleting the old store as part of the migration | an irreversible act with no gate | SUPERSEDED pointer, read-only, the gate, then a person decides |
| A retired path still cited by an agent or a rule | agents keep reading or writing the dead store | the retired-location guard |
