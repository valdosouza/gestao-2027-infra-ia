# Prompt — Indexador Terminal (PDVs → web) + preservação da TB_SYNC_TABLE (retaguarda)

**Escopo**: setes
**Origem**: rascunho do Valdo (2026-07-26) + varredura de código (sincronizador, Gestao2016, setes-sync)
**Status**: FECHADO na Rodada 1 (2026-07-26) — 4 decisões; EXECUTADO no Sincronizador
**Pai**: revisão Sincronizador × setes-sync (D1–D24) + `prompt_construcao_banco_cliente.md` (bootstrap, 10 decisões — a decisão 1 é REVISADA aqui)

---

## Contexto

Clientes possuem terminais de checkout (PDV) com **Firebird próprio em cada terminal**:
terminal 0 = Servidor Local/Base única; terminais 1..N = PDVs. Todos precisam sincronizar
para o MESMO `setes_<schema>`, usando o número do terminal como dimensão do índice.

Na rede local existe a **RETAGUARDA** (Gestao2016): sincronia Servidor↔Terminais via fila
`TB_SINCRONIA` (triggers `TG_SRC_*`) + checkpoints. A revisão do bootstrap (2026-07-24)
mandou dropar a `TB_SYNC_TABLE` — **conflito**: ela é checkpoint vivo da retaguarda.

## Fatos verificados (varredura 2026-07-26 — não re-auditar)

### Lado web: JÁ PRONTO para terminal
- `terminal` é dimensão de PK: `tb_order (id, institution, terminal)`, `tb_cashier (id, institution, terminal)`,
  `tb_invoice (id, institution, terminal)`, `tb_financial (institution, order, terminal, parcel)` — dois
  terminais com o mesmo id local geram LINHAS DISTINTAS (sem sobrescrita).
- 10 endpoints recebem `terminal` no payload (cashier, financial, financial-statement, invoice,
  invoice-return*, order-purchase, order-sale, order-stock-adjust, stock-list, stock-statement);
  validações cruzadas já filtram por terminal.
- ⚠️ exceção conhecida (Rodada 4): `tb_stock_statement` tem PK física SÓ `id` AUTO_INCREMENT —
  colisão entre terminais/institutions dá erro de duplicate key (não sobrescreve, mas falha).

### Lado Sincronizador: o fio desligado
- TODAS as classes de movimento já enviam `terminal` no JSON... a partir de `FTerminal`,
  que **NUNCA é atribuído em runtime** (fica 0). `un_send_to_web_server.SyncTable` configura
  URL/ApiKey/EndPoint mas não o Terminal.
- A chave `SISWEB\TERMINAL` JÁ EXISTE no registro do Windows e na tela de config
  (`tas_config.pas:1202/1292`) — só não é lida no carregamento.
- O rascunho pedia "arquivo config"; a convenção da casa é o REGISTRO (SISWEB), onde a
  chave já está criada (⚠️ Q1).

### Lado Gestao2016: identidade do terminal e retaguarda
- O terminal do Gestão é `Gb_Terminal`, carregado do PARÂMETRO DE BANCO `GRL_G_TERMINAL`
  (`UN_Principal.pas:3490`), **default 1**. Não há X_Config nem uso do registro para isso.
- ⚠️ Conflito de convenção: rascunho diz 0=Servidor Local; `GRL_G_TERMINAL` default=1;
  comentário antigo do uMain do Sincronizador diz "0=servidor Web, 1=servidor Local" (⚠️ Q1).
- **RETAGUARDA**: fila `TB_SINCRONIA` (alimentada por triggers) + DOIS checkpoints:
  `TB_RETAGUARDA_SYNC` (caminho RetaguardaSync) e **`TB_SYNC_TABLE`** (caminho
  RetaguardaSendToLocal + `Un_Funcoes.updateTableSync` + `ControllerCtrlEstoque:874`).
  `TB_SYNC_TABLE (ID=nome tabela, WAY, KIND, DT/TM_UPDATE, OPERATOR)` = marca d'água, não fila.
- **O bootstrap atual do Sincronizador DROPA a TB_SYNC_TABLE a cada start**
  (`un_dm.pas:285-289`, chamada em `:499`) — numa base com retaguarda, destrói os
  checkpoints da sincronia local (re-baseline para 01/01/2016 no melhor caso).
- Retaguarda `Send` (terminal→servidor) está VAZIO (`ControllerRetaguardaSync.pas:105-108`) —
  os dados de venda do PDV NÃO chegam à base do servidor pela retaguarda; por isso a web
  precisa ler CADA base de terminal (objetivo deste prompt).

## Workflow alvo

1. **Instalação por terminal**: o Sincronizador roda (ou aponta) em cada base — servidor e PDVs.
   `BDPathBDLocal` → base do terminal; `TERMINAL` → número do terminal (⚠️ Q1 fonte/convenção);
   mesma `FApiKey`? (⚠️ Q2).
