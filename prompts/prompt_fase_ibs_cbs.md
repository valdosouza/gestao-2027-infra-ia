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
**Estado**: **⏯ 2026-11-01: D-IB113 + D-IB120 PUBLICADAS (sql/73 aplicado, carga do catálogo gravada, setes-api/sql/app no `main`, no ar e no GitHub) — a D-IB115 está cumprida e a D-IB98 CAI: em P, um serviço e uma nota primeiro (§13.8, fim).** (antes:) **⏯ 2026-11-01: D-IB113 EXECUTADA em worktree (`D:\Gestao2027\ib113`, branch `ib113` — §13.8, fim): CST sem o grupo IBS/CBS recusado no ERP pelo veredito único (`cst-without-group`), sql/73 provado e NÃO aplicado, gates 0,76/0,86 sem HIGH; **D-IB120** (Valdo: o boot recusa com CST de indicador desconhecido em uso) executada; ⏳ Q-IB121 + A-IB120…A-IB122 aguardam o Valdo; publicar com "vai" (merge do `main` antes) — com ela no ar a D-IB115 está cumprida (a prova em H já passou).** (antes:) **⏯ 2026-11-01: D-IB99 EXECUTADA em worktree (`D:\Gestao2027\ib99`, branch `ib99` — §14.1–§14.3): D-IB100 (Valdo: peça PRÓPRIA `tb_establishment_ibscbs_assessment`, revê a letra da D-IB7; D-IB24 não vem junto), migration 076 + seed sql/71 provados em schema descartável, recusa no `issueInvoice` para toda nota, sub-recurso + aba "Regime IBS/CBS"; gates 0,76/0,72 sem HIGH; **D-IB101** (Valdo, Q-IB104 = (a): a opção nunca muda o que uma nota já leu — fronteira = maior entre hoje e a última nota viva; gates do delta 0,74/0,74; §14.4); **D-IB102** (Q-IB105 = (a): 2/3 só com opSimpNac 3/4 gravado; gates do delta 0,76 · re-prova 0,86; §14.5); **D-IB103** (Q-IB107 = (b): a fronteira conta só as notas do ERP web; re-prova 0,78/0,80; §14.6); **D-IB104** (Q-IB106 = (a): a aba avisa quem também emite pelo ERP Desktop; §14.7); **D-IB105** (Q-IB108 = (a): aviso não bloqueante ao tirar do Simples com opção futura 2/3 — a EXECUTAR na `ib99` antes da janela; §14.8); NADA mergeado — entra no `main` depois do bloco de privilégios, com o "vai".** (antes:) **⏯ 2026-10-31: D-IB99 (§14) — o regime de IBS/CBS vira CONFIGURAÇÃO datada por estabelecimento (revê a D-IB66); a Q-IB1 deixa de ser questão do sistema (é dado da Setes); escolher o regular grava e o faturamento recusa até o cálculo existir; no ar antes de 01/01/2027.** (antes:) **⏯ 2026-10-15 (tarde): IB-3 PUBLICADA (§13 — D-IB76…D-IB98; api e4af7aa · nfse ba78074 · app fbc2fac; 007 em produção) — D-IB98: nenhum serviço classificado em produção até a prova em H passar (fisco de H com E1000); RETOMAR pela prova em H (§13.8).** (antes:) **⏯ 2026-10-15: IB-2 EXECUTADA na worktree `setes-api-ib2` (branch `ib2`) — Rodada 1 D-IB62…D-IB73 (§12.6), execução (§12.7), gates 0,74/0,80 + D-IB74/D-IB75 e retrabalho (§12.8: trava da presunção provada e corrigida — 1213; pré-voo pela união por cliente); setes-api 1899/1899; PUBLICADA 2026-10-15 (api cfe9409 · sql 7cdce7e; 070 aplicada em produção); Q-IB76 aberta; próximo = IB-3.** (antes: 2026-10-14 Rodada 0 da IB-2) (antes:) **IB-1 FECHADA no dev (2026-10-10, 2ª sessão — §11.1…§11.6 = PONTO DE RETOMADA): gates socrático 0.66→0.75 ✅ e adversarial 0.80 ✅ (retrabalho com teste: Calculadora vazia recusada, conferência por linha/data — A-IB2, o ato da carga tem PLANO, CHECK conferido no boot + CHECK nas colunas congeladas, orçamento de memória do xlsx, autor da classificação), passeio logado feito (achado corrigido: cIndOp sem o "local do fornecimento" — 7 pares iguais), catálogo de campos da interface services (seed 62 + caminho do payload); código COMMITADO só pelos caminhos da IB-1 (§11.6 — api e635fef · sql 5dcede9 · app 27cc7a6, PUBLICADO; Infra-IA integrada e commitada); **Rodada 3 DECIDIDA e EXECUTADA (§11.7/§11.8 — D-IB28…D-IB33, A-IB1/A-IB2 confirmadas; gates do delta 0.72/0.74 ✅; não commitada); Rodada 4 Q-IB34…Q-IB38 aberta (§11.9 — Q-IB34 antes de dezembro)**; Rodada 3 Q-IB28…Q-IB33 + confirmar A-IB1/A-IB2 aguardam o Valdo.** (antes: IB-1 implementada na 1ª sessão) (antes: IB-0 + Rodada 2 — §10.5) (antes: IB-0 com parecer do
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
**D-IB58** (serviço salvo com a vigente que exige tributação regular + futura ACEITA na janela — salvável desde a D-IB57: ANTES da
obrigação a nota sai SEM o grupo IBS/CBS, nunca 422, como na D-IB34/D-IB41; DEPOIS, a futura já vale — ou o 422 da D-IB8) · **D-IB59**
(entre as VIGENTES o cadastro olha só a MAIS NOVA — a mesma linha da data do fato: selo e faturamento concordam para as vigentes) ·
D-IB47 (a pergunta do faturamento é o VEREDITO da peça na data do fato — `classificationVerdictAt`/`classificationVerdictsAt` (lote),
com o MOTIVO `no-line`/`not-applicable`/`requires-regular` para o 422 legível; a MESMA que a carga do catálogo usa no impacto; o selo
usa `classificationAcceptedForRegistration`; "aceito" = `verdictOf`, UMA definição — nunca re-derivar `applicable && !requiresRegular`) ·
limite TOCTOU do §11.8 (PUT que leu o catálogo antes de uma carga pode gravar código que acabou de perder a presença — a IB-2 barra) ·
limite do §11.11 (excluir o serviço não mata a peça 1:1 `tb_service_ibscbs` — todo leitor exige o produto vivo) · **D-IB52 (PRÉ-VOO do
faturamento antes de 01/01/2027: listar, por schema, os serviços cuja classificação gravada a data do fato JÁ recusa — o "estoque" que o
impacto da carga não mostra — desde a D-IB59, o caso em que o selo diz "aceita" e o faturamento recusa é só o do serviço aceito por
uma linha FUTURA (D-IB58); uma consulta por schema pela pergunta da peça —
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

- **Q-IB1 Regime de IBS/CBS da Setes em 2027 — PRAZO 30/10/2026.** ➡️ *(2026-10-31: deixa de ser questão do SISTEMA — o regime vira configuração de cada estabelecimento, D-IB99 §14; a resposta da Setes é dado na tela dela.)* ⏳ *(2026-10-20, rodada "uma pergunta por vez": o Valdo pediu registrar EM ABERTO — decisão com o contador até 30/10; para o sistema, (a) = caminho mais curto, (b)/(c) antecipam a porta de cálculo para dezembro.)* (a) não optar: IBS/CBS no DAS (`regApIBSCBSSN` 1) · (b) regime regular
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
   `exigeGrupoTributacaoRegular`, `permiteDiferimento`, `possibilidadeCreditoPresumido` e — visto em 2026-11-01, D-IB113 —
   `exigeGrupoIbsCbs`, o `ind_gIBSCBS` do CST que o fisco consulta no E0961); NBS (`/dados-abertos/nbs/lista`, 920 códigos);
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

### 11.31 Rodada 11 DECIDIDA (Valdo 2026-10-11: "siga as recomendações na Rodada 11") — D-IB58…D-IB60

| Decisão | O que fixa |
|---|---|
| **D-IB58** | (IB-2) Serviço salvo com a vigente que exige tributação regular + futura ACEITA na janela (salvável desde a D-IB57): ANTES da obrigação a nota sai SEM o grupo IBS/CBS (nunca 422 — como na D-IB34/D-IB41); DEPOIS, a futura já vale (ou o 422 da D-IB8). Registrado no roteiro do §4 |
| **D-IB59** | (b) Entre as VIGENTES o cadastro (`pickForRegistration` — lista, salvar, selo, exibição) olha só a MAIS NOVA — a mesma linha que a data do fato usa (`findClassificationAt`); a preferência pela ACEITA (D-IB57) vale só na janela FUTURA. Fecha a divergência selo × faturamento na sobreposição de vigentes — a da D-IB57 e a antiga da D-IB52 no selo |
| **D-IB60** | O cadastro NÃO exige que a linha escolhida valha na obrigação: a futura aceita que acaba antes de 01/01/2027 salva hoje e vira "não aceita" no meio do caminho — o aviso prospectivo (D-IB45/D-IB50) lista a perda com data. Limite conhecido na skill |

**Execução**: §11.32.

### 11.32 Rodada 11 — execução (2026-10-11)

- **D-IB59** na peça `@shared/ibscbs-classification` (carregada pelo servidor — trocada de uma vez, `/health` ok): `pickForRegistration`
  usa só a vigente mais nova (`current[0]`) e tenta `accepts` nas futuras. No catálogo REAL, só leitura: 173 códigos × 173 dias (2026-10-11
  a 2027-04-01), nenhuma sobreposição de vigentes, nenhuma diferença contra a regra da Rodada 10.
- **Achado na prova ao vivo, corrigido sem decisão** (mantém a invariante da D-IB29 "lista e salvar nunca discordam"): a lista de apoio
  filtrava LINHAS pelo nome antes da escolha — filtrando pelo nome da linha antiga de uma sobreposição, a escolha só via essa linha e
  oferecia o código que o salvar recusa. Agora o filtro escolhe CÓDIGOS (subconsulta por qualquer linha do código) e a escolha vê todas as
  linhas. Ao vivo no MariaDB real: sem filtro = 68 códigos (= os aceitos), filtros por código e por nome certos, 1–56 ms; pela ferramenta
  do gate adversarial R10 (estado forjado em transação desfeita): o filtro pelo nome da linha antiga não oferece mais o 000001 (o HEAD
  oferecia). O fake de teste passou a emular o filtro (por código na forma nova, por linha na antiga) — o teste pega a regressão.
- Testes ajustados à D-IB59 (o comportamento antigo da sobreposição era fixado por eles): R7-S1 e ADV-R7-01 → `registrationStillAccepts:
  false` (o selo também deixa de aceitar); a "sobreposição" da D-IB53 → impacto vazio (o cadastro nunca aceitou pela antiga); o lote do
  cadastro → a vigente mais nova sem presença decide; novos: vigente aceita antiga × mais nova com tributação regular → a mais nova (recusa);
  mais nova sem presença × antiga aceita × futura aceita → a futura; a lista não oferece a sobreposição nem filtrando pelo nome da antiga.
  IBS/CBS + serviços 149/149.
- **Provas ao vivo** (harness do gate — transação externa, commit proibido): s5a (sobreposição) → impacto com `registrationStillAccepts:
  false` (antes `true`); p1-overlap-reg (o MEDIUM do gate R10) → cadastro, salvar, selo, exibição e data do fato concordam
  (`requires-regular`) em 11/10, 15/11, 01/12/2026 e 01/01/2027; controle com o IT oficial v1.70 = sem limite, impacto ou aviso, plano igual
  (`edb2c381d29e316e`); catálogo conferido depois (os 7 `CHECKSUM TABLE` iguais), produtos 65–68 excluídos.
- **D-IB58** no roteiro da IB-2 (§4); **D-IB60** limite conhecido na skill — nenhum código.
- **Gates do delta R11**: socrático e adversarial EM EXECUÇÃO no momento do commit — o Valdo pediu "save tudo" (commit e push antes do resultado; as 19 falhas da bomba-relógio do Banco Inter ficam para outra sessão). O resultado dos dois gates entra na próxima rodada (§11.33) e, se trouxer achado objetivo, vira correção com teste num commit próprio.

### 11.33 Gates do delta da Rodada 11 (rodaram depois do commit 6201fbf — "save tudo" do Valdo) + correções

- **Socrático: 0.77 ✅** — os testes ajustados à D-IB59 são consequência legítima (nenhum afrouxado); "qual linha" e "aceito" são a mesma
  regra nas duas pontas para as vigentes. **Adversarial: 0.84 ✅** (sem HIGH/CRITICAL/MEDIUM) — enumeração exaustiva sem banco (221.566
  conjuntos de linhas × 4 datas): zero violação de "fato aceita ⇒ cadastro aceita", "cadastro aceita ⇒ fato aceita ou há futura aceita na
  janela", "vigente escolhida = linha da data do fato", "superada nunca é escolhida"; catálogo real 173 × 173 sem diferença; 130 execuções
  do harness triplo da carga sem erro (as 15 diferenças contra 05ccfd2 todas explicadas pela D-IB59); subconsulta da lista no MariaDB =
  semi-join pela PRIMARY, 1–8 ms; entradas `%`, `_`, `'; DROP --` voltam vazias.
- **Correções sem decisão** (commit próprio): (S11-2 = LOW 1 do adversarial) o LIMIT da lista é por LINHA e podia cortar o último código no
  meio — só as linhas antigas chegavam à escolha e a lista oferecia o que o salvar recusa; batendo no limite, o último código é descartado
  (teste com 399 + 1 códigos); (LOW 3 do adversarial / S11-5) o filtro por código/nome só casa com linha DA JANELA — o nome de uma linha
  vencida ou fora da janela não puxa mais o código; o comentário saiu de dentro da string do SQL (o mysql2 troca todo `?`); (S11-3) testes:
  caso positivo do filtro (antiga sem presença × nova aceita, filtrando pela antiga → oferece pela nova e o salvar aceita) e PROPRIEDADE
  "depois da obrigação o cadastro escolhe a mesma linha da data do fato" (27 formas × 3 datas); (S11-4) textos: `lostAfterLoad` (pela
  D-IB59 só linha FUTURA dá `registrationOnly`), comentário do teste da sobreposição, roteiro da D-IB52 no §4, cabeçalho da peça. IBS/CBS +
  serviços 153/153; lista no catálogo real igual (68 códigos sem filtro, hoje e depois da obrigação; filtros certos; 1–99 ms).

### 11.34 ⚠️ Rodada 12 — questões para o Valdo (dos gates do delta da Rodada 11; recomendação entre parênteses)

- **Q-IB61** — Linha antiga que VOLTA a valer dentro da janela (os dois gates acharam, provado): a vigente mais nova sem aceite acaba
  ANTES da obrigação por cima de uma antiga aceita em aberto — hoje cadastro, salvar, selo e lista recusam, mas a data do fato volta a
  aceitar no dia seguinte ao fim dela e na própria obrigação; a futura aceita salva (D-IB57), a volta da antiga não; o impacto marca
  `registrationStillAccepts: false` sem dizer que volta e o aviso fica vazio (pela regra antiga o aviso dizia "volta em X"). (a) limite
  conhecido — falha para o lado seguro (422), zero sobreposições no catálogo real —, escrito na skill, inclusive que o aviso não parte
  desse código; (b) a janela pergunta pela LINHA DO TEMPO: a volta da linha antiga dentro da janela conta como "futura aceita" na data da
  volta (mesmo mecanismo do `lossesAhead`); (c) só informar no impacto da carga quando o código volta (`acceptedAgainFrom`).
  *(Rec.: (a) — o estado depende de sobreposição que hoje não existe, a regra mudou duas vezes em duas rodadas, a falha é segura; reabrir
  para (b) se uma carga real trouxer sobreposição.)*

### 11.35 Rodada 12 DECIDIDA (Valdo 2026-10-11: "siga as recomendações na Rodada 12") — D-IB61

| Decisão | O que fixa |
|---|---|
| **D-IB61** | (a) A linha antiga que VOLTA a valer dentro da janela (sobreposição: a vigente mais nova sem aceite acaba antes da obrigação por cima de uma antiga aceita em aberto) é LIMITE CONHECIDO: o cadastro recusa hoje um código que a data do fato volta a aceitar antes da obrigação; o impacto não diz que volta e o aviso não parte dele. Falha para o lado seguro (422); zero sobreposições no catálogo real; reabrir para a "linha do tempo" (opção (b)) se uma carga real trouxer sobreposição de vigentes |

**Execução** (2026-10-11): nenhuma mudança de código de produção — um teste que FIXA a semântica (`src/__tests__/ibscbs-classification.test.ts`
"D-IB61 — limite conhecido": cadastro recusa em 10/10, data do fato aceita em 01/12 e na obrigação; padrão do conhecimento negativo da
D-A28 — para ninguém "consertar" sem nova decisão) + o limite escrito na skill `setes-api/skills/carregar-catalogo-ibscbs.md` com o gatilho
de reabertura. Gates socrático/adversarial NÃO rodados nesta rodada: o delta não toca código de produção (só um teste que fixa o
comportamento já provado pelos gates da Rodada 11 e documentação). Nenhuma questão aberta na fase depois desta rodada — próximo passo
da fase: a IB-2 (roteiro de leitura no §4).

## 12. IB-2 — EXECUTADA na worktree com gates (2026-10-15 — §12.6 decisões · §12.7 execução · §12.8 gates) — PUBLICADA 2026-10-15 (api cfe9409 · sql 7cdce7e) — ⚠️ RETOMAR PELA IB-3 (§12.8, fim)

**Escopo** (§4 + decisões já tomadas): (1) **congelamento ÚNICO** da classificação no ramo `tb_invoice_service` (`classification_code`,
`place_indicator_code`, `nbs` — colunas JÁ criadas pela migration 066 na IB-1, sem produtor; CST e indDest derivados) por UMA função da
peça `@shared/ibscbs-classification`, chamada pelos dois produtores — `buildServiceBranch` (billing) e `freezeServiceOrderIss` (OS; a Setes
fatura pela OS) — D-IB9; (2) **barreira por calendário** — antes da obrigação, sem classificação aceita a nota sai SEM o grupo IBS/CBS (nunca
422, inclusive no lote mensal); depois, 422 (D-IB8/D-IB34/D-IB41/D-IB42/D-IB58); a pergunta é o VEREDITO da peça na data do fato
(`classificationVerdictAt`/`classificationVerdictsAt` — D-IB47; `acceptedToday` é sinal de cadastro e nunca decide); a nota congelada nunca
reconsulta o catálogo (D-IB41); NBS pela regra única `nbsAcceptedSql` (D-IB40/D-IB42); (3) **obrigação pelo ENQUADRAMENTO DATADO** do
emitente (D-IB7/D-IB35 — `tb_establishment_tax_regime`, item B3 adiado da IB-1 porque troca os leitores de `tb_entity_tax` na fiscal-api
`src/erp/facts.ts` e na nfse-api `src/facts/service-facts.ts` — **a cópia do dual-run no setes-api NÃO existe mais** (F2a A3, §12.2) —
FRENTE DAS APIs FISCAIS: combinar antes — §12.5);
(4) **PRÉ-VOO** do faturamento (D-IB52/D-IB55 — antes de 01/01/2027 listar, por schema, os serviços cuja classificação gravada a data da
OBRIGAÇÃO recusa, com o veredito de hoje e o selo ao lado).

**Estado em 2026-10-11 (fim da sessão)**: dois levantamentos SÓ DE LEITURA foram lançados e INTERROMPIDOS a pedido do Valdo (nova sessão) —
nada foi integrado nem alterado. **Primeiro passo da próxima sessão: relançá-los em paralelo**:
- **Inventário** (agente Explore, very thorough): os dois produtores do ramo de serviço e a peça `@shared/invoice` (`issueInvoice`) — onde
  gravam `tb_invoice_service` e se alguém lê/escreve as 3 colunas da 066; o lote mensal e o faturamento individual da OS (como erros por
  ordem são reportados; onde um 422 da classificação apareceria); data do fato × competência (`dCompet`) na venda e na OS e o "hoje do
  estabelecimento"; colunas de `tb_entity_tax` e TODOS os seus leitores (setes-api, fiscal-api, nfse-api, views do `fiscal_api`) e se há
  rascunho de `tb_establishment_tax_regime` (`prompt_fase_ibs_cbs-ddl-ib1-rascunho.sql`); campos de IBS/CBS que os dois montadores do DPS
  já têm; o que falta na peça para congelar (veredito do cIndOp e da NBS na data); se o reenvio reconsulta o ramo; testes existentes.
- **Parecer do guardião** (agente `setes-conceito`): a peça do congelamento (nome, assinatura, o que congela, o "nada" antes da
  obrigação — coluna NULL × fato próprio com motivo), em que ponto da transação, como os dois produtores a chamam sem duplicar regra; a data
  que a peça recebe (emissão × COMPETÊNCIA — a obrigação é pela competência, Ato Conjunto nº 4/2026 § 1º); se o enquadramento datado entra
  já (D-IB35) ou fica a constante do Simples até o 1º cliente não optante — DDL mínimo pelo PADROES_BANCO, quem escreve, o que pedir à frente
  fiscal; o pré-voo como peça × relatório × script do Super; nomes (glossário de palavras ocupadas) e o que vira maquete.
- Depois: consolidar aqui (fatos com caminho:linha + modelo + **Rodada 1 da IB-2 — Q-IB62 em diante**, cada uma com recomendação) e
  combinar com a sessão das APIs fiscais o que tocar nos leitores dela. Nenhum código antes das decisões do Valdo.

**2026-10-14 (Valdo: "siga a ordem: retome a IB-2 pelo §12")**: os dois levantamentos foram RELANÇADOS em paralelo (Explore very thorough +
`setes-conceito`), só leitura; o condutor conferiu no disco os fatos que sustentam as questões (UPSERT do ramo, `dCompet`, E0322 no Anexo I,
trava D5, model 55 da conjugada, `fields[]` descartado no lote, catálogo sem vigência para cIndOp/NBS, dual-run removido, `tsx watch` na
árvore viva). Consolidação em §12.1–§12.5. Nenhum código; nenhuma escrita fora da Infra-IA.

### 12.1 Fatos (2026-10-14 — conferidos no disco; setes-api = `main` 9b85b51, a árvore de PRODUÇÃO)

| # | Fato | Onde |
|---|---|---|
| F1 | **Ninguém lê nem grava** `classification_code`/`place_indicator_code`/`nbs` de `tb_invoice_service` em nenhum repositório — só o DDL | `setes-api/src/migrations/sql/066_ibscbs_service_classification.sql:54-72` · `sql/03_schema_cliente_ddl.sql:462-464,477-479` |
| F2 | O ÚNICO escritor do ramo é `issueInvoice`; o `ON DUPLICATE KEY UPDATE` NÃO lista as 3 colunas → a nota **revivida herdaria a declaração da 1ª vida** se a 2ª não a regravar (inclusive NULL) | `setes-api/src/shared/invoice/invoice.ts:312-329` |
| F3 | Dois produtores de forma diferente: `buildServiceBranch` é PURA/síncrona, sem conexão, chamada dentro de `persistInvoiceOnce` (transação `:458-606`, retry `:444-451`, chamada `:510-512`); `freezeServiceOrderIss` é async e recebe a conexão (chamada `:1147`, antes do `issueInvoice` `:1161`). O fiscal da venda e da OS é resolvido FORA da transação, pelo pool | `billing/billing.repository.ts:770-797` · `service-orders/service-orders.repository.ts:1009-1054` · `billing.service.ts:404-429` · `service-orders.repository.ts:963-1006` |
| F4 | **`dCompet` do DPS = `tb_invoice.dt_emission`** = `todayFor` no faturamento. A competência do CONTRATO (`'YYYY-MM'`, `tb_contract_item_competence`) não chega à nota nem ao DPS — OS de competência 12/2026 faturada em janeiro sai com `dCompet` 2027-01 | `nfse-api/src/facts/service-facts.ts:284` · `invoice.ts:283` · `service-orders.repository.ts:600,731-743` |
| F5 | **E0322 (rejeição)**: "Se o bloco IBS/CBS for informado na DPS, então é obrigatório informar um item da NBS" — o grupo sem `cNBS` é rejeitado | `Infra-IA/setes-api/integracoes/nfse-adn/anexo1-dps.xlsx`, aba RN DPS_NFS-e, linha 324 |
| F6 | Um DPS = UM código nacional (422 `INVOICE_SERVICE_MULTI_CODE`), mas a trava D5 permite UMA OS aberta por cliente e a rotina mensal agrupa por cliente → N serviços numa declaração; o cIndOp muda pela NBS (licenciamento **100501** × desenvolvimento/manutenção/SaaS **100301** — §10.1 item 5) | `billing.repository.ts:773-777` · `setes-api/src/shared/service-order/service-order.ts:10` · §10.1 |
| F7 | A peça responde "na data" SÓ para o cClassTrib (motivos `no-line`/`not-applicable`/`requires-regular`); **cIndOp e NBS não têm vigência no catálogo** (`findPlaceIndicator` sem data; `nbsAcceptedSql`/`nbsExists` só `deleted`); a obrigação é só a constante do Simples; `indDest` não existe em repositório algum; a presunção do serviço (`tb_service_ibscbs` + `tb_service.nbs`) só é lida no módulo `services` | `setes-api/src/shared/ibscbs-classification/index.ts:41-45,88-163,292-304,313-322` · `sql/61_ibscbs_reference_ddl.sql:81-116` · `services.repository.ts:95-170` |
| F8 | A conjugada da venda tem `tb_invoice.model` **55**, e o ramo de serviço vai ao fisco como NFS-e (a nfse-api não filtra modelo) → o veredito do ramo pergunta pelo modelo **SE** (`MODEL_NFSE`), nunca pelo `model` da nota | `billing.service.ts:689` · `nfse-api/src/nfse/transmission.ts:117-125` |
| F9 | O "lote mensal" das D-IB34/D-IB42 é o **`POST /batch-invoice`** (a rotina mensal só INJETA itens, não fatura): uma transação por ordem — um 422 derruba só a ordem —, mas o `catch` devolve `message`+`code` e **DESCARTA `fields[]`** | `service-orders.service.ts:147-185,261-282` · `service-orders.repository.ts:594-776` |
| F10 | O reenvio na nfse-api **relê o ramo vivo** e remonta o DPS (só série/nDPS/Id ficam congelados no `fiscal_api`) → a declaração tem de estar NO ramo | `nfse-api/src/nfse/transmission.ts:306,315,345-357` |
| F11 | A **cópia do dual-run do setes-api foi REMOVIDA** na F2a A3 (commit `ca81906`, 2026-10-12): o único leitor do enquadramento é `buildEmitter` → núcleo `erp.entityTax` (fora da superfície `reading`), lido AGORA e não pela competência; nenhuma view lê `tb_entity_tax`; **D-F133**: proibido recompilar o núcleo na máquina de produção até a F3 | `service-facts.ts:159-205` · `fiscal-api/src/erp/facts.ts:238-259` · `fiscal-api/src/reading.ts:19-34` |
| F12 | DPS de hoje: só `cNBS` opcional sem produtor; grupo IBSCBS/cClassTrib/CST/cIndOp/indDest inexistentes; `DpsRegTrib` só opSimpNac 1/2/3 e não optante = 422 | `nfse-api/src/authority/types.ts:18,23-27,64` · `dps-builder.ts:168` · `service-facts.ts:192-195` |
| F13 | O setes-api de PRODUÇÃO roda `tsx watch` na árvore viva `D:\Gestao2027\setes-api` — salvar = deploy | processo `node … tsx … watch … src/server.ts` (2026-10-14) |

### 12.2 Correções de documentação (sem decisão)

- §12 (escopo, item 3) e §10.3 (d) citavam "a cópia do dual-run" — não existe mais (F11); o §12 foi corrigido, o §10.3 fica como história.
  **D-IB15 (fallback do grupo nas duas cópias) e D-IB27 ficam SEM OBJETO** — a F2a virou em 2026-10-14, antes do corte de 30/11.
- §4 (roteiro): "os dois montadores têm o campo" → hoje só o da nfse-api.
- Rascunho `prompt_fase_ibs_cbs-ddl-ib1-rascunho.sql`: o bloco C diz "migration 002 da nfse-api" — a 002 já é `002_cancel_event_code.sql` (a
  nfse-api vai até a 006): renumerar na execução (PADROES §11 regra 14); o B5.2 cita o leitor do dual-run.
- O comentário da 066 (`:9-10`) cita o dual-run — migration aplicada não se reescreve; registrado aqui.

### 12.3 Modelo (parecer do guardião, 2026-10-14)

**Conceito**: a **declaração IBS/CBS da nota** = o par cClassTrib + cIndOp e a NBS que a nota apresenta ao fisco, decididos UMA vez na
competência fiscal da nota (`dCompet`) e congelados no ramo. Fato gerador: o faturamento (evento E). Distinta da **presunção** do serviço
(`tb_service_ibscbs` + `tb_service.nbs` — o que o cadastro presume) e da **voz** do fisco (os valores). A **ausência** antes da obrigação NÃO é
fato — é consequência de regra sobre fatos já gravados (data + regime + calendário).

| Peça | Responsabilidade | Onde | Quem chama |
|---|---|---|---|
| **Regra** `ibscbsDeclarationAt` + `ibscbsObligationStart` | decide a declaração a partir das presunções, da data e do início da obrigação — `classificationVerdictsAt`/`verdictOf` (D-IB47), `findPlaceIndicator`, `nbsAcceptedSql` (D-IB40); reduz N itens a 1; aplica o calendário (omite antes, 422 depois); SEMPRE pelo modelo SE (F8); não conhece o ERP | `@shared/ibscbs-classification` | a composição; o pré-voo; na F4, a NF-e |
| **Peça** `readServicePresumptions(conn, s, inst, productIds)` | lê a presunção dos serviços (NBS + 1:1), só de produto VIVO (limite do §11.11) | `@shared/service-ibscbs` (nova) | a composição |
| **Peça** `emitterRegimeAt(conn, s, inst, date)` | enquadramento do emitente na data (forma: Q-IB66) | `@shared/entity-tax` | a composição; a janela do cadastro (D-IB29/D-IB35) |
| **Composição** `declareServiceIbscbs(conn, s, inst, { productIds, competenceDate })` | só combina as três — sem regra própria | `@shared/service-ibscbs-declaration` | os DOIS produtores e o pré-voo |
| `issueInvoice` | único ESCRITOR das 3 colunas — também no `ON DUPLICATE KEY UPDATE` (F2) | `@shared/invoice` | os produtores |

Esboço do tipo (o texto exato é da execução): `IbscbsDeclaration { group: { classificationCode, placeIndicatorCode } | null; nbs: string |
null; omitted: IbscbsOmission[] }` — `IbscbsOmission` = `not-classified | no-line | not-applicable | requires-regular | place-indicator |
nbs-missing | nbs-not-accepted | divergent`; só a peça o constrói; `omitted` NÃO é persistido (Q-IB65). **Congela** as 3 colunas; CST
(prefixo do cClassTrib) e `indDest` (0 enquanto o ERP não tiver o conceito — quando tiver, é fato da NOTA) ficam derivados no montador da IB-3.
**Ponto da transação**: com a conexão da transação do faturamento, depois da trava do pedido e logo antes do `issueInvoice` — billing depois
de `persistItemTaxes` (produtos de `serviceItems`, `billing.repository.ts:498-513`); OS depois de `freezeServiceOrderIss`, que relê os itens
sob a trava e passa a devolver os `productIds`. **Sem duplicar regra**: `InvoiceServiceInput.ibscbs` OBRIGATÓRIO e do tipo da peça — produtor
que não decide não compila. **Data**: o produtor calcula `dtEmission` UMA vez e passa a MESMA variável à composição e ao `issueInvoice`
(que deixa de chamar `todayFor` para ela); no lote, o relógio é por ordem (Q-TZ9).

**Fica de fora**: coluna/tabela de motivo da omissão (sem fato gerador nem consumidor; morreria em 01/01/2027) · chave de "envio
voluntário" (maquete nº 2 do §3.1 — o liga/desliga do envio é o calendário de LEIAUTE da nfse-api, D-IB13) · snapshot por item na NFS-e
(D-IB9 (b) rejeitada) · reconsultar o catálogo na transmissão (D-IB41).

**Maquetes desta onda**: (1) regra copiada nos dois produtores · (2) motivo da omissão persistido · (3) chave de envio voluntário · (4) "o
item de maior valor decide" · (5) re-derivar "aceito" (`applicable && !requiresRegular`) ou usar `acceptedToday` no faturamento (D-IB41/
D-IB47) · (6) CST/`indDest` gravados no ramo · (7) competência do CONTRATO como data fiscal · (8) tabela datada sem a D-IB24 · (9) pré-voo
com predicado SQL próprio · (10) — defeito, não maquete — a revivida herdando a declaração da 1ª vida (F2).

