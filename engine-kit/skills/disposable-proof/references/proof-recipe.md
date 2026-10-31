# Disposable proof - recipe, SQL shapes and the record

**Scope**: method

Companion of [the disposable-proof skill](../SKILL.md), part A. Example: **Acme Orders**
seeds the permission pairs of its refunds screen (`returns x REFUND`, `returns x VIEW`,
...) into a catalog of pairs (screen x action).

## The proof script

Kept outside the repository (a scratch folder of the session), because it is a one-off;
what it proves goes into the front's log.

```
1. connect with the SAME settings and options the real runner uses
   (same user rights, same multi-statement mode)
2. record the shared database's counts (pairs, screens, actions, last change)
3. create the throwaway schema  proof_<front>_<seed>_disposable
   for each table the seed touches: create like the original + copy its rows
4. run the seed file with only the target swapped (the USE line, or the schema setting)
5. check 1 - count:   new pairs = the independent expectation; sample row by row
6. check 2 - rerun:   run again -> same counts
                      soft-delete one seeded pair as a person would -> run again ->
                      it stays deleted
7. check 3 - impossible variant: a copy of the seed with one pair whose screen does not
                      exist -> the run must STOP with a readable error
8. check 4 - clean up: drop the throwaway schema; recount the shared database = step 2
```

The **independent expectation** comes from the spec (the list of pairs the owner
approved), not from running the seed: a count computed from the script proves only that
the script agrees with itself.

## SQL shapes (generic; adapt the syntax to the engine)

**Insert if absent, by natural key** - ids come from the target:

```sql
INSERT INTO refund_reason (code, label)
SELECT 'DAMAGED', 'Damaged on arrival'
WHERE NOT EXISTS (SELECT 1 FROM refund_reason WHERE code = 'DAMAGED');
```

**Relations by natural keys on both sides** - no id appears in the seed:

```sql
INSERT INTO permission_pair (screen_id, action_id)
SELECT s.id, a.id
FROM wanted_pairs w                          -- the seed's list: (screen_key, action_name)
JOIN screen s ON s.screen_key = w.screen_key
JOIN action a ON a.name       = w.action_name
WHERE NOT EXISTS (                            -- no "AND deleted = 'N'" here:
  SELECT 1 FROM permission_pair p             -- a pair a person removed is NOT revived
  WHERE p.screen_id = s.id AND p.action_id = a.id);
```

`wanted_pairs` is a temporary table or an inline list of values, filled by the seed.

**Post-conditions that stop the script** - the part that makes check 3 possible:

```sql
-- every wanted pair exists (alive, or removed by a person) - otherwise STOP
-- use the engine's raise mechanism (SIGNAL, RAISE EXCEPTION, THROW);
-- where the runner offers none, a deliberate reference to an object named after the
-- failure stops the script with a readable message:
--   SELECT * FROM seed_failed_expected_pair_missing;   -- (the table does not exist)
```

Useful post-conditions for a catalog seed:

1. no **dead** row (a pair whose screen or action no longer exists);
2. no screen of the menu **without its required action**;
3. no **expected** row missing - the one the impossible variant trips.

Know your engine's quirks in the messages (for example, identifier case folding on some
platforms) so the error stays readable.

## The proof record (in the front's log)

| Step | Result |
|---|---|
| shared database before | 12 pairs; last change 2026-02-11 |
| first run (copy) | 12 -> 48 pairs; post-conditions 1 and 2 empty |
| new pairs vs the approved list | 36 = the 36 of the list; sample checked row by row |
| second run (idempotent) | 48 |
| a pair soft-deleted by hand + third run | not revived (still deleted); post-condition 1 lists it |
| impossible variant (`screen-that-does-not-exist x VIEW`) | **stopped**: `seed_failed_expected_pair_missing` |
| clean up | copy dropped; shared database after = 12 pairs (untouched) |
| seed file | SHA-256 `<hash>` |

Negative knowledge, written next to it: "the script is not transactional - on a failing
post-condition, the inserts before it stay. It is idempotent, so fixing the list and
running again is enough."

## Applying for real (after the release word)

| Step | Result |
|---|---|
| (1) precondition: the catalog equals the one proved | counts, last change and the seed's hash match the proof |
| (2) apply with the real runner | `OK` - the post-conditions passed |
| (3) recount | 48 alive; the approved list checked row by row |
| (4) the consumer, read-only | the code path that builds the menu, run read-only for one administrator, returns the new actions |
| (5) the fence check (when the catalog is fenced) | exit 0 |
| (6) what was not seen live | named, with how to see it (for example: "log in again and open Refunds - the menu loads at login") |

If the precondition does not match - someone edited the catalog since the proof - stop,
read the difference, and prove again.
