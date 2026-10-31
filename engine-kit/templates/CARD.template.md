---
id: K-<YYYYMMDD>-<HHMM>             # minted at write time; never changed, never reused
kind: card
project: <KEY>                      # optional; otherwise derived from the path
subject: <AREA>
version: "<version the rule was verified on>"   # delete the line when the project has no version lines
tickets: ["<id>"]                   # every work item that produced or confirmed the rule
entities: [<unit>, <table>, <screen>]
status: fact                        # cards hold facts only
confidence: 0.9                     # 0.8 or more at birth; 0.95 after two independent confirmations
source_file: <repository-relative path of the main file>
vcs_revision: <revision or commit>  # that introduced or last changed the code the rule describes; pending until committed
vcs_date: <YYYY-MM-DD HH:MM:SS +ZZZZ>
vcs_author: <author of that revision>
supersedes: []                      # ids of the cards this one replaces; they are marked, never deleted
last_updated: <YYYY-MM-DD>
---
# <The rule, stated as one sentence a reader can quote>

**Scope**: <method|case|mixed>

> Template from the engine-kit (`templates/CARD.template.md`) - technique T49, *operating*.
> One rule per file, at `SUBJECT/<AREA>/KNOWLEDGE/<version>_<Entity>_<ShortRule>_<YYYY-MM-DD>.md`
> of the owning project. Under 60 lines once this note is gone. Replace every
> `<placeholder>`, keep the six sections, and delete this note. When a newer card replaces
> this one, add one line under the Scope line:
> `**SUPERSEDED**: see K-<new id> (<YYYY-MM-DD>, <why, one line>)`. Method: the
> `archive-card` skill.

## Problem
<The failure or the question, symptom first, in two to four lines.>

## Rule
<The invariant in one or two sentences - the part that gets quoted. Say since when it
holds when it has temporal validity ("since revision <rev>").>

## Fix pattern
1. <What to change, and where: the working shape.>
2. <...>

## Anti-patch
<The tempting change that hides the symptom and leaves the cause - what not to do.>

## Key files
- <repository-relative path> (<function or section>, lines <n>-<m>)

## Evidence
- Log: <base-relative path of the episodic log> (claim <n>)
- Verified at: <working-copy revision>, <YYYY-MM-DD> (<static read | run>)
- Work items: <ids>
