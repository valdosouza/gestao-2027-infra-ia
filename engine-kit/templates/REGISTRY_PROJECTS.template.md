---
registry: projects
last_updated: <YYYY-MM-DD>
# configuration of runtime/registry/*.py (command-line options win; paths KB-root relative,
# resolved against --root or the KB_ROOT environment variable - never a machine path here)
root_globs:
  - "<glob of project-root folders, e.g. projects/*>"
subject_dir: SUBJECT
decision_register: "{path}/_REGISTRY/DECISIONS.md"
root_register: DECISIONS.md
# generated files, by profile (EK#5). team: versioned inside the base - the line below and
# the defaults (index and cross ledger next to this file). solo: in the runtime area, OUTSIDE
# the versioned base - replace the line below with the three commented lines, uncommented,
# the area written relative to the KB root: a folder inside the base that version control
# ignores (.runtime below - .gitignore or svn:ignore on the base root, EK#27) or a folder
# beside the base (e.g. ../acme-kb-runtime):
ledger: "{path}/_REGISTRY/LEDGER.md"
# decisions_index: ".runtime/DECISIONS-INDEX.md"
# ledger: ".runtime/{key}/LEDGER.md"
# ledger_all: ".runtime/LEDGER-ALL.md"
tenant_types: [tenant]
enforce_from: ""
scope_value: <case-key>  # or case (EK#2): the Scope line of the generated files
tags:
  - registry
  - projects
---
# Projects Registry - <knowledge-base name>

**Scope**: <method|case|mixed>

> Template from the engine-kit (`templates/REGISTRY_PROJECTS.template.md`). Save the
> filled copy as `_REGISTRY/PROJECTS.md` at the knowledge-base root (or pass `--projects`),
> fill every `<placeholder>` and delete this note. Every configuration key is described in
> the kit's `runtime/registry/README.md`.

The single inventory of the projects of this knowledge base. A project is a folder with
its own subjects, registers and decisions; its **key** is the row whose Path is that
folder - the only place where a key is chosen. Keys name decision namespaces (`KEY#N`).

- Add the row when the project folder is created: `projects_check.py` fails on a folder
  matched by `root_globs` without a row, on a row whose folder is missing, and on a
  duplicate key or folder.
- The row whose Path is `.` is the workspace: decisions about the whole knowledge base
  live in its root register (`root_register`).
- A row whose Type is listed in `tenant_types` is a tenant, isolated from the other
  tenants: `projects_check.py --check-scope --project KEY` fails when a change touches
  another tenant. Other types (shared code, a core product) may be touched by any change.
- Every log, card, pipeline and ticket document declares `project: <KEY>` in its front
  matter (`projects_check.py --check-touched`); a missing key warns until `enforce_from`.
- A project that moves to a new major version is a new row with a new key; its old
  registers are linked, not copied.

## Projects

Path is relative to the knowledge-base root (or to `paths_base`). Keep Path the last
backticked cell of a row.

| Key | Type | Name | Code tree | Path | Status |
|---|---|---|---|---|---|
| `<WORKSPACE-KEY>` | workspace | <the knowledge base itself> | - | `.` | active |
| `<KEY>` | <tenant or shared> | <project name> | `<code-tree path or repository URL>` | `<folder>` | active |

## Registers present (generated)

Rewritten by `projects_check.py --write`; do not edit between the markers.

<!-- BEGIN GENERATED -->
<!-- END GENERATED -->
