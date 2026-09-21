# NFS-e Padrão Nacional (Sefin Nacional / ADN) — contrato oficial para emissor próprio

**Escopo**: misto (o padrão nacional é método portável para qualquer cliente; Curitiba e o e-CNPJ da
Setes são conteúdo `setes`)
**Levantado em**: 2026-09-20 (Rodada 0 da Onda 3 — `prompts/prompt_onda3_nfse_adn.md`), só fontes
oficiais gov.br / nfse.gov.br / Prefeitura de Curitiba, salvo onde marcado **[SEC]**
**Por que está aqui**: como no Banco Inter (`../banco-inter/`), documentos públicos de um terceiro
guardados em TEXTO para o agente ler sem ir ao portal. Os swaggers oficiais exigem certificado de
cliente (HTTP 403 anônimo) — baixar na sessão de smoke com o e-CNPJ, como foi feito com o Inter.

| Arquivo | O que é |
|---|---|
| `manual-api-contribuinte-v12.txt` | Manual do Contribuinte — API do Emissor Público (Sefin Nacional) v1.2 (out/2025): endpoints |
| `manual-adn-contribuinte.txt` | Manual das APIs do ADN para contribuintes v1.0 (12/02/2026): distribuição DF-e por NSU, eventos por chave |
| `manual-integrado-2022.txt` | Manual Integrado SNNFS-e v1.01 (homologação, 2022) — único que descreve por extenso comunicação, certificado e assinatura |
| `anexo1-dps.xlsx` | Anexo I — leiaute DPS/NFS-e v1.01 (09/02/2026) + regras de negócio E0xxx + local de incidência por subitem |
| `anexo2-eventos.xlsx` | Anexo II — pedido de registro de evento / eventos v1.01 (22/01/2026) |
| `nt007.txt` · `nt008.txt` · `nt009.txt` | Notas Técnicas da reforma tributária (IBS/CBS): 007 (fev/2026), 008 DANFSe v1.02 (jul/2026), 009 v1.0 (jun/2026) |
| `res3-2023.txt` | Resolução CGNFS-e nº 3/2023 — modelo, eventos, DANFSe, irreversibilidade do cancelamento |
| `faq-nacional.txt` | Perguntas e respostas oficiais v1.00 (08/09/2026, 174 itens) |
| `curitiba-manual.txt` | Manual de Emissão da NFS-e Nacional da Prefeitura de Curitiba (regras locais de eventos) |

## Fatos confirmados (o que o modelo da Onda 3 assume)

**Arquitetura.** ADN = repositório nacional de todos os DF-e de serviço. Sefin Nacional = quem "valida e
recebe DPS" e gera a NFS-e (numera `nNFSe` sequencial por emitente, nunca reaproveitado). Emissor
Nacional (Web, Mobile, **API**) chega à mesma Sefin. **Emissor próprio = o ERP assina e envia a DPS pela
API da Sefin Nacional** e recebe a NFS-e síncrona (ou a rejeição). NÃO existe "integrar direto ao ADN"
para emitir: ao contribuinte o ADN só expõe distribuição/consulta. Município de sistema próprio não fala
com o ADN pelo contribuinte (`ambGer` 1 × 2). Base normativa: Res. CGNFS-e 3/2023.

**Curitiba (4106902) — CONFIRMADO conveniado à Sefin Nacional**: planilha oficial de adesões
(`municipios-aderentes-20260918.xlsx`, gov.br/nfse/municipios/monitoramento-adesoes): "Conveniado Ativo",
aderente ao Ambiente Nacional e ao Emissor Nacional, vigência 30/08/2023. Cronograma municipal (Portaria
33/2025, Decreto 1960/2025): ISS fixo 01/10/2025 · Simples Nacional 01/11/2025 · **demais contribuintes
01/01/2026, obrigatório** — a memória "Curitiba migrou em jan/2026" está certa. ISS continua recolhido
por DAM no ISS Curitiba (Portaria 51/2025). Suporte: isscuritiba@curitiba.pr.gov.br. Fonte:
https://lp.curitiba.pr.gov.br/notanacional/ e https://mid.curitiba.pr.gov.br/2025/00461932.pdf.

