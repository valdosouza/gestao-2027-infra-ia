# Skill: Testar Sincronização Multi-Tenant

**Objetivo**: Validar que sincronização está funcionando corretamente  
**Tempo**: ~5 minutos
**Escopo**: setes

---

## 🚀 Teste Rápido

### 1. Sincronizar Cliente A

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-a-key-12345" \
  -d '{
    "customers": [
      {"id": 10, "name": "João Silva", "email": "joao@a.com"}
    ]
  }'
```

### 2. Sincronizar Cliente B

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-b-key-12345" \
  -d '{
    "customers": [
      {"id": 10, "name": "Pedro Costa", "email": "pedro@b.com"}
    ]
  }'
```

### 3. Verificar Isolamento

```bash
# Cliente A
mysql -u root -p -e "USE schema_cliente_a; SELECT * FROM tb_customer WHERE id = 10;"
# Output: João Silva

# Cliente B
mysql -u root -p -e "USE schema_cliente_b; SELECT * FROM tb_customer WHERE id = 10;"
# Output: Pedro Costa

# ✅ Dados isolados!
```

---

## 🔍 Teste com Erros

### API Key Inválida

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: INVALID-KEY" \
  -d '{"customers": []}'

# Esperado: 401 Unauthorized
```

### Payload Inválido

```bash
curl -X POST http://localhost:3001/customer/sincronize \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: cliente-a-key-12345" \
  -d '{"invalid": "payload"}'

# Esperado: 400 Bad Request
```

---

## ✅ Checklist

- [ ] Cliente A sincroniza
- [ ] Cliente B sincroniza
- [ ] Dados isolados por schema
- [ ] Erros tratados corretamente
- [ ] Logs registrados em sync_log

---

*Skill atualizada: 2026-07-01*

