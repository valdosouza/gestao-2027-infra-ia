# guard-common.ps1 - shared helpers of the engine-kit guards (runtime layer 2).
#
# Dot-sourced by encoding-guard.ps1, revert-guard.ps1 and hook.ps1; it does nothing on
# its own. ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source.
#
# What lives here:
#   - project config: .engine-kit/guards.json found by walking up from a path
#   - VCS adapter: git and svn behind one small set of functions (detection by walking
#     up for .git / .svn, then `git rev-parse` / `svn info`). READ operations only:
#     status, diff, blame, log, show/cat. Nothing here ever writes to a repository.
#   - native process runner that keeps raw bytes (no console re-encoding)
#   - ASCII-only JSON writer for hook output (non-ASCII is escaped as \uXXXX, so the
#     console code page can never mangle a message)

$script:GuardConfigRel = '.engine-kit' + [System.IO.Path]::DirectorySeparatorChar + 'guards.json'

# ---------------------------------------------------------------- stdin / JSON out

function Read-StdinUtf8 {
    # Raw bytes decoded as UTF-8: [Console]::In would decode with the OEM code page and
    # break any non-ASCII path in the hook payload.
    $stream = [Console]::OpenStandardInput()
    $ms = New-Object System.IO.MemoryStream
    $stream.CopyTo($ms)
    $bytes = $ms.ToArray()
    $start = 0
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) { $start = 3 }
    return [System.Text.Encoding]::UTF8.GetString($bytes, $start, $bytes.Length - $start)
}

function ConvertTo-JsonString([string]$s) {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append('"')
    foreach ($ch in $s.ToCharArray()) {
        $c = [int]$ch
        if ($c -eq 34) { [void]$sb.Append('\"') }
        elseif ($c -eq 92) { [void]$sb.Append('\\') }
        elseif ($c -eq 10) { [void]$sb.Append('\n') }
        elseif ($c -eq 13) { [void]$sb.Append('\r') }
        elseif ($c -eq 9) { [void]$sb.Append('\t') }
        elseif ($c -lt 32 -or $c -gt 126) { [void]$sb.Append(('\u{0:x4}' -f $c)) }
        else { [void]$sb.Append($ch) }
    }
    [void]$sb.Append('"')
    return $sb.ToString()
}

function ConvertTo-JsonAscii($obj) {
    if ($obj -is [System.Collections.IDictionary]) {
        $parts = @()
        foreach ($k in $obj.Keys) { $parts += (ConvertTo-JsonString ([string]$k)) + ':' + (ConvertTo-JsonAscii $obj[$k]) }
        return '{' + ($parts -join ',') + '}'
    }
    if ($obj -is [bool]) { if ($obj) { return 'true' } else { return 'false' } }
    return (ConvertTo-JsonString ([string]$obj))
}

function Write-HookJson($obj) {
    [Console]::Out.Write((ConvertTo-JsonAscii $obj))
    [Console]::Out.Flush()
}

# ---------------------------------------------------------------- paths

function Find-UpDir([string]$Start, [scriptblock]$Test) {
    # Walks from $Start (a file or a folder) up to the filesystem root; returns the first
    # folder for which $Test returns true, or $null.
    if (-not $Start) { return $null }
    try { $d = [System.IO.Path]::GetFullPath($Start) } catch { return $null }
    while ($d) {
        if (& $Test $d) { return $d }
        $parent = [System.IO.Path]::GetDirectoryName($d)
        if (-not $parent -or $parent -eq $d) { break }
        $d = $parent
    }
    return $null
}

function Find-GuardConfig([string]$Start) {
    $root = Find-UpDir $Start { param($d) Test-Path -LiteralPath (Join-Path $d $script:GuardConfigRel) -PathType Leaf }
    if ($root) { return (Join-Path $root $script:GuardConfigRel) }
    return $null
}

