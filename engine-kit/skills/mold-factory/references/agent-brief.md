# Agent brief, agent report, verification sheet

**Scope**: method

Companion of [the mold-factory skill](../SKILL.md), sections 5 to 7. The brief is the
whole of what a generating agent knows: it does not see the conversation that produced
the molds, so anything left out of the brief is guessed. Keep the brief of each wave
next to the plan - it is also the relaunch template when an agent has to run again.

## The brief

```markdown
# Brief - wave <n>, agent <letter>: <pieces>

## Your pieces
| Piece | Mold | Schema objects | Legacy counterpart (behaviour only) |
|---|---|---|---|

## Molds
- Read the mold cards: <path>#<mold>, <path>#<mold>.
- Read the mold files: <paths>. Copy their structure; change only the variation points.

## Schema extract (the only source of columns)
<the extract for your pieces: table, column, type, null, key, constraint>
Known schema findings: <legacy columns that do not exist, ignored NOT NULL columns, ...>

## Rules (answer each one in your report)
1. ...
9. ...

## File set
- Create: <paths>
- May modify: <paths, usually none>
- Never touch: the molds, the mold cards, the shared files (<list>), other agents' pieces.
- Need a line in a shared file? Put it in your report, section "Shared-file requests".

## Done means
- Each piece's files exist, build and type check clean, its tests run green.
- The report below, complete.
- No commit, no write to any shared database, no decision taken: questions go in the report.
```

## The report (what the agent returns)

```markdown
# Report - wave <n>, agent <letter>

## Pieces
| Piece | Files written | Build | Tests (found / passed) |
|---|---|---|---|

## Rules
| Rule | Piece | Yes / No | Evidence (file:line, command output) |
|---|---|---|---|

## Deviations from the mold
| Piece | File:line | What differs outside the variation points | Why |
|---|---|---|---|

## Schema findings
| Piece | Legacy reads / writes | Schema says |
|---|---|---|

## Shared-file requests
| File | Line(s) to add | For piece |
|---|---|---|

## Questions (numbered locally; the conductor renumbers)
| # | Question | Options | Recommendation |
|---|---|---|---|
```

## The conductor's verification sheet

One row per piece; a piece is integrated only when every column holds.

| Check | How | Pass |
|---|---|---|
| Files on disk | list the file set; compare with the report | every file present, nothing outside the file set touched (status of the working copy) |
| Build, type check | the project's build ([`build-analyst`](../../../agents/build-analyst.md) on a compiled stack) | clean, or every risky item a finding |
| Tests | run the piece's tests | found as many as the mold's equivalent list; all green |
| Schema | search the piece's code for table and column names; compare with the extract | no name outside the extract |
| Rules | each rule with its evidence, re-checked where a script can | all yes, or a justified deviation |
| Diff to the mold | compare each file with the mold file it came from | differences only at the variation points, or listed and justified |
| Questions | read them | renumbered into the home register with a from -> to table |
| Shared files | apply the requests | written by the conductor, once, after the wave |

When an agent ends without a report, or its report and the disk disagree, the disk wins:
verify the pieces as they are, and relaunch the brief for what is missing - never accept
"done" on the report alone.