**Glossário (entra na skill `guardiao-conceitual.md` com a execução)**: *competência* tem dois sentidos — o mês do CONTRATO
(`tb_contract_item_competence.competence`) × a competência FISCAL da nota (`dCompet` = `dt_emission`); parâmetro da peça = `competenceDate`,
nunca `competence` solto · *classificação* = a linha do cClassTrib no catálogo; o serviço tem a **presunção**, a nota leva a **declaração**
(livre) · *regime* = `tb_entity_tax.tax_regime` (CRT, serve ao destinatário) × o enquadramento inteiro do emitente · evitar *barreira*
(ocupada na F2a) e *obrigações do DPS* (Anexo I) — usar `ibscbsObligationStart`.

### 12.4 ⚠️ Rodada 1 da IB-2 — questões para o Valdo (recomendação entre parênteses)

**A. A declaração**

- **Q-IB62 Unidade da declaração (fato E0322 — F5).** (a) **o grupo só vai com o TRIO aceito (cClassTrib + cIndOp + NBS); antes da obrigação,
  falta de qualquer um = o grupo inteiro é omitido (a NBS ainda pode ir sozinha, como `cNBS`, se aceita); depois, falta de qualquer um = 422
  — inclusive serviço sem NBS (`tb_service.nbs` NULL), caso que a D-IB42 não nomeia; CHECKs novos em `tb_invoice_service`: o par vem completo
  ou não vem, e `classification_code` presente exige `nbs`** · (b) componentes independentes (dá E0322) · (c) NBS obrigatória já antes da
  obrigação (contraria a D-IB42). *(Rec.: (a) — refina D-IB13/D-IB34/D-IB42 pelo fato do fisco.)*
- **Q-IB63 N itens → UMA declaração (F6).** (a) **divergência de qualquer componente entre os serviços da nota segue o MESMO calendário: antes
  da obrigação omite (motivo `divergent`); depois, 422 `INVOICE_SERVICE_MULTI_DECLARATION` com o campo por produto (molde do `MULTI_CODE`);
  o pré-voo lista os clientes com divergência; o contador harmoniza a classificação do que é faturado junto; se a divergência for REAL
  (ex.: licenciamento 100501 + manutenção 100301 na mesma OS), reabrir a trava D5 (OS por cliente × declaração) como decisão própria ANTES de
  dezembro** · (b) o item de maior valor decide (decisão silenciosa — maquete nº 4) · (c) declaração por item (= D-IB9 (b), rejeitada).
  *(Rec.: (a).)*
- **Q-IB64 Data da peça (F4).** (a) **`dt_emission` — que é o `dCompet` do DPS —, calculada UMA vez pelo produtor e passada ao `issueInvoice` e à
  peça** · (b) a competência do contrato na OS · (c) o `dhEmi` (instante da transmissão). *(Rec.: (a). **Para o contador, à parte**: faturar
  em dezembro o serviço de janeiro (rotina antecipada) sai SEM o grupo, e a OS de dezembro faturada em janeiro sai COM ele — `dCompet` = dia
  do faturamento está certo para a cobrança mensal da Setes?)*
- **Q-IB65 O "nada" antes da obrigação.** (a) **as 3 colunas NULL, sem motivo persistido; o motivo volta no RESULTADO do faturamento
  (`ibscbs: declared | omitted[]`) e vira contador no relatório do `batch-invoice` (molde da D26); como o lote descarta `fields[]` (F9), a
  MENSAGEM do 422 depois da obrigação nomeia o(s) serviço(s)** · (b) coluna/tabela de motivo (maquete) · (c) silêncio (um envio voluntário
  desligado em dezembro passaria sem ninguém ver). *(Rec.: (a).)*

**B. Obrigação e enquadramento**

- **Q-IB66 Enquadramento datado — ⚠️ DIVERGE da D-IB35.** (a) **assinatura datada JÁ (`emitterRegimeAt`, `ibscbsObligationStart(model,
  regime)`), lendo o `tb_entity_tax` atual sob a convenção NOMEADA "sem história, o enquadramento conhecido vale para toda data"; a tabela
  `tb_establishment_tax_regime`, a D-IB24 (CRT derivado) e o leitor por `dCompet` nascem com o 1º FATO datado — gatilhos: Q-IB1 (b)/(c) em
  30/10 (aí a tabela entra antes de 01/12), XSD da NT 009 (IB-5) ou 1º cliente não optante; item de agenda: conferir a Q-IB1 em 30/10** ·
  (b) D-IB35 ao pé da letra, já na IB-2, com a D-IB24 · (c) constante do Simples para todos. *(Rec.: (a) — no leiaute 1.01 nada muda no DPS
  da Setes em 01/01/2027 (o `regApIBSCBSSN` só existe na NT 009); a tabela sem a D-IB24 espalha o CRT em duas casas (maquete nº 10 — o motor
  de mercadoria lê `tax_regime`, `billing.service.ts:94`); o leitor está em produção na nfse-api e o núcleo não pode ser recompilado (D-F133).
  Quando entrar: rascunho B3 + `regEspTrib` (`special_tax_regime` — vai no MESMO grupo `regTrib` do DPS), sem `valid_until` (a linha
  seguinte fecha a anterior), CHECK pela PADROES §11 regra 11, o `establishment` grava só linha nova e altera só linha futura, backfill com
  piso 2000-01-01 e `WHERE NOT EXISTS`, contract em migration separada.)*
- **Q-IB67 Obrigação do NÃO optante na constante.** (a) **data única conservadora 01/10/2026 para qualquer subitem; MEI, ME/EPP e opSimpNac 4
  "pendente" = 01/01/2027; revisar com o 1º não optante (que hoje nem transmite — F12)** · (b) tabela por subitem já · (c) tratar como Simples
  (leniente — deixa passar desconformidade). *(Rec.: (a) — ajusta a dimensão "subitem" da D-IB13.)*
- **Q-IB68 Alcance da trava do faturamento.** (a) **vale para toda nota SE faturada pelo ERP (o setes-api é passivo e não lê a habilitação)** ·
  (b) só para estabelecimento com habilitação SE no `fiscal_api` (dependência nova do ERP no banco fiscal). *(Rec.: (a).)*
- **Q-IB69 cIndOp e NBS sem vigência no catálogo (F7).** (a) **limite conhecido: para eles a peça responde o estado do catálogo no MOMENTO
  do faturamento (o "na data" da D-IB47/D-IB55 vale inteiro só para o cClassTrib); conferir na próxima carga se a fonte oficial (Anexo VII,
  tabela NBS) traz data de vigência — se trouxer, vigência entra como linha, no molde do cClassTrib, em rodada própria** · (b) vigência para
  os dois já na IB-2 (DDL + carga). *(Rec.: (a) — sem fonte datada, vigência inventada seria maquete.)*

**C. Execução**

- **Q-IB70 Leituras dentro da transação.** (a) **presunção do serviço em leitura travante COMPARTILHADA (PADROES §9 regra 2; entra na ordem
  canônica entre pedido e nota); catálogo central SEM trava, como exceção documentada (travá-lo acopla todo faturamento ao `FOR UPDATE` da
  carga) — limite conhecido: a nota congela o catálogo do retrato da transação** · (b) tudo travante (o lote leva 409 durante a carga) · (c)
  tudo fora da transação (abre a corrida com a edição do serviço). *(Rec.: (a).)*
- **Q-IB71 Estrutura (ajusta a letra da D-IB9).** (a) **regra na peça de classificação; leitura da presunção em `@shared/service-ibscbs`;
  composição fina chamada pelos dois produtores; `ibscbs` obrigatório no tipo do ramo; o UPSERT do `issueInvoice` grava as 3 colunas também na
  revivida (F2); teste de cerca: só `@shared/invoice` escreve as colunas; CHECKs da Q-IB62 numa migration nova (número conferido entre as
  frentes — PADROES §11 regra 14 — e pelo `revisar-ddl`)** · (b) tudo dentro da peça de classificação (ela passa a conhecer o ERP e a NF-e
  não a reusa — na F4 a presunção vem da regra `tb_tax_rule_ibscbs`, não do produto). *(Rec.: (a).)*
- **Q-IB72 Forma do pré-voo (D-IB52/D-IB55).** (a) **script do Super `scripts/preflight-ibscbs.ts` com a MESMA composição em modo "só
  pergunta" (sem escrita), todos os schemas, mesmo operador/credencial da carga (D-IB32); universo = cada serviço ativo sozinho + os conjuntos
  REAIS (OS abertas e contratos vigentes POR CLIENTE — o que o lote de janeiro vai faturar, e o que pega a divergência da Q-IB63); data = a da
  obrigação (depois dela, a competência a faturar), com o veredito de hoje e o selo ao lado; rodar antes de 01/12 e de novo antes de 01/01;
  endpoint no módulo `services` só quando o 2º cliente emitir pela nfse-api** · (b) endpoint e tela já · (c) critério da Pesquisa Avançada
  (2ª definição de "aceito" em SQL — maquete). *(Rec.: (a).)*
- **Q-IB73 Onde executar (F13).** (a) **worktree própria do setes-api (branch `ib2`, molde da F2a), migration provada em schema descartável,
  merge na árvore viva só com o "vai" — com a suíte verde e os gates; nada se salva na árvore viva antes disso** · (b) direto na árvore viva
  (cada salvar vira deploy em produção). *(Rec.: (a).)*

### 12.5 Verificações e combinação com a frente das APIs fiscais

- **V1 — pré-condição da D-IB33**: a 066 está no `setes_setes`, que desde a janela é PRODUÇÃO (a máquina do Valdo). Confirmar com o grupo do
  sync que o `/service/sincronize` não faz REPLACE nem DELETE físico em `tb_service` (a FK `tb_service_ibscbs → tb_service` está viva) —
  pergunta ao grupo do sync (regra dos dois grupos; esta frente não investiga o setes-sync).
- **V2 — risco de CAIXA em janeiro**: com Q-IB62/Q-IB63 (a), o `batch-invoice` de 01/2027 dá 422 em toda OS sem declaração completa e ÚNICA.
  O que evita isso é o pré-voo (Q-IB72) + a classificação e a NBS de CADA serviço da Setes definidas pelo Valdo com o contador ANTES de
  dezembro (junto com a Q-IB1 até 30/10).
- **Frente fiscal**: com a Q-IB66 (a), a IB-2 toca SÓ o setes-api (+ migration dos CHECKs no schema do cliente) — nada na nfse-api nem no
  núcleo. A IB-3 acrescenta as 3 colunas ao SELECT de `readServiceInvoice` (nfse-api) e nunca reconsulta o catálogo; quando a tabela datada
  nascer, o leitor por `dCompet` vai na fonte de fatos da própria nfse-api (`service-facts.ts`), não no núcleo, até a F3 (D-F133); o GRANT
  `SELECT` em `setes\_%` já cobre a tabela (`nfse-api/ops/grants.sql:17`).
- **Esforço**: IB-2 segue em 2–3 sessões (§4) com a Q-IB66 (a); com a (b), +1–2 (D-IB24 + leitor na nfse-api + janela de deploy).

### 12.6 Rodada 1 da IB-2 DECIDIDA (Valdo 2026-10-15: "siga as recomendações da Rodada 1 da IB-2") — D-IB62…D-IB73

Cada D-IB*n* = a recomendação (a) da Q-IB*n* (§12.4), na íntegra. Numeração permanente; código e testes citam o nº.

| Decisão | O que fixa |
|---|---|
| **D-IB62** | unidade da declaração = o TRIO aceito (cClassTrib + cIndOp + NBS) — E0322; antes da obrigação, falta de qualquer um omite o grupo inteiro (a NBS pode ir sozinha, como `cNBS`, se aceita); depois, falta de qualquer um = 422, inclusive serviço sem NBS; CHECKs em `tb_invoice_service`: par completo ou nenhum, `classification_code` exige `nbs` — **refina D-IB13/D-IB34/D-IB42** |
| **D-IB63** | N serviços → UMA declaração: divergência segue o calendário (antes omite com motivo `divergent`; depois 422 `INVOICE_SERVICE_MULTI_DECLARATION` com o campo por produto); o pré-voo lista os clientes com divergência; divergência REAL reabre a trava D5 como decisão própria antes de dezembro |
| **D-IB64** | a data da peça é `dt_emission` (= `dCompet`), calculada UMA vez pelo produtor e passada ao `issueInvoice` e à composição. **Pendente com o contador** (não bloqueia): `dCompet` = dia do faturamento está certo para a cobrança mensal? |
| **D-IB65** | antes da obrigação as 3 colunas ficam NULL, sem motivo persistido; o motivo volta no resultado do faturamento (`ibscbs`) e vira contador no relatório do `batch-invoice`; a mensagem do 422 depois da obrigação nomeia o(s) serviço(s) (o lote descarta `fields[]`) |
| **D-IB66** | **DIVERGE da D-IB35**: assinatura datada já (`emitterRegimeAt`, `ibscbsObligationStart(model, regime)`), lendo o `tb_entity_tax` atual sob a convenção NOMEADA "sem história, o enquadramento conhecido vale para toda data"; `tb_establishment_tax_regime` + D-IB24 + leitor por `dCompet` nascem com o 1º fato datado (gatilhos: Q-IB1 (b)/(c) em 30/10 → tabela antes de 01/12; XSD da NT 009; 1º não optante). **Agenda: conferir a Q-IB1 em 30/10** — ⚠️ **REVISTA pela D-IB99 (2026-10-31, §14): a configuração datada nasce já, sem gatilho** |
| **D-IB67** | obrigação do não optante = data única 01/10/2026 para qualquer subitem; MEI, ME/EPP e opSimpNac 4 = 01/01/2027; revisar com o 1º não optante — ajusta a dimensão "subitem" da D-IB13 |
| **D-IB68** | a exigência vale para toda nota SE faturada pelo ERP (o setes-api não lê a habilitação do `fiscal_api`) |
| **D-IB69** | cIndOp e NBS sem vigência = limite conhecido (estado do catálogo no MOMENTO do faturamento); conferir na próxima carga se a fonte oficial traz vigência — se trouxer, entra como linha em rodada própria |
| **D-IB70** | presunção do serviço em leitura travante COMPARTILHADA dentro da transação (PADROES §9 regra 2, entre pedido e nota); catálogo central sem trava (exceção documentada); a nota congela o catálogo do retrato da transação |
| **D-IB71** | regra na peça de classificação; presunção em `@shared/service-ibscbs`; composição fina `@shared/service-ibscbs-declaration` chamada pelos dois produtores; `ibscbs` obrigatório no tipo do ramo; o UPSERT do `issueInvoice` grava as 3 colunas também na revivida; teste de cerca (só `@shared/invoice` escreve as colunas); CHECKs numa migration nova (número conferido — PADROES §11 regra 14 — e `revisar-ddl`) — **ajusta a letra da D-IB9** |
| **D-IB72** | pré-voo = script do Super `scripts/preflight-ibscbs.ts`, mesma composição em modo só-pergunta, todos os schemas; universo = serviços ativos sozinhos + conjuntos reais por cliente (OS abertas e contratos vigentes); data = a da obrigação (depois, a competência a faturar) com o veredito de hoje e o selo; rodar antes de 01/12 e de novo antes de 01/01 |
| **D-IB73** | execução em worktree própria do setes-api (branch `ib2`), migration provada em schema descartável, merge na árvore viva só com o "vai" (suíte verde + gates); nada se salva na árvore viva antes disso |

**Execução**: §12.7.

### 12.7 IB-2 — execução (2026-10-15, worktree `D:\Gestao2027\setes-api-ib2`, branch `ib2` — D-IB73; NADA na árvore viva)

