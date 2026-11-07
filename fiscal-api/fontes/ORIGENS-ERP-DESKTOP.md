# Fontes oficiais — Apuração de IBS/CBS

Baixadas em **27/10/2026** para a frente de planejamento [`../plano-apuracao-ibs-cbs.md`](../plano-apuracao-ibs-cbs.md).
Também servem à frente de emissão 2027 ([`../../Emissao2027/plano-emissao-2027.md`](../../Emissao2027/plano-emissao-2027.md),
D-AP14), que acrescentou três NTs em `nfe/` no mesmo dia.
Cada arquivo tem ao lado um `.txt` (UTF-8) gerado por `pdftotext -layout` ou por extração de HTML/JSON, para busca com grep.
Os arquivos começados por `_` são páginas de listagem guardadas só como prova de onde o link saiu.

**Atenção:** o Planalto (planalto.gov.br) bloqueia download automatizado. As leis foram baixadas do LegIn da **Câmara dos
Deputados** (fonte oficial, texto "norma atualizada" com as alterações da LC 227/2026 e da LC 235/2026). A **LC 123/2006
consolidada não foi baixada**: o Planalto bloqueia e a Câmara devolveu 404. As regras do Simples usadas no plano vêm da
LC 214 (que altera a LC 123), da Resolução CGSN 140 multivigente e da Resolução CGSN 190.

## legislacao/

| Arquivo | O que é | Origem | Uso no plano |
|---|---|---|---|
| `lc214-2025-norma-atualizada.htm` / `.pdf` | LC 214/2025 com alterações (LC 227/2026, LC 235/2026) | www2.camara.leg.br/legin (normaatualizada) | arts. 27 (extinção), 41 (regimes), 42–46 (apuração e apuração assistida), 47–57 (créditos), 343–348 (transição) |
| `lc214-2025-publicacao-original.htm` | LC 214 como publicada em 16/01/2025 | idem | conferência |
| `lc227-2026-publicacao-original.htm` | LC 227/2026 (CGIBS, altera a LC 214) | idem | redações novas do art. 47 §§ 8º, 12 e 13 |
| `lc235-2026-publicacao-original.htm` | LC 235/2026 (27/08/2026, altera a LC 214) | idem | conferência |
| `decreto12955-2026-regulamento-cbs-publicacao-original.htm` | Decreto 12.955/2026 — Regulamento da CBS | idem | arts. 41–49 (apuração, prazos, apuração assistida, créditos) |

## rfb/ (Receita Federal)

| Arquivo | O que é | Origem |
|---|---|---|
| `manual-plataforma-cbs-2026-05.pdf` | Manual da Plataforma CBS, versão maio/2026 (atualizado 29/07/2026) | gov.br/receitafederal › Manuais › Reforma Tributária do Consumo |
| `primeiros-passos-apuracao-assistida-1.pdf` / `-2.pdf` | Passo a passo da Apuração Assistida (simulação de venda, compra, DARF, RAD) | idem |
| `manual-servicos-rtc.pdf` | Manual de Serviços da RTC | idem |
| `manual-piloto-rtc-v3-2026-05.pdf` | Manual Piloto RTC v3 (glossário) | idem |
| `comunicado-producao-beta-2025-12.pdf` | Comunicado sobre o ambiente de Produção Beta | idem |
| `api-apuracao-cbs/*.html` | Documentação da API de apuração da CBS: guia assíncrono, débitos, créditos, pagamentos, recolhimentos, situação, download, FAQ (v1.2 de 14/10/2026) | docs.receitafederal.gov.br/apuracao-cbs |

## cgibs/ (Comitê Gestor do IBS)

| Arquivo | O que é |
|---|---|
| `resolucao-cgibs-06-2026-regulamento-ibs.pdf` | Resolução CGIBS 6/2026 — Regulamento do IBS (arts. 41–46 = apuração; espelha o da CBS) |
| `resolucao-cgibs-13-2026-altera-regulamento.pdf` | Altera o art. 617 (vigências) |
| `moc-api-apuracao-assistida-ibs-v1.10.pdf` | **Manual da API de Apuração Assistida do IBS v1.10 (23/09/2026)** — arquivo delta diário, webhook, credenciais do portal CGIBS |
| `manual-integracao-receita-integra-v1.4.pdf` | Receita Integra (Serpro) — OAuth2 client credentials para as APIs da RFB |
| `ato-conjunto-01-2025-obrigacoes-2026.pdf` | Ato Conjunto RFB/CGIBS 1/2025 — 2026 com apuração meramente informativa |
| `ato-conjunto-02..06-2026*.pdf` | Atos Conjuntos 2 a 6/2026 (4 = obrigatoriedade dos DF-e por data; 5 = conformidade; 6 = nanoempreendedor) |
| `ato-tecnico-conjunto-*.pdf` | Atos Técnicos Conjuntos 1, 2, 4, 5, 8 (aprova NT 2025.002 v1.52 e IT 2025.002 v1.70) e 9/2026 |