**APIs (REST; JSON por fora, XML GZip+base64 por dentro).** Índice oficial dos swaggers:
https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/apis-prod-restrita-e-producao
- Sefin Nacional — produção `https://sefin.nfse.gov.br/SefinNacional` · produção restrita
  `https://sefin.producaorestrita.nfse.gov.br/SefinNacional`.
  `GET /parametros_municipais/{cMun}/convenio` · `/{cMun}/{codigoServico}` (alíquota, regimes, deduções) ·
  `/{cMun}/{CPF/CNPJ}` (retenções/benefícios) · **`POST /nfse`** (recebe DPS, gera NFS-e síncrona; com
  `subst/chSubstda` cancela a original por substituição) · `GET /nfse/{chave}` (XML) · `GET|HEAD /dps/{id}`
  (chave a partir do id da DPS; só o ator) · `POST /nfse/{chave}/eventos` · `GET .../eventos[/{tipo}[/{seq}]]`
  · `GET /danfse/{chave}` — **API de DANFSe SUSPENSA em 03/08/2026 (NT 008): o ERP gera o PDF**.
- ADN contribuintes — `https://adn.nfse.gov.br/contribuintes/...` (e `adn.producaorestrita...`):
  `GET /DFe/{NSU}` (lotes de até 50, esperar ≥ 1 h quando `ultNSU == maxNSU`; NÃO distribui documentos
  emitidos pela própria empresa — só onde ela é tomadora/intermediária) · `GET /NFSe/{chave}/Eventos`.
- Parametrização municipal: `https://adn.nfse.gov.br/parametrizacao/docs/index.html`.
- Nomes JSON do envelope (`dpsXmlGZipB64` → `nfseXmlGZipB64` + `chaveAcesso`, 201/400/403/409) só em
  fontes **[SEC]** — confirmar no swagger com certificado.

**Autenticação.** TLS **mútuo** com certificado ICP-Brasil A1/A3 (e-CNPJ OID 2.16.76.1.3.3 ou e-CPF
2.16.76.1.3.1; KeyUsage Assinatura Digital + Não Recusa + Autenticação de Cliente; Basic Constraint
false). Assinatura **XMLDSig Enveloped** na tag com `Id` (`infDPS` / `infPedReg`), C14N, só o certificado
final (o manual de 2022 cita RSA-SHA1 — confirmar SHA-256 no XSD v1.01). Regra E0718: CPF/CNPJ do
certificado = `emit/prest` da DPS. **Sem token/OAuth. Sem procuração eletrônica na API** (FAQ §28.1) →
cada cliente emite com o PRÓPRIO e-CNPJ A1 no cofre (`@shared/secret-store`, owner `establishment`).

**Leiaute (XSD v1.01, 09/02/2026).** `infDPS/@Id` = "DPS" + cMun(7) + tpInsc(1) + inscrição(14) +
série(5) + nDPS(15) = 45. **Chave de acesso 50** = cMun(7)+ambGer(1)+tpInsc(1)+inscrição(14)+nNFSe(13)+
AAMM(4)+cód.(9)+DV(1); `infNFSe/@Id` = "NFS"+chave. **Séries do aplicativo próprio: 00001–49999**
(50000+ mobile/web/transcrição). `tpAmb` 1 produção / 2 homologação (E0006 se divergir); `dhEmi` UTC;
`dCompet`; `tpEmit` 1 prestador (2/3 ainda rejeitados — E9996). Grupos: `prest` (CNPJ/CPF, IM,
`regTrib`: `opSimpNac` 1/2/3, `regApTribSN`, `regEspTrib` 0–9) · `toma` · `interm` · **`serv`
SINGULAR** (`locPrest/cLocPrestacao`, `cServ/cTribNac` 6 dígitos do Anexo B, `cTribMun` 3,
`xDescServ`, `cNBS`, `infoCompl`) · `valores` (`vServ`, `vDescIncond`, `vDedRed` → vira `vAjusteBC`
na NT 009, `tribISSQN` 1 tributável/2 imune/3 exportação/4 não incidência, `tpRetISSQN` 1/2/3, `pAliq`
≤ 5 % conferido contra a parametrização do município de incidência, `tribFed/piscofins`, `totTrib`) ·
`IBSCBS` (opcional até a obrigatoriedade) · `subst`. Regras de negócio E0xxx no Anexo I.

