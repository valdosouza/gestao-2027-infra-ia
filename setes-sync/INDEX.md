# Documentação — setes-sync

## 📚 Índice de Documentação

### 1. **01-SWAGGER.md**
Documentação interativa com Swagger/OpenAPI 3.0
- Como acessar interface Swagger UI
- 23 endpoints documentados
- Teste interativo de endpoints
- Exportar para Postman/Insomnia

**Leia se:** Quer testar endpoints via navegador ou entender a API

---

### 2. **02-SETUP.md**
Guia completo de instalação e configuração
- Pré-requisitos
- Instalação de dependências
- Configuração de .env
- Health check
- Teste manual com curl
- Troubleshooting

**Leia se:** Está iniciando setes-sync pela primeira vez

---

### 3. **03-INSTRUCOES_TESTE.md**
Instruções passo a passo para testar
- Fase 1: Preparação
- Fase 2: Iniciar setes-sync
- Fase 3: Testes básicos
- Fase 4: Testes automatizados
- Fase 5: Integração com Sincronizador Delphi
- Checklist de sucesso
- Troubleshooting

**Leia se:** Quer validar que setes-sync está funcionando

---

## 🎯 Quick Start

### Passo 1: Setup
```bash
cd D:\Gestao2027\setes-sync
npm install
npm run dev
```

### Passo 2: Acessar Documentação
```
http://localhost:3001/docs
```

### Passo 3: Testar no Swagger UI
1. Clique "Authorize"
2. Digite X-Api-Key
3. Expanda endpoint
4. Clique "Try it out"
5. Execute

---

## 📋 23 Endpoints

**Masteres (6)**
- brand, customer, category, merchandise, provider, salesman

**Financeiro (3)**
- financial, financial-plans, financial-statement

**Estoque (4)**
- stock-balance, stock-list, stock-statement, order-stock-adjust

**Vendas & Compras (2)**
- order-sale, order-purchase

**Preços (3)**
- price, price-list, promotion

**Operações (5)**
- cashier, bank-account, payment-type, package, file-xml

---

## 🔐 Autenticação

Todos os endpoints requerem:
```
X-Api-Key: sua_chave_compartilhada_do_sincronizador
```

---

## 📁 Arquivos no Projeto

```
setes-sync/
├── SETUP.md                       (Setup original)
├── SWAGGER.md                     (Swagger original)
├── package.json                   (com swagger-jsdoc + swagger-ui-express)
├── src/shared/swagger/
│   ├── swagger-config.ts          (Definição OpenAPI 3.0)
│   └── swagger-endpoints.ts       (Docs dos 23 endpoints)
└── ...
```

---

## 🚀 Fluxo Recomendado

1. **Primeira vez?** → Leia **02-SETUP.md**
2. **Quer testar?** → Leia **03-INSTRUCOES_TESTE.md**
3. **Precisa de docs?** → Leia **01-SWAGGER.md**

---

## 🔗 Links Importantes

- **API Live**: `http://localhost:3001` (quando rodando)
- **Swagger UI**: `http://localhost:3001/docs`
- **OpenAPI JSON**: `http://localhost:3001/docs.json`
- **Projeto**: `D:\Gestao2027\setes-sync`

---

## 📝 Notas

- Porta padrão: `3001`
- Banco de dados: MySQL (setes_central)
- Autenticação: X-Api-Key (compartilhada com Sincronizador Delphi)
- 23 endpoints de sincronização ativos
- 7 endpoints de restaurante removidos

---

## ✅ Checklist de Configuração

- [ ] Node.js 18+ instalado
- [ ] npm install executado
- [ ] .env criado e configurado
- [ ] npm run dev rodando
- [ ] GET /health retorna 200
- [ ] Swagger acessível em /docs
- [ ] X-Api-Key configurada
- [ ] Testes passam em npm test

---

*Última atualização: 2026-07-01*
