# fiscal-api/regras — catálogo de regras fiscais (NF-e, NFS-e e Reforma Tributária)

**Escopo**: método (o que a norma e o fisco dizem; nada de cliente, credencial nem dado pessoal)
**Criado em**: 07/11/2026, por decisão do Valdo: o ERP Desktop (legado) e o sistema web reaproveitam o mesmo conhecimento fiscal; conhecer → planejar → organizar a execução → só então o código.
**Companheiros**: [`INDEX.md`](INDEX.md) (como usar), [`MATRIZ.md`](MATRIZ.md) (o estado de cada regra no legado e na web), [`../fontes/INDEX.md`](../fontes/INDEX.md) (as fontes oficiais), `../01-…`, `../02-…`, `../03-…` (a leitura por extenso).

## Como ler

- **ID estável** `RF-<ÁREA>-<NN>`: nunca muda e **nunca é reaproveitado**; regra que cai vira "(revogada em AAAA-MM-DD)", não é apagada.
- **Grau** da afirmação: **T** = está escrito na norma citada · **L** = leitura nossa, ainda sem confirmação do fisco · **E** = **empírico**, provado em homologação (H) ou produção (P) · **N** = não verificado ou não achado nas fontes.
- **Vetor** = o vetor de teste neutro que prova a regra (hoje só a conta "por dentro" tem; a coluna existe para as próximas peças).
- Áreas: **CAL** calendário e obrigatoriedade · **BC** base de cálculo · **PRC** preço e conta "por dentro" · **SN** Simples Nacional · **DEV** devolução · **CLS** classificação e Calculadora · **NFS** NFS-e (leiaute e ambiente) · **NFE** NF-e.
- A **decisão de produto** não mora aqui: cada sistema decide e aponta para a regra (D-EM e D-AP no legado, D-IB, D-F e D-NE na web). Ver a seção "Decisões de produto lado a lado" da matriz.

## CAL — Calendário e obrigatoriedade

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-CAL-01 | Transição 2026–2033: 2026 teste (IBS 0,1% e CBS 0,9%, compensados com PIS/COFINS); 2027 PIS/COFINS extintos e CBS cheia; 2029–2032 ICMS/ISS reduzidos em 10/20/30/40%; 2033 ICMS e ISS extintos | LC 214 arts. 343–349, 360–364, 367, 542, 543 | T | — |
| RF-CAL-02 | CBS de 2027 = alíquota de referência fixada pelo Senado − 0,1 p.p. (2027–2028); sem resolução do Senado valem as do TCU (11,3% → CBS 11,2%). O prazo do Senado (15/12/2026 no levantamento de 31/10) precisa de conferência | LC 214 arts. 347, 349 § 1º II | L | — |
| RF-CAL-03 | Obrigatoriedade de emitir com IBS/CBS: NF-e, NFC-e, CT-e, MDF-e e demais a partir de 03/08/2026; NFS-e em 01/10/2026 (serviços da alínea d) e 01/12/2026 (demais); NFCom em 01/10/2026 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º | T | `vetores/obrigatoriedade.json` |
| RF-CAL-04 | **Simples Nacional**: obrigatoriedade de todos os documentos, inclusive a NFS-e, a partir de 01/01/2027 | Ato Conjunto 4/2026, art. 1º, § 1º | T | `vetores/obrigatoriedade.json` |
| RF-CAL-05 | A carência de penalidade pela falta dos campos de IBS/CBS acabou em 01/08/2026 (1º dia do 4º mês após 29/04/2026); a apuração de 2026 é meramente informativa | Decreto 12.955 art. 619 I; Ato Conjunto 1/2025 art. 3º | L | — |
| RF-CAL-06 | Penalidades: 100% do tributo de referência (serviço ou prestação sem documento); 66% (documento não idôneo); 60 dias para suprir a omissão de 2026 depois do auto | LC 214 arts. 341-G (XI, XIII) e 348 § 3º | T | — |
| RF-CAL-07 | Produção das NTs de NF-e adiada para 16/11/2026 (2025.002 v1.52/v1.53, 2026.006, 2026.007, 2026.008 e os campos da 2026.005); DANFE RTC em 01/12/2026 | Comunicados do Portal NF-e de 05/10 e 27/10/2026; NT 2026.010 | T | — |
| RF-CAL-08 | NF-e de saída não referencia NFC-e/CF-e a partir de 14/12/2026; fim da inutilização em AC, BA e SP em 11/11/2026; fim da autorização assíncrona (rejeição 129) em 05/04/2027 | NT 2026.002 v1.11; NT 2023.002 v1.02 | T | — |

