# ACBr NF-e — leitura DETERMINÍSTICA (graphify + varredura reproduzível) — 2026-10-12

**Escopo**: misto (método: leitura de repositório legado por grafo estrutural + varredura por script, sem LLM — portável; conteúdo: o ACBr para a nfe-api)
**Pedido**: Valdo, 2026-10-12, antes de decidir a Q-NE72…Q-NE74 (`../../prompts/prompt_onda_nfe_sefaz.md` §12.9.7): "faça a leitura
determinística do ACBrNFe antes de decidir usando o graphify" — a leitura de 2026-10-10 (relatórios 01–05) foi feita por AGENTES de IA.
**Natureza**: referência de TERCEIRO (ACBr, LGPL 2.1, cópia de trabalho SVN em `D:\Componentes\acbr\Fontes\` — nada foi gravado lá).
Nunca substitui o oficial (D-NE19).

## Como foi feito (reproduzível)

| Peça | O quê |
|---|---|
| Grafo | graphify, extração ESTRUTURAL só (Part A da skill — sem LLM, 0 tokens, 100 % EXTRACTED). Sem `tree-sitter-pascal` instalado → o graphify usou o extrator Pascal por REGEX dele (determinístico). Saída em `graphify/graphify-out/` (`graph.json`, `GRAPH_REPORT.md`; `graph.html` e `cache/` são regeneráveis — `.gitignore`) |
| Recorte | o MESMO da leitura de 10/10: `ACBrDFe\ACBrNFe\**` (60 `.pas` + 11 `.dfm` + 11 `.lfm`) + `ACBrDFe\*.pas` (31, base) + `ACBrLibXML2\*.pas` (2) + `PCNComum\*.pas` (15) = **130 arquivos** |
| Números | **4.944 nós · 7.876 arestas · 368 comunidades** (rótulo determinístico = unit dominante); relações: 2.950 `method`, 2.374 `calls`, 1.782 `contains`, 421 `imports`, 319 `inherits`, 30 `references`; nenhum ciclo de import |
| Varredura | `graphify/scripts/acbr_scan.py` + padrões fixos (`acbr_patterns_xml.json`, `acbr_patterns_var.json`) sobre os 110 `.pas` do recorte + `ACBrComum\ACBr.inc` + `ACBrComum\ACBrUtil.XMLHTML.pas`, comentários Pascal removidos (exceto onde o padrão é o próprio comentário). Saídas: `graphify/scan_xml.json`, `graphify/scan_var.json` |
| Reproduzir | `python -I graphify/scripts/acbr_graph_build.py <pasta>` → `acbr_graph_label.py <pasta>` → `graphify export html`; `python -I graphify/scripts/acbr_scan.py <padroes.json>`; consultas: `acbr_graph_query.py graph.json inherits|importers|callers|methods …` |

**Limites (honestos)**: (1) o extrator por regex NÃO registra chamada a símbolo FORA do recorte (ex.: `SeparaDados` do `ACBrUtil`) — por isso a
varredura complementa; (2) **1.015 imports pendentes** (units fora do recorte — `SysUtils`, `ACBrUtil.*` — e units ENTRE pastas que o resolvedor não
casou: `ACBrXmlDocument` ×13, `pcnConversao` ×51); (3) NÃO foram re-verificadas aqui as contagens dos relatórios 02/04/05 (750 campos, 198 regras,
cStat tratados) — só os pontos abaixo, escolhidos por pesarem nas decisões abertas.

## Confronto com a leitura por agentes (2026-10-10)

| # | Afirmação da leitura por agentes | Resultado determinístico | Evidência |
|---|---|---|---|
| 1 | 11 classes de serviço (`01` §2) | ✅ **confirmado** — 11 herdeiros diretos de `TNFeWebService` (que herda de `TDFeWebService`) | grafo, `inherits`: `ACBrNFeWebServices.pas:96` (StatusServico) · `:133` Recepcao · `:189` RetRecepcao · `:245` Recibo · `:290` Consulta · `:346` Inutilizacao · `:404` ConsultaCadastro · `:456` EnvEvento · `:493` AdministrarCSCNFCe · `:524` DistribuicaoDFe · `:564` EnvioWebService |
| 2 | caminho vigente do XML = `ACBrXmlDocument` (`USE_ACBr_XMLDOCUMENT`) | ✅ **confirmado, com o recorte exato**: libxml2 (`TACBrXmlDocument.LoadFromXml`) lê a NF-e (`ACBrNFe.XmlReader.pas:172`), consulta de situação (`ACBrNFe.RetConsSit.pas:182`), evento (`ACBrNFe.RetEnvEvento.pas:724`), inutilização (`ACBrNFe.RetInut.pas:123`, `ACBrNFe.Inut.pas:221`) e CSC (`ACBrNFe.RetAdmCSC.pas:159`) | `ACBrComum\ACBr.inc:64` `{$DEFINE USE_ACBr_XMLDOCUMENT}` |
| 3 | parte do caminho vigente ainda usa PCN (consulta de recibo) | ✅ **confirmado e ampliado**: o leitor TEXTUAL `TLeitor` (`pcnLeitor.pas:67`, busca por `Pos`) ainda lê o retorno do LOTE/autorização (`pcnRetEnvNFe.pas:100`), do RECIBO (`pcnRetConsReciDFe.pas:133`), status (`pcnRetConsStatServ.pas:96`), cadastro (`pcnRetConsCad.pas:159`) e DistDFe (`pcnRetDistDFeInt.pas:457`); o próprio ACBr marca a dívida: "deve ser removida quando for refatorado para usar ACBrXMLDocument" (`ACBrNFeWebServices.pas:1624`) | varredura `pcn_leitor` (38) |
| 4 | a resposta SOAP é extraída por busca TEXTUAL (`SeparaDadosArray`, case-insensitive, tolera prefixo) | ✅ **confirmado** — nos 11 serviços: `ACBrNFeWebServices.pas:868, 1182, 1617, 1975, 2242, 2774, 2991, 3749, 3921, 4072` + `SeparaDados(…, 'soap:Body')` `:4260`; `SeparaDados` = `Pos('<'+chave)` em maiúsculas, com 2ª tentativa achando o PREFIXO (`ACBrUtil.XMLHTML.pas:398-450`) | varredura `separa_dados` (36) |
| 5 | N17 — SEFAZ-PR devolve atributos com apóstrofo; leitura por recorte quebra | ✅ **confirmado como está no código** (é COMENTÁRIO, não fato verificável da SEFAZ): `ACBrNFeWebServices.pas:2482-2485` troca TODO `'` por `"` no `protNFe` (INF: altera também apóstrofo de CONTEÚDO); `TLeitor.rAtributo` aceita as DUAS aspas (`pcnLeitor.pas:398-407`); já `RetornarConteudoEntre(…, 'versao="', '"')` só aceita aspas duplas (`ACBrNFeWebServices.pas:2514, 2576`) — o mesmo componente trata a variação num lugar e não no outro | varredura `apostrofo_comment`, `retornar_conteudo_entre` |
| 6 | tags com PREFIXO em algumas SEFAZ | ✅ **confirmado**: correções "para WebServices do Ceará/MG" no leitor textual (`pcnLeitor.pas:168, 178, 188`); o caminho do parser casa por nome LOCAL em qualquer namespace (`FindAnyNs` — 249 ocorrências no recorte, ex.: `ACBrNFe.RetConsSit.pas:189-245`) | varredura `regional_fix`, `prefix_tag` |
| 7 | CDATA no `qrCode` da NFC-e (relatório `02`, linhas 137 e 394 — XD:456-461, W:387-388) | ✅ **confirmado**: o escritor põe CDATA (`ACBrNFe.XmlWriter.pas:388`) e o LEITOR não decodifica — tira o marcador por `StringReplace` (`ACBrNFe.XmlReader.pas:1698`, `pcnNFeR.pas:1222`) | varredura `cdata` (37) |
| 8 | N1 — a cadeia do certificado do SERVIDOR não é verificada | ✅ **confirmado**: OpenSSL — a linha `VerifyCert` está COMENTADA (`ACBrDFeHttpOpenSSL.pas:200`) e o padrão do Synapse é NÃO verificar (`Terceiros\synalist\blcksock.pas:4190` `FVerifyCert := False`); WinINet — liga `IGNORE_UNKNOWN_CA`, `CERT_CN_INVALID`, `CERT_DATE_INVALID`, `REVOCATION`, `WRONG_USAGE` (`ACBrDFeHttpIndy.pas:227-232`) | varredura `tls_verify` + leitura das linhas |

**Veredito**: nos 8 pontos conferidos a leitura por agentes de 10/10 **se sustenta** (nenhuma afirmação desmentida; números e linhas batem). O
que a leitura determinística ACRESCENTA é precisão e uma consequência de DESENHO (abaixo).

## O que muda nas decisões abertas (§12.9.7 do prompt da NF-e)

- **Q-NE72 (N17 — leitor XML do núcleo)**: a evidência reforça o PARSER (o próprio ACBr migra para libxml2 e o que sobrou de leitura textual
  acumula remendos por UF: apóstrofo do PR, prefixo de CE/MG). **Consequência nova**: as regras "casar pelo NOME QUALIFICADO" e "CDATA = recusa"
  NÃO podem ser regra do NÚCLEO — servem à família NFS-e (saída idêntica à regex de hoje), mas a família NF-e vai precisar de nome LOCAL em
  qualquer namespace (CE/MG — item 6) e de ler CDATA (qrCode da NFC-e — item 7). O leitor do núcleo expõe as duas regras como PARÂMETRO da
  leitura; a família escolhe. (Corrige o parecer do guardião da parte 2, letra F — "não casar por localName" vale para a NFS-e, não para o núcleo.)
- **Q-NE73 (nome `erpLegacy`) e Q-NE74 (escritor exige a trava pelo tipo)**: independem do ACBr — tratam só do código do núcleo e da nfse-api.
  (O ACBr não tem habilitação, tentativa × voz nem trava em banco: nenhuma unit de banco de dados é importada no recorte.)
- **D-NE57 (cadeia do servidor — já decidida)**: o item 8 confirma o conhecimento negativo N1 com evidência de código; nada muda na decisão.
