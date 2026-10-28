# hook.ps1 - Claude Code hook entry point of the engine-kit guards (runtime, guards).
#
# Reads the hook JSON once from stdin, finds the project from the payload (the edited
# file, or the folder the commit runs in), loads <project>/.engine-kit/guards.json and
# dispatches to the guards that the config enables. ASCII-only; PowerShell 5.1 and 7.
#
#   no config file             -> exit 0, no output (the plugin is installed everywhere;
#                                 only a project that opts in is checked)
#   PostToolUse Edit|Write|MultiEdit -> each enabled guard checks the edited file; findings go
#                                 back to the agent as additionalContext (and to the user
#                                 as systemMessage)
#   PreToolUse Bash|PowerShell with `git commit` / `svn commit|ci`
#                              -> each enabled guard checks the files the commit carries.
#                                 Default "commitGate": "warn": systemMessage + context,
#                                 the commit goes ahead. "commitGate": "ask": the harness
#                                 asks the user to confirm (permissionDecision "ask").
#                                 The guards never deny (EK#6: warn-only by default).
#                              -> with a "commitDoor" section, the commit door of the
#                                 testing tools (runtime/testing/suite.py precommit) runs
#                                 too, always warn-only (EK#14): its warnings join the
#                                 answer; it never asks, never denies, never runs the
#                                 suite; no Python 3.8+ -> one "not run here" line.
#
# Commit folder: the last `cd` / `Set-Location` / `pushd` / `git -C` before the commit
# verb in the command, else the payload "cwd", else the current folder.
# Always exits 0. Set ENGINEKIT_GUARDS_DEBUG=1 for a trace on stderr.
#
# Normally launched by launch.sh (the cheap prefilter wired in hooks/hooks.json); it can
# also be wired directly: powershell -NoProfile -ExecutionPolicy Bypass -File hook.ps1

$ErrorActionPreference = 'SilentlyContinue'
. (Join-Path $PSScriptRoot 'guard-common.ps1')
function Dbg([string]$m) { if ($env:ENGINEKIT_GUARDS_DEBUG) { [Console]::Error.WriteLine(('[guards {0:HH:mm:ss.fff}] {1}' -f (Get-Date), $m)) } }

$MaxLinesPerGuard = 40
$bs = [string][char]92

