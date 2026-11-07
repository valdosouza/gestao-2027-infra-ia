# fiscal-api/processo — componentes: o que o ACBr entrega pronto no legado e o que a web precisa construir

**Escopo**: método (inventário de componentes e esforço; nada de cliente, credencial nem código de produto)
**Criado em**: 07/11/2026, por observação do Valdo: "parte do processo está componentizado no ACBr, enquanto na web teremos mais trabalho para criar os componentes similares ao ACBr".
**Companheiros**: [`INDEX.md`](INDEX.md) (o mapa do processo), `NFE.md` e `NFSE.md` (etapa por etapa), [`../../nfe-api/referencia-acbr/00-INDEX.md`](../../nfe-api/referencia-acbr/00-INDEX.md) (a leitura do ACBr que a web já fez: 6 relatórios e 198 cartões de regra).

## 1. A assimetria

| | ERP Desktop (legado) | Web |
|---|---|---|
| Quem faz o XML, a assinatura, o transporte, a validação e o DANFE | **ACBr** (componente de terceiro, LGPL 2.1, trunk2 r48887); o Gestão em Delphi só calcula os valores e preenche os componentes | **Código próprio componentizado**: núcleo `fiscal-api` (biblioteca) + `nfse-api` + `nfe-api` |
| Tamanho do que se recebe pronto ou se constrói | NF-e: cerca de **98 mil linhas** de ACBrNFe e ACBrDFe lidas como referência; NFS-e: **438 arquivos de provedores** em ACBrNFSeX (em geral 3 por provedor: `GravarXml`, `LerXml`, `Provider`, ≈ 146 provedores), mais o Padrão Nacional | `fiscal-api` 6.556 linhas de TypeScript (sem testes), `nfse-api` 3.582 (`authority` 1.391 + `nfse` 2.191), `nfe-api` **498** |
| Estado | NF-e e NFS-e em produção nos clientes | **NFS-e Padrão Nacional em produção** desde 29/09/2026; **NF-e ainda sem emissão** (só acervo, o esqueleto do emitente, o controle de numeração e inutilização e a família da voz) |

Os números de linhas servem só para dar a **ordem de grandeza da referência**, não para comparar produtividade: as duas bases têm linguagens e abstrações diferentes.

**Regra de reaproveitamento do ACBr pela web:** o ACBr é **referência de comportamento**, nunca fonte oficial nem código a copiar (LGPL 2.1; o oficial manda: MOC, NT, XSD, WSDL — D-NE19). A web já extraiu o que precisa em `nfe-api/referencia-acbr/`; quem for construir um componente lê o relatório correspondente e **confere no oficial**.

## 2. Inventário de componentes

**Esforço (só para ordenar, não é prazo):** **P** pequeno, reusa o núcleo, cerca de 1 sessão · **M** médio, 2 a 4 sessões · **G** grande, 5 ou mais sessões ou depende de decisão. A "sessão" é a da escala dos planos da web (cerca de 4 h com testes verdes, ±40%). **Web hoje:** **I** existe e funciona (NFS-e) · **P** parcial ou só dado arquivado · **plano** planejado sem código · **—** não existe.

### NF-e e NFC-e

