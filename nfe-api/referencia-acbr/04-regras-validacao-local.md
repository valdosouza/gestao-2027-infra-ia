# ACBr NF-e — Regras de validação local (pré-SEFAZ)
**Escopo**: setes
**Natureza**: referência de TERCEIRO — ACBr (LGPL 2.1), motor da NF-e no legado Gestao2016; nunca substitui o oficial (MOC — Regras de Validação)
**Fonte**: D:\Componentes\acbr\Fontes\ACBrDFe\ (change-log 19/08/2026) · leitura de 2026-10-10
**Agente**: business-rules-extractor (plugin code-modernization) no método assess-legacy-repo
**Dado**: 04-regras-validacao-local.json (mesmas regras; o .md e o .json devem bater 1:1)

> **Os cards (§5), a tabela-resumo (§2) e a lista de cStat (§8.6) foram GERADOS a partir do .json** (lição 7 do
> método: regra nasce como dado; gerador inline nesta leitura, não versionado). Ao corrigir uma regra, corrija o
> .json primeiro e o card igual — teste de 1:1: todo `#### <id>` do .md existe no .json e vice-versa (198 = 198).
> Todo caminho `arquivo:linha` é relativo a `D:\Componentes\acbr\Fontes\ACBrDFe\` (`..\` sobe para `Fontes\`).
> Enunciados reproduzem a REGRA; nenhum bloco de código do ACBr foi transcrito.

---

## 1. Escopo, fontes e convenções

**Lido por inteiro**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas` (1335 linhas). **Lido nos pontos de
validação**: `ACBrNFe\ACBrNFeNotasFiscais.pas` (Assinar, Validar, VerificarAssinatura, ValidarRegrasdeNegocios,
GerarXML), `ACBrNFe\ACBrNFe.pas` (Enviar, EnviarEvento, predicados de cStat), `ACBrNFe\ACBrNFeConfiguracoes.pas`
(inteiro), `ACBrNFe\Base\ACBrNFe.Consts.pas` (inteiro — só 368 descrições `DSC_*`, nenhuma mensagem de rejeição),
`ACBrNFe\Base\ACBrNFe.XmlWriter.pas` (todos os `wAlerta` e as regras de geração que omitem/forçam/alteram conteúdo).
**Dependências seguidas até a regra**: `ACBrXmlWriter.pas` (AddNode/wAlerta), `ACBrDFeUtil.pas` (chave, município,
cNF, AAMM, país), `ACBrDFeSSL.pas` (CNPJ do certificado), `ACBrDFeWebService.pas` (validade do certificado),
`ACBrDFeConfiguracoes.pas` (flags gerais), `ACBrNFe\ACBrNFeWebServices.pas` (XSD de eventos),
`..\ACBrDiversos\ACBrValidador.pas` (CNPJ, IE, GTIN, prefixo GTIN), `..\ACBrComum\ACBrUtil.Math.pas` (ComparaValor).
`ACBrNFe\PCNNFe\pcnConversaoNFe.pas` e `ACBrDFe.Conversao.pas` foram consultados **só** para traduzir enumerados em
códigos do leiaute (o validador importa `pcnConversaoNFe` — ver §6, D8); nenhuma regra foi extraída do `PCNNFe\`.
**Descartado**: `PCNNFe\` como fonte de regra (writer vigente = `ACBrNFe.XmlWriter` — `..\ACBrComum\ACBr.inc:64`),
`*Ini*`/`*JSON*`, DANFE/relatórios, `ACBrDFe.RTC.XmlWriter.pas` (a NF-e não o usa: `TNFeXmlWriter` herda de
`TACBrXmlWriter` — `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:76`).

**Convenções do card**
- `id` = `ACBR-NFE-<cStat>` quando o código cita o cStat (na mensagem, no nome da opção ou no comentário que a
  acompanha); senão `ACBR-NFE-X<nn>` com `cStat` nulo (nunca há cStat presumido no campo — a hipótese vai na pergunta).
- **Natureza** (início do campo "ativação"): *Validador de regras (opt-in)* · *Regra de geração* (o gerador altera
  ou omite conteúdo) · *Alerta do gerador* (não bloqueia) · *Guarda bloqueante automática*.
- **Confiança**: **Alta** = lógica explícita e mensagem coerente com a condição; **Média** = lógica explícita, mas
  há parâmetro (prazo, tolerância, lista) ou condição que precisa ser conferida no MOC; **Baixa** = a condição
  contradiz a mensagem, a regra é inerte ou é uma aproximação. Toda confiança abaixo de Alta traz a pergunta exata.
- Valores do "Dado/Quando/Então" são exemplos concretos construídos para o teste, não dados reais.

## 2. Resumo

| Categoria | Alta | Média | Baixa | Total |
|---|---:|---:|---:|---:|
| Identificação (ide) | 17 | 9 | 0 | 26 |
| Emitente | 8 | 1 | 0 | 9 |
| Destinatário | 18 | 3 | 2 | 23 |
| Datas | 1 | 7 | 0 | 8 |
| Itens/produto | 13 | 7 | 1 | 21 |
| ICMS/ST | 2 | 3 | 0 | 5 |
| IPI/PIS/COFINS | 2 | 1 | 0 | 3 |
| Totais | 17 | 5 | 0 | 22 |
| Pagamento e cobrança | 12 | 1 | 0 | 13 |
| Transporte | 6 | 0 | 0 | 6 |
| NFC-e | 42 | 2 | 1 | 45 |
| IBS/CBS | 1 | 3 | 0 | 4 |
| Outras | 12 | 1 | 0 | 13 |
| **Total** | **151** | **43** | **4** | **198** |

| Natureza | Cards | Bloqueia o envio no ACBr? |
|---|---:|---|
| Validador de regras (opt-in) | 155 | só se a aplicação chamar e decidir parar |
| Regra de geração | 19 | não (altera/omite o XML) |
| Alerta do gerador (não bloqueia) | 19 | não (só aparece se o XSD falhar) |
| Guarda bloqueante automática | 5 | sim (exceção) |

158 cards têm cStat citado no código (155 no validador + 3 em regras de geração que nomeiam a rejeição que evitam); 40 são `X` (sem cStat no código).

## 3. Fluxo — quando a validação roda e o que acontece na falha

O ACBr tem **quatro camadas** que não se confundem:

```
Aplicação
  │  (opcional, quando quiser)  NotasFiscais.ValidarRegrasdeNegocios(out Erros) ──► TNFeValidarRegras.Validar(Agora)
  │                                                                                  roda TODAS as regras, acumula texto, devolve Boolean
  ▼
ACBrNFe.Enviar(lote)
  ├─ 0 < notas ≤ 50, senão exceção ......................................... guarda (ACBR-NFE-X33)
  ├─ NotasFiscais.Assinar
  │    ├─ raiz do CNPJ do emitente = raiz do CNPJ do certificado, senão exceção  guarda (ACBR-NFE-X31)
  │    ├─ GerarXML: monta a chave, MUTA o objeto (SEM GTIN, textos de homologação,
  │    │            cNF/cDV/Id, cEnq 999), omite/força grupos, grava ALERTAS ...... geração + alertas
  │    ├─ assina infNFe
  │    └─ NFC-e (e 55 com tpImp 6): calcula QR-Code depois da assinatura e regera o XML
  ├─ NotasFiscais.Validar  → XSD de cada nota; a 1ª inválida LEVANTA exceção e interrompe o lote
  │       mensagem = "Falha na validação dos dados da nota: <nNF>" + alertas do gerador (+ erro XSD se ExibirErroSchema)
  └─ WebServices.Envia → antes de qualquer serviço: certificado vencido = exceção (ACBR-NFE-X32)
```

1. **Regras de negócio são opt-in.** `Enviar` chama só `Assinar` + `Validar` (XSD)
   (`ACBrNFe\ACBrNFe.pas:880-881`); `ValidarRegrasdeNegocios` não é chamado por nenhum ponto do componente
   (grep: só a declaração e a própria implementação em `ACBrNFe\ACBrNFeNotasFiscais.pas:107,171,470-496,1012-1032`).
   O exemplo oficial do ACBr a chama sobre um XML **já carregado do disco**
   (`..\..\Exemplos\ACBrDFe\ACBrNFe\Delphi\Frm_ACBrNFe.pas:5724-5727`).
2. **Não para no primeiro erro.** `AdicionaErro` concatena uma linha por violação
   (`ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:465-468`); `Validar` percorre tudo e só no fim decide
   (`:1203-1209`), prefixando "Erro(s) nas Regras de negócios da NF-e: <nNF>". No lote, as mensagens de todas as notas
   são juntadas sem repetir texto idêntico e o resultado é `False` se qualquer nota falhar
   (`ACBrNFe\ACBrNFeNotasFiscais.pas:1012-1032`). **Não levanta exceção** — quem chamou decide o que fazer.
3. **Ordem interna** (`ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:487-495, 497-1201`): regras dos dois modelos
   (226, 228, 512, 701, 703, 897) → só 55 → só 65 → gerais de cabeçalho/participantes (253 … 323) → por item
   (NCM, NFC-e, GTIN, combustível, rastro) → 772 → totais → pagamento. Erros de item levam `[nItem: n]`.
4. **"Agora"** é o relógio do sistema convertido para o fuso configurado (`ACBrNFe\ACBrNFeNotasFiscais.pas:475-477`,
   `ACBrDFeUtil.pas:645-663`); `dEmi` é comparado sem fuso.
5. **XSD é automático e bloqueante**, depois da assinatura, e **para no 1º documento inválido** do lote (laço sem
   tratamento, `ACBrNFe\ACBrNFeNotasFiscais.pas:980-986`). O schema é escolhido pela versão/modelo/UF
   (`ACBrNFe\ACBrNFeNotasFiscais.pas:405-423`; `ACBrNFe\ACBrNFe.pas:313-320`). Eventos: XSD do envelope e de cada
   `detEvento` (`ACBrNFe\ACBrNFeWebServices.pas:3679-3729`).
6. **Alertas do gerador não bloqueiam.** Ficam em `Alertas` e só aparecem anexados à exceção do XSD
   (`ACBrNFe\ACBrNFeNotasFiscais.pas:425-433, 699-703`). XSD válido ⇒ alerta ignorado. As checagens de IE, SUFRAMA e
   lista de serviços do gerador nascem desligadas (`ACBrNFe\Base\ACBrNFe.XmlWriter.pas:263-271`) e o fluxo padrão não
   as liga (`ACBrNFe\ACBrNFeNotasFiscais.pas:633-662` não atribui `ValidarInscricoes`/`ValidarListaServicos`).
7. **Verificação de assinatura** é outro método opt-in (`ACBrNFe\ACBrNFeNotasFiscais.pas:438-468, 988-1010`).
8. **Flags que ligam/desligam algo**: `ExibirErroSchema` (padrão True — só o texto do erro), `FormatoAlerta`,
   `RetirarAcentos`/`RetirarEspacos` (`ACBrDFeConfiguracoes.pas:243-249`); `CamposFatObrigatorios` (True),
   `ForcarGerarTagRejeicao938/906` (Nunca) (`ACBrNFe\ACBrNFeConfiguracoes.pas:57-59, 80-83, 204-206`);
   `Certificados.VerificarValidade` (True — `ACBrDFeConfiguracoes.pas:90`). **Nenhuma flag liga ou desliga regra do
   validador**; as regras só variam por modelo, versão do leiaute, finalidade e ambiente/forma de emissão configurados.

## 4. Parâmetros transversais (valem para vários cards)

| Parâmetro | Valor no ACBr | Evidência |
|---|---|---|
| Comparação de valores | igual se `|a − b| ≤ tolerância` (diferença arredondada a 9 casas) | `..\ACBrComum\ACBrUtil.Math.pas:229-242` |
| Tolerância dos totais e pagamentos | 0,001 (na prática, exato ao centavo) | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:111-112` |
| Tolerância da 610 | 0,009 (e aceita a fórmula sem abater o desonerado) | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1122-1128` |
| Tolerância da 528 | 0,01 | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:836-840` |
| Município IBGE | 7 dígitos, cUF válido, posições 3–6 ≠ 0000, DV módulo 10 pesos 1212120; 9999999 aceito; 9 municípios com DV irregular aceitos | `ACBrDFeUtil.pas:893-931` |
| Códigos de UF | 12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17 + 90/91 | `ACBrDFeUtil.pas:860-865` |
| Chave de acesso | 44 posições, DV módulo 11, cUF, AAMM, CNPJ/CPF | `ACBrDFeUtil.pas:772-810` |
| CNPJ | 14 posições letras/números (alfanumérico aceito), zeros recusado | `..\ACBrDiversos\ACBrValidador.pas:846-880` |
| IE | algoritmo por UF; `ISENTO` aceito; vazio recusado | `..\ACBrDiversos\ACBrValidador.pas:740-767, 1131-1132` |
| GTIN | só dígitos, 8/12/13/14, DV GS1; prefixo em 127 faixas embutidas | `..\ACBrDiversos\ACBrValidador.pas:1690-1865, 1924-1974` |
| Corte do "SEM GTIN" | emissão após 01/12/2018, versão 4.00 | `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1204-1207, 1278-1281` |
| Serviço (validador) | NCM `00` ou `cListServ` preenchido | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:700` |
| Serviço (gerador) | `cSitTrib` do ISSQN ou `cListServ` (versão > 3) — critério diferente | `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1915-1916` |
| tpEmis | 1 normal · 2 FS-IA · 3 SCAN · 4 EPEC · 5 FS-DA · 6 SVC-AN · 7 SVC-RS · 8 SVC-SP · 9 off-line | `ACBrDFe.Conversao.pas:76-81` |
| tpImp | 0 sem · 1 retrato · 2 paisagem · 3 simplificado · 4 NFC-e · 5 msg eletrônica · 6 Simplificado Tipo 2 | `ACBrDFe.Conversao.pas:62-67` |
| indPres | 0,1,2,3,4 (entrega a domicílio),5 (fora do estabelecimento),9 | `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:869-874` |
| finNFe | 1 normal · 2 complementar · 3 ajuste · 4 devolução · 5 crédito · 6 débito | `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:1278-1282` |
| indIEDest | 1 contribuinte · 2 isento · 9 não contribuinte | `ACBrDFe.Conversao.pas:492-495` |
| tpNF | 0 entrada · 1 saída | `ACBrDFe.Conversao.pas:217-220` |
| Versão | várias regras só na 4.00 (GTIN, rastro, pagamento, cobrança, 864, 868) | ver cards |

## 5. Rule Cards

### 5.1 Identificação (ide) — 26 cards

#### ACBR-NFE-226 · cStat 226 · confiança Alta
> A UF do emitente (2 primeiros dígitos do código IBGE do município do emitente) tem de ser a UF do autorizador para o qual o componente está configurado.

- **Dado** Emitente com cMun 4106902 (Curitiba, prefixo 41) e componente configurado para o autorizador de SP (UFCodigo 35)
- **Quando** a aplicação chama a validação de regras
- **Então** erro '226-Rejeição: Código da UF do Emitente diverge da UF autorizadora'
- **Parâmetros**: `comparacao` = copy(cMun do emitente,1,2) × Configuracoes.WebServices.UFCodigo
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:131`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1216-1221`; `ACBrNFe\ACBrNFeNotasFiscais.pas:486`

#### ACBR-NFE-252 · cStat 252 · confiança Alta
> O ambiente da nota (tpAmb) tem de ser o ambiente para o qual o componente está configurado.

- **Dado** Nota com tpAmb=2 (homologação) e componente com Ambiente=produção
- **Quando** validação de regras
- **Então** erro '252-Rejeição: Ambiente informado diverge do Ambiente de recebimento'
- **Parâmetros**: `comparacao` = Ide.tpAmb × Configuracoes.WebServices.Ambiente
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:526-531`; `ACBrNFe\ACBrNFeNotasFiscais.pas:484`

#### ACBR-NFE-253 · cStat 253 · confiança Média
> A chave de acesso (Id sem o prefixo 'NFe') tem de ter 44 posições, DV módulo 11 correto, cUF existente, AAMM com mês 01–12 e CNPJ/CPF válido nas posições do emitente.

- **Dado** Id com 44 posições cujo 44º dígito não confere com o módulo 11 dos 43 anteriores (ou com AAMM '2613', ou cUF 99)
- **Quando** validação de regras
- **Então** erro '253-Rejeição: Digito Verificador da chave de acesso composta inválida'
- **Parâmetros**: `tamanho` = 44 · `dv` = módulo 11 sobre as 43 primeiras posições · `cUF_validos` = 12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17,90,91 · `AAMM` = 4 dígitos, mês 01..12 · `documento` = CPF se a extração der 11 posições, senão CNPJ (aceita alfanumérico)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Observação: o gerador recalcula a chave a cada GerarXML (ver ACBR-NFE-X01), então esta regra só falha em XML carregado de fora ou validado antes da geração.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:497-499`; `ACBrDFeUtil.pas:772-810`; `ACBrDFeUtil.pas:860-865`; `ACBrDFeUtil.pas:739-746`
- **Conferir no MOC**: A mensagem fala só do DV, mas o código também recusa cUF/AAMM/CNPJ inválidos dentro da chave. No MOC, essas falhas são cStat 253 ou códigos próprios (ex.: 502 — Id não corresponde à concatenação)?

#### ACBR-NFE-270 · cStat 270 · confiança Alta
> O município do fato gerador (cMunFG) tem de ter dígito verificador IBGE válido.

- **Dado** cMunFG 4106903 (Curitiba é 4106902)
- **Quando** validação de regras
- **Então** erro '270-Rejeição: Código Município do Fato Gerador: dígito inválido'
- **Parâmetros**: `tamanho` = 7 · `dv` = módulo 10, pesos 1212120 (produtos > 9 somam os dígitos) · `aceito_sempre` = 9999999 · `prefixo` = 2 primeiros dígitos = cUF válido; posições 3–6 ≠ '0000' · `excecoes_dv_irregular` = 2201919, 2202251, 2201988, 2611533, 3117836, 3152131, 4305871, 5203939, 5203962
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:501-503`; `ACBrDFeUtil.pas:893-931`

