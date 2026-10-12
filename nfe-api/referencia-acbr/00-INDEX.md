# ACBr NF-e — leitura de referência para o planejamento da nfe-api (índice)

**Status**: leitura COMPLETA (2026-10-10) — 5 frentes, 5 relatórios + 1 catálogo de regras como dado
**Origem**: pedido do Valdo (2026-10-10): "vamos fazer o planejamento da api-nfe lendo um componente conhecido do acbr, use os agentes de legacy system"
**Escopo**: setes
**Natureza**: referência de TERCEIRO — ACBr (LGPL 2.1), `D:\Componentes\acbr\Fontes\ACBrDFe\` (change-log de 19/08/2026). É o
motor da NF-e do legado Gestao2016 (`TACBrNFe`). **Nunca substitui o oficial** (MOC, NT, XSD, WSDL — D-NE19: "ACBr local só como
conferência"). Toda regra daqui só vira regra de produção depois de conferida no levantamento oficial da NE-0
(`Infra-IA/nfe-api/integracoes/nfe-sefaz/`).
**Plano que consome esta leitura**: `../../prompts/prompt_onda_nfe_sefaz.md` §12 (ajuste das ondas NE-0…NE-7 + Rodada 2 da nfe-api)

---

## Como foi feito

- Agentes do plugin `code-modernization` (Anthropic) usados como persona — **legacy-analyst** (frentes 01, 02, 03, 05) e
  **business-rules-extractor** (frente 04) — no método da casa `engine-kit/skills/assess-legacy-repo` (fotografia fiel com
  `arquivo:linha`, 7 seções, §8 de insumos FORA da fotografia, §9 de confiança). O **architecture-critic** revisou o plano
  consolidado (§12 do prompt).
- Recorte: ~76 mil linhas do ACBrNFe + ~22 mil da base ACBrDFe. Caminho vigente do XML = `ACBrNFe.XmlWriter`
  (`ACBrComum\ACBr.inc:64` define `USE_ACBr_XMLDOCUMENT`); `pcnNFeW/pcnNFeR` = descarte. Ainda assim o caminho vigente usa
  unidades de `PCNNFe\` (conversões, `pcnProcNFe` na montagem do `nfeProc`, consulta de recibo) — o descarte vale só para os
  writers/readers antigos.
- Nenhum texto com cara de instrução para IA e nenhuma credencial literal nos fontes lidos.
- **Numeração de questões**: os relatórios sugeriram números provisórios (Q-NE27…Q-NE36, Q-NE-S1…S9, Q-RTC1…7) que COLIDEM
  entre si — estão SUPERADOS pela tabela de-para do §12.6 do prompt; vale só a numeração do §12.5 (Q-NE27…Q-NE54).
- **Leitura do catálogo de regras (04)**: depois da revisão do architecture-critic, o catálogo é ÍNDICE para escolher regras, não
  semente a implementar inteira — pré-validação em três camadas (Q-NE43).

## Os relatórios

| # | Arquivo | Frente | Números da seção 7 |
|---|---|---|---|
| 01 | [01-transporte-e-servicos.md](01-transporte-e-servicos.md) | SOAP 1.2, serviços, URLs por UF, máquina de envio, cStat, TLS, contingência, arquivos | 11 classes de serviço (9 SEFAZ 4.00 + EPEC NFC-e SP); INI com 127 seções/72 redirecionamentos/307 URLs; 55: 10 SEFAZ próprias + 16 SVRS + 1 SVAN; 21 cStat tratados; 27 pendências (1 🔴) |
| 02 | [02-modelo-xml-chave-assinatura.md](02-modelo-xml-chave-assinatura.md) | Modelo 4.00 → XML por grupo, formatação, chave 44/cDV, assinatura, XSD | 21 grupos sob `infNFe` (19 gerados); 750 campos escritos (+111 IBS/CBS); 21 variantes de ICMS; 24 pendências; **§8.1 = tabela "fato que a nfe-api lê do ERP por grupo"** |
| 03 | [03-ibs-cbs-rtc.md](03-ibs-cbs-rtc.md) | IBS/CBS/IS na NF-e **e** no DPS da NFS-e Padrão Nacional | 42 unidades RTC na NF-e; 10 no IBSCBS do DPS; 15 eventos RTC (todos à SVRS); 22 pendências (2 🔴) |
| 04 | [04-regras-validacao-local.md](04-regras-validacao-local.md) + [.json](04-regras-validacao-local.json) | Regras de validação pré-SEFAZ como Rule Cards (Given/When/Then) | **198 regras** (151 Alta / 43 Média / 4 Baixa), 158 cStat citados; .md e .json 1:1 conferidos por programa |
| 05 | [05-eventos-inutilizacao-danfe.md](05-eventos-inutilizacao-danfe.md) | Eventos (110111/110110/…), inutilização, consulta de situação, DANFE A4, e-mail | 11 mensagens; 18 blocos do DANFE; 30 pendências (0 🔴) |
| 06 | [06-leitura-deterministica.md](06-leitura-deterministica.md) | **Leitura DETERMINÍSTICA (2026-10-12)** — grafo graphify (sem LLM) + varredura por script, mesmo recorte; confronto com 01–05 | 130 arquivos · 4.944 nós · 7.876 arestas; **8 pontos conferidos, 0 desmentidos**; consequência: casamento por nome e CDATA = parâmetro do leitor do núcleo (Q-NE72) |

> **Sobre a confiabilidade de 01–05**: a leitura de 10/10 foi feita por AGENTES (afirmação com `arquivo:linha`, cobertura não garantida). Em
> 2026-10-12 os pontos que pesam nas decisões foram reconferidos de forma determinística no **06** (grafo em `graphify/`, scripts em
> `graphify/scripts/`) — todos se sustentaram. Contagens de 02/04/05 (750 campos, 198 regras, cStat) NÃO foram re-verificadas.

## Conhecimento NEGATIVO — o que o ACBr faz e a nfe-api NÃO deve copiar

> Prioridade máxima (princípio processador × memória: o que não fazer é o que mais se perde). Evidência em cada relatório.

| # | O ACBr… | Consequência | Onde |
|---|---|---|---|
| N1 | não verifica a cadeia do certificado do SERVIDOR da SEFAZ em nenhum caminho (OpenSSL com verificação desligada; WinINet ignora CA/CN/validade) | MITM silencioso; confirma D-NE17 | 01 §8 item 4 |
| N2 | dá lote com N notas como sucesso se QUALQUER uma autorizar; o desvio "103 em envio síncrono → consultar recibo" é código morto | perda de desfecho; base da regra "1 NF-e por lote, síncrono, 103/105 = P" | 01 §8 item 5 |
| N3 | no síncrono aceita retorno cuja chave não casa com nenhuma nota enviada | resposta não conferida contra a pergunta | 01 §8 item 7 |
| N4 | não trata denegação como desfecho final nem guarda o XML da denegada | nota registrada no fisco sem prova local | 01 §8 item 6 |
| N5 | não trata 204/539/656/108/109/999 — fica com a aplicação | duplicidade e consumo indevido sem política | 01 §7 |
| N6 | roteia SVC/consulta/evento por configuração GLOBAL, não pela tentativa | pergunta vai ao autorizador errado depois de trocar a configuração | 01 §8 item 9 |
| N7 | fachada de cancelamento devolve sucesso olhando o 128 do LOTE, não o 135/136/155 do EVENTO | evento rejeitado tratado como cancelado | 05 §8 item 1 |
| N8 | monta o `procEventoNFe` a partir do 1º evento do lote | lote com >1 evento sai trocado | 05 §8 item 2 |
| N9 | e-mail de evento anexa o XML do PEDIDO, não o proc com protocolo | destinatário recebe documento sem valor | 05 §8 item 20 |
| N10 | `AtualizarXMLCancelado` grava o cancelamento DENTRO do XML da autorização | arquivo autorizado deixa de ser o autorizado | 05 §8 item 8 |
| N11 | fuso é estado global do processo; padrão = fuso do SO; `dhEmi` só ganha o offset | data fiscal errada em servidor fora do fuso | 01 §8 item 14 · 02 §8 item 20 |
| N12 | regras de negócio são OPT-IN (o `Enviar` só valida XSD) — **o Gestao2016 nunca as chamou** | o legado pré-validava só estrutura; regra de negócio voltava como rejeição | 04 §6 D1 · §7 |
| N13 | o gerador MUTA a nota (SEM GTIN, textos de homologação, cNF/cDV/Id, cEnq 999) — validar antes ou depois de assinar dá resultado diferente | regras dependentes de ordem | 04 §6 D6 |
| N14 | obrigatório vazio sai como elemento vazio; nada é truncado nem recusado | rejeição evitável chega à SEFAZ | 02 §8 item 4 |
| N15 | aceita A1 da matriz para a filial comparando só a raiz (8 dígitos) | política implícita — no núcleo é decisão (Q-NE30) | 02 §8 item 9 |
| N16 | dois modelos divergentes da NF-e RTC no mesmo pacote (13 divergências); especificação revertida em 09/07/2026 e reintroduzida em 28/07/2026 | o ACBr NÃO serve como fonte de leiaute da reforma | 03 §8 A2 |
| N17 | leitura do retorno por recorte textual (a SEFAZ-PR devolve atributos com apóstrofo) | parser por regex quebra no PR | 01 §8 item 3 · 05 §8 item 9 |
| N18 | timeout padrão 5 s, igual para todos os serviços | autorização síncrona lenta vira falso erro | 01 §8 item 16 |

## Confirmações — o que o núcleo `fiscal-api` já cobre (sem trabalho novo)

- **Assinatura**: enveloped, C14N inclusiva, rsa-sha1/sha1, `URI="#NFe…"`, só o certificado final, `Signature` último filho do
  pai do elemento assinado — vale para `infNFe`, `infEvento` e `infInut` (`fiscal-api/src/transport/xmldsig.ts`) — 02 §8 item 8,
  05 §8 item 12. (Conferir no MOC se SHA-1 segue exigido.)
- **Fuso**: `nowIsoIn` da zona do estabelecimento serve para `dhEmi`, AAMM da chave e `dhEvento` (`fiscal-api/src/time/zone.ts`).
- **Arquivo fiscal**: `<cnpj>/<H|P>/<ano>/<mês>` com escrita atômica — falta só a convenção de nomes da NF-e.
- **Máquina tentativa × voz** da nfse-api (reserva → fisco fora da transação → A/R/F; ambíguo em voo; reconciliação por
  consulta; reconferência antes do cancelamento) já é o desenho certo — o ACBr não tem nada disso (D-NE13).

## Ponte com o legado Gestao2016 (fatos por grep — a investigação do legado está ENCERRADA, Decisão 65)

- O legado emite NF-e/NFC-e pelo `TACBrNFe` e NFS-e pelo `TACBrNFSeX` (`TFr_geranfe_Srv` no grafo do legado).
- Validava só XSD (`NotasFiscais.Assinar` + `Validar` — `D:\Gestao2016\Tarefas\UN_Principal.pas:3767-3768`;
  `D:\Gestao2016\Ajuda\un_geranfe3X.pas:826-827`); `Registro.Sincrono := 'S'` (`D:\Gestao2016\Ajuda\un_geranfe_Srv.pas:1303`).
- Revisão do ACBr compilada pelo legado: **47865 (19/08/2026)** — posterior ao revert/reintrodução de 28/07/2026 (respondido pela
  fotografia do legado da fase IBS/CBS, `prompts/prompt_fase_ibs_cbs.md` §1.6).
- Perguntas de INTENÇÃO ao dono (opcionais — nenhuma bloqueia o plano): `AtualizarXMLCancelado`/`ValidarDigest` ligados? mais de um evento por lote? opções do DANFE usadas pelos clientes?
  `TB_IBSCBS*` guarda valor calculado pelo legado ou devolvido pelo fisco?
