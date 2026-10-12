# Onda NF-e — Nota de mercadoria pela SEFAZ (modelo 55; modelo 65 só apontado)

**Escopo**: misto (habilitação do emissor, transmissão, voz do fisco e inutilização são método portável — o mesmo molde das Ondas 2 e 3; a SEFAZ-PR, o A1 e o primeiro cliente com mercadoria são conteúdo `setes`)
**Fase-mãe**: `prompt_primeiro_cliente_setes.md` (D1 emissão com A1 próprio; D33 ordem Inter → NFS-e → Produção). A Setes vende serviço: **esta onda não tem item na trilha dos 7 processos** — nasce para que o desenho da NFS-e (Onda 3) seja correto por construção e para o primeiro cliente com mercadoria.
**Molde**: `prompt_onda3_nfse_adn.md` §3–§7 (mesma tabela de conceitos, mesmos nomes de peça) e `prompt_onda2_banco_inter.md` §3 (dono × apresentação × voz do terceiro) e §10 (lições dos gates: ambíguo nunca fecha, reconciliar antes de reapresentar, transitório ≠ recusa).
**Legado** (vault `D:\Gestao2016\Infra-IA\Gestao`, Decisão 65): `proc-faturamento-venda` E07, `proc-cancelamento-nfe` C00–C05, Lote 6 §2–§5, Lote 8 §2, NUM-01/02/03, AUT-01/02/03/04, CAN-01, CAN-V5/V6/V7, NF-01, `geracao-nfe-hierarquia` §3–§4 (diagnóstico: variação por MODELO duplicada = maior fonte de retrabalho; variação por PROCESSO pequena e sadia; operações do ciclo — inutilizar/consultar — são comandos, não "geradores").
**Aberto em**: 2026-09-21 (Rodada 0 = parecer do guardião conceitual, agente `setes-conceito`, a pedido do Valdo: "desenhar o processo da NF-e mantendo a simetria de controles com a NFS-e, para que o desenho fique, se não o mesmo, seguindo o mesmo fluxo"). Fatos do parecer conferidos no disco pelo condutor (billing.service.ts:672–677, baseline 001, produtores em api/sync).
**Estado**: **2026-10-12 (tarde) — §12.9.7: Rodada 0 da PARTE 2 da NE-1a feita (inventário + parecer do guardião + ordem interna, sem DDL) + leitura DETERMINÍSTICA do ACBr (`../nfe-api/referencia-acbr/06`) → D-NE72…D-NE74 DECIDIDAS e ordem aceita ("siga as recomendações e a ordem proposta"); EM EXECUÇÃO — passos 1–6 FEITOS (§12.9.7.1: cerca por modelo, emitter no núcleo, terminal por parâmetro + listas derivadas, escritor genérico sob `InvoiceTx`, política em peças, `ca`/cadeia do servidor — D-NE57; núcleo 327 · nfse-api 591 + 150/150 ao vivo; nada commitado); gates 0,76/0,72 → D-NE75…D-NE84; "parte 2a" PUBLICADA (núcleo 27d2aa6 · nfse 38980bb · infra f72fba4); próximo: passo 7 = N17 (parser XML) → "parte 2b"** · **2026-10-12 — §12.9 ⏯ RETOMAR POR AQUI: NE-1a PARTE 1 EXECUTADA, com GATES (0,76/0,76) e PUBLICADA — D-NE56…D-NE62 e D-NE66/68/69/70/71 (D-NE61: a denegada barra pelo FATO da view — Q-NE67 rejeitada); nenhuma questão aberta; PROMPT DE RETOMADA da parte 2 no §12.9.6; próximo: parte 2 da NE-1a (cerca por modelo, emitter, escritor/peças, `ca`/cadeia D-NE57, parser XML N17, D-NE69) → F2a** · 2026-10-11 — D-NE55 (a NE-0 vai para depois da F2a) · **2026-10-11 — §12.8: nota de implantação da NE-1a para a ESCRITA DA VOZ por família (D-F105/D-F106/D-F108 das APIs fiscais) — entra no escopo da NE-1a** · **2026-10-10 (tarde) — §12: plano ajustado pela leitura do ACBr (`../nfe-api/referencia-acbr/`) + Rodada 2 da nfe-api DECIDIDA (§12.7, D-NE27…D-NE54 = recomendações); NE-1 partida em 1a (antes da F2a) / 1b (depois); nenhuma questão da nfe-api aberta — o bloco F vai ao prompt IBS/CBS** · **2026-10-10 — Rodada 0 da `nfe-api` ORGANIZADA (§11) e Rodada 1 DECIDIDA (§11.7, D-NE1…D-NE26 = recomendações; D-F20 suspensa em parte — NE-0…NE-3 liberadas)** · **Rodada 1 DECIDIDA (2026-09-21, D-E1…D-E25 = recomendações)** · execução pela D-E20 (a): peças comuns junto com a Onda 3 (§10); a NF-e em si espera o 1º cliente com mercadoria — várias questões REABREM de propósito itens da Onda 3 (Q-N4/Q-N6/Q-N9/Q-N13/Q-N14) porque agora custam zero e depois custam migration · contrato oficial da SEFAZ NÃO levantado (MOC 7.0, NT 2025.002 IBS/CBS, schemas PL, tabela de autorizadores — 1ª tarefa técnica, como foi com o Inter e o ADN) · nenhuma linha de código

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

**Conceito**: uma faixa de números (ano, modelo, série, `number_from..number_to`) deste emissor que declaramos ao fisco que não será usada. Nasce de um ato do usuário (obrigação legal: números pulados devem ser inutilizados até o 10º dia do mês seguinte) e recebe UMA voz síncrona e definitiva (cStat 102 homologada; rejeição; 206 "já inutilizada" = confirmação de um envio ambíguo anterior). Não é sobre nota nenhuma: NUM-03/Lote 8 §2 do legado mostram o erro de quem tentou (`tb_ctrl_nf` recriando a sequência com "uma linha por número", `LiberaNumeroNota` morta, série fixa '1').

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
certificado = admin · **D-E15** devolução: `finality` por presença, `refNFe` = chave autorizada da âncora · **D-E16**
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
| **D-NE25** | 1º release = venda (finNFe 1) + devolução (finNFe 4, `refNFe` da âncora); exige TRANSMITIR em `order-returns` |

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
| **D-NE45** | em `tpAmb=2` o builder aplica os textos padrão do fisco (`dest/xNome`, `xProd` do item 1) | NE-4 |
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

### 12.9 D-NE55 — a NE-0 vai para DEPOIS da F2a (Valdo 2026-10-11) + NE-1a ABERTA (Rodada 0) — ⏯ RETOMAR POR AQUI

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

**Provas**: núcleo **405/405** · nfse-api **665 unit** (44 suítes) · `tsc` limpo nos dois · `dist/` refeito · ao vivo **150/150**. **PUBLICADA a "parte 2b" (Valdo: "pode publicar a parte 2b", 2026-10-12)** — núcleo 604117a · nfse ebbaf44. Próximo: F2a.
