# 🔑 Secrets Protection Setup — Remediate, Prevent, Detect

**Scope**: method
**Goal**: Get leaked secrets out fast and keep new ones from ever reaching git
**Applies to**: any stack — the technique is the same; only the file names change

---

## 🚫 Rule Zero (before anything else)

**A report about leaked secrets never contains the secret value; record type, location, line and risk only.**

The same goes for commit messages, issues, chat, screenshots and CI logs. A report that
quotes the key is a second leak.

| Type | Location | Line | Risk | Action |
|------|----------|------|------|--------|
| API key (cloud provider) | `config/<file>` | 14 | High — public repo | Rotated; history rewrite pending |
| DB password | `scripts/<file>.sh` | 9 | Medium — private repo | Moved to env var; rotated |

---

## 📋 Summary

1. 🔴 **Rotate first** — revoke/rotate every exposed credential
2. 🧹 **Rewrite history** — remove the secret from every commit (BFG or git filter-repo)
3. 🛡️ **Prevent** — ignore rules, pre-commit hook, `.example` files
4. 🔍 **Detect** — secret scanning in CI on every push and pull request
5. 📚 **Document** — a short local-secrets setup guide for the team

---

## 🔴 CRITICAL CASE: Secrets Already Committed

### Step 0: Rotate the credential FIRST

The secret is compromised the moment it is pushed. Rewriting history does **not**
un-leak it: forks, clones, caches, CI logs and scanners may already have it.

1. Revoke or rotate the key/password at its provider — **now**, before the cleanup
2. Check the provider's access logs for use since the leak
3. Record the leak with Rule Zero (type, location, line, risk — never the value)

Only then clean the history — the cleanup protects the future, the rotation protects
the present.

### Step 1: Rewrite history

Both tools work on a fresh clone. Keep the list of values to scrub in a local file
**outside** the repository and delete it afterwards — it contains the secrets.

#### Option 1: BFG Repo-Cleaner (fast, simple)

```bash
git clone --mirror <repo-url> repo-mirror.git

# Remove a whole file from every commit
bfg --delete-files <secret-file-name> repo-mirror.git

# Or replace literal values everywhere (one value per line in replacements.txt)
bfg --replace-text ../replacements.txt repo-mirror.git

cd repo-mirror.git
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force
```

> BFG protects the current commit by default: remove the secret from HEAD with a normal
> commit first, then run BFG.

#### Option 2: git filter-repo (full control)

The git project recommends `git filter-repo` instead of the old `git filter-branch`
(slow and error-prone).

```bash
git clone <repo-url> repo-clean && cd repo-clean

# Drop a file from every commit
git filter-repo --invert-paths --path <path/to/secret-file>

# Or replace literal values everywhere
git filter-repo --replace-text ../replacements.txt

# filter-repo removes 'origin' on purpose (to prevent an accidental push) - add it back
git remote add origin <repo-url>
git push origin --force --all
git push origin --force --tags
```

> A normal clone has only the default branch locally: check out every branch that
> carries the secret before rewriting, or use a mirror clone.

### Step 2: After the rewrite

- [ ] **Warn the team BEFORE the force push** — it rewrites everyone's history
- [ ] Every collaborator re-clones (an old clone pushes the secret right back)
- [ ] Ask the hosting provider to purge cached views if the repository was ever public
- [ ] Scan the rewritten history again (see 🔍 below) — zero findings

---

## ✅ SETUP FOR THE FUTURE

### Step 1: Ignore Rules by Category

Ignore **categories** of sensitive files, not just one stack's file names:

```gitignore
# ===== Environment files =====
.env
.env.*
!.env.example

# ===== Private keys and keystores =====
*.pem
*.key
*.p12
*.pfx
*.jks
*.keystore

# ===== Cloud / service credentials =====
credentials.json
service-account*.json
.aws/
.azure/
.gcp/

# ===== App config that holds secrets =====
config/secrets.*
*.local.json

# ===== Database dumps =====
*.dump
*.sql.gz
```

**Stack examples** (add what your stack generates — the category is what matters):

| Stack | Typical secret-bearing files |
|-------|------------------------------|
| Node.js / web | `.env*`, `.npmrc` with an auth token |
| Python | `.env`, `local_settings.py`, `.pypirc` |
| Java / JVM | `application-local.properties`, `*.jks`, `gradle.properties` with signing passwords |
| .NET | `appsettings.*.json` with secrets (prefer user-secrets), `*.pfx`, `*.publishsettings` |
| Mobile (any platform) | per-platform service config files that embed API keys, signing keystores, `local.properties` |
| Infrastructure as code | `*.tfvars`, `*.tfstate` (state stores secrets in clear text), `kubeconfig` |
| Desktop / legacy | `*.ini` / `*.conf` holding connection strings |

⚠️ **Avoid broad name globs** such as `*secret*`, `*token*` or `*password*`: they also
ignore code and docs whose names contain those words — a guide like this one included —
and silently drop them from version control. Prefer exact names and extensions; if you
keep a broad glob, add `!` exceptions and check with:

```bash
git check-ignore -v <file>   # shows which rule ignores the file
```

**Commit:**
```bash
git add .gitignore
git commit -m "chore: ignore sensitive file categories"
```

> Ignoring a file does not untrack it: if it was already committed, run
> `git rm --cached <file>` too — and go back to the CRITICAL CASE above.

---

### Step 2: Install a Pre-Commit Hook

The hook blocks a commit whose **added lines** look like a credential. It prints
`file:line` only — never the matched value (Rule Zero).

#### Manual installation (no dependencies)

Save as `.git/hooks/pre-commit`:

