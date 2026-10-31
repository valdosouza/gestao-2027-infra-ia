---
name: fences
description: Builds a fence around an invariant that can drift silently (catalog rows the code depends on, a closed list of writers or callers) - one source list, a static AST/tokenizer scan, a read-only live test, a boot alarm that never blocks, a publish script that exits 1, a refusal at the API.
---

# Skill: Fences (for invariants that drift silently)

**Scope**: method
**Maturity**: operating

**When to use**: an invariant can break without anything failing at the time - code checks
a row that an administrator can delete at runtime, a rule says only these files may write
that table, two tiers compare the same name as text. Also when a gate or a bug report shows
that such a drift already happened ("nothing failed, the button just disappeared").
**Not for**: what the type system, a foreign key, a unique index or a check constraint can
enforce - use those first, they are the best fences. A fence covers what crosses a
boundary they cannot (code <-> rows edited at runtime; which code may call what; a text
contract between tiers), or covers it until the constraint can exist.
**Real origin**: case zero (2026-10). A permission the code checked was never in the
catalog table, so an action button vanished for every administrator - no test failed, no
error was logged, and it was found months later by reading. The fence built for it (one
list, six parts) then caught its own delivery, a later drift in a sibling service and
five false negatives of its first scanner, found by the adversarial gate. Closed lists of
writers, "no outbound call" rules and contract-vs-routes checks in the same case were
smaller fences of the same shape. One case, core by choice: `operating`
([maturity](../../docs/MATURITY.md)); technique T40 in the [register](../../docs/TECHNIQUES.md).
**Hands off to**: [`delivery-gates`](../delivery-gates/SKILL.md) (the fence itself goes
through the gates - its false negatives are the attack surface),
[`decision-rounds`](../decision-rounds/SKILL.md) (an entry kept absent on purpose cites a
decision; the publish step waits for the release word) and
[`retain-knowledge`](../retain-knowledge/SKILL.md) (every fence records what it does not
catch).

---

## The principle

Some invariants are loud when they break: a compiler error, a red test, a 500. Others are
silent: the code is right, the data it relies on changed, and the only symptom is
something a user no longer sees. A fence makes a silent invariant **loud at every moment it
can break** - when code changes, when the suite runs, when the service starts, when someone
publishes, and when someone edits the data at runtime - and all of those read **one source
list**.

Example used throughout (fictional): **Acme Orders** checks permission pairs
(screen x action, such as `orders x APPROVE`) in its API guards and in its UI buttons; the
pairs live in a catalog table that a superuser edits through an admin screen. A pair
missing from the catalog makes a button vanish and a route answer 403 - silently.

## The six parts

| # | Part | Catches | Runs | Must never |
|---|---|---|---|---|
| 1 | **Source list** | - (it is the truth the others read) | - | hold an entry without its consumer |
| 2 | **Static scan** (AST / tokenizer) | code that consumes something outside the list; a list entry nothing consumes; consumption it cannot read | in the test suite, on every change | skip what it cannot read; use regex on raw text |
| 3 | **Read-only live test** | list entries missing from the live catalog | in the test suite, against the real dev database | write; run on a session that could write |
| 4 | **Boot alarm** | drift in the catalog the running service uses | at service start | throw, or block the start |
| 5 | **Publish script** | drift in the target before a deploy or after a seed | in the publish procedure | publish on an alarm (exit 1) |
| 6 | **Refusal at the API** | a runtime edit that would break the invariant | on every catalog write | let any role through, superuser included |

Parts 2 and 3 close the triangle **code -> list -> catalog** in the test suite, before
anything is deployed. Parts 4 and 5 watch the deployed catalog. Part 6 stops the drift at
the door. Detail of each part with the Acme Orders example:
[references/fence-parts.md](references/fence-parts.md).

## Part 1 - one source list

- **One list, in code**, next to the code it protects (for example
  `shared/auth/permission-catalog`): each entry is the protected item plus its **exact
  consumers** - which tier (API guard, other service, UI button) and where.
- **An entry without a consumer fails the scan**: the list cannot rot into a wish list.
- **An entry absent on purpose** carries a mark with the decision that keeps it out
  (`absentBy: 'ORD#12'`); the mark stops being valid when a consumer appears.
- **Rules that are not pairs** (every menu screen needs the VIEW action) live in the list
  as rules, read by the same predicate.
- **Every reader uses the list**: adding an entry protects it everywhere with no new code.

## Part 2 - the static scan

A test that parses the code - **AST for the server language, a tokenizer for any other
language in the scan** - and compares every consumption with the list. Rules and the
classes of false negatives the gates found: [references/static-scan.md](references/static-scan.md).

