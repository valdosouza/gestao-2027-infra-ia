# Frente CNPJ alfanumérico — INVENTÁRIO do código (Rodada 0, 2026-10-15)

**Escopo**: misto (o método de inventariar "onde o produto assume um formato" é portável; os pontos são do Gestão 2027)
**Origem**: agente de leitura (só leitura, nada rodado), conferido por amostragem pelo condutor. Anexo de `prompt_frente_cnpj_alfanumerico.md`.
**Recorte**: setes-api (`src`, `scripts` — main e4af7aa), setes-app (`apps/web/lib`, `packages/*/lib`, traduções e testes — main fbc2fac),
`fiscal-api/src`, `nfse-api/src` + `scripts`, `D:\Gestao2027\sql` e as migrations dos três serviços. **Fora (regra dos dois grupos)**: setes-sync
e sincronizador — são a OUTRA porta de escrita de `setes_central.tb_company.cnpj` e de `tb_sync_conflict.document`. nfe-api sem código (D-F20).
**Legenda do efeito**: RECUSA (barra com erro) · ESTRAGA (transforma o valor sem avisar; "latente" = hoje uma recusa barra antes) · OK · doc.

Caminhos curtos: `api` = `D:\Gestao2027\setes-api\src` · `app` = `D:\Gestao2027\setes-app` · `core` = `D:\Gestao2027\fiscal-api\src` ·
`nfse` = `D:\Gestao2027\nfse-api\src`.

## 1. setes-api

