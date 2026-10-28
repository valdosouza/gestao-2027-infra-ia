# Install journal - reversible machine setup

**Scope**: method

A setup script that changes a machine (files, folders, links, environment variables,
scheduled tasks, entries in another program's hook list) does every change through
[`InstallJournal.psm1`](InstallJournal.psm1). **Every change is one JSON line** in a journal
file; **uninstall reverses the lines newest first**; **install runs only on explicit
request** (importing the module, or loading a skill that mentions it, changes nothing).
Technique T74.

## Files

| File | What it is |
|---|---|
| [`InstallJournal.psm1`](InstallJournal.psm1) | The module: eleven exported functions, no side effect on import. Windows PowerShell 5.1 (and 7), ASCII-only, LF |
| [`tests/test-install-journal.ps1`](tests/test-install-journal.ps1) | Plain PowerShell tests (no Pester), run in a scratch folder; fakes replace the scheduler and the registry inside the module |

## The contract: the journal

- **One journal per installed component**, its path always a parameter (`-Journal`). It is
  machine state: keep it outside the kit and outside every repository (for example
  `<local-app-data>\<tool>\install.jsonl`), never versioned.
- **JSON Lines**, UTF-8 without BOM, ASCII-only (non-ASCII is escaped `\uXXXX`), LF.
- **Write-ahead**: the line is appended just before its change. If the change then fails,
  an `undone` marker with `result: not-applied` closes the line at once; after a crash the
  undo finds the change missing and reports `gone`. There is never a change without a line.
- **Append-only**: undo does not rewrite the journal; it appends one `undone` marker per
  line it handles. A stopped undo therefore resumes where it stopped. When nothing is
  left, the journal is renamed `<journal>.undone-<stamp>` (kept as the audit trail).
- **Backups** of replaced files and of edited JSON files go to `<journal>.backup\`; each is
  consumed by its undo; the folder is removed when empty.

Every line has `v` (schema, 1), `seq` (1, 2, ...), `time` (local, with offset) and `action`.
A change line also has `id` (identity used for idempotency), `target`, `keep`, and
`supersedes` when it replaces an older line of the same id. Example:

```json
{"v":1,"seq":1,"time":"2026-10-21T10:15:02+01:00","action":"folder-create","id":"folder:c:\\tools\\demo","target":"C:\\tools\\demo","keep":false}
{"v":1,"seq":2,"time":"2026-10-21T10:15:02+01:00","action":"file-create","id":"file:c:\\tools\\demo\\demo.ini","target":"C:\\tools\\demo\\demo.ini","keep":false,"sha256":"6F1E0C..."}
{"v":1,"seq":3,"time":"2026-10-21T10:15:03+01:00","action":"env-set","id":"env:user:demo_home","target":"DEMO_HOME","keep":false,"scope":"User","value":"C:\\tools\\demo","before":null}
{"v":1,"seq":4,"time":"2026-10-21T11:40:19+01:00","action":"undone","ref":3,"result":"reverted"}
```

A change line is **active** while no `undone` marker points at it (`ref`) and no applied line
supersedes it. Markers: `undone` (`ref`, `result`: `reverted`, `kept`, `gone`, `retained`,
`not-applied`; optional `note`) and `repaired` (`ref`: a missing change was re-applied).

| `action` | Written by | Extra fields | Inverse (undo) |
|---|---|---|---|
| `folder-create` | `New-JournalFolder`; any missing parent of a file, link or JSON file | - | remove the folder if it is empty |
| `file-create` | `New-JournalFile`; `Set-JournalFile` on a missing file | `sha256` | delete it if its hash is still `sha256` |
| `file-replace` | `Set-JournalFile` on an existing file | `sha256Before`, `backup`, `sha256` | restore the backup if the hash is still `sha256` (also when the file was deleted) |
| `link-create` | `New-JournalLink` | `linkTarget`, `linkType` | remove the link (pointer only) if it still points at `linkTarget` |
| `env-set` | `Set-JournalEnvironment` | `scope`, `value`, `before` | set `before` back (no value = remove) if the value is still `value` |
| `task-register` | `Register-JournalTask` | `definition` (hash) | unregister the task |
| `task-disable` | `Disable-JournalTask` | - | enable the task again |
| `entry-add` | `Add-JournalEntry` | `store` (`json`/`registry`), `arrayPath` or `valueName`+`recordLines`+`kind`, `entry`, `exact`, `before`, `after`, `backup`, `fileCreated` | untouched list: exact previous bytes/value; otherwise remove only this entry |
| `entry-remove` | `Remove-JournalEntry` | the same + `index` | untouched list: exact previous bytes/value; otherwise insert the entry back at `index` |

## Functions

Every function that changes something supports `-WhatIf` and `-Confirm` (a calling
script's `-WhatIf` reaches them too), takes `-Journal`, and `-Keep` (undo then retains the
change unless `-Purge`) and `-Id` (own identity; a new definition under the same id
supersedes the old line). Paths are resolved against the caller's location.

| Function | Change | Refuses |
|---|---|---|
| `New-JournalFolder -Path` | creates the folder, one line per missing level | a file in the way |
| `New-JournalFile -Path (-Content [-Encoding utf8\|utf8bom\|ascii] \| -SourceFile) [-IfMissing]` | creates the file | an existing file with other content (`-IfMissing` leaves it instead) |
| `Set-JournalFile -Path (-Content \| -SourceFile)` | replaces the file, old one backed up | a folder or a link in the way |
| `New-JournalLink -Path -Target [-LinkType Junction\|SymbolicLink]` | creates the link | anything already at `-Path` that is not the same link |
| `Set-JournalEnvironment -Name -Value -Scope Process\|User\|Machine` | sets the variable, keeps the old value | - |
| `Register-JournalTask -Name (-Command [-Schedule] [-TaskArgs] \| -Xml)` | registers a scheduled task (`schtasks.exe`) | a task of that name it did not register |
| `Disable-JournalTask -Name` | disables a task that a new one supersedes (never deletes it) | - |
| `Add-JournalEntry (-JsonFile [-ArrayPath a.b.c] \| -RegistryKey -ValueName [-RecordLines n]) -Entry` | adds one entry to another program's list (a hook) | - |
| `Remove-JournalEntry (same store parameters) -Entry` | removes an entry (an older tool's hook) | - |
| `Get-JournalStatus` | - | lists active lines with the live state: `installed`, `changed`, `missing` |
| `Undo-Journal [-ContinueOnError] [-Purge]` | reverses active lines, newest first | stops at the first failure unless `-ContinueOnError` |

**Results.** Each change function returns objects `Action, Target, Status, Seq, Note`, with
`Status` one of `done` (changed, one new line), `skipped` (recorded and in place),
`repaired` (recorded but missing: re-applied), `updated` (new definition: a superseding
line), `present` (already as wanted but not created by this journal: no line, never undone),
`changed` (recorded but someone changed it since: left as it is, with a warning), `whatif`.
`Undo-Journal` returns one object per line with `reverted`, `kept` (changed since: left,
with a warning), `gone` (already absent), `retained` (`-Keep`), `failed` or `whatif`; on a
failure it writes one error naming the line, what was undone, what is still installed, and
"run Undo-Journal again". JSON list entries are compared in a canonical form (sorted keys);
pass `[ordered]@{...}` or an object so the written key order is stable.

## Safety rules

1. **Never delete or overwrite what changed after we made it.** A created file whose hash
   differs, a folder that is not empty, a variable with another value, a link re-pointed:
   kept, with a warning; the line is closed so the journal can finish.
2. **Never follow a link to delete.** Links are removed with `[IO.Directory]::Delete` /
   `[IO.File]::Delete` (the pointer); nothing is deleted recursively; a created folder that
   became a link is kept. Link detection uses `LinkType`, not the reparse-point attribute
   (cloud-sync placeholders are reparse points too).
3. **Never take over what we did not create.** Something already there is refused or left
   as `present`, with no line, so no undo can ever remove it.
4. **Supersede, do not destroy.** An older tool's task is disabled, its hook entry removed
   with an inverse; both come back on undo.
5. **Install only on explicit request**; `-WhatIf` before the first real run.
6. **No secrets in the journal**: values and previous values are stored in plain text.

## How a setup script uses it

```powershell
[CmdletBinding(SupportsShouldProcess = $true)]
param([switch]$Install, [switch]$Uninstall, [switch]$Status)
Import-Module '<kit>\runtime\install-journal\InstallJournal.psm1'
$j = Join-Path $env:LOCALAPPDATA '<tool>\install.jsonl'
if ($Install) {
    New-JournalFile -Journal $j -Path "$env:LOCALAPPDATA\<tool>\config.json" -Content '{}' -IfMissing -Keep
    New-JournalLink -Journal $j -Path "$HOME\.<editor>\skills\<skill>" -Target "$PSScriptRoot\skills\<skill>"
    Set-JournalEnvironment -Journal $j -Name '<TOOL>_HOME' -Value $PSScriptRoot -Scope User
    Add-JournalEntry -Journal $j -JsonFile "$HOME\.<editor>\settings.json" -ArrayPath 'hooks.PostToolUse' -Entry ([ordered]@{ command = '<tool> --hook' }) -Id '<tool>-hook'
} elseif ($Uninstall) { Undo-Journal -Journal $j }
elseif ($Status) { Get-JournalStatus -Journal $j | Format-Table }
else { 'Nothing done. Use -Install, -Uninstall or -Status.' }
```

Run it with `-Install -WhatIf` first. Re-running `-Install` is safe (everything in place is
`skipped`); a new version of the script that writes new content or a new value under the
same id updates it in place. The status door belongs to the script too: it adds its own
prerequisite checks (tools on PATH, access) to `Get-JournalStatus`.

## Tests

`powershell -NoProfile -ExecutionPolicy Bypass -File tests\test-install-journal.ps1 [-Scratch <empty dir>] [-KeepScratch]`

Pester is not required (Windows ships an old Pester 3 at most; the script is plain
PowerShell). It works only inside its scratch folder, sets variables in **Process scope
only**, and replaces the scheduler and registry backends with in-memory fakes inside the
module. Sections: status before; install with `-WhatIf` from a calling function; install
(folders, files, replace, junction, variables, JSON hook add/remove, fake task, fake
registry record); status; re-run (all `skipped`, journal unchanged); drift (deleted file
repaired, new value and new hook definition superseding); refusals; edits by someone else;
undo `-WhatIf`; undo newest first (edited file kept with a warning, `-Keep` retained,
junction removed with its target intact, swapped folder never followed, replaced file and
variables restored, JSON user edit kept); status after (journal archived, no backup left);
exact byte restore of an untouched JSON file (CRLF kept); stop on first failure and resume;
`-ContinueOnError`; write-ahead on a failed change; `-Purge`; symbolic link (skipped
without the privilege). Last run on Windows PowerShell 5.1: **65 passed, 0 failed, 1
skipped** (symbolic link).

## Untested actions

Implemented behind the same interface, never run against the real thing:

| Action | Why untested | What was checked |
|---|---|---|
| `Register-JournalTask`, `Disable-JournalTask`, their undo | would create real scheduled tasks | journal logic with a fake scheduler; `/TR` quoting; the query path and the `<Enabled>false</Enabled>` detection read-only against existing tasks |
| `Add-/Remove-JournalEntry -RegistryKey` | would write real registry keys | journal logic and multi-line records with a fake registry |
| `Set-JournalEnvironment -Scope User/Machine` | would change the user's / machine's environment | Process scope only (same code path, other scope) |
| `New-JournalLink -LinkType SymbolicLink` | needs the create-symbolic-link privilege (Developer Mode or elevation) | the test runs it when allowed, otherwise checks the refused creation is closed as `not-applied` |
| PowerShell 7 | not installed where the tests ran | written for it (own JSON writer, own native command line), not run |

## Limits

- One writer per journal at a time (no lock).
- A scheduled task is identified by its name: a task edited by hand after install is still
  unregistered by the undo.
- Do not use `Set-JournalEnvironment` for list-valued variables such as `PATH` at User or
  Machine scope: it sets the whole value, and the .NET call stores a plain string (an
  expandable `%VAR%` value would be frozen). A per-entry PATH action is not in this version.
- When a JSON list was edited by someone else after us, the undo rewrites the file in a
  2-space layout (content kept, our entry removed); untouched, the exact bytes come back.
  `-ArrayPath` cannot name a key that contains a dot. Under PowerShell 7 before 7.5 such a
  rewrite turns ISO date strings into the round-trip date format.
- A registry hook list is read from a key that must already exist (the owning program
  creates it).

## What was left in the case

Distilled from one case's test-suite installer. Kept: one JSON line per change, reverse
newest first, uninstall keeps the log under another name, disable-not-delete for a
superseded task, re-add for a removed hook entry, "kept on uninstall" items, a second
install that changes nothing. Dropped as case-only: the version-control
client's hook format and its identity rule (type + path + command, flags ignored; here an
exact record), the tool-specific configuration and interactive questions, a build
environment file generated from an example, a pinned-hash download of a coverage tool (a
separate technique), the import of an older tool's state, the move of a test suite between
working copies, and the prerequisite checks (they belong to each setup script's status).
Changed on the way: lines are written before the change, not after; undo appends markers
instead of renaming only at the end, so a failed undo can resume; `seq` and schema `v`;
LF instead of CRLF; the scheduler command line is built in one place, so embedded quotes
behave the same on Windows PowerShell 5.1 and PowerShell 7.

## Techniques

| # | Technique | Maturity ([labels](../../docs/MATURITY.md)) | Here |
|---|---|---|---|
| T74 | Reversible install journal | operating | the module, its tests and this contract; related rules in [`sync-skills.ps1`](../sync-skills.ps1) (junctions, never delete) |