| ID | Componente | No ACBr (legado) | Web hoje | O que a web precisa construir | Esforço | Conhecimento já levantado |
|---|---|---|---|---|---|---|
| C-01 | **Gerador do XML** (modelo → XML por grupo, formatação decimal por campo, o que o writer calcula ou deriva) | `ACBrNFe.XmlWriter` (4.926 l.) + `Classes` (5.965 l.): 19 grupos gerados, ~750 campos (+111 de IBS/CBS), 21 variantes de ICMS | plano (builder da NE-3) | Builder completo da NF-e 4.00 e dos grupos RTC | **G** | relatório 02; NTs e XSD do acervo |
| C-02 | **Leitor do XML** (procNFe, protocolo, XML de compra) | `XmlReader` e unidades do PCN | P (`@xmldom/xmldom` no núcleo, usado na NFS-e) | Leitor de NF-e e de `procNFe` | **M** | relatórios 02 e 06 |
| C-03 | **Chave de acesso, numeração, série, cDV** | `ACBrDFeUtil` | P (`number-void.ts` e controle de numeração na `nfe-api`; `access-key.ts` na NFS-e) | Fechar numeração por estabelecimento e modelo | **P** | relatório 02 §3.12; MOC 2.2.6 e 2.2.8 |
| C-04 | **Assinatura XMLDSig** (NF-e: RSA-SHA1, C14N; eventos; inutilização) | `ACBrDFeSSL`, `ACBrDFeOpenSSL` (2.005 + 476 l.) | I (`xml-crypto` + `node-forge` no núcleo, `xmldsig` paramétrico) | Parametrizar para NF-e, eventos e inutilização | **P** | prompt da NF-e §3.8; relatório 02 |
| C-05 | **Certificado** (A1 em PFX; A3) | `ACBrDFeOpenSSL`, bibliotecas CAPICOM, WinCrypt, CNG | I para A1 (cofre); A3 — | A1 já serve; A3 não está no plano | **P** (A1) | prompt da NF-e §3.8 |
| C-06 | **Validação XSD local** | libxml2 do ACBr, pacotes em `Schemas` | **— (o núcleo não tem biblioteca de validação XSD)**; plano: camadas PL_009_V4, PL_010d, PL_010f | Escolher e integrar um validador de XSD (biblioteca nativa ou WASM) | **M** | D-NE102 a D-NE114; acervo `schemas/` |
| C-07 | **Transporte SOAP 1.2 com TLS** (PFX no socket, timeout, proxy, fuso) | `ACBrDFeWebService`, `ACBrDFeHttpOpenSSL` (640 + 255 l.) | plano (`adapters/sefaz.ts`); a NFS-e usa REST com mTLS, mais simples | Cliente SOAP, envelope, TLS, fuso | **M** | relatório 01 §3.5 e §2.3 |
| C-08 | **Tabela de autorizadores e URLs** | `ACBrNFeServicos.ini` (1.280 l.: 127 seções, 72 redirecionamentos, 307 URLs) | P (JSON de autorizadores de 15/10/2026 no acervo; constante datada planejada) | Tabela versionada no código, por UF, ambiente e modelo | **P** | relatório 01 §3.2 a §3.4; `AUTORIZADORES.md` |
| C-09 | **Serviços da SEFAZ** (status, autorização, retorno, consulta, cadastro, eventos, CSC, DistDFe, envio genérico) | `ACBrNFeWebServices` (4.366 l.): 11 classes | plano | Os 8 serviços do MOC 5.1 a 5.8 | **G** | relatório 01; MOC cap. 5 |
| C-10 | **Máquina de envio** (lote e recibo, tentativas, duplicidade, reenvio após timeout, 21 cStat) | `TNFeRecepcao`, `TNFeRetRecepcao` | P (o núcleo já tem a voz do fisco e as tentativas, na família da NFS-e; a família da NF-e está no esqueleto) | Estados do 103/105 (recibo), tratamento dos cStat | **M** | relatório 01 §4.1, §4.2 e §4.8 |
| C-11 | **Eventos da NF-e** (cancelamento e substituição, CC-e, manifestação, EPEC, ator interessado, prorrogação, 15 eventos RTC) | `TNFeEnvEvento`, `EventoClass` (11 mensagens) | P (o cancelamento da NFS-e é reaproveitável); NF-e fora da F4 | Um construtor por evento; o cancelamento primeiro | **M** (cada), **G** (total) | relatório 05; MOC cap. 3 e 5.8 a 5.14 |
| C-12 | **Inutilização** | `TNFeInutilizacao` | P (`number-void.ts`) | Serviço e evento | **P** | relatório 05; MOC 5.3 |
| C-13 | **Contingência** (SVC-AN, SVC-RS, EPEC, FS-DA, off-line da NFC-e) | ACBr (modalidades de emissão) | — (fora da F4) | Entrada e saída de contingência, EPEC | **G** | MOC Anexo III e 3.3 |
| C-14 | **DANFE** (A4, simplificado, NFC-e; bloco de IBS/CBS) | DANFE em FPDF A4 (18 blocos) e o do Fortes usado no Gestão | P (`pdfkit` e `bwip-js` no núcleo, usados no DANFSe; DANFE planejado) | Renderizador de DANFE | **G** | relatório 05 §3.2; MOC Anexo II; NT 2026.010 |
| C-15 | **QR-Code e CSC da NFC-e** | `TAdministrarCSCNFCe` | — (NFC-e é onda própria) | CSC, QR-Code, serviço de CSC | **M** | relatório 01 §4.7 |
| C-16 | **Validação local de regras** (pré-SEFAZ) | `ACBrNFe.ValidarRegrasdeNegocio` (1.333 l.): 198 regras; **nenhuma de IBS/CBS** | plano (pré-validação em 3 camadas, Q-NE43) | Camada de regras; as de IBS/CBS vêm do catálogo `../regras/` | **M** | relatório 04 (JSON de 198 cartões) |
| C-17 | **Distribuição DF-e e importação de XML** | `TDistribuicaoDFe` | — (fora da F4) | NSU, download, importação | **M** | relatório 01 §4.7; MOC 5.7 |
| C-18 | **E-mail após a autorização** | fachada de e-mail do ACBr | — (fora da F4) | Envio do XML e do PDF | **P** | relatório 05 §2.3 |

