# 🚀 Git/GitHub — Envio Seguro

**Objetivo**: Fazer push simples e seguro sem dados sensíveis
**Escopo**: metodo

---

## 📋 Fluxo Básico (3 Linhas)

```bash
cd <raiz-do-workspace>\[PROJETO]
git add . && git commit -m "[Mensagem]" && git push
```

---

## 🛡️ Segurança

✅ `.gitignore` bloqueia:
- `.env` (credenciais)
- `node_modules/` (dependências)
- `dist/`, `build/` (compilado)
- Credenciais, secrets, tokens

✅ Antes de push, verificar:
```bash
git status  # Ver o que será enviado
```

---

## 🔗 URLs dos Repositórios

```
1. https://github.com/<conta-github>/<repo-docs>
2. https://github.com/<conta-github>/<repo-api>
3. https://github.com/<conta-github>/<repo-sync>
4. https://github.com/<conta-github>/<repo-legado>
5. https://github.com/<conta-github>/<repo-aprendizado>
```

---

## 📚 Mensagens Padrão por Projeto

```bash
# <projeto-docs> (documentação)
git commit -m "docs: atualização de documentação"

# <projeto-api> / <projeto-sync>
git commit -m "feat: [breve descrição]"

# <projeto-legado> / <projeto-aprendizado>
git commit -m "chore: atualização de código legado"
```

---

**Simples, Seguro, Efetivo** 🔐