| # | arquivo:linha | o que faz | categoria | efeito |
|---|---|---|---|---|
| A1 | api/shared/validation/validators.ts:31-33 | `isValidCnpj` exige `^\d{14}$` (peça "fonte da verdade" do espelho Dart) | VALIDAÇÃO | RECUSA |
| A2 | api/shared/validation/validators.ts:34-47 | DV: repetidos `^(\d)\1{13}$`; `split('').map(Number)`; pesos 5..2/9..2 — sem ASCII−48 | DV | RECUSA |
| A3 | api/shared/validation/validators.ts:70-73 | `stripNonDigits` = `replace(/\D/g,'')` — `PC3D315K000193` → `3315000193` | NORMALIZAÇÃO | ESTRAGA (usada pela pesquisa, A14) |
| A4 | api/shared/validation/validators.ts:51-68 | `matchesMask`: `#` dígito, `A` letra — não há "dígito ou letra" | MÁSCARA | latente |
| A5 | api/shared/fiscal/fiscal.dto.ts:21 | `companyBody.cnpj` regex `^\d{14}$` ("14 dígitos numéricos") — o portão de TODOS os cadastros | VALIDAÇÃO | RECUSA (422) |
| A6 | api/shared/fiscal/fiscal.dto.ts:22 | `.refine(isValidCnpj)` (regra repetida na mesma peça) | DV | RECUSA |
| A7 | api/shared/entity/entity-fiscal.ts:85-89 | `entityFiscalBody` compõe `companyBody` — customers/carriers/collaborators/providers/institutions DTOs (5 portas) | VALIDAÇÃO | RECUSA |
| A8 | api/modules/entities/entities.controller.ts:7,21-24 | `GET /api/entities/by-document` (prefill) | VALIDAÇÃO | RECUSA (400) |
| A9 | api/modules/institutions/institutions.controller.ts:22-37 | `GET fiscal-exists` (sem consumidor no app) | VALIDAÇÃO | RECUSA (400) |
| A10 | api/shared/fiscal/fiscal.repository.ts:87-95 | `findEntityIdByCnpj`: `WHERE cnpj = ?` (colação `_ci`: `pc3d…` = `PC3D…`) | COMPARAÇÃO | OK |
| A11 | api/shared/entity/entity-fiscal.ts:182-213 | reuso da entity e 409 de documento duplicado pela A10 | COMPARAÇÃO | OK (herda a insensibilidade à caixa) |
| A12 | api/shared/fiscal/fiscal.repository.ts:35-43 | upsert grava o cnpj como veio (não normaliza a caixa) | ARMAZENAMENTO | OK |
| A13 | api/shared/entity/entity-search-criteria.ts:29-36 | critério "document" com `digits: true` (6 telas de papel) | NORMALIZAÇÃO | **ESTRAGA HOJE** (S1) |
| A14 | api/shared/list/search-criteria.ts:62-63,221-237 | `stripNonDigits` + "Informe só números" + `LIKE %…%` | NORMALIZAÇÃO | **ESTRAGA HOJE** (S1) |
| A15 | api/shared/bank-slip-registration/bank-slip-registration.ts:95-97 | pagador `.replace(/\D/g,'')`; só confere se ficou vazio | NORMALIZAÇÃO | ESTRAGA latente (S3) |
| A16 | api/shared/bank-channel/types.ts:51-53 | contrato `document: CPF/CNPJ só dígitos` | INTEGRAÇÃO | doc |
| A17 | api/shared/bank-channel/adapters/inter.ts:146-148 | `cpfCnpj` + `tipoPessoa` (Inter: string 11–18, sem pattern) | INTEGRAÇÃO | ESTRAGA latente (recebe A15) |
| A18 | api/shared/invoice/invoice-cancel-waiver.ts:46-81 | `access_key = ?` | COMPARAÇÃO | OK |
| A19 | api/modules/salesmen/salesmen.repository.ts:71 | `COALESCE(cpf,cnpj) AS document` | exibição | OK |
| A20 | api/modules/establishment/establishment.service.ts:37 | documento só leitura | exibição | OK |
| A21 | institutions.routes.ts:73-79 · entities.routes.ts:28-33 · institutions.controller.ts:26 · entities.controller.ts:7 · api/shared/errors/error-codes.ts:213,268,361-362 | Swagger e mensagens "14 dígitos / somente dígitos" | texto | doc |
| A22 | api/__tests__/validators.test.ts:24-35 | CNPJ válido só numérico | TESTE | fixa |
| A23 | api/__tests__/onda2-adversarial.test.ts:405-411 | "só dígitos chegam ao banco" | TESTE | fixa a mutilação da A15 |
| A24 | api/__tests__/search-criteria.test.ts:65-68 | "documento compara só dígitos" | TESTE | fixa a A14 |
| A25 | bank-slip-registration.test.ts:78 · onda2-gate-rework.test.ts:98 · onda2-adversarial.test.ts:104 | fixture `12.345.678/0001-99` | TESTE | fixa |
| A26 | entidade-unica.test.ts:34,53 · establishment.test.ts:40,182 · onboarding.test.ts:31 · bank-channel-inter-adapter.test.ts:86 | fixtures numéricos | TESTE | fixa |
| A27 | setes-api/scripts/smoke-pesquisa-avancada.ts:57-61 | máscara por posição; `cnpj <> '0'` | TESTE | assume dígitos |
| A28 | setes-api/scripts/trilha-primeiro-cliente.ts:618 | `accessKey.length === 50` | TESTE | OK |

Ponto de partida que MUDOU: `api/shared/fiscal-issuer/fiscal-issuer.ts` não existe mais (saiu na F2a — o equivalente é `core/secret/certificate.ts`);
`api/shared/tax-authority/` também saiu (o comentário de `core/errors/ambiguous-cause.ts:8` aponta um espelho que não existe).

## 2. setes-app

