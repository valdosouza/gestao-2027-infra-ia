# InstallJournal.psm1 - reversible install journal (engine-kit runtime, technique T74).
#
# Every change a setup script makes to a machine goes through one function of this module,
# and every change is ONE JSON line in a journal file (JSON Lines; one journal per installed
# component; its path is always a parameter). The line carries what the inverse needs and is
# appended just BEFORE the change (write-ahead): a crash leaves at worst a line whose change
# never happened - which the undo recognises - never a change nobody recorded.
# Undo-Journal reverses the active lines newest first.
#
# Rules the module enforces:
#   - Nothing runs on import. A setup script installs only when it is explicitly asked to.
#   - Never delete or overwrite what changed after we made it: a created file whose hash
#     differs, a folder that is not empty, a variable with another value -> kept, with a warning.
#   - Never follow a link to delete: a link is removed as a pointer ([IO.Directory]::Delete /
#     [IO.File]::Delete, never recursive), and a path that became a link is kept.
#   - Never take over what we did not create: an existing file, link or task that is not in the
#     journal is refused (or left as it is), so the undo can never remove it.
#   - Idempotent: an action recorded and still in place is skipped; recorded but gone, it is
#     re-applied (repaired); a new definition under the same id (new content, new value, new
#     target) supersedes the old line.
#   - -WhatIf and -Confirm on every function that changes something.
#
# Journal line (schema v1), one per change; markers point at a line by its seq:
#   {"v":1,"seq":3,"time":"...","action":"file-create","id":"file:c:\\x\\a.ini","target":"C:\\x\\a.ini","keep":false,"sha256":"..."}
#   {"v":1,"seq":9,"time":"...","action":"undone","ref":3,"result":"reverted"}
# Contract and examples: README.md next to this file.
#
# Windows PowerShell 5.1 compatible (PowerShell 7 too). ASCII-only on purpose: Windows
# PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.

$script:SchemaVersion = 1
$script:Inv = [Globalization.CultureInfo]::InvariantCulture
$script:Utf8 = New-Object Text.UTF8Encoding($false)

# ======================================================================== helpers

function Get-Prop($Object, [string]$Name) {
    if ($null -eq $Object) { return $null }
    $p = $Object.PSObject.Properties[$Name]
    if ($p) { return , $p.Value }   # the comma keeps a one-element array an array
    return $null
}

function Use-CallerWhatIf($Cmdlet, $Bound) {
    # The caller's -WhatIf also governs the cmdlets this module calls (modules do not see the
    # caller's preference variables otherwise).
    if ($Bound.ContainsKey('WhatIf')) { return }
    $v = $Cmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
    if ($null -ne $v) { Set-Variable -Scope 1 -Name WhatIfPreference -Value $v -WhatIf:$false -Confirm:$false }
}

