# NF-e modelo 55 (SEFAZ) — contrato oficial para emissor próprio

**Escopo**: misto (o contrato nacional da NF-e é portável para qualquer cliente; o Paraná, a Setes sem IE e o 1º cliente de mercadoria são conteúdo `setes`)
**Levantado em**: 2026-10-15 — NE-0 da nfe-api (`../../../prompts/prompt_onda_nfe_sefaz.md` §13). Rodada 0 = levantamento na web; Rodada 3
DECIDIDA no mesmo dia (D-NE93…D-NE101) — **downloads autorizados pela D-NE94 e FEITOS** (abaixo). **[SEC]** = fonte secundária; "não
confirmado" = não deu para conferir.
**Casa**: D-NE19. Molde: `../../../setes-api/integracoes/nfse-adn/` (o acervo da NFS-e).
**Lista de conferências**: [CONFERENCIAS.md](CONFERENCIAS.md) (65 itens, cada um com a decisão que sustenta).
**Ferramenta**: [`ferramentas/riscados.py`](ferramentas/riscados.py) — lista o texto TACHADO de um PDF de NT (ver "Conhecimento negativo").

---

## Arquivo (baixado em 2026-10-15 — D-NE94)

Cada PDF tem ao lado o `.txt` (`pdftotext -layout -enc UTF-8`) para leitura do agente — **o `.txt` NÃO mostra tachado** (ver abaixo).
Os zips de schema estão também extraídos na própria pasta. SHA-256 = 16 primeiros hex.

