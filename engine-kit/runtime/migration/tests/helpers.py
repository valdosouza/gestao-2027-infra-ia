"""Shared helpers of the migration tests: scratch folders, the fictional base of the
shipped example (an order-handling product's old notes and a team knowledge base), the
CLIs run in-process, tree fingerprints. Everything happens under one temporary folder."""

import contextlib
import hashlib
import io
import json
import os
import shutil
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
TOOL = os.path.dirname(HERE)
if TOOL not in sys.path:
    sys.path.insert(0, TOOL)

EXAMPLE_CONFIG = os.path.join(TOOL, 'migration.example.json')
EXAMPLE_MANIFEST = os.path.join(TOOL, 'manifest.example.csv')

CHECKOUT = '\n'.join([
    '---',
    'title: Checkout flow',
    'vcs_revision: r120',
    'kind: note',
    '---',
    '# Checkout flow',
    '',
    'The refund rule is in [refund](refund-rule.md#when) and the rounding in [[tax-rounding]].',
    'A copy lived at D:/old-notes/notes/orders/checkout-flow.md before the move.',
    'See also [gone](missing.md), [site](https://example.com/x) and [top](#checkout-flow).',
    '',
    '```text',
    '[not a link](refund-rule.md)',
    '```',
    ''])
REFUND = '# Refunds are full or none\r\n\r\nA partial refund is refused.\r\n'
README = '# Old notes\n\nStart at [checkout](notes/orders/checkout-flow.md).\n'
TAX = '---\nvcs_revision: r88\nvcs_author: dev-q\n---\n# Tax is rounded per line\n\nSource body.\n'
TAX_TARGET = '---\nid: K-BILLING-001\n---\n# Tax is rounded per line\n\n**Scope**: case\n\nKept body.\n'
QUESTIONS = '# Open questions\n\n- Does a refund reopen the order?\n'
PDF = b'%PDF-1.4\n\x00\xff\xfe fictional binary\n'


def write(path, body):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    data = body if isinstance(body, bytes) else body.encode('utf-8')
    with open(path, 'wb') as handle:
        handle.write(data)


def read_bytes(path):
    with open(path, 'rb') as handle:
        return handle.read()


def read(path):
    return read_bytes(path).decode('utf-8')


def load_json(path):
    return json.loads(read(path))


def fingerprint(root):
    """{relative path: sha256} of every file under root."""
    out = {}
    for dirpath, _, files in os.walk(root):
        for name in files:
            full = os.path.join(dirpath, name)
            out[os.path.relpath(full, root).replace(os.sep, '/')] = hashlib.sha256(read_bytes(full)).hexdigest()
    return out


def run(main, argv):
    """A tool's main() in-process: (exit code, stdout + stderr)."""
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
        try:
            code = main(argv)
        except SystemExit as exc:  # argparse errors
            code = exc.code
    return code, buf.getvalue()


class Scratch(unittest.TestCase):
    """A test case with its own scratch folder holding the fictional base."""

    def setUp(self):
        self.tmp = tempfile.mkdtemp(prefix='ek-migration-')
        self.old = self.path('old-notes')
        self.kb = self.path('kb')
        write(os.path.join(self.old, 'README.md'), README)
        write(os.path.join(self.old, 'notes', 'orders', 'checkout-flow.md'), CHECKOUT)
        write(os.path.join(self.old, 'notes', 'orders', 'refund-rule.md'), REFUND)
        write(os.path.join(self.old, 'notes', 'orders', 'invoice-sample.pdf'), PDF)
        write(os.path.join(self.old, 'notes', 'billing', 'tax-rounding.md'), TAX)
        write(os.path.join(self.old, 'notes', 'billing', 'open-questions.md'), QUESTIONS)
        write(os.path.join(self.old, 'scratch', 'todo.txt'), 'not in the manifest\n')
        write(os.path.join(self.kb, 'projects', 'shop', 'SUBJECT', 'BILLING', 'KNOWLEDGE', 'tax-rounding.md'),
              TAX_TARGET)

    def tearDown(self):
        shutil.rmtree(self.tmp, ignore_errors=True)

    def path(self, *parts):
        return os.path.join(self.tmp, *parts)

    def manifest(self, rows, name='manifest.csv'):
        path = self.path(name)
        write(path, 'source,target,batch,kind,note\n' + ''.join(','.join(r) + '\n' for r in rows))
        return path

    def clean_manifest(self):
        """The example manifest without its open row (every row resolvable)."""
        with open(EXAMPLE_MANIFEST, 'r', encoding='utf-8') as handle:
            lines = [l for l in handle.read().splitlines() if 'open-questions' not in l]
        path = self.path('clean.csv')
        write(path, '\n'.join(lines) + '\n')
        return path