| # | arquivo:linha | o que faz | categoria | efeito |
|---|---|---|---|---|
| B1 | app/packages/setes_validators/lib/src/validators.dart:122-125 | `isValidCnpj` `^\d{14}$` (espelho da A1) | VALIDAÇÃO | RECUSA |
| B2 | validators.dart:127-139 | DV com `int.parse` por caractere | DV | RECUSA (letra lançaria `FormatException`) |
| B3 | validators.dart:64-68 | `SetesValidators.cnpj()` (sem uso em `lib/`) | VALIDAÇÃO | RECUSA |
| B4 | app/packages/setes_validators/lib/src/mask.dart:8-25 | `matchesMask` `#`/`A` | MÁSCARA | latente |
| B5 | mask.dart:33-70 | `SetesMaskFormatter` descarta letra em posição `#` | MÁSCARA | latente |
| B6 | mask.dart:28-29 | `unmask` mantém letras | NORMALIZAÇÃO | OK |
| B7 | app/apps/web/lib/app/shared/entity/widgets/entity_main_tab.dart:132-146 | `_validateCnpj`: `replaceAll(\D)` + tamanho 14 (só letras → "obrigatório") | VALIDAÇÃO | RECUSA |
| B8 | entity_main_tab.dart:152-162 | prefill só com `isValidCnpj(cnpjDigits)` | VALIDAÇÃO | RECUSA silenciosa |
| B9 | entity_main_tab.dart:375 | `keyboardType: TextInputType.number` (Android/web mobile sem letras) | TECLADO | RECUSA |
| B10 | app/apps/web/lib/app/shared/entity/domain/object_entity_fiscal.dart:65-69 | `cnpjDigits`; `toJson` → `'cnpj': cnpjDigits` | NORMALIZAÇÃO | ESTRAGA latente (S2) |
| B11–B15 | customer_page.dart:360-375 · carrier_page.dart:307-320 · collaborator_page.dart:307-320 · institution_page.dart:307-320 · provider_page.dart:306-319 | pendência `cnpjDigits.length != 14` (5 cópias) | VALIDAÇÃO | RECUSA |
| B16 | app/apps/web/lib/app/shared/entity/data/entity_by_document_datasource.dart:61-70 | `doc=` com `Uri.encodeComponent` | INTEGRAÇÃO | OK (a API recusa — A8) |
| B17 | app/packages/core/lib/src/shared/http/api_client.dart:207-214 | tira a query do log | log | OK |
| B18 | app/apps/web/assets/translations/pt.json:269 · en.json:269 (+ pt.json:132) | "CNPJ deve ter 14 dígitos" | texto | doc |
| B19–B21 | establishment_page.dart:465-475 · establishment_issuer_section.dart:317-318 + establishment_issuer_entity.dart:71-72,92 · salesman_page.dart:134,160-161 | exibição (o CNPJ do certificado fica `null` com A1 alfanumérico — C1) | exibição | OK |
| B22–B23 | setes_validators/test/validators_test.dart:20-28 · apps/web/test/establishment_issuer_*_test.dart | fixtures numéricos; nenhum teste cobre `cnpjDigits`, `_validateCnpj` nem B11–B15 | TESTE | fixa |

## 3. fiscal-api (núcleo)

| # | arquivo:linha | o que faz | categoria | efeito |
|---|---|---|---|---|
| C1 | core/secret/certificate.ts:23-24,27-36 | `cnpjFromSubject`: `:(\d{14})(?!\d)` no CN — e o perfil SE-S (DOC-ICP-04 v8.3) NEM traz o CNPJ no CN | CERTIFICADO | RECUSA (409 "sem CNPJ no CN") |
| C2 | certificate.ts:38-42,147-150 | `cpfFromSubject` `:(\d{11})(?!\d)` — CN `…:12345678000A35` lido como e-CPF | PF×PJ | RECUSA com diagnóstico errado |
| C3 | certificate.ts:137-142 | `expected.replace(/\D/g,'')` + tamanho 14 | NORMALIZAÇÃO | RECUSA (422 "Estabelecimento sem CNPJ") |
| C4 | certificate.ts:143-146 | `info.cnpj !== expected` (sensível à caixa) | COMPARAÇÃO | OK |
| C5 | core/erp/facts.ts:261,271-275 | `establishmentCnpj`: só dígitos + 14, senão `null` — alimenta upload do A1 e toda pasta fiscal | NORMALIZAÇÃO | RECUSA |
| C6 | facts.ts:212-229 | `entityFiscal` lê cnpj/cpf crus | leitura | OK |
| C7 | core/storage/fiscal-storage.ts:27,32-37 | `cnpjRoot`: só dígitos + 14, senão lança (com o CNPJ na mensagem) | STORAGE | RECUSA → vira estrago silencioso na nfse-api (S6) |
| C8 | fiscal-storage.ts:5-12,56-81 | layout `<raiz>/<cnpj>/[H/]<ano>/<mês>` (Windows ignora caixa; Linux não) | STORAGE | OK |
| C9 | core/emitter/emitter.ts:179-196 | upload com `expectedCnpj`; loga o cnpj | CERTIFICADO | RECUSA (herdada) |
| C10 | core/establishment/establishment.ts:133-147 · establishment.repository.ts:342-379 | grava o CNPJ lido do certificado | CERTIFICADO | OK |
| C11 | core/errors/ambiguous-cause.ts:1-9 | já trata CNPJ alfanumérico de TERCEIRO (D-F98); comentário :8 obsoleto | doc | OK |
| C12–C13 | core/transport/xmldsig.ts:43-46 · voice/families/service.ts:201-212 · reading.ts:33,75,171 | Id de assinatura `[A-Za-z0-9]+`; dpsId/accessKey como texto | CHAVE FISCAL | OK |
| C14–C16 | cofre.test.ts:14,73-74 · adversarial-r19-gate.test.ts:275-278 (`^\d{50}$`) · ne1a-emitter.test.ts:151 | fixtures numéricos | TESTE | fixa |

