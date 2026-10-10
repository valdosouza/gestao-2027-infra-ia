# Onda NF-e — Nota de mercadoria pela SEFAZ (modelo 55; modelo 65 só apontado)

**Escopo**: misto (habilitação do emissor, transmissão, voz do fisco e inutilização são método portável — o mesmo molde das Ondas 2 e 3; a SEFAZ-PR, o A1 e o primeiro cliente com mercadoria são conteúdo `setes`)
**Fase-mãe**: `prompt_primeiro_cliente_setes.md` (D1 emissão com A1 próprio; D33 ordem Inter → NFS-e → Produção). A Setes vende serviço: **esta onda não tem item na trilha dos 7 processos** — nasce para que o desenho da NFS-e (Onda 3) seja correto por construção e para o primeiro cliente com mercadoria.
**Molde**: `prompt_onda3_nfse_adn.md` §3–§7 (mesma tabela de conceitos, mesmos nomes de peça) e `prompt_onda2_banco_inter.md` §3 (dono × apresentação × voz do terceiro) e §10 (lições dos gates: ambíguo nunca fecha, reconciliar antes de reapresentar, transitório ≠ recusa).
**Legado** (vault `D:\Gestao2016\Infra-IA\Gestao`, Decisão 65): `proc-faturamento-venda` E07, `proc-cancelamento-nfe` C00–C05, Lote 6 §2–§5, Lote 8 §2, NUM-01/02/03, AUT-01/02/03/04, CAN-01, CAN-V5/V6/V7, NF-01, `geracao-nfe-hierarquia` §3–§4 (diagnóstico: variação por MODELO duplicada = maior fonte de retrabalho; variação por PROCESSO pequena e sadia; operações do ciclo — inutilizar/consultar — são comandos, não "geradores").
**Aberto em**: 2026-09-21 (Rodada 0 = parecer do guardião conceitual, agente `setes-conceito`, a pedido do Valdo: "desenhar o processo da NF-e mantendo a simetria de controles com a NFS-e, para que o desenho fique, se não o mesmo, seguindo o mesmo fluxo"). Fatos do parecer conferidos no disco pelo condutor (billing.service.ts:672–677, baseline 001, produtores em api/sync).
**Estado**: **2026-10-10 — Rodada 0 da `nfe-api` ORGANIZADA (§11) e Rodada 1 DECIDIDA (§11.7, D-NE1…D-NE26 = recomendações; D-F20 suspensa em parte — NE-0…NE-3 liberadas)** · **Rodada 1 DECIDIDA (2026-09-21, D-E1…D-E25 = recomendações)** · execução pela D-E20 (a): peças comuns junto com a Onda 3 (§10); a NF-e em si espera o 1º cliente com mercadoria — várias questões REABREM de propósito itens da Onda 3 (Q-N4/Q-N6/Q-N9/Q-N13/Q-N14) porque agora custam zero e depois custam migration · contrato oficial da SEFAZ NÃO levantado (MOC 7.0, NT 2025.002 IBS/CBS, schemas PL, tabela de autorizadores — 1ª tarefa técnica, como foi com o Inter e o ADN) · nenhuma linha de código

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
> cima das §3–§10 onde conflitar com as decisões das APIs isoladas (`prompt_apis_fiscais_isoladas.md` §7 — D-F1…D-F48).

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
     (é a mesma lacuna do achado L5 do gate da Rodada 6 = **Q-F58**, absorvida pela Q-NE10);
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
- **Q-NE10 Cerca da virada por família (absorve a Q-F58 do gate da Rodada 6).** (a) **55/65 nascem virados e não dependem
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
D-F50) · **D-NE11** linha 55/65 do `fiscal_api` sem série; série editada no ERP · **D-NE12** `terminal` parametrizado já ·
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
