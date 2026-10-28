---
project: <KEY>
front: <NS>
window: <YYYY-MM-DD HH:MM - HH:MM, timezone>
last_updated: <YYYY-MM-DD>
decisions: [<KEY>#<n>]
tags:
  - runbook
  - cutover
---
# Cutover runbook - <what changes, in one line a user would recognise>

**Scope**: <method|case|mixed>
**Owner**: <the person who gives the release word - name as the source writes it>
**Operator**: <who types the commands>; **Present**: <who must be reachable during the window>
**Point of no return**: step <N>; **Abort valid until**: step <N-1> (the abort script refuses after it)

> Template from the engine-kit (`templates/CUTOVER_RUNBOOK.template.md`) - technique T33,
> the `disposable-proof` skill, part B. One runbook per irreversible window, kept in the
> front's folder. Replace every `<placeholder>` and delete this note. Nothing here runs
> without the owner's release word for that step (`decision-rounds` skill).

## 1. What is irreversible

<One paragraph: what the act changes, why it cannot be rolled back after step <N> (only a
forward fix), and what users notice. Cite the decisions: <KEY>#<n>.>

| Before the window | After the window |
|---|---|
| <who owns the records / which system answers> | <the new owner / system> |

## 2. Entry criterion

The window opens only when **every** line is checked. One unchecked line = the window
does not open; reschedule.

- [ ] Delivery gates passed on the revisions below (Socratic >= 0.70; adversarial with no
      HIGH or CRITICAL) - record: <link>
- [ ] Every question that blocks the window is decided: <Q-ids -> decisions>
- [ ] Rehearsal done on a second instance on <date>, against these revisions - section 3
- [ ] **No repository changed since the rehearsal** - or re-rehearsed on <date>
- [ ] The abort was rehearsed in the same rehearsal and answered without refusal
- [ ] Every artifact the window builds was built in the rehearsal (server, client, scripts)
- [ ] Fences and boot checks green on the target: <command> exit 0
- [ ] Users told; usage stopped from <time> (who stops it, how it is checked)
- [ ] Production backup / snapshot taken at <time>: <where> (and how a restore was tested)

| Repository | Revision rehearsed | Revision for the window |
|---|---|---|
| <repo> | <hash> | <hash - must match, or re-rehearse> |

## 3. Rehearsal evidence

**Environment**: second instance on port <port>, data folder <path in the scratch area>,
restored from a read-only dump of <schemas> taken <date time>; outbound hosts blocked in
every rehearsal process: <list>; own signing key id <kid>; storage / secrets / mail
isolated; production users' passwords not used.
**Probe before each step**: `<probe command>` -> server port <port>, data folder <path>.

| Step | Expected | Rehearsal result | Evidence |
|---|---|---|---|
| <n> | <expected> | <what happened - literal values> | <log line, report, count> |
| abort (dry run) | <answers without refusal: ...> | <...> | <...> |
| production read back after the rehearsal | unchanged | <counts / rows read> | <query> |

**What the rehearsal changed in this runbook**: <a step added, an order changed, a build
fixed - or "nothing">.

## 4. Steps

Each irreversible step needs the release word **at that moment**: the word given for the
window does not cover a step added afterwards. "Abort trigger" is the observable that
stops the window at that step; then follow section 5 (before step <N>) or section 6
(after it).

| # | Action (command, from where) | Expected result | Abort trigger | Release word | Reversible |
|---|---|---|---|---|---|
| 1 | Check the entry criterion (section 2) | all lines checked | any line unchecked | - | yes |
| 2 | Stop usage: <how> | <no requests in the log for N minutes> | requests still arriving | - | yes |
| 3 | Probe: `<probe>` from <folder> | server port <port>, data folder <path> = production | anything else | - | yes |
| 4 | Dry run of the act: `<command>` | exit 0; report: <expected blocker only> | exit 1, or any unexpected blocker | - | yes |
| 5 | Dry run of the abort: `<command>` | answers without refusal: <expected fields> | refusal - **stop here** | - | yes |
| 6 | <deploy / merge / migrate>: `<command>`; start; read the start log | log shows: <expected lines> | a line missing, an alarm | required | yes, by section 5 |
| 7 | Resync and counts: `<command>` | origin = replica: <counts> | any difference | - | yes |
| **<N>** | **The act**: `<command> <execute flag>` - **POINT OF NO RETURN** | <committed: true; expected state> | <failure output> -> section 6 | **required** | **no** |
| <N+1> | Publish the client build: `<command>` | <cache headers, version shown> | build fails -> section 6 | required | forward only |
| <N+2> | Reopen usage | <first real request succeeds> | errors in the log | - | forward only |

## 5. Abort path (valid until step <N-1>)

Run in this order; each step has its own expected result. The abort writes its
**tombstone first**, so an interrupted abort is finished by running it again.

| # | Action | Expected result |
|---|---|---|
| A1 | Stop the service the new code runs in (by port and command line) | port <port> closed |
| A2 | Abort, dry run: `<command>` | reports: <what it will undo> |
| A3 | Abort, execute (**release word required**): `<command> <execute flag>` | tombstone written; <undone items>; post-condition checked |
| A4 | Revert the deployed code to <revision recorded at step 6> | <revision> running |
| A5 | Start; read the log | old code runs; the new code would refuse (tombstone) |
| A6 | Resync / counts | <counts> |
| A7 | Reopen usage on the old path; tell users | <first request succeeds> |

**Coming back later**: <how the tombstone is removed on purpose, and that the window starts
again from section 2>.

## 6. After the point of no return

No rollback. Failures are handled forward: <the forward-fix owner, the contacts, the
first commands to read state, the decision that forbids rollback: <KEY>#<n>>.

## 7. Release word

One line per irreversible step, written **when the word is given** (date, time, channel,
the owner's literal words, the list it covers):

- Step <6>: "<literal words>" - <owner>, <date time>, <channel> - covers: <commits, paths, targets>
- Step <N>: "<literal words>" - <owner>, <date time>, <channel> - covers: <the act on <target>>
- Step <N+1>: "<literal words>" - ...

## 8. Post-window checks

- [ ] Counts on both sides: <query> = <expected>
- [ ] The start log of every service shows <expected lines>; no alarm line
- [ ] Fences / boot checks on production: <command> exit 0
- [ ] The consumer, read-only: <the screen or query that proves the new path answers>
- [ ] The owner's walk on production (the owner logs in): <screens>
- [ ] Old secrets, keys or credentials of the retired path deleted (**release word**): <list>
- [ ] Rehearsal instance, scratch folders, links and keys removed (by port, by link - never
      a recursive delete through a link)
- [ ] Commits pushed; the front's log, decisions and negative knowledge updated
      (`retain-knowledge` skill)

## 9. Window log

| Time | Step | Result (literal) | Who |
|---|---|---|---|
| <HH:MM> | <n> | <...> | <...> |
