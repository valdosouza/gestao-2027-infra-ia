**Escopo**: metodo

# Guia de Uso: Sistema de Testes Sincronizador

## Visão Geral

Sistema de testes incremental, controlado e orientado a endpoint para validar a sincronização
entre Delphi (Sincronizador) e Node.js (setes-sync/setes-api).

**Fluxo:**
1. Tabelas sem dependências (Level 0)
2. Tabelas que dependem de Level 0 (Level 1)
3. Tabelas que dependem de Level 1 ou 0 (Level 2)
4. ... e assim por diante

**Parada em erro**: Se alguma tabela falhar, o teste interrompe imediatamente,
sem executar dependentes. Você diagnostica, corrige, aprova e retoma.

---

## Setup Inicial (Uma vez)

### 1. Criar as tabelas de log (MySQL - setes_central)

```bash
cd D:\Gestao2027\setes-api
npm run db:migrate
# Executa a migration 1722441200000-CreateTestSyncTables.ts
```

As tabelas criadas:
- `tb_sync_test_session` — sessões de teste (UUID, usuário, status)
- `tb_sync_test_log` — logs de cada tabela testada (conta de registros, erros, timestamps)

### 2. Integrar o módulo de teste na setes-api

No arquivo `src/app.module.ts`, importar o TestModule:

```typescript
import { TestModule } from './modules/test/test.module';

@Module({
  imports: [
    // ... outros módulos
    TestModule, // ← adicionar aqui
  ],
})
export class AppModule {}
```

Registrar no Swagger (se houver):

```typescript
// em src/main.ts ou swagger config
// documentação dos endpoints fica em /api/test/... automaticamente
```

### 3. Compilar Delphi com a classe TTestSyncOrchestrator

No Delphi, adicionar à pasta apropriada:
- `D:\Gestao2027\sincronizador\source\TestSyncOrchestrator.pas`

Adaptar conforme necessário (a classe usa abstrações — você liga nos eventos reais).

### 4. Reiniciar os serviços

```bash
# Terminal 1: setes-api
cd D:\Gestao2027\setes-api
npm run start:dev

# Terminal 2: sincronizador (Delphi)
# Compilar e executar no IDE Delphi
```

---

## Workflow de Teste

### Fase 1: Iniciar Sessão

No Delphi (dentro de um botão de teste ou menu):

```pascal
procedure TMainForm.ButtonStartTests_Click(Sender: TObject);
var
  Orchestrator: TTestSyncOrchestrator;
begin
  Orchestrator := TTestSyncOrchestrator.Create('http://localhost:3001', FLogger);
  try
    { Criar sessão }
    Orchestrator.CreateTestSession(
      'valdo@setes.com.br',
      'Round 1 — Teste básico de cadastros'
    );

    { Executar testes }
    Orchestrator.RunTests;

    { Ver resultado }
    ShowMessage(Orchestrator.GetSessionStatus);
  finally
    Orchestrator.Free;
  end;
end;
```

**O que acontece:**

1. ✓ Cria sessão em `tb_sync_test_session` (UUID gerado)
2. ✓ Carrega mapa de dependências do endpoint `/api/test/dependency-map`
3. ✓ Inicia loop Level 0 → Level 1 → Level 2 → ...

### Fase 2: Execução Automática

Para cada tabela em ordem:

```
[Level 0]
  TB_USUARIO      (32 registros)
  → Executa POST /api/user/sincronize
  → Registra: sucesso, 32 enviados ✓

  TB_PORTADOR     (5 registros)
  → Executa POST /api/carrier/sincronize
  → Registra: sucesso, 5 enviados ✓

[Level 1]
  TB_EMPRESA      (12 registros)
  → Executa POST /api/entity/sincronize
  → Registra: sucesso, 12 enviados ✓

  TB_CLIENTE      (42 registros)
  → Executa POST /api/customer/sincronize
  → ERRO: "Duplicated CNPJ for client #15"
  → Registra: falha, erro_mensagem + stack
  → ⚠️ PARA AQUI
  → TB_NOTA_FISCAL e TB_PEDIDO ficam bloqueados
```

### Fase 3: Diagnóstico

Quando o teste parar, você:

1. **Obter logs de erro:**

```bash
curl http://localhost:3001/api/test/sessions/{sessionId}/errors | jq
```

Resposta:
```json
{
  "session_id": "uuid-123",
  "error_count": 1,
  "errors": [
    {
      "table": "TB_CLIENTE",
      "status": "failed",
      "erro_mensagem": "Duplicated CNPJ for client #15",
      "erro_detalhes": {
        "stack": "...",
        "request_body": {...},
        "response_code": 409
      },
      "timestamp": "2026-07-31T14:30:00Z"
    }
  ]
}
```

2. **Analisar em duas frentes:**

   **API (setes-sync/setes-api):**
   - Verificar logs em `npm run start:dev`
   - Verificar banco: `SELECT * FROM tb_customer WHERE id = ...`
   - Verificar validação: há CNPJ duplicado? Está fora de máscara?

   **Firebird (Sincronizador):**
   - Verificar dados: `SELECT * FROM TB_CLIENTE WHERE ...`
   - Verificar registro #15: CPF/CNPJ corretos?
   - Verificar DELETED flag: marca 'S' (soft delete)?

3. **Identificar a raiz:**
   - Dados ruim no Firebird? → limpar/corrigir na origem
   - Validação muito rigorosa na API? → relaxar ou documentar
   - Bug no endpoint? → corrigir no código

---

## Aprovação e Retry

Após corrigir a raiz do problema:

### 1. Corrigir no código (API ou Delphi)

Exemplo: código da API estava validando CNPJ mal formatado:

