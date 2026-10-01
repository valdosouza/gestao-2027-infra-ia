# Onda 3 — NFS-e pelo Padrão Nacional (ADN / Sefin Nacional)

**Escopo**: misto (habilitação do emissor, transmissão do DPS e voz do fisco são método portável — o
mesmo molde da Onda 2; Setes, Curitiba e o certificado A1 da empresa são conteúdo `setes`)
**Fase-mãe**: `prompt_primeiro_cliente_setes.md` (D1 emissão pelo ambiente nacional com A1, nunca
webservice municipal · achado A2 ramo de serviço vazio · D33 ordem Inter → NFS-e → Produção)
**Molde**: `prompt_onda2_banco_inter.md` §3 (dono × apresentação × voz do terceiro) e §10 (lições dos gates)
**Aberto em**: 2026-09-20 (Rodada 0 = levantamento + parecer do guardião conceitual, agente `setes-conceito`,
enquanto o sandbox do Inter está fechado — janela seg–sex 8h–20h)
**Estado**: **EM EXECUÇÃO — 1ª sessão em PRODUÇÃO (2026-09-29, §13: Q-N35 (b) + Q-N36 executada — regApTribSN obrigatório p/ ME/EPP)** · antes: retrabalho dos gates (2026-09-28): §10.3 (10 achados adversariais R1 corrigidos) ·
§10.4 (socrático 0.67 → D-N26…D-N30 executadas, migration 061) · §10.5 (adversarial R2 0.64 → R2-1…R2-5 corrigidos) ·
**§10.6 re-score FINAL: socrático 0.74 ✅ · adversarial R3 0.58 → 7 corrigidos + D-N31 (um A1 por estabelecimento) + rótulo Homologação** · suíte 1363/1363 · trilha 21 OK · 3 PENDENTE · 0 FALHA (P8b = código municipal da regra de ISS) · NADA commitado. Rodada 1 DECIDIDA 2026-09-21 (D-N1…D-N16);
contrato oficial em `setes-api/integracoes/nfse-adn/` (swagger/XSD só com o e-CNPJ)

---

## 1. Contexto

A nota da OS já nasce pela peça `@shared/invoice` (`issueInvoice`, evento `E`, model `'SE'` série `'1'`,
migration 046) e é cancelável (`cancelInvoice`, evento `C`, ciclo da OS em `tb_service_order`). Mas nasce
**sem o ramo de serviço** — `service-orders.repository.ts:975` passa `serviceTotal: null` (achado **A2** da
Onda 0; trilha **P8a** PENDENTE) — e não existe emissão fiscal nenhuma: sem DPS, sem transmissão, sem
protocolo, sem DANFSe, sem cancelamento por evento (trilha **P8b** PENDENTE). A venda com serviço já
manda `serviceTotal` e grava `tb_order_item_issqn` (item LC 116 + código municipal + alíquota da regra).

O que existe e é reusado sem reforma: `tb_invoice` (cabeçalho), `tb_invoice_service` (ramo MÍNIMO — só
`total_value`, migration 020: "cresce quando houver fato gerador"), `tb_invoice_event` (append-only E/C;
**T A R D I reservados**, nunca X), `tb_service_tax_rule` + `tb_service` (cidade de incidência × item LC
116 → alíquota + código municipal; `@shared/service-tax-rule` resolve; `calcIssqn`), estabelecimento com
CRT/regime, IE, **IM** (sem certificado), `@shared/secret-store` com owner `establishment` já previsto
(D-I1 da Onda 2: certificado A1 do EMISSOR ≠ certificado mTLS do canal do banco) — só PEM hoje.

Legado (vault `D:\Gestao2016\Infra-IA\Gestao`): NFS-e por PROVEDOR municipal via ACBrNFSeX (ISSNet, IPM,
Betha…), `TB_RPS_NFSE`/`TB_RETORNO_NFS` (lote, RPS, número, protocolo, "situação 1–5"), nota conjugada
mercadoria+serviço em desuso — **"na web cada ramo autoriza no seu documento"** (processo-pedido-nota);
`geracao-nfe-hierarquia`: NFS-e fica FORA da árvore da NF-e, pipeline com Strategy por modelo;
anti-exemplo `tb_config_nfe.certificate_pass` (senha em coluna). CAN-V5: NF-e autorizada com NFS-e
autorizada/cancelada NÃO bloqueia (decisão 36 do legado, intencional).

### 1.1 Contrato oficial — LEVANTADO (2026-09-20)

Guardado em `Infra-IA/setes-api/integracoes/nfse-adn/` (README com os fatos + manuais, Anexos I/II,
NTs 007/008/009, Res. 3/2023, FAQ oficial, manual de Curitiba — em texto). O que a spec CORRIGE ou
ACRESCENTA ao que a fase-mãe assumia:

- **Não existe "integrar direto ao ADN" para emitir**: o emissor próprio assina a DPS e a envia à
  **API da Sefin Nacional** (`POST /nfse`, síncrono: devolve a NFS-e ou a rejeição). O ADN só serve
  distribuição/consulta ao contribuinte. D1 continua válida — o alvo é `sefin.nfse.gov.br`.
- **Curitiba CONFIRMADA** conveniada à Sefin Nacional (planilha oficial de adesões: "Conveniado Ativo",
  aderente ao Emissor Nacional); obrigatório para todos desde **01/01/2026** (Portaria 33/2025). Q1 da
  fase e Q-N11 resolvidas pela fonte. ISS segue por DAM no ISS Curitiba.
- Autenticação = **mTLS com e-CNPJ A1** + **XMLDSig enveloped** da DPS (regra E0718: CNPJ do certificado
  = prestador). **Sem procuração eletrônica** → cada cliente emite com o próprio A1 (confirma D-I1 e o
  dono `establishment`). Sem token/OAuth.
- **API de DANFSe SUSPENSA desde 03/08/2026 (NT 008)**: o PDF é gerado pelo emissor, com leiaute da NT
  (bloco IBS/CBS, QR Code para a consulta pública). O conceito D do §3 muda: DANFSe é peça NOSSA de
  renderização a partir do XML autorizado, não uma chamada ao fisco → **Q-N13**.
- **Um DPS declara UM serviço** (grupo `serv` singular) — confirma a forma do ramo por colunas (Q-N2).
- **Séries do aplicativo próprio: 00001–49999**; `infDPS/@Id` de 45 posições traz cMun + inscrição +
  série + nDPS(15); chave de acesso de 50 dígitos; `tpAmb` 2 = produção restrita.
- **Cancelamento** (`e101101`, síncrono, irreversível, `cMotivo` 1/2/9 + `xMotivo` 15–255): prazo é do
  MUNICÍPIO (default 730 dias) — **Curitiba: 60 dias, não cancela após o recolhimento do ISS** (manual
  municipal; conferir o PAM por `GET /parametros_municipais/4106902/convenio`). Fora do prazo só resta a
  "Solicitação de Análise Fiscal" (`e101103`). Substituição existe (DPS com `chSubstda`) — fora desta onda.
- **Produção restrita existe** (`sefin.producaorestrita.nfse.gov.br`), mesmas regras (mTLS, E0718),
  sem cadastro prévio documentado; a confirmar se a parametrização de Curitiba está replicada lá.
- **IBS/CBS (LC 214/2025)**: o grupo `IBSCBS` da DPS é opcional hoje e **obrigatório em 01/10/2026**
  (lista LC 116 em geral) ou **01/12/2026** (subitens 1.03/1.05/1.09, 16.01, plataformas…); até
  31/12/2026 a ausência não rejeita. A Setes (software, subitem 1.x) cai numa dessas datas → **Q-N14**.
  NT 009 (jun/2026): CNPJ alfanumérico já vigente (01/07/2026), `vAjusteBC`, nova `vBC`.
- Swaggers oficiais exigem certificado (403 anônimo): o contrato JSON exato do `POST /nfse` (nomes dos
  campos, códigos HTTP) e o algoritmo de assinatura vigente (SHA-1 no manual de 2022 × SHA-256) se
  confirmam na 1ª sessão com o e-CNPJ — **1ª tarefa técnica da onda**, como foi com o Inter.

## 2. Objetivos (numerados)

1. A nota da OS nasce COM o ramo de serviço congelado (base de ISS, código nacional/municipal, cidade
   de incidência) — fecha A2 e a trilha P8a.
2. O estabelecimento se habilita como emissor nacional com o SEU certificado A1, em produção restrita ou
   produção, sem segredo em tabela nem no repositório.
3. Transmitir o DPS ao ADN, guardar as duas referências (nosso número do DPS × chave de acesso/número
   da NFS-e) e a história da conversa com o fisco; XML autorizado em disco; DANFSe sob demanda.
4. Cancelar a NFS-e por evento no ADN e só então cancelar a nota aqui (fail-closed); refletir aqui o que
   o fisco disser.
5. Trilha: P8a e P8b viram OK (ramo + transmissão + consulta + cancelamento em produção restrita).

## 3. Modelo (Rodada 0 — parecer do guardião, 2026-09-20)

"Emitir NFS-e pelo ADN" tem quatro "e" escondidos:

| # | Conceito (uma frase) | Fato gerador | Natureza |
|---|---|---|---|
| A | Este estabelecimento fala com o fisco nacional com o SEU certificado A1, num ambiente | habilitação (upload do A1 + ambiente) | peça — especialização do EMISSOR por PK |
| B | Este ramo de serviço foi declarado ao ADN (um DPS enviado) | o envio | peça — 1 ramo × N transmissões |
| C | O fisco disse algo sobre essa transmissão | cada resposta (síncrona ou consulta) | peça — voz do fisco, append-only |
| D | A NFS-e resultou (chave 50, número, protocolo, XML) | a autorização | NÃO é peça: write-once na transmissão autorizada + XML em `STORAGE_PATH/<cnpj>/<ano>/<mes>` (precedente do sync); **DANFSe = renderização NOSSA do XML** (API do fisco suspensa — Q-N13) |
| E | Nossa nota mudou (cancelou) | o efeito que a voz produz aqui | `tb_invoice_event` como hoje: só E/C |

**Reserva T/A/R/D/I de `tb_invoice_event`: LIBERAR (espelho da D-I5 da Onda 2).** T/A/R são a voz do
terceiro — vive em tabela própria, só o EFEITO entra no evento do documento; D (denegada) e I
(inutilizada) são conceitos da NF-e sem fato no ADN; e uma nota mercadoria+serviço teria DUAS
autorizações — `A` no cabeçalho não saberia dizer qual. **O estado fiscal é do RAMO**, derivado do último
evento da última transmissão. `cancelInvoice` continua a única porta do C.

### A. `tb_establishment_issuer` — a habilitação do emissor (schema do cliente)

Hoje não existe `tb_establishment`: o emissor É a institution (`tb_institution.id = tb_entity.id =
tb_company.id`; "Meu Estabelecimento" = cadeia da própria entity + `tb_entity_tax`). Dono =
`tb_institution_id`; `secret-store` owner `establishment` com `ownerId = institutionId` já encaixa.

PK `(tb_institution_id, authority)` — `authority` char(1) `N` = NFS-e nacional (amanhã `E` = SEFAZ NF-e
AGREGA linha, não reforma). **É dado**: `environment` char(1) `H` produção restrita / `P` produção ·
`dps_serie` varchar(5) (série do DPS é configuração do emissor) · `simples_regime` (opSimpNac — o
`taxRegime` de hoje não distingue MEI × ME/EPP) · `active` · colunas padrão. **Nunca é dado**: .pfx,
senha, chave privada, token.

**Senha do PKCS#12**: o upload recebe `.pfx` + senha, ABRE o arquivo na hora e o cofre guarda só o par
PEM (`certificate.pem` + `private.key`, mesmo formato do canal Inter; validade lida do certificado). A
senha existe só na requisição — nunca vira arquivo nem coluna (mata o anti-exemplo do legado por
construção). Custo: dependência para abrir PKCS#12 (Node não abre nativamente).

"canal" fica com o banco (palavra ocupada: conta × SEU banco); `issuer` já é a palavra da casa para
quem emite (`tb_invoice.issuer`).

### B. `tb_invoice_service_transmission` — a transmissão do DPS

PK `(tb_institution_id, tb_invoice_id, terminal, attempt)`; `environment` CONGELADO; write-once (chegam
na autorização/consulta, nunca mudam): `dps_id` (45), `access_key` (50), `nfse_number`, `protocol`,
`dh_proc`; `last_queried_at` (D-I20 da Onda 2: o fato "nós olhamos o fisco", write-many); XML
autorizado em disco. Reapresentar = `attempt + 1`, nunca UPDATE.

### C. `tb_invoice_service_transmission_event` — a voz do fisco (append-only)

`kind` = NOSSA leitura: **S** enviado · **A** autorizada · **R** rejeitada · **C** cancelada · **K**
cancelamento em voo · **F** falha explícita; `authority_code` cru + `message` + `dh` + `source` P/Q +
`invoice_event` (causa → efeito, precedente `slip_event`); idempotência por (kind, dh). Situação
desconhecida → falha alto (502), nunca inventa.

### O ramo de serviço como base do DPS (A2)

