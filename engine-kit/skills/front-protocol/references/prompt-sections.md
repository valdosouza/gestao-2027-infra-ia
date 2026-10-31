# The living prompt - sections, wave blocks and annexes, with examples

**Scope**: method

Companion of [the front-protocol skill](../SKILL.md), section 1 (T26) and section 2 (T12).
Every name is neutral: a product *Acme Orders* (project `ACME-2.1`), a front `XY` that
gives guest users access to a second tenant, a sibling front `GR` (tenant groups), another
group that owns a sync service. The ids follow [`decision-rounds`](../../decision-rounds/SKILL.md);
nothing here redefines them. The skeleton to copy is
[`templates/FRONT_PROMPT.template.md`](../../../templates/FRONT_PROMPT.template.md).

## 1. Header

```markdown
# Front - Guest users across tenants (one login, several companies)

**Scope**: mixed (the "credential owner vs guest link" concept is portable; ids, code and decisions are ACME-2.1's)
**Origin**: Q-AB39 of `prompts/prompt_front_ab.md` - owner, 2026-03-04: "customer 1 supplies customer 2; could
customer 2 create a user with the same login and different rights? Analyse whether we open a front."
**Opened**: 2026-03-04. **State**: Round 0 answered in part (XY#1-XY#5); round 1 open (Q-XY23, Q-XY24); A-XY2 and
A-XY3 to ratify first. Nothing coded, no DDL, nothing committed. Resume from section 12.
**Writer**: session "front XY" (since 2026-03-04). Parallel: none.
**Namespace**: `XY` - home register: this file, section "Recorded decisions". Reserved: none.
**Ownership**: the sync group's code was not opened (names of its endpoints only - section 5 of the skill).
**Cross-cutting**: api (auth, users, onboarding), app (login, users screen), front GR (same link mechanism inside a
tenant group), front AB's wave (branch `ab-roles`, not merged - same `users.service`). Say it when resuming.
**Data access**: read-only sessions; the development database holds real data.
**Inventory base**: api `main` 3c1d2e0 · app `main` 7b9a415.
```

The State is short and current. Bad: a State that lists every round since the start. The
history is in the execution blocks and in the commit log.

## 2. The ask and what is already decided

```markdown
## 1. The ask and what is already decided (inherited - not re-discussed here)

**Owner, literally (2026-03-04)**: "customer 1 supplies customer 2; ..."
Inherited: ACME-2.1#10 (the account authenticates only; the role lives in the tenant link) ·
ACME-2.1#14 (the super role exists only in the operator's tenant) · GR#3 (a group shares one schema).
```

## 3. Facts and objective defects

```markdown
## 2. Facts (read-only inventory on `main`; evidence file:line)

| # | Fact | Evidence |
|---|---|---|
| F1 | Creating a user with a login that already exists answers 409 "login in use" | `users.service.ts:212` |
| F2 | The same PUT writes the global account (e-mail, active) and the tenant link | `users.service.ts:240-266` |

### 2.1 Objective defects (fixing is not deciding)

- **C1 - The "reassign refund" button is hidden for everybody.** The route needs UPDATE on `refunds`, the app
  shows the button on `can('UPDATE')`, and the catalog has no UPDATE for `refunds`. Correction: the pair
  (`refunds`, UPDATE) in the backfill script. Not a question.

### 2.2 Impact today (read-only)

- No regular user exists yet (2 admins + 1 super in the only live tenant) - backfilling the catalog changes nobody's
  access today.
```

A fact the code answers is resolved and cited; only intent becomes a question
(decision-rounds, Round 0 step 0). A fact only the owner has (a date, a machine, a file not
handed over) goes to section 2.3 as `R-XY1`, with no options; its answer becomes an `F`. An
objective defect is an error with one correct fix - it goes to the deliverables, not to the
owner.

## 4. Inventory and its annex

When the item-by-item table is longer than a screen, the prompt keeps a summary of the
facts that drive the design, and the table goes to `prompt_<front>-inventory.md`:

```markdown
## 3. Facts that decide (summary - detail and evidence in `prompt_xy-inventory.md`)

| # | Fact | Consequence for the design |
|---|---|---|
| F7 | The invoice freezes the item's tax data at billing time | the catalog keeps the presumed fact; it never decides the snapshot |
| F9 | Records created on the web can be overwritten when the legacy sync reaches the same id | the screen is released only to tenants that no longer run the sync (a request to the sync group) |
```

