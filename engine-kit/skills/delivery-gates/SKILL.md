---
name: delivery-gates
description: Use when a change's tests are green and it is about to be called done, handed over or released, or a later delta (a fix, a walk finding, probes alone) needs re-gating - a Socratic risk review scored 0-1 (pass at 0.70), an adversarial attack with no HIGH or CRITICAL left, every finding a permanent probe, and the owner's logged-in walk.
---

# Skill: Delivery gates (after green, before done)

**Scope**: method
**Maturity**: operating

**When to use**: a delivery - an endpoint, a module, a screen, a migration, a fence, a
whole wave of a front - has its tests green and someone is about to call it done, hand it
over or ask for the release word. Also after every later correction to it (a gate fix, a
walk finding, a decision executed afterwards, a change to the probes or tests alone): the
gates run again on that **delta**.
**Not for**: replacing the tests (the gates run after them, never instead), designing the
change (the change gate, planned for wave 2), or deciding architecture (a finding that
needs a choice becomes a numbered question).
**Real origin**: case zero - a multi-service modernization where every delivery wave of
every front ran these gates (2026-08 to 2026-10): dozens of recorded passes; first passes
failed at 0.64-0.68 and passed after rework at 0.74-0.82; adversarial passes found HIGH
findings that a fully green, fully mocked suite had missed. One case, core by choice:
`operating` ([maturity](../../docs/MATURITY.md)); technique T39 in the
[register](../../docs/TECHNIQUES.md).
**Inspiration**: the Socratic tech-lead review and the adversarial QA skills of
[harness-kit](https://github.com/romabeckman/harness-kit) (MIT). The score gate, the
severity verdict and "a confirmed finding becomes a test" come from there; the probe
labels, the delta re-score and the owner's walk were added by the case.
**Hands off to**: [`decision-rounds`](../decision-rounds/SKILL.md) (a point that needs the
owner becomes a question `Q-<NS>n`; passing the gates is not the release word),
[`disposable-proof`](../disposable-proof/SKILL.md) (where live attacks and the walk run
when real data must not change), [`fences`](../fences/SKILL.md) (a finding about a silent
drift usually becomes a fence), [`retain-knowledge`](../retain-knowledge/SKILL.md)
(the limits the gates accepted are negative knowledge) and
[`evaluate-harness`](../evaluate-harness/SKILL.md) (design: first-pass scores would feed
its gate-quality component).

---

## The principle

Green tests prove the code does what its author thought of. The gates ask the two
questions the author could not: **what breaks in production** (the Socratic review) and
**what breaks when someone tries** (the adversarial review). Then they make the answers
permanent - every attack becomes a probe in the suite - and they end where the user is:
the owner, logged in, walking the real application.

| # | Gate | How | Passes when |
|---|---|---|---|
| G1 | Socratic risk review | a reviewer persona that only asks; simulates production under stress against a risk checklist | score >= 0.70 |
| G2 | Adversarial review | an attacker persona; runs the attacks it can against a dev database or a disposable copy | score >= 0.70 **and** no HIGH or CRITICAL finding |
| G3 | Permanent probes | every attack tried and every finding becomes a labelled test in the suite | every finding has its probe; the suite is green, expected failures included |
| G4 | Owner's walk | the owner, logged in, walks the real application through the delivery | each observation is fixed, decided, or recorded as a limit |

Example used throughout (fictional): **Acme Orders, front `ORD`, delivery "partial
refunds"** - a new endpoint `POST /orders/:id/refunds`, a button on the order screen and a
seed of refund reason codes.

## Where the gates sit

```
plan / spec / red test -> code -> tests green -> G1 -> G2 -> G3 -> G4 -> close -> release word
                                       ^______________ rework = a delta ______________|
```

- **After green, never instead of it.** A gate run on red code reviews the wrong thing.
- **Before the release word.** Passed gates are evidence for the owner, not a release;
  the release word belongs to [`decision-rounds`](../decision-rounds/SKILL.md).
- **Warn-only by default** ([EK#6](../../DECISIONS.md)): the gates are a process the agent
  runs and records. A project makes them blocking - for example, closing refuses a
  delivery without a gate record - by its own numbered decision.
- **The two reviews are separate passes**, ideally separate agents: the reviewer who asks
  and the attacker who breaks look for different things, and one persona doing both
  drifts to the easier half.

## G1 - Socratic risk review

A senior reviewer who **asks, never writes code and never decides architecture**. Detail,
score anchors and report format: [references/socratic-review.md](references/socratic-review.md).

1. **Read the reference first**: the front's prompt and its decisions (`KEY#N`), the
   project's architecture rules, the diff of the delivery - and the older code the
   delivery relies on.
2. **Simulate production under stress** against the checklist: scale, tenant isolation,
   transaction boundaries, concurrency, idempotency, external failure, sensitive data,
   authorization, error contract, recorded decisions.
3. **Write 3-5 open points**, each a question with its concrete failure scenario ("what
   happens to this list when the client has 50 000 orders?"), never a ready-made fix.
4. **Score 0.00-1.00.** Below 0.70: rework before delivering - the open points are the
   rework list. At 0.70 or above: deliver, with the open points recorded as explicit
   pending items.
5. **A point that needs the owner** goes to a separate list and becomes a numbered
   question; the reviewer never settles it by changing code silently. After the go, that
   round carries the plan's revision ([below](#rework-deltas-and-the-score-chain)).

## G2 - Adversarial review

An attacker whose success is **the case nobody tested**. Vectors, severity scale and
verdict format: [references/adversarial-review.md](references/adversarial-review.md).

1. **List the promises** of the contract: status codes, envelopes, invariants, decisions.
2. **Build the attack matrix**: vectors x promises.
3. **Execute** what can be executed - probes against a dev database or a disposable copy,
   never against shared data - and mark each result `proven` (a command or a test) or
   `analysed` (file:line). Reading is not proving.
4. **Attack the probes too** - a probe that a wrong fix satisfies guards nothing. In a
   disposable copy, mutate the code under each probe the delivery adds or changes: remove
   the barrier (a `RESISTED` or `FIXED` probe must fail); apply another option of the
   question, or half of the recommended one (a `FINDING` probe must keep failing on its
   assertion, never turn red as if fixed). A probe that answers a mutation otherwise is a
   finding against the probe.
5. **Classify** each finding LOW / MEDIUM / HIGH / CRITICAL.
6. **Verdict**: any HIGH or CRITICAL fails the delivery whatever the score; a score below
   0.70 fails it too. A HIGH that **predates** the delivery but defeats it still fails the
   gate: close it in the session (an interim barrier is enough) and open a question for
   the definitive fix.

## G3 - Every finding becomes a permanent probe

The report never replaces the test. Every attack the review tried and every finding it
made lands in a probe file of the suite (one per gate, for example
`orders-refunds-adversarial-gate.test`), with a label in the test name:

| Label | Meaning | The probe asserts |
|---|---|---|
| `[RESISTED]` | the attack was tried and the code held | the refusal (status, unchanged data) - so no later change reopens it |
| `[FIXED <severity>]` | the attack succeeded and the fix landed | the corrected behaviour; written red first, against the unfixed code |
| `[DECIDED <KEY#N>]` | the owner decided that what the attack found is intended | the decided semantics - so nobody "repairs" it later |
| `[FINDING <severity> <Q-id>]` | accepted, or waiting for the owner | the correct behaviour - while the question is open, its **whole recommended option**, read against every option of the question - as an **expected-failure test** |

An expected-failure test (`it.failing` in Jest, `xfail(strict=True)` in pytest, or the
framework's equivalent) keeps an open finding visible in every run and **turns red the day
someone fixes it**, so the label is promoted on purpose - to `FIXED`, or to `DECIDED` when
the owner rules the behaviour intended (an answer that is not the recommended option
rewrites the probe on it). **Only the recommended option, whole, turns it red**: the probe
asserts every part of that option (the refusal and the unchanged data, every path and
variant it names) and is read against each other option of its question - another option,
or half of the recommended one, keeps it failing; otherwise a wrong fix reads as done. A
probe on a time limit reads either side of the boundary with a margin (just under, just
over), never the exact boundary. The marker passes on **any** failure, an exception
included, so a `FINDING` probe is checked like a `FIXED` one: it fails **on its assertion,
for the reason its name gives** - never on a missing column, an import or a setup error
(pin the failure type where the framework can: `raises=AssertionError` in pytest; where it
cannot, a suite test runs each `FINDING` probe without its marker and requires an assertion
failure). Lifecycle and examples: [references/probes-and-walk.md](references/probes-and-walk.md).

Socratic findings that were fixed get a test too (a `FIXED` probe or a plain regression
test): the correction must be pinned, not only remembered.

## G4 - The owner walks the real application

The gates read code and drive requests; the owner sees what a user sees. Before the
delivery is called done, the owner **walks the real application, logged in**.

- **The owner types the login** - never the agent (prepare-only,
  [T29](../../runtime/guards/HARNESS-PERMISSIONS.md)). After the login the agent may drive
  the browser, read the page and record literal values, with the engines and read-back
  rules of [`browser-verification`](../browser-verification/SKILL.md).
- **The agent prepares a walk script**: the screens and acts of the delivery, the states a
  user meets (empty list, a link from another tenant, a user without the permission) and
  **provoked failures** - a local proxy that answers a gateway error or hangs, to see what
  the user is told.
- **Where the walk would touch data that must not change** (real customers, an outbound
  provider), it runs on a disposable instance with outbound hosts blocked
  ([`disposable-proof`](../disposable-proof/SKILL.md)).
- **Each observation gets an id** (`P-1`, `P-2`, ...) and an outcome: fixed, a question for
  the owner, or a recorded limit. Fixes from the walk are a delta: G1-G3 run again on it.
- **While the walk waits**, the closing record and the release list wait as a draft; the
  walk and the release word may be asked in one message, and the word releases the list
  only once the walk passed ([`close-and-retain`](../close-and-retain/SKILL.md#drafts-while-a-gate-waits)).
- **Something seen once and not reproduced** is recorded with what was tried and how to
  capture it next time - never dropped.

## Rework, deltas and the score chain

- **Rework re-scores.** After a failed gate, fix the open points; the same gate runs again
  on the reworked code and **verifies each correction at file:line**. What the re-score
  finds new is handled the same way.
- **Every later correction is a delta** (`base..tip`): the gates' own corrections, the
  walk's fixes, a decision executed afterwards. The gates run on the delta and are
  recorded as gates of that delta.
- **A delta that changes only probes or tests is gated too.** No production byte moves,
  but a probe that does not discriminate lets the next wrong fix through. G2 checks that
  each changed probe discriminates (the mutation of [G2](#g2---adversarial-review), step 4,
  in a copy); G1 that each asserts its decision, or its question's recommended option,
  whole. Their scores enter the chain like any delta's.
- **Record the chain, not the last number**: `Socratic 0.66 -> 0.78 PASSED; adversarial
  0.72 (1 HIGH) -> 0.75 (1 new HIGH) -> 0.81 PASSED`. The failed passes are the evidence
  of what the gates are worth.
- **Gates that diverge with no way out** - one can only pass what the other fails, after a
  real attempt - stop the work and go to the owner as a question.
- **Questions the gates raise after the go** change approved behaviour. Their round
  carries the plan's revision, written on the round's recommendations, with its go asked
  on a line of its own ([`decision-rounds`](../decision-rounds/SKILL.md#a-round-raised-after-the-go-the-ek26-pattern);
  [`change-gate`](../change-gate/SKILL.md) step 4) - one stop for the owner, not two. Each
  question's `FINDING` probe asserts that same recommended option, whole.

## The gate record

Written in the front's prompt, under the delivery, after each pass:

```markdown
### Gates - ORD partial refunds (delta 3f1c2a0..9be7d41)
- **Socratic 0.66 - FAILED** (threshold 0.70). Open points: (1) two refunds at once on one
  order... (2) ... Rework done: (1) row lock on the order; (2) ...
- **Socratic re-score 0.78 - PASSED.** Corrections verified: refund.service:88, ...
  Points for the owner: Q-ORD14.
- **Adversarial 0.72, 1 HIGH - FAILED.** HIGH (proven): a clerk without the refund
  permission refunds through the older bulk route. Fixed in the session; probe `[FIXED HIGH]`.
- **Adversarial re-test 0.81 - PASSED** (no HIGH/CRITICAL). Remaining: MEDIUM ... (Q-ORD15),
  LOW ... (limit). Probes: orders-refunds-adversarial-gate.test - 31 (27 RESISTED,
  3 FIXED, 1 expected failure FINDING MEDIUM Q-ORD15).
- **Owner's walk 2026-03-09** - P-1 (raw error text on a timeout) fixed; P-2 -> Q-ORD16.
```

## Anti-patterns (each one happened)

- **All green, all mocked, unusable.** Hundreds of passing tests, and the first real call
  returned a server error (a column that did not exist) while the new lookup tables were
  empty (no seed in the package). Permanent vectors: one real end-to-end cycle (create ->
  read -> update -> delete) per new module against a real database; and "new lookup table:
  who fills it, and is the seed in the package?".
- **The database that already went through the previous version.** A seed that skipped
  what an earlier version had left behind needed manual updates later. Vector: run the
  delivery on a copy that went through the previous release.
- **FIXED for the wrong reason.** A probe turned green because the test double started
  answering a new query, not because the barrier worked. Check that each probe fails for
  the reason its name gives.
- **FINDING for any reason.** An expected-failure probe on a column that did not exist yet
  "failed as expected" - on the error, not on the behaviour it named (a greenfield exit
  test). A `FINDING` probe is checked to fail on its assertion, like a `FIXED` one.
- **FINDING asserting a part.** Probes written to "assert the recommended option" each
  asserted one part of it: another option, a half fix or a column with a default would
  have read as the fix, and one read a time limit exactly at its boundary. The adversarial
  pass on that probe-only delta proved it by mutation and failed it (a greenfield exit
  test). Assert the whole option, read against the others; read time either side of the
  boundary.
- **Tight timing probes.** Time-based probes with margins of tens of milliseconds flaked
  when the whole suite ran on a busy machine. Give them generous margins and say so.
- **Silencing as a fix.** Catching and swallowing the error an attack provoked is a new
  finding, not a fix.
- **The reviewer decides.** A finding that needed the owner and became a quiet code change
  hides the choice; it must be a numbered question.
- **Only the diff.** An older route or writer that defeats the new rule is in scope: the
  gates review the result, not the patch.