Fato do layout nacional que decide a forma: **um DPS declara UM serviço** (grupo `serv` singular:
`cTribNac`, `cTribMun`, `xDescServ`, valores) — não existe "item de NFS-e", a descrição é texto. Logo
`tb_invoice_service` cresce **por colunas**, nunca por `tb_invoice_service_item`: o detalhe por item já é
o universal (`tb_order_item` + `tb_order_item_issqn` congelado no faturamento).

Colunas do ramo (congeladas no faturamento, como `tb_invoice_merchandise` congela base/ICMS):
`tb_service_list_id` + `national_code` (cTribNac — o catálogo central `tb_service_list` ganha a coluna,
fato do mundo), `municipal_code` (da regra), `tb_city_id` de incidência (da regra), `base_iss_value` /
`aliq` / `iss_value` (soma de `tb_order_item_issqn`), `iss_withheld` char(1) e `liability` char(1)
exigibilidade (Q-N8), `dps_number` write-once (cunhado na 1ª transmissão — Q-N3), `description`
(xDescServ montado dos itens). Emitente/tomador/regime NÃO se congelam no ramo: são lidos na
transmissão e ficam congelados no XML assinado (o arquivo é o snapshot). Deduções e IBS/CBS agregam por
ADD COLUMN quando houver fato (Q-N10). `service-orders.repository.ts:975` passa a mandar o ramo — a
nota da OS deixa de ser "fatura interna".

### Composições

- **`@shared/tax-authority`** + `adapters/adn.ts` — transporte: assinatura XMLDSig, mTLS com o A1,
  recepção do DPS, consulta por chave, eventos, DANFSe. Não conhece nota.
- **`@shared/service-invoice-transmission`** — `transmit` (reserva `attempt` sob lock da nota → fisco
  FORA da transação → S/A/R/F; desfecho AMBÍGUO nunca fecha estado — D-I21) · `refresh` (consulta,
  grava a voz, `touchQueriedAt`, idempotente) · `applyAuthorityStatus` (ÚNICA porta de efeitos, em
  SAVEPOINT; recusa de REGRA = fato + pendência; transitório desfaz a transação — HIGH-1 da Onda 2) ·
  `cancelAtAuthority`.
- **Cancelamento** (junta D-I22 com a C1 do cancelamento de nota): **plano local → estado fiscal →
  pedido ao fisco → voz → efeito**. (1) `buildCancelPlan` ganha bloco `fiscal` e roda primeiro (FOR
  UPDATE): baixa/boleto/cheque bloqueiam ANTES de tocar o ADN; (2) transmissão autorizada vigente →
  evento de cancelamento ao ADN (síncrono: a resposta É a confirmação — diferente do 202 do Inter);
  (3) voz `C` na transmissão; (4) C local por `cancelInvoice` na MESMA transação. O C local nasce só da
  voz C do fisco; ambíguo grava `K` "em voo" que bloqueia qualquer ação até a consulta por chave
  reconciliar; fisco recusa (prazo, motivo) → 409 legível e nada muda; recusa local que entrou no
  intervalo → fato gravado + pendência visível (D-I10). Nota nunca transmitida cancela só localmente.

### Peças reusadas sem alteração
`issueInvoice`/`cancelInvoice`/`lockInvoice`, `tb_invoice_event` E/C, `tb_order_item_issqn`,
`@shared/service-tax-rule`, `calcIssqn`, `secret-store` (owner `establishment`), padrão apresentação ×
voz da Onda 2, `withDeadlockRetry`/`contention`, `lockInstitutionCounters` (para o `dps_number`),
`STORAGE_PATH`, catálogo `error-codes`.

### O que vira MAQUETE se modelar errado
Usar T/A/R/D/I na `tb_invoice_event` · chave/protocolo/cStat como colunas de `tb_invoice` ou do ramo ·
`tb_nfse` paralela à nota (recria TB_RPS_NFSE/TB_RETORNO_NFS) · `tb_invoice_service_item` · senha/.pfx em
coluna · `status_sefaz` no cabeçalho · pendurar o A1 no canal do banco · número do DPS = `tb_invoice.number`
(dois sentidos num campo quando houver conjugada) · C local no "enviado" sem voz · "situação 1–5" do
legado como coluna de estado · `tb_fiscal_log(json)` · `provider` de webservice municipal (D1 já matou) ·
UNIQUE de transmissão por nota (reapresentar é `attempt + 1`).

## 4. Nomes

| Objeto | Nome |
|---|---|
| Habilitação do emissor | `tb_establishment_issuer` (PK institution × authority) |
| Transmissão do DPS | `tb_invoice_service_transmission` |
| Voz do fisco | `tb_invoice_service_transmission_event` |
| Transporte | `@shared/tax-authority` + `adapters/adn.ts` |
| Composição | `@shared/service-invoice-transmission` |
| Segredos | `@shared/secret-store` owner `establishment` (par PEM derivado do .pfx) |
| Tela | aba **"Emissor fiscal"** no Meu Estabelecimento + seção **"No fisco"** no documento faturado da OS (linha do tempo, Transmitir / Consultar / DANFSe / Cancelar NFS-e) + ação em lote "Transmitir pendentes" na aba Faturados; sem tela nova de lista |
| Códigos de erro | `FISCAL_ISSUER_MISSING` · `FISCAL_CERT_MISSING/EXPIRED/INVALID` · `FISCAL_AUTHORITY_UNAVAILABLE` · `FISCAL_TRANSMISSION_IN_PROGRESS` · `FISCAL_DPS_REJECTED` · `FISCAL_ALREADY_AUTHORIZED` · `FISCAL_CANCEL_REFUSED` · `INVOICE_SERVICE_BRANCH_MISSING` · `INVOICE_SERVICE_MULTI_CODE` |

Palavras que ENTRAM na tabela de ocupadas do guardião ao fechar a Rodada 1: **transmissão** (DPS ao
fisco, ≠ registro do boleto) · **emissor** (`_issuer` = habilitação do estabelecimento; `tb_invoice.issuer`
= quem emitiu) · **autoridade** (`@shared/tax-authority`, ≠ banco).

## 5. Fora de escopo desta onda
NF-e de mercadoria (SEFAZ) — mesma peça `_issuer` com `authority='E'`, onda própria · IBS/CBS no DPS e
deduções (Q-N10) · webservice municipal (D1 matou) · substituição de NFS-e · transmissão automática no
faturamento (Q-N9 — política do emissor, depois) · produção real (Onda 4: URL, `SECRETS_PATH` fora do
deploy, certificado A1 real da Setes).

## 6. Critérios de sucesso (testáveis)
1. OS faturada → `tb_invoice_service` completo (código nacional/municipal, cidade, base, alíquota, ISS)
   — trilha P8a OK; venda com serviço inalterada.
2. Upload do A1 (.pfx + senha) → cofre com par PEM, validade na tela, senha em lugar nenhum; par que
   não abre/vencido → 400/409 legíveis.
3. Transmitir → S; consulta → A com chave 50, número, protocolo, XML em disco; DANFSe abre; transmitir de
   novo com A vigente → 409; DPS rejeitado → R legível e nova tentativa = `attempt + 1`; timeout → nada
   fecha, reconciliação por consulta.
4. Cancelar: baixa/boleto bloqueiam ANTES do fisco; fisco aceita → voz C + C local na mesma transação;
   fisco recusa → 409, nada muda; ambíguo → K bloqueante até reconciliar.
5. Trilha P8b OK em produção restrita; gates socrático ≥ 0.70 e adversarial sem HIGH.

## 7. ⚠️ Rodada 1 — questões para o Valdo (recomendação entre parênteses)

> **Antes de decidir, ler `prompt_onda_nfe_sefaz.md`** (Rodada 0 da NF-e por simetria, 2026-09-21): a Q-E1 responde a
> Q-N4 (PK do emissor por MODELO, não por autoridade), a Q-E2 tira `dps_serie` daqui (série = coluna do emissor por
> modelo), a Q-E3/Q-E23 tiram `simples_regime` da habilitação (vai para `tb_entity_tax` com `special_tax_regime` e
> `cnae`), a Q-E6 renomeia a composição para `@shared/invoice-transmission` + `branches/service.ts`, e o §9 daquele
> prompt enquadra a aba de configuração do `un_geranfe_Srv` do legado (provedor/layout/versão/portal morrem com a D1;
> LC 116/tributação municipal/NBS já são dado por serviço; CRET/CNAE são fato do emitente; formato da discriminação e
> e-mails viram configs da interface `billing`).

**Fatos do dev levantados na abertura da onda (2026-09-21)**, para decidir com o dado na mão:
- Todos os serviços da Setes (`tb_service` × `tb_service_tax_rule`) apontam para o item **1.02 Programação**
  da LC 116 (`tb_service_list.id = '1.02'`), código municipal 0102, alíquota 5 %, cidade de incidência
  Curitiba. Os contratos 4 e 11 têm dois serviços cada, mas os dois são 1.02 → **nunca há dois `cTribNac`
  na mesma OS** (Q-N2 (a) é segura; a recusa `INVOICE_SERVICE_MULTI_CODE` nunca dispara no caso zero).
- `tb_service_list` hoje é só `id` (o item, "1.02") + `description` + `local_incidence` — o `national_code`
  (`cTribNac`, 6 dígitos) NÃO existe (Q-N11 confirmada: a coluna nasce nesta onda, catálogo Super).
- Q-N14 com a data certa: para o 1.02 o grupo `IBSCBS` é obrigatório em **01/10/2026** (regra geral; só
  1.03/1.05/1.09/16.01 vão para 01/12) — a ausência não rejeita até 31/12/2026, mas a Onda 4 (produção)
  nasce dentro do período obrigatório.
- Resíduo do dev: serviços 19–40 "TRILHA Suporte mensal …" são sobras da trilha (não da onda); limpar junto
  com o ambiente ao fechar.

- **Q-N1** Liberar a reserva T/A/R/D/I de `tb_invoice_event`; voz do fisco em tabela própria; estado
  fiscal derivado por RAMO. *(Rec.: liberar — D-I5 espelhada.)*
- **Q-N2** Um DPS = um serviço: nota de serviço com mais de um `cTribNac` — (a) faturamento/OS recusa
  (`INVOICE_SERVICE_MULTI_CODE`) × (b) 1 ramo × N DPS (a transmissão ganharia o grupo na PK — REFORMA
  depois). *(Rec.: (a) nesta onda; conferir se a Setes usa 1.05 e 1.07 na mesma OS — se sim, a decisão
  é operacional, não de modelo.)*
- **Q-N3** Número do DPS: próprio do ramo, write-once na 1ª transmissão, MAX+1 por série do emissor com
  `lockInstitutionCounters` × reusar `tb_invoice.number`. *(Rec.: próprio do ramo.)*
- **Q-N4** Dono = institution, PK `(tb_institution_id, authority)` × só institution. *(Rec.: com authority.)*
- **Q-N5** PKCS#12: converter no upload e guardar só o par PEM, senha nunca persistida × guardar .pfx +
  senha como arquivos do cofre. *(Rec.: converter.)*
- **Q-N6** Ambiente `H`/`P` na habilitação; certificado sob a pasta do ambiente vigente (mesmo A1 nos
  dois — a virada exige novo upload, uma vez). *(Rec.: sim.)*
- **Q-N7** Ordem do cancelamento (plano local → fisco → voz → C) e C local só com voz; ambíguo = K em
  voo bloqueante; recusa local posterior = fato + pendência. *(Rec.: sim.)*
- **Q-N8** Retenção do ISS e exigibilidade: fonte = TOMADOR (`tb_entity_tax`) e REGRA
  (`tb_service_tax_rule` ganha `liability`), congeladas no ramo; nesta onda só o caso da Setes
  (tributável, sem retenção) com as colunas presentes e default. *(Rec.: colunas agora, fonte
  configurável no 1º caso real.)*
- **Q-N9** Transmitir: ato explícito + lote "Transmitir pendentes" × automática no faturamento da OS.
  *(Rec.: explícito + lote nesta onda; automática vira config do emissor depois.)*
- **Q-N10** IBS/CBS (grupo 2026 do DPS) e deduções: fora da onda, ramo cresce por coluna. *(Rec.: fora;
  registrar aqui o que a spec exigir em 2026 — §1.1.)*
- **Q-N11** Pré-requisitos antes de qualquer linha do conector: Q1 da fase (adesão de Curitiba, com
  fonte) e `national_code` no catálogo central `tb_service_list` (Super). *(Rec.: 1ª tarefa da onda.)*
- **Q-N12** Alvo confirmado pela spec: API da Sefin Nacional (mTLS + XMLDSig), produção restrita como
  ambiente `H`; a 1ª sessão com o e-CNPJ baixa o swagger e o XSD v1.01 para `integracoes/nfse-adn/` e
  crava o contrato do `POST /nfse` e o algoritmo de assinatura. *(Rec.: confirmar; é fato, não escolha.)*
- **Q-N13** DANFSe: a API do fisco foi suspensa (NT 008) → o PDF é NOSSO, renderizado do XML autorizado
  (leiaute da NT 008: QR Code para a consulta pública, bloco IBS/CBS). Peça `@shared/danfse` (render
  server-side, sem tela) nesta onda × entregar só o XML + link da consulta pública e o PDF na onda
  seguinte. *(Rec.: PDF nesta onda — o cliente da Setes recebe o DANFSe por e-mail hoje; sem ele a
  emissão não substitui o processo atual.)*
