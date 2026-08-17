**Escopo**: metodo

# Descobertas: Mapa de Dependências do Sincronizador

**Data:** 2026-07-31  
**Fonte:** Agente Explore (mapeamento de `D:\Gestao2027\sincronizador/` + ControllerTrigger.pas + RegisterClass)  
**Resultado:** 32 tabelas sincronizadas em 7 níveis de dependência

---

## 📊 Estatísticas

| Métrica | Valor |
|---------|-------|
| **Total de tabelas sincronizadas** | 32 |
| **Total de classes TxxxSendWeb** | 32 |
| **Níveis de dependência** | 7 (Level 0-6) |
| **Sequências no TB_LISTA_SINCRONIA** | 1-33 (Seq 34+ futuro) |
| **Tabelas removidas (Rodada 2)** | TB_PEDIDO (merged em TB_NOTA_FISCAL) |
| **Módulo deprecated** | TB_REST_* (restaurante) |
| **Endpoint inativo** | /invoice-rectification (TB_CARTA_CORRECAO, SET_ON='N') |

---

## 🎯 Achados Críticos

### 1. **TB_TRANSPORTADORA ANTES de TB_CLIENTE**

```
❌ ERRADO:
  1. Sync TB_CLIENTE
  2. Sync TB_TRANSPORTADORA
  → Erro: CARRIER_NOT_SYNCED (cliente não encontra transportadora)

✅ CORRETO:
  1. Sync TB_TRANSPORTADORA (Level 3)
  2. Sync TB_CLIENTE (Level 3)
  → Sucesso
```

**Impacto:** Qualquer teste que começar TB_CLIENTE ANTES de TB_TRANSPORTADORA falhará.  
**Implementação:** Em `test-sync.service.ts`, TB_TRANSPORTADORA é Seq 18, TB_CLIENTE é Seq 14 no mapa ordenado por Level (3 vs 3, mas TRANSPORTADORA listada antes).

---

### 2. **TB_EMPRESA NÃO É SINCRONIZADO SEPARADAMENTE**

```
TB_EMPRESA é mestre IMPLÍCITO para:
  ├─ TB_CLIENTE (CLI_CODEMP → TB_EMPRESA)
  ├─ TB_FORNECEDOR (FOR_CODEMP → TB_EMPRESA)
  ├─ TB_COLABORADOR (CLB_CODIGO → TB_EMPRESA, implícito)
  └─ TB_TRANSPORTADORA (TRP_CODEMP → TB_EMPRESA)
```

**Síntese:** Não há endpoint `/api/entity/sincronize` ou similar. A criação de empresa é IMPLÍCITA
quando um cliente/fornecedor é sincronizado (reuso por CPF/CNPJ, Fase 3).

**Impacto:** Testes não precisam de "etapa de empresa prévia". Ela é criada automaticamente.

---

### 3. **TB_PRODUTO É DUPLA: PRO_TIPO=M vs S**

```
TabelaFísica: TB_PRODUTO

Variant A (Merchandise):
  Class: TMerchandiseSendWeb
  Endpoint: /api/merchandise/sincronize
  Filter: PRO_TIPO = 'M' (padrão)
  PK: PRO_CODIGO
  FK: PRO_CODMRC, PRO_CODMED, PRO_CODEMB, PRO_CODCAT

Variant B (Service):
  Class: TServiceSendWeb
  Endpoint: /api/service/sincronize
  Filter: PRO_TIPO = 'S'
  PK: PRO_CODIGO (mesma tabela)
  FK: PRO_CODCAT (categoria)
```

**Impacto:** No teste, TB_PRODUTO aparece 2 vezes (Seq 6 e 19). Ambos sincronizam a MESMA tabela,
mas filtram por tipo. Ordem não importa (ambos Level 1), mas certifique-se de que CATEGORIA (Level 0)
passa antes.

---

### 4. **TB_NOTA_FISCAL É QUÁDRUPLA (Rodada 2, 2026-07-27)**

