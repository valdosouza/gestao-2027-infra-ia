# Permanent probes and the owner's walk (delivery gates G3 and G4)

**Scope**: method

Companion of [the delivery-gates skill](../SKILL.md). G3 turns every attack into a test
that stays in the suite; G4 puts the owner in front of the real application.

## G3 - the probe file

One probe file per gate of a delivery, in the project's normal test folder, run by the
normal suite:

```
<area>-<delivery>-adversarial-gate.test.<ext>
```

- The file header names the gate passes it holds (`gate 1: 2026-03-08, re-test:
  2026-03-09`) and the delta of each.
- **Every attack the review tried** is a test, not only the successful ones. Most of the
  file is `RESISTED`: that is the wall a later change must not breach.
- A probe that needs a live database or a running service sits behind the project's live
  switch (an environment flag) and is listed as such in the gate record - never silently
  skipped.

## The labels

```js
// Acme Orders - ORD partial refunds - adversarial gate
describe('refunds adversarial gate', () => {
  it('[RESISTED] a refund with another tenant order id answers 404, same body as missing', ...)
  it('[RESISTED] the id spelled as "011", "+11", "1.1e1" reaches the same check', ...)
  it('[FIXED HIGH] the bulk route refuses a clerk without the refund permission', ...)
  it('[DECIDED ORD#21] a refund on a cancelled order is accepted and logged', ...)
  it.failing('[FINDING MEDIUM Q-ORD15] two parallel refunds never exceed the order total', ...)
})
```

```python
# the same idea in pytest
@pytest.mark.xfail(strict=True, raises=AssertionError, reason="FINDING MEDIUM Q-ORD15 - parallel refunds")
def test_parallel_refunds_never_exceed_total(): ...
```

| Label | Written when | Asserts | Lifecycle |
|---|---|---|---|
| `[RESISTED]` | an attack was tried and held | the refusal and the unchanged state | permanent |
| `[FIXED <severity>]` | an attack succeeded | the correct behaviour; red against the unfixed code first, then green | permanent; the severity stays as history |
| `[DECIDED <KEY#N>]` | the owner ruled the found behaviour intended | the decided behaviour, citing the decision | permanent; changes only with a newer decision |
| `[FINDING <severity> <Q-id>]` | accepted, or waiting for the owner | the correct behaviour - while the question is open, its whole recommended option, read against every option of the question - marked expected-to-fail; checked to fail on that assertion | promoted when it starts passing or when the owner answers (another option rewrites it) |

## The expected-failure test

An open finding is not a comment in a report. It is a test that states the **correct**
behaviour and is marked as expected to fail:

- Jest: `it.failing(...)`; pytest: `@pytest.mark.xfail(strict=True)`; other frameworks:
  their expected-failure marker. **Strict** matters: an unexpected pass must fail the run.
- **The marker accepts any failure** - an import error, a missing column, a setup
  exception "fail as expected" too. So the probe is read once: its failure is the
  assertion its name gives, on the behaviour it names. Pin the failure type where the
  framework can (`raises=AssertionError` in pytest). Where it cannot (no `raises=`), the
  default is **a suite test that runs each `FINDING` probe without its marker** and requires
  an assertion failure - so the check lasts: a setup step that starts raising later turns
  the suite red instead of keeping the probe "expected". A one-time run without the marker,
  its log kept, is the floor where no such test can be written - it proves the day it ran,
  not the next one.

  ```python
  # unittest has no raises=: one suite test keeps every FINDING probe honest
  class FindingProbesFailOnTheirAssertion(unittest.TestCase):
      def test_each_finding_probe_fails_on_its_assertion(self):
          for case, name in finding_probes():   # every test labelled FINDING in its name
              with self.subTest(probe=name):
                  probe = case(name)
                  probe.setUp()
                  try:
                      getattr(probe, name)()     # the body, without the expected-failure marker
                  except AssertionError:
                      continue                   # the reason its name gives
                  except Exception as error:
                      self.fail('%s fails on %r, not on its assertion' % (name, error))
                  finally:
                      probe.tearDown()
                  self.fail('%s passes: promote it to FIXED or DECIDED' % name)
  ```
