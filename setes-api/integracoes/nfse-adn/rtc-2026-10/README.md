# NFS-e Nacional — documentos RTC (IBS/CBS) arquivados em 2026-10-10

**Escopo**: setes
**Origem**: IB-0 da fase IBS/CBS (`Infra-IA/prompts/prompt_fase_ibs_cbs.md` — D-IB21; downloads autorizados pelo Valdo em 2026-10-10)
**Fonte**: página oficial "RTC" do portal da NFS-e — https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/rtc
(o gov.br recusa HEAD e clientes sem User-Agent com 403; GET com User-Agent de navegador + Referer da página responde 200)
**Casa**: junto do acervo `nfse-adn` (decisão do Valdo na IB-0); a mudança para `Infra-IA/nfse-api/integracoes/` (D-NE19/D-IB21) é tarefa mecânica separada.

| Arquivo | Documento | Bytes | SHA-256 (16) | URL |
|---|---|---|---|---|
| `nota-tecnica-009-se-cgnfs-e-v-1-01.pdf` | NT SE/CGNFS-e nº 009 v1.01 (01/10/2026) — campos do Simples (`regApIBSCBSSN`, `cAtvSN`, `gTribSN`), notas de ajuste, `vAjusteBC`, `gPgtoVinc` — **sem XSD nem cronograma** | 703145 | cc86c9402e317e84 | …/rtc/nota-tecnica-009-se-cgnfs-e-v-1-01.pdf |
| `anexovi-leiautesrn_rtc_ibscbs-v1-04-01-nt009.xlsx` | Anexo VI v1.04.01 — leiaute + regras de negócio do RTC (NT 009 v1.01) | 296297 | 103a150dd6f56ec8 | …/rtc/anexovi-leiautesrn_rtc_ibscbs-v1-04-01-nt009.xlsx |
| `anexovii-indop_ibscbs_v1-03-00-nt009.xlsx` | Anexo VII v1.03.00 — tabela de cIndOp (aba "cIndOp Public": código, tipo, característica, local do fornecimento, LC 214, `indNFe`, `indNFSe`, `indNFSe Via`, `NFSeLocIncidIBS`) | 27475 | 95f30a44ee94adee | …/rtc/anexovii-indop_ibscbs_v1-03-00-nt009.xlsx |
| `anexoviii-correlacaoitemnbsindopcclasstrib_ibscbs_v1-01-00.xlsx` | Anexo VIII v1.01.00 — correlação Item LC 116 × NBS × cIndOp × cClassTrib (aba "tabela geral", ~1.500 linhas) — **"trabalho inicial", sem regra ligada** | 142315 | a21be0e86b7ae2c0 | …/rtc/anexoviii-correlacaoitemnbsindopcclasstrib_ibscbs_v1-01-00.xlsx |
| `nt-010-se-cgnfse-leiaute-nfse-via-v-1.00.pdf` | NT SE/CGNFS-e nº 010 v1.00 — leiaute da "NFS-e Via" (novo; não lido ainda) | 425218 | 18cd169f76f7f949 | https://www.gov.br/nfse/pt-br/nfs-e-via/documentacao-tecnica/notas-tecnicas/nt-010-se-cgnfse-leiaute-nfse-via-v-1.00.pdf |

`…` = `https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica`

**Achados de leitura (IB-0)**: Anexo VIII liga o subitem **01.02 Programação** → NBS 1.1502.10.00 / .20.00 / .90.00 →
cIndOp **100301** ("Demais serviços, em operações onerosas" — domicílio principal do adquirente) → cClassTrib **000001** (tributação
integral). 01.05 Licenciamento → 1.1103.21.00 → 100501. 01.07 Suporte técnico → 1.1501.30.00 → 050101 (local da prestação).
01.03 Hospedagem → 1.1506.10.00 → 100301.
