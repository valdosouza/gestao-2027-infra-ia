# <AREA> - Knowledge for AI-assisted work

**Scope**: <method|case|mixed>
**Master copy**: `<knowledge-base path of this file>` (linked from the area's `INDEX.md`)
**Deployed copy**: `<workspace folder on the developer's machine>` - a plain, unversioned copy
**Last updated**: <YYYY-MM-DD>

> Template from the engine-kit (`templates/AREA_KNOWLEDGE.template.md`), technique T08
> (open-question onboarding, `candidate`). Save the filled copy as `<AREA>_KNOWLEDGE.md`,
> fill every `<placeholder>` and delete this note. Distilled, not exhaustive: the AI can
> read the code - give it the map, not the territory. Every reference file named below
> must exist in the deployed workspace (relative names, no knowledge-base paths).

## How to use this file

Paste this one line into the developer's tool rules file (`.cursorrules`, `CLAUDE.md`, ...):

> For any broad question about <AREA>, read `<AREA>_KNOWLEDGE.md` first and answer from it;
> offer to update its STATUS section after each commit.

Smoke test (no special syntax, no file mentions): *"What do you know about <AREA> that can
help me?"* returns the context, the recipe, the queue and the watch-outs; *"What should I
do next?"* answers from the Queue below.

## Context

<Three to six lines: what this area is, who uses it, why the current effort exists.>

## The recipe (proven patterns)

"Do to X what was done to Y" beats any abstract description: point at real, finished work.

| Pattern | When it applies | Reference in this workspace |
|---|---|---|
| <pattern name> | <trigger> | `<relative/path/to/finished/example>` |

## STATUS

Kept as simple markdown tables so the AI can update them itself.

### Done

| Item | Date | Reference |
|---|---|---|
| <item> | <YYYY-MM-DD> | <commit or file> |

### Queue (next first)

| Item | Pattern | Notes |
|---|---|---|
| <item> | <pattern name> | <notes> |

### Skip (decided not to do)

| Item | Why |
|---|---|
| <item> | <reason and who decided> |

### Open issues

| Issue | Since | Waiting on |
|---|---|---|
| <issue> | <YYYY-MM-DD> | <the role, not a name, unless the people registry confirms it> |

## Watch-outs

Known traps the AI must not clone:

- <trap: what it looks like, why it is wrong, what to do instead>

## Working agreements

- <how commits are made, who reviews, what the AI must never do in this area>
