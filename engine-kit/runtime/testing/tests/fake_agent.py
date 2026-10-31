#!/usr/bin/env python3
"""A stand-in proposal agent for the testing group's tests: reads the brief and writes a
REPORT.md (and one draft) into the proposal folder it is given. Never used outside the tests.

  python fake_agent.py <proposal dir> <revision label> <mode>
  mode: good | no-report | stray-file | touch-wc=<path>
"""

import os
import sys

SECTIONS = ('Changed code vs the suite', 'Suite run', 'Testability', 'Draft', 'Case rows',
            'Backlog candidates', 'Rule verdict')


def main():
    folder, label, mode = sys.argv[1], sys.argv[2], sys.argv[3]
    brief = sys.stdin.read() if not sys.stdin.isatty() else ''
    if mode.startswith('touch-wc='):
        with open(mode.split('=', 1)[1], 'a', encoding='utf-8') as fh:
            fh.write('changed by the agent\n')
    if mode != 'no-report':
        body = '# %s by someone\none-line summary\n\n' % label
        body += '\n'.join('## %s\nnone, because this is a fake agent (brief %d chars)\n' % (s, len(brief))
                          for s in SECTIONS)
        with open(os.path.join(folder, 'REPORT.md'), 'w', encoding='utf-8', newline='\n') as fh:
            fh.write(body)
        with open(os.path.join(folder, 'calc_test.draft.py'), 'w', encoding='utf-8', newline='\n') as fh:
            fh.write('def test_adds():\n    assert 1 + 1 == 2  # TODO record from the run\n')
    if mode == 'stray-file':
        with open(os.path.join(folder, 'notes.txt'), 'w', encoding='utf-8') as fh:
            fh.write('not allowed here\n')
    print('summary: fake proposal for %s' % label)


if __name__ == '__main__':
    main()
