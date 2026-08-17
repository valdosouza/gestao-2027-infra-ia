**Escopo**: metodo

# Checklist de Implementação — Sistema de Testes Sincronizador

## ✅ Entregáveis Criados

### Documentação
- [x] Plano arquitetural (`plano-testes-sincronizador.md`)
- [x] Guia de uso (`GUIA-USO-TESTES.md`)
- [x] Este checklist

### API (Node.js - setes-sync)

#### Controllers & Services
- [x] `src/modules/test/test-sync.controller.ts` — 8 endpoints
- [x] `src/modules/test/test-sync.service.ts` — lógica de testes
- [x] `src/modules/test/test.module.ts` — integração NestJS

#### Entities (Banco de dados)
- [x] `src/modules/test/entities/test-sync-log.entity.ts` — logs de teste
- [x] `src/modules/test/entities/test-sync-session.entity.ts` — sessões de teste

#### Database
- [x] `src/database/migrations/1722441200000-CreateTestSyncTables.ts` — DDL

### Sincronizador (Delphi)
- [x] `Infra-IA/Sincronizador/test-sync-orchestrator.pas` — template da classe

---

## ⏳ Próximas Etapas

### 1. Mapa de Dependências (Aguardando Agente)

**Status:** Agente está explorando as tabelas...

**Objetivo:** Descobrir:
- Todas as tabelas sincronizadas
- Suas FKs
- Ordenação correta (Level 0 → 1 → 2 → ...)

**Saída esperada:**
```typescript
// Em test-sync.service.ts, método initializeDependencyMap()
// Atualizar com o mapa real do Firebird + Delphi
```

**Ação após resultado do agente:**
1. Ler resultado do agente
2. Atualizar `DependencyMap` em `test-sync.service.ts`
3. Verificar se os `endpoints` estão corretos (comparar com `setes-api/src/main.ts` ou swagger)

---

### 2. Integração na setes-api

**Arquivo:** `src/app.module.ts`

**Mudança:**
```typescript
// Antes
@Module({
  imports: [
    // ... outros módulos
  ],
})

// Depois
import { TestModule } from './modules/test/test.module';

@Module({
  imports: [
    // ... outros módulos
    TestModule, // ← adicionar esta linha
  ],
})
```

**Teste:**
```bash
curl http://localhost:3001/api/test/dependency-map
# Deve retornar array de tabelas em JSON
```

---

### 3. Criar Migration e Executar

**Arquivo:** `src/database/migrations/1722441200000-CreateTestSyncTables.ts`

**Executar:**
```bash
cd D:\Gestao2027\setes-api
npm run db:migrate
# ou
npm run typeorm migration:run -- -d src/database/datasource.ts
```

**Verificar:**
```sql
USE setes_central;
SHOW TABLES LIKE 'tb_sync_test%';
-- Deve aparecer:
-- tb_sync_test_session
-- tb_sync_test_log
```

---

### 4. Implementar TTestSyncOrchestrator no Delphi

**Arquivo:** `D:\Gestao2027\sincronizador\source\TestSyncOrchestrator.pas`

**Dependências esperadas:**
```pascal
// Já existentes no projeto Delphi:
- HTTPClient / REST client
- JSON handling
- Logger (sua classe)
- TFDQuery para contar registros (em CountRecords)
```

**Implementar método concreto:**
```pascal
function TTestSyncOrchestrator.CountRecords(const ATableName: string): Integer;
begin
  { TODO: Implementar }
  { Usar TFDQuery para SELECT COUNT(*) FROM [ATableName] WHERE DELETED = 'N' }
end;
```

**Integrar no menu ou botão:**
```pascal
procedure TMyForm.ButtonStartTests_Click(Sender: TObject);
var
  Orchestrator: TTestSyncOrchestrator;
begin
  Orchestrator := TTestSyncOrchestrator.Create('http://localhost:3001', FLogger);
  try
    Orchestrator.CreateTestSession('valdo@setes.com.br', 'Round 1');
    Orchestrator.RunTests;
    ShowMessage(Orchestrator.GetSessionStatus);
  finally
    Orchestrator.Free;
  end;
end;
```

---

### 5. Testes de Fumaça (Smoke Tests)

**Executar manualmente:**

#### 5a. Criar sessão
```bash
curl -X POST http://localhost:3001/api/test/sessions \
  -H "Content-Type: application/json" \
  -d '{
    "usuario": "valdo@setes.com.br",
    "observacoes": "Teste manual"
  }'

# Resposta esperada:
# { "session_id": "uuid-123", "created_at": "..." }
```

#### 5b. Carregar mapa
```bash
curl http://localhost:3001/api/test/dependency-map

# Resposta esperada:
# [
#   { "level": 0, "table_name": "TB_USUARIO", "endpoint": "/api/user/sincronize", ... },
#   { "level": 0, "table_name": "TB_PORTADOR", "endpoint": "/api/carrier/sincronize", ... },
#   ...
# ]
```

