# NFS-e Nacional — pacote da PRODUÇÃO RESTRITA de 20/10/2026 (NT 009) × pacote de PRODUÇÃO de 09/02/2026

**Escopo**: misto (a leitura do contrato nacional é portável; as consequências para o montador da `nfse-api` e para a Setes são caso `setes`)
**Levantado em**: 2026-11-01, sessão filha da IB-4 (`../../../../prompts/prompt_fase_ibs_cbs.md` §13.8, fim, e §15). Download autorizado pelo Valdo
no mesmo dia. Fonte: página oficial "Documentação Técnica (Homologação/testes)" — https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/producao-restrita
(o gov.br responde 403 sem User-Agent de navegador + Referer; o HEAD dá 403 sempre).
**Ferramentas da comparação** (no scratchpad da sessão, não versionadas): diferença ESTRUTURAL dos tipos nomeados (sequência, ocorrência, tipo,
facetas) e diferença das abas de regras de negócio pelo código do erro.

## Arquivos

| Arquivo | O quê | Bytes | SHA-256 |
|---|---|---|---|
| `esquemas_prod_restrita_20261020.zip` (+ `xsd/`, extraído) | XSD da produção restrita, 20/10/2026 | 36.351 | `25fdcecc651a67a216496ab10d7566631e6ed10f721e37d62c7845dadb0ea267` |
| `anexo_i-sefin_adn-dps_nfse-snnfse_prodrest-v1-01-20261020.xlsx` | Anexo I PRODREST — leiaute DPS/NFS-e + regras de negócio (abas novas: `CÓDIGO_INDICADOR_OPERAÇÃO`, `AJUSTE_BC_REPERCUSSÃO`) | 248.110 | `72b05981c8882cdd807f3acf901b669465360f9cf1b9d9e235ac4363dacfb2d8` |
| `anexo_ii-sefin_adn-pedregevt_evt-snnfse_prodrest-v1-01-20261020.xlsx` | Anexo II PRODREST — pedido de registro de evento / eventos (aba nova: `RN_RECEP_PED.REG.EVENTO`) | 56.517 | `6e0660d18def5dc674923f0e2f3731ada5bdbfac966f1dc615c090104d28688d` |

XSD que MUDARAM em relação a `../xsd/Schemas/1.01/` (os demais são idênticos byte a byte — `DPS`, `NFSe`, `evento`, `pedRegEvento`, `tiposEventos`, `CNC`):
`tiposComplexos_v1.01.xsd` (`4f66f7c1…`), `tiposSimples_v1.01.xsd` (`562e3267…`), `xmldsig-core-schema.xsd` (`8c9792a0…` — só tirou o DOCTYPE).

## ⚠️ O fato que decide o desenho: a VERSÃO não mudou

O pacote novo continua `versao="1.01"` (`TVerNFSe` idêntico; `DPS_v1.01.xsd` idêntico). **Dois leiautes incompatíveis com o MESMO número de
versão**: o DPS que passa em H é recusado pelo esquema em P (e o inverso — prova: nota 8014, E1235 em H, 2026-11-01). Logo o calendário de leiaute
(`nfse-api/src/authority/layout-calendar.ts`, D-IB81) **não pode distinguir os leiautes pela string da versão** — ele precisa nomear o PACOTE
(leiaute) e, separado, a versão do atributo.

## Mudanças que tocam o DPS que a nfse-api monta (`dps-builder.ts`)

| # | Tipo | Produção (09/02) | Produção restrita (20/10) | Efeito no nosso DPS |
|---|---|---|---|---|
| M1 | `TCInfDPS` | `tpEmit → cMotivoEmisTI? → chNFSeRej? → cLocEmi` | `tpEmit → cMotivoEmisTI? → **finNFSe** → chNFSeRej? → cLocEmi` (`finNFSe` OBRIGATÓRIO, `TSRTCFinNFSe` = só "0") | TODO DPS (com ou sem IBS/CBS) leva `<finNFSe>0</finNFSe>` antes do `cLocEmi` — causa do E1235 da 8014 |
| M2 | `TCCServ` | `cTribNac, cTribMun?, xDescServ, cNBS?, cIntContrib?` | `cTribNac, cTribMun?, cNBS?, cIntContrib?, **xDescServ**` | `xDescServ` passa para DEPOIS do `cNBS` (só muda a ordem quando há NBS; sem NBS o XML sai igual) |
| M3 | `TCRTCInfoIBSCBS` | `finNFSe, indFinal?, cIndOp, tpOper?, gRefNFSe?, tpEnteGov?, indDest, dest?, imovel?, valores` | `indFinal?, cIndOp?, tpOper?, gRefNFSe?, tpEnteGov?, indDest, dest?, imovel?, bensMoveis[0..1000], valores` | o grupo PERDE o `finNFSe` (foi para o `infDPS`); `cIndOp` vira opcional (a regra decide — E0859/E0860) |
| M4 | `TCRTCInfoValoresIBSCBS`/`trib` | `valores{gReeRepRes?, trib{gIBSCBS{CST, cClassTrib, cCredPres?, gTribRegular?, gDif?}}}` | `valores{trib{CST, cClassTrib, gIBSCBS?{cCredPres?, gTribRegular?, gDif?}}}` | `CST`/`cClassTrib` SOBEM para `trib`; `gIBSCBS` fica só com opcionais (ver E0960 abaixo) |

