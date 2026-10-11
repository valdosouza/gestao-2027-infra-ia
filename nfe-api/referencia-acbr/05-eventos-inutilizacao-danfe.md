# ACBr NF-e — Eventos, inutilização, consulta de situação e DANFE
**Escopo**: setes
**Natureza**: referência de TERCEIRO — ACBr (LGPL 2.1), motor da NF-e no legado Gestao2016; nunca substitui o oficial (MOC/Anexo DANFE/NT/XSD)
**Fonte**: D:\Componentes\acbr\Fontes\ACBrDFe\ (change-log 19/08/2026) · leitura de 2026-10-10
**Agente**: legacy-analyst (plugin code-modernization) no método assess-legacy-repo

> Convenção: `arquivo:linha` relativo a `ACBrDFe\` (ex.: `ACBrNFe\ACBrNFe.pas:797`). Arquivos fora dessa pasta aparecem
> com `..\` (ex.: `..\ACBrComum\ACBrUtil.DateTime.pas:269`). Documenta COMPORTAMENTO, LAYOUT e REGRAS — não transcreve
> código. Fato sem linha = ⚠️. "Aparenta" = inferência do analista, não confirmada por execução.
>
> **Descartes respeitados**: `PCNNFe\pcn*` (vigente = `ACBrNFe.XmlWriter`; `USE_ACBr_XMLDOCUMENT` ligado em
> `..\ACBrComum\ACBr.inc:64`) — **exceção lida**: `PCNNFe\pcnProcNFe.pas`, porque a CONSULTA vigente ainda monta o
> `nfeProc` por ele (`ACBrNFe\ACBrNFeWebServices.pas:54,2477-2493`); `*Ini*`/`*JSON*`; motores Fortes/Fast/LazReport/EscPos
> (não lidos — o FPDF bastou); `ACBrECFVirtualNFCe\`; `__recovery\`; partes do "Integrador" (MFE-CE) ignoradas.

---

## 1. Visão geral do sistema

O ACBr NF-e expõe, na fachada `TACBrNFe` (`ACBrNFe\ACBrNFe.pas:123-179`), quatro atos pós-autorização: **evento**
(`EnviarEvento`, com atalhos `Cancelamento` e `EnviarCartaCorrecao`), **inutilização** (`Inutilizar`), **consulta de
situação** (`Consultar`) e **e-mail** (`EnviarEmail`/`EnviarEmailEvento`). Cada ato é um `TNFeWebService` em
`ACBrNFe\ACBrNFeWebServices.pas` que (1) escolhe URL/serviço pela UF/forma de emissão, (2) monta o XML com as classes de
`ACBrNFe\Base\Servicos\` (string ou `TACBrXmlWriter`), (3) assina (evento e inutilização), valida no XSD (só evento),
envia, (4) lê o retorno com a classe `Ret*` e (5) monta e grava o arquivo "proc" (`procEventoNFe`, `ProcInutNFe`, `nfeProc`
reconstruído, `NFeDFe`). A impressão é um componente separado (`TACBrDFeDANFeReport` → `TACBrNFeDANFEClass` → renderer);
o renderer em código puro é o FPDF (`ACBrNFe\DANFE\NFe\FPDF\ACBrNFeDANFeFPDF.pas`), que monta o DANFE A4 por **bandas**
lendo só o objeto `TNFe` (XML) + propriedades de configuração do componente.

---

## 2. Inventário de componentes

### 2.1 Modelos de mensagem (Base\Servicos)

| Componente | Arquivo | Responsabilidade | Dependências | Status |
|---|---|---|---|---|
| `TEventoNFe` | `ACBrNFe\Base\Servicos\ACBrNFe.EnvEvento.pas:87-178` | gera `envEvento` (lote) com N `evento/infEvento/detEvento` por tipo | `ACBrNFe.EventoClass`, `ACBrXmlWriter` | ✅ |
| `TInfEvento`/`TDetEvento`/`TRetInfEvento` | `ACBrNFe\Base\Servicos\ACBrNFe.EventoClass.pas:461-685` | dados do evento, descrição por tipo, texto padrão do `xCondUso`, retorno por evento | `ACBrDFe.Conversao` | ✅ |
| `TRetEventoNFe` | `ACBrNFe\Base\Servicos\ACBrNFe.RetEnvEvento.pas:73-126` | lê `retEnvEvento`, `procEventoNFe`, `envEvento`, `evento`, `NFeDFe` | `EventoClass` | ⚠️ (P9) |
| `TinutNFe` | `ACBrNFe\Base\Servicos\ACBrNFe.Inut.pas:55-95` | gera `inutNFe/infInut` (string) e lê proc/retorno | `ACBrNFe.RetInut` | ⚠️ (P7, P8) |
| `TRetInutNFe` | `ACBrNFe\Base\Servicos\ACBrNFe.RetInut.pas:109-165` | lê `retInutNFe/infInut` (raiz ou dentro do proc) | — | ✅ |
| `TConsSitNFe` | `ACBrNFe\Base\Servicos\ACBrNFe.ConsSit.pas:45-94` | gera `consSitNFe` (string) | — | ✅ |
| `TRetConsSitNFe` | `ACBrNFe\Base\Servicos\ACBrNFe.RetConsSit.pas:98-281` | lê `retConsSitNFe`: `protNFe`, `retCancNFe` (legado), N `procEventoNFe` | `TRetEventoNFe`, `TProcDFe` | ✅ |
| `TProcNFe` (pcn) | `ACBrNFe\PCNNFe\pcnProcNFe.pas:62,147-320` | monta `nfeProc` = NFe + protNFe por concatenação | `pcnGerador` | ✅ (legado ainda em uso pela consulta) |

### 2.2 Serviços (ACBrNFeWebServices.pas)

| Componente | Linhas | Responsabilidade | Status |
|---|---|---|---|
| `TNFeEnvEvento` | `ACBrNFe\ACBrNFeWebServices.pas:456-491,3047-3863` | rota do evento, assinatura por evento, validação XSD, tratamento, `procEventoNFe` | ⚠️ (P1, P2) |
| `TNFeInutilizacao` | `ACBrNFe\ACBrNFeWebServices.pas:346-400,2615-2834` | inutilização, `ProcInutNFe` | ✅ (P6, P8) |
| `TNFeConsulta` | `ACBrNFe\ACBrNFeWebServices.pas:290-342,2019-2611` | consulta situação, reconciliação do `nfeProc`, `NFeDFe`, extração de eventos | ✅ (P11, P12) |
| `TWebServices.Inutiliza` | `ACBrNFe\ACBrNFeWebServices.pas:4344-4364` | valida CNPJ/CPF e dispara | ✅ |

### 2.3 Fachada e e-mail

| Componente | Linhas | Responsabilidade | Status |
|---|---|---|---|
| `TACBrNFe` (eventos/inut/consulta) | `ACBrNFe\ACBrNFe.pas:797-999,1098-1105` | `Cancelamento`, `Consultar`, `EnviarCartaCorrecao`, `EnviarEvento`, `Inutilizar` | ⚠️ (P3) |
| `TACBrNFe.EnviarEmailEvento` | `ACBrNFe\ACBrNFe.pas:1107-1135` | e-mail do evento (PDF + XML) | ⚠️ (P4, P5) |
| `NotaFiscal.EnviarEmail` | `ACBrNFe\ACBrNFeNotasFiscais.pas:588-631` | e-mail da NF-e (XML + PDF do DANFE) | ✅ |
| `TACBrDFe.EnviarEmail` | `ACBrDFe.pas:289-338` | envio via `ACBrMail` (assunto/corpo/anexos/CC/BCC/ReplyTo) | ✅ |

### 2.4 DANFE

| Componente | Arquivo | Responsabilidade | Status |
|---|---|---|---|
| `TACBrDFeReport` + `TCasasDecimais` | `ACBrDFeReport.pas:53-344,473-506` | propriedades comuns (logo, margens, Sistema, casas decimais) | ✅ |
| `TACBrDFeDANFeReport` | `ACBrNFe\DANFE\ACBrDFeDANFeReport.pas:55-667` | API de impressão (abstrata) + montadores de texto (`Manter*`) | ⚠️ (P15) |
| `TACBrNFeDANFEClass` | `ACBrNFe\DANFE\ACBrNFeDANFEClass.pas:76-153,210-827` | opções do DANFE NF-e + dados adicionais compostos | ✅ |
| `TACBrNFeDANFeFPDF` / `TNFeDANFeFPDF` | `ACBrNFe\DANFE\NFe\FPDF\ACBrNFeDANFeFPDF.pas:69-120,2604-2893` | DANFE A4 em PDF por bandas | ⚠️ (P16–P21, P24) |
| `TNFeDANFeEventoFPDF` | `ACBrNFe\DANFE\NFe\FPDF\ACBrNFeDANFeFPDF.pas:299-323,2897-3617` | PDF do evento (CC-e/cancelamento/genérico) | ⚠️ (P25, P26) |
| `TNFeUtilsFPDF` | `ACBrNFe\DANFE\NFe\FPDF\ACBrNFeUtilsFPDF.pas:57-168` | estado da nota (cancelada/denegada/EPEC), texto da fatura, texto adicional | ✅ (P27) |
| DANFE de inutilização no FPDF | `ACBrNFe\DANFE\NFe\FPDF\ACBrNFeDANFeFPDF.pas:2879-2893` | cai no `ErroAbstract` da base | ❌ |
| DANFE resumido/simplificado e impressão direta no FPDF | `ACBrNFe\DANFE\NFe\FPDF\ACBrNFeDANFeFPDF.pas:2744-2762` | cai no `ErroAbstract` | ❌ |
| Motor FPDF-Pascal (terceiro, MIT) | `..\Terceiros\FPDF-Pascal\ACBr_fpdf_ext.pas:35,147`; `..\Terceiros\FPDF-Pascal\ACBr_fpdf_report.pas:508-523,1001` | Code128 A/B/C automático; bandas, `DrawAgain`, double pass | ✅ |

---

## 3. Mapas

### 3.1 Mapa evento / inutilização / consulta → XML enviado e retorno

#### 3.1.1 Catálogo de eventos suportados pelo gerador NF-e

Códigos: `ACBrDFe.Conversao.pas:93-144` (enum × string); descrição gravada no XML: `ACBrNFe\Base\Servicos\ACBrNFe.EventoClass.pas:715-779`;
leitura do código: `ACBrNFe\Base\ACBrNFe.Conversao.pas:1139-1150`; despacho do gerador: `ACBrNFe.EnvEvento.pas:1022-1088`;
rota: `ACBrNFe\ACBrNFeWebServices.pas:3109-3161`. "Quem emite" = valor de `tpAutor` fixado no código quando há (senão vem do chamador).

| tpEvento | Enum | descEvento gravado | detEvento (campos, min–max) | Autor no código | Rota (UF/serviço) | Gerador |
|---|---|---|---|---|---|---|
| 110110 | teCCe | `Carta de Correcao` | descEvento, xCorrecao 15–1000, xCondUso 1–5000 | — | UF da chave (ou SVC) | `EnvEvento.pas:559-572` |
| 110111 | teCancelamento | `Cancelamento` | descEvento, nProt 15–17, xJust 15–255 | — | UF da chave (ou SVC) | `EnvEvento.pas:499-512` |
| 110112 | teCancSubst | `Cancelamento por substituicao` | descEvento, cOrgaoAutor 1–2, tpAutor **"1" fixo**, verAplic 1–20, nProt 15–17, xJust 15–255, chNFeRef 44 (valida chave) | emitente (1) | UF da chave (ou SVC) | `EnvEvento.pas:529-557` |
| 110140 | teEPECNFe | `EPEC` | cOrgaoAutor, tpAutor "1", verAplic, dhEmi, tpNF, IE, dest (UF, CNPJ/CPF/idEstrangeiro, IE; no 55 vNF/vICMS/vST dentro de `dest`) | emitente (1) | AN (SP/NFC-e: `LayNFCeEPEC`) | `EnvEvento.pas:617-663,372-424` |
| 210200/210210/210220/210240 | teManifDest* | `Confirmacao/Ciencia/Desconhecimento da Operacao`, `Operacao nao Realizada` | só descEvento; 210220 xJust opcional; 210240 xJust 15–255 | destinatário (implícito) | AN | `EnvEvento.pas:696-739` |
| 111500/111501 · 111502/111503 | tePedProrrog* · teCanPedProrrog* | `Pedido de Prorrogacao` · `Cancelamento de Pedido de Prorrogacao` | nProt + itemPedido (≤990) · idPedidoCancelado 54 + nProt | — | UF da chave | `EnvEvento.pas:754-776,514-527` |
| 110130/110131 | teComprEntregaNFe / teCanc… | `Comprovante de Entrega da NF-e` / cancelamento | dhEntrega, nDoc, xNome, lat/long, hash 28, dhHash · nProtEvento | tpAutor "1" | AN | `EnvEvento.pas:574-615,478-497` |
| 110150 | teAtorInteressadoNFe | `Ator interessado na NF-e` | cOrgaoAutor, tpAutor, verAplic, autXML (≤1), tpAutorizacao, xCondUso fixo quando permite | chamador | AN | `EnvEvento.pas:426-463` |
| 110192/110193 | teInsucessoEntregaNFe / teCanc… | insucesso / cancelamento | dhTentativa, nTentativa, tpMotivo, xJustMotivo 25–250, GPS, hash 20 · nProtEvento | — | SVRS | `EnvEvento.pas:778-839` |
| 110750/110751 | teConcFinanceira / teCanc… | `ECONF` / `Cancelamento Conciliação Financeira` | verAplic + detPag (≤100) · nProtEvento | — | SVRS (55) / UF (65) | `EnvEvento.pas:841-940` |
| 110001 | teCancGenerico (RTC) | `Cancelamento de Evento` | cOrgaoAutor, verAplic, tpEventoAut 6, nProtEvento 15–17 | — | SVRS | `EnvEvento.pas:2464-2484` |
| 112110…112150, 211110…211150, 212110/212120 | eventos da Reforma Tributária | descrições com acento (`EventoClass.pas:762-775`) | grupos gCredPres/gConsumo/gImobilização/… | chamador | SVRS | `EnvEvento.pas:2486-3092` |

⚠️ `teVinculoPgto` (110300) e `teCancVinculoPgto` (110301) existem no enum comum (`ACBrDFe.Conversao.pas:127,144`) mas
**não** têm gerador no `case` do NF-e (`EnvEvento.pas:1022-1088`) nem leitura (`ACBrNFe.Conversao.pas:1142-1150`).

**Prazos**: ⚠️ nenhum prazo de cancelamento, CC-e ou manifestação é aplicado no código (busca por prazo/horas/168 nos
arquivos do serviço sem resultado pertinente). **Limite de 20 CC-e por NF-e**: ⚠️ não encontrado no código.

#### 3.1.2 `envEvento` (comum a todos)

| Campo XML | Tipo/tamanho | Origem no componente | Transformação / regra |
|---|---|---|---|
| `envEvento@versao`, ns `http://www.portalfiscal.inf.br/nfe` | str | versão do serviço (`FPVersaoServico`) | `EnvEvento.pas:254-256`; `WebServices.pas:3634` |
| `idLote` | int64 1–15 | parâmetro `idLote` da fachada | `EnvEvento.pas:260-261`; `ACBrNFe.pas:940` |
| `evento@versao` | str | idem | `EnvEvento.pas:292-294` |
| `infEvento@Id` | 54 | calculado | **"ID" + tpEvento(6) + chave sem literais(44) + nSeqEvento com 2 dígitos**; alerta se < 54 (`EnvEvento.pas:285-290`) |
| `cOrgao` | int 1–2 | `InfEvento.cOrgao`; se 0, 2 primeiros dígitos da chave | `EventoClass.pas:705-713`; `EnvEvento.pas:961-962` — **91 (AN) não é forçado** para eventos roteados ao AN |
| `tpAmb` | 1 | sempre o ambiente da configuração | `ACBrNFe.pas:948`; `EnvEvento.pas:964-965` |
| `CNPJ`/`CPF` | 14/11 | `InfEvento.CNPJ`; se vazio, extraído da chave | série 910–969 na chave ⇒ CPF (exceto manifestação) `EnvEvento.pas:967-997` |
| `chNFe` | 44 | chamador / nota carregada | valida DV com alerta `EnvEvento.pas:999-1003`; preenchida pela nota se vazia `ACBrNFe.pas:972-973` |
| `dhEvento` | AAAA-MM-DDThh:nn:ss + TZD | `InfEvento.dhEvento` (no `Cancelamento`, `now`) | offset por `GetUTC(UF do cOrgao)` `EnvEvento.pas:1005-1008`; `ACBrNFe.pas:816` |
| `tpEvento` | 6 | enum → string | `EnvEvento.pas:1010-1011` |
| `nSeqEvento` | int 1–2 | chamador; **0 vira 1** | `ACBrNFe.pas:945-946`; `EnvEvento.pas:1013-1014` |
| `verEvento` | 1–4 | versão do serviço | `EnvEvento.pas:1016` |
| `detEvento@versao` | — | versão do serviço | ex.: `EnvEvento.pas:501-502` |
| `Signature` | XMLDSig | assinatura POR evento, elemento `evento`, referência `infEvento` | `WebServices.pas:3644-3668`; a Signature fica dentro de `evento`, após `infEvento` |
| quantidade de eventos | ≤ 20 | — | exceção na fachada `ACBrNFe.pas:936-938`; alerta no writer `EnvEvento.pas:303-304` |