#### ACBR-NFE-271 · cStat 271 · confiança Alta
> O município do fato gerador tem de pertencer à UF do emitente.

- **Dado** Emitente PR (41) e cMunFG 3550308 (São Paulo)
- **Quando** validação de regras
- **Então** erro '271-Rejeição: Código Município do Fato Gerador: difere da UF do emitente'
- **Parâmetros**: `comparacao` = código da UF do emitente × copy(cMunFG,1,2)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:505-508`

#### ACBR-NFE-570 · cStat 570 · confiança Média
> Nota marcada como contingência SCAN/SVC (tpEmis 3, 6 ou 7) não pode sair por um componente configurado para emissão normal.

- **Dado** Nota com tpEmis=6 (SVC-AN) e componente com FormaEmissao normal (código 1)
- **Quando** validação de regras
- **Então** erro '570-Rejeição: Tipo de Emissão 3, 6 ou 7 só é válido nas contingências SCAN/SVC'
- **Parâmetros**: `tpEmis_nota` = 3, 6, 7 · `forma_emissao_config` = 1
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:510-513`; `ACBrNFe\ACBrNFeNotasFiscais.pas:485`
- **Conferir no MOC**: Na SEFAZ a 570 compara tpEmis com o web service que recebeu (SVC acessada); o ACBr compara com a configuração local. Confirmar a condição oficial.

#### ACBR-NFE-713 · cStat 713 · confiança Média
> Componente configurado para SVC (forma 6 ou 7) só pode enviar nota com tpEmis 6 ou 7.

- **Dado** Componente com FormaEmissao 7 (SVC-RS) e nota com tpEmis=1
- **Quando** validação de regras
- **Então** erro '713-Rejeição: Tipo de Emissão diferente de 6 ou 7 para contingência da SVC acessada'
- **Parâmetros**: `forma_emissao_config` = 6, 7 · `tpEmis_nota_aceito` = 6, 7
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:521-524`; `ACBrNFe\ACBrNFeNotasFiscais.pas:485`
- **Conferir no MOC**: Mesma questão da 570: a regra oficial compara com a SVC efetivamente acessada; o ACBr usa a configuração.

#### ACBR-NFE-370 · cStat 370 · confiança Alta
> Nota fiscal avulsa (procEmi 1 ou 2) só pode ter tipo de emissão normal.

- **Dado** procEmi=1 (avulsa pelo fisco) e tpEmis=2
- **Quando** validação de regras
- **Então** erro '370-Rejeição: Nota Fiscal Avulsa com tipo de emissão inválido'
- **Parâmetros**: `procEmi` = 1, 2 · `tpEmis_exigido` = 1
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:533-536`

#### ACBR-NFE-556 · cStat 556 · confiança Alta
> Emissão normal (tpEmis 1) não pode trazer justificativa nem data/hora de entrada em contingência.

- **Dado** tpEmis=1 e xJust='queda de energia'
- **Quando** validação de regras
- **Então** erro '556-Justificativa de entrada em contingência não deve ser informada para tipo de emissão normal'
- **Parâmetros**: `campos` = xJust preenchida ou dhCont ≠ 0
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:538-543`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:619-631`

#### ACBR-NFE-557 · cStat 557 · confiança Média
> Contingência em formulário de segurança ou off-line (tpEmis 2, 5 ou 9) exige justificativa.

- **Dado** tpEmis=5 (FS-DA) e xJust vazia
- **Quando** validação de regras
- **Então** erro '557-A Justificativa de entrada em contingência deve ser informada'
- **Parâmetros**: `tpEmis_cobrados` = 2, 5, 9 · `tpEmis_nao_cobrados` = 3, 4, 6, 7, 8
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:545-548`
- **Conferir no MOC**: O MOC exige xJust para todo tpEmis ≠ 1 (inclusive 4-EPEC e 6/7-SVC)? O ACBr só cobra 2, 5 e 9.

#### ACBR-NFE-701 · cStat 701 · confiança Média
> A versão do leiaute (atributo versao de infNFe) não pode ser anterior a 3.10.

- **Dado** infNFe versao='3.00'
- **Quando** validação de regras
- **Então** erro '701-Rejeição: Versão inválida'
- **Parâmetros**: `versao_minima` = 3.10
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:134`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1286-1291`
- **Conferir no MOC**: Hoje só a 4.00 é aceita pela SEFAZ; o piso local de 3.10 está defasado. Confirmar versões vigentes (inclusive leiaute RTC).

#### ACBR-NFE-710 · cStat 710 · confiança Alta
> NF-e (55) não pode usar formato de DANFE de NFC-e (tpImp 4) nem de mensagem eletrônica (tpImp 5).

- **Dado** Modelo 55 com tpImp=4
- **Quando** validação de regras
- **Então** erro '710-Rejeição: NF-e com formato de DANFE inválido'
- **Parâmetros**: `tpImp_proibidos` = 4, 5
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:149`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1300-1305`; `ACBrDFe.Conversao.pas:62-67`

#### ACBR-NFE-711 · cStat 711 · confiança Média
> NF-e (55) em contingência off-line (tpEmis 9) só é aceita com DANFE Simplificado Tipo 2 (tpImp 6).

- **Dado** Modelo 55, tpEmis=9 e tpImp=1
- **Quando** validação de regras
- **Então** erro '711-Rejeição: NF-e com contingência off-line em operação não permitida'
- **Parâmetros**: `tpEmis` = 9 · `tpImp_exigido` = 6 (DANFE Simplificado Tipo 2 — NT 2026/002)
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:150`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1307-1312`; `ACBrDFe.Conversao.pas:62-67`; `ACBrNFe\ACBrNFe-change-log.txt:73-75`; `ACBrNFe\ACBrNFe-change-log.txt:88-90`
- **Conferir no MOC**: Conferir na NT 2026/002 em que condições a NF-e 55 pode usar tpEmis 9 com tpImp 6 (UF, indPres, valor) — o ACBr só exige tpImp 6 (ajuste ACBR-9651 de 20/07/2026).

#### ACBR-NFE-794 · cStat 794 · confiança Média
> NF-e (55) com indicativo de entrega a domicílio (indPres 4, típico de NFC-e) só é aceita com DANFE Simplificado Tipo 2 (tpImp 6).

- **Dado** Modelo 55, indPres=4 e tpImp=1
- **Quando** validação de regras
- **Então** erro '794-Rejeição: NF-e com indicativo de NFC-e com entrega a domicílio'
- **Parâmetros**: `indPres` = 4 · `tpImp_exigido` = 6
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:181`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1321-1326`
- **Conferir no MOC**: Conferir na NT 2026/002 se a exceção de tpImp 6 para indPres 4 no modelo 55 é a regra oficial.

#### ACBR-NFE-897 · cStat 897 · confiança Alta
> O código numérico da chave (cNF) não pode ser igual ao número da nota nem uma sequência trivial.

- **Dado** nNF=123 e cNF=12345678
- **Quando** validação de regras
- **Então** erro '897-Rejeição: Código numérico em formato inválido'
- **Parâmetros**: `proibido_igual` = cNF = nNF · `sequencias_proibidas_8_digitos` = 00000000, 11111111, 22222222, 33333333, 44444444, 55555555, 66666666, 77777777, 88888888, 99999999, 12345678, 23456789, 34567890, 45678901, 56789012, 67890123, 78901234, 89012345, 90123456, 01234567
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:136`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1328-1333`; `ACBrDFeUtil.pas:978-999`

#### ACBR-NFE-254 · cStat 254 · confiança Alta
> NF-e complementar (finNFe 2) tem de referenciar uma nota.

- **Dado** finNFe=2 e nenhum NFref
- **Quando** validação de regras
- **Então** erro '254-Rejeição: NF-e complementar não possui NF referenciada'
- **Parâmetros**: `finNFe` = 2
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:152-154`

#### ACBR-NFE-255 · cStat 255 · confiança Alta
> NF-e complementar referencia exatamente uma nota.

- **Dado** finNFe=2 e 2 NFref
- **Quando** validação de regras
- **Então** erro '255-Rejeição: NF-e complementar possui mais de uma NF referenciada'
- **Parâmetros**: `maximo_referencias` = 1
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:156-158`

#### ACBR-NFE-269 · cStat 269 · confiança Média
> Na NF-e complementar, a nota referenciada em papel (refNF) ou de produtor (refNFP) tem de ser do mesmo CNPJ/CPF do emitente.

- **Dado** finNFe=2, 1 NFref com refNF.CNPJ 11222333000181 e emitente 12345678000195
- **Quando** validação de regras
- **Então** erro '269-Rejeição: CNPJ Emitente da NF Complementar difere do CNPJ da NF Referenciada'
- **Parâmetros**: `grupos_checados` = refNF.CNPJ, refNFP.CNPJCPF · `grupos_nao_checados` = refNFe (chave), refCTe, refECF
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:160-168`
- **Conferir no MOC**: A 269 oficial também compara o CNPJ contido na chave refNFe? O ACBr só olha refNF/refNFP.

#### ACBR-NFE-678 · cStat 678 · confiança Média
> Na NF-e complementar, a nota referenciada em papel/produtor tem de ser da mesma UF do emitente (regra marcada como facultativa).

- **Dado** finNFe=2, refNF com cUF=35 e emitente PR
- **Quando** validação de regras
- **Então** erro '678-Rejeição: NF referenciada com UF diferente da NF-e complementar'
- **Parâmetros**: `grupos_checados` = refNF (nNF>0), refNFP (nNF>0) · `facultativa` = sim (comentário B25-60)
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:170-179`
- **Conferir no MOC**: Regra facultativa por UF: quais autorizadores aplicam a 678?

#### ACBR-NFE-321 · cStat 321 · confiança Alta
> NF-e de devolução (finNFe 4) tem de referenciar documento — no cabeçalho (NFref) ou em algum item (DFeReferenciado, Reforma Tributária).

- **Dado** finNFe=4, sem NFref e nenhum item com DFeReferenciado.chaveAcesso
- **Quando** validação de regras
- **Então** erro '321-Rejeição: NF-e devolução não possui NF referenciada'
- **Parâmetros**: `finNFe` = 4 · `aceita_como_referencia` = NFref no ide OU DFeReferenciado em qualquer item
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:145`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1233-1252`; `ACBrNFe\ACBrNFe-change-log.txt:446-449`

#### ACBR-NFE-864 · cStat 864 · confiança Alta
> NF-e de operação presencial fora do estabelecimento (indPres 5) tem de referenciar nota.

- **Dado** Versão 4.00, indPres=5 e nenhum NFref
- **Quando** validação de regras
- **Então** erro '864-Rejeição: NF-e com indicativo de Operação presencial, fora do estabelecimento e não informada NF referenciada'
- **Parâmetros**: `indPres` = 5 · `versao` = >= 4
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:257-262`

#### ACBR-NFE-X01 · cStat — · confiança Alta
> A chave de acesso é sempre montada pelo gerador: cUF + AAMM da emissão (no fuso da UF) + CNPJ/CPF do emitente (ou CNPJ da avulsa) + modelo + série + número + tpEmis + cNF + DV módulo 11; cNF 0 ou −1 é sorteado até passar na regra 897; cNF ≤ −2 vira zero.

- **Dado** Nota 55, série 1, nNF 123, tpEmis 1, cNF=0, emitente 12345678000195 PR, dEmi 10/10/2026
- **Quando** o XML é gerado (Assinar/GerarXML)
- **Então** Id = 'NFe41' + '2610' + '12345678000195' + '55' + '001' + '000000123' + '1' + cNF sorteado (8 dígitos) + DV; cDV e cNF do objeto são reescritos
- **Parâmetros**: `tamanhos` = cUF 2, AAMM 4, documento 14, mod 2, série 3, nNF 9, tpEmis 1, cNF 8, DV 1 · `sorteio_cNF` = Random até ValidarCodigoDFe aceitar · `fuso` = AAMM calculado com AjustarDataHoraParaUf
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:353-364`; `ACBrDFeUtil.pas:184-237`

#### ACBR-NFE-X02 · cStat — · confiança Alta
> cUF da nota fora da lista de códigos de UF gera alerta.

- **Dado** ide.cUF=99
- **Quando** o XML é gerado
- **Então** alerta 'B02 cUF inválido'
- **Parâmetros**: `cUF_validos` = 12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17,90,91
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:497-500`; `ACBrDFeUtil.pas:860-865`

#### ACBR-NFE-X03 · cStat — · confiança Alta
> Município do fato gerador (cMunFG) e o novo município do fato gerador do IBS (cMunFGIBS, Reforma) com DV inválido geram alerta.

- **Dado** cMunFGIBS=4106903
- **Quando** o XML é gerado
- **Então** alerta 'B12 cMunFGIBS inválido'; cMunFGIBS só é gerado quando > 0
- **Parâmetros**: `dv` = mesma rotina ValidarMunicipio da 270
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:551-563`

#### ACBR-NFE-X04 · cStat — · confiança Alta
> Chave de documento referenciado inválida gera alerta: refNFe (B13), refCTe (B20i), chNFe de exportação indireta (I54) e DFeReferenciado do item (VB02).

- **Dado** refNFe com 44 dígitos e DV errado
- **Quando** o XML é gerado
- **Então** alerta 'B13 refNFe inválido' (refNFeSig não é checada)
- **Parâmetros**: `validacao` = ValidarChave (mesma da 253)
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:674-687`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:743-749`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1519-1522`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:4761-4778`

#### ACBR-NFE-X05 · cStat — · confiança Alta
> Nota referenciada em papel (refNF) ou de produtor (refNFP): cUF inexistente, AAMM com mês fora de 01–12 ou modelo inválido geram alerta.

- **Dado** refNF com AAMM='2613' e mod=4
- **Quando** o XML é gerado
- **Então** alertas 'B16 AAMM Periodo inválido' e 'B18 mod Modelo de documento inválido'
- **Parâmetros**: `modelos_refNF_validos` = versão < 4: 1; versão ≥ 4: 1 ou 2 (refNFP não checa modelo)
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:689-741`; `ACBrDFeUtil.pas:882-891`

### 5.2 Emitente — 9 cards

#### ACBR-NFE-207 · cStat 207 · confiança Alta
> O CNPJ (ou CPF, no caso do produtor rural) do emitente tem de ser válido.

- **Dado** Emitente CNPJ 12345678000100 (DV errado)
- **Quando** validação de regras
- **Então** erro '207-Rejeição: CNPJ do emitente inválido'
- **Parâmetros**: `aceita` = CPF (11) ou CNPJ (14, inclusive alfanumérico) · `zeros` = 00000000000000 recusado
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:558-561`; `..\ACBrDiversos\ACBrValidador.pas:846-880`

#### ACBR-NFE-272 · cStat 272 · confiança Alta
> O município do emitente tem de ter DV IBGE válido.

- **Dado** enderEmit.cMun=4106903
- **Quando** validação de regras
- **Então** erro '272-Rejeição: Código Município do Emitente: dígito inválido'
- **Parâmetros**: `dv` = ValidarMunicipio (ver 270)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:563-565`

#### ACBR-NFE-273 · cStat 273 · confiança Alta
> O município do emitente tem de pertencer à UF do emitente.

- **Dado** enderEmit.UF='PR' e cMun 3550308
- **Quando** validação de regras
- **Então** erro '273-Rejeição: Código Município do Emitente: difere da UF do emitente'
- **Parâmetros**: `comparacao` = código da UF × copy(cMun,1,2)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:567-570`

#### ACBR-NFE-229 · cStat 229 · confiança Alta
> A inscrição estadual do emitente é obrigatória.

- **Dado** Emitente sem IE (caso da Setes, prestadora de serviço)
- **Quando** validação de regras
- **Então** erro '229-Rejeição: IE do emitente não informada' (e, junto, a 209 — IE vazia também é 'inválida')
- **Parâmetros**: `vazio` = string vazia
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:572-574`

#### ACBR-NFE-209 · cStat 209 · confiança Média
> A inscrição estadual do emitente tem de ser válida para a UF do emitente; o texto 'ISENTO' é aceito como válido.

- **Dado** Emitente PR com IE 1234567890 (DV errado)
- **Quando** validação de regras
- **Então** erro '209-Rejeição: IE do emitente inválida'
- **Parâmetros**: `algoritmo` = ACBrValidador por UF · `ISENTO` = aceito · `vazio` = recusado ('não pode ser vazio')
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:576-578`; `ACBrDFeUtil.pas:945-948`; `..\ACBrDiversos\ACBrValidador.pas:1131-1132`; `..\ACBrDiversos\ACBrValidador.pas:740-767`
- **Conferir no MOC**: O MOC aceita IE 'ISENTO' para o EMITENTE de NF-e/NFC-e? O ACBr aceita; se o oficial recusa, a pré-validação precisa recusar também.

#### ACBR-NFE-530 · cStat 530 · confiança Alta
> Item com tributação de ISSQN exige inscrição municipal do emitente.

- **Dado** Emitente sem IM e item com ISSQN.vBC 100,00 e cListServ '01.02'
- **Quando** validação de regras
- **Então** erro '530-Rejeição: Operação com tributação de ISSQN sem informar a Inscrição Municipal [nItem: 1]'
- **Parâmetros**: `gatilho_ISSQN` = vBC, vAliq, vISSQN ou cMunFG > 0 (tolerância 0,001) ou cListServ preenchido
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:847-854`

