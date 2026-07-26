# Prompt — Revisão do Sincronizador × setes-sync (FECHADO — 3 rodadas, 24 decisões)

> **IMPLEMENTADO (lado setes-sync) em 2026-07-19 — Ondas 1–6 completas no mesmo dia.**
> 14 testes jest + 4 suítes de smoke (auth, cadastros, papéis/reindexação, movimento,
> retornos/arquivos) todas verdes contra o banco dev. Docs vivos:
> `MAPA_INDEXACAO.md` (indexadores + pendências da Rodada 4) e `CONTRATOS_SYNC.md`
> (contrato por endpoint — fonte da verdade para o Delphi).
> **Frente Delphi**: kit de patches em `sincronizador/patches-revisao-2026-07/`
> (C1–C12; compilação/teste com o Valdo).
> **Rodada 4 pendente** (3 achados de DDL — ver seção no MAPA_INDEXACAO):
> tb_order.tb_user_id NOT NULL (usuário do sync), vínculo nota×pedido,
> PK da tb_stock_statement. **Decisão nova registrada na implementação**:
> semântica de ESPELHO do financeiro (baixa do legado = evento 1 'N' via upsert;
> estornos do legado não viajam — imutabilidade plena só p/ eventos web).

**Origem**: `Infra-IA/prompts/Explicacoes sobre o Sincronizador e setes-sync.md` (rascunho do Valdo, 2026-07-19)
**Método**: `skills-genericas/refinar-prompt-arquitetura.md` (rodadas de decisão numeradas)
**Escopo**: setes
**Nota de produto**: esta revisão é o **caso nº 2 do método** da Engine de Modernização — insights de método vão para `prompts/rascunho_engine_modernizacao.md`.

---

## Contexto

Três gerações de sistema:

| # | Projeto | Tecnologia | Papel |
|---|---------|-----------|-------|
| 1 | **Gestao2016** | Delphi desktop + Firebird 2.5 | Em produção nos clientes atuais. Banco MUITO diferente do novo — o sincronizador precisa de cuidado extra nas indexações ao montar os pacotes JSON |
| 2 | **GestaoWeb** | Delphi + UniGui (gera Sencha/JS) | Intermediário aposentado. O banco do Gestao2027 é ~95% derivado DELE (12 anos de maturação) — **não** do Firebird. Referências (`d:\gestaoweb`) usar com MUITA cautela: models/controllers servem de referência, mas não trabalha com API e não tem cliente usando |
| 3 | **Gestao2027** | Flutter WebApp + APIs Node/TS | O destino. setes-api (3000) + setes-sync (3001) |

**Papel do sincronizador**: temporário por cliente — leva os dados do Firebird local para a web de 5 em 5 minutos, até o cliente migrar de vez. Com os dados na web, o comercial vende os produtos mobile; com o tempo o Gestao2016 é aposentado.

**Fluxo**: `Gestao2016 (Firebird) → Sincronizador.exe (Delphi) → setes-sync:3001 → setes_central + setes_<schema>`

---

## Objetivos

1. Revisar TODOS os endpoints da setes-sync para o padrão vigente (Fase 2 Gerenciamento Central + Fase 3 Entidade Única) — hoje o código está defasado (ver seção "Achados no código atual").
2. Implementar a **reindexação por CPF/CNPJ** no recebimento dos pacotes (calcanhar de aquiles — ver seção Indexações).
3. Implementar o fluxo do **UUID para registros sem documento** (`tb_no_doc` → `tb_empresa.externalCode` no Firebird).
4. Implementar **autenticação entre sistemas** (Sincronizador ↔ setes-sync).
5. Implementar **soft delete** ponta a ponta (campo `DELETED` no Firebird → payload → destino).
6. Centralizar **Brand/Package/Measure** em `setes_central` com vínculos `tb_institution_has_*`.
7. Corrigir os bugs conhecidos do Sincronizador Delphi (lista na seção Correções Delphi).
8. Tratar retorno de NF-e (55/65), NFS-e e arquivos XML em disco.

---

## Decisões arquiteturais registradas (permanente)

> Decisões já tomadas pelo Valdo no rascunho de 2026-07-19. Numeração contínua entre rodadas.

