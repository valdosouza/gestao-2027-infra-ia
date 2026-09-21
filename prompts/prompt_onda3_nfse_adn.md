# Onda 3 — NFS-e pelo Padrão Nacional (ADN / Sefin Nacional)

**Escopo**: misto (habilitação do emissor, transmissão do DPS e voz do fisco são método portável — o
mesmo molde da Onda 2; Setes, Curitiba e o certificado A1 da empresa são conteúdo `setes`)
**Fase-mãe**: `prompt_primeiro_cliente_setes.md` (D1 emissão pelo ambiente nacional com A1, nunca
webservice municipal · achado A2 ramo de serviço vazio · D33 ordem Inter → NFS-e → Produção)
**Molde**: `prompt_onda2_banco_inter.md` §3 (dono × apresentação × voz do terceiro) e §10 (lições dos gates)
**Aberto em**: 2026-09-20 (Rodada 0 = levantamento + parecer do guardião conceitual, agente `setes-conceito`,
enquanto o sandbox do Inter está fechado — janela seg–sex 8h–20h)
**Estado**: Rodada 0 ORGANIZADA · **Rodada 1 AGUARDA o Valdo (Q-N1…Q-N16)** · contrato oficial LEVANTADO
(§1.1 + `setes-api/integracoes/nfse-adn/`; swagger/XSD só com o e-CNPJ) · nenhuma linha de código

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
(nenhuma ainda — Rodada 1 aguarda o Valdo)
