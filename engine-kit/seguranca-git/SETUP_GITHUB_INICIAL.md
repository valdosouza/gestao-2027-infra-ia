# 🚀 Setup GitHub Inicial — Criar Repositórios + Autenticação

**Objetivo**: Preparar GitHub para receber código via agente  
**Tempo**: ~15 minutos  
**Crítico**: Fazer ANTES que agente faça push
**Escopo**: metodo

---

## ✅ Passo 1: Criar 5 Repositórios no GitHub

### Acessar GitHub

1. Abra: https://github.com/new
2. Você está logado em `<conta-github>`? 
   - Se NÃO: https://github.com/login primeiro

---

### Criar Repositório 1: <repo-docs>

```
Repository name: <repo-docs>
Description: Documentação, agentes e skills do projeto
Visibility: ☐ Public  ☑ Private
Initialize repository: ☐ Add a README file
                       ☐ Add .gitignore
                       ☐ Choose a license

→ Clicar: "Create repository"
```

**Resultado**: https://github.com/<conta-github>/<repo-docs> (vazio ✅)

---

### Criar Repositório 2: <repo-api>

```
Repository name: <repo-api>
Description: Node.js + TypeScript API para ERP multi-tenant
Visibility: ☐ Public  ☑ Private
Initialize repository: ☐ Tudo em branco

→ Clicar: "Create repository"
```

**Resultado**: https://github.com/<conta-github>/<repo-api> (vazio ✅)

---

### Criar Repositório 3: <repo-sync>

```
Repository name: <repo-sync>
Description: Node.js + TypeScript API para sincronização de dados
Visibility: ☐ Public  ☑ Private
Initialize repository: ☐ Tudo em branco

→ Clicar: "Create repository"
```

**Resultado**: https://github.com/<conta-github>/<repo-sync> (vazio ✅)

---

### Criar Repositório 4: <repo-legado>

```
Repository name: <repo-legado>
Description: Sincronizador de dados (Legado em produção)
Visibility: ☑ Private
Initialize repository: ☐ Tudo em branco

→ Clicar: "Create repository"
```

**Resultado**: https://github.com/<conta-github>/<repo-legado> (vazio ✅)

---

### Criar Repositório 5: <repo-aprendizado>

```
Repository name: <repo-aprendizado>
Description: Modelos legados para referência e conversão
Visibility: ☑ Private
Initialize repository: ☐ Tudo em branco

→ Clicar: "Create repository"
```

**Resultado**: https://github.com/<conta-github>/<repo-aprendizado> (vazio ✅)

---

## ✅ Resultado: 5 Repositórios Criados

```
✅ https://github.com/<conta-github>/<repo-docs>
✅ https://github.com/<conta-github>/<repo-api>
✅ https://github.com/<conta-github>/<repo-sync>
✅ https://github.com/<conta-github>/<repo-legado>
✅ https://github.com/<conta-github>/<repo-aprendizado>
```

---

## 🔐 Passo 2: Criar Personal Access Token (Autenticação)

**Por que token?** Melhor para:
- Agente gerenciar múltiplos repos
- Não expor senha do GitHub
- Revogar sem mudar senha

### Gerar Token

1. Abra: https://github.com/settings/tokens
2. Clicar: **"Generate new token"** → **"Generate new token (classic)"**

### Configurar Token

```
Token name: <empresa>-Agent
Expiration: 90 days (ou mais, sua escolha)

Scopes (Marcar):
☑ repo              (Acesso completo a repositórios)
☑ read:user
☑ user:email
☑ admin:public_key
☑ admin:repo_hook

→ Clicar: "Generate token"
```

### Copiar Token

```
⚠️ IMPORTANTE:
- Copiar o token gerado (será exibido apenas uma vez)
- GUARDAR EM LOCAL SEGURO (não commit, não compartilhar)
- Exemplos de onde guardar:
  ✅ Password manager (Bitwarden, 1Password)
  ✅ Arquivo .env pessoal (NÃO no projeto)
  ✅ Anotação segura (Notion, OneNote pessoal)
  ❌ Commit em Git
  ❌ Compartilhar

Formato do token:
ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## 🔐 Passo 3: Configurar Git para Usar Token

### No Windows (Recomendado: Git Credential Manager)

**Opção A: Usar Git Credential Manager (Automático)**

Git já vem com credential manager. Quando tentar fazer push:

```bash
git push origin main
# Vai pedir:
# Username: <conta-github>
# Password: [Cole o token aqui]
# 
# Git salva automaticamente
```

**Opção B: Armazenar Token Manualmente**

```bash
# Armazenar credenciais no Windows Credential Manager
git config --global credential.helper manager-core

