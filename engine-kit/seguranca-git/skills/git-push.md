# Skill: Git Push — Envio Seguro e Simples

**Objetivo**: Fazer commit e push com segurança  
**Tempo**: 2 minutos  
**Frequência**: Sempre que terminar trabalho
**Escopo**: metodo

---

## 🎯 Fluxo

### 1. Verificar o que será enviado
```bash
cd <raiz-do-workspace>\[PROJETO]
git status
```

### 2. Adicionar e Commitar
```bash
git add .
git commit -m "[Sua mensagem aqui]"
```

**Mensagens padrão**:
- `docs: [descrição]` — Documentação
- `feat: [descrição]` — Nova feature
- `fix: [descrição]` — Bug fix
- `chore: [descrição]` — Manutenção

### 3. Push para GitHub
```bash
git push
```

---

## ✅ Segurança Automática

`.gitignore` bloqueia automaticamente:
- ✅ `.env` — NÃO será enviado
- ✅ `node_modules/` — NÃO será enviado
- ✅ `dist/`, `build/` — NÃO será enviado
- ✅ Credenciais — NÃO serão enviadas

---

## 🔍 Se Algo Estranho Aparecer

```bash
# Ver o que será enviado
git diff --cached --name-only

# Se .env aparecer:
git reset HEAD .env
# ❌ PARAR e investigar
```

---

## 📝 Exemplo Completo

```bash
cd <raiz-do-workspace>\<projeto-api>

# Ver status
git status

# Adicionar e commitar
git add .
git commit -m "feat: add JWT authentication middleware"

# Push
git push

# ✅ Pronto! Código está no GitHub
```

---

**Simples, Rápido, Seguro** 🚀
