# Roteiro de Implantação — Sincronizador por Cliente

**Escopo**: setes

> Origem: handoff da sessão claude.ai (celular) de 2026-07-25 — conversa "Acesso aos trabalhos no Claude desktop".

Aplicar em CADA instalação (Gestao2016 + Sincronizador local). Pré-requisitos globais (uma vez só, antes de qualquer cliente): setes-sync publicada e no ar com as Ondas 1–6; Sincronizador compilado com os patches (Onda 0, 02 e 03 já estão no código; 04 ainda pendente — NFS-e fica de fora até aplicar).

## Fase 0 — Preparação (antes de ir ao cliente)

- Criar a chave da instalação pela TELA (2026-07-26): cadastro de Estabelecimento no app
  (Super) → aba Estabelecimento → seção "Chave de Sincronização" → Gerar chave → Copiar
  (API: GET/POST `/api/institutions/:id/sync-api-key`; grava em `setes_central.tb_sync_api_key`) —
  uma chave POR estabelecimento; a tela só GERA quando não existe (trocar chave = intervenção
  manual no banco, de propósito)
- Confirmar a URL base da setes-sync (porta 3001) acessível a partir da rede do cliente
- Fazer backup/cópia do banco Firebird do cliente e validar o DDL na cópia primeiro (o script avisa: não testado em produção)

## Fase 1 — Banco Firebird do cliente (Gestao2016)

Rodar `patches-revisao-2026-07/01_firebird_ddl.sql`:

- `ALTER TABLE TB_EMPRESA ADD EXTERNALCODE VARCHAR(36)` + índice `IDX_EMPRESA_EXTERNALCODE`
- `ADD DELETED CHAR(1) DEFAULT 'N'` nas 23 tabelas sincronizadas (TB_MARCA_PRODUTO ... TB_CAIXA — lista completa no script)
- `UPDATE ... SET DELETED='N' WHERE DELETED IS NULL` em TODAS as 23 (Firebird legado não aplica default em linhas existentes) + COMMIT
- Conferir antes com `00_inventario_tb_lista_sincronia.sql` se o inventário real do cliente bate com a lista do DDL (clientes antigos podem ter divergência de schema)

## Fase 2 — Configuração do Sincronizador (registro do Windows, seção SISWEB)

- `FApiKey` = chave criada na Fase 0 (**a MESMA para todos os terminais do estabelecimento** — decisão 2 do indexador terminal)
- `FPathURL` = URL base da setes-sync (porta 3001)
- `TERMINAL` = número do terminal desta instalação (**0 = Servidor Local/Base única; 1..N = PDVs** — decisões 1 do `prompt_indexador_terminal_pdv.md`, 2026-07-26)
- Conferir intervalo / nominuto (ciclo de 5 min padrão)
- NÃO configurar mais institution no payload — a chave resolve institution + schema no servidor

### Clientes com PDVs (terminais de checkout com Firebird próprio)

- UMA instalação do Sincronizador POR BASE: servidor (`TERMINAL=0`) + cada PDV (`TERMINAL=N`,
  `BDPathBDLocal` apontando para a base do PDV)
- No PDV o seed nasce com **perfil de movimento** (decisão 3): cadastros Seq 1–16, 38 e 39
  SET_ON='N' (chegam ao PDV pela retaguarda); movimento Seq 17–29 ativo
- ⚠️ Autor no PDV (indexação de usuários, decisão 8 — 2026-07-26): EXTERNALCODE não é
  replicado pela retaguarda → movimentos do PDV só identificam o autor por CPF do
  colaborador; sem doc, a web usa o fallback (memória: revisar replicação da retaguarda)
- ⚠️ RETAGUARDA: o bootstrap NÃO toca mais na `TB_SYNC_TABLE` (decisão 4 — reversão do drop);
  se alguma base dev rodou o bootstrap antigo, recriar a tabela pela DDL de
  `Gestao2016\Scripts\Banco2022\CriarTodasAsTabelas.sql:3225-3233`