function Read-GuardConfig([string]$Path) {
    # Throws on invalid JSON; the caller decides how loud to be.
    $raw = [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
    return ($raw | ConvertFrom-Json)
}

function Get-Cfg($obj, [string]$Name, $Default) {
    if ($null -eq $obj) { return $Default }
    $p = $obj.PSObject.Properties[$Name]
    if ($null -eq $p -or $null -eq $p.Value) { return $Default }
    return $p.Value
}

function Get-GuardSection($cfg, [string]$Name) {
    # A guard runs when its section is present and "enabled" is not false.
    $sec = Get-Cfg $cfg $Name $null
    if ($null -eq $sec) { return $null }
    if ((Get-Cfg $sec 'enabled' $true) -eq $false) { return $null }
    return $sec
}

function Get-RelPath([string]$Root, [string]$Full) {
    $r = [System.IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
    $f = [System.IO.Path]::GetFullPath($Full)
    if ($f.Length -gt $r.Length -and $f.StartsWith($r, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $f.Substring($r.Length).TrimStart('\', '/').Replace('\', '/')
    }
    return $f.Replace('\', '/')
}

# ---------------------------------------------------------------- native processes

function ConvertTo-ArgString([string[]]$ArgList) {
    # Windows command-line quoting (CommandLineToArgvW rules); .NET applies the same rules
    # when it splits the string on macOS / Linux.
    $out = @()
    foreach ($a in $ArgList) {
        if ($a -eq '') { $out += '""'; continue }
        if ($a -notmatch '[\s"]') { $out += $a; continue }
        $s = [regex]::Replace($a, '(\\*)"', { param($m) ($m.Groups[1].Value * 2) + '\"' })
        $s = [regex]::Replace($s, '(\\+)$', { param($m) $m.Groups[1].Value * 2 })
        $out += '"' + $s + '"'
    }
    return ($out -join ' ')
}

function Invoke-Native {
    # Runs a command and returns ExitCode, raw stdout Bytes, stdout Text (UTF-8) and Error.
    # A PowerShell pipeline would re-encode native output with the console code page; this
    # keeps the bytes. Stdin is closed so a tool can never wait for input.
    param([string]$Exe, [string[]]$ArgList = @(), [string]$WorkDir = '')
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $Exe
    $psi.Arguments = ConvertTo-ArgString $ArgList
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.RedirectStandardInput = $true
    $psi.CreateNoWindow = $true
    if ($WorkDir) { $psi.WorkingDirectory = $WorkDir }
    try { $p = [System.Diagnostics.Process]::Start($psi) }
    catch { return [pscustomobject]@{ ExitCode = -1; Bytes = [byte[]]@(); Text = ''; Error = $_.Exception.Message } }
    $p.StandardInput.Close()
    $errTask = $p.StandardError.ReadToEndAsync()
    $ms = New-Object System.IO.MemoryStream
    $p.StandardOutput.BaseStream.CopyTo($ms)
    $p.WaitForExit()
    $bytes = $ms.ToArray()
    return [pscustomobject]@{
        ExitCode = $p.ExitCode
        Bytes    = $bytes
        Text     = [System.Text.Encoding]::UTF8.GetString($bytes)
        Error    = $errTask.Result
    }
}

function Split-Lines([string]$Text) {
    if (-not $Text) { return @() }
    return @($Text -split "`n" | ForEach-Object { $_.TrimEnd("`r") })
}

# ---------------------------------------------------------------- VCS adapter (read-only)

function Get-VcsInfo([string]$Start, [string]$Prefer = '') {
    # Returns @{ Kind = 'git'|'svn'; Root = <working copy root> } or $null.
    # Nearest marker wins; -Prefer breaks the tie when one folder sits in both.
    $git = Find-UpDir $Start { param($d) Test-Path -LiteralPath (Join-Path $d '.git') }
    $svn = Find-UpDir $Start { param($d) Test-Path -LiteralPath (Join-Path $d '.svn') -PathType Container }
    if (-not $git -and -not $svn) {
        $dir = $Start
        if (-not (Test-Path -LiteralPath $dir -PathType Container)) { $dir = [System.IO.Path]::GetDirectoryName($Start) }
        if ($dir -and (Test-Path -LiteralPath $dir -PathType Container)) {
            $r = Invoke-Native 'git' @('rev-parse', '--show-toplevel') $dir
            if ($r.ExitCode -eq 0 -and $r.Text.Trim()) { $git = [System.IO.Path]::GetFullPath($r.Text.Trim()) }
            else {
                $r = Invoke-Native 'svn' @('info', '--show-item', 'wc-root', '--non-interactive', $dir)
                if ($r.ExitCode -eq 0 -and $r.Text.Trim()) { $svn = [System.IO.Path]::GetFullPath($r.Text.Trim()) }
            }
        }
    }
    if ($git -and $svn) {
        if ($Prefer -eq 'git') { $svn = $null }
        elseif ($Prefer -eq 'svn') { $git = $null }
        elseif ($git.Length -ge $svn.Length) { $svn = $null }
        else { $git = $null }
    }
    if ($git) { return @{ Kind = 'git'; Root = $git } }
    if ($svn) { return @{ Kind = 'svn'; Root = $svn } }
    return $null
}

function Test-GitHasHead($Vcs) {
    $r = Invoke-Native 'git' @('rev-parse', '--verify', '-q', 'HEAD') $Vcs.Root
    return ($r.ExitCode -eq 0)
}

function Get-VcsChangedFiles($Vcs, [string]$Scope, [string[]]$Kinds) {
    # Files that the next commit would carry, as full paths.
    #   git: every tracked file that differs from HEAD, staged or not (the same command
    #        often stages them: `git add ... && git commit`); untracked files are not
    #        included, like svn's unversioned '?' entries. Whole repository.
    #   svn: `svn status` under $Scope (the folder the commit runs in).
    # $Kinds: any of 'modified', 'added', 'replaced'.
    $result = @()
    if ($Vcs.Kind -eq 'git') {
        $filter = ''
        if ($Kinds -contains 'added') { $filter += 'A' }
        if ($Kinds -contains 'modified' -or $Kinds -contains 'replaced') { $filter += 'M' }
        if (-not $filter) { return @() }
        if (Test-GitHasHead $Vcs) {
            $r = Invoke-Native 'git' @('-c', 'core.quotepath=off', 'diff', 'HEAD', '--name-only', '-z', '--no-renames', "--diff-filter=$filter") $Vcs.Root
        } elseif ($filter -match 'A') {
            $r = Invoke-Native 'git' @('-c', 'core.quotepath=off', 'diff', '--cached', '--name-only', '-z', '--diff-filter=A') $Vcs.Root
        } else { return @() }
        if ($r.ExitCode -ne 0) { return @() }
        foreach ($rel in ($r.Text -split "`0")) {
            if ($rel) { $result += [System.IO.Path]::GetFullPath((Join-Path $Vcs.Root $rel)) }
        }
        return $result
    }
    if (-not $Scope) { $Scope = $Vcs.Root }
    $r = Invoke-Native 'svn' @('status', '--xml', '--non-interactive', $Scope)
    if ($r.ExitCode -ne 0) { return @() }
    try { [xml]$x = $r.Text } catch { return @() }
    foreach ($e in $x.SelectNodes('//entry')) {
        $ws = $e.SelectSingleNode('wc-status')
        if (-not $ws) { continue }
        if ($Kinds -notcontains $ws.GetAttribute('item')) { continue }
        $p = $e.GetAttribute('path')
        if (-not [System.IO.Path]::IsPathRooted($p)) { $p = Join-Path $Scope $p }
        $result += [System.IO.Path]::GetFullPath($p)
    }
    return $result
}

function Get-VcsBaseBytes($Vcs, [string]$File) {
    # Raw bytes of the base revision (git: HEAD, svn: BASE); $null for a file that is
    # new in this change.
    if ($Vcs.Kind -eq 'git') {
        $r = Invoke-Native 'git' @('show', ('HEAD:' + (Get-RelPath $Vcs.Root $File))) $Vcs.Root
    } else {
        $r = Invoke-Native 'svn' @('cat', '-r', 'BASE', '--non-interactive', $File)
    }
    if ($r.ExitCode -ne 0) { return $null }
    return , $r.Bytes
}

function Get-VcsRemovedLines($Vcs, [string]$File) {
    # Line numbers (in the base revision) of the lines the local change removes.
    if ($Vcs.Kind -eq 'git') {
        $r = Invoke-Native 'git' @('diff', '--no-ext-diff', '--no-color', '-U0', 'HEAD', '--', (Get-RelPath $Vcs.Root $File)) $Vcs.Root
    } else {
        $r = Invoke-Native 'svn' @('diff', '--internal-diff', '--non-interactive', $File)
    }
    if ($r.ExitCode -ne 0) { return @() }
    $removed = @()
    $inHunk = $false
    $old = 0
    foreach ($line in (Split-Lines $r.Text)) {
        if ($line -match '^@@ -(\d+)') { $inHunk = $true; $old = [int]$Matches[1]; continue }
        if ($line -match '^Property changes on: ') { break }        # svn property section
        if (-not $inHunk) { continue }                               # headers, incl. a '--- x' file line
        if ($line.StartsWith('\')) { continue }                     # "\ No newline at end of file"
        if ($line.StartsWith('-')) { $removed += $old; $old++ }
        elseif ($line.StartsWith('+')) { }
        else { $old++ }
    }
    return $removed
}

function Get-VcsLineOrigins($Vcs, [string]$File, [int[]]$Lines) {
    # base line number -> @{ Rev; Label; Author; Date (local time) }
    $map = @{}
    if (-not $Lines -or $Lines.Count -eq 0) { return $map }
    if ($Vcs.Kind -eq 'git') {
        $argList = @('blame', '--line-porcelain')
        $sorted = @($Lines | Sort-Object -Unique)
        $a = $sorted[0]; $b = $a
        foreach ($n in (@($sorted | Select-Object -Skip 1) + @(-1))) {
            if ($n -eq $b + 1) { $b = $n; continue }
            $argList += @('-L', "$a,$b")
            $a = $n; $b = $n
        }
        $argList += @('HEAD', '--', (Get-RelPath $Vcs.Root $File))
        $r = Invoke-Native 'git' $argList $Vcs.Root
        if ($r.ExitCode -ne 0) { return $map }
        $cur = $null
        foreach ($line in (Split-Lines $r.Text)) {
            if ($line -match '^([0-9a-f]{40,64}) \d+ (\d+)') {
                $cur = @{ Rev = $Matches[1]; Label = $Matches[1].Substring(0, 8); Author = ''; Date = $null; Line = [int]$Matches[2] }
                continue
            }
            if ($null -eq $cur) { continue }
            if ($line.StartsWith("`t")) { $map[$cur.Line] = $cur; $cur = $null; continue }
            if ($line -match '^author (.*)$') { $cur.Author = $Matches[1] }
            elseif ($line -match '^committer-time (\d+)') {
                $cur.Date = [DateTimeOffset]::FromUnixTimeSeconds([long]$Matches[1]).LocalDateTime
            }
        }
        return $map
    }
    $r = Invoke-Native 'svn' @('blame', '--xml', '-r', 'BASE', '--non-interactive', $File)
    if ($r.ExitCode -ne 0) { return $map }
    try { [xml]$x = $r.Text } catch { return $map }
    $want = @{}
    foreach ($n in $Lines) { $want[$n] = $true }
    foreach ($e in $x.SelectNodes('//entry')) {
        $n = [int]$e.GetAttribute('line-number')
        if (-not $want.ContainsKey($n)) { continue }
        $c = $e.SelectSingleNode('commit')
        if (-not $c) { continue }
        $rev = $c.GetAttribute('revision')
        $au = $c.SelectSingleNode('author'); $dt = $c.SelectSingleNode('date')
        $date = $null
        if ($dt) { $date = [datetime]::Parse($dt.InnerText, [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::RoundtripKind).ToLocalTime() }
        $map[$n] = @{ Rev = $rev; Label = "r$rev"; Author = $(if ($au) { $au.InnerText } else { '' }); Date = $date; Line = $n }
    }
    return $map
}

function Get-VcsMessage($Vcs, [string]$File, [string]$Rev) {
    if ($Vcs.Kind -eq 'git') {
        $r = Invoke-Native 'git' @('log', '-1', '--format=%B', $Rev) $Vcs.Root
        if ($r.ExitCode -ne 0) { return '' }
        return $r.Text
    }
    $r = Invoke-Native 'svn' @('log', '--xml', '-r', $Rev, '--non-interactive', $File)
    if ($r.ExitCode -ne 0) { return '' }
    try { [xml]$x = $r.Text } catch { return '' }
    $m = $x.SelectSingleNode('//logentry/msg')
    if ($m) { return $m.InnerText }
    return ''
}