| Arquivo | Documento | Bytes | SHA-256 (16) | Origem |
|---|---|---|---|---|
| `moc-7.00/moc7-visao-geral.pdf` | MOC 7.00 — Visão Geral (150 p.) | 4.304.647 | f664dcf94b77cabb | https://www.confaz.fazenda.gov.br/legislacao/arquivo-manuais/moc7-visao-geral.pdf |
| `moc-7.00/moc7-anexo-i-leiaute-e-rv.pdf` | MOC 7.00 — Anexo I: leiaute e regras de validação; cStat §4.4 (153 p.) | 4.106.196 | 5eb4cf2010b10b0b | …/arquivo-manuais/moc7-anexo-i-leiaute-e-rv.pdf |
| `moc-7.00/moc7-anexo-ii-danfe-codigo-barras.pdf` | MOC 7.00 — Anexo II: DANFE e código de barras (28 p.) | 1.345.906 | 729c04fd1374188c | …/arquivo-manuais/moc7-anexo-ii-manual-especificacoes-tecnicas-danfe-codigo-barras.pdf |
| `moc-7.00/moc7-anexo-iii-contingencia.pdf` | MOC 7.00 — Anexo III: contingência (21 p.) | 1.369.540 | e1cfb9b6c5adc6a6 | …/arquivo-manuais/moc7-anexo-iii-manual-contingencia-nf-e.pdf |
| `nt/nt-2025-002-v1-52.pdf` | NT 2025.002-RTC v1.52 (IBS/CBS/IS; 94 p.) — publicada 01/10/2026 | 2.102.849 | 54ed893327040a20 | Portal NF-e `exibirArquivo.aspx?conteudo=HXPO8VLbh4o=` |
| `nt/nt-2026-007-v1-10.pdf` | NT 2026.007 v1.10 — emissão por contribuinte exclusivo do IBS/CBS (sem IE), LCC-RFB/CCC (11 p.) — 01/10/2026 | 775.351 | 4a9d9de64504f409 | `…conteudo=fpJlwzhffcQ=` |
| `nt/nt-2026-008-v1-00.pdf` | NT 2026.008 v1.00 — valor líquido do produto (10 p.) — 01/10/2026 | 461.635 | bc56e76ae5f3354f | `…conteudo=qAoMot6VyiY=` |
| `nt/nt-2026-010-v1-00.pdf` | NT 2026.010 v1.00 — DANFE da RTC (9 p.) — 01/10/2026 | 712.823 | eadc5246235f37a5 | `…conteudo=ugn4MYF5PLg=` |
| `nt/nt-2026-004-v1-01.pdf` | NT 2026.004 v1.01 — schema do CNPJ alfanumérico (14 p.) — 08/06/2026 | 516.956 | 5f24a25351e79069 | `…conteudo=BTZQzgsO9Ws=` |
| `nt/nt-conjunta-2025-001.pdf` | NT Conjunta DF-e 2025.001 v1.00 — CNPJ alfanumérico (15 p.) — documento de 25/04/2025, publicado no portal em 08/05/2025 | 962.216 | 671d546b24ad4682 | `…conteudo=5ZkvIZt10mQ=` |
| `nt/nt-2025-001-v1-03.pdf` | NT 2025.001 v1.03 corrigida — simplificação operacional (15 p.) — 29/09/2025 | 1.028.544 | 333b69f71debe504 | `…conteudo=NvuzQGYd6E8=` |
| `nt/nt-2018-005-v1-52.pdf` | NT 2018.005 v1.52 — responsável técnico e CSRT (28 p.) — 10/07/2025 | 787.598 | c2c299ee59397a49 | `…conteudo=vZguLua3oPM=` |
| `nt/nt-2013-007-v1-03.pdf` | NT 2013.007 v1.03 — SVC (14 p.) — 16/09/2014 | 851.500 | e8d4e4f4b31a1e8c | `…conteudo=b4h3Pi+Helo=` |
| `schemas/PL_010f_v1.04.zip` (+ pasta) | Pacote de Liberação 010f (NT 2025.002 v1.50 + NT 2026.007 v1.00) — 31/08/2026 — **só o leiaute da NF-e** (`leiauteNFe`, `nfe`, `tiposBasico`, `DFeTiposBasicos`, `xmldsig`) | 41.682 | b8589490a58a09a9 | `…conteudo=8ITFuBLltXs=` |
| `schemas/evento-cancelamento-2018-12-21.zip` (+ `Evento_Canc_PL_v1.01/`) | Schemas do evento de cancelamento 110111 (atualizado 21/12/2018) | 10.695 | 71ccd5fcc48f9604 | `…conteudo=0Yynu2Ck+bM=` |
| `schemas/evento-cce-v1.01.zip` (+ `Evento_CCe_PL_v1.01/`) | Schemas da CC-e 110110 v1.01 (30/05/2014) | 11.180 | c300695ae3344dcb | `…conteudo=+0MSTVshMl8=` |
| `schemas/PL_009_V4_00_NT_2020_006_v1.20.zip` (+ pasta) | Pacote-BASE 009 (NT 2020.006 v1.20, 17/03/2021) — todas as RAÍZES das mensagens: enviNFe, retEnviNFe, consReciNFe, retConsReciNFe, inutNFe, retInutNFe, procInutNFe, consSitNFe, retConsSitNFe, consStatServ (+ leiaute), retConsStatServ, procNFe — D-NE115 | 70.894 | be222eb8336bfb38 | `…conteudo=TM+OHbWgTOI=` |
| `schemas/PL_010d_v1.03.zip` (+ `PL_010d_v1.03/`) | Pacote 010d v1.03 — ATUALIZAÇÃO do CNPJ alfanumérico (NT 2026.004 v1.01), 10/07/2026: `NFe/` (consSitNFe, leiauteConsSitNFe, **leiauteInutNFe** — Id `ID[0-9]{4}[0-9A-Z]{12}[0-9]{25}` —, **procInutNFe** — raiz `ProcInutNFe` —, retConsReciNFe, retConsSitNFe, leiaute/nfe/tipos), `Evento/` (envEvento, leiauteEvento — Id `ID[0-9]{12}[0-9A-Z]{12}[0-9]{28}`, TProt 15\|17, TStat 3–4 —, procEventoNFe, retEnvEvento), `CadConsultaCadastro/` (2.00) — baixado 15/10 (D-NE104) | 67.813 | 45ceefe4dfbbfec9 | `…conteudo=+pBOYTXBtbk=` |
| `schemas/pl-cnpj-alfa-eventos-ccc-nt2026-004-v1-01.zip` (+ `NT2026.004_v1.01_eventos_ccc/`) | "CNPJ Alfanumérico - NT2026.004.v.1.01 PL Eventos e Cad Consulta Cadastro CCC.zip" (08/06/2026) — três zips internos (010d, evento, consulta cadastro), extraídos — D-NE104 | 65.203 | cc50170b276c23bd | `…conteudo=FOEnx2KAsCk=` |
| `nt/nt-2021-003-v1-50.pdf` | NT 2021.003 v1.50 — validação do GTIN, Grupo V (52 p.) — 25/09/2026; a VIGENTE do GTIN (substitui a 2017.001 na matéria); Grupo V H 01/04/2027 · P 01/09/2027 — D-NE116 | 1.240.427 | 28b7e26b1a515cdd | `…conteudo=ENot2yWE72Q=` |
| `nt/nt-2023-001-v1-60.pdf` | NT 2023.001 v1.60 — tributação monofásica dos combustíveis (46 p.) — 09/06/2025 — D-NE104 | 1.752.521 | 2b18d99fdb4989a1 | `…conteudo=FZn7+YawPY4=` |
| `nt/nt-2023-004-v1-20.pdf` | NT 2023.004 v1.20 — pagamentos e outros; `indDeduzDeson`; **W16-10 vigente** (16 p.) — 07/10/2024 — D-NE104 | 714.686 | 1c6db64a5c32b176 | `…conteudo=hoSIJ5lGBNc=` |
| `nt/nt-2017-001-v1-50.pdf` | NT 2017.001 v1.50 — validações do GTIN, cronograma CNAE × NCM (18 p.) — 07/12/2018 — D-NE104 | 727.901 | 3b16c2855ac3e7b0 | `…conteudo=5xfrYjX1kSo=` |
| `it/it-2023-002-v2-10-cfop.pdf` | Informe Técnico 2023.002 **v2.10** (CFOP com `indExcIBSCBS`) — 04/09/2026 (o levantamento tinha achado a v2.00; a vigente é a 2.10) | 245.017 | dd47206ec74040b3 | `…conteudo=GyPA/cEjrMk=` |
| `legislacao/atc-rfb-cgibs-08-2026.pdf` | Ato Técnico Conjunto RFB/CGIBS nº 8 (29/09/2026) — versões aprovadas | 902.455 | 54138fabb3ff08d3 | https://www.cgibs.gov.br/upload/arquivos/202610/01120217-nfe-nfc-cte-notas-faturas-e-demais-atc-rfb-sufis-cgibs-diretoria-executiva-n-8-de-29-de-setembro-de-2026.pdf |
| `legislacao/aviso-encat-3008-2026-10-05.txt` | Aviso da Coordenação Técnica do ENCAT de 05/10/2026 (adia H/P das NT 2025.002 v1.52, 2026.007 v1.10 e 2026.008 para **26/10 e 16/11/2026**) + aviso da SVRS do CNPJ alfanumérico de teste — TRANSCRIÇÃO da página (é HTML, não arquivo) | — | — | https://dfe-portal.svrs.rs.gov.br/Nfe/Avisos/3008 |
| `legislacao/npf-101-2014.pdf` | SEFA-PR — NPF 101/2014 (credenciamento de emissores de NF-e) | 145.525 | 0553bbb4603c0283 | http://www.sefanet.pr.gov.br/dados/SEFADOCUMENTOS/103201400101.pdf |
| `legislacao/npf-063-2012.pdf` | SEFA-PR — NPF 063/2012 (sistemas de processamento de dados / UPD; CSRT) | 407.394 | 104eec7a0007c705 | …/SEFADOCUMENTOS/103201200063.pdf |
| `tls/ACcompactado.zip` | ITI — cadeias vigentes da ICP-Brasil (180 certificados, inclusive `ICP-Brasilv10.crt`, `AC-SOLUTI-SSL-EV-G4.crt`, `AC-SERPRO-SSLv1-v10.crt`) — Last-Modified 27/08/2026; **SHA-512 confere** com o `hashsha512.txt` publicado | 351.321 | d7f977c68fed7609 | https://acraiz.icpbrasil.gov.br/credenciadas/CertificadosAC-ICP-Brasil/ACcompactado.zip |
| `tls/hashsha512.txt` | ITI — SHA-512 do pacote acima | 147 | d46c5c94c55dc00b | …/CertificadosAC-ICP-Brasil/hashsha512.txt |
| `tls/homologacao_nfe_sefa_pr_gov_br-03jul2025.zip` | SEFA-PR — cadeia do servidor de homologação (publicada 03/07/2025 — **folha VENCIDA em 03/07/2026**; o servidor já usa outra) | 5.934 | a17e1d9d3c282e5b | https://sped.fazenda.pr.gov.br/sites/sped/arquivos_restritos/files/documento/2025-07/homologacao_nfe_sefa_pr_gov_br-03jul2025.zip |
| `tls/nfe_sefa_pr_gov_br-03jul2025.zip` | SEFA-PR — cadeia do servidor de produção (idem — folha vencida em 03/07/2026) | 6.288 | 6942c8b7afea75c1 | …/2025-07/nfe_sefa_pr_gov_br-03jul2025.zip |