## 5. Guardian opinion

```markdown
## 4. Guardian opinion (2026-03-04 - integrated)

**Concept**: the guest link is a fact of its own - an invitation the credential owner accepts - not a second account.
**Piece or composition**: a piece (the link gains a state; the account does not change shape).
**Reused**: the tenant link; the password-recovery flow. **Left out**: per-supplier data scope (another front).
**Names**: `invitation`, never "contract" (an occupied word in this glossary).
```

The format is the [`conceptual-guardian`](../../conceptual-guardian/SKILL.md) expected
output. A conceptual divergence stops the design and becomes a question.

## 6. Design and waves

```markdown
## 5. Design and waves (provisional - valid after Round 0)

| Wave | Content | Depends on |
|---|---|---|
| 0 | split what belongs to the account from what belongs to the link; the delete route goes | XY#1, XY#2; merge of `ab-roles` first (same file) |
| 1 | the intercepted creation: link inactive + e-mail; the acceptance activates it | Q-XY23 (where "awaiting acceptance" lives - DDL, guardian first) |
| 2 | app: acceptance at login, "awaiting acceptance" in the users list | wave 1 |
```

## 7. Negative knowledge (front level)

```markdown
## 6. Negative knowledge (what NOT to do - holds whatever is decided)

1. **Never tell the inviter WHERE the e-mail is a login, nor the person's name before acceptance** - an enumeration
   oracle across tenants (F12). Accepted limit: the flow reveals "a login somewhere" (A-XY4).
2. **An act on the LINK never touches the global ACCOUNT** (name, login e-mail, password, account active) - today
   one PUT writes both (F2): the root of a high finding in front AB's gate.
3. **Deactivating the account switches the person off in every tenant** - removing a guest deactivates the link (XY#2).
```

Wave-level entries look the same, under "Known limits" (section 9 below).

## 8. Questions and the status line under each

