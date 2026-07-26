# Prompt — Preparação do banco Firebird do cliente para o Sincronizador

**Escopo**: setes
**Origem**: rascunho `Infra-IA/prompts/ConstrucaoDoSincronizador.txt` (2026-07-24), refinado via
`Infra-IA/skills-genericas/refinar-prompt-arquitetura.md`
**Status**: ✅ IMPLEMENTADO (2026-07-24) — 7 entregáveis entregues; ver "Notas da implementação" no fim

---

## Contexto

Precisamos instalar o Sincronizador em cada cliente e preparar o banco Firebird local para
alimentar o envio de dados ao setes-sync — sem nenhum SQL manual. O fluxo comercial (decisão 8):
quando o cliente optar por espelhar os dados na internet, instala-se o Sincronizador (que prepara
o banco inteiro sozinho) e baixa-se a nova versão do desktop, já preparada para os controles
(soft delete etc.).

## Objetivos

1. Impedir que a sincronização comece antes do banco do cliente estar pronto (tabelas de controle
   + triggers criadas).
2. Automatizar 100% a preparação do banco na primeira execução em um cliente novo (bootstrap
   idempotente a cada start).
3. UM único lugar para o checkpoint de último envio: `TB_LISTA_SINCRONIA.LAST_UPDATE`
   (decisões 1 e 3) — `TB_SYNC_TABLE` é removida por completo do projeto.
   ⚠️ **REVISÃO 2026-07-26 (decisão 4 de `prompt_indexador_terminal_pdv.md`)**: a remoção
   do CÓDIGO permanece, mas o **`DROP TABLE TB_SYNC_TABLE` foi REVERTIDO** — a tabela é
   checkpoint vivo da RETAGUARDA do Gestao2016 (sincronia local Servidor×PDVs) e o
   Sincronizador NUNCA a toca. Bases dev onde o drop chegou a rodar: recriar pela DDL de
   `Gestao2016\Scripts\Banco2022\CriarTodasAsTabelas.sql:3225-3233` (checkpoints re-baseiam).
4. Soft delete universal: campo `DELETED CHAR(1) DEFAULT 'N'` em TODAS as tabelas do sistema
   (decisão 8), exceto `TB_SINCRONIA` e `TB_LISTA_SINCRONIA`.
5. Limpeza automática da fila `TB_SINCRONIA` (1x por dia — decisão 9).

## Workflow da instalação

1. Copiar o Sincronizador para uma pasta (normalmente a mesma do `Gestao.exe`)
2. Executar o Sincronizador
3. Configurar a conexão com o banco de dados
4. Ao conectar, o bootstrap roda sozinho (`EnsureSincronia` ampliado, em `DataModuleCreate`)
5. **A sincronização só é liberada depois que o bootstrap completa com sucesso**

## Bootstrap do banco (idempotente — roda a cada start, só age no que faltar)

Ordem de execução dentro do `EnsureSincronia` ampliado (`un_dm.pas`):

### Passo 1 — `TB_SINCRONIA` (fila de alterações) — criar se não existir

DDL autoritativa (decisão 2, fornecida pelo Valdo):

```sql
CREATE GENERATOR GN_SINCRONIA;

CREATE TABLE TB_SINCRONIA (
    SRC_CODIGO    INTEGER NOT NULL,
    SRC_TABELA    VARCHAR(30),
    SRC_CHAVE     VARCHAR(30),
    SRC_OPER      CHAR(1),
    SRC_TIME      TIMESTAMP,
    SRC_REGISTRO  INTEGER,
    SRC_LOG       VARCHAR(255)
);

ALTER TABLE TB_SINCRONIA ADD CONSTRAINT PK_TB_SINCRONIA PRIMARY KEY (SRC_CODIGO);

SET TERM ^ ;
CREATE OR ALTER TRIGGER TG_SINCRONIA FOR TB_SINCRONIA
ACTIVE BEFORE INSERT POSITION 0
AS BEGIN NEW.SRC_CODIGO = GEN_ID(GN_SINCRONIA, 1); END
^
SET TERM ; ^
```

Nota de implementação: no Delphi (IBSQL) cada statement roda separado — sem `SET TERM`. Checar
existência do generator via `RDB$GENERATORS` e da tabela via `RDB$RELATIONS` antes de criar.

