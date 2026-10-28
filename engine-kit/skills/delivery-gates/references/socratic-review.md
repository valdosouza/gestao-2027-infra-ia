# Socratic risk review (delivery gate G1)

**Scope**: method

Companion of [the delivery-gates skill](../SKILL.md), gate G1. Adapted from the Socratic
tech-lead review of [harness-kit](https://github.com/romabeckman/harness-kit) (MIT): the
portable principle is "a reviewer who asks, with a score gate"; the checklist below is
neutral, and each project adds its own reference documents.

## Role and limits

- **A senior reviewer** who looks for systemic risk - what breaks under load, under
  concurrency, when a dependency fails, across tenants - and states it as **questions**
  with a failure scenario, not as solutions.
- **Does not decide architecture or business behaviour.** A finding that needs a choice
  becomes a numbered question for the owner
  ([`decision-rounds`](../../decision-rounds/SKILL.md)); it never turns into a silent
  change.
- **Does not write code during the review.** It names the logical or architectural flaw
  and the scenario in which it explodes; the fix is the author's rework.
- **Runs after the tests are green.** The tests prove the code works as written; this
  review asks what fails in production.

## Read before reviewing

| What | Why |
|---|---|
| The front's prompt and its recorded decisions (`KEY#N`) | a delivery that contradicts a decision is a finding; cite the number |
| The project's architecture rules (module shape, guard per module, error envelope, pagination rule) | the boundary of acceptable structure |
| The database standards and the data model the delivery touches | transactions, keys, soft delete, naming |
| The diff of the delivery **and** the older code it relies on | the risk often sits in what the new code calls, not in what it adds |
| The gate records of earlier waves of the same front | a risk already accepted is a limit, not a new finding; a risk fixed before must stay fixed |

A project keeps the list of its own references in its rules file; this page does not
name any.

## The risk checklist

Simulate production under stress and walk the list:

1. **Scale** - what happens with a million rows? A query without pagination or index? One
   update per row in a loop instead of a set operation? N+1 reads in a list?
2. **Tenant isolation** - can a query read or write another tenant's data? Does the tenant
   id always come from the authenticated identity, never from the request body?
3. **Transactions** - are the writes that must be atomic in the same transaction? What is
   left in the database if it fails half-way?
4. **Concurrency** - two requests on the same resource at once (next number = max + 1,
   counters, status changes): race? lock? which one wins?
5. **Idempotency** - the same request or message sent twice: does anything duplicate?
6. **External failure** - the dependency is down or slow: is there a timeout? Does the
   error reach the caller with the right status (never a success status masking an
   error)?
7. **Sensitive data** - a field that should not leave in the response? A log line with a
   document number, a password, a token, an SQL text?
8. **Authorization** - the right guard on the route? A new endpoint left open by
   accident? A path that skips the guard (a bypass for an administrator, a second route
   to the same writer)?
9. **Error contract** - the project's error envelope respected? A code from the error
   catalog, or a bare message?
10. **Recorded decisions** - does the implementation contradict a numbered decision?
    Cite it.

## Writing an open point

An open point is a question that teaches, anchored in a concrete scenario:

| Weak | Strong |
|---|---|
| "Add pagination." | "How does this list avoid loading every order into memory when the client has 50 000?" |
| "Check concurrency." | "Two clerks refund the same order at the same second: what stops the total from going past the order value?" |
| "Error handling is weak." | "When the payment provider times out, how does the caller tell 'refused' from 'unknown'?" |

- **Systemic, never syntactic.** Naming, formatting and style are not gate material.
- **3 to 5 points.** More than five usually means the delivery is not ready for a gate.
- **One architectural hint** (one sentence, the pattern, not the code) is allowed.

## The score

A judgment from 0.00 to 1.00, not an average of the checklist. **0.70 is the threshold.**
Anchors that keep scores comparable across reviews:

| Score | What it means |
|---|---|
| >= 0.85 | no systemic risk with a credible failure scenario; only hardening left |
| 0.75 - 0.84 | real but contained risks, each with a scenario and a clear next step |
| 0.70 - 0.74 | at least one risk that will bite in ordinary production, but bounded; deliverable with the points recorded |
| < 0.70 | a scenario that loses or corrupts data, crosses a tenant, escalates a privilege or breaks the contract under ordinary production conditions - rework first |

Be strict and fair: never round up to pass, never sink a score for style.

## Report format

```json
{
  "target": "the module, endpoint or files reviewed, with the delta base..tip",
  "score": 0.00,
  "openPoints": [
    "Socratic question on scale/performance, with the failure scenario",
    "Socratic question on tenant isolation or security",
    "Socratic question on transaction, concurrency or idempotency"
  ],
  "architecturalHint": "one sentence naming the pattern, not the code",
  "questionsForTheOwner": ["only when a point needs a decision - becomes Q-<NS>n"]
}
```

The front's prompt keeps the markdown summary (the gate record of the skill); the JSON is
the reviewer's raw output and may be kept beside it.

## Re-score on a delta

- The re-score reads **only the delta** plus whatever the delta touches, and verifies each
  correction of the rework at **file:line** ("correction (3) verified at
  router.test:120").
- Leftovers it finds are fixed in the same session when cheap, or recorded (open point,
  question, limit).
- A re-score never rewrites the earlier pass: the chain `0.66 -> 0.78` stays in the
  record.
- **A delta that changes only probes or tests** is reviewed too: each changed probe is
  read against the decision it cites, or its question's recommended option - does it
  assert the whole of it, and does another option or a half fix leave it failing? The
  mutation that proves it is G2's ([adversarial review](adversarial-review.md)).

## Calibration questions (from real misses, neutralized)

- **A fixed row limit on every list** lived for months before it became its own project.
  The question that would have caught it: "what happens to this list when the client has
  50 000 records?".
- **A success status masking an error** - a sync endpoint answered success with an error
  body, and the client marked the record as synchronized. The question: "how does the
  CONSUMER tell success from failure in this contract?".
- **A guard reading the wrong segment of the path** stayed invisible because the
  administrator role bypassed the guard. The question: "which request path does NOT go
  through the bypass and proves the guard works?".
- **A key of unbounded size** - a rate limiter keyed by an e-mail of any length let one
  client fill the server's memory. The question: "what is the largest value this key can
  take, and who controls it?".
