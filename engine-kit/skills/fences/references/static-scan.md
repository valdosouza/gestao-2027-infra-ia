# The static scan of a fence - rules and false negatives

**Scope**: method

Companion of [the fences skill](../SKILL.md), part 2. The scan is the part that sees code
changes; it is also the part most likely to be quietly blind. Every rule below exists
because a scan without it missed something real.

## Parse, never grep

| Language in the scan | Tool | Why not a regex |
|---|---|---|
| the server language | its compiler's AST (for TypeScript, the compiler API; for others, the language's own parser) | comments, strings, template literals and multi-line calls look like code to a regex |
| any other language (UI, scripts) | a tokenizer that knows its literals: plain, raw, triple-quoted, interpolated, nested comments | a comment marker inside a string, or `can(` mentioned in a text, fooled the first scanner |
| SQL inside code | the string literal from the AST, then a statement-level check of the write target | `UPDATE IGNORE`, `DELETE t FROM`, multi-table updates, qualified names and modifiers slipped past a pattern |

Comments are removed by the parser or tokenizer - never by a pattern that would also eat
`//` inside a string.

## What the scan resolves

- **The primitives**: the functions that consume the protected item (the guard, the
  "has permission" check, the button's `can`). The list of primitives is itself closed:
  a **new export** of the implementation file fails the scan until it is classified
  (primitive, helper, or not related).
- **Derived primitives**: a function that receives the protected value as a parameter and
  passes it to a primitive becomes a primitive itself, followed **by symbol** wherever it
  is imported - including through re-export barrels (`export * from`).
- **Values by lexical scope**: a constant counts only when it resolves, by scope, to the
  declaration in the list's module. Resolving by **name** read the wrong pair when a local
  constant had the same name.
- **Resolvers by symbol**: when a primitive takes a resolver (a function that picks the
  screen from the request), the scan accepts only the known resolver symbol, not any
  function with the right name.
- **The consumer's context**: in a UI, the screen a button belongs to - from the routing
  table of the module, and for a **shared component**, every screen that imports it
  (derived from the import graph; an exclusion with a reason subtracts a screen, never
  replaces the derived set).

## What fails the scan

1. a consumption whose item is not in the list;
2. a consumption with a consumer the list does not name ("the list says API only, the UI
   uses it too");
3. a list entry no code consumes;
4. a consumption the scan **cannot read** - a computed argument, a value from an unknown
   variable - reported as unreadable, never skipped;
5. the protected value used loose (the constant read outside a primitive);
6. a direct read of the protected store outside the registered files (for example SQL on
   the grants table), counted **per file** so a second query in a registered file is
   seen;
7. an indirect use the consumer allows - a method reference passed without a call
   (tear-off), a direct read of the state the primitive wraps;
8. an `absentBy` entry that gained a consumer;
9. an entry point (a mounted module, a route group) neither fenced nor a named exception;
   the scan counts the mount calls, so a new one cannot hide behind indentation or
   formatting.

## Proving the scan is not blind

- **Planted violations**: a fixture folder with one file per rule above, each containing
  exactly one violation; the test asserts that each one is reported.
- **Mutation**: remove one entry from the list and see the scan fail with the consumer
  named.
- **The live variant**: run the scan over the real tree of a sibling service that is known
  to consume the item and see the consumption found.

## False negatives found by the adversarial gate (neutralized)

The first version of one real fence passed its own tests and failed the gate with five
MEDIUM findings, all proven with a probe:

| Missed | Fix |
|---|---|
| a constant resolved by name read the wrong pair | resolve by lexical scope |
| a resolver accepted by name | accept the resolver by symbol |
| a method reference passed without a call (tear-off) in the UI | fail on tear-offs of the primitive |
| a comment marker inside a string hid the rest of the line | tokenizer that knows string literals |
| a registered file was allowed any number of direct queries | count queries per file |

The re-test then found one more: a derived primitive imported through a barrel disappeared
from the scan - fixed by following re-exports. Each became a `[FIXED MEDIUM]` probe of the
fence's own gate.

## What the scan does not chase

Record these in the fence's negative knowledge rather than growing the scanner forever:

- computed property access to a primitive (`obj['has' + 'Permission']`);
- an alias export over an unexported constant;
- a new wrapper around a reader inside a file that is already registered;
- consumption from repositories outside the scanned set.
