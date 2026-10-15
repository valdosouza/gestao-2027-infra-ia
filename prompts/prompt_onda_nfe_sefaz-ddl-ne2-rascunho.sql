-- Escopo: setes
-- v1.1 (2026-10-15): Rodada 4 DECIDIDA (prompt §13.10 — D-NE102…D-NE114 = recomendacoes): G1…G11 do parecer viram D-NE105…D-NE114;
--      a alternativa (a) da Q-NE103 (tabela item->nItem) foi REJEITADA pela D-NE103 (derivacao, sem DDL) — fica no fim so como conhecimento negativo.
-- RASCUNHO v1 do DDL da FAMILIA NF-e (ramo `merchandise`, modelos 55/65) no banco `fiscal_api` — NE-0, entregavel E4
-- (prompt_onda_nfe_sefaz.md §13.2). NAO EXECUTAR: e insumo da NE-2 (vira a migration 001 da nfe-api, namespace proprio em
-- `_migrations (project, version)` — PADROES §11 regra 2; dono = a familia, D-F35). Passa de novo pelo revisar-ddl na NE-2.
-- Molde de FORMA: nfse-api 001..007 (tentativa x voz, life_event, projecao comum da 004 com COLLATE bin, dominios binarios 005/006).
-- Fatos oficiais: Infra-IA/nfe-api/integracoes/nfe-sefaz/ (README, CONFERENCIAS, AUTORIZADORES; PL_010f_v1.04 tiposBasico_v4.00:
-- TChNFe [0-9]{6}[0-9A-Z]{12}[0-9]{26} · TProt [0-9]{15}|[0-9]{17} · TRec [0-9]{15} · TStat [0-9]{3,4}).
--
-- O QUE NAO VIRA COLUNA (e onde vive):
--  * XML: `<chave>-nfe.xml` (candidato assinado, gravado IGUAL ao validado — D-NE43), `<chave>-procNFe.xml` (autorizada OU denegada —
--    D-NE35), `<chave>-evt110111-1.xml`, `<Id43>-inut.xml`, em `<cnpj>/<H|P>/<ano>/<mes>` (D-NE50). O XML e o snapshot do que o
--    documento DECLARA (emitente, IE, itens, totais, tpAmb): nada disso vira coluna.
--  * cNF, cDV e tpEmis: gravados POR CONSTRUCAO dentro da chave (posicoes 36-43, 44 e 35) — D-NE7/D-NE37. Coluna propria seria uma
--    2a fonte do mesmo fato (precisaria de regra para nao contradizer a chave = maquete).
--  * presenca de IE do emitente: declarada no XML (emit/IE presente ou ausente); a CONSEQUENCIA dela — o autorizador — e a coluna
--    (D-NE96 grava o autorizador). Ver G1 do parecer.
--  * serie e numero da nota: do ERP (D-F21/D-NE11) — estao na chave; nenhuma coluna de serie/numero/contador na familia.
--  * valores de imposto (ICMS, IBS/CBS...): conteudo do ERP (D-NE15/D-NE27) — na NF-e QUEM CALCULA e o emitente; uma tabela de
--    "valores do fisco" no molde da 007 da nfse-api seria MAQUETE (la o fisco calcula — Q-NE102 no parecer).
--  * teto de 2 MB do corpo HTTP (D-NE93): transporte, nao DDL.
-- Sem FK para o ERP (outro banco): tb_institution_id + tb_invoice_id + terminal = a nota em setes_<cliente> (D-F10/D-F15).
-- MariaDB 10.4 SEM modo estrito: dominio fechado = CHECK BINARIO conferido no boot pelo NOME (PADROES §11 regras 11 e 16); escritor
-- nunca INSERT IGNORE. CHECK com expressao NULL PASSA — por isso cada CHECK sobre coluna anulavel diz o caso NULL explicitamente.
-- RE-EXECUTAVEL: CREATE TABLE IF NOT EXISTS com as constraints no CREATE; CREATE OR REPLACE VIEW.

