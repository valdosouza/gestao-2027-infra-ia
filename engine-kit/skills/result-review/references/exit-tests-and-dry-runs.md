# Exit tests and dry runs (T43)

**Scope**: method

Part of [`result-review`](../SKILL.md). **Rule**: prove a process on a real item before
calling it done.

A process change - a new workflow, a gate, a tool, a mechanism merged from another team - is
reviewed like code, but its "result" only exists when it runs. Two instruments:

| Instrument | Question it answers | Who runs it | On what |
|---|---|---|---|
| **Exit test** | can the people who must adopt it keep working the way they work, with it? | the adopter, on their own machine and tools | the things they do every day, replayed |
| **Dry run** | do the process's gates hold on a real work item? | the process owner (or an agent for them), read-only | one real work item, ideally in progress |

Both end the same way: findings on the **process**, numbered, decided by the owner
([`decision-rounds`](../../decision-rounds/SKILL.md)), built tests-first, and recorded in the
same document.

## Exit tests

### Rules

- **Each test replays one thing the adopter does every day**, named in a line "what it
  replays". A test of a feature nobody uses proves nothing.
- **A test passes when the expected artefacts appear where the knowledge base says they
  live** - the path, the front matter, the exit code - not when "it seemed to work".
- **A test fails usefully.** Friction - a step slower than before, a tool not reachable, a
  persona that does not answer - is the real output. Write it down; never work around it in
  silence.
- **A missing prerequisite is already a finding.** Note it, continue with what works.
- **Writes to real systems are chosen carefully.** When a test exercises a step that writes
  to a shared system (a tracker field, a shared database), run it on an item that needs that
  write anyway, or answer "no" at every write prompt: the test still passes when the agent
  shows what it would write and waits.
- **Nothing is committed by the agent** during a test (prepare-only, T29).
- **The results decide a named next gate** ("when tests 1-3 pass, the content migration
  starts"); retiring the old way is a separate gate with its own criteria.

### Document shape

```markdown
# <Process> - Exit tests for <who adopts it>

**Scope**: <method|case|mixed>
**Status**: ready to run | running | done - results in section N
**Plan**: <the plan or decision ids this proves>
**Who runs it**: <the adopter>, on their own workstation, in the tool they really use
**Who reads the results**: <the owner> - the result column decides <the next gate>

## 0. Why these tests exist
<the things the adopter did daily, now done through the new process; one question per test>

## 1. Prerequisites (once)
| Step | Command / action | Check |

## 2. Test 1 - <name> (<what part of the change it covers>)
*What it replays*: <the daily action>
1. <step>
2. Expected: <artefact> at <path>, with <front matter / exit code / prompt>
3. Evidence: <paths, first lines, command output - even when empty>
**Fails if**: <the concrete conditions>

## N. Results
| Test | Date | Tool (+ version) | Project key | Result (pass / fail) | Evidence (paths) | Friction |

## N+1. Revision history
| Date | Change |
```

## Dry runs

### Rules

- **Read-only on the item.** Nothing is written to the item's folder, the code working copy
  or the tracker. The mechanical checks (validators, closing scripts) run on a **scratch
  copy** of the item's folder.
- **The item may be in progress in another session**: do not touch it, and say so in the
  header.
- **Gate by gate**, in the process's own order: what artefact the gate expects, what was
  found, and one of `pass`, `gap`, `pending` (not reached yet), `n.a.` (does not apply, with
  why).
- **A gap is a gap of the process, not a reproach to the item's author.** The findings
  section is titled "on the process".
- **"An exemption is a line, never silence."** Where the process allows a step to be
  skipped, check that the skip writes a line (`skip: <reason>`) and that something checks
  the line; a skip with no writer and no check is a finding.
- **Run the mechanical check in variants**: the item as it is, and the same item pointed at
  the other path (another kind of project, another line) - a gate that bites on one path and
  lets the other through is a finding.
- **One item proves one path.** Test the path the item did not exercise separately, on the
  same day, and record it in its own section.
- **Findings become decisions, then tests-first changes.** Each finding carries a proposal;
  the owner decides (numbered decisions); the change is built with its tests red first, then
  green; the document records what was built where.

### Document shape

```markdown
# <Process> dry run on <work item> (<decision ids under test>)

**Scope**: <method|case|mixed>
**Purpose**: test <the process and its gates> on a real item before <committing the decisions>
**Item**: <id, title, project, area, folder>
**Mode**: read only - nothing written to the item, the code or the tracker; mechanical checks on a scratch copy

## 1. Where the item stands
<what is done, what is in progress, in which session>

## 2. Gate by gate
| Step | Artefact found | Result (pass / gap / pending / n.a.) | Note |

## 3. Mechanical check (on a scratch copy)
| Variant | Result |

## 4. Findings on the process (not on the item)
| # | Finding | Proposal |

## 5. Decisions (<owner>, <date>)
| # | Decision |
| # | Open question | Options | Status |

## 6. Implementation
| Decision | Built in |
Tests first: <which tests ran red, then green>. Not done here: <list, with who>.

## 7. The other path, tested separately
| Step | Result here |
```

## Example (fictional)

A team changed its change process: a test plan is now mandatory in every plan, and a skipped
suite must leave a `skip:` line. Dry run on work item `ORD-42`, in progress:

| Step | Artefact found | Result | Note |
|---|---|---|---|
| Plan | the fix proposal, no separate plan | gap | no test plan section; the proposal template has none |
| Code gate | the go is written in the dossier | gap | the process puts it in the work log, which does not exist in this flow |
| Suite | none | gap | the item is client-only, the suite is skipped, but nothing writes or checks the `skip:` line |
| Review | none | pending | expected at this stage |

Findings F1-F3 on the process went to the owner as questions; the decisions were built tests
first (the closing check gained a red case for a missing `skip:` line, then went green), and
the core path - which this client-only item never reached - was dry-run separately the next
day.
