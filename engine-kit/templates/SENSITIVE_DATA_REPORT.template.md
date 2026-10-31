# Sensitive data report - <repository or folder> - <YYYY-MM-DD>

**Scope**: <method|case|mixed>

> **Rule zero: this report never contains a secret value.** Not the key, not the password,
> not "the first characters", not a screenshot of it. Record what it is and where it is;
> the value stays where it was found until it is rotated. A report that quotes a secret is
> itself a leak - and it usually gets committed, shared and indexed.

**Scanned**: <paths, branches and history depth> · **How**: <tool or manual review, command
used> · **By**: <who> · **Status**: <open | rotating | cleaned | closed>

## Findings

| # | Type | Location | Line | In history? | Risk | Action | State |
|---|---|---|---|---|---|---|---|
| 1 | <API key / password / token / private key / connection string / personal data> | `<path>` | <n> | <yes - since commit/revision X / no> | <critical / high / medium / low - and why: what it opens, who can read the repository> | <rotate at the provider, then remove from the file, then rewrite history if published> | <open / rotated / removed / history cleaned> |

Risk guide: **critical** = a live credential in a repository that others can read (or ever
could); **high** = a live credential in a private repository, or a revoked one still in
public history; **medium** = personal data or internal endpoints; **low** = test or example
values that look real (fix them so they stop looking real).

## Action plan (in this order)

1. **Rotate or restrict first** - at the provider, for every live credential found. Removing
   it from the file does not help while the old value still works.
2. **Remove from the working tree** - move the value to an ignored local file or the
   secret store, and leave an `.example` with a placeholder.
3. **Clean the history** when the repository is or was readable by others (see
   [the secrets protection setup](../skills/git-security/references/SECRETS_PROTECTION_SETUP.md)),
   then ask every clone to re-clone.
4. **Prevent** - ignore rules by category, a pre-commit secret scan, CI scanning with
   redaction on.
5. **Close** - each row marked rotated / removed / history cleaned, with the date.

## Not findings (checked and cleared)

| Location | Why it is not a secret |
|---|---|
| `<path>` | <placeholder value / documented public key / test fixture> |
