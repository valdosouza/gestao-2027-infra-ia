# fiscal-api/regras — matriz das regras: legado × web

**Escopo**: método (estado de implementação e prova de cada regra; sem dado de cliente)
**Criada em**: 07/11/2026. **Companheiro**: [`REGRAS.md`](REGRAS.md) (o enunciado de cada regra, com o mesmo ID).
**Base da conferência**: o estado do **legado** (ERP Desktop) vem da `RETOMADA.md` e dos planos da frente, até a r1393 do SVN; o da **web** vem do prompt da fase IBS/CBS (`../../prompts/prompt_fase_ibs_cbs.md`, até 01/11/2026) e do código lido em 07/11/2026. **`?` = não verificado.** Onde a web mudou depois de 01/11/2026, esta matriz está defasada: conferir antes de decidir.

**Estados:** **L** lida · **D** decidida · **I** implementada (commit ou publicada) · **T** testada (suíte ou tela) · **H** provada em homologação · **P** provada em produção · **—** não se aplica · **?** não verificado.

## 1. Divergências e ações (o que esta matriz já mostra)

| # | Achado | Regras | Ação proposta |
|---|---|---|---|
| 1 | **Cálculo: o legado tem motor próprio em Delphi; a web decidiu usar a Calculadora oficial e "motor próprio NUNCA" (D-IB11).** | CLS-05, BC-01 a BC-05 | Decisão do Valdo sobre a arquitetura. No mínimo, validar o motor do legado contra a Calculadora offline com os vetores comuns |
| 2 | **Classificação por serviço**: a web já decidiu (D-IB6: `cClassTrib` e `cIndOp` escolhidos pelo usuário, Anexo VIII só sugere; D-IB8: sem classificação depois da obrigação, recusa). O legado ainda não decidiu (NFSE.E4, P2). | CLS-01, CLS-03, CLS-04 | A P2 do legado adota o modelo da D-IB6; a web passa do Anexo VIII v1.01.00 para o v1.02.00, já no acervo |
| 3 | **E0855 já tem resposta empírica**: em H, a NFS-e de optante do Simples com competência 11/2026 e sem o grupo foi **autorizada** (nota 8015, 01/11/2026). O legado tinha isto como pergunta aberta ao fisco. | NFS-07, CAL-04 | O legado atualiza o `03`, o plano §11.15 e a RETOMADA; confirmar em produção quando a NT 009 chegar lá |
| 4 | A pendência da **D-IB12** da web ("conferir se no DAS `vTotNF = vLiq`") se fecha: Anexo VI, E1555, diz `vTotNF = vLiq` quando IBS e CBS são apurados no Simples; 2026 confirmado em H. | PRC-08 | A web fecha a pendência com a citação da regra |
| 5 | **A web não tem motor de IBS/CBS para a NF-e** (D-E17: pré-requisito de qualquer NF-e em produção). O legado é a única implementação de preço final, conta "por dentro", Simples e devolução. | PRC-01 a PRC-05, SN-13, DEV-01 a DEV-03 | Transformar essas regras em vetores de teste neutros; a web as implementa contra os mesmos vetores |
| 6 | **Duas constantes de data de obrigação**: `D-EM9` no legado (data de emissão) e `ibscbsObligationStart` na web (D-IB13, competência). | CAL-03, CAL-04 | **Calendário criado** (`../calendario/fatos.json`, 55 fatos): falta cada lado adotá-lo com um teste de contrato que leia o JSON |
| 7 | A **armadilha do leiaute** (dois pacotes `versao="1.01"` incompatíveis) a web conhece e tratou (calendário por data); no legado o ACBr tem `ProVersaoNT` e `HomVersaoNT` fixos. | NFS-02, NFS-03 | Na NFSE.E4, P3, escolher o leiaute por data e ambiente de forma explícita |
| 8 | **ME/EPP do Simples emite NFS-e pelo ambiente nacional desde 01/11/2026.** A web já emite pela Sefin Nacional (produção desde 29/09/2026); os 3 emissores do legado usam o Padrão Nacional; os 2 com provedor municipal não emitiram em 2026. | SN-12 | Sem ação para os 3; os 2 migram se voltarem a emitir |
| 9 | O **acervo de fontes** era duplicado (16 arquivos idênticos) e a web estava com versões antigas de NTs. | — | Feito em 07/11/2026: [`../fontes/INDEX.md`](../fontes/INDEX.md) |