### Passo 2 — Remoção da `TB_SYNC_TABLE` (decisão 1)

- `DROP TABLE TB_SYNC_TABLE` se existir no banco do cliente (o Valdo está reestruturando; a
  tabela nunca teve DDL oficial no repo).
- Remover do projeto Delphi: `origen/model/tblSyncTable.pas`, `origen/model/tblDskSyncTable.pas`,
  `origen/controller/ControllerSyncTable.pas`, o campo `SyncClient` em `ControllerSincronia.pas`
  e as referências nos 3 call-sites (`classes/general_web.pas::getLasUpdate`,
  `function/un_base_setes.pas::SetLastUpdate`, `origen/controller/
  ControllerRetaguardaSendToLocal.pas`) — todos passam a ler/gravar
  `TB_LISTA_SINCRONIA.LAST_UPDATE` via `ControllerListaSincronia`.

### Passo 3 — `TB_LISTA_SINCRONIA` + coluna nova `LAST_UPDATE` (decisão 3)

- `EnsureListaSincroniaTable` (já existe) ganha a coluna `LAST_UPDATE TIMESTAMP` no
  `CREATE TABLE`; para bancos já criados, `ALTER TABLE ... ADD LAST_UPDATE TIMESTAMP` se a coluna
  não existir (checar `RDB$RELATION_FIELDS`).
- `LAST_UPDATE` substitui `DT_UPDATE`/`TM_UPDATE` do rascunho — uma coluna única.
- Semântica: atualizada a cada registro enviado com sucesso (checkpoint por `WAY`+`DESC_TABELA`);
  é a referência para selecionar registros novos na `TB_SINCRONIA`. NULL = nunca sincronizou
  (envia tudo desde o início).
- Seed continua o de `un_sincronia_seed.pas` (37 linhas, `LAST_UPDATE` nasce NULL).

### Passo 4 — Rename `TTabelaParaSincronizar` → `TListaSincronia` (decisão 4)

- `origen/model/tblTabelaParaSincronizar.pas` → `tblListaSincronia.pas`; classe
  `TTabelaParaSincronizar` → `TListaSincronia`; ajustar todos os `uses`/referências
  (`ControllerListaSincronia.pas` e demais). Rename simples — o bootstrap procedural
  (`un_dm.pas`/`un_sincronia_seed.pas`) permanece como está.
- ⚠️ Conflito de nome: hoje `ControllerSincronia.pas` declara
  `TListaSincronia = TObjectList<TSincronia>` (alias interno). Esse alias deve ser renomeado
  (ex.: `TListaFilaSincronia`) para liberar o nome — o comentário no próprio
  `tblTabelaParaSincronizar.pas:10` já registrava esse conflito.

### Passo 5 — Soft delete universal: `DELETED` em TODAS as tabelas (decisão 8)

- Listar todas as tabelas de usuário do banco:
  `SELECT RDB$RELATION_NAME FROM RDB$RELATIONS WHERE RDB$SYSTEM_FLAG = 0 AND RDB$VIEW_BLR IS NULL`
- Para cada tabela SEM a coluna (checar `RDB$RELATION_FIELDS`):
  `ALTER TABLE <tabela> ADD DELETED CHAR(1) DEFAULT 'N'` seguido de
  `UPDATE <tabela> SET DELETED = 'N' WHERE DELETED IS NULL` (na 2.5 o DEFAULT não retroage aos
  registros existentes — o backfill garante valor uniforme; ver decisão 10)
- Exceções (não recebem o campo): `TB_SINCRONIA`, `TB_LISTA_SINCRONIA`
- NÃO é restrito às tabelas sincronizadas — é o sistema inteiro (o desktop novo fará soft delete
  em tudo; exclusão vira `UPDATE ... SET DELETED = 'S'`, que a trigger de UPDATE captura).
- O patch antigo `patches-revisao-2026-07/01_firebird_ddl.sql` (23 tabelas) fica SUPERADO por
  este passo (mantido só como histórico) — exceto a parte de `TB_EMPRESA.EXTERNALCODE`, que
  continua válida e deve ser incorporada ao bootstrap (checar/adicionar a coluna também).