**O que entrou** (setes-api; nada na nfse-api nem no núcleo — D-IB66 (a)):
- **Regra** na peça `@shared/ibscbs-classification` (`index.ts`, bloco "IB-2"): `ibscbsObligationStart(model, regime)` (D-IB66/D-IB67 —
  constante da obrigação legal: MEI/ME-EPP/pendente 01/01/2027, não optante 01/10/2026; **A-IB3**: opSimpNac desconhecido = data do não optante,
  o lado conservador; NF-e falha alto — F4), `evaluateIbscbsDeclaration` (reduz N serviços a UMA declaração na competência: falta → motivo,
  valores diferentes → `divergent`, cClassTrib pelo veredito da data — `classificationVerdictsAt`, cIndOp/NBS pelo estado do catálogo — D-IB69,
  SEMPRE modelo SE), `assertIbscbsDeclarable` (obrigatória e incompleta = 422 `INVOICE_SERVICE_IBSCBS_REQUIRED` ou
  `INVOICE_SERVICE_MULTI_DECLARATION`, `fields[]` por serviço e a mensagem NOMEIA os serviços — D-IB65), `IbscbsDeclaration` com MARCA de tipo
  (só a peça constrói), `ibscbsOutcomeOf`.
- **Peça nova** `@shared/service-ibscbs` (`readServicePresumptions` — presunção por produto, só produto vivo, `LOCK IN SHARE MODE` na
  transação — D-IB70) · `@shared/entity-tax` ganhou `emitterRegimeAt` (assinatura datada, convenção NOMEADA "sem história"; trava
  compartilhada na transação) · **composição nova** `@shared/service-ibscbs-declaration` (`declareServiceIbscbs` para o faturamento,
  `evaluateServiceIbscbs` só-pergunta para o pré-voo).
- **`issueInvoice`**: `InvoiceServiceInput.ibscbs` OBRIGATÓRIO (tipo da peça); o UPSERT do ramo grava as 3 colunas no INSERT **e** no
  `ON DUPLICATE KEY UPDATE` (a revivida nunca herda — F2); `dtEmission` OBRIGATÓRIO no lugar do `dtRecord?` (a nota e o evento E com a
  data que o produtor calculou — D-IB64); `InvoiceServiceDraft` = o ramo antes da declaração.
- **Produtores**: billing — `dtEmission` = a `baseDate` já calculada (a mesma dos vencimentos), declaração depois de `persistItemTaxes` e
  logo antes do `issueInvoice`, `invoiceDate` (cheque/automatismos) = a mesma data; OS — `dtEmission` na conexão da transação logo após as
  travas, `freezeServiceOrderIss` devolve `{ draft, productIds }` (relidos sob o lock), declaração antes da nota, automatismos com a mesma
  data. Resultado dos dois com `ibscbs: { declared, omitted[] }`; `batch-invoice` com `ibscbsDeclared`/`ibscbsOmitted` e `ibscbs` por linha
  (D-IB65). Swagger dos três endpoints atualizado (201/200 + o 422 novo).
- **Migration 070** `070_ibscbs_declaration_checks.sql`: `ck_invoice_service_ibscbs_pair` (par completo ou nenhum) +
  `ck_invoice_service_ibscbs_requires_nbs` (grupo exige NBS — E0322); NBS sozinha permitida. **Provada em schema descartável**
  (`scripts/prove-ibscbs-declaration-checks.ts`: aplicada 2×, 6 casos, 0 violação nas linhas do `setes_setes`, schema apagado). Espelho no
  canônico `sql/03_schema_cliente_ddl.sql` (repo `sql`, não commitado).
- **Pré-voo** `scripts/preflight-ibscbs.ts` (D-IB72): mesma composição, todos os schemas, universo (a) serviço ativo sozinho + (b) OS aberta
  e contratos vigentes por cliente, data da obrigação (depois, a competência), veredito de hoje + selo ao lado.
- **Glossário** na skill `guardiao-conceitual.md`: competência (2 sentidos), classificação × presunção × declaração, regime, barreira.
- **Conhecimento** (comentário no billing): as leituras do catálogo central são não travantes (D-IB70) e viriam antes do recomputo do saldo
  devolvível numa devolução — a devolução nasce só com itens P/M (pré-carga `p.kind IN ('P','M')`), sem ramo de serviço. ⚠️ Achado
  pré-existente (não desta onda): `resolveParcels` (`getPaymentTypeKinds`) e o `todayFor` com cache frio já fazem leitura não travante antes do
  `assertReturnableInTx` — candidato a gate do financeiro, fora da IB-2.

**1º pré-voo REAL (2026-10-15, só leitura, `setes_setes`)**: opSimpNac 3 → obrigação 01/01/2027; **os 45 serviços ativos estão SEM
classificação e SEM NBS** (hoje a nota sai sem o grupo — `[not-classified, nbs-missing]`; em 01/01/2027 = 422) e **todos os conjuntos reais**
(OS abertas + contratos vigentes em 2027-01) recusariam — **145 recusas** na data (serviços + conjuntos; parte vem do resíduo de teste
"TRILHA" da régua do Primeiro Cliente). É a V2 do §12.5 materializada: a classificação + NBS de cada serviço da Setes com o contador ANTES de
dezembro é PRÉ-REQUISITO do lote de janeiro.

**Suíte (2026-10-15, worktree)**: 1ª rodada completa = 2 falhas FORA da IB-2, ambas dependentes do CHECKOUT (a worktree sai com CRLF pelo
`autocrlf` e mora fora da árvore viva) — corrigidas só no teste, sem decisão: (1) `time-zone-fence.test.ts` dividia por `'\n'` e o `.` do JS
não casa `\r`, então `//.*$` não tirava o comentário de linha CRLF (acusava o comentário "nunca CURDATE()" do `cashier.repository.ts`, que nem
foi tocado) → `split(/\r?\n/)`; (2) `adversarial-f2a-r6-gate.test.ts` simulava o diretório de migrations da ÁRVORE VIVA enquanto o
runner-fixture lê o da PRÓPRIA árvore — numa worktree a 069 ficava fora da simulação → o diretório simulado é o da árvore do teste (idêntico
na árvore viva). Depois: **1893/1893** (31 ao vivo pulados; ao fim dos gates: **1899/1899** — §12.8) · `tsc` limpo. Lição: teste que lê texto de fonte divide por `/\r?\n/`; teste
que simula diretório simula o que o código LÊ.


### 12.8 Gates da IB-2 (2026-10-15) — socrático **0,74 ✅** · adversarial **0,80 ✅** (nenhum HIGH/CRITICAL) — Valdo: "siga as recomendações dos gates"

Os dois gates caíram junto com a sessão e foram RETOMADOS dos transcritos (o adversarial já atacava a versão com a trava corrigida);
nenhum schema descartável sobrou (`setes_ib2_%` = 0) e as sondas temporárias do adversarial foram apagadas por ele.

**Decisões da rodada** (Valdo: "siga as recomendações dos gates" — cada uma = a recomendação (a) do gate):

| Decisão | O que fixa |
|---|---|
| **D-IB74** (= Q-IB74 (a)) | opSimpNac DESCONHECIDO segue a A-IB3 (vale a obrigação do não optante, 01/10/2026 — JÁ), mas o 422 DIZ a causa e as duas saídas ("regime do Simples NÃO informado no estabelecimento — vale a obrigação do não optante: informe o regime na aba Tributação do estabelecimento ou classifique os serviços"); o pré-voo lista as institutions nesse caso (hoje: nenhuma — `setes_setes` tem opSimpNac 3). A-IB3 vira decidida |
| **D-IB75** (= Q-IB75 (a)) | o setes-app mostra a declaração JUNTO da IB-3, com prazo ANTES do lote de dezembro (≤ 30/11): relatório do lote com "saíram sem IBS/CBS: N" + motivo por linha, selo no resultado do faturamento individual. Até lá a declaração é só JSON + pré-voo do Super |

**Retrabalho feito na sessão (sem decisão)**:
1. **Trava da presunção — HIGH latente PROVADO e corrigido** (socrático): o SELECT único com LEFT JOIN travante intercalava as travas
   (produto A → intervalo da 1:1 ausente de A → produto B) e fechava ciclo com o `PUT /services/B` (que segura o produto B e INSERE a 1:1
   no intervalo) — **1213 provado em schema descartável, o PUT de quem classifica era a vítima**. `readServicePresumptions` agora faz TRÊS
   leituras travantes na ORDEM do PUT (tb_product → tb_service → tb_service_ibscbs): o faturamento espera o PUT em vez de cruzar com ele, e
   lê a classificação recém-gravada. Prova permanente: `scripts/prove-ibscbs-presumption-lock.ts` (forma antiga = 1213 CONFIRMADO · forma
   nova = PUT confirma e o faturamento lê `900002:000001`; schema `setes_ib2_lock_<pid>` apagado). Conhecimento: **SELECT travante com
   LEFT JOIN herda as travas de INTERVALO das linhas ausentes, na ordem da junção — trava de leitura que decide se toma por TABELA, na
   ordem de quem escreve** (candidato a regra do PADROES §9).
2. **Pré-voo pela UNIÃO por cliente** (socrático + ADV-IB2-01 MEDIUM, provado vermelho): a rotina mensal injeta os itens do contrato na OS
   ABERTA do cliente (trava D5) — a nota leva OS aberta ∪ contratos vigentes; o script perguntava pelas duas partes separadas e dava "0
   recusas" com 422 MULTI_DECLARATION no lote. Agora agrupa por cliente. 2º pré-voo real: **92 conjuntos por cliente · 137 recusas em
   01/01/2027** (todos os 45 serviços seguem sem classificação e sem NBS).
3. **Billing relê os itens SOB o lock** (D-IB71 no 2º produtor — socrático): `assertBillingItemsUnchanged` (mesmo critério de
   `listBillingItems`, leitura travante que não abre o retrato) antes da declaração; mudou no intervalo = 409 RESOURCE_BUSY. O TOCTOU geral do
   billing (ISS, totais) é pré-existente e fica registrado.
4. **Cinto da devolução** (socrático): devolução com ramo de serviço = erro de PROGRAMAÇÃO (falha alto) — a invariante do saldo devolvível
   não admite as leituras não travantes do catálogo antes do recomputo. **O pré-existente** (`resolveParcels`/`getPaymentTypeKinds` e o
   `todayFor` de cache frio já leem sem trava antes do `assertReturnableInTx` — risco de devolver mais que o saldo sob concorrência) virou
   **tarefa própria** (chip "Provar a invariante do saldo devolvível no faturamento").
5. **Mensagem do 422 agrupada por MOTIVO com "e mais N"** (ADV-IB2-03 LOW, provado vermelho): cortava em 600 caracteres e escondia serviços
   no relatório do lote (que descarta `fields[]`); teto de 12 nomes por motivo, nunca some calado.
6. **Cerca do escritor único reforçada** (ADV-IB2-02 LOW): a unidade é a CHAMADA `.query(…)` inteira (SQL + parâmetros) — pega `INSERT
   IGNORE`, `REPLACE`, `UPDATE … JOIN … SET sv.nbs` e o `??`; varre src/, scripts/ e as migrations .sql; exceção NOMEADA para a prova que
   escreve só no schema descartável; limite conhecido: tabela por VARIÁVEL.
7. **Texto "declarada" × "transmitida"** (socrático): até a IB-3, `declared`/`ibscbsDeclared` = CONGELADA no ramo, não prova de envio
   (interfaces + Swagger dos três endpoints).
8. Testes do gate promovidos a permanentes: `adversarial-ib2-gate.test.ts` (mensagem + lote) e `adversarial-ib2-preflight.test.ts` (união —
   a sonda do teste lia o mock FORA do `jest.isolateModules`, outra instância; corrigido).

**Provas**: setes-api **1899/1899** (31 ao vivo pulados) · `tsc` limpo · `swagger-parse` OK · as duas provas em schema descartável OK.

**Fica registrado (não decidido)**:
- **Q-IB76 — o `/billing/validate` não antecipa a recusa IBS/CBS** (adversarial, caso não testado): depois de 01/01/2027 "Validar" passa e
  "Faturar" devolve 422. (a) o validate acusa a declaração pela MESMA composição em modo só-pergunta (aviso antes da obrigação, bloqueio
  depois) · (b) só o pré-voo do Super. *Rec. (a) junto da IB-3/D-IB75 (tela e envio no mesmo ciclo do app).*
- Pré-voo: o universo da D-IB72 não inclui pedidos de VENDA abertos com serviço (conjugada 55) — limite conhecido (a Setes fatura pela OS).
- Notas de serviço gravadas pelo setes-sync ficam com as 3 colunas NULL (regra dos dois grupos; o leitor é da IB-3).
- `POST /services` × faturamento (o POST trava todos os produtos da institution) — só analisado, sem ciclo.

**Próximo**: "vai" do Valdo para levar a IB-2 à árvore viva (merge da branch `ib2` no `main` do setes-api → o `tsx watch` reinicia e a 070 é
aplicada pelo runner no boot/`db:migrate`; `npm run errors:gen` para os 2 códigos novos no catálogo central; `sql/03` no repo sql) e commits/
push (api · sql · infra). Depois: **IB-3** (nfse-api lê as 3 colunas e monta o grupo; DANFSe; D-IB75 no app; Q-IB76) e, antes de dezembro, a
classificação + NBS de cada serviço da Setes com o contador (V2) — o pré-voo é a régua.

**PUBLICADA 2026-10-15 (Valdo: "vai")**: merge fast-forward da `ib2` no `main` da árvore viva → o `tsx watch` reiniciou e o boot aplicou a
**070 em `setes_setes` às 11:42:54 UTC** (`/health` 200 em 2 s; `ck_invoice_service_ibscbs_pair` + `_requires_nbs` ativos); `errors:gen` = 162
códigos no catálogo central; GitHub: **api cfe9409 · sql 7cdce7e · infra (o commit desta seção)**. A worktree `setes-api-ib2` (branch `ib2`,
já no `main`) fica até a IB-3 começar. ⏯ **Próximo: IB-3** (nfse-api lê as 3 colunas e monta o grupo IBSCBS; DANFSe com o bloco; D-IB75 no
app; Q-IB76) — e, com o contador, a classificação + NBS dos 45 serviços da Setes antes de dezembro (o pré-voo é a régua).

## 13. IB-3 — PUBLICADA 2026-10-15 (§13.1–§13.8 — D-IB76…D-IB98; api e4af7aa · nfse ba78074 · app fbc2fac) — ✅ 2026-11-01: leiaute por ambiente PUBLICADO (nfse-api b6600c1, D-IB110…D-IB115) e **PROVA EM H (IB-4) PASSOU** (8014 com o grupo e 8015 só NBS autorizadas e canceladas em H; valores do fisco lidos) — classificar em P espera só a D-IB113 no setes-api (D-IB115) (§13.8, fim)

**Escopo** (§4 + decisões já tomadas): (1) a fonte de fatos da nfse-api lê a DECLARAÇÃO congelada no ramo (`classification_code`,
`place_indicator_code`, `nbs` — IB-2) e nunca reconsulta o catálogo (D-IB41); (2) o montador do DPS emite o grupo IBS/CBS (CST e `indDest`
derivados) e o `cNBS` (D-IB2/D-IB62); (3) calendário de LEIAUTE por ambiente × data (D-IB13/D-IB14 — absorve a D-NE31); (4) a VOZ IBS/CBS do
fisco lida do XML autorizado, write-once no `fiscal_api` + VIEW para o setes-api (D-IB10); (5) DANFSe com o bloco (NT 008); (6) D-IB12 (títulos ×
`vTotNF`); (7) D-IB75 — o setes-app mostra a declaração (resultado do faturamento + relatório do lote) ANTES do lote de dezembro (≤ 30/11);
(8) Q-IB76 — o `/billing/validate` antecipa a pendência. Depois: IB-4 (prova em produção restrita + envio voluntário em dezembro — D-IB16).

**Restrições conhecidas**: a nfse-api está em PRODUÇÃO (:3002, máquina do Valdo, `tsx` sem watch — reiniciar = deploy); **D-F133: proibido
recompilar o núcleo (`fiscal-api`) na máquina de produção até a F3** — o que exigir o núcleo precisa de outro caminho ou espera; o app tem
build web próprio (`build-web.ps1`).

**Estado em 2026-10-15**: inventário do código (Explore) e parecer do guardião (`setes-conceito`) lançados em paralelo, só leitura. Ao voltarem:
consolidar aqui (fatos com caminho:linha + modelo + **Rodada 1 da IB-3 — Q-IB77 em diante**, com a Q-IB76 na mesma rodada). Nenhum código
antes das decisões do Valdo. Se a sessão cair: relançar os dois levantamentos (ou retomá-los pelo id, se o transcrito sobreviver).


### 13.1 Fatos (2026-10-15 — inventário Explore + guardião; os que sustentam questão conferidos no disco)

| # | Fato | Onde |
|---|---|---|
| T1 | XSD 1.01: `infDPS/IBSCBS` (`TCRTCInfoIBSCBS`, opcional) é o ÚLTIMO filho de `infDPS`; filhos: `finNFSe` (só "0"), `indFinal`?, `cIndOp`, `tpOper`?, `gRefNFSe`?, `tpEnteGov`?, `indDest` (0 = o próprio tomador), `dest`?, `imovel`?, `valores/trib/gIBSCBS{CST, cClassTrib, cCredPres?, gTribRegular?, gDif?}`; `cNBS` fica em `serv/cServ` depois de `xDescServ` | `Infra-IA/setes-api/integracoes/nfse-adn/xsd/Schemas/1.01/tiposComplexos_v1.01.xsd:744-847, 838, 2207-2280, 2388-2431, 2625-2663, 1329-1362` |
| T2 | A NFS-e autorizada tem DOIS `IBSCBS`: `infNFSe/IBSCBS` (`TCRTCIBSCBS` — valores do FISCO, opcional: `valores{vBC, uf, mun, fed}` + `totCIBS{vTotNF, gIBS{vIBSTot…}, gCBS{vCBS}}`) e `infNFSe/DPS/infDPS/IBSCBS` (a NOSSA declaração); `parseNfseXml` lê "o 1º elemento com o nome" — se o fisco omitir o grupo dele, leríamos a nossa declaração como voz do fisco | `tiposComplexos_v1.01.xsd:142-148, 287-369, 452-617`; `nfse-api/src/authority/dps-builder.ts:255-266, 309-324` |
| T3 | `vTotNF` = `vLiq` em 2026 e `vLiq + vCBS + vIBSTot` a partir de 2027 (o 1.01 não distingue o Simples) — a divergência título × `vTotNF` (D-IB12) é provável já na competência 01/2027 e não aparece em dezembro nem em H antes de 2027 | `tiposComplexos_v1.01.xsd:454-460` |
| T4 | A fonte de fatos NÃO lê as 3 colunas; `buildDpsBase` monta `cServ` sem `cNBS` e nenhum grupo; `DpsInput` sem IBS/CBS ("sem IBS/CBS" no comentário); `LAYOUT_VERSION='1.01'` serve ao DPS E ao pedido de evento; não existe calendário de leiaute nem validação local contra XSD (o README do acervo diz "validação local antes de assinar") | `nfse-api/src/facts/service-facts.ts:25-37, 63-103, 245-303`; `authority/types.ts:17-20, 64, 87-100`; `dps-builder.ts:16, 168, 203-217, 247` |
| T5 | ⚠️ **A nfse-api de PRODUÇÃO carrega o núcleo pelo `src`, não pelo `dist`**: o `tsconfig` mapeia `fiscal-api` → `../fiscal-api/src/index.ts` e a produção roda `tsx` — a D-F133 protege o `dist` (que o setes-api usa), mas QUALQUER edição em `fiscal-api/src` entra na nfse-api de produção no próximo restart | `nfse-api/tsconfig.json:12-15`; `nfse-api/package.json:22`; processo de produção (`tsx … src/server.ts`) |
| T6 | O setes-api só lê o `fiscal_api` pela superfície `fiscal-api/reading` (porta "sem SQL próprio" + cercas) → leitor de view nova exige o núcleo (`dist`) = D-F133; `ErrorCodes` e a lista fechada `AMBIGUOUS_CAUSES` também moram no núcleo | `setes-api/src/shared/fiscal-voice/fiscal-voice.ts:13-26`; `fiscal-api/src/reading.ts:19-34`; `fiscal-api/src/errors/` |
| T7 | O escritor genérico da voz (`defineVoiceFamily`) só aceita tabelas `^tb_…_transmission_event$` — os valores do fisco gravados na tentativa seguem o molde `fillAuthorityData` (escrita da FAMÍLIA sob `InvoiceTx`), sem núcleo | `fiscal-api/src/voice/event-table.ts:68`; `nfse-api/src/nfse/repository.ts:286-299` |
| T8 | O DANFSe é da nfse-api (pdfkit) e lê o XML autorizado, nunca o banco; NT 008 pede o bloco IBS/CBS (CST/cClassTrib, cIndOp e localidade de incidência, base, alíquotas e efetivas por esfera, valores, "Total do IBS/CBS" e "Valor Líquido + IBS/CBS") | `nfse-api/src/nfse/danfse.ts:65-178`; `Infra-IA/setes-api/integracoes/nfse-adn/nt008.txt:316-407` |
| T9 | `/billing/validate` existe só na VENDA — a OS (como a Setes fatura) não tem validação; no app `canInvoice = issues.isEmpty` (qualquer issue BLOQUEIA) e `ValidationIssue` não tem severidade | `setes-api/src/modules/billing/billing.routes.ts:60`; `setes-app/apps/web/lib/app/modules/orders/domain/entity/order_entity.dart:321` |
| T10 | O app RECALCULA o relatório do lote pelas linhas (`fromEntries`/`merge`) — contadores do topo da API seriam descartados; nenhuma ocorrência de "ibscbs" no app | `setes-app/.../service_orders/domain/entity/service_order_entity.dart:419-484` |
| T11 | O XSD 1.01 do acervo não tem `indZFMALC` (NT 007) nem nada da NT 009; `opSimpNac` 1/2/3 — a IB-2 aceita '4' na regra da obrigação, a nfse-api recusa '4' (coerente até a NT 009) | `tiposSimples_v1.01.xsd` (`TSOpSimpNac`); `service-facts.ts:161-164` |
| T12 | Smoke em H existe (`npm run smoke:adn-h -- --nota <id> [--vai]`, banco descartável `fiscal_api_smoke`); testes ao vivo pelo harness com cópia `fiscal_api_adv_*` (`FISCAL_COPY_TABLES` precisa da tabela nova) | `nfse-api/scripts/smoke-adn-homologacao.ts:1-19`; `src/__tests__/live-harness.ts:23-26` |

### 13.2 Modelo (parecer do guardião, 2026-10-15)

A IB-3 **leva ao fisco a declaração que o ERP já congelou e guarda o que o fisco devolveu** — não decide classificação nem obrigação (IB-2).
Três peças da família NFS-e, nenhuma linha no núcleo (D-F133):

| Peça | Faz | Não faz |
|---|---|---|
| **Fonte de fatos** (`readServiceInvoice`) | lê as 3 colunas do ramo → `ServiceBranchRow.declaration {classificationCode, placeIndicatorCode} \| null` + `nbs`; confere a FORMA (par completo, grupo exige NBS, 6/6/9 dígitos) → 422 `FISCAL_DPS_INVALID` (código existente), nunca descarta calado | nunca lê `tb_service_ibscbs`, `tb_service.nbs` nem o catálogo (D-IB41 — cerca na SQL); nunca decide a obrigação |
| **Montador** (`buildDpsXml`) | `DpsIbscbs {cIndOp, cClassTrib}` → grupo como ÚLTIMO filho de `infDPS`: `finNFSe`=0, `cIndOp`, `indDest`=0, `valores/trib/gIBSCBS{CST = prefixo(cClassTrib), cClassTrib}`; `cNBS` em `cServ` | o tipo NÃO tem CST/`indDest`/`finNFSe` (derivados por construção) nem `tpRetPisCofins` (D-IB19) |
| **Valores do fisco** (`parseNfseIbscbs` + `fillAuthorityIbscbs` + migration 007 `tb_invoice_service_transmission_ibscbs`) | leitura pura, escopada no filho DIRETO de `infNFSe`, tudo-ou-nada; gravação write-once na tentativa que detém a chave, nos mesmos pontos de `fillAuthorityData` (transmissão P e consulta Q) | não é VOZ (não muda estado, sem kind/source); a voz A nunca espera os valores |

