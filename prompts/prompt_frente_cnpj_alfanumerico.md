# Frente de PRODUTO — CNPJ alfanumérico

**Escopo**: misto (a regra de formação do CNPJ e o método "inventariar onde o produto assume um formato" são portáveis; os pontos de código e as
integrações são do Gestão 2027)
**Origem**: D-NE29 (2026-10-10, Rodada 2 da nfe-api — "frente de PRODUTO própria, aberta já; 1º passo: inventário, vigência e o que cada leiaute
oficial aceita hoje; a nfe-api nasce aceitando no SEU builder o que o leiaute da NF-e aceitar; núcleo e nfse-api seguem a versão oficial de cada
leiaute; Sincronizador/setes-sync pelo grupo dele") · D-NE99 (2026-10-15, Rodada 3 da nfe-api — Rodada 0 em sessão própria depois da NE-0).
**Aberto em**: 2026-10-15 (Valdo: "agora abra a frente do CNPJ alfanumérico"). Rodada 0 = dois levantamentos em paralelo (inventário do código +
estado OFICIAL na web, fontes primárias datadas) + parecer do guardião (`setes-conceito`). Nada de código, DDL ou download.
**Regra dos dois grupos**: setes-sync e sincronizador NÃO foram lidos — são a outra porta de escrita de `setes_central.tb_company.cnpj`; o pedido ao
grupo do sync é tarefa SEPARADA (§7).
**Anexo**: `prompt_frente_cnpj_alfanumerico-inventario.md` (110 pontos com arquivo:linha).
**Estado (2026-10-15)**: ⏯ **Rodada 0 ORGANIZADA** — inventário (anexo), fatos oficiais (§2), parecer do guardião INTEGRADO (§4), ondas (§5);
**Rodada 1 (Q-CJ1…Q-CJ13, §6) aguarda o Valdo**. Retomar pelo §8. PUBLICADA 2026-10-15 (infra 024f914).

---

## 1. Por que agora

1. **Desde 31/07/2026 a RFB atribui CNPJ ALFANUMÉRICO a inscrições NOVAS** (o 1º: `00.000.000/E08G-12`, filial do Banco do Brasil). CNPJ existente
   não muda; CNPJ novo PODE continuar só numérico (a atribuição é aleatória); **não há data-limite** — os dois formatos convivem sem prazo.
2. **O produto RECUSA hoje** um CNPJ com letra em todas as portas de cadastro (5 papéis + prefill), no upload do A1, na NFS-e (emitente E tomador) e
   no boleto (latente). Consequência de negócio: **um cliente da Setes não consegue cadastrar nem faturar para uma empresa aberta depois de jul/2026**
   (cliente novo, fornecedor novo, tomador novo), e a Setes não consegue implantar cliente novo com CNPJ alfanumérico. O risco cresce a cada mês.
3. **Estraga HOJE, independente de letra** (S1): a pesquisa avançada "Documento" das 6 telas de papel tira as letras do que se digita e faz `LIKE`
   parcial com o resto.
4. **Certificado e-CNPJ — risco que vale também para CNPJ NUMÉRICO**: pelo DOC-ICP-04 v8.3 (ITI, Res. 211/2024 e 212/2025) o certificado de pessoa
   jurídica passa ao perfil **SE-S/SE-H (selo eletrônico)**, com `CN = <Razão Social>` e o CNPJ no **`serialNumber` (2.5.4.5)** do titular (o OID
   2.16.76.1.3.3 fica "obrigatório com restrição" até 31/12/2028). O núcleo lê o CNPJ do CN com `:(\d{14})` (`fiscal-api/src/secret/certificate.ts`):
   **quando a AC emitir um A1 no perfil novo, o upload quebra para qualquer cliente** — com ou sem letra. O A1 da Setes renovado em 10/10/2026 ainda
   veio no formato antigo (data da transição das ACs: não confirmada).

## 2. Fatos oficiais (levantamento de 2026-10-15; nada arquivado — Q-CJ1)

- **Norma**: IN RFB nº 2.229, de 15/10/2024 (altera a IN 2.119/2022; vigência 25/10/2024) — https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/acoes-e-programas/programas-e-atividades/cnpj-alfanumerico
  (o texto no SIJUT não abriu). Cronograma de implantação na RFB: base só consulta 23/07/2026 21h · indisponível 25/07 7h · sistemas em produção 27/07
  7h · 1º CNPJ alfanumérico 31/07/2026 (notícias da RFB de 10/07 e 31/07/2026).
- **Formato** (Perguntas e Respostas da RFB, 52 perguntas — `…/centrais-de-conteudo/publicacoes/perguntas-e-respostas/cnpj/cnpj-alfanumerico.pdf`, 782 KB):
  14 posições — 8 de raiz + 4 de ordem com `[0-9A-Z]` (letras **MAIÚSCULAS**) + 2 DV numéricos; **não há letra proibida para validação** (a RFB veda
  combinações internamente; os sistemas aceitam as 26 — FAQ 1, 38, 45; o DRN do Bacen diz o mesmo) — a observação "I, O, U, Q, F" da NT Conjunta
  2025.001 era pedido do ENCAT "a confirmar" e caiu; máscara de exibição igual à atual `XX.XXX.XXX/XXXX-DV` (FAQ 21); **"0001" deixa de garantir
  matriz** (FAQ 25); CNPJ novo pode ser numérico (FAQ 27/28) — nenhuma regra pode deduzir "novo ⇒ tem letra".
- **DV oficial** (Manual de cálculo do DV, Serpro/RFB, 05/11/2024 — `…/publicacoes/documentos-tecnicos/cnpj/manual-dv-cnpj.pdf`, 702 KB): cada caractere
  vale **ASCII − 48** (0–9 = 0–9; A = 17 … Z = 42); pesos 2…9 da direita para a esquerda; módulo 11; resto 0 ou 1 → DV 0, senão 11 − resto. Exemplo
  resolvido oficial `12.ABC.345/01DE-35`. ⚠️ O Ex1 da FAQ 23 (`AA345678/0003-29`) tem DV ERRADO (o certo é `-86`) — nunca usar como caso de teste.
  Para CNPJ numérico o cálculo dá exatamente o mesmo de hoje.
- **NF-e/NFC-e** (acervo da nfe-api — NT Conjunta 2025.001 + NT 2026.004 v1.01, arquivadas): aceito desde **01/07/2026**; chave de acesso
  `[0-9]{6}[0-9A-Z]{12}[0-9]{26}` com DV pela mesma regra ASCII − 48 sobre as 44 posições; DANFE com Code-128 **híbrido** 128C/128A.
- **NFS-e Padrão Nacional**: NT 009 v1.01 (11/09/2026) §2.1 — todos os campos CNPJ passam de numérico (N) para caractere (C), sem cronograma; a
  página "Atualizações e Implantações" registra em **10/08/2026** "Evolução para tratamento do CNPJ alfanumérico"; **o XSD da PRODUÇÃO RESTRITA (v1.01,
  27/07/2026) já aceita letra** — `TSCNPJ` `[0-9A-Z]{14}`, `TSIdDPS` `DPS[0-9]{7}(1[0-9]{14}|2[0-9A-Z]{14})[0-9]{20}`, `TSIdNFSe`
  `NFS[0-9]{9}[0-9A-Z]{14}[0-9]{27}`, chave `[0-9]{6}([0-9A-Z]{14})[0-9]{30}` (⚠️ defeito: o padrão reserva as letras nas posições 7–20, mas o CNPJ fica
  nas 10–23 — recusaria chave cujo 12º caractere do CNPJ seja letra, como o 1º CNPJ real); **o XSD publicado como PRODUÇÃO (1.01 de 09/02/2026, no
  acervo da NFS-e) segue numérico** — mesma versão, leiautes diferentes; qual o servidor de produção aplica de fato só se sabe testando. Tamanhos não
  mudam (chave 50, Id do DPS 45). DV da chave: "representação numérica dos caracteres" (Anexo VI v1.04.01) — ASCII − 48 não está escrito.
- **Certificado ICP-Brasil**: DOC-ICP-04 v8.3 compilado (30/01/2025) — o OID 2.16.76.1.3.3 continua com o CNPJ "nas 14 posições" e `otherName` admite
  A–Z/0–9; perfil SE-S/SE-H para PJ com o CNPJ no `serialNumber`; o formato `RAZÃO:CNPJ` no CN fica só para o SAT. Nenhum ato do ITI sobre o CNPJ
  alfanumérico em si.
- **Bacen / bancos**: DRN "CNPJ Alfanumérico" v1.02 (22/05/2025) — no catálogo do SFN (a partir do 5.10) o `CNPJ` vira `[0-9A-Z]{12}[0-9]{2}`, o **ISPB
  vira `[0-9A-Z]{8}`**, o `IdentcSacdrAvalst` das mensagens DDA (boleto) aceita letra e o `EndToEndId` do Pix também; Comunicado 44.396 (16/12/2025) —
  testes no STR/SPI/Selic. **Inter**: o Pix com CNPJ alfanumérico está em produção (blog do Inter, 31/07/2026); a API Cobrança v3 tem `pagador.cpfCnpj`
  texto de 11 a 18 sem padrão — **não confirmado** que aceite letra (testar no sandbox). Febraban (arrecadação v08, 01/06/2026): CNPJ alfanumérico NÃO
  identifica empresa no segmento 6 do código de barras de ARRECADAÇÃO (contas/tributos — não é o boleto de cobrança).
- **Outros**: EFD ICMS/IPI NT 2026.001 (leiaute 021, 01/01/2027 — CNPJ vira C) [SEC]; DARF aceita; CT-e/BP-e/NFCom/NF3e/NFAg/NFGas: NT 2026.004 de cada
  modelo adiada para H 26/10 · P 16/11/2026 (aviso SVRS de 15/10); a RFB alertou que aplicações não adaptadas que consomem serviços dela podem falhar
  desde 27/07/2026.
- **CNPJ de teste**: SVRS (NF-e/NFC-e em homologação) `PC3D315K000193` com IE `0018001360` (aviso de 29/05/2026 — arquivado no acervo da nfe-api);
  Bacen (homologação do STR/SPI) ISPB `99999A03` / CNPJ `99999A03000106` e `99999A04` / `99999A04000150`; simulador da RFB gera até 1.000 CNPJ fictícios
  (https://servicos.receitafederal.gov.br/servico/cnpj-alfa). NFS-e e Inter: não encontrado.

## 3. Inventário (resumo — anexo com os 110 pontos)

- **110 pontos**: setes-api 28 · setes-app 23 · fiscal-api 16 · nfse-api 31 · banco 12. RECUSA 38 · ESTRAGA 11 (S1 hoje, S2–S7 latentes) · TESTE 18.
- **Banco**: NENHUMA coluna precisa mudar de tipo (nenhuma numérica; os comprimentos cabem). **Colação em aberto**: `tb_company.cnpj` (central,
  UNIQUE, escrita também pelo setes-sync) compara sem distinguir caixa; o DV oficial distingue.
- **Concentração**: a correção cabe em poucas peças — `validators.ts` + `fiscal.dto.ts` (API), `setes_validators` + `entity_main_tab`/
  `object_entity_fiscal` (app), `certificate.ts` + `facts.ts` + `fiscal-storage.ts` (núcleo), `dps-builder.ts` + `service-facts.ts` + `adn.ts` (nfse-api)
  — mas há ~13 cópias de `replace(/\D/g,'')`, 6 cópias do "14 por comprimento" no app, 2 do DV (TS × Dart) e a detecção PF × PJ pelo comprimento em 3
  lugares.
- **O pior caso latente (D12)**: se o fisco autorizar uma NFS-e de emitente com CNPJ alfanumérico, a nfse-api lê a chave só com dígitos e cai em 502
  ambíguo — a nota fica autorizada no fisco sem a voz A no sistema. **Incoerência já existente**: a chave substituta (`transmission.ts:1205`) e o CHECK da
  067 aceitam `[0-9A-Z]`; o resto tira as letras.

## 4. Parecer do guardião (agente `setes-conceito`, 2026-10-15 — integrado; conferido no disco pelo agente, nada escrito por ele)

**Conferências do guardião** (sem abrir setes-sync/sincronizador): ISPB não aparece em setes-api, setes-app (lib) nem sql (`tb_bank.number` é
`varchar(3)`, o COMPE); nada deduz matriz por "0001"; o CHECK `ck_invoice_cancel_waiver_access_key` (067) usa REGEXP sem `COLLATE utf8mb4_bin` em
coluna `unicode_ci` — aceita minúscula (violação da regra 11, anterior a ela); `SetesValidators.cnpj()` existe no Dart e ninguém usa (as 6 telas
reimplementam pelo comprimento); o `buildPayer` do boleto já decide PF × PJ pela PRESENÇA da especialização (certo) — a nfse-api e o DANFSe pelo
comprimento (errado); `nfse-api/src/authority/layout-calendar.ts` (IB-3) já é a casa da "versão oficial de cada leiaute", mas identifica o leiaute só
pela versão; DV ASCII − 48 conferido em node: fecham `12ABC34501DE35`, `PC3D315K000193`, `99999A03000106`, `99999A04000150`, `00000000E08G12` e
`11222333000181`; o Ex1 da FAQ 23 não fecha (o certo é `…86`).

### 4.1 Briefing usado na Rodada 0 (histórico — serve de molde se o guardião precisar ser relançado)

Ler: skill `Infra-IA/skills-genericas/guardiao-conceitual.md`; este prompt (§1–§3) e o anexo `prompt_frente_cnpj_alfanumerico-inventario.md`;
`Infra-IA/database/PADROES_BANCO.md` §5 e §11 regra 11; as peças `setes-api/src/shared/validation/validators.ts`, `.../shared/fiscal/fiscal.dto.ts`,
`.../shared/fiscal/fiscal.repository.ts`, `.../shared/list/search-criteria.ts`, `.../shared/entity/entity-search-criteria.ts`,
`setes-app/packages/setes_validators/lib/src/validators.dart` e `mask.dart`, `fiscal-api/src/secret/certificate.ts`, `.../erp/facts.ts`,
`.../storage/fiscal-storage.ts`, `nfse-api/src/authority/dps-builder.ts`, `.../facts/service-facts.ts`, `.../authority/adn.ts`. NÃO abrir setes-sync
nem sincronizador. Parecer sobre: (1) o "documento de identificação fiscal" (CPF/CNPJ) como PEÇA — regra ÚNICA de formação/DV/normalização (TS e Dart
espelhados), o que é normalizar (maiúscula; tirar só `.`/`-`/`/`; nunca letra), validar, detectar PF × PJ, exibir/máscara, entrada no app, comparar e
pesquisar; a chave de acesso fiscal (50/44) é outra peça que partilha o DV ASCII−48?; (2) colação de `tb_company.cnpj` (`_ci` + normalizar para
maiúscula em toda escrita × `utf8mb4_bin` + CHECK × outra); (3) o CNPJ do titular do certificado (ordem serialNumber 2.5.4.5 × OID 2.16.76.1.3.3 × CN
legado) — vale também para CNPJ numérico; (4) a nfse-api diante de produção (XSD numérico) × produção restrita (já aceita letra): leitura tolerante
de chave alfanumérica JÁ (D12) × escrita conforme o leiaute vigente; (5) boleto/Inter (pagador mutilado) e se o produto usa ISPB; (6) a pesquisa por
documento (S1 — igualdade normalizada? prefixo? parcial?); (7) maquetes e palavras ocupadas; (8) ondas recomendadas (risco de negócio × leiaute oficial)
e questões numeradas G1… (problema → evidência → recomendação). Não inventar fato oficial — usar o §2.

### 4.2 O conceito — `FederalId` (inscrição federal)

**Frase**: *a inscrição federal identifica uma pessoa perante a Receita Federal* (CPF para PF, CNPJ para PJ; irmã da IE e da IM, que não mudam).
**Fato gerador**: o ato de inscrição na RFB — o produto NUNCA cunha; só recebe por 4 portas (digitação, certificado A1, voz do fisco, sincronizador).
"Validar" = forma + DV; consultar a RFB é outro conceito. **Peça = tipo de valor que carrega o tipo**: `FederalId = { kind: 'cpf' | 'cnpj', value }`.

| Operação | Regra única (TS e Dart espelhados) |
|---|---|
| Forma canônica | CNPJ `[0-9A-Z]{12}[0-9]{2}` (ASCII, MAIÚSCULA, sem máscara); CPF `[0-9]{11}` |
| Normalizar | trim; remove SÓ os literais `.` `/` `-` e espaço; `a–z → A–Z`; qualquer outro caractere torna o valor INVÁLIDO — nunca é apagado |
| Validar | forma + DV (ASCII − 48; pesos 2…9 da direita, ciclando; módulo 11; resto 0/1 → 0, senão 11 − resto); mantém só o veto "14 iguais"; nenhum veto de letra |
| Exibir | `XX.XXX.XXX/XXXX-DV` nas mesmas posições, só sobre valor válido |
| Comparar | igualdade exata da forma canônica — nunca depois de tirar caractere, nunca `LOWER`/`UPPER` no SQL |
| PF × PJ | do LUGAR onde o valor mora (especialização viva do toggle triplo, elemento `<CNPJ>`/`<CPF>` do XML, `tpInsc` do Id/chave, perfil/OID do certificado) — o teste de comprimento depois de limpar MORRE |

**Onde mora (G1 → Q-CJ2)**: uma fonte TS no núcleo, superfície pública pura e sem banco `fiscal-api/federal-id` (molde `fiscal-api/reading`, D-F33),
reexportada por `@shared/validation`; Dart em `setes_validators`; o espelho TS × Dart ganha um **vetor oficial de casos** lido pelas duas suítes (os 6
válidos acima + inválidos: minúscula, acento, máscara parcial, letra no DV, o Ex1 da FAQ 23). ⚠️ PADROES §11 regra 17: o núcleo na árvore viva já é
produção — a peça nasce em worktree e entra numa janela. **App**: os 5 formulários usam o formatter da peça (maiúscula, 1–12 `[0-9A-Z]`, 13–14
dígito, literais inseridos), teclado `text` + `characters`; marca inline e as 5 pendências chamam o MESMO validador (R3 por construção); o objeto de
domínio guarda e envia a forma canônica — o nome `cnpjDigits` morre.

**A chave de acesso é OUTRA peça** (identifica um DOCUMENTO): forma por posição (letra só nas 12 primeiras posições da inscrição — NFS-e 10–21,
NF-e 7–18); `issuerOf(chave)` num lugar só (hoje copiado em `transmission.ts:1193`, `adn.ts:341` e no recorte do Id do DPS); DV da NF-e (nós
cunhamos) pela primitiva `mod11` ASCII − 48 (utilitário partilhado, como `money`); **DV da chave da NFS-e NÃO se calcula nem se confere** (o fisco
cunha; o Anexo VI só fala em "representação numérica") — conhecimento negativo: DV presumido numa chave que não é nossa transforma divergência de
interpretação em recusa da voz.

### 4.3 Armazenamento e colação (G3 → Q-CJ4)

A RFB só emite maiúscula e o DV distingue `a` de `A`: minúscula não é "o mesmo CNPJ escrito diferente", é um texto que não é CNPJ — o problema é de
FORMA, não de comparação. (a) `_ci` + "toda porta normaliza" = maquete (N escritores, um de outro grupo, segurando o invariante); (b) `utf8mb4_bin`
sem CHECK fica PIOR que hoje (a UNIQUE separa `pc3d…` de `PC3D…` → duas entities para o mesmo CNPJ; DDL numa UNIQUE central partilhada; risco de
1267); **(c) recomendado: colação mantida + CHECK BINÁRIO DE FORMA** `ck_company_cnpj_form CHECK (cnpj COLLATE utf8mb4_bin REGEXP
'^[0-9A-Z]{12}[0-9]{2}$' …)` com sonda no boot pelo NOME (§5 + §11 regras 11/16) — com só `[0-9A-Z]` na coluna a UNIQUE `_ci` fica exata por
construção; o DV fica na peça; o mesmo CHECK em `fiscal_api.tb_establishment_certificate.cnpj`; o CHECK da 067 ganha `COLLATE utf8mb4_bin`.
**Pré-condições**: auditoria só-leitura dos dados vivos (inclusive o sentinela `'0'` — G4); **acordo com o grupo do sync ANTES do DDL** (o CHECK vira o
contrato entre os grupos); provar em schema descartável se o `ADD CONSTRAINT` do MariaDB 10.4 recusa linhas existentes (a conferir).

### 4.4 Certificado e-CNPJ (G5 → Q-CJ6)

O titular do certificado é a inscrição que ele identifica — fato lido de campo NORMATIVO, nunca do CN (exibição); ler do CN era a maquete que o SE-S
expõe (vale também para CNPJ numérico). Fontes: OID 2.16.76.1.3.3 (`otherName`, até 31/12/2028), `serialNumber` (2.5.4.5, SE-S/SE-H), CN legado
`RAZÃO:CNPJ` (SAT). **Regra = CONSENSO**, não precedência: lê todas as presentes pela peça; uma → ela; duas divergentes → 409 "certificado
incoerente"; nenhuma → 409 "sem a inscrição do titular" ("a primeira que casa vence" deixaria passar certificado contraditório). PF × PJ pelo perfil/OID
(o C2 morre). `CertificateInfo.cnpj` vira `holder: FederalId | null` + as fontes achadas. Leitura do ERP com três estados: ausente ≠ inválido ≠ válido
(os diagnósticos C3/C5/D8/D9 morrem; a pasta fiscal usa a forma canônica). ⚠️ **A conferir no DOC-ICP-04**: OID do titular PF, OID do responsável no
e-CNPJ (que traz CPF — ter CPF não é ser e-CPF), formato exato do `serialNumber` no SE-S — **sem amostra real de SE-S, não codificar por suposição**.

### 4.5 Fronteira com o fisco (G6 → Q-CJ7)

**Regra: o dado NOSSO sai conforme o leiaute oficial do ambiente; o dado do TERCEIRO entra pela forma geral e volta como veio.** Leitura (voz): chave,
Id e inscrição conferidos pela forma geral da RFB + coerência com o que perguntamos, em qualquer ambiente/versão, sem tirar caractere, sem DV
presumido — ler mais estrito que o fisco faz de uma NFS-e AUTORIZADA um 502 ambíguo (D12); precedentes: `exactDigits` da IB-3 e a D16; atinge
D7/D12/D13/D14/D16/D17/D20/D21; nunca copiar o padrão de chave do XSD de H (defeito nas posições 7–20). Eco: a chave vai no cancelamento como veio
(D5/D6). **Escrita** (emitente, tomador, Id do DPS — D2/D3/D4/D18): pelo `layout-calendar.ts` (linha nova por DEPLOY, nunca flag) — **achado: o
calendário precisa identificar o LEIAUTE (o XSD publicado), não a versão** (H e P têm a mesma 1.01 com gramáticas diferentes); H aceita letra; P recusa
local 422 legível ANTES de reservar o nDPS até a linha mudar; o `padStart(14,'0')` do Id fica só para o CPF. **A leitura tolerante vem antes e não
depende do resto** (o escritor nunca produz o que o leitor não lê); a D12 não é provável por nós em H (a Setes é numérica) — defesa por construção com
vetor sintético de chaves.

### 4.6 Boleto, ISPB e pesquisa

- **Boleto (G9 → Q-CJ10)**: o erro é só o `replace(/\D/g,'')` (A15); o PF × PJ já está certo. **S3 é o estrago mais grave da frente** (CNPJ com letras
  apagadas pode virar 11 dígitos enviados como JURÍDICA — boleto no documento de outra pessoa). A forma canônica é conforme o contrato do Inter (texto
  11–18) — confirmar no sandbox antes de abrir a porta. `ChargePayer.document` + `personType` viram um `FederalId`; o contrato de `bank-channel/types.ts`
  deixa de dizer "só dígitos"; o teste A23 inverte.
- **ISPB**: o produto não guarda nem usa — nada agora; quando Pix/TED nascerem, ISPB é texto `[0-9A-Z]{8}` (sem coluna antes de consumidor).
- **Pesquisa (G8 → Q-CJ9)**: a inscrição é identificador POSICIONAL — o pedaço com significado é o PREFIXO (as 8 primeiras = raiz da empresa); "contém"
  não significa nada (`%315%`) e "0001" não significa matriz. O `digits: true` no kind `text` vira kind próprio `federalId` (D-BA4: o operador é da peça
  pelo kind) — normaliza pela peça (caractere estranho = 422), `LIKE 'X%'` com `escapeLike` sobre CPF ou CNPJ; morrem "Informe só números" e o teste
  A24; by-document (A8) e fiscal-exists (A9) canonicalizam e comparam por igualdade.

### 4.7 Maquetes e palavras ocupadas

**Maquetes**: normalizar apagando (`stripNonDigits`/`digits()`/`digitsOf`/`cnpjDigits`, ~13 cópias) · PF × PJ pelo comprimento depois de limpar · "14
dígitos" copiado (6 cópias no app) · coluna/flag/tabela de "formato/versão" do CNPJ ("novo ⇒ letra" é falso) · config/env "aceitar alfanumérico" (o
mesmo erro do "Ativar Reforma" do legado) · CNPJ do certificado lido do CN, ou "a primeira fonte que casa vence" · leitor da voz mais estrito que o
fisco · "toda porta normaliza" segurando a UNIQUE, ou `bin` sem CHECK · `digits: true` na pesquisa · máscara configurável no CPF/CNPJ · DV presumido
na chave da NFS-e · recortes posicionais copiados (`slice(8,23)`/`slice(10,25)`) · veto de letra inventado (I/O/U/Q/F caiu) · sentinela `'0'` numa coluna
de identidade com UNIQUE.

**Palavras ocupadas** (entram na tabela do guardião ao fechar a Rodada 1): **documento** (documento FISCAL — nota/DPS/NF-e/evento — × CPF/CNPJ; código
novo usa "inscrição federal"/`federalId` para o 2º) · **inscrição** (`tpInsc` federal × IE × IM — dizer qual) · **dígitos/digits** (reservado ao que é
numérico — CEP, fone, IBGE, CPF; o CNPJ é "letras e números") · **normalizar** (canonicalizar e recusar o resto; nunca apagar) · **validar (CNPJ)** (forma
+ DV; não é consultar a RFB) · **máscara** (máscara configurável `#`/`A` × formatação da inscrição) · **chave** (letra só nas posições da inscrição; DV da
chave NFS-e é do fisco) · **matriz** ("0001" não garante) · **taxpayer** (en: "contribuinte do ICMS" — não usar para CPF/CNPJ).

**Resumo no formato da skill** — conceito: a inscrição federal identifica uma pessoa perante a RFB · peça: `FederalId` (tipo de valor); a chave de
acesso é OUTRA peça; `mod11` ASCII − 48 = primitiva partilhada (DV do CNPJ e da chave da NF-e) · reusadas: calendário de leiaute (IB-3), CHECK binário
com sonda pelo nome (§11 regras 11/16), CHECK de formato (§5), `expected` (D-N3), superfície pública do núcleo, toggle triplo, kind da pesquisa
(D-BA4), "conferido, nunca normalizado" (IB-3), cercas por teste, worktree do núcleo (regra 17) · não entrou: tipo/tamanho de coluna, troca de
colação, flag de formato, config "aceita alfanumérico", consulta à RFB, DV da chave NFS-e, ISPB, IE/IM, vetos de letra, NF-e, sync, S6 · nomes:
`federal-id`/`FederalId`/`normalizeCnpj`/`isValidCnpj`/`formatCnpj`; kind `federalId`; `CertificateInfo.holder`; `ck_company_cnpj_form`;
`ck_establishment_certificate_cnpj_form`; cerca `federal-id-fence`.

## 5. Ondas propostas (guardião; esforço estimado pelo condutor — sessão ≈ 4 h com testes verdes, ±40 %)

Princípio (G7 → Q-CJ8): **a porta do cadastro só abre quando todo consumidor que hoje mutila o valor já lê certo ou recusa de forma legível.**

| Onda | Entrega | Sessões | Depende de |
|---|---|---|---|
| **0 — peça e leitores** (urgente; não depende de leiaute) | `FederalId` TS (núcleo, worktree) + Dart com o vetor oficial; certificado por CONSENSO (vale para CNPJ numérico); leitura tolerante da chave/Id na nfse-api (fecha a D12); pesquisa com kind `federalId` (S1 estraga hoje); boleto sem `\D`; diagnósticos "ausente ≠ inválido"; cerca `federal-id-fence`; janela de deploy do núcleo | 3–5 | Q-CJ1 (acervo), amostra real de SE-S para o certificado |
| **1 — abrir a porta** | os 5 DTOs + prefill; o campo do app (formatter, teclado, pendências); o CHECK de forma (depois da auditoria e do acordo com o sync); a NFS-e pelo calendário por LEIAUTE (H aceita, P recusa legível); i18n/Swagger/catálogo de erros; testes A23/A24 invertidos | 3–4 | onda 0; acordo com o grupo do sync |
| **2 — espera o oficial** | linha de P no calendário (por deploy) quando o leiaute de produção aceitar; o Inter conforme a sonda do sandbox; a NF-e pela frente própria (NE-1b/NE-4) | 1–2 | publicação oficial; sandbox do Inter |
| **paralelo (outro grupo)** | pedido ao grupo do sync (o CHECK é o contrato) — tarefa separada sugerida | — | — |

## 6. ⚠️ Rodada 1 — questões para o Valdo (recomendação entre parênteses; numeração Q-CJ/D-CJ)

- **Q-CJ1 Acervo oficial** (G12) — arquivar em `Infra-IA/setes-api/integracoes/cnpj-alfanumerico/` (molde do `nfse-adn`), cada download com o "vai"
  (nome, origem e tamanho — refazer o HEAD na hora): Perguntas e Respostas da RFB (782 KB) · Manual do DV (702 KB) · NT 009 v1.01 (já no acervo da
  NFS-e) · os DOIS XSD 1.01 da NFS-e — produção restrita `esquemas-nfse-rtc-v1-01-20260727.zip` (34 KB) e produção (já no acervo) · DOC-ICP-04 v8.3
  compilado (716 KB) · DRN do Bacen v1.02 (354 KB) · contrato do Inter (já no acervo do banco). *(Rec.: sim — sem o XSD de H arquivado, a linha do
  calendário não tem fonte.)*
- **Q-CJ2 Onde mora a fonte TS da peça** (G1): (a) **núcleo `fiscal-api/federal-id` (superfície pública pura), com `@shared/validation` reexportando
  e o Dart em `setes_validators`, espelho garantido por um vetor oficial de casos lido pelas duas suítes** · (b) setes-api, com o núcleo copiando.
  *(Rec.: (a) — nuance da decisão 18 dos campos configuráveis: a superfície fica, a implementação vira uma só.)*
- **Q-CJ3 Contrato das portas de escrita** (G2): (a) **a API aceita só a forma canônica e recusa o resto com `fields[].expected` (decisão 19 + "o que
  valida é o que grava"); as LEITURAS canonicalizam a entrada** · (b) a API canonicaliza tudo. *(Rec.: (a).)*
- **Q-CJ4 Forma no banco** (G3): (a) `_ci` + normalizar nas portas · (b) `utf8mb4_bin` · (c) **colação mantida + CHECK BINÁRIO de forma provado no
  boot (também em `fiscal_api.tb_establishment_certificate.cnpj`), com a correção do CHECK da 067** — depois da auditoria dos dados vivos e do acordo
  com o grupo do sync. *(Rec.: (c).)*
- **Q-CJ5 Sentinela `'0'`** de `tb_company.cnpj` (G4 — `DEFAULT '0'` + UNIQUE): (a) **auditar quem grava; o CHECK o tolera explicitamente até decidir;
  "sem documento" já é `tb_no_doc`; a saída do DEFAULT vai à revisão do sync** · (b) remover já. *(Rec.: (a).)*
- **Q-CJ6 Certificado por CONSENSO das fontes** (G5 — serialNumber × OID 2.16.76.1.3.3 × CN legado; divergência = 409): (a) **na onda 0, depois de
  arquivar o DOC-ICP-04 v8.3 e conseguir uma amostra REAL de SE-S** · (b) codificar já pela norma. *(Rec.: (a) — vale para CNPJ numérico; não codificar
  por suposição.)*
- **Q-CJ7 NFS-e com letra em produção** (G6): (a) **recusa local legível pelo XSD oficial de P (D-NE29 ao pé da letra), linha nova no calendário (por
  LEIAUTE, não por versão) por deploy quando mudar; H aceita já** · (b) enviar e o fisco decide (cada recusa consome um nDPS) · (c) (a) + tentativa
  controlada no 1º caso real, com o "vai". *(Rec.: (a), com a porta (c) aberta.)*
- **Q-CJ8 Ordem das ondas 0 → 1 → 2, leitores antes da porta** (G7). *(Rec.: sim.)*
- **Q-CJ9 Pesquisa por documento** (G8 — diverge da D-BA20/21): (a) **PREFIXO com kind próprio `federalId`** · (b) "contém" com a normalização certa
  · (c) só igualdade. *(Rec.: (a) — a raiz de 8 posições é o pedaço com significado.)*
- **Q-CJ10 Boleto** (G9): (a) **sonda no sandbox do Inter antes da onda 1: aceitou → envia a forma canônica; recusou → recusa local legível; mutilar
  NUNCA** · (b) enviar sem sonda. *(Rec.: (a).)*
- **Q-CJ11 Máscara configurável no CPF/CNPJ** (G10): (a) **o campo sai do motor de máscara configurável (a formatação é fato da RFB)** · (b) o motor
  ganha o símbolo "letra ou dígito". *(Rec.: (a); conferir se há linha em `tb_institution_has_field` com máscara de cnpj.)*
- **Q-CJ12 Cerca contra regressão** (G11 — molde `time-zone-fence`/`voice-kind-fence`): proíbe `replace(/\D/g…)` sobre inscrição e chave, com lista
  branca CEP/fone/IBGE/CPF. *(Rec.: sim.)*
- **Q-CJ13 Fora da frente** (G13): a falha ao gravar o XML autorizado gera só aviso no log (S6/D19 — independe de letra). *(Rec.: tarefa própria na fase
  fiscal.)*

## 7. Fora desta frente / outro grupo

- **setes-sync e sincronizador** (regra dos dois grupos): indexam a entity por CPF/CNPJ (`setes_central.tb_company.cnpj`, `tb_sync_conflict.document`) e
  o Firebird do legado guarda CNPJ — o grupo do sync faz o próprio inventário e a própria correção (tarefa separada).
- **NF-e**: já nasce aceitando (D-NE29) — a chave e o Code-128 híbrido estão no acervo da nfe-api e entram na NE-1b/NE-4.

## 8. ⏯ PROMPT DE RETOMADA (colar numa sessão nova)

```
Retome a frente de PRODUTO "CNPJ alfanumérico" (Gestão 2027): D:\Gestao2027\Infra-IA\prompts\prompt_frente_cnpj_alfanumerico.md
(Rodada 0 ORGANIZADA: §2 fatos oficiais, §4 parecer do guardião, §5 ondas 0/1/2; anexo prompt_frente_cnpj_alfanumerico-inventario.md com os
110 pontos). Apresente-me a Rodada 1 (Q-CJ1…Q-CJ13 do §6) com as recomendações; quando eu decidir, registre D-CJ1… no §6.x, faça os downloads
da Q-CJ1 (só com o meu "vai", nome/origem/tamanho por HEAD) e siga a ordem do §5 (onda 0 primeiro — núcleo em WORKTREE, PADROES §11 regra 17).
Regra dos dois grupos: NÃO ler setes-sync nem sincronizador (tarefa separada). Atualize a cadeia (INDICE_CENTRAL, CLAUDE.md da raiz, memória).
```