## cgsn/ (Simples Nacional)

| Arquivo | O que é | Origem |
|---|---|---|
| `manual-opcao-regime-regular-ibs-cbs-simples.pdf` | Manual da opção pelo regime regular do IBS/CBS no Simples (versão 07/10/2026) | www8.receita.fazenda.gov.br/SimplesNacional › Manuais |
| `resolucao-cgsn-190-2026.json` | Resolução CGSN 190/2026 (IBS/CBS no Simples; efeitos 01/01/2027) | normas.receita.fazenda.gov.br (API pública do portal, idAto 152832) |
| `resolucao-cgsn-140-2018-multivigente.json` | Resolução CGSN 140/2018 em visão multivigente (inclui 190, 191 e 195) | idem (idAto 92278) |
| `resolucao-cgsn-195-2026.json` | Resolução CGSN 195/2026 (DASN-Simei como documento; efeitos 01/01/2027) | idem (idAto 154194) |
| `perguntao-simples-nacional.pdf`, `roteiro-opcao-simples-2027.pdf`, `manual-pgdas-d-2018-v4.pdf` | Perguntas e respostas, roteiro da opção 2027, manual do PGDAS-D | Portal do Simples |

## nfe/ (Portal Nacional da NF-e)

| Arquivo | O que é |
|---|---|
| `NT_2025.002_v1.52_RTC.pdf` | Leiaute RTC (grupos IBS/CBS, finNFe 5/6, tpNFDebito/tpNFCredito, eventos 112xxx/211xxx/212xxx). Regras para CRT 1/2/4 "em NT futura" |
| `NT_2026.006_v1.00_vinculo_NFe_split_payment.pdf` | Vínculo NF-e × transação financeira (split payment) |
| `NT_2026.007_v1.10_contribuinte_exclusivo_IBSCBS.pdf` | Emissão por contribuinte exclusivo de IBS/CBS |
| `NT_2026.008_v1.00_valor_liquido.pdf` | Valor líquido do produto (IBS/CBS no vProd a partir de 2027) |
| `NT_2014.002_v1.40_distribuicao_DFe.pdf` | Web service de Distribuição DF-e (NSU) |
| `NT_2020.001_v1.60_manifestacao_destinatario.pdf` | Manifestação do destinatário |
| `NT_2026.002_v1.11_DANFE_simplificado_offline.pdf` | NF-e com DANFE Simplificado Tipo 2, contingência off-line (tpEmis 9), autorização com alerta; **BA02-35/VC02-40/I08-180 em produção em 14/12/2026** (NF-e de saída não referencia NFC-e/CF-e); CSOSN/CFOP do CRT 4 na NFC-e (N12a-91). Baixada em 27/10/2026 para a frente de emissão 2027 |
| `NT_2026.010_v1.00_DANFE_RTC.pdf` | Leiaute do DANFE com IBS/CBS/IS (bloco de totais, CRT no emitente, campos UB nos itens); produção 01/12/2026; "Tipo de Regime de Apuração do IBS e da CBS" com tag "a ser publicada em NT futura". Baixada em 27/10/2026 |
| `NT_2023.002_v1.02_fim_assincrona_inutilizacao.pdf` | **Publicada em 27/10/2026.** Fim da autorização assíncrona (rejeição 129, produção 05/04/2027) e dos serviços de inutilização em AC, BA e SP (produção 11/11/2026). Baixada em 27/10/2026 |
| `NT_2024.001_v1.20_CRT4_MEI.pdf` | Cria o CRT 4 (MEI) e as regras de CFOP/CSOSN do MEI (produção das regras do MEI em 01/04/2025). Baixada em 27/10/2026 para a frente de emissão 2027 (CRT 4 ausente na tela do Gestao) |
| `IT_2025.002_v1.70_tabelas_cClassTrib.pdf` | Informe Técnico 2025.002 v1.70 (01/10/2026, aprovado pelo Ato Técnico Conjunto 8): descrição das tabelas de cClassTrib, CST e crédito presumido; coluna **`tpRBSN`** ("formas de receita bruta aplicáveis aos contribuintes do Simples Nacional"). As tabelas em si (planilhas) ficam em "Documentos > Diversos" do Portal e **não foram baixadas**. Baixado em 27/10/2026 |
| `_comunicado-2026-10-05-adia-homologacao-producao.html`, `_comunicado-2026-10-27-adia-producao-16-11.html` | Comunicados do Portal NF-e: **produção das NTs 2025.002 v1.50/v1.52, 2026.006 v1.00, 2026.007 v1.00/v1.10 e 2026.008 v1.00 adiada para 16/11/2026** (homologação em 26/10/2026). Prevalecem sobre as datas impressas nas NTs |
| `_lista-notas-tecnicas-2026-10-27.html` | Lista de Notas Técnicas do Portal NF-e em 27/10/2026 (prova de que **não** saiu a NT do Simples CRT 1/2/4). Vistas e não baixadas, por não tratarem da reforma: NT 2026.009 v1.00 (CFOP 1.949/2.949), NT 2021.003 v1.50 (GTIN), NT 2023.003 v1.40 (CFOP da NFC-e) |
| `NT_2026.005_v1.00_Simples_Nacional.pdf` | **Publicada em 30/10/2026. A NT do Simples (CRT 1/2/4).** Campos `tpRegimeIBSCBS` (C21a, emitente), `cAtivSN` (I17d, item), grupos `gTribSN`/`gIBSSN`/`gCBSSN` (UB115a-g, alíquota efetiva e valor do Simples) e total `gTribSN` (W59h-j, rej. 1275-1277 e 1284); tabela de preenchimento por CRT × regime (§2.3); devolução espelha o item original (§2.4); evento do fisco 412140 "Tributação do Simples Nacional" (implementação futura). Campos: teste até 26/10/2026, **produção 16/11/2026**. Baixada em 31/10/2026 |
| `NT_2025.002_v1.53_RTC.pdf` | **Publicada em 30/10/2026.** Devolução: chave referenciada no cabeçalho (`refNFe`, uma ocorrência só, B25-40) **ou** no item (`DFeReferenciado`), nunca nos dois (VC02-14, produção 03/11/2026; mudanças da v1.53 até 16/11/2026); UB12-10 ganhou a exceção da devolução de nota anterior a 2027. Baixada em 31/10/2026 |
| `NT_2026.008_v1.01_valor_liquido.pdf` | **Publicada em 30/10/2026.** Datas (produção 16/11/2026); **retirado o item "Composição do valor do produto com IBS e CBS"**; a introdução passa a dizer que o `vProd` é "desconsiderados os valores de IBS, CBS e IS", o `vItem` inclui todos os tributos e o `vNFTot` é a soma dos `vItem`; VB01-10/20 viram implementação futura. A observação do campo I11 ainda diz que IBS/CBS/IS compõem o `vProd` a partir de 2027 (o texto se contradiz). Baixada em 31/10/2026 |
| `NT_2026.007_v1.11_contribuinte_exclusivo_IBSCBS.pdf`, `NT_2026.006_v1.01_vinculo_NFe_split_payment.pdf` | **Publicadas em 30/10/2026.** Só mudança de datas (teste até 26/10/2026, produção 16/11/2026). Baixadas em 31/10/2026 |
| `_lista-notas-tecnicas-2026-10-31.html` | Lista de Notas Técnicas em 31/10/2026 (com as cinco publicações de 30/10/2026) |

