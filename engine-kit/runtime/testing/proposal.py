#!/usr/bin/env python3
"""proposal.py - the proposal folder of a claimed revision (T75): the bundle the script
prepares, the brief the headless agent gets, the checks its output must pass, and the
local staging into the claims area for a human to publish, promote or reject.

Per machine, never versioned (<stateDir>/work/<key>/):
  bundle/     written by the script, read-only for the agent: revision.json, diff.patch,
              suite.json (the script ran the suite itself), prompt.md, agent.log,
              agent.settings.json (when the agent command asks for it)
  proposal/   the agent's ONLY writable folder (its working folder): REPORT.md (always)
              and draft files (<name>.draft.<ext>, configurable); nothing else, no sub-folder
  attempts/   what earlier attempts left in proposal/, moved aside before the next one

check_proposal() accepts the folder only when REPORT.md names the revision and has every
section, each draft matches the draft pattern and holds no machine path, and nothing
else is there. stage() copies the accepted files next to CLAIM.md in the private claims
working copy - a local copy; publishing is a human's commit.

Python 3.8+, standard library only.
"""

import json
import os
import re
import shutil

REPORT_SECTIONS = ('Changed code vs the suite', 'Suite run', 'Testability', 'Draft',
                   'Case rows', 'Backlog candidates', 'Rule verdict')
DEFAULT_DRAFT_PATTERN = r'^[A-Za-z0-9_.-]+\.draft\.[A-Za-z0-9]+$'
# absolute machine paths: a drive letter, or a home folder; a draft must read nothing by them
DEFAULT_FORBIDDEN = (r'(?<![A-Za-z0-9])[A-Za-z]:[\\/][^\s"\']*', r'(?<![\w.~])/(?:home|Users)/[^/\s"\']+')


def work_dirs(state_dir, key):
    base = os.path.join(state_dir, 'work', key)
    return os.path.join(base, 'bundle'), os.path.join(base, 'proposal')


def check_report(body, labels):
    """Reasons the report is not acceptable ([] = fine). labels: accepted revision labels."""
    reasons = []
    m = re.search(r'(?m)^# (\S+) by \S.*$', body)
    if not m:
        reasons.append("REPORT.md has no title '# <revision> by <author>'")
    elif m.group(1) not in labels:
        reasons.append('REPORT.md names %s, not %s' % (m.group(1), ' / '.join(labels)))
    for section in REPORT_SECTIONS:
        sm = re.search(r'(?ms)^## ' + re.escape(section) + r'[ \t]*\r?\n(.*?)(?=^## |\Z)', body)
        if not sm:
            reasons.append('REPORT.md lacks the section "%s"' % section)
        elif not sm.group(1).strip():
            reasons.append('REPORT.md section "%s" is empty (write "none" and why)' % section)
    return reasons


def machine_path_hit(body, forbidden):
    for pat in forbidden:
        m = re.search(pat, body)
        if m:
            return m.group(0)
    return ''


def check_proposal(folder, labels, draft_pattern=DEFAULT_DRAFT_PATTERN, forbidden=DEFAULT_FORBIDDEN):
    """(ok, files to publish, reasons)."""
    reasons, files = [], []
    if not os.path.isdir(folder):
        return False, [], ['no proposal folder %s' % folder]
    draft_re = re.compile(draft_pattern)
    for name in sorted(os.listdir(folder)):
        full = os.path.join(folder, name)
        if os.path.isdir(full):
            reasons.append('unexpected folder %s' % name)
            continue
        if name == 'REPORT.md':
            files.append(name)
            continue
        if draft_re.search(name) and not name.lower().endswith('.md'):
            with open(full, 'rb') as fh:
                hit = machine_path_hit(fh.read().decode('utf-8', 'replace'), forbidden)
            if hit:
                reasons.append('%s reads a machine path (%s): take files relative to the working copy' % (name, hit))
            files.append(name)
            continue
        reasons.append('unexpected file %s' % name)
    report = os.path.join(folder, 'REPORT.md')
    if not os.path.isfile(report):
        reasons.append('REPORT.md missing')
    else:
        with open(report, 'rb') as fh:
            reasons += check_report(fh.read().decode('utf-8', 'replace'), labels)
    return not reasons, files, reasons


def render_prompt(template, values):
    """The brief with its kit Scope line removed and every {KEY} filled."""
    body = re.sub(r'(?m)^\*\*Scope\*\*:[^\r\n]*(\r?\n)+', '', template, count=1)
    for key, value in values.items():
        body = body.replace('{%s}' % key, str(value))
    return body


def count_diff_lines(diff_text):
    return sum(1 for ln in diff_text.splitlines()
               if (ln.startswith('+') and not ln.startswith('+++')) or (ln.startswith('-') and not ln.startswith('---')))


def stage(src_folder, files, dest_folder):
    os.makedirs(dest_folder, exist_ok=True)
    for name in files:
        shutil.copyfile(os.path.join(src_folder, name), os.path.join(dest_folder, name))
    return [os.path.join(dest_folder, n) for n in files]


def archive_attempt(proposal_dir, attempts_dir, stamp, agent_log=None):
    """Moves what an earlier attempt left in the proposal folder (and a copy of its agent
    log) to attempts_dir/<stamp>/, so each attempt starts from an empty folder and a
    leftover never fails the next check. Returns the archive folder, or '' when empty."""
    if not os.path.isdir(proposal_dir) or not os.listdir(proposal_dir):
        return ''
    dest = os.path.join(attempts_dir, stamp)
    os.makedirs(dest, exist_ok=True)
    for name in os.listdir(proposal_dir):
        shutil.move(os.path.join(proposal_dir, name), os.path.join(dest, name))
    if agent_log and os.path.isfile(agent_log):
        shutil.copyfile(agent_log, os.path.join(dest, 'agent.log'))
    return dest


def write_agent_settings(path, proposal_dir):
    """A permission file for a headless Claude Code run: read anywhere, edit and write only
    under the proposal folder, no shell. Written when the agent command uses
    {agent_settings}; other agents take their own sandbox flags with {proposal}."""
    scope = '//' + os.path.abspath(proposal_dir).replace(os.sep, '/').lstrip('/') + '/**'
    data = {'permissions': {'allow': ['Read', 'Grep', 'Glob', 'Edit(%s)' % scope, 'Write(%s)' % scope],
                            'deny': ['Bash']}}
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as fh:
        json.dump(data, fh, indent=2)
        fh.write('\n')
    return path


def agent_command(command, values):
    """Placeholders in each argument: {prompt}, {proposal}, {bundle}, {rev},
    {agent_settings}."""
    out = []
    for arg in command:
        a = str(arg)
        for k, v in values.items():
            a = a.replace('{%s}' % k, str(v))
        out.append(a)
    return out