- Destravar os TODOs: as 18 classes `*_send_web.pas` que mandam `'deleted':'N'` hardcoded passam
  a ler o campo real.

### Passo 6 — Triggers de captura `TG_SRC_*` (decisões 5, 6 e 7)

- Fonte de verdade: `TB_LISTA_SINCRONIA` (`WAY='E'`, `SET_ON='S'`), campos `DESC_TABELA` +
  `DESC_FIELD` (já populados no seed para todas as linhas ativas) — substitui a lista fixa de
  15 tabelas hardcoded em `un_dm.pas::ListTrigger`, que deve ser removida junto com o esqueleto
  comentado de `execTrigger`.
- **UMA trigger por tabela** (confirmado: Firebird 2.5 suporta multi-evento), SEM evento de
  DELETE (exclusão física não existe mais — decisão 6):

```sql
CREATE OR ALTER TRIGGER TG_SRC_<TABELA_SEM_PREFIXO> FOR <TABELA>
ACTIVE AFTER INSERT OR UPDATE POSITION 0
AS BEGIN
  IF (INSERTING) THEN
    INSERT INTO TB_SINCRONIA (SRC_CODIGO, SRC_TABELA, SRC_CHAVE, SRC_OPER, SRC_REGISTRO, SRC_TIME)
    VALUES (0, '<TABELA>', '<DESC_FIELD>', 'I', NEW.<DESC_FIELD>, CURRENT_TIMESTAMP);
  ELSE
    INSERT INTO TB_SINCRONIA (SRC_CODIGO, SRC_TABELA, SRC_CHAVE, SRC_OPER, SRC_REGISTRO, SRC_TIME)
    VALUES (0, '<TABELA>', '<DESC_FIELD>', 'U', OLD.<DESC_FIELD>, CURRENT_TIMESTAMP);
END
```

  (corpo derivado dos exemplos reais da decisão 7 — `SRC_CODIGO=0` é sobrescrito pela
  `TG_SINCRONIA` do passo 1; INSERT usa `NEW.`, UPDATE usa `OLD.`; nome `TG_SRC_EMPRESA` para
  `TB_EMPRESA` etc.)
- Após criar cada trigger, gravar o nome em `TB_LISTA_SINCRONIA.DESC_TRIGGER` (hoje sempre NULL).
- `CREATE OR ALTER` garante idempotência.

### Passo 7 — Liberação da sincronização

O loop de sincronia (`un_sincroniza.pas`) só inicia se o bootstrap terminou sem erro; em caso de
falha, mensagem clara no ListBox e sincronização bloqueada.

## Fluxo da sincronia (referência — já implementado)

1. Tabela X alterada (insert/update) → `TG_SRC_X` grava em `TB_SINCRONIA`
2. Sincronizador consulta `TB_LISTA_SINCRONIA` (`WAY='E'`, `SET_ON='S'`, `ORDER BY SEQ` — PK
   antes de FK)
3. Para cada tabela, consulta `TB_SINCRONIA` com `SRC_TIME > LAST_UPDATE`
4. Envia registro a registro via factory (`TGeneralSendFactory`)
5. Retorno atualiza `TB_SINCRONIA.SRC_LOG` (ok/erro) e `TB_LISTA_SINCRONIA.LAST_UPDATE` — se o
   loop cair no meio, retoma de onde parou

## Operações automáticas — limpeza da fila (decisão 9)

- Excluir de `TB_SINCRONIA`: `SRC_LOG = 'ok'` **e** `SRC_TIME` mais antigo que 48 horas.
- Frequência: **uma execução por dia** — o Sincronizador guarda a data da última limpeza (em
  memória/registro do Windows) e roda a rotina no primeiro ciclo de cada dia.

## Entregáveis

