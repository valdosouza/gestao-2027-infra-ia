# Maturity labels

**Scope**: method

Every skill and agent in the kit declares, right after its title, one line:

```
**Maturity**: proven | operating | candidate | design
```

`runtime/kit_lint.py` fails when the line is missing or carries another value
([EK#7](../DECISIONS.md)).

## The four labels

| Label | Meaning | Installed by default? |
|---|---|---|
| `proven` | Running in **two or more** real cases, with evidence in each | Yes |
| `operating` | Running in **one** real case with evidence, and chosen as core because the method needs it | Yes |
| `candidate` | Running in one real case with evidence, but optional: it fits some projects only | No — opt in |
| `design` | Described, never run in a real case | No — a proposal |

## Rules

- **No silent upgrades.** A label only moves up with a CHANGELOG entry that names the
  new evidence (anonymously: "a second legacy case, ~1k files", never a client's name).
- **Evidence is described, never imported.** The kit says *what kind of case* proved a
  technique and *what was measured*; the case's material stays in the case.
- **A label can go down.** When a case stops using a technique, or a later case refutes
  it, the entry is demoted the same way it was promoted, with the reason.
- **Design is honest, not shameful.** A `design` entry tells the reader it has never
  been run; it is how a good idea waits for its first case without pretending.
- **The rule of three cases.** A boundary drawn from one case is a guess. One case
  makes a technique `operating` or `candidate`; two make it `proven`; the third is what
  confirms that the abstraction, not just the technique, is right.