```typescript
// Antes (incorreto):
if (!isValidCNPJ(cnpj)) {
  throw new BadRequestException('Invalid CNPJ');
}

// Depois (correto):
const cleanCnpj = cnpj.replace(/[^\d]/g, '');
if (!isValidCNPJ(cleanCnpj)) {
  throw new BadRequestException('Invalid CNPJ');
}
```

Commit e push:
```bash
git add src/modules/customer/services/...
git commit -m "fix: CNPJ normalization in customer sync"
git push
```

### 2. Compilar (se foi Delphi) ou deploy (se foi API)

```bash
# API Node.js
npm run build
npm run start:dev

# Delphi
# Recompile no IDE
```

### 3. Aprovar reset

```bash
curl -X POST http://localhost:3001/api/test/sessions/{sessionId}/tables/TB_CLIENTE/reset \
  -H "Content-Type: application/json" \
  -d '{"approved_by": "valdo@setes.com.br"}'
```

**O que acontece:**
- ✓ Marca `TB_CLIENTE` como "reset"
- ✓ Limpa dados de teste na API (`DELETE FROM tb_customer WHERE test_session_id = ...`)
- ✓ Marca `pronto_retry = true`

### 4. Retomar testes

No Delphi:

```pascal
Orchestrator.ResetTable('TB_CLIENTE', 'valdo@setes.com.br');
Orchestrator.ResumeTests; // Volta para TB_CLIENTE, depois continua
```

**Resultado:**
```
[Level 1]
  TB_EMPRESA      (12 registros)
  ✓ Já passou — pula

  TB_CLIENTE      (42 registros)
  → Executa POST /api/customer/sincronize (novamente)
  → SUCESSO ✓
  → Continua para Level 2...

[Level 2]
  TB_NOTA_FISCAL  (15 registros)
  → Executa POST /api/invoice/sincronize
  → SUCESSO ✓
  ...
```

---

## Consultar Resultados

### Relatório final (quando tudo passar)

```bash
curl http://localhost:3001/api/test/sessions/{sessionId}/report | jq
```

Resposta:
```json
{
  "session_id": "uuid-123",
  "usuario": "valdo@setes.com.br",
  "status": "concluido",
  "iniciado_em": "2026-07-31T10:00:00Z",
  "finalizado_em": "2026-07-31T14:45:00Z",
  "duracao_minutos": 285,
  "resumo": {
    "total_tabelas": 9,
    "sucesso": 9,
    "falha": 0,
    "aguardando": 0
  },
  "detalhes": [
    { "table": "TB_USUARIO", "level": 0, "status": "success", "registros": {...}, "tempo_segundos": 2.34 },
    { "table": "TB_PORTADOR", "level": 0, "status": "success", "registros": {...}, "tempo_segundos": 1.12 },
    ...
  ]
}
```

### Exportar logs (para Excel/análise)

```bash
curl http://localhost:3001/api/test/sessions/{sessionId}/logs > test-logs.json

# Abrir em Excel:
# Dados → Novo Texto → JSON → Importar
```

---

## Troubleshooting

### Problema: "ERRO — Sessão não encontrada"

```
GET /api/test/sessions/{sessionId} → 404
```

**Solução:**
- Verificar se {sessionId} foi copiado corretamente
- Verificar se a API reiniciou (logs perdidos em memória)
- Recriar sessão: `Orchestrator.CreateTestSession(...)`

---

### Problema: "ERRO — Tabela não mapeada"

```
POST /api/test/sessions/{sessionId}/tables/TB_MINHA_TABELA/start → 404
```

**Solução:**
- A tabela não está em `getDependencyMap()`
- Verificar em `test-sync.service.ts` se `TB_MINHA_TABELA` está em `initializeDependencyMap()`
- Se não estiver, adicionar:

```typescript
{
  level: X,
  table_name: 'TB_MINHA_TABELA',
  send_class: 'TMeuClassSendWeb',
  endpoint: '/api/meu-endpoint/sincronize',
  dependencies: ['TB_DEPENDENCIA'],
}
```

---

### Problema: "Delphi perde conexão com API"

```
[TEST ERROR] Erro ao executar TClienteSendWeb: Connection timeout
```

**Solução:**
- Verificar se setes-api está rodando: `npm run start:dev`
- Verificar porta (padrão 3001): `netstat -ano | grep 3001`
- Aumentar timeout no TRESTClient:

```pascal
FApiClient.ConnectTimeout := 30000; // 30s
FApiClient.ReadTimeout := 60000;    // 60s
```

---

## Referência Rápida

| Componente | Localização | Função |
|------------|------------|--------|
| **Tabelas de log** | `setes_central.tb_sync_test_*` | Histórico de testes |
| **Endpoints** | `/api/test/*` | API de teste |
| **Mapa de dependências** | `GET /api/test/dependency-map` | Ordem de execução |
| **Classe Delphi** | `TestSyncOrchestrator.pas` | Orquestrador de testes |
| **Service** | `test-sync.service.ts` | Lógica de testes |
| **Controller** | `test-sync.controller.ts` | REST endpoints |

---

## Fluxo Completo em 1 Comando

Se você implementar um CLI ou script:

```bash
# Iniciar, executar, gerar relatório
node scripts/test-sync.js --session-id "round-1" --user "valdo@setes.com.br"

# Ou em Delphi:
TTestSyncOrchestrator.RunFullCycle(
  'valdo@setes.com.br',
  'Round 1 — Testes básicos',
  true  // pausar em erro
);
```

---

## Próximas Etapas

- [ ] Executar Round 1 (Level 0)
- [ ] Executar Round 2 (Level 0-1)
- [ ] Executar Round 3 (Level 0-2)
- [ ] Documentar gaps encontrados
- [ ] Integrar ao CI/CD (opcional)

