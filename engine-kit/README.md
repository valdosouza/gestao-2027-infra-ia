# ⚙️ Engine Kit — Legacy Modernization Engine (Portability Kit)

**Version**: 0.3 (2026-07-28) — English edition + Claude Code plugin format
**Scope**: method
**Origin**: `Infra-IA/prompts/rascunho_engine_modernizacao.md` (product journal) — this kit is the materialization of the `mixed`/`method` queue from the 2026-07-19 scope census
**Canonical home**: PROVISIONALLY here; the definitive home (a neutral vault, outside any company workspace) will be decided in the product's IP round

---

## What this kit is

The minimal, **portable** core of the legacy modernization method: the documents that
can be installed in any new company/case WITHOUT carrying content from any previous
case. Everything here is `scope: method` — neutralized, with no domain names, tables,
or stack from any client.

**The engine in one sentence**: assess the legacy repository → distill the business
concepts out of the old system's shell → guide the business owner through recorded
decision rounds → rewrite in composable pieces → retain every lesson in the knowledge
base.

> The engine keeps a **human-in-command** loop: the AI organizes, evidences, and
> suggests; the business owner decides; every decision becomes a permanent, numbered
> record traceable down to the line of code.

## 🛠️ Skills (`skills/`)

Each skill follows the Claude Code plugin format (`skills/<name>/SKILL.md` with
frontmatter), so it can auto-trigger in Claude Code — and still works as a plain
prompt in any other tool.

| Skill | Phase | Core function |
|---|---|---|
| [`assess-legacy-repo`](skills/assess-legacy-repo/SKILL.md) | Phase 1 | Faithful assessment of the legacy system (inventory, source-to-target mapping, pending items; in large repos: index before reading) |
| [`conceptual-guardian`](skills/conceptual-guardian/SKILL.md) | Phase 2 | Distill concepts: lego pieces, not scale models (the scale-model test / triggering fact) |
| [`decision-rounds`](skills/decision-rounds/SKILL.md) | Phase 3 | The business owner decides; decisions are numbered, permanent, traceable in the code |
| [`retain-knowledge`](skills/retain-knowledge/SKILL.md) | Continuous cycle | What to retain, where, and the mandatory update chain |
| [`scope-census`](skills/scope-census/SKILL.md) | Governance | Classify the entire collection (`method × <case> × mixed`) in parallel, with verification |
| [`git-security`](skills/git-security/SKILL.md) | Hygiene | Versioning hygiene and secrets protection (critical in legacy systems: assume a hardcoded credential until proven otherwise) — deep guides in [`references/`](skills/git-security/references/) |
| [`git-setup`](skills/git-setup/SKILL.md) | Hygiene | Safe initial git setup for a repository |
| [`git-commit-push`](skills/git-commit-push/SKILL.md) | Hygiene | Commit + push with the security checklist |
| [`git-push`](skills/git-push/SKILL.md) | Hygiene | Push with the pre-flight security check |

## 🤖 Agents (`agents/`)

| Agent | Role | Focus |
|---|---|---|
| [`legacy-analyst`](agents/legacy-analyst.md) | Phase 1 analyst | Reads legacy source and documents faithfully — never infers, never suggests improvements (photography, not renovation) |

## 📚 Docs

| File | Role in the engine |
|---|---|
| [`INSTALLATION.md`](INSTALLATION.md) | Executable step-by-step installation in a new case (Day 1 / Day 2+ / what to never do) |
| [`docs/KNOWLEDGE-BASE-STRUCTURE.md`](docs/KNOWLEDGE-BASE-STRUCTURE.md) | Phase 0 — building the "vessel": a governed knowledge base (root rules, index with history, project↔knowledge symmetry) |

## How to install in a new case

**Follow [`INSTALLATION.md`](INSTALLATION.md)** — an executable step-by-step (commands,
order, checklists): Day 1 builds the vessel (knowledge base + rules + index +
connection to existing tools + census of the collection), Day 2+ plugs the engine into
the legacy system (size → pilot unit → first full cycle
assess→conceptualize→decide→retain). Success criterion: ONE full cycle run on a pilot
unit, everything recorded in the base.

In Claude Code, the kit can also be installed as a plugin (it carries a
`.claude-plugin/plugin.json` manifest), so the skills auto-trigger by description.

## Complementary tooling

For the **rewrite** phase (composable pieces → code), this kit pairs well with
[harness-kit](https://github.com/romabeckman/harness-kit): engine-kit defines *what to
build and who decides* (assessment, concepts, decision records); harness-kit supplies
the *execution discipline* (autonomous TDD loop, Socratic code review, feature state
machine). Consume it as an installed plugin — do not merge its code into this kit.

## Multi-case hygiene rules (inviolable)

- **Case content NEVER crosses companies.** Code, DDL, domain decisions, client names:
  none of it enters the kit or travels between cases. Only the METHOD travels.
- **The kit only receives `method` material** (or `mixed` already distilled —
  principle separated from instance). When in doubt, it stays out.
- **Method improvements discovered in a case** come back to the kit DISTILLED (without
  the case's context) and are recorded in the product journal.
- The product owner's decisions are never lost: recorded, numbered, with the why.

## Kit versioning

Every evolution: a new row in the table below + update the **Version** at the top.

| Version | Date | What |
|---|---|---|
| 0.1 | 2026-07-19 | Initial kit extracted from case zero: 5 skills + knowledge-base skeleton + git security package (11 neutralized docs) |
| 0.2 | 2026-07-19 | `INSTALACAO.md` created (owner feedback: "how to install" was not executable) — Day 1/Day 2+ step-by-step with commands, connection to existing tools, pilot unit, and "what to never do" |
| 0.3 | 2026-07-28 | English edition + Claude Code plugin format adopted from harness-kit best practices: `.claude-plugin/plugin.json` manifest, `skills/<name>/SKILL.md` with auto-trigger frontmatter, `agents/` personas, git security package converted to skills with a `references/` folder |