## BC — Base de cálculo

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-BC-01 | Base do IBS/CBS = valor da operação: o integral cobrado a qualquer título, incluindo juros, multas, descontos condicionais, transporte cobrado, seguros e taxas | LC 214 art. 12, caput e § 1º | T | — |
| RF-BC-02 | Fora da base: o próprio IBS/CBS ("por fora"), o IPI, os descontos incondicionais, reembolsos de terceiros e, de 01/01/2026 a 31/12/2032, ICMS, ISS, PIS e COFINS | LC 214 art. 12, § 2º | T | — |
| RF-BC-03 | NF-e: `vBC` = soma de `vProd`, `vServ`, `vFrete`, `vSeg`, `vOutro`, `vII`, menos `vDesc`, `vPIS`, `vCOFINS`, `vICMS`, `vICMSUFDest`, `vFCP`, `vFCPUFDest`, `vICMSMono`, `vISSQN`, mais `vIS`. Exceções 1 e 2: não subtrair o PIS/COFINS por substituição tributária quando compõem o total da NF-e (`indSomaPISST`, `indSomaCOFINSST` = 1); a NT marca isso como "implementação futura, aguardando orientação normativa" | NT 2025.002 v1.53, regra UB16-10 | T / N | `vetores/nfe-diversos.json` (sem as exceções) |
| RF-BC-04 | `vIBSUF = vBC × pIBSUF/100 − vDif − vDevTrib`, com tolerância de 0,01 a mais ou a menos | NT 2025.002 v1.53, regra UB35-10 | T | `vetores/conta-por-dentro.json` |
| RF-BC-05 | NFS-e: `vBC = vServ − descIncond − ajustes` (`vCalcAjusteBC…`) | Anexo VI v1.04.01, leiaute | T | — |

## PRC — Preço e conta "por dentro"

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-PRC-01 | O IBS/CBS ficam por fora da própria base; no regime normal o IBS/CBS integram a base do ICMS, calculado "por dentro" | LC 214 art. 12 § 2º I e V; SEFA-PR, Consulta 48/2026 (citada na pergunta 2854 do SAC) | T / L | — |
| RF-PRC-02 | Com o **preço final** como entrada: `ICMS = t × P`; `vBC = S ÷ (1 + a)`; `vIBS = vBC × aIBS`; `vCBS = vBC × aCBS`; `vProd = P − (vIBS + vCBS)`; `vItem = P`. Reproduz o exemplo da SEFA-PR centavo a centavo (P 123,64; ICMS 14,84; base 100,00; IBS 0,10; CBS 8,70; vProd 114,84) | `02-REFORMA-CONTA-POR-DENTRO-PRECO-FINAL.md` §2 e §3 | L | `vetores/conta-por-dentro.json` |
| RF-PRC-03 | Fechamento em centavos pela tolerância de ±0,01: `vItem = P` em 100% de 30.000 itens simulados (8,9% usam o ajuste de 1 centavo) | doc 02 §4; NT UB35-10 | L | `vetores/conta-por-dentro.json` |
| RF-PRC-04 | Ordem do cálculo: ICMS (ST, FCP, IPI) → alíquotas efetivas de IBS/CBS (reduções e vigência) → `vBC` → `vProd` e `vItem`. Casos de borda: ICMS zero, reduções, 31/12/2026 contra 01/01/2027, Imposto Seletivo | doc 02 §5 | L | `vetores/conta-por-dentro.json` |
| RF-PRC-05 | Decisão judicial que exclui o IBS/CBS da base do ICMS: `ICMS = t × P ÷ (1 + a − t × a)` | doc 02 §2 | L | — |
| RF-PRC-06 | A NT 2026.008 v1.01 se contradiz sobre o `vProd` de 2027: leitura A (sem IBS/CBS) × leitura B (com IBS/CBS). Pergunta ao fisco | NT 2026.008 v1.01 (introdução × campo I11 e regra VB01-10) | N | — |
| RF-PRC-07 | Qual total o `vPag` deve igualar quando `vNF` e `vNFTot` diferem | regra de NT mais antiga, fora das fontes | N | — |
| RF-PRC-08 | **NFS-e: IBS e CBS "por fora".** `vTotNF = vLiq` em 2026; a partir de 2027, `vLiq + vCBS + vIBSTot` (não optante, pendente e ME/EPP com `regApIBSCBSSN` = 3); `vLiq` quando IBS e CBS são apurados no Simples (`regApIBSCBSSN` = 1); `vLiq + vIBSTot` com `regApIBSCBSSN` = 2 | Anexo VI v1.04.01, regra E1555; **E: `vTotNF = vLiq` em 2026 confirmado em H (01/11/2026)** | T / E | `vetores/nfse-vtotnf.json` |

