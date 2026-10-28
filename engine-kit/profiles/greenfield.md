# Profile: greenfield (the new-project track)

**Scope**: method

For a project that starts from an idea, not from a running system: a draft, loose notes, a
master prompt, perhaps a pasted schema. The work is to turn the draft into decisions the
owner has taken, then to build in composable pieces behind gates. The other track is
[legacy](legacy.md); the team profile ([solo](solo.md) or [team](team.md)) and the
[adoption level](../docs/ADOPTION-LEVELS.md) are chosen beside this one. Steps:
[INSTALLATION.md](../INSTALLATION.md).

## The track

| | Greenfield |
|---|---|
| **Day 1** | The vessel ([`kb-setup`](../skills/kb-setup/SKILL.md)). A census ([`scope-census`](../skills/scope-census/SKILL.md)) only when documents already exist - the draft and its notes are classified like any other |
| **Entry** | Frame: the draft organised as it is -> Round 0 -> a closed prompt and its requirements ([`frame-greenfield`](../skills/frame-greenfield/SKILL.md) with [`decision-rounds`](../skills/decision-rounds/SKILL.md)) |
| **Then** | The same cycle as the legacy track, per front: the guardian before any domain object, as while framing ([`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md)), then [`front-protocol`](../skills/front-protocol/SKILL.md), [`change-gate`](../skills/change-gate/SKILL.md), [`test-gate`](../skills/test-gate/SKILL.md), [`delivery-gates`](../skills/delivery-gates/SKILL.md), [`close-and-retain`](../skills/close-and-retain/SKILL.md) |
| **Success** | One front taken from the draft to delivery through the gates, with its decisions recorded |

## What it turns on

At level 1, on top of the essential pieces - which include, on both tracks, the whole
[`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md) with
[`OCCUPIED_WORDS`](../templates/OCCUPIED_WORDS.template.md) and the
[`FRONT_PROMPT`](../templates/FRONT_PROMPT.template.md) skeleton the organised draft is
written on, with no borrowing decision ([EK#25](../DECISIONS.md), revising EK#23) - the
track entry:

- [`frame-greenfield`](../skills/frame-greenfield/SKILL.md): the draft organised without
  rewriting it, Round 0, the closed prompt.
- [`REQUIREMENTS`](../templates/REQUIREMENTS.template.md): the requirements of the closed
  prompt, written from the document, not from code.

Candidates of the track, each at its own level and turned on by its situation:

| Piece | Level | Turn it on when |
|---|---|---|
| [`official-source-archive`](../skills/official-source-archive/SKILL.md) | 2 | an official norm governs a requirement |
| [`mold-factory`](../skills/mold-factory/SKILL.md) | 2 | a family of similar pieces (endpoints, screens, modules) is about to be built |
| [`disposable-proof`](../skills/disposable-proof/SKILL.md) | 2 | the first seed, schema migration or cutover |
| [`browser-verification`](../skills/browser-verification/SKILL.md) | 2 | the first change a user can see |
| [`fences`](../skills/fences/SKILL.md) | 3 | an invariant starts to drift silently (catalog rows the code depends on, a closed list of writers) |

## Rules of the track

1. **The draft is organised as it is.** Its words, order and doubts are kept; what is unclear
   gets a mark, not a guess. Rewriting the draft before Round 0 hides the owner's intent.
2. **Nothing is decided for the owner.** Every architecture or business choice becomes a
   numbered question with closed options and one recommendation; the answer becomes `KEY#N`
   and the code cites it.
3. **No production behaviour before the go.** The closed prompt and its decisions come
   first, then the code gate's go on the first wave's plan - asked in the round that closes
   the prompt ([EK#26](../DECISIONS.md)). The red's tests and a new unit's stub may exist
   before it ([EK#28](../DECISIONS.md)); nothing leaves the working copy before the release
   word. While the owner has not answered, a followed recommendation is an assumption to
   ratify.
4. **The guardian before any domain object.** A new table, shared piece or business concept
   passes the scale-model test before any schema or code exists.
5. **The first front is the pilot.** It runs the whole cycle before a second front opens -
   the counterpart of the legacy track's single pilot unit, and the track's success
   criterion.

## Levels on this track

| Level | Typically from |
|---|---|
| 1 | Day 1: the vessel and the framing, up to the closed prompt |
| 2 | The first front: the prompt is closed (its State line says so), and the level moves by the owner's answer - asked in the round that closes the prompt, together with the first wave's plan and its go ([EK#26](../DECISIONS.md)) |
| 3 | The base passing ~50 documents, or a second person joining |