Validação local (só evento): XSD da mensagem inteira (`WebServices.pas:3677-3693`) e XSD do `detEvento` de cada evento com
o schema do tipo (`WebServices.pas:3695-3733`); schema não definido ⇒ exceção (`WebServices.pas:3684-3687`).

**Cancelamento 110111 — fluxo da fachada**: para cada nota carregada, executa **antes** a consulta de situação; usa a chave
e o `Protocolo` devolvidos pela consulta como `chNFe`/`nProt`; `dhEvento = now`; `CNPJ` = emitente da nota
(`ACBrNFe.pas:797-830`). Pelo `EnviarEvento`, se `nProt` vier vazio em 110111/110112: pega `procNFe.nProt` da nota; se ainda
vazio, consulta a SEFAZ (`ACBrNFe.pas:975-990`).

**CC-e 110110**: `xCondUso` vazio é substituído pelo texto padrão (Convênio S/N, §1º-A do art. 7º, três vedações I–III),
gravado **sem acentos** (`EventoClass.pas:896-911`); o setter dispara quando o serviço copia o campo
(`WebServices.pas:3253`). O `nSeqEvento` é do chamador (0→1). Nome do arquivo de pedido `<idLote>-cce.xml`
(`EnvEvento.pas:216`). Atalho `EnviarCartaCorrecao` copia `CartaCorrecao.CCe` para `EventoNFe` (`ACBrNFe.pas:895-926`).

