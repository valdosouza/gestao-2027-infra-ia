# ACBr NF-e — Modelo 4.00, geração do XML, chave de acesso e assinatura
**Escopo**: setes
**Natureza**: referência de TERCEIRO — ACBr (LGPL 2.1), motor da NF-e no legado Gestao2016; nunca substitui o oficial (MOC/NT/XSD/WSDL)
**Fonte**: D:\Componentes\acbr\Fontes\ACBrDFe\ (change-log 19/08/2026) · leitura de 2026-10-10
**Agente**: legacy-analyst (plugin code-modernization) no método assess-legacy-repo

> Fotografia do que o código do ACBr FAZ — comportamento e regras, sem transcrever código (licença). Toda afirmação traz
> `arquivo:linha`. As seções 1–7 descrevem só o ACBr; o §8 (insumos para a nfe-api) está FORA da fotografia e é o único
> lugar onde aparecem o núcleo `fiscal-api`, a `nfse-api` e as questões Q-NE. O grupo IBS/CBS (reforma tributária) é de
> outra frente: aqui só se registra ONDE ele entra na árvore (§3.16).

## Legenda dos arquivos citados

| Sigla | Arquivo (relativo a `ACBrDFe\`, salvo indicação) | Linhas |
|---|---|---|
| **W** | `ACBrNFe\Base\ACBrNFe.XmlWriter.pas` | 4926 |
| **C** | `ACBrNFe\Base\ACBrNFe.Classes.pas` | 5965 |
| **CV** | `ACBrNFe\Base\ACBrNFe.Conversao.pas` | 1828 |
| **K** | `ACBrNFe\Base\ACBrNFe.Consts.pas` | 423 |
| **VR** | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas` (lido só onde toca totais/chave) | 1335 |
| **NF** | `ACBrNFe\ACBrNFeNotasFiscais.pas` | 1232 |
| **N** | `ACBrNFe\ACBrNFe.pas` | 1152 |
| **NC** | `ACBrNFe\ACBrNFeConfiguracoes.pas` | 389 |
| **WS** | `ACBrNFe\ACBrNFeWebServices.pas` (só o envelope do lote) | 4366 |
| **U** | `ACBrDFeUtil.pas` | 1307 |
| **XW** | `ACBrXmlWriter.pas` | 520 |
| **XB** | `ACBrXmlBase.pas` | 468 |
| **S** | `ACBrDFeSSL.pas` | 2005 |
| **XS** | `ACBrDFeXsXmlSec.pas` | 1033 |
| **L2** | `ACBrDFeXsLibXml2.pas` | 760 |
| **OS** | `ACBrDFeOpenSSL.pas` | 476 |
| **D** | `ACBrDFe.pas` | 700 |
| **DC** | `ACBrDFe.Conversao.pas` | — |
| **DCF** | `ACBrDFeConfiguracoes.pas` | — |
| **V** | `..\ACBrDiversos\ACBrValidador.pas` | — |
| **UB / US / UD / UX** | `..\ACBrComum\ACBrUtil.Base.pas` / `ACBrUtil.Strings.pas` / `ACBrUtil.DateTime.pas` / `ACBrUtil.XMLHTML.pas` | — |
| **XD** | `..\ACBrLibXML2\ACBrXmlDocument.pas` | — |
| **PC** | `..\PCNComum\pcnConversao.pas` | — |
| **INC** | `..\ACBrComum\ACBr.inc` | — |
| **XSDref** | `D:\Componentes\acbr\Exemplos\ACBrDFe\Schemas\NFe\leiauteNFe_v4.00.xsd` (cópia de TERCEIRO do XSD, 201 arquivos na pasta) | — |

---

## 1. Visão geral do sistema

O ACBr representa a NF-e como um grafo de objetos Delphi (`TNFe`, C:2938) preenchido pela aplicação hospedeira. O
`TNFeXmlWriter` (W:76) percorre esse grafo e escreve o XML 4.00 numa árvore DOM sobre libxml2 (`TACBrXmlDocument`, XD);
o caminho vigente é o do `ACBrXmlDocument` (INC:64 define `USE_ACBr_XMLDOCUMENT`). O writer **não calcula impostos nem
totais**: formata o que recebe, decide presença/ausência de grupos por regras de valor/CST/CRT/modelo/versão, gera a
chave de acesso (W:353-364) e devolve alertas (não exceções) quando algo foge ao leiaute (XW:467-485). O fluxo do
componente é `NotaFiscal.GerarXML` (NF:633) → `Assinar` (NF:325: XMLDSig enveloped em `infNFe`, C14N inclusiva,
RSA-SHA1 por padrão; para NFC-e gera QR Code e re-serializa) → `Validar` (NF:390: XSD via libxml2) → lote `enviNFe`
(WS:1143). Validação de regras de negócio (VR) existe, mas é chamada à parte — `Enviar` não a invoca (N:880-883).

---

## 2. Inventário de componentes

### 2.1 Unidades lidas

| Unidade | Responsabilidade | Depende de | Status |
|---|---|---|---|
| C | Modelo de dados da NF-e/NFC-e 4.00 — 133 classes (C:64–2938), propriedades tipadas (Currency/Double/enum/string) | DC, PC | ✅ Completo |
| W | Writer do XML 4.00: árvore, ordem, condicionalidade, formatação por campo, chave, Signature, nfeProc | XW, U, C, CV, DC | ✅ Completo (⚠️ 2 grupos do XSD não gerados — §6) |
| XW | Base dos writers: `AddNode` (tipos, ocorrência, omissão, formatação, alertas), CNPJ/CPF, template `Signature` | XB, U, V, UB, US | ✅ Completo |
| XB | `TSignature` (XB:60-68), `FiltrarTextoXML` (XB:161-180) | US | ✅ Completo |
| XD | DOM sobre libxml2; conteúdo de texto e CDATA (XD:451-468), serialização UTF-8 (XD:1278-1300) | libxml2 (DLL) | ✅ Completo |
| U | Chave de acesso, cNF, cDV, validações de chave/UF/município, template de assinatura, hash CSRT | V, UB, US, UD | ✅ Completo |
| V | Módulo 11 (V:644-660, V:2131-2183), CNPJ alfanumérico (V:846-882) | — | ✅ Completo |
| N | Componente `TACBrNFe`: namespace, schema por leiaute, QR Code v1/v2/v3, chave de contingência FS-DA, `Enviar` | NF, WS, S | ✅ Completo (na fatia lida) |
| NF | Item `NotaFiscal`: GerarXML, Assinar, Validar, VerificarAssinatura, ValidarRegrasdeNegocios, nomes de arquivo | W, N, S, VR | ✅ Completo |
| NC | Defaults da configuração NF-e (modelo 55, versão 4.00, QR v2, campos de fatura obrigatórios) | DCF | ✅ (só construtor) |
| S | Orquestra assinatura/validação/hash; conferência CNPJ×certificado | XS, L2, OS | ✅ Completo (na fatia lida) |
| XS | Assinatura e validação XSD via xmlsec1 | libxml2, xmlsec1 | ✅ Completo |
| L2 | Assinatura "manual" (C14N + digest + RSA) e validação XSD via libxml2 | libxml2, OS | ✅ Completo |
| OS | PKCS#12, digest e assinatura RSA (EVP) | OpenSSL | ✅ (só hash/assinatura) |
| D / DC / DCF / UD / US / UB / UX / PC | Busca do arquivo XSD, enums de CST/CSOSN, defaults gerais, fuso, acentos, máscara decimal | — | ✅ nas funções citadas |
| VR | Regras de negócio locais; **re-soma** dos totais para comparar (não grava) | C | ⚠️ Parcial (lido só totais/chave) |
| K | `NAME_SPACE` (K:43) e 368 `DSC_*` (descrições usadas em alertas) | — | ✅ |

### 2.2 Classes do modelo (as que viram grupo no XML)

| Classe | Linha | Nº props | Grupo XML |
|---|---|---|---|
| `TNFe` | C:2938 | 24 (C:2974-2997) | raiz `NFe` |
| `TinfNFe` | C:64 | 2 (`ID`, `Versao`) | `infNFe@Id/@versao` |
| `TIde` (+`TNFrefCollection`, `TRefNF`, `TRefNFP`, `TRefECF`) | C:224 | 33 (C:269-303) | `ide`, `NFref` |
| `TEmit` / `TenderEmit` | C:338 / C:308 | 10 / 11 | `emit`, `enderEmit` |
| `TAvulsa` | C:369 | 11 | `avulsa` |
| `TDest` / `TEnderDest` | C:429 / C:399 | 9 / 11 | `dest`, `enderDest` |
| `TRetirada` / `TEntrega` | C:458 / C:496 | 15 / 15 | `retirada`, `entrega` |
| `TDetCollectionItem` | C:1951 | 9 (C:1968-1977) | `det` |
| `TProd` | C:999 | 41 (C:1058-1099) | `prod` |
| `TICMS` | C:1104 | 62 (C:1173-1239) | `ICMS/ICMSxx`, `ICMSSNxxx`, `ICMSPart`, `ICMSST` |
| `TIPI`, `TII`, `TPIS`, `TPISST`, `TCOFINS`, `TCOFINSST`, `TISSQN`, `TICMSUFDest` | C:1244…1416 | 11, 4, 6, 6, 7, 6, 18, 9 | grupos de `imposto` |
| `TImposto` | C:1889 | 12 | `imposto` |
| `TICMSTot` / `TISSQNtot` / `TretTrib` / `TTotal` | C:1995 / 2062 / 2114 / 2259 | 29 / 12 / 7 / 6 | `total` |
| `TTransp` (+ transporta, retTransp, veicTransp, reboque, vol, lacres) | C:2430 | 8 | `transp` |
| `TCobr` / `TFat` / `TDupCollectionItem` | C:2500 / 2457 / 2473 | 2 / 4 / 3 | `cobr` |
| `TpagCollection(Item)` | C:2553 / 2517 | 2 / 13 | `pag/detPag/card` |
| `TinfIntermed`, `TInfAdic`, `TExporta`, `TCompra`, `Tcana`, `TinfRespTec`, `Tagropecuario` | C:2572…2904 | 2, 5, 5, 3, 10, 6, 2 | grupos finais |
| `TinfNFeSupl` | C:2828 | 2 | `infNFeSupl` (NFC-e / DANFE simplificado tipo 2) |
| `TinfPAA` | C:2921 | 4 | ⚠️ sem escrita no writer (só leitura — change-log de 26/05/2026) |

Tipos numéricos que importam para a formatação: `qCom`, `qTrib`, `vProd` e todos os valores/percentuais de `TICMS` são
`Currency` (ponto fixo, 4 casas) (C:1069, C:1071, C:1075, C:1177-1236); `vUnCom`/`vUnTrib` são `Double` (C:1070, C:1076).

### 2.3 Descartados (só registro de existência)

`ACBrNFe\PCNNFe\` (writer/reader antigos `pcnNFeW/pcnNFeR` — o writer vivo usa só `pcnConversaoNFe` dali, W:43);
`*IniReader/*IniWriter/*JSONReader/*JSONWriter` (NF:234-238); relatórios; `ACBrECFVirtualNFCe\` (único lugar que
**soma totais** — `ACBrECFVirtualNFCe.pas:783-870`); `__recovery\`; CAPICOM/WinCrypt/MSXML — desligados por padrão
(INC:56 `DFE_SEM_CAPICOM`, INC:58 `DFE_SEM_MSXML`; a escolha `xsMsXml` levanta exceção quando compilado sem suporte, S:1944-2001).

---

## 3. Mapa modelo → XML por grupo (seção central)

### 3.0 Mecânica comum do writer (vale para todo campo)

| Regra | Comportamento | Evidência |
|---|---|---|
| Assinatura de campo | `AddNode(tipo, ID-do-MOC, tag, min, max, ocorrência, valor)`; ocorrência 1 = obrigatório, 0 = opcional | XW:243-465 |
| String (`tcStr`) | `Trim`; vazia = "vazio" | XW:276-280 |
| String numérica com zeros (`tcNumStr`) | completa com zeros à esquerda até o mínimo | XW:282-289 |
| Só dígitos (`tcEsp`) | não filtra: só alerta se não for número | XW:386-394 |
| Inteiro (`tcInt`) | `0` com ocorrência 0 = vazio; completa com zeros até o mínimo (ex.: `cUF` 2, `cNF` 8, `CEP` 8) | XW:396-412 |
| Decimal (`tcDe2…tcDe10`) | casas FIXAS pelo tipo, separador `.`, sem milhar; arredondamento delegado ao `FormatFloat` do RTL | XW:338-384, UB:215-229, UB:293-313 |
| Zero opcional | valor 0 com ocorrência 0 **some** do XML; zero obrigatório sai `0.00` | XW:369, XW:449 |
| Obrigatório vazio | o elemento é criado VAZIO (não falha) + alerta "vazio" quando `min > 0` | XW:423-424, XW:442-446 |
| Tamanho | acima do máximo = só alerta; **não trunca** | XW:430-431, XW:449-458 |
| Datas | `tcDat` = `AAAA-MM-DD` (data 30/12/1899 = vazio); `tcHor` = `hh:mm:ss` | XW:297-325 |
| Data-hora com fuso | `dhEmi`, `dhSaiEnt`, `dhCont`, `dhRecbto` = `AAAA-MM-DDThh:mm:ss±hh:mm` sem milissegundos (§3.13) | W:519-526, W:622-624, UD:178-184, UD:254-267 |
| Texto | `FiltrarTextoXML`: retira acentos (default ligado — DCF:546), colapsa espaços duplos (DCF:547), troca quebra de linha pelo separador configurado (default `\|` — DCF:785), `Trim` | XW:453-455, XB:161-180 |
| Acentos | `TiraAcentos` translitera e troca por ESPAÇO qualquer byte fora de ASCII 32–126 | US:1265-1282 |
| Entidades | o filtro não escapa (`ParseText` comentado, XB:168); o escape de `& < >` fica com o serializador libxml2 (texto entra cru via `xmlNodeAddContent`) | XD:466, XD:1285-1289 |
| CDATA | conteúdo que contém `<![CDATA[` vira nó CDATA (usado no `qrCode` v1) | XD:456-461, W:387-388 |
| Serialização | UTF-8, sem declaração `<?xml?>`, vazio serializado como par abre/fecha, sem indentação (default) | XW:142, XD:50, DCF:548 |
| Alertas | lista de texto com `ID/tag/descrição/mensagem`; o XML sai mesmo com alertas (83 chamadas `wAlerta` no W) | XW:467-485 |
| CNPJ/CPF (`AddNodeCNPJCPF`) | só alfanuméricos; ≤ 11 → `CPF` (zeros à esquerda até 11); senão `CNPJ` (zeros até 14) — **inclusive vazio quando obrigatório** | XW:155-192 |
| CNPJ puro (`AddNodeCNPJ`) | alfanumérico em MAIÚSCULAS (`OnlyCPFCNPJAlphaNum`); fora do Brasil = tag vazia | XW:194-212, US:1210-1213 |

### 3.1 Árvore e ordem (raiz até 1º nível)

| Ordem | Elemento | Condição de geração | Evidência |
|---|---|---|---|
| raiz | `nfeProc@versao` (envolve `NFe` + `protNFe`) | só se `procNFe.nProt` preenchido | W:369-379, W:420-424, W:4193-4212 |
| raiz | `NFe` (namespace `http://www.portalfiscal.inf.br/nfe`) | sempre | W:367, N:53 |
| NFe/1 | `infNFe@Id="NFe"+chave @versao="4.00"` | sempre | W:427-434 |
| infNFe/1 | `ide` | sempre | W:436 |
| infNFe/2 | `emit` | sempre | W:437 |
| infNFe/3 | `avulsa` | só se `Avulsa.CNPJ` não vazio | W:438, W:840-871 |
| infNFe/4 | `dest` | dest com documento, ou idEstrangeiro, ou UF=EX, **ou modelo ≠ 65** (55 sempre tem) | W:440-442 |
| infNFe/5 | `retirada` | se `xLgr` preenchido | W:444, W:983-1031 |
| infNFe/6 | `entrega` | se `xLgr` preenchido | W:445, W:1033-1081 |
| infNFe/7 | `autXML` (0..n; alerta acima de 10) | um por item da lista | W:447-451, W:1144-1158 |
| infNFe/8 | `det@nItem` (alerta acima de 990) | um por item | W:453-457, W:1160-1189 |
| infNFe/9 | `total` | sempre | W:459 |
| infNFe/10 | `transp` | sempre (`modFrete` obrigatório) | W:460, W:3782-3805 |
| infNFe/11 | `cobr` | se houver fatura ou duplicata | W:461, W:3657-3677 |
| infNFe/12 | `pag` | versão ≥ 4: **sempre um** `pag` (mesmo sem `detPag`) | W:463-476, W:3726-3730 |
| infNFe/13 | `infIntermed` | v4 e (`CNPJ` ou `idCadIntTran`) | W:478, W:4049-4063 |
| infNFe/14 | `infAdic` | qualquer de infAdFisco/infCpl/obsCont/obsFisco/procRef | W:479, W:3941-3974 |
| infNFe/15 | `exporta` | `UFSaidaPais` ou `xLocExporta` | W:480, W:4065-4091 |
| infNFe/16 | `compra` | `xNEmp`/`xPed`/`xCont` | W:481, W:4093-4103 |
| infNFe/17 | `cana` | safra/ref/forDia/deduc | W:482, W:4105-4138 |
| infNFe/18 | `infRespTec` | v4 e `CNPJ` preenchido | W:484-485, W:4173-4191 |
| — | `infSolicNFF` | ⚠️ **não gerado** (existe no XSDref:6483) | ausente em W e C |
| infNFe/19 | `agropecuario` | defensivo (prioridade) OU guiaTransito | W:487, W:1105-1142 |
| — | `infPAA` | ⚠️ **não gerado** (existe no XSDref:6585 e em C:2921) | ausente em W |
| NFe/2 | `infNFeSupl` (`qrCode`, `urlChave` v4) | se `qrCode` preenchido (NFC-e ou DANFE simplificado tipo 2) | W:384-397 |
| NFe/3 | `Signature` | conforme `GerarTagAssinatura` (default: só se já houver digest+assinatura+certificado) | W:266, W:399-418 |

A ordem do writer coincide com a sequência do XSDref para os 19 grupos gerados (conferido nomes/posição: XSDref:6478 `infRespTec`,
6483 `infSolicNFF`, 6503 `agropecuario`, 6585 `infPAA`).

### 3.2 `ide`

Campos em ordem (W:490-645; 33 `AddNode` incluindo ramos de versão): `cUF` (int 2; alerta se UF inválida — U:860-865),
`cNF` (int 8), `natOp` (1–60), [`indPag` só v<4], `mod`, `serie` (1–3), `nNF` (1–9), `dhEmi` (fuso), `dhSaiEnt` (só
modelo 55 e data ≠ 0), `dPrevEntrega` (opcional, data), `tpNF`, `idDest` (v≥3), `cMunFG` (7, alerta se DV inválido),
[`cMunFGIBS` — RTC], [`NFref` só v<3 aqui], `tpImp`, `tpEmis`, `cDV`, `tpAmb`, `finNFe`, [`tpNFDebito`/`tpNFCredito` — RTC,
W:586-595], `indFinal`, `indPres` (v≥3), `indIntermed` (v4, opcional), `cIndOp` (v4, opcional, 6 com zeros), `procEmi`,
`verProc` (1–20), `dhCont`+`xJust` (só se algum preenchido), `NFref` (v≥3: um por referência), [`gCompraGov`,
`gPagAntecipado` — RTC, W:643-644].

`NFref` (W:647-760): cada item escolhe `refNFe`/`refNFeSig` (44, literais removidos, alerta se chave inválida), `refNF`
(cUF, AAMM, CNPJ, mod, serie, nNF), `refNFP` (cUF, AAMM, CNPJ/CPF, IE, mod, serie, nNF), `refCTe` (44) ou `refECF`
(mod, nECF 3, nCOO 6) — pela presença do campo; alerta acima de 999.

### 3.3 `emit`, `avulsa`, `dest`, `retirada`, `entrega`, `autXML`

| Grupo | Campos (ordem) | Regras/condições | Evidência |
|---|---|---|---|
| `emit` | CNPJ/CPF, xNome (2–60), xFant (opc), `enderEmit`, IE, IEST (opc), IM (opc), CNAE (só se IM), CRT, ISUFEmit (opc) | IE: só dígitos, exceto o literal `ISENTO`; IE vazia sai como elemento VAZIO (min 0, ocorrência 1); validação de IE só com opção ligada | W:762-803 |
| `enderEmit` | xLgr, nro, xCpl, xBairro, cMun, xMun, UF, CEP (8), cPais, xPais, fone (só dígitos) | `cPais` sai SEMPRE 1058 (ignora o modelo); `nro` pode virar 3 dígitos com zeros se `AjustarTagNro` | W:805-838, U:1261-1271 |
| `avulsa` | CNPJ, xOrgao, matr, xAgente, fone, UF, nDAR, dEmi, vDAR, repEmi, dPag | só NFA-e (CNPJ do fisco); muda o CNPJ da CHAVE (W:355-356) | W:840-871 |
| `dest` | idEstrangeiro **ou** CNPJ/CPF, xNome, `enderDest`, indIEDest, IE, ISUF, IM, email | estrangeiro se idEstrangeiro ou cPais ∉ {0,1058}; em 55 o documento é obrigatório (vazio vira `00000000000000`); **homologação sobrescreve `xNome`** com o texto padrão do fisco; xNome obrigatório só no 55; `enderDest` sempre no 55 e, no 65, só com `xLgr`; IE só se `indIEDest ≠ 2` E IE preenchida (literal `ISENTO` preservado) | W:873-944, XW:179-185 |
| `enderDest` | xLgr…fone (CEP opcional) | exterior: cMun 9999999, xMun `EXTERIOR`, UF `EX` | W:946-981, W:296-313 |
| `retirada` / `entrega` | CNPJ/CPF (sem zeros à esquerda, opcional), xNome, endereço, CEP, cPais, xPais, fone, email, IE | só com `xLgr` | W:983-1081 |
| `autXML` | CNPJ/CPF | lista | W:1144-1158 |

### 3.4 `det/prod`

Campos em ordem (W:1191-1366): `cProd`, `cEAN` (vazio vira `SEM GTIN` na v4 após 01/12/2018; GTIN validado só
como alerta), `cBarra` (opc), `xProd` (1–120; **item 1 vira texto padrão de homologação** em H para modelo 65 ou 55 com
DANFE simplificado tipo 2), `NCM` (2–8), `NVE` (0..8), `CEST`+`indEscala`+`CNPJFab` (só se CEST tem dígitos),
`cBenef` (opc), `gCred` (0..4), [`tpCredPresIBSZFM` — RTC], `EXTIPI` (opc), `CFOP` (só dígitos), `uCom`, `qCom`,
`vUnCom`, `vProd`, `cEANTrib` (mesma regra `SEM GTIN`), `cBarraTrib`, `uTrib`, `qTrib`, `vUnTrib`, `vFrete`/`vSeg`/
`vDesc`/`vOutro` (opcionais, somem se zero), `indTot`, [`indBemMovelUsado` — RTC], `DI` (0..100), `detExport` (0..500),
`xPed`, `nItemPed` (só dígitos), `nFCI` (36), `rastro` (0..500), `veicProd`, `med` (0..1 na v4), `arma` (0..500), `comb`,
`nRECOPI` (20, validado como alerta).

| Subgrupo | Gatilho | Campos | Evidência |
|---|---|---|---|
| `DI` / `adi` | lista | nDI, dDI, xLocDesemb, UFDesemb, dDesemb, tpViaTransp, vAFRMM (obrig. se marítima), tpIntermedio, CNPJ/CPF, UFTerceiro, cExportador, `adi`(nAdicao opc, nSeqAdic, cFabricante, vDescDI, nDraw) | W:1368-1467 |
| `detExport` / `exportInd` | lista; `exportInd` se nRE ou chNFe | nDraw; nRE, chNFe, qExport | W:1488-1529 |
| `rastro` | lista (v4) | nLote, qLote (3 casas), dFab, dVal, cAgreg | W:1531-1554 |
| `veicProd` | `chassi` preenchido | 22 campos (tpOp…tpRest) | W:1556-1623 |
| `med` | lista | v4: cProdANVISA, xMotivoIsencao, vPMC | W:1625-1666 |
| `arma` | lista | tpArma, nSerie, nCano, descr | W:1668-1688 |
| `comb` (+ CIDE, encerrante, origComb) | `cProdANP > 0` | cProdANP, descANP, pGLP/pGNn/pGNi/vPart (só GLP 210203001; 100 sai com 2 casas, demais com 4), CODIF, qTemp, UFCons, CIDE (se algum >0), encerrante (se nBico), pBio, origComb (0..30) | W:1690-1841 |
| `gCred` | lista (v4) | cCredPresumido, pCredPresumido, vCredPresumido | W:3471-3494 |

Fechamento do `det` (W:1160-1189): `prod` → `imposto` → `impostoDevol` (se `pDevol > 0`: pDevol 2 casas + `IPI/vIPIDevol`,
W:3459-3469) → `infAdProd` (1–500) → `obsItem` (obsCont/obsFisco com atributo `xCampo`, W:3212-3250) → [`vItem`,
`DFeReferenciado` — RTC].

### 3.5 `det/imposto`

**Escolha do bloco** (W:1889-1943): `vTotTrib` (opc) → se o item tem ISSQN (`cSitTrib` informado ou `cListServ` na v>3)
gera `IPI` + `ISSQN` (item de serviço na NF-e conjugada); senão `ICMS` + `IPI` + `II`. Depois sempre `PIS`, `PISST`,
`COFINS`, `COFINSST`, `ICMSUFDest` (se `pICMSInterPart > 0`). Todo esse bloco é SUPRIMIDO quando `finNFe` é crédito/débito
ou `tpOperGov` = recebimento — salvo os tipos de crédito/débito listados (W:1895-1913). Por fim `IS` e `IBSCBS` (RTC).

**ICMS — despacho** (W:1945-2982): CST monofásico 02/15/53/61 vai a grupo próprio **independente do CRT** (W:2010-2088);
os demais seguem o CRT do emitente: regime normal ou Simples com excesso de sublimite → grupos por CST (W:2092-2101); Simples
ou MEI → grupos por CSOSN (W:2763-2768). Nome do grupo: `ICMS`+sufixo (W:1951-1976; CSOSN: DC:1282-1292).

| Grupo (CST) | Campos obrigatórios | Condicionais | Evidência |
|---|---|---|---|
| ICMS00 | orig, CST, modBC, vBC, pICMS, vICMS | FCP (pFCP, vFCP) se algum > 0 | W:2103-2126 |
| ICMS02 | orig, CST, qBCMono, adRemICMS, vICMSMono | — | W:2021-2029 |
| ICMS10 | modBC, vBC, pICMS, vICMS, modBCST, vBCST, pICMSST, vICMSST | pRedBC/pBCOp/UFST só se UFST/pBCOp (ou Part10); FCP e FCPST se algum >0; pMVAST/pRedBCST opc; vICMSSTDeson+motDesICMSST se >0 | W:2128-2230 |
| ICMS15 | qBCMono, adRemICMS, vICMSMono, qBCMonoReten, adRemICMSReten, vICMSMonoReten | pRedAdRem+motRedAdRem se qBCMono ≠ 0 | W:2031-2053 |
| ICMS20 | modBC, pRedBC, vBC, pICMS, vICMS | FCP; vICMSDeson+motDesICMS(+indDeduzDeson) se >0 | W:2232-2282 |
| ICMS30 | modBCST, vBCST, pICMSST, vICMSST | pMVAST/pRedBCST opc; FCPST; deson | W:2284-2329 |
| ICMS40 (CST 40, 41, 50) | orig, CST | vICMSDeson+motDesICMS(+indDeduzDeson) só se >0 | W:2330-2359 |
| ICMS51 | orig, CST | modBC, pRedBC, vBC, pICMS, vICMSOp, pDif, vICMSDif, vICMS **obrigatórios (mesmo zero) se cUF ∈ {33 RJ, 35 SP, 41 PR}**, senão opcionais; cBenefRBC opc; FCP; pFCPDif/vFCPDif/vFCPEfet se algum >0 | W:2361-2437 |
| ICMS53 | qBCMono | adRemICMS, vICMSMonoOp, pDif (100 com 2 casas), vICMSMonoDif, vICMSMono opcionais | W:2055-2076 |
| ICMS60 | orig, CST | vBCSTRet, pST, vICMSSTRet (+vICMSSubstituto opc) se algum >0 ou opção "forçar 938"; FCPSTRet se >0; pRedBCEfet/vBCEfet/pICMSEfet/vICMSEfet se algum >0 ou opção "forçar 906" com consumidor final | W:2439-2494, W:1978-2004 |
| ICMS61 | qBCMonoRet, adRemICMSRet, vICMSMonoRet | — | W:2078-2086 |
| ICMS70 | modBC, pRedBC, vBC, pICMS, vICMS, modBCST, vBCST, pICMSST, vICMSST | FCP, FCPST, deson, STDeson | W:2496-2576 |
| ICMS90 | orig, CST | bloco próprio (modBC, vBC, pRedBC, cBenefRBC, pICMS, [vICMSOp, pDif, vICMSDif], vICMS) só se vBC ou vICMS >0; FCP; FCPDif; bloco ST se vBCST/vICMSST/pICMSST >0; FCPST; deson; pBCOp/UFST; STDeson | W:2577-2724 |
| ICMSPart (CST 10/90 com partilha) | idem 10/90 + pBCOp + UFST | — | W:2128-2230, W:2577-2724 |
| ICMSPart (CST 20) | ⚠️ conteúdo do ICMS20, sem pBCOp/UFST, e **sem sufixo de tag** (falta ramo em W:1951-1976) | — | W:2232-2282 |
| ICMSST (41/60 repasse) | vBCSTRet, vICMSSTRet, vBCSTDest, vICMSSTDest | pST/vICMSSubstituto (opção "forçar 938"); FCPSTRet; ICMS efetivo | W:2725-2760 |

| Grupo (CSOSN) | Campos | Evidência |
|---|---|---|
| ICMSSN101 | orig, CSOSN, pCredSN, vCredICMSSN | W:2781-2788 |
| ICMSSN102 (102, 103, 300, 400) | orig (opcional nesses CSOSN), CSOSN | W:2769-2795 |
| ICMSSN201 | ST completo (modBCST…vICMSST), FCPST, pCredSN, vCredICMSSN | W:2796-2833 |
| ICMSSN202 (202, 203) | ST completo, FCPST | W:2834-2867 |
| ICMSSN500 | vBCSTRet/pST/vICMSSubstituto/vICMSSTRet (mesma regra do CST 60), FCPSTRet, ICMS efetivo | W:2868-2908 |
| ICMSSN900 | bloco próprio se vBC/vICMS >0; bloco ST se vBCST/vICMSST >0; FCPST; pCredSN se >0 | W:2909-2969 |

| Grupo | Regra | Evidência |
|---|---|---|
| `IPI` | **nunca no 65**; CST não tributado só sai com a opção `GerarTagIPIparaNaoTributado` (default ligada, W:263); CST 00 com tudo zerado e sem cEnq = grupo omitido; `cEnq` vazio vira `999`; `IPITrib` por alíquota (vBC, pIPI, vIPI) OU por unidade (qUnid, vUnid, vIPI) — misturar só alerta; `IPINT` para CST 01–05/51–55 | W:2984-3065 |
| `II` | se algum valor >0 OU CFOP começa com `3` (importação): vBC, vDespAdu, vII, vIOF | W:3067-3084 |
| `PIS` / `COFINS` | no 65 o grupo é omitido se tudo zero e CST fora de {04–09, 49, 99}; Aliq (01,02), Qtde (03), NT (04–09), Outr (49–99, por alíquota OU por quantidade) | W:3086-3166, W:3252-3336 |
| `PISST` / `COFINSST` | se algum >0; por alíquota ou por quantidade; `indSomaPISST`/`indSomaCOFINSST` (v4) se informado | W:3168-3210, W:3338-3384 |
| `ISSQN` | se algum valor/cMunFG/cListServ: vBC, vAliq, vISSQN, cMunFG, cListServ (5 na v≥3.10), vDeducao…indIncentivo | W:3386-3457 |
| `ICMSUFDest` (DIFAL) | se `pICMSInterPart > 0`: vBCUFDest, vBCFCPUFDest, pFCPUFDest, pICMSUFDest, pICMSInter, pICMSInterPart, vFCPUFDest, vICMSUFDest, vICMSUFRemet (todos obrigatórios) | W:1933-1934, W:3496-3538 |

### 3.6 `total`

`ICMSTot` (sempre — W:3557-3602): vBC, vICMS, vICMSDeson, [vFCPUFDest, vICMSUFDest, vICMSUFRemet opcionais], vFCP,
vBCST, vST, vFCPST, vFCPSTRet, [qBCMono, vICMSMono, qBCMonoReten, vICMSMonoReten, qBCMonoRet, vICMSMonoRet opcionais],
vProd, vFrete, vSeg, vDesc, vII, vIPI, vIPIDevol, vPIS, vCOFINS, vOutro, vNF, [vTotTrib opcional] — todos com 2 casas.
`ISSQNtot` se algum de vServ/vBC/vISS/vPIS/vCOFINS >0 (W:3604-3633; `dCompet` obrigatório nele). `retTrib` se alguma
retenção >0 (W:3635-3655). Depois [`ISTot`, `IBSCBSTot`, `vNFTot` — RTC] (W:3540-3555).

### 3.7 `transp`, `cobr`, `pag`

| Grupo | Regra | Evidência |
|---|---|---|
| `transp` | modFrete (obrig.) → `transporta` (se algum campo; CNPJ/CPF só se informado; IE só dígitos ou `ISENTO`) → `retTransp` (se algum) → `veicTransp` (se placa/UF/RNTC) → `reboque` (0..5) → vagao/balsa (opc) → `vol` (qVol, esp, marca, nVol, pesoL/pesoB 3 casas, `lacres`) | W:3782-3939 |
| `cobr/fat` | gera se nFat/vOrig/vDesc/vLiq; com `CamposFatObrigatorios` (default ligado — NC:204) os 4 campos são obrigatórios na v4 (zero sai `0.00`) | W:3679-3693 |
| `cobr/dup` | nDup e dVenc obrigatórios na v4, vDup; alerta acima de 120 | W:3695-3718 |
| `pag/detPag` | v4: um `pag` com N `detPag`: indPag (opc), tPag (obrig.), xPag (opc), vPag, dPag (opc), CNPJPag+UFPag (par, se algum), `card` (se tpIntegra informado: tpIntegra, CNPJ, tBand, cAut, CNPJReceb, idTermPag); `vTroco` opcional no fim; alerta acima de 100 | W:3720-3780 |

### 3.8 Grupos finais

`infIntermed` (CNPJ, idCadIntTran — W:4049-4063); `infAdic` (infAdFisco 1–2000, infCpl 1–5000, obsCont/obsFisco 0..10
com atributo `xCampo` ≤ 20 só como alerta, procRef 0..100 — W:3941-4047); `exporta` (UFSaidaPais, xLocExporta,
xLocDespacho — W:4065-4091); `compra` (W:4093-4103); `cana` (quantidades com 10 casas — W:4105-4171); `infRespTec`
(CNPJ, xContato, email, fone; `idCSRT`+`hashCSRT` só com CSRT configurado — W:4173-4191); `agropecuario` (W:1083-1142).

### 3.9 O que o writer CALCULA/DERIVA × recebe pronto

| Calcula/deriva | Evidência |
|---|---|
| Chave de acesso, `Id`, `cDV`, `cNF` (aleatório quando 0) | W:353-364, U:196-237 |
| `URI` da assinatura (`#NFe`+chave) | W:415 |
| `hashCSRT` = Base64(SHA-1(CSRT + chave)) | W:4187-4188, U:585-588 |
| `cEAN`/`cEANTrib` vazios → `SEM GTIN`; `cEnq` vazio → `999` | W:1205-1207, W:1279-1281, W:3021-3022 |
| Endereço do exterior (9999999 / EXTERIOR / EX); `cPais` do emitente fixo 1058 | W:296-313, W:831-832 |
| Textos de homologação em `dest/xNome` e `xProd` do item 1 | W:878, W:896-897, W:1193, W:1222-1225 |
| Fuso do `dh*` (§3.13) | UD:178-184 |
| **NÃO calcula**: base, alíquota, valor de nenhum imposto, FCP, ST, DIFAL, totais (`ICMSTot`, `vNF`), parcelas, troco | nenhum cálculo em W; a única soma de totais do ACBr está no descartado `ACBrECFVirtualNFCe.pas:783-870` |
| VR **re-soma** os itens só para COMPARAR com os totais informados (tolerância 0,001) e rejeitar localmente (531…610, 685, 861–863); `vNF` esperado = vProd + vST + vFrete + vSeg + vOutro + vII + vIPI + vServ + vFCPST + vICMSMonoReten + vIPIDevol + PISST/COFINSST que compõem − (vDesc + vICMSDeson); com faturamento direto de veículo sai vST/vFCPST/MonoReten/IPIDevol; soma por `indTot` | VR:112, VR:965-1037, VR:1040-1132 |

### 3.10 Efeitos colaterais do writer no modelo (o writer MUTA o objeto)

`infNFe.ID`, `ide.cDV`, `ide.cNF` (W:362-364); `Prod.cEAN`/`cEANTrib` (W:1207, W:1281); `Dest.xNome` em H (W:897);
`Prod.xProd` do item 1 (W:1225); `IPI.cEnq` (W:3022); `Dest.indIEDest` na v<3.10 (W:912); `signature.URI` (W:415).

### 3.11 Formatação decimal por campo (NF-e 4.00)

| Campo(s) | Tipo/casas | Evidência |
|---|---|---|
| `qCom`, `qTrib` | 4 casas (até 15) | W:1271-1272, W:1298-1299 |
| `vUnCom`, `vUnTrib` | 10 casas na v≥2 (até 21) | W:348-351, W:1273-1274, W:1300-1301 |
| `vProd`, `vFrete`, `vSeg`, `vDesc`, `vOutro`, todo valor monetário de imposto e de total | 2 casas | W:1275-1309, W:3557-3602 |
| Percentuais `pICMS`, `pRedBC`, `pMVAST`, `pICMSST`, `pFCP*`, `pPIS`, `pCOFINS`, `pIPI`, `vAliq`, `pST`, `pCredSN`, `pDif` | 4 casas na v≥3.10 (`FormatoValor4ou2`) | W:341-346, ex.: W:2109-2111 |
| `pMVAST` no CST 90 | ⚠️ 2 casas (exceção) | W:2660-2661 |
| `pRedBC` no CST 10 | 2 casas | W:2138-2139 |
| `pICMSInter`, `pDevol`, `pICMSRet` | 2 casas | W:3520-3521, W:3464-3465, W:3854 |
| `qBCMono*`, `adRem*` (item) / `qBCMono*` (total) | 4 / 2 casas | W:2023-2026, W:3581-3586 |
| `qLote`, `pesoL`, `pesoB` | 3 casas | W:1542, W:3917-3918 |
| `qBCProd`, `vAliqProd` (PIS/COFINS/CIDE), `qUnid`, `vUnid` (IPI), `qExport`, `qTemp`, `pBio`, `pOrig` | 4 casas | W:3118-3121, W:3038-3041, W:1523, W:1743, W:1774, W:1836 |
| `cana` (qtde, qTotMes…) | 10 casas | W:4124-4126, W:4153 |

### 3.12 Chave de acesso

| Aspecto | Comportamento | Evidência |
|---|---|---|
| Composição (44) | cUF(2) + AAMM(4, `YYMM` do `dEmi` após ajuste de UF) + CNPJ/CPF(14, só alfanuméricos, zeros à esquerda) + mod(2) + série(3) + nNF(9) + tpEmis(1) + cNF(8) + cDV(1) | U:196-237 |
| CNPJ da chave | do emitente; na NFA-e, o CNPJ do fisco (`avulsa`) | W:353-356 |
| cNF | 0 ou −1 → aleatório; ≤ −2 → 0 (pode ser recusado); qualquer outro valor é usado como veio (sem validar) | U:203-213 |
| Aleatório | sorteio até cNF ≠ nNF e fora de 20 sequências proibidas (00000000, 11111111…, 12345678…) | U:184-194, U:978-999 |
| cDV | módulo 11 com pesos 2..9 ciclando da direita para a esquerda; valor do caractere = código ASCII − 48 (dígitos 0–9; letras A=17…); resto < 2 → DV 0; senão 11 − resto | U:236, V:644-660, V:2147-2183 |
| CNPJ alfanumérico | letras entram no cálculo pelo ASCII−48 (mesma regra acima); validação de CNPJ aceita alfanuméricos nas 12 primeiras posições (DVs numéricos) | V:852, V:864-875 |
| Caixa das letras | ⚠️ a geração da chave não converte para maiúsculas (U:217; V:76) — só `ValidarConcatChave` e a conferência do certificado convertem (NF:807, S:1678) | §6 item 13 |
| Validação | 44 posições, DV (pesos `4329876…432`, mesma conta — U:665-688), UF válida, AAMM válido, CNPJ/CPF válido pela série (CPF nas séries 910–969 e na NFF) | U:772-810, U:1051-1109 |
| `Id` | `"NFe"` + 44 | W:362 |
| Regeneração | a chave é recalculada a cada `GerarXML` a partir do modelo; nome de arquivo `<chave>-nfe.xml` | W:358-364, NF:694-697, NF:742-755 |
| Chave de contingência FS-DA (36, DANFE em formulário de segurança) | outra coisa — o ajuste de 30/07/2026 "chaves alfanuméricas" do change-log é nela | N:407-479, `ACBrNFe-change-log.txt:52-57` |

### 3.13 Data/hora e fuso

`dhEmi` = parede do `dEmi` + offset de `GetUTC` (W:519-521, UD:178-184). O "ajuste para UF" não converte a hora — só
devolve o mesmo valor e o offset, salvo se a aplicação instalar um gancho (UD:203-213). O offset depende do modo: **padrão
= fuso do sistema operacional** (UD:84, UD:99, UD:271-273); modo "PCN" = tabela por UF (AC −05, AM/RR/RO/MT/MS −04,
demais −03 — UD:283-315); modo manual = texto fixo. Horário de verão: a tabela segue no código mas devolve falso para
datas após 2019 (UD:361-376, UD:399-407). O AAMM da chave usa a mesma parede (U:216) — chave e `dhEmi` coerentes.

### 3.14 Assinatura

| Aspecto | Comportamento | Evidência |
|---|---|---|
| Algoritmos | padrão RSA-SHA1 + digest SHA-1; SHA-256/512 selecionáveis | S:467, S:1307, U:422-438 |
| C14N | padrão C14N 1.0 inclusiva (`REC-xml-c14n-20010315`) em `CanonicalizationMethod` e no 2º `Transform`; exclusiva selecionável | S:468, S:1310, U:440-448 |
| Transforms | `enveloped-signature` + C14N | U:457-460, XW:503-505 |
| Reference | `URI="#NFe<chave>"` (lida do 1º atributo `Id=` após `<NFe`) | W:415, U:477-504 |
| Posição | `Signature` como ÚLTIMO filho de `NFe` (irmão seguinte de `infNFe`/`infNFeSupl`) | NF:345, L2:202-203, L2:719-758, XS:453-458 |
| KeyInfo | `X509Data/X509Certificate` só com o certificado do signatário (DER Base64), sem cadeia, sem KeyValue | L2:238-242, XS:538, S:1132-1220 |
| Bibliotecas | xmlsec1 (insere DTD temporário para o `Id` ser reconhecido, assina o template, remove o DTD) ou libxml2 "manual" (canonicaliza `infNFe` copiando os namespaces da raiz, SHA do canônico, insere template, canonicaliza `SignedInfo`, assina RSA via OpenSSL `EVP_SignFinal`) | XS:486-548, XS:758-767, L2:142-267, L2:294-378, OS:321-390 |
| Escolha da lib | sem default declarado na configuração (a aplicação escolhe) | DCF:235, DCF:533-535 |
| Pós-assinatura | remove quebras de linha e espaços dentro de `SignatureValue…KeyInfo` | S:1175-1177, S:1216-1217, L2:261 |
| Conferência CNPJ | antes de assinar, compara a RAIZ (8 primeiras posições) do CNPJ do documento com o do certificado — filial assina com A1 da matriz; ignora se algum não for CNPJ de 14 | NF:333-334, S:1674-1696 |
| Verificação | recalcula o digest do `infNFe` canônico e confere o `SignatureValue` com a chave pública do X509 embutido; algoritmo lido do próprio XML | NF:438-468, L2:459-549, S:1222-1245 |
| Origem do A1 | PKCS#12 (`PKCS12parse`) | OS:210-238 |

### 3.15 Validação XSD

`Validar` usa o XML assinado, extrai só `NFe` (sem `nfeProc`), escolhe o leiaute de autorização (v≥3.10) e valida com
libxml2 `xmlSchemaValidateDoc` (NF:390-436, L2:380-457, XS:550-637). Arquivo = `PathSchemas` (default `<app>\Schemas`,
DCF:1252-1260) + nome do schema (`Nfe`, do enum — CV:1229-1233) + `_v` + versão (`4.00`) + `.xsd`; sem o arquivo exato,
pega a maior versão ≤ pedida (D:375-442, D:44-45). Falha = exceção com o `nNF`, os alertas do writer e o erro do libxml2
(NF:425-434). Na referência de terceiro, `nfe_v4.00.xsd` inclui `leiauteNFe_v4.00.xsd`, que importa `xmldsig-core-schema_v1.01.xsd`
e inclui `tiposBasico_v4.00.xsd` e `DFeTiposBasicos_v1.00.xsd` (XSDref:4-6). O ACBr não fixa número de pacote PL no código.

### 3.16 NFC-e: QR Code e `infNFeSupl` (registro)

Gerado DEPOIS da assinatura (precisa do `DigestValue`) para modelo 65 ou 55 com DANFE simplificado tipo 2; em seguida o XML
é re-serializado (NF:360-376). Versão do QR: padrão v2 (NC:203), mínimo v1 na 4.00 (N:502-509). v1: parâmetros em
query string + `cHashQRCode` = HEX(SHA-1(parâmetros + CSC)) (N:648-695). v2: `chave|2|tpAmb|` (+ `dia|vNF|digVal-hex|`
off-line tpEmis 9) + `idCSC` e hash HEX(SHA-1(entrada + idCSC + CSC)) (N:697-737). v3: `chave|3|tpAmb`; off-line acrescenta
`dia|vNF|tpDest|doc` + assinatura RSA-SHA1 Base64 com o A1, sem CSC (N:739-775). URLs por UF × ambiente × versão no
`ACBrNFeServicos.ini` (`URL-QRCode`, `URL-ConsultaNFCe`). PR/SP/MS recebem hex minúsculo (N:663-667). CSC vazio →
derivado da chave (N:673-674). `qrCode` com CDATA só quando não é o formato `?p=` (W:387-388).

### 3.17 Onde entra o grupo IBS/CBS (posição apenas — fora desta frente)

`ide`: `cMunFGIBS` após `cMunFG` (W:557-563); `tpNFDebito`/`tpNFCredito` após `finNFe` (W:586-595); `gCompraGov` e
`gPagAntecipado` no FIM do `ide` (W:643-644, W:4215-4261). `prod`: `tpCredPresIBSZFM` antes de `EXTIPI` (W:1263-1264);
`indBemMovelUsado` após `indTot` (W:1315-1317). `imposto`: `IS` e `IBSCBS` por último (W:1937-1942, W:4263-4358); o
`IBSCBS` só sai com CST e `cClassTrib` (W:4306) e liga a geração do `IBSCBSTot`. `det`: `vItem` e `DFeReferenciado` após
`obsItem` (W:1180-1184). `total`: `ISTot` e `IBSCBSTot` após `retTrib`, `vNFTot` por último (W:3548-3554, W:4780-4822).
Reforma exige o caminho `ACBrXmlDocument` (INC:61-64).

---

## 4. Fluxo de dados (gerar → assinar → validar → gravar → enviar)

1. **Criação do item** — `NotaFiscal.Create` cria o `TNFe` com defaults: `tpNF` saída, `indPag` à vista, `verProc`
   `ACBrNFe`, `xPais` BRASIL/1058, `nro` "SEM NUMERO", e copia da configuração no momento da criação: modelo, versão,
   `tpAmb`, `tpEmis` (NF:220-258).
2. **Preenchimento** — pela aplicação (Delphi do Gestao2016) ou pelos leitores INI/JSON/XML (descartados aqui).
3. **GerarXML** — copia opções (acentos, espaços, quebra de linha, fatura obrigatória, forçar 938/906, CSRT, fuso) e roda o
   writer; versão/modelo/ambiente do XML vêm do MODELO, não da configuração (bloco comentado: NF:666-674, W:327-335). Altera
   o modelo (§3.10); guarda `XMLOriginal` em UTF-8; recalcula o nome de arquivo se a chave mudou; guarda alertas
   (NF:633-705).
4. **Assinar** — confere raiz do CNPJ × certificado; GERA DE NOVO; converte para UTF-8; assina `infNFe`; lê de volta
   URI/Digest/Signature/X509 para o modelo; se NFC-e/simplificado: calcula QR e `urlChave` e GERA DE NOVO (o XML assinado
   passa a ser a re-serialização do modelo com a `Signature` reconstituída — NF:862-876); grava em disco se configurado
   (NF:325-388).
5. **Validar** — XSD (§3.15); exceção em caso de erro (NF:390-436).
6. **ValidarRegrasdeNegocios** — opcional; não é chamado por `Enviar` (NF:470-496, N:880-883).
7. **Enviar** — limite de 50 notas por lote (N:876-878); `Assinar` + `Validar` em todas (N:880-881); o lote `enviNFe`
   recorta cada `<NFe…</NFe>` do XML assinado, acrescenta `idLote`/`indSinc`, opcionalmente GZip+Base64; recusa lote acima
   de 500 KB (WS:1143-1173). O que acontece daí em diante é de outra frente (WebServices).
8. **Tratamento de erro** — gerar: alertas, nunca exceção; assinar/validar: exceção; regras de negócio: lista de erros.

---

## 5. Integrações externas identificadas

| Integração | Uso | Autenticação | Evidência |
|---|---|---|---|
| libxml2 (DLL) | DOM do writer, C14N, validação XSD | — | XD:1278-1300, L2:380-457 |
| xmlsec1 (DLL, opcional) | assinatura XMLDSig | — | XS:143-257, XS:438-484 |
| OpenSSL (DLL) | PKCS#12, digest, RSA | senha do PFX (configuração, sem literal no código lido) | OS:210-238, OS:321-390 |
| Pasta de schemas (`.xsd`) | validação | — | D:375-442, DCF:1252-1260 |
| `ACBrNFeServicos.ini` | URLs do QR Code / consulta NFC-e por UF × ambiente | — | N:545, N:562, N:653 |
| Arquivo de municípios (IBGE) | só se `NormatizarMunicipios` | — | W:308-312 |
| SEFAZ (SOAP) | lote `enviNFe` | mTLS com o A1 | WS:1143-1173 (fora desta frente) |

Nenhuma credencial literal e nenhum texto dirigido a IA foram encontrados nos arquivos lidos (busca em W, C, CV, K, NF, N,
U, XW, XB, S, XS, L2, OS).

---

## 6. Pendências e inconsistências

| # | Sev. | Achado | Evidência |
|---|---|---|---|
| 1 | 🟡 | `cstPart20` (partilha com CST 20) entra no ramo do CST 20, mas a função de sufixo não tem esse caso → tag do grupo sem sufixo e sem `pBCOp`/`UFST`; o XSDref aceita CST 20 no `ICMSPart` (XSDref:3616, 3640-3642) | W:1951-1976, W:2232-2282 |
| 2 | 🟡 | Obrigatório vazio vira elemento vazio (sem falha) — ex.: `emit/IE` vazia → `<IE></IE>`, rejeitado só no XSD | XW:442-446, W:772-776 |
| 3 | 🟡 | `dest` do 55 sem documento sai com CNPJ `00000000000000` | XW:179-185, W:891 |
| 4 | 🟡 | `pag` sempre gerado na v4, mesmo sem `detPag` (XSD exige ao menos um) | W:463-468, W:3726-3730 |
| 5 | 🟡 | Strings acima do máximo não são truncadas — só alerta | XW:430-431, XW:449-458 |
| 6 | 🟢 | O alerta de "excesso de casas decimais" nunca dispara: a checagem lê a string já formatada com N casas | XW:371-375 |
| 7 | 🟡 | `PISST`/`COFINSST`: com alíquota E quantidade informadas, o 2º grupo substitui o 1º (só alerta) | W:3181-3208, W:3353-3382 |
| 8 | 🟢 | `pMVAST` do CST 90 com 2 casas (demais CST: 4) — perde precisão | W:2660-2661 |
| 9 | 🟢 | `entrega` valida `cMun`/`UF` crus (não os ajustados) e usa o ID `F07` da retirada | W:1059-1064 |
| 10 | 🟢 | `not ValidarCodigoPais(x) = -1` — precedência do `not` sobre smallint; ⚠️ intenção não confirmada | W:975, W:1020, W:1070 |
| 11 | 🟢 | Regra 502 (chave × campos) comentada no validador; `ValidarConcatChave` sem chamador ativo | VR:1276-1284, NF:794-814 |
| 12 | 🟢 | Versão/modelo/ambiente da configuração não são reaplicados ao gerar (bloco comentado) — valem os do modelo | W:327-335, NF:666-674 |
| 13 | 🟡 | Caixa do CNPJ alfanumérico: chave e CNPJ do XML preservam minúsculas (DV muda: ASCII−48), enquanto conferências normalizam para maiúsculas | U:217, V:76, XW:161, NF:807, S:1678 |
| 14 | 🟢 | cNF informado ≠ 0 não é validado na geração (só a regra 897 do validador opcional) | U:203-213, VR:1328-1333 |
| 15 | 🟢 | NFC-e: o XML assinado final é RE-SERIALIZADO do modelo após o QR — depende de a serialização reproduzir os bytes canônicos assinados | NF:349-376, NF:872-875 |
| 16 | 🟢 | `Enviar` não roda as regras de negócio locais | N:880-883 |
| 17 | 🟢 | Writer muta o modelo (homologação, `SEM GTIN`, `cEnq` 999…) — efeito colateral persiste no objeto | §3.10 |
| 18 | 🟢 | `ICMSUFDest`: ramo `if v4 … else` com código idêntico nos dois lados (comentários de NT 2016.002) | W:3501-3532 |
| 19 | 🟢 | `infSolicNFF` e `infPAA` existem no XSDref e `TinfPAA` no modelo, mas o writer não os gera | XSDref:6483, XSDref:6585, C:2921 |
| 20 | 🟢 | Enum de CST compartilhado com outros DF-e (45, 80, 81, 01, 12, 13, 14, 21, 72, 73, 74) sem ramo no writer da NF-e → grupo só com orig/CST | DC:256-259, W:1951-1976 |
| 21 | 🟢 | `TiraAcentos` troca por espaço qualquer caractere fora de ASCII 32–126 (default ligado) — altera o texto | US:1265-1282, DCF:546 |
| 22 | 🟡 | Offset do `dhEmi` padrão = fuso do SO da máquina emissora, não da UF | UD:99, UD:271-273 |
| 23 | 🟢 | IDs de alerta reaproveitados (`B25a`/`B25b` em campos distintos; `B09` em `dPrevEntrega`) — só afeta mensagens | W:539, W:589-608 |
| 24 | 🟢 | ⚠️ Possível `PIS`/`COFINS` vazio se o CST não cair em nenhuma lista (elemento criado antes do despacho); enum completo não conferido | W:3100-3165, W:3267-3335 |

Fila para o `guardiao-conceitual`: nenhum "modelo maquete" — o objeto é o espelho 1:1 do leiaute (é referência de terceiro).
Fila para `decision-rounds`: itens 2, 3, 4, 5, 13, 22 viram decisões de desenho na nfe-api (§8).

---

## 7. Resumo executivo

| Medida | Total | ✅ Completo | ⚠️ Parcial | ❌ Não gerado |
|---|---|---|---|---|
| Grupos de 1º nível sob `infNFe` (XSDref) | 21 | 19 | 0 | 2 (infSolicNFF, infPAA) |
| Elementos de nível `NFe`/raiz (infNFe, infNFeSupl, Signature, nfeProc/protNFe) | 4 | 4 | 0 | 0 |
| Subgrupos de `prod` (vigentes) | 14 | 14 | 0 | 0 |
| Grupos de `imposto` (sem RTC) | 10 | 10 | 0 | 0 |
| Variantes do grupo ICMS (CST 15 + CSOSN 6) | 21 | 20 | 1 (ICMSPart CST 20) | 0 |
| Unidades lidas | 24 | 22 | 2 (VR, WS — fatias) | 0 |
| Chamadas de campo no writer (fora RTC / RTC) | 750 / 111 | — | — | — |
| Pendências §6 | 24 | — | 🔴 0 · 🟡 8 · 🟢 16 | — |

O ACBr é um **formatador fiel do leiaute** com regras de presença bem definidas: gera chave, assinatura e QR Code, valida no
XSD antes de enviar e entrega alertas em vez de falhar. **Tudo o que é valor fiscal (impostos, FCP, ST, DIFAL, totais, vNF)
precisa chegar pronto** — o writer não calcula nada; o validador de regras só re-soma para comparar. As lacunas relevantes
são de robustez (vazio vira elemento vazio, sem truncamento, CNPJ zerado, `pag` vazio) e não de cobertura.

---

## 8. Insumos para o planejamento da nfe-api — ⚠️ FORA DA FOTOGRAFIA

> Leitura extra só para este §: `fiscal-api/src/transport/xmldsig.ts`, `fiscal-api/src/secret/certificate.ts`,
> `nfse-api/src/authority/dps-builder.ts`. Nada aqui é decisão — cada item aponta onda, questão e o que conferir no OFICIAL.

| # | Insumo | (a) Evidência ACBr | (b) Onda | (c) Q-NE | (d) Conferir no oficial |
|---|---|---|---|---|---|
| 1 | O builder não deve calcular imposto; a fonte de fatos entrega TODOS os valores por item e o builder só formata | W:1945-3538; §3.9 | NE-4 / NE-6 | **refina Q-NE15** (estrutural no ERP) | MOC: regras de validação de cada grupo N/O/P/Q/S |
| 2 | Totais (`ICMSTot`, `vNF`): ou o ERP congela, ou a nfe-api deriva dos itens com a fórmula do vNF — o ACBr recebe pronto e só confere com tolerância 0,001 | VR:965-1037, VR:1040-1132 | NE-4 | **questão nova Q-NE27**: dono dos totais (snapshot do ERP × derivação na nfe-api × derivar e conferir com o ERP) | MOC regras W (531–610, 564, 685, 861–863) e fórmula de W16 |
| 3 | Casas decimais por campo (§3.11) — o builder tem formatadores tipados (2, 3, 4, 10 casas), não um `toFixed(2)` geral; `dec2` da nfse-api só cobre 2 casas | W:341-351; `dps-builder.ts:46` | NE-4 | confirma Q-NE16 | tipos `TDec_*` do XSD do pacote PL vigente |
| 4 | Política de ausência: opcional zero some; obrigatório zero sai `0.00`; obrigatório VAZIO deve FALHAR localmente (o ACBr emite elemento vazio) | XW:369, XW:442-449 | NE-4 | refina Q-NE16 | XSD (`minOccurs`) |
| 5 | Texto: o legado envia ASCII sem acentos, quebra de linha `\|`, espaços colapsados; a nfse-api já tem `escapeXml` + limpeza de controle | US:1265-1282, DCF:546-547, DCF:785; `dps-builder.ts:33`, `:52` | NE-4 | **questão nova Q-NE28**: UTF-8 com acentos × transliterar como o legado | MOC (caracteres aceitos, regra de caractere especial) |
| 6 | Chave 44 + cDV módulo 11 (pesos 2..9, ASCII−48) + cNF aleatório ≠ nNF e fora das 20 sequências; AAMM da MESMA parede do `dhEmi` | U:184-237, V:2147-2183, U:978-999 | NE-4 | **confirma Q-NE7** (chave por tentativa; persistir cNF/cDV/chave na tentativa — o ACBr só regenera a cada geração) | MOC 7.0 (chave de acesso), NT 2019.001 (cNF), regra 897 |
| 7 | CNPJ alfanumérico: o núcleo só aceita `\d{14}` no certificado e o builder da nfse-api tira tudo que não é dígito | `certificate.ts:34`; `dps-builder.ts:59-63`; V:852 | NE-1 | **questão nova Q-NE29**: generalizar documento alfanumérico (maiúsculas) no núcleo antes da nfe-api | NT do CNPJ alfanumérico (vigência e regra do DV) |
| 8 | Assinatura do núcleo já serve: enveloped, C14N inclusiva, rsa-sha1/sha1, `URI="#NFe…"`, só o certificado final, `Signature` último filho do pai do elemento assinado (= `NFe`); `assertReferenceId` aceita `NFe`+44 alfanumérico | U:416-475, L2:202-203, XS:538; `xmldsig.ts:18-66` | NE-3 / NE-4 | confirma §11.2.3 / Q-NE13 | MOC (assinatura: SHA-1 ainda exigido?) |
| 9 | O ACBr aceita A1 da MATRIZ para filial (compara só a raiz de 8); o núcleo exige CNPJ idêntico | S:1692-1695; `certificate.ts:143` | NE-1 | **refina Q-NE9** — questão nova: aceitar A1 de mesma raiz? | MOC (rejeição "CNPJ-base do emitente difere do certificado") |
| 10 | Validar XSD SEMPRE antes de enviar — o ACBr faz em `Enviar` via libxml2 (`xmlSchemaValidateDoc`) sobre o `NFe` sem `nfeProc` | N:880-881, L2:380-457 | NE-3 / NE-4 | **confirma Q-NE16**; aponta libxml2 (binding em Node) como a mesma família de validador | pacote PL oficial vigente (incluindo `DFeTiposBasicos` do RTC) |
| 11 | Ordem dos elementos = sequência do XSD (tabela §3.1 e §3.2–3.8) — mesmo padrão do `dps-builder` ("ordem = xs:sequence") | W:427-488; `dps-builder.ts:7-13` | NE-4 | — | XSD oficial |
| 12 | Homologação muda conteúdo: `dest/xNome` e `xProd` do item 1 viram o texto padrão do fisco | W:878, W:896-897, W:1222-1225 | NE-3 (smoke H) | refina Q-NE18 | MOC (regras de homologação) |
| 13 | Emitente sem IE: o XML sai com `IE` vazia e cai no XSD local antes da SEFAZ — reforça que autorização em H precisa de cliente-piloto | W:772-776, XW:442-446 | NE-3 | **confirma Q-NE18 (c)** | XSD tipo `TIe` do emitente; regras 209/230 |
| 14 | CST 51 em PR/SP/RJ exige os campos do diferimento mesmo zerados | W:2366-2369 | NE-4 | — (fato para o 1º cliente) | NT/regra estadual de PR para CST 51 |
| 15 | CST monofásico 02/15/53/61 vale também para Simples (despacho antes do CRT) | W:2009-2088 | NE-6 | refina Q-NE15 (motor do ERP produz 02/15/53/61 para CRT 1?) | NT do ICMS monofásico de combustíveis |
| 16 | Campos estruturais de ICMS que o ERP ainda não congela: desoneração (vICMSDeson, motDesICMS, indDeduzDeson), ST retido (vBCSTRet, pST, vICMSSubstituto, vICMSSTRet, FCP ST retido), ICMS efetivo, diferimento (vICMSOp, pDif, vICMSDif) | W:2264-2281, W:2439-2494, W:2361-2437 | NE-6 | **confirma Q-NE15 / §11.2.5** (ST retido, desonerado) | MOC grupos N; NT 2023.004 (desoneração) |
| 17 | DIFAL (`ICMSUFDest`) sai só com `pICMSInterPart > 0` e 9 campos obrigatórios | W:1933-1934, W:3496-3538 | NE-6 | confirma lacuna DIFAL (§11.2.5) | EC 87/2015 + NT 2015.003 |
| 18 | GTIN vazio → `SEM GTIN`; `cEnq` vazio → `999` (defaults legais aplicados pelo writer) | W:1205-1207, W:1279-1281, W:3021-3022 | NE-4 | **confirma Q-NE15 (c)** (cosmético por default) | NT de GTIN; tabela de enquadramento do IPI |
| 19 | `pag` é obrigatório na 4.00 (ao menos um `detPag`); fatura com os 4 campos obrigatórios por padrão; `dup` com nDup/dVenc obrigatórios | W:463-468, W:3679-3718, NC:204 | NE-4 | refina **Q-NE25** (devolução: `tPag` "sem pagamento") | MOC grupo YA e regra de devolução |
| 20 | `dhEmi`/AAMM pela zona: o padrão do ACBr é o fuso do SO; a nfse-api já formata pela zona do estabelecimento (`formatDateTimeTz`) | UD:99, UD:271-273, U:216; `dps-builder.ts:69` | NE-4 | refina **Q-NE21** (data fiscal derivada da voz) | MOC B09 (formato UTC) |
| 21 | Builder PURO: o writer do ACBr muta o modelo (§3.10); na nfe-api os fatos lidos do ERP não mudam — derivados (chave, cNF, textos de H) vivem na tentativa | W:362-364, W:897, W:1225 | NE-4 / NE-5 | confirma Q-NE7 | — |
| 22 | `infRespTec` + `hashCSRT` = Base64(SHA-1(CSRT+chave)) — a Setes será responsável técnica | W:4173-4191, U:585-588 | NE-4 | **questão nova Q-NE30**: dados do responsável técnico e CSRT por UF (cofre?) | NT 2018.005 e quais UFs exigem CSRT |
| 23 | Ganchos da reforma nas posições do §3.17 — o builder 4.00 nasce com os pontos de inserção, conteúdo na fase própria | W:557-595, W:643-644, W:1180-1184, W:1937-1942, W:3548-3554 | NE-4 | **confirma Q-NE4** | NT 2025.002 (RTC) |
| 24 | NFC-e: QR v2 (padrão do legado) com CSC; v3 sem CSC e com assinatura RSA no off-line; `infNFeSupl` antes da `Signature`; QR depende do DigestValue | N:697-775, NF:360-376, W:384-397 | F5 | confirma **Q-NE2 (a)** | NT do QR Code v2 e v3 (NFC-e) |
| 25 | Lote: máx. 50 NF-e e 500 KB; o envelope recorta o `NFe` do XML assinado | N:876-878, WS:1155-1170 | NE-3 | refina Q-NE5 | MOC (limites do lote, `indSinc`) |
| 26 | Regras de negócio locais (VR, ~20 regras + conferência de totais) evitam rejeição que custa tentativa | VR:64-89, VR:1040-1132 | NE-5 | **questão nova Q-NE31**: pré-validar regras de negócio localmente além do XSD? | MOC (lista de regras de validação) |
| 27 | Robustez que o ACBr não tem e a nfe-api precisa decidir: truncar × recusar acima do máximo; recusar `dest` sem documento no 55; recusar `pag` vazio | XW:430-431, XW:179-185, W:3726-3730 | NE-4 | refina Q-NE16 | XSD |

### 8.1 Fato que a nfe-api precisa LER do ERP, por grupo do XML (insumo da fonte de fatos da mercadoria)

Status do lado do ERP conforme `prompt_onda_nfe_sefaz.md` §11.2 item 5 (não reconferido no setes-api nesta leitura):
✔ congelado/existente · ⚠️ lacuna listada no §11.2.5 · ❓ não sei / conferir.

| Grupo | Fatos que o builder recebe (o ACBr recebe pronto) | Status ERP |
|---|---|---|
| `ide` | natOp | ⚠️ sem fonte |
| | série, nNF | ✔ (D-F21) |
| | dhEmi / AAMM | derivado na tentativa (zona do estabelecimento) |
| | dhSaiEnt | ⚠️ `dt_exit` |
| | tpNF, idDest (UF emit × UF dest × exterior), cMunFG | ❓ derivável |
| | finNFe | ⚠️ `finality` não gravado |
| | indFinal | ❓ |
| | indPres | ⚠️ fixo 0 |
| | indIntermed (+ `infIntermed`) | ❓ |
| | NFref (`refNFe` da âncora na devolução) | ❓ (D-E15) |
| `emit` | CNPJ, razão, fantasia, endereço completo, fone, IE, IEST, IM/CNAE, CRT | ✔ cadeia da entity / ⚠️ IE da Setes |
| `dest` | documento/idEstrangeiro, nome, endereço, indIEDest, IE, ISUF, IM, email | ✔ cadeia da entity / ❓ indIEDest |
| `retirada` / `entrega` / `autXML` | endereços alternativos; CNPJ/CPF autorizados | ❓ sem produtor |
| `prod` | cProd, xProd, NCM, CEST (+indEscala/CNPJFab), CFOP, EXTIPI | ✔ snapshots do item / ❓ CEST |
| | cEAN/cEANTrib | ⚠️ GTIN não congelado |
| | uCom/uTrib | ⚠️ unidade não congelada |
| | qCom, vUnCom, vProd, qTrib, vUnTrib, vFrete, vSeg, vDesc, vOutro, indTot | ✔ (❓ rateio de frete/desconto por item) |
| | cBenef, gCred | ⚠️ `cBenef` sem leitor |
| | xPed/nItemPed, rastro, med, arma, comb, veicProd, DI, detExport | ❓ fora do 1º release |
| `ICMS` | orig, CST/CSOSN, modBC, pRedBC, vBC, pICMS, vICMS, FCP, ST (modBCST, pMVAST, pRedBCST, vBCST, pICMSST, vICMSST, FCPST), pCredSN/vCredICMSSN, monofásico | ✔ motor congela ICMS/CSOSN/ST/FCP |
| | desoneração, ST retido, ICMS efetivo, diferimento | ⚠️ desonerado / ST retido |
| `IPI` / `II` / `PIS` / `COFINS` (+ST) | CST, base, alíquota, valor (ou quantidade/valor unitário), cEnq | ✔ snapshots |
| `ICMSUFDest` | 9 campos do DIFAL | ⚠️ DIFAL |
| `impostoDevol` | pDevol, vIPIDevol | ❓ (devolução) |
| `vTotTrib` | valor aproximado de tributos | ❓ |
| `total` | 29 campos do `ICMSTot` (+ ISSQNtot, retTrib) | Q-NE27 (snapshot × derivação) |
| `transp` | modFrete, transportadora, veículo, volumes | ⚠️ sem produtor web |
| `cobr` | fatura (nFat, vOrig, vDesc, vLiq) e duplicatas (nDup, dVenc, vDup) | ✔ títulos do faturamento |
| `pag` | tPag, vPag, indPag, card, troco | ✔ `tPag` congelado |
| `infAdic` | infCpl, infAdFisco, obsCont/obsFisco | ❓ observações do pedido / da regra |
| `infRespTec` | CNPJ, contato, email, fone, CSRT | config da Setes (Q-NE30) |
| `IBSCBS` | fase própria | ⚠️ IBS/CBS (Q-NE4) |

---

## 9. Confiança e lacunas

- **Alta** em: árvore, ordem e condicionalidade (W lido por inteiro de 35 a 4250), formatação (XW, XB, XD lidos), chave e
  cDV (U, V lidos), assinatura e validação (S, XS, L2, OS nas funções citadas), fluxo (NF, N).
- **Média** em: arredondamento exato dos decimais — o ACBr delega ao `FormatFloat` do RTL Delphi sobre `Currency`/`Double`;
  não li o RTL (UB:293-313). A nfe-api deve definir o próprio arredondamento a partir do oficial.
- **Não verificado**: comportamento do RTL para `Result` de string não atribuído (achado 1); enum `TCSTPIS` completo (achado 24);
  conteúdo de `ACBrNFeServicos.ini` além das chaves do QR; regras do VR fora de totais/chave; o grupo IBS/CBS (outra frente);
  qual biblioteca de assinatura o Gestao2016 configura (a configuração fica na aplicação, não no ACBr).
- **XSD citado** é a cópia do ACBr (`Exemplos\`), não o pacote oficial — serve para conferir posição, não para virar regra.
- **Perguntas ao Valdo** (intenção, não fato): nenhuma nesta fotografia; as decisões estão no §8 como Q-NE27…Q-NE31.
