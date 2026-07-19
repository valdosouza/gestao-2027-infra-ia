# 🔐 Segurança Git — O Que NÃO Commitar

**Crítico**: Prevenir dados sensíveis e código inútil no GitHub
**Escopo**: metodo

---

## ❌ NUNCA Commite (Checklist de Risco)

### 🔴 Dados Sensíveis (CRÍTICO)

| O quê | Por quê | Solução |
|-------|---------|---------|
| `.env` ou `.env.local` | Credenciais, tokens, senhas | Adicionar ao .gitignore |
| `config/secrets.json` | API keys, DB passwords | Nunca commitar |
| `private_keys/` ou `*.pem` | SSH/SSL keys | Sempre em .gitignore |
| `credentials.json` | GCP, AWS, Azure keys | NUNCA commitar |
| Tokens GitHub/NPM | Autenticação | Usar variáveis de ambiente |
| Database backups | Dados sensíveis | Nunca em Git |

### 🟠 Código Inútil (Build/Dependencies)

| O quê | Por quê | Solução |
|-------|---------|---------|
| `node_modules/` | 1000+ arquivos desnecessários | .gitignore |
| `dist/` / `build/` | Código compilado (regenerável) | .gitignore |
| `.next/` / `.vuepress/` | Build artifacts | .gitignore |
| `*.tsbuildinfo` | Typescript cache | .gitignore |
| `coverage/` | Test reports | .gitignore |
| `.cache/` | Local cache | .gitignore |

### 🟡 Arquivos Locais (Não Relevantes)

| O quê | Por quê | Solução |
|-------|---------|---------|
| `.vscode/` | Configuração IDE pessoal | .gitignore |
| `.idea/` | IntelliJ config | .gitignore |
| `.DS_Store` | macOS system file | .gitignore |
| `Thumbs.db` | Windows system file | .gitignore |
| `*.log` | Log files | .gitignore |
| `*.swp` / `*.swo` | Editor temp files | .gitignore |

---

## 📋 .gitignore Seguro — Por Projeto

### setes-api / setes-sync (Node.js)

**MÁXIMO DE SEGURANÇA**:
```
# ===== CRÍTICO: Dados Sensíveis =====
.env
.env.local
.env.*.local
.env*.production
.env*.development
secrets/
credentials.json
private_keys/
*.pem
*.key
*.crt

# ===== Código Inútil =====
node_modules/
dist/
build/
*.tsbuildinfo
.next/
out/
coverage/
.nyc_output/

# ===== Arquivos Locais =====
.vscode/
.idea/
*.swp
*.swo
.DS_Store
Thumbs.db

# ===== Logs =====
logs/
*.log
npm-debug.log*
yarn-error.log*
lerna-debug.log*

# ===== Cache =====
.cache/
.eslintcache
.parcel-cache
.turbo/
dist-ssr

# ===== Teste =====
.mocha_output/
test-results/

# ===== Package Lock (opcional) =====
# Se trabalhar em equipe:
# package-lock.json  # Deixar para todos terem mesma versão
# yarn.lock          # Deixar para todos terem mesma versão

# ===== OS Specific =====
*.exe
*.dll
*.so
```

### Sincronizador (Delphi)

```
# ===== CRÍTICO: Dados Sensíveis =====
*.ini
config.local.*
credentials.*
secrets/

# ===== Build Output =====
__history/
__recovery/
*.dcu
*.o
*.a
Win32/
Win64/
Release/
Debug/

# ===== IDE =====
.idea/
*.local

# ===== OS =====
.DS_Store
Thumbs.db
*.exe
```

### Infra-IA (Documentação)

```
# ===== Arquivos Temporários =====
temp/
tmp/
*.tmp
*.bak

# ===== IDE =====
.vscode/
.idea/

# ===== OS =====
.DS_Store
Thumbs.db
*.swp

# ===== Se tiver código fonte =====
node_modules/
dist/
```

---

## 🛡️ Proteção Adicional: Pre-commit Hooks

### Instalar Husky + Lint-staged

```bash
npm install --save-dev husky lint-staged
npx husky install
```

### Criar arquivo `.husky/pre-commit`

```bash
#!/bin/sh

# Roda verificações ANTES de fazer commit

echo "🔐 Verificando dados sensíveis..."
if git diff --cached | grep -E "(\.env|AWS_|DATABASE_|SECRET_|PASSWORD_|API_KEY|TOKEN=)" ; then
    echo "❌ ERRO: Dados sensíveis detectados!"
    echo "Verifique .env e use variáveis de ambiente"
    exit 1
fi

echo "📦 Verificando node_modules..."
if git diff --cached --name-only | grep "node_modules/" ; then
    echo "❌ ERRO: node_modules/ não deve ser commitado!"
    exit 1
fi

echo "✅ Pré-verificações OK"
exit 0
```

### Executar automaticamente

```bash
chmod +x .husky/pre-commit
```

**Resultado**: Git recusará commit se encontrar .env ou node_modules

---

## 🔍 Verificar Antes de Push

### 1. Ver o que será pushado

```bash
# Mostrar arquivos que serão enviados
git diff --cached --name-only

# Mostrar conteúdo das mudanças
git diff --cached
```

