# The consolidation cycle - worksheet, records and a worked example

**Scope**: method

Detail of section 5 of [`memory-engineering`](../SKILL.md). The cycle itself - trigger,
steps, rules - is there; this page holds what a cycle fills in and writes.

## The cross-log worksheet (step 2)

Kept in the agent's working context, never saved as a document of its own: its results
land in the owning artifacts (step 3). One row per claim theme, across every log of the
cycle.

| Theme / entity | Logs (claim n) | Status across the logs | Verdict | Target |
|---|---|---|---|---|
| <what the claims are about> | <log, claim n; log, claim n> | <fact 0.9 in two logs / hypothesis refuted / fact vs fact> | survivor / pattern / chain end / dead end / contradiction / open | card new or K-... / INDEX section / skill / journal / stays in the log |

Reading the verdicts:

- **Survivor** - a fact no later log contradicts. Rule-shaped and at 0.8 or more: a card
  candidate. Otherwise it stays in its log; the log is still searchable.
- **Pattern** - true in two or more logs. Two independent sessions that went back to the
  primary evidence are also the two confirmations that raise a card to 0.95.
- **Chain end** - the last link of hypothesis -> refuted -> replaced by. Only the end is
  promoted; the earlier links stay in their logs.
- **Dead end** - a refuted link worth never re-entering: it goes to Known dead ends with
  its refuting evidence, or into the Anti-patch of the card it belongs to.
- **Contradiction** - two facts that cannot both hold. Look for the time (a revision in
  between) or the scope (one client, one version) that separates them. Found: both stay,
  each with its note. Not found: an open question, and neither side is promoted.
- **Open** - an open question of any log that no later log answered.

## What the cycle writes into the area's INDEX

Four sections, created the first time a cycle needs them. Every entry links back to its
source logs.

```markdown
## Consolidated knowledge

- K-20260115-1432 - Invoice totals round once per invoice, never per line (<link to the card>)
- Totals are computed on save, not by the nightly job; the nightly job only re-exports
  them. Sources: <log 2026-01-10>, <log 2026-01-14>.

## Known dead ends

- Rounding each line before the sum (true through r811 only) - refuted by <log 2026-01-12>
  claim 2; see K-20260115-1432.

## Open questions

- Do credit notes round per line? Hypothesis 0.4 in <log 2026-01-10>; nobody has read the
  credit-note path yet.

## Consolidation cycles

| Date | Logs absorbed | Artifacts touched |
|---|---|---|
| 2026-01-16 | 5 (<the five log names>) -> `consolidated: true` | K-20260115-1432 written (supersedes K-20251201-0900); K-20260110-0700 checked, left unchanged; Consolidated knowledge, Known dead ends, Open questions |
```

The links follow the base's link style. A Consolidated knowledge entry that later proves
wrong keeps its place with a `SUPERSEDED` note pointing at the log with the new evidence;
a card is superseded by a new card ([`archive-card`](../../archive-card/SKILL.md)).

## Lazy migration of a pre-schema log

A log without front matter counts as unconsolidated. The cycle that absorbs it adds the
front matter first and changes nothing in its body:

```yaml
---
subject: BILLING
entities: [InvoiceTotals]
claims:
  - claim: "Totals were off by one cent on long invoices"
    status: fact
    confidence: 0.8
    evidence: "body of this log, line 3 (migrated in the cycle of 2026-01-16)"
outcome: analyzed
consolidated: true
---
```

Only what the body states becomes a claim. What the body only suspects becomes an
inference or a hypothesis. When the body names no evidence, the confidence stays below
0.8 and nothing from it becomes a card.

## Worked example (fictional)

Area BILLING. The build flags it: five unconsolidated logs.

1. **Inventory** - `query --subject BILLING --unconsolidated` lists four logs with claims
   and one pre-schema log. Live cards: K-20251201-0900 (lines round one by one, then the
   sum) and K-20260110-0700 (the tax rate comes from the order date).
2. **Cross-log view**:
   - three logs state, as a fact at 0.9 with the code read at r812, that totals round once
     per invoice. Pattern and survivor, and it contradicts K-20251201-0900. The
     separating time is r812, so the old card was right through r811;
   - one log held "the rounding happens in the export" as a hypothesis, and the next log
     refuted it. That is a chain: its end is the survivor above, and the refuted link is a
     dead end;
   - a typed claim (`correction`, agent `pipeline-mapper`) says the process map named the
     wrong trigger. It survives as a fact about the system (the INDEX narrative), and it
     stays a typed claim for the feedback analyst;
   - "credit notes may round per line" - hypothesis 0.4, open.
3. **Targets** - a new card that supersedes K-20251201-0900; the trigger fact into
   Consolidated knowledge and into the pipeline document; the dead end; the open question.
   K-20260110-0700 met no new evidence: checked, left unchanged.
4. **Write** - the new card's Evidence lists the three logs; the old card gets its
   `**SUPERSEDED**` line; the INDEX entries name their logs.
5. **Verify, then flip** - the rebuild lists the new card as live and the old one as
   superseded, and reports no mark without a link. Only then do the five logs get
   `consolidated: true`; the pre-schema log first gets its front matter.
6. **Record** - one row in Consolidation cycles.
7. **Close** - the retention chain; the rebuilt index shows BILLING with 0 unconsolidated
   logs.

## What case two taught

- A cycle records what it **checked and left unchanged**, not only what it wrote. The next
  cycle then knows that a card was already weighed against those logs.
- A cycle in a client's area found rules of the shared core. Those cards were written into
  the core's area and cited from the client's INDEX. Cross-area facts go to their owner;
  they are never copied.
- Each cycle carried the open questions forward with their state, and "none resolved" is
  a state too. A question dropped in silence loses the reason a later answer matters.
- One cycle absorbed thirteen logs of one area at once. A count that large is the reason
  for the worksheet: claims are grouped by theme, not read log by log.