- **D1 — Dois grupos distintos (REGRA CANÔNICA)**: `setes-app` consome `setes-api`; `Sincronizador` consome `setes-sync`. Esta revisão **não altera nada** em setes-api nem em setes-app.
- **D2 — Soft delete no Firebird**: será criado um campo `DELETED` em cada tabela sincronizada do Firebird. Sem deleção física; o Gestao2016 muda de comportamento (DELETE vira UPDATE). É a única alteração de DDL no Firebird.
- **D3 — Indexador é o documento, nunca o código local**: `emp_codigo` do Firebird NUNCA é referência (o mesmo CNPJ existe com códigos diferentes em cada cliente da Setes). A setes-sync, ao receber pacote com CPF/CNPJ, **reindexa para entity.id** da central; se não encontra, cria a entity (person/company) no padrão da Fase 3.
- **D4 — Sem documento → UUID**: cadastros do Firebird sem CPF/CNPJ sincronizam mesmo assim (histórico). Na primeira sincronização a web gera o UUID (`tb_no_doc.external_id`, padrão Fase 3) e o **devolve**; o Sincronizador grava em `tb_empresa.externalCode` (campo novo a criar, criação automatizada). Nas sincronizações seguintes o UUID é o indexador — sem risco de duplicar cliente.
- **D5 — Brand/Package/Measure centralizados**: `tb_brand`, `tb_package`, `tb_measure` viram registros ÚNICOS em `setes_central`, deduplicados por **descrição**. Clientes usam via vínculo: `tb_institution_has_brand` / `tb_institution_has_package` / `tb_institution_has_measure` (podem inativar / soft delete no vínculo).
- **D6 — Cadência**: sincronização de 5 em 5 minutos, 24/7. Duração temporária, cliente a cliente, até o cutover.
- **D7 — Dual-write existe**: há clientes com apps mobile de venda — pedidos feitos na web precisarão voltar para o Firebird (sentido inverso, `TReceiveFromWebServer`).
- **D8 — Prioridade das classes de envio** (ordem do Valdo):
  1. TBrandSendWeb · 2. TCategorySendWeb · 3. TMeasureSendWeb · 4. TPackageSendWeb · 5. TMerchandiseSendWeb · 6. TPriceListSendWeb · 7. TPriceSendWeb · 8. TStockListSendWeb · 9. TStockBalanceSendWeb · 10. TPromotionSendWeb · 11. TFinancialPlansSendWeb · 12. TPaymentTypeSendWeb · 13. TCustomerSendWeb · 14. TProviderSendWeb · 15. TSalesManSendWeb · 16. TBankAccountSendWeb (⚠️ revisar — bug de serialização) · 17. TOrderSaleSendWeb · 18. TOrderPurchaseSendWeb · 19. TOrderStockAdjustSendWeb · 20. TInvoiceSendWeb · 21. TInvoiceMerchandiseSendWeb · 22. TStockStatementSendWeb · 23. TFinancialSendWeb · 24. TFinancialStatementSendWeb · 25. TCashierSendWeb
  Depois: retorno de NF-e **modelo 55**, **modelo 65**, **NFS-e** (`TInvoiceReturnServiceSendWeb`, hoje comentada) e **arquivos** (`TFileSendWeb`).
- **D9 — Arquivos XML em disco**: arquivos que hoje são gravados no banco Firebird passam a ser gravados em **disco no servidor web**, devidamente **indexados por CNPJ**.
- **D10 — Software House fora do escopo**: o desktop tem muitos buracos em relação ao módulo novo; o sync não tenta cobri-lo.
- **D11 — Id local do Firebird**: em alguns casos poderá ser usado; esses casos precisam de um **local de memorização permanente** (ver Q6).

> Rodada 1 (2026-07-19) — decisões do Valdo sobre Q1–Q4 e Q9:

- **D12 — Autenticação por cliente** (Q1): UMA API key por instalação em `setes_central.tb_sync_api_key` → resolve `institutionId` + `schemaName`. A chave global `SYNC_API_KEY` do `.env` é APOSENTADA. Chave configurada no Sincronizador junto com a URL base.
- **D13 — Reuso por CÓPIA + fronteira de gravação SEM AMBIGUIDADE** (Q2): as peças da cadeia de entidade são COPIADAS da setes-api para a setes-sync (projetos independentes, D1 preservada). Regra absoluta de gravação: `tb_entity`/`tb_person`/`tb_company`/`tb_address`/`tb_phone`/`tb_mailing`/`tb_no_doc` **TUDO em `setes_central`**; no schema do cliente que está enviando fica **apenas o vínculo do papel** (`tb_customer`/`tb_provider`/... com id = entity.id). Não pode haver dúvida no uso.
- **D14 — Mapeamento sem-documento é SÓ o externalCode** (Q3): cada registro de `tb_empresa` sem CPF/CNPJ recebe o UUID no campo novo `tb_empresa.externalCode` (a criar no Firebird). **Não** se usa `TB_GESTAO_WEB` para mapeamento de entidades. O response da setes-sync devolve o `externalCode` gerado e o Sincronizador o grava.
- **D15 — Payload ALINHADO ao novo formato** (Q4): em vez de manter os JSONs legados do Delphi, o Sincronizador será ajustado para montar o JSON **o mais alinhado possível ao formato que a setes-sync grava** — aumenta a eficiência da setes-sync (menos tradução no servidor). Consequência: os data objects Delphi serão remodelados (ver C11 e Q12).
- **D16 — Sentido inverso é fase própria** (Q9): `TReceiveFromWebServer` + pedidos web/mobile → Firebird ficam para "Sync Fase 2 — Recebimento", depois que o envio estiver estável.

> Rodada 2 (2026-07-19) — decisões do Valdo sobre Q5, Q6, Q8, Q10, Q11 e Q12:

- **D17 — Critério de dedupe por descrição** (Q5): comparação por `UPPER(TRIM(descricao))`, SEM colapsar acentos ("AÇO" ≠ "ACO"). Vale para Brand/Package/Measure na central.
- **D18 — MAPA_INDEXACAO.md** (Q6): criar `Infra-IA/setes-sync/MAPA_INDEXACAO.md` — tabela por entidade: indexador na web (documento / UUID / descrição / id local), transformações e os casos onde o id do Firebird É aceito. Leitura obrigatória da skill `novo-endpoint-sync.md`.
- **D19 — Fila interna removida** (Q8): o Delphi envia registro a registro (fila é a TB_SINCRONIA no Firebird). A `sync.queue` em memória sai; processamento síncrono e transacional por POST.
- **D20 — XMLs em disco** (Q10): raiz configurável por env var `SYNC_FILES_ROOT`; estrutura `<cnpj>/<ano>/<mes>/<chave>.xml`; no banco ficam metadados + caminho.
- **D21 — Inventário oficial é o passo 0** (Q11): a implementação começa rodando `SELECT CLASS_NAME, END_POINT, WAY, SET_ON FROM TB_LISTA_SINCRONIA` no Firebird de produção para fechar a lista real de classes/endpoints.
- **D22 — Contrato = shape das peças copiadas da setes-api** (Q12): os contratos JSON dos endpoints espelham o formato de entrada das peças da Fase 3 copiadas da setes-api (entidade = shape do `EntityFiscalInput` + bloco do papel); documentados endpoint a endpoint. Os ajustes para produzir esse JSON são feitos NO SINCRONIZADOR — **é o sistema que será aposentado, então é ele que se adapta ao formato novo, nunca o contrário** (princípio de direção da revisão inteira).

> Rodada 3 (2026-07-19) — decisões finais do Valdo:

- **D23 — Endpoints de restaurante APOSENTADOS** (Q7): os 7 arquivos `rest-*` (restgroup, restsubgroup, restmenu, restmenuhasingrediente, restgrouphasattribute, restgrouphasmeasure, restgrouphasoptional) saem do código; conhecimento vai para `Infra-IA/HISTORICO/`.
- **D24 — Central inicia do ZERO** (Q13): não haverá dedupe retroativo de `tb_brand`/`tb_package`/`tb_measure` — a base central começa limpa; o dedupe por descrição (D17) vale desde o primeiro registro sincronizado.

---

## Indexações (o coração do problema)

`tb_empresa` do Firebird foi dividida na nova estrutura em:
- `tb_entity` (+ `tb_person` OU `tb_company`)
- `tb_mailing`
- `tb_social_media`
- (endereços/fones: `tb_address`, `tb_phone`)

Fluxo de reindexação no recebimento (por pacote com dados de entidade):