#### 3.1.3 Retorno do evento e `procEventoNFe`

| Elemento | Leitura | Uso |
|---|---|---|
| `retEnvEvento`: versao, idLote, tpAmb, verAplic, cOrgao, **cStat**, xMotivo | `RetEnvEvento.pas:684-703` | **sucesso do serviço = cStat do LOTE = 128** (`WebServices.pas:3763`) |
| `retEvento/infEvento`: Id, tpAmb, verAplic, cOrgao, cStat, xMotivo, chNFe, tpEvento, xEvento, nSeqEvento, CNPJDest/CPFDest, emailDest, cOrgaoAutor, dhRegEvento, nProt, chNFePend* | `RetEnvEvento.pas:632-670` | copiados para `FEvento.Evento[I].RetInfEvento` casando **só por chNFe** (`WebServices.pas:3772-3784`) |
| proc | — | gerado só para retorno do evento com cStat **135, 136 ou 155** (`WebServices.pas:3788`) |

Montagem do `procEventoNFe` (`WebServices.pas:3790-3806`): `procEventoNFe@versao` (versão lida dos parâmetros do serviço) +
ns NF-e ⊃ `evento` (o `infEvento` e a `Signature` recortados do XML enviado) + `retEvento` (o `infEvento` recortado da
resposta). Gravado como `<Id sem "ID">-procEventoNFe.xml` na pasta de evento por tipo (`WebServices.pas:3808-3816`;
`ACBrNFeConfiguracoes.pas:345-359`) se `Arquivos.SalvarEvento` (default False, `ACBrNFeConfiguracoes.pas:111-112,288`).
Evento rejeitado ⇒ `RetInfEvento.XML` vazio (`WebServices.pas:3822-3828`). Pedido/resposta do lote:
`<idLote>-ped-eve.xml` / `-eve.xml` (`WebServices.pas:3068-3069,3859-3863`).

#### 3.1.4 Inutilização (`inutNFe`)

| Campo XML | Tamanho | Origem | Transformação / regra |
|---|---|---|---|
| `inutNFe@versao`, ns NF-e | — | versão do serviço | `Inut.pas:169`; `WebServices.pas:2756` |
| `infInut@Id` | 43 | calculado | **"ID" + cUF(2) + AA(2) + CNPJ(14) + mod(2) + série(3) + nNFIni(9) + nNFFin(9)**; MT (cUF 51) com CPF ⇒ "000"+CPF no Id (`Inut.pas:131-138`) |
| `tpAmb` | 1 | ambiente da configuração | `WebServices.pas:2747` |
| `xServ` | — | literal `INUTILIZAR` | `Inut.pas:172` |
| `cUF` | 2 | UF da configuração | `WebServices.pas:2748` |
| `ano` | 2 | parâmetro; > 2000 ⇒ subtrai 2000 | `Inut.pas:146-147,174` |
| `CNPJ` (ou `CPF` só em MT) | 14/11 | parâmetro, só dígitos, validado | `WebServices.pas:4349-4352`; `Inut.pas:149-164` |
| `mod` | 2 | **modelo da configuração global**, não do chamador | `ACBrNFe.pas:1102-1104` |
| `serie`, `nNFIni`, `nNFFin` | int | parâmetros | `Inut.pas:177-179` |
| `xJust` | ≥ 15 após trim | parâmetro | exceção se vazio ou < 15 (`WebServices.pas:2639-2654`); concatenado sem escape (`Inut.pas:180`) |
| `Signature` | XMLDSig | elemento `inutNFe`, referência `infInut` | `WebServices.pas:2758-2760` |

Validações comentadas: tamanho do Id, cUF, CNPJ, `nNFIni ≤ nNFFin` (`Inut.pas:140-144,162-163,166-167`). Sem validação XSD
local neste serviço (⚠️ `DefinirDadosMsg` em `WebServices.pas:2741-2766` não chama `SSL.Validar`, diferente do evento).

Retorno (`RetInut.pas:109-165`): versao, Id, tpAmb, verAplic, cStat, xMotivo, cUF, ano, CNPJ/CPF, mod, serie, nNFIni,
nNFFin, dhRecbto, nProt, xJust. **Sucesso = cStat 102** (`WebServices.pas:2793`). Proc gerado para **102 ou 563**
(`WebServices.pas:2796`): raiz escrita **`ProcInutNFe`** (P maiúsculo) + versão + ns, contendo o `inutNFe` assinado enviado
seguido do retorno cru (`WebServices.pas:2798-2803`); arquivo `<Id sem "ID">-procInutNFe.xml` em `PathInu`
(por CNPJ e modelo se configurado) quando `Arquivos.Salvar` (`WebServices.pas:2656-2670,2805-2808`). Pedido
`<Id>-ped-inu.xml` (`Inut.pas:122-125`; `WebServices.pas:2621-2622`). Roteamento: UF da configuração, sem SVC
(`WebServices.pas:2687-2695`).

#### 3.1.5 Consulta de situação (`consSitNFe`)

| Enviado | Origem | Linha |
|---|---|---|
| `consSitNFe@versao`, ns | versão do serviço | `ConsSit.pas:89` |
| `tpAmb` | `tpAmb` da 1ª nota carregada, senão configuração | `WebServices.pas:2098-2101` |
| `xServ` = `CONSULTAR` | literal | `ConsSit.pas:91` |
| `chNFe` | chave validada (DV) sem literais | `WebServices.pas:2073-2084` |
| cabeçalho SOAP `cUF` | UF da chave | `WebServices.pas:2095,2181-2184` |
| URL | UF da chave; SVC-AN/SVC-RS se a forma de emissão configurada for SVC | `WebServices.pas:2105-2112` |

Retorno (`RetConsSit.pas:166-281`): versao, verAplic, tpAmb, cUF, nRec, cStat, xMotivo, dhRecbto, chNFe;
**`protNFe` só lido se cStat ∈ {100, 101, 104, 150, 151, 155}** (guarda `XMLprotNFe` = OuterXml e campos de `infProt`
incl. digVal, cMsg, xMsg — `RetConsSit.pas:198-224`); **`retCancNFe/infCanc`** (cancelamento modelo antigo) se cStat ∈
{101, 151, 155} (`RetConsSit.pas:226-248`); **todos os `procEventoNFe`** do retorno, cada um lido por `TRetEventoNFe`
(`RetConsSit.pas:250-273`).

Uso pelo componente (`WebServices.pas:2186-2586`):
- `Protocolo`/`DhRecbto` = do `retCancNFe`; senão do último evento 110111/110112 encontrado; senão do `protNFe`
  (`WebServices.pas:2267-2283,2381-2387,2394-2399`).
- Sucesso do serviço = cStat ∈ {100, 120, 150} ∪ {101, 135, 151, 155} (`ACBrNFe.pas:286-311`; `WebServices.pas:2407-2411`).
- **Reconciliação da nota carregada com a mesma chave** (`WebServices.pas:2415-2564`): sempre grava
  `NFe.procNFe.cStat := cStat do retorno` (`:2443`); se `ValidarDigest` (default True — `ACBrDFeConfiguracoes.pas:251-252`)
  e o `digVal` do protNFe diferir do DigestValue da assinatura local ⇒ **exceção** (`:2434-2440`); reconstrói o `nfeProc`
  (XML local + `protNFe` do retorno) via `pcnProcNFe` (`:2477-2493`; `PCNNFe\pcnProcNFe.pas:302-312`), trocando
  apóstrofos por aspas porque **a SEFAZ-PR devolve atributos com apóstrofo** (`:2482-2485`); com
  `AtualizarXMLCancelado=True` (default False — `ACBrNFeConfiguracoes.pas:75-76,200`) regrava o proc com nProt/cStat do
  cancelamento (`:2447-2461`).