#### ACBR-NFE-X07 · cStat — · confiança Alta
> A IE do emitente sai como 'ISENTO' literal ou só com dígitos; a checagem de IE vazia/inválida no gerador só existe com a opção ValidarInscricoes, que nasce desligada e o fluxo padrão não liga.

- **Dado** Opcoes.ValidarInscricoes=False (padrão) e IE vazia
- **Quando** o XML é gerado
- **Então** nenhum alerta C17; a tag IE sai vazia (o XSD acusa)
- **Parâmetros**: `ValidarInscricoes` = False (padrão); não atribuído em NotaFiscal.GerarXML · `excecao` = procEmi=1 (avulsa fisco) não é checada
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado. Depende de Opcoes.ValidarInscricoes=True.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:772-787`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:267`; `ACBrNFe\ACBrNFeNotasFiscais.pas:633-662`

#### ACBR-NFE-X08 · cStat — · confiança Alta
> Endereço do emitente e da avulsa: município com DV inválido ou UF inexistente geram alerta; o país do emitente é sempre 1058.

- **Dado** enderEmit.UF='XX'
- **Quando** o XML é gerado
- **Então** alerta 'C12 UF inválido'
- **Parâmetros**: `UF_validas` = AC..TO + EX · `cPais_emitente` = 1058 fixo
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:805-838`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:856-859`; `ACBrDFeUtil.pas:938-943`

#### ACBR-NFE-X09 · cStat — · confiança Alta
> O CNAE só é gerado quando há inscrição municipal (NT 2013/005 v1.03).

- **Dado** Emitente com CNAE 6201501 e sem IM
- **Quando** o XML é gerado
- **Então** tag CNAE omitida
- **Parâmetros**: `condicao` = Length(IM) > 0
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:790-796`

### 5.3 Destinatário — 23 cards

#### ACBR-NFE-208 · cStat 208 · confiança Alta
> CNPJ do destinatário, quando informado, tem de ser válido.

- **Dado** dest.CNPJ 11222333000180 (DV errado)
- **Quando** validação de regras
- **Então** erro '208-Rejeição: CNPJ do destinatário inválido'
- **Parâmetros**: `gatilho` = documento com 14 ou mais posições após limpeza (aceita alfanumérico)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:580-583`

#### ACBR-NFE-237 · cStat 237 · confiança Média
> CPF do destinatário, quando informado, tem de ser válido — checado só na NF-e 55.

- **Dado** Modelo 55 e dest.CPF 12345678900 (DV errado)
- **Quando** validação de regras
- **Então** erro '237-Rejeição: CPF do destinatário inválido'
- **Parâmetros**: `gatilho` = documento não vazio com até 11 posições
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:188-192`
- **Conferir no MOC**: A 237 oficial vale também para NFC-e (CPF do consumidor)? O ACBr só checa no 55.

#### ACBR-NFE-721 · cStat 721 · confiança Alta
> Operação interestadual exige CNPJ ou CPF do destinatário.

- **Dado** Modelo 55, idDest=2 e dest sem CNPJ/CPF
- **Quando** validação de regras
- **Então** erro '721-Rejeição: Operação interestadual deve informar CNPJ ou CPF'
- **Parâmetros**: `idDest` = 2
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:199-202`

#### ACBR-NFE-723 · cStat 723 · confiança Alta
> Operação interna com destinatário estrangeiro (idEstrangeiro) só para consumidor final.

- **Dado** idDest=1, idEstrangeiro='AB123456' e indFinal=0
- **Quando** validação de regras
- **Então** erro '723-Rejeição: Operação interna com idEstrangeiro informado deve ser para consumidor final'
- **Parâmetros**: `idDest` = 1 · `indFinal_exigido` = 1
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:204-208`

#### ACBR-NFE-724 · cStat 724 · confiança Alta
> NF-e exige o nome do destinatário.

- **Dado** Modelo 55 e dest.xNome vazio
- **Quando** validação de regras
- **Então** erro '724-Rejeição: NF-e sem o nome do destinatário'
- **Parâmetros**: —
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Em homologação o gerador sobrescreve xNome (ver ACBR-NFE-X10).
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:210-212`

#### ACBR-NFE-726 · cStat 726 · confiança Alta
> NF-e exige o logradouro do destinatário.

- **Dado** Modelo 55 e enderDest.xLgr vazio
- **Quando** validação de regras
- **Então** erro '726-Rejeição: NF-e sem a informação de endereço do destinatário'
- **Parâmetros**: —
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:214-216`

#### ACBR-NFE-509 · cStat 509 · confiança Baixa
> O código diz 509 (exterior com município ≠ 9999999), mas a condição executada é outra: destinatário de UF diferente de 'EX' com município de DV inválido.

- **Dado** Modelo 55, enderDest.UF='PR' e cMun 4106903
- **Quando** validação de regras
- **Então** erro com o texto da 509 ('código de município diferente de 9999999 para operação com o exterior')
- **Parâmetros**: `condicao_executada` = UF ≠ 'EX' e ValidarMunicipio(cMun) falso
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:218-221`
- **Conferir no MOC**: Discrepância mensagem × condição. No MOC: DV inválido do município do destinatário é qual cStat (hipótese 274)? E a 509 (UF 'EX' com cMun ≠ 9999999) — o ACBr não a executa para o destinatário.

#### ACBR-NFE-727 · cStat 727 · confiança Alta
> Operação com o exterior exige UF do destinatário 'EX'.

- **Dado** idDest=3 e enderDest.UF='SP'
- **Quando** validação de regras
- **Então** erro '727-Rejeição: Operação com Exterior e UF diferente de EX'
- **Parâmetros**: `idDest` = 3
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:223-226`

#### ACBR-NFE-771 · cStat 771 · confiança Alta
> Operação interestadual não pode ter destinatário com UF 'EX'.

- **Dado** idDest=2 e enderDest.UF='EX'
- **Quando** validação de regras
- **Então** erro '771-Rejeição: Operação Interestadual e UF de destino com EX'
- **Parâmetros**: `idDest` = 2
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:228-231`

#### ACBR-NFE-773 · cStat 773 · confiança Alta
> Operação interna com destinatário de outra UF só é aceita se presencial.

- **Dado** Emitente PR, idDest=1, enderDest.UF='SC' e indPres=2 (internet)
- **Quando** validação de regras
- **Então** erro '773-Rejeição: Operação Interna e UF de destino difere da UF do emitente - não presencial'
- **Parâmetros**: `idDest` = 1 · `excecao` = indPres=1
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:233-237`; `ACBrNFe\ACBrNFe-change-log.txt:3709`

#### ACBR-NFE-790 · cStat 790 · confiança Alta
> Operação com o exterior exige destinatário não contribuinte (indIEDest 9).

- **Dado** idDest=3 e indIEDest=1
- **Quando** validação de regras
- **Então** erro '790-Rejeição: Operação com Exterior para destinatário Contribuinte de ICMS'
- **Parâmetros**: `indIEDest_exigido` = 9
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:239-242`; `ACBrDFe.Conversao.pas:492-495`

#### ACBR-NFE-772 · cStat 772 · confiança Baixa
> Operação interestadual não pode ter destinatário na UF do emitente — mas o ACBr só acusa quando também há local de entrega na UF do emitente.

- **Dado** Emitente PR, idDest=2, dest PR (CNPJ diferente do emitente), entrega.UF='PR', nenhum combustível com UFcons ≠ PR
- **Quando** validação de regras
- **Então** erro '772-Rejeição: Operação Interestadual e UF de destino igual à UF do emitente'; sem grupo entrega, nenhum erro
- **Parâmetros**: `excecoes` = item de combustível com UFcons ≠ UF do emitente; dest com o mesmo CNPJ do emitente; entrega.UF ≠ UF do emitente (inclusive vazia)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:928-929`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1021-1029`; `ACBrNFe\ACBrNFe-change-log.txt:1587`
- **Conferir no MOC**: A exigência de entrega.UF = UF do emitente faz a regra nunca disparar quando não há local de entrega. Qual é a exceção oficial da 772 (entrega em outra UF? mesmo CNPJ?)

#### ACBR-NFE-513 · cStat 513 · confiança Alta
> Local de retirada com UF 'EX' exige município 9999999.

- **Dado** retirada.UF='EX' e cMun 4106902
- **Quando** validação de regras
- **Então** erro '513-Rejeição: Código Município do Local de Retirada deve ser 9999999 para UF retirada = EX'
- **Parâmetros**: `cMun_exterior` = 9999999
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:585-588`

#### ACBR-NFE-276 · cStat 276 · confiança Alta
> Município do local de retirada (no Brasil, com nome informado) tem de ter DV válido.

- **Dado** retirada.UF='PR', xMun='Curitiba', cMun 4106903
- **Quando** validação de regras
- **Então** erro '276-Rejeição: Código Município do Local de Retirada: dígito inválido'
- **Parâmetros**: `gatilho` = UF ≠ 'EX' e xMun preenchido
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:590-594`

#### ACBR-NFE-277 · cStat 277 · confiança Alta
> Município do local de retirada tem de pertencer à UF informada (UF 'EX' corresponde ao prefixo 99).

- **Dado** retirada.UF='SC' e cMun 4106902
- **Quando** validação de regras
- **Então** erro '277-Rejeição: Código Município do Local de Retirada: difere da UF do Local de Retirada'
- **Parâmetros**: `gatilho` = UF preenchida e cMun > 0 · `EX` = prefixo 99
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:596-606`

#### ACBR-NFE-515 · cStat 515 · confiança Alta
> Local de entrega com UF 'EX' exige município 9999999.

- **Dado** entrega.UF='EX' e cMun 4106902
- **Quando** validação de regras
- **Então** erro '515-Rejeição: Código Município do Local de Entrega deve ser 9999999 para UF entrega = EX'
- **Parâmetros**: `cMun_exterior` = 9999999
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:608-611`

#### ACBR-NFE-278 · cStat 278 · confiança Alta
> Município do local de entrega (no Brasil, com nome informado) tem de ter DV válido.

- **Dado** entrega.UF='PR', xMun='Curitiba', cMun 4106903
- **Quando** validação de regras
- **Então** erro '278-Rejeição: Código Município do Local de Entrega: dígito inválido'
- **Parâmetros**: `gatilho` = UF ≠ 'EX' e xMun preenchido
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:613-617`

#### ACBR-NFE-279 · cStat 279 · confiança Alta
> Município do local de entrega tem de pertencer à UF informada (UF 'EX' corresponde ao prefixo 99).

- **Dado** entrega.UF='SC' e cMun 4106902
- **Quando** validação de regras
- **Então** erro '279-Rejeição: Código Município do Local de Entrega: difere da UF do Local de Entrega'
- **Parâmetros**: `gatilho` = UF preenchida e cMun > 0 · `EX` = prefixo 99
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:619-629`

#### ACBR-NFE-X10 · cStat — · confiança Média
> Em homologação o gerador sobrescreve o nome do destinatário pelo texto fixo de homologação.

- **Dado** tpAmb=2 e dest.xNome='Cliente Real Ltda'
- **Quando** o XML é gerado
- **Então** xNome = 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL' (no objeto e no XML)
- **Parâmetros**: `texto` = NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:873-898`
- **Conferir no MOC**: Qual regra/cStat do MOC exige esse texto em homologação e se vale para 55 e 65 (o ACBr aplica sempre que o grupo dest é gerado).

#### ACBR-NFE-X11 · cStat — · confiança Alta
> Na NFC-e o grupo dest só é gerado se houver CNPJ/CPF, idEstrangeiro ou UF 'EX'; destinatário com país ≠ 1058 ou idEstrangeiro recebe idEstrangeiro no lugar do documento; nome e endereço são obrigatórios só no 55 (no 65, endereço só se houver logradouro).

- **Dado** Modelo 65 sem documento do consumidor
- **Quando** o XML é gerado
- **Então** grupo dest omitido
- **Parâmetros**: `documento_obrigatorio_55` = sim · `documento_obrigatorio_65` = não
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:440-442`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:884-906`

#### ACBR-NFE-X12 · cStat — · confiança Alta
> IE do destinatário não é gerada quando indIEDest=2 (isento); 'ISENTO' literal é mantido, o resto vira só dígitos; IE e SUFRAMA do destinatário só são checadas (alertas E17/E18) com ValidarInscricoes ligado.

- **Dado** indIEDest=2 e dest.IE='123.456.78-9'
- **Quando** o XML é gerado
- **Então** tag IE omitida
- **Parâmetros**: `SUFRAMA_dv` = 9 dígitos, módulo 11 com pesos 9..1 · `ValidarInscricoes` = False (padrão)
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro. Alertas dependem de Opcoes.ValidarInscricoes=True.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:908-943`; `ACBrDFeUtil.pas:950-966`

#### ACBR-NFE-X13 · cStat — · confiança Média
> Endereço do destinatário: município com DV inválido (E10) e UF inexistente (E12) geram alerta; o alerta de país (E14) tem defeito de precedência e só dispara quando o código NÃO está na tabela mas o DV confere — inclusive cPais não preenchido (0).

- **Dado** enderDest.cPais=0 (não preenchido)
- **Quando** o XML é gerado
- **Então** alerta 'E14 cPais inválido' (falso positivo); código de país com DV errado não gera alerta
- **Parâmetros**: `defeito` = 'not ValidarCodigoPais(x) = -1' é avaliado como '(not x) = -1', verdadeiro só quando x = 0
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:946-981`; `ACBrDFeUtil.pas:812-858`
- **Conferir no MOC**: Qual a regra oficial para país do destinatário (tabela BACEN; rejeição própria)? A pré-validação deve implementar a intenção, não o defeito.

#### ACBR-NFE-X14 · cStat — · confiança Alta
> Locais de retirada e de entrega (gerados só com logradouro): CNPJ/CPF, município, UF e país são checados com alerta (F02–F11 / G02–G11); a entrega checa o município bruto (antes do ajuste de exterior) e reporta o alerta com o ID 'F07'.

- **Dado** entrega com xLgr e cMun 4106903
- **Quando** o XML é gerado
- **Então** alerta 'F07 cMun inválido' (ID da retirada, embora seja a entrega)
- **Parâmetros**: `gatilho` = xLgr preenchido · `cPais` = mesmo defeito da ACBR-NFE-X13
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:983-1081`

### 5.4 Datas — 8 cards

#### ACBR-NFE-228 · cStat 228 · confiança Média
> A data de emissão não pode ter mais de 30 dias de atraso em relação ao momento da validação.

- **Dado** Agora = 10/10/2026 12:00 e dEmi = 09/09/2026 11:00
- **Quando** validação de regras
- **Então** erro '228-Rejeição: Data de Emissão muito atrasada'
- **Parâmetros**: `limite_dias` = 30 · `agora` = relógio do sistema convertido para o fuso configurado (DataHoraTimeZoneModoDeteccao)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:132`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1223-1231`; `ACBrNFe\ACBrNFeNotasFiscais.pas:475-477`; `ACBrDFeUtil.pas:645-663`
- **Conferir no MOC**: Confirmar o limite oficial de atraso da dhEmi para 55 e 65 (o ACBr usa 30 dias para ambos).

#### ACBR-NFE-703 · cStat 703 · confiança Média
> A data/hora de emissão não pode estar mais de 5 minutos no futuro.

- **Dado** Agora = 12:00 e dEmi = 12:06 do mesmo dia
- **Quando** validação de regras
- **Então** erro '703-Rejeição: Data-Hora de Emissão posterior ao horário de recebimento'
- **Parâmetros**: `tolerancia_minutos` = 5
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:135`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1293-1298`
- **Conferir no MOC**: Confirmar a tolerância oficial de dhEmi futura (o ACBr usa 5 minutos).

#### ACBR-NFE-504 · cStat 504 · confiança Média
> A data de saída/entrada não pode estar mais de 30 dias no futuro (regra facultativa).

- **Dado** Agora = 10/10/2026 e dSaiEnt = 15/11/2026
- **Quando** validação de regras
- **Então** erro '504-Rejeição: Data de Entrada/Saída posterior ao permitido'
- **Parâmetros**: `limite_dias` = 30 · `facultativa` = sim (comentário B10-20)
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:146`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1254-1259`
- **Conferir no MOC**: Regra facultativa: quais UFs aplicam e com qual prazo?

#### ACBR-NFE-505 · cStat 505 · confiança Média
> A data de saída/entrada, quando informada, não pode ter mais de 30 dias de atraso (regra facultativa).

- **Dado** Agora = 10/10/2026 e dSaiEnt = 01/09/2026
- **Quando** validação de regras
- **Então** erro '505-Rejeição: Data de Entrada/Saída anterior ao permitido'
- **Parâmetros**: `limite_dias` = 30 · `facultativa` = sim (comentário B10-30)
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:147`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1261-1266`
- **Conferir no MOC**: Regra facultativa: quais UFs aplicam e com qual prazo?

#### ACBR-NFE-506 · cStat 506 · confiança Média
> A data de saída/entrada, quando informada, não pode ser anterior à data de emissão (regra facultativa).

- **Dado** dEmi = 10/10/2026 10:00 e dSaiEnt = 10/10/2026 09:00
- **Quando** validação de regras
- **Então** erro '506-Rejeição: Data de Saída menor que a Data de Emissão'
- **Parâmetros**: `comparacao` = data e hora · `facultativa` = sim (comentário B10-40)
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:148`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1268-1274`
- **Conferir no MOC**: Regra facultativa: quais UFs aplicam? A comparação oficial é por data ou data-hora?

