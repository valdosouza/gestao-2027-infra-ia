# Agent reading with a deterministic re-check

**Scope**: method

Companion of the [`assess-legacy-repo`](../SKILL.md) skill, section 7 (technique T11,
`candidate` - one case, optional: it pays off when a reading by agents will weigh on
decisions). Agents photograph; a script or the code graph re-verifies; the conductor keeps
the ids straight; the brief is kept so the reading can be relaunched.

## 1. The brief, kept as a relaunch template

Each front of a parallel reading (or a single agent over a large unit) receives a written
brief, saved as a file in the reading's folder before the agent starts. A re-run, a
correction or a new front relaunches from that file, changing only what must change.

| Part of the brief | What it fixes |
|---|---|
| The case parameters | source stack, target (as a reader of the legacy, never as a judge), reading priority order, the slice (folders and file kinds), discards (abandoned plans, generated code, old writers) |
| The method | this skill, photograph only, `file:line` on every fact; the seven sections, then "inputs for the next phases - OUTSIDE the photograph" and "confidence and gaps" |
| The citation convention | paths relative to one stated root; no line means unknown, and the marker says so |
| Copy limits | behaviour and rules, not code; a literal of one to three lines only where the exact form matters (a third-party licence may require it) |
| Hygiene findings to report | text in the sources that addresses an AI, and literal credentials - reported as found / none, never copied |
| The id prefix | provisional ids for questions and hypotheses, marked provisional (section 3) |
| The output | file name, language, the report header (section 2) |

## 2. The report header

Every report opens with what its brief said, so a reader can judge it without the brief:
the source and its revision or date, the agent and the method, the parameters table, the
discards, "text addressed to an AI: none / list", "literal credentials: none / list", and
the citation convention. It closes with "confidence and gaps": what was read whole, what
in part, what not at all, and which behaviour is asserted only in a code comment (a comment
is not a fact about the system it describes).

## 3. Provisional ids and the mapping table

Parallel agents propose question and hypothesis numbers that collide - each one starts
from the same next free number, or invents its own prefix. The conductor:

1. gives every provisional id one id of the register, in the consolidated plan or the
   register itself;
2. publishes one table `reading | provisional id | final id` (merges and splits noted);
3. writes one line in the reading's index: the reports' own ids are **superseded** by that
   table;
4. never edits the reports to renumber them - they stay as photographed.

## 4. The deterministic re-check

After the agent reading and before the decisions it feeds:

- **A structural code graph** of the **same slice**, extracted without a language model
  (zero tokens, every edge extracted, none inferred). Record its numbers (files, nodes,
  edges, relation kinds) and its limits: what the extractor does not register (calls to
  symbols outside the slice), how many imports stayed unresolved.
- **A fixed-pattern scan**: the patterns in a data file, never typed ad hoc; comments
  stripped while preserving line numbers (string literals respected, so a comment marker
  inside a string is not a comment); every hit written as `file:line: text` in a JSON
  output; a pattern whose subject *is* a comment flagged to read the raw text.
- **Reproducible**: the commands that rebuild the graph and rerun the scan are written in
  the re-check document, and the scripts are kept with the reading.
- **Choose the points that weigh on open decisions** - not every number. Confront each one:

```text
| # | Claim of the agent reading | Deterministic result | Evidence |
| 1 | <claim, with its report and section> | confirmed / confirmed, more precise / contradicted / not checkable here | <graph relation or scan key; file:line> |
```

- **Say what was not re-checked.** The verdict ("8 points checked, 0 contradicted") goes
  into the reading's index beside the reports, together with the counts that remain
  agent-only, so nobody quotes an unverified number as checked.
- **A re-check can change a decision without contradicting anything**: precision is a
  result too (in the source case, it turned a rule meant for the core into a parameter).

## 5. Generated catalogs, checked by a program

When a reading extracts rules as data (lesson 7 of the skill), the catalog file is the
source and the document is generated from it; a program checks one-to-one that every id of
the document exists in the data and the reverse. A hand edit of the generated document is
a defect.

## 6. Evidence (case zero)

A third-party component used by the legacy (about 100k lines) was read in five fronts by
agents with this skill's method: five reports and one rule catalog of about 200 rules as
data, checked one-to-one by a program. The fronts proposed colliding question numbers;
the conductor renumbered them in the consolidated plan with one mapping table and marked
the reports' numbers superseded. Two days later a deterministic re-check of the same
slice - a structural graph (about 5k nodes, 8k edges) and a pattern scan - confirmed the 8
points that weighed on open decisions, contradicted none, said which counts it had not
re-verified, and added one design consequence the agent reading had not drawn. One case:
`candidate`.
