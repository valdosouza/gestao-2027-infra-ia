# test-install-journal.ps1 - plain PowerShell tests of InstallJournal.psm1 (no Pester needed).
#
# Everything happens inside one scratch folder that stands for "the machine". Nothing else is
# touched: environment variables in Process scope only; the scheduled-task and registry
# backends are replaced by in-memory fakes INSIDE the module (no real task, no real key).
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File tests\test-install-journal.ps1 [-Scratch <dir>] [-KeepScratch]
# -Scratch: an empty folder to work in (default: a new folder under the temp folder).
# Exit 0 = every check passed, 1 = a check failed.
# ASCII-only on purpose: Windows PowerShell 5.1 misreads BOM-less UTF-8 source as ANSI.

[CmdletBinding()]
param([string]$Scratch = '', [switch]$KeepScratch)

$ErrorActionPreference = 'Stop'
Import-Module (Join-Path (Split-Path -Parent $PSScriptRoot) 'InstallJournal.psm1') -Force
$mod = Get-Module InstallJournal

if (-not $Scratch) { $Scratch = Join-Path ([IO.Path]::GetTempPath()) ('install-journal-test-' + [guid]::NewGuid().ToString('N').Substring(0, 8)) }
New-Item -ItemType Directory -Force -Path $Scratch | Out-Null
$Scratch = (Resolve-Path -LiteralPath $Scratch).ProviderPath
$machine = Join-Path $Scratch 'machine'
$journals = Join-Path $Scratch 'journals'

$script:Pass = 0
$script:Fail = 0
function Check([bool]$Condition, [string]$Name, [string]$Detail = '') {
    if ($Condition) { $script:Pass++; Write-Host "  PASS $Name" -ForegroundColor DarkGreen }
    else { $script:Fail++; Write-Host "  FAIL $Name $Detail" -ForegroundColor Red }
}
function Section([string]$Title) { Write-Host ''; Write-Host "== $Title" -ForegroundColor Cyan }
function Show($Objects, [string[]]$Props) {
    # paths are shown relative to the scratch folder (~)
    $rows = @(@($Objects) | ForEach-Object {
        $copy = $_ | Select-Object -Property *
        foreach ($p in 'Target', 'Note') { if ($copy.PSObject.Properties[$p] -and $copy.$p) { $copy.$p = ([string]$copy.$p).Replace($Scratch, '~') } }
        $copy
    })
    if ($rows.Count -eq 0) { Write-Host '  (nothing)'; return }
    ($rows | Format-Table -Property $Props -AutoSize | Out-String -Width 220).TrimEnd() -split "`n" | ForEach-Object { Write-Host ('  ' + $_.TrimEnd()) }
}
function Count-Lines([string]$Path) { if ([IO.File]::Exists($Path)) { return @([IO.File]::ReadAllLines($Path) | Where-Object { $_.Trim() }).Count } return 0 }
function Read-Bytes([string]$Path) { return [Convert]::ToBase64String([IO.File]::ReadAllBytes($Path)) }
function Write-Text([string]$Path, [string]$Text) { [IO.File]::WriteAllText($Path, $Text, (New-Object Text.UTF8Encoding($false))) }
function Status-Of($Results, [string]$Target) { return @(@($Results) | Where-Object { $_.Target -eq $Target } | ForEach-Object { $_.Status }) -join ',' }
function Remove-Tree([string]$Path) {
    # cleanup that never follows a link: links are removed as pointers first
    if (-not ([IO.Directory]::Exists($Path) -or [IO.File]::Exists($Path))) { return }
    $item = Get-Item -LiteralPath $Path -Force
    if ($item.LinkType -eq 'Junction' -or $item.LinkType -eq 'SymbolicLink') {
        if ($item.PSIsContainer) { [IO.Directory]::Delete($Path) } else { [IO.File]::Delete($Path) }
        return
    }
    if ($item.PSIsContainer) {
        foreach ($child in [IO.Directory]::GetFileSystemEntries($Path)) { Remove-Tree $child }
        [IO.Directory]::Delete($Path)
    } else {
        $item.Attributes = 'Normal'
        [IO.File]::Delete($Path)
    }
}

