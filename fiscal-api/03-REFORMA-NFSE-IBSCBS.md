# Reforma Tributária — NFS-e com IBS/CBS: o que os atos oficiais exigem, o que o ACBr suporta e o que ainda falta

**Escopo**: método (datas e artigos oficiais, suporte de uma biblioteca de código aberto e números agregados; nada de cliente, credencial nem código de produto — este repositório é PÚBLICO)
**Origem**: levantamento feito em 07/11/2026 na frente do ERP Desktop (Gestão 2026), a pedido do Valdo, para uso do setes-app, do setes-api e da `nfse-api`
**Pré-requisitos**: `01-REFORMA-BASE-DE-CALCULO-E-TRANSICAO.md` e `02-REFORMA-CONTA-POR-DENTRO-PRECO-FINAL.md`
**Status**: **COMPLETO para a parte documental e para a leitura das notas técnicas** (NT SE/CGNFS-e 008 v1.02, 009 v1.01 e ATC 7/2026 baixadas e lidas em 07/11/2026, ver o item 3). **Também lidos em 07/11/2026**: os Anexos VI, VII e VIII (planilhas) e os dois pacotes XSD (item 3.5)
**Fontes baixadas**: gov.br/nfse (biblioteca de documentação técnica) e cgibs.gov.br; as cópias ficam no repositório do ERP Desktop, não neste
**Convenção**: **[texto]** = está escrito na norma citada · **[leitura nossa]** = interpretação · **[não achei]** = procurado nas fontes locais e não encontrado · **[relatório]** = do levantamento de código, conferido só em parte

## 1. Obrigatoriedade dos documentos eletrônicos com IBS/CBS

**[texto] Ato Conjunto RFB/CGIBS nº 4, de 30/07/2026, art. 1º**: a obrigatoriedade de emitir os documentos fiscais eletrônicos com as informações do IBS e da CBS (art. 112 dos regulamentos) começa para os fatos geradores a partir de:

| Documento | Data |
|---|---|
| NF-e (modelo 55) e NFC-e (modelo 65) | 03/08/2026 |
| CT-e (57), CT-e OS (67), MDF-e (58), GTV-e (64), NF3e (66) | 03/08/2026 |
| **NFS-e — serviços da lista da LC 116 não incluídos nas alíneas a, b e c (alínea d)** | **01/10/2026** |
| NFS-e — plataformas digitais (art. 22, § 1º, LC 214); subitens 1.03, 1.05 e 1.09; subitem 16.01; bens imateriais; taxas condominiais; locações e cessões; demais serviços | **01/12/2026** |
| NFCom (62) | 01/10/2026 |
| NFGas (76), NFAg (75), NF-e ABI (77), BP-e semiurbano/metropolitano e aéreo | 01/12/2026 |

- **[texto] Simples Nacional (art. 1º, § 1º):** para os optantes, a obrigatoriedade de emissão de **todos** os documentos dos incisos do caput, **inclusive a NFS-e**, começa em **01/01/2027** (e não nas datas da tabela acima). Fornecimentos monofásicos na NF-e: 01/01/2027 (§ 2º). NF-e do sujeito passivo de IBS/CBS que **não é contribuinte do ICMS**: 01/12/2026 (§ 4º).
- **[leitura nossa]** Na NFS-e, o regime normal está sujeito às datas de 01/10/2026 e 01/12/2026, e o optante do Simples, a 01/01/2027.
- **[texto]** MEI: a NFS-e nacional é obrigatória (CGSN 190, art. 106-A), e o MEI fica dispensado de destacar IBS e CBS (art. 106, § 1º, V). **[relatório]**, conferir o caput.
- **Ressalva [relatório]:** o Ato 4 não escreve literalmente "com campos IBS/CBS"; a leitura vem do art. 112 do Decreto 12.955 e do art. 60 da LC 214, combinados com o Ato 1/2025, art. 3º, I (que fala em "falta de registro dos campos do IBS e da CBS nos documentos fiscais").
- **[texto]** LC 214, art. 62 (NFS-e de padrão nacional e CGNFS-e): os sistemas devem usar "leiaute padronizado" que permita informar IBS/CBS (caput, I); desde 01/01/2026 os Municípios autorizam a NFS-e nacional ou, se têm emissor próprio, compartilham os documentos no leiaute padronizado (§ 1º); vale até 31/12/2032 (§ 2º); o leiaute é definido em convênio e gerido pelo CGNFS-e (§ 4º); a sanção do § 7º é contra os entes (suspensão de transferências voluntárias), não contra o contribuinte.

