# Authoring skills and agents

**Scope**: method

How to write a skill or an agent for this kit (technique **T62**, `operating`, core -
[maturity](MATURITY.md)): which of the two a piece of work should be, the sections each
one carries, the description rule, the folder layout, the size budget and the hygiene
rules. [`runtime/kit_lint.py`](../runtime/kit_lint.py) enforces the mechanical half
(checks 3 to 8); review enforces the rest. Distilled from case two's two framework guides
("how to create an agent", "how to create a skill": when to choose which, the front
matter, the role paragraph, the memory section, naming, a checklist, a 500-line limit) and
from the shape the kit's own skills and agents settled on in waves 1 and 2.

## 1. Agent, skill, runtime tool or template

| Write a... | When the work is... | It holds | In the kit |
|---|---|---|---|
| **agent** | judgment: calls that change with the situation and that no script can make - which mode, which verdict, when to stop, what to ask the owner | a role, triggers, inputs, a standing workflow with its stop conditions, outputs, memory, rules, the governance block | [`build-analyst`](../agents/build-analyst.md) decides which compiler warning is a finding |
| **skill** | a fixed procedure: the same sequence, rules and written lines every time, whoever runs it | the principle, the steps, the hard rules, anti-patterns, a checklist | [`test-gate`](../skills/test-gate/SKILL.md) |
| **runtime tool** | anything a program can do or check: count, compare, stage, generate, validate | a script in `runtime/<group>/` with a README, an example configuration and tests | [`runtime/testing/`](../runtime/testing/README.md) |
| **template** | a document shape a case fills in | placeholders, fill-in notes, the Scope line for the copy | [`AGENT.template.md`](../templates/AGENT.template.md) |

Four questions, in this order:

1. **Can a program do it or check it?** Then write the script; the skill names it and says
   what to do with its result. A rule that a script could check but nobody runs is drift
   waiting to happen.
2. **Are the steps the same every time?** Then it is a skill - even when an agent runs it.
3. **Must someone decide what the procedure cannot?** Then it is an agent, and the agent
   points at the skill for the procedure instead of copying it: two copies drift apart.
4. **Is it a document shape?** Then it is a template - in the skill's `templates/` when only
   that skill produces it, in the kit's `templates/` folder when several do.

Pairs in the kit: [`build-analyst`](../agents/build-analyst.md) with
[`runtime/build/`](../runtime/build/README.md);
[`ecosystem-curator`](../agents/ecosystem-curator.md) with the
[`abstraction-ladder`](../skills/abstraction-ladder/SKILL.md) skill and
[`runtime/ladder/`](../runtime/ladder/README.md); [`test-gate`](../skills/test-gate/SKILL.md)
with [`runtime/testing/`](../runtime/testing/README.md); this guide with check 8 of
[`kit_lint.py`](../runtime/kit_lint.py).

## 2. The description - paid in every session

The plugin loads the `name` and `description` of every skill and every agent into every
session, before any of them is used: that is the kit's **always-on cost**, and every new
description adds to it. At wave 4 it was about **3,700-3,800 tokens for 30 skills and 10
agents** (~3,689 by `kit_lint.py`, ~3,782 by `claude plugin details`); `kit_lint.py`
prints the current figure (check 8, characters / 4). It is one objective input for the
[adoption levels](ADOPTION-LEVELS.md).

A new or touched description:

- **starts with "Use when"**, followed by the situations and the words a person would type
  ("prepare the pack for CR-123", "is the suite green?");
- then at most one clause on what it does or never does, when that is what makes it safe
  to trigger ("Login is always a human step");
- stays around **300 characters** (about 75 tokens) or less: no history, no counts, no
  technique ids, no case names - those belong in the body.

```yaml
---
name: test-gate
description: Use when a plan or spec needs its Test plan (or exempt line), a test must fail red first, the suite runs before review, ...
---
```

