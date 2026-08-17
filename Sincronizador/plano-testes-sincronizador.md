**Escopo**: metodo

# Plano: Sistema de Testes Incremental para Sincronizador

## Objetivo
Testar envio de tabelas de forma **controlada e ordenada**, começando por cadastros simples,
evitando cascata de erros e permitindo aprovação manual entre etapas.

## Princípios

1. **Sem reenvio completo**: logs controlam quantos registros foram enviados de cada tabela
2. **Dependência respeita FK**: tabelas com FK só enviadas DEPOIS que suas dependências passam
3. **Parada em erro**: interrompe, limpa destino, aguarda correção + aprovação
4. **Orquestração conjunta**: API fornece endpoints, Delphi coordena com feedback

---

## Arquitetura

### 1. Tabela de Controle (setes_central)

```sql
CREATE TABLE tb_sync_test_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  test_session_id UUID NOT NULL,           -- agrupa um round de testes
  table_name VARCHAR(100) NOT NULL,         -- TB_CLIENTE, TB_PEDIDO, etc
  send_class VARCHAR(100),                  -- TClienteSendWeb (Delphi)
  endpoint VARCHAR(100),                    -- /api/customer/sincronize
  status ENUM('pending','running','success','failed','reset'),
  registros_esperados INT,                  -- COUNT(*) no Firebird
  registros_enviados INT,                   -- quantos chegaram
  registros_falhados INT,                   -- quantos erraram
  erro_mensagem TEXT,                       -- última falha
  erro_detalhes JSON,                       -- stack/response
  timestamp_inicio DATETIME,
  timestamp_fim DATETIME,
  aprovado_por VARCHAR(100),                -- email do usuário que aprovou
  aprovado_em DATETIME,
  pronto_retry BOOLEAN DEFAULT FALSE,       -- aguardando retry após correção
  INDEX idx_session (test_session_id),
  INDEX idx_status (status),
  FOREIGN KEY (test_session_id) 
    REFERENCES tb_sync_test_session(id) ON DELETE CASCADE
);

CREATE TABLE tb_sync_test_session (
  id UUID PRIMARY KEY,
  iniciadp_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  finalizado_em DATETIME,
  status ENUM('em_andamento','parado','concluido'),
  observacoes TEXT,
  usuario VARCHAR(100)
);
```

### 2. Mapa de Dependências (descoberto via agente)

**Exemplo de estrutura esperada:**

```
Level 0 (Sem FK para tabelas síncronas):
  ✓ TB_USUARIO        /api/user/sincronize
  ✓ TB_PORTADOR       /api/carrier/sincronize
  ✓ TB_UNIDADE        /api/measure/sincronize

Level 1 (FK → Level 0):
  ✓ TB_EMPRESA        /api/entity/sincronize (FK: TB_USUARIO? não)
  ✓ TB_CLIENTE        /api/customer/sincronize (FK: TB_EMPRESA)

Level 2 (FK → Level 0 ou 1):
  ✓ TB_NOTA_FISCAL    /api/invoice/sincronize (FK: TB_CLIENTE)
  ✓ TB_PEDIDO         /api/order/sincronize (FK: TB_CLIENTE)

...
```

---

## 3. Fluxo de Testes

### Fase 1: Setup (Manual, uma vez)

```bash
# API: criar session + carregar mapa de dependências
POST /api/test/sessions
{
  "usuario": "valdo@setes.com.br",
  "observacoes": "Round 1 - Testes básicos"
}
→ { session_id: "uuid-123" }

# Delphi: fetch do mapa
GET /api/test/dependency-map
→ [
    { level: 0, table: "TB_USUARIO", endpoint: "/api/user/sincronize", ... },
    { level: 0, table: "TB_PORTADOR", endpoint: "/api/carrier/sincronize", ... },
    { level: 1, table: "TB_EMPRESA", endpoint: "/api/entity/sincronize", deps: [] },
    { level: 1, table: "TB_CLIENTE", endpoint: "/api/customer/sincronize", deps: ["TB_EMPRESA"] },
    ...
  ]
```

### Fase 2: Execução Incremental (Delphi coordena)

**Para cada tabela em ordem de dependência:**

```
1. Delphi conta registros no Firebird
   SELECT COUNT(*) FROM TB_CLIENTE WHERE DELETED = 'N'

2. Delphi marca início no log
   POST /api/test/sessions/{session_id}/tables/{table_name}/start
   { registros_esperados: 42 }

3. Delphi chama endpoint de sincronização (já existente)
   POST /api/customer/sincronize
   (autorizado como super; cria nova session ou reutiliza a de teste)

4. Delphi aguarda callback da API com resultado
   GET /api/test/sessions/{session_id}/tables/{table_name}/status
   → { status: "success", registros_enviados: 42, erro: null }

5. Delphi registra resultado
   POST /api/test/sessions/{session_id}/tables/{table_name}/finish
   { status: "success", registros_enviados: 42 }
```

### Fase 3: Tratamento de Erro

**Se algum endpoint falhar:**

```
1. API marca status = "failed"
   tb_sync_test_log.status = 'failed'
   tb_sync_test_log.erro_mensagem = resposta HTTP
   tb_sync_test_log.erro_detalhes = JSON full stack

2. Delphi para iteração (não tenta próximas tabelas que dependem desta)
   Exibe relatório: "TB_CLIENTE falhou em registro #15"

3. Usuário (você) recebe notificação:
   - Error log da API completo (GET /api/test/sessions/{id}/errors)
   - Diagnostica no código
   - Corrige (commit + push)
   - Compila Delphi (se necessário)

4. Após correção aprovada, limpar e retry:
   POST /api/test/sessions/{session_id}/tables/{table_name}/reset
   { approve_by: "valdo@setes.com.br" }
   → Limpa registros no destino (DELETE FROM tb_*)
   → Marca pronto_retry = true

5. Delphi retoma: volta para a tabela que falhou e reexecuta
```