## 2. Penalidades e carência

- **[texto]** Decreto 12.955, **art. 619, I**: a exigência de emissão do art. 112 produz efeitos a partir do **primeiro dia do quarto mês subsequente** ao da publicação (29/04/2026). **[leitura nossa]** Isso dá **01/08/2026** para a CBS.
- **[texto]** Ato Conjunto nº 1/2025, art. 3º: até o primeiro dia do quarto mês subsequente à publicação da parte comum dos regulamentos, não há penalidade pela falta de registro dos campos de IBS/CBS; o parágrafo único diz que a apuração de 2026 é **meramente informativa**, desde que cumpridas as obrigações acessórias. **[leitura nossa]** A carência **já acabou**. A data de publicação da parte comum do regulamento do **IBS** (Resolução CGIBS 6/2026) não foi conferida.
- **[texto]** LC 214, art. 341-G: **100%** do valor do tributo de referência para prestar ou tomar serviço desacobertado de documento fiscal ou de declaração (inciso XI); **66%** para emitir ou utilizar documento fiscal não idôneo (inciso XIII); multa em UPF por entregar, registrar ou manter em desacordo arquivos decorrentes da emissão de documentos fiscais (inciso IV; valor não conferido).
- **[texto]** LC 214, art. 348, §§ 3º e 4º: lavrado auto de infração por descumprir o art. 341-G durante 2026, o sujeito passivo tem **60 dias** da intimação para suprir a omissão (LC 227/2026).
- **[texto]** Ato Conjunto nº 5/2026 (programa de conformidade): fica no programa, por padrão, quem cumpre as obrigações acessórias; quem não cumpre precisa de aumento contínuo de notas com os campos corretos, de atender intimações, de retificar inconsistências até 31/12/2026 e de contador responsável. **[relatório]** O ato não menciona a NFS-e em particular.
- **[não achei]** Regra local de **rejeição** da NFS-e sem o grupo de IBS/CBS. O grupo é opcional no XSD da DPS v1.01 (`minOccurs="0"` em `infDPS/IBSCBS`), mas isso é só schema, não a regra de negócio do ambiente nacional. Se omitir o grupo equivale a "documento não idôneo" ou a "registro em desacordo" é interpretação jurídica que as fontes locais não resolvem.

## 3. Documentação técnica da NFS-e nacional (lida em 07/11/2026)

### 3.1 Quais documentos valem

- **[texto]** Ato Técnico Conjunto nº 1/2026, art. 3º (31/07/2026): ratificou a NT SE/CGNFS-e nº 009 **v1.0** e a nº 008 v1.02.
- **[texto] ATC RFB/SUFIS/CGIBS nº 7, de 28/09/2026, art. 1º, I** (vigência na publicação, art. 2º): aprova a **NT SE/CGNFS-e nº 009 versão 1.01**, composta pelo **Anexo VI** (leiautes e regras de negócio da NFS-e com IBS/CBS, **v1.04**) e pelo **Anexo VII** (tabela de indicadores da operação, `cIndOp`, **v1.02**); aprova também a NT 010 v1.00 e o manual da NFS-e Via (exploração de via), que não tratamos aqui. Ou seja, **a v1.01 é a vigente e é a que o ACBr implementa** (a diferença v1.0 × v1.01 que o item 5 apontava deixa de ser problema).
- **[texto]** NT 008 v1.02 (14/07/2026): especificação do DANFSe (a nota impressa); não altera o que o emissor envia.
- **[texto: página da biblioteca, 07/11/2026]** A NT 009 v1.01 está datada de 11/09/2026 e listada como publicada em 01/10/2026. A página oferece os anexos **VI v1.04.01** e **VII v1.03.00**, **mais novos** que os aprovados pelo ATC 7 (VI v1.04 e VII v1.02), e o **Anexo VIII v1.02.00 (26/10/2026)**. **[não achei]** ato que aprove essas revisões; qual versão do anexo vale para a validação fica como pergunta ao fisco.