`name` is the skill's folder name or the agent's file name without `.md` (lint checks 5
and 8). Older descriptions that do not start with "Use when" are rewritten when their file
is next touched, not in a sweep ([EK#18](../DECISIONS.md): `kit_lint.py` prints how many are
left, and the rule becomes a lint error when the count reaches zero): a new description changes when the piece triggers, which
is a behaviour change to try on a real request.

## 3. Required sections of a skill

The shape the kit's skills follow (see [`test-gate`](../skills/test-gate/SKILL.md) or
[`backport`](../skills/backport/SKILL.md)):

```markdown
---
name: <folder name>
description: Use when <the situations, the words people type> - <one clause>.
---

# Skill: <Name> (<the idea in a few words>)

**Scope**: method
**Maturity**: <proven | operating | candidate | design>
**When to use**: <the moments in the cycle; the questions people ask>
**Not for**: <neighbouring work, linked to the skill or agent that owns it>
**Real origin**: <the kind of case, anonymous; what happened; what corrected the rules>
**Parts**: <technique ids with their maturity, when the skill holds several>
**Works with**: <the skills before and after it, linked>
**Changelog**: <date> - <what changed and why>

---

## The principle
## 1. <first part of the procedure>
## 2. <...>
## Anti-patterns
## Checklist before the hand-off
```

| Element | Required | Checked by |
|---|---|---|
| Front matter: `name` = folder, `description` not empty | yes | lint 5 |
| Description starts with "Use when" | new and touched skills | review |
| First heading `# Skill: <Name> (<the idea>)` | yes | lint 8 |
| `**Scope**: method` and `**Maturity**:` in the header block (between the title and the first `## `) | yes | lint 4, 5, 8 |
| `**When to use**`, `**Not for**`, `**Real origin**` | yes | review |
| `**Parts**`, `**Works with**`, `**Detail**` / `**Templates**`, `**Hands off to**`, `**Changelog**` | when they apply | review |
| `## The principle`: the idea in a few lines, and the words the skill uses | yes | review |
| The procedure: one section per part, numbered, with its rules and its written lines | yes | review |
| `## Anti-patterns`: each one seen, with why it fails and what to do instead | yes | review |
| `## Checklist ...`: the last thing read before the hand-off | yes | review |
| At most 500 lines | yes | lint 5 |

