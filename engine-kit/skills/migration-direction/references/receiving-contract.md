# The receiving contract - envelope, re-index, codes, queue

**Scope**: method

Companion of [the migration-direction skill](../SKILL.md), sections 2 and 4. Fictional
values throughout: Acme Orders' desktop sender posting to the cloud platform's receiver;
field and code names are examples, not a standard.

## The response envelope

One shape for every endpoint of the receiver, so the sender handles all of them with one
piece of code:

```jsonc
// 200 - written (created or updated); the sender marks the record sent
{ "ok": true, "id": 1234 }
// 200 - first sync of a record with no business key: the target issued the id; the sender stores it
{ "ok": true, "id": 1234, "carriedKey": "6f1c2e0a-9b7d-4c3e-8a51-2d4f0b9e7c11" }
// 200 - the record graduated (its business key indexes it now): the sender clears its carried key
{ "ok": true, "id": 1234, "clearCarriedKey": true }

// 4xx/5xx - nothing written; the sender keeps the record unsent and logs code and message
{ "ok": false, "code": "CUSTOMER_NOT_SYNCED", "error": "customer 77 has not been synced yet", "fields": [] }
{ "ok": false, "code": "INVALID", "error": "invalid record", "fields": [{ "field": "email", "message": "not an e-mail" }] }
```

- `id` is the target's id of the record (for a shared entity, the shared record's id).
- The sender marks a record sent **only** on a 200; anything else stays in its queue with
  the code in its log.
- The credential travels in a header (one key per installation); the receiver resolves the
  tenant from it. Missing or unknown key -> 401; a known key that was switched off -> 403.
  The payload never names its tenant.

## The re-index flow

For an entity indexed by business key, with the carried key as the fallback:

```text
payload arrives (with a business key, or with a carried key, or with neither)
  business key present?
    look it up in the target, inside the transaction
      found     -> use the target's id; do NOT rewrite the shared record (read-only to the sync)
      not found -> create it in the target's own shape; use the new id
  no business key:
    carried key present?  -> look it up -> the target's id   (unknown key: see the table below)
    no carried key        -> create the record, generate its id, return it as carriedKey
  the tenant's own link to the record (customer, supplier, employee) uses that id
```

## When the business key arrives later

A record first synced without a business key carries the key the target issued. Later
someone types the business key in the legacy, and the payload brings both:

| Case | Business key in the target? | Carried key resolves? | The receiver does |
|---|---|---|---|
| Graduation | no | yes | attaches the business key to the carried key's record (same id); answers `clearCarriedKey` |
| Repeat | yes, on the same record | (already cleared) | nothing new; answers `clearCarriedKey` again (idempotent) |
| Conflict | yes, on **another** record | yes | **never merges**: the record stays as it was, the business key is not written, the conflict is registered for a person |
| Orphan, key free | no | no | indexes by the business key; answers `clearCarriedKey` and a warning |
| Orphan, key taken | yes | no | 409 `CARRIED_KEY_ORPHAN`, the conflict registered, nothing written |

The conflict register (a table in the target, or a list a person works through) keeps both
records' ids, the tenant, the payload and the date; resolving it is a business decision,
never the sync's.

## Error families and their codes

| Family | HTTP | Code pattern | The sender does | Heals by |
|---|---|---|---|---|
| not synced | 409 | `<ENTITY>_NOT_SYNCED` | keeps the record, resends next cycle | the dependency arriving |
| not found | 409 or 422 | `<REFERENCE>_NOT_FOUND` | keeps the record, logs it | a person fixing the target's catalog (resending never helps) |
| busy | 409 | `RESOURCE_BUSY` | retries next cycle | the lock being free |
| conflict | 409 | `<WHAT>_CONFLICT`, `CARRIED_KEY_ORPHAN` | keeps the record, logs it | a person resolving the registered conflict |
| invalid | 400 | `INVALID` + `fields` | keeps the record, logs the fields | fixing the data in the legacy |
| credential | 401 / 403 | `KEY_MISSING`, `KEY_INVALID`, `KEY_INACTIVE` | stops the cycle, alerts | configuration |

Rules for the receiver:

- **Every reference is checked before any write**, and again inside the transaction. A 409
  leaves no trace: no half-created catalog entry, no partial header.
- **A missing optional reference is not a 409**: an absent value goes in as the target's
  documented sentinel; a value that is present and does not resolve is the 409.
- **A list of children sent with its parent is a snapshot**: children missing from the list
  are marked deleted in the target. Say so in the contract of that endpoint.
- **Deletes travel as a flag** (`"deleted": true`) and become soft deletes in the target; the
  receiver never deletes physically.

## The legacy's queue

- One row per record to send (or a "last update" marker per table plus an error log): the
  sender picks unsent records each cycle, posts them, marks them sent on a 200, writes the
  code and the message on anything else.
- **Watch the age**: a query that lists open codes by entity, oldest first. A `NOT_SYNCED`
  older than a few cycles is no longer ordering: look for a dependency with no sender, or a
  mapping that resolves to nothing.
- **A backfill** (after a contract change, or for a tenant's first load): clear the error
  log and rewind the table's "last update" marker, so every record is sent again; the
  receiver's upserts make the replay idempotent. Prove it on a copy first, count both sides
  after ([`disposable-proof`](../../disposable-proof/SKILL.md)).
- **The cadence** (every few minutes) and the per-tenant switch (a key that can be turned
  off) are configuration, not code.