#### ACBR-NFE-558 · cStat 558 · confiança Média
> A data de entrada em contingência não pode ser de um dia posterior ao da validação.

- **Dado** Agora = 10/10/2026 e dhCont = 11/10/2026 00:10
- **Quando** validação de regras
- **Então** erro '558-Rejeição: Data de entrada em contingência posterior a data de recebimento'
- **Parâmetros**: `comparacao` = só a data (CompareDate), sem hora
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:550-552`
- **Conferir no MOC**: A regra oficial compara data-hora (com tolerância) ou só a data?

#### ACBR-NFE-569 · cStat 569 · confiança Média
> A data de entrada em contingência não pode ter mais de 30 dias de atraso.

- **Dado** Agora = 10/10/2026 e dhCont = 01/09/2026
- **Quando** validação de regras
- **Então** erro '569-Rejeição: Data de entrada em contingência muito atrasada'
- **Parâmetros**: `limite_dias` = 30
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:554-556`
- **Conferir no MOC**: Confirmar o limite oficial de atraso da dhCont.

#### ACBR-NFE-X06 · cStat — · confiança Alta
> A data/hora de saída (dhSaiEnt) só é gerada no XML do modelo 55; na NFC-e é descartada mesmo se preenchida.

- **Dado** Modelo 65 com dSaiEnt preenchida
- **Quando** o XML é gerado
- **Então** dhSaiEnt omitida (o validador de regras, se rodar sobre o objeto, acusa a 705)
- **Parâmetros**: `formato` = data-hora com fuso da UF (DateTimeWithTimeZone)
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:517-527`

### 5.5 Itens/produto — 21 cards

#### ACBR-NFE-777 · cStat 777 · confiança Alta
> Item de mercadoria exige NCM completo (8 dígitos); item de serviço (NCM '00' ou com código da lista de serviços) está dispensado.

- **Dado** Item com NCM '8471' e sem cListServ
- **Quando** validação de regras
- **Então** erro '777-Rejeição: Obrigatória a informação do NCM completo [nItem: 1]'
- **Parâmetros**: `tamanho_minimo` = 8 · `servico` = NCM = '00' ou ISSQN.cListServ preenchido
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:700-707`; `ACBrNFe\ACBrNFe-change-log.txt:4329`

#### ACBR-NFE-611 · cStat 611 · confiança Alta
> GTIN do produto (cEAN), quando informado e diferente de 'SEM GTIN', tem de ser válido.

- **Dado** Versão 4.00 e cEAN '7891234567890' com DV errado
- **Quando** validação de regras
- **Então** erro '611-Rejeição: GTIN (cEAN) inválido [nItem: 1]'
- **Parâmetros**: `formato` = só dígitos, 8/12/13/14 posições · `dv` = GS1 (pesos 3/1 sobre 13 posições com zeros à esquerda)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:861-876`; `..\ACBrDiversos\ACBrValidador.pas:1924-1974`

#### ACBR-NFE-882 · cStat 882 · confiança Média
> GTIN do produto tem de ter prefixo GS1 conhecido.

- **Dado** cEAN válido no DV com prefixo 140
- **Quando** validação de regras
- **Então** erro '882-Rejeição: GTIN (cEAN) com prefixo inválido [nItem: 1]'
- **Parâmetros**: `tabela` = 127 faixas GS1 embutidas no código (ex.: 789–790 Brasil, 978–979 ISBN)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:877-879`; `..\ACBrDiversos\ACBrValidador.pas:1690-1865`
- **Conferir no MOC**: A tabela de prefixos válida é a do MOC/CCG (NT 2017.001 e atualizações)? Conferir faixas 140–199 e as marcadas 'circulação restrita' (020–029, 040–049, 200–299).

#### ACBR-NFE-885 · cStat 885 · confiança Alta
> Se o GTIN do produto foi informado, o GTIN da unidade tributável também tem de ser.

- **Dado** cEAN '7891000315507' e cEANTrib 'SEM GTIN'
- **Quando** validação de regras
- **Então** erro '885-Rejeição: GTIN informado, mas não informado o GTIN da unidade tributável [nItem: 1]'
- **Parâmetros**: `vazio_equivalente` = '' ou 'SEM GTIN'
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:881-883`

#### ACBR-NFE-612 · cStat 612 · confiança Alta
> GTIN da unidade tributável (cEANTrib), quando informado e diferente de 'SEM GTIN', tem de ser válido.

- **Dado** cEANTrib '17891000315504' com DV errado
- **Quando** validação de regras
- **Então** erro '612-Rejeição: GTIN da unidade tributável (cEANTrib) inválido [nItem: 1]'
- **Parâmetros**: `formato` = igual à 611
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:887-899`

#### ACBR-NFE-884 · cStat 884 · confiança Média
> GTIN da unidade tributável tem de ter prefixo GS1 conhecido.

- **Dado** cEANTrib válido no DV com prefixo 140
- **Quando** validação de regras
- **Então** erro '884-Rejeição: GTIN da unidade tributável (cEANTrib) com prefixo inválido [nItem: 1]'
- **Parâmetros**: `tabela` = a mesma da 882
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:901-903`; `..\ACBrDiversos\ACBrValidador.pas:1690-1865`
- **Conferir no MOC**: Mesma pergunta da 882 (tabela de prefixos oficial).

#### ACBR-NFE-886 · cStat 886 · confiança Alta
> Se o GTIN da unidade tributável foi informado, o GTIN do produto também tem de ser.

- **Dado** cEANTrib '7891000315507' e cEAN vazio
- **Quando** validação de regras
- **Então** erro '886-Rejeição: GTIN da unidade tributável informado, mas não informado o GTIN [nItem: 1]'
- **Parâmetros**: `vazio_equivalente` = '' ou 'SEM GTIN'
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:905-907`

#### ACBR-NFE-889 · cStat 889 · confiança Baixa
> O ACBr recusa item com cEAN vazio ('Obrigatória a informação do GTIN'); como o gerador troca vazio por 'SEM GTIN', a regra só dispara se a validação rodar antes da geração.

- **Dado** Versão 4.00, cEAN vazio, validação chamada antes de Assinar
- **Quando** validação de regras
- **Então** erro '889-Rejeição: Obrigatória a informação do GTIN para o produto [nItem: 1]'
- **Parâmetros**: `gatilho` = cEAN vazio (não considera 'SEM GTIN')
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4; dependente da ordem (ver ACBR-NFE-X15).
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:911-913`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1204-1207`
- **Conferir no MOC**: No MOC a 889 depende do Cadastro Centralizado de GTIN (produto com GTIN cadastrado informado como 'SEM GTIN'). Confirmar a condição oficial — a versão do ACBr é uma aproximação por campo vazio.

#### ACBR-NFE-879 · cStat 879 · confiança Alta
> Item produzido em escala NÃO relevante (indEscala 'N') exige CNPJ do fabricante.

- **Dado** indEscala='N' e CNPJFab vazio
- **Quando** validação de regras
- **Então** erro '879-Rejeição: Informado item Produzido em Escala NÃO Relevante e não informado CNPJ do Fabricante [nItem: 1]'
- **Parâmetros**: `indEscala` = N
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4. O gerador só emite indEscala/CNPJFab com CEST (ver ACBR-NFE-X17).
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:915-918`; `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:1581-1584`

#### ACBR-NFE-489 · cStat 489 · confiança Alta
> CNPJ do fabricante, quando informado, tem de ser válido.

- **Dado** CNPJFab 12345678000100
- **Quando** validação de regras
- **Então** erro '489-Rejeição: CNPJFab informado inválido (DV ou zeros) [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:920-922`

#### ACBR-NFE-854 · cStat 854 · confiança Alta
> GLP (código ANP 210203001) exige unidade tributável 'kg' (sem diferenciar maiúsculas).

- **Dado** cProdANP=210203001 e uTrib='UN'
- **Quando** validação de regras
- **Então** erro '854-Rejeição: Unidade Tributável (tag:uTrib) incompatível com produto informado [nItem: 1]'
- **Parâmetros**: `cProdANP` = 210203001 · `uTrib` = KG (case-insensitive)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:924-926`

#### ACBR-NFE-461 · cStat 461 · confiança Alta
> Percentuais de GLP/gás natural só podem ser informados para o produto GLP.

- **Dado** cProdANP=320102001 e pGLP=50
- **Quando** validação de regras
- **Então** erro '461-Rejeição: Informado campos de percentual de GLP e/ou GLGNn e/ou GLGNi para produto diferente de GLP [nItem: 1]'
- **Parâmetros**: `campos` = pGLP, pGNn, pGNi > 0
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:956-958`

#### ACBR-NFE-855 · cStat 855 · confiança Média
> No GLP, a soma dos percentuais pGLP + pGNn + pGNi tem de ser 100.

- **Dado** cProdANP=210203001, pGLP=60, pGNn=30, pGNi=5
- **Quando** validação de regras
- **Então** erro '855-Rejeição: Somatório percentuais de GLP derivado do petróleo, GLGNn e GLGNi diferente de 100 [nItem: 1]'
- **Parâmetros**: `soma` = 100, comparação exata em ponto flutuante (sem tolerância)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:960-962`
- **Conferir no MOC**: A regra oficial tem tolerância para a soma (percentuais com 4 casas)?

#### ACBR-NFE-877 · cStat 877 · confiança Média
> Data de fabricação do lote (rastro) não pode ser posterior à emissão da nota.

- **Dado** dEmi 10/10/2026 e rastro.dFab 11/10/2026
- **Quando** validação de regras
- **Então** erro '877-Rejeição: Data de fabricação maior que a data de processamento [nItem: 1]'
- **Parâmetros**: `comparacao` = dFab × dEmi (a mensagem diz 'data de processamento')
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:931-935`
- **Conferir no MOC**: A 877 oficial compara dFab com a data de processamento (recebimento) ou com dhEmi?

#### ACBR-NFE-870 · cStat 870 · confiança Alta
> Data de validade do lote não pode ser anterior à data de fabricação.

- **Dado** rastro.dFab 01/10/2026 e dVal 30/09/2026
- **Quando** validação de regras
- **Então** erro '870-Rejeição: Data de validade incompatível com data de fabricação [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:937-939`

#### ACBR-NFE-873 · cStat 873 · confiança Média
> Medicamento (código ANVISA informado) exige grupo de rastreabilidade, salvo exceções de finalidade, presença, CFOP e entrada.

- **Dado** Saída (tpNF 1), finNFe 1, indPres 1, CFOP 5102, med.cProdANVISA preenchido e nenhum rastro
- **Quando** validação de regras
- **Então** erro '873-Rejeição: Operação com medicamentos e não informado os campos de rastreabilidade [nItem: 1]'
- **Parâmetros**: `excecao_finNFe` = 2, 3, 4 · `excecao_indPres` = 2, 3 · `excecao_CFOP` = 5922, 6922, 5118, 6118, 5119, 6119, 5120, 6120 · `excecao_tpNF` = 0
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Só versão ≥ 4.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:942-954`; `ACBrNFe\ACBrNFe-change-log.txt:1554`
- **Conferir no MOC**: Conferir a lista de exceções vigente da 873 (NT 2021.004 e posteriores).

#### ACBR-NFE-X15 · cStat — · confiança Alta
> Na versão 4.00, com emissão após 01/12/2018, cEAN e cEANTrib vazios viram 'SEM GTIN' no objeto e no XML; GTIN preenchido inválido gera alerta (I03/I12) com a mensagem do validador.

- **Dado** Versão 4.00, dEmi 10/10/2026, cEAN vazio
- **Quando** o XML é gerado
- **Então** cEAN = 'SEM GTIN' (o objeto da nota é alterado)
- **Parâmetros**: `data_corte` = 01/12/2018 · `texto` = SEM GTIN
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1204-1217`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1278-1291`

#### ACBR-NFE-X16 · cStat — · confiança Média
> Em homologação, a descrição do item 1 da NFC-e (e da NF-e com DANFE Simplificado Tipo 2) é sobrescrita pelo texto fixo de homologação.

- **Dado** Modelo 65, tpAmb=2, item 1 xProd='Refrigerante 2L'
- **Quando** o XML é gerado
- **Então** xProd = 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL'
- **Parâmetros**: `texto` = NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL · `itens` = só nItem=1
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1191-1193`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1222-1225`
- **Conferir no MOC**: Qual regra/cStat do MOC exige o texto no xProd do 1º item em homologação (NFC-e e NF-e tpImp 6)?

#### ACBR-NFE-X17 · cStat — · confiança Média
> Na versão 4.00, indEscala e CNPJFab só são gerados quando há CEST; sem CEST são descartados em silêncio (as regras 879/489 olham o objeto, não o XML). cBenef é opcional (8 a 10 posições).

- **Dado** Item sem CEST com indEscala='N' e CNPJFab preenchido
- **Quando** o XML é gerado
- **Então** indEscala e CNPJFab omitidos
- **Parâmetros**: `CEST` = 7 dígitos
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1239-1261`
- **Conferir no MOC**: O MOC permite indEscala/CNPJFab sem CEST?

#### ACBR-NFE-X18 · cStat — · confiança Alta
> Limites de ocorrência no nível do item geram alerta quando excedidos.

- **Dado** Nota com 991 itens
- **Quando** o XML é gerado
- **Então** alerta 'H02 nItem ... máximo 990'
- **Parâmetros**: `itens` = 990 · `NVE` = 8 · `DI` = 100 · `adicoes_por_DI` = 999 · `detExport` = 500 · `rastro` = 500 · `med_v4` = 1 · `med_antes_v4` = 500 · `arma` = 500 · `origComb` = 30 · `gCred` = 4
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1187-1188`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1484-1485`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1432-1433`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1465-1466`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1527-1528`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1552-1553`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1659-1665`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1686-1687`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1839-1840`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3491-3492`

#### ACBR-NFE-X19 · cStat — · confiança Alta
> Identificadores especiais do item com formato inválido geram alerta: NVE, nRECOPI, ato concessório de drawback (nDraw), registro de exportação (nRE), UF de desembaraço/terceiro e UF de consumo do combustível.

- **Dado** nRECOPI com 20 posições fora do formato
- **Quando** o XML é gerado
- **Então** alerta 'L109 nRECOPI inválido'
- **Parâmetros**: `validadores` = ValidaNVE, ValidaRECOPI, ValidaDrawback, ValidaRE, ValidarUF
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1361-1365`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1389-1392`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1416-1420`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1458-1463`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1477-1481`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1504-1518`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1763-1767`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1882-1885`

### 5.6 ICMS/ST — 5 cards

#### ACBR-NFE-528 · cStat 528 · confiança Média
> Nas CST 00, 10, 20 e 70 de nota normal, o valor do ICMS tem de ser base × alíquota, com até 1 centavo de diferença.

- **Dado** finNFe=1, CST 00, vBC 100,00, pICMS 18,00, vICMS 18,02
- **Quando** validação de regras
- **Então** erro '528-Rejeição: Valor do ICMS difere do produto BC e Alíquota [nItem: 1]' (diferença 0,02 > 0,01)
- **Parâmetros**: `CST` = 00, 10, 20, 70 · `finNFe` = 1 · `tolerancia` = 0,01 · `formula` = vBC × pICMS / 100
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:836-840`
- **Conferir no MOC**: Confirmar no MOC a lista de CST (51/90 ficam fora?), o arredondamento e a tolerância oficial da 528.

#### ACBR-NFE-625 · cStat 625 · confiança Alta
> Desoneração do ICMS por SUFRAMA (motDesICMS 7) exige inscrição SUFRAMA do destinatário.

- **Dado** Item com motDesICMS=7 e dest.ISUF vazio
- **Quando** validação de regras
- **Então** erro '625-Rejeição: Inscrição SUFRAMA deve ser informada na venda com isenção para ZFM [nItem: 1]'
- **Parâmetros**: `motDesICMS` = 7 (SUFRAMA)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:842-845`

#### ACBR-NFE-938 · cStat 938 · confiança Média
> Para evitar a rejeição 938, o grupo do ICMS-ST retido anteriormente (vBCSTRet, pST, vICMSSubstituto, vICMSSTRet) pode ser forçado no XML para CST 60, repasse de ST (ST41/ST60) e CSOSN 500 — por configuração, não por regra.