2. **Carregamento**: no start, o número do terminal é carregado (variável global do Sincronizador)
   e atribuído a cada classe de envio (`LcSendWeb.Terminal := <n>`) em `un_send_to_web_server`.
3. **Payload**: nada muda — as classes já montam `terminal` a partir de `FTerminal`.
4. **Web**: nada muda nos endpoints (dimensão já existe); pendência do stock_statement segue
   na Rodada 4.
5. **Perfil de classes por terminal**: PDVs enviam movimento; cadastros vêm do servidor (⚠️ Q3).
6. **TB_SYNC_TABLE**: o Sincronizador PARA de dropá-la (decisão 4 — reversão) e não a usa;
   a retaguarda continua dona dela.

## Questões pendentes

**Nenhuma** (Rodada 1, 2026-07-26 — decididas pelo Valdo, ver seção de decisões).

## Entregáveis EXECUTADOS (2026-07-26 — Sincronizador; aguarda compilação do Valdo)

| Entregável | Decisão | Onde |
|---|---|---|
| `DM.GbTerminal` carregado de `SISWEB\TERMINAL` no DataModuleCreate (antes do bootstrap) | 1 | `un_dm.pas` |
| `LcSendWeb.Terminal := DM.GbTerminal` no laço de envio — o campo `terminal` que TODAS as classes de movimento já montavam deixa de ser 0 fixo | 1 | `un_send_to_web_server.pas` (SyncTable) |
| Convenção canônica documentada (0=Servidor Local; 1..N=PDVs) — comentário antigo corrigido | 1 | `uMain.pas` |
| Perfil PDV: seed inicial com cadastros (Seq 1–16 e 38) `SET_ON='N'` quando `GbTerminal<>0` | 3 | `un_dm.pas` (SeedListaSincroniaIfEmpty) |
| `DropSyncTable` REMOVIDO (declaração + corpo + chamada) — TB_SYNC_TABLE intocada | 4 | `un_dm.pas` (EnsureSincronia) |
| Reversão registrada no prompt do bootstrap (objetivo 3) | 4 | `prompt_construcao_banco_cliente.md` |

setes-sync: NENHUMA mudança necessária (dimensão terminal já pronta — fatos acima).
API key: decisão 2 é operacional (mesma chave por estabelecimento) — sem código.

## Decisões arquiteturais registradas (Valdo, 2026-07-26 — Rodada 1)

1. **Fonte e convenção do terminal**: registro `SISWEB\TERMINAL` da instalação (chave/tela já
   existiam); convenção 0 = Servidor Local/Base única, 1..N = PDVs (alinha com o DEFAULT 0 do
   DDL web). O `GRL_G_TERMINAL` do Gestao2016 segue independente (uso interno do Gestão).
2. **API key por ESTABELECIMENTO**: a mesma chave em todos os terminais — ela resolve
   institution+schema; a origem é rastreável pelo `terminal` do payload.
3. **Perfil PDV = só MOVIMENTO**: em instalação com terminal ≠ 0, o seed nasce com os
   CADASTROS desligados (Seq 1–16 e 38 → SET_ON='N'); movimento (Seq 17–29) ativo. Cadastros
   chegam ao PDV pela retaguarda — reenviá-los seria redundante. Reativação manual possível.
4. **TB_SYNC_TABLE MANTIDA** — reversão da decisão 1 do bootstrap (2026-07-24): o
   `DropSyncTable` saiu do `EnsureSincronia` e do projeto; a tabela pertence à RETAGUARDA
   do Gestao2016 (checkpoint do caminho SendToLocal) e não pode ser tocada pelo Sincronizador.
   Recuperação para bases onde o drop JÁ rodou (dev): recriar pela DDL canônica
   (`Gestao2016\Scripts\Banco2022\CriarTodasAsTabelas.sql:3225-3233`) — os checkpoints
   re-baseiam em 01/01/2016 e a retaguarda se recupera reaplicando (idempotente).

## Fora de escopo

- Retaguarda `Send` vazio (terminal→servidor local) — problema do Gestao2016, não do sync web
- PK do `tb_stock_statement` (Rodada 4, já registrada)
- Sentido web→Firebird (D16)

## Critérios de sucesso (esboço)

1. Duas bases (terminal 0 e terminal 1) com `PED_CODIGO` iguais → duas linhas distintas em
   `tb_order` na web, cada uma com seu terminal
2. `SISWEB\TERMINAL` (ou fonte da Q1) carregado no start e presente em TODOS os payloads de movimento
3. Base com retaguarda ativa: bootstrap do Sincronizador roda SEM tocar na TB_SYNC_TABLE
4. PDV (perfil decisão 3): cadastros não são reenviados; movimento flui
5. Testes/smokes verdes nos dois lados
