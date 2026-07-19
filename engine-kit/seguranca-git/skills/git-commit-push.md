# Skill: Git Commit & Push — Versionamento Diário

**Objetivo**: Fazer commits profissionais e publicar no GitHub  
**Tempo**: ~5-10 minutos  
**Frequência**: Diária (ou a cada feature)
**Escopo**: metodo

---

## 🎯 Quando Usar

- ✅ Terminou uma feature
- ✅ Corrigiu um bug
- ✅ Atualizou documentação
- ✅ Fez refatoração
- ✅ Fim do dia (commit tudo)

---

## 📋 Fluxo Padrão (5 Passos)

### Passo 1: Verificar Status

```bash
cd <raiz-do-workspace>\<projeto-api>
git status
```

**Output esperado:**
```
On branch main
Changes not staged for commit:
  modified:   src/app.ts
  modified:   package.json

Untracked files:
  new-file.ts
```

### Passo 2: Staging (Escolher Arquivos)

```bash
# Opção A: Todos os arquivos
git add .

# Opção B: Arquivo específico
git add src/app.ts

# Opção C: Pasta específica
git add src/

# Opção D: Interativo (escolher)
git add -p
# Pressione 'y' para incluir, 'n' para pular
```

### Passo 3: Verificar o que será commitado

```bash
git status
# Deve mostrar "Changes to be committed"

# Ou ver diferenças
git diff --cached
```

### Passo 4: Commit com Mensagem Profissional

**Padrão Conventional Commits**:
```
<type>(<scope>): <subject>

<description> (opcional)

<footer> (opcional)
```

**Tipos**:
- `feat` — Nova feature
- `fix` — Bug fix
- `docs` — Documentação
- `refactor` — Refatoração (sem nova feature)
- `test` — Testes
- `style` — Formatação
- `chore` — Manutenção (deps, etc)

**Exemplos**:

```bash
# Feature simples
git commit -m "feat(auth): add JWT token validation"

# Com descrição
git commit -m "feat(api): implement multi-tenant support

- Add tenantId extraction from JWT
- Create tenant context middleware
- Update database connection logic

Closes #42"

# Bug fix
git commit -m "fix(db): resolve connection timeout on startup"

# Documentação
git commit -m "docs: update API endpoints README"

# Refatoração
git commit -m "refactor(service): simplify user service logic"
```

### Passo 5: Push para GitHub

```bash
# Primeira vez em uma branch
git push -u origin main

# Próximas vezes
git push
```

---

## 🔄 Fluxo Completo em Uma Linha

```bash
# Para fazer tudo de uma vez
cd <raiz-do-workspace>\<projeto-api> && \
git add . && \
git commit -m "feat(core): implement authentication" && \
git push
```

---

## 📊 Padrões por Contexto

### Depois de Codificar (Feature)
```bash
git add src/
git commit -m "feat(payments): add Stripe integration

- Add Stripe client initialization
- Implement payment processing endpoint
- Add webhook handlers"
git push
```

### Depois de Corrigir Bug
```bash
git add src/
git commit -m "fix(api): handle null request body

Previously: Application crashed on empty POST
Now: Returns validation error message"
git push
```

### Depois de Atualizar Docs
```bash
git add README.md
git add docs/
git commit -m "docs: add API endpoint documentation"
git push
```

### Fim do Dia (Múltiplas Mudanças)
```bash
git add .
git commit -m "chore: daily updates

- Updated dependencies
- Refactored user service
- Fixed linting errors"
git push
```

---

## ⚠️ Boas Práticas

### ✅ Faça

- ✅ Commit frequente (pelo menos 1x/dia)
- ✅ Mensagens descritivas
- ✅ Agrupe mudanças relacionadas
- ✅ Inclua contexto (por quê, não só o quê)
- ✅ Referencie issues: "Closes #123"

### ❌ NÃO Faça

- ❌ Commit sem mensagem (`git commit -m "fix"`)
- ❌ Commit gigante (1000+ linhas)
- ❌ Misturar assuntos (refactor + feature)
- ❌ Commit de .env ou dados sensíveis
- ❌ Force push sem motivo

---

## 🔍 Ver Histórico

```bash
# Últimos 10 commits
git log --oneline -10

# Com mais detalhes
git log --oneline --graph --all

# De um arquivo específico
git log --oneline src/app.ts

# Buscar por mensagem
git log --oneline --grep="auth"
```

---

## 🚨 Se Cometeu Erro

### Desfazer último commit (arquivo ainda existe)
```bash
git reset --soft HEAD~1
git add .
git commit -m "feat: correct message"
git push -f origin main
# ⚠️ Force push (perigoso se colab)
```

### Desfazer commits
```bash
# Ver histórico
git log --oneline

# Volta 2 commits (mantém mudanças)
git reset --soft HEAD~2

# Volta 2 commits (apaga mudanças)
git reset --hard HEAD~2
```

---

## ✅ Checklist Diário

- [ ] Rodou testes antes de commit
- [ ] Código formatado/lint
- [ ] Mensagem commit clara
- [ ] .env não foi commitado
- [ ] Push foi bem-sucedido

---

## 🎓 Exemplo Real

```bash
# 1. Terminei feature de autenticação
cd <raiz-do-workspace>\<projeto-api>

# 2. Ver mudanças
git status
# src/auth/auth.middleware.ts
# src/auth/auth.service.ts
# src/types/express.d.ts

# 3. Adicionar arquivos
git add src/auth/
git add src/types/

# 4. Verificar
git diff --cached

# 5. Commit
git commit -m "feat(auth): implement JWT validation middleware

- Extract tenantId from JWT token
- Add tenant context to Express request
- Create TenantPayload interface
- Add error handling for invalid tokens

Closes #15"

# 6. Push
git push

# 7. Verificar no GitHub
# → github.com/<conta-github>/<repo-api>/commits/main
```

---

## 🚀 Próxima Etapa

Para releases: use skill `git-release.md`

---

*Skill criada: 2026-07-04*  
*Agente: Git/GitHub Specialist*