Format and recording are [`decision-rounds`](../../decision-rounds/SKILL.md) (problem,
evidence, options, one recommendation; the owner's words; divergences as such). What a
front adds is the **status line under each question**, so the round reads as a record:

```markdown
- **Q-XY1 - Which pairs enter the catalog now?** Evidence: F4 (INSERT/DELETE have no consumer). (a) VIEW on every
  screen + the actions the code checks (Rec.); (b) the full due set now; (c) VIEW only.
  **-> XY#1 = (b), DIVERGED from the Rec.** (owner, 2026-03-04, chat: "keep everything, we will use it").
- **Q-XY5 - Guard of the admin-only screens?** ... **Rec.: (a)**.
  **-> no answer; restated as Q-XY12 in round 1 with the corrected facts.**
```

A restated question takes a new number and cites the old one - never `Q-XY5'`.

## 9. Assumptions, deliverables, out of scope, success criteria

```markdown
## 9. Deliverables - only after the decision AND the release word

1. WRITTEN 2026-03-05: `scripts/012_catalog_backfill.sql` (96 pairs, by natural key, final check fails loudly).
2. PROVEN 2026-03-05 in a disposable schema (section 9): count, rerun = 0 new rows, impossible variant fails.
3. APPLIED - waits for the release word.

## 10. Out of scope (moves, never disappears)

- Per-supplier data scope -> its own front, if the owner asks (Q-XY9).
- Seats / user limits -> not a concept yet; if it is born, the unit is the active link.
- Any change in the sync service -> request to the sync group (section 5 of the skill).

## 11. Success criteria

1. One login chooses between its own company and the inviting one, with each company's role and rights (probe P3).
2. No path deletes a credential or changes a login e-mail (XY#1) - adversarial probe kept as a test.
```

Assumptions follow [the ledger format](../../decision-rounds/references/assumptions-and-release.md).

## 10. The wave execution block

```markdown
## 13. Wave 0 - 2026-03-06, worktree `xy/{api,app}`, branch `xy-wave0` - NOTHING committed

**Where**: `work/xy/api` (base `main` 3c1d2e0), `work/xy/app` (base `main` 7b9a415); outside git: links
`work/xy/node_modules`, `work/xy/api/.env` (linked file, read-only use). Data: read-only session. Sync code not opened.
**Precondition checked**: script 012 is applied (118 pairs, read-only count).

### 13.1 New facts (they correct premises of rounds 0-1)
- **F21 - the premise of XY#2 was false**: "each module only calls its own API" - 9 live cross calls (8 reads,
  1 write). Applied the existing rule "each screen reads its own list" as A-XY5.

### 13.2 What was done
- api: piece `module-gate.ts` (verb -> right; marked acts; named exceptions) ... (XY#2, XY#7)
- app: one gate point in the form factory ... (XY#2)

### 13.3 Assumptions executed - to ratify
- **A-XY5** - ... Applied: ... Undo: ...

### 13.4 Questions - round 2 (none blocks what was done; Q-XY11 blocks the RELEASE)

### 13.5 Tests
- api: 1480 tests, 96 suites (12 skipped - the live ones); new: `module-gate.test.ts` (18: verb map, acts, HEAD,
  unknown route, profiles), `routes-xy2.test.ts` (25: the real gateway map; a new POST route must be classified).

### 13.6 Gates
- Socratic 0.66 FAILED -> rework (4 items) -> 0.75 PASSED. Adversarial 0.71 with 1 HIGH -> fixed (interim barrier)
  -> 0.80 PASSED. Each confirmed finding became a probe test.

### 13.7 Known limits (negative knowledge)
- The gate depends on the router's internal shape; `module-gate.test.ts` breaks loudly if it changes.
- Each screen request costs one more query (licence) - no cache; same cost as today's action guards.

### 13.8 Release plan (only with the release word)
1. Script 013 before the app. 2. Merge api and app TOGETHER (old app on new api: 403 on two lookups). 3. Regenerate the
error catalog (3 new codes). 4. Expected conflict: `error-codes.ts` with front GR - both append: union.

### 13.9 Resume here (saved 2026-03-06)
(the resume block - template `RESUME_BLOCK.template.md`)
```

Every part is there even when short: "Known limits: none found - checked X and Y" is an
answer; a missing part is a gap.

## 11. Moving a closed wave to the annex

When the prompt passes 60 KB (or a wave closes and the owner asks for a lighter file):

1. **Pick what moves**: closed waves first (released or dropped, questions answered or
   carried), then the inventory, then long audits. Open material never moves.
2. **Create or extend the annex** `prompt_<front>-execution.md` with its own header:

   ```markdown
   # Annex - execution of front XY

   **Scope**: mixed
   **Front**: `prompts/prompt_xy.md` (sections 13 and 14 point here)
   **Why**: the front prompt passed 60 KB; closed waves live here (T26).
   ```

3. **Move verbatim**, keeping the section numbers (`## 13. Wave 0 ...` stays `13`): every
   "see section 13.8" in commits, resume prompts and other fronts keeps resolving. No
   rewording during a move.
4. **Leave a stub in place**:

   ```markdown
   ## 13. Wave 0 - executed and released 2026-03-08
   Moved to `prompt_xy-execution.md` section 13. In short: account vs link split, delete route removed, gates
   0.75/0.80; released as api 4e5f6a7, app 8b9c0d1.
   ```

5. **Lift the negative knowledge** that still holds into section 6 of the prompt, each
   entry with "(from wave 0)".
6. **Fix the resume pointers** (header State, resume block, the index line).
7. **Check the size again**, then one checkpoint commit: `Front XY: wave 0 moved to the
   execution annex (prompt 41 KB)`.

## 12. Recorded decisions and pending

```markdown
## Recorded decisions

### Round 0 - answered in part (owner, 2026-03-04, chat)
- **XY#1** (Q-XY1 = (b), DIVERGED from the Rec.) - "keep everything, we will use it": ...

## Pending
- Ratify first: A-XY2, A-XY3. Answer: Q-XY11, Q-XY23, Q-XY24. Ratify: A-XY4...A-XY8.
- Blocks the release: Q-XY11. Requests out: sync group R-7 (open).
```

When the front's namespace has its home register elsewhere (a project register), this
section is a one-line mirror per decision pointing to it - never a second full copy
(decision-rounds, "one home register per decision").