A part that never ran in a real case says so in its own heading (for example "design,
never run"), not only in the label. The oldest skills (the git pack) predate this shape;
they take it when they are next rewritten.

## 4. Required sections of an agent

The shape of [`templates/AGENT.template.md`](../templates/AGENT.template.md):

```markdown
---
name: <file name without .md>
description: Use when <...>. <What it never does, when that makes it safe to trigger.>
tools: [<read, search, edit, terminal, task, browser, web, todo, memory>]
---

# <Title> - <its role in a few words>

**Scope**: method
**Maturity**: <label>
<one line on why, when the label is below operating>

## Role
## When to use
## Inputs
## Standing workflow
## Outputs
## Memory
## Rules (non-negotiable)
## Governance (mandatory, every task)
```

| Element | Required | Checked by |
|---|---|---|
| Front matter: `name` = file name, `description` not empty | yes | lint 8 |
| `tools:` in the neutral words; the stub generator maps them per editor (T91, [`runtime/adapters/`](../runtime/adapters/README.md)) | yes | review |
| The H1 title first; Scope and Maturity in the header block | yes | lint 4, 5, 8 |
| `## Role`: the job, the judgment the agent holds, the skill that holds its procedure | yes | review |
| `## When to use`: a trigger table with the words people say, and a "Not for" line | yes | review |
| `## Inputs` (each with "if missing"), `## Standing workflow` (recall first, stop conditions, verify before claiming, close), `## Outputs` (where, in which format) | yes | review |
| `## Memory`: the episodic log with claims ([`memory-engineering`](../skills/memory-engineering/SKILL.md)) | when it produces knowledge | review |
| `## Rules (non-negotiable)` or `## Never` | yes | review |
| `## Governance (mandatory, every task)` last, word for word from the template (T72); agent-specific rules go in a section above it, never into it | yes | lint 8 |
| At most 500 lines; a long fixed procedure moves to a skill | yes | lint 8 |

Case values - paths, servers, names, keys - never appear in an agent: they come from the
case's knowledge base (the projects registry, the document the agent works on) or, for a
client overlay, the client's notes file pointed to from `AGENTS.md` (T95).

## 5. Inside a skill folder

```text
skills/<name>/
  SKILL.md                        the entry: what a reader needs in order to act
  references/<topic>.md           detail: formats, long tables, recipes, the evidence
  templates/<NAME>.template.md    a document this skill produces
```

- `SKILL.md` keeps the rules and the sequence; detail needed at one step only moves to
  `references/`. Each reference opens with its title, its Scope line and a "Companion of
  the <skill> skill, section <...>" line, and is linked from `SKILL.md` - no orphans.
- A template in the kit carries `**Scope**: method` and tells the case to set its copy's
  own Scope line; placeholders are `<...>`; its fill-in note is deleted in the copy.
- Scripts never live in a skill folder: they go to `runtime/<group>/` with a README, an
  example configuration and tests ([`runtime/README.md`](../runtime/README.md)), and the
  skill links them.

## 6. Maturity

Every skill and agent declares one label right after its title, and below `operating` a
line says why ([MATURITY.md](MATURITY.md)). A skill whose parts differ lists them under
`**Parts**` with their labels. No silent upgrades: a label moves with a CHANGELOG entry
that names the new evidence, described anonymously.

## 7. Size, links, Scope, no case content

- **Size**: a `SKILL.md` or an agent stays under 500 lines (lint); any markdown file under
  60 KB (lint warns): move detail to `references/` and history to the CHANGELOG.
- **Links** are relative and resolve (lint 3). Never wrap a markdown link in a code span:
  it stops being a link and escapes the check. An example link that must not resolve goes
  in a fenced code block.
- **Scope**: every markdown file of the kit carries `**Scope**: method` right after its
  title (lint 4); templates carry the placeholder the case fills.
- **No case content**: no client, product, person, language or version line, path or
  machine name (lint 2, with each case's deny-list kept outside the kit). Evidence is
  described by the kind of case ("case zero - the modernization of a legacy business
  application", "case two - a multi-developer product team"); examples are fictional
  (ACME, orders, revisions `r100`, owners A and B).
- **Text**: English, ASCII punctuation (`-`, `->`), LF line endings.

## 8. Registering a new skill or agent

1. A row in [`techniques.csv`](techniques.csv) (`in-kit` or `partial`, the location is the
   folder or file), then `python runtime/coverage.py`: lint 7 fails until the piece is
   registered.
2. A row in the README's skills or agents table, and a CHANGELOG entry.
3. The catalog regenerated ([`runtime/ladder/`](../runtime/ladder/README.md)); the agent
   stubs checked with the stub generator's `--check`.
4. `python runtime/kit_lint.py --require-denylist --denylist <each case's list>` clean.
5. A method lesson learned while writing it goes to the [journal](../JOURNAL.md).
6. Its place in [ADOPTION-LEVELS.md](ADOPTION-LEVELS.md): one level, core or situational.

## Checklist before adding a skill or an agent

- [ ] It is the right kind (section 1): the judgment in an agent, the procedure in a skill, the checkable part in a script.
- [ ] The description starts with "Use when", uses the words people type, and stays around 300 characters.
- [ ] The required sections are there (section 3 or 4); an agent ends with the governance block, word for word.
- [ ] The maturity label matches the evidence; a part that never ran says so.
- [ ] Under 500 lines; detail in `references/`; document shapes in `templates/`; scripts in `runtime/`.
- [ ] Links resolve; the Scope line is there; no case content; fictional examples only.
- [ ] Registered (section 8); `kit_lint.py` clean.
