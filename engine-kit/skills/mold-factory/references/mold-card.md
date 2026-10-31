# Mold card - what a mold carries besides its code

**Scope**: method

Companion of [the mold-factory skill](../SKILL.md), section 3. A mold card is short: an
agent reads it with the mold's files open beside it. It lives next to the plan (the
front prompt or the plan artifact), never inside the code.

## Template

```markdown
## Mold <name> - <the axis of variation it covers>

Written by hand: <change id>, verified end to end <date> (<how: the real app, the real schema>).

### Files
| File | Holds |
|---|---|
| <path> | <what this file does in the piece> |

### Variation points (what an agent changes)
| Point | In the mold | How a piece changes it |
|---|---|---|
| <name of the piece> | <mold value> | <the rule: plural, casing, prefix> |
| <columns> | <the mold's column block> | <from the schema extract, in schema order> |

### Invariants (never changed by an agent)
- <the error envelope>
- <the order of the guards>
- <the transaction shape>
- <the test skeleton>

### Tests
| Mold test | Each piece has |
|---|---|
| <test> | <the equivalent, named the same way> |

### Known gaps
- <what the mold does not show; a piece that needs it raises a question>

### Corrections
| Date | Defect | Fixed in the mold | Pieces fixed |
|---|---|---|---|
```

## Example (fictional)

*Acme Orders* replaces the import side of its bridge service: ten endpoints receive the
legacy system's records (customers, suppliers, carriers, products, price lists, stock
moves, orders, invoices, payments, returns). The inventory finds two axes of variation:
a record that stands alone, and a header with a list of child lines. Two molds:
`customers` (standalone) and `orders` (header and lines). The `orders` card:

```markdown
## Mold orders - a header with child lines

Written by hand: CR-210, verified end to end 2026-03-02 (the legacy sender's test batch
against the staging schema).

### Files
| File | Holds |
|---|---|
| import/orders/contract | the accepted payload: header fields, a `lines` array |
| import/orders/handler | parse, validate, then one transaction: upsert the header, replace the lines |
| import/orders/store | the statements, columns from the schema extract only |
| import/orders/tests | accepted, rejected, replayed, parent missing |

### Variation points (what an agent changes)
| Point | In the mold | How a piece changes it |
|---|---|---|
| Piece name | `orders` | the plural of the record, lower case |
| Header columns | the `orders` block of the extract | the piece's own block, in schema order |
| Child list | `lines` -> `order_lines` | the piece's child table; a piece without one uses the `customers` mold |
| Parent reference | `customer_id` must already exist | each foreign key of the piece, same refusal |

### Invariants (never changed by an agent)
- The error envelope `{ error, code, fields[] }`; the codes from the shared code list.
- Validate everything before the transaction opens; one transaction per record.
- Replaying the same record is idempotent: an upsert by the legacy key, never a second row.
- A missing parent is refused with its own code, so the sender retries it on its next cycle.

### Tests
| Mold test | Each piece has |
|---|---|
| accepts a valid record | the same, with the piece's own minimal record |
| rejects a missing required field (code and field named) | the same, one per required column |
| replay changes nothing | the same |
| parent missing is refused with its code | one per foreign key |

### Known gaps
- No computed field: a piece that derives a value (a total) raises a question.
- No delete: the legacy sender never deletes; a piece whose legacy source does raises a question.

### Corrections
| Date | Defect | Fixed in the mold | Pieces fixed |
|---|---|---|---|
| 2026-03-04 | lines replaced outside the header's transaction | handler, one transaction | invoices, returns |
```

What the inventory also produced, before any agent ran: the legacy sender of `invoices`
reads a column the target schema does not have, and the one of `stock moves` ignores a
`NOT NULL` column - both recorded as schema findings and quoted in the two briefs.
