---
project: <KEY>
subject: <AREA>
rule: <slug>
last_updated: <YYYY-MM-DD>
decisions: [<n>, <n>]
work_items: [<id>]
tags:
  - rule
---
# Rule — <the behaviour, in one line a user would recognise>

**Scope**: <method|case|mixed>
**Governed by**: <KEY>#<n> (the project's decision that adopted rule files and the rule gate)
**Area**: <AREA> · pipeline or flow: <link to the map of the process this rule lives in>

> Template from the engine-kit (`templates/RULE.template.md`) — technique T24, *candidate*:
> optional, a project opts in by a decision in its own register. One business rule per
> file, at `RULES/RULE-<slug>.md` in its area. Replace every `<placeholder>` and delete
> this note. Method: the `decision-rounds` skill, section "Business rules and the rule gate".

## Current rule

<What holds today, in the words a user would use: what the user sees, what the screen,
report or import does, what is charged or paid. Every sentence cites the history row
that authorises it: "Authorised by row <n>.">

**Code state on <YYYY-MM-DD>**: <matches the rule | not yet in the code: row <n> waits
for <work item / change>>.

## Decision history (append only)

Never edit a row: a change is a new row, and a denied alternative is a row too — it is
what lets a regression be caught. Each `#` is a number of the `<KEY>` register, which keeps
a one-line row pointing here (cite it as `<KEY>#<n>`). **Decided by** is the name as the
source writes it; never infer a role.
**Evidence** says where the answer can be read again (work item, message, document,
commit) and quotes the decisive words.

| # | Date | Decided by | Decision | Status | Evidence |
|---|---|---|---|---|---|
| <n> | <YYYY-MM-DD> | <name as written in the source> | <the behaviour decided> | Authorised | <where>: "<the words>" |
| <n> | <YYYY-MM-DD> | <name as written in the source> | <the alternative refused> | **Denied** | <where>: "<the words>" |

The newest row about a behaviour wins. A Denied behaviour comes back only through a newer
Authorised row from the person who can decide it — for a user-visible rule, whoever owns
that behaviour.

## Regression guard

Stop and quote the row (number, date, who decided, evidence) when a plan, spec, test,
code change or review:

- <brings back the behaviour of Denied row <n>>;
- <reads <an ambiguous word or label> as <the denied meaning>> (row <n>).

Not a regression: <a nearby behaviour that looks like one, and why it is allowed>.

## Open questions

A question enters this table **the moment it is asked**, not when it is answered. While
it is open, nothing implements the open point. Answered, it becomes a history row and its
status points to that row.

| Q | Asked | Asked of | Question (evidence, options, recommendation) | Status |
|---|---|---|---|---|
| <Q-id> | <YYYY-MM-DD> | <the person who can decide> | <question> — (a) … (b) … Rec.: (a) | open |
| <Q-id> | <YYYY-MM-DD> | <the person who can decide> | <question> | answered → row <n> |

## Links

- Work items: <ids and links>
- Process map: <link>
- Related rules: <RULE-<slug>.md>