## Fase 3 — Primeiro start (bootstrap automático)

- Substituir o executável pelo build novo e iniciar
- O `EnsureSincronia` roda no DataModuleCreate: cria a TB_LISTA_SINCRONIA se não existir e semeia os 32 registros (Seq 38 = transportadora 2026-07-25; Seq 39 = usuário/autor 2026-07-26; as 7 linhas TB_REST_* foram REMOVIDAS do catálogo em 2026-07-26 — o bootstrap também as DELETA de bancos já semeados, Seqs 31–37 ficam reservados)
- Conferir: `SELECT COUNT(*) FROM TB_LISTA_SINCRONIA` → 32; só a Carta de Correção (Seq 30) fica SET_ON='N' (NFS-e nasce 'S' desde o patch 04; nenhuma linha TB_REST_* deve existir)
- DESC_TRIGGER fica NULL — preencher manualmente só se o motor exigir

## Fase 4 — Sincronização inicial (UMA entidade por vez, ordem D8)

### Primeira carga SELETIVA por período (decisão Valdo 2026-08-01)

O cliente pode não querer levar todo o histórico. Na tela de configuração
(aba Período da primeira carga: `ChBx_Periodo` + datas inicial/final), com o
período marcado, o "Colocar na Fila Sincronia" aplica filtro nas tabelas com
regra (`SqlFiltroPeriodoPrimeiraCarga` em tas_config.pas):

| Tabela | Regra |
|---|---|
**PRINCÍPIO (Valdo, 2026-08-04): "Enviar somente o que for do período" — padrão Fc_Usuario**
— a LISTA nasce no CONTROLLER da tabela: o `getList` honra `Periodo/DataInicial/DataFinal`
(do ControllerBase) com a query vinculada à NOTA do período (ou à própria data de
movimento); sem `Periodo`, devolve a query original (carga completa — callers antigos
intactos). A `Fc_*` do tas_config só instancia o controller, seta o período capturado,
itera a `Lista` chamando `Fc_InsertSicronia(tabela, campo, codigo)` e reporta via
InicioEtapa/FimEtapa. Na thread da carga, cada controller recebe `DataBase := FCargaDB`
(conexão própria — o DM segue livre para o ciclo de envio). As funções
`SqlPrimeiraCargaPeriodo` (abordagem anterior por WHERE) foram REMOVIDAS.

Molde do SQL (confirmado no código, `ControllerProduto.getList`): `TB_PEDIDO → tb_nota_fiscal
(NFL_CODPED=PED_CODIGO) → tb_itens_nfl (ITF_CODPED=PED_CODIGO) → TB_PRODUTO
(PRO_CODIGO=ITF_CODPRO) WHERE nfl_dt_emissao BETWEEN :ini AND :fim`. Nota AVULSA (`NFL_TIPO
='EM'`) não tem `TB_PEDIDO` e por isso não entra nesse molde de produto — ela é tratada à
parte, sem join de itens (`ControllerNotaFiscal.getList`, filtro direto `nfl_tipo='EM'`); o
que indexa `tb_order.id` na web continua sendo sempre `TB_NOTA_FISCAL.NFL_CODIGO`
([[notas-mercadoria-servico]]), independente de o funil de produto passar ou não pelo pedido.

**Realinhamento de tipo de registro (Valdo, 2026-08-09)** — nem toda tabela do funil deve
respeitar Período; cadastros de referência e catálogos pequenos vão SEMPRE completos,
mesmo com a aba Período marcada, para não gerar 409 `*_NOT_SYNCED` em cascata nem custo de
filtrar poucos registros:

- **catálogo pequeno, sempre completo**: `TB_CATEGORY`, `TB_EMBALAGEM`, `TB_MEDIDA`,
  `TB_MARCA_PRODUTO`, `TB_FORMAPAGTO` — deixaram de filtrar por produto movimentado
  (removida a query via `TB_PEDIDO→NF→ITENS_NFL→PRODUTO`; voltaram ao `SELECT *` simples)
