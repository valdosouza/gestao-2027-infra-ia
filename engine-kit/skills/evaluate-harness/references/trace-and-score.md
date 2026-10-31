# Trace and score (design)

**Scope**: method

Companion of [the evaluate-harness skill](../SKILL.md), sections 1 and 2. **Design - never
run in a real case**: every field, formula and number below is a proposal for the first
run to confirm or correct.

## The trace

One JSON object per line, one line per session, in an append-only file of the case (for
example `<kb>/_EVAL/traces.jsonl`). JSON lines because a trace is data, not a document:
it is aggregated by a script, never read as prose, and the file is never rewritten.

| Field | Type | Meaning | Taken from |
|---|---|---|---|
| `trace` | int | format version, `1` | - |
| `session` | text | unique id: the date and a short slug | the session record |
| `date` | date | the day the session ended | the session record |
| `task` | text | the work item or the front's wave | the work log |
| `kind` | text | the task kind, from a short fixed list the case keeps (`bug`, `change`, `analysis`, `report` ...) | tagged at closing |
| `variant` | text | `baseline` or the candidate id (`C-3`) | the harness in force for the session |
| `harness` | text | the kit version and the case layer's revision | the installed kit; the case's VCS |
| `outcome` | text | `delivered`, `partial`, `abandoned` or `blocked` | the closing record |
| `checks` | object | each applicable process check, `true` or `false`: `go_before_code`, `red_first`, `evidence_complete`, `retention_done`, `prepare_only_kept`; a check that did not apply is left out | the work log, the test evidence, the closing record |
| `gates` | object | `g1_first`, `g2_first` (the delivery gates' first-pass scores), `g2_high` (HIGH or CRITICAL findings open after the first pass) | the gate record |
| `rework` | int | times a gate sent the work back: a code-gate stop that forced a new plan, a test sent back to implementation, a delivery-gate score under its threshold, a review finding that reopened the change | the work log, the gate records |
| `corrections` | int | human corrections recorded during the session | the episodic log's claims, the work log |
| `cost` | object | `tokens`, `minutes` - each only when the tool reported it | the tool's usage report |
| `sources` | list | the records the line was built from (paths in the case) | - |

A **late field** is a new line that names the session:

| Field | Meaning |
|---|---|
| `late` | the field it adds: `escaped` |
| `session` | the session it belongs to |
| `date` | when it was found |
| `value` | for `escaped`: defects found after the hand-over and traced to the session, in a fixed period after it (proposal: 30 days) |
| `source` | the record that traced it (a result review, a bug linked to the change) |

Example (fictional):

```json
{"trace": 1, "session": "2026-11-04-refund-rounding", "date": "2026-11-04", "task": "ORD-101", "kind": "bug", "variant": "baseline", "harness": "kit 0.8.0 + case r5120", "outcome": "delivered", "checks": {"go_before_code": true, "red_first": true, "evidence_complete": true, "retention_done": false}, "gates": {"g1_first": 0.68, "g2_first": 0.74, "g2_high": 0}, "rework": 1, "corrections": 2, "cost": {"tokens": 182000, "minutes": 95}, "sources": ["TICKETS/ORD-101/WORKLOG.md", "SUBJECT/ORDERS/MEMORY/2026-11-04-refund-rounding.md"]}
{"trace": 1, "late": "escaped", "session": "2026-11-04-refund-rounding", "date": "2026-12-04", "value": 0, "source": "no defect linked in 30 days"}
```

Rules for the tracer:

- **Records only.** Every value comes from a record that existed before the trace was
  written. The agent's view of how the session went is not a field.
- **Absent, never estimated.** A gate that did not run, a cost the tool did not report, a
  check that did not apply: the field is left out, and the score uses what is there.
- **Counts and pointers only.** No code, no data, no client names, no quotes from the
  session: the file can be read by people who must not see the case.
- **Append-only.** A wrong line is corrected by a new line with the same `session` and a
  `supersedes: true` flag; the evaluator reads the newest.

## The components

Each component is a number from 0 to 1, higher is better, computed per trace.

| Component | Formula | Present when | Note |
|---|---|---|---|
| **G** gate quality | mean of `g1_first` and `g2_first` that are present; `min(that, 0.5)` when `g2_high > 0` | at least one delivery gate ran | the first pass, never the re-score: the re-score measures the rework, not what the harness produced |
| **R** rework | `1 / (1 + rework)` | always | 0 returns -> 1.0; 1 -> 0.5; 3 -> 0.25 |
| **H** human load | `1 / (1 + corrections)` | the session wrote an episodic log or a work log | read beside G and E: fewer corrections can also mean less attention |
| **D** discipline | checks that hold / checks that apply | at least one check applies | measures the method followed, not the result |
| **E** escapes | `1` with 0, `0.5` with 1, `0` with 2 or more | the late line exists (the period has passed) | until then the trace has no E, and comparisons that need E wait |

**Quality** `Q = sum(w_i * c_i) / sum(w_i)` over the components `c_i` present in the
trace, with the owner's weights `w_i` (proposal: all 1). Two variants are compared on the
components both have: when the baseline's traces have E and the candidate's do not yet,
E is left out of both, or the comparison waits.

**Cost** `C` = `tokens` when present, else `minutes`, never a mix within one comparison.
It is not part of Q.

Example, the trace above with equal weights: G = mean(0.68, 0.74) = 0.71; R = 1/2 = 0.50;
H = 1/3 = 0.33; D = 3/4 = 0.75; E = 1.00 (no defect in 30 days). Q = (0.71 + 0.50 + 0.33 +
0.75 + 1.00) / 5 = 0.66; C = 182 000 tokens.

## Per variant

For each variant and task kind: the number of sessions, the **median** Q and C, and the
**spread** (minimum and maximum; the interquartile range from 10 sessions up). Medians,
not means: one disastrous session should not decide a verdict, and one should not hide
either - the spread shows it.

The **noise band** of each axis is the baseline's own spread on that axis in that task
kind (proposal: the interquartile range, or half the range below 10 sessions). A
difference of medians inside the band counts as equal.
