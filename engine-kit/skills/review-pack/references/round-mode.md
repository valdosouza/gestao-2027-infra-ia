# Round mode (review-pack steps 10-14)

**Scope**: method

What happens when the answers to a handed-over pack come back. The goal is the one the
pack had before the meeting: **nobody re-reads the ticket by hand**. The agent reads the
answers, quotes them, classifies them, turns the settled ones into permanent decisions,
re-plans what they change and re-presents only what is still open.

## Triggers

- The pack owner says the answers are in ("the answers to CR-123 are in").
- A context refresh shows the tracker's questions field changed since the hand-over.
- The change moved state (it came back from "waiting for the requester").

Same rules as the pack: read-only on the tracker and the planning sheets; every outward
text prepared for a human; nothing leaves before the pack owner confirms it.

## Step 10 - Read back (read-only)

Read, in this order:

1. **The questions field**: parse each numbered item and the text after its `Answer:` line.
   An answer typed elsewhere in the field (under the wrong number, at the end) is still an
   answer - attach it to the question it answers and note where it was found.
2. **The discussion** since the hand-over date: answers often arrive as comments.
3. **Attachments**: a new version of the change document changes the scope - it re-runs
   step 2 in step 12.
4. **State and flags**: as facts, for the round header.
5. **The planning sheets** the pack cited: an entry may have been answered there.

