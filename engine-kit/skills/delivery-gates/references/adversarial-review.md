# Adversarial review (delivery gate G2)

**Scope**: method

Companion of [the delivery-gates skill](../SKILL.md), gate G2. Adapted from the
adversarial QA skill of [harness-kit](https://github.com/romabeckman/harness-kit) (MIT): the
portable principle is "an attacker with a severity verdict, and a confirmed finding becomes
a test"; the vectors below are neutral, and each project adds the ones its contracts
need.

## Role

The goal is to **break the delivery**. Success is the case nobody tested. The contract -
the API description, the front's decisions, the error and page envelopes - is the
boundary of correct behaviour: everything it promises and the code does not keep is a
finding.

## Promises first

Before attacking, write down what the delivery promises:

- status codes per outcome (created, refused, not found, conflict, not permitted);
- the envelopes (error, paginated list) and their fields;
- invariants (a refund never exceeds the order; a tenant never sees another's rows);
- the decisions `KEY#N` that shape behaviour.

The attack matrix is **vectors x promises**. A vector that touches no promise is skipped
on purpose, not forgotten.

## Attack vectors

**Generic - every delivery**

1. Input edges: null, empty string, zero, negative, a huge number, accents and unicode,
   a missing required field, a field of the wrong type, an object where text is expected.
2. Size: the largest value each input can take - a body of megabytes, a key used for
   caching or rate limiting, a list parameter with ten thousand items.
3. Injection: quote characters, comment markers, `%` and `_` in LIKE filters - is every
   query parameterized?
4. Authorization: no token, a token of another tenant, a user without the permission, a
   forged role, a role name spelled with other letter case.
5. Duplicates and concurrency: the same request twice; two clients writing one resource;
   a burst of 25 parallel requests against a limit.

**Lists and pages**

6. `page=0`, `page=99999`, `pageSize=-1`, `pageSize=10000`; does the count use the same
   filter as the list?

**Tenants and identity**

7. The id of another tenant's resource in the URL: refused without revealing that it
   exists (same status, same body, same time)?
8. Timing oracles: does an existing account answer slower or faster than a missing one?

**Routes and ids**

9. URL and verb tricks: case, trailing slash, encoded slash, path parameters with `;`,
   double slashes, HEAD / PATCH / unusual verbs, method-override headers.
10. Id spellings: `011`, `1.1e1`, `+2`, `0x2`, `%202`, `2.0` - does every spelling reach
    the same check?

**State and data**

11. Soft delete and revival: create with a code that existed and was deleted; revive a
    row a guard counted only while alive.
12. Dependency order: send the child before the parent it references - a clear error or
    stored garbage?
13. Partial payloads: an optional block missing - does the fallback overwrite real data?
14. The backing service down: a server error without leaking SQL, paths or stack.
15. A database that already went through the previous version.

**Older code in scope**: every other writer or route that reaches the same data. A HIGH
found there - even if it predates the delivery - fails the gate when it defeats the
delivery's rule.

**The probes themselves** - every probe the delivery adds or changes (G3)

16. Mutation in a disposable copy of the code: the barrier removed - a `RESISTED` or
    `FIXED` probe must fail; another option of the probe's question, or half of its
    recommended option, implemented - a `FINDING` probe must keep failing on its assertion,
    never turn red as if fixed; likewise a column added with a default, a time read at the
    exact boundary. A probe that answers a mutation otherwise asserts too little: a finding
    against the probe (`proven`, the mutation and the run as evidence).

## Proven or analysed

Execute what can be executed: a request against a dev server, a probe test with the real
router, a script against a **disposable copy** ([`disposable-proof`](../../disposable-proof/SKILL.md)).
Never attack shared or production data. Each result says how it is known:

- `proven` - the command or test that showed it;
- `analysed` - the file:line read, when it could not be executed.

A `proven` HIGH outranks an `analysed` one; an `analysed` HIGH is still a HIGH until a
probe says otherwise.

## Severity

| Severity | Meaning |
|---|---|
| CRITICAL | exploitable now, from outside or by any user: mass data loss, cross-tenant leak, takeover of an administrator account |
| HIGH | a user changes or reads what they must not; data is corrupted; the delivery is unusable against the real database |
| MEDIUM | a real defect behind a narrower precondition: a race that needs concurrency, a timing oracle, a false negative of a fence |
| LOW | hardening and defence in depth: a response header that reveals activity, a cache without expiry, a message that names an internal |

## Verdict format

```json
{
  "target": "the module or endpoint attacked, with the delta base..tip",
  "score": 0.00,
  "passed": false,
  "findings": [
    {
      "type": "AUTH_BYPASS | TENANT_LEAK | INJECTION | RACE_CONDITION | DATA_EXPOSURE | ...",
      "severity": "LOW | MEDIUM | HIGH | CRITICAL",
      "description": "where, with which input, with which effect",
      "evidence": "proven (command or test) | analysed (file:line)",
      "probe": "the test name with its label"
    }
  ],
  "resisted": ["attacks tried that the code held - each one is a RESISTED probe"],
  "untested": ["edge scenarios the suite does not cover - candidates for new tests"]
}
```

- `passed` is true **only** when the score is at least 0.70 **and** no finding is HIGH or
  CRITICAL.
- A finding is actionable: "injection in the `name` filter of the order list", never "risk
  of injection".

## Re-test rules

- **Attack the reworked version**, not the report of the fix. Re-attack every earlier
  finding marked fixed: the fix itself is a new surface.
- **A new HIGH in the re-test fails it**, even when the first HIGH is now closed. Two or
  three passes are normal; record each.
- **An interim barrier** (the narrowest refusal that closes a HIGH in the session) is a
  valid fix for the gate; the definitive design goes to the owner as a question, and the
  barrier's limits are recorded.
- **The probes are the proof of the re-test**: a finding is closed when its probe is
  `[FIXED]` and green, not when the text says so.
- **A delta that changes only probes is attacked too** - with vector 16: no production
  byte moved, so the attack is on whether each changed probe discriminates.

## What real attacks found (neutralized)

- An older route outside the new guard let a user without the permission rewrite a
  record the new module protected - found by probing every writer of that table, not the
  diff.
- A barrier counted only live links; with a revoked link, an administrator of one tenant
  could reset a password and inherit a superuser link the moment it was revived.
- A fence configured from an environment value read a malformed list as an empty set - an
  open fence, without a log line.
- A second attack pass found a HIGH in code the first fix had touched: re-tests are not a
  formality.
- A pass on a delta that changed only probes failed it: five expected-failure probes each
  asserted one part of their recommended option, and a mutation in a copy (another option,
  a half fix) turned them red as if fixed - a wrong fix would have read as done (a
  greenfield exit test).