Origem de `nfe/`: Portal Nacional da NF-e (`www.nfe.fazenda.gov.br/portal/listaConteudo.aspx?tipoConteudo=04BIflQt1aY=`),
baixado com cookie jar (curl `-c/-b`). Os `.txt` das NTs de 27/10/2026 (2026.002, 2026.010, 2023.002) foram gerados com
`pdftotext -enc UTF-8 -layout`. Os de 31/10/2026 foram gerados com Python (`pypdf`), com a marca `<<<PAGE n>>>` no fim de cada página.

**Não baixados (pendência):** os Anexos I a V da Res. CGSN 190 (tabelas de partilha com IBS e CBS por faixa) são PDFs
anexos ao ato (`Anexo I.pdf` a `Anexo V.pdf`, idArquivoBinario 85769 em diante); a API pública devolve só o texto, e as
tentativas de baixar o binário deram 403. Baixar manualmente pelo Portal do Simples quando a frente de emissão precisar
dos números.

## nfse/ (NFS-e nacional — baixado em 07/11/2026, a pedido do Valdo, do gov.br/nfse e do cgibs.gov.br)

Passo P1 da D-EM51 (`Emissao2027\plano-emissao-2027.md`). Cada PDF tem ao lado um arquivo `<nome>.pdf.txt` gerado por `pdftotext -layout` (a codificação do texto é Windows-1252; o PDF é a fonte).
Os arquivos `_portal-*.html` são as páginas do portal usadas como prova de onde saíram os links.