-- =============================================================================================================================
-- 1. TENTATIVA de autorizacao da NF-e (conceito B — uma declaracao do ramo de mercadoria de UMA vida da nota, apresentada ao fisco
--    com a chave que NOS cunhamos). N por vida; attempt continuo por nota, atravessa as vidas (molde da nfse-api 001).
--    Diferencas de FATO com a NFS-e: a chave e NOSSA e existe desde a reserva (D-NE7); "registro" = protocolo (D-NE56); nao ha DPS por
--    vida (quem numera e o ERP — D-F21), logo NAO ha tabela de vida nem JOIN na view.
--    Write-once (NULL -> valor UMA vez, pelo escritor da familia com `... WHERE col IS NULL`): receipt, protocol, dh_recbto.
--    Imutaveis desde o INSERT: access_key, life_event, environment, authorizer, dh_emission, digest_value.
-- =============================================================================================================================
CREATE TABLE IF NOT EXISTS `tb_invoice_merchandise_transmission` (
  `tb_institution_id` INT(11) NOT NULL COMMENT 'Estabelecimento = institution do produto (sem FK, outro banco — D-F10)',
  `tb_invoice_id`     INT(11) NOT NULL COMMENT 'Nota no schema do cliente (= pedido) — referencia sem FK',
  `terminal`          INT(11) NOT NULL DEFAULT 0 COMMENT 'Terminal da nota (D-NE12; 0 = web, so na borda)',
  `attempt`           INT(11) NOT NULL COMMENT 'Sequencia 1..N por nota; nova tentativa so com a anterior RESOLVIDA (D-NE7 — barreira blocksNewAttempt, D-NE56/D-NE61)',
  `life_event`        INT(11) NOT NULL COMMENT 'Evento E da nota que abriu a VIDA = identidade da declaracao (D-NE7, molde D-N27/D-F30)',
  `environment`       CHAR(1) NOT NULL COMMENT 'H/P CONGELADO da habilitacao 55/65 no envio (D-N6/D-F120)',
  `authorizer`        VARCHAR(6) NOT NULL COMMENT 'Autorizador CONGELADO = f(UF, modelo, ambiente, tpEmis, presenca de IE) — consulta, recibo e evento vao a ELE (D-NE37/D-NE96); lista = authorizers.ts (D-NE3)',
  `access_key`        VARCHAR(44) NOT NULL COMMENT 'Chave de acesso NOSSA, cunhada na reserva (cUF AAMM CNPJ mod serie nNF tpEmis cNF cDV) — cNF/cDV/tpEmis gravados nela (D-NE7/D-NE37)',
  `dh_emission`       DATETIME NOT NULL COMMENT 'dhEmi assinado (instante UTC — PADROES §10.3); a data FISCAL e derivada daqui pela view, nunca espelhada no cabecalho do ERP (D-NE21)',
  `digest_value`      VARCHAR(28) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'DigestValue (SHA-1, Base64) do infNFe do candidato assinado — prova do D-NE41 contra o digVal do protNFe (opcional no XSD); Base64 distingue caixa: colacao BINARIA na coluna (o _ci da tabela casaria digests diferentes)',
  `receipt`           VARCHAR(15) DEFAULT NULL COMMENT 'nRec do 103/105 (TRec) — write-once; saida do P pela consulta do recibo (D-NE33)',
  `protocol`          VARCHAR(17) DEFAULT NULL COMMENT 'nProt do protNFe da AUTORIZACAO ou da DENEGACAO (TProt 15 ou 17 — NT 2025.002 §5.1) — write-once; presenca = REGISTRO pelo fisco (D-NE56/D-NE61); o evento 110111 o exige (rej. 222)',
  `dh_recbto`         DATETIME DEFAULT NULL COMMENT 'dhRecbto do protNFe (instante UTC) — write-once; inicio do prazo de cancelamento por UF (teto do rodizio — D-NE26)',
  `last_queried_at`   DATETIME DEFAULT NULL COMMENT 'Ultima consulta a ESTA chave (rodizio/656: > 10 consultas da mesma chave/h bloqueiam — D-NE26/D-NE54); NULL = nunca',
  `tb_user_id`        INT(11) DEFAULT NULL,
  `created_at`        DATETIME DEFAULT NULL,
  `updated_at`        DATETIME DEFAULT NULL,
  `deleted`           CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`),
  -- a chave carrega o CNPJ: e unica no PAIS, nao so no estabelecimento. A UNIQUE e a guarda POR CONSTRUCAO da D-NE7 (cNF repetido
  -- na mesma nota/mes daria a MESMA chave a duas tentativas — a reserva falha e o cNF e sorteado de novo).
  UNIQUE KEY `uk_invoice_merchandise_transmission_key` (`access_key`),
  KEY `idx_invoice_merchandise_transmission_life` (`tb_institution_id`, `tb_invoice_id`, `terminal`, `life_event`),
  KEY `idx_invoice_merchandise_transmission_query` (`tb_institution_id`, `last_queried_at`),
  CONSTRAINT `ck_invoice_merchandise_transmission_environment`
    CHECK (`environment` COLLATE utf8mb4_bin IN ('H', 'P')),
  -- TChNFe do PL_010f (CNPJ alfanumerico — producao 01/07/2026) + mod da FAMILIA (55/65 = modelsOf('merchandise'); teste compara) +
  -- tpEmis 1 normal · 6 SVC-AN · 7 SVC-RS (contingencia fora da F4 — D-NE6 —, o tipo ja comporta). EPEC 4 / FS-DA 5 / off-line 9 (65) =
  -- migration que ESTENDE a lista. Binario: o REGEXP em colacao _ci aceitaria minuscula. DV modulo 11 = camada 1 da nfe-api (D-NE43).
  CONSTRAINT `ck_invoice_merchandise_transmission_key`
    CHECK (`access_key` COLLATE utf8mb4_bin REGEXP '^[0-9]{6}[0-9A-Z]{12}[0-9]{26}$'
           AND SUBSTRING(`access_key`, 21, 2) IN ('55', '65')
           AND SUBSTRING(`access_key`, 35, 1) IN ('1', '6', '7')),
  -- Lista do authorizers.ts (D-NE3; relacao de 15/10/2026 — AUTORIZADORES.md): 10 SEFAZ proprias + SVAN + SVRS + SVC-AN + SVC-RS.
  -- 'AN' fica FORA (nao autoriza NF-e; so eventos do AN — fora da F4). Comprimento + lista binaria (PADROES §11 regra 16 — 'PR ' em
  -- colacao PAD SPACE passaria no IN).
  CONSTRAINT `ck_invoice_merchandise_transmission_authorizer`
    CHECK ((CHAR_LENGTH(`authorizer`) = 2 AND `authorizer` COLLATE utf8mb4_bin IN ('AM', 'BA', 'GO', 'MG', 'MS', 'MT', 'PE', 'PR', 'RS', 'SP'))
        OR (CHAR_LENGTH(`authorizer`) = 4 AND `authorizer` COLLATE utf8mb4_bin IN ('SVAN', 'SVRS'))
        OR (CHAR_LENGTH(`authorizer`) = 6 AND `authorizer` COLLATE utf8mb4_bin IN ('SVC-AN', 'SVC-RS'))),
  CONSTRAINT `ck_invoice_merchandise_transmission_digest`
    CHECK (`digest_value` COLLATE utf8mb4_bin REGEXP '^[A-Za-z0-9+/]{27}=$'),
  CONSTRAINT `ck_invoice_merchandise_transmission_receipt`
    CHECK (`receipt` IS NULL OR `receipt` COLLATE utf8mb4_bin REGEXP '^[0-9]{15}$'),
  CONSTRAINT `ck_invoice_merchandise_transmission_protocol`
    CHECK (`protocol` IS NULL OR `protocol` COLLATE utf8mb4_bin REGEXP '^([0-9]{15}|[0-9]{17})$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================================================================
-- 2. VOZ da SEFAZ sobre a tentativa (conceito C — append-only; estado DERIVADO da ultima voz, nunca coluna). kind = NOSSA leitura,
--    da LISTA DE ESCRITA da familia (descritor `defineVoiceFamily` — `MERCHANDISE_VOICE_WRITE_KINDS` no repo da nfe-api, a MESMA
--    constante deste CHECK; teste compara — D-F105/D-F107/D-F108):
--      A autorizada (100/150; ou pousada pela consulta da chave depois de 204 — D-NE36) · R rejeitada (so com retorno legivel e cStat de
--      rejeicao — D-NE34) · D denegada (110/301/302/303 — FINAL e REGISTRADA: o escritor grava `protocol` na MESMA transacao — D-NE61) ·
--      P em processamento (103/105 com recibo — D-NE33; saida: consulta do recibo e, sem recibo util, consulta da CHAVE — G4) ·
--      C cancelada · K pedido de cancelamento em voo (fato NOSSO, dh NULL — PADROES §11 regra 9) · F falha explicita (conclusiva) ·
--      N pedido de cancelamento nao vigora (liberacao do K — D-N17/D-NE83).
--    S fica FORA (G3): "tentativa sem voz" ja e o "em voo" da familia; S teria de trazer a saida junto (D-F102/D-F105).
--    VOZ DO EVENTO (D-NE39): o 110111 e o unico evento da F4 e MUDA o estado do documento — a voz dele e o C/K/N desta tabela, com a
--    IDENTIDADE na linha: tpEvento em `authority_code` da voz C (a mesma semantica da D-F68 na NFS-e), chave pela tentativa (FK), nSeq = 1
--    (fixo para o cancelamento — MOC; CONFERENCIAS 29). O leitor confere tpEvento/chNFe/nSeqEvento do retEvento contra a pergunta antes de
--    gravar (D-NE42); decide o cStat do retEvento (135/136/155), nunca o 128; 573 = ja registrado (prova). Evento que NAO muda estado
--    (CC-e 110110, eventos RTC) e outra peca, quando entrar (§3.10 `_rectification`) — agrega, nao reforma (G2).
-- =============================================================================================================================
CREATE TABLE IF NOT EXISTS `tb_invoice_merchandise_transmission_event` (
  `tb_institution_id` INT(11) NOT NULL,
  `tb_invoice_id`     INT(11) NOT NULL,
  `terminal`          INT(11) NOT NULL DEFAULT 0,
  `attempt`           INT(11) NOT NULL,
  `event`             INT(11) NOT NULL COMMENT 'Sequencia 1..N por tentativa (MAX+1 sob a trava da nota — escritor unico do nucleo, D-F108/D-NE74)',
  `kind`              CHAR(1) NOT NULL COMMENT 'A · R · D · P · C · K · F · N (lista da familia — D-F107/D-F108)',
  `authority_code`    VARCHAR(10) DEFAULT NULL COMMENT 'A/R/D/P = cStat cru (3-4 digitos — NT 2025.002 §5.1) · C = tpEvento do cancelamento (110111), escrito uma vez (D-NE39; semantica da D-F68) · F/N = codigo da falha/recusa',
  `message`           VARCHAR(255) DEFAULT NULL COMMENT 'xMotivo (TMotivo 1-255)',
  `dh`                DATETIME DEFAULT NULL COMMENT 'Instante UTC do fisco: dhRecbto (A/R/D/P) ou dhRegEvento (C); NULL nos fatos NOSSOS K/N',
  `source`            CHAR(1) NOT NULL COMMENT 'P resposta direta · Q consulta (recibo ou chave) — a SEFAZ nao chama: sem W',
  `tb_user_id`        INT(11) DEFAULT NULL,
  `created_at`        DATETIME DEFAULT NULL,
  `updated_at`        DATETIME DEFAULT NULL,
  `deleted`           CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`, `event`),
  UNIQUE KEY `uk_invoice_merchandise_transmission_event_dh` (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`, `kind`, `dh`),
  CONSTRAINT `fk_invoice_merchandise_transmission_event_tx` FOREIGN KEY (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`)
    REFERENCES `tb_invoice_merchandise_transmission` (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`),
  CONSTRAINT `ck_invoice_merchandise_transmission_event_kind`
    CHECK (`kind` COLLATE utf8mb4_bin IN ('A', 'R', 'D', 'P', 'C', 'K', 'F', 'N')),
  CONSTRAINT `ck_invoice_merchandise_transmission_event_source`
    CHECK (`source` COLLATE utf8mb4_bin IN ('P', 'Q')),
  -- a voz que DECIDE carrega o cStat que decidiu, em 3-4 digitos (TStat do PL_010f — coluna/parser presos em 3 quebram).
  CONSTRAINT `ck_invoice_merchandise_transmission_event_status_code`
    CHECK (`kind` COLLATE utf8mb4_bin NOT IN ('A', 'R', 'D', 'P')
           OR (`authority_code` IS NOT NULL AND `authority_code` COLLATE utf8mb4_bin REGEXP '^[0-9]{3,4}$')),
  -- C nasce SEMPRE com o tipo do evento (familia nova, sem a forma anterior NULL da NFS-e); comprimento + lista binaria (regra 16).
  -- 110112 (cancelamento por substituicao da NFC-e) entra com a F5 — migration que estende a lista.
  CONSTRAINT `ck_invoice_merchandise_transmission_event_cancel_code`
    CHECK (`kind` COLLATE utf8mb4_bin <> 'C'
           OR (`authority_code` IS NOT NULL AND CHAR_LENGTH(`authority_code`) = 6 AND `authority_code` COLLATE utf8mb4_bin IN ('110111')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================================================================
-- 3. INUTILIZACAO de faixa (conceito F — ato sobre a NUMERACAO do emissor, nunca sobre uma nota; nao existe na NFS-e). Dono = a
--    familia (D-NE8); o setes-api LE a view ao cunhar numero (D-NE8/D-F21). Uma linha = um pedido apresentado com UMA resposta
--    definitiva (102 · 563 · rejeicao), write-once; a ambiguidade reenvia o MESMO Id na MESMA linha e o 563 traz o nProt do pedido
--    anterior (D-NE40 — nao existe consulta de inutilizacao; CONFERENCIAS 31/32). Rejeitada fica como HISTORIA; nova tentativa = nova
--    linha. Inutilizada = authority_code 102 ou 563 (o protocolo "se vier" — D-NE40). 256 (faixa sobreposta, sem nProt) e 201 (faixa
--    acima do limite) sao REJEICOES.
--    Chave natural da faixa (cUF, ano, CNPJ, mod, serie, nNFIni, nNFFin) = o proprio Id de 43 (D-NE40): guarda-se o Id; modelo,
--    serie e faixa saem DELE na view (colunas separadas seriam 2a fonte do mesmo fato).
--    UNIQUE da chave natural ENTRE AS LINHAS NAO REJEITADAS (`withdrawn_void_id`): uma faixa so pode estar "retirada da numeracao"
--    (pendente ou inutilizada) uma vez; a rejeitada nao bloqueia o novo pedido da mesma faixa (G5). id = MAX+1 por estabelecimento
--    sob a trava da habilitacao do modelo (PADROES §9 regra 7) — e a corrida com a cunhagem do ERP e a G6.
-- =============================================================================================================================
CREATE TABLE IF NOT EXISTS `tb_invoice_number_void` (
  `tb_institution_id` INT(11) NOT NULL,
  `id`                INT(11) NOT NULL COMMENT 'MAX+1 por estabelecimento (PADROES §9 regra 7)',
  `void_id`           VARCHAR(43) NOT NULL COMMENT 'Id do infInut = chave natural da faixa: ID cUF ano(2) CNPJ mod serie(3) nNFIni(9) nNFFin(9) (D-NE40)',
  `environment`       CHAR(1) NOT NULL COMMENT 'H/P CONGELADO da habilitacao no pedido (D-N6)',
  `authorizer`        VARCHAR(6) NOT NULL COMMENT 'Autorizador CONGELADO — o reenvio do mesmo Id vai a ELE (D-NE37/D-NE96); AC/BA/SP sem o servico a partir de 01/11/2026 = recusa local (a conferir no Ajuste SINIEF 40/26)',
  `reason`            VARCHAR(255) NOT NULL COMMENT 'xJust 15-255 (camada 1 — D-NE43); o reenvio do mesmo Id remonta o pedido IGUAL',
  `authority_code`    VARCHAR(10) DEFAULT NULL COMMENT 'cStat da resposta (102 · 563 · rejeicao) — write-once; NULL = pendente (enviado ou nao, sem resposta)',
  `message`           VARCHAR(255) DEFAULT NULL COMMENT 'xMotivo — write-once com a resposta',
  `protocol`          VARCHAR(17) DEFAULT NULL COMMENT 'nProt (102, ou o do pedido anterior no 563 — D-NE40) — write-once',
  `dh_recbto`         DATETIME DEFAULT NULL COMMENT 'dhRecbto da resposta (instante UTC) — write-once',
  `withdrawn_void_id` VARCHAR(43) GENERATED ALWAYS AS
                        (IF(`authority_code` IS NULL OR `authority_code` COLLATE utf8mb4_bin IN ('102', '563'), `void_id`, NULL)) STORED
                        COMMENT 'O Id enquanto a faixa esta RETIRADA da numeracao (pendente ou inutilizada); NULL = rejeitada (historia)',
  `tb_user_id`        INT(11) DEFAULT NULL,
  `created_at`        DATETIME DEFAULT NULL,
  `updated_at`        DATETIME DEFAULT NULL,
  `deleted`           CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `id`),
  UNIQUE KEY `uk_invoice_number_void_withdrawn` (`withdrawn_void_id`),
  CONSTRAINT `ck_invoice_number_void_environment`
    CHECK (`environment` COLLATE utf8mb4_bin IN ('H', 'P')),
  -- 2 + 4 (cUF, ano) + 12 + 2 (CNPJ alfanumerico — TCnpj do PL_010f) + mod da familia + 21 (serie 3, nNFIni 9, nNFFin 9) = 43;
  -- 1 <= nNFIni <= nNFFin (TNF comeca em 1). O limite de 10.000 (rej. 201) e a serie 0-889 do aplicativo com CNPJ (244/503) ficam na
  -- camada 1 (D-NE43). A conferir: o padrao do Id no XSD do inutNFe com CNPJ alfanumerico (pacote das mensagens de servico NAO arquivado).
  CONSTRAINT `ck_invoice_number_void_id`
    CHECK (`void_id` COLLATE utf8mb4_bin REGEXP '^ID[0-9]{4}[0-9A-Z]{12}[0-9]{2}(55|65)[0-9]{21}$'
           AND CAST(SUBSTRING(`void_id`, 26, 9) AS UNSIGNED) BETWEEN 1 AND CAST(SUBSTRING(`void_id`, 35, 9) AS UNSIGNED)),
  CONSTRAINT `ck_invoice_number_void_authorizer`
    CHECK ((CHAR_LENGTH(`authorizer`) = 2 AND `authorizer` COLLATE utf8mb4_bin IN ('AM', 'BA', 'GO', 'MG', 'MS', 'MT', 'PE', 'PR', 'RS', 'SP'))
        OR (CHAR_LENGTH(`authorizer`) = 4 AND `authorizer` COLLATE utf8mb4_bin IN ('SVAN', 'SVRS'))),
  -- a resposta e cStat de 3-4 digitos (o formato tambem torna EXATO o IN da coluna gerada: '102 ' nao chega a ser gravado)
  CONSTRAINT `ck_invoice_number_void_status_code`
    CHECK (`authority_code` IS NULL OR `authority_code` COLLATE utf8mb4_bin REGEXP '^[0-9]{3,4}$'),
  -- protocolo so com a inutilizacao homologada (102) ou a prova dela (563)
  CONSTRAINT `ck_invoice_number_void_protocol`
    CHECK (`protocol` IS NULL
           OR (`protocol` COLLATE utf8mb4_bin REGEXP '^([0-9]{15}|[0-9]{17})$'
               AND `authority_code` IS NOT NULL AND `authority_code` COLLATE utf8mb4_bin IN ('102', '563')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- (a SVC nao oferece inutilizacao — CONFERENCIAS 23 —, por isso o CHECK do autorizador da inutilizacao nao tem SVC-AN/SVC-RS)

-- =============================================================================================================================
-- 4. VIEWS publicadas para o setes-api (D-F15: SELECT SO nelas; GRANT em nfe-api/ops/grants.sql — molde da nfse-api). Fundiveis:
--    nenhuma subconsulta na LISTA, sem GROUP BY/DISTINCT/LIMIT; "ultima voz" no ON (PADROES §11 regra 3). Coluna derivada de LITERAL
--    leva COLLATE utf8mb4_bin (regra 3 — erro 1267 no leitor de outra colacao). Conferir EXPLAIN (PRIMARY, acesso por chave) e
--    `SET NAMES utf8mb4 COLLATE <x>` em >= 2 colacoes antes de publicar. A familia entra em VOICE_READINGS (`merchandise`) com a
--    conferencia de boot da view (D-F113/D-NE76) e sobe ANTES do setes-api que a le.
-- =============================================================================================================================

-- 4.1 Tentativas = PROJECAO COMUM (COMMON_TRANSMISSION_COLUMNS — mesmos nomes, tipos e significado da 004 da nfse-api) + o que e da
--     familia e TEM leitor no setes-api: so `dh_emission` (D-NE21 — data fiscal derivada). authorizer/receipt/protocol/dh_recbto/
--     digest_value ficam INTERNOS da nfe-api (a coluna entra na view com o 1o leitor — regra da D-IB78).
--     authority_recorded = PROTOCOLO presente (D-NE56): na NF-e a chave existe desde a reserva e NUNCA e sinal de registro. Toda voz
--     D/A/N/C/K publicada sai REGISTRADA (D-NE61/D-F136/D-F154 — o mapa comum recusa o contrario; teste da NE-2 confere na view).
CREATE OR REPLACE VIEW `vw_invoice_merchandise_transmission` AS
SELECT t.`tb_institution_id`, t.`tb_invoice_id`, t.`terminal`, t.`attempt`, t.`life_event`, t.`environment`,
       t.`access_key`,
       IF(t.`protocol` IS NULL, 'N', 'S') COLLATE utf8mb4_bin AS `authority_recorded`,
       t.`dh_emission`,
       t.`last_queried_at`, t.`created_at`,
       le.`event`          AS `last_event`,
       le.`kind`           AS `last_kind`,
       le.`authority_code` AS `last_code`,
       le.`message`        AS `last_message`,
       le.`source`         AS `last_source`,
       le.`dh`             AS `last_dh`,
       le.`created_at`     AS `last_event_at`
  FROM `tb_invoice_merchandise_transmission` t
  LEFT JOIN `tb_invoice_merchandise_transmission_event` le
    ON le.`tb_institution_id` = t.`tb_institution_id` AND le.`tb_invoice_id` = t.`tb_invoice_id`
   AND le.`terminal` = t.`terminal` AND le.`attempt` = t.`attempt` AND le.`deleted` = 'N'
   AND NOT EXISTS (SELECT 1 FROM `tb_invoice_merchandise_transmission_event` x
                    WHERE x.`tb_institution_id` = le.`tb_institution_id` AND x.`tb_invoice_id` = le.`tb_invoice_id`
                      AND x.`terminal` = le.`terminal` AND x.`attempt` = le.`attempt` AND x.`deleted` = 'N'
                      AND x.`event` > le.`event`)
 WHERE t.`deleted` = 'N';

-- 4.2 Vozes (forma comum `VoiceView` — a `voiceView` que o descritor de leitura exige; L5 da NE-1a: peca de leitura na NE-2).
CREATE OR REPLACE VIEW `vw_invoice_merchandise_transmission_event` AS
SELECT e.`tb_institution_id`, e.`tb_invoice_id`, e.`terminal`, e.`attempt`, e.`event`, e.`kind`,
       e.`authority_code`, e.`message`, e.`dh`, e.`source`, e.`tb_user_id`, e.`created_at`,
       t.`life_event`
  FROM `tb_invoice_merchandise_transmission_event` e
  JOIN `tb_invoice_merchandise_transmission` t
    ON t.`tb_institution_id` = e.`tb_institution_id` AND t.`tb_invoice_id` = e.`tb_invoice_id`
   AND t.`terminal` = e.`terminal` AND t.`attempt` = e.`attempt` AND t.`deleted` = 'N'
 WHERE e.`deleted` = 'N';

-- 4.3 Faixas RETIRADAS da numeracao (pendentes ou inutilizadas) — o que o setes-api le ao cunhar numero (D-NE8): por modelo e serie
--     da NOTA (a do ERP — D-F21; `serie` sai NUMERICA para nao depender do zero a esquerda do Id), MAX(number_to) no leitor.
--     authority_recorded = o fisco homologou a inutilizacao (102/563 — D-NE40); 'N' = pedido pendente (a faixa ja nao se usa — G6).
CREATE OR REPLACE VIEW `vw_invoice_number_void` AS
SELECT v.`tb_institution_id`, v.`id`,
       SUBSTRING(v.`void_id`, 21, 2) COLLATE utf8mb4_bin   AS `model`,
       CAST(SUBSTRING(v.`void_id`, 23, 3) AS UNSIGNED)     AS `serie`,
       CAST(SUBSTRING(v.`void_id`, 26, 9) AS UNSIGNED)     AS `number_from`,
       CAST(SUBSTRING(v.`void_id`, 35, 9) AS UNSIGNED)     AS `number_to`,
       v.`environment`,
       IF(v.`authority_code` IS NOT NULL AND v.`authority_code` IN ('102', '563'), 'S', 'N') COLLATE utf8mb4_bin AS `authority_recorded`,
       v.`created_at`
  FROM `tb_invoice_number_void` v
 WHERE v.`deleted` = 'N' AND v.`withdrawn_void_id` IS NOT NULL;

-- =============================================================================================================================
-- 5. Para a NE-2 (codigo, nao DDL):
--  * sondas do boot pelo NOME da constraint (regras 11/16), cada uma com PK propria numa transacao desfeita: kind 'S' e 'a';
--    source 'X' e 'q'; environment 'X' e 'h'; C com '110111 ' (espaco); A com '1000 0'; chave com minuscula e com tpEmis '2';
--    authorizer 'pr', 'PR ' e 'AN'; void_id com 'id' minusculo e faixa invertida; protocolo de 16 digitos.
--  * GRANT SELECT nas tres views ao usuario do setes-api; a nfe-api: controle total so no `fiscal_api` (D-F31).
--  * prova em banco descartavel: a coluna GERADA STORED com UNIQUE (MariaDB 10.4 e o MySQL 8 da F3); EXPLAIN das tres views.
--  * a familia declara `MERCHANDISE_VOICE_WRITE_KINDS` = A R D P C K F N (teste: = CHECK da secao 2) e o descritor com
--    eventTable `tb_invoice_merchandise_transmission_event` (regex do nucleo) e a convencao vw_<x> sobre tb_<x> (D-NE76).
-- =============================================================================================================================

-- -----------------------------------------------------------------------------------------------------------------------------
-- ALTERNATIVA (a) da Q-NE103 — REJEITADA pela D-NE103 (2026-10-15: derivacao por peca unica + conferencia no procNFe da origem, sem DDL).
-- Mantida comentada para comparacao: mostra o GRAO errado (por tentativa) que a opcao (a) exigiria.
-- CREATE TABLE IF NOT EXISTS `tb_invoice_merchandise_transmission_item` (
--   `tb_institution_id` INT(11) NOT NULL, `tb_invoice_id` INT(11) NOT NULL, `terminal` INT(11) NOT NULL DEFAULT 0,
--   `attempt` INT(11) NOT NULL, `item_number` SMALLINT NOT NULL COMMENT 'det/@nItem 1..990',
--   `tb_order_item_id` INT(11) NOT NULL, `tb_order_item_kind` VARCHAR(50) NOT NULL COMMENT 'item do ERP (sem FK — outro banco)',
--   `created_at` DATETIME DEFAULT NULL, `updated_at` DATETIME DEFAULT NULL, `deleted` CHAR(1) NOT NULL DEFAULT 'N',
--   PRIMARY KEY (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`, `item_number`),
--   UNIQUE KEY `uk_merchandise_transmission_item_erp` (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`, `tb_order_item_id`, `tb_order_item_kind`),
--   CONSTRAINT `fk_merchandise_transmission_item_tx` FOREIGN KEY (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`)
--     REFERENCES `tb_invoice_merchandise_transmission` (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`),
--   CONSTRAINT `ck_merchandise_transmission_item_number` CHECK (`item_number` BETWEEN 1 AND 990)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- -----------------------------------------------------------------------------------------------------------------------------
