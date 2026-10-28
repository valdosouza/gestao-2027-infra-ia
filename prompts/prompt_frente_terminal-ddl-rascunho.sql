-- =====================================================================
-- ⚠️ SUPERADO (2026-10-21, onda 0 — §10 do prompt): a forma DEFINITIVA é a migration
--   `setes-api/src/migrations/sql/074_terminal.sql` (worktree `D:\Gestao2027\terminal\setes-api`, branch `terminal`) e o
--   espelho `sql/03_schema_cliente_ddl.sql` — SEM a linha 0 e sem kind 'W' (D-TM16), com `active`, marcadores gerados
--   `live_marker`/`live_local_server` (molde da 071) e UNIQUE `uq_terminal_live_description`/`uq_terminal_local_server`
--   (A-TM2/D-TM10), `tb_terminal_holder`, índice `idx_order_terminal_counter` em tb_order e DROP guardado de tb_devices
--   (D-TM22). Este arquivo fica como HISTÓRIA da Rodada 0 (não apagar — regra dos docs superados).
-- =====================================================================
-- RASCUNHO v2 — NÃO APLICADO (frente tb_terminal, Rodada 0 de 2026-10-18)
-- Escopo: setes
-- Prompt: Infra-IA/prompts/prompt_frente_terminal.md (§4.1) — D-TM1…D-TM7 + parecer do guardião (§3)
-- Destino na execução: setes-api/src/migrations/sql/073_terminal.sql (número a CONFERIR de novo:
--   071/072 estão reservados pela worktree `merchandise`; há sessões paralelas).
-- Revisado pela skill database/skills/revisar-ddl.md (relatório no §4.1 do prompt); sintaxe conferida
--   com sqlglot (dialeto mysql). Forma RECOMENDADA — depende da Rodada 1:
--     * `kind` existe só com a Q-TM1 (a)          (sem ela: tirar a coluna e os CHECKs ck_terminal_kind/_web)
--     * `tb_terminal_holder` existe só com a Q-TM2 (a)  (sem ela: tirar a tabela inteira)
--     * o índice de tb_order existe só com a Q-TM4 (a)
-- =====================================================================
-- Conceito (guardião): um terminal = um ESPAÇO DE NUMERAÇÃO do movimento de um estabelecimento.
--   0 = a web (D-TM2), sempre presente, nunca excluída; >= 1 = cada base que sincroniza, número cunhado
--   PELA WEB (MAX+1 sobre TODAS as linhas — como nada se apaga (PADROES §3.1), o número nunca volta).
-- Schema do CLIENTE, escopo do ESTABELECIMENTO (PADROES §12 — a filial tem os seus terminais e a sua
--   linha 0). Sem FK das 55 tabelas de movimento para cá (D-TM6).
-- =====================================================================

CREATE TABLE IF NOT EXISTS `tb_terminal` (
  `tb_institution_id` int(11)      NOT NULL,
  -- 0 = web; >= 1 = MAX+1 da institution (lockInstitutionCounters antes — PADROES §9 regra 7);
  -- a PK (tb_institution_id, id) é o prefixo do MAX (regra 5) — por isso a ordem difere do costume (id, institution)
  `id`                int(11)      NOT NULL,
  `description`       varchar(50)  NOT NULL,
  -- W = web (só o 0) · L = servidor local (retaguarda) · P = PDV — perfil que a base herda pelo vínculo
  `kind`              char(1)      NOT NULL,
  `created_at`        datetime     DEFAULT NULL,
  `updated_at`        datetime     DEFAULT NULL,
  `deleted`           char(1)      NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `id`),
  CONSTRAINT `ck_terminal_id`        CHECK (`id` >= 0),
  CONSTRAINT `ck_terminal_kind`      CHECK (`kind` IN ('W', 'L', 'P')),
  CONSTRAINT `ck_terminal_web`       CHECK ((`id` = 0) = (`kind` = 'W')),
  CONSTRAINT `ck_terminal_web_alive` CHECK (`id` <> 0 OR `deleted` = 'N'),
  CONSTRAINT `ck_terminal_deleted`   CHECK (`deleted` IN ('S', 'N')),
  CONSTRAINT `fk_terminal_institution` FOREIGN KEY (`tb_institution_id`)
    REFERENCES `setes_central`.`tb_institution` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- O VÍNCULO "esta base responde por este terminal" — fato com produtor PRÓPRIO (o setes-sync, no ato de
-- vincular; o setes-api só LÊ). INSERT puro (o UNIQUE além da PK recusa alto — nunca ON DUPLICATE KEY
-- UPDATE: PADROES §9 regra 10); nenhuma rota escreve deleted='S' (base nova = terminal novo).
CREATE TABLE IF NOT EXISTS `tb_terminal_holder` (
  `tb_institution_id` int(11)   NOT NULL,
  `tb_terminal_id`    int(11)   NOT NULL,
  -- identidade da BASE (UUID_TO_CHAR(GEN_UUID()) do bootstrap do sincronizador, guardado DENTRO da base)
  `holder_uuid`       char(36)  NOT NULL,
  `created_at`        datetime  DEFAULT NULL,
  `updated_at`        datetime  DEFAULT NULL,
  `deleted`           char(1)   NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `tb_terminal_id`),
  UNIQUE KEY `uq_terminal_holder_uuid` (`tb_institution_id`, `holder_uuid`),
  CONSTRAINT `ck_terminal_holder_not_web` CHECK (`tb_terminal_id` > 0),
  CONSTRAINT `ck_terminal_holder_uuid`    CHECK (`holder_uuid` REGEXP '^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$'),
  CONSTRAINT `ck_terminal_holder_deleted` CHECK (`deleted` IN ('S', 'N')),
  CONSTRAINT `fk_terminal_holder_terminal` FOREIGN KEY (`tb_institution_id`, `tb_terminal_id`)
    REFERENCES `tb_terminal` (`tb_institution_id`, `id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Linha 0 "Web" das institutions que JÁ existem no schema (D-TM5: só o registro nasce — nenhum movimento
-- migra). Quem cria estabelecimento NOVO é a peça ensureWebTerminal no createInstitution (cobre os dois
-- atos da D-GE14 — o 2º não roda migration). INSERT … SELECT … WHERE NOT EXISTS (nunca INSERT IGNORE).
INSERT INTO `tb_terminal` (`tb_institution_id`, `id`, `description`, `kind`, `created_at`, `updated_at`, `deleted`)
SELECT i.`id`, 0, 'Web', 'W', NOW(), NOW(), 'N'
  FROM `setes_central`.`tb_institution` i
 WHERE i.`schema_name` = DATABASE()
   AND i.`deleted` = 'N'
   AND NOT EXISTS (SELECT 1 FROM `tb_terminal` t
                    WHERE t.`tb_institution_id` = i.`id` AND t.`id` = 0);

-- Q-TM4 (a): o MAX+1 do pedido da web passa a contar DENTRO do terminal 0 — índice cujo prefixo é o WHERE
-- (PADROES §9 regra 5; tb_order só tem a PK (id, tb_institution_id, terminal) hoje).
ALTER TABLE `tb_order`
  ADD KEY IF NOT EXISTS `idx_order_terminal_counter` (`tb_institution_id`, `terminal`, `id`);
