# Front and promotion (design)

**Scope**: method

Companion of [the evaluate-harness skill](../SKILL.md), sections 3 to 6. **Design - never
run in a real case.**

## The candidate file

One file per candidate in the case (for example `<kb>/_EVAL/candidates/C-3.md`), written
before any session runs under it:

```markdown
# C-3: the change gate asks for the state map before the plan

**Scope**: case
**Hypothesis**: bug fixes rework less when the plan starts from the state map.
**Change**: <the diff to the skill or agent, or a pointer to it>
**Task kinds**: bug
**Sessions**: at least 5 (decision <KEY#N>)
**Mode**: replay on the evaluation set, then live
**Deadline**: 2026-12-15 - without evidence by then, rejected by default
**Proposed by**: <the feedback report or the retrospective>
```

## Running the variants

| Mode | How | Good for | Limit |
|---|---|---|---|
| **Replay** (first) | the same past tasks - input revision, the task as it was given, the accepted outcome - run under each variant in a disposable copy ([`disposable-proof`](../../disposable-proof/SKILL.md)); the delivery gates run on each result; E is replaced by the result review's findings against the accepted outcome | a fair comparison: same tasks | costs a session per task per variant; old tasks may not resemble today's |
| **Live** (then) | real work under the candidate for a period or for alternate tasks | real conditions | the task mix differs from the baseline's; compare per task kind only |

A candidate that changes a gate is never promoted on live data alone: the gate it changes
is also the instrument that scores it. It needs a replay where the **unchanged** gates
score both variants.

## A worked example

Fictional, task kind `bug`, equal weights, cost in thousands of tokens, minimum 5 sessions
per variant:

| Variant | Sessions | Median Q | Spread of Q | Median C | Spread of C |
|---|---|---|---|---|---|
| baseline | 12 | 0.64 | 0.58 - 0.70 (IQR 0.06) | 180 | 150 - 230 (IQR 30) |
| C-3 (state map first) | 6 | 0.73 | 0.69 - 0.78 | 195 | 170 - 220 |
| C-4 (shorter plan template) | 6 | 0.56 | 0.50 - 0.61 | 120 | 110 - 140 |
| C-5 (a second reviewer) | 5 | 0.66 | 0.57 - 0.75 | 260 | 235 - 300 |
| C-6 (reworded checklist) | 3 | 0.70 | 0.66 - 0.72 | 175 | 160 - 190 |

```
Q
0.75 |                   * C-3
0.70 |               o C-6 (3 sessions, below the minimum)
0.65 |                * baseline       * C-5
0.60 |
0.55 |    * C-4
     +-----------------------------------------> C (k tokens)
          120         175 180 195     260
```

Reading it, with the noise bands of the baseline - 0.06 on Q, 30 on C:

- **C-3**: Q +0.09, beyond the band; C +15, inside the band, so equal. Better on one axis,
  equal on the other: it **dominates** the baseline -> **promote**.
- **C-4**: C -60, beyond the band, but Q -0.08, also beyond it. Cheaper and worse: neither
  dominates -> **trade-off**. The question to the owner: "C-4 cuts the tokens of a bug fix
  by a third and lowers Q from 0.64 to 0.56: promote?", with the spreads attached. A
  recommendation goes with it, as with every numbered question.
- **C-5**: Q +0.02, inside the band, so equal; C +80, beyond it. The baseline dominates
  it -> **reject**, kept with its data.
- **C-6**: 3 sessions, under the minimum -> **no evidence** yet, whatever its numbers
  look like; it keeps collecting until its deadline, then it is rejected by default.
- C-3 and C-4 are both on the front. Combining them is a **new candidate** with sessions of
  its own, never an assumption.

## The verdict record

```markdown
# Verdict: C-3 - the change gate asks for the state map before the plan

**Scope**: case
**Task kinds**: bug
**Sessions**: baseline 12, C-3 6 (replay on the evaluation set)
**Front**: baseline Q 0.64 C 180; C-3 Q 0.73 C 195; noise bands Q 0.06, C 30
**Proposed**: promote (better quality, cost inside the noise band)
**Hand check**: 2 traces per variant compared with their sessions - match
**Owner's decision**: <KEY#N, date, the words>
**Applied by**: <the change that carried it, the CHANGELOG entry>
**Recheck**: <date one cycle later> - live median Q <...>; regression: no
```

## The first run

1. **Tag** the last sessions of one task kind with their kind and harness version from the
   records; write the baseline traces (at least 10); check two by hand against their
   sessions.
2. **Decide** with the owner: the weights, the minimum sessions per variant, the noise
   rule, the cost source - one numbered decision, before any candidate is scored.
3. **Pick one candidate** with a hypothesis and a deadline - the clearest method change in
   the latest feedback report.
4. **Build the evaluation set** for a replay: at least 5 past tasks of that kind with
   their input revision and accepted outcome; prepare the disposable environment.
5. **Run** the candidate (replay first); write its traces the same way; check two by hand.
6. **Score, draw, propose**: the components, the medians and spreads, the front, the
   verdict by the rule - in a verdict record.
7. **The owner decides**; a promotion goes through the normal change cycle; a rejection is
   kept with its data.
8. **One cycle later**, recheck the live traces; then write back what was learned (which
   components discriminated, which were noise, the sessions actually needed) into the
   skill, and record the evidence for the label in the CHANGELOG
   ([MATURITY.md](../../../docs/MATURITY.md)).

What the first run is expected to find out, and must record either way: whether the
records are complete enough to build traces without estimating; whether 5 sessions per
variant separate anything from the noise; whether H moves independently of G and E;
whether cost is reported reliably enough to be an axis.