- Se houver eventos: monta `<chave>-NFeDFe.xml` = `NFeDFe` ⊃ `procNFe` (conteúdo do `nfeProc` local) + todos os
  `procEventoNFe` recortados do retorno (`:2505-2525`); grava nfeProc/NFeDFe se `Arquivos.Salvar` e houve atualização;
  com `ExtrairEventos` grava cada `procEventoNFe` separado (`:2527-2559`, `SalvarEventos` `:2188-2229`). Sem nota carregada,
  só extrai eventos (`:2567-2581`).

### 3.2 Mapa XML → bloco do DANFE (FPDF, A4)

Montagem e ordem das bandas: `ACBrNFeDANFeFPDF.pas:2706-2723` (todas as linhas desta seção referem-se a esse arquivo, salvo
indicação). Bandas `btData` aparecem uma vez; `btPageHeader`/`btPageFooter` repetem por página; marca d'água por página
(`..\Terceiros\FPDF-Pascal\ACBr_fpdf_report.pas:508-523,1001`).

| # | Bloco (banda, altura mm) | Campos do XML → posição | Configuração que interfere | Status |
|---|---|---|---|---|
| 0 | Marca d'água (`btWatermark`) `:2502-2600` | ver §3.2.1 | `Cancelada` do componente | ✅ |
| 1 | Canhoto (`btTopMargin` 20; só 1ª página) `:336-546` | texto "RECEBEMOS DE {emit.xNome} … INDICADA {ABAIXO\|AO LADO}. EMISSÃO: {dEmi dd/mm/aaaa} VALOR TOTAL: R$ {vNF} DESTINATÁRIO: {dest.xNome + endereço}" (tpNF entrada inverte emitente/destinatário) `:414-467`; caixa "NF-e / Nº {nNF} / Série {serie 000}" `:472-478`; "DATA DE RECEBIMENTO" e "IDENTIFICAÇÃO E ASSINATURA DO RECEBEDOR" `:480-489` | `FormatarNumeroDocumento` `:450-453`; posição sempre topo (P20) | ⚠️ |
| 2 | Identificação do emitente (header, 41% largura, 32) `:597-764` | emit.xNome (fonte 12,5→8 até caber), xLgr, nro, xCpl, xBairro, xMun, UF, CEP, fone | `Logo` (arquivo ou bytes), `LogoemCima`→centro, `ExpandeLogoMarca`→full, senão direita `:2673-2704` | ✅ |
| 3 | Bloco central "DANFE" (17%) `:766-814` | "Documento Auxiliar da Nota Fiscal Eletrônica", "0 - ENTRADA / 1 - SAÍDA" + tpNF, "Nº {nNF formatado}", "Série {000}", "Folha n/N" (double pass `:2620`) | — | ✅ |
| 4 | Código de barras e chave (42%) `:816-861` | **Code128 da chave (75×12 mm)** `:824-827`; "CHAVE DE ACESSO" formatada; "Consulta de autenticidade no portal nacional da NF-e / www.nfe.fazenda.gov.br/portal ou no site da Sefaz Autorizadora"; em contingência FS/FS-DA: 2º Code128 com a chave de contingência `:847-853` | — | ✅ |
| 5 | Natureza + protocolo `:863-970` | natOp; campo variável por tpEmis: normal/SVC → "PROTOCOLO DE AUTORIZAÇÃO DE USO" (ou "DE DENEGAÇÃO") + nProt + dhRecbto, ou "NFe sem Autorização de Uso da SEFAZ"; contingência → "DADOS DA NF-E" + chave de contingência; DPEC → protocolo do EPEC ou "NÚMERO DE REGISTRO DPEC" | — | ✅ |
| 6 | IE / IE ST / CNPJ (33%/33%/resto) `:972-999` | emit.IE, emit.IEST, emit.CNPJCPF (rótulo sempre "CNPJ") | — | ✅ (altura total do header 46 `:1004`) |
| 7 | Destinatário/Remetente (25) `:1015-1191` | xNome, CNPJ/CPF, data da emissão (só data), endereço, bairro, CEP, data saída/entrada, município (+ país se EXTERIOR), UF, fone, IE, hora saída/entrada | — | ✅ |
| 8 | Local de retirada / entrega (25 cada, se CNPJCPF preenchido) `:1196-1239,1250-1376` | grupos `retirada`/`entrega` — **retirada impressa antes de entrega** `:2713-2714` | — | ✅ |
| 9 | Fatura / duplicatas (variável) `:1389-1560` | texto: indPag ("à Vista"/"à Prazo") + nFat + vOrig + vDesc + vLiq (`ACBrNFeUtilsFPDF.pas:118-140`); grade Num./Venc./Valor, **15 por linha retrato (20 paisagem), até 8 (6) linhas** `:1527-1528`; só visível se houver `dup` `:1519-1523` | `ExibeCampoFatura`, `ExibeCampoDuplicata` | ⚠️ (P17) |
| 10 | Pagamentos (12; só com `ExibeCampoDePagamento=eipQuadro`, sem duplicatas, e não "sem pagamento") `:1570-1660,2716-2717` | tPag (descrição) + vPag; 4 por linha retrato (9 paisagem) até 5 linhas | `ExibeCampoDePagamento` | ⚠️ (P18) |
| 11 | Cálculo do imposto (18, 9 colunas × 2 linhas) `:1671-1762` | L1: vBC, vICMS, vBCST, vST, vII, vICMSUFRemet, vFCPUFDest ("VALOR DO FCP"), vPIS, vProd · L2: vFrete, vSeg, vDesc, vOutro, vIPI, vICMSUFDest, vTotTrib, vCOFINS, **vNF (negrito)** | nenhuma | ✅ |
| 12 | Transportador / volumes (25) `:1773-2004` | transporta.xNome, modFrete (descrição por versão), RNTC ("CÓDIGO ANTT"), placa/UF do veículo (ou do 1º reboque), CNPJ/CPF, xEnder, xMun, UF, IE; volumes **agregados**: soma qVol/pesoB/pesoL; esp/marca/nVol → "VARIAS" se divergem `:1913-1934`; pesos com 3 casas | — | ✅ |
| 13 | Produtos/serviços (ocupa o espaço livre; `DrawAgain` continua na página seguinte) `:2217-2498` | colunas (% largura): cProd ou cEAN 9 · descrição 28 · NCM 6 · O/CST ou O/CSOSN 5 · CFOP 4 · UN 3 · QUANT 7 · VALOR UNIT 6 · VALOR TOTAL 6 · B.CÁLC ICMS 6 · VALOR ICMS 6 · VALOR IPI 5 · ALÍQ. ICMS 3,5 · ALÍQ. IPI resto `:2288-2386`; uCom/qCom/vUnCom; **qCom e vUnCom com 4 casas fixas** `:2452-2456`; vProd (ou vProd−vDesc) `:2460` | `ImprimeCodigoEan`, `ExibeInforAdicProduto`, `ImprimeXPedNItemPed`, `ExibeTotalTributosItem`/`TributosPercentual`, `ImprimeDetalhamentoEspecifico` (via descrição), `ImprimeTotalLiquido` | ⚠️ (P19) |
| 14 | Cálculo do ISSQN (11; se ISSQNtot.vServ>0 e vBC≠0) `:2015-2083` | emit.IM, vServ, vBC, vISS | `ExibeDadosISSQN` ignorado | ✅ |
| 15 | Dados adicionais (`btPageFooter`, altura calculada) `:2088-2175` | "INFORMAÇÕES COMPLEMENTARES" (66%) com texto composto (§3.2.2) e "RESERVADO AO FISCO" (vazio) | ver §3.2.2 | ⚠️ (P16) |
| 16 | Rodapé (`btPageFooter`, 5) `:2179-2213` | — (sem fonte no XML) | `Sistema` (default "Projeto ACBr - www.projetoacbr.com.br", `ACBrDFeReport.pas:321`) dividido por `\|` em esquerda/centro/direita `:2781` | ✅ |

**Campos do XML sem destino no DANFE FPDF**: ⚠️ NOT MAPPED — totais IBS/CBS (0 ocorrências de IBS/CBS em
`ACBrNFeDANFeFPDF.pas`, `ACBrNFeDANFEClass.pas`, `ACBrDFeDANFeReport.pas` e no Fortes Retrato); vFCP/vFCPST/vFCPSTRet;
vICMSDeson (o FPDF não aplica `ExibeICMSDesoneradoComoDesconto` nos totais); uTrib/qTrib/vUnTrib (`ImprimeValor`
ignorado); vDesc por item como coluna; hora do dhEmi no bloco do destinatário (só data, `:1086`).
**Campos sem fonte no XML**: ⚠️ NO SOURCE — "Folha n/N" (motor), logo, rodapé, "RESERVADO AO FISCO".

#### 3.2.1 Marcas d'água (`:2509-2581`, cinza 230; carimbo por página)