## 2. Matriz por regra

### CAL — Calendário e obrigatoriedade

| ID | Legado (ERP Desktop) | Web | Divergência ou ação |
|---|---|---|---|
| RF-CAL-01 | D · I (alíquotas por data e regime, Decisão Nº 8, r1348 a r1353; `[AliquotasIBSCBS]`) · T (regressão de 2026 sem diferença) · 2027 não homologado | — (a Calculadora entrega; D-IB11) | Vetores devem cobrir 31/12/2026 contra 01/01/2027 |
| RF-CAL-02 | I (mecanismo `[AliquotasIBSCBS]` no `atualizacao.ini`; valor a publicar de 15 a 22/12) | ? (o catálogo vem da Calculadora, D-IB5) | Conferir o prazo do Senado |
| RF-CAL-03 | D · I (D-EM9: o grupo vai pela data de emissão; Decisões Nº 8 e 9) | D · I (D-IB2 e D-IB13: obrigação por competência; IB-2 publicada em 15/10) | Duas constantes de data: o calendário (FT-OBR-01 a FT-OBR-14) é a fonte; adoção pendente nos dois lados (divergência 6) |
| RF-CAL-04 | D (D-EM51) · NF-e I (Decisão Nº 9) · NFS-e não implementada | D · I · H (D-IB2, D-IB13; E0855 não recusou em H, D-IB114) | Alinhados |
| RF-CAL-05 | L | L (D-IB2) | Só documentação |
| RF-CAL-06 | L | ? | Só documentação |
| RF-CAL-07 | L (plano de emissão §11.9) | ? | Conferir se a nfe-api acompanha o 16/11 |
| RF-CAL-08 | I (Decisão Nº 10: NFC-e síncrona, inutilização extinta em AC, BA e SP) · tela e homologação pendentes (REF.E5.P3.T3) · 14/12: L | ? (NFC-e é onda do PDV) | — |

### BC — Base de cálculo

| ID | Legado | Web | Divergência ou ação |
|---|---|---|---|
| RF-BC-01 | I (motor em `Un_RegraIBSCBS2027`) · não homologado em 2027 | NF-e: sem motor (D-E17) · NFS-e: Calculadora (D-IB11) | Divergência 1 |
| RF-BC-02 | I (idem) | idem | idem |
| RF-BC-03 | I (UB16-10 no motor; hoje o `vBC` é calculado **antes** das alíquotas efetivas; **conferir se inclui `vICMSMono`**) · não homologado em 2027 | NF-e: sem motor | Divergência 5 |
| RF-BC-04 | D (tolerância de ±0,01 no desenho, D-EM49) · código ainda não | Calculadora; a voz confere em R$ 0,01 (D-IB12) | — |
| RF-BC-05 | — (não preenche a NFS-e; Decisão Nº 4) | I · H (montador da DPS, IB-3; nota 8014) | NFSE.E4 do legado |

### PRC — Preço e conta "por dentro"

| ID | Legado | Web | Divergência ou ação |
|---|---|---|---|
| RF-PRC-01 | D (D-EM49) | ? | — |
| RF-PRC-02 | D (D-EM44, D-EM45, D-EM49) · 8 vetores no doc 02 (8/8 em Python) · **código ainda não** (fila de código, item 1) | NF-e: sem motor (D-E17); o ICMS não está no escopo da Calculadora (leitura nossa) | Divergência 5: vetores para a web |
| RF-PRC-03 | D · simulação de 30.000 itens · código ainda não | ? | idem |
| RF-PRC-04 | D · hoje a ordem está invertida em `Pc_DefineIBSCBS` | ? | Corrigir no legado antes da conta |
| RF-PRC-05 | D (D-EM50: sem parâmetro, até algum cliente pedir) | ? | — |
| RF-PRC-06 | N (D-EM49 propõe um parâmetro global A/B no `atualizacao.ini`, não confirmado) | ? | **Uma só pergunta ao fisco, para os dois lados** (Portal NF-e e homologação de dezembro) |
| RF-PRC-07 | N | ? | idem |
| RF-PRC-08 | — (a NFS-e não leva o grupo) | I · H (2026: `vTotNF = vLiq`; D-IB12, o título nasce do total do ERP) · 2027 só T | Divergência 4 |

