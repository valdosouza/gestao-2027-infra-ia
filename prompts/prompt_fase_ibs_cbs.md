# Fase IBS/CBS — Reforma Tributária do Consumo nos documentos fiscais (NFS-e da Setes primeiro, NF-e depois)

**Escopo**: misto (catálogo oficial versionado, classificação × cálculo × voz do fisco e leiaute com vigência são método portável; a
Setes no Simples, Curitiba, subitem 1.02 e a opção de regime são conteúdo `setes`)
**Origem**: D-F22 (fase própria, marco duro 01/01/2027) · D-E17 (um desenho para os dois documentos) · D-N14 (premissa corrigida pelo
Ato Conjunto nº 4/2026) · D-NE4 ("prompt aberto JÁ") · D-NE31 (vigência de leiaute vem para cá) · D-NE47 (finNFe 5/6 entram por aqui)
· bloco F do §12.5 de `prompt_onda_nfe_sefaz.md` (Q-RTC1…Q-RTC6).
**Aberto em**: 2026-10-10 — pedido do Valdo: "vamos abrir o prompt da fase IBS/CBS".
**Insumos desta Rodada 0** (4 levantamentos em paralelo, só leitura): (A) oficial da NFS-e no acervo (`Infra-IA/setes-api/integracoes/nfse-adn/`:
XSD 1.01, NT 007/008/009, anexos I e II, FAQ) · (B) inventário do produto (setes-api, nfse-api, fiscal-api, sql) · (C) fotografia do legado
Gestao2016 (agente legacy-analyst) · (D) legislação e documentos oficiais na web (fontes primárias, datadas) · + `Infra-IA/nfe-api/referencia-acbr/03-ibs-cbs-rtc.md`
(ACBr, terceiro — só conferência).
**Estado**: **IB-1 FECHADA no dev (2026-10-10, 2ª sessão — §11.1…§11.6 = PONTO DE RETOMADA): gates socrático 0.66→0.75 ✅ e adversarial 0.80 ✅ (retrabalho com teste: Calculadora vazia recusada, conferência por linha/data — A-IB2, o ato da carga tem PLANO, CHECK conferido no boot + CHECK nas colunas congeladas, orçamento de memória do xlsx, autor da classificação), passeio logado feito (achado corrigido: cIndOp sem o "local do fornecimento" — 7 pares iguais), catálogo de campos da interface services (seed 62 + caminho do payload); código COMMITADO só pelos caminhos da IB-1 (§11.6 — api e635fef · sql 5dcede9 · app 27cc7a6, PUBLICADO; Infra-IA integrada e commitada); **Rodada 3 DECIDIDA e EXECUTADA (§11.7/§11.8 — D-IB28…D-IB33, A-IB1/A-IB2 confirmadas; gates do delta 0.72/0.74 ✅; não commitada); Rodada 4 Q-IB34…Q-IB38 aberta (§11.9 — Q-IB34 antes de dezembro)**; Rodada 3 Q-IB28…Q-IB33 + confirmar A-IB1/A-IB2 aguardam o Valdo.** (antes: IB-1 implementada na 1ª sessão) (antes: IB-0 + Rodada 2 — §10.5) (antes: IB-0 com parecer do
guardião). Antes: Rodada 1 DECIDIDA (2026-10-10, "siga as recomendações" — §8, D-IB1…D-IB21).
⚠️ A opção de regime da Setes (D-IB1) segue com o Valdo e o contador até **30/10/2026**; o patch do legado (D-IB3) está COMMITADO (SVN r1300) e
compilado — falta só a versão aos clientes (conferência dispensada: nenhum cliente de serviço emitiu com a reforma).
Antes: Rodada 0 ORGANIZADA (2026-10-10) com parecer do guardião (§3). Nenhuma linha de código.

---

## 0. ⚠️ Antes de qualquer código

1. **30/10/2026 — opção da Setes pelo regime de IBS/CBS (decisão de NEGÓCIO, com o contador).** Resolução CGSN nº 194 (DOU 28/09/2026,
   notícia da RFB de 29/09/2026): o optante do Simples pode optar por recolher IBS/CBS pelo regime REGULAR ("por fora" do DAS) na janela
   **01/09 a 30/10/2026**, com efeito em **01/01/2027**; cancelamento da opção 03/11 a 20/12/2026; depois a opção é **semestral**
   (exercida em setembro/março para janeiro/julho) e **irretratável no semestre** (LC 123 art. 13 §§ 9º–11, redação da LC 227/2026). Sem
   opção, IBS e CBS ficam "por dentro" do DAS (Manual do CGSN de 07/10/2026). Efeito para o tomador: quem compra de optante no DAS só
   credita "o equivalente ao devido por meio desse regime" (LC 214 art. 47 § 9º). Efeito no documento: `regApIBSCBSSN` = 1 (IBS e CBS no
   Simples) · 2 (só CBS no Simples) · 3 (ambos regulares) — NT 009 §2.4. → **Q-IB1**.
2. **Alerta do LEGADO (fora deste projeto, mas é risco hoje)**: a NFS-e do Gestao2016 tem **valores de exemplo FIXOS no código** —
   `cIndOp '123456'`, documento de reembolso `'12345'`/"Carta Remessa de Mercadoria", CST 000/cClassTrib 000001, `cCredPres 'cp01'`,
   diferimento 5 %/5 %/5 % (`D:\Gestao2016\Ajuda\un_geranfe_Srv.pas:2827`, `:2885-2893`, `:2922-2934`) — e vão ao XML de QUALQUER
   prestador assim que alguém marcar "Ativar Reforma Tributária" (`GRL_G_REF_TRIBUTARIA`, `Ajuda/Un_Configuracao.dfm:621`, lido em
   `un_geranfe_Srv.pas:1153`). → **Q-IB3**.

## 1. Fatos (2026-10-10)

### 1.1 Legislação e cronograma (fontes primárias, levantamento D)

- **Ato Conjunto RFB/CGIBS nº 4, de 30/07/2026** (PDF assinado, site do CGIBS 31/07/2026; base: art. 112 do Decreto 12.955/2026 e
  Resolução CGIBS nº 6/2026): obrigação por FATO GERADOR a partir de — NF-e/NFC-e 03/08/2026 (§ 4º: não contribuinte de ICMS 01/12/2026);
  NFS-e 01/10/2026 (lista LC 116 em geral, alínea d) e 01/12/2026 (plataformas, subitens 1.03/1.05/1.09, 16.01, bens imateriais,
  condomínios, locações — alíneas a–c e e–h); **§ 1º: todo optante do Simples Nacional em 01/01/2027**. O Ato **não trata** de rejeição.
- **Ato Conjunto nº 5, de 12/08/2026** (site do CGIBS 13/08): Programa Nacional de Conformidade Tributária (LC 214 arts. 471-A a 471-C,
  incluídos pela LC 227/2026) **só para 2026** — quem cumpre ou melhora progressivamente e **retifica até 31/12/2026**. Para 2027: não
  encontrado. Ato nº 6 (28/08/2026): nanoempreendedor dispensado até 2028. Nenhum ato mudou as datas do nº 4.
- **Rejeição por ausência do grupo**: a RFB anunciou em 01/08/2026 que a ausência deixa de rejeitar NF-e, NFC-e, CT-e e outros (a NFS-e
  não está na lista); na NT 2025.002 v1.52 a regra UB12-10 (rej. 1115) tem as datas riscadas — inclusive 04/01/2027 do Simples — e
  vale "implementação futura"; na NFS-e o grupo segue `minOccurs="0"` no XSD de produção. **Consequência**: a obrigação de 01/01/2027 é
  LEGAL (Ato nº 4); a rejeição por ausência pode não estar ligada nessa data. Regras do grupo só rodam se ele for enviado — mandar errado
  rejeita, omitir não (aviso da NT). Em 2026, ausência = intimação com 60 dias para suprir (LC 214 art. 348 §§ 3º–4º).
- **Alíquotas 2027**: IBS 0,05 % estadual + 0,05 % municipal (LC 214 art. 344); CBS = referência − 0,1 ponto (art. 347), fixada pelo
  Senado até 31/10 (art. 349 § 1º) — **resolução não encontrada em 10/10/2026**; a calculadora oficial devolve 404 para datas de 2027.
  PIS/COFINS revogados em 01/01/2027 (art. 542). Partilha do DAS, Anexo III 1ª faixa (6,00 %), 2027–2028: CBS 15,43 % · IBS 0,17 %.

### 1.2 NFS-e — o que o OFICIAL diz (levantamento A, conferido com D)

- **Em produção**: XSD **1.01** (09/02/2026; leiaute da NT 004). O grupo `IBSCBS` é o **último filho de `infDPS`**, opcional
  (`tiposComplexos_v1.01.xsd:838`). Aceito para competência ≥ 01/01/2026 (E0850) e DPS ≥ 1.01 (E0854) — **a Setes já pode enviar o grupo
  hoje, voluntariamente**.
- **O DPS leva CLASSIFICAÇÃO e contexto** (`TCRTCInfoIBSCBS`, `:2207-2280`): `finNFSe` (só "0"), `indFinal`?, **`cIndOp`** (6 dígitos),
  `tpOper`?, `gRefNFSe`?, `tpEnteGov`?, **`indDest`**, `dest`?, `imovel`?, `valores{gReeRepRes? (R$), trib{gIBSCBS{CST, cClassTrib,
  cCredPres?, gTribRegular?, gDif? (%)}}}`. Nenhuma alíquota nem valor de IBS/CBS calculado; nenhuma redução escolhida pelo emitente.
- **O FISCO CALCULA** (`TCRTCIBSCBS`, `:287-734`): local de incidência, `pRedutor`, `vBC`, alíquotas e efetivas por esfera, `totCIBS{vTotNF,
  gIBS, gCBS…}` — cada valor "igual ao retornado pela Calculadora", tolerância R$ 0,01 (E1539…E1607, `anexo1!RN l.76-138`). **`vTotNF =
  vLiq` em 2026 e `vLiq + vCBS + vIBSTot` a partir de 2027** (`:454-463`).
- **A classificação é validada contra FLAGS do cClassTrib**: válido para serviço (E0958), CST = prefixo do cClassTrib (E0959), exige/proíbe
  `gTribRegular` (E0964/E0965), permite/proíbe `gDif` (E0971/E0972), redutores (E1540…E1553). Para não ser rejeitado, o ERP precisa de
  cópia local da tabela COM as flags.
- **Simples no 1.01**: nenhuma regra cruza Simples × IBSCBS além de "obrigatório a partir de 2027" (`anexo1!LEIAUTE l.47/l.336`).
- **NT 009 v1.01 (11/09/2026; leiaute Anexo VI v1.04.01; cIndOp Anexo VII v1.03.00)** — **sem XSD em produção nem em produção restrita
  (27/07/2026) e com cronograma "será publicado"**: `opSimpNac` 4 "pendente"; `regApIBSCBSSN`; `cAtvSN` (9 = Fator R, Anexo III/V);
  na NFS-e `gTribSN{pIBSSN, vIBSSN, pCBSSN, vCBSSN}` sobre `vReceitaBrutaSN`, `verCalcIBSCBS`; notas de ajuste `finNFSe` 1/2 com
  `gIBSCBSAjuste` (emitente informa vIBS/vCBS); `vAjusteBC`; `gPgtoVinc` (boleto 15 / Pix); `indFinal` reinserido.
- **NT 007**: `tpRetPisCofins` 1/2 serão SUPRIMIDOS quando o grupo for obrigatório (a nfse-api não emite o campo hoje); PIS/COFINS/CSLL
  retidos somados em `vRetCSLL`; arredondamento half-even. **NT 008 v1.02**: DANFSe ganha o bloco "Dados da Tributação IBS/CBS" e o total
  "Valor Líquido + IBS/CBS"; federais viram "Exceto CBS".
- **Conjunto mínimo provável da Setes em 2027** (Simples ME/EPP, 1.02 `010201`, Curitiba, tomador PJ): `finNFSe` 0 · `cIndOp` de "demais
  serviços → estabelecimento do adquirente" (INFERÊNCIA — Anexo VII fora do acervo) · `indDest` 0 · CST 000 + cClassTrib 000001
  (INFERÊNCIA) · com a NT 009: `regApIBSCBSSN` 1 (se não optar — Q-IB1) e `cAtvSN` 9 (INFERÊNCIA — Anexo III a 6,00 %).
- **CNPJ alfanumérico**: NF-e em produção desde 01/07/2026 (NT 2026.004); NFS-e desde 10/08/2026 (página de implantações); 1º CNPJ com
  letras gerado em 31/07/2026 — insumo da frente própria (D-NE29).

### 1.3 Tabelas oficiais e a Calculadora (levantamento D)

- **cClassTrib/CST**: Informe Técnico 2025.002 **v1.70** (09/2026, Ato Técnico Conjunto nº 8 de 29/09/2026, publicado 01/10/2026) —
  218 códigos, cada linha com `dIniVig`, `dFimVig`, `DataAtualização`, flags; **nova versão a cada 2–3 meses em 2026**; UMA tabela para
  todos os DF-e, com indicador `indNFSe`; nenhum cClassTrib próprio do Simples (só 811003 "desenquadramento"); a dimensão Simples é o
  indicador `tpRBSN` (desde a v1.60). Fontes: Portal NF-e (Documentos > Diversos), SVRS `ClassificacaoTributaria`, **API dados-abertos da
  Calculadora (JSON, sem autenticação)**.
- **cIndOp**: Anexo VII v1.03.00 (LC 214 art. 11). **Anexo VIII** (NBS × IndOp × cClassTrib) = "trabalho inicial", sem regra ligada.
- **Calculadora oficial ("motor de cálculo oficial", IT 2025.002)**: API pública BETA com Swagger (app 1.5.4, banco V0059 de 30/09/2026
  "Habilitação de 820 para NFSe"; endpoints de NFS-e: base, cIndOp, cClassTrib por NBS, geração/validação de XML) + **versão OFFLINE em
  código aberto para embarcar no ERP** (zip/Docker/JAR — não baixada). É a MESMA que a Sefin usa para gerar os valores da NFS-e.

### 1.4 NF-e (levantamento D + ACBr)

NT 2025.002-RTC **v1.52** (01/10/2026), pacote **PL 010f** (31/08/2026); regras para CRT 1/2/4 "em NT futura" — **não publicada** (o
cronograma previa 01/09). NT 2026.006 (vínculo com o pagamento) · **NT 2026.007 v1.10: NF-e SEM IE para contribuinte exclusivo de
IBS/CBS, produção 03/11/2026 + rej. 180 CRT divergente do cadastro da RFB** (reabre a premissa da D-NE18 "a Setes não tem IE") ·
**NT 2026.008: IBS/CBS compõem o `vProd` a partir de 2027** (regras em produção 01/03/2027) · NT 2026.010 DANFE da reforma. Na NF-e o
EMITENTE informa valores (42 unidades — `referencia-acbr/03` §3); o ACBr traz dois modelos divergentes da NF-e RTC (não é fonte de leiaute).

### 1.5 O produto hoje (levantamento B)