### 2. Buscar dados sensíveis

```bash
# Procurar por padrões perigosos
git diff --cached | grep -i "password\|secret\|token\|api_key"

# Procurar por .env
git diff --cached | grep "\.env"

# Procurar por node_modules
git ls-files | grep "node_modules"
```

### 3. Script de Verificação Segura

```bash
#!/bin/bash
# Salvar como: scripts/pre-push-check.sh

echo "🔍 Verificando segurança antes de push..."

# Verificar .env
if git ls-files | grep -E "\.env|secrets/|credentials" ; then
    echo "❌ CRÍTICO: Arquivos sensíveis detectados!"
    exit 1
fi

# Verificar node_modules
if git ls-files | grep "node_modules/" ; then
    echo "❌ CRÍTICO: node_modules/ no repositório!"
    exit 1
fi

# Verificar dist
if git ls-files | grep "^dist/" ; then
    echo "⚠️ AVISO: dist/ está versionado (considere .gitignore)"
fi

echo "✅ Verificações passaram!"
exit 0
```

**Uso**:
```bash
bash scripts/pre-push-check.sh
```

---

## 🚨 Se Cometeu Erro (Remover Dados Sensíveis)

### Opção 1: Se ainda não fez push

```bash
# Remover arquivo do staging
git reset HEAD .env

# Ou remover do último commit (antes de push)
git rm --cached .env
git commit --amend -m "feat: remove sensitive files"
```

### Opção 2: Se já fez push (EMERGÊNCIA)

```bash
# NUNCA faça force push sem avisar time!
# Melhor: Rodar um novo commit que remove o arquivo

git rm --cached .env
git commit -m "fix: remove .env file from repository"
git push origin main

# Depois: Regenerar tokens/senhas (foram expostos!)
```

### Opção 3: Usar BFG Repo-Cleaner (Remove da História)

```bash
# Instalar
brew install bfg  # macOS
choco install bfg  # Windows

# Remover arquivo .env da história toda
bfg --delete-files .env

# Push
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push --force
```

**⚠️ PERIGOSO**: Force push afeta todo o time

---

## ✅ Checklist de Segurança PRÉ-COMMIT

Sempre verificar ANTES de fazer `git push`:

- [ ] `.env` **NÃO** está no commit
- [ ] `credentials.json` **NÃO** está
- [ ] `*.pem` / `*.key` **NÃO** está
- [ ] `node_modules/` **NÃO** está
- [ ] `dist/` **NÃO** está (se em .gitignore)
- [ ] `.vscode/` **NÃO** está
- [ ] `*.log` **NÃO** está
- [ ] Nenhuma senha/API key em código
- [ ] `git diff --cached` está limpo
- [ ] Executei pre-push-check.sh ✅

---

## 🎯 Comandos Seguros

### Ver o que será commitado
```bash
git diff --cached --stat
```

### Remover arquivo antes de commitar
```bash
git reset HEAD arquivo-sensivel.env
```

### Revisar mudanças antes de push
```bash
git log --oneline -5  # Ver commits
git diff origin/main  # Ver diferenças antes de push
```

### Desfazer último commit (antes de push)
```bash
git reset --soft HEAD~1
# Arquivos voltam para staging, pode revisar e refazer
```

---

## 📌 Configuração Recomendada em `package.json`

```json
{
  "scripts": {
    "pre-push": "bash scripts/pre-push-check.sh",
    "pre-commit": "husky install && lint-staged"
  },
  "lint-staged": {
    "*.ts": "eslint --fix",
    "*.md": "prettier --write"
  }
}
```

---

## 🔐 GitHub: Proteção Adicional

### Settings → Secrets and variables

1. Criar secrets em GitHub (não em código):
   - DATABASE_URL
   - API_KEY
   - JWT_SECRET

2. Usar em CI/CD:
```yaml
# .github/workflows/deploy.yml
env:
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
  API_KEY: ${{ secrets.API_KEY }}
```

---

## 📚 Documentação para Time

Adicionar em `README.md` de cada projeto:

```markdown
## 🔐 Security

- **NUNCA** commit `.env` files
- **NUNCA** commit `node_modules/`
- **NUNCA** commit credentials ou API keys
- **SEMPRE** use `.gitignore`
- **SEMPRE** verifique `git diff --cached` antes de push

See [SEGURANCA_GIT.md](../SEGURANCA_GIT.md) for details.
```

---

## ✨ Resumo: O Sistema Está Seguro?

| Proteção | Status | Ação |
|----------|--------|------|
| .gitignore configurado | ✅ Sim | Usar template provided |
| Pre-commit hooks | ⏳ Opcional | Instalar Husky |
| Pre-push check script | ⏳ Criar | Adicionar a scripts/ |
| GitHub branch protection | ⏳ Setup | Ativar em Settings |
| Secrets no GitHub | ⏳ Setup | Criar secrets |
| Team awareness | ⏳ Documentar | Share SEGURANCA_GIT.md |

---

**Criado**: 2026-07-04  
**Crítico**: Ler antes de primeiro push  
**Responsável**: Valdo + Git/GitHub Specialist Agent