- **Q-N14** IBS/CBS: o grupo `IBSCBS` vira obrigatório em 01/10 ou 01/12/2026 conforme o subitem. (a)
  Entrar já nesta onda com os campos mínimos (`cIndOp`, `cClassTrib`, `dest`, `vBC`) × (b) fora, ramo
  cresce por coluna depois (Q-N10) e a onda fecha antes de outubro. *(Rec.: (b) com data marcada — a
  ausência não rejeita até 31/12/2026, mas a Onda 4 (produção) precisa nascer com a data no radar;
  decisão de negócio junto: subitem LC 116 / `cTribNac`, `cNBS` e `cIndOp` do serviço da Setes.)*
- **Q-N15** Prazo de cancelamento é do município (Curitiba 60 dias, nunca após o ISS recolhido): a
  composição lê o prazo do PAM na hora (`GET /parametros_municipais/{cMun}/convenio`, com cache) e
  recusa localmente antes de ir ao fisco × só repassa a recusa do fisco (E0822). *(Rec.: ler o PAM e
  avisar na tela; a recusa definitiva continua sendo a do fisco — nunca duas fontes de verdade.)*
- **Q-N16** Análise fiscal (`e101103`) e substituição (`chSubstda`): fora desta onda; registrar como atos
  próprios futuros (mesma família do "desativar a cobrança" B09). *(Rec.: fora.)*

## 8. Decisões registradas

**Rodada 1 DECIDIDA (Valdo 2026-09-21: "siga as recomendações nas duas rodadas" — NFS-e e NF-e juntas).** Onde a
Rodada 0 da NF-e (`prompt_onda_nfe_sefaz.md`) corrigiu a recomendação daqui, vale a versão corrigida:

- **D-N1** Reserva T/A/R/D/I de `tb_invoice_event` LIBERADA (comentário do `kind` muda; só E/C continuam); voz do
  fisco em tabela própria; estado fiscal derivado por RAMO.
- **D-N2** Um DPS = um serviço: OS/venda com mais de um `cTribNac` recusa (`INVOICE_SERVICE_MULTI_CODE`). Caso zero:
  todos os serviços da Setes são 1.02 (fato do dev, §7).
- **D-N3** Número do DPS próprio do ramo (`dps_number` write-once na 1ª transmissão, MAX+1 por série do emissor sob
  `lockInstitutionCounters`).
- **D-N4** (corrigida pela D-E1) Habilitação `tb_establishment_issuer` com PK **`(tb_institution_id, model)`**;
  autoridade DERIVADA do modelo. Linha `SE` para a NFS-e.
- **D-N5** PKCS#12 convertido no upload → cofre guarda só o par PEM; senha nunca persistida. A3 fora (D-E22).
- **D-N6** `environment` H/P por linha; certificado sob a pasta do ambiente (`establishment/<inst>/<H|P>/`), o mesmo A1
  serve a todos os modelos do ambiente.
- **D-N7** Cancelamento: plano local → estado fiscal → pedido ao fisco → voz → C na MESMA transação; C local só com a
  voz; ambíguo = K em voo bloqueante; recusa local posterior = fato + pendência.
- **D-N8** Retenção/exigibilidade: colunas `iss_withheld` e `liability` no ramo, congeladas; fonte configurável no 1º
  caso real (Setes = tributável, sem retenção, defaults).
- **D-N9** Transmitir = ato explícito + lote "Transmitir pendentes"; automático vira config do emissor depois
  (`fiscal_auto_transmit`, futura).
- **D-N10** IBS/CBS e deduções fora; ramo cresce por coluna. **Data no radar: 01/10/2026** (item 1.02) — mesma mesa da
  D-E17 (fase própria de IBS/CBS para os dois documentos).
- **D-N11** Pré-requisitos: adesão de Curitiba (confirmada pela fonte) e `national_code` no catálogo central
  `tb_service_list` — 1ª tarefa da onda.
- **D-N12** Alvo = API da Sefin Nacional (mTLS + XMLDSig), produção restrita = ambiente H; a 1ª sessão com o e-CNPJ da
  Setes crava o contrato do `POST /nfse` e o algoritmo de assinatura (swagger/XSD → `integracoes/nfse-adn/`).
- **D-N13** DANFSe = PDF NOSSO nesta onda (`@shared/danfse`, render server-side do XML autorizado; motor de PDF único
  com o futuro DANFE — D-E13/D-E25).
- **D-N14** IBS/CBS (b): fora desta onda, com data marcada (01/10/2026); a Onda 4 nasce dentro do período obrigatório.
  > **Premissa CORRIGIDA (2026-09-30, texto oficial do Ato Conjunto RFB/CGIBS nº 4/2026, lido no PDF do CGIBS)**:
  > o 01/10/2026 (art. 1º, III, "d") vale para o regime REGULAR. O **§ 1º põe TODO optante do Simples
  > Nacional em 01/01/2027**, para todos os documentos, sem condição de opção — a Setes é ME/EPP (D-N19a),
  > logo **nada muda para a Setes em 01/10**. A FAQ local (`faq-nacional.txt` 15.1) diz "optantes que
  > aderirem voluntariamente" — está ERRADA frente ao texto; vale o Ato. Demais fatos do Ato: a obrigação é
  > por FATO GERADOR (competência) a partir da data; 1.03/1.05/1.09/16.01, plataformas, locação e bens
  > imateriais = 01/12/2026; NF-e/NFC-e = 03/08/2026 (monofásica 01/01/2027; não contribuinte de ICMS
  > 01/12/2026). Até 31/12/2026 a ausência não rejeita; o Ato Conjunto nº 5/2026 (DOU 13/08) criou o
  > programa de conformidade (adaptação assistida, retificar até 31/12/2026). Consequência: IBS/CBS vira
  > pré-requisito de (1) o 1º cliente NÃO optante do Simples e (2) a própria Setes em 01/01/2027.
- **D-N15** Prazo de cancelamento: lê o PAM (`GET /parametros_municipais/{cMun}/convenio`, com cache) e AVISA na tela;
  a recusa definitiva é a do fisco (E0822).
- **D-N16** Análise fiscal (`e101103`) e substituição (`chSubstda`): fora; atos próprios futuros.
- **Herdadas da NF-e** (D-E2/D-E3/D-E6/D-E23/D-E24): `serie` = coluna do emissor por modelo (aposenta `invoice_serie` e
  o `dps_serie`); `simples_regime` + `special_tax_regime` + `cnae` em `tb_entity_tax` (aba Tributação do Meu
  Estabelecimento); composição ÚNICA `@shared/invoice-transmission` + `branches/service.ts`; configs de comportamento
  (`dps_description_format`, `fiscal_accountant_email`, `fiscal_email_copy_to_issuer`) na interface `billing`.

**Ordem de execução (D-E20 (a): peças comuns nascem com esta onda; a NF-e em si espera o 1º cliente com mercadoria)**
— ver `prompt_onda_nfe_sefaz.md` §10 para o que da NF-e entra agora.

## 9. Execução — CHECKPOINT (sessão de 2026-09-21 → 22; retomar por aqui)

### Etapa 1 — DDL + ramo de serviço (A2 fechado) — ENTREGUE
- **Seed sql/57** (aplicado no dev): catálogo CENTRAL `tb_service_national_code` (336 códigos do Anexo B v1.01; PK
  `code` CHAR(6), FK ao subitem `tb_service_list`) — **D-N11a (assunção)**: 338 códigos para ~200 subitens → o código
  nacional é catálogo próprio ligado ao subitem, NÃO coluna de `tb_service_list`; a regra de ISS escolhe
  (`tb_service_tax_rule.national_code`), pré-preenchido/derivado quando o subitem tem um único desdobro
  (`DERIVED_NATIONAL_CODE_SQL` na peça). Setes: 1.02 → **010201**. Subitens 11.05 e 99.01 do Anexo B não existem no
  nosso catálogo LC 116 (ficaram fora; conferir quando houver cliente nesses itens). DDL canônico em `sql/01`.
- **Migration 058** (aplicada no dev; `sql/03` espelhado): `tb_entity_tax` + `simples_regime`/`special_tax_regime`/`cnae`
  (D-E23); `tb_service_tax_rule.national_code` + FK cross-schema; `tb_invoice_service` + 11 colunas congeladas
  (subitem, códigos, cidade de incidência, base/alíquota/ISS, retenção, exigibilidade, `dps_number` write-once,
  `description`); comentário de `tb_invoice_event.kind` liberado (D-N1); **`tb_establishment_issuer` PK (institution,
  model)** + backfill da linha 55 a partir da config `invoice_serie` (D-E2; no dev não havia valor);
  `tb_invoice_service_transmission` + `_event` (conceitos B/C). Validação sqlglot: `ADD KEY IF NOT EXISTS` (MariaDB) o
  parser não conhece — validar com essas cláusulas removidas, como na 056.
- **Seed sql/58** (aplicado): configs `dps_description_format` (Options I/O/A), `fiscal_accountant_email`,
  `fiscal_email_copy_to_issuer` na interface `billing`; `invoice_serie` marcada deleted='S' no catálogo (D-E2).
  FEITO (2026-09-22): billing lê a série da linha do emissor por modelo (`getIssuer(model)`, fallback '1') e a OS a
  da linha SE — `invoice_serie` não é mais lida em lugar nenhum.
- **Código** (1049 → verde nas suítes tocadas; jest completo 1057/1057 antes dos agentes): `@shared/entity-tax`
  (3 fatos do emitente) + módulo `establishment` (DTO/PUT/GET); `@shared/service-tax-rule` resolve `nationalCode`
  (derivado) e `checkServiceRule` ganha o problema `NATIONAL_CODE` (depois da cidade); módulo `service-tax-rules` grava
  `nationalCode`, valida que é desdobro do subitem (422 `SERVICE_TAX_RULE_NATIONAL_CODE_MISMATCH`), lookup
  `GET /national-codes?serviceListId=`; **`issueInvoice` troca `serviceTotal` por `service: InvoiceServiceInput`**
  (ramo por colunas); billing monta o ramo (`buildServiceBranch`: D-N2 → 422 `INVOICE_SERVICE_MULTI_CODE`; regra sem
  código → 422 `SERVICE_RULE_NATIONAL_CODE_REQUIRED`; descrição = "qtd x nome; …"); **OS: `resolveServiceOrderFiscal`
  ANTES da transação** (regra por serviço, cidade do tomador pela cadeia, retenção do tomador) + `freezeServiceOrderIss`
  SOB o lock (itens relidos; `tb_order_item_issqn` por item — mesma tabela da venda; item trocado no intervalo = 422) →
  a nota da OS nasce COM o ramo. Trilha: **P8a OK** (21 OK · 3 PENDENTE · 0 FALHA). Códigos novos: os 4 acima +
  `SERVICE_ORDER_ITEM_NO_RULE`.