- **Dado** CST 60 com todos os valores retidos zerados e ForcarGerarTagRejeicao938='Somente produção' em tpAmb=1
- **Quando** o XML é gerado
- **Então** o grupo é emitido com os quatro campos (zerados); com 'Nunca' (padrão) e valores zerados, o grupo é omitido
- **Parâmetros**: `opcoes` = Nunca (padrão) | Sempre | Somente produção | Somente homologação · `referencia` = NT 2018.005 v1.20 — campos N26, N26a, N26b
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro. Liga por Configuracoes.Geral.ForcarGerarTagRejeicao938 (ini: TagNT2018005).
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:69-71`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1978-1990`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:2439-2463`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:2725-2735`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:2868-2884`; `ACBrNFe\ACBrNFeConfiguracoes.pas:58`; `ACBrNFe\ACBrNFeConfiguracoes.pas:82`; `ACBrNFe\ACBrNFeConfiguracoes.pas:205`; `ACBrNFe\ACBrNFe-change-log.txt:2294-2296`
- **Conferir no MOC**: Quando o grupo de ST retido é obrigatório pela 938 (consumidor final? UF? CST/CSOSN)? O ACBr transfere a decisão para a configuração.

#### ACBR-NFE-906 · cStat 906 · confiança Média
> Para evitar a rejeição 906, o grupo do ICMS efetivo (pRedBCEfet, vBCEfet, pICMSEfet, vICMSEfet) pode ser forçado no XML em venda a consumidor final — por configuração.

- **Dado** indFinal=1, CST 60 sem valores efetivos e ForcarGerarTagRejeicao906='Sempre'
- **Quando** o XML é gerado
- **Então** o grupo efetivo é emitido (com zeros); com 'Nunca' (padrão) só aparece se algum valor > 0
- **Parâmetros**: `opcoes` = Nunca (padrão) | Sempre | Somente produção | Somente homologação · `condicao` = indFinal=1
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro. Liga por Configuracoes.Geral.ForcarGerarTagRejeicao906.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1992-2004`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:2479-2480`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:2752-2753`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:2899-2900`; `ACBrNFe\ACBrNFeConfiguracoes.pas:59`; `ACBrNFe\ACBrNFeConfiguracoes.pas:83`; `ACBrNFe\ACBrNFeConfiguracoes.pas:206`
- **Conferir no MOC**: Quais UFs exigem o grupo ICMS efetivo (906) e em quais CST/CSOSN?

#### ACBR-NFE-X20 · cStat — · confiança Alta
> Item de serviço (com situação tributária do ISSQN ou código de serviço) não recebe grupos ICMS nem II — leva IPI e ISSQN; o grupo de partilha interestadual (ICMSUFDest/DIFAL) só é gerado com pICMSInterPart > 0.

- **Dado** Item com ISSQN.cListServ '01.07' e ICMS preenchido no objeto
- **Quando** o XML é gerado
- **Então** grupo ICMS omitido; IPI e ISSQN gerados
- **Parâmetros**: `servico_no_gerador` = ISSQN.cSitTrib preenchido ou (versão > 3 e cListServ preenchido) — critério DIFERENTE do validador (NCM '00' ou cListServ)
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1915-1934`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:700`

### 5.7 IPI/PIS/COFINS — 3 cards

#### ACBR-NFE-X21 · cStat — · confiança Média
> O grupo IPI nunca é gerado na NFC-e; no 55 é omitido para CST não tributado quando GerarTagIPIparaNaoTributado=False e quando tudo está zerado com CST 00 e sem enquadramento; enquadramento vazio vira '999'.

- **Dado** Modelo 55, IPI CST 00, cEnq vazio, vBC 100,00, pIPI 10,00
- **Quando** o XML é gerado
- **Então** grupo IPI com cEnq='999'
- **Parâmetros**: `GerarTagIPIparaNaoTributado` = True (padrão) · `CST_tributados` = 00, 49, 50, 99 · `cEnq_padrao` = 999
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:2985-3024`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:263`
- **Conferir no MOC**: O MOC aceita cEnq '999' como padrão genérico (tabela de enquadramento legal do IPI)?

#### ACBR-NFE-X22 · cStat — · confiança Alta
> IPI tributado não pode misturar cálculo por alíquota (vBC/pIPI) com cálculo por unidade (qUnid/vUnid).

- **Dado** IPI CST 50 com vBC 100,00, pIPI 5 e qUnid 2
- **Quando** o XML é gerado
- **Então** alerta 'O07 IPITrib — As TAG vBC e pIPI não podem ser informadas em conjunto com as TAG qUnid e vUnid'
- **Parâmetros**: —
- **Modelos**: 55
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3025-3031`

#### ACBR-NFE-X23 · cStat — · confiança Alta
> PIS, PIS-ST, COFINS e COFINS-ST não podem misturar cálculo por alíquota (vBC/percentual) com cálculo por quantidade (qBCProd/vAliqProd).

- **Dado** PIS CST 99 com vBC 100,00, pPIS 1,65 e qBCProd 10
- **Quando** o XML é gerado
- **Então** alerta 'Q05 PISOutr — As TAG vBC e pPIS não podem ser informadas em conjunto com as TAG qBCProd e vAliqProd' (idem R01, S05, T01)
- **Parâmetros**: `CST_PIS_COFINS_outros` = 49–56, 60–67, 70–75, 98, 99
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3131-3139`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3171-3179`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3300-3308`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3342-3351`

### 5.8 Totais — 22 cards

#### ACBR-NFE-531 · cStat 531 · confiança Alta
> Total da base de cálculo do ICMS = soma das bases dos itens que compõem o total (indTot 1).

- **Dado** Itens indTot=1 com vBC 100,00 e 50,00; ICMSTot.vBC 149,99
- **Quando** validação de regras
- **Então** erro '531-Rejeição: Total da BC ICMS difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 (exato ao centavo) · `itens` = indTot=1
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:987-990`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1039-1041`; `..\ACBrComum\ACBrUtil.Math.pas:229-242`

#### ACBR-NFE-532 · cStat 532 · confiança Alta
> Total do ICMS = soma do ICMS dos itens com indTot 1.

- **Dado** Itens indTot=1 com vICMS 18,00 e 9,00; ICMSTot.vICMS 27,01
- **Quando** validação de regras
- **Então** erro '532-Rejeição: Total do ICMS difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = indTot=1
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:991`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1043-1045`

#### ACBR-NFE-795 · cStat 795 · confiança Média
> Total do ICMS desonerado = soma do ICMS desonerado de TODOS os itens (independe de indTot).

- **Dado** Item 1 (indTot=0) vICMSDeson 5,00 e item 2 vICMSDeson 3,00; ICMSTot.vICMSDeson 3,00
- **Quando** validação de regras
- **Então** erro '795-Rejeição: Total do ICMS desonerado difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:974`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1047-1049`
- **Conferir no MOC**: A soma oficial do vICMSDeson considera itens com indTot=0?

#### ACBR-NFE-533 · cStat 533 · confiança Alta
> Total da base do ICMS-ST = soma das bases ST dos itens com indTot 1.

- **Dado** Itens indTot=1 com vBCST 120,00 e 0,00; ICMSTot.vBCST 0,00
- **Quando** validação de regras
- **Então** erro '533-Rejeição: Total da BC ICMS-ST difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = indTot=1
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:992`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1051-1053`

#### ACBR-NFE-534 · cStat 534 · confiança Alta
> Total do ICMS-ST = soma do ICMS-ST dos itens com indTot 1.

- **Dado** Itens indTot=1 com vICMSST 3,60; ICMSTot.vST 3,59
- **Quando** validação de regras
- **Então** erro '534-Rejeição: Total do ICMS-ST difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = indTot=1
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:993`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1055-1057`

#### ACBR-NFE-564 · cStat 564 · confiança Média
> Total dos produtos = soma de vProd dos itens com indTot 1 que não são serviço; na nota de ajuste (finNFe 3) os serviços também somam.

- **Dado** finNFe=1, item mercadoria vProd 100,00 e item serviço (NCM '00') vProd 50,00; ICMSTot.vProd 150,00
- **Quando** validação de regras
- **Então** erro '564-Rejeição: Total do Produto / Serviço difere do somatório dos itens' (esperado 100,00)
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = indTot=1 e (não serviço ou finNFe=3) · `servico` = NCM '00' ou cListServ preenchido
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:700`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1005-1007`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1059-1061`; `ACBrNFe\ACBrNFe-change-log.txt:4332`
- **Conferir no MOC**: A exceção 'nota de ajuste soma serviço' é do MOC? E o critério de serviço (NCM '00' ou cListServ) é o oficial?

#### ACBR-NFE-535 · cStat 535 · confiança Alta
> Total do frete = soma do frete de todos os itens (independe de indTot).

- **Dado** Itens com vFrete 10,00 e 5,00; ICMSTot.vFrete 10,00
- **Quando** validação de regras
- **Então** erro '535-Rejeição: Total do Frete difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:967`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1063-1065`

#### ACBR-NFE-536 · cStat 536 · confiança Alta
> Total do seguro = soma do seguro de todos os itens.

- **Dado** Itens com vSeg 2,00 e 2,00; ICMSTot.vSeg 2,00
- **Quando** validação de regras
- **Então** erro '536-Rejeição: Total do Seguro difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:968`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1067-1069`

#### ACBR-NFE-537 · cStat 537 · confiança Alta
> Total do desconto = soma do desconto de todos os itens.

- **Dado** Itens com vDesc 1,00 e 1,50; ICMSTot.vDesc 2,00
- **Quando** validação de regras
- **Então** erro '537-Rejeição: Total do Desconto difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:970`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1071-1073`

#### ACBR-NFE-601 · cStat 601 · confiança Alta
> Total do imposto de importação = soma do II de todos os itens.

- **Dado** Item com vII 40,00; ICMSTot.vII 0,00
- **Quando** validação de regras
- **Então** erro '601-Rejeição: Total do II difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:971`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1075-1077`

#### ACBR-NFE-538 · cStat 538 · confiança Alta
> Total do IPI = soma do IPI de todos os itens.

- **Dado** Itens com vIPI 5,00 e 2,50; ICMSTot.vIPI 7,00
- **Quando** validação de regras
- **Então** erro '538-Rejeição: Total do IPI difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:972`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1079-1081`

#### ACBR-NFE-602 · cStat 602 · confiança Média
> Total do PIS (grupo ICMSTot) = soma do PIS dos itens que NÃO são serviço.

- **Dado** Mercadoria com vPIS 1,65 e serviço (cListServ) com vPIS 0,65; ICMSTot.vPIS 2,30
- **Quando** validação de regras
- **Então** erro '602-Rejeição: Total do PIS difere do somatório dos itens sujeitos ao ICMS' (esperado 1,65)
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos os não-serviço (independe de indTot)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:976-985`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1083-1085`
- **Conferir no MOC**: A soma oficial do vPIS em ICMSTot considera itens com indTot=0?

#### ACBR-NFE-603 · cStat 603 · confiança Média
> Total da COFINS (grupo ICMSTot) = soma da COFINS dos itens que NÃO são serviço.

- **Dado** Mercadoria com vCOFINS 7,60; ICMSTot.vCOFINS 7,59
- **Quando** validação de regras
- **Então** erro '603-Rejeição: Total da COFINS difere do somatório dos itens sujeitos ao ICMS'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos os não-serviço
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:976-985`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1087-1089`
- **Conferir no MOC**: Mesma pergunta da 602 (indTot=0).

#### ACBR-NFE-604 · cStat 604 · confiança Alta
> Total de outras despesas acessórias = soma de vOutro de todos os itens.

- **Dado** Itens com vOutro 3,00; ICMSTot.vOutro 0,00
- **Quando** validação de regras
- **Então** erro '604-Rejeição: Total do vOutro difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:969`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1091-1093`

#### ACBR-NFE-608 · cStat 608 · confiança Alta
> Total do PIS sobre serviços (grupo ISSQNtot) = soma do PIS dos itens de serviço.

- **Dado** Serviço com vPIS 0,65; ISSQNtot.vPIS 0,00
- **Quando** validação de regras
- **Então** erro '608-Rejeição: Total do PIS difere do somatório dos itens sujeitos ao ISSQN'
- **Parâmetros**: `tolerancia` = 0,001 · `servico` = NCM '00' ou cListServ
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:976-980`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1095-1097`

#### ACBR-NFE-609 · cStat 609 · confiança Alta
> Total da COFINS sobre serviços (ISSQNtot) = soma da COFINS dos itens de serviço.

- **Dado** Serviço com vCOFINS 3,00; ISSQNtot.vCOFINS 0,00
- **Quando** validação de regras
- **Então** erro '609-Rejeição: Total da COFINS difere do somatório dos itens sujeitos ao ISSQN'
- **Parâmetros**: `tolerancia` = 0,001 · `servico` = NCM '00' ou cListServ
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:976-980`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1099-1101`

#### ACBR-NFE-861 · cStat 861 · confiança Alta
> Total do FCP = soma do FCP dos itens com indTot 1.

- **Dado** Item indTot=1 com vFCP 2,00; ICMSTot.vFCP 0,00
- **Quando** validação de regras
- **Então** erro '861-Rejeição: Total do FCP difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = indTot=1
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:994`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1103-1105`

#### ACBR-NFE-862 · cStat 862 · confiança Alta
> Total do FCP-ST = soma do FCP-ST dos itens com indTot 1 (só NF-e).

- **Dado** Modelo 55, item com vFCPST 1,20; ICMSTot.vFCPST 0,00
- **Quando** validação de regras
- **Então** erro '862-Rejeição: Total do FCP ST difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = indTot=1
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:995`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1107-1111`

#### ACBR-NFE-859 · cStat 859 · confiança Alta
> Total do FCP retido anteriormente por ST = soma dos itens com indTot 1 (só NF-e).

- **Dado** Modelo 55, item com vFCPSTRet 0,80; ICMSTot.vFCPSTRet 0,00
- **Quando** validação de regras
- **Então** erro '859-Rejeição: Total do FCP retido anteriormente por Substituição Tributária difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = indTot=1
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:996`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1113-1115`

#### ACBR-NFE-863 · cStat 863 · confiança Alta
> Total do IPI devolvido = soma de vIPIDevol de todos os itens (só NF-e).

- **Dado** Modelo 55, item com vIPIDevol 4,00; ICMSTot.vIPIDevol 0,00
- **Quando** validação de regras
- **Então** erro '863-Rejeição: Total do IPI devolvido difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:973`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1117-1119`

#### ACBR-NFE-610 · cStat 610 · confiança Média
> Valor total da nota = produtos + ST + frete + seguro + outras + II + IPI + serviços + FCP-ST + ICMS monofásico retido + IPI devolvido + PIS-ST/COFINS-ST que compõem − (desconto + ICMS desonerado); aceita também a versão sem abater o desonerado; dispensada se houver item de importação.

- **Dado** vProd 100,00, vST 10,00, vFrete 5,00, vDesc 2,00, demais zero; vNF 112,50
- **Quando** validação de regras
- **Então** erro '610-Rejeição: Total da NF difere do somatório dos Valores compõe o valor Total da NF.' (esperado 113,00)
- **Parâmetros**: `tolerancia` = 0,009 (filtro inicial 0,001) · `formula_normal` = vProd + vST + vFrete + vSeg + vOutro + vII + vIPI + vServ + vFCPST + vICMSMonoReten + vIPIDevol + vPISST + vCOFINSST − (vDesc + vICMSDeson) · `formula_faturamento_direto_veiculo` = vProd + vFrete + vSeg + vOutro + vII + vIPI + vServ + vPISST + vCOFINSST − (vDesc + vICMSDeson) · `alternativa_aceita` = vNF = fórmula + vICMSDeson · `dispensa` = algum item com CFOP iniciado por '3' · `vServ` = lido do total ISSQNtot.vServ (605 por item não implementada) · `nao_entra` = IBS, CBS, IS (Reforma)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1010-1014`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1018-1019`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1031-1037`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1122-1128`; `ACBrNFe\ACBrNFe-change-log.txt:1366`; `ACBrNFe\ACBrNFe-change-log.txt:1670`
- **Conferir no MOC**: Conferir a fórmula oficial do vNF (NT 2020.005 e RTC): o desonerado abate ou não por UF? IBS/CBS/IS entram em vNF ou só em vNFTot? Importação é mesmo dispensada?

#### ACBR-NFE-685 · cStat 685 · confiança Alta
> Total do valor aproximado dos tributos = soma de vTotTrib de todos os itens.

- **Dado** Itens com vTotTrib 12,00 e 6,00; ICMSTot.vTotTrib 17,00
- **Quando** validação de regras
- **Então** erro '685-Rejeição: Total do Valor Aproximado dos Tributos difere do somatório dos itens'
- **Parâmetros**: `tolerancia` = 0,001 · `itens` = todos
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:966`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1130-1132`

### 5.9 Pagamento e cobrança — 13 cards

#### ACBR-NFE-768 · cStat 768 · confiança Alta
> NF-e de leiaute anterior a 4.00 não pode ter grupo de pagamento.

- **Dado** Modelo 55, versão 3.10, com 1 pag
- **Quando** validação de regras
- **Então** erro '768-Rejeição: NF-e não deve possuir o grupo de Formas de Pagamento'
- **Parâmetros**: `versao` = < 4
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:244-249`

#### ACBR-NFE-769 · cStat 769 · confiança Alta
> Grupo de formas de pagamento obrigatório: NF-e a partir da 4.00 e NFC-e sempre.

- **Dado** Modelo 55, versão 4.00, sem pag
- **Quando** validação de regras
- **Então** erro '769-Rejeição: NF-e deve possuir o grupo de Formas de Pagamento' (no 65: 'NFC-e deve possuir...')
- **Parâmetros**: `55` = versão ≥ 4 · `65` = qualquer versão
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:250-255`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:451-453`

#### ACBR-NFE-866 · cStat 866 · confiança Alta
> Se os pagamentos somam mais que o total da nota, o troco tem de ser informado.

- **Dado** Versão 4.00, finNFe 1, vNF 95,00, pag 100,00, vTroco 0
- **Quando** validação de regras
- **Então** erro '866-Rejeição: Ausência de troco quando o valor dos pagamentos informados for maior que o total da nota'
- **Parâmetros**: `finNFe` = 1, 2 · `tolerancia` = 0,001
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1146-1155`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1181-1183`

#### ACBR-NFE-869 · cStat 869 · confiança Alta
> Com troco informado, total da nota = soma dos pagamentos − troco.

