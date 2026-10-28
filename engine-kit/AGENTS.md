# Engine Kit - rules for whoever edits the kit

**Scope**: method

Read by every tool that loads `AGENTS.md`, every session. These rules are for a person or an
agent changing the KIT itself. Installing the kit in a case is [INSTALLATION.md](INSTALLATION.md);
a case's own rules live in that case, never here.

## What may enter

- **Method only.** Every file is `**Scope**: method`, right after its title (templates carry
  the placeholder the case fills). No case content: no company, product, customer, person,
  path, machine, case version line, or language, compiler, database or regime tied to a
  case. Examples are fictional (acme, orders); evidence is described by the kind of case
  ("case zero - the modernization of a legacy business application").
- **Each case's deny-list stays outside the kit** - the list itself names clients. Never
  print, copy or quote its contents; when the lint reports a leak, rephrase the text.
- **English**, ASCII punctuation (`-`, `->`, `...`). New files LF; an old file that is CRLF
  in the working copy keeps CRLF when edited (git normalizes on commit).
- Origin material (a case's base, prompts, old copies of the kit) is read-only. Never edit
  a copy marked SUPERSEDED, and never edit the kit from a copy inside a case
  ([EK#1](DECISIONS.md)): improvements come here, distilled.

## How to change it

- New or rewritten skill or agent: [docs/AUTHORING.md](docs/AUTHORING.md) (judgment vs
  procedure vs script, the "Use when" description, the required sections, the governance
  block word for word, under 500 lines). Maturity per [docs/MATURITY.md](docs/MATURITY.md),
  never upgraded silently. Its level: [docs/ADOPTION-LEVELS.md](docs/ADOPTION-LEVELS.md); then `python runtime/levels.py --write`.
- Every technique is a row of the register [docs/techniques.csv](docs/techniques.csv); after
  editing it run `python runtime/coverage.py`.
- Decisions about the kit are `EK#N` in [DECISIONS.md](DECISIONS.md) (the `decision-rounds`
  format: numbered, permanent, never renumbered; the owner decides).
- Every change gets a [CHANGELOG.md](CHANGELOG.md) entry; a method insight gets one line in
  [JOURNAL.md](JOURNAL.md) in the same session (append-only). A journal line's last column
  names where it landed only after the text is in that file (with the commit or tag);
  until then it stays `open`.
- An entry that changes a rule adopters copy into their own `AGENTS.md` (gate sentences, the
  adoption line, where files live, the release word) lists it under **Adopters: re-check**,
  so a case on an older tag knows what to update. An entry that reshapes what a case keeps
  in its own files (an open round, gate probes, a closing draft, an approved Test plan, the
  files of a prepared change, a register's row rule) adds a second list, **Case files to
  reshape**.
- A release moves the version in `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`,
  the README's **Version** line and the first CHANGELOG entry together.

## Before every commit

```text
python runtime/kit_lint.py --require-denylist --denylist <case-a.txt> --denylist <case-b.txt>
claude plugin validate --strict .claude-plugin/marketplace.json
claude plugin validate --strict skills
claude plugin validate --strict agents
```

The lint runs with every case's deny-list and must end with 0 errors. Commits, pushes,
merges, tags and releases are **prepare-only**: the exact commands are prepared, a human
runs them.