## 4. nfse-api

| # | arquivo:linha | o que faz | categoria | efeito |
|---|---|---|---|---|
| D1 | nfse/authority/dps-builder.ts:91-95 | `digits()` = `replace(/\D/g,'')` + tamanho opcional | NORMALIZAÇÃO | RECUSA com tamanho; ESTRAGA sem (D2) |
| D2 | dps-builder.ts:124-141 | `buildDpsId`: `digits(inscricao)` SEM tamanho + `padStart(14,'0')` | CHAVE FISCAL | ESTRAGA latente (S4) |
| D3 | dps-builder.ts:143-149 (:145) | `<prest><CNPJ>` com `digits(…,14)` (espelha o XSD `[0-9]{14}`) | VALIDAÇÃO | RECUSA |
| D4 | dps-builder.ts:151-153 | `<toma><CNPJ>/<CPF>` | VALIDAÇÃO | RECUSA |
| D5 | dps-builder.ts:253-256,263-278 | chave de 50, `PRE…` e `CNPJAutor` por `digits()` — cancelar NFS-e de chave alfanumérica é impossível | CHAVE FISCAL | RECUSA |
| D6 | dps-builder.ts:222-223 | `^DPS\d{42}$` | CHAVE FISCAL | RECUSA |
| D7 | dps-builder.ts:339-361,437-455 | leitura do XML (chave = Id sem "NFS", `chNFSe`) | CHAVE FISCAL | OK |
| D8 | nfse/facts/service-facts.ts:178,204-208 | `buildEmitter`: só dígitos + 14 ("Estabelecimento sem CNPJ") | NORMALIZAÇÃO | RECUSA (422) |
| D9 | service-facts.ts:180-188 | `emitterCnpj` (via C5) — bloqueia XML, DANFSe, tela e arquivo | NORMALIZAÇÃO | RECUSA |
| D10 | service-facts.ts:265-278 | `buildRecipient`: só dígitos; `length===14 ? {cnpj} : {cpf}` — **tomador PJ novo não recebe NFS-e** | PF×PJ | RECUSA (422) |
| D11 | nfse/authority/types.ts:30-33,47-50,116-117,124,130-132 | contratos "14 dígitos"/"50 dígitos" | doc | doc |
| D12 | nfse/authority/adn.ts:142-146 (+:225-233, :257-262) | `asAccessKey`: só dígitos + 50 — **chave alfanumérica autorizada vira 502 ambíguo ("nfse-sem-chave"): a NFS-e fica autorizada no fisco sem a voz A, tentativa em voo** | CHAVE FISCAL | **RECUSA GRAVE** |
| D13 | adn.ts:127-131 | `isGeneratedEventFor`: tira letras da chave do evento e compara | CHAVE FISCAL | RECUSA (cancelamento nunca reconhecido) |
| D14 | adn.ts:333-341 | `GET /dps`: busca `\b\d{50}\b` ("dps-fora-do-contrato") | CHAVE FISCAL | RECUSA |
| D15 | nfse/nfse/transmission.ts:1188-1194 | `sameIssuerKey` por posição | CHAVE FISCAL | OK |
| D16 | transmission.ts:1196-1206 | chave substituta `^[0-9A-Z]{50}$` — **INCOERENTE com D12** | CHAVE FISCAL | OK |
| D17 | transmission.ts:84-86 | nome do arquivo = chave sem letras | STORAGE | ESTRAGA latente (S5) |
| D18 | transmission.ts:167-170 | `serviceDpsId` chama D2 com `emitter.cnpj` | CHAVE FISCAL | ESTRAGA latente (S4) |
| D19 | transmission.ts:279-287,643-659,668-689 | falha ao gravar o XML fiscal só gera aviso no log | STORAGE | ESTRAGA latente silencioso (S6) |
| D20 | nfse/nfse/danfse.ts:32-38 | `fmtDoc`: só dígitos; máscara pelo comprimento (11 → CPF) | PF×PJ | ESTRAGA latente (S7) |
| D21–D22 | danfse.ts:44 (`fmtKey` só dígitos — cosmético) · danfse.ts:124-125 (lê CNPJ/CPF do XML — OK) | | | |
| D23 | nfse/modules/emitter/emitter.service.ts:46-49 | upload do A1 com `expectedCnpj` (C5) | CERTIFICADO | RECUSA |
| D24–D25 | nfse-api/scripts/migrate-from-setes-api.ts:146-147 (`^DPS\d{42}$`, script da virada já executado) · scripts/probe-query.ts:12 (`^\d{50}$`) | | CHAVE FISCAL | RECUSA |
| D26–D31 | authority.test.ts:51,63-69 · n17-paridade.test.ts:72,76 · ibscbs-ib3.test.ts:324,328 · adversarial-r18/r19/r20 (`ALNUM_CNPJ='12ABC34501DE35'` — só vazamento de terceiro) · adversarial-r15:324 · transmission.test.ts:66 e r11…r21 | fixtures numéricos | TESTE | fixa |

