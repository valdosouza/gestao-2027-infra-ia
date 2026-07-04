# Skill: Teste E2E Completo

**Objetivo**: Testar fluxo completo: Sync → API → Dados  
**Tempo**: ~10 minutos

---

## 📋 Checklist Pré-Teste

- [ ] MySQL rodando
- [ ] setes-sync rodando (porta 3001)
- [ ] setes-api rodando (porta 3000)
- [ ] API Keys cadastradas
- [ ] Schemas criados

---

## 🧪 Teste 1: Health Checks

```bash
# setes-sync
curl http://localhost:3001/health
# Esperado: { "status": "ok" }

# setes-api
curl http://localhost:3000/health
# Esperado: { "status": "ok" }
```

---

## 🔄 Teste 2: Sincronização Completa

### 2a. Sincronizar dados

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-a-key-12345" \
  -d '{
    "customers": [
      {"id": 100, "name": "Test Customer A", "email": "teste@a.com"}
    ]
  }'
```

**Esperado**: `{ "ok": true, "inserted": 1 }`

### 2b. Sincronizar para Cliente B

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-b-key-12345" \
  -d '{
    "customers": [
      {"id": 100, "name": "Test Customer B", "email": "teste@b.com"}
    ]
  }'
```

**Esperado**: `{ "ok": true, "inserted": 1 }`

---

## 📖 Teste 3: Gerar JWT e Acessar API

```bash
# Gerar token Cliente A
TOKEN_A=$(npx ts-node -e "
const jwt = require('jsonwebtoken');
const token = jwt.sign({
  tenantId: 'cliente-a',
  userId: 'user-001',
  role: 'client_user',
  schemaName: 'schema_cliente_a'
}, 'sua_chave_secreta_aqui', { expiresIn: '24h' });
console.log(token);
")

# Usar token na API
curl -X GET http://localhost:3000/api/core/info \
  -H "Authorization: Bearer $TOKEN_A"
```

**Esperado**: Dados de Cliente A retornados

---

## 🔐 Teste 4: Isolamento de Dados

### 4a. Verificar dados Cliente A

```sql
USE schema_cliente_a;
SELECT * FROM tb_customer WHERE id = 100;
-- Esperado: Test Customer A
```

### 4b. Verificar dados Cliente B

```sql
USE schema_cliente_b;
SELECT * FROM tb_customer WHERE id = 100;
-- Esperado: Test Customer B
-- Os IDs são iguais mas dados são diferentes = ISOLAMENTO OK ✅
```

---

## 📊 Teste 5: Verificar Logs

```sql
USE setes_central;
SELECT tenant_id, endpoint, status, records_count FROM sync_log 
ORDER BY created_at DESC LIMIT 5;
```

---

## ✅ Teste 6: Swagger APIs

- [ ] http://localhost:3001/docs (23 endpoints)
- [ ] http://localhost:3000/docs (5 endpoints)

---

## 🎉 E2E Completo!

Se todos os testes passarem:

- ✅ Arquitetura funcional
- ✅ Multi-tenant operacional
- ✅ Isolamento de dados garantido
- ✅ APIs respondendo corretamente
- ✅ Pronto para produção

---

*Skill atualizada: 2026-07-01*

