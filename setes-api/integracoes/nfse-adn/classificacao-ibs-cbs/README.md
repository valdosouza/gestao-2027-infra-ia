# Classificação tributária do IBS/CBS — tabela oficial arquivada em 2026-10-10

**Escopo**: setes
**Origem**: IB-0/Rodada 2 da fase IBS/CBS (`Infra-IA/prompts/prompt_fase_ibs_cbs.md` — D-IB23; download autorizado pelo Valdo em 2026-10-10: "pode baixar o IT")
**Fonte**: Portal Nacional da NF-e (o portal exige cookie de sessão da página de listagem antes de `exibirArquivo.aspx`)

| Arquivo | Documento | Bytes | SHA-256 (16) | Origem |
|---|---|---|---|---|
| `it-2025-002-v1-70-tabelas-classificacao-ibs-cbs.pdf` | Informe Técnico 2025.002 v1.70 — "Tabelas de Classificação do IBS e da CBS" (publicado 01/10/2026; Ato Técnico Conjunto nº 8). É a DOCUMENTAÇÃO das colunas (13 páginas); a tabela em si é publicada à parte | 4684152 | cbf61d15fce46101 | Informes Técnicos → `exibirArquivo.aspx?conteudo=h9o7idH+OcI=` |
| `it-2025-002-v1-70-cclasstrib.xlsx` | "IT 2025.002 v.1.70 - cClassTrib.xlsx" — a TABELA (Diversos: "Tabela de Classificação Tributária do IBS e CBS - Publicada em 01/10/2026") | 165715 | bee3e106d24c0625 | Diversos → `exibirArquivo.aspx?conteudo=Cd5xq2ZVuEg=` |

**Estrutura da planilha** (lida em 2026-10-10):
- aba `cClass 2026-09-01` — 173 cClassTrib (todos distintos): CST, descrição do CST, cClassTrib, Nome, Descrição (máx. 1.155
  caracteres), LC/Regulamentos, Tipo de Alíquota, `pRedIBS`, `pRedCBS`, **`ind_gTribRegular`** (por CLASSIFICAÇÃO — 31 = 1),
  `ind_gCredPresOper`, `ind_gMono*`, `ind_gpBioDiferenca`, `ind_gEstornoCred`, `tpRBSN`, `tpDoacao`, **`dIniVig`** (todas 2026-01-01
  nesta versão), **`dFimVig`** (3 preenchidas), `DataAtualização`, **aplicabilidade por documento** (`indNFe`, `indNFCe`, `indNFSe` — 73 =
  1 —, `indNFSe Via`, `indCTe`… `indDUIMP`), ANEXO, Link;
- aba `CST 2026-09-01` — CST com as flags de grupo (`ind_gIBSCBS`, `ind_gIBSCBSMono`, `ind_gRed`, `ind_gDif`, `ind_gTransfCred`,
  `ind_gCredPresIBSZFM`, `ind_gAjusteCompet`, `ind_RedutorBC`);
- abas `tpDoacao` e `tpRBSN` (domínios).

**Uso** (D-IB23, refinada pelo fato): esta planilha é a fonte de IDENTIDADE, VIGÊNCIA, `ind_gTribRegular` e APLICABILIDADE por
documento do catálogo central; a API da Calculadora (`/dados-abertos/classificacoes-tributarias/cbs-ibs?data=` e
`/{sigla}/{cClassTrib}`) é a CONFERÊNCIA — divergência entre as duas = carga recusada inteira.
