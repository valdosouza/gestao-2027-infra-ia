# Ownership partition - read by name, ask by request

**Scope**: method

Companion of [the front-protocol skill](../SKILL.md), section 5 (T32). Neutral names: a
front `XY` of product *Acme Orders* (project `ACME-2.1`) and a **sync group** that owns
the service bridging the legacy system - it writes the `products`, `prices` and `stock`
tables of the tenants that still run the legacy system.

## 1. The partition, written once

The workspace rules (`AGENTS.md` - [`kb-setup`](../../kb-setup/SKILL.md)) carry one table;
fronts point to it and never restate it differently:

| Group | Owns (code) | Writes (shared data) | Its documents | Its request inbox |
|---|---|---|---|---|
| core team | `api/`, `app/`, `db-scripts/` | every tenant schema except below | `prompts/` | `prompts/REQUESTS.md` |
| sync group | `sync-service/`, `legacy-bridge/` | `products`, `prices`, `stock` of tenants on the legacy system | `sync-service/docs/` | `sync-service/docs/REQUESTS.md` |

Each front's header repeats the line that applies: "**Ownership**: the sync group's code
was not opened - names of its endpoints only (inventory section 1.6)".

## 2. Read by name only

| Allowed | Not allowed |
|---|---|
| names of the other group's endpoints, jobs, tables and columns (from the shared schema or their published contract) | opening their implementation files, tests or branches |
| their published documents and answers | inferring their intent from their code and designing on it |
| the list of what they write, by name | "a quick look to confirm" - a confirmation is a request |
| a search hit in their folder, read up to the file name | following that hit into the file |

Why the line is drawn there:

1. **A design built on another group's internals breaks silently** when they change them;
   their contract is what they promise to keep.
2. **A fact read from their code without their review is a hypothesis** the front would
   treat as truth - and record as fact in its prompt.
3. **The front would start keeping knowledge it does not own**, and two groups would end up
   changing the same thing.

## 3. Shared data is a contract

In a table the other group writes:

- a new column is **additive and has a default**;
- **never** a rename, a removal, a new mandatory column without a default, or a new
  meaning for an existing value;
- **never** delete or rewrite rows they own;
- anything beyond these limits is a request first, and waits for the answer.

The front's inventory marks those tables as `contract (sync group)`, so every design
step that touches them meets the rule.

## 4. The request

Written in **their** inbox (append-only for other groups; never the body of their prompt,
which has one writer; never their code):

```markdown
### R-7 - from front XY (ACME-2.1), 2026-03-05 - OPEN

**Need**: confirm whether a product created on the web can collide with an id the legacy system later sends.
**Why**: front XY releases a product screen; our evidence: the web insert picks `MAX(id)+1`
(`products.repository.ts:120`), and the sync writes the same table (by name, from the shared schema).
**Blocks**: the release of XY wave 1 to tenants that still run the legacy system. Nothing else.
**Our proposal** (optional): the screen is enabled only for tenants without the sync until you answer.
**Answer** (sync group): <date, text>
```

- The id is the **owning group's** sequence (`R-7`), cited by our front as `sync R-7`.
- Our front records it three times, each one a pointer: in the wave map ("depends on sync
  R-7"), in the out-of-scope list ("collision guard -> sync group, R-7") and in Pending.
- One need, one request. A follow-up question is a new request that cites the first.

## 5. The answer comes back as a fact

```markdown
### 19.2 Facts from the sync group (2026-03-07, answer to R-7)

- **F31** (sync group, R-7, literal: "web rows are overwritten when the legacy reaches the same id; we do not
  check the origin") - a product created on the web in a synced tenant is silently replaced.
```

- Quoted and dated, with the request id - never paraphrased into a decision.
- When it changes the design, it opens a question in the next round (`Q-XY52 - with F31,
  do we block web inserts for synced tenants?`); when it falsifies a decision's premise,
  the decision gets the note "premise changed by F31" and the question decides what
  follows (decision-rounds: a decision is revised, never deleted).
- A release that depends on an open request waits; the release plan says which request.

## 6. Notes

- **The partition is about ownership, not people.** The same owner may decide for both
  groups; the request is still how the need reaches the right register and the right
  writer.
- **A guard that enforces the partition across tenants or projects** (closing fails when
  a change set touches another tenant's project) is a separate technique of the kit
  (T86, `runtime/registry/projects_check.py --check-scope`); this page is about code and
  data owned by another *group*.