### O que **não** é do ACBr (é regra do produto, nos dois lados)

| ID | Componente | Legado | Web hoje | Esforço |
|---|---|---|---|---|
| C-19 | **Tributação do item** (ICMS, ST, DIFAL, FCP, IPI, PIS, COFINS; CFOP, CST, CSOSN; regra de tributação por item) | Gestão em Delphi (`tributacao.pas` e regras de tributação) | **— (pré-requisito de qualquer NF-e na web, D-E17)** | **G** |
| C-20 | **IBS/CBS**: cálculo, classificação e preenchimento do grupo | Gestão (motor próprio) + o grupo `gIBSCBS` do ACBr | Calculadora oficial atrás de uma porta (D-IB11) + montador; só a NFS-e | **M** |
| C-21 | Pedido → nota, numeração por estabelecimento, guarda do XML, SPED | Gestão | parte no núcleo | **M** |

C-19 é onde o **conhecimento do legado** mais vale para a web: o ACBr não ajuda, e a web não tem nada. Os vetores e o catálogo de regras são o caminho para levá-lo.

### NFS-e

| ID | Componente | No ACBr (legado) | Web hoje | Esforço |
|---|---|---|---|---|
| N-01 | XML da DPS do Padrão Nacional | `ACBrNFSeX` `PadraoNacional.GravarXml` | **I** (`dps-builder.ts`, 541 l.) | — |
| N-02 | Assinatura | `ACBrDFeSSL` | **I** (`xmldsig` no núcleo) | — |
| N-03 | Cliente da Sefin Nacional e do ADN (REST com mTLS) | `PadraoNacional.Provider` | **I** (`adn.ts`, `transmission.ts`) | — |
| N-04 | Eventos (cancelamento, substituição) | provedor do Padrão Nacional | **I** para o cancelamento (provado em H); substituição **?** | **P** (substituição) |
| N-05 | DANFSe | DANFSe do ACBr | **I** (`danfse.ts`, `pdfkit`); conferir a NT 008 v1.02 | **P** |
| N-06 | Calendário de leiaute por ambiente | configuração `ProVersaoNT` e `HomVersaoNT` fixas | **I** (`layout-calendar.ts`) | — |
| N-07 | **Provedores municipais** (ABRASF, IPM, ISSNet, Curitiba etc.) | ≈ 146 provedores em ACBrNFSeX | **— nenhum** (só o Padrão Nacional) | **G** por provedor ou família; **depende da decisão de escopo** |

N-07 define o escopo: a LC 214 (art. 62) mantém os municípios com emissor próprio até 2032, mas o ME/EPP do Simples emite pelo ambiente nacional desde 01/11/2026 (RF-SN-12). Se a web só atender o Padrão Nacional, o legado continua tendo uma vantagem real (os provedores municipais) até a migração.

## 3. Riscos que o inventário mostra

1. **No legado, a atualização do ACBr é o gargalo.** O ACBr instalado não tem os campos do Simples da NT 2026.005 nem os da NT 009 (nenhuma ocorrência de `tpRegimeIBSCBS`, `cAtivSN`, `gTribSN`, `gIBSSN`, `regApIBSCBSSN`, `vReceitaBrutaSN`) e não tem o grupo `vAjusteBC` na NFS-e.
2. **No legado ninguém confere a conta de IBS/CBS antes da SEFAZ**: o validador local do ACBr tem 0 menções a IBS/CBS; os vetores e as regras `RF-*` cobrem isso.
3. **Na web, o núcleo não tem validador de XSD** (C-06), e a validação em camadas está só no plano.
4. **Na web, não há nenhum provedor municipal** (N-07).
5. **O maior trabalho da web na NF-e está em C-01, C-09, C-13, C-14 e C-19** (G): gerador de XML, serviços da SEFAZ, contingência, DANFE e a tributação do item.

## 4. Como isto entra no planejamento (próximo passo, com o Valdo)

- **Legado primeiro:** o ACBr já entrega C-01 a C-18; o trabalho é o do Gestão (C-19 a C-21), o que depende de versões do ACBr (riscos 1 e 2) e a NFS-e do Simples (N-01 a N-06 via ACBr). O mapa por etapa (`NFE.md`, `NFSE.md`) mostra onde.
- **Web depois, reaproveitando:** norma, regras, vetores e calendário são os mesmos; o que a web constrói é a coluna "Web hoje" desta tabela, na ordem que o planejamento definir. Os componentes **P** são os primeiros candidatos; **G** precisam de decisão de escopo.
