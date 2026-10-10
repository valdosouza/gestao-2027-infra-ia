-- Escopo: setes
-- RASCUNHO DE TRABALHO v2 da IB-1 (fase IBS/CBS) — NAO EXECUTAR ainda.
-- v2 (2026-10-10): aplica D-IB22..D-IB27 (Rodada 2, "siga as recomendacoes") + as 13 correcoes do
-- parecer do guardiao/revisar-ddl (prompt_fase_ibs_cbs.md §10.3) + o fato da IB-0: a tabela oficial
-- (IT 2025.002 v1.70 - cClassTrib.xlsx) traz dIniVig/dFimVig, ind_gTribRegular POR CLASSIFICACAO e a
-- aplicabilidade por documento (indNFSe/indNFe/indNFCe) como presenca.
-- Destino final: bloco A -> sql/01 (canonico) + script numerado sql/NN aplicado ANTES do setes-api;
-- bloco B -> sql/03 (canonico) + migration do setes-api (nº na execucao); bloco C -> migration 002 da nfse-api.
-- MariaDB 10.4 (dev) roda SEM modo estrito: CHECK e a guarda de dominio (D-IB26); carga nunca INSERT IGNORE.

-- =============================================================================
-- A. setes_central — REFERENCIAS (fato do mundo). Carga: rotina do Super a partir
--    do IT 2025.002 (xlsx) e do Anexo VII; API da Calculadora = conferencia
--    (divergencia entre as fontes = carga recusada inteira — D-IB23).
-- =============================================================================

