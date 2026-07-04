# 🗺️ Mapa de Skills — Localização & Organização

**Objetivo**: Localizar rapidamente a skill que precisa  
**Versão**: 1.0

---

## 📍 Localização de Todas as Skills

### setes-sync Skills
**Pasta**: `D:\Gestao2027\Infra-IA\setes-sync\skills\`

```
setes-sync/skills/
├── setup-setes-sync.md           ← Start here
├── novo-endpoint-sync.md         ← Nova feature
├── testar-sincronizacao.md       ← QA
└── swagger-endpoint.md           ← Documentação (TBD)
```

**Quando usar**:
- 📦 Setup inicial da API de sync
- 🆕 Adicionar novo endpoint de sincronização
- 🧪 Testar multi-tenant
- 📚 Documentar novo endpoint no Swagger

---

### setes-api Skills
**Pasta**: `D:\Gestao2027\Infra-IA\setes-api\skills\`

```
setes-api/skills/
├── setup-setes-api.md              ← Start here
├── novo-endpoint-erp.md            ← Nova feature
├── delphi-to-typescript.md         ← 🆕 Converter Delphi
├── novo-modulo.md                  ← Novo módulo (TBD)
└── swagger-endpoint.md             ← Documentação (TBD)
```

**Quando usar**:
- 📦 Setup inicial da API de negócio
- 🆕 Adicionar novo endpoint ERP
- 🔄 **Converter código Delphi → TypeScript** (NEW)
- 🏗️ Criar novo módulo (auth, payments, etc)
- 📚 Documentar novo endpoint

---

### Database Skills
**Pasta**: `D:\Gestao2027\Infra-IA\database\skills\`

```
database/skills/
├── setup-mysql-multitenant.md    ← Start here
├── novo-tenant.md                ← Onboard cliente
├── backup-restore.md             ← Backup/Restore (TBD)
└── migracao-dados.md             ← Migração (TBD)
```

**Quando usar**:
- 🗄️ Setup inicial do MySQL
- 👥 Adicionar novo cliente
- 💾 Fazer backup de tenant
- 🔄 Migrar dados entre ambientes

---

### Integration Skills
**Pasta**: `D:\Gestao2027\Infra-IA\integration\skills\`

```
integration/skills/
├── teste-e2e.md                  ← Start here
├── deploy-producao.md            ← Deploy (TBD)
└── sincronizar-delphi.md         ← Delphi config (TBD)
```

**Quando usar**:
- 🧪 Testar fluxo completo
- 🚀 Deploy para produção
- 🔗 Configurar Sincronizador Delphi

---

## 🔍 Encontrar Skill por Necessidade

### "Quero fazer setup do projeto"

```
1. database/skills/setup-mysql-multitenant.md
2. setes-sync/skills/setup-setes-sync.md
3. setes-api/skills/setup-setes-api.md
4. integration/skills/teste-e2e.md ← validar tudo
```

**Tempo total**: ~1h30min

---

### "Quero converter código Delphi para TypeScript"

```
1. setes-api/skills/delphi-to-typescript.md ← Start here
2. (Agente especializado a81b1668737619946 faz o resto)
3. integration/skills/teste-e2e.md ← validar
```

**Tempo total**: ~30-45 min

---

### "Quero adicionar novo cliente"

```
database/skills/novo-tenant.md
```

**Tempo total**: ~5 min

---

### "Quero adicionar novo endpoint de sincronização"

```
1. Ler documentação: D:\Gestao2027\ARQUITETURA_FINAL.md
2. setes-sync/skills/novo-endpoint-sync.md
3. setes-sync/skills/testar-sincronizacao.md
4. integration/skills/teste-e2e.md ← validar
```

**Tempo total**: ~30 min

---

### "Quero adicionar novo endpoint ERP"

```
1. Ler documentação: D:\Gestao2027\ARQUITETURA_FINAL.md
2. setes-api/skills/novo-endpoint-erp.md
3. integration/skills/teste-e2e.md ← validar
```

**Tempo total**: ~25 min

---

### "Quero fazer testes"

```
setes-sync/skills/testar-sincronizacao.md
integration/skills/teste-e2e.md
```

**Tempo total**: ~15 min

---

## 🆕 Skills por Criar (Futuros)

Quando essas necessidades surgirem, criar:

### Pasta: `setes-sync/skills/`
- `swagger-endpoint.md` — Como documentar endpoint no Swagger

### Pasta: `setes-api/skills/`
- `novo-modulo.md` — Criar módulo novo (ex: Auth, Payments)
- `swagger-endpoint.md` — Documentar endpoint

### Pasta: `database/skills/`
- `backup-restore.md` — Backup/restore por tenant
- `migracao-dados.md` — Migração entre ambientes

### Pasta: `integration/skills/`
- `deploy-producao.md` — Deploy para AWS/Azure
- `sincronizar-delphi.md` — Configurar Sincronizador Delphi
- `monitoramento.md` — Setup de observabilidade
- `load-testing.md` — Teste de carga

---

## 📊 Resumo Executivo

| Categoria | Skills | Tempo Total | Status |
|-----------|--------|-------------|--------|
| **Setup** | 3 | ~1h30min | ✅ Criado |
| **Desenvolvimento** | 3 | Variável | ✅ Criado |
| **Migração Delphi** | 1 | ~30-45min | ✅ Criado |
| **Testes** | 2 | ~15min | ✅ Criado |
| **Banco de Dados** | 2 | ~15min | ✅ Criado |
| **Avançado** | 5 | Variável | ⏳ Futuro |
| **TOTAL** | **16** | **~2h30min** | **10 pronto** |

---

## 🎯 Próximas Ações

### Semana 1
- [ ] Usar skills de setup
- [ ] Adicionar primeiros clientes com `novo-tenant.md`
- [ ] Rodar testes com `teste-e2e.md`

### Semana 2+
- [ ] Adicionar novos endpoints conforme necessário
- [ ] Criar skills restantes conforme surgem novas necessidades
- [ ] Otimizar skills baseado em feedback da equipe

---

## 💾 Como Salvar Skill Localmente

```bash
# Clonar skill para seu projeto
cp D:\Gestao2027\Infra-IA\<modulo>\skills\<skill>.md ~/meu-projeto/docs/
```

---

## 🔄 Atualizar Skills

Quando processo muda:

1. Abra arquivo `.md` da skill
2. Atualize conteúdo
3. Atualize timestamp no final
4. Teste o novo processo
5. Confirme que funciona

---

**Gestao 2027 — Skills Mapeadas e Organizadas! 📍**

*Última atualização: 2026-07-01*