Mudanças estruturais SEM efeito no que montamos hoje (não emitimos esses grupos): `TCInfoValores.vDedRed` → `vAjusteBC` (`TCInfoAjusteBC`, `TCDocAjusteBC`
— "ajuste de BC" unifica dedução/redução e reembolso/repasse); `TCRTCInfoImovel` reestruturado (`cMun`, `gLocacao?`, `gUnidImob[0..99]`); grupo
`bensMoveis` (locação de bens móveis, `cTribNac` 99.04.01, `TSNCM`); `TCInfoPessoa.xNome` passa a opcional (E0225: o tomador-emitente não informa).

## Tipos simples (Ids, chave, CNPJ, série, textos)

| Tipo | Mudança | Nosso caso |
|---|---|---|
| `TSCNPJ` | `[0-9]{14}` → `[0-9A-Z]{14}` (CNPJ alfanumérico) | nada (frente do CNPJ alfanumérico — `prompt_frente_cnpj_alfanumerico.md`) |
| `TSIdDPS` | `DPS[0-9]{42}` → `DPS[0-9]{7}(1[0-9]{14}\|2[0-9A-Z]{14})[0-9]{20}` | o nosso Id numérico cabe nos dois |
| `TSChaveNFSe`, `TSIdNFSe`, `TSIdPedRegEvt`, `TSIdEvento`, `TSIdNumEvento`, `TSChaveNFe` | letras só nas 14 posições da inscrição | o Id `PRE…` do cancelamento cabe nos dois |
| `TSSerieDPS` | `^0{0,4}\d{1,5}$` → `[0-9]{1,4}\|[0-8][0-9]{4}` (até 89999) | série sem zero à esquerda (900) cabe nos dois |
| `TSDesc*` (40…2000, `TSDescInfCompl`) | ganham `pattern [\s\S]*[^\s][\s\S]*` (pelo menos um caractere não branco) | o montador apara e omite o vazio; `xDescServ` cai em "Serviços" |
| `TSDateTimeUTC` | correção da regex (`[0,13-9]` → `[013-9]`) | nada |
| novos | `TSNCM`, `TSRTCTpAjusteBC`, `TSAjusteBCLocImoveis` | não usados |
| removidos | `TSIdeDedRed`, `TSRTCTpReeRepRes` | não usados |

## A NFS-e DEVOLVIDA (o que lemos — `parseNfseIbscbs`, `parseNfseDeclaration`, DANFSe)

- **Grupo do fisco `infNFSe/IBSCBS` (`TCRTCIBSCBS`)**: `cLocalidadeIncid`, `xLocalidadeIncid` e `valores` passam a OPCIONAIS; em `totCIBS` (`TCRTCTotalCIBS`)
  `gIBS` e `gCBS` passam a OPCIONAIS — **o fisco só os preenche quando o cClassTrib indica tributação (`ind_gIBSCBS = 1`)**: E1518/E1524/E1526/E1562/E1573
  proíbem com indicador 0, E1563 (e par da CBS) exige com 1. Hoje `parseNfseIbscbs` é tudo-ou-nada com `vTotNF`+`vIBSTot`+`vCBS` → uma NFS-e legítima
  sem IBS/CBS calculado (CST 410 etc.) sairia `unreadable` + alarme a cada passada (D-IB80/D-IB97).
- **Declaração embutida (`infNFSe/DPS/infDPS/IBSCBS`)**: no leiaute novo o CST/cClassTrib estão em `valores/trib/`, não em `valores/trib/gIBSCBS/` →
  `parseNfseDeclaration` (tela "No fisco" e DANFSe) devolveria `null` para todo DPS do leiaute novo. Os XML dos DOIS leiautes convivem no arquivo
  fiscal para sempre.
- `TCValoresNFSe.vCalcDR` → `vCalcAjusteBCISSQN` (não lemos).

## Eventos (cancelamento `e101101`)

`tiposEventos_v1.01.xsd`, `evento_v1.01.xsd` e `pedRegEvento_v1.01.xsd` IDÊNTICOS; o pedido de cancelamento não muda (só os padrões de Id aceitam
letras na inscrição). Anexo II: leiaute igual (corrige só um caminho `e202201`); regras = RENUMERAÇÃO dos erros de assinatura (E1980…E1991 →
E0714…E0718; E2020… → E1630…E1638) + bloqueios municipais de evento (E0820, E0844, E0846, E0854, E0857, E1964); aba nova com as regras de
recepção (certificado de transmissão, base64, namespace, UTF-8, E1235). **O montador do evento não muda**; a linha `EVENT` do calendário pode
seguir em 1.01 nos dois ambientes.