### 3.2 Em que ambiente cada leiaute está no ar [texto: página "Atualizações e Implantações" do portal, atualizada em 21/10/2026]

| Data | Produção | Produção restrita |
|---|---|---|
| 03/08/2026 | Consulta pública e DANFSe com os grupos IBS/CBS (NT 008) | — |
| 10/08/2026 | Emissor Nacional Web com destaque de IBS/CBS pela **NT 004**; CNPJ alfanumérico | — |
| 20/10/2026 | **nada** (célula vazia) | **leiaute da NT 009**: `CST`/`cClassTrib` reposicionados no XML, novos fatos geradores 99.02 a 99.04, grupo `vAjusteBC` (junção de `vDedRed` com `gReeRepRes`) |

- **[leitura nossa]** Hoje a **produção** ainda roda o leiaute da NT 004 e a **produção restrita** já roda o da NT 009. **[não achei]** a data em que a NT 009 chega à produção: a própria NT 009 diz que o cronograma de implantação "será publicado no portal". Quem for homologar precisa usar a produção restrita; quem emitir em produção hoje usa o leiaute anterior.
- **[texto]** Em produção, o novo leiaute passará a se chamar `ANEXO_I-SEFIN_ADN-DPS_NFSe-SNNFSe` (com versão).

### 3.3 O que a NT 009 v1.01 muda e importa para o Simples Nacional [texto, item 2.4]

- `opSimpNac` (situação do prestador no Simples) ganha o valor **4 — Optante Pendente** (além de 1 não optante, 2 MEI, 3 ME/EPP).
- **`regApIBSCBSSN`** (novo, na DPS, `prest/regTrib`, opcional): **1** = IBS e CBS apurados pelo Simples; **2** = CBS pelo Simples e IBS pelo regime regular; **3** = IBS e CBS pelo regime regular.
- **`cAtvSN`** (novo, na DPS, `serv/cServ`, opcional): código da atividade no Simples (7 a 14 e 90, conforme a LC 123: Anexos III, IV, Fator R, construção civil etc.). A regra é **bicondicional**: `regApIBSCBSSN` e `cAtvSN` só valem se os dois vierem.
- **`vReceitaBrutaSN`** (novo, na NFS-e, `IBSCBS/valores`): é a base do Simples. `vReceitaBrutaSN = vServ − descIncond − vCalcAjusteBCIBSCBS − vCalcAjusteBCISSQN` (este último só quando o ajuste for do tipo "9 — profissional parceiro"). Casa com o item 3 do documento 01 (base do Simples = receita bruta). Quem decide se o valor entra é o indicador **`tpRBSN`** do `cClassTrib`: 0 não é receita bruta (então `vReceitaBrutaSN = 0`), 1 interna, 2 interna sem cálculo de IBS/CBS, 3 exportação direta, 4 exportação indireta, 5 interna e exportação 50/50, 9 fornecimento incompatível com o Simples.
- Novo grupo **`gTribSN`** (em `totCIBS`): `pIBSSN`, `vIBSSN`, `pCBSSN`, `vCBSSN` para quem apura IBS/CBS pelo Simples. Por causa dele, `vIBSTot`, `gIBSUFTot`, `gIBSMunTot`, `pCredPresCBS`, `vCredPresCBS` e `vCBS` deixaram de ser obrigatórios.
- `indFinal` volta a existir (uso ou consumo pessoal, art. 57 da LC 214).
- **Deduções/reembolsos**: `vDedRed` e `gReeRepRes` viram um grupo só, **`vAjusteBC`**; há também notas de **ajuste de débito e crédito** (grupo `gIBSCBSAjuste`). O ACBr ainda não implementa `vAjusteBC` (item 5).
- **Campo `verCalcIBSCBS`**: versão da Calculadora de Tributos que gerou a nota.

### 3.4 Classificação e Calculadora [texto]