Mais: **calendário de leiaute** `authority/layout-calendar.ts` (`dpsLayoutAt(environment, instant)` — documento × ambiente × `valid_from`; o
evento com a linha dele) · **DANFSe** com o bloco lido do XML autorizado (declaração do `infDPS/IBSCBS` embutido + valores do `infNFSe/IBSCBS`)
· **setes-api**: declaração CONGELADA lida do ramo no detalhe faturado; declaração PREVISTA pela composição só-pergunta da IB-2 · **app**: só
renderiza (`ibscbs`, contadores pelas linhas, motivos por i18n). Glossário: **"valores do fisco (IBS/CBS)"** (dado gravado uma vez — não é voz)
e **"leiaute"** (versão por ambiente × INSTANTE da transmissão ≠ "obrigação" por competência). **Maquetes**: nfse-api re-derivando a declaração
ou decidindo a obrigação · CST/`indDest`/`finNFSe` como entrada ou coluna · chave/flag/variável/data de "go-live" ligando o grupo · ler "o 1º
IBSCBS" · espelhar o XML em 13 colunas sem leitor ou DANFSe lendo a tabela · valores como voz que prende a A · linha parcial com NULL ou coluna
de motivo · UPDATE de título por `vTotNF` · setes-api lendo o `fiscal_api` com SQL próprio · recompilar o núcleo "só por um código" · app
calculando omissão/obrigação/divergência · corrigir a declaração na nfse-api · calendário consultado por `dCompet`.
**Correções de documentação (sem decisão)**: §4 (linha IB-3) "enquadramento pela competência" — superado pela D-IB66, nada na IB-3; §6.4
"exibida no DANFSe" — cumpre-se pelo XML, não pela tabela; §3 item 10 chama de "voz A" o que é dado gravado uma vez.

### 13.3 Rodada 1 da IB-3 (recomendação entre parênteses) — DECIDIDA (Valdo 2026-10-15: "siga as recomendações da Rodada 1 da IB-3")

- **Q-IB76 (reformulada — fato T9)** Declaração PREVISTA antes de faturar. (a) **pela MESMA composição só-pergunta da IB-2, no validate da
  VENDA e no detalhe da OS ABERTA (a Setes fatura pela OS): antes da obrigação = AVISO num campo próprio da resposta (`ibscbs`), NUNCA em
  `issues` (no app toda issue bloqueia — T9); depois = issue de bloqueio com os mesmos códigos do 422; a CONGELADA lida do ramo no detalhe
  faturado; o app só renderiza** · (b) só o validate da venda · (c) só o pré-voo. *(Rec. (a), no ciclo do app da D-IB75.)*
- **Q-IB77 (G1) Tabela dos valores do fisco.** (a) **nasce na IB-3 só com `total_invoice_value` (vTotNF), `ibs_total_value` (vIBSTot) e
  `cbs_value` (vCBS) — NOT NULL, sem default — + `created_at`/`updated_at`/`deleted`; PK = a da tentativa, FK para ela; escritor único da
  família no molde `fillAuthorityData`; o resto do rascunho C1 fica no XML até surgir consumidor (carga do XML, molde D-IB27)** · (b) as 13
  colunas · (c) nenhuma tabela até o leitor no setes-api. *(Rec. (a).)*
- **Q-IB78 (G2) View e leitor no setes-api × D-F133.** (a) **a view nasce com o 1º leitor (conferência D-IB12) no deploy do núcleo da F3; se o
  gatilho vier antes (Q-IB1 (b)/(c) ou divergência real em janeiro que exija ato), decide-se uma "janela do núcleo" com checklist, molde F2a** ·
  (b) publicar a view já sem leitor · (c) SQL próprio no setes-api (fere a D-F33). *(Rec. (a) — a IB-3 não toca o núcleo.)*
- **Q-IB79 (G3) D-IB12 na IB-3 (fato T3).** (a) **só VISIBILIDADE (seção "No fisco" + DANFSe); pergunta ao contador junto da Q-IB1 (30/10):
  "no DAS, NFS-e com `vTotNF` > título — o que se faz?"; prévia da Calculadora com data de 2027 na IB-4; pendência/ato no ERP só com a resposta
  e o leitor da Q-IB78** · (b) pendência no setes-api já (exige o núcleo) · (c) a nfse-api compara com o total do ERP. *(Rec. (a).)*
- **Q-IB80 (G4) Valores ausentes/ilegíveis.** (a) **a voz A nunca espera; leitura pura, escopada no filho direto de `infNFSe`, tudo ou nada,
  FORA da transação (dentro, só o INSERT com valor conferido na faixa DECIMAL(15,2) — servidor sem modo estrito); ausente/ilegível = sem linha
  + alarme no log (rótulo fixo, sem conteúdo do XML — D-F100); a consulta seguinte preenche; releitura divergente = fica a 1ª + alarme; sem
  causa nova de ambíguo, sem coluna de motivo** · (b) ilegível = ambíguo e a A não grava · (c) linha parcial com NULL. *(Rec. (a).)*
- **Q-IB81 (G5) Calendário de leiaute.** (a) **mínimo já: constante congelada no adaptador (documento × ambiente × `valid_from` → versão),
  consultada pelo INSTANTE da transmissão e pelo ambiente congelado da tentativa; um consumidor (o `versao` do DPS); o evento com a linha dele;
  no 1.01 não decide o grupo** · (b) adiar para a IB-5. *(Rec. (a) — critério §6.5; veda a flag da NT 009.)*
- **Q-IB82 (G6) Guarda do envio em PRODUÇÃO (D-IB16).** (a) **a guarda é a ORDEM: prova em produção restrita pela instância de ensaio ANTES
  do deploy; em P o "liga" é a CLASSIFICAÇÃO do serviço (um serviço e uma nota primeiro), o recuo é desclassificar; nota recusada = cancelar e
  refaturar no ERP** · (b) data "grupo em P a partir de 01/12" no calendário · (c) flag/variável. *(Rec. (a) — (b)/(c) = maquete nº 2.)*
- **Q-IB83 (fato T5) O furo do "src do núcleo" na produção da nfse-api.** (a) **conhecimento registrado (prompt das APIs fiscais + PADROES
  §11): a D-F133 vale para o `src` TAMBÉM — nada se edita em `D:\Gestao2027\fiscal-api` enquanto a nfse-api de produção carregar o `src`; a IB-3
  trabalha em pasta-irmã `D:\Gestao2027\ib3\{nfse-api,fiscal-api}` (worktrees — o `../fiscal-api` do tsconfig resolve para o núcleo da
  worktree); o checklist de deploy da nfse-api ganha "núcleo da árvore viva com `git status` limpo e no commit conferido"; trocar a produção da
  nfse-api para o `dist` fica para a F3** · (b) trocar o `tsconfig` da produção da nfse-api para o `dist` já. *(Rec. (a) — não muda a produção
  fora de uma decisão da frente fiscal.)*
- **Q-IB84 (fato T4) Validação local contra o XSD.** (a) **não agora: a prova é a produção restrita (IB-4) + testes de ORDEM e FORMA do grupo
  contra o XSD lido do acervo (teste que extrai a sequência de `TCRTCInfoIBSCBS`/`TCInfDPS` do arquivo oficial); o README do acervo ganha nota
  "não há validação local — decisão Q-IB84"** · (b) dependência de validação XSD (libxml) na nfse-api. *(Rec. (a) — dependência nativa nova na
  máquina de produção não vale o risco agora.)*

| Decisão | O que fixa |
|---|---|
| **D-IB76** (= Q-IB76 (a)) | declaração PREVISTA pela composição só-pergunta no validate da venda e no detalhe da OS aberta; aviso em campo próprio antes da obrigação, issue de bloqueio depois; congelada lida do ramo; app só renderiza |
| **D-IB77** (= Q-IB77 (a)) | `tb_invoice_service_transmission_ibscbs` com vTotNF/vIBSTot/vCBS NOT NULL + auditoria, escritor único da família, resto no XML |
| **D-IB78** (= Q-IB78 (a)) | view + leitor no setes-api só com o 1º leitor, no deploy do núcleo da F3 (ou "janela do núcleo" decidida se o gatilho vier antes) |
| **D-IB79** (= Q-IB79 (a)) | D-IB12 na IB-3 = só visibilidade; pergunta ao contador com a Q-IB1; prévia da Calculadora 2027 na IB-4 |
| **D-IB80** (= Q-IB80 (a)) | valores ausentes/ilegíveis: a A nunca espera; tudo ou nada fora da transação; alarme no log; 1ª gravação vence |
| **D-IB81** (= Q-IB81 (a)) | calendário de leiaute mínimo (documento × ambiente × `valid_from`, pelo instante da transmissão) |
| **D-IB82** (= Q-IB82 (a)) | a guarda do envio em P é a ORDEM (prova em H pela instância de ensaio antes do deploy; o "liga" em P é a classificação) |
| **D-IB83** (= Q-IB83 (a)) | D-F133 vale para o `src` do núcleo; IB-3 em `D:\Gestao2027\ib3\{nfse-api,fiscal-api}`; checklist de deploy da nfse-api; troca para o `dist` na F3 |
| **D-IB84** (= Q-IB84 (a)) | sem validação local contra XSD agora; testes de ordem/forma contra o XSD do acervo; nota no README |

**Ordem de execução** (guardião §7): (1) worktrees `ib3`; (2) nfse-api: fonte de fatos + cerca D-IB41, montador do grupo + `cNBS`, calendário,
`parseNfseIbscbs` + migration 007 + escritor, "No fisco" com os valores, DANFSe com o bloco; (3) prova em produção restrita pela instância de
ensaio (D-IB82); (4) gates; (5) deploy da nfse-api com "vai"; (6) setes-api (D-IB76) em worktree, merge com "vai"; (7) build web do app (D-IB75,
≤ 30/11); (8) dezembro: envio voluntário em P, um serviço por vez. Estimativa 4–6 sessões.

### 13.4 Execução da IB-3 — nfse-api (2026-10-15, worktrees `D:\Gestao2027\ib3\{nfse-api,fiscal-api}` — D-IB83; NADA na árvore viva)

- **Fonte de fatos**: `readServiceInvoice` lê as 3 colunas CRUAS (`ServiceBranchRow.declaration`); `declarationForDps` confere a FORMA só no
  caminho do DPS (par completo, grupo exige NBS, 6/6/9 dígitos → 422 `FISCAL_DPS_INVALID` com o campo — o cancelamento e as leituras não
  passam por ela); `buildDpsBase` passa `cServ.cNBS` e `ibscbs {cIndOp, cClassTrib}`.
- **Montador**: `DpsIbscbs` só com os dois códigos escolhidos; `ibscbsXml` = último filho de `infDPS` (`finNFSe` 0, `cIndOp`, `indDest` 0,
  `valores/trib/gIBSCBS{CST = prefixo, cClassTrib}`); grupo sem `cNBS` = erro de programação (cinto da E0322).
- **Calendário** `src/authority/layout-calendar.ts` (`layoutAt(documento, ambiente, instante)` — DPS e EVENTO com linha própria; constante
  congelada; piso nomeado "desde o 1º envio"); `LAYOUT_VERSION` aposentada.
- **Valores do fisco**: `parseNfseIbscbs` por CAMINHO (só o `IBSCBS` filho direto de `infNFSe`; texto TSDec15V2); migration **007**
  `tb_invoice_service_transmission_ibscbs` (**DECIMAL(17,2)** — o TSDec15V2 admite 15 inteiros; o rascunho/guardião diziam (15,2), que
  truncaria em silêncio); escritor único `fillAuthorityIbscbs` (INSERT … SELECT … chave presente AND NOT EXISTS; `inserted/same/divergent/
  no-key`); `src/nfse/ibscbs-values.ts` (`readFiscalIbscbs` pura FORA da transação + `recordIbscbsValues` com alarmes de rótulo fixo — E1515
  ausente, ilegível, divergente) ligado nos dois pontos da voz A (transmissão P e consulta Q).
- **"No fisco"**: `ServiceFiscalView.ibscbs {declared (do DPS embutido no XML — D-F76), values (da tabela)}`; OpenAPI atualizado.
- **DANFSe**: bloco "IBS / CBS" (NT 008) — declaração do DPS embutido + valores do grupo do FISCO por caminho; "Valor Líquido + IBS/CBS" com
  fundo cinza; o campo `ibscbs` é AUSENTE quando a nota não declarou o grupo (o oráculo congelado do N17 é por hash — paridade mantida).
- **Testes**: `src/__tests__/ibscbs-ib3.test.ts` (ordem/forma contra o XSD OFICIAL lido do acervo — D-IB84; calendário; forma da declaração;
  dois IBSCBS; escritor; alarmes; cercas D-IB41 e escritor único; "No fisco"; DANFSe). Ajuste da cerca de contexto `adversarial-ne1a-gate`
  (Q-NE68): 4º ponto que lê `access_key IS NOT NULL` = o escritor dos valores (só onde há chave — D-N26). **nfse-api 795/795** (19 pulados) ·
  `tsc` limpo.
- **Conhecimento**: (1) a worktree sai em CRLF (autocrlf) — os arquivos tocados ficam em LF como no `main` (testes que leem fonte por regex
  `[^\n]*` pegavam o `\r`); (2) os testes adversariais da nfse-api precisam de `SETES_API_DIR` apontando para o setes-api real quando rodam
  fora da raiz do workspace; (3) **a bateria AO VIVO (`NFSE_ADV_LIVE=1`) está indisponível no dev pós-janela**: exige 6 notas "frescas" no ERP
  — falha IGUAL no `main` (25/25 no `adversarial-f1.live`) — pré-condição de DADOS, não regressão; refazer a massa é tarefa própria da frente
  fiscal; (4) ~~`FISCAL_COPY_TABLES` do harness ganha a tabela nova só DEPOIS do deploy~~ (SUPERADO pelos gates — §13.6: a tabela já está na
  lista; a cópia tolera a ausência no real só enquanto a migration dela não foi aplicada lá + cerca `copy-tables-fence.test.ts`).
- **Pendente**: gates do delta (lançados); prova em PRODUÇÃO RESTRITA pela instância de ensaio (D-IB82 — exige um serviço de teste
  CLASSIFICADO + NBS no cadastro e uma OS de teste de cliente interno faturada DEPOIS disso; `smoke:adn-h -- --vai` só com o "vai"); setes-api
  D-IB76 e app D-IB75.

### 13.5 Execução da IB-3 — setes-api (D-IB76) e setes-app (D-IB75) (2026-10-15, worktrees `D:\Gestao2027\ib3\{setes-api,setes-app}`, branch `ib3`)

- **setes-api**: `previewServiceIbscbs` (a MESMA composição da IB-2, só-pergunta, sem trava, na data de emissão do estabelecimento) no
  `POST /api/billing/validate` (campo `ibscbs`; antes da obrigação só aviso, depois a recusa também vira issue `scope:'ibscbs'`) e no
  `GET /api/service-orders/:id` (bloco `ibscbs {preview, frozen}` — prevista na OS aberta, CONGELADA lida do ramo na faturada/cancelada,
  `readFrozenIbscbs`); Swagger; testes `ibscbs-ib3-erp.test.ts` + mocks ajustados.
- **setes-app**: peça `app/shared/ibscbs/ibscbs.dart` (formas + `IbscbsCard` que só renderiza) — cartão no detalhe da OS (prevista ×
  congelada + enviada/valores da nfse-api), selo no sucesso do faturamento individual (OS e venda: "saiu SEM o grupo IBS/CBS: motivos"),
  relatório do lote com "Faturadas SEM o grupo IBS/CBS: N" + motivo por linha (contadores RECONTADOS das linhas — D27), prévia no diálogo de
  pendências da venda; i18n pt/en; `test/ibscbs_ib3_test.dart`.

### 13.6 Gates da IB-3 (2026-10-15) — nfse-api 0,70/0,70 · setes-api+app 0,77/0,82 — e a Rodada 2 da IB-3 (D-IB85…D-IB94, "siga as recomendações" — autorização em pé)

**Gates da nfse-api** — socrático **0,70** (3 MEDIUM) · adversarial **0,70** (2 MEDIUM, 2 LOW; testes `adv-ib3-xml|facts|db.test.ts`). Achados e
retrabalho (sem decisão nova):
- **1213 PROVADO entre vozes A de notas DIFERENTES** (adversarial (d9): 10 concorrentes = 17–23 perdidas em 150; linha de base pré-IB-3 = 0): o
  `INSERT … SELECT … NOT EXISTS` do escritor dos valores travava o INTERVALO do índice. **Corrigido**: a trava da NOTA (D-F27) já serializa o
  escritor da mesma nota — leitura de existência SEM trava + `INSERT … VALUES`; corrida sem a trava = 1062 → releitura travante da linha que
  existe. **Re-prova no MariaDB real (banco descartável): (d9) 0 perdida, 0 reexecução com 2/5/10 concorrentes; (d10) realista 75/75.**
- **A gravação dos valores derrubava a voz A** (socrático M1 + adversarial (c)): **COMPARTIMENTO** — SAVEPOINT em volta; deadlock repassa (o
  InnoDB desfez a transação inteira — seguir rodaria a A em AUTOCOMMIT, fora da trava da nota); outro erro = ROLLBACK TO SAVEPOINT + `failed`
  com o código + alarme; a voz A segue (D-IB80). Teste com a 007 renomeada no banco real: a A grava.
- **Amarra XML × tentativa** (socrático L3): os valores só pousam se `infNFSe/@Id` do XML = a chave da voz (`key-mismatch` = alarme) E a
  tentativa detém ESSA chave (`access_key = ?`, nunca "tem alguma chave").
- **E0234/E0903 locais** (adversarial MEDIUM): o grupo abre duas rejeições do Anexo I sabidas na montagem — cIndOp ∈ {030102 … 100301 …
  100601} exige o endereço do tomador (RN 255) e cTribNac 25.05/15.09/17.12/10.05 exige `tpOper` (RN 547, não emitido) → 422 local
  (`assertIbscbsGroupDeliverable`; molde E0322/E0166/E0712). Setes hoje: 0 de 76 tomadores com endereço incompleto; 01.02 não cai na E0903.
- Cinto ESTRITO no montador (`exactDigits` — `digits()` normalizava "000-001"); cerca D-IB41 contra QUALQUER menção solta a `tb_service`;
  cerca do harness (`copy-tables-fence.test.ts` + cópia tolerante à migration ainda não aplicada no real); DANFSe e "No fisco" sem 500 por
  dado de exibição, valor do fisco formatado do TEXTO (BigInt na soma; ausente = "—", nunca "0,00").
- Conhecimento registrado (D-IB83/D-IB84 — socrático M3): PADROES_BANCO §11 regra 17 (v1.7), extensão da D-F133 no prompt das APIs fiscais,
  **checklist de deploy da nfse-api** em `nfse-api/INDEX.md`, nota "sem validação local contra o XSD" no README do acervo.
- **Errata da D-IB80**: a tabela dos valores é **DECIMAL(17,2)** (o TSDec15V2 admite 15 inteiros; "(15,2)" do rascunho truncaria) — assunção
  confirmada pelo socrático.

**Gates do setes-api + app** — socrático **0,77** (3 MEDIUM, 8 LOW) · adversarial **0,82** (3 LOW no app, com testes
`adversarial_ib3x_gate_test.dart`; 7 testes novos da montagem do detalhe da OS em `adv-ib3x-os-detail.test.ts`). Retrabalho sem decisão nova:
parse TOLERANTE no app (tipo trocado = vazio/null — uma linha não derruba o relatório do lote), valor do fisco formatado do TEXTO (ilegível =
"—", exato até 15 inteiros), predicado ÚNICO "saiu sem o grupo" (`IbscbsOutcome.leftWithoutGroup`), data da prévia no cartão, texto do
`nbs-not-accepted` sem "na data" (D-IB69), terminal do ramo em `readFrozenIbscbs` (nunca `terminal = 0`).

**Rodada 2 da IB-3** (questões dos gates; Valdo em pé: "siga as recomendações" — nenhuma irreversível, nenhuma HIGH; as do adversarial do app
vieram numeradas Q-IB90…Q-IB92 e foram RENUMERADAS para Q-IB92…Q-IB94 por colidirem com as do socrático):

| Decisão | O que fixa |
|---|---|
| **D-IB85** (= Q-IB85 (a)) | a NBS SOZINHA (cNBS sem o grupo) também muda o que vai ao fisco em P: entra na MESMA ordem da D-IB82 (prova em H do caso só-NBS antes do deploy; em P um serviço e uma nota primeiro; recuo = tirar a NBS do cadastro) |
| **D-IB86** (= Q-IB86 (a)) | o bloco IBS/CBS do DANFSe aparece com a declaração OU com o grupo do fisco — o que faltar sai "não informado" (paridade do N17 mantida) |
| **D-IB87** (= Q-IB87 (a)) | a prévia/congelada que falha no detalhe da OS DEGRADA TIPADA (`ibscbs {preview:null, frozen:null, unavailable:true}` + alarme de rótulo fixo); o app diz "indisponível"; o validate da venda segue falhando alto |
| **D-IB88** (= Q-IB88 (a)) | DONO ÚNICO da data de emissão/competência fiscal: `invoiceEmissionDateFor` (`@shared/invoice/emission-date`) — billing, OS e prévia; cerca `emission-date-fence.test.ts` |
| **D-IB89** (= Q-IB89 (a)) | antes da obrigação a prévia traz o veredito NA DATA DA OBRIGAÇÃO (`atObligation` — "a partir de 01/01/2027 seria RECUSADA: …") |
| **D-IB90** (= Q-IB90 (a)) | "congelada × enviada": a visão fiscal da nfse-api diz se o DPS autorizado levou o grupo (`groupInDps` true/false/null); o app mostra o alerta quando o ERP congelou e a NFS-e não leva; **ordem de deploy**: nenhum serviço classificado em P antes do deploy da nfse-api IB-3 (checklist) |
| **D-IB91** (= Q-IB91 (a)) | motivos de omissão = CONTRATO publicado: `IBSCBS_OMISSIONS` (o tipo sai dela), Swagger enumera, o app guarda o espelho `kIbscbsOmissions` conferido contra a constante da API por teste |
| **D-IB92** (= Q-IB92 (b), adversarial) | na venda, o aviso de antes da obrigação no caminho SEM pendências fica no selo pós-faturamento (a Setes fatura pela OS, onde o cartão mostra a prévia) — limite conhecido |
| **D-IB93** (= Q-IB93 (a), adversarial) | a prévia responde só o IBS/CBS — não repete as conferências anteriores do faturamento (item inativo/excluído/sem regra de ISS); limite conhecido |
| **D-IB94** (= Q-IB94 (a), adversarial) | a issue `scope:'ibscbs'` do validate não leva `code` — o código está em `ibscbs.refusal.code` |

**Contagens**: nfse-api **863** unit (179 pulados — ao vivo/banco) + `adv-ib3-db` 10/10 no MariaDB real (banco descartável apagado; `fiscal_api`
real intocado, na 006) · setes-api e app: §13.7.

### 13.7 Gates do DELTA do retrabalho da IB-3 (2026-10-15) — socrático **0,78 ✅** · adversarial **0,84 ✅** (nenhum HIGH) — e D-IB95…D-IB97

Valdo (2026-10-15): "vamos finalizar ib-3" — autorização em pé ("siga as recomendações") mantida para as questões dos gates.

**Retrabalho sem decisão (na sessão)**:
- **ADV-IB3Y-01** (LOW): `fillAuthorityIbscbs` confere o `InvoiceTx` de NOVO logo antes do INSERT (chamada sem await que sobrevivesse ao
  COMMIT gravaria em AUTOCOMMIT — regra NE1A2-02); provado no banco descartável (y4) e corrigido.
- **Cabeçalho da 007** reescrito ANTES de ela ser aplicada (ensinava o `INSERT … SELECT … NOT EXISTS` que o d9 provou causar 1213);
  promessa do `recordIbscbsValues` alinhada (a única exceção que sai é o deadlock — de propósito).
- **D-IB88 completa**: a grade prévia da negociação (`orders.repository.ts`) usa o dono único; a cerca `emission-date-fence.test.ts` varre o
  `src` INTEIRO e pega atribuição E propriedade (`x: await todayFor(`); Swagger × `IBSCBS_OMISSIONS` cercado no mesmo teste.
