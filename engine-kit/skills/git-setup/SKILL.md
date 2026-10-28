---
name: git-setup
description: Use when making the first commit of a project, putting a project or a knowledge base under Git (local only, or with a remote on any host), configuring a new repository, or adding a .gitignore.
---

# Skill: Git Setup - Initialize a Repository

**Goal**: Put a project under Git versioning - local only, or with a remote on any host  
**Time**: ~10 minutes  
**Prerequisite**: Git installed
**Scope**: method
**Maturity**: operating

---

## When to Use

- First commit of a project
- A knowledge base that must be under version control (Day 1 of a case: a local
  repository is enough)
- Migrating a project to Git
- Configuring a new repository
- Adding a .gitignore

---

## Flow

### Step 1: Prepare the Environment

```bash
# 1. Go to the project folder
cd <workspace-root>/<project>

# 2. Check whether Git is already initialized
git status
# If it returns the error "not a git repository" -> continue
```

### Step 2: Initialize Git

```bash
# 1. Initialize the local repository
git init

# 2. Create the appropriate .gitignore (see examples below)
# Copy according to the project type

# 3. Configure Git (if not done globally yet)
git config user.name "<owner>"
git config user.email "<email>"

# 4. Check that what you mean to version is not ignored
#    (a global ignore pattern can silently keep every .md out)
git check-ignore -v <a file you mean to version>
# No output -> the file is not ignored
```

### Step 3 (optional): Add a Remote

A local repository is complete on its own: history, diffs and checkpoint commits all work
without a remote, and a solo knowledge base may stay local - the kit's installation only
asks for version control. Add a remote when the work must be shared or kept elsewhere, on
any host: a hosted service, a company server, a bare repository on a share. Creating the
remote repository and granting access to it are the owner's acts.

```bash
# 1. The owner creates an EMPTY repository on the chosen host (no README, no .gitignore,
#    so the first push does not conflict) and gives its URL:
#    an HTTPS or SSH URL of the host, or the path of a bare repository

# 2. Add it as a remote
git remote add origin <remote-url>

# 3. Verify the remote
git remote -v
# Should show origin <remote-url> twice, (fetch) and (push)
```

Without a remote, record it as a choice of the case (local only), so that nobody reads it
as an oversight; a remote can be added at any time later.

### Step 4: First Commit - prepared; the owner runs it

The assistant prepares the commands below with every path written out; the owner reads
the staged list and runs the commit and, with a remote, the push (prepare-only: a commit
and a push are the owner's acts). Stage by path - never `git add .` or `git add -A`, which
sweep in whatever the folder holds: a secret, a build output, another session's scratch
file.

```bash
# 1. What is there
git status --short

# 2. Stage by path - each path named (the .gitignore first)
git add .gitignore
git add README.md <path> <path>

# 3. Check: the staged list is exactly the intended one, and no secret is in it
git status --short
git diff --cached --stat

# 4. Initial commit - the owner runs it
git commit -m "Initial commit: project setup"

# 5. Rename branch (if needed)
git branch -M main

# 6. Only with a remote (step 3): push - the owner runs it
git push -u origin main
# -u flag: sets origin/main as the upstream of main
```

---

## .gitignore by Project Type

Three labelled examples, one per kind of stack; take the closest and adapt it to the
project's own stack - the kit assumes none. Whatever the stack, secrets (`.env`, keys,
credentials) stay out ([`git-security`](../git-security/SKILL.md)).

### Example A - a service on Node.js + TypeScript

```
# Dependencies
node_modules/
package-lock.json
yarn.lock

# Build
dist/
build/
*.tsbuildinfo

# Environment
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
logs/
*.log
npm-debug.log*
yarn-error.log*

# Testing
coverage/
.nyc_output/
```

### Example B - a compiled application (a native toolchain shown)

```
# Compiler output
*.o
*.obj
*.a
*.so
*.dll
*.exe
*.pdb

# Build
build/
out/
bin/

# IDE
.idea/
*.swp

# OS
.DS_Store
Thumbs.db
```

### Example C - documentation only (Markdown)

```
# OS
.DS_Store
Thumbs.db
*.swp

# IDE
.vscode/
.idea/

# Temp
temp/
tmp/
*.tmp
```

---

## Post-Setup Checklist

- [ ] Git initialized (`git status` returns "On branch main")
- [ ] What must be versioned is not ignored (`git check-ignore -v <file>` prints nothing)
- [ ] .gitignore created and committed
- [ ] First commit prepared (staged by path, list checked) and run by the owner
- [ ] With a remote: `git remote -v` shows origin, the push was run by the owner, and the
      branch is visible on the host
- [ ] Without a remote: recorded as a choice of the case (local only)

---

## Troubleshooting

### "fatal: not a git repository"
-> Run `git init` in the folder

### "Permission denied" when pushing
-> Check the credentials for the host: an SSH key, or the credential manager that comes
   with Git
-> Never keep a password in plain text (`credential.helper store` writes it unencrypted)

### "The remote origin already exists"
-> `git remote -v` shows it; `git remote set-url origin <remote-url>` changes it

### Empty folder does not appear in Git
-> Git only tracks files. Create `.gitkeep` in empty folders

---

## Next Step

After setup, use the [`git-commit-push`](../git-commit-push/SKILL.md) skill for daily commits

---

*Skill created: 2026-07-04*  
*Responsible agent: Git specialist*