# ---------------------------------------------------------------- fakes inside the module
& $mod {
    $script:FakeTasks = @{ 'Old-Poll' = 'true' }
    $script:LastCreate = @()
    function script:Invoke-TaskTool([string[]]$Arguments) {
        $name = $Arguments[[array]::IndexOf($Arguments, '/TN') + 1]
        switch ($Arguments[0]) {
            '/Query' {
                if ($script:FakeTasks.ContainsKey($name)) { return [pscustomobject]@{ ExitCode = 0; Output = "<Task><Settings><Enabled>$($script:FakeTasks[$name])</Enabled></Settings></Task>" } }
                return [pscustomobject]@{ ExitCode = 1; Output = 'ERROR: The system cannot find the file specified.' }
            }
            '/Create' {
                if ($script:FakeTasks.ContainsKey($name) -and $Arguments -notcontains '/F') { return [pscustomobject]@{ ExitCode = 1; Output = 'ERROR: exists' } }
                $script:FakeTasks[$name] = 'true'
                $script:LastCreate = $Arguments
            }
            '/Change' { if ($Arguments -contains '/DISABLE') { $script:FakeTasks[$name] = 'false' } else { $script:FakeTasks[$name] = 'true' } }
            '/Delete' { [void]$script:FakeTasks.Remove($name) }
        }
        return [pscustomobject]@{ ExitCode = 0; Output = '' }
    }
    $script:FakeReg = @{ 'HKCU:\Software\FakeVcsClient' = @{ hooks = @{ Kind = 'String'; Data = "start_commit_hook`nC:\other`nother.exe`ntrue`nshow`nask`n" } } }
    function script:Read-RegistryValue([string]$Key, [string]$Name) {
        if (-not $script:FakeReg.ContainsKey($Key)) { throw "registry key not found: $Key" }
        $vals = $script:FakeReg[$Key]
        if (-not $vals.ContainsKey($Name)) { return [pscustomobject]@{ Exists = $false; Kind = 'String'; Data = $null } }
        return [pscustomobject]@{ Exists = $true; Kind = $vals[$Name].Kind; Data = $vals[$Name].Data }
    }
    function script:Write-RegistryValue([string]$Key, [string]$Name, [string]$Kind, $Data) { $script:FakeReg[$Key][$Name] = @{ Kind = $Kind; Data = $Data } }
    function script:Remove-RegistryValue([string]$Key, [string]$Name) { $script:FakeReg[$Key].Remove($Name) }
}
function Get-FakeTask([string]$Name) { return (& $mod { param($n) $script:FakeTasks[$n] } $Name) }
function Get-FakeHooks { return [string](& $mod { $script:FakeReg['HKCU:\Software\FakeVcsClient']['hooks'].Data }) }

