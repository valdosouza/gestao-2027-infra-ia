# 🚀 Git/GitHub — Envio Seguro

**Objetivo**: Fazer push simples e seguro sem dados sensíveis

---

## 📋 Fluxo Básico (3 Linhas)

```bash
cd D:\Gestao2027\[PROJETO]
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
1. https://github.com/valdosouza/gestao-2027-infra-ia
2. https://github.com/valdosouza/gestao-2027-setes-api
3. https://github.com/valdosouza/gestao-2027-setes-sync
4. https://github.com/valdosouza/gestao-2027-sincronizador
5. https://github.com/valdosouza/gestao-2027-codigo-aprendizado
```

---

## 📚 Mensagens Padrão por Projeto

```bash
# Infra-IA
git commit -m "docs: atualização de documentação"

# Setes-API / Setes-Sync
git commit -m "feat: [breve descrição]"

# Sincronizador / Código-Aprendizado
git commit -m "chore: atualização de código legado"
```

---

**Simples, Seguro, Efetivo** 🔐
