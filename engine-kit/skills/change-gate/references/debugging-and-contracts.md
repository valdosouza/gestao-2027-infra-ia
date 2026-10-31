# Divergence-point debugging, path integrity and anti-patch

**Scope**: method

Companion of [the change-gate skill](../SKILL.md) - techniques T81, T82 and T34, all
`operating`. They feed step 3: a plan artifact that ignores them is not ready for the gate.
Example: **Acme Orders**, change **CR-123** (partial shipment of an order).

## Divergence-point debugging (T81)

For a result that is **wrong without a crash**. A crash shows where it happened; a wrong
value does not, and the fix tends to land where the value is *displayed* instead of where
it went wrong. So no fix is proposed before four points are written down.

### The four points

| Point | Write down | Not enough |
|---|---|---|
| 1. Symptom | expected value vs actual value, on which input, in which environment | "the total is wrong" |
| 2. Recall | what the memory knows about the units involved; cards quoted by id; past logs on the same symptom | "nothing relevant" without the query |
| 3. State map | the values that carry the result from input to output, step by step, with where each is computed | reading the code top to bottom |
| 4. First diverging statement | the first step where the actual state departs from the expected one | the last step, where the wrong value appears |

**The fix goes at point 4.** A correction applied later in the chain leaves every other
consumer of the diverged value wrong.

### The audit, in this order

1. **Undefined names** - a function or variable used but defined elsewhere: find its
   definition before reasoning about it. Never guess what it does.
2. **Recent rule changes** - the history of the units in the state map: did a recent
   change alter the rule? (The full forensic lens over several revisions belongs to the
   [`result-review`](../../result-review/SKILL.md) skill:
   [revision forensics](../../result-review/references/revision-forensics.md).)
3. **Side effects** - shared modules, globals and caches that another thread or session
   can change between read and use.
4. **Conditionals** - every branch on the path: empty strings, null objects, zero dates
   and boundary values that skip a validation.
5. **Data integrity** - the state of each record at every write, and the order of the
   writes.
6. **Type conversions** - implicit numeric and variant conversions, rounding, string
   encoding.
7. **Swallowed errors** - an empty catch on the path is a finding in itself: it hides the
   real failure ([anti-patch](#anti-patch-t34)).

### Report

**Root cause** (the point of divergence) - **Logical trace** (input -> divergence -> wrong
output) - **The fix** (at the divergence) - **Card candidate** (decided at the close).

### Worked example

Symptom: an order of 10 units at 5.00 with a 10 % discount, shipped 4 + 6, invoices 18.00
+ 30.00 = 48.00; expected 45.00.

| # | Value | Expected | Actual | Computed in |
|---|---|---|---|---|
| 1 | line net price | 4.50 | 4.50 | `pricing/line_price:31` |
| 2 | shipped quantity, first shipment | 4 | 4 | `orders/shipment:58` |
| 3 | invoice line amount, first shipment | 18.00 | 18.00 | `billing/invoice_line:22` |
| 4 | invoice line amount, second shipment | 27.00 | 30.00 | `billing/invoice_line:22` |

First divergence: row 4 - the second invoice re-reads the **list** price because the
discount is applied only "on the first invoice of an order" (`billing/invoice_line:19`).
The fix goes there (the discount belongs to the line, not to the first invoice), not in
the invoice total, where the wrong 48.00 shows.

## Path integrity and contract first (T82)

### Never cite a symbol you have not read

- A file, function, class, page, endpoint, column or setting named in a plan artifact,
  a review or a hand-off has been **opened and read in this task**, or resolved through the
  code graph and then read.
- A name the agent cannot resolve is not guessed: it is removed, or written as an open
  question ("`InvoiceRules` is referenced in the dossier; not found in the working copy").
- The same holds for paths: a path is written after it was seen to exist, in the path
  style of the active shell.

### Contract first

Before code, for any change that crosses a tier boundary (server and client, service and
service, code and database):

1. **Write the contract**: every field name exactly as the producer will emit it, its type
   on both sides (dates, decimals, booleans and nulls mapped explicitly), required vs
   optional, and the error envelope.
2. **Walk it end to end**: producer type -> wire field -> consumer read. A field the
   consumer reads under another name or type is a defect found before it exists.
3. **Every consumer call handles both paths**: success and failure, with the error
   envelope read the same way everywhere.

```markdown
| Field (wire) | Producer type | Consumer reads | Notes |
|---|---|---|---|
| `lineId` | integer | `line.lineId` (number) | required |
| `qty` | decimal, 3 places | `Number(line.qty)` | > 0 and <= open quantity (ORD#14) |
| `code` (error) | string enum | `err.code` | `QTY_EXCEEDS_OPEN`, `ORDER_CLOSED` |
```

### Done means every tier resolves

A cross-tier change is complete only when, **in the same working tree**:

- [ ] the handler or endpoint exists with the contract's names and types;
- [ ] the data layer it calls exists and reads or writes the contract's fields;
- [ ] the consuming page or client exists and reads exactly those fields, on both paths;
- [ ] each of them was read after the change - not assumed from the plan.

One tier green (a server test passing) is not the change done.

## Anti-patch (T34)

**Silencing a crash or a warning is a finding, not a fix.** The check is at step 3: a plan
that silences something is rejected at the gate, never discovered at the review.

| The patch | Why it is not a fix | Instead |
|---|---|---|
| A null guard added where the crash happened | the object should not be null there; the guard hides who freed or never created it | trace creation, ownership, destruction and concurrency; fix where the lifecycle breaks |
| An empty catch, or a catch that only logs and continues | the failure still happens; now nobody sees it | handle the specific failure with a defined outcome, or let it surface |
| A compiler or linter warning switched off | the warning names a real risk (an uninitialised value, an unsafe conversion) | fix the code the warning points at |
| A retry loop or a longer timeout around a flaky step | it hides a race or an ordering defect | find the ordering; make the step deterministic |
| A widened tolerance or a weakened assertion in a test | the test no longer pins the behaviour | fix the code, or change the expected behaviour through the owner (a gated revision) |
| A special case for the one record that fails | the rule is still wrong for the next record | fix the rule; the record is the test case |

- Every plan artifact carries the line *"This plan silences nothing"* - or names the
  finding it records.
- When the cause is out of reach in this change (a third-party component, another group's
  code), the plan says so, the finding is recorded with its evidence, and the owner
  decides. A guard never enters as a quiet "fix".
