# Skill: Git Segurança — Verificar Antes de Commitar

**Objetivo**: Garantir que nenhum dado sensível seja enviado para GitHub  
**Tempo**: ~2 minutos  
**Crítico**: Executar ANTES de cada push
**Escopo**: metodo

---

## 🎯 Quando Usar

- ✅ SEMPRE antes de `git push`
- ✅ SEMPRE antes de `git commit` em arquivo sensível
- ✅ Ao configurar novo repositório
- ✅ Quando adicionar `.env` pela primeira vez

---

## 🔐 Verificação Rápida (30 segundos)

### Verificar Arquivos Sensíveis

```bash
# 1. Ver o que será commitado
git diff --cached --name-only

# 2. Procurar por dados sensíveis
git diff --cached | grep -i "password\|secret\|token\|api_key\|\.env"

# 3. Procurar por .env
git ls-files | grep "\.env"

# 4. Procurar por node_modules
git ls-files | grep "node_modules/"
```

**Se retornar algo**: ❌ **NÃO FAÇA PUSH** — Vá para "Remover Arquivo Sensível" abaixo

---

## ❌ Dados Sensíveis NÃO Devem Estar

```
❌ .env
❌ .env.local
❌ credentials.json
❌ secrets.json
❌ *.pem (chaves privadas)
❌ *.key (chaves privadas)
❌ config/secrets/
❌ AWS_ACCESS_KEY
❌ DATABASE_PASSWORD
❌ API_KEYS
```

**Solução**: Adicionar a `.gitignore` ANTES de usar

---

## 📦 Código Inútil NÃO Deve Estar

```
❌ node_modules/        (1000+ arquivos)
❌ dist/                (código compilado)
❌ build/               (código compilado)
❌ .next/               (Next.js cache)
❌ coverage/            (testes coverage)
❌ *.log                (logs)
```

**Verificar**:
```bash
git ls-files | wc -l
# Se > 10000 arquivos → algo errado está versionado!
```

---

## 🚨 Script de Verificação Automática

### Criar: `scripts/pre-push-check.sh`

```bash
#!/bin/bash
set -e

echo "🔐 Verificação de Segurança PRÉ-PUSH"
echo "===================================="

# 1. Verificar dados sensíveis
echo ""
echo "1️⃣ Procurando dados sensíveis..."
if git diff origin/main --stat | grep -E "\.env|credentials|secrets|\.pem|\.key" ; then
    echo "❌ ERRO: Dados sensíveis detectados!"
    echo "Remova antes de fazer push"
    exit 1
fi

# 2. Verificar node_modules
echo "2️⃣ Procurando node_modules..."
if git ls-files | grep "node_modules/" ; then
    echo "❌ ERRO: node_modules/ no repositório!"
    echo "Adicione a .gitignore e remova"
    exit 1
fi

# 3. Verificar dist/build
echo "3️⃣ Procurando código compilado..."
if git ls-files | grep -E "^dist/|^build/|^\.next/" ; then
    echo "⚠️ AVISO: Código compilado versionado"
    echo "(opcional: adicione a .gitignore)"
fi

# 4. Contar arquivos
TOTAL_FILES=$(git ls-files | wc -l)
echo ""
echo "4️⃣ Total de arquivos: $TOTAL_FILES"
if [ "$TOTAL_FILES" -gt 5000 ] ; then
    echo "❌ AVISO: Muitos arquivos versionados!"
    echo "Verifique se node_modules ou dist/ estão inclusos"
    # Não falha, apenas avisa
fi

# 5. Verificar .env
echo "5️⃣ Procurando .env..."
if [ -f ".env" ] ; then
    if git ls-files | grep "\.env$" ; then
        echo "❌ ERRO: .env foi commitado!"
        exit 1
    else
        echo "✅ .env existe localmente mas NÃO está versionado (correto)"
    fi
fi

echo ""
echo "✅ Verificações passaram!"
echo "Seguro fazer push"
exit 0
```

**Dar permissão**:
```bash
chmod +x scripts/pre-push-check.sh
```

**Usar**:
```bash
bash scripts/pre-push-check.sh
```

---

## ❌ Remover Arquivo Sensível do Staging

### Se ainda NÃO fez commit:

```bash
# Ver o que está staged
git status

# Remover arquivo do staging
git reset HEAD .env

# Ou remover múltiplos
git reset HEAD .env credentials.json
```

### Se AINDA NÃO fez push:

```bash
# Remover do último commit (antes de push)
git rm --cached .env
git add .gitignore
git commit --amend -m "fix: remove .env from repository"

# NÃO fazer push ainda!
# Verifique: git log --oneline
```

### Se JÁ fez push (⚠️ Emergência):

```bash
# 1. Regenerar todas as senhas/tokens (foram expostos!)
# 2. Remover arquivo do repositório
git rm --cached .env
git commit -m "fix: remove exposed .env from history"
git push origin main

# 3. Notify team: "Regenerem credenciais"
```

---

## ✅ Checklist PRÉ-PUSH

```
ANTES de qualquer `git push`, verificar:

□ git diff --cached | grep -i "password\|secret\|token\|api_key"
  → Se algo aparece: ❌ REMOVER

□ git ls-files | grep "\.env"
  → Se encontra: ❌ REMOVER

□ git ls-files | grep "node_modules"
  → Se encontra: ❌ VERIFICAR

□ git ls-files | wc -l
  → Se > 5000: ⚠️ INVESTIGAR

□ Executar: bash scripts/pre-push-check.sh
  → Deve retornar: ✅ "Seguro fazer push"

□ git log --oneline -5
  → Nenhum commit com credenciais

✅ Tudo OK → SAFE para git push
```

---

## 🔍 Investigar Repositório Existente

Se já tem repositório e quer verificar se algo foi commitado:

```bash
# Procurar por .env na história
git log --all --source --diff-filter=D -- '*.env'

# Procurar por credenciais
git log -p -S "password" --all

# Ver arquivos grandes (pode ser node_modules comprimido)
git rev-list --objects --all | sort -k2 | uniq | sort -rn -k1 | head -20
```

---

## 📊 Configurar .gitignore Depois (Recovery)

Se já commitou sem .gitignore:

```bash
# 1. Criar .gitignore robusto
cat > .gitignore << 'EOF'
# Sensíveis
.env
.env.local
credentials.json
*.pem
*.key

# Build
node_modules/
dist/
build/
*.tsbuildinfo

# Local
.vscode/
.idea/
*.log
.DS_Store
EOF

# 2. Remover do staging (não apagar local)
git rm --cached node_modules/ -r
git rm --cached dist/ -r
git rm --cached .env

# 3. Commit
git commit -m "chore: add .gitignore and remove build artifacts"

# 4. Push
git push
```

---

## 🛡️ Proteção Permanente: Husky

Instalar pre-commit hook que IMPEDE commit com dados sensíveis:

```bash
# 1. Instalar Husky
npm install --save-dev husky
npx husky install

# 2. Criar hook
npx husky add .husky/pre-commit 'bash scripts/pre-push-check.sh'

# 3. Testar
git add .env
git commit -m "test"
# Deve FALHAR ✅
```

**Resultado**: Git recusa commit se .env estiver staged

---

## 📱 Checklist Diário

```
Cada dia:

Morning:
□ git pull

Before Commit:
□ Verifiquei .env não está staged?
□ Verifiquei node_modules não está?
□ Rodei pre-push-check.sh?

After Push:
□ Verifiquei no GitHub que nenhum .env aparece?
```

---

## 🚨 Emergência: Removeu .env do Histórico

Se .env foi exposte e regenerou tudo:

```bash
# Usando BFG Repo-Cleaner (remove da história)
npm install -g bfg

bfg --delete-files .env

git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force

# ⚠️ AVISAR TIME ANTES DE FORCE PUSH
```

---

## 📚 Referência Rápida

| Comando | Para quê |
|---------|----------|
| `git diff --cached --name-only` | Ver arquivos no staging |
| `git reset HEAD .env` | Remover do staging |
| `bash scripts/pre-push-check.sh` | Verificar segurança |
| `git ls-files \| grep "node_modules"` | Procurar por erro |
| `git rm --cached .env` | Remover sem apagar local |

---

## ✨ Resumo: O Que Fazer

```
✅ SEMPRE:
  • git diff --cached ANTES de push
  • Verificar .env não está versionado
  • Verificar node_modules não está versionado
  • Usar .gitignore robusto
  • Executar pre-push-check.sh

❌ NUNCA:
  • Commitar .env
  • Commitar credenciais
  • Commitar node_modules
  • Force push sem avisar

🚨 SE ACONTECER:
  • Remova arquivo
  • Regenere credenciais
  • Avise o time
  • Use BFG se exposto na história
```

---

*Skill criada: 2026-07-04*  
*Crítico: Ler antes de primeiro push*  
*Agente: Git/GitHub Specialist*
