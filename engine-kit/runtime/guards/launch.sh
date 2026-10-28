#!/bin/sh
# launch.sh - cheap prefilter of the engine-kit guards hook (runtime, guards).
#
# Wired in hooks/hooks.json as a shell-form command:
#   sh "${CLAUDE_PLUGIN_ROOT}/runtime/guards/launch.sh" <post|commit|ci> [tag]
# It reads the hook JSON from stdin and starts PowerShell (hook.ps1) only when the event
# can concern a project that opted in; anything else exits 0 at once:
#   post   - PostToolUse Edit|Write|MultiEdit: a .engine-kit/guards.json exists in the
#            folder of the edited file or one of its parents (or in the payload cwd's chain)
#            and it names an edit guard ("encoding" or "revert"; a file that only turns the
#            commit door on has nothing to check after an edit);
#   commit - PreToolUse Bash|PowerShell: the command (tool_input.command, not the rest of
#            the payload) mentions git/svn ... commit;
#   ci     - PreToolUse Bash|PowerShell: the command mentions svn ci.
#            For a commit, hook.ps1 resolves the project folder (a command such as
#            "cd <dir> && git commit" leaves the payload cwd). Only when the command has
#            no folder move that hook.ps1 follows (cd, chdir, pushd, Set-Location, sl,
#            git -C) is the commit folder the payload cwd, so a cwd chain without
#            .engine-kit/guards.json ends here too.
# The guards and the commit door (EK#14) share this prefilter and one PowerShell process.
# The optional [tag] only keeps the hooks.json handlers distinct; it is ignored.
#
# POSIX sh (Git Bash on Windows, sh on macOS / Linux); besides builtins it runs only cat.
# PowerShell: powershell.exe (Windows PowerShell 5.1), else pwsh (PowerShell 7).
# Always exits 0: the guards and the door warn, they never break the tool call.

p=$(cat)
[ -n "$p" ] || exit 0

# json_command: the "command" string of the payload in $cmdv, JSON escapes left as they
# are (an escaped quote does not end it). Parameter expansion only.
json_command() {
  cmdv=
  case "$p" in *'"command"'*) ;; *) return 0 ;; esac
  r=${p#*\"command\"}
  r=${r#*\"}
  while :; do
    case $r in *\"*) ;; *) cmdv=$cmdv$r; return 0 ;; esac
    h=${r%%\"*}
    r=${r#*\"}
    cmdv=$cmdv$h
    # the quote is escaped when an odd run of backslashes precedes it
    t=$h
    while :; do case $t in *'\\') t=${t%??} ;; *) break ;; esac; done
    case $t in *'\') cmdv=$cmdv'"' ;; *) return 0 ;; esac
  done
}

# the command itself, not the whole payload (a description or a path may say "commit")
case "$1" in
  commit|ci)
    json_command
    case "$1:$cmdv" in
      commit:*git*commit*|commit:*svn*commit*|ci:*svn*' ci'*) ;;
      *) exit 0 ;;
    esac ;;
  post) ;;
  *) exit 0 ;;
esac

# json_path KEY: raw value of the first "KEY": "..." of the payload in $v, with the JSON
# doubled backslashes turned into forward slashes (every shell and PowerShell accept them).
# Parameter expansion only: on Windows each extra process costs tens of milliseconds.
json_path() {
  v=
  case "$p" in *"\"$1\""*) ;; *) return 0 ;; esac
  v=${p#*\"$1\"}
  v=${v#*\"}
  v=${v%%\"*}
  while :; do
    case $v in
      *'\\'*) a=${v%%\\\\*}; b=${v#*\\\\}; v=$a/$b ;;
      *) break ;;
    esac
  done
}

found=
cfgfile=
for key in file_path cwd; do
  json_path "$key"
  # a \uXXXX escape (a serializer that escapes non-ASCII) cannot be resolved here: let hook.ps1 decide
  case $v in *\\u*) found=1; break ;; esac
  d=$v
  while [ -n "$d" ]; do
    if [ -f "$d/.engine-kit/guards.json" ]; then found=1; cfgfile=$d/.engine-kit/guards.json; break 2; fi
    n=${d%/*}
    [ "$n" = "$d" ] && break
    d=$n
  done
done

if [ "$1" = post ]; then
  # an edit outside every opted-in project: done, PowerShell never starts
  [ -n "$found" ] || exit 0
  # a project whose config names no edit guard (the commit door alone): done too
  if [ -n "$cfgfile" ]; then
    edit=
    while IFS= read -r l || [ -n "$l" ]; do
      case $l in *'"encoding"'*|*'"revert"'*) edit=1; break ;; esac
    done < "$cfgfile"
    [ -n "$edit" ] || exit 0
  fi
elif [ -z "$found" ]; then
  # a commit whose folder is the payload cwd (no folder move in the command) outside every
  # opted-in project: done
  json_path cwd
  if [ -n "$v" ]; then
    case $cmdv in
      *[Cc][Dd]*|*[Cc][Hh][Dd][Ii][Rr]*|*[Pp][Uu][Ss][Hh][Dd]*|*[Ss][Ee][Tt]-[Ll][Oo][Cc][Aa][Tt][Ii][Oo][Nn]*) ;;
      *[Ss][Ll]' '*|*[Ss][Ll]'\'*|*-C*) ;;
      *) exit 0 ;;
    esac
  fi
fi

ps=
for c in powershell.exe pwsh; do
  if command -v "$c" >/dev/null 2>&1; then ps=$c; break; fi
done
if [ -z "$ps" ]; then
  [ -n "$found" ] && printf '%s' '{"systemMessage":"engine-kit guards: .engine-kit/guards.json found but no PowerShell (powershell.exe or pwsh) on PATH - guards and commit door skipped."}'
  exit 0
fi

here=${0%/*}
[ "$here" = "$0" ] && here=${0%\\*}   # a Windows path with backslashes only
[ "$here" = "$0" ] && here=.
printf '%s' "$p" | "$ps" -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "$here/hook.ps1"
exit 0
