# ACBr — IBS/CBS (Reforma Tributária do Consumo) na NF-e e na NFS-e Padrão Nacional
**Escopo**: setes
**Natureza**: referência de TERCEIRO — ACBr (LGPL 2.1), motor da NF-e no legado Gestao2016; nunca substitui o oficial (NT/IT/XSD/Ato Conjunto)
**Fonte**: D:\Componentes\acbr\Fontes\ACBrDFe\ (change-log 19/08/2026) · leitura de 2026-10-10
**Agente**: legacy-analyst (plugin code-modernization) no método assess-legacy-repo

> **Como ler**: §1–§7 são FOTOGRAFIA (só o que está no código, com `arquivo:linha` relativo a `ACBrDFe\`).
> §8 é INSUMO de planejamento, fora da fotografia. §9 = confiança e lacunas.
> Abreviações de caminho fora de `ACBrDFe\`: `[XSD-ACBr]` = `D:\Componentes\acbr\Exemplos\ACBrDFe\Schemas\`
> (cópia de XSD empacotada pelo ACBr — também terceiro, versão não declarada no arquivo);
> `[nfse-api]` = `D:\Gestao2027\nfse-api\` (só no §8). `..\ACBrComum\` = `D:\Componentes\acbr\Fontes\ACBrComum\`.
> Licença: o documento descreve COMPORTAMENTO e REGRAS; nenhum bloco de código transcrito.

## 0. Recorte, descartes e convenção de leitura

- **Lido**: `ACBrDFe.RTC.Classes.pas` (1.648 l.), `ACBrDFe.RTC.XmlWriter.pas` (1.231), `ACBrDFe.RTC.XmlReader.pas` (725, só
  conferência), trechos RTC de `ACBrNFe\Base\ACBrNFe.Classes.pas` (5.965) e `ACBrNFe\Base\ACBrNFe.XmlWriter.pas` (4.926),
  enums em `ACBrDFe.Conversao.pas` e `ACBrNFe\Base\ACBrNFe.Conversao.pas`, `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas`,
  catálogo de eventos em `ACBrNFe\Base\Servicos\ACBrNFe.EventoClass.pas`/`ACBrNFe.EnvEvento.pas` e o roteamento em
  `ACBrNFe\ACBrNFeWebServices.pas`; NFS-e: `ACBrNFSeX\Base\ACBrNFSeXClass.pas`, `ACBrNFSeX\Base\ACBrNFSeXConversao.pas`,
  `ACBrNFSeX\Base\Provedores\ACBrNFSeXGravarXml.pas`/`ACBrNFSeXLerXml.pas`, `ACBrNFSeX\Provedores\PadraoNacional.GravarXml.pas`/
  `.LerXml.pas`/`.Provider.pas`; os três change-logs (`ACBrNFe\ACBrNFe-change-log.txt`, `ACBrDFe-change-log.txt`,
  `ACBrNFSeX\ACBrNFSeX-change-log.txt`); a semântica do `AddNode` em `ACBrXmlWriter.pas:243-460`.
- **Descartado** (regra do caso): `PCNNFe\`/`pcn*`, `*IniReader/*IniWriter/*JSON*`, relatórios (DANFE/DANFSe), `__recovery\`.
  **Exceção única e justificada**: `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:302-303,1280-1287` foi aberto SÓ para saber qual enum
  de `finNFe` o writer vigente enxerga (achado I-2) — nada mais desse caminho foi usado.
- **Chave de compilação**: as tags da Reforma só são geradas com `USE_ACBr_XMLDOCUMENT` ligado — o próprio comentário diz
  que, desligado, "não será gerado nos XML" (`..\ACBrComum\ACBr.inc:61-64`).
- **Convenção `AddNode`** (todas as tabelas de §3 usam): parâmetros = tipo, ID do leiaute, tag, tamanho mín–máx, ocorrência,
  valor (`ACBrXmlWriter.pas:243-246`). Em `tcDeN` (N casas decimais) mín/máx contam dígitos SEM o separador
  (`ACBrXmlWriter.pas:338-345`); ex.: `Dec4 1-7` = até 3 inteiros + 4 decimais. Ocorrência 0 com valor zero/vazio ⇒ **tag
  omitida** (`:369`, `:449`); ocorrência 1 com vazio ⇒ tag vazia criada + alerta (`:423-424`, `:442-446`); tamanho
  estourado ⇒ **alerta** na lista, nunca exceção (`:430-437`). Nas tabelas: **Oc 1** = obrigatório no writer; **Oc 0** = opcional.

---

## 1. Visão geral

O ACBr tem **três modelos distintos** de IBS/CBS no mesmo pacote: (a) o da NF-e/NFC-e, autocontido em `ACBrNFe.Classes` +
`ACBrNFe.XmlWriter`; (b) a unit "comum" `ACBrDFe.RTC.*` (criada em 02/07/2026), usada hoje só por BP-e, NFAg e NFGas, que traz
um ramo rotulado "Usado pela NF-e" **sem consumidor na NF-e** e com 13 divergências em relação a (a); (c) o da NFS-e
(`ACBrNFSeX`), que o change-log diz que nunca usará a unit comum. Os três compartilham só os ENUMERADOS de
`ACBrDFe.Conversao` (CST 19 valores, cCredPres 01–13, tpEnteGov, tpOperGov). O componente **não calcula nada**: grava o que
recebe (itens e totais) e só decide QUAIS grupos emitir — por CST, por modelo (55 × 65), por presença de valor > 0 e por
finalidade. Na NFS-e Padrão Nacional o DPS leva só **classificação e contexto** (CST, cClassTrib, cIndOp, finNFSe…), sem
alíquota nem valor; os valores voltam calculados pelo fisco no `infNFSe/IBSCBS`. **Nenhum ramo do IBS/CBS olha o regime do
Simples** (nem CRT na NF-e, nem opSimpNac no DPS). Eventos da Reforma na NF-e (15 códigos) vão todos à **SVRS**.

---

## 2. Inventário de componentes

### 2.1 Modelos (classes)

| Unidade | Responsabilidade | Dependências | Status |
|---|---|---|---|
| `ACBrNFe\Base\ACBrNFe.Classes.pas` (RTC em 188-220, 252-303, 1041-1042/1098-1099, 1440-1922, 1937-1977, 2134-2281) | modelo IBS/CBS/IS da NF-e e NFC-e (ide, prod, det, imposto, total) | `ACBrDFe.Conversao`, `ACBrNFe.Conversao`, `pcnConversao`, `pcnConversaoNFe` (uses `:50-53`) | ✅ |
| `ACBrDFe.RTC.Classes.pas` (1-1648) | modelo "comum" (ide, item, totais, pgtoVinc); classes marcadas "Usado por: BPe, CTe, NF3e, NFAg, NFCom, NFGas" (`:136`) e "Usado por: NFe" (`:159`) | `ACBrDFe.Conversao` (`:48`) | ⚠️ ramo NF-e sem consumidor |
| `ACBrNFSeX\Base\ACBrNFSeXClass.pas` (lado NFS-e 1559-1845; lado DPS 1979-2275) | DPS (declarado) + NFS-e (gerado pelo fisco) | `ACBrDFe.Conversao`, `ACBrNFSeXConversao` (`:52-53`) | ✅ |
| `ACBrCTe\Base\ACBrCTe.Classes.pas:226/250`, `ACBrNF3e\Base\ACBrNF3eClass.pas:221/245`, `ACBrNFCom\Base\ACBrNFComClass.pas:220/244` | modelos próprios de cada família | — | ⚠️ localizados, NÃO lidos |

### 2.2 Enumerados / conversões

| Unidade | Conteúdo RTC | Status |
|---|---|---|
| `ACBrDFe.Conversao.pas` | `TModelosDFe` (`:44-45`); `TACBrTipoEvento` + códigos (`:93-144`); `TIndicadorEx` (`:205-208`); `TtpNFDebito` (`:558-565`); `TtpEnteGov` (`:568-573`); `TtpOperGov` (`:576-580`); `TCSTIBSCBS` (`:583-590`); `TcCredPres` (`:593-598`); `TIndAceitacao` (`:609-612`); `TTpCredPresIBSZFM` (`:615-620`); `TtpPagAnt` (`:623-627`); `TtpALCZFMCBS` (`:630-633`) | ✅ |
| `ACBrNFe\Base\ACBrNFe.Conversao.pas` | `TpcnFinalidadeNFe` só 1–4 (`:291-295`, `:1261-1271`); `TtpNFDebito` DUPLICADO (`:408-415`); `TtpNFCredito` (`:418-423`); `TCSTIS` sem uso (`:426-431`); `TTpCredPresIBSZFM` DUPLICADO (`:434-439`); códigos de evento (`:1139-1172`) | ⚠️ (I-2, I-3, I-13) |
| `ACBrNFe\PCNNFe\pcnConversaoNFe.pas` (exceção do descarte) | `TpcnFinalidadeNFe` com 5 crédito / 6 débito (`:302-303`, `:1280-1287`) — é o que o writer enxerga | ⚠️ (I-2) |
| `ACBrNFSeX\Base\ACBrNFSeXConversao.pas` | `TOptanteSN` (`:387-392`), `TRegimeApuracaoSN` (`:395-400`), `TfinNFSe` (`:688-693`), `TindFinal` (`:696-699`), `TindDest` (`:702-705`), `TtipoChaveDFe` (`:708-712`), `TtpReeRepRes` (`:715-719`), `TindCompGov` (`:722-725`), `TtpOperGovNFSe` (`:728-734`) | ✅ |

### 2.3 Escrita / leitura de XML

| Unidade | Responsabilidade | Status |
|---|---|---|
| `ACBrNFe\Base\ACBrNFe.XmlWriter.pas` (RTC: `:92`, `:337`, `:539-644`, `:1180-1184`, `:1263-1264`, `:1314-1317`, `:1895-1942`, `:3548-3554`, `:4214-4924`) | gera ide/prod/det/imposto/total RTC da NF-e e NFC-e | ✅ |
| `ACBrDFe.RTC.XmlWriter.pas` | gerador comum, com despacho por `ModelosDFe` (`:242-265`) | ✅ p/ BPe/NFAg/NFGas · ⚠️ ramo NF-e sem consumidor |
| `ACBrDFe.RTC.XmlReader.pas` | leitura do comum | ⚠️ (I-9, I-10) |
| `ACBrNFSeX\Base\Provedores\ACBrNFSeXGravarXml.pas` (`:1660-2170`, padrões `:378-401`) | IBSCBS do DPS (completo) e da NFS-e (parcial) | ✅ DPS · ⚠️ NFS-e |
| `ACBrNFSeX\Provedores\PadraoNacional.GravarXml.pas` (`:539-625`, `:688-693`, `:815-828`, `:1733-1786`) | encaixe do IBSCBS no infDPS/infNFSe, regTrib, totTrib | ✅ |
| `ACBrNFSeX\Base\Provedores\ACBrNFSeXLerXml.pas` (`:1656-2076`) + `PadraoNacional.LerXml.pas:860,989-993` | leitura DPS e NFS-e (valores do fisco) | ✅ |

### 2.4 Regras de negócio / validação local

| Unidade | Conteúdo | Status |
|---|---|---|
| `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas` | NENHUMA regra de IBS/CBS/IS (grep sem ocorrência); a regra 321 passou a aceitar `DFeReferenciado` por item como alternativa ao `NFref` na devolução (`:1233-1252`; change-log 19/09/2025, `ACBrNFe\ACBrNFe-change-log.txt:446-449`) | ⚠️ sem regras RTC |
| `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1895-1935` | regra B25-80 / rejeição 1001 implementada como SUPRESSÃO de grupos no writer (§3.5) | ✅ |

### 2.5 Eventos da Reforma (NF-e)

| Unidade | Conteúdo | Status |
|---|---|---|
| `ACBrNFe\Base\Servicos\ACBrNFe.EventoClass.pas:761-775` | descrições dos 15 eventos RTC | ✅ |
| `ACBrNFe\Base\Servicos\ACBrNFe.EnvEvento.pas:1059-1087` | despacho tpEvento → gerador do `detEvento` | ✅ |
| `ACBrNFe\ACBrNFeWebServices.pas:3151-3160` | roteamento: todos os 15 vão à **SVRS** com layout `LayNFeEvento` | ✅ |

### 2.6 Quem usa o quê (comum × específico)

| DF-e | Modelo IBS/CBS | Usa `ACBrDFe.RTC.*`? | Evidência |
|---|---|---|---|
| NF-e 55 / NFC-e 65 | próprio (`ACBrNFe.Classes.pas:1855`) | **não** (0 arquivos de `ACBrNFe\` citam a unit) | grep; RTC só tem o ramo pronto (`ACBrDFe.RTC.XmlWriter.pas:343-376`) |
| BP-e | comum | sim (7 arquivos) | `ACBrBPe\Base\ACBrBPeXmlWriter.pas:923,1409` |
| NFAg | comum | sim (5) | `ACBrNFAg\Base\ACBrNFAg.XmlWriter.pas:879,1079` |
| NFGas | comum | sim (5) | `ACBrNFGas\Base\ACBrNFGas.IniWriter.pas:144` |
| CT-e, NF3e, NFCom | próprios | não | §2.1 |
| NFS-e (ACBrNFSeX) | próprio (`ACBrNFSeXClass.pas:2003`, `:2232`) | não — e "com exceção da NFS-e" no plano (`ACBrDFe-change-log.txt:85-88`) | — |
| MDF-e, DC-e | sem IBSCBS | — | grep 0 arquivos |

O que é de fato COMUM aos DF-e: os enumerados de `ACBrDFe.Conversao` (CST, cCredPres, tpEnteGov, tpOperGov, tpNFDebito,
TpCredPresIBSZFM, tpALCZFMCBS) e as constantes de descrição de `ACBrDFeConsts` (centralizadas em 09/06/2025,
`ACBrDFe-change-log.txt:293-300`). Estrutura de classes e writer: cada família tem a sua (exceto BPe/NFAg/NFGas).

---

## 3. Mapa modelo RTC → XML (central)

### 3.1 NF-e — grupo `ide` (`ACBrNFe.Classes.pas:188-303` → `ACBrNFe.XmlWriter.pas`)

| Campo | Modelo | Writer (ID) | Tipo/Tam | Oc | Quando é gerado |
|---|---|---|---|---|---|
| `dPrevEntrega` | `TIde.dPrevEntrega` `:297` | `:539-540` (B09) | data 10 | 0 | sempre chamado; omitido se data vazia |
| `cMunFGIBS` | `:298` | `:556-563` (B12a) | int 7 | 0 | só se > 0; município inválido ⇒ alerta |
| `finNFe` 5/6 | `:287` | `:582-583` (B25) | str 1 | 1 | valores 1–6 vêm de `pcnConversaoNFe` (I-2) |
| `tpNFDebito` | `:299` | `:586-590` (B25a) | str 2 | 0 | versão ≥ 4 **e** finNFe = débito |
| `tpNFCredito` | `:300` | `:592-594` (B25b) | str 2 | 0 | versão ≥ 4 **e** finNFe = crédito |
| `cIndOp` | `:291` | `:610-611` (B25c) | numStr 6 | 0 | versão ≥ 4 (sem marca "Reforma" no código — I-21) |
| `gCompraGov` | `TgCompraGov` `:189-207`, `:302` | `:4215-4242` (BB02-BB05) | ver abaixo | — | só se tpEnteGov ≠ nenhum **e** tpOperGov ≠ nenhum (`:4221-4222`) |
| ↳ `tpEnteGov` | | BB02 | str 1 | 1 | 1–6 (`ACBrDFe.Conversao.pas:568-573`) |
| ↳ `pRedutor` | | BB03 | Dec4 1-7 | 1 | |
| ↳ `tpOperGov` | | BB04 | str 1 | 1 | 1–4 (`:576-580`) |
| ↳ `refDFeAnt` | `TDFErefCollection` | BB05 (0..n) | str 44 | 1 por item | um por chave da lista |
| `gPagAntecipado` | `:209-220`, `:303` | `:4244-4261` (BC02 `refNFe`) | str 44 (0..n) | 1 por item | só se a lista > 0 (change-log 30/06/2026, `:102-105`); sem alerta de máximo (I-19) |

Ordem de emissão no `ide`: `gCompraGov` e `gPagAntecipado` são os ÚLTIMOS filhos, depois dos `NFref` (`:642-644`).

### 3.2 NF-e — `prod` e `det`

| Campo | Modelo | Writer (ID) | Tipo/Tam | Oc | Quando |
|---|---|---|---|---|---|
| `tpCredPresIBSZFM` (prod) | `TProd` `:1042/1099` | `:1263-1264` (I06) | str 1 | 0 | omitido quando "nenhum" (string vazia); valores 0–4 (`ACBrDFe.Conversao.pas:615-620`) |
| `indBemMovelUsado` (prod) | `:1041/1098` (`TIndicadorEx`, default nenhum) | `:1314-1317` (I17c) | str 1 | 1 | só versão ≥ 4 **e** = Sim (grava "1") |
| `vItem` (det) | `TDetCollectionItem` `:1960/1976` (Currency) | `:1180-1182` (V01) | Dec2 1-15 | 0 | omitido se 0 — **recebido pronto** |
| `DFeReferenciado` (det) | `:1937-1947`, `:1977` | `:4761-4778` | `chaveAcesso` str 44 Oc1 (VB02) · `nItem` int 1-3 Oc0 (VB03) | — | só se a chave não for vazia; chave inválida ⇒ alerta (`:4772-4773`) |

### 3.3 NF-e — supressão dos tributos atuais (regra B25-80 / rejeição 1001)

`GerarDetImposto` (`ACBrNFe.XmlWriter.pas:1889-1943`) só escreve ICMS/IPI/II (ou ISSQN), PIS, PISST, COFINS, COFINSST e
ICMSUFDest quando: **(finNFe não é crédito nem débito E tpOperGov ≠ 2-Recebimento do pagamento)** OU tpNFCredito ∈ {03 retorno
recusa total, 04 redução de valores, 06 retorno recusa parcial} OU tpNFDebito ∈ {06 pagamento antecipado, 07 perda em
estoque} (`:1910-1913`). O comentário cita literalmente "NT 2025.002 v1.40 - Validação B25-80 / Rejeição 1001" e registra que
a versão anterior só tratava tpNFCredito 03 (`:1895-1909`). `IS` e `IBSCBS` são escritos SEMPRE, depois (`:1937-1942`).

### 3.4 NF-e — Imposto Seletivo `IS` (`ACBrNFe.Classes.pas:1440-1466` → `ACBrNFe.XmlWriter.pas:4263-4300`)

Gatilho externo: `CSTIS` ≠ '' **e** `vBCIS` > 0 (`:1938-1940`).

| Campo | Modelo | ID | Tipo/Tam | Oc | Observação |
|---|---|---|---|---|---|
| `CSTIS` | string (`:1446`) | UB03 | str 3 | 1 | comentário: string "até a publicação de uma tabela de CSTs oficial para o IS" (`:1444`, `:4267`) |
| `cClassTribIS` | `:1447` | UB04 | str 6 | 1 | |
| `vBCIS` | `:1448` | UB06 | Dec2 1-15 | 1 | bloco de valores só se vBCIS/pIS/uTrib/qTrib/vIS preenchido (`:4276-4277`) |
| `pIS` | `:1449` | UB07 | Dec2 1-5 | 1 | |
| `adRemIS` | `:1450` | UB08 | Dec2 1-5 | 0 | (descrição reaproveita `DSC_PIMPSELESPEC`) |
| `uTrib` / `qTrib` | `:1451-1452` | UB09 / UB10 | str 1-6 Oc1 / Dec4 1-15 Oc0 | | só se uTrib ou qTrib (`:4288-4295`) |
| `vIS` | `:1453` | UB11 | Dec2 1-15 | 1 | |

### 3.5 NF-e — grupo `IBSCBS` do item: raiz e despacho por CST (`ACBrNFe.XmlWriter.pas:4302-4358`)

Gatilho: `CST` ≠ nenhum **e** `cClassTrib` ≠ '' (`:4306`); ao gerar, liga a flag que fará nascer `IBSCBSTot` (`:4308`).

| Campo | Modelo (`TIBSCBS` `:1853-1885`) | ID | Tipo/Tam | Oc | Observação |
|---|---|---|---|---|---|
| `CST` | `TCSTIBSCBS` | UB12 | str 3 | 1 | obrigatórios desde 14/08/2025 (change-log `:519-523`) |
| `cClassTrib` | **string livre** | UB13 | str 6 | 1 | deixou de ser enumerado em 19/08/2025 (`:514-517`) — nenhuma validação contra tabela (I-4) |
| `indDoacao` | `TIndicadorEx` | '#3' | str 1 | 0 | só se = Sim, grava "1" (`:4317-4319`) |

| CST | Modelo 55 | Modelo 65 | Subgrupo gerado |
|---|---|---|---|
| 000, 200, 220, 510 | sim | sim | `gIBSCBS` (`:4322-4323`) |
| 515, 550, 830 | sim | **nada** | `gIBSCBS` (`:4325-4327`) |
| 620 | sim | sim | `gIBSCBSMono` (`:4329-4330`) |
| 800 | sim | **nada** | `gTransfCred` (`:4332-4334`) |
| 811 | sim | **nada** | `gAjusteCompet` (`:4336-4338`) |
| 010, 011, 221, 222, 400, 410, 810, 820 | — | — | nenhum (só CST + cClassTrib). Comentário `:4341-4347`: 010/011 alíquotas uniformes (NFS-e e DERE), 221 alíquota fixa rateada (NFS-e), 222 redução de base (BP-e), 400 isenção (NFS-e/BPeTM), 410 "não se calcula", 820 regime específico (NFS-e). **810 sem comentário** (I-15) |

Ainda dentro do gatilho (`:4349-4356`): `gEstornoCred` se vIBSEstCred > 0 ou vCBSEstCred > 0 ou (modelo 55 e tpNFDebito = 07
perda em estoque); `gCredPresOper` se cCredPres ≠ nenhum, **senão** `gCredPresIBSZFM` se tpCredPresIBSZFM ≠ nenhum
(mutuamente exclusivos).

### 3.6 NF-e — `gIBSCBS` e filhos

| Grupo / campo | Modelo | Writer | ID | Tipo/Tam | Oc | Condição |
|---|---|---|---|---|---|---|
| **gIBSCBS** | `TgIBSCBS` `:1634-1660` | `:4360-4381` | | | | |
| `vBC` | | | UB16 | Dec2 1-15 | 1 | |
| `gIBSUF`, `gIBSMun`, `gCBS` | | | | | | sempre |
| `vIBS` | | | UB35 | Dec2 1-15 | 1 | entre gIBSMun e gCBS |
| `gTribRegular` | | | | | | se CSTReg ≠ nenhum (`:4375-4376`) |
| `gTribCompraGov` | | | | | | se `ide.gCompraGov` presente (`:4378-4379`) |
| **gIBSUF** | `TgIBSUF` `:1520-1540` | `:4383-4403` | | | | |
| `pIBSUF` | | | UB18 | Dec4 1-7 | 1 | |
| `gDif` / `gDevTrib` / `gRed` | | | | | | pDif > 0 / vDevTrib > 0 / (pRedAliq > 0 ou pAliqEfet > 0 ou compra governamental) |
| `vIBSUF` | | | UB35 | Dec2 1-15 | 1 | |
| **gIBSMun** | `TgIBSMun` `:1542-1562` | `:4405-4425` | | mesma forma do gIBSUF (`pIBSMun` Dec4, `vIBSMun` Dec2) | | |
| **gCBS** | `TgCBS` `:1564-1586` | `:4427-4449` | | | | |
| `pCBS` | | | UB61 | Dec4 1-7 | 1 | |
| `gDif` / `gDevTrib` / `gRed` | | | | | | mesmas condições |
| `gALCZFMCBS` | `:1504-1518` | `:4541-4557` | | | | se pAliqEfetRegCBS > 0 ou vTribRegCBS > 0 (`:4444-4445`; opcional desde 01/07/2026, change-log `:97-100`) |
| ↳ `tpALCZFMCBS` · `nProcSuframa` · `pAliqEfetRegCBS` · `vTribRegCBS` | | | UB66b–e | str 1 Oc1 (valores 1/2) · str 8-12 Oc0 · Dec4 1-7 Oc1 · Dec2 1-15 Oc1 | | valores 1/2 corrigidos de 0/1 em 10/07/2026 (`ACBrDFe-change-log.txt:59-62`) |
| `vCBS` | | | UB83 | Dec2 1-15 | 1 | |
| **gDif** | `:1468-1478` | `:4451-4461` | UB22/UB23 | `pDif` Dec4 1-7 · `vDif` Dec2 1-15 | 1/1 | |
| **gDevTrib** | `:1480-1490` | `:4463-4473` | | `pDevTrib` Dec4 1-7 **Oc0** · `vDevTrib` Dec2 1-15 Oc1 | | pDevTrib opcional desde 19/08/2026 (change-log `:47-50`) |
| **gRed** | `:1492-1502` | `:4475-4485` | UB27/UB28 | `pRedAliq` Dec4 1-7 · `pAliqEfet` Dec4 1-7 | 1/1 | |
| **gTribRegular** | `:1588-1611` | `:4487-4515` | '#56'…'#63' | `CSTReg` str 3 · `cClassTribReg` str 6 · `pAliqEfetRegIBSUF` Dec4 · `vTribRegIBSUF` Dec2 · `pAliqEfetRegIBSMun` Dec4 · `vTribRegIBSMun` Dec2 · `pAliqEfetRegCBS` Dec4 · `vTribRegCBS` Dec2 | todos 1 | |
| **gTribCompraGov** | `:1613-1632` | `:4517-4539` | '#1' | `pAliqIBSUF` Dec4 · `vTribIBSUF` Dec2 · `pAliqIBSMun` Dec4 · `vTribIBSMun` Dec2 · `pAliqCBS` Dec4 · `vTribCBS` Dec2 | todos 1 | |

### 3.7 NF-e — monofasia `gIBSCBSMono` (CST 620) (`ACBrNFe.Classes.pas:1662-1760` → `ACBrNFe.XmlWriter.pas:4559-4671`)

| Subgrupo | Gatilho | Campos (ID · tipo · Oc) |
|---|---|---|
| `gMonoPadrao` | adRemIBS, adRemCBS, vIBSMono ou vCBSMono > 0 (`:4564-4565`) — `qBCMono` fora do gatilho (I-20) | qBCMono UB85 Dec4 1-15 Oc0 · adRemIBS UB86 Dec4 1-7 · adRemCBS UB87 Dec4 1-7 · vIBSMono UB88 Dec2 · vCBSMono UB89 Dec2 (`:4595-4614`) |
| `gMonoReten` | algum dos 4 > 0 (`:4570-4571`) | qBCMonoReten Dec4 Oc0 · adRemIBSReten Dec4 · vIBSMonoReten Dec2 · adRemCBSReten Dec4 · vCBSMonoReten Dec2 (`:4616-4634`) |
| `gMonoRet` | algum dos 4 > 0 (`:4576-4577`) | qBCMonoRet Dec4 Oc0 · adRemIBSRet · vIBSMonoRet · adRemCBSRet · vCBSMonoRet (`:4636-4654`) |
| `gMonoDif` | algum dos 4 > 0 (`:4582-4583`) | pDifIBS UB100 Dec4 · vIBSMonoDif UB101 Dec2 · pDifCBS UB102 Dec4 · vCBSMonoDif UB103 Dec2 (`:4656-4671`) |
| (sempre) | — | vTotIBSMonoItem UB104 Dec2 Oc1 · vTotCBSMonoItem UB105 Dec2 Oc1 (`:4588-4592`) |

Forma: IBS e CBS no MESMO subgrupo (adRemIBS + adRemCBS). Confere com o XSD empacotado (`[XSD-ACBr]\NFe\DFeTiposBasicos_v1.00.xsd`
tem `gMonoPadrao`, `adRemCBS`, `gMonoDif`). A unit comum usa outra forma (§3.10, item 9).

### 3.8 NF-e — demais subgrupos do item

| Grupo | Modelo | Writer | Campos |
|---|---|---|---|
| `gTransfCred` (CST 800, só 55) | `:1762-1773` | `:4673-4683` | vIBS UB85 Dec2 · vCBS UB86 Dec2 |
| `gAjusteCompet` (CST 811, só 55) | `:1775-1788` | `:4685-4698` | competApur UB112 str 7 (formato ano-mês "aaaa-mm") · vIBS UB113 · vCBS UB114 |
| `gEstornoCred` | `:1790-1801` | `:4700-4710` | vIBSEstCred Dec2 **1-7** · vCBSEstCred Dec2 1-15 (I-7) |
| `gCredPresOper` | `:1818-1836` | `:4712-4728` | vBCCredPres Dec2 1-15 Oc1 · cCredPres str 2 Oc1 (01–13, `ACBrDFe.Conversao.pas:593-598`) · `gIBSCredPres` se pCredPres > 0 · `gCBSCredPres` se pCredPres > 0 |
| `gIBSCredPres` / `gCBSCredPres` | `:1803-1816` | `:4730-4744` | pCredPres UB57 Dec4 1-7 Oc1 · **vCredPresCondSus** UB59 Dec2 se > 0, **senão vCredPres** UB58 Dec2 (um ou outro — I-22) |
| `gCredPresIBSZFM` | `:1838-1851` | `:4746-4759` | competApur UB132 "aaaa-mm" · tpCredPresIBSZFM UB133 str 1-15 (0–4) · vCredPresIBSZFM UB134 Dec2 |

### 3.9 NF-e — totais (`ACBrNFe.Classes.pas:2134-2281` → `ACBrNFe.XmlWriter.pas:3540-3555, 4780-4924`)

| Grupo | Gatilho | Campos (todos Dec2 1-15) |
|---|---|---|
| `ISTot` | vIS > 0 (`:4784`) | vIS W35 Oc1 |
| `IBSCBSTot` | algum item gerou `IBSCBS` (flag resetada em `:337`, ligada em `:4308`; teste `:4797`) | vBCIBSCBS W35 Oc1 |
| ↳ `gIBS` | vIBS, vDif UF/Mun, vDevTrib UF/Mun, vCredPres ou vCredPresCondSus > 0 (`:4804-4808`) | gIBSUF (vDif W38, vDevTrib W39, vIBSUF W41) · gIBSMun (vDif W43, vDevTrib W44, vIBSMun W46) · vIBS W48 · vCredPres W48 · vCredPresCondSus W49 (`:4824-4869`) |
| ↳ `gCBS` | vCBS, vDif, vDevTrib, vCredPres ou vCredPresCondSus > 0 (`:4810-4812`) | vDif W53 · vDevTrib W54 · vCBS W56 · vCredPres W56a · vCredPresCondSus W56b (`:4871-4889`) |
| ↳ `gMono` | algum dos 6 > 0 (`:4814-4817`) | vIBSMono W58 · vCBSMono W59 · vIBSMonoReten · vCBSMonoReten · vIBSMonoRet · vCBSMonoRet (`:4891-4912`) |
| ↳ `gEstornoCred` | algum > 0 (`:4819-4820`) | vIBSEstCred **1-7** · vCBSEstCred 1-15 (`:4914-4924`) |
| `vNFTot` | sempre chamado (`:3553-3554`) | W60 Oc0 — omitido se 0 |

**Calculado × recebido pronto**: NADA é calculado. O writer só formata. Não há atribuição a `vBCIBSCBS`, `vNFTot`, `vItem` ou
aos `v*` do IBS/CBS em `ACBrNFe\` fora de leitores e de eventos (grep), e nenhuma unidade fora de `Base\` toca `IBSCBSTot`
(grep). A única coisa derivada é a flag de presença do total. Base, alíquotas, valores por item e somatórios são do chamador.

### 3.10 Unit comum `ACBrDFe.RTC.*` × writer vigente da NF-e — divergências

| # | Ponto | `ACBrNFe.XmlWriter` (vigente para NF-e) | `ACBrDFe.RTC.XmlWriter` (ramo NF-e, sem consumidor) |
|---|---|---|---|
| 1 | CSTs → `gIBSCBS` no 55 | 000/200/**220**/510/515/550/830 (`:4321-4327`) | 000/200/510/515/550/830 — sem 220 (`:350-352`) |
| 2 | CSTs no 65 | 000/200/220/510 + 620 (`:4321-4330`) | 000/200 + 620 (`:365-373`) |
| 3 | gatilho `gCompraGov` | tpEnteGov e tpOperGov ≠ nenhum (`:4221-4222`) | pRedutor > 0 (`:753-756`) |
| 4 | `refDFeAnt` em `gCompraGov` | escrito (`:4235-4240`); o XSD empacotado tem o campo (`[XSD-ACBr]\NFe\DFeTiposBasicos_v1.00.xsd:1398`) | ausente da classe e do writer (`ACBrDFe.RTC.Classes.pas:158-172`; `:748-769`) |
| 5 | gatilho `gTribCompraGov` | compra gov no `ide` (`:4378`) | pAliqIBSUF > 0 e tpEnteGov ≠ nenhum (`:404-405`) |
| 6 | `pAliqEfet` (gRed) | Dec4 (`:4483`) | Dec2 (`:509`); leitor também Dec2 (`ACBrDFe.RTC.XmlReader.pas:273`); XSD empacotado = 4 casas (`DFeTiposBasicos_v1.00.xsd:1176`) |
| 7 | `pDevTrib` | Dec4 1-7 Oc0 (`:4468`) | Dec2 1-15 Oc0 (`:494`); XSD empacotado = 4 casas (`:1229`) |
| 8 | alíquota específica do IS | `adRemIS` (`ACBrNFe.Classes.pas:1450`; `:4285`) | `pISEspec` (`ACBrDFe.RTC.Classes.pas:762`; `:814`) |
| 9 | forma da monofasia | gMonoPadrao/Reten/Ret/**Dif**, IBS+CBS juntos (§3.7) | gIBSMonoAdRem/AdValorem + gCBSMonoAdRem/AdValorem, com gpBioDiferenca, **sem** gMonoDif (`ACBrDFe.RTC.Classes.pas:350-630`) |
| 10 | vCredPres/vCredPresCondSus nos totais gIBS/gCBS | escritos (`:4834-4838`, `:4884-4888`) | não escritos (`:628-637`, `:669-681`) embora existam na classe (`ACBrDFe.RTC.Classes.pas:824-825`, `:844-845`) |
| 11 | estorno/crédito presumido | dentro do gatilho do IBSCBS (`:4349-4357`) | FORA do gatilho — acesso a resultado nulo possível (`:266-278`; I-8) |
| 12 | filho de `gPagAntecipado` no ide | `refNFe` (`:4256`) | `Gerar_gPagAntecipadoIde` usa `chDFePagAnt` (`:214`); `Gerar_gPagAntecipado` usa `refNFe` (`:783`) |
| 13 | pagamento antecipado por ITEM | não existe | `gPagAntecipado` com chDFePagAnt + nItemPagAnt (`ACBrDFe.RTC.Classes.pas:52-63`; `:189-199`) |

Change-log: as units RTC foram deixadas "prontas para a NT 2025/002 versão 1.50 da NF-e" (`ACBrDFe-change-log.txt:63-66`,
10/07/2026). **Inferência rotulada** (não confirmada pelo código): o ramo NF-e da unit comum aparenta antecipar a v1.50,
enquanto o writer vigente da NF-e segue o leiaute do XSD empacotado; a versão desse XSD não está declarada no arquivo.

### 3.11 NFS-e Padrão Nacional — `IBSCBS` do DPS (declarado pelo emitente)

**Gatilho de presença** (`PadraoNacional.GravarXml.pas:688-693`): gera se `dest.xNome` ≠ '' ou `imovel.cCIB` ≠ '' ou CEP do imóvel
≠ '' ou `cEndPost` ≠ '' ou `gIBSCBS.CST` ≠ nenhum. Posição: último filho do `infDPS`, depois de `valores` (`:681-693`).
Writer `ACBrNFSeXGravarXml.pas:1784-1817`; modelo `TIBSCBSDPS` (`ACBrNFSeXClass.pas:2232-2275`).

| Campo | Tipo | Oc (padrão em `:378-401`) | Valores / condição |
|---|---|---|---|
| `finNFSe` | str 1 | 1 | 0 regular · 1 crédito · 2 débito (`ACBrNFSeXConversao.pas:688-693`) |
| `indFinal` | str 1 | 0 | 1 sim · 0 não (`:696-699`); padrão do enum = "sim" (I-17, inferido) |
| `cIndOp` | str 6 | 1 | sem tabela no código |
| `tpOper` | str 1 | 0 | '' · 1–5 (`:728-734`) |
| `gRefNFSe` | `refNFSe` str 50, até 99 | — | se lista > 0 (`:1800-1801`, `:1819-1839`) |
| `tpEnteGov` | str 1 | 0 | 1–6 (enum comum `ACBrDFe.Conversao.pas:568-573`) |
| `indDest` | str 1 | 1 | 0 / 1 (`ACBrNFSeXConversao.pas:702-705`) |
| `dest` | grupo | — | se xNome ≠ '' (`:1809-1810`): CNPJ/CPF, ou NIF, ou cNaoNIF; xNome 1-300; end; fone 6-20; email (`:1841-1861`) |
| `imovel` | grupo | — | se cCIB ou xLgr (`:1812-1814`): inscImobFisc, cCIB, end nacional/exterior (`:1921-1980`) |
| `valores` | grupo | sempre (`:1816`) | `gReeRepRes` se há documentos (`:1986-1987`) + `trib` (`:1989`) |
| ↳ `gReeRepRes/documentos` | | — | dFeNacional (tipoChaveDFe 1/2/3/9, xTipoChaveDFe, chaveDFe 1-50) **ou** docFiscalOutro **ou** docOutro; fornec; dtEmiDoc; dtCompDoc; tpReeRepRes 01–04/99; xTpReeRepRes; vlrReeRepRes Dec2 (`:2011-2113`) |
| ↳ `trib/gIBSCBS` | | — | `CST` str 3 Oc1 · `cClassTrib` str 6 Oc1 · `cCredPres` str 2 Oc0 · `gTribRegular` (CSTReg + cClassTribReg) se CSTReg ≠ nenhum e cClassTribReg ≠ '' · `gDif` (pDifUF, pDifMun, pDifCBS — Dec2 1-15) se algum > 0 (`:2115-2170`) |

**Fato estrutural**: o DPS não carrega alíquota nem valor de IBS/CBS — só classificação (CST/cClassTrib/cCredPres/
gTribRegular/gDif) e contexto (finalidade, consumidor final, local, operação governamental, destinatário, imóvel,
reembolso/repasse). O XSD empacotado 1.01 confirma a estrutura (`[XSD-ACBr]\NFSe\PadraoNacional\1.01\tiposComplexos_v1.01.xsd:2207-2251`,
`:2641-2655`) e marca o grupo do DPS como opcional (`:838-841`); o 1.00 não tem IBSCBS (0 ocorrências).

### 3.12 NFS-e — `IBSCBS` da NFS-e (gerado pelo fisco)

Leitura `ACBrNFSeXLerXml.pas:1922-2076` (chamada em `PadraoNacional.LerXml.pas:989-993`, que herda `cLocIncid` se faltar).

| Grupo | Campos lidos (todos decimais como Dec2) |
|---|---|
| raiz | cLocalidadeIncid int 7 · xLocalidadeIncid · pRedutor (`:1929-1933`) |
| `valores` | vBC · vCalcReeRepRes · `uf` (pIBSUF, pRedAliqUF, pAliqEfetUF) · `mun` (pIBSMun, pRedAliqMun, pAliqEfetMun) · `fed` (pCBS, pRedAliqCBS, pAliqEfetCBS) (`:1940-1978`) |
| `totCIBS` | vTotNF · gTribRegular (pAliqEfeRegIBSUF…vTribRegCBS) · gTribCompraGov (pIBSUF, vIBSUF, pIBSMun, vIBSMun, pCBS, vCBS) · gIBS (vIBSTot, gIBSCredPres, gIBSUFTot vDifUF/vIBSUF, gIBSMunTot vDifMun/vIBSMun) · gCBS (gCBSCredPres, vDifCBS, vCBS) (`:1980-2076`) |

Percentuais da NFS-e = 2 casas no XSD empacotado (`TSDec2V2`, `tiposComplexos_v1.01.xsd:373-427`) — contra 4 casas na NF-e.
O writer do lado NFS-e (simulação/provedores que exigem — `ACBrNFSeXGravarXml.pas:1660-1782`) escreve só um subconjunto
(raiz, valores sem vCalcReeRepRes, uf/mun/fed, vTotNF, vIBSTot, vIBSUF, vIBSMun, vCBS) e limita xLocalidadeIncid a 15
caracteres (`:1667`) — I-16.

### 3.13 Simples Nacional (CRT · opSimpNac · regApTribSN) — o que o código faz

- **NF-e**: nenhum ramo de IBS/CBS/IS consulta o CRT. No writer, CRT só aparece na emissão do campo (`ACBrNFe.XmlWriter.pas:798-799`)
  e no ICMS (`:2092-2093`, `:2763`). Único item RTC com "Simples" no nome: tpNFDebito **08 = desenquadramento do SN**
  (`ACBrDFe.Conversao.pas:558-565`).
- **NFS-e / regTrib**: `opSimpNac` sempre (1 não optante · 2 MEI · 3 ME/EPP — `ACBrNFSeXConversao.pas:387-392`); `regApTribSN`
  só para ME/EPP (`PadraoNacional.GravarXml.pas:822-824`; valores 1/2/3, `:395-400`).
- **NFS-e / totTrib** (`PadraoNacional.GravarXml.pas:1747-1769`): MEI → indTotTrib se ≠ "sim", senão percentual/valor; ME/EPP →
  `pTotTribSN` se > 0, senão percentual/valor; não optante → percentual/valor.
- **NFS-e / IBSCBS do DPS**: sem nenhum ramo por regime (gatilho só de presença, `:688-693`).
- **NFS-e / IBSCBS da NFS-e**: existiu gatilho "só para não optante" (change-log 30/01/2026, `ACBrNFSeX-change-log.txt:2112-2114`),
  hoje COMENTADO (`PadraoNacional.GravarXml.pas:607`) após a mudança de 16/03/2026 que passou a gerar o grupo quando o DPS o
  tem (`ACBrNFSeX-change-log.txt:1422-1427`).

### 3.14 Enumerados — valores literais

| Enum | Valores (código → identificador) | Onde |
|---|---|---|
| `TCSTIBSCBS` (19) | 000, 010, 011, 200, 220, 221, 222, 400, 410, 510, 515, 550, 620, 800, 810, 811, 820, 830 (+ vazio) | `ACBrDFe.Conversao.pas:583-590` |
| `TcCredPres` | 01–13 (+ vazio) | `:593-598` |
| `TtpEnteGov` | 1 União · 2 Estados · 3 DF · 4 Municípios · 5 Consórcio público · 6 Comitê Gestor do IBS (nomes = identificadores) | `:568-573` |
| `TtpOperGov` (NF-e) | 1 Fornecimento · 2 Recebimento do pagamento · 3 Fornecimento com pagamento realizado · 4 Recebimento com fornecimento posterior | `:576-580` |
| `TtpOperGovNFSe` | 1–5 (o 5 = fornecimento e recebimento) — homônimos de `TtpOperGov` | `ACBrNFSeXConversao.pas:728-734` |
| `TtpNFDebito` | 01 transf. crédito cooperativa · 02 anulação · 03 débitos não processados · 04 multa e juros · 05 transf. crédito sucessão · 06 pagamento antecipado · 07 perda em estoque · 08 desenquadramento do SN | `ACBrDFe.Conversao.pas:558-565` (duplicado em `ACBrNFe.Conversao.pas:408-415`) |
| `TtpNFCredito` | 01 multa e juros · 02 apropriação de crédito presumido · 03 retorno · 04 redução de valores · 05 transf. crédito sucessão · 06 retorno por recusa parcial | `ACBrNFe.Conversao.pas:418-423` |
| `finNFe` | 1–4 + **5 nota de crédito · 6 nota de débito** | `pcnConversaoNFe.pas:302-303`; doc. do XSD empacotado `leiauteNFe_v4.00.xsd:187-193` |
| `TTpCredPresIBSZFM` | 0 sem crédito · 1 bens de consumo final · 2 bens de capital · 3 bens intermediários · 4 informática e outros | `ACBrDFe.Conversao.pas:615-620` |
| `TtpALCZFMCBS` | 1 / 2 | `:630-633` |
| `TCSTIS` | 000, 100…600 (sem uso no writer) | `ACBrNFe.Conversao.pas:426-431` |
| `TtpPagAnt` | 1 serviço não continuado · 2 serviço continuado · 3 fornecimento com pagamento anterior | `ACBrDFe.Conversao.pas:623-627` |

Descrições de CST e de cClassTrib: **não existem no código** (nenhuma tabela descritiva; só os códigos). Citação legal literal
encontrada: `DSC_TPCREDPRESIBSZFM` cita "art. 450, § 1º, da LC 214/25" (`ACBrDFeConsts.pas:224`).

### 3.15 Eventos da Reforma na NF-e — catálogo

| tpEvento | Enum | Finalidade (descrição do código, `EventoClass.pas:761-775`) | Gerador (`EnvEvento.pas`) |
|---|---|---|---|
| 110001 | teCancGenerico | Cancelamento de evento (leva tpEventoAut + nProtEvento — `:2479-2483`) | `:2464` |
| 112110 | tePagIntegLibCredPresAdq | Informação de pagamento integral para liberar crédito presumido do adquirente | `:2486` |
| 112120 | teImporALCZFM | Importação em ALC/ZFM não convertida em isenção | `:2828` |
| 112130 | tePerecPerdaRouboFurtoTranspContratFornec | Perecimento/perda/roubo/furto no transporte contratado pelo fornecedor | `:2996` |
| 112140 | teFornecNaoRealizPagAntec | Fornecimento não realizado com pagamento antecipado | `:665` |
| 112150 | teAtualizacaoDataPrevisaoEntrega | Atualização da data de previsão de entrega | `:465` |
| 211110 | teSolicApropCredPres | Solicitação de apropriação de crédito presumido | `:2507` |
| 211120 | teDestItemConsPessoal | Destinação de item para consumo pessoal | `:2587` |
| 211124 | tePerecPerdaRouboFurtoTranspContratAqu | Perecimento/perda/roubo/furto no transporte contratado pelo adquirente | `:2965` |
| 211128 | teAceiteDebitoApuracaoNotaCredito | Aceite de débito na apuração por emissão de nota de crédito | `:2858` |
| 211130 | teImobilizacaoItem | Imobilização de item | `:2798` |
| 211140 | teSolicApropCredCombustivel | Solicitação de apropriação de crédito de combustível | `:2935` |
| 211150 | teSolicApropCredBensServicos | Solicitação de apropriação de crédito p/ bens e serviços que dependem de atividade do adquirente | `:2694` |
| 212110 / 212120 | teManifPedTransfCred{IBS,CBS}Sucessao | Manifestação sobre pedido de transferência de crédito de IBS / de CBS em sucessão | `:741` |

Códigos: `ACBrNFe\Base\ACBrNFe.Conversao.pas:1139-1172`. Roteamento: todos → SVRS (`ACBrNFeWebServices.pas:3151-3160`).
Os eventos 110300/110301 (vínculo de pagamento) existem no enum comum (`ACBrDFe.Conversao.pas:127`, `:144`) mas só são usados
por BP-e, CT-e e NF3e (grep) — não pela NF-e. Autor de cada evento (emitente × destinatário): ⚠️ não determinado nesta leitura.

### 3.16 Versões de leiaute / NT citadas

- **No código**: só "NT 2025.002 v1.40 - Validação B25-80 / Rejeição 1001" (`ACBrNFe.XmlWriter.pas:1895`). NFS-e: versões de
  leiaute `ve100`/`ve101` decidem campos (`PadraoNacional.GravarXml.pas:448`, `:603`) e o schema é `DPS_v<versão>.xsd`
  (`PadraoNacional.Provider.pas:202-206`); o provedor declara `AtendeReformaTributaria := True` (`:166`).
- **Nos change-logs**: NT 2025/002 v1.01 (`ACBrNFe-change-log.txt:686`), v1.20 (`:527-528`, `:490`), v1.30 (`:405`), v1.40 (`:80`),
  v1.50 (`ACBrDFe-change-log.txt:65`), "v1.00" em 02/07/2026 (`ACBrNFe-change-log.txt:94` — I-12); NT 2026/002 v1.00 DANFE
  simplificado (`:89`). NFS-e: NT 2025/003 v1.2 (`ACBrNFSeX-change-log.txt:3656`), NT 2025/004 v1.1 (`:3611`), NT 008 do DANFSe
  (`:383`), NT 007 (`:1993`).

### 3.17 Linha do tempo (change-logs)

| Data | Onde | Mudança |
|---|---|---|
| 10/02–08/03/2025 | `ACBrNFe-change-log.txt:783-818` | classes, constantes, escrita/leitura RTC; cMunFGIBS sem erro quando vazio |
| 29/04/2025 | `:686` | NT 2025/002 v1.01 |
| 21/05–20/06/2025 | `ACBrDFe-change-log.txt:271-311` | unit de tipos RTC; TcCredPres; TtpOperGov; CST/cClassTrib/cCredPres "com base nas tabelas da SVRS"; "nenhum" em tpEnteGov/tpOperGov |
| 26/05/2025 | `ACBrNFe-change-log.txt:655-657` | CSTIS deixa o tipo do CST IBS/CBS; cCredPres vira enum |
| 18/07 → 22/07/2025 | `:563` → `:558` | CST 410 passa a gerar gIBSCBS e, 4 dias depois, é retirado ("não se calcula") |
| 18/07/2025 | `ACBrDFe-change-log.txt:266-269` | código cClassTrib "410099" corrigido para "410999" |
| 01/08 e 03/09/2025 | `ACBrNFe-change-log.txt:525-528`, `:488-491` | conformidade v1.20 |
| 14/08/2025 | `:519-523` | CST e cClassTrib obrigatórios |
| 19/08/2025 | `:514-517`; `ACBrDFe-change-log.txt:239-242` | cClassTrib deixa de ser enum (vira string) |
| 15/09/2025 | `ACBrNFe-change-log.txt:470-473` | crédito/débito sem ICMS/PIS/COFINS no item |
| 16/09/2025 | `:461-465` | regras de negócio + primeiros eventos (110001, 112110, 211110, 211120) |
| 23/09/2025 | `:430-433` | "possível solução" para vCredPres/vCredPresCondSus |
| 02/10/2025 | `ACBrDFe-change-log.txt:228-231` | atualização dos CST |
| 13–17/10/2025 | `ACBrNFe-change-log.txt:388-406` | v1.30; tabela CST/cClassTrib alterada; eventos 2111xx |
| 28–29/10/2025 | `:348-361` | novos tipos de evento; eventos RTC recepcionados pela SVRS |
| 12/11–05/12/2025 | `:275-339` | demais eventos e leitura de XML de eventos |
| 30/12/2025 → 08/01/2026 | `:243`, `:248` | CSTIS: enum atualizado e, 9 dias depois, volta a string |
| 02/05/2026 | `:153-156` | sem ICMS/ISSQN/IPI/PIS/COFINS quando tpOperGov = 2 |
| 01/06/2026 | `:132-135` | tpNFCredito 06 (retorno por recusa parcial) |
| 10/06/2026 | `:126-130` | IS volta a ser gerado (estava comentado) |
| 30/06–02/07/2026 | `:94-105`; `ACBrDFe-change-log.txt:84-99` | gPagAntecipado só com chaves; gALCZFMCBS opcional; units RTC comuns criadas |
| 07/07/2026 | `ACBrNFe-change-log.txt:84-87` | ajuste p/ evitar rejeição 1001 (B25-80) |
| **09/07/2026** | `:78-82`; `ACBrDFe-change-log.txt:68-72` | **REVERT** das mudanças da NT 2025/002 v1.40 nos eventos (211110/211120) |
| 10/07/2026 | `ACBrDFe-change-log.txt:59-66` | tpALCZFMCBS 1/2; units RTC "prontas para v1.50" |
| 16/07 e 05/08/2026 | `ACBrDFe-change-log.txt:42-52` | pagamento antecipado (NF-e e NFGas) na unit comum |
| **28/07/2026** | `ACBrNFe-change-log.txt:61-66` | **reintroduz** o leiaute do 211110 e desfaz a remoção do 211120 |
| 19/08/2026 | `:47-50` | pDevTrib opcional |
| NFS-e 22/05/2025 → 07/08/2026 | `ACBrNFSeX-change-log.txt:4438`, `:3654-3658`, `:3610-3613`, `:3171-3175`, `:2112-2114`, `:1784-1791`, `:1618-1622`, `:1422-1427`, `:916-922`, `:369-384`, `:121-126` | flag "atende reforma"; DPS/NFS-e PN pelas NT 2025/003 e 2025/004; IBSCBS opcional no 1.01; gate por optante (jan/26) e sua neutralização (mar/26); pTotTribSN; E0713; cidades 1.00 (sem RTC) × 1.01 (com RTC) convivendo; DANFSe: vTotNF = líquido + IBS/CBS e NT 008; um provedor municipal com validação de schema DESATIVADA porque o XSD não tinha os campos da reforma |

---

## 4. Fluxo de dados

**4.1 NF-e — geração** (`ACBrNFe.XmlWriter.pas`): zera a flag do total (`:337`) → `ide`: dPrevEntrega, cMunFGIBS, finNFe,
tpNFDebito/Crédito (só v4 e finalidade), cIndOp, … NFref → gCompraGov → gPagAntecipado (`:539-644`) → para cada item: `prod`
(tpCredPresIBSZFM `:1263`, indBemMovelUsado `:1314`) → `imposto`: filtro B25-80 decide os tributos atuais (`:1910-1935`) → IS se
CSTIS e vBCIS (`:1938`) → IBSCBS se CST e cClassTrib (`:4306`), despacho por CST × modelo, estorno, crédito presumido →
`vItem`, `DFeReferenciado` (`:1180-1184`) → `total`: ICMSTot, ISSQNtot, retTrib, ISTot, IBSCBSTot (se a flag), vNFTot
(`:3540-3555`). **Erros**: só alertas (`wAlerta`) — nada interrompe; validação de schema e de regra RTC ⚠️ não implementadas
no componente (as regras locais não têm IBS/CBS — §2.4).

**4.2 NF-e — eventos RTC**: tpEvento → gerador do `detEvento` (`EnvEvento.pas:1059-1087`) → envio sempre à SVRS, layout de
evento (`ACBrNFeWebServices.pas:3151-3160`) → leitura do retorno (change-log 03/12/2025, `ACBrNFe-change-log.txt:280-284`).

**4.3 NFS-e — DPS**: `GerarXMLInfDps` (`PadraoNacional.GravarXml.pas:641-694`) → tpAmb … prestador (regTrib `:815-828`) → tomador
→ intermediário → serviço → valores (totTrib por regime `:1733-1786`) → IBSCBS se presença (`:688-693`). Assinatura e envio:
fora deste recorte.

**4.4 NFS-e — retorno**: XML da NFS-e → `LerXMLIBSCBSNFSe` (`PadraoNacional.LerXml.pas:989`) → valores e totais calculados pelo
fisco (§3.12); se `cLocalidadeIncid` não vier, herda `cLocIncid` (`:990-993`). A geração do infNFSe (simulação) reaproveita
`cLocIncid` → `IBSCBS.cLocalidadeIncid` (`PadraoNacional.GravarXml.pas:539-552`, `:614-618`).

---

## 5. Integrações externas identificadas

| Integração | Payload / uso | Autenticação | Evidência |
|---|---|---|---|
| SVRS — recepção de eventos da NF-e | os 15 eventos RTC (§3.15), layout de evento | ⚠️ não lida aqui (certificado do componente) | `ACBrNFeWebServices.pas:3151-3160`; change-log `:348-352` |
| ADN / Padrão Nacional (NFS-e) | DPS v1.00 ou v1.01; IBSCBS só na 1.01 | ⚠️ não lida aqui | `PadraoNacional.Provider.pas:144`, `:166`, `:202-206` |
| Validação de schema (XSD) | XSDs empacotados em `[XSD-ACBr]` | — | change-log NFS-e `:121-126` (um provedor desligou a validação por XSD defasado) |
| Serviço de cálculo de IBS/CBS (calculadora) | ⚠️ não encontrado no código — o componente não chama nenhum | — | §3.9 |

---

## 6. Pendências e inconsistências

Severidade lida no contexto do caso (ACBr como REFERÊNCIA): 🔴 copiar o comportamento levaria a XML errado/rejeitável ou
esconde uma decisão de leiaute · 🟡 comportamento incorreto ou risco de perda · 🟢 débito sem impacto imediato.

| # | Sev. | Achado | Evidência |
|---|---|---|---|
| I-1 | 🔴 | Duas implementações do IBS/CBS da NF-e no mesmo pacote, com 13 divergências (§3.10); a "comum" tem o ramo NF-e pronto e nenhum consumidor NF-e | `ACBrDFe.RTC.XmlWriter.pas:343-376` × `ACBrNFe.XmlWriter.pas:4302-4358` |
| I-2 | 🔴 | `finNFe` 5/6 não existe no enum da unit vigente; o writer compila por enxergar o enum da unit `pcn` (ordem do `uses`) — o caminho "vigente" depende do "descartado" | `ACBrNFe.Conversao.pas:291-295, 1261-1271`; `ACBrNFe.Classes.pas:51-53`; `ACBrNFe.XmlWriter.pas:39-43, 588, 592, 1910`; `pcnConversaoNFe.pas:302-303` |
| I-3 | 🟡 | Enums declarados em duplicidade (`TtpNFDebito`, `TTpCredPresIBSZFM`) e homônimos entre famílias (`togNenhum`… em `TtpOperGov` × `TtpOperGovNFSe`) — resolução silenciosa pela ordem do `uses` | `ACBrDFe.Conversao.pas:558, 576, 615`; `ACBrNFe.Conversao.pas:408, 434`; `ACBrNFSeXConversao.pas:728` |
| I-4 | 🟡 | `cClassTrib` é texto livre de 6 posições; nenhuma tabela nem validação CST × cClassTrib em lugar algum | `ACBrNFe.Classes.pas:1858`; change-log `:514-517`; §2.4 |
| I-5 | 🟡 | Nenhuma regra de negócio local de IBS/CBS/IS — rejeição só no fisco | `ACBrNFe.ValidarRegrasdeNegocio.pas` (grep) |
| I-6 | 🟡 | Totais e `vItem`/`vNFTot` não calculados nem conferidos contra os itens | §3.9 |
| I-7 | 🟡 | `vIBSEstCred` limitado a 7 dígitos (máx. 99.999,99) contra 15 do `vCBSEstCred`, no item e no total, nos dois writers (estouro = só alerta) | `ACBrNFe.XmlWriter.pas:4705, 4708, 4919, 4922`; `ACBrDFe.RTC.XmlWriter.pas:572, 575, 688, 691` |
| I-8 | 🟡 | Unit comum: estorno de crédito avaliado FORA do gatilho — com CST "nenhum" e estorno > 0 há acesso a resultado nulo | `ACBrDFe.RTC.XmlWriter.pas:226-278` |
| I-9 | 🟡 | Leitor comum lê `CNPJBasePSP` como decimal (perde zeros à esquerda / alfanumérico) | `ACBrDFe.RTC.XmlReader.pas:416` |
| I-10 | 🟡 | Unit comum grava/lê `pAliqEfet` e `pDevTrib` com 2 casas; XSD empacotado e writer da NF-e usam 4 | §3.10 itens 6–7 |
| I-11 | 🟡 | Instabilidade da especificação: revert (09/07/2026) e reintrodução (28/07/2026) dos eventos 211110/211120; CST 410 ida-e-volta; CSTIS enum↔string; IS comentado e reativado | `ACBrNFe-change-log.txt:61-66, 78-82, 558, 563, 243, 248, 126-130` |
| I-12 | 🟢 | Change-log de 02/07/2026 cita "NT 2025/002 - versão 1.00" depois de entradas da v1.40 | `ACBrNFe-change-log.txt:92-95` |
| I-13 | 🟢 | `CSTIS` como string "até tabela oficial", mas existe `TCSTIS` sem uso | `ACBrNFe.Classes.pas:1444-1446`; `ACBrNFe.Conversao.pas:426-431` |
| I-14 | 🟢 | Descrições trocadas e IDs repetidos (cCredPres com descrição de estorno; vIBSMun com a de vIBSUF; adRemCBSReten com a de IBS; UB35/UB93/W35/'#1' repetidos) | `ACBrNFe.XmlWriter.pas:4721, 4424, 4630, 4370/4401, 4801`; `ACBrDFe.RTC.XmlWriter.pas:1151` |
| I-15 | 🟢 | CST 810 no enum sem tratamento nem comentário no writer | `ACBrDFe.Conversao.pas:585`; `ACBrNFe.XmlWriter.pas:4321-4347` |
| I-16 | 🟢 | Writer do lado NFS-e: xLocalidadeIncid limitado a 15 (XSD empacotado: 600) e omite vCalcReeRepRes, vDif*, créditos presumidos, gTribRegular e gTribCompraGov que o leitor conhece | `ACBrNFSeXGravarXml.pas:1660-1782`; `tiposComplexos_v1.01.xsd:296` |
| I-17 | 🟢 | `indFinal` aparenta sair "1" mesmo sem o chamador definir (padrão do enum = sim; ocorrência 0 só omite vazio) — **inferido** | `ACBrNFSeXConversao.pas:696-699`; `ACBrNFSeXGravarXml.pas:380, 1791-1792`; `ACBrXmlWriter.pas:449` |
| I-18 | 🟢 | Propriedade `GerarIBSCBSNFSe` não é lida pelo provedor Padrão Nacional (gate comentado) — chave morta para este provedor | `ACBrNFSeXGravarXml.pas:123, 291, 401`; `PadraoNacional.GravarXml.pas:607` |
| I-19 | 🟢 | `gPagAntecipado` da NF-e sem alerta de máximo (XSD empacotado: 99); a unit comum alerta | `ACBrNFe.XmlWriter.pas:4244-4261`; `ACBrDFe.RTC.XmlWriter.pas:788-789`; `leiauteNFe_v4.00.xsd:508` |
| I-20 | 🟢 | `qBCMono` não entra no gatilho do `gMonoPadrao` | `ACBrNFe.XmlWriter.pas:4564-4565` |
| I-21 | 🟢 | `cIndOp` no `ide` da NF-e sem marca "Reforma" no código; o XSD empacotado o descreve como "código indicador do local da operação de fornecimento" | `ACBrNFe.XmlWriter.pas:610-611`; `ACBrNFe.Consts.pas:196`; `leiauteNFe_v4.00.xsd:256-258` |
| I-22 | 🟢 | No item, `vCredPresCondSus` e `vCredPres` são exclusivos (um ou outro) — a origem no change-log é "possível solução" | `ACBrNFe.XmlWriter.pas:4738-4743`; change-log `:430-433` |

Texto com cara de instrução para IA: **nenhum** encontrado nos arquivos lidos (varredura por padrões típicos). Credencial
literal: **nenhuma** nas units RTC e do Padrão Nacional.

---

## 7. Resumo executivo

| Medida | Total | ✅ | ⚠️ | ❌ |
|---|---|---|---|---|
| Unidades RTC da NF-e (ide 6 · prod 2 · det 2 · imposto 23 · total 9) | 42 | 37 | 5 (IS; gEstornoCred item e total; tpNFDebito e tpNFCredito por I-2) | 0 |
| Unidades do IBSCBS do DPS (NFS-e) | 10 | 10 | 0 | 0 |
| Unidades do IBSCBS da NFS-e (fisco) — **leitura** | 14 | 14 | 0 | 0 |
| idem — **escrita** (simulação) | 14 | 3 | 7 | 4 |
| Divergências unit comum × NF-e | 13 | — | — | — |
| Consumidores NF-e da unit comum | 0 | — | — | — |
| Eventos RTC da NF-e (todos à SVRS) | 15 | 15 | — | — |
| Componentes inventariados (§2.1–§2.5) | 19 | 11 | 8 | 0 |
| Pendências / inconsistências (§6) | 22 | 🔴 2 · 🟡 9 · 🟢 11 | | |

**Conclusão**: o ACBr entrega um mapa completo e funcional do grupo IBS/CBS/IS da NF-e (42 unidades) e do IBSCBS do DPS
nacional, com regras de PRESENÇA bem definidas (por CST, por modelo, por valor > 0, por finalidade) e o catálogo dos 15 eventos
roteados à SVRS. O que falta é tudo que não é forma de XML: cálculo, totais, tabela cClassTrib, regras de negócio e qualquer
tratamento de regime do Simples — e o próprio pacote convive com duas versões divergentes do leiaute da NF-e, sinal de uma
especificação que mudou (e reverteu) até agosto de 2026.

---

## 8. Insumos para o planejamento — **FORA DA FOTOGRAFIA**

Formato de cada item: **(a)** evidência · **(b)** onda/fase · **(c)** D-F/Q-NE que confirma ou contradiz, ou questão nova ·
**(d)** o que conferir no OFICIAL antes de virar regra.

### A. Núcleo `fiscal-api` (comum às duas famílias)

- **A1 — Classificação RTC é comum; forma e decimais são da família.** (a) Enums únicos para NF-e e NFS-e
  (`ACBrDFe.Conversao.pas:568-598`; `ACBrNFSeXClass.pas:52`), mas percentuais com 4 casas na NF-e (`ACBrNFe.XmlWriter.pas:4388`)
  e 2 na NFS-e (`ACBrNFSeXGravarXml.pas:1694`; `tiposComplexos_v1.01.xsd:373`). (b) NE-1 + fase IBS/CBS. (c) Coerente com Q-NE13
  (política comum no núcleo) e Q-NE5 (dialeto na família); **questão nova Q-RTC1**: o catálogo CST/cClassTrib/cCredPres mora
  no ERP (motor, D-F22) e o núcleo só valida domínio, ou o núcleo carrega o catálogo versionado? (d) tabela oficial
  CST × cClassTrib (Informe Técnico / portal SVRS) e sua política de versão/vigência.
- **A2 — O ACBr não serve de fonte de leiaute; XSD oficial + validação local são obrigatórios.** (a) I-1 (13 divergências),
  I-10, XSD empacotado sem versão declarada. (b) NE-0 (levantamento) e NE-1 (validação no núcleo). (c) Confirma Q-NE16 e
  Q-NE19 (casa do levantamento). (d) qual PL/XSD está em produção em cada ambiente na data.
- **A3 — O componente não calcula nem confere totais.** (a) §3.9, I-6. (b) fase IBS/CBS (motor no setes-api). (c) Confirma
  D-F22 (motor no ERP, congelado) e a regra "a API fiscal não calcula imposto" (`[nfse-api]\CLAUDE.md`); reforça Q-NE15 (c).
  (d) regras oficiais de arredondamento e de conferência item × total (rejeições de totais).
- **A4 — Versão de leiaute com vigência por data e por ambiente.** (a) NFS-e 1.00 e 1.01 coexistindo por município
  (`ACBrNFSeX-change-log.txt:916-922`); revert/reintrodução de eventos na NF-e (I-11). (b) NE-1. (c) **Questão nova Q-RTC2**:
  o núcleo versiona leiaute por família com "vigência em H" × "vigência em P" (liga primeiro na homologação)? (d) cronogramas
  oficiais de cada NT e datas de obrigatoriedade por ambiente.
- **A5 — Regime do emitente decide fora do emissor.** (a) Nenhum ramo RTC olha CRT/opSimpNac (§3.13). (b) fase IBS/CBS.
  (c) Confirma Q-E23 (`simples_regime` como fato do emitente); a decisão "o que o Simples informa" é regra do motor, não do
  builder. (d) § 1º do Ato Conjunto RFB/CGIBS nº 4/2026 e a NT correspondente.

### B. `nfse-api` — prazo 01/01/2027 (Setes, ME/EPP)

- **B1 — O DPS leva classificação, não valores.** (a) §3.11 (`ACBrNFSeXGravarXml.pas:1784-1817`, `:2115-2170`); a `nfse-api`
  não tem nada do grupo (`[nfse-api]\src\authority\types.ts:18` "sem IBS/CBS"; `dps-builder.ts:148-162`). Falta: finNFSe,
  indFinal, cIndOp, tpOper, gRefNFSe, tpEnteGov, indDest, dest, imovel, valores/gReeRepRes, trib/gIBSCBS (CST, cClassTrib,
  cCredPres, gTribRegular, gDif) — como último filho do `infDPS`. (b) fase IBS/CBS (builder na nfse-api depois da F1). (c) Confirma
  D-F22. (d) XSD 1.01 oficial vigente e a NT da NFS-e: obrigatoriedade para ME/EPP em 01/01/2027 e quais campos o Simples
  preenche.
- **B2 — Fonte de fatos do ramo de serviço precisa dos novos fatos.** (a) `[nfse-api]\src\facts\service-facts.ts` não lê
  nenhum fato RTC; o DPS exige cIndOp e indDest (Oc1). (b) fase IBS/CBS — motor/congelamento no setes-api + leitura na nfse-api.
  (c) **Questão nova Q-RTC3**: onde moram cClassTrib e cIndOp — na regra de serviço (`tb_service_tax_rule`, ao lado do código
  nacional), no ramo congelado da nota, ou derivados do tomador/local? (d) tabela oficial do cIndOp e regra do local de incidência.
- **B3 — O fisco devolve os valores calculados; a nfse-api hoje os ignora.** (a) §3.12 (`ACBrNFSeXLerXml.pas:1922-2076`);
  `parseNfseXml` lê só o cabeçalho (`[nfse-api]\src\authority\dps-builder.ts:241-254`); DANFSe do ACBr passou a usar
  vTotNF = líquido + IBS/CBS (`ACBrNFSeX-change-log.txt:369-377`). (b) fase IBS/CBS. (c) **Questão nova Q-RTC4**: os valores do
  fisco (vBC, vIBSTot, vCBS, vTotNF) voltam ao ERP como fato (efeito lido pelo setes-api, molde D-F11) e alteram o valor a cobrar,
  ou ficam só no XML/voz? (d) se vTotNF muda o valor devido pelo tomador em 2027 para optante do Simples.
- **B4 — DANFSe próprio precisa do bloco IBS/CBS.** (a) change-log NT 008 e vTotNF (`ACBrNFSeX-change-log.txt:369-384`).
  (b) fase IBS/CBS (peça DANFSe). (c) relaciona-se a Q-NE20 (base de PDF no núcleo). (d) leiaute oficial do DANFSe (NT 008).
- **B5 — Nenhum ramo do ACBr trata o ME/EPP no IBSCBS.** (a) §3.13 — gatilho só de presença (`PadraoNacional.GravarXml.pas:688-693`);
  gate por optante criado e neutralizado (`ACBrNFSeX-change-log.txt:2112-2114` → `:1422-1427`; `:607`). (b) fase IBS/CBS.
  (c) Q-NE4 (a) e D-F22; **questão nova Q-RTC5**: para ME/EPP em 2027, CST/cClassTrib são fixos por regime (valor único
  configurável) ou por serviço? (d) Ato Conjunto § 1º + NT da NFS-e (CST/cClassTrib aplicáveis ao Simples).
- **B6 — Dá para ligar o grupo sem trocar de versão.** (a) a nfse-api já está na 1.01 (`[nfse-api]\src\authority\dps-builder.ts:16`)
  e o grupo é opcional no XSD 1.01 empacotado (`tiposComplexos_v1.01.xsd:838`). (b) fase IBS/CBS. (c) Confirma D-F22 ("depois
  da F1"); sugere entrar por configuração com data. (d) se o ADN publicou versão/regra que torna o grupo obrigatório e se a
  produção restrita já valida.
- **B7 — Nota de crédito/débito na NFS-e.** (a) finNFSe 1/2 + gRefNFSe até 99 (`ACBrNFSeXConversao.pas:688-693`;
  `ACBrNFSeXGravarXml.pas:1800-1839`). (b) fora do 1º release da fase IBS/CBS. (c) **Questão nova Q-RTC6**: escopo do 1º
  release = só finNFSe 0 (regular)? (d) NT da NFS-e (uso de crédito/débito × cancelamento).
- **B8 — cNBS.** (a) opcional no ACBr (`PadraoNacional.GravarXml.pas:1060-1061`) e nunca preenchido na nfse-api
  (`[nfse-api]\src\authority\types.ts:64`; sem uso em `service-facts.ts`). (b) fase IBS/CBS. (c) retoma o `nbs_code` citado em
  `prompt_onda_nfe_sefaz.md:308`. (d) se a classificação RTC passa a exigir NBS.

### C. `nfe-api`

- **C1 — Despacho por CST e restrição por modelo.** (a) §3.5 (`ACBrNFe.XmlWriter.pas:4321-4339`). (b) NE-4 (builder). (c) Confirma
  Q-NE2 (55 primeiro; o 65 aceita subconjunto). (d) regras de validação por CST da NT 2025.002 na versão vigente (1.40/1.50).
- **C2 — Nota de crédito/débito suprime os tributos atuais.** (a) §3.3 (`:1895-1935`). (b) NE-4. (c) Q-NE25 (escopo do 1º release
  não cita finNFe 5/6) — **questão nova Q-RTC7**: finNFe 5/6 ficam fora da F4? (d) regra B25-80/rejeição 1001 oficial.
- **C3 — Eventos RTC vão à SVRS, não ao autorizador da UF.** (a) `ACBrNFeWebServices.pas:3151-3160`. (b) NE-3 (adaptador).
  (c) Complementa Q-NE3 (tabela de autorizadores) e Q-NE14 (vocabulário — eventos que não são cancelamento). (d) URLs e
  WSDL oficiais da SVRS para esses eventos e quem é o autor de cada um.
- **C4 — Devolução pode referenciar por item.** (a) regra 321 aceita `DFeReferenciado` por item (`ACBrNFe.ValidarRegrasdeNegocio.pas:1233-1252`;
  `ACBrNFe.XmlWriter.pas:4761-4778`). (b) NE-4/NE-6. (c) Complementa Q-NE25 (devolução com refNFe da âncora — D-E15).
  (d) MOC/NT: quando o DFeReferenciado substitui o NFref.
- **C5 — Campos novos fora do item.** (a) §3.1–§3.2 e §3.9 (cMunFGIBS, dPrevEntrega, tpNFDebito/Crédito, gCompraGov,
  gPagAntecipado, indBemMovelUsado, tpCredPresIBSZFM, vItem, ISTot, IBSCBSTot, vNFTot). (b) NE-4 (fonte de fatos) e NE-6 (ERP).
  (c) Confirma Q-NE15 (c) — estrutural no ERP. (d) fórmulas oficiais de vItem e vNFTot.
- **C6 — Semântica "zero = ausente".** (a) `ACBrXmlWriter.pas:369, 449` + gatilhos > 0 (§3.6–§3.9). (b) NE-4. (c) — .
  (d) conferir no XSD/NT quais grupos são obrigatórios mesmo zerados.
- **C7 — Grupos especializados** (monofasia, ZFM/ALC, compra governamental, crédito presumido, transferência, ajuste, IS).
  (a) §3.4, §3.6–§3.8. (b) fora da F4 salvo cliente que exija. (c) Q-NE25. (d) aplicabilidade por cClassTrib.

### D. Fila para o guardião e para as rodadas

- **Maquete suspeita**: o próprio pacote mostra o risco de "uma forma por família congelada cedo" — dois modelos da NF-e e um
  terceiro da NFS-e para o mesmo conceito. Para o guardião: o conceito é UM (classificação + base + alíquotas efetivas + valores
  por esfera), com dois dialetos de XML.
- **Questões novas para a rodada**: Q-RTC1 (casa do catálogo CST/cClassTrib) · Q-RTC2 (versão de leiaute com vigência por
  ambiente) · Q-RTC3 (onde moram cClassTrib/cIndOp do serviço) · Q-RTC4 (valores do fisco na NFS-e: fato do ERP ou só XML) ·
  Q-RTC5 (classificação do ME/EPP: por regime ou por serviço) · Q-RTC6 (finNFSe crédito/débito fora do 1º release) ·
  Q-RTC7 (finNFe 5/6 fora da F4).

---

## 9. Confiança e lacunas

- **Alta** para o comportamento dos writers de NF-e e NFS-e (linhas lidas integralmente nos trechos citados) e para os catálogos
  de enumerados e eventos.
- **Não lido**: modelos IBS/CBS de CT-e, NF3e e NFCom (só localizados); `ACBrNFe.XmlReader` (leitura do retorno da NF-e);
  `ACBrNFeNotasFiscais` (só grep); INI/JSON e relatórios (descartados por regra).
- **Inferido** (rotulado no texto): significado de valores de enum além do identificador; I-17 (indFinal "1" por padrão);
  a leitura de §3.10 sobre a unit comum antecipar a v1.50.
- O XSD em `[XSD-ACBr]` usado como conferência também é cópia de terceiro e não declara a versão da NT; serve como sinal, não
  como prova.
- Datas: uma entrada do change-log da NFS-e aparece como "25/01/2025" entre entradas de 2026 (`ACBrNFSeX-change-log.txt:2230-2244`)
  — tratada como erro de digitação e não usada.
- **Perguntas ao dono (SME)**: qual revisão do ACBr o legado Gestao2016 compila hoje (antes ou depois de 28/07/2026)? O legado
  emite NFS-e pelo ACBrNFSeX (Padrão Nacional) ou só a NF-e passa pelo ACBr? Os `TB_IBSCBS*` do legado são gravados com valores
  calculados por ele ou vindos do retorno?
