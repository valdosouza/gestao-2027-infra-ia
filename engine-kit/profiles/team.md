# Profile: team (more than one person works in the base)

**Scope**: method

For a case where several people - each with their AI tools - write in the same knowledge
base. The profile decides **where derived artifacts live and who builds them**
([EK#5](../DECISIONS.md)), and it brings the pieces that only exist because there is more
than one person. The other profile is [solo](solo.md); the track ([legacy](legacy.md) or
[greenfield](greenfield.md)) and the [adoption level](../docs/ADOPTION-LEVELS.md) are chosen
beside it. More than one person is itself a level-3 trigger.

## The artifact policy

A derived artifact is anything a tool rebuilds from the base or the code: code graphs, the
memory index database, generated catalogs and maps. In a team case:

| Rule | How |
|---|---|
| Derived artifacts are **versioned with the knowledge base** | everyone reads the same build, received with a normal VCS update |
| **One designated builder** rebuilds them, on a schedule | one machine, named in the registry; every other machine skips the build |
| The builder's commit carries **only** the artifacts | never a person's unfinished edit; the push is the builder's own step |

What implements it:

- **Code graphs**: each graph registry declares `**Profile**: team` and
  `**Designated builder**: <machine>` ([`REGISTRY_GRAPHS`](../templates/REGISTRY_GRAPHS.template.md)).
  [`rebuild-graphs.ps1`](../runtime/graph/rebuild-graphs.ps1) rebuilds on the builder only,
  `-Commit` commits only the registered graph folders, and `-StampRegistry` adds each
  registry it stamped only when that registry had no local change before the stamp
  ([EK#12](../DECISIONS.md)); `-Register` schedules it ([`runtime/graph/`](../runtime/graph/README.md)).
  A team registry without a designated builder gets a warning and no commit.
- **Memory index**: the designated builder runs [`memory_index.py`](../runtime/memory_index.py)
  `build` into the versioned location; the kit has no scheduled job for it yet, so the
  builder runs it with the graph rebuild or at its own closes.
- **The case's `AGENTS.md`** names the versioned folder and the builder in its
  derived-artifacts row ([template](../templates/AGENTS.template.md)).

## Working side by side

- **Decision ids never collide**: a parallel session works in its own namespace or a reserved
  range of numbers, and nobody renumbers ([EK#4](../DECISIONS.md),
  [`decision-rounds`](../skills/decision-rounds/SKILL.md)).
- **One writer per file, a worktree per front, an ownership partition** between groups that
  work at the same time ([`front-protocol`](../skills/front-protocol/SKILL.md) sections 4
  and 5).
- **People are not roles**: a role comes from the people registry the owner confirms, never
  from a tracker field ([`kb-setup`](../skills/kb-setup/SKILL.md) section 4).
- **Doors are warn-only** ([EK#6](../DECISIONS.md)). Turning one blocking changes everyone's
  work: it is a numbered decision of the team, announced before it lands. The hooks are
  turned on for the whole project by a versioned `.engine-kit/guards.json`
  ([`runtime/guards/`](../runtime/guards/README.md)).

## What it turns on

| Piece | Level | For |
|---|---|---|
| [`env-setup`](../agents/env-setup.md) + [`runtime/install-journal/`](../runtime/install-journal/README.md) | 3 | a person joins or changes machine: detect first, run only what is missing, every machine change undoable |
| [`AREA_KNOWLEDGE`](../templates/AREA_KNOWLEDGE.template.md) | 3 | one more developer on one area, through the open-question onboarding |
| [`weekly-report`](../skills/weekly-report/SKILL.md) + [`runtime/weekly/`](../runtime/weekly/README.md) | 3 | each person's week for whoever plans the work |
| [`folder-importer`](../agents/folder-importer.md) | 3 | people's scattered local working folders brought into the base, the first one supervised |
| [`result-review`](../skills/result-review/SKILL.md) | 2 | one person reviews another's result, with the open / acknowledged / resolved handshake |