**Como foi baixado**: CONFAZ, CGIBS e SEFA-PR por `curl` comum; ITI pelo `curl` do Windows (cadeia ICP-Brasil no repositório do sistema — o
`curl` do Git não confia na raiz; **um dos servidores do ITI entrega certificado TLS VENCIDO de forma intermitente**: a 1ª tentativa caiu
em `SEC_E_CERT_EXPIRED`, a 2ª passou e o SHA-512 confere); Portal Nacional da NF-e por `curl` com **cookie jar** (`-c`/`-b`) — o "too many
redirects" da Rodada 0 era só o teste de cookie do ASP.NET (os links foram lidos pelo navegador do app). Nenhuma verificação TLS foi
desligada em nenhum download.

**NÃO arquivado**:
- Schemas dos eventos RTC (NT 2025.002 v1.40, 27/07/2026) — fase IBS/CBS; NT 2026.002/2026.006/2026.009/2026.001 — fora do 1º release.
- NPF 062/2023 da SEFA-PR (uso de sistemas de processamento de dados — citada na página do CSRT) — conferir se substitui a NPF 063/2012.
- O pacote de schemas da NT 2026.008 (`vProdLiq`, `vUnComLiq`, `vProdLiqTot`) — **ainda não publicado** em 15/10/2026 (a página de schemas
  para no PL_010f de 31/08).