- **`CST` e `cClassTrib` são obrigatórios; o grupo `gIBSCBS` é opcional** e depende do indicador `ind_gIBSCBS` da tabela oficial de CST e classificação tributária (IT 2025.002 v1.60 citada pela NT 009; o documento 02 já usava a v1.70). O indicador `indNFSe` diz quais `cClassTrib` valem na NFS-e.
- A NFS-e tem **integração online com a Calculadora de Tributos** (motor de cálculo oficial, que valida campos e regras e devolve valores) e há **versão offline de código aberto**, ambas em `consumo.tributos.gov.br`. **[leitura nossa]** Um emissor próprio pode usar a offline em vez de reimplementar as regras.
- **Anexo VIII** (correlação item da LC 116 × NBS × atividade do Simples × `cIndOp` × `cClassTrib`, v1.02.00 de 26/10/2026): **lido em 07/11/2026**, ver o item 3.5.
- **[texto] Regra de rejeição E0855 (Anexo VI v1.04.01, aba "RN DPS_NFS-e"): "É obrigatório declarar informações de IBS/CBS quando a data de competência for igual ou posterior a 01/10/2026"**; a E0850 só permite declarar a partir de 01/01/2026. As duas rodam no ADN e nos emissores nacionais. Ver a contradição com o Simples no item 3.5.

### 3.5 O que o Anexo VI, o Anexo VII, o Anexo VIII e os XSD dizem (lidos em 07/11/2026)

- **Obrigatoriedade: o próprio Anexo VI se contradiz para o Simples.** O leiaute (grupo `IBSCBS` da NFS-e e da DPS) diz **[texto]** "para optantes do Simples Nacional, os grupos IBSCBS só serão obrigatórios a partir de 2027". A regra **E0855** diz, sem exceção escrita, que é obrigatório a partir da competência 01/10/2026. **[leitura nossa]** Não dá para saber, só pelo anexo, se o ambiente nacional rejeita hoje a DPS de um optante sem o grupo; só o teste em produção restrita ou a resposta do fisco resolve. A regra E1302 proíbe, para o MEI (`opSimpNac` = 2), informar os campos de `valores` além de `vLiq`.
- **Quem emite pelo ambiente nacional a partir de 01/11/2026.** **[texto]** E0163 (roda no ADN): uma NFS-e de ME/EPP (`opSimpNac` = 3) só pode ser **compartilhada pelo município** com o ADN se a competência for **menor ou igual a 01/11/2026**. E0039 (roda nos emissores nacionais): o município precisa estar parametrizado para o emissor nacional, **exceto** MEI ou ME/EPP com ISSQN pelo Simples (`regApTribSN` = 1) com competência **a partir de 01/11/2026**. O portal confirma, em 28/09/2026, uma função no painel municipal "para antecipar a adoção do Emissor Nacional para optantes pelo Simples". **[leitura nossa]** A partir de 01/11/2026 o ME/EPP do Simples deve emitir a NFS-e pelo ambiente nacional, em qualquer município. Quem hoje emite por provedor municipal precisa migrar. Os 2 clientes da base local com provedor municipal configurado (item 4) são **optantes do Simples (CRT 1)**, mas não emitiram NFS-e em 2026; se um deles voltar a emitir, terá de usar o ambiente nacional.
- **IBS e CBS "por fora" na NFS-e.** **[texto]** `vTotNF` (E1555): para não optante, optante pendente e ME/EPP com `regApIBSCBSSN` = 3: `vLiq` em 2026 e `vLiq + vCBS + vIBSTot` a partir de 2027; com `regApIBSCBSSN` = 1 (tudo no Simples): `vLiq` nos dois anos; com = 2: `vLiq + vIBSTot` em 2027. A base é `vBC = vServ − descIncond − ajustes`. **[leitura nossa]** Ao contrário do preço final da NF-e (documento 02), no leiaute da NFS-e o `vServ` é o valor antes do IBS/CBS. Como o Gestão deve tratar isso é decisão do produto (a D-EM44 foi tomada para a NF-e).
- **Campos do Simples e valores.** **[texto]** `regApIBSCBSSN` é obrigatório quando `opSimpNac` = 3 ou 4. `vReceitaBrutaSN` é proibido se `opSimpNac` = 1 e obrigatório se = 2, 3 ou 4. O grupo `gTribSN` só aparece quando `opSimpNac` = 3 ou 4 com `regApIBSCBSSN` = 1 ou 2; com = 1, `vIBSSN = vReceitaBrutaSN × pIBSSN` e `pIBSSN` tem de bater com a alíquota da Calculadora (para `pCBSSN` o anexo não escreve regra própria); com = 2, `pIBSSN` e `vIBSSN` não podem vir. O total de IBS e o de CBS não podem vir quando apurados no Simples.
- **Anexo VII (`cIndOp`):** 41 códigos de 6 dígitos (tipo de operação, local do fornecimento, dispositivo da LC 214), com as colunas `indNFe`, `indNFSe` e `indNFSe Via` dizendo em qual documento o código vale.
- **Anexo VIII resolve a classificação por serviço.** Tem 1.661 linhas, 209 itens da LC 116 e 731 NBS, e correlaciona cada item/NBS com: `COD_ATIV_SN` (o `cAtvSN`: 7, 8, 9, 10, 11, 12, 13, 14, ou "IMP" = atividade impeditiva no Simples, 151 linhas), `INDOP` (24 códigos), local de incidência do IBS, `cClassTrib` (849 linhas com 000001, tributação integral) e o nome. **Não é 1 para 1:** só 71 dos 209 itens têm uma combinação única de (`cAtvSN`, `INDOP`, `cClassTrib`); 81 têm duas, 42 têm três e 15 têm de quatro a seis. **[leitura nossa]** Dá para pré-preencher a partir do item e da NBS que o cadastro já tem, mas em muitos itens o sistema precisa de uma escolha do usuário, e itens "IMP" devem barrar a NFS-e do optante.
- **XSD.** O pacote da produção restrita de 20/10/2026 e o de fevereiro/2026 têm `DPS_v1.01`, `NFSe_v1.01` e vários arquivos idênticos; a produção restrita traz `vAjusteBC` e o de fevereiro traz `vDedRed` e `gReeRepRes`. **Nenhum dos dois traz** `regApIBSCBSSN`, `cAtvSN`, `vReceitaBrutaSN`, `gTribSN`, `verCalcIBSCBS` nem `opSimpNac` = 4. **[leitura nossa]** O leiaute do Simples da NT 009 existe no Anexo VI, mas ainda não em XSD publicado, então não dá para validar localmente nem o ACBr gerar com segurança esses campos até o esquema sair.