### SN — Simples Nacional

| ID | Legado | Web | Divergência ou ação |
|---|---|---|---|
| RF-SN-01 | D (D-EM47) · I (EM-3 Parte A, r1373) | D (D-IB1: IBS/CBS no DAS, `regApIBSCBSSN` 1) | — |
| RF-SN-02 | L | ? | — |
| RF-SN-03 | D (D-EM47: só a receita do item) · I (`Un_RegraSimplesIBSCBS.Fc_BaseSimplesIBSCBS`) · T (tela, 31/10 e 05/11) | ? | — |
| RF-SN-04 | N | ? | Pergunta ao fisco |
| RF-SN-05 | D (D-EM46: `pCredSN` manual por estabelecimento, `GRL_G_AQ_CRED_ICMS`; deve ser o do mês da operação) · I | `pTotTribSN` segue coluna (D-IB7) · ? | Alinhar o mês da operação |
| RF-SN-06 | L | ? | — |
| RF-SN-07 | D · I · T (Decisão Nº 9: `SN_REG` e `SN_REG_CBS`; D-EM23, D-EM33; r1371 a r1373; híbrido testado em tela em 31/10) | D (D-IB1; D-IB100 a D-IB105: opção própria e datada do estabelecimento) · I ? | Comparar os dois modelos |
| RF-SN-08 | I · T (D-EM20 NFS-e do MEI; CRT 4; Decisão Nº 6; tela em 04/11) | D (D-IB7: `opSimpNac` com o valor 2) · ? | — |
| RF-SN-09 | L (NFSE.E4, P3 e P4 pendentes) | D · I (D-IB7: enquadramento datado com `opSimpNac` 4 e `regApIBSCBSSN`); o XML espera o XSD (D-IB14) | Divergência 7 |
| RF-SN-10 | L | ? (D-IB14) | — |
| RF-SN-11 | L | ? | — |
| RF-SN-12 | L (RETOMADA de 07/11) | I · P (a nfse-api emite pela Sefin Nacional, produção desde 29/09/2026) | Divergência 8 |
| RF-SN-13 | D · I (cálculo e gravação, r1373) · **XML não** (Parte B espera o ACBr; portão `C_XML_SIMPLES_NT2026005` em `False`) · T (tela) | — (NF-e sem IBS/CBS) | Divergência 5 |

### DEV — Devolução

| ID | Legado | Web | Divergência ou ação |
|---|---|---|---|
| RF-DEV-01 | D (D-AP31) · I não (apuração: AP-2 em diante) | ? (a apuração não está na web) | Vetores |
| RF-DEV-02 | D · I · T (D-EM16, Decisão Nº 13; tela em 31/10; operação anterior a 2026 ou 2027 sai sem grupo, com aviso) | — | — |
| RF-DEV-03 | I (a NT 2025.002 v1.53 já é atendida) | — | — |
| RF-DEV-04 | N | N | Pergunta ao fisco |

### CLS — Classificação e Calculadora

| ID | Legado | Web | Divergência ou ação |
|---|---|---|---|
| RF-CLS-01 | NF-e: I · T (classificação por regra de tributação; G1 recusa nota sem classificação, Decisão Nº 9 item 5). NFS-e: sem classificação por serviço | D · I (D-IB5, D-IB6, D-IB8; IB-1 e IB-2 publicadas em 15/10); D-IB113 (recusa CST com `ind_gIBSCBS = 0`) executada em worktree em 01/11 | Divergência 2 |
| RF-CLS-02 | ? (o ACBr só escreve o grupo com `CST`, destinatário ou imóvel preenchidos; conferir o grupo vazio) | I · H (D-IB112; E0960 não disparou) | Levar à NFSE.E4, P4 |
| RF-CLS-03 | L (o exemplo fictício de `cIndOp` foi desligado em 10/10, Decisão Nº 4) | D · I (D-IB6: `tb_ibscbs_place_indicator`, Anexo VII) | Divergência 2 |
| RF-CLS-04 | L | D (D-IB6: o Anexo VIII só sugere; acervo na v1.01.00) | Divergência 2 |
| RF-CLS-05 | **Motor próprio** (sem a Calculadora) | D · H (D-IB11: Calculadora atrás de uma porta, "motor próprio NUNCA"; a integrada respondeu em H) | **Divergência 1** |

