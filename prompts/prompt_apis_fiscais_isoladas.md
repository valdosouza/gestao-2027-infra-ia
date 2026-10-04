# APIs Fiscais Isoladas — `nfse-api` (NFS-e/ADN) e `nfe-api` (NF-e/NFC-e/SEFAZ)

**Status**: Rodada 1 — PARCIALMENTE DECIDIDA (2026-10-03, 2ª mensagem do Valdo): **D-F1…D-F3** registradas (§7), escopo AMPLIADO (§1.5: qualquer cliente, múltiplos apps, 1000 clientes), parecer do guardião integrado (§3); aguardam o Valdo Q-F2…Q-F5, Q-F7…Q-F16, Q-F18…Q-F28 (§8). Estrutura do projeto criada: `D:\Gestao2027\fiscal-api\` (CLAUDE.md + README, sem código) e espelho `Infra-IA/fiscal-api/INDEX.md`. **3ª mensagem (2026-10-03): "setes-api NÃO vira cliente; o setes-app vira cliente da fiscal-api como qualquer front-end" — ANÁLISE em §11, decisão pendente (Q-F27/Q-F28); a parte "setes-api é um dos apps" da D-F2 está em revisão.**
**Origem**: pedido do Valdo em 2026-10-03, ao fechar a fase de emissão de NFS-e: *"isolar as APIs do sistema porque o consumo pode ser feito por outras aplicações e eu posso dar escala para elas"*
**Referências**: `prompt_onda3_nfse_adn.md` (NFS-e — ENTREGUE, produção desde 2026-09-29) · `prompt_onda_nfe_sefaz.md` (NF-e — Rodadas 0/1 decididas, nada executado além das peças comuns do §10) · `prompt_primeiro_cliente_setes.md` (Onda 4 — produção na SaveInCloud, ainda INEXISTENTE) · `skills-genericas/guardiao-conceitual.md` · `setes-sync/prompt_revisao_sincronizador_setes_sync.md` D12 (API key por institution — precedente de API consumida por terceiro) · método: `skills-genericas/refinar-prompt-arquitetura.md`
**Escopo**: misto (o conceito "serviço de documento fiscal que não conhece o ERP" é método portável; tabelas, ADN, SEFAZ e dados da Setes são conteúdo do caso zero)

> Este documento NÃO decide. Organiza o que existe, mede o esforço e transforma cada escolha arquitetural em questão numerada (§8) com recomendação. Decisões do Valdo entram na §7 com numeração permanente (D-F1…).

> **⏯ RETOMAR POR AQUI (sessão fechada em 2026-10-03)**: (1) decidir **Q-F27/Q-F28** primeiro — mudam a D-F2 e a forma da F2 (§11); (2) depois **Q-F21** (onde vive o pedido dos apps de venda); (3) então as demais Q-F2…Q-F26 em bloco ("siga as recomendações" vale, como nas outras fases). Só depois de a §8 zerar: F0 (OpenAPI design-first + DDL com `revisar-ddl`) e F1. Estrutura já existe: `D:\Gestao2027\fiscal-api\` (sem código) e `Infra-IA/fiscal-api/INDEX.md`. Nada commitado além do próprio prompt/índice; repo GitHub da fiscal-api ainda não existe.

---

## 1. Contexto — fatos verificados no disco (2026-10-03)

### 1.1 O que a NFS-e já é hoje (dentro do setes-api)

A Onda 3 entregou a emissão de NFS-e pelo ADN nacional como peças `@shared/*` do **setes-api**, consumidas pelo módulo `billing` (rotas `/api/billing/fiscal*`) e pelo módulo `establishment` (habilitação do emissor). Está em **produção real**: NFS-e nº 704 autorizada em 2026-09-29, DANFSe e cancelamento provados no mesmo dia.

| Peça | Arquivos | Linhas | Lê tabela do ERP? | Natureza |
|---|---|---|---|---|
| `shared/tax-authority` | types · adapters/adn · dps-builder · https-json · xmldsig | 1.054 | **não** | transporte puro: assina XML, fala mTLS com o fisco, devolve fatos crus |
| `shared/invoice-transmission` | invoice-transmission (840) · branches/service (599) · transmission.repository (532) · kinds | 1.992 | **sim** — `tb_invoice`, `tb_invoice_service`, `tb_invoice_event`, `tb_entity_tax`, `tb_city`, cadeia da entity | composição: reserva de tentativa → fisco fora da transação → voz → efeito; estratégia por ramo |
| `shared/fiscal-issuer` | fiscal-issuer · repository | 416 | só `tb_establishment_issuer` + transmissões | habilitação do emissor: PKCS#12 → par PEM no cofre, abre o par, valida validade/CN |
| `shared/danfse` | danfse | 168 | não | render do PDF a partir do XML autorizado (pdfkit) |
| `shared/secret-store` | secret-store | 149 | não | cofre em arquivos `SECRETS_PATH/<schema>/<owner>/<id>/<S|P>/<name>` — **compartilhado com o canal do banco** (owner `bank-account`) |
| `modules/billing` (parte fiscal) | billing.fiscal.controller (113) · billing.fiscal.service (144) · 9 rotas em billing.routes | ~300 | sim (privilégio por ramo, autoria JWT) | fronteira HTTP ↔ composição; lote com orçamento de 60 s e trava `runningBatch` |
| `modules/establishment` (parte issuer) | issuer.controller (61) · dto (35) · service (169) · 5 rotas | ~265 | sim | upload do A1, linha por modelo |
| Testes | 7 arquivos (`tax-authority` 372 · `invoice-transmission` 502 · `fiscal-issuer` 317 · `secret-store` 75 · `danfse` 71 · adversarial 83 · fiscal-folder-zone 40) | 1.460 | mocks na fronteira (`pool`, repository, adapter) | portáveis — mockam o que a peça importa, não o banco |
| Migrations | 058 (ramo + emissor + transmissão + voz) · 059 (chave do DPS) · 060 (contador + kind N) · 061 (`invoice_event` = vida da nota) · 062/063 (`tb_entity_tax` Simples) | — | 062/063 são fatos do EMITENTE no ERP (ficam) | 058–061 criam as tabelas candidatas a migrar |
| Códigos de erro | 23 `FISCAL_*` / `INVOICE_SERVICE_*` (de 296 no catálogo) | — | — | contrato de erro já estável |
| Dependências npm | `node-forge` (PKCS#12) · `xml-crypto` (XMLDSig) · `pdfkit` (DANFSe) | — | — | migram junto |
| Arquivos em disco | `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mes>/` (`*-dps.xml`, `*-nfse.xml`, `*-evt101101.xml`) · `SECRETS_PATH/<schema>/establishment/<inst>/P/certificate.pem + private.key` | — | — | o A1 real da Setes já está no cofre do dev (vence 08/10/2026) |

**Consumidores no app** (setes-app): 17 arquivos Dart (2 do emissor em `establishment`, 15 do fiscal em `service_orders`) + 4 testes — todos falam SÓ com `/api/billing/fiscal*` e `/api/establishment/issuer*` do setes-api (regra "módulo do app fala só com o seu `/api/<m>`"). **Se o setes-api continuar sendo a porta do app, o app não muda.**

**O que a transmissão lê do ERP e o que é só do fisco** (fato que define a fronteira — §4):
- *Do ERP, no momento da transmissão*: a nota viva emitida pela institution (`readServiceInvoice` — `tb_invoice` + ramo `tb_invoice_service` congelado no faturamento), o emitente (cadeia + `tb_entity_tax`: CNPJ, IM, cMun IBGE, opSimpNac/regApTribSN/regEspTrib, pTotTribSN — `buildEmitter`), o tomador (cadeia — `buildRecipient`), a cidade de incidência (IBGE), o fuso do estabelecimento (`institutionZoneFor`), o último evento da nota (MEDIUM-3: "a nota mudou no intervalo?"), o lock da nota e o lock de contadores da institution.
- *Só do fisco*: habilitação (ambiente, série, contador nDPS), par PEM, tentativa (`attempt`, ambiente congelado, `dps_id`, chave 50, número, `dh_proc`, `last_queried_at`), voz (S/A/R/C/K/F/N com código cru, fonte P/Q), XML em disco, DANFSe, prazo do PAM (cache).
- *O efeito*: a voz C do fisco produz `cancelInvoice` local em SAVEPOINT (porta única `applyCancelEffect`); recusa local = fato gravado + pendência (`FISCAL_EFFECT_PENDING`, `countPendingEffects`) — **o padrão "voz do terceiro × efeito nosso" já existe e já tolera separação no tempo** (D-I10/D-I25/D-I28 da Onda 2).

### 1.2 Estado de produção e escala — fatos

- **Onda 4 (deploy) não existe**: o setes-api não tem Dockerfile, `ecosystem.config` nem script de deploy; só `.env` de dev. A "produção" fiscal de 2026-09-29 foi o ambiente P do FISCO (tpAmb 1) acionado do dev. Decisão D3 da fase Primeiro Cliente: SaveInCloud, `api-erp.setesgestao.com.br`.
- **Estado em memória que NÃO sobrevive a 2+ instâncias** (achado desta leitura): `runningRefresh` (`invoice-transmission.ts:708`, 1 rodízio por institution), `runningBatch` (`billing.fiscal.service.ts:58`, 1 lote por institution), `termsCache` (`branches/service.ts:498`, só cache — inofensivo). Quem escala horizontalmente precisa trocar os dois primeiros por trava no banco ou aceitar "1 por instância".
- **Cofre e XML em filesystem local** (`SECRETS_PATH`, `STORAGE_PATH`): 2+ instâncias exigem volume compartilhado ou backend de objeto/KMS — a peça já diz "cofre/KMS entra ATRÁS desta interface quando a produção pedir".
- **Volume da Setes**: cobrança mensal em lote (teto 50 ordens/requisição — D27), centenas de NFS-e/mês. A escala que justifica serviço próprio é a da **NFC-e (modelo 65, PDV)** — milhares/dia por cliente — e a de **outros consumidores**.
- **Precedente de API consumida por terceiro**: setes-sync autentica por `X-Api-Key` resolvida em `setes_central.tb_sync_api_key` (institution + schema por JOIN, cache 5 min) — D12 da revisão do sync.

### 1.3 Estado da NF-e — fatos

- Rodadas 0 e 1 DECIDIDAS (D-E1…D-E25, "siga as recomendações", 2026-09-21). **D-E20 (a)**: as peças comuns nasceram com a Onda 3 (feito — `tb_establishment_issuer` com PK por MODELO, `xmldsig` paramétrico `sha1|sha256`, UMA composição `@shared/invoice-transmission` com `branches/`, motor de PDF único); **a NF-e em si espera o 1º cliente de mercadoria**. Nada de `adapters/sefaz.ts`, `branches/merchandise.ts`, `tb_invoice_merchandise_transmission`, `tb_invoice_number_void`, DANFE.
- O ERP já congela no faturamento os fatos do ramo de mercadoria (6 snapshots por item: `tb_order_item_icms/_fcp/_ipi/_pis/_cofins/_issqn`; `tb_invoice_merchandise`) — o builder do XML consome RESULTADO da tributação, nunca recalcula (§3.11 da NF-e; §4.3 do diagnóstico do legado).
- **IBS/CBS (NT 2025.002)**: obrigatório na NF-e/NFC-e do regime regular desde **03/08/2026**; Simples Nacional em **01/01/2027** (Ato Conjunto RFB/CGIBS nº 4/2026 — premissa corrigida em 2026-09-30). O motor `@shared/tax-rule` (1.099 linhas) **não calcula IBS/CBS** — pré-requisito de qualquer NF-e real (Q-E17), que vive no ERP, não na API fiscal.
- Contrato oficial da SEFAZ (MOC 7.0, NTs, schemas PL, autorizadores por UF, cStat) **ainda não levantado** (`integracoes/nfe-sefaz/` não existe). O da NFS-e existe em `setes-api/integracoes/nfse-adn/`.

### 1.4 Calibração de esforço (ondas reais desta mesma stack)

| Onda | Calendário | Tamanho | Observação |
|---|---|---|---|
| Onda 2 — Banco Inter (conector REST + mTLS + webhook, 3 peças, migration 055/056/057, app) | 2026-09-19 → 21 (3 dias) + gates/smoke até 21 | 948 → 1.056 testes | fisco/banco com contrato JSON documentado |
| Onda 3 — NFS-e ADN (DDL + emissor + transporte + composição + DANFSe + app + 3 rodadas de gates + 1ª produção) | 2026-09-20 → 30 (10 dias) | ~6,5 k linhas (código + testes), 7 migrations, 23 códigos de erro, 9 rotas | fisco DESCONHECIDO: a 1ª sessão real cravou contrato, assinatura e 4 códigos E0xxx |
| Cancelamento autorizado D3/D4 + rodadas Q-CA/Q-ADV | 2026-09-29 → 30 (2 dias) | 1.387 → 1.429 testes | delta sobre peça existente |

Unidade usada abaixo: **sessão** = bloco de ~4 h de trabalho Valdo + agente, com testes verdes ao fim. Faixa com ±40 % — o que encurta é código já provado sendo MOVIDO; o que alonga é fisco novo (SEFAZ) e dependência externa (DNS, SaveInCloud, homologação).

### 1.5 Rodada 1 — o que o Valdo trouxe (2026-10-03, 2ª mensagem; texto fiel)

> "quero tratar fiscal-api como novo projeto seguindo as estruturas do setes-app incluindo a documentação de Gestao2027\Infra-IA... mas cada cliente incluindo a setes poderá fazer o uso da api, incluindo aplicativos de vendas que poderá criar orders e enviar para autorização, múltiplos apps, acessando o próprio ambiente do cliente através da web ou app android/iOS consumindo apis que devem ser publicadas de maneira que a escala de uso aguente o consumo de 1000 clientes emitindo e autorizando notas"

O que isso muda no desenho:

| Antes (Rodada 0) | Agora (Rodada 1) | Efeito |
|---|---|---|
| Consumidor principal = setes-api; terceiros "um dia" | **Todo cliente** (inclusive a Setes) consome a API diretamente, com **múltiplos aplicativos** (web, Android, iOS, apps de venda de terceiros) | licenciado = o CLIENTE (D-F2, fecha Q-F17); nasce a credencial POR APLICATIVO (§5.8); contrato, CORS, documentação e limites de nível público desde a F1 |
| Escala "nascer escalável" sem número | **1000 clientes emitindo e autorizando** | requisito não-funcional com número (D-F3): dimensionamento §5.9; F3 vira "produção escalável" (2+ instâncias, storage de objeto, cofre criptografado, worker, teste de carga) |
| `fiscal-api` como nome recomendado pelo guardião | **`fiscal-api` é novo PROJETO de 1º nível** com espelho `Infra-IA/fiscal-api/` | D-F1 fecha Q-F1 e Q-F6; estrutura §5.10 criada nesta sessão (sem código) |
| Pedido/nota só no ERP | "aplicativos de vendas que poderá criar orders e enviar para autorização" | ⚠️ **Q-F21**: onde vive o PEDIDO desses apps — no ambiente do cliente (setes-api, que então orquestra faturar + autorizar) ou a `fiscal-api` passa a aceitar pedidos? A leitura fiel ao parecer §3 é a primeira; a segunda recria o ERP dentro da API fiscal |

Leitura adotada para "seguindo as estruturas do setes-app": o mesmo TRATAMENTO que os projetos existentes têm — pasta própria na raiz, repositório git próprio, `CLAUDE.md` do repo, espelho `Infra-IA/<projeto>/` com `INDEX.md` + prompts fechados + skills, linha nas tabelas fixas (CLAUDE.md da raiz, `ORGANIZACAO_PASTAS.md`, `INDICE_CENTRAL.md`). O CÓDIGO segue o molde do setes-api (Node/TS: `gateway/ · modules/ · shared/ · migrations/`, módulo em 6 arquivos — `ARQUITETURA_MODULOS_API.md`), porque a fiscal-api é uma API, não um app Flutter. Se o Valdo quis algo diferente com "setes-app", é a Q-F26.

---

## 2. Objetivos (numerados)

1. **Isolar a emissão de NFS-e** num serviço próprio (pedido: `nfse-api`; parecer §3.E: `fiscal-api`, família `/nfse` — Q-F1) consumível por qualquer aplicação autenticada — sem conhecer pedido, nota ou cadeia do ERP.
2. **Transformar o setes-api em CONSUMIDOR** desse serviço, sem mudar o setes-app (a porta do app continua `/api/billing/fiscal*` e `/api/establishment/issuer*`).
3. **Nascer escalável**: instâncias sem estado em memória que precise ser único; travas no banco; cofre e XML em backend compartilhável; contrato versionado (`/v1`).
4. **Preparar a família NF-e** (pedido: `nfe-api`; parecer: família `/nfe` do mesmo serviço — NF-e 55, NFC-e 65 apontada) sobre o MESMO núcleo (emissor, cofre, transmissão/voz, assinatura, transporte, PDF) — a NF-e **nasce na API, nunca no ERP** (parecer §3.I-6), respeitando a D-E20 (execução com o 1º cliente de mercadoria) salvo decisão nova.
5. **Zero regressão** na Setes: as 704+ NFS-e já emitidas, o A1 no cofre, XMLs em disco e a trilha `trilha-primeiro-cliente.ts` (P8a/P8b) continuam OK após o corte.
6. Gates do método (socrático ≥ 0,70 · adversarial sem HIGH) em cada onda; a API fiscal entra em produção **antes** do ERP como piloto da Onda 4 — ou junto, conforme Q-F10.

---

## 3. Parecer do guardião conceitual (Rodada 0)

> Parecer do agente `setes-conceito` (2026-10-03), colado como veio. **Diverge do rascunho inicial (§4–§5) em quatro pontos, já refletidos abaixo e nas questões §8**: (1) o conceito é UMA API (`fiscal-api`), duas só como topologia; (2) o ERP não guarda ESTADO fiscal — só o VÍNCULO nota × documento; (3) a série do 55 é de quem NUMERA (ERP), a do DPS é de quem DECLARA (API) — D-E2 diverge; (4) o banco da API não pode casar com o prefixo `setes_<cliente>`.

Fatos conferidos no disco: `shared/tax-authority/*`, `shared/invoice-transmission/*` (composição + `branches/service.ts` + repositório), `fiscal-issuer`, `secret-store`, `danfse`, `billing.fiscal.service.ts`, `establishment.issuer.service.ts`, bloco `fiscal` de `invoice-cancel.ts`, DDL de `tb_establishment_issuer`/`tb_invoice_service_transmission(_event)`, `tb_sync_api_key` + `sync.auth.middleware.ts`. Nenhuma decisão do INDICE_CENTRAL trata de isolamento; as que o parecer TOCA (D-E2, D-N7) estão devolvidas nos pontos 2 e 3.

### 3.A Conceito

**Conceito único**: *um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele.* A hipótese do rascunho acerta no que NEGA (não calcula imposto; não conhece pedido/nota) e esconde um "e" no que afirma: "assina, fala, guarda voz e XML" é UM processo (a declaração), mas "recebe fatos do emitente" junta fatos geradores distintos:

| # | Conceito (uma frase) | Fato gerador | Hoje | Natureza |
|---|---|---|---|---|
| 1 | Este CNPJ fala com o fisco com o SEU A1, por modelo/ambiente | upload do A1 + linha por modelo | `tb_establishment_issuer` + cofre | peça (habilitação) |
| 2 | Este documento foi declarado ao fisco: N tentativas × voz × XML | o pedido de transmissão | `_transmission` + `_event` + disco | peça (apresentação × voz — a mesma peça de método do boleto) |
| 3 | Quem pode PEDIR ao serviço, por quais emitentes | licenciamento do consumidor | não existe (`tb_sync_api_key` é outro fato) | peça de fronteira — não é fiscal |

A API é a **composição** das três: a política "como tratamos a voz de um fisco" é o `invoice-transmission.ts` de hoje SEM o efeito local. O arquivo se parte em dois: política da voz (API) × montador do pedido + efeito (ERP). **Teste do terceiro cego**: o Gestao2016 não tem `tb_entity` — tudo que o contrato exigir e ele não puder MANDAR está do lado errado da cerca.

### 3.B Fronteira

Regra de corte: **o ERP responde pelo CONTEÚDO (o que foi vendido/prestado, por quem, a quem); a API, pelo FORMATO e pela CONVERSA (leiaute/Anexo I, assinatura, transporte, voz, arquivo).**

| MIGRA para a API | FICA no ERP | VIAJA no contrato |
|---|---|---|
| `tax-authority` inteira (adn, https-json mTLS, xmldsig paramétrico, dps-builder = forma do leiaute) | ramo `tb_invoice_service` congelado no faturamento (`dps_number` aposentado — é identidade do documento na API); `tb_invoice_event` E/C; `cancelInvoice`; `buildCancelPlan` (bloco `fiscal` lê o VÍNCULO local + a API) | fatos do emitente: CNPJ, IM, cMun IBGE, opSimpNac/regApTribSN/regEspTrib, pTotTribSN — lidos de `tb_entity*`/`tb_entity_tax` pelo ERP |
| `fiscal-issuer` (habilitação por modelo, PKCS#12→PEM, `openIssuer`, guardas de transmissão viva ao mudar ambiente) re-chaveada pelo emitente | `buildEmitter`/`buildRecipient`/`buildDpsBase` viram o MONTADOR do pedido (os 422 de cadastro incompleto são do ERP); L8 (base ISS ≠ valor); `assertTransmittable`; vida da nota (D-N27) | fatos do tomador (documento, nome, endereço) |
| `secret-store` owner do A1 (a peça é UMA; o owner `bank-account` fica no ERP — D-I1 preservada) | privilégios TRANSMITIR/CANCELAR por ramo e resolver de interface; telas "No fisco"/"Emissor fiscal" viram CLIENTES da API | fatos do serviço/itens congelados (cTribNac, cTribMun, vServ, retenção, exigibilidade, descrição, dCompet) |
| transmissão (attempt, ambiente congelado, write-once, `last_queried_at`, reconciliação por dps_id/chave, K→N, rodízio, órfã) + voz append-only | `tb_entity_tax` (o regime também alimenta a regra de ISS) | `dhEmi`/`dhEvento` com offset da zona (Q-TZ2); motivo do cancelamento; autoria opaca (`external_user`) |
| arquivo `STORAGE_PATH/<cnpj>/<ano>/<mes>` (já é por CNPJ), DANFSe/DANFE (função pura do XML), PAM, matriz do Anexo I (`emitterDpsFacts`: E0166/E0712 são conhecimento do fisco) | — | — |

Transmissão e voz são **da API**. O ERP guarda **(1) o vínculo** nota × documento, por VIDA e por MODELO (conjugada = 2 documentos) — fato do ERP ("entreguei esta vida à API como documento X", ato de quem tem TRANSMITIR) e âncora do plano de cancelamento com a API fora (sem vínculo = nunca declarada = cancela local sem perguntar a ninguém; com vínculo = pergunta à API antes, como a Q-ADV1b já faz) — e **(2) o efeito** (`tb_invoice_event` C). Nenhuma coluna de estado fiscal no ERP: estado é DERIVADO na API; lista e detalhe leem por lote de referências (ponto 4).

### 3.C Identidade

Três papéis, três peças: **licenciado** (quem chama, chave) → **emitente** (CNPJ em cujo nome falamos, dono do A1 — pela D-N29 o A1 É do CNPJ, logo o emitente pode NASCER do upload) → **habilitação** (emitente × modelo: ambiente, série/contador do SE). `tb_sync_api_key` NÃO serve: seu conceito é "esta instalação do legado escreve no schema desta institution" — amarra a `tb_institution`, o acoplamento que a isolação quer cortar. Peça nova, no banco próprio da API. UNIQUE `(licenciado, emitente, external_code)` dá POR CONSTRUÇÃO a idempotência que o Inter não dava (Q11: seuNumero não era único) — retry pós-timeout acha o documento em vez de criar o segundo.

### 3.D O efeito atravessa a fronteira

É **fiel** — é a forma pura do modelo. O SAVEPOINT era conveniência de banco compartilhado; o invariante sempre foi "só a voz muda estado; o efeito é aplicado pela composição; recusa = fato + pendência" (D-I10). Com dois serviços, TODA aplicação de efeito vira o que o webhook do Inter já é: voz chega (notificação ou consulta) → efeito na transação do ERP → ack à API com a referência do efeito; sem ack = pendente (espelho exato de `PENDING_EFFECT_WHERE` e da reaplicação D-I25). Guardas: at-least-once exige efeito idempotente (`recordCancelVoice` já é por KIND; `applyCancelEffect` já devolve o C existente); a API registra que o licenciado ACUSOU (`licensee_effect` no lugar de `invoice_event` na voz) sem saber o que o efeito é. Vira maquete se o ERP decidir por estado em cache em vez da voz, se a API conhecer `tb_invoice_event`, ou se um C local nascer sem voz.

### 3.E Uma API ou duas

Conceitualmente **UMA**: um emitente, um A1 (D-N31), uma habilitação por modelo (D-E1), uma política (D-E6 — "o legado errou nos gêmeos 55×65"), estratégia por documento. **(iii)** duas APIs com cofre próprio = o emitente sobe o MESMO A1 em dois cofres e tem duas habilitações para um CNPJ — "mesmo fato em dois lugares" + "composição gêmea por modelo", que o §3.11 da NF-e já lista como maquete. **(ii)** só é legítima como TOPOLOGIA de (i): um repo, um banco, um cofre, dois processos (`--family nfse|nfe`). **(i) Recomendado.** Nomear o serviço pelo DOCUMENTO (`nfse-api`/`nfe-api`) repete o erro de `tb_nfse` paralela: o nome é o conceito (emissão fiscal), o documento é o ramo.

### 3.F Nomes

| Objeto | Nome | Por quê / colisões evitadas |
|---|---|---|
| Serviço | `fiscal-api` (famílias `/nfse`, `/nfe`) | conceito, não documento |
| Quem chama | `tb_licensee` (Recomendado) · alt. `tb_client` | "licença" já é o sentido de `tb_institution.active` (PADROES §6); livre no acervo. `client` colide com "cliente" = tenant e com customer; `consumer` com consumidor final (indFinal); `credential` é como os comentários chamam o A1 |
| Emitente | `tb_emitter` (cnpj, `time_zone` — pasta do mês Q-TZ7; cofre `emitter/<id>/P/`) | "emitente" já é a palavra do `prest` do DPS |
| Habilitação | `tb_issuer` (PK `tb_emitter_id, model`) — sucessora de `tb_establishment_issuer` | "emissor" continua = habilitação |
| Documento no serviço | `tb_fiscal_document` (raiz: emitente, modelo, `external_code`, número) + transmissão/voz por FAMÍLIA de autoridade (ADN × SEFAZ — fatos diferem, D-E6) | "documento" sozinho = CPF/CNPJ no ERP (`by-document`); DF-e é o termo oficial |
| Referência do consumidor | `external_code` | palavra da casa para "id no outro sistema" (sync) |
| Vínculo no ERP | `tb_invoice_fiscal_document` (nota, vida, modelo, id na API) — sem FK, molde `tb_bank_slip_title` | vínculo ≠ estado |
| Notificação | colunas `notified_at` + `licensee_effect` na voz; URL do licenciado + `inbound_token` (molde do canal); receptor no ERP `/hooks/fiscal-document/:inst/:token` (molde `/hooks/bank-channel`) | sem `tb_notification`: "avisamos" é fato da voz, como `last_queried_at` é "olhamos" |

### 3.G O que NÃO entra (e por quê)
Reuso de `tb_sync_api_key` (fato gerador ≠) · estado fiscal em coluna do ERP (decidido fora = status) · schema-por-cliente dentro da API (um banco, escopo por linha `tb_licensee_id`) · cópia da cadeia de entidade na API (teste do terceiro cego) · cálculo de imposto na API · `tb_integration*`/`tb_nfe*`/`tb_nfse*` · usuário do ERP como FK na API (autoria é texto opaco) · segunda tabela de voz no ERP (duas verdades).

### 3.H Onde vira maquete
Cofre/emissor duplicado por API · API que conhece `tb_invoice`/`tb_order` · ERP que cancela local sem perguntar à API quando HÁ vínculo · "status" sincronizado por cron · série do 55 na API (quem numera é o ERP — ponto 2) · `external_code` sem UNIQUE · callback sem consulta (D33: polling faz a ponte; os dois convivem, uma porta de efeito só).

### 3.I Pontos que exigem decisão do Valdo (levados à §8 como Q-F16…Q-F20 e revisões de Q-F1/Q-F5/Q-F6/Q-F8)

1. **Granularidade do licenciado para o próprio ERP**: (a) um por institution — espelho da D12, cerca do emitente feita pela API, chave no cofre `establishment/<inst>` (Recomendado; custo: provisionamento no POST de institutions com uma credencial de serviço) · (b) um para o setes-api inteiro com N emitentes (mais simples; a cerca por CNPJ fica só no ERP).
2. **D-E2 diverge** ("série no emissor aposenta `invoice_serie`" pressupunha emissor e numeração no mesmo lugar): a série do 55 é fato de quem NUMERA (ERP); a do DPS, de quem DECLARA (API). (a) API guarda série/contador só do SE; 55/65 numeram no ERP e a série viaja no payload (Recomendado) · (b) API guarda as séries de todos e o ERP a lê antes de cunhar (ERP não numera com a API fora — maquete).
3. **D-N7 relaxa** ("voz C → C local na MESMA transação" é impossível entre serviços): confirmar o invariante como "C local SÓ da voz; efeito na transação do ERP; recusa ou falha = pendência visível e reaplicável" (Recomendado) — já é o que vale para o C vindo da consulta.
4. **Leitura de estado pelo ERP**: (a) sem espelho — lista e detalhe por lote de referências; API fora = selo "indisponível" e ações fiscais 503 (Recomendado: zero coluna de estado) · (b) espelho de exibição escrito SÓ pela notificação, nunca decisório — se a latência da lista doer.
5. **Banco da API**: nome fora do prefixo `setes_<cliente>` (`setes_fiscal` casaria com `SCHEMA_RE`) — ex.: `fiscal_api`; um banco, escopo por linha.
6. **Ordem**: (a) extrair AGORA com a NFS-e em produção como piloto, contrato já paramétrico por família — a NF-e nasce na API, nunca no ERP (Recomendado) · (b) NF-e no ERP primeiro e extrair as duas depois (paga a extração duas vezes).
7. **Palavra do licenciado**: `tb_licensee` × `tb_client` — palavra é decisão do Valdo (lição "contrato").

*Arquivos lidos pelo guardião (nenhum editado)*: guardiao-conceitual.md · PADROES_BANCO.md · INDICE_CENTRAL.md · os dois prompts fiscais (§3/§4/§8/§10) · `tax-authority/{types,xmldsig,dps-builder,https-json}.ts` + `adapters/adn.ts` · `invoice-transmission/*` · `fiscal-issuer/*` · `secret-store.ts` · `danfse.ts` · `invoice-cancel.ts` (bloco `fiscal`, 322–373) · `billing.fiscal.service.ts` · `establishment.issuer.service.ts` · `sync.auth.middleware.ts` · `sql/03_schema_cliente_ddl.sql` (479–525) · `sql/05_sync_api_key.sql`.

---

## 4. Fronteira proposta — o que migra, o que fica, o que nasce

Hipótese organizadora, **confirmada pelo parecer §3.A/§3.B com duas correções**: *um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele* — a API responde pelo FORMATO e pela CONVERSA (leiaute, assinatura, transporte, voz, arquivo); o ERP responde pelo CONTEÚDO (o que foi vendido/prestado, por quem, a quem). Não calcula imposto. Não conhece pedido, nota, cliente ou cadeia do ERP. Correções do parecer sobre o rascunho: (1) a matriz do Anexo I (`emitterDpsFacts` — E0166/E0712) é conhecimento do FISCO e migra; (2) o ERP **não guarda estado fiscal** — guarda o VÍNCULO nota × documento (Q-F16).

| Peça hoje (setes-api) | Destino | Trabalho | Linhas |
|---|---|---|---|
| `tax-authority/*` (types, adn, dps-builder, https-json, xmldsig) | **`fiscal-api`** (núcleo comum às famílias) | MOVER sem mudança de contrato; `AuthorityContext` continua recebendo o par PEM | 1.054 |
| `secret-store` | **copiar** para o núcleo (owner `emitter`); o setes-api MANTÉM a sua para o canal do banco | COPIAR + renomear owner; o caminho deixa de ter `<schema>` (identidade = emitente) | 149 |
| `fiscal-issuer` | núcleo | MOVER + reindexar: PK `(institution, model)` → `(emitente CNPJ, model)`; validação do CN × CNPJ já existe (D-N29b) | 416 |
| `transmission.repository` + máquina de estados de `invoice-transmission.ts` (reserva → fisco → voz → reconciliação K/F → refresh/rodízio) | `fiscal-api` (política da voz, por família de autoridade) | MOVER + reindexar: `(institution, invoice, terminal, attempt)` → `(documento, attempt)`; a "nota mudou?" (MEDIUM-3) fica no ERP (vida da nota no `external_code`) | ~1.400 |
| `branches/service.ts` — leitura do ERP (`readServiceInvoice`, `buildEmitter`, `buildRecipient`, `buildDpsBase`, `assertTransmittable`, L8) | **FICA no setes-api** como *montador do pedido* (`@shared/fiscal-client/nfse-facts.ts`) — os 422 de cadastro incompleto são do ERP | ADAPTAR: o resultado deixa de virar XML aqui e vira o PAYLOAD da API (`DpsInput` sem série/nDPS — já é assim: `DpsBase`); **`emitterDpsFacts` (matriz do Anexo I) MIGRA**; **`dps_number`/`lockDpsNumber` morrem no ramo** (a identidade do documento é da API — §3.B) | ~350 ficam / ~250 migram |
| `applyCancelEffect` / `reconfirmBeforeLocalCancel` / bloco `fiscal` do `buildCancelPlan` | **FICA no setes-api** | ADAPTAR: o bloco lê o VÍNCULO (FOR UPDATE) e pergunta à API ANTES da transação (a Q-ADV1b já faz isso com o fisco); sem vínculo = nunca declarada = cancela local sem perguntar; efeito idempotente + ack à API (`licensee_effect`) | ~300 |
| `danfse` | `fiscal-api` — `GET /v1/nfse/documents/{id}/danfse` | MOVER (função pura do XML); o nome/município do emitente passam a vir de `tb_emitter` (hoje vêm da cadeia) | 168 |
| `billing.fiscal.*` + 9 rotas · `establishment.issuer.*` + 5 rotas | **FICAM** como porta do app | ADAPTAR: service chama o cliente HTTP em vez da composição; privilégios TRANSMITIR/CANCELAR continuam aqui (Q-F11) | ~565 |
| `tb_establishment_issuer` · `tb_invoice_service_transmission` · `_event` (058–061) | **nascem no banco do serviço** como `tb_licensee` · `tb_emitter` · `tb_issuer` (emitente × modelo) · `tb_fiscal_document` + transmissão/voz por FAMÍLIA de autoridade (§3.F) | DDL novo (`revisar-ddl`) + **migração única dos dados da Setes** (transmissões, vozes, XMLs, A1) | 6 tabelas + script |
| Vínculo no ERP: `tb_invoice_fiscal_document` (nota × vida × modelo × id do documento na API; sem FK, molde `tb_bank_slip_title`) | **novo no setes-api** | NOVO: **sem coluna de estado** (§3.B/§3.I-4 — estado é derivado na API e lido por lote de referências); alternativa (b) espelho de EXIBIÇÃO escrito só pela notificação = Q-F16 | 1 tabela |
| Testes (7 arquivos) | 5 migram (mocks na fronteira já isolam `pool`/adapter), 2 ficam/adaptam (cancel adversarial, folder-zone) | ADAPTAR nomes de módulo e chaves | 1.460 |
| `runningRefresh` / `runningBatch` em memória | morrem | trava no banco (linha do emitente `FOR UPDATE WAIT`) ou semântica "1 por instância" declarada | — |

**O que NÃO migra (e por quê)**: `tb_invoice_event` E/C e `cancelInvoice` (vida da nota é do ERP); `calcIssqn`, `@shared/service-tax-rule`, `@shared/tax-rule` (imposto é do ERP — a API declara, não calcula); `tb_entity_tax` 062/063 (fatos do emitente são CADASTRO do ERP e viajam no payload — Q-F15; o regime também alimenta a regra de ISS); privilégios de ação (autorização de USUÁRIO é do ERP; o serviço autentica o LICENCIADO); `lockInvoice`/`lockInstitutionCounters` (o contador nDPS migra para o serviço; o lock da nota e a numeração do 55/65 ficam — §3.I-2); a cadeia de entidade (teste do terceiro cego: o Gestao2016 não tem `tb_entity`).

---

## 5. Arquitetura proposta (Rodada 0 — tudo sujeito às Q-F)

### 5.1 Contrato externo da `fiscal-api` — família `/v1/nfse` (OpenAPI design-first)

Vocabulário: o do adaptador (`DpsInput`, `CancelEventInput`, `ParsedNfse`) — já é o vocabulário do XSD, não do ERP. Nomes conforme o parecer §3.F (`licensee` · `emitter` · `issuer` · `fiscal document` · `externalCode`).

| Recurso | Operação | Semântica |
|---|---|---|
| `POST /v1/emitters` · `GET /v1/emitters/{cnpj}` · `PUT /v1/emitters/{cnpj}/models/{SE}` | habilitação | emitente = CNPJ + identidade fiscal mínima (cMun IBGE, IM, nome, fuso IANA) + linha por modelo (ambiente H/P, série, contador) |
| `PUT /v1/emitters/{cnpj}/certificate` (.pfx + senha) · `GET` (só metadados) · `DELETE` | cofre | PKCS#12 → par PEM; senha nunca persiste (D-N5); UM A1 por emitente (D-N31) |
| `POST /v1/nfse/documents` | transmitir | corpo = fatos do DPS (competência, prestador: regTrib/pTotTribSN, tomador, serviço, valores, `dhEmi` com offset da zona) + `externalCode` (id do consumidor) + `externalUser` (autoria opaca); idempotência POR CONSTRUÇÃO pelo UNIQUE `(licensee, emitter, external_code)` — retry pós-timeout ACHA o documento (§3.C); **síncrono** com o ADN: 201 A (chave, número, dhProc) · 422 R (códigos E0xxx no `fields[]`) · **202 K/em voo** no desfecho ambíguo (nada fecha — D-I21) |
| `GET /v1/nfse/documents/{id}` · `GET /v1/nfse/documents?externalCode=a,b,c` (lote) | estado | linha do tempo (vozes), estado derivado da última voz da última tentativa, chave, número, pendências; o lote por referências é como a lista do ERP mostra o selo fiscal (Q-F16) |
| `POST /v1/nfse/documents/{id}/attempts` | reapresentar | `attempt + 1` só com a anterior resolvida (R/F); mesma vida = mesmo nDPS (D-N3/D-N18) |
| `POST /v1/nfse/documents/{id}/refresh` · `POST /v1/emitters/{cnpj}/refresh` | consulta | voz por consulta (source Q), rodízio por `last_queried_at`, orçamento de tempo |
| `POST /v1/nfse/documents/{id}/cancel` {motivo} | cancelar no fisco | e101101 síncrono; voz C; **o efeito no ERP é do consumidor** (§5.3) |
| `POST /v1/nfse/documents/{id}/events/{n}/ack` {effectRef} | acusar efeito | o licenciado diz "apliquei o efeito desta voz" (`licensee_effect` na voz — §3.D); voz sem ack = pendência visível dos dois lados |
| `GET …/xml` · `GET …/danfse` · `GET …/events` | arquivos | XML autorizado / evento de cancelamento / PDF nosso |
| `GET /v1/health` · `GET /v1/emitters/{cnpj}/authority-status` | operação | prazo do PAM (D-N15) e disponibilidade |
| Notificação (opcional, Q-F4) | callback | `POST` na URL do licenciado com `inbound_token` (molde do canal do banco) a cada voz nova — só GATILHO de consulta, nunca fonte de verdade (D-I9); `notified_at` na voz; receptor no ERP `/hooks/fiscal-document/:inst/:token` (molde `/hooks/bank-channel`) |

Regras herdadas que o contrato fixa: estado DERIVADO da última voz (nunca coluna `status`); 2xx ilegível = ambíguo (502/K), nunca aceite; recusa de REGRA ≠ transitório (`retryable`); erros com `{error, code, fields[{field, message, expected?}]}` (framework de mensagens).

### 5.2 Identidade e autenticação

- **Licenciado** (`tb_licensee` — parecer §3.C/§3.F; alternativa `tb_client`, Q-F20): quem chama, com chave (`X-Api-Key`, hash no banco, precedente D12 do sync) ou OAuth2 client-credentials (Q-F3). É dono de N emitentes. Autoriza o *acesso*, não a *ação*: TRANSMITIR/CANCELAR por usuário continuam no ERP (Q-F11). Para o próprio setes-api: um licenciado por institution (cerca feita pela API) × um para o ERP inteiro — Q-F17.
- **Emitente** (`tb_emitter`) = CNPJ em cujo nome falamos, dono do A1 (pela D-N29 o A1 É do CNPJ — o emitente pode NASCER do upload), com `time_zone` (pasta do mês, Q-TZ7). **Habilitação** (`tb_issuer`, PK emitente × modelo) = ambiente + série/contador **só do SE** (a série do 55/65 é de quem numera, o ERP — Q-F18). O setes-api mapeia `institution → CNPJ` (`tb_company.cnpj` da própria entity). Cofre: `SECRETS_PATH/emitter/<id>/P/` (um A1 por emitente — D-N31), sem `<schema>`.
- Rate limit por licenciado; idempotência pelo UNIQUE `(licensee, emitter, external_code)` (§3.C); auditoria por licenciado (quem pediu o quê, `externalUser` opaco).

### 5.3 O fluxo que atravessa a fronteira (NFS-e)

> ⚠️ Este fluxo (setes-api chamando a fiscal-api) está EM REVISÃO pela §11: o Valdo quer o setes-app como cliente direto e o setes-api passivo. A versão candidata do fluxo está em §11.3; esta fica como registro da Rodada 1 até a Q-F27 decidir.

```
setes-api (billing.fiscal.service)                 fiscal-api (família nfse)                ADN
  1. readServiceInvoice + buildDpsBase  ──► fatos  (FICA: ERP monta o PEDIDO; 422 de cadastro são do ERP)
  2. grava o VÍNCULO nota×vida×modelo → externalCode (ato de quem tem TRANSMITIR)
     ─ POST /v1/nfse/documents {externalCode, fatos} ──► UNIQUE(licensee, emitter, external_code): acha ou cria o documento
                                                       reserva attempt (lock emitente·série) → nDPS; assina; *-dps.xml ──► POST /nfse
                                                       voz A/R (source P) · ambíguo = K em voo  ◄──────────── 2xx / 4xx / timeout
  3. ◄── 201 {documentId, attempt, state A, chave, nº}   |  422 R (fields[])   |  202 K
  4. completa o vínculo com o documentId — transação do ERP, SEM o fisco dentro; NENHUMA coluna de estado (Q-F16)
  5. lista/detalhe/selo fiscal: GET /documents?externalCode=a,b,c (lote); API fora = selo "indisponível", ações fiscais 503;
     "Consultar" = POST /refresh
  6. cancelar nota: buildCancelPlan lê o VÍNCULO FOR UPDATE → sem vínculo = nunca declarada = cancela local; com vínculo =
     GET /documents/{id} ANTES da transação (como reconfirmBeforeLocalCancel já faz) → POST /cancel → voz C →
     cancelInvoice local na transação do ERP (idempotente) → POST .../events/{n}/ack; sem ack = pendência visível nos dois lados
     + "Reaplicar efeito" (D-I25)
```

O que muda de verdade: hoje voz e efeito moram na MESMA transação (SAVEPOINT). O parecer §3.D fixa que isso era conveniência de banco compartilhado — o invariante sempre foi "só a voz muda estado; o efeito é aplicado pela composição; recusa = fato + pendência" (D-I10). Com dois serviços, TODA aplicação de efeito vira o que o webhook do Inter já é; a D-N7 relaxa para "C local SÓ da voz; efeito na transação do ERP; falha = pendência reaplicável" (Q-F19). Vira maquete se o ERP decidir por estado em cache em vez da voz, se a API conhecer `tb_invoice_event`, ou se um C local nascer sem voz.

### 5.4 Persistência e arquivos

- Banco próprio **`fiscal_api`** (Q-F5 — NUNCA `setes_<algo>`: casaria com o `SCHEMA_RE` dos schemas de cliente, §3.I-5), um banco com escopo por linha `tb_licensee_id`: `tb_licensee` · `tb_emitter` (CNPJ, nome, cMun IBGE, IM, `time_zone`) · `tb_issuer` (emitente × modelo: ambiente, série/contador do SE) · `tb_fiscal_document` (emitente, modelo, `external_code` UNIQUE por licenciado×emitente, número) · transmissão (attempt, ambiente congelado, dps_id, chave, número, dh_proc, last_queried_at) e voz (append-only: kind + código cru + source + dh + `notified_at` + `licensee_effect`) **por FAMÍLIA de autoridade** (ADN × SEFAZ — fatos diferem, D-E6); amanhã inutilização (família NF-e). Mesma forma das 058–061 — só a chave muda.
- Migrations próprias do serviço (runner igual ao do setes-api); regra PADROES_BANCO (UTC na sessão, REPEATABLE READ, contadores por lock — §9/§10) herdada.
- XML em `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mes>/` (já é assim); cofre e storage atrás de interface com backend trocável (filesystem → objeto/KMS) — pré-requisito de 2+ instâncias.
- **Migração única dos dados da Setes**: `tb_establishment_issuer` → `tb_emitter` + `tb_issuer`; transmissões + vozes → documento/tentativa/voz com `external_code = <invoiceId>:<vida>`; XMLs copiados; A1 copiado para `emitter/<id>/P/`; o VÍNCULO do ERP (`tb_invoice_fiscal_document`) nasce do mesmo script; `dps_number` do ramo deixa de ser lido. Corte com homologação H antes de P (Q-F7).

### 5.5 Escala — o que o serviço precisa ter desde o 1º dia

1. Instância sem estado único: nenhum `Map/Set` de controle (lote/rodízio) — trava do emitente no banco (`FOR UPDATE WAIT n`, D-A23).
2. Serialização por construção: 1 tentativa viva por documento; contador por emitente×série sob lock (regra 7 do PADROES §9).
3. UNIQUE `(licensee, emitter, external_code)` por construção (replay = acha o documento e devolve o estado, nunca 2ª NFS-e — a chave repetida foi achado real da Q-N33; `seuNumero` não único foi o da Q11 do Inter).
4. Orçamento de tempo por requisição (o ADN leva segundos por DPS) e lote fora da API: quem lota é o consumidor (como hoje) ou uma fila interna com relatório consultável (candidata, não desta onda).
5. Logs estruturados com `documentId`/`externalCode`/`licensee`; `/health` que prova banco + cofre; métricas mínimas (documentos/dia por licenciado — contagem DERIVADA das tentativas, nada a modelar — Q-F12).

### 5.6 Repositórios, pastas e espelho de conhecimento (impacto na raiz fixa)

A raiz `D:\Gestao2027` tem tabela FIXA de pastas (CLAUDE.md / `ORGANIZACAO_PASTAS.md` §1). Qualquer opção abaixo exige atualizar as duas tabelas e criar o espelho `Infra-IA/<projeto>/` (regra de simetria).

| Opção | Pastas/repos | Prós | Contras |
|---|---|---|---|
| (a) duas pastas `nfse-api/` e `nfe-api/`, cada uma seu repo, cofre próprio | 2 repos + 2 espelhos | literal ao pedido | **maquete pelo parecer §3.E**: o emitente sobe o MESMO A1 em dois cofres e tem duas habilitações para um CNPJ; núcleo duplicado |
| (b) um repo `fiscal-api/` **com dois PROCESSOS por família** (`--family nfse` / `--family nfe`), um banco `fiscal_api`, um cofre | 1 repo + 1 espelho; 2 deployáveis | escala e deploy independentes por família; D-N31 por construção; código comum sem pacote publicado | legítima SÓ como topologia de (c) — mesma base de código, mesma verdade; disciplina de fronteira entre famílias |
| (c) **`fiscal-api/`** único — famílias `/v1/nfse` e `/v1/nfe` no mesmo processo **(Recomendado pelo guardião — conceito ÚNICO: um emitente, um A1, uma habilitação por modelo, uma política da voz)** | 1 repo, 1 espelho, 1 deployável | mais simples; nome pelo CONCEITO (emissão fiscal), não pelo documento (`tb_nfse` paralela foi o erro do legado) | escala uniforme — se a NFC-e pedir perfil próprio, vira (b) sem mudar modelo |

### 5.7 Deploy

Dockerfile (Node 20, `npm ci`, `tsc`, `node dist/server.js [--family nfse|nfe]`), `docker-compose` de dev (MySQL + setes-api + fiscal-api), variáveis (`DB_*`, `SECRETS_PATH`, `STORAGE_PATH`, `FISCAL_API_KEYS_PEPPER`), volumes para cofre/XML, HTTPS pelo LB da SaveInCloud, `pre-deploy` check (molde `scripts/pre-deploy-tz-check.ts`). A `fiscal-api` é candidata a **1º serviço publicado** (superfície pequena, contrato fechado, trilha P8 como régua) — Q-F10.

### 5.8 Multi-app por cliente (Rodada 1 — D-F2)

Três níveis, três fatos geradores — a estrutura do parecer §3.C ganha um nível abaixo do licenciado:

| Nível | Peça | Fato gerador | O que carrega |
|---|---|---|---|
| Cliente | `tb_licensee` | licenciamento (o cliente contrata a emissão) | identidade comercial, limites (req/min, documentos/dia), URL de notificação + `inbound_token`, `active` |
| Aplicativo | `tb_licensee_app` ⚠️ nome na Q-F20 | o cliente AUTORIZA um app a chamar em seu nome (setes-api, app Android de vendas, sistema de terceiro…) | `app_id` público + `secret` (só hash), **escopos** (`nfse:write`, `nfse:read`, `nfe:write`, `emitter:admin`), emitentes permitidos (todos do licenciado ou lista), `revoked_at`, `last_used_at` |
| Emitente | `tb_emitter` / `tb_issuer` | o A1 + a habilitação por modelo | como no §3.F |

Autenticação (revisa a Q-F3): o app troca `app_id + secret` por um **token curto** (`POST /v1/auth/token`, client-credentials simplificado, JWT de ~1 h assinado pela fiscal-api) e chama com `Authorization: Bearer`. A chave em si nunca viaja em cada requisição e a revogação é imediata na próxima troca. **Aplicativo móvel/web do usuário final NÃO guarda o secret**: ou opera através do backend do cliente (setes-api, que é um `tb_licensee_app` com escopo pleno), ou recebe do backend um token curto já trocado (token exchange) — Q-F22. Rate limit e auditoria por app (`externalUser` opaco continua sendo a autoria dentro do app). CORS liberado por lista de origens do licenciado (web direta); Swagger/OpenAPI público com exemplos por família é parte da entrega, não documentação interna.

Autorização de AÇÃO continua do ERP (Q-F11): a fiscal-api sabe que o app PODE emitir pelo emitente X; quem dentro do cliente pode apertar "transmitir" é regra do sistema que chama.

### 5.9 Dimensionamento para 1000 clientes (Rodada 1 — D-F3; premissas marcadas, número real = Q-F23)

| Premissa (a confirmar) | Valor assumido | Documentos/dia |
|---|---|---|
| 60 % dos clientes = serviços (NFS-e) | 600 × 30/mês ÷ 22 | ~800 |
| 40 % = mercadoria com NF-e | 400 × 20/dia útil | ~8.000 |
| metade dos de mercadoria tem PDV (NFC-e) | 200 lojas × 200/dia | ~40.000 |
| **Total** | | **~49.000/dia** (≈ 1,7/s média em 8 h; pico ≈ 5/s) |

Consequências de engenharia (o que a F3 precisa provar, não só declarar):

| Dimensão | Número derivado | Implicação |
|---|---|---|
| Concorrência com o fisco | 5/s × 1–3 s por autorização → 5–15 chamadas simultâneas | 2 instâncias Node bastam para a CPU; o gargalo é o fisco — orçamento por requisição, `keep-alive` por emitente, fail-closed quando a autoridade cai (regra D-I8) |
| Linhas no banco | ~5 por documento (documento, tentativa, 2 vozes, ack) → ~250 k/dia → **~60 M/ano** | índices por `(licensee, emitter, external_code)` e `(emitter, created_at)`; **particionamento por ano ou arquivamento** a partir do 1º ano; nunca `SELECT` sem escopo de licenciado |
| XML em disco | 8–15 KB × 49 k → **0,5–0,75 GB/dia → ~200 GB/ano** | filesystem local NÃO serve a 2+ instâncias nem a esse volume: **storage de objeto (S3-compatível)** atrás da interface que já existe (`storageRoot()`); retenção legal 5 anos |
| Certificados A1 | ≥ 1.000 pares PEM (N por cliente com filiais), renovação anual | cofre **criptografado em repouso** (KMS ou chave-mestra) atrás de `secret-store`; **alerta de vencimento por licenciado** (o A1 da Setes vence 08/10/2026 — caso zero do alerta) |
| Consultas ao fisco | rodízio por emitente; SEFAZ pune consulta repetida (cStat 656) | o `refresh` sai da requisição e vira **worker** com orçamento global e por emitente (mata `runningRefresh` por construção); NF-e assíncrona (recibo 103/105) exige o mesmo worker — Q-F25 |
| Lote do ERP | D27: 50 ordens/requisição, 60 s | continua no CONSUMIDOR; a fiscal-api é por documento. Fila interna só se um licenciado pedir "transmitir 5.000" — fora desta fase |
| Observabilidade | 1000 clientes = 1000 "ele disse que a nota não saiu" | log estruturado com `licensee/app/emitter/externalCode/documentId`, métricas por licenciado (documentos, rejeições por E0xxx, latência do fisco), `/health` que prova banco + cofre + storage |

Teste de carga como critério de aceite (§10.9): script `scripts/carga-fiscal.ts` contra um fisco FALSO (stub do ADN com latência e falhas configuráveis) simulando 1000 licenciados / 5 req/s por 30 min: p95 < 5 s fora do tempo do fisco, zero 500, zero documento duplicado, 2 instâncias.

### 5.10 Estrutura do projeto `fiscal-api` (Rodada 1 — D-F1; criada nesta sessão SEM código)

```
D:\Gestao2027\fiscal-api\                 ← repo próprio (valdosouza/gestao-2027-fiscal-api), porta 3002
├── CLAUDE.md                              regras para agentes (fronteira, nomes, teste do terceiro cego)
├── README.md                              estado: F0 — nada de código até D-F fechar F1
├── .env.example · package.json · tsconfig.json (paths @gateway/@modules/@shared — molde setes-api)
├── src/
│   ├── gateway/        auth por token de app (JWT curto) · rate limit por app · router /v1 · CORS por licenciado
│   ├── modules/        licensees · licensee-apps · emitters · issuers · nfse (documents/attempts/events/xml/danfse/ack) · nfe (F4) · auth (token) · hooks (notificação de saída)
│   ├── shared/         tax-authority (adn · sefaz) · xmldsig · secret-store (owner emitter) · storage (fs → objeto) · fiscal-document (máquina de estados por FAMÍLIA) · pdf (danfse · danfe) · db · errors · logger · swagger · time-zone
│   ├── migrations/sql/ banco `fiscal_api` (runner = molde do setes-api)
│   └── __tests__/
├── scripts/            migrate-from-setes-api.ts · smoke-adn-h.ts · carga-fiscal.ts · pre-deploy-check.ts
└── (contratos oficiais ficam no espelho: Infra-IA/fiscal-api/integracoes/ — hoje em Infra-IA/setes-api/integracoes/nfse-adn)

Infra-IA\fiscal-api\                      ← espelho de conhecimento (regra de simetria)
├── INDEX.md                               START HERE (criado 2026-10-03)
├── prompt_fase1_fiscal_api.md             (quando este prompt fechar — hoje em prompts/)
└── skills/                                (nascem com a F1: novo-modulo-fiscal, nova-familia-de-autoridade)
```

Entrou nas tabelas fixas da raiz (CLAUDE.md, `ORGANIZACAO_PASTAS.md`) e no `INDICE_CENTRAL.md` nesta sessão. Módulo de cadastro na fiscal-api segue `ARQUITETURA_MODULOS_API.md` (6 arquivos, `/v1/<modulo>`); o módulo `nfse` é tela de PROCESSO (molde `bank-slips`), não cadastro.

---

## 6. Plano em ondas e esforço

| Onda | Entrega | Tamanho | Esforço (sessões) | Calendário | Depende de |
|---|---|---|---|---|---|
| **F0 — Decisões + contrato** | Rodadas 1..N deste prompt (Q-F2…Q-F26); OpenAPI `v1` da `fiscal-api` (família nfse + auth de apps) escrito ANTES do código (design-first, nível PÚBLICO: exemplos, códigos de erro, limites), já paramétrico por família; DDL do `fiscal_api` revisado (`revisar-ddl`) | 1 OpenAPI (~800 linhas) + DDL (7 tabelas) | 3–4 | 2–3 dias | Valdo (decisões) |
| **F1 — `fiscal-api`, família nfse** | repo `fiscal-api/` (D-F1); mover tax-authority/xmldsig/secret-store/fiscal-issuer/danfse/máquina de estados + repository re-chaveado por emitente/documento; `emitterDpsFacts` (Anexo I); shell do serviço (**licenciado + apps + token curto + escopos + CORS por licenciado**, UNIQUE de idempotência, rate limit por app, OpenAPI servido, health, logger, migrations próprias); DTOs zod do payload; testes migrados + novos; script de migração dos dados da Setes; smoke contra o ADN H com o A1 real | ~3,7 k linhas movidas/adaptadas + ~2,4 k novas + ~2,3 k testes | 10–14 | 7–10 dias úteis (inclui 2 rodadas de gates) | F0 |
| **F2 — setes-api consumidor** | `@shared/fiscal-client` (HTTP, mapeamento de erros → `FISCAL_*`, retry só em `retryable`); `branches/service.ts` vira montador do pedido; VÍNCULO `tb_invoice_fiscal_document` + ack de efeito + pendências; `billing.fiscal.service` e `establishment.issuer.service` chamam o cliente; lista com selo por lote de referências (ou espelho de exibição — Q-F16); `buildCancelPlan.fiscal` lê vínculo + pergunta à API; `dps_number` aposentado no ramo; trilha P8a/P8b OK; app INALTERADO; corte H → P da Setes | ~2,1 k linhas alteradas + ~500 testes + 1 migration | 5–7 | 4–5 dias úteis (gates do delta) | F1 |
| **F3 — Produção ESCALÁVEL (piloto da Onda 4; D-F3)** | Dockerfile, compose, variáveis/segredos fora do repo, HTTPS/DNS (`fiscal.setesgestao.com.br`?), **2+ instâncias atrás do LB**, **storage de objeto para XML** atrás de `storageRoot()`, **cofre criptografado em repouso** atrás de `secret-store`, **worker de refresh/rodízio** (fim do `runningRefresh`), alerta de vencimento de A1 por licenciado, particionamento/arquivamento planejado, métricas por licenciado, backup, pre-deploy check, **teste de carga `carga-fiscal.ts`** (1000 licenciados × 5 req/s × 30 min contra fisco falso); `fiscal-api` publicada e o setes-api do dev apontando para ela | infra + ~1,2 k linhas (worker, storage/cofre adaptadores, carga) | 6–10 | 1–2 semanas + espera externa (DNS, SaveInCloud: oferta de objeto/KMS — Q-F25) | F2 + Q5/Q6 da fase Primeiro Cliente |
| **F4 — família nfe (NF-e 55) — nasce NA API, nunca no ERP (§3.I-6)** | levantamento oficial (`integracoes/nfe-sefaz/`: MOC 7.0, NT 2025.002, schemas PL, autorizadores, cStat); `adapters/sefaz.ts` (SOAP 1.2: autorização síncrona/assíncrona com recibo, consulta protocolo, status, evento 110111, inutilização) + `authorizers.ts`; builder NF-e 4.00 com grupos ICMS/CSOSN/IPI/PIS/COFINS/ICMSUFDest **+ IBS/CBS**; chave 44 (série e número vêm do ERP no payload — Q-F18) + cDV; validação XSD; voz com P e D; inutilização de faixa; DANFE A4 (motor pdfkit); ERP: `branches/merchandise.ts` como montador do pedido (6 snapshots + cadeia + NCM/CEST/EAN + transporte), vínculo por ramo, bloco fiscal por ramo, cópia de ordem #20, aba "Numeração"; app: seção "No fisco" no pedido faturado | ~8 k linhas novas no serviço + ~2 k no ERP + ~1,5 k Dart + ~3 k testes | 25–35 | 5–7 semanas (≥ 3 rodadas de gates; 1ª sessão real na SEFAZ-PR H crava cStat e assinatura) | **D-E20** (1º cliente de mercadoria) · fase IBS/CBS no motor (Q-F14) · e-CNPJ do cliente |
| **F5 — NFC-e 65 (PDV)** | QR Code v2 + CSC no cofre, contingência off-line (tpEmis 9) com transmissão posterior, prazo de cancelamento em minutos, série por terminal, DANFE NFC-e (bobina), fila assíncrona para volume | ~4 k serviço + PDV no app (onda própria do PDV) | 15–25 | 3–5 semanas | F4 + onda do PDV |

**Totais (Rodada 1)**: `fiscal-api` com NFS-e em produção ESCALÁVEL (F0–F3) = **24–35 sessões ≈ 5–6 semanas de calendário** com gates (era 18–27 na Rodada 0 — a diferença é multi-app, contrato público e produção para 1000); família NF-e (F4) = **+25–35 sessões ≈ 5–7 semanas**, só com fato gerador; NFC-e (F5) = +15–25. Comparação: a Onda 3 inteira (fisco desconhecido) levou 10 dias — F1+F2 movem código provado, por isso a faixa parecida apesar do volume maior. O parecer §3.I-6 pesa a favor de extrair AGORA: fazer a NF-e dentro do ERP e extrair depois paga a extração duas vezes.

**Frentes IRMÃS que a visão da Rodada 1 exige e que NÃO são da fiscal-api** (dimensionadas para o Valdo decidir se entram, quando e onde):

| Frente | Por quê a visão precisa dela | Tamanho | Onde vive |
|---|---|---|---|
| **S1 — setes-api como plataforma para apps de venda** (Q-F21 leitura (a)) | "aplicativos de vendas que criam orders e enviam para autorização" hoje só existem como setes-app com JWT de usuário; um app de terceiro precisa de credencial de APLICATIVO por institution, escopos, contrato `/v1` público de pedidos + faturamento + "faturar e autorizar" numa chamada (PDV não espera duas), documentação pública | 8–12 sessões | setes-api (prompt próprio — molde deste: licenciado/app vira `tb_institution_app`?) |
| **S2 — setes-api em escala de 1000 clientes** (Q-F24) | fatos do código hoje: `runMigrationsForAllInstitutions` roda as migrations dos N schemas a CADA boot (1000 schemas = minutos de boot e deploy serial); pool único `connectionLimit: 20`; rate limit 300/min por institution em memória; `interface-config` cache por processo | 3–5 sessões de DIAGNÓSTICO (medir com 1000 schemas sintéticos) antes de qualquer correção | setes-api (fase própria) |
| **S3 — IBS/CBS** (Q-F14) | pré-requisito da família NF-e e da própria NFS-e da Setes em 01/01/2027 | fase própria (motor + 2 builders) | setes-api motor + fiscal-api builders |

**Riscos que puxam para o teto**: (1) homologação do ADN só com o A1 real da Setes (vence **08/10/2026** — renovar antes de F1 terminar); (2) SaveInCloud/DNS fora do nosso controle (F3); (3) SEFAZ-PR em homologação exige e-CNPJ de empresa com IE — a Setes não emite NF-e (F4 precisa do cliente); (4) IBS/CBS é fase do motor do ERP, não da API — sem ela a NF-e de regime regular é rejeitada desde 03/08/2026; (5) XSD validation em Node não é nativa (libxmljs2 ou `xmllint` externo) — decidir na F4.

---

## 7. Decisões registradas (D-F — permanente; numeração contínua)

- **D-F1 (Valdo, 2026-10-03) — `fiscal-api` é UM novo projeto de primeiro nível**, com o mesmo tratamento dos projetos existentes: pasta `D:\Gestao2027\fiscal-api\` (repo próprio), espelho `Infra-IA/fiscal-api/` (INDEX + prompts fechados + skills), linha nas tabelas fixas da raiz. Fecha a **Q-F1** na opção (i) do guardião — uma API nomeada pelo CONCEITO, famílias `/v1/nfse` e `/v1/nfe` — e a **Q-F6** na opção (c). Topologia em dois processos por família (opção (ii)) continua disponível como decisão de deploy, sem mudar modelo. Leitura de "seguindo as estruturas do setes-app" registrada no §1.5 (estrutura de PROJETO; o código segue o molde do setes-api). *Por quê*: palavras do Valdo; coerente com o parecer §3.E (um emitente, um A1, uma política da voz).
- **D-F2 (Valdo, 2026-10-03) — todo cliente, inclusive a Setes, consome a API diretamente, com múltiplos aplicativos** (web, Android, iOS, apps de venda de terceiros), cada um acessando o PRÓPRIO ambiente do cliente. Consequências: licenciado = o CLIENTE (fecha a **Q-F17** em (a) — um `tb_licensee` por institution/cliente); nasce a credencial por APLICATIVO (`tb_licensee_app`, §5.8 — nome na Q-F20) com escopos e revogação; token curto por app (revisa a Q-F3, §5.8); CORS por licenciado; OpenAPI de nível público desde a F1. ~~O setes-api passa a ser UM dos apps do licenciado (escopo pleno), não o único consumidor.~~ ⚠️ **Esta frase está EM REVISÃO pela 3ª mensagem do Valdo (§11, Q-F27): ele não quer o setes-api como cliente da fiscal-api — o setes-app (e qualquer front-end) é o cliente.** As demais partes da D-F2 (licenciado = cliente, múltiplos apps, credencial por app, token curto) seguem valendo. *Por quê*: palavras do Valdo; a cerca por cliente é feita pela API (a D12 do sync já fazia por institution).
- **D-F3 (Valdo, 2026-10-03) — requisito não-funcional: a API publicada deve aguentar 1000 clientes emitindo e autorizando notas.** Vira dimensionamento (§5.9, premissas a confirmar na Q-F23), redefine a F3 como "produção ESCALÁVEL" (2+ instâncias, storage de objeto, cofre criptografado, worker, teste de carga como critério de aceite §10.9) e expõe as frentes irmãs S1/S2 (§6) que a fiscal-api não resolve sozinha. *Por quê*: número dado pelo Valdo; sem número, "escalável" não é testável.

---

## 8. ⚠️ Questões pendentes — Rodada 1 (recomendação entre parênteses)

- ~~**Q-F1 Uma API, duas ou duas com núcleo comum?**~~ → **DECIDIDA = D-F1** (opção (i): `fiscal-api` única com famílias; (ii) fica como topologia de deploy).
- **Q-F2 Transmissão e voz moram no serviço ou no ERP?** (a) **no serviço** (tentativa, voz, nDPS, XML, DANFSe); o ERP guarda só o VÍNCULO nota × documento (estado: Q-F16) · (b) no ERP; o serviço é só transporte (assina + mTLS + parse). *(Rec.: (a), confirmada pelo guardião §3.B — em (b) cada consumidor reimplementa a parte que os gates provaram ser a difícil: K em voo, reconciliação, ambíguo nunca fecha, 1 viva por documento; e o par PEM teria que viajar por chamada.)*
- **Q-F3 Autenticação dos aplicativos** (revisada pela D-F2 — múltiplos apps por cliente desde o 1º dia): (a) API key fixa por app no header (`X-Api-Key`, precedente D12) · (b) **credencial por app (`app_id` + `secret` só em hash) trocada por TOKEN CURTO (`POST /v1/auth/token`, JWT ~1 h) — client-credentials simplificado, §5.8** · (c) OAuth2 completo (authorization server). *(Rec.: (b) — a chave nunca viaja por requisição, revogação é imediata na próxima troca, serve de base ao token exchange para apps móveis (Q-F22); (a) é frágil com N apps por cliente; (c) é peso sem consumidor que o exija.)*
- **Q-F4 Como a voz nova chega ao ERP**: (a) **resposta síncrona do próprio pedido + `refresh` sob demanda/rotina** (como hoje) · (b) + callback HTTP assinado na URL da conta como GATILHO de consulta (regra do webhook do Inter). *(Rec.: (a) na F1/F2; (b) como opção da conta na F3, quando houver URL pública.)*
- **Q-F5 Banco do serviço**: (a) **`fiscal_api` único, escopo por linha `tb_licensee_id`** · (b) schema por cliente como o ERP. *(Rec.: (a) — o serviço não tem "cliente do ERP"; tem licenciado e emitente. O nome NÃO pode ser `setes_<algo>`: casaria com o `SCHEMA_RE` dos schemas de cliente — §3.I-5.)*
- ~~**Q-F6 Pastas e repos**~~ → **DECIDIDA = D-F1** (pasta `fiscal-api/` + espelho `Infra-IA/fiscal-api/`, criados em 2026-10-03; repo GitHub `valdosouza/gestao-2027-fiscal-api` a criar pelo Valdo).
- **Q-F7 Corte dos dados da Setes**: (a) **migração única (script) + corte com H antes de P**, sem dual-write · (b) dual-run (ERP grava nos dois) por N dias. *(Rec.: (a) — dual-write em transmissão fiscal cria duas verdades; a trilha P8 e a reconciliação por `dps_id` são a prova.)*
- **Q-F8 D-E20 mantida?** A NF-e em si espera o 1º cliente de mercadoria. O que antecipar da família nfe: (a) **só o contrato OpenAPI já paramétrico por família + levantamento oficial da SEFAZ (`integracoes/nfe-sefaz/`) + a estratégia por família prevista no código da F1** · (b) executar F4 agora porque a API é produto. *(Rec.: (a) — sem cliente não há homologação real nem e-CNPJ com IE; IBS/CBS (Q-F14) precede qualquer NF-e. Em qualquer caso, pelo §3.I-6 a NF-e **nasce na API, nunca no ERP** — a D-E20 segue valendo para o QUANDO, não para o ONDE.)*
- **Q-F9 Legado Gestao2016 como 2º consumidor da `nfse-api`?** Curitiba exige NFS-e nacional desde 01/01/2026 — o webservice municipal do legado morreu. (a) registrar como candidato (fora desta fase) · (b) planejar `TNfseSendWeb` no sincronizador · (c) o legado chama a `nfse-api` direto. *(Rec.: (a) — a regra dos dois grupos (sincronizador ↔ setes-sync) precisaria de decisão própria antes de nascer um 3º grupo.)*
- **Q-F10 Ordem**: (a) **F1 → F2 no dev → F3 publica a `nfse-api` como piloto da Onda 4** · (b) Onda 4 do ERP inteiro primeiro, extrair depois. *(Rec.: (a) — a extração não depende de produção, e publicar primeiro o serviço pequeno ensina a SaveInCloud com menos superfície.)*
- **Q-F11 Autorização de AÇÃO** (TRANSMITIR/CANCELAR por usuário) fica no ERP; o serviço só autentica a CONTA e registra o `requestedBy` opaco que o consumidor mandar. *(Rec.: sim — privilégio é do usuário do ERP; o serviço não tem usuário.)*
- **Q-F12 Produto/cobrança do serviço** (metering por documento, planos): fora desta fase; só garantir que "documentos emitidos por conta/mês" seja consulta derivada das tentativas. *(Rec.: fora; nada a modelar.)*
- **Q-F13 Versionamento**: `/v1/` desde o 1º dia (contrato externo), `Accept-Version` não. *(Rec.: sim — diferente do `/api` interno, que acompanha o app.)*
- **Q-F14 IBS/CBS** é pré-requisito da F4 (NF-e regime regular desde 03/08/2026; Simples 01/01/2027 — inclusive a NFS-e da Setes). Vive no motor do ERP (`tb_order_item_ibscbs` + regra) e no builder dos dois documentos. (a) **fase própria "IBS/CBS" antes da F4 e antes de 01/01/2027 para a NFS-e** · (b) dentro da F4. *(Rec.: (a) — toca os dois documentos e o motor; não é da API fiscal.)*
- **Q-F15 O que do emitente é CADASTRO no serviço × o que viaja por documento**: (a) **cadastro: CNPJ, nome, cMun IBGE do emitente, IM, fuso IANA, ambiente/série por modelo; por documento: regTrib (opSimpNac/regApTribSN/regEspTrib), pTotTribSN, tomador, serviço, valores** · (b) tudo no cadastro do emitente. *(Rec.: (a) — regime e alíquota efetiva mudam no tempo e são fatos da competência; o XML congela; o ERP já os valida (422 `FISCAL_EMITTER_INCOMPLETE`); a API aplica a matriz do Anexo I (`emitterDpsFacts`) e devolve o mesmo `fields[]`.)*

**Acrescentadas pelo parecer do guardião (§3.I):**

- **Q-F16 Estado fiscal no ERP**: (a) **sem espelho — lista e detalhe por lote de referências (`GET /documents?externalCode=…`); API fora = selo "indisponível" e ações fiscais 503** · (b) espelho de EXIBIÇÃO escrito só pela notificação, nunca decisório. *(Rec.: (a) — zero coluna de estado; "status sincronizado por cron" é maquete. (b) só se a latência da lista de OS doer de verdade — medir antes.)*
- ~~**Q-F17 Granularidade do licenciado**~~ → **DECIDIDA = D-F2** (um licenciado por CLIENTE; o setes-api é um `tb_licensee_app` de escopo pleno de cada licenciado, provisionado no onboarding da institution).
- **Q-F18 D-E2 diverge — quem guarda a série**: a série do 55/65 é fato de quem NUMERA (ERP); a do DPS, de quem DECLARA (API). (a) **API guarda série/contador só do SE; 55/65 numeram no ERP e série + número viajam no payload** · (b) API guarda as séries de todos e o ERP a lê antes de cunhar. *(Rec.: (a) — em (b) o ERP não numera com a API fora = maquete; `tb_establishment_issuer.serie` do 55 fica no ERP, a linha SE migra.)*
- **Q-F19 D-N7 relaxa**: "voz C → C local na MESMA transação" é impossível entre serviços. Confirmar o invariante como **"C local SÓ da voz; efeito na transação do ERP, idempotente; recusa ou falha = pendência visível e reaplicável; ack à API"**. *(Rec.: confirmar — já é o que vale para o C vindo da consulta.)*
- **Q-F20 Palavras**: licenciado = `tb_licensee` × `tb_client`; credencial por aplicativo (D-F2) = `tb_licensee_app` × `tb_app` × `tb_app_credential`. *(Rec. do guardião: `tb_licensee` — "licença" já é o sentido de `tb_institution.active`; `client` colide com cliente/tenant/customer; `consumer` com consumidor final. Para o app: `tb_licensee_app` — diz de quem é e o que é; "app" está livre na tabela de ocupadas. Palavra é decisão do Valdo — lição "contrato".)*

**Acrescentadas pela Rodada 1 (2ª mensagem do Valdo, §1.5):**

- **Q-F21 Onde vive o PEDIDO dos aplicativos de venda?** "Apps de venda que criam orders e enviam para autorização": (a) **o pedido nasce no AMBIENTE DO CLIENTE (setes-api: `tb_order` + faturamento com os impostos congelados) e o setes-api orquestra "faturar e autorizar" numa chamada; a fiscal-api só recebe o documento pronto** · (b) a fiscal-api aceita PEDIDOS (itens, preços) e produz a nota — o que exige cálculo de imposto, catálogo de produtos/regras e cadastro de clientes dentro dela. *(Rec.: (a) — (b) recria o ERP dentro da API fiscal e contradiz o parecer §3 ("a API responde pelo FORMATO; o ERP pelo CONTEÚDO"); o que (a) exige é a frente irmã S1 (setes-api como plataforma para apps, com "faturar e autorizar" síncrono para PDV). Se a intenção for atender quem NÃO usa o ERP, isso é um produto diferente — "motor de nota" — e merece prompt próprio.)*
- **Q-F22 Acesso DIRETO de app móvel/web do usuário final à fiscal-api**: (a) **não guarda secret no dispositivo: o backend do cliente (setes-api) é o `tb_licensee_app` e repassa um token curto já trocado (token exchange) ou faz a chamada** · (b) o app móvel carrega a credencial do licenciado (secret extraível do APK/IPA) · (c) só via backend, nunca direto. *(Rec.: (a) — direto quando precisar (PDV offline-first consultando estado), seguro porque o token expira; (b) é vazamento por construção.)*
- **Q-F23 Perfil de carga dos 1000 clientes** (as premissas do §5.9 são chute): quantos são serviço × mercadoria × PDV, documentos/dia típicos e pico (Black Friday, fechamento de mês), quantos estabelecimentos por cliente (A1 por CNPJ). *(Rec.: responder com a base do legado — o Gestao2016 tem a estatística real dos clientes atuais da Setes; sem isso, a F3 dimensiona pelo §5.9 e o teste de carga fixa o número.)*
- **Q-F24 setes-api em escala de 1000 clientes (frente irmã S2)**: hoje o boot roda migrations em TODOS os schemas (`runMigrationsForAllInstitutions`), o pool é único (`connectionLimit: 20`), o rate limit é em memória por processo. (a) **diagnóstico com 1000 schemas sintéticos ANTES de decidir** (medir boot, deploy, pool) · (b) decidir já: migrations sob demanda/por versão gravada, pool dimensionado, rate limit compartilhado. *(Rec.: (a) — fato antes de intenção; a fiscal-api não depende disso, mas a visão "1000 clientes criando pedidos" depende.)*
- **Q-F25 Infra de produção para a escala**: storage de objeto S3-compatível para XML (200 GB/ano) e cofre criptografado em repouso (KMS ou chave-mestra) — a SaveInCloud oferece? (a) **descobrir na F3 e adaptar atrás das interfaces que já existem (`storageRoot()`, `secret-store`)** · (b) exigir desde a F1 (atrasa a extração). *(Rec.: (a) — as interfaces já isolam o backend; o worker de refresh entra na F3 em qualquer caso.)*
- **Q-F26 "Seguindo as estruturas do setes-app"**: a leitura adotada (§1.5) é "mesmo tratamento de projeto" com código no molde do setes-api. Se o Valdo quis dizer outra coisa (ex.: monorepo com `packages/` + `apps/` como o setes-app, ou um app Flutter de administração da fiscal-api), corrigir aqui. *(Rec.: manter a leitura; um app de administração dos licenciados/emitentes, se vier, é tela do setes-app (Super) consumindo a fiscal-api — não um app novo.)*

**Acrescentadas pela 3ª mensagem do Valdo (§11 — "setes-api não vira cliente; o setes-app vira cliente da fiscal-api como qualquer front-end"):**

- **Q-F27 Papel do setes-api perante a fiscal-api**: (a) **PASSIVO — NUNCA chama a fiscal-api: expõe os FATOS do documento, emite o token federado para o app, VERIFICA recibos assinados que o front-end traz (vínculo + efeito), recebe webhook de entrada com o mesmo recibo** (§11.2) · (b) não orquestra, mas pode CONSULTAR (GET) a fiscal-api para listas e plano de cancelamento — cliente só de leitura · (c) manter a D-F2 como estava (setes-api orquestra, app inalterado). *(Rec.: (a) — é o que o Valdo pediu e fecha SEM hearsay (o ERP nunca acredita no app, só na assinatura da fiscal-api); (b) é meia-medida que cria exatamente a dependência de saída que ele quer evitar. Consequência registrável: a regra canônica "setes-app só fala com setes-api" (D1 da revisão do sync; `ARQUITETURA_MODULOS.md` do app) vira "o app fala com os datasources DEDICADOS das APIs do produto; nunca cruza datasources" — decisão explícita, com atualização de memória e CLAUDE.md.)*
- **Q-F28 Emissão iniciada pelo SERVIDOR fica fora por construção** (§11.2-4): sem chamada de saída, a rotina mensal não transmite sozinha e `fiscal_auto_transmit` (D-N9) só existe como "o app transmite logo após faturar". Hoje transmitir já é ato explícito do usuário — nada se perde HOJE; perde-se a opção futura. (a) **aceitar e registrar como conhecimento negativo** · (b) reservar exceção: um ÚNICO processo servidor-para-servidor do setes-api como `tb_licensee_app` só para rotinas sem humano. *(Rec.: (a); se um dia for preciso, (b) nasce como decisão nova — nada no modelo impede.)*

---

## 9. Fora de escopo desta fase

Cálculo de imposto (continua no ERP) · IBS/CBS (fase própria — Q-F14) · NFC-e/PDV (F5, onda própria) · carta de correção, contingência SVC/EPEC, manifestação do destinatário, DF-e distribuição (compra) · metering/cobrança do serviço · sentido web → legado · substituição de NFS-e, análise fiscal e101103 · webservice municipal (D1 da Onda 3 matou).

---

## 10. Critérios de sucesso (testáveis)

1. `fiscal-api` sobe sozinha (sem `setes_central`), com `fiscal_api` vazio + migrations próprias; `/v1/health` prova banco e cofre; OpenAPI servido em `/docs`; **nenhum import de `tb_invoice`/`tb_order`/`tb_entity`** (teste do terceiro cego — cerca por teste de lint/grep).
2. Licenciado + emitente (CNPJ da Setes) + A1 (.pfx + senha → PEM; senha em lugar nenhum) via `/v1`; par inválido/vencido/CN ≠ CNPJ → 4xx legível (D-N29b/D-N30b).
3. `POST /v1/nfse/documents` com os fatos da OS → 201 com chave 50 e número no ADN **H**; replay com o mesmo `externalCode` → mesma resposta, nenhuma 2ª tentativa (UNIQUE por construção); DPS rejeitado → 422 com E0xxx no `fields[]`; timeout simulado → 202 em voo e `refresh` reconcilia por `dps_id`.
4. setes-api: trilha `trilha-primeiro-cliente.ts` P8a/P8b OK contra a `fiscal-api`; lista de OS com selo fiscal por lote de referências (API parada → "indisponível", nunca 500); "Cancelar nota" com NFS-e autorizada → voz C no serviço + C local no ERP + ack; falha local simulada → pendência visível nos dois lados + "Reaplicar efeito" fecha; nota SEM vínculo cancela local sem chamar a API; **nenhum arquivo Dart alterado**.
5. Migração dos dados da Setes: as transmissões/vozes/XMLs existentes aparecem no serviço com `external_code` = nota:vida e o vínculo nasce no ERP; DANFSe da nº 704 renderiza igual; H depois P sem reemitir nada.
6. Escala: 2 instâncias da `fiscal-api` contra o mesmo banco, 6 pedidos concorrentes do mesmo `externalCode` → 1 documento, 1 tentativa viva, zero 500 (molde das provas de corrida das rodadas anteriores); nenhum `Map/Set` de controle em memória.
7. Gates por onda: socrático ≥ 0,70 · adversarial sem HIGH/CRITICAL; achado confirmado vira teste.
8. Família nfe (F4, quando houver fato gerador): NF-e autorizada em homologação da SEFAZ-PR com XML válido no XSD, DANFE renderizado, inutilização de faixa homologada, cancelamento 110111 e denegação tratada como D sem efeito automático.
9. **Carga (D-F3)**: `scripts/carga-fiscal.ts` com 1000 licenciados × 5 req/s × 30 min contra fisco FALSO, em 2 instâncias: p95 < 5 s fora do tempo do fisco, zero 500, zero documento duplicado, nenhum estado em memória de processo; relatório anexado ao prompt.
10. **Multi-app (D-F2)**: dois apps do mesmo licenciado com credenciais independentes emitem pelo mesmo emitente; revogar um não afeta o outro; token expirado → 401 legível; app sem escopo `nfse:write` → 403; app web direta só das origens do licenciado (CORS); nenhum secret em claro no banco, no log ou na resposta.
11. **Operação para 1000**: alerta de vencimento de A1 por licenciado (o da Setes em 08/10/2026 é o caso zero), métricas por licenciado visíveis, `/health` prova banco + cofre + storage.
12. **Se Q-F27 = (a)** — setes-api passivo: nenhuma chamada HTTP de saída do setes-api para a fiscal-api (cerca por grep em `src/`); recibo com assinatura inválida/expirada/de outro licenciado → 401/409 e NADA muda na nota; nota com "declaração solicitada" sem recibo → cancelamento local 409 `FISCAL_RECEIPT_REQUIRED`; app fechado entre o passo 2 e 3 da saga → ao reabrir, o app recupera pelo `externalCode` e completa, sem 2º documento; webhook de entrada com recibo C aplica o efeito sem humano; selo fiscal da lista = último recibo verificado.

---

## 11. Análise — setes-app como cliente DIRETO da fiscal-api (Valdo, 2026-10-03, 3ª mensagem)

> "não quero que setes-api vire cliente e sim o setes-app vire cliente de fiscal-api como qualquer outro front-end... analise isso"

### 11.1 O que a frase muda

| Antes (D-F2 como registrada) | Pedido |
|---|---|
| setes-api = `tb_licensee_app` de escopo pleno; orquestra "faturar → fatos → fiscal-api → vínculo → efeito"; app continua falando só com `/api`, **inalterado** | setes-app (e qualquer front-end) fala DIRETO com a fiscal-api; **o setes-api não chama a fiscal-api** |
| Regra canônica dos dois grupos: setes-app ↔ setes-api × Sincronizador ↔ setes-sync (D1 da revisão do sync); app: "módulo fala só com o seu `/api/<m>`" | nasce uma 3ª aresta: setes-app ↔ fiscal-api. Se confirmado, é decisão EXPLÍCITA: o app consome N APIs do produto, cada módulo com datasources dedicados por API, nunca cruzados |

Não muda o CONCEITO nem a fronteira do parecer §3 (conteúdo no ERP; formato e conversa na API). Muda o **PORTADOR** dos fatos e das vozes: em vez do servidor, o front-end.

### 11.2 As quatro perguntas que o desenho tem que responder — e como responde sem furar a fronteira

1. **Quem monta os FATOS do documento?** O conteúdo é do ERP (§3.B: emitente, tomador, serviço congelado, valores, zona). → O setes-api expõe `GET /api/<ramo>/:orderId/fiscal-facts` = o `buildDpsBase` de hoje SERIALIZADO (o payload do `POST /v1/nfse/documents`) + `externalCode` determinístico (`<schema>:<invoiceId>:<vida>`), e grava na nota a INTENÇÃO ("declaração solicitada"). O app REPASSA à fiscal-api. O ERP continua dono do conteúdo; o app é portador. Um front-end de terceiro produz os fatos do próprio sistema dele. Os 422 de cadastro incompleto continuam do ERP (nascem no `fiscal-facts`).
2. **Como o usuário do app se autentica na fiscal-api sem carregar o segredo do licenciado?** (Q-F22) → **federação de identidade**: a fiscal-api confia em tokens emitidos pelo backend do LICENCIADO — chave pública/JWKS registrada em `tb_licensee`. O setes-api já emite JWT para o app; passa a emitir também um token curto para a fiscal-api (claims: `licensee`, `emitters` permitidos, escopos, `externalUser`). O setes-api vira **emissor de identidade confiado**, não cliente. Front-end de terceiro com backend próprio faz o mesmo; sistema servidor usa `tb_licensee_app` + `POST /v1/auth/token`.
3. **Como o ERP sabe o que o fisco disse, sem perguntar à fiscal-api e sem acreditar no app?** → **RECIBO ASSINADO**: toda voz que a fiscal-api devolve (A, R, F, C, K, N) vem num JWS assinado pela fiscal-api (chave pública conhecida do setes-api, com rotação) contendo `documentId`, `externalCode`, `emitter`, `kind`, `dh`, chave/número. O app repassa o recibo (`POST /api/<ramo>/:orderId/fiscal-receipt`); o setes-api verifica a assinatura OFFLINE, grava o vínculo e aplica o efeito. **Hearsay morre por construção**: um app não consegue "contar" ao ERP que o fisco cancelou — só portar o recibo. A D-N7 relaxada (Q-F19) vira: *C local SÓ com recibo C verificado*; "nunca cancela no escuro" vira *nota com vínculo e sem recibo conclusivo → 409 `FISCAL_RECEIPT_REQUIRED` ("consulte na fiscal-api e traga o estado")*. Alternativa examinada: verificar a assinatura do PRÓPRIO fisco no XML da NFS-e/evento (ICP-Brasil) — mais pesado e não cobre F/K/R; fica como opção.
4. **E quando não há humano na tela?** (voz C descoberta pelo worker da fiscal-api — cancelada no portal; A tardia depois de K) → **webhook de ENTRADA** no setes-api (`/hooks/fiscal-document/:inst/:token`, molde do Inter — D-I9) carregando o MESMO recibo assinado. Receber webhook não é ser cliente: nenhuma chamada de saída. **O que fica impossível sem chamada de saída: EMISSÃO iniciada pelo servidor** (rotina mensal transmitindo sozinha; `fiscal_auto_transmit` da D-N9 fora de uma tela). Hoje transmitir é ato explícito do usuário — nada se perde hoje; perde-se a opção futura → Q-F28.

### 11.3 A saga no front-end (3 passos) e a recuperação

```
1. app → setes-api   GET  /api/<ramo>/:orderId/fiscal-facts        → fatos + externalCode; nota marcada "declaração solicitada"
2. app → fiscal-api  POST /v1/nfse/documents (token federado)       → 201 A · 422 R · 202 K  — sempre com RECIBO assinado
3. app → setes-api   POST /api/<ramo>/:orderId/fiscal-receipt {jws} → verifica assinatura, grava vínculo (documentId), aplica efeito
```

- App fecha/rede cai entre 2 e 3: a nota fica "declaração solicitada sem recibo"; ao reabrir, o app consulta `GET /v1/nfse/documents?externalCode=` (UNIQUE: acha o documento ou nada — §3.C) e completa o passo 3. Idempotente nos três passos; a fiscal-api nunca cria 2º documento para o mesmo `externalCode`.
- Lote "Transmitir pendentes": o app fatia e repete a saga por item (já faz isso na cobrança mensal — D27); o orçamento de 60 s do servidor e o `runningBatch` morrem por construção.
- Lista com selo fiscal: (i) o app consulta a fiscal-api por lote de `externalCode` (Q-F16 (a)) ou (ii) o ERP mostra o **último recibo verificado** — um espelho LEGÍTIMO, porque nasceu de assinatura, não de cache. Isso reabre a Q-F16 a favor de (ii) "espelho por recibo", que o guardião aceitaria (não é "status sincronizado por cron": é fato assinado portado).
- Cancelar nota: `buildCancelPlan.fiscal` lê vínculo + último recibo; recibo A vigente → o app precisa cancelar na fiscal-api PRIMEIRO e trazer o recibo C; recibo R/F conclusivo → cancela local; sem recibo conclusivo → 409.
- A1 e habilitação: o upload do `.pfx` vai do app DIRETO à fiscal-api — o certificado nunca passa pelo ERP (ganho). Telas Super de licenciado/app/emitente no setes-app consomem a fiscal-api.

### 11.4 O que muda no plano (F2 vira duas frentes; o app MUDA)

| Antes (Rodada 1) | Com o setes-api passivo (Q-F27 (a)) |
|---|---|
| F2 "setes-api consumidor": `@shared/fiscal-client`, 5–7 sessões, **app inalterado** | **F2a — setes-api PASSIVO** (`fiscal-facts`, `fiscal-receipt` com verificação JWS, vínculo + efeito, webhook de entrada, token federado, cerca "zero saída" por grep): 4–6 sessões · **F2b — setes-app CLIENTE** (módulo/datasource `fiscal` apontando para a fiscal-api, token, saga resumível, lote no cliente, DANFSe/XML direto, upload do A1 direto, telas Super de licenciado/app/emitente): 6–9 sessões — **17 arquivos Dart de hoje mudam + novos** |
| F1 shell: token por app | F1 ganha federação (JWKS por licenciado), recibos assinados (chave da fiscal-api + rotação), CORS por licenciado como caminho PRINCIPAL, endpoints de arquivo pensados para browser/mobile: +2–3 sessões |
| `trilha-primeiro-cliente.ts` bate só no setes-api | a trilha vira um FRONT-END: bate nas duas APIs e porta recibos (régua do corte) |
| Total F0–F3: 24–35 sessões | **30–43 sessões ≈ 6–8 semanas** |

### 11.5 Ganhos e custos (sem maquiar)

**Ganhos**: fiscal-api front-end-first de verdade (o PDV/NFC-e autoriza do dispositivo, um salto a menos — relevante para a F5); ERP menor e SEM dependência de saída (fiscal-api fora não derruba faturamento nem baixa); o A1 nunca transita pelo ERP; front-end de terceiro é cidadão de 1ª classe desde o 1º dia; `runningBatch` e o orçamento de lote do servidor morrem.

**Custos**: cada front-end reimplementa a saga de 3 passos (mitigar com receita publicada + SDK Dart/TS); o app muda (não mudava); sem emissão iniciada pelo servidor (Q-F28); o estado do ERP fica ATRÁS do fisco até um recibo chegar (webhook mitiga); mais superfície de segurança (CORS, token no browser, chaves de verificação e rotação); o lote passa a depender da sessão do usuário (fechar a aba = parar — Q-R5.2 já existia).

### 11.6 Leitura do guardião aplicada (sem nova rodada do agente)

O parecer §3 continua inteiro: conteúdo no ERP, formato/conversa na API, API cega ao ERP. O que ele proíbe continua proibido, com outro transporte: C local sem voz → *sem recibo*; estado em cache decisório → *só recibo verificado*; "ERP cancela sem perguntar quando há vínculo" → *sem recibo conclusivo, 409*. Palavra nova a ocupar se decidido: **recibo** (`receipt`) = a voz assinada pela fiscal-api para quem a porta — não colide com "voz" (fato cru do fisco), "registro" (boleto no banco) nem "protocolo" (número do fisco). Nome candidato da tabela do ERP: `tb_invoice_fiscal_receipt` (substitui `tb_invoice_fiscal_document` — o vínculo passa a ser o 1º recibo).

**Recomendação**: Q-F27 (a) — fazer exatamente o que o Valdo pediu, com os três mecanismos (federação, recibo assinado, webhook de entrada) como condição; sem eles, "o app é o cliente" vira "o ERP acredita no app", e isso o guardião chamaria de maquete.
