# Patterns of the conceptual guardian - worked examples

**Scope**: method

Companion of the [conceptual-guardian skill](../SKILL.md), sections 5 and 6. The four
patterns case zero added to the seed inventory, and a decision with a condition, each with a
fictional example, its symptoms and what the verdict says. Fictional throughout: the acme
product - orders, service jobs, invoices, payment slips - with a bank and a carrier as
external parties; decisions in the namespace `ACME`.

## 1. Nature by presence x process by act

**The situation.** Orders are the backbone of every operation (backbone + branches). Some
orders include a service visit. Two different things live here:

| | Nature | Process |
|---|---|---|
| Says | what the order **is**: "it includes a service" | under which **cycle** the work is: opened, scheduled, done, cancelled |
| Exists | present or absent, from the order's creation | only once its act happened (a job was opened) |
| Written by | whoever creates the order | the jobs module, and only it |
| Piece | a branch `order_service`, sharing the order's id | its own table `service_job`, with its cycle |

**Symptoms that they were mixed** (a scale model):

- a column with several meanings from several producers - a `number` that is the job
  number when the jobs module writes it, an import id when the importer does, a free
  reference when a clerk does;
- an identity by absence - "an order is a plain sale because it has no job row";
- one status column on the branch that both the jobs module and the order screen update.

**Verdict.** Two pieces: the branch is nature (present or not, written once by the order's
producer); the job is process (born from its act, owned by one producer). A plain sale is
identified by what it is, never by the absence of another branch.

## 2. Third-party voice x our own effect

**The situation.** Acme presents payment slips to a bank (the same shape fits shipments to a
carrier or documents to a public authority):

- one slip x N **attempts** (`slip_presentation`: the slip, the attempt number, the
  environment frozen at the attempt);
- the bank's **voice** is an append-only event table (`presentation_event`): what the bank
  said - accepted, refused, cancelled - with its **source**: the response to our request,
  our query, or the bank's notification;
- the state of the exchange is **derived** from the last event - never a status column our
  code updates;
- presenting again is a **new attempt**, never an update of the previous one;
- **our own effect** - the receivable settled, the invoice marked cancelled - is applied by
  the composition, in a savepoint of the same transaction that records the voice, and never
  invented.

**Rules.**

- An event we write without a response is not voice: it is "in flight", or a failure by an
  explicit refusal. An unreadable success response is **ambiguous** - query again; never
  read it as an acceptance.
- A human decision about a third-party fact (keep an invoice whose document the authority
  cancelled; waive a charge the bank refused) is **our own fact** of the decided object -
  who, why, when - never a column on the third party's event.

**Symptoms.** A `status` column set by our code on a successful network call; a retry that
overwrites the previous attempt; a manual override written into the event table.

**Verdict.** Three pieces: the attempt, the voice (append-only, one producer: the third
party), our decision about it (its own fact). One composition applies our effect from the
voice.

## 3. Transaction-aware piece

**The rule.** A reusable rule that must run inside the caller's transaction - reserve stock,
take the next number of a series, apply the effect of a voice - receives the transaction (or
the connection) as its first argument and never opens, commits or rolls back one. It lives in
the shared code with the other pieces, so every caller runs it the same way.

```text
reserveStock(tx, orderId, lines)     called by the order service inside its own transaction
releaseStock(tx, orderId)            called by the cancel, inside the cancel's transaction
```

**Layers.** Business rules (not found, conflict) live in the service; the data layer raises
only what needs the transaction itself - a state lock ("the row changed under you").

**Symptom.** A shared function that commits: when the caller fails afterwards, half of the
work stays done.

## 4. Composition with one policy

**The rule.** A composition only combines pieces, and it is the home of a **policy that must
not fork between callers** - for example, the outcome a payment method gives a newly created
installment: settled at once under a standing agreement, or a payment slip issued
automatically. Every caller that creates installments goes through the composition, so the
policy is the same everywhere.

**Symptom of a wrong cut.** To fit a sibling, the composition needs a parameter such as
`blocks: true/false` or `mode`. In case zero, a sibling payment form that needed such a flag
was left out of the composition for that very reason.

**Verdict.** Leave the sibling out (its own composition), or find the concept that lets it
fit without a flag. Never add the flag.

## 5. A decision with a condition

**The decision**, in the home register:

```markdown
| 4 | 2026-03-03 | **Keep "contract" for the service agreement** - on condition that its screen title and menu entry read "Service contracts" | the word is visible since the first release; renaming means migrating every translation | |
```

**The check**, in the same round, as a success criterion of the prompt:

```markdown
7. The service agreement screen's title and its menu entry read "Service contracts"
   (ACME#4 condition) - proven by the browser check of the wave and the owner's walk.
```

**The occupied-words row** cites the decision
([template](../../../templates/OCCUPIED_WORDS.template.md)), and the next screen that wants
the word finds it taken.

**On a base already written**, the check is a sweep the word's row keeps. A decision
"never `account` alone" (ACME#5), taken when many documents already used the word:

```text
sweep    ACME#5 - pattern \baccounts?\b (forms: account, accounts) over the living documents
except   literal quotations, file and path names, history lines, permanent registers
result   0 outside the exceptions (3 inside: a quoted answer, a changelog line, a decision row)
```

The pattern covers every form of the word in the artifact language - here singular and
plural; in a language that inflects for gender, the feminine forms too (in a legacy exit
test, a quoted question brought in the feminine form of a decided word, which the decision
as written did not address), and the row says which forms count.

The three hits inside the exceptions stay as they are: rewriting a quotation falsifies it,
a renamed path breaks its links, and a history line or a register row records what was
true when it was written.

**What happens without the check** (case zero, anonymized): a decision kept a poor name in
exchange for a condition on the screen's label; the delivery never checked it; much later two
screens with the same word sat side by side in a menu, and the confusion was reported as if
it were a modelling error. The cheap half of the trade (keeping the name) was taken; the
expensive half (the distinct label) was never delivered.