| Condição | Texto |
|---|---|
| `Cancelada` do componente **ou** `procNFe.cStat` ∈ {101, 151, 155} (`ACBrNFeUtilsFPDF.pas:142-151`) | `NOTA CANCELADA` |
| tpEmis = DPEC (`ACBrNFeUtilsFPDF.pas:165-168`) | aviso de contingência DPEC recebida pela RFB (48 B) |
| `procNFe.cStat` ∈ {110, 301, 302, 303} (`ACBrNFeUtilsFPDF.pas:153-163`) | `NFe USO DENEGADO` + `SEM VALOR FISCAL` + xMotivo |
| tpAmb = homologação | `SEM VALOR FISCAL` (48) + `AMBIENTE DE HOMOLOGAÇÃO` (30) |
| produção, tpEmis contingência/FS-DA (não EPEC) | `DANFE Emitido em Contingência` + `devido à problemas técnicos` |
| produção, `procNFe.nProt` vazio | `SEM VALOR FISCAL` + `FALTA PROTOCOLO DE AUTORIZAÇÃO DA SEFAZ` |

O "cancelado" não vem do XML da NF-e: vem de quem imprime (`ImprimirDANFECancelado` liga a flag —
`ACBrDFeDANFeReport.pas:320-328`) ou do cStat gravado em memória pela consulta (`WebServices.pas:2443`).

#### 3.2.2 Texto dos dados adicionais (ordem fixa — `ACBrNFeDANFEClass.pas:774-788`)

1) protocolo de autorização se contingência/FS-DA com cStat 100 (`:751-761`); 2) "INSCRIÇÃO SUFRAMA" (`:763-772`,
`ExibeDadosInscricaoSuframa`); 3) "Pagamento(s): (…)" só com `eipAdicionais` (`:790-827`); 4) documentos referenciados
NF-e/NFC-e/CF-e/CT-e/ECF/NF/NFP (`:546-628`, `ExibeDadosDocReferenciados`); 5) infAdFisco (`ACBrDFeDANFeReport.pas:453-470`);
6) obsFisco xCampo: xTexto (`:528-548`); 7) procRef (`:550-573`); 8) obsCont (`:502-526`, `ImprimeInfContr`); 9) infCpl
(`:494-500`); 10) aviso de contingência (`ACBrNFeDANFEClass.pas:630-644`). Quebra de linha = caractere da configuração
(default `|`, `ACBrDFeDANFeReport.pas:218-223`).

#### 3.2.3 Paisagem e simplificado

- Orientação vem do **XML** (`ide.tpImp = tiPaisagem` ⇒ landscape), não de `TipoDANFE` (`:2643-2646`). Em paisagem
  mudam: fonte do rótulo do emitente (8 B × 6 I `:600-603`), duplicatas 20×6 (`:1527-1528`), pagamentos 9/linha com
  largura 28 (`:1593-1606`), texto do canhoto "AO LADO" (`:463`). Mesmo conjunto de bandas.
- Simplificado/resumido (`tiSimplificado`): ❌ não implementado no FPDF (`:2759-2762` → `ACBrDFeDANFeReport.pas:330-333`).
  Há units Fortes `ACBrNFeDANFeRLPaisagem.pas`, `ACBrNFeDANFeRLSimplificado.pas`, `ACBrNFeDANFeRLEtiqueta.pas` — ⚠️ não
  lidas (descarte).

#### 3.2.4 Fontes, margens, casas decimais

Fonte core **Times**, `SetUTF8(false)` e textos convertidos para ANSI (`:2618-2619`; `NativeStringToAnsi` em todo o arquivo);
tamanhos: rótulos 6, valores 10 (B), itens 7, título "DANFE" 14 B. Margens: defaults do componente 6/8/5,1/8 mm são
**trocados por 2 mm** quando não alterados (`:2648-2671`; defaults em `ACBrDFeReport.pas:325-328`). Casas decimais do
componente: `TCasasDecimais` qCom/vUnCom/alíquota = 2 (máx. 4/10/4) ou máscara (`ACBrDFeReport.pas:279-304,473-506`) —
**não usadas pelo FPDF** (qCom/vUnCom fixos em 4 casas; demais valores 2 casas).

#### 3.2.5 DANFE de evento (`TNFeDANFeEventoFPDF`, `:3556-3600`)