- **Dado** Versão 4.00, vNF 95,00, pag 100,00, vTroco 4,00
- **Quando** validação de regras
- **Então** erro '869-Rejeição: Valor do troco incorreto' (esperado 5,00)
- **Parâmetros**: `finNFe` = 1, 2 · `tolerancia` = 0,001
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1185-1187`

#### ACBR-NFE-871 · cStat 871 · confiança Alta
> NF-e de devolução só pode ter meio de pagamento 'Sem pagamento' (90).

- **Dado** Versão 4.00, finNFe=4 e pag com tPag 01 (dinheiro)
- **Quando** validação de regras
- **Então** erro '871-Rejeição: O campo Meio de Pagamento deve ser preenchido com a opção Sem Pagamento' (um erro por pag)
- **Parâmetros**: `tPag_exigido` = 90
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1191-1199`; `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:884-890`

#### ACBR-NFE-895 · cStat 895 · confiança Alta
> Desconto da fatura não pode exceder o valor original da fatura.

- **Dado** Modelo 55, versão 4.00, finNFe 1, fat.vOrig 100,00 e vDesc 100,01
- **Quando** validação de regras
- **Então** erro '895-Rejeição: Valor do Desconto da Fatura maior que Valor Original da Fatura'
- **Parâmetros**: `finNFe` = 1, 2 · `tolerancia` = 0,001
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:272-276`

#### ACBR-NFE-902 · cStat 902 · confiança Alta
> Valor líquido da fatura = valor original − desconto.

- **Dado** fat.vOrig 100,00, vDesc 10,00, vLiq 91,00
- **Quando** validação de regras
- **Então** erro '902-Rejeição: Valor Liquido da Fatura difere do Valor Original menos o Valor do Desconto'
- **Parâmetros**: `finNFe` = 1, 2 · `tolerancia` = 0,001
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:278-280`

#### ACBR-NFE-857 · cStat 857 · confiança Alta
> Toda parcela de cobrança (dup) exige número da parcela.

- **Dado** dup com nDup vazio
- **Quando** validação de regras
- **Então** erro '857-Rejeição: Número da parcela inválido ou não informado' (um por parcela)
- **Parâmetros**: `finNFe` = 1, 2
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:293-295`

#### ACBR-NFE-894 · cStat 894 · confiança Alta
> Vencimento de parcela não pode ser anterior à data de emissão (compara só a data).

- **Dado** dEmi 10/10/2026 15:00 e dup.dVenc 09/10/2026
- **Quando** validação de regras
- **Então** erro '894-Rejeição: Data de vencimento da parcela não informada ou menor que Data de Emissão'
- **Parâmetros**: `comparacao` = dVenc × DateOf(dEmi)
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:288`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:299-301`

#### ACBR-NFE-867 · cStat 867 · confiança Alta
> Vencimentos das parcelas têm de estar em ordem não decrescente.

- **Dado** dup 1 vence 10/11/2026 e dup 2 vence 05/11/2026
- **Quando** validação de regras
- **Então** erro '867-Rejeição: Data de vencimento da parcela não informada ou menor que a Data de vencimento da parcela anterior'
- **Parâmetros**: `primeira_parcela` = comparada com a data de emissão
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:287-308`

#### ACBR-NFE-851 · cStat 851 · confiança Média
> A soma das parcelas não pode ficar abaixo do valor líquido da fatura (nem de original − desconto); soma acima não é recusada.

- **Dado** fat.vOrig 100,00, vDesc 0, vLiq 100,00 e parcelas 50,00 + 49,99
- **Quando** validação de regras
- **Então** erro '851-Rejeição: Soma do valor das parcelas difere do Valor Líquido da Fatura'
- **Parâmetros**: `condicao` = há dup e ((vLiq > 0 e soma < vLiq) ou soma < vOrig − vDesc) · `tolerancia` = 0,001
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:310-314`
- **Conferir no MOC**: A 851 oficial diz 'difere': parcelas que somam MAIS que vLiq também são rejeitadas?

#### ACBR-NFE-X24 · cStat — · confiança Alta
> O grupo fatura só existe se algum campo estiver preenchido; com CamposFatObrigatorios (padrão True) e versão 4.00, nFat, vOrig, vDesc e vLiq saem sempre, mesmo zerados.

- **Dado** fat com nFat '123' e vOrig 100,00, vDesc 0
- **Quando** o XML é gerado
- **Então** fat com nFat, vOrig 100.00, vDesc 0.00, vLiq (informado)
- **Parâmetros**: `CamposFatObrigatorios` = True (padrão)
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro. Configuracoes.Geral.CamposFatObrigatorios.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3680-3693`; `ACBrNFe\ACBrNFeConfiguracoes.pas:57`; `ACBrNFe\ACBrNFeConfiguracoes.pas:80-81`; `ACBrNFe\ACBrNFeConfiguracoes.pas:204`

#### ACBR-NFE-X25 · cStat — · confiança Alta
> Na versão 4.00 cada parcela (dup) sai com nDup e dVenc obrigatórios.

- **Dado** Versão 4.00, dup sem dVenc
- **Quando** o XML é gerado
- **Então** alerta de campo obrigatório vazio em Y09 (o XSD também recusa)
- **Parâmetros**: —
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3695-3715`

### 5.10 Transporte — 6 cards

#### ACBR-NFE-542 · cStat 542 · confiança Alta
> CNPJ do transportador, quando informado, tem de ser válido.

- **Dado** transporta.CNPJ 11222333000180
- **Quando** validação de regras
- **Então** erro '542-Rejeição: CNPJ do Transportador inválido'
- **Parâmetros**: `gatilho` = 14 ou mais posições
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:631-635`

#### ACBR-NFE-543 · cStat 543 · confiança Alta
> CPF do transportador, quando informado, tem de ser válido.

- **Dado** transporta.CPF 12345678900
- **Quando** validação de regras
- **Então** erro '543-Rejeição: CPF do Transportador inválido'
- **Parâmetros**: `gatilho` = até 11 posições
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:637-641`

#### ACBR-NFE-559 · cStat 559 · confiança Alta
> IE do transportador exige UF do transportador.

- **Dado** transporta.IE '1234567890' e UF vazia
- **Quando** validação de regras
- **Então** erro '559-Rejeição: UF do Transportador não informada'
- **Parâmetros**: —
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:643-646`

#### ACBR-NFE-544 · cStat 544 · confiança Alta
> IE do transportador, quando informada, tem de ser válida para a UF do transportador ('ISENTO' é aceito).

- **Dado** transporta.UF='PR' e IE com DV errado
- **Quando** validação de regras
- **Então** erro '544-Rejeição: IE do Transportador inválida'
- **Parâmetros**: `ISENTO` = aceito
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:648-651`; `..\ACBrDiversos\ACBrValidador.pas:1131-1132`

#### ACBR-NFE-868 · cStat 868 · confiança Alta
> Operação interestadual não pode informar veículo de transporte nem reboque.

- **Dado** Versão 4.00, idDest=2 e veicTransp.placa 'ABC1D23'
- **Quando** validação de regras
- **Então** erro '868-Rejeição: Grupos Veiculo Transporte e Reboque não devem ser informados'
- **Parâmetros**: `idDest` = 2 · `campos` = placa, UF ou RNTC do veículo; qualquer reboque
- **Modelos**: 55
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:264-270`

#### ACBR-NFE-X26 · cStat — · confiança Alta
> Transporte: UF do transportador, do veículo e dos reboques inexistentes, e município do fato gerador da retenção com DV inválido geram alerta; IE do transportador só é checada com ValidarInscricoes.

- **Dado** veicTransp.UF='XX'
- **Quando** o XML é gerado
- **Então** alerta 'X20 UF inválido'
- **Parâmetros**: `retTransp` = grupo gerado se qualquer valor > 0 ou CFOP/cMunFG preenchido
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3815-3900`

### 5.11 NFC-e — 45 cards

#### ACBR-NFE-789 · cStat 789 · confiança Alta
> NFC-e só para destinatário não contribuinte do ICMS (indIEDest 9).

- **Dado** Modelo 65 e indIEDest=1
- **Quando** validação de regras
- **Então** erro '789-Rejeição: NFC-e para destinatário contribuinte de ICMS'
- **Parâmetros**: `indIEDest_exigido` = 9
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:321`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1314-1319`

#### ACBR-NFE-704 · cStat 704 · confiança Média
> NFC-e emitida em modo normal ou SVC não pode ter data/hora de emissão mais de 10 minutos atrás.

- **Dado** Modelo 65, tpEmis=1, Agora 12:00 e dEmi 11:49
- **Quando** validação de regras
- **Então** erro '704-Rejeição: NFC-e com Data-Hora de emissão atrasada'
- **Parâmetros**: `atraso_maximo_minutos` = 10 · `tpEmis` = 1, 3, 6, 7 (off-line 9 fica fora)
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:323-327`
- **Conferir no MOC**: Confirmar o atraso máximo oficial da dhEmi da NFC-e (o ACBr usa 10 minutos) e se há variação por UF.

#### ACBR-NFE-705 · cStat 705 · confiança Alta
> NFC-e não tem data de saída/entrada.

- **Dado** Modelo 65 com dSaiEnt preenchida
- **Quando** validação de regras
- **Então** erro '705-Rejeição: NFC-e com data de entrada/saída'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. O gerador já omite dhSaiEnt no 65 (ACBR-NFE-X06).
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:329-331`

#### ACBR-NFE-706 · cStat 706 · confiança Alta
> NFC-e não pode ser de entrada.

- **Dado** Modelo 65 e tpNF=0
- **Quando** validação de regras
- **Então** erro '706-Rejeição: NFC-e para operação de entrada'
- **Parâmetros**: `tpNF_exigido` = 1
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:333-335`; `ACBrDFe.Conversao.pas:217-220`

#### ACBR-NFE-707 · cStat 707 · confiança Alta
> NFC-e só para operação interna.

- **Dado** Modelo 65 e idDest=2
- **Quando** validação de regras
- **Então** erro '707-NFC-e para operação interestadual ou com o exterior'
- **Parâmetros**: `idDest_exigido` = 1
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:337-339`

#### ACBR-NFE-709 · cStat 709 · confiança Alta
> NFC-e só com formato de DANFE NFC-e (4) ou mensagem eletrônica (5).

- **Dado** Modelo 65 e tpImp=1
- **Quando** validação de regras
- **Então** erro '709-Rejeição: NFC-e com formato de DANFE inválido'
- **Parâmetros**: `tpImp_aceitos` = 4, 5
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:341-344`

#### ACBR-NFE-782 · cStat 782 · confiança Alta
> NFC-e não é autorizada pelo SCAN.

- **Dado** Modelo 65 e tpEmis=3
- **Quando** validação de regras
- **Então** erro '782-Rejeição: NFC-e não é autorizada pelo SCAN'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:346-348`

#### ACBR-NFE-783 · cStat 783 · confiança Alta
> NFC-e não é autorizada pela SVC.

- **Dado** Modelo 65 e tpEmis=6
- **Quando** validação de regras
- **Então** erro '783-Rejeição: NFC-e não é autorizada pela SVC'
- **Parâmetros**: `tpEmis` = 6, 7
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:350-352`

#### ACBR-NFE-715 · cStat 715 · confiança Alta
> NFC-e só com finalidade normal.

- **Dado** Modelo 65 e finNFe=4
- **Quando** validação de regras
- **Então** erro '715-Rejeição: NFC-e com finalidade inválida'
- **Parâmetros**: `finNFe_exigido` = 1
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:354-356`

#### ACBR-NFE-716 · cStat 716 · confiança Alta
> NFC-e só para consumidor final.

- **Dado** Modelo 65 e indFinal=0
- **Quando** validação de regras
- **Então** erro '716-Rejeição: NFC-e em operação não destinada a consumidor final'
- **Parâmetros**: `indFinal_exigido` = 1
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:358-360`

#### ACBR-NFE-717 · cStat 717 · confiança Alta
> NFC-e só presencial (1) ou entrega a domicílio (4).

- **Dado** Modelo 65 e indPres=2
- **Quando** validação de regras
- **Então** erro '717-Rejeição: NFC-e em operação não presencial'
- **Parâmetros**: `indPres_aceitos` = 1, 4
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:362-365`; `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:869-874`

#### ACBR-NFE-785 · cStat 785 · confiança Baixa
> NFC-e com entrega a domicílio em UF que não permite — no ACBr a lista de UFs é um marcador ('XX') e a regra nunca dispara.

- **Dado** Modelo 65, indPres=4 e emitente de qualquer UF real
- **Quando** validação de regras
- **Então** nenhum erro (lista vazia de fato)
- **Parâmetros**: `lista_UF` = ['XX'] (marcador; comentário pergunta qual estado não permite)
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. Inerte.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:367-371`
- **Conferir no MOC**: Quais UFs não permitem NFC-e com entrega a domicílio (indPres 4)? A lista tem de vir do MOC/NT.

#### ACBR-NFE-708 · cStat 708 · confiança Alta
> NFC-e não pode referenciar documento fiscal.

- **Dado** Modelo 65 com 1 NFref
- **Quando** validação de regras
- **Então** erro '708-Rejeição: NFC-e não pode referenciar documento fiscal'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:373-375`

#### ACBR-NFE-718 · cStat 718 · confiança Alta
> NFC-e não informa IE de substituto tributário do emitente.

- **Dado** Modelo 65 com emit.IEST preenchida
- **Quando** validação de regras
- **Então** erro '718-Rejeição: NFC-e não deve informar IE de Substituto Tributário'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:377-379`

#### ACBR-NFE-787 · cStat 787 · confiança Alta
> NFC-e com entrega a domicílio exige endereço (do local de entrega ou do destinatário).

- **Dado** Modelo 65, indPres=4, sem entrega.xLgr e sem enderDest.xLgr
- **Quando** validação de regras
- **Então** erro '787-Rejeição: NFC-e de entrega a domicílio sem a identificação do destinatário'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:381-385`

#### ACBR-NFE-729 · cStat 729 · confiança Alta
> NFC-e não informa IE do destinatário.

- **Dado** Modelo 65 com dest.IE preenchida
- **Quando** validação de regras
- **Então** erro '729-Rejeição: NFC-e com informação da IE do destinatário'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:387-389`

#### ACBR-NFE-730 · cStat 730 · confiança Alta
> NFC-e não informa inscrição SUFRAMA.

- **Dado** Modelo 65 com dest.ISUF preenchida
- **Quando** validação de regras
- **Então** erro '730-Rejeição: NFC-e com Inscrição Suframa'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:391-393`

#### ACBR-NFE-753 · cStat 753 · confiança Alta
> NFC-e sem entrega a domicílio tem de ser 'sem frete' (modFrete 9).

- **Dado** Modelo 65, indPres=1 e modFrete=0
- **Quando** validação de regras
- **Então** erro '753-Rejeição: NFC-e com Frete'
- **Parâmetros**: `modFrete_exigido` = 9 · `excecao` = indPres=4
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:395-398`

#### ACBR-NFE-754 · cStat 754 · confiança Alta
> NFC-e sem entrega a domicílio não informa transportador.

- **Dado** Modelo 65, indPres=1 e transporta.xNome='Transportes X'
- **Quando** validação de regras
- **Então** erro '754-Rejeição: NFC-e com dados do Transportador'
- **Parâmetros**: `campos` = CNPJ/CPF, xNome, IE, xEnder, xMun, UF
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:400-408`

#### ACBR-NFE-786 · cStat 786 · confiança Alta
> NFC-e com entrega a domicílio exige CNPJ/CPF e nome do transportador.

- **Dado** Modelo 65, indPres=4 e transportador sem CNPJ/CPF
- **Quando** validação de regras
- **Então** erro '786-Rejeição: NFC-e de entrega a domicílio sem dados do Transportador'
- **Parâmetros**: `campos_exigidos` = CNPJ/CPF e xNome
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:410-414`

#### ACBR-NFE-755 · cStat 755 · confiança Alta
> NFC-e não tem retenção de ICMS no transporte.

- **Dado** Modelo 65 com retTransp.vServ 50,00
- **Quando** validação de regras
- **Então** erro '755-Rejeição: NFC-e com dados de Retenção do ICMS no Transporte'
- **Parâmetros**: `campos` = vServ, vBCRet, pICMSRet, vICMSRet, CFOP, cMunFG
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:416-423`

#### ACBR-NFE-756 · cStat 756 · confiança Alta
> NFC-e não informa veículo de transporte.

- **Dado** Modelo 65 com veicTransp.placa
- **Quando** validação de regras
- **Então** erro '756-Rejeição: NFC-e com dados do veículo de Transporte'
- **Parâmetros**: `campos` = placa, UF, RNTC
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:425-429`

#### ACBR-NFE-757 · cStat 757 · confiança Alta
> NFC-e não informa reboque.

- **Dado** Modelo 65 com 1 reboque
- **Quando** validação de regras
- **Então** erro '757-Rejeição: NFC-e com dados de Reboque do veículo de Transporte'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:431-433`

#### ACBR-NFE-758 · cStat 758 · confiança Alta
> NFC-e não informa vagão.

- **Dado** Modelo 65 com transp.vagao
- **Quando** validação de regras
- **Então** erro '758-Rejeição: NFC-e com dados do Vagão de Transporte'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:435-437`

#### ACBR-NFE-759 · cStat 759 · confiança Alta
> NFC-e não informa balsa.

- **Dado** Modelo 65 com transp.balsa
- **Quando** validação de regras
- **Então** erro '759-Rejeição: NFC-e com dados da Balsa de Transporte'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:439-441`

#### ACBR-NFE-760 · cStat 760 · confiança Alta
> NFC-e não tem cobrança (fatura/duplicatas).

- **Dado** Modelo 65 com 1 dup
- **Quando** validação de regras
- **Então** erro '760-Rejeição: NFC-e com dados de cobrança (Fatura, Duplicata)'
- **Parâmetros**: `campos` = nFat, vOrig, vDesc, vLiq, dup
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:443-449`