## 4. Quem emite NFS-e hoje no ERP Desktop (levantado em 07/11/2026; só números agregados, sem nomes)

Consulta de leitura em 39 das 40 cópias locais de bancos de clientes (uma está corrompida; as cópias são fotos de 05–06/11/2026):

| Achado | Resultado |
|---|---|
| Clientes com NFS-e registrada em 2026 | **3** de 39 (de 14 a 526 notas no ano; a mais recente em 22/09/2026) |
| Provedor dessas 3 | **Padrão Nacional** (ADN), ambiente de **produção** |
| Regime dessas 3 | as 3 são **optantes do Simples (CRT 1)** |
| Versão da DPS configurada nas 3 | **v1.00** (configuração "layout 1 / ve100") |
| Clientes com NFS-e configurada por provedor municipal, sem nota em 2026 | 2 (um provedor de IPM e um de ISS de capital) |
| Clientes de regime normal (CRT 3) com NFS-e em 2026 | **0** |

- **[leitura nossa]** Como todos os emissores de NFS-e do ERP Desktop são optantes do Simples, a obrigatoriedade deles começa em **01/01/2027** (Ato 4/2026, art. 1º, § 1º). A exposição imediata é pequena; a de 01/01/2027 vale para os 3.
- **Limite:** a amostra são cópias locais de 39 bases, não a produção; um cliente sem cópia local não aparece.

## 5. O que o ACBr (trunk2 r48887, 28/10/2026) suporta de IBS/CBS na NFS-e [relatório; `ProVersaoNT` e `HomVersaoNT` do `.ini` conferidos]