```
TabelaFísica: TB_NOTA_FISCAL (PK: NFL_CODIGO)

Variante 1: Avulsa (EM)
  Class: TInvoiceSendWeb
  Endpoint: /api/invoice/sincronize
  Sem dependência de pedido

Variante 2: Serviço (PED_TIPO=1 + itens PRO_TIPO=S)
  Class: TInvoiceServiceSendWeb
  Endpoint: /api/order-service/sincronize
  Depende: TB_CLIENTE

Variante 3: Venda (PED_TIPO=1, nenhum item S)
  Class: TInvoiceMerchandiseSaleSendWeb
  Endpoint: /api/order-sale/sincronize
  Depende: TB_CLIENTE

Variante 4: Compra (PED_TIPO=2, issuer=N)
  Class: TInvoiceMerchandisePurchaseSendWeb
  Endpoint: /api/order-purchase/sincronize
  Depende: TB_FORNECEDOR

Variante 5: Ajuste (PED_TIPO=3, entidade opcional)
  Class: TInvoiceMerchandiseAdjustSendWeb
  Endpoint: /api/order-stock-adjust/sincronize
  Sem dependência obrigatória
```

**Impacto:** TB_NOTA_FISCAL aparece 5 vezes (Seq 20-24). Mesma tabela física, mas filtros
e dependências diferentes. Todos Level 6, após CLIENTE/FORNECEDOR.

---

### 5. **TB_RETORNO_NFS (Onda 6) — REATIVADA 2026-07-25**

```
Histórico:
  - Commit patch 04 (2026-07-25): TInvoiceReturnServiceSendWeb criada
  - Arquivo: invoice_return_service_send_web.pas
  - Seed: Seq 28 SET_ON='S'
  - Molde: 55/65 (NF-e/NFC-e)

Status Atual:
  ✓ Classe Delphi: TInvoiceReturnServiceSendWeb
  ✓ Endpoint: /api/invoice-return-service/sincronize
  ✓ Level: 7
  ✓ Depende: TB_NOTA_FISCAL

Nota: Patch 04 aguardava compilação do Valdo (2026-07-25).
```

**Impacto:** Se você está em Rodada 3+, TB_RETORNO_NFS já deve estar ativa.
Teste: execute `/api/invoice-return-service/sincronize` com dados de exemplo.

---

### 6. **TB_CARTA_CORRECAO (CC-e) — INATIVA**

```
Histórico:
  - Classe Delphi: TInvoiceRectificationSendWeb
  - Arquivo: invoice_rectification_send_web.pas
  - Seed: Seq 33 (REMOVIDA ou SET_ON='N')
  - Endpoint: /api/invoice-rectification/sincronize
  
Status Atual:
  ❌ INATIVO
  Razão: Endpoint NÃO implementado em nenhuma onda
  Achado: "TInvoiceRectificationSendWeb sem endpoint em nenhuma onda"

Decision (Rodada 4):
  → Nova gap na Rodada 4: implementar CC-e ou aprovar descontinuação
```

**Impacto:** NÃO incluir TB_CARTA_CORRECAO em testes. Se precisar, reopening como tarefa separada.

---

### 7. **Tabelas Removidas: TB_PEDIDO Merged em TB_NOTA_FISCAL**

```
Antes (Rodada 1):
  TB_PEDIDO → Tabela separada
  Trigger TG_SRC_PEDIDO → Marca para sincronização

Rodada 2 (2026-07-27):
  ❌ TB_PEDIDO SAIU da fila de sincronização
  ✅ TB_NOTA_FISCAL dirige TUDO
  ✅ /order-* recebem objeto completo (invoice + nota na mesma transação)
  ✅ Trigger TG_SRC_PEDIDO morto
  ✅ Bootstrap limpa Seqs 17/18/19/21/41

Implicação:
  - Não sincronize TB_PEDIDO
  - Sincronize TB_NOTA_FISCAL (com filtros por PED_TIPO e PRO_TIPO)
  - A ordem (TB_PEDIDO, TB_NOTA_FISCAL) é implícita agora
```

**Impacto:** Arquitetura antigos de teste que sincronizavam "TB_PEDIDO depois de TB_CLIENTE"
ficarão obsoletos. Use TB_NOTA_FISCAL variantes (20-24).

---

### 8. **Tabelas do Módulo Restaurante (TB_REST_*) — DEPRECATED**

