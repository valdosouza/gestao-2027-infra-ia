---
project: <KEY>
subject: <AREA or the whole product>
last_updated: <YYYY-MM-DD>
tags:
  - glossary
  - occupied-words
---
# Occupied words - <product or area>

**Scope**: <method|case|mixed>
**Governed by**: the `conceptual-guardian` skill, section 4 (occupied words); a new sense
of a listed word is a decision of `<KEY>`'s register, never an edit.

> Template from the engine-kit (`templates/OCCUPIED_WORDS.template.md`) - technique T20.
> One table per product (or per area when the areas never share screens), kept in the
> knowledge base beside the area index, or at the project mirror while no area exists (at
> framing). A word already taken by a concept of the domain cannot name a new one: before
> naming a table, a column, a piece, a screen, a menu entry, a parameter or a status,
> search this table. Replace every `<placeholder>`, delete the
> fictional example rows and this note.

## How to read and keep it

- **Already means** lists every sense found, numbered, each with where it lives (a table, a
  piece, a screen, a document) - including senses that live only in comments. A sense the
  user can see is marked **visible**.
- **Use instead** says what a new, similar concept is called, or "say which" when the word
  must stay but never alone.
- A row is added when a concept is named **and** when a collision is found in code, screens
  or documents - most rows are born from a collision.
- A word may gain a sense only by a decision (`<KEY>#n`); when that decision keeps the word
  **on a condition** (a distinct title, a qualifier in every label), the condition is a
  delivery check with the decision's id (`conceptual-guardian`, section 6).
- A word decision with a condition ("never the word alone") taken when documents already
  exist is checked by a **sweep**, and the row keeps it in its "Decided by" cell:
  `check: <search pattern> (forms: <the forms it counts>); except quotations, file names,
  history lines, permanent registers`. The pattern covers the word's inflections in the
  artifact language - singular and plural, and masculine and feminine where the language
  inflects for gender - and the row lists which forms count. The exceptions are never
  rewritten; every other hit is; each delivery runs the same sweep and writes "0 outside the
  exceptions", or the hits left and why.
- Legacy names never become visible names; when the legacy word collides, the row says so.

## The table

| Word | Already means (sense -> where) | Visible? | If your new concept is similar | Decided by | Since |
|---|---|---|---|---|---|
| <word> | (1) <sense> -> <where>; (2) <sense> -> <where> | <(1) yes; (2) no> | <use `<other word>` \| say which: `<qualified name>` \| never use it> | <<KEY>#n \| found <YYYY-MM-DD>> | <YYYY-MM-DD> |
| contract | (1) the customer's service agreement -> `service_contract`, screen "Service contracts"; (2) an API contract -> comments only | (1) yes; (2) no | a recurring purchase is a `subscription`; an agreement with a third party is an `agreement`; a configured presumption is a `rule` | ACME#4 (kept on condition: the title reads "Service contracts") | 2026-03-03 |
| account | (1) a bank account -> `bank_account`; (2) the cash drawer -> `cash_drawer`; (3) a user's sign-in -> `user_login` | (1), (2), (3) yes | say which: never `account` alone in a name or a label | ACME#5 (check: `\baccounts?\b`, the word alone - `bank_account` does not match (forms: account, accounts); except quotations, file names, history lines, permanent registers) | 2026-02-11 |
| order | the backbone of every operation (sale, purchase, return) -> `orders` | yes | a new kind of operation is a branch `order_<kind>`, never a parallel table | ACME#2 | 2026-01-20 |
| key | (1) a primary key -> comments; (2) an integration's API key -> secret store; (3) a customer's licence key -> `licence.licence_key` | (3) yes | say which: `api_key`, `licence_key`; a secret never appears in a response | found 2026-04-02 | 2026-04-02 |

## Collisions found

| Date | Word | Where it collided | What was done |
|---|---|---|---|
| <YYYY-MM-DD> | <word> | <two screens side by side in a menu; a parameter that meant two things> | <renamed to ... (<KEY>#n) \| kept on condition ... (<KEY>#n, check: ...)> |
