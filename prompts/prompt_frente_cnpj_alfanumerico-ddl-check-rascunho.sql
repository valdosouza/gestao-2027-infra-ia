-- =====================================================================================================================================
-- RASCUNHO (NÃO é migration — NÃO aplicar) · Frente do CNPJ alfanumérico · D-CJ4 (= Q-CJ4 (c)) / D-CJ5
-- Escopo: setes
-- Origem: prompt_frente_cnpj_alfanumerico.md §4.3, §6.1 e §8.8 (Valdo 2026-10-16: "abro a tarefa do sync; CHECK depois").
--
-- O CHECK BINÁRIO DE FORMA é o CONTRATO entre os dois grupos (setes-api grava pelo cadastro; o setes-sync também grava
-- setes_central.tb_company.cnpj): só vira migration DEPOIS que o grupo do sync confirmar que grava a forma canônica (tarefa separada
-- aberta em 2026-10-16). Quando virar: migration do setes-api para o central e para os schemas de cliente + migration do núcleo para o
-- fiscal_api, cada CHECK conferido no BOOT pelo NOME (PADROES_BANCO §5 + §11 regras 11/16) — sonda que falha alto se o CHECK sumir.
--
-- PROVADO em schema descartável no MariaDB 10.4.20 do dev em 2026-10-16 (`cnpj_check_probe_20261016`, criado e APAGADO na mesma execução):
--   * ADD CONSTRAINT VALIDA as linhas existentes: com uma linha fora da forma o DDL FALHA (errno 4025, "CONSTRAINT … failed") — a auditoria
--     (anexo §8.1: 249/249 na forma, zero '0') é pré-condição REAL, não formalidade; rodar a auditoria de novo no dia.
--   * Depois do CHECK: 'PC3D315K000193' entra; minúscula, máscara e letra no DV são RECUSADAS; duplicata em caixa diferente cai na UNIQUE
--     `_ci` (ER_DUP_ENTRY) — com só [0-9A-Z] na coluna a UNIQUE `_ci` fica exata por construção.
--   * SEM `COLLATE utf8mb4_bin` o REGEXP numa coluna `_ci` ACEITA minúscula (o defeito do CHECK da 067) — com o COLLATE, recusa.
--   * CONHECIMENTO NEGATIVO: o driver `mysql2` rotula o errno 4025 do MariaDB como `ER_INNODB_AUTOEXTEND_SIZE_OUT_OF_RANGE` (tabela de
--     nomes do MySQL) — quem tratar a violação do CHECK confere `errno === 4025`, NUNCA o `code` textual.
-- =====================================================================================================================================

-- 1) Central — a inscrição federal da pessoa jurídica (D-CJ4) com o sentinela '0' tolerado até a revisão do DEFAULT pelo grupo do sync (D-CJ5)
ALTER TABLE setes_central.tb_company
  ADD CONSTRAINT ck_company_cnpj_form
  CHECK (cnpj COLLATE utf8mb4_bin REGEXP '^[0-9A-Z]{12}[0-9]{2}$' OR cnpj = '0');

-- 2) fiscal_api — o CNPJ lido do certificado A1 (coluna NULLABLE: certificado sem CNPJ lido fica NULL)
ALTER TABLE fiscal_api.tb_establishment_certificate
  ADD CONSTRAINT ck_establishment_certificate_cnpj_form
  CHECK (cnpj IS NULL OR cnpj COLLATE utf8mb4_bin REGEXP '^[0-9A-Z]{12}[0-9]{2}$');

-- 3) Cada schema de cliente (setes_<cliente>) — o CHECK da 067 ganha o COLLATE binário (PADROES §11 regra 11; anterior à regra)
--    hoje: `access_key` regexp '^[0-9A-Z]{44}([0-9A-Z]{6})?$'  (aceita minúscula — provado)
ALTER TABLE `setes_<cliente>`.tb_invoice_cancel_waiver
  DROP CONSTRAINT ck_invoice_cancel_waiver_access_key,
  ADD CONSTRAINT ck_invoice_cancel_waiver_access_key
  CHECK (access_key COLLATE utf8mb4_bin REGEXP '^[0-9A-Z]{44}([0-9A-Z]{6})?$');