- O IT 2025.002 v1.70 já está no acervo da NFS-e (`../../../setes-api/integracoes/nfse-adn/classificacao-ibs-cbs/`).

## Conhecimento negativo (o que este acervo já ensinou)

- **O `.txt` de uma NT NÃO mostra o tachado.** O pdftotext põe o texto riscado e o novo lado a lado, sem marca. Prova: na NT 2025.002 v1.52,
  p. 40, a UB12-10 "dizia" no texto produção para CRT 3 em 03/08/2026 e para o Simples em 04/01/2027 — as DUAS observações estão
  RISCADAS no PDF (vale "Observação 2: implementação futura para produção"); uma cópia [SEC] lida em texto levou o levantamento da web a
  afirmar o contrário. Regra: linha de NT com data, prazo ou obrigatoriedade → rodar `ferramentas/riscados.py` antes de concluir.
- **O zip de certificados do servidor publicado pela SEFA-PR está velho** (folha vencida em 03/07/2026): a cadeia do servidor se lê no
  handshake, e o que vale para a confiança é a RAIZ (v10), nunca a folha publicada.
- O Portal Nacional da NF-e não exige navegador — exige COOKIE (`curl -c/-b`); o tamanho e o nome do arquivo se leem por HEAD antes de pedir
  autorização.
