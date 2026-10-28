# Architecture: three layers (method / runtime / case)

**Scope**: method
**Status**: decided — the July 2026 unification proposal, updated to the state decided in
the 0.7 consolidation (kit decisions EK#1, EK#2 and EK#3 in the kit's `DECISIONS.md`)
**Origin**: a structured comparison between this kit and the workspace of a mature case
(the one with the most AI tooling). Distilled insight — no case content travels in this
document.
**References**: [README](../README.md), [KNOWLEDGE-BASE-STRUCTURE](KNOWLEDGE-BASE-STRUCTURE.md),
[`scope-census`](../skills/scope-census/SKILL.md),
[`retain-knowledge`](../skills/retain-knowledge/SKILL.md),
[`memory-engineering`](../skills/memory-engineering/SKILL.md)

---

## The diagnosis in one sentence

A method kit on its own is a **paper operating system without a runtime** (strong method
and governance, zero executables); a mature case workspace on its own is a **powerful
runtime without an operating system** (concrete tooling, but no decision trail, no scope
census, and curated indexes drifting away from reality). Each one's disease is exactly
the remedy the other one carries.

## The three layers

```
Layer 1 — METHOD (neutral; travels between companies)
   scope census · decision rounds · conceptual guardian · knowledge retention
   · memory engineering · versioning security
        ↓ installs
Layer 2 — PORTABLE RUNTIME (inside the kit, in runtime/; case-neutral tooling)
   kit-lint · index/registry validation · memory index · skill sync
   · templates for the area (subject) model · skeleton agents
        ↓ instantiates
Layer 3 — CASE (the company's workspace; content that NEVER travels)
   domain docs, business decisions, integrations with the client's infrastructure
```

Unifying is not merging repositories of different cases — it is recognizing the roles
and keeping the middle layer that was missing. The flow between layers is **always
distillation, never copy**: nothing with a client or domain name rises from Layer 3.

## Where each layer lives (decided)

| Decision | What was decided | Why |
|---|---|---|
| **EK#1** — canonical home (revised by **EK#32**) | The kit lives in **one place owned by the method's author** - since EK#32 the `engine-kit/` folder of the author's workspace repository - and every case consumes it **as a plugin** (or a pinned clone); copies inside other case workspaces are never edited | All cases run the same version; where the method is hosted is the author's call (EK#32) |
| **EK#2** — language and token | The kit is written in **English**, with the grep-able token `**Scope**: method \| case \| mixed` (a case may write its own key instead of `case`) | The plugin ecosystem already speaks English; each case's own documents keep the case's language, and validators accept local-language aliases of the token |
| **EK#3** — runtime home | Layer 2 lives **inside the kit**, in `runtime/` (with `templates/`) — not in a sibling repository | One version, one installation. The layers stay separate as folders; what diverged before was precisely a pair of repositories with no common version |

The scope token, verbatim: `**Scope**: method | case | mixed`. Everything inside the kit
itself is `method`; a case classifies its own collection with the same token.

Target layout of the kit repository:

```
engine-kit/
├── .claude-plugin/          plugin manifest (one version, checked by kit-lint)
├── skills/<name>/SKILL.md   Layer 1: procedures
├── agents/<name>.md         Layer 1: judgment personas
├── docs/                    Layer 1: structure, architecture, installation
├── templates/               Layer 2: empty shapes a case fills in (rules file, decision log, area index, episodic log)
└── runtime/                 Layer 2: executable, case-neutral tooling
```

Layer 3 never enters the kit repository. Each case keeps its **leak deny-list** outside
the kit, because the list itself names clients; the kit ships only the scanner
([`runtime/kit_lint.py`](../runtime/kit_lint.py)).

## Flow between the layers

- **Down (1 + 2 → 3)**: the case installs the kit as a plugin and instantiates it —
  fills the templates, runs the runtime against its own knowledge base. The case never
  edits a private copy of the kit: a divergent copy is how the drift started.
- **Up (3 → 1 + 2)**: a method improvement discovered in a case comes back
  **distilled** (principle separated from instance, without the case's context), is
  recorded in the product journal ([`JOURNAL.md`](../JOURNAL.md)) and lands in the next
  kit version. When in doubt, it
  stays out.
- **Never**: case code, schemas, domain decisions, client names or machine paths in the
  kit. `kit-lint` checks this mechanically with each case's deny-list.

## What a mature case runtime gives to the method (distilled)

Patterns already operating in a case that proved their value and generalize:

1. **Area (subject) model** — one directory per business domain with a fixed structure
   (`INDEX / PIPELINES / SETTINGS / MEMORY`). It is the mature, operational version of
   the "project mirror" that [KNOWLEDGE-BASE-STRUCTURE](KNOWLEDGE-BASE-STRUCTURE.md)
   describes abstractly.
2. **Code graph in optional layers** — e.g., a graph of the base product, a graph of a
   client's customization, and the merged graph (the truth of what runs in
   production), rebuilt incrementally by AST hash. Usage rule: **query the graph before
   reading source** (context economy). The graph is a derived, rebuildable artifact —
   never the source of truth.
3. **Tool-agnostic rules file + thin adapters** — the rules live in a single
   tool-neutral document; each assistant or editor gets only a short adapter that
   points to it. Better than one monolithic rules file per tool.
4. **"Prepare-only" for irreversible operations** — agents prepare the
   commit / merge / deploy commands; the human runs them. It generalizes as a method
   rule: *the agent never executes the irreversible*.
5. **Feedback agent (self-improvement loop)** — an agent reads the typed claims of the
   sessions' memory logs (corrections, misses, wrong outputs, collisions), finds repeated
   patterns and proposes changes to the agents and skills themselves; a human approves.
   It is the executable form of the "retain -> distill into the product journal
   ([`JOURNAL.md`](../JOURNAL.md))" cycle.
6. **Authoring frameworks + sync with precedence** — "how to create an agent" / "how to
   create a skill" guides (the kit's own: [`AUTHORING.md`](AUTHORING.md)), a single subagent with write permission on the base (all
   others delegate), and a skill sync with precedence kit < project < case. The plugin
   is the primary distribution mechanism (EK#1); links are only for tools that cannot
   load plugins.

## What the method imposes on a case (and how it fixes the drift)

1. **Scope census** — run [`scope-census`](../skills/scope-census/SKILL.md) over the
   collection. Besides revealing the portable core (in the first census, ~40% —
   above intuition), its "programmatic verification by grep" generalizes to the real
   problem observed: **automatic index ↔ reality reconciliation** (curated indexes
   marking empty things as done, stale graph registries). A validation script is the
   marriage of the two cultures — it belongs to Layer 2, and `kit-lint` applies the
   same idea to the kit itself.
2. **Numbered decision rounds** — the workspace's architecture decisions recorded
   permanently and numbered ([`decision-rounds`](../skills/decision-rounds/SKILL.md)),
   giving a trail to the *why* of every tooling choice.
3. **Mandatory retention chain** — [`retain-knowledge`](../skills/retain-knowledge/SKILL.md)
   (index + rules + memory + SUPERSEDED, in the same task) becomes an instruction of
   every agent in the case. It is exactly the habit whose absence causes the drift.
4. **Conceptual guardian** — [`conceptual-guardian`](../skills/conceptual-guardian/SKILL.md)
   enters the change-analysis flow before any new modeling (the scale-model test, the
   triggering fact, and the occupied words).
5. **Nothing is blindly overwritten** — superseded docs are marked SUPERSEDED with a
   pointer, never edited in place.

A sensible adoption order in an existing case goes from least effort to most value:
census first (marking is cheap and makes every later separation a filter), then the
index validator, then the governance skills in the case's agents, then the runtime
from the kit, and finally a clean boundary between runtime artifacts (graphs,
dependencies, daemons) and knowledge artifacts.

## Still open

- **Feedback agent** — it ships as `design` until it produces its first real report in
  a case; it is to read the claims of the episodic logs, not free-text markers.
- **Central memory service and a multi-tool runner abstraction** — design notes only,
  no implementation.
- **Portability proof** — the architecture is only proven when a full cycle runs with
  the kit alone, in a project unrelated to the cases it was distilled from.