Retrato, margens 4 mm, Times. Bandas: Cabeçalho 18 (título = `detEvento.descEvento`; "Não possui valor fiscal, simples
representação do fato indicado abaixo."; "CONSULTE A AUTENTICIDADE NO SITE DA SEFAZ AUTORIZADORA.") `:2923-2954` · Dados da
nota 20 (modelo, série, número 9 dígitos, dhEmi com hora, Code128 + chave) `:3123-3204` · Dados do evento 25 (órgão, ambiente
"1 - PRODUÇÃO"/"2 - HOMOLOGAÇÃO (SEM VALOR FISCAL)", dhEvento, tpEvento, descrição, nSeq, versão, "cStat - xMotivo", protocolo,
dhRegEvento) `:3000-3121` · Emitente 25 · Destinatário 25 · só CC-e: "CONDIÇÕES DE USO" (xCondUso com quebras) `:2956-2973` ·
CC-e e cancelamento: "CORREÇÕES A SEREM CONSIDERADAS" (xCorrecao) ou "JUSTIFICATIVA DO CANCELAMENTO" (xJust) ocupando o resto
`:2975-2998` · rodapé de página: mensagem por tipo (CC-e/evento é representação gráfica sem validade; manter o XML) `:3508-3529`
+ linha `Sistema` `:3531-3554`. Sem marca d'água.

---

## 4. Fluxo de dados por entidade

**4.1 Cancelamento (fachada `Cancelamento`)** — ler nota carregada → exige ≥1 nota (`ACBrNFe.pas:801-802`) → por nota:
consulta situação (falha ⇒ exceção com a mensagem da consulta) (`:806-809`) → monta evento 110111 com chave/protocolo da
consulta, `dhEvento=now`, justificativa do chamador (`:811-821`) → `EnviarEvento`: valida 1..20 eventos, nSeq 0→1, tpAmb da
configuração, confere que a chave existe entre as notas carregadas, completa CNPJ/chave/nProt (`:928-993`) →
`TNFeEnvEvento.Executar`: URL pela UF da chave ou SVC (`WebServices.pas:3092-3177`), XML, assinatura por evento, XSD lote +
detEvento (`:3216-3740`) → resposta: lote 128 = sucesso; por evento 135/136/155 ⇒ proc + arquivo (`:3742-3834`) → falha de
serviço ⇒ exceção com `xMotivo` (`ACBrNFe.pas:823-827`) → **retorna True** (`:829`). ⚠️ A nota carregada não tem seu
`procNFe.cStat` atualizado pelo evento (só a consulta faz isso — `WebServices.pas:2443`).

**4.2 CC-e** — `CartaCorrecao.CCe` → cópia para `EventoNFe` com tpEvento 110110 → mesmo pipeline (`ACBrNFe.pas:895-926`);
`xCondUso` padrão aplicado na cópia do serviço (`WebServices.pas:3253`; `EventoClass.pas:896-911`).

**4.3 Inutilização** — `Inutilizar(CNPJ, just, ano, série, ini, fim)` com modelo da configuração (`ACBrNFe.pas:1098-1105`) →
valida CNPJ/CPF (`WebServices.pas:4349-4352`) e justificativa (`:2639-2654`) → URL pela UF da configuração (`:2672-2698`) →
XML (`Inut.pas:127-193`) e assinatura (`WebServices.pas:2758-2760`) → resposta: 102 = sucesso; 102/563 ⇒ `ProcInutNFe`
(`:2768-2813`) → falha ⇒ exceção com a mensagem (`:4362-4363`). Nenhuma lógica decide QUAIS números inutilizar (⚠️ não
encontrado: buracos/sequência são do chamador).

**4.4 Consulta** — chave do chamador ou de cada nota carregada (`ACBrNFe.pas:832-857`) → URL (`WebServices.pas:2086-2125`) →
`consSitNFe` (`:2165-2179`) → leitura (`RetConsSit.pas:166-281`) → protocolo/cancelamento/eventos → reconciliação da nota
carregada, digest, nfeProc, NFeDFe, arquivos (`WebServices.pas:2413-2581`). Sucesso só para cStat processado/cancelado.

**4.5 DANFE PDF** — `ImprimirDANFEPDF` percorre **todas** as notas carregadas (ignora o parâmetro) (`:2772-2774`) → cria o
relatório com a nota e o componente (`:2775`) → rodapé = `Sistema` (`:2781`) → motor comprimido → stream (nome lógico
`<chave>-nfe.pdf`) ou arquivo `PathPDF\<chave>-nfe.pdf` e `ArquivoPDF` atualizado (`:2786-2801`).

**4.6 PDF do evento** — `ImprimirEVENTOPDF` pareia `NotasFiscais[I]` com `EventoNFe.Evento[I]` (`:2836-2841`) → arquivo
`PathPDF\<tpEvento><chave>-nfe.pdf` (`:2861-2868`) — ⚠️ `ArquivoPDF` não é atualizado nesse ramo.

**4.7 E-mail** — NF-e: exige `ACBrMail` (`ACBrNFeNotasFiscais.pas:596-597`); anexa `XMLOriginal` como `<chave>-nfe.xml`
(após autorização/consulta o XMLOriginal é o `nfeProc` — `WebServices.pas:1274,1702,2493`) e, se `EnviaPDF`, o PDF do DANFE,
apagado ao final salvo `ManterPDFSalvo` (`ACBrNFeNotasFiscais.pas:606-627`). Evento: gera PDF do evento e anexa
`ArquivoPDF` + stream de `GravarStream` nomeado `<Id>-procEventoNFe.xml` (`ACBrNFe.pas:1107-1135`); `GravarStream` usa o
`XmlEnvio` do componente — gera o `envEvento` se vazio (`ACBrNFe.pas:777-785`). Assunto e corpo **sempre do chamador**; não há
texto padrão; corpo também vira AltBody sem HTML (`ACBrDFe.pas:298-306`). ⚠️ Nenhum envio automático pós-autorização no código.

---

## 5. Integrações externas identificadas

| Integração | Serviço / payload | Autenticação | Evidência |
|---|---|---|---|
| SEFAZ autorizadora — eventos | `NFeRecepcaoEvento4` / ação `nfeRecepcaoEvento`; `envEvento` → `retEnvEvento` (resultado em `nfeRecepcaoEventoResult`/`nfeRecepcaoEventoNFResult`/`nfeResultMsg`) | certificado do emitente + XMLDSig por evento | `WebServices.pas:3179-3193,3749-3751` |
| Ambiente Nacional (AN) | eventos fora de {CC-e, cancelamentos, prorrogação} → `LayNFeEventoAN`, UF "AN" | idem | `WebServices.pas:3126-3132` |
| SVRS | insucesso de entrega, conciliação financeira (55), eventos da Reforma Tributária | idem | `WebServices.pas:3134-3161` |
| SVC-AN / SVC-RS | eventos e consulta quando a forma de emissão configurada é SVC | idem | `WebServices.pas:3108-3116,2105-2112` |
| SEFAZ — inutilização | `NFeInutilizacao4` / `nfeInutilizacaoNF`; `inutNFe` → `retInutNFe` | certificado + XMLDSig | `WebServices.pas:2700-2728,2774-2776` |
| SEFAZ — consulta | `NFeConsultaProtocolo4` / `nfeConsultaNF`; `consSitNFe` → `retConsSitNFe` | certificado (TLS) | `WebServices.pas:2127-2152,2242-2244` |
| URLs | lidas de parâmetros por modelo × UF × ambiente × serviço × versão (`LerServicoDeParams`) — ⚠️ conteúdo do INI não lido aqui (outra frente) | — | `WebServices.pas:3166-3174,2687-2695,2114-2122` |
| SMTP (ACBrMail) | e-mail com anexos | configuração do ACBrMail (não lida) | `ACBrDFe.pas:289-338` |
| Sistema de arquivos | `-ped-eve/-eve`, `-procEventoNFe`, `-ped-inu/-inu`, `-procInutNFe`, `-ped-sit/-sit`, `-NFeDFe`, `-nfe.pdf` | — | §3 |
| Portal (texto no DANFE) | `www.nfe.fazenda.gov.br/portal` como link do bloco da chave | — | `ACBrNFeDANFeFPDF.pas:856-860` |

Não há credencial literal nem texto com cara de instrução para IA nos trechos lidos.

---

## 6. Pendências e inconsistências

| # | Sev. | Achado | Evidência |
|---|---|---|---|
| P1 | 🟡 | O `procEventoNFe` recorta o **1º** `infEvento`/`Signature` do XML enviado e o 1º `infEvento` da resposta, e casa evento↔retorno **só por chNFe** — lote com >1 evento (ou 2 eventos da mesma chave) grava proc trocado | `WebServices.pas:3772-3806` |
| P2 | 🟢 | O XSD do `detEvento` de TODOS os eventos do lote é o do tipo do ÚLTIMO evento (variável sobrescrita no laço) | `WebServices.pas:3247-3250,3718` |
| P3 | 🟡 | `Cancelamento` devolve True com evento rejeitado: só o cStat do lote (128) é conferido | `ACBrNFe.pas:823-829`; `WebServices.pas:3763` |
| P4 | 🟡 | `EnviarEmailEvento` anexa como `-procEventoNFe.xml` o `XmlEnvio` do componente (envEvento, sem retorno; a cópia assinada vive só no serviço) | `ACBrNFe.pas:777-785,1123-1130`; `WebServices.pas:3225-3227` |
| P5 | 🟡 | `ImprimirEVENTOPDF` em arquivo não atualiza `ArquivoPDF` → o e-mail do evento anexa PDF antigo/vazio | `ACBrNFeDANFeFPDF.pas:2857-2868` × `:2801`; `ACBrNFe.pas:1125-1126` |
| P6 | 🟡 | Raiz do proc de inutilização escrita `ProcInutNFe` (P maiúsculo); a leitura compara em minúsculas — conferir com o XSD | `WebServices.pas:2799`; `Inut.pas:229` |
| P7 | 🟢 | Validações da inutilização comentadas (Id, cUF, CNPJ, ini ≤ fim) | `Inut.pas:140-144,162-163,166-167` |
| P8 | 🟢 | `xJust` da inutilização concatenada sem escape XML e serviço sem validação XSD local | `Inut.pas:180`; `WebServices.pas:2741-2766` |
| P9 | 🟢 | `Ler_chNFePend` procura `chNFePend` dentro do próprio nó `chNFePend` (aparenta sempre vazio) | `RetEnvEvento.pas:621-630,665-669` |
| P10 | 🟢 | `qtdeItem` gravado com 2 casas e lido com 4 (prorrogação) | `EnvEvento.pas:1104`; `RetEnvEvento.pas:681` |
| P11 | 🟡 | Consulta com `AtualizarXMLCancelado=True` regrava o `nfeProc` com protocolo e cStat do cancelamento (autorização e cancelamento no mesmo arquivo) | `WebServices.pas:2447-2461` |
| P12 | 🟢 | `SalvarEventos` sempre grava (o envelope nunca é vazio); sobra de texto após o último evento aparenta gerar arquivo vazio com nome por timestamp | `WebServices.pas:2196-2227` |
| P13 | 🟢 | `cOrgao` 91 não é forçado para eventos roteados ao AN (default = UF da chave) | `EventoClass.pas:705-713`; `WebServices.pas:3126-3132` |
| P14 | 🟢 | Sem regra de prazo (cancelamento/CC-e) nem limite de 20 CC-e; cStat 656 não tratado | busca sem ocorrência em `ACBrNFe.pas`, `ACBrNFeWebServices.pas`, `Base\Servicos\` |
| P15 | 🟡 | `ManterProcreferenciado` imprime só o ÚLTIMO processo referenciado | `ACBrDFeDANFeReport.pas:558-568` |
| P16 | 🟡 | Dados adicionais: altura medida com a largura TOTAL e texto desenhado em 66% → corte possível; é rodapé repetido em todas as páginas, sem continuação | `ACBrNFeDANFeFPDF.pas:2105-2110,2147-2158,2090` |
| P17 | 🟡 | Duplicatas além de 120 (15×8 retrato; 20×6 paisagem) descartadas sem aviso | `ACBrNFeDANFeFPDF.pas:1527-1528,1494-1495` |
| P18 | 🟢 | Quadro de pagamentos com altura fixa 12 mm mas quebra até 5 linhas | `ACBrNFeDANFeFPDF.pas:1594,1636-1644,1660` |
| P19 | 🟢 | FPDF ignora opções do componente: `CasasDecimais` (4 casas fixas), `ImprimeValor`, `ImprimeDescAcrescItem` (sem coluna desconto), `ExibeResumoCanhoto`/`TextoResumoCanhoto`, `ExpandirDadosAdicionaisAuto`, `ImprimeTributos`, `ExibeDadosISSQN`, `ExibeICMSDesoneradoComoDesconto` nos totais, `TipoDANFE`, `Usuario`/`Site`, `NumCopias` | `ACBrNFeDANFeFPDF.pas:2452-2456`; 0 ocorrências por grep |
| P20 | 🟢 | `PosCanhoto` não é repassado (linha comentada; FPDF redeclara `TPosRecibo`) → canhoto sempre no topo; em paisagem o texto diz "AO LADO" | `ACBrNFeDANFeFPDF.pas:2779,463`; `ACBrNFeUtilsFPDF.pas:55` |
| P21 | 🟢 | Número no canhoto respeita `FormatarNumeroDocumento`; no cabeçalho é sempre formatado | `ACBrNFeDANFeFPDF.pas:450-453` × `:804` |
| P22 | 🟡 | Nenhum renderer de DANFE do ACBr mostra IBS/CBS, embora o writer da NF-e gere o grupo (nota em `..\ACBrComum\ACBr.inc:62-64`) | grep 0 em FPDF/DANFEClass/DANFeReport/Fortes Retrato |
| P23 | 🟢 | FPDF não implementa impressão direta, DANFE resumido/simplificado nem DANFE de inutilização (caem no `ErroAbstract`) | `ACBrNFeDANFeFPDF.pas:2744-2762,2879-2893`; `ACBrDFeDANFeReport.pas:261-264` |
| P24 | 🟢 | `ImprimirDANFEPDF` ignora o parâmetro e gera todas as notas carregadas; com stream, todas no mesmo stream | `ACBrNFeDANFeFPDF.pas:2772-2791` |
| P25 | 🟢 | PDF do evento pareia evento e nota por índice | `ACBrNFeDANFeFPDF.pas:2836-2841` |
| P26 | 🟢 | Título do PDF do evento lê `detEvento.descEvento` (preenchido só quando o evento vem de XML lido — `EnvEvento.pas:1166`); evento montado em memória aparenta sair sem título; homologação só no campo AMBIENTE | `ACBrNFeDANFeFPDF.pas:2941,3071,3037-3041`; `EventoClass.pas:531,620` |
| P27 | 🟢 | `GetTextoFatura` não sai quando `nFat` vazio | `ACBrNFeUtilsFPDF.pas:123-139` |
| P28 | 🟢 | Comentários em sintaxe PHP (`$this->…`, `foreach`) — aparenta porta de outro gerador de DANFE | `ACBrNFeDANFeFPDF.pas:774-784,1419,1610,1705-1756,2152-2155,2227-2229` |
| P29 | 🟢 | `indAceitacao` com tamanho 8..8 (conferir no XSD; fora do escopo) | `EnvEvento.pas:751` |
| P30 | 🟢 | `RetirarAcentos := False` ligado durante a geração para alguns eventos não volta para os seguintes do lote | `EnvEvento.pas:1019-1020` |

---

## 7. Resumo executivo

| Medida | Total | ✅ | ⚠️ | ❌ |
|---|---|---|---|---|
| Componentes (§2) | 20 | 11 | 7 | 2 |
| Entidades de mensagem (§3.1: envEvento comum, 110111, 110112, 110110, manifestação, EPEC, retorno/proc do evento, inutNFe, retorno/proc da inutilização, consSitNFe, retorno+reconciliação) | 11 | 9 | 2 | 0 |
| Blocos do DANFE (§3.2, incl. marca d'água) + PDF do evento | 18 | 13 | 5 | 0 |
| Campos do XML sem destino no DANFE (⚠️ NOT MAPPED) | 6 | — | — | — |
| Pendências (§6) | 30 | 🔴 0 | 🟡 10 | 🟢 20 |

O ACBr cobre o ciclo pós-autorização inteiro com regras explícitas de formação (Id 54 do evento, Id 43 da inutilização,
cStat 128 do lote × 135/136/155 do evento, 102/563 da inutilização, protNFe só nos cStat 100/101/104/150/151/155) e uma
reconciliação rica na consulta (digest conferido, nfeProc reconstruído, NFeDFe com eventos). O que falta ou está torto é
de borda: o proc do evento só é confiável com 1 evento por lote, a fachada de cancelamento não olha o cStat do evento, o
e-mail do evento anexa o XML errado, e o DANFE FPDF ignora boa parte das opções do componente, não mostra IBS/CBS e trunca
dados adicionais/duplicatas sem aviso.

---

## §8 Insumos para o planejamento da nfe-api

> **FORA DA FOTOGRAFIA.** Daqui em diante é leitura do analista para a Rodada da nfe-api — decisões continuam do Valdo.
> Referências cruzadas: Q-NE (§11.5 do `prompt_onda_nfe_sefaz.md`) e D-NE (§11.7, decididas 2026-10-10).
> Base própria conferida só para este bloco: `nfse-api\src\nfse\danfse.ts`, `nfse-api\src\nfse\transmission.ts`,
> `nfse-api\src\authority\adn.ts`, `fiscal-api\src\transport\xmldsig.ts`, `fiscal-api\src\storage\fiscal-storage.ts`,
> `fiscal-api\src\voice\kinds.ts`, `fiscal-api\src\time\zone.ts`.

1. **128 é do LOTE, 135/136/155 é do EVENTO.** (a) `WebServices.pas:3763,3788`; `ACBrNFe.pas:823-829`. (b) NE-3/NE-5.
   (c) **Refina D-NE13/D-NE14**: a voz C nasce do cStat do `retEvento`, nunca do 128; o ACBr erra justamente aí (P3).
   (d) MOC — significado de 128, 135, 136, 155 e da rejeição por evento.
2. **Um evento por envio.** (a) P1 `WebServices.pas:3772-3806` (proc recortado do 1º evento; casamento só por chave).
   (b) NE-3. (c) **Questão nova sugerida** (Q-NE27): `idLote` único com 1 evento e casamento por `Id` do evento.
   (d) XSD `envEvento`/`procEventoNFe` (aceita 1..20; nada obriga N>1).
3. **Identidade do evento = (tpEvento, chave, nSeqEvento)** no Id de 54 posições; nSeq de 2 dígitos, default 1.
   (a) `EnvEvento.pas:285-290,1013-1014`; `ACBrNFe.pas:945-946`. (b) NE-2 (DDL). (c) **Refina D-NE7**: a voz do evento
   ganha chave natural própria, separada da tentativa da autorização. (d) MOC/NT de eventos (faixa do nSeq; CC-e até 20).
4. **Cancelamento consulta antes de cancelar** e tira o `nProt` da consulta. (a) `ACBrNFe.pas:804-821,975-990`. (b) NE-5.
   (c) **Confirma D-NE13** (o padrão já existe na nfse-api: `reconfirmBeforeLocalCancel` e a reserva K antes do fisco —
   `nfse-api\src\nfse\transmission.ts:573,617-665`). (d) MOC 110111 (nProt obrigatório = protocolo de autorização).
5. **Inutilização tem chave natural explícita**: (cUF, AA, CNPJ, mod, série, nNFIni, nNFFin), Id de 43; ano com 2 dígitos;
   justificativa ≥ 15; sucesso 102; 563 também gera proc; o ACBr não escolhe números. (a) `Inut.pas:131-182`;
   `WebServices.pas:2639-2654,2793-2808`. (b) NE-2 (DDL `tb_invoice_number_void`) e NE-6. (c) **Confirma D-NE8** (a faixa é
   fato do `fiscal_api`; quem enxerga o buraco é o ERP, pela view). (d) XSD `inutNFe_v4.00` (nome da raiz `procInutNFe` — P6),
   significado do 563, prazo legal da inutilização.
6. **Inutilização não leva IE** no XML. (a) `Inut.pas:169-182`. (b) NE-3. (c) **Confirma D-NE18** como hipótese: é o serviço
   mais promissor para o smoke H com o A1 da Setes (sem IE). (d) Rejeições de inutilização para CNPJ não credenciado na UF.
7. **Consulta reconcilia por fato, não por memória**: protNFe só em cStat {100,101,104,150,151,155}; `retCancNFe` legado;
   N `procEventoNFe`; digest do protNFe conferido contra a assinatura local (exceção se diverge).
   (a) `RetConsSit.pas:198-273`; `WebServices.pas:2434-2440`. (b) NE-3/NE-5. (c) **Refina D-NE14** ("registro fiscal por
   FATO"): incluir a conferência `digVal` = DigestValue do XML guardado como prova de que o arquivo é o autorizado —
   **questão nova sugerida** (Q-NE28). (d) MOC — grupos do `retConsSitNFe`.
8. **Cancelamento nunca dentro do XML da autorização.** O ACBr só faz isso com `AtualizarXMLCancelado=True` (P11).
   (a) `WebServices.pas:2447-2461`; `ACBrNFeConfiguracoes.pas:75-76,200`. (b) NE-5. (c) **Confirma D-NE20** e o gate A8 da
   nfse-api (carimbo pelo estado vigente da voz — `nfse-api\src\nfse\danfse.ts:95-97`). (d) Nada oficial; regra de desenho.
9. **SEFAZ-PR devolve `protNFe` com apóstrofos.** (a) `WebServices.pas:2482-2485`. (b) NE-3 (adaptador; a Setes é do PR).
   (c) **Questão nova sugerida** (Q-NE29): o leitor do retorno precisa tolerar aspas simples (parser XML de verdade, nunca
   regex por `"`) — conferir na homologação real do PR. (d) Comportamento não documentado: provar em H.
10. **Rota por serviço × evento, não só por UF**: CC-e/cancelamentos → autorizadora (ou SVC); manifestação/EPEC/ator → AN;
    insucesso/conciliação/RTC → SVRS. (a) `WebServices.pas:3109-3161`. (b) NE-3. (c) **Refina D-NE3**: `authorizers.ts`
    precisa da dimensão serviço/evento. (d) Tabela oficial de URLs por serviço e NT dos eventos da RTC.
11. **Fuso do `dhEvento`**: offset por UF (tabela fixa −03/−04/−05 com horário de verão) ou do sistema ou manual.
    (a) `..\ACBrComum\ACBrUtil.DateTime.pas:269-315`; `EnvEvento.pas:1005-1008`. (b) NE-1. (c) **Confirma** a regra do núcleo
    (zona do estabelecimento — `fiscal-api\src\time\zone.ts:37`): nunca a tabela por UF. (d) MOC — formato TZD.
12. **Assinatura**: evento e inutilização assinados com a Signature como filha do pai do elemento com Id (`evento` ⊃
    `infEvento`; `inutNFe` ⊃ `infInut`). (a) `WebServices.pas:3663,2758-2760`. (b) NE-1. (c) **Confirma** que o
    `signXml` do núcleo serve sem mudança (`fiscal-api\src\transport\xmldsig.ts:51-70`). (d) MOC — algoritmo exigido
    (rsa-sha1 × sha256) por serviço.
13. **Validação XSD**: o ACBr valida a mensagem e o `detEvento` por tipo; não valida a inutilização. (a)
    `WebServices.pas:3677-3733,2741-2766`. (b) NE-3. (c) **Confirma D-NE16** e estende: validar também `inutNFe` e
    `consSitNFe` (P8). (d) Pacote PL de schemas.
14. **DANFE: lista de primitivas para a base de PDF do núcleo** — Code128 da chave (75×12 mm, subconjuntos A/B/C automáticos),
    "Folha n/N" (duas passadas), cabeçalho repetido, marca d'água por página, carimbos (CANCELADA, DENEGADA, homologação,
    contingência, "FALTA PROTOCOLO"). (a) `ACBrNFeDANFeFPDF.pas:813,824-827,2509-2581,2620`;
    `..\Terceiros\FPDF-Pascal\ACBr_fpdf_ext.pas:147`. (b) NE-1 (base) / NE-5 (DANFE). (c) **Refina D-NE20**: o pdfkit não tem
    código de barras e a nfse-api adotou "sem lib nova" (`nfse-api\src\nfse\danfse.ts:14-16`) — **questão nova sugerida**
    (Q-NE30): lib de barras (ex.: bwip-js) × Code128 próprio no núcleo. (d) Anexo II do MOC (simbologia exigida para a chave,
    dimensões, posições).