- **ativo da empresa, sempre completo**: `TB_CLIENTE`, `TB_FORNECEDOR` — deixaram de filtrar
  por nota emitida no período (mesmo critério que já valia para transportadora/colaborador)
- **funil (respeita Período)**: `TB_NOTA_FISCAL` e os derivados diretos do produto
  MOVIMENTADO na nota — `TB_PRODUTO`/`TB_PRECO`/`TB_ESTOQUE`/`TB_TABELA_PRECO`/`TB_ESTOQUES` —
  e o financeiro vinculado à nota (`TB_FINANCEIRO`)

⚠️ Achado em aberto (2026-08-04, Pipoteca — "25 mil produtos na fila com banco zerado"):
a conversão Grupo/Subgrupo→Categoria do bootstrap regrava PRO_CODCAT de TODOS os
produtos e a TG_SRC_PRODUTO enfileira o catálogo inteiro, ignorando o período (uma
tentativa de "primeira carga substitui a fila" foi implementada e REVERTIDA a pedido
do Valdo — solução dele pendente). Regras vigentes:

| Tabela | Regra (no controller) |
|---|---|
| TB_NOTA_FISCAL | `NFL_DT_EMISSAO` dentro do período |
| TB_PRODUTO / TB_PRECO / TB_ESTOQUE | produto MOVIMENTADO no período (nota→pedido→itens do pedido — `NFL_CODPED=PED_CODIGO`, `ITF_CODPED=PED_CODIGO → ITF_CODPRO`) |
| TB_MARCA_PRODUTO / TB_EMBALAGEM / TB_MEDIDA / TB_CATEGORY / TB_FORMAPAGTO | ✔ 2026-08-09: catálogo pequeno — carga SEMPRE completa (Período não filtra) |
| TB_TABELA_PRECO / TB_ESTOQUES | ✔ 2026-08-04: tabela com preço de produto movimentado (`PRC_CODTPR`) / depósito com saldo de produto movimentado (`EST_CODETS`) |
| TB_CLIENTE / TB_FORNECEDOR | ✔ 2026-08-09: ativo da empresa — carga SEMPRE completa (Período não filtra) |
| TB_FINANCEIRO | parcela cuja NOTA vinculada é do período (`FIN_CODNFL = NFL_CODIGO`, não `NFL_CODPED`). Financeiro avulso (nulo/0) fica fora — já não grava na web (orderId obrigatório) |
| TB_RETORNO_NFE / NFC / NFS + TB_CARTA_CORRECAO | pela NOTA vinculada (`*_CODNFL`) |
| TB_ARQUIVOS (XMLs) | pela nota, por `ARQ_TIPO` (3/6 direto; 1 via retorno NF-e; 4 via NFC-e; 2 via carta; tipo fora desses fica fora — igual ao legado) |
| TB_MOVIM_FINANCEIRO / TB_CASHIER / TB_CTRL_ESTOQUE | pela PRÓPRIA data (`MVF_DATA` / `DT_RECORD` / `CET_DATA`) |
| Usuário, colaborador, transportadora, forma pagto, plano contas, conta bancária, promoção | carga COMPLETA de propósito — são REFERÊNCIA dos movimentos (autor, vendedor, carrier, billing, payment, extrato); filtrá-los causaria 409 `*_NOT_SYNCED` em cascata |

Ativar/testar nesta ordem, validando cada uma antes da próxima:

1. brand → 2. category → 3. measure → 4. package → 5. merchandise →
6. price-list → 7. price → 8. stock-list → 9. stock-balance →
10. promotion → 11. financial-plans → 12. payment-type →
12b. **carrier** (transportadora — ANTES do customer; revisão de entidades 2026-07-25) →
12c. salesman (idem — o customer referencia vendedor/transportadora por PAPEL) →
12d. **user** (usuário/autor — ANTES dos movimentos; indexação de usuários 2026-07-26;
     depois do salesman: a cascata reusa o EXTERNALCODE do colaborador) →