```sh
#!/bin/sh
# Blocks staged lines that look like credentials. Reports file:line only.
PATTERN='(api[_-]?key|client[_-]?secret|secret[_-]?key|access[_-]?token|passw(or)?d)[[:space:]]*[:=]|-----begin [a-z ]*private key-----'

if ! git diff --cached -U0 --no-color --diff-filter=ACM | awk -v pat="$PATTERN" '
    /^\+\+\+ b\// { file = substr($0, 7); next }
    /^@@/         { split($3, a, ","); line = substr(a[1], 2) + 0; next }
    /^\+/         { if (tolower($0) ~ pat) { print "possible secret: " file ":" line; found = 1 } line++; next }
    END           { exit found ? 1 : 0 }'
then
    echo "pre-commit: commit blocked - move the value to an ignored file or env var" >&2
    exit 1
fi
exit 0
```

```bash
chmod +x .git/hooks/pre-commit
```

#### Installation with the `pre-commit` framework (shareable with the team)

```bash
pip install pre-commit          # or: pipx install pre-commit
```

`.pre-commit-config.yaml` at the repo root:

```yaml
repos:
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0                 # pin a release; update deliberately
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']
```

```bash
detect-secrets scan --all-files > .secrets.baseline   # record known false positives
pre-commit install
```

(`gitleaks` also ships a pre-commit hook — use one scanner, not three.)

**Test** (with an obviously fake value):
```bash
echo 'api_key = "FAKE-TEST-VALUE"' > hook-test.txt
git add hook-test.txt
git commit -m "test"        # ❌ BLOCKED, prints hook-test.txt:1

git reset hook-test.txt && rm hook-test.txt
```

> `git commit --no-verify` skips any local hook — that is why CI scanning (below) is
> the second net.

---

### Step 3: Create `.example` Files

Commit a template with the **same keys** and **obviously fake values**; keep the real
file ignored. Developers copy the template and fill it in locally.

`.env.example`:
```bash
# Copy to .env and fill in real values. Never commit .env.
DATABASE_URL=<connection-string>
API_KEY=<your-api-key>
SMTP_PASSWORD=<smtp-password>
```

The same pattern covers any generated config: commit `<name>.example.<ext>` with
placeholders, ignore `<name>.<ext>`, and pair the rules in `.gitignore`
(`.env.*` + `!.env.example`).

**Commit:**
```bash
git add .env.example
git commit -m "docs: add example config without secrets"
```

---

### Step 4: Document for the Team

Create `SETUP_LOCAL_SECRETS.md` at the root:

````markdown
# Local Secrets Setup

## ⚠️ Never commit
- `.env`, `.env.*` (except `.env.example`)
- <the stack's secret-bearing config files>
- private keys and keystores

## First-time setup
1. Get the values from <the team's secrets manager / the provider's console>
2. Copy the templates: `cp .env.example .env`
3. Fill in the real values locally
4. Confirm they are ignored: `git check-ignore -v .env` (must print a rule)

## If you committed a secret
1. Tell the team lead immediately — do not paste the value anywhere
2. Rotate the credential at its provider FIRST
3. Clean the history (BFG or git filter-repo) and re-clone
````

---

## 🔍 CI Secret Scanning

Local hooks can be skipped; CI cannot. Scan the **full history** on every push and pull
request, with **redaction on**, and fail the build on a finding.

### GitHub Actions example: `.github/workflows/secret-scan.yml`

```yaml
name: secret-scan

on:
  push:
  pull_request:

jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0        # full history: a secret deleted later still counts

      - name: Scan for secrets (values redacted)
        run: |
          docker run --rm -v "$PWD:/repo" ghcr.io/gitleaks/gitleaks:<pinned-version> \
            detect --source /repo --redact --exit-code 1
```

Any other CI does the same three things: full checkout, scanner with redaction, non-zero
exit on a finding. If the hosting provider offers server-side secret scanning or push
protection, turn it on too.

**Commit:**
```bash
git add .github/workflows/secret-scan.yml
git commit -m "ci: add secret scanning"
```

---

## 📊 Implementation Checklist

- [ ] Exposed credentials **rotated first**
- [ ] Leak recorded as type / location / line / risk — **no value**
- [ ] History rewritten (BFG or git filter-repo); team re-cloned
- [ ] `.gitignore` covers the categories; no broad glob hides code or docs
- [ ] Pre-commit hook installed (manual or framework)
- [ ] `.example` files committed with fake values
- [ ] `SETUP_LOCAL_SECRETS.md` written
- [ ] CI secret scan running on push and pull request
- [ ] Team informed

---

## 📚 Quick Reference

| Tool | Command | Use |
|------|---------|-----|
| BFG | `bfg --delete-files FILE` / `bfg --replace-text FILE` | Remove a file or values from history |
| git filter-repo | `git filter-repo --invert-paths --path FILE` | Same, with full control |
| git | `git check-ignore -v FILE` | Which rule ignores a file |
| pre-commit | `pre-commit install` | Install shared hooks |
| detect-secrets | `detect-secrets scan` | Find secret patterns; baseline for false positives |
| gitleaks | `gitleaks detect --redact` | Scan history, values redacted |
| trufflehog | `trufflehog git file://. --only-verified` | Deep scan, verifies live credentials |

---

## ❓ Related

1. [GIT_SECURITY.md](GIT_SECURITY.md) — what never to commit
2. [GITIGNORE_TEMPLATES.md](GITIGNORE_TEMPLATES.md) — base `.gitignore` per project type
3. [SECURITY_SUMMARY.md](SECURITY_SUMMARY.md) — the layered defenses at a glance
4. The `git-security` skill ([../SKILL.md](../SKILL.md)) — the check before every push