## 5. Banco

| tabela.coluna | tipo | colação | índice | comporta letra? |
|---|---|---|---|---|
| setes_central.tb_company.cnpj (`sql/01_setes_central_ddl.sql:106-120`) | char(14) NOT NULL DEFAULT '0' (sentinela '0') | não declarada — padrão do servidor (o central é utf8mb4_general_ci — `029_tax_rule_direction.sql:32`) | UNIQUE `cnpj` | sim |
| setes_central.tb_person.cpf (`:123-139`) | char(11) | idem | UNIQUE | n/a (CPF segue numérico) |
| setes_central.tb_sync_conflict.document (`:727-744`) | varchar(14) | idem | UNIQUE (inst, document, external_code) | sim (escritor = setes-sync) |
| setes_<cliente>.tb_order_item_ipi.producer_cnpj (`001_baseline.sql:1455`) | varchar(14) | general_ci | — | sim (sem escritor no setes-api) |
| setes_<cliente>.tb_invoice_service_transmission.dps_id / access_key (058 / `sql/03:515,525`) | VARCHAR(45)/(50) | unicode_ci | UNIQUE (inst, access_key) | sim (histórico depois da F2a) |
| setes_<cliente>.tb_invoice_cancel_waiver.access_key (067) | VARCHAR(50) + CHECK `^[0-9A-Z]{44}([0-9A-Z]{6})?$` | unicode_ci | PK | sim (sob `_ci` o CHECK aceita minúscula — PADROES §11 regra 11) |
| fiscal_api.tb_establishment_certificate.cnpj (`core 001:22-41`) | CHAR(14) | unicode_ci | — | sim |
| fiscal_api.tb_invoice_service_dps.dps_id (`nfse 001:24-38`) | VARCHAR(45) | unicode_ci | UNIQUE (inst, dps_id) | sim |
| fiscal_api.tb_invoice_service_transmission.access_key (`nfse 001:46-67`) | VARCHAR(50) | unicode_ci | UNIQUE (inst, access_key) | sim |

**Tipo: nenhuma coluna precisa mudar** (nenhuma numérica; comprimentos cabem; chave e Id mantêm o número de posições). **Colação: em aberto** —
hoje toda comparação/UNIQUE ignora a caixa (e, em general_ci, o acento); o DV oficial distingue caixa (ASCII − 48); CHECK de forma em coluna `_ci`
precisa de `COLLATE utf8mb4_bin`; `tb_company` é central e o setes-sync escreve nela.

