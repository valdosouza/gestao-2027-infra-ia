# Onda NF-e — Nota de mercadoria pela SEFAZ (modelo 55; modelo 65 só apontado)

**Escopo**: misto (habilitação do emissor, transmissão, voz do fisco e inutilização são método portável — o mesmo molde das Ondas 2 e 3; a SEFAZ-PR, o A1 e o primeiro cliente com mercadoria são conteúdo `setes`)
**Fase-mãe**: `prompt_primeiro_cliente_setes.md` (D1 emissão com A1 próprio; D33 ordem Inter → NFS-e → Produção). A Setes vende serviço: **esta onda não tem item na trilha dos 7 processos** — nasce para que o desenho da NFS-e (Onda 3) seja correto por construção e para o primeiro cliente com mercadoria.
**Molde**: `prompt_onda3_nfse_adn.md` §3–§7 (mesma tabela de conceitos, mesmos nomes de peça) e `prompt_onda2_banco_inter.md` §3 (dono × apresentação × voz do terceiro) e §10 (lições dos gates: ambíguo nunca fecha, reconciliar antes de reapresentar, transitório ≠ recusa).
**Legado** (vault `D:\Gestao2016\Infra-IA\Gestao`, Decisão 65): `proc-faturamento-venda` E07, `proc-cancelamento-nfe` C00–C05, Lote 6 §2–§5, Lote 8 §2, NUM-01/02/03, AUT-01/02/03/04, CAN-01, CAN-V5/V6/V7, NF-01, `geracao-nfe-hierarquia` §3–§4 (diagnóstico: variação por MODELO duplicada = maior fonte de retrabalho; variação por PROCESSO pequena e sadia; operações do ciclo — inutilizar/consultar — são comandos, não "geradores").
**Aberto em**: 2026-09-21 (Rodada 0 = parecer do guardião conceitual, agente `setes-conceito`, a pedido do Valdo: "desenhar o processo da NF-e mantendo a simetria de controles com a NFS-e, para que o desenho fique, se não o mesmo, seguindo o mesmo fluxo"). Fatos do parecer conferidos no disco pelo condutor (billing.service.ts:672–677, baseline 001, produtores em api/sync).
**Estado**: **2026-10-18 (noite) — §15 ⏯ NE-2 Rodada 0 ORGANIZADA (inventário + parecer do guardião + escopo E1–E6; NE-3 só como vista no §15.5); Rodada 15 em revisão UMA A UMA (§15.8): D-NE158 (família no catálogo só na NE-6) e D-NE159 (`humanEffectCancel` = false) decididas — RETOMAR PELA Q-NE160; achado: a UNIQUE da faixa inutilizada no rascunho do DDL não tem o ambiente (Q-NE163)** · **2026-10-18 — §14.20 NE-1b FECHADA e PUBLICADA (2 janelas — núcleo abce0b8; subpath `fiscal-api/pdf`; Rodadas 5–14 = D-NE117…D-NE157; regra da família para a NE-2/NE-3 na D-NE157); próximo: NE-2/NE-3** · **2026-10-17 — §14: NE-1b Rodada 0 ORGANIZADA, SÓ NF-e (base de PDF no núcleo: Code-128 híbrido C/A + QR por bwip-js — spike provado —, passada por folha, marca d'água; "documento alfanumérico" já feito pela frente do CNPJ; DANFSe FORA — tarefa da família NFS-e); Q-NE117…Q-NE123 aguardam o Valdo** · **2026-10-15 — §13: NE-0 ABERTA (Rodada 0)** — acervo `../nfe-api/integracoes/nfe-sefaz/` criado (README com 20 documentos a arquivar + fatos levantados na web; CONFERENCIAS com 65 itens, 26 com prévia; **nenhum download feito**); fato que reabre a D-NE18: pela NT 2026.007 (H 26/10, P 16/11/2026) emitente SEM IE autoriza só na SVRS; PR exige CSRT; prazo de cancelamento no PR = 168 h; SHA-1 e síncrono confirmados; **Rodada 3 DECIDIDA (§13.8, D-NE93…D-NE101) e NE-0 EXECUTADA (§13.9: 24 oficiais arquivados, 65 conferências fechadas — 2 DERRUBAM —, autorizadores como dado, DDL da família em RASCUNHO pelo guardião, OpenAPI v1) — Rodada 4 DECIDIDA (§13.10, D-NE102…D-NE114; D-NE103 supera o refNFe da D-NE25) — **NE-0 FECHADA**; D-NE115/D-NE116 (downloads) executadas — NENHUMA questão aberta; PUBLICADA (infra 5a1633d · nfe-api a9ef9ac); próximo: frente do CNPJ alfanumérico (D-NE99) → NE-1b/NE-2/NE-3** · **2026-10-12 (tarde) — §12.9.7: Rodada 0 da PARTE 2 da NE-1a feita (inventário + parecer do guardião + ordem interna, sem DDL) + leitura DETERMINÍSTICA do ACBr (`../nfe-api/referencia-acbr/06`) → D-NE72…D-NE74 DECIDIDAS e ordem aceita ("siga as recomendações e a ordem proposta"); EM EXECUÇÃO — passos 1–6 FEITOS (§12.9.7.1: cerca por modelo, emitter no núcleo, terminal por parâmetro + listas derivadas, escritor genérico sob `InvoiceTx`, política em peças, `ca`/cadeia do servidor — D-NE57; núcleo 327 · nfse-api 591 + 150/150 ao vivo; nada commitado); gates 0,76/0,72 → D-NE75…D-NE84; "parte 2a" PUBLICADA (núcleo 27d2aa6 · nfse 38980bb · infra f72fba4); próximo: passo 7 = N17 (parser XML) → "parte 2b"** · **2026-10-12 — §12.9 ⏯ RETOMAR POR AQUI: NE-1a PARTE 1 EXECUTADA, com GATES (0,76/0,76) e PUBLICADA — D-NE56…D-NE62 e D-NE66/68/69/70/71 (D-NE61: a denegada barra pelo FATO da view — Q-NE67 rejeitada); nenhuma questão aberta; PROMPT DE RETOMADA da parte 2 no §12.9.6; próximo: parte 2 da NE-1a (cerca por modelo, emitter, escritor/peças, `ca`/cadeia D-NE57, parser XML N17, D-NE69) → F2a** · 2026-10-11 — D-NE55 (a NE-0 vai para depois da F2a) · **2026-10-11 — §12.8: nota de implantação da NE-1a para a ESCRITA DA VOZ por família (D-F105/D-F106/D-F108 das APIs fiscais) — entra no escopo da NE-1a** · **2026-10-10 (tarde) — §12: plano ajustado pela leitura do ACBr (`../nfe-api/referencia-acbr/`) + Rodada 2 da nfe-api DECIDIDA (§12.7, D-NE27…D-NE54 = recomendações); NE-1 partida em 1a (antes da F2a) / 1b (depois); nenhuma questão da nfe-api aberta — o bloco F vai ao prompt IBS/CBS** · **2026-10-10 — Rodada 0 da `nfe-api` ORGANIZADA (§11) e Rodada 1 DECIDIDA (§11.7, D-NE1…D-NE26 = recomendações; D-F20 suspensa em parte — NE-0…NE-3 liberadas)** · **Rodada 1 DECIDIDA (2026-09-21, D-E1…D-E25 = recomendações)** · execução pela D-E20 (a): peças comuns junto com a Onda 3 (§10); a NF-e em si espera o 1º cliente com mercadoria — várias questões REABREM de propósito itens da Onda 3 (Q-N4/Q-N6/Q-N9/Q-N13/Q-N14) porque agora custam zero e depois custam migration · contrato oficial da SEFAZ NÃO levantado (MOC 7.0, NT 2025.002 IBS/CBS, schemas PL, tabela de autorizadores — 1ª tarefa técnica, como foi com o Inter e o ADN) · nenhuma linha de código

---

## 1. Contexto (fatos verificados no disco em 2026-09-21)

- **A nota de mercadoria já nasce numerada e com o ramo congelado.** `POST /api/billing/invoice` → `issueInvoice` (`@shared/invoice`): cabeçalho `tb_invoice` (PK `id = pedido` + institution + terminal; `issuer = institution`; `number` = MAX+1 por `model`+`serie` pelo índice da migration 045, sob `lockInstitutionCounters`), evento `E` com snapshot (número/série/modelo/valor), ramo `tb_invoice_merchandise` (base/ICMS/ST/IPI/frete/seguro/despesas/desconto/`indPres`/`dt_exit`/`total_value` — o `total_value` do RAMO é o `vNF` da NF-e; `tb_invoice.value` inclui o serviço) e snapshots por item `tb_order_item_icms/_icms_fcp/_ipi/_pis/_cofins/_ii` (CST, CFOP, bases, alíquotas, MVA, ST retido). `model` é derivado por PRESENÇA (`'55'` se há item de mercadoria, senão `'SE'` — `billing.service.ts:676`); `serie` vem da config `invoice_serie` (default `'1'`). **Diferença estrutural com o legado**: lá o número nasce na autorização (E07, NUM-02); aqui nasce no faturamento — rejeição da SEFAZ nunca "libera" número porque ele já era da nota.
- **Uma venda com serviço = UMA `tb_invoice` com DOIS ramos** (`tb_invoice_merchandise` + `tb_invoice_service`) = **dois documentos fiscais** (NF-e à SEFAZ; DPS à Sefin Nacional). A conjugada do legado (`OSR_G_NFSE_CONJ`, serviço dentro do XML da NF-e) está morta: "na web cada ramo autoriza no seu documento" (processo-pedido-nota; Onda 3 §1). O XML da NF-e leva só os itens `kind` P/M.
- **O que existe e é reusado sem reforma**: `tb_invoice_event` E/C (T A R D I reservados — liberar, espelho da Q-N1), `buildCancelPlan`/`cancelInvoice` (409 único `INVOICE_CANCEL_BLOCKED` com blocos `title|bankSlip|check|return|serviceOrder`; D3 nota autorizada MANTIDA, D4 número, D5 pedido volta a 'A' — e o §5 do prompt de cancelamento já reserva para a "fase de transmissão": *ramo autorizada, pedido 'C' + cópia de ordem (#20), inutilização*), `@shared/tax-rule` (motor ICMS/ST/IPI/PIS/COFINS), `tb_cfop`/`tb_ncm`/`tb_cest` centrais, `tb_state.id` = código IBGE (41 = PR) e `tb_city.ibge` (cUF/cMunFG deriváveis, sem coluna nova), `tb_company.ie/im/iest`, `tb_entity_tax` (CRT por `parseCrt`), `@shared/secret-store` (`<schema>/<owner>/<ownerId>/<S|P>/<name>`, dono `establishment` previsto pela D-I1), `withDeadlockRetry`/`contention`/`lockInstitutionCounters`, `STORAGE_PATH`, catálogo `error-codes`, `requirePrivilegeFor` (privilégio por RAMO, D-G29).
- **Resíduo do baseline que NÃO é peça desta onda** (regra dos dois grupos — o setes-sync é dono): `tb_invoice_return_55/65/service` = espelho do `TB_RETORNO_NFE/NFCE/NFS` do desktop (só o `/invoice-return-*/sincronize` escreve; `file_name` = elo com o `/filexml`); `tb_invoice_rectification` = alvo futuro da CC-e sincronizada (gap da Rodada 4 do sync); `tb_nfe_events`, `tb_nfe_events_sent`, `tb_nfe_sequences`, `tb_nfe_series` = sem produtor em lugar nenhum (nem sync, nem api) — "tabela sem consumidor não é morta", mas também não vira fundação de emissão nativa: carregam o formato do desktop (série por terminal, situação como coluna). Nota sincronizada do legado (sem evento `E`) **não é transmissível** na web, pelo mesmo princípio da Q-P1 (não é cancelável) — 409 "autorize/cancele na origem".
- **Lacuna que é PRÉ-REQUISITO, não parte do desenho**: a web não tem `tb_order_item_ibscbs` nem motor de IBS/CBS; o legado já grava `TB_IBSCBS*` por item (E04) e a NF-e 4.0 exige o grupo `IBSCBS` por item em 2026 (NT 2025.002 — cronograma exato no levantamento). Sem isso nenhuma NF-e de 2026 é autorizável em produção → **Q-E17**.

## 2. Objetivos (numerados)

1. O estabelecimento se habilita como emissor de NF-e (modelo 55) com o MESMO certificado A1 e o MESMO cofre da NFS-e, em homologação ou produção — **agregando linha** à habilitação, não reformando a peça da Onda 3.
2. Transmitir o ramo de mercadoria à SEFAZ autorizadora da UF do emitente (chave de 44 NOSSA, lote síncrono NF-e 4.0 com fallback por recibo), guardar a voz da SEFAZ append-only, o protocolo write-once e o XML autorizado (`nfeProc`) em disco; DANFE renderizado por nós.
3. Refletir aqui o que a SEFAZ disser sem inventar: autorizada, rejeitada, **denegada**, cancelada — estado fiscal do RAMO derivado do último evento da última transmissão; a nota continua E/C.
4. Cancelar pela mesma ordem da NFS-e (plano local → estado fiscal → pedido ao fisco → voz → efeito), com evento 110111 e prazo de 24 h; nota mercadoria+serviço = dois pedidos ao fisco, um por documento.
5. **Inutilizar faixa de numeração** como ato sobre a NUMERAÇÃO do emissor (nunca sobre uma nota), com o contador respeitando as faixas inutilizadas por construção.
6. Deixar por construção o encaixe do modelo 65 (NFC-e/PDV), da contingência e da CC-e como atos/estratégias futuras, sem coluna antecipada.

## 3. Modelo (Rodada 0 — parecer do guardião, 2026-09-21)

"Emitir NF-e" tem os MESMOS quatro "e" escondidos da NFS-e — mais UM que a NFS-e não tem (a numeração é nossa, logo o fisco precisa saber o que NÃO usamos):

| # | Conceito (uma frase) | Fato gerador | Natureza | Igual à NFS-e? |
|---|---|---|---|---|
| A | Este estabelecimento emite documentos do modelo M perante o fisco desse modelo, com o SEU A1, num ambiente, numa série | habilitação (upload do A1 + ambiente + série) | peça — especialização do EMISSOR por PK | **MESMA peça** `tb_establishment_issuer` — agrega linha (55). Achado: a chave natural é o MODELO, não a autoridade (§3.1, Q-E1) |
| B | Este ramo de mercadoria foi declarado à SEFAZ (uma NF-e enviada, com a chave que NÓS cunhamos) | o envio | peça — 1 ramo × N transmissões | **mesma forma**, tabela irmã por ramo (`tb_invoice_merchandise_transmission`); colunas diferem por fato: chave 44 nossa no envio, recibo, sem "número do fisco" |
| C | A SEFAZ disse algo sobre essa transmissão | cada resposta (síncrona, recibo ou consulta) | peça — voz do fisco, append-only | **mesma forma** (`_transmission_event`); kinds a mais: **P** (em processamento) e **D** (denegada) |
| D | A NF-e resultou (protocolo, `dhRecbto`, XML `nfeProc`) | a autorização | NÃO é peça: write-once na transmissão + XML em `STORAGE_PATH/<cnpj>/<ano>/<mes>`; **DANFE = renderização NOSSA** (sempre foi — nunca houve API) | igual (a NFS-e chegou ao mesmo ponto pela NT 008) |
| E | Nossa nota mudou (cancelou) | o efeito que a voz produz aqui | `tb_invoice_event` só E/C; nota que o fisco REGISTROU (A ou D) é mantida e o pedido vai a 'C' + cópia (#20) | igual; a diferença é o D (§3.5) |
| F | Uma faixa de números do modelo/série deste emissor foi declarada inutilizada ao fisco | o pedido de inutilização + a resposta síncrona | peça NOVA — ato sobre a NUMERAÇÃO | **não existe na NFS-e** (lá quem numera é o fisco). Forçar simetria aqui seria maquete |

**Reserva T/A/R/D/I de `tb_invoice_event`: LIBERAR, e desta vez com o motivo completo.** T/A/R são voz do terceiro (tabela própria); **D é voz** (a SEFAZ diz "uso denegado", cStat 110/301/302/303 — nossa nota não "fica denegada": o RAMO fica, derivado); **I não é estado de nota**: inutiliza-se NÚMERO sem nota viva — a nota soft-deletada que carregava o número (D3) não recebe evento; a faixa é que existe (peça F). Uma nota mercadoria+serviço tem DUAS autorizações — `A` no cabeçalho não saberia dizer qual (o mesmo argumento da Onda 3, agora com o caso real: toda venda com serviço).

### 3.1 A. `tb_establishment_issuer` — a habilitação AGREGA linha, mas revela a chave natural (Q-E1)

Confirmado: mesma tabela, mesmo dono (`tb_institution_id` — o emissor É a institution: `tb_institution.id = tb_entity.id = tb_company.id`), mesmo A1, mesmo cofre (`secret-store` owner `establishment`, `ownerId = institutionId`, par PEM derivado do `.pfx` — Q-N5), mesma aba "Emissor fiscal". **Nunca é dado**: `.pfx`, senha, chave privada, CSC.

O que a NF-e traz e a NFS-e não tinha como ver — teste 6 do checklist ("o irmão AGREGA ou REFORMA?"):

- **55 e 65 falam com a MESMA autoridade** (SEFAZ da UF, mesmo certificado, mesma família de webservices) mas **não compartilham série, ambiente nem segredo**: a série do 55 e a do 65 são contadores independentes (a chave de acesso os separa por `mod`); uma empresa homologa NFC-e enquanto a NF-e já está em produção (fato corriqueiro de implantação); o CSC (código de segurança do contribuinte, QR Code) é segredo só do 65. Com PK `(institution, authority)` a linha `E` teria `serie_55`/`serie_65`/`environment_65`/`csc_id` — coluna com dois significados vindos de dois documentos: o sintoma de maquete registrado no inventário.
- **A autoridade é FUNÇÃO do modelo** (`'SE'` → Sefin Nacional; `'55'`/`'65'` → SEFAZ). Coluna `authority` seria derivável → redundante.
- **A série já é do modelo hoje**: `nextInvoiceNumber(model, serie)`; a config `invoice_serie` vale para a nota que o billing cunha (55) e a Onda 3 criou `dps_serie` para o DPS — duas fontes para o mesmo conceito ("como este estabelecimento numera documentos do modelo M").

**Recomendação**: PK **`(tb_institution_id, model)`** — `model` VARCHAR(2) com o domínio de `tb_invoice.model` (`SE`, `55`, `65`); `authority` derivada (mapa constante em `@shared/tax-authority`); `environment` char(1) `H`/`P` por linha (o certificado continua por AMBIENTE em `establishment/<inst>/<H|P>/` — uma linha 55 em P e outra 65 em H usam a mesma pasta do seu ambiente; Q-N6 preservada); **`serie`** VARCHAR(5) por linha substitui `dps_serie` e aposenta a config `invoice_serie` (uma fonte; tarefa de implantação — Q-E2); `simples_regime` (opSimpNac) sai da linha `SE` e vai para onde o regime do emitente já vive (`tb_entity_tax` da institution) — é fato do EMITENTE, não do modelo (Q-E3); `active` — presença de `environment` + certificado já decide (Q-E4). Nome mantido (`_issuer` = habilitação de quem emite). O que não muda: Q-N4/Q-N5/Q-N6 da Onda 3 continuam válidas; só a coluna da PK troca — e troca AGORA porque a Onda 3 ainda não tem DDL (custo zero; depois seria migration com reforma).

### 3.2 B. `tb_invoice_merchandise_transmission` — a transmissão da NF-e

PK `(tb_institution_id, tb_invoice_id, terminal, attempt)` + FK composta para `tb_invoice` (espelho exato da `_service_transmission`). `environment` CONGELADO. Colunas:

- **`access_key` CHAR(44) NOT NULL, UNIQUE `(tb_institution_id, access_key)` — nasce NO INSERT, é NOSSA** (cUF + AAMM + CNPJ + mod + série + nNF + tpEmis + cNF + cDV; `cNF` aleatório ≠ nNF, um por tentativa). Diferença de fato com a NFS-e (chave 50 dada pelo fisco na autorização, write-once). Consequência boa: reconciliar um desfecho ambíguo é consultar **a nossa chave** (`nfeConsultaProtocolo`), sem depender de `GET /dps/{id}`; e "Rejeição 204/539 Duplicidade" vira sinal de reconciliação, não de falha.
- `dh_emission` DATETIME NOT NULL — o `dhEmi` que assinamos (Q-E9 decide se o cabeçalho espelha a data fiscal, AUT-03 do legado).
- Write-once (NULL → valor uma vez, pela voz): `receipt` VARCHAR(15) (`nRec`, só quando a SEFAZ cair no assíncrono: 105), `protocol` VARCHAR(15) (`nProt`), `dh_authorization` DATETIME (`dhRecbto` da autorização/denegação). Sem `nfse_number`, sem `dps_id` — não existem.
- `last_queried_at` (D-I20; aqui é OBRIGAÇÃO, não conforto: consultar a mesma chave repetidamente dá cStat 656 "consumo indevido" — o rodízio por `last_queried_at` da migration 056 é a regra).
- `tb_user_id`, colunas padrão. XML em disco: `<chave>-nfe.xml` (`nfeProc`, o mesmo nome que o `/filexml` do sync já usa), `<chave>-can.xml` (`procEventoNFe` do cancelamento).
- Reapresentar = `attempt + 1`, com chave própria, **só depois de a tentativa anterior estar resolvida** (R/F por voz ou por consulta) — lição D-I21/§10 da Onda 2 ("reconciliar por seuNumero ANTES de nova apresentação"), aqui por chave.
- **Guarda por construção**: só se transmite nota com `tb_invoice.issuer = institution` (nota de compra, `issuer` de terceiro, nunca), com evento `E` (nota da web), com ramo de mercadoria presente e com habilitação `('55', environment)` + certificado válido.
- `tp_emis`, `dh_contingency`, `contingency_reason`: **não entram** — o `tpEmis` já está na posição 35 da chave (derivável); a contingência é atributo da TENTATIVA e agrega por ADD COLUMN quando houver fato (§3.10, Q-E12).

### 3.3 C. `tb_invoice_merchandise_transmission_event` — a voz da SEFAZ (append-only)

PK `(tb_institution_id, tb_invoice_id, terminal, attempt, event)`; `kind` = NOSSA leitura: **S** enviado · **P** em processamento (103/105 — recibo em mãos; só NF-e) · **A** autorizada (100; 150 fora de prazo) · **R** rejeitada (qualquer cStat de rejeição de lote/nota) · **D** denegada (110, 301, 302, 303 — só NF-e) · **C** cancelada (135, 155; 101 na consulta) · **K** cancelamento em voo · **F** falha explícita (transporte/TLS/assinatura recusada localmente); `authority_code` INT (cStat cru) · `message` (xMotivo) · `dh` (dhRecbto) · `source` char(1) **P** resposta direta / **Q** consulta (recibo ou situação) — sem **W**: a SEFAZ não nos chama, não existe webhook nem `inbound_token` (diferença de fato com o Inter, igual à NFS-e) · `invoice_event` INT NULL (causa → efeito; precedente `slip_event`) · idempotência por `(kind, dh)` com UNIQUE-cinto. cStat desconhecido → 502, nunca inventa (lição do `TB_MSG_RETORNO_NFE` mantido "à mão", Decisão 13 do legado: a tradução é código versionado no adaptador, não tabela).

### 3.4 D. Resultado write-once e DANFE

Protocolo/`dhRecbto` na transmissão; `nfeProc` em disco (o arquivo É o snapshot de emitente, destinatário, itens com NCM/CEST/EAN, transportadora — nada disso vira coluna). **DANFE**: peça NOSSA de renderização do XML (Anexo II do MOC; QR Code só no 65) — `@shared/danfe`, irmã da `@shared/danfse` (Q-N13); o motor de PDF é escolhido UMA vez para as duas. Não se guarda PDF (regenera sob demanda; cache opcional em `STORAGE_PATH` por convenção, como o PDF do boleto).

### 3.5 E. Efeito na nota — o que a voz produz aqui

- **A** → nenhum evento na nota (estado do RAMO derivado); hooks de pós-autorização por PROCESSO (a fronteira sadia do legado, §3 do diagnóstico): e-mail com XML + DANFE ao destinatário (AUT-02) — ato explícito nesta onda, automático vira config do emissor depois (Q-E10). `tb_invoice.dt_emission` espelha `dh_emission`? — Q-E9.
- **D (denegada)** → a nota EXISTE na SEFAZ com essa chave: número consumido (nem reusar nem inutilizar), mercadoria não circula, **não se cancela no fisco, não se retransmite**. Efeito automático: **NENHUM** — voz gravada, pendência visível ("denegada: motivo"); o usuário decide "Cancelar nota" (desfazer financeiro/comissão pelo plano de sempre) e o bloco fiscal do plano, vendo D vigente, **não vai ao fisco** e cancela local com a nota MANTIDA (regra: *nota que o fisco registrou — A ou D — é mantida com número; pedido 'C' + cópia*). O ramo 5 do legado (denegada → `Pc_FinalizaCancelamentoNFe`, código morto pela Decisão 4) NÃO se reproduz: denegação não é cancelamento. Se a Receita realmente deixou de denegar (Decisão 4 do vault), o kind D fica sem produtor e não custa nada; se voltar a denegar, a peça já sabe ouvir. Q-E7.
- **C vinda da consulta** (cancelada no portal da SEFAZ/outro software com o mesmo A1 — o "portal do banco" desta onda) → `cancelInvoice` em SAVEPOINT; recusa local (título baixado) = **fato gravado + pendência** (D-I10) — a política que não pode bifurcar entre chamadores e que justifica UMA composição (§3.11).
- **Pedido depois de nota registrada no fisco** (A cancelada, ou D): `tb_invoice` tem PK = pedido (1 nota por pedido); nota mantida ⇒ o pedido **não é refaturável na mesma identidade** → `tb_order.status = 'C'` + **cópia de ordem** (#20 — já reservado no §5 do prompt de cancelamento). D5 ('A', refaturável) continua valendo só para nota que o fisco não registrou. Q-E8.
- **D3/D4 estendidas**: "autorizada" → "registrada no fisco (A ou D)" mantém; "pendente" (nunca enviada, R, F) → soft-delete + número reaproveitável se era o último (SEFAZ nunca a viu — legal).

### 3.6 F. `tb_invoice_number_void` — inutilização de faixa (peça nova, só modelos 55/65)

**Conceito**: uma faixa de números (ano, modelo, série, `number_from..number_to`) deste emissor que declaramos ao fisco que não será usada. Nasce de um ato do usuário (obrigação legal: números pulados devem ser inutilizados até o 10º dia do mês seguinte) e recebe UMA voz síncrona e definitiva (cStat 102 homologada; rejeição; 206 "já inutilizada" = confirmação de um envio ambíguo anterior — ⚠️ **SUPERADO pelo fato do §13.3 (2026-10-15)**: o 206 é resposta da AUTORIZAÇÃO de número inutilizado; quem confirma o envio ambíguo é o **563**, que traz o `nProt` do pedido anterior — D-NE40). Não é sobre nota nenhuma: NUM-03/Lote 8 §2 do legado mostram o erro de quem tentou (`tb_ctrl_nf` recriando a sequência com "uma linha por número", `LiberaNumeroNota` morta, série fixa '1').

- PK `(tb_institution_id, id)` (`id` MAX+1 sob `lockInstitutionCounters`); `model` VARCHAR(2), `serie` VARCHAR(5), `year` SMALLINT, `number_from`/`number_to` INT, `reason` VARCHAR(255) (xJust 15–255), `environment` CONGELADO, `void_id` CHAR(43) (o `Id` do `infInut`, nosso), `tb_user_id`; **write-once** pela resposta: `authority_code`, `message`, `protocol`, `dh`. Sem tabela de voz: a inutilização tem exatamente UMA resposta, síncrona e irreversível — modelar `_event` aqui seria simetria por gosto. Tentativa rejeitada fica como história; nova tentativa = nova linha. Estado derivado: enviada (sem código) · homologada (102/206) · rejeitada.
- **Guardas por construção**: a faixa não pode conter nota `deleted='N'` do mesmo modelo/série (409 `FISCAL_VOID_RANGE_IN_USE`); nota soft-deletada com número na faixa é o caso normal; **o contador `nextInvoiceNumber` passa a ser `MAX(MAX(tb_invoice viva), MAX(number_to homologado)) + 1`** por modelo/série — D4 continua ("reaproveita se era a última") e a faixa inutilizada nunca é reusada, sem regra de aplicação.
- **Buracos = leitura derivada, nunca tabela**: "números sem nota viva entre 1 e MAX, descontadas as faixas homologadas" — a tela "Numeração" da aba Emissor fiscal lista e oferece "Inutilizar faixa". É o que o `Un_Pesq_Ctrl_NF` reconstruía à mão; aqui é query.

### 3.7 Autoridade por UF — derivada, nunca coluna

SEFAZ autorizadora = f(**UF do emitente**, modelo, ambiente, tpEmis): PR, SP, MG, RS, BA, GO, MT, MS, PE, AM têm SEFAZ própria; as demais usam SVRS/SVAN; contingência vai à SVC-AN/SVC-RS; NFC-e tem tabela própria. É **fato do mundo publicado pelo Portal NF-e** e muda raramente → **constante versionada em `adapters/sefaz.ts`** (`authorizers.ts`, molde dos escopos do Inter), nunca tabela nem coluna. A UF vem do endereço fiscal da cadeia da institution (`tb_address.main='S'` → `tb_state.id` = IBGE → `abbreviation`), lida na transmissão e **congelada na própria chave** (os 2 primeiros dígitos = cUF): se o endereço mudar depois, a chave já disse de onde saiu. Ambiente (`tpAmb`) vem da habilitação. Nada a decidir além de confirmar (Q-E5).

### 3.8 Assinatura e transporte — `@shared/tax-authority` paramétrica por FATO, não por gosto

- **Assinatura**: NF-e 4.0 = XMLDSig enveloped sobre `infNFe` (`Id="NFe"+chave`), eventos sobre `infEvento`, inutilização sobre `infInut`; C14N inclusiva; **RSA-SHA1 + SHA-1** (o MOC 7.0 ainda exige). NFS-e: enveloped sobre `infDPS`/`infPedReg`, algoritmo a confirmar (Q-N12). Logo o assinador é UMA peça `xmldsig.ts` com parâmetros `{ algorithm: 'sha1'|'sha256', referenceId, canonicalization }` — parametrizado porque os dois fiscos DIFEREM, não para "o caso X".
- **Transporte**: NF-e = SOAP 1.2 sobre TLS 1.2+, **certificado de cliente = o A1 do emissor** (o mesmo arquivo do cofre que a NFS-e usa no mTLS REST). Os dois são TLS com certificado de cliente do ESTABELECIMENTO; o "mTLS de canal" do Inter é outro certificado (o da aplicação bancária) — por isso o A1 nunca se pendura no canal do banco (D-I1). O que muda entre ADN e SEFAZ é o envelope (JSON gzip+b64 × SOAP) — vive inteiro no adaptador. Validação local contra XSD (PL vigente) antes de assinar = parte do adaptador (o legado "gera/assina/valida" e, se falha, não envia — mantido).
- Interface de `@shared/tax-authority` (não conhece nota): `sign(xml, ref)` · `authorize(lote)` · `queryReceipt(nRec)` · `queryKey(chave)` · `event(chave, tipo, payload)` · `void(range)` · `status()` (nfeStatusServico — a aba Emissor fiscal mostra "SEFAZ disponível"). Adaptadores: `adn.ts` (Onda 3) + `sefaz.ts`; amanhã `distribution()` (DF-e recebidos — compra) entra na mesma família como fato próprio.

### 3.9 Cancelamento — mesma ordem, um pedido ao fisco POR RAMO

**plano local → estado fiscal por ramo → pedido ao fisco por ramo → voz → efeito** (junta D-I22, C1 do cancelamento de nota e Q-N7):

1. `buildCancelPlan` ganha o bloco **`fiscal`** e roda primeiro (FOR UPDATE): baixa/boleto/cheque/devolução bloqueiam ANTES de tocar qualquer fisco. O bloco lê, por RAMO presente, o último evento da última transmissão: nunca transmitida/R/F → cancela local; **A vigente** → precisa da voz C daquele fisco; **D** → não vai ao fisco, cancela local com nota mantida; **K** → 409 até reconciliar; C já → nada a pedir.
2. **NF-e**: evento 110111 (`xJust` 15–255 = o motivo que a D13 já exige), síncrono — a resposta É a confirmação (135/155). Prazo **24 h** (nacional; extemporâneo até 480 h depende da UF e sofre multa) — constante do adaptador com aviso na tela; a recusa definitiva é a da SEFAZ (220), nunca duas fontes de verdade (mesma postura da Q-N15 com o PAM). Bloqueio por manifestação do destinatário (confirmação da operação) idem: voz do fisco, não regra nossa.
3. **Nota mercadoria+serviço = dois documentos, dois pedidos** (CAN-V5/Decisão 36 do legado: "cada ramo autoriza no seu documento" — a NF-e autorizada nunca foi bloqueada pela NFS-e). Ordem: NF-e primeiro (prazo mais curto: se recusar, nada aconteceu); depois DPS (`e101101`). Um fisco aceita e o outro recusa → **estado parcial é FATO visível e retomável** ("NF-e cancelada; NFS-e vigente — conclua"), o C local da nota (financeiro/comissão) só quando nenhum ramo restar autorizado. Nunca se "desfaz" um cancelamento aceito (irreversível nos dois fiscos). Q-E11.
4. Voz C na transmissão + C local por `cancelInvoice` na MESMA transação; ambíguo → K em voo, bloqueante até a consulta por chave reconciliar.

### 3.10 O que a NF-e tem e a NFS-e não — onde cada fato vive e se entra nesta onda

| Fato do mundo | Como entra | Onde vive | Nesta onda? |
|---|---|---|---|
| Numeração NOSSA + chave 44 | `tb_invoice.number` já existe; `access_key` nasce na transmissão | B | sim |
| **Inutilização** de faixa | ato sobre a numeração; contador respeita faixas | F | sim (obrigação legal desde a 1ª nota pulada) |
| **Denegação** | voz D; nota registrada, sem efeito automático | C + regra do §3.5 | sim (kind + guardas; pode ficar sem produtor) |
| Lote síncrono com fallback assíncrono (103/105 + `nRec`) | kind P + `receipt` write-once + `queryReceipt` | B/C | sim |
| Consulta de situação por chave | `refresh` com rodízio (`last_queried_at`, cStat 656) | B/C | sim |
| Cancelamento 110111 / 24 h | evento assinado, síncrono; prazo = constante do adaptador | §3.9 | sim |
| Autorização com "uso denegado" (110) | mesmo kind D | C | sim |
| DANFE | peça nossa `@shared/danfe` | D | sim (Q-E13, espelho da Q-N13) |
| **Contingência** (SVC-AN/SVC-RS tpEmis 6/7; EPEC 4; FS-DA 5; off-line 9 do 65) | atributo da TENTATIVA (já está na chave); SVC = outro endpoint do mesmo adaptador; EPEC = evento à AN antes da nota | B (ADD COLUMN `dh_contingency`/`contingency_reason` quando houver fato) + adaptador | **fora** (Q-E12) — a forma já comporta |
| **Carta de correção** (110110, `nSeqEvento` 1..20) | ato próprio: nossa fala (texto) + resposta write-once; não muda estado | peça futura `tb_invoice_merchandise_rectification` (a palavra da casa para CC-e já é *rectification* — sync) | **fora**; só apontada |
| Devolução (finNFe 4 + `refNFe`) | `tb_invoice.finality` já existe; `refNFe` = `access_key` autorizada da transmissão da venda-âncora (`tb_order_item_return` já aponta) | XML | Rodada 1 (Q-E15) |
| **Modelo 65 / NFC-e** | mesma `tb_invoice` (`model='65'`, `terminal` já na PK), mesmo ramo, mesmas tabelas B/C/F, mesmo adaptador com ramo por modelo (URLs, QR Code + CSC como SEGREDO do cofre, off-line 9, prazo de cancelamento em minutos, série por terminal) | linha `('65')` na habilitação + estratégia | **onda própria (PDV)**; nada antecipado — o que o 65 pode pedir de novo é a SÉRIE POR TERMINAL (`tb_nfe_series` do legado) e isso a onda do PDV decide (Q-E16) |
| IBS/CBS por item (NT 2025.002) | grupo obrigatório na NF-e em 2026; motor + `tb_order_item_ibscbs` | pré-requisito, fase própria | **antes desta onda entrar em produção** (Q-E17) |

### 3.11 O ramo de mercadoria como base do XML — e UMA composição para os dois ramos

**Já congelado no faturamento** (não se recalcula na transmissão): totais do ramo, CST/CFOP/base/alíquota/valor por item nas 6 tabelas de snapshot, `indPres`, `dt_exit`. **Lido na transmissão e congelado só no XML** (o arquivo é o snapshot — regra da Onda 3): emitente (cadeia + IE + CRT), destinatário (cadeia + `tb_entity_tax`: `indIEDest`, consumidor final), produto (NCM/CEST/EAN/unidade — `tb_product` é mutável, como o tomador da NFS-e), transportadora/volumes (`tb_invoice_shipping` existe no baseline), pagamento (`tb_order_billing`/parcelas → grupo `pag`/`cobr`). `tb_invoice.finality` (finNFe) passa a ser escrito por `issueInvoice` por PRESENÇA do ramo (1 normal; 4 devolução) — hoje só o sync a escreve. `kind_emis` fica como está (só o sync; `[INCERTO]` o sentido) — não se reaproveita coluna de significado desconhecido.

**Composição**: a política de "como tratamos a voz de um fisco" NÃO pode bifurcar — reserva de `attempt` sob lock da nota → fisco FORA da transação → voz → `applyAuthorityStatus` como ÚNICA porta em SAVEPOINT (recusa de regra = fato + pendência; transitório desfaz; ambíguo nunca fecha) → cancelamento na ordem do §3.9. Isso é uma composição só: **`@shared/invoice-transmission`** com **estratégias por RAMO** (`branches/merchandise.ts`, `branches/service.ts`: tabelas, montador do XML, adaptador, mapa de kinds, prazos). O legado errou exatamente aqui (55 × 65 gêmeos de 1.700 linhas); a estratégia por MODELO é a correção que o próprio diagnóstico propôs (§4.2). Duas TABELAS por ramo (as colunas diferem por fato: chave nossa × chave do fisco, recibo × número da NFS-e) e UMA composição — não é "parâmetro `bloqueia: true/false`": o ramo não altera a política, só o documento. Consequência para a Onda 3: `@shared/service-invoice-transmission` vira `@shared/invoice-transmission` + `branches/service.ts` **agora**, antes de existir (Q-E6).

**Peças reusadas sem alteração**: `issueInvoice`/`cancelInvoice`/`lockInvoice`, `tb_invoice_event` E/C, `buildCancelPlan` (ganha o bloco `fiscal` — mesma extensão que a Onda 3 já pede), `@shared/tax-rule` e os 6 snapshots por item, `tb_invoice_merchandise`, `tb_invoice_shipping`, `tb_cfop/tb_ncm/tb_cest/tb_state/tb_city`, `secret-store` (owner `establishment`), `@shared/tax-authority` + `xmldsig` (Onda 3), padrão apresentação × voz (Onda 2), `withDeadlockRetry`/`contention`/`lockInstitutionCounters`, `STORAGE_PATH`, `requirePrivilegeFor`, catálogo `error-codes`, `@shared/mailer`.

**O que NÃO entrou (e por quê)**: `tb_invoice_return_55` como voz nativa (é espelho do desktop, dono = sync — regra dos dois grupos; a web LÊ para exibir estado de nota sincronizada, nunca escreve nem decide por ela) · `tb_nfe_series`/`_sequences`/`_events*` (formato do desktop; sem produtor; o que fazer com elas é do Valdo — Q-E18) · coluna de UF/URL/autorizadora no emissor (derivadas) · `tpEmis` como coluna (está na chave) · voz para a inutilização (uma resposta, definitiva) · evento `I`/`D` na nota (I é de número; D é voz) · `tb_ctrl_nf`/sequência materializada (derivada) · tradução cStat em tabela (código versionado) · CSC/`csc_id` (65, onda do PDV — no cofre) · e-mail automático (config do emissor depois) · CC-e, contingência, DF-e distribuição (atos/fatos futuros com lugar já apontado).

### O que vira MAQUETE se modelar errado
`status_sefaz`/`access_key`/`protocol` em `tb_invoice` ou no ramo · T/A/R/D/I na `tb_invoice_event` · `tb_nfe` paralela à nota (recria `TB_RETORNO_NFE`) ou escrever na `tb_invoice_return_55` · "situação 0–5" como coluna · número cunhado só na transmissão (NUM-02 do legado — na web ele já é da nota) · `tpEmis`/`serie_900` no emissor · UF, URL da SEFAZ ou "autorizadora" como coluna · certificado por AUTORIDADE (é do estabelecimento, por ambiente) · `tb_ctrl_nf` "uma linha por número" · inutilização marcando a nota com `I` · denegada tratada como cancelamento (ramo 5 morto do legado) · `tb_invoice_merchandise_item` (o universal já é por item) · composição gêmea por modelo (55 × 65) · consulta obrigatória antes de todo envio (`Fc_ConsultaNFe` do legado — só na ambiguidade) · PDF/XML em blob · `authorized` boolean · UNIQUE de transmissão por nota · 24 h como regra nossa que substitui a SEFAZ · `tb_fiscal_log(json)`.

### Simetria: onde é OBRIGATÓRIA (mesma peça) × onde seria MAQUETE (forçar a NF-e no molde da NFS-e)

| Obrigatória — mesma peça/política | Maquete se forçada — o fato é outro |
|---|---|
| `tb_establishment_issuer` (uma tabela, uma aba, um cofre, um A1 por ambiente) | "número do fisco" write-once na NF-e (quem numera somos nós) · `dps_number` no ramo de mercadoria |
| forma transmissão (`attempt`, ambiente congelado, write-once, `last_queried_at`) + voz (`kind` nosso + código cru + `source` + `invoice_event`) | tabela de "parâmetros da autoridade" para a SEFAZ (PAM é municipal; a SEFAZ é constante) · `receipt`/`P`/`D` no ramo de serviço |
| `applyAuthorityStatus` porta única em SAVEPOINT; ambíguo nunca fecha; recusa local = fato + pendência; C local só com voz | inutilização de "DPS" ou voz `_event` para a inutilização · `K`/consulta "por id de DPS" (a NF-e consulta pela chave nossa) |
| ordem do cancelamento e `buildCancelPlan.fiscal` por RAMO | um único pedido ao fisco para a nota conjugada (são dois documentos) · substituição (`chSubstda`) na NF-e (não existe; há CC-e e complementar) |
| XML em disco por CNPJ/ano/mês; render nosso (DANFE/DANFSe) | webhook/`inbound_token` (a SEFAZ não chama) |
| `@shared/tax-authority` + `xmldsig` paramétrico + adaptador por fisco; `@shared/invoice-transmission` + estratégia por ramo | SOAP embutido na composição · REST do ADN "genérico" para a SEFAZ |
| códigos `FISCAL_*` e a tela "No fisco" por ramo, lote "Transmitir pendentes", privilégio de ação por ramo | tela de "autorização" própria (o legado fundiu UI e máquina fiscal) |

## 4. Nomes

| Objeto | Nome |
|---|---|
| Habilitação do emissor | `tb_establishment_issuer` — PK **`(tb_institution_id, model)`** (Q-E1), `serie`, `environment` |
| Transmissão da NF-e | `tb_invoice_merchandise_transmission` |
| Voz da SEFAZ | `tb_invoice_merchandise_transmission_event` |
| Inutilização de faixa | `tb_invoice_number_void` |
| Transporte | `@shared/tax-authority` + `adapters/sefaz.ts` (`authorizers.ts` = tabela oficial versionada) + `xmldsig.ts` |
| Composição | `@shared/invoice-transmission` + `branches/merchandise.ts` · `branches/service.ts` (renomeia a `@shared/service-invoice-transmission` da Onda 3 — Q-E6) |
| Render | `@shared/danfe` (irmã da `@shared/danfse`; motor de PDF único) |
| Segredos | `@shared/secret-store` owner `establishment`, por ambiente (`certificate.pem` + `private.key`; amanhã `csc` do 65) |
| Contrato oficial | `Infra-IA/setes-api/integracoes/nfe-sefaz/` (MOC 7.0, NT 2025.002 e vigentes, schemas PL, tabela de autorizadores, cStat) — 1ª tarefa técnica |
| Tela | aba **"Emissor fiscal"** no Meu Estabelecimento (certificado por ambiente + UMA linha por modelo + seção **"Numeração"** com buracos derivados e "Inutilizar faixa" + "SEFAZ disponível") · seção **"No fisco"** no documento faturado do PEDIDO (aba Faturados: linha do tempo por ramo, Transmitir / Consultar / DANFE / Cancelar NF-e) · lote "Transmitir pendentes"; sem lista nova |
| Endpoints | `POST /api/billing/transmit {orderId, branch}` · `POST /api/billing/fiscal/refresh` · `GET /api/billing/fiscal/:orderId` · `GET /api/billing/fiscal/:orderId/danfe` · inutilização e status na rota do Meu Estabelecimento (`.../issuer/void`, `.../issuer/status`) — `/api/billing/*` já é a exceção nomeada com resolver de interface por ramo (D-G29) |
| Privilégios | **TRANSMITIR** = privilégio de ação novo por ramo (o legado separava AUTORIZAR de faturar; seed no catálogo, tarefa de implantação); inutilização = admin (como o certificado) — Q-E14 |
| Códigos de erro | reusa `FISCAL_ISSUER_MISSING` · `FISCAL_CERT_MISSING/EXPIRED/INVALID` · `FISCAL_AUTHORITY_UNAVAILABLE` · `FISCAL_TRANSMISSION_IN_PROGRESS` · `FISCAL_ALREADY_AUTHORIZED` · `FISCAL_CANCEL_REFUSED`; generaliza `FISCAL_DPS_REJECTED` → **`FISCAL_DOCUMENT_REJECTED`** (com `authority_code`); novos **`FISCAL_DENIED`** · `FISCAL_NUMBER_VOIDED` · `FISCAL_VOID_RANGE_IN_USE` · `FISCAL_VOID_REJECTED` · `FISCAL_CANCEL_DEADLINE` (aviso 24 h) · `FISCAL_PARTIAL_CANCEL` · `INVOICE_MERCHANDISE_BRANCH_MISSING` · `INVOICE_NOT_ISSUER` (nota de terceiro) · `INVOICE_LEGACY_NOT_TRANSMITTABLE` |

**Palavras que ENTRAM na tabela de ocupadas do guardião ao fechar a Rodada 1** (somam às três da Onda 3 — transmissão · emissor · autoridade):
**chave** (`access_key` = chave de acesso do documento fiscal, 44 na NF-e — nossa — e 50 na NFS-e — do fisco; ≠ `tb_sync_api_key`, ≠ chave PIX, ≠ chave de config) · **inutilização** (`_number_void` = ato sobre a NUMERAÇÃO; nunca estado de nota) · **denegação** (kind `D` da VOZ; nunca evento da nota nem cancelamento) · **contingência** (atributo da tentativa, derivável do `tpEmis` da chave; nunca coluna do emissor) · **modelo** (`tb_invoice.model` `SE`/`55`/`65` — decide a autoridade e a série) · **série** (contador do emissor POR MODELO; a do 65 pode ser por terminal — onda do PDV) · **protocolo** (`nProt` da autorização/evento ≠ "protocolo" de atendimento ≠ `request_code` do banco) · **retorno** (`tb_invoice_return_*` = ESPELHO do desktop via sync; a voz nativa é `_transmission_event`) · **autorizar** (ato do FISCO — a nossa ação chama-se *Transmitir*; a tela nunca diz "Autorizar") · **evento** (já tem 4 usos: `tb_invoice_event`, `tb_check_event`, `_registration_event`, "evento" da SEFAZ — para o fisco diga *voz* (tabela) ou *ato* (nosso pedido: cancelamento, CC-e, inutilização)).

## 5. Fora de escopo desta onda
Modelo 65/NFC-e e PDV (onda própria; forma já comporta) · contingência (SVC/EPEC/FS-DA/off-line) · carta de correção · nota complementar/ajuste (`finNFe` 2/3) · DF-e distribuição (compra) · manifestação do destinatário · e-mail automático pós-autorização (config do emissor depois) · IBS/CBS no motor e nos itens (pré-requisito, fase própria — Q-E17) · produção real (URL, cofre fora do deploy, A1 real do primeiro cliente com mercadoria) · destino das tabelas `tb_nfe_*` do baseline (Q-E18).

## 6. Critérios de sucesso (testáveis)
1. Habilitação `('55', H)` na MESMA tabela/aba/cofre da NFS-e; o mesmo A1 serve às duas linhas do mesmo ambiente; sem `.pfx`/senha em lugar nenhum; `serie` única fonte (config `invoice_serie` aposentada).
2. Transmitir → S com `access_key` nossa; 104+100 → A com protocolo/`dhRecbto`/`nfeProc` em disco e DANFE abrindo; 105 → P com recibo e `queryReceipt` fecha A/R/D; rejeição → R legível e `attempt + 1` só após resolver a anterior; timeout → nada fecha, reconciliação pela nossa chave; 656 nunca ocorre (rodízio); nota de terceiro/legado/sem ramo → 409/422 legíveis.
3. Denegada → D gravado, sem efeito automático, pendência visível; "Cancelar nota" não vai ao fisco, mantém a nota, pedido 'C' + cópia; número não reaproveitável nem inutilizável.
4. Cancelar: bloqueios locais ANTES do fisco; 24 h avisado, recusa 220 repassada; 135 → voz C + C local na mesma transação; conjugada → dois pedidos, parcial visível e retomável; ambíguo → K bloqueante até reconciliar.
5. Inutilizar faixa com nota viva → 409; faixa homologada (102/206) → contador nunca devolve número da faixa (prova: cancelar a última nota pendente, inutilizar seu número, faturar de novo → número seguinte); buracos derivados batem com a numeração.
6. Gates socrático ≥ 0.70 e adversarial sem HIGH (corridas: duas transmissões da mesma nota; transmissão × cancelamento; inutilização × faturamento concorrente; consulta 2× com a mesma voz não duplica evento).

## 7. ⚠️ Rodada 1 — questões para o Valdo (recomendação entre parênteses)

Onde a simetria é OBRIGATÓRIA (mesma peça) e onde seria MAQUETE está na tabela do §3; as questões abaixo marcam o que precisa de decisão — várias reabrem, de propósito, itens ainda abertos da Onda 3, porque agora custam zero e depois custam migration.

- **Q-E1** PK de `tb_establishment_issuer`: **`(tb_institution_id, model)`** com autoridade derivada do modelo × `(…, authority)` da Onda 3 (Q-N4). *(Rec.: `model` — 55 e 65 partilham autoridade e certificado mas não série/ambiente/CSC; `authority` seria coluna derivável; a Onda 3 ainda não tem DDL.)*
- **Q-E2** Série = coluna `serie` do emissor por modelo (fonte única; aposenta a config `invoice_serie` e o `dps_serie`) × manter a config para o 55 e `dps_serie` para o DPS. *(Rec.: coluna do emissor; implantação: copiar `invoice_serie` para a linha 55 ao criar a habilitação.)*
- **Q-E3** `simples_regime` (opSimpNac) sai da linha do emissor e vai para o regime do emitente (`tb_entity_tax` da institution, ao lado do `taxRegime`/CRT) — fato do EMITENTE, consumido pelos dois fiscos. *(Rec.: sim.)*
- **Q-E4** `active` na habilitação × presença (`environment` + certificado válido decide). *(Rec.: presença; "desligar" = apagar a linha/soft-delete.)*
- **Q-E5** Autorizadora derivada (UF do endereço fiscal `main='S'` da institution + modelo + ambiente) como constante versionada em `adapters/sefaz.ts`; confirmar que o endereço `main` é o fiscal. *(Rec.: sim; é fato, não escolha.)*
- **Q-E6** UMA composição `@shared/invoice-transmission` com estratégias por ramo (renomeando a da Onda 3 antes de nascer) × duas composições irmãs. *(Rec.: uma — a política do fisco não pode bifurcar; o ramo é estratégia, não flag.)*
- **Q-E7** Denegada: voz D sem efeito automático + pendência; cancelamento local mantém a nota (fisco registrou) e não vai ao fisco × tratar como cancelamento automático (ramo 5 do legado). *(Rec.: sem efeito automático; kind existe mesmo se a Receita não denegar mais — Decisão 4 do vault.)*
- **Q-E8** Pedido de nota registrada no fisco (A cancelada ou D) → `'C'` + cópia de ordem (#20) — nasce nesta onda (é a 1ª vez que uma nota mantida impede o refaturamento na mesma identidade). *(Rec.: nesta onda; a cópia é peça de pedido, não de nota.)*
- **Q-E9** `dhEmi` = instante da assinatura (`dh_emission` na transmissão); no A o cabeçalho `tb_invoice.dt_emission` espelha a data fiscal (AUT-03 do legado) × cabeçalho intocado (data do faturamento; risco de rejeição 228 se transmitir > 30 dias depois). *(Rec.: espelhar no A, só o cabeçalho — títulos e vencimentos NÃO mudam; o E da nota guarda a data original no snapshot.)*
- **Q-E10** Pós-autorização: e-mail com XML + DANFE ao destinatário como ato explícito nesta onda; automático vira config do emissor depois (Q-N9 espelhada); mesmo hook serve à NFS-e. *(Rec.: sim.)*
- **Q-E11** Cancelamento da nota mercadoria+serviço: dois pedidos (NF-e primeiro), parcial = fato visível e retomável, C local só quando nenhum ramo restar autorizado × exigir pré-checagem dos dois prazos e recusar se um falhar × tudo ou nada (impossível: irreversível nos dois fiscos). *(Rec.: dois pedidos + parcial visível; pré-checar prazos só como AVISO.)*
- **Q-E12** Contingência fora da onda; quando entrar: ADD COLUMN `dh_contingency`/`contingency_reason` na transmissão + SVC no adaptador; `tpEmis` nunca vira coluna (está na chave). *(Rec.: fora; registrar EPEC como ato próprio futuro.)*
- **Q-E13** DANFE nesta onda (`@shared/danfe`, motor de PDF único com o DANFSe da Q-N13) × só XML. *(Rec.: nesta onda — sem DANFE a mercadoria não circula.)*
- **Q-E14** Privilégio TRANSMITIR novo, por ramo (`requirePrivilegeFor`), separado de FATURAR (como AUTORIZAR no legado); inutilização e certificado = admin. *(Rec.: sim; seed + tarefa de implantação, como CANCELAR/DESCONTO.)*
- **Q-E15** Devolução: `finality` escrita por `issueInvoice` por presença do ramo; `refNFe` = chave autorizada da transmissão da venda-âncora; devolução de venda cuja NF-e não foi autorizada → 422 (`refNFe` obrigatório no finNFe 4). *(Rec.: sim; venda do legado autorizada no desktop usa a chave do `tb_invoice_return_55.file_name` — leitura, nunca escrita.)*
- **Q-E16** Modelo 65 = onda própria; o único ponto que pode pedir forma nova é a série POR TERMINAL. Reservar a decisão para lá, sem coluna agora. *(Rec.: sim.)*
- **Q-E17** IBS/CBS (NT 2025.002): motor + `tb_order_item_ibscbs` + grupo no XML são PRÉ-REQUISITO de qualquer NF-e em produção em 2026 — fase própria ANTES da execução desta onda (o legado já grava `TB_IBSCBS*`; a Onda 3 tem a Q-N14 gêmea). *(Rec.: abrir como fase da tributação, mesma mesa da Q-N14 — um só desenho de IBS/CBS para os dois documentos.)*
- **Q-E18** `tb_nfe_events`, `tb_nfe_events_sent`, `tb_nfe_sequences`, `tb_nfe_series` (baseline, sem produtor em api e sync): (a) deixar como estão até a Rodada 4 do sync dizer se as usa · (b) DROP por migration. *(Rec.: (a) — regra "tabela sem consumidor não é morta"; registrar que a emissão nativa NUNCA as toca.)*
- **Q-E19** Levantamento do contrato oficial da SEFAZ (MOC 7.0, NTs vigentes, schemas PL, tabela de autorizadores, cStat) em `integracoes/nfe-sefaz/` como 1ª tarefa técnica — e homologação da SEFAZ-PR com o A1 de qual empresa? (a Setes não emite 55; homologação aceita qualquer A1 válido). *(Rec.: A1 da Setes em H para provar transporte/assinatura/inutilização; a 1ª NF-e real é do 1º cliente com mercadoria.)*
- **Q-E20** Quando EXECUTAR: (a) só o DDL/peças comuns junto com a Onda 3 (emissor com PK por modelo, `@shared/invoice-transmission`, `xmldsig`), NF-e propriamente dita quando houver cliente com mercadoria · (b) tudo agora, provado em homologação · (c) só desenho, nada agora. *(Rec.: (a) — a simetria se garante nas peças comuns nascendo certas; o adaptador SEFAZ, a inutilização e o DANFE esperam o fato gerador: um cliente que vende mercadoria.)*

## 8. Decisões registradas

**Rodada 1 DECIDIDA (Valdo 2026-09-21: "siga as recomendações nas duas rodadas").** D-E1…D-E25 = as recomendações do
§7 e do §9.4, na íntegra: **D-E1** PK do emissor por MODELO · **D-E2** `serie` no emissor (aposenta `invoice_serie`
e `dps_serie`; implantação copia a config para a linha 55/SE) · **D-E3** `simples_regime` no emitente · **D-E4**
habilitado = presença (linha + certificado válido), sem `active` · **D-E5** autorizadora derivada (UF do endereço
`main='S'`) como constante do adaptador · **D-E6** UMA composição `@shared/invoice-transmission` com estratégia por
ramo · **D-E7** denegada = voz D sem efeito automático, nota mantida · **D-E8** pedido de nota registrada no fisco →
'C' + cópia de ordem (#20) · **D-E9** `dhEmi` = instante da assinatura; no A o cabeçalho espelha a data fiscal (só
`dt_emission`) · **D-E10** e-mail pós-autorização como ato explícito, mesmo hook para os dois documentos · **D-E11**
conjugada = dois pedidos, parcial visível; prazos só como aviso · **D-E12** contingência fora · **D-E13** DANFE
nesta família (`@shared/danfe`, motor único com o DANFSe) · **D-E14** privilégio TRANSMITIR por ramo; inutilização e
certificado = admin · **D-E15** devolução: `finality` por presença, `refNFe` = chave autorizada da âncora (⚠️ *`refNFe` SUPERADO pela D-NE103, §13.10 — referência POR ITEM*) · **D-E16**
modelo 65 = onda do PDV · **D-E17** IBS/CBS = fase própria ANTES da produção, mesma mesa da D-N14 · **D-E18** `tb_nfe_*`
ficam como estão (sem produtor; a emissão nativa nunca as toca) · **D-E19** contrato da SEFAZ = 1ª tarefa técnica da
NF-e; homologação com o A1 da Setes · **D-E20 (a)** executar AGORA só as peças comuns junto com a Onda 3; adaptador
SEFAZ, inutilização, DANFE e configs `danfe_*` esperam o 1º cliente com mercadoria · **D-E21** código do destinatário
no `xNome` morre · **D-E22** A3 fora por construção (aviso no upload) · **D-E23** `special_tax_regime`, `simples_regime`
e `cnae` em `tb_entity_tax` (migration da habilitação) · **D-E24** configs de comportamento na interface `billing`;
`cashier_block_on_pending_fiscal` na do caixa (quando o caixa consumir) · **D-E25** `danfe_*` nascem com a peça.

## 10. O que da NF-e entra AGORA (D-E20 (a)) — executado junto com a Onda 3
1. `tb_establishment_issuer` já nasce com PK `(tb_institution_id, model)`, `environment`, `serie` (sem `csc_id` — a
   coluna só nasce com o 65, D-E16).
2. `tb_entity_tax` ganha `simples_regime`, `special_tax_regime`, `cnae` (D-E23) — aba Tributação.
3. `tb_invoice_event`: comentário do `kind` liberado (D-N1: T A R D I deixam de ser reservados).
4. `@shared/tax-authority` com `xmldsig.ts` paramétrico (algoritmo/referência) e `adapters/adn.ts`; nenhum esqueleto
   de `sefaz.ts` (nada antecipado) — a interface do adaptador já comporta.
5. `@shared/invoice-transmission` + `branches/service.ts`; `branches/merchandise.ts` só quando a NF-e executar.
6. Configs `fiscal_accountant_email`, `fiscal_email_copy_to_issuer`, `dps_description_format` na interface `billing`;
   `invoice_serie` migra para `tb_establishment_issuer.serie` (linha 55 criada pela migration a partir da config, se
   existir; linha SE nasce pela habilitação).
7. Motor de PDF escolhido UMA vez (`@shared/danfse` agora; `@shared/danfe` depois com o mesmo motor).
Tudo o mais da NF-e (transmissão de mercadoria, voz da SEFAZ, inutilização, DANFE, privilégio TRANSMITIR do ramo
mercadoria, cópia de ordem #20) fica para a execução da onda, com o fato gerador.

## 9. Enquadramento das CONFIGURAÇÕES do legado (Valdo, 2026-09-21) — `tas_gera_nfe_config` × `un_geranfe_Srv`

**Fontes lidas** (`D:\Gestao2016`): `view/module/operation/task/tas_gera_nfe_config.{pas,dfm}` (NF-e/NFC-e; 6 abas:
Geral · Arquivos · NFC-e · Outras informações · Certificado · NF-e) e `Ajuda/un_geranfe_Srv.{pas,dfm}` (NFS-e; aba
"Configurações" com sub-abas Certificado · WbService · Outras · Arquivos). Persistência do legado, em TRÊS lugares
(o sintoma que a web não repete): `TB_NF_ELETRONICA` (1 linha por estabelecimento, `model/tblNfEletronica.pas` —
ambiente, emissão, certificado, repositórios, orientação/canhoto do DANFE, duplicata, e-mail do contador, cópia,
IdToken/Token do NFC-e, versão), `TB_GERAL` chave/valor (`Fc_Tb_Geral`: NFE_SERIE, **NFE_SENHA_CERT** e NFS_SENHA_CERT
— senha em tabela, o anti-exemplo já registrado —, margens, lote/validade/rastreio, código do destinatário, bloqueio
do caixa, código de barras) e o **INI da estação** (`Fc_Aq_Geral`: libs SSL/Crypt/Http/XmlSign, tipo de certificado
A1/A3, TLS, porta/modelo/velocidade da impressora, ESC/POS, NFS_* idem). A NFS-e ainda tem um registro próprio por
estabelecimento (usuário/senha/frase do portal, caminhos, prefeitura, provedor, layout, versão, LC 116, CRET,
tributação municipal, CNAE, NBS, formato da discriminação).

**Princípio do enquadramento**: cada item do legado vai para UM de seis destinos, pelo fato gerador — nunca "uma
tabela de config da nota" (seria a `TB_NF_ELETRONICA` de novo, e o legado mostra que ela não bastou: vazou para
`TB_GERAL` e para o INI).

| Destino | O que é | Onde vive na web |
|---|---|---|
| **H — Habilitação** | fato de "este estabelecimento emite o modelo M": ambiente, série, identificador público do CSC | `tb_establishment_issuer` (PK institution × `model` — Q-E1), UMA linha por modelo |
| **S — Segredo** | credencial | `@shared/secret-store` owner `establishment`, por ambiente (`certificate.pem` + `private.key`; `csc` do 65) — nunca coluna |
| **E — Emitente** | fato fiscal da empresa, consumido por TODOS os documentos | `tb_entity_tax` da institution (CRT, regime especial/Simples, CNAE) + cadeia (IE/IM/endereço fiscal) |
| **C — Comportamento** | preferência de operação/renderização, mutável sem migration | Framework de Configurações (`tb_interface_has_config` × `tb_institution_has_config`), ancorada na interface `billing` (kind R, já ancora `invoice_serie`) ou na interface dona do efeito (caixa) |
| **A — Adaptador** | fato do mundo publicado pelo fisco (versão do layout, URL, autorizadora, algoritmo, prazos) | constante versionada em `@shared/tax-authority/adapters/*` — o cliente nunca escolhe |
| **X — Morre** | específico do desktop (biblioteca, porta COM, pasta local, ESC/POS) ou do provedor municipal (D1) | nada |

### 9.1 NF-e / NFC-e — `tas_gera_nfe_config` item a item

| Legado (aba · campo · chave) | Destino | Na web |
|---|---|---|
| Geral · Ambiente de Destino (`NFE_AMBIENTE`) | **H** | `tb_establishment_issuer.environment` H/P **por modelo** (55 em P e 65 em H é caso real de implantação) |
| Geral · Série da N.F (`TB_GERAL NFE_SERIE`) | **H** | `tb_establishment_issuer.serie` por modelo (Q-E2 — aposenta a config `invoice_serie`) |
| Geral · Forma de Emissão (Normal/Contingência/SCAN/DPEC/FDSA/SVCAN/SVC-RS — `NFE_EMISSAO`) | **X → ato** | NÃO é configuração: contingência é atributo da TENTATIVA (`tpEmis` na chave, Q-E12); SCAN/DPEC não existem mais. Quando entrar, é botão "Emitir em contingência" com motivo, nunca estado persistente que "esquece de voltar ao normal" (falha clássica do legado) |
| Geral · e-mail para envio da nota ao Contador (`NFE_EMAIL_CONTADOR`) | **C** | config `fiscal_accountant_email` (scope I, interface `billing`) — consumida pelo hook de pós-autorização (Q-E10); serve aos dois documentos |
| Geral · Receber cópia de NF-e no e-mail principal (`NFE_COPIA_EMAIL`) | **C** | config `fiscal_email_copy_to_issuer` (S/N) — idem |
| Geral · Visualizar Mensagem (`NFE_DFE_VISUALIZAR`) | **X** | UI do desktop (mostrar diálogo); na web a ponte de feedback sempre mostra |
| Geral · DANFE Retrato/Paisagem (`NFE_DFE_ORIENTACAO`) · Posição do Canhoto (`NFE_POS_CANH`) · NF-e · Margens esq/sup/inf (`NFE_MARGEM_*`) | **C** | configs de RENDER do DANFE (`danfe_orientation`, `danfe_stub_position`, `danfe_margins`) — só existem para o 55; nascem com a peça `@shared/danfe` (Q-E13), nunca colunas do emissor |
| Geral · Utilizar Nota Fiscal Duplicata (`NFE_DFE_DUP`/`FAT`) · Oculta pagamentos à vista (`NFE_OCUL_PAG_AVISTA`) | **C** | config `nfe_include_installments` (grupo `cobr`/`dup` no XML a partir das parcelas do pedido — `pag` é obrigatório sempre) e `nfe_hide_cash_installments`; conteúdo do XML decidido por preferência = config, não regra |
| Geral · Mostrar código do destinatário junto ao nome (`NFE_SHOW_COD_DESTINATARIO`) | **C** | config `nfe_recipient_code_in_name` — composição do `xNome`; candidata a morrer (a web tem o id na tela) — **Q-E21** |
| Geral · Bloquear fechamento de caixa com NF-e pendente (`NFE_BLOQUEIA_FECHA_CAIXA`) | **C (caixa)** | config `cashier_block_on_pending_fiscal` na interface do **caixa** (o efeito é lá); "pendente" = ramo com transmissão S/P/K ou nota com ramo nunca transmitido — leitura derivada da voz. Entra quando o caixa consumir |
| Arquivos · 7 pastas (NF-e/Cancelamento/CC-e/Inutilização/DPEC/Evento/NFC-e) + Salvar separado/mensal/literal/por emissão/por CNPJ/por modelo | **X → convenção** | `STORAGE_PATH/<cnpj>/<ano>/<mes>/<chave>-{nfe,can,cce,inu}.xml` — separação por CNPJ, mês e modelo é SEMPRE (a chave traz o modelo); nada configurável (precedente `/filexml` do sync) |
| NFC-e · Ativar NFC-e (`FRT_VDA_NFCE`) | **H** | = existência da linha `('65', environment)` na habilitação (Q-E4: presença decide) — onda do PDV |
| NFC-e · IdToken/IdCSC (`NFE_IDTOKEN`) · Token/CSC (`NFE_TOKEN`) | **H + S** | `csc_id` (identificador público, coluna da linha 65) + `csc` no cofre (`establishment/<inst>/<H|P>/csc`) — o legado guardava o CSC em COLUNA; onda do PDV |
| NFC-e · Porta/Modelo/Velocidade da impressora, linhas entre cupons, largura da bobina, ESC/POS, ativar na inicialização, imprimir automaticamente (`NFCE_*`, `FRT_ESCPOS`) | **X** | dispositivo da ESTAÇÃO, não do emissor — onda do PDV decide como o terminal imprime (nada no emissor) |
| NFC-e · Imprime desconto/acréscimo por item (`NFCE_SHW_DESCACRESITEM`) | **C (PDV)** | config de render do DANFE-NFC-e, onda do PDV |
| Outras · Preencher tag Lote (rastreio completo) · Preencher lote e validade · Mostrar lote (`NFE_SHOW_RASTREIO_COMPLETO`, `NFE_PREENCHE_LOTE_VALID`, `NFE_MOSTRA_LOTE`) | **C** | config `nfe_fill_batch_tracking` (grupo `rastro` por item); o DADO (lote/validade) é do item/estoque — sem ele a config não faz nada |
| NF-e · Não enviar o código de barras (`NFE_SEM_CODIGO_BARRAS`) | **C** | config `nfe_send_gtin` (S/N; `cEAN`/`cEANTrib` = "SEM GTIN" quando N ou quando o produto não tem) |
| Certificado · Carregar certificado / Nº de série (`NFE_CERTIFICADO`) · Senha (`TB_GERAL NFE_SENHA_CERT`) · Tipo A1/A3 (`NFE_TIPO_CERT`) | **S** | upload `.pfx` + senha → par PEM no cofre, senha nunca persistida (Q-N5); "nº de série" vira METADADO lido do PEM (`certificateInfo`: subject/validade), não campo. **A3 (token/smartcard) NÃO existe na web** — servidor não tem leitor; cliente com A3 precisa de A1 — **Q-E22** |
| Certificado · SSLType/SSLLib/CryptLib/HttpLib/XMLSignLib · SSL/TLS (`NFE_TIPO_SSL`, `NFE_SSLLib`…, `NFE_SSLTLS`) | **X** | escolha de biblioteca do ACBr na estação; na web é Node (`https` + `xmldsig.ts`) — TLS 1.2+ fixo |
| `TB_NF_ELETRONICA.NFE_VERSAO` (3.10/4.00) · `NFE_DFE_TIPO/COB` (não usados na tela) | **A / X** | versão do layout = constante do adaptador (`4.00`); campos mortos |

### 9.2 NFS-e — `un_geranfe_Srv` aba Configurações item a item

| Legado (sub-aba · campo) | Destino | Na web |
|---|---|---|
| Certificado (tipo A1/A3, nº de série, senha, libs) · WbService (SSLType, SSL/TLS) | **S / X** | idem 9.1 — **o MESMO A1 e o mesmo cofre** da NF-e (D-I1; §3.1). O legado pedia o certificado DUAS vezes (NFE_* e NFS_*): a web pede uma |
| WbService · Ambiente de Destino | **H** | `tb_establishment_issuer.environment` da linha `SE` (H = produção restrita) |
| WbService · Acesso a Sistema Web: usuário, senha, frase secreta | **X** | credencial de portal de PROVEDOR municipal (ISSNet etc.); o Padrão Nacional autentica só por mTLS + assinatura (§1.1 da Onda 3). Morre com a D1 — e credencial nunca iria a coluna |
| Outras · Provedor (PadraoNacional/ISSNet…) · Layout · Versão (ve100…ve203) · Arquivo INI do provedor · Schemas do provedor | **A / X** | só Padrão Nacional (D1); versão/schemas = constante do adaptador `adn.ts` |
| Outras · Código Serviço LC 116 · Código Tributação Município · Código NBS | **já é DADO por serviço** | `tb_service_tax_rule` (item LC 116 + `municipal_code` + cidade) e `tb_service_list` (+ `national_code` — Q-N11; `nbs_code` idem se a DPS exigir — Q-N14). O legado tinha UM código global porque a empresa tinha um serviço; a web já resolve por serviço, congelado no ramo (§3 da Onda 3) |
| Outras · Código do Regime Especial de Tributação (CRET 00–08) | **E** | fato do EMITENTE: `tb_entity_tax` da institution ganha `special_tax_regime` (regEspTrib da DPS) ao lado do CRT/`taxRegime` — mesma mesa da Q-E3 (`simples_regime`/opSimpNac) |
| Outras · Código CNAE | **E** | `tb_entity_tax` da institution (`cnae`) — usado pela DPS quando exigido e pelo cadastro fiscal em geral; hoje não existe coluna — **Q-E23** |
| Outras · Formato da Discriminação (Nacional/…) | **C** | config `dps_description_format` (como o `xDescServ` é montado dos itens: nome · nome+qtd·valor · texto do pedido) — ancorada em `billing` |
| Outras · Visualizar Mensagem · Receber cópia no e-mail | **X / C** | idem 9.1 (`fiscal_email_copy_to_issuer` é UMA config para os dois documentos) |
| Arquivos · Pasta NFS-e · Pasta RPS · Nome da Prefeitura · Logo da Prefeitura | **X → convenção / DANFSe** | XML em `STORAGE_PATH/<cnpj>/<ano>/<mes>/`; não existe RPS no nacional; nome/logo do município saem do PAM/`tb_city` no render do DANFSe (peça nossa, NT 008) |
| Aba NFS-e · Informar Recibo/Lote manualmente · Forçar consulta quando autorizada | **X** | RPS/lote não existem no Padrão Nacional; "forçar consulta" é o `refresh` normal (reconciliação por chave), não opção |

### 9.3 A matriz que resulta — "o que a web precisa definir por emissor"

Para "dar suporte aos diferentes emissores" a definição é POR MODELO (linha da habilitação), e o resto é comum:

| | `SE` (NFS-e nacional) | `55` (NF-e) | `65` (NFC-e — onda do PDV) |
|---|---|---|---|
| **H** habilitação (linha) | `environment` H/P · `serie` (00001–49999) | `environment` · `serie` | `environment` · `serie` (talvez por terminal) · `csc_id` |
| **S** cofre por ambiente | `certificate.pem` + `private.key` (**compartilhados** pelos 3 modelos do mesmo ambiente) | idem | idem + `csc` |
| **E** emitente (uma vez) | CRT · `simples_regime` (opSimpNac) · `special_tax_regime` (regEspTrib) · `cnae` · IM · endereço fiscal | CRT · IE · endereço fiscal (UF → autorizadora) | idem 55 |
| **C** comportamento (Framework, interface `billing`) | `dps_description_format` · `fiscal_accountant_email` · `fiscal_email_copy_to_issuer` · (futuro: `fiscal_auto_transmit` — Q-N9/Q-E10) | `nfe_include_installments` · `nfe_hide_cash_installments` · `nfe_send_gtin` · `nfe_fill_batch_tracking` · `danfe_orientation` · `danfe_stub_position` · `danfe_margins` · os `fiscal_*` comuns | os `fiscal_*` comuns · render do cupom (PDV) |
| **C** em outra interface | — | `cashier_block_on_pending_fiscal` (caixa) | idem |
| **A** adaptador (constante) | Sefin Nacional · layout DPS 1.01 · algoritmo de assinatura · prazo do PAM lido em runtime | SEFAZ da UF · NF-e 4.00 · SHA-1 · 24 h · autorizadores | SEFAZ da UF · QR Code v2 · prazos em minutos |
| **X** não existe | libs SSL, provedor/layout/versão municipal, usuário/senha do portal, RPS/lote, pastas, prefeitura | libs SSL, forma de emissão como estado, pastas, margens como coluna | porta/modelo/velocidade da impressora, ESC/POS, largura da bobina |

Consequências para o desenho já feito: a aba **"Emissor fiscal"** do Meu Estabelecimento passa a ter três blocos —
(1) **Certificado por ambiente** (upload do A1 + validade, uma vez, serve a todos os modelos do ambiente), (2) **uma
linha por modelo** (ambiente, série, [csc_id], estado derivado "habilitado" = linha + certificado válido — Q-E4) e (3)
a seção **"Numeração"** (NF-e/NFC-e). As preferências (**C**) NÃO ficam nessa aba: ficam na engrenagem da interface
`billing` (Framework de Configurações), onde `invoice_serie` já vivia e de onde SAI (vira coluna H — Q-E2). Os fatos
do emitente (**E**) ficam na aba Tributação do Meu Estabelecimento, que já existe.

### 9.4 Questões que o enquadramento acrescenta à Rodada 1
- **Q-E21** `nfe_recipient_code_in_name` (código do destinatário no `xNome`): manter como config × deixar morrer.
  *(Rec.: morrer — o id do cliente está na tela e na nota; poluir o `xNome` do XML era muleta do desktop.)*
- **Q-E22** Certificado A3 (token/smartcard): fora por construção — a web só aceita A1 (`.pfx`). Cliente que só tem A3
  precisa emitir um A1. *(Rec.: registrar como restrição de produto, com aviso no upload.)*
- **Q-E23** Fatos do emitente que faltam em `tb_entity_tax`: `special_tax_regime` (regEspTrib, CRET 00–08 do legado),
  `simples_regime` (opSimpNac — Q-E3) e `cnae`. Entram na migration da habilitação (Onda 3), não na linha do emissor.
  *(Rec.: sim; aba Tributação do Meu Estabelecimento.)*
- **Q-E24** Onde ancorar as configs **C**: todas na interface `billing` (que já ancora `invoice_serie`) × interface
  própria "fiscal". *(Rec.: `billing` — é a interface que produz a nota; `cashier_block_on_pending_fiscal` na do caixa.)*
- **Q-E25** Configs de render do DANFE (`danfe_*`) nascem com a peça `@shared/danfe` (Q-E13/Q-E20a) ou só quando houver
  cliente de mercadoria? *(Rec.: junto com a peça; até lá não existem — nada de coluna/catálogo antecipado.)*

---

## 11. Rodada 0 da `nfe-api` — preparação (Valdo, 2026-10-10: "vamos nos preparar para montar a api-nfe")

> Este bloco NÃO decide: organiza o que existe, mede o esforço e numera as escolhas (Q-NE1…Q-NE26) com recomendação.
> Insumo: inventário de 2026-10-10 (só leitura, conferido por amostragem no disco — fatos marcados ✔ abaixo). Vale por
> cima das §3–§10 onde conflitar com as decisões das APIs isoladas (`prompt_apis_fiscais_isoladas.md` §7 — D-F1…D-F59, numeração unificada na reconciliação de 2026-10-10, §20 de lá).

### 11.1 O pedido e o que ele muda

A D-F20 (2026-10-03) diz "nfe-api sem código até o 1º cliente de mercadoria". O pedido é de **PREPARAÇÃO** — Rodada 0,
levantamento e o que dá para adiantar sem cliente —, não de código de emissão. Suspender a D-F20 (toda ou em parte) é a
Q-NE1. Nenhum cliente de mercadoria foi identificado no acervo.

### 11.2 Fatos (2026-10-10)

1. ✔ `D:\Gestao2027\nfe-api` só tem `CLAUDE.md`, `README.md`, `.gitignore` (1 commit). Repo `valdosouza/gestao-2027-nfe-api`
   privado. Nenhum material oficial da SEFAZ no acervo — `integracoes/nfe-sefaz/` não existe em nenhum dos três caminhos que
   os documentos citam (Q-NE19).
2. **D-E1…D-E25 todas decididas** (§8); nenhuma Q-E aberta. As D-F mudaram o ONDE (a NF-e nasce na nfe-api — D-F12/D-F17),
   a fronteira (a API lê o ERP e não aplica efeito — D-F10/D-F11/D-F28) e a série/número do 55/65 (ficam no ERP — D-F21).
3. **Núcleo `fiscal-api` que serve sem mudança**: pool/transação/`runShortCommand`, executor de migrations com namespace,
   JWT RS256, cofre AES-256-GCM do A1, habilitação por modelo (CHECK `SE/55/65` — D-F45), aluguel do rodízio por modelo,
   storage `<cnpj>/<H|P>/<ano>/<mês>`, fuso, e o `xmldsig` (enveloped, C14N inclusiva, Signature último filho do pai — confere
   com `infNFe`, `infEvento` e `infInut`).
4. **Núcleo com semântica de NFS-e** (a generalizar antes de a nfe-api nascer):
   - ✔ vocabulário da voz `S A R C K F N` (`fiscal-api/src/voice/kinds.ts`) sem **P** (em processamento, 103/105) nem **D**
     (denegada, 110/301/302/303 — D-E7);
   - contrato de leitura (`voice/reading.ts`) decide a vigente por "quem detém a chave" e o setes-api decide "registro
     fiscal" por `!!accessKey` — na NF-e a chave é NOSSA desde o envio;
   - ✔ `TLS_CREDENTIAL_CODES` (`transport/https-json.ts:104-109`) inclui `UNABLE_TO_GET_ISSUER_CERT_LOCALLY` e
     `SELF_SIGNED_CERT_IN_CHAIN`: falha da cadeia do SERVIDOR da SEFAZ viraria "fisco recusou o certificado do emissor";
   - transporte só JSON/ADN (`authorityJson`) — a SEFAZ é SOAP 1.2 com HTTP 200 + `cStat`;
   - cerca da virada por INSTITUTION (`emissionStillInErp`/`assertEmitterWritable`): a réplica SE da Setes bloquearia o 55
     (é a mesma lacuna do achado L5 do gate da Rodada 6 = **Q-F64** — era a Q-F58 desta máquina —, absorvida pela Q-NE10);
   - `terminal = 0` fixo na fonte de fatos base (`erp/facts.ts`);
   - a "máquina tentativa × voz" prometida ao núcleo (§12.1 das APIs isoladas) vive em `nfse-api/src/nfse/transmission.ts`
     (945 linhas); motor de PDF (`pdfkit`) só na nfse-api; `/v1/emitter` (A1 + habilitação) só na nfse-api e só SE.
5. **Lado do produto (ERP)**: o motor por item já congela ICMS/CSOSN/ST/FCP/IPI/PIS/COFINS/II em 6 snapshots, financeiro e
   `tPag`. **Faltam**: IBS/CBS (bloqueia produção do regime regular), DIFAL, ST retido, valor do ICMS desonerado,
   GTIN/unidade congelados, transporte/volumes sem produtor web, ✔ `finality` não gravado pelo `issueInvoice`, `indPres` fixo
   0, `dt_exit`, `natOp` sem fonte, `cBenef` sem leitor, o 65 nunca é cunhado, numeração que respeite faixas inutilizadas,
   TRANSMITIR em `order-returns` (seed 59 só liga `service-orders`/`orders`).
6. ✔ **A Setes não tem IE** (`setes_central.tb_company.ie` NULL — é prestadora de serviço): a homologação COMPLETA da NF-e
   (autorização) com o A1 da Setes é duvidosa — a SEFAZ costuma recusar emitente sem IE (230/209). Serviços sem emitente
   (status, consulta) servem para provar o adaptador. → Q-NE18.
7. ✔ Referência local de TERCEIRO (não oficial): `D:\Componentes\acbr\Exemplos\ACBrDFe\Schemas\NFe\` (201 XSD, inclusive com
   `IBSCBS`) e `ACBrNFeServicos.ini` (URLs por UF × ambiente) — serve para conferir o levantamento oficial, nunca substitui.
8. **IBS/CBS (D-F22/D-E17) — a fase própria NÃO tem prompt.** O marco de 01/01/2027 já obriga pela NFS-e da Setes (Simples),
   independente da NF-e. Recomendação desta rodada: abrir o prompt da fase IBS/CBS já, em paralelo.

### 11.3 Superado ou em conflito (D-E × D-F)

| D-E (este prompt) | D-F (APIs isoladas) | Vale |
|---|---|---|
| D-E2 série no emissor por modelo | D-F21 série/nº do 55/65 no ERP; D-F42 linha 55/65 do ERP = série da nota | **D-F21** → Q-NE11 |
| D-E6 UMA composição no setes-api | D-F12/D-F17 duas famílias + núcleo | **D-F** — a política comum vai ao NÚCLEO (Q-NE13) |
| D-E9 cabeçalho espelha `dt_emission` no A | D-F31 API fiscal não escreve dado do ERP; D-F28 sem job | **conflito sem dono** → Q-NE21 |
| §3.5/§3.9 voz C + C local na mesma transação | D-F11/D-F28 C local é do setes-api; pendência derivada | **D-F** |
| §3.3 coluna `invoice_event` na voz | D-F28/D-F30 sem coluna de efeito; `life_event` na tentativa | **D-F** → Q-NE7 |
| §3.8 interface genérica de autoridade no setes-api | D-F17 dialeto na família | **D-F** → Q-NE5 |
| §4 rotas `/api/billing/*` | D-F4/D-F8 app chama `/v1/nfe/*` na família | **D-F** |
| §3.11 plano de cancelamento lê transmissões locais | D-F11/D-F33 setes-api lê VIEWs do `fiscal_api` | **D-F** (F2a precisa ler também a view da NF-e) |
| D-E20 (a) peças comuns no setes-api agora | D-F20 pasta sem código | D-F20 para o ONDE; o QUANDO = Q-NE1 |

### 11.4 Ondas e esforço (sessão ≈ 4 h com testes verdes; ±40 %)

| Onda | Entrega | Sessões | Depende de |
|---|---|---|---|
| **NE-0** | Rodada 1 (Q-NE*); levantamento oficial em `integracoes/nfe-sefaz/` (MOC 7.0, NTs vigentes incl. RTC, pacote PL, WSDL dos 6 serviços, autorizadores, cStat, prazos, cadeia TLS, homologação PR); parecer do guardião + `revisar-ddl` do DDL da família; OpenAPI `nfe-api.v1.yaml` design-first | 3–4 | Valdo |
| **NE-1** | núcleo generalizado: cerca por família (Q-NE10), emitter no núcleo (Q-NE9), `terminal` (Q-NE12), vocabulário P/D + contrato de leitura (Q-NE14), máquina comum (Q-NE13), TLS `ca` (Q-NE17), base de PDF (Q-NE20) — re-prova da nfse-api inteira + gate do delta | 4–6 | gate da Rodada 6 fechado; dual-run |
| **NE-2** | esqueleto da nfe-api (molde da nfse-api) + DDL da família (transmissão, voz, inutilização) + views para o setes-api | 2–3 | NE-0, NE-1 |
| **NE-3** | adaptador SEFAZ (SOAP 1.2, `authorizers.ts`, autorização síncrona + recibo, consulta, evento 110111, inutilização, XSD) + smoke H parcial | 5–7 | NE-2; credencial (Q-NE18) |
| **NE-4** | fonte de fatos da mercadoria + builder NF-e 4.00 + chave 44/cDV | 5–7 | NE-3; NE-6 |
| **NE-5** | composição (transmitir/consultar/reconfirmar/cancelar/inutilizar/rodízio) + DANFE A4 + rotas `/v1/nfe` + gates (≥ 3 rodadas) | 5–8 | NE-4 |
| **NE-6** | ERP: lacunas de conteúdo (Q-NE15), numeração × inutilização (Q-NE8), plano de cancelamento lendo a NF-e, TRANSMITIR em `order-returns` | 4–6 | F2a |
| **NE-7** | setes-app: datasource da nfe-api, "No fisco" no pedido, numeração, DANFE | 3–5 | F2b |
| **F4 total** | | **31–46** (≈ 7–10 semanas) | acima dos 25–35 do §12.7: o núcleo precisa generalizar e o ERP tem lacunas de conteúdo |
| parte SEM cliente de mercadoria | NE-0…NE-3 | **14–20** | A1 vigente para o smoke |
| **F5 — NFC-e 65** | QR/CSC cifrado, off-line tpEmis 9, série por terminal, DANFE bobina | 15–25 | F4 + onda do PDV |

### 11.5 ⚠️ Rodada 1 da nfe-api — questões para o Valdo (recomendação entre parênteses)

**A. Estratégicas — decidem o rumo**

- **Q-NE1 Suspender a D-F20?** (a) manter integral — só documentos (NE-0) · (b) **suspender em PARTE: NE-0…NE-3**
  (levantamento, núcleo generalizado, esqueleto, DDL, adaptador SEFAZ provado em H só nos serviços que não exigem emitente com
  IE) — sem builder de autorização em produção · (c) suspender inteira. *(Rec.: (b), com NE-1 ANTES da F2a: o contrato de
  leitura que a F2a vai importar no setes-api é hoje só-NFS-e — generalizar depois custa o dobro. (c) está bloqueada por IE
  e IBS/CBS.)*
- **Q-NE2 55 antes do 65?** (a) **55 primeiro (F4); 65 com a onda do PDV (F5 — D-E16)**, generalizando já o que vira
  migration depois (`terminal`, casa cifrada do CSC) · (b) juntos · (c) 65 primeiro (a escala da NFC-e). *(Rec.: (a) — o PDV
  não existe e o faturamento nunca cunha 65.)*
- **Q-NE3 Autorizadora/UF.** (a) **tabela completa (27 UF + SVRS/SVAN + SVC-AN/RS + AN) como constante versionada;
  homologação na UF do 1º cliente** · (b) só PR + SVRS · (c) esperar o cliente. *(Rec.: (a) — é dado, não código.)* Fato a
  obter: UF e regime (Simples × regular) do 1º cliente de mercadoria.
- **Q-NE4 IBS/CBS.** (a) **fase própria ANTES da produção (D-E17/D-F22), com prompt aberto JÁ** — motor no ERP + builder do
  grupo em cada família · (b) builder dentro da F4, motor na fase própria · (c) 1º cliente Simples vai à produção sem IBS/CBS
  até 31/12/2026. *(Rec.: (a); a fase é obrigatória de qualquer jeito pela NFS-e da Setes em 01/01/2027.)*
- **Q-NE18 Credencial para homologação.** (a) Setes obtém IE (não faz sentido para prestadora) · (b) A1 + IE de um
  cliente-piloto de mercadoria · (c) **H parcial com o A1 da Setes renovado (status/consulta; inutilização se aceita sem IE)
  e autorização em H com o cliente-piloto**. *(Rec.: (c).)*
- **Q-NE25 Escopo do 1º release da F4.** (a) **venda (finNFe 1) + devolução (finNFe 4, `refNFe` da âncora — D-E15)** ·
  (b) só venda · (c) + entrada própria. CC-e, complementar, manifestação e DF-e seguem fora. *(Rec.: (a) — a devolução já
  tem módulo; exige TRANSMITIR em `order-returns`.)*

**B. Desenho — o guardião opina antes do DDL**

- **Q-NE7 Identidade da declaração.** (a) **`life_event` na tentativa (molde D-N27/D-F30) + chave nova por tentativa só
  depois de a anterior estar resolvida (R ou F conclusiva)** · (b) chave por vida com `dhEmi` congelado · (c) chave por
  tentativa sem vida. *(Rec.: (a); a chave carrega o AAMM do `dhEmi` e o nº do ERP pode ser reaproveitado no revive — D4.)*
- **Q-NE8 Inutilização × numeração do ERP.** (a) **faixa inutilizada no `fiscal_api` (dono = nfe-api, ato ao fisco) +
  VIEW; o setes-api lê a view ao cunhar** (leitura passiva, molde D-F11/D-F33) · (b) faixa como fato do ERP (nfe-api
  escreveria no ERP — lista da D-F31) · (c) só se inutilizam buracos internos. *(Rec.: (a).)*
- **Q-NE9 Dono do A1 e da habilitação com duas famílias.** (a) cada família com seu `/v1/emitter` · (b) A1 só pela
  nfse-api · (c) **módulo emitter no NÚCLEO, montado pelas duas, com "transmissões vivas" por família na guarda do DELETE do
  A1** (resíduo do §15.4 das APIs isoladas). *(Rec.: (c).)*
- **Q-NE10 Cerca da virada por família (absorve a Q-F64 — ex-Q-F58 — do gate da Rodada 6).** (a) **55/65 nascem virados e não dependem
  da SE; a lacuna (b) olha a LINHA SE; escrita do A1 (comum) segue barrada enquanto houver réplica** · (b) nfe-api só para
  institution já virada na NFS-e ou sem SE no ERP. *(Rec.: (a) — coerente com a D-F42.)*
- **Q-NE11 Série do 55.** (a) **linha 55/65 do `fiscal_api` SEM série (regra/CHECK) + série editada no ERP (Meu
  Estabelecimento)**; a nfe-api só exibe · (b) série no `fiscal_api` lida pelo ERP (contradiz a D-F21). *(Rec.: (a).)*
- **Q-NE12 `terminal ≠ 0`.** (a) **parametrizar já as assinaturas do núcleo (comportamento 0 até a F5)** · (b) na F5.
  *(Rec.: (a) — antes de a F2a importar o contrato.)*
- **Q-NE13 Máquina tentativa × voz.** (a) **extrair a política comum para o núcleo ANTES da nfe-api, provada pela suíte da
  nfse-api e gate do delta** · (b) a nfe-api escreve a sua e extrai depois (regra dos 3 casos) · (c) nfe-api importa da
  nfse-api. *(Rec.: (a), depois do gate da Rodada 6 e com a nfse-api ainda em dual-run — risco controlado pela suíte.)*
- **Q-NE14 Vocabulário e leitura da voz para duas famílias.** (a) **vocabulário comum estendido (P, D) + "registro fiscal"
  por FATO (protocolo/voz A ou D em P) + `TransmissionView` com parte comum e parte da família** · (b) contrato por família.
  *(Rec.: (a) — uma fonte só; decidir ANTES da F2a.)*
- **Q-NE21 `dhEmi` × cabeçalho do ERP (D-E9 × D-F31).** (a) setes-api espelha `dt_emission` ao ler a voz A · (b) **não
  espelhar: a data fiscal é DERIVADA da view; o cabeçalho guarda a data do faturamento** · (c) a nfe-api escreve (lista
  D-F31). *(Rec.: (b) — fato fiscal derivado, nunca copiado; conferir relatórios/SPED.)*
- **Q-NE22 Cancelar nota conjugada entre DUAS APIs (D-E11).** (a) **saga do app: plano (setes-api) → cancel na nfe-api →
  cancel na nfse-api → C local quando nenhum ramo restar autorizado; parcial = pendência derivada nas duas views** · (b)
  setes-api orquestra (viola D-F4). *(Rec.: (a).)*

**C. Técnicas — com recomendação; "siga as recomendações" basta**

- **Q-NE5 SOAP:** (a) **núcleo ganha só o comum ao TLS de cliente (`ca`, agent, separar falha de cadeia do servidor de
  falha de credencial); envelope SOAP 1.2 e tradução cStat na nfe-api** · (b) `authoritySoap` genérico no núcleo · (c) lib
  SOAP de terceiros. *(Rec.: (a).)*
- **Q-NE6 Contingência:** (a) **fora da F4 (D-E12); SVC reabre antes da produção do 1º cliente** · (b) SVC na F4 · (c) EPEC.
  *(Rec.: (a).)*
- **Q-NE15 Lacunas de conteúdo no ERP:** (a) onda ERP própria congelando tudo · (b) nfe-api lê na transmissão com defaults
  legais · (c) **misto: estrutural no ERP (finality, indPres, dt_exit, transporte, DIFAL, ST retido, fatos de produto usados no
  cálculo); cosmético por default/config ("SEM GTIN", natOp do CFOP)**. *(Rec.: (c) — conteúdo é do ERP.)*
- **Q-NE16 Validação XSD local:** validar SEMPRE antes de enviar (o legado validava; rejeição custa `attempt + 1`); a
  ferramenta (libxmljs2 × xmllint × JVM) se escolhe depois do levantamento. *(Rec.: validar.)*
- **Q-NE17 TLS do servidor da SEFAZ:** (a) **cadeia ICP-Brasil versionada no adaptador (`ca` por chamada) + classificação
  separada** · (b) `NODE_EXTRA_CA_CERTS` · (c) `rejectUnauthorized: false` — NUNCA (conhecimento negativo). *(Rec.: (a).)*
- **Q-NE19 Casa do levantamento oficial:** (a) **`Infra-IA/nfe-api/integracoes/nfe-sefaz/`** e mover `nfse-adn` para
  `Infra-IA/nfse-api/integracoes/` (promessa antiga do INDEX do núcleo) · (b) `Infra-IA/setes-api/integracoes/`. ACBr local só
  como conferência. *(Rec.: (a).)*
- **Q-NE20 PDF:** (a) **base de PDF no núcleo (fontes, carimbo CANCELADA, código de barras), DANFE na nfe-api** · (b) cada
  família com o seu. *(Rec.: (a) — D-E13 "motor único".)*
- **Q-NE23 E-mail pós-autorização (D-E10):** (a) **nfe-api (tem XML e DANFE; configs lidas do ERP)** · (b) setes-api ·
  (c) o app anexa. *(Rec.: (a), sempre ato explícito — D-F5.)*
- **Q-NE24 Resíduos do baseline com segredo em claro** (`tb_config_nfe.certificate_pass`, `tb_config_nfe_65.token_nfce`,
  `tb_msg_return_nfe`): (a) **regra da D-E18 (ficam, a emissão nativa nunca toca) + contar conteúdo (sem expor) e expurgar
  segredo se houver** · (b) DROP. *(Rec.: (a) — tabela sem consumidor não é morta, mas segredo em claro é achado de
  segurança.)*
- **Q-NE26 Rodízio da NF-e (análogo D-F38):** (a) **teto = prazo de cancelamento da UF + margem; autorizadas só sob
  demanda; vivas/ambíguas com intervalo mínimo (cStat 656 — consumo indevido)** · (b) igual à NFS-e. *(Rec.: (a).)*

### 11.6 Correções de documentação achadas (sem decisão — feitas nesta rodada)

`nfe-api/CLAUDE.md` citava D-F1…D-F26 e "não escreve no ERP" (a D-F31 admite a trava da nota); `Infra-IA/fiscal-api/INDEX.md`
falava de `tb_emitter`/`tb_issuer` (mortos pela D-F34) e "trava nomeada" (morta pela D-F27).

### 11.7 Rodada 1 da `nfe-api` DECIDIDA (Valdo 2026-10-10: "siga as recomendações") — D-NE1…D-NE26

Cada D-NE*n* = a recomendação da Q-NE*n* (§11.5). As que mudam o rumo:

| Decisão | O que fixa |
|---|---|
| **D-NE1** | a **D-F20 fica SUSPENSA EM PARTE**: NE-0…NE-3 têm código (levantamento, núcleo generalizado, esqueleto + DDL da família, adaptador SEFAZ provado em H nos serviços sem emitente com IE); builder de autorização em produção espera o 1º cliente de mercadoria. **O núcleo generalizado (NE-1) vem ANTES da F2a** |
| **D-NE2** | 55 primeiro (F4); 65 com a onda do PDV (F5) — mas `terminal` e a casa cifrada do CSC já nascem generalizados |
| **D-NE3** | `authorizers.ts` = tabela COMPLETA (27 UF + SVRS/SVAN + SVC-AN/RS + AN) como constante versionada; homologação na UF do 1º cliente |
| **D-NE4** | IBS/CBS = fase PRÓPRIA antes de qualquer produção, **prompt aberto JÁ** (o marco de 01/01/2027 já obriga pela NFS-e da Setes) |
| **D-NE18** | homologação PARCIAL com o A1 da Setes (status/consulta; inutilização se aceita sem IE); autorização em H com um cliente-piloto de mercadoria (a Setes não tem IE) |
| **D-NE25** | 1º release = venda (finNFe 1) + devolução (finNFe 4, `refNFe` da âncora); exige TRANSMITIR em `order-returns` — ⚠️ *a parte "`refNFe` da âncora" foi SUPERADA pela **D-NE103** (2026-10-15, §13.10): a devolução referencia POR ITEM (`DFeReferenciado`), `refNFe` proibido (rej. 321)* |

Desenho (o guardião opina no DDL da NE-2): **D-NE7** `life_event` na tentativa + chave nova só com a anterior resolvida ·
**D-NE8** faixa inutilizada no `fiscal_api` + VIEW lida pelo setes-api ao cunhar · **D-NE9** módulo emitter no NÚCLEO com
"transmissões vivas" por família · **D-NE10** cerca por família (55/65 independentes da SE; a lacuna (b) pela linha SE já é a
D-F57) · **D-NE11** linha 55/65 do `fiscal_api` sem série; série editada no ERP · **D-NE12** `terminal` parametrizado já ·
**D-NE13** máquina tentativa × voz extraída para o núcleo antes da nfe-api (provada pela suíte da nfse-api + gates) · **D-NE14**
vocabulário comum com P e D + "registro fiscal" por FATO · **D-NE21** `dhEmi` NÃO espelhado no cabeçalho (derivado da view) ·
**D-NE22** cancelamento da conjugada = saga do app.

Técnicas: **D-NE5** núcleo só com o comum ao TLS de cliente; SOAP e cStat na nfe-api · **D-NE6** contingência fora da F4 (SVC
reabre antes da produção do 1º cliente) · **D-NE15** lacunas do ERP: estrutural no ERP, cosmético por default/config · **D-NE16**
validação XSD local sempre (ferramenta após o levantamento) · **D-NE17** cadeia ICP-Brasil versionada no adaptador, falha de cadeia
do servidor ≠ credencial; `rejectUnauthorized: false` NUNCA · **D-NE19** levantamento em `Infra-IA/nfe-api/integracoes/nfe-sefaz/`
(e `nfse-adn` muda para `Infra-IA/nfse-api/integracoes/`); ACBr local só como conferência · **D-NE20** base de PDF no núcleo, DANFE
na nfe-api · **D-NE23** e-mail pós-autorização pela nfe-api, sempre ato explícito · **D-NE24** resíduos com segredo em claro
ficam (regra D-E18), conteúdo contado sem expor e segredo expurgado se houver · **D-NE26** rodízio com teto pelo prazo de
cancelamento da UF + intervalo mínimo (cStat 656).

**Próximos passos (ordem)**: (1) gate adversarial do delta fiscal desta sessão (APIs isoladas §17.8); (2) **prompt da fase
IBS/CBS** (D-NE4 — Rodada 0); (3) **NE-0**: levantamento oficial (D-NE19) + OpenAPI design-first + parecer do guardião sobre o
DDL; (4) **NE-1** (núcleo generalizado — antes da F2a); (5) F2a/F2b da NFS-e em paralelo com NE-2/NE-3.
*(Ajustado pelo §12.4 — NE-1 partida em 1a/1b; o calendário com um executor é serial. Refinadas pela Rodada 2 (§12.7): D-NE3 →
D-NE37 (rota pela tentativa, dimensão serviço/evento) · D-NE16 → D-NE43 (pré-validação em três camadas) · D-NE20 → D-NE32 (lib
única de barras/QR) · D-NE23 → D-NE53 (anexo = XML da voz). A tabela de ondas do §11.4 vale pelo §12.3.)*

## 12. Planejamento da `nfe-api` a partir da leitura do ACBr (2026-10-10) — Rodada 2 da nfe-api

> Pedido do Valdo (2026-10-10): "vamos fazer o planejamento da api-nfe lendo um componente conhecido do acbr, use os agentes de
> legacy system". Este bloco NÃO decide: ajusta as ondas NE-0…NE-7 (§11.4) às decisões D-NE1…D-NE26 (§11.7) com o que a leitura
> revelou e numera o que pede decisão (Q-NE27…Q-NE54). Fonte: `Infra-IA/nfe-api/referencia-acbr/` (`00-INDEX.md` + 5 relatórios
> + catálogo de 198 regras em JSON), feita pelos agentes do plugin `code-modernization` (legacy-analyst ×4,
> business-rules-extractor ×1) no método `assess-legacy-repo`; o rascunho deste § passou pelo **architecture-critic** (1 Blocker,
> 5 High, 8 Medium — todos incorporados ou respondidos; afirmações do crítico conferidas no disco). O ACBr é referência de
> TERCEIRO (D-NE19): nada aqui vira regra sem o oficial.

### 12.1 O que a leitura mudou no entendimento

1. **O builder não calcula nada.** O writer do ACBr só formata o que recebe — imposto, totais e `vNF` chegam prontos (02 §8
   item 1). A nfe-api, idem (D-NE15). Mas o ERP hoje congela só 11 campos do ramo (`setes-api/src/shared/invoice/invoice.ts:211-225`
   — `insurance_value` e `indPres` fixos em 0) e o `ICMSTot` tem 29: ~2/3 dos totais não têm dono → Q-NE27.
2. **O legado nunca pré-validou regra de negócio.** O ACBr tem ~155 regras de negócio, opt-in; o Gestao2016 nunca as chamou —
   só XSD (04 §7). Leitura certa do fato (architecture-critic H1): o legado viveu anos só com XSD, então a rejeição da SEFAZ no 55
   é TOLERÁVEL (não queima número, volta em segundos); o catálogo é ÍNDICE para escolher regras, não semente a implementar
   inteira → Q-NE43.
3. **18 itens de conhecimento NEGATIVO** (`referencia-acbr/00-INDEX.md` N1–N18): cadeia TLS do servidor nunca verificada (N1 —
   confirma D-NE17); lote parcial e 103 morto (N2); retorno não conferido contra a pergunta (N3); denegada não guardada (N4);
   evento decidido pelo 128 do lote (N7); proc do evento tirado do 1º evento do lote (N8); e-mail com o XML do pedido (N9);
   cancelamento gravado dentro do XML autorizado (N10); fuso global (N11); gerador que muta a nota (N13); leiaute RTC divergente e
   revertido dentro do próprio pacote (N16); parser por recorte textual (N17 — **vale também para a nfse-api em produção**:
   `attrOf` por regex só com aspas duplas em `nfse-api/src/authority/dps-builder.ts:228-231` e o DANFSe lê grupos por regex).
4. **O núcleo já cobre a assinatura** de NF-e, evento e inutilização sem mudança (`fiscal-api/src/transport/xmldsig.ts` — 02 item
   8, 05 item 12; conferir no MOC se SHA-1 segue exigido). Parser XML de verdade já está na árvore (`@xmldom/xmldom`, via
   `xml-crypto`).
5. **Eventos têm identidade própria** `(tpEvento, chave, nSeqEvento)` (Id de 54) e **roteamento por serviço**, não só por UF:
   cancelamento/CC-e → autorizadora; manifestação/EPEC → AN; eventos da reforma → SVRS (05 itens 3 e 10; 03 C3) — o
   `authorizers.ts` da D-NE3 ganha a dimensão serviço/evento.
6. **A inutilização não leva IE** (05 item 6) → serviço mais promissor para o smoke H com o A1 da Setes (hipótese da D-NE18 a
   provar). A AUTORIZAÇÃO com a Setes cai no XSD local antes da SEFAZ (`IE` vazia — 02 item 13; regras 209/229): a D-NE18 (c) está
   certa por dois caminhos.
7. **IBS/CBS na NFS-e — HIPÓTESE para o prompt da fase (D-NE4)**, já com base no OFICIAL que está no acervo
   (`Infra-IA/setes-api/integracoes/nfse-adn/`: XSD 1.01 + NT 007/008/009): o grupo `IBSCBS` do DPS é opcional hoje
   (`tiposComplexos_v1.01.xsd:838`) e leva classificação e contexto (CST, cClassTrib, cIndOp, indDest… `:2207-2272`), **nenhuma
   alíquota nem valor de IBS/CBS calculado** (`gDif` leva %, `gReeRepRes` leva valor — `:2388-2423`); os valores aparecem no XML da
   NFS-e devolvida (03 B1/B3). Se confirmado, o marco de 01/01/2027 da Setes exige **classificação congelada no ERP + leitura do
   retorno**, não o motor de cálculo — o que re-escopa a D-F22/D-NE4 (o motor segue pré-requisito da NF-e do regime regular, onde o
   emitente informa VALORES — 42 unidades, 03 §3). A NT 007 (`nt007.txt:199-241`) suprime `tpRetPisCofins` 1/2 quando o IBSCBS
   virar obrigatório (a nfse-api hoje não emite o campo — sem risco). O ACBr não trata ME/EPP em ramo nenhum (03 B5).
8. **CNPJ alfanumérico** (IN RFB 2.229/2024; ACBr ajustou a chave em 30/07/2026): o produto inteiro assume 14 DÍGITOS e hoje
   **recusa (falha fechada) com diagnóstico errado** — cadastro (`setes-api/src/shared/validation/validators.ts:33`,
   `setes-app/packages/setes_validators/lib/src/validators.dart:124` + máscaras), fiscal (`setes-api/src/shared/fiscal/fiscal.dto.ts:21`,
   `setes-api/src/shared/fiscal-issuer/fiscal-issuer.ts:93`), núcleo (`fiscal-api/src/secret/certificate.ts:34,143`,
   `fiscal-api/src/storage/fiscal-storage.ts:33-34`), nfse-api (`dps-builder.ts:59-63`, `facts/service-facts.ts:147-148`) e, fora do
   grupo, o Sincronizador/setes-sync (indexa a entity por CPF/CNPJ — não lido, regra dos dois grupos). O XSD oficial 1.01 da NFS-e
   ainda exige `[0-9]{14}` (`tiposSimples_v1.01.xsd:357-365`) → a nfse-api não PODE aceitar antes do leiaute. Lacuna de PRODUTO →
   Q-NE29.

### 12.2 Restrição que ordena o plano (architecture-critic B1)

**A única obrigação com data é o IBS/CBS na NFS-e da Setes em 01/01/2027** (~12 semanas), que depende de F2a/F2b, Onda 4 e de
uma fase IBS/CBS sem prompt. Regra: **nada da nfe-api entra antes da F2a se não for pré-requisito dela.** A D-NE1 pôs a NE-1 antes
da F2a por UM motivo — o contrato de leitura que a F2a importa é só-NFS-e; documento alfanumérico, Code128 e versão de leiaute
não fazem parte desse contrato → saem do caminho crítico (NE-1b).

### 12.3 As ondas ajustadas (substitui a tabela do §11.4 onde conflitar)

| Onda | Entrega (acréscimos da leitura em **negrito**) | Sessões | Depende de |
|---|---|---|---|
| **NE-0** | levantamento oficial (D-NE19) + OpenAPI design-first + parecer do guardião sobre o DDL; **conferir: a tabela de autorizadores contra a "Relação de Web Services" (o INI do ACBr dá a forma — 127 seções, redirecionamentos; 01 item 1); a coluna (d) dos §8 dos relatórios 01/02/05; se existe consulta de inutilização (Q-NE40); a NT do CNPJ alfanumérico na NF-e (insumo da Q-NE29)** | 3–4 | Valdo; depois do prompt IBS/CBS |
| **NE-1a** (antes da F2a) | EXATAMENTE o escopo do §11.4: cerca por família (D-NE10), emitter no núcleo (D-NE9), `terminal` (D-NE12), vocabulário P/D + leitura (D-NE14), máquina comum extraída (D-NE13), `ca` + falha de cadeia do servidor ≠ credencial (D-NE17); **assinatura SEM mudança; dívida N17 da nfse-api (regex → parser XML) paga na extração da máquina; escrita da voz pelo DESCRITOR da família (D-F108 — nota no §12.8)** | 4–6 | gate do delta fiscal (§11.7 passo 1) |
| **NE-1b** (depois da F2a) | **base de PDF (D-NE20) com código de barras (Q-NE32), "Folha n/N", marca d'água por página; documento alfanumérico no núcleo conforme a frente de produto (Q-NE29)** | 1–2 | F2a; Q-NE29/Q-NE32 |
| **NE-2** | esqueleto + DDL da família (transmissão, voz, inutilização) + views — **+ voz do EVENTO com identidade `(tpEvento, chave, nSeq)` (Q-NE39); autorizador e `tpEmis` na tentativa (Q-NE37); cNF/cDV/chave persistidos write-once na tentativa (02 item 6); UNIQUE da chave natural da inutilização (cUF, ano, CNPJ, mod, série, faixa — 05 item 5); nomes de arquivo (Q-NE50)** | 2–4 | NE-0, NE-1a |
| **NE-3** | adaptador SEFAZ: **envelope SOAP 1.2 mínimo sem Header (01 item 2); 1 NF-e por lote síncrono (Q-NE33); 1 evento por envio (Q-NE39); parser XML de verdade + resposta conferida contra a pergunta (Q-NE42); timeouts por serviço (Q-NE38); Fault/HTTP 500 classificados (Q-NE34)**; `authorizers.ts` com dimensão serviço/evento; XSD de toda mensagem (inclusive `inutNFe`/`consSitNFe`); smoke H parcial: status, consulta cadastro, **inutilização** | 5–7 | NE-2; A1 vigente |
| **NE-4** | fonte de fatos da mercadoria (**tabela do 02 §8.1**) + builder 4.00 PURO (**formatadores tipados 2/3/4/10 casas; obrigatório vazio = recusa local; chave/cNF/cDV — 02 item 6; textos de homologação — Q-NE45; `infRespTec` — Q-NE44; SEM grupo ISSQN — a conjugada do legado morreu, §1**) + **pré-validação camada 1 (Q-NE43), começando pela conferência no MOC do SUBCONJUNTO do catálogo que vale para o 1º release na UF e no regime do cliente** | 6–8 | NE-3; NE-6 |
| **NE-5** | composição (transmitir/consultar/reconfirmar/cancelar/inutilizar/rodízio) + DANFE A4 + rotas + gates — **+ candidato montado em memória, validado e gravado igual (Q-NE43); reconciliação com `digVal` (Q-NE41); 204/539 (Q-NE36); 563 (Q-NE40); denegada com `nfeProc` (Q-NE35); e-mail com o XML da voz (Q-NE53); OPERAÇÃO (Q-NE54)** | 6–8 | NE-4 |
| **NE-6** | ERP: lacunas de conteúdo (D-NE15) — **mapa lacuna → regras sem dado no 04 §8.3** (finality, indPres, dt_exit, transporte, GTIN/unidade, ST retido/desonerado/DIFAL **+ diferimento e ICMS efetivo; conferir se o motor produz CST monofásico 02/15/53/61 com CRT 1 — 02 itens 14–16**) + **camada 2 da pré-validação no `validate` do faturamento (Q-NE43)** + totais (Q-NE27) + **`tPag 90` na devolução (Q-NE48) + tamanho máximo (Q-NE49) + plano de cancelamento lendo a voz D (número queimado — D-E7/D-E8, §6 item 3)** + numeração × inutilização (D-NE8) + TRANSMITIR em `order-returns` (D-NE25) | 5–7 | F2a |
| **NE-7** | setes-app: datasource da nfe-api, "No fisco" no pedido, numeração, DANFE | 3–5 | F2b |
| **F4 total** | | **35–51** (era 31–46) | a leitura tirou incerteza do transporte e da assinatura; somou ERP (camada 2, totais) e operação |
| parte SEM cliente (NE-0…NE-3) | | **15–23** (era 14–20) | |

NE-4 depende de NE-6, que depende de F2a — não é circular, mas com UM executor o calendário é SERIAL: prompt IBS/CBS → NE-0 →
NE-1a → F2a/F2b + fase IBS/CBS da NFS-e (caminho crítico de 01/01/2027) → NE-1b/NE-2/NE-3 → NE-6 → NE-4 → NE-5 → NE-7.

### 12.4 Próximos passos (substitui o §11.7 onde conflitar)

(1) gate adversarial do delta fiscal (APIs isoladas §17.8) · (2) prompt da fase IBS/CBS — **começar pelas NT 007/008/009 e pelo
XSD 1.01 oficiais (`Infra-IA/setes-api/integracoes/nfse-adn/`) e pela hipótese do item 7 do §12.1; o `referencia-acbr/03` §8 A/B é
conferência** · (3) NE-0 · (4) NE-1a (antes da F2a) · (5) F2a/F2b · (6) NE-1b/NE-2/NE-3. **Bloqueios da Rodada 2**: Q-NE29 abre
frente própria (não espera rodada); Q-NE32 bloqueia só a NE-1b; Q-NE31 vai para a fase IBS/CBS; as demais bloqueiam a NE-2 em
diante — nenhuma bloqueia a NE-0 nem a NE-1a.

### 12.5 ⚠️ Rodada 2 da nfe-api — questões para o Valdo (recomendação entre parênteses)

**A. Núcleo e produto**

- **Q-NE27 Dono dos totais** (`ICMSTot`, `vNF`; depois `vNFTot`). (a) só o snapshot do ERP · (b) nfe-api deriva tudo ·
  (c) **`vNF` do ramo (`tb_invoice_merchandise.total_value` — os títulos nasceram dele) é do ERP; os demais campos são SOMA dos
  snapshots de item feita pela nfe-api com a fórmula oficial (W16); a conferência "`vNF` derivado × `vNF` do ERP" usa a
  tolerância OFICIAL, nunca uma mais estrita; divergência = 422 com código de DEFEITO DO MOTOR + alarme operacional; a NE-6
  decide se o ERP passa a congelar o resto**. *(Rec.: (c) — o ERP não congela ~2/3 do `ICMSTot` hoje; recusar por diferença de
  arredondamento seria punir o usuário por defeito do motor.)*
- **Q-NE28 Texto.** (a) **UTF-8 com acentos, sem caracteres de controle, espaços colapsados, escape XML** · (b) transliterar
  para ASCII como o legado (quebra de linha vira `|`). *(Rec.: (a), salvo vedação no MOC — "sem legado no sistema".)*
- **Q-NE29 CNPJ alfanumérico.** (a) **frente de PRODUTO própria, aberta JÁ — 1º passo: inventário (§12.1 item 8), vigência e o
  que cada leiaute oficial aceita hoje; a nfe-api nasce aceitando no SEU builder o que o leiaute da NF-e aceitar (código novo,
  custo ~zero); núcleo e nfse-api seguem a versão oficial de cada leiaute** · (b) só no núcleo, quando a nfe-api nascer · (c)
  esperar o 1º cliente com CNPJ alfanumérico. *(Rec.: (a) — se a vigência de jul/2026 se confirmar, um cliente novo com CNPJ
  alfanumérico já não entra no ERP; o Sincronizador/setes-sync entra pelo grupo dele.)*
- **Q-NE30 A1 da matriz para a filial** (o ACBr aceita mesma raiz de 8 — N15). *(Rec.: NÃO decidir agora — sem fato gerador
  (nenhum cliente com filial); o núcleo segue exigindo CNPJ idêntico; reabrir com o 1º cliente que tiver filial.)*
- **Q-NE31 Versão de leiaute com vigência por data e ambiente.** *(Rec.: transferida para a fase IBS/CBS — o fato gerador é ligar
  o IBSCBS da NFS-e em 01/01/2027 sem deploy à meia-noite; na nfe-api a versão é constante do adaptador por ambiente (01 item 15).)*
- **Q-NE32 Código de barras / QR na base de PDF.** (a) **UMA lib escolhida uma vez para Code128 (DANFE) e QR (NFC-e, F5)** ·
  (b) Code128-C próprio no núcleo, com teste que DECODIFICA a imagem; QR decide lib depois. *(Rec.: (a) — o "sem lib nova" da
  DANFSe não vale na nfe-api: o validador XSD (D-NE16) e o QR trazem lib de qualquer jeito.)*

**B. Transporte e ciclo (nfe-api)**

- **Q-NE33 Lote.** **1 NF-e por lote, `indSinc=1` sempre; 103 → P + consulta do recibo; 105 → P.** *(Rec.: sim — N2.)*
- **Q-NE34 SOAP Fault / HTTP 500.** (a) **ambíguo (em voo, reconcilia pela chave); R só com retorno SEFAZ legível e cStat de
  rejeição; Fault REPRODUZÍVEL = defeito nosso: para o rodízio daquela nota e alarma** · (b) R. *(Rec.: (a) — "ambíguo nunca fecha".)*
- **Q-NE35 Denegada.** **guardar o `nfeProc` da denegada (voz D com prova).** *(Rec.: sim — N4.)*
- **Q-NE36 Duplicidade 204/539.** **204 (mesma chave) → pousar A pela consulta da chave. 539 (mesmo número, chave diferente) →
  consultar as chaves de TODAS as nossas tentativas da nota (nunca recortar o `xMotivo` — Q-NE42); A numa tentativa já fechada (R/F)
  = a D-NE7 foi violada = INCIDENTE crítico (o conteúdo autorizado pode diferir da nota atual no ERP); nenhuma é nossa → número usado
  fora (legado em transição) → ação na numeração do ERP (D-F21), nunca chave nova automática.** *(Rec.: sim.)*
- **Q-NE37 Rota pela tentativa.** **autorizador e `tpEmis` gravados na tentativa; consulta/evento/recibo vão a ele.** *(Rec.: sim — N6.)*
- **Q-NE38 Timeout por serviço** (autorização síncrona longa; status curto); timeout = ambíguo. *(Rec.: sim; valores do MOC/`tMed`.)*
- **Q-NE39 Eventos.** **1 evento por `envEvento`; decide o cStat do `retEvento` (135/136/155), nunca o 128 do lote; voz do evento
  com identidade `(tpEvento, chave, nSeq)`.** *(Rec.: sim — N7/N8.)*
- **Q-NE40 Inutilização 563.** **o 563 é o FATO "a faixa está inutilizada", seja quem for o autor → pousa como inutilizada, com o
  próprio 563 (e o protocolo, se vier) como prova; nunca segura a numeração em pendência.** *(Rec.: sim; NE-0 confere o 563 e se
  existe consulta de inutilização.)*
- **Q-NE41 Reconciliação com prova.** **`digVal` do `protNFe` = DigestValue do XML guardado; divergência = pendência crítica, nunca
  sobrescreve; roteiro: procurar entre os XMLs write-once das tentativas o que casa com o `digVal` (a consulta não devolve a NF-e;
  DistDFe está fora da F4).** *(Rec.: sim.)*
- **Q-NE42 Leitura do retorno.** **parser XML de verdade (`@xmldom/xmldom`, já na árvore), tolerante a apóstrofos (SEFAZ-PR);
  `chNFe` do retorno ≠ chave enviada NUNCA vira A (N3); a dívida igual da nfse-api (N17) é paga na extração da máquina comum
  (NE-1a).** *(Rec.: sim.)*

**C. Conteúdo e builder**

- **Q-NE43 Pré-validação (refina a D-NE16).** (a) **TRÊS CAMADAS — (1) na nfe-api, só regras sobre o que ELA deriva (chave/cDV/cNF,
  `dhEmi` × relógio, coerência de totais da Q-NE27, textos de H, limites de tamanho) + XSD oficial, bloqueantes, sobre o CANDIDATO
  montado em memória que a reserva grava IGUAL (teste prova validado = gravado); (2) regras de CONTEÚDO (finNFe, indPres, dest,
  transporte, GTIN…) no `validate` do faturamento do ERP, onde o usuário corrige antes da nota existir (NE-6); (3) o resto fica com
  a SEFAZ. O catálogo do ACBr é ÍNDICE, não semente: cresce por EVIDÊNCIA (rejeição vista em H/P vira regra + teste); cada regra
  com `moc_version`, dono nomeado e revisão a cada NT nova; listas versionadas (CFOP, CST, prefixos GTIN, tolerâncias, prazos — 04
  §8.4) idem; violação = 422 com a lista inteira, sem tentativa, sem alerta silencioso** · (b) catálogo inteiro (~150 regras do 55)
  bloqueante na nfe-api. *(Rec.: (a) — no 55 a rejeição não queima número e volta em segundos; catálogo sem dono deriva e passa a
  recusar nota que a SEFAZ aceitaria, sem recurso.)*
- **Q-NE44 Responsável técnico (`infRespTec`).** **a Setes como responsável técnica; dados = config da plataforma; CSRT por UF =
  segredo de PLATAFORMA da nfe-api (credencial da Setes, igual para todos os clientes — NÃO o cofre do estabelecimento, D-F34);
  nasce só quando a UF do 1º cliente exigir.** *(Rec.: sim; conferir NT 2018.005.)*
- **Q-NE45 Homologação.** **o builder aplica os textos padrão do fisco (`dest/xNome`, `xProd` do item 1) quando `tpAmb=2`.**
  *(Rec.: sim; conferir no MOC.)*
- **Q-NE46 Emitente pessoa física** (CPF, séries 910–969). *(Rec.: fora da F4 — o arquivo fiscal exige CNPJ; nenhum cliente.)*
- **Q-NE47 finNFe 5/6** (crédito/débito da reforma). *(Rec.: fora da F4 — D-NE25 = 1 e 4; entra pela fase IBS/CBS.)*
- **Q-NE48 Pagamento na devolução.** A devolução HERDA `tb_order_billing` da venda (D-A4), mas a finNFe 4 sai com **`tPag=90` (sem
  pagamento) e sem `cobr`** (02 item 19; regra 871). *(Rec.: sim — o builder deriva da finalidade; conferir no MOC.)*
- **Q-NE49 Texto acima do tamanho máximo** (xProd, infCpl…). (a) **recusar no `validate` do faturamento com o campo (camada 2)** ·
  (b) truncar em silêncio. *(Rec.: (a) — documento fiscal nunca é cortado em silêncio.)*
- **Q-NE50 Nomes de arquivo** dentro de `<cnpj>/<H|P>/<ano>/<mês>`. **molde da nfse-api: `<chave>-nfe.xml` (assinado enviado),
  `<chave>-procNFe.xml` (com protocolo — o da voz), `<chave>-evt<tpEvento>-<nSeq>.xml` (proc do evento), `<Id43>-inut.xml`
  (proc da inutilização).** *(Rec.: sim.)*

**D. DANFE e e-mail**

- **Q-NE51 Configs `danfe_*` no 1º release.** **o mínimo legal + logo; o resto (canhoto, pagamento em quadro, casas decimais,
  detalhamentos) sob demanda.** *(Rec.: sim.)*
- **Q-NE52 Cancelamento no PDF.** **só carimbo CANCELADA no DANFE pela voz (como a DANFSe) + XML do evento; PDF do evento depois,
  se pedido.** *(Rec.: sim — N10.)*
- **Q-NE53 E-mail.** **anexo = XML da VOZ com protocolo (`procNFe`/proc do evento) + PDF; assunto/corpo = config com modelo padrão.**
  *(Rec.: sim — N9.)*

**E. Operação (architecture-critic H5 — "o que o plantonista precisa às 3h")**

- **Q-NE54 Operação da nfe-api (NE-5).** (a) **cadeia ICP do servidor (D-NE17) como DADO recarregável sem build, com alarme próprio
  ("cadeia do servidor") e roteiro — troca de certificado de uma autorizadora não pode virar parada até deploy; (b) disjuntor por
  CNPJ × cStat (rejeições iguais repetidas viram recusa local) contra o 656, que bloqueia o CNPJ inteiro — além do rodízio da
  D-NE26; (c) estado por autorizador no `/health` (`consStatServ` com teto de frequência) — "SEFAZ-PR fora" × "defeito nosso";
  (d) canal de alerta para pendência crítica (Q-NE36/Q-NE41): e-mail ao suporte da Setes + log estruturado agora, monitor externo
  na Onda 4.** *(Rec.: sim aos quatro.)*

**F. Vão ao prompt da fase IBS/CBS (D-NE4), não a esta rodada**: Q-RTC1 casa do catálogo CST/cClassTrib (ERP × núcleo) · Q-RTC2 =
Q-NE31 · Q-RTC3 onde moram cClassTrib/cIndOp do serviço · Q-RTC4 valores devolvidos pelo fisco na NFS-e viram fato do ERP? ·
Q-RTC5 classificação do ME/EPP por regime ou por serviço · Q-RTC6 NFS-e de crédito/débito fora do 1º release · quadro IBS/CBS do
DANFE/DANFSe · eventos RTC (15, via SVRS) · `tpRetPisCofins` (NT 007) · a hipótese do item 7 do §12.1 (re-escopo da D-F22).

### 12.6 Números provisórios dos relatórios → numeração deste § (os do relatório ficam SUPERADOS)

| Relatório | Sugerida lá | Aqui |
|---|---|---|
| 01 transporte | Q-NE-S1 · S2 · S3 · S4 · S5 · S6 · S7 · S8 · S9 | Q-NE34 · 33 · 35 · 36 · 37 · 40 · 39 · 38 · 50 |
| 02 modelo/XML | Q-NE27 totais · 28 texto · 29 alfanumérico · 30 resp. técnico · 31 pré-validação · "A1 de mesma raiz" | Q-NE27 · 28 · 29 · 44 · 43 · 30 |
| 03 IBS/CBS | Q-RTC1…Q-RTC7 | §12.5 F (Q-RTC2 = Q-NE31; Q-RTC7 = Q-NE47) |
| 04 regras | "refinar a D-NE16" | Q-NE43 |
| 05 eventos/DANFE | Q-NE27 · 28 · 29 · 30 · 31 · 32 · 33 · 34 · 35 · 36 | Q-NE39 · 41 · 42 · 32 · §12.5 F · 51 · 53 · 46 · 52 · §12.5 F |

**Respondido sem questão nova**: efeito da voz D no ERP (crítico M4) — já coberto pela D-E7/D-E8 e pelo §6 item 3 (cancelamento
local mantém a nota, pedido 'C' + cópia, número nem reaproveitável nem inutilizável); entra só como item da NE-6. NF-e conjugada
com ISSQN — morta pelo §1 (cada ramo no seu documento): o builder nasce SEM o grupo ISSQN (corte registrado).

### 12.7 Rodada 2 da `nfe-api` DECIDIDA (Valdo 2026-10-10: "siga as recomendações") — D-NE27…D-NE54

Cada D-NE*n* = a recomendação da Q-NE*n* (§12.5), na íntegra. Numeração permanente; código e testes citam o nº.

| Decisão | O que fixa | Onda |
|---|---|---|
| **D-NE27** | `vNF` do ramo (`tb_invoice_merchandise.total_value`) é do ERP; os demais totais = SOMA dos snapshots de item pela nfe-api com a fórmula oficial (W16); conferência `vNF` derivado × ERP na tolerância OFICIAL; divergência = 422 "defeito do motor" + alarme; a NE-6 decide se o ERP congela o resto | NE-4/NE-6 |
| **D-NE28** | texto em UTF-8 com acentos, sem controle, espaços colapsados, escape XML (salvo vedação no MOC — NE-0 confere) | NE-4 |
| **D-NE29** | CNPJ alfanumérico = **frente de PRODUTO própria, aberta já** (1º passo: inventário, vigência, leiautes oficiais); a nfe-api nasce aceitando no seu builder o que o leiaute da NF-e aceitar; núcleo e nfse-api seguem a versão oficial de cada leiaute; Sincronizador/setes-sync pelo grupo dele | frente própria + NE-1b |
| **D-NE30** | A1 da matriz para a filial **NÃO decidido** (sem fato gerador); o núcleo segue exigindo CNPJ idêntico; reabre com o 1º cliente com filial | — |
| **D-NE31** | versão de leiaute com vigência por data/ambiente **vai à fase IBS/CBS** (*decidida lá como D-IB13, 2026-10-10*); na nfe-api a versão é constante do adaptador por ambiente | fase IBS/CBS |
| **D-NE32** | UMA lib de código de barras escolhida uma vez para Code128 (DANFE) e QR (NFC-e) na base de PDF do núcleo — **refina a D-NE20**; o "sem lib nova" da DANFSe não vale na nfe-api | NE-1b |
| **D-NE33** | 1 NF-e por lote, `indSinc=1` sempre; 103 → P + consulta do recibo; 105 → P | NE-3 |
| **D-NE34** | SOAP Fault/HTTP 500 = ambíguo (em voo, reconcilia pela chave); R só com retorno SEFAZ legível e cStat de rejeição; Fault reproduzível = defeito nosso → para o rodízio da nota e alarma | NE-3/NE-5 |
| **D-NE35** | denegada guarda o `nfeProc` (voz D com prova) | NE-5 |
| **D-NE36** | 204 → pousa A pela consulta da chave; 539 → consultar as chaves de TODAS as nossas tentativas (nunca recortar `xMotivo`); A em tentativa fechada = violação da D-NE7 = incidente crítico; nenhuma nossa → ação na numeração do ERP (D-F21), nunca chave nova automática | NE-5 |
| **D-NE37** | autorizador e `tpEmis` gravados na tentativa; consulta/evento/recibo vão a ele — **refina a D-NE3** (`authorizers.ts` com dimensão serviço/evento) | NE-2/NE-3 |
| **D-NE38** | timeout por serviço (valores do MOC/`tMed`); timeout = ambíguo | NE-3 |
| **D-NE39** | 1 evento por `envEvento`; decide o cStat do `retEvento` (135/136/155), nunca o 128; voz do evento com identidade `(tpEvento, chave, nSeq)` | NE-2/NE-3 |
| **D-NE40** | 563 = FATO "faixa inutilizada" → pousa como inutilizada com o 563 (e o protocolo, se vier) como prova; nunca segura a numeração | NE-5 |
| **D-NE41** | reconciliação com prova: `digVal` = DigestValue do XML guardado; divergência = pendência crítica, nunca sobrescreve; roteiro = procurar entre os XMLs write-once das tentativas | NE-5 |
| **D-NE42** | parser XML de verdade (`@xmldom/xmldom`), tolerante a apóstrofos; `chNFe` ≠ enviada nunca vira A; a dívida igual da nfse-api (regex em `dps-builder.ts:228-231` e na DANFSe) é paga na extração da máquina comum | NE-1a/NE-3 |
| **D-NE43** | pré-validação em TRÊS CAMADAS (nfe-api valida só o que deriva + XSD, sobre o candidato que a reserva grava igual · conteúdo no `validate` do ERP · resto com a SEFAZ); catálogo do ACBr = ÍNDICE que cresce por evidência, cada regra com `moc_version` + dono + revisão por NT; violação = 422 com a lista inteira, sem tentativa, sem alerta silencioso — **refina a D-NE16** | NE-4/NE-6 |
| **D-NE44** | Setes como responsável técnica: dados = config da plataforma; CSRT por UF = segredo de PLATAFORMA da nfe-api (não o cofre do estabelecimento — D-F34), nasce só quando a UF do 1º cliente exigir | NE-4 |
| **D-NE45** | em `tpAmb=2` o builder aplica os textos padrão do fisco (`dest/xNome`, `xProd` do item 1) — *dado do §13.3 (2026-10-15): no 55 o oficial exige só o `dest/xNome` (598); o `xProd` do item 1 é da NFC-e (373, F5)* | NE-4 |
| **D-NE46** | emitente pessoa física (CPF, séries 910–969) fora da F4 | — |
| **D-NE47** | finNFe 5/6 (crédito/débito da reforma) fora da F4 — entra pela fase IBS/CBS | — |
| **D-NE48** | devolução (finNFe 4) sai com `tPag=90` e sem `cobr`, mesmo herdando `tb_order_billing` (D-A4) — o builder deriva da finalidade | NE-4 |
| **D-NE49** | texto acima do tamanho máximo é RECUSADO no `validate` do faturamento com o campo; nunca truncado em silêncio | NE-6 |
| **D-NE50** | nomes de arquivo no molde da nfse-api: `<chave>-nfe.xml` (enviado), `<chave>-procNFe.xml` (com protocolo), `<chave>-evt<tpEvento>-<nSeq>.xml`, `<Id43>-inut.xml` | NE-2 |
| **D-NE51** | `danfe_*` do 1º release = mínimo legal + logo; o resto sob demanda (ajusta a D-E25) | NE-5 |
| **D-NE52** | cancelamento no PDF = só carimbo CANCELADA pela voz + XML do evento; PDF do evento depois, se pedido | NE-5 |
| **D-NE53** | e-mail anexa o XML da VOZ com protocolo + PDF; assunto/corpo = config com modelo padrão — **refina a D-NE23/D-E10** | NE-5 |
| **D-NE54** | operação: cadeia ICP do servidor como DADO recarregável sem build + alarme + roteiro; disjuntor CNPJ × cStat contra o 656; estado por autorizador no `/health`; alerta de pendência crítica por e-mail ao suporte da Setes + log estruturado (monitor externo na Onda 4) | NE-5 |

**Não decidido aqui (vai ao prompt da fase IBS/CBS — D-NE4; ABERTO em 2026-10-10: `prompt_fase_ibs_cbs.md`, Q-IB1…Q-IB21 — Q-RTC1 = Q-IB5,
Q-RTC3 = Q-IB6, Q-RTC4 = Q-IB10, Q-RTC5 ≈ Q-IB7, Q-RTC6 → §5, D-NE31 = Q-IB13, D-NE18 revisitada = Q-IB20)**: o bloco F do §12.5 (Q-RTC1…Q-RTC6, quadro IBS/CBS do DANFE/DANFSe,
eventos RTC, `tpRetPisCofins` da NT 007, hipótese do §12.1 item 7) e a D-NE31.

**Próximos passos (ordem do §12.4, inalterada)**: (1) gate adversarial do delta fiscal (APIs isoladas §17.8) · (2) prompt da fase
IBS/CBS (Rodada 0 — começar pelas NT 007/008/009 + XSD 1.01 do acervo) · (3) NE-0 · (4) NE-1a · (5) F2a/F2b · (6) NE-1b/NE-2/NE-3.
A frente do CNPJ alfanumérico (D-NE29) corre à parte, no grupo de cada sistema.

### 12.8 Nota de implantação da NE-1a — escrita da voz POR FAMÍLIA (D-F105/D-F106/D-F108 das APIs fiscais, 2026-10-11)

Origem: gates da Rodada 22 das APIs fiscais (`prompt_apis_fiscais_isoladas.md` §21.16) e a **D-F108** (= Q-F114 (a), Rodada 23 — §21.17
de lá). Hoje o escritor da voz da NFS-e mora na nfse-api (`src/nfse/repository.ts` — `insertTransmissionEvent`, lista
`SERVICE_VOICE_WRITE_KINDS` A/R/C/K/F/N, funil em execução) e o núcleo não tem escritor nenhum. A NE-1a (D-NE13) leva a máquina
tentativa × voz para o núcleo — e com ela as defesas da NFS-e, que ficariam para trás se a extração fosse literal (o escritor comum tipado
pelo vocabulário COMUM aceita S, P e D para qualquer família — provado no `adversarial-r22-gate` do núcleo e da nfse-api).

1. **Descritor da família** (D-F108): `VoiceFamily<K>` no núcleo com a tabela da voz e `writeKinds: readonly K[]`; o escritor comum é
   genérico em K e CONFERE a lista em execução (o funil da D-F106 vai junto); a família de serviço declara `SERVICE_VOICE_WRITE_KINDS`; a
   NF-e declara a dela (pode ter S/P/D — D-F105 — desde que dê a saída de cada uma na mesma entrega).
2. A porta do núcleo é **PROPRIEDADE-FUNÇÃO, nunca método** — método é bivariante: aceitaria o escritor estreito e deixaria gravar S
   (provado com `tsc --strict`); ou o escritor é genérico com `kind: WriteKindOf<F>`.
3. Testemunhas `@ts-expect-error` de S/P/D presas ao escritor que a máquina REALMENTE chama (molde do S1 no `adversarial-r21-gate` da
   nfse-api e do `service-voice-write-kind.test.ts` do setes-api).
4. Nenhum "S antes do POST" comum às famílias — quem produzir S na NF-e entrega a saída junto (consulta pela NOSSA chave — §3.2/D-NE7; o P
   sai pela consulta do recibo — D-NE33).
5. P entra no tipo comum como VIVA e **D em `FINAL_TRANSMISSION_KINDS`**; os `default` dos dois `fiscalStateOf` viram `switch` exaustivo
   (`never`) — kind novo quebra a compilação em vez de virar `in_flight`.
6. A cerca do núcleo vira **ESCRITOR ÚNICO**: SQL de escrita em `*_transmission_event` só no escritor do descritor (lista branca); a cerca
   da voz S segue `sqlOnly` no núcleo (D-F105 — `${table}` é invisível a ela).
7. A lista da família tem UMA fonte, reusada pelo CHECK da F2a (D-F107 — domínio A/R/C/K/F/N em colação binária na tabela da NFS-e).
8. Depois da extração: `voiceSProducers()`, `voiceWriterViolations()` (a peça `nfse-api/src/__tests__/voice-kind-fence.ts` — ajustar o
   escopo e os `VOICE_SQL_WRITERS` ao escritor do núcleo), as testemunhas e a suíte inteira da nfse-api (unit + 150 ao vivo).

### 12.9 D-NE55 — a NE-0 vai para DEPOIS da F2a (Valdo 2026-10-11) + NE-1a ABERTA (Rodada 0) — (a retomada passou para o §13, NE-0)

**Q-NE55** (levantada pelo condutor ao retomar a NE-0/NE-1a): o §12.4 punha "NE-0 → NE-1a → F2a", mas pelo próprio plano a NE-0 não é
pré-requisito da F2a nem da NE-1a — o §12.2 diz "nada da nfe-api entra antes da F2a se não for pré-requisito dela"; no §12.3 a NE-1a
depende só do gate do delta fiscal (feito — APIs fiscais §19.4) e quem depende da NE-0 é a NE-2; a semântica de P/D e a separação
credencial × cadeia do servidor já vieram da leitura do ACBr. Opções: (a) NE-1a já, NE-0 depois da F2a · (b) manter NE-0 → NE-1a ·
(c) as duas em paralelo (agentes na NE-0).

| Decisão | O quê |
|---|---|
| **D-NE55** (= Q-NE55 (a), Valdo 2026-10-11) | **a NE-0 sai do caminho crítico de 01/01/2027**: ordem = **NE-1a → F2a/F2b + fase IBS/CBS da NFS-e → NE-0 → NE-1b/NE-2/NE-3** (substitui o §12.4 e o §12.7 "Próximos passos"). A NE-1a não pode depender de dado oficial NOVO da SEFAZ; se a NE-0 revelar algo que mude o vocabulário do núcleo, o ajuste entra na NE-1b/NE-2. Economia: 3–4 sessões antes da F2a. |

**NE-1a — Rodada 0 (2026-10-11)**: inventário do código (agente Explore) e parecer do guardião (agente `setes-conceito`), ambos só de
leitura; as afirmações que sustentam as questões foram conferidas no disco pelo condutor.

#### 12.9.1 Fatos do inventário (caminho:linha)

- **A máquina tentativa × voz está quase toda na nfse-api**: no núcleo só o vocabulário (`fiscal-api/src/voice/kinds.ts`) e o contrato de
  leitura (`voice/reading.ts`); nenhum escritor da voz e nenhum `VoiceFamily`. O `fiscal-api/CLAUDE.md` diz o contrário — corrigir.
  Esqueleto genérico ≈ 245 de 1.122 linhas de `nfse-api/src/nfse/transmission.ts` (`withInvoiceTx`, `isInterruptedInFlight`,
  `recordInterruptedFailure`, `classifyAuthorityError`/`OUTCOME_KIND`, reserva K/N, esqueleto do rodízio sem o PAM) + ≈ 360 de 431 linhas
  de `repository.ts` com forma genérica mas tabelas fixas `tb_invoice_service_*`. Fica na família: `dps-builder` (306), `adn` (388),
  `danfse` (167), `service-facts` (358) e ≈ 450 linhas de DPS/E2404/PAM/e101101 em `transmission.ts`. Muda de lugar: ≈ 600–650 linhas.
- **Registro fiscal pela PRESENÇA DA CHAVE** (conferido): `currentOf` = "quem detém a chave" (`fiscal-api/src/voice/reading.ts:98-103`);
  o setes-api decide o registro com `!!tx?.accessKey && tx.environment === 'P'` (`setes-api/src/shared/invoice/invoice-cancel.ts:350`). Na
  NF-e a chave é NOSSA e existe desde o INSERT da tentativa (§3.2/D-NE7) → uma NF-e rejeitada viraria "registro fiscal".
- **Vocabulário**: `fiscalStateOf` com `default: 'in_flight'` (`reading.ts:121`) — um D cairia como "em voo"; `FINAL`/`AUTHORIZED` em `Set`
  soltos (`kinds.ts:32,34`); SQL com lista literal (`nfse-api/src/nfse/repository.ts:377,391-404`); barreira de nova tentativa
  `isLive || isAuthorized` (`transmission.ts:337`) — com D deixaria retransmitir NF-e denegada.
- **Cerca da virada por INSTITUTION**: `emissionStillInErp` e `assertEmitterWritable` olham qualquer réplica (`fiscal-api/src/establishment/
  establishment.ts:180-186`, `establishment.repository.ts:149-156`), apoiados na premissa escrita de que 55/65 nascem virados; `'SE'`
  espalhado (`authorityOf` `establishment.ts:25-27`, `SERVICE_ISSUER_MODEL`, `nextDpsNumber` `establishment.repository.ts:195-213`).
- **Transmissões vivas só da NFS-e** (conferido): `countLiveTransmissions` lê só `tb_invoice_service_transmission(_event)`
  (`nfse-api/src/nfse/repository.ts:416-431`) e guarda o DELETE do A1, que é UM por estabelecimento para as duas famílias.
- **`terminal = 0` literal** no núcleo (`fiscal-api/src/erp/facts.ts:70,102,110,311,316`) e em ≈ 18 SQLs da nfse-api; nenhuma assinatura
  recebe terminal; as colunas já existem em todas as PKs e views.
- **TLS** (conferido): falha da cadeia do SERVIDOR (`SELF_SIGNED_CERT_IN_CHAIN`, `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`, `CERT_HAS_EXPIRED`…)
  vira 409 `FISCAL_AUTHORITY_AUTH_FAILED` "confira o A1" e voz F (`fiscal-api/src/transport/https-json.ts:107-131,187-190`); sem `ca`
  em lugar nenhum; erro de código desconhecido vira AMBÍGUO (`nfse-api/src/nfse/transmission.ts:206-212`).
- **XML por regex (N17)**: `nfse-api/src/authority/dps-builder.ts:254-306` (a referência antiga "228-231" envelheceu), `danfse.ts:28-91`,
  `adn.ts:118-120,331`, `fiscal-api/src/transport/xmldsig.ts:75`; nenhum parser XML declarado (`@xmldom/xmldom` só transitivo do
  `xml-crypto`); 25 asserções em 6 suítes fixam o comportamento atual.
- **Views**: `vw_invoice_service_transmission` (migration 003 da nfse-api) e `_event` (001); **`vw_invoice_service_dps` não existe** (só no
  plano §14); o setes-api ainda não lê nenhuma (GRANTs comentados em `nfse-api/ops/grants.sql:32-33`).
- **Cercas que travam a divisão atual e terão de mudar na NE-1a**: `fiscal-api/src/__tests__/fence.ts` (escritor com `${tabela}` é acusado),
  `contrato.test.ts:157-165` (nenhum `tb_invoice*` fora de `src/erp/` no núcleo), `:180-186` (`new Map<`), r21/r22 do núcleo (o núcleo não
  pode ter escritor da voz), `voice-kind-fence.ts` (`VOICE_SQL_WRITERS`), r18/r19/r22 da nfse-api (leem caminho/texto de arquivos); 20
  suítes fazem `jest.mock('../nfse/repository')`; o `live-harness.ts` copia 5 tabelas fixas.
- Correções de documentação (sem decisão): `closeInterruptedSend` não existe — os nomes reais são `reconcileInterrupted` +
  `recordInterruptedFailure`; o `fiscal-api/CLAUDE.md` anuncia a máquina no núcleo.

#### 12.9.2 Modelo do guardião (peças)

Conceito mantido ("um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele"); **sem DDL de tabela** (no máximo a
troca de uma VIEW — Q-NE56). Peças no núcleo: vocabulário com **classificação total** (`KIND_CLASS satisfies Record<kind,{final,authorized}>`,
P viva, D final não autorizada; `fiscalStateOf` exaustivo com `'processing'`/`'denied'`); **projeção comum** `TransmissionView` ×
`ServiceTransmissionView` da família; **leitura publicada da família** `VoiceFamilyReading<V>` + catálogo `VOICE_READINGS` (no núcleo —
o setes-api só importa o núcleo, D-F33); predicados comuns `currentOf` (por REGISTRO), `isFiscalRecord`, `blocksNewAttempt =
isLive || registrado`, `localCancelPending`; regras só da NFS-e (E2404, substituição/ofício, códigos de evento) em
`voice/families/service.ts`, re-exportadas com os mesmos nomes; **escrita** `VoiceFamily<K>`/`defineVoiceFamily`/`insertVoice`
(propriedade-função) com `SERVICE_VOICE_FAMILY` declarado pela nfse-api (D-F108); **família = RAMO** (`InvoiceBranch = 'service' |
'merchandise'` — 55 e 65 são a mesma família) × **cerca/emissão/aluguel = MODELO**, ligados por UM catálogo `ISSUER_MODEL_FACTS`
(`{authority, branch, erpLegacy}`, só SE tem legado); cerca `emissionStillInErp(…, model)` + `assertIssuerWritable` (habilitação) +
`assertCertificateWritable` (A1 — qualquer réplica ou lacuna (b) da SE, como hoje); vivas do emitente somando as leituras do catálogo
(o DELETE do A1 soma todas as famílias); `InvoiceRef {institutionId, invoiceId, terminal}` com `WEB_TERMINAL = 0` só na borda; transporte
com `ca` + `isServerChainError`; leitor XML em `fiscal-api/src/xml/`. **Views POR família com a projeção comum idêntica** — view comum
(UNION) é MAQUETE (não funde — PADROES §11.3; colunas NULL por família; sem dono — D-F35). Contrato que a F2a importa = projeção comum +
registro por fato + P/D + `InvoiceRef`; o resto (leitura de mercadoria, `model` na projeção, inutilização, voz do evento, PDF) fica para a
NE-2/NE-1b. Critério "a NFS-e não muda": 561 unit + 150 ao vivo verdes SEM mexer em asserção (só import); equivalência da view e do
`currentOf` contra o dado real; EXPLAIN refeito; N17 com corpus dourado dos XMLs reais (a 704, os eventos) — parser novo e regex com
saída idêntica, divergência = parar e levar ao Valdo. MAQUETES vetadas: `tb_fiscal_document`/identidade comum da declaração, roteiro
genérico com ganchos, `model` na tentativa, terminal na URL/config, renomear `FISCAL_DPS_REJECTED`. Conhecimento negativo: no Node, passar
`ca` SUBSTITUI a loja padrão — nunca no ADN.

#### 12.9.3 Rodada 1 da NE-1a — DECIDIDA (Valdo 2026-10-11: "siga as recomendações da Rodada 1 da NE-1a" → D-NE56…D-NE60, todas (a))

| Decisão | O quê |
|---|---|
| **D-NE56** (= Q-NE56 (a)) | registro pelo fisco = coluna `authority_recorded` ('S'/'N') na PROJEÇÃO COMUM da view de cada família — NFS-e `access_key IS NOT NULL` (view 004 da nfse-api), NF-e (NE-2) pelo protocolo; nunca a presença da chave lida pelo consumidor |
| **D-NE57** (= Q-NE57 (a)) | falha da cadeia do SERVIDOR: voz F inalterada, código próprio `FISCAL_AUTHORITY_CHAIN_UNTRUSTED` com mensagem que não manda renovar o A1, classificação explícita, em `EMITTER_FAILURE_CODES`, `logger.error`; a cópia do setes-api não recebe |
| **D-NE58** (= Q-NE58 (a)) | "a máquina" no núcleo = a POLÍTICA em peças; os roteiros ficam na nfse-api compondo as peças; roteiro comum só quando a nfe-api tiver o dela e coincidir |
| **D-NE59** (= Q-NE59 (a)) | parte 1 (o que a F2a importa: projeção comum + registro, P/D com classificação total, `InvoiceRef`) primeiro; parte 2 (cerca por modelo, emitter, escritor/peças, `ca`/cadeia, N17) depois — se passar de 6 sessões, a parte 2 desliza para logo depois da F2a |
| **D-NE60** (= Q-NE60 (a)) | CSC: nenhum DDL na NE-1a; a coluna nasce na F5 com o dado oficial |

Texto original das questões (registro):

- **Q-NE56 — como o "registro fiscal" (D-NE14) chega ao leitor.** (a) coluna `authority_recorded` ('S'/'N') na projeção comum da VIEW de
  cada família — NFS-e `access_key IS NOT NULL`, NF-e (NE-2) `protocol IS NOT NULL`; só a view muda (migration 004 da nfse-api,
  `CREATE OR REPLACE VIEW`, fundível, equivalência provada contra o dado real) · (b) predicado na `VoiceFamilyReading` da biblioteca, sem
  DDL · (c) manter `!!accessKey` e decidir na NE-2. *(Rec.: (a) — o fato fica no contrato (a view é a API, D-F15), a família é dona da
  definição (D-F35) e a F2a conta pendências em SQL com um fragmento só; (c) entrega à F2a o bug da NF-e rejeitada como registro.)*
- **Q-NE57 — falha da cadeia do SERVIDOR (D-NE17) na NFS-e.** (a) voz F inalterada (antes do aperto de mão nada chegou ao fisco — é
  conclusivo), código NOVO `FISCAL_AUTHORITY_CHAIN_UNTRUSTED` com mensagem que não manda renovar o A1, classificação EXPLÍCITA (código
  desconhecido vira ambíguo hoje), entra em `EMITTER_FAILURE_CODES`, `logger.error` como semente do alarme · (b) sem voz (503 — a
  tentativa fica em voo; mente, nada foi enviado) · (c) separar só na nfe-api (bifurca o transporte). *(Rec.: (a) — é a ÚNICA mudança
  visível da NE-1a na NFS-e: código e mensagem, não a voz; a cópia do setes-api NÃO recebe — morre na F2a e o caso nunca ocorreu em
  produção.)*
- **Q-NE58 — o que é "a máquina" extraída (D-NE13).** (a) a POLÍTICA em peças no núcleo (escritor único, vigente/registro, barreira de nova
  tentativa, desfecho → voz, reserva K/liberação N, idempotência, transação sob a trava da nota, aluguel); os ROTEIROS (transmitir,
  consultar, reconferir, cancelar, rodízio) ficam na nfse-api compondo as peças; o roteiro comum só se extrai quando a nfe-api tiver o dela
  e os dois coincidirem · (b) roteiro genérico com ganchos por família já agora · (c) só o escritor e a leitura. *(Rec.: (a) — (b) seriam
  palpites sobre um fluxo que a D-NE55 proíbe conhecer agora; (c) entrega menos que a D-NE13.)*
- **Q-NE59 — ordem interna e linha de corte (corte da F2a 30/11).** (a) primeiro o que a F2a importa (projeção comum + registro, P/D com
  classificação total, `InvoiceRef`); depois cerca por modelo, emitter, escritor/peças, `ca`/cadeia e N17 — se passar das 6 sessões, a
  2ª metade desliza para logo depois da F2a (nada dela muda o que o setes-api lê) · (b) a NE-1a inteira antes da F2a. *(Rec.: (a).)*
- **Q-NE60 — "casa cifrada do CSC já nasce generalizada" (D-NE2).** (a) nenhum DDL: a casa genérica já existe (AES-GCM com AAD por linha,
  PADROES §11.6); a coluna do CSC nasce na F5 com o dado oficial · (b) tabela genérica `tb_establishment_secret` agora (puxaria o A1 para
  dentro — reforma de `tb_establishment_certificate`) · (c) colunas na linha 65 agora. *(Rec.: (a) — sem consumidor; a semântica do CSC é
  dado da SEFAZ, que a D-NE55 tirou do caminho.)*

**Ao fechar a rodada**: glossário de palavras ocupadas ganha "registro fiscal" (`authority_recorded` × `isFiscalRecord`) e "família" (o ramo
da nota no `fiscal_api`).

#### 12.9.4 NE-1a — parte 1 EXECUTADA (2026-10-11) — gates no §12.9.5

**Núcleo (`fiscal-api`)**: `voice/kinds.ts` — vocabulário com P (viva) e D (final, não autorizada), classificação TOTAL `KIND_CLASS`
(`satisfies Record<kind,…>`; `FINAL`/`AUTHORIZED` derivados, sem cast); os códigos de cancelamento da NFS-e saíram para a família.
`voice/reading.ts` — PROJEÇÃO COMUM `TransmissionView` (+ `authorityRecorded`), `COMMON_TRANSMISSION_COLUMNS` (uma lista que monta o SELECT
de toda família), `VoiceFamilyReading<V>`, `familyViewSelect`/`familyViewQuery` (nota pela referência inteira — terminal por parâmetro),
`mapCommonView` ESTRITO (view sem `authority_recorded` falha alto), `currentOf` por REGISTRO, `FiscalState` com `processing`/`denied` e
`fiscalStateOf` EXAUSTIVO (`never`; kind desconhecido em execução falha fechado como viva), `isFiscalRecord`, `blocksNewAttempt`,
`localCancelPendingIn`. `voice/families/service.ts` (novo) — tudo o que é só da NFS-e (códigos de evento, efeito humano,
`ServiceTransmissionView`, `SERVICE_VOICE_READING`, `transmissionViewSelect`, `localCancelPending`, reconferência E2404), mesmos nomes na
biblioteca. `voice/families/index.ts` — `VOICE_READINGS` (só `service`). `ref/invoice-ref.ts` (novo) — `InvoiceRef`, `WEB_TERMINAL`
(só na borda), `invoiceRef`, `invoiceRefFilter`. `erp/facts.ts` — `lockInvoice`/`invoiceLife`/`invoiceLives`/`orderInterface` com o
terminal por parâmetro (zero `terminal = 0` literal no núcleo — cerca em teste).

**nfse-api**: migration **004** (`CREATE OR REPLACE VIEW vw_invoice_service_transmission` + `authority_recorded`); `repository.ts` lê o
mesmo fato pela MESMA expressão (`SERVICE_AUTHORITY_RECORDED_SQL` — teste compara com o texto da 004); `transmission.ts`/`guards.ts`
chamam os leitores do ERP com a referência (`webInvoice` = borda PROVISÓRIA; a parte 2 leva a referência até a rota).

**Achado na conferência do dev (corrigido antes de publicar)**: a coluna derivada de literal saiu COERCÍVEL na colação do banco
(`utf8mb4_unicode_ci`) e `authority_recorded = 'S'` numa conexão `utf8mb4_general_ci` — o padrão do mysql2, que NEM o setes-api NEM o
núcleo fixam — deu **erro 1267** (a F2a quebraria na 1ª leitura). Correção: `COLLATE utf8mb4_bin` na expressão (coercibilidade 0;
binária como o CHECK da D-F107). LIÇÃO para toda view publicada: coluna derivada de literal leva COLLATE explícito; conferir com
`SET NAMES … COLLATE` de pelo menos duas colações antes de publicar.

**Provas**: núcleo 224 (16 novos em `ne1a-leitura.test.ts`) · nfse-api 565 unit (4 novos em `ne1a-registro.test.ts`) + **150/150 ao vivo**
(cópias descartáveis, com a 004) · `tsc` limpo nos dois · 004 aplicada no `fiscal_api` do dev (DEFINER `fiscal_api@localhost`):
equivalência `authority_recorded = 'S'` ⇔ `access_key` não nula = **0 divergências em 20 tentativas** (3 registradas); comparação com 'S'
em unicode_ci/general_ci/bin OK; EXPLAIN da view por chave (fundida) e `npm run explain:leituras` OK. Mudanças nos testes antigos: só
imports (as regras da NFS-e mudaram de arquivo), fixtures de linha da view com `authority_recorded` (a coluna agora é obrigatória), a
forma da chamada dos leitores do ERP (referência inteira) e as testemunhas que fixavam o vocabulário antigo (S..N → + P/D; a simulação
da NE-1a no r22 da nfse-api virou o real). As fixtures `tx()` da nfse-api não trazem `authorityRecorded` (= "não registrado"); a prova
do caminho real é a suíte ao vivo e o `ne1a-registro.test.ts` pelo `mapTx`.

#### 12.9.5 Gates da parte 1 (2026-10-11/12) — socrático **0,76 ✅** · adversarial **0,76 ✅** (nenhum CRITICAL/HIGH) — Valdo: "siga as recomendações dos gates"

**Correções de sessão (sem decisão nova)** — socrático M1–M4 + adversarial NE1A-01/02/04/05/06/07/08:
- **Predicados falham ALTO** sem o fato booleano (`authorityRecordedOf` em `currentOf`/`isFiscalRecord`/`blocksNewAttempt`/`reconfirmationCandidate`):
  a linha CRUA da view ('S' do SELECT público) virava "não registrada" calada — NFS-e registrada em produção tratada como pendente na F2a.
- **Mapa da projeção comum estrito** também em `environment` (o padrão 'H' falhava ABERTO no `isFiscalRecord`) e `terminal` (o `?? 0` era o terminal
  da web escondido no núcleo); **`mapTx` da nfse-api estrito** (coluna obrigatória e COERENTE com a chave — registro ⇔ chave na NFS-e).
- **`reconfirmationCandidate` lê o FATO** (antes `!!accessKey` — o núcleo se contradizia numa linha incoerente); dentro da nfse-api o SQL segue pela
  chave, com cerca de que é a MESMA definição da view (`ne1a-registro.test.ts`).
- **`currentOf` recusa lista que mistura** estabelecimento, nota, terminal ou vida (a família não está na linha — limite conhecido).
- **`familyViewSelect` valida coluna e campo** e recusa a família que REDECLARA coluna/campo da projeção comum (sombreamento calado do fato).
- **`familyViewQueryMany`** (leitura em LOTE — o selo da lista de OS na F2a, terminal por parâmetro).
- **Imutável em execução**: `KIND_CLASS` congelado em profundidade, colunas congeladas por tupla (`frozenColumns`), conjuntos exportados pela peça
  nova `util/readonly-set.ts` (sem `add`); a cerca de Map/Set do núcleo agora pega `new Map()`/`new Set(…)` sem genérico, com LISTA BRANCA nomeada dos
  detentores de dado.
- Fixtures da nfse-api com o fato (peça de teste `fixture-record.ts` — `withRecord`, 19 suítes); conexões falsas devolvem a linha `{ n: 0 }` só ao
  COUNT; a projeção à mão do `adversarial-f1.live` lê `authority_recorded` da view real (o predicado estrito a pegou ao vivo — a cerca funcionou).
- Docs: itens (8)/(9) da nota da F2a (APIs fiscais §21.17 — não portar a linha da chave do `invoice-cancel.ts:350`; nfse-api com 003+004 ANTES do
  setes-api novo e conferência de `authority_recorded` no boot); glossário ("registro fiscal", "família"); `fiscal-api/CLAUDE.md`; PADROES §11 regra 3
  (coluna de view derivada de literal leva `COLLATE`).

**Decisões (Valdo: "siga as recomendações dos gates")**:

| Decisão | O quê | Onde |
|---|---|---|
| **D-NE62** (= Q-NE62 (a)) | a família LÊ a tabela dela pelo vocabulário COMUM até o CHECK da F2a; P/D gravados por fora na NFS-e mudaram de leitura — CONHECIMENTO NEGATIVO junto da D-F103; OpenAPI da NFS-e segue com 7 estados | `fiscal-api/src/voice/kinds.ts` |
| **D-NE66** (= Q-NE66 (c)) | (a) JÁ: predicados e `mapTx` falham alto; (b) NA F2a: o núcleo entrega um leitor que já mapeia (`readFamilyTransmissions`) e `familyViewQuery`/`…Many` deixam de ser o caminho público | código + nota da F2a |
| **D-NE68** (= Q-NE68 (b)) | só a regra exportada do núcleo (`reconfirmationCandidate`) passa a ler o fato; dentro da nfse-api a chave fica (lá chave ⇔ registro), com cerca, e o mapa da família recusa linha incoerente | código + `ne1a-registro.test.ts` |
| **D-NE69** (= Q-NE69 (a)) | as listas LITERAIS de kinds no SQL da nfse-api (rodízio `('S','K')`/`('A','N')`, pendentes `IN ('A','N','S','K','C','-')`) passam a DERIVAR da `KIND_CLASS` — na PARTE 2 (escritor/peças, D-NE58) | parte 2 |
| **D-NE70** (= Q-NE70 (a)) | linha sem terminal falha alto | `mapCommonView` |
| **D-NE71** (= Q-NE71 (a)) | `currentOf` recusa lista mista (nota/estabelecimento/terminal/vida) | `currentOf` |

Q-NE63…Q-NE65 não foram usadas (o socrático numerou a partir de Q-NE61, o adversarial a partir de Q-NE66).

**DECIDIDO (Valdo 2026-10-12, perguntado à parte por serem recomendações CONFLITANTES): D-NE61 (= Q-NE61 (a)) — o que barra a NF-e denegada é o
FATO da view: invariante da família (toda voz D publicada REGISTRADA); o `mapCommonView` recusa linha D sem registro (falha alto); a barreira segue só
pelo fato (D-NE56). Q-NE67 (barrar pela classe da letra) REJEITADA. A família NF-e confere o invariante na NE-2 (teste da view dela). Limite
conhecido: objeto montado à mão (sem o mapa) com D sem registro não barra — o caminho público da F2a é o leitor que já mapeia (D-NE66 (b)). Núcleo
256 · nfse-api 584 (o teste `[LOW NE1A-03]` virou `[DECIDIDO — D-NE61]`).** Registro da pergunta (o que barra a nota DENEGADA, NE1A-03 — só a
NF-e/NE-2; a NFS-e não muda):
- **Q-NE61 (socrático, Rec. (a))** — invariante da FAMÍLIA: toda voz D é publicada com `authority_recorded = 'S'`; o mapa recusa D com 'N' (falha alto) e
  o teste da família NF-e confere na NE-2. A barreira continua só pelo FATO (D-NE56). Rejeitou o atributo na classe ("o registro continua fato da view").
- **Q-NE67 (adversarial, Rec. (a))** — D barra pela CLASSE do kind (`KIND_CLASS` ganha o atributo; `blocksNewAttempt = viva || registrada || queima`),
  independente do que a view disser.
Os dois podiam COMPOR (o mapa recusa D sem registro E a classe barra) — o Valdo escolheu só a Q-NE61 (a).

**Registrado para depois**: parte 2 — D-NE69 (listas literais), `voiceView` sem peça de leitura (L5 do socrático — NE-2), borda provisória `webInvoice` em
`transmission.ts` importada pela `guards.ts` (L6 — a parte 2 leva a referência até a rota), `terminal = 0` literal no SQL da FAMÍLIA (31 em `repository.ts`,
9 em `service-facts.ts`); F2a — D-NE66 (b).

**Provas finais**: núcleo **256** (gate `adversarial-ne1a-gate.test.ts` 31 convertidos; `ne1a-leitura.test.ts` 17) · nfse-api **584 unit** (gate
`adversarial-ne1a-gate.test.ts` 17; `ne1a-registro.test.ts` 6) + **150/150 ao vivo** · `tsc` limpo nos dois · `dist/` do núcleo refeito.
**PUBLICADO**: núcleo 4e7fd9c + 8b094ea (D-NE61) · nfse a4bbf96 · infra 7a98f88 + 8b2d1a2. Migration 004 APLICADA no `fiscal_api` do dev.

#### 12.9.6 ⏯ PROMPT DE RETOMADA — parte 2 da NE-1a (colar numa sessão nova)

```
Retome a NE-1a do Gestão 2027 (APIs fiscais) pela PARTE 2. Antes de qualquer coisa leia: D:\Gestao2027\CLAUDE.md,
Infra-IA/INDICE_CENTRAL.md, Infra-IA/prompts/prompt_onda_nfe_sefaz.md §12.8 (nota de implantação da escrita da voz por família) e
§12.9 inteiro (D-NE55…D-NE71 — a parte 1 está PUBLICADA: núcleo 8b094ea · nfse a4bbf96), e Infra-IA/prompts/prompt_apis_fiscais_isoladas.md
§21.16–§21.17 (D-F105…D-F108 e a nota de implantação da F2a, itens (7)–(9)).

ESCOPO DA PARTE 2 (decidido — D-NE9/10/12/13/17/57/58/59/69, D-F108; nada a reabrir):
 1. cerca da virada POR MODELO (D-NE10): catálogo ISSUER_MODEL_FACTS {authority, branch, erpLegacy}; emissionStillInErp(…, model);
    assertEmitterWritable vira assertIssuerWritable (habilitação) × assertCertificateWritable (A1 — réplica em qualquer linha ou lacuna (b) da SE);
 2. emitter no núcleo (D-NE9): "transmissões vivas" somando as leituras de VOICE_READINGS (o DELETE do A1 soma TODAS as famílias);
 3. a máquina tentativa × voz como PEÇAS no núcleo (D-NE13/D-NE58): escritor por VoiceFamily<K> (defineVoiceFamily, porta = PROPRIEDADE-FUNÇÃO,
    funil em execução — D-F108), withInvoiceTx, reserva K / liberação N, idempotência (kind, dh); os ROTEIROS (transmitir, consultar, reconferir,
    cancelar, rodízio) FICAM na nfse-api compondo as peças; a cerca do núcleo vira "escritor único" (ajustar fence.ts, contrato.test.ts,
    voice-kind-fence.ts/VOICE_SQL_WRITERS e os gates r21/r22 que proíbem escritor no núcleo);
 4. D-NE57: transporte com `ca` + isServerChainError → código FISCAL_AUTHORITY_CHAIN_UNTRUSTED (mensagem sem "renove o A1"), voz F INALTERADA,
    classificação explícita em classifyAuthorityError, entra em EMITTER_FAILURE_CODES, logger.error; a cópia do setes-api NÃO muda;
    conhecimento negativo: no Node, passar `ca` SUBSTITUI a loja padrão — nunca no ADN;
 5. dívida N17: leitura de XML por PARSER (fiscal-api/src/xml/; @xmldom/xmldom) no lugar das regex (nfse-api dps-builder.ts:254-306, danfse.ts,
    adn.ts; núcleo xmldsig.ts:75) — corpus dourado com os XMLs reais do STORAGE_PATH do dev + fixtures: saída IDÊNTICA à da regex,
    inclusive a assinatura do evento (D-F96); qualquer divergência = PARAR e trazer ao Valdo;
 6. D-NE69: listas LITERAIS de kinds no SQL da nfse-api (rodízio ('S','K')/('A','N'), pendentes IN ('A','N','S','K','C','-')) DERIVADAS da KIND_CLASS;
 7. terminal por parâmetro no SQL da FAMÍLIA (≈ 31 em repository.ts, 9 em service-facts.ts) e InvoiceRef até a ROTA (`webInvoice` sai de
    transmission.ts; WEB_TERMINAL só na borda HTTP).

COMO: comece com a Rodada 0 da parte 2 — inventário fino (Explore) + parecer do guardião (agente setes-conceito) sobre as peças NOVAS do
núcleo (escritor/emitter/cerca/xml) e, se surgir DDL, `Infra-IA/database/skills/revisar-ddl.md`; proponha a ORDEM INTERNA e me mostre antes
de codificar. Critério "a NFS-e não muda": nfse-api 584 unit + 150 ao vivo verdes SEM mexer em asserção (só import/forma de chamada/fixture);
núcleo 256. Gates socrático ≥ 0,70 + adversarial sem HIGH (agentes que não fizeram a entrega); "siga as recomendações" não resolve conflito
ENTRE recomendações — pergunte. Se a parte 2 passar de 6 sessões, ela desliza para logo depois da F2a (D-NE59) — corte da F2a: 30/11.

AMBIENTE (Windows/PowerShell 5.1): testes ao vivo = `$env:NFSE_ADV_LIVE='1'; npx jest live --runInBand --forceExit` (cópias descartáveis do
fiscal_api; NUNCA `migrate:setes --cutover --vai`); o núcleo é consumido pelo dist/ → `npm run build` no fiscal-api depois de mexer; o
setes-api do dev roda em tsx watch (salvar em src/ = deploy) — a parte 2 NÃO toca o setes-api; suíte do setes-api só com `--runInBand`;
commit com mensagem em ARQUIVO UTF-8 sem BOM (`git commit -F arquivo` — o `-F -` com here-string não lê a stdin); editar arquivos com a
ferramenta de edição ou script Node em UTF-8 (nunca Set-Content); commit SÓ dos caminhos da frente; ao terminar, atualizar §12.9,
INDEX (fiscal-api/nfse-api/nfe-api), INDICE_CENTRAL, CLAUDE.md da raiz e a memória (skill atualizar-infra-ia).
```

#### 12.9.7 Parte 2 da NE-1a — Rodada 0 (2026-10-12): inventário + parecer do guardião + ORDEM INTERNA proposta — ⚠️ aguarda o Valdo (Q-NE72…Q-NE74)

Inventário (agente Explore) e parecer (agente `setes-conceito`), ambos só de leitura; o condutor conferiu no disco os pontos que geram
questão ou conflito com o critério (`kinds.ts`, `ne1a-gate:170-239`, `authority.test.ts:282-293`, `service-facts.ts:311-340`,
`repository.ts:380-452`, `r17:270-294`, `r13:523-535`, `004_issuer_model_domain.sql`, `establishment.ts:140-179`).
**Linha de base**: núcleo **256/256** · nfse-api **584 unit** (150 ao vivo pulados) · `tsc` limpo nos dois · árvores limpas.

**Fatos do inventário (o que mudou em relação ao §12.9.1)**:
- Tamanhos: `transmission.ts` 1.128 · `repository.ts` 452 linhas. O que MUDA DE LUGAR é ≈ 230–395 linhas (não 600–650 — o §12.9.1 contava
  roteiros e leitores que a D-NE58 deixa na família). `terminal = 0` literal: **18** em `repository.ts` (15 + 3 `VALUES (?, ?, 0`), **3** em
  `service-facts.ts`, 2 no `smoke-adn-homologacao.ts` (não 31/9). `jest.mock('../nfse/repository')` em **21** suítes. Linhas do §12.9.1 que
  envelheceram (parte 1 já mexeu): `currentOf` `reading.ts:202-208`, `fiscalStateOf` exaustivo `:248-269`, conjuntos derivados `kinds.ts:51-69`,
  `countLiveTransmissions` `repository.ts:437-452` (já deriva os finais), barreira `transmission.ts:343`, `classifyAuthorityError` `:212-218`.
- Cerca: `assertEmitterWritable` guarda A1 (`storeCertificate`/`clearCertificate`) E habilitação (`upsertIssuer`/`softDeleteIssuer`,
  `emitter.service.ts:59,77`); `emissionStillInErp` em `guards.ts:30`, `transmission.ts:774,974`, `openIssuer` e na pós-condição do ato
  (`migrate-from-setes-api.ts:442`). Achado menor: `scripts/smoke-adn-homologacao.ts:133` chama `openIssuer` SEM `schemaName` (único que cai no
  ramo `issuerRowsState`).
- Emitter: a guarda do DELETE do A1 é CALLBACK da família (`clearCertificate({ guard })`, `establishment.ts:161-171`) contando só
  `tb_invoice_service_*` (`repository.ts:437-452`) — com a NF-e, a nfse-api apagaria o A1 com NF-e viva.
- Transporte: ninguém passa `ca`; `TLS_CREDENTIAL_CODES` (`https-json.ts:107-112`) mistura cadeia do SERVIDOR com credencial; a regex
  `/certificate/` (`:130`) casa os dois lados ("unable to get local issuer certificate" é do servidor; "sslv3 alert bad certificate" é nosso).
- XML: nenhum parser declarado (`@xmldom/xmldom` 0.8.15 só transitivo do `xml-crypto` 6.3.2). Corpus real do dev: `setes-api/storage`
  = 3 DPS + 3 NFS-e + 2 `-evt101101` (PRODUÇÃO); `nfse-api/storage-smoke` = 4 DPS + 1 NFS-e + 1 evento (H). `adn.ts:331` varre o texto
  JSON do `GET /dps` — NÃO é XML (fora do N17). `CANCEL_EVENT_CODES` em DUAS fontes (`dps-builder.ts:23` mutável × `families/service.ts:20`).
- D-NE69 — listas literais: rodízio `('S','K')` (`repository.ts:398,414`), `('A','N')` (`:416`), ordenação `('A','N','F')` (`:428`), pendentes
  `IN ('A','N','S','K','C','-')` (`service-facts.ts:333`); letras de UM fato: `'C'` do ERP (`l.last_kind`), `'F'` da revisita (`:419`), `'-'`.
- Consumidores: o setes-api NÃO importa o núcleo (só comentários); a `nfe-api` não tem `src/`. Mexer em export do núcleo não quebra outro projeto.

**Modelo do guardião (corrige o §12.9.2 em dois pontos)**:
1. **Três grãos**, não dois: **RAMO** (tabelas, views, leitura, lista de escrita) × **MODELO** (a linha da habilitação: ambiente, série,
   `cutover_at`, aluguel, nDPS, autoridade derivada) × **ESTABELECIMENTO** (o A1 — D-N31 —, a trava de TODAS as linhas, o ato da virada, as vivas
   de TODAS as famílias quando o assunto é o A1).
2. O escritor se chama **`insertTransmissionEvent`** (não `insertVoice`): a tabela é `*_transmission_event`, K/N são fatos NOSSOS gravados nela
   (PADROES §11 regra 9) e a `writerCallFlags` reconhece o escritor por esse nome.

Peças (sem DDL — nenhuma tabela nem view muda):
- **Dois descritores COMPOSTOS**: `VoiceFamilyReading<V>` (contrato PUBLICADO — o setes-api importa, D-F33) + `VoiceFamily<K>` (lado interno).
  Tipo e `defineVoiceFamily({ reading, eventTable, writeKinds })` no núcleo; o VALOR `SERVICE_VOICE_FAMILY` e a constante
  `SERVICE_VOICE_WRITE_KINDS` ficam na nfse-api (`src/nfse/voice-family.ts`) — mesmo repo do CHECK da F2a (D-F107). `eventTable` validada em
  execução (`^tb_[a-z0-9_]+_transmission_event$` — sem ponto, crase, schema); o literal da tabela NUNCA entra no núcleo (a cerca do núcleo cego
  fica sem exceção). Teste da família: a `eventTable` é o `FROM` da view da migration.
- **Escritor** em `fiscal-api/src/voice/event-table.ts` — o ÚNICO SQL do núcleo na voz (escritor + `hasTransmissionEvent` +
  `findTransmissionEventByKind`; funil + MAX+1 sob trava + colunas comuns); exceção NOMEADA na cerca D-F31 (`fence.ts` — o arquivo e
  `${family.eventTable}`); na nfse-api nenhum SQL de escrita na voz sobra (`VOICE_SQL_WRITERS` = escritor do núcleo + a cópia do
  `migrate:setes`, R21-05). A nfse-api re-exporta `insertTransmissionEvent` em `repository.ts` como `const` arrow tipada pela lista da família —
  os 21 `jest.mock` seguem interceptando e as testemunhas `@ts-expect-error` S/P/D ficam presas a ela (o que a máquina chama).
- **Emitter** = composição em `fiscal-api/src/emitter/`: `countLiveTransmissions(q, inst, { branches: 'all' | InvoiceBranch[], environment? })`
  lendo as VIEWS do catálogo `VOICE_READINGS` (DELETE do A1 = todas as famílias; PUT/DELETE da habilitação de M = só a família de M); o callback
  `guard` morre; rotas `/v1/emitter` seguem em cada serviço, montadas por `modelsOf(branch)` (somem os `'SE'` de `emitter.service.ts:32,113`).
  Equivalência tabela × view no dev (a FK `fk_invoice_service_transmission_dps` garante o JOIN da view) + EXPLAIN. Erro 1146 NUNCA vira 0;
  família entra no catálogo junto com a conferência de boot da view dela (molde do item (9) da F2a).
- **Cerca por modelo**: `ISSUER_MODEL_FACTS` em CÓDIGO, congelado, `satisfies Record<IssuerModel, …>` (tabela-catálogo já vetada na 004 —
  lê-la antes do `FOR UPDATE` recria o snapshot); `ISSUER_MODELS`/`authorityOf` DERIVAM dele; teste catálogo × CHECK da 004. A TRAVA segue de
  TODAS as linhas (`lockIssuerRows`, PADROES §9 regra 8) — só a DECISÃO é por modelo. `emissionStillInErp(q, s, inst, model)` com `model`
  OBRIGATÓRIO + `anyEmissionStillInErp(q, s, inst)` (rotas do A1 e pós-condição do ato, que é por institution); `assertIssuerWritable(…, model)` ×
  `assertCertificateWritable(…)` (o predicado de hoje, renomeado). `nextDpsNumber` fica SEM modelo (fato da linha SE — D-N18). `InvoiceBranch`
  vai para `ref/` (re-exportado com o mesmo nome; `establishment/` não importa `voice/`).
- **Peças da máquina que SOBEM**: `withInvoiceTx` (ao lado de `lockInvoice`, recebe `InvoiceRef`), escritor + idempotência (kind, dh) + C por
  kind, `reserveCancelRequest`/`releaseCancelRequest` (K/N exigidos no TIPO da família — QUANDO reservar e o K→N por carência de 10 min ficam na
  família), `classifyAuthorityError`/`AuthorityOutcome`/`OUTCOME_KIND`/`EMITTER_FAILURE_CODES` (roteiros com `switch` exaustivo — a classe da
  D-NE57 quebra a compilação do cancelamento em vez de cair no ambíguo e prender o K). **FICAM**: `isInterruptedInFlight`/`reconcileInterrupted`/
  `recordInterruptedFailure` (`IN_FLIGHT_MINUTES`, GET /dps, E2404 — NFS-e; D-F102 vale só para ela), `firstAuthorityCode` (`E\d{4}` = dialeto do
  ADN), aluguel/rodízio (o mecanismo já está no núcleo), `insertTransmission`/`fillAuthorityData`/`touchQueriedAt`/`recordNfseNotGenerated`
  (colunas da tentativa são da família), `liveTransmissionError`.
- **D-NE69**: deriva da `KIND_CLASS` SÓ as CLASSES (vivas com voz = não finais S/K/P; autorizadas A/N; finais); letras que nomeiam UM fato
  ficam literais (C fora do rodízio — D-F28; F da revisita — D-F52; sentinela `'-'`). P entra no TEXTO do SQL, não no comportamento (nenhum P na
  tabela da NFS-e); EXPLAIN refeito.
- **Leitor XML** `fiscal-api/src/xml/`: leitura ESTRITA (mal-formado ou DOCTYPE = erro — fecha XXE/expansão), `readXml`/`firstElement`/
  `firstText` (mantém o nome da D-F96)/`attrOf` por NOME QUALIFICADO sem prefixo (como a regex); `@xmldom/xmldom` dependência DIRETA na linha
  0.8.x do `xml-crypto` (uma cópia do DOM); a extração da `Signature` do `verifyXml` sobe. Leitores da família reescritos sobre a peça em
  `authority/nfse-reader.ts` (ler × montar); o montador fica (escape sobe na NE-4). Reproduzir o ESCOPO de cada leitura (ex.: `cancelBlock` lê
  `dhEvento` do documento inteiro; `parseNfseXml` lê o cabeçalho antes do `<emit>`); `CANCEL_EVENT_CODES` da família passa a ser a do núcleo.
- **`ca`**: campo `ca` no `HttpsCall` + `isServerChainError`/`SERVER_CHAIN_CODES` decididos pelo CÓDIGO antes de `isTlsCredentialError`
  (EPROTO, alertas TLS e `ERR_OSSL_*` seguem credencial); o `ca` é dado do ADAPTADOR da autoridade (D-NE17/D-NE54) — nunca de
  `tb_establishment_*`, do núcleo nem de `NODE_EXTRA_CA_CERTS` (processo inteiro: ADN e Inter). Conhecimento negativo no comentário do campo +
  teste da nfse-api que exige `ca === undefined` no ADN + cerca de zero `rejectUnauthorized`.
- **Maquetes vetadas**: descritor único leitura+escrita; registro de tabelas internas no núcleo; `writeKinds` no `VoiceFamilyReading`; catálogo
  de escrita paralelo; tabela por convenção `tb_invoice_${branch}_…`; ganchos/"colunas extras" no escritor; escritor comum gravando a
  tentativa; porta como método; guarda do A1 injetada pela família; vivas da habilitação somando TODAS as famílias; tabela-catálogo de modelos;
  `nextDpsNumber(model)`; trava só na linha do modelo; `IN_FLIGHT_MINUTES` no núcleo; "S antes do POST" comum; D-NE69 derivando da lista de
  ESCRITA; modelo de objeto do DPS/NF-e no núcleo; leitor tolerante que imita a regex; regex como plano B (dois leitores — fere a D-F96); XSD
  no núcleo agora (NE-3); `ca` na configuração do estabelecimento; flag `trustServerChain`.
- **Glossário (ao fechar)**: "emitter" (dois sentidos na nfse-api: o emissor do `fiscal_api` — `/v1/emitter` — × o emitente lido do ERP —
  `EmitterIdentity`; no núcleo nunca para fato do ERP), "reserva" (da TENTATIVA × do PEDIDO de cancelamento K), "descritor de leitura × descritor
  da família".

**Como o critério "a NFS-e não muda" será lido (o mesmo da parte 1)**: asserção de COMPORTAMENTO intocada; mudam só import, forma da chamada
(inclusive a posição do parâmetro do terminal — `r21:451`, `r22:103`), fixture e o ponto de simulação dos mocks; testes de CONTEXTO/CERCA que
fixavam a estrutura que as decisões mandam mudar são CONVERTIDOS como na parte 1 e na R22 (`ne1a-gate:185-194/227-239`, r21/r22 do núcleo — "o
núcleo não tem escritor" —, r22 da nfse-api — INSERT literal e `VOICE_SQL_WRITERS` —, oráculo do `f1r9` com `t.terminal = 0`, `f1r10:184-186`,
`r20:265`, leituras de texto de arquivo dos r18/r19/r21 nos caminhos novos), cada um listado na entrega. **Uma** asserção de comportamento muda
POR DECISÃO: D-NE57 × `authority.test.ts:285-286` (`CERT_HAS_EXPIRED` é a cadeia do SERVIDOR → `FISCAL_AUTHORITY_CHAIN_UNTRUSTED`, voz F
inalterada); a mensagem sem código (`:287-288`) segue credencial (o código decide antes da mensagem).

**Ordem interna PROPOSTA** (todo passo: `tsc` nos dois + `npm run build` do núcleo + 256/584; "ao vivo" = 150 em cópias descartáveis):

| # | Passo | Frente | Risco para a NFS-e | Prova extra |
|---|---|---|---|---|
| 1 | cerca por modelo (`ISSUER_MODEL_FACTS`, `emissionStillInErp(…, model)`, `anyEmissionStillInErp`, `assertIssuerWritable` × `assertCertificateWritable`; o smoke passa o schema) | (1) | baixo — réplica só existe na SE (D-F42) | matriz `r8`/`f1r11.live` |
| 2 | emitter no núcleo (vivas pelo catálogo; o callback morre) | (2) | médio — a guarda passa a ler a VIEW | equivalência tabela × view no dev + EXPLAIN + **ao vivo** |
| 3 | uma passada pelo SQL da família: terminal por parâmetro, `InvoiceRef` até a rota (`WEB_TERMINAL` só em `*.routes.ts`, com cerca) + listas derivadas da `KIND_CLASS` | (7)+(6) | baixo — texto muda, dado não | EXPLAIN (`explain:leituras`) |
| 4 | estrutura do escritor: `withInvoiceTx`/`InvoiceTx`, descritores, escritor no núcleo, ligação na família, cercas (escritor único, exceção nomeada da D-F31, r21/r22, `voice-kind-fence`) | (3a) | o MAIOR estrutural | **ao vivo** |
| 5 | política sobre o escritor: K/N, idempotência, desfecho → voz com `switch` exaustivo | (3b) | médio | — |
| 6 | `ca` + cadeia do servidor (D-NE57) — depois do 5 para mexer na classificação UMA vez, já no lugar final | (4) | a ÚNICA mudança visível (código/mensagem) | **ao vivo** |
| — | **gates** (socrático + adversarial, agentes que não fizeram a entrega) dos passos 1–6 → publicar ("parte 2a") | | | |
| 7 | N17 — parser XML; corpus dourado (8 XMLs de produção + 6 de H + fixtures) | (5) | isolado; único que pode PARAR por divergência | **ao vivo** + gate do delta ("parte 2b") |

Estimativa: 1–6 + gates ≈ 4–5 sessões; o N17 ≈ 1–2. O N17 por último porque é puro e isolado, não pode segurar os outros, e é o candidato
natural a deslizar para depois da F2a se a parte 2 passar de 6 sessões (D-NE59) — nada da F2a lê XML.

**Questões para o Valdo (recomendação entre parênteses)**:
- **Q-NE72 — até onde vale "saída IDÊNTICA" no N17.** Fora do XML bem-formado a regex e o parser divergem por natureza (mal-formado, DOCTYPE,
  auto-fechado, CDATA, comentário, prefixo — casos que o corpus real não exercita). (a) idêntico no que o corpus real e as fixtures BEM-FORMADAS
  exercitam; nos casos estranhos o leitor RECUSA (valor só de elemento com TEXTO SIMPLES — CDATA, comentário ou filho = recusa) e a recusa vira
  ambíguo pela causa que já existe (`nfse-ilegivel`/`evento-ilegivel`) — falha fechado; os testes adversariais de CDATA/marcação
  (`r17:282-293`, `r13:523-535`) devem seguir com o MESMO desfecho (ambíguo / chave nula), e onde só o caminho mudar (XML mal-formado que a regex
  "lia") a divergência é intencional, fixada em teste de contexto · (b) equivalência também nos casos estranhos (reimplementar a regex dentro do
  parser — maquete) · (c) regex como plano B quando o parser falhar (dois leitores — fere a D-F96). *(Rec.: (a) — sem ela o "divergência = parar"
  trava o N17 em casos que nenhum XML real produz; qualquer divergência no corpus REAL continua sendo parar e trazer ao Valdo.)*
  **Atualização pela leitura DETERMINÍSTICA do ACBr (2026-10-12, pedido do Valdo antes de decidir — `../nfe-api/referencia-acbr/06-leitura-deterministica.md`;
  8 pontos da leitura por agentes conferidos, 0 desmentidos)**: as regras "casar pelo NOME QUALIFICADO" e "CDATA = recusa" de (a) passam a ser
  PARÂMETRO da leitura do núcleo, escolhido pela FAMÍLIA — a NFS-e usa qualificado + texto simples (saída idêntica à regex); a NF-e (NE-2) vai precisar
  de nome LOCAL em qualquer namespace (prefixos das SEFAZ CE/MG — `pcnLeitor.pas:168,178,188`; o parser do ACBr usa `FindAnyNs`) e de ler CDATA (qrCode
  da NFC-e — `ACBrNFe.XmlWriter.pas:388`). Corrige o parecer do guardião (letra F: "não casar por `localName`" vale para a NFS-e, não para o núcleo).
  Q-NE73 e Q-NE74 independem do ACBr.
- **Q-NE73 — nome do campo `erpLegacy` do catálogo da D-NE10.** "Legado" no acervo é o Gestao2016; aqui o fato é "o ERP (setes-api) já transmitiu
  este modelo antes da extração e a lacuna (b) consulta a habilitação dele". (a) `erpTransmitted` · (b) manter `erpLegacy` e registrar a colisão no
  glossário. *(Rec.: (a) — só o nome muda; o conceito da D-NE10 fica.)*
- **Q-NE74 — o escritor da voz exige a TRAVA pelo tipo?** (a) o escritor recebe um `InvoiceTx` (conexão + `InvoiceRef` + vida travada) que SÓ o
  `withInvoiceTx` produz — a regra "escrita na voz sempre sob a trava da nota" (hoje comentário, `repository.ts:221-222`) vale por construção e a
  nota escrita é obrigatoriamente a travada (hoje `insertTransmissionEvent(conn, institutionId, invoiceId, …)` aceita outra nota); todas as
  escritas atuais já estão dentro do `withInvoiceTx` (conferido pelo guardião) — muda a FORMA de ≈ 30 asserções de chamada, não o comportamento ·
  (b) manter `(conn, institutionId, invoiceId)` e a regra em comentário. *(Rec.: (a) — é a mesma defesa da D-F106 levada da letra para a nota;
  barato agora, caro depois que a NF-e escrever.)*
**DECIDIDO (Valdo 2026-10-12: "siga as recomendações e a ordem proposta" — depois da leitura determinística do ACBr)**:

| Decisão | O quê |
|---|---|
| **D-NE72** (= Q-NE72 (a)) | N17: saída IDÊNTICA no corpus real e nas fixtures bem-formadas; nos casos estranhos o leitor RECUSA → ambíguo pela causa existente; casamento por nome (qualificado × local) e CDATA são PARÂMETRO da leitura do núcleo, escolhidos pela família (NFS-e = qualificado + texto simples) |
| **D-NE73** (= Q-NE73 (a)) | o campo do catálogo `ISSUER_MODEL_FACTS` é `erpTransmitted` (não `erpLegacy`) |
| **D-NE74** (= Q-NE74 (a)) | o escritor da voz recebe `InvoiceTx` (conexão + `InvoiceRef` + vida travada), produzido SÓ pelo `withInvoiceTx` |
| ordem | a ORDEM INTERNA proposta acima (passos 1–6 → gates → publicar "parte 2a"; passo 7 = N17 → gate do delta → "parte 2b") |

- Achado sem decisão (entra no passo 1): `smoke-adn-homologacao.ts:133` passa a informar o schema (o `openIssuer` sem schema dava o predicado
  INCOMPLETO da cerca); `fiscal-api/package.json:5` ainda anuncia "tentativa × voz" — corrigir com a entrega.

##### 12.9.7.1 Execução — passos 1 a 6 (2026-10-12) — nada commitado ainda; próximo: gates (socrático + adversarial) dos passos 1–6

| Passo | O que mudou | Provas |
|---|---|---|
| **1 — cerca por modelo** (D-NE10/D-NE73) | núcleo: `establishment/issuer-models.ts` (catálogo `ISSUER_MODEL_FACTS {authority, branch, erpTransmitted}` congelado, domínio = CHECK da 004; `authorityOf`/`branchOf`/`modelsOf`/`erpTransmitted`); `emissionStillInErp(…, model)` OBRIGATÓRIO + `anyEmissionStillInErp` (grão do estabelecimento = o predicado de antes = a disjunção do catálogo); `assertEmitterWritable` → `assertIssuerWritable(…, model)` (trava TODAS as linhas, decide pelas do modelo) × `assertCertificateWritable` (o de antes); `InvoiceBranch` foi para `ref/`. nfse-api: `requireCutover(ctx, inst, grain)` — SE nas rotas da NFS-e e da habilitação, `'establishment'` nas do A1; ato da virada com `anyEmissionStillInErp`; smoke com o schema | núcleo +29 (`ne1a-cerca-modelo.test.ts`: catálogo × CHECK, matriz por modelo em 11 estados × ERP com/sem SE, disjunção); matriz por modelo também no MOTOR real (`f1r11.live`) |
| **2 — emitter no núcleo** (D-NE9) | núcleo `emitter/emitter.ts`: `countLiveTransmissions(q, inst, { branches, environment })` pelas VIEWS publicadas de `VOICE_READINGS` (1146 nunca vira 0); `emitterView`/`writeIssuer`/`deleteIssuer`/`uploadCertificate`/`clearCertificate`/`deleteCertificate` — o DELETE do A1 soma TODAS as famílias, a habilitação de M só a família de M; o callback `guard` da família MORREU (o `clearCertificate` saiu de `establishment/`). nfse-api: `emitter.service.ts` vira borda fina (DTO + recusa do modelo); `countLiveTransmissions` saiu do `repository.ts`. **Achado e corrigido**: o upload no núcleo lia o CNPJ do ERP por dentro e furava a costura dos mocks da família (o 503 do teste de contrato virou 422) → a BORDA lê o fato do ERP e entrega (`expectedCnpj`); o núcleo segue recusando ausente/divergente | núcleo +10 (`ne1a-emitter.test.ts` — inclusive a SOMA com uma 2ª família injetada: NF-e viva barra o A1, não barra a SE); dev: tabela × view **0 divergências**; EXPLAIN da contagem nova: view fundida, por chave, ~1 ms (entrou no `explain:leituras`) |
| **3 — terminal por parâmetro + listas derivadas** (D-NE12/D-NE59/D-NE69) | núcleo: `LIVE_VOICE_KINDS` + `sqlKindList` (só kinds do vocabulário) e `InvoiceScope`; nfse-api: o SQL da família recebe a nota INTEIRA (`InvoiceRef`) ou o ESCOPO (estabelecimento + terminal) — zero `terminal = 0` fora das 3 peças da VOZ (passo 4); a composição recebe `ref` (conferido por `refOf` — outra institution falha alto); `webInvoice` saiu; a ROTA monta a referência (`WEB_TERMINAL` só em `*.routes.ts` e scripts); rodízio e pendentes com o terminal da borda; listas do rodízio/pendentes DERIVADAS (vivas S/K/P · autorizadas A/N · ordem pelos finais; C e '-' pelo nome) | núcleo +3 (`ne1a-listas-sql.test.ts`); codemod por AST nos testes (354 edições de FORMA — composição, repositório, escopo, mocks, índices de `mock.calls`); EXPLAIN do rodízio e dos pendentes OK |

| **4 — estrutura do escritor** (D-F108/D-NE74) | núcleo: `erp/invoice-tx.ts` — `withInvoiceTx(pool, schema, ref, {label, requireAlive, lock}, fn)` produz o `InvoiceTx` (marca por `unique symbol` que não sai do módulo), CONGELADO, com CÓPIAS congeladas da referência e da vida (quem segura o `InvoiceTx` não troca a nota escrita depois da trava) e `open` (getter que cai no fim do callback — `InvoiceTx` vazado para depois da transação é recusado); `assertInvoiceTx` confere em execução. `voice/event-table.ts` — `defineVoiceFamily({reading, eventTable, writeKinds})`: tabela da voz só por NOME SIMPLES `tb_<…>_transmission_event`, lista no vocabulário (cópia congelada), escritor GENÉRICO (propriedade-função; FUNIL da lista da família antes de qualquer query → `assertInvoiceTx` → MAX+1 e INSERT pela tabela do descritor, terminal da referência) + os dois leitores de idempotência. nfse-api: `nfse/voice-family.ts` = o DESCRITOR (dona de `SERVICE_VOICE_WRITE_KINDS`); o `repository.ts` só LIGA (`export const insertTransmissionEvent = SERVICE_VOICE_FAMILY.insertTransmissionEvent`) e re-exporta; `transmission.ts` usa o `withInvoiceTx` do núcleo (leitor travante `erp.lockInvoice` como costura dos mocks) e escreve com o `InvoiceTx`. Cercas: exceção NOMEADA da D-F31 (`NAMED_WRITE_EXCEPTIONS` — só `voice/event-table.ts` com alvo `${table}`, alvo exato); `voice-kind-fence`: `VOICE_SQL_WRITERS` sem o repositório da nfse-api, escrita na voz = a voz como ALVO (o subselect do `recordNfseNotGenerated` não é escrita), um descritor só (`VOICE_FAMILY_DESCRIPTORS`, `defineVoiceFamily` por qualquer grafia fora dele = violação); cast para `InvoiceTx` só na própria peça (AST) | núcleo +15 (`ne1a-escritor.test.ts`: descritor, funil, terminal, idempotência, trava/404, cópias congeladas, `InvoiceTx` vazado/forjado, deadlock com `InvoiceTx` próprio, testemunhas de compilação — `VoiceFamily<estreita>` não alarga; o MÉTODO alargaria —, cerca do cast); nfse-api +2 (cerca: alvo da escrita, 2º descritor); codemod por AST (48 edições de FORMA nas chamadas do escritor/leitores); EXPLAIN OK; ao vivo 150/150 |

| **5 — política sobre o escritor** (D-NE13/D-NE58) | núcleo `voice/outcome.ts`: `AuthorityOutcome`, `classifyAuthorityError` (`switch` pelo código), `OUTCOME_KIND` (Record sobre os desfechos que gravam — exaustivo pelo tipo — e congelado, valores literais R/F), `EMITTER_FAILURE_CODES` (agora `readonlySet` — imutável em execução), `unhandledOutcome(never)` (fecho de `switch` exaustivo nos roteiros); `voice/policy.ts`: `recordVoiceOnce` (idempotência (kind, dh) da voz do fisco), `recordKindOnce` (um C por tentativa, qualquer dh — HIGH-3a), `reserveCancelRequest` (K, dh NULL) e `releaseCancelRequest` (N só se a última voz ainda é o K, lida pela família sob a mesma trava). As peças recebem a PORTA da família (`VoiceWriter<'K'>`…): o escritor de uma família sem K/N não cabe (contravariância — `strictFunctionTypes`) e a costura dos mocks da família fica intacta. nfse-api: `transmission.ts` re-exporta os nomes (os testes seguem importando de lá); o roteiro do cancelamento virou `switch` EXAUSTIVO; o A idempotente (POST e consulta), o C por kind, o K e o N passam pelas políticas. Cerca nova (`voice-kind-fence`): o ESCRITOR como VALOR só vai às políticas (1º argumento de reserva/liberação; propriedade das portas de `recordVoiceOnce`/`recordKindOnce`) | núcleo +9 (`ne1a-politica.test.ts`, inclusive testemunhas: família sem K/N não reserva; roteiro que esquece um desfecho não compila); nfse-api +1 (cerca do escritor como valor) |
| **6 — `ca` + cadeia do servidor** (D-NE57) | núcleo: `HttpsCall.ca` (só passa ao Node quando DITO — ausente = loja padrão; conhecimento negativo no tipo: `ca` SUBSTITUI a loja, nunca no ADN); `isServerChainError` pelo CÓDIGO (lista de verificação X.509 da doc do `tls` + `ERR_TLS_CERT_ALTNAME_INVALID`; a mensagem nunca decide) → antes do aperto de mão **409 `FISCAL_AUTHORITY_CHAIN_UNTRUSTED`** ("Certificado do servidor do fisco não reconhecido … não é o seu A1; nada foi enviado …") + `logger.error`; depois do aperto de mão segue ambíguo (Q-ADV1a); desfecho `chain_untrusted` EXPLÍCITO → voz **F** (inalterada), em `EMITTER_FAILURE_CODES` (pára a passada do rodízio); catálogo de erros. A compilação QUEBROU no roteiro do cancelamento da nfse-api até ele tratar o caso (o `switch` exaustivo do passo 5 cumpriu o papel) → `chain_untrusted` libera o K com N ("pedido não enviado — certificado do servidor do fisco não confiável"). `package.json` do núcleo: descrição corrigida. A cópia do setes-api NÃO muda | núcleo +5 (`ne1a-cadeia.test.ts`: `ca` só quando dito, código × mensagem, 409/`logger.error`/voz F, depois do aperto de mão = ambíguo, cerca AST de `rejectUnauthorized`/`NODE_TLS_REJECT_UNAUTHORIZED` em produção); nfse-api +4 (cadeia no adaptador ADN — 7 códigos, mensagem sem "A1"; ADN nunca passa `ca`; transmitir → F; cancelar → K,N) |

**Provas acumuladas**: núcleo **298/298** · nfse-api **584/584 unit** · `tsc` limpo nos dois · `dist/` refeito · ao vivo **150/150** depois dos passos 1–2 e de novo **150/150** depois do passo 3. **Depois do passo 4**: núcleo **313/313** · nfse-api **586/586 unit** · EXPLAIN OK · ao vivo **150/150** (271 s). **Depois dos passos 5–6**: núcleo **327/327** · nfse-api **591/591 unit** · `tsc` limpo · `dist/` refeito · ao vivo **150/150** (313 s).

**Testes CONVERTIDOS (estrutura que as decisões mandaram mudar — nenhuma promessa mudou)**: r8/cofre/f1r11.live/f1r5/f1r8 (nomes da cerca; grão do
estabelecimento); `ne1a-gate` da nfse-api (C: listas literais → `[DECIDIDO — D-NE69]` provando os MESMOS membros para os kinds da NFS-e; D: borda
`webInvoice` → `[DECIDIDO — D-NE12/D-NE59]` — refs só da borda, zero literal fora das peças da voz); `ne1a-gate` do núcleo (o SQL das vivas mora no
emitter); `cofre` (o callback da família morreu → a guarda do núcleo recusa e desfaz); `f1r9` (oráculo aprende `t.last_kind`/`t.terminal = ?`);
`f1r5` (a contagem é pela view); posição de parâmetro do SQL nos bancos falsos r15/r16/r18/r20/r21 e em `passada-ramos`; textos `('S','K')` →
`('S','K','P')` (r20, passada-ramos); `f1r10` (VALUES com o terminal por parâmetro). **Passos 4–6**: r22 da nfse-api (32 trechos com a
forma nova da chamada `(itx, attempt, userId, …)`; kind no índice 5 do INSERT — o terminal entrou; o título do funil diz onde ele mora; lista e
tipo derivado conferidos no DESCRITOR `voice-family.ts` + re-exportação no repositório; casts de LEITURA 4→3 — o da nfse-api saiu com o leitor;
assinatura = ligação + `PropertySignature` no núcleo; escritores SQL sem o repositório da nfse-api + o genérico pela tabela do descritor + um
descritor só; o mapa ganha `chain_untrusted`); `df61:352` (índice `![5]`→`![3]` fora do alcance do codemod); `ne1a-gate` da nfse-api (D: a trava
`erp.lockInvoice` entrou no `withInvoiceTx` do núcleo — a chamada contada é a dele; "terminal = 0 só nas 3 peças da voz" → zero, e o núcleo usa
`terminal = ?`); `contrato`/`r8` L6 do núcleo (exceção NOMEADA `${table}` em `voice/event-table.ts`); r21/r22 do núcleo ("o núcleo NÃO tem
escritor" → "tem EXATAMENTE UM, genérico, exportado só como fábrica"); r21 e r22 da nfse-api (as escritas pelas políticas contam como chamadas
legítimas — K/N fixos na peça, conferidos); `r20:327` (a análise estática do produtor do K olha a chamada da reserva); `r20:297` (o mapa
desfecho → voz dá `F` também para a cadeia — a promessa "só R/F" segue, por conjunto). **Asserção de COMPORTAMENTO mudada — UMA, por decisão
(D-NE57)**: `authority.test.ts:285-286` (`CERT_HAS_EXPIRED` com código → `FISCAL_AUTHORITY_CHAIN_UNTRUSTED`, voz F inalterada); a mensagem sem
código (`:287-288`) segue credencial.

**Consequência decidida, registrada (D-NE10 (a))**: no estado inalcançável "só 55 réplica" (versão antiga do script — o `migrate:setes` atual falha
alto), a habilitação SE e as rotas da NFS-e deixam de ser barradas pela réplica 55; o A1 segue barrado (grão do estabelecimento).

**Lições (conhecimento negativo)**: (1) NUNCA editar `src/` enquanto a suíte ao vivo roda — o Jest carrega os módulos ao longo da execução e mede
código pela metade (a 1ª rodada do passo 1 acusou 500 no DELETE do A1 que era o passo 2 meio editado); (2) codemod que REMAPEIA índice
(`c[3]`→`c[2]`) não é idempotente — rodar só na 1ª passada; as trocas idempotentes (guardadas pelo prefixo `refOf(`/`webRef(`) podem repetir;
(3) inserir import por regex de linha cai dentro de import de várias linhas — posicionar pela AST (última `ImportDeclaration`); (4) composição do
núcleo que chama outra peça do núcleo POR DENTRO fura o `jest.mock('fiscal-api')` da família — fato do ERP lido na BORDA e entregue.

##### 12.9.7.2 Gates dos passos 1–6 (2026-10-12) — socrático **0,76 ✅** · adversarial **0,72 ✅** (nenhum CRITICAL/HIGH) — Valdo: "siga as recomendações dos gates"

**Socrático (agente independente)**: nenhum CRITICAL/HIGH; as decisões executadas fielmente; três brechas MÉDIAS no que a entrega anuncia "por
construção" — (i) o `lock` do `withInvoiceTx` é porta lateral (qualquer função vira "a trava" e o `assertInvoiceTx` confere só a FORMA);
(ii) a exceção nomeada da D-F31 casava arquivo + alvo, não o VERBO (`UPDATE`/`DELETE` em `${table}` passavam — provado); (iii) a amarração
da referência ao estabelecimento de quem pede só existia na nfse-api (`refOf`), não no núcleo. **Correções de sessão** (sem decisão nova):
cerca do `lock` + identidade do `InvoiceTx`; exceção com VERBO; o `withInvoiceTx` recebe quem pede e recusa outra institution; a liberação
confere a TENTATIVA do `current`; o alarme da cadeia leva host (nunca a URL com chave/Id); rótulo da família no DESCRITOR (núcleo sem
literal); a decisão do cancelamento pelas CLASSES (`isLiveTransmission`/`isAuthorized` — P/D do vocabulário comum); teste que amarra a
`eventTable` do descritor à view da migration.

**Decisões (Valdo: "siga as recomendações dos gates")**:

| Decisão | O quê |
|---|---|
| **D-NE75** (= Q-NE75 (a)) | a D-NE74 alcança os escritores da TENTATIVA que a F2a lê: `fillAuthorityData` (grava `access_key` = o REGISTRO fiscal da D-NE56), `insertTransmission` e `insertLifeDps` recebem o `InvoiceTx` (escrita na nota TRAVADA por construção); ficam de fora, por desenho, os comandos únicos guardados FORA da trava — `touchQueriedAt` (throttle) e `recordNfseNotGenerated` (prova D-F90, UPDATE condicional) |
| **D-NE76** (= Q-NE76 (a)) | família do catálogo `VOICE_READINGS` × `fiscal_api` compartilhado: decisão POR CHAMADA no `countLiveTransmissions` — view existe → conta; nem a view nem a tabela base da família existem → família NÃO INSTALADA → 0 legítimo; tabela sem view (ou 1146 da view com a tabela presente) → falha fechado; nenhum serviço condiciona o boot às migrations de outra família |
| **D-NE77** (= Q-NE77 (a)) | superfície da biblioteca para a F2a: subpath de LEITURA `fiscal-api/reading` (`exports` do package.json — projeção comum, `VOICE_READINGS`, predicados, `InvoiceRef`; o leitor que já mapeia da D-NE66 (b) entra nele na F2a) + cerca de que o setes-api só importa esse subpath; o barrel completo é das famílias |

| **D-NE80** (= Q-NE80 (a)) | a TRAVA do `withInvoiceTx` numa família é só `erp.lockInvoice` — cerca por AST (`lockFlags` na `voice-kind-fence` da nfse-api; o gate do núcleo enumera todo `lock:` do workspace) |
| **D-NE81** (= Q-NE81 (b) — **Valdo DIVERGIU** da recomendação do adversarial (a), escolhendo a do socrático) | o `assertInvoiceTx` confere IDENTIDADE: o núcleo guarda os `InvoiceTx` EMITIDOS e abertos num `WeakSet` privado de `erp/invoice-tx.ts` — forja impossível, mesmo copiando os campos de um verdadeiro; exceção NOMEADA na regra 3 do núcleo (lista branca da cerca de Map/Set, que passou a enxergar `WeakMap`/`WeakSet`): identidade, não trava — a trava segue no BANCO |
| **D-NE82** (= Q-NE82 (a)) | "um descritor só" endurecido na cerca da família: o NOME `defineVoiceFamily` fora do descritor autorizado, em qualquer forma (identificador ou texto), e o escritor/descritor como valor por texto, elemento, reflexão ou espalhamento são violação. **(c) — registro de descritores em EXECUÇÃO no núcleo — segue EM PAUTA** (não decidido; o contexto que o fundamenta fica fixado nos gates) |
| **D-NE83** (= Q-NE83 (a)) | `releaseCancelRequest` exige `current: { attempt, lastKind }` e confere `current.attempt === attempt` (a de outra tentativa falha ALTO) |
| **D-NE84** (= Q-NE84 (a)) | a trava e a leitura da habilitação decidem na MESMA semântica já (o modelo volta CANÔNICO de `lockIssuerRowList` — a colação _ci do SQL); o CHECK binário do `model` entra na migration da F2a (nota de implantação, junto da D-F107) |

**Adversarial (agente independente)**: 12 achados — 2 MEDIUM (NE1A2-01 `InvoiceTx` forjado passava na conferência por FORMA; NE1A2-09 o 2º
descritor por alias/`.call`/`(0, f)`/elemento/desestruturação/`Reflect.apply` escapava da cerca — com o NE1A2-10, uma cadeia SEM cast
gravava S e D na tabela da NFS-e), 10 LOW; todos LATENTES (nenhum caminho de produção os aciona). **Correções de sessão** (sem decisão nova):
NE1A2-02 (2ª conferência do `InvoiceTx` logo antes do INSERT), NE1A2-03 (a entrada do escritor lida UMA vez), NE1A2-05 (as políticas conferem o
`InvoiceTx` na entrada), NE1A2-06 (`branches` vazio/estranho falha alto), NE1A2-08 (a exceção da D-F31 com VERBO + alvo + LIGAÇÃO
`const table = d.eventTable`), NE1A2-11 (`SERVICE_VOICE_WRITE_KINDS` congelada), NE1A2-12 (`refOf` devolve cópia congelada e cada composição
a usa — conferida UMA vez).

**Execução das correções e decisões (2026-10-12)**: núcleo — `withInvoiceTx(pool, quemPede, ref, …)` (outra institution/id/terminal fora do
domínio falha alto antes de qualquer conexão), registro `ISSUED` (D-NE81), rótulo no DESCRITOR (`label` — o núcleo sem literal de família),
`countLiveTransmissions` por chamada (D-NE76 — a tabela pela CONVENÇÃO `vw_<x>` ↔ `tb_<x>`, sem literal de família no núcleo: a 1ª tentativa
com o nome da tabela no catálogo tropeçou na cerca de "tabela do ERP"), superfície `fiscal-api/reading` (D-NE77 — `exports` + `typesVersions`;
caminho interno do pacote bloqueado em execução, `ERR_PACKAGE_PATH_NOT_EXPORTED`), alarme da cadeia só com o HOST; nfse-api — D-NE75 nos três
escritores da tentativa, decisão do cancelamento pelas CLASSES (`isLiveTransmission`/`isAuthorized`), `underTx` (peça de teste: `InvoiceTx` de
VERDADE — o `itxOf` forjado só serve a escritor simulado), teste `descritor-ddl` (o descritor e a convenção da D-NE76 amarrados às migrations).
**Testes convertidos** (estrutura/decisão — nenhuma promessa de comportamento da NFS-e mudou): os `it.failing` dos dois gates → `[CORRIGIDO na
sessão]`; os "contexto" que fixavam as fugas de HOJE (NE1A2-09/10) passam a fixar "nada escapa"; o 1146 do emitter (`ne1a-emitter`, gate E) ganha
a distinção "família instalada"; `withInvoiceTx` com quem pede (codemod); `defineVoiceFamily` com `label`; D-NE75 (codemod — 5 edições);
`r20:327` (a decisão do cancelamento pelas classes); `ne1a-gate` D (a cópia do `refOf`); pinos da lista congelada (r22 nos dois projetos);
cerca de Map/Set (`WeakMap`/`WeakSet`). **Provas**: núcleo **356/356** · nfse-api **606 unit** · `tsc` limpo · `dist/` refeito · EXPLAIN OK ·
ao vivo **150/150** (255 s). **PUBLICADA a "parte 2a" (Valdo: "pode publicar a parte 2a", 2026-10-12)** — núcleo 27d2aa6 · nfse 38980bb · infra f72fba4. Próximo: passo 7 (N17 — parser XML, D-NE72) → gate do delta → "parte 2b".

**Lição (ferramenta)**: o heredoc do Bash desta sessão corta PELA METADE as barras invertidas (`\\n` vira quebra de linha real, `/\\/g` vira `/\/g`) —
script com barra invertida vai por arquivo escrito pela ferramenta de escrita, nunca por heredoc nem `node -e` com aspas duplas.

##### 12.9.7.3 Passo 7 — N17: leitura de XML por PARSER (2026-10-12; Valdo: "pode seguir para o passo 7") — gates do delta e o que mudou depois deles no §12.9.7.4

> ⚠️ **Errata do gate socrático do delta (item 11)**: a 1ª versão desta tabela prometia mais do que a peça fazia — a estriteza vinha de uma LISTA
> de leniências medidas, e lixo depois de comentário/declaração, CDATA mal-formado, PI sem fim e caractere de controle cru ainda passavam. A
> peça foi REESCRITA nos gates (varredura ÚNICA da gramática — §12.9.7.4); a linha "Peça do núcleo" abaixo descreve a 1ª versão e fica como
> história. Também as linhas "NFS-e" (`cdata: 'refuse'` saiu da família — D-NE87) e "Divergências" (auto-fechado e aspas simples NÃO eram da
> D-NE72 — viraram D-NE85) foram superadas pelo §12.9.7.4.

| O quê | Como |
|---|---|
| **Peça do núcleo** `xml/reader.ts` (D-NE72) | `parseXml` ESTRITO por cima do `@xmldom/xmldom` 0.8.15 (declarado no núcleo, exato, `npm install --offline` — já vinha transitivo do `xml-crypto`; nenhum download). Medido no passo: o @xmldom 0.8 é LENIENTE — aceita `&` solto, lixo depois da raiz, referência de caractere fora do Unicode (vira lixo) e descarta calado o lixo antes da raiz; a peça RECUSA tudo isso + DOCTYPE, entidade não predefinida, aviso/erro do parser, documento sem raiz ou com 2 raízes (`XmlUnreadableError` com o motivo). Leitura: ordem de DOCUMENTO, 1º elemento pelo nome; `textOf` = TEXTO SIMPLES aparado (filho/comentário/PI = recusa; CDATA = recusa ou texto); casamento QUALIFICADO × LOCAL e CDATA = PARÂMETRO da família (`XmlReadOptions`). **Conhecimento negativo**: o @xmldom traz `/// <reference lib="dom" />` — importado com tipos, poria os tipos do DOM na compilação INTEIRA do núcleo e da nfse-api; entra por `require` com tipos estruturais mínimos |
| **NFS-e** (`dps-builder.ts`, `danfse.ts`, `adn.ts`) | `NFSE_XML = { match: 'qualified', cdata: 'refuse' }`; `firstText`/`parseNfseXml`/`parseEventXml`/DANFSe/`sentDpsIdOf` pelo leitor, com a MESMA busca do recorte (cabeçalho = elementos depois de `<infNFSe>` e antes do 1º `<emit>` sem atributo; `<eNNNNNN>` e `<e101101>` sem atributo; atributo do 1º elemento que o TEM). A recusa cai nos `try` que já existiam no adaptador → ambíguo pela causa existente (`nfse-ilegivel`/`evento-ilegivel`). `unescapeXml` fica como utilitário (os testes o usam para conferir o XML que NÓS montamos) |
| **Núcleo** `transport/xmldsig.ts` | `verifyXml` acha a `<Signature>` pelo leitor (a 1ª do namespace XMLDSig que o declara nela mesma — a forma do recorte) e passa o NÓ ao `xml-crypto`; documento ilegível = false |
| **Paridade** | ORÁCULO = o leitor por regex extraído LITERALMENTE do git (nfse-api 38980bb → `__tests__/legacy-xml-oracle.ts`; núcleo 27d2aa6 → dentro de `n17-xmldsig.test.ts`) — nunca editado à mão. **Corpus real do dev (14: 8 de produção + 6 de H)**: saída IDÊNTICA em TUDO o que a família lê (parse da NFS-e e do evento, assinatura do evento D-F93, DANFSe, Id do DPS, `firstText` de toda folha com conteúdo) e as 14 assinaturas reais VERIFICAM (true) nos dois; **fixtures**: medição com instrumentação TEMPORÁRIA (revertida) na suíte inteira — 1014 leituras, **0 divergência** fora dos casos estranhos; 11 fixtures sintéticas bem-formadas idênticas (`n17-paridade.test.ts`) |
| **Divergências INTENCIONAIS** (D-NE72 — fixadas `[DECIDIDO — D-NE72]`) | CDATA, elemento ou comentário no valor lido, referência inválida, entidade não predefinida, `&` solto, DOCTYPE, texto UTF-16 lido como UTF-8, lixo fora da raiz → o leitor RECUSA (o recorte devolvia marcação crua, literal ou "nada"; a referência fora do Unicode já lançava) — mesmo DESFECHO nos testes adversariais (r17/r18/r13: ambíguo); a CAUSA do CDATA nos 4 campos da assinatura muda de `evento-contraditorio` para `evento-ilegivel` (as duas são ambíguo). **Auto-fechado** (`<x/>`): o recorte o PULAVA e lia o próximo `<x>…</x>`; o parser lê o 1º (vazio) — no corpus só os algoritmos da assinatura são auto-fechados (nunca lidos). **Atributo com aspas simples**: o recorte não via (nulo); o parser lê |
| **Cerca** | `n17-xml-reader.test.ts`: nenhuma regex com cara de TAG em produção (núcleo, nfse-api src/scripts, nfe-api) — exceção NOMEADA: o saneamento do HTML de gateway nas mensagens de erro (`https-json.ts` — texto para pessoa, nunca valor fiscal) |

**Provas**: núcleo **367/367** · nfse-api **630 unit** · `tsc` limpo · `dist/` refeito · ao vivo **150/150** (253 s).


##### 12.9.7.4 Gates do delta do passo 7 (2026-10-12) — socrático **0,74 ✅** · adversarial **0,72 ✅** (nenhum CRITICAL/HIGH; 2 MEDIUM) — Valdo respondeu as 6 questões pelas recomendações → D-NE85…D-NE90

**Socrático (agente independente)**: aprovado, mas com o ponto 1 a corrigir ANTES de publicar porque gravava C irreversível — o AUTO-FECHADO
decidia voz (`<e101101/>` numa NFS-e virava `cancelled`; num evento, `eventCode` 101101 e o registrar aceitava; `<dhProc/>` devolvia `''` e o
`??` não caía). Demais: a estriteza vinha de LISTA de leniências medidas (passavam CDATA sem fim/minúsculo — a marcação crua lida como valor —,
lixo depois de comentário/declaração, `&#0;` escondido por comentário com marcador de CDATA, PI sem fim, `<` em atributo, controle cru);
custo/DoS (sem teto de tamanho, DOM ≈ 90× o texto, assinatura D-F93 reparsando o evento 4–5×, pré-checagem quadrática, `elementsOf`
recursivo estourando a pilha ~10 mil níveis); recusa fora do ambíguo (DANFSe → 500 para sempre; `sentDpsIdOf` depois do 2xx, fora de `try`);
trecho do documento na mensagem da recusa (contra a D-F100); grão do `match: 'local'`/CDATA para a NF-e; cerca com rotas de evasão; oráculo
sem integridade; `package-lock` da nfse-api velho; e o §12.9.7.3 prometendo mais que a peça (errata acima).

**Adversarial (agente independente — gates criados: `fiscal-api/src/__tests__/adversarial-n17-gate.test.ts` 35 testes,
`nfse-api/src/__tests__/adversarial-n17-gate.test.ts` 33)**: **N17-01 MEDIUM** — o pré-filtro em duas passadas (CDATA, depois comentário)
deixava `<![CDATA[` num comentário e `]]>` noutro esconderem referência inválida/`&` solto; o @xmldom convertia calado → na consulta o evento
virava CANCELADA com motivo-lixo e no transmitir AUTORIZADA com nNFSe-lixo (o publicado dava `evento-ilegivel`/`nfse-ilegivel`); **N17-02
MEDIUM** — o DANFSe lê campos que mais ninguém lê (nomes, `xDescServ`, `xLgr`): NFS-e AUTORIZADA com marcação neles → 500 "Erro interno"; LOW
N17-03 (exceção crua: CDATA depois da raiz sem `try` no DOMParser; `elementsOf` recursivo), N17-04 (10 classes BEM-FORMADAS divergindo do
oráculo — o parser lê certo; duas mudam voz), N17-05 (o vazio `''` não dispara `??`; grupo vazio vale cancelamento), N17-06 (12 formas
mal-formadas aceitas), N17-07 (2 bem-formadas recusadas — PI com `&`, `<!DOCTYPE` em comentário), N17-08 (1 + 5N parses por consulta; pré-filtro
quadrático; sem teto), N17-09 (cerca sem `<\s*`, `[<]`, `\x3c`, `RegExp(` sem `new`, concatenação, `split`/`indexOf`). **Resistiu**:
truncamento; XXE/DOCTYPE; atributo duplicado/sem aspas; lixo depois da raiz; resposta TROCADA com aspas simples; Id falso em COMENTÁRIO (o
recorte o lia e **autorizava a NFS-e alheia** — o parser lê o real); eco do nosso pedido com `<dhProc/>`; `verifyXml` nunca lança.

**Decisões (Valdo, 2026-10-12 — as 6 pelas recomendações)**:

| Decisão | O quê |
|---|---|
| **D-NE85** (= Q-NE85 (b) + Q-NE92 (a)) | **VALOR vazio = AUSENTE**: o leitor PULA o elemento vazio e lê o próximo com o nome (paridade com o recorte em `<x/>`; o vazio EXPLÍCITO `<x></x>` passa de `''` para `null` — divergência intencional); os `??` do adaptador voltam a cair. **GRUPO que decide voz vazio** (`<e101101/>`, `<e101101></e101101>`, `<eNNNNNN/>` — no evento e EMBUTIDO na NFS-e) = RECUSA `grupo-vazio` → ambíguo pela causa existente (`evento-ilegivel`/`nfse-ilegivel`), **nunca C** — a forma explícita, que o recorte dava por cancelamento, também muda. Ratifica as **aspas simples** (o parser lê; a identidade segue conferida pela chave/Id) — o §12.9.7.3 as tinha posto na conta da D-NE72 sem ela as decidir |
| **D-NE86** (= Q-NE86 (b)) | `match: 'local'` (NF-e) casa o nome local SÓ dentro da lista de namespaces da FAMÍLIA (`{ match: 'local', namespaces: [...] }` — cobre o prefixo de CE/MG; SOAP e XMLDSig ficam fora). A leitura por nó-escopo (caminho) fica para a NE-2 decidir com o leiaute |
| **D-NE87** (= Q-NE87 (b)) | CDATA é escolha do **CAMPO** (`XmlFieldRead { cdata: 'refuse' \| 'read' }`), recusa por padrão: só o campo que o leiaute põe em CDATA (qrCode/urlChave da NFC-e) pede `'read'`; campo que decide voz (cStat, chNFe, nProt…) nunca. Saiu do `XmlReadOptions` da família (`NFSE_XML = { match: 'qualified' }`) |
| **D-NE88** (= Q-NE88 recomendada) | tetos ANTES do parse, no NÚCLEO: **1 MB** de texto (`MAX_XML_BYTES` — também o `maxOutputLength` do gunzip da nfse-api) e **64 níveis** (`MAX_XML_DEPTH`); `grande-demais`/`profundo-demais` entram no `XmlRefusal` e a família os mapeia para a causa que JÁ existe — nenhuma `AmbiguousCause` nova (D-F98). NFS-e real ≈ 10 KB e 12 níveis |
| **D-NE89** (= Q-NE89 (a) + Q-NE91 (a)) | DANFSe de nota cujo XML guardado tem campo que o leitor recusa: erro com **código próprio** do catálogo `FISCAL_DANFSE_XML_UNREADABLE` (422 — "o XML segue disponível para download"), **nunca 500**; o XML continua pela rota dele |
| **D-NE90** (= Q-NE90 (a)) | as 10 classes BEM-FORMADAS em que o recorte lia ERRADO (`<e101101 >`, `</nNFSe >`, marcação dentro de comentário — `<emit>`, `<cStat>`, `<e101101>` —, referência de espaço na ponta do valor, CR LF, referência/espaço em volta do `=`/`>` literal em atributo) são **divergência INTENCIONAL**: o parser lê certo; imitar o recorte reintroduziria o cancelamento lido de dentro de comentário e o Id falso em comentário. As duas que mudam voz (contradição → repetição; `<e101101 >` → cancelada) ficam fixadas como contexto `[DECIDIDO — D-NE90]` |

**Correções de sessão (sem decisão nova)** — o núcleo `xml/reader.ts` foi REESCRITO na linha da "dica arquitetural" do socrático (estrito por
GRAMÁTICA num ponto só, não por lista de leniências): **varredura ÚNICA em ordem de documento** antes do @xmldom — comentário (sem `--` dentro),
CDATA só DENTRO da raiz e fechado, PI fechada, `<?xml` só no início, qualquer outro `<!` = `doctype`, tag com aspas respeitadas e `<` em
atributo recusado, referências validadas em texto E atributo (`referencia-invalida`), `]]>` em texto recusado, fora da raiz só espaço do XML
(`fora-da-raiz`), profundidade contada na própria varredura (`profundo-demais`), caractere fora da produção Char do XML 1.0
(`caractere-invalido`) — fecha N17-01, N17-06, N17-07 e o item 1 do socrático; `try` em volta do DOMParser (erro dele = `mal-formado`) e
`elementsOf` ITERATIVO (N17-03); a mensagem da recusa leva só o MOTIVO e a POSIÇÃO, nunca trecho do documento (D-F100); `firstText` pula o
vazio (D-NE85). nfse-api: `parseEventDoc` + `eventSignature(e, doc)` + `firstText(xml | doc)` — **um parse por documento** (consulta com N
eventos = 1 + N; era 1 + 5N — N17-08); o Id do NOSSO DPS lido ANTES do POST (se o leitor o recusar, nada foi enviado — socrático 4);
`assertGroupFilled` (D-NE85); DANFSe pela D-NE89. Cerca `tagReads` (`n17-xml-reader.test.ts`) passou a pegar `RegExp(` sem `new`, concatenação
com `'<'`, `\x3c`, `[<]`, `<\s*` e `indexOf`/`split`/`includes`/`match` com literal de tag (N17-09 · socrático 7); oráculo com **sha256
fixado** em teste (texto com fins de linha normalizados — socrático 8); `package-lock` da nfse-api com o `@xmldom/xmldom` do núcleo
(`--package-lock-only --offline` — socrático 9).

**Testes convertidos**: gate do núcleo — os 17 `it.failing` → `[CORRIGIDO na sessão]` (N17-01 ×3, N17-03 ×2, N17-06 ×12); os contextos que
fixavam o lixo/os desfechos duplos passam a fixar a recusa; "1 000 níveis" → recusado pelo teto (D-NE88). Gate da nfse-api — N17-01 ×2,
N17-02 ×4, N17-05 ×2 → `[CORRIGIDO na sessão]`; N17-04 ×10 → `[DECIDIDO — D-NE90]` (afirma divergência SEM recusa); Q-NE92 → `[DECIDIDO —
D-NE85]` (grupo vazio = ambíguo nos dois caminhos e embutido na NFS-e); N17-08 → 2 e 4 parses. `n17-paridade`: o vazio explícito saiu das
fixtures idênticas para `[DECIDIDO — D-NE85]` (`[null, '']`); o auto-fechado agora é PARIDADE (`['12', '12']`); teste novo do grupo vazio.

**O que muda na NFS-e** (critério "a NFS-e não muda de comportamento" — só o DECIDIDO): casos estranhos → ambíguo (D-NE72); grupo de voz
vazio → ambíguo, inclusive a forma explícita (D-NE85); valor vazio explícito `''` → ausente (D-NE85); as 10 classes bem-formadas (D-NE90);
DANFSe com campo recusado → 422 com código (era PDF com a marcação crua no publicado — D-NE89). **Corpus real do dev (14 XMLs): saída
IDÊNTICA** e as 14 assinaturas verificam.

**Fica registrado (não decidido)**: **Q-NE93** — o corpo HTTP da resposta do fisco (`https-json` do núcleo) segue SEM teto; o XML descomprimido
tem o da D-NE88 e o canal é mTLS com o fisco. Opções: (a) teto no transporte do núcleo (ex.: alguns MB, recusa = ambíguo pela causa da
transmissão/consulta); (b) manter como limite conhecido. *Rec. (a) na F2a/NE-2* (vem junto do SOAP da SEFAZ). Para a **NE-2**: o `verifyXml`
liga a assinatura ao nó lido? (o xml-crypto reparsa com o @xmldom leniente; quem validar XML do fisco tem de ler do nó ASSINADO — risco de
assinatura embrulhada/XSW); leitura por nó-escopo (D-NE86). Segue EM PAUTA a D-NE82 (c).

**Provas**: núcleo **405/405** · nfse-api **665 unit** (44 suítes) · `tsc` limpo nos dois · `dist/` refeito · ao vivo **150/150**. **PUBLICADA a "parte 2b" (Valdo: "pode publicar a parte 2b", 2026-10-12)** — núcleo 604117a · nfse ebbaf44 · infra afcbebb. Próximo: F2a.

---

## 13. NE-0 — ABERTA e FECHADA em 2026-10-15 (Valdo: "agora abra a NE-0 da nfe-api") — ⏯ RETOMAR PELO §13.10

> Este bloco NÃO decide: organiza o escopo da NE-0, registra o que o levantamento na web já disse e numera as escolhas (Q-NE94…Q-NE101,
> mais a Q-NE93 reapresentada) com recomendação. Insumos — dois levantamentos em paralelo, só leitura: **(A)** o oficial na web (fontes
> primárias datadas, [SEC] marcado, "não confirmado" explícito) e **(B)** o inventário de tudo que o acervo mandou "conferir no oficial"
> (relatórios do ACBr, este prompt, APIs fiscais, IBS/CBS — com arquivo:linha). Nenhum download, nenhum código, nenhum DDL executado.
> Acervo novo: `../nfe-api/integracoes/nfe-sefaz/` — `README.md` (documentos a arquivar + fatos levantados com fonte) e
> `CONFERENCIAS.md` (65 itens com a decisão que cada um sustenta).

### 13.1 Lugar no calendário e natureza

- Ordem da D-NE55: NE-1a ✅ (12/10, publicada) → F2a/F2b ✅ (JANELA executada em produção em 14–15/10 — APIs fiscais §22.51) + fase
  IBS/CBS da NFS-e (IB-3 publicada em 15/10; a IB-4 — prova em H — espera o fisco de H, E1000; `prompt_fase_ibs_cbs.md` §13.8) →
  **NE-0** → NE-1b/NE-2/NE-3.
- A NE-0 é DOCUMENTO: acervo oficial, conferências, autorizadores como dado, parecer do guardião com DDL em RASCUNHO, OpenAPI
  design-first. Não toca a árvore viva do setes-api (`tsx watch` = deploy), nem o `src` do núcleo (deploy no restart — D-F133), nem o
  `fiscal_api`. Não disputa o caminho crítico de 01/01/2027: a IB-4 espera fato externo e a Q-IB1 (30/10) é decisão de negócio.
- Esforço do plano: 3–4 sessões (§12.3); esta Rodada 0 é a 1ª.

### 13.2 Entregáveis

| # | Entregável | Onde | Estado |
|---|---|---|---|
| E1 | acervo oficial arquivado (README com arquivo · bytes · SHA-256 · URL — molde IB-0) | `../nfe-api/integracoes/nfe-sefaz/` | lista proposta (Q-NE94); 0 arquivos |
| E2 | conferências — cada linha fecha CONFIRMA · AJUSTA · DERRUBA · NÃO OFICIAL, com a fonte | `…/nfe-sefaz/CONFERENCIAS.md` | 65 itens; 26 com prévia (§13.3) |
| E3 | autorizadores como DADO conferido: UF × modelo × ambiente × serviço/evento × presença de IE → URL; serviço oferecido por UF; prazo de cancelamento por UF; parâmetros do 656 — insumo do `authorizers.ts` (D-NE3/D-NE37) | `…/nfe-sefaz/AUTORIZADORES.md` | a fazer |
| E4 | parecer do guardião (`setes-conceito`) + `revisar-ddl`: DDL da família NF-e no `fiscal_api` em RASCUNHO — tentativa (chave/cNF/cDV write-once; autorizador, `tpEmis` e presença de IE congelados — D-NE37), voz (domínio do `kind` pela lista da família — D-F107/D-F108), voz do EVENTO `(tpEvento, chave, nSeq)` (D-NE39), inutilização (chave natural da faixa; 102/563 — D-NE8/D-NE40), views (`authority_recorded` = protocolo — D-NE56; D-NE61) | `prompt_onda_nfe_sefaz-ddl-ne2-rascunho.sql` (ao lado deste prompt; não executado) | a fazer |
| E5 | OpenAPI `/v1` design-first das rotas do 1º release (D-NE25: venda + devolução; transmitir, consultar, reconfirmar, cancelar, inutilizar, XML, DANFE, status, numeração) | `D:\Gestao2027\nfe-api\openapi\nfe-api.v1.yaml` (molde `nfse-api/openapi/nfse-api.v1.yaml`) | a fazer |
| E6 | Rodada 4 da nfe-api com o que as conferências DERRUBAREM | este prompt | — |

### 13.3 O que o levantamento na web já disse (PRÉVIA — fecha ao arquivar; fontes no README do acervo)

**Confirma** (a decisão segue como está):
- **SHA-1** segue exigido (RSA-SHA1 + digest SHA-1; nenhuma NT de SHA-256) — a assinatura do núcleo fica sem mudança (NE-1a).
- **1 NF-e = SÍNCRONO obrigatório**: assíncrono com 1 nota = rej. **452** desde 13/10/2025 (NT 2025.001) — a D-NE33 fica mais forte.
- **Não existe consulta de inutilização**; reenviar a mesma faixa devolve **563 com o `nProt` do pedido anterior** — a D-NE40 (o 563 é a
  prova) é exatamente o caminho oficial.
- Mensagem até **500 KB** — o teto de 1 MB da D-NE88 cabe.
- `dhEmi` = instante da assinatura (D-NE21): 703 só acima de 5 min à frente; atraso > 7 dias vira 150; > 30 dias só contingência.
- Texto: UTF-8; acentos "devem ser evitados", não proibidos; `TString` só U+0020–U+00FF, sem CR/LF/TAB, sem espaço nas pontas (D-NE28 —
  o mesmo padrão que pegou a NFS-e: D-F65).
- A 4.00 eliminou o `nfeCabecMsg` (envelope mínimo sem Header — §12.3, NE-3).

**Ajusta** (a decisão vale com DADO novo — sem questão):
- **D-NE45**: no 55 o texto de homologação é só o `dest/xNome` (rej. 598); o do `xProd` do item 1 é da NFC-e (373) — vale para a F5.
- **D-NE26 / §3.9**: o prazo do cancelamento é DADO POR UF — **PR = 168 h** (RICMS/PR), não 24 h; o aviso `FISCAL_CANCEL_DEADLINE` e o
  teto do rodízio leem da tabela de autorizadores (E3); a recusa continua sendo da SEFAZ (501).
- **D-NE26 / D-NE54 (b)**: parâmetros do 656 — consulta da MESMA chave > 10/h bloqueia até 1 h (intervalo mínimo por chave ≥ 6 min);
  autorização com > 30 rejeições iguais (o disjuntor CNPJ × cStat fica abaixo disso).
- **D-NE38**: esperar ≥ 15 s antes de consultar o recibo; `tMed` mínimo 1 s.
- **§3.6**: o **206 NÃO é resposta da inutilização** (é a autorização de número inutilizado); a inutilização responde 102 · 563 · 256 (faixa
  com número já inutilizado) · 201 (faixa > 10.000) — o §3.6 fica marcado.
- **D-NE3 / D-NE37**: AC, BA e SP deixam de usar o pedido de inutilização a partir de 01/11/2026 (Ajuste SINIEF 40/26 — conferir no texto) →
  a tabela de autorizadores ganha "serviço oferecido por UF".
- **D-NE17 / D-NE54 (a)**: a SEFA-PR publica a raiz ICP-Brasil v5 + o pacote do certificado do servidor (servidor ICP-Brasil = inferência);
  SVRS não confirmado; o ITI publica as cadeias em zip com SHA-512 — é a fonte do DADO recarregável.

**Pede decisão** (→ §13.6):
- **NT 2026.007** (H **26/10**, P **16/11/2026**): emitente SEM IE autoriza só na **SVRS** (eventos também); exige CRT = cadastro da RFB
  (rej. 180 — vale para TODOS os emitentes a partir de 16/11), CFOP da IT 2023.002, ICMS proibido, IBSCBS obrigatório; não trata
  inutilização nem contingência → Q-NE95, Q-NE96.
- **CSRT obrigatório no PR** (H desde 19/01/2026, P desde 23/02/2026) + produção no PR exige o software cadastrado pelo fornecedor no UPD
  → Q-NE97 (a D-NE44 dizia "nasce quando a UF do 1º cliente exigir": o PR exige).
- **O MOC muda de dono em 01/11/2026** → MOC Online do PR (só http) → Q-NE98.
- **CNPJ alfanumérico na NF-e em produção desde 01/07/2026** e a frente da D-NE29 sem prompt → Q-NE99.
- **DANFE da reforma** (NT 2026.010, produção 01/12/2026, sem fase de teste) → Q-NE100.

**Divergência (não decide — fecha no arquivo oficial)**: a cópia [SEC] da NT 2025.002 v1.52 dá a UB12-10 (rej. 1115) obrigatória para CRT
1/2/4 em **04/01/2027**; a fase IBS/CBS (`prompt_fase_ibs_cbs.md` §1.1) registrou as datas RISCADAS na v1.52 e o anúncio da RFB (01/08/2026)
de que a ausência deixa de rejeitar. Afeta a premissa do §1 ("sem o grupo nenhuma NF-e é autorizável") e o calendário da IB-N — não a NFS-e.

**Não confirmado** (vai à NE-3, com o A1): `action` × `SOAPAction` (o WSDL só abre com mTLS); cadeia do servidor da SVRS; prefixos e
namespaces devolvidos (D-NE86); apóstrofos do PR (D-NE42); CSRT e credenciamento exigidos pela SVRS para quem não tem IE.

### 13.4 Herdado para a NE-2 em diante (não é da NE-0 — listado para não se perder; arquivo:linha no inventário B)

Q-NE93 (teto do corpo HTTP — reapresentada no §13.6) · XSW no `verifyXml` (quem valida XML do fisco lê do nó ASSINADO) · leitura por
nó-escopo (D-NE86) · D-NE82 (c) em pauta · D-NE61 (a view da família prova que toda voz D publicada está registrada) · D-NE56
(`authority_recorded` = protocolo, COLLATE bin) · `voiceView` sem peça de leitura (L5 da NE-1a) · domínio do `kind` da tabela da NF-e pela
lista da família (D-F105/D-F107/D-F108 — S/P/D com a saída de cada um na mesma entrega) · a família entra em `VOICE_READINGS` com a
conferência de boot da view e sobe ANTES do setes-api (D-NE76/D-F113) · a voz D no plano de cancelamento da conjugada (APIs fiscais §22.5
item 9) · série do 55 só leitura no ERP até o 1º cliente (D-F112/D-F137) · "A1 por duas APIs" e `app/shared/fiscal` no 2º consumidor
(F2b) · **lacuna EXISTENTE**: a tela de pedidos (`orders`) não tem "No fisco" — venda conjugada com NFS-e autorizada não cancela a NFS-e por
ali · NE-1b/NE-2 em worktrees irmãs (núcleo = deploy — D-F133) · escopo da NE-2 já fixado no §12.3 · NE-1b (PDF/Code128, alfanumérico no
núcleo) · IB-N dentro da F4 (`ibscbsObligationStart` falha alto para modelo ≠ SE).

### 13.5 Ordem interna proposta (Q-NE101)

1. Arquivar os lotes 1 e 2 (Q-NE94) — README com bytes e SHA-256.
2. Fechar primeiro as conferências que podem DERRUBAR premissa: a divergência da UB12-10; o texto oficial da NT 2026.007; CSRT/UPD; depois
   as 39 linhas sem prévia.
3. E3 — autorizadores como DADO.
4. E4 — guardião + `revisar-ddl` com os fatos já fechados (o DDL nasce do oficial, não do ACBr).
5. E5 — OpenAPI.
6. Rodada 4 (se alguma linha DERRUBAR) → NE-0 fechada → NE-1b/NE-2/NE-3 (D-NE55).

### 13.6 ⚠️ Rodada 3 da nfe-api — questões para o Valdo (recomendação entre parênteses)

- **Q-NE94 Downloads** (cada documento com nome, origem e tamanho no README do acervo, "Documentos a arquivar"): (a) **lote 1 — 8 itens
  oficiais de acesso direto (MOC 7.00 Visão Geral e Anexos I–III; ATC RFB/CGIBS nº 8; cadeias ICP-Brasil do ITI; certificados de servidor e
  normas de credenciamento do PR — ≈ 10,7 MB nos itens de tamanho conhecido) + lote 2 — 12 itens do Portal Nacional pelo navegador do app
  (NT 2025.002 v1.52, 2026.007 v1.10, 2026.008, 2026.010, 2026.004, Conjunta 2025.001, 2025.001, 2018.005, 2013.007, PL_010f, schemas
  dos eventos, IT 2023.002); cópia [SEC] nunca é arquivada como oficial** · (b) só o lote 1; o Valdo baixa o lote 2 à mão e larga na
  pasta · (c) só links. *(Rec.: (a) — o portal só recusa cliente sem cookie; o que o navegador também não abrir cai em (b).)*
- **Q-NE95 Prova em homologação com o A1 da Setes pela SVRS (revisita a D-NE18)**: a D-NE18 deixou a autorização em H para o
  cliente-piloto porque a Setes não tem IE; com a NT 2026.007 (H 26/10) o emitente sem IE autoriza na SVRS. (a) manter a D-NE18 · (b)
  **somar: o ciclo completo (autorizar, consultar, cancelar, evento) provado em H pela SVRS com o A1 da Setes, como HIPÓTESE da NE-3/NE-5
  — com os pré-requisitos do próprio fisco: CRT igual ao da RFB (Setes = 1), CFOP da IT 2023.002, sem ICMS e com o grupo IBSCBS (puxa a
  parte do builder da IB-N para antes da prova); o que é do PR (apóstrofos, CSRT, 168 h, credenciamento, inutilização) segue com o
  cliente-piloto** · (c) trocar o cliente-piloto pela SVRS. *(Rec.: (b) — prova real sem esperar cliente; o PR continua precisando de um.)*
- **Q-NE96 Emitente sem IE no produto**: (a) **o autorizador passa a ser f(UF, modelo, ambiente, tpEmis, PRESENÇA de IE do emitente) — a
  IE vem da fonte de fatos do emitente e o autorizador já é gravado na tentativa (D-NE37); as restrições do sem-IE (CFOP, ICMS proibido,
  IBSCBS obrigatório) entram na camada 2 da pré-validação (D-NE43, NE-6); o escopo do 1º release segue a D-NE25** · (b) emitente sem IE
  fora do produto (recusa local). *(Rec.: (a) — é fato do mundo e custa UMA entrada a mais na derivação; sem ela a Q-NE95 (b) não existe.)*
- **Q-NE97 CSRT e software no UPD do PR (ajusta o QUANDO da D-NE44)**: (a) **tarefas do Valdo com prazo "antes da 1ª autorização em H no
  PR" (cliente-piloto, NE-5): pedir o CSRT de homologação e de produção da Setes como responsável técnica e cadastrar o software no UPD;
  a nfe-api guarda o CSRT como segredo de PLATAFORMA (D-NE44)** · (b) pedir já. *(Rec.: (a) — status, consulta e inutilização não levam
  `infRespTec`; nada da NE-0…NE-3 depende disso.)*
- **Q-NE98 MOC depois de 01/11/2026**: (a) **arquivar agora os PDFs 7.00 (versão congelada) e, a partir de 01/11, conferir no MOC Online do
  PR pelo navegador quando uma linha pedir — o acervo guarda o trecho lido em texto com a data da leitura** · (b) espelhar o MOC Online
  inteiro periodicamente. *(Rec.: (a) — o MOC muda pouco; quem muda são as NT.)*
- **Q-NE99 CNPJ alfanumérico (a frente da D-NE29 não tem prompt)**: a NF-e aceita desde 01/07/2026, a NFS-e desde 10/08/2026, e a RFB só
  atribui a inscrições NOVAS (desde jul/2026); o produto inteiro recusa (§12.1 item 8). (a) **Rodada 0 da frente em sessão PRÓPRIA logo
  depois da NE-0** · (b) agora, em paralelo · (c) esperar o 1º cliente com CNPJ alfanumérico (revoga a D-NE29). *(Rec.: (a) — o risco é o
  cliente NOVO (empresa aberta depois de jul/2026): crescente, ainda pequeno; o inventário já existe.)*
- **Q-NE100 DANFE**: (a) **o DANFE A4 da nfe-api nasce no leiaute da NT 2026.010 (produção 01/12/2026, antes de qualquer NF-e nossa em
  produção); o Anexo II 7.00 vale no que a NT não muda** · (b) Anexo II puro; a reforma depois. *(Rec.: (a); conferir no arquivo se a
  2026.010 vale para todo emitente ou só para nota com o grupo.)*
- **Q-NE93 (reapresentada — aberta desde 12/10) Teto do corpo HTTP da resposta do fisco**: com o dado "mensagem até 500 KB": (a) **teto no
  transporte do núcleo (2 MB); recusa = ambíguo pela causa que já existe na transmissão/consulta; executa na NE-2, junto do SOAP** · (b)
  limite conhecido. *(Rec.: (a).)*
- **Q-NE101 Ordem interna da NE-0** (§13.5). *(Rec.: aceitar.)*

### 13.7 Correções sem decisão (feitas nesta rodada)

§3.6 marcado (o 206); D-NE45 anotada (o dado do §13.3); §12.9 deixa de ser o ponto de retomada; `../nfe-api/INDEX.md` (a pasta
`integracoes/nfe-sefaz/` agora existe; estado da NE-0); `D:\Gestao2027\nfe-api\CLAUDE.md` (o estado era de 2026-10-03 e as decisões
citadas iam só até D-F108). Efeito colateral do levantamento: o WebFetch guardou cópias dos PDFs que leu no cache da SESSÃO (fora do
projeto) — não são o acervo nem contam como download autorizado.

### 13.8 Rodada 3 da `nfe-api` DECIDIDA (Valdo 2026-10-15: "siga as recomendações") — D-NE93…D-NE101

Cada D-NE*n* = a recomendação da Q-NE*n* (§13.6), na íntegra. Numeração permanente.

| Decisão | O que fixa | Onda |
|---|---|---|
| **D-NE93** (= Q-NE93 (a)) | teto do corpo HTTP da resposta do fisco no transporte do núcleo = **2 MB**; recusa = ambíguo pela causa que já existe na transmissão/consulta; executa na NE-2, junto do SOAP | NE-2 |
| **D-NE94** (= Q-NE94 (a)) | **downloads AUTORIZADOS**: lote 1 (8 itens oficiais de acesso direto) + lote 2 (12 itens do Portal Nacional pelo navegador do app), exatamente a lista do README do acervo; cópia [SEC] nunca é arquivada como oficial; o que o navegador não abrir cai para o Valdo baixar à mão | NE-0 |
| **D-NE95** (= Q-NE95 (b)) | **soma à D-NE18**: o ciclo completo (autorizar, consultar, cancelar, evento) é provado em H **pela SVRS com o A1 da Setes (sem IE)**, como HIPÓTESE da NE-3/NE-5, com os pré-requisitos do fisco (CRT = RFB, CFOP da IT 2023.002, sem ICMS, grupo IBSCBS — puxa a parte do builder da IB-N para antes da prova); o que é do PR (apóstrofos, CSRT, 168 h, credenciamento, inutilização) segue com o cliente-piloto | NE-3/NE-5 |
| **D-NE96** (= Q-NE96 (a)) | autorizador = f(UF, modelo, ambiente, tpEmis, **presença de IE do emitente**); a IE vem da fonte de fatos do emitente e o autorizador é gravado na tentativa (D-NE37); as restrições do sem-IE entram na camada 2 da pré-validação (D-NE43); o escopo do 1º release segue a D-NE25 — **refina a D-NE3/D-NE37** | NE-2/NE-3/NE-6 |
| **D-NE97** (= Q-NE97 (a)) | CSRT de H e de P da Setes como responsável técnica + cadastro do software no UPD = **tarefas do Valdo com prazo "antes da 1ª autorização em H no PR"** (cliente-piloto, NE-5); a nfe-api guarda o CSRT como segredo de PLATAFORMA — **ajusta o QUANDO da D-NE44** | NE-5 |
| **D-NE98** (= Q-NE98 (a)) | o acervo arquiva os PDFs do MOC 7.00 (versão congelada); a partir de 01/11/2026 confere no MOC Online do PR pelo navegador quando uma linha pedir e guarda o trecho lido em texto com a data da leitura | NE-0 em diante |
| **D-NE99** (= Q-NE99 (a)) | frente do CNPJ alfanumérico (D-NE29): Rodada 0 em sessão PRÓPRIA logo depois da NE-0 | depois da NE-0 |
| **D-NE100** (= Q-NE100 (a)) | o DANFE A4 da nfe-api nasce no leiaute da NT 2026.010; o Anexo II 7.00 vale no que a NT não muda; conferir no arquivo se a 2026.010 vale para todo emitente — **refina a D-NE51/D-NE20** | NE-5 |
| **D-NE101** (= Q-NE101) | ordem interna da NE-0 = §13.5 (arquivar → conferências que derrubam premissa → autorizadores → guardião + DDL em rascunho → OpenAPI → Rodada 4 se houver derrubada) | NE-0 |

### 13.9 NE-0 EXECUTADA na ordem da D-NE101 (2026-10-15) — E1…E5 feitos; Rodada 4 decidida no §13.10

**E1 — acervo arquivado** (`../nfe-api/integracoes/nfe-sefaz/` — README com arquivo · bytes · SHA-256 · origem; todo PDF com `.txt` ao lado): MOC
7.00 (Visão Geral + Anexos I–III), NT 2025.002 v1.52, 2026.007 v1.10, 2026.008, 2026.010, 2026.004, Conjunta 2025.001, 2025.001 v1.03,
2018.005 v1.52, 2013.007, PL_010f_v1.04 + schemas do cancelamento e da CC-e (extraídos), IT 2023.002 **v2.10** (a vigente; o levantamento
achara a 2.00), ATC RFB/CGIBS nº 8, NPF 101/2014 e 063/2012 do PR, cadeias ICP-Brasil do ITI (SHA-512 confere), zips de certificado do
servidor do PR, transcrição do aviso ENCAT de 05/10. **Como**: o "too many redirects" do Portal Nacional era só o teste de cookie do
ASP.NET — `curl -c/-b` resolve (o navegador do app só leu os links); o ITI tem um nó com certificado TLS VENCIDO intermitente (2ª tentativa
passou, hash confere); nenhuma verificação TLS foi desligada. **Não arquivado** (fora da lista da D-NE94 → Q-NE104): o pacote com as
MENSAGENS de serviço (o PL_010f traz só o leiaute da NF-e) e as NT 2023.001, 2023.004 e 2017.001.

**E2 — conferências**: as **65 linhas FECHADAS** (`CONFERENCIAS.md`, fonte = linha do `.txt` + página do PDF) — 26 CONFIRMA · 28 AJUSTA ·
**2 DERRUBA** (20 → D-NE95/D-NE96, já decididas; **51 → Q-NE103**) · 5 NÃO OFICIAL · 3 fora da F4. Três leitores em paralelo (A+B, C+D,
E+F+G) + o condutor (14, 20, 49, 53).

**E3 — autorizadores como DADO**: `AUTORIZADORES.md` + `autorizadores-2026-10-15.json` gerados da "Relação de Serviços Web" OFICIAL (produção
e homologação, lidas em 15/10): 10 SEFAZ próprias + SVAN (MA) + SVRS (16 UF) + SVC-AN/SVC-RS + AN; a SVC não tem inutilização; a SVRS tem
consulta cadastro também em H (o levantamento da web dizia o contrário); **o PI está na SVC-AN em P e na SVC-RS em H** (divergência da
própria relação, registrada por ambiente); o mapa UF→SVC do Anexo III (2020) diverge da relação atual — vale a relação com a data.
**TLS provado no handshake** (só leitura, sem certificado de cliente): PR = AC SOLUTI SSL EV G4 e SVRS = AC SERPRO SSLv1, ambas sob a **Raiz
ICP-Brasil v10** — a v10 sozinha como `ca` valida as duas (o zip de certificados publicado pelo PR tem a folha VENCIDA em 03/07/2026).

**E4 — parecer do guardião + DDL em RASCUNHO** (`prompt_onda_nfe_sefaz-ddl-ne2-rascunho.sql`, ao lado deste prompt — NÃO executado; sqlglot
OK; checklist do revisar-ddl feita pelo guardião e conferida no disco pelo condutor): **6 comandos** — `tb_invoice_merchandise_transmission`
(PK `(institution, invoice, terminal, attempt)`; `life_event`; chave NOSSA write-once com CHECK do `TChNFe` alfanumérico + mod 55/65 + tpEmis
1/6/7; `authorizer` com CHECK pela lista da relação; `digest_value` COLLATE bin; `receipt`/`protocol` (15 ou 17)/`dh_recbto` write-once;
`last_queried_at`), `…_transmission_event` (voz append-only, lista da família A R D P C K F N — sem S; cStat 3–4 dígitos; o 110111 com o
tpEvento em `authority_code` da voz C, molde D-F68) e `tb_invoice_number_void` (Id de 43, faixa, 102/563 como prova) + 3 views para o
setes-api (`authority_recorded` = protocolo, COLLATE bin — D-NE56). **Fora por construção**: cNF/cDV/tpEmis/série/número/modelo em coluna
própria (estão na chave), presença de IE (Q-NE105), tabela de vida, tabela de valores do fisco (na NF-e quem calcula é o emitente), tabela de
eventos (Q-NE106), mapa item→nItem (Q-NE103). Ainda NÃO provado (exige banco descartável na NE-2): coluna gerada STORED com UNIQUE no MariaDB
10.4 e no MySQL 8; EXPLAIN das três views.

**E5 — OpenAPI design-first**: `D:\Gestao2027\nfe-api\openapi\nfe-api.v1.yaml` (15 rotas; 110 referências resolvem — conferido com o js-yaml):
health com a cadeia do servidor e o estado por autorizador (D-NE54) · emitter do núcleo (55 só com o ambiente — a série é do ERP) · pendentes
paginados por ramo (`orders`/`order-returns`) · situação fiscal (estados `processing`/`denied`; `authorityRecorded`) · transmitir (201 A / 202 P;
409 `FISCAL_DENIED`; 422 com a lista inteira da pré-validação) · refresh (429 `FISCAL_QUERY_TOO_SOON` pelo 656) · cancelar (xJust 15–255;
prazo por UF como aviso) · XML (`procNFe` + `procEventoNFe`) · DANFE (NT 2026.010) · e-mail (ato explícito) · passada do rodízio · numeração
(buracos derivados) · inutilização (102/563/256). Pontos que dependem da Rodada 4 estão marcados `[Q-NE…]`.

**Ajustes por FATO (sem questão — o dado oficial muda o conteúdo, não o rumo)**:
- **D-NE45**: no 55 só o `dest/xNome` (598); o `xProd` do item 1 é da NFC-e (373, F5); o DANFE de H traz "SEM VALOR FISCAL".
- **D-NE46**: o aplicativo com CPF usa 920–969 (910–919 é o site do fisco); o 55 com CNPJ pelo nosso aplicativo só usa as séries **0–889**.
- **D-NE48**: o oficial exige só `tPag=90` (871) e `vPag=0` (904); omitir o `cobr` na devolução vira ESCOLHA nossa (a devolução não cobra).
- **D-NE36**: o 539 é FACULTATIVO — a UF que não o aplica devolve 204 também para chave diferente; o caminho "consultar as chaves de todas
  as tentativas" cobre (a consulta da nossa chave dá 217 e cai na rota do 539).
- **D-NE14/D-NE56**: cStat 3–4 dígitos e nProt 15 ou 17 (NT 2025.002 §5.1) — no DDL e no contrato.
- **D-NE27**: a tolerância OFICIAL nos totais é ZERO (só R$ 0,50 presa ao vServ; a 610 é facultativa e a 564 virou obrigatória) — a
  conferência `vNF` derivado × ERP não pode ser mais frouxa que isso.
- **D-NE44/D-NE97**: no PR o GRUPO `infRespTec` inteiro é obrigatório desde 2019 (972/973) e o CNPJ do responsável técnico tem de ser o
  CADASTRADO para o emitente (974) — no PR o uso do sistema é pedido pelo ESTABELECIMENTO no UPD com a Setes como fornecedora (tarefa de
  implantação POR CLIENTE, além do CSRT da Setes); `hashCSRT` = Base64(SHA-1(CSRT + chave)).
- **D-NE26/D-NE38/D-NE54**: parâmetros do 656 (facultativos e parametrizáveis por autorizador); status em laço ≥ 3 min; ≥ 15 s antes do
  recibo; a SEFAZ processa até 3 min; consulta protocolo até 180 dias.
- **D-NE32/D-NE20**: Code-128C; com CNPJ alfanumérico a NT Conjunta sugere código HÍBRIDO 128C/128A — a lib única precisa dos dois.
- **D-NE43**: o subconjunto do 1º release perde a 785 (só NFC-e); X10/X16/X21 não são regras.
- **D-NE100**: fechado o "conferir" — a NT 2026.010 vale para TODO DANFE 55 (com ou sem IBS/CBS) e imprime o CRT do emitente.
- **D-NE18**: expectativa do smoke da Setes no PR — status e consulta protocolo passam; consulta cadastro → 257; inutilização → 203.

**Conhecimento negativo novo** (README do acervo): o `.txt` de NT não mostra o tachado (ferramenta `ferramentas/riscados.py`); o `-layout`
desalinha colunas de cronograma e troca IDs de regra no Anexo I (usar `-raw` e a posição no PDF); a data que vale pode estar num AVISO e não
na NT; o zip de certificado do servidor publicado pela UF envelhece — o que vale é a raiz.

#### 13.9.1 ⚠️ Rodada 4 da nfe-api — questões para o Valdo (recomendação entre parênteses)

- **Q-NE102 vProd com IBS/CBS a partir de 2027** (NT 2026.008 — CONFERENCIAS 40): IBS, CBS e IS passam a COMPOR o `vProd` (logo o `vNF`);
  campos novos `vUnComLiq`/`vProdLiq`/`vProdLiqTot`; o Simples recebe a regra em NT futura. (a) **parecer do guardião: nenhum conceito nem
  coluna nova — é regra do motor (ERP, IB-N) e do builder (NE-4), com três guardas: o preço do item no ERP mantém UM significado (o líquido
  = `vUnComLiq`) e o bruto é derivado pelo builder; o IBS/CBS/IS do item é snapshot do ERP, nunca voz do fisco; o `total_value` do ramo segue
  sendo o `vNF` e a base dos títulos (D-NE27/D-IB12), com a fórmula datada pelo fato (D-IB13); "líquido" entra no glossário de palavras
  ocupadas (na comissão = "depois do desconto"; na NT = "sem tributos")** · (b) o preço do item passa a ser o bruto a partir de 2027. *(Rec.:
  (a) — (b) daria à mesma coluna dois significados conforme a data.)*
- **Q-NE103 Devolução referencia POR ITEM** (rej. 321 — `DFeReferenciado` = chave + nItem em cada item; `refNFe` proibido; 1048, 1072, 1130,
  1193, 1194; produção 16/11/2026 — derruba a parte "`refNFe` da âncora" da D-NE25/D-E15). Onde nasce "o item X foi o nItem N da NF-e K"?
  (a) fato write-once no `fiscal_api` (a nfe-api grava o mapa na reserva) · (b) **DERIVAÇÃO determinística por UMA peça — a que o builder usa
  para numerar o `det` (só o que está congelado na vida: itens com snapshot de imposto do ramo, em ordem pelo id do item — nunca
  `tb_product.kind`), reusada pela devolução (e pelos eventos RTC que também citam nItem); antes de referenciar, confere o `det[nItem]` do
  `procNFe` ARQUIVADO da origem (cProd, qCom, vUnCom) — divergência = 422, nunca chute; nada é gravado (D-F10/D-F31 intactos);
  conhecimento negativo: mudar a ordem da peça muda o passado — a conferência pelo XML é a cerca** · (c) o ERP grava o nItem no item ao
  faturar. *(Rec.: (b) — (a) grava N cópias do mesmo mapa por vida e põe a API como dona de conteúdo; (c) é dado da nota guardado no item do
  pedido, sem consumidor no ERP.)*
- **Q-NE104 Downloads adicionais** (Portal Nacional da NF-e, `exibirArquivo.aspx`, tamanhos lidos no cabeçalho): `PL_010d_v1.03.zip` (67.813
  B — pacote com as mensagens de serviço e o CNPJ alfanumérico) · `CNPJ Alfanumérico - NT2026.004.v.1.01 PL Eventos e Cad Consulta Cadastro
  CCC.zip` (65.203 B — schemas de evento e consulta cadastro alfanuméricos; os de 2014/2018 arquivados não validam o 110111 com CNPJ
  alfanumérico) · NT 2023.001 v1.60 monofásico (1.752.521 B — CONFERENCIAS 44) · NT 2023.004 v1.20 `indDeduzDeson` (714.686 B — a W16 do MOC
  deve estar defasada por ela — 40/45) · NT 2017.001 v1.50 GTIN (727.901 B — 47). (a) **os cinco** · (b) só os dois pacotes de schema · (c)
  nenhum. *(Rec.: (a) — sem eles a validação XSD local (D-NE16/D-NE43) não roda nas mensagens e três linhas ficam NÃO OFICIAL.)*
- **Q-NE105 Presença de IE como coluna** (G1 do guardião — refina o E4 do §13.2 e a D-NE96): (a) **não vira coluna: o autorizador é a coluna
  (consequência); a presença de IE fica no XML enviado (`emit/IE`) — guardar entrada e resultado seriam dois fatos que podem se contradizer**
  · (b) coluna `state_registration_absent` ao lado do autorizador. *(Rec.: (a).)*
- **Q-NE106 Voz do EVENTO na F4** (G2 — refina a D-NE39): (a) **sem tabela própria: o 110111 (único evento da F4, nSeq sempre 1) é o C/K/N da
  voz da tentativa, com o tpEvento em `authority_code` da voz C (molde D-F68); a tabela de eventos nasce com a CC-e ou os eventos RTC, agregando
  sem reformar; a NE-3 confere se o 136 vale como C** · (b) tabela `…_document_event` já na NE-2. *(Rec.: (a) — a F2a já lê `last_kind = 'C'` na
  view; dois lugares para "cancelada" seria maquete.)*
- **Q-NE107 Voz S na família NF-e** (G3): (a) **fora da lista de escrita (a "tentativa sem voz" já é o em voo; S sem saída é a D-F102); entra
  só se a NE-5 precisar, junto com a saída** · (b) S na lista desde a NE-2. *(Rec.: (a).)*
- **Q-NE108 cStat 106 "lote não localizado"** (G4 — a D-NE33 não o mapeia): (a) **não grava voz; a tentativa segue P; a saída é a consulta pela
  NOSSA chave; só se reenvia o mesmo XML depois dessa consulta** · (b) 106 = F. *(Rec.: (a) — a SEFAZ processa por até 3 min e reenvio às cegas
  consome o 656.)*
- **Q-NE109 UNIQUE da faixa inutilizada** (G5): (a) **UNIQUE só entre os pedidos NÃO rejeitados (coluna gerada) — um 203/256 corrigível não
  bloqueia novo pedido da mesma faixa; provar a coluna gerada no MariaDB 10.4 e no MySQL 8 na NE-2** · (b) UNIQUE simples. *(Rec.: (a) — a
  Setes deve receber 203 no PR; com (b) a faixa ficaria presa.)*
- **Q-NE110 Corrida inutilização × cunhagem de número** (G6): (a) **a view publica faixas PENDENTES e homologadas e o ERP pula as duas ao
  cunhar; a reserva da inutilização toma a TRAVA do contador da institution no ERP como 1º comando (antes de conferir que a faixa não tem
  nota viva) — entra na lista da D-F31 como 2ª trava admitida (hoje só a da nota); no MySQL 8 da F3 o `FOR UPDATE` exige GRANT** · (b) só a
  view (corrida aceita como limite conhecido). *(Rec.: (a) — número cunhado dentro de faixa inutilizada é documento inválido.)*
- **Q-NE111 Prova de "não registrada" na NF-e** (G7 — análogo da D-F90): (a) **regra e coluna nascem na NE-5 com a política (um 217 cedo demais
  vira F prematuro e o número seria reaproveitado com a nota antiga podendo autorizar depois); ADD COLUMN agrega** · (b) já no DDL da NE-2.
  *(Rec.: (a).)*
- **Q-NE112 Devolução com duas linhas do mesmo item de origem** (G9 — rej. 1072; `tb_order_item_return` sem UNIQUE `(tb_order_id,
  tb_order_item_id_ori)`): (a) **a camada 2 do `validate` do faturamento recusa (NE-6); o builder nunca soma** · (b) a tela agrega as linhas.
  *(Rec.: (a), com a tela avisando já na digitação.)*
- **Q-NE113 Devolução de venda do LEGADO** (G10 — nota sincronizada, sem tentativa nativa): (a) **fora do 1º release com recusa legível
  (`INVOICE_LEGACY_NOT_TRANSMITTABLE` já existe); reabre com o 1º cliente de mercadoria vindo do Gestao2016** · (b) casar pelo XML autorizado da
  origem (a nfe-api leria o storage do setes-sync — cruza a fronteira dos grupos) · (c) escolha manual na tela, gravada no ERP. *(Rec.: (a)
  agora; o guardião prefere (b) como alvo — a decisão de ler o storage do outro grupo fica para quando houver o cliente.)*
- **Q-NE114 Coluna `digest_value`** (G11 — não estava nas decisões): (a) **manter — sustenta a D-NE41 dentro da transação (o arquivo em disco não
  é transacional)** · (b) ler o digest do arquivo. *(Rec.: (a).)*

**Depois da Rodada 4**: arquivar a Q-NE104 (se autorizada) e fechar 40/44/45/47 e o XSD das mensagens; NE-0 FECHADA → frente do CNPJ alfanumérico
em sessão própria (D-NE99) → NE-1b/NE-2/NE-3 (D-NE55).

### 13.10 Rodada 4 da `nfe-api` DECIDIDA (Valdo 2026-10-15: "siga as recomendações") — D-NE102…D-NE114 — e NE-0 FECHADA

Cada D-NE*n* = a recomendação da Q-NE*n* (§13.9.1), na íntegra. Numeração permanente.

| Decisão | O que fixa | Onda |
|---|---|---|
| **D-NE102** | IBS/CBS/IS no `vProd` a partir de 2027 (NT 2026.008) = **regra do motor (ERP, IB-N) e do builder (NE-4)**, sem conceito nem coluna nova: o preço do item mantém UM significado (o líquido = `vUnComLiq`) e o bruto é derivado pelo builder; IBS/CBS/IS do item = snapshot do ERP; `total_value` do ramo segue sendo o `vNF` e a base dos títulos (D-NE27/D-IB12), fórmula datada pelo fato (D-IB13); **a W16 vigente é a da NT 2023.004** (`indDeduzDeson`, vICMSMonoReten, PIS/COFINS-ST com indicador); "líquido" entra no glossário de palavras ocupadas | IB-N · NE-4 · NE-6 |
| **D-NE103** | devolução referencia POR ITEM (`DFeReferenciado` chave + nItem; `refNFe` proibido — rej. 321) — **supera a parte "`refNFe` da âncora" da D-NE25/D-E15**; o nItem é DERIVADO por UMA peça (a que o builder usa para numerar o `det`: itens com snapshot de imposto do ramo, em ordem pelo id do item, nunca `tb_product.kind`), reusada pela devolução e pelos eventos RTC; antes de referenciar, confere o `det[nItem]` do `procNFe` arquivado da origem (cProd, qCom, vUnCom) — divergência = 422 `FISCAL_RETURN_REFERENCE_MISMATCH`, nunca chute; nada gravado (D-F10/D-F31 intactos); conhecimento negativo: mudar a ordem da peça muda o passado | NE-4 · NE-6 |
| **D-NE104** | downloads dos cinco (PL_010d_v1.03, pacote de eventos/consulta cadastro alfanuméricos, NT 2023.001, 2023.004, 2017.001) — **FEITOS** (abaixo) | NE-0 |
| **D-NE105** | presença de IE NÃO vira coluna: o autorizador é a coluna; a presença fica no XML enviado (`emit/IE`) — **refina a D-NE96 e o E4 do §13.2** | NE-2 |
| **D-NE106** | o 110111 (único evento da F4, nSeq 1) é o C/K/N da voz da tentativa, tpEvento em `authority_code` da voz C (molde D-F68); a tabela de eventos nasce com a CC-e ou os eventos RTC, agregando; a NE-3 confere se o 136 vale como C — **refina a D-NE39** | NE-2/NE-3 |
| **D-NE107** | voz S FORA da lista de escrita da família NF-e; entra só se a NE-5 precisar, junto com a saída | NE-2 |
| **D-NE108** | cStat 106 "lote não localizado": não grava voz, a tentativa segue P, a saída é a consulta pela NOSSA chave; só se reenvia o mesmo XML depois dela — **completa a D-NE33** | NE-3/NE-5 |
| **D-NE109** | UNIQUE da faixa inutilizada só entre os pedidos NÃO rejeitados (coluna gerada `withdrawn_void_id`); provar no MariaDB 10.4 e no MySQL 8 na NE-2 | NE-2 |
| **D-NE110** | corrida inutilização × cunhagem: a view publica faixas PENDENTES e homologadas e o ERP pula as duas ao cunhar; a reserva da inutilização toma a trava do CONTADOR da institution no ERP como 1º comando — **2º item da lista fechada da D-F31** (nota registrada junto da D-F31 no prompt das APIs fiscais); GRANT do `FOR UPDATE` no MySQL 8 da F3 | NE-2/NE-5/NE-6 |
| **D-NE111** | prova de "não registrada" (217) na NF-e: regra e coluna nascem na NE-5 com a política (análogo da D-F90); ADD COLUMN agrega | NE-5 |
| **D-NE112** | devolução com duas linhas do mesmo item de origem (rej. 1072): a camada 2 do `validate` recusa (a tela avisa na digitação); o builder nunca soma | NE-6 |
| **D-NE113** | devolução de venda do LEGADO fora do 1º release, com recusa legível; reabre com o 1º cliente de mercadoria vindo do Gestao2016 (o guardião prefere casar pelo XML como alvo — exige decidir a leitura do storage do setes-sync) | NE-6 |
| **D-NE114** | `digest_value` na tentativa (sustenta a D-NE41 dentro da transação) | NE-2 |

**Executado na mesma sessão**:
- **D-NE104 — arquivados** (README do acervo, SHA-256): `PL_010d_v1.03.zip` e o pacote de eventos/consulta cadastro (extraídos — os schemas de evento e de
  inutilização agora aceitam CNPJ alfanumérico: Id do evento `ID[0-9]{12}[0-9A-Z]{12}[0-9]{28}`, Id da inutilização `ID[0-9]{4}[0-9A-Z]{12}[0-9]{25}`,
  TProt 15|17, TStat 3–4; a raiz `ProcInutNFe` é oficial), NT 2023.001, NT 2023.004, NT 2017.001 (com `.txt`).
- **Conferências reabertas e fechadas** (CONFERENCIAS): 1 (versões; faltam só as RAÍZES das mensagens — pacote-base), 8 (`ProcInutNFe` oficial), 31 (Id
  alfanumérico), 40 (**W16 da NT 2023.004**), 44 (o Simples pode usar os CST monofásicos — exceção da 590), 45 (`indDeduzDeson` — o ERP precisa
  congelá-lo por item com desoneração, NE-6), 47 ("SEM GTIN" aceito; exigência por cronograma CNAE × NCM; a NT vigente é a 2021.003 v1.50).
- **DDL em rascunho v1.1**: cabeçalho com a Rodada 4; a alternativa (a) da Q-NE103 marcada REJEITADA (fica como conhecimento negativo). As demais
  decisões já estavam no rascunho do guardião (sem coluna de IE, voz sem S, UNIQUE da faixa pela coluna gerada, view com faixas pendentes).
- **OpenAPI**: marcas `[Q-NE…]` → `[D-NE…]`; transmitir ganha `FISCAL_RETURN_REFERENCE_MISMATCH` e `FISCAL_RETURN_DUPLICATED_ITEM` (D-NE103/D-NE112) e a
  recusa da origem do legado (D-NE113).
- **D-F31** (prompt das APIs fiscais): nota com a D-NE110 junto da decisão.

**NE-0 FECHADA** (2026-10-15): E1…E5 entregues, as 65 conferências fechadas, Rodadas 3 e 4 decididas. Ficam abertos só dois DOWNLOADS, que não bloqueiam
nada antes da NE-3/NE-4:

- **Q-NE115 Pacote-base das mensagens** — `PL_009_V4_00_NT_2020_006_v1.20.zip` (Portal NF-e, 70.894 B): as raízes `enviNFe`/`inutNFe`/`consReciNFe`/
  `consStatServ` e retornos que os pacotes de atualização não trazem; sem ele a validação XSD local (D-NE16/D-NE43) não roda nessas mensagens. (a) **baixar**
  · (b) usar a cópia do ACBr só como conferência. *(Rec.: (a) — validação de produção nunca por cópia de terceiro.)*
- **Q-NE116 NT 2021.003 v1.50** (GTIN, publicada 25/09/2026 — `NT2021.003_v1_50 - Validacao GTIN Grupo V.pdf`, Portal NF-e, 1.240.427 B): a NT VIGENTE
  do GTIN (a 2017.001 arquivada é a anterior). (a) **baixar** · (b) depois, na NE-4. *(Rec.: (a) — custa nada e fecha a linha 47.)*

**Próximo (D-NE55 + D-NE99)**: frente do **CNPJ alfanumérico** — Rodada 0 em sessão PRÓPRIA (inventário no §12.1 item 8; fatos oficiais no acervo: NT
Conjunta 2025.001 e NT 2026.004 — produção 01/07/2026, DV ASCII − 48, Code-128 híbrido no DANFE) → **NE-1b / NE-2 / NE-3** (a NE-2 nasce do DDL em
rascunho + `nfe-api.v1.yaml`; a NE-3 do `AUTORIZADORES.md` e do smoke H — status/consulta no PR com o A1 da Setes; autorização pela SVRS sem IE a partir
de 26/10 em H — D-NE95).

#### 13.10.1 D-NE115 e D-NE116 DECIDIDAS e EXECUTADAS (Valdo 2026-10-15: "siga as recomendações") — NE-0 sem pendência

| Decisão | O que fixa |
|---|---|
| **D-NE115** (= Q-NE115 (a)) | pacote-base `PL_009_V4_00_NT_2020_006_v1.20.zip` ARQUIVADO (70.894 B, SHA-256 be222eb8336bfb38): todas as RAÍZES das mensagens (enviNFe, retEnviNFe, consReciNFe, inutNFe, retInutNFe, consStatServ, retConsStatServ, procNFe). Validação XSD local = **sobreposição de camadas** base `PL_009_V4` → `PL_010d_v1.03` → `PL_010f_v1.04` (README do acervo — conhecimento negativo: os pacotes 010d/010f são atualizações, não versões completas) |
| **D-NE116** (= Q-NE116 (a)) | NT 2021.003 v1.50 ARQUIVADA (1.240.427 B, SHA-256 28b7e26b1a515cdd): é a NT VIGENTE do GTIN (substitui a 2017.001 na matéria); Grupo IV em produção desde 01/10/2025, **Grupo V H 01/04/2027 · P 01/09/2027** — a pré-validação da NE-4 parte dela (CONFERENCIAS 47) |

**NE-0 FECHADA SEM PENDÊNCIA**: nenhuma questão da nfe-api aberta. **PUBLICADA 2026-10-15** ("pode publicar a NE-0") — infra 5a1633d · nfe-api a9ef9ac. Próximo (D-NE55 + D-NE99): frente do **CNPJ alfanumérico** — Rodada 0 em sessão
PRÓPRIA → NE-1b / NE-2 / NE-3.

## 14. NE-1b — Rodada 0 (2026-10-17): a base de PDF no núcleo — SÓ NF-e

> Valdo (2026-10-17): "vamos para a NE-1b" e, quando a rodada derivou para o DANFSe, "por que estamos falando de nfs-e?" → **o escopo desta onda é
> a NF-e**. A lacuna do DANFSe achada no caminho virou tarefa SEPARADA da família NFS-e (chip "Conformar o DANFSe à NT 008 (v2.0)" — §14.4, último
> item) e NÃO entra aqui. Antes: a frente do CNPJ alfanumérico teve a janela da onda 0 executada em produção na mesma noite (`prompt_frente_cnpj_alfanumerico.md` §8.16).

### 14.1 O que a NE-1b entrega

Linha do §12.3: "base de PDF (D-NE20) com código de barras (Q-NE32), 'Folha n/N', marca d'água por página; documento alfanumérico no núcleo (Q-NE29)".

- **Base de PDF no núcleo para o DANFE** (e para a NFC-e na F5): régua em cm, papéis de fonte, escritor com PASSADA POR FOLHA (índice e total),
  marca d'água, Code-128 da chave no híbrido C/A da NT Conjunta 2025.001, QR (lib única — D-NE32).
- **"Documento alfanumérico no núcleo" = FEITO pela frente do CNPJ**: a peça `fiscal-api/federal-id` está em produção desde 2026-10-17 (núcleo 4b17b23).
  Nada a fazer aqui.
- **Não entra**: o leiaute do DANFE (NE-5 — NT 2026.010 / D-NE100), o TEXTO "Folha n/N" e o cabeçalho repetido nas folhas adicionais (layout da família
  — Q-NE122), os formatadores de valor/chave, qualquer coisa do DANFSe.

### 14.2 Fatos oficiais (acervo já arquivado — nada baixado nesta rodada)

- **MOC 7.00 Anexo II** (`../nfe-api/integracoes/nfe-sefaz/moc-7.00/moc7-anexo-ii-danfe-codigo-barras.txt`): DANFE pode ter várias folhas; "o número de
  ordem e o número total de folhas deverão ser impressos na parte superior de cada uma das folhas, inclusive na primeira" (3.10.2, `:1375-1378`);
  folhas adicionais repetem emitente, "DANFE", número/série/tipo, total e ordem da folha, código de barras, natureza e chave (3.5, `:645-668`); marca
  d'água permitida se não prejudicar a leitura (3.10.1, `:1370-1373`); homologação = "SEM VALOR FISCAL" em infCpl OU marca d'água destacada (`:302-304`);
  fontes Times New Roman ou Courier New, tamanhos mínimos por campo (3.7, `:714-772`); margens 0,2–0,8 cm (3.6.2, `:696-699`); A4 a Ofício II.
- **NT Conjunta 2025.001 §6** (`…/nt/nt-conjunta-2025-001.txt:166-343`): código de barras da chave = CODE-128 HÍBRIDO — Start C; troca para A antes de letra
  e no dígito ímpar que antecede letra; volta para C em grupos ≥ 4 dígitos (par: antes do grupo; ímpar: depois do 1º dígito); DV mód. 103 (exemplo
  "5225AB83": soma 1987 → DV 30, `:236-271`); largura mínima 11,5 cm, altura 0,8 cm, módulo ≥ 0,02 cm, margem clara ≥ 10 módulos (`:201-227`).
  **CONHECIMENTO NEGATIVO — o texto da NT tem dois erros**: "código 100 para alternar os subtipos A e C" (`:179` — 100 é Code B; o exemplo correto usa
  101 = Code A a partir de C e 99 = Code C a partir de A) e "o valor 103 que corresponde ao caractere de início (start) para o padrão Code C" (`:263` —
  103 é Start A; Start C = 105, como a própria NT diz em `:235`). Seguir o EXEMPLO, nunca a frase.
- **NT 2026.010** (DANFE da Reforma, produção 01/12/2026 — `…/nt/nt-2026-010-v1-00.txt:253-264`): o QR Code (ZX02) passará a valer também no DANFE
  modelo 55, retrato e paisagem, com regra a publicar → **a lib de QR serve a NE-5, não só a NFC-e da F5** (reforça a D-NE32).

### 14.3 Prova de conceito (scratchpad da sessão — nada no repositório)

- **bwip-js 4.11.4** (MIT, zero dependências, publicada 2026-08-19; ~12,6 MB no disco com todos os builds): `bwip.raw()` existe; com `raw: true` aceita os
  CODEWORDS ditados por nós e **reproduz o exemplo da NT símbolo por símbolo** (`StartC 52 25 CodeA 33 34 CodeC 83 30 Stop` — DV 30); no modo AUTOMÁTICO
  troca para **Code B** (válido, mesma largura, mas foge do A "sugerido"); a chave alfanumérica de 44 posições sai com 31 símbolos no automático. QR:
  matriz 37×37 da URL de consulta, **decodificada de volta pelo jsQR 1.4.0 (Apache-2.0) = igual à URL**.
- **pdfkit 0.20.2** (o mesmo da nfse-api): com `bufferPages`, a passada final escreve "FOLHA i/3" em cada uma das 3 folhas DEPOIS de conhecer o total e a
  marca d'água diagonal em todas; Code-128 vetorial numa caixa de 11,5 × 0,8 cm (132 módulos de 0,087 cm ≥ 0,02 cm); QR vetorial; acentos pt-BR em
  Times/Courier (fontes-padrão, WinAnsi) — texto extraído do PDF conferido.

### 14.4 Parecer do guardião (agente `setes-conceito`, 2026-10-17 — integrado; referências de código conferidas no disco pelo condutor)

**Conceito**: a base de PDF é o vocabulário de DESENHO comum aos documentos auxiliares (folha, fonte por papel, marca d'água, barras, matriz) — cega ao
fisco: não sabe o que é nota, voz ou estado. DANFE e DANFSe são COMPOSIÇÕES da família; a base não compõe nada.

| Peça | O que é | Natureza | Onde (núcleo) |
|---|---|---|---|
| `cmToPt` | a régua em cm das normas → ponto do PDF | pura | `src/pdf/units.ts` |
| `code128Symbols` → `code128Bars` | texto [0-9A-Z] → símbolos no híbrido C/A (Start C 105, CODE A 101, CODE C 99, DV mód. 103, Stop) → larguras | pura | `src/pdf/barcode/code128.ts` |
| `qrMatrix` | texto → matriz de módulos (a ÚNICA porta para a lib) | pura na saída | `src/pdf/barcode/qr.ts` |
| `createPdf` → `{ doc, end(sheetPass) }` | A4, margens em cm, passada final POR FOLHA com `{ index, total }` (`bufferPages`) | pdfkit | `src/pdf/pdf-writer.ts` |
| `registerFontRoles` | papel (título, conteúdo, fixo) → fonte escolhida pela FAMÍLIA | pdfkit | `src/pdf/fonts.ts` |
| `drawBars` / `drawMatrix` | módulos → retângulos vetoriais numa caixa; devolve o módulo efetivo (a família confere o mínimo da norma) | pdfkit | `src/pdf/draw.ts` |
| `drawWatermark` | texto diagonal na folha corrente (tamanho, ângulo, cor CMYK) — sem enum de estados | pdfkit | `src/pdf/draw.ts` |
| superfície `fiscal-api/pdf` | 3º subpath publicado — FORA do índice principal e do `reading` (o setes-api não carrega pdfkit) | — | `src/pdf.ts` |

- **Marcas = decisão da FAMÍLIA, desenho da BASE**: na NE-5 nasce `danfeMarksOf` (homologação → "SEM VALOR FISCAL"; contingência pelo `tpEmis` do XML —
  hoje fora, D-E12); a base só oferece `drawWatermark(texto, estilo)`. Um "DocumentoAuxiliar" genérico precisaria de parâmetro "página única × Folha
  n/N" e de enum com os estados de todas as famílias — a regra morre por construção.
- **Paginação**: a base dá só a passada por folha; "Folha n/N" + cabeçalho repetido é layout do DANFE (NE-5); o DANFSe (quando for consumidor) afirma
  `total === 1` e falha alto se transbordar.
- **Fontes**: a base dá o mecanismo de papéis; a escolha é da norma de cada família (MOC: Times/Courier).
- **Palavras ocupadas**: "carimbo" (carimbo de tempo do rodízio — D-F90) e "selo" (selo fiscal da OS, selo da aba IBS/CBS) — a base fala `pdf`, `sheet`,
  `watermark`, `bars`, `matrix`; nunca "documento"/"nota".
- **Fora do núcleo**: quadros e coordenadas de cada norma, textos das marcas, leitura do XML, logomarcas, configs `danfe_*` (D-NE51), persistência do PDF,
  caixa de texto que encolhe/corta; os formatadores (`fmtDecText`/`addDecText`/`fmtKey`) só sobem com o 2º consumidor.
- **Publicação**: pdfkit como `peerDependency` (precedente do express) + devDependency do núcleo; consumidor que usar `fiscal-api/pdf` pelo `src` precisa
  mapear o subpath no `tsconfig` `paths` e no `moduleNameMapper` do jest (sem isso o tsx cai no `dist` — cópia velha, `instanceof` quebrado). **Duas cercas
  novas**: `src/pdf/**` não importa `voice/`, `erp/`, `establishment/` nem `errors/`; nem `reading`, nem `federal-id`, nem o índice principal alcançam `pdf/`.
- **Divergência registrada**: o guardião recomendou fazer o DANFSe v2.0 (NT 008) DENTRO da NE-1b como 1º consumidor real da base (peça sem consumidor =
  risco de abstração errada). Com o direcionamento do Valdo (só NF-e), isso vai como **Q-NE117**. Os achados da NT 008 — QR obrigatório, "SUBSTITUÍDA"
  saindo como "CANCELADA" (toda voz C vira `cancelled` — `fiscal-api/src/voice/reading.ts:254` → `nfse-api/src/nfse/transmission.ts:1225`, embora
  `isSubstitutionCancel` exista em `fiscal-api/src/voice/families/service.ts:71`), sem aviso de homologação, sem marca d'água diagonal, margens fora da
  faixa, leiaute fora do Anexo I — estão no chip da família NFS-e.

### 14.5 ⚠️ Rodada 5 da nfe-api — questões para o Valdo (recomendação entre parênteses)

- **Q-NE117 Consumidor da base nesta onda.** (a) **NE-1b só NF-e: a base provada pelos próprios testes + uma "folha de prova" no teste (3 folhas, Code-128
  da chave + QR + marca d'água, decodificados e conferidos); o DANFSe fica com a tarefa da família NFS-e, que vira o 1º consumidor real quando rodar** ·
  (b) o DANFSe v2.0 dentro da NE-1b (recomendação do guardião; +1 sessão e volta à NFS-e). *(Rec.: (a) — o direcionamento é a NF-e; o risco de abstração
  errada fica contido porque as formas são DITADAS pelas normas (Code-128, QR, cm) e o resto da base é fino.)*
- **Q-NE118 Como sai o Code-128.** (a) **plano C/A NOSSO (peça pura `code128Symbols`, regras 1–4 da NT + DV) e a lib em modo `raw` só converte os símbolos
  em larguras; o teste decodifica as barras com uma tabela-ORÁCULO própria (independente da lib)** · (b) plano nosso e larguras pela nossa tabela também em
  produção (a lib fica só no QR) · (c) modo automático da lib (Code B no lugar do A). *(Rec.: (a) — D-NE32 ao pé da letra, provado no spike; a tabela
  Code-128 vive só no teste, como verificador da lib.)*
- **Q-NE119 A lib.** **bwip-js 4.11.4** como dependência do núcleo (carregada só pelo subpath `pdf`) + **jsqr 1.4.0 só em devDependency** (oráculo do QR nos
  testes). *(Rec.: sim.)*
- **Q-NE120 Fontes do DANFE.** (a) **as 14 fontes-padrão (Times-Roman/Courier, sem embutir, WinAnsi); caractere fora do WinAnsi = substituição VISÍVEL definida
  numa regra da base, com teste** · (b) Liberation Serif/Mono embutidas (OFL, Unicode completo, +~1 MB por fonte). *(Rec.: (a) — é a norma ao pé da letra;
  embutir só se aparecer texto real fora do WinAnsi ou validador que recuse.)*
- **Q-NE121 Publicação da base.** Subpath `fiscal-api/pdf`, pdfkit como `peerDependency`, as duas cercas do guardião. *(Rec.: sim.)*
- **Q-NE122 O texto "Folha n/N".** A base entrega a passada por folha (`index`, `total`); o TEXTO "Folha n/N" e a repetição do cabeçalho nascem com o DANFE na
  NE-5 (ajusta a linha do §12.3). *(Rec.: sim.)*
- **Q-NE123 Janela da NE-1b.** A onda só ACRESCENTA o subpath no núcleo — o índice principal não muda, a nfse-api de produção não importa `pdf/` e não precisa
  de restart: publicar = `merge --ff-only` + `npm install` (bwip-js) + `npm run build` no núcleo vivo + push, depois dos gates. *(Rec.: sim.)*

### 14.6 Plano de execução (depois das decisões)

Worktree `D:\Gestao2027\ne1b\fiscal-api` (branch `ne1b`, a partir do `main` 4b17b23 — o núcleo vivo é deploy da nfse-api pelo `src`, D-F133): (1) `units`
→ (2) `code128` puro (exemplo da NT, chaves numéricas e alfanuméricas, alfabeto fora = recusa, os dois erros da NT fixados em teste) → (3) `qr` → (4)
`pdf-writer` com a passada por folha → (5) `fonts` (+ regra do WinAnsi) → (6) `draw` (barras/matriz/marca d'água com os mínimos conferidos) → (7) superfície
`fiscal-api/pdf` + cercas → (8) folha de prova decodificada no teste → (9) gates (socrático + adversarial) → (10) janela (Q-NE123). Estimativa: 1 sessão.

### 14.7 Rodada 5 da `nfe-api` DECIDIDA (Valdo 2026-10-17: "siga as recomendações") — D-NE117…D-NE123

| Decisão | O que fixa |
|---|---|
| **D-NE117** (= Q-NE117 (a)) | NE-1b SÓ NF-e: a base é provada pelos próprios testes + uma folha de prova (3 folhas) decodificada no teste; o DANFSe NÃO entra (tarefa da família NFS-e — o 1º consumidor real quando rodar). Diverge do guardião, registrado no §14.4 |
| **D-NE118** (= Q-NE118 (a)) | Code-128: plano C/A NOSSO (peça pura `code128Symbols` — regras 1–4 da NT + DV mód. 103); a lib em modo `raw` só converte símbolos em larguras; a tabela Code-128 vive só no TESTE, como oráculo independente da lib |
| **D-NE119** (= Q-NE119) | bwip-js 4.11.4 (versão EXATA) como dependência do núcleo, carregada só pelo subpath `pdf`, por UMA porta (`barcode/lib.ts`); jsqr 1.4.0 só em devDependency |
| **D-NE120** (= Q-NE120 (a)) | as 14 fontes-padrão (Times-Roman/Courier no DANFE), sem embutir; caractere fora do WinAnsi = substituição VISÍVEL por regra da base, com teste |
| **D-NE121** (= Q-NE121) | subpath `fiscal-api/pdf`; pdfkit como `peerDependency` (opcional — o setes-api não instala) + devDependency do núcleo; as duas cercas do guardião |
| **D-NE122** (= Q-NE122) | a base entrega a passada por folha (`index`, `total`); o TEXTO "Folha n/N" e o cabeçalho repetido nascem com o DANFE na NE-5 — ajusta a linha da NE-1b no §12.3 |
| **D-NE123** (= Q-NE123) | janela da NE-1b = `merge --ff-only` + `npm install` + `npm run build` no núcleo vivo + push, DEPOIS dos gates; sem restart (nada em produção importa `pdf/`) |

### 14.8 NE-1b EXECUTADA em worktree (2026-10-17) — núcleo 1072916 (branch `ne1b`)

Worktree `D:\Gestao2027\ne1b\fiscal-api` (branch `ne1b` do `main` 4b17b23) + irmãs SEM mudança `ne1b\{nfse-api,setes-api}` (as cercas do núcleo leem
os repositórios vizinhos; `node_modules` delas = JUNÇÃO para as árvores vivas — sem instalar de novo).

- **Peças** (`src/pdf/`, superfície `src/pdf.ts` = subpath `fiscal-api/pdf`): `units` (`cmToPt`/`ptToCm`); `fonts` (`registerFontRoles` papel → fonte-padrão;
  `toWinAnsi` = NFC, `\n` único, tab → espaço, fora do CP1252 → `?` contado; sem `Set` em memória — a cerca do núcleo cego acusou e virou texto
  constante); `pdf-writer` (`createPdf` → `{ doc, end(sheetPass) }`: A4 ou papel em cm, margens em cm, `sheetStart` ao abrir cada folha — inclusive as
  que o pdfkit abre sozinho no transbordo —, passada por folha com `{ sheet, total }`, a passada que abre folha falha alto, fecha uma vez, `creationDate`
  fixa dá PDF reprodutível); `draw` (`drawBars` com margem clara dentro da caixa, `drawMatrix` por corridas, `drawWatermark` que preserva `doc.x/y` e
  devolve quantos viraram `?`; todos devolvem o módulo efetivo); `barcode/code128` (`code128Symbols` puro + `code128Bars`, que confere o tamanho que a lib
  devolveu); `barcode/qr` (`qrMatrix`, só ASCII imprimível, L/M/Q/H); `barcode/lib` = a ÚNICA porta do `bwip-js` (opção `raw` pela forma de texto — a
  tipagem da lib não a declara).
- **Regra do Code-128**: as 4 da NT + "grupo PAR de dígitos até o FIM volta para C" — só para reproduzir o exemplo oficial (mesmo comprimento; numa chave
  real nunca acontece: depois do CNPJ vêm 26+ dígitos).
- **Testes** (35 novos; núcleo **668** verdes, 48 suítes): oráculo Code-128 PRÓPRIO (`pdf-oracle.ts` — tabela ISO + decodificador A/B/C com DV e Stop),
  exemplo da NT símbolo a símbolo, regras 1–4 caso a caso, 3000 chaves alfanuméricas (decodifica a chave exata; o DV desenhado pela lib = o nosso;
  nunca mais símbolos que o automático da lib; cabe nas 539 posições da NT), pior caso de CNPJ com módulo ≥ 0,02 cm em 11,5 cm, 3000 textos quaisquer;
  QR lido de volta pelo jsQR nos 4 níveis; desenho remontado dos retângulos e decodificado; folha de prova com transbordo (marca d'água por baixo, "FOLHA
  i/N" por cima, 160 itens, acentos); ida e volta de TODO caractere WinAnsi nas 12 fontes; cercas `pdf-cerca.test.ts` (base cega; índice/reading/federal-id
  não alcançam `pdf/` nem as libs — também conferido em EXECUÇÃO no `dist`; bwip-js por uma porta; superfície sem a porta). Mutação conferida: DV com peso
  errado, regra 3 sem o ímpar, total errado na passada e marca d'água que move a posição — todas pegas.
- **Cerca D-CJ12** (nunca tirar dígito de inscrição/chave): o `c >= '0' && c <= '9'` do Code-128 entrou na lista branca COM motivo (escolhe o conjunto C × A;
  nada é removido — a chave inteira volta no leitor).
- **Gates**: §14.9.

### 14.9 Gates da NE-1b (2026-10-17) — 1ª rodada REPROVOU; Rodada 6 decidida; retrabalho no núcleo 3d37aea

**1ª rodada sobre 1072916** (revisores independentes; os dois gates da sessão anterior pararam com ela e foram relançados do zero):
- **Socrático 0,64 ✗** e **adversarial 0,55 ✗** — pelo MESMO **HIGH**, provado pelos dois: a marca d'água trocava fonte, corpo, cor e opacidade do
  pdfkit sem devolver (no pdfkit 0.20.2 o `save()`/`restore()` guarda só a MATRIZ) e, no `sheetStart` — que roda também nas folhas abertas sozinhas
  no transbordo —, o texto da família das folhas seguintes saía em Helvetica 50 cinza K35 translúcido (a própria folha de prova saía com 15 folhas,
  14 ilegíveis; o teste só conferia "total ≥ 3" e o texto). Com `continued`, a marca reusava o quebrador de linha VIVO da família.
- Adversarial (arquivo permanente `src/__tests__/adversarial-ne1b-gate.test.ts`, 36 ataques): MEDIUM A2 (marca com `width` quebra linha e ABRE FOLHA —
  no `sheetStart`, recursão até estourar a pilha), A3 (cor inválida ignorada em silêncio pelo pdfkit — barras na cor corrente, até branca; CMYK fora da
  faixa cru no PDF), A4 (o WinAnsi só valia para quem lembrasse do `toWinAnsi`); LOWs A5–A12b (passada assíncrona, `flushPages`, data inválida tardia,
  ângulo/caixa absurdos depois do `save()`, papel "toString", símbolos forjados, matriz/barras malformadas, `ecLevel` lido duas vezes, erro cru da lib).
  RESISTIRAM: Code-128 exaustivo nas 4.096 formas de CNPJ (decodifica, DV = o nosso, comprimento ÓTIMO A/C, pior caso 385 de 539 posições), 312 chaves
  letra × posição, 20.000 textos ótimos, barras e QR de ponta a ponta no pdfkit real, QR no limite de capacidade, 200 folhas, reentrância.
- Socrático: MEDIUM o "peer opcional" do pdfkit não vale no arranjo `file:`/`src` (quem desenha é sempre a cópia do núcleo); MEDIUM a folha de prova
  não lia barras/QR do próprio PDF; LOWs (contrato do `sheetStart` não escrito, `end()` misto síncrono × promessa, nome `{ sheet }` × `{ index }` — o
  código usa `{ sheet, total }`, 1…total, e ESTE é o registro —, o 2º exemplo da NT "123A" narrado começando em C, `code128Bars` aceitando forjados).

**Rodada 6 da `nfe-api` DECIDIDA (Valdo 2026-10-17: "Q-NE124, Q-NE125, Q-NE126 segue recomendação")** — D-NE124…D-NE126:

| Decisão | O que fixa |
|---|---|
| **D-NE124** (= Q-NE124 (b)) | pdfkit = DEPENDÊNCIA comum do núcleo, versão EXATA 0.20.2 (como o bwip-js da D-NE119) — um motor de desenho em todo ambiente; a base depende de internos dele (`pdf/state.ts`). **Revê a D-NE121** (o peer opcional saiu) |
| **D-NE125** (= Q-NE125 (a)) | contrato do `sheetStart`: roda ISOLADO — fonte, corpo, cor, opacidade, matriz e texto encadeado da família voltam; o `y` em que ele PARA fica como começo do conteúdo da folha (o cabeçalho repetido da NE-5 reserva o espaço assim); o `x` volta; papéis de fonte pela opção `fontRoles` do `createPdf`, já na 1ª folha |
| **D-NE126** (= Q-NE126 (b)) | `writeText(doc, papel, texto, opções)` = a porta de texto da família, sempre pelo `toWinAnsi`; `doc.text` direto fica FORA da garantia — a cerca que o proíbe na família nasce com o DANFE (NE-5) |

**Retrabalho (núcleo 3d37aea, branch `ne1b`)**: `pdf/state.ts` (`isolated` — guarda e devolve o estado JS do pdfkit + q/Q; conhecimento negativo dos
internos 0.20.2); todo `draw*` isolado; marca d'água em UMA linha sem `width`; `normalizeColor` (hex, black/white/gray, CMYK 0–100 arredondado a
centésimos); caixas até 14.400 pt, ângulo, matriz e barras validados ANTES do `save()`; `createPdf` com `fontRoles`, `sheetStart` isolado com o `y`
mantido, assíncronos e `flushPages` recusados, data validada — contrato de erro: **erro de USO lança na hora; o PDF vem pela promessa** (resposta ao LOW
do `end()`); `writeText`; papel com nome de propriedade do JS recusado; Code-128 com teto 128, runs lineares e `code128Bars` recusando símbolos que a
peça não produziria (máquina A/C + DV); recusa de entrada da lib → RangeError da base sem a mensagem dela; `ecLevel` lido uma vez. Testes: a folha de
prova confere o LAYOUT (total = o da mesma folha sem marca = 3), fonte/corpo/cor/opacidade de CADA trecho (só a marca a 50 pt cinza translúcido) e lê
as barras e o QR dos retângulos do PRÓPRIO PDF; contrato da D-NE125 (cabeçalho com papel na folha 1, estilo do `sheetStart` não vaza, conteúdo abaixo
do `y` reservado, `x` da margem); A1–A12b do arquivo do gate viraram verdes (A4 pela porta `writeText`). Mutação conferida: sem devolver o estado, 8
testes falham; marca de volta ao quebrador de linha, 3 falham. Núcleo **709** verdes (49 suítes); índice/reading/federal-id seguem sem carregar
pdfkit/bwip-js (conferido em execução no `dist`).

**Re-gate do delta**: §14.10.

### 14.10 Re-gate do delta 1072916..3d37aea (2026-10-17) e Rodada 7 da `nfe-api`

- **Socrático 0,72 ✅** (revisor independente; sondas só na scratchpad): o HIGH fechado nos caminhos da base (transbordo, `addPage` da família,
  `continued`, `sheetStart` que mexe no estilo); D-NE124 fecha o MEDIUM do peer. Achados NOVOS, corrigíveis sem decisão: **MEDIUM N1** barras e QR
  herdam a OPACIDADE da família (`fillColor(c)` sem opacidade não emite `gs` — código translúcido); **MEDIUM N2** `_lineGap` fora do isolamento (o
  `lineGap(8)` do `sheetStart` levou 4 folhas a 8); LOW N3 `isolated` não confere o equilíbrio do q/Q (save sem restore no `sheetStart` = q aberto
  em toda folha); LOW N4 `sheetStart` sem trava de reentrada (cabeçalho que transborda → "Maximum call stack"); LOW N5 `y` mantido não conferido
  (além do pé → 21 folhas com 1 linha fora da folha; `columns` reabre no topo — limite a escrever); LOW N6 passada por folha não isolada (texto
  encadeado do fim do conteúdo leva o "FOLHA 1/1" para fora da folha); LOW N7 `@types/pdfkit` só em dev e d.ts sem referência ao namespace `PDFKit`;
  LOW N8 comentários desatualizados (`pdf.ts` ainda fala em peer; 14400 = limite dos LEITORES de PDF, não do pdfkit; literal repetido em `fonts.ts`;
  `_strokeColor` não existe no 0.20.2). Janela: segue segura (lock só acrescenta; sem script de instalação); o `npm run build` reescreve o `dist`
  que o `tsx watch` do setes-api lê pelo link `file:` — observar o log dele (restart aceitável).
- **Rodada 7 DECIDIDA (Valdo 2026-10-17: "Q-NE127, Q-NE128, Q-NE129 segue recomendação")** — D-NE127…D-NE129:

| Decisão | O que fixa |
|---|---|
| **D-NE127** (= Q-NE127 (a)) | a base só desenha em documento que ELA criou: o `createPdf` marca o documento (SÍMBOLO privado no próprio objeto — nenhuma coleção em memória, regra do núcleo cego) e as portas que recebem documento (`drawBars`, `drawMatrix`, `drawWatermark`, `registerFontRoles`, `writeText` e a porta de medida) recusam documento sem a marca — a D-NE124 ("um motor") vale de fato |
| **D-NE128** (= Q-NE128 (a)) | a passada por folha roda ISOLADA como o `sheetStart`, por folha, sem manter nada |
| **D-NE129** (= Q-NE129 (a)) | porta de MEDIDA de texto (altura/largura) com a MESMA normalização do `writeText` — medir o texto cru e escrever o convertido daria alturas diferentes e quebraria a grade de itens do DANFE; a cerca da NE-5 na família cobre `doc.text`, `doc.list`, `doc.table`, as medidas cruas do pdfkit (`heightOfString`/`widthOfString`) e `doc.font` fora dos papéis |

- **Adversarial 0,72 ✅** (sem HIGH; arquivo permanente `src/__tests__/adversarial-ne1b-delta-gate.test.ts`, 27 ataques): A1–A12b fechados;
  MEDIUM D1 (= N2 `_lineGap`), **D2** (`writeText` com `y` e sem `x` DESCARTAVA as opções — no pdfkit 0.20.2 o `x` ausente vira o objeto de
  opções), **D3** (`save()` sem `restore()` no `sheetStart` fechava o `q` ERRADO — conteúdo vermelho translúcido, o sintoma do HIGH por outra
  porta); LOWs D4 (folha trocada no `sheetStart`), D5 (`y` não conferido), D6 (`columns` reabre a 2ª coluna no topo), D7 (cabeçalho herdava o
  corpo da família), D8 (= N6), D9 (thenable recusado não observado → `unhandledRejection`), D10 (CMYK com buraco), D11 (ângulo gigante),
  D12 (opções do `writeText` sem conferência), D13 (ano > 9999), D14 (`writeText` aceitava papel do registro do PDFKIT — `doc.registerFont`
  com Symbol). RESISTIRAM: `sheetStart` que lança no meio, estado sem `save`, encadeado nos dois sentidos, marca nos extremos, cores no limite,
  3.000 textos Code-128 de 21–120, QR acima da capacidade sem eco, reprodutibilidade com tudo, `state.ts` fora da superfície.
- **Rodada 7 EXECUTADA — núcleo 756d244** (branch `ne1b`): `pdf/base-document.ts` (D-NE127: marca por símbolo + registro de papéis DA BASE; as
  seis portas recusam documento alheio — D14 fechado); `state.ts` (`_lineGap`; q/Q conferido e CORRIGIDO + erro de uso; folha trocada volta +
  erro de uso; `neutral`; o erro de quem rodou nunca é trocado pelo de uso); `pdf-writer.ts` (`sheetStart` com estado de entrada NEUTRO — preto
  opaco, corpo 12, espaçamento 0, o cabeçalho sai igual em toda folha —, trava de reentrada, `y` finito/na folha/com lugar para 1 linha;
  passada por folha ISOLADA e neutra — D-NE128; thenable recusado e OBSERVADO; ano 0–9999); `draw.ts` (cor E opacidade afirmadas — N1;
  CMYK por índice; ângulo módulo 360 — D11 vira aceito, o ataque verde já exigia 1e300); `fonts.ts` (lista FECHADA de opções do texto —
  `columns` fora = LIMITE CONHECIDO, a NE-5 decide; só-`y` usa o `x` corrente; `measureText` — D-NE129); `@types/pdfkit` dependência exata e
  `/// <reference types="pdfkit" preserve="true" />` (o TypeScript 5.9 só mantém a diretiva no `.d.ts` com `preserve`); comentários corrigidos
  (N8; `MAX_COORDINATE_PT` em `units`). Oráculo: `pdfContentOps` anota a opacidade REAL de cada ExtGState (o `gs` de opacidade 1 que a base
  emite para afirmar o desenho opaco não é "translúcido"). Mutação conferida (sem `_lineGap`, passada sem neutro, `drawBars` sem marca, barras
  sem opacidade — todas pegas). Núcleo **739** verdes (50 suítes); isolamento do índice/reading/federal-id conferido em execução.
- **Gates do delta 3d37aea..756d244**: §14.11.

### 14.11 Gates do delta 3d37aea..756d244, Rodada 8 da `nfe-api` e as duas últimas levas (2026-10-17)

- **Socrático 0,76 ✅** — N1/N2-D1/D2/D3 fechados. Novos: MEDIUM **S1** (o `writeText` CONFERIA o papel no registro da base mas DESENHAVA pela
  resolução do pdfkit pelo nome — `doc.registerFont` direto ainda punha Symbol); LOWs S2 (restore a mais), S3 (neutro parcial — face da fonte, posição
  da passada, traço; o recorte herdado não se desfaz), S4 (medida sem `width` dependia do `x` do momento), S5 (marca pela cadeia de protótipo), S6
  (depois de erro no `sheetStart`, o `end()` culpava o flushPages). Janela segura (o `npm ci` dos consumidores não quebra — link `file:`; a diretiva de
  tipos sobrevive no `.d.ts`).
- **Adversarial 0,74 ✅** (sem HIGH; arquivo permanente `adversarial-ne1b-r7-gate.test.ts`, 30 ataques): **MEDIUM R7-M1** (`restore()` a mais no
  `sheetStart`/passada passava CALADO — corpo vermelho a 30 % girado 90° em toda folha; `restore(); save()` equilibrava a contagem), **MEDIUM R7-M2**
  (`lineBreak:false` com `width` — a célula alinhada do DANFE — quebrava a linha e abria folha); LOWs R7-L1 (= S1), L2 (`wordSpacing` apaga quebras de
  linha; `characterSpacing` duplicado no sublinhado), L3 (escritor travado depois de `sheetStart` que abre folha; `save()` noutra folha), L4 (recorte
  atravessando a quebra deixa o "Folha n/N" invisível), L5 (getters lidos várias vezes), L6 (espaçamento negativo leva o texto para fora da folha),
  L7 (depois de `lineBreak:false` o `x` ficava no fim — coluna de rótulos em escada), L8 (`sheetStart` que não é função).
- **Leva sem decisão — núcleo 23dee91**: `restore()` a mais BARRADO NA HORA (guarda que substitui o `restore` da instância durante o `isolated`, antes
  de emitir o `Q` — acusar depois não desfazia o vazamento) + identidade da entrada do `save()`; desenho e medida pela fonte do REGISTRO DA BASE;
  estado neutro = folha nova (Helvetica 12, preto opaco, traço 1 pt contínuo) e a passada entra nas margens; `measureText` com `x`; marca só como
  propriedade PRÓPRIA; `sheetStart` que abre folha deixa o documento INVÁLIDO e o `end()` diz a causa; `save()` noutra folha fecha lá;
  `wordSpacing`/`characterSpacing` FORA da lista (defeitos do pdfkit — o DANFE não precisa); espaçamentos só positivos e `lineGap` > 0; opções/estilos
  lidos uma vez; `sheetStart` tem de ser função.
- **Rodada 8 DECIDIDA (Valdo 2026-10-17: "Q-NE130 a Q-NE134 segue recomendação")** — executada no núcleo 428e282:

| Decisão | O que fixa |
|---|---|
| **D-NE130** (= Q-NE130 (a)) | texto GIRADO (canhoto vertical do DANFE paisagem, MOC 3.8.2) = LIMITE CONHECIDO: sem `rotation` na porta; a família gira o DOCUMENTO em volta do `writeText` — caminho que a cerca da NE-5 permite |
| **D-NE131** (= Q-NE131 (a)) | um papel, UMA fonte no documento: religar com OUTRA fonte é recusado (a grade medida não muda no meio); com a mesma, inofensivo; lote inválido não registra nada |
| **D-NE132** (= Q-NE132 (a)) | `lineBreak: false` COM `width` = LINHA ÚNICA: a base mede, alinha (left/center/right) e escreve uma linha; não cabe = RangeError legível (a família mede antes e abrevia/reduz); sem `\n` nem continued/height/ellipsis/indent/gaps nessa forma |
| **D-NE133** (= Q-NE133 (a)) | depois de toda escrita de linha única (`lineBreak: false`, com ou sem `width`) o `x` volta para onde ela COMEÇOU |
| **D-NE134** (= Q-NE134 (a)) | `save()` da família aberto na abertura de uma folha (o `addPage` do pdfkit reinicia a matriz mas NÃO a pilha) = erro de uso legível |

- Testes: os achados viraram verdes nos arquivos permanentes (M1 com recusa NA HORA e PDF limpo; M2/L4/L7 pelas decisões); testes positivos da linha
  única (posições exatas) e do papel único. Mutação conferida (guarda do restore; D-NE131…D-NE134). Núcleo **771** verdes (51 suítes).
- **Gate rápido do delta 756d244..428e282**: §14.12.

### 14.12 Gate rápido do delta 756d244..428e282 e Rodada 9 da `nfe-api` (2026-10-17)

- **Socrático 0,74 ✅** (sondas na scratchpad): guarda do `restore()` segura (aninhada, erro dentro, documento reutilizado — o método próprio sai
  em todo caminho; ressalva só para espião de teste instalado DURANTE o isolado); D-NE131/`measureText` com `x` OK; D-NE134 sem falso positivo.
  **MEDIUM M1**: a linha única (D-NE132) com uma cadeia `continued` ABERTA — o pdfkit funde `width`/`align` da cadeia e reusa o quebrador de linha
  (célula fora do lugar; perto do pé, abre folha). LOWs: L1 (o nome da FONTE-PADRÃO ainda passa pelo registro/cache do pdfkit —
  `doc.registerFont('Times-Roman','Symbol')`), L2 (erro de uso de dentro do `pageAdded` que não invalida o documento — D-NE134 e o fecho do R7-L3b),
  L3 (`save()`+recorte aberto no FIM do conteúdo deixa o "Folha n/N" invisível), L4 (D-NE133 × trechos seguidos na mesma linha com `lineBreak:false`
  sem `x` — sobrepostos), L5 (espaços no fim contam na medida/alinhamento da linha única), L6 (dentro da rotação da D-NE130 o quebrador confere o
  `y` girado contra o pé da folha — só a linha única é segura girada).
- **Rodada 9 DECIDIDA (Valdo 2026-10-17: "Q-NE135, Q-NE136, Q-NE137 segue recomendação")**:

| Decisão | O que fixa |
|---|---|
| **D-NE135** (= Q-NE135 (a)) | linha única pedida com texto encadeado (`continued`) ABERTO = erro de uso legível ("feche o texto encadeado antes") |
| **D-NE136** (= Q-NE136 (a)) | `continued` junto com `lineBreak: false` (com ou sem `width`) é RECUSADO; para juntar trechos na mesma linha a família usa `x` explícito pelo `measureText` ou `continued` com `width` |
| **D-NE137** (= Q-NE137 (a)) | na linha única, os espaços do FIM não contam: a base mede, alinha e desenha o texto sem eles (como o pdfkit faz no alinhamento à direita) |

- **Adversarial do delta 0,76 ✅** (sem HIGH; arquivo permanente `src/__tests__/adversarial-ne1b-final-gate.test.ts`). **MEDIUM F-M1** = o M1 do
  socrático provado no PDF: com um encadeado aberto, a célula de linha única sai em 3 linhas com o número partido (F-M1a) e, perto do pé, abre
  folha (F-M1b). LOWs: F-L1 (`{lineBreak:false, continued:true}` sem largura aceito, mas a D-NE133 joga o `continued` fora — o trecho seguinte cai
  POR CIMA), F-L2 (= L1 do socrático: `registerFont('Times-Roman','Symbol')` põe a Symbol na porta do WinAnsi), F-L3 (o erro da D-NE134 deixava
  folha ÓRFÃ, sem o sheetStart, e o documento ainda fechava), F-L4 (a guarda do `restore()` contava a pilha do JS, não a da FOLHA: `save()` noutra
  folha + `restore()` nesta fechava o `q` do isolamento sem erro), F-L5 (`measureText` com `x` além da margem direita: a medida dizia N linhas e o
  `writeText` empilhava todas no mesmo `y`), F-L6 (texto posto EXATAMENTE no pé pela medida: o pdfkit abre folha antes — arredondamento float32 do
  `maxY`). Resistiram: guarda do `restore()` aninhada/reentrante/com espião do jest, linha única nos limites (tolerância 1e-6), D-NE134 sem falso
  positivo, D-NE131 em lote misto, reprodutibilidade byte a byte.
- **Leva executada (núcleo c99309e, branch `ne1b`, LOCAL)**: D-NE135/D-NE136 no `writeText` (F-M1 e F-L1 fechados pela recusa); D-NE137 (aparar
  antes de medir/alinhar/desenhar); `assertStandardFontIntact` em `fontOfRole` e no `drawWatermark` (F-L2/L1); `broken` também para a D-NE134 — o
  `end()` recusa com a causa e o documento não fecha (F-L3/L2); `end()` recusa `save()` aberto no fim do conteúdo (L3); `isolated` guarda a FOLHA de
  cada `save()`, barra `restore()` noutra folha NA HORA e, na limpeza, fecha cada `save()` extra na folha em que abriu chamando a função ORIGINAL
  (`GUARD`/`rawOf` — F-L4); `writeText`/`measureText` sem largura útil = recusa legível (F-L5); F-L6 e L6 = LIMITES CONHECIDOS documentados no
  código (F-L6 segue `it.failing` rotulado). Núcleo **790** verdes (52 suítes); mutação conferida (D-NE135/136/137 e guarda por folha).
- **Gate curto do delta 428e282..c99309e**: §14.13 (Rodada 10 — Q-NE138…Q-NE143 aguardam o Valdo; janela parada).

### 14.13 Gate curto do delta 428e282..c99309e e Rodada 10 da `nfe-api` (2026-10-17)

- **Socrático 0,72 ✅** (no piso). **Achado 1 (MEDIUM-baixo, REGRESSÃO do delta)**: o `save()` de ENTRADA de um isolado aninhado passava pela guarda
  do de fora e ficava para sempre na lista de folhas dele — `save()` na folha 2 + desenho da base na folha 1 + volta + `restore()` na 2 era acusado
  como "noutra folha"; sem o `restore()`, a limpeza fechava o `q` da folha 2 na folha 1 (PDF desbalanceado que ainda fechava). Achado 2 (LOW): 4
  proteções sem teste que as pegue (recusa do `end()` com `save()` aberto, F-L2 na marca, limpeza por folha do F-L4, F-L5 da medida) e 6 testes do
  final-gate aceitando qualquer `RangeError`. Achado 3 (LOW): `measureText` sem `width` depende do `x` corrente. Achado 4 (LOW): a D-NE137 só na
  escrita — a medida mede os espaços do fim (D-NE129 deixa de valer) e o NBSP não é aparado. Achado 5 (LOW): o comentário do `state.ts` dizia que o
  recorte "só vive dentro de save()" — falso (`clip()` fora de `save()` recorta o "Folha n/N"). Achado 6 (informativo): `continued: false` explícito
  recusado; F-L6 + `broken` = bloco recortado no pé exato deixa o documento sem conserto.
- **Adversarial 0,80 ✅** (sem HIGH; arquivo permanente `src/__tests__/adversarial-ne1b-r9-gate.test.ts`, 32 ataques). LOWs: R9-L1 (TOCTOU — a
  conferência da fonte rodava ANTES de ler opções/texto/cor: getter/`toString` sobrepunha a fonte depois), R9-L2 (fonte EMBUTIDA com nome
  PostScript de fonte-padrão passava — o `Times.ttc` do macOS), R9-L3 (NBSP do fim não aparado — o pdfkit, que a D-NE137 cita, apara `\s`), R9-L4
  (poda `/ +$/` quadrática), R9-L5 (= achado 1 do socrático), R9-L6 (`save()` numa folha + `restore()` noutra no nível de cima zera a pilha: o
  `end()` aceita e o "Folha n/N" sai recortado), R9-L7 (CMYK lido 5 vezes por elemento). Resistiram: D-NE135/136 sem rastro, D-NE137 com
  tab/mistura/500 espaços, `broken` da D-NE134, `end()` com recorte aberto, guarda por folha sem aninhamento, F-L5 nos limites.
- **Leva executada (núcleo 623a2a7, branch `ne1b`, LOCAL)**: achado 1/R9-L5 — guardas, entrada, saída e limpeza pela função ORIGINAL (`rawOf`):
  cada isolado conta só os `save()` da família feitos sob a guarda DELE; R9-L1 — `useStandardFont` confere no próprio `doc.font` (as 3 portas);
  R9-L2 — a conferência exige o PROTÓTIPO da fonte-padrão do pdfkit (tirado da Helvetica de abertura, guardado na marca do documento); R9-L4 — poda
  linear (só U+0020 até a Q-NE141); R9-L7 — CMYK lido uma vez; achado 2 — os testes casam a mensagem de cada decisão e as 4 mutações são
  detectadas; achados 3 e 5 — documentados no código. R9-L3 e R9-L6 seguem `it.failing` (dependem da Rodada 10). Núcleo **822** verdes (53 suítes).
- **⚠️ JANELA D-NE123 PARADA** — a Rodada 10 abaixo aguarda o Valdo (regra do pedido: achado que exige decisão para antes da janela).

#### 14.13.1 Rodada 10 da `nfe-api` — questões para o Valdo (recomendação entre parênteses)

| Questão | O quê | Opções |
|---|---|---|
| **Q-NE138** (adversarial Q-NE138 + socrático Q1) | Trocar de folha com `save()` da família aberto (fecha R9-L6 na raiz) | (a) erro de uso: no nível de cima, `switchToPage` com `save()` aberto é recusado (extensão da D-NE134); dentro do `sheetStart` e da passada, trocar de folha é proibido de vez — guarda que barra na hora, e o controle de folha por `save()` do isolado sai (simplifica); voltar a uma folha anterior SEM `save()` aberto (preencher totais depois do transbordo) segue livre · (b) manter a troca e registrar o R9-L6 como limite conhecido — **(a)** |
| **Q-NE139** (adversarial) | Linha única só de espaços com sublinhado/riscado não desenha nada (o traço de "ABC   " cobre só "ABC") | (a) manter — linha de preenchimento é desenho vetorial da família; já fixado por teste · (b) recusar sublinhado/riscado quando a linha aparada fica vazia — **(a)** |
| **Q-NE140** (socrático Q2) | F-L6 + `broken`: bloco recortado posto EXATAMENTE em `pé − altura medida` deixa o documento sem conserto (o `end()` recusa) | (a) a base compensa o arredondamento float32 do pdfkit na escrita (~1e-4 pt) — a promessa da medida passa a valer · (b) limite documentado + regra de folga na cerca da NE-5 — **(a)** |
| **Q-NE141** (socrático Q3 + adversarial R9-L3 — os revisores divergem no NBSP) | A D-NE137 também na MEDIDA, e quais "espaços" | (a) a medida também apara os espaços do fim de cada linha, e "espaço" = U+0020 e NBSP U+00A0 nos dois (como o pdfkit faz — a letra da D-NE137) · (b) os dois aparam só U+0020; NBSP no fim é intencional, documentado · (c) a medida não muda — **(a)** |
| **Q-NE142** (socrático Q4) | `clip()` FORA de `save()`/`restore()` recorta o "Folha n/N" e a base não desfaz | (a) entra na cerca da NE-5 (lista da D-NE129): `clip` só com `save()` aberto · (b) só o limite documentado (já no código) — **(a)** |
| **Q-NE143** (socrático achado 6) | `continued: false` explícito junto de `lineBreak: false` é recusado (letra da D-NE136) — montador genérico de opções tropeça | (a) aceitar `false` (é o padrão); a D-NE136 recusa só `continued: true` · (b) manter a recusa de qualquer valor — **(a)** |

Depois das decisões: executar → gate curto do delta → JANELA D-NE123 (`merge --ff-only` + `npm install` + `npm run build` no núcleo vivo + push; sem restart).

#### 14.13.2 Rodada 10 DECIDIDA (Valdo 2026-10-17: "Q-NE138 a Q-NE143 segue recomendação") e EXECUTADA

| Decisão | O que fixa |
|---|---|
| **D-NE138** (= Q-NE138 (a)) | No nível de cima, `switchToPage` com `save()` da família aberto = erro de uso legível ANTES de trocar (guarda instalada pelo `createPdf` — extensão da D-NE134); dentro do `sheetStart` e da passada (todo `isolated`) trocar de folha é barrado NA HORA; o controle de folha por `save()` (`savedOn` — F-L4/R9-L5) SAIU; voltar a uma folha anterior SEM `save()` aberto (totais depois do transbordo) segue livre |
| **D-NE139** (= Q-NE139 (a)) | Linha única que fica vazia depois de aparada não desenha nada, nem sublinhado/riscado — a linha de preenchimento é desenho vetorial da família (só documentado; o teste já fixava) |
| **D-NE140** (= Q-NE140 (a)) | A base compensa o arredondamento float32 do pdfkit na ENTRADA do bloco (`fitFloat32` no `writeText`): 1ª linha que cabe no pé EXATO e não no arredondado — o `y` sobe < 1e-4 pt; o que não cabe de verdade segue com o pdfkit; fora do encadeado aberto. CONHECIMENTO NEGATIVO (sonda na execução): com `height` o pdfkit NÃO perde a linha (a conferência só avança a coluna) — não há o que compensar; o ramo que eu tinha escrito para isso saiu (a mutação sobreviveu e a sonda mostrou por quê) |
| **D-NE141** (= Q-NE141 (a)) | "Espaço do fim" = U+0020 e NBSP U+00A0, na linha única E na `width` da medida (por linha) |
| **D-NE142** (= Q-NE142 (a)) | `clip()` só com `save()` aberto entra na cerca da NE-5 (lista da D-NE129 — com `doc.text` cru e `doc.font` fora dos papéis); hoje: limite documentado no `state.ts` |
| **D-NE143** (= Q-NE143 (a)) | `continued: false` (o padrão) passa com `lineBreak: false`; a D-NE136 recusa só `continued: true` |

- **Consequência vista na execução (sem nova decisão — o gate revisa)**: com a D-NE141 a `width` de "CNPJ: " sai SEM o espaço e medir um espaço
  sozinho dá 0 — o caminho que a própria D-NE136 indica ("junte trechos com x pelo measureText") colaria o número no rótulo. O `measureText` passou a
  devolver também **`advance`** (a mesma medida COM os espaços do fim = o quanto o `x` anda para o próximo trecho); a mensagem da D-NE136 diz "x pelo
  advance do measureText". As duas decisões seguem valendo.
- Testes: `src/__tests__/pdf-rodada10.test.ts` (positivos de cada decisão, no PDF real — D-NE140 em 4 corpos no pé exato com recorte aberto); R9-L3, R9-L6 e F-L6 viraram `it`; os testes que trocavam de folha dentro do `sheetStart` passaram a esperar a recusa da D-NE138.
  Mutação conferida: cada decisão (D-NE138 nos dois níveis, D-NE140, D-NE141 NBSP e medida, `advance`, D-NE143) derruba testes. Núcleo **833**
  verdes (54 suítes).

### 14.14 Gate curto do delta c99309e..2e16ea6 e Rodada 11 da `nfe-api` (2026-10-18)

- **Socrático 0,68 ❌** (reprovou por pouco) · **Adversarial 0,74 ✅** (sem HIGH; arquivo permanente `src/__tests__/adversarial-ne1b-r10-gate.test.ts`,
  23 ataques). O MESMO MEDIUM pelos dois lados (**socrático M1 = R10-M1**): o `fitFloat32` tratava `y + lh > pé` como "não cabe de verdade" sem
  folga, mas a altura que a medida devolve é `(y + lh) − y` em float64 e erra 1 a 3 ulps — ~5 % dos corpos do DANFE (Times-Bold 8/8,5, Courier 8…),
  com a medida feita onde o conteúdo parou, ainda abriam folha, e com o recorte aberto o documento não fechava (a D-NE140 cumprida só em parte; o
  teste dos 4 corpos media no `y` onde o erro quase não aparece). LOWs sem decisão: socrático L2 (guarda do `save()` virou código morto), L4 = R10-L2
  (espião/embrulho sem a marca no `switchToPage` escondia a original do `rawOf` — a volta à folha tropeçava na D-NE138), L5 (testes aceitando
  qualquer `RangeError` / asserções condicionais / título que dizia "fecha" sem fechar). LOWs que pedem decisão: socrático L1 (`advance` = linha mais
  larga, não a última), socrático L3 (`sheetStart` barrado no meio do transbordo deixa meia folha e o documento ainda fecha), R10-L1 (texto VAZIO
  mede 0 e, posto no pé, abre folha vazia), R10-L3 (`lineBreak: false` sem `width` com `\n`: o pdfkit cola as linhas na mesma linha de base e o
  `advance` não descreve a escrita). Resistiram: D-NE138 nos dois níveis (passada e `sheetStart` legítimos intactos; `addPage`/`continueOnNewPage`
  crus caem na D-NE134), `rawOf` aninhado com erro no meio, D-NE140 fora do R10-M1 (sobe < 1e-4 pt no A4/Ofício II; 1e-6 pt além do pé vai para a
  folha seguinte), D-NE141, D-NE143, R9-L1/R9-L2.
- **Leva executada (núcleo a180971, branch `ne1b`, LOCAL)**: R10-M1 — "cabe no pé exato" com folga RELATIVA de 2^-40 × pé (~7e-10 pt no A4; o que
  passa 1e-6 pt segue para a folha seguinte); R10-L2 — a volta à folha do isolado pelo `switchToPage` do PRÓPRIO pdfkit (protótipo); L2 — guarda
  morta fora; L5 — testes casam a mensagem; a D-NE140 provada por VARREDURA (3 fontes × corpos 5–12 × cursor da medida no topo/meio/baixo × 2
  margens, recorte aberto, documento fechado); mutações conferidas (sem a folga a varredura falha; sem a volta pela original, 2 do R10 falham).
  Núcleo **854** verdes (55 suítes). R10-L1 e R10-L3 seguem `it.failing` até a Rodada 11.
- **⚠️ JANELA D-NE123 PARADA** — Rodada 11 abaixo aguarda o Valdo.

#### 14.14.1 Rodada 11 da `nfe-api` — questões para o Valdo (recomendação entre parênteses)

| Questão | O quê | Opções |
|---|---|---|
| **Q-NE144** (socrático L3) | O `sheetStart` que FALHA (D-NE138, erro da própria família, `y` fora da área útil) no meio de um transbordo deixa a folha com meio cabeçalho; o erro escapa pelo `writeText` do conteúdo (pode ser engolido) e o documento ainda fecha | (a) toda falha do `sheetStart` deixa o documento INVÁLIDO (`broken` — como a D-NE134/F-L3): o `end()` recusa dizendo a causa · (b) manter: só folha órfã invalida — **(a)** |
| **Q-NE145** (socrático L1 — ratifica o `advance` da consequência da D-NE141) | O `advance` devolve o avanço da linha MAIS LARGA — num texto de 2 linhas o próximo trecho entra no fim da última | (a) manter o `advance`, definido como o avanço da ÚLTIMA linha (sem quebra; com `width` que quebra, documentado que não se aplica) · (b) manter como está (linha mais larga), só documentar · (c) tirar o `advance` (a família soma o espaço) — **(a)** |
| **Q-NE146** (adversarial Q-NE150 — R10-L3) | `lineBreak: false` SEM `width` com `\n`: o pdfkit escreve as linhas uma depois da outra na MESMA linha de base | (a) recusar `\n` em toda escrita `lineBreak: false` (estende a D-NE132 — a linha única já recusa); o `advance` vale sempre para uma linha · (b) trocar `\n` por espaço (como a marca d'água) · (c) manter e documentar — **(a)** |
| **Q-NE147** (adversarial Q-NE151 — R10-L1) | Texto VAZIO mede altura 0, mas posto no pé (`pé − 0`) o pdfkit abre folha vazia; com o recorte aberto a D-NE134 recusa (campo opcional vazio, p.ex. infCpl, num bloco ancorado no rodapé) | (a) `writeText` de texto vazio sem `continued` não chama o pdfkit (é o que a medida 0 promete) · (b) a medida do vazio passa a ser uma linha · (c) limite documentado — **(a)** |

Depois das decisões: executar → gate curto do delta → JANELA D-NE123.

#### 14.14.2 Rodada 11 DECIDIDA (Valdo 2026-10-18: "Q-NE144 a Q-NE147 segue recomendação") e EXECUTADA (núcleo 15f3373, LOCAL)

| Decisão | O que fixa |
|---|---|
| **D-NE144** (= Q-NE144 (a)) | TODA falha do `sheetStart` (erro da família, erro de uso da base, `y` fora da área útil) deixa o documento INVÁLIDO: o erro sobe na hora e o `end()` recusa sempre, com a causa em TEXTO FIXO da base ("o sheetStart falhou (a folha ficou sem o cabeçalho inteiro — D-NE144)") — nunca a mensagem de quem falhou (sem eco de dado) |
| **D-NE145** (= Q-NE145 (a)) | `advance` RATIFICADO = o avanço da ÚLTIMA linha com os espaços do fim (onde o próximo trecho entra); com `width` que quebra o texto, não se aplica (documentado) |
| **D-NE146** (= Q-NE146 (a)) | Toda escrita `lineBreak: false` (com ou sem `width`) recusa quebra de linha — o pdfkit, sem quebrador, cola as linhas na mesma linha de base |
| **D-NE147** (= Q-NE147 (a)) | `writeText` de texto VAZIO sem `continued` (e sem cadeia aberta) não chama o pdfkit — nada escrito, nenhuma folha nova (a medida 0 vale); `x`/`y` ficam como informados; com a cadeia aberta o vazio a FECHA (vai ao pdfkit) |

- Consequência nos testes: os que fechavam o documento depois de uma falha do `sheetStart` (R7, R9, R10, final, delta, rodada10) passaram a esperar a
  recusa da D-NE144 — e o equilíbrio q/Q por folha continua conferido no conteúdo VIVO (oráculo `liveContentOps`/`qDepth`: o pdfkit guarda o conteúdo
  da folha sem comprimir em `page.content.buffer` até o `end()`, com a opacidade anotada como no `pdfContentOps`). Positivos em
  `src/__tests__/pdf-rodada11.test.ts`; R10-L1/R10-L3 viraram `it`; mutação de cada decisão detectada. Núcleo **863** verdes (56 suítes).
- **Gate curto do delta 2e16ea6..15f3373**: §14.15.

### 14.15 Gate curto do delta 2e16ea6..15f3373 e Rodada 12 da `nfe-api` (2026-10-18)

- **Socrático 0,80 ✅** (sem HIGH/MEDIUM, nenhuma questão; sondas por PROPRIEDADE: 1.500 casos aleatórios de medida → escrita em `pé − altura` com
  recorte aberto, zero falha; sem a folga de 2^-40 a sonda reprova; a D-NE147 deixa `x`/`y` idênticos ao pdfkit cru com texto vazio; o conteúdo vivo
  = o PDF final byte a byte). LOWs: L1 (asserções que ficaram VAZIAS nos testes adaptados à D-NE144 — "palavra" na folha 2 nunca existe), L2
  (`RangeError` genérico no R10-L3), L3 (`liveContentOps` falhava ABERTO depois do `end()`), L4 (sobra morta), L5 (o JSDoc público não dizia D-NE138/
  D-NE144/D-NE146/D-NE147 nem o limite do `advance` com quebra pela largura que sobra/`indent`). Nota para a NE-5: um `doc.on('pageAdded')` da família
  desenharia fora do contrato do `sheetStart` (sem isolamento, D-NE134, D-NE144) — candidato à lista da cerca (D-NE129/D-NE142).
- **Adversarial 0,82 ✅** (sem HIGH; arquivo permanente `src/__tests__/adversarial-ne1b-r11-gate.test.ts`, 27 ataques). LOWs: R11-L1 (pede decisão —
  abaixo), R11-L2 ("lugar para 1 linha" depois do `sheetStart` sem folga: o cabeçalho medido para terminar em `pé − 1 linha` passava por 1e-13 pt e,
  pela D-NE144, invalidava o documento — ~28 % de 252 combinações), R11-L3 (a mensagem imediata repetia a 1ª causa guardada), R11-L4 (conferência do
  `y` fora do trecho que invalida — acessor que lança escapava), R11-L5 (o oráculo vivo anotava a opacidade sem o arredondamento do PDF final).
  Resistiram: `fitFloat32` em 864 combinações (até 14.400 pt, margem 0, corpo 1000, `y` negativo), D-NE144 sem falso positivo (medida, marca,
  barras, QR, linha única e vazio dentro do `sheetStart`) e sem falso negativo (`throw` de string/null/undefined/objeto sem protótipo/thenable
  quebrado — a causa nunca ecoa), D-NE145, D-NE146 (U+2028/U+2029/NEL/VT/FF viram `?`), D-NE147, volta pelo protótipo sob espiões.
- **Leva executada (núcleo 877402f, branch `ne1b`, LOCAL)**: R11-L2 — folga relativa de 2^-40 também no "lugar para 1 linha"; R11-L3 — a mensagem
  da PRÓPRIA causa; R11-L4 — o `y` lido uma vez dentro do trecho que invalida; R11-L5/socrático L3 — o oráculo vivo arredonda como o PDF e falha
  FECHADO sem a matriz-base; socrático L1/L2 — asserções vazias e genéricas endurecidas; L4/L5 — sobra morta fora e o contrato público com as
  decisões. Mutações conferidas (R11-L2, L3, L4 detectadas). Núcleo **890** verdes (57 suítes). R11-L1 segue `it.failing`.
- **⚠️ JANELA D-NE123 PARADA** — Rodada 12 abaixo aguarda o Valdo.

#### 14.15.1 Rodada 12 da `nfe-api` — questão para o Valdo (recomendação entre parênteses)

| Questão | O quê | Opções |
|---|---|---|
| **Q-NE152** (adversarial R11-L1) | O texto VAZIO que fecha uma cadeia aberta (D-NE147 manda ao pdfkit) não avança o `y`: o pdfkit deixa o `y` no topo da linha encadeada — "INF. COMPL.: " encadeado + campo opcional vazio + o próximo bloco só com `x` sai POR CIMA do rótulo; e uma cadeia de 7 pt no pé fechada com vazio de outro papel em 12 pt abre folha VAZIA | (a) a base fecha a cadeia ela mesma no vazio, deixando `x`/`y` onde o fechamento com texto deixaria (sem chamar o pdfkit) · (b) recusar o vazio com cadeia aberta (a família fecha com texto ou não encadeia quando o campo é vazio) · (c) limite conhecido documentado — **(a)** |

Depois da decisão: executar → gate curto do delta → JANELA D-NE123.

#### 14.15.2 Rodada 12 DECIDIDA (Valdo 2026-10-18: "Q-NE152 segue recomendação") e EXECUTADA

| Decisão | O que fixa |
|---|---|
| **D-NE152** (= Q-NE152 (a)) | O texto VAZIO sem `continued` com a cadeia ABERTA é fechado pela BASE, sem chamar o pdfkit: `x` no início da cadeia; `y` uma linha abaixo da linha encadeada — altura da linha na fonte/corpo do fechamento + `lineGap` + `paragraphGap`, as opções da cadeia valendo onde o fechamento não diz (como o `_initOptions` do pdfkit); nenhuma folha abre |

- Testes: paridade "fechar com vazio" × "fechar com texto" em 16 combinações (opções da cadeia × papel/corpo/gaps do fechamento) no `pdf-rodada11`;
  R11-L1a/b viraram `it`; mutação detectada (ramo desligado, sem `lineGap`, sem `paragraphGap`). Núcleo **907** verdes (57 suítes).
- **Gate curto do delta 15f3373..HEAD**: §14.16.

### 14.16 Gate curto do delta 15f3373..f2ca95a (2026-10-18) — em curso na hora da janela

- Socrático e adversarial disparados sobre o delta (877402f + f2ca95a). O Valdo mandou seguir a janela ("segue D-NE123") com os gates no ar: o
  subpath `fiscal-api/pdf` não tem consumidor em produção — achado que vier entra numa publicação seguinte (fast-forward de novo). Resultado: §14.18.

### 14.17 JANELA D-NE123 EXECUTADA e PUBLICADA (2026-10-18 — Valdo: "segue D-NE123")

1. Conferido antes: `D:\Gestao2027\fiscal-api` limpo, no `main` 4b17b23 = `origin/main`, ancestral do `ne1b` (12 commits); fora de `src/pdf` e dos
   testes o delta só ACRESCENTA (`package.json`, `package-lock.json`, `src/pdf.ts`). `dist` antigo guardado em `scratchpad\janela-ne1b\dist-4b17b23`.
2. `git merge --ff-only ne1b` → f2ca95a; `npm install` (NUNCA `npm ci`) — entraram SÓ `pdfkit 0.20.2`, `bwip-js 4.11.4`, `@types/pdfkit 0.17.6` (e
   `jsqr 1.4.0` de teste); as demais dependências nas MESMAS versões; o lock não mudou; `npm run build`.
3. Prova DE DENTRO do setes-api (pelo `dist`, link `file:`): `fiscal-api`, `fiscal-api/reading` e `fiscal-api/federal-id` NÃO carregam pdfkit/bwip-js;
   `fiscal-api/pdf` exporta as peças e gera um PDF real (`createPdf` + `writeText` + `code128Bars` + `drawBars` → `%PDF-1.3`).
4. Suíte na árvore viva: 1 falha AMBIENTAL — a asserção da 1ª linha do `src/pdf.ts` quebrava só por `\n` e o checkout do Windows (`core.autocrlf`)
   grava CRLF (no worktree os arquivos estavam em LF) → corrigida no `ne1b` (4110957, `split(/\r?\n/)`) e o `main` vivo avançou de novo por fast-forward;
   **57 suítes / 907 verdes** na árvore viva. CONHECIMENTO NEGATIVO: teste que lê fonte do repositório quebra por linha com `/\r?\n/`.
5. **Push**: `valdosouza/gestao-2027-fiscal-api` `main` 4b17b23..**4110957**. Sem restart (D-NE123).
6. ⚠️ Achado de ambiente (fora da janela): na hora da janela NADA escutava nas portas 3000 (setes-api), 3002 (nfse-api) e 5051 (app) — as abas do
   Terminal de produção da sessão de 2026-10-17 ("nfse-api producao", "setes-app web 5051") não existiam mais (o app reiniciou); os serviços já
   estavam fora do ar ANTES do merge. Não subidos por conta própria (subir = deploy) — fica com o Valdo.

### 14.18 Resultado do gate do delta 15f3373..f2ca95a (2026-10-18 — rodou junto da janela) e Rodada 13 da `nfe-api`

- **Adversarial 0,84 ✅** (sem HIGH; arquivo permanente `src/__tests__/adversarial-ne1b-r12-gate.test.ts`, 43 ataques — paridade da D-NE152 com `===`
  em 23 casos: cadeia de várias linhas, `indent`, `align`, `x`/`y` explícitos, outro papel/corpo, `lineGap` do documento, `height`, cadeia crua
  girada/em colunas, transbordo, `sheetStart`; o pdfkit não emite nada no fechamento com texto que a base deixe de fazer). LOWs: R12-L1 (com
  `paragraphGap` a base somava de uma vez — 1 ulp de diferença), R12-L2 (o vazio com `continued: true` ainda abre folha no pé — pede decisão), R12-L3
  (o oráculo vivo devolvia `[]` depois do `end()`/`flushPages` — falhava aberto).
- **Socrático 0,74 ✅** (18 cenários sondados contra o pdfkit fechando com "X" — `x`/`y` iguais). **M1 (MEDIUM, pede decisão)**: trecho VAZIO com
  `continued: true` e a cadeia ABERTA vai ao pdfkit, cujo `_initOptions` copia o `textWidth` velho do `_textOptions` — o `continuedX` soma de novo a
  largura do trecho anterior: "Endereço: " + complemento vazio + "Rua…" sai com a rua deslocada (avanço do rótulo dobrado; dois vazios = triplicado);
  no pé, com corpo maior, abre folha. Caminho da D-NE136 (`continued` com `width`) com dado plausível. L1 (3 mutações do ramo da D-NE152 passavam —
  a paridade nunca exercitava `y` explícito, `lineGap` do documento, cadeia de várias linhas, `x` mexido), L2 (= R12-L1), INFO (comentário da folga).
- **Leva executada (núcleo c01496c, branch `ne1b`, LOCAL — NÃO publicada)**: R12-L1/L2 — soma na ORDEM do pdfkit (igual bit a bit); L1 — paridade
  EXATA nos casos que faltavam (as 3 mutações detectadas); R12-L3 — o oráculo falha fechado sem folhas ou com folhas despejadas; comentário. Núcleo
  **954** verdes (58 suítes). R12-L2 segue `it.failing`.
- **Publicação**: esta leva + a Rodada 13 vão numa 2ª janela (fast-forward do `main` vivo + build + push), depois do gate curto — o subpath
  `fiscal-api/pdf` não tem consumidor em produção.

#### 14.18.1 Rodada 13 da `nfe-api` — questão para o Valdo (recomendação entre parênteses)

| Questão | O quê | Opções |
|---|---|---|
| **Q-NE153** (socrático M1 + adversarial R12-L2 — a mesma família: o trecho VAZIO com `continued: true`) | Com a cadeia ABERTA: o pdfkit repete o avanço do trecho anterior (texto seguinte deslocado em silêncio) e, no pé com corpo maior, abre folha. SEM cadeia (vazio que ABRIRIA a cadeia): no pé abre folha só com o cabeçalho | (a) a base não chama o pdfkit para o vazio `continued: true`: com a cadeia ABERTA a cadeia segue IGUAL (o vazio não soma nada — sem avanço fantasma, sem folha); SEM cadeia, é RECUSADO com erro de uso legível ("abra a cadeia com o 1º trecho que tem texto") · (b) recusar SEMPRE o vazio com `continued: true` (a família pula o campo vazio) · (c) limite conhecido documentado — **(a)** (fecha o MEDIUM com exatidão, sem imitar o pdfkit para abrir cadeia; muda o positivo do `pdf-rodada11` que hoje fixa "vazio `continued: true` abre cadeia") |

#### 14.18.2 Rodada 13 DECIDIDA (Valdo 2026-10-18: "pode seguir com a recomendação") e EXECUTADA (núcleo, branch `ne1b`, LOCAL)

| Decisão | O que fixa |
|---|---|
| **D-NE153** (= Q-NE153 (a)) | O trecho VAZIO com `continued: true` não vai ao pdfkit: com a cadeia ABERTA a cadeia segue IGUAL (o vazio não soma nada — no pdfkit o `_initOptions` copiava o `textWidth` velho e o trecho seguinte saía deslocado pela largura do anterior; num corpo maior no pé, abria folha); SEM cadeia, é RECUSADO com erro de uso legível ("abra a cadeia com o 1º trecho que tem texto") |

- Testes (`pdf-rodada11`): "Endereço: " + um ou dois vazios (outro papel/corpo) + "Rua…" = o documento SEM o vazio (posições no PDF); "Rua " + vazio +
  "das Flores"; vazio de corpo maior no meio da cadeia no pé sem folha; R12-L2a/b viraram `it`; os testes que abriam cadeia com vazio esperam a recusa;
  mutação dos dois ramos detectada. Núcleo **957** verdes (58 suítes).
- **Gate curto do delta 4110957..HEAD (c01496c + Rodada 13)** e depois a 2ª janela (fast-forward + build + push): §14.19.

### 14.19 Gate curto do delta 4110957..f71c802 (c01496c + Rodada 13) e Rodada 14 da `nfe-api` (2026-10-18)

- **Socrático 0,80 ✅** (no-op da D-NE153 exato — toda validação roda ANTES; ordem das recusas: D-NE136 vence a D-NE153, a D-NE153 vence a F-L5;
  mutações: 4 de 5 detectadas). **L1 (LOW, consequência → Q-NE157)**: o vazio do MEIO da cadeia descarta as PRÓPRIAS opções (`x`/`y`, corpo,
  `lineGap`, `align`…) — o mesmo trecho com texto as passaria à cadeia; o leiaute do RESTO da cadeia depende de o campo vir vazio ("Endereço: " a
  6 pt + meio a 12 pt + "Rua" sem corpo: a rua sai a 6 pt com o meio vazio e a 12 pt com "Apto 1 "; `lineGap: 10` no meio: 14 × 24 pt por linha).
  L2 (nenhum teste fixava o descarte — o r13 do adversarial passou a fixar), **L3 (para a NE-2/NE-3, sem decisão): a recusa da D-NE153 sem cadeia é
  disparada por DADO — a bateria da família do DANFE ganha um fixture com TODOS os opcionais vazios**, L4 (complexidade: "cadeia aberta" escrita de
  5 formas no `writeText`; o despacho do vazio partido antes/depois da fonte — PENDENTE, sem mexer antes da janela), INFO (textos desatualizados).
- **Adversarial 0,86 ✅** (sem HIGH; arquivo permanente `src/__tests__/adversarial-ne1b-r13-gate.test.ts`, 142 ataques — o no-op mantém os MESMOS
  objetos do quebrador (identidade), byte a byte igual ao gêmeo sem o vazio em cadeia no pé/transbordada/justify/height/crua/`sheetStart`/passada;
  recusa sem rastro em todos os textos vazios × opções × estados; 16 combinações de recusas na regra certa; 800 paridades sorteadas da D-NE152 por
  `===`). LOW R13-L1 (oráculo do PDF FINAL: um PNG com " re " nos bytes virava folha — o logotipo da NE-5).
- **Leva executada (núcleo, branch `ne1b`, LOCAL)**: R13-L1 — o oráculo pula fluxo de IMAGEM/XObject (`isImageStream`); INFO — comentário e textos
  dos testes. Núcleo **1099** verdes (59 suítes).

#### 14.19.1 Rodada 14 da `nfe-api` — questão para o Valdo (recomendação entre parênteses)

| Questão | O quê | Opções |
|---|---|---|
| **Q-NE157** (socrático L1 — ratificação de consequência da D-NE153) | O trecho VAZIO do MEIO da cadeia descarta as próprias opções e o corpo; com texto no lugar, elas passariam ao resto da cadeia — o leiaute do resto muda conforme o dado | (a) MANTER pela letra da D-NE153 + conhecimento negativo no comentário do `writeText` + teste que fixa o descarte (já no r13) + REGRA para a NE-2/NE-3: corpo e opções de leiaute em CADA trecho com texto, nunca herdados de um trecho do meio que pode vir vazio · (b) o vazio do meio aplica o que dura (fonte/corpo, opções na cadeia sem o `textWidth`, `x`/`y`) como trecho de largura zero · (c) recusar o vazio do meio que traga opção além de `continued` — **(a)** (não muda código de produção; os dois revisores sugerem que não segure a 2ª janela — o subpath não tem consumidor em produção) |

#### 14.19.2 Rodada 14 DECIDIDA (Valdo 2026-10-18: "Q-NE157 segue recomendação")

| Decisão | O que fixa |
|---|---|
| **D-NE157** (= Q-NE157 (a)) | MANTIDO pela letra da D-NE153: o vazio do MEIO da cadeia descarta as próprias opções e o corpo. Conhecimento negativo no comentário do `writeText`; o descarte fixado no `adversarial-ne1b-r13-gate`. **REGRA da família (NE-2/NE-3): cada trecho com texto diz o seu corpo e as suas opções de leiaute — nunca herdados de um trecho do meio que pode vir vazio**; e a bateria do DANFE ganha um fixture com TODOS os opcionais vazios (socrático L3). Sem mudança de código de produção (núcleo abce0b8). |

### 14.20 2ª JANELA EXECUTADA e PUBLICADA (2026-10-18)

- Núcleo vivo: limpo em 4110957 = `origin/main`; `merge --ff-only ne1b` (4 commits — c01496c, f71c802, 0c5ae84, abce0b8; fora dos testes só
  `src/pdf/fonts.ts` e `pdf-writer.ts`); `npm install` = "up to date" (nenhuma dependência mudou); build; **59 suítes / 1099 verdes NA ÁRVORE VIVA**;
  prova de dentro do setes-api (portas antigas não carregam pdfkit/bwip-js; "Endereço: " + vazio + "Rua das Flores" gera o PDF pelo `dist`).
- **Push**: `gestao-2027-fiscal-api` `main` 4110957..**abce0b8**. Sem restart. Pendências que ficam: socrático L4 (complexidade do `writeText` — "cadeia
  aberta" escrita de 5 formas; despacho do vazio partido) para quando a NE-5 mexer na porta; os serviços de produção fora do ar ficam com a sessão
  própria do Valdo. **NE-1b FECHADA. ⏯ Próximo: NE-2/NE-3.**

## 15. NE-2 — Rodada 0 (2026-10-18): esqueleto da nfe-api + DDL da família + leitura publicada (NE-3 à vista)

> Valdo (2026-10-18): "retomar §14.20; o próximo passo é a NE-2/NE-3". Este bloco NÃO decide: organiza o escopo da NE-2, registra o inventário
> (caminho:linha, conferido no disco), integra o parecer do guardião (agente `setes-conceito`) sobre o que a NE-2 ACRESCENTA ao DDL já revisado na
> NE-0 (E4 — `prompt_onda_nfe_sefaz-ddl-ne2-rascunho.sql` v1.1) e numera as escolhas (Q-NE158…) com recomendação. A NE-3 entra só como VISTA —
> o que ela herda e o que a Rodada 0 dela vai pedir —, porque depende do que a NE-2 fixar (escopo da NF-e — memória da NE-1b: nada de NFS-e aqui).
> Nenhum código, nenhum DDL executado, nenhum download.

### 15.1 Lugar no calendário e natureza

- Ordem (D-NE55 + §12.3): NE-1a ✅ → F2a/F2b ✅ → NE-0 ✅ → NE-1b ✅ (18/10) → **NE-2** (2–4 sessões) → **NE-3** (5–7) → NE-6 → NE-4 → NE-5 → NE-7.
  Nada disso disputa o caminho crítico de 01/01/2027: a IB-4 espera o fisco de H e a Q-IB1 (30/10) é decisão de negócio.
- É a 1ª vez que `D:\Gestao2027\nfe-api` ganha `src/` e `package.json` — a D-NE1 libera a NE-0…NE-3; o `nfe-api/CLAUDE.md` ainda diz "Não crie
  `src/` nem `package.json` aqui" (texto de 2026-10-03) e é corrigido junto com a execução.
- Ambiente: NADA está em produção (Valdo, 18/10 — memória `nada-em-producao`); a disciplina de deploy segue: o núcleo é deploy no restart de quem o
  consome (D-F133), a nfse-api roda `tsx` sem watch, o setes-api `tsx watch`. Hoje NADA escuta em 3000/3002/3003 (só a MariaDB :3306 e o app :5051).
- Fato que a NE-3 leva em conta: pela NT 2026.007 a SVRS autoriza o emitente SEM IE em H a partir de **26/10/2026** (D-NE95) — mas a autorização
  pede o builder (NE-4) e o grupo IBSCBS; antes disso a prova em H com o A1 da Setes é status, consulta e inutilização (D-NE18 + §13.9 "Ajustes").

### 15.2 Fatos do inventário (2026-10-18)

1. **O núcleo já recebe a 2ª família sem reforma**: `defineVoiceFamily` (`fiscal-api/src/voice/event-table.ts:71` — escritor único genérico pela lista
   de escrita da família), `VoiceFamilyReading` (`voice/reading.ts:86` — inclusive `humanEffectCancel`, que a NF-e "define na NE-2"), o catálogo
   `ISSUER_MODEL_FACTS` (`establishment/issuer-models.ts` — 55/65 → `merchandise`, `erpTransmitted=false`), `countLiveTransmissions`
   (`emitter/emitter.ts:90` — percorre o catálogo; família não instalada = 0 legítimo, D-NE76) e `writeIssuer` com `serie: null` (a coluna `serie` da
   habilitação é só da SE — `migrations/sql/001_core_baseline.sql`).
2. **O catálogo `VOICE_READINGS` é lido no BOOT de dois serviços e cercado no ERP**: a nfse-api confere a view de CADA família do catálogo
   (`nfse-api/src/server.ts:21` — `assertFamilyViewsReadable(ctx.pool, ctx.fiscalDb)`, padrão = catálogo inteiro — `fiscal-api/src/voice/family-reader.ts:58`);
   o setes-api idem (`setes-api/src/shared/fiscal-voice/fiscal-voice.ts:130`) e tem a cerca `KNOWN_FAMILIES = ['service']`
   (`setes-api/src/shared/invoice/invoice-fiscal-effect.ts:27` + `src/__tests__/f2a-a3-voz.test.ts:82-84`: família nova no catálogo = revisão
   OBRIGATÓRIA do plano de cancelamento). O núcleo fixa o catálogo em testes (`ne1a-leitura.test.ts:83`, `adversarial-ne1a-gate.test.ts:378`).
   ⇒ pôr `merchandise` no catálogo é uma JANELA TRANSVERSAL (núcleo + nfe-api + nfse-api + setes-api): a migration 001 da nfe-api aplicada no
   `fiscal_api` e o GRANT da view ao `setes_api` ANTES de a nfse-api e o setes-api reiniciarem com o núcleo novo. A D-F113 ("o boot confere toda
   família do catálogo") e a D-NE76 ("nenhum serviço condiciona o boot às migrations de OUTRA família") se tocam aqui → Q-NE158.
3. **Transporte sem teto de corpo**: `httpsRequest` (`fiscal-api/src/transport/https-json.ts:69-103`) junta o corpo inteiro em memória. A D-NE93
   (2 MB, recusa = ambíguo) mora aqui e vale para as DUAS famílias — a NFS-e muda de comportamento no restart que levar o núcleo novo → Q-NE164.
4. **DDL em rascunho v1.1**: 3 tabelas (`tb_invoice_merchandise_transmission`, `…_transmission_event`, `tb_invoice_number_void`) + 3 views, 15 CHECKs
   NOMEADOS; o §5 do rascunho já lista o que a NE-2 faz em código (sondas do boot pelo nome da constraint, GRANT, prova da coluna gerada STORED com
   UNIQUE, EXPLAIN das três views, `MERCHANDISE_VOICE_WRITE_KINDS` = A R D P C K F N = CHECK).
5. **Banco do dev = MariaDB 10.4.20** (XAMPP, serviço `mysql`, :3306); **não há MySQL 8 na máquina nem Docker**. A D-NE109 manda provar a coluna
   gerada "no MariaDB 10.4 e no MySQL 8 na NE-2". O MySQL 8 avalia `REGEXP` por ICU (a MariaDB por PCRE) e exige GRANT extra para `FOR UPDATE`
   (`nfse-api/ops/grants.sql`, seção 1): a dúvida vale para TODO CHECK com REGEXP do `fiscal_api` (núcleo 001–005, nfse-api 001–007), não só para a
   001 da nfe-api → Q-NE165.
6. **Molde do esqueleto = nfse-api**: `src/{app,server,context,health,cors-origins}.ts`, `migrations/index.ts` (núcleo primeiro, depois a família;
   namespace por projeto — D-F35), `modules/emitter` (emitter do núcleo montado para a família — D-NE9; a borda recusa o modelo que não é da API),
   `nfse/voice-family.ts` (descritor + sondas do boot), `ops/grants.sql` (seção 2 já prevê "família nova = a view de tentativas DELA"),
   `scripts/{migrate,mint-dev-token,explain-leituras}.ts`, OpenAPI servido em `/docs` e `/v1/openapi.yaml`, `package.json` com `fiscal-api: file:../fiscal-api`.
7. **Contrato `nfe-api/openapi/nfe-api.v1.yaml`** (15 rotas): sem o adaptador (NE-3) e o builder (NE-4) a NE-2 consegue servir só `GET /v1/health`
   (sem o bloco `authorities` — `consStatServ` é NE-3) e o emitente (`GET /v1/emitter`, `PUT|DELETE /v1/emitter/certificate`,
   `PUT|DELETE /v1/emitter/issuers/55`) → Q-NE166.
8. **Correção sem decisão**: o contrato diz que a lista de pendentes exclui a última voz "S" (`nfe-api.v1.yaml:170`) — a D-NE107 tirou a S da
   família; sai na execução.
9. **Achado alheio (não tocado)**: `nfse-api/package.json` com alteração NÃO commitada — campos `main`/`keywords`/`author`/`license` de um `npm init`
   (outra sessão). Fica para o Valdo.
10. **Repos**: núcleo `main` abce0b8 = `origin`; worktrees vivas `cnpj`, `ib3`, `ne1b` (a `ne1b` = `main`, removível — as irmãs `ne1b\nfse-api` e
    `ne1b\setes-api` têm `node_modules` em JUNÇÃO para as árvores vivas: tirar só a junção); nfe-api `main` a9ef9ac = `origin` (só `openapi/`,
    `CLAUDE.md`, `README.md`).
11. **Herdados do §13.4, com casa**: NE-2 → D-NE56 (registro = protocolo na view, COLLATE bin), D-NE61 (teste: toda voz D publicada sai registrada),
    domínio do `kind` pela lista da família (D-F107/D-F108 + D-NE107), `voiceView` sem peça de leitura (L5 da NE-1a), família no catálogo (Q-NE158),
    D-NE93 (Q-NE164), D-NE82 (c) em pauta (Q-NE167) · NE-3 → XSW no `verifyXml` (quem valida XML do fisco lê do nó ASSINADO), leitura por nó-escopo
    (D-NE86), Q-NE38 timeouts · NE-6 → voz D no plano de cancelamento da conjugada, série do 55 só leitura no ERP, "No fisco" na tela de pedidos,
    numeração × inutilização (D-NE8/D-NE110) · NE-7 → `app/shared/fiscal` (2º consumidor).

### 15.3 Parecer do guardião (agente `setes-conceito`, 2026-10-18 — integrado; citações conferidas no disco pelo condutor)

**Conceito**: na NE-2 a família NF-e ganha FORMA no `fiscal_api` (tabelas, CHECKs, descritor de escrita, leitura pronta); PUBLICAR (catálogo,
superfície `fiscal-api/reading`, GRANT) é ato separado e nasce com o 1º leitor. Peças reusadas: `defineVoiceFamily`, `VoiceFamilyReading`/
`mapCommonView`, `countLiveTransmissions` + `familyInstalled` (D-NE76), `assertCheckRefuses`, `ISSUER_MODEL_FACTS`, o calendário datado da
nfse-api. Peça nova: só a leitura das faixas retiradas (e só na NE-6).

**Achado de fundo — "instalada" tem dois sentidos**: D-F113 = está no CATÁLOGO da versão da biblioteca (escrita para o boot do setes-api —
`prompt_apis_fiscais_isoladas.md:841`); D-NE76 = a view/tabela EXISTE no banco. O boot da nfse-api já mistura os dois (`nfse-api/src/server.ts:21`
usa o padrão "catálogo inteiro" — `family-reader.ts:59`): com UMA família não aparece; com duas, a nfse-api passaria a depender da migration da
nfe-api para subir.

1. **Entrada no catálogo** — três consumidores com prazos diferentes: o emitter do núcleo (`emitter.ts:90-116`) precisa da família ANTES da 1ª
   tentativa de NF-e existir (senão o DELETE do A1 pela nfse-api ignoraria uma NF-e viva — `emitter.ts:202-213`, o furo que a NE-1a fechou); o boot
   da nfse-api violaria a D-NE76; o setes-api segue a D-F113 + a cerca `KNOWN_FAMILIES` e NÃO pode usar a detecção da D-NE76 (com GRANT só nas
   views, GRANT faltando parece "não instalada" e falha ABERTO — `prompt_apis_fiscais_isoladas.md:3226`). **Fato gerador** = a 1ª tentativa possível
   ou o 1º leitor no ERP, o que vier antes = **NE-6** (vem antes da NE-4/NE-5). **Maquete na entrada já**: a cerca `KNOWN_FAMILIES` só passaria
   puxando o plano de cancelamento da NE-6 para agora ou listando a família sem decidir o plano (contornar a cerca) — e seria janela transversal para
   uma família VAZIA. Construções que acompanham a espera: `assertFamilyViewsReadable` sem valor padrão (cada chamador diz o que confere — setes-api
   o catálogo, nfse-api a de serviço, nfe-api a de mercadoria) e, como verificação da NE-5, a nfe-api não monta a reserva sem a família no catálogo
   (a frase "ramo sem leitura = família sem tentativa possível", `emitter.ts:85`, fica verdadeira por construção). Até lá a leitura fica só no barrel
   `fiscal-api` (a cerca `ne1a-superficie.test.ts` obriga a decidir a entrada em `fiscal-api/reading`).
2. **`humanEffectCancel`** — o fato gerador do efeito humano é cancelamento cujo efeito o ERP não decide sozinho (NFS-e: 105102 substituição com
   substituta desconhecida, 305101 de ofício — `families/service.ts:20-29`). Na F4 não existe: a voz C da NF-e só aceita 110111 (rascunho `:130-132`)
   = pedido do emitente, efeito automático, também quando veio do portal/outro sistema com o mesmo A1 (molde do 101101 por consulta). `() => false` +
   conhecimento negativo + teste. NÃO criar conjunto vazio "para a F5" (o 110112 da NFC-e é substituição do próprio PDV, que conhece a substituta —
   copiar "substituição = humano" da NFS-e seria maquete). O predicado é por família e não decide a conjugada (D-NE22) — o plano da NE-6 compõe.
3. **Colunas publicadas** — confirmado: própria só `dh_emission` (D-NE21); `protocol` interno (o ERP da NE-6 lê o registro e a identidade na projeção
   comum — `authority_recorded`, `access_key` via `fiscalRecordKey`, `invoice-fiscal-effect.ts:48-54`; o 110111 é montado pela nfe-api com a tabela
   dela; o número da nota é do ERP — D-F21; protocolo publicado só com leitor, p.ex. livro fiscal/SPED). **`model`** (deixado para a NE-2 pelo
   emitter — `emitter.ts:32-33`): na F4 só existe o 55 (65 = F5, D-NE2) — o sobre-bloqueio 55↔65 não tem objeto; na F5 sai da chave (pos. 21–22) e,
   se o emitter filtrar por modelo, vira coluna da PROJEÇÃO COMUM (a NFS-e publica 'SE'). **View de vozes sem leitor**: a 4.2 do rascunho e o campo
   `voiceView` (`reading.ts:91`) não têm consumidor em família nenhuma (só o teste `descritor-ddl`); a tela "No fisco" lê as próprias tabelas
   (`nfse-api/ops/grants.sql:33`) — contrato publicado sem consumidor (o L5 da NE-1a).
4. **Faixas retiradas** — a leitura mora no NÚCLEO (o setes-api não tem SQL próprio no `fiscal_api` — `fiscal-voice.ts:17-19`, D-F33/D-NE77; ler direto
   do ERP é a (c) que a Q-IB78 rejeitou), NÃO no `VOICE_READINGS` (o catálogo é de famílias de TRANSMISSÃO — o emitter e o boot o percorrem; faixa ali
   seria tentativa falsa): peça própria `fiscal-api/src/numbering/`. O leitor recebe OBRIGATORIAMENTE o ambiente (institution × modelo × série ×
   ambiente — faixa inutilizada em H não retira número de P). A view nasce na 001 (já desenhada e revisada; o §5 do rascunho exige o EXPLAIN); leitor,
   superfície e GRANT com o 1º leitor (NE-6) — publicar é GRANT + superfície, não a view existir (a D-IB78 adiou a view porque lá era desenho novo).
   A coluna `authority_recorded` da view de faixas (rascunho `:247`) não tem leitor (o ERP pula pendente e homologada igual — D-NE110) e esticaria
   "registro" (palavra ocupada) para a inutilização. Limite conhecido: inutilização pendente não conta como viva no DELETE do A1 (`emitter.ts:208-221`)
   — falha FECHADO (a faixa fica retirada até o A1 voltar).
5. **Autorizadores** — moram na nfe-api (`src/authority/authorizers.ts` — a D-NE5 põe SOAP e cStat na família; o núcleo só conhece 'SEFAZ' pelo
   modelo, `issuer-models.ts:34-38`; o ERP nunca fala com o fisco). Forma = constante versionada (D-NE3), NUNCA dado recarregável: a cadeia ICP muda
   sem aviso (D-NE54 (a)); a rota muda por NT/Ajuste com data. Acréscimos: dois grãos (UF: rota por modelo/ambiente/tpEmis/IE/serviço, prazo de
   cancelamento, serviço oferecido · autorizador: URL por serviço × ambiente, parâmetros do 656); entradas DATADAS (`validFrom`) avaliadas no instante
   da reserva (sem IE → SVRS em H 26/10 e P 16/11; AC/BA/SP sem inutilização desde 01/11 — molde do calendário por pacote da nfse-api); a tentativa
   congela o CÓDIGO (D-NE37), a URL é resolvida na chamada (URL nova = build, nunca migration); CHECKs do autorizador = domínio dos códigos com teste
   contra a constante (molde `ISSUER_MODELS` × CHECK); o JSON do acervo é EVIDÊNCIA ("não é código") — teste de proveniência contra uma cópia com o
   SHA-256. Nasce na NE-3.
6. **Maquete / grão errado**: (1) **DEFEITO REAL no DDL** — a UNIQUE da faixa (`uk_invoice_number_void_withdrawn`, rascunho `:167`) não tem o ambiente;
   o Id de 43 não leva tpAmb e H/P são bases separadas da SEFAZ ⇒ faixa inutilizada em H bloquearia a mesma faixa em P para sempre (*duplicate key*);
   o grão da retirada é (ambiente, faixa) e a linha já tem `environment` congelado. (2) Mesmo erro no nome do arquivo: `<Id43>-inut.xml` (D-NE50) tem o
   grão da FAIXA e a linha o do PEDIDO — o 2º pedido da faixa no mesmo ambiente sobrescreve o arquivo do 1º. (3) GRANT nas três views (§5 do rascunho)
   contradiz o GRANT mínimo (`grants.sql:29-37`) — correção sem decisão. (4) NÃO fazer tabela de cStat nem de autorizadores (veto de
   `issuer-models.ts:9-10`: tabela-catálogo lida antes da trava recria o retrato; o mapa cStat→kind é regra de leitura da família, versionada com a NT).
   (5) Sem coluna de status nem cópia de fato do ERP (série/número/modelo da chave ou do Id; IE no XML — D-NE105). (6) Não reabrir: `authority_code`
   com três sentidos por kind (cStat · tpEvento · código da falha) — já decidido (D-F68/D-NE106), tipado por CHECK por kind (`:125-132`); 135 × 155
   fica no XML do evento. (7) Não é maquete: pedido e resposta da inutilização na mesma linha (resposta única, sem consulta — D-NE40); se o rodízio da
   NE-5 reenviar pendentes, a linha ganha `last_sent_at` (agrega).

### 15.4 Escopo proposto da NE-2 (entregáveis — executam depois das decisões)

| # | Entregável | Onde | Fecha |
|---|---|---|---|
| E1 | **esqueleto** no molde da nfse-api: `package.json` (`fiscal-api: file:../fiscal-api`; dependência NOVA com versão EXATA — D-NE124), `tsconfig*`, `src/{app,server,context,health,cors-origins}.ts`, `migrations/index.ts` (núcleo → `nfe-api`), `modules/emitter` (habilita só o 55, só com o ambiente — a série é do ERP, D-F21/D-NE11; SE e 65 = 422 `FISCAL_MODEL_NOT_SUPPORTED`), `scripts/{migrate,mint-dev-token,explain-leituras}.ts`, OpenAPI servido + teste rota × contrato; porta 3003 | `nfe-api` | D-NE1 · D-NE9 · D-F8 · D-F13 |
| E2 | **migration `001`** da família = rascunho v1.1 com as Q-NE160 (sem a view 4.2), Q-NE161 (view de faixas sem `authority_recorded`) e Q-NE163 (UNIQUE com o ambiente) e NOVA passada do `revisar-ddl`; provada antes num banco DESCARTÁVEL `fiscal_api_adv_ne2` (o GRANT `fiscal\_api\_adv%` já existe — D-F53): cada CHECK pela sonda de NOME, coluna gerada STORED + UNIQUE, EXPLAIN das três views, `SET NAMES utf8mb4 COLLATE <x>` em ≥ 2 colações, re-execução idempotente | `nfe-api/src/migrations/sql` | D-NE105…D-NE109 · D-NE114 · D-NE56 |
| E3 | **família**: `MERCHANDISE_VOICE_WRITE_KINDS` (A R D P C K F N — sem S, D-NE107) + `MERCHANDISE_VOICE_FAMILY` (`defineVoiceFamily`) + sondas do boot (`assertMerchandiseVoiceDomainsEnforced` — lista do §5 do rascunho); cerca da família por AST (escritor único nas tabelas da família; `defineVoiceFamily` só no descritor — D-NE82 (a)); testemunhas `@ts-expect-error` de S presas ao escritor que a máquina chama (§12.8 item 3) | `nfe-api/src/nfe/voice-family.ts` + `__tests__` | D-F107/D-F108 · D-NE107 |
| E4 | **núcleo** (worktree — deploy no restart, D-F133): leitura publicada `voice/families/merchandise.ts` (views, colunas próprias, mapa com os invariantes D-NE61/D-F136/D-F154, `humanEffectCancel` pela Q-NE159) — entrada no catálogo pela Q-NE158 (a peça `numbering/` das faixas só com o leitor — Q-NE161); o teto de 2 MB vai à NE-3 se a Q-NE164 for (b) | `fiscal-api/src/voice/families/` · `transport/` | D-NE56/D-NE61 · D-NE93 |
| E5 | **permissões**: `nfe-api/ops/grants.sql` (mesmo usuário `fiscal_api` — `nfse-api/ops/grants.sql` seção 1 já diz "nfse-api hoje; nfe-api amanhã"); GRANT da view de tentativas ao `setes_api` só quando houver leitor (Q-NE158) | `nfe-api/ops` | D-F15 · D-F31 |
| E6 | gates (socrático ≥ 0,70 + adversarial sem HIGH) e a publicação (Q-NE168) | — | gate de entrega |

### 15.5 A NE-3 à vista (não decide — o que a Rodada 0 dela vai pedir)

- **Entrega** (§12.3): adaptador SEFAZ — envelope SOAP 1.2 mínimo sem Header; 1 NF-e por lote síncrono (D-NE33; 452 desde 13/10/2025); 1 evento por
  envio (D-NE39/D-NE106); parser do núcleo (`xml/reader.ts` — D-NE85…D-NE90) com a resposta conferida contra a pergunta (D-NE42); timeouts por serviço
  (D-NE38: ≥ 15 s antes do recibo, status ≥ 3 min); Fault/500 classificados (D-NE34); 106 (D-NE108); `authorizers.ts` com a dimensão serviço/evento a
  partir do DADO já arquivado (`AUTORIZADORES.md` + `autorizadores-2026-10-15.json` — D-NE3/D-NE37/D-NE96); XSD de toda mensagem pela sobreposição
  PL_009_V4 → PL_010d → PL_010f (D-NE115); smoke H parcial com o A1 da Setes.
- **Vai pedir decisão** (prévia, sem número): (1) a LIB do validador XSD (o Node não valida XSD sozinho: nativa × WASM × Java — dependência nova,
  versão exata); (2) `action` × `SOAPAction` — NÃO confirmado (o WSDL só abre com mTLS: o 1º passo da NE-3 é ler o WSDL com o A1); (3) XSW — o nó
  lido tem de ser o nó ASSINADO (`fiscal-api/src/transport/xmldsig.ts:74` `verifyXml`); (4) a casa do transporte SOAP (núcleo, ao lado do
  `https-json`, × família); (5) o roteiro do smoke H (no PR: status e consulta protocolo passam, consulta cadastro → 257, inutilização → 203 — §13.9) —
  sem gravar no `fiscal_api` real; (6) a cadeia ICP do servidor como DADO recarregável (D-NE54 (a) — formato e lugar; hoje a Raiz v10 valida PR e SVRS).

### 15.6 ⚠️ Rodada 15 da `nfe-api` — questões para o Valdo (recomendação entre parênteses)

**A. Do parecer do guardião (§15.3)**

| Questão | O quê | Opções |
|---|---|---|
| **Q-NE158** | Quando a leitura `merchandise` entra no catálogo `VOICE_READINGS` (fato 2 do §15.2; parecer 1) | (a) já na NE-2 — janela TRANSVERSAL: 001 da nfe-api aplicada + GRANT ao `setes_api` antes de reiniciar nfse-api e setes-api, e o plano de cancelamento/`KNOWN_FAMILIES` decididos agora · (b) **a leitura nasce no núcleo na NE-2 FORA do catálogo e fora de `fiscal-api/reading` (só no barrel); a nfe-api confere as próprias views passando a leitura; entrada no catálogo + superfície + GRANT na janela da NE-6, antes da 1ª tentativa; junto: `assertFamilyViewsReadable` sem valor padrão (cada chamador passa o que confere) e, como verificação da NE-5, a nfe-api não monta a reserva sem a família no catálogo** · (c) como (b) sem as duas construções (ordem só pelo calendário) — **(b)** *(nota do condutor: o "sem valor padrão" toca nfse-api e setes-api; sem mudança de comportamento enquanto o catálogo tiver só `service` — pode ir na janela da NE-6, quando os dois reiniciam de qualquer jeito; a cerca `ne1a-leitura.test.ts:83` quebra quando o catálogo crescer e aponta para cá)* |
| **Q-NE159** | `humanEffectCancel` da NF-e (parecer 2) | (a) **`() => false` + conhecimento negativo (o 110111 é sempre do emitente, efeito automático, mesmo vindo de outro sistema; o 110112 da F5 decide o dele) + teste que fixa** · (b) conjunto vazio de códigos no molde da NFS-e · (c) voz C chegada por consulta sem K nosso = efeito humano — **(a)** |
| **Q-NE160** | O que a família publica (parecer 3) | (a) **própria só `dh_emission`; `protocol`/`authorizer`/`receipt`/`dh_recbto`/`digest_value` internos até haver leitor; sem `model` até a F5 (sai da chave; vai à projeção COMUM se o emitter filtrar por modelo); `voiceView` sai do contrato publicado (`reading.ts:91`) e a view 4.2 não nasce; a view de vozes da NFS-e fica, sem DROP** · (b) como (a), mantendo `voiceView` e a 4.2 por simetria (L5 como limite) · (c) publicar `protocol` e `model` já — **(a)** |
| **Q-NE161** | Leitura das faixas retiradas da numeração (parecer 4) | (a) **peça própria no núcleo (`numbering/`, fora do `VOICE_READINGS`), em `fiscal-api/reading` com o 1º leitor (NE-6) e o GRANT; leitor escopado por institution × modelo × série × AMBIENTE; a view nasce na 001 (NE-2), sem `authority_recorded`** · (b) como (a), mas a view também só na NE-6 (D-IB78 ao pé da letra) · (c) SQL próprio do setes-api sobre a view (fere D-F33/D-NE77) — **(a)** |
| **Q-NE162** | Autorizadores (parecer 5) | (a) **`nfe-api/src/authority/authorizers.ts`, constante versionada (D-NE3) com os dois grãos (UF × autorizador) e entradas DATADAS avaliadas no instante da reserva; a tentativa congela o código, a URL se resolve na chamada; CHECKs = domínio dos códigos com teste contra a constante + teste de proveniência pelo SHA-256 do JSON do acervo; nasce na NE-3** · (b) no núcleo · (c) dado recarregável sem build, como a cadeia ICP — **(a)** |
| **Q-NE163** | Grão da faixa retirada — **defeito real do rascunho** (parecer 6.1/6.2; refina a D-NE109 e a D-NE50) | (a) **UNIQUE `(environment, withdrawn_void_id)`; arquiva-se só a PROVA (`ProcInutNFe` do 102/563 — uma por faixa retirada por construção) com o nome da D-NE50** · (b) UNIQUE com o ambiente e o `id` da linha no nome do arquivo (arquiva também os rejeitados) · (c) manter (a faixa de H bloqueia a de P) — **(a)** |

**B. Do condutor (fatos 3, 5, 7, 10 e 11 do §15.2)**

| Questão | O quê | Opções |
|---|---|---|
| **Q-NE164** | Quando executa o teto de 2 MB da resposta do fisco (D-NE93 dizia "na NE-2, junto do SOAP" — mas o §12.3 pôs o envelope SOAP na NE-3; o teto mora no `httpsRequest` COMUM e muda também a NFS-e) | (a) na NE-2, no `httpsRequest` comum · (b) **na NE-3, no `httpsRequest` comum, junto do transporte SOAP (corrige só o QUANDO da D-NE93; vale para as duas famílias; a recusa = ambíguo pela causa que já existe; entra nos gates da NE-3 com a NFS-e no escopo)** · (c) só no transporte SOAP (a NFS-e fica sem teto) — **(b)** — a NE-2 não tem transporte; o teto junto do SOAP é a mesma revisão de código |
| **Q-NE165** | Prova no MySQL 8 (D-NE109 manda provar a coluna gerada "no MariaDB 10.4 e no MySQL 8 na NE-2"; não há MySQL 8 na máquina; REGEXP por ICU × PCRE e o GRANT do `FOR UPDATE` valem para TODO o `fiscal_api`) | (a) baixar o MySQL 8.0 LTS (zip sem instalador, ≈ 250 MB, dev.mysql.com — download pede o teu "sim"), subir numa porta só para a prova, provar a 001 da nfe-api E o `fiscal_api` inteiro (núcleo 001–005, nfse-api 001–007), apagar depois · (b) **NE-2 prova no MariaDB 10.4; a prova em MySQL 8 vira PRÉ-CONDIÇÃO da F3 para o `fiscal_api` inteiro, quando a SaveInCloud disser motor e versão (corrige o QUANDO da D-NE109)** · (c) não provar — **(b)** — provar contra uma versão adivinhada é meia prova; nenhuma linha de NF-e existe antes da NE-5 (corrigir DDL antes disso é barato) |
| **Q-NE166** | O que a NE-2 SERVE (fato 7) | (a) **só `GET /v1/health` (sem `authorities` — é NE-3) e o emitente (`GET /v1/emitter`, `PUT`/`DELETE /v1/emitter/certificate`, `PUT`/`DELETE /v1/emitter/issuers/55`); as outras 10 rotas ficam no contrato marcadas com a onda que as traz (`x-onda: NE-3 \| NE-5`) e o teste rota × contrato confere servidas = contrato − marcadas (nada servido fora do contrato, nada marcado servido); sem stub 501** · (b) stubs 501 para as 10 · (c) a NE-2 não sobe servidor (só migrations + descritor; o HTTP vem na NE-3) — **(a)** — o emitente já é peça do núcleo testada (D-NE9) e a borda é a da nfse-api |
| **Q-NE167** | D-NE82 (c) — registro de descritores EM EXECUÇÃO no núcleo (em pauta desde 12/10; o 2º descritor chega agora; contexto: `nfse-api/src/__tests__/adversarial-ne1a2-gate.test.ts:149` e `fiscal-api/src/__tests__/adversarial-ne1a2-gate.test.ts:192` — um 2º descritor da MESMA tabela com S na lista grava S, "um descritor só" é promessa da cerca da família) | (a) **fechar a (c) como REJEITADA, com conhecimento negativo: a defesa em execução é o CHECK BINÁRIO da tabela da família (D-F107 — vale para QUALQUER processo; um registro no processo não cobre o outro serviço); a nfe-api ganha a MESMA cerca por AST da nfse-api (um descritor só, em `nfe/voice-family.ts`)** · (b) registro no núcleo (recusa o 2º descritor da mesma tabela no MESMO processo) · (c) segue em pauta — **(a)** |
| **Q-NE168** | Onde executa e como publica a NE-2 (fato 10) | (a) **worktrees irmãs `D:\Gestao2027\ne2\{fiscal-api,nfe-api}` (branch `ne2`; o `file:../fiscal-api` resolve a irmã); provas num banco descartável `fiscal_api_adv_ne2`; publicação = núcleo fast-forward + build + push (sem restart: com a Q-NE158 (b) o núcleo só ACRESCENTA — nenhum consumidor muda) + push do `main` da nfe-api + a 001 aplicada no `fiscal_api` do dev pelo `db:migrate` da nfe-api (aditiva, não toca tabela de outra família), com as sondas do boot conferidas logo depois; a nfe-api não fica no ar (sobe só para o passeio)** · (b) a 001 só entra no `fiscal_api` na janela da NE-6, junto do catálogo · (c) trabalhar direto no `main` da nfe-api (a pasta não tem serviço no ar) e só o núcleo em worktree — **(a)** |

### 15.7 Correções sem decisão

- Feitas nesta rodada: o §5 do rascunho do DDL passa a dar GRANT só na view de TENTATIVAS, e só com o leitor (parecer 6.3 — `nfse-api/ops/grants.sql:29-37`).
- Na execução (anotadas aqui para não se perder): `nfe-api.v1.yaml:170` sem a voz S (D-NE107); comentário de `fiscal-api/src/voice/families/index.ts:6`
  ("quando a NF-e chegar (NE-2)") pela Q-NE158; `nfe-api/CLAUDE.md` deixa de dizer "não crie `src/`" (D-NE1); o `emitter.ts:32-33` registra a
  decisão do `model` (Q-NE160).

### 15.8 Rodada 15 — revisão UMA A UMA em curso (Valdo 2026-10-18: "quero revisar as questões da Rodada 15 uma a uma antes de decidir") — ⏯ RETOMAR PELA Q-NE160

| Decisão | O que fixa |
|---|---|
| **D-NE158** (= Q-NE158 (b)) | a leitura publicada `merchandise` nasce no núcleo na NE-2 FORA do catálogo `VOICE_READINGS` e fora de `fiscal-api/reading` (só no barrel); a nfe-api confere as próprias views no boot passando a leitura; entrada no catálogo + superfície + GRANT ao `setes_api` na janela da NE-6, antes da 1ª tentativa possível; junto: `assertFamilyViewsReadable` sem valor padrão (cada chamador passa o que confere — pode ir na janela da NE-6, nota do condutor) e, como verificação da NE-5, a nfe-api não monta a reserva sem a família no catálogo |
| **D-NE159** (= Q-NE159 (a)) | `humanEffectCancel` da NF-e = `() => false`: o 110111 é sempre pedido do emitente e o efeito no ERP é automático, mesmo vindo de outro sistema com o mesmo A1; conhecimento negativo no código + teste que fixa; o 110112 (NFC-e) é decidido pela F5 — nada de conjunto vazio "para a F5" |
| **D-NE160** (= Q-NE160 (a); Valdo, 2026-10-20: *"(a), siga a recomendação"*) | a leitura publicada da família `merchandise` tem como coluna PRÓPRIA só `dh_emission`; `protocol`/`authorizer`/`receipt`/`dh_recbto`/`digest_value` ficam INTERNOS até haver leitor; sem `model` até a F5 (sai da chave; vai à projeção COMUM se o emitter filtrar por modelo); `voiceView` sai do contrato publicado (`reading.ts:91`) e a view 4.2 do rascunho NÃO nasce; a view de vozes da NFS-e fica, sem DROP |
| **D-NE161** (= Q-NE161 (a); Valdo, 2026-10-20, literal: *"A nota de mercadoria e controlada por nos, e a nota de servico é gerado pelo servidor"*) | a faixa retirada é fato da NOSSA numeração (D-F21: série/número do 55/65 são do ERP), não voz do fisco — na NFS-e o número vem do servidor nacional e o fato não existe. Logo: peça própria no núcleo (`numbering/`), FORA do `VOICE_READINGS`; exposta em `fiscal-api/reading` só com o 1º leitor (NE-6) + GRANT; leitor escopado por institution × modelo × série × AMBIENTE; a view nasce na 001 da NE-2 (provada junto do DDL), sem `authority_recorded` |
| **D-NE162** (= Q-NE162 (a); Valdo, 2026-10-20: *"(a), siga a recomendação"*) | autorizadores = constante VERSIONADA em `nfe-api/src/authority/authorizers.ts` (D-NE3), dois grãos (UF × autorizador), entradas DATADAS avaliadas no instante da reserva; a tentativa congela o CÓDIGO do autorizador, a URL se resolve na chamada; CHECKs = domínio dos códigos com teste contra a constante + teste de proveniência pelo SHA-256 do JSON do acervo (`AUTORIZADORES.md`); nasce na NE-3 |
| **D-NE163** (= Q-NE163 (a) + emenda; Valdo, 2026-10-20: *"(a), siga a recomendação...inclua chave composta serie"*) | a faixa retirada tem identidade COMPOSTA com a SÉRIE: `(institution, model, serie, environment, number_from, number_to)` — UNIQUE na tabela da faixa (`tb_invoice_number_void` do rascunho) por essa chave, e a PROVA (`ProcInutNFe` do 102/563, uma por faixa retirada por construção) referencia a faixa — UNIQUE `(environment, withdrawn_void_id)`; o ambiente separa H de P; arquiva-se só a prova, com o nome da D-NE50 (que carrega modelo, série, faixa e ambiente — conferir o nome ao ajustar o rascunho); rejeição é voz, não documento. Corrige o defeito do rascunho (UNIQUE sem ambiente) e refina D-NE109/D-NE50 |
| **D-NE164** (= Q-NE164 (b); Valdo, 2026-10-20: *"(b), siga a recomendação"*) | o teto de 2 MB da resposta do fisco entra na **NE-3**, no `httpsRequest` COMUM do núcleo, junto do transporte SOAP — vale para as DUAS famílias (a NFS-e ganha o teto na mesma revisão); resposta acima do teto = ambíguo pela causa já existente (`tagAmbiguous`); gates da NE-3 com a NFS-e no escopo. Corrige só o QUANDO da D-NE93 |
| **D-NE165** (= Q-NE165 (b); Valdo, 2026-10-20: *"(b), siga a recomendação"*) | a NE-2 prova a 001 no MariaDB 10.4 (descartável `fiscal_api_adv_ne2`); a prova em **MySQL 8 vira PRÉ-CONDIÇÃO da F3** para o `fiscal_api` INTEIRO (núcleo 001–005, nfse-api 001–007, nfe-api 001+), contra o motor e a versão que a SaveInCloud disser — item do roteiro da Onda 4/F3 (`prompt_apis_fiscais_isoladas.md`). Corrige o QUANDO da D-NE109 |
| **D-NE166** (= Q-NE166 (a); Valdo, 2026-10-20: *"(a), siga a recomendação"*) | a NE-2 serve só `GET /v1/health` (sem `authorities` — NE-3) e o emitente (`GET /v1/emitter`, `PUT`/`DELETE /v1/emitter/certificate`, `PUT`/`DELETE /v1/emitter/issuers/55`); as outras 10 rotas ficam no `openapi/nfe-api.v1.yaml` marcadas `x-onda: NE-3 \| NE-5`; teste rota × contrato: servidas = contrato − marcadas (nada servido fora do contrato, nada marcado servido); sem stub 501; borda = a da nfse-api (D-NE9) |
| **D-NE167** (= Q-NE167 (a); Valdo, 2026-10-20: *"(a), siga a recomendação"*) | a **D-NE82 (c) é REJEITADA** com conhecimento negativo no código: a defesa EM EXECUÇÃO contra um 2º descritor da mesma tabela é o CHECK BINÁRIO da tabela da família no banco (D-F107 — vale para qualquer processo); registro de descritores em memória não cobre o outro serviço. A nfe-api ganha a MESMA cerca por AST da nfse-api (um descritor só, em `nfe/voice-family.ts`); teste que fixa a semântica nos dois serviços |
| **D-NE168** (= Q-NE168 (a); Valdo, 2026-10-20: *"(a), siga a recomendação"*) | execução em worktrees irmãs `D:\Gestao2027
e2\{fiscal-api,nfe-api}` (branch `ne2`; `file:../fiscal-api` resolve a irmã); provas no descartável `fiscal_api_adv_ne2` (GRANT `fiscal\_api\_adv%` já existe — D-F53); publicação = núcleo fast-forward + build + push (sem restart: o núcleo só ACRESCENTA — D-NE158) + push do `main` da nfe-api + 001 aplicada no `fiscal_api` do dev pelo `db:migrate` da nfe-api (aditiva) com as sondas do boot conferidas em seguida; a nfe-api não fica no ar (sobe só para o passeio) |

**Rodada 15 FECHADA (2026-10-20 — Valdo, "uma pergunta por vez")**: Q-NE160…Q-NE168 → D-NE160…D-NE168 (D-NE163 com a SÉRIE na chave composta da faixa). **Nenhuma questão aberta.** Próximo: executar a NE-2 em `ne2/` na ordem E1 → E2 (DDL do rascunho ajustado às D-NE160/161/163, provado no descartável ANTES de qualquer código que dependa dele) → E3 → E4 → E5 → gates → publicação (D-NE168); depois a Rodada 0 da NE-3 (§15.5).

~~**Pendentes (na ordem da revisão)**: Q-NE160 (o que a família publica)~~ · Q-NE161 (leitura das faixas retiradas) · Q-NE162 (autorizadores) · Q-NE163
(UNIQUE da faixa com o ambiente — defeito real do rascunho) · Q-NE164 (teto de 2 MB) · Q-NE165 (prova no MySQL 8) · Q-NE166 (rotas da NE-2) · Q-NE167
(D-NE82 (c)) · Q-NE168 (onde executa e como publica). Nada executado; nada commitado.

**Depois da Rodada 15**: executar a NE-2 na ordem E1 → E2 (DDL provado no descartável ANTES de qualquer código que dependa dele) → E3 → E4 → E5 →
gates → publicação (Q-NE168); a Rodada 0 da NE-3 abre depois, com o §15.5 como roteiro.
