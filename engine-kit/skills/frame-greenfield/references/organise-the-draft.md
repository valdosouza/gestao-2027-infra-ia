# Organising a draft - a worked example

**Scope**: method

Companion of the [frame-greenfield skill](../SKILL.md), sections 1, 2, 3 and 6 (T17). Every
name is fictional: the acme product, a new module **Acme Subscriptions**, namespace `SUB`,
front file `prompts/prompt_subscriptions.md`.

## 1. The draft, frozen

The owner's notes, saved as received in `prompts/prompt_subscriptions-draft.md`. The line
numbers are the item ids; the file is never edited.

```text
 1  Subscriptions - notes for the new module
 2
 3  Customers choose a box and a frequency, monthly only.
 4  They pay by card when they subscribe.
 5  The box price is the catalog price minus 10%.
 6  They can pause.
 7  Weekly boxes for the premium customers.
 8  Every delivery creates an order like the shop does.
 9  Cancel anytime, but not after the box is packed.
10  Subscription fields: customer, box, frequency, start, customer, status.
11  Later: gift subscriptions.
12  The contract screen shows all the subscriptions of a customer.
```

What a first read finds: L3 and L7 disagree; L4 and L8 leave open when each delivery is
charged; L6 has two readings; L8 introduces a domain object (a delivery that is an order);
L10 lists a field twice; L11 is deferred; L12 uses a word the product already uses for
something else.

## 2. The organised draft (excerpt of the front prompt)

```markdown
## 4. Guardian opinion (2026-03-02 - integrated)

**Concept**: a subscription is a standing request for a box at a frequency; each delivery
is an order of the shop with a subscription branch - not a parallel "delivery" table.
**Piece or composition**: a piece (subscription) plus a branch of the order backbone.
**Reused**: the order backbone, the catalog price. **Left out**: gift subscriptions (L11).
**Names**: `subscription`; never "contract" - an occupied word (L12, Q-SUB4).

## 5. Design and waves (provisional - valid after Round 0)

### 5.1 Subscribing
- Customers choose a box and a frequency, monthly only (L3). (!) Q-SUB1
- They pay by card when they subscribe (L4). (!) Q-SUB2
- The box price is the catalog price minus 10% (L5).

### 5.2 Life of a subscription
- They can pause (L6). (!) Q-SUB3
- Every delivery creates an order like the shop does (L8) - see section 4.
- Cancel anytime, but not after the box is packed (L9).

### 5.3 Data
- Subscription fields: customer, box, frequency, start, status (L10; C1).
```

Section 2.1 of the same prompt lists the objective defect:

```markdown
- **C1 - `customer` is listed twice in L10.** A record has one customer; the second
  occurrence is a slip. Correction: kept once. Not a question.
```

and section 2.3 a fact only the owner has - asked beside the questions, with no options:

```markdown
- **R-SUB1** - On which day are the boxes packed today, and how many days before the
  delivery? Weighs on: L9 (no cancel after packing), Q-SUB3 (pause).
```

## 3. The Round 0 questions

```markdown
## 7. Questions - round 0 (open)

- **Q-SUB1 - Monthly only, or weekly boxes for premium customers?** Problem: L3 says
  "monthly only"; L7 offers weekly boxes to premium customers. Evidence: draft L3, L7.
  (a) monthly only in this phase, weekly boxes out of scope (Rec.); (b) monthly for all and
  weekly for premium from the start; (c) any frequency for everyone.
  **Rec.: (a)** - one frequency keeps the first wave's schedule and charging simple; (b)
  needs a premium rule the draft does not define.
- **Q-SUB2 - When is a delivery charged?** Problem: L4 charges at subscription; L8 creates
  an order per delivery. Evidence: L4, L8. (a) each delivery's order is charged when it is
  created (Rec.); (b) the whole period is charged at subscription.
  **Rec.: (a)** - the order already knows how to charge; (b) needs refunds on cancel (L9).
- **Q-SUB3 - What does "pause" do?** Problem: L6 has two readings. Evidence: L6. (a) skip
  the next delivery only (Rec.); (b) stop until the customer resumes; (c) both.
  **Rec.: (a)** - a bounded effect; (b) needs a rule for prices that change while paused.
- **Q-SUB4 - What is the screen of L12 called?** Problem: "contract" already names the
  customer's service agreement in this product (occupied words). Evidence: L12, the
  occupied-words table. (a) "Subscriptions" (Rec.); (b) "Contracts", with a distinct title.
  **Rec.: (a)** - a free word needs no condition; (b) is a condition to check forever.
```

## 4. The answer, recorded

The owner answers in the file, under each question. Recorded literally
([`decision-rounds`](../../decision-rounds/SKILL.md)):

```markdown
- **Q-SUB1 -> SUB#1 = (b)**, DIVERGED from the Rec. (a) (owner, 2026-03-03: "weekly for
  premium from day one - it is the reason for the module"). The premium rule is missing:
  -> Q-SUB5 (round 1).
- **Q-SUB2 -> SUB#2 = (a)** as recommended. **Q-SUB3 -> SUB#3 = (a)** as recommended.
- **Q-SUB4 -> SUB#4 = (a)** as recommended.
```

The marks in section 5 give way to the ids (`monthly or weekly (L3, L7; SUB#1)`), and the
divergence opens a new question instead of being smoothed over.

## 5. The disposition table (section 3 of the prompt)

After Round 0 and the first requirements run:

| Item | Starts with | Kind | Destination |
|---|---|---|---|
| L1 | "Subscriptions - notes" | heading | prompt 1 |
| L3 | "Customers choose a box" | contradicts L7 | SUB#1; FR01 |
| L4 | "They pay by card" | a choice (with L8) | SUB#2; FR03 |
| L5 | "The box price is" | clear | BR01 |
| L6 | "They can pause" | unclear | SUB#3; FR05, TC-B03 |
| L7 | "Weekly boxes" | contradicts L3 | SUB#1; Q-SUB5 |
| L8 | "Every delivery creates an order" | a domain object | prompt 4; FR04 |
| L9 | "Cancel anytime" | clear | BR02; TC-B02 |
| L10 | "Subscription fields" | objective defect | C1; prompt 5.3 |
| L11 | "Later: gift subscriptions" | deferred | out -> phase 2 |
| L12 | "The contract screen" | occupied word | SUB#4; FR06 |

Count for the State line: 11 items, 11 with a destination, 1 waiting for the owner (L7, via
Q-SUB5). The prompt cannot close until Q-SUB5 is answered and L7 points to its decision.

## 6. The naming sweep

SUB#4 names the screen "Subscriptions". The sweep searches the prompt, the requirements
annex and any seed for `contract` and `Contracts`: two hits in section 5 and one in FR06's
first wording are changed; one hit in section 6 ("never call it a contract") stays, on
purpose, and the sweep note says why.

## 7. When a draft arrives mid-front

A second draft from the owner is frozen as `prompt_subscriptions-draft-2.md`; its items are
`2:L1`...; they join the same disposition table. An item that repeats one of the first draft
points to it (`2:L4 = L6`); an item that contradicts a decision already taken becomes a
question that cites the decision - it never overwrites it silently.
