# Profile: solo (one person works in the base)

**Scope**: method

For a case where one person - with their AI tools - is the only one who writes in the
knowledge base. The profile decides one thing the tracks do not: **where derived artifacts
live and who builds them** ([EK#5](../DECISIONS.md)). The other profile is [team](team.md);
the track ([legacy](legacy.md) or [greenfield](greenfield.md)) and the
[adoption level](../docs/ADOPTION-LEVELS.md) are chosen beside it.

## The artifact policy

A derived artifact is anything a tool rebuilds from the base or the code: code graphs, the
memory index database, generated catalogs and maps. In a solo case:

| Rule | How |
|---|---|
| Derived artifacts live **outside the versioned base** | a runtime area of the case: a folder beside the base (for example `../<kb-folder>-runtime/`) or a folder inside the base folder that version control ignores (for example `.runtime/`, [EK#27](../DECISIONS.md), [below](#a-runtime-folder-inside-the-base)) - the second when only the base folder may be written. Every versioned file writes it relative to the base's root, which the tools resolve from `--root` or `KB_ROOT` - never as an absolute machine path; never committed |
| They are **rebuildable** at any time | the markdown and the code are the source of record; deleting an artifact loses nothing |
| The one user builds them | no designated builder, no scheduled commit |

What implements it:

- **Code graphs**: each graph registry declares `**Profile**: solo`
  ([`REGISTRY_GRAPHS`](../templates/REGISTRY_GRAPHS.template.md)); the rebuild job warns
  when a solo graph's location is inside the base and never commits it
  ([`runtime/graph/`](../runtime/graph/README.md)). A registry without a Profile line is
  treated as solo.
- **Registers**: the projects registry takes the solo keys - `decisions_index`, `ledger`
  and `ledger_all` in the runtime area ([`REGISTRY_PROJECTS`](../templates/REGISTRY_PROJECTS.template.md),
  [registry tools](../runtime/registry/README.md)) - so the generated index and ledgers
  never land in the versioned base.
- **Memory index**: [`memory_index.py`](../runtime/memory_index.py) builds its database
  where `--db` says - a path in the runtime area, outside the versioned base; the close script rebuilds
  it from `checks.memory.db` of its configuration, written relative to the base's root the
  same way ([`runtime/close/`](../runtime/close/README.md)).
- **The case's `AGENTS.md`** names the runtime area in its derived-artifacts row
  ([template](../templates/AGENTS.template.md)).

## A runtime folder inside the base

When only the knowledge-base folder may be written (a managed machine, a sandboxed tool),
a sibling folder is impossible: the runtime area is then a folder inside the base folder
that version control ignores ([EK#27](../DECISIONS.md), refining EK#5). It stays outside
the versioned base - nothing in it is ever added or committed.

1. **Name it with a leading dot** - `.runtime/` in the examples. The registry tools find
   project folders by `root_globs`, and a glob such as `*` does not match a dot-named
   folder, so the area is never mistaken for a project.
2. **Ignore it before the first generated file lands in it**, at the base root:
   - git: the line `/.runtime/` in the base's `.gitignore`;
   - svn: `.runtime` in the `svn:ignore` property of the base root - read the current
     value first (`svn propget svn:ignore <kb-root>`), because `svn propset` replaces the
     whole list: `svn propset svn:ignore -F <file with the old lines plus .runtime> <kb-root>`.

   The ignore rule is itself a versioned change (`.gitignore`, or the property): prepared
   for the owner, committed with the owner's release word like any other.
3. **Check it**: `git -C <kb-root> check-ignore -v .runtime/probe` names the rule (git);
   `svn status --no-ignore <kb-root>` lists `I .runtime` (svn).

What the tools see:

- The close script's `scope` and `unversioned` checks read the change set from version
  control, so an ignored folder is never counted and needs no `checks.unversioned.ignore`
  entry. When the generated files show up as unversioned, the ignore rule is missing: fix
  the rule, not the check ([`runtime/close/`](../runtime/close/README.md)).
- The graph rebuild job warns when a solo graph's location is inside the base folder; it
  does not read the ignore rule yet, so a graph in the ignored folder warns too
  ([`runtime/graph/`](../runtime/graph/README.md)).
- Never the kit's folder: the tools refuse to write a case artifact inside the kit.

## Doors and decisions

- Hooks and gates are **warn-only** ([EK#6](../DECISIONS.md)); the one person turns a door
  blocking by a numbered decision of the project, like any other choice.
- Decisions need one namespace per project; a reserved range is needed only when the same
  person runs parallel sessions on one register ([EK#4](../DECISIONS.md)).
- "People are not roles" still applies: the owner of the decisions is named once, in the
  base ([`kb-setup`](../skills/kb-setup/SKILL.md) section 4) - on Day 1 only when a signed
  document names them, otherwise as the first answer of Round 0
  ([INSTALLATION.md](../INSTALLATION.md), step 4).

## What a solo case does not need

Pieces whose situation is a second person stay off: [`env-setup`](../agents/env-setup.md) and
its [install journal](../runtime/install-journal/README.md) (one machine, set up by its
user), [`weekly-report`](../skills/weekly-report/SKILL.md), the open-question onboarding
template ([`AREA_KNOWLEDGE`](../templates/AREA_KNOWLEDGE.template.md)), the ownership
partition of [`front-protocol`](../skills/front-protocol/SKILL.md) section 5. Review is the
owner's walk of the real application ([`delivery-gates`](../skills/delivery-gates/SKILL.md)).

## Moving to team

A second person writing in the base is a [level-3 trigger](../docs/ADOPTION-LEVELS.md#moving-up)
and a profile change, decided together (`KEY#N`): name the designated builder, move the
derived artifacts into a versioned folder of the base under its policy ([team](team.md)) -
an ignored runtime folder stays ignored, empty or removed - switch every graph
registry to `**Profile**: team`, and onboard the new person with
[`env-setup`](../agents/env-setup.md).