- Alarme da D-IB87 com `kind` (nome do erro) — TypeError de programação × banco fora do ar.
- **Checklist de deploy da nfse-api, item 6** (socrático M1): confere o CADASTRO **e os RAMOS já congelados** sem NFS-e (o que vai ao fisco é o
  ramo). Conferência na produção (2026-10-15, só leitura): 0 serviço classificado · 0 ramo congelado · **2 serviços com NBS — resíduo de teste
  da IB-1 (61 "ADV-IB1 smoke retrabalho", 62 "PASSEIO IB-1 aba IBS/CBS"), sem OS aberta; desativar = ação na produção, aguarda o Valdo.**

**Provas**: os ataques do delta resistiram no banco real descartável (y1/y1b duas vozes A da MESMA nota com a trava; y2 sem a trava; y3 1205
fabricado → `failed` e a voz A segue; y5 deadlock real dentro do escritor → reexecução e tudo gravado uma vez) + re-prova do d9 (0 perdas).

| Decisão | O que fixa |
|---|---|
| **D-IB95** (= Q-IB95 (a) do socrático = Q-IB100 (b) do adversarial) | E0903 (subitens 25.05/15.09/17.12/10.05 exigem `tpOper`) = LIMITE CONHECIDO com GATILHO: na implantação de cliente desses subitens o `tpOper` (fato novo — passa pelo guardião) entra ANTES da data da obrigação dele; linha no roteiro de implantação por cliente. A Setes (01.02) não é atingida |
| **D-IB96** (= Q-IB96 (a)) | ramos JÁ congelados com o grupo/NBS no momento do deploy seguem a D-IB82: depois do deploy, UMA nota primeiro, conferida em "No fisco", e só então o resto; recuo do que congelou = cancelar e refaturar (tirar a NBS do cadastro não desfaz o ramo) |
| **D-IB97** (= Q-IB101 (b)) | o alarme dos valores (divergente/key-mismatch/E1515) segue a cada passada do rodízio até a prova da IB-4 mostrar se o fisco devolve o grupo; se o E1515 aparecer de verdade, decide-se "alarmar só na 1ª vez" |

**Contagens** (2026-10-15): nfse-api **869** unit (185 pulados — ao vivo/banco) + banco descartável `adv-ib3-db` + `adv-ib3y-db` **16/16** ·
setes-api **1923/1923** (31 pulados, com o delta) · app **615/615** (28 pulados) + `flutter analyze` limpo + 46/46 nos
testes IBS/CBS (inclusive os adversariais ib3x/ib3y).

**Prova em PRODUÇÃO RESTRITA (D-IB82) — preparada na INSTÂNCIA DE ENSAIO** (kit `fiscal-api/scripts/ensaio-janela/`: 2ª MariaDB :3307 de dump
só-leitura da produção, usuários com senhas novas, fisco/Inter de PRODUÇÃO bloqueados no processo): serviço 1 classificado (000001/100301/NBS
115021000) pelo código da `ib3`; OS **8014** (cliente da D-F54) com prévia "COM o grupo" hoje e na obrigação; faturada → nota **6794**,
`ibscbs.declared: true`, congelada no ramo; smoke SEM `--vai` = pré-condições OK; DPS montado localmente com `cNBS` e `<IBSCBS>` como último
filho do `infDPS`. **Falta o "vai" do Valdo** para `smoke:adn-h -- --nota 8014 --vai` (transmitir em H → consultar → XML/DANFSe → bloco
IBS/CBS → cancelar no fisco de H).

**"vai" do Valdo (2026-10-15) — resultado**: 3 transmissões em H (16:33–16:36 UTC, DPS novos) → **R E1000** "A calculadora integrada ao sistema
NFS-e retornou o seguinte erro: The operation has timed out". Leitura: o DPS com o grupo PASSOU a validação de forma (o fisco chegou a acionar a
Calculadora com a nossa classificação); quem caiu foi a integração da Sefin de H com a Calculadora — a Calculadora pública (piloto-cbs) responde
em < 1 s, e o fórum do ACBr registra o mesmo E1000/timeout para todos desde **14/10/2026 08h16** no ambiente de homologação. Conhecimento: E1000
= erro da Calculadora integrada (pode ser TRANSITÓRIO — a voz é R e a nota segue retransmissível, cada tentativa com DPS novo). A prova dos VALORES
devolvidos fica pendente da normalização do fisco de H. Junto do "vai": serviços 61/62 (resíduo da IB-1) DESATIVADOS na produção (`active='N'`;
já estavam excluídos no `tb_product` — achado: a exclusão do serviço não alcança o ramo `tb_service`, que fica vivo com a NBS).

### 13.8 IB-3 PUBLICADA (2026-10-15) — D-IB98

| Decisão | O que fixa |
|---|---|
| **D-IB98** (Valdo 2026-10-15: "(b), pode publicar") | com o fisco de H fora (E1000 — Calculadora integrada em timeout desde 14/10), a IB-3 é PUBLICADA ANTES da prova completa em H — inverte a ordem literal da D-IB82, mantendo o que ela protege: **NENHUM serviço classificado (nem com NBS) em PRODUÇÃO até a prova em H passar** (autorização + valores do fisco lidos + cancelamento em H). Com 0 classificado e 0 ramo congelado, o deploy é INERTE em P: o "liga" segue sendo a classificação |

**Publicação** (checklist de deploy da nfse-api conferido — núcleo vivo limpo em 945ad2d; item 6: 0 classificado · 0 ramo congelado · os 2
serviços com NBS (61/62, resíduo da IB-1) DESATIVADOS a pedido do Valdo):
- **setes-api** `e4af7aa` (merge ff da `ib3` na árvore viva — `tsx watch` reiniciou; health 200);
- **nfse-api** `ba78074` (merge ff; processo REINICIADO na aba do Terminal "nfse-api producao" — **migration 007 aplicada no boot no `fiscal_api`
  de produção**; `/v1/health` ok; leitura da visão "No fisco" de 3 notas reais pelo código publicado: `groupInDps: false` (saíram antes da IB-3),
  tabela nova vazia);
- **setes-app** `fbc2fac` (merge ff; `flutter run -d web-server --web-port 5051` reiniciado na aba "setes-app web 5051");
- GitHub: os três `main` empurrados.

**Pendente (fecha a IB-4)**: refazer a prova em H quando o fisco normalizar — instância de ensaio 3307 (scratchpad desta sessão) ou nova
(kit `fiscal-api/scripts/ensaio-janela/`): classificar o serviço de teste na CÓPIA, faturar, `smoke:adn-h -- --nota <id> --vai` (o roteiro já
imprime o bloco IBS/CBS no passo 3b); só DEPOIS dela classificar em produção (um serviço e uma nota primeiro — D-IB82/D-IB96). Q-IB1 (opção de
regime até 30/10) segue com o Valdo + contador.

**Prova em H — nova tentativa (2026-10-31 → 2026-11-01, sessão filha; "vai" do Valdo em 2026-11-01) — BLOQUEADA, agora pelo LEIAUTE de H (não
mais pelo E1000)**:
- **Sonda leve (31/10 ~23h BRT, só GET, produção bloqueada no processo)**: fisco de H NO AR — `GET /dps/{Id inexistente}` → E2404 em 2,6 s;
  fórum do ACBr relata o E1000 "corrigido" (sem data).
- **Instância descartável** (kit `fiscal-api/scripts/ensaio-janela/`: MariaDB :3307 de dump só-leitura de 31/10, senhas novas, setes-api da
  árvore viva `e61f9fe` SEM watch em :3010 com JWT de kid próprio, fisco/Inter de PRODUÇÃO bloqueados): serviço 1 classificado
  000001/100301 + NBS 115021000 e serviço 5 só com NBS, ambos na CÓPIA; OS 8014 → nota 6794 congelada {000001,100301,115021000}
  (`declared: true`); OS 8015 → nota 6795 congelada só com a NBS (`omitted: ['not-classified']` — caso D-IB85). Smoke sem `--vai` = pré-condições
  OK nas duas; DPS local da 8014 com `<cNBS>` + `<IBSCBS>` último filho do `infDPS`; da 8015, só `<cNBS>`.
- **`smoke:adn-h -- --nota 8014 --vai` (2026-11-01 10:50:50 UTC, série 900, DPS novo)** → **R E1235** "Falha no esquema XML do DF-e. (The element
  'infDPS' … has invalid child element 'cLocEmi' … List of possible elements expected: 'cMotivoEmisTI, finNF[Se]'…)". Consulta = R; sem NFS-e,
  sem cancelamento; banco do smoke apagado. **A 8015 NÃO foi transmitida**: a recusa é de esquema no `cLocEmi`, ANTES de qualquer grupo; daria a
  mesma voz (o caso só-NBS fica para a mesma retomada).