#### ACBR-NFE-762 · cStat 762 · confiança Alta
> NFC-e não informa dados de compra (empenho, pedido, contrato).

- **Dado** Modelo 65 com compra.xPed='PED-1'
- **Quando** validação de regras
- **Então** erro '762-Rejeição: NFC-e com dados de compras (Empenho, Pedido, Contrato)'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:455-457`

#### ACBR-NFE-763 · cStat 763 · confiança Alta
> NFC-e não informa aquisição de cana.

- **Dado** Modelo 65 com cana.safra='2026/2027'
- **Quando** validação de regras
- **Então** erro '763-Rejeição: NFC-e com dados de aquisição de Cana'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:459-462`

#### ACBR-NFE-383 · cStat 383 · confiança Alta
> Item de NFC-e não usa CSOSN com crédito ou ST (101, 201, 202, 203).

- **Dado** Modelo 65, item com CSOSN 101
- **Quando** validação de regras
- **Então** erro '383-Rejeição: NFC-e Item com CSOSN indevido [nItem: 1]'
- **Parâmetros**: `CSOSN_proibidos` = 101, 201, 202, 203
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:709-713`; `ACBrNFe\ACBrNFe-change-log.txt:1386`

#### ACBR-NFE-766 · cStat 766 · confiança Alta
> Item de NFC-e não usa CST 10, 30, 50, 51 ou 70.

- **Dado** Modelo 65, item com CST 10
- **Quando** validação de regras
- **Então** erro '766-Rejeição: NFC-e Item com CST indevido [nItem: 1]'
- **Parâmetros**: `CST_proibidos` = 10, 30, 50, 51, 70
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:715-717`

#### ACBR-NFE-725 · cStat 725 · confiança Média
> Item de NFC-e só com CFOP da lista permitida.

- **Dado** Modelo 65, item com CFOP 5401
- **Quando** validação de regras
- **Então** erro '725-Rejeição: NFC-e com CFOP inválido [nItem: 1]'
- **Parâmetros**: `CFOP_permitidos` = 5101, 5102, 5103, 5104, 5115, 5405, 5656, 5667, 5933, 5949 · `comparacao` = busca por substring numa string separada por vírgula (aceita fragmentos)
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:719-721`; `ACBrNFe\ACBrNFe-change-log.txt:1371`; `ACBrNFe\ACBrNFe-change-log.txt:2227`
- **Conferir no MOC**: Conferir a lista oficial vigente de CFOP permitidos na NFC-e (MOC/NT e UF).

#### ACBR-NFE-774 · cStat 774 · confiança Alta
> Todo item de NFC-e compõe o total (indTot 1).

- **Dado** Modelo 65, item com indTot=0
- **Quando** validação de regras
- **Então** erro '774-Rejeição: NFC-e com indicador de item não participante do total [nItem: 1]'
- **Parâmetros**: `indTot_exigido` = 1
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:723-725`; `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:810`

#### ACBR-NFE-736 · cStat 736 · confiança Alta
> NFC-e não tem grupo de veículos novos.

- **Dado** Modelo 65, item com veicProd.chassi
- **Quando** validação de regras
- **Então** erro '736-Rejeição: NFC-e com grupo de Veículos novos [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:727-729`

#### ACBR-NFE-738 · cStat 738 · confiança Alta
> NFC-e não tem grupo de armamentos.

- **Dado** Modelo 65, item com 1 arma
- **Quando** validação de regras
- **Então** erro '738-Rejeição: NFC-e com grupo de Armamentos [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:731-733`

#### ACBR-NFE-348 · cStat 348 · confiança Alta
> NFC-e não tem grupo RECOPI.

- **Dado** Modelo 65, item com nRECOPI
- **Quando** validação de regras
- **Então** erro '348-Rejeição: NFC-e com grupo RECOPI [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:735-737`

#### ACBR-NFE-740 · cStat 740 · confiança Alta
> Item de NFC-e não usa CST 51 (diferimento).

- **Dado** Modelo 65, item com CST 51
- **Quando** validação de regras
- **Então** erro '740-Rejeição: NFC-e com CST 51-Diferimento [nItem: 1]' (junto com a 766)
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:739-741`

#### ACBR-NFE-741 · cStat 741 · confiança Alta
> Item de NFC-e não usa partilha de ICMS entre UFs (CST Part10/Part90).

- **Dado** Modelo 65, item com CST Part10
- **Quando** validação de regras
- **Então** erro '741-Rejeição: NFC-e com Partilha de ICMS entre UF [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:743-745`

#### ACBR-NFE-742 · cStat 742 · confiança Alta
> Item de NFC-e não tem IPI.

- **Dado** Modelo 65, item com IPI.vIPI 5,00
- **Quando** validação de regras
- **Então** erro '742-Rejeição: NFC-e com grupo do IPI [nItem: 1]'
- **Parâmetros**: `campos` = cEnq, vBC, qUnid, vUnid, pIPI, vIPI
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra. O gerador já descarta o IPI no 65 (ACBR-NFE-X21).
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:747-754`

#### ACBR-NFE-743 · cStat 743 · confiança Alta
> Item de NFC-e não tem imposto de importação nem CFOP de entrada do exterior.

- **Dado** Modelo 65, item com CFOP 3102
- **Quando** validação de regras
- **Então** erro '743-Rejeição: NFC-e com grupo do II [nItem: 1]'
- **Parâmetros**: `gatilho` = II.vBC, vDespAdu, vII ou vIOF > 0, ou CFOP iniciado por '3'
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:756-762`

#### ACBR-NFE-746 · cStat 746 · confiança Alta
> Item de NFC-e não tem PIS-ST.

- **Dado** Modelo 65, item com PISST.vPIS 1,00
- **Quando** validação de regras
- **Então** erro '746-Rejeição: NFC-e com grupo do PIS-ST [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:764-770`

#### ACBR-NFE-749 · cStat 749 · confiança Alta
> Item de NFC-e não tem COFINS-ST.

- **Dado** Modelo 65, item com COFINSST.vCOFINS 1,00
- **Quando** validação de regras
- **Então** erro '749-Rejeição: NFC-e com grupo da COFINS-ST [nItem: 1]'
- **Parâmetros**: —
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:772-778`

#### ACBR-NFE-767 · cStat 767 · confiança Alta
> NFC-e de leiaute anterior a 4.00: soma dos pagamentos = total da nota.

- **Dado** Modelo 65, versão 3.10, vNF 50,00 e pag 49,00
- **Quando** validação de regras
- **Então** erro '767-Rejeição: NFC-e com somatório dos pagamentos diferente do total da Nota Fiscal'
- **Parâmetros**: `versao` = < 4 · `tolerancia` = 0,001
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1134-1145`

#### ACBR-NFE-899 · cStat 899 · confiança Alta
> NFC-e de venda (finalidade 1/2) não usa meio de pagamento 'Sem pagamento' (90).

- **Dado** Modelo 65, versão 4.00, finNFe 1, pag com tPag 90
- **Quando** validação de regras
- **Então** erro '899-Rejeição: Informado incorretamente o campo meio de pagamento' (uma vez)
- **Parâmetros**: `tPag_proibido` = 90
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1164-1174`

#### ACBR-NFE-865 · cStat 865 · confiança Alta
> Na NFC-e, a soma dos pagamentos não pode ser menor que o total da nota.

- **Dado** Modelo 65, versão 4.00, vNF 50,00 e pag 49,99
- **Quando** validação de regras
- **Então** erro '865-Rejeição: Total dos pagamentos menor que o total da nota'
- **Parâmetros**: `tolerancia` = 0,001
- **Modelos**: 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1176-1178`; `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1157-1162`

#### ACBR-NFE-X27 · cStat — · confiança Alta
> O QR-Code (e, na 4.00, a URL de consulta) é calculado DEPOIS da assinatura e inserido em infNFeSupl, com nova geração do XML — para NFC-e e para NF-e com DANFE Simplificado Tipo 2.

- **Dado** Modelo 65, versão 4.00, nota assinada
- **Quando** Assinar
- **Então** infNFeSupl.qrCode e urlChave preenchidos; XML regerado
- **Parâmetros**: `modelos_com_QR` = 65; 55 com tpImp 6 · `versao_QR` = VersaoQRCode (padrão 2.00)
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro. Usa IdCSC/CSC da configuração.
- **Evidência**: `ACBrNFe\ACBrNFeNotasFiscais.pas:360-377`; `ACBrNFe\ACBrNFe.pas:630-646`; `ACBrNFe\ACBrNFeConfiguracoes.pas:77-79`

### 5.12 IBS/CBS — 4 cards

#### ACBR-NFE-1001 · cStat 1001 · confiança Média
> Nota de crédito ou débito (finNFe 5/6) ou de recebimento de pagamento em compra governamental (tpOperGov 2) não leva, no item, ICMS, ISSQN, IPI, II, PIS, PIS-ST, COFINS, COFINS-ST nem ICMSUFDest — exceto crédito por retorno/redução/recusa parcial (03, 04, 06) e débito por pagamento antecipado/perda em estoque (06, 07).

- **Dado** finNFe=6 (débito) com tpNFDebito 01
- **Quando** o XML é gerado
- **Então** o item sai só com vTotTrib, IS (se houver) e IBSCBS
- **Parâmetros**: `excecoes_tpNFCredito` = 03, 04, 06 · `excecoes_tpNFDebito` = 06, 07 · `referencia` = NT 2025.002 v1.40 — regra B25-80
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1895-1935`; `ACBrNFe\PCNNFe\pcnConversaoNFe.pas:420-436`; `ACBrNFe\ACBrNFe-change-log.txt:84-87`
- **Conferir no MOC**: Conferir na NT 2025.002 (versão vigente) a regra B25-80/1001 e a lista de exceções por tpNFCredito/tpNFDebito.

#### ACBR-NFE-X28 · cStat — · confiança Média
> O item só recebe o grupo IBSCBS com CST e cClassTrib preenchidos; o subgrupo depende do CST: 000/200/220/510 → gIBSCBS; 515/550/830 → gIBSCBS só no 55; 620 → gIBSCBSMono; 800 → gTransfCred só no 55; 811 → gAjusteCompet só no 55.

- **Dado** Modelo 65, CST IBS/CBS 550 e cClassTrib '550001'
- **Quando** o XML é gerado
- **Então** IBSCBS com CST e cClassTrib, sem gIBSCBS
- **Parâmetros**: `gatilho` = CST ≠ nenhum e cClassTrib ≠ '' · `matriz_55_only` = 515, 550, 830, 800, 811
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:4302-4339`
- **Conferir no MOC**: Conferir com a NT 2025.002/RTC a matriz CST × modelo e os grupos obrigatórios por CST.

#### ACBR-NFE-X29 · cStat — · confiança Média
> O total IBSCBSTot só é gerado se algum item gerou IBSCBS; gIBS, gCBS, gMono e gEstornoCred só com algum valor > 0; vNFTot é gerado como veio, sem conferência — e o validador não tem NENHUMA regra de IBS/CBS.

- **Dado** Nota com itens IBSCBS e vNFTot informado 113,00
- **Quando** o XML é gerado / validação de regras
- **Então** IBSCBSTot emitido; vNFTot 113,00 sem checagem de soma
- **Parâmetros**: `validador` = nenhuma regra de IBS/CBS/IS
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3540-3555`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:4793-4822`
- **Conferir no MOC**: Quais regras de totalização de IBS/CBS/IS e de vNFTot o MOC/RTC impõe? (lacuna total no ACBr)

#### ACBR-NFE-X30 · cStat — · confiança Alta
> Grupos da Reforma no cabeçalho e no item são gerados por presença: tpNFDebito/tpNFCredito só com finNFe 6/5 (versão 4.00); gCompraGov só com tipo de ente e de operação; gPagAntecipado só com chaves referenciadas; Imposto Seletivo só com CSTIS e vBCIS > 0.

- **Dado** finNFe=5 com tpNFCredito 04
- **Quando** o XML é gerado
- **Então** ide.tpNFCredito='04'; gCompraGov omitido sem tpEnteGov
- **Parâmetros**: —
- **Modelos**: 55, 65
- **Ativação**: Regra de geração (automática): aplicada ao gerar o XML em Assinar/GerarXML/Enviar; altera ou omite conteúdo sem produzir erro.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:585-595`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:4215-4261`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1937-1940`

### 5.13 Outras — 13 cards

#### ACBR-NFE-323 · cStat 323 · confiança Alta
> CNPJ autorizado a baixar o XML (autXML) tem de ser válido.

- **Dado** autXML com CNPJ 11222333000180
- **Quando** validação de regras
- **Então** erro '323-Rejeição: CNPJ autorizado para download inválido'
- **Parâmetros**: `gatilho` = documento com mais de 11 posições
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:653-664`

#### ACBR-NFE-325 · cStat 325 · confiança Alta
> CPF autorizado a baixar o XML (autXML) tem de ser válido.

- **Dado** autXML com CPF 12345678900
- **Quando** validação de regras
- **Então** erro '325-Rejeição: CPF autorizado para download inválido'
- **Parâmetros**: `gatilho` = documento com até 11 posições (inclusive vazio)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:653-658`

#### ACBR-NFE-287 · cStat 287 · confiança Alta
> Município do fato gerador do ISSQN, quando informado, tem de ter DV válido.

- **Dado** Item com ISSQN.cMunFG 4106903
- **Quando** validação de regras
- **Então** erro '287-Rejeição: Código Município do FG - ISSQN: dígito inválido [nItem: 1]'
- **Parâmetros**: `dv` = ValidarMunicipio (ver 270)
- **Modelos**: 55, 65
- **Ativação**: Validador de regras de negócio (opt-in): roda só quando a aplicação chama NotasFiscais.ValidarRegrasdeNegocios; Enviar não o chama; o erro é acumulado em texto e a validação segue para a próxima regra; nenhuma flag de configuração liga ou desliga a regra.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:856-859`

#### ACBR-NFE-X31 · cStat — · confiança Média
> Antes de assinar, a raiz do CNPJ (8 primeiros dígitos) do emitente tem de ser a mesma do certificado (filial pode usar o certificado da matriz); emitente CPF ou certificado sem CNPJ legível não são checados.

- **Dado** Emitente 12345678000195 e certificado de 98765432000110
- **Quando** Assinar (também via Enviar)
- **Então** exceção 'O CNPJ do Documento é diferente do CNPJ do Certificado Digital'
- **Parâmetros**: `comparacao` = 8 primeiros dígitos · `desliga` = evento SSL.AntesDeAssinar atribuído
- **Modelos**: 55, 65
- **Ativação**: Guarda bloqueante automática: levanta exceção no fluxo Enviar/Assinar e impede o envio.
- **Evidência**: `ACBrNFe\ACBrNFeNotasFiscais.pas:325-335`; `ACBrDFeSSL.pas:1674-1696`
- **Conferir no MOC**: Qual cStat oficial a SEFAZ devolve para CNPJ-base do emitente ≠ do certificado (hipótese 213)?

#### ACBR-NFE-X32 · cStat — · confiança Alta
> Certificado vencido bloqueia qualquer chamada ao web service.

- **Dado** Certificado com validade 08/10/2026 e envio em 10/10/2026
- **Quando** qualquer serviço (Enviar, consulta, evento)
- **Então** exceção 'Data de Validade do Certificado já expirou: 08/10/2026'
- **Parâmetros**: `VerificarValidade` = True (padrão)
- **Modelos**: 55, 65
- **Ativação**: Guarda bloqueante automática: levanta exceção no fluxo Enviar/Assinar e impede o envio. Configuracoes.Certificados.VerificarValidade.
- **Evidência**: `ACBrDFeWebService.pas:372-380`; `ACBrDFeConfiguracoes.pas:90`

#### ACBR-NFE-X33 · cStat — · confiança Alta
> Lote de NF-e tem de ter de 1 a 50 notas; lote de eventos, de 1 a 20 eventos.

- **Dado** 51 notas em NotasFiscais
- **Quando** Enviar
- **Então** exceção 'Conjunto de NF-e transmitidas (máximo de 50 NF-e) excedido'
- **Parâmetros**: `max_notas` = 50 · `max_eventos` = 20
- **Modelos**: 55, 65
- **Ativação**: Guarda bloqueante automática: levanta exceção no fluxo Enviar/Assinar e impede o envio.
- **Evidência**: `ACBrNFe\ACBrNFe.pas:873-878`; `ACBrNFe\ACBrNFe.pas:933-938`

#### ACBR-NFE-X34 · cStat — · confiança Alta
> Toda nota é validada contra o XSD do leiaute depois de assinada, automaticamente em Enviar; a primeira nota inválida interrompe o lote com exceção.

- **Dado** Nota com natOp vazia
- **Quando** Enviar (Assinar → Validar)
- **Então** exceção 'Falha na validação dos dados da nota: <nNF>' + alertas do gerador + erro do XSD (se ExibirErroSchema)
- **Parâmetros**: `schema` = autorização (versão ≥ 3.10) ou recepção, pelo número da versão · `ExibirErroSchema` = True (padrão)
- **Modelos**: 55, 65
- **Ativação**: Guarda bloqueante automática: levanta exceção no fluxo Enviar/Assinar e impede o envio.
- **Evidência**: `ACBrNFe\ACBrNFe.pas:880-881`; `ACBrNFe\ACBrNFeNotasFiscais.pas:390-436`; `ACBrNFe\ACBrNFeNotasFiscais.pas:980-986`; `ACBrNFe\ACBrNFe.pas:313-320`; `ACBrDFeConfiguracoes.pas:243-244`

