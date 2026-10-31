---
name: git-push
description: Use whenever you finish a piece of work and need a minimal, safe commit-and-push flow to the remote.
---

# Skill: Git Push — Safe and Simple Delivery

**Goal**: Commit and push safely  
**Time**: 2 minutes  
**Frequency**: Whenever you finish work
**Scope**: method
**Maturity**: operating

---

## 🎯 Flow

### 1. Check what will be sent
```bash
cd <workspace-root>\[PROJECT]
git status
```

### 2. Add and Commit
```bash
git add <the paths of this change>   # by path - never "git add ." (it sweeps unrelated files and secrets)
git commit -m "[Your message here]"
```

**Standard messages**:
- `docs: [description]` — Documentation
- `feat: [description]` — New feature
- `fix: [description]` — Bug fix
- `chore: [description]` — Maintenance

### 3. Push to the remote
```bash
git push
```

---

## ✅ Automatic Safety

`.gitignore` automatically blocks:
- ✅ `.env` — will NOT be sent
- ✅ `node_modules/` — will NOT be sent
- ✅ `dist/`, `build/` — will NOT be sent
- ✅ Credentials — will NOT be sent

---

## 🔍 If Something Strange Appears

```bash
# See what will be sent
git diff --cached --name-only

# If .env appears:
git reset HEAD .env
# ❌ STOP and investigate
```

---

## 📝 Complete Example

```bash
cd <workspace-root>\<api-project>

# Check status
git status

# Add and commit
git add <the paths of this change>   # by path - never "git add ." (it sweeps unrelated files and secrets)
git commit -m "feat: add JWT authentication middleware"

# Push
git push

# ✅ Done! Code is on the remote
```

---

**Simple, Fast, Safe** 🚀
