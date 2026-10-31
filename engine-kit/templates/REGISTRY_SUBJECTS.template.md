---
knowledge_base: <project>
last_updated: <YYYY-MM-DD>
tags:
  - registry
  - subjects
---
# Subjects Registry - <project>

**Scope**: <method|case|mixed>

> Template from the engine-kit (`templates/REGISTRY_SUBJECTS.template.md`). Save the
> filled copy as `REGISTRY_SUBJECTS.md` next to the `SUBJECT\` folder it describes, fill
> every `<placeholder>` and delete this note.

All known business subjects. A subject is a business domain that spans one or more
source units and has its own pipeline documentation.

Status vocabulary (the first word of the Status cell; notes may follow it):
`documented` (INDEX has real content) - `skeleton` (folder + placeholder INDEX only) -
`in-progress` (analysis exists, no INDEX yet) - `notes-only` (loose reference notes,
no subject structure).

Kept honest by `runtime/validate-registry.ps1`: every row needs a `SUBJECT\<NAME>\`
folder and every folder needs a row; a `documented` row whose INDEX still says
"To be populated" fails validation. Subject names are UPPER_SNAKE.

An empty table - the header rows only - is valid until the project's first area: a new
project (a greenfield one always, until Round 0 closes) deletes the example row below.

| Subject | Path | Source Units | Status |
|---|---|---|---|
| <NAME> | [[SUBJECT/<NAME>/INDEX]] | <unit>, <unit> | skeleton |