# ---------------------------------------------------------------- the "machine" before install
New-Item -ItemType Directory -Force -Path (Join-Path $machine 'data') | Out-Null
Write-Text (Join-Path $machine 'data\payload.txt') "data that is not ours`n"
Write-Text (Join-Path $machine 'existing.cfg') "original=1`r`n"
# 4-space indent on purpose: an untouched file must come back byte for byte, not re-formatted
Write-Text (Join-Path $machine 'settings.json') "{`n    `"theme`": `"dark`",`n    `"hooks`": {`n        `"post`": [ { `"command`": `"older-tool --x`" } ]`n    }`n}`n"
$suffix = [guid]::NewGuid().ToString('N').Substring(0, 8).ToUpperInvariant()
$envPrev = "IJ_TEST_PREV_$suffix"
$envNew = "IJ_TEST_NEW_$suffix"
[Environment]::SetEnvironmentVariable($envPrev, 'old', 'Process')
$j = Join-Path $journals 'demo.jsonl'
$before = @{
    existing = Read-Bytes (Join-Path $machine 'existing.cfg')
    settings = Read-Bytes (Join-Path $machine 'settings.json')
    hooks    = Get-FakeHooks
}

function Install-Demo {
    # what a component's setup script would do, step by step
    [CmdletBinding(SupportsShouldProcess = $true)]
    param([string]$Journal, [string]$HookCommand = 'demo-tool --hook')
    New-JournalFolder -Journal $Journal -Path "$machine\app\conf"
    New-JournalFile -Journal $Journal -Path "$machine\app\conf\settings.ini" -Content "a=1`n"
    New-JournalFile -Journal $Journal -Path "$machine\app\readme.txt" -Content "readme`n"
    New-JournalFile -Journal $Journal -Path "$machine\app\local.cfg" -Content "user=me`n" -IfMissing -Keep
    Set-JournalFile -Journal $Journal -Path "$machine\existing.cfg" -Content "replaced=1`n"
    New-JournalLink -Journal $Journal -Path "$machine\app\data-link" -Target "$machine\data"
    New-JournalFolder -Journal $Journal -Path "$machine\swap"
    Set-JournalEnvironment -Journal $Journal -Name $envPrev -Value 'new' -Scope Process
    Set-JournalEnvironment -Journal $Journal -Name $envNew -Value 'fresh' -Scope Process
    Add-JournalEntry -Journal $Journal -JsonFile "$machine\settings.json" -ArrayPath 'hooks.post' -Entry ([ordered]@{ command = $HookCommand }) -Id 'demo-post-hook'
    Remove-JournalEntry -Journal $Journal -JsonFile "$machine\settings.json" -ArrayPath 'hooks.post' -Entry ([ordered]@{ command = 'older-tool --x' })
    Register-JournalTask -Journal $Journal -Name 'Demo-Poll' -Command 'powershell.exe -File "C:\demo tool\run.ps1" -Poll' -Schedule 'HOURLY'
    Disable-JournalTask -Journal $Journal -Name 'Old-Poll'
    Add-JournalEntry -Journal $Journal -RegistryKey 'HKCU:\Software\FakeVcsClient' -ValueName 'hooks' -RecordLines 6 -Entry @('post_commit_hook', "$machine\app", 'demo.exe --post', 'false', 'hide', 'ask')
}

Write-Host "InstallJournal tests - scratch: $Scratch"
try {
    # ------------------------------------------------------------ 1
    Section '1. status before install'
    $st = @(Get-JournalStatus -Journal $j)
    Show $st @('Seq', 'Action', 'Target', 'State')
    Check ($st.Count -eq 0) 'nothing is installed before the first install'

    # ------------------------------------------------------------ 2
    Section '2. install with -WhatIf (from the calling function, not passed per call)'
    $r = @(Install-Demo -Journal $j -WhatIf)
    Check (@($r | Where-Object { $_.Status -ne 'whatif' }).Count -eq 0) 'every action reports whatif' (($r | ForEach-Object { $_.Status }) -join ',')
    Check (-not (Test-Path -LiteralPath $j)) 'no journal written'
    Check (-not (Test-Path -LiteralPath "$machine\app")) 'no folder created'
    Check ([Environment]::GetEnvironmentVariable($envPrev, 'Process') -eq 'old' -and $null -eq [Environment]::GetEnvironmentVariable($envNew, 'Process')) 'environment unchanged'
    Check ((Read-Bytes "$machine\settings.json") -eq $before.settings -and (Get-FakeTask 'Old-Poll') -eq 'true' -and -not (Get-FakeTask 'Demo-Poll')) 'settings file and tasks unchanged'

    # ------------------------------------------------------------ 3
    Section '3. install'
    $r = @(Install-Demo -Journal $j)
    Show $r @('Seq', 'Action', 'Status', 'Target')
    Check (@($r | Where-Object { $_.Status -ne 'done' }).Count -eq 0) 'every action is done' (($r | ForEach-Object { $_.Status }) -join ',')
    Check ((Count-Lines $j) -eq $r.Count) "one journal line per change ($($r.Count))"
    Check ((Get-Content -LiteralPath "$machine\existing.cfg" -Raw) -eq "replaced=1`n") 'existing file replaced'
    Check ((Get-Item -LiteralPath "$machine\app\data-link").LinkType -eq 'Junction') 'junction created'
    Check ([Environment]::GetEnvironmentVariable($envPrev, 'Process') -eq 'new' -and [Environment]::GetEnvironmentVariable($envNew, 'Process') -eq 'fresh') 'process variables set'
    $sj = Get-Content -LiteralPath "$machine\settings.json" -Raw | ConvertFrom-Json
    Check (@($sj.hooks.post).Count -eq 1 -and $sj.hooks.post[0].command -eq 'demo-tool --hook' -and $sj.theme -eq 'dark') 'JSON hook entry added, older entry removed, the rest kept'
    Check ((Get-FakeTask 'Demo-Poll') -eq 'true' -and (Get-FakeTask 'Old-Poll') -eq 'false') 'task registered, superseded task disabled (fake scheduler)'
    $tr = (& $mod { $script:LastCreate })[[array]::IndexOf((& $mod { $script:LastCreate }), '/TR') + 1]
    $quoted = & $mod { param($a) ConvertTo-CommandLineArg $a } $tr
    Check ($quoted -eq '"powershell.exe -File \"C:\demo tool\run.ps1\" -Poll"') "the /TR value is quoted for the native command line: $quoted"
    Check ((& $mod { ConvertTo-CommandLineArg 'C:\dir with space\' }) -eq '"C:\dir with space\\"') 'a trailing backslash is doubled before the closing quote'
    Check ((Get-FakeHooks) -match 'demo\.exe --post' -and (Get-FakeHooks) -match 'other\.exe') 'registry hook record added after the existing one (fake registry)'
    $line = [IO.File]::ReadAllLines($j)[0]
    Check ($line -match '^\{"v":1,"seq":1,"time":"[^"]+","action":"folder-create","id":"folder:' -and $line -notmatch '[^\x20-\x7E]') 'journal lines are compact ASCII JSON'
    Write-Host ('  line 1: ' + $line.Replace($Scratch.Replace('\', '\\'), '~').Replace($Scratch.ToLowerInvariant().Replace('\', '\\'), '~'))

    # ------------------------------------------------------------ 4
    Section '4. status after install'
    $st = @(Get-JournalStatus -Journal $j)
    Show $st @('Seq', 'Action', 'State', 'Keep', 'Target')
    Check ($st.Count -eq $r.Count -and @($st | Where-Object { $_.State -ne 'installed' }).Count -eq 0) "all $($r.Count) lines installed"

    # ------------------------------------------------------------ 5
    Section '5. re-run install (idempotent)'
    $n = Count-Lines $j
    $r2 = @(Install-Demo -Journal $j)
    Show ($r2 | Group-Object Status | Select-Object Name, Count) @('Name', 'Count')
    Check (@($r2 | Where-Object { $_.Status -ne 'skipped' }).Count -eq 0) 'every action is skipped' (($r2 | ForEach-Object { $_.Status }) -join ',')
    Check ((Count-Lines $j) -eq $n) "journal unchanged ($n lines)"

    # ------------------------------------------------------------ 6
    Section '6. drift: a recorded file is deleted, a new value and a new hook definition come in'
    Remove-Item -LiteralPath "$machine\app\readme.txt"
    $r3 = @(Install-Demo -Journal $j -HookCommand 'demo-tool --hook --v2')
    Check ((Status-Of $r3 "$machine\app\readme.txt") -eq 'repaired' -and (Test-Path -LiteralPath "$machine\app\readme.txt")) 'deleted file repaired under its old line'
    $u = @(Set-JournalEnvironment -Journal $j -Name $envPrev -Value 'newer' -Scope Process)
    Check ($u[0].Status -eq 'updated' -and [Environment]::GetEnvironmentVariable($envPrev, 'Process') -eq 'newer') 'new value supersedes the old line'
    $sj = Get-Content -LiteralPath "$machine\settings.json" -Raw | ConvertFrom-Json
    Check (@($sj.hooks.post).Count -eq 1 -and $sj.hooks.post[0].command -eq 'demo-tool --hook --v2') 'same -Id, new hook entry: the old one is replaced, not duplicated'
    $st = @(Get-JournalStatus -Journal $j)
    Check (@($st | Where-Object { $_.State -ne 'installed' }).Count -eq 0) 'still all installed after repair and updates'

    # ------------------------------------------------------------ 7
    Section '7. refusals: never take over what this journal did not create'
    $jr = Join-Path $journals 'refuse.jsonl'
    $threw = $false; try { New-JournalFile -Journal $jr -Path "$machine\data\payload.txt" -Content 'x' | Out-Null } catch { $threw = $true }
    Check $threw 'New-JournalFile refuses an existing file with other content'
    $threw = $false; try { New-JournalLink -Journal $jr -Path "$machine\data" -Target "$machine\app" | Out-Null } catch { $threw = $true }
    Check $threw 'New-JournalLink refuses a real folder in its place'
    $threw = $false; try { Register-JournalTask -Journal $jr -Name 'Old-Poll' -Command 'x.exe' | Out-Null } catch { $threw = $true }
    Check $threw 'Register-JournalTask refuses a task it did not register'
    Check ((Count-Lines $jr) -eq 0) 'a refusal writes no journal line'

    # ------------------------------------------------------------ 8
    Section '8. someone else changes things after install'
    Write-Text "$machine\app\conf\settings.ini" "a=1`nedited-by-user=1`n"
    [IO.Directory]::Delete("$machine\swap")
    New-Item -ItemType Junction -Path "$machine\swap" -Value "$machine\data" | Out-Null
    $s = Get-Content -LiteralPath "$machine\settings.json" -Raw
    Write-Text "$machine\settings.json" ($s -replace '"theme": "dark"', '"theme": "dark", "user": true')
    $st = @(Get-JournalStatus -Journal $j)
    Show ($st | Where-Object { $_.State -ne 'installed' }) @('Seq', 'Action', 'State', 'Target')
    Check (($st | Where-Object { $_.Target -eq "$machine\app\conf\settings.ini" }).State -eq 'changed') 'status sees the edited file as changed'
    Check (($st | Where-Object { $_.Target -eq "$machine\swap" }).State -eq 'changed') 'status sees the folder swapped for a junction as changed'

    # ------------------------------------------------------------ 9
    Section '9. undo with -WhatIf'
    $n = Count-Lines $j
    $w = @(Undo-Journal -Journal $j -WhatIf)
    Check ($w.Count -gt 0 -and @($w | Where-Object { $_.Status -ne 'whatif' }).Count -eq 0) "every line reports whatif ($($w.Count))"
    Check ((Count-Lines $j) -eq $n -and (Test-Path -LiteralPath "$machine\app\readme.txt")) 'nothing undone, journal unchanged'

    # ------------------------------------------------------------ 10
    Section '10. undo (newest first)'
    $warn = @()
    $u = @(Undo-Journal -Journal $j -WarningVariable warn -WarningAction SilentlyContinue)
    Show $u @('Seq', 'Action', 'Status', 'Target', 'Note')
    Write-Host "  warnings: $($warn.Count)"
    $warn | ForEach-Object { Write-Host ("    WARNING: " + ("$_").Replace($Scratch, '~')) -ForegroundColor DarkYellow }
    $seqs = @($u | ForEach-Object { [int]$_.Seq })
    $sorted = @($seqs | Sort-Object -Descending)
    Check (($seqs -join ',') -eq ($sorted -join ',')) 'lines undone newest first'
    Check ((Status-Of $u "$machine\app\conf\settings.ini") -eq 'kept' -and (Get-Content -LiteralPath "$machine\app\conf\settings.ini" -Raw) -match 'edited-by-user') 'the file edited after install is kept'
    Check (@($warn | Where-Object { "$_" -match 'settings\.ini' }).Count -eq 1) 'with a warning'
    Check ((Status-Of $u "$machine\app\local.cfg") -eq 'retained' -and (Test-Path -LiteralPath "$machine\app\local.cfg")) 'the -Keep file is retained'
    Check (-not (Test-Path -LiteralPath "$machine\app\readme.txt")) 'the untouched created file is deleted'
    Check ((Status-Of $u "$machine\app\conf") -eq 'kept' -and (Status-Of $u "$machine\app") -eq 'kept') 'folders that are not empty are kept'
    Check (-not (Test-Path -LiteralPath "$machine\app\data-link") -and (Get-Content -LiteralPath "$machine\data\payload.txt" -Raw) -eq "data that is not ours`n") 'junction removed, its target and content untouched'
    Check ((Status-Of $u "$machine\swap") -eq 'kept' -and (Get-Content -LiteralPath "$machine\data\payload.txt" -Raw) -eq "data that is not ours`n") 'a created folder later swapped for a junction is kept, never followed'
    Check ((Read-Bytes "$machine\existing.cfg") -eq $before.existing) 'replaced file restored byte for byte'
    Check ([Environment]::GetEnvironmentVariable($envPrev, 'Process') -eq 'old') 'variable back to its value from before the first install'
    Check ($null -eq [Environment]::GetEnvironmentVariable($envNew, 'Process')) 'variable that did not exist is removed'
    $sj = Get-Content -LiteralPath "$machine\settings.json" -Raw | ConvertFrom-Json
    Check (@($sj.hooks.post).Count -eq 1 -and $sj.hooks.post[0].command -eq 'older-tool --x' -and $sj.user -eq $true) 'JSON list: our entry gone, the removed one back, the user edit kept'
    Check ((Get-FakeTask 'Demo-Poll') -eq $null -and (Get-FakeTask 'Old-Poll') -eq 'true') 'task unregistered, superseded task enabled again (fake scheduler)'
    Check ((Get-FakeHooks) -ceq $before.hooks) 'registry hook value back to its exact previous text (fake registry)'

    # ------------------------------------------------------------ 11
    Section '11. status after undo'
    $st = @(Get-JournalStatus -Journal $j)
    Show $st @('Seq', 'Action', 'Target', 'State')
    Check ($st.Count -eq 0) 'nothing installed'
    Check (-not (Test-Path -LiteralPath $j) -and @(Get-ChildItem -LiteralPath $journals -Filter 'demo.jsonl.undone-*').Count -eq 1) 'journal kept under demo.jsonl.undone-<stamp>'
    Check (-not (Test-Path -LiteralPath "$j.backup")) 'no backup left behind'

    # ------------------------------------------------------------ 12
    Section '12. untouched JSON file comes back byte for byte'
    $jx = Join-Path $journals 'exact.jsonl'
    Write-Text "$machine\settings.json" "{`r`n    `"keep`":   `"this odd spacing`",`r`n    `"hooks`": { }`r`n}"
    $b0 = Read-Bytes "$machine\settings.json"
    $null = Add-JournalEntry -Journal $jx -JsonFile "$machine\settings.json" -ArrayPath 'hooks.pre' -Entry 'plain-string-entry'
    $null = Add-JournalEntry -Journal $jx -JsonFile "$machine\settings.json" -ArrayPath 'hooks.post' -Entry ([ordered]@{ command = 'second' })
    $mid = Get-Content -LiteralPath "$machine\settings.json" -Raw
    Check ($mid.Contains("`r`n") -and ($mid | ConvertFrom-Json).hooks.pre[0] -eq 'plain-string-entry') 'CRLF line ends kept; a plain string is an entry too'
    $u = @(Undo-Journal -Journal $jx)
    Check ((Read-Bytes "$machine\settings.json") -eq $b0 -and @($u | Where-Object { $_.Note -match 'exact' }).Count -eq 2) 'two entries undone through the exact-restore chain: the original bytes are back'
    $jy = Join-Path $journals 'newfile.jsonl'
    $null = Add-JournalEntry -Journal $jy -JsonFile "$machine\new\tool.json" -ArrayPath 'hooks.post' -Entry ([ordered]@{ command = 'x' })
    Check ((Get-Content -LiteralPath "$machine\new\tool.json" -Raw) -eq "{`n  `"hooks`": {`n    `"post`": [`n      {`n        `"command`": `"x`"`n      }`n    ]`n  }`n}`n") 'a missing JSON file is created, 2-space indented'
    $null = Undo-Journal -Journal $jy
    Check (-not (Test-Path -LiteralPath "$machine\new")) 'undo deletes the file it created and the folder it created'

    # ------------------------------------------------------------ 13
    Section '13. a failure stops the undo; a second run resumes'
    $j2 = Join-Path $journals 'stop.jsonl'
    foreach ($f in 'f1', 'f2', 'f3') { $null = New-JournalFile -Journal $j2 -Path "$machine\stop\$f.txt" -Content $f }
    (Get-Item -LiteralPath "$machine\stop\f2.txt").IsReadOnly = $true
    $err = @()
    $u = @(Undo-Journal -Journal $j2 -ErrorVariable err -ErrorAction SilentlyContinue)
    Show $u @('Seq', 'Action', 'Status', 'Target')
    # -ErrorVariable also collects the exception the module caught; the report is the error it wrote
    $report = @($err | Where-Object { "$_" -match 'stopped at' })
    Write-Host "  report: $(("$($report[0])").Replace($Scratch, '~'))" -ForegroundColor DarkYellow
    Check ((Status-Of $u "$machine\stop\f3.txt") -eq 'reverted' -and (Status-Of $u "$machine\stop\f2.txt") -eq 'failed' -and (Status-Of $u "$machine\stop\f1.txt") -eq '') 'f3 undone, f2 failed, f1 not attempted'
    Check ($report.Count -eq 1 -and "$($report[0])" -match 'stopped at line 3' -and "$($report[0])" -match 'run Undo-Journal again') 'one report naming the failed line and the next step'
    Check ((Test-Path -LiteralPath $j2) -and @(Get-JournalStatus -Journal $j2).Count -eq 3) 'journal not closed; f2, f1 and the folder still listed'
    (Get-Item -LiteralPath "$machine\stop\f2.txt").IsReadOnly = $false
    $u = @(Undo-Journal -Journal $j2)
    Check (($u | ForEach-Object { $_.Status }) -join ',' -eq 'reverted,reverted,reverted' -and -not (Test-Path -LiteralPath "$machine\stop") -and -not (Test-Path -LiteralPath $j2)) 'second run resumes and closes the journal'

    # ------------------------------------------------------------ 14
    Section '14. -ContinueOnError goes past a failure'
    $j3 = Join-Path $journals 'continue.jsonl'
    foreach ($f in 'f1', 'f2', 'f3') { $null = New-JournalFile -Journal $j3 -Path "$machine\cont\$f.txt" -Content $f }
    (Get-Item -LiteralPath "$machine\cont\f2.txt").IsReadOnly = $true
    $u = @(Undo-Journal -Journal $j3 -ContinueOnError -ErrorVariable err -ErrorAction SilentlyContinue -WarningAction SilentlyContinue)
    Show $u @('Seq', 'Action', 'Status', 'Target')
    Check ((Status-Of $u "$machine\cont\f1.txt") -eq 'reverted' -and (Status-Of $u "$machine\cont\f2.txt") -eq 'failed' -and (Status-Of $u "$machine\cont") -eq 'kept') 'f3 and f1 undone, f2 failed, its folder kept'
    $left = @(Get-JournalStatus -Journal $j3)
    Check ($left.Count -eq 1 -and $left[0].Target -eq "$machine\cont\f2.txt") 'only the failed line is still installed'
    (Get-Item -LiteralPath "$machine\cont\f2.txt").IsReadOnly = $false
    $null = Undo-Journal -Journal $j3
    Check (-not (Test-Path -LiteralPath $j3) -and -not (Test-Path -LiteralPath "$machine\cont\f2.txt")) 'second run finishes it'

    # ------------------------------------------------------------ 15
    Section '15. write-ahead: a change that fails leaves a closed line, no orphan'
    $j4 = Join-Path $journals 'ahead.jsonl'
    Write-Text "$machine\locked.cfg" "locked`n"
    (Get-Item -LiteralPath "$machine\locked.cfg").IsReadOnly = $true
    $threw = $false; try { Set-JournalFile -Journal $j4 -Path "$machine\locked.cfg" -Content "new`n" | Out-Null } catch { $threw = $true }
    $last = ([IO.File]::ReadAllLines($j4))[-1]
    Check ($threw -and $last -match '"action":"undone"' -and $last -match '"result":"not-applied"') 'the failed change is recorded and closed as not-applied'
    Check (@(Get-JournalStatus -Journal $j4).Count -eq 0 -and (Get-Content -LiteralPath "$machine\locked.cfg" -Raw) -eq "locked`n") 'status lists nothing; the file is untouched'
    Check (@(Get-ChildItem -LiteralPath "$j4.backup" -Force -ErrorAction SilentlyContinue).Count -eq 0) 'the backup taken for the failed replace is gone'
    (Get-Item -LiteralPath "$machine\locked.cfg").IsReadOnly = $false

    # ------------------------------------------------------------ 16
    Section '16. -Purge reverts lines recorded with -Keep'
    $j5 = Join-Path $journals 'purge.jsonl'
    $null = New-JournalFile -Journal $j5 -Path "$machine\purge.cfg" -Content "x`n" -Keep
    $u = @(Undo-Journal -Journal $j5 -Purge)
    Check ($u[0].Status -eq 'reverted' -and -not (Test-Path -LiteralPath "$machine\purge.cfg")) 'the -Keep file is removed under -Purge'

    # ------------------------------------------------------------ 17
    Section '17. symbolic link to a file (needs the create-symbolic-link privilege)'
    $j6 = Join-Path $journals 'symlink.jsonl'
    $made = $false
    try { $null = New-JournalLink -Journal $j6 -Path "$machine\payload-link.txt" -Target "$machine\data\payload.txt" -LinkType SymbolicLink; $made = $true }
    catch { Write-Host "  SKIP symbolic link not created here: $($_.Exception.Message)" -ForegroundColor DarkYellow }
    if ($made) {
        $null = Undo-Journal -Journal $j6
        Check (-not (Test-Path -LiteralPath "$machine\payload-link.txt") -and (Test-Path -LiteralPath "$machine\data\payload.txt")) 'undo removes the file link, not its target'
    } else {
        $last = ([IO.File]::ReadAllLines($j6))[-1]
        Check ($last -match '"result":"not-applied"' -and @(Get-JournalStatus -Journal $j6).Count -eq 0) 'the refused link creation is closed as not-applied'
    }
} catch {
    $script:Fail++
    Write-Host "  FAIL unexpected error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "  at: $($_.InvocationInfo.PositionMessage)" -ForegroundColor Red
} finally {
    [Environment]::SetEnvironmentVariable($envPrev, $null, 'Process')
    [Environment]::SetEnvironmentVariable($envNew, $null, 'Process')
    Remove-Module InstallJournal -ErrorAction SilentlyContinue
    if (-not $KeepScratch) { Remove-Tree $Scratch }
}

Write-Host ''
$color = 'Green'
if ($script:Fail) { $color = 'Red' }
Write-Host "InstallJournal tests: $($script:Pass) passed, $($script:Fail) failed" -ForegroundColor $color
if ($script:Fail) { exit 1 }
exit 0