15. **Ordem e dimensões dos blocos do DANFE A4** (canhoto 20 · header 46 · destinatário 25 · retirada/entrega 25 ·
    fatura · pagamentos 12 · imposto 18 · transporte 25 · produtos (resto) · ISSQN 11 · dados adicionais · rodapé 5) e
    colunas de produtos em %. (a) `ACBrNFeDANFeFPDF.pas:2706-2723`, tabela §3.2. (b) NE-5. (c) Insumo do layout (D-NE20).
    (d) Anexo II — conferir cada bloco; o ACBr imprime retirada antes de entrega e repete os dados adicionais como rodapé.
16. **O DANFE do ACBr não tem IBS/CBS.** (a) P22. (b) Fase IBS/CBS. (c) **Refina D-NE4**: incluir o quadro do DANFE no prompt
    da fase — **questão nova sugerida** (Q-NE31). (d) NT 2025.002 (representação no DANFE).
17. **Configurações do DANFE** que o legado oferece e que viram `danfe_*` (D-E25): logo e posição, canhoto (posição/resumo),
    fatura/duplicata, pagamento (nunca/adicionais/quadro), código EAN, info adicional do produto, total de tributos por item
    (+ base %), detalhamento específico (veículos/medicamentos/rastro/arma/combustível), xPed/nItemPed, total líquido, doc.
    referenciados, SUFRAMA, obsCont, casas decimais, rodapé. (a) `ACBrNFeDANFEClass.pas:126-153`;
    `ACBrDFeDANFeReport.pas:139-151`; `ACBrDFeReport.pas:261`. (b) NE-5/NE-6. (c) **Questão nova sugerida** (Q-NE32): quais
    nascem no 1º release (Rec. do analista: o mínimo legal + logo; o resto sob demanda). (d) Anexo II (o que é obrigatório
    × facultativo).