| # | Entregável | Onde |
|---|---|---|
| 1 | Bootstrap ampliado (`EnsureSincronia`: TB_SINCRONIA + generator/trigger, DROP TB_SYNC_TABLE, LAST_UPDATE, DELETED universal, EXTERNALCODE, triggers TG_SRC_*) | `function/un_dm.pas` |
| 2 | Remoção total da TB_SYNC_TABLE do projeto (3 units + call-sites migrados para LAST_UPDATE) | `origen/model`, `origen/controller`, `classes/general_web.pas`, `function/un_base_setes.pas` |
| 3 | Rename `TTabelaParaSincronizar`→`TListaSincronia` (+ resolução do alias conflitante) | `origen/model`, `origen/controller`, `ControllerSincronia.pas` |
| 4 | Checkpoint via `ControllerListaSincronia` (get/set `LAST_UPDATE` por WAY+DESC_TABELA) | `origen/controller/ControllerListaSincronia.pas` |
| 5 | Rotina diária de limpeza (48h) | `ControllerSincronia.pas` + chamada no loop |
| 6 | Gate "não sincroniza sem bootstrap ok" | `un_sincroniza.pas`/`uMain.pas` |
| 7 | 18 classes `*_send_web.pas` lendo `DELETED` real (fim do hardcoded) | `classes/*.pas` |

## Decisões arquiteturais registradas

