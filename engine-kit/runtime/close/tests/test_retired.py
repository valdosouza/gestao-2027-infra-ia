r"""The retired-location rules (T88): one written location matches every spelling of it -
drive letter with either separator, escaped backslashes, a POSIX shell's /r/..., file URLs,
UNC with either separator - and nothing that only looks like it. The known defect this
guards against: patterns that caught the backslash spelling and missed the UNC and the
forward-slash ones."""

import unittest

import helpers  # noqa: F401  (puts runtime/close on the path)
import retired


def hit(location, line, **kw):
    return bool(retired.spelling_regex(location, **kw).search(line))


class Spellings(unittest.TestCase):
    def test_a_drive_location_matches_every_spelling(self):
        loc = 'R:\\old-share\\kb'
        for line in ('see R:\\old-share\\kb\\INDEX.md',
                     'see R:/old-share/kb/INDEX.md',
                     '"root": "R:\\\\old-share\\\\kb"',
                     'cd /r/old-share/kb && ls',
                     'ls /mnt/r/old-share/kb',
                     'open file:///R:/old-share/kb/INDEX.md',
                     'r:\\OLD-SHARE\\KB in lower case',
                     'mixed R:\\old-share/kb/x'):
            self.assertTrue(hit(loc, line), line)

    def test_written_with_forward_slashes_it_still_matches_backslashes(self):
        self.assertTrue(hit('R:/old-share/kb', 'R:\\old-share\\kb\\x'))

    def test_a_unc_location_matches_both_separators_and_escapes(self):
        loc = '\\\\files01\\old-share'
        for line in ('\\\\files01\\old-share\\kb',
                     '//files01/old-share/kb',
                     '"\\\\\\\\files01\\\\old-share"',
                     'file://files01/old-share/kb'):
            self.assertTrue(hit(loc, line), line)

    def test_neighbours_do_not_match(self):
        loc = 'R:\\old-share\\kb'
        for line in ('R:\\old-share\\kb2\\x',
                     'R:\\old-share\\kbase',
                     'XR:\\old-share\\kb',
                     'S:\\old-share\\kb',
                     'R:\\old-share',
                     'docs/r/old-share/kb'):
            self.assertFalse(hit(loc, line), line)

    def test_case_sensitive_when_asked(self):
        self.assertFalse(hit('R:\\Old\\Kb', 'R:\\old\\kb', case_sensitive=True))
        self.assertTrue(hit('R:\\Old\\Kb', 'r:\\Old\\Kb', case_sensitive=True))  # a drive letter never is

    def test_a_trailing_separator_means_inside_it(self):
        loc = 'C:\\Users\\'
        self.assertTrue(hit(loc, 'C:\\Users\\someone\\notes'))
        self.assertTrue(hit(loc, '/c/Users/someone'))
        self.assertFalse(hit(loc, 'the C:\\Users folder'))

    def test_a_whole_drive(self):
        self.assertTrue(hit('Q:\\', 'Q:\\anything'))
        self.assertTrue(hit('Q:', 'Q:/anything'))
        self.assertFalse(hit('Q:', 'Note Q: is the old drive'))

    def test_posix_and_relative_locations(self):
        self.assertTrue(hit('/srv/old-kb', 'path: /srv/old-kb/notes'))
        self.assertTrue(hit('/srv/old-kb', 'path: \\srv\\old-kb'))
        self.assertFalse(hit('/srv/old-kb', 'path: /srv/old-kb2'))
        self.assertTrue(hit('tools/old-engine', 'run tools\\old-engine\\x.ps1'))
        self.assertFalse(hit('tools/old-engine', 'run mytools/old-engine'))

    def test_a_url(self):
        self.assertTrue(hit('https://wiki.acme.invalid/kb', 'see https://wiki.acme.invalid/kb/page'))
        self.assertFalse(hit('https://wiki.acme.invalid/kb', 'see https://wiki.acme.invalid/kb2'))

    def test_empty_is_refused(self):
        with self.assertRaises(ValueError):
            retired.spelling_regex('  ')
        with self.assertRaises(ValueError):
            retired.spelling_regex('\\\\')


class Rules(unittest.TestCase):
    def test_config_entries(self):
        rules = retired.rules_from_config({
            'locations': ['D:\\tools\\old-engine',
                          {'spellings': ['R:\\old-share', '\\\\files01\\old-share'], 'why': 'frozen',
                           'instead': 'the KB working copy', '_note': 'ignored'},
                          {'location': 'Q:\\x'}],
            'patterns': [{'regex': r'\bold-host\b', 'instead': 'new-host'}, r'legacy-tool\.exe']})
        self.assertEqual(len(rules), 5)
        self.assertEqual(rules[1].describe(), 'R:\\old-share; frozen; instead: the KB working copy')
        self.assertTrue(rules[1].search('//files01/old-share/x'))
        self.assertTrue(rules[3].search('ping OLD-HOST now'))
        self.assertEqual(rules[4].label, 'pattern legacy-tool\\.exe')

    def test_bad_entries(self):
        for section in ({'locations': [{'spelling': 'x'}]}, {'locations': [{}]}, {'locations': [3]},
                        {'patterns': ['(']}):
            with self.assertRaises(ValueError):
                retired.rules_from_config(section)

    def test_scan_and_allow(self):
        import re
        rules = retired.rules_from_config({'locations': ['R:\\old-share']})
        allow = re.compile(r'(?i)\bretired\b')
        lines = ['one R:/old-share/a', 'R:\\old-share was retired in March', 'nothing', '//x']
        self.assertEqual([n for n, _, _ in retired.scan_text(lines, rules, allow)], [1])
        self.assertEqual([n for n, _, _ in retired.scan_text(lines, rules)], [1, 2])

    def test_superseded_head(self):
        self.assertTrue(retired.is_superseded(['# Old', '', '**SUPERSEDED**: see NEW.md']))
        self.assertFalse(retired.is_superseded(['# Doc'] + [''] * 20 + ['SUPERSEDED'], head=10))


if __name__ == '__main__':
    unittest.main()
