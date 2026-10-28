# Technical half (review-pack steps 3-7)

**Scope**: method

The "what it costs and where it lands" half of the pack: prior art, pipelines and
collisions, the concept verdict, placement, reuse, then the synthesis into options,
estimate, questions, risks and proposed decisions. Everything here is read-only
investigation; the only files written are the brief and the context. What goes in which
section of the brief is fixed by the
[brief template](../templates/REVIEW_BRIEF.template.md); this page says how to find it.

## Step 3 - Prior art

Question: **does the function already exist** - in core, in another client's project, in
this version or another?

- Query the code graph before reading code ([runtime/graph](../../../runtime/graph/README.md));
  then the area indexes of the core project and of the client's project; then the
  decision register (a "new" request is often an old decision re-raised - answer it with
  the decision id instead of opening a question).
- Where the case keeps business-rule files (the optional rule gate of
  [decision-rounds](../../decision-rounds/SKILL.md)), read the ones the change touches: a
  change that brings back the behaviour of a **Denied** row is a question for the round,
  quoted with that row - never an option the pack recommends silently.
- When the client runs a different version than the latest, compare the unit and its
  processes across the active versions (cross-version drift, planned for the kit's
  `version-diff` agent).
- Record a fact with its location ("exists in <unit>/<screen>, since <version>") or
  "No prior art." Partial prior art is the most valuable finding: it changes the
  estimate and usually the placement.

## Step 4 - Pipelines and collisions

- List every process the change touches. **Mapped**: link its map. **Unmapped**: map it
  now, or list it as "to map before coding" - the pipeline gate
  ([memory-engineering](../../memory-engineering/SKILL.md), section 4). A pack that hides
  an unmapped process hands the implementer a guess. (The process mapper is the
  [`pipeline-builder`](../../../agents/pipeline-builder.md) agent; the collision risk is
  section 5 of its [template](../../../templates/PIPELINE.template.md).)
- For each mapped process, read its collision-risk section.
- Add the change's own collisions:
  - other **open changes** on the same units or screens (a collision the meeting can
    resolve by ordering or merging them);
  - **locks** and concurrency (two users, two jobs, an import running while the screen
    saves);
  - **partitioned keys** (per site, per tenant, per company) and the contracts around them;
  - **imports, exports, reports and integrations** that read what the change writes;
  - **decisions already registered** that constrain the change (cite `KEY#N`).
- Every collision found here becomes at least one smoke item in the Dev Context
  (regression), so the implementer tests what the pack feared.

## Step 5 - Concept

Run [conceptual-guardian](../../conceptual-guardian/SKILL.md) whenever the change
introduces a table, a shared piece, a business concept or a pipeline entity. The brief
carries the verdict in one line: **concept** (one sentence, no "and") - **piece or
composition** - **pieces reused** - **what was left out**. A divergence (the change asks
for a scale model, the concept says otherwise) is a question or a proposed decision for
the round; the pack never resolves it alone.

## Step 6 - Placement and reuse

- **Placement**: core, per-client, or split. Apply the case's placement rule and state the
  reason in one paragraph, including **what changes for every other client if it goes to
  core** (a setting defaulting to the old behaviour, a migration, a screen change). A
  split (generic part in core, the client's variant in its project) is a real option when
  only part of the change is generic.
- **Reuse**: units, helpers, screens, reports and settings that already do part of the
  job (the case's settings register lists the flags and where they act). "None
  identified." is an acceptable answer, an unchecked one is not.

## Step 7 - Synthesis

### Options
At least two when a real choice exists (one may be "do nothing" or "defer"). Each says
what it gives and what it costs or risks; exactly one carries "(Recommended)". When there
is no real choice, say so in one line instead of inventing an option B.

### Estimate
- **Coding + developer test only**, in days, split into lines (server, screen, data,
  developer test). Confidence HIGH, MEDIUM or LOW; the assumptions that would move it.
- Days owned by other roles (QA, analysis, configuration, upgrade, documentation) are
  shown on a separate line for planning and **never** summed into the developer's figure.

### Questions
- Start from the requirements hand-over (open items and HIGH-impact unknowns), then add
  what steps 3-6 raised.
- **Fact or intent first** ([decision-rounds](../../decision-rounds/SKILL.md), step 0):
  what the code, a document or a recorded decision answers is a fact - answer it with
  evidence and do not ask it. Only intent becomes a question.
- Each question: the evidence it rests on, closed options when possible, one
  recommendation, the owner as a role ("the requester", "QA", or "owner to be assigned at
  the review"), and the impact if it stays unanswered.
- Numbered `Q1`, `Q2`... and never renumbered across rounds; the tracker text uses the
  same numbers.
- Write for the reader who will answer: one question per number, no compound "and"
  questions, no background the question does not need (the brief keeps the rationale).

### Risks
The top three to five, each with a mitigation: the business risks from the hand-over plus
the technical risks steps 3-6 found (collisions, unmapped processes, partial prior art,
placement side effects).

### Proposed decisions
`P1`, `P2`... - what the meeting must decide, each with the recommended answer. They are
proposals, not decisions: each becomes `KEY#N` in the case's register only when the
meeting or an answer settles it. (The `P` prefix avoids confusion with a namespace such as
`D-XY2`, which the kit reads as `XY#2`.)

## Example (CR-123)

- **Prior art**: the order screen already splits an order into two when stock is short
  (core, every client) - partial prior art; the change may extend it rather than add a
  new flow.
- **Collisions**: CR-118 (open) changes the same shipment unit; the nightly stock import
  reads outstanding units; `ORD#9` says an order's status is derived, never stored.
- **Concept**: a partial shipment is a **shipment** (piece) linked to an order line with a
  quantity - not a "sub-order" (scale model). Pieces reused: order, order line, shipment.
- **Placement**: core, behind a setting that defaults to off - other clients see no
  change until they turn it on.
- **Options**: A. extend the existing split (Recommended) - B. a new partial-shipment
  screen.
- **Estimate**: 3 days coding + developer test, confidence MEDIUM (assumes CR-118 lands
  first); QA 1 day, configuration 0.5 day, shown apart.