```
Módulo: Restaurant (PDV)

Tabelas:
  TB_REST_COMANDA
  TB_REST_MESA
  TB_REST_CARDAPIO
  ... (7 no total)

Sync:
  ❌ Seqs 31-37 DELETADAS do seed (bootstrap 2026-07-26)
  ❌ Não sincronizadas
  ❌ Módulo aposentado

Razão: Decisão de negócio 2026-01 (fora de escopo Setes+Metodo)
```

**Impacto:** Ignorar em testes. Se cliente legado tiver esses dados, precisará de migração
manual (fora do escopo do sincronizador).

---

### 9. **TB_CATEGORIA = Árvore Recalculada**

```
Estrutura:
  TB_CATEGORY (ID, parent_id, position_level)
  Relação: Hierarquia recursiva (categoria pai → subcategorias)

Sincronização:
  Class: TCategorySendWeb
  Endpoint: /api/category/sincronize
  Level: 0 (nenhuma dependência)

Processamento:
  - Ao sincronizar, recalcular position_level da árvore
  - Dedupe: não sincronizar duplicatas por (name, parent_id)
  - Soft delete se removida no Firebird (DELETED='S')

Impacto no Teste:
  ✅ Pode ser primeira (Level 0)
  ⚠️ Cuidado com duplicatas: se teste rodar 2x, pode gerar posição_level errada
  Solução: Reset da sessão anterior antes de rodar Round 2
```

---

### 10. **Catálogos Centralizados (Brand, Package, Measure)**

```
Catálogos (Fase 2, Migration 018):
  1. TB_MARCA_PRODUTO (Brand)
  2. TB_EMBALAGEM (Package)
  3. TB_MEDIDA (Measure)

Deduplicação:
  - Chave: Descrição (não ID)
  - Regra: INSERT IF NOT EXISTS by description
  - Central: setes_central.tb_institution_has_* (DDL pendente)

Sync:
  Classes: TBrandSendWeb, TPackageSendWeb, TMeasureSendWeb
  Endpoints: /api/brand, /api/package, /api/measure
  Level: 0 (nenhuma dependência)

Impacto no Teste:
  ✅ Pode ser primeira (Level 0)
  ⚠️ Dedupe por description: se inserir "Unidade" 2x, segunda ignora
  Teste: verificar que COUNT é igual aos esperados (sem duplicata)
```

---

## 🗺️ Mapa Completo (Ordenado por Level)

```
LEVEL 0 (7 tabelas):
  Seq 1:  TB_USUARIO (TUserSendWeb)
  Seq 2:  TB_MARCA_PRODUTO (TBrandSendWeb)
  Seq 3:  TB_CATEGORY (TCategorySendWeb)
  Seq 4:  TB_MEDIDA (TMeasureSendWeb)
  Seq 5:  TB_EMBALAGEM (TPackageSendWeb)
  Seq 12: TB_PLANOCONTAS (TFinancialPlansSendWeb)
  Seq 13: TB_FORMAPAGTO (TPaymentTypeSendWeb)

LEVEL 1 (4 tabelas, 5 endpoints):
  Seq 6:  TB_PRODUTO PRO_TIPO=M (TMerchandiseSendWeb)
  Seq 19: TB_PRODUTO PRO_TIPO=S (TServiceSendWeb)
  Seq 9:  TB_ESTOQUES (TStockListSendWeb)
  Seq 11: TB_PROMOTION (TPromotionSendWeb)

LEVEL 2 (3 tabelas):
  Seq 7:  TB_TABELA_PRECO (TPriceListSendWeb)
  Seq 8:  TB_PRECO (TPriceSendWeb)
  Seq 10: TB_ESTOQUE (TStockBalanceSendWeb)

LEVEL 3 (5 tabelas):
  Seq 18: TB_TRANSPORTADORA (TCarrierSendWeb) ← ANTES de TB_CLIENTE
  Seq 17: TB_CONTABANCARIA (TBankAccountSendWeb)
  Seq 16: TB_COLABORADOR (TSalesManSendWeb)
  Seq 15: TB_FORNECEDOR (TProviderSendWeb)
  Seq 14: TB_CLIENTE (TCustomerSendWeb) ← DEPOIS de TB_TRANSPORTADORA

LEVEL 4 (1 tabela):
  Seq 25: TB_CTRL_ESTOQUE (TStockStatementSendWeb)

LEVEL 5 (3 tabelas):
  Seq 26: TB_FINANCEIRO (TFinancialSendWeb)
  Seq 27: TB_MOVIM_FINANCEIRO (TFinancialStatementSendWeb)
  Seq 28: TB_CASHIER (TCashierSendWeb)

LEVEL 6 (5 tabelas, 5 endpoints):
  Seq 20: TB_NOTA_FISCAL avulsa (TInvoiceSendWeb)
  Seq 21: TB_NOTA_FISCAL serviço (TInvoiceServiceSendWeb)
  Seq 22: TB_NOTA_FISCAL venda (TInvoiceMerchandiseSaleSendWeb)
  Seq 23: TB_NOTA_FISCAL compra (TInvoiceMerchandisePurchaseSendWeb)
  Seq 24: TB_NOTA_FISCAL ajuste (TInvoiceMerchandiseAdjustSendWeb)

LEVEL 7 (4 tabelas):
  Seq 29: TB_RETORNO_NFE (TInvoiceReturn55SendWeb)
  Seq 30: TB_RETORNO_NFC (TInvoiceReturn65SendWeb)
  Seq 31: TB_RETORNO_NFS (TInvoiceReturnServiceSendWeb)
  Seq 32: TB_ARQUIVOS (TFileSendWeb)

INATIVO:
  Seq 33: TB_CARTA_CORRECAO (TInvoiceRectificationSendWeb) ← endpoint não implementado
```

