# Documentação — setes-api

## 📚 Índice de Documentação

### ⭐ **ARQUITETURA_MODULOS_API.md** (2026-07-11 — LER ANTES de criar/alterar módulo de cadastro)
Padrão vigente: 1 cadastro = 1 módulo SIMÉTRICO com o setes-app
- 6 arquivos por módulo: interface / dto / repository / service / controller / routes
- URL segue o módulo: /api/<modulo> espelha /home/<modulo> do app (ex.: /api/countries)
- "Super" NUNCA vira pasta nem URL — guard POR MÓDULO no gateway (super.guard.ts nos cadastros do catálogo central)
- Regras de consistência (envelope {ok,data}, camelCase, soft delete, códigos BACEN/IBGE vs MAX+1)
- Skill passo a passo: `skills/novo-modulo.md`

**Leia se:** Vai criar ou mexer em qualquer módulo de cadastro (countries, states, cities, interfaces, privileges...)

---

### 0. **AGENTE_ESPECIALIZADO.md** 🆕
Guia do agente Delphi → TypeScript
- O que é o agente
- Como usar
- Exemplos de conversão
- Troubleshooting

**Leia se:** Quer converter código Delphi para TypeScript

---

### 1. **01-DESACOPLAMENTO.md**
Status do desacoplamento de setes-sync
- O que mudou
- Código antes vs depois
- Estrutura após desacoplamento
- Limpeza necessária
- Próximos passos

**Leia se:** Quer entender o desacoplamento de sync

---

### 2. **02-VALIDACAO.md**
Validação de setes-api como API ERP pura
- Testes de validação executados
- Endpoints ativos documentados
- Como testar localmente
- Checklist de validação

**Leia se:** Quer validar que setes-api funciona sem sync

---

### ⭐ **05-ORDEM-SERVICO-SOFTWARE-HOUSE.md** (2026-07-18 — modelagem VALIDADA pelo Valdo)
Módulo Software House no backbone `tb_order` — Fases 2–7 do prompt FECHADO
`prompt_modulo_software_house.md` (nesta pasta; decisões DP1–DP12 todas validadas):
- ER conceitual, rotina mensal (vencimento decidido pelo usuário — DP1; pró-rata; estados na tb_order — DP7), parcerias (ordens PA próprias via tb_order_financial + estorno imutável; PA aberta compensa com PA+C — DP11)
- DDL físico validado (tb_contract, tb_order_service, tb_order_financial, tb_order_item_merchandise — DP6, realinhamento tb_financial*/tb_partnership*/tb_bank)
- Especificação de baixa/settled_code/estorno e matriz com 20 casos de teste
- NADA executado em banco/código ainda; migration 013 depende da revisão do sync

**Leia se:** vai implementar contratos, OS, faturamento mensal, financeiro ou parcerias

---

### 3. **03-SWAGGER.md**
Documentação Swagger/OpenAPI 3.0
- Como acessar interface Swagger UI
- 5 endpoints documentados
- Teste interativo de endpoints
- Exportar para Postman/Insomnia
- Exemplos de uso

**Leia se:** Quer testar endpoints via navegador

---

## 🎯 Quick Start

### Passo 1: Setup
```bash
cd D:\Gestao2027\setes-api
npm install
npm run dev
```

### Passo 2: Validar Health
```bash
curl http://localhost:3000/health
```

### Passo 3: Testar com JWT
```bash
# Gerar token (veja scripts/generate-token.ts)
curl -H "Authorization: Bearer <jwt>" \
  http://localhost:3000/api/core/info
```

---

## 📋 Módulos Ativos

### Core
- `GET /api/core/info` — Informações do tenant
- `POST /api/core/setup` — Setup do tenant

### ERP
- `GET /api/erp/status` — Status do módulo

### Admin
- `POST /api/admin/user` — Criar usuário
- `GET /api/admin/user/:id` — Obter usuário

---

## 🔐 Autenticação

Todos os endpoints `/api/*` requerem:
```
Authorization: Bearer <jwt>
```

Exemplo de token:
```typescript
// scripts/generate-token.ts
jwt.sign(
  { 
    tenantId: 'tenant-001', 
    userId: 'user-001', 
    role: 'client_user', 
    schemaName: 'schema_alpha' 
  },
  process.env.JWT_SECRET,
  { expiresIn: '24h' }
)
```

---

## ✨ Recursos

### Autenticação JWT
- Multi-tenant via tenantId em JWT
- Extração automática de schemaName do banco
- Validação em authMiddleware

### Feature Flags
- Por módulo (core, erp, admin)
- Por tenant
- Cache com TTL configurável

### Rate Limiting
- 300 req/min por tenant
- Keying inteligente: tenantId > IP
- Aplicado globalmente em /api/*

### Multi-tenancy
- Cada tenant tem schema MySQL próprio
- Schemas isolados (schema_tenant_001, schema_beta, etc)
- Dados não vazam entre tenants

---

## 📝 Notas Importantes

### Desacoplamento Completo

❌ **Removido**:
- `/sync/*` endpoints
- módulos/sync/
- sync.specific.routes.ts
- Middlewares condicionais

✅ **Mantido**:
- JWT auth
- Feature flags
- Rate limiting
- Multi-tenancy
- Core, ERP, Admin modules

### Mudança de Porta

- **setes-api**: `localhost:3000` (ERP + APIs cliente)
- **setes-sync**: `localhost:3001` (Sincronização com Delphi)

---

## 🔗 Relacionado

- **setes-sync** — Nova API de sincronização (porta 3001)
- **Sincronizador Delphi** — Envia dados para setes-sync
- **setes-app** — Cliente web (Flutter) consome setes-api

---

## 📁 Arquivos Principais

```
setes-api/
├── CLAUDE.md                (Guia técnico)
├── package.json             (Dependências)
├── tsconfig.json           (TypeScript config)
├── .env.example            (Variáveis de ambiente)
├── src/
│   ├── app.ts              (Express setup)
│   ├── server.ts           (Bootstrap)
│   ├── gateway/
│   │   ├── auth.middleware.ts
│   │   ├── feature-flag.middleware.ts
│   │   ├── rate-limit.middleware.ts
│   │   └── router.ts
│   ├── modules/
│   │   ├── core/
│   │   ├── erp/
│   │   ├── admin/
│   │   └── _template/      (Template para novos módulos)
│   ├── feature-flags/
│   │   ├── flag.service.ts
│   │   └── flag.repository.ts
│   ├── migrations/
│   ├── shared/
│   │   ├── db/connection.ts
│   │   ├── logger/logger.ts
│   │   ├── errors/http-error.ts
│   │   └── types/express.d.ts
│   └── __tests__/
└── CLAUDE.md               (Documentação técnica)
```

---

## ✅ Checklist de Validação

- [ ] `npm install` executado
- [ ] `.env` criado e configurado
- [ ] `npm run dev` rodando
- [ ] GET /health retorna 200
- [ ] GET /api/core/info retorna 200 (com JWT)
- [ ] Feature flags funcionando
- [ ] Testes passam em `npm test`
- [ ] Swagger rodando em http://localhost:3001/docs (setes-sync)

---

## 🚀 Próximas Etapas

1. ✅ Desacoplamento de sync
2. ⏳ Validar que setes-api funciona sem sync
3. ⏳ Documentar arquitetura final
4. ⏳ Setup do banco de dados para setes-sync

---

*Última atualização: 2026-07-01*
