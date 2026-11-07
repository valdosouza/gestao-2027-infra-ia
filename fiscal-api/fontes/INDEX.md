# fiscal-api/fontes — manifesto das fontes oficiais de NF-e, NFS-e e Reforma Tributária

**Escopo**: método (documentos oficiais públicos, sem dado de cliente)
**Criado em**: 07/11/2026, por decisão do Valdo: o ERP Desktop (legado, vivo até os clientes migrarem) e o sistema web **reaproveitam o mesmo conhecimento** de NF-e e NFS-e; o que for lido, decidido ou baixado de um lado não se refaz do outro. **Casa única do conhecimento fiscal: `Infra-IA/fiscal-api`.**
**Origem do levantamento**: comparação por hash (SHA-256) de 257 arquivos oficiais dos dois lados em 07/11/2026.

## 1. Regra de uso (vale para as duas pontas)

1. **Antes de baixar ou pesquisar um assunto fiscal, procure aqui** e nos README das áreas (item 2). Em 07/11/2026 o mesmo XSD tinha sido baixado duas vezes e a mesma descoberta feita duas vezes.
2. **Arquivo novo entra uma vez só**, na área certa do item 2, com **origem (endereço), data e SHA-256** no README da área, e a linha correspondente neste manifesto.
3. A **leitura da norma** (o que o fisco diz) é única e mora nos documentos `01` em diante desta pasta; a **decisão de produto** é de cada sistema e aponta para a leitura.
4. **Dado sensível nunca entra** (senha, token, certificado, CNPJ ou e-mail de cliente). Documentação e código podem ser livres (Valdo, 07/11/2026).

## 2. Onde está cada acervo