- **Os pacotes de schema da NF-e são CAMADAS, não versões completas**: o 010d/010f trazem só o que mudou. Para validar, sobrepor nesta ordem:
  base `PL_009_V4` (raízes das mensagens) → `PL_010d_v1.03` (CNPJ alfanumérico — inut, consSit, recibo, evento, consulta cadastro) →
  `PL_010f_v1.04` (leiaute vigente da NF-e). Os schemas de evento de 2014/2018 (cancelamento, CC-e) são só numéricos — o envEvento vigente é o
  do 010d.
- **O `.txt -layout` desalinha as COLUNAS dos cronogramas** (a NT 2026.008 põe as datas de 2027 da NB01-30 na linha das outras regras):
  data de NT se confere pela POSIÇÃO no PDF (pypdf), nunca só pelo `.txt`.
- **A data que vale pode não estar em nenhuma NT**: o aviso ENCAT de 05/10 adiou H/P das NT 2025.002 v1.52, 2026.007 e 2026.008 — os PDFs
  ainda dizem 05/10 e 03/11. Ler os avisos da SVRS junto com as NT.
- **O `.txt -layout` do Anexo I troca os IDs das regras de linha** (a 897 aparece como "B09-20", a 301 como "1C17-60"): para ID de regra,
  extrair com `pdftotext -raw`.
- **A reforma alarga códigos**: a NT 2025.002 passa o cStat a **3–4 dígitos** e o nProt a **15 ou 17** (o PL_010f já aceita) — coluna,
  tipo ou parser preso em 3/15 quebra. Os XSD de EVENTO arquivados (2014/2018) ainda são só numéricos (chave/CNPJ), `ID[0-9]{52}`, TProt 15 e
  TStat 3 — não validam evento com CNPJ alfanumérico.

## Fatos

