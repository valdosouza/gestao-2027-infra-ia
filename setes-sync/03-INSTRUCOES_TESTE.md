# Instruções para Testar setes-sync
**Escopo**: setes

## Fase 1: Preparação (5 min)

### 1.1 Abrir Terminal 1 (para setes-sync)

```bash
cd D:\Gestao2027\setes-sync
npm install
```

### 1.2 Criar arquivo `.env`

Copie `.env.example` para `.env`:

```bash
cp .env.example .env
```

Edite `.env` e configure (veja SETUP.md para detalhes):

```
PORT=3001
SYNC_API_KEY=sua_chave_compartilhada_do_sincronizador_aqui
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=seu_password
DB_NAME=setes_central
```

---

## Fase 2: Iniciar setes-sync (Terminal 1)

```bash
npm run dev
```

**Esperado**:
```
[INFO]  2026-07-01T15:30:00.000Z Setes Sync API rodando na porta 3001
```

Se não aparecer essa mensagem, verifique:
- Port 3001 não está em uso
- `.env` está configurado
- Node.js 18+ está instalado

---

## Fase 3: Testes Básicos (Terminal 2)

### 3.1 Test Health Check

```bash
curl http://localhost:3001/health
```

**Esperado**:
```json
{"status":"ok","service":"setes-sync","ts":"..."}
```

### 3.2 Test Autenticação (sem chave)

```bash
curl -X POST http://localhost:3001/brand/sincronize \
  -H "Content-Type: application/json" \
  -d '{"brands": []}'
```

**Esperado**: `401 - X-Api-Key header obrigatorio`

### 3.3 Test com X-Api-Key válida

```bash
curl -X POST http://localhost:3001/brand/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: sua_chave_compartilhada_do_sincronizador_aqui" \
  -d '{"brands": [{"id": "1", "name": "Brand A"}]}'
```

**Esperado**: 
- `200` com `{"ok": true, "inserted": 1, ...}` (se DB conectado)
- `500` (se DB não conectado) — menos crítico, mostra que auth passou

---

## Fase 4: Rodar Testes Automatizados (Terminal 2)

```bash
cd D:\Gestao2027\setes-sync
npm test
```

**Esperado**: 
```
PASS  src/__tests__/integration.test.ts
  ✓ GET /health retorna 200
  ✓ POST /brand/sincronize retorna 401 sem X-Api-Key
  ...
```

---

## Fase 5: Integração com Sincronizador Delphi

### 5.1 Configurar Sincronizador

No Sincronizador.exe:
1. Abrir settings/config
2. Alterar URL de sincronização para: `http://localhost:3001`
3. Configurar X-Api-Key: `sua_chave_compartilhada_do_sincronizador_aqui`
4. Testar conexão

### 5.2 Iniciar Sincronização

1. Abrir Sincronizador.exe
2. Iniciar sincronização de dados
3. Monitorar logs em tempo real (Terminal 1)

**Logs esperados**:
```
[INFO]  2026-07-01T15:30:05.123Z Sincronizador autenticado
[INFO]  2026-07-01T15:30:06.456Z Sincronizando brand: 10 registros
[INFO]  2026-07-01T15:30:07.789Z Sincronizando customer: 25 registros
```

### 5.3 Validar no Banco

```sql
-- Terminal SQL
mysql -u root -p

USE setes_central;
SELECT * FROM sync_log ORDER BY created_at DESC LIMIT 5;

USE schema_tenant_001;
SELECT COUNT(*) FROM tb_brand;
SELECT COUNT(*) FROM tb_customer;
```

---

## Checklist de Sucesso

- [ ] `npm run dev` roda sem erros
- [ ] GET `/health` retorna 200
- [ ] POST sem X-Api-Key retorna 401
- [ ] POST com X-Api-Key passa autenticação
- [ ] `npm test` todos os testes passam
- [ ] Sincronizador consegue conectar
- [ ] Dados aparecem no banco após sincronização
- [ ] Logs mostram "Sincronizador autenticado"

---

## Troubleshooting

### Problema: "Port 3001 already in use"

**Solução Windows**:
```bash
netstat -ano | findstr :3001
taskkill /PID <PID> /F
```

**Solução Linux/Mac**:
```bash
lsof -i :3001
kill -9 <PID>
```

### Problema: "401 - API Key invalida" mesmo com chave certa

**Verificar**:
1. Tabela `setes_central.sync_api_keys` existe?
2. Registra com api_key e active=TRUE existe?
3. Chave está exatamente igual em setes-sync/.env e BD?

**SQL**:
```sql
SELECT * FROM setes_central.sync_api_keys WHERE api_key LIKE '%sua_chave%';
```

### Problema: "Cannot find module '@shared/db/connection'"

**Solução**:
```bash
npm install
npm run dev
```

### Problema: Dados não aparecem no banco

**Verificar**:
1. DB está accessible? Teste: `mysql -u root -p setes_central`
2. Schema de tenant existe? Ex: `schema_tenant_001`
3. Tabelas existem no schema? Ex: `tb_brand`, `tb_customer`
4. Logs em setes-sync mostram erro?

---

## Próximos Passos

✅ Tarefa #5 (Testar setes-sync): **COMPLETO**

⏳ Tarefa #6: Validar setes-api sem sync (ERP puro)
⏳ Tarefa #7: Documentar arquitetura pós-desacoplamento
⏳ Tarefa #8: Configurar banco de dados para setes-sync