- Fails on: consumption outside the list; a list entry with no consumer; **consumption it
  cannot read** (a computed name, a variable it cannot resolve) - fail closed, never skip;
  a new export of the protected implementation that is not classified; a new entry point
  (a mounted module, a route group) that is neither fenced nor a named exception - count
  them, so a new one cannot slip in.
- Resolves names by **lexical scope and by symbol**, following re-exports and wrappers
  that pass the protected value through a parameter.
- **Allow-list, not deny-list**: the scan accepts the known shapes and fails on the rest.
- **Proves it is not blind**: a planted violation in the test fixtures must fail it.

## Part 3 - the read-only live test

The list is a subset of the live catalog of the dev database. The test opens a session
that **cannot write** (a read-only session or user) and **proves it** - a write attempt in
the test is refused by the database. Red here means the seed did not reach the database
before the code that needs it.

## Part 4 - the boot alarm

At start, the service runs the same predicate the consumers use against its catalog and
logs **one line per class of problem** with a fixed tag (`[ALARM ORD-PERMS] missing pair
orders x APPROVE (consumers: api guard, ui button)`).

- **Never throws, never blocks the start** - not even when the logger or an error's message
  getter throws. A service that refuses to start over a catalog drift turns a hidden
  defect into an outage.
- Compares the way the consumer compares (the same case folding, the same trimming, the
  same collation) - otherwise it alarms on what works and misses what breaks.
- It only sees on the next restart; before a deploy, parts 3 and 5 are the checks.

## Part 5 - the publish script

The same check outside the boot, read-only, for the publish procedure:

- **Exit 1 on any alarm**; a distinct exit code and message when the target configuration
  is missing (no database settings for the target = it does not know what it checked).
- **Prints which target it checked** (host, database, port) - a check against the wrong
  database is worse than none.
- Runs **before** the build or deploy of the consumers and **after** any seed of the
  catalog; the publish order is seed -> server -> client.

## Part 6 - the refusal at the API

The screens and endpoints that edit the catalog **refuse** (409, naming each consumer in
the error fields) a change that would break the invariant: removing a consumed entry,
renaming or deleting it, a screen without its required action, a key repeated in another
row. Including an update that silently clears a collection because a field was omitted.

- **Every role, superuser included**: this is integrity of the catalog, not permission.
- **Reads the same list**, so a new entry is protected at runtime with no new code.
- Seeds and bootstrap scripts do not pass through the API: parts 3 to 5 cover them.

## Smaller fences

Not every invariant needs six parts. Pick the shape from what can drift:

| Invariant | Parts | Example |
|---|---|---|
| code depends on rows edited at runtime | 1-6 | permission pairs, feature flags the code names, status codes in a lookup table |
| a closed list of writers of a table | 1, 2 (+5) | "only the order service writes the refunds table" - SQL write targets by allow-list |
| no call from service A to service B | 2 | "the core never calls the reporting service" - outbound calls and imports scanned |
| a contract file equals the routes | 2 | every route in the API description exists, and every route is described |
| a read that grows with history stays indexed | 2 (+5) | the query plan of each listed read is checked; a full scan fails |
| a text compared across tiers | 1, 2, 4 | the UI compares an action by name; the API by id |

## Prove the fence

- **Rebuild the defect and watch it fire**: reconstruct the state before the fix (for
  example, the catalog rows created before the seed's timestamp, read-only) and show that
  the alarm names **exactly** the known defect - and the current state names nothing.
- **Gate the fence** ([`delivery-gates`](../delivery-gates/SKILL.md)): for a fence, the
  adversarial attack is the false negative - a consumption the scan does not see, a
  comparison that differs from the consumer's, an entry point it does not count.
- **A malformed list never reads as an empty one.** The scan and the script fail on it; the
  boot alarm reports it on its own line. An empty fence is an open fence.

## Negative knowledge every fence records

- **What it does not chase**: deliberate evasion (a computed property name, an alias over
  an unexported constant). The fence protects against drift, not against an attacker in
  the code base.
- **The closed set it scans**: which repositories, which languages. A new consumer outside
  that set needs the predicate extended.
- **Green certifies a combination of checkouts**: a scan that reads sibling repositories
  is green for those revisions; continuous integration of one repository needs the
  others' paths.
- **The boot sees only on restart**; a long-running service learns of drift at the next
  deploy.
- **Concurrency gaps**: two simultaneous catalog edits may produce a state that neither
  check validated, until a database constraint exists.

## Anti-patterns

- **A regex fence on raw text** - comment markers inside strings, multi-line constructs and
  string interpolation fooled it. Parse.
- **A fence that fails open for new code** - it checked the modules it knew and ignored a
  new one. Count entry points; classify every new one.
- **A list without consumers** - entries nobody uses accumulate until nobody trusts the
  list.
- **A boot alarm that blocks the start** - one bad row takes the service down.
- **A refusal only for ordinary users** - the superuser is the one who edits the catalog.