```
1. Pacote chega com CPF/CNPJ (ou sem documento + externalCode/UUID)
2. COM documento:  busca tb_person.cpf / tb_company.cnpj em setes_central
   → achou:      usa entity.id (reindexa o pacote)
   → não achou:  cria entity + person/company (padrão Fase 3: busca DENTRO da transação)
3. SEM documento:
   → pacote traz externalCode (UUID)?  busca tb_no_doc.external_id → entity.id
   → não traz?  cria entity + tb_no_doc (UUID) e DEVOLVE o UUID no response
                → Sincronizador grava em tb_empresa.externalCode
4. O id do papel (tb_customer/tb_provider/...) = entity.id no schema do cliente (Fase 3)
```

Brand/Package/Measure: dedupe central por descrição + vínculo `tb_institution_has_*` (D5).

---

## Achados no código atual da setes-sync (evidências — Rodada 0)

> A setes-sync tem ~30 endpoints implementados, mas o código é **anterior às Fases 2 e 3**:

| # | Achado | Evidência | Conflita com |
|---|--------|-----------|--------------|
| A1 | Auth por cliente consulta `setes_central.sync_api_keys` com `tenant_id`/`schema_name` | `sync.auth.middleware.ts:29-31` | Fase 2: tabela é `tb_sync_api_key`, modelo institution (nunca tenant) |
| A2 | Existe um SEGUNDO middleware com chave única global `SYNC_API_KEY` do `.env` | `gateway/auth.middleware.ts:12` | Modelo por cliente (uma chave por instalação) |
| A3 | `customer.ts` grava `tb_entity`/`tb_person`/`tb_company`/`tb_address`... **dentro do schema do cliente** (`USE schemaName`) | `endpoints/customer.ts:80` + `saveFiscalEntity` | Fase 3: cadeia mora SÓ em `setes_central` (migration 005 dropou as cópias locais — essas tabelas nem existem mais no schema do cliente) |
| A4 | `customer.ts` usa `Cliente.id` (id do Firebird) como id da entity | `endpoints/customer.ts:85` | D3: documento é o indexador, nunca o código local |
| A5 | Não existe reindexação por CPF/CNPJ nem fluxo de UUID/`tb_no_doc` | `sync.lookup.ts` (só description e bank number) | D3, D4 |
| A6 | `findOrCreateByDescription` cria direto na tabela, sem vínculo `tb_institution_has_*` | `sync.lookup.ts:4-26` | D5 |
| A7 | Não há tratamento de soft delete (`DELETED`) em nenhum endpoint | grep | D2 |
| A8 | `tb_institution_has_entity` é usada pelo customer.ts — verificar se ainda existe no modelo atual | `endpoints/customer.ts:88` | Fase 3 |
| A9 | Endpoints de restaurante (`rest-*`, 7 arquivos) ainda existem no código | `endpoints/rest*.ts` | Doc diz "removidos" |
| A10 | Fila em memória (`sync.queue`) para lotes > 50 — mas o Sincronizador envia 1 registro por POST (fila TB_SINCRONIA) | `sync.service.ts:23` | Complexidade possivelmente morta |

**Conclusão da Rodada 0**: a revisão não é "ajuste fino" — é **reescrever a camada de gravação** dos endpoints no padrão Fase 3, mantendo o contrato com o Delphi o mais estável possível.

---

## Correções no Sincronizador Delphi (da análise de 2026-05-31)

