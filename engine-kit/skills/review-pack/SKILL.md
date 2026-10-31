---
name: review-pack
description: Prepares the review pack of one change request (or any significant change) before its review meeting, so that discovery happens before the meeting and the meeting only decides. Reads the ticket and any planning sheet read-only, runs the requirements analysis, prior art, pipelines and collisions, the conceptual-guardian verdict, core vs per-client placement and reuse, then writes a two-page Review Brief that ends with the texts ready to paste into the tracker, and a Dev Context pack for the implementer's own AI. Round mode reads the answers back, quotes and classifies them, registers the answered ones as decisions and re-presents the rest. Use when a change review is scheduled, when asked to prepare a change request for review ("prepare the pack for CR-123", "review brief for this change", "get this CR ready for the meeting"), or when answers to a published pack arrive ("the answers to CR-123 are in").
---

# Skill: Review pack (discovery before the meeting, answers back as decisions)

**Scope**: method
**Maturity**: operating

**When to use**: a change request - or any change big enough to be reviewed by more than
one person before it is built - has a review meeting coming, or someone asks for it to be
"prepared". Also, in **round mode**, when the answers to a published pack come back.
**Not for**: designing or implementing the change (the pack stops at options and a
recommendation; the meeting decides), nor a bug investigation.
**Real origin**: one case - a multi-developer product team preparing change requests
from more than one client for their review meeting (2026-09 to 2026-10): about fourteen
packs, three of them carried through at least one answer round. The rules below are the
corrections that case made along the way (see
[Anti-patterns](#anti-patterns)). One case,
core by choice: `operating` ([maturity](../../docs/MATURITY.md)); technique T85 in the
[register](../../docs/TECHNIQUES.md).
**Hands off to**: [`decision-rounds`](../decision-rounds/SKILL.md) (every answer that
settles something becomes a numbered decision `KEY#N`),
[`conceptual-guardian`](../conceptual-guardian/SKILL.md) (the concept verdict),
[`memory-engineering`](../memory-engineering/SKILL.md) (the pipeline gate and the session
log) and [`retain-knowledge`](../retain-knowledge/SKILL.md) (the update chain). The
requirements half is the requirements pipeline of
[`frame-greenfield`](../frame-greenfield/SKILL.md)
([procedure](../frame-greenfield/references/requirements.md), technique T18), run in its
`pack` profile; the file follows
[`templates/REQUIREMENTS.template.md`](../../templates/REQUIREMENTS.template.md).

---

## The principle

A meeting that discovers cannot decide. When the people around the table learn during
the meeting that the function half exists already, that two other open changes touch the
same units, or that nobody knows who can answer the key question, the meeting ends with
"let's look into it" and the change waits another cycle.

**The pack removes discovery from the meeting; the meeting keeps the decision.** The
agent reads everything beforehand, read-only, and arrives with: what was asked, what
already exists, what it collides with, where it belongs, what it costs, which options
there are (one recommended), and the numbered questions only a human can answer. When
the answers come back, the agent quotes them, classifies them, turns the settled ones
into permanent decisions and re-presents what is still open - nobody re-reads the ticket
by hand.

Example used throughout the skill (fictional): **CR-123, "Acme Orders: allow a partial
shipment of an order"**, decisions registered in the project namespace `ORD`.

## Vocabulary

| Term | Meaning |
|---|---|
| Change | the change request (or significant change) under review; one pack per change |
| Pack owner | the human the agent works for; confirms the pack, the questions and every outward text before anything leaves |
| Requester | whoever asked for the change and holds the answers (a client, a business owner); a role, never deduced from a name |
| Tracker | the work-item system where the change lives; **read-only** for the agent |
| Planning sheet | any spreadsheet or board where planners already asked and answered things about the change; read-only |
| Round | one cycle: texts handed over -> answers arrive -> answers registered -> remaining questions re-presented |

## Hard rules

1. **Read-only on trackers and planning sheets; every write is prepared for a human.**
   The agent never changes a field, a state, a flag, a link, a comment or a sheet cell. It
   prepares the exact texts; a human pastes them (prepare-only, technique T29). Keep the
   tracker's write tools on the [harness ask-list](../../runtime/guards/HARNESS-PERMISSIONS.md)
   so a slip stops at a prompt instead of reaching the requester.
2. **One owner file per content type** ([table below](#who-owns-what)). The brief and the
   context never repeat each other. A key (a pipeline name, a decision id, a scenario id)
   may appear in both; its content lives in one, the other points to it.
3. **The pack recommends, the meeting decides.** Options carry "(Recommended)"; open
   choices are numbered proposed decisions; every question has evidence, closed options
   when possible and one recommendation ([`decision-rounds`](../decision-rounds/SKILL.md)).
4. **Questions leave only after the pack owner confirms them**, one change at a time,
   with the exact text shown first. That confirmation is the pack owner's release word
   ([`decision-rounds`](../decision-rounds/SKILL.md)): deciding what to ask is not
   releasing it. A question the pack owner rewords is handed over as reworded; one they
   strike is not handed over.
5. **People are not roles** - stated once in the case's `AGENTS.md`
   ([template](../../templates/AGENTS.template.md), section "People are not roles"). In
   short: a role comes only from the case's people register or the signed change
   document; a tracker field ("Assigned to", "Requester"), comment activity or query
   ownership is a **fact to quote** ("Requester field: <name>"), never a role. Without a
   source, write the role without a name ("the requester", "QA") or "owner to be assigned
   at the review". In this skill every stakeholder entry carries `role_source: document |
   register | unconfirmed`, and the brief's header has no role field for a named person.
6. **The estimate is coding + developer test only.** Days owned by other roles (QA,
   analysis, configuration, upgrade) are listed separately for planning and never quoted
   as the developer's figure.
7. **Pipeline gate**: every process the change touches is either linked to its map or
   listed "to map before coding" - never silently skipped
   ([`memory-engineering`](../memory-engineering/SKILL.md), section 4).
8. **Answers are quoted verbatim, never paraphrased**, and an answer that departs from the
   recommendation is recorded as a divergence. Question numbers are local to the change
   (`Q1`, `Q2`...; the tracker shows "1.", "2."; elsewhere cite `CR-123 Q2`); an answered
   one points to its decision (`CR-123 Q2 -> ORD#15`). No number is ever reused or
   renumbered; a published question is never reworded - a narrower follow-up gets a new
   number.
9. **Deliverable rules**: the case's artifact language, a `**Scope**` line, output in the
   change's folder of the versioned knowledge base - never a desktop, never the root.

## Who owns what

| Content | Owner file | Never repeated in |
|---|---|---|
| Problem, functional and non-functional requirements, business rules, acceptance criteria (Given-When-Then), test scenarios (positive, negative, boundary, regression) | `<ID>_Requirements.md` (step 2) | brief, context (both link it) |
| The ask in five lines, planning-sheet entries (verbatim), prior art, concept verdict, placement, pipelines touched and collisions, reuse, options, estimate, questions, risks, proposed decisions, rounds, tracker texts | `<ID>_Review_Brief.md` ([template](templates/REVIEW_BRIEF.template.md)) | requirements (it hands its risks and open items over once, frozen), context |
| What the implementer's AI loads: rules and decisions in force (by id), knowledge pointers, steps that change per pipeline, contracts and invariants, settings, units and call sites, do-not-touch, smoke checklist | `<ID>_Dev_Context.md` ([template](templates/DEV_CONTEXT.template.md)) | brief |
| Decision texts | the case's decision register ([template](../../templates/DECISIONS.template.md)) | brief and context cite `KEY#N` (the brief's round block keeps the verbatim answer only as evidence) |

The requirements file is **never edited after the pack**: answers, estimate revisions
and new questions live in the brief. A new version of the change document produces a new
requirements file; the old one is marked SUPERSEDED.

## Inputs

- The change id and its tracker (read access). Optional: the meeting date; the owning
  project when the tracker does not say it.
- Read access to: the change document (usually an attachment), the planning sheets the
  case registers, the code graph and area indexes of the core project and of the
  client's project, the decision register, the settings register.

## Steps - pack mode

0. **Context refresh** (at the start of a pack or of a round, never on a timer). Read the
   planning sheets the case registers, only the tabs and rows that mention the change's
   screen, process or id. Quote an entry by sheet title (and its key in the case's
   sources register), tab and **the question text as written** - never by row number,
   never by a nickname the reader cannot open. A sheet missing from the register is
   registered first (id and link): a citation nobody can open is worthless.
1. **Ticket.** Read the change read-only (fields, discussion, links, attachments) into an
   intake dossier; reuse one from the current week and say so (shared intake, step 0 of
   [`change-gate`](../change-gate/SKILL.md)). Copy the change document into the change's folder.
2. **Requirements half** - the "what was asked": problem, requirements, Given-When-Then,
   scenarios, from the document and without reading code, in the **pack profile**
   (business-only, ending with a frozen hand-over of risks and open items). Procedure:
   [the requirements pipeline](../frame-greenfield/references/requirements.md), profile
   `pack`; file structure:
   [`templates/REQUIREMENTS.template.md`](../../templates/REQUIREMENTS.template.md).
   Reuse an existing requirements file when the change document has not changed since.
3. **Prior art** - does the function already exist, in core or per client, in this
   version or another (in another version: the
   [`version-diff`](../../agents/version-diff.md) agent)? Graph first, then indexes.
   "Exists in <unit/screen>" or "No prior art."
4. **Pipelines and collisions** - the processes touched (mapped: link; unmapped: map now
   or "to map before coding"), each map's collision section, plus the change's own
   collisions: other open changes on the same units, locks, partitioned keys, imports,
   exports, reports, decisions already registered.
5. **Concept** - [`conceptual-guardian`](../conceptual-guardian/SKILL.md) whenever the
   change introduces a table, a shared piece, a business concept or a pipeline entity.
   One-line verdict in the brief; a divergence becomes a question for the round, never a
   choice the pack makes.
6. **Placement and reuse** - core vs per-client proposal with its reason (the case's
   placement rule; what changes for every other client if it goes to core); units,
   helpers, screens and settings to reuse.
7. **Synthesis** - fill the two templates. The brief's questions start from the
   requirements hand-over (open items and HIGH-impact unknowns) plus what steps 3-6
   raised; its risks from the hand-over's business risks plus the technical risks found.
   Split fact from intent first ([`decision-rounds`](../decision-rounds/SKILL.md) step 0):
   what the code or a recorded decision answers is answered, with evidence, never asked.
   Investigation detail for steps 3-7:
   [references/technical-half.md](references/technical-half.md).
8. **Retention** - the change's folder linked from its area index; a session log with
   claims ([`memory-engineering`](../memory-engineering/SKILL.md)); the review-queue row,
   if the case keeps a queue page, set to "pack ready"; the proposed decisions listed as
   pending - they enter the register only when answered or decided at the meeting.
9. **Confirm and hand over** (prepare-only). Show the pack owner the questions and the two
   tracker texts, one change at a time. After the confirmation, hand the texts to the
   human who pastes them; record the hand-over (date, who confirmed) in the session log
   and the queue row ("handed over, round 1"). Moving the state, flagging, mentioning
   people and setting dates stay human.

## Round mode - when the answers arrive (steps 10-14)

Trigger: the pack owner says the answers are in, a context refresh shows the questions
field changed since the hand-over, or the change moved state. Same rules as pack mode:
read everything, write nothing outside the knowledge base. Full procedure and a worked
example: [references/round-mode.md](references/round-mode.md).

10. **Read back** (read-only): the questions field (each numbered item and the text after
    its `Answer:` line), the discussion since the hand-over, new attachments (a new
    version of the change document changes the scope), the state. Who answered and when
    is recorded as a field value - a fact, not a role.
11. **Classify** every question of the round as **answered**, **partial**, **open** or
    **new** (raised by the requester), each answer quoted verbatim. Show the table to the
    pack owner; an ambiguous answer is partial, never answered.
12. **Decide** ([`decision-rounds`](../decision-rounds/SKILL.md)): each answered question
    (and the settled part of a partial one) becomes `KEY#N` in the case's register, with
    the next free number and its source ("<ID> questions field, answer to Q<n>, <name as
    field value>, <date>"); a divergence from the recommendation is written as one. Then
    regenerate the decisions index and run the citation check
    ([runtime/registry](../../runtime/registry/README.md)). An answer that changes scope,
    placement or estimate re-runs the affected steps 3-7; a new change document re-runs
    step 2 as well.
13. **Re-present**: prepend a Round N block to the brief (question, answer verbatim,
    class, consequence), update the affected sections in place, update the context's
    decisions in force and do-not-touch list, and rebuild the tracker texts: the summary
    gains one "Update <date>:" line, the questions field carries only what is still open
    plus the new questions.
14. **Confirm, hand over, retain** - as step 9. Never reword the requester's text. When no
    question is left open, tell the human the change can leave the "waiting for the
    requester" state.

## Output location and names

`<area>/TICKETS/<ID>/` in the owning project's part of the knowledge base (the case's
placement formula decides the project; create the folder rather than asking):
`<ID>_Requirements.md`, `<ID>_Review_Brief.md`, `<ID>_Dev_Context.md`, the intake dossier
and the change document side by side. For CR-123: `ORDERS/TICKETS/CR-123/CR-123_Review_Brief.md`.

## After the meeting (humans)

- The meeting takes the proposed decisions; the pack owner tells the agent, which
  registers them (`KEY#N`, source "review meeting <date>") and updates the brief.
- Answers are typed under each question in the tracker by whoever holds them; then the
  agent runs round mode - nobody re-reads the ticket by hand.
- The implementer starts from `<ID>_Dev_Context.md`; the case's closing step finishes the
  change and cites the decision ids in code and commit.

## Anti-patterns

- **Two estimates in one folder.** The requirements analysis said 2.5 days, the brief 3.5.
  Fix: the requirements half runs business-only in a pack and hands its risks and open
  items over once; the brief is the only owner of the estimate.
- **The developer's figure inflated by other roles' days.** QA, analysis and
  configuration days are listed apart, never summed into the coding estimate.
- **A summary field that retells the analysis.** Its reader prices and schedules the work;
  four to six lines, only what changes price, scope or timeline, plus where the full
  analysis lives.
- **A planning-sheet citation by row number.** Rows move; quote the question as written.
- **"<name>, the PM" from the Assigned-to field.** A field holds a name, not a role.
- **Questions without a recommendation.** They are the ones that stall or diverge.
- **Publishing on the agent's own initiative.** Questions reach the requester only after
  the pack owner read them; a wrong question costs a round.

## Files in this skill

| File | Role |
|---|---|
| `SKILL.md` | this procedure |
| [references/requirements-half.md](references/requirements-half.md) | step 2: a pointer to frame-greenfield's requirements pipeline (pack profile) |
| [references/technical-half.md](references/technical-half.md) | steps 3-7: prior art, pipelines and collisions, concept, placement, reuse, options, estimate, questions, risks |
| [references/round-mode.md](references/round-mode.md) | steps 10-14 in detail, with a worked round of CR-123 |
| [templates/REVIEW_BRIEF.template.md](templates/REVIEW_BRIEF.template.md) | the two-page brief, ending with the tracker texts |
| [templates/DEV_CONTEXT.template.md](templates/DEV_CONTEXT.template.md) | the implementer's AI context, with do-not-touch and smoke lists |