### NFS — NFS-e: leiaute e ambiente

| ID | Legado | Web | Divergência ou ação |
|---|---|---|---|
| RF-NFS-01 | L | L (D-IB21: acervo) | — |
| RF-NFS-02 | L | I (calendário: H desde 20/10 18h10 BRT no `xsd-20261020`; P segue no `xsd-20260209` até o fisco anunciar; D-IB110 e D-IB111) | Divergência 7 |
| RF-NFS-03 | L | I · E (calendário por deploy; E1235 em H) | idem |
| RF-NFS-04 | L | L (comentário do calendário; D-IB14: 1.01 agora, NT 009 quando o XSD existir) | Igual |
| RF-NFS-05 | L | ? | — |
| RF-NFS-06 | L | E (D-IB16: competência 2026 já aceita) | — |
| RF-NFS-07 | L (era pergunta aberta) | **E** (H, nota 8015, D-IB114) | **Divergência 3** |
| RF-NFS-08 | — (hoje não lê o retorno) | I · H (D-IB10: voz do fisco no `fiscal_api`, lida do XML autorizado) | NFSE.E4 |
| RF-NFS-09 | ? | I (DANFSe com o bloco, IB-3) | — |

### NFE — NF-e

| ID | Legado | Web | Divergência ou ação |
|---|---|---|---|
| RF-NFE-01 | I · T (EM-1 e EM-2; grupos pelo regime a partir de 2027) · H só em 2026 sem grupo (NF-e nº 2634, 07/11) | — (D-E17: pré-requisito de qualquer NF-e em produção) | Divergência 5 |
| RF-NFE-02 | I · T (CRT 4, r1345; Decisão Nº 6; tela em 04/11) | ? | — |
| RF-NFE-03 | ? (emitentes sem IE: lista do suporte; código não verificado) | D (D-IB20, NE-0) · ? | — |
| RF-NFE-04 | I · H (DANFE RTC, Decisão Nº 7; DANFE no leiaute novo na autorização de 07/11) | ? (PDF.E1: base só para a NF-e) | — |

## 3. Decisões de produto lado a lado

| Assunto | ERP Desktop (legado) | Web | Igual? |
|---|---|---|---|
| Preço do item | Só preço final (D-EM44, D-EM45) | NFS-e: valor do serviço, IBS/CBS por fora (leiaute); NF-e: sem decisão | A decidir na NF-e web |
| Cálculo do IBS/CBS | Motor próprio, alíquotas por data e regime (Decisão Nº 8) | Calculadora oficial atrás de uma porta (D-IB11), só nasce com consumidor | **Não** |
| Classificação por serviço | Sem cadastro por serviço; P2 por decidir | Peça 1:1 com `cClassTrib` e `cIndOp` escolhidos; recusa sem classificação depois da obrigação (D-IB6, D-IB8) | A alinhar |
| Obrigação por data | Data de emissão (D-EM9) | Constante da peça de classificação, por competência (D-IB13) | A unificar |
| Enquadramento do Simples | CRT mais `SN_REG` e `SN_REG_CBS` por estabelecimento (D-EM23) | Enquadramento datado (D-IB7) e opção de apuração própria e datada (D-IB100 a D-IB105) | Parecido |
| `pCredSN` | Manual por estabelecimento (D-EM46) | `pTotTribSN` em coluna (D-IB7) | ? |
| Base do Simples | Só a receita do item (D-EM47) | Quando houver XSD, `vReceitaBrutaSN` pela NT 009 (D-IB14) | A alinhar |
| PIS/COFINS na devolução | Sem opção; crédito do art. 379 na apuração (D-EM48, D-AP31) | ? | ? |
| Total da nota ou título | NF-e: `vNFTot` = total pago (D-EM44, D-EM45) | O título nasce do total do ERP; a voz confere em R$ 0,01 (D-IB12) | A conferir |
| Leiaute por data | DPS v1.00 fixa nos 3 emissores; migração na P3 | Calendário por documento × ambiente × instante (D-IB13, D-IB110, D-IB111) | Web à frente |
| Valores do fisco | Não lê | Voz no `fiscal_api`, gravação única (D-IB10) | Web à frente |
