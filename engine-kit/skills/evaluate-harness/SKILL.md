---
name: evaluate-harness
description: Use when a change to the harness (a skill, agent, prompt or hook) must be promoted or rejected by data rather than taste, through a trace per session, a composite score with named components, a Pareto front of quality against cost, and a human who approves. Design only - never run in a real case.
---

# Skill: Evaluate the harness (trace, score, Pareto front, a human promotes)

**Scope**: method
**Maturity**: design

> **Design - never run in a real case.** No trace, score or front described here has been
> produced yet. Use it as a proposal: the first case that runs it records what it
> measured and moves the label up ([maturity](../../docs/MATURITY.md)). The exit test is in
> [section 6](#6-exit-test-design---operating).

**When to use**: a proposed change to the harness - from the
[`feedback-analyst`](../../agents/feedback-analyst.md)'s report, a retrospective, or
someone's idea - would alter how the method works and should be judged on sessions, not
on how convincing it reads; two variants of a skill compete; someone asks "did that change
to the change gate make things better or only longer?". Also to prepare a case for its
first evaluation (section 5).
**Not for**: judging a delivery ([`delivery-gates`](../delivery-gates/SKILL.md)) or one
change's result ([`result-review`](../result-review/SKILL.md)); mining the logs for
corrections (the feedback analyst does, and feeds this skill); a wording fix that changes
no behaviour (a plain edit, approved as usual); and **never** an agent changing its own
harness - every promotion is a human's decision.
**Real origin**: case zero - the modernization of a legacy business application. Its
insight diary, entry of 2026-08-03, after reading an external open-source harness kit:
the engine had **retention** (logs, cards, consolidation) but **no self-evaluation**; the
tracer -> evaluator -> meta-harness loop - a trace per session, a composite score, a Pareto
front, a candidate promoted or rejected by data - was the missing method piece. The same
reading adopted the Socratic and adversarial gates at once
([`delivery-gates`](../delivery-gates/SKILL.md)); this loop was left for later and was
never built or run.
**Inspiration**: the loop's shape, as recorded in that diary entry from
[harness-kit](https://github.com/romabeckman/harness-kit) (MIT). The external kit was not
re-read for this version and nothing of its code or formats is copied: the trace, the
components and the rules below are this kit's own proposal.
**Parts**: T59 `design` ([register](../../docs/TECHNIQUES.md)).
**Works with**: [`feedback-analyst`](../../agents/feedback-analyst.md) (proposes the
candidates), [`delivery-gates`](../delivery-gates/SKILL.md) (its first-pass scores are a
component), [`memory-engineering`](../memory-engineering/SKILL.md) (episodic logs and
their corrections are trace sources), [`change-gate`](../change-gate/SKILL.md) and
[`test-gate`](../test-gate/SKILL.md) (their records are trace sources),
[`decision-rounds`](../decision-rounds/SKILL.md) (weights, verdicts and trade-offs are the
owner's numbered decisions), [`disposable-proof`](../disposable-proof/SKILL.md) (where a
replay runs), [`retain-knowledge`](../retain-knowledge/SKILL.md) (a rejected candidate is
negative knowledge), [MATURITY.md](../../docs/MATURITY.md) (the same honesty rules).
**Detail**: [trace and score](references/trace-and-score.md) (the trace fields, an
example, the components and their formulas) and
[front and promotion](references/front-and-promotion.md) (reading the front, a worked
example, the verdict record, the first run step by step).
**Changelog**: 2026-10-21 - first version (wave 3), a design from case zero's insight
diary.

---

## The principle

Retention says what the engine learned. It does not say whether the engine got better.
Every change to the harness is a hypothesis - "asking for the state map before the plan
cuts rework" - and a hypothesis is kept or dropped on data:

```
sessions --tracer--> traces --evaluator--> scores --meta--> front --> verdict proposal
   ^                                                                       |
   |______________ harness change, applied by the normal change cycle ____ human approves
```

| Role | Does | Never does |
|---|---|---|
| **Tracer** | writes one trace per session, mechanically, from records that already exist | asks the agent how it did; estimates a missing value |
| **Evaluator** | scores each trace by a formula fixed before the run | judges by reading the session's prose |
| **Meta step** | groups the scores by variant and task kind, draws the front, proposes a verdict by the rule | applies the change, or moves a weight after seeing results |
| **Human (the owner)** | approves or rejects the verdict, decides trade-offs, fixes weights | - |

Words used here: the **harness** is everything that shapes the agent's work in a case -
the kit's skills, agents, hooks and templates plus the case's own rules and prompts; the
**baseline** is the harness in force; a **candidate** is one named change to it with a
written hypothesis; a **variant** is the baseline or a candidate; a **task kind** is a
class of work compared only with itself (a bug fix, a change request, an analysis, a
report).

## 1. The trace - one per session, minimal

One JSON line per session in an append-only file of the case (for example
`<kb>/_EVAL/traces.jsonl`), outside the kit. Fields and an example:
[references/trace-and-score.md](references/trace-and-score.md#the-trace).

| Group | Fields |
|---|---|
| Identity | `session`, `date`, `task`, `kind`, `variant`, `harness` (the kit version plus the case layer's revision) |
| Outcome | `outcome`: delivered, partial, abandoned or blocked |
| Gates | what each gate recorded: the go logged before code, red first, evidence complete, retention done; the delivery gates' **first-pass** scores and HIGH count |
| Human load | `rework` (times a gate sent the work back), `corrections` (human corrections recorded in the work log or the episodic log) |
| Cost | `tokens` and `minutes` when the tool reports them - omitted, never estimated, when it does not |
| Pointers | `sources`: the work log, the episodic log, the gate record the line was built from |
| Late fields | `escaped`: defects found after the hand-over and traced to the session - written later as a **new line that cites the session**, never as an edit |

Rules: built from records, never from the agent's self-assessment; a value that is not
recorded stays absent; no code, data or client content - counts and pointers only; the
file is never rewritten.

## 2. The composite score - named components

Each component is a number from 0 to 1, higher is better. Formulas:
[references/trace-and-score.md](references/trace-and-score.md#the-components).

| Component | Name | From | Rewards |
|---|---|---|---|
| **G** | gate quality | the mean of the delivery gates' first-pass scores; capped at 0.5 when a HIGH or CRITICAL finding was open | work that passes review the first time |
| **R** | rework | `1 / (1 + rework)` | fewer returns from a gate |
| **H** | human load | `1 / (1 + corrections)` | fewer corrections by a person |
| **D** | discipline | the share of the applicable process checks that held | the method followed |
| **E** | escapes | 1 with none, 0.5 with one, 0 with two or more (late field) | fewer defects after the hand-over |

- **Quality Q** = the weighted mean of the components present in the trace. The weights
  are a **numbered decision of the owner, taken before the first candidate is scored**;
  the default proposal is equal weights. Changing a weight later is a new decision and
  rescores every variant.
- **Cost C** = tokens per session (minutes when tokens are unknown). **Cost is never
  folded into Q**: it is the second axis of the front, so that a trade-off stays visible.
- Two variants are compared only on the components **both** have, and only **within one
  task kind**.

## 3. The Pareto front - how to read it

Per task kind, each variant is one point: the **median Q** of its sessions (up is better)
against the **median C** (left is better), with its spread. On each axis the **noise
band** is the spread of the baseline's own sessions; a difference inside it counts as
equal. Variant A **dominates** B when A is at least as good on both axes and better on
one. The **front** is the set of variants no other variant dominates. Worked example:
[references/front-and-promotion.md](references/front-and-promotion.md#a-worked-example).

| What the front shows | Verdict proposed |
|---|---|
| The candidate dominates the baseline in every task kind it ran on | **promote** |
| The baseline dominates the candidate in any task kind | **reject** (unless the owner decides that task kind does not matter - a numbered decision) |
| Neither dominates: better Q for more cost, or cheaper for less Q | **trade-off** - a numbered question to the owner, with both numbers and the spread |
| The difference sits inside the noise band, or a variant has fewer sessions than the minimum | **no evidence** - keep collecting until the candidate's deadline, then **reject by default**: the harness does not change without evidence |

## 4. The promotion rule

1. **A human approves; never auto-promote.** The meta step writes a verdict proposal; the
   owner decides, and the decision is recorded as `KEY#N`
   ([`decision-rounds`](../decision-rounds/SKILL.md)).
2. **A promoted candidate enters by the normal change cycle**: a plan, the go, the change
   to the skill or agent, prepared commits that a person runs
   ([prepare-only](../change-gate/references/prepare-only.md)). The kit's CHANGELOG entry
   names the evidence anonymously ([MATURITY.md](../../docs/MATURITY.md)).
3. **A rejected candidate is kept with its data** as negative knowledge
   ([`retain-knowledge`](../retain-knowledge/SKILL.md)), so it is not proposed again
   unchanged.
4. **Evaluation never edits the harness.** Candidates live as files of their own (a
   description, the hypothesis, the diff, the task kinds, a deadline); a candidate that
   touches a hook or a guard is reviewed before any run, because hooks execute code.
5. **A promotion can be undone.** The live traces after a promotion keep being scored; a
   regression beyond the noise band is a demotion proposal, decided the same way.
6. **The evaluator is checked too.** For each variant, a person compares at least two
   traces with their sessions; a trace that does not match its session voids the run.

## 5. Data needed before the first run

| Need | Why | Comes from |
|---|---|---|
| The records the tracer reads exist and agree: go and rework rows, gate records with first-pass scores, episodic logs with corrections, test evidence | a trace is built from them | [`change-gate`](../change-gate/SKILL.md), [`delivery-gates`](../delivery-gates/SKILL.md), [`memory-engineering`](../memory-engineering/SKILL.md), [`test-gate`](../test-gate/SKILL.md) |
| Each session tagged with its task kind and its harness version | comparisons stay within a kind and a variant | the closing step |
| At least 10 baseline sessions of one task kind (proposal) | the noise band | the tracer, on past sessions |
| The weights and the minimum sessions per variant (proposal: 5) decided | no tuning after the fact | a numbered decision |
| A cost source, or the decision to run without cost | without cost the front has one axis and no trade-off can be seen | the tool's usage report |
| One candidate with a hypothesis, task kinds and a deadline | something to evaluate | the feedback analyst, a retrospective |
| For a replay: an evaluation set (past tasks with their input revision and accepted outcome) and a disposable environment | the same tasks under each variant | [`disposable-proof`](../disposable-proof/SKILL.md) |

## 6. Exit test (design -> operating)

The label moves up when one case has, with evidence: written traces for the baseline and
one real candidate, with no field estimated and a sample checked by hand; scored them by a
script or a logged calculation; drawn the front and proposed the verdict by the rule; had
the owner decide it as a numbered decision; and, one cycle later, checked that the
promoted candidate did not regress (or kept the rejected one with its data). What it
learned - which components discriminated, which were noise, how many sessions were really
needed - is written back here, and the CHANGELOG entry names it
([MATURITY.md](../../docs/MATURITY.md)). The first run, step by step:
[references/front-and-promotion.md](references/front-and-promotion.md#the-first-run).

## What the kit already has, and what this adds

| Kit piece | What it gives today | What evaluation adds |
|---|---|---|
| [`feedback-analyst`](../../agents/feedback-analyst.md) | mines the logs for corrections and proposes edits; a human approves on the strength of the cited log lines | after approval, a method-changing edit can run as a candidate first, and is kept or dropped on measured sessions |
| [`delivery-gates`](../delivery-gates/SKILL.md) (Socratic score, adversarial review) | a score per delivery, with anchors | component G, aggregated per variant; the first pass, not the re-score, because it measures what the harness produced |
| [`memory-engineering`](../memory-engineering/SKILL.md) | episodic logs with claims and corrections | the H component's source |
| [MATURITY.md](../../docs/MATURITY.md) and the [register](../../docs/TECHNIQUES.md) | labels move only with evidence | the evidence for a change of the harness itself, in numbers |
| [`retain-knowledge`](../retain-knowledge/SKILL.md) | what was learned is kept | what did **not** work is kept with its data |

## Anti-patterns

| Seen | Why it fails | Instead |
|---|---|---|
| Promoting automatically when the score rises | the harness rewrites itself without a person; a measuring error becomes the method | the owner decides each verdict |
| Choosing or moving the weights after seeing the results | any candidate can be made to win | weights decided before the first score; a change rescores all |
| The agent's own judgment of its session as a trace field | it grades its own homework | records only; absent stays absent |
| A verdict from one or two sessions | judgment scores are noisy | the minimum per variant; the noise band |
| Comparing across task kinds, or a hard week against an easy one | the task mix decides, not the variant | one task kind at a time; replay the same tasks |
| Cost folded into the composite | a cheap, worse variant hides behind a good average | cost is the second axis |
| Fewer corrections read as better | the person may simply have stopped correcting | the hand check of traces against sessions; G and E beside H |
| Code or client data in a trace | a trace travels further than the case | counts and pointers only |