Record **who answered and when** as field values ("changed by <name>, <date>"; "comment
by <name>, <date>"). That is a fact about the tracker, not a role: the answerer is "the
requester" only if the people register or the signed change document says so.

## Step 11 - Classify

Every question of the round gets exactly one class; every answer is quoted **verbatim**,
never paraphrased, never trimmed into a different meaning.

| Class | When | What happens |
|---|---|---|
| **answered** | the answer settles the question without a condition the pack cannot check | registered as a decision (step 12); leaves the published questions field |
| **partial** | it settles part of the question, or settles it with a condition ("yes, unless...") or a "for now" | the settled part is registered; the remainder becomes a **new** numbered follow-up ("follow-up to Q2"); the original is marked "partial -> Q5" |
| **open** | no answer, or a reply that does not answer ("will check", "see attached" with nothing relevant attached) | stays with the same number and the same text |
| **new** | the requester raises a question or a requirement of their own | gets the next number; when it changes scope it triggers step 12's re-run |

- **Show the classification, and the decision rows it implies, to the pack owner before
  registering anything.** Classifying
  is a judgment; an answer that reads as settled may hide a condition. When in doubt, the
  class is **partial**, never answered.
- A published question is never reworded. A narrower question is a new number.

## Step 12 - Decide (decision-rounds)

- Each answered question, and the settled part of a partial one, becomes **`KEY#N`** in
  the case's decision register, with the next free number of the namespace
  ([decision-rounds](../../decision-rounds/SKILL.md); register
  [template](../../../templates/DECISIONS.template.md)). The register row carries:
  - the decision in one sentence;
  - the **verbatim** answer;
  - the source: "<ID> questions field, answer to Q<n>, <name as field value>, <date>"
    (or "discussion comment" / "planning sheet <title>, tab <tab>, question as written");
  - the why, when the answer gave one;
  - the option it took - and, when that is not the recommended one, the mark
    "DIVERGED from the recommendation (<option>)": divergences show where the pack read
    the evidence wrong, so they are never smoothed into "as recommended".
- The question points to what it became: `CR-123 Q1 -> ORD#14`.
- An answer that **revises** an earlier decision registers a new number and marks the old
  one "REVISED by KEY#N" - nothing is deleted or renumbered.
- Where the case keeps business-rule files (the optional rule gate of decision-rounds), an
  answer that changes what a user sees is also a new row in that rule's history.
- After registering, **regenerate the decisions index and run the citation check** on the
  brief and the context ([runtime/registry](../../../runtime/registry/README.md)): a cited
  `KEY#N` that is not in its register fails.
- **Re-run what the answer moves**:
  - scope, placement or estimate changed -> steps 3-7 for the affected sections
    (pipelines, collisions, options, estimate, risks);
  - a new version of the change document -> step 2 as well: a new requirements file, the
    old one marked SUPERSEDED, then steps 3-7.
- Proposed decisions (`P1`...) that the meeting took are registered the same way, source
  "review meeting <date>", as the pack owner reports them.

## Step 13 - Re-present

- **Brief, section 0 (Rounds)**: one new row in the rounds table, and a **Round N block
  prepended** above the previous rounds: question as published, answer verbatim (who,
  when), class, consequence (`KEY#N`, section changed, still open, follow-up `Qm`). Then
  one line: what changed in options, estimate and placement; the new question numbers.
- **Brief, other sections**: updated **in place** (the rounds block keeps the history).
  Questions keep their numbers; answered ones point to their decision (`Q1 -> ORD#14`) in
  the brief only, never in the tracker text.
- **Dev Context**: decisions in force (the new ids), do-not-touch (an answer often moves a
  boundary), smoke checklist when the scope changed.
- **Tracker texts, rebuilt** (rules in the brief template):
  - the **summary** gains one line, `Update <date>: <what changed in estimate, scope or
    placement>. <n> answers registered, <n> questions open.` - or "no change to estimate
    or scope". It never retells the change;
  - the **questions field** carries only what is still open plus the new questions, each
    with an empty `Answer:` line, or the single line "No open questions."

## Step 14 - Confirm, hand over, retain

- Show the pack owner the two rebuilt texts (the classification and the registrations were
  confirmed at step 11); one change at a time.
- After the confirmation, hand the texts to the human who pastes them. The tracker's field
  history keeps the requester's original text; the agent never rewords it. If the tracker
  keeps no history of the field, the human appends the round instead of replacing it.
- Session log with claims; queue row "round N handed over" if the case keeps a queue page.
- When nothing is left open, tell the human the change can leave the "waiting for the
  requester" state. Moving it stays human.

## Worked round (CR-123, round 2)

Questions handed over in round 1 (numbers as published):

1. May a partial shipment be cancelled after dispatch?
2. Should the outstanding units keep the order's original delivery date?
3. Is the over-shipment message wording yours to provide?
4. Must the nightly stock import see partial shipments the same day?

Read back - questions field and one discussion comment (names are field values):

| Q | Answer (verbatim, who, when) | Class | Consequence |
|---|---|---|---|
| 1 | "No. Once dispatched it stays; returns are a separate process." (changed by <name>, 2026-10-14) | answered | `ORD#14` - no cancel after dispatch; smoke item "cancel after dispatch is refused (ORD#14)" added to the Dev Context |
| 2 | "Keep it for now, but we may want a date per shipment later." (changed by <name>, 2026-10-14) | partial | `ORD#15` - keep the original date in this change; follow-up **Q5** |
| 3 | - | open | stays as Q3 |
| 4 | "Yes, same day." (comment by <name>, 2026-10-15) | answered | `ORD#16`; collision with the nightly import confirmed - estimate +0.5 day |
| 6 | "Can the clerk choose which warehouse ships?" (comment by <name>, 2026-10-15) | new | scope change - steps 4-7 re-run; placement unchanged, estimate open until answered |

New and follow-up questions: **Q5** (follow-up to Q2) "Per-shipment delivery dates: in
this change or in a later one?" (Recommended: a later one). **Q6** as raised, with the
pack's options attached in the brief.

Rebuilt texts, ready to paste after the pack owner confirms:

```text
Update 2026-10-16: estimate 3.5 days (was 3), the nightly import must see partial shipments the same day. 3 answers registered (one partial), 3 questions open.
```

```text
3. Is the over-shipment message wording yours to provide?
   Answer:
5. Per-shipment delivery dates: in this change or in a later one?
   Answer:
6. Can the clerk choose which warehouse ships?
   Answer:
```

The register gains `ORD#14`-`ORD#16`; the brief's section 0 gains the round 2 block above
round 1; the Dev Context lists `ORD#14`-`ORD#16` as in force and adds "returns process" to
do-not-touch.