| Arquivo | O que é | Origem |
|---|---|---|
| `NT_009_SE-CGNFSe_v1.01_RTC_NFSe.pdf` | Nota Técnica SE/CGNFS-e nº 009 v1.01 (datada de 11/09/2026; publicada 01/10/2026): CNPJ alfanumérico, notas de ajuste, Simples Nacional (`regApIBSCBSSN`, `cAtvSN`, `vReceitaBrutaSN`), `verCalcIBSCBS`, reposicionamento de `CST`/`cClassTrib` | `gov.br/nfse/.../rtc/nota-tecnica-009-se-cgnfs-e-v-1-01.pdf` |
| `NT_008_SE-CGNFSe_v1.02_DANFSe.pdf` | Nota Técnica SE/CGNFS-e nº 008 v1.02 (14/07/2026): especificação do DANFSe | `gov.br/nfse/.../rtc/nt-008-se-cgnfse-danfse-20260714-v1-02.pdf` |
| `ATC_07-2026_NFSe-e-NFSeVia_28-09-2026.pdf` | Ato Técnico Conjunto RFB/SUFIS/CGIBS nº 7 (28/09/2026): aprova a NT 009 v1.01 (Anexo VI v1.04 e Anexo VII v1.02) e a NT 010 v1.00 (NFS-e Via) | `cgibs.gov.br/upload/arquivos/202610/01120218-...n-7-de-28-de-setembro-de-2026.pdf` |

**Anexos e esquemas (baixados em 07/11/2026, depois do "Sim, baixar" do Valdo; GET simples, assinatura `PK` conferida, sem executáveis nos pacotes; as planilhas foram lidas por exportação para texto):**

| Arquivo | O que é | Origem (`gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/...`) |
|---|---|---|
| `anexovi-leiautesrn_rtc_ibscbs-v1-04-01-nt009.xlsx` | Anexo VI v1.04.01: leiaute da DPS/NFS-e com IBS/CBS e regras de negócio (7 abas: leiaute, `RN DPS_NFS-e` com os códigos de erro, ajuste de base, notas de ajuste) | `rtc/anexovi-leiautesrn_rtc_ibscbs-v1-04-01-nt009.xlsx` |
| `anexovii-indop_ibscbs_v1-03-00-nt009.xlsx` | Anexo VII v1.03.00: tabela de indicadores da operação (`cIndOp`, 41 códigos, com as colunas `indNFe`/`indNFSe`/`indNFSe Via`) | `rtc/anexovii-indop_ibscbs_v1-03-00-nt009.xlsx` |
| `anexo_viii-tabela-correlacao-v01-02-00-20261026.xlsx` | Anexo VIII v1.02.00 (26/10/2026): correlação item da LC 116 × NBS × `COD_ATIV_SN` × `INDOP` × `cClassTrib` (1.661 linhas, 209 itens, 731 NBS) | `rtc/anexo_viii-tabela-correlacao-v01-02-00-20261026.xlsx` |
| `esquemas_prod_restrita_20261020.zip` | XSD da produção restrita de 20/10/2026 (DPS/NFSe v1.01, 10 arquivos) | `producao-restrita/esquemas_prod_restrita_20261020.zip` |
| `nfse-esquemas_xsd-v1-01-20260209.zip` | XSD da documentação atual (`Schemas\1.00` e `Schemas\1.01`, de 09/02/2026) | `documentacao-atual/nfse-esquemas_xsd-v1-01-20260209.zip` |

Conferência dos dois pacotes XSD: `DPS_v1.01`, `NFSe_v1.01`, `evento`, `pedRegEvento`, `tiposCnc` e `tiposEventos` são idênticos; `tiposComplexos`, `tiposSimples` e `xmldsig-core-schema` diferem. A produção restrita traz `vAjusteBC`; o pacote de fevereiro traz `vDedRed` e `gReeRepRes`. **Nenhum dos dois traz** `regApIBSCBSSN`, `cAtvSN`, `vReceitaBrutaSN`, `gTribSN`, `verCalcIBSCBS` nem `opSimpNac` = 4 (esses só existem no Anexo VI).

**Não baixado:** o Anexo VI v1.04 e o Anexo VII v1.02 exatos que o ATC 7 aprova (o portal só oferece as revisões v1.04.01 e v1.03.00), e as versões anteriores dos Anexos VI a VIII listadas no portal.
