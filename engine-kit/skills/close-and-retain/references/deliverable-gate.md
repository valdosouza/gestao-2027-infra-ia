# Deliverable gate - language, place, format, before the file exists

**Scope**: method

Companion of [the close-and-retain skill](../SKILL.md), step 7 - technique T92, `operating`
(one case: a multi-developer product team; the gate was written the day an analysis for a
client was delivered in the chat's language, as binary documents only, in the root folder
of the knowledge base). It runs **before** a deliverable is created - not after - for every
artifact someone will keep or share: a closing record, an analysis, a report, a plan, a
review, a slide deck, a spreadsheet. Header:
[`templates/DELIVERABLE.template.md`](../../../templates/DELIVERABLE.template.md).

## 1. Language

- The case fixes **one artifact language** in its `AGENTS.md`; every artifact is written in
  it, whatever the chat language.
- **The chat follows the user**: explanations and summaries in the user's language;
  artifacts quoted verbatim in the artifact language.
- A copy in another language is made **only on request**, and it stays **outside** the
  knowledge base (a translation in the base is a second record that drifts).

## 2. Place

Resolve the owning folder first; create the standard folder when it is missing - do not ask
whether to create it, and do not invent a name.

| The work concerns | The deliverable goes to |
|---|---|
| A work item (bug, change request, task) | its ticket folder, `<project>/SUBJECT/<AREA>/TICKETS/<ID>/` |
| A client's work item, even when the code changed is the shared core | the client's project, not the core's |
| An area, with no single work item | the area folder (`<project>/SUBJECT/<AREA>/`, its reports sub-folder for packs) |
| The method or the base's own governance | the method's folder (the case's guide or orchestration folder) |
| A draft or a prompt being refined | the prompts folder - never loose at the root |
| A one-off analysis or report kept for the record | the history folder, with its index updated |

**Never the root folder** of the knowledge base, and never a personal or desktop folder:
per-person paths collide between people and leave the base. "Do not invent" forbids a
made-up place; it does not forbid creating the standard folder the formula names.

## 3. Format

- **The markdown is the record**: a title, the Scope line (`method | case | mixed`), status
  or version, date, origin and references
  ([template](../../../templates/DELIVERABLE.template.md)).
- **Binary formats are exports** - a word-processor document, a PDF, slides, a spreadsheet -
  generated from the markdown and saved **beside it with the same base name**. The binary is
  never the only copy: it has no diff, no search and no link.
- **Names**: `<Topic>-<YYYY-MM-DD>.md` in the artifact language, words joined by hyphens, no
  spaces. A ticket folder's fixed files keep their fixed names (`CLOSE.md`, `PLAN.md`).

## 4. Retention, in the same task

1. The Scope line is present (the census counts it - [`scope-census`](../../scope-census/SKILL.md)).
2. The owning `INDEX.md` links the deliverable.
3. An area that was analysed gets its episodic log.
4. A decision taken goes to its register ([`decision-rounds`](../../decision-rounds/SKILL.md)).
5. A deliverable it replaces is marked SUPERSEDED, never deleted.

## 5. Self-check before handing the file over

- [ ] In the artifact language?
- [ ] In the owning folder - not the root, not a personal folder?
- [ ] A markdown record with its Scope line and header?
- [ ] Every binary file an export beside its markdown, same base name?
- [ ] Linked from the owning index; the retention chain run in this task?

## 6. Regularising a misplaced deliverable

1. Write or recover the markdown record (from the binary, when that is all there is).
2. Move it with version control (`git mv`, `svn move`) so its history follows, to the
   owning folder, with a conforming name.
3. Regenerate the exports beside it; remove the old binaries from the wrong place by a
   prepared deletion (a human runs it).
4. Fix every link to the old place; a copy that must stay gets a SUPERSEDED mark pointing at
   the record.
5. A translation found inside the base leaves it, unless the owner decides otherwise.