- Libs instaladas: `node-forge` (PKCS#12), `xml-crypto` (XMLDSig/C14N), `pdfkit` (DANFSe) + types.
- Contrato baixado: Anexo B v1.01 (xlsx) + XSD v1.01 (zip → `xsd/Schemas/1.01/`) em `integracoes/nfse-adn/`; assinatura =
  **rsa-sha1** pelo manual 2022 (XSD genérico não fixa) — parametrizada, confirmar com o e-CNPJ.

### Etapa 2 — habilitação do emissor: API ENTREGUE (agente, 2026-09-22 — verificada: 21 testes, tsc limpo, 133 códigos) · APP ENTREGUE (agente: aba "Emissor fiscal" como seção autônoma com `file_selector`, 3 fatos do emitente na aba principal, código nacional dependente do item no form da regra; analyze limpo, 120/120; `file_selector` declarado no pubspec do app; achado: o molde `bank_account_channel_section` libera `_busy` só no finally — spinner atrás do dialog de falha, não corrigido lá)
- API: peça `@shared/fiscal-issuer` (linhas por modelo, cofre owner `establishment` por ambiente H→'S'/P→'P',
  `storeIssuerCertificate` converte .pfx+senha → PEM com node-forge validando o par antes de gravar; `openIssuer`;
  status com CNPJ do e-CNPJ) + sub-recurso `establishment/issuer` (`GET /issuer`, `PUT/DELETE /issuer/:model`,
  `PUT/DELETE /issuer/certificate/:environment` write-only) + códigos `FISCAL_ISSUER_MISSING/CERT_MISSING/CERT_EXPIRED/
  CERT_INVALID/MODEL_NOT_SUPPORTED/ISSUER_HAS_LIVE_TRANSMISSIONS`.
- App: aba **"Emissor fiscal"** no Meu Estabelecimento (certificado por ambiente via `file_selector` + linhas por
  modelo SE/55) + 3 fatos do emitente na aba principal + código nacional no form da regra de ISS (lookup dependente do
  item; derivado quando único).

### Etapa 3 — transmissão: peça `@shared/tax-authority` ENTREGUE (agente, 2026-09-22; 23 testes, tsc limpo); composição EM CURSO
- **[INCERTO] só a 1ª sessão com o e-CNPJ confirma** (registrar o resultado aqui): (1) nomes JSON do envelope
  (`dpsXmlGZipB64` envio · `nfseXmlGZipB64` + `chaveAcesso` retorno · evento `pedidoRegistroEventoXmlGZipB64` — sem fonte —
  e retorno `eventoXmlGZipB64`; leitura tolerante a qualquer chave `xml…gzip…b64`); (2) formato de `erros[]`
  (`{codigo, descricao, complemento}` assumido; aceita `errors[]`/`mensagens[]`); (3) lista de `GET /nfse/{chave}/eventos`
  e o JSON do `/convenio` (prazo procurado por `*cancel*` + `prazo|dias`); (4) SHA-1 × SHA-256 (manual 2022 = sha1;
  `ADN_SIGN_ALGORITHM` parametrizado); (5) `<serie>` sem zero à esquerda; (6) 201 × 200 no `POST /nfse` (aceita 2xx).
  **Fatos cravados nas fontes**: `nPedRegEvento` não existe (Id = `PRE`+chave(50)+código(6)); `e101101/xDesc` fixo
  "Cancelamento de NFS-e"; `cStat` da NFS-e NÃO expressa cancelamento — `queryNfse` deriva `cancelled` dos eventos.
- Peça `@shared/tax-authority` (agente): `xmldsig.ts` paramétrico, `dps-builder.ts` (Id 45, XML na ordem do XSD,
  evento e101101, parse da NFS-e), `adapters/adn.ts` (REST JSON gzip+b64, mTLS com o A1, tradução única de falhas:
  `FISCAL_AUTHORITY_UNAVAILABLE/AUTH_FAILED/DPS_REJECTED/NFSE_NOT_FOUND/AUTHORITY_UNKNOWN_RESPONSE`).
- Já escrito: `@shared/invoice-transmission/transmission.repository.ts` (tabelas B/C do ramo de serviço: reserva
  `attempt`, `dps_id` nosso, write-once do fisco, voz append-only idempotente por (kind, dh), `touchQueriedAt`, rodízio,
  pendentes para o lote, `nextDpsNumber` MAX+1 sob lock da institution — D-N3).
- **Composição ENTREGUE (agente, 2026-09-22; verificada: tsc limpo, jest 88 suítes/1131 testes, errors:gen 143)**:
  `@shared/invoice-transmission` (transmit/refresh/applyCancelEffect/cancelAtAuthority/refreshOpen/view/readNfseXml) +
  `branches/service.ts`; `@shared/danfse` (pdfkit; QR Code em texto — [INCERTO: lib de QR]); 8 rotas `/api/billing/fiscal*`
  + `POST /billing/transmit`; bloco **`fiscal`** no `buildCancelPlan` (nota com A/em voo/K → 409 `INVOICE_CANCEL_BLOCKED`
  field `fiscal` — variante escolhida em vez de código próprio); **migration 059** (`dps_id` deixa de ser UNIQUE: toda
  tentativa reusa o nDPS — D-N3); **seed sql/59** privilégio TRANSMITIR (id 9) em `service-orders` e `orders`; trilha
  **P8b real** (PENDENTE com motivo exato). Códigos: `INVOICE_SERVICE_BRANCH_MISSING`, `FISCAL_TRANSMISSION_IN_PROGRESS`,
  `FISCAL_ALREADY_AUTHORIZED`, `FISCAL_CANCEL_IN_FLIGHT`, `FISCAL_CANCEL_REFUSED`, `FISCAL_NOT_TRANSMITTED`,
  `INVOICE_NOT_TRANSMITTABLE`, `FISCAL_EMITTER_INCOMPLETE`, `FISCAL_RECIPIENT_INCOMPLETE`, `FISCAL_EFFECT_PENDING`.
  **Assunções do agente a confirmar (Q-N17…)**: sem evento `S` (POST síncrono → A/R/F direto); reserva sem voz > 10 min
  → no transmit consulta `GET /dps/{id}` (achou = A retroativo; não achou = F "sem resposta"); efeito C pendente é
  RETENTADO na consulta seguinte (não há "reaplicar" manual como na D-I25); TRANSMITIR conferido por item no lote;
  `tb_invoice.status` intocado.
- **App "No fisco" ENTREGUE (agente; analyze limpo, 143/143)**: seção no documento faturado da OS (situação, chave/nº
  com copiar, pendências, Transmitir/Consultar/XML/DANFSe/Cancelar NFS-e gated por TRANSMITIR/CANCELAR; "Cancelar nota"
  some com A/K), lote "Transmitir pendentes" na aba Faturadas (fatias de 50, reentrância H1), `showInfoFeedback` para
  `warnings[]`, 45 chaves i18n.
- **Sonda ao vivo (2026-09-22, dev, certificado AUTOASSINADO descartável — removido no fim)**: PUT issuer SE (H, série 1)
  → PUT certificate H → `POST /billing/transmit` da nota 8005: DPS montado (Id
  `DPS4106902 2 07742094000113 00001 000000000000001`, tomador com endNac/CEP, cTribNac 010201, vServ 250, pAliq 5)
  , assinado, salvo em `storage/<cnpj>/2026/09/`, produção restrita respondeu **403** (cert não ICP-Brasil) → 409
  `FISCAL_AUTHORITY_AUTH_FAILED`, evento F, view `state: failed`, refresh idempotente. **Achados da sonda (corrigir)**:
  (a) `cTribMun` cortado para 3 dígitos ("0102" → "010") — omitir quando não tem exatamente 3 dígitos; (b) mensagem do
  403 carrega o HTML do fisco — limpar tags e limitar.
- Falta: gates (socrático + adversarial EM CURSO), correções, 1ª sessão com o e-CNPJ da Setes (só o Valdo), commit.
- Antes (referência do plano): composição `@shared/invoice-transmission` + `branches/service.ts` (transmit/refresh/cancel na ordem D-N7;
  montagem do DPS a partir do ramo + cadeia do emitente/tomador + `tb_entity_tax`; XML em `STORAGE_PATH/<cnpj>/<ano>/
  <mes>/<chave>.xml`), endpoints em `/api/billing` (`POST /transmit {orderId}`, `POST /fiscal/refresh`,
  `GET /fiscal/:orderId`, `GET /fiscal/:orderId/xml`, `GET /fiscal/:orderId/danfse`), bloco `fiscal` no
  `buildCancelPlan` (plano local → estado fiscal → pedido ao fisco → voz → C na mesma transação), `@shared/danfse`
  (pdfkit), privilégio TRANSMITIR (seed), app "No fisco" na OS faturada + lote "Transmitir pendentes", trilha P8b,
  gates, 1ª sessão com o e-CNPJ da Setes (D-N12/D-E19 — só o Valdo).

## 10. Gates da onda (2026-09-22)

### 10.1 Gate socrático — 1ª rodada **0.63 ✗** (retrabalho em sessão)
Nenhum CRITICAL. **HIGH-1** K (cancelamento em voo) não tinha saída quando o fisco NÃO cancelou (timeout antes de o
pedido chegar → nota presa em 409 para sempre). **HIGH-2** o revive do cabeçalho zerava `dps_number` e o MAX+1 lia só
linhas vivas → cancelar e refaturar a última nota cunhava o MESMO nDPS/Id de DPS para conteúdo diferente. **HIGH-3** a
voz C do mesmo cancelamento chegava com `dh` diferente por três caminhos (NFS-e agregada, lista de eventos, resposta
do pedido) → 2º C gravado, e o efeito batia em `lockInvoice` 404 (nota já soft-deletada) → pendência permanente.
MEDIUM: R terminal para a consulta (NFS-e de tentativa anterior inalcançável — a chave ia para `latestTransmission`, não
para quem cunhou o `dps_id`); idade da reserva misturava relógio do MySQL com `Date.now()`; DPS assinado de leitura
pré-transação sem cinto de versão; lote sem orçamento nem coalescência; defaults silenciosos em fato fiscal
(`opSimpNac` '1', `liability` '1', `cTribMun` truncado); consulta ativa não vigiava A nem retentava C pendente; consulta
sem privilégio e `minMinutes` 0. LOW: erros de montagem do DPS como `Error` cru (500); UNIQUE (kind, dh) com NULL não é
cinto; lote listava reserva em voo como pendente; comentário de `status='0'` desatualizado; ordem de locks invertida na
consulta (retry cobre); amostra de 2xx ilegível no log; `dhEmi` antes da assinatura; configs do seed 58 sem consumidor;
contador por institution e não por série.

**Assunções EXECUTADAS no retrabalho (viram decisão com o "concordo"; divergência = reverter):**
- **D-N17** — kind **`N`** ("pedido de cancelamento não consta no fisco", voz source Q) resolve o K: consulta com K vigente e
  fisco dizendo autorizada/não cancelada grava N; N devolve a transmissão ao estado AUTORIZADO (`isAuthorized` = A ou N),
  é final para a consulta ativa e libera novo pedido de cancelamento. Alternativas descartadas: reusar A com outro dh
  (fato falso), apagar o K (append-only).
- **D-N18** — o contador do nDPS vive no EMISSOR: `tb_establishment_issuer.dps_last_number` (migration 060, backfill =
  MAX incluindo canceladas), incrementado sob `lockInstitutionCounters`; o revive continua zerando `dps_number` (nova vida
  = novo nDPS, Id novo); trocar a série NÃO reinicia a numeração (o Id inclui a série — sem colisão; diverge da prática
  "por série" — Q-N25 se o Valdo quiser reinício por série).
- **D-N19** — `simples_regime` NULL no emitente = 422 `FISCAL_EMITTER_INCOMPLETE` (campo `simplesRegime`), nunca default
  "não optante"; `special_tax_regime` NULL → '0' documentado. Se a Setes for ME/EPP, `regApTribSN` precisa de coluna
  (fato do emitente) antes da 1ª sessão — **Q-N19a**.
- **D-N20** — `liability` (tribISSQN) derivada da exigibilidade do EMITENTE (`tb_entity_tax.iss_exigibilidade`: 01→1,
  05→2 imune, 04→3 exportação, 02→4 não incidência; demais/NULL → 1) nas duas portas; override por regra de ISS = futuro.
- **D-N21** — a consulta ativa vigia A (throttle 24 h — cancelamento pelo portal do contribuinte) e retenta C com efeito
  pendente (15 min), dentro dos mesmos 8/passada e orçamento.
- **D-N22 (divergente da rec.)** — as rotas de consulta exigem o privilégio TRANSMITIR do ramo (quem consulta pode disparar
  efeito local — cancelamento, estorno de cheque); `minMinutes ≥ 1`. (Rec. do gate era VISUALIZAR: não existe privilégio
  de visualização por ramo — acesso à interface é o que há.)
- **D-N23** — `dCompet` = `dt_emission` nesta onda (a competência do contrato fica para quando houver rejeição por isso).
- **D-N24** — `dps_description_format` consumido no billing de VENDA ('I' itens · 'O' observação · 'A' ambos); OS = 'I'.
- HIGH-3 — C idempotente por KIND na tentativa (um C por transmissão, qualquer dh); efeito reconhece nota já cancelada
  (último evento C, mesmo soft-deletada) como aplicado. MEDIUM-1 — consulta/reconciliação por `dps_id` em R/F, chave gravada
  na tentativa que CUNHOU o Id. MEDIUM-2 — idade no banco (`TIMESTAMPDIFF`). MEDIUM-3 — reserva confere `lastEvent` e
  `updated_at` do ramo (409 RESOURCE_BUSY se mudou) e abre o emissor sob lock. MEDIUM-4 — lote com orçamento 60 s,
  `stoppedEarly`, coalescência por institution (409 `FISCAL_BATCH_RUNNING`), IN_PROGRESS retryable. LOW-1 — montagem do DPS
  falha com 422 (`FISCAL_DPS_INVALID`) antes de reservar. LOW-3/4/6/9/10 executados/registrados.

### 10.2 ⚠️ RETOMAR AQUI (sessão fechada em 2026-09-22 ~02h; os dois agentes caíram por 522 do provedor no FIM do trabalho)
**Conferido no disco ANTES de fechar (mais preciso que o texto abaixo)**: `tsc` LIMPO; **migration 060 existe e está
APLICADA no dev** (`dps_last_number` no emissor, kind N; `sql/03` espelhado; `simples_regime='1'` gravado na institution
1); `onda3-gate-rework.test.ts` **33/33** (retrabalho do §10.1 chegou inteiro); suíte completa **1269/1279 — as 10 falhas
são TODAS no `onda3-adversarial.test.ts`** e são os ACHADOS que o gate deixou FALHANDO de propósito (o relatório não foi
entregue — a lista é a dos títulos dos testes): **ACHADO 1 (HIGH)** `registerEvent` trata 2xx SEM envelope legível
(corpo vazio / JSON sem XML / 201 HTML de proxy / 204) como ACEITE → voz C + `cancelInvoice` local nascem sem voz do fisco
(D-N7 furada) — deve virar 502 ambíguo + K em voo; **série**: DTO do emissor aceita "0"/"00000"/"50000" e `buildDpsId`
aceita 50000/99999 (limitar 1–49999 nas duas camadas); **`municipal_code` com 2 dígitos → `Error` cru** (422 antes de
reservar); **lote com TLS recusado na 1ª nota** deve parar (`stoppedEarly`) sem chamar o fisco de novo nem gravar F nas
demais; **2xx com `chaveAcesso` "123" e XML sem Id → 502** (não é chave) e nada gravado; **ACHADO 6 (LOW)** .pfx com dois
certificados da MESMA chave (renovação) → o cofre deve ficar com o VÁLIDO. Passo 1 da retomada = corrigir esses 10 em
sessão (cada teste já é a prova), re-score socrático, docs, commit.
Estado do disco ao fechar: setes-api 51 arquivos sujos · setes-app 39 · sql 5 · Infra-IA 8 — **NADA commitado da Onda 3**.
Última migration em disco: **059** (060 do retrabalho AINDA NÃO existia); `src/__tests__/onda3-adversarial.test.ts`
existe PARCIAL (o gate adversarial estava escrevendo; `tsc` acusa erros nele — linhas 76/77 — e nenhum relatório foi
entregue); o retrabalho socrático (§10.1: D-N17…D-N24, migration 060, `onda3-gate-rework.test.ts`) tinha acabado de ser
delegado — provavelmente nada ou pouco dele chegou ao disco.

**Passos para retomar, nesta ordem:**
1. `cd setes-api && npx tsc --noEmit -p . && npx jest --silent` — separar o que está quebrado: se só o
   `onda3-adversarial.test.ts` quebra, é o arquivo parcial (renomear para `.wip` ou completar); se `invoice-transmission`,
   `branches/service.ts`, `transmission.repository.ts` ou `fiscal-issuer` quebram, o retrabalho ficou pela metade —
   comparar com o §10.1 e concluir item a item (HIGH-1 kind N · HIGH-2 contador `dps_last_number` no emissor + migration
   060 + espelho em sql/03 · HIGH-3 C idempotente por kind + efeito reconhece nota já cancelada · MEDIUM-1…7 · LOWs).
2. Refazer o gate adversarial (prompt do §10.1 e o molde `onda2-adversarial.test.ts`) e o re-score socrático até ≥ 0.70 /
   sem HIGH; corrigir em sessão; registrar em §10.3/§10.4.
3. `flutter analyze` + `flutter test` em setes-app/apps/web (estado ao fechar: analyze limpo, 143/143).
4. Trilha `scripts/trilha-primeiro-cliente.ts` (estado ao fechar: 21 OK · 3 PENDENTE · 0 FALHA; P8b diz "sem habilitação
   SE"). No dev a linha SE (H, série 1) FICOU habilitada pela sonda; o certificado autoassinado foi REMOVIDO.
5. Fechar docs (§9/§10 aqui, INDICE_CENTRAL, CLAUDE.md, memória, palavras ocupadas do guardião: transmissão · emissor ·
   autoridade · chave · voz) e **commitar os 4 repos** (um commit por repo; push só com "vai" do Valdo).
6. 1ª sessão com o e-CNPJ A1 da Setes (só o Valdo): aba Emissor fiscal → certificado H → Transmitir a nota da OS →
   cravar os [INCERTO] do §9 (envelope JSON, `erros[]`, `/convenio`, sha1×sha256, 201×200) e a Q-N19a (ME/EPP →
   `regApTribSN`).
Questões abertas para o Valdo: Q-N17…Q-N24 (assunções do §10.1, confirmar ou reverter), Q-N19a, Q-N25 (reinício do nDPS
por série?).

### 10.3 Gate adversarial — 1ª rodada: os 10 achados CORRIGIDOS em sessão (2026-09-28)
Retomada pelo §10.2. Estado do disco conferido antes de tocar: `tsc` limpo, suíte 1269/1279 — as 10 falhas eram
exatamente os achados que o gate deixou como testes em `onda3-adversarial.test.ts` (o relatório nunca foi entregue; a
lista abaixo é a dos testes). Cada correção passou pelo teste que a provava; suíte **1279/1279** ao final.

| # | Sev. | Achado (o que o teste provava) | Correção |
|---|---|---|---|
| 1 | **HIGH** | `registerEvent` do ADN tratava 2xx SEM o evento gerado (corpo vazio, JSON sem XML, 201 HTML de proxy, 204) como ACEITE: devolvia `dhEvento null` e a composição gravava a voz C e cancelava a nota localmente sem a voz do fisco — D-N7 furada; a consulta seguinte nem olhava o fisco (C sem pendência = fim da história). | `adapters/adn.ts`: sem evento parseado (`eventCode` + `dhProc|dhEvento`) → 502 `FISCAL_AUTHORITY_UNKNOWN_RESPONSE` (mesma `unknownResponse` do transmit). A composição já tratava ambíguo como K em voo — o erro sobe COMO VEIO (prova positiva (16) exige identidade do erro, inclusive erro cru). Teste unitário do adaptador que fixava o comportamento antigo foi atualizado (`tax-authority.test.ts`). |
| 2 | MEDIUM | `municipal_code` presente e fora de 3 dígitos era OMITIDO em silêncio no DPS (default em fato fiscal, MEDIUM-5 do socrático); demais casos (alíquota ≥ 10, valor negativo, série 0/não numérica) já viravam 422 pela LOW-1. | `branches/service.ts`: presente e ≠ 3 dígitos → 422 `FISCAL_DPS_INVALID` campo `municipalCode` ANTES de reservar; ausente segue omitido (XSD opcional). ⚠️ O valor está CONGELADO no ramo no faturamento — nota faturada com código do legado ('0102') não transmite até a regra de ISS ser corrigida e a nota refaturada (**Q-N26**). |
| 3 | MEDIUM | DTO do emissor aceitava série "0"/"00000"/"50000"; `buildDpsId` aceitava 50000–99999 (faixa do emissor nacional, §1). | Constantes ÚNICAS `DPS_SERIE_MIN/MAX` (1–49999) em `dps-builder.ts`, consumidas pelo DTO (`.refine`), pelo service do emissor e por `buildDpsId`. NF-e admite série 0 no SEFAZ — quando a onda 55 executar, a faixa passa a depender do modelo (Q-E). |
| 4 | MEDIUM | Lote `transmit-batch` só parava em `FISCAL_AUTHORITY_UNAVAILABLE`: TLS recusado na 1ª nota gerava 1 F por nota e N handshakes com o mesmo A1 quebrado (lição §10.4 da Onda 2: credencial ≠ indisponibilidade). | `billing.fiscal.service.ts`: `FISCAL_AUTHORITY_AUTH_FAILED` também pára o lote (`stoppedEarly`; restantes `retryable` sem F). |
| 5 | LOW | 2xx com `chaveAcesso` "123" e XML sem Id gravava A com "chave" que o cancelamento (`buildEventId` exige 50) estourava como `Error` cru. | `adapters/adn.ts`: `asAccessKey` — chave só com 50 dígitos em `transmit`, `queryNfse` (chave do XML) e `queryDpsAccessKey`; sem chave válida → 502, nada gravado. |
| 6 | LOW | `.pfx` com DOIS certificados da MESMA chave (renovação que reaproveitou o par: vencido + válido) → o cofre ficava com o 1º que casava, mesmo vencido → 409 injusto. | `fiscal-issuer.ts` `pkcs12ToPem`: entre os que casam com a chave, prefere o VIGENTE agora; empate = o que vence por último. |

Ajuste de harness (não de prova): o teste do ACHADO 1 checava o NOME do construtor (`ctor: 'HttpError'`); o erro do
adaptador é `AuthorityHttpError` (subclasse) e a prova positiva (16) exige que ele suba idêntico — trocado por
`toBeInstanceOf(HttpError)` + mensagem "sem envelope legível", como já fazia o teste (3). A prova do bug (≥ 502, nenhum C,
`cancelInvoice` não chamado, K em voo) ficou intacta.

Régua da fase re-executada com a API no ar (2026-09-28): **trilha 21 OK · 3 PENDENTE · 0 FALHA** (P7b pendente = sandbox
do Inter fora da janela 8h–20h; P8b = sem A1 no cofre; P9 = Onda 4) — nenhum OK anterior quebrou.

### 10.4 Re-score socrático **0.67 ✗** (2026-09-28) → retrabalho EXECUTADO em sessão (assunções D-N26…D-N30)
Os 3 HIGH da 1ª rodada e os 10 achados do adversarial foram conferidos FECHADOS no código; D-N17…D-N24 conferidas
item a item. Sobrou 1 HIGH NOVO, estrutural, nascido da própria correção MEDIUM-1 da 1ª rodada, e 4 MEDIUM.
**Assunções EXECUTADAS (viram decisão com o "concordo"; divergência = reverter)** — testes em
`onda3-gate-rework-r2.test.ts` (12/12):
- **D-N26 (HIGH-1)** — a chave da NFS-e pousa na tentativa que CUNHOU o Id (MEDIUM-1 da 1ª rodada), que pode NÃO ser
  a última (1 em voo → F por 404 eventual do `/dps`, 2 reusa o nDPS → R, consulta acha → A na 1). TODOS os decisores
  liam a última (`ORDER BY attempt DESC`): o plano de cancelamento cancelava LOCALMENTE uma nota autorizada no fisco
  (D-N7 furada por outro caminho) e o transmit abria a 3ª tentativa com o mesmo Id (`fillAuthorityData` batia no UNIQUE
  da chave → 500 em loop). Agora `latestTransmission` é o leitor ÚNICO da VIGENTE: **quem DETÉM a chave decide**
  (`ORDER BY access_key IS NOT NULL DESC, attempt DESC`); `currentOf()` aplica a mesma regra na lista da tela. Alternativa
  descartada: leitor novo `currentServiceTransmission` (deixaria o antigo vivo para alguém usar errado).
- **D-N27 (MEDIUM-1)** — a transmissão pertence a uma VIDA da nota: migration **061** (`invoice_event` = evento E que
  a emitiu; backfill = último E anterior à criação da tentativa; sem E localizável = NULL, segue visível). Cancelar e
  refaturar o MESMO id (revive, D3) abre vida nova: a tela "No fisco", o XML, o DANFSe e a lista de pendentes mostravam
  a NFS-e CANCELADA da vida anterior como se fosse desta nota. `LIFE_WHERE` em todos os leitores por nota.
- **D-N28 (MEDIUM-2)** — K só vira N depois da CARÊNCIA (`lastEventAgeMinutes ≥ IN_FLIGHT_MINUTES` = 10, idade no
  banco): 5 s após um timeout o fisco pode ainda estar processando o pedido — "ambíguo não é N", mesma lição do
  "ambíguo não é F". Antes da carência a consulta só marca "nós olhamos". A parte "recusa do fisco 'já cancelada' dispara
  refresh antes do 409" fica para a 1ª sessão real (o código E-xxxx é [INCERTO]) — **Q-N28b**.
- **D-N29 (MEDIUM-3)** — sem procuração (D-N12) o A1 tem que ser do CNPJ do EMITENTE: a porta do cofre
  (`storeIssuerCertificate` com `expectedCnpj` = CNPJ da institution) recusa CN com CNPJ diferente (409
  `FISCAL_CERT_INVALID` no campo `pfx`). CN sem o padrão ICP-Brasil (sem 14 dígitos) entra — não há como comparar.
- **D-N30 (MEDIUM-4)** — falha de credencial LOCAL (par PEM não abre/não casa, `ERR_OSSL_*` antes de qualquer byte
  chegar ao fisco — ex.: cert novo + key velha numa corrida de upload) NÃO é voz do fisco: 409 `FISCAL_CERT_INVALID`
  (authorityStatus 0), outcome `local` na composição = NADA gravado na nota (a reserva reconcilia como as demais);
  F fica só para 401/403 do fisco. `writeSecret` grava por tmp + rename (nunca arquivo pela metade); a troca dos
  DOIS arquivos continua não atômica — o 409 sem voz é o que contém o dano.
- **L5** kinds numa fonte só (`transmission-kinds.ts`); **L6** lote pára também em 409 do EMISSOR (sem habilitação,
  sem certificado, vencido, par inválido) — `STOPS_THE_BATCH`.
Ficam registrados sem correção (LOW): L1 ordem de locks no plano do cancelamento fiscal (retry cobre); L2 coalescência em
memória morre com 2 instâncias (Onda 4 — o lock da nota é a segurança real); L3 exigir `infEvento/@Id` quando a 1ª
sessão confirmar o envelope (parcialmente coberto: aceite exige Id OU dhProc); L4 `readNfseXml`/view passam por
`buildEmitter` (exige simples_regime/IBGE) — só precisam do CNPJ; L7 rotas GET `/fiscal/:orderId`, `/xml`, `/danfse` só
com a flag billing (o XML carrega dados do tomador); L8 `vServ = total_value` coincide com `base_iss_value` HOJE — cinto
422 se divergirem quando dedução/redução entrar no cálculo; L9 → Q-N31; L10 UNIQUE (kind, dh) com NULL.
**Questões para o Valdo**: **Q-N26** nota faturada com `municipal_code` do legado ('0102', congelado no ramo) não transmite
até corrigir a regra e refaturar — aceitar, ou permitir editar o código municipal do ramo? · **Q-N27** confirmar a coluna
`invoice_event` (alternativa: filtrar por `created_at` > último E — frágil) · **Q-N28** carência de 10 min para o N +
**Q-N28b** (recusa "já cancelada" dispara reconciliação) · **Q-N29** confirmar a recusa do A1 de outro CNPJ (e-CPF entra
hoje — o CN não traz 14 dígitos) · **Q-N30** confirmar "falha local = 409 sem voz" · **Q-N31** contador do nDPS por
ambiente (zera ao trocar H→P) ou contínuo? — junta-se à Q-N25 · **Q-N32** L7: gate de privilégio nas leituras fiscais?

### 10.5 Gate adversarial — rodada 2 **0.64 ✗** (2026-09-28) → R2-1…R2-5 CORRIGIDOS em sessão
`onda3-adversarial-r2.test.ts` (37 testes: 14 provas de bug → agora 37/37; 23 provas positivas: corridas transmit ×
cancel × refresh serializadas, lote com orçamento estourado no meio, consulta ativa com 502 repetido, nota
soft-deletada + C pendente, efeito recusado → transitório → aplicado, PKCS#12 com dois válidos). Família do que sobrou:
"o fisco respondeu, mas respondeu AO QUE EU PERGUNTEI?" — o adaptador aceitava envelope bem formado sem conferir
chave, tipo do evento ou Id do DPS contra o pedido.

| # | Sev. | Achado | Correção |
|---|---|---|---|
| R2-1 | MEDIUM | `registerEvent` aceitava o ECO do próprio pedido (pedRegEvento tem e101101 + dhEvento), evento gerado de OUTRA chave ou de OUTRO tipo → C + `cancelInvoice` sem voz (mesmo efeito do ACHADO 1). | Aceite = evento GERADO (`infEvento/@Id` EVT… OU `dhProc`) + `eventCode` = e101101 + `chNFSe` = chave pedida (`isGeneratedEventFor`). |
| R2-2 | MEDIUM | Chave com 50 dígitos porém DIFERENTE da pedida passava; `infDPS/@Id` embutido na NFS-e nunca era comparado com o DPS enviado; `/eventos` cancelava por e101101 de outra chave. | `transmit`: chave JSON × chave XML × `Id` do DPS enviado (`sentDpsIdOf`); `queryNfse`: chave do XML = pedida, eventos filtrados pela chave; a composição confere `parsed.dpsId` = `target.dpsId` na consulta antes de gravar (502, nem "nós olhamos"). |
| R2-3 | MEDIUM | Consulta ativa não parava em AUTH_FAILED: N handshakes e N notas "olhadas" sem nada aprendido. | `stopsTheRun` inclui AUTH_FAILED e FISCAL_CERT_INVALID (sem `touchQueriedAt`). |
| R2-4 | LOW | Certificado AINDA NÃO VIGENTE (notBefore amanhã) entrava no cofre e abria o emissor. | `certificateInfo.notYetValid`; upload, `openIssuer` e "habilitado" recusam (409). |
| R2-5 | LOW | `municipal_code` "1-2-3"/"12 3"/"1.2.3" virava cTribMun "123" (normalização em fato fiscal). | Conferência do VALOR trimado com `/^\d{3}$/`. |

Fixtures de testes anteriores atualizados para os contratos novos (K→N com carência, Id do DPS na NFS-e do adaptador,
7º argumento do `insertTransmission`). Suíte **1328/1328** · tsc limpo · app analyze limpo 143/143 · trilha 21 OK · 3
PENDENTE · 0 FALHA (re-executada após o retrabalho; migration 061 aplicada no dev pelo boot do servidor).

### 10.6 Re-score FINAL (2026-09-28): socrático **0.74 ✅** · adversarial R3 **0.58 ✗ → 7 achados CORRIGIDOS em sessão**
**Socrático 0.74 — PASSA** (≥ 0.70, nenhum CRITICAL/HIGH): as 10 correções da rodada 2 conferidas item a item no código;
regressões procuradas e descartadas (leitor pela chave × reserva interrompida/cancel; `LIFE_WHERE` × consulta ativa; vidas
com `invoice_event` NULL = só nota sincronizada, que `assertTransmittable` já recusa; chNFSe formatado normalizado). Sobraram
2 MEDIUM, EXECUTADOS em sessão como assunção (recomendação do gate):
- **M1 (Q-N34 a)** — os leitores de EVENTO e o contador de pendência não filtravam por VIDA (metade da D-N27): C do fisco
  com efeito recusado numa vida anterior ficava órfão para sempre e a tela contava pendência numa nota sã. Agora eventos e
  `countPendingEffects` passam pela transmissão (`JOIN` + `LIFE_WHERE`) e o cancelamento manual pela rota GENÉRICA
  (`POST /billing/cancel`) liga a pendência da voz C ao C que ele produz — espelho do que a rota fiscal já fazia.
- **M2 (Q-N33)** — transmit aceitava nota com voz C do fisco e efeito local PENDENTE: 2ª tentativa reenviava o MESMO Id de
  DPS (fisco ecoa a NFS-e cancelada → chave repetida no UNIQUE → 500; timeout → órfã). Agora 409 `FISCAL_EFFECT_PENDING`
  no gate da reserva até a pendência resolver.
- **LOW-A** — consulta ativa e lote param pelo MESMO critério (`EMITTER_FAILURE_CODES` em `branches/service.ts`: fisco
  indisponível, credencial recusada, par local inválido, emissor sem habilitação/certificado/vencido) e sem marcar "nós
  olhamos" quando o fisco não foi chamado.
- Registrados sem correção: LOW-B/R3-6 (fechado abaixo), LOW-C chave do evento só por `chNFSe` (se o envelope real
  trouxer a chave só no Id EVT, a 1ª sessão crava — fallback pela chave embutida no Id junto com L3), LOW-D → **Q-N30b**,
  LOW-E → Q-N29 (reforço: recusar CN sem CNPJ para o modelo SE?).

**Adversarial rodada 3 (`onda3-adversarial-r3.test.ts`, 35 testes: 13 provas de bug → agora 35/35 · 22 provas
positivas: contornos de `isGeneratedEventFor`, dois `infDPS`, `id=` minúsculo, NULL na idade do K, toque manual não
adianta o N, consulta ativa pára em CERT_INVALID, TypeError cru continua ambíguo, lote com 409 local vindo do
adaptador, corridas transmit × refresh com a vigente ≠ última):**
| # | Sev. | Achado | Correção |
|---|---|---|---|
| R3-1 | **HIGH** | Tentativa ÓRFÃ: 1 → F (404 eventual do `/dps`); 2 reusa o nDPS, o fisco GERA a NFS-e mas a resposta se perde; reconciliação acha a chave e a põe na 1 ("a mais antiga sem chave"); a 2 fica em voo sem voz PARA SEMPRE — invisível ao leitor único (D-N26), nunca reconciliada, listada em 1º lugar em TODA passada da consulta ativa (com 8 órfãs a vigilância D-N21 morre em silêncio). | `findTransmissionByDpsId` prefere quem JÁ detém a chave (idempotente; nunca a mesma chave em duas linhas); `refreshServiceTransmission` ganhou `opts.attempt` (reserva interrompida e rodízio da consulta ativa olham a PRÓPRIA tentativa); quando a tentativa que perguntou está em voo e a NFS-e pertence a outra, ela é encerrada com **F "envio reconciliado"** (voz da consulta) e sai do rodízio; chave diferente da que o Id já tem → 502, nada gravado. |
| R3-2 | MEDIUM | D-N30 só chegou ao transmit: credencial LOCAL no pedido de cancelamento gravava K "enviado sem resposta" (fato falso). | `cancelServiceInvoiceAtAuthority`: outcome `local` sobe sem K. |
| R3-3 | MEDIUM | O adaptador conhecia 2 dos 4 cancelamentos do XSD: **e105104** (deferido por análise fiscal — o único caminho fora do prazo municipal) e **e305101** (de ofício) deixavam a NFS-e "autorizada" aqui. | `CANCEL_EVENT_CODES` (101101 · 105102 · 105104 · 305101) em `dps-builder.ts`, consumido pelo adaptador. |
| R3-4 | MEDIUM | D-N29 deixava passar o **e-CPF** (CN "NOME:CPF" não tem 14 dígitos → "não há como comparar"). | `cpfFromSubject`: e-CPF com `expectedCnpj` → 409 `FISCAL_CERT_INVALID` ("sem procuração o A1 tem que ser o e-CNPJ do emitente"). |
| R3-7 | MEDIUM | D-N30 ficou no TRANSPORTE: chave ilegível no cofre estourava cru em `signXml` (`ERR_OSSL_UNSUPPORTED`) → 500 por nota no transmit, no cancelamento e no lote (`code: null` não parava). | `openIssuer` valida a CHAVE ao abrir (`validatePrivateKeyPem` → 409); `signLocal` traduz erro local da assinatura em 409 `FISCAL_CERT_INVALID`; o lote pára pelo `EMITTER_FAILURE_CODES`. |
| R3-5 | LOW | `cnpjFromSubject` atravessava a RDN: CN sem CNPJ + `OU=AR X:99887766000155` atribuía o CNPJ da OU ao titular. | `cnValueOf`: só o VALOR da RDN CN é lido (CNPJ e CPF). |
| R3-6 | LOW | Consulta aceitava NFS-e SEM identidade (nem Id do infNFSe nem do infDPS) como a da chave pedida — um `<e101101>` dentro virava C irreversível. | `queryNfse`: sem nenhuma identidade → 502 (régua da R2-2). |
Mantido como está, com questão: **Q-N30b / Q-R3.1** — falha de credencial LOCAL no transmit deixa a reserva em voo (nova
tentativa dá 409 IN_PROGRESS até os 10 min; a reconciliação fecha com F "sem resposta" embora o fisco não tenha sido
chamado). Rec. dos dois gates: fechar na hora com F "credencial local" — decisão do Valdo; com o R3-7 (chave validada
antes de reservar) o caso vira corrida rara. Fixado como prova positiva no r3.
**Rótulo do ambiente H (Valdo, 2026-09-28)**: "Produção restrita" → **"Homologação"** na tela (pt/en) e na mensagem da
API; o código continua `H` (tpAmb 2 do fisco, que o chama de "produção restrita").
**D-N31 (Valdo, 2026-09-28) — UM certificado A1 por estabelecimento**: "o certificado usado é o mesmo para produção e
para testes, mantenha apenas 1 na hora de carregar o A1". A metade "o A1 é do AMBIENTE" da D-N6 cai; a outra metade
(o HOST do fisco fica congelado por tentativa — a consulta de uma tentativa nascida em H fala com H mesmo com o emissor já
em P) permanece. Peça: `issuerSecretRef(schema, institution, name)` sem ambiente (pasta `P` fixa —
`ISSUER_SECRET_ENVIRONMENT`; `secretEnvironmentOf` morreu), `issuerCertificateStatus`/`storeIssuerCertificate`/
`clearIssuerCertificate` sem ambiente, `authorityContextFor` usa sempre o par aberto. API: `GET /issuer` devolve
`certificate` (singular) no lugar de `certificates.{H,P}`; `PUT/DELETE /api/establishment/issuer/certificate` (sem
`/:environment`); `enabled` de cada modelo = linha + o único par vigente. App: um bloco de certificado na aba Emissor
fiscal (sem escolha de ambiente), `certificate` singular na entidade, `notYetValid` na validade. Testes reescritos onde
provavam a D-N6 do certificado ((7b) do adversarial R1 virou prova positiva: tentativa em H consultada com o mesmo par;
`fiscal-issuer.test.ts` "o par de H não serve a P" virou "cofre vazio → CERT_MISSING; linha em P abre com o único A1").
Sem DDL. Implantação: quem já tinha par em `S` (H) precisa reenviar o .pfx (o dev não tinha).
Questões abertas da fase para o Valdo: **Q-N17…Q-N24** (assunções do §10.1), **Q-N19a**, **Q-N25**, **Q-N26…Q-N32**
(§10.4), **Q-N33/Q-N34** (executadas como assunção — confirmar), **Q-N30b/Q-R3.1**.
Estado final: suíte **1363/1363** api · tsc limpo · app analyze limpo **148/148 (analyze limpo)** · trilha **21 OK · 3 PENDENTE · 0 FALHA (P8b = código municipal da regra de ISS)**.

## 11. ⚠️ Rodada 2 — questões consolidadas para o Valdo (2026-09-28; recomendação entre parênteses)

Tudo o que está EXECUTADO como assunção segue valendo até resposta; "concordo" fecha, divergência reverte.

### 11.1 Assunções do retrabalho socrático (§10.1) — confirmar ou reverter
- **Q-N17** kind **N** ("pedido de cancelamento não consta no fisco") devolve a NFS-e a AUTORIZADA e libera novo pedido. (**Rec.: manter** — a alternativa era reusar A com outro dh, fato falso.)
- **Q-N18** contador do nDPS no EMISSOR (`dps_last_number`), contínuo mesmo trocando a série; revive zera `dps_number` (nova vida = novo nDPS). (**Rec.: manter.**)
- **Q-N19** `simples_regime` NULL no emitente = 422, nunca default "não optante". (**Rec.: manter.**)
- **Q-N19a** → **RESPONDIDA pelo Valdo (2026-09-28): SIM, a Setes é ME/EPP (opSimpNac 3) — D-N19a EXECUTADA.** Fato do
  XSD (tiposComplexos v1.01): `regApTribSN` é OPCIONAL e serve ao ME/EPP que ULTRAPASSOU sublimite/limite (1 federais e
  municipal pelo SN · 2 federais pelo SN e ISSQN por fora · 3 tudo por fora); ausente = o fisco apura pelo SN. Executado:
  migration **062** `tb_entity_tax.simples_assessment` (espelho no sql/03), peça entity-tax + módulo establishment
  (`simplesAssessment`, limpo automaticamente quando o regime deixa de ser 3), `buildEmitter` só emite o elemento com
  opSimpNac 3 e valor informado (NULL = omitido — ausência do fato prevista no XSD, não default), app: dropdown "Apuração
  no Simples (sublimite)" visível só com ME/EPP, i18n pt/en. Dev: institution 1 gravada com `simples_regime = '3'`,
  apuração NULL (dentro do sublimite) — o Valdo confirma na aba Tributação se ultrapassou.
- **Q-N20** `liability` (tribISSQN) derivada da exigibilidade do EMITENTE; override por regra de ISS = futuro. (**Rec.: manter.**)
- **Q-N21** consulta ativa vigia A a cada 24 h e retenta C pendente a cada 15 min. (**Rec.: manter.**)
- **Q-N22** consultas exigem o privilégio TRANSMITIR do ramo (quem consulta pode disparar efeito local). (**Rec.: manter.**)
- **Q-N23** `dCompet` = data de emissão nesta onda. (**Rec.: manter até rejeição real por competência.**)
- **Q-N24** `dps_description_format` consumido no billing de venda; OS = itens. (**Rec.: manter.**)
- **Q-N25** reinício do nDPS por série? (**Rec.: NÃO — numeração contínua; o Id inclui a série, sem colisão.**)

### 11.2 Questões do re-score socrático (§10.4) e das rodadas adversariais
- **Q-N26** nota já faturada com `municipal_code` do legado ("0102") NÃO transmite até corrigir a regra de ISS e refaturar. (**Rec.: aceitar — e, na implantação, deixar o código municipal VAZIO quando o município não exigir; o campo é opcional no DPS. Hoje no dev: regra 2 → vazio.**)
- **Q-N27** coluna `invoice_event` na transmissão (vida da nota) — EXECUTADA (migration 061). (**Rec.: confirmar.**)
- **Q-N28** carência de 10 min para K virar N — EXECUTADA. (**Rec.: confirmar.**)
- **Q-N28b** recusa do fisco "já cancelada" no 2º pedido dispara a reconciliação (refresh) antes do 409? (**Rec.: sim, na 1ª sessão real, quando o código E-xxxx for conhecido.**)
- **Q-N29** A1 tem que ser do CNPJ do emitente; e-CPF recusado; CN sem os 14 dígitos entra. (**Rec.: confirmar; reforço = recusar CN sem CNPJ para o modelo SE — fail-closed.**)
- **Q-N30** falha de credencial LOCAL = 409 sem voz F — EXECUTADA. (**Rec.: confirmar.**)
- **Q-N30b / Q-R3.1** falha local no transmit deixa a reserva em voo 10 min (nova tentativa dá 409 IN_PROGRESS; a reconciliação fecha com F "sem resposta"). (**Rec. dos dois gates: fechar NA HORA com F "credencial local do emissor" — o fisco comprovadamente não foi chamado.**)
- **Q-N31** contador do nDPS por ambiente (zera ao ir de H para P) ou contínuo? (**Rec.: contínuo — NFS-e não tem inutilização e o Id inclui tpAmb pelo ambiente da tentativa, não pelo número; simples e sem risco.**)
- **Q-N32** leituras fiscais (`GET /fiscal/:orderId`, `/xml`, `/danfse`) só com a flag billing — o XML carrega dados do tomador. (**Rec.: gate pelo acesso à INTERFACE do ramo (orders/service-orders), sem privilégio novo.**)
- **Q-N33** transmit recusa nota com voz C do fisco e efeito local pendente (409 `FISCAL_EFFECT_PENDING`) — EXECUTADA. (**Rec.: confirmar.**)
- **Q-N34** cancelamento manual pela rota genérica liga a pendência da voz C; eventos e pendências filtram por vida — EXECUTADA. (**Rec.: confirmar.**)

### 11.3 Registrados sem correção (LOW) — decidir se entram nesta onda
- **L3/LOW-C** exigir `infEvento/@Id` no aceite e aceitar a chave embutida no Id EVT. (**Rec.: na 1ª sessão real, quando o envelope for conhecido.**)
- **L4** XML/DANFSe passam por `buildEmitter` (exigem simples_regime/IBGE) — só precisam do CNPJ. (**Rec.: corrigir agora, é pequeno.**)
- **L8** cinto 422 quando `vServ ≠ base_iss_value` (hoje coincidem). (**Rec.: corrigir agora.**)
- **L2** coalescência em memória com 2 instâncias. (**Rec.: Onda 4.**)
- Cópia órfã do A1 em `secrets/setes_setes/establishment/1/S` (pasta antiga de H). (**Rec.: apagar.**)

### 11.4 Rodada 2 DECIDIDA e EXECUTADA (Valdo, 2026-09-28 — "siga as recomendações")
**Confirmadas sem mudança (viram decisão)**: Q-N17→D-N17 · Q-N18→D-N18 · Q-N19→D-N19 · Q-N20→D-N20 · Q-N21→D-N21 ·
Q-N22→D-N22 · Q-N23→D-N23 · Q-N24→D-N24 · **Q-N25→D-N25 numeração do nDPS NÃO reinicia por série** · Q-N27→D-N27 ·
Q-N28→D-N28 · Q-N30→D-N30 (metade "409 sem voz do fisco") · **Q-N31→D-N31b contador do nDPS CONTÍNUO de H para P**
(não zera; o Id inclui o ambiente pela tentativa) · Q-N33→D-N33 · Q-N34→D-N34 · L2 fica para a Onda 4 · L3/LOW-C e
Q-N28b ficam para a 1ª sessão real (envelope do evento e código E-xxxx de "já cancelada").
**Executadas em sessão**:
- **Q-N26 → D-N26b**: nota já faturada com código municipal fora da forma NÃO transmite até corrigir a regra e refaturar
  (aceito). Implantação: código municipal VAZIO quando o município não exigir (opcional no DPS). Dev: regra de ISS 2
  gravada com `municipal_code = NULL` — a próxima corrida da trilha fatura sem o "0102".
- **Q-N29 reforço → D-N29b**: fail-closed — CN sem os 14 dígitos do padrão ICP-Brasil ("RAZÃO SOCIAL:CNPJ") não é
  e-CNPJ → 409 `FISCAL_CERT_INVALID` "não é um e-CNPJ" (soma-se ao e-CPF e ao CNPJ divergente). Só entra sem comparar
  quando não há `expectedCnpj` (uso de peça). Provas do R3-5/P6 e da rework-r2 mudaram de sentido.
- **Q-N30b / Q-R3.1 → D-N30b**: falha de credencial LOCAL no transmit fecha a tentativa NA HORA com **F "credencial
  local"** (source P) — o fisco comprovadamente não foi chamado; nada fica em voo, o reenvio com o cofre corrigido vai
  ao fisco. `OUTCOME_KIND.local = 'F'`. Provas P5/P7 do R3 e D-N30 da rework-r2 mudaram de sentido.
- **Q-N32 → D-N32**: leituras fiscais (`GET /fiscal/:orderId`, `/xml`, `/danfse`) passam por `requireInterfaceFor`:
  a interface do RAMO resolvida por requisição tem que estar no contrato da institution (`tb_institution_has_interface`
  ativa); admin passa; 403 `INTERFACE_NOT_ALLOWED`. Sem privilégio novo (não existe acesso por usuário a interface no
  modelo — o contrato é da institution).
- **L4**: XML/DANFSe/tela leem só o CNPJ do emitente (`emitterCnpj`) — limpar a aba Tributação não torna um XML já
  autorizado ilegível.
- **L8**: 422 `FISCAL_DPS_INVALID` (campo `baseIss`) quando, com ISS tributável, a base congelada ≠ valor do serviço —
  o DPS não tem campo de base; cinto para quando dedução/redução entrar no cálculo.
- Cópia órfã do A1 em `secrets/setes_setes/establishment/1/S` APAGADA (o par vigente está em `P`, único — D-N31).
**Nenhuma questão da Onda 3 fica aberta.** Próximo passo = 1ª transmissão REAL da nota da OS em homologação (o A1 da Setes
já está no cofre; regra de ISS corrigida): roda pela trilha (P8b) ou pela tela "No fisco" — é ato externo, dispara com o
"vai" do Valdo; é ela que crava os [INCERTO] (envelope JSON, `erros[]`, `/convenio`, sha1×sha256, 201×200, Id do evento).

## 12. 1ª SESSÃO REAL com o e-CNPJ da Setes — homologação (2026-09-28, "vai" do Valdo)

Trilha P8b transmitiu a nota da OS 8011 (nº 6790/1, SE, R$ 250) para `sefin.producaorestrita.nfse.gov.br` com o
A1 real (CN …:07742094000113, vence 08/10/2026). **O fisco RESPONDEU**: HTTP 400 com

> `E0116: A IM deve ser informada para o emitente prestador do serviço na DPS, conforme informações complementares
> registradas no CNC NFS-e do município emissor informado na DPS.`

Gravado como manda a peça: tentativa 1 em H, `dps_id` DPS4106902 2 07742094000113 00001 …0002, voz **R** source P com
`authority_code = E0116` e a frase do fisco, `invoice_event = 1` (vida da nota), DPS assinado em
`storage/07742094000113/2026/09/…-dps.xml`. `tb_company.im` da Setes = NULL → o DPS saiu sem `<IM>` (opcional no XSD, mas
o CNC NFS-e de Curitiba o exige). **Tarefa do Valdo: informar a Inscrição Municipal no Meu Estabelecimento e
retransmitir** (a 2ª tentativa reusa o nDPS — D-N3 — e ganha um Id novo só se a nota for refaturada).

**[INCERTO] do §9 CRAVADOS pela resposta real:**
- mTLS com o e-CNPJ A1 real: handshake ACEITO (o 403 da sonda era só o autoassinado).
- Envelope do POST /nfse: `{ "dpsXmlGZipB64": … }` ENTENDIDO pelo fisco (ele leu o DPS por dentro — a crítica é semântica).
- Rejeição: HTTP **400** com `erros[]` = `[{ codigo: 'E0116', descricao: '…' }]` — `authorityRejections` extraiu código e
  frase sem ajuste; `firstAuthorityCode` gravou `E0116` em `authority_code`.
- Assinatura XMLDSig (sha1, C14N inclusive, enveloped): NÃO rejeitada — a crítica E0116 vem de regra de negócio, depois
  do XSD; fica confirmada como "não é o algoritmo errado" (a confirmação definitiva é a 1ª AUTORIZAÇÃO).
- `PENDENCIA_FISCO` da trilha ganhou `FISCAL_DPS_REJECTED`: rejeição do fisco por cadastro é PENDENTE com a frase dele.
Ainda [INCERTO] até a 1ª autorização: nomes do JSON de resposta 2xx (`nfseXmlGZipB64`, `chaveAcesso`), 200×201, formato
do `GET /nfse/{chave}/eventos`, envelope do evento gerado (Id EVT, dhProc), `/parametros_municipais/…/convenio`.
**IM informada pelo Valdo (2026-09-28): "01 06 501.367-7"** → gravada em `tb_company.im` como `01065013677` e retransmitida
(tentativas 2–7 da nota 8011): o fisco repetiu **E0116** para TODAS as formas tentadas (`01065013677` · `01 06 501.367-7` ·
`0106501367-7` · `01.06.501.367-7` · `1065013677`). Leitura do Anexo I (regra do E0116): o CNC NFS-e de Curitiba TEM
registro complementar da Setes (senão o erro seria "IM não deve ser informada"), e a IM da DPS precisa bater EXATAMENTE
com a registrada lá — nenhuma das formas bateu. **Pendência do Valdo**: conferir no Portal Nacional NFS-e (CNC → dados
complementares do município, login gov.br/e-CNPJ) ou no ISS Curitiba qual string está registrada — em produção
restrita o CNC pode divergir do de produção. `<IM>` vai dentro de `<prest>` logo após `<CNPJ>` (ordem do XSD conferida).
**Passeio no Portal Nacional (Claude in Chrome, sessão do Valdo, 2026-09-28)** — `nfse.gov.br/EmissorNacional` (PRODUÇÃO):
as 5 NFS-e que o Valdo emitiu hoje pelo portal mostram **"Inscrição Municipal: -"**, "ME/EPP", "Base de cálculo 0,00 ·
Alíquota 0,00 · ISSQN 0,00 · 1 - Não retido", NFS-e gerada (cStat 100). Ou seja: **em produção o CNC de Curitiba NÃO exige
IM da Setes** — o E0116 é da PRODUÇÃO RESTRITA, cujo CNC é outra base (registro complementar com uma IM que nenhuma das 9
formas tentadas bateu: `01065013677` · `01 06 501.367-7` · `0106501367-7` · `01.06.501.367-7` · `1065013677` ·
`0106501367` · `010650136770` · `106501367`). O portal do contribuinte da produção restrita (`producaorestrita.nfse.gov.br/
EmissorNacional`) devolve página de erro / redireciona para gov.br/nfse — sem como ler o CNC de homologação por aqui.
**Consequência para a Onda 3**: o pipeline até o fisco está provado; a autorização em homologação depende de Curitiba/ISS
Curitiba informar a string do CNC de produção restrita (ou de a produção ser o 1º ambiente de autorização, quando a
próxima cobrança real da Setes for faturada por aqui — decisão do Valdo, **Q-N35**). `tb_company.im` fica `01065013677`
(inofensivo em produção: sem registro complementar, o Anexo I manda NÃO informar — **atenção**: regra E0118-família "IM não
deve ser informada" pode disparar em produção; ver Q-N35).
**Achado do passeio que vale para PRODUÇÃO (executado)**: Anexo I **E0625/E0621** — para ME/EPP com ISSQN apurado PELO
Simples (regApTribSN 1/omitido), município conveniado e SEM retenção, `pAliq` é PROIBIDA (o ISS vai no DAS — é o "alíquota
0,00" das notas do portal); COM retenção é obrigatória (≥ 1,8 %). `buildDpsBase` passou a omitir `pAliq` nesse cenário
(`issInDas`); apuração por fora (2/3) ou não optante seguem com a alíquota da regra. Teste na `onda3-gate-rework-r2`.
**Q-N35 (Valdo)**: em produção, mandar `<IM>` ou não? O portal não manda (CNC sem registro). Rec.: NÃO mandar quando o
município não tiver registro complementar — como não há consulta ao CNC pela API, a forma segura é `tb_company.im`
VAZIO para a Setes em produção (a NFS-e sai como as do portal) e IM só quando o município exigir.
**Cadastro do ISS Curitiba (PDF "Consulta de Dados Cadastrais", emitido 28/09/2026 22:36, enviado pelo Valdo)**: F. D. SOUZA
DESENVOLVIMENTO E LICENCIAMENTO DE PROGRAMAS · CNPJ 07.742.094/0001-13 · **Inscrição Municipal 01 06 501.367-7** (confirma o
número) · R. Faustino Jacob Stofella 28, Alto Boqueirão, CEP 81770-090 · início 30/09/2005 · situação ATIVA · alvará
001.225.245 (25/05/2015) · **Simples Nacional desde 01/01/2018** · atividades C.18.3.0-0/03.00, J.62.0.2-3/00.00,
J.62.0.3-1/00.00 (desenvolvimento e licenciamento de programas — item 1.02/1.05 da LC 116). Conclusão: o número que
enviamos ao fisco É a IM real; a divergência está no CNC da produção restrita (base de teste da Sefin/Curitiba), não no
cadastro da Setes. Tentativas extras com o número do alvará (001225245 · 1225245 · 001.225.245) registradas abaixo.
Resultado das 3 formas do alvará: **E0116 nas três** (12 formas ao todo). `tb_company.im` restaurada para `01065013677`.
**Estado ao fechar a sessão (2026-09-28)**: pipeline até o fisco PROVADO; 1ª AUTORIZAÇÃO depende de (a) Curitiba/Sefin
informar a IM carregada no CNC da produção restrita, ou (b) Q-N35 = autorizar em PRODUÇÃO com a próxima cobrança real
(sem IM e sem alíquota, como o portal fez hoje). Nota 8011 do dev: 13 tentativas R (E0116), todas em homologação.

## 13. 1ª SESSÃO em PRODUÇÃO — Q-N35 e Q-N36 decididas (2026-09-29, Valdo)

**Q-N35 → (b), Valdo**: "pode transmitir sem a IM, faremos o teste em produção". O Valdo trocou o emissor SE para
**P** e limpou `tb_company.im` pela tela (o agente não altera configuração fiscal por SQL — negado pelo classificador
e correto: a troca leva a próxima transmissão ao fisco real). OS 7374 / nota 6790 (pedido 8011, K2) em produção:
- tentativa 14 (IM ainda preenchida) → **E0120** "IM do prestador não deve ser informado, pois não existem informações
  complementares registradas no CNC NFS-e do município" — espelho do E0116 da homologação; confirma que em PRODUÇÃO a
  Setes não tem registro complementar no CNC de Curitiba: `<IM>` vai VAZIO (tb_company.im NULL).
- tentativa 15 (sem IM) → **E0166** "É obrigatório o preenchimento do campo de regime de apuração dos tributos do SN
  para o optante do Simples Nacional ME/EPP". mTLS, envelope e leitura do DPS em produção CRAVADOS.

**Q-N36 — DECIDIDA e EXECUTADA ("vai", Valdo 2026-09-29): D-N19a CORRIGIDA.** A premissa "regApTribSN NULL = dentro
do sublimite, elemento omitido (opcional no XSD)" MORREU com o E0166: para opSimpNac 3 o elemento é OBRIGATÓRIO.
Conhecimento negativo — ninguém volta a "simplificar" para omitido: o XSD mente por omissão, a regra de negócio da
Sefin exige.
- Peça `branches/service.ts` (identidade do emitente): regime 3 sem apuração → **422 FISCAL_EMITTER_INCOMPLETE**
  `fields[simplesAssessment]` ANTES de reservar tentativa (molde da D-N19); `issInDas` passa a exigir
  `regApTribSN === '1'` explícito (o `?? '1'` era o eco da premissa morta).
- Módulo `establishment`: PUT com estado RESULTANTE regime 3 sem apuração → **422 REQUIRED_FIELDS** no campo, antes
  de gravar qualquer parte (o que valida é o que grava); sair do regime 3 segue limpando a apuração.
- App (Meu Estabelecimento → Tributação): opção "Dentro do sublimite (não informar)" REMOVIDA (chave i18n
  `simplesAssessment0` apagada; placeholder = "Não informado", estado a corrigir); pendência local obrigatória no
  campo com regime 3 — espelho da API. Rótulo "Apuração no Simples".
- Setes: apuração **1** (federais e ISS pelo Simples — como as notas do portal: alíquota 0,00, ISS no DAS; `pAliq`
  segue omitida sem retenção, E0625/E0621).
- Testes: fixtures de emitente ME/EPP ganharam `simplesAssessment: '1'`; teste do 422 local + dois do save.
  **1371/1371 api · 148/148 app · analyze limpo.**

**Junto (pedido do Valdo na mesma sessão): nº da nota + selo fiscal na lista de OS faturadas.** A lista não permitia
achar a OS do teste (avatar = nº da OS; o "8011" era o id do pedido). `GET /api/service-orders` devolve
`invoiceNumber`, `fiscalState` (none|in_flight|authorized|rejected|failed|cancelled|cancel_in_flight; null = aberta ou
nota da origem, sem evento E na web), `fiscalEnvironment`, `nfseNumber`. O selo vem do MESMO leitor do detalhe: nova
`currentTransmissionsOf` (lote, vida vigente D-N27, escolha pelo `currentOf` D-N26) + `getServiceFiscalSummaries`
(`fiscalStateOf`) — sem 2ª cópia da regra em SQL. Filtro só com dígitos acha pelo nº da OS ou da nota (igualdade).
Homologação sinalizada no selo ("· Homologação"). Nada commitado.

### 13.1 Q-N37 — total aproximado de tributos (Lei 12.741) — DECIDIDA e EXECUTADA ("vai", Valdo 2026-09-29)

Tentativa 16 (apuração 1 já gravada) → **E0712** "Para ME/EPP o indicador de informação de valor total de tributos não
pode ser informado". O DPS mandava SEMPRE `totTrib/indTotTrib=0` — válido SÓ para MEI. Matriz do Anexo I (RN do
`totTrib`, linhas 538–541):

| opSimpNac | indTotTrib=0 | pTotTribSN | vTotTrib / pTotTrib (por esfera) |
|---|---|---|---|
| 2 MEI | ✅ | ❌ E0710 | ✅ |
| 3 ME/EPP | ❌ E0712 | ✅ | ✅ |
| 1 não optante | ❌ E0713 | ❌ E0713 | ✅ |

Decisão (recomendação aceita): **ME/EPP → `pTotTribSN` = % aproximado da alíquota EFETIVA do Simples (DAS)**, fato do
emitente em `tb_entity_tax.simples_total_tax_aliquot DECIMAL(5,2)` (migration **063**; TSDec2V2 ⇒ 0,01–99,99, > 0 —
declarar 0 seria falso para o tomador); MEI segue `indTotTrib=0`; **não optante = 422 honesto "ainda não suportado"**
(decidir valor/percentual por esfera com o 1º cliente assim). Nunca `0,00` para passar na validação.
**Valor da Setes = 6,00 %** — derivado do DAS de 08/2026 (PGDAS-D, R$ 713,41): a repartição IRPJ 4,00 · CSLL 3,50 ·
COFINS 12,82 · PIS 2,78 · CPP 43,40 · ISS 33,50 % bate EXATAMENTE com a faixa 1 do Anexo III (faixa 2 já seria COFINS
14,05 / ISS 32,00), onde a efetiva = nominal (sem parcela a deduzir); receita implícita ≈ R$ 11.890. Revisar quando o
RBT12 mudar de faixa (o contador informa).
Guardião: fato do EMITENTE, irmão de simples_regime/simples_assessment — não é peça nova; histórico congelado em cada
DPS transmitido; o irmão futuro (percentual por esfera do não optante) AGREGA colunas, não reforma.
- Peça `branches/service.ts`: nova `emitterDpsFacts(prest, aliquot)` — obrigações do DPS por regime (Q-N36 apuração +
  Q-N37 totTrib) SAÍRAM do `buildEmitter`: o cancelamento também lê o emitente, e uma NFS-e autorizada não pode deixar
  de ser cancelável porque alguém limpou a aba Tributação (corrige o 422 que a Q-N36 tinha posto no leitor comum).
- Módulo `establishment`: DTO (> 0, ≤ 99,99, 2 casas), 422 REQUIRED_FIELDS no estado resultante com regime 3, sair do
  regime 3 limpa apuração e %; Swagger do GET/PUT com os fatos do emitente.
- App (Tributação): campo "% aproximado de tributos do Simples" (texto com vírgula/ponto, dica "alíquota efetiva do
  DAS"), obrigatório e validado localmente com regime 3 — espelho da API.
- **1377/1377 api · 149/149 app · analyze limpo · migration 063 aplicada no dev.** Nada commitado.

### 13.2 🎉 1ª AUTORIZAÇÃO em PRODUÇÃO (2026-09-29 23:33:44)

Tentativa 17 da OS 7374 / nota 6790 (pedido 8011), após informar apuração 1 e 6,00 % na aba Tributação: **NFS-e nº 704**,
chave `41069022207742094000113000000000070426093703546385`, cStat 100, dhProc 2026-09-29T23:33:44-03:00, Curitiba,
vServ = vLiq = 250,00, tomador NICOLE CRISTINA LOPES ALVES LTDA (K2). Voz **A** source P gravada; XML da NFS-e em
`storage/07742094000113/2026/09/<chave>-nfse.xml` (regApTribSN 1, pTotTribSN 6.00, opSimpNac 3, sem IM, sem pAliq —
igual às notas do portal). **CRAVADOS pela resposta real** os [INCERTO] do §12: o JSON 2xx do POST /nfse (chave + XML
gzip/b64) foi lido pelo adaptador SEM ajuste e conferido contra a pergunta (R2-2: Id do infDPS = DPS enviado); fluxo
Q-N35/Q-N36/Q-N37 fechado em 4 tentativas (E0120 → E0166 → E0712 → A). Ainda a provar ao vivo: consulta de eventos,
DANFSe desta nota, cancelamento em produção (se a nota for só de teste, cancelar pela seção "No fisco" dentro do prazo
do município).

### 13.3 1º CANCELAMENTO em PRODUÇÃO (2026-09-29 23:35:18)

O Valdo cancelou a NFS-e 704 pela seção "No fisco" ~2 min após a autorização: o fisco ACEITOU (voz **C** source P no
evento 2 da tentativa 17, `invoice_event` 2 ligado); efeito local na MESMA transação (D-N7): `tb_invoice_event` 2 = C,
nota 6790 soft-deletada, OS 7374 de volta a **A** com a trava `open_lock` restaurada. DANFSe da 704 aberto antes sem
erro. Ciclo emitir → autorizar → DANFSe → cancelar PROVADO ao vivo em produção.
**Achado (Q-N38, aguarda o Valdo)**: o XML do EVENTO de cancelamento (pedido assinado + resposta do fisco) NÃO é
gravado em disco — só `-dps.xml` e `-nfse.xml` existem (`saveFiscalXml` não é chamado no cancelamento). O arquivo
fiscal do contribuinte deveria guardar o evento junto com a NFS-e (mesma pasta `<cnpj>/<ano>/<mês>`). Rec.: gravar
`<chave>-evt101101.xml` com o evento devolvido pelo fisco, na composição do cancelamento.