function Resolve-CmdPath([string]$p, [string]$base) {
    $p = $p.Trim().Trim('"', "'")
    if (-not $p) { return $base }
    if ($p -eq '~' -or $p.StartsWith('~/') -or $p.StartsWith('~\')) { $p = $HOME + $p.Substring(1) }
    # Git Bash style /c/folder on Windows
    if ([System.IO.Path]::DirectorySeparatorChar -eq '\' -and $p -match '^/([A-Za-z])(/.*)?$') {
        $p = $Matches[1] + ':' + $(if ($Matches[2]) { $Matches[2] } else { '/' })
    }
    if (-not [System.IO.Path]::IsPathRooted($p)) { $p = Join-Path $base $p }
    try { $full = [System.IO.Path]::GetFullPath($p) } catch { return $base }
    if (Test-Path -LiteralPath $full -PathType Container) { return $full }
    return $base
}

function Get-CommitInfo([string]$Cmd, [string]$Cwd) {
    # @{ Vcs = 'git'|'svn'; Dir = <folder the commit runs in> } or $null
    if (-not $Cmd) { return $null }
    $q = '(?:"[^"]*"|''[^'']*''|[^\s;&|)]+)'
    $git = [regex]::Match($Cmd, '(?i)(?<![\w-])git(?:\.exe)?((?:\s+(?:-C\s+' + $q + '|-c\s+\S+|--?[A-Za-z][\w-]*(?:=\S+)?))*)\s+commit(?![\w-])')
    $svn = [regex]::Match($Cmd, '(?i)(?<![\w-])svn(?:\.exe)?\s+(?:commit|ci)(?![\w-])')
    $m = $null; $vcs = ''
    if ($git.Success -and (-not $svn.Success -or $git.Index -le $svn.Index)) { $m = $git; $vcs = 'git' }
    elseif ($svn.Success) { $m = $svn; $vcs = 'svn' }
    if (-not $m) { return $null }
    $dir = $Cwd
    $prefix = $Cmd.Substring(0, $m.Index)
    foreach ($cd in [regex]::Matches($prefix, '(?i)(?:^|[;&|(]|\s)(?:cd|chdir|pushd|Set-Location|sl)\s+(?:-(?:Literal)?Path\s+)?(' + $q + ')')) {
        $dir = Resolve-CmdPath $cd.Groups[1].Value $dir
    }
    if ($vcs -eq 'git') {
        foreach ($c in [regex]::Matches($m.Groups[1].Value, '-C\s+(' + $q + ')')) { $dir = Resolve-CmdPath $c.Groups[1].Value $dir }
    }
    return @{ Vcs = $vcs; Dir = $dir }
}

function Limit-Lines([string[]]$lines, [string]$fullList) {
    # $fullList: the command that prints the full list
    if ($lines.Count -le $MaxLinesPerGuard) { return $lines }
    $more = $lines.Count - $MaxLinesPerGuard
    return @($lines[0..($MaxLinesPerGuard - 1)]) + @("... $more more line(s) - run $fullList for the full list")
}

# ---------------------------------------------------------------- the commit door (EK#14)

# Runs suite.py precommit with gate.mode forced to warn, whatever the testing config (or
# its per-machine local.json) says: from the plugin hook the door only warns and never
# runs the suite. argv: <testing dir> <testing config>. Exit 78 = this Python 3 is older
# than 3.8 (78 is the testing tools' "not run here" code, never a warn-mode precommit
# answer). Started with -I: the project folder never shadows a module.
$DoorWrapper = @'
import sys
if sys.version_info < (3, 8):
    sys.exit(78)
sys.path.insert(0, sys.argv[1])
import suite
sys.exit(suite.main(['--config', sys.argv[2], 'precommit', '--warn-only']))
'@

function Get-PythonCandidates {
    # Python 3 launchers found on PATH, in order: python3, python, py -3. Get-Command looks
    # on PATH only (never the current folder), and the full path is what runs.
    $list = @()
    foreach ($c in @(@{ Name = 'python3'; Pre = @() }, @{ Name = 'python'; Pre = @() }, @{ Name = 'py'; Pre = @('-3') })) {
        $cmd = Get-Command $c.Name -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($cmd) { $list += , @{ Exe = $cmd.Source; Pre = $c.Pre } }
    }
    return , $list
}

function Invoke-CommitDoor($Door, [string]$CfgPath) {
    # Returns one block (Head, Lines, Advice) for the hook answer, or nothing when the door
    # has nothing to say.
    $root = Split-Path -Parent (Split-Path -Parent $CfgPath)
    $rel = [string](Get-Cfg $Door 'config' '.engine-kit/testing.json')
    $testingCfg = $rel
    if (-not [System.IO.Path]::IsPathRooted($testingCfg)) { $testingCfg = Join-Path $root $testingCfg }
    $testingCfg = [System.IO.Path]::GetFullPath($testingCfg)
    $suitePy = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../testing/suite.py'))
    $byHand = "python $suitePy --config $testingCfg precommit"
    Dbg "door config=$testingCfg"
    if (-not (Test-Path -LiteralPath $testingCfg -PathType Leaf)) {
        return @{
            Head   = "COMMIT-DOOR: commitDoor.config '$rel' not found (from $CfgPath) - door skipped, the commit goes ahead."
            Lines  = @()
            Advice = 'Point commitDoor.config at the testing config of the suite (runtime/testing/README.md), or set commitDoor.enabled to false.'
        }
    }
    if (-not (Test-Path -LiteralPath $suitePy -PathType Leaf)) {
        return @{
            Head   = "COMMIT-DOOR: $suitePy is missing from this kit install - door skipped, the commit goes ahead."
            Lines  = @()
            Advice = 'Reinstall or update the engine-kit plugin.'
        }
    }
    $r = $null
    $old = $false
    foreach ($py in (Get-PythonCandidates)) {
        $argList = @($py.Pre) + @('-I', '-X', 'utf8', '-c', $DoorWrapper, (Split-Path -Parent $suitePy), $testingCfg)
        $r = Invoke-Native $py.Exe $argList $root
        Dbg "door python=$($py.Exe) exit=$($r.ExitCode)"
        # -1: did not start; 9009: a launcher stub without Python behind it; 78: older than 3.8
        if ($r.ExitCode -eq 78) { $old = $true }
        if (@(-1, 9009, 78) -contains $r.ExitCode) { $r = $null; continue }
        break
    }
    if ($null -eq $r) {
        $why = 'no Python 3.8+ on PATH (python3, python, py -3)'
        if ($old) { $why = 'the Python on PATH is older than 3.8' }
        return @{
            Head   = "COMMIT-DOOR: not run here - $why; the commit goes ahead."
            Lines  = @()
            Advice = "Install Python 3.8+ to get the commit door's warnings here, or run it by hand: $byHand"
        }
    }
    $out = @(Split-Lines $r.Text | Where-Object { $_.Trim() })
    $err = @(Split-Lines $r.Error | Where-Object { $_.Trim() })
    if ($r.ExitCode -ne 0) {
        return @{
            Head   = "COMMIT-DOOR: the door could not run (exit $($r.ExitCode)) - the commit goes ahead."
            Lines  = @(Limit-Lines (@($out | Where-Object { $_ -match '^(note|error):' }) + @($err | Select-Object -Last 8)) $byHand)
            Advice = "Fix the testing config ($testingCfg; contract in runtime/testing/README.md), then check with: $byHand"
        }
    }
    $said = @($out | Where-Object { $_ -match '^(warn|note):' })
    if ($said.Count -eq 0) { return }
    return @{
        Head   = "COMMIT-DOOR: the commit door of the project's suite has warnings (warn-only; testing config $rel)."
        Lines  = @(Limit-Lines (@($out | Where-Object { $_ -match '^precommit:' }) + $said) $byHand)
        Advice = ("Act on each door warning: a fix and its tests go in separate commits (the fix first); a fix without " +
                  "tests gets its tests (or its Test plan's exempt line) in the next commit; a new fixture gets its row in " +
                  "the index of tested changes; a test reads its data relative to itself, never from a machine path. " +
                  "The door does not run the suite here and never blocks from the plugin hook (EK#6, EK#14).")
    }
}

try {
    $raw = Read-StdinUtf8
    if (-not $raw) { exit 0 }
    try { $payload = $raw | ConvertFrom-Json } catch { exit 0 }
    $hookEvent = [string]$payload.hook_event_name
    $tool  = [string]$payload.tool_name
    $cwd   = [string]$payload.cwd
    if (-not $cwd) { $cwd = (Get-Location).Path }
    Dbg "event=$hookEvent tool=$tool"

    # ------------------------------------------------------------ what happened
    $mode = ''; $file = ''; $commit = $null; $start = ''
    if (@('Edit', 'Write', 'MultiEdit') -contains $tool) {
        if ($hookEvent -and $hookEvent -ne 'PostToolUse') { exit 0 }
        $file = [string]$payload.tool_input.file_path
        if (-not $file) { exit 0 }
        if (-not [System.IO.Path]::IsPathRooted($file)) { $file = Join-Path $cwd $file }
        $mode = 'edit'; $start = $file
    } elseif (@('Bash', 'PowerShell') -contains $tool) {
        if ($hookEvent -and $hookEvent -ne 'PreToolUse') { exit 0 }
        $commit = Get-CommitInfo ([string]$payload.tool_input.command) $cwd
        if (-not $commit) { exit 0 }
        $mode = 'commit'; $start = $commit.Dir
    } else { exit 0 }
    Dbg "mode=$mode start=$start"

    # ------------------------------------------------------------ project config
    $cfgPath = Find-GuardConfig $start
    if (-not $cfgPath) { Dbg 'no .engine-kit/guards.json - nothing to do'; exit 0 }
    try { $cfg = Read-GuardConfig $cfgPath }
    catch {
        Write-HookJson ([ordered]@{ systemMessage = "engine-kit guards: $cfgPath is not valid JSON - guards skipped." })
        exit 0
    }
    $enc = Get-GuardSection $cfg 'encoding'
    $rev = Get-GuardSection $cfg 'revert'
    $door = Get-GuardSection $cfg 'commitDoor'
    $commitGate = ([string](Get-Cfg $cfg 'commitGate' 'warn')).ToLowerInvariant()
    if ($commitGate -ne 'ask') { $commitGate = 'warn' }
    Dbg "config=$cfgPath encoding=$([bool]$enc) revert=$([bool]$rev) commitDoor=$([bool]$door) commitGate=$commitGate"

    # ------------------------------------------------------------ dispatch
    $encScript = Join-Path $PSScriptRoot 'encoding-guard.ps1'
    $revScript = Join-Path $PSScriptRoot 'revert-guard.ps1'
    $blocks = @()
    if ($enc) {
        if ($mode -eq 'edit') { $a = @(& $encScript -Paths @($file) -Config $cfgPath -PassThru) }
        else { $a = @(& $encScript -Gate -WcRoot $commit.Dir -Vcs $commit.Vcs -Config $cfgPath -PassThru) }
        if ($a.Count -gt 0) {
            $blocks += @{
                Head   = 'ENCODING-GUARD: charset problem in source (project policy in .engine-kit/guards.json).'
                Lines  = Limit-Lines $a 'encoding-guard.ps1 -Gate'
                Advice = ("Fix the characters listed, before anything else: ASCII stand-ins in code and comments " +
                          "(em dash -> '-', box line -> '-', arrow -> '->', ellipsis -> '...'); in user-visible strings the " +
                          "escape of the file's language (HTML entities such as &mdash; &hellip; in markup, $($bs)u2014 / $($bs)u2026 " +
                          "in script string literals). A file that is not valid UTF-8: restore the affected lines from the base " +
                          "revision (git show HEAD:<path> / svn cat -r BASE <path>) instead of keeping replacement characters.")
            }
        }
    }
    if ($rev) {
        if ($mode -eq 'edit') { $a = @(& $revScript -Paths @($file) -Config $cfgPath -PassThru) }
        else { $a = @(& $revScript -Gate -WcRoot $commit.Dir -Vcs $commit.Vcs -Config $cfgPath -PassThru) }
        if ($a.Count -gt 0) {
            $blocks += @{
                Head   = 'REVERT-GUARD: the change removes recently committed code - confirm the intention before proceeding.'
                Lines  = Limit-Lines $a 'revert-guard.ps1 -Gate'
                Advice = ("If the removal is NOT intentional, restore the code (git show <rev> / svn diff -c <rev> shows what " +
                          "the origin revision did). If it IS a deliberate revert, confirm with the user and say so in the commit message.")
            }
        }
    }
    $guardBlocks = $blocks.Count
    if ($mode -eq 'commit' -and $door) { $blocks += @(Invoke-CommitDoor $door $cfgPath) }
    Dbg "blocks=$($blocks.Count) (guards $guardBlocks)"
    if ($blocks.Count -eq 0) { exit 0 }

    # ------------------------------------------------------------ hook output
    $msg = (@($blocks | ForEach-Object {
        if (@($_.Lines).Count -gt 0) { $_.Head + "`n  " + (@($_.Lines) -join "`n  ") } else { $_.Head }
    }) -join "`n")
    $advice = (@($blocks | ForEach-Object { $_.Advice }) -join "`n")

    if ($mode -eq 'edit') {
        Write-HookJson ([ordered]@{
            systemMessage      = $msg
            hookSpecificOutput = [ordered]@{
                hookEventName     = 'PostToolUse'
                additionalContext = $msg + "`n" + $advice
            }
        })
        exit 0
    }
    # "ask" answers the guards' findings only: the commit door alone never asks (EK#14)
    if ($commitGate -eq 'ask' -and $guardBlocks -gt 0) {
        Write-HookJson ([ordered]@{
            systemMessage      = $msg
            hookSpecificOutput = [ordered]@{
                hookEventName            = 'PreToolUse'
                permissionDecision       = 'ask'
                permissionDecisionReason = $msg
                additionalContext        = $msg + "`n" + $advice
            }
        })
        exit 0
    }
    $tail = "`n(warn-only: the commit goes ahead)"
    if ($guardBlocks -gt 0) { $tail = "`n(warn-only: the commit goes ahead; a project that wants a confirmation sets `"commitGate`": `"ask`")" }
    Write-HookJson ([ordered]@{
        systemMessage      = $msg + $tail
        hookSpecificOutput = [ordered]@{
            hookEventName     = 'PreToolUse'
            additionalContext = $msg + "`n" + $advice
        }
    })
    exit 0
}
catch {
    Dbg "error: $($_.Exception.Message)"
    exit 0
}