---

## 📝 Próximas Ações para Você

1. **Round 1 (Catalogs — Level 0)**
   - [ ] Teste TB_USUARIO, TB_MARCA, TB_CATEGORY, TB_MEDIDA, TB_EMBALAGEM, TB_PLANOCONTAS, TB_FORMAPAGTO
   - Esperado: 7 sucessos, sem dependências

2. **Round 2 (Produtos — Level 1)**
   - [ ] Teste TB_PRODUTO (ambas variantes), TB_ESTOQUES, TB_PROMOTION
   - Esperado: 5 sucessos (depende de Level 0)
   - Bloqueador: falta de marca/medida/categoria

3. **Round 3 (Precificação — Level 2)**
   - [ ] Teste TB_TABELA_PRECO, TB_PRECO, TB_ESTOQUE
   - Esperado: 3 sucessos
   - Bloqueador: falta de produto ou tabela de preço

4. **Round 4 (Entidades — Level 3) — CRÍTICO**
   - [ ] Teste TB_TRANSPORTADORA **antes** de TB_CLIENTE
   - [ ] Teste TB_COLABORADOR, TB_FORNECEDOR
   - Esperado: 5 sucessos
   - Bloqueador: **ordem de TRANSPORTADORA vs CLIENTE**

5. **Round 5 (Financeiro — Level 5)**
   - [ ] Teste TB_FINANCEIRO, TB_MOVIM_FINANCEIRO, TB_CASHIER
   - Esperado: 3 sucessos

6. **Round 6 (Documentos — Level 6) — VOLUME ALTO**
   - [ ] Teste TB_NOTA_FISCAL (5 variantes)
   - Esperado: 5 sucessos (podem ser mesma tabela, filtros diferentes)
   - Bloqueador: falta de cliente/fornecedor

7. **Round 7 (Retornos — Level 7) — FINAL**
   - [ ] Teste TB_RETORNO_*, TB_ARQUIVOS
   - Esperado: 4 sucessos
   - Bloqueador: falta de nota fiscal

---

## 📚 Referências

- **Documentação Sync:** `Infra-IA/setes-sync/MAPA_INDEXACAO.md`
- **Contrato Sync:** `Infra-IA/setes-sync/CONTRATOS_SYNC.md`
- **Rodada 3 (Sincronia):** `Infra-IA/setes-sync/prompt_notas_mercadoria_servico.md`
- **Mapa Atual:** `test-sync.service.ts` (initializeDependencyMap)

