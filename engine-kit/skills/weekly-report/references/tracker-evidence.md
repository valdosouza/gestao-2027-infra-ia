# Tracker evidence - the contract a case's adapter fills

**Scope**: method

Companion of [the weekly-report skill](../SKILL.md), nets 2 to 4. The tracker differs from
case to case (an issue tracker, a work-item service, a board), so the kit does not ship an
adapter: each case writes a small read-only one - an MCP server's tools, or a REST script
for when the server is down - that returns the fields below. The skill reads the fields;
it does not care how they were fetched.

## What the adapter returns, per item

| Field | Meaning | Used for |
|---|---|---|
| `id`, `type`, `title` | the item | the row; the title is read against each commit message that names the item |
| `state`, `holder` | now | "where it stands, who holds it" in the reply |
| `state_changes` | in the window: old -> new, **change date**, made by whom | a hand-over by the person; a revert by someone else |
| `assignment_changes` | in the window: old -> new, change date, made by whom | assigned away by the person (handed over); assigned to the person by someone else (pending) |
| `my_comments` | the person's comments in the window: date, text (markup stripped, cut) | a delivery comment to the holder; an acknowledgement-only comment (out) |
| `last_other_comment` | the latest comment by someone else in the window: date, who, text | flags a question waiting for the person |
| `my_changes` | the person's changes in the window: count and kinds (state, assignment, comment, links, other edit) | the sweep's filter; borderline cases |
| `handed_over_by_me` | true when the person, in the window, moved the state to a hand-over state or assigned the item away from themselves | the done test (a delivery comment is read from `my_comments`) |

An item that cannot be read is returned with its id and the error, never dropped: the
reply names it.

## Three queries

1. **Items by id (net 2)**: the ids from the commit step (`--json` of
   [`weekly_commits.py`](../../../runtime/weekly/README.md)), plus any id the person adds.
2. **Sweep (net 3)**: items changed in the window that were ever assigned to the person,
   created by them or last changed by them; keep an item only when **at least one change
   in the window was made by the person**. Restrict by the changed date first: "ever
   assigned to me" alone returns years of items.
3. **Landed on the person (net 4)**: items assigned to the person now and changed in the
   window, that net 3 did not return - someone else moved them to the person (a revert, a
   new assignment). They are pending candidates; the person confirms each.

Ids found by nets 3 and 4 that the commit step did not have go through query 1 for their
full fields when they look like real work.

## Dating a tracker change

Many trackers keep each item's history as a list of revisions, and each revision carries
two dates:

- the **change date** - when that change was made;
- a **replaced date** (often called the revised date) - when the **next** revision
  replaced it. The latest revision has no next one, so it carries a far-future sentinel.

Filter and date by the **change date**. Filtered by the replaced date, each item's latest
change falls outside every window (its date is the sentinel) - and the latest change is
very often the hand-over itself. In the source case this hid two hand-overs in one week
before it was found.

Like commit dates, tracker dates are usually instants in UTC: convert them to the
person's offset before comparing them with the window.

## Identity

The person's identity differs per source: a login in version control, a display name in
the tracker. The adapter takes a pattern for the person's tracker name from the personal
settings and matches it against **who made each change** - never against the item's text,
where the name also appears in mentions and quotes.

## Read-only, and the token

- The adapter only reads: no state change, no comment, no field write. The tracker's write
  tools sit on the harness ask-list
  ([HARNESS-PERMISSIONS.md](../../../runtime/guards/HARNESS-PERMISSIONS.md)).
- A REST fallback authenticates with a token of read scope, taken from an environment
  variable whose **name** is in the personal settings. The token is never written into a
  file, a log or the evidence.
- Take the id list as a list or as a file of ids: shells disagree on how a comma-separated
  argument arrives.

## Pitfalls seen

- A comment's markup (HTML) quoted raw makes the reply unreadable: strip it and cut long
  texts.
- A state click on someone else's item (moving their item along a board) is a change by
  the person, but not their work: it is "out" unless the person says otherwise.
- An item closed by the person on someone else's behalf is borderline: listed apart.
