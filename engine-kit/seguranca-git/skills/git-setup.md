# Skill: Git Setup — Inicializar Repositório

**Objetivo**: Configurar um projeto para versionamento Git com GitHub  
**Tempo**: ~10 minutos  
**Pré-requisito**: Git instalado
**Escopo**: metodo

---

## 🎯 Quando Usar

- ✅ Primeiro commit de um projeto
- ✅ Migrar projeto para Git/GitHub
- ✅ Configurar novo repositório
- ✅ Adicionar .gitignore

---

## 📋 Fluxo

### Passo 1: Preparar Ambiente

```bash
# 1. Ir para pasta do projeto
cd <raiz-do-workspace>\<projeto-api>

# 2. Verificar se Git já está inicializado
git status
# Se retornar erro: "not a git repository" → continuar
```

### Passo 2: Inicializar Git

```bash
# 1. Inicializar repositório local
git init

# 2. Criar .gitignore apropriado (ver exemplos abaixo)
# Copie conforme o tipo de projeto

# 3. Configurar Git (se ainda não fez globalmente)
git config user.name "<responsável>"
git config user.email "<email>"
```

### Passo 3: Adicionar Remote GitHub

```bash
# 1. Criar repositório ANTES em GitHub
#    https://github.com/new
#    Nome: <repo-api> (exemplo)
#    Descrição: Node.js API para ERP multi-tenant
#    Privado/Público: você escolhe

# 2. Adicionar como remote
git remote add origin https://github.com/<conta-github>/<repo-api>.git

# 3. Verificar remote
git remote -v
# Deve mostrar:
# origin  https://github.com/<conta-github>/<repo-api>.git (fetch)
# origin  https://github.com/<conta-github>/<repo-api>.git (push)
```

### Passo 4: Primeiro Commit

```bash
# 1. Adicionar arquivos
git add .

# 2. Commit inicial
git commit -m "Initial commit: Project setup"

# 3. Renomear branch (se necessário)
git branch -M main

# 4. Push para GitHub
git push -u origin main
# -u flag: define 'main' como upstream (padrão)
```

---

## 📄 .gitignore por Projeto Type

### <projeto-api> / <projeto-sync> (Node.js + TypeScript)

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
*.swp

# OS
.DS_Store
Thumbs.db
```

### <projeto-docs> / Documentação (Markdown)

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

## ✅ Checklist Pós-Setup

- [ ] Git inicializado (`git status` retorna "On branch main")
- [ ] .gitignore criado e commitado
- [ ] Remote configurado (`git remote -v` mostra origin)
- [ ] Primeiro commit feito
- [ ] Push bem-sucedido (código visível no GitHub)
- [ ] Branch main criada no GitHub
- [ ] Repositório visível em github.com/<conta-github>

---

## 🐛 Troubleshooting

### "fatal: not a git repository"
→ Rode `git init` na pasta

### "Permission denied" ao fazer push
→ Verifique token GitHub ou SSH key
→ Configure credenciais: `git config credential.helper store`

### "The remote origin already exists"
→ `git remote remove origin` e refaça

### Pasta vazia não aparece no Git
→ Git só rastreia arquivos. Crie `.gitkeep` em pastas vazias

---

## 🚀 Próximo Passo

Após setup, use skill: `git-commit-push.md` para fazer commits diários

---

*Skill criada: 2026-07-04*  
*Agente responsável: Git/GitHub Specialist*