## SN — Simples Nacional

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-SN-01 | A base do DAS é a receita bruta mensal, excluídas as vendas canceladas e os descontos incondicionais | CGSN 140 arts. 2º II e 16; LC 123 art. 18 | T | — |
| RF-SN-02 | A NT 2026.005 não define a base de `pIBSSN`/`pCBSSN` (alíquota efetiva) e `vIBSSN`/`vCBSSN` (valor devido) | NT 2026.005 v1.00; CGSN 190 art. 59 § 9º | T | — |
| RF-SN-03 | Valor por item no Simples = alíquota efetiva × receita bruta da operação (`vProd + frete + seguro + outras − desconto`); nenhum texto sustenta descontar ICMS ou IPI | doc 01 §3 | L | — |
| RF-SN-04 | A lei exclui só o desconto **incondicional**; se o sistema subtrai todo o `vDesc`, é preciso saber se ele pode ser condicional | CGSN 140 art. 2º | N | — |
| RF-SN-05 | `pCredSN`: faixa do **mês anterior** hoje (CGSN 140 art. 60 § 1º); faixa do **mês da operação** a partir de 01/01/2027 (LC 123 art. 23 § 2º; CGSN 190 art. 58 § 1º-A); a LC prevalece | CGSN 140 e 190; LC 123 | L | — |
| RF-SN-06 | O comprador não optante tem crédito em montante equivalente ao cobrado no regime único | LC 123 art. 23 § 1º-A (LC 227/2026) | T | — |
| RF-SN-07 | O optante pode escolher o regime regular de IBS/CBS (o "híbrido"); a opção de 2026 teve prazo em 30/10/2026 | manual do CGSN da opção; CGSN 194 (citado na D-IB1 da web) | L | — |
| RF-SN-08 | MEI: NFS-e nacional obrigatória e dispensa de destacar IBS/CBS; o Anexo VI proíbe informar, além de `vLiq`, os campos de `valores` (E1302). Os artigos da CGSN 190 precisam de conferência | Anexo VI (E1302); CGSN 190 arts. 106-A e 106 § 1º V | T / N | — |
| RF-SN-09 | NFS-e do Simples: `opSimpNac` ganha o valor 4 (optante pendente); `regApIBSCBSSN` (1 IBS e CBS no Simples; 2 só CBS; 3 regime regular); `cAtvSN` (7 a 14 e 90), bicondicional com o anterior; `vReceitaBrutaSN`; grupo `gTribSN` | NT 009 v1.01 item 2.4; Anexo VI | T | — |
| RF-SN-10 | `vReceitaBrutaSN = vServ − descIncond − ajustes`; vale 0 se o `tpRBSN` do `cClassTrib` for 0 (indicadores 1 a 5 e 9 para os demais casos) | NT 009 item 2.4; IT 2025.002 v1.70 | T | `vetores/nfse-simples.json` |
| RF-SN-11 | `gTribSN` só aparece com `opSimpNac` 3 ou 4 e `regApIBSCBSSN` 1 ou 2; com 1, `vIBSSN = vReceitaBrutaSN × pIBSSN` e `pIBSSN` igual ao da Calculadora; com 2, `pIBSSN` e `vIBSSN` não vêm; totais de IBS e CBS não vêm quando apurados no Simples | Anexo VI v1.04.01 (regras de `gTribSN`, `vIBSTot`, `vCBS`) | T | `vetores/nfse-simples.json` (presença) |
| RF-SN-12 | A partir de 01/11/2026 o ME/EPP do Simples emite NFS-e pelo ambiente nacional: o município com emissor próprio só compartilha com o ADN até a competência 01/11/2026 | Anexo VI, regras E0163 e E0039 | L | — |
| RF-SN-13 | NF-e do Simples (CRT 1, 2 e 4): `tpRegimeIBSCBS` (C21a), `cAtivSN` (I17d), grupos `gTribSN`/`gIBSSN`/`gCBSSN` (UB115a a g) e os totais | NT 2026.005 v1.00 (produção em 16/11/2026) | T | — |