- **Classes:** `NFSe.IBSCBS` (`finNFSe`, `indFinal`, `cIndOp`, `tpOper`, `gRefNFSe`, `tpEnteGov`, `indDest`, `dest`, `imovel`, `valores`); `valores.trib.gIBSCBS` (`CST`, `cClassTrib`, `cCredPres`, `gTribRegular`, `gDif`); `valores.gReeRepRes.documentos` (reembolsos); `infNFSe.IBSCBS` (retorno do ambiente nacional, lido do XML).
- **Padrão Nacional:** suporte nos dois modos do `ACBrNFSeXServicos.ini`, seção `[PadraoNacional]` (`Versao=1.01`):
  - `ProVersaoNT=0` (**produção, padrão**): gerador "antigo"; o XSD de produção exige `cIndOp` (6 posições) e `indDest`.
  - `HomVersaoNT=009.1.01` (**homologação, padrão**): NT 009 v1.01; exige DPS v1.01; `finNFSe` só regular; deduções e reembolsos geram exceção porque `vAjusteBC` não está implementado; `cIndOp` vira opcional.
  - **Versão:** o ATC 1/2026 ratificou a NT 009 v1.0 e o ATC 7/2026 aprovou a **v1.01**, que é a que o ACBr implementa (change log da biblioteca: "NT 009 versão 1.01 ... na homologação da API do SERPRO"). Está alinhado (item 3.1).
  - **Lacunas do ACBr frente à NT 009 [leitura nossa, a conferir no código]:** `vAjusteBC`/notas de ajuste, e os campos do Simples (`regApIBSCBSSN`, `cAtvSN`, `vReceitaBrutaSN`, `gTribSN`, `opSimpNac` = 4) não aparecem na lista de campos que o relatório de código citou; conferir antes de contar com eles.
- **Provedores:** IPM tem geração própria do grupo, só no layout 2.04 ABRASF v2; ISSNet só gera pela variante de API própria (derivada do Padrão Nacional); os layouts ABRASF do ISSNet não geram IBS/CBS.
- **O que o chamador precisa preencher** (Padrão Nacional): `finNFSe` (só regular na NT 009), `indFinal`, `cIndOp` (obrigatório se `ProVersaoNT=0`), `tpOper`, `tpEnteGov`, `indDest` com `dest` coerente, `valores.trib.gIBSCBS.CST` e `cClassTrib`; opcionalmente `cCredPres`, `gTribRegular`, `gDif`, `imovel` e `gRefNFSe`. O gerador só escreve o grupo se `dest.xNome`, `imovel` ou `CST` estiverem preenchidos.

## 6. O que o ERP Desktop faz hoje [relatório]

- **Não preenche nenhum campo de IBS/CBS na NFS-e.** Em 10/10/2026 o grupo de exemplo (com dados fictícios, como `cIndOp` 123456) foi desligado por decisão de produto; a rotina de exemplo está fora da compilação.
- No cadastro só há um item da lista LC 116 e um código NBS por estabelecimento; **não há CST, `cClassTrib` nem `cIndOp` por serviço**.
- **Indício de problema a verificar:** a tela grava o índice do layout direto no enum do ACBr; o índice 1, rotulado "Provedor", força o **Padrão Nacional v1.00**. Os 3 emissores estão em "layout 1 / ve100" (item 4). Para o grupo de IBS/CBS (que só existe na DPS v1.01) seria preciso mudar a versão.
- O ERP Desktop já trata o optante (CRT 3 não optante; CRT 4 MEI; demais, optante ME/EPP) e baixa os XSD do Padrão Nacional por um pacote do site.

## 7. Próximos passos propostos (nenhum executado)

1. ~~Baixar e ler as NT 008 e 009, o ATC 7/2026, os Anexos VI, VII e VIII e os XSD~~ — **feito em 07/11/2026** (itens 3.1 a 3.5).
2. **Decidir a classificação por serviço** (CST, `cClassTrib`, `cIndOp`, `cAtvSN`), usando o Anexo VIII como tabela de apoio, e como o Simples informa `regApIBSCBSSN` e `vReceitaBrutaSN` em 2027. **Perguntas ao fisco:** a E0855 vale para o optante antes de 2027? Quando a NT 009 entra em produção e quando sai o XSD com os campos do Simples?
3. **Conferir a versão da DPS** dos emissores e a possibilidade de migrar para v1.01.
4. **Homologar** no ambiente nacional antes de 01/01/2027 (Simples) e, para quem for de regime normal, antes das datas de 01/10 e 01/12/2026, que já correram.
