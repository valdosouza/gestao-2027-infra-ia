#!/usr/bin/env python3
"""A stand-in test command for the testing group's tests: writes a JUnit XML file and
prints a summary, from a JSON spec. Not a test framework; never used outside the tests.

  python fake_suite.py <spec.json>
  spec: {"tests": {"Cls.name": "pass" | "fail" | "error" | "skip"}, "out": "<xml path>",
         "exit": <int, default 1 when a test fails or errors, else 0>,
         "declared": <int written as tests="..."; default the real count>,
         "write": true, "sleep": 0, "marker": "<file created when the command runs>"}
"""

import json
import sys
import time
from xml.sax.saxutils import quoteattr


def main():
    with open(sys.argv[1], 'r', encoding='utf-8') as fh:
        spec = json.load(fh)
    if spec.get('marker'):
        open(spec['marker'], 'a').close()
    time.sleep(float(spec.get('sleep', 0)))
    tests = spec.get('tests', {})
    bad = sum(1 for v in tests.values() if v in ('fail', 'error'))
    cases = []
    for tid, outcome in tests.items():
        cls, _, name = tid.rpartition('.')
        body = {'fail': '<failure message="expected 1, got 2"/>', 'error': '<error message="boom"/>',
                'skip': '<skipped/>'}.get(outcome, '')
        cases.append('    <testcase classname=%s name=%s>%s</testcase>' % (quoteattr(cls), quoteattr(name), body))
    declared = spec.get('declared', len(tests))
    xml = ('<?xml version="1.0" encoding="UTF-8"?>\n<testsuites tests="%d">\n  <testsuite name="fake" tests="%d">\n%s\n'
           '  </testsuite>\n</testsuites>\n' % (declared, declared, '\n'.join(cases)))
    if spec.get('write', True):
        with open(spec['out'], 'w', encoding='utf-8') as fh:
            fh.write(xml)
    print('Tests found: %d, failing: %d' % (len(tests), bad))
    for tid, outcome in tests.items():
        if outcome in ('fail', 'error'):
            print('FAIL: %s' % tid)
    code = spec.get('exit')
    sys.exit(code if code is not None else (1 if bad else 0))


if __name__ == '__main__':
    main()
