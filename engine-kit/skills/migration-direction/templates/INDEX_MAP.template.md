# Template: Index map

**Scope**: method
**Used by**: [migration-direction](../SKILL.md) sections 2 and 4.
**Produces**: `INDEX_MAP.md` in the knowledge mirror of the receiver (the sync's project):
the permanent place that says, entity by entity, what indexes it in the target, what
happens to the legacy's id, what the receiver transforms and which dependencies can
answer "not synced". Copy the skeleton below, fill every `<...>`, and set the copy's own
Scope line. Read it before any new or changed endpoint; update it in the same change.

## Skeleton

````markdown
# Index map - <legacy system> -> <target platform>

**Scope**: <method|case|mixed>
**Rule**: legacy local ids never index a shared entity (<KEY#N>).
**Read before**: any new or changed endpoint of the receiver; updated in the same change.
**Last reviewed**: <YYYY-MM-DD>

## Indexers

| Indexer | How it works here |
|---|---|
| Business key | <which keys (registration id, e-mail, SKU); lookup inside the transaction; records found are read-only to the sync> |
| Carried key | <the target issues the id; the legacy stores it in <table.column>; graduation and conflict per the receiving contract> |
| Normalised description | <the normalisation rule (trim, case, accents), decided in <KEY#N>; the per-tenant link table> |
| Local id accepted | <only where the table lives in the tenant's own space, keyed per tenant, with no better key> |

## Entities (in send order)

| # | Entity (legacy sender) | Target table(s) | Indexer | Legacy id | Transformations | Depends on (409 codes) | Decisions | State |
|---|---|---|---|---|---|---|---|---|
| 1 | <entity> | <tables> | <indexer> | <discarded / = target id per tenant / carried> | <what the receiver derives or defaults, with the reason> | <ENTITY>_NOT_SYNCED, ... | <KEY#N> | <designed / live since <date>> |

## Exceptions on the target's side

| Field | Fallback the target accepts | Why | Records it unblocked | Decision |
|---|---|---|---|---|
| <entity.field> | <value> | <the legacy never filled it> | <n> | <KEY#N> |

## Retired from the sync

| Entity | Retired on | Knowledge moved to | If it comes back |
|---|---|---|---|
| <entity> | <YYYY-MM-DD> | <history document> | rewritten in this pattern; the old code is no mold |
````
