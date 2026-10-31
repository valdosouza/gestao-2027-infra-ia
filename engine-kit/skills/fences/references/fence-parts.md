# The six parts of a fence - worked example

**Scope**: method

Companion of [the fences skill](../SKILL.md). One fictional invariant, built end to end:
**Acme Orders** checks permission pairs (screen x action) in API guards and in UI buttons;
the pairs live in a catalog table that a superuser edits through two admin screens
(Screens, Actions). The sketches are TypeScript-flavoured pseudo-code; the shape is what
matters, not the language.

## 1. The source list

```ts
// shared/auth/permission-catalog.ts - the ONE list (ORD#30)
export type Consumer = { tier: 'api' | 'billing-svc' | 'ui'; where: string }

export const CONSUMED_PAIRS = [
  { screen: 'orders',  action: 'APPROVE', consumers: [
      { tier: 'api', where: 'orders.routes approve' },
      { tier: 'ui',  where: 'order_page approve button' } ] },
  { screen: 'returns', action: 'REFUND',  consumers: [
      { tier: 'api', where: 'returns.routes refund' } ] },
  { screen: 'returns', action: 'CANCEL',  consumers: [], absentBy: 'ORD#12' },
] as const

// a rule, not a pair: every screen in the menu needs VIEW
export const MENU_ACTION = 'VIEW'

// the pure check every reader uses - no I/O
export function catalogProblems(catalog: CatalogRows): Problem[] { /* ... */ }
```

- `absentBy` names the decision that keeps an entry out of the catalog on purpose; the
  scan fails if a consumer appears for an entry marked absent.
- `catalogProblems` is pure: the live test, the boot alarm, the publish script and the API
  refusal all call it with rows they read.

## 2. The static scan

```ts
// __tests__/permission-catalog-fence.test.ts
const uses = scanServer('src/')          // AST: every call of the guard primitives
  .concat(scanUi('../ui/lib/'))           // tokenizer: every can('ACTION') with its screen
const problems = fenceProblems(uses, CONSUMED_PAIRS)

it('every consumption is in the list, with its exact consumer', () =>
  expect(problems.outsideList).toEqual([]))
it('every list entry has a consumer (the list does not rot)', () =>
  expect(problems.unconsumed).toEqual([]))
it('no consumption is unreadable (fail closed)', () =>
  expect(problems.unreadable).toEqual([]))
it('every mounted module is fenced or a named exception', () =>
  expect(problems.unclassifiedModules).toEqual([]))
it('the scan is not blind: a planted violation fails it', () =>
  expect(fenceProblems(scanFixture('planted-violation'), CONSUMED_PAIRS).outsideList)
    .toHaveLength(1))
```

Scanner rules and the false negatives a gate found: [static-scan.md](static-scan.md).

## 3. The read-only live test

```ts
// __tests__/permission-catalog-live.test.ts (needs the dev database)
it('the session is read-only', async () =>
  await expect(db.query('UPDATE permission_pair SET id = id WHERE 1 = 0'))
    .rejects.toThrow())                                // proven, not assumed
it('every consumed pair exists in the live catalog', async () =>
  expect(catalogProblems(await readCatalog(db))).toEqual([]))
```

Red here means: the code that needs a pair reached the branch before the seed that creates
it reached the database. Fix the order, not the test.

## 4. The boot alarm

```ts
// shared/auth/assert-permission-catalog.ts - called once in server start
export async function assertPermissionCatalog(db, log) {
  try {
    const problems = catalogProblems(await readCatalog(db))   // same predicate
    for (const line of groupByClass(problems))
      safeLog(log, `[ALARM ORD-PERMS] ${line}`)
  } catch (e) {
    safeLog(log, `[ALARM ORD-PERMS] check could not run: ${safeMessage(e)}`)
  }                                                           // never rethrows
}
```

- One line per class: missing pair; name changed (compared as the UI compares it); name
  repeated on another row; menu screen without VIEW; key repeated or not canonical
  (compared as the database collates); an `absentBy` mark that is out of date.
- `safeLog` and `safeMessage` swallow their own failures: a broken logger or an error whose
  `message` getter throws must not stop the start.
- Prove it: with the catalog as it was before the fix (rows created before the seed,
  read-only) the alarm prints exactly the known missing pair; with today's catalog it
  prints nothing.

## 5. The publish script

```
check-permission-catalog --env <target env file>
  exit 0  no alarm                          prints: checked db=<name> host=<host> port=<port>
  exit 1  one or more alarm lines
  exit 2  the target env file lacks the database settings (its own message)
```

The publish procedure (a script, not a memory) runs it:

1. after the seed of the catalog - the seed is not done until the check exits 0;
2. before the server deploy and before the client build;
3. against the **target's** settings, given explicitly; when it falls back to a default,
   it says so.

The procedure stops on any non-zero exit. Publishing still waits for the release word
([`decision-rounds`](../../decision-rounds/SKILL.md)).

## 6. The refusal at the API

```ts
// screens.service / actions.service - before every write
assertNoCatalogViolation(currentRows, proposedRows, CONSUMED_PAIRS)
// -> 409 CATALOG_PAIR_IN_USE, fields: [{ pair: 'orders x APPROVE', consumers: [...] }]
```

Refused, for every role (integrity, not permission):

1. removing a consumed pair - including an update whose omitted field would clear all
   pairs of a screen;
2. a menu screen without VIEW (on create, and when a resource becomes a menu screen);
3. changing or deleting a screen key the code uses;
4. a key repeated on another live row (the guard resolves by key and takes the first);
5. renaming or deleting a consumed action by name (only letter case may change, if the
   consumer folds case);
6. giving another row the name of a consumed action.

A way out must exist for a real duplicate: deleting one of two **equivalent** rows (same
key, same menu place, same pairs) passes. Without it, a duplicate can only be fixed by hand
in the database.

## Where each part catches the original defect

| Moment | Part | What it says |
|---|---|---|
| the developer adds `can('APPROVE')` on a new screen | 2 | "pair outside the list" |
| the branch is merged before the seed | 3 | "pair missing from the live catalog" |
| the service restarts on a catalog someone edited | 4 | `[ALARM ORD-PERMS] missing pair ...` |
| the deploy of the client starts | 5 | exit 1 - the deploy stops |
| the superuser unticks APPROVE on the Screens page | 6 | 409, naming the API guard and the button |