Fonte: arquivo deste acervo (com linha do `.txt`) quando arquivado; senão o código: **F5** lista de documentos da SVRS
(https://dfe-portal.svrs.rs.gov.br/Nfe/Documentos) · **F6** serviços da SVRS (…/Nfe/Servicos) · **F7** aviso ENCAT de 05/10/2026
(…/Nfe/Avisos/3008) · **F15** endereços dos WS do PR (https://sped.fazenda.pr.gov.br/NFe/Pagina/Enderecos-dos-ambientes-de-homologacao-e-producao-Versao-400) ·
**F16** credenciamento PR (…/Pagina/Regras-de-Credenciamento) · **F17** CSRT PR (…/Pagina/CSRT) · **F22** Ajuste SINIEF 07/05 consolidado
(https://www.confaz.fazenda.gov.br/legislacao/ajustes/2005/AJ_007_05) · **F23** Decreto PR 9.192/2018 [SEC] · **F26** RFB, CNPJ alfanumérico.
Os itens abaixo são o resumo; o fechamento item a item (status + fonte com linha) está na [CONFERENCIAS.md](CONFERENCIAS.md).

1. **MOC**: vigente em PDF = **7.00** (arquivado); não há MOC 8. A partir de **01/11/2026** (Ajuste SINIEF 40/26) a versão oficial passa a
   ser o **MOC Online mantido pelo Paraná** (http://moc.sped.fazenda.pr.gov.br/NFe_NFCe/VisaoGeral.html — só http) (F22; SVRS notícia 3007).
   D-NE98: conferir lá pelo navegador quando uma linha pedir.
2. **Versões aprovadas** (ATC nº 8, arquivado): NT 2025.002 v1.52 · 2026.002 v1.11 · 2026.007 v1.10 · 2026.008 v1.00 · 2026.010 v1.00 · IT
   2025.002 v1.70. **Calendário**: o texto das NT diz teste até 05/10 e produção 03/11/2026 (NT 2026.007 l. 72–77); o **aviso ENCAT de 05/10
   adiou** para homologação **26/10** e produção **16/11/2026** (F7). NT 2026.010 (DANFE) em produção **01/12/2026**.
3. **Grupo IBSCBS (UB12-10, rej. 1115) — RESOLVIDO no arquivo oficial**: NT 2025.002 v1.52 p. 40 (`nt-2025-002-v1-52.txt` l. 2704–2732) —
   homologação para NF-e de emissão ≥ 01/07/2026 e CRT 3 (Observação 1, não riscada); **produção (03/08/2026 para CRT 3 e 04/01/2027 para
   CRT 1/2/4) RISCADA → "implementação futura para produção"**; as orientações para CRT 1/2/4 "serão publicadas em NT futura" (l. 361–364).
   Confirma a leitura da fase IBS/CBS; a obrigação LEGAL segue o Ato Conjunto nº 4 (o Simples em 01/01/2027).
4. **PL**: mais novo = **PL_010f_v1.04** (31/08/2026) — só o leiaute da NF-e (sem as raízes das mensagens de serviço e dos procs, e
   **sem os campos da NT 2026.008** — o pacote de novembro ainda não saiu); versões das mensagens: enviNFe/consReciNFe/inutNFe/consSitNFe/
   consStatServ 4.00, envEvento 1.00, **consCad 2.00**; histórico na página de schemas: 010e_v1.01 (26/06),
   010e_v1.02 (10/07), 010d_v1.01 (08/06 — CNPJ alfanumérico, eventos e consulta CCC), 010d_v1.02 (26/06), 010d_v1.03 (10/07).
5. **Web services**: NFeAutorizacao4, NFeRetAutorizacao4, NFeInutilizacao4, NFeConsultaProtocolo4, NFeStatusServico4, CadConsultaCadastro4,
   NFeRecepcaoEvento4 (+ NFeDistribuicaoDFe no AN). **PR**: produção `https://nfe.sefa.pr.gov.br/nfe/<Servico>4`, homologação
   `https://homologacao.nfe.sefa.pr.gov.br/nfe/<Servico>4` (F15). **SVRS**: produção `https://nfe.svrs.rs.gov.br/ws/…/…4.asmx`, homologação
   `nfe-homologacao.svrs.rs.gov.br`; consulta cadastro da SVRS só em produção (F6). AC, BA e SP deixam de usar o pedido de inutilização a
   partir de 01/11/2026 (F22 — conferir).
6. **SOAP**: 1.2, Document/Literal, XML em `nfeDadosMsg`; a 4.00 eliminou o `nfeCabecMsg`. `action` × `SOAPAction`: ver CONFERENCIAS 12.
7. **Emitente SEM IE — NT 2026.007 v1.10 (arquivada)**: "contribuinte exclusivo do IBS/CBS" = não informa `emit/IE` + CNPJ ativo na RFB +
   sem IE de ICMS habilitada na UF (l. 120–130); destinada a **contribuintes do ISS** e demais contribuintes do IBS/CBS que passem a emitir
   NF-e — p. ex. venda de ativo imobilizado, transferências (l. 98–108); autorização **só na SVRS** (C17-11, rej. 166 fora dela; l. 276–282);
   SVRS: 163/164 (CCC), 159 (CFOP), 161 (ICMS proibido), **162 (IBSCBS obrigatório — UB12-11)**; NFC-e sem IE proibida (C17-42); regra C17-10
   (229) EXCLUÍDA (riscada). **LCC-RFB para TODAS as autorizadoras**: 178/179 (CNPJ do emitente) e **180 = CRT × `regTrib`** da RFB
   (1 Simples ↔ 1 optante; 3 Normal ↔ 9; 4 MEI ↔ 2) (l. 470–520); **em homologação: exceção se `CCC.indContribTeste=1`** e a LCC consultada é a
   de PRODUÇÃO (l. 488–519). A NT **não trata** inutilização nem contingência para quem não tem IE. No PL_010f o `emit/IE` já é
   `minOccurs=0`; com a NT em produção a rejeição 229 sai para TODAS as autorizadoras (sem IE fora da SVRS = 166; IE zerada segue 209).
   Smoke da Setes no PR (CONFERENCIAS 19): status e consulta protocolo passam; consulta cadastro → 257; inutilização → 203.
8. **Inutilização**: não existe web service de consulta de inutilização; **563** = "já existe pedido de inutilização com a mesma faixa" com o
   `nProt` do pedido anterior; **102** homologada; **256** faixa com NF-e já inutilizada; **201** faixa > 10.000; o **206** é da AUTORIZAÇÃO
   (NF-e já inutilizada). Prazo legal: até o 10º dia do mês seguinte (Ajuste SINIEF 07/05, cl. 14ª). Linhas exatas: CONFERENCIAS 31/32.
9. **Assinatura**: RSA-SHA1 + digest SHA-1, C14N 20010315, enveloped, só o certificado final; nenhuma NT de SHA-256.
10. **Limites**: mensagem até 500 KB (214); lote até 50 NF-e; **1 NF-e tem que ir síncrono — assíncrono = rej. 452 (NT 2025.001)**; síncrono
    com >1 NF-e = 764; esperar ≥ 15 s antes de consultar o recibo.
11. **Consumo indevido (656)**: consulta protocolo > 10 da MESMA chave/h; autorização > 30 rejeições iguais; bloqueio de até 1 h (cada
    autorizador pode mudar; após 50 bloqueios pode virar permanente).
12. **Data/hora**: `AAAA-MM-DDThh:mm:ssTZD`; 703 = emissão > 5 min à frente; atraso > 7 dias → 150; > 30 dias só contingência (NT 2025.001).
13. **Cancelamento 110111**: nacional 24 h; extemporâneo a critério da UF; **PR = 168 h** (RICMS/PR, Anexo III, Subanexo I, art. 11 — F23
    [SEC]); fora do prazo = 501 ("considera a exceção de prazo definida em legislação estadual"); 128 lote processado · 135 vinculado ·
    136 sem vínculo · **155 cancelamento homologado fora de prazo — ESTÁ no MOC 7.00 (§5.9.4, p. 109)**; o 220 NÃO é de cancelamento.
14. **Homologação**: `dest/xNome` = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL" (598); o `xProd` do item 1 é da NFC-e (373).
    **Credenciamento no PR (F16, confirmado)**: homologação AUTOMÁTICA para estabelecimento ativo no **CAD/ICMS** do PR (a Setes não está);
    produção por pedido no **UPD** (NPF 101/2014). **CSRT no PR (F17, confirmado)**: validado desde **19/01/2026 (teste)** e **23/02/2026
    (produção)** — NPF 063/2012 + NT 2018.005 v1.52; CSRT de 16 a 36 bytes, um por FORNECEDOR do software (a Setes), "hash" com a chave de
    acesso; a página cita também a NPF 062/2023.
15. **Texto**: UTF-8 obrigatório (402); `& < > " '` escapados; sem prefixo de namespace (404), sem outro namespace (587), sem formatação entre
    tags (588); acentos "devem ser evitados", não proibidos; `TString` só U+0020–U+00FF, sem CR/LF/TAB nem espaço nas pontas.
16. **TLS do servidor — PROVADO no handshake (2026-10-15, só leitura, sem certificado de cliente)**: PR (homologação e produção) = folha
    da CELEPAR emitida pela **AC SOLUTI SSL EV G4**, que é emitida pela **Raiz ICP-Brasil v10** (folhas válidas até 18–19/06/2027); SVRS
    (homologação e produção) = `*.svrs.rs.gov.br` (PROCERGS) emitida pela **AC SERPRO SSLv1**, também sob a **Raiz v10** (até 03/07/2027);
    TLS 1.2. **A Raiz v10 SOZINHA como `ca` valida as duas** (`openssl s_client -CAfile v10.pem` → código 0). Confirma a D-NE17 (cadeia
    ICP-Brasil, nunca `rejectUnauthorized:false`) e dá o DADO da D-NE54 (a): o `ACcompactado.zip` do ITI traz a v10 e as duas ACs
    intermediárias. A SVRS não manda a raiz na cadeia — o `ca` tem de tê-la.
17. **cStat**: MOC Anexo I §4.4 (4.4.1 resultados, 4.4.2 rejeições, 4.4.3 denegações); códigos novos nas NT (156–188 na NT 2026.007).
18. **CNPJ alfanumérico**: NT Conjunta 2025.001 + NT 2026.004 v1.01 (arquivadas); a RFB só atribui a inscrições NOVAS, desde jul/2026
    (F26); CNPJ de teste na homologação da SVRS: `PC3D315K000193` (aviso 2978). DV da chave: CONFERENCIAS 34.
19. **DANFE**: MOC Anexo II 7.00; novo leiaute pela NT 2026.010 (produção 01/12/2026, sem teste) — vale para **todo DANFE 55**, com ou sem
    IBS/CBS, e imprime o CRT do emitente; Code-128C (largura ≥ 6 cm em não impacto); **com CNPJ alfanumérico a NT Conjunta sugere código
    HÍBRIDO 128C/128A** e 11,5 cm (CONFERENCIAS 59/60).
20. **Devolução referencia POR ITEM** (NT 2025.002 v1.52, VC02-14/rej. **321**, obrigatória; produção 03/11 nas NT → 16/11/2026 pelo aviso):
    finNFe=4 exige `DFeReferenciado` (chave + **nItem**) em cada item e **proíbe o `refNFe`** na devolução; 1010/1048/1193/1194 associadas —
    **derruba a parte "`refNFe` da âncora" da D-NE25/D-E15** (Q-NE103).
21. **A partir de 2027 IBS, CBS e IS COMPÕEM o `vProd`** (NT 2026.008 — o "(+) vIBS/vCBS/vIS" e a exceção de 2025/2026 estão RISCADOS); pela
    W16 o `vNF` passa a carregá-los; campos novos `vUnComLiq`/`vProdLiq`/`vProdLiqTot`; o Simples recebe a regra em NT futura (Q-NE102).
    Nos totais **não há tolerância oficial** (só R$ 0,50 presa ao vServ); a 610 (vNF) é facultativa e a 564 virou obrigatória. A **W16-10
    VIGENTE é a da NT 2023.004 v1.20** (arquivada): soma vICMSMonoReten e o PIS/COFINS-ST com `indSomaPISST`/`indSomaCOFINSST`=1, e o
    vICMSDeson só deduz com `indDeduzDeson`=1 (Exceção 4) — a fórmula do MOC 7.00 está defasada (D-NE102: regra do motor e do builder).
22. **Responsável técnico no PR**: o GRUPO `infRespTec` inteiro é obrigatório desde 03/06/2019 (972/973 — também AM, MS, PE, SC, TO);
    **974: o CNPJ do responsável técnico tem de ser o CADASTRADO para o emitente** (P 01/05/2025) — no PR o uso do sistema é pedido pelo
    ESTABELECIMENTO no UPD com a Setes como fornecedora; CSRT (975) H 19/01 · P 23/02/2026; `hashCSRT` = Base64(SHA-1(CSRT + chave)).
23. **A reforma alarga códigos**: cStat 3–4 dígitos e nProt 15 ou 17 (NT 2025.002 §5.1; o PL_010f já aceita).