| # | Arquivo | Problema | Severidade |
|---|---------|----------|------------|
| C1 | `bank_account_send_web.pas` | Serializa `LcObj` (vazio) em vez de `FCtrl.Obj` — payload chega quase vazio | 🔴 |
| C2 | `general_web.pas` | Autenticação ausente (`LcAccessToKen` nunca inicializado) | 🔴 |
| C3 | `uMain.pas` | `TInvoiceReturnServiceSendWeb` comentada no `initialization` — NFS-e não sincroniza | 🔴 |
| C4 | `uMain.pas` | `RunScript` ignora o parâmetro e sempre roda SQL hardcoded | 🔴 |
| C5 | `ControllerColaborador.pas` | Celular enviado com valor do fone (`Registro.Fone` duplicado) | 🟡 |
| C6 | `customer/provider_send_web.pas` | Validação CPF/CNPJ comentada | 🟡 |
| C7 | `file_send_web.pas` | Conteúdo Base64 do XML comentado — só metadados chegam | 🟡 |
| C8 | Vários | ids fixos em 0, `active` fixo em 'S' (package), campos não mapeados | 🟡 |
| C9 | **NOVO (D4)** | Tratar o RESPONSE do POST: gravar `externalCode` (UUID) devolvido em `tb_empresa.externalCode`; hoje o Delphi só verifica HTTP 200 | 🔴 |
| C10 | **NOVO (D2)** | Incluir campo `DELETED` nos payloads + triggers/comportamento no Gestao2016 | 🔴 |
| C11 | **NOVO (D15)** | Remodelar os data objects Delphi (`Api/src/data_objetcs/`) para o contrato JSON novo, alinhado ao formato de gravação da setes-sync — endpoint a endpoint, na ordem D8 | 🔴 |
| C12 | **NOVO (D14)** | Automatizar a criação do campo `tb_empresa.externalCode` no Firebird (script de estrutura do Gestao2016) | 🔴 |

---

## Questões pendentes: **Nenhuma** ✅

> Q1–Q4/Q9 → D12–D16 (Rodada 1). Q5/Q6/Q8/Q10/Q11/Q12 → D17–D22 (Rodada 2). Q7/Q13 → D23–D24 (Rodada 3).
> Prompt fechado em 2026-07-19 com 24 decisões. Itens adiados estão em "Fora de escopo desta fase".

---

## Plano de implementação (ordem sugerida das ondas)

| Onda | O quê | Decisões |
|------|-------|----------|
| 0 | Inventário oficial: query na `TB_LISTA_SINCRONIA` de produção | D21 |
| 1 | Fundação setes-sync: auth por `tb_sync_api_key` (fim da chave global), remoção da fila em memória, aposentadoria dos `rest-*`, envelope de resposta `{ok, id, externalCode?, error?}` | D12, D19, D23, D14 |
| 2 | Cópia das peças da cadeia (setes-api → setes-sync) + motor de reindexação por CPF/CNPJ/UUID + `MAPA_INDEXACAO.md` + `CONTRATOS_SYNC` por endpoint | D13, D3, D4, D18, D22 |
| 3 | DDL: `tb_institution_has_brand/package/measure` (guardiao-conceitual + revisar-ddl) + endpoints dos cadastros centrais (prioridades 1–12 da D8) | D5, D17, D24 |
| 4 | Papéis de entidade: Customer/Provider/SalesMan (prioridades 13–15) + BankAccount revisado (16) | D3, D4, C1 |
| 5 | Movimento: Orders/Invoices/Stock/Financial (prioridades 17–25) | D8 |
| 6 | Retornos NF-e 55/65, NFS-e e arquivos XML em disco | D9, D20, C3, C7 |
| Delphi (paralelo) | `tb_empresa.externalCode` (C12), DELETED (C10/D2), auth (C2), response (C9), data objects alinhados (C11), bugs C1/C3–C8 | — |

> Soft delete (D2) atravessa todas as ondas: todo endpoint revisado já trata `deleted` no payload.

---

## Fora de escopo desta fase

- setes-api e setes-app: **nenhuma alteração** (D1).
- Módulo Software House no desktop (D10).
- Sentido inverso web → Firebird — "Sync Fase 2 — Recebimento" (D16).
- Cutover/migração definitiva de clientes.

## Critérios de sucesso (rascunho — fecham junto com as questões)

1. Sincronizador autentica por chave de cliente e a setes-sync resolve institution + schema (Q1).
2. Pacote de Customer/Provider/SalesMan com CNPJ já existente em outro cliente NÃO duplica entity (reindexação D3 provada por teste).
3. Pacote sem documento cria `tb_no_doc` + UUID, devolve `externalCode`, e o REENVIO do mesmo registro com o UUID não duplica (D4 provada por teste).
4. Registro com `DELETED=true` no payload inativa/soft-deleta no destino (D2).
5. Brand/Package/Measure deduplicados na central com vínculo por institution (D5).
6. Endpoints seguem a ordem de prioridade D8; cada endpoint revisado ganha teste de integração + Swagger.
7. Bug do BankAccount (C1) corrigido e provado com payload completo.
