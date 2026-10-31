# Ids, namespaces and registers — worked examples

**Scope**: method

Companion of [the decision-rounds skill](../SKILL.md), section *Ids, namespaces and
registers* (T22). Every name is neutral: a project `ACME-2.1`, a shared project `CORE`,
a front `XY`, a parallel session `S`.

## 1. A row of a home register

| # | Date | Decision | Why | Applies to |
|---|---|---|---|---|
| 7 | 2026-03-04 | **Invoices close on the last working day of the month.** The close job runs that evening | owner, 2026-03-04, chat: "last working day, not the 30th" | `CORE` |

`ACME-2.1#7` lives in this register only. A `CORE` document that depends on it cites
`ACME-2.1#7`; it never copies the row. A revision is a new row ("REVISED by ACME-2.1#12"
on the old one); nothing is deleted.

## 2. Choosing the namespace

| The choice binds | Namespace | Home register |
|---|---|---|
| the whole knowledge base, or how the team works | the workspace key | the root register |
| one project | the project key (`ACME-2.1`) | the project's register |
| one front of a project (its own prompt and rounds) | the front key (`XY`) | the front's register |
| a parallel session inside a front | a sub-front key (`XW`) or a reserved range of `XY` | the front's register |

For the citation check to verify a front's ids, the front is a row of the projects
registry with its own register file — see
[the registry tools](../../../runtime/registry/README.md#ids-and-the-front-alias).

## 3. The alias inside a front prompt

> **Q-XY5 — Which total does the summary show?** Evidence: `summary.ts:88` shows net only;
> the export shows gross. (a) net (b) gross (c) both. **Rec.: (a)**.
> **→ D-XY9 = (c), DIVERGED from the Rec.** (owner, 2026-03-04, chat: "both — the
> auditors read the gross").

`D-XY9` and `XY#9` are the same id. `decisions_index.py --check-touched` checks
`D-XY9` as `XY#9` when `XY` is a registered key; `Q-XY5` (a question) and `A-XY3` (an
assumption) are never checked as decisions. Keys that end in a digit have no alias
(`D-ACME-2.17` is ambiguous): write `ACME-2.1#7`.

## 4. Reserving numbers for a parallel session

In the home register's header, **before** the session starts:

> **Reserved** (2026-03-05, by the conductor, for session S): `Q-XY: 40-44`,
> `A-XY: 20-22` and decisions `XY: 30-32`. The shared sequences skip them: after `Q-XY39`
> the next free question is `Q-XY45`.

A number nobody has taken yet is written `<sequence>: <number>`, never `XY#30`: the
citation check reads every `XY#N` (and `D-XYN`) as a decision that must already exist.

Or a namespace of its own:

> **Sub-front `XW`** (2026-03-05, session S): questions `Q-XW1…`, assumptions `A-XW1…`,
> decisions `XW#1…`. Merged back, its decisions keep their `XW` ids.

## 5. Reconciliation — the conductor's equivalence table

Session S worked without a reservation and wrote `XY#14…XY#16` and `Q-XY30…Q-XY31`,
while the main line had already registered `XY#14` and `XY#15` and asked `Q-XY30`. The
conductor merges and keeps this table in the home register:

| Session S (original) | Unified | Status |
|---|---|---|
| `XY#14` — test data only in the disposable copy | `XY#16` | stands |
| `XY#15` — partial refunds rounded per line | `= XY#15` | same decision as the main line's `XY#15`; one implementation kept |
| `XY#16` — exports skip archived rows | `XY#17` | revoked by `XY#18` (owner, at reconciliation) |
| `Q-XY30` | `Q-XY32` | still open — collided with the main line's `Q-XY30` |
| `Q-XY31` | `Q-XY31` | still open — no collision, number kept |

- Numbers already in the home register never change; only the late session's ids are
  mapped.
- Text merged into the main line uses the unified ids; the session's own branch and
  commits keep the original ids as history and resolve through this table.
- The owner's choices made at reconciliation are decisions like any other, with their
  own rows.

## 6. After every round

```
python runtime/registry/decisions_index.py --root <kb-root>                  # regenerate the index
python runtime/registry/decisions_index.py --root <kb-root> --check-touched  # citations of the touched documents
```

## 7. In code

```sql
-- ACME-2.1#7: invoices close on the last working day of the month
```

```ts
// XY#9: the summary shows net and gross
```

An older comment such as `decision 7 (ACME)` is still understood by the citation check
(it warns when it does not resolve); new comments use the qualified id.