13. customer → 14. provider → 15. ~~salesman~~ (movido p/ 12c) → 16. bank-account →
17. order-sale → 18. order-purchase → 19. order-stock-adjust →
20. invoice → 21. invoice-merchandise → 22. stock-statement →
23. financial → 24. financial-statement → 25. cashier →
26. invoice-return-55 → 27. invoice-return-65 → 28. filexml

Validações por entidade:

- HTTP 200 com `{ok:true, id}` → registro marcado como enviado
- HTTP ≠ 200 → `{ok:false, error}` gravado em `TB_SINCRONIA.SRC_LOG`
- HTTP 409 `*_NOT_SYNCED` → dependência fora de ordem; o ciclo de 5 min reenvia sozinho (auto-cura) — não é erro de implantação
- Cadastro SEM CPF/CNPJ **ou com documento INVÁLIDO** (revisão de entidades: inválido = sem doc) → response traz `externalCode` → conferir gravação em `TB_EMPRESA.EXTERNALCODE` (ou `TB_COLABORADOR.EXTERNALCODE` no colaborador; `TB_USUARIO.EXTERNALCODE` no usuário) e REENVIAR o registro → não pode duplicar (teste obrigatório)
- Autor dos movimentos: pedido reenviado COM bloco `user` deve corrigir o `tb_user_id` gravado no fallback; conferir `tb_user` fantasma (password NULL, active='N') e vínculo `kind='SYNC'` na central
- XMLs (filexml): conferir chegada em disco no servidor, estrutura `<cnpj>/<ano>/<mes>/`

## Fase 5 — Encerramento

- Deixar o ciclo automático rodando e acompanhar 2–3 ciclos completos
- Revisar `TB_SINCRONIA.SRC_LOG` — zerar pendências ou justificar
- Registrar: cliente, data, chave criada, versão do executável

### Reenviar registros que FALHARAM (mecânica confirmada 2026-08-02)

Registro que falhou fica ESTACIONADO: o envio grava a mensagem de erro em
`TB_SINCRONIA.SRC_LOG` e as queries de envio só pegam `SRC_LOG` null/vazio —
NÃO há retry automático (a limpeza de 48h só remove `SRC_LOG='OK'`). Depois de
corrigir a causa (patch na web ou no Delphi), **NUNCA apague nada** — nem na
web (falha = transação com rollback, nada foi gravado; sucesso = upsert
last-write-wins, reenvio corrige em cima) nem no Firebird. Basta limpar a marca:

```sql
UPDATE TB_SINCRONIA
   SET SRC_LOG = NULL
 WHERE SRC_LOG IS NOT NULL
   AND SRC_LOG <> ''
   AND SRC_LOG <> 'OK';
```

O próximo ciclo reenvia tudo o que estava parado. Para forçar o reenvio
COMPLETO de uma classe (ex.: notas de serviço após recompilar com
`GetNfsNumero`), rebobinar o checkpoint — o catch-up cai na sentinela
01/01/2016 e reprocessa tudo (idempotente):

```sql
UPDATE TB_LISTA_SINCRONIA SET LAST_UPDATE = NULL
 WHERE DESC_TABELA = 'TB_NOTA_FISCAL' AND KIND = 'NOTA_SERVICO';
```

## Fora do escopo desta implantação

- ~~NFS-e (invoice-return-service): só após aplicar o patch 04~~ **Patch 04 APLICADO em
  2026-07-25** — NFS-e entra na Fase 4 como entidade 29 (após filexml), nasce SET_ON='S'
  no seed novo; bancos já semeados precisam do UPDATE manual (ver patch 04)
- Carta de Correção (invoice-rectification): aguarda a Rodada 4 (endpoint não existe) — SET_ON='N'
- Sentido web → Firebird (GetSincronize): fase própria (D16), não mexer
