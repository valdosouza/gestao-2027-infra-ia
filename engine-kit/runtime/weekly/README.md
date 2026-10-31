# Weekly tools - one author's commits in a week, grouped by work item

**Scope**: method

The commit step of the [`weekly-report`](../../skills/weekly-report/SKILL.md) skill: list
one person's commits in a week window, from git or svn, grouped by the work-item ids their
messages name (T96). Python 3.8+, standard library only. Read-only towards version
control (`git log`, `svn log`, `svn info`); it never writes to a repository or a tracker
and never sends anything. The id style, the week start and the person's identity are
parameters; nothing here knows a tracker, a team or a case.

## Files

| File | What it is | Technique |
|---|---|---|
| [`weekly_commits.py`](weekly_commits.py) | The command line below | T96 |
| [`tests/`](tests/test_weekly_commits.py) | `python -m unittest discover -s tests` from this folder: a throwaway git repository and a throwaway svn repository (`file://`, skipped with the reason when `svn` and `svnadmin` are not on PATH) | - |

## Command

```text
python weekly_commits.py --author NAME [--author NAME2] --repo PATH|URL [--repo ...]
    [--vcs auto|git|svn] [--since YYYY-MM-DD] [--until YYYY-MM-DD]
    [--week-start thursday] [--today YYYY-MM-DD] [--utc-offset +HH:MM]
    [--id-pattern REGEX ...] [--git-date committer|author] [--ref REF ...]
    [--json FILE]
```

| Option | Default | Meaning |
|---|---|---|
| `--author` | required | The VCS author, matched **exactly** (case-insensitive; git: the name or the email). Repeat it for several identities of one person |
| `--repo` | required | A git repository or working copy; an svn URL or working copy (its URL is logged; give the repository root to see every branch). Repeatable; `--vcs` forces the kind |
| `--since` / `--until` | the last `--week-start` day / `--today` | The window, both days included, as local dates at `--utc-offset`. On the start day itself the default goes one full week back |
| `--week-start` | `thursday` | The weekday the reporting week starts |
| `--today` | this machine's date | For a report about another week, and for tests |
| `--utc-offset` | `+00:00` | The person's offset: the window's midnights are theirs, and the dates printed are converted to it (git and svn keep instants; svn's are UTC) |
| `--id-pattern` | none | A regular expression of a work-item id: its first group, or the whole match. Repeat it for several id styles. Without one, every commit is NO-ID |
| `--git-date` | `committer` | git: the date that decides the window. `author` keeps a rebased or cherry-picked commit in the week it was written |
| `--ref` | branches, remote-tracking branches, tags | git: read only these refs. Stashes and notes are never read |
| `--json` | none | Also write the result as JSON (window, sources, commits, items, NO-ID with hints). **Refused inside the kit** |

Exit codes: `0` every source read; `1` at least one source could not be read - the others
are still reported and each unread one is printed as `NOT READ <repo>: <reason>`, so the
report can say what it did not see; `2` usage error.

Example (fictional): the commits of `ann` in the week starting Thursday 2026-09-10, in a
git product repository and an svn tools repository, with ids like `ORD-123`:

```text
python weekly_commits.py --author ann --repo ../orders --repo https://svn.example.invalid/tools \
    --since 2026-09-10 --until 2026-09-16 --utc-offset -03:00 \
    --id-pattern "\b(ORD-\d+)\b" --json ../weekly-out/2026-09-10.json
```

```text
author: ann | window: 2026-09-10 .. 2026-09-16 (both included, UTC-03:00)
source    orders (git): 4 commit(s)
source    tools (svn): 1 commit(s)

ORD-101  2 commit(s)
  332ae482f8 2026-09-10 05:00  orders       main                     ORD-101 fix rounding of refunds
  44b0685798 2026-09-11 12:00  orders       main                     ORD-102 reason codes; see also ORD-101  [also: ORD-102]

ORD-102  2 commit(s)
  44b0685798 2026-09-11 12:00  orders       main                     ORD-102 reason codes; see also ORD-101  [also: ORD-101]
  r412       2026-09-11 15:30  tools        trunk                    ORD-102 seed of refund reason codes

ORD-103  1 commit(s)
  9f4cf444bd 2026-09-14 10:20  orders       main                     ORD-103 refund button on the order screen

NO-ID  1 commit(s) - the message names no item; the person decides where each belongs
  1ed3296044 2026-09-11 07:00  orders       main                     tidy imports  [same day: ORD-102, ORD-101]

TOTAL 5 commit(s); 3 item(s): ORD-101, ORD-102, ORD-103; 1 NO-ID; 0 source(s) not read
```

A commit that names two items is listed under both and counted once. The text is for the
person; the JSON keeps the full messages and paths for the report's next step.

## The three rules it enforces

Each one failed silently in the case the tool comes from.

1. **The author field, exactly.** `svn log --search NAME` also matches the message text,
   the changed paths and longer names (`anna` for `ann`); `git log --author` is a regular
   expression over "name <email>". The tool uses them as pre-filters at most and keeps a
   commit only when its author field is one of `--author`.
2. **Each commit's own date.** svn resolves `{date}` to the youngest revision **before**
   that date, so `svn log -r {since}:{until}` brings one revision from before the window.
   The tool checks every commit's date against the window.
3. **No guessing.** A commit whose message names no item is listed as NO-ID, with the
   items of the same author's other commits that day as a hint. The person decides where
   it belongs; the tool never assigns it.

What it cannot see: a message that names the **wrong** item (a pasted link to another
item). The skill checks each message against the item's title in the tracker.

Known limit: svn finds a date's revision by assuming that revision dates rise with the
revision number. That holds in a repository built by ordinary commits; in one whose history
was imported with rewritten dates, the lookup can miss revisions: check the week against
`svn log -r <first>:<last>` by revision number before trusting the list.

## What stayed in the case

The case this comes from also had a tracker step (each named item's state, holder, state
and assignment changes and comments in the window; a sweep for items changed without a
commit; items reassigned to the person by someone else) and a spreadsheet writer. Both are
tied to one tracker and one spreadsheet layout, so they stay in the case behind the
contract in [the skill's tracker reference](../../skills/weekly-report/references/tracker-evidence.md).