- While the question is open, "the correct behaviour" is the question's **recommended
  option, whole**: the probe asserts every part of it (the refusal and the unchanged data,
  every path or variant the option names) and is read against every other option of the
  question - another option, or half of the recommended one, keeps it failing. An answer
  that picks another option rewrites the probe on the decision.
- **A time limit is read off its boundary**: one probe just under it and one just over,
  with a margin the clock cannot blur - never the exact boundary, which reads the same
  under an inclusive and an exclusive rule.
- Where a framework has no such marker, assert the current wrong behaviour, name the test
  `[FINDING ...] currently <wrong behaviour>`, and say in the test that the assertion flips
  when the finding is fixed.
- When the finding is fixed, the expected failure turns red; whoever fixed it relabels the
  probe `[FIXED ...]` and removes the marker in the same change.
- When the owner decides the behaviour is intended, the probe is rewritten to assert it
  and relabelled `[DECIDED KEY#N]` - which also stops a well-meaning "repair" later.
- Every `FINDING` probe appears in the gate record with its question or limit, so the
  count of expected failures is visible at a glance.

## Checking a probe is honest

- **Red first.** A `FIXED` probe is run against the unfixed code and fails for the reason
  its name gives. A probe that goes green because a test double changed its answer is not
  proof. A `FINDING` probe gets the same check on the code as it stands: it fails on its
  assertion, never on an error.
- **Mutation check where cheap.** Remove the barrier, run the probe, see it fail; put the
  barrier back.
- **Mutation is how G2 attacks a probe.** In a disposable copy of the code: the barrier
  removed (a `RESISTED` or `FIXED` probe must fail); another option of the question, or
  half of the recommended one, implemented (a `FINDING` probe must keep failing on its
  assertion, never turn red as if fixed). A probe that answers a mutation otherwise is a
  finding against the probe. A delta that changes only probes gets this attack too
  ([the skill](../SKILL.md#rework-deltas-and-the-score-chain)).
- **Reconcile counts.** The gate record states how many probes the file has and how many
  of each label; the runner's count must match.

## G4 - the owner's walk

The walk is the last gate: the owner sees the delivery as a user does.

**Before** - the agent prepares:

- the environment: the real application on a dev server, or a disposable instance when
  the walk could touch real data or an outbound provider
  ([`disposable-proof`](../../disposable-proof/SKILL.md));
- the walk script (below);
- for provoked failures, a local proxy in front of each service that can answer a gateway
  error or hang on demand, controlled by a small file the agent edits between steps
  (mode, path pattern, number of times). It answers the way the real front proxy would -
  including without cross-origin headers - so the walk sees what the browser really
  delivers to the application.

**During**:

- **The owner types the login.** The agent never handles the password.
- The agent may drive the browser after the login, read the page and record literal
  values; it never asserts a text it typed itself (engines and read-back rules:
  [`browser-verification`](../../browser-verification/SKILL.md)).
- Each observation is written with an id: `P-1 - after a gateway error on the list, the
  screen shows "No records found" (wrong: the list did not load)`.

**After**:

| Outcome | What happens |
|---|---|
| fixed | the fix is a delta: G1-G3 run again on it; the walk step is repeated |
| question | `P-n -> Q-<NS>n` for the owner; the work that depends on it waits |
| limit | recorded as negative knowledge with the reason |
| not reproduced | recorded with what was tried and how to capture it next time (for example, a build with source maps) |

### Walk script template

```markdown
## Walk - ORD partial refunds (environment: <dev | disposable instance>, build <hash>)
Owner logs in as: <role> (the owner types the password)

| # | Screen / act | Expected | Seen | P-id |
|---|---|---|---|---|
| 1 | Orders list -> order 1042 -> Refund | dialog with the reasons from the seed | | |
| 2 | Refund 30 of 100, reason Damaged | refund line, order balance 70 | | |
| 3 | Proxy: next POST /refunds -> gateway error | "result uncertain - check before retrying" | | |
| 4 | Proxy: list read hangs 70 s | list shows the network message and Retry | | |
| 5 | Log in as clerk without the permission | no Refund button; direct link refused | | |
```