18. **Casas decimais**: o FPDF força 4 casas em qCom/vUnCom; o componente aceita 0–4 / 0–10. (a) `ACBrNFeDANFeFPDF.pas:2452-2456`;
    `ACBrDFeReport.pas:279-304`. (b) NE-5. (c) Insumo de Q-NE32. (d) Anexo II e leiaute (qCom 4 casas, vUnCom até 10).
19. **Dados adicionais**: ordem de composição fixa e risco de corte (P16). (a) `ACBrNFeDANFEClass.pas:774-788`;
    `ACBrNFeDANFeFPDF.pas:2094-2174`. (b) NE-5. (c) Insumo de D-NE20 (teste de texto longo e de muitos itens).
    (d) Anexo II — continuação dos dados adicionais em folhas seguintes.
20. **E-mail**: anexos esperados = `<chave>-nfe.xml` (nfeProc com protocolo) + DANFE; para evento, o proc do evento — nunca o
    pedido (P4) — e o PDF do evento; assunto/corpo sem padrão no ACBr. (a) `ACBrNFeNotasFiscais.pas:588-631`;
    `ACBrNFe.pas:1107-1135`. (b) NE-5. (c) **Refina D-NE23**: o anexo é sempre o XML da VOZ (com protocolo); modelo de
    assunto/corpo vira config — **questão nova sugerida** (Q-NE33). (d) Obrigação de disponibilizar o XML ao destinatário.
21. **Nomes de arquivo** do legado (`-procEventoNFe`, `-procInutNFe`, `-NFeDFe`, `-ped-*`). O arquivo fiscal do núcleo exige
    CNPJ de 14 dígitos (`fiscal-api\src\storage\fiscal-storage.ts:33-38`); o ACBr trata emitente CPF (séries 910–969,
    `EnvEvento.pas:972-980`; MT com CPF na inutilização). (b) NE-2. (c) **Questão nova sugerida** (Q-NE34): emitente pessoa
    física fica fora da F4? (d) MOC — séries reservadas a PF.
22. **Conjugada**: o DANFE tem bloco ISSQN quando o serviço vai DENTRO da NF-e; cancelamento é por chave, sem composição.
    (a) `ACBrNFeDANFeFPDF.pas:2074-2083`. (b) NE-5. (c) **Confirma D-NE22** (o ACBr não oferece saga; a coordenação entre
    nfe-api e nfse-api é nossa). (d) Se a NF-e conjugada com ISSQN ainda vale para município no padrão nacional da NFS-e.
23. **Rodízio**: o ACBr não tem consulta periódica nem trata 656. (a) P14. (b) NE-5. (c) **Confirma D-NE26** (teto e
    intervalo vêm do oficial, não do ACBr). (d) Regra do 656 e prazos de cancelamento por UF.
24. **PDF do evento** (cancelamento/CC-e) existe no legado. (a) `ACBrNFeDANFeFPDF.pas:3556-3600`. (b) NE-5. (c) **Questão nova
    sugerida** (Q-NE35): gerar comprovante PDF do cancelamento ou só carimbar o DANFE (como a nfse-api)? (d) Não há leiaute
    oficial de representação de evento — conferir.
25. **Eventos da Reforma Tributária** (110001 e famílias 112xxx/211xxx/212xxx, via SVRS) já estão no componente.
    (a) `EnvEvento.pas:2464-3092`; `WebServices.pas:3151-3160`. (b) Fase IBS/CBS. (c) **Questão nova sugerida** (Q-NE36):
    entram no escopo da fase IBS/CBS ou ficam fora como manifestação/DF-e (D-NE25)? (d) NT 2025.002 — eventos.

---

## §9 Confiança e lacunas

- **Alta** em formação de XML, roteamento, tratamento de retorno e layout FPDF: leitura direta das linhas citadas.
- **Média** na semântica das bandas do motor FPDF (`btData` uma vez, page header/footer por página): inferida de
  `..\Terceiros\FPDF-Pascal\ACBr_fpdf_report.pas:508-523,1001`, sem execução.
- **Não verificado por execução**: P9, P12 e P26 são "aparenta" (lógica lida, não rodada).
- **Lacunas**: conteúdo de `ACBrNFeServicos.ini` (URLs, versões) e transporte SOAP/TLS (outra frente); motores Fortes/Fast
  (descartados) — paisagem/simplificado/etiqueta do Fortes não confirmados; algoritmo de assinatura do evento/inutilização
  (fica com a frente de transporte); `TACBrXmlWriter.AddNode` (como alertas de tamanho viram erro) não lido — a
  barreira efetiva é o XSD.
- **Perguntas ao dono do legado (intenção)**: (1) o Gestao2016 ligava `AtualizarXMLCancelado` ou `ValidarDigest`? (2) mandava
  mais de um evento por lote? (3) quais opções do DANFE o cliente usava (casas decimais, canhoto, pagamento em quadro)?
  (4) usava o e-mail do evento (que anexa o XML de envio — P4)?