**Eventos (Anexo II).** `e101101` Cancelamento (autor emitente, assinado; `cMotivo` 1 erro na emissão /
2 serviço não prestado / 9 outros; `xMotivo` 15–255) · `e105102` Cancelamento por substituição (gerado
pelo sistema; `cMotivo` 01–05/99; E0058 proíbe trocar o tomador) · `e101103` Análise fiscal ·
manifestações `e2022xx` · de ofício `e305101/2/3` (bloqueio impede qualquer cancelamento). Registro é
SÍNCRONO (aceite/rejeição na resposta do POST); depois `GET .../eventos`. **Prazo de cancelamento NÃO é
nacional**: parametrizado pelo município (default 730 dias; fora do prazo E0822 → resta a análise
fiscal); cancelamento e substituição são IRREVERSÍVEIS (Res. 3/2023 art. 7º). **Curitiba: até 60 dias,
sem teto de valor, permitido sem tomador, NÃO cancela após o recolhimento do ISS, justificativa
obrigatória** (manual municipal — conferir o PAM vigente por `GET /parametros_municipais/4106902/convenio`).

**Produção restrita.** Existe para contribuintes (`*.producaorestrita.nfse.gov.br`), mesmas regras de
segurança (mTLS, E0718), `tpAmb = 2`. Nenhum cadastro prévio documentado: o acesso é pelo certificado
(Res. 3/2023 art. 4º: PJ regular no CNPJ e não desautorizada). A confirmar: se o CNPJ/município
precisa constar no CNC da restrita e se a parametrização de Curitiba está replicada lá.

**Reforma tributária (LC 214/2025 — IBS/CBS).** RTC oficial: NTs 001–009, Anexos VI/VII/VIII
(https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/rtc). NT 007 (09/02/2026 em produção):
`indZFMALC`, `tpRetPisCofins`, half-even. NT 009 (jun/2026): CNPJ alfanumérico (vigente 01/07/2026),
`gIBSCBSAjuste`, `vAjusteBC`, nova `vBC` (até 2026 desconta ISS+PIS+COFINS; 2027–2032 só ISS), campos do
SN. **Prazos oficiais (CGNFS-e 07/08/2026)**: destaque IBS/CBS obrigatório em **01/10/2026** para a
lista LC 116 em geral · **01/12/2026** para plataformas, subitens 1.03/1.05/1.09 e 16.01, bens
imateriais, condomínios, locações · **01/01/2027** SN optante pelo destaque · **até 31/12/2026 a
ausência não rejeita a nota**. ME/EPP do SN: a partir de 01/11/2026 só pelo Emissor Nacional. DANFSe:
NT 008 v1.02 (PDF só com dados do XML, bloco IBS/CBS, QR Code ≥ 1,52 cm → consulta pública
https://www.nfse.gov.br/consultapublica).

## Ainda a obter (com certificado ou decisão do Valdo)
- `swagger.json` da Sefin Nacional (produção e restrita) e do ADN contribuintes — 403 sem mTLS.
- Contrato JSON exato do `POST /nfse` (nomes dos campos e códigos HTTP) — só confirmável no swagger.
- Algoritmo de assinatura vigente (SHA-1 × SHA-256) no XSD v1.01 (`nfse-esquemas_xsd-v1-01-20260209.zip`
  — não guardado aqui, baixar junto com o swagger).
- Cronograma de implantação da NT 009 (a NT diz "será publicado") e versão do leiaute resultante.
- Pré-condições da produção restrita para o CNPJ da Setes; rate limits (nada oficial).
- **Decisão de negócio**: subitem LC 116 / `cTribNac`, `cNBS` e `cIndOp` (IBS/CBS) do serviço da Setes.

## URLs oficiais de referência
- Documentação atual (XSD, Anexos I/II/A/B/C, manuais): https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/documentacao-atual
- Produção restrita: https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/producao-restrita
- Atualizações e implantações: https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/atualizacoes-e-implantacoes
- Adesões municipais: https://www.gov.br/nfse/pt-br/municipios/monitoramento-adesoes
- Prazos IBS/CBS: https://www.gov.br/nfse/pt-br/noticias/cgnfs-e-orienta-sobre-os-prazos-para%20destaque-de-ibs-cbs-nas-notas-fiscais-de-servico
- Manual Integrado 2022: https://www.gov.br/nfse/pt-br/biblioteca/eventos_NFS-e/evento-tecnico-setembro-de-2022/manualintegradosnnfse_v1-01-00-homologacao.pdf
