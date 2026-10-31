---
project: <KEY>
subject: <AREA>
work_items: [<id>]
date: <YYYY-MM-DD>
status: <draft | final | superseded>
language: <the case's artifact language>
exports: [<Topic>-<YYYY-MM-DD>.pdf]
tags:
  - deliverable
---
# <Topic> - <what the reader gets, in one line>

**Scope**: <method|case|mixed>
**Status**: <draft | final> - version <n>, <YYYY-MM-DD>
**Origin**: <the request, work item or session that produced it>
**References**: <the documents, cards, decisions (KEY#N) and revisions it rests on>

> Template from the engine-kit (`templates/DELIVERABLE.template.md`) - technique T92,
> *operating*. The record of anything someone will keep or share: this markdown, written in
> the case's artifact language, saved in the owning folder (never the root folder) as
> `<Topic>-<YYYY-MM-DD>.md`. A document, slide or spreadsheet version is an export generated
> from it and saved beside it with the same base name - list it under `exports`. Method: the
> `close-and-retain` skill, section "The deliverable gate". Replace every `<placeholder>`,
> keep the header lines, and delete this note.

## Summary

<What the reader needs first: the answer, the recommendation or the result, in a few lines.>

## <Body sections>

<The content.>

## Self-check (delete when final)

- [ ] In the artifact language
- [ ] In the owning folder, not the root, not a personal folder
- [ ] This markdown is the record; every binary is an export beside it, same base name
- [ ] Linked from the owning `INDEX.md`; the retention chain run in this task
- [ ] What it replaces is marked SUPERSEDED, pointing here
