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
**Estado (2026-10-15)**: Rodada 0 ORGANIZADA — inventário (anexo), fatos oficiais (§2), parecer do guardião INTEGRADO (§4), ondas (§5);
PUBLICADA (infra 024f914). **Rodada 1 DECIDIDA ("siga as recomendações" → D-CJ1…D-CJ13, §6.1)**; **onda 0 EXECUTADA em worktree com gates
socrático 0,76 / adversarial 0,82 (§8)**; **rodada 2 DECIDIDA (D-CJ14…D-CJ18, §8.8) e ONDA 1 EXECUTADA em worktree (2026-10-16, §8.9) com gates
socrático 0,74 / adversarial 0,80 e retrabalho na sessão (§8.10)**; **rodada 3 DECIDIDA (D-CJ19…D-CJ22, §8.11) e D-CJ19 EXECUTADA com gates
do delta 0,75/0,72 (§8.12)** — commits LOCAIS no branch `cnpj`, nada publicado; ⏯ **rodada 4 (Q-CJ23…Q-CJ27, §8.12) e a JANELA (§8.5 —
pela D-CJ21, só a onda 0 enquanto o grupo do sync não responder) aguardam o Valdo; retomar pelo §9.**

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

### 6.1 Rodada 1 DECIDIDA (2026-10-15, Valdo: "siga as recomendações") — D-CJ1…D-CJ13

Antes da apresentação, auditoria só-leitura do banco vivo (anexo §8.1): 249 CNPJ em `tb_company`, TODOS `^[0-9]{14}$`, zero `'0'`, zero
letra/minúscula; certificado do `fiscal_api` numérico; nenhum campo CPF/CNPJ no catálogo de campos configuráveis e nenhuma máscara configurada.

- **D-CJ1** (= Q-CJ1 (Rec.)): acervo em `Infra-IA/setes-api/integracoes/cnpj-alfanumerico/` (molde `nfse-adn`, README com origem/data/SHA-256);
  5 documentos NOVOS — Perguntas e Respostas da RFB · Manual do DV · XSD 1.01 da produção restrita da NFS-e (`esquemas-nfse-rtc-v1-01-20260727.zip`)
  · DOC-ICP-04 v8.3 compilado · DRN do Bacen v1.02; os outros 3 (NT 009 v1.01, XSD 1.01 de produção, contrato do Inter) já estão nos acervos e são
  só REFERENCIADOS. Cada download com o "vai" do Valdo (nome, origem e tamanho pelo HEAD da hora).
- **D-CJ2** (= Q-CJ2 (a)): fonte TS ÚNICA no núcleo, superfície pública pura e sem banco `fiscal-api/federal-id` (molde `fiscal-api/reading`, D-F33),
  reexportada pelo `@shared/validation` do setes-api; Dart em `setes_validators`; o espelho TS × Dart é garantido por UM vetor oficial de casos
  (JSON) lido pelas duas suítes. Nuance da decisão 18 dos campos configuráveis: a superfície fica, a implementação vira uma só.