| Área | Caminho em `Infra-IA/` | O que guarda | Manifesto próprio |
|---|---|---|---|
| NF-e (mod. 55) e NFC-e | `nfe-api/integracoes/nfe-sefaz/` | MOC 7.00, Notas Técnicas (`nt/`, agora com as versões mais novas), IT, schemas (PL_*), legislação da NF-e, TLS | `README.md` (tabela com origem e hash) |
| NFS-e Padrão Nacional | `setes-api/integracoes/nfse-adn/` | Manuais do ADN e do Emissor, FAQ, Resolução CGNFS-e 3/2023, XSD 1.00/1.01, **produção restrita 20/10/2026**, Anexos I e II, `rtc-2026-10/` (NT 009, Anexos VI a VIII, NT 010), **`rtc-2026-11/` (NT 008 PDF, ATC 7, Anexo VIII v1.02.00, páginas do portal)**, classificação (IT 2025.002 v1.70), legislação IBS/CBS | `README.md` e o de cada subpasta |
| CNPJ alfanumérico (NFS-e) | `setes-api/integracoes/cnpj-alfanumerico/` | XSD da produção restrita v1.01 de 27/07/2026 | — |
| **Legislação, atos e manuais da Reforma** | `fiscal-api/fontes/` (esta pasta) | LC 214, LC 227, LC 235, Decreto 12.955; atos conjuntos e atos técnicos do CGIBS; Simples Nacional (CGSN); manuais da RFB e da apuração assistida | `ORIGENS-ERP-DESKTOP.md` (origem de cada arquivo) |
| Espelho no SVN do ERP Desktop | `D:\Gestao2016\Docs\ReformaTributaria\Apuracao\fontes\` | As mesmas fontes que serviram de prova às decisões do legado | `README.md` da pasta |

## 3. Arquivos idênticos nos dois lados (mesmo SHA-256)

Já existiam nos dois acervos. Nenhum precisa ser baixado de novo; a cópia do SVN fica como espelho de prova.

| SHA-256 (12) | Na web (`Infra-IA/…`) | No SVN do ERP Desktop (`…/fontes/`) |
|---|---|---|
| 4a76f0afbf30 | `setes-api/integracoes/nfse-adn/legislacao-ibs-cbs/ato-conjunto-rfb-cgibs-04-2026.pdf` | `cgibs/ato-conjunto-04-2026-obrigatoriedade-dfe.pdf` |
| 251f7a8d886b | `setes-api/integracoes/nfse-adn/legislacao-ibs-cbs/ato-conjunto-rfb-cgibs-05-2026.pdf` | `cgibs/ato-conjunto-05-2026-conformidade.pdf` |
| 54138fabb3ff | `nfe-api/integracoes/nfe-sefaz/legislacao/atc-rfb-cgibs-08-2026.pdf` | `cgibs/ato-tecnico-conjunto-08-2026-nfe-nfce-cte.pdf` |
| 46be3150314e | `setes-api/integracoes/nfse-adn/legislacao-ibs-cbs/manual-cgsn-opcao-regime-regular-ibs-cbs-2026-10-07.pdf` | `cgsn/manual-opcao-regime-regular-ibs-cbs-simples.pdf` |
| cbf61d15fce4 | `setes-api/integracoes/nfse-adn/classificacao-ibs-cbs/it-2025-002-v1-70-tabelas-classificacao-ibs-cbs.pdf` | `nfe/IT_2025.002_v1.70_tabelas_cClassTrib.pdf` |
| 671d546b24ad | `nfe-api/integracoes/nfe-sefaz/nt/nt-conjunta-2025-001.pdf` | `nfe/NTConjunta_2025.001_CNPJ_alfanumerico_orientacoes.pdf` |
| 54ed89332704 | `nfe-api/integracoes/nfe-sefaz/nt/nt-2025-002-v1-52.pdf` | `nfe/NT_2025.002_v1.52_RTC.pdf` |
| 5f24a25351e7 | `nfe-api/integracoes/nfe-sefaz/nt/nt-2026-004-v1-01.pdf` | `nfe/NT_2026.004_v1.01_CNPJ_alfanumerico.pdf` |
| 4a9d9de64504 | `nfe-api/integracoes/nfe-sefaz/nt/nt-2026-007-v1-10.pdf` | `nfe/NT_2026.007_v1.10_contribuinte_exclusivo_IBSCBS.pdf` |
| bc56e76ae5f3 | `nfe-api/integracoes/nfe-sefaz/nt/nt-2026-008-v1-00.pdf` | `nfe/NT_2026.008_v1.00_valor_liquido.pdf` |
| eadc5246235f | `nfe-api/integracoes/nfe-sefaz/nt/nt-2026-010-v1-00.pdf` | `nfe/NT_2026.010_v1.00_DANFE_RTC.pdf` |
| cc86c9402e31 | `setes-api/integracoes/nfse-adn/rtc-2026-10/nota-tecnica-009-se-cgnfs-e-v-1-01.pdf` | `nfse/NT_009_SE-CGNFSe_v1.01_RTC_NFSe.pdf` |
| 103a150dd6f5 | `setes-api/integracoes/nfse-adn/rtc-2026-10/anexovi-leiautesrn_rtc_ibscbs-v1-04-01-nt009.xlsx` | `nfse/anexovi-leiautesrn_rtc_ibscbs-v1-04-01-nt009.xlsx` |
| 95f30a44ee94 | `setes-api/integracoes/nfse-adn/rtc-2026-10/anexovii-indop_ibscbs_v1-03-00-nt009.xlsx` | `nfse/anexovii-indop_ibscbs_v1-03-00-nt009.xlsx` |
| 25fdcecc651a | `setes-api/integracoes/nfse-adn/producao-restrita-20261020/esquemas_prod_restrita_20261020.zip` | `nfse/esquemas_prod_restrita_20261020.zip` |
| e7935cbd9470 | `setes-api/integracoes/nfse-adn/nfse-esquemas_xsd-v1.01-20260209.zip` | `nfse/nfse-esquemas_xsd-v1-01-20260209.zip` |

## 4. Versões que estavam só no legado e foram trazidas para a web em 07/11/2026

| Onde ficou | Arquivo | Observação |
|---|---|---|
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2014-002-v1-40.pdf` | NT 2014.002 v1.40 — Web Service de Distribuição DF-e (NSU) |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2020-001-v1-60.pdf` | NT 2020.001 v1.60 — Manifestação do destinatário |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2023-002-v1-02.pdf` | NT 2023.002 v1.02 — fim da autorização assíncrona (rejeição 129, produção 05/04/2027) e da inutilização em AC, BA e SP (produção 11/11/2026); publicada em 27/10/2026 |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2024-001-v1-20.pdf` | NT 2024.001 v1.20 — CRT 4 (MEI) e regras de CFOP/CSOSN do MEI |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2025-002-v1-53.pdf` | NT 2025.002-RTC v1.53 — devolução com a chave referenciada no cabeçalho ou no item; publicada em 30/10/2026 |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2026-002-v1-11.pdf` | NT 2026.002 v1.11 — DANFE simplificado tipo 2, contingência off-line (tpEmis 9); BA02-35/VC02-40/I08-180 em produção em 14/12/2026 |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2026-005-v1-00.pdf` | NT 2026.005 v1.00 — Simples Nacional (CRT 1/2/4): tpRegimeIBSCBS, cAtivSN, gTribSN/gIBSSN/gCBSSN; publicada em 30/10/2026, produção 16/11/2026 |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2026-006-v1-00.pdf` | NT 2026.006 v1.00 — vínculo NF-e × transação financeira (split payment) |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2026-006-v1-01.pdf` | NT 2026.006 v1.01 — vínculo NF-e × split payment (só datas); publicada em 30/10/2026 |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2026-007-v1-11.pdf` | NT 2026.007 v1.11 — contribuinte exclusivo de IBS/CBS (só datas); publicada em 30/10/2026 |
| `nfe-api/integracoes/nfe-sefaz/nt/` | `nt-2026-008-v1-01.pdf` | NT 2026.008 v1.01 — valor líquido do produto; retira o item "Composição do valor do produto com IBS e CBS"; produção 16/11/2026 |
| `setes-api/integracoes/nfse-adn/rtc-2026-11/` | `nt-008-se-cgnfse-danfse-20260714-v1-02.pdf` | NT SE/CGNFS-e 008 v1.02 — DANFSe (14/07/2026) |
| `setes-api/integracoes/nfse-adn/rtc-2026-11/` | `atc-07-2026-nfse-e-nfsevia-28-09-2026.pdf` | Ato Técnico Conjunto RFB/SUFIS/CGIBS 7/2026 (28/09/2026): aprova a NT 009 v1.01 (Anexo VI v1.04, Anexo VII v1.02) e a NT 010 v1.00 |
| `setes-api/integracoes/nfse-adn/rtc-2026-11/` | `anexo_viii-tabela-correlacao-v01-02-00-20261026.xlsx` | Anexo VIII v1.02.00 (26/10/2026) — correlação item da LC 116 × NBS × cAtvSN × indOp × cClassTrib (a web tinha a v1.01.00) |
| `setes-api/integracoes/nfse-adn/rtc-2026-11/` | `portal-nfse-atualizacoes-e-implantacoes-2026-11-07.html` | Página "Atualizações e Implantações" do portal da NFS-e em 07/11/2026 (o que está em produção e em produção restrita) |
| `setes-api/integracoes/nfse-adn/rtc-2026-11/` | `portal-nfse-rtc-2026-11-07.html` | Página "RTC" da biblioteca de documentação técnica da NFS-e em 07/11/2026 (lista de notas técnicas e anexos) |

## 5. Legislação, atos e manuais copiados para esta pasta (`fiscal-api/fontes/`)

Cada arquivo `.pdf` ou `.htm` tem ao lado um `.txt` (texto extraído) quando o original é pesado. Origem de cada um: `ORIGENS-ERP-DESKTOP.md`. As páginas `_*.html` são fotografias do portal na data do levantamento.

| Arquivo | Bytes | SHA-256 (16) |
|---|---|---|
| `cgibs/_home.html` | 58.609 | 369283c2dd50fe8a |
| `cgibs/_lista-atos-conjuntos.html` | 52.570 | 46ad2841b30eba65 |
| `cgibs/_lista-atos-tecnicos-conjuntos.html` | 53.742 | 9e95ca01b9364444 |
| `cgibs/_lista-documentos-tecnicos.html` | 51.637 | cd2f714c063dee7c |
| `cgibs/_lista-regulamentos.html` | 50.150 | 337f0da9db5fdd17 |
| `cgibs/_pagina-apuracao-assistida-ibs.html` | 48.659 | fcc42f8cdcfb1661 |
| `cgibs/ato-conjunto-01-2025-obrigacoes-2026.pdf` | 164.068 | ef8fd7902133b8df |
| `cgibs/ato-conjunto-02-2026.pdf` | 733.052 | ac3c05c9e7ac56a9 |
| `cgibs/ato-conjunto-03-2026-dere.pdf` | 909.043 | 7390981608c9d510 |
| `cgibs/ato-conjunto-04-2026-obrigatoriedade-dfe.pdf` (já na web) | 867.240 | 4a76f0afbf306557 |
| `cgibs/ato-conjunto-05-2026-conformidade.pdf` (já na web) | 378.457 | 251f7a8d886b70f8 |
| `cgibs/ato-conjunto-06-2026.pdf` | 875.017 | ecb129d646f2b617 |
| `cgibs/ato-tecnico-conjunto-01-2026-ratifica-nts.pdf` | 517.244 | 6fc8aecc0a362bbd |
| `cgibs/ato-tecnico-conjunto-02-2026.pdf` | 1.922.670 | 45a7bee5ff291b42 |
| `cgibs/ato-tecnico-conjunto-04-2026-split.pdf` | 465.757 | e48c6838542d6233 |
| `cgibs/ato-tecnico-conjunto-05-2026.pdf` | 473.485 | e403dcd404f96b04 |
| `cgibs/ato-tecnico-conjunto-08-2026-nfe-nfce-cte.pdf` (já na web) | 902.455 | 54138fabb3ff08d3 |
| `cgibs/ato-tecnico-conjunto-09-2026.pdf` | 529.299 | 4d8bb7b574b79154 |
| `cgibs/manual-integracao-receita-integra-v1.4.pdf` | 449.907 | e02d210d30e78aaf |
| `cgibs/moc-api-apuracao-assistida-ibs-v1.10.pdf` | 1.563.839 | 99613100c1d88e66 |
| `cgibs/resolucao-cgibs-06-2026-regulamento-ibs.pdf` | 2.896.452 | 9ed7032ef9c25bbe |
| `cgibs/resolucao-cgibs-13-2026-altera-regulamento.pdf` | 481.153 | 527f5b01b2c8effd |
| `cgsn/_lista-legislacao.html` | 25.966 | 2deb0e4744be4f9d |
| `cgsn/_lista-manuais.html` | 40.983 | 0491c4a332c2e91d |
| `cgsn/_lista-tela-legislacao.html` | 30.262 | 96169884932c1dc3 |
| `cgsn/manual-opcao-regime-regular-ibs-cbs-simples.pdf` (já na web) | 1.760.570 | 46be3150314ece2f |
| `cgsn/manual-pgdas-d-2018-v4.pdf` | 6.516.324 | e73b2bfc7eded9e4 |
| `cgsn/perguntao-simples-nacional.pdf` | 1.759.275 | 08667b6c34527f12 |
| `cgsn/resolucao-cgsn-140-2018-multivigente.json` | 1.463.113 | 32588ef739a8d592 |
| `cgsn/resolucao-cgsn-190-2026.json` | 401.283 | f6b9c4986b051322 |
| `cgsn/resolucao-cgsn-195-2026.json` | 12.515 | 744914843138b566 |
| `cgsn/roteiro-opcao-simples-2027.pdf` | 334.505 | e3f6cf25c5168aad |
| `legislacao/decreto12955-2026-regulamento-cbs-publicacao-original.htm` | 1.034.352 | 895774cdd2ec8208 |
| `legislacao/lc214-2025-norma-atualizada.htm` | 3.095.827 | dc87a43e7a4c293b |
| `legislacao/lc214-2025-norma-atualizada.pdf` | 1.280.237 | 0cf36f4433ced108 |
| `legislacao/lc214-2025-publicacao-original.htm` | 958.783 | efd06578a4789874 |
| `legislacao/lc227-2026-publicacao-original.htm` | 851.353 | 78b197b1fc22b9ec |
| `legislacao/lc235-2026-publicacao-original.htm` | 67.813 | 17f711208a88d462 |
| `rfb/api-apuracao-cbs/credito.html` | 30.673 | 1c474ee718ce166a |
| `rfb/api-apuracao-cbs/debito.html` | 27.701 | 6bb396df98be2b7e |
| `rfb/api-apuracao-cbs/download.html` | 8.580 | 43dea30176bedc97 |
| `rfb/api-apuracao-cbs/faq.html` | 6.880 | 3942e59eb12f4a22 |
| `rfb/api-apuracao-cbs/guiaapiassincrona.html` | 9.877 | e7c5e6ae746ecee9 |
| `rfb/api-apuracao-cbs/index.html` | 2.155 | b6e21e6c65e893fd |
| `rfb/api-apuracao-cbs/pagamentos.html` | 23.845 | 1ec274fe842707a6 |
| `rfb/api-apuracao-cbs/recolhimentos.html` | 23.126 | 8402fee5e8baacb9 |
| `rfb/api-apuracao-cbs/situacao-solicitacao.html` | 7.736 | febd34088a540c45 |
| `rfb/comunicado-producao-beta-2025-12.pdf` | 306.884 | 29bb3281a684b477 |
| `rfb/manual-piloto-rtc-v3-2026-05.pdf` | 805.170 | 6a79c4691badf62f |
| `rfb/manual-plataforma-cbs-2026-05.pdf` | 4.899.543 | 745d11d63a50a631 |
| `rfb/manual-servicos-rtc.pdf` | 3.000.844 | 0273fc690c514654 |
| `rfb/primeiros-passos-apuracao-assistida-1.pdf` | 2.222.816 | 2277f9edce03bd1f |
| `rfb/primeiros-passos-apuracao-assistida-2.pdf` | 1.132.388 | fc3426adebfec836 |

## 6. O que só a web tem e o legado deve consultar antes de pesquisar

- **ADN e Emissor Nacional da NFS-e:** `nfse-adn/manual-api-contribuinte-v12.txt`, `manual-adn-contribuinte.txt`, `faq-nacional.txt` (174 itens), `res3-2023.txt`, `anexo1-dps.xlsx` e `anexo2-eventos.xlsx` (v1.01).
- **Produção restrita de 20/10/2026:** `nfse-adn/producao-restrita-20261020/` (XSD, Anexos I e II da produção restrita e `DIFERENCA.md` com a diferença para o pacote de 09/02/2026).
- **NF-e:** MOC 7.00, schemas PL_009 a PL_010f e dos eventos, `CONFERENCIAS.md` (65 itens, cada um com a decisão que o sustenta), `AUTORIZADORES.md`.
- **Código e decisões da web:** `nfse-api/src/authority/layout-calendar.ts` (calendário de leiaute por documento, ambiente e instante) e `Infra-IA/prompts/prompt_fase_ibs_cbs.md` (decisões D-IB1 em diante).

## 7. Pendências deste acervo

- A origem **por arquivo** (endereço) das NTs de NF-e trazidas no item 4 não foi registrada de forma individual; vale a lista de NTs do Portal NF-e. Preencher quando alguém rebaixar.
- `fiscal-api/fontes/` e o espelho do SVN têm os mesmos arquivos: daqui em diante **só esta casa recebe arquivo novo**; o README do SVN deve apontar para cá.
- Ainda não existem aqui os vetores de teste neutros (entrada e saída esperada por regra) nem o calendário único de fatos com data; são as próximas peças da base de conhecimento fiscal.