- **Causa (fatos levantados)**: a página oficial "Documentação Técnica (Homologação/testes)" do portal da NFS-e (atualizada 20/10/2026 18h10) publica
  o pacote **`NFSe-ESQUEMAS_XSD-PRODREST-v1.01` de 20/10/2026** (`…/documentacao-tecnica/producao-restrita/esquemas_prod_restrita_20261020.zip`) +
  Anexos I/II PRODREST de 20/10/2026 — leiaute da **NT 009** na produção restrita. A página de PRODUÇÃO segue com o pacote de **09/02/2026**
  (o que o nosso montador segue — `Infra-IA/setes-api/integracoes/nfse-adn/xsd/`, conferido: `tpEmit → cMotivoEmisTI? → chNFSeRej? → cLocEmi`).
  Relatos de integradores (OpenAC.Net.NFSe.Nacional #69, nfse-php #61/#68), NÃO conferidos no XSD: `finNFSe` OBRIGATÓRIO direto no `infDPS`
  (`tpEmit → cMotivoEmisTI? → finNFSe → chNFSeRej? → cLocEmi`, valor único 0) e `xDescServ` do `cServ` DEPOIS de `cNBS`/`cIntContrib`; com isso
  o DPS passou o esquema e parou em regra de negócio (E0312). Em P o leiaute antigo segue aceito — **sem data publicada para P migrar**.
- **Leitura**: o E1000 deixou de ser o bloqueio conhecido (não provado — a recusa de esquema vem antes da Calculadora). A prova em H agora exige
  o montador do DPS no leiaute da NT 009 PARA H (código da nfse-api — fora desta tarefa: árvore viva = deploy; decisão do Valdo sobre leiaute por
  ambiente). ⚠️ **Risco para P**: quando a produção adotar o pacote da NT 009, TODA emissão de NFS-e recusa com E1235 até o montador mudar.
- **Desmontagem**: setes-api :3010 e MariaDB :3307 parados (pela porta + caminho), pasta da instância apagada. Produção conferida só-leitura
  depois: 0 serviço classificado vivo (as 22 linhas de `tb_service_ibscbs` são da IB-1, todas `deleted='S'`, iguais no dump de 31/10), 0 serviço
  ativo com NBS, 0 ramo congelado, notas 8014/8015 inexistentes. **D-IB98 segue valendo** (nada classificado em produção).
- **Próximo**: baixar e conferir o pacote PRODREST de 20/10/2026 (arquivar no acervo `nfse-adn` com SHA-256), decidir o leiaute por ambiente na
  nfse-api (worktree + gates), refazer esta prova (8014 + 8015) com o kit.

**Leiaute da NT 009 na nfse-api — Rodada 0 (2026-11-01, sessão filha; numeração em BLOCO Q-IB110…/D-IB110… — a sessão da D-IB99 usa Q-IB103/Q-IB104
e D-IB100+)**:
- **Pacote BAIXADO** (autorização do Valdo) e arquivado em `Infra-IA/setes-api/integracoes/nfse-adn/producao-restrita-20261020/` (XSD + Anexos I/II
  PRODREST de 20/10/2026, SHA-256 no README do acervo); **diferença completa em `…/producao-restrita-20261020/DIFERENCA.md`**. Fatos que decidem:
  (1) **mesma `versao="1.01"` com leiaute DIFERENTE** — o calendário não distingue pela versão; (2) o DPS muda em 4 pontos: `finNFSe` OBRIGATÓRIO no
  `infDPS` (entre `cMotivoEmisTI` e `chNFSeRej`), `xDescServ` depois de `cNBS`/`cIntContrib`, o grupo `IBSCBS` perde o `finNFSe` e `cIndOp` vira
  opcional, `CST`/`cClassTrib` sobem para `IBSCBS/valores/trib` (o `gIBSCBS` fica só com opcionais); (3) eventos IDÊNTICOS (o cancelamento não muda);
  (4) regras novas: **E0855** (grupo obrigatório com competência ≥ 01/10/2026 — sem exceção do Simples no TEXTO da regra; a nota do leiaute diz "SN
  só em 2027"), E0859/E0860 e E0960/E0961 (`cIndOp`/`gIBSCBS` pelo `ind_gIBSCBS` do CST — 000 = 1), E0234 sai (E0239/E0241/E0243); (5) na NFS-e
  devolvida, `gIBS`/`gCBS` passam a opcionais (só com indicador 1); (6) conhecimento negativo: o Anexo I PRODREST imprime o caminho do `finNFSe`
  errado (vale o XSD) e a NT 009 entrou PARCIAL em H (sem `regApIBSCBSSN`).
- **Guardião** (setes-conceito, 2026-11-01 — parecer conferido no disco): nenhuma peça nova; o calendário nomeia o LEIAUTE pelo pacote oficial
  (`'xsd-20260209' | 'xsd-20261020'` — nunca "NT 009" nem "H") separado da versão; UM montador com três costuras por `switch` exaustivo no leiaute;
  leitura da declaração pela FORMA do documento (nunca pelo calendário); maquetes: escolher por `environment === 'H'`, flag/variável de leiaute,
  reenviar com o outro leiaute no E1235, coluna "leiaute" na tentativa, constante CST→indicador na nfse-api, apagar o `cIndOp` congelado.

| Decisão | O que fixa |
|---|---|
| **D-IB110** (= Q-IB110 (a), Valdo 2026-11-01) | Leiaute POR AMBIENTE pelo calendário (`layout-calendar.ts`): `DPS · H · desde 20/10/2026 18h10 BRT → xsd-20261020` (versão 1.01); P segue no `xsd-20260209` até o fisco anunciar; o EVENTO segue igual nos dois. **Evolui a D-IB81**: `layoutAt` devolve `{layout, version}` — o leiaute é o pacote, a versão é o atributo; continua sem decidir o grupo |
| **D-IB111** (= Q-IB111 (a)) | Virada de P = linha nova no calendário por DEPLOY antes da data anunciada (com teste); fisco adia/antecipa = novo deploy movendo a data; E1235 em P = alarme no log; nunca trocar sozinho nem por flag/variável; o checklist de deploy da nfse-api ganha "conferir a página oficial de produção" |
| **D-IB112** (= Q-IB112 (a)) | No leiaute `xsd-20261020` o grupo declarado leva `<gIBSCBS/>` VAZIO depois de `CST`/`cClassTrib` (letra da E0960 com `ind_gIBSCBS = 1`); a prova da 8014 confirma — se o fisco recusar o vazio, omitir no mesmo leiaute (conformidade) |
| **D-IB113** (= Q-IB113 (a)) | CST com `ind_gIBSCBS = 0` é RECUSADO no ERP por ora ("ainda não suportado na NFS-e"): o catálogo grava o indicador do CST (coluna em `tb_tax_ibscbs`; o `parse.ts` hoje lê e descarta) e o cadastro e o faturamento recusam pelo MESMO predicado; suporte completo com o 1º cliente que precisar. A nfse-api nunca consulta o indicador (grupo declarado ⇒ `cIndOp` + `gIBSCBS`, por construção). Execução: sessão própria do setes-api com `revisar-ddl` |
| **D-IB114** (= Q-IB114 (a)) | E0855 sem espelho local na nfse-api (a obrigação é do ERP — D-IB13); a prova em H transmite a 8015 (só NBS) para ver se a regra atinge o Simples; se atingir e P adotar a regra, a data da obrigação reabre no ERP e classificar a Setes em P (D-IB98) vira tarefa ANTES da virada de P |

**Conformidade sem decisão** (o XSD manda): `finNFSe`=0 no `infDPS`, ordem do `cServ` e forma do grupo no leiaute novo; leitura da declaração nas duas
formas (excludentes pelo XSD; forma mista = ilegível); testes de ordem/forma POR PACOTE contra o acervo; `parseNfseIbscbs` e a tabela da D-IB77 NÃO
mudam (indicador 0 fica fora pela D-IB113 — com indicador 1, `gIBS`/`gCBS` ausentes seguem anomalia com alarme).

**Execução (2026-11-01, WORKTREE `D:\Gestao2027\nt009\{nfse-api,fiscal-api}`, branch `nt009-leiaute` sobre os `main` vivos 62c5fcf/abce0b8 —
núcleo INTOCADO, só para o `tsconfig` resolver; NADA na árvore viva, NADA commitado)**:
- `src/authority/layout-calendar.ts`: `NfseLayout = 'xsd-20260209' | 'xsd-20261020'`, `layoutAt` → `{layout, version}`, linha `DPS · H ·
  2026-10-20T21:10:00Z → xsd-20261020`; linhas tipadas sem `as` + `assertLayoutCalendar` no CARREGAMENTO (validFrom fora da forma UTC/
  inexistente, linha repetida ou par sem piso = o boot não sobe — a linha de P chega por deploy sob pressão).
- `src/authority/dps-builder.ts`: UM montador, três costuras por `switch` exaustivo com o cinto `unknownLayout` (`finNFSe` no `infDPS`, ordem do
  `cServ`, grupo com `<gIBSCBS></gIBSCBS>` vazio); evento igual (`assertCancelEventForm`); `parseNfseDeclaration` pelas DUAS formas (mista =
  null); `requiredText` (obrigatório esvaziado pelo saneamento = erro de programação) + `dpsText` exportado.
- `src/facts/service-facts.ts`: nome do tomador que o saneamento esvazia = 422 `FISCAL_RECIPIENT_INCOMPLETE` (`recipient.name`); descrição
  esvaziada cai em "Serviços" — decide pelo MESMO saneamento do montador (ADV-NT009-01, abaixo).
- `src/nfse/transmission.ts`: alarme `[D-IB111] E1235 em PRODUÇÃO` no DPS e no pedido de EVENTO, antes da gravação da voz/liberação do K,
  com rótulo que manda CONFERIR (o E1235 não prova troca de pacote).
- Testes: `leiaute-nt009.test.ts` (ordem + obrigatórios contra o XSD OFICIAL de cada pacote, ida e volta da declaração, alarme, cercas da
  forma por leiaute e do calendário) + do gate adversarial `adv-nt009-xsd.test.ts` (**validação REAL por `xmllint`/libxml2 do Git for
  Windows, `--nonet`**: 7 casos × 2 pacotes, assinados sha1/sha256 e não assinados, todos válidos no seu pacote e inválidos no outro — sempre
  pelo `finNFSe`, o mesmo E1235 da 8014; assinatura sobre o grupo vazio verifica), `adv-nt009-borda.test.ts`, `adv-nt009-achados.test.ts`;
  `ibscbs-ib3`/`adv-ib3-xml` passam a fixar o pacote de 09/02 em P. Docs: checklist de deploy da nfse-api itens 7 (leiaute) e 8 (D-IB115).
- **Contagem final** (worktree, depois do retrabalho): nfse-api **1082 verdes / 0 falha** (185 pulados — banco/ao vivo) · `tsc` limpo; árvores
  vivas `nfse-api`/`fiscal-api` com `git status` vazio.
- **Gates**: socrático **0,80 ✅** · adversarial **0,86 ✅** (nenhum HIGH). Retrabalho na sessão (sem decisão nova): ADV-NT009-01 (LOW,
  anterior ao delta — texto obrigatório só com caracteres fora do Latin-1 saía do DPS em silêncio, fora do esquema → E1235 e alarme falso em
  P); runbook e alarme não afirmam mais troca de pacote (MEDIUM — há E1235 por dado); alarme também no evento (Q-c) e antes da transação (L6);
  cerca do calendário (L4); mensagem do cinto E0234 cita E0243 (L7).
- **Conhecimento negativo (gate adversarial)**: no pacote de 09/02 o `TSSerieDPS` é `^0{0,4}\d{1,5}$` — no XSD `^`/`$` são LITERAIS e o
  libxml2 recusa TODA série; o validador do fisco (.NET) aceita (a 704 autorizou) e o pacote de 20/10 corrigiu o padrão. O teste valida numa
  cópia sem as âncoras.

| Decisão | O que fixa |
|---|---|
| **D-IB115** (= Q-IB115 (a), Valdo 2026-11-01 — do gate socrático) | A D-IB98 (nenhum serviço classificado em P) só cai depois da prova em H passar **E** da D-IB113 no ar no setes-api; pré-condição escrita no item 8 do checklist de deploy da nfse-api |

**Limites conhecidos registrados (sem decisão)**: o `dhEmi` nasce antes do envio — na fronteira da virada uma tentativa pode sair no pacote
antigo e levar R (a seguinte corrige; recomendação no runbook: não rodar o lote mensal na janela da virada de P); campos do tomador sem corte
pelo XSD (IM > 15, `nro`/`xBairro` > 60, `xCpl` > 156 — anterior ao delta) geram E1235 por DADO em qualquer leiaute; o lote do app não para
no E1235 em massa (`FISCAL_DPS_REJECTED` não é falha do emitente).

**PUBLICADA 2026-11-01 ("Vai, publicar" do Valdo)** — checklist de deploy da nfse-api conferido: (1) núcleo vivo limpo em abce0b8 (= o da
worktree); (2) merge ff `nt009-leiaute` → `main` **b6600c1** na árvore viva, suíte NA árvore viva 1082 verdes / 0 falha (checkout CRLF);
(3) sem migration nova (última aplicada 007); (6/8) produção só-leitura: 0 serviço classificado vivo, 0 com NBS, 0 ramo congelado sem NFS-e
(D-IB98 segue de pé); (7) página oficial de PRODUÇÃO ainda com `nfse-esquemas_xsd-v1-01-20260209.zip` + Anexo I de 09/02 = a linha de P do
calendário; leitura das NFS-e REAIS 704–707 pelo código publicado idêntica (sem grupo, declaração nula, DANFSe gerado); processo antigo
(`npx tsx --require tsconfig-paths/register src/server.ts`, de 31/10 20:26) parado e o MESMO comando subido numa aba nova "nfse-api producao"
(PID 30124, 14:28 UTC) — `/v1/health` 200 (`db`/`masterKey`/`storage`), rota protegida 401 sem token; GitHub `main` 62c5fcf..b6600c1. INERTE em
P (P segue no pacote de 09/02 até a linha nova); em H o DPS já sai no pacote de 20/10. Infra-IA NÃO commitada (arquivos compartilhados com
outras sessões — commit só pelos trechos, com pedido).
**Próximo**: (1) ~~"vai" do Valdo para publicar a nfse-api~~ FEITO (acima); (2) a prova em H (8014 com o grupo + 8015 só NBS) pelo kit `fiscal-api/scripts/ensaio-janela/`, com novo "vai"
(o smoke precisa do código desta branch — rodar da worktree, com o `.env` da instância descartável, ou depois da publicação: a sessão da
prova decide); (3) D-IB113 no setes-api (sessão própria, `revisar-ddl`).

**🎉 PROVA EM H (IB-4) PASSOU — 2026-11-01 14:53 UTC ("Vai, prova em H" do Valdo), código PUBLICADO da nfse-api (`main` b6600c1)**:
- **Instância descartável** (kit `fiscal-api/scripts/ensaio-janela/`): MariaDB :3307 (só 127.0.0.1) de dump SÓ-LEITURA da produção do mesmo dia,
  usuários `setes`/`fiscal_api` com senhas NOVAS; setes-api da árvore viva SEM watch na :3010 com JWT de kid próprio (`passeio`), SMTP para
  127.0.0.1:1, storage/segredos isolados; `block-hosts.js` recusando `sefin.nfse.gov.br`, `adn.nfse.gov.br` e o Inter de produção. ⚠️ Conhecimento:
  o gatilho da F2a na cópia RECUSA mexer na habilitação SE do ERP (aposentada e congelada) — o "UPDATE … environment='H'" do kit vale só para o
  `fiscal_api` (o ERP não emite). Na cópia, pela API: serviço 1 classificado 000001/100301 + NBS 115021000; serviço 5 só NBS; OS **8014** (cliente
  209 da D-F54, prévia "COM o grupo" hoje e na obrigação) → nota 6794 congelada {000001, 100301, 115021000}; OS **8015** → nota 6795 só com a NBS
  (`omitted: ['not-classified']`). DPS local das duas no pacote `xsd-20261020` (o calendário publicado deu H = 20/10).
- **8014 (com o grupo) — AUTORIZADA em H** (NFS-e de H nº 4, chave `41069022207742094000113000000000000426117167090320`, série 900): passou o ESQUEMA da NT 009 e as
  regras; **o `<gIBSCBS></gIBSCBS>` VAZIO foi aceito (D-IB112 CONFIRMADA — E0960 não disparou)**; a Calculadora integrada respondeu (o E1000 de
  14/10 sumiu); o fisco devolveu o grupo dele: **vTotNF 10,00 · vIBSTot 0,01 · vCBS 0,09** (alíquotas de teste de 2026 sobre R$ 10; vTotNF =
  vLiq em 2026 — fato T3), gravados pelo escritor da IB-3 e lidos em "No fisco" (`groupInDps: true`) — **a dúvida da D-IB97 (E1515) se fechou:
  o fisco devolve o grupo**; DANFSe gerado; cancelamento e101101 aceito em H (voz C 101101).
- **8015 (só NBS, sem o grupo) — AUTORIZADA em H** (NFS-e de H nº 5): **a E0855 NÃO recusou a nota do Simples com competência 11/2026** — vale a
  nota do leiaute ("SN só a partir de 2027"); a data da obrigação do ERP (01/01/2027 para o Simples) NÃO reabre (D-IB114). Conhecimento para o
  regime REGULAR: a E0855 diz 01/10/2026 — cliente fora do Simples precisará do grupo desde essa competência quando P adotar o pacote.
  Cancelada em H (voz C 101101).
- **Desmontagem**: setes-api :3010 e MariaDB :3307 parados (shutdown normal), pasta da instância (datadir + dump) APAGADA; logs do smoke na pasta
  de notas da sessão. **Produção conferida só-leitura depois**: nenhuma ordem/nota/tentativa 8014/8015, serviços 1 e 5 sem NBS, 0 classificado/0
  congelado, habilitação real SE em P com a virada, nenhum banco de smoke.
- **Consequência (D-IB98 × D-IB115)**: a condição "prova em H" da D-IB98 está CUMPRIDA (autorização + valores do fisco lidos + cancelamento em H).
  Pela D-IB115, classificar serviço em P ainda espera a **D-IB113 no ar** (sessão própria do setes-api, em curso). Depois dela: em P, UM serviço e
  UMA nota primeiro, conferidos em "No fisco" (D-IB82/D-IB96).

**D-IB113 no setes-api + sql — EXECUTADA em WORKTREE (2026-11-01, sessão filha; `D:\Gestao2027\ib113\{setes-api,sql,setes-app}`, branch `ib113` a
partir dos `main` api e61f9fe · sql 66fc17c · app a450909 — NADA commitado, aplicado em banco vivo ou com push; numeração em BLOCO 120+ — 100+ é
da D-IB99, 110+ do leiaute)**:
- **sql/73** `73_ibscbs_cst_requires_group.sql`: `setes_central.tb_tax_ibscbs.requires_ibscbs_group CHAR(1) NULL` (o `ind_gIBSCBS` do CST; NULL =
  CST gravado por carga anterior ao 73 — nenhum DEFAULT inventa) + CHECK binário `ck_tax_ibscbs_requires_group` (`IS NULL OR … COLLATE
  utf8mb4_bin IN ('S','N')`), re-executável (`ADD COLUMN IF NOT EXISTS`, `DROP CONSTRAINT IF EXISTS` + `ADD` no mesmo ALTER); espelho no 61 e
  no canônico 01. Guardião: atributo da peça do CST (molde `requires_regular_taxation`), sem peça nova (`revisar-ddl` sem achado). **Provado
  em schema descartável** (`setes-api/scripts/prove-ibscbs-cst-group.ts`, 26/26: cópia do `tb_tax_ibscbs` vivo, 73 duas vezes, 18/18 NULL, CHECK
  recusa `s`/`n`/`X`/`''` e vem ANTES da PK, boot antes/depois do 73, script interrompido entre os comandos, ambiente novo 61 + 73, bloco do 01 =
  do 61). **NÃO aplicado** no `setes_central`.
- **Carga do catálogo** (`@shared/ibscbs-catalog`): `parse.ts` confere o `ind_gIBSCBS` 0/1 da aba CST (vazio, `2`, `S`, `1.0` = fonte
  recusada; a LEGENDA no fim da aba — linhas sem CST — é ignorada); `apply.ts` grava/atualiza o indicador e devolve `relatorio.cstGroupOff`
  (CSTs que passam a não levar o grupo); o impacto lista os serviços deles com o motivo novo; `reconcile.ts` — a conferência D-IB28 (a)
  compara também `exigeGrupoIbsCbs` do PAR da Calculadora (campo que existe — visto ao vivo) com o indicador do CST no IT.
- **Peça** `@shared/ibscbs-classification` (a regra ÚNICA — D-IB47): `ClassificationAt.cstRequiresGroup` (JOIN com `tb_tax_ibscbs`); `verdictOf`
  ganha o motivo **`cst-without-group`** por ÚLTIMO (todo veredito anterior fica idêntico; só o aceito pode virar recusa); indicador NULL também
  recusa (falha fechada); frase única `groupRefusalText` (o 422 do cadastro e o do faturamento dizem o mesmo; o NULL diz "ainda não foi
  carregado"). Cadastro: 422 **`IBSCBS_CLASSIFICATION_GROUP_UNSUPPORTED`** em `ibscbs.classificationCode`; lista de apoio e selo do GET pelo
  mesmo veredito. Faturamento/prévia (validate, OS aberta, lote): omissão nova `cst-without-group` na lista FECHADA (D-IB91 — Swagger de billing
  e OS, espelho + i18n do app); antes da obrigação a nota sai SEM o grupo (nunca congela `cIndOp` com CST sem o grupo), depois 422
  `INVOICE_SERVICE_IBSCBS_REQUIRED` nomeando o motivo. Boot (`assertIbscbsCatalogSchema`, molde D-IB26/D-IB36): sem a coluna do 73 não sobe e
  diz o script; o CHECK é PROVADO pelo NOME (duas sondas — fora do domínio e a minúscula —, PK própria, transação desfeita; PK ocupada 1062 ou
  espera de trava 1205 = sem o CHECK, dito como tal); CST com indicador NULL = ALERTA `[D-IB113]` — revisto pela D-IB120 (abaixo): com
  cClassTrib vivo o boot RECUSA.
- **App** (`ib113/setes-app`): `kIbscbsOmissions` + `ibscbs.omitted.cst-without-group` pt/en; `ibscbs_ib3_test.dart` (contagem 9) 18/18; analyze
  limpo. Publicar JUNTO com a API (o app antigo mostra o motivo cru — parse tolerante).
- **Prova ao vivo** (`setes-api/scripts/prove-ibscbs-cst-group-live.ts --calculadora`: cópia das 7 tabelas do catálogo vivo num schema
  descartável + 73 + carga REAL do IT v1.70 + a peça apontada para a cópia): indicador gravado = aba CST; 1ª carga `cstGroupOff` = 400, 410,
  620, 800, 810, 811, 820; dos 71 cClassTrib aceitos HOJE na NFS-e, **41 seguem (000001 da Setes incluso) e 30 passam a recusados — exatamente
  os desses CSTs**; lista, 422 do cadastro e faturamento antes × depois da obrigação coerentes; 2ª carga inalterada; **Calculadora × IT: 71
  pares, 0 divergência** (o gate adversarial: 173 pares nas datas de conferência e 9 códigos em 6 datas até 2033 — 0). Censo só-leitura do
  vivo: 0 serviço classificado, 0 ramo congelado.
- **Testes**: `ibscbs-cst-group.test.ts` (novo); blocos D-IB113 e A-IB120 em `ibscbs-catalog-apply.test.ts`; boot em `ibscbs-classification.test.ts`;
  motivo novo em `ibscbs-declaration.test.ts`; do gate `adv-ib113-gate.test.ts` (puros + 3 ao vivo opt-in `IB113_ADV_LIVE=1`, schemas
  `setes_ib113_adv_*`; o ADV-IB113-01 segue `it.failing`) + scripts `adv-ib113-{matrix,calculadora,calc-dates,boot-lock,nonstrict}.ts`. Suíte da
  worktree: **136 suítes, 2202 verdes, 34 ao vivo pulados** (com a D-IB120; dois testes de TEMPO — F2a r4 e D-RS4 — estouraram uma vez sob carga e passam sozinhos) (`tsc` limpo; o gate ao vivo 26/26 com `IB113_ADV_LIVE=1`; nenhum schema
  `setes_ib113_*` ficou; o `setes_central` segue sem a coluna). Ambiente: junções `ib113/fiscal-api` e `ib113/nfse-api` → árvores vivas, só leitura (as cercas da F2a leem `../nfse-api`).
- **Gates**: socrático **0,76 ✅** · adversarial **0,86 ✅** (nenhum HIGH/CRITICAL). Retrabalho na sessão: (1) a 1ª carga depois do 73 tinha o
  "antes" do impacto todo recusado (indicador NULL) e escondia perdas por OUTRO motivo → o "antes" é lido DEPOIS de gravar o indicador e a perda
  pelo indicador entra pelo `cstGroupOff` (A-IB120; teste da ORDEM dos comandos); (2) ordem de deploy alinhada ao precedente da D-IB33 —
  **script 73 → carga da branch → deploy** — o desconhecido nunca chega à produção (cabeçalho do 73 + skill `carregar-catalogo-ibscbs` §4, com a
  conferência "0 CST NULL" antes do deploy); (3) sonda do boot com frase clara nos casos 1062/1205 (ADV-IB113-02); (4) `exigeGrupoIbsCbs` no
  acervo da Calculadora (linha das flags POR PAR, acima).

| Assunção (a ratificar) | O que fixa |
|---|---|
| **A-IB120** | Linha de base do impacto da carga: o veredito "antes" é lido DEPOIS de gravar o indicador do CST (o "antes" usa o indicador da FONTE); a perda pelo próprio indicador (`S`/NULL → `N`) entra no impacto pelo `cstGroupOff`. Revê a letra da D-IB47 só nesse ponto — para tudo o mais o impacto segue sendo a diferença do veredito |
| **A-IB121** | A conferência D-IB28 (a) confere também o GRUPO: `exigeGrupoIbsCbs` do par NFS-e × cClassTrib da Calculadora × `ind_gIBSCBS` do CST no IT; divergência tira a linha da NFS-e (o fisco decide o grupo pela Calculadora — E0961). Par sem o campo booleano = estrutura mudada, carga recusada |
| **A-IB122** | Indicador DESCONHECIDO (NULL) = recusado com o MESMO motivo `cst-without-group` (o 422 diz "ainda não foi carregado"; omissão e selo não distinguem) — e, pela D-IB120, ele não chega a um setes-api no ar enquanto o CST tiver cClassTrib vivo |

→ ✅ **A-IB120, A-IB121 e A-IB122 RATIFICADAS** (Valdo 2026-11-11, "a"). A regra da A-IB121 (Calculadora prevalece sobre o IT no grupo)
vale também para o ERP Desktop quando ele classificar serviços (D-IB123/regra fiscal dos dois ERPs).

- ✅ **Q-IB120 → D-IB120 (Valdo 2026-11-01, "Sim, recusar").** Texto original: **o boot RECUSA subir com CST de indicador desconhecido?** —
  (a) recusar quando um CST com indicador NULL ainda tem cClassTrib com linha viva (não superada); (b) manter o alerta + a conferência no
  checklist. Rec.: (a).

| Decisão | O que fixa |
|---|---|
| **D-IB120** (= Q-IB120 (a), Valdo 2026-11-01: "Sim, recusar") | O boot do setes-api (`assertIbscbsCatalogSchema`) NÃO sobe enquanto um CST de indicador do grupo DESCONHECIDO (NULL) ainda tem cClassTrib com linha VIVA (não superada — o código segue na fonte, a carga o alcança); a mensagem nomeia os CSTs e manda rodar a carga ANTES do deploy (ordem script 73 → carga → deploy). CST desconhecido sem linha viva (saiu da fonte antes da 1ª carga depois do 73) = só ALERTA. Com isto "D-IB113 no ar" (D-IB115) exige a carga por construção |

**Execução da D-IB120 (mesma worktree, mesmo dia)**: uma consulta por CST desconhecido (`EXISTS` de cClassTrib com linha viva) na peça;
testes do boot (recusa nomeando os CSTs; só alerta fora da fonte); prova do DDL (`prove-ibscbs-cst-group.ts`, agora com a identidade e a
história do cClassTrib copiadas) **28/28** — 73 aplicado sem a carga = o boot recusa listando os 18 CSTs; o 830 desconhecido e fora da fonte
= sobe com alerta; volta à fonte = recusa de novo; o teste ao vivo do gate passou a copiar a identidade do cClassTrib.
- ⏳ **Q-IB121 — ADV-IB113-01 (LOW, conhecimento negativo da CASA)**: numa sessão SEM modo estrito (o servidor do dev), SQL direto
  `SET requires_ibscbs_group = 'Sem grupo'` é TRUNCADO para `'S'` antes do CHECK e passa (vale para todo CHAR(1) com CHECK; a rotina do Super
  grava em STRICT). (a) registrar no PADROES §11 regra 11 e exigir `STRICT_ALL_TABLES` global no servidor de produção na Onda 4; (b) alargar
  as colunas de domínio. **Rec.: (a)** (questão da Onda 4; não trava a D-IB113).
  - ✅ **Q-IB121 → D-IB121** (Valdo, 2026-11-03, pela orquestradora da governança de projetos — B4 da fila única; literal: *"Exigir modo
    estrito (Recomendado)"*) — **(a)**: registrar no PADROES §11 regra 11 e exigir `STRICT_ALL_TABLES` global no servidor de produção na
    Onda 4 do deploy; vale para todos os serviços do ERP web. Descartada: (b) alargar as colunas de domínio. Execução: passo da Onda 4
    (deploy) na árvore de cada serviço, pela governança.

**Limites conhecidos registrados (sem decisão)**: ADV-IB113-03 — carga que vire um CST de `S` para `N` com um faturamento já aberto: a nota
congela pelo retrato da transação (o mesmo limite da D-IB70; a consequência agora seria E0859/E0961 — só numa mudança oficial do IT que a
Calculadora também confirme); o indicador NÃO tem data (atributo do CST, como a descrição): o IT que trocar o indicador muda o veredito de
competências ainda não faturadas — a nota congelada nunca reconsulta; CST que sair da fonte com NULL fica desconhecido (alerta a cada boot) —
hoje 18/18 na fonte; a sonda do boot grava (e desfaz) em `setes_central.tb_tax_ibscbs` — 2ª tabela do catálogo no boot, como a `tb_nbs` da
D-IB26: o GRANT mínimo da Onda 4 precisa de INSERT nela; ramo congelado ANTES do deploy com CST sem o grupo seguiria para o fisco (0 hoje —
censo); MySQL 8 revê o 73 (cláusulas só do MariaDB); aba cClass que ganhe a coluna `ind_gIBSCBS` seria lida como a do CST — recusa por CST
repetido (teste do gate).

**🎉 D-IB113 + D-IB120 PUBLICADAS — 2026-11-01 ("Vai, publicar" do Valdo), nesta ordem**:
1. Commits na `ib113` (api d5a7f35 · sql 3a11ca5 · app 0e6d0b5) + merge do `main` nos três SEM conflito (api 5cfd052 · sql 2232b84 · app
   b9f1f2a); suíte do merge **160 suítes, 2705 verdes** (34 ao vivo pulados), `tsc` limpo, `check:privileges` sem alarme, app 18/18.
2. **sql/73 aplicado em `setes_central`** (`apply-seed.ts`): coluna + CHECK conferidos no `information_schema`; os 18 CSTs NULL; o setes-api
   antigo seguiu no ar (ignora a coluna).
3. **Carga do catálogo da pasta da branch** (IT v1.70, Anexo VII v1.03.00, NBS da Calculadora): ENSAIO plano `b07477b619129422` — CST 18
   atualizados, `cstGroupOff` = 400, 410, 620, 800, 810, 811, 820, conferência 0 não confirmado/0 bloqueio/0 divergência (73 pares), nada
   encolhe, impacto vazio — e ATO com o mesmo plano: **GRAVADO**. Efeito a mais, da própria fonte: **3 presenças NOVAS na NFS-e — 000006, 200055
   e 200056** (códigos da A-IB1 que a Calculadora passou a ter; CST 000/200 levam o grupo → passam a ser OFERECIDOS no cadastro). Depois:
   0 CST com indicador NULL.
4. **Merge ff no `main`** do sql e do setes-api (`tsx watch` reiniciou: PID novo 20208, `/health` ok — o servidor só escuta depois de todas as
   conferências do boot, inclusive o 73, o CHECK e a D-IB120) + `npm run errors:gen` (179 códigos). Conferência no vivo (só leitura + a sonda
   do boot): boot `ok`; 000001/000006/200055/200056 aceitos; 410014/400001/811001/820001 recusados por `cst-without-group`; a lista de apoio
   (41 códigos) sem nenhum de CST sem o grupo.
5. **App**: merge ff no `main` (b9f1f2a) e o `flutter run -d web-server --web-port 5051 --dart-define-from-file=.env` REINICIADO numa aba
   nova "setes-app web 5051" (o processo antigo parado pela árvore do PID); `pt.json` servido com `cst-without-group`.

**Consequência (D-IB115)**: as duas condições estão cumpridas (prova em H + D-IB113 no ar) — a D-IB98 CAI: classificar serviço em P é
permitido, UM serviço e UMA nota primeiro, conferidos em "No fisco" (D-IB82/D-IB96). **GitHub EMPURRADO** (Valdo: "Sim, empurrar" — api 42278bf..5cfd052 · sql ff79a50..2232b84 · app 8b054f7..b9f1f2a; o remoto não tinha andado). Infra-IA não
commitada (arquivos compartilhados com outras sessões). ⚠️ A pasta `D:\Gestao2027\ib113` tem JUNÇÕES (`fiscal-api`, `nfse-api`) para as árvores
vivas: ao remover a worktree, apagar as junções com `cmd /c rmdir` ANTES (um `Remove-Item -Recurse` no PowerShell 5.1 pode apagar o conteúdo
do alvo).

## 14. Regime de IBS/CBS como CONFIGURAÇÃO por estabelecimento — D-IB99 (2026-10-31)

**Origem** (Valdo, ao ser cobrado da Q-IB1 vencida em 30/10, literal): *"por que tenho que responder isso e simplesmente não ter uma opção
para configurar no sistema, pois independente da Setes podemos ter outros clientes que escolheram coisas diferentes"*.

**Leitura**: o desenho já dizia isso — a D-IB7 fez do regime um fato DATADO por estabelecimento (`tb_establishment_tax_regime`, institution ×
`valid_from`; datado porque a opção é semestral e irretratável no semestre — §0). O erro foi de enquadramento: a D-IB66 adiou CONSTRUIR a
configuração até o 1º fato datado e usou a escolha de UM cliente (a Setes) como gatilho, tratando dado de cliente como decisão do sistema.
**Q-IB1 deixa de ser questão do sistema**: vira o DADO da Setes, preenchido na tela dela; sem preenchimento vale "não optar" (efeito legal —
D-IB1). Fato a conferir com o contador (não trava nada): se a Setes optou pelo regular até 30/10, pela D-IB99 o faturamento dela é recusado a
partir de 01/01/2027 — aí o cálculo do regime regular (D-IB11/D-IB12) vira tarefa de dezembro.

- ✅ **Q-IB102 → D-IB99 (2026-10-31, (a)).** Texto original: **o que o sistema faz quando o estabelecimento escolhe o regime regular** (o
  regular muda a nota — `vTotNF` soma IBS/CBS — e o financeiro — títulos nascidos antes da transmissão, D-IB11/D-IB12 —, e essa parte não
  existe): (a) **configuração já, com as três opções e a data de início; a escolha do regular é GRAVADA, mas o faturamento recusa com
  mensagem clara ("regime regular de IBS/CBS ainda não suportado") a partir da data de efeito, até o cálculo existir** — molde do não optante
  do Simples na NFS-e (Q-N37); (b) configuração já, só com "não optar" liberado; (c) configuração + cálculo do regular agora. **Rec.: (a)**.

| Decisão | O que fixa |
|---|---|
| **D-IB99** (Valdo 2026-10-31: "Opção (a)") | O regime de IBS/CBS do Simples é CONFIGURAÇÃO de cada estabelecimento, com data de início — as três opções (`regApIBSCBSSN` 1 = não optar, IBS/CBS no DAS · 2 = só CBS regular · 3 = IBS e CBS regular), resolvida pela data de COMPETÊNCIA; padrão de quem não preenche = 1 (D-IB1). Escolher 2/3 é aceito e gravado; o faturamento RECUSA (422 com código próprio e mensagem "ainda não suportado") toda nota cuja competência caia na vigência de 2/3, até o cálculo do regime regular (D-IB11/D-IB12) existir — nunca emite nota errada. **REVÊ a D-IB66**: a configuração datada nasce JÁ, não espera o 1º fato datado (os três gatilhos da D-IB66 morrem). Prazo: no ar antes de 01/01/2027 (data da obrigação do Simples). Execução: sessão própria (setes-api establishment + billing, `sql/`, setes-app Meu Estabelecimento) pelo guardião + `revisar-ddl` sobre o rascunho B3 (`prompt_fase_ibs_cbs-ddl-ib1-rascunho.sql`); a D-IB66 apontava que a tabela sem a D-IB24 (CRT derivado) espalha o CRT em duas casas — a execução confere com o guardião se a D-IB24 vem junto (se exigir escolha, vira questão). Vale a D-CF1 (motor de campos na aba). Liga com a D-PV32 (6) do `prompt_privilegios_interfaces.md` (tributação do EMITENTE separada da RELAÇÃO em peça datada "fica para a D-IB7, sem prazo") — com a D-IB99 o prazo passa a ser 01/01/2027 para o regime; o resto do enquadramento segue o que o guardião disser |

**Correção de documentação (sem decisão — NT 009 p. 9, conferida 2026-10-31)**: `regApIBSCBSSN` **2 = CBS apurada pelo SN e IBS pelo
regime regular** (a D-IB99 e a Q-IB102 descreveram a opção 2 ao contrário; o §0 e o B3 do rascunho estão certos). O comportamento não muda —
2 e 3 são recusados igual —; o rótulo da tela e a mensagem seguem a NT.

### 14.1 Parecer do guardião e Rodada 1 da execução — D-IB100 (2026-10-31)

Parecer do `setes-conceito` (íntegra na pasta de notas da sessão-mãe, `ib99-parecer-guardiao.md`): a opção do Simples pelo regime de
apuração do IBS/CBS tem FATO GERADOR PRÓPRIO (opção CGSN 194, semestral e irretratável no semestre; no MAT para quem abre a empresa) —
distinto do enquadramento no Simples (opSimpNac: opção/exclusão), do sublimite (regApTribSN) e do pTotTribSN (mensal). A linha única do B3
precisaria de dois CHECKs cruzados só para não se contradizer e copiaria os vizinhos a cada mudança (teste da maquete). Divergia da letra
da D-IB7 → questão ao Valdo, uma só:

- ✅ **Q-IB103 → D-IB100 (Valdo 2026-10-31, "(b) Peça própria").** Texto original: **onde fica a opção de regime IBS/CBS datada** —
  (a) letra da D-IB7: tabela com o enquadramento inteiro + D-IB24 + troca do leitor do NÚCLEO (`fiscal-api/src/erp/facts.ts`, janela da
  D-F133) + contract das colunas de `tb_entity_tax`; (b) **peça própria SÓ da opção, `tb_establishment_ibscbs_assessment`
  (estabelecimento × `valid_from`, `assessment` 1/2/3, autor obrigatório); opSimpNac/regApTribSN/pTotTribSN/regEspTrib/CRT ficam em
  `tb_entity_tax` até o próprio 1º fato datado (somam depois, sem reforma); núcleo e nfse-api não mudam (o leiaute 1.01 não leva o
  campo)**. *(Rec.: (b).)*

| Decisão | O que fixa |
|---|---|
| **D-IB100** (Valdo 2026-10-31: "(b) Peça própria") | A opção de apuração do IBS/CBS do Simples é peça PRÓPRIA e DATADA do ESTABELECIMENTO — `tb_establishment_ibscbs_assessment` (PK estabelecimento × `valid_from`; `assessment` CHAR(1) 1/2/3 com CHECK binário; `tb_user_id` NOT NULL), dona única a peça `@shared/ibscbs-assessment`. **REVÊ a letra da D-IB7** (a tabela única `tb_establishment_tax_regime` com o enquadramento inteiro não nasce): opSimpNac, regApTribSN, pTotTribSN, regEspTrib e o CRT seguem em `tb_entity_tax` sob a convenção "sem história" da D-IB66 (limite conhecido: a nfse-api lê o opSimpNac na transmissão) e cada um vira peça datada própria quando tiver o seu 1º fato datado. **A D-IB24 (CRT derivado) NÃO vem junto** — com a peça só da opção o CRT continua numa casa só; a dupla codificação CRT × opSimpNac (maquete nº 10) fica como está, sem piorar. Núcleo `fiscal-api` e nfse-api intocados |

**O resto do parecer (não diverge de decisão — executado como regra da peça)**: sem `valid_until` (a linha seguinte fecha a anterior; a PK
impede sobreposição) · **sem linha = 1** (efeito legal da D-IB1 — sem backfill e sem piso; uma linha '1' explícita só fecha um período 2/3)
· inserir com início ≥ hoje do estabelecimento (fuso — PADROES §10) · alterar/excluir (soft) só linha FUTURA; a vigente e as passadas são
imutáveis (o passado já lido por uma nota nunca muda) · revive da mesma PK sem herdar nada (PADROES §3.1) · **2/3 só com início ≥
2027-01-01** (piso legal na peça, 422 no campo da data); o calendário 01/01·01/07 NÃO é travado (MAT/exclusão de ofício têm "data do fato
motivador") — a tela só SUGERE o próximo início de semestre · "suportado" é propriedade do CÓDIGO (constante que cresce com a D-IB11/D-IB12),
nunca coluna · a recusa mora no ESCRITOR ÚNICO da nota (`issueInvoice`), antes de cunhar o número, com leitura travante compartilhada na
conexão da transação — vale para TODO modelo (SE/55/65) e todo produtor (venda, conjugada, devolução, OS, lote, revive); as prévias (validate
da venda, detalhe da OS) perguntam pela MESMA regra, sem trava · `emitterRegimeAt` não muda (a obrigação do Simples começa em 01/01/2027
qualquer que seja a opção) · o não optante segue barrado na transmissão pela nfse-api (F4/IB-N) · sub-recurso próprio como escritor único (o
PUT do estabelecimento não recebe a opção) · motor de campos: só as 2 colunas da seção no catálogo de `establishment` (o resto da tela na onda
da D-CF4) · glossário: "apuração (assessment)" ≠ "regime". **Para conferir com o contador (não trava nada)**: o MEI pode fazer a opção? (a
NT 009 diz "optante ou pendente"); a opção é da RAIZ do CNPJ e a tabela é por estabelecimento (filiais repetem o valor — limite para a frente
do grupo).

### 14.2 Execução da D-IB99/D-IB100 (2026-10-31→11-01, worktrees `D:\Gestao2027\ib99\{setes-api,sql,setes-app}`, branch `ib99`, a partir do `main` — NADA mergeado, aplicado em banco vivo ou com push)

- **DDL**: migration **076** `setes-api/src/migrations/sql/076_establishment_ibscbs_assessment.sql` (CREATE TABLE IF NOT EXISTS + FK para
  `setes_central.tb_institution` + `ck_establishment_ibscbs_assessment` `assessment COLLATE utf8mb4_bin IN ('1','2','3')` por ADD CONSTRAINT IF
  NOT EXISTS — re-executável); espelho no canônico `sql/03_schema_cliente_ddl.sql`; seed **`sql/71_establishment_ibscbs_assessment_fields_seed.sql`**
  (catálogo de campos da interface `establishment`: `valid_from` Date + `assessment` String, técnicos 'S'; id da interface por `i18n_key`).
  Números conferidos livres em 31/10 (071–075 e sql/66–70 são de outras branches). **Provado em schema descartável** —
  `setes-api/scripts/prove-ibscbs-assessment.ts`: 076 aplicada 3× sem erro; CHECK pelo NOME e corpo (o MariaDB 10.4 guarda
  `` `assessment` collate utf8mb4_bin in ('1','2','3') ``); domínio recusa '4','0','',' ','a'; a peça inteira (registrar, duplicata, alterar,
  excluir soft com autor, reviver sem herdar, vigente imutável, piso do regular, recusa na competência); **a TRAVA**: com o faturamento lendo a
  opção (LOCK IN SHARE MODE) na competência, registrar opção com início ≤ competência ESPERA — com e SEM linha anterior (a gap lock cobre a 1ª
  opção); depois do commit passa. Conhecimento (MariaDB 10.4, provado): a mesma leitura também segura o registro de início DEPOIS da
  competência (next-key da busca descendente) — inofensivo (espera curta). Schema apagado; nenhum resíduo.
- **setes-api**: peça **`@shared/ibscbs-assessment`** (dona única — cerca `ibscbs-assessment-fence.test.ts`: nenhum outro arquivo de `src/`,
  `scripts/` ou migrations nomeia a tabela; sem DELETE/REPLACE/TRUNCATE): `ibscbsAssessmentAt` (linha viva de maior início ≤ data; travante
  sob pedido), `assessmentRefusalOf`/`assertIbscbsAssessmentSupported` (422 **`IBSCBS_REGULAR_REGIME_UNSUPPORTED`**, mensagem com a opção, o
  início e a competência), `previewIbscbsAssessmentRefusal`, `readIbscbsAssessmentView`, `createIbscbsAssessment` / `changeIbscbsAssessment` /
  `removeIbscbsAssessment` (transação + `withDeadlockRetry`; trava de REGISTRO pela PK completa — PADROES §9 regra 8; INSERT atômico, duplicata
  viva 409, morta = revive), `isIsoDate` (data de calendário real — o servidor roda sem modo estrito), boot `assertIbscbsAssessmentChecks` (CHECK
  pelo nome e corpo em cada schema vivo; faltando, NÃO sobe — `server.ts`, depois das migrations). **`issueInvoice`** chama a regra ANTES do
  `nextInvoiceNumber`. Prévias: `previewServiceIbscbs` dobra a recusa da opção no `refusal` (e no `atObligation`) DEPOIS da recusa da declaração
  (a ordem do faturamento); o validate da venda empurra a issue `order/ibscbsAssessment` também na venda só de mercadoria, sem repetir quando a
  prévia do serviço já a trouxe. Sub-recurso **`GET/POST /api/establishment/ibscbs-assessments`** e **`PUT/DELETE …/:validFrom`** (adminGuard
  herdado; institution do token; a data é a identidade; Swagger), DTO com data real e domínio da NT; o PUT do estabelecimento NÃO recebe a
  opção. Motor de campos: **`assertClientRequired(..., onlyFields)`** — tela com DOIS salvares sobre o mesmo catálogo confere em cada porta só
  as colunas que ela recebe (sem isso, o campo apertado numa seção recusaria a outra). Códigos novos: `IBSCBS_REGULAR_REGIME_UNSUPPORTED`,
  `IBSCBS_ASSESSMENT_DATE_PAST`, `_REGULAR_TOO_EARLY`, `_DUPLICATE`, `_NOT_FOUND`, `_IN_EFFECT` (`errors:gen` NÃO rodado — escreve no
  `setes_central` vivo; roda na publicação).
- **setes-app**: 6ª aba **"Regime IBS/CBS"** no Meu Estabelecimento — seção AUTÔNOMA (molde da aba Emissor fiscal: datasource próprio
  `EstablishmentIbscbsAssessmentDatasource` → setes-api, botões próprios, ponte de feedback): "vale hoje" (sem linha = apuração pelo Simples),
  AVISO vermelho quando há 2/3 vigente ou futura ("a partir de dd/mm/aaaa o faturamento será RECUSADO"), histórico com linha futura editável
  (Salvar/Excluir) e as demais só leitura, registrar com data sugerida (próximo 01/01 ou 01/07) + opção; pendências espelham a regra da API
  antes do envio. A página carrega o motor de campos (`FieldConfigLoader('establishment')`) e a seção aplica o rótulo do cliente. i18n pt/en.
- **Provas**: `tsc` limpo · **setes-api 137/137 suítes, 2184 testes** (31 ao vivo pulados) — novos: `ibscbs-assessment` (16), `ibscbs-assessment-fence`
  (3), `establishment-ibscbs-assessment` (7) + `invoice` (recusa ANTES do número, sem linha segue), `billing` (issue na venda só de mercadoria,
  sem duplicar), `ibscbs-ib3-erp` (prévia com a opção 3; declaração incompleta vem primeiro; linha '1' fecha o período), `field-config`
  (`onlyFields`) · app: teste novo `establishment_ibscbs_assessment_test.dart` 10/10 (+ `flutter analyze` e suíte — ver abaixo).
- **Limites conhecidos (registrados, sem decisão)**: notas que chegam pelo sincronizador (setes-sync) não passam pelo `issueInvoice` (o legado
  emite) — fora do alcance da recusa; a convenção "sem história" segue para opSimpNac & cia (nota de 30/12 transmitida em 02/01 sai com o
  opSimpNac do dia da transmissão — D-IB66); a recusa usa a competência `dt_emission` (D-IB64) — se a D-IB64 mudar com o contador, muda junto
  pelo dono único da data.
- **Para a JANELA de publicação (depois do passo 4 do plano 10-21, com o "vai")**: o bloco de privilégios põe a guarda POR ROTEADOR (D-PV2) —
  conferir que as 4 rotas novas caem nos verbos V/I/A/E de `establishment` e entram na lista da cerca (D-PV9); renumerar 076 / sql/71 se outra
  branch tiver tomado o número; aplicar o seed 71 antes do app; `errors:gen`; a migration 076 sobe no boot (o boot confere o CHECK).
- **Consumidor seguinte (sem decisão — liga com a IB-4, §13.8 fim)**: a produção restrita usa desde 20/10/2026 o pacote da NT 009, que
  tem `regApIBSCBSSN` no `prest/regTrib` do DPS. Quando o montador da nfse-api adotar a NT 009, ESTA peça é a fonte do campo, lida pela
  competência (`dCompet`) — pela fonte de fatos da nfse-api (view + GRANT mínimo, molde D-F15), nunca por cópia; o núcleo/nfse-api
  ganham o leitor nessa janela (D-F133). Até lá, nada vai ao fisco (o 1.01 não leva o campo).

### 14.3 Gates da D-IB99/D-IB100 (2026-11-01) — socrático **0,76 ✅** · adversarial **0,72 ✅** (nenhum HIGH/CRITICAL; 2 MEDIUM dependem de decisão)

Agentes independentes, seguindo `skills-genericas/revisar-riscos-sistemicos.md` e `testar-adversarial.md` (ataques reais SÓ em schemas
descartáveis `setes_ib99_adv_*`, todos apagados; nada escrito em `setes_setes`/`setes_central`/árvores vivas).

**Corrigido na sessão (sem decisão)**:
- **ADV-IB99-03 (LOW)** — competência inválida (`''`, `'abc'`, `'2027-13-45'`) acharia "sem linha" e valeria 1 (a nota passaria com 3
  vigente): `ibscbsAssessmentAt` falha FECHADO (erro de programação do produtor) antes do SQL — teste na peça.
- **ADV-IB99-04 (LOW, transversal)** — `:param` com URI malformada (`%`, `%E0%A4%A`) dava 500 sem `code` (URIError do Express 4 antes do
  controller): o handler global de `app.ts` devolve 400 `VALIDATION_FAILED` — vale para TODA rota com parâmetro; teste
  `adversarial-ib99-gate.test.ts` pela porta HTTP real (inclusive 403/401 seguem).
- **ADV-IB99-05 (LOW)** — 4 reviveres simultâneos da mesma data morta esgotavam o retry (INSERT com chave duplicada pega trava S e
  sobe para X → 1213 → 409 RESOURCE_BUSY): o registro agora escolhe o caminho por leitura consistente, TRAVA a linha que existe por
  REGISTRO antes de decidir e só INSERE a que não existe (duplicata no INSERT = 409 DUPLICATE). Provado ao vivo (schema descartável):
  revive ×4 e criação ×4 = 1 ok + 3 `IBSCBS_ASSESSMENT_DUPLICATE`, sem deadlock.
- Socrático LOW: Swagger dos dois faturamentos (`/api/billing/invoice`, `/api/service-orders/:id/invoice`) cita o 422 novo; o texto da
  peça e da prova promete só o que a trava faz (ORDENA o registro depois do faturamento em curso — não confere notas já nascidas); app:
  `initialDate` do seletor de data preso ao intervalo (data digitada fora dele derrubava o Flutter) e **registrar/trocar para opção sem
  suporte pede decisão explícita** (como a exclusão — é o ato que bloqueia o faturamento a partir da data).

**Conhecimento (sem ação)**: a leitura travante SEM linha do estabelecimento põe trava de intervalo até a fronteira com o estabelecimento
vizinho do MESMO schema (grupo) — o registro de outra filial espera faturamentos alheios (espera curta, sem ciclo: o faturamento nunca
espera o registro); `onlyFields` hoje não tem efeito (as 2 colunas do seed 71 são técnicas e o PUT principal não chama o motor) — é
preventivo para a onda da D-CF4; boot: `assertIbscbsAssessmentChecks` consulta `information_schema` por schema, em série (como o
`assertF2aFreezeTriggers`) — um schema sem o CHECK impede o boot de todos (raio de explosão aceito pelo molde D-IB26; orçamento de boot com
1000 clientes = item da Onda 4/F3). Lote da OS: a ordem recusada vira linha do relatório com o código, o lote segue (analisado).

**Questões para o Valdo (uma por vez — recomendação entre parênteses)**:
- ✅ **Q-IB104 → D-IB101 (Valdo 2026-11-01, "(a) Hoje ou última nota" — §14.4). A fronteira do que muda (ADV-IB99-01 + ADV-IB99-02, MEDIUM; socrático ponto 1).** A competência é por DIA: uma nota de
  hoje nasce com 1 às 10h; às 10h05 o admin registra 3 com início HOJE (aceito — só se recusa início antes de hoje) e a nota passa a cair na
  vigência de 3 (quando a NT 009 levar o `regApIBSCBSSN` ao DPS, a nfse-api leria 3 para uma nota calculada como Simples). O mesmo na virada
  da meia-noite, e — provado — trocando o fuso do estabelecimento (SP → Rio_Branco, opção do seed 60) o "hoje" volta um dia: a linha vigente
  vira editável e o início "ontem" passa. A trava só ORDENA. (a) **a fronteira é o MAIOR entre hoje e a última `dt_emission` de nota VIVA do
  estabelecimento, lida TRAVADA na transação do registro, com o relógio de DEPOIS da trava: registrar/alterar/excluir recusam (409) início ≤
  essa data** — fecha o "hoje", a meia-noite e o fuso trocado; (b) início só DEPOIS de hoje (simétrico a alterar/excluir) — não fecha a
  meia-noite nem o fuso; (c) manter início ≥ hoje como limite conhecido. *(Rec.: (a) — é a leitura literal de "o passado já lido por uma
  nota nunca muda"; os testes ao vivo do gate — `ib99-adversarial-live.test.ts` na pasta de notas da sessão-mãe — passam com (a).)*
- ✅ **Q-IB105 → D-IB102 (Valdo 2026-11-01, "(a) API recusa 2/3" — §14.5). Estabelecimento que NÃO é do Simples (socrático ponto 2).** Hoje a aba aparece para todos e a API aceita 2/3 de qualquer
  estabelecimento: um Lucro Presumido que registre 3 (ou um optante que saia do Simples deixando uma linha 3 futura) passa a ter TODO
  faturamento recusado com uma mensagem que fala da opção do Simples. (a) **a API recusa REGISTRAR/TROCAR para 2/3 quando o opSimpNac
  gravado não é 3/4; a aba segue sempre visível (uma linha futura nunca fica órfã — dá para excluí-la)**; (b) aba só com opSimpNac 3/4 (o
  guardião sugeriu) e a API sem conferência; (c) como está. *(Rec.: (a).)*
- ✅ **Q-IB106 → D-IB104 (Valdo 2026-11-01, "(a) Avisar na aba" — §14.7). Estabelecimento que emite também pelo ERP Desktop (socrático ponto 3).** *(Reformulada 2026-11-01 com os termos "ERP Desktop"
  × "ERP web", pedido do Valdo — o conteúdo não mudou.)* A opção registrada na aba "Regime IBS/CBS" é do **ERP web**: só a nota emitida pelo
  ERP web passa pela recusa (`issueInvoice`). As notas do **ERP Desktop** chegam ao mesmo `tb_invoice` pelo sincronizador/setes-sync sem passar
  por ela, e o ERP Desktop tem a própria chave da reforma (D-IB3) — no mesmo CNPJ haveria notas do ERP web recusadas e notas do ERP Desktop vivas
  na vigência de 2/3. (a) **a aba avisa, quando o estabelecimento tem sincronizador, que a opção governa só as notas emitidas pelo ERP web**
  (o texto visível segue a regra de não citar o sistema antigo na tela — redação final do Valdo); (b) o sub-recurso recusa 2/3 enquanto o
  estabelecimento emitir pelo ERP Desktop; (c) limite conhecido, sem aviso. *(Rec.: (a).)*

**Estado**: branch `ib99` com testes verdes (ver §14.2, contagem final abaixo), gates passados com as questões acima como pendência
explícita (regra do gate: score ≥ 0,70 com pontos abertos → entrega registrando-os). Nada mergeado/aplicado/pushado. A Q-IB104, se (a),
muda só a peça (`@shared/ibscbs-assessment`) e a prova; a Q-IB105 (a) toca a peça (lê o opSimpNac de `tb_entity_tax`); a Q-IB106 (a) só o app.

**Contagem final (2026-11-01, depois das correções dos gates)**: `tsc` limpo · **setes-api 138/138 suítes, 2193 testes** (31 ao vivo pulados) · prova `scripts/prove-ibscbs-assessment.ts` OK (inclui revive ×4 e criação ×4 concorrentes) · **app: `flutter analyze` sem aviso, 645 testes verdes** (28 pulados; `establishment_ibscbs_assessment_test.dart` 11/11). Commit LOCAL na branch `ib99` dos três repositórios — api **2d6c393** · sql **0d3df12** · app **bef45ad** — (sem push, sem merge); os testes ao vivo do gate adversarial para a Q-IB104 ficaram na pasta de notas (`ib99-adversarial-live.test.ts`, opt-in `IB99_ADV_LIVE=1`) — entram no repositório com a decisão.

### 14.4 Rodada 2 da execução — D-IB101 (Valdo 2026-11-01) e a execução

| Decisão | O que fixa |
|---|---|
| **D-IB101** (Valdo 2026-11-01: "(a) Hoje ou última nota" — fecha a Q-IB104) | A FRONTEIRA do que a opção de apuração do IBS/CBS pode mudar é o MAIOR entre HOJE e a ÚLTIMA data de emissão (`dt_emission`) de nota VIVA do estabelecimento (qualquer terminal/modelo; a autorizada cancelada segue viva), lida na transação do registro DEPOIS da trava que serializa com o faturamento e com o relógio REAL de depois da espera: registrar, alterar ou excluir com início ≤ essa data = **409 `IBSCBS_ASSESSMENT_INVOICED`** (`fields[validFrom]`). Leitura literal de "o passado já lido por uma nota nunca muda": fecha a opção registrada HOJE depois de uma nota de hoje, a virada da meia-noite e a troca do fuso do estabelecimento (o "hoje" anda para trás; a nota não). A espera ORDENA (o faturamento lê com LOCK IN SHARE MODE); quem CONFERE é o escritor da opção |

**Nota do Valdo à Q-IB104 (2026-11-01, sessão-mãe — literal)**: *"Q-IB104 o governo tem regras proprias para troca de regime, normalmente
depois de escolher deve ficar o ano fiscal nela, pode acnotecer de sr expulso de um regime por falta de complaince...nao acredito que
precisemos cuidar disso"*. **Complemento da D-IB101 — conhecimento negativo**: o sistema NÃO controla as regras do governo sobre a opção —
permanência mínima no período (ano/semestre, "irretratável no semestre"), prazo/calendário para optar, exclusão do regime por
descumprimento. A opção é DADO DECLARADO pelo estabelecimento; não nascem trava de permanência, calendário de opção nem exclusão automática.
A D-IB101 não é regra do governo: só protege o passado já lido por uma nota. **Conferido no código (2026-11-01)**: nenhuma trava desse tipo
— registrar/alterar/excluir dependem só de "linha futura" (D-IB100) e "depois da última nota" (D-IB101); trocar de opção é registrar uma
linha nova a qualquer momento; o calendário 01/01·01/07 é só SUGESTÃO na tela. A única regra legal na peça é o PISO de 01/01/2027 para 2/3
(a opção pelo regular só existe na lei a partir daí — evita parar o faturamento por uma data digitada em 2026); não é regra de troca de
regime — se o Valdo quiser tirá-lo também, é ajuste de uma linha (`assertRegularFloor`).

**Execução (worktree `ib99`, mesma branch — nada mergeado/aplicado/pushado)**:
- Peça `@shared/ibscbs-assessment`: `frontierAfterLock` (hoje por `todayFor(…, conn, new Date())` + `lastLiveEmissionDate`) chamada SEMPRE depois
  da trava, sem leitura consistente antes dela na transação (o retrato nasce depois da espera e enxerga a nota que o faturamento concorrente
  acabou de gravar); `assertNotInvoiced` nos três atos. **Registrar em DUAS transações**: (1) o INSERT é a própria trava (espera o faturamento
  que leu a data) e a fronteira vem depois — falhou, desfaz; chave já existente encerra a transação sem nada gravado; (2) a linha existente é
  travada por REGISTRO (`FOR UPDATE`) antes da fronteira e do revive (ADV-IB99-05 segue fechado). Piso do regular antes de abrir transação.
- `@shared/invoice/emission-date` (dono único da data de emissão) ganhou `lastLiveEmissionDate` — MAX(`dt_emission`) de `tb_invoice`
  `deleted='N'` da institution (prefixo `tb_institution_id` do `idx_invoice_number_seq`), leitura consistente; a peça da opção não nomeia
  `tb_invoice` (cerca de dono único intacta). Código novo `IBSCBS_ASSESSMENT_INVOICED`.
- Provas: testes da peça reescritos para o fluxo (a trava é o 1º comando; a fronteira vem depois; `todayFor` com relógio real; INVOICED nos
  três atos; revive respeita a fronteira) · **`src/__tests__/adversarial-ib99-live.test.ts`** (opt-in `IB99_ADV_LIVE=1`, schema descartável):
  ADV-IB99-01, -02 (fuso SP → Rio_Branco) e -05 — **3/3 verdes** · prova `scripts/prove-ibscbs-assessment.ts` ganhou a corrida-chave: o
  faturamento lê a opção (travado), o registro com início na competência ESPERA, o faturamento grava a nota e confirma, o registro passa e
  **recusa com INVOICED** (o retrato nasceu depois da espera) — PROVA OK, schema apagado. App: sugestão da data diz "depois da última nota
  emitida" (o 409 com `fields[validFrom]` já foca o campo).

**Gates do delta da D-IB101 (2026-11-01) — socrático 0,74 ✅ · adversarial 0,74 ✅ (sem HIGH/CRITICAL)**. Confirmado pelo ataque (schemas
`setes_ib99_d101_*`, apagados): a premissa "nenhuma leitura consistente antes da trava" vale nos 4 caminhos (o INSERT é o 1º comando; a FK
no pai central é leitura travante e não cria o retrato; revive/alterar/excluir começam pelo `FOR UPDATE`); a 1ª transação do registro com
chave duplicada solta a trava S no commit, sem resíduo; corridas registro × faturamento consistentes em todas as ordens (revive de linha
morta, início posterior à competência, linha viva anterior). **Corrigido na sessão (sem decisão)**:
- **ADV-D101-02 (MEDIUM)** — a MAX(`dt_emission`) varria todas as notas da institution sob a trava (300 mil notas: 4–6 s com o faturamento
  parado; um registro com data passada que terminava em 422 segurou o faturamento 4,8 s): índice **`idx_invoice_live_emission`
  (`tb_institution_id`, `deleted`, `dt_emission`) na própria 076** (+ canônico `sql/03`) — EXPLAIN provado: *Select tables optimized away* — e
  **pré-checagem pelo pool, SEM trava** (`assertRegistrable` antes da transação; a conferência DECISIVA continua depois da trava — teste
  "o hoje virou entre a pré-checagem e a trava").
- **ADV-D101-05 (LOW)** — Swagger dos três atos cita o 409 `IBSCBS_ASSESSMENT_INVOICED`; a visão (`GET`) ganhou `lastInvoice` e `firstStart`
  (o 1º início aceito = o maior entre hoje e o dia seguinte à última nota) e `editable` respeita a última nota; app: sugestão e seletor a partir
  do `firstStart`, pendência própria ("já existe nota emitida em …") e a recusa de uma LINHA não leva o foco ao campo do registro novo.
- **ADV-D101-06 (LOW)** — os testes ao vivo passam a fixar o relógio REAL (`jest.setSystemTime`, só o `Date` falso) — exercitam o "hoje", o
  fuso e a meia-noite de verdade; + a corrida "o registro que espera o faturamento enxerga a nota e recusa" como teste permanente (4/4 ao vivo).
- **Conhecimento (sem ação)**: **ADV-D101-03 (LOW)** — o INSERT da opção toma trava S no pai da FK (`setes_central.tb_institution`) e a venda
  toma X no mesmo pai DEPOIS de ler a opção (`lockInstitutionCounters` do `nextSettledCode`): impasse provado; o InnoDB escolheu o REGISTRO
  (transação menor), que refez e terminou em INVOICED — os dois lados têm `withDeadlockRetry`. **ADV-D101-04 (LOW)** — nota do legado/PDV ainda
  na fila do sincronizador não entra na fronteira (limite da Q-IB106).

**Questão nova para o Valdo (do MEDIUM ADV-D101-01 — o socrático chegou à mesma)**:
- ✅ **Q-IB107 → D-IB103 (Valdo 2026-11-01, "(b) Só do ERP web" — §14.6). Quais notas formam a fronteira da D-IB101.** *(Reformulada 2026-11-01 com os termos "ERP Desktop" × "ERP web", pedido do
  Valdo — o conteúdo não mudou.)* A D-IB101 protege "o que uma nota já leu": a opção registrada no ERP web nunca muda a data de uma nota que a
  leu. Hoje a fronteira conta TODA nota viva do estabelecimento em `tb_invoice`, que guarda três tipos: (1) as notas emitidas pelo **ERP web**
  — nascem pelo `issueInvoice`, que lê a opção (têm evento E em `tb_invoice_event`; 678 das 680 do dev); (2) as notas emitidas pelo **ERP
  Desktop**, que chegam pelo sincronizador (6.470 no dev, sem evento E) — NUNCA leram a opção do ERP web (o desktop tem a própria chave, D-IB3);
  (3) as COMPRAS (notas de terceiros recebidas). Provado: uma nota do tipo (2) ou (3) com `dt_emission` 2062-06-20 (data digitada errada no ERP
  Desktop/PDV) impede registrar a opção 3 em 2027-01-01, sem saída pela tela — e a opção pelo regular tem prazo legal; uma compra de HOJE impede
  registrar a partir de hoje. (a) as três (como está); (b) **só as notas emitidas pelo ERP web (as que de fato leram a opção)**. O campo `issuer`
  não serve para separar (o sincronizador grava `issuer` = cliente); o critério é o evento E. *(Rec.: (b).)*

**Conferência pedida pela sessão-mãe (2026-11-01)**: nenhuma trava de permanência/calendário/exclusão no código — ver a nota do Valdo acima.

**Contagem final do delta (2026-11-01)**: `tsc` limpo · **setes-api 138/138 suítes, 2196 testes** (35 pulados — inclusive a suíte ao vivo opt-in `adversarial-ib99-live`, 4/4 com `IB99_ADV_LIVE=1`) · prova OK (corrida + EXPLAIN do índice) · app `flutter analyze` sem aviso, **648 verdes**. Commits LOCAIS na branch `ib99`: api **921149f** · sql **070ddc7** · app **8571d23** (sobre 2d6c393 · 0d3df12 · bef45ad). Observado: `adversarial-d-rs4-gate.test.ts` (recuperação de senha, fora desta frente) falhou 1× na suíte completa e passou sozinho (23/23) e na rodada seguinte — intermitente por tempo.

### 14.5 Rodada 3 da execução — D-IB102 (Valdo 2026-11-01)

| Decisão | O que fixa |
|---|---|
| **D-IB102** (Valdo 2026-11-01: "(a) API recusa 2/3" — fecha a Q-IB105) | Registrar ou TROCAR para o regime regular (2/3) só com o opSimpNac GRAVADO no estabelecimento = **3 (ME/EPP) ou 4 (opção pendente)** — senão **422 `IBSCBS_ASSESSMENT_NOT_SIMPLES`** (`fields[assessment]`, a mensagem nomeia o regime gravado). A aba segue SEMPRE visível: registrar a opção 1 e EXCLUIR linha futura nunca leem o regime — a linha 2/3 deixada por quem saiu do Simples nunca fica órfã. O opSimpNac é lido de `tb_entity_tax` (convenção "sem história" — D-IB66), pela peça dona dele (`emitterRegimeAt`). O faturamento NÃO muda: recusa toda nota na vigência de 2/3 (D-IB99), qualquer que seja o regime |

**Execução (mesma worktree/branch `ib99`)**: peça `@shared/ibscbs-assessment` — `assertRegularAllowed` na PRÉ-CHECAGEM (pool, sem trava) e na
conferência DECISIVA dentro das transações de registrar, reviver e trocar, com leitura TRAVANTE compartilhada do regime (PADROES §9 regra 2),
depois da trava da linha da opção; visão com `simplesRegime`/`regularAllowed`; Swagger (422 nos atos). App: pendência própria (2/3 sem
ME/EPP nem pendente — nada vai à API) e aviso "Regime do Simples gravado: … — as opções 2 e 3 não são aceitas; a 1 e a exclusão seguem
possíveis". MEI ('2') fica de fora (letra da D-IB99/Q-IB105; a pergunta ao contador "o MEI pode optar?" segue do §14.1). Testes: peça
(+ pré-checagem sem transação, decisiva travante depois do INSERT, MEI/não optante/não informado, 1 e excluir sem ler o regime, troca),
ao vivo `adversarial-ib99-live.test.ts` **5/5** (o schema descartável ganhou `tb_entity_tax` ME/EPP), prova OK, app 16/16.

**Gates do delta da D-IB102 (2026-11-01)** — socrático **0,76 ✅**; adversarial 1ª rodada **0,68 ✗** (sem HIGH, reprovado pelo score) →
corrigido → **re-prova 0,86 ✅**:
- **ADV-D102-01 (MEDIUM, provado)** — ORDEM DE TRAVAS invertida em relação ao faturamento: o registro travava X na opção e DEPOIS pedia S em
  `tb_entity_tax`; o faturamento trava S em `tb_entity_tax` (declaração IBS/CBS) e DEPOIS lê a opção (S) no `issueInvoice`. Com um PUT do
  regime (X em `tb_entity_tax`) na fila, fechava ciclo de 3 e o PUT era a VÍTIMA (1213, sem retry, com a cadeia já gravada). **Correção**: a
  leitura TRAVANTE do regime é o 1º comando das transações de registrar, reviver e trocar (só para 2/3) — a mesma ordem do faturamento.
  **Conhecimento provado (MariaDB 10.4)**: leitura TRAVANTE (`LOCK IN SHARE MODE`/`FOR UPDATE`, inclusive em linha inexistente) NÃO abre o
  retrato do REPEATABLE READ — a 1ª leitura consistente depois dela ainda enxerga o que outra sessão gravou no meio; a fronteira da D-IB101
  continua nascendo depois da espera (teste vivo "D-IB101 × D-IB102" com a opção 3). Re-prova: tempestades de 12 e 20 rodadas (até 100
  faturamentos, 80 PUTs, revive e notas no meio) sem nenhum deadlock — o "LATEST DETECTED DEADLOCK" do InnoDB ficou o da 1ª rodada.
- **LOWs corrigidos**: app aceitava JSON sem `regularAllowed` (agora estrito — falha de LEITURA, nunca "não informado" inventado para um ME/EPP);
  a mensagem prometia ajustar para "pendente" pela tela (agora "ajuste-o para ME/EPP na aba Principal" — a tela só grava 1/2/3); a seção não
  relia a visão depois de uma recusa nem depois de salvar a aba Principal (agora relê — `refreshEpoch` — SEM apagar o rascunho); a recusa
  por regime virou a ÚLTIMA conferência (data já registrada, inexistente, vigente e já faturada vêm antes — a trava do regime segue a 1ª).
- Testes permanentes: `ADV-D102-01` e "D-IB101 × D-IB102" no `adversarial-ib99-live.test.ts` (**7/7** ao vivo); a ordem das travas e a ordem
  dos erros nos testes da peça; o recarregar sem perder rascunho no app. **Contagem final**: `tsc` limpo · setes-api **138/138 suítes, 2204
  testes** · app `flutter analyze` sem aviso, **651 verdes** · prova OK. Commits LOCAIS `ib99`: api **b364418** · app **70bedc3** (sql sem mudança).
  Regra permanente nova: `database/PADROES_BANCO.md` §9 **regra 14** (v2.3).
- **Assunção A-IB4 (sem decisão — confirmar com o Valdo quando oportuno)**: o opSimpNac **4 "pendente"** segue ACEITO se gravado por outra via
  (sincronizador/NT 009 — `emitterRegimeAt` lê 1–4), mas a tela do estabelecimento só grava 1/2/3 e a mensagem não promete o 4. Gravar o 4 pela
  tela é mudança de produto, fora desta frente.
  → ✅ **D-IB123** (Valdo 2026-11-11, "a" da pergunta reformulada — REGRA FISCAL DOS DOIS ERPs): os dois sistemas OFERECEM "4 – Optante
  pendente" (NT 009) no cadastro do estabelecimento (sistema agnóstico, D-IB122); a NFS-e manda `opSimpNac` 4 só quando o leiaute da NT 009
  vigorar no ambiente (calendário por pacote, D-IB110); antes disso a emissão RECUSA com mensagem clara (nunca troca por outro valor). No
  ERP Desktop depende do ACBr novo/fork (mesma fila da EM-3 Parte B) — levar à frente do ERP Desktop (ficha
  `Docs\ReformaTributaria\Emissao2027\ficha-nfse-p2-ibscbs-servico.md`) e ao catálogo fiscal único da Infra-IA.
- **Para a D-IB11 (quando o cálculo do regular nascer — sem ação agora)**: o faturamento hoje não lê o opSimpNac (recusa qualquer 2/3); quando
  2/3 forem suportados, decidir se o `issueInvoice` também confere o opSimpNac (a linha 3 deixada por quem saiu do Simples).

**Questões abertas (uma por vez)**: **Q-IB107** (quais notas formam a fronteira — §14.4; MEDIUM; Rec. (b) só as emitidas pelo ERP web) ·
**Q-IB106** (estabelecimento que emite também pelo ERP Desktop — §14.3) · ✅ **Q-IB108 → D-IB105 (§14.8)** — o PUT do estabelecimento que TIRA do Simples (3 → 1/2) com linha 2/3 futura deve AVISAR?
(socrático do delta; recusar está fora — a D-IB102 deixa a linha excluível). (a) **aviso não bloqueante no app ao salvar (o faturamento a
partir da data da linha será recusado até excluí-la ou registrar a 1)**; (b) sem aviso (a aba já mostra o aviso vermelho). *(Rec.: (a).)*

### 14.6 Rodada 4 da execução — D-IB103 (Valdo 2026-11-01)

Termos (memória `terminologia-erp-desktop-web`, pedido do Valdo no mesmo dia): **ERP web** = setes-app + setes-api (+ APIs fiscais) · **ERP
Desktop** = o Gestao2016, cujas notas chegam a `tb_invoice` pelo sincronizador/setes-sync.

| Decisão | O que fixa |
|---|---|
| **D-IB103** (Valdo 2026-11-01: "(b) Só do ERP web" — fecha a Q-IB107) | A fronteira da D-IB101 conta SÓ as notas VIVAS emitidas pelo **ERP web** — as que nasceram pelo escritor único `issueInvoice` e por isso LERAM a opção (critério: evento **E** vivo em `tb_invoice_event`). As notas do **ERP Desktop** (sincronizador, sem evento E) e as COMPRAS de terceiros não contam — nunca leram a opção do ERP web; uma data digitada errado nelas não trava mais a opção. O campo `issuer` não serve de critério (o sincronizador grava `issuer` = cliente) |

**Execução (mesma worktree/branch `ib99`)**: `@shared/invoice/emission-date` — `lastLiveEmissionDate` virou **`lastErpWebEmissionDate`**: a última
`dt_emission` de nota viva da institution com EXISTS de evento E vivo (mesma institution/id/terminal), por varredura DESCENDENTE no índice
`idx_invoice_live_emission` (076) que para na 1ª nota do ERP web — EXPLAIN provado (`key=idx_invoice_live_emission · Using where; Using
index`). A peça da opção só troca o nome; o critério mora no dono da data de emissão. Testes: unidade (o SQL tem o EXISTS do evento E e
os 3 parâmetros) · ao vivo `adversarial-ib99-live.test.ts` **8/8** (+ "D-IB103: nota do ERP DESKTOP com data 2062 e de hoje não trava a
opção; a do ERP web trava"; as notas das corridas passaram a gravar o evento E, como o `issueInvoice`) · prova OK (a nota da corrida com
evento E; EXPLAIN da consulta nova).

**Gates do delta da D-IB103 (2026-11-01)** — 1ª rodada socrático **0,66 ✗** · adversarial **0,68 ✗** → corrigido → **re-prova 0,78 ✅ · 0,80 ✅**
(sem HIGH/CRITICAL):
- **ADV-D103-01 (MEDIUM, provado)** — a 1ª forma (notas `WHERE EXISTS (evento E)`) virou semi-join MATERIALIZADO no MariaDB 10.4: copiava todos os
  eventos E e varria as notas do ERP Desktop mais novas — 1,3–1,6 s com o faturamento parado (300 mil notas). **Correção**: a fronteira é lida a
  partir do FATO — `tb_invoice_event e STRAIGHT_JOIN tb_invoice i`, varredura descendente no índice novo **`idx_invoice_event_issue`
  (`tb_institution_id`, `kind`, `deleted`, `dt_record`) na 076** — o `idx_invoice_live_emission` de `tb_invoice` (da D-IB101) SAIU, ficou sem
  consumidor; a 076 nunca foi aplicada em schema nenhum (o dev está na 075), a versão final é a deste commit — e **devolve `e.dt_record`** (a data
  que a nota do ERP web LEU; igual à `dt_emission` em todo caminho — `issueInvoice` e os backfills 042/046 —, conferido no dev). ANALYZE: **1+1
  linhas lidas, 0,6–0,8 ms** (só ERP web 300 mil; misto com 150 mil do ERP Desktop mais novas; revivida; grupo com outra institution grande).
- Fechados junto: **ADV-D103-02** (o sincronizador reescrevendo na MESMA PK o cabeçalho de uma nota do ERP web não move mais a fronteira — vale a
  data do evento); prova pelo PLANO (pelos eventos, sem MATERIALIZED) e teste vivo por ANALYZE (`src/__tests__/adversarial-d103-live.test.ts`,
  opt-in); textos (app e o 409 da API) dizem "nota emitida **por este sistema**"; o canônico `sql/03` aplica o índice DEPOIS do CREATE de
  `tb_invoice_event`. Conferido sem efeito colateral: o `MAX(event)+1 FOR UPDATE` e a view `vw_invoice_life` seguem pelo PRIMARY; revive × nota
  nova e C × E sem espera.
- **Limites conhecidos (assunção A-IB5 — confirmar com o Valdo quando oportuno)**: (1) cada nota PENDENTE CANCELADA (soft-deleted) mais nova que a
  última nota viva custa 1 leitura na varredura (10 mil = 61 ms; 100 mil = ~1 s; no dev: 0 — uma pendente cancelada costuma ser refaturada e
  REVIVE na mesma PK); (2) se o sincronizador gravar `deleted='S'` na PK de uma nota do ERP web (a colisão de ids da Q-SY12, grupo do sync), a nota
  sai da fronteira e ela RECUA — mesmo limite da Q-SY12, não investigado aqui (fronteira dos grupos).
  → ✅ **A-IB5 RATIFICADA** (Valdo 2026-11-11, "a"): o limite (1) fica como limite conhecido; o (2) deixou de existir pela D-SY28 do grupo do
  sync (o sincronizador nunca toca nota com evento na web) — a execução da D-SY28 deve ter teste que prove a fronteira estável.
- Provas: `tsc` limpo · setes-api **138/138 suítes, 2204 testes** (+ 2 suítes ao vivo opt-in: **11/11**) · prova OK · app `flutter analyze` sem
  aviso, **651 verdes**. Commits LOCAIS `ib99`: api **95181b9** · sql **b98274c** · app **6a69090**. Regra PADROES §9 regra 14 (d) reescrita
  ("a leitura que decide sob trava parte do FATO que a define, pelo índice dele").

### 14.7 Rodada 5 da execução — D-IB104 (Valdo 2026-11-01)

| Decisão | O que fixa |
|---|---|
| **D-IB104** (Valdo 2026-11-01: "(a) Avisar na aba" — fecha a Q-IB106) | Quando o estabelecimento tem SINCRONIZADOR (chave viva em `setes_central.tb_sync_api_key` — ativa ou pausada), a aba "Regime IBS/CBS" AVISA que a opção de apuração vale só para as notas emitidas por ESTE sistema (o ERP web): as notas do ERP Desktop chegam pela sincronização sem passar pela opção (o desktop tem a própria chave da reforma — D-IB3). Só aviso: nada é recusado por isso. O texto visível não cita o sistema antigo (regra da casa) |

**Execução (mesma worktree/branch `ib99`)**: a visão do sub-recurso ganhou **`desktopEmission`** (só a PRESENÇA da chave viva — `SELECT 1 … LIMIT 1`
pela institution do token; a chave nunca sai); Swagger; app: aviso informativo na aba — rascunho do texto (**a redação final é do Valdo**): *"Este
estabelecimento também envia notas de outro sistema pela sincronização: a opção registrada aqui vale só para as notas emitidas por este
sistema."* Testes: peça (presença/ausência, nunca lê a chave), app (aviso com e sem sincronizador; `desktopEmission` estrito no JSON).

**Gate do delta da D-IB104 (2026-11-01)** — socrático **0,82 ✅** · adversarial **0,84 ✅** (sem HIGH/CRITICAL). Conferido: institution do token,
`adminGuard`, a chave nunca sai (só `1`; JSON leva o booleano), `ref` por `fk_sak_to_institution` (1 linha), texto sem o sistema antigo; a Setes
(institution 1) tem chave no dev — a aba dela mostra o aviso. **Nota para a JANELA de merge (sem decisão nova — alinhamento com a D-PR47)**: a
branch `merchandise` (fora do `main`) traz o FATO `tb_institution.source_kind` (W/L/P — "origem dos cadastros é fato da institution") e o ato
"encerrar a transição" L→W deixa a chave do sincronizador INATIVA e viva em definitivo — com este predicado (presença da chave) o cliente que
virou W seria avisado para sempre. **Ao juntar as duas branches, `desktopEmission` passa a ler `source_kind IN ('L','P')`** (um fato, um
predicado) + o teste "D-IB104 × D-PR48: W depois de encerrar a transição não avisa"; com o grupo (D-TM10), a filial herda o fato da fundadora.
Publicação: a API sobe ANTES ou junto do app (o app lê `desktopEmission` estrito).

**Estado em 2026-11-01 (fim da sessão — "salva tudo" do Valdo)**: commits LOCAIS na branch `ib99` (sem push, sem merge): setes-api **3a7dbd3**
(topo: 2d6c393 → 921149f → b364418 → 95181b9 → 3a7dbd3) · sql **b98274c** (0d3df12 → 070ddc7 → b98274c) · setes-app **b9a3416**
(bef45ad → 8571d23 → 70bedc3 → 6a69090 → b9a3416). Suítes da D-IB104: `tsc` limpo · setes-api 138/138 (2205; + 2 suítes ao vivo opt-in 11/11) · app 652 verdes. ⚠️ O passo 4 do plano 10-21
(bloco de privilégios + costura A1) foi PUBLICADO por outra sessão em 2026-11-01 (INDICE 10.66) — a `ib99` saiu do `main` ANTES dele: o merge
pede juntar o `main` novo na `ib99` (conflito provável em `router.ts`/guarda por roteador — as 4 rotas novas caem na guarda V/I/A/E de
`establishment`, D-PV9) e rodar a suíte + os dois gates do merge. **Retomar por aqui**: Q-IB108 (uma questão), depois a janela de publicação
(renumerar 076/sql-71 se preciso; seed 71 antes do app; `errors:gen`; a 076 sobe no boot e o boot confere o CHECK; com a `merchandise`, o
`desktopEmission` passa a ler `source_kind`).

### 14.8 Rodada 6 da execução — D-IB105 (Valdo 2026-11-01, pela fila única do portfólio)

| Decisão | O que fixa |
|---|---|
| **D-IB105** (Valdo 2026-11-01: "Avisa sem bloquear" — fecha a Q-IB108) | Quando o admin salva o estabelecimento TIRANDO-O do Simples (opSimpNac 3 → 1/2) e já existe linha FUTURA de opção de apuração 2 ou 3 (`tb_establishment_ibscbs_assessment`), o app mostra um AVISO NÃO BLOQUEANTE ao salvar: o faturamento a partir da data dessa linha será recusado até excluí-la ou registrar a opção 1. O salvamento segue. Recusar o salvamento está fora (a D-IB102 deixa a linha excluível). Descartada: (b) sem aviso, contando só com o aviso vermelho da aba |

**Execução**: NÃO feita — o Valdo pediu decidir tudo antes de voltar ao código (fila única de 2026-11-01, `D:\Setes-Governanca\fila\`).
Entra na branch `ib99` ANTES da janela de publicação, junto com o merge do `main` novo. Rascunho para a sessão que executar (sem mudar o
contrato salvo de forma aditiva): a resposta do PUT do estabelecimento (ou a visão do sub-recurso) diz se há linha futura 2/3 a partir de
qual data; o app mostra o aviso depois de salvar. **Textos FINAIS (Valdo 2026-11-01, "Aprovar os dois")** — D-IB104: *"Este
estabelecimento também envia notas de outro sistema pela sincronização: a opção registrada aqui vale só para as notas emitidas por este
sistema."* (o rascunho do §14.7 vira o texto final) · D-IB105: *"Este estabelecimento tem uma opção de apuração do IBS/CBS a partir de
DD/MM/AAAA que só vale para o Simples Nacional. O faturamento a partir dessa data será recusado até essa opção ser excluída ou trocada."*
(DD/MM/AAAA = data da 1ª linha futura 2/3). **Retomar por aqui**: executar a
D-IB105 na `ib99` → merge do `main` → suíte + gates → janela.

### 14.9 Rodada 7 — D-IB122: pergunta ao contador vira opção de configuração (Valdo 2026-11-11)

| Decisão | O que fixa |
|---|---|
| **D-IB122** (Valdo 2026-11-11, literal: *"Perguntas para o contador nao devem ser consideradas como esperando respostas e sim utilizadas para criar opcoes de configuracoes, pois cada cliente usando o sistema tera um enquadramento diferente, estamos desenvolvendo o sistema agnostico em relacao a clientes, apesar de ter alguns como referencia"*) | Nenhum passo do ERP web espera resposta do contador. Cada pergunta "ao contador" vira OPÇÃO de configuração por cliente/estabelecimento (Framework de Configurações ou peça datada própria), com o enquadramento da Setes só como caso de referência. Aplica-se a: **P-IBS-1** (opção pelo regime regular — já é configuração datada, D-IB99/D-IB100); **P-IBS-2** (NBS e classificação de cada serviço — já é cadastro por serviço; a Setes preenche os dela); **P-IBS-3** (competência = dia do faturamento ou outra regra — vira opção); **P-IBS-4** (total da NFS-e maior que o título — vira opção de tratamento); **P-IBS-5** (opção pela raiz do CNPJ ou por estabelecimento; MEI) — vira opção/regra configurável. Os passos IBS.E7.P1, IBS.E9.P1 e IBS.E9.P2 deixam de ter "decisão a tomar" do contador: passam a "desenhar a opção" (guardião antes do DDL) |