# Próximo push vai pedir token uma vez e guardar
git push origin main
```

**Opção C: Via .git/config (Não recomendado)**

```bash
# NÃO recomendado, mas funciona:
git config --global user.name "<conta-github>"
git config --global user.password "ghp_xxxx...xxxx"
```

---

## ✅ Testar Autenticação

```bash
# 1. Ir para qualquer pasta do projeto
cd <raiz-do-workspace>\<projeto-api>

# 2. Tentar clonar um repo vazio
git clone https://github.com/<conta-github>/<repo-api> test-clone

# 3. Se pedir username/password:
#    Username: <conta-github>
#    Password: [Cole o token]

# 4. Se clonar sem erro: ✅ Autenticação OK
```

---

## 📋 Checklist Pré-Agente

```
Antes de agente começar:

GitHub:
☑ 5 repositórios criados (vazios)
☑ Personal Access Token gerado
☑ Token guardado em local seguro
☑ Token testado com git clone

Configuração Local:
☑ Git instalado
☑ Git configurado (user.name, user.email)
☑ Credential manager funcionando

Pastas:
☑ <raiz-do-workspace>\<projeto-api> existe
☑ <raiz-do-workspace>\<projeto-sync> existe
☑ <raiz-do-workspace>\<projeto-legado> existe
☑ <raiz-do-workspace>\<projeto-docs> existe
☑ <raiz-do-workspace>\<projeto-aprendizado> existe

✅ Tudo OK → Agente pode proceder
```

---

## 🎯 URLs dos Repositórios (Copie)

Depois que criar, você terá:

```
1. https://github.com/<conta-github>/<repo-docs>
2. https://github.com/<conta-github>/<repo-api>
3. https://github.com/<conta-github>/<repo-sync>
4. https://github.com/<conta-github>/<repo-legado>
5. https://github.com/<conta-github>/<repo-aprendizado>
```

---

## 🚀 Próximo Passo

Depois de:
1. ✅ Criar 5 repositórios
2. ✅ Gerar e testar token

Volte aqui e diga:

```
✅ REPOSITÓRIOS CRIADOS
✅ TOKEN GERADO E TESTADO

AGENTE PODE COMEÇAR O PUSH
```

---

## ⚠️ Se Tiver Dúvidas

### "Qual é melhor: SSH ou Token?"

**SSH** (mais seguro, mas complexo):
- Gerar chave RSA
- Adicionar a GitHub
- Usar em cada push

**Token (recomendado para agente)**:
- Gerar uma vez
- Guardar seguro
- Agente usa automaticamente
- Fácil revogar se necessário

→ **Para o agente gerenciar: USE TOKEN** ✅

---

### "Onde guardar o token?"

```
❌ NÃO em:
  - Commit em Git
  - Email
  - Mensagem de texto

✅ SIM em:
  - Password manager (Bitwarden, 1Password)
  - Arquivo local .env pessoal
  - Anotação segura (Notion pessoal)
```

---

### "Token expirou?"

Se token expirou (90 dias):

1. Gerar novo: https://github.com/settings/tokens
2. Atualizar em password manager
3. Git pedirá novo token no próximo push

---

## 📞 Resumo Rápido

```
1. Criar 5 repos vazios no GitHub
   → https://github.com/new (5x)

2. Gerar token
   → https://github.com/settings/tokens
   → "Generate new token (classic)"
   → Copiar token (uma única oportunidade!)

3. Testar autenticação
   → git clone https://github.com/<conta-github>/<repo-api>
   → Username: <conta-github>
   → Password: [token]
   → ✅ Se funciona, tudo OK

4. Volta aqui e avisa
   → "REPOSITÓRIOS CRIADOS E TESTADO"
   → Agente começa o push
```

**Tempo**: ~15 minutos

---

*Guia criado: 2026-07-04*  
*Para: Primeiro setup antes do agente*  
*Status: Siga e volte aqui quando terminar ✅*