## DEV — Devolução

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-DEV-01 | Bens recebidos em devolução a partir de 01/01/2027, de venda anterior, dão crédito de **CBS** igual ao PIS/COFINS que incidiu; só compensa CBS (sem ressarcimento). O crédito nasce na apuração; a nota de devolução continua com PIS/COFINS zerados | LC 214 art. 379; Decreto 12.955 art. 603 | T / L | — |
| RF-DEV-02 | A NF-e de devolução (`finNFe` 4) ou complementar (2) que referencia NF-e de data anterior a 2027 não é obrigada a levar o grupo IBS/CBS | NT 2025.002 v1.53, regra UB12-10 | T | — |
| RF-DEV-03 | Chave referenciada no cabeçalho (`refNFe`, uma ocorrência) **ou** no item (`DFeReferenciado`), nunca nos dois (produção 03/11/2026) | NT 2025.002 v1.53, regra VC02-14 | T | `vetores/nfe-diversos.json` |
| RF-DEV-04 | Não existe campo da NF-e para o crédito do art. 379 (só `vCredPres` e `vCredPresCondSus`) nem orientação de como apropriá-lo na plataforma da CBS | manuais da RFB, API de apuração e resoluções do CGIBS | N | — |

## CLS — Classificação e Calculadora

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-CLS-01 | `CST` e `cClassTrib` são obrigatórios; o grupo `gIBSCBS` é opcional e depende do indicador `ind_gIBSCBS` da tabela oficial; `indNFSe` diz quais `cClassTrib` valem na NFS-e | IT 2025.002 v1.70; NT 009 | T | — |
| RF-CLS-02 | Validação por flags: `cClassTrib` válido para o documento (E0958); `CST` = prefixo do `cClassTrib` (E0959); com `ind_gIBSCBS = 1` o grupo vai. **O `<gIBSCBS/>` vazio é aceito** (E0960 não disparou) | Anexo VI; **E: nota 8014 em H, 01/11/2026** | T / E | `vetores/nfe-diversos.json` (CST); `vetores/obrigatoriedade.json` (OBS-002) |
| RF-CLS-03 | `cIndOp` identifica o tipo de operação (LC 214 art. 11): 41 códigos de 6 dígitos, com as colunas `indNFe`, `indNFSe` e `indNFSe Via` | Anexo VII v1.03.00 | T | — |
| RF-CLS-04 | O Anexo VIII correlaciona item da LC 116 × NBS × `cAtvSN` × `INDOP` × `cClassTrib` (1.661 linhas, 209 itens, 731 NBS). Só 71 itens têm combinação única; "IMP" = atividade impeditiva no Simples | Anexo VIII v1.02.00 (26/10/2026) | T | — |
| RF-CLS-05 | A **Calculadora de Tributos** oficial é o motor de cálculo (online; offline de código aberto); a NFS-e integra online e grava `verCalcIBSCBS`. **E: a Calculadora integrada respondeu em H** | NT 009 §2.9; prova em H 01/11/2026 | T / E | — |

