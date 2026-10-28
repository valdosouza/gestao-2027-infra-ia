---
name: migration-direction
description: Use when a retiring legacy system must sync or migrate data into a new platform - who adapts to whom, how legacy records re-index (a business key, or an id the platform returns), how legacy state enters an event-based target, and how send order heals itself (a "not synced" conflict, resent next cycle).
---

# Skill: Migration direction (the retiring system adapts; the target stays clean)

**Scope**: method
**Maturity**: candidate

Ran in one case; optional: only a project where a legacy system feeds or migrates into a
new platform needs it.

**When to use**: before the first endpoint, payload or mapping of a sync or a data
migration from a legacy system into a new platform is written, and when an existing one
is reviewed. The questions people ask: "should the new API accept the old format?",
"which id do we use for customers?", "half the legacy customers have no tax id", "the new
ledger is immutable but the old system only has balances", "in what order do we send the
tables?", "why does this record keep failing with 409?". Also when a sync drifts:
duplicates, orphans, an error that never goes away.
**Not for**: moving a knowledge base's documents into a new layout - that is
[`runtime/migration`](../../runtime/migration/README.md) (T61, T89), which migrates
**knowledge, not business data**; proving a backfill or a migration script on a throwaway
copy, and the cutover window when the new platform takes over a kind of record for good -
[`disposable-proof`](../disposable-proof/SKILL.md); modelling the target's concepts -
[`conceptual-guardian`](../conceptual-guardian/SKILL.md); reading what the legacy really
does - [`assess-legacy-repo`](../assess-legacy-repo/SKILL.md).
**Real origin**: case zero - a legacy desktop system, installed at each customer with its
own database, syncing every few minutes into a new multi-tenant platform, temporarily and
customer by customer until each one moves over. The sync was reviewed in three decision
rounds in one day: Round 0 read the real code, and where the draft asked to "review" the
receiver, the code showed its write path had to be rewritten - two phases behind the
target's model. It was then rebuilt in waves by parallel agents guided by two hand-written
molds, and every agent found old sync code writing columns the real schema did not have.
The rules below are that review's decisions and the corrections of its first real loads:
the same customer existed under a different local code in every installation; one
tenant's wrong record overwrote another tenant's correct one until records found by
business key became read-only to the sync; a dependency error that never healed turned
out to be a sender nobody had written; a missing reference value blocked over a thousand
invoices until the reference table became a catalog of the target.
**Profile**: legacy track ([profiles/legacy.md](../../profiles/legacy.md)).
**Parts**: T14 `candidate` - one case, optional ([maturity](../../docs/MATURITY.md),
[register](../../docs/TECHNIQUES.md)).
**Works with**: [`assess-legacy-repo`](../assess-legacy-repo/SKILL.md) (the old sender and
the real list of what syncs are read, not trusted),
[`decision-rounds`](../decision-rounds/SKILL.md) (every change to the legacy and every
exception on the target is a numbered decision),
[`conceptual-guardian`](../conceptual-guardian/SKILL.md) (the target keeps its concepts;
the legacy's shell does not shape them), [`disposable-proof`](../disposable-proof/SKILL.md)
(backfills and replays on a copy; the cutover window), [`test-gate`](../test-gate/SKILL.md)
(data-sync tests by dependency level, T44, design), the read-only
[data probe](../../runtime/data-probe/README.md) (counts on both sides).
**Detail**: [references/receiving-contract.md](references/receiving-contract.md) (the
response envelope, the re-index flow, a business key that arrives later, error families,
the legacy's queue, backfills).
**Templates**: [templates/INDEX_MAP.template.md](templates/INDEX_MAP.template.md) (the
permanent per-entity index map).
**Changelog**: 2026-10-21 - first version (wave 4), from case zero's sync review and its
first loads.

---

## The principle

When a system that will be retired feeds a system that will stay, **the retiring system
pays for the translation**. The target's model, contracts and screens stay what they would
be without the legacy; the legacy - its sender, its queue, a few columns - bends to fit
them. Four rules follow, one per question every sync must answer:

| Question | Rule | Section |
|---|---|---|
| Who adapts? | the retiring system; the target never grows legacy-shaped columns, codes or endpoints | [1](#1-direction---the-retiring-system-adapts) |
| Which id? | a business key re-indexes to the target's id; with no business key, the target generates the id and returns it, and the legacy keeps it | [2](#2-identity---re-index-or-let-the-target-issue-the-id) |
| What about history? | when the target is event-based and the legacy knows only state, the legacy state enters as one mirror event | [3](#3-state---the-legacy-state-is-a-mirror-event) |
| In what order? | any order: a missing dependency is a "not synced" conflict, nothing is written, the legacy resends next cycle | [4](#4-order---a-not-synced-conflict-makes-it-self-healing) |

| Term | Meaning |
|---|---|
| Legacy | the system being retired: its database, its **sender** (builds and posts payloads) and its **queue** (which records still need sending) |
| Target | the new platform the data goes to |
| Receiver | the target's endpoints that accept the legacy's payloads |
| Business key | an identifier with meaning outside both systems: a registration or tax id, an e-mail, a SKU, a natural key of several columns |
| Carried key | an id the target generated and returned, stored by the legacy in a column of its own |
| Mirror event | one upsertable event in the target that stands for the legacy's current state of a record |
| Cycle | one pass of the sender over its queue |

Example used throughout (fictional): **Acme Orders** - a desktop order-entry system
installed at each store, feeding a new cloud platform every five minutes until each store
moves over.

## 1. Direction - the retiring system adapts

- **The contract is the target's own input shape.** The receiver accepts what the target's
  write path already accepts - the same field names, types and codes - and the legacy's
  sender builds its payloads in that shape. The translation lives on the sender's side.
- **The target's application API is not changed for the legacy.** The receiver is a group
  of endpoints (or a service) of its own that reuses the target's input shapes and write
  rules. Two groups, no ambiguity: the app consumes the API; the legacy's sender consumes
  the receiver.
- **Changes in the legacy are few, structural and decided.** Typical ones: a `deleted` flag
  on each synced table, so a delete becomes an update the sender can send; a column for the
  carried key; a reworked sender. Each is a numbered decision
  ([`decision-rounds`](../decision-rounds/SKILL.md)).
- **An exception on the target's side is a decision too, and narrow.** When legacy data
  lacks a value the target requires (records the legacy never classified), the target may
  accept a documented fallback for that field - written in the contract with its reason and
  the number of records it unblocked - instead of reshaping its model.
- **Rewrite against the target's schema; do not translate the old sender.** The old code
  is evidence to read ([`assess-legacy-repo`](../assess-legacy-repo/SKILL.md)), not a mold:
  in the source case it wrote columns the real schema did not have. Molds for the new
  endpoints are written by hand against the real schema, then reused.
- **Step 0 is the real inventory**: what syncs, read from the legacy's production
  configuration (its sync table, its scheduler) - not from documents.
- **Retired scope leaves cleanly.** An entity out of scope is removed from the receiver
  and its knowledge moved to history; if it comes back, it is rewritten in the new
  pattern - its old code is no mold.

## 2. Identity - re-index, or let the target issue the id

Legacy local ids collide: the same customer has a different code in every installation,
and one code means different customers in different installations. **A local id never
indexes a shared entity.**

Choose one **indexer per entity** and write it in the index map
([template](templates/INDEX_MAP.template.md)) - the permanent place every new endpoint is
checked against:

| Indexer | When | How |
|---|---|---|
| **Business key** | the record has one | the receiver looks the key up in the target **inside the transaction**: found -> the target's id; not found -> created in the target's own shape |
| **Carried key** | no business key | first sync: the target creates the record, generates its id and **returns it**; the legacy stores it in its new column and sends it on every later sync - the legacy becomes the carrier of the new system's key |
| **Normalised description** | shared reference lists with no key (brands, units) | one target record per normalised description - the normalisation decided once (trim, case, whether accents fold) - and a link per tenant |
| **Local id accepted** | the table lives in the tenant's own space, keyed per tenant, with no better business key | the legacy id becomes the target id within that tenant; written in the map as an exception, with its reason |

- **A record found by business key is read-only to the sync.** The same key lives in many
  tenants; while the sync rewrote found records, one tenant's wrong data overwrote
  another's correct data. Only creation writes; a correction to a shared record goes
  through the target's own screens.
- **The business key may arrive later** (someone types the missing tax id in the legacy):
  the record **graduates** - the target attaches the key to the same id and tells the
  legacy to clear the carried key. If the key already belongs to another target record,
  **never merge**: keep the record as it was, register the conflict for a person, write
  nothing else. Every case:
  [references/receiving-contract.md](references/receiving-contract.md#when-the-business-key-arrives-later).
- **The tenant comes from the credential, never from the payload**: one key per
  installation, resolved by the receiver.

## 3. State - the legacy state is a mirror event

When the target keeps an immutable history (a ledger, a stock journal, a payment log)
and the legacy keeps only the current state:

- **The legacy state enters as one mirror event per record**, upserted by a natural key
  (store + order + instalment). A later sync replaces that one event; it never appends
  another.
- **The legacy's own history does not travel.** The reversals and corrections it
  overwrote are gone, and inventing them would be fiction. Full immutability applies to
  events **born in the target**.
- **Mirror events are marked** (an origin or status column), so reports and rules can tell
  them from events born in the target.
- **Mirror faithfully.** Where the target has the same notion, keep the legacy's codes as
  they are: an invented code escapes the target's filters and triggers its rules for the
  wrong reason.
- **The mirror must reach the target's read paths.** If the target's screens join a
  companion record (a header per line, a bill per instalment), the receiver writes it in
  the same transaction - otherwise the mirror is in the database and nowhere on screen.

## 4. Order - a "not synced" conflict makes it self-healing

The receiver checks every reference **before it writes anything**:

- A reference the legacy will send but has not sent yet -> **HTTP 409 with a code
  `<ENTITY>_NOT_SYNCED`** (`CUSTOMER_NOT_SYNCED`, `PARENT_NOT_SYNCED`), nothing written. The
  legacy's queue keeps the record unsent and resends it next cycle; once the parent has
  arrived, the child goes through. The load converges with no central orchestrator.
- Check **before touching shared records** - a 409 must not leave a half-created catalog
  entry behind - and **again inside the transaction**.
- A send order (masters, then documents, then movements) **reduces** the 409s; correctness
  does not depend on it.
- **Upserts by the chosen indexer** make every resend and every replay idempotent. A
  backfill is "mark everything unsent and let the cycles run" - proved first on a copy
  ([`disposable-proof`](../disposable-proof/SKILL.md)).

Keep the error families apart - only the first heals by itself:

| Family | Example code | Means | Heals by |
|---|---|---|---|
| not synced | `ORDER_NOT_SYNCED` | a dependency the legacy will send | the next cycle |
| not found | `TAX_CODE_NOT_FOUND` | reference data the legacy never sends | fixing the target's catalog - resending never helps |
| busy | `RESOURCE_BUSY` | a lock was not obtained in time | a retry |
| invalid | 400 with a field list | the record's own data | fixing the data in the legacy |

**A "not synced" that never heals is a bug, not an ordering problem**: no sender exists for
that dependency, or a mapping is wrong. Watch the age of each code in the legacy's log; in
the source case one stayed until the missing sender was written. The envelope, the codes
and the queue: [references/receiving-contract.md](references/receiving-contract.md).

## 5. The span of a sync

- **Temporary, per tenant, until cutover.** The sync runs on a cadence while the legacy is
  still the system of record. Each tenant's cutover - the target takes over a kind of
  record for good - is an irreversible act with a runbook and a rehearsal
  ([`disposable-proof`](../disposable-proof/SKILL.md), part B).
- **The reverse direction is its own phase.** Records born in the target that must reach
  the legacy (orders from a new mobile app) come after the forward sync is stable, with
  their own decisions.
- **Counts on both sides**, read-only, after every wave and at each cutover - by entity and
  by tenant, with the open 409s listed by code and age.
- **The first loads are tested by dependency level** (test-gate section 7, T44 - design,
  never run).

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| The target's API made to accept the legacy's payloads | the new platform carries the old model after the old system is gone | the sender builds the target's input shape |
| The legacy's local code used as the shared id | the same customer gets one record per installation; codes collide across tenants | business key, else a carried key the target issues |
| The sync rewriting a record it found by business key | one tenant's wrong data overwrites another's correct data | records found by key are read-only to the sync |
| Merging two records when a late business key collides | two customers' history becomes one, silently | never merge: a registered conflict for a person |
| The legacy's history reconstructed as target events | invented events look like facts in an immutable log | one mirror event per record, marked |
| A central orchestrator to sequence the tables | one stuck table stops everything; the order is fragile | 409 `<ENTITY>_NOT_SYNCED`, resent next cycle |
| A "not found" resent forever as if it were "not synced" | reference data the legacy never sends will never arrive | separate the families; fix the catalog |
| The old sender translated line by line | reproduces writes to columns that no longer exist | rewrite against the real schema, from hand-written molds |
| `runtime/migration` used to move business data | it migrates knowledge-base documents, not records | this skill, with `disposable-proof` for the act |

## Checklist before the first endpoint (and at every review)

- [ ] Step 0 done: what syncs, read from the legacy's production configuration.
- [ ] Every payload is the target's input shape; the target's app API is unchanged; each legacy change and each target exception is a numbered decision.
- [ ] The index map has a row per entity: its indexer, what happens to the legacy id, its transformations, its dependencies and their 409 codes.
- [ ] Records found by business key are read-only to the sync; a late business key graduates, and a collision is a registered conflict, never a merge.
- [ ] Event-based targets receive one marked mirror event per record, visible on the target's screens.
- [ ] Every reference is checked before any write; `NOT_SYNCED`, `NOT_FOUND`, busy and invalid are separate codes; the legacy resends unsent records each cycle.
- [ ] Open 409s are watched by code and age; one that never heals is a bug.
- [ ] Backfills and replays proved on a copy; counts on both sides; each cutover has its runbook.