#### ACBR-NFE-X35 · cStat — · confiança Alta
> Eventos (cancelamento, CC-e etc.) são validados contra o XSD duas vezes antes do envio: o envelope do lote e cada detEvento.

- **Dado** Cancelamento com xJust de 10 caracteres
- **Quando** EnviarEvento
- **Então** exceção 'Falha na validação dos dados do Evento'
- **Parâmetros**: —
- **Modelos**: 55, 65
- **Ativação**: Guarda bloqueante automática: levanta exceção no fluxo Enviar/Assinar e impede o envio.
- **Evidência**: `ACBrNFe\ACBrNFeWebServices.pas:3679-3729`

#### ACBR-NFE-X36 · cStat — · confiança Alta
> Todo campo gerado é conferido contra obrigatoriedade, tamanho mínimo/máximo e casas decimais do leiaute; violação vira alerta.

- **Dado** xNome do emitente com 1 caractere (mínimo 2)
- **Quando** o XML é gerado
- **Então** alerta 'TAG:... ID:C03/xNome(...) - menor que o mínimo [X]'
- **Parâmetros**: `checagens` = vazio obrigatório, menor que o mínimo, maior que o máximo, decimais acima do formato · `formato` = FormatoAlerta configurável
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrXmlWriter.pas:243-246`; `ACBrXmlWriter.pas:369-437`; `ACBrXmlWriter.pas:467-485`; `ACBrDFeConfiguracoes.pas:245`

#### ACBR-NFE-X37 · cStat — · confiança Alta
> Todo CNPJ/CPF gerado (emitente, destinatário, retirada, entrega, autXML, transportador, DI) é completado com zeros à esquerda e conferido no DV; tamanho fora de 0/11/14 também alerta.

- **Dado** autXML com '123456789' (9 dígitos)
- **Quando** o XML é gerado
- **Então** CPF '00123456789' gerado e alerta 'CPF inválido' se o DV não fechar
- **Parâmetros**: `preenche_zeros` = CPF até 11, CNPJ até 14
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrXmlWriter.pas:155-232`

#### ACBR-NFE-X38 · cStat — · confiança Alta
> Limites de ocorrência no nível do documento geram alerta quando excedidos.

- **Dado** Nota com 121 duplicatas
- **Quando** o XML é gerado
- **Então** alerta 'Y07 dup ... máximo 120'
- **Parâmetros**: `NFref` = 999 · `autXML` = 10 · `dup` = 120 · `pag` = 100 · `reboque` = 5 · `obsCont` = 10 · `obsFisco` = 10 · `procRef` = 100 · `defensivo` = 20
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:670-671`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1156-1157`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3716-3717`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3778-3779`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3887-3888`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3982-3983`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:4007-4008`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:4045-4046`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1101-1102`

#### ACBR-NFE-X39 · cStat — · confiança Alta
> Observação do contribuinte/fisco (no item e na nota) exige nome do campo (xCampo) com 1 a 20 caracteres.

- **Dado** infAdic.obsCont com xCampo vazio
- **Quando** o XML é gerado
- **Então** alerta 'ZO5 xCampo vazio'
- **Parâmetros**: `xCampo` = 1..20 · `xTexto` = 1..60
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3212-3237`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3976-4023`

#### ACBR-NFE-X40 · cStat — · confiança Alta
> Grupo de exportação: UF de saída do país (embarque, antes da 3.10) inexistente gera alerta.

- **Dado** exporta.UFSaidaPais='XX'
- **Quando** o XML é gerado
- **Então** alerta 'ZA02 UFSaidaPais inválido'
- **Parâmetros**: `gatilho` = UF ou local de exportação preenchidos
- **Modelos**: 55, 65
- **Ativação**: Alerta do gerador (não bloqueia): gravado em ListaDeAlertas ao gerar o XML (Assinar/GerarXML); só chega ao usuário anexado à exceção do XSD, se o XSD falhar — com XSD válido a nota segue e o alerta é ignorado.
- **Evidência**: `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:4065-4091`

## 6. Discrepâncias e achados do código (fotografia — sem solução)

| # | Achado | Evidência | Sev. |
|---|---|---|---|
| D1 | **Validação de regras é opt-in**: `Enviar` não a chama; o exemplo oficial a usa sobre XML já gerado. | `ACBrNFe\ACBrNFe.pas:880-881`; `..\..\Exemplos\ACBrDFe\ACBrNFe\Delphi\Frm_ACBrNFe.pas:5724-5727` | 🟡 |
| D2 | **Regras só em comentário (código comentado ou removido)** — não são regras: 719 e 720 (`:183-186`, `:194-197`); 897 da fatura com o código de outra regra (`:282-285`); 508, 529, 600, 806 (`:784-813`); 856, 858 (`:815-821`, a 858 marcada "VERIFICAR"); 629, 630 (`:827-835`, desabilitadas — change-log `ACBrNFe\ACBrNFe-change-log.txt:475`); 883, 888 (`:865-867`, `:889-891`); 502 dentro da "512", que roda vazia (`:1276-1284`); 571 (`:514-520`, change-log `:263`); 767 da 4.00 (`:1157-1162`, "removida na NT 2016.002 v1.10"); GB09.02/03 (`:1229-1230`); 605 por item (`:1018`); DI/DSI/DIRE (`ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1381-1383`). | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas` (linhas indicadas) | 🟢 |
| D3 | **Mensagem × condição**: 509 roda o teste de DV do município do destinatário fora do exterior; 877 diz "data de processamento" e compara com `dEmi`; 253 diz "dígito" e recusa também UF/AAMM/CNPJ da chave. | cards ACBR-NFE-509, -877, -253 | 🟡 |
| D4 | **Regra inerte**: 785 com lista de UF = marcador `'XX'`. | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:367-371` | 🟢 |
| D5 | **Defeitos**: alerta de país com precedência invertida (dispara no código válido-fora-da-tabela e no cPais 0; cala no erro real) — `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:975, 1020, 1070`; alerta de município da entrega usa o valor bruto e o ID `F07` — `:1059-1060`; 321 acessa o item 0 antes de checar se há itens (nota sem item = erro de índice, não regra) — `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:1238-1243`; lista de CFOP da 725 comparada por substring — `:720`; soma exata em ponto flutuante na 855 — `:961`; 772 só dispara com local de entrega na UF do emitente — `:1024-1028`. | linhas indicadas | 🟡 |
| D6 | **Resultado depende da ordem**: o gerador altera o objeto da nota (SEM GTIN, `xNome`/`xProd` de homologação, `cNF`/`cDV`/`Id`, `cEnq` 999). Validar regras antes ou depois de `Assinar` dá resultados diferentes (889, 253, 897, 724). | `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:358-364, 896-897, 1204-1207, 1222-1225, 3021-3022` | 🟡 |
| D7 | **Dois critérios de "serviço"** (validador × gerador) — um item pode somar como serviço num lado e receber ICMS no outro. | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:700`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:1915-1916` | 🟡 |
| D8 | O validador vigente importa os tipos de `pcnConversao`/`pcnConversaoNFe` (unidades do caminho antigo); `ACBrNFe.Conversao` está comentado. | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:39-46` | 🟢 |
| D9 | **Nenhuma regra de IBS/CBS/IS no validador**; a fórmula do vNF (610) não os considera e `vNFTot` não é conferido. | `ACBrNFe\Base\ACBrNFe.ValidarRegrasdeNegocio.pas:470-1214`; `ACBrNFe\Base\ACBrNFe.XmlWriter.pas:3553-3554` | 🔴 para o regime regular a partir da obrigatoriedade |
| D10 | Tolerâncias heterogêneas (0,001 · 0,009 · 0,01) e prazos fixos no código (30 dias, 5 min, 10 min). | §4 | 🟢 |
| D11 | **Texto com cara de instrução para IA**: nenhum encontrado (varredura dos 7 arquivos principais por padrões de instrução). | — | — |

## 7. Ponte com o legado Gestao2016 (fato, só leitura por grep)

- Nenhuma chamada a `ValidarRegrasdeNegocios` em `D:\Gestao2016` (`.pas`/`.dfm`): **o legado nunca rodou este
  catálogo** — só o XSD, via `NotasFiscais.Assinar` + `NotasFiscais.Validar` (`D:\Gestao2016\Tarefas\UN_Principal.pas:3767-3768`;
  `D:\Gestao2016\Ajuda\un_geranfe3X.pas:826-827`) e via `Enviar` na NFC-e
  (`D:\Gestao2016\view\module\operation\task\tas_gera_nfce_autorizacao.pas:969`).
- Consequência fotografada: tudo o que o legado "pré-validava" era estrutura (XSD) + alertas silenciosos do gerador.
  Regras de negócio chegavam à SEFAZ e voltavam como rejeição.

---

## 8. Insumos para o planejamento da nfe-api — ⚠️ FORA DA FOTOGRAFIA (opinião do extrator; decisão é do Valdo)

### 8.1 Como o catálogo entra na nfe-api
- **O .json é o catálogo-semente da pré-validação** (lição 7): cada regra vira uma função pura `(nota, contexto) →
  violação[]` identificada pelo `id`, e cada card vira **dois testes jest** (o "Dado/Quando/Então" que falha e a
  variação mínima que passa). O `status` de cada regra (conferida no MOC / divergente / descartada) entra no próprio
  catálogo na NE-0, não num documento paralelo.
- **Onde**: na nfe-api (dialeto da família — D-F17), não no núcleo; o núcleo só oferece o contrato genérico
  "pré-validação acumula violações e bloqueia a transmissão".
- **Ondas**: NE-0 confere o catálogo contra o MOC/NTs oficiais (as 47 perguntas, §8.5); NE-4 implementa as regras junto
  com o builder (são regras sobre o mesmo modelo de fatos); NE-5 faz a composição chamar a pré-validação **antes** do
  aluguel/tentativa — violação = nenhuma tentativa, nenhum `attempt + 1`, resposta 422 com a lista inteira.
- **Não copiar o desenho do ACBr**: (a) acumular TODAS as violações (como o validador) mas **bloquear** (como o XSD);
  (b) rodar as regras sobre a nota **já montada e imutável** (pós-builder, pré-assinatura) para eliminar a
  dependência de ordem de D6; (c) "Agora" = o relógio único da requisição no fuso do estabelecimento (regra do fuso
  já vigente — Q-TZ8), nunca o relógio do processo.

### 8.2 Q-NE16 — confirma e refina
Confirma "validar sempre antes de enviar" e **refina**: o legado validava só o XSD (§7), então "validar como o legado"
deixaria de fora ~155 regras de negócio que o próprio ACBr conhece. Proposta de redação: *pré-validação = catálogo de
regras de negócio (este .json, conferido no MOC) + XSD oficial, ambos obrigatórios e bloqueantes; alertas do gerador
viram erro ou somem — não existe alerta silencioso.*

### 8.3 Regras que dependem de fato do ERP que hoje não existe (§11.2 item 5 do prompt)
| Lacuna do ERP | Regras do catálogo que ficam sem dado |
|---|---|
| `finality` não gravado pelo `issueInvoice` | 254, 255, 269, 678, 321, 528, 564, 610, 851/895/902 (filtram finNFe), 866/869/871, 873, 715 |
| `indPres` fixo 0 | 717, 753, 754, 773, 786, 787, 794, 864, 873 (todas presumem o valor real) |
| `dt_exit` | 504, 505, 506, 705, X06 |
| transporte/volumes sem produtor | 542, 543, 544, 559, 868, 753–759, X26 |
| GTIN/unidade congelados | 611, 612, 882, 884, 885, 886, 889, 854, X15 |
| ST retido / ICMS desonerado / DIFAL | 938, 859, 795, 610, 625, X20 (ICMSUFDest), 906 |
| IE do emitente (Setes sem IE) | 229 e 209 disparam **localmente** — a autorização com o A1 da Setes já é barrada na pré-validação (reforça a Q-NE18 (c)) |
| IBS/CBS (motor no ERP) | 1001, X28, X29, X30 — e nenhuma regra de totalização (D9) |
| numeração × inutilização (Q-NE8) | nenhuma regra local cobre (só a 897, do cNF) |
| rastro/medicamento, combustível, veículo, arma | 873, 877, 870, 854, 855, 461, X18/X19 — ⚠️ não levantado se o ERP tem esses fatos |

### 8.4 Regras que só fazem sentido com dado externo ou versionado
- **Configuração do autorizador/ambiente** (na nfe-api vêm da tabela de autorizadores — Q-NE3 — e da habilitação por
  modelo): 226, 252, 570, 713.
- **Relógio**: 228, 703, 704, 558, 569, 504, 505 — dependem do relógio da SEFAZ; localmente só aproximam.
- **Cadastros oficiais**: 889 (Cadastro Centralizado de GTIN), 882/884 (tabela GS1), 209/544 (situação cadastral é
  consulta, o ACBr só confere DV), X31/X32 (certificado no cofre).
- **Listas que viram dado versionado, não código**: CFOP da NFC-e (725), CST/CSOSN proibidos (383, 766, 740),
  exceções da 873, UFs da 785, municípios com DV irregular, prefixos GTIN, data de corte SEM GTIN, tolerâncias e
  prazos (§4).
- **Fora do alcance local por natureza**: duplicidade de chave/número, denegação por situação do emitente ou
  destinatário, consumo indevido, nota já cancelada — só a SEFAZ responde.

### 8.5 O que conferir no MOC (prioridade)
1. As 4 regras **Baixa**: 509, 772, 785, 889.
2. As **Média** do caminho do 1º release (venda finNFe 1 + devolução finNFe 4 — Q-NE25): 253, 528, 564, 602/603,
   610, 795, 851, 855, 873, 877, 209, 237, 269, 701, 711, 794, 228, 703, X10/X16 (textos de homologação), X21 (cEnq 999).
3. As de contingência e NFC-e (704, 557, 570, 713, 725) ficam para a F5 (Q-NE2).
4. IBS/CBS (1001, X28, X29) entra na fase própria (Q-NE4).

### 8.6 cStat cobertos e estimativa do que falta
**Validador (155 cStat)**: 207, 208, 209, 226, 228, 229, 237, 252, 253, 254, 255, 269, 270, 271, 272, 273, 276, 277, 278, 279, 287, 321, 323, 325, 348, 370, 383, 461, 489, 504, 505, 506, 509, 513, 515, 528, 530, 531, 532, 533, 534, 535, 536, 537, 538, 542, 543, 544, 556, 557, 558, 559, 564, 569, 570, 601, 602, 603, 604, 608, 609, 610, 611, 612, 625, 678, 685, 701, 703, 704, 705, 706, 707, 708, 709, 710, 711, 713, 715, 716, 717, 718, 721, 723, 724, 725, 726, 727, 729, 730, 736, 738, 740, 741, 742, 743, 746, 749, 753, 754, 755, 756, 757, 758, 759, 760, 762, 763, 766, 767, 768, 769, 771, 772, 773, 774, 777, 782, 783, 785, 786, 787, 789, 790, 794, 795, 851, 854, 855, 857, 859, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 873, 877, 879, 882, 884, 885, 886, 889, 894, 895, 897, 899, 902.

**Regras de geração que nomeiam a rejeição evitada (3)**: 906, 938, 1001.


**Quantas regras do MOC o ACBr NÃO cobre**: ⚠️ o código não permite inferir — não há no ACBr a lista completa de
cStat do MOC (o `ACBrNFe.Consts.pas` só tem descrições de campo). O que o código mostra: (a) 17 regras com cStat conhecido que
estão comentadas/removidas, além de GB09.02/03 e da validação de DI/DSI/DIRE (D2); (b) **zero** regras de IBS/CBS/IS (D9); (c) zero regras de numeração, duplicidade,
cadastro e evento (cancelamento/CC-e só passam pelo XSD). O universo oficial tem de vir do levantamento da NE-0
(`integracoes/nfe-sefaz/`, Q-NE19).

## 9. Confiança e lacunas

- **Contagem**: ver §2. Os cards **Alta** descrevem lógica explícita sem indício de divergência — ainda assim são
  reimplementação de terceiro e precisam do selo "conferida no MOC" antes de virar regra de produção.
- **Lacunas da leitura**: algoritmos de IE por UF e o DV do CNPJ alfanumérico (rotina `Modulo`) foram aceitos sem
  inspeção linha a linha; a tabela de prefixos GTIN foi conferida por amostra (início, Brasil, fim);
  `ACBrNFeWebServices.pas` foi lido só nos pontos de validação; os alertas genéricos de obrigatoriedade/tamanho do
  `AddNode` (ACBR-NFE-X36) não foram enumerados campo a campo — são o XSD reimplementado, e o XSD oficial é a fonte;
  cardinalidades foram agrupadas em dois cards (X18 item, X38 documento).
- **Leitura do legado** (§7) foi só por grep de chamadas; não se leu como o legado montava o objeto `TNFe`.
- **Material oficial**: nenhum MOC/NT no acervo (fato 1 do §11.2 do prompt) — todas as perguntas ficam abertas até a NE-0.
- **Riscos de interpretação**: regras marcadas "facultativa" (504, 505, 506, 678) variam por UF; a 711/794 dependem da
  NT 2026/002 (ajuste do ACBr de 20/07/2026); a 1001 depende da NT 2025.002 v1.40, que teve idas e vindas no próprio
  change-log (`ACBrNFe\ACBrNFe-change-log.txt:61-82`).