### Fase 4: Conclusão

```
POST /api/test/sessions/{session_id}/finalize
→ Gera relatório com hits/fails por nível
```

---

## 4. Endpoints da API (setes-sync)

| Método | Path | O quê |
|--------|------|-------|
| POST | `/api/test/sessions` | Criar nova sessão de teste |
| GET | `/api/test/sessions/{id}` | Ver status da sessão |
| GET | `/api/test/dependency-map` | Mapa de dependências (order de execução) |
| POST | `/api/test/sessions/{id}/tables/{name}/start` | Marca início de teste da tabela |
| POST | `/api/test/sessions/{id}/tables/{name}/finish` | Registra resultado |
| POST | `/api/test/sessions/{id}/tables/{name}/reset` | Limpa e marca retry |
| GET | `/api/test/sessions/{id}/errors` | Lista todos os erros (para diagnóstico) |
| GET | `/api/test/sessions/{id}/report` | Relatório final (resumo + detalhes) |
| GET | `/api/test/sessions/{id}/logs` | Logs completos (JSON para Excel) |

---

## 5. Script Delphi (pseudocódigo)

```pascal
{ TTestSyncOrchestrator }

procedure TTestSyncOrchestrator.RunTests(sessionId: string);
var
  dependencyMap: TArray<TTableDependency>;
  level: Integer;
  table: TTableDependency;
  registerCount: Integer;
  response: TTestFinishRequest;
begin
  // 1. Fetch dependency map
  dependencyMap := FApiClient.GetDependencyMap();
  
  // 2. Para cada level (0, 1, 2, ...)
  level := 0;
  repeat
    for table in dependencyMap do
    begin
      if table.Level <> level then
        Continue;
      
      { Registra início }
      registerCount := CountRecords(table.Name);
      FApiClient.PostTableStart(sessionId, table.Name, registerCount);
      
      FLogger.Info('Testing: ' + table.Name + ' (' + registerCount.ToString() + ' regs)');
      
      try
        { Executa o envio (endpoint já existente) }
        ExecuteSendClass(table.SendClass, table.Endpoint, sessionId);
        
        { Registra sucesso }
        FApiClient.PostTableFinish(sessionId, table.Name, 'success', registerCount);
        FLogger.Info('✓ ' + table.Name + ' enviado com sucesso');
        
      except
        on E: Exception do
        begin
          { Registra erro }
          FApiClient.PostTableFinish(sessionId, table.Name, 'failed', 0, E.Message);
          FLogger.Error('✗ ' + table.Name + ' falhou: ' + E.Message);
          
          { Para iteração }
          ShowMessage('Erro em ' + table.Name + '.' + #13 +
                      'Aguardando correção...' + #13 +
                      'Logs: GET /api/test/sessions/' + sessionId + '/errors');
          
          Exit; // Interrompe, não continua
        end;
      end;
    end;
    
    Inc(level);
  until level > MaxLevels;
  
  FLogger.Info('Todos os testes concluídos!');
end;

procedure TTestSyncOrchestrator.ExecuteSendClass(
  sendClass, endpoint, sessionId: string);
begin
  { Chama o endpoint normal de sincronização (já existente) }
  { com header X-Test-Session: sessionId para a API saber que é um teste }
  FApiClient.Post(endpoint, Headers(['X-Test-Session: ' + sessionId]));
end;
```

---

## 6. Monitoramento em Tempo Real (Web UI opcional)

Dashboard simples mostrando:

```
Session: 2026-07-31T10:30:00
Usuário: valdo@setes.com.br
Status: PARADO (erro em TB_CLIENTE)

Level 0:
  ✓ TB_USUARIO        (32 regs)
  ✓ TB_PORTADOR       (5 regs)
  
Level 1:
  ✓ TB_EMPRESA        (12 regs)
  ✗ TB_CLIENTE        (esperava 42, falhou no #15)
    Erro: "Duplicated CNPJ"
    Aguardando aprovação de correção...
  
Level 2:
  ⊘ TB_NOTA_FISCAL    (bloqueado - TB_CLIENTE falhou)
  ⊘ TB_PEDIDO         (bloqueado - TB_CLIENTE falhou)
```

---

## 7. Aprovação e Retry (Fluxo manual)

1. **Você diagnostica** no log:
   ```
   GET /api/test/sessions/uuid-123/errors
   → [ { table: "TB_CLIENTE", erro: "Duplicated CNPJ", record_id: 42 } ]
   ```

2. **Você corrige** no código (setes-sync ou Delphi)

3. **Você aprova retry**:
   ```
   POST /api/test/sessions/uuid-123/tables/TB_CLIENTE/reset
   { approved_by: "valdo@setes.com.br" }
   ```
   → Limpa TB_CLIENTE no destino, marca `pronto_retry = true`

4. **Delphi retoma** de onde parou (volta para TB_CLIENTE, não reinicia tudo)

---

## Próximos Passos

1. ✓ **Agente**: mapear dependências (em andamento)
2. **Você**: revisar mapa (quando agente terminar)
3. **Implementação**:
   - [ ] DDL + migrations (tb_sync_test_log, tb_sync_test_session)
   - [ ] 8 endpoints na setes-sync API
   - [ ] Script Delphi no sincronizador
   - [ ] Dashboard (opcional, para visualizar)
4. **Testes piloto** com os dados do Valdo

