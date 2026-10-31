# Validation, message and decision (T19 - candidate)

**Scope**: method

Companion of the [frame-greenfield skill](../SKILL.md), section 5. A **product pattern** for
anything with screens and an API: three different jobs that products tend to mix, kept
apart, with one error envelope and one catalog of codes.

Maturity: `candidate` - case zero (a new product built during the modernization of a legacy
business application) framed it as a framework of its own, settled it in one round of eight
owner decisions and applied it to every screen and endpoint. One case, optional: a product
adopts it by a decision in its own register; without that decision this page is advice.

## The three jobs

| Job | What it does | Never |
|---|---|---|
| **Validation** | judges data against a **rule** and says which rule failed, on which field | talks to the user directly |
| **Message** | communicates an **outcome** - success, a rule failed, an unexpected error; the channel follows the severity, chosen in **one** place | decides anything; is built by hand in a screen |
| **Decision** | **asks** and returns a **typed choice** (`yes`, `no`, `cancel`) | returns free text or a boolean that hides a third answer |

A screen never speaks on its own: every piece of feedback goes through one bridge, and the
bridge chooses the channel. That is what makes "one change of channel" a one-file change.

## The pieces (built once, reused, never recreated)

| Piece | What it is |
|---|---|
| The error envelope | every rejection has the same shape: `{error, code, ref, fields[]}` |
| The catalog of error codes | the **source** of every known code (code, status, message key, the rule it enforces); the table of codes in the documentation is **generated** from it, never written by hand |
| The technical trail | an unexpected error is logged with a reference; the user sees the reference, never the stack |
| Shared rules | the same validation rules on both sides of the wire, plus a field catalog per screen (required, kind, mask) |
| The presenter | one way to show a message by kind and one way to ask a decision |
| The bridge | the only path from a screen to the presenter |

The envelope:

| Field | Holds | When |
|---|---|---|
| `error` | the message for the user, already in the user's language | always |
| `code` | a stable code from the catalog (`QTY_EXCEEDS_STOCK`) | every known error |
| `ref` | the reference of the technical trail | unexpected errors |
| `fields[]` | `{path, message}` per field: the path exactly as the client sent it (`items[0].quantity`) | every error about a field, a duplicate included |

```json
{ "error": "Quantity exceeds the units in stock", "code": "QTY_EXCEEDS_STOCK", "ref": null,
  "fields": [ { "path": "items[0].quantity", "message": "Only 6 units in stock" } ] }
```

## Server side - checklist

- [ ] Every rejection goes through one error type (status, message, optional fields and
      code) and one central handler - never an error response written by hand.
- [ ] A known error carries a code from the catalog; a new code is added to the catalog in
      the same commit as the code that raises it, and the generated table is rebuilt at
      delivery.
- [ ] An error about a field always carries `fields[]` - including a duplicate conflict.
- [ ] The schema library's generic messages are set once, globally, in the product's
      language; a rule of the domain writes its own message.
- [ ] Business rules live in the service layer (not found, conflict); the data layer raises
      only what needs the transaction itself (the row changed under you).
- [ ] An unexpected error is never handled by hand: the central handler creates the `ref`
      and writes the trail.
- [ ] Required fields the client configures per screen are checked by the service from the
      same field catalog the screen reads.

## Client side - checklist

- [ ] No screen calls a notice, toast or dialog widget directly; all feedback goes through
      the bridge (success, failure, validation, decision).
- [ ] The channel per severity is a product decision taken once (for example: success as a
      transient notice; a failed rule or an error as a dialog with OK) - and then nowhere
      else.
- [ ] **One pending item at a time**: the first problem opens the dialog and the focus goes
      to its field; never a whole screen painted red.
- [ ] A decision is typed (yes, no, cancel); **cancel is always offered when yes and no lead
      to different actions** ("Save before leaving? Yes saves, No discards, Cancel stays").
- [ ] Each entry of `fields[]` is anchored to its field - matched by the exact path, else by
      its last segment for nested objects; with no anchor, show the field name and the
      message, never only the generic text.
- [ ] Texts come from the translation keys; a server message passes through intact.
- [ ] Forms are built from the field catalog and the shared rules; a process screen
      validates its action dialogs with the same rules.

## Catalog first

A new screen is born in this order, and nothing is born in a developer's head:

1. the **field catalog** rows of the screen (required, kind, mask);
2. the **server-side schema** of the endpoint (the technical baseline);
3. only then the **screen**, whose validators are read from the catalog.

The two sources of validation are the field catalog and the server schema; the error codes
come from the code catalog. This is the same idea as "rules as data"
([`assess-legacy-repo`](../../assess-legacy-repo/SKILL.md), T15): the catalog is the source,
documents and tables are generated from it.

## In the framing

| Where | What T19 adds |
|---|---|
| Round 0 | the adoption decision (`SUB#n`), and the product's channel per severity as one decided table |
| Requirements | each business rule names what happens on a violation and its code (`BR02 -> CANCEL_AFTER_PACKED`); NFRs for the channel per severity and one pending item at a time; negative scenarios assert the code and `fields[]`, not a wording |
| Contract | the envelope is part of the contract written before the code ([`change-gate`](../../change-gate/SKILL.md), contract first) |
| Delivery | one row per screen in a **conformance matrix** (below); the review asks "a code from the catalog, or a bare message?" ([`delivery-gates`](../../delivery-gates/SKILL.md), Socratic review) |

The conformance matrix, attached to the delivery record:

| Screen | Bridge only | Catalog validators | One pending | `fields[]` anchored | Typed decision | Translated | No direct feedback | Status |
|---|---|---|---|---|---|---|---|---|
| Subscriptions list | yes | yes | yes | yes | n/a | yes | yes | conform |

## Anti-patterns

- **A screen that speaks on its own** - one direct notice call, and the product has two
  channel policies. Route it through the bridge.
- **A bare message for a known error** - the client cannot react to text, and the wording
  becomes an interface. Give it a code from the catalog.
- **A hand-written table of codes** - two sources of the same list drift apart. Generate it
  from the catalog.
- **A whole form in red** - the user does not know where to start. One pending item, focused.
- **A yes/no question with three outcomes** - the third one is decided by whoever wrote the
  dialog. Type the decision and offer cancel.
