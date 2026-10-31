---
name: weekly-report
description: Use when a person reports their week to whoever plans the work - what was done and handed over, what is pending and how much time it still needs - built only from evidence (their commits by the author field, tracker items they changed, dated by the change date). Prepares the report; the person sends it.
---

# Skill: Weekly report (worked and handed over, by evidence)

**Scope**: method
**Maturity**: candidate

Ran in one case, every week, for several developers; optional: only a team whose people
report their week to a planner needs it.

**When to use**: "what did I work on since last Thursday?", "prepare my weekly update",
"fill this week's report", "which items did I finish and which are still with me?". Also
to check a report before it goes: does every row have evidence, is anything missing?
**Not for**: planning the next week or estimating for the person (the time still needed
is theirs to give); team velocity or anyone's performance (the report is one person's
account of their own week); writing to the tracker or sending the report - no state
change, comment or estimate field is ever written, and the person sends
([prepare-only](../change-gate/references/prepare-only.md)).
**Real origin**: case two - a multi-developer product team where each developer tells the
project manager every week which items were finished and handed over and how much time
the pending ones still need, in a shared spreadsheet (2026-09 to 2026-10). Two versions
grew there: one read the tracker only (done = moved by the developer to a hand-over
state); the other started from the developer's commits and swept the tracker for work
done without commits. Its first run covered a week of 18 commits: 6 items with commits,
8 touched without one, 11 rows written. The rules below are its corrections: a text
search for the author also matched other people's commits; tracker changes filtered by
the date a revision was replaced hid two hand-overs in one week; a commit's pasted link
named another item.
**Parts**: T96 `candidate` - one case, optional ([maturity](../../docs/MATURITY.md),
[register](../../docs/TECHNIQUES.md)).
**Works with**: [`retain-knowledge`](../retain-knowledge/SKILL.md) (a trap found while
reporting is a lesson), [`decision-rounds`](../decision-rounds/SKILL.md) (the team's
definition of "handed over" and of the week is a recorded decision, not the agent's),
[`memory-engineering`](../memory-engineering/SKILL.md) (episodic logs of the week can
explain an item's row, never replace its evidence). Tool for the commit step:
[`runtime/weekly/`](../../runtime/weekly/README.md) (git or svn).
**Detail**: [tracker evidence](references/tracker-evidence.md) (the contract a case's
tracker adapter fills, the change-date rule) and
[classification and the report](references/classification-and-report.md) (a worked
example, the reply, the writer contract).
**Changelog**: 2026-10-21 - first version (wave 3), from case two's weekly report.

---

## The principle

The report says what the person did in the week and what is still on their desk, and
nothing it cannot point at. Three rules carry it:

1. **Worked and handed over is what counts as done.** Not "closed": an item is done for
   the week when the person did real work on it **and** passed it to someone else - a
   reviewer, a tester, the requester - inside the window.
2. **Evidence, or it is not in the report.** Every row points at commits made by the
   person or at tracker changes made by the person in the window; a pending row points
   at the item's assignment. What has no evidence is asked, never written.
3. **Dated by when the change was made.** A commit by its own date; a tracker change by
   its change date - never by the date the tracker says that revision was replaced.

Words used here: the **window** is the reporting week; the **tracker** is where work
items live; the **planner** reads the report (a project manager, a lead); **the person**
reports their own week; an item is **handed over** when the person moved it to a
hand-over state, assigned it away from themselves, or delivered the result in a comment
to whoever holds it.

## 1. The week window

- The week starts on a fixed weekday (a team convention, recorded). Default window: from
  the most recent start day before today to today, **both included**; on the start day
  itself, a full week back. "Since <date>" overrides it (after a holiday, a missed week).
- The window's midnights are the person's. Version control and most trackers store
  instants (often UTC): convert every date to the person's offset before comparing. A
  commit at 22:00 on the last evening belongs to this week, not the next.
- The window is printed at the top of the reply, so the planner reads which days it
  covers.

## 2. The evidence - four nets and the previous report

| Net | What it lists | What only it catches | How |
|---|---|---|---|
| 1. Commits | the person's commits in the window, grouped by the item ids their messages name | coded work | [`runtime/weekly/weekly_commits.py`](../../runtime/weekly/README.md) (git, svn) |
| 2. Items named | per item: type, title, state and holder now; state and assignment changes in the window and **who** made them; the person's comments; the last comment by someone else | where each item stands; who handed it over | the case's tracker adapter, read-only ([contract](references/tracker-evidence.md)) |
| 3. Sweep | items with at least one change **by the person** in the window, commits or not | analysis, hand-overs and replies that left no commit | the same adapter |
| 4. Landed on the person | items assigned to the person now, changed **by someone else** in the window, with no action of theirs | a revert to the person, a new assignment: pending rows nets 1-3 cannot see | the same adapter |
| Previous report | the rows carried over as pending, with their time estimates; the rows already reported done | continuity | the person's last report |

Rules, each one a correction from the source case:

- **The author field, exactly.** A text search for the person's name also matches
  messages, paths and longer names (`anna` for `ann`). Filter on the author field; the
  tool does.
- **Each commit by its own date.** A date range in svn brings the revision just before
  the window; the tool checks every commit's date.
- **A commit with no item id is NO-ID.** It usually belongs with the person's other
  commits of the same day - the tool prints them as a hint - but the person decides; the
  agent never assigns it.
- **Read each commit message against the item's title.** A pasted link can name another
  item. A mismatch is a **link anomaly** in the reply; the item the person never touched
  is "related", not a row.
- **Tracker changes by their change date.** Filtering by the date a revision was
  replaced drops every item's latest change - often the hand-over itself
  ([detail](references/tracker-evidence.md#dating-a-tracker-change)).
- **Credit only the person's own changes.** A state change made by someone else is not
  the person's hand-over; each such exclusion is listed.
- **A source not read is a line, never a gap**: `not read: <source> - <reason>`. A
  report built without the tracker says so at the top.

## 3. Classification

| Class | Rule | Time column |
|---|---|---|
| **Done, handed over** (Y) | real work in the window - a commit, a fix, a tool, an analysis with a conclusion - **and** handed over in the window by the person: moved to a hand-over state (review, test, done), assigned away, or the result delivered in a comment to the holder. Closed is not required | empty |
| **Pending, with time needed** (N) | assigned to the person and not handed over: carried over as pending from the previous report; (re)assigned to them in the window by someone else - a revert counts even when nothing was done yet; or touched by them without a hand-over | the time still needed, **from the person only** |
| **Out** | an acknowledgement-only comment; a state click on someone else's item; an item reported done last week with no new work; an item the person never touched even when a commit's link names it (mention it as related); an item assigned to the person but untouched since before the window (backlog, not this week) | - |
| **Borderline** | a reply with a small deliverable; an item the person closed for someone else | listed apart; the person decides; never written unasked |
| **Excluded by a case rule** | a recorded team rule, e.g. finished release-assembly tasks: their commits are accounted for in the reply as excluded work, and the items they carried keep their own rows | named in the reply |

- **One row per item**, however many commits it had.
- **The time needed comes only from the person.** Carry the previous report's estimate
  for the same item when they give no new one; leave it blank when unknown, and the reply
  lists every blank. Never take it from an empty tracker field, never infer it from the
  commits.
- Order: carried-over pending rows keep their previous order (the planner finds them
  where they were); new items follow.

## 4. The reply, then the written report

**The reply comes first**, before anything is written:

1. the window and the sources read (and `not read:` lines);
2. a table per item: id and title; state and who holds it now; the person's commits
   (revisions, lines); the person's part in one sentence; the class; the time;
3. worked without commits (from nets 3 and 4);
4. link anomalies and NO-ID commits (with the hint and where the person put them);
5. the borderline list;
6. the exclusions: state changes made by others, case-rule exclusions;
7. items whose last comment is a question to the person - flagged.

The person corrects; **only the agreed rows** go to the written report. The output
format is the case's (a spreadsheet, a message, a page); its writer follows one contract
([detail](references/classification-and-report.md#the-writer-contract)): values into the
case's template, a binary format written with a library and never with text tools, the
previous version archived before writing, this week's file never overwritten without
asking, what was written read back and counted, the evidence of each step kept until the
person confirms the report was sent.

**Prepare-only.** The skill writes the file; **the person sends it**. It never sends a
message or an email, and never writes to the tracker.

## 5. What stays in the case

| Part | Fictional example |
|---|---|
| The person's identity per source | VCS author `ann`; tracker display name matching `Ann Example` |
| The sources | the product repository, the tools repository |
| The work-item id pattern | `\b(ORD-\d+)\b` |
| Week start and offset | Thursday; UTC-03:00 |
| The tracker adapter | an MCP server, or a REST script when the server is down; read-only; fills [the contract](references/tracker-evidence.md) |
| Hand-over states | `In review`, `Ready for test`, `Done` |
| Item labels | Bug -> `BUG`, Change -> `CR`, Task -> `TASK` |
| The output and its writer | the team's weekly spreadsheet template |
| Case exclusions | finished release-assembly tasks |

Personal settings (identity, the name of the token variable, the output path) live in a
per-person file outside every repository; a token is read from the environment, with read
scope only, and is never written in a file of the case or of the kit.

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| A text search for the author's name | matches other people's commits, messages and paths | the author field, exactly |
| A date range alone in svn | brings the revision before the window | each commit's own date |
| Tracker changes filtered by the date a revision was replaced | drops each item's latest change - often the hand-over | the change date |
| "Closed" as the test for done | an item with the tester is done for the person | handed over |
| Someone else's state change credited | not the person's work | only the person's changes; list the exclusions |
| An estimate invented, or read from an empty tracker field | the planner plans on a guess | the person gives it; a blank is said |
| A NO-ID commit filed by the agent | a guess shown as evidence | the hint; the person decides |
| A commit's link trusted without the item's title | the link named another item | read message against title |
| Last week's file overwritten | the previous estimates are lost | archive first; ask before overwriting |
| The agent sends the report | not prepare-only | the person sends it |

## Self-check before handing over

- [ ] The window is printed and matches the team's week (start day included).
- [ ] Every commit in the window is under a row, or named as related, NO-ID or excluded.
- [ ] Every done row has a hand-over **made by the person** in the window.
- [ ] Every pending row is assigned to the person now, or carried over as pending.
- [ ] Every blank time is listed; no estimate came from anyone but the person.
- [ ] Items whose last comment is a question to the person are flagged.
- [ ] Every source not read is a `not read:` line.
- [ ] The written report was read back; its row count matches the agreed rows; the previous
      version is archived.
- [ ] Nothing was sent and nothing was written to the tracker; the evidence is kept until
      the person confirms the report went out.
