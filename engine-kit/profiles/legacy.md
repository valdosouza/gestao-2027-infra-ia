# Profile: legacy (the legacy track)

**Scope**: method

For a project whose starting point is a system that already runs: code, data and documents
that someone wrote before the kit arrived. The work is to understand it faithfully before
changing or replacing it - photography first, renovation later. The other track is
[greenfield](greenfield.md); the team profile ([solo](solo.md) or [team](team.md)) and the
[adoption level](../docs/ADOPTION-LEVELS.md) are chosen beside this one. Steps:
[INSTALLATION.md](../INSTALLATION.md).

## The track

| | Legacy |
|---|---|
| **Day 1** | The vessel ([`kb-setup`](../skills/kb-setup/SKILL.md)) and the census of the existing collection ([`scope-census`](../skills/scope-census/SKILL.md)) - not one line of code read yet |
| **Entry** | Assess: size the repository, index it when it is large, define the units, propose ONE pilot unit and assess only that unit ([`assess-legacy-repo`](../skills/assess-legacy-repo/SKILL.md), agent [`legacy-analyst`](../agents/legacy-analyst.md)); conceptualize the pilot ([`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md)); Round 0 ([`decision-rounds`](../skills/decision-rounds/SKILL.md)) decides the pilot, with the assessment as its evidence, in `prompts/prompt_<name>.md` built on the [`FRONT_PROMPT`](../templates/FRONT_PROMPT.template.md) skeleton, as on the greenfield track ([EK#25](../DECISIONS.md)) |
| **Then** | The cycle per front ([`front-protocol`](../skills/front-protocol/SKILL.md), [`change-gate`](../skills/change-gate/SKILL.md), [`test-gate`](../skills/test-gate/SKILL.md), [`delivery-gates`](../skills/delivery-gates/SKILL.md), [`close-and-retain`](../skills/close-and-retain/SKILL.md)), the guardian still before every domain object |
| **Success** | One full cycle - assess -> conceptualize -> decide -> retain - run on the pilot unit, with everything recorded in the base. From there on it is repetition at scale |

## What it turns on

At level 1, on top of the essential pieces - which include, on both tracks, the whole
[`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md) with
[`OCCUPIED_WORDS`](../templates/OCCUPIED_WORDS.template.md) for the pilot's concept step, and
the [`FRONT_PROMPT`](../templates/FRONT_PROMPT.template.md) skeleton for Round 0's prompt,
with no borrowing decision ([EK#25](../DECISIONS.md)) - the track entry:

- [`assess-legacy-repo`](../skills/assess-legacy-repo/SKILL.md) and the agent
  [`legacy-analyst`](../agents/legacy-analyst.md): faithful reading, `file:line` on every fact,
  no inferred intent, no improvement suggested.
- [`HYPOTHESES`](../templates/HYPOTHESES.template.md): a legacy claim (a comment, an old
  document, the owner's memory) stays a hypothesis until the code confirms it.
- [`runtime/data-probe/`](../runtime/data-probe/README.md) when the legacy has a database to
  read: read-only, rows capped.
- [`SENSITIVE_DATA_REPORT`](../templates/SENSITIVE_DATA_REPORT.template.md) when the
  assessment's hygiene line finds a credential or personal data: where, never the value.

Candidates of the track, each at its own level and turned on by its situation:

| Piece | Level | Turn it on when |
|---|---|---|
| [`official-source-archive`](../skills/official-source-archive/SKILL.md) | 2 | the legacy implements an official norm, and a rule must be checked against the norm itself |
| [`migration-direction`](../skills/migration-direction/SKILL.md) | 2 | a new system replaces the legacy while the legacy keeps running |
| [`settings-mapper`](../agents/settings-mapper.md), [`pipeline-builder`](../agents/pipeline-builder.md) | 2 | behaviour is steered by settings; a fix lands on a flow nobody mapped |
| [`runtime/graph/`](../runtime/graph/README.md) | 3 | the sizing step finds more than ~500 files, or more than a few sessions of reading |
| [`folder-importer`](../agents/folder-importer.md), [`runtime/migration/`](../runtime/migration/README.md) | 3 | knowledge already exists in scattered working folders or in an old store |
| [`version-diff`](../agents/version-diff.md), [`backport`](../skills/backport/SKILL.md) | 3 | more than one version or line of the legacy is maintained |

## Rules of the track

1. **Census before reading.** Documentation that already exists is moved or linked into the
   project's mirror and classified on Day 1; it is not rewritten.
2. **Legacy documents are input, never truth.** Every claim they make is a hypothesis until
   the code confirms it - an owner's confirmation does not promote it. The same holds for
   the owner's own account of what the legacy runs or does - an answer to a fact requested
   in a round (`R-<NS>n`): it enters the hypothesis register with that id as its source
   (`owner R-<NS>n`, priority high), and only the code, a read-only probe or a run settles
   it. A fact about the world (volumes, opening hours, who does what) stays a fact; an environment the code constrains (a server or runtime version, a profile, the database it
   selects) is a claim about the system - a hypothesis
   ([`decision-rounds`](../skills/decision-rounds/SKILL.md#recording-the-owners-answer),
   [`HYPOTHESES`](../templates/HYPOTHESES.template.md)).
3. **Index before reading** when the repository is large: above a few sessions of reading,
   direct reading is sampling in disguise. The sizing step measures it; above ~500 files the
   [level-3 trigger](../docs/ADOPTION-LEVELS.md#moving-up) is met before the first front.
4. **One pilot unit, end to end** - small, but born on a screen, written to the database and
   read back in a report. No big bang. The assessment proposes it; the owner decides it in
   Round 0.
5. **No code rewritten before the pilot's first full cycle.**
6. **Name the owner of the decisions** - from a signed document on Day 1, else as the
   first question of Round 0 ([INSTALLATION.md](../INSTALLATION.md), step 4): without a
   named owner the method does not work.

## Levels on this track

| Level | Typically from |
|---|---|
| 1 | Day 1: the vessel, the census; then the sizing, the pilot's assessment, the guardian's opinion on it and Round 0 |
| 2 | A recorded decision calls for the first change on the pilot unit (the first front); the level moves by the owner's answer, asked in the round that settles the pilot's first change, together with that change's plan and its go ([EK#26](../DECISIONS.md)) |
| 3 | The sizing step (a large legacy), a second person, or the base passing ~50 documents |