## Regras de negócio novas ou mudadas que tocam o nosso DPS (Anexo I, aba `RN DPS_NFS-e 1.01`)

| Código | Regra (resumo) | Peso para a Setes |
|---|---|---|
| **E0855** (nova, nível 1, executada na recepção do prestador) | "É obrigatório declarar informações de IBS/CBS quando a data de competência for igual ou posterior a 01/10/2026" — **sem exceção para o Simples no texto da regra** (a nota do leiaute do grupo diz "para optantes do Simples Nacional, os grupos IBSCBS só serão obrigatórios a partir de 2027") | em H, todo DPS SEM o grupo com `dCompet` ≥ 01/10/2026 tende a recusar (a 8015 "só NBS" é o teste); se P migrar com a mesma regra, NFS-e sem classificação é recusada no dia da virada — a OBRIGAÇÃO é do ERP (IB-2), não da nfse-api |
| **E0960 / E0961** | `gIBSCBS` obrigatório com `ind_gIBSCBS = 1` / proibido com 0 ("conforme consulta à calculadora") | CST 000 (cClassTrib 000001 da Setes) tem `ind_gIBSCBS = 1` (IT 2025.002 v1.70, aba CST) — e no leiaute novo o `gIBSCBS` só tem filhos opcionais, nenhum aplicável ao 000001 (`ind_gTribRegular`/`ind_gCredPresOper`/`ind_gDif` = 0) → **a regra pede o grupo VAZIO `<gIBSCBS/>`?** Não conferido — prova em H |
| **E0859 / E0860** | `cIndOp` proibido com `ind_gIBSCBS = 0` / obrigatório com 1 | hoje o montador SEMPRE emite `cIndOp` — um cClassTrib de CST com indicador 0 (ex.: 410 imunidade) seria recusado |
| E0234 (REMOVIDA) → **E0239/E0241/E0243** | endereço do tomador obrigatório quando o `cIndOp` aponta o município do tomador/destinatário e há tributação (`ind_IBSCBS = 1`) | o cinto local `assertIbscbsGroupDeliverable` (lista do antigo E0234) continua conservador nos dois leiautes |
| E0233 (mudou) | `xNome` obrigatório se CNPJ/CPF/NIF (antes só NIF) | já emitimos sempre |
| E0313 / E0314 | `cTribMun` proibido para MEI; `cTribMun` precisa existir no município de incidência (antes "exceto MEI") | Setes não manda `cTribMun` |
| E0312 (igual, nível 3 — parametrização municipal) | `cTribNac` administrado pelo município de incidência | é a recusa que integradores relataram DEPOIS de passar o esquema — depende da parametrização de H do município deles, não do leiaute |
| E0903, E0322 | iguais (tpOper p/ 25.05/15.09/17.12/10.05; grupo exige NBS) | iguais |

`RN_RECEP_DPS` (recepção) idêntica. `E1260` só mudou o texto ("prazo de aceitação da versão do leiaute do DF-e").

## Conhecimento negativo (o que NÃO se lê destes documentos)

1. **O Anexo I PRODREST imprime o caminho do `finNFSe` errado** (linha 111 da aba de leiaute: `NFSe/infNFSe/DPS/infDPS/IBSCBS/finNFSe`, na posição
   do `infDPS`) — **o XSD vale**: `infDPS/finNFSe`. O domínio na planilha (0/1/2) também está à frente do XSD (só "0").
2. A MENSAGEM do E0960 diz "quando NÃO houver indicação" — a REGRA diz "quando houver (`ind_gIBSCBS = 1`)". Vale a regra.
3. **A NT 009 entrou PARCIAL em H**: o pacote de 20/10 não tem o `regApIBSCBSSN` do prestador (nt009.txt §2.x, campos do Simples) nem o
   `gIBSCBSAjuste`/`tpNFSeDebito`/`tpNFSeCredito` no XSD. "Leiaute da NT 009" ≠ "pacote de H de 20/10": o calendário nomeia o PACOTE.
4. O indicador `ind_gIBSCBS` que as regras E0855/E0859/E0860/E0960/E0961 citam é do **CST** (IT 2025.002, aba CST — coluna `ind_gIBSCBS`); a
   aba `cClass` do IT 1.70 não o repete. A "consulta à calculadora" que o Anexo cita aponta para um endereço interno do SERPRO (`…estaleiro.serpro…`),
   não público.
5. A página de PRODUÇÃO segue com o pacote de 09/02/2026 e **não há data publicada para P adotar o de 20/10** (conferido 2026-11-01).

## O que só a prova em H confirma (IB-4 — com "vai")

- 8014 (classificada 000001/100301 + NBS) no leiaute novo: passa o esquema? `gIBSCBS` vazio × ausente (E0960)?
- 8015 (só NBS, sem grupo): **E0855** em H com competência ≥ 01/10/2026 (esperado) — ou a nota do leiaute (Simples só em 2027) prevalece?
- O grupo do fisco devolvido com `gIBS`/`gCBS` para o 000001 (E1563).