- **Zero IBS/CBS.** Só esqueleto: `tb_tax_rule.tb_taxes_id` e `tb_service_tax_rule.tb_taxes_id` sem FK ("elo da reforma — tb_taxes ainda
  não existe na web", `setes-api/src/migrations/sql/025_tax_rule_family.sql:34,55-56`; `036_service_tax_rule.sql:14,25`), ignorados pelo
  motor; stub "P10 aguardando regulamento" em `api/shared/tax-rule/calc.ts:8,379`; DPS declaradamente "sem IBS/CBS"
  (`nfse-api/src/authority/types.ts:18`); `cNBS` no tipo e no montador, nunca preenchido. **NBS não existe em nenhum cadastro.**
- **Molde de snapshot por item** (mercadoria): `persistItemTaxes` (`api/modules/billing/billing.repository.ts:624-746`) grava
  `tb_order_item_icms/_icms_fcp/_ipi/_ii/_pis/_cofins/_issqn` na MESMA transação do faturamento; PK desses snapshots **sem `kind`**,
  enquanto o vínculo `tb_order_item_tax_rule` e `tb_order_item` têm `kind` (inconsistência). A OS calcula ISS direto (`calcIssqn`,
  `service-orders.repository.ts:1032`), **sem passar pelo motor**.
- **Serviço**: `tb_service_list` (LC 116) → `tb_service_national_code` (cTribNac, seed 57) → `tb_service_tax_rule` (cidade × item →
  alíquota, códigos) → `tb_service` (FK literal) → ramo `tb_invoice_service` (código nacional, municipal, cidade de incidência, ISS).
- **Emitente** (`tb_entity_tax`): `simples_regime` (opSimpNac), `simples_assessment` (regApTribSN), `simples_total_tax_aliquot`
  (pTotTribSN); `tax_regime` (CRT) não chega à nfse-api; não optante = 422 "ainda não suportado" (`nfse-api/src/facts/service-facts.ts:190-193`).
- **Títulos × total**: os títulos nascem do total do ERP na MESMA transação do faturamento (`billing.repository.ts:517-541`; OS
  `service-orders.repository.ts:1162-1212`), ANTES da transmissão; **nada do retorno do fisco volta ao ERP** — o `parseNfseXml` lê só o
  cabeçalho e o `fiscal_api` guarda só chave/número/dhProc. Com `vTotNF = vLiq + IBS + CBS` (regime regular, 2027), o total do fisco
  passa a diferir do título.
- **Dual-run**: até a virada (F2a), o DPS de PRODUÇÃO sai pela cópia do montador no setes-api (`api/shared/tax-authority/`); mexer no
  DPS antes da virada = mexer nas DUAS cópias (D-F43).
- Nenhuma config nem chave de reforma no Framework de Configurações.

### 1.6 O legado (fotografia — levantamento C)

- **Catálogo** `TB_ECLASS` (PK CST+CLASSE; flags IND_GTRIBREGULAR, IND_CREDPRES, IND_MONO*, PREDIBS/PREDCBS, vigência) — 132 linhas de
  05–06/2025 carregadas de um `tb_eclass.sql` avulso que é APAGADO após rodar; **nenhum código usa as flags nem a vigência**; traz CST 210
  que o ACBr da revisão compilada não conhece (exceção em runtime) e falta 515/811.
- **`TB_TAXES` = UMA "taxa" por regra de tributação** (CST + cClassTrib + alíquotas por esfera CBS/IBS UF/IBS Mun, sem dimensão de UF ou
  município de destino), ligada por `TB_TRIBUTACAO.TB_TAXES_ID` sem FK — **é a origem das colunas `tb_taxes_id` mortas da web**.
- **O legado CALCULA** (`componentes/tributacao.pas:3236-3563`): base, efetiva `p × (1 − red/100)`, diferimento; duas semânticas de
  `ALIQ_RED` (tela em pontos × motor em %); grava `TB_IBSCBS` + UF/MUN/CBS por item mesmo com a reforma desligada.
- **Chave manual** `GRL_G_REF_TRIBUTARIA` por estabelecimento; sem vigência por data; sem tratamento do Simples; "APLICAR" altera regras
  de TODOS os estabelecimentos. NFS-e: ver §0 item 2. ACBr compilado: revisão 47865 (19/08/2026).

## 2. Objetivos (numerados)

1. A Setes emite NFS-e com o grupo `IBSCBS` correto para o seu regime (Q-IB1) a partir da competência 01/2027 — **sem calcular o que o
   fisco calcula** —, provado antes em produção restrita e, se decidido, voluntariamente em produção em dezembro/2026.
2. A CLASSIFICAÇÃO (CST, cClassTrib, cIndOp, indDest…) é fato do ERP: escolhida/derivada por regra, conferida contra o catálogo oficial
   local (com flags e vigência) ANTES de faturar, e congelada na nota.
3. A voz do fisco com os VALORES (vBC, alíquotas, vIBS, vCBS, vTotNF) é guardada e lida; o efeito no ERP (títulos) é decidido, não
   presumido.
4. O leiaute muda por DATA e AMBIENTE sem deploy à meia-noite (D-NE31); a NT 009 entra quando o XSD existir sem reformar o que nasceu.
5. A NF-e (regime regular primeiro, F4) reusa o MESMO catálogo e a mesma classificação; o cálculo por item (que só a NF-e exige) é
   decidido aqui e executado na NE-4/NE-6.
6. DANFSe (e depois o DANFE) com o bloco IBS/CBS.

## 3. Modelo (Rodada 0 — parecer do guardião conceitual, agente `setes-conceito`, 2026-10-10)

**Conceito-mãe**: a reforma entra como TRÊS fatos com donos diferentes — a **classificação** (o que o contribuinte presume da operação:
escolha, congelada na nota), o **cálculo** (a lei aplicada a uma base: função, sem escolha) e a **voz do fisco** (os valores que o terceiro
calculou) — mais dois fatos DATADOS: o **enquadramento do emitente** e o **calendário** de leiaute/obrigação. O legado fundiu os cinco numa
"taxa por regra" (`TB_TAXES`) + uma chave manual; por isso precisou de valores de exemplo fixos e acabou com duas semânticas de redução.

| # | Conceito (uma frase) | Fato gerador | Natureza | Onde mora | Nome proposto |
|---|---|---|---|---|---|
| 1 | Situação tributária do IBS/CBS (CST) | publicação do IT 2025.002 | referência (pai) | `setes_central` | `tb_tax_ibscbs` (família de `tb_tax_pis`/`_cofins`) |
| 2 | Classificação tributária (cClassTrib) com flags e vigência | mesma publicação, linha com `dIniVig` | referência filha, PK `(code, valid_from)` | `setes_central` | `tb_tax_ibscbs_classification` |
| 3 | Natureza do serviço (NBS 2.0) | Portaria RFB/SCS | referência + coluna do serviço | central / cliente | `tb_nbs` + `tb_service.nbs` |
| 4 | Hipótese do local da operação (cIndOp, LC 214 art. 11) | Anexo VII | referência | `setes_central` | `tb_ibscbs_place_indicator` |
| 5 | Classificação que a regra de MERCADORIA presume | cadastro da regra | peça 1:1 da regra (presença = "a regra define IBS/CBS") | cliente | `tb_tax_rule_ibscbs` |
| 6 | Classificação que o SERVIÇO presume | cadastro do serviço | peça 1:1 de `tb_service` (cClassTrib + cIndOp) | cliente | `tb_service_ibscbs` |
| 7 | Enquadramento do emitente vigente a partir de uma data | opção/enquadramento perante a RFB, com data de efeito | peça com vigência | cliente | `tb_establishment_tax_regime` |
| 8 | Classificação que a NFS-e declara | faturamento (billing **e** OS) | colunas do ramo (um DPS = um serviço) | cliente | `tb_invoice_service.classification_code`, `place_indicator_code`, `nbs` |
| 9 | Tributação IBS/CBS declarada por item da NF-e | faturamento | snapshot por item; esferas como lista por `kind` U/M/C | cliente (F4) | `tb_order_item_ibscbs` |
| 10 | Valores que o fisco calculou na NFS-e autorizada | voz A | peça 1:1 da tentativa, write-once + VIEW | `fiscal_api` | `tb_invoice_service_transmission_ibscbs` |
| 11 | Cálculo do IBS/CBS (a lei aplicada) | chamada do faturamento | porta sem escolha; atrás dela a Calculadora oficial | setes-api | `@shared/ibscbs-calculation` |
| 12 | Resolução da classificação (linha vigente, CST derivado, aplicabilidade por modelo, obrigação legal, congelamento do ramo) | — | peça transaction-aware | setes-api | `@shared/ibscbs-classification` |
| 13 | Leiaute aceito por ambiente e data | publicação de NT/XSD | constante datada do adaptador | nfse-api (e nfe-api) | calendário de leiaute em `authority/` |

**Pontos do parecer que viram regra se aprovados** (as escolhas estão no §7, Q-IB4…Q-IB13):

- **Catálogo**: casa ÚNICA em `setes_central` (fato do mundo; a nfse-api lê pela fonte de fatos — D-F10); a regra guarda só o cClassTrib,
  o **CST é DERIVADO** (prefixo — E0959); vigência é a LINHA (`valid_from`/`valid_until` resolvidas pela data do fato gerador), a versão do
  IT é só proveniência (`source_version`, `source_updated_at`); linha nunca é apagada; flags viram colunas tipadas **só com consumidor**;
  carga por rotina do Super a partir dos dados abertos, falhando alto se a estrutura oficial mudar (nunca o `.sql` avulso do legado).
- **Serviço × regra de ISS**: a classificação NÃO cabe na `tb_service_tax_rule` — o seletor dela é cidade × item com unicidade por 409
  (`sql/03_schema_cliente_ddl.sql:1170`): dois serviços do mesmo subitem com cClassTrib diferente ficariam impossíveis e a classificação se
  duplicaria por cidade. O DPS separa as camadas: `cNBS`/`cAtvSN` em `serv/cServ` (natureza do serviço) × `cIndOp` no grupo IBSCBS.
  **cIndOp é ESCOLHIDO** (o Anexo VIII só sugere), nunca derivado do local do ISS (LC 116 art. 3º ≠ LC 214 art. 11) nem fixo.
- **Enquadramento datado**: a nfse-api lê `tb_entity_tax` NA TRANSMISSÃO (`nfse-api/src/facts/service-facts.ts:157-167`) — nota de 30/12
  transmitida em 02/01 sairia com o regime novo. `tax_regime` (CRT, varchar livre) e `simples_regime` (opSimpNac) são DUAS codificações
  do mesmo fato (`sql/03:758-759`) — a NF-e vai precisar do CRT (rej. 180).
- **Dois congeladores**: o ramo de serviço tem dois produtores — `buildServiceBranch` (`setes-api/src/modules/billing/billing.repository.ts:770`)
  e `freezeServiceOrderIss` (`service-orders.repository.ts:1009`) — e **a Setes fatura pela OS**. O congelamento da classificação é UMA função
  na peça.
- **Voz, não cópia**: os valores do fisco ficam no `fiscal_api` (copiar no ERP = segunda verdade; a nfse-api escrever no ERP fere a D-F31).
- **Cálculo** é porta no setes-api (D-F22; as APIs fiscais não calculam); motor próprio de alíquota/redução é maquete (alíquota é lei × ente
  × data — a partir de 2029 cada UF e município fixa a sua). O stub P10 (`calc.ts:8,379`) vira a chamada da porta, por último na ordem T1
  (D22 do faturamento continua valendo).
- **Calendário**: três fatos datados com três donos — leiaute (autoridade → constante datada do adaptador; `LAYOUT_VERSION='1.01'` vira
  tabela ambiente × `valid_from`, por deploy antes da data — D-NE31) · obrigação legal (lei → constante da peça de classificação: documento ×
  regime × subitem × data, decide o 422) · rejeição por ausência (fisco — não modelamos). **Envio voluntário não precisa de chave**: basta a
  classificação cadastrada.

### 3.1 O que vira MAQUETE se modelar errado

1. `tb_taxes` com alíquota por esfera em cada regra (N regras por destino, a lei mantida à mão) · 2. chave "Ativar Reforma" por
estabelecimento (dono errado de um fato datado + valores de exemplo no XML) · 3. CST guardado ao lado do cClassTrib (guarda "CST =
prefixo") · 4. catálogo por VERSÃO com ponteiro de "vigente" (regras órfãs a cada IT) · 5. classificação na regra de ISS · 6. redução
digitada pelo cliente · 7. valores do fisco copiados no ERP ou título reescrito pela voz · 8. regApIBSCBSSN como coluna editada na virada
· 9. cAtvSN no emitente (empresa com dois anexos) · 10. CRT e opSimpNac como colunas livres separadas · 11. dois congeladores (billing ×
OS) · 12. motor próprio de alíquota · 13. cIndOp fixo ou derivado do local do ISS.

### 3.2 Palavras ocupadas (não usar) e livres

**Ocupadas**: *taxa/taxes* (taxa da `tb_settlement_rule`, `ci.taxes`, `tb_taxes_id`, `TB_TAXES` do legado) · *tributação* (Regra de
Tributação) · *operation* (polaridade C/D do financeiro → por isso cIndOp = `place_indicator`) · *regime* (o enquadramento, que a peça
datada reúne). **Livres**: `classification`, `ibscbs`, `nbs`. Colunas-chave: `classification_code` char(6), `place_indicator_code`,
`nbs` char(9), `valid_from`/`valid_until`, `source_version`.

## 4. Ondas e esforço (sessão ≈ 4 h com testes verdes; ±40 %)

| Onda | Entrega | Sessões | Depende de |
|---|---|---|---|
| **IB-0** | Rodada 1 (Q-IB*); arquivar os oficiais (Q-IB21); levantar fatos da Setes (opção Q-IB1, cIndOp exato pelo Anexo VII, tomador público — Q-IB18); parecer do guardião sobre o DDL + `revisar-ddl` | 1–2 | Valdo; **Q-IB1 até 30/10** |
| **IB-1** | referências centrais (CST, cClassTrib com vigência/flags, cIndOp, NBS) + rotina de carga do Super; `tb_service_ibscbs` + `nbs` no serviço (aba no cadastro de serviços); enquadramento datado (migra colunas de `tb_entity_tax`, CRT derivado); DROP `tb_taxes_id` (Q-IB4) | 3–4 | IB-0 |
| **IB-2** | peça `@shared/ibscbs-classification` (linha vigente, CST derivado, obrigação → 422) + congelamento ÚNICO no ramo (billing e OS) + o que as views/fonte de fatos precisam | 2–3 | IB-1 |
| **IB-3** | nfse-api: fonte de fatos lê classificação congelada e enquadramento pela competência; builder do grupo `IBSCBS`; calendário de leiaute; leitura do `IBSCBS` do retorno → voz + VIEW; DANFSe com o bloco (NT 008) | 3–4 (+1–2 se Q-IB15 (b)) | IB-2 |
| **IB-4** | prova em produção restrita + envio VOLUNTÁRIO em produção em dezembro (Q-IB16) + gates socrático/adversarial | 1–2 | IB-3 |
| **IB-5** | NT 009 quando o XSD existir (regApIBSCBSSN, cAtvSN no serviço, `gTribSN` na leitura) | 1–2 | XSD oficial |
| **IB-N** (dentro da F4) | porta de cálculo + Calculadora oficial (prova de conceito, topologia D-F9) + `tb_tax_rule_ibscbs` + `tb_order_item_ibscbs` + builder do grupo na nfe-api (NE-4/NE-6) | 6–10 | 1º cliente de mercadoria; Q-IB11 |
| **Caminho até 01/01/2027 (IB-0…IB-4)** | | **10–15** (≈ 3–4 semanas de trabalho) | concorre com a F2a (um executor = serial); Q-IB15 |

**⚠️ Roteiro de leitura ANTES de abrir a IB-2** (decisões e limites que a IB-1 deixou para ela — gate socrático do delta R5):
D-IB8 (sem classificação depois da obrigação = 422) · D-IB9 (colunas congeladas no ramo `tb_invoice_service`, UMA função da peça, billing
E OS) · D-IB13 (três fatos datados: leiaute, obrigação, rejeição) · D-IB34 (linha que só vale depois do faturamento: antes da obrigação a
nota sai sem o grupo, nunca 422 — inclusive no lote mensal; depois, 422) · D-IB35 (a data da obrigação passa a vir do enquadramento
datado) · D-IB40 (NBS sem presença barra o faturamento; regra única `nbsAcceptedSql` da peça) · D-IB41 (linha vigente SEM presença = mesmo
caminho da D-IB34; `acceptedToday` é sinal de CADASTRO, nunca decide o faturamento; a nota congelada nunca reconsulta o catálogo) ·
D-IB47 (a pergunta do faturamento é o VEREDITO da peça na data do fato — `classificationVerdictAt`/`classificationVerdictsAt` (lote),
com o MOTIVO `no-line`/`not-applicable`/`requires-regular` para o 422 legível; a MESMA que a carga do catálogo usa no impacto; o selo
usa `classificationAcceptedForRegistration`; "aceito" = `verdictOf`, UMA definição — nunca re-derivar `applicable && !requiresRegular`) ·
limite TOCTOU do §11.8 (PUT que leu o catálogo antes de uma carga pode gravar código que acabou de perder a presença — a IB-2 barra) ·
limite do §11.11 (excluir o serviço não mata a peça 1:1 `tb_service_ibscbs` — todo leitor exige o produto vivo) · **D-IB52 (PRÉ-VOO do
faturamento antes de 01/01/2027: listar, por schema, os serviços cuja classificação gravada a data do fato JÁ recusa — o "estoque" que o
impacto da carga não mostra, inclusive a sobreposição em que o selo diz "aceita"; uma consulta por schema pela pergunta da peça —
`classificationVerdictsAt` — antes de ligar a barreira; D-IB55: pergunta NA DATA DA OBRIGAÇÃO — depois dela, na competência a
faturar — e mostra ao lado o veredito de HOJE e o selo do cadastro: "recusa hoje → a nota sai sem o grupo" × "recusa na obrigação → vai
dar 422")** · D-IB42 (calendário
da barreira da NBS: antes da obrigação a nota sai SEM o `cNBS`, nunca 422 — inclusive no lote; depois, 422 também para NBS ausente do
catálogo — §11.16). Fato de 2026-10-11: hoje NINGUÉM preenche o `cNBS` do DPS (os dois montadores têm o campo; nenhum produtor) — a
IB-2 congela a NBS no ramo e a IB-3 a leva ao DPS.

## 5. Fora de escopo desta fase (1º release — sujeito à Q-IB17)

Notas de ajuste (finNFSe 1/2 — Q-RTC6; finNFe 5/6 — D-NE47) · compra governamental/`tpEnteGov` (salvo Q-IB18) · imóveis/locação ·
`gReeRepRes`/`vAjusteBC` · `gDif` · `cCredPres` · ZFM/ALC · eventos RTC (15 da NF-e, via SVRS) · `gPgtoVinc` e split payment (NT 2026.006)
· estorno de crédito no cancelamento (LC 214 art. 47 §§ 8º/12) · CNPJ alfanumérico (frente própria — D-NE29) · NF-e em produção (F4).

## 6. Critérios de sucesso (testáveis)

1. Catálogo central carregado da fonte oficial; a 2ª carga (versão nova) AGREGA sem apagar; estrutura oficial mudada = falha alta.
2. Serviço sem classificação após a data da obrigação → 422 legível no faturamento; classificação inválida para serviço (flags E0958/E0959)
   → 422 antes de faturar — nunca chega ao fisco.
3. Nota de competência 12/2026 transmitida em 01/2027 sai com o enquadramento da COMPETÊNCIA.
4. Billing e OS congelam a classificação pela MESMA função; DPS com o grupo valida no XSD 1.01; produção restrita autoriza; a voz com os
   valores é lida, guardada write-once e exibida no DANFSe; nenhuma escrita da nfse-api no ERP.
5. O grupo liga por data/ambiente sem deploy no dia; a NT 009 entra agregando (linha nova no calendário), sem reforma.
6. Gates socrático ≥ 0.70 e adversarial sem HIGH (corridas: carga do catálogo × faturamento; troca de enquadramento × transmissão em voo).

## 7. ⚠️ Rodada 1 — questões para o Valdo (recomendação entre parênteses)

**A. Prazo externo e negócio**

- **Q-IB1 Regime de IBS/CBS da Setes em 2027 — PRAZO 30/10/2026.** (a) não optar: IBS/CBS no DAS (`regApIBSCBSSN` 1) · (b) regime regular
  de ambos (3) · (c) só CBS regular (2). *(Decisão de NEGÓCIO, com o contador — o tomador PJ que compra de optante no DAS credita só "o
  equivalente ao devido" (LC 214 art. 47 § 9º). Para o SISTEMA, (a) é o caminho mais curto: classificação + voz, título sem mudança se
  `vTotNF = vLiq` (Q-IB12); (b)/(c) antecipam a porta de cálculo (Q-IB11) para dezembro. O modelo datado (Q-IB7) atende qualquer resposta.)*
- **Q-IB2 Alvo legal.** (a) **emitir com o grupo desde a competência 01/2027 por obrigação do Ato nº 4 § 1º, rejeite a Sefin ou não** ·
  (b) só quando a Sefin passar a rejeitar. *(Rec.: (a) — a ausência é desconformidade; em 2026 gera intimação.)*
- **Q-IB3 Legado (§0 item 2).** (a) **patch no Gestao2016 que impede ligar a chave enquanto os valores forem de exemplo + conferir se algum
  cliente ligou** · (b) só conferir os clientes. *(Rec.: (a) — um clique manda valores falsos ao fisco; ato no SVN do legado, fora deste repo.)*

**B. Modelo (parecer do guardião)**

- **Q-IB4 `tb_taxes_id` — DIVERGE da D23(f) do faturamento** (`prompt_fase_faturamento_financeiro.md:741`, que ratificou a coluna no
  seletor). (a) **peça 1:1 de classificação, sem `tb_taxes`, sem alíquota na regra, DROP de `tb_taxes_id` em `tb_tax_rule` e
  `tb_service_tax_rule`** · (b) manter a D23(f). *(Rec.: (a) — a `TB_TAXES` do legado é maquete (alíquota por regra sem dimensão de
  destino); pré-condição: o grupo do sync confirmar que nenhum endpoint grava a coluna.)*
- **Q-IB5 Catálogo (= Q-RTC1).** (a) **referência central em `setes_central`: CST (pai) + cClassTrib (filho, PK `(code, valid_from)`, flags
  tipadas com consumidor, `source_version`); carga por rotina do Super a partir dos dados abertos da Calculadora; linha nunca apagada** ·
  (b) catálogo por versão com ponteiro "vigente" · (c) consulta online a cada nota. *(Rec.: (a).)*
- **Q-IB6 Classificação do serviço (= Q-RTC3).** (a) **peça 1:1 `tb_service_ibscbs` (cClassTrib + cIndOp ESCOLHIDOS) + `nbs` em
  `tb_service` com referência `tb_nbs`** · (b) na regra de ISS · (c) família de regra nova por NBS. *(Rec.: (a); exceções por operação —
  exportação, ente público — entram depois como escolha por item, sem reforma.)*
- **Q-IB7 Enquadramento do emitente com vigência (≈ Q-RTC5).** (a) **`tb_establishment_tax_regime` (institution × `valid_from`) com o
  enquadramento INTEIRO (opSimpNac — com o 4 "pendente" —, regApTribSN, regApIBSCBSSN), resolvido pela data de competência; colunas
  migradas de `tb_entity_tax`; CRT DERIVADO; `pTotTribSN` segue coluna; `cAtvSN` no SERVIÇO quando a NT 009 tiver XSD** · (b) só o
  regApIBSCBSSN com vigência · (c) coluna editada na virada. *(Rec.: (a) — o oficial não tem cClassTrib do Simples (só `tpRBSN`): a
  classificação é do serviço, o regime é do emitente.)*
- **Q-IB8 Ausência de classificação depois da data da obrigação.** (a) **422 no faturamento** · (b) fatura e omite o grupo · (c) fatura com
  aviso. *(Rec.: (a) — obrigação legal.)*
- **Q-IB9 Congelamento.** (a) **NFS-e: colunas no ramo `tb_invoice_service` (`classification_code`, `place_indicator_code`, `nbs`; CST e
  `indDest` derivados) gravadas por UMA função da peça, chamada pelos dois produtores (billing e OS); NF-e (F4): `tb_order_item_ibscbs` com
  PK SEM `kind`, como os 7 snapshots irmãos — condicionado ao id do item ser único por ordem em todo produtor (o grupo do sync confirma)** ·
  (b) snapshot por item também na NFS-e · (c) NF-e com `kind`, reformando os irmãos. *(Rec.: (a).)*

**C. Valores, cálculo e títulos**

- **Q-IB10 Valores devolvidos pelo fisco (= Q-RTC4).** (a) **voz no `fiscal_api` — peça 1:1 da tentativa que obteve a NFS-e, write-once,
  lida do XML autorizado — + VIEW para o setes-api (D-F11/D-F15)** · (b) cópia no ERP · (c) só no XML. *(Rec.: (a).)*
- **Q-IB11 Cálculo.** (a) **porta `@shared/ibscbs-calculation` no setes-api com a Calculadora oficial atrás (versão offline embarcada —
  prova de conceito antes, topologia D-F9); só nasce com consumidor (NF-e do regime regular ou Q-IB1 (b)/(c))** · (b) motor próprio no
  `@shared/tax-rule` (como o legado) · (c) API online beta a cada nota. *(Rec.: (a) — é o mesmo motor que o fisco usa para conferir.)*
- **Q-IB12 Títulos × `vTotNF`.** (a) **título nasce do total do ERP; com tributo "por fora", o valor vem da porta de cálculo e a voz
  confere (R$ 0,01); divergência = pendência visível + ato manual, nunca UPDATE do título** · (b) título só depois da autorização (muda o
  processo de faturamento). *(Rec.: (a); antes da Q-IB1, confirmar com o contador se no DAS `vTotNF = vLiq` — a NT 009 (vIBSTot/vCBS
  opcionais + `gTribSN`) é indício, não prova.)*

**D. Leiaute, calendário e entrega**

- **Q-IB13 Três fatos datados (absorve a D-NE31).** (a) **leiaute = constante datada do adaptador (ambiente × `valid_from`), por deploy
  ANTES da data; obrigação legal = constante da peça de classificação (decide o 422 da Q-IB8); rejeição = do fisco, não modelada; envio
  voluntário = presença da classificação, sem chave** · (b) chave por estabelecimento (como o legado). *(Rec.: (a).)*
- **Q-IB14 NT 009 sem XSD.** (a) **implementar o 1.01 agora (classificação) e a NT 009 quando o XSD existir (agrega: linha no calendário +
  dados já cadastrados); se até 01/12 não houver XSD em produção restrita, a Setes entra em 2027 com o 1.01** · (b) esperar a NT 009.
  *(Rec.: (a).)*
- **Q-IB15 Dual-run (D-F43).** (a) **F2a (virada) antes de dezembro e o builder do grupo só na nfse-api; data de corte 30/11 — se a F2a
  não tiver virado, cair para (b)** · (b) implementar o grupo nas DUAS cópias do montador. *(Rec.: (a) com o corte.)*
- **Q-IB16 Prova antes do prazo.** (a) **produção restrita assim que o builder existir + envio VOLUNTÁRIO em produção em dezembro
  (competência 2026 já aceita o grupo — E0850)** · (b) só produção restrita · (c) direto em janeiro. *(Rec.: (a).)*

**E. Escopo e pendências pequenas**

- **Q-IB17 Escopo do 1º release.** (a) **NFS-e regular (finNFSe 0) da Setes no Simples + voz + DANFSe com o bloco; o resto no §5** ·
  (b) incluir já as notas de ajuste. *(Rec.: (a).)*
- **Q-IB18 Tomador ente público** (`tpEnteGov` + `tpOper` obrigatórios, `pRedutor` na NFS-e). (a) **levantar na IB-0 se a Setes tem
  tomador público; entra no 1º release só se tiver** · (b) entra sempre · (c) fora. *(Rec.: (a).)*
- **Q-IB19 `tpRetPisCofins` (NT 007).** **registrar como conhecimento negativo: nunca emitir 1/2 (suprimidos quando o grupo for
  obrigatório); PIS/COFINS/CSLL retidos somados em `vRetCSLL`.** *(Rec.: sim; nada a codificar hoje.)*
- **Q-IB20 D-NE18 revisitada** (NT 2026.007: NF-e SEM IE para contribuinte exclusivo de IBS/CBS, produção 03/11/2026). *(Rec.: conferir
  na NE-0 se a Setes pode autorizar NF-e em H; a D-NE18 não muda até lá.)*
- **Q-IB21 Arquivar os oficiais novos** (IT 2025.002 v1.70 com a tabela cClassTrib, Anexo VII v1.03.00, Anexo VI v1.04.01, NT 009 v1.01,
  Atos Conjuntos nº 4/5/6, NT 2025.002 v1.52, Manual do CGSN de 07/10/2026). (a) **baixar na IB-0 para `Infra-IA/nfse-api/integracoes/`
  (movendo o `nfse-adn` — D-NE19) e `Infra-IA/nfe-api/integracoes/nfe-sefaz/`, com data e URL de cada um** · (b) só links. *(Rec.: (a) — o
  acervo da NFS-e já mostrou que FAQ e README divergem do Ato; documento datado no disco é a prova.)*

## 8. Decisões registradas

**Rodada 1 DECIDIDA (Valdo 2026-10-10: "siga as recomendações").** Cada D-IB*n* = a recomendação da Q-IB*n* (§7), na íntegra. Numeração
permanente; DDL, código e testes citam o nº.

| Decisão | O que fixa | Onda |
|---|---|---|
| **D-IB1** | o sistema segue o **efeito legal de NÃO optar**: IBS/CBS no DAS (`regApIBSCBSSN` 1). ⚠️ **A opção pelo regime regular (b)/(c) segue com o Valdo e o contador até 30/10/2026** (CGSN 194) — "siga as recomendações" não é a escolha de negócio; se optar, a porta de cálculo (D-IB11) e a conferência de títulos (D-IB12) antecipam para dezembro, e o enquadramento datado (D-IB7) recebe a linha a partir de 01/01/2027 | IB-0 |
| **D-IB2** | emitir com o grupo desde a competência 01/2027 por obrigação do Ato nº 4 § 1º, rejeite a Sefin ou não | IB-3/IB-4 |
| **D-IB3** | patch no Gestao2016 que impede ligar "Ativar Reforma Tributária" enquanto a NFS-e tiver valores de exemplo + conferir se algum cliente ligou — **ato do Valdo no SVN do legado** (fora deste repositório; compilação Delphi). **PATCH COMMITADO no SVN em 2026-10-10 — r1300** (só `Ajuda\un_geranfe_Srv.pas` + `CLAUDE.md`; a cópia de trabalho tinha 14 alterações alheias, intocadas): a mesma chave `GRL_G_REF_TRIBUTARIA` liga também o IBS/CBS da NF-e/NFC-e (`un_geranfe3X.pas:899…3436`, `componentes\tributacao.pas:2530`) — travá-la cortaria a NF-e do regime regular; por isso o mecanismo virou **"a chave não liga mais o grupo na NFS-e"**: chamada de `CarregaDadosReformaTributaria` comentada em `Ajuda\un_geranfe_Srv.pas` (+9 linhas, UTF-8 com BOM e CRLF preservados, 0 U+FFFD); compilado em cópia descartável (0 erros; `Gestao.res` restaurado; exe de `D:\Modelos` intocado); Decisão Canônica Nº 4 no `D:\Gestao2016\CLAUDE.md` com o SQL de conferência nos clientes. **Conferência DISPENSADA pelo Valdo (2026-10-10)**: nenhum cliente de serviço emitiu com a reforma; só alguns clientes de NF-e usam a chave (assunto interno de cada cliente). Falta só a versão aos clientes | legado |
| **D-IB4** | peça 1:1 de classificação, sem `tb_taxes`, sem alíquota na regra; **DROP de `tb_taxes_id`** em `tb_tax_rule` e `tb_service_tax_rule` — **SUPERA em parte a D23(f)** de `prompt_fase_faturamento_financeiro.md`; **pré-condição**: o grupo do sync confirmar que nenhum endpoint grava a coluna (tarefa no grupo dele — regra dos dois grupos) | IB-1 |
| **D-IB5** | catálogo = referência central em `setes_central`: CST (pai `tb_tax_ibscbs`) + cClassTrib (filho `tb_tax_ibscbs_classification`, PK `(code, valid_from)`, flags tipadas só com consumidor, `source_version`/`source_updated_at`); carga por rotina do Super a partir dos dados abertos da Calculadora, falhando alto se a estrutura mudar; linha nunca apagada | IB-1 |
| **D-IB6** | classificação do serviço em peça 1:1 `tb_service_ibscbs` (cClassTrib + cIndOp ESCOLHIDOS; o Anexo VIII só sugere) + `nbs` em `tb_service` com referência `tb_nbs`; referência `tb_ibscbs_place_indicator` (Anexo VII); nunca na regra de ISS | IB-1 |
| **D-IB7** | enquadramento do emitente datado `tb_establishment_tax_regime` (institution × `valid_from`) com opSimpNac (inclui 4 "pendente"), regApTribSN e regApIBSCBSSN, resolvido pela data de COMPETÊNCIA; colunas migradas de `tb_entity_tax`; CRT DERIVADO; `pTotTribSN` segue coluna; `cAtvSN` no serviço quando a NT 009 tiver XSD | IB-1 |
| **D-IB8** | sem classificação depois da data da obrigação → 422 no faturamento | IB-2 |
| **D-IB9** | NFS-e: colunas no ramo `tb_invoice_service` (`classification_code`, `place_indicator_code`, `nbs`; CST e `indDest` derivados) gravadas por UMA função da peça `@shared/ibscbs-classification`, chamada por billing E OS; NF-e (F4): `tb_order_item_ibscbs` com PK SEM `kind` como os irmãos (condicionado ao id do item único por ordem em todo produtor — o grupo do sync confirma) | IB-2 / F4 |
| **D-IB10** | valores do fisco = voz no `fiscal_api` (`tb_invoice_service_transmission_ibscbs`, 1:1 da tentativa, write-once, lida do XML autorizado) + VIEW para o setes-api; nunca cópia no ERP | IB-3 |
| **D-IB11** | cálculo = porta `@shared/ibscbs-calculation` no setes-api com a Calculadora oficial atrás (offline embarcada, prova de conceito antes, topologia D-F9); só nasce com consumidor (NF-e do regime regular ou opção (b)/(c) da D-IB1); motor próprio NUNCA | IB-N |
| **D-IB12** | título nasce do total do ERP; com tributo "por fora" o valor vem da porta de cálculo e a voz confere (R$ 0,01); divergência = pendência visível + ato manual, nunca UPDATE do título; **conferir com o contador se no DAS `vTotNF = vLiq`** | IB-3 / IB-N |
| **D-IB13** | três fatos datados: leiaute = constante datada do adaptador (ambiente × `valid_from`, deploy ANTES da data — absorve a D-NE31); obrigação legal = constante da peça de classificação (decide o 422 da D-IB8); rejeição = do fisco, não modelada; envio voluntário = presença da classificação, sem chave | IB-2/IB-3 |
| **D-IB14** | 1.01 agora (classificação); NT 009 quando o XSD existir, agregando; sem XSD em produção restrita até 01/12, a Setes entra em 2027 com o 1.01 | IB-3/IB-5 |
| **D-IB15** | F2a (virada) antes de dezembro e o builder do grupo SÓ na nfse-api; **corte 30/11/2026** — se a F2a não tiver virado, o grupo entra nas DUAS cópias do montador (D-F43) | IB-3 |
| **D-IB16** | produção restrita assim que o builder existir + envio VOLUNTÁRIO em produção em dezembro (competência 2026 já aceita — E0850) | IB-4 |
| **D-IB17** | 1º release = NFS-e regular (finNFSe 0) da Setes no Simples + voz + DANFSe com o bloco; o resto no §5 | — |
| **D-IB18** | levantar na IB-0 se a Setes tem tomador ente público; `tpEnteGov`/`tpOper` só entram se tiver | IB-0 |
| **D-IB19** | conhecimento negativo: nunca emitir `tpRetPisCofins` 1/2; PIS/COFINS/CSLL retidos somados em `vRetCSLL` (NT 007) | IB-3 |
| **D-IB20** | NE-0 confere se a Setes pode autorizar NF-e em H pela NT 2026.007 (NF-e sem IE para contribuinte exclusivo de IBS/CBS, 03/11/2026); a D-NE18 não muda até lá | NE-0 |
| **D-IB21** | arquivar os oficiais novos na IB-0 (IT 2025.002 v1.70, Anexo VII v1.03.00, Anexo VI v1.04.01, NT 009 v1.01, Atos Conjuntos 4/5/6, NT 2025.002 v1.52, Manual do CGSN) em `Infra-IA/nfse-api/integracoes/` (movendo o `nfse-adn` — D-NE19) e `Infra-IA/nfe-api/integracoes/nfe-sefaz/`, com data e URL de cada um — cada download pedido ao Valdo com nome, origem e tamanho | IB-0 |

**Próximos passos (ordem)**: (1) **Valdo + contador: opção de regime até 30/10** (D-IB1) e **distribuição do patch do legado (r1300)
aos clientes** (D-IB3 — conferência dispensada) · (2) **IB-0**:
arquivar os oficiais (D-IB21), levantar cIndOp exato da Setes pelo Anexo VII e tomador público (D-IB18), pedir ao grupo do sync a
confirmação sobre `tb_taxes_id` e o id do item (D-IB4/D-IB9), parecer do guardião sobre o DDL + `revisar-ddl` · (3) IB-1…IB-4 em
série com a F2a (corte 30/11 — D-IB15). Nenhuma questão da fase está aberta.

## 9. Correções de documentação achadas (sem decisão — feitas nesta rodada)

- "Até 31/12/2026 a ausência não rejeita" **não está no Ato nº 4**: a não-rejeição hoje é por tempo indeterminado (NF-e: "implementação
  futura"; NFS-e: grupo opcional no XSD) e 31/12/2026 é o prazo de RETIFICAÇÃO do programa de conformidade do Ato nº 5 (de 12/08/2026,
  publicado no site do CGIBS em 13/08). Marcado em `prompt_onda3_nfse_adn.md` (nota da D-N14).
- `Infra-IA/setes-api/integracoes/nfse-adn/README.md:96` repete a redação errada da FAQ 15.1 ("SN optante pelo destaque") — marcado. A FAQ
  também erra na 15.3 (`gDevTrib`/`gDeson` não existem no XSD da NFS-e) e na 20.2 (E1302/E1307 são de MEI, não de ME/EPP).
- `Infra-IA/nfe-api/referencia-acbr/00-INDEX.md`: a pergunta "qual revisão do ACBr o legado compila" está respondida — revisão **47865
  (19/08/2026)**, posterior ao revert/reintrodução de 28/07/2026.

## 10. IB-0 — EXECUTADA (2026-10-10)

### 10.1 Fatos levantados

1. **D-IB3 fechada**: patch do legado commitado (SVN r1300); conferência nos clientes DISPENSADA pelo Valdo — nenhum cliente de serviço
   emitiu com a reforma; só alguns clientes de NF-e usam a chave (assunto interno de cada um). Falta só a versão aos clientes.
2. **D-IB18 — tomador ente público: NENHUM.** Varredura por nome (somente leitura) nos 235 tomadores das 6.861 notas de serviço da Setes:
   o único acerto ("AUTO ELETRICA UNIAO") é falso positivo. `tpEnteGov`/`tpOper` ficam fora do 1º release.
3. **Notas de serviço no banco da Setes**: 7.074 ramos `tb_invoice_service`, dos quais ~7.064 vieram do legado pelo sync (sem item/código
   nacional) e só os nativos da web (desde 21/09/2026) têm subitem 1.02 / `010201`.
4. **Calculadora oficial — API pública de dados abertos** (`https://consumo.tributos.gov.br/servico/calcular-tributos-consumo/api`, OpenAPI
   em `/api-docs`, tags "VERSÃO BETA"): lista de cClassTrib por DATA (`/calculadora/dados-abertos/classificacoes-tributarias/cbs-ibs?data=`
   → **161 códigos vigentes em 01/01/2027**, com flags, reduções e `tiposDfeClassificacao`, **sem `dIniVig`/`dFimVig`** — a vigência vem do
   parâmetro); flags POR PAR cClassTrib × documento (`/classificacoes-tributarias/cbs-ibs/{sigla}/{cClassTrib}?data=` → válido,
   `exigeGrupoTributacaoRegular`, `permiteDiferimento`, `possibilidadeCreditoPresumido`); NBS (`/dados-abertos/nbs/lista`, 920 códigos);
   cIndOp por NBS (`/calculadora/nfse/indicador-operacao?nbs=`) — às vezes VÁRIOS; classificações por NBS
   (`/calculadora/nfse/situacoes-classificacoes-tributarias?nbs=`); alíquotas por UF/município/União por data.
5. **A Setes, conferido na fonte**: para as NBS de desenvolvimento (1.1502.10/20/90), manutenção (1.1508.00), SaaS (1.1506.21) e licenciamento
   (1.1103.22) a classificação aceita em 2027 é só **CST 000 / cClassTrib 000001**; para 000001 na NFS-e: válido, NÃO exige tributação
   regular, NÃO permite diferimento, sem crédito presumido. cIndOp: **100301** (serviço oneroso — domicílio do adquirente) para
   desenvolvimento/manutenção/SaaS; **100501** para licenciamento; suporte em TI admite 050101/050102/100301. Anexo VIII: **01.02
   Programação → 1.1502.10.00/.20.00/.90.00 → 100301 → 000001**. → o DPS da Setes levará `finNFSe 0 · cIndOp 100301 · indDest 0 · CST 000 ·
   cClassTrib 000001` (confirma a inferência do §1.2).
6. **NBS por serviço = dado de CADASTRO da Setes (Valdo + contador)** — 34 serviços; os de uso real: mensalidade (7.097 usos), atendimento de
   suporte, instalação, implementação, desenvolvimento, treinamento, hospedagem (e-mail/sistema/website). Hoje TODOS usam a mesma regra de
   ISS (subitem 1.02); o Anexo VIII associa licenciamento a 01.05, suporte a 01.07 e hospedagem a 01.03 — coerência fiscal a conferir com o
   contador (não é decisão de sistema; a tela da IB-1 recebe a NBS e a classificação por serviço).
7. **Documentos oficiais ARQUIVADOS** (autorizados): `Infra-IA/setes-api/integracoes/nfse-adn/rtc-2026-10/` (NT 009 v1.01, Anexos VI v1.04.01,
   VII v1.03.00, VIII v1.01.00, NT 010 v1.00 "NFS-e Via") e `…/legislacao-ibs-cbs/` (Atos Conjuntos 4 e 5, Manual do CGSN de 07/10/2026) —
   cada pasta com README (URL, bytes, SHA-256). Casa = junto do `nfse-adn` (decisão do Valdo na IB-0; a mudança de casa da D-NE19/D-IB21
   vira tarefa mecânica separada — toca 15 arquivos, inclusive comentários em 6 fontes). **Não arquivado**: IT 2025.002 v1.70 (PDF 4,7 MB —
   fonte de `dIniVig`/`dFimVig`; Q-IB23). O gov.br recusa HEAD/sem User-Agent (403); o portal da NF-e exige cookie de sessão.
8. **Pedido ao grupo do sync** aberto como tarefa separada (pré-condições D-IB4/D-IB9; o guardião pede também: o sync não faz DELETE físico
   nem REPLACE em `tb_service`/`tb_invoice_service` e não grava `simples_*` em `tb_entity_tax`).

### 10.2 DDL da IB-1 — rascunho

`prompt_fase_ibs_cbs-ddl-ib1-rascunho.sql` (ao lado deste prompt; sqlglot OK, 11 comandos; NÃO executado): A — central `tb_tax_ibscbs`,
`tb_tax_ibscbs_classification` (PK `(code, valid_from)`), `tb_tax_ibscbs_classification_model` (flags por par), `tb_ibscbs_place_indicator`,
`tb_nbs`; B — cliente: `tb_service.nbs` (FK central), `tb_service_ibscbs` (1:1), `tb_establishment_tax_regime` (+ backfill), colunas
congeladas em `tb_invoice_service`, DROP de `tb_taxes_id` em migration separada; C — `fiscal_api`: `tb_invoice_service_transmission_ibscbs`.

### 10.3 Parecer do guardião + checklist `revisar-ddl` (2026-10-10; consultas só de leitura no dev — MariaDB 10.4.20)

Arranjo aprovado no essencial. **Correções de checklist (sem decisão — entram na versão final)**: (1) B1 não re-executável — FK num ALTER
separado (molde 058:34-36); (2) DDL central em script numerado do `sql/` aplicado ANTES do setes-api, e a migration confere a existência
das tabelas centrais com erro legível (senão errno 150); (3) C1 ganha `updated_at`/`deleted` (PADROES §3 — a voz append-only do `fiscal_api`
tem); (4) C1 ganha a VIEW (D-IB10) + linha no `nfse-api/ops/grants.sql` + EXPLAIN (PADROES §11); (5) backfill com `INSERT … WHERE NOT
EXISTS`, nunca `INSERT IGNORE` (o dev roda SEM modo estrito: `@@sql_mode = IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,
NO_ENGINE_SUBSTITUTION`); (6) o loader confere forma/tamanho antes de gravar (sem modo estrito, VARCHAR/CHAR truncam em silêncio); (7) flags
`NOT NULL` SEM default (ausência ≠ "não exige"); (8) CST = prefixo garantido por construção (Q-IB26); (9) domínios fechados (modelo,
opSimpNac 1–4, regApTribSN/regApIBSCBSSN 1–3) por CHECK (Q-IB26); (10) o "precedente dos CSTs da 025" no rascunho está ERRADO — a 025 ficou
sem FK por COLLATION (`025_tax_rule_family.sql:45-47`), não por PK composta; (11) colunas novas em `tb_invoice_service` (tabela
**general_ci**) × catálogo central unicode_ci → Q-IB25; (12) B3 ganha `tb_user_id` (fato editado por gente — precedente
`tb_establishment_issuer`); (13) blocos A/B vão aos canônicos `sql/01`/`sql/03`.

**Ajustes de conceito**: (a) `_classification_model` é peça certa (vínculo catálogo × modelo, presença = aceita no documento) mas o nome
lê como "molde" → **`tb_tax_ibscbs_classification_applicability`**; só `requires_regular_taxation` tem consumidor (vira guarda 422 —
o builder não emite `gTribRegular`); `allows_deferral`/`allows_presumed_credit` SAEM (gDif/cCredPres estão no §5); CHECK SE/55/65 e carga só
de SE agora (55/65 entram como DADO na F4); (a.iv) **achado**: o Anexo VII também tem aplicabilidade por documento para o cIndOp
(`indNFe`/`indNFSe`/`indNFSe Via`) e o local de incidência é atributo do par (`NFSeLocIncidIBS`) → `tb_ibscbs_place_indicator_applicability
(code, model)`, `incidence_place` sai do A4; (d) `tax_regime` (CRT) NÃO sai de `tb_entity_tax` — a tabela é por relação entity ×
institution e o CRT do DESTINATÁRIO alimenta o seletor da regra (`billing.service.ts:113,125`); o "CRT derivado" da D-IB7 vale SÓ para a
linha do emitente; migração em expand/contract (a 066 cria + backfill; no mesmo deploy o establishment grava SÓ na peça e os dois leitores —
`fiscal-api/src/erp/facts.ts:237-252` e a cópia do dual-run `setes-api/src/shared/invoice-transmission/branches/service.ts:196-208` — leem
por competência; DROP das colunas em migration separada que confere coluna = linha vigente); backfill `valid_from = 2000-01-01` aceitável
como CONVENÇÃO nomeada na peça (o cancelamento/consulta de nota antiga também monta o emitente); (e) NBS como coluna de `tb_service` está
certo; a correlação do Anexo VIII fica FORA (só sugestão, sem regra ligada); (f) a voz C1 está conforme a §11 no conceito.

### 10.4 Rodada 2 — questões para o Valdo (DECIDIDA em 2026-10-10 — §10.5)

- **Q-IB22 Identidade × vigência do cClassTrib** (diverge da letra da D-IB5). (a) manter PK `(code, valid_from)` e validar a existência na
  peça · (b) **dividir: `tb_tax_ibscbs_classification` (PK `code`, CST com CHECK = prefixo) + `tb_tax_ibscbs_classification_validity`
  (`code`, `valid_from`, `valid_until`, descrição, `source_*`), com a aplicabilidade pendurada na validity**. *(Rec.: (b) — o serviço presume
  o CÓDIGO, não a versão; ganha FK física agora e a regra de mercadoria (F4) agrega sem reforma; padrão identidade × história da casa.)*
- **Q-IB23 Fonte da vigência** (diverge da letra da D-IB5). (a) **IT 2025.002 (PDF v1.70 arquivado; ou a SVRS se expuser a vigência em
  formato de máquina) para identidade + vigência; API da Calculadora para aplicabilidade/flags por par consultadas na data `valid_from`;
  divergência entre as fontes = carga recusada inteira** · (b) só a API, `valid_from` = data da carga (inventa) · (c) sondar datas na API.
  *(Rec.: (a); pede o download do IT v1.70 — PDF 4,7 MB, nfe.fazenda.gov.br.)*
- **Q-IB24 CRT derivado × D42.** (a) **derivado só para o EMITENTE; `tax_regime` fica para as demais relações; a tabela opSimpNac ×
  regApTribSN → CRT 1/2/3/4 é confirmada com o contador; se o excesso de sublimite não for derivável, a peça ganha o FATO (`sublimit_exceeded`),
  nunca o código CRT; troca de GRUPO de CRT só com `valid_from` ≤ hoje (a D42 segue no ato)** · (b) CRT continua coluna livre do emitente.
  *(Rec.: (a).)*
- **Q-IB25 Collation das colunas novas em `tb_invoice_service` (general_ci).** (a) **`COLLATE utf8mb4_unicode_ci` POR COLUNA + regra nova na
  PADROES §5 ("coluna nova que referencia catálogo central nasce unicode_ci mesmo em tabela general_ci")** · (b) herdar general_ci e COLLATE no
  JOIN. *(Rec.: (a).)*
- **Q-IB26 CHECK no schema do cliente** (domínios do enquadramento, modelo, flags S/N, CST = prefixo). (a) **adotar, com conferência no boot
  do setes-api de que o motor aplica CHECK (molde D-F45)** · (b) só a peça. *(Rec.: (a) — sem modo estrito, o CHECK é a única guarda contra a
  carga e SQL direto.)*
- **Q-IB27 Voz dos valores no fallback da D-IB15** (grupo nas duas cópias se a F2a não virar até 30/11). (a) **nota transmitida pelo
  setes-api guarda só o XML em disco; o `migrate:setes` da virada lê o grupo do XML e grava a voz no `fiscal_api`** · (b) tabela gêmea
  temporária no ERP. *(Rec.: (a) — o XML é o snapshot; a gêmea seria uma segunda verdade.)*

**Fora da rodada (dado de cadastro)**: NBS e classificação de cada serviço da Setes — Valdo + contador (§10.1 item 6).
**Próximo**: Rodada 2 → versão final do DDL (correções do §10.3) → IB-1.

### 10.5 Rodada 2 DECIDIDA (Valdo 2026-10-10: "siga as recomendações e pode baixar o IT") — D-IB22…D-IB27

Cada D-IB*n* = a recomendação da Q-IB*n* (§10.4). Numeração permanente (continua o §8).

| Decisão | O que fixa |
|---|---|
| **D-IB22** | cClassTrib em DUAS peças: **identidade** `tb_tax_ibscbs_classification` (PK `code`, CST com CHECK = prefixo) + **história** `tb_tax_ibscbs_classification_validity` (`code`, `valid_from`, `valid_until`, nome, descrição, `requires_regular_taxation`, `source_*`); aplicabilidade pendurada na validity — o serviço (e a regra de mercadoria na F4) ganham FK física ao CÓDIGO. **Ajusta a letra da D-IB5** (PK `(code, valid_from)` vira a da história) |
| **D-IB23** | fonte da vigência = **o IT 2025.002**; API da Calculadora = conferência; divergência = carga recusada inteira. **Refinada pelo FATO** (planilha baixada — `…/nfse-adn/classificacao-ibs-cbs/`): a tabela oficial `IT 2025.002 v.1.70 - cClassTrib.xlsx` já traz identidade, `dIniVig`/`dFimVig`, **`ind_gTribRegular` por CLASSIFICAÇÃO** (não por par) e a aplicabilidade por documento (`indNFSe`/`indNFe`/`indNFCe`) como presença — a planilha é a fonte de TUDO isso, a API só confere. Consequência no DDL: a flag mora na validity, e a aplicabilidade é só presença |
| **D-IB24** | CRT DERIVADO só para o EMITENTE; `tb_entity_tax.tax_regime` fica (serve ao destinatário); a tabela opSimpNac × regApTribSN → CRT 1/2/3/4 é confirmada com o contador; excesso de sublimite não derivável = FATO na peça (`sublimit_exceeded`), nunca o código CRT; troca de GRUPO de CRT só com `valid_from` ≤ hoje (a D42 segue no ato) |
| **D-IB25** | coluna nova que referencia catálogo central nasce `COLLATE utf8mb4_unicode_ci` POR COLUNA, mesmo em tabela general_ci — regra nova na `database/PADROES_BANCO.md` §5 |
| **D-IB26** | CHECK no schema do cliente e nas referências (domínios do enquadramento, modelo SE/55/65, flags S/N, CST = prefixo, formato dos códigos), com conferência no boot do setes-api de que o motor aplica CHECK (molde D-F45) |
| **D-IB27** | no fallback da D-IB15 (grupo nas duas cópias se a F2a não virar até 30/11), a nota transmitida pelo setes-api guarda só o XML; o `migrate:setes` da virada lê o grupo do XML e grava a voz no `fiscal_api` — nunca tabela gêmea no ERP |

**Download autorizado e feito**: `Infra-IA/setes-api/integracoes/nfse-adn/classificacao-ibs-cbs/` — IT 2025.002 v1.70 (PDF, documentação) +
a tabela `IT 2025.002 v.1.70 - cClassTrib.xlsx` (173 códigos; 73 aceitos na NFS-e; 31 exigem tributação regular), com README.

**DDL da IB-1 — versão 2** (`prompt_fase_ibs_cbs-ddl-ib1-rascunho.sql`, sqlglot OK, 18 comandos; NÃO executado): aplica D-IB22…D-IB27 e as 13
correções do §10.3 — A1 `tb_tax_ibscbs` · A2 `_classification` (identidade) · A3 `_classification_validity` (história + `requires_regular_taxation`)
· A4 `_classification_applicability` (presença por modelo) · A5 `tb_ibscbs_place_indicator` · A6 `_place_indicator_applicability` · A7 `tb_nbs`;
B0 conferência legível das referências · B1 `tb_service.nbs` + FK em ALTER separado · B2 `tb_service_ibscbs` (FK física ao código) · B3
`tb_establishment_tax_regime` + CHECKs + `tb_user_id` · B3.1 backfill `WHERE NOT EXISTS` (piso 2000-01-01 como convenção nomeada) · B4 colunas
unicode_ci POR COLUNA em `tb_invoice_service` · B5 migrations separadas (DROP `tb_taxes_id` após o sync; contract do `simples_*`; boot confere
CHECK); C1 voz com `updated_at`/`deleted` · C2 VIEW + GRANT. A execução real no MariaDB acontece na IB-1 (em banco descartável primeiro).

**Próximo**: **IB-1** — loader do catálogo (rotina do Super: planilha do IT + Anexo VII + lista NBS da API; conferência pela API), DDL nos
canônicos + migrations, peça de classificação do serviço e aba no cadastro de serviços, enquadramento datado. Pré-condição para o DROP
(B5.1) e para o contract (B5.2): o chip do grupo do sync. Dado de cadastro pendente: NBS/classificação por serviço da Setes (Valdo + contador).

## 11. IB-1 — FECHADA no dev (2026-10-10, 2ª sessão: gates + passeio + catálogo de campos — §11.1…§11.6); commit PREPARADO, aguarda "vai"

**Feito e provado na 1ª sessão (base dos gates):**
1. **Referências centrais**: `sql/61_ibscbs_reference_ddl.sql` (+ espelho no canônico `sql/01`) APLICADO no `setes_central` do dev — 7
   tabelas (`tb_tax_ibscbs`, `_classification`, `_classification_validity`, `_classification_applicability`, `tb_ibscbs_place_indicator`,
   `_place_indicator_applicability`, `tb_nbs`), unicode_ci, 9 CHECKs.
2. **Rotina do Super (loader)**: `setes-api/scripts/load-ibscbs-catalog.ts` + peças `@shared/xlsx` (leitor mínimo com fflate + @xmldom,
   teto anti zip-bomb) e `@shared/ibscbs-catalog` (parse/validação · conferência · gravação em UMA transação, sessão STRICT, ensaio por
   padrão, grava só com `--vai`). Catálogo CARREGADO no dev: 18 CST · 173 cClassTrib (vigência 2026-01-01) · 70 aceitos na NFS-e · 40
   cIndOp (28 na NFS-e) · 920 NBS; 2ª passada = 100% inalterada (idempotente). O modo estrito pegou um rótulo de 36 > 30 (corrigido).
   Comando: `npx tsx --require tsconfig-paths/register scripts/load-ibscbs-catalog.ts --it <…/classificacao-ibs-cbs/it-2025-002-v1-70-cclasstrib.xlsx> --it-version "IT 2025.002 v1.70" --indop <…/rtc-2026-10/anexovii-indop_ibscbs_v1-03-00-nt009.xlsx> --indop-version "Anexo VII v1.03.00" [--vai]`.
3. **⚠️ ASSUNÇÃO A-IB1 (refina a D-IB23 — confirmar com o Valdo)**: a Calculadora (banco V0059, 30/09) ainda NÃO tem 9 cClassTrib novos
   do IT v1.70 (01/10) — 000006, 200055, 200056 (NFS-e) e 400003, 400004, 550026…550029. Regra implementada: código só na Calculadora =
   IT desatualizado → carga RECUSADA; código só no IT = identidade/vigência carregadas SEM aplicabilidade (não oferecido nem aceito até a
   Calculadora tê-lo — a Sefin confere pela Calculadora). A letra da D-IB23 ("divergência = recusa inteira") travaria toda carga.
4. **Schema do cliente**: migration `066_ibscbs_service_classification.sql` (+ `sql/03`) APLICADA no `setes_setes` — `tb_service.nbs` + FK
   (FK `IF NOT EXISTS`, provada idempotente em banco descartável), `tb_service_ibscbs` (1:1, FK física ao CÓDIGO e ao cIndOp), 3 colunas
   unicode_ci POR COLUNA em `tb_invoice_service`. **B3 (`tb_establishment_tax_regime`) ADIADO para a IB-2** junto com a troca dos dois
   leitores (fiscal-api `src/erp/facts.ts` + cópia do dual-run no setes-api) — a nfse-api estava com merge em conflito de outra sessão; sem
   dois escritores (guardião §10.3 (d)). Nada muda para a Setes antes de 01/01/2027.
5. **Peça `@shared/ibscbs-classification`** (vigência na data, presença por modelo, recusa de `requires_regular_taxation`, cIndOp por
   modelo, NBS; listas de apoio) + **módulo `services`**: GET devolve `nbs`/`nbsDescription`/`ibscbs{…cst derivado…}`; POST/PUT aceitam
   `nbs`/`ibscbs` (ausente = não mexe · null = remove), conferidos na data de HOJE do estabelecimento dentro da transação (422 `IBSCBS_*`
   com `fields[]`); lookups `GET /api/services/nbs`, `/ibscbs-classifications`, `/ibscbs-place-indicators` (+ Swagger). 5 códigos de
   erro novos (`errors:gen` = 155). `package.json`: `fflate` e `@xmldom/xmldom` declaradas (já instaladas, sem download).
6. **Provas**: tsc limpo · **setes-api 1861/1861 (114 suítes)**, +22 da IB-1 · smoke ao vivo (servidor de dev): lookups com dados reais;
   PUT num serviço de TESTE da trilha (id 24): 422 NBS inexistente / 000006 não confirmado / cIndOp 010104 só NF-e, 400 formato, gravação
   válida (NBS 115022000 + 000001/100301), PUT sem os campos preserva, desfeito ao final.

**App (feito pelo agente `setes-form-builder` e CONFERIDO no disco)**: aba "IBS/CBS" no cadastro de serviços (depois de Principal e
Preços) — NBS, cClassTrib (CST derivado só leitura) e cIndOp, cada um com lista de apoio filtrável e limpar; salvar sempre manda `nbs`/`ibscbs`
(null quando vazios); "os dois códigos juntos" validado antes da API (foco na aba); erros `fields[]` da API ancorados no campo; texto de
ajuda (NFS-e a partir de 2027, o fisco calcula). `showSetesLookup` (setes_widgets) ganhou `itemAvatar` OPCIONAL (código textual com zeros
à esquerda — retrocompatível). Arquivos: `apps/web/lib/app/modules/services/{domain/entity/service_entity.dart, domain/service_ibscbs_rules.dart,
data/datasource/service_lookup_datasource.dart, presentation/page/service_page.dart}`, `apps/web/assets/translations/{pt,en}.json`,
`apps/web/test/service_ibscbs_entity_test.dart`, `packages/setes_widgets/{lib/src/setes_lookup.dart, test/setes_widgets_test.dart}` + skill
`Infra-IA/setes-app/skills/campo-lookup-fk.md` (seção "Lookup de CÓDIGO OFICIAL textual"). **Provas conferidas por mim**: `flutter analyze`
limpo (app e setes_widgets) · setes_widgets 5/5 · app **177/177** (+15). Tela ainda NÃO vista no navegador (passeio logado pendente).
Pendência do agente: catálogo de campos da interface `services` (`npm run fields:gen`) — chaves usadas: `nbs`, `classification_code`,
`place_indicator_code`.

*(Pendências da 1ª sessão — gates, passeio, `fields:gen`, commit — tratadas na 2ª sessão abaixo. As alterações de OUTRA sessão que
estavam no working tree do setes-api foram commitadas por ela — fcc71fb/db82641 — e o working tree ficou só com a IB-1.)*

### 11.1 Catálogo de campos da interface `services` (seed `sql/62_services_interface_fields_seed.sql`)

A interface `services` (id 34 no dev) NÃO tinha catálogo nenhum. `fields:gen` sobre `tb_product` + `tb_service` + `tb_service_ibscbs`,
revisado: 13 campos; fora `id`, `tb_institution_id`, `kind`, `tb_user_id`; técnico 'S' só em `description`/`tb_category_id`
(`identifier` 'N' — em branco = o id, D7); `classification_code`/`place_indicator_code` 'N' (a PEÇA é opcional; a obrigação legal no
faturamento é da IB-2/D-IB8). Aplicado no dev, re-executável. **Defeito achado ao gerar**: `assertClientRequired` procurava no payload o
camelCase da COLUNA (`tbFinancialPlansId`, `classificationCode`) e o DTO usa `financialPlansId`/`ibscbs.classificationCode` — campo
apertado pelo cliente derrubaria TODO salvar com 400. Correção: parâmetro OPCIONAL `payloadPaths` (coluna → caminho do payload, com
ponto) em `@shared/field-config`; o módulo services declara `SERVICE_FIELD_PATHS` (`services.dto.ts`); a tela respeita o aperto nos
dois códigos. Outros módulos inalterados — o mesmo defeito em catálogos antigos (ex.: `tb_bank_account_id` em settlement-rules) virou
TAREFA SEPARADA (chip).

### 11.2 Gates (setes-api + app)

- **Socrático, 1ª rodada: 0.66 ✗** — Calculadora (API "beta") respondendo 200 com `[]` apagava em silêncio a aplicabilidade do catálogo
  inteiro no `--vai`; ensaio e ato eram duas consultas à fonte; conciliação num dia só (linha do IT com dIniVig FUTURA ganhava
  aplicabilidade sem conferência); dia UTC no loader (fora da cerca); conferência de CHECK no boot que a D-IB26 cita NÃO existia; colunas
  congeladas sem CHECK de formato; `tb_user_id` da peça 1:1 nunca gravado; NBS extinta nunca desativada; fetch sem timeout; `applyCatalog`
  sem teste.
- **Adversarial: 0.80 ✅ sem HIGH** (~150 requisições, zero 500; 2 MEDIUM: vocabulário de `indNFSe`/`indNFe` do Anexo VII não validado —
  "Sim" desativava as 28 aplicabilidades com rc=0; DoS no leitor de xlsx — `<row r="300000000">`/célula `ZZZZZZ1` = heap out of memory).
- **Retrabalho (sem decisão nova)**: `reconcile.ts` recusa lista VAZIA da Calculadora em QUALQUER data consultada e confere POR LINHA de
  vigência na data `conferenceDateOf` (a da vigência mais perto da carga — futura na própria dIniVig; sem lista = não confirmada:
  **ASSUNÇÃO A-IB2**, abaixo); `parseCalculatorCodes` (estrutura mudada = erro alto); `apply.ts` aplicabilidade pela LINHA,
  `deactivatedKeys` no relatório, **NBS por presença**; `parse.ts` datas com âncora + calendário (`isCalendarDate`), vocabulário S/N/vazio;
  `read-xlsx.ts` limites do formato + **orçamento de posições** (2.000.000 — 90 KB com 20 mil linhas na coluna XFD viravam 2,7 GB) + serial
  ≤ 9999-12-31; **o ATO tem PLANO** (peça `plan.ts`): o ensaio imprime o hash do que será gravado (fontes + registros interpretados +
  conferência + não confirmados + NBS + data) e o `--vai` só grava com `--plano` igual (`--vai` sem plano / plano sem `--vai` / divergente =
  recusa); dia de Brasília (`todayIn`) e `--date` conferido; fetch com `Connection: close` + 30 s (o servidor do gov.br TRAVA a 2ª
  requisição numa conexão keep-alive — 20 s × 148 ms, provado) ; cerca de fuso agora varre `scripts/` (`gerar-interface-fields.ts` ajustado);
  `assertCheckConstraintsEnforced` no boot (molde D-F45, tabela REAL `tb_nbs` — prova que o CHECK do catálogo existe; ao vivo "aplicado");
  CHECK de formato nas 3 colunas congeladas de `tb_invoice_service` (066 passo 4 + `sql/03`; `ADD CONSTRAINT IF NOT EXISTS` provado
  re-executável em banco descartável; aplicado no dev — **a 066 foi editada no lugar porque nunca saiu do dev**: exceção registrada à regra
  de não editar migration aplicada); `tb_user_id` do JWT na peça 1:1 e **autor/data só mudam quando a classificação muda**; nome do
  cClassTrib no GET pela linha vigente HOJE.
- **Socrático, re-score: 0.75 ✅** (o furo novo — `[]` só recusado na data da carga — e a classe do DoS por linhas largas foram corrigidos
  na sequência, com teste; o resto virou questão — §11.5).
- **Provas finais**: tsc limpo · setes-api **1917/1917 (118 suítes; +56 desde a 1ª sessão)** · app 177/177 + `flutter analyze` limpo · cerca de fuso 2/2 · ensaio real do
  catálogo 100% inalterado (plano `1192023064a0a70b`, determinístico) · planilhas forjadas largas = erro legível em 5 s com heap de 1 GB.

**⚠️ ASSUNÇÃO A-IB2 (refina a A-IB1 — confirmar com o Valdo)**: cada linha de vigência é conferida na Calculadora na data em que vale
mais perto da carga; linha que só passa a valer depois (dIniVig futura) é conferida na própria dIniVig; sem lista dessa data (ou JSON
salvo só com a data da carga) = SEM aplicabilidade até uma recarga confirmá-la (fail-closed — nada é oferecido sem a Calculadora).

### 11.3 Passeio logado (Claude in Chrome, Valdo logado; dados do passeio removidos ao final)

Serviço de TESTE `PASSEIO IB-1 aba IBS/CBS` (id 62, criado pela API): aba IBS/CBS com texto de ajuda; lista da NBS filtrando no formato
oficial com pontos (`1.1502` → capítulo 1.15); cClassTrib com o CST no avatar e o CST derivado (000) só leitura; salvar com só o cClassTrib
= pendência legível do cIndOp sem chamar a API; gravação 115022000 + 000001/100301 (banco = tela, `tb_user_id` 1); GET recarrega tudo;
painel "Campos das Interfaces" mostra os 13 campos do seed 62 (descrição travada) → apertar `classification_code` com rótulo
"Classificação IBS/CBS (cliente)" → a tela usa o rótulo do cliente e cobra o campo ("Preencha o campo: …"); configuração desfeita pelo
painel; limpar os dois códigos e salvar = peça `deleted='S'`, NBS mantida. **Achado do passeio, CORRIGIDO**: 100301 e 100302 apareciam
com a MESMA descrição (7 pares do Anexo VII só diferem no "Local do fornecimento a ser identificado no DFe" — adquirente × destinatário;
o DDL do script 61 já documentava "tipo + característica + local") → `parsePlaceIndicators` passou a incluir o local (coluna obrigatória
na estrutura); carga do dev regravada pelo plano (40 descrições `updated`, nada mais); lista conferida pela API (a 2ª aba do Chrome travou
no build debug — sem nova tentativa). Resíduo conferido: 0 serviços de teste vivos, 0 linhas em `tb_institution_has_field` da 34, 0 peças vivas.

### 11.4 Fora da IB-1 (tarefas separadas — chips)

(1) caminho do payload × catálogo de campos nos demais módulos (`tb_bank_account_id` × `bankAccountId` em settlement-rules — apertar o
campo derruba todo salvar); (2) `insertService` cunha o id por MAX+1 sem `lockInstitutionCounters`/`withDeadlockRetry` (regra 7 do
PADROES §9 — 12 POST paralelos = 10–11 × 409 RESOURCE_BUSY, nunca 500; pré-existente).

### 11.5 ⚠️ Rodada 3 — questões para o Valdo (recomendação entre parênteses)

- **Q-IB28 Conferência e encolhimento do catálogo** (confirma A-IB1/A-IB2). (a) Conferir também ATRIBUTOS IT × Calculadora (indNFSe ×
  `tiposDfeClassificacao`, ind_gTribRegular × `exigeGrupoTributacaoRegular`)? *(Rec.: sim, só os dois que o código consome; divergência =
  linha SEM aplicabilidade + listada — mesmo fail-closed da A-IB1.)* (b) Código que perde a confirmação numa recarga e está EM USO por
  serviços: desativa para todos ou recusa a carga? *(Rec.: desativa (presença) e o ensaio lista os serviços afetados por schema antes do
  plano.)* (c) Limiar de "encolheu demais" (Calculadora pela metade desativa 26; NBS com 10 itens desativa 910 — hoje só o relatório e o
  plano protegem)? *(Rec.: recusar perda > 10 % das linhas vivas de qualquer lista sem um argumento explícito do ato, ex.
  `--aceita-encolher`.)* (d) Correção de dIniVig de um código deixa a linha antiga ABERTA (`valid_until` NULL, só perde a aplicabilidade)?
  *(Rec.: manter — linha nunca é apagada; o resolvedor pega a mais nova vigente; registrar.)*
- **Q-IB29 Data de conferência no cadastro do serviço**: hoje (como está) × "vigente hoje OU a partir de data futura" × data da obrigação
  (01/01/2027); e a tela mostra que a classificação gravada deixa de valer? *(Rec.: aceitar vigente hoje ou futura até a data da
  obrigação, com "vale a partir de" na tela — decidir antes de dezembro.)*
- **Q-IB30 Reconferir a classificação INALTERADA no salvar** (hoje: sim — classificação que expira bloqueia uma edição de preço)?
  *(Rec.: só o que mudou — precedente D-G34; a D-IB8 barra no faturamento.)*
- **Q-IB31 Obrigatoriedade comercial em campo "ausente = não mexe"**: validar o PAYLOAD (hoje — PUT sem `ibscbs` num serviço já
  classificado dá 400) ou o ESTADO resultante (gravado + payload)? Vale para a peça field-config inteira. *(Rec.: estado resultante, junto
  com o chip do caminho do payload.)*
- **Q-IB32 Carga em produção**: quem roda, de onde (os `.xlsx` moram na Infra-IA; o build não leva `scripts/` nem `tsx`), com que
  credencial, e quem dispara a recarga quando a Calculadora publicar os 9 códigos? *(Rec.: o Valdo, da máquina dele, com usuário de banco
  só de `setes_central`, ensaio fora do horário comercial — o ensaio segura FOR UPDATE na aplicabilidade SE — e lembrete mensal de
  recarga até os 9 entrarem.)*
- **Q-IB33 Deploy da 066 × sync**: a 066 deixa viva a FK `tb_service_ibscbs → tb_service`; se o `/service/sincronize` fizer REPLACE ou
  DELETE físico em `tb_service`, a sincronia desses serviços falha (1451). *(Rec.: a 066 só vai a produção depois de o chip do grupo do
  sync confirmar — é pré-condição do deploy, não do dev.)*
- **A-IB1 e A-IB2**: confirmar (§11 item 3 e §11.2).

### 11.6 Commit da IB-1 (SÓ os caminhos da fase) — código COMMITADO 2026-10-10 com o "vai" do Valdo: api e635fef · sql 5dcede9 · app 27cc7a6 — PUBLICADO no GitHub 2026-10-10; Infra-IA integrada ao origin (13 commits; 2 conflitos de linha resolvidos — INDICE renumerado 9.15–9.17, D-IB15 sobre o §19.1) e commitada SÓ com os caminhos/trechos da fase

setes-api: `package.json`, `scripts/load-ibscbs-catalog.ts`, `scripts/gerar-interface-fields.ts`, `src/server.ts`, `src/shared/db/connection.ts`,
`src/shared/field-config/field-config.service.ts`, `src/shared/xlsx/`, `src/shared/ibscbs-catalog/`, `src/shared/ibscbs-classification/`,
`src/modules/services/*`, `src/shared/errors/error-codes.ts`, `src/migrations/sql/066_*`, `src/__tests__/{ibscbs-*,field-config,time-zone-fence}.test.ts`
· setes-app: o bloco App acima (NUNCA o `.dart_tool/`) · sql: `01`, `03`, `61`, `62` · Infra-IA: este prompt + DDL rascunho, oficiais
arquivados (`setes-api/integracoes/nfse-adn/{classificacao-ibs-cbs,legislacao-ibs-cbs,rtc-2026-10}/` + README), `database/PADROES_BANCO.md`,
`setes-app/skills/campo-lookup-fk.md`, as correções de premissa (`prompt_fase_faturamento_financeiro.md`, `prompt_onda3_nfse_adn.md`,
`prompt_apis_fiscais_isoladas.md`), `nfse-api/INDEX.md` e SÓ os trechos IBS/CBS do `INDICE_CENTRAL.md`. FORA (outra frente — leitura
do ACBr da nfe-api): `prompt_onda_nfe_sefaz.md`, `nfe-api/`, `rascunho_engine_modernizacao.md`, submódulo `codigo-aprendizado/`.

**Valdo**: opção de regime até **30/10**; NBS/classificação de cada serviço da Setes (com o contador); Rodada 3 (§11.5). **Depois**: IB-2
(congelamento único no ramo billing+OS, 422 de obrigação D-IB8, enquadramento datado + leitores).

### 11.7 Rodada 3 DECIDIDA (Valdo 2026-10-10: "siga as recomendações na Rodada 3") — D-IB28…D-IB33 + A-IB1/A-IB2 confirmadas

Cada D-IB*n* = a recomendação da Q-IB*n* (§11.5). Numeração permanente (continua o §10.5). "Siga as recomendações" foi lido também como a
CONFIRMAÇÃO das assunções A-IB1/A-IB2 (o item da rodada era "confirmar").

| Decisão | O que fixa |
|---|---|
| **D-IB28** | Conferência e encolhimento do catálogo: (a) além da presença do código, a carga confere na Calculadora os DOIS atributos que o código consome — aceitação na NFS-e (`tiposDfeClassificacao` tipo 91 da lista + `validoParaSiglaDfeInformado` do par NFS-e × cClassTrib) e tributação regular (`exigeGrupoTributacaoRegular` do par × `ind_gTribRegular` do IT); divergência = a LINHA perde a aplicabilidade na NFS-e e é listada (mesmo fail-closed da A-IB1); IT que NÃO aceita e Calculadora que aceita = só listado (o IT governa a presença); (b) código que perde a confirmação/aplicabilidade e está EM USO: desativa (presença) e o ensaio lista os serviços afetados por schema; (c) perda > 10 % das linhas vivas de qualquer lista (aplicabilidade de cClassTrib, de cIndOp, NBS) = carga RECUSADA, salvo argumento explícito do ato `--aceita-encolher` (que entra no plano); (d) correção de dIniVig que deixa a linha antiga aberta: manter (linha nunca apagada; perde a aplicabilidade; o resolvedor pega a mais nova vigente) |
| **D-IB29** | Cadastro do serviço aceita classificação VIGENTE HOJE ou com dIniVig FUTURA até a data da obrigação da NFS-e (01/01/2027 — Ato Conjunto nº 4/2026 § 1º; depois dela, só a vigente); a tela mostra "vale a partir de" (e "válida até", quando houver fim) |
| **D-IB30** | O salvar do serviço reconfere só a NBS/classificação que MUDOU (precedente D-G34); a inalterada não bloqueia uma edição de preço — quem barra a classificação vencida é o faturamento (D-IB8, IB-2) |
| **D-IB31** | Obrigatoriedade comercial em campo "ausente = não mexe" valida o ESTADO resultante (gravado + payload), não só o payload — vale para a peça field-config inteira; executa junto com a tarefa do caminho do payload nos demais catálogos (chip) |
| **D-IB32** | Carga em produção: o Valdo, da máquina dele, com usuário de banco que só ESCREVE em `setes_central` (e só LÊ `tb_service`/`tb_service_ibscbs`/`tb_product` dos clientes para o relatório de impacto da D-IB28 (b)); ensaio fora do horário comercial (segura FOR UPDATE na aplicabilidade SE); lembrete mensal de recarga até os 9 códigos da A-IB1 entrarem na Calculadora. Procedimento: skill `setes-api/skills/carregar-catalogo-ibscbs.md` |
| **D-IB33** | A migration 066 só vai a produção depois de o grupo do sync confirmar que o `/service/sincronize` não faz REPLACE nem DELETE físico em `tb_service` (FK viva `tb_service_ibscbs → tb_service`) — pré-condição do DEPLOY, não do dev |
| **A-IB1** | CONFIRMADA: código só na Calculadora = IT desatualizado → carga recusada; código só no IT = identidade/vigência sem aplicabilidade até a Calculadora tê-lo |
| **A-IB2** | CONFIRMADA: cada linha de vigência é conferida na data em que vale mais perto da carga (futura na própria dIniVig); sem lista dessa data = sem aplicabilidade |

**Execução**: §11.8.

### 11.8 Rodada 3 — execução (2026-10-10)

- **D-IB28 (a)** `reconcile.ts`: lista da Calculadora com os documentos de cada código (`tiposDfeClassificacao`, NFS-e = tipo 91) +
  par NFS-e × cClassTrib (`validoParaSiglaDfeInformado`, `exigeGrupoTributacaoRegular`); linha que o IT aceita na NFS-e e a Calculadora
  não (lista ou par), par não consultado ou tributação regular divergente = `blocked` (sem aplicabilidade SE); IT não aceita × Calculadora
  aceita = só `divergences`. A conferência é OBRIGATÓRIA na assinatura. Loader: ritmo de 250 ms, 4 tentativas com espera crescente,
  `Connection: close`; esgotadas = fonte fora do ar, nada gravado. 1ª conferência real: 70 pares, 0 bloqueados, 1 divergência
  informativa (410028).
- **D-IB28 (b)** `apply.ts`: no ENSAIO, o que fica SEM nenhuma aplicabilidade SE (cClassTrib e cIndOp — código que segue aceito por
  outra linha não conta) e a NBS que perde presença; a leitura dos schemas dos clientes acontece DEPOIS do rollback (nenhuma trava
  central segura N schemas) e não roda no ato; erro de leitura = `impactProblems`.
- **D-IB28 (c)**: perda > 10 % das linhas vivas (aplicabilidade cClassTrib, cIndOp, NBS) decidida ANTES de ler clientes; ensaio avisa
  (`AVISO_ENCOLHIMENTO`), ato recusa salvo `--aceita-encolher` (no plano).
- **D-IB29** peça `@shared/ibscbs-classification`: constante `NFSE_IBSCBS_SIMPLES_OBLIGATION_START` (2027-01-01); regra ÚNICA do
  cadastro `pickForRegistration` para lista, salvar e exibição (vigente com presença → futura com presença → vigente sem presença); GET
  e lista com `validFrom`/`validUntil`; a tela mostra "Vale a partir de … / Vale de … até …" sob o campo e "(vale a partir de …)" na
  lista (texto da tela — i18n).
- **D-IB30** `services.repository.ts`: o salvar compara NBS e par com o GRAVADO (na transação, depois do FOR UPDATE do tb_product) e
  reconfere só o que mudou. Ao vivo: classificação inalterada que perdeu a aplicabilidade = 200; trocar para inválida = 422.
- **D-IB31**: tarefa separada (chip) junto com o caminho do payload. **D-IB32/D-IB33**: skill `setes-api/skills/carregar-catalogo-ibscbs.md`.
- **Limite conhecido registrado**: um PUT que leu o catálogo antes do commit de uma carga pode gravar código que acabou de perder a
  presença (TOCTOU) — não aparece no impacto daquela carga; a IB-2 barra no faturamento.
- **Gates do delta**: socrático **0.72 ✅** (correções sem decisão feitas: regra única lista × salvar × exibição, impacto com cIndOp e
  fora do lock, NBS gravada só da linha viva, conferência de atributos obrigatória, texto da API sem português, constante com o nome do
  Simples, documentação); adversarial **0.74 ✅** sem HIGH (~70 requisições, zero 500, catálogo central intacto por CHECKSUM) — 2 MEDIUM
  da mesma raiz (D-IB28 (d) — linha antiga aberta numa correção de dIniVig para o futuro) CORRIGIDOS com teste: o impacto passa a
  olhar a linha VIGENTE na data da carga (antes: "ainda aceito" pela linha futura → impact []), e lista × salvar concordam pela regra
  única (o harness de 7 casos fictícios, em transação desfeita, não mostra mais divergência). LOWs corrigidos: D-IB30 por COMPONENTE do
  par (trocar só o cIndOp não reconfere o cClassTrib inalterado), `pares` do JSON offline validados (objeto com chaves de 6 dígitos),
  A-IB1 em TODA data consultada, impacto com os ids dos serviços (até 50) e as institutions inativas (`institutionActive`).
  Provas finais: ensaio real 47 s, 70 pares, 0 bloqueados, mesmo plano; **setes-api 1997/1997 (121 suítes, inclui testes em andamento de
  outra sessão) · app 200/200 · analyze limpo**; smoke ao vivo (lista com validFrom, troca só do cIndOp = 200, cIndOp inválido = 422 no
  campo, D-IB30 com classificação inalterada vencida = 200). **PUBLICADO 2026-10-10** só pelos caminhos da Rodada 3: api 6cee5a3 ·
  app 6819734 (traduções: só as 2 chaves IBS/CBS) · infra 4b5b97e; sql sem alteração nesta rodada. Os de billing/invoice/tax-authority/
  error-codes/migration 067/service_orders no working tree são de OUTRA sessão (não commitados por esta).

### 11.9 ⚠️ Rodada 4 — questões para o Valdo (do gate socrático do delta; recomendação entre parênteses)

- **Q-IB34 Classificação que só vale depois da data do faturamento (dezembro, envio voluntário — D-IB13/D-IB16)**: (a) faturar SEM o
  grupo (voluntário é opcional); (b) 422; (c) usar a linha anterior. Vale também para o lote mensal. *(Rec.: (a) antes da obrigação;
  depois dela, o 422 da D-IB8.)* ⚠️ é desenho da IB-2 — precisa estar decidida antes de dezembro.
- **Q-IB35 Obrigação por regime**: a constante 2027-01-01 é do Simples (§ 1º do Ato nº 4); o não optante tem obrigação desde 01/10/2026
  (01/12 para alguns subitens). A janela da D-IB29 e o 422 da D-IB8 saem do enquadramento datado (D-IB7) na IB-2, ou fica a constante
  única até o 1º cliente não optante? *(Rec.: a IB-2 lê pelo enquadramento; a constante já foi renomeada para deixar claro que é do Simples.)*
- **Q-IB36 Linha órfã de correção de dIniVig no resolvedor da DATA DO FATO** (o cadastro já prefere a linha com presença): (a) o
  resolvedor só escolhe entre as linhas COM presença no modelo; (b) a carga grava o fato "ausente da fonte desde a versão X" sem apagar
  nada e a peça ignora a linha superada; (c) a carga fecha o `valid_until`. *(Rec.: (b).)*
- **Q-IB37 Aviso ao usuário**: o GET e a tela dizem que a classificação gravada deixou de ser aceita na NFS-e (presença perdida numa
  recarga) ou venceu? Com a D-IB30 o usuário salva sem saber até faturar. *(Rec.: o GET devolve `acceptedToday` e a tela mostra um selo.)*
- **Q-IB38 Limite de encolhimento bruto × líquido**: uma correção de dIniVig em massa desativa N linhas e insere N novas e é recusada sem
  `--aceita-encolher`. *(Rec.: manter bruto — conservador; registrar.)*

### 11.10 Rodada 4 DECIDIDA (Valdo 2026-10-10: "siga as recomendações na Rodada 4") — D-IB34…D-IB38

Cada D-IB*n* = a recomendação da Q-IB*n* (§11.9). Numeração permanente.

| Decisão | O que fixa |
|---|---|
| **D-IB34** | Serviço classificado com linha que só começa a valer DEPOIS da data do faturamento: ANTES da obrigação (envio voluntário — D-IB13/D-IB16) a nota sai SEM o grupo IBS/CBS (nunca 422, inclusive no lote mensal); DEPOIS da obrigação, o 422 da D-IB8. Executa na IB-2 (congelamento único no ramo) |
| **D-IB35** | A data da obrigação (janela do cadastro D-IB29 e 422 da D-IB8) passa a ser lida pelo enquadramento datado do emitente (D-IB7) na IB-2; até lá vale a constante do Simples (`NFSE_IBSCBS_SIMPLES_OBLIGATION_START`, já com o nome do Simples) |
| **D-IB36** | Linha de vigência que SOME da fonte (ex.: dIniVig corrigida pelo IT): a carga grava o FATO "ausente da fonte desde a versão X" (`absent_since_version` na história do cClassTrib) sem apagar nada; volta na fonte = o fato é limpo; a peça IGNORA a linha superada em toda resolução (data do fato, cadastro, lista) — a exibição de um código gravado ainda a mostra se não houver outra |
| **D-IB37** | O GET do serviço devolve `acceptedToday` (a classificação gravada é aceita hoje pela regra do cadastro: linha com presença na NFS-e, sem tributação regular, e cIndOp aceito) e a tela mostra um SELO quando não é — o usuário sabe antes de faturar |
| **D-IB38** | O limite de encolhimento da D-IB28 (c) conta desativações BRUTAS (lado conservador): correção de dIniVig em massa exige `--aceita-encolher`, com o ensaio mostrando as chaves |

**Execução**: §11.11.

### 11.11 Rodada 4 — execução (2026-10-10)

- **D-IB36**: script `sql/63_ibscbs_validity_absent_since.sql` (coluna `absent_since_version` na história do cClassTrib, espelhada no
  `61` e no canônico `01`; aplicado no `setes_central` do dev, re-executável — **ordem de deploy: o 63 antes do setes-api**, a peça lê a
  coluna). Guardião: atributo da peça de HISTÓRIA (fato gerador = carga de uma versão do IT sem a linha), sem FK nem regra nova. A carga
  (`apply.ts`) grava a versão em que a linha sumiu e limpa o fato quando ela volta (`validity.deactivated`/`revived` + chaves); a peça
  ignora a linha superada em `findClassificationAt`, `pickForRegistration` e na lista; a exibição do código gravado só a mostra se não
  houver outra. Ensaio real: 173 linhas inalteradas, 0 marcadas (o IT v1.70 traz todas), mesmo plano.
- **D-IB37**: peça `classificationAcceptedToday` (regra do cadastro + cIndOp aceito); o GET do serviço devolve `ibscbs.acceptedToday`
  (null = não avaliado) e a aba mostra o SELO "não é mais aceita na NFS-e hoje — escolha outra antes de faturar"; escolher outra na lista
  tira o selo. Ao vivo: classificação boa = `true`; gravada 000006 (sem presença) = `false`.
- **D-IB34/D-IB35**: desenho da IB-2 (faturamento sem o grupo antes da obrigação; obrigação pelo enquadramento datado) — registrado,
  executa na IB-2. **D-IB38**: registrado (limite bruto).
- **Gates do delta da Rodada 4**: socrático **0.76 ✅** · adversarial **0.80 ✅** (sem HIGH; ~40 requisições, 11 ensaios offline, catálogo
  intacto por CHECKSUM). Os 2 MEDIUM coincidentes CORRIGIDOS: (1) a exibição caía na linha SUPERADA nos recursos de reserva mesmo havendo
  outra → reservas olham primeiro as não superadas (harness: 000924 mostra a viva fora da janela, 000925 a expirada viva; só-superada cai
  nela como último recurso); (2) o selo juntava cClassTrib e cIndOp num booleano só e a tela culpava a classificação → peça
  `classificationAcceptance` POR COMPONENTE, o GET devolve `acceptedToday` + `classificationAcceptedToday` + `placeIndicatorAcceptedToday`
  e a aba mostra o selo sob o campo certo (ao vivo: cIndOp morto = `cClassTrib true / cIndOp false`). LOWs: Swagger do GET com os campos
  novos; **o boot confere a coluna do script 63** (`assertIbscbsCatalogSchema` — sem ela a API não sobe e diz qual script aplicar; antes
  o boot passava e o cadastro dava 500); os fakes de teste EXIGEM o filtro `absent_since_version IS NULL` no SQL; resíduo dos smokes
  limpo (4 peças 1:1 vivas de serviços de teste excluídos). **Registrado** (limite conhecido, sem decisão): excluir o serviço não mata a
  peça 1:1 `tb_service_ibscbs` — todo leitor e o impacto exigem o produto vivo; o custo do GET por id (+2 consultas centrais indexadas;
  a lista não chama a peça) fica como está.

### 11.12 ⚠️ Rodada 5 — questões para o Valdo (dos gates do delta da Rodada 4; recomendação entre parênteses)

- **Q-IB39 Encolhimento da história**: as marcações "ausente da fonte" (`relatorio.validity.deactivated`) entram no limite da D-IB28 (c),
  em bruto como na D-IB38, com o mesmo `--aceita-encolher`? (o adversarial provou: IT antigo + Calculadora offline sem os 103 códigos sem
  NFS-e marcaria 103 de 173 linhas sem aviso; com a Calculadora real a A-IB1 recusa) *(Rec.: sim — uma linha no laço do limite; cobre as
  linhas sem presença SE, que pesam na F4.)*
- **Q-IB40 NBS no selo**: a NBS que perde a presença numa recarga entra no impacto mas não no selo (o GET mostra a descrição dela sem
  sinal). O GET passa a dizer se a NBS gravada é aceita (`nbsAcceptedToday`) e a IB-2 barra NBS sem presença? *(Rec.: sim, campo próprio
  para a tela apontar o campo.)*
- **Q-IB41 (IB-2, antes de dezembro) Linha VIGENTE sem presença com linha futura com presença**: na data do fato, `findClassificationAt`
  devolve uma linha que não se aplica, enquanto o selo (regra do cadastro) diz "aceita". *(Rec.: tratar igual à D-IB34 — antes da
  obrigação a nota sai sem o grupo; depois, o 422 da D-IB8 — e registrar na IB-2 que `acceptedToday` é sinal de CADASTRO, não decide o
  faturamento, e que a nota congelada nunca reconsulta o catálogo.)*

### 11.13 Rodada 5 DECIDIDA (Valdo 2026-10-10: "siga as recomendações na Rodada 5") — D-IB39…D-IB41

| Decisão | O que fixa |
|---|---|
| **D-IB39** | As marcações "ausente da fonte" da história do cClassTrib (`relatorio.validity.deactivated`) entram no limite de encolhimento da D-IB28 (c), em BRUTO como na D-IB38, com o mesmo `--aceita-encolher` (base = linhas de vigência presentes na fonte antes da carga) — cobre o IT antigo carregado por engano também nas linhas sem presença na NFS-e (que pesam na F4) |
| **D-IB40** | O GET do serviço diz se a NBS GRAVADA é aceita hoje (`nbsAcceptedToday` — presente na lista oficial) e a aba mostra o selo sob a NBS; a descrição continua exibida (o GET nunca esconde o que está gravado). A IB-2 barra o faturamento de serviço com NBS sem presença |
| **D-IB41** | (IB-2) Linha VIGENTE na data do fato SEM presença na NFS-e (com ou sem linha futura que tenha) = mesmo tratamento da D-IB34: ANTES da obrigação a nota sai sem o grupo IBS/CBS; DEPOIS, o 422 da D-IB8. Registrado na IB-2: `acceptedToday` é sinal de CADASTRO e não decide o faturamento; a nota congelada nunca reconsulta o catálogo (as colunas congeladas de `tb_invoice_service` são a verdade da nota) |

**Execução**: §11.14.

### 11.14 Rodada 5 — execução (2026-10-10)

- **D-IB39** `apply.ts`: a lista `validity` entra no laço do limite da D-IB28 (c) — base = linhas de vigência PRESENTES na fonte antes da
  carga (`absent_since_version` nulo); ensaio avisa, ato recusa salvo `--aceita-encolher`. Teste: 1 de 3 marcada (33 %) = aviso no ensaio,
  recusa no ato, grava com o argumento.
- **D-IB40** `services.repository.ts`: o GET devolve `nbsAcceptedToday` (NBS gravada presente na lista oficial; null = sem NBS) — a descrição
  segue exibida; a aba mostra o selo sob a NBS e escolher outra o tira. Ao vivo: com NBS = `true`, sem NBS = `null`. O `false` NÃO foi
  provado ao vivo pelo GET (não se mexe no catálogo central de produção para provar): o teste unitário só lê a coluna pronta, e quem
  prova o SQL é o par do gate socrático abaixo (teste que fixa o JOIN e o predicado + consulta ao vivo do predicado em tabela derivada).
  O bloqueio no faturamento é da IB-2.
- **D-IB41**: registrado para a IB-2 (§11.13) — nenhum código nesta rodada.
- **Gate socrático do delta R5: 0.78 ✅** — correções sem decisão feitas na sessão:
  (1) "NBS aceita" tem UM dono: `nbsAcceptedSql(alias)` na peça `@shared/ibscbs-classification` (alias validado) — usado pelo
  `nbsExists` (salvar), pela lista de apoio e pelo selo do GET; a IB-2 lê o mesmo;
  (2) testes que protegem o SQL: o JOIN com `tb_nbs` no GET é só `nb.code = sv.nbs` (não filtra `deleted` — a descrição da NBS que saiu
  segue) e o selo usa o predicado da peça; `nbsExists` recusa NBS com `deleted = 'S'`. Prova ao vivo do predicado (só leitura, tabela
  derivada no MySQL do dev): presente = 1 · saiu da lista = 0 com descrição · fora do catálogo = 0 · sem NBS = nulo; catálogo real: 920
  NBS, 920 aceitas;
  (3) teste da base do limite da D-IB39: linha já marcada ausente numa carga anterior fica fora da base (`aliveBefore` 2) e não conta de
  novo (shrink vazio);
  (4) a recusa de encolhimento diz o que é cada lista ("história do cClassTrib (linhas marcadas ausentes da fonte) [validity]: 1 de 3 —
  1 de código que segue na fonte (ex.: vigência corrigida), 0 de código que sumiu da fonte"); o relatório da história separa
  `codeInSource` × `codeVanished`;
  (5) skill `carregar-catalogo-ibscbs.md`: a história conta no limite; correção em massa da dIniVig é `--aceita-encolher` legítimo
  (`codeInSource` alto, `codeVanished` ≈ 0); `codeVanished` alto sem nota da Receita = parar;
  (6) roteiro de leitura da IB-2 no §4 + comentário do `findClassificationAt` (`applicable = false` segue a D-IB34 pela D-IB41, nunca
  "sem classificação");
  (7) o título da aba IBS/CBS ganha um ícone de aviso (com dica) quando algum selo da aba está ligado.
- **Gate adversarial do delta R5: 0.84 ✅** (nenhum HIGH/CRITICAL; 14 ensaios offline sem `--vai` + ~60 requests ao vivo em série; catálogo
  central intacto por `CHECKSUM TABLE` antes/depois; resíduo limpo). Provado: fronteira do limite na história (17 de 173 passa, 18 de 173
  avisa; no ato com proxy de commit, 18 de 180 grava e 19 de 180 recusa), IT antigo da Rodada 4 agora avisa (103 de 173), plano muda com
  e sem `--aceita-encolher`; D-IB40 ao vivo com a NBS retirada numa transação desfeita (GET `false` com descrição, lookup não oferece,
  PUT inalterado = OK, troca/POST = 422); sem regressão das Rodadas 3/4 (lista × salvar × selo concordam nos 173 cClassTrib e 40 cIndOp).
  4 LOW: (2) o 422 da NBS retirada dizia "não existe no catálogo" enquanto a tela mostra a descrição → CORRIGIDO ("não está na lista
  oficial", a língua do selo; descrição do código de erro idem); (3) skill/§11.14 → já feitos acima; (4) rótulo "substituída por nova
  vigência" presumia vigência nova → CORRIGIDO (`codeInSource` = "de código que segue na fonte"); (1) encerramento de vigência em massa
  fora do limite e do impacto → **Q-IB44** (§11.15). Casos não testados que viraram teste jest: fronteira exata no ato (18/180 × 19/180) e
  "limpar a NBS e reenviar a mesma" reconfere. Ficam registrados (sem teste automatizado): widget test do selo da NBS e encolhimento em
  fatias (cada carga com o seu ensaio — é do desenho).

### 11.15 ⚠️ Rodada 6 — questões para o Valdo (do gate socrático do delta da Rodada 5; recomendação entre parênteses)

- **Q-IB42** — Calendário da barreira da NBS no faturamento (D-IB40 diz "a IB-2 barra", sem data): ANTES da obrigação (envio
  voluntário — D-IB13/D-IB34), serviço com NBS sem presença na lista oficial fatura e a nota sai SEM o `cNBS`/grupo, nunca 422 (inclusive
  no lote mensal)? DEPOIS da obrigação, 422 — também para NBS ausente do catálogo? *(Rec.: sim nas duas — é o mesmo calendário da D-IB34/
  D-IB41; a NBS nunca derruba o lote antes de 01/01/2027.)*
- **Q-IB43** — Guarda de versão do IT: hoje nada impede carregar um IT MAIS ANTIGO que o já carregado (só o limite de encolhimento
  pega, se passar de 10 %). Recusar versão anterior à gravada? *(Rec.: não agora — a versão é texto livre do operador e o limite +
  `codeVanished` no relatório cobrem o caso real; registrar como limite conhecido e reabrir se a Receita publicar versões fora de ordem.)*
- **Q-IB44** — Encerramento de vigência em massa (gate adversarial do delta R5, LOW 1, provado offline): um IT com dFimVig no passado em
  169 de 173 linhas (e Calculadora coerente) passa sem aviso — a linha não fica "ausente", só muda o `valid_until` — e o impacto não
  lista os serviços que perdem a linha vigente. Com a Calculadora real a A-IB1 recusa; a família de risco é a mesma da D-IB39. Contar no
  limite (bruto, mesmo `--aceita-encolher`) as linhas que deixam de valer HOJE por mudança de `valid_until` e pôr no impacto os serviços
  cujo código fica sem linha vigente na data? *(Rec.: sim nas duas — mesma regra da D-IB39 aplicada a "deixa de valer hoje"; o impacto
  já roda na data do ensaio.)*

### 11.16 Rodada 6 DECIDIDA (Valdo 2026-10-11: "siga as recomendações na Rodada 6") — D-IB42…D-IB44

| Decisão | O que fixa |
|---|---|
| **D-IB42** | (IB-2) Calendário da barreira da NBS no faturamento — o mesmo da D-IB34/D-IB41: ANTES da obrigação (envio voluntário), serviço com NBS sem presença na lista oficial FATURA e a nota sai SEM o `cNBS` (nunca 422, inclusive no lote mensal); DEPOIS da obrigação, 422 — também para NBS ausente do catálogo. A regra de presença é a `nbsAcceptedSql` da peça (D-IB40); a data da obrigação vem da D-IB35 |
| **D-IB43** | Sem guarda de versão do IT agora: carregar um IT mais antigo que o gravado NÃO é recusado pela versão (o rótulo é texto livre do operador); quem pega o caso real é o limite de encolhimento (D-IB28 (c)/D-IB39/D-IB44) + `codeVanished` no relatório. Limite conhecido registrado na skill; reabrir se a Receita publicar versões fora de ordem |
| **D-IB44** | Linha da história VIGENTE na data da carga (presente na fonte) cuja vigência a fonte encerrou ANTES dessa data (dFimVig < data) conta no limite de encolhimento da história — somada às marcações "ausente da fonte", em BRUTO, com o mesmo `--aceita-encolher` (base = linhas presentes antes da carga) — e o código que fica SEM linha vigente na data entra no relatório de impacto (D-IB28 (b)). Fim na própria data, fim futuro, linha que já não valia e linha superada não contam |

**Execução**: §11.17.

### 11.17 Rodada 6 — execução (2026-10-11)

- **D-IB44** `setes-api/src/shared/ibscbs-catalog/apply.ts` (só a rotina do Super carrega — o servidor não importa a peça): no UPDATE
  da linha existente, se ela era vigente na data da carga (`valid_from ≤ data ≤ valid_until` ou aberta, sem `absent_since_version`) e a
  fonte traz `dFimVig` antes da data, a chave entra em `relatorio.validityEnded`; o limite da história soma
  `validity.deactivated + validityEnded` sobre `validity.aliveBefore`; a linha de encolhimento ganha `endedBeforeDate` e o rótulo
  "história do cClassTrib (linhas ausentes da fonte ou com a vigência encerrada antes da data da carga)"; o impacto passa a ter como
  candidato o código encerrado (a consulta pela linha VIGENTE na data com aplicabilidade SE decide). Sem data na carga, nada muda.
  Testes jest: limite (1 de 2 = aviso no ensaio, recusa no ato, grava com o argumento), 5 casos que NÃO contam, impacto com e sem outra
  linha vigente. Prova AO VIVO só por ensaio (rollback, sem `--vai`): o IT forjado do gate adversarial R5 (169 de 173 linhas com
  dFimVig 2026-10-09) agora dá **AVISO_ENCOLHIMENTO — 169 de 173, 169 com a vigência encerrada** (antes: sem aviso, shrink vazio); o
  impacto vazio é correto (a Setes usa 000001, não encerrado); controle com o IT oficial v1.70 = 173 inalteradas, sem aviso,
  `validityEnded` 0; catálogo central conferido depois (173 linhas, 0 ausentes, versão v1.70, 70 aceitas na NFS-e).
- **D-IB42**: registrada para a IB-2 (roteiro do §4) — nenhum código nesta rodada (hoje nenhum produtor preenche o `cNBS`).
- **D-IB43**: limite conhecido na skill `carregar-catalogo-ibscbs.md` — nenhum código.

- **Gate socrático do delta R6: 0.74 ✅** (sem CRITICAL/HIGH) — correções sem decisão feitas na sessão: (1) teste que exige a consulta
  central do impacto ANTES do rollback, pela linha vigente na data (predicado e parâmetros `[códigos, data, data]` conferidos pelo
  fake); o impacto POSITIVO foi provado ao vivo pelo harness do gate adversarial (transação externa com commit proibido e serviço de
  teste 67 revivido só dentro dela): o 000001 encerrado com sucessora só em 01/11 lista o serviço 67 — antes o §11.17 sugeria prova ao
  vivo do positivo, que só existia pelo stub; (2) desdobramento das encerradas em `endedWithSuccessor` (o código tem outra linha
  vigente na data — substituição) × `endedNoSuccessor` (o código deixa de valer) — ao vivo, o IT forjado dá 169 encerradas, 0 com
  sucessora, 169 sem; skill com o critério do `--aceita-encolher` (fim de ano com sucessoras = legítimo; `endedNoSuccessor` alto =
  parar); (6) a recusa diz "tiraria … (desativadas; na história, ausentes da fonte ou com a vigência encerrada)" e mostra a data; o JSON
  do script ganha `data` e `AVISO_DATA` quando `--date` não é hoje (provado ao vivo); `shrink[].deactivated` da história documentado
  (= ausentes + encerradas); (7) fronteiras: fim que já estava no futuro ou na própria data, encurtado para antes dela, conta; (8)
  skill: cabeçalho, referências até a D-IB44 e o impacto "pela linha vigente na data da carga" (o selo do cadastro pode discordar).
- **Gate adversarial do delta R6: 0.86 ✅** (sem HIGH/CRITICAL; 25 ensaios com IT/Calculadora forjados em transação desfeita; catálogo
  central conferido por `CHECKSUM TABLE` antes/depois — iguais, conferidos de novo depois das provas da sessão). Provado: borda da data
  exata, as duas causas somando no limite (9 + 9 = 18 de 173 recusa; 8 + 9 = 17 passa), sem dupla contagem, linha que já não valia e
  superada fora, 1ª carga sem recusa, impacto ponta a ponta (só linha futura entra; sucessora vigente não; sucessora sem conferência
  entra), plano recusa `--date` diferente entre ensaio e ato, D-IB39 sem regressão. 3 LOW: `--date` livre no passado escapa do limite →
  `AVISO_DATA` feito + **Q-IB48**; encerramento NA data ou em data futura próxima passa → mesma família da **Q-IB45**; desdobramento →
  feito (e skill: `codeInSource`/`endedWithSuccessor` só são benignos com `codeVanished` ≈ 0 e `endedNoSuccessor` ≈ 0). Casos não
  testados que viraram jest: as duas causas cruzando o limite (9 + 9 = 18 de 180 grava; 9 + 10 recusa) e o mesmo código com uma linha
  marcada e outra encerrada (2 linhas, sem dupla contagem).
- Suíte: as 19 falhas da suíte completa em 2026-10-11 são bomba-relógio dos testes do Banco Inter (fixture com vencimento fixo
  2026-10-10 × relógio real — a guarda `BANK_SLIP_EXPIRATION_PAST` está certa); fora desta frente, tarefa separada (chip).

### 11.18 ⚠️ Rodada 7 — questões para o Valdo (dos gates do delta da Rodada 6; recomendação entre parênteses)

- **Q-IB45** — Aviso PROSPECTIVO: o ensaio passa a listar, só como informação e FORA do limite, os serviços cujo código perde a linha
  vigente com presença na NFS-e até o fim da janela do cadastro (`registrationWindowEnd`, hoje a obrigação 01/01/2027), com a data da
  perda — inclusive o encerramento NA data da carga ou em data futura próxima (gate adversarial LOW 2: 160 linhas com fim na própria
  data passam caladas e deixam de valer no dia seguinte)? *(Rec.: sim — a consulta do impacto rodada no dia seguinte a cada fim de
  vigência dentro da janela; o limite da D-IB44 não muda.)*
- **Q-IB46** — Base do limite para encerramentos: manter "linhas presentes antes da carga" (D-IB44) ou usar "vigentes na data" para a
  parte encerrada (a história cresce e dilui a base)? *(Rec.: manter e registrar como limite conhecido; o relatório passa a mostrar as
  vigentes na data ao lado da base; reabrir quando vigentes/presentes ficar abaixo de 80 % — hoje 170 de 173.)*
- **Q-IB47** — Uma regra só para o impacto: ele passa a perguntar à peça de classificação (`findClassificationAt(conn, código, 'SE',
  data)` com `applicable && !requiresRegularTaxation`, na conexão da transação) em vez do predicado SQL próprio, e a flag de tributação
  regular ligada numa linha vigente usada vira candidata ao impacto? *(Rec.: sim, pela data do fato — o que a IB-2 vai usar; mesmo
  princípio da D-IB40; o relatório marca quando o cadastro ainda aceita por linha futura.)*
- **Q-IB48** — `--date` diferente de hoje no ATO: hoje só avisa (`AVISO_DATA`) e o plano garante ensaio = ato. O ato com `--vai` deve
  RECUSAR `--date` diferente de hoje (o ensaio segue aceitando, para reproduzir uma carga)? *(Rec.: sim — o único uso legítimo de
  `--date` é reproduzir; gravar com outra data é fugir do limite e do impacto.)*

### 11.19 Rodada 7 DECIDIDA (Valdo 2026-10-11: "siga as recomendações na Rodada 7") — D-IB45…D-IB48

| Decisão | O que fixa |
|---|---|
| **D-IB45** | Aviso PROSPECTIVO no ensaio: `relatorio.impactAhead` lista, só como informação e FORA do limite, os serviços cujo código ACEITO na data da carga deixa de ser aceito até o fim da janela do cadastro (`registrationWindowEnd` — hoje a obrigação 01/01/2027), com a data da perda (`lossDate`) — inclusive o encerramento NA data da carga (perde no dia seguinte). Datas candidatas = dia seguinte a cada fim de vigência e o início de cada linha nova dentro da janela; depois da obrigação não há janela. O limite da D-IB44 não muda |
| **D-IB46** | A base do limite da história segue "linhas presentes antes da carga" (D-IB44); o relatório mostra ao lado as VIGENTES na data (`validityVigentOnDate`, `vigentOnDate` na linha do encolhimento). Limite conhecido: a história cresce com os encerramentos e dilui a base — reabrir quando vigentes/presentes ficar abaixo de 80 % (2026-10-11: 170 de 173) |
| **D-IB47** | Uma regra só para "aceito": o impacto (e o aviso da D-IB45) pergunta à PEÇA de classificação na data do fato — `classificationAcceptedAt` (linha vigente com presença e sem exigir tributação regular), na conexão da transação da carga — em vez do predicado SQL próprio; a flag de tributação regular LIGADA numa linha vigente vira candidata ao impacto (`validityRegularOn`); a linha do impacto marca `registrationStillAccepts` quando o cadastro ainda aceita o código por linha futura (o selo diz "aceita") |
| **D-IB48** | O ATO com `--vai` recusa `--date` diferente de hoje (antes de abrir o banco); o ensaio segue aceitando, com `AVISO_DATA`, para reproduzir uma carga |

**Execução**: §11.20.

### 11.20 Rodada 7 — execução (2026-10-11)

- **Peça `@shared/ibscbs-classification`** (carregada pelo servidor — trocada de uma vez, `/health` em 6 s): "aceito" ganhou UMA definição
  (`accepts`: presença e sem tributação regular) com duas portas — `classificationAcceptedAt` (data do fato: impacto da carga e,
  na IB-2, o faturamento) e `classificationAcceptedForRegistration` (regra do cadastro: o selo — `classificationAcceptance` passa a
  usá-la, comportamento idêntico). Testes da peça e dos serviços 34/34.
- **D-IB45/D-IB46/D-IB47** `apply.ts`: `lostAfterLoad` com data pergunta à peça (candidatos = perdeu presença, vigência encerrada,
  tributação regular ligada); sem data, o comportamento antigo; `lossesAhead` (consulta marcada `/* ibscbs-ahead */` + a peça em cada
  data candidata) alimenta `impactAhead`, lido nos clientes DEPOIS do rollback como o impacto; `validityVigentOnDate`/`vigentOnDate`.
- **D-IB48** `scripts/load-ibscbs-catalog.ts`: `--vai` com `--date` ≠ hoje recusado antes de ler fontes e abrir o banco.
- Testes jest: a conexão falsa responde às perguntas da peça (`__piece`, emulando `findClassificationAt`/linhas do código) e à
  consulta do aviso (`__ahead`); migrados os 4 testes do impacto pela data; novos: flag regular → impacto com
  `registrationStillAccepts` false; aviso prospectivo (perda em 01/01/2027, fim NA data → perde amanhã, sucessora com presença não
  perde, linha nova sem presença dentro da janela perde, depois da obrigação não consulta, não roda no ato nem sem data). Catálogo
  64/64.
- **Provas ao vivo** (só ensaio, sem `--vai`): o ato com `--date 2026-10-10` é recusado com a mensagem da D-IB48 antes do banco; pelo
  harness do gate adversarial (transação externa, commit proibido, serviço de teste 67 revivido só dentro dela) um IT que encerra o
  000001 em 31/12/2026 dá limite e impacto de hoje vazios e **`impactAhead` = serviço 67 com perda em 2027-01-01**, vigentes na data 170;
  controle com o IT oficial v1.70 = sem limite, impacto ou aviso, plano igual ao de antes (`edb2c381d29e316e`); catálogo central
  conferido depois (`CHECKSUM TABLE` iguais) e o serviço 67 segue excluído.
- **Gate socrático do delta R7: 0.72 ✅** e **adversarial: 0.78 ✅** (sem HIGH/CRITICAL). Os DOIS acharam, por caminhos diferentes, o mesmo
  furo MEDIUM (R7-S1 = ADV-R7-01, provado por sonda e por 4 variantes no harness): o impacto inferia os candidatos pelo TIPO da mudança
  (presença perdida, vigência encerrada, flag regular) e perdia a linha NOVA sobreposta, REVIVIDA ou ESTENDIDA que passa a ser a vigente
  mais nova sem presença — a peça dizia "não aceito", impacto e aviso vazios, e o selo seguia "aceita". **Retrabalho feito na sessão**
  (cumpre a D-IB47, sem decisão nova):
  (1) **impacto = DIFERENÇA do veredito da peça ANTES × DEPOIS da gravação**, na mesma transação, para todo código que a carga pode tocar
  (o catálogo inteiro ∪ a fonte; o "antes" é lido logo depois do FOR UPDATE, antes de qualquer gravação); `validityEnded`/`validityRegularOn`
  seguem só como informação;
  (2) a peça devolve o VEREDITO com o motivo (`verdictOf` → `no-line`/`not-applicable`/`requires-regular`); `accepts`, a lista de apoio e o
  422 do cadastro leem dele (textos e códigos de erro iguais); a linha do impacto e a do aviso trazem `reason`;
  (3) portas em LOTE na peça (`classificationVerdictsAt` — mesma regra do `findClassificationAt`, blocos de 500; `classificationRegistrationVerdicts`)
  — o ensaio faz 1 consulta antes + 1 depois + 1 por data candidata do aviso (antes: 2 por código, em série);
  (4) sem data o ensaio com impacto é RECUSADO (a 2ª definição de "aceito" do ramo antigo morreu);
  (5) D-IB48 virou `assertActDate` em `plan.ts` (testada); o ensaio com `--date` diferente de hoje diz que o plano NÃO é gravável (LOW do
  adversarial: oferecia `--vai --plano X` que o ato recusaria); limite conhecido: o ato que cruza a meia-noite grava com a data de ontem;
  (6) testes: a conexão falsa responde pelo estado ANTES (`__pieceBefore`, até a 1ª gravação) e DEPOIS (`__piece`), emula o lote; novos: R7-S1
  (sobreposta), ADV-R7-01 (revivida e estendida), SQL/parâmetros/ordem da consulta do aviso (R7-S4), fronteiras do aviso (volta para a linha
  antiga sem presença → perda em 12-01; fim em 2027-01-01 → sem aviso; carga em 31/12 com fim no mesmo dia → perda na obrigação), veredito
  e lotes na peça, `assertActDate`;
  (7) texto: `registrationStillAccepts` = o cadastro ainda aceita (linha futura na janela OU outra linha vigente com presença —
  `pickForRegistration`).
  IBS/CBS jest 111/111 + catálogo de campos; tsc limpo. **Re-prova AO VIVO** pelo harness do adversarial (transação externa, commit
  proibido): s5a/s5r/s5x/s5y → o serviço 67 aparece no impacto com `reason: not-applicable` e `registrationStillAccepts: true` (antes:
  vazio); r7a → aviso com perda em 2027-01-01 `no-line`; 169 encerradas → limite com `vigentOnDate` 170; IT oficial → sem limite, impacto
  ou aviso, plano igual (`edb2c381d29e316e`); catálogo conferido depois — os 7 `CHECKSUM TABLE` iguais aos do gate, produtos 65–68
  excluídos, nenhuma transação aberta. Provado também pelo adversarial: o selo do GET não mudou (11.591 comparações HEAD × novo, 0
  divergências) e a D-IB48 recusa antes de ler fontes e de abrir o banco.

### 11.21 ⚠️ Rodada 8 — questões para o Valdo (dos gates do delta da Rodada 7; recomendação entre parênteses)

- **Q-IB49** — Horizonte do aviso prospectivo DEPOIS da obrigação: hoje (D-IB45) ele vai até 01/01/2027 e some daí em diante —
  justamente quando a perda vira 422 (D-IB8; o gate adversarial provou: em 01/01/2027 e depois, um encerramento na data ou dias à frente
  passa calado). Desacoplar da janela do cadastro — horizonte = o MAIOR entre o fim da janela e a data da carga + 90 dias, sempre FORA do
  limite? *(Rec.: sim, data + 90 dias; o custo continua limitado pelas linhas do IT dentro do horizonte.)*
- **Q-IB50** — Serviço classificado por linha FUTURA (aceito pelo cadastro, ainda não na data da carga) cuja linha acaba antes da
  obrigação: o aviso só olha código aceito na data da carga e esse caso passa calado. O aviso deve partir de "aceito pelo cadastro"
  (a janela que o selo mostra) e não só de "aceito hoje"? *(Rec.: sim — caso raro, consulta barata, e é o que o usuário vê no selo.)*

### 11.22 Rodada 8 DECIDIDA (Valdo 2026-10-11: "siga as recomendações na Rodada 8") — D-IB49…D-IB50

| Decisão | O que fixa |
|---|---|
| **D-IB49** | Horizonte do aviso prospectivo (D-IB45) DESACOPLADO da janela do cadastro: o MAIOR entre o fim da janela (a obrigação, enquanto ela não chega) e a data da carga + 90 dias (`AHEAD_DAYS`), sempre FORA do limite; o relatório mostra o horizonte (`impactAheadUntil`). Depois de 01/01/2027 o aviso segue funcionando (data + 90) — é quando a perda vira 422 |
| **D-IB50** | O aviso parte também do código aceito só pelo CADASTRO na data da carga (linha futura na janela — o que o selo mostra) e não só do aceito na data do fato: entra quando, depois de passar a valer, deixa de ser aceito dentro do horizonte (a linha do aviso traz `acceptedFrom`). Código que ninguém aceita não entra |

**Execução**: §11.23.

### 11.23 Rodada 8 — execução (2026-10-11)

- `setes-api/src/shared/ibscbs-catalog/apply.ts` (só a rotina do Super carrega): `AHEAD_DAYS = 90` + `aheadHorizon(date)` (o maior entre
  `registrationWindowEnd` e data + 90); `lossesAhead` parte dos códigos aceitos na data do fato OU (D-IB50) pelo cadastro —
  `classificationRegistrationVerdicts` em LOTE só para os códigos da consulta do aviso que não são aceitos hoje —, conta a perda do aceito
  só pelo cadastro DEPOIS de passar a valer (`acceptedFrom`) e grava o horizonte em `relatorio.impactAheadUntil`.
- Testes jest (IBS/CBS 112/112): horizonte da carga de 10/10/2026 = 2027-01-08 (parâmetros da consulta do aviso conferidos); fim em
  01/01/2027 → perda em 02/01 (antes: fora da janela); fim em 08/01 → perda em 09/01, fora; depois da obrigação (carga em 05/01/2027 →
  horizonte 05/04/2027): fim em 31/03 → perda em 01/04, fim em 05/04 → fora; D-IB50: código sem presença hoje com linha futura do
  cadastro de 01/11 a 15/12 → aviso com `acceptedFrom` 2026-11-01 e perda em 2026-12-16; código que ninguém aceita não entra.
- **Provas ao vivo** (harness do gate adversarial: transação externa, commit proibido, serviço de teste 67 revivido só dentro dela):
  r8a — carga em 05/01/2027 com o 000001 encerrado em 31/03/2027 → aviso = serviço 67, perda em 2027-04-01, horizonte 2027-04-05
  (antes da D-IB49: vazio); r8b — 000001 encerrado antes da carga com linha futura de 01/11 a 15/12/2026 → impacto de hoje = serviço 67
  (`no-line`, `registrationStillAccepts: true`) E aviso = serviço 67 com `acceptedFrom` 2026-11-01 e perda em 2026-12-16; controle com
  o IT oficial v1.70 = sem limite, impacto ou aviso, horizonte 2027-01-08, plano igual (`edb2c381d29e316e`); catálogo conferido depois
  (os 7 `CHECKSUM TABLE` iguais), produtos 65–68 excluídos, nenhuma transação aberta.

- **Gate socrático do delta R8: 0.80 ✅** (nenhum defeito de correção) — correções sem decisão feitas: comentários de `impactAhead`/`lossDate`
  alinhados à D-IB49/D-IB50 (S8-1); título do teste de fronteira corrigido + testes do TOPO inclusivo do horizonte (perda no próprio dia do
  horizonte e linha nova que começa nele entram; um dia depois, não) + teste unitário de `aheadHorizon` (02→03→04/10/2026, depois da
  obrigação, 29/02/2028) (S8-2); três testes da D-IB50 — o mesmo serviço no impacto e no aviso, a consulta do cadastro que não roda quando
  todo código do aviso já é aceito hoje, aceito pelo cadastro que não perde não entra (S8-3); skill com a leitura das DUAS listas juntas e
  "no-line" qualificado (S8-4); limite conhecido da SOBREPOSIÇÃO e da recusa herdada (S8-5 → Q-IB52); campo morto `aheadUntil` removido
  (S8-6); nota de que desde 2026-10-03 o horizonte real é data + 90 (S8-7).
- **Gate adversarial do delta R8: 0.82 ✅** (sem HIGH/CRITICAL; harness DUPLO — o `apply.ts` novo e uma cópia do HEAD na mesma transação
  desfeita: 31 cenários "IGUAL fora do aviso", 169 encerradas conferidas contra o esperado; bordas do horizonte todas certas, inclusive
  virada de ano e 29/02; pior caso de custo 15.300 linhas no horizonte = +91 consultas e +345 ms numa carga de 6,4 s; catálogo central e
  produtos 65–68 conferidos antes/depois). MEDIUM (decisão → **Q-IB53**): carga que tira a aceitação de um código aceito SÓ pelo cadastro
  antes dela (linha futura some, perde presença ou passa a exigir tributação regular) não aparece em lista nenhuma — o HEAD também calava;
  LOW corrigido: `aheadHorizon` perto do fim do calendário não estoura para o ano 10000 (fica em 9999-12-31; teste); LOW do comentário =
  S8-1. Casos não testados que viraram jest: `impactAheadUntil` null no ato, `acceptedFrom` ausente quando o aviso parte da data do fato,
  bordas de `aheadHorizon`. IBS/CBS jest 117/117. Re-conferido ao vivo depois das correções: controle oficial igual (horizonte 2027-01-08,
  plano `edb2c381d29e316e`) e r8b igual.

### 11.24 ⚠️ Rodada 9 — questões para o Valdo (dos gates do delta da Rodada 8; recomendação entre parênteses)

- **Q-IB51** — O aviso mostra só a 1ª perda. Trazer também `acceptedAgainFrom` (o dia em que o código VOLTA a ser aceito dentro do
  horizonte)? O veredito de todas as datas candidatas já é calculado — custo zero — e evita reclassificar por um buraco temporário com
  sucessora já publicada (mais provável depois da obrigação). *(Rec.: sim.)*
- **Q-IB52** — "Estoque" de recusas herdadas: o impacto mede só o que ESTA carga mudou; serviço já recusado no faturamento por carga
  anterior (inclusive a sobreposição em que o selo diz "aceita") não reaparece em lista nenhuma. *(Rec.: não na carga — levar para a IB-2
  como PRÉ-VOO do faturamento antes de 01/01/2027, uma consulta por schema pela pergunta da peça; até lá, limite conhecido na skill — feito.)*
- **Q-IB53** — Carga que tira a aceitação de um código aceito SÓ pelo cadastro antes dela (linha futura da janela some da fonte, perde a
  presença ou passa a exigir tributação regular — o selo muda de "aceita" para "não aceita" e, depois da obrigação, a nota daria 422)
  deve aparecer no impacto? *(Rec.: sim — comparar também o veredito do CADASTRO antes × depois para os códigos que a data do fato já
  recusava antes, com `reason` e a marca `registrationOnly: true`, fora do limite; o caso do gate adversarial (adv8-d1…d3) vira teste jest.)*

### 11.25 Rodada 9 DECIDIDA (Valdo 2026-10-11: "siga as recomendações na Rodada 9") — D-IB51…D-IB53

| Decisão | O que fixa |
|---|---|
| **D-IB51** | O aviso prospectivo traz também `acceptedAgainFrom` — o dia em que o código VOLTA a ser aceito dentro do horizonte (buraco temporário com sucessora já publicada); ausente = não volta dentro do horizonte. Sai dos vereditos já calculados (custo zero) |
| **D-IB52** | O "estoque" de recusas herdadas (serviço que a data do fato já recusa por carga anterior — inclusive a sobreposição com o selo "aceita") NÃO entra na carga: vira PRÉ-VOO do faturamento na IB-2, antes de 01/01/2027 (uma consulta por schema pela pergunta da peça); até lá, limite conhecido na skill |
| **D-IB53** | O impacto compara também o veredito do CADASTRO antes × depois para os códigos que a data do fato já recusava antes da carga: o que o cadastro aceitava (linha futura da janela) e deixa de aceitar — a linha some, perde a presença ou passa a exigir tributação regular — entra no impacto com `registrationOnly: true` e o motivo, fora do limite |

**Execução**: §11.26.

### 11.26 Rodada 9 — execução (2026-10-11)

- `setes-api/src/shared/ibscbs-catalog/apply.ts` (só a rotina do Super carrega): D-IB53 — no "antes" (logo depois do FOR UPDATE, antes de
  gravar), além do veredito na data do fato, o veredito do CADASTRO em lote para os códigos que a data do fato recusa; no "depois", o
  cadastro é perguntado de novo só para os que ele aceitava — o que deixou de aceitar entra em `impact` com `registrationOnly: true`,
  `registrationStillAccepts: false` e o `reason`; D-IB51 — no laço do aviso, depois da perda, a 1ª data candidata seguinte com veredito
  aceito vira `acceptedAgainFrom`. D-IB52 no roteiro da IB-2 (§4) — nenhum código nesta rodada.
- Testes jest (IBS/CBS 119/119): D-IB51 buraco temporário (perda em 01/01/2027, volta em 05/01) × perda definitiva (sem o campo); D-IB53 as
  três causas (linha futura some → `no-line`, perde presença → `not-applicable`, exige tributação regular → `requires-regular`) +
  controle (futura de pé → nada no impacto); o teste da guarda de custo da D-IB50 passou a medir só o que o AVISO acrescenta.
- **Provas ao vivo** (harness do gate adversarial — transação externa, commit proibido): os casos do gate R8 adv8-d1/d2/d3 (antes
  calados) → impacto = serviço 67 com `registrationOnly: true` e `no-line`/`not-applicable`/`requires-regular`; controle adv8-d0 igual
  (aviso com `acceptedFrom` 2026-11-01 e perda em 2027-01-01); r9a (fim em 31/12/2026 e sucessora em 05/01/2027) → aviso com perda em
  2027-01-01 e `acceptedAgainFrom` 2027-01-05; controle com o IT oficial v1.70 = sem limite, impacto ou aviso, horizonte 2027-01-08,
  plano igual (`edb2c381d29e316e`); catálogo conferido depois (os 7 `CHECKSUM TABLE` iguais), produtos 65–68 excluídos, nenhuma
  transação aberta.
- **Gate socrático do delta R9: 0.80 ✅** (nenhum defeito de correção) — correções sem decisão feitas: comentários do `apply.ts` alinhados
  (`reason` com duas semânticas — data do fato × regra do cadastro nas linhas `registrationOnly`; "só a 1ª perda e a 1ª volta"; D-IB52 no
  lugar da Q-IB52; `lostAfterLoad` com a D-IB53); a D-IB53 pega também a SOBREPOSIÇÃO por construção (compara o veredito do cadastro, não o
  tipo da linha) — escrito no código e na skill; skill: `impact` agora também tem linhas pela regra do cadastro, "a volta NÃO garante o
  aceite até o horizonte", a sobreposição herdada segue fora "salvo quando esta carga tira a aceitação do cadastro"; testes novos:
  `registrationOnly` fora do aviso mesmo com linhas na consulta dele, D-IB53 na sobreposição antes e depois da obrigação, `acceptedAgainFrom`
  junto com `acceptedFrom`, volta NO horizonte entra e um dia depois não.
- **Gate adversarial do delta R9: 0.86 ✅** (sem HIGH/CRITICAL; harness DUPLO estrito × HEAD ed8aba1 — 88 de 88 cenários antigos iguais, mais os
  4 de volume; 20 ataques novos; ordem provada ao vivo: a leitura "antes" do cadastro é a 4ª consulta, antes da 1ª gravação; custo +1 consulta
  da peça por ensaio, +2 quando há código só do cadastro; catálogo e produtos 65–68 conferidos antes/depois). 2 LOW → **Q-IB54** (volta e
  perde de novo dentro do horizonte: a 2ª perda não aparece) e **Q-IB56** (volta por linha ainda não conferida pela Calculadora aparece como
  "não volta"); observação fora do delta → **Q-IB57**. Testes que fixam a semântica ATUAL até a decisão: só a 1ª volta; linha não conferida não
  é volta; o ato não compara o cadastro. IBS/CBS jest 124/124.

### 11.27 ⚠️ Rodada 10 — questões para o Valdo (dos gates do delta da Rodada 9; recomendação entre parênteses)

- **Q-IB54** — Trazer no aviso também `lostAgainFrom` (a 1ª perda DEPOIS da volta, dentro do horizonte)? O gate adversarial provou o caso
  (fim em 31/12, sucessora só de 05/01 a 06/01, horizonte 08/01: o aviso diz "volta em 05/01" e cala a perda de 07/01 — e a skill manda não
  reclassificar por buraco temporário). Sai dos vereditos já calculados, custo zero. *(Rec.: sim; a skill já avisa que a volta não garante o
  aceite até o horizonte.)*
- **Q-IB55** — Em que data o PRÉ-VOO da D-IB52 (IB-2) pergunta à peça? Perguntando "hoje", ele acusa o código cuja linha futura só começa
  depois e deixa passar o que vale hoje e acaba antes da obrigação. *(Rec.: na data da obrigação — depois dela, na competência a faturar —,
  mostrando ao lado o veredito de hoje e o selo: "recusa hoje → a nota sai sem o grupo" × "recusa na obrigação → vai dar 422".)*
- **Q-IB56** — Separar no aviso "não volta" de "volta, mas a sucessora ainda não foi conferida pela Calculadora" (A-IB1 — a linha está no IT
  mas sem presença)? Hoje sai `no-line` sem `acceptedAgainFrom` e a skill manda reclassificar (erro conservador). *(Rec.: sim —
  `pendingReturnFrom` com a data da linha não conferida, quando ela existe dentro do horizonte; o operador espera a próxima carga.)*
- **Q-IB57** — Regra do cadastro (D-IB29, anterior a esta rodada; observação do gate adversarial): com uma linha VIGENTE com presença que exige
  tributação regular e uma FUTURA aceitável na janela, `pickForRegistration` escolhe a vigente e recusa (`requires-regular`), embora a futura
  seria aceita — coerente com lista/salvar/selo. Preferir a linha ACEITA (presença e sem tributação regular) antes da só aplicável, nas duas
  pontas (vigente aceita → futura aceita → vigente aplicável → …)? *(Rec.: sim — "aceito" é `verdictOf` (D-IB47); muda a regra única de lista ×
  salvar × selo junto, com teste; nenhum serviço da Setes é afetado hoje.)*

### 11.28 Rodada 10 DECIDIDA (Valdo 2026-10-11: "siga as recomendações na Rodada 10") — D-IB54…D-IB57

| Decisão | O que fixa |
|---|---|
| **D-IB54** | O aviso prospectivo traz também `lostAgainFrom` — a 1ª perda DEPOIS da volta, dentro do horizonte (a volta não garante o aceite até o fim). Sai dos vereditos já calculados |
| **D-IB55** | (IB-2) O pré-voo do faturamento (D-IB52) pergunta à peça NA DATA DA OBRIGAÇÃO — depois dela, na competência a faturar — e mostra ao lado o veredito de hoje e o selo: "recusa hoje → a nota sai sem o grupo" × "recusa na obrigação → vai dar 422" |
| **D-IB56** | Sem volta aceita, o aviso traz `pendingReturnFrom` — a data da linha da FONTE que faria o código voltar se a Calculadora a conferisse (A-IB1: presença no SE e sem tributação regular no IT, ainda não confirmada); o operador espera a próxima carga em vez de reclassificar |
| **D-IB57** | A regra do cadastro (`pickForRegistration`, D-IB29 — lista, salvar e selo) prefere a linha ACEITA (`verdictOf`: presença e sem tributação regular) antes da só aplicável: vigente aceita → futura aceita → vigente com presença → futura com presença → vigente → futura |

**Execução**: §11.29.

### 11.29 Rodada 10 — execução (2026-10-11)

- **D-IB57** na peça `@shared/ibscbs-classification` (carregada pelo servidor — trocada de uma vez, `/health` ok): `pickForRegistration` tenta
  `accepts` nas vigentes e nas futuras antes da regra de presença. No catálogo REAL, só leitura: nenhum dos 173 códigos muda de aceitação
  hoje (68 aceitos pela regra antiga e pela nova). Testes: vigente que exige tributação regular × futura aceita → a futura; vigente aceita
  antiga × vigente mais nova com tributação regular → a aceita; nenhuma aceita → a vigente com presença (o 422 diz "exige tributação regular").
- **D-IB54/D-IB56** em `apply.ts`: no laço do aviso, depois da volta, a 1ª data candidata seguinte recusada vira `lostAgainFrom`; as linhas
  da fonte não conferidas (`unconfirmed`) com presença no SE e sem tributação regular, entre a perda e a volta (ou o horizonte), dão
  `pendingReturnFrom`. D-IB55 no roteiro da IB-2 (§4) — nenhum código.
- Testes jest (IBS/CBS + serviços 143/143): volta e perde de novo → `lostAgainFrom` 2027-01-07; sucessora não conferida → `pendingReturnFrom`
  2027-01-05; sem presença no SE ou exigindo tributação regular → sem o campo; linha não conferida segue não sendo volta.
- **Provas ao vivo** (harness do gate adversarial — transação externa, commit proibido): adv9-a1 → perda 2027-01-01, volta 2027-01-05,
  `lostAgainFrom` 2027-01-07 (antes: a 2ª perda sumia); adv9-a3 → perda 2027-01-01 com `pendingReturnFrom` 2027-01-05 (antes: "não volta");
  s4b com o estado pré-futuro → impacto vazio (antes: `registrationOnly` `requires-regular` — o cadastro escolhia a vigente que exige
  tributação regular; agora escolhe a futura aceita de 01/12); controle com o IT oficial v1.70 = sem limite, impacto ou aviso, horizonte
  2027-01-08, plano igual (`edb2c381d29e316e`); catálogo conferido depois (os 7 `CHECKSUM TABLE` iguais), produtos 65–68 excluídos.
- **Gate socrático do delta R10: 0.76 ✅** (sem defeito de correção dentro do decidido; consultas só de leitura: a D-IB57 não muda
  nenhum código do catálogo real DIA A DIA de 2026-10-11 a 2027-04-01 — 173 linhas para 173 códigos, sem sobreposição; nenhum
  `tb_service_ibscbs` ativo na Setes) — correções sem decisão feitas: `pendingReturnFrom` só SEM volta aceita (texto literal da D-IB56; o
  código emitia também antes da volta — o §11.29 dizia "entre a perda e a volta"); comentários do `apply.ts` ("outra linha vigente ACEITA");
  skill: tirado "só a 1ª perda aparece", o pendente não diz até quando a linha vale nem pega a que começa antes da perda, a 3ª perda não
  aparece; testes: pendente NO dia da perda (o caso mais comum da A-IB1), sem pendente quando há volta aceita, a D-IB57 pelas TRÊS portas
  do cadastro (lista, 422 do salvar, selo) com a divergência da data do fato fixada (→ Q-IB58). 2 MEDIUM de decisão → **Q-IB58**/**Q-IB59**.
- **Gate adversarial do delta R10: 0.80 ✅** (sem HIGH/CRITICAL; harness TRIPLO — novo × apply do HEAD com a peça nova × HEAD inteiro, numa
  transação desfeita: 133 de 133 execuções iguais tirando os campos novos; D-IB57 muda o relatório só em s4b (intencional) e adv10-c3
  (coerente); catálogo real em 96 datas: zero mudança de veredito, de linha escolhida, de lista (17 filtros × 4 datas), de exibição/selo/422;
  ganho provado: com a D-IB57 tudo o que a lista mostra o salvar aceita — no HEAD, filtrando pelo nome da linha antiga, a lista mostrava e o
  salvar dava 422; volume 7.659 não conferidas sem custo extra). MEDIUM = o mesmo da Q-IB59 (sobreposição entre VIGENTES: selo "aceita"
  pela antiga × faturamento recusa pela mais nova — nasce de carga válida); LOW novo → **Q-IB60** (a linha que o cadastro escolhe não
  precisa valer na obrigação); LOW `pendingReturnFrom` com volta = corrigido acima; LOW doc = corrigido. Casos não testados que viraram
  jest: 2ª perda no último dia do horizonte e um dia depois, 3ª perda ignorada, sucessora bloqueada não é pendente, lista × salvar
  (toda linha da lista passa no salvar). IBS/CBS + serviços 148/148.

### 11.30 ⚠️ Rodada 11 — questões para o Valdo (dos gates do delta da Rodada 10; recomendação entre parênteses)

- **Q-IB58** — (IB-2) Serviço salvo com vigente que exige tributação regular + futura aceita na janela (salvável desde a D-IB57): ANTES da
  obrigação a nota sai SEM o grupo IBS/CBS (nunca 422 — como na D-IB34/D-IB41); DEPOIS, a futura já vale (ou o 422 da D-IB8)?
  *(Rec.: sim; registrar no roteiro do §4 ao lado da D-IB41.)*
- **Q-IB59** — Sobreposição de duas VIGENTES (a antiga aceita × a mais nova que exige tributação regular): pela D-IB57 o selo diz "aceita"
  enquanto o faturamento (linha vigente mais nova) recusa — hoje, na obrigação e depois; o estado nasce de uma carga válida. (a) Aceitar
  como limite conhecido da D-IB52 (o pré-voo da D-IB55 pega), com a divergência fixada em teste e escrita na skill; (b) o cadastro olha,
  entre as VIGENTES, só a MAIS NOVA (a da data do fato) e aplica o "aceita antes" só à janela futura — fecha esta divergência e também a
  sobreposição antiga da D-IB52 no selo. *(Rec.: (b) — o gate adversarial mostrou que o estado nasce de carga válida e dura até a próxima;
  "aceito" e "qual linha" passam a ser a mesma regra nas duas pontas para as vigentes; no catálogo real hoje não muda nada (0
  sobreposições).)*
- **Q-IB60** — A linha que o cadastro escolhe na janela não precisa valer NA obrigação: vigente que exige tributação regular × futura aceita
  que acaba antes de 01/01/2027 salva hoje e vira "não aceita" no meio do caminho (a variante "vigente sem presença" já existia antes da
  D-IB57). O cadastro deve exigir que a linha escolhida valha em 01/01/2027 (ou, depois dela, na data de hoje)? *(Rec.: não — o aviso
  prospectivo (D-IB45/D-IB50) já lista a perda com data; registrar como limite conhecido na skill.)*