#### 5c. Registrar início de teste
```bash
curl -X POST http://localhost:3001/api/test/sessions/uuid-123/tables/TB_USUARIO/start \
  -H "Content-Type: application/json" \
  -d '{"registros_esperados": 42}'

# Resposta esperada:
# { "log_id": 1, "started_at": "...", "status": "running" }
```

#### 5d. Registrar fim (sucesso)
```bash
curl -X POST http://localhost:3001/api/test/sessions/uuid-123/tables/TB_USUARIO/finish \
  -H "Content-Type: application/json" \
  -d '{
    "status": "success",
    "registros_enviados": 42
  }'

# Resposta esperada:
# { "log_id": 1, "status": "success", "finished_at": "..." }
```

#### 5e. Obter erros
```bash
curl http://localhost:3001/api/test/sessions/uuid-123/errors

# Se houver erro:
# {
#   "error_count": 1,
#   "errors": [
#     { "table": "TB_CLIENTE", "erro_mensagem": "...", ... }
#   ]
# }
```

#### 5f. Obter relatório
```bash
curl http://localhost:3001/api/test/sessions/uuid-123/report

# Resposta esperada:
# {
#   "session_id": "uuid-123",
#   "resumo": { "total_tabelas": 9, "sucesso": 8, "falha": 1, ... },
#   "detalhes": [...]
# }
```

---

## 📋 Matriz de Testes (Após Implementação)

### Smoke (Básico)
- [ ] POST `/api/test/sessions` — cria sessão
- [ ] GET `/api/test/dependency-map` — carrega mapa
- [ ] POST `.../tables/TB_XXX/start` — inicia log
- [ ] POST `.../tables/TB_XXX/finish` — finaliza com sucesso
- [ ] GET `/api/test/sessions/{id}` — vê status

### Cenários
- [ ] **Round 1 (Level 0):** TB_USUARIO, TB_PORTADOR, TB_UNIDADE
  - Esperado: 3 sucessos
  - Bloqueador: nenhum

- [ ] **Round 2 (Level 0-1):** + TB_EMPRESA, TB_CATEGORIA, TB_CLIENTE
  - Esperado: 6 sucessos (depende de Level 0)
  - Bloqueador: FK inválida, CNPJ duplicado?

- [ ] **Round 3 (Level 0-2):** + TB_NOTA_FISCAL, TB_PEDIDO
  - Esperado: 8 sucessos
  - Bloqueador: dependências de cliente falham?

### Error Handling
- [ ] Erro em Level 1 bloqueia Level 2+
- [ ] Reset e retry funcionam corretamente
- [ ] Logs de erro salvos em `tb_sync_test_log`

---

## 🔧 Ajustes Finais

### Após mapa de dependências (agente)

1. **Atualizar `initializeDependencyMap()` em test-sync.service.ts**
   - Remover placeholder
   - Inserir tabelas REAIS do agente
   - Verificar `endpoints` contra Swagger da setes-api

2. **Verificar `cleanTableDestination()`**
   - Implementar DELETE específico para cada tabela
   - Considerar soft delete vs hard delete
   - Considerar cascade e integridade referencial

3. **Documentar dependências no MAPA_INDEXACAO.md**
   - Adicionar seção "Grafo de Sincronização"
   - Listar todas as tabelas com Level
   - Motivo de cada FK (negócio)

---

## 📊 Resumo de Arquivos

| Arquivo | Linguagem | Linhas | Descrição |
|---------|-----------|--------|-----------|
| `plano-testes-sincronizador.md` | Markdown | ~250 | Arquitetura completa |
| `test-sync.controller.ts` | TypeScript | ~200 | 8 endpoints REST |
| `test-sync.service.ts` | TypeScript | ~350 | Lógica de testes |
| `test-sync-log.entity.ts` | TypeScript | ~60 | Entity ORM |
| `test-sync-session.entity.ts` | TypeScript | ~40 | Entity ORM |
| `test.module.ts` | TypeScript | ~15 | Módulo NestJS |
| `1722441200000-CreateTestSyncTables.ts` | TypeScript | ~150 | Migration DDL |
| `test-sync-orchestrator.pas` | Pascal/Delphi | ~400 | Template Delphi |
| `GUIA-USO-TESTES.md` | Markdown | ~400 | Manual de uso |
| **Total** | — | **~1800** | — |

---

## ✨ Benefícios Obtidos

1. **Controle granular** — teste tabela por tabela
2. **Rastreabilidade** — logs de cada envio
3. **Parada segura** — não continua em cascata de erros
4. **Aprovação manual** — você valida antes de retry
5. **Escalabilidade** — cria Round 2, 3, ... conforme volume cresce
6. **Documentação automática** — endpoints em Swagger

---

## Status Atual

| Item | Status | Responsável |
|------|--------|-------------|
| Mapa de dependências | ⏳ Em descoberta | Agente Explore |
| Implementação API | ✅ Pronta | Claude |
| Integração NestJS | ⏳ Aguarda mapa | Você |
| Script Delphi | ✅ Template | Você (adaptar) |
| Testes manuais | ⏳ Pós-integração | Você |
| Documentação | ✅ Completa | Claude |

