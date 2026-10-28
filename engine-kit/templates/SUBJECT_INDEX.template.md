---
subject: <NAME>
project: <project>
version: <version>
last_updated: <YYYY-MM-DD>
tags:
  - subject
---
# <NAME> - Subject Index

**Scope**: <method|case|mixed>

> To be populated: one paragraph describing the business domain this subject covers.
> (While this line is here the subject is a `skeleton`; the validator rejects it as
> `documented`.)

## Source Units

- [[<unit>]] - what it does (one line)

## Pipelines

Rows written by the pipeline builder; a path checked absent:
`<pipeline>: not on this line, checked at <revision>`.

| Pipeline | Trigger Condition | Status |
|---|---|---|
| [[PIPELINES/<PIPE_NAME>]] | <when it runs> | documented <YYYY-MM-DD> |

## Settings

Rows written by the settings mapper.

| Setting | Source | Effect on this subject |
|---|---|---|
| <flag> | <config file / code constant / per-client override> | <what it bifurcates> |

## Knowledge

Atomic cards in [[KNOWLEDGE/]] - one reusable rule per file, cited by id, one line each:

- K-<id> - <rule> ([[KNOWLEDGE/<file>]])

## Memory

Session logs in [[MEMORY/]] - newest first, with claims front matter (indexed by
`runtime/memory_index.py`). Typed claims (`type: correction | missed | wrong | collision`)
feed the feedback-analyst loop.
