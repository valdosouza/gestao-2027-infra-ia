# ACBr NF-e — Transporte e ciclo de serviços com a SEFAZ
**Escopo**: setes
**Natureza**: referência de TERCEIRO — ACBr (LGPL 2.1), motor da NF-e no legado Gestao2016; nunca substitui o oficial (MOC/NT/XSD/WSDL)
**Fonte**: D:\Componentes\acbr\Fontes\ACBrDFe\ (change-log 19/08/2026) · leitura de 2026-10-10
**Agente**: legacy-analyst (plugin code-modernization) no método assess-legacy-repo

> Convenção de citação: caminhos relativos a `D:\Componentes\acbr\Fontes\ACBrDFe\`. Arquivos fora dessa pasta
> aparecem como `..\ACBrComum\...` ou `..\Terceiros\...`. Sem linha = não sabe → ⚠️.
> Fotografia (§1–§7): descreve o ACBr como ele é. O que a nfe-api deve fazer está SÓ no §8 (fora da fotografia).
> Licença: comportamento e regras, não código; literais de 1–3 linhas apenas quando a forma exata importa.

## Parâmetros do caso

| Parâmetro | Valor |
|---|---|
| Stack de origem | Delphi/FPC — ACBrNFe (`TACBrNFe`) sobre a base ACBrDFe; HTTP por Synapse+OpenSSL (alternativas WinINet/WinHttp/Indy) |
| Stack alvo | `nfe-api` (Node/TS, :3003, `/v1`) sobre o núcleo `fiscal-api` |
| Ordem de leitura | `ACBrNFeWebServices.pas` (inteiro) → `ACBrDFeWebService.pas` (inteiro) → `ACBrNFe.pas` (inteiro) → `ACBrDFe.pas` (inteiro) → `ACBrNFeServicos.ini` (estrutura + seções-chave) → `ACBrNFeConfiguracoes.pas` (inteiro) → `ACBrDFeConfiguracoes.pas`, `ACBrDFeSSL.pas`, `ACBrDFeHttpOpenSSL.pas`, `ACBrDFeOpenSSL.pas`, `ACBrDFeUtil.pas` (só transporte/URL/UF/fuso) |
| Descartes | `ACBrNFe\PCNNFe\pcnNFeW/pcnNFeR`, `*IniReader/*IniWriter/*JSON*`, relatórios, `ACBrECFVirtualNFCe\`, `__recovery\`; CAPICOM/WinCrypt/MSXML/WinApi só registrados como alternativa |
| Achados de texto dirigido a IA | nenhum nos arquivos lidos |
| Credencial literal | nenhuma nos arquivos lidos |

---

## 1. Visão geral

O `TACBrNFe` (`ACBrNFe\ACBrNFe.pas:76`) expõe atos de alto nível (`Enviar`, `Consultar`, `Cancelamento`, `EnviarEvento`,
`Inutilizar`, `DistribuicaoDFe`, `AdministrarCSC` — `ACBrNFe\ACBrNFe.pas:109-175`) que delegam a 11 classes de serviço
reunidas em `TWebServices` (`ACBrNFe\ACBrNFeWebServices.pas:593-634`). Toda classe herda o mesmo "molde de chamada" de
`TDFeWebService.Executar` (`ACBrDFeWebService.pas:202-253`): resolve URL/serviço/ação → monta a mensagem → embrulha num
envelope SOAP 1.2 textual → grava o pedido em disco → envia por HTTPS com o A1 do emitente → extrai a resposta por texto
→ interpreta o `cStat` → grava a resposta. A URL vem de um INI de serviços embutido como recurso e substituível por
arquivo externo (`ACBrNFe\ACBrNFe.pas:198`, `ACBrDFeConfiguracoes.pas:883-938`), indexado por modelo × UF × ambiente
(`ACBrDFe.pas:541`). O componente decide "sucesso" por uma lista curta de `cStat`; duplicidade, consumo indevido,
contingência automática e reconciliação após timeout NÃO estão no componente (ficam com a aplicação — §4.8).

---

## 2. Inventário de componentes

### 2.1 Unidades lidas

| Unidade | Responsabilidade (no que toca transporte) | Depende de | Status |
|---|---|---|---|
| `ACBrNFe\ACBrNFeWebServices.pas` (4366 l.) | 11 classes de serviço + `TWebServices.Envia/Inutiliza` | `ACBrDFeWebService`, `ACBrNFe`, PCN (ver P-25) | ✅ lido inteiro |
| `ACBrDFeWebService.pas` (640 l.) | molde `Executar`, envelope SOAP, envio, gravação de pedido/resposta | `ACBrDFe`, `ACBrDFeSSL` | ✅ lido inteiro |
| `ACBrNFe\ACBrNFe.pas` (1152 l.) | componente; atos de alto nível; cStat confirmada/cancelada; namespace; URL por config | `ACBrNFeWebServices` | ✅ lido inteiro |
| `ACBrDFe.pas` (700 l.) | resolução de URL no INI (`LerServicoDeParams`), versão por XSD, `Gravar` | `ACBrDFeConfiguracoes` | ✅ lido inteiro |
| `ACBrNFe\ACBrNFeServicos.ini` (1280 l.) | URLs por modelo/UF/ambiente; perfis de SOAPAction | — | ✅ estrutura inteira; URLs conferidas por amostra (PR, SVRS, SVAN, SVC, AN, SP, BA) |
| `ACBrNFe\ACBrNFeConfiguracoes.pas` (389 l.) | modelo, versão, CSC, caminhos NF-e/evento/inutilização | `ACBrDFeConfiguracoes` | ✅ lido inteiro |
| `ACBrNFe\Base\ACBrNFe.Consts.pas` (423 l.) | só o literal de namespace interessa (`:43`); resto são rótulos | — | ✅ (relevância baixa) |
| `ACBrDFeConfiguracoes.pas` (1556 l.) | `TWebServicesConf` (UF, ambiente, timeout, tentativas, proxy, TLS, fuso), `TArquivosConf.GetPath` | — | ⚠️ parcial (seções de transporte/caminhos) |
| `ACBrDFeSSL.pas` (2005 l.) | contrato HTTP, envio com/sem thread, carga do PFX, escolha de biblioteca | Synapse, `ACBrDFeOpenSSL` | ⚠️ parcial (HTTP/PFX/escolha de lib) |
| `ACBrDFeHttpOpenSSL.pas` (255 l.) | cliente HTTP Synapse+OpenSSL (proxy, header, PFX no socket, TLS, timeout) | Synapse | ✅ lido inteiro |
| `ACBrDFeOpenSSL.pas` (476 l.) | abrir PKCS#12 | OpenSSL | ⚠️ parcial (PFX) |
| `ACBrDFeUtil.pas` (1307 l.) | chave de acesso, fuso de validação, extratores de chave/recibo/protocolo do texto | — | ⚠️ parcial |
| `ACBrNFe\ACBrNFeNotasFiscais.pas` | (fora da lista, lido só para nomes de arquivo e validação XSD pré-envio) | — | ⚠️ parcial |
| `..\ACBrComum\ACBrUtil.DateTime.pas` | fuso (`TTimeZoneConf`, `GetUTC`, horário de verão, `DateTimeWithTimeZone`) | — | ⚠️ parcial |
| `..\ACBrComum\ACBrUtil.XMLHTML.pas` | `SeparaDados` (extração de tag por texto) | — | ⚠️ parcial |

### 2.2 Classes de serviço (`TWebServices`)

| Classe | Declaração / implementação | Ato | Status |
|---|---|---|---|
| `TNFeStatusServico` | `ACBrNFeWebServices.pas:96` / `:783-938` | consulta status | ✅ |
| `TNFeRecepcao` | `:133` / `:940-1385` | autorização (lote; síncrono/assíncrono; zip) | ✅ (ver P-02, P-03, P-05) |
| `TNFeRetRecepcao` | `:189` / `:1387-1802` | consulta do recibo com laço de tentativas + monta `nfeProc` | ✅ |
| `TNFeRecibo` | `:245` / `:1804-2015` | consulta avulsa de recibo (não anexa protocolo às notas) | ✅ |
| `TNFeConsulta` | `:290` / `:2017-2611` | consulta protocolo/situação (+ eventos) | ✅ (ver P-27) |
| `TNFeInutilizacao` | `:346` / `:2613-2834` | inutilização de faixa | ✅ |
| `TNFeConsultaCadastro` | `:404` / `:2836-3043` | consulta cadastro de contribuinte | ✅ |
| `TNFeEnvEvento` | `:456` / `:3045-3863` | recepção de evento (cancelamento, CC-e, EPEC, manifestação, eventos RTC) | ✅ (ver P-06, P-07) |
| `TAdministrarCSCNFCe` | `:493` / `:3865-3966` | administração de CSC (NFC-e) | ✅ |
| `TDistribuicaoDFe` | `:524` / `:3968-4204` | distribuição DF-e (AN) | ✅ |
| `TNFeEnvioWebService` | `:564` / `:4206-4276` | envio genérico (URL/ação/XML do chamador) | ✅ |

### 2.3 Bibliotecas de transporte (alternativas registradas)

| Opção | Evidência | Observação |
|---|---|---|
| Enum `TSSLHttpLib` = none / WinINet / WinHttp / OpenSSL / Indy | `ACBrDFeSSL.pas:64` | default `httpNone` (`ACBrDFeSSL.pas:1301`); escolha em `ACBrDFeSSL.pas:1901-1942` |
| OpenSSL (Synapse) | `ACBrDFeHttpOpenSSL.pas:51-252` | único caminho multiplataforma; lido inteiro |
| WinINet/WinHttp | `ACBrDFeSSL.pas:1912-1919` | Windows-only — não analisado |
| "Indy" (usa `InternetSetOption`) | `ACBrDFeSSL.pas:1921-1928`; `ACBrDFeHttpIndy.pas:220-237` | Windows-only; ignora falhas de certificado do servidor (P-01) |
| Integrador Fiscal (CE) | `ACBrDFeWebService.pas:418-436`; desligado para modelo 55 em `ACBrNFeWebServices.pas:750-770` | fora do escopo |
| Evento `OnTransmit` (aplicação faz o envio) | `ACBrDFeWebService.pas:410-416`; `ACBrDFe.pas:48-49` | gancho de terceiros |
| Criptografia: OpenSSL / CAPICOM / WinCrypt / CNG | `ACBrDFeSSL.pas:63`, `:1842-1899` | só registrado |

### 2.4 Configurações que governam o transporte (defaults do código)

| Configuração | Default | Evidência |
|---|---|---|
| `WebServices.UF` | `DFeUF[24]` = **SP** (código 35) | `ACBrDFeConfiguracoes.pas:769-770`; `ACBrDFe.Conversao.pas:601-606` |
| `WebServices.Ambiente` | homologação | `ACBrDFeConfiguracoes.pas:771` |
| `WebServices.TimeOut` | **5000 ms** | `ACBrDFeConfiguracoes.pas:782`; `ACBrDFeSSL.pas:1302` |
| `WebServices.TimeOutPorThread` | False | `ACBrDFeConfiguracoes.pas:783` |
| `WebServices.Tentativas` | 5 (≤ 0 vira 5) | `ACBrDFeConfiguracoes.pas:778`, `:940-946` |
| `WebServices.IntervaloTentativas` | 1000 ms (mínimo forçado 1000) | `ACBrDFeConfiguracoes.pas:779`, `:895-898` |
| `WebServices.AguardarConsultaRet` | 0 | `ACBrDFeConfiguracoes.pas:777` |
| `WebServices.AjustaAguardaConsultaRet` | False (se True, recebe `tMed`×1000 do status) | `ACBrDFeConfiguracoes.pas:780`; `ACBrNFeWebServices.pas:900-903` |
| `WebServices.SSLType` | `LT_TLSv1_2` | `ACBrDFeConfiguracoes.pas:786`; `ACBrDFeSSL.pas:1306` |
| `WebServices.Salvar` (envelope SOAP em disco) | False | `ACBrDFeConfiguracoes.pas:781` |
| `WebServices.ResourceName` (NF-e) | `ACBrNFeServicos` | `ACBrNFe\ACBrNFeConfiguracoes.pas:159` |
| `Geral.FormaEmissao` | normal | `ACBrDFeConfiguracoes.pas:536` |
| `Geral.Salvar` (pedido/resposta crus) | True | `ACBrDFeConfiguracoes.pas:537` |
| `Geral.ValidarDigest` | True | `ACBrDFeConfiguracoes.pas:549` |
| `Geral.ModeloDF` / `VersaoDF` (NF-e) | 55 / 4.00 | `ACBrNFe\ACBrNFeConfiguracoes.pas:197-199` |
| `Geral.AtualizarXMLCancelado` | False | `ACBrNFe\ACBrNFeConfiguracoes.pas:200` |
| `Arquivos.Salvar` | True | `ACBrDFeConfiguracoes.pas:1156` |
| `Arquivos.SepararPor*` / `AdicionarLiteral` | todos False | `ACBrDFeConfiguracoes.pas:1161-1167` |
| `Arquivos.PathSalvar` | `<pasta do executável>\Docs` | `ACBrDFeConfiguracoes.pas:1241-1250` |
| `Arquivos.PathSchemas` | `<pasta do executável>\Schemas` | `ACBrDFeConfiguracoes.pas:1252-1261` |
| `Arquivos.IniServicos` | `<pasta do executável>\ACBrNFeServicos.ini` | `ACBrDFeConfiguracoes.pas:1288-1295` |
| `Arquivos.SalvarEvento` | **False** | `ACBrNFe\ACBrNFeConfiguracoes.pas:288` |
| `Arquivos.SalvarApenasNFeProcessadas` | False | `ACBrNFe\ACBrNFeConfiguracoes.pas:289` |
| `Arquivos.EmissaoPathNFe` (pasta pela data de emissão) | False (pasta pela data de AGORA) | `ACBrNFe\ACBrNFeConfiguracoes.pas:287`; `ACBrNFeNotasFiscais.pas:763-766` |
| `Certificados.VerificarValidade` | True | `ACBrDFeConfiguracoes.pas:90` |
| `TimeZoneConf.ModoDeteccao` | `tzSistema` | `..\ACBrComum\ACBrUtil.DateTime.pas:98-99`, `:472` |
| `UseCertificateHTTP` (mTLS) | True, reafirmado a cada `Clear` de serviço | `ACBrDFeSSL.pas:1314`; `ACBrNFeWebServices.pas:669-670` |

---

## 3. Mapa serviço → operação / URL / envelope / retorno

### 3.1 Serviços (layout 4.00 — o que o código monta)

Namespace base: `http://www.portalfiscal.inf.br/nfe` (`ACBrNFe\ACBrNFe.pas:53`); `GetUrlWsd` = namespace + `/wsdl/`
(`ACBrDFeWebService.pas:615-618`). "Servico" é usado como `xmlns` do elemento de corpo (`ACBrDFeWebService.pas:340`).
`Servico` e `SoapAction` só recebem o valor padrão do código quando o INI não trouxe outro (testes `EstaVazio`).

| Serviço | Chave no INI (`NomeServico`) | Servico (= xmlns do corpo) | SOAPAction padrão | Mensagem | Tag extraída da resposta | "Sucesso" no código | Arquivos ped/resp |
|---|---|---|---|---|---|---|---|
| Status | `NfeStatusServico` | `…/wsdl/NFeStatusServico4` (`:819`) | `+/nfeStatusServicoNF` (`:821`) | `consStatServ` tpAmb+cUF (`:853-858`) | `nfeResultMsg` (`:868-870`) | 107 (`:905`) | `ped-sta`/`sta` (`:791-792`) |
| Autorização | `NfeAutorizacao` (`:1064-1067`) | `…/NFeAutorizacao4` (`:1099`) | `+/nfeAutorizacaoLote` (`:1101`); zip: `+ZIP` (`:1117-1118`) | `enviNFe versao` + `idLote` + `indSinc` + NFe assinadas (`:1149-1162`) | `nfeResultMsg`/`nfeResultMsgZip` (`:1182-1187`) | assínc.: 103 (`:1321`) · sínc.: lote 104 **e** protNFe ∈ {100,120,150} (`:1232-1233`) | `env-lot`/`rec`; sínc.: `pro-rec` ou `pro-lot` (`:965-966`, `:1368-1385`) |
| Ret. autorização | `NfeRetAutorizacao` (`:1534-1537`) | `…/NFeRetAutorizacao4` (`:1569`) | `+/nfeRetAutorizacaoLote` (`:1571`) | `consReciNFe` tpAmb+nRec (`:1597-1613`) | `nfeResultMsg` (`:1617-1620`) | repete enquanto 105 (`:1638`); fecha em 104 (`:1503-1504`) | `ped-rec`/`pro-rec` (`:1433-1434`) |
| Recibo avulso | idem | idem (`:1865-1887`) | idem | idem (`:1955-1971`) | idem (`:1975-1978`) | 104 (`:1996`) | `ped-rec`/`pro-rec` (`:1826-1827`) |
| Consulta protocolo | `NfeConsultaProtocolo` | `…/NFeConsultaProtocolo4` (`:2136`) | `+/nfeConsultaNF` (`:2138`) | `consSitNFe` tpAmb+chNFe (`:2165-2179`) | `nfeResultMsg` (`:2242-2244`) | cStat processado OU cancelado (`:2407-2411`) | `ped-sit`/`sit` (`:2042-2043`) |
| Inutilização | `NfeInutilizacao` | `…/NFeInutilizacao4` (`:2710`) | `+/nfeInutilizacaoNF` (`:2712`) | `inutNFe` assinado em `infInut` (`:2741-2766`) | `nfeResultMsg` (`:2774-2776`) | 102 (`:2793`) | `ped-inu`/`inu` (`:2621-2622`) |
| Consulta cadastro | `NfeConsultaCadastro` | `…/CadConsultaCadastro4` (`:2918`) | `+/consultaCadastro` (`:2920`) | `ConsCad` UF + IE ou CNPJ ou CPF (`:2964-2987`); MT: mensagem embrulhada em `nfeDadosMsg` e corpo `consultaCadastro` (`:2978-2982`, `:3038-3042`) | `consultaCadastroResult`…`nfeResultMsg` (`:2991-2994`) | 111/112 (`:3010`) | `ped-cad`/`cad` (`:2862-2863`) |
| Evento | `RecepcaoEvento` (layouts Evento/EventoAN) ou `EventoEPEC` (NFC-e SP) | `…/NFeRecepcaoEvento4` (`:3184`) | `+/nfeRecepcaoEvento` (`:3186`) | `envEvento` idLote + `evento`(s) assinados em `infEvento` (`:3644-3675`) | `nfeResultMsg` (`:3749-3751`) | lote 128 (`:3763`); por evento 135/136/155 (`:3788`) | `ped-eve`/`eve` (`:3068-3069`) |
| CSC (NFC-e) | `AdministrarCSCNFCe` | `…/CscNFCe` (`:3896`) | `+/admCscNFCe` (`:3897`) | `admCscNFCe` (`:3900-3917`); mantém cabeçalho `nfeCabecMsg` (`:3959`) | `admCscNFCeResult` (`:3921`) | 150–153 (`:3930-3940`) | `ped-csc`/`csc` (`:3885-3886`) |
| Distribuição DF-e | `NFeDistribuicaoDFe` | `…/NFeDistribuicaoDFe` (`:4039`) | `+/nfeDistDFeInteresse` (`:4040`) | corpo `nfeDistDFeInteresse` → `nfeDadosMsg` → `distDFeInt` (`:3995`, `:4043-4065`) | `nfeDistDFeInteresseResult`/`nfeResultMsg` (`:4072-4073`) | 137/138 (`:4136`) | `con-dist-dfe`/`dist-dfe` (`:3993-3994`) |
| Envio genérico | — (URL e ação do chamador — `:4232-4240`) | — | — | XML do chamador (`:4242-4256`) | `soap:Body` inteiro (`:4260`) | sempre True (`:4264`) | — |

Linhas sem prefixo = `ACBrNFe\ACBrNFeWebServices.pas`. Mapeamento layout → nome de serviço: `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:1191-1204`.
Versão < 4.00 (2.00/3.10) ainda existe nas mesmas classes (ex.: BA 3.10 com nomes próprios — `:823-830`, `:2140-2151`,
`:2714-2722`) — legado, fora do interesse.

### 3.2 Resolução da URL (algoritmo)

1. Seção = `<Modelo>_<UF>_<P|H>` (`ACBrDFe.pas:541`). Modelo = `NFe`/`NFCe` (prefixo do modelo).
2. Chave = `UPPER(NomeServico)_<versão 0.00>` — busca exata; se vazia, a de MAIOR versão ≤ pedida (`ACBrDFe.pas:456-510`).
   Leitura do INI é case-insensitive nas chaves (`TMemIniFile` — `ACBrDFe.pas:78`, `:201`).
3. `Servico` e `SoapAction` podem vir de seções-perfil apontadas pelas chaves `WSDL` e `SoapAction` da seção da UF
   (`ACBrDFe.pas:545-546`). Só BA usa (`SoapAction=SOAP_V4_BA` — INI `:84`, `:106`).
4. Sem URL → segue `Usar=<outra seção>` em laço, com proteção de redirecionamento circular (`ACBrDFe.pas:548-579`).
   Seção sem a URL e sem `Usar` → exceção "URL para o serviço … não encontrada" (`:573-574`).
5. Versão final da mensagem = versão do **XSD** encontrado em `PathSchemas` (maior ≤ pedida), quando houver
   (`ACBrDFe.pas:581-593`, `:375-442`). Pasta de schemas vazia → exceção (`ACBrDFe.pas:397-399`).
6. O INI vem do arquivo externo se existir; senão do recurso compilado (`ACBrDFeConfiguracoes.pas:883-938`).

Quem escolhe UF/modelo/ambiente em cada serviço:

| Serviço | Modelo | UF / seção | Ambiente | Evidência |
|---|---|---|---|---|
| Status | config | config; `SVC-AN`/`SVC-RS` se `FormaEmissao` for SVC | config | `ACBrNFe\ACBrNFe.pas:511-533` |
| Autorização / Ret. / Recibo | da 1ª nota (ou config) | `cUF` da 1ª nota; SVC pela `FormaEmissao` | config (exceção se ≠ `tpAmb` da nota) | `ACBrNFeWebServices.pas:1045-1087`, `:1515-1557`, `:1897-1939` |
| Consulta | da chave | UF da chave; SVC pela `FormaEmissao` | `tpAmb` da 1ª nota carregada, senão config | `:2086-2125` |
| Evento | da chave | UF da chave; SVC pela `FormaEmissao`; `AN` para eventos fora da lista; `SVRS` para eventos RTC/insucesso/conciliação (55) | `tpAmb` do evento | `:3092-3177` |
| Inutilização | parâmetro | **UF da config** (nunca SVC) | config | `:2672-2698` |
| Consulta cadastro | config | UF parâmetro (ou config) | config | `:2940-2962` |
| DistDFe | da chave (ou config) | `AN` | config | `:4011-4035` |

Lista de eventos que ficam na autorizadora (UF/SVC): CC-e, cancelamento, cancelamento por substituição, pedidos e
cancelamentos de prorrogação (`:3126-3128`). EPEC de NFC-e só em SP (`:3118-3123`). Eventos da Reforma Tributária →
SVRS (`:3151-3160`; change-log `ACBrNFe\ACBrNFe-change-log.txt` entrada de 29/10/2025).

### 3.3 Estrutura do `ACBrNFeServicos.ini`

- **127 seções**: 64 `NFe_*`, 58 `NFCe_*`, 5 perfis (`WSDL_V4`, `SOAP_V4`, `WSDL_V4_SP`, `SOAP_V4_SP`, `SOAP_V4_BA` — INI `:1238-1280`).
- **72 redirecionamentos** `Usar=`; **307** chaves `*_4.00=https…`.
- Seções virtuais: `NFe_SVAN` (`:513/533`), `NFe_SVRS` (`:553/572`), `NFe_SVC-AN` (`:591/608`), `NFe_SVC-RS` (`:625/639`),
  `NFe_AN` (`:652/657`), `NFCe_SVAN` (vazias — `:1206-1209`), `NFCe_SVRS` (`:1210/1224`).
- Chaves extras de NFC-e: `URL-QRCode*`, `URL-ConsultaNFCe*` (ex.: PR `:1016-1021`), `AdministrarCSCNFCe_1.00` (só AM e GO —
  `:709`, `:729`, `:806`, `:833`), `EventoEPEC_1.00` (só SP — `:1158`, `:1179`).
- Valor vazio = serviço não oferecido (ex.: `NfeConsultaCadastro_4.00=` em NFC-e MG — `:865`, `:876`).

### 3.4 Tabela UF → autorizador (como está no INI)

Hosts das seções virtuais: SVRS-55 `nfe.svrs.rs.gov.br` / `nfe-homologacao.svrs.rs.gov.br` (cadastro em `cad.` /
`cad-homologacao.svrs.rs.gov.br` — `:564-570`, `:583-589`); SVRS-65 `nfce.svrs.rs.gov.br` / `nfce-homologacao.svrs.rs.gov.br`
(`:1217-1222`, `:1231-1236`); SVAN `www.sefazvirtual.fazenda.gov.br` / `hom.sefazvirtual.fazenda.gov.br` (`:526-531`, `:546-551`);
SVC-AN = mesmos hosts da SVAN (`:601-606`, `:618-623`); SVC-RS = mesmos hosts da SVRS-55 (`:632-637`, `:646-650`); AN
eventos `www.nfe.fazenda.gov.br` / `hom1.nfe.fazenda.gov.br` (`:655`, `:660`); DistDFe `www1.nfe.fazenda.gov.br` /
`hom1.nfe.fazenda.gov.br` (`:654`, `:659`).

| UF | NF-e 55 P | NF-e 55 H | NFC-e 65 P | NFC-e 65 H | Linhas (55 P/H · 65 P/H) |
|---|---|---|---|---|---|
| AC | SVRS | SVRS | SVRS | SVRS | 2/5 · 664/670 |
| AL | SVRS | SVRS | SVRS | SVRS | 8/11 · 676/682 |
| AP | SVRS | SVRS | SVRS | SVRS | 14/17 · 688/694 |
| AM | nfe.sefaz.am.gov.br | homnfe.sefaz.am.gov.br | nfce.sefaz.am.gov.br | homnfce.sefaz.am.gov.br | 20/42 · 700/720 |
| BA | nfe.sefaz.ba.gov.br | hnfe.sefaz.ba.gov.br | SVRS | SVRS | 64/86 · 740/748 |
| CE | SVRS | SVRS | SVRS | SVRS | 108/111 · 756/762 |
| DF | SVRS | SVRS | SVRS | SVRS | 114/117 · 768/774 |
| ES | SVRS | SVRS | SVRS | SVRS | 120/123 · 780/786 |
| GO | nfe.sefaz.go.gov.br | homolog.sefaz.go.gov.br | nfe.sefaz.go.gov.br | homolog.sefaz.go.gov.br | 126/148 · 792/819 |
| MA | **SVAN** | **SVAN** | SVRS | SVRS | 170/174 · 846/852 |
| MG | nfe.fazenda.mg.gov.br | hnfe.fazenda.mg.gov.br | nfce.fazenda.mg.gov.br | hnfce.fazenda.mg.gov.br | 178/196 · 858/869 |
| MS | nfe.sefaz.ms.gov.br | hom.nfe.sefaz.ms.gov.br | nfce.sefaz.ms.gov.br | hom.nfce.sefaz.ms.gov.br | 218/239 · 880/899 |
| MT | nfe.sefaz.mt.gov.br | homologacao.sefaz.mt.gov.br | nfce.sefaz.mt.gov.br | homologacao.sefaz.mt.gov.br | 260/281 · 918/935 |
| PA | SVRS | SVRS | SVRS | SVRS | 299/302 · 952/958 |
| PB | SVRS | SVRS | SVRS | SVRS | 305/308 · 964/970 |
| PE | nfe.sefaz.pe.gov.br | nfehomolog.sefaz.pe.gov.br | SVRS | SVRS | 311/333 · 976/982 |
| PI | SVRS | SVRS | SVRS | SVRS | 353/356 · 988/995 |
| **PR** | nfe.sefa.pr.gov.br | homologacao.nfe.sefa.pr.gov.br | nfce.sefa.pr.gov.br | homologacao.nfce.sefa.pr.gov.br | 359/375 · 1002/1023 |
| RJ | SVRS | SVRS | SVRS | SVRS | 391/394 · 1044/1050 |
| RN | SVRS | SVRS | SVRS | SVRS | 397/400 · 1056/1062 |
| RO | SVRS | SVRS | SVRS | SVRS | 403/406 · 1068/1074 |
| RS | nfe.sefazrs.rs.gov.br | nfe-homologacao.sefazrs.rs.gov.br | nfce.sefazrs.rs.gov.br | nfce-homologacao.sefazrs.rs.gov.br | 409/428 · 1080/1097 |
| RR | SVRS | SVRS | SVRS | SVRS | 447/450 · 1114/1120 |
| SC | SVRS | SVRS | SVRS | SVRS | 453/456 · 1126/1132 |
| SE | SVRS | SVRS | SVRS | SVRS | 459/462 · 1138/1144 |
| SP | nfe.fazenda.sp.gov.br | homologacao.nfe.fazenda.sp.gov.br | nfce.fazenda.sp.gov.br | homologacao.nfce.fazenda.sp.gov.br | 465/486 · 1150/1171 |
| TO | SVRS | SVRS | SVRS | SVRS | 507/510 · 1192/1199 |

Totais: NF-e 55 = 10 autorizadoras próprias + 16 SVRS + 1 SVAN; NFC-e 65 = 8 próprias + 19 SVRS.
PR NF-e: as URLs de POST terminam em `?wsdl` (ex.: `NFeAutorizacao4?wsdl` — INI `:372`, `:388`).
Mapa UF → SVC-AN/SVC-RS: ⚠️ não está no código (a aplicação escolhe `teSVCAN`/`teSVCRS`).

### 3.5 Envelope SOAP 1.2

- Forma: `<soap12:Envelope …>` com atributos `xmlns:xsi`, `xmlns:xsd` e `xmlns:soap12="http://www.w3.org/2003/05/soap-envelope"`
  (`ACBrDFeWebService.pas:170-176`); corpo `<soap12:Body><nfeDadosMsg xmlns="<Servico>">` + mensagem
  (`ACBrDFeWebService.pas:318-347`).
- **Sem `<soap12:Header>` na 4.00** — o cabeçalho `nfeCabecMsg` (cUF + versaoDados) só é montado quando há
  `HeaderElement` (`ACBrNFeWebServices.pas:692-693`, `:1031-1034`; `ACBrDFeWebService.pas:331-338`, `:593-598`). Exceção: CSC
  força `nfeCabecMsg` (`ACBrNFeWebServices.pas:3955-3960`).
- Declaração XML só no build FPC; no Delphi o envelope é convertido para UTF-8 antes do envio, salvo se já assinado
  (`ACBrDFeWebService.pas:324-328`, `:393-397`).
- HTTP: método POST quando há corpo (`ACBrDFeSSL.pas:1049-1056`); `Content-Type: application/soap+xml; charset=utf-8`
  quando o serviço não define outro (`ACBrDFeSSL.pas:1410-1411`); header separado `SOAPAction: "<ação>"`
  (`ACBrDFeHttpOpenSSL.pas:160-161`); HTTP/1.1, `User-Agent` próprio (`:158-159`). ⚠️ O código NÃO coloca `action=` no
  `Content-Type`.
- Compactação: só na autorização com `Zipado` — corpo vira `nfeDadosMsgZip` com `base64(gzip(declaração + enviNFe))`
  e ação `…ZIP` (`ACBrNFeWebServices.pas:1115-1125`, `:1164-1165`). Nenhum outro serviço compacta. DistDFe recebe `docZip`
  (descompactação em `ACBrDFeComum.RetDistDFeInt` — ⚠️ não lido).
- Extração da resposta: busca TEXTUAL da 1ª ocorrência das tags candidatas (`SeparaDadosArray`, case-insensitive, tolera
  prefixo — `..\ACBrComum\ACBrUtil.XMLHTML.pas:398-464`). Vazio → exceção `"Erro ao obter resposta do webservice."` com o
  corpo cru anexado (`ACBrDFeWebService.pas:57-58`, `:606-613`).
- HTTP fora de 200–202 → exceção `EACBrDFeException` com código interno, HTTP, URL, descrição e o corpo
  (`ACBrDFeSSL.pas:1071-1081`; formato em `..\ACBrComum\ACBrConsts.pas:380`). SOAP Fault: ⚠️ não há parser de Fault — um
  Fault com HTTP 500 cai nessa exceção; um Fault com HTTP 200 cai em "Erro ao obter resposta" (inferido do fluxo).

---

## 4. Fluxo por serviço

### 4.1 Autorização (`TACBrNFe.Enviar` → `TWebServices.Envia`)

1. Pré-envio: limpa; exige 1 ≤ notas ≤ 50; assina; **valida no XSD** (`ACBrNFe\ACBrNFe.pas:865-893`; validação em
   `ACBrNFeNotasFiscais.pas:390-436`, schema pela versão do `infNFe`).
2. `InicializarServico`: NFC-e força síncrono e no máximo 1 nota (NT 2023/002 — `ACBrNFeWebServices.pas:1007-1016`); NF-e
   máximo 50 (`:1017-1022`); versão tirada da 1ª nota (`:1024-1027`).
3. Mensagem: `indSinc` presente para 4.00 (`:1149-1153`); cada `<NFe>` recortado do XML assinado (`:1155-1158`); limite de
   500 KB medido sobre a mensagem final, já zipada se for o caso (`:1167-1170`).
4. Envio: confere validade do certificado antes (`ACBrDFeWebService.pas:372-380`); envia; grava pedido e resposta.
5. **Síncrono** (`:1191-1304`): troca `retEnviNFe` por `retConsSitNFe` no texto para reaproveitar o leitor (`:1193-1201`);
   `cStat` público = o do protNFe quando houver (`:1215-1218`); sucesso = lote 104 e protNFe ∈ {100,120,150}
   (`:1232-1233`); casa a nota pela chave (`:1244`); compara DigestValue (`:1246-1251`); monta `nfeProc` (protocolo +
   NFe assinada — `:1265-1274`) e grava (`:1276-1293`).
6. **Assíncrono**: sucesso do envio = 103 (`:1321`) com recibo (`:1319`); `Envia` chama `Retorno.Executar`
   (`:4334-4339`), que dorme `AguardarConsultaRet`, consulta o recibo e repete enquanto a resposta for 105, até
   `Tentativas`, dormindo `max(IntervaloTentativas,1000)` (`:1480-1505`) — o laço chama a consulta uma vez a mais que o
   número de tentativas (condição avaliada em `:1493-1494`). Fechou em 104 → `TratarRespostaFinal` (`:1641-1768`): para
   cada `protNFe`, casa pela chave, compara DigestValue, copia os campos do protocolo e, se cStat ∈ {100,120,150},
   monta e grava `nfeProc`. Resultado True se **alguma** nota foi confirmada (`:1734-1742`); mensagem lista as não
   confirmadas (`:1744-1760`); `cStat`/protocolo/chave públicos = os do 1º protocolo (`:1762-1767`).
7. Erros: `Executar` falso → `GerarException` (`:4331-4332`, `:4337-4338`).

### 4.2 `cStat` — o que o código faz

| cStat | Onde | Comportamento |
|---|---|---|
| 100, 120, 150 | `ACBrNFe\ACBrNFe.pas:286-302`; `ACBrNFeWebServices.pas:1690` | "confirmada"/"processada": monta e grava `nfeProc`. Significado de 120: ⚠️ conferir no MOC |
| 101, 135, 151, 155 | `ACBrNFe\ACBrNFe.pas:304-311` | "cancelada" (consulta aceita como resultado válido — `:2407-2411`) |
| 102 | `:2793` | inutilização homologada; grava `-procInutNFe.xml` |
| 563 | `:2796-2809` | inutilização: também grava o "proc" (pedido + resposta), mas resultado = falha (P-16) |
| 103 | `:1321` | lote recebido → segue para consulta do recibo |
| 104 | `:1232`, `:1503`, `:1996` | lote processado |
| 105 | `:1638` | em processamento → repete |
| 107 | `:905` | serviço em operação |
| 111, 112 | `:3010` | consulta cadastro com resultado |
| 128 | `:3763` | lote de evento processado |
| 135, 136, 155 | `:3788` | evento registrado → monta e grava `procEventoNFe` |
| 137, 138 | `:4136` | DistDFe com/sem documentos |
| 150–153 | `:3930-3940` | CSC (contexto do serviço de CSC, não da NF-e) |
| 108, 109 | — | ⚠️ sem tratamento: status retorna falso; nenhuma troca automática para contingência |
| 110, 301, 302, 303 | — | ⚠️ sem tratamento próprio: não é "confirmada"; não gera `nfeProc`; no síncrono vira exceção (P-04) |
| 204, 539 | — | ⚠️ sem tratamento (P-10) |
| 656 | — | ⚠️ sem tratamento (P-10) |
| 999 | — | ⚠️ sem tratamento |

Varredura: os únicos literais de `cStat` em `ACBrNFeWebServices.pas`, `ACBrNFe.pas` e `ACBrNFeNotasFiscais.pas` são os
listados acima com linha (grep de 2026-10-10).

### 4.3 Consulta protocolo / situação (`TNFeConsulta`)

Chave validada (DV, UF, AAMM, CNPJ/CPF — `ACBrNFeWebServices.pas:2073-2084`; `ACBrDFeUtil.pas:772-810`). Lê
`retConsSitNFe`; cancelamento "antigo" (`retCancNFe`) e eventos 110111/110112 marcam cancelada e trocam protocolo/data
pelos do evento (`:2265-2283`, `:2381-2387`); senão usa o `protNFe` (`:2394-2399`). Atualiza a nota carregada cuja chave
= chave PEDIDA (`:2421`), compara DigestValue sem diferenciar maiúsculas (`:2434-2440`), troca aspas simples por duplas no
`protNFe` porque, segundo o comentário, a SEFAZ-PR devolve atributos com apóstrofo (`:2482-2485` — comportamento da SEFAZ
afirmado só em comentário), remonta `nfeProc` e grava `-nfe.xml`; havendo eventos, grava também `<chave>-NFeDFe.xml`
(`:2505-2555`) e, com `ExtrairEventos`, um `-procEventoNFe.xml` por evento (`:2188-2229`). `TACBrNFe.Consultar` ignora o
resultado e devolve True (P-08).

### 4.4 Cancelamento e eventos

`TACBrNFe.Cancelamento` (`ACBrNFe\ACBrNFe.pas:797-830`): para cada nota, **consulta primeiro** para obter o protocolo
(`:806-809`), monta o evento com `cOrgao` = UF da chave, `dhEvento := now` (relógio local — `:816`), `xJust`, e chama
`EnviarEvento`; exceção substituída pelo `xMotivo` do retorno (`:823-827`). `EnviarEvento` (`:928-999`): 1 a 20 eventos
(`:933-938`), `nSeqEvento` 0 vira 1 (`:945-946`), `tpAmb` da config (`:948`), protocolo da nota carregada ou por nova
consulta (`:975-990`). `TNFeEnvEvento.DefinirDadosMsg` (`ACBrNFeWebServices.pas:3216-3740`): copia campos por tipo de
evento, gera o lote, **assina cada `evento` em `infEvento`** (`:3651-3668`), valida o `envEvento` e cada `detEvento` no
XSD — exceção se falhar (`:3677-3733`). Resposta: lote 128; por evento 135/136/155 monta `procEventoNFe` = evento
assinado + `retEvento` e grava se `SalvarEvento` (`:3742-3834`).

### 4.5 Inutilização

`TACBrNFe.Inutilizar` usa o modelo da config (`ACBrNFe\ACBrNFe.pas:1098-1105`); `TWebServices.Inutiliza` valida CNPJ
(`ACBrNFeWebServices.pas:4344-4364`); justificativa obrigatória com ≥ 15 caracteres (`:2639-2654`); URL sempre da UF
configurada (`:2672-2698`); `inutNFe` assinado em `infInut` (`:2758-2760`); 102 → `procInutNFe` = pedido assinado +
retorno, gravado como `<Id sem literal>-procInutNFe.xml` (`:2795-2809`, `:2831-2834`).

### 4.6 Status do serviço

`consStatServ` com tpAmb e cUF da config (`:849-862`); sucesso 107; quando o host é SVRS e a diferença entre `dhRecbto` e
o relógio local passa de 50 min, subtrai 1 h do `dhRecbto` (ajuste de horário de verão — `:885-893`, P-14); com
`AjustaAguardaConsultaRet`, grava `tMed`×1000 em `AguardarConsultaRet` (`:900-903`).

### 4.7 Consulta cadastro, DistDFe, CSC, envio genérico

Ver §3.1. DistDFe nomeia arquivos `-resNFe.xml`, `-resEventoNFe.xml`, `-nfe.xml`, `-procEventoNFe.xml` e usa caminhos de
download (`:4083-4124`, `:4165-4204`). CSC exige `idCsc`/`codigoCsc` por operação (`:3900-3917`).

### 4.8 Duplicidade, reenvio e recuperação após timeout

- ⚠️ **Não implementado no componente**: nenhum literal 204/539/656 nos fontes de transporte (grep), nenhuma consulta
  automática pela chave após timeout ou erro de rede, nenhuma reemissão.
- Utilitários existem sem chamador no ACBr: extrair chave (44 dígitos validada), protocolo e recibo (15 dígitos) de um texto
  de `xMotivo` (`ACBrDFeUtil.pas:1171-1259`; grep de chamadores só os encontra nesta unit e em `..\PCNComum\pcnAuxiliar.pas`).
- A consulta do recibo (assíncrono) é a única "recuperação" nativa (§4.1-6); se o envio falhou antes de devolver recibo, o
  componente só lança exceção.

### 4.9 Contingência

- `tpEmis` 1..9 (`ACBrDFe.Conversao.pas:76-77`; `..\PCNComum\pcnConversao.pas:842-846`).
- **Troca de URL só para SVC** (6 = SVC-AN, 7 = SVC-RS), por configuração global (`FormaEmissao`): autorização, recibo,
  consulta, evento e status (§3.2). FS-IA (2), FS-DA (5), EPEC/DPEC (4) e off-line (9): nenhuma troca de URL no transporte.
- EPEC NF-e: evento enviado ao AN (layout `EventoAN` — `ACBrNFeWebServices.pas:3126-3132`); EPEC NFC-e só SP
  (`:3118-3123`; INI `:1158`, `:1179`).
- `dhCont`/`xJust` são gerados no XML quando preenchidos (`ACBrNFe\Base\ACBrNFe.XmlWriter.pas:619-627`); regras de
  coerência `tpEmis` × SVC na validação local (`ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:347-352`, `:510-540`).
- "Chave de contingência" de 36 dígitos para DANFE em FS/FS-DA (NT 2009.003) — `ACBrNFe\ACBrNFe.pas:407-479`.
- Retorno à normal e transmissão posterior das notas de contingência: ⚠️ não implementado no componente.
- ConfigurarSoapDEPC (SOAP 1.1 do DPEC antigo) existe e não é chamado (P-17).

### 4.10 Fuso, `dhEmi` e horário de verão

- `TimeZoneConf` é **singleton global** (`..\ACBrComum\ACBrUtil.DateTime.pas:459-465`), sobrescrito pela config do
  componente a cada serviço (`ACBrDFeWebService.pas:573`, `:583`) e a cada geração de XML (`ACBrNFeNotasFiscais.pas:664`).
- Modos: `tzSistema` (offset do SO), `tzPCN` (tabela por UF: AC −05, AM/RR/RO/MT/MS −04, demais −03) e `tzManual`
  (`..\ACBrComum\ACBrUtil.DateTime.pas:269-315`).
- Horário de verão: início/fim retornam 0 a partir de 2019 (decreto 9.772), logo nunca há horário de verão para datas
  atuais (`:361-376`, `:399-415`).
- `dhEmi`/`dhSaiEnt`/`dhCont` = hora de parede da nota + offset do modo (`ACBrNFe.XmlWriter.pas:519-525`, `:622-623`;
  `..\ACBrComum\ACBrUtil.DateTime.pas:178-184`). **A hora não é convertida**: `AjustarDataHoraParaUf` devolve a mesma
  hora salvo gancho externo (`:203-213`) — P-13.
- AAMM da chave sai da mesma data (`ACBrDFeUtil.pas:216`).
- Data de "agora" das regras locais convertida para o fuso configurado (`ACBrDFeUtil.pas:645-663`;
  `ACBrNFeNotasFiscais.pas:475-477`). `dhEvento` do cancelamento = `now` local (`ACBrNFe\ACBrNFe.pas:816`).

### 4.11 Erros — como aparecem para quem chama

| Classe | Quando | Evidência |
|---|---|---|
| `EACBrDFeException` (base) | qualquer falha do componente; `GerarException` levanta, salvo se o `OnGerarLog` marcar "tratado" | `ACBrDFeException.pas:46-50`; `ACBrDFe.pas:635-656` |
| `EACBrNFeException` | regras da NF-e (ambiente diferente, chave inválida, DigestValue não confere, lote/evento inválido) | `ACBrNFe\ACBrNFe.pas:58`; ex.: `ACBrNFeWebServices.pas:1051`, `:1250`, `:2081` |
| `EACBrDFeExceptionTimeOut` | só quando o erro interno do socket é 10060 (WSAETIMEDOUT) | `ACBrDFeException.pas:53`; `ACBrDFeWebService.pas:457-458` |
| `EACBrDFeExceptionNoPrivateKey` | declarada | `ACBrDFeException.pas:52` (uso ⚠️ não lido) |
| Exceção genérica "Timeout - Não foi possível obter a resposta do servidor" | modo `TimeOutPorThread` | `ACBrDFeSSL.pas:1413-1436` |
| Exceção com "Erro Interno / Erro HTTP / URL" + corpo | HTTP ≠ 200–202 ou falha de socket | `ACBrDFeSSL.pas:1071-1081`; `ACBrDFeHttpOpenSSL.pas:124-128` |
| "Erro ao obter resposta do webservice." + corpo | resposta sem a tag esperada | `ACBrDFeWebService.pas:606-613` |
| "Data de Validade do Certificado já expirou" | antes do envio | `ACBrDFeWebService.pas:376-380` |
| Mensagem amigável "Inativo ou Inoperante tente novamente" | exceção não-DFe em Status/CSC/DistDFe/genérico | `ACBrNFeWebServices.pas:934-938`, `:3962-3966`, `:4159-4163`, `:4267-4271`; aplicada em `ACBrDFeWebService.pas:243-248` |
| Rejeição de regra (cStat ≠ sucesso) | vira exceção com `xMotivo` nos atos de alto nível | `ACBrNFeWebServices.pas:4331-4338`; `ACBrNFe\ACBrNFe.pas:997-998`, `:1055-1056`, `:1070-1071` |

O evento `OnTransmitError` permite à aplicação pedir nova tentativa do mesmo envio (`ACBrDFeWebService.pas:448-462`).

---

## 5. Integrações externas identificadas

### 5.1 Endpoints

| Destino | Serviços | Autenticação | Payload |
|---|---|---|---|
| Autorizadoras próprias (10 UF no 55, 8 no 65) | todos os da UF | mTLS com o A1 do emitente | SOAP 1.2, §3.5 |
| SVRS / SVAN | UFs redirecionadas (§3.4) | idem | idem |
| SVC-AN / SVC-RS | contingência 6/7 | idem | idem |
| AN (Ambiente Nacional) | eventos fora da autorizadora (EPEC NF-e, manifestação…), DistDFe | idem | idem |
| SVRS (eventos RTC) | eventos da Reforma Tributária | idem | idem |
| SP EPEC NFC-e | `EventoEPEC_1.00` | idem | idem |
| URL de PFX remoto (`URLPFX`) | download do certificado | ⚠️ não lido em detalhe | `ACBrDFeSSL.pas:796-797`, `:833-860` |

### 5.2 TLS e certificado

- Fontes do A1: `URLPFX`, `DadosPFX`, `ArquivoPFX` ou `NumeroSerie` (repositório Windows) — `ACBrDFeSSL.pas:796-809`. Com
  OpenSSL o PKCS#12 é aberto com a senha (`ACBrDFeOpenSSL.pas:210-252`) e entregue inteiro ao socket como PFX + senha
  (`ACBrDFeHttpOpenSSL.pas:166-176`).
- Versão: `SSLType` → método OpenSSL (SSLv2/v3/TLS1.0/1.1/1.2 ou "TLS" negociado) — `ACBrDFeHttpOpenSSL.pas:211-244`.
- **Cadeia do SERVIDOR não é verificada**: no caminho OpenSSL a linha de `VerifyCert` está comentada
  (`ACBrDFeHttpOpenSSL.pas:200`), o default da Synapse é `False` (`..\Terceiros\synalist\blcksock.pas:4190`) e o contexto
  usa `SSL_VERIFY_NONE` (`..\Terceiros\synalist\ssl_openssl.pas:540-543`); nenhum `CertCAFile` é configurado pelo ACBr
  (grep). No caminho "Indy"/WinINet o código liga explicitamente "ignorar CA desconhecida, CN inválido, data inválida,
  revogação e uso" (`ACBrDFeHttpIndy.pas:227-232`). WinHttp: ⚠️ não lido. Ver P-01.
- Timeout: o mesmo valor em conexão, envio e túnel (`ACBrDFeHttpOpenSSL.pas:181-191`).
- Proxy: host/porta/usuário/senha (`ACBrDFeHttpOpenSSL.pas:150-154`).
- Concorrência: todo envio de uma instância passa por uma seção crítica (`ACBrDFeSSL.pas:1440-1446`, `:579-585`).

### 5.3 Arquivos (integração com o disco)

- `Gravar`: sem pasta no nome → `aPath` → `PathSalvar`; cria a pasta; sempre UTF-8; escreve direto no arquivo final
  (`ACBrDFe.pas:241-287`).
- Árvore (`GetPath`): base (`PathNFe`/`PathEvento`/`PathInu` ou `PathSalvar`) + na ordem configurada: CNPJ (do documento ou
  do certificado), IE, modelo, data (ano / ano+mês / dia) e literal (`NFe`, `NFCe`, `Evento`, `Inu`) — `ACBrDFeConfiguracoes.pas:1297-1402`;
  evento acrescenta a descrição do tipo quando `AdicionarLiteral` (`ACBrNFe\ACBrNFeConfiguracoes.pas:345-359`). Por padrão
  nenhuma separação está ligada (§2.4).
- Nomes:

| Arquivo | Nome | Evidência |
|---|---|---|
| NF-e (assinada e, depois, `nfeProc`) | `<chave>-nfe.xml` | `ACBrNFeNotasFiscais.pas:742-755` |
| Evento processado | `<Id do evento sem literal>-procEventoNFe.xml` | `ACBrNFeWebServices.pas:3810` |
| Inutilização processada | `<Id da inutilização sem literal>-procInutNFe.xml` | `:2805-2808` |
| Consulta com eventos | `<chave>-NFeDFe.xml` | `:2540` |
| Rastreio cru (pedido/resposta) | `<prefixo>-<ped-…>.xml` e `-soap.xml` | `ACBrDFeWebService.pas:466-522`; prefixos por serviço em §3.1 |
| DistDFe | `-resNFe.xml`, `-resEventoNFe.xml`, `-nfe.xml`, `-procEventoNFe.xml` | `ACBrNFeWebServices.pas:4089-4105` |

### 5.4 Arquivos de configuração e schemas

INI de serviços externo opcional (§3.2-6); pasta `Schemas` obrigatória para validar e para fixar versão (§3.2-5); INI
de configuração do componente grava senha do PFX e do proxy (P-20).

---

## 6. Pendências e inconsistências

Severidade adaptada a uma referência de terceiro: 🔴 = se reproduzido, causa risco fiscal/segurança · 🟡 = perda de
dado ou comportamento incorreto · 🟢 = débito sem impacto imediato. Objetivo, sem solução (as soluções vão ao §8).

| # | Sev. | Achado | Evidência |
|---|---|---|---|
| P-01 | 🔴 | Certificado do servidor da SEFAZ nunca é verificado (OpenSSL: verificação desligada por default; WinINet/"Indy": ignora CA/CN/data/revogação explicitamente) | `ACBrDFeHttpOpenSSL.pas:200`; `..\Terceiros\synalist\blcksock.pas:4190`; `..\Terceiros\synalist\ssl_openssl.pas:540-543`; `ACBrDFeHttpIndy.pas:227-232` |
| P-02 | 🟡 | Síncrono que volta 103: o desvio para a consulta do recibo em `Envia` só é alcançável se a exceção anterior for "tratada" pelo log — com resultado falso (`:1232`) a exceção sobe antes | `ACBrNFeWebServices.pas:1232-1233`, `:4331-4339`; `ACBrDFe.pas:650-655` |
| P-03 | 🟡 | Síncrono: autorização dada como sucesso (protocolo preenchido) mesmo se a chave do `protNFe` não casar com nenhuma nota carregada — o laço só deixa de anexar | `ACBrNFeWebServices.pas:1232-1303` |
| P-04 | 🟡 | Denegação (110/301/302/303) não é "confirmada" nem "processada": sem `nfeProc` gravado; no síncrono vira exceção | `ACBrNFe\ACBrNFe.pas:286-302`; `ACBrNFeWebServices.pas:1690`, `:1232` |
| P-05 | 🟡 | Lote assíncrono com várias notas: sucesso se QUALQUER uma foi confirmada; cStat/chave/protocolo públicos = do 1º protocolo | `ACBrNFeWebServices.pas:1734-1767` |
| P-06 | 🟡 | Lote com mais de um evento: `procEventoNFe` de cada evento montado com o 1º `infEvento` do pedido e do retorno (extração textual da 1ª ocorrência); casamento só por chave | `ACBrNFeWebServices.pas:3772`, `:3792-3801`; `..\ACBrComum\ACBrUtil.XMLHTML.pas:420` |
| P-07 | 🟡 | Evento: sucesso = lote 128; evento rejeitado dentro de lote 128 não gera exceção | `ACBrNFeWebServices.pas:3763`, `:3788`; `ACBrNFe\ACBrNFe.pas:995-998` |
| P-08 | 🟡 | `Consultar` ignora o resultado e devolve True | `ACBrNFe\ACBrNFe.pas:844`, `:852`, `:856` |
| P-09 | 🟡 | Roteamento SVC por configuração global, não pelo `tpEmis` da chave: nota autorizada em SVC e consultada/cancelada depois do retorno à normal vai à autorizadora da UF (inferido do fluxo) | `ACBrNFeWebServices.pas:1069-1077`, `:1539-1547`, `:2103-2112`, `:3108-3116` |
| P-10 | 🟡 | Duplicidade (204/539), consumo indevido (656), paralisação (108/109) e 999 sem tratamento; extratores de chave/recibo do `xMotivo` sem chamador | grep; `ACBrDFeUtil.pas:1171-1259` |
| P-11 | 🟡 | Timeout: classe própria só para o código 10060 (Windows); no modo por thread vira exceção genérica e a thread é abandonada; nenhuma reconciliação depois | `ACBrDFeWebService.pas:457-458`; `ACBrDFeSSL.pas:1413-1436` |
| P-12 | 🟡 | Fuso é estado global do processo, sobrescrito por cada serviço e cada geração de XML — instâncias com fusos diferentes disputam | `..\ACBrComum\ACBrUtil.DateTime.pas:459-465`; `ACBrDFeWebService.pas:573`, `:583`; `ACBrNFeNotasFiscais.pas:664` |
| P-13 | 🟡 | `dhEmi` = hora de parede + offset, sem conversão: em `tzSistema` o offset é o do servidor; em `tzPCN` com relógio fora do fuso da UF o instante declarado fica errado (inferido) | `..\ACBrComum\ACBrUtil.DateTime.pas:178-213`, `:269-281` |
| P-14 | 🟢 | Ajuste de horário de verão da SVRS no status ainda ativo (−1 h se divergência > 50 min), embora o horário de verão nunca mais seja reconhecido | `ACBrNFeWebServices.pas:885-893`; `..\ACBrComum\ACBrUtil.DateTime.pas:361-376` |
| P-15 | 🟢 | Versão da mensagem depende dos XSD presentes na pasta | `ACBrDFe.pas:581-593` |
| P-16 | 🟢 | Inutilização grava `-procInutNFe.xml` também no 563 (pedido + resposta de rejeição) | `ACBrNFeWebServices.pas:2796-2809` |
| P-17 | 🟢 | `ConfigurarSoapDEPC` declarado e nunca chamado; string de atributos malformada | `ACBrNFeWebServices.pas:76`, `:673-682` |
| P-18 | 🟢 | Perfis `WSDL_V4`, `SOAP_V4`, `WSDL_V4_SP`, `SOAP_V4_SP` sem nenhuma seção que os referencie; neles a chave `CadConsultaCadastro_4.00` difere do nome de serviço `NfeConsultaCadastro` | INI `:1238-1272`, `:84`, `:106`; `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:1194-1197` |
| P-19 | 🟢 | DigestValue comparado com maiúsculas no envio e sem diferenciar na consulta | `ACBrNFeWebServices.pas:1248`, `:1668`, `:2436` |
| P-20 | 🟢 | Senha do PFX gravada no INI em base64 sem cifra quando não há chave de cifra; senha do proxy cifrada com o próprio host como chave | `ACBrDFeConfiguracoes.pas:1063-1076`, `:828-829`, `:857-858` |
| P-21 | 🟢 | `SalvarEvento` default False: `procEventoNFe` (inclusive do cancelamento) não vai a disco por padrão; gravação sem escrita atômica | `ACBrNFe\ACBrNFeConfiguracoes.pas:288`; `ACBrDFe.pas:274` |
| P-22 | 🟢 | Limite de 500 KB medido depois de gzip+base64 | `ACBrNFeWebServices.pas:1164-1170` |
| P-23 | 🟢 | `GetPath` grava a ordenação na 1ª chamada; mudar `SepararPor*` depois não reordena | `ACBrDFeConfiguracoes.pas:1316-1324` |
| P-24 | 🟢 | Seções `NFCe_SVAN` vazias e cadastro NFC-e MG vazio → exceção "URL não encontrada" | INI `:1206-1209`, `:865`, `:876`; `ACBrDFe.pas:573-574` |
| P-25 | 🟢 | O caminho vigente ainda usa unidades PCN (`pcnConversaoNFe`, `pcnProcNFe`, `pcnConsReciDFe`, `pcnRetConsReciDFe`) — o aviso de descarte vale para `pcnNFeW/R`, não para estas | `ACBrNFeWebServices.pas:47`, `:54`, `:650` |
| P-26 | 🟢 | `ExtrairChaveMsg`/`…Protocolo`/`…Recibo` acessam o 1º caractere sem testar string vazia | `ACBrDFeUtil.pas:1181-1184`, `:1211-1214`, `:1241-1244` |
| P-27 | 🟢 | Consulta: o `protNFe` da resposta é anexado à nota da chave PEDIDA sem conferir `chDFe` (a atribuição da chave retornada está comentada) | `ACBrNFeWebServices.pas:2262`, `:2421-2474` |

Fila para o guardião conceitual (suspeitas de maquete): nenhuma tabela/estrutura de domínio nesta frente — o ACBr não
persiste estado (fora arquivos).

---

## 7. Resumo executivo

| Métrica | Valor |
|---|---|
| Classes de serviço | 11 — todas implementadas (11 ✅, 0 ❌) |
| Serviços SEFAZ distintos (chaves 4.00) | 9: status, autorização, ret. autorização, consulta protocolo, inutilização, consulta cadastro, recepção de evento (UF/AN/SVRS), DistDFe, CSC; + EPEC NFC-e SP |
| Unidades lidas | 15 (6 inteiras, 9 parciais) |
| INI | 127 seções (64 NF-e, 58 NFC-e, 5 perfis), 72 `Usar=`, 307 URLs 4.00 |
| UF mapeadas | 27 no 55 (10 próprias, 16 SVRS, 1 SVAN) · 27 no 65 (8 próprias, 19 SVRS) |
| `cStat` com tratamento explícito | 21 (100, 101, 102, 103, 104, 105, 107, 111, 112, 120, 128, 135, 136, 137, 138, 150, 151, 152, 153, 155, 563) |
| `cStat` pedidos sem tratamento | 10 (108, 109, 110, 204, 301, 302, 303, 539, 656, 999) |
| Pendências | 27 (🔴 1 · 🟡 12 · 🟢 14) |
| Texto dirigido a IA / credencial literal | 0 / 0 |

O ACBr cobre bem a mecânica: resolução de URL por dado (INI), envelope SOAP 1.2 mínimo sem cabeçalho na 4.00, mTLS com
o A1, validação XSD antes de enviar, síncrono/assíncrono com laço de recibo e montagem de `nfeProc`/`procEventoNFe`/
`procInutNFe`. O que falta está na POLÍTICA: não verifica o servidor, não trata duplicidade/consumo indevido/denegação,
não reconcilia após timeout, roteia contingência por estado global e trata fuso como estado global do processo — tudo isso
fica com a aplicação.

---

## 8. Insumos para o planejamento da nfe-api — FORA DA FOTOGRAFIA

> Daqui em diante é recomendação para o planejamento (não é descrição do ACBr). Cada item: (a) evidência,
> (b) onda, (c) relação com Q-NE, (d) o que conferir no OFICIAL antes de virar regra.

### 8.0 Núcleo hoje × o que a SEFAZ pede

| Tema | `fiscal-api` hoje | Falta para a SEFAZ |
|---|---|---|
| Transporte | `httpsRequest` mTLS PEM, `afterHandshake`, timeout 30 s (`fiscal-api/src/transport/https-json.ts:38`, `:58-91`) | POST de corpo arbitrário já serve; falta opção `ca`; `authorityJson` é só JSON (`:173-220`) |
| Classificação TLS | cadeia do servidor (`UNABLE_TO_GET_ISSUER_CERT_LOCALLY`, `SELF_SIGNED_CERT_IN_CHAIN`) cai em "credencial" (`https-json.ts:104-109`, `:124-128`) | separar falha de cadeia do SERVIDOR de falha da credencial |
| Assinatura | enveloped, C14N inclusiva, sha1/sha256, Signature último filho do pai (`fiscal-api/src/transport/xmldsig.ts:51-66`) | conferir algoritmo exigido pela NF-e (frente de assinatura) |
| Voz | `S A R C K F N` (`fiscal-api/src/voice/kinds.ts:7-15`) | P (103/105) e D (denegação) |
| Leitura | `TransmissionView` com campos do DPS/NFS-e e "quem detém a chave" (`fiscal-api/src/voice/reading.ts:10-34`, `:96-101`) | parte comum × parte da família (chave 44 nossa desde o envio) |
| Arquivo | `<cnpj>/<H>/<ano>/<mês>`, escrita atômica (`fiscal-api/src/storage/fiscal-storage.ts:8-10`, `:49-52`) | convenção de nomes da NF-e |
| Fuso | zona por estabelecimento, `nowIsoIn` (`fiscal-api/src/time/zone.ts:37-56`) | já atende — usar para `dhEmi`, AAMM da chave e `dhEvento` |
| Máquina | vive em `nfse-api/src/nfse/transmission.ts` (reserva → fisco fora da transação → A/R/F; ambíguo em voo; reconciliação por consulta — `:282-422`) | extrair para o núcleo (Q-NE13) e acrescentar estados da SEFAZ |

### 8.1 Lista numerada

1. **Autorizadores como DADO versionado, com redirecionamento.** (a) `ACBrDFe.pas:527-579`; INI 127 seções/72 `Usar=`;
   override externo `ACBrDFeConfiguracoes.pas:883-938`. (b) NE-0 (levantamento) → NE-3 (`authorizers.ts`). (c) Confirma
   Q-NE3 (a). (d) "Relação de Web Services" vigente do Portal NF-e: CE/PA/MA/BA-65/PE-65 em SVRS/SVAN, hosts PR (`?wsdl`
   no POST), mapa UF → SVC-AN/SVC-RS (ausente no ACBr).
2. **Envelope SOAP 1.2 mínimo na família.** (a) `ACBrDFeWebService.pas:170-176`, `:318-347`; sem Header na 4.00
   `ACBrNFeWebServices.pas:692-693`; Content-Type `ACBrDFeSSL.pas:1410-1411`; SOAPAction em header
   `ACBrDFeHttpOpenSSL.pas:160-161`. (b) NE-3. (c) Confirma Q-NE5 (a): envelope é texto trivial na nfe-api; o núcleo só dá
   transporte cru + `ca`. (d) WSDL de cada serviço: `action=` no Content-Type (SOAP 1.2) × header `SOAPAction`; namespace
   do `nfeDadosMsg`; ações próprias da BA (INI `:1274-1280`).
3. **Resposta, Fault e HTTP ≠ 200 classificados — nunca "exceção com corpo".** (a) `ACBrDFeSSL.pas:1071-1081`;
   `ACBrDFeWebService.pas:606-613`; extração textual `..\ACBrComum\ACBrUtil.XMLHTML.pas:398-464`. (b) NE-1 (classificação) e
   NE-3 (parser XML de verdade). (c) Refina Q-NE5/Q-NE13 — **questão nova sugerida Q-NE-S1**: SOAP Fault/HTTP 500 de
   validação de schema é recusa (R) ou ambíguo? Regra do núcleo: 2xx ilegível = ambíguo. (d) MOC: mensagens de erro de
   schema (215/225 etc.) e formato de Fault por autorizadora.
4. **Verificar a cadeia do servidor (conhecimento NEGATIVO do ACBr).** (a) P-01; núcleo sem `ca` e classificando falha de
   cadeia como credencial (`https-json.ts:104-109`, `:124-128`). (b) NE-1. (c) Confirma Q-NE17 (a); nunca
   `rejectUnauthorized:false`. (d) cadeias ICP-Brasil vigentes e certificados de servidor de cada autorizadora (algumas usam
   AC comercial).
5. **1 NF-e por lote, `indSinc=1`, e 103/105 como voz P (em voo).** (a) NFC-e já é 1/síncrona `ACBrNFeWebServices.pas:1007-1016`;
   lote de 50 com resultado parcial `:1734-1767`; desvio 103 morto P-02. (b) NE-3/NE-5. (c) Refina Q-NE13/Q-NE14 —
   **Q-NE-S2**: adotar 1 nota por lote e síncrono sempre; 103 → P + consulta do recibo; 105 → P. (d) MOC: UFs que não
   processam síncrono no 55; retenção do recibo; `tMed`.
6. **Denegação como voz D final, com o `nfeProc` guardado.** (a) P-04. (b) NE-1 (vocabulário) e NE-5. (c) Confirma
   Q-NE14 (a) e acrescenta **Q-NE-S3**: guardar o XML da denegada (o ACBr não guarda). (d) MOC: 110/301/302/303 (e o
   "denegada" na consulta) e obrigação de guarda.
7. **Resposta conferida contra a pergunta (chave E digest), inclusive no síncrono.** (a) `ACBrNFeWebServices.pas:1244-1251`,
   `:1664-1672`, `:2434-2440`; P-03, P-27; aspas da SEFAZ-PR `:2482-2485`. (b) NE-3/NE-5. (c) Generaliza o R2-2 da
   nfse-api (`nfse-api/src/authority/adn.ts:138-147`) — Q-NE13. (d) MOC: `protNFe/infProt` (chNFe, digVal, nProt,
   dhRecbto) e `retConsSitNFe` com eventos; não copiar bytes do `protNFe` sem parser (variação de aspas).
8. **Duplicidade e reenvio resolvidos pela consulta da chave.** (a) P-10; extratores sem chamador `ACBrDFeUtil.pas:1171-1259`.
   (b) NE-5. (c) Refina Q-NE7 (a): reenviar a MESMA chave após ambíguo e receber 204 → pousar A pela consulta (fonte Q);
   nova chave só com a anterior resolvida — **Q-NE-S4**: tratamento do 539 (mesmo número, chave diferente). (d) MOC:
   textos/campos do 204 e 539 (se trazem chave/protocolo/recibo).
9. **Rotear consulta/evento/recibo pela TENTATIVA, nunca por configuração global.** (a) P-09; `ACBrNFe\ACBrNFe.pas:517-523`.
   (b) NE-2 (gravar autorizador e `tpEmis` na tentativa) e NE-3. (c) Q-NE6 (a) mantém SVC fora da F4; **Q-NE-S5**: a
   tentativa grava autorizador/`tpEmis` usados e toda pergunta posterior vai a ele. (d) NT de SVC: serviços oferecidos
   (o INI não tem inutilização 4.00 em `NFe_SVC-RS_H` — `:639-650`).
10. **Inutilização: sempre na UF, justificativa ≥ 15, proc = pedido assinado + retorno.** (a) `ACBrNFeWebServices.pas:2639-2654`,
    `:2672-2698`, `:2741-2813`, `:4344-4364`; P-16. (b) NE-2 (faixa no `fiscal_api`) e NE-3. (c) Confirma Q-NE8 (a) —
    **Q-NE-S6**: o 563 vira qual voz? (d) MOC: leiaute `inutNFe` (ano, série, faixa), cStat 102/563, prazo.
11. **Cancelamento 110111: protocolo por consulta, 1 evento por lote, `dhEvento` pela zona.** (a) `ACBrNFe\ACBrNFe.pas:797-830`,
    `:928-999`; `ACBrNFeWebServices.pas:3216-3834`; P-06/P-07. (b) NE-3/NE-5. (c) Q-NE7/Q-NE13 — **Q-NE-S7**: sempre 1
    evento por lote (evita P-06); sucesso do lote 128 não basta, decide o cStat do evento. (d) MOC: prazos por UF
    (Q-NE26), 135/136/155, duplicidade de evento.
12. **Smoke H parcial sem IE: status e consulta cadastro.** (a) `consStatServ` só tpAmb+cUF `ACBrNFeWebServices.pas:849-862`;
    `ConsCad` por CNPJ `:2964-2987`. (b) NE-3. (c) Confirma Q-NE18 (c). (d) se a autorizadora exige IE do certificado nesses
    serviços; inutilização sem IE.
13. **Rodízio respeitando `tMed`, intervalo mínimo e 656.** (a) `ACBrNFeWebServices.pas:900-903`, `:1480-1505`;
    `ACBrDFeConfiguracoes.pas:777-780`, `:895-898`; 656 sem tratamento. (b) NE-5. (c) Refina Q-NE26 (a). (d) MOC: regra do
    656 (janela e limite por UF).
14. **`dhEmi`, AAMM da chave e `dhEvento` do MESMO instante na zona do estabelecimento — nada global.** (a) P-12, P-13;
    `ACBrDFeUtil.pas:216`. (b) NE-4 (builder); NE-1 já tem `nowIsoIn`. (c) Q-NE21 (b). (d) formato TZD e tolerância
    `dhEmi` × recebimento.
15. **Validar XSD antes e fixar a versão de cada mensagem no adaptador.** (a) `ACBrNFeNotasFiscais.pas:390-436`;
    `ACBrNFeWebServices.pas:3677-3733`; P-15. (b) NE-3/NE-4. (c) Confirma Q-NE16 e acrescenta: versão = constante do
    adaptador, nunca derivada da pasta. (d) pacote PL vigente (inclusive RTC) e versão de cada mensagem.
16. **Timeout é AMBÍGUO; limites por serviço.** (a) ACBr 5 s `ACBrDFeConfiguracoes.pas:782`; P-11; núcleo 30 s e `timeout`
    → 503 (`https-json.ts:38`, `:86`, `:189-191`). (b) NE-1/NE-3. (c) Q-NE13 — **Q-NE-S8**: timeout por serviço
    (autorização síncrona × status). (d) MOC: orientação de reconsulta.
17. **Limites locais baratos antes do envio.** (a) 50 notas/1 NFC-e/500 KB/20 eventos `ACBrNFeWebServices.pas:1009-1022`,
    `:1167-1170`; `ACBrNFe\ACBrNFe.pas:936-938`. (b) NE-3. (c) —. (d) limites oficiais de tamanho e quantidade.
18. **Nomes de arquivo da NF-e.** (a) §5.3 (`-nfe.xml`, `-procEventoNFe.xml`, `-procInutNFe.xml`); nfse-api usa
    `-dps.xml`/`-nfse.xml`/`-evt101101.xml` (`nfse-api/src/nfse/transmission.ts:75-77`). (b) NE-2/NE-5. (c) **Q-NE-S9**:
    convenção de nomes dentro de `<cnpj>/<H>/<ano>/<mês>`. (d) não é oficial — conferir só a obrigação de guarda dos procs.
19. **Fora da F4, mas registrado.** (a) DistDFe `:3968-4204`, CSC `:3865-3966`, EPEC `:3118-3132`, gzip `:1115-1125`,
    eventos RTC na SVRS `:3151-3160`. (b) F5 / fase IBS-CBS. (c) Q-NE2 (a), Q-NE6 (a), Q-NE25, Q-NE4. (d) NT 2023/002,
    NTs de EPEC e NT 2025/002.
20. **Segredo em configuração do legado.** (a) P-20. (b) NE-6. (c) Reforça Q-NE24 (a). (d) —.

---

## 9. Confiança e lacunas

- **Alta**: fluxo de transporte, envelope, resolução de URL, cStat tratados e arquivos — unidades centrais lidas inteiras.
- **Média**: TLS (só o caminho OpenSSL lido inteiro; WinHttp não lido), fuso (funções lidas; o ponto de entrada do
  gancho `OnAjustarDataHoraParaUf` no legado não foi procurado).
- **Não lido (⚠️)**: leitores de retorno (`ACBrNFe.RetConsSit`, `ACBrNFe.RetEnvEvento`, `ACBrNFe.RetInut`,
  `pcnRetConsReciDFe`, `ACBrDFeComum.RetEnvio/RetDistDFeInt/RetConsCad`) — como interpretam `dhRecbto` com fuso e recortam
  `XMLprotNFe`; `pcnProcNFe` (forma exata do `nfeProc`); formação do Id do evento (`ACBrNFe.EnvEvento`); download do PFX
  por URL; descompactação do `docZip`.
- **Comportamento da SEFAZ afirmado só em comentário** (não é fato do código): apóstrofos na SEFAZ-PR (`:2482-2485`),
  horário de verão na SVRS (`:885-887`), BA com nomes próprios na 3.10 (`:823`).
- **URLs do INI** não foram conferidas contra o oficial — só a estrutura e as seções-chave.
- **Legado Gestao2016 (fora desta frente, só ponteiros)**: tela de configuração `D:\Gestao2016\Ajuda\un_geranfe_Srv.dfm:1636-1651`
  (`SSLLib`/`SSLHttpLib` none, `AguardarConsultaRet` 0), `Registro.Sincrono := 'S'` em `D:\Gestao2016\Ajuda\un_geranfe_Srv.pas:1303`
  e seguintes, campo `FTentativasChaveDuplicada` em `D:\Gestao2016\Ajuda\un_geranfe3X.pas:77` (uso não localizado) — a
  política real de duplicidade do legado deve ser fotografada pela frente do legado.
- Nenhuma pergunta ao Valdo nesta frente: tudo que restou é FATO a conferir no oficial (coluna (d) do §8).