function Resolve-FullPath($Cmdlet, [string]$Path) {
    # relative to the CALLER's location, not to the process working folder
    $full = $Cmdlet.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
    if ($full.Length -gt 3) { $full = $full.TrimEnd('\', '/') }
    return $full
}

function Get-NormKey([string]$Text) { return $Text.TrimEnd('\', '/').ToLowerInvariant() }

function Get-HexHash([byte[]]$Bytes) {
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return [BitConverter]::ToString($sha.ComputeHash($Bytes)).Replace('-', '') } finally { $sha.Dispose() }
}

function Get-FileHashHex([string]$Path) {
    $sha = [Security.Cryptography.SHA256]::Create()
    $fs = [IO.File]::Open($Path, 'Open', 'Read', 'ReadWrite')
    try { return [BitConverter]::ToString($sha.ComputeHash($fs)).Replace('-', '') } finally { $fs.Dispose(); $sha.Dispose() }
}

function Test-Entry([string]$Path) {
    # true for a broken junction too (Test-Path follows the link and says false)
    return ([IO.Directory]::Exists($Path) -or [IO.File]::Exists($Path))
}

function Get-PathKind([string]$Path) {
    # 'absent' | 'link' | 'dir' | 'file'. LinkType, not the ReparsePoint attribute: cloud-sync
    # placeholders are reparse points too.
    if (-not (Test-Entry $Path)) { return 'absent' }
    $item = Get-Item -LiteralPath $Path -Force
    if ($item.LinkType -eq 'Junction' -or $item.LinkType -eq 'SymbolicLink') { return 'link' }
    if ($item.PSIsContainer) { return 'dir' }
    return 'file'
}

function Get-LinkTargetPath([string]$Path) {
    $t = (Get-Item -LiteralPath $Path -Force).Target
    if ($t -is [array]) { $t = $t[0] }
    return [string]$t
}

function Remove-LinkPointer([string]$Path) {
    # removes the link itself; the target and its content are never touched
    $item = Get-Item -LiteralPath $Path -Force
    if (-not ($item.LinkType -eq 'Junction' -or $item.LinkType -eq 'SymbolicLink')) { throw "not a link, refusing to remove: $Path" }
    if ($item.PSIsContainer) { [IO.Directory]::Delete($Path) } else { [IO.File]::Delete($Path) }
}

function New-Result([string]$Action, [string]$Target, [string]$Status, $Seq = $null, [string]$Note = '') {
    return [pscustomobject]@{ Action = $Action; Target = $Target; Status = $Status; Seq = $Seq; Note = $Note }
}

function Write-Changed([string]$Action, [string]$Target, $Seq, [string]$Why) {
    Write-Warning "$Action ${Target}: $Why - left as it is"
    return (New-Result $Action $Target 'changed' $Seq $Why)
}

# ---------------------------------------------------------------- JSON (no ConvertTo-Json)
# Own writer: deterministic on 5.1 and 7, 2-space indent like most tools, sorted keys for the
# canonical form of an entry, ASCII-only in the journal (\uXXXX).

function ConvertTo-JsonLiteral([string]$Text, [bool]$Ascii) {
    $sb = New-Object Text.StringBuilder ($Text.Length + 2)
    [void]$sb.Append('"')
    foreach ($ch in $Text.ToCharArray()) {
        $c = [int]$ch
        if ($c -eq 34) { [void]$sb.Append('\"') }
        elseif ($c -eq 92) { [void]$sb.Append('\\') }
        elseif ($c -eq 10) { [void]$sb.Append('\n') }
        elseif ($c -eq 13) { [void]$sb.Append('\r') }
        elseif ($c -eq 9) { [void]$sb.Append('\t') }
        elseif ($c -lt 32 -or ($Ascii -and $c -gt 126)) { [void]$sb.Append('\u' + $c.ToString('x4')) }
        else { [void]$sb.Append($ch) }
    }
    [void]$sb.Append('"')
    return $sb.ToString()
}

function ConvertTo-JsonText($Value, [bool]$Indent = $false, [bool]$Sort = $false, [bool]$Ascii = $true, [string]$Pad = '') {
    if ($null -eq $Value) { return 'null' }
    if ($Value -is [string] -or $Value -is [char] -or $Value -is [guid] -or $Value -is [enum]) { return (ConvertTo-JsonLiteral ([string]$Value) $Ascii) }
    if ($Value -is [bool]) { if ($Value) { return 'true' } else { return 'false' } }
    if ($Value -is [datetime]) { return (ConvertTo-JsonLiteral $Value.ToString('o', $script:Inv) $Ascii) }
    if ($Value -is [double] -or $Value -is [single]) { return ([double]$Value).ToString('R', $script:Inv) }
    if ($Value -is [int] -or $Value -is [long] -or $Value -is [decimal] -or $Value -is [int16] -or $Value -is [byte] -or
        $Value -is [sbyte] -or $Value -is [uint16] -or $Value -is [uint32] -or $Value -is [uint64]) { return ([IFormattable]$Value).ToString($null, $script:Inv) }
    $inner = ''; $nl = ''; $colon = ':'
    if ($Indent) { $inner = $Pad + '  '; $nl = "`n"; $colon = ': ' }
    $isDict = $Value -is [Collections.IDictionary]
    if ($isDict -or $Value -is [Management.Automation.PSCustomObject]) {
        $names = New-Object Collections.Generic.List[string]
        $vals = @{}
        if ($isDict) { foreach ($k in $Value.Keys) { $names.Add([string]$k); $vals[[string]$k] = $Value[$k] } }
        else { foreach ($p in $Value.PSObject.Properties) { if ($p.MemberType -eq 'NoteProperty') { $names.Add($p.Name); $vals[$p.Name] = $p.Value } } }
        if ($names.Count -eq 0) { return '{}' }
        $order = $names.ToArray()
        if ($Sort) { [Array]::Sort($order, [StringComparer]::Ordinal) }
        $parts = foreach ($n in $order) { $inner + (ConvertTo-JsonLiteral $n $Ascii) + $colon + (ConvertTo-JsonText $vals[$n] $Indent $Sort $Ascii $inner) }
        return '{' + $nl + (@($parts) -join (',' + $nl)) + $nl + $Pad + '}'
    }
    if ($Value -is [Collections.IEnumerable]) {
        $parts = foreach ($item in $Value) { $inner + (ConvertTo-JsonText $item $Indent $Sort $Ascii $inner) }
        if (@($parts).Count -eq 0) { return '[]' }
        return '[' + $nl + (@($parts) -join (',' + $nl)) + $nl + $Pad + ']'
    }
    return (ConvertTo-JsonLiteral ([string]$Value) $Ascii)
}

$script:JsonDateKind = (Get-Command ConvertFrom-Json).Parameters.ContainsKey('DateKind')

function ConvertFrom-JsonText([string]$Text) {
    # PowerShell 7.5+ would turn ISO date strings into dates; keep them strings
    if ($script:JsonDateKind) { $o = ConvertFrom-Json -InputObject $Text -DateKind String }
    else { $o = ConvertFrom-Json -InputObject $Text }
    return , $o
}

# ======================================================================== the journal

function Read-JournalState([string]$Journal) {
    $lines = New-Object Collections.Generic.List[object]
    if ([IO.File]::Exists($Journal)) {
        $n = 0
        foreach ($text in [IO.File]::ReadAllLines($Journal)) {
            $n++
            if (-not $text.Trim()) { continue }
            try { $lines.Add((ConvertFrom-JsonText $text)) }
            catch { throw "journal $Journal, line ${n}: not valid JSON; nothing was changed - repair that line by hand ($($_.Exception.Message))" }
        }
    }
    $closed = @{}
    $notApplied = @{}
    $maxSeq = 0
    foreach ($l in $lines) {
        $s = [int](Get-Prop $l 'seq')
        if ($s -gt $maxSeq) { $maxSeq = $s }
        if ((Get-Prop $l 'action') -eq 'undone') {
            $closed[[int](Get-Prop $l 'ref')] = $true
            if ((Get-Prop $l 'result') -eq 'not-applied') { $notApplied[[int](Get-Prop $l 'ref')] = $true }
        }
    }
    foreach ($l in $lines) {
        # a superseding line closes the older one - unless its own change never happened
        $sup = Get-Prop $l 'supersedes'
        if ($null -ne $sup -and -not $notApplied.ContainsKey([int](Get-Prop $l 'seq'))) { $closed[[int]$sup] = $true }
    }
    $active = @($lines | Where-Object { @('undone', 'repaired') -notcontains (Get-Prop $_ 'action') -and -not $closed.ContainsKey([int](Get-Prop $_ 'seq')) })
    return [pscustomobject]@{ Path = $Journal; Lines = $lines.ToArray(); Active = $active; NextSeq = $maxSeq + 1 }
}

function Find-ActiveRecord([string]$Journal, [string]$Id) {
    $hit = $null
    foreach ($r in (Read-JournalState $Journal).Active) { if ((Get-Prop $r 'id') -eq $Id) { $hit = $r } }
    return $hit
}

function Add-JournalLine([string]$Journal, [string]$Action, $Fields) {
    $line = [ordered]@{ v = $script:SchemaVersion; seq = (Read-JournalState $Journal).NextSeq; time = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssK', $script:Inv); action = $Action }
    foreach ($k in $Fields.Keys) { $line[$k] = $Fields[$k] }
    $dir = Split-Path -Parent $Journal
    if ($dir -and -not [IO.Directory]::Exists($dir)) { [void][IO.Directory]::CreateDirectory($dir) }
    [IO.File]::AppendAllText($Journal, (ConvertTo-JsonText $line) + "`n", $script:Utf8)
    return $line.seq
}

function Add-NotApplied([string]$Journal, $Seq, $ErrorRecord) {
    # the write-ahead line stays, closed: its change did not happen
    [void](Add-JournalLine $Journal 'undone' ([ordered]@{ ref = $Seq; result = 'not-applied'; note = $ErrorRecord.Exception.Message }))
}

function New-BackupPath([string]$Journal, [string]$Leaf) {
    $name = (Get-Date).ToString('yyyyMMddHHmmss', $script:Inv) + '-' + [guid]::NewGuid().ToString('N').Substring(0, 8) + '-' + $Leaf
    return (Join-Path ($Journal + '.backup') $name)
}

function Save-Backup([string]$Journal, [string]$Path) {
    $backup = New-BackupPath $Journal (Split-Path -Leaf $Path)
    [void][IO.Directory]::CreateDirectory((Split-Path -Parent $backup))
    [IO.File]::Copy($Path, $backup, $false)
    [IO.File]::SetAttributes($backup, [IO.FileAttributes]::Normal)   # a copy of a read-only file is read-only too
    return $backup
}

function Remove-Backup($Backup) {
    if ($Backup -and [IO.File]::Exists([string]$Backup)) {
        [IO.File]::SetAttributes([string]$Backup, [IO.FileAttributes]::Normal)
        [IO.File]::Delete([string]$Backup)
    }
}

# ======================================================================== folders

function Invoke-FolderCreate($Cmdlet, [string]$Journal, [string]$Path, [bool]$Keep, [string]$Id = '') {
    $kind = Get-PathKind $Path
    $leafId = $Id
    if (-not $leafId) { $leafId = 'folder:' + (Get-NormKey $Path) }
    if ($kind -eq 'file') { throw "a file is there, not a folder: $Path" }
    if ($kind -ne 'absent') {
        $rec = Find-ActiveRecord $Journal $leafId
        if ($rec -and $kind -eq 'dir') { return (New-Result 'folder-create' $Path 'skipped' $rec.seq) }
        if ($rec) { return (Write-Changed 'folder-create' $Path $rec.seq 'a link is there now') }
        return (New-Result 'folder-create' $Path 'present' $null 'exists, not created by this journal')
    }
    # every missing level is its own line, outermost first, so the undo removes innermost first
    $chain = New-Object Collections.Generic.List[string]
    $p = $Path
    while ($p -and (Get-PathKind $p) -eq 'absent') {
        $chain.Insert(0, $p)
        $parent = Split-Path -Parent $p
        if (-not $parent -or $parent -eq $p) { break }
        $p = $parent
    }
    foreach ($level in $chain) {
        $id = 'folder:' + (Get-NormKey $level)
        if ($level -eq $Path) { $id = $leafId }
        if (-not $Cmdlet.ShouldProcess($level, 'create folder')) { New-Result 'folder-create' $level 'whatif'; continue }
        $rec = Find-ActiveRecord $Journal $id
        if ($rec) {
            [void][IO.Directory]::CreateDirectory($level)
            [void](Add-JournalLine $Journal 'repaired' ([ordered]@{ ref = $rec.seq }))
            New-Result 'folder-create' $level 'repaired' $rec.seq
            continue
        }
        $seq = Add-JournalLine $Journal 'folder-create' ([ordered]@{ id = $id; target = $level; keep = $Keep })
        try { [void][IO.Directory]::CreateDirectory($level) } catch { Add-NotApplied $Journal $seq $_; throw }
        New-Result 'folder-create' $level 'done' $seq
    }
}

function New-JournalFolder {
    <#
    .SYNOPSIS
    Creates a folder (and each missing parent), one journal line per level. Undo removes a level
    only when it is empty; a folder that is not empty, or became a link, is kept with a warning.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true)][string]$Path,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    Invoke-FolderCreate $PSCmdlet (Resolve-FullPath $PSCmdlet $Journal) (Resolve-FullPath $PSCmdlet $Path) ([bool]$Keep) $Id
}

function Initialize-Parent($Cmdlet, [string]$Journal, [string]$Path, [bool]$Keep) {
    $parent = Split-Path -Parent $Path
    if ($parent -and (Get-PathKind $parent) -eq 'absent') { Invoke-FolderCreate $Cmdlet $Journal $parent $Keep }
}

# ======================================================================== files

function Get-WantedBytes([string]$Set, [string]$Content, [string]$Encoding, [string]$SourceFile) {
    if ($Set -eq 'Source') {
        if (-not [IO.File]::Exists($SourceFile)) { throw "source file not found: $SourceFile" }
        return , ([IO.File]::ReadAllBytes($SourceFile))
    }
    if ($Encoding -eq 'ascii') {
        if ($Content -match '[^\x00-\x7F]') { throw 'the content has non-ASCII characters; use -Encoding utf8' }
        return , ([Text.Encoding]::ASCII.GetBytes($Content))
    }
    if ($Encoding -eq 'utf8bom') { $e = New-Object Text.UTF8Encoding($true); return , ([byte[]]($e.GetPreamble() + $e.GetBytes($Content))) }
    return , ($script:Utf8.GetBytes($Content))
}

function Invoke-FileAction($Cmdlet, [string]$Journal, [string]$Mode, [string]$Path, [byte[]]$Bytes, [bool]$IfMissing, [bool]$Keep, [string]$Id) {
    $want = Get-HexHash $Bytes
    if (-not $Id) { $Id = 'file:' + (Get-NormKey $Path) }
    $rec = Find-ActiveRecord $Journal $Id
    $kind = Get-PathKind $Path
    if ($kind -eq 'link' -or $kind -eq 'dir') {
        if ($rec) { return (Write-Changed $rec.action $Path $rec.seq "a $kind is there now") }
        throw "refusing to write a file over a ${kind}: $Path"
    }
    $cur = $null
    if ($kind -eq 'file') { $cur = Get-FileHashHex $Path }

    if ($rec) {
        $act = [string]$rec.action
        $untouched = ($cur -eq $rec.sha256) -or ($null -eq $cur) -or ($cur -eq $want)
        if (-not $untouched) { return (Write-Changed $act $Path $rec.seq 'changed since this journal wrote it') }
        if ($cur -eq $want -and $want -eq $rec.sha256) { return (New-Result $act $Path 'skipped' $rec.seq) }
        if ($null -eq $cur -and $want -eq $rec.sha256) {
            if (-not $Cmdlet.ShouldProcess($Path, 'write the missing file again')) { return (New-Result $act $Path 'whatif' $rec.seq) }
            Initialize-Parent $Cmdlet $Journal $Path $Keep
            [IO.File]::WriteAllBytes($Path, $Bytes)
            [void](Add-JournalLine $Journal 'repaired' ([ordered]@{ ref = $rec.seq }))
            return (New-Result $act $Path 'repaired' $rec.seq)
        }
        # new content for a file this journal owns: a new line supersedes the old one
        if (-not $Cmdlet.ShouldProcess($Path, 'update file')) { return (New-Result $act $Path 'whatif' $rec.seq) }
        $fields = [ordered]@{ id = $Id; target = $Path; keep = $Keep; supersedes = $rec.seq }
        if ($act -eq 'file-replace') { $fields.sha256Before = $rec.sha256Before; $fields.backup = $rec.backup }
        $fields.sha256 = $want
        if ($null -eq $cur) { Initialize-Parent $Cmdlet $Journal $Path $Keep }
        $seq = Add-JournalLine $Journal $act $fields
        try { if ($cur -ne $want) { [IO.File]::WriteAllBytes($Path, $Bytes) } } catch { Add-NotApplied $Journal $seq $_; throw }
        return (New-Result $act $Path 'updated' $seq)
    }

    if ($cur -eq $want) { return (New-Result 'file-create' $Path 'present' $null 'same content already there, not created by this journal') }
    if ($null -eq $cur) {
        Initialize-Parent $Cmdlet $Journal $Path $Keep
        if (-not $Cmdlet.ShouldProcess($Path, 'create file')) { return (New-Result 'file-create' $Path 'whatif') }
        $seq = Add-JournalLine $Journal 'file-create' ([ordered]@{ id = $Id; target = $Path; keep = $Keep; sha256 = $want })
        try { [IO.File]::WriteAllBytes($Path, $Bytes) } catch { Add-NotApplied $Journal $seq $_; throw }
        return (New-Result 'file-create' $Path 'done' $seq)
    }
    if ($Mode -eq 'create') {
        if ($IfMissing) { return (New-Result 'file-create' $Path 'present' $null 'exists, left as it is (-IfMissing)') }
        throw "exists with other content and was not created by this journal: $Path (Set-JournalFile replaces it and keeps a backup; -IfMissing leaves it)"
    }
    if (-not $Cmdlet.ShouldProcess($Path, 'replace file (the old one is backed up)')) { return (New-Result 'file-replace' $Path 'whatif') }
    $backup = Save-Backup $Journal $Path
    $seq = Add-JournalLine $Journal 'file-replace' ([ordered]@{ id = $Id; target = $Path; keep = $Keep; sha256Before = $cur; backup = $backup; sha256 = $want })
    try { [IO.File]::WriteAllBytes($Path, $Bytes) } catch { Add-NotApplied $Journal $seq $_; Remove-Backup $backup; throw }
    return (New-Result 'file-replace' $Path 'done' $seq)
}

function New-JournalFile {
    <#
    .SYNOPSIS
    Creates a file (missing parent folders are journaled too). Refuses an existing file this
    journal did not create, unless -IfMissing (then it is left as it is). Undo deletes the file
    only when its hash is still the one written; otherwise it is kept with a warning.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Content')]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true, ParameterSetName = 'Content')][AllowEmptyString()][string]$Content,
        [Parameter(ParameterSetName = 'Content')][ValidateSet('utf8', 'utf8bom', 'ascii')][string]$Encoding = 'utf8',
        [Parameter(Mandatory = $true, ParameterSetName = 'Source')][string]$SourceFile,
        [switch]$IfMissing,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $src = ''
    if ($SourceFile) { $src = Resolve-FullPath $PSCmdlet $SourceFile }
    $bytes = Get-WantedBytes $PSCmdlet.ParameterSetName $Content $Encoding $src
    Invoke-FileAction $PSCmdlet (Resolve-FullPath $PSCmdlet $Journal) 'create' (Resolve-FullPath $PSCmdlet $Path) $bytes ([bool]$IfMissing) ([bool]$Keep) $Id
}

function Set-JournalFile {
    <#
    .SYNOPSIS
    Gives a file the wanted content. An existing file this journal did not create is backed up
    first (next to the journal, in <journal>.backup) and restored by the undo - unless it was
    changed again after we replaced it. A missing file is simply created.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Content')]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true, ParameterSetName = 'Content')][AllowEmptyString()][string]$Content,
        [Parameter(ParameterSetName = 'Content')][ValidateSet('utf8', 'utf8bom', 'ascii')][string]$Encoding = 'utf8',
        [Parameter(Mandatory = $true, ParameterSetName = 'Source')][string]$SourceFile,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $src = ''
    if ($SourceFile) { $src = Resolve-FullPath $PSCmdlet $SourceFile }
    $bytes = Get-WantedBytes $PSCmdlet.ParameterSetName $Content $Encoding $src
    Invoke-FileAction $PSCmdlet (Resolve-FullPath $PSCmdlet $Journal) 'replace' (Resolve-FullPath $PSCmdlet $Path) $bytes $false ([bool]$Keep) $Id
}

# ======================================================================== links

function New-JournalLink {
    <#
    .SYNOPSIS
    Creates a junction (default) or a symbolic link at -Path pointing to -Target. Undo removes
    the link itself, never the target; a link re-pointed by someone else, or a real folder in
    its place, is kept with a warning.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Target,
        [ValidateSet('Junction', 'SymbolicLink')][string]$LinkType = 'Junction',
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $j = Resolve-FullPath $PSCmdlet $Journal
    $link = Resolve-FullPath $PSCmdlet $Path
    $tgt = Resolve-FullPath $PSCmdlet $Target
    if (-not (Test-Entry $tgt)) { throw "link target not found: $tgt" }
    if ($LinkType -eq 'Junction' -and -not [IO.Directory]::Exists($tgt)) { throw "a junction points to a folder: $tgt" }
    if (-not $Id) { $Id = 'link:' + (Get-NormKey $link) }
    $rec = Find-ActiveRecord $j $Id
    $kind = Get-PathKind $link
    $points = ''
    if ($kind -eq 'link') { $points = Get-NormKey (Get-LinkTargetPath $link) }
    $fields = [ordered]@{ id = $Id; target = $link; keep = [bool]$Keep; linkTarget = $tgt; linkType = $LinkType }
    if ($rec) {
        $mine = Get-NormKey ([string]$rec.linkTarget)
        if ($kind -eq 'link' -and $points -eq $mine) {
            if ($points -eq (Get-NormKey $tgt)) { return (New-Result 'link-create' $link 'skipped' $rec.seq) }
        } elseif ($kind -ne 'absent') {
            return (Write-Changed 'link-create' $link $rec.seq 'replaced or re-pointed since this journal created it')
        }
        $sameDef = ($mine -eq (Get-NormKey $tgt)) -and ($rec.linkType -eq $LinkType)
        if (-not $PSCmdlet.ShouldProcess($link, "link -> $tgt")) { return (New-Result 'link-create' $link 'whatif' $rec.seq) }
        if ($kind -eq 'absent') { Initialize-Parent $PSCmdlet $j $link ([bool]$Keep) }
        if ($sameDef -and $kind -eq 'absent') {
            New-Item -ItemType $LinkType -Path $link -Value $tgt -WhatIf:$false -Confirm:$false | Out-Null
            [void](Add-JournalLine $j 'repaired' ([ordered]@{ ref = $rec.seq }))
            return (New-Result 'link-create' $link 'repaired' $rec.seq)
        }
        $fields.supersedes = $rec.seq
        $seq = Add-JournalLine $j 'link-create' $fields
        try {
            if ($kind -eq 'link') { Remove-LinkPointer $link }
            New-Item -ItemType $LinkType -Path $link -Value $tgt -WhatIf:$false -Confirm:$false | Out-Null
        } catch { Add-NotApplied $j $seq $_; throw }
        return (New-Result 'link-create' $link 'updated' $seq)
    }
    if ($kind -eq 'link' -and $points -eq (Get-NormKey $tgt)) { return (New-Result 'link-create' $link 'present' $null 'the same link is there, not created by this journal') }
    if ($kind -ne 'absent') { throw "refusing: $link exists ($kind) and was not created by this journal" }
    Initialize-Parent $PSCmdlet $j $link ([bool]$Keep)
    if (-not $PSCmdlet.ShouldProcess($link, "create $LinkType -> $tgt")) { return (New-Result 'link-create' $link 'whatif') }
    $seq = Add-JournalLine $j 'link-create' $fields
    try { New-Item -ItemType $LinkType -Path $link -Value $tgt -WhatIf:$false -Confirm:$false | Out-Null } catch { Add-NotApplied $j $seq $_; throw }
    return (New-Result 'link-create' $link 'done' $seq)
}

# ======================================================================== environment

function Set-JournalEnvironment {
    <#
    .SYNOPSIS
    Sets an environment variable in one scope and records its previous value. Undo restores the
    previous value (removes the variable when there was none) - unless someone set another value
    since, then it is kept with a warning. Values are stored in the journal: never journal a secret.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$Value,
        [Parameter(Mandatory = $true)][ValidateSet('Process', 'User', 'Machine')][string]$Scope,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $j = Resolve-FullPath $PSCmdlet $Journal
    if (-not $Id) { $Id = 'env:' + $Scope.ToLowerInvariant() + ':' + $Name.ToLowerInvariant() }
    $cur = [Environment]::GetEnvironmentVariable($Name, $Scope)
    $rec = Find-ActiveRecord $j $Id
    $label = "$Scope variable $Name"
    if ($rec) {
        $mine = [string]$rec.value
        $before = Get-Prop $rec 'before'
        if ($cur -ceq $mine -and $Value -ceq $mine) { return (New-Result 'env-set' $label 'skipped' $rec.seq) }
        $gone = ($null -eq $cur) -or ($cur -ceq $before -and -not ($cur -ceq $mine))
        if (-not ($cur -ceq $mine) -and -not $gone -and -not ($cur -ceq $Value)) { return (Write-Changed 'env-set' $label $rec.seq 'another value was set since') }
        if (-not $PSCmdlet.ShouldProcess($label, 'set')) { return (New-Result 'env-set' $label 'whatif' $rec.seq) }
        if ($gone -and $Value -ceq $mine) {
            [Environment]::SetEnvironmentVariable($Name, $Value, $Scope)
            [void](Add-JournalLine $j 'repaired' ([ordered]@{ ref = $rec.seq }))
            return (New-Result 'env-set' $label 'repaired' $rec.seq)
        }
        # a new value supersedes; the value from before the first install is carried along
        $seq = Add-JournalLine $j 'env-set' ([ordered]@{ id = $Id; target = $Name; keep = [bool]$Keep; scope = $Scope; value = $Value; before = $before; supersedes = $rec.seq })
        try { [Environment]::SetEnvironmentVariable($Name, $Value, $Scope) } catch { Add-NotApplied $j $seq $_; throw }
        return (New-Result 'env-set' $label 'updated' $seq)
    }
    if ($cur -ceq $Value) { return (New-Result 'env-set' $label 'present' $null 'already has this value, not set by this journal') }
    if (-not $PSCmdlet.ShouldProcess($label, 'set')) { return (New-Result 'env-set' $label 'whatif') }
    $seq = Add-JournalLine $j 'env-set' ([ordered]@{ id = $Id; target = $Name; keep = [bool]$Keep; scope = $Scope; value = $Value; before = $cur })
    try { [Environment]::SetEnvironmentVariable($Name, $Value, $Scope) } catch { Add-NotApplied $j $seq $_; throw }
    return (New-Result 'env-set' $label 'done' $seq)
}

# ======================================================================== scheduled tasks
# Windows Task Scheduler through schtasks.exe. The command line is built here with the Windows
# quoting rules and handed to the process as one string, so an embedded quote in /TR survives
# the same way on Windows PowerShell 5.1 and PowerShell 7 (their native-argument passing differs).

function ConvertTo-CommandLineArg([string]$Arg) {
    if ($Arg.Length -gt 0 -and $Arg -notmatch '[\s"]') { return $Arg }
    $sb = New-Object Text.StringBuilder
    [void]$sb.Append('"')
    $slashes = 0
    foreach ($ch in $Arg.ToCharArray()) {
        if ($ch -eq '\') { $slashes++; continue }
        if ($ch -eq '"') { [void]$sb.Append('\' * ($slashes * 2 + 1)).Append('"'); $slashes = 0; continue }
        [void]$sb.Append('\' * $slashes).Append($ch); $slashes = 0
    }
    [void]$sb.Append('\' * ($slashes * 2)).Append('"')
    return $sb.ToString()
}

function Invoke-NativeTool([string]$Exe, [string[]]$Arguments) {
    $psi = New-Object Diagnostics.ProcessStartInfo
    $psi.FileName = $Exe
    $psi.Arguments = (@($Arguments | ForEach-Object { ConvertTo-CommandLineArg $_ }) -join ' ')
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.CreateNoWindow = $true
    $p = [Diagnostics.Process]::Start($psi)
    $errTask = $p.StandardError.ReadToEndAsync()
    $out = $p.StandardOutput.ReadToEnd()
    $p.WaitForExit()
    return [pscustomobject]@{ ExitCode = $p.ExitCode; Output = ($out + $errTask.Result) }
}

function Invoke-TaskTool([string[]]$Arguments) { return (Invoke-NativeTool 'schtasks.exe' $Arguments) }

function Get-TaskState([string]$Name) {
    # the XML export is not localized; a disabled task carries <Enabled>false</Enabled> in <Settings>
    $r = Invoke-TaskTool @('/Query', '/TN', $Name, '/XML')
    if ($r.ExitCode -ne 0) { return 'missing' }
    if ($r.Output -match '(?s)<Settings>.*?<Enabled>false</Enabled>.*?</Settings>') { return 'disabled' }
    return 'enabled'
}

function Invoke-TaskChecked([string[]]$Arguments) {
    $r = Invoke-TaskTool $Arguments
    if ($r.ExitCode -ne 0) { throw "schtasks $($Arguments[0]) failed (exit $($r.ExitCode)): $(([string]$r.Output).Trim())" }
}

function Register-JournalTask {
    <#
    .SYNOPSIS
    Registers a Windows scheduled task (schtasks /Create) from a command and a schedule, or from
    a task XML file. Refuses a task of the same name that this journal did not register. Undo
    unregisters it. UNTESTED against the real Task Scheduler (see README).
    #>
    [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Command')]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true, ParameterSetName = 'Command')][string]$Command,
        [Parameter(ParameterSetName = 'Command')][string]$Schedule = 'HOURLY',
        [Parameter(ParameterSetName = 'Command')][string[]]$TaskArgs = @(),
        [Parameter(Mandatory = $true, ParameterSetName = 'Xml')][string]$Xml,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $j = Resolve-FullPath $PSCmdlet $Journal
    if ($PSCmdlet.ParameterSetName -eq 'Xml') {
        $xmlFull = Resolve-FullPath $PSCmdlet $Xml
        if (-not [IO.File]::Exists($xmlFull)) { throw "task XML not found: $xmlFull" }
        $createArgs = @('/Create', '/TN', $Name, '/XML', $xmlFull)
        $definition = Get-FileHashHex $xmlFull
    } else {
        $createArgs = @('/Create', '/TN', $Name, '/SC', $Schedule, '/TR', $Command) + @($TaskArgs)
        $definition = Get-HexHash ($script:Utf8.GetBytes((@($Schedule, $Command) + @($TaskArgs)) -join "`n"))
    }
    if (-not $Id) { $Id = 'task:' + $Name.ToLowerInvariant() }
    $rec = Find-ActiveRecord $j $Id
    $exists = (Get-TaskState $Name) -ne 'missing'
    $fields = [ordered]@{ id = $Id; target = $Name; keep = [bool]$Keep; definition = $definition }
    if ($rec) {
        if ($exists -and $rec.definition -eq $definition) { return (New-Result 'task-register' $Name 'skipped' $rec.seq) }
        $status = 'updated'
        if (-not $exists -and $rec.definition -eq $definition) { $status = 'repaired' }
        if (-not $PSCmdlet.ShouldProcess($Name, 'register scheduled task')) { return (New-Result 'task-register' $Name 'whatif' $rec.seq) }
        $fields.supersedes = $rec.seq
        $seq = Add-JournalLine $j 'task-register' $fields
        try { Invoke-TaskChecked ($createArgs + '/F') } catch { Add-NotApplied $j $seq $_; throw }
        return (New-Result 'task-register' $Name $status $seq)
    }
    if ($exists) { throw "a scheduled task named '$Name' exists and was not registered by this journal; refusing to take it over" }
    if (-not $PSCmdlet.ShouldProcess($Name, 'register scheduled task')) { return (New-Result 'task-register' $Name 'whatif') }
    $seq = Add-JournalLine $j 'task-register' $fields
    try { Invoke-TaskChecked $createArgs } catch { Add-NotApplied $j $seq $_; throw }
    return (New-Result 'task-register' $Name 'done' $seq)
}

function Disable-JournalTask {
    <#
    .SYNOPSIS
    Disables an existing scheduled task that a new one supersedes (never deletes it). Undo
    enables it again. UNTESTED against the real Task Scheduler (see README).
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true)][string]$Name,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $j = Resolve-FullPath $PSCmdlet $Journal
    if (-not $Id) { $Id = 'task-disable:' + $Name.ToLowerInvariant() }
    $rec = Find-ActiveRecord $j $Id
    $state = Get-TaskState $Name
    if ($state -eq 'missing') { return (New-Result 'task-disable' $Name 'present' $null 'no such task, nothing to disable') }
    if ($state -eq 'disabled') {
        if ($rec) { return (New-Result 'task-disable' $Name 'skipped' $rec.seq) }
        return (New-Result 'task-disable' $Name 'present' $null 'already disabled, not by this journal')
    }
    if (-not $PSCmdlet.ShouldProcess($Name, 'disable scheduled task')) { return (New-Result 'task-disable' $Name 'whatif') }
    if ($rec) {
        Invoke-TaskChecked @('/Change', '/TN', $Name, '/DISABLE')
        [void](Add-JournalLine $j 'repaired' ([ordered]@{ ref = $rec.seq }))
        return (New-Result 'task-disable' $Name 'repaired' $rec.seq)
    }
    $seq = Add-JournalLine $j 'task-disable' ([ordered]@{ id = $Id; target = $Name; keep = [bool]$Keep })
    try { Invoke-TaskChecked @('/Change', '/TN', $Name, '/DISABLE') } catch { Add-NotApplied $j $seq $_; throw }
    return (New-Result 'task-disable' $Name 'done' $seq)
}

# ======================================================================== list entries (hooks)
# An entry in a list another program owns: an array inside a JSON file (an editor's hook
# settings) or the records of one registry value (a VCS client's hook list). Entries are matched
# by their canonical form: JSON with sorted keys; the exact text of a registry record.

function Get-StoreSpec($Cmdlet, [string]$Set, [string]$JsonFile, [string]$ArrayPath, [string]$RegistryKey, [string]$ValueName, [int]$RecordLines) {
    if ($Set -eq 'Json') {
        $file = Resolve-FullPath $Cmdlet $JsonFile
        return [pscustomobject]@{ store = 'json'; target = $file; arrayPath = $ArrayPath; locator = 'json:' + (Get-NormKey $file) + '#' + $ArrayPath }
    }
    if ($RecordLines -lt 1) { throw '-RecordLines must be 1 or more' }
    $key = $RegistryKey.TrimEnd('\')
    return [pscustomobject]@{ store = 'registry'; target = $key; valueName = $ValueName; recordLines = $RecordLines; locator = 'registry:' + (Get-NormKey $key) + '\' + $ValueName.ToLowerInvariant() }
}

function Get-SpecFromRecord($Rec) {
    if ($Rec.store -eq 'json') { return [pscustomobject]@{ store = 'json'; target = [string]$Rec.target; arrayPath = [string]$Rec.arrayPath } }
    return [pscustomobject]@{ store = 'registry'; target = [string]$Rec.target; valueName = [string]$Rec.valueName; recordLines = [int]$Rec.recordLines }
}

function Get-EntryKey($Spec, $Entry) {
    if ($Spec.store -eq 'json') { return (ConvertTo-JsonText $Entry $false $true $true) }
    return ((@($Entry) | ForEach-Object { [string]$_ }) -join "`n")
}

# --- registry backend (tests replace these three) ---
function Read-RegistryValue([string]$Key, [string]$Name) {
    if (-not (Test-Path -LiteralPath $Key)) { throw "registry key not found: $Key (is the program that owns this list installed?)" }
    $k = Get-Item -LiteralPath $Key
    if (@($k.GetValueNames()) -notcontains $Name) { return [pscustomobject]@{ Exists = $false; Kind = 'String'; Data = $null } }
    return [pscustomobject]@{ Exists = $true; Kind = [string]$k.GetValueKind($Name); Data = $k.GetValue($Name, $null, 'DoNotExpandEnvironmentNames') }
}
function Write-RegistryValue([string]$Key, [string]$Name, [string]$Kind, $Data) {
    if (@((Get-Item -LiteralPath $Key).GetValueNames()) -contains $Name) { Set-ItemProperty -LiteralPath $Key -Name $Name -Value $Data -Type $Kind -WhatIf:$false -Confirm:$false }
    else { New-ItemProperty -LiteralPath $Key -Name $Name -Value $Data -PropertyType $Kind -WhatIf:$false -Confirm:$false | Out-Null }
}
function Remove-RegistryValue([string]$Key, [string]$Name) {
    Remove-ItemProperty -LiteralPath $Key -Name $Name -WhatIf:$false -Confirm:$false
}

function Read-Store($Spec) {
    # -> Items (entries as stored), Keys (canonical), Snapshot (hash or raw value), plus what a write needs
    if ($Spec.store -eq 'json') {
        $o = [ordered]@{ Exists = $false; Snapshot = $null; Root = $null; Bom = $false; Newline = "`n"; Trailing = $true; Items = @(); Keys = @() }
        if ([IO.File]::Exists($Spec.target)) {
            $bytes = [IO.File]::ReadAllBytes($Spec.target)
            $o.Exists = $true
            $o.Snapshot = Get-HexHash $bytes
            $o.Bom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
            $text = $script:Utf8.GetString($bytes)
            if ($o.Bom) { $text = $text.Substring(1) }
            if ($text.Contains("`r`n")) { $o.Newline = "`r`n" }
            $o.Trailing = ($text.Length -eq 0) -or $text.EndsWith("`n")
            if ($text.Trim()) { $o.Root = ConvertFrom-JsonText $text }
        }
        $segments = @($Spec.arrayPath -split '\.' | Where-Object { $_ })
        if ($null -eq $o.Root) { if ($segments.Count) { $o.Root = [pscustomobject]@{} } else { $o.Root = @() } }
        $node = $o.Root
        foreach ($s in $segments) {
            if ($null -eq $node) { break }
            if (-not ($node -is [Management.Automation.PSCustomObject])) { throw "$($Spec.target): not a JSON object above '$($Spec.arrayPath)'" }
            $node = Get-Prop $node $s
        }
        if ($null -ne $node) {
            if ($node -is [string] -or $node -is [Management.Automation.PSCustomObject] -or -not ($node -is [Collections.IEnumerable])) { throw "$($Spec.target): '$($Spec.arrayPath)' is not a JSON array" }
            $o.Items = @($node)
        }
        $o.Keys = @($o.Items | ForEach-Object { Get-EntryKey $Spec $_ })
        return [pscustomobject]$o
    }
    $v = Read-RegistryValue $Spec.target $Spec.valueName
    $lines = @()
    if ($v.Data -is [array]) { $lines = @($v.Data | ForEach-Object { [string]$_ }) }
    elseif ($null -ne $v.Data) {
        $lines = @(([string]$v.Data) -split "`n")
        if ($lines.Count -and $lines[-1] -eq '') { $lines = @($lines | Select-Object -First ($lines.Count - 1)) }
    }
    $records = @()
    for ($i = 0; $i -lt $lines.Count; $i += $Spec.recordLines) {
        $last = [Math]::Min($i + $Spec.recordLines, $lines.Count) - 1
        $records += , ((@($lines[$i..$last])) -join "`n")
    }
    return [pscustomobject]@{ Exists = $v.Exists; Kind = $v.Kind; Snapshot = $v.Data; Items = $records; Keys = $records }
}

function Format-Store($Spec, $Read, [object[]]$Items) {
    # -> what a write puts back: bytes for a JSON file, the value data for a registry value
    if ($Spec.store -eq 'json') {
        $segments = @($Spec.arrayPath -split '\.' | Where-Object { $_ })
        $root = $Read.Root
        if ($segments.Count -eq 0) { $root = $Items }
        else {
            $node = $root
            for ($i = 0; $i -lt $segments.Count; $i++) {
                $s = $segments[$i]
                if ($i -eq $segments.Count - 1) {
                    if ($node.PSObject.Properties[$s]) { $node.$s = $Items } else { $node | Add-Member -NotePropertyName $s -NotePropertyValue $Items }
                    break
                }
                $next = Get-Prop $node $s
                if ($null -eq $next) { $next = [pscustomobject]@{}; $node | Add-Member -NotePropertyName $s -NotePropertyValue $next }
                $node = $next
            }
        }
        $text = (ConvertTo-JsonText $root $true $false $false) -replace "`n", $Read.Newline
        if ($Read.Trailing) { $text += $Read.Newline }
        $bytes = $script:Utf8.GetBytes($text)
        if ($Read.Bom) { $bytes = [byte[]](@(0xEF, 0xBB, 0xBF) + $bytes) }
        return , $bytes
    }
    $lines = @(@($Items) | ForEach-Object { ([string]$_) -split "`n" })
    if ($Read.Kind -eq 'MultiString') { return , ([string[]]$lines) }
    return ((@($lines) | ForEach-Object { $_ + "`n" }) -join '')
}

function Write-Store($Spec, $Read, $Data) {
    if ($Spec.store -eq 'json') { [IO.File]::WriteAllBytes($Spec.target, [byte[]]$Data); return }
    $kind = $Read.Kind
    if ($kind -ne 'MultiString' -and $kind -ne 'ExpandString') { $kind = 'String' }
    Write-RegistryValue $Spec.target $Spec.valueName $kind $Data
}

function Get-StoreSnapshot($Spec) {
    if ($Spec.store -eq 'json') { if ([IO.File]::Exists($Spec.target)) { return (Get-FileHashHex $Spec.target) } return $null }
    return (Read-RegistryValue $Spec.target $Spec.valueName).Data
}

function Test-SameSnapshot($A, $B) {
    if ($null -eq $A -or $null -eq $B) { return ($null -eq $A -and $null -eq $B) }
    return ((@($A) -join "`n") -ceq (@($B) -join "`n"))
}

function Restore-StoreExact($Spec, $Rec) {
    # puts back the exact bytes / value from before the change
    if ($Spec.store -eq 'json') {
        if ($Rec.fileCreated) { [IO.File]::Delete($Spec.target); return }
        [IO.File]::Copy([string]$Rec.backup, $Spec.target, $true)
        Remove-Backup $Rec.backup
        return
    }
    if ($null -eq $Rec.before) { Remove-RegistryValue $Spec.target $Spec.valueName; return }
    $kind = [string]$Rec.kind
    if (-not $kind) { $kind = 'String' }
    Write-RegistryValue $Spec.target $Spec.valueName $kind $Rec.before
}

function Invoke-EntryChange($Cmdlet, [string]$Journal, [string]$Action, $Spec, $Entry, [bool]$Keep, [string]$Id) {
    $key = Get-EntryKey $Spec $Entry
    if (-not $Id) { $Id = $Action + ':' + $Spec.locator + ':' + (Get-HexHash ($script:Utf8.GetBytes($key))).Substring(0, 16) }
    $label = $Spec.target
    if ($Spec.store -eq 'json') { $label += '#' + $Spec.arrayPath } else { $label += '\' + $Spec.valueName }
    $rec = Find-ActiveRecord $Journal $Id
    $read = Read-Store $Spec
    $index = [array]::IndexOf([string[]]@($read.Keys), $key)
    $adding = ($Action -eq 'entry-add')
    $recKey = $null
    if ($rec) { $recKey = Get-EntryKey $Spec $rec.entry }
    $inPlace = ($adding -and $index -ge 0) -or (-not $adding -and $index -lt 0)
    if ($rec -and -not $adding -and $recKey -ne $key) { throw "another entry was removed under the id '$Id'; give this removal its own -Id" }
    if ($rec -and $recKey -eq $key -and $inPlace) { return (New-Result $Action $label 'skipped' $rec.seq) }
    if ($inPlace -and (-not $rec -or -not $adding)) {
        $why = 'already there, not added by this journal'
        if (-not $adding) { $why = 'not there, nothing to remove' }
        return (New-Result $Action $label 'present' $null $why)
    }
    if (-not $Cmdlet.ShouldProcess($label, "$Action " + ($key -replace "`n", ' | '))) { return (New-Result $Action $label 'whatif') }

    # the new list
    $items = New-Object Collections.Generic.List[object]
    foreach ($it in @($read.Items)) { $items.Add($it) }
    $status = 'done'
    $carry = $false
    if ($rec) {
        $status = 'repaired'
        if ($recKey -ne $key) {
            $status = 'updated'
            # the entry this journal added before (an older definition under the same id) goes
            $old = [array]::IndexOf([string[]]@($read.Keys), $recKey)
            if ($adding -and $old -ge 0) { $items.RemoveAt($old) }
        }
        # the old line's exact-restore point is still valid only if nobody touched the list since
        $carry = [bool]$rec.exact -and (Test-SameSnapshot $read.Snapshot $rec.after)
    }
    $position = $index
    if ($adding) {
        $listedNow = @($items | ForEach-Object { Get-EntryKey $Spec $_ })
        if ([array]::IndexOf([string[]]$listedNow, $key) -lt 0) { $items.Add($Entry) }
    } else {
        $items.RemoveAt($index)
    }
    $data = Format-Store $Spec $read ($items.ToArray())

    $fields = [ordered]@{ id = $Id; target = $Spec.target; keep = $Keep; store = $Spec.store }
    if ($Spec.store -eq 'json') { $fields.arrayPath = $Spec.arrayPath } else { $fields.valueName = $Spec.valueName; $fields.recordLines = $Spec.recordLines; $fields.kind = $read.Kind }
    $fields.entry = $Entry
    if (-not $adding) { $fields.index = $position }
    if ($rec) { $fields.supersedes = $rec.seq }
    $fields.exact = $true
    $backup = $null
    $dropAfter = $null
    if ($carry) {
        $fields.before = $rec.before; $fields.fileCreated = [bool]$rec.fileCreated; $fields.backup = $rec.backup
    } else {
        if ($rec) { $dropAfter = $rec.backup }
        if ($Spec.store -eq 'json') {
            $fields.before = $read.Snapshot
            $fields.fileCreated = -not $read.Exists
            if ($read.Exists) { $backup = Save-Backup $Journal $Spec.target }
            $fields.backup = $backup
        } else {
            $fields.before = $read.Snapshot
        }
    }
    if ($Spec.store -eq 'json') { $fields.after = Get-HexHash ([byte[]]$data) } else { $fields.after = $data }
    if ($Spec.store -eq 'json' -and -not $read.Exists) { Initialize-Parent $Cmdlet $Journal $Spec.target $Keep }
    $seq = Add-JournalLine $Journal $Action $fields
    try { Write-Store $Spec $read $data } catch { Add-NotApplied $Journal $seq $_; Remove-Backup $backup; throw }
    Remove-Backup $dropAfter
    return (New-Result $Action $label $status $seq)
}

function Add-JournalEntry {
    <#
    .SYNOPSIS
    Adds one entry to a list another program owns (a hook entry): an array inside a JSON file
    (-JsonFile, -ArrayPath 'a.b.c', created when missing) or the records of a registry value
    (-RegistryKey, -ValueName, -RecordLines; UNTESTED against the real registry). Undo removes
    exactly that entry; when nobody touched the list since, the exact previous bytes come back.
    With -Id, a new -Entry under the same id replaces the one this journal added before.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Json')]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true, ParameterSetName = 'Json')][string]$JsonFile,
        [Parameter(ParameterSetName = 'Json')][AllowEmptyString()][string]$ArrayPath = '',
        [Parameter(Mandatory = $true, ParameterSetName = 'Registry')][string]$RegistryKey,
        [Parameter(Mandatory = $true, ParameterSetName = 'Registry')][string]$ValueName,
        [Parameter(ParameterSetName = 'Registry')][int]$RecordLines = 1,
        [Parameter(Mandatory = $true)]$Entry,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $spec = Get-StoreSpec $PSCmdlet $PSCmdlet.ParameterSetName $JsonFile $ArrayPath $RegistryKey $ValueName $RecordLines
    if ($spec.store -eq 'registry') { $Entry = (@($Entry) | ForEach-Object { [string]$_ }) -join "`n" }
    Invoke-EntryChange $PSCmdlet (Resolve-FullPath $PSCmdlet $Journal) 'entry-add' $spec $Entry ([bool]$Keep) $Id
}

function Remove-JournalEntry {
    <#
    .SYNOPSIS
    Removes one existing entry from such a list - typically the entry of an older tool that the
    new one supersedes. Undo puts it back at the position it had.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Json')]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [Parameter(Mandatory = $true, ParameterSetName = 'Json')][string]$JsonFile,
        [Parameter(ParameterSetName = 'Json')][AllowEmptyString()][string]$ArrayPath = '',
        [Parameter(Mandatory = $true, ParameterSetName = 'Registry')][string]$RegistryKey,
        [Parameter(Mandatory = $true, ParameterSetName = 'Registry')][string]$ValueName,
        [Parameter(ParameterSetName = 'Registry')][int]$RecordLines = 1,
        [Parameter(Mandatory = $true)]$Entry,
        [switch]$Keep,
        [string]$Id = ''
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $spec = Get-StoreSpec $PSCmdlet $PSCmdlet.ParameterSetName $JsonFile $ArrayPath $RegistryKey $ValueName $RecordLines
    if ($spec.store -eq 'registry') { $Entry = (@($Entry) | ForEach-Object { [string]$_ }) -join "`n" }
    Invoke-EntryChange $PSCmdlet (Resolve-FullPath $PSCmdlet $Journal) 'entry-remove' $spec $Entry ([bool]$Keep) $Id
}

# ======================================================================== state and undo

function Get-RecordState($Rec) {
    # 'installed' (in place, as recorded) | 'changed' (someone changed it since) | 'missing'
    $t = [string]$Rec.target
    switch ([string]$Rec.action) {
        { $_ -eq 'file-create' -or $_ -eq 'file-replace' } {
            $k = Get-PathKind $t
            if ($k -eq 'absent') { return 'missing' }
            if ($k -ne 'file') { return 'changed' }
            if ((Get-FileHashHex $t) -eq $Rec.sha256) { return 'installed' }
            return 'changed'
        }
        'folder-create' {
            $k = Get-PathKind $t
            if ($k -eq 'absent') { return 'missing' }
            if ($k -eq 'dir') { return 'installed' }
            return 'changed'
        }
        'link-create' {
            $k = Get-PathKind $t
            if ($k -eq 'absent') { return 'missing' }
            if ($k -eq 'link' -and (Get-NormKey (Get-LinkTargetPath $t)) -eq (Get-NormKey ([string]$Rec.linkTarget))) { return 'installed' }
            return 'changed'
        }
        'env-set' {
            $cur = [Environment]::GetEnvironmentVariable($t, [string]$Rec.scope)
            if ($cur -ceq [string]$Rec.value) { return 'installed' }
            if ($null -eq $cur -or $cur -ceq (Get-Prop $Rec 'before')) { return 'missing' }
            return 'changed'
        }
        'task-register' { if ((Get-TaskState $t) -eq 'missing') { return 'missing' } return 'installed' }
        'task-disable' { if ((Get-TaskState $t) -eq 'disabled') { return 'installed' } return 'missing' }
        { $_ -eq 'entry-add' -or $_ -eq 'entry-remove' } {
            $spec = Get-SpecFromRecord $Rec
            $listed = [array]::IndexOf([string[]]@((Read-Store $spec).Keys), (Get-EntryKey $spec $Rec.entry)) -ge 0
            if (($Rec.action -eq 'entry-add') -eq $listed) { return 'installed' }
            return 'missing'
        }
    }
    return 'unknown'
}

function Undo-Record($Rec) {
    # -> @(result, note); result: reverted | kept | gone. Throws on failure.
    $t = [string]$Rec.target
    switch ([string]$Rec.action) {
        'file-create' {
            $k = Get-PathKind $t
            if ($k -eq 'absent') { return @('gone', 'already absent') }
            if ($k -ne 'file') { return @('kept', "a $k is there now; never followed") }
            if ((Get-FileHashHex $t) -ne $Rec.sha256) { return @('kept', 'changed since this journal created it') }
            [IO.File]::Delete($t)
            return @('reverted', 'deleted')
        }
        'file-replace' {
            $k = Get-PathKind $t
            if ($k -eq 'link' -or $k -eq 'dir') { return @('kept', "a $k is there now; the backup stays at $($Rec.backup)") }
            if ($k -eq 'file') {
                $h = Get-FileHashHex $t
                if ($h -eq $Rec.sha256Before) { Remove-Backup $Rec.backup; return @('gone', 'the previous content is already there') }
                if ($h -ne $Rec.sha256) { return @('kept', "changed since this journal replaced it; the previous version stays at $($Rec.backup)") }
            }
            if (-not [IO.File]::Exists([string]$Rec.backup)) { throw "backup missing, cannot restore: $($Rec.backup)" }
            [IO.File]::Copy([string]$Rec.backup, $t, $true)
            if ((Get-FileHashHex $t) -ne $Rec.sha256Before) { throw "restored file does not match the recorded hash: $t (backup kept at $($Rec.backup))" }
            Remove-Backup $Rec.backup
            return @('reverted', 'previous version restored')
        }
        'folder-create' {
            $k = Get-PathKind $t
            if ($k -eq 'absent') { return @('gone', 'already absent') }
            if ($k -ne 'dir') { return @('kept', "a $k is there now; never followed") }
            $n = @(Get-ChildItem -LiteralPath $t -Force).Count
            if ($n -gt 0) { return @('kept', "not empty ($n item(s))") }
            [IO.Directory]::Delete($t)
            return @('reverted', 'removed (it was empty)')
        }
        'link-create' {
            $k = Get-PathKind $t
            if ($k -eq 'absent') { return @('gone', 'already absent') }
            if ($k -ne 'link') { return @('kept', "a real $k is there now") }
            if ((Get-NormKey (Get-LinkTargetPath $t)) -ne (Get-NormKey ([string]$Rec.linkTarget))) { return @('kept', 're-pointed since this journal created it') }
            Remove-LinkPointer $t
            return @('reverted', "link removed; target untouched: $($Rec.linkTarget)")
        }
        'env-set' {
            $scope = [string]$Rec.scope
            $cur = [Environment]::GetEnvironmentVariable($t, $scope)
            $before = Get-Prop $Rec 'before'
            if ($cur -ceq [string]$Rec.value -or ($null -eq $cur -and $null -ne $before)) {
                [Environment]::SetEnvironmentVariable($t, $before, $scope)
                if ($null -eq $before) { return @('reverted', 'removed (it did not exist before)') }
                return @('reverted', 'previous value restored')
            }
            if ($cur -ceq $before) { return @('gone', 'already at the previous value') }
            return @('kept', 'another value was set since')
        }
        'task-register' {
            if ((Get-TaskState $t) -eq 'missing') { return @('gone', 'already absent') }
            Invoke-TaskChecked @('/Delete', '/TN', $t, '/F')
            return @('reverted', 'unregistered')
        }
        'task-disable' {
            $s = Get-TaskState $t
            if ($s -ne 'disabled') { return @('gone', "the task is $s") }
            Invoke-TaskChecked @('/Change', '/TN', $t, '/ENABLE')
            return @('reverted', 'enabled again')
        }
        { $_ -eq 'entry-add' -or $_ -eq 'entry-remove' } {
            $spec = Get-SpecFromRecord $Rec
            $adding = ($Rec.action -eq 'entry-add')
            if ($spec.store -eq 'json' -and -not [IO.File]::Exists($spec.target)) { return @('gone', 'the file is gone') }
            $snap = Get-StoreSnapshot $spec
            if ([bool]$Rec.exact -and (Test-SameSnapshot $snap $Rec.after)) {
                Restore-StoreExact $spec $Rec
                return @('reverted', 'untouched since: exact previous content restored')
            }
            if ([bool]$Rec.exact -and -not [bool]$Rec.fileCreated -and (Test-SameSnapshot $snap $Rec.before)) {
                Remove-Backup $Rec.backup
                return @('gone', 'the previous content is already there')
            }
            $read = Read-Store $spec
            $key = Get-EntryKey $spec $Rec.entry
            $index = [array]::IndexOf([string[]]@($read.Keys), $key)
            $items = New-Object Collections.Generic.List[object]
            foreach ($it in @($read.Items)) { $items.Add($it) }
            if ($adding) {
                if ($index -lt 0) { Remove-Backup $Rec.backup; return @('gone', 'entry not found as written (removed or edited since)') }
                $items.RemoveAt($index)
            } else {
                if ($index -ge 0) { Remove-Backup $Rec.backup; return @('gone', 'the entry is already back') }
                $items.Insert([Math]::Min([int]$Rec.index, $items.Count), $Rec.entry)
            }
            Write-Store $spec $read (Format-Store $spec $read ($items.ToArray()))
            Remove-Backup $Rec.backup
            return @('reverted', 'list changed since: only this entry was touched')
        }
    }
    throw "unknown action '$($Rec.action)' (journal schema newer than this module?)"
}

function Get-JournalStatus {
    <#
    .SYNOPSIS
    Lists what a journal has installed: one object per active line, with the live state of the
    machine (installed | changed | missing). Nothing installed (or no journal): no output.
    #>
    [CmdletBinding()]
    param([Parameter(Mandatory = $true)][string]$Journal)
    $j = Resolve-FullPath $PSCmdlet $Journal
    foreach ($r in (Read-JournalState $j).Active) {
        $state = 'unknown'
        try { $state = Get-RecordState $r } catch { $state = 'error: ' + $_.Exception.Message }
        [pscustomobject]@{ Seq = [int]$r.seq; Action = [string]$r.action; Target = [string]$r.target; State = $state; Keep = [bool](Get-Prop $r 'keep'); Time = [string]$r.time }
    }
}

function Undo-Journal {
    <#
    .SYNOPSIS
    Reverses every active line of a journal, newest first, and returns one result per line
    (reverted | kept | gone | retained | failed | whatif). Stops at the first failure with a
    report (or goes on with -ContinueOnError); a later run resumes, because every undone line is
    marked in the journal. When nothing is left, the journal is renamed <journal>.undone-<stamp>.
    Lines recorded with -Keep are retained unless -Purge.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)][string]$Journal,
        [switch]$ContinueOnError,
        [switch]$Purge
    )
    Use-CallerWhatIf $PSCmdlet $PSBoundParameters
    $j = Resolve-FullPath $PSCmdlet $Journal
    $state = Read-JournalState $j
    $todo = @($state.Active | Sort-Object { [int]$_.seq } -Descending)
    if ($todo.Count -eq 0) { Write-Verbose "nothing installed by $j"; return }
    $failed = New-Object Collections.Generic.List[object]
    $done = 0
    foreach ($r in $todo) {
        $action = [string]$r.action
        $target = [string]$r.target
        if ([bool](Get-Prop $r 'keep') -and -not $Purge) {
            if ($PSCmdlet.ShouldProcess($target, "retain $action (-Keep; -Purge reverts it)")) {
                [void](Add-JournalLine $j 'undone' ([ordered]@{ ref = $r.seq; result = 'retained' }))
                $done++
                New-Result $action $target 'retained' $r.seq 'recorded with -Keep; -Purge reverts it'
            } else { New-Result $action $target 'whatif' $r.seq 'would be retained (-Keep)' }
            continue
        }
        if (-not $PSCmdlet.ShouldProcess($target, "undo $action")) {
            $now = 'unknown'
            try { $now = Get-RecordState $r } catch { }
            New-Result $action $target 'whatif' $r.seq "state now: $now"
            continue
        }
        try {
            $res = Undo-Record $r
            [void](Add-JournalLine $j 'undone' ([ordered]@{ ref = $r.seq; result = $res[0] }))
            $done++
            if ($res[0] -eq 'kept') { Write-Warning "$action ${target}: $($res[1]) - kept" }
            New-Result $action $target $res[0] $r.seq $res[1]
        } catch {
            $failed.Add([pscustomobject]@{ Seq = $r.seq; Action = $action; Target = $target; Error = $_.Exception.Message })
            New-Result $action $target 'failed' $r.seq $_.Exception.Message
            if (-not $ContinueOnError) { break }
        }
    }
    if ($WhatIfPreference) { return }
    $left = @((Read-JournalState $j).Active)
    if ($failed.Count -gt 0) {
        $first = $failed[0]
        $how = 'stopped at'
        if ($ContinueOnError) { $how = "$($failed.Count) failure(s), first at" }
        $msg = "Undo of $j $how line $($first.Seq) ($($first.Action) $($first.Target)): $($first.Error). " +
            "Undone now: $done; still installed: $($left.Count) (lines $((@($left | ForEach-Object { $_.seq }) -join ', '))). " +
            'Fix the cause and run Undo-Journal again: it resumes where it stopped.'
        Write-Error -Message $msg -Category OperationStopped
        return
    }
    if ($left.Count -eq 0) {
        $stamp = (Get-Date).ToString('yyyyMMdd-HHmmss-fff', $script:Inv)
        [IO.File]::Move($j, "$j.undone-$stamp")
        $bdir = $j + '.backup'
        if ([IO.Directory]::Exists($bdir)) {
            if (@(Get-ChildItem -LiteralPath $bdir -Force).Count -eq 0) { [IO.Directory]::Delete($bdir) }
            else { Write-Warning "backups of files that were kept stay in $bdir" }
        }
        Write-Verbose "journal closed: $j.undone-$stamp"
    }
}

Export-ModuleMember -Function New-JournalFile, Set-JournalFile, New-JournalFolder, New-JournalLink, Set-JournalEnvironment,
    Register-JournalTask, Disable-JournalTask, Add-JournalEntry, Remove-JournalEntry, Get-JournalStatus, Undo-Journal
