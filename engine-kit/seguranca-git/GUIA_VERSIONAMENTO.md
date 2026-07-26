# 🔄 Guia de Versionamento — <empresa> + GitHub

**Objetivo**: Manter código versionado com Git e publicado no GitHub  
**Conta**: https://github.com/<conta-github>  
**Status**: Setup em Progresso
**Escopo**: metodo

---

## 📊 Estrutura de Repositórios

### Projetos a Versionados

```
GitHub: github.com/<conta-github>/

├── <repo-api>                    (Node.js + TypeScript)
│   ├── src/
│   ├── dist/
│   ├── package.json
│   ├── tsconfig.json
│   └── .gitignore
│
├── <repo-sync>                   (Node.js + TypeScript)
│   ├── src/
│   ├── dist/
│   ├── package.json
│   ├── tsconfig.json
│   └── .gitignore
│
├── <repo-legado>                 (Delphi Legado)
│   ├── source/
│   ├── exe/
│   ├── lib/
│   └── .gitignore
│
├── <repo-docs>                   (Documentação + Agentes + Skills)
│   ├── docs/
│   ├── agents/
│   ├── skills/
│   └── .gitignore
│
└── <repo-aprendizado>            (Modelos legados para referência)
    ├── model/
    ├── dataobjects/
    └── .gitignore
```

**Total**: 5 repositórios

---

## 🔧 Configuração Local

### 1. Instalar Git
```bash
# Windows
https://git-scm.com/download/win

# OU via Chocolatey
choco install git
```

### 2. Configurar Git Globalmente
```bash
git config --global user.name "<responsável>"
git config --global user.email "<email>"
git config --global core.autocrlf true
```

### 3. Autenticação GitHub
```bash
# Opção A: Personal Access Token (Recomendado)
# 1. GitHub → Settings → Developer settings → Personal access tokens
# 2. Gerar token com: repo, read:user, user:email
# 3. Guardar token seguro

# Opção B: SSH Key
git config --global core.sshCommand "ssh -i ~/.ssh/id_ed25519"
ssh-keygen -t ed25519 -C "<email>"
# Copiar chave pública para GitHub
```

---

## 📁 Fluxo: Inicializar Repositório Localmente

### Para cada projeto:

```bash
# 1. Ir para pasta
cd <raiz-do-workspace>\<projeto-api>

# 2. Inicializar Git
git init

# 3. Adicionar GitHub como remote
git remote add origin https://github.com/<conta-github>/<repo-api>.git

# 4. Criar .gitignore
echo "node_modules/" > .gitignore
echo "dist/" >> .gitignore
echo ".env" >> .gitignore
echo ".DS_Store" >> .gitignore

# 5. Primeiro commit
git add .
git commit -m "Initial commit: Setup <projeto-api>"

# 6. Push para GitHub
git branch -M main
git push -u origin main
```

---

## 📋 Padrão de Commits

### Convenção Conventional Commits

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Tipos

| Tipo | Exemplo | Descrição |
|------|---------|-----------|
| `feat` | `feat(auth): add JWT validation` | Nova feature |
| `fix` | `fix(db): resolve connection timeout` | Bug fix |
| `docs` | `docs: update README` | Documentação |
| `style` | `style: format code` | Formatação (sem lógica) |
| `refactor` | `refactor(api): simplify routes` | Refatoração |
| `test` | `test: add unit tests` | Testes |
| `chore` | `chore: update dependencies` | Manutenção |

### Exemplo Completo

```bash
git commit -m "feat(core): implement multi-tenant authentication

- Add JWT parsing with tenantId
- Implement feature flag middleware
- Add tenant context to Request object

Closes #123"
```

---

## 🔄 Fluxo Diário: Versionar Código

```bash
# 1. Verificar status
git status

# 2. Adicionar arquivos
git add src/
git add package.json

# 3. Commit com mensagem clara
git commit -m "feat(api): add new endpoint /users"

# 4. Push para GitHub
git push origin main
```

---

## 🌿 Branching Strategy (Git Flow)

### Branches Principais

```
main/
├── (stable, production-ready)
│
develop/
├── (integration, latest features)
│
feature/nova-feature
├── (desenvolvimento de feature)
│
hotfix/bug-critico
└── (fix urgente em produção)
```

### Fluxo

```bash
# 1. Criar branch feature
git checkout -b feature/nova-funcionalidade

# 2. Desenvolver e commitar
git add .
git commit -m "feat: implement new feature"

# 3. Push para origin
git push origin feature/nova-funcionalidade

# 4. Criar Pull Request no GitHub
# → Review → Merge para develop

# 5. Quando pronto para produção
# → Merge develop → main
# → Tag release
git tag v1.0.0
git push origin v1.0.0
```

---

## 🏷️ Versionamento Semântico

### Formato: MAJOR.MINOR.PATCH

| Tipo | Exemplo | Quando |
|------|---------|--------|
| **MAJOR** | 1.0.0 → 2.0.0 | Breaking changes |
| **MINOR** | 1.0.0 → 1.1.0 | Nova feature (compatível) |
| **PATCH** | 1.0.0 → 1.0.1 | Bug fix |

### Exemplos

```bash
# Primeira release
git tag -a v1.0.0 -m "Initial release"
git push origin v1.0.0

# Feature release
git tag -a v1.1.0 -m "Add multi-tenant support"
git push origin v1.1.0

# Bug fix
git tag -a v1.0.1 -m "Fix authentication bug"
git push origin v1.0.1
```

---

## 📊 .gitignore Padrão

### <projeto-api> / <projeto-sync> (Node.js)
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
*.log
npm-debug.log*

# Testing
coverage/
.nyc_output/
```

### <projeto-legado> (Delphi)
```
# Delphi
*.dcu
*.o
*.a
*.so
__history/
__recovery/
*.local

# Build
Win32/
Win64/

# IDE
.idea/

# OS
.DS_Store
Thumbs.db
```

### <projeto-docs> (Markdown)
```
# Geral
.DS_Store
Thumbs.db
*.swp
.vscode/

# Arquivos temporários
temp/
tmp/
*.tmp
```

---

## 🔗 URLs dos Repositórios

Criar em: https://github.com/new

```
1. <repo-api>
   https://github.com/<conta-github>/<repo-api>

2. <repo-sync>
   https://github.com/<conta-github>/<repo-sync>

3. <repo-legado>
   https://github.com/<conta-github>/<repo-legado>

4. <repo-docs>
   https://github.com/<conta-github>/<repo-docs>

5. <repo-aprendizado>
   https://github.com/<conta-github>/<repo-aprendizado>
```

---

## ✅ Checklist Setup

- [ ] Git instalado
- [ ] Git configurado (user.name, user.email)
- [ ] Token GitHub criado
- [ ] 5 Repositórios criados no GitHub
- [ ] <projeto-api> inicializado e pushado
- [ ] <projeto-sync> inicializado e pushado
- [ ] <projeto-legado> inicializado e pushado
- [ ] <projeto-docs> inicializado e pushado
- [ ] <projeto-aprendizado> inicializado e pushado
- [ ] .gitignore configurado em cada repo
- [ ] Tags de versão criadas

---

## 🚀 Próximo Passo

Usar agente especializado para automatizar versionamento:

```
/SendMessage to: 'agente-git-github'

Quero versionar <projeto-api> no GitHub
```

---

**Documento Criado**: 2026-07-04  
**Status**: Setup Initial Guide