## 6. Os que ESTRAGAM em silêncio

- **S1 — HOJE** (não depende de CNPJ com letra gravado): pesquisa avançada "Documento" nas 6 telas de papel (A3/A13/A14) — `PC3D315K` vira
  `LIKE '%315%'` (devolve qualquer CPF/CNPJ com "315" e o chip diz que filtrou); quando houver CNPJ com letra gravado, nada o encontra; só letras =
  "Informe só números". O teste A24 fixa isso.
- Latentes: **S2** corpo enviado pelo app mutilado (B10) · **S3** boleto no Inter com o pagador mutilado — com 3 letras sobram 11 dígitos: forma de CPF
  com tipo JURIDICA (A15/A17; teste A23 fixa) · **S4** Id do DPS com a inscrição errada, gravado uma vez e UNIQUE (D2/D18) · **S5** nome do arquivo
  fiscal sem letras (D17) · **S6** XML autorizado NÃO arquivado sem ninguém ver (C7 + D19; o aviso leva o CNPJ) · **S7** DANFSe com máscara de CPF (D20).
- **Diagnóstico enganoso**: "Estabelecimento sem CNPJ" (C3/C5/D8/D9); e-CNPJ lido como e-CPF (C2); "Tomador sem CPF/CNPJ válido" (D10); só letras
  → "campo obrigatório" (B7); **D12 — o pior: chave alfanumérica autorizada vira 502 ambíguo e a NFS-e fica autorizada no fisco sem a voz A**.
- **Incoerência que já existe**: D16 e o CHECK da 067 aceitam `[0-9A-Z]`; D1/D12/D13/D14/D17 tiram as letras.

## 7. Onde a regra se concentra × onde está duplicada

- **Peças que concentram**: `api/shared/validation/validators.ts` · `api/shared/fiscal/fiscal.dto.ts` (`companyBody` → 5 DTOs) ·
  `api/shared/fiscal/fiscal.repository.ts` (`findEntityIdByCnpj` — o único ponto de comparação) · `api/shared/list/search-criteria.ts` +
  `api/shared/entity/entity-search-criteria.ts` · `app/packages/setes_validators/lib/src/{validators,mask}.dart` · `object_entity_fiscal.dart` +
  `entity_main_tab.dart` (o campo dos 5 formulários) · `core/erp/facts.ts` (`establishmentCnpj`) · `core/secret/certificate.ts` ·
  `core/storage/fiscal-storage.ts` · `nfse/authority/dps-builder.ts` (`digits()`) · `nfse/facts/service-facts.ts`.
- **Duplicadas**: DV em 2 cópias (TS × Dart); regex `^\d{14}$` em A1, A5, B1 e o padrão do certificado (C1); "14 dígitos" por comprimento no app em 6
  cópias (B7 + B11–B15); `replace(/\D/g,'')`/`digitsOf` em ~13 cópias (validators.ts:72, bank-slip-registration.ts:95, facts.ts:261,
  fiscal-storage.ts:27, certificate.ts:137, service-facts.ts:178, dps-builder.ts:92, adn.ts:129 e :144, transmission.ts:85-86, danfse.ts:34,
  object_entity_fiscal.dart:66, entity_main_tab.dart:142); chave de 50 numérica em 4 pontos × 2 que já aceitam letra; PF × PJ pelo comprimento em
  service-facts.ts:271/:278, danfse.ts:35-36, certificate.ts:34/:40.

## 8. Contagem e o que NÃO foi verificado

110 linhas: setes-api 28 · setes-app 23 · fiscal-api 16 · nfse-api 31 · banco 12. RECUSA 38 · ESTRAGA 11 (1 cadeia HOJE — S1) · TESTE 18.
Não verificado: colação real e dados do banco vivo (já existe CNPJ com letra/minúscula vindo do setes-sync? máscara de CNPJ configurada em
`tb_institution_has_field`?); setes-sync e sincronizador; o leiaute oficial com letra (o XSD do acervo é numérico); comportamento em execução
(nada rodado); NF-e (sem código).