1. **`TB_SYNC_TABLE` removida por completo** — tabela, models (`tblSyncTable.pas`,
   `tblDskSyncTable.pas`), controller e todas as referências. O checkpoint de último envio migra
   para `TB_LISTA_SINCRONIA.LAST_UPDATE`. (Valdo, 2026-07-24 — "remova TB_SYNC_TABLE e tudo que
   está relacionado, estou reestruturando")
2. **DDL autoritativa da `TB_SINCRONIA`** fornecida pelo Valdo: generator `GN_SINCRONIA` +
   trigger `TG_SINCRONIA` (BEFORE INSERT) para a PK `SRC_CODIGO`; campos `SRC_TABELA VARCHAR(30)`,
   `SRC_CHAVE VARCHAR(30)`, `SRC_OPER CHAR(1)`, `SRC_TIME TIMESTAMP`, `SRC_REGISTRO INTEGER`,
   `SRC_LOG VARCHAR(255)`.
3. **Checkpoint em coluna única `LAST_UPDATE TIMESTAMP`** na `TB_LISTA_SINCRONIA` (sem
   `DT_UPDATE`/`TM_UPDATE` separados).
4. **Rename `TTabelaParaSincronizar` → `TListaSincronia`** (unit `tblListaSincronia.pas`), rename
   simples sem unificar o bootstrap procedural; o alias `TListaSincronia` que hoje existe em
   `ControllerSincronia.pas` é renomeado para liberar o nome.
5. **Triggers geradas a partir de `TB_LISTA_SINCRONIA`** (`DESC_TABELA`+`DESC_FIELD`, linhas
   `WAY='E'` e `SET_ON='S'`) — fim da lista hardcoded de 15 tabelas em `un_dm.pas`.
6. **Sem trigger de DELETE** — exclusão física deixa de existir (soft delete universal); UMA
   trigger multi-evento `TG_SRC_<TABELA>` por tabela (`AFTER INSERT OR UPDATE`), já que o
   Firebird 2.5 suporta — preferência expressa do Valdo ("se puder criar uma trigger que dispare
   qualquer uma das alterações").
7. **Corpo da trigger** derivado dos exemplos reais fornecidos: INSERT grava `NEW.<chave>` com
   `SRC_OPER='I'`; UPDATE grava `OLD.<chave>` com `SRC_OPER='U'`; `SRC_CODIGO=0` (a
   `TG_SINCRONIA` gera o valor real); `CURRENT_TIMESTAMP` em `SRC_TIME`.
8. **`DELETED CHAR(1) DEFAULT 'N'` em TODAS as tabelas do sistema** (não só as sincronizadas),
   exceto `TB_SINCRONIA` e `TB_LISTA_SINCRONIA` — via varredura de `RDB$RELATIONS` no bootstrap.
   Fluxo comercial: instalar Sincronizador → preparação total do banco → baixar desktop novo já
   preparado. Supera o patch manual `01_firebird_ddl.sql` (exceto `EXTERNALCODE`, incorporado ao
   bootstrap).
9. **Limpeza da fila 1x por dia**: `DELETE FROM TB_SINCRONIA WHERE SRC_LOG='ok' AND SRC_TIME <
   (agora - 48h)`, disparada pelo Sincronizador no primeiro ciclo de cada dia.
10. **Compatibilidade Firebird 2.5 ↔ 5.0** (Valdo, 2026-07-24): todo DDL gerado pelo bootstrap usa
    apenas sintaxe válida nas DUAS versões — a 5.0 fará parte da atualização futura. Regras:
    - Triggers multi-evento `ACTIVE AFTER INSERT OR UPDATE POSITION 0` com
      `IF (INSERTING)` — suportado de 1.5 até 5.0 ✅
    - `CREATE OR ALTER TRIGGER` — suportado de 2.0 até 5.0 ✅
    - Geração de PK via `GEN_ID(GN_SINCRONIA, 1)` em trigger BEFORE INSERT — funciona em ambas;
      **NÃO usar** `IDENTITY` (só existe a partir da 3.0) nem `NEXT VALUE FOR` dentro do corpo
      criado (existe desde 2.0, mas GEN_ID é o padrão do legado — manter um só estilo)
    - `CREATE GENERATOR` — aceito em ambas (na 5.0 é alias legado de `CREATE SEQUENCE`); a
      checagem de existência via `RDB$GENERATORS` funciona igual nas duas
    - Checagens de metadados (`RDB$RELATIONS` com `RDB$SYSTEM_FLAG = 0 AND RDB$VIEW_BLR IS NULL`,
      `RDB$RELATION_FIELDS`) — estáveis entre 2.5 e 5.0; comparar `RDB$SYSTEM_FLAG` como número
      (não boolean) e sempre com `TRIM/UPPER` no nome
    - **PROIBIDO** no DDL do bootstrap: `IDENTITY`, `BOOLEAN` (só 3.0+), `DDL triggers`, pacotes,
      funções nativas exclusivas da 3.0+ — nada que quebre na 2.5
    - `DEFAULT 'N'` em `ALTER TABLE ... ADD DELETED CHAR(1) DEFAULT 'N'` — comportamento igual
      nas duas versões (registros existentes ficam NULL na 2.5; o bootstrap complementa com
      `UPDATE <tabela> SET DELETED = 'N' WHERE DELETED IS NULL` para garantir o valor inicial
      uniforme nas duas versões)

## Questões pendentes

Nenhuma.

## Fora de escopo desta fase

- Sentido `WAY='R'` (web→Firebird) — fase própria (D16 da revisão do sincronizador)
- Módulo restaurante — linhas do seed permanecem `SET_ON='N'` (aposentado)
- A nova versão do desktop (Gestão) que passa a fazer soft delete em vez de DELETE físico — frente
  do Valdo, fora do repositório do Sincronizador

## Notas da implementação (2026-07-24)

- **Bootstrap** em `un_dm.pas`: `EnsureSincronia` = `EnsureSincroniaTable` (TB_SINCRONIA +
  GN_SINCRONIA + TG_SINCRONIA) → `DropSyncTable` → `EnsureListaSincroniaTable` (+`LAST_UPDATE`
  via `ALTER` em bancos antigos) → `SeedListaSincroniaIfEmpty` → `EnsureDeletedColumns` (varre
  `RDB$RELATIONS`, com backfill) → `EnsureExternalCode` (TB_EMPRESA, VARCHAR(36)+índice) →
  `EnsureTriggers`. Flag público `DM.BootstrapOk` (gate). Helpers novos: `CampoExiste`,
  `GeneratorExiste`, `GetDeletedFlag`.
- **Triggers**: nome `TG_SRC_<TABELA sem TB_>` truncado a 31 chars (limite de identificador do
  Firebird), `AFTER INSERT OR UPDATE` com `IF (INSERTING)`; nome gravado em `DESC_TRIGGER`.
  Tabelas do catálogo ainda inexistentes no banco são puladas (Continue).
- **Removidos do projeto**: `tblSyncTable.pas`, `tblDskSyncTable.pas`, `ControllerSyncTable.pas`,
  `un_terminal_to_web.pas` (unit morta, sem nenhuma referência, toda construída sobre
  TB_SYNC_TABLE com sentidos W/D), `execTrigger`/`ListTrigger` (un_dm), `execTableSincronia`/
  `execTrigger` (uMain), `getLasUpdate` (general_web — não tinha chamador).
- **Rename**: `tblListaSincronia.pas`/`TListaSincronia` substitui `tblTabelaParaSincronizar.pas`/
  `TTabelaParaSincronizar`; o alias antigo `TListaSincronia` de `ControllerSincronia.pas` virou
  `TListaFilaSincronia`.
- **Checkpoint**: `TControllerListaSincronia.GetLastUpdate/SetLastUpdate(way, tabela, kind)` +
  `SetLastUpdateAll(way)`; granularidade = PK do catálogo (KIND incluído — mais fino do que o
  texto da decisão 3, que citava só WAY+DESC_TABELA, porque TB_PEDIDO tem 3 linhas com KINDs
  distintos e o chamador `un_base_setes.SetLastUpdate` sempre teve o parâmetro pTipo).
  `VerificaModoSincronia` (ajuste manual de data na tela) usa `SetLastUpdateAll` mapeando o
  radio antigo W/D/A → E/R/ambos.
- **Gate**: em `TPrincipal.ExecutaSincronia` (único funil — botão Sincronizar e os 2 timers
  passam por ele; Sb_Enviar/Sb_Receber não têm OnClick).
- **Limpeza diária**: `TControllerSincronia.DeleteProcessadosAntigos`
  (`UPPER(SRC_LOG)='OK' AND SRC_TIME < DATEADD(-48 HOUR TO CURRENT_TIMESTAMP)`) chamada por
  `TPrincipal.ExecutaLimpezaDiaria` (1x por dia por sessão; `DATEADD` ok em 2.5 e 5.0).
- **MnuPreparaLocal** continua existindo como preparação manual, mas agora delega ao mesmo
  `DM.EnsureSincronia` (removidos os passos redundantes).
- **Extras pós-prompt (2026-07-24, pedidos do Valdo)**: (a) bandeja corrigida — ocultar agora
  esconde também o botão da barra de tarefas (`SW_HIDE` na janela da Application) e duplo-clique
  no ícone RESTAURA em vez de fechar; (b) **parada graciosa no fechamento** — fechar durante uma
  sincronia seta `TBaseSetes.PararSolicitado` (class var), os loops de envio/recebimento checam
  entre registros (o atual conclui com checkpoint/SRC_LOG gravados) e o app fecha sozinho no
  `FinalizarSincronia`; fechar sem sincronia ativa segue o fluxo normal com confirmação; (c) fix
  de compilação em `un_receive_from_web_server.pas` (corpo `Receive` sem declaração → `send`).
- `ControllerPDV`/`ControllerRetaguarda`/`ControllerRetaguardaWeb` ainda geram triggers no
  padrão ANTIGO (3 por tabela, com DELETE, listas hardcoded em `ControllerTrigger.pas`) — são
  fluxos de preparação de retaguarda local fora do escopo deste prompt; ninguém os chama no
  fluxo de sincronia web. Candidatos a revisão quando o sentido R for implementado (D16).

## Critérios de sucesso

1. Rodar o Sincronizador pela primeira vez num Firebird de cliente sem NENHUM preparo e, sem SQL
   manual, o banco termina com: `TB_SINCRONIA` + `GN_SINCRONIA` + `TG_SINCRONIA`,
   `TB_LISTA_SINCRONIA` populada (com `LAST_UPDATE`), `DELETED` em todas as tabelas de usuário
   (menos as 2 de controle), `EXTERNALCODE` em `TB_EMPRESA`, e uma trigger `TG_SRC_*` por tabela
   ativa (nome gravado em `DESC_TRIGGER`)
2. Sincronização bloqueada até o bootstrap completar sem erro
3. Bootstrap reexecutado em banco já preparado: nenhuma alteração, nenhum erro (idempotente)
4. Nenhuma referência a `TB_SYNC_TABLE`/`TSyncTable`/`TControllerSyncTable` sobrando no projeto
   (grep limpo) e o projeto compila
5. Interromper o envio no meio do loop e reiniciar retoma do `LAST_UPDATE` correto (sem reenviar
   tudo, sem pular registros)
6. Um INSERT e um UPDATE manuais numa tabela monitorada geram exatamente 1 linha cada em
   `TB_SINCRONIA` com `SRC_OPER` 'I'/'U' corretos
7. Registros `SRC_LOG='ok'` com mais de 48h somem na primeira limpeza diária