## NFS — NFS-e: leiaute e ambiente

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-NFS-01 | O ATC 7/2026 aprova a NT 009 **v1.01** (Anexo VI v1.04, Anexo VII v1.02); o portal já oferece o VI v1.04.01 e o VII v1.03.00, sem ato localizado que os aprove | ATC 7/2026 art. 1º, I | T / N | — |
| RF-NFS-02 | Ambientes: a produção ainda roda o leiaute da NT 004 (e, no calendário da web, o pacote XSD de 09/02/2026); a produção restrita adotou a NT 009 em 20/10/2026 (18h10 de Brasília); a data da NT 009 em produção não foi publicada | portal da NFS-e (21/10/2026); NT 009 | T / N | `vetores/leiaute-nfse.json` |
| RF-NFS-03 | Os dois pacotes XSD vigentes dizem `versao="1.01"` e são **incompatíveis** (E1235): nunca escolher o leiaute pela versão nem pelo ambiente; a troca é por data, em calendário, por deploy | calendário da nfse-api (D-IB110, D-IB111); **E: nota 8014 em H com o pacote antigo** | E | `vetores/leiaute-nfse.json` |
| RF-NFS-04 | Os XSD publicados (09/02 e 20/10/2026) **não trazem** `regApIBSCBSSN`, `cAtvSN`, `vReceitaBrutaSN`, `gTribSN`, `verCalcIBSCBS` nem `opSimpNac` = 4; a produção restrita traz `vAjusteBC`, o pacote de fevereiro traz `vDedRed` e `gReeRepRes` | leitura dos dois pacotes (hash em `../fontes/INDEX.md`) | T | — |
| RF-NFS-05 | `vDedRed` e `gReeRepRes` viram o grupo `vAjusteBC`; há notas de ajuste de débito e de crédito; o CNPJ passa a ser alfanumérico | NT 009 v1.01 | T | — |
| RF-NFS-06 | Declarar IBS/CBS só é permitido a partir da competência 01/01/2026 (E0850) | Anexo VI | T | — |
| RF-NFS-07 | **E0855** ("obrigatório declarar IBS/CBS desde a competência 01/10/2026") **não recusou a NFS-e do Simples com competência 11/2026 e sem o grupo** em H; vale a nota do leiaute (Simples só em 2027). Para o regime regular a E0855 diz 01/10/2026 quando a produção adotar o pacote | Anexo VI; **E: nota 8015 em H, 01/11/2026** | T / E | `vetores/obrigatoriedade.json` (OBS-001) |
| RF-NFS-08 | A NFS-e autorizada devolve o grupo de IBS/CBS calculado pelo fisco (`vTotNF`, `vIBSTot`, `vCBS`) | **E: nota 8014 em H, 01/11/2026** | E | — |
| RF-NFS-09 | DANFSe com o bloco de IBS/CBS (NT 008 v1.02); consulta pública com os grupos desde 03/08/2026 | NT 008 v1.02; portal da NFS-e | T | — |

## NFE — NF-e

| ID | Regra | Fonte e vigência | Grau | Vetor |
|---|---|---|---|---|
| RF-NFE-01 | Leiaute RTC: grupos IBS/CBS, `finNFe` 5 e 6, `tpNFDebito`/`tpNFCredito`, eventos 112xxx/211xxx/212xxx | NT 2025.002 v1.53 | T | — |
| RF-NFE-02 | CRT 4 (MEI) e as regras de CFOP/CSOSN do MEI | NT 2024.001 v1.20 | T | — |
| RF-NFE-03 | NF-e por contribuinte exclusivo de IBS/CBS (sem IE) | NT 2026.007 v1.11 | T | — |
| RF-NFE-04 | DANFE com IBS/CBS/IS: bloco de totais, CRT no emitente, campos UB nos itens (produção em 01/12/2026) | NT 2026.010 v1.00 | T | — |
