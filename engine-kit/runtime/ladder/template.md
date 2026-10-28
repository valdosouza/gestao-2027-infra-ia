# Abstraction ladder - node source document (template)

**Scope**: method

The raw layer a box renders from: what a manifest node's `source_md` (mode A) or a leaf
page's `source_md` (mode B) points to. Prose only - the generators handle boxes,
statuses and navigation. One file per node per depth that genuinely needs its own
depth; tiers that need no other depth share one file.

## How to fill it

1. **The node exists first.** This file is only ever reached from a manifest or spec
   entry; never create it standalone.
2. **Prefer what already exists and is validated** - an area's pipeline doc, an area
   index, an existing manual. The ladder is presentation, not primary authorship: point
   at the raw source instead of writing new prose that repeats it.
3. **Write at the depth of the tier** when new prose is needed: a technical-build page
   and an executive-summary page about the same process read differently. Do not
   smuggle another tier's depth in.
4. **Every claim is traceable to an evidence category** (list in the skeleton). No
   evidence line, no claim.
5. **Leave `validation.status: pending`** until the node passed its validation round
   (the owner, a tester, a developer - whoever the content calls for). The template does
   not let an author self-declare validated; the box's status in the manifest changes
   only after that sign-off.

## Location and naming

Wherever the `source_md` path points, relative to the manifest or spec. The raw doc
usually already lives in its natural home (an area's pipelines, its index, the manuals
folder) and keeps that home's naming convention; use this skeleton only when no
convention applies.

## Skeleton

```markdown
---
node_id: <node-id>
pack: <pack-id>
audience_tier: <tier-id>
evidence: <category>      # static analysis | runtime trace | database dependency |
                          # documentation | bug investigation | production incident |
                          # developer validated | semantic similarity | model inference
confidence: <0.0-1.0>
validation:
  status: pending         # pending | validated | needs-revalidation
  reviewers: []           # filled by the validation round
  decision_ref: <optional decision id>
last_source_sync: <YYYY-MM-DD>   # when the underlying code/process was last checked
---

# <Node label>

**Scope**: <method | case-key | mixed>

> Pack: <pack-id> | Tier: <tier label> | Depth: <one line: what this page is for>

## What this covers

<One to three paragraphs; every claim traceable to the evidence above.>

## Details

<Sections as needed, at this tier's depth only.>

## Open questions

<Unresolved items, or "None.">
```

When the source behind a validated page changes, the page is not edited quietly: the
node's status goes to `stale` in the manifest or spec first, then the page is
revalidated.