- **D-CJ3** (= Q-CJ3 (a)): as portas de ESCRITA aceitam só a forma canônica e recusam o resto com `fields[].expected` (decisão 19 + "o que valida é
  o que grava"); as LEITURAS (prefill by-document, fiscal-exists, pesquisa) canonicalizam a entrada.
- **D-CJ4** (= Q-CJ4 (c)): colação mantida + CHECK BINÁRIO de forma provado no boot pelo nome (`ck_company_cnpj_form`,
  `ck_establishment_certificate_cnpj_form`) + o CHECK da 067 ganha `COLLATE utf8mb4_bin`; pré-condições: auditoria (FEITA — §8.1 do anexo, 0
  linha fora da forma), prova em schema descartável do `ADD CONSTRAINT` do MariaDB 10.4 sobre linhas existentes, e **acordo com o grupo do sync
  ANTES do DDL** (o CHECK é o contrato entre os grupos). Entra na onda 1.
- **D-CJ5** (= Q-CJ5 (a)): o CHECK tolera o sentinela `'0'` explicitamente até a decisão; "sem documento" já é `tb_no_doc`; a saída do
  `DEFAULT '0'` vai à revisão do sync. Hoje nenhuma linha tem `'0'`.
- **D-CJ6** (= Q-CJ6 (a)): o titular do certificado por CONSENSO das fontes (OID 2.16.76.1.3.3 × `serialNumber` 2.5.4.5 × CN legado; divergência =
  409 "certificado incoerente"; nenhuma = 409 "sem a inscrição do titular"), codificado na onda 0 SÓ depois de arquivar o DOC-ICP-04 v8.3 e ter
  uma amostra REAL de SE-S. Risco aceito: um A1 no perfil novo chegar antes quebra o upload (vale para CNPJ numérico) — o certificado é a 1ª
  coisa a destravar quando a amostra existir.
- **D-CJ7** (= Q-CJ7 (a), porta (c) aberta): o dado NOSSO sai conforme o leiaute oficial do ambiente — H aceita letra já; P recusa local legível
  (422, ANTES de reservar o nDPS) enquanto o XSD de produção for numérico; o `layout-calendar.ts` passa a identificar o LEIAUTE (o XSD publicado),
  não a versão; linha nova por deploy, nunca flag; tentativa controlada no 1º caso real só com o "vai". O dado do TERCEIRO (voz) entra pela forma
  geral e volta como veio — a leitura tolerante vem antes e não depende do resto.
- **D-CJ8** (= Q-CJ8): ondas 0 → 1 → 2; a porta do cadastro só abre quando todo consumidor que hoje mutila o valor já lê certo ou recusa legível.
- **D-CJ9** (= Q-CJ9 (a); DIVERGE da D-BA20/21 no critério "Documento"): pesquisa por PREFIXO com kind próprio `federalId` (o operador é da peça
  pelo kind — D-BA4); normaliza pela peça (caractere estranho = 422); `LIKE 'X%'` com `escapeLike`; morre o "Informe só números".
- **D-CJ10** (= Q-CJ10 (a)): sonda no sandbox do Inter ANTES da onda 1 — aceitou → envia a forma canônica; recusou → recusa local legível; mutilar
  NUNCA (o `replace(/\D/g,'')` do pagador sai na onda 0).
- **D-CJ11** (= Q-CJ11 (a)): CPF/CNPJ saem do motor de máscara configurável (a formatação é fato da RFB); nenhum dado configurado a migrar (§8.1).
- **D-CJ12** (= Q-CJ12): cerca `federal-id-fence` (molde `time-zone-fence`/`voice-kind-fence`) proíbe `replace(/\D/g…)` sobre inscrição e chave,
  com lista branca CEP/fone/IBGE/CPF.
- **D-CJ13** (= Q-CJ13): S6/D19 (falha ao gravar o XML autorizado vira só aviso no log) é tarefa própria da fase fiscal, fora desta frente.

## 7. Fora desta frente / outro grupo

- **setes-sync e sincronizador** (regra dos dois grupos): indexam a entity por CPF/CNPJ (`setes_central.tb_company.cnpj`, `tb_sync_conflict.document`) e
  o Firebird do legado guarda CNPJ — o grupo do sync faz o próprio inventário e a própria correção (tarefa separada).
- **NF-e**: já nasce aceitando (D-NE29) — a chave e o Code-128 híbrido estão no acervo da nfe-api e entram na NE-1b/NE-4.

## 8. Onda 0 — EXECUTADA em worktree (2026-10-15)

Worktrees irmãs (PADROES §11 regra 17): `D:\Gestao2027\cnpj\{fiscal-api,nfse-api,setes-api,setes-app}`, branch `cnpj` a partir do `main`
(núcleo 945ad2d · nfse ba78074 · api e4af7aa · app fbc2fac). **Nada na árvore viva**; o merge é a JANELA (§8.5). O `.env` e o `package-lock.json`
do setes-api foram COPIADOS da árvore viva (não versionados — como nas worktrees `ib3`/`f2a`).

### 8.1 Acervo (D-CJ1) — ARQUIVADO

`Infra-IA/setes-api/integracoes/cnpj-alfanumerico/` (README com origem, bytes e SHA-256; texto extraído ao lado de cada PDF): Perguntas e Respostas
da RFB · Manual do DV · XSD 1.01 da produção restrita (10 XSD extraídos) · DOC-ICP-04 v8.3 (o do link principal, já com a Res. 215/2025 — o PDF
rotulado "V.8.3" da lista de versões é a mesma versão SEM a 215, descartado) · DRN do Bacen v1.02. Fatos NOVOS lidos no arquivo:
- **DOC-ICP-04 v8.3 não tem mais o tipo "A1"**: usuário final = A3/A4 (só PF), **SE-S/SE-H (selo eletrônico, só PJ — PC 2.16.76.1.2.201.n/202.n)**,
  T3/T4, AE-S/AE-H, A CF-e-SAT, OM-BR. Perfil SE-S: `CN = <Razão Social>`, **`serialNumber = <número CNPJ>`** (o documento não diz se com máscara);
  OID 2.16.76.1.3.3 "obrigatório com restrição" até 31/12/2028 "para que as aplicações possam ser ajustadas" ao `serialNumber`. Reforça a D-CJ6.
- **XSD de produção restrita × produção** (mesma 1.01): tabela no README; o defeito do `TSChaveNFSe` de H tem ORIGEM — é o padrão da chave de 44
  da NF-e (`[0-9]{6}([0-9A-Z]{14})[0-9]{24}`, no mesmo XSD) colado na chave de 50; o `TSIdNFSe` e o Id do pedido de evento (`PRE` + 8 dígitos +
  tpInsc + 14) põem a inscrição nas posições certas (10–23).
- Manual do DV: exemplo resolvido `12.ABC.345/01DE-35` (somatórios 459 e 424) — entrou no vetor.

### 8.2 O que mudou (códigos do inventário)

- **Núcleo (fiscal-api)** — peça pura `src/federal-id/federal-id.ts` (`FederalId`, `CNPJ_FORM`, `mod11Ascii48` — primitiva partilhada com o DV
  da chave da NF-e —, `cnpjCheckDigits`, `canonicalizeFederalIdText`, `normalizeCnpj/Cpf`, `isValidCnpj/Cpf`, `formatCnpj/Cpf`, `federalIdOf`,
  `readFederalIdFact` em TRÊS estados com o sentinela `'0'` = ausente — D-CJ5) + vetor oficial `federal-id.vector.json` + subpath
  `fiscal-api/federal-id` (package.json `exports`/`typesVersions`; cerca `ne1a-superficie` admite o 2º subpath). C3 (A1 conferido contra o fato
  em três estados — "CNPJ inválido no cadastro" ≠ "sem CNPJ"), C5 (`establishmentCnpjFact` + `establishmentCnpj` só válido), C7 (pasta fiscal
  pela forma canônica — nunca outra pasta). **C1/C2 (CNPJ do CN do certificado) NÃO mexidos** — D-CJ6: consenso das fontes só com amostra real
  de SE-S.
- **nfse-api** — peça `src/authority/access-key.ts` (OUTRA peça: forma geral da chave `^[0-9]{9}[0-9A-Z]{12}[0-9]{29}$` e do Id do DPS
  `^DPS[0-9]{8}[0-9A-Z]{12}[0-9]{22}$` — letra só nas 12 primeiras posições da inscrição, sem presumir o domínio do tpInsc; `issuerOf*` +
  `sameEmbeddedIssuer` num lugar só; DV da chave NFS-e NUNCA calculado). Leitores: D12 (`asAccessKey` pela forma geral — chave alfanumérica
  AUTORIZADA vira voz A), D13 (`looseKeyOf`: tira só a formatação — D-F88 preservada —, as letras ficam), D14 (`GET /dps` acha a chave pela forma
  geral e confere o emitente pela peça), D15/D16 (substituta pela peça), D17 (nome do arquivo = a chave como é), D5 (o pedido de cancelamento
  ECOA a chave). Fonte de fatos: D8/D9 (emitente em três estados; o caminho feliz segue com UMA leitura), D10 (tomador PF × PJ pelo LUGAR, três
  estados — o CNPJ de 3 letras nunca mais vira `<CPF>`), e o CNPJ alfanumérico VÁLIDO de emitente/tomador é **recusado legível (422) antes de
  reservar o nDPS até a onda 1** (`DPS_NUMERIC_CNPJ` — o escritor pelo calendário de leiaute é da onda 1). D20/S7 (DANFSe formata pelo ELEMENTO
  `<CNPJ>`/`<CPF>`, fora do `DanfseFields` — paridade N17 com o oráculo congelado; chave agrupada de 4 em 4 com letra).
- **setes-api** — `@shared/validation` REEXPORTA a peça do núcleo (A1/A2 — a superfície da decisão 18 fica, a implementação vira uma só);
  `stripNonDigits` MORREU (A3). Pesquisa: kind `federalId` = PREFIXO canonicalizado (A13/A14 — S1, o que estragava HOJE; 422 legível para
  caractere estranho, só máscara, > 14); o `digits` do critério morreu. `by-document`/`fiscal-exists` canonicalizam a entrada (A8/A9 — D-CJ3).
  Boleto: pagador na forma canônica, três estados, CNPJ com letra recusado legível até a sonda (A15/A16 — S3; teste A23 INVERTIDO). A **porta do
  cadastro segue numérica** (`companyBody` `^\d{14}$` — D-CJ8, comentado no código). Swagger: kind `federalId` nas 23 rotas `search-criteria`
  e a nova semântica do `by-document`/`fiscal-exists`.
- **setes-app** — espelho Dart `packages/setes_validators/lib/src/federal_id.dart` (`FederalIdRules`/`FederalId`), lendo o MESMO vetor do núcleo
  pela pasta-irmã (`FISCAL_API_DIR` sobrescreve; sem o arquivo FALHA ALTO); `SetesValidators.isValidCnpj/Cpf` delegam (B1/B2). Painel da pesquisa
  avançada com o kind `federalId` (validação local = a mesma canonicalização; i18n pt/en `search.federalIdHint/Invalid/TooLong`). App ANTIGO
  descarta o kind desconhecido (L4) — API e app sobem em qualquer ordem (no pior caso o "Documento" some do painel até o app novo).
- **Cercas D-CJ12** — `federal-id-fence` por AST nos 3 repositórios TS (lista branca com MOTIVO: conta bancária, CEP, filtro de código NBS,
  IBGE, CEP do tomador e o `digits()` do montador da nfse-api — este último "vence na onda 1") + gêmea Dart em `apps/web/test` (o `cnpjDigits` e a
  validação do CNPJ do formulário "vencem na onda 1"). A lista não apodrece (entrada que sumiu quebra).

### 8.3 Testes (worktrees)

Depois dos gates e do retrabalho (final): núcleo **633** (era 531) · nfse-api **949** (era 823 + 1 falha + 1 suíte que não rodava — ver 8.4) ·
setes-api **1996** (127 suítes; 31 pulados) · setes_validators **92** · app **631** (28 pulados). Typecheck limpo nos 3 TS; `flutter analyze` limpo
na pesquisa, na cerca e no pacote. Fixtures que só passavam porque o código olhava o COMPRIMENTO (CNPJ `12345678000199`/`98765432000188` com DV errado, CNPJ gravado
COM máscara no ERP falso) trocados por CNPJ de DV válido na forma canônica — em ~30 arquivos da nfse-api e 4 do setes-api/núcleo.

### 8.4 Pré-existente corrigido de passagem

Na nfse-api do `main`, 2 testes dependiam do fim de linha da CÓPIA (`autocrlf` no Windows): `adversarial-r22-gate` (`[^\n]*` capturava o `\r`) e
`adv-ib3-xml` (a suíte nem rodava — `\/\n` sobre um arquivo CRLF). Agora `[^\r\n]*` e `\/\r?\n`.

### 8.5 JANELA de deploy (precisa do "vai" do Valdo — nada foi publicado)

Ordem (o setes-api de produção roda `tsx watch` na árvore viva e resolve `fiscal-api/federal-id` pelo `dist` do núcleo VIVO — `dist/` NÃO é
versionado; a nfse-api resolve o núcleo pelo `src`, também em `tsx watch`): (1) NÚCLEO vivo: merge `cnpj` → `main` em fast-forward +
`npm run build` + PROVA `node -e "require('fiscal-api/federal-id')"` executado DE DENTRO de `D:\Gestao2027\setes-api` (o `dist` com `federal-id`
tem de existir ANTES do passo 3 — sem ele o `@shared/validation` não carrega e o ERP inteiro cai no boot); (2) nfse-api viva: merge (o watch
reinicia — o checklist do `nfse-api/INDEX.md` confere o núcleo vivo limpo e no commit esperado) + DANFSe de uma nota de H e uma transmissão em H
como prova (as funções novas só falham NA CHAMADA, não no boot nem no /health — gate socrático); (3) setes-api vivo: merge (o `tsx watch`
recarrega) + /health + uma pesquisa "Documento"; (4) app: merge + `build-web.ps1`. Sem DDL nesta onda. Push dos 4 repos + Infra-IA depois.
Q-CJ14 (§8.7) decide se o boot do setes-api passa a PROVAR a peça carregada.
**D-CJ21 (2026-10-16) recorta a janela por COMMIT**: sem o retorno do grupo do sync, a janela leva SÓ a onda 0 — `git merge --ff-only` até
núcleo 4b17b23 · nfse 62c5fcf · api f53a618 · app 2f621c1 (nunca a ponta do branch `cnpj`); a onda 1 e o retrabalho dos gates (§8.9–§8.12)
seguem juntos, na mesma ordem, depois do retorno. Se o sync responder antes, uma janela só com a ponta.

### 8.6 Fica para a onda 1 (D-CJ8)

A porta: os 5 DTOs (`companyBody`) + o campo do app (formatter, teclado, pendências B7–B15, `cnpjDigits` — S2) + o CHECK de forma (D-CJ4, depois do
acordo com o grupo do sync) + o escritor do DPS pelo calendário por LEIAUTE (D-CJ7 — D2/D3/D4/D6/D18 e o `CNPJAutor`) + textos/catálogo de erros
"14 dígitos" (A21/B18) + `ChargePayer` como `FederalId` (parecer §4.6). O certificado por consenso (D-CJ6) entra quando houver amostra real de
SE-S. A sonda do Inter (D-CJ10) antes da onda 1.

### 8.7 Gates da onda 0 (2026-10-15) — PASSARAM, com retrabalho na sessão

- **Socrático 0,76 ✅** (revisor independente). Corrigido na sessão: (1) a borda do upload do A1 na nfse-api (`modules/emitter/emitter.service.ts`)
  passa o FATO em três estados (`establishmentCnpjFact`) — com o valor achatado, DV errado ainda virava "sem CNPJ"; (2) `buildDpsId` recebe a
  inscrição COMO É (CNPJ 14 dígitos / CPF 11) e LANÇA no resto — o `digits()` SEM tamanho tirava letras e completava com zeros, e o Id é
  write-once na vida da nota (cenário da onda 1: H aberto, o Id nasceria mutilado e a correção cairia em 409 `FISCAL_DPS_ID_CHANGED`).
  Conferido por ele: a forma da chave segue a formação da RFB; o `looseKeyOf` não confunde chaves (conferido contra o `<chNFSe>` real da nota 707).
- **Adversarial 0,82 ✅, sem HIGH/CRITICAL** (revisor independente; 171 ataques em 4 arquivos de teste NOVOS e PERMANENTES —
  `adversarial-cnpj-onda0-gate.test.ts` no núcleo (44), na nfse-api (39) e no setes-api (58) + `adversarial_cnpj_onda0_gate_test.dart` no
  setes_validators; resistiram: o BMP inteiro no meio do texto, 5.000 raízes aleatórias de DV contra oráculo independente, 20.000 CNPJ numéricos
  com decisão idêntica à do algoritmo antigo, injeção no `federalId`, todos os DTOs de papel recusando letra). Os 4 LOW CORRIGIDOS na sessão
  (testes `[CORRIGIDO na sessão — ACHADO LOW]`): (a) a CERCA via só regex literal em `.replace` — o predicado saiu para um arquivo GÊMEO idêntico
  nos 3 TS (`src/__tests__/federal-id-fence.ts`; no setes-api `src/test-setup/` — o jest de lá roda todo .ts de `__tests__`) e pega regex em
  qualquer posição, `RegExp` construído, coleta de dígitos, remoção de letras e filtro por '0'/'9' (as 9 formas que escapavam são SONDAS); a
  cerca Dart varre o arquivo inteiro (RegExp sem raw, argumento na linha de baixo, classes, `'0123456789'.contains`) com CONTAGEM por arquivo —
  o `cnpjDigits` e a validação do CNPJ do formulário estão marcados "vencem na onda 1"; (b) o espelho Dart aparava o NEL (U+0085) e o TS não —
  o Dart apara pelo `\s` do RegExp (semântica ECMAScript) e o vetor oficial ganhou NEL e NBSP; (c) `GET /dps`: campo DECLARADO manda — presente e
  fora da forma = 502, a busca no texto só sem campo (ela achava a `chaveSubstituta`); (d) `readFederalIdFact` só lê texto/número/Buffer (array ou
  objeto = inválido) e `isFederalIdFact` reconhece o fato pela forma (array no `validateIssuerPair` = 422, não 500).
- **Questões para a rodada 2 (recomendação entre parênteses)**:
  - **Q-CJ14 Prova da peça no deploy/boot**: (a) só o passo de prova no roteiro da janela (§8.5) até a F3 trocar a produção para o `dist`
    versionado · (b) o boot do setes-api prova a peça carregada (versão/hash do vetor) e falha alto. *(Rec.: (a) agora; (b) com a F3.)*
  - **Q-CJ15 Cerca pelo VALOR**: a cerca hoje vigia o padrão; o `digits()` do montador ainda recebe o CNPJ do prestador/tomador/autor (sempre com
    tamanho — lança). (a) a onda 1 tira a inscrição do `digits()` (escritor pelo calendário) e a cerca passa a acusar helper de dígitos aplicado
    a campo de inscrição · (b) já agora. *(Rec.: (a) — o caminho silencioso, o `buildDpsId`, já foi fechado na sessão.)*
  - **Q-CJ16 Leitura de documento JÁ autorizado com o cadastro fora da forma**: XML/DANFSe/selo pegam o CNPJ do estabelecimento estrito (forma +
    DV); se o setes-sync regravar o cadastro fora da forma antes do CHECK (onda 1), a 2ª via vira 422. (a) manter estrito e pôr o acordo com o
    grupo do sync como pré-requisito da onda 1 · (b) a leitura do ARQUIVO canonicaliza o CNPJ gravado (máscara sai, minúscula sobe, sem DV;
    nunca apaga) — a emissão segue estrita. *(Rec.: (b) — D-CJ3 no espírito; hoje 249/249 na forma, risco baixo, mas a 2ª via não deve depender
    do cadastro de hoje.)*
  - **Q-CJ17 Cadastro sincronizado com CNPJ alfanumérico antes da onda 1**: o formulário do app ainda exige 14 dígitos — editar telefone/endereço
    de um cliente assim fica bloqueado por um campo que o usuário não tocou. (a) aceitar (hoje 0 casos; a onda 1 resolve) · (b) pedir ao grupo do
    sync um alerta até lá. *(Rec.: (a) + a onda 1 começa pelo campo do app.)*
  - **Q-CJ18 Pesquisa por prefixo sem ganho de plano**: o critério segue escalar correlacionado por linha (custo igual ao "contém" anterior; a
    UNIQUE central não é usada). (a) aceitar e medir na cerca M5 quando houver 10⁵ papéis · (b) semi-join pela UNIQUE escopado ao papel (forma
    nova de critério — parecer do guardião). *(Rec.: (a).)*

### 8.8 Rodada 2 DECIDIDA (2026-10-16, Valdo: "vamos finalizar a frente CNPJ alfanumérico e todos os transversais — cadastro de institution,
cliente, fornecedor, transportadora, nota de serviço — e depois voltamos [à nfe-api]" + "siga as recomendações") — D-CJ14…D-CJ18

- **D-CJ14** (= Q-CJ14 (a)): a prova da peça carregada fica no ROTEIRO da janela (§8.5); a prova no boot entra com a F3.
- **D-CJ15** (= Q-CJ15 (a)): a cerca passa a vigiar o VALOR (helper de dígitos aplicado a campo de inscrição) junto com o escritor do DPS — onda 1.
- **D-CJ16** (= Q-CJ16 (b)): a LEITURA de documento já autorizado (XML, DANFSe, selo, substituta) canonicaliza o CNPJ gravado do emitente (máscara
  sai, minúscula sobe, sem DV, nunca apaga); a EMISSÃO segue estrita (forma canônica + DV).
- **D-CJ17** (= Q-CJ17 (a)): aceito — 0 casos hoje; o campo do app abre nesta onda.
- **D-CJ18** (= Q-CJ18 (a)): prefixo sem otimizar o plano; medir na cerca M5 quando houver 10⁵ papéis.
- **D-CJ4 confirmada na ordem**: a onda 1 abre a porta com validação na API e no app; o DDL do CHECK fica PRONTO e PROVADO em schema descartável, e
  só é aplicado depois do acordo com o grupo do sync (tarefa separada aberta nesta data).
- **Publicação**: commit LOCAL no branch `cnpj` das 4 worktrees + Infra-IA agora (sem push, sem merge); onda 0 + onda 1 numa JANELA ÚNICA no fim,
  com o "vai".
- **Escopo do fecho**: depois desta frente, volta-se à nfe-api (NE-1b — a NF-e nasce com CNPJ alfanumérico, D-NE29). Valdo (2026-10-16): a sessão
  anterior foi retomar a nfe-api e caiu na NFS-e — a frente é TRANSVERSAL (a onda 0 não tinha o que mexer na nfe-api, que não tem emissão ainda);
  dizer isso de saída em qualquer retomada.

### 8.9 Onda 1 — EXECUTADA em worktree (2026-10-16) — a porta aberta nos transversais

Commits locais no branch `cnpj` (sem merge, sem push): onda 0 = núcleo 4b17b23 · nfse 62c5fcf · api f53a618 · app 2f621c1 (+ Infra-IA d2593e8);
onda 1 = núcleo 50271c4 · nfse a1bdcbd · api a44ce04 · app afa2b59. Tarefa SEPARADA do grupo do sync aberta (inventário + acordo do CHECK).

- **Cadastros (setes-api) — D-CJ3/D-CJ8**: `companyBody`/`personBody` pela peça (`federalIdIssue`): a porta dos 5 papéis (institution, cliente,
  fornecedor, transportadora, colaborador) aceita o CNPJ alfanumérico CANÔNICO; fora da forma mas canonicalizável → 400 com `fields[].expected`
  TEXTO = a forma canônica (só quando ela é VÁLIDA — máscara sobre DV errado não sugere nada); `FieldError.expected` virou `number | string`
  (aditivo à D-N3) e o `zodToFields` leva o `params.expected` do issue.
- **App — D-CJ8**: `CnpjInputFormatter` (literais nas posições do CNPJ numérico, minúscula sobe, DV só dígito, cursor no fim) + teclado de TEXTO
  (B9); julgamento ÚNICO `cnpjProblem`/`cpfProblem` (`shared/entity/domain/federal_id_check.dart`) para a marca inline E as 5 pendências — R3
  por construção (antes 6 cópias de "14 dígitos"; agora forma + DV); o objeto guarda e envia a forma canônica (`cnpjCanonical`; `cnpjDigits`
  MORREU — S2); `FailureField.expectedText` no core (o `as num?` derrubava o parse com texto); i18n "CNPJ inválido (12 letras ou números e 2 DV)".
- **NFS-e (nfse-api) — D-CJ7/D-CJ15/D-CJ16**: `layout-calendar.ts` por PACOTE XSD (`LAYOUT_SCHEMAS` com a fonte arquivada; `layoutLineAt`,
  `cnpjAlphanumericAccepted`): H aceita letra desde 10/08/2026 (implantação registrada no portal; XSD de 27/07), P segue numérico. A fonte de
  fatos devolve o FATO (o `DPS_NUMERIC_CNPJ` provisório da onda 0 saiu); `buildDpsBase` recusa legível (422 `FISCAL_DPS_INVALID` com o campo,
  ANTES de nDPS/tentativa/fisco) quando o leiaute do ambiente não aceita; o montador não usa mais `digits()` em inscrição (`cnpjForLayout`/
  `cpfForLayout`; `buildDpsId` aceita o CNPJ canônico; `buildDpsXml` confere o Id pelo leiaute — o literal "DPS" fica fora da conferência; o
  `CNPJAutor` segue o leiaute do EVENTO); `emitterCnpj` (leitura/arquivamento de documento já autorizado) canonicaliza o gravado sem DV (D-CJ16).
- **Cercas — D-CJ15**: regra 5 do predicado gêmeo (helper de dígitos aplicado a campo de inscrição alarma); o `digits()` do montador só cMun/CEP/
  fone/códigos; na cerca Dart saíram as entradas do formulário de entidade.
- **DDL do CHECK — D-CJ4**: RASCUNHO `prompt_frente_cnpj_alfanumerico-ddl-check-rascunho.sql` PROVADO em schema descartável (criado e apagado):
  o MariaDB 10.4 VALIDA as linhas existentes no `ADD CONSTRAINT`; com `COLLATE utf8mb4_bin` recusa minúscula/máscara/letra no DV; sem ele aceita
  minúscula (o defeito da 067); ⚠️ o `mysql2` rotula o errno 4025 como `ER_INNODB_AUTOEXTEND_SIZE_OUT_OF_RANGE` — conferir pelo NÚMERO. NÃO aplicado.
- **Testes (worktrees, depois da onda 1)**: núcleo 633 · nfse-api 960 · setes-api 2012 (128 suítes) · setes_validators 96 · core 79 · app 637.
- **Fica pendente (com motivo)**: o CHECK (acordo do grupo do sync); a sonda do Inter (D-CJ10 — o sandbox só atende seg–sex 8h–20h; até lá o
  boleto recusa CNPJ com letra, legível) e o `ChargePayer` como `FederalId` junto com ela; o certificado SE-S por consenso (D-CJ6 — amostra real);
  a linha de P no calendário quando o fisco publicar o XSD de produção com letra (onda 2); a NF-e nasce aceitando na nfe-api (NE-1b).

### 8.10 Gates da onda 1 (2026-10-16) — PASSARAM, com retrabalho na sessão

- **Socrático 0,74 ✅** (revisor independente; nenhum CRITICAL — os de maior peso MEDIUM). Conferido certo por ele: o 422 do leiaute em P vem
  antes de qualquer reserva em todo caminho de transmissão (um transmit só; o 0b depois do passo (c); throw dentro da reserva desfaz até o
  `dps_last_number`); o `expected` texto não quebra app antigo (que só envia dígitos); R3 por construção. Pontos abertos e destino:
  - **(e) pasta do arquivo fiscal / (b) `CNPJAutor` de documento JÁ autorizado** saem do CADASTRO de hoje, não do emitente embutido na chave →
    **Q-CJ19**. Corrigido na sessão só o que não depende de decisão: cancelar em P com o cadastro do emitente hoje alfanumérico dava 500 (o
    `cnpjForLayout` lançava DEPOIS da reserva K) → agora 422 `FISCAL_DPS_INVALID` legível ANTES de reservar (`nfse/transmission.ts`, teste
    "D-CJ7" em `transmission.test.ts`). O autor ≠ emitente quando o cadastro mudou para OUTRO CNPJ numérico segue na Q-CJ19.
  - **(a) a porta grava CNPJ com letra no central antes do CHECK e do inventário do sync** → **Q-CJ21**.
  - **(f) o `CnpjInputFormatter` APAGAVA o que não cabia** (contra a D-CJ2) → CORRIGIDO: a edição que traz caractere fora de `[0-9A-Za-z./- ]`,
    passa de 14 posições ou põe letra no DV NÃO ENTRA (fica o valor anterior; nada já digitado muda; colar "CNPJ 12.ABC…" não vira outra
    sequência de 14); literal só antes de um caractere seguinte; o cursor fica onde o usuário estava (`federal_id.dart`).
  - **(c) o calendário supõe linhas cada vez mais permissivas sem conferir** → teste de MONOTONIA (`cnpj-alfa-onda1.test.ts` da nfse-api: por
    documento × ambiente o "aceita letra" nunca volta atrás, e o EVENT aceita sempre que o DPS aceita — senão a nota autorizada com letra fica
    sem leiaute para o próprio cancelamento); a "tentativa controlada no 1º caso real" da linha de P → **Q-CJ22**.
  - **(10) a porta abriu sem a sonda do Inter (desvio da D-CJ10)** → **Q-CJ20**; corrigido na sessão: a recusa do boleto diz a SAÍDA ("cancele
    este boleto — nada foi ao banco; o título fica livre — e cobre por outro meio"), e o A1 de estabelecimento ALFANUMÉRICO cujo titular o
    leitor do CN não lê recebe 409 que diz o limite NOSSO ("o A1 não precisa ser trocado; a conferência entra com a leitura por consenso —
    D-CJ6"), nunca "não é um e-CNPJ" (`fiscal-api/src/secret/certificate.ts`; teste em `cofre.test.ts`).
  - Menores: a regra 5 reconhecia a inscrição só pelo NOME do argumento → CORRIGIDO (taint por escopo, abaixo); o `zodToFields` repassa
    `params.expected` de QUALQUER issue `custom` (só texto/número) — limite conhecido: pôr `expected` num issue é decisão explícita de quem escreve.
- **Adversarial 0,80 ✅, sem HIGH/CRITICAL** (revisor independente; 5 arquivos de teste NOVOS e PERMANENTES `adversarial-cnpj-onda1-gate` —
  setes-api, nfse-api, setes_validators, core, app web; resistiram: os 10 DTOs dos 5 papéis num fuzz de 6.000, o envelope `expected`
  número × texto sem conversão, app OK ⇔ API aceita o que o app ENVIA num fuzz de 8.000, P com letra = 422 antes de nDPS/tentativa/fisco
  inclusive com reserva em voo e com o ambiente virando H→P no meio). Os **9 LOW CORRIGIDOS na sessão** (testes `[CORRIGIDO na sessão — ACHADO
  LOW]`): (1) CNPJ/CPF de dígitos iguais recebiam "dígito verificador não confere" → "com todos os dígitos iguais não é válido"; (2) cancelar
  em P com cadastro alfanumérico = 500 → 422 antes da reserva (acima); (3) o `emitterCnpj` tolerante (D-CJ16) aceitava `00000000000000` como
  pasta → veto dos 14 iguais; (4)+(5) a cerca TS gêmea (idêntica nos 3 repositórios) — taint POR ESCOPO de função a partir de nomes/campos de
  inscrição (inclusive `insc`, `.doc`, `.ni`, desestruturação, alias, `.call/.apply`, callback de iterador), helper de dígitos por apelido,
  conversão numérica (`Number`/`parseInt`/`parseFloat`/`isNaN`), padrão em constante, `\p{…}`/hex/`\P{N}`, `/\d/` sem flag, `includes`
  — as formas que escapavam são SONDAS permanentes (`FENCE_PROBES_CAUGHT/CLEAN`); (6) a cerca Dart ganhou o padrão em variável RESOLVIDO pela
  atribuição literal, a faixa de código (`c >= 48 && c <= 57`, decimal/hex, nos dois sentidos), `\p{L}`/`\P{N}`/hex e `int|num|double.parse`/
  helper "digits" num comando que fala de inscrição — as três faixas do `CnpjInputFormatter` (classificação, não filtro) na lista branca com
  o motivo; achado de passagem: o `_uncomment` da cerca Dart nunca tirava comentário de arquivo CRLF (o `.` do Dart não casa `\r`); (7) NEL
  nas pontas: o app julga e envia pelo `FederalIdRules.trimLikeJs` (o `trim()` do JS) — mesma decisão da API; (8)+(9) formatter (acima).
- **Testes (worktrees, depois dos gates)**: núcleo 634 (+1 skip) · nfse-api 983 (+185 skip — ao vivo) · setes-api 2045 (129 suítes, +31 skip) ·
  setes_validators 104 · core 84 · app web 642 (+28 skip) · `tsc --noEmit` nos 3 TS e `flutter analyze` limpos. Commits LOCAIS do retrabalho no
  branch `cnpj`: núcleo c84eaf5 · nfse e3b891a · api dcf4e1e · app db92f38 (o `dist` do núcleo da worktree reconstruído).
- **Questões para a rodada 3 (recomendação entre parênteses)**:
  - **Q-CJ19 Pasta do arquivo fiscal e `CNPJAutor` de documento JÁ autorizado**: (a) tirados do emitente EMBUTIDO na chave pela peça
    `access-key` (o cadastro vale só para a emissão — supera em parte a D-CJ16: a 2ª via deixa de depender do cadastro) · (b) manter o cadastro
    canonicalizado sem DV e aceitar o limite. *(Rec.: (a).)*
  - **Q-CJ20 A porta abriu sem a sonda do Inter (desvio da D-CJ10)**: (a) aceitar o desvio — o boleto recusa CNPJ com letra até a sonda, com a
    saída dita (já feito na sessão) · (b) a janela da onda 1 espera a sonda. *(Rec.: (a).)*
  - **Q-CJ21 A janela única publica a porta antes do inventário do grupo do sync** (contra o "todo consumidor" da D-CJ8 — o indexador do sync,
    "achou pelo CPF/CNPJ → reusa o id", está fora da nossa vista): (a) publicar e aceitar o risco, com conferência só-leitura de duplicidade de
    CNPJ canonicalizado no central depois da janela · (b) a onda 0 vai na janela e a PORTA (`companyBody` aceitando letra) espera o retorno do
    sync. *(Rec.: (b) se o sync não responder antes da janela.)*
  - **Q-CJ22 Linha de P na onda 2**: (a) abrir P exige a "tentativa controlada no 1º caso real com o vai" (porta (c) da D-CJ7); a cerca de
    monotonia já entrou · (b) só pela data anunciada. *(Rec.: (a).)*

### 8.11 Rodada 3 DECIDIDA (2026-10-16, Valdo: as quatro recomendações) — D-CJ19…D-CJ22

- **D-CJ19** (= Q-CJ19 (a)): o que é de documento JÁ autorizado — a PASTA do arquivo fiscal (XML da NFS-e, do evento, 2ª via) e o `CNPJAutor`
  do pedido de evento — sai do emitente EMBUTIDO na chave pela peça `access-key`; o cadastro de hoje governa só o que vai NASCER (emissão).
  Supera em parte a D-CJ16 (a leitura tolerante do cadastro fica só onde não há chave). Executada em worktree (§8.12).
- **D-CJ20** (= Q-CJ20 (a)): aceito o desvio da D-CJ10 — o boleto recusa CNPJ com letra até a sonda do Inter, com a saída dita (feito no §8.10).
- **D-CJ21** (= Q-CJ21 (b)): a JANELA leva a onda 0; a PORTA do cadastro (aceitar CNPJ com letra no central) espera o retorno do grupo do
  sync. Como os commits da onda 1 misturam a porta com o resto, a onda 1 vai INTEIRA depois do retorno do sync (se ele responder antes da
  janela, vão juntas). Nenhuma flag: a separação é por commit.
- **D-CJ22** (= Q-CJ22 (a)): a linha de P (onda 2) abre só com uma tentativa CONTROLADA no 1º caso real, com o "vai" (porta (c) da D-CJ7); a
  cerca de monotonia já está no `cnpj-alfa-onda1.test.ts`.

### 8.12 D-CJ19 EXECUTADA em worktree (2026-10-16) — nfse-api c67bcc4

- Peça `access-key.cnpjOfAccessKey(chave)`: o CNPJ do emitente EMBUTIDO (tpInsc 2 + forma canônica `[0-9A-Z]{12}[0-9]{2}`, como veio, sem DV
  conferido — a inscrição é voz do fisco que autorizou); null quando a chave não traz CNPJ na forma.
- `transmission.ts`: `documentCnpj(chave)` = a chave, com o cadastro (`emitterCnpj`, leitura tolerante da D-CJ16) só como RECURSO — gravar e
  procurar o XML da NFS-e (autorização, consulta, 2ª via, tela "No fisco", IBS/CBS) e do evento (cancelamento, arquivamento tardio,
  substituta) pelo MESMO lugar; o `CNPJAutor` do pedido de cancelamento e a conferência do leiaute do EVENTO (422 antes do K) pelo emitente da
  NOTA. Documento arquivado antes da mudança foi gravado pela pasta do CADASTRO — é a mesma enquanto o cadastro for o emitente da chave (o
  caso de hoje: a Setes nunca trocou de CNPJ); nada a migrar agora.
- Limite conhecido (não decidido aqui): o cancelamento ainda passa pelo `buildEmitter` (endereço/IBGE do cadastro, para o prazo do PAM) —
  cadastro incompleto hoje recusa o preparo (N, 422) mesmo com a nota autorizada.
- Testes: `transmission.test.ts` ("D-CJ19 — documento JÁ autorizado pela chave dele…": cadastro trocado para OUTRO CNPJ → autor e pasta seguem
  a nota e a 2ª via é achada; P com cadastro hoje alfanumérico e nota numérica cancela; nota com letra em P recusa antes do K; chave sem CNPJ
  → recurso) + `cnpj-alfa-onda1.test.ts` (a peça). nfse-api 989 (+185 skip).
- **Gates do delta D-CJ19 (2026-10-16) — PASSARAM**: socrático **0,75** · adversarial **0,72** (sem HIGH; 22 ataques no arquivo PERMANENTE
  `adversarial-cnpj-dcj19-gate.test.ts` — resistiram chaves forjadas/Unicode/traversal em fuzz de 30 mil, gravação × busca na MESMA pasta,
  leiaute do evento, substituta, documentos antigos com o cadastro nunca trocado). **Corrigido na sessão — 2 MEDIUM, mesma causa (nfse
  2d49f43)**: a chave decide a pasta (raiz ÚNICA para todos os clientes) e o autor, mas o emitente embutido nela não era conferido contra o
  DPS — chave de OUTRO emitente gravada numa tentativa servia a 2ª via/DANFSe/substituta de OUTRO cliente, gravava na pasta dele e saía no
  `CNPJAutor` do cancelamento. Agora: o `POST /nfse` confere (a mesma regra do `GET /dps`); a transmissão repete como cinto (a reserva fica
  em voo, nada gravado); `documentIssuerCnpj` só usa a chave quando ela é do emitente do DPS da tentativa — senão 502 ambígua
  `nfse-chave-divergente` (no cancelamento, ANTES do K). Fixtures de chave MALFORMADA (sem o tpInsc — ~15 suítes antigas, a que mantinha o
  "recurso" vivo nos testes) corrigidas; a cerca D-F98 conhece o produtor novo. nfse-api **1011** (+185 skip — ao vivo NÃO rodados: gravam
  em cópias do dev). Limite registrado: o `checkXmls` do `migrate:setes` procura pela pasta do CNPJ do A1 (3ª fonte) — script da re-sincronia,
  morto depois da virada de 14–15/10.
- **Questões para a rodada 4 (recomendação entre parênteses)**:
  - **Q-CJ23 Recurso ao cadastro quando a chave não traz CNPJ**: com a conferência chave × DPS ele só é alcançado em tentativa SEM Id do DPS
    gravado. (a) tirar o recurso: chave sem CNPJ = erro legível "emitente fora do suporte" + conferência só-leitura no `fiscal_api` de que
    nenhuma chave gravada tem tpInsc ≠ 2 ou emitente ≠ DPS (`SUBSTRING(access_key,10,14) <> SUBSTRING(dps_id,12,14)`) · (b) manter o recurso
    numa peça só · (c) como está. *(Rec.: (a).)*
  - **Q-CJ24 Autor da chave × A1 de hoje** (Anexo II: E0812 confere só a RAIZ do CNPJ do certificado; E0813 exige autor = emitente): (a)
    conferir a raiz localmente ANTES do K · (b) deixar o fisco decidir e traduzir o E0812 numa mensagem com a SAÍDA (carregar o A1 do emitente
    da nota ou cancelar no Emissor Nacional) · (c) nada. *(Rec.: (b) agora; (a) junto da D-CJ6.)*
  - **Q-CJ25 Levar a D-CJ19 até o fim**: (a) o cancelamento tira da NOTA o que precisa (cMun da chave para o prazo do PAM, CNPJ para o autor) e
    deixa de chamar o `buildEmitter` estrito; o "Município gerador" do DANFSe vem do documento · (b) manter: cadastro incompleto bloqueia o
    cancelamento com 422 legível e o DANFSe mostra o município de hoje. *(Rec.: (a).)*
  - **Q-CJ26 (assunção EXECUTADA na sessão — confirmar)**: chave × DPS incoerentes = ambígua 502 `nfse-chave-divergente` no adaptador, na
    transmissão, nos leitores e no autor (falha fechada; o "Fisco ambíguo persistente" alarma) · (b) só no adaptador (linhas já gravadas —
    inclusive as do `migrate:setes` — seguiriam decidindo pela chave). *(Rec.: (a) — manter.)*
  - **Q-CJ27 Documento cancelado arquivado pela versão anterior na pasta de um cadastro JÁ trocado** (LOW do adversarial — teste `it.failing`):
    (a) a busca procura também na pasta do cadastro quando a da chave não tem · (b) a consulta da C regrava o XML da NFS-e que já recebe do
    fisco (como a consulta da A já faz) · (c) limite conhecido. *(Rec.: (b) — torna verdadeira a mensagem "consulte a nota para regravar" sem
    reabrir o cadastro como fonte.)*

## 9. ⏯ PROMPT DE RETOMADA (colar numa sessão nova)

```
Retome a frente de PRODUTO "CNPJ alfanumérico" (Gestão 2027): D:\Gestao2027\Infra-IA\prompts\prompt_frente_cnpj_alfanumerico.md
(TRANSVERSAL — cadastros, NFS-e, boleto, certificado; a nfe-api não tem emissão ainda e volta DEPOIS desta frente, na NE-1b).
Rodadas 1–3 DECIDIDAS (D-CJ1…D-CJ22, §6.1/§8.8/§8.11); ONDAS 0 e 1 + D-CJ19 EXECUTADAS em worktrees D:\Gestao2027\cnpj\{fiscal-api,
nfse-api,setes-api,setes-app}, branch `cnpj`, commits LOCAIS (sem push/merge), gates 0,76/0,82 (onda 0), 0,74/0,80 (onda 1) e 0,75/0,72
(delta D-CJ19) com retrabalho — §8.7/§8.10/§8.12.
1) Apresente a rodada 4 (Q-CJ23…Q-CJ27 do §8.12) com as recomendações; decidida, registre D-CJ23… e execute o que couber em worktree
(gates do delta). 2) A JANELA (§8.5) SÓ com o meu "vai" (núcleo build + prova da peça a partir do setes-api → nfse-api → setes-api → app);
pela D-CJ21 ela leva só a onda 0 (por commit) enquanto o grupo do sync não responder. 3) O CHECK de forma (rascunho provado) só depois do
acordo com o grupo do sync. NÃO ler setes-sync nem sincronizador (tarefa separada). Atualize a cadeia (INDICE_CENTRAL, CLAUDE.md da raiz, memória).
```