-- A1. CST do IBS/CBS (familia de tb_tax_pis/_cofins). Flags de grupo do CST (ind_gRed,
--     ind_gDif...) sem consumidor no 1º release — entram por coluna quando houver.
CREATE TABLE IF NOT EXISTS `tb_tax_ibscbs` (
  `id`                 CHAR(3) NOT NULL COMMENT 'CST do IBS/CBS (ex.: 000)',
  `description`        VARCHAR(255) NOT NULL,
  `source_version`     VARCHAR(30) NOT NULL COMMENT 'Proveniencia: ex. IT 2025.002 v1.70',
  `created_at`         DATETIME DEFAULT NULL,
  `updated_at`         DATETIME DEFAULT NULL,
  `deleted`            CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  CONSTRAINT `ck_tax_ibscbs_id` CHECK (`id` REGEXP '^[0-9]{3}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- A2. IDENTIDADE do cClassTrib (D-IB22): o servico/regra presume o CODIGO, nao a versao.
--     CST = prefixo por construcao (E0959) — a regra "CST = prefixo" morre no CHECK.
CREATE TABLE IF NOT EXISTS `tb_tax_ibscbs_classification` (
  `code`               CHAR(6) NOT NULL COMMENT 'cClassTrib',
  `tb_tax_ibscbs_id`   CHAR(3) NOT NULL COMMENT 'CST = LEFT(code,3)',
  `created_at`         DATETIME DEFAULT NULL,
  `updated_at`         DATETIME DEFAULT NULL,
  `deleted`            CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`code`),
  KEY `idx_ibscbs_classification_cst` (`tb_tax_ibscbs_id`),
  CONSTRAINT `fk_ibscbs_classification_cst` FOREIGN KEY (`tb_tax_ibscbs_id`) REFERENCES `tb_tax_ibscbs` (`id`),
  CONSTRAINT `ck_ibscbs_classification_code` CHECK (`code` REGEXP '^[0-9]{6}$'),
  CONSTRAINT `ck_ibscbs_classification_cst` CHECK (`tb_tax_ibscbs_id` = LEFT(`code`, 3))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- A3. HISTORIA do cClassTrib (D-IB22/D-IB5): vigencia e a linha (dIniVig/dFimVig do IT).
--     Atributo corrigido sem dIniVig novo = UPDATE da mesma linha (source_* registram).
--     Linha nunca e apagada (nota antiga aponta codigo antigo).
CREATE TABLE IF NOT EXISTS `tb_tax_ibscbs_classification_validity` (
  `code`                       CHAR(6) NOT NULL,
  `valid_from`                 DATE NOT NULL COMMENT 'dIniVig',
  `valid_until`                DATE DEFAULT NULL COMMENT 'dFimVig; NULL = vigente',
  `name`                       VARCHAR(255) NOT NULL COMMENT 'Nome cClassTrib',
  `description`                VARCHAR(2000) NOT NULL COMMENT 'Descricao cClassTrib (max oficial 1.155)',
  `requires_regular_taxation`  CHAR(1) NOT NULL COMMENT 'ind_gTribRegular — classificacao que exige gTribRegular (o builder nao emite: 422 antes de faturar)',
  `source_version`             VARCHAR(30) NOT NULL COMMENT 'ex.: IT 2025.002 v1.70',
  `source_updated_at`          DATE NOT NULL COMMENT 'DataAtualizacao da linha oficial',
  `created_at`                 DATETIME DEFAULT NULL,
  `updated_at`                 DATETIME DEFAULT NULL,
  `deleted`                    CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`code`, `valid_from`),
  CONSTRAINT `fk_ibscbs_validity_classification` FOREIGN KEY (`code`) REFERENCES `tb_tax_ibscbs_classification` (`code`),
  CONSTRAINT `ck_ibscbs_validity_period` CHECK (`valid_until` IS NULL OR `valid_until` >= `valid_from`),
  CONSTRAINT `ck_ibscbs_validity_regular` CHECK (`requires_regular_taxation` IN ('S','N'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- A4. APLICABILIDADE por modelo de documento (presenca = aceita no documento; indNFSe/indNFe/indNFCe).
--     Modelo novo = linha nova. Carga so de SE agora; 55/65 entram como DADO na F4.
CREATE TABLE IF NOT EXISTS `tb_tax_ibscbs_classification_applicability` (
  `code`        CHAR(6) NOT NULL,
  `valid_from`  DATE NOT NULL,
  `model`       VARCHAR(2) NOT NULL COMMENT 'Dominio de tb_invoice.model: SE (NFS-e) · 55 · 65',
  `created_at`  DATETIME DEFAULT NULL,
  `updated_at`  DATETIME DEFAULT NULL,
  `deleted`     CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`code`, `valid_from`, `model`),
  CONSTRAINT `fk_ibscbs_applicability_validity` FOREIGN KEY (`code`, `valid_from`)
    REFERENCES `tb_tax_ibscbs_classification_validity` (`code`, `valid_from`),
  CONSTRAINT `ck_ibscbs_applicability_model` CHECK (`model` IN ('SE','55','65'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- A5. Indicador da operacao (cIndOp, Anexo VII — LC 214 art. 11). "operation" e palavra ocupada.
CREATE TABLE IF NOT EXISTS `tb_ibscbs_place_indicator` (
  `code`            CHAR(6) NOT NULL COMMENT 'cIndOp (ex.: 100301)',
  `description`     VARCHAR(1000) NOT NULL COMMENT 'Tipo de operacao + caracteristica + local do fornecimento (max oficial 535)',
  `source_version`  VARCHAR(30) NOT NULL COMMENT 'ex.: Anexo VII v1.03.00',
  `created_at`      DATETIME DEFAULT NULL,
  `updated_at`      DATETIME DEFAULT NULL,
  `deleted`         CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`code`),
  CONSTRAINT `ck_ibscbs_place_indicator_code` CHECK (`code` REGEXP '^[0-9]{6}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- A6. Aplicabilidade do cIndOp por modelo (indNFSe/indNFe do Anexo VII) — o lookup do servico so
--     oferece cIndOp aceito na NFS-e. Local de incidencia (NFSeLocIncidIBS) sem consumidor: fora.
CREATE TABLE IF NOT EXISTS `tb_ibscbs_place_indicator_applicability` (
  `code`        CHAR(6) NOT NULL,
  `model`       VARCHAR(2) NOT NULL,
  `created_at`  DATETIME DEFAULT NULL,
  `updated_at`  DATETIME DEFAULT NULL,
  `deleted`     CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`code`, `model`),
  CONSTRAINT `fk_place_indicator_applicability` FOREIGN KEY (`code`) REFERENCES `tb_ibscbs_place_indicator` (`code`),
  CONSTRAINT `ck_place_indicator_applicability_model` CHECK (`model` IN ('SE','55','65'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- A7. Nomenclatura Brasileira de Servicos (NBS 2.0, 9 digitos sem pontos; 920 codigos).
CREATE TABLE IF NOT EXISTS `tb_nbs` (
  `code`            CHAR(9) NOT NULL COMMENT 'NBS sem pontos (ex.: 115021000 = 1.1502.10.00)',
  `description`     VARCHAR(255) NOT NULL COMMENT 'max oficial 200',
  `source_version`  VARCHAR(30) NOT NULL,
  `created_at`      DATETIME DEFAULT NULL,
  `updated_at`      DATETIME DEFAULT NULL,
  `deleted`         CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`code`),
  CONSTRAINT `ck_nbs_code` CHECK (`code` REGEXP '^[0-9]{9}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- B. Schema do cliente — migration do setes-api (nº na execucao). D-IB6/D-IB7/D-IB9/D-IB25/D-IB26.
--    PRE-REQUISITO: bloco A aplicado em setes_central (checklist de deploy). O 1º comando
--    falha com erro LEGIVEL (1146 com o nome da tabela) se faltar — nunca errno 150.
--    PRE-CONDICAO do sync (chip): DELETE/REPLACE em tb_service/tb_invoice_service; simples_* em tb_entity_tax.
-- =============================================================================

-- B0. Confere a presenca das referencias centrais (erro legivel).
SELECT 1 FROM `setes_central`.`tb_nbs` LIMIT 0;
SELECT 1 FROM `setes_central`.`tb_tax_ibscbs_classification` LIMIT 0;
SELECT 1 FROM `setes_central`.`tb_ibscbs_place_indicator` LIMIT 0;

-- B1. Natureza do servico: NBS no servico (espelho do ncm da mercadoria). tb_service e unicode_ci.
ALTER TABLE `tb_service`
  ADD COLUMN IF NOT EXISTS `nbs` CHAR(9) DEFAULT NULL
    COMMENT 'NBS do servico (setes_central.tb_nbs.code) — cNBS do DPS'
    AFTER `tb_service_tax_rule_id`;
ALTER TABLE `tb_service`
  ADD CONSTRAINT `fk_service_nbs` FOREIGN KEY (`nbs`) REFERENCES `setes_central`.`tb_nbs` (`code`);

-- B2. Classificacao que o SERVICO presume (peca 1:1; presenca = "o servico esta classificado").
--     FK fisica ao CODIGO (D-IB22); a vigencia e conferida na peca pela data do fato.
CREATE TABLE IF NOT EXISTS `tb_service_ibscbs` (
  `id`                    INT(11) NOT NULL COMMENT 'tb_service.id',
  `tb_institution_id`     INT(11) NOT NULL,
  `classification_code`   CHAR(6) NOT NULL COMMENT 'cClassTrib escolhido (CST derivado)',
  `place_indicator_code`  CHAR(6) NOT NULL COMMENT 'cIndOp escolhido (Anexo VIII so sugere)',
  `tb_user_id`            INT(11) DEFAULT NULL,
  `created_at`            DATETIME DEFAULT NULL,
  `updated_at`            DATETIME DEFAULT NULL,
  `deleted`               CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`, `tb_institution_id`),
  CONSTRAINT `fk_service_ibscbs_service` FOREIGN KEY (`id`, `tb_institution_id`)
    REFERENCES `tb_service` (`id`, `tb_institution_id`),
  CONSTRAINT `fk_service_ibscbs_classification` FOREIGN KEY (`classification_code`)
    REFERENCES `setes_central`.`tb_tax_ibscbs_classification` (`code`),
  CONSTRAINT `fk_service_ibscbs_place` FOREIGN KEY (`place_indicator_code`)
    REFERENCES `setes_central`.`tb_ibscbs_place_indicator` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- B3. Enquadramento do EMITENTE vigente a partir de uma data (D-IB7), resolvido pela COMPETENCIA.
--     tax_regime (CRT) de tb_entity_tax FICA (serve ao destinatario); CRT do emitente e DERIVADO
--     (D-IB24 — tabela opSimpNac × regApTribSN → CRT confirmada com o contador).
CREATE TABLE IF NOT EXISTS `tb_establishment_tax_regime` (
  `tb_institution_id`   INT(11) NOT NULL,
  `valid_from`          DATE NOT NULL COMMENT 'Data de efeito (opcao/enquadramento perante a RFB)',
  `simples_regime`      CHAR(1) NOT NULL COMMENT 'opSimpNac: 1 nao optante · 2 MEI · 3 ME/EPP · 4 optante pendente (NT 009)',
  `simples_assessment`  CHAR(1) DEFAULT NULL COMMENT 'regApTribSN (so opSimpNac 3): 1 tudo pelo SN · 2 ISSQN por fora · 3 tudo por fora',
  `ibscbs_assessment`   CHAR(1) DEFAULT NULL COMMENT 'regApIBSCBSSN (NT 009): 1 IBS e CBS no SN · 2 so CBS no SN · 3 ambos regulares',
  `tb_user_id`          INT(11) DEFAULT NULL,
  `created_at`          DATETIME DEFAULT NULL,
  `updated_at`          DATETIME DEFAULT NULL,
  `deleted`             CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `valid_from`),
  CONSTRAINT `fk_establishment_tax_regime_institution` FOREIGN KEY (`tb_institution_id`)
    REFERENCES `setes_central`.`tb_institution` (`id`),
  CONSTRAINT `ck_tax_regime_simples` CHECK (`simples_regime` IN ('1','2','3','4')),
  CONSTRAINT `ck_tax_regime_assessment` CHECK (`simples_assessment` IS NULL
    OR (`simples_regime` = '3' AND `simples_assessment` IN ('1','2','3'))),
  CONSTRAINT `ck_tax_regime_ibscbs` CHECK (`ibscbs_assessment` IS NULL
    OR (`simples_regime` <> '1' AND `ibscbs_assessment` IN ('1','2','3')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- B3.1 Backfill (expand): uma linha por emitente que ja tem o regime em tb_entity_tax (id = institution).
--      valid_from = PISO DO HISTORICO (convencao nomeada na peca: "sem historico, o enquadramento
--      conhecido vale para o passado" — cancelamento/consulta de nota antiga tambem monta o emitente).
INSERT INTO `tb_establishment_tax_regime`
  (`tb_institution_id`, `valid_from`, `simples_regime`, `simples_assessment`, `ibscbs_assessment`, `created_at`, `updated_at`, `deleted`)
SELECT et.`tb_institution_id`, '2000-01-01', et.`simples_regime`, et.`simples_assessment`, NULL, NOW(), NOW(), 'N'
  FROM `tb_entity_tax` et
 WHERE et.`id` = et.`tb_institution_id` AND et.`simples_regime` IS NOT NULL AND et.`deleted` = 'N'
   AND NOT EXISTS (SELECT 1 FROM `tb_establishment_tax_regime` r WHERE r.`tb_institution_id` = et.`tb_institution_id`);

-- B4. Classificacao que a NFS-e DECLARA — congelada no ramo (D-IB9; CST e indDest derivados).
--     tb_invoice_service e general_ci (baseline); as colunas novas nascem unicode_ci POR COLUNA (D-IB25).
ALTER TABLE `tb_invoice_service`
  ADD COLUMN IF NOT EXISTS `classification_code` CHAR(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
    COMMENT 'cClassTrib congelado no faturamento (D-IB9)' AFTER `liability`,
  ADD COLUMN IF NOT EXISTS `place_indicator_code` CHAR(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
    COMMENT 'cIndOp congelado no faturamento (D-IB9)' AFTER `classification_code`,
  ADD COLUMN IF NOT EXISTS `nbs` CHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
    COMMENT 'NBS congelada no faturamento (cNBS do DPS)' AFTER `place_indicator_code`;

-- B5. Migrations SEPARADAS (nao entram na IB-1 base):
--   B5.1 DROP tb_taxes_id (tb_tax_rule e tb_service_tax_rule) — so apos a confirmacao do grupo do sync (D-IB4).
--   B5.2 CONTRACT: DROP tb_entity_tax.simples_regime/simples_assessment — so depois que os leitores
--        (fiscal-api/src/erp/facts.ts e a copia do dual-run no setes-api) lerem a peca por competencia;
--        a migration confere coluna = linha vigente e falha alto se divergir.
--   B5.3 Boot do setes-api confere que o motor APLICA CHECK (molde D-F45) — codigo, nao DDL (D-IB26).

-- =============================================================================
-- C. fiscal_api — migration 002 da nfse-api — VOZ do fisco (D-IB10), IB-3
-- =============================================================================

-- C1. Valores que o fisco calculou na NFS-e autorizada — 1:1 da tentativa onde a NFS-e pousou,
--     write-once (lidos do XML autorizado, infNFSe/IBSCBS do XSD 1.01). Presenca = o fisco devolveu
--     o grupo. NT 009 (gTribSN do Simples) entra por coluna na IB-5.
CREATE TABLE IF NOT EXISTS `tb_invoice_service_transmission_ibscbs` (
  `tb_institution_id`   INT(11) NOT NULL,
  `tb_invoice_id`       INT(11) NOT NULL,
  `terminal`            INT(11) NOT NULL DEFAULT 0,
  `attempt`             INT(11) NOT NULL,
  `incidence_city_ibge` CHAR(7) DEFAULT NULL COMMENT 'cLocalidadeIncid',
  `base_value`          DECIMAL(15,2) DEFAULT NULL COMMENT 'vBC',
  `ibs_state_aliquot`   DECIMAL(7,4) DEFAULT NULL COMMENT 'pIBSUF',
  `ibs_state_effective` DECIMAL(7,4) DEFAULT NULL COMMENT 'pAliqEfetUF',
  `ibs_city_aliquot`    DECIMAL(7,4) DEFAULT NULL COMMENT 'pIBSMun',
  `ibs_city_effective`  DECIMAL(7,4) DEFAULT NULL COMMENT 'pAliqEfetMun',
  `cbs_aliquot`         DECIMAL(7,4) DEFAULT NULL COMMENT 'pCBS',
  `cbs_effective`       DECIMAL(7,4) DEFAULT NULL COMMENT 'pAliqEfetCBS',
  `ibs_state_value`     DECIMAL(15,2) DEFAULT NULL COMMENT 'vIBSUF',
  `ibs_city_value`      DECIMAL(15,2) DEFAULT NULL COMMENT 'vIBSMun',
  `ibs_total_value`     DECIMAL(15,2) DEFAULT NULL COMMENT 'vIBSTot',
  `cbs_value`           DECIMAL(15,2) DEFAULT NULL COMMENT 'vCBS',
  `total_invoice_value` DECIMAL(15,2) DEFAULT NULL COMMENT 'vTotNF',
  `created_at`          DATETIME DEFAULT NULL,
  `updated_at`          DATETIME DEFAULT NULL,
  `deleted`             CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`),
  CONSTRAINT `fk_transmission_ibscbs_transmission` FOREIGN KEY (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`)
    REFERENCES `tb_invoice_service_transmission` (`tb_institution_id`, `tb_invoice_id`, `terminal`, `attempt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- C2. Contrato de leitura do setes-api (D-F15/D-IB10): VIEW publicada; GRANT em nfse-api/ops/grants.sql
--     (`GRANT SELECT ON fiscal_api.vw_invoice_service_transmission_ibscbs TO 'setes_api'@'%'`); EXPLAIN antes
--     de publicar (PADROES §11 regra 3).
CREATE OR REPLACE VIEW `vw_invoice_service_transmission_ibscbs` AS
SELECT v.`tb_institution_id`, v.`tb_invoice_id`, v.`terminal`, v.`attempt`,
       v.`incidence_city_ibge`, v.`base_value`,
       v.`ibs_state_aliquot`, v.`ibs_state_effective`, v.`ibs_city_aliquot`, v.`ibs_city_effective`,
       v.`cbs_aliquot`, v.`cbs_effective`,
       v.`ibs_state_value`, v.`ibs_city_value`, v.`ibs_total_value`, v.`cbs_value`, v.`total_invoice_value`,
       v.`created_at`
  FROM `tb_invoice_service_transmission_ibscbs` v
 WHERE v.`deleted` = 'N';
