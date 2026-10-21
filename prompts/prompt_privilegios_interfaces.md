# Tarefa — Privilégios devidos de cada interface (backfill do catálogo + regra "tela nasce com privilégios")

**Escopo**: misto (o método — "privilégio só existe com consumidor: tabela → tela → código", a cerca de completude do catálogo e o
inventário tela a tela pelo que a rota realmente faz — é portável; os ids, telas e decisões são do Gestão 2027)
**Origem**: achado de 2026-10-18 ao conferir a regra (1) da **D-GE19** no dev (§12.5 do `prompt_frente_grupo_estabelecimentos.md`):
31 das 40 interfaces do catálogo central sem privilégio nenhum. Tarefa própria aberta pela sessão da frente do grupo.
**Aberto em**: 2026-10-18. **Estado**: Rodada 0 ORGANIZADA (fatos §2 + inventário §3 + questões §4). **Rodada 1 respondida EM PARTE
(Valdo, 2026-10-18) → D-PV1 (catálogo COMPLETO já — diverge da Rec.), D-PV2, D-PV3/D-PV4 (Super e kind 'R' TAMBÉM têm privilégio — diverge
da Rec.; o super escapa de todas as verificações), D-PV9.** Regra escrita nas duas skills. **Rodada 2 FECHADA (Valdo, 2026-10-18: "siga as
recomendações da Rodada 2") → A-PV1…A-PV4 confirmadas, D-PV5…D-PV8 — NENHUMA questão aberta.** Seed `sql/64_privileges_backfill_seed.sql`
(134 pares) ESCRITO e PROVADO em schema descartável (§9) e **APLICADO em `setes_central` em 2026-10-18 (Valdo: "Vai: aplique o seed 64",
§10) — 157 pares vivos; C1 corrigido no menu do admin**; COMMITADO sem push em 2026-10-18 (sql 3672ee2 = seed 64 + comentário do 06; Infra-IA no commit seguinte, só os trechos desta tarefa).
Entregas próprias em curso (sessões abertas pelo Valdo em 2026-10-18): a cerca da D-PV9 e a onda da D-PV2 (com A-PV1/D-PV5/D-PV6/D-PV8).
**Cerca da D-PV9 ENTREGUE em worktree em 2026-10-18 (§12 — lista única `privilege-catalog.ts` + cerca + teste ao vivo + boot que grita;
C1 provado ao vivo; gates 0,80/0,78; NADA commitado). Rodada 5 (D-PV14…D-PV17) com D-PV15/D-PV16 EXECUTADAS (§12.8; gates do delta
0,76/0,72 → 0,80). Aguardam o Valdo: A-PV12, A-PV14, Q-PV19 (resposta veio repetida) e Q-PV50…Q-PV53. ⏯ Retomar pelo §12.9.**
**Onda da D-PV2 EXECUTADA em worktree em 2026-10-18 (§11 — guarda por roteador + A-PV1 na API e na nfse-api + fábrica do app; worktrees
`privilegios/*`, branch `privilegios-crud`; gates 0,76/0,82 com 2 HIGH anteriores à onda corrigidos por barreiras INTERINAS; NADA
commitado; A-PV5…A-PV11 a ratificar; Q-PV10…Q-PV15 e Q-PV21…Q-PV29 aguardam o Valdo — a Q-PV11 trava a PUBLICAÇÃO).**
**D-PV10/D-PV11 DECIDIDAS e EXECUTADAS na mesma worktree em 2026-10-18 (§11.9 — a Setes é cliente comum, D-PV10 fecha a Q-PV11 = (a);
tela delegável "Interfaces dos clientes"; seed `sql/65` provado, não aplicado; gates do delta 0,74 · adversarial 0,64 → re-prova 0,76;
NADA commitado; D-PV12 fecha a Q-PV37 = (b) — o admin troca a senha de todos menos do super; D-PV13 = Q-PV38 em tarefa própria;
Q-PV30…Q-PV36 + A-PV13 aguardam o Valdo).**
**Q-PV38 / D-PV13 EXECUTADA em worktree em 2026-10-18 (§13 — `D:\Gestao2027\recuperacao-senha\{setes-api,sql}`, branch `recuperacao-senha`;
tabela `tb_user_password_reset` (sql/67, provada em descartável, NÃO aplicada); 5 erradas esgotam o código; resposta neutra em corpo, status
e tempo; achado CRITICAL anterior corrigido — o código ia ao texto da requisição e a colação iguala `gmaíl.com` a `gmail.com`; gates
0,66 → 0,80 · 0,82 · delta 0,85; NADA commitado; numeração própria Q-RS1…Q-RS6 / A-RS1…A-RS4 aguardam o Valdo).**
**Regra dos dois grupos**: setes-sync e sincronizador NÃO foram lidos.
**Transversal (leve)**: o seed é do `setes_central` (catálogo), mas o efeito aparece no setes-app (menu, botões, cadastro de privilégios do
usuário) e na nfse-api (as guardas dela leem `tb_user_has_privilege` do schema do cliente — `nfse-api/src/modules/guards.ts:12`).
**Consultas ao banco**: só leitura, sessão `READ ONLY` (o banco do dev é o de produção).

---

## 1. Regra que esta tarefa cumpre

- **D-GE19** (Valdo, literal): *"temos um cadastro de interface, para cada tela desenvolvido devemos criar um registro com os devidos
  priviegios,, essas interfaces farao parte do contrato com o cliente e os menus que o cliente podera ver e o modulo podera
  reorganiza-los"*.
- **Q-G29** (Valdo, 2026-09-10 — `setes-api/ARQUITETURA_MODULOS_API.md`, seção "Privilégio de AÇÃO"): o privilégio **existe na TABELA**
  (`tb_privilege` + `tb_interface_has_privilege` — seed), **é OPÇÃO na TELA** (o cadastro de privilégios do usuário só oferece o que a
  interface tem) e **o CÓDIGO valida**. Admin e super passam sempre.
- **D-GE20**: o menu é editado por quem tem a tela **Módulos** concedida no cadastro do usuário — pressupõe que `modules` tenha privilégios.

## 2. Fatos (com evidência)

### 2.1 O catálogo e a matriz de hoje (`setes_central`, 2026-10-18)

`tb_privilege`: 1 INSERIR · 2 ALTERAR · 3 EXCLUIR · 4 IMPRIMIR · 5 FATURAR · 6 VISUALIZAR (ids do desktop, `sql/06`) · 7 CANCELAR
(`sql/51`) · 8 DESCONTO (`sql/55`) · 9 TRANSMITIR (`sql/59`).

`tb_interface_has_privilege`: **23 linhas, todas vivas** (nenhuma `deleted='S'` nem inativa). Só 9 interfaces têm alguma:

| Interface | Privilégios hoje | De onde vieram |
|---|---|---|
| 1 institutions | 1, 6 | tela Interfaces do Super (`sql/06` linha 9) |
| 4 countries · 6 cities · 19 bank-accounts | 1, 2, 3, 6 | idem |
| 20 service-orders · 29 orders | 5, 7, 9 | seeds 51/52/53/59 (só AÇÃO) |
| 21 settlements | 8 | seed 55 (só AÇÃO) |
| 31 order-returns | 5 | seed 54 (só AÇÃO) |
| 39 bank-charge-agreements | 8 | seed 55 (só AÇÃO) |

### 2.2 Quem CONSOME cada privilégio (o que de fato muda alguma coisa)

| Privilégio | Consumidor | Evidência |
|---|---|---|
| VISUALIZAR (6) | **menu do usuário regular**: só entra a tela com VISUALIZAR concedido | `setes-api/src/modules/core/core.repository.ts:143` e `:178` |
| FATURAR (5) | rota (`requirePrivilegeFor`/`requirePrivilege`) + botão no app | `billing.routes.ts:116`, `service-orders.routes.ts:362/:411`; `order_page.dart:841`, `order_return_page.dart:560`, `service_order_page.dart:269/:556/:1237` |
| CANCELAR (7) | rota + botão | `billing.routes.ts:156/:192/:231`; `order_page.dart:863`, `service_order_page.dart:1177`, `service_order_fiscal_section.dart:150` |
| DESCONTO (8) | política no controller + campo no app | D-G32/D-G36; `settlement_page.dart:963` |
| TRANSMITIR (9) | guarda da nfse-api + botão | `nfse-api/src/modules/guards.ts:12`; `service_order_page.dart:284`, `service_order_fiscal_section.dart:250/:259` |
| ALTERAR (2) | **só** "trocar a cobrança" do título (D17/D21) | `settlements.routes.ts:326`; `settlement_page.dart:343` |
| INSERIR (1) · EXCLUIR (3) · IMPRIMIR (4) | **NENHUM** — nem rota, nem botão (a fábrica `RegisterSearchPage`/`RegisterFormPage` não consulta privilégio; `canDelete` é `!creating`) | grep em `setes-app/apps/web/lib` e `setes-api/src` |

Outros fatos do consumo:
- **Botões do admin e do super = o CATÁLOGO da interface** (`core.service.ts:149–166`: admin recebe `getAllInterfacePrivileges()`); o app
  pergunta `CurrentInterface.can('X')` sobre essa lista (`app/shared/session/current_interface.dart`, setada em
  `home/interface_routes.dart:93`). ⇒ **privilégio que falta no catálogo esconde o botão até do admin.**
- O cadastro de privilégios do usuário lista **interfaces contratadas × catálogo** (`users.repository.ts:256`) e o salvar recusa o que está
  fora do catálogo (`users.service.ts:207–212`).
- **A API não confere VISUALIZAR**: acesso à tela é UX do menu (decisão 21 da Fase 1). Rotas só têm `superGuard`/`adminGuard` por roteador
  (`gateway/router.ts:61–87`) e as guardas de AÇÃO. `PUT /api/interface-fields/:id/:fieldName` não confere admin
  (`interface-fields.service.ts:59`), enquanto `interface-configs` restringe o valor da institution ao admin (`interface-configs.service.ts:99`).
- Menu do cliente nunca mostra o grupo Super (`NOT_SUPER_GROUP`, `core.repository.ts:116`) nem interface kind 'R' (`ONLY_SCREEN_KIND`, `:121`).
- **Legado** (Gestao2016): cada tela tinha VISUALIZAR, INSERIR, ALTERAR, EXCLUIR, AUTORIZAR, NEGOCIAR, ligando/desligando BOTÕES
  (`Pc_PermissaoBotao` — `D:\Gestao2016\Infra-IA\Gestao\02-enriquecimento\Baixa-LoteR1-receber.md:21`; `Gb_Nivel=1` = tudo).

### 2.3 Defeitos objetivos achados (corrigir ≠ decidir)

- **C1 — "Trocar a cobrança" está escondido para TODO MUNDO desde a D21 (2026-09-13).** A rota exige ALTERAR em `settlements` e o app
  mostra o botão só com `can('ALTERAR')`, mas `settlements` não tem ALTERAR no catálogo ⇒ admin e super não recebem ALTERAR no menu ⇒ o
  ícone ⇄ da linha do título nunca aparece (só via deep link, onde `CurrentInterface` é nulo e libera). A API aceitaria o admin. Correção =
  o par (`settlements`, 2) no seed.
- **C2 — Cinco telas têm só privilégio de AÇÃO, sem VISUALIZAR**: `orders`, `service-orders`, `settlements`, `order-returns`,
  `bank-charge-agreements` ⇒ um usuário regular pode receber FATURAR/CANCELAR/DESCONTO mas **nunca vê a tela no menu**. Somado às 31 sem
  nada: **das 29 telas de cliente (kind 'T', fora do grupo Super), só `bank-accounts` pode aparecer no menu de um usuário regular.**

### 2.4 Impacto em produção hoje (só leitura)

- **Não existe usuário regular**: a única institution ativa (1 — `setes_setes`) tem 2 admin + 1 super. `tb_user_has_privilege` tem 1 linha
  (bank-charge-agreements × DESCONTO). ⇒ o backfill **não muda o acesso de ninguém hoje** e nenhum usuário perde nada se, depois, o código
  passar a exigir INSERIR/ALTERAR/EXCLUIR.
- **Contrato da Setes** (`setes_setes.tb_institution_has_interface`): 14 interfaces — 20, 21, 27, 29, 30, 31, 32, 33, 34, 36, 37, 38, 39,
  40. **Não estão contratadas**: os cadastros de entidade (customers, collaborators, salesmen, carriers, providers), categories,
  financial-plans, payment-types, contracts, bank-accounts, users, modules, interface-fields, interface-configs, general-configs (e as do
  Super). Pela parte (2) da D-GE19 e pela D-F37, tela não contratada não aparece no menu de NINGUÉM, nem do admin — só o super vê tudo.
  Não é desta tarefa (é contrato/implantação), mas a D-GE20 depende dela: **a Módulos (26) não está no contrato da Setes**.

## 3. Inventário tela a tela

Legenda do tipo: **CAD** lista + formulário (fábrica) · **ÁRV** cadastro em árvore · **PROC** tela de processo · **SESS** sessão/status ·
**PAINEL** painel de configuração · **ADM** só admin hoje (`adminGuard`) · **SUP** grupo Super (`superGuard`, fora do menu do cliente) ·
**R** recurso/aba (kind 'R', fora do menu).
Coluna "Devido (proposta)": o que a tela realmente FAZ, mapeado no catálogo existente (V = 6 VISUALIZAR, I = 1, A = 2, E = 3, P = 4
IMPRIMIR). Coluna "Entra já" = o que entra no seed SE a Q-PV1 for (a).

| id | i18n_key | grupo | tipo | O que a tela faz (rotas) | Hoje | Devido (proposta) | Entra já (Q-PV1 a) |
|---|---|---|---|---|---|---|---|
| 1 | institutions | Super | SUP | CRUD + chave do sync | 1,6 | — (Q-PV3) | — |
| 2 | privileges | Super | SUP | CRUD | — | — (Q-PV3) | — |
| 3 | interfaces | Super | SUP | CRUD + catálogo de configs/privilégios | — | — (Q-PV3) | — |
| 4 | countries | Super | SUP | CRUD | 1,2,3,6 | — (Q-PV3) | — |
| 5 | states | Super | SUP | CRUD | — | — (Q-PV3) | — |
| 6 | cities | Super | SUP | CRUD | 1,2,3,6 | — (Q-PV3) | — |
| 7 | interface-fields | Sistema | PAINEL | GET + PUT do campo (sem incluir/excluir) | — | V, A (Q-PV5) | V |
| 8 | users | Sistema | ADM | CRUD + vínculos + privilégios do usuário | — | — (Q-PV5) | — |
| 9 | customers | Cadastros | CAD | CRUD (+ aba parceria = 18) | — | V, I, A, E | V |
| 10 | interface-configs | Sistema | PAINEL | GET + PUT do valor (institution só admin; override U pessoal) | — | V, A | V |
| 11 | general-configs | Sistema | PAINEL | abre o painel 10 filtrado (sem módulo próprio) | — | V, A | V |
| 12 | collaborators | Cadastros | CAD | CRUD | — | V, I, A, E | V |
| 13 | categories | Cadastros | ÁRV | CRUD | — | V, I, A, E | V |
| 14 | financial-plans | Cadastros | ÁRV | CRUD | — | V, I, A, E | V |
| 15 | cfop | Super | SUP | CRUD | — | — (Q-PV3) | — |
| 16 | payment-types | Financeiro | CAD | vincular / alterar / desvincular forma | — | V, I, A, E | V |
| 17 | contracts | Cadastros | CAD | CRUD do contrato de mensalidade | — | V, I, A, E | V |
| 18 | partnerships | Cadastros | R | aba de Clientes (`GET/PUT /customers/:id/partnership`) | — | — (Q-PV4) | — |
| 19 | bank-accounts | Financeiro | CAD | CRUD + canal API (segredos, token, webhook, teste) | 1,2,3,6 | já completo (canal = A) | — |
| 20 | service-orders | Serviços | PROC | criar, itens, excluir, rotina mensal, faturar, lote, transmitir, cancelar | 5,7,9 | + V, I, A, E (rotina/excluir = Q-PV8 ↔ Q-R5.5) | V |
| 21 | settlements | Financeiro | PROC | baixar, estornar, extrato, trocar cobrança, desconto | 8 | + V, A; baixa/estorno = Q-PV7 | V, **A (C1)** |
| 22 | salesmen | Cadastros | CAD | CRUD (promoção de colaborador) | — | V, I, A, E | V |
| 23 | carriers | Cadastros | CAD | CRUD | — | V, I, A, E | V |
| 24 | providers | Cadastros | CAD | CRUD | — | V, I, A, E | V |
| 25 | banks | Super | SUP | CRUD | — | — (Q-PV3) | — |
| 26 | modules | Sistema | ADM → privilégio (D-GE20) | CRUD do módulo de menu + vínculo ordenável | — | V, I, A, E (Q-PV5) | — (entra com a onda 0) |
| 27 | tax-rules | Cadastros | CAD | CRUD | — | V, I, A, E | V |
| 28 | billing | — | R | configs + ações FATURAR/CANCELAR resolvidas pelo RAMO | — | — (Q-PV4) | — |
| 29 | orders | Vendas | PROC | criar, itens, negociação, excluir aberto, faturar, cancelar, transmitir | 5,7,9 | + V, I, A, E | V |
| 30 | cashier | Financeiro | SESS | abrir, sangria, fechar | — | V + atos = Q-PV7 | V |
| 31 | order-returns | Vendas | PROC | abrir, itens, excluir, faturar (cancelar = Onda 2) | 5 | + V, I, A, E | V |
| 32 | establishment | Sistema | ADM | formulário único (GET/PUT) | — | — (Q-PV5) | — |
| 33 | price-lists | Cadastros | CAD | CRUD | — | V, I, A, E | V |
| 34 | services | Cadastros | CAD | CRUD | — | V, I, A, E | V |
| 35 | service-list | Super | SUP | CRUD (LC 116 central) | — | — (Q-PV3) | — |
| 36 | service-tax-rules | Cadastros | CAD | CRUD | — | V, I, A, E | V |
| 37 | settlement-rules | Financeiro | CAD | CRUD | — | V, I, A, E | V |
| 38 | bank-slips | Financeiro | PROC | emitir, liquidar, cancelar, estornar, registrar/consultar no banco, PDF, reaplicar efeito | — | V + atos = Q-PV7 | V |
| 39 | bank-charge-agreements | Financeiro | CAD | CRUD da carteira | 8 | + V, I, A, E | V |
| 40 | checks | Financeiro | PROC | depositar, descontar, devolver, usar em pagamento, estornar | — | V + atos = Q-PV7 | V |

Contagem se Q-PV1 = (a): **26 pares novos** (25 VISUALIZAR + ALTERAR em settlements). Se Q-PV1 = (b): a coluna "Devido" inteira.
⚠️ A coluna "Entra já" ficou SUPERADA pela D-PV1 (catálogo completo) e pela D-PV3/D-PV4 — o conjunto do seed é o §3.1.

### 3.1 Conjunto do seed 64 (D-PV1 + D-PV3 + D-PV4 + D-PV7, A-PV2…A-PV4 confirmadas — Rodada 2 FECHADA)

| Bloco | Interfaces | Pares novos | Situação |
|---|---|---|---|
| Super (D-PV3 + A-PV3) | privileges, interfaces, states, cfop, banks, service-list → 1,2,3,6 · institutions → +2,3 (já tem 1,6; emitir a chave do sync = A) · countries, cities já completos | 26 | decidido |
| kind 'R' (D-PV4 + A-PV2) | partnerships → 2,6 (a aba lê e grava) · billing → 2,6 (o conteúdo dela são as CONFIGS; FATURAR/CANCELAR/TRANSMITIR seguem na tela do RAMO — Q-G22) | 4 | decidido (A-PV2 confirmada) |
| Cadastros (D-PV1) | customers, collaborators, categories, financial-plans, payment-types, contracts, salesmen, carriers, providers, tax-rules, price-lists, services, service-tax-rules, settlement-rules → 1,2,3,6 · bank-charge-agreements → +1,2,3,6 | 60 | decidido |
| Painéis (D-PV1) | interface-fields, interface-configs, general-configs → 2,6 (não incluem nem excluem) | 6 | decidido |
| Telas do perfil admin (A-PV4) | users, modules → 1,2,3,6 · establishment → 2,6 (formulário único) | 10 | decidido (A-PV4 confirmada) |
| Processo — parte CRUD (D-PV1) | service-orders, orders, order-returns → +1,2,3,6 · settlements → +2,6 · cashier, bank-slips, checks → 6 | 17 | decidido |
| Processo — atos (D-PV7) | settlements +1,3 · bank-slips +1,2,4,7,9 · checks +2,7 · cashier +1,2 (pelo mapa recomendado) | 11 | decidido (D-PV7) |
| **Total** | | **123 + 11 = 134** | |

A Q-PV8 não acrescenta par: service-orders já fica com 1,2,3,5,6,7,9 — ela só decide QUAL privilégio a rota mensal e o DELETE vão exigir
(efeito na onda da D-PV2).

## 4. Questões — Rodada 1 (respondida em parte pelo Valdo, 2026-10-18 — o status de cada uma vem logo abaixo dela)

- **Q-PV1 — Quais privilégios entram no catálogo AGORA**, sabendo que INSERIR/ALTERAR/EXCLUIR/IMPRIMIR não têm consumidor (§2.2)?
  (a) **VISUALIZAR em toda tela de cliente + os de AÇÃO que o código já valida** (inclui ALTERAR em settlements — C1); INSERIR/ALTERAR/
  EXCLUIR/IMPRIMIR entram tela a tela NA ENTREGA que fizer o código validá-los (Q-PV2) — nenhuma opção na tela do usuário "mente";
  (b) o conjunto "Devido" completo já, sem consumidor — o cadastro do usuário mostra INSERIR/EXCLUIR que não mudam nada até a Q-PV2;
  (c) só VISUALIZAR (C1 em tarefa à parte). **Rec.: (a)** — é a Q-G29 ao pé da letra (tabela → tela → código) e não esconde nada (o
  "Devido" fica registrado no §3 para a onda da Q-PV2).
  **→ D-PV1 = (b), DIVERGIU da Rec.** (Valdo: *"mantenha tudo, ainda vamos usar"*).
- **Q-PV2 — Abrir a onda que torna INSERIR/ALTERAR/EXCLUIR (e VISUALIZAR) efetivos?** (a) **sim, tarefa própria, com UM ponto de consumo de
  cada lado**: app — a fábrica (`RegisterSearchPage` "novo" ← INSERIR; `RegisterFormPage` salvar ← INSERIR/ALTERAR, excluir ← EXCLUIR, por
  `CurrentInterface.can`) + as telas de processo uma a uma; API — guarda POR ROTEADOR do módulo (GET → VISUALIZAR, POST → INSERIR, PUT →
  ALTERAR, DELETE → EXCLUIR) com o `requirePrivilege` que já existe, possível porque o módulo do app só fala com o seu `/api/<m>`; exceções
  nomeadas: `/api/core`, `/api/entities`, `/api/billing/*`, e as leituras de motor `GET /interface-fields/key/:k` e
  `GET /interface-configs/key/:k` (toda tela as consome); o seed do CRUD da tela entra na MESMA entrega e ANTES do app (senão o admin perde
  o botão — é o C1); (b) só o app (UX, como o legado `Pc_PermissaoBotao`), sem guarda na API; (c) não — CRUD fica fora; só VISUALIZAR e
  ações. **Rec.: (a)** — hoje não há usuário regular (§2.4), então ligar a guarda não tira acesso de ninguém; é o momento mais barato.
  **→ D-PV2 = (a)** (Valdo: *"ok"*).
- **Q-PV3 — Telas do grupo Super** (privileges, interfaces, states, cfop, banks, service-list; e institutions/countries/cities, que já têm
  1,6 / 1,2,3,6): (a) **sem privilégios** — o super passa por `isSuper()`, essas telas nunca vão ao menu do cliente (`NOT_SUPER_GROUP`) e a
  API é `superGuard`; a exceção fica escrita na regra das skills; os vínculos já existentes ficam como estão (inofensivos — nada é apagado);
  (b) o mesmo CRUD de countries/cities em todas, por simetria (decorativo); (c) (a) + desativar os vínculos já existentes.
  **Rec.: (a)** — a D-GE19 fala da tela que entra no CONTRATO com o cliente; tela do Super não é vendida.
  **→ D-PV3 = (b), DIVERGIU da Rec.** (Valdo, sobre Q-PV3/Q-PV4: *"ficam com privilegio e o super deve escapar de todas as
  verificacoes"*) — quais privilégios: A-PV3; o que "todas" cobre: A-PV1 (§4.2).
- **Q-PV4 — Interfaces kind 'R'** (`billing`, `partnerships`): (a) **sem privilégios** — 'R' nunca vai ao menu; as ações do faturamento
  vivem na tela do RAMO (Q-G22: orders / service-orders / order-returns); a aba de parceria segue os privilégios de Clientes (ALTERAR de
  `customers` quando a Q-PV2 chegar); (b) VISUALIZAR em `partnerships` para mostrar/esconder a aba por usuário. **Rec.: (a)** — recurso
  'R' é vendável pelo CONTRATO, não por usuário; (b) criaria uma 2ª chave para a mesma aba.
  **→ D-PV4 = privilégio também nas 'R', DIVERGIU da Rec.** (mesma resposta da D-PV3) — quais: A-PV2 (§4.2).
- **Q-PV5 — Telas que hoje são do PERFIL admin** (`users`, `establishment`, `modules` — `adminGuard`) **e o painel `interface-fields`**:
  dar VISUALIZAR a um regular mostra o item no menu e a API responde 403. (a) **`users` e `establishment` seguem só do admin, SEM
  privilégio** (o perfil decide: quem tem Usuários concede privilégio a si mesmo — escalada; Meu Estabelecimento guarda regime e
  configuração fiscal — D41 "só Admin"); **`modules` ganha V, I, A, E na entrega da onda 0** (D-GE20, junto da troca da guarda e da D-GE3),
  não neste backfill; **`interface-fields` ganha V agora** (é painel do cliente que só APERTA o baseline, sem escalada); (b) as três ganham
  V agora (uniforme), aceitando menu + 403 até as guardas mudarem; (c) o princípio da D-GE20 ("o privilégio decide, não o perfil") vale
  para TODAS as telas de Sistema — `users` e `establishment` também trocam `adminGuard` por privilégio (tarefa própria). **Rec.: (a)**.
  Ligada à **A-GE2** (frente do grupo, §12.5): se até o admin precisar da Módulos marcada, o admin passa a precisar de linha em
  `tb_user_has_privilege` — decidir as duas juntas. → **A-GE2 RESOLVIDA 2026-10-18 (Valdo): o admin passa como sempre; só o não admin
  precisa da Módulos concedida** — a `modules` segue a regra geral; nenhuma linha de privilégio para o admin.
  **→ sem resposta; revista na Rodada 2 (A-PV4 + Q-PV5', §4.2)** — com a D-PV1/D-PV3 o catálogo entra; resta a GUARDA.
- **Q-PV6 — `interface-fields` salva sem conferir admin** (`interface-fields.service.ts:59`) — qualquer usuário autenticado da institution
  aperta campo obrigatório de todo o estabelecimento chamando a API (o backfill só o põe no menu). (a) **fica como está até a Q-PV2**: a
  guarda por roteador (PUT → ALTERAR) passa a decidir; (b) já exigir admin no salvar, como o valor da institution do `interface-configs`;
  (c) aceitar como limite conhecido. **Rec.: (a)** — com a Q-PV2 (a) o privilégio decide; sem ela, (b).
  **→ sem resposta; segue na Rodada 2 (§4.2).**
- **Q-PV7 — Atos das telas de PROCESSO sem privilégio no catálogo** (§3, "atos = Q-PV7"): mapear no catálogo EXISTENTE, sem privilégio
  novo? Proposta: **settlements** baixa = I · estorno = E · trocar cobrança = A (já) · desconto = 8 (já); **bank-slips** emitir = I ·
  liquidar manual = A · cancelar e estornar = 7 CANCELAR · registrar no banco = 9 TRANSMITIR (o "TRANSMITIR" do banco, simétrico ao do
  fisco) · PDF = 4 IMPRIMIR; **checks** depositar/descontar/devolver/usar em pagamento = A · estornar = 7; **cashier** abrir = I · sangria e
  fechar = A; **orders/order-returns** excluir o aberto = E. (a) **esse mapa, efetivo só com a onda da Q-PV2** (antes disso não entra no
  seed — Q-PV1 (a)); (b) privilégios NOVOS por ato (ESTORNAR, ABRIR CAIXA, REGISTRAR…), como o legado tinha AUTORIZAR/NEGOCIAR — exige o
  guardião e o legado ato a ato; (c) telas de processo ficam só com V + as ações que já existem. **Rec.: (a)** — reaproveita o catálogo;
  privilégio novo só quando um ato precisar de autoridade DIFERENTE (como DESCONTO precisou).
  **→ sem resposta; segue na Rodada 2 (§4.2) — com a D-PV1 o mapa entra no seed JÁ (não espera a onda).**
- **Q-PV8 — Rotina mensal e excluir OS** = a **Q-R5.5** ainda aberta (`prompt_primeiro_cliente_setes.md` §11, Rec. lá: rotina sob FATURAR
  (5), DELETE da OS sob CANCELAR (7), sem privilégio novo). Decidir aqui fecha as duas: (a) **a Rec. da Q-R5.5**; (b) rotina sob INSERIR e
  DELETE sob EXCLUIR (pelo mapa da Q-PV7); (c) privilégio novo COBRANCA. **Rec.: (a)** — a rotina CUNHA notas (é faturar) e apagar a OS
  devolve competência (é desfazer).
  **→ Valdo pediu explicação da Q-R5.5. ⚠️ A justificativa acima estava ERRADA**: a rotina mensal NÃO cunha nota — ela abre/reusa a OS
  de cada cliente e injeta os itens do contrato da competência; quem cunha é o "Faturar em lote", que já exige FATURAR. Revista como
  Q-PV8' na Rodada 2 (§4.2).
- **Q-PV9 — Cerca para o C1 não voltar** (catálogo incompleto esconde botão até do admin): (a) **lista única dos pares (interface,
  privilégio) que o código consome** — `@shared/auth/privilege-catalog.ts` no setes-api, onde toda `requirePrivilege`/`requirePrivilegeFor`
  e todo `CurrentInterface.can('X')` do app têm de constar (teste jest por varredura dos `*.routes.ts` e dos `.dart`, no molde das cercas
  `voice-kind-fence`/`federal-id-fence`) + **o boot confere a lista contra `tb_interface_has_privilege` e grita (alarme no log, sem
  recusar subir)**, no molde do "boot confere os 9 gatilhos"; (b) só a regra escrita nas skills; (c) o boot RECUSA subir com par faltando.
  **Rec.: (a)** — o defeito C1 passou por todos os gates da D21 porque nada ligava rota/botão ao seed.
  **→ D-PV9 = (a)** (Valdo: *"ok"*).

### 4.2 Rodada 2 — assunções a confirmar e questões que seguem (FECHADA 2026-10-18 pelas recomendações — ver "Decisões")

O que o super JÁ escapa hoje (conferido no código): todo privilégio (`isAdmin` inclui o super — `require-privilege.ts`, política do
desconto, configs da institution; na nfse-api, `guards.ts:18`), o menu (vê o catálogo central inteiro — `getAllCentralInterfaces`) e os
roteadores do Super (`superGuard`). **Não escapa da LICENÇA**: ação em tela NÃO contratada responde 403 `INTERFACE_NOT_ALLOWED` também para
ele (D-F37 — `require-privilege.ts` e `nfse-api/src/modules/guards.ts:15`). O super só existe na institution da Setes (`isSuper` exige a
institution 1).

- **A-PV1 — "o super deve escapar de todas as verificações" inclui a LICENÇA?** (a) **sim — o super passa também a tela não contratada**:
  revê a D-F37 SÓ para o super (setes-api `requirePrivilege`/`requirePrivilegeFor`/`requireInterfaceFor` + nfse-api `requireBranchPrivilege`/
  `passScope`); entra no código na onda da D-PV2 (caminho fiscal = com os gates); elimina a incoerência de hoje (o menu do super mostra a tela,
  o botão dela responde 403); (b) não — "todas" = as de privilégio; a licença segue valendo para todos como a D-F37 decidiu. **Rec.: (a)** —
  é o que a frase diz, e o super só opera dentro da própria Setes, onde não há venda a proteger.
- **A-PV2 — Privilégios das 'R'** (D-PV4): `partnerships` = VISUALIZAR + ALTERAR (a aba lê e grava); `billing` = VISUALIZAR + ALTERAR (o
  conteúdo dela são as configs — `auto_bank_slip`, `sn_credit_aliq`, configs fiscais); FATURAR/CANCELAR/TRANSMITIR **seguem na tela do
  RAMO** (Q-G22), nunca em `billing` (seria uma 2ª chave para o mesmo ato). Confirmar.
- **A-PV3 — Privilégios das telas do Super** (D-PV3): VISUALIZAR, INSERIR, ALTERAR, EXCLUIR em todas (são CRUD); em `institutions`
  emitir a chave do sync = ALTERAR. Elas nunca vão ao menu do cliente (`NOT_SUPER_GROUP`) e o super escapa — o catálogo serve aos botões do
  super e ao dia em que a tela for vendida/delegada. Confirmar.
- **A-PV4 — Telas do perfil admin** (`users`, `modules`, `establishment`) entram no catálogo AGORA como qualquer tela (D-PV1/D-PV3):
  users e modules = V, I, A, E; establishment = V, A (formulário único). A guarda é a Q-PV5'. Confirmar.
- **Q-PV5' — A GUARDA de `users` e `establishment` na onda da D-PV2** (a `modules` já está decidida — D-GE20): (a) **seguem do perfil
  admin** (`adminGuard`): quem tem a tela Usuários concede privilégio a si mesmo (escalada) e Meu Estabelecimento guarda regime e configuração
  fiscal (D41); na onda da D-PV2 o cadastro de privilégios NÃO oferece essas duas a usuário regular (o catálogo fica para os botões do
  admin/super); (b) o princípio da D-GE20 vale para elas também (privilégio decide) — exige uma regra contra a escalada (ninguém concede o que
  não tem nem mexe nos próprios privilégios); (c) decidir só quando a onda da D-PV2 abrir. **Rec.: (a)**.
- **Q-PV6** — segue como está no §4 (interface-fields salva sem conferir admin). **Rec.: (a)** — com a D-PV2 decidida, a guarda por
  roteador (PUT → ALTERAR) passa a decidir.
- **Q-PV7** — segue como está no §4 (mapa dos atos das telas de processo), agora com efeito IMEDIATO no seed (D-PV1): são os 11 pares do
  §3.1. **Rec.: (a)**. **É a única que trava o seed.**
- **Q-PV8' — rotina mensal e excluir OS (= Q-R5.5)**, com os fatos certos: `POST /api/service-orders/monthly-run` ("Rotina de
  faturamento mensal") percorre TODOS os clientes com contrato vigente na competência e, por cliente, reusa a OS aberta (ou abre uma) e
  injeta os itens do contrato (pró-rata, idempotente pela competência) — **não fatura**; quem cunha as notas é o "Faturar em lote"
  (`POST /batch-invoice`), que já exige FATURAR. `DELETE /api/service-orders/:id` cancela a OS **ABERTA** (soft delete; libera a trava
  "uma aberta por cliente" e devolve a competência para a rotina reinjetar) — a OS faturada não sai por aqui (a NOTA cancela pelo
  `/billing/cancel`, que exige CANCELAR). Hoje as duas rotas não pedem privilégio nenhum. (a) **rotina = FATURAR** (ato em massa da cobrança
  do mês, feito por quem fatura o lote em seguida) **+ excluir OS = EXCLUIR** (apaga registro aberto; CANCELAR fica só para cancelar NOTA);
  (b) a Rec. original da Q-R5.5: rotina = FATURAR + excluir OS = CANCELAR; (c) rotina = INSERIR + excluir = EXCLUIR (pelo CRUD — mas quem
  abre UMA OS manual passaria a rodar o mês de TODOS os clientes). **Rec.: (a)** — cada verbo com um sentido só (FATURAR = cobrança/nota,
  CANCELAR = nota, EXCLUIR = registro aberto). Efeito só na onda da D-PV2; fecha a Q-R5.5 do `prompt_primeiro_cliente_setes.md`.

## 5. Entregáveis — só depois do "siga as recomendações" (ou da decisão) E do "vai"

1. ✅ **ESCRITO 2026-10-18: `sql/64_privileges_backfill_seed.sql`** (desenho original abaixo; o arquivo usa uma tabela TEMPORÁRIA com a
   lista dos 157 pares do estado final, collation explícita `utf8mb4_general_ci` = a do `i18n_key`, e a conferência 3 falha alto por
   `PREPARE` de um `SELECT` numa tabela inexistente — portável MySQL/MariaDB, sem `SIGNAL` fora de rotina). **Seed `sql/NN_privileges_backfill_seed.sql`** (NN = próximo número livre no momento — hoje 64; conferir antes, há sessões paralelas):
   `INSERT IGNORE … SELECT` por **`i18n_key`** (nunca id fixo de interface — lição do seed 40v1), no molde dos seeds 51–59, a partir de uma
   lista de pares `(i18n_key, privilégio)`:
   ```sql
   INSERT IGNORE INTO `tb_interface_has_privilege`
     (`tb_interface_id`, `tb_privilege_id`, `active`, `created_at`, `updated_at`, `deleted`)
   SELECT i.`id`, p.`id`, 'S', NOW(), NOW(), 'N'
     FROM (SELECT 'customers' AS k, 6 AS pid UNION ALL SELECT 'settlements', 2 UNION ALL …) d
     JOIN `tb_interface` i ON i.`i18n_key` = d.k AND i.`deleted` = 'N'
     JOIN `tb_privilege` p ON p.`id` = d.pid AND p.`deleted` = 'N';
   ```
   + **conferência no fim do script** (SELECT dos pares esperados que FALTAM = 0 linhas; pares que existem com `deleted='S'` são
   LISTADOS e não revividos — a remoção feita pelo Super na tela Interfaces é respeitada, como no `INSERT IGNORE` dos seeds 51–59).
   O `INSERT IGNORE` silencioso do 40v1 é a razão da conferência.
2. ✅ **PROVADO 2026-10-18 (§9)**: rodar o seed num schema descartável (cópia de `tb_interface`, `tb_privilege` e `tb_interface_has_privilege`
   do `setes_central`), conferir a contagem esperada (§3), rodar de novo (idempotência = 0 linhas novas), apagar o descartável. Só então,
   com o "vai", em `setes_central` — **PENDENTE o "vai"**.
3. **Regra nas skills** — ✅ ESCRITA em 2026-10-18 (D-PV1/D-PV3/D-PV4/D-PV9): `setes-api/skills/novo-modulo.md` (seção "Interface e
   privilégios") e `setes-app/skills/criar-formulario-cadastro.md` (item 6, que antes prometia um `can('insert'|'update'|'delete')` que o
   código nunca teve), citada em `setes-api/ARQUITETURA_MODULOS_API.md`. Toda tela — inclusive Super e kind 'R' — nasce com interface +
   VISUALIZAR + o CRUD do que ela faz + as ações; seed por `i18n_key` ANTES do app; o super escapa de todas as verificações.
4. D-PV9: a lista + a cerca + a conferência no boot (setes-api, worktree — a árvore viva roda `tsx watch` = deploy ao salvar) — entrega
   própria, junto ou antes da onda da D-PV2.
5. Registro: decisões D-PVn neste prompt, linha no INDICE_CENTRAL, ponteiro no §12.5 da frente do grupo, memória.

## 6. Fora de escopo

- Contratar telas na Setes (§2.4) — implantação, decisão comercial do Valdo.
- A onda da D-PV2 em si (guardas por roteador, gates na fábrica, A-PV1 nas guardas do setes-api e da nfse-api, D-PV5/D-PV6/D-PV8) —
  tarefa própria (decidida).
- Privilégio POR estabelecimento (D-GE3) e a troca da guarda do `/api/modules` (D-GE20) — onda 0 da frente do grupo.
- Q-R5.6 (JWT de usuário soft-deletado) e as demais Q-R5.x.

## 7. Critérios de sucesso

1. As 40 interfaces têm o conjunto do §3.1 no catálogo (D-PV1/D-PV3/D-PV4); um usuário regular pode receber VISUALIZAR de qualquer tela
   de cliente e ela aparece no menu dele (se contratada).
2. O ícone "trocar cobrança" aparece para o admin na tela de Baixas (C1).
3. A conferência do seed devolve 0 pares faltando; rodar duas vezes não cria linha.
4. A regra "tela nasce com interface + privilégios" está nas duas skills ✅; tela nova sem os pares que o código consome falha a cerca
   (D-PV9 — entrega própria).

## 8. Retomada (prompt curto)

> ⏯ **Cerca da D-PV9 (lista única, guarda das telas do Super, publicação que para): retomar pelo §12.9.** Este §8 é a retomada do
> seed 64, já aplicado.

> ✅ **Seed 64 APLICADO em 2026-10-18 (§10).** Resta: ver o ícone ⇄ na tela de Baixas quando a API e o app estiverem no ar, e o push
> (só com o "vai"). Commits feitos sem push: sql 3672ee2 + Infra-IA. O roteiro abaixo fica como registro do que foi feito.
> Todas as questões FECHADAS (D-PV1…D-PV9 + A-PV1…A-PV4). O seed `sql/64_privileges_backfill_seed.sql` está escrito e provado (§9).
> **Com o "vai"**: (1) conferir que ninguém mexeu no catálogo desde a prova (`SELECT COUNT(*) FROM setes_central.tb_interface_has_privilege`
> = 23, ou rever a lista); (2) `cd D:\Gestao2027\setes-api && npx tsx scripts/apply-seed.ts 64_privileges_backfill_seed.sql` (sai
> `[apply-seed] OK`; qualquer FALHA com `SEED64_FALHOU…` = par esperado ausente — parar e olhar); (3) conferir 157 pares e o ícone "trocar
> cobrança" de volta na tela de Baixas para o admin (C1 — recarregar o app para o menu trazer o catálogo novo); (4) commit do repo `sql`
> (64 + comentário do 06) e da Infra-IA só com o "vai" de commit. Depois: a onda da D-PV2 (guardas por roteador + gates na fábrica + A-PV1
> + D-PV5/D-PV6/D-PV8) e a cerca da D-PV9 — entregas próprias, em worktree. Não ler setes-sync/sincronizador.

## 9. Prova do seed 64 em schema descartável (2026-10-18)

Script de prova (fora do repositório, scratchpad da sessão): conexão do `.env` do setes-api, `multipleStatements` como o `apply-seed.ts`;
schema `prova_seed64_descartavel` com `CREATE TABLE … LIKE` + cópia das 3 tabelas do `setes_central`; o seed rodado com o `USE` trocado.

| Passo | Resultado |
|---|---|
| `setes_central` antes | 23 pares |
| 1ª execução | OK — 23 → **157** pares; conferências 1 e 2 vazias (nenhum par morto, nenhuma interface sem privilégio) |
| Estado final | as 40 interfaces com o conjunto do §3.1, conferido linha a linha (ex.: settlements 1,2,3,6,8 · bank-slips 1,2,4,6,7,9 · checks 2,6,7 · cashier 1,2,6) |
| Novos × `setes_central` | **134** pares novos (= §3.1) |
| 2ª execução (idempotência) | OK — continua 157 |
| Par removido pelo Super (countries × EXCLUIR com `deleted='S'`) + 3ª execução | OK — NÃO revive (`deleted` segue 'S'); a conferência 1 o lista |
| Variante com par impossível (`interface-que-nao-existe`, 6) | **FALHA alto**: `Table '…seed64_falhou_par_esperado_ausente' doesn't exist` |
| Limpeza | schema descartável apagado; `setes_central` DEPOIS = 23 pares (intacto) |

Conhecimento negativo: o script não é transacional — na falha da conferência 3 o `INSERT IGNORE` anterior já gravou (é idempotente, então
corrigir a lista e rodar de novo basta). Com `lower_case_table_names=1` (Windows) a mensagem sai em minúsculas.

## 10. Aplicação em `setes_central` (2026-10-18 — Valdo: "Vai: aplique o seed 64 no setes_central pelo roteiro do §8")

| Passo do §8 | Resultado |
|---|---|
| (1) catálogo igual ao da prova | 23 pares (0 mortos, último `updated_at` 2026-09-22), 40 interfaces, 9 privilégios — igual à prova; seed com SHA-256 `729e25fb…575d0` |
| (2) `npx tsx scripts/apply-seed.ts 64_privileges_backfill_seed.sql` | `[apply-seed] OK` (a conferência 3 passou — nenhum par esperado ausente) |
| (3a) 157 pares | **157 vivos e ativos**, 0 mortos; as 40 interfaces com o conjunto do §3.1, conferido linha a linha |
| (3b) C1 — "trocar cobrança" | o setes-api (:3000) e o app de produção (:5051) **não estavam no ar** na hora (nada escutando nas portas) — a tela não pôde ser vista ao vivo. Prova pelo MESMO código do `GET /api/core/menus`: `getMenus` do `core.service` rodado só leitura para os dois admins da Setes (usuários 2 e 3) → **Baixas (`settlements`): INSERIR, ALTERAR, EXCLUIR, VISUALIZAR, DESCONTO**; como `settlement_page.dart:343` mostra o ícone ⇄ quando `CurrentInterface.can('ALTERAR')`, o botão volta. **Falta só ver na tela**: ao subir a API e o app, entrar de novo (o menu é carregado no início) e abrir Baixas. |
| (4) commit | feito sem push (Valdo, 2026-10-18): sql `3672ee2` (seed 64 + comentário do 06) e Infra-IA só com os trechos desta tarefa — no `INDICE_CENTRAL.md` e na skill do formulário havia trechos de outras sessões (densidade, produtos, grupo), que ficaram fora do commit; o `prompt_frente_grupo_estabelecimentos.md` (nunca commitado, da outra frente) também ficou fora |

Efeito colateral esperado e conferido no mesmo `getMenus`: o menu do admin passa a carregar o catálogo completo das telas contratadas
(ex.: bank-slips INSERIR, ALTERAR, IMPRIMIR, VISUALIZAR, CANCELAR, TRANSMITIR). Na tela, hoje, só o C1 muda — os demais gates do app
(FATURAR, CANCELAR, TRANSMITIR, DESCONTO) já estavam no catálogo; INSERIR/EXCLUIR/IMPRIMIR só passam a valer na onda da D-PV2.

## 11. Onda da D-PV2 — Rodada 0 + execução (2026-10-18, sessão própria, em WORKTREE — NADA commitado)

**Transversal**: setes-api + setes-app + nfse-api. Worktrees `D:\Gestao2027\privilegios\{setes-api,setes-app,nfse-api}` (branch
`privilegios-crud`, base = `main` de cada repo: api f53a618 · app 2f621c1 · nfse 62c5fcf), junções `privilegios\fiscal-api` e
`node_modules` (molde da `grupo-leitores`). Banco: só leitura (sessão `READ ONLY`). setes-sync/sincronizador não lidos.
Pré-condição conferida: **o seed 64 JÁ está aplicado em `setes_central`** (157 pares, 2026-10-18).

### 11.1 Fatos novos (corrigem premissas da Rodada 1/2)

- **F1 — a premissa da D-PV2 era falsa.** "possível porque o módulo do app só fala com o seu `/api/<m>`": **13 chamadas cruzadas vivas**
  no app — 12 LEITURAS de lista de apoio (pedido, OS e contrato → `/api/customers`; contrato, OS e Baixas → `/api/payment-types`; Baixas e
  Caixa → `/api/bank-accounts`; Formas → `/api/financial-plans`; aba Parceria → `/api/collaborators`; Devolução → `/api/cfop`; pedido →
  `/api/customers/salesman-lookup` pela peça `SalesmanLookupDatasource`) + 1 ESCRITA (pedido → `POST /api/order-returns` = "Devolver").
  Com a guarda, quem só tem a OS precisaria de VISUALIZAR em Clientes. A regra vigente (CLAUDE.md, Serviços/ISS) já mandava o contrário →
  corrigido como aplicação da regra (A-PV5): cada tela lê a SUA lista (§11.3).
- **F2 — defeito pré-existente**: o diálogo de CFOP do faturamento da devolução lia `/api/cfop`, que é `superGuard` ⇒ **o admin recebia
  403 e só o super faturava devolução pela tela**. Caiu de carona (rota própria `order-returns/cfop-lookup`).
- **F3 — licença no CRUD tira acesso do ADMIN da Setes** (provado no banco, só leitura): a guarda reaproveita a conferência existente
  (licença ANTES do privilégio — D-F37). O contrato da Setes tem 14 telas; as flags habilitam 26 módulos e `isModuleEnabled` libera TUDO
  à institution 1 ⇒ depois da onda, os 2 admins recebem 403 `INTERFACE_NOT_ALLOWED` em Clientes, Colaboradores, Vendedores,
  Transportadoras, Fornecedores, Categorias, Plano de contas, Formas, Contratos, Contas bancárias, Campos e Configurações (e na
  "Configurações Gerais"). O MENU deles já não mostra essas telas (D-GE19 parte 2); hoje chegavam por deep link e pelas chamadas cruzadas
  (já resolvidas). O super segue vendo tudo (A-PV1). ⇒ **Q-PV11** (decidir ANTES de publicar).
- **F4** — os 10 usuários `kind='user'` do `setes_setes` (265–274) são RESÍDUO de teste com `tb_user.deleted='S'` (não logam) ⇒ o §2.4 se
  mantém: nenhum usuário regular vivo. (O vínculo `tb_institution_has_user` deles segue `deleted='N'` — inofensivo, não é desta tarefa.)
- **F5** — `partnerships` (kind 'R') não está contratada em lugar nenhum nem entra no `grantStructuralInterfaces`; com a A-PV2 a aba
  Parceria passa a exigir a licença DELA ⇒ **Q-PV12**.
- **F6** — o app só conhece os privilégios da tela aberta PELO MENU (`CurrentInterface`): a engrenagem de qualquer lista abre o painel de
  configs com a interface de ORIGEM; as 'R' não vêm no menu (`ONLY_SCREEN_KIND`); o "Devolver" do pedido grava em outra interface ⇒ nesses
  três o app não esconde o botão e a API decide (403 com mensagem) ⇒ **Q-PV13**.
- **F7** — `state-tax-rates` (MVA/FCP por UF×NCM) não tem interface no catálogo ⇒ fica FORA da guarda: qualquer autenticado escreve dado
  fiscal pela API ⇒ **Q-PV14**.
- **F8** — o `OPTIONS` (preflight CORS) é respondido em `app.ts` antes da autenticação — não chega à guarda.

### 11.2 O que foi feito

**setes-api**
- Peça `src/shared/auth/module-privilege-gate.ts`: `gatedModule('<m>', routes)` no gateway (25 módulos de tela do cliente:
  interface-fields, interface-configs, customers, collaborators, salesmen, carriers, providers, tax-rules, categories, financial-plans,
  payment-types, contracts, bank-accounts, settlement-rules, bank-slips, bank-charge-agreements, checks, services, price-lists,
  service-tax-rules, service-orders, settlements, cashier, orders, order-returns). Verbo → GET/HEAD 6 · POST 1 · PUT/PATCH 2 · DELETE 3
  na interface do módulo; atos marcados NA ROTA com `privilegeAct(PRIVILEGE_X[, interface])`; exceções com `openRoute(motivo)`. A guarda
  acha a rota casada no `stack` do roteador do módulo (a mesma `regexp` que o Express usa — sem efeito colateral); rota sem marcador vale
  pelo VERBO (esquecer nega, nunca libera). Fora da guarda, por nome: core, erp, admin, entities, billing/* (ações pela interface do RAMO),
  geográficos (leitura aberta), as do Super (`superGuard`), users/establishment (D-PV5), modules (`adminGuard` até a onda 0 — D-GE20) e
  state-tax-rates (F7). `listGatedRoutes()` = a tabela dos pares consumidos (insumo da cerca D-PV9).
- **A-PV1**: `require-privilege.ts` ganhou a peça `licensedFor` (super → basta existir no catálogo central; admin/regular → contratada) +
  `privilegeVerdict`/`denyPrivilege` (mesmo envelope em toda guarda). `requirePrivilege`/`requirePrivilegeFor`/`requireInterfaceFor` usam
  a peça. Interface que NÃO existe no catálogo nega também para o super (integridade, não licença).
- **D-PV7/D-PV8 no código**: settlements baixa = I (verbo) · estorno = E · trocar cobrança = A (o `requirePrivilege` duplicado da rota
  saiu); bank-slips emitir = I · liquidar = A · cancelar/estornar = 7 · registrar = 9 · PDF = 4 · consultar/simular/reaplicar = 9 (A-PV7);
  checks movimentos = A · estornar = 7; cashier abrir = I · retirada/fechar = A; OS rotina mensal = 5 · excluir = E · faturar/lote = 5
  (viraram marcador); pedido/devolução excluir = E; canal API da conta bancária = A em toda escrita (A-PV9; o `adminGuard` segue).
- **Exceções e interface trocada**: `GET /interface-fields/key/:k`, `GET /interface-configs/key/:k` e `PUT /interface-configs/key/:k/:n`
  (A-PV6) abertos; aba Parceria (`GET/PUT /customers/:id/partnership` + a lista de apoio dela) confere `partnerships` (A-PV2); o painel de
  configs aceita o privilégio da "Configurações Gerais" no painel DELA (A-PV8 — `interface-configs.privilege-policy.ts`, resolvedor
  dinâmico pelo `:id`). D-PV6: salvar campo = ALTERAR do painel de campos.
- **D-PV5**: o cadastro de privilégios do usuário não lista users/establishment (lista nomeada `ADMIN_PROFILE_INTERFACE_KEYS` no
  service) e o salvar recusa (400 `PRIVILEGE_ADMIN_PROFILE` no campo `privilegeIds`) — para qualquer usuário-alvo (A-PV10). Códigos
  novos no catálogo de erros: `PRIVILEGE_ADMIN_PROFILE`, `CONFIG_INSTITUTION_VIA_PANEL` (rodar `npm run errors:gen` na publicação).
- **Listas de apoio próprias (A-PV5)**: novas `settlements/payment-types`, `settlements/bank-accounts`, `cashier/bank-accounts`,
  `service-orders/payment-types`, `payment-types/financial-plans`, `customers/collaborator-lookup`, `order-returns/cfop-lookup`,
  `orders/active-salesman-lookup`; peça nova `@shared/bank-account` (2 consumidores); as de cliente do pedido/OS/contrato e a de formas do
  contrato ganharam campos ADITIVOS (`nickTrade`/`nameCompany`/`description` — a pesquisa avançada segue lendo `name`). Cada uma reproduz o
  conjunto de linhas que a tela lia antes (formas: só as HABILITADAS — as que o ato aceita). Swagger em todas.

**nfse-api** (caminho fiscal de PRODUÇÃO — só código + testes com dublês; nada ao vivo): A-PV1 em `src/modules/guards.ts` por uma peça
`licensed` (super → sempre; chaves da nfse-api são sempre reais) em `requireBranchPrivilege`, `requireBranchInterface`,
`requireAnyInterface`, `visibleInterfaces` e `passScope` (para o super todo ramo vai a `[interfaces]` — nada "só vivas") (A-PV11). A cerca
da virada (`requireCutover`) NÃO é licença: segue barrando o super.

**setes-app**
- Ponto único DA FÁBRICA `app/shared/session/crud_privileges.dart`: `CrudPrivileges.canInsert/canUpdate/canDelete/canSave(creating:)`
  sobre a `CurrentInterface`, com o nome LITERAL do catálogo. As telas de processo (`modules/<m>/`) perguntam direto
  `CurrentInterface.can('NOME')` — a cerca da D-PV9 lê o par estaticamente e reprova nome que não seja literal (por isso uma lista de
  constantes `PrivilegeNames`, que chegou a ser escrita, saiu).
- Fábrica: `RegisterSearchPage` "Novo" ← INSERIR; `RegisterFormPage` (novo parâmetro `creating`) e a casca nova `RegisterFormShell`
  (sobre a `SetesFormShell` do design system) — ✓ ← INSERIR no registro novo / ALTERAR na edição, lixeira ← EXCLUIR. As 15 telas de
  cadastro do cliente trocaram `SetesFormShell` por `RegisterFormShell`; as 11 da `RegisterFormPage` passam `creating` (OBRIGATÓRIO —
  deduzir de `canDelete` erraria na tela que não exclui). Árvores
  (Categorias, Plano de contas): novo nível/subnível ← INSERIR.
- Telas de processo uma a uma: pedido/OS/devolução (novo ← I; item novo ← I, mudar ← A, tirar ← E — literal; excluir o documento ← E;
  negociação ← A; rotina mensal ← FATURAR); Baixas (baixar ← I, estornar ← E, trocar cobrança ← A); Boletos (emitir ← I, liquidar ← A,
  cancelar/estornar ← CANCELAR, registrar/consultar/reaplicar ← TRANSMITIR — inclusive a consulta silenciosa ao abrir a tela, PDF ←
  IMPRIMIR); Cheques (movimentos ← A, estornar ← CANCELAR); Caixa (abrir ← I, retirada/fechar ← A).
- As 12 leituras cruzadas trocadas pelas rotas próprias (§11.1 F1); `SalesmanLookupDatasource` ganhou o `path` do módulo de quem usa.
- Fora do portão no app (a API decide): painéis de campos/configs (F6), aba Parceria (F6), "Devolver" do pedido (F6), Meu
  Estabelecimento e as telas do Super (perfil — admin/super recebem o catálogo inteiro).

### 11.3 Assunções executadas (A-PVn — ratificar)

- **A-PV5 — RATIFICADA (Valdo, 2026-10-20: "ratifico")** — as leituras cruzadas viram lista de apoio do PRÓPRIO módulo (regra vigente "módulo só fala com o seu /api"), reproduzindo o
  conjunto de hoje; a escrita cruzada "Devolver" fica como está (abrir devolução = INSERIR em `order-returns` — o sentido certo).
- **A-PV6 — RATIFICADA (Valdo, 2026-10-20; com a D-PV25 a porta do valor `'I'` é o veredito CONFIGURAR da tela alvo)** — `PUT /interface-configs/key/:moduleKey/:name` (o override PESSOAL do itens/página que TODA lista grava) aberto como a leitura
  por chave — e por ser aberto, **só `target: 'U'`**: o valor da institution (`'I'`) tem UMA porta, a do painel guardado (`PUT
  /:id/:name`); pela chave responde 403 `CONFIG_INSTITUTION_VIA_PANEL` (achado do gate socrático: eram duas portas para o mesmo ato, e a
  aberta era a mais fraca). O app só grava `'U'` pela chave.
- **A-PV7 — RATIFICADA COM EMENDA (Valdo, 2026-10-20: "transmitir e consultar sao dois verbos independentes" → D-PV40: nasce CONSULTAR; o reaplicar saiu pela D-PV27)** — falar com o BANCO = TRANSMITIR (registrar — D-PV7 — e também consultar, simular no sandbox e reaplicar a voz dele), simétrico
  ao fisco, onde consultar também é TRANSMITIR (`nfse-api` `refresh`/rodízio).
- **A-PV8 — SUPERADA pela D-PV25 (Valdo, 2026-10-20: "confirmo" — CONFIGURAR em `general-configs` para a geral, CONFIGURAR na tela X para as demais; sem exceção)** — o privilégio da "Configurações Gerais" vale no painel de configs filtrado nela (vitrine + o `:id` dela); outra tela, só o do
  painel (`interface-configs`).
- **A-PV9 — RATIFICADA (Valdo, 2026-10-20; "Testar conexão" fica em ALTERAR — a finalidade é configurar o canal, não consultar documento; não é CONSULTAR da D-PV40)** — canal API da conta bancária: toda escrita = ALTERAR (o inventário do §3 já dizia "canal = A").
- **A-PV10 — RATIFICADA (Valdo, 2026-10-20)** — D-PV5 vale para qualquer usuário-alvo (o cadastro nunca oferece users/establishment; admin não precisa — passa o privilégio).
- **A-PV11 — RATIFICADA (Valdo, 2026-10-20)** — A-PV1 alcança também as LEITURAS fiscais da nfse-api (`requireBranchInterface`, `requireAnyInterface`, `visibleInterfaces`) —
  "todas as verificações"; a cerca da virada não é licença.

### 11.4 Questões — Rodada 3 (aguardam o Valdo; nenhuma trava o que foi feito, a Q-PV11 trava a PUBLICAÇÃO)

- **Q-PV10 — itens dos documentos abertos (pedido, OS, devolução)**: executado o LITERAL da D-PV2 (item novo = INSERIR, mudar = ALTERAR,
  tirar = EXCLUIR). Efeito: quem monta pedido precisa dos três, e quem pode tirar item também pode excluir o pedido aberto. (a) manter o
  verbo; (b) **todo ato sobre o documento aberto = ALTERAR** (itens, negociação) — INSERIR = abrir o documento, EXCLUIR = apagá-lo; quem
  lança pedido precisa de I + A; (c) item = INSERIR **ou** ALTERAR. **Rec.: (b)** — cada verbo com um sentido só sobre o DOCUMENTO
  (mesmo princípio da D-PV8).
- **Q-PV11 — DECIDIDA: D-PV10 = (a)** (a Setes é cliente como os outros; só o super tem tudo). Texto original da questão: a licença no CRUD (F3): a guarda executa a licença (D-F37 ao pé da letra). Além dos cadastros não
  contratados, o gate socrático achou a regressão que dói HOJE: a **engrenagem de tela CONTRATADA** (Meu Estabelecimento → fuso; Baixas →
  `max_discount_aliquot`; OS; Boletos) abre o painel `interface-configs`, que a Setes NÃO contrata ⇒ os 2 admins deixam de mudar essas
  configs pela tela (só o super). (a) manter a licença e, ANTES do merge, contratar na Setes as telas que os admins usam (no mínimo as
  estruturais `interface-configs`/`users`/`modules`, que o `grantStructuralInterfaces` dá a todo cliente novo e a Setes não tem); (b) os
  PAINÉIS de sistema (`interface-configs`, `interface-fields`, `general-configs`) ficam fora da licença como infraestrutura — já eram
  `FLAG_EXEMPT` — e só o privilégio decide neles; (c) a guarda do CRUD confere só o privilégio (licença fica nas ações, no menu e nas
  flags); (d) aceitar que só o super os usa. **Rec.: (a) + (b)** — tela de cliente não contratada não existe (D-GE19 parte 2); painel
  de sistema é a moldura das telas contratadas, não um produto vendido.
- **Q-PV12 — licença das interfaces 'R' (F5)**: executado (a): a aba Parceria exige a licença de `partnerships`. (a) manter — a 'R' é
  vendida no contrato junto da tela-mãe (implantação + `grantStructuralInterfaces`/aba Interfaces do Super); (b) a 'R' herda a licença da
  tela-mãe (Clientes) e só o privilégio é dela. **Rec.: (a)** — é o que a D-GE19 diz ("as interfaces farão parte do contrato"); a aba que
  some quando não contratada depende da Q-PV13.
- **Q-PV13 — privilégios de OUTRAS interfaces no app (F6)** [→ decidida junto da Q-PV20 da cerca = **D-PV17**: a interface do botão é a
  do MÓDULO da tela; navegar entre módulos troca o `CurrentInterface` pelo item do menu da tela de destino; sem o item no menu, `can` =
  falso — EXECUTAR nesta onda antes de publicar (§11.8 item 3a)]: (a) o `/api/core/menus` (ou `/me`) entrega, junto da tela, os privilégios das
  'R' que ela hospeda e das telas que ela aciona (engrenagem → `interface-configs`; "Devolver" → `order-returns`), e o app ganha um
  `can(i18nKey, X)` de sessão; (b) a API decide (403 com mensagem) — limite conhecido. **Rec.: (a)** em entrega própria de UX, sem
  urgência (nenhum regular vivo).
- **Q-PV14 — portas de ESCRITA fora da guarda**: `state-tax-rates` (CRUD de MVA/FCP sem interface no catálogo — F7), `PUT
  /api/entities/:id/tax` (grava `tb_entity_tax` por fora do ALTERAR do papel; sem consumidor no app) e `POST /api/billing/validate` (grava a
  regra por item, origin 'A', sem guarda nenhuma). (a) `state-tax-rates` sob `adminGuard` até a tela nascer; `entities/:id/tax` retirada
  (o salvar vai pela aba Tributação DO PAPEL, na transação dele); `billing/validate` sob FATURAR pela interface do RAMO (o mesmo resolvedor
  do `/invoice`); (b) cada uma ganha interface/privilégio próprio agora; (c) limite conhecido. **Rec.: (a)**.
- **Q-PV15 — A-PV1 × conferências de licença que NÃO são guarda** (`isInterfaceAcquired` do painel de campos/configs — gravar config de tela
  não adquirida; elegibilidade do menu da Módulos): o super escapa também? (a) **não** — é regra de domínio do contrato (o dado gravado é
  da institution), não acesso; (b) sim. **Rec.: (a)**.

- **Q-PV21 — quem governa as configs da tela X aberta pela engrenagem**: (a) o privilégio do PAINEL (executado; a A-PV8 abre exceção só
  para a "Configurações Gerais"); (b) o V/A da PRÓPRIA tela X (coerente com a A-PV2 — "billing = V + A, o conteúdo dela são as configs").
  **Rec.: (b)** — quem pode alterar a tela pode ajustar o comportamento dela; o painel solto (menu Sistema) segue pelo privilégio dele.
- **Q-PV22 — reaplicar a voz do banco (`POST /bank-slips/:id/reapply`)**: executado TRANSMITIR (A-PV7), mas o ato NÃO fala com o banco —
  aplica no ERP a liquidação ou o cancelamento que o banco já disse. (a) TRANSMITIR (o canal com o banco, como está); (b) o privilégio do
  EFEITO (ALTERAR = liquidar · CANCELAR = cancelar), decidido pela voz reaplicada. **Rec.: (b)** — quem aplica o efeito responde pelo
  efeito.
- **Q-PV23 — a janela de publicação**: API e app têm de mudar JUNTOS (app velho sobre API nova: o seletor de cliente da OS e as contas do
  Caixa/Baixas leem `/api/customers`/`/api/bank-accounts`, não contratadas → 403 para o admin; app novo sobre API velha: `GET
  /api/service-orders/payment-types` cai no `GET /:id` → 400). (a) roteiro de janela única (merge da API + recarga das abas do app
  publicado) e conferência depois; (b) a guarda nasce em modo "registra e deixa passar" por um período (log de quem SERIA barrado) e só
  depois nega. **Rec.: (a)** — hoje não há regular e a produção é uma máquina só; (b) se a Q-PV11 não for decidida a tempo.
- **Q-PV24 — custo e escopo da conferência**: cada requisição de tela do cliente custa +1 consulta (contrato) para o admin e +2 para o
  regular, sem cache (o `flag.service` tem TTL de 60 s). E o `userHasPrivilege(schema, user, interface, privilégio)` não recebe a
  institution — com a 1ª filial no mesmo schema (onda 0 do grupo, D-GE3), o privilégio dado na matriz valeria na filial. (a) medir agora e
  decidir cache depois (revogação imediata); a D-GE3 entra na peça única (`privilegeVerdict` ganha a institution) na onda 0; (b) cache do
  veredito com TTL curto e invalidação ao salvar privilégio/contrato. **Rec.: (a)**.

- **Q-PV25 — tributação AVULSA da entidade (`GET/PUT /api/entities/:id/tax`)** — achado HIGH do gate adversarial; interino já no código:
  `adminGuard`. (a) **remover as duas rotas** (sem consumidor no app; a tributação se grava na transação do PAPEL — aba Tributação — e a do
  emitente pelo Meu Estabelecimento, com as validações); (b) manter com `adminGuard` (como está); (c) exigir ALTERAR da tela do papel e
  recusar `:id` = institution. **Rec.: (a)** — porta sem consumidor é só superfície; menos uma exceção na guarda.
- **Q-PV26 — rotas abertas do `/api/core` e da leitura por chave**: `PUT /api/core/theme` deixa qualquer regular trocar cores e logo da
  institution; `GET /interface-configs/key/:k` (aberta — monta toda tela) devolve as configs resolvidas da institution de qualquer tela.
  (a) o tema passa a exigir admin (é marca da empresa); a leitura por chave fica aberta (a tela precisa da config para se montar — não há
  segredo em config de comportamento); (b) as duas como estão. **Rec.: (a)**.

- **Q-PV27 — o ALTERAR do painel de configs × a decisão 4 do Framework de Configurações** (o valor da institution `'I'` é só do admin —
  `interface-configs.service.ts:99`): para o usuário regular, o ALTERAR de `interface-configs`/`general-configs` hoje não muda nada (o
  override pessoal `'U'` já entra pela porta aberta por chave) — o cadastro oferece um privilégio que nenhum código consome (o defeito que a
  Q-G29 veio fechar). (a) o ALTERAR do painel passa a abrir o `'I'` também para o regular (a decisão 4 vira "valor da institution = quem tem
  ALTERAR"; admin segue passando); (b) manter a decisão 4 e o catálogo desses painéis ficar só com VISUALIZAR; (c) limite conhecido.
  **Rec.: (a)** — é o que a D-PV1 pôs no catálogo ("V, A — os painéis não incluem nem excluem").
- ⚠️ **Q-PV11, Q-PV15, Q-PV21 e Q-PV27 regem o MESMO caminho** (engrenagem da tela X → painel → service: licença do painel na guarda,
  `isInterfaceAcquired` de X no service, privilégio de qual interface, valor `'I'` de quem) — decidir JUNTAS, com a regra escrita por
  caminho (menu Sistema → painel × engrenagem da tela X → painel).

- **Q-PV28 — o próprio estabelecimento como papel** (achado HIGH do adversarial; interino no código: 409 `ROLE_IS_OWN_ESTABLISHMENT`):
  (a) **os papéis recusam a entity do próprio estabelecimento** (como está — a empresa não é cliente/fornecedor/transportadora/colaborador de
  si mesma; OS interna usa um cliente interno, como o smoke da D-F54); (b) o papel pode existir, mas a aba Tributação e a cadeia ficam
  somente leitura quando a entity é a institution (o emitente só se edita pelo Meu Estabelecimento); (c) separar a tributação do EMITENTE
  da tributação da RELAÇÃO numa peça própria (tabela datada da D-IB7) — pede o guardião. **Rec.: (a)** agora; (c) quando a D-IB7 nascer.
- **Q-PV29 — cadeia GLOBAL last-write-wins entre institutions (Fase 3, decisões 1/9)**: o cadastro de um papel numa institution reescreve
  a cadeia (razão social, IE/IM, endereços) da mesma entity — inclusive a de um EMITENTE de OUTRA institution, cujo CNPJ alguém cadastre
  como cliente. Fora do alvo desta onda (decisão anterior da Fase 3); registrado para rodada própria (com o guardião), ligado à frente do
  grupo (D-GE1/D-GE21: a institution enxerga só o próprio dado + o compartilhado por consulta).

- **Q-PV30 — trilha do vínculo e da delegação** (o vínculo é a LICENÇA e agora é editado por quem não é Super): hoje a trilha é o log
  (`added`/`removed` + autor nas duas portas e na concessão de privilégio — feito no gate). (a) tabela de eventos append-only (quem,
  estabelecimento alvo, interface, concedeu/revogou, quando), no molde dos `_event` do produto; (b) o log basta; (c) limite conhecido.
  **Rec.: (a)** — log gira; licença comercial precisa de história consultável.
- **Q-PV31 — gravação simultânea do vínculo**: a aba manda a lista COMPLETA montada quando abriu; o Super concede numa porta e o liberado,
  com a aba aberta, revoga em silêncio na outra. (a) a aba grava a DIFERENÇA de cada marca (concede/revoga um id); (b) versão otimista
  (409 se mudou desde a leitura); (c) limite conhecido. **Rec.: (a)** — cada marca já é um ato.
- **Q-PV32 — o que a porta delegada pode vincular**: (a) só interfaces vendáveis (fora do grupo Super), e as ESTRUTURAIS (users, modules,
  interface-configs, establishment) não se revogam por ela; (b) o catálogo inteiro, como a aba do Super. **Rec.: (a)**.
- **Q-PV33 — a flag técnica dos módulos que já passam pela guarda**: sem o atalho da Setes, a flag é uma 2ª licença sem tela (nenhuma
  porta a sincroniza com o vínculo). (a) a flag morre para os módulos guardados (o vínculo já é a licença — D-F37/D-PV2); (b) a peça grava
  a flag junto do vínculo; (c) manter, com conferência no deploy. **Rec.: (a)** — liga à D-GE22 item 3.
- **Q-PV34 — "a própria Setes" no mundo do grupo** (hoje o literal id 1 em 5 lugares; na onda 1 do grupo o vínculo é do GRUPO e uma filial
  da Setes teria outro id): (a) predicado da peça pelo grupo/schema já agora; (b) id 1 até a onda 1, com nota no roteiro dela. **Rec.:
  (b)**.
- **Q-PV35 — LER o vínculo da própria Setes** (`GET /api/institution-interfaces/1` pelo liberado): (a) 403 como o salvar (coerente com a
  lista, que a esconde); (b) leitura permitida (como está). **Rec.: (a)**.
- **Q-PV36 — config de tela do Super que ninguém contrata** (o `page_size` da tela nova não persiste: o painel de configs recusa tela não
  "adquirida") — ligada à Q-PV15: (a) tela do Super delegável conta como adquirida pela Setes para as configs dela; (b) limite conhecido.
  **Rec.: (a)**.

- **Q-PV37 — quem mexe na CONTA (senha, e-mail, ativo, exclusão)** — achado HIGH do adversarial do delta; interino no código: o não-super
  só mexe em conta cujos vínculos vivos são todos com o próprio estabelecimento e nenhum super. (a) manter a regra interina e acrescentar:
  **a conta que recebeu uma liberação de tela do Super também passa a ser gerida só pelo Super** (senão o admin troca a senha do liberado
  e herda a delegação — o MEDIUM restante); (b) só a regra interina (o liberado segue editável pelo admin da Setes); (c) outra forma.
  **Rec.: (a)** — a liberação é ato do Super (D-PV11 (b)); a credencial de quem a recebeu é a própria liberação. (Re-prova: a regra
  interina passou a contar TODO vínculo, vivo ou adormecido — vínculo revogado que o Super revive entregava a conta.)
  → **DECIDIDA pelo Valdo = (b) — D-PV12** (Valdo divergiu da recomendação; ver "Rodada 4" nas Decisões).
- **Q-PV38 — força bruta no código de 6 dígitos do `/auth/change-password`** (MEDIUM ANTERIOR à onda, achado de passagem na re-prova): o
  código não morre depois de N tentativas erradas; só freia o limite de 300/min por IP (sem `trust proxy` atrás do proxy, o IP é o do
  proxy — ou todos dividem o limite, ou ninguém). (a) tarefa própria: N tentativas erradas (ex.: 5) invalidam o código + limite por
  e-mail; (b) limite conhecido até a Onda 4. **Rec.: (a)** — fora desta onda (não mexe em privilégio), tarefa separada.
  → **DECIDIDA pelo Valdo = (a) — D-PV13**: tarefa própria, iniciada em sessão separada em 2026-10-18 ("Força bruta no código do
  /auth/change-password (Q-PV38)"); o resultado é registrado lá, não nesta onda.
  → **EXECUTADA em worktree em 2026-10-18 (§13)**: `tb_user_password_reset` (sql/67) — 5 erradas esgotam o código (a 6ª certa = a mesma
  401), teto por conta + limite por e-mail em memória, resposta neutra (corpo, status e tempo); gates 0,66 → 0,80 · 0,82 · delta 0,85.

### 11.5 Testes

- setes-api: **2149 testes, 134 suítes** (31 pulados — os ao vivo; última volta depois dos retrabalhos dos gates) com os novos — `module-privilege-gate.test.ts` (22: mapa do verbo, atos, exceção, interface
  trocada/dinâmica, HEAD, rota inexistente, perfis, A-PV1, a tabela), `privilegios-rotas-d-pv2.test.ts` (38: o mapa REAL do gateway — os
  25 módulos, os atos da D-PV7/D-PV8, canal, exceções, e a CERCA dos POST: rota nova com POST tem de ser classificada), 
  `privilegios-lookups-proprios.test.ts` (16, de ponta a ponta: a tela consumidora lê a sua lista; o privilégio da dona NÃO basta),
  `users-privileges-admin-profile.test.ts` + casos D-PV5 em `users.test.ts`, A-PV1 em `require-privilege.test.ts`. Testes antigos que
  fixavam o super barrado pela licença foram atualizados para a A-PV1 (decisão nova); os de rota que usavam regular SEM privilégio ganharam o
  dublê `src/test-setup/privilege-db.ts` (`grantingPrivileges`). As 3 suítes que leem o `.env` rodaram com cópia temporária (apagada).
- Smoke SÓ-LEITURA no banco real (sessão `READ ONLY` provada — a escrita é recusada pelo banco): todas as consultas novas rodam, contagens
  = as de hoje (contas 2/2, vendedores ativos 2/2, plano de contas 0/0, formas habilitadas 6), cadastro de privilégios do admin 2 = 13 telas
  sem users/establishment; veredito do admin em Clientes = `not-contracted` (F3), do super = `ok`. **Pares da guarda × catálogo vivo**:
  os 233 pares que `listGatedRoutes()` exige existem nos 157 do seed 64 (0 faltando) — o verbo-padrão não pede par inexistente.
- nfse-api: **965** (185 pulados — os ao vivo), +5 em `privilegios-apv1.test.ts` e +11 da sonda adversarial. setes-app: `flutter analyze` limpo; suíte inteira
  **640** (28 pulados) com `crud_privileges_test.dart` (8: o ponto único, a casca, o "Novo" da pesquisa, a `RegisterFormPage`).

### 11.6 Gates

- **Socrático, 1ª passada: 0,68 — REPROVOU** (limiar 0,70). Mecanismo da guarda conferido contra o despacho real do Express (mesma
  `regexp`/`keys`, HEAD→GET, OPTIONS no CORS, nenhum `next('route')`/`router.param`/`mergeParams`/sub-roteador nos 25 módulos); A-PV1
  segura no caminho fiscal (a Setes contrata os 3 ramos — `passScope` sem mudança hoje; cerca da virada intacta). Retrabalho feito na
  sessão: (1) **duas portas para o valor da institution** — a rota aberta por chave aceitava `target: 'I'` → agora só `'U'`, 403
  `CONFIG_INSTITUTION_VIA_PANEL` (A-PV6 revista); (3) **a cerca falhava aberta para módulo novo** → `privilegios-rotas-d-pv2.test.ts` lê o
  `gateway/router.ts` e exige que TODO `router.use` seja `gatedModule('<chave = URL>')` ou exceção nomeada (e conta cada `router.use(`);
  (4) **o marcador ignorava o verbo** (`router.route(x).get(act).post(h)` daria ao POST o privilégio do GET) → `actOf(layer, method)` pelo
  `method` de cada handler; (5) **erro sem código** → `PRIVILEGE_ADMIN_PROFILE`. Pontos que pedem decisão viraram Q-PV11 (reescrita: a
  engrenagem das telas contratadas quebra para os admins da Setes), Q-PV14 (ampliada), Q-PV21…Q-PV24.
- **Socrático, re-score: 0,76 — PASSOU.** Os 5 retrabalhos conferidos no código. Sobras corrigidas na sessão: a cerca do gateway passou a
  casar `router.use` indentado e a conferir que o `app.ts` monta em `/api` só o gateway; a negação da guarda deixa RASTRO no log (quem,
  interface, privilégio, veredito, rota — insumo da conferência da janela, Q-PV23); o comentário do cache de interface virou conhecimento
  negativo (o id por `i18n_key` não expira no processo). Pontos que pedem decisão: Q-PV26 (tema) e Q-PV27 (abaixo); o 403 sem código do
  `interface-configs.service` (linhas 88/100/103 — anterior à onda) fica como limite.
- **Adversarial, 1ª passada: 0,74 com 1 HIGH — REPROVOU.** HIGH (provado por sonda, rota ANTIGA na exceção nomeada `/api/entities`):
  `PUT /api/entities/:id/tax` deixava o usuário regular SEM privilégio reescrever a tributação de qualquer entidade — inclusive a do
  EMITENTE (regime do Simples, apuração, pTotTribSN, que a nfse-api lê para o DPS de produção), por fora do `adminGuard` e das validações
  do Meu Estabelecimento (D41/D-PV5, Q-N36/Q-N37). **Corrigido na sessão (interino)**: `adminGuard` em `GET/PUT /api/entities/:id/tax`
  (o app não usa essas rotas; o prefill `by-document` segue aberto); as sondas viraram `[CORRIGIDO]` → Q-PV25 para o definitivo. Resistiu:
  truques de URL e verbo (caixa, barra final, `%2F`, `;jsessionid`, `//`, HEAD/PATCH/PROPFIND, method-override), grafias do `:id` do painel
  (`011`, `1.1e1`, `%2011`…), perfis forjados (super fora da Setes, `Super`), banco fora do ar (500 sem vazar), LIKE escapado e institution
  só do JWT nas listas novas, D-PV5 em qualquer grafia do id; na nfse-api a A-PV1 vale só para o super legítimo e a cerca da virada barra o
  super nos dois grãos. Sondas: `setes-api/src/__tests__/adversarial-pv2-gate.test.ts` (41) e `nfse-api/src/__tests__/adversarial-pv2-
  gate.test.ts` (11). Achados restantes: MEDIUM state-tax-rates (Q-PV14), LOW `PUT /api/core/theme` (qualquer regular troca cores/logo —
  Q-PV26), LOW `POST /billing/validate` (Q-PV14), LOW leitura aberta de configs por chave (Q-PV26), LOW cache i18n_key→id sem expiração
  (limite).
- **Adversarial, re-prova 1: 0,76 com 1 HIGH NOVO — REPROVOU.** A correção do 1º HIGH resistiu (admin de OUTRA institution grava só a
  relação dele, no próprio schema; regular e super falso → 403; o prefill segue aberto). HIGH novo, ANTERIOR à onda (antes estava aberto a
  qualquer autenticado; a onda já reduziu a INSERIR/ALTERAR): **cadastrar o próprio estabelecimento como Cliente/Fornecedor/Transportadora**
  — o reuso pelo documento resolve o CNPJ da empresa para a entity da INSTITUTION e a aba Tributação grava a linha do EMITENTE em
  `tb_entity_tax` (e a cadeia — razão social, IE/IM, endereços — na mesma transação), por fora do Meu Estabelecimento; pode acontecer até
  por engano. **Corrigido na sessão (INTERINO — Q-PV28)**: peça `@shared/entity/own-establishment.ts` (`assertNotOwnEstablishment` → 409
  `ROLE_IS_OWN_ESTABLISHMENT`) nos 4 papéis com cadeia fiscal (clientes, fornecedores, transportadoras, colaboradores), na criação logo
  depois do reuso (o throw cai no rollback) e na edição antes da cadeia; nenhum papel da Setes é a própria Setes (conferido no banco, só
  leitura) — nada muda nos dados. Provas: as 2 sondas viraram `[CORRIGIDO]` + `own-establishment-role.test.ts` (cerca dos 4 papéis). LOW
  novo: o ADMIN grava a tributação do emitente por `/api/entities/:id/tax` sem as regras do Meu Estabelecimento (Q-PV25 (a) resolve).
- **Adversarial, re-prova 2 (final): 0,82 — PASSOU** (sem HIGH/CRITICAL). A barreira interina resistiu: varredura de TODO escritor da
  cadeia/tributação da entity = institution (sobram os 4 papéis com a barreira, `entities` com `adminGuard`, `establishment` e `institutions`
  — sonda que fixa a lista e reprova escritor novo), POST e PUT dos 4 papéis (409, rollback, nunca commit), id como texto (`02`, `2.0`,
  `+2`, `%202`, `0x2`), REVIVE de papel soft-deletado (a barreira vem antes), o 409 não vaza id/CNPJ/schema, sem oráculo de outro tenant.
  Restam (registrados): MEDIUM state-tax-rates (Q-PV14); LOW admin × `entities/:id/tax` (Q-PV25), tema (Q-PV26), `billing/validate`
  (Q-PV14), leitura aberta de configs por chave (Q-PV26), override `'U'` de qualquer tela (A-PV6), cache sem expiração (limite); LIMITE
  INTERINO: papel já existente cuja entity é a própria institution (ex.: vindo do sincronizador) fica não editável pelo app até a Q-PV28 —
  hoje nenhum. Sondas finais: setes-api `adversarial-pv2-gate.test.ts` 59 (4 `[CORRIGIDO]`, 4 `it.failing` documentando os abertos) ·
  nfse-api `adversarial-pv2-gate.test.ts` 11.
- **Gates FECHADOS: socrático 0,68 → 0,76 ✅ · adversarial 0,74 (HIGH) → 0,76 (HIGH novo) → 0,82 ✅.**

### 11.7 Limites conhecidos (conhecimento negativo)

- A guarda depende da forma interna do Router do **Express 4** (`stack[].route`, `.regexp`, `.keys`, `route.methods`,
  `route.stack[].handle`). A prova `module-privilege-gate.test.ts` quebra alto se a forma mudar (Express 5). Sub-roteador DENTRO de módulo
  guardado é recusado por `listGatedRoutes()`.
- Cada requisição de tela do cliente custa +1 consulta de contrato (admin/regular) e +1 de vínculo (regular), além do id da interface
  (cacheado). Sem cache de contrato — mesmo custo das guardas de ação de hoje.
- O app esconde botões só pela `CurrentInterface`: deep link libera, e tela aberta FORA do menu herda a interface do último clique (ex.:
  "Devolver" no pedido abre a Devolução com os privilégios de `orders` — Q-PV20 da cerca, mesma família da Q-PV13); quem decide é a API.

### 11.8 Publicação — roteiro (só com o "vai"; commitado e enviado nos branches `privilegios-crud` em 2026-10-18 — api 50b928f · app 5a06d73 · nfse b62d55b; sql 9f4fcf3 — nada no `main`)

1. ~~Decidir a Q-PV11~~ (D-PV10 = (a)): contratar na Setes as telas que os admins usam — lista do Valdo (conferir de novo que não há
   usuário regular vivo); aplicar o seed 65 ANTES do app.
2. Juntar com a cerca da D-PV9 (sessão própria, worktree `privilegios-catalogo`). **D-PV14** (= Q-PV16 (a)): quem chegar por último ao
   `main` escreve o adaptador, e ele põe os pares de `listGatedRoutes()` TAMBÉM na lista que a guarda lê em tempo de execução
   (`CONSUMED_PRIVILEGES`/`requiredPairsOf` — a D-PV15 recusa tirar par consumido nas telas Interfaces/Privilégios), não só no teste da
   cerca. Conflito de merge: só `src/shared/errors/error-codes.ts` (as duas ondas ACRESCENTAM códigos — juntar as duas listas); esta onda
   não tocou `modules/interfaces` nem `modules/privileges`. Avisos da cerca (2026-10-18): o DTO de interfaces só aceita `i18nKey`
   kebab (`^[a-z0-9]+(-[a-z0-9]+)*$` — `institution-interfaces` passa) e o `build-web.ps1` roda a cerca do app sobre a árvore do build
   (`SETES_APP_DIR`); numeração reservada pela cerca: Q-PV50…Q-PV53 (passando de Q-PV49, pular para Q-PV54). A **Q-PV53** da cerca (conserto de
   interface duplicada × contrato dos clientes, que aponta pelo id em `tb_institution_has_interface`/`tb_module_has_interface`) toca esta
   onda: a peça `@shared/institution-interfaces` (D-PV11) grava esse vínculo pelo id — conferir na fusão. A lista dela deve ler `listGatedRoutes()` e os
   consumos do app (`CurrentInterface.can('NOME')` literal nas telas; a fábrica via `CrudPrivileges` — peça compartilhada a registrar
   com as telas que cobre) — avisado por mensagem; a cerca dela exige `requirePrivilege`/primitivas registradas: a guarda por roteador
   (`modulePrivilegeGate`) e as 3 primitivas novas de `require-privilege.ts` (`licensedFor`, `privilegeVerdict`, `denyPrivilege`) entram
   no registro dela no merge.
3. App: os branches `densidade`/`shell` (já no `main`, a450909) mexem na `RegisterFormPage` — merge com atenção (o portão é um parâmetro
   e duas condições). O `build-web.ps1` da cerca para a publicação se a conferência do catálogo acusar alarme (D-PV16).
3a. **D-PV17** (a Q-PV13 desta onda): no app, a interface do botão é a do MÓDULO da tela — navegar entre módulos (ex.: "Devolver" em
   `order_page.dart` → `/home/order-returns/`, a aba 'R' de Parceria, a engrenagem do painel de configs) troca o `CurrentInterface` pelo
   item do menu da tela de destino; sem o item no menu, `can` = falso. PENDENTE de execução nesta onda, antes de publicar.
3b. **D-UC1…D-UC3** (Valdo, na frente do usuário convidado — `prompts/prompt_frente_usuario_convidado.md`, 2026-10-18): a credencial NUNCA
   é excluída e o e-mail de login NUNCA muda — só se inativa (D-UC1, vale até para o Super — A-UC1); inativar no cadastro = o VÍNCULO do
   próprio estabelecimento, os outros ficam iguais (D-UC2); o dono do login é o TITULAR do e-mail (D-UC3). Efeito nesta onda: a **A-PV13
   MORRE** (a barreira deixa de depender de institution); a **D-PV12 encolhe** — das quatro coisas que dava ao admin (senha, e-mail, ativo,
   exclusão), o e-mail e a exclusão deixam de existir, o "ativo" vai para o vínculo e a senha segue a Q-UC18 de lá (Rec.: o admin só
   DISPARA o código ao e-mail). Código do branch a ajustar: `removeUser` some, `editUser` recusa trocar o e-mail de login, "ativo" do
   cadastro = o vínculo, e `assertAccountManageable` fica protegendo só o que sobra (senha/nome — Q-UC18/Q-UC21). PENDENTE: decidir se
   entra nesta onda (antes de publicar) ou na onda de código da frente do convidado — enquanto isso a barreira atual falha FECHADO
   (mais restritiva que a D-UC3, nunca menos).
4. Publicar **API e app JUNTOS** (as rotas antigas que o app lia continuam existindo, mas o app novo precisa das rotas próprias); nfse-api
  = restart manual (produção roda tsx SEM watch).
5. `npm run errors:gen` no setes-api (3 códigos novos: `PRIVILEGE_ADMIN_PROFILE`, `CONFIG_INSTITUTION_VIA_PANEL`,
   `ROLE_IS_OWN_ESTABLISHMENT`; e a descrição do `INTERFACE_NOT_ALLOWED` mudou — o super passa).
6. O commit da onda leva as sondas dos gates (`adversarial-pv2-gate.test.ts` nos dois repositórios — achado confirmado vira teste).
7. Depois: a onda 0 do grupo troca o `adminGuard` da `/api/modules` por `gatedModule('modules', modulesRoutes)` (uma linha) + D-GE3
   (o `privilegeVerdict` passa a receber a institution — Q-PV24).

### ⏯ 11.8.1 Retomar daqui (salvo em 2026-10-18 — "salve tudo para recomeçarmos depois")

Prompt curto para a próxima sessão: *"Retome a onda da D-PV2 pelo §11.8.1 do `prompt_privilegios_interfaces.md`."* ⚠️ TRANSVERSAL
(setes-api, setes-app, nfse-api) — dizer de saída ao retomar.

- **Onde está o código**: worktrees `D:\Gestao2027\privilegios\{setes-api,setes-app,nfse-api}`, branch `privilegios-crud`, COMMITADO e
  no GitHub (api 50b928f · app 5a06d73 · nfse b62d55b), **sem merge no `main`**; seed `sql/65` no `main` do repositório `sql` (9f4fcf3),
  **não aplicado** no banco. Suíte do setes-api 2225 verde (137 suítes) · app 641 · nfse-api 965.
- **1º passo**: a decisão do Valdo que ficou no ar — executar já no branch os itens **3a** (D-PV17: a interface do botão é a do módulo
  da tela) e **3b** (efeito da D-UC1…D-UC5: `removeUser` sai, e-mail de login imutável, "ativo" = o vínculo, a A-PV13 morre) ou deixar o
  3b para a onda de código da frente do usuário convidado. Cada item com testes e os dois gates.
- **Depois**: o roteiro acima (itens 1–7) — contrato da Setes com a lista do Valdo, seed 65 antes do app, `errors:gen`, fusão com a cerca
  (`privilegios-catalogo`, D-PV14/D-PV15: adaptador também na lista de execução; Q-PV53 toca o vínculo pelo id) e com `grupo-leitores`
  (`admin.repository.ts` — ficar com a peça), publicar API + app juntos.
- **Abertas**: Q-PV10…Q-PV15, Q-PV21…Q-PV36 (a Q-PV37 virou D-PV12 e a Q-PV38 virou D-PV13); A-PV5…A-PV11 a ratificar; numeração livre a
  partir de D-PV18 / A-PV15 / Q-PV40 (a cerca reservou Q-PV50…Q-PV53 — passando de Q-PV49, pular para Q-PV54).
- **Sessões irmãs**: a Q-PV38 (recuperação de senha) está em `D:\Gestao2027\recuperacao-senha\{setes-api,sql}`, branch
  `recuperacao-senha` — §13 deste prompt; `sql/67` NÃO aplicado (antes e depois do merge). A frente do usuário convidado está em
  `prompts/prompt_frente_usuario_convidado.md` (D-UC1…D-UC5; sobram Q-UC11/Q-UC23/Q-UC24).

### 11.9 Rodada 3 — D-PV10/D-PV11 executadas (2026-10-18, mesma worktree; NADA commitado; seed 65 NÃO aplicado)

**D-PV10 (a Setes é cliente como os outros)**: morreu o atalho de flags da institution 1 (`flag.service.ts` — só o super escapa das flags,
no middleware); conferido que as flags da Setes cobrem todo módulo que o app usa. A licença no CRUD fica (Q-PV11 = (a)); o contrato da
Setes recebe as telas que os admins usam (as estruturais primeiro) — **implantação com o "vai" e a lista do Valdo** (§11.8).

**D-PV11 (delegação do vínculo de interfaces dos clientes)**:
- API: peça ÚNICA `@shared/institution-interfaces` (leitura escopada pela institution — a forma da D-GE4 — e a escrita do vínculo; a aba do
  Super em `/api/admin` passou a usar a mesma peça — o `admin.repository` re-exporta, o `admin.service` ficou com a MESMA linha da D-GE4);
  módulo novo `institution-interfaces` (6 arquivos: `GET /` paginado, `GET/PUT /:id`; interface fora do catálogo = 400; `:id` = a Setes =
  403 `SETES_INTERFACES_SUPER_ONLY` para quem não é super; a lista do usuário liberado não traz a Setes; trilha no log de quem mudou o quê).
- Guarda DELEGADA (`gatedModule(..., { delegatedSuper: true })` + peça `@shared/auth/super-delegation`): super passa; usuário da Setes —
  **admin inclusive** — só com o privilégio marcado (GET → VISUALIZAR, PUT → ALTERAR); outra institution / "super" fora da Setes → 403 (a
  tela não existe para ela); SEM licença (tela do Super não é vendida). Só as chaves de `DELEGABLE_SUPER_INTERFACES` (hoje 1) podem ser
  montadas assim — a montagem lança com outra (D-PV11 (d)).
- Menu: a tela entra no menu do usuário da Setes SÓ com o VISUALIZAR marcado, e os botões dela são os privilégios que o Super marcou
  (nunca o catálogo — o admin não "passa" privilégio de tela delegada).
- Cadastro de privilégios: a tela delegável só é LISTADA e GRAVADA quando quem edita é o super e o usuário é da Setes — o admin recebe 403
  `SUPER_DELEGATION_SUPER_ONLY` (nunca concede, nem a si).
- Seed `sql/65_institution_interfaces_seed.sql` (interface no grupo Super, V+A, page_size, flag só da institution 1, SEM vínculo no
  contrato de ninguém; conferência que falha alto) **PROVADO em schema descartável** (2026-10-18: id dinâmico, 2ª execução idempotente,
  falha alta com privilégio faltando; `setes_central` intacto em 157 pares; o descartável apagado) — **aplicar só com o "vai"**, ANTES do
  app novo.
- App: a aba de interfaces virou peça COMPARTILHADA (`app/shared/institution_interfaces/` — entidade, fonte abstrata, aba com
  `canChange`); o cadastro de Estabelecimentos (Super) usa a dele, e o módulo novo `institution_interfaces` (lista paginada → aba) a
  sua (`/api/institution-interfaces`); sem ALTERAR a aba fica só leitura; rota, módulo e traduções pt/en registrados.
- Provas: `super-delegation-d-pv11.test.ts` (7), D-PV11 em `users.test.ts` (3), `menus-super-delegation.test.ts` (3), cerca do gateway
  (o 26º módulo guardado, único com a guarda delegada), D-PV10 em `feature-flag.middleware.test.ts` (admin da Setes segue as flags; o
  super passa); app `institution_interfaces_tab_test.dart` (2).
- **Gate socrático do delta: 0,74 — PASSOU** (nenhum caminho de escalada nem escrita em schema de outro cliente: o único escritor de
  `tb_user_has_privilege` passa pela trava; `/api/admin`, `/api/interfaces`, `/api/privileges` e `/institutions` seguem do super; o schema
  alvo vem sempre da central). Corrigido na sessão: (1) **desligar a delegação abria a trava** — soft-deletar a tela fazia o
  `findInterfaceKey` (filtro `deleted='N'`) devolver nada e a trava do cadastro ser pulada → agora a busca devolve chave + estado e o
  salvar recusa interface inexistente ou EXCLUÍDA (falha fechado); (3) **trilha** — as duas portas do vínculo e a concessão de privilégio
  registram o que entrou/saiu (`added`/`removed`, a peça devolve a diferença com `FOR UPDATE`) e o autor; (5) a tela delegável NUNCA entra
  pela listagem do contrato (nem para o admin, nem duplicada para o super); (6) catálogo vivo e sem repetidos viraram regra da PEÇA (as
  duas portas); (9) o seed 65 RELIGA a flag que já existe desligada e a conferência passou a olhar a flag (reprovado no descartável); (10)
  o 403 da flag ganhou código (`MODULE_NOT_ENABLED`); (11) o literal 6 virou a constante. Fica como limite: o cache do id da interface não
  expira; duas leituras de "vinculado" (`active IS NULL` na guarda × `active='S'` na aba — anterior ao delta). Questões Q-PV30…Q-PV36
  (§11.4).
- **Gate adversarial do delta, 1ª passada: 0,64 com 2 HIGH — REPROVOU.** A delegação resistiu a tudo (truques de URL e verbo, 8 grafias
  do id na auto-concessão, 14 grafias de "1" no vínculo da Setes, outra institution/"super" forjado, corpo do PUT, alvo inexistente, flags,
  montagem). HIGH (anteriores ao delta, no módulo `users`, mas derrubam a D-PV10/D-PV11): (1) o admin da Setes editava e excluía a conta
  do SUPER (senha, e-mail, `active`) — com ela concedia a si a delegação; (2) o admin de OUTRO cliente trocava senha/e-mail de usuário
  vinculado também à Setes (o login é global). **Corrigido na sessão (INTERINO — Q-PV37)**: `assertAccountManageable` no editar/excluir
  conta — quem não é super só mexe na conta cujos vínculos vivos são TODOS com o próprio estabelecimento e nenhum de perfil super (403
  `USER_MANAGED_BY_SUPER`); as sondas viraram `[CORRIGIDO]` pelo motivo certo (o dublê passou a responder a consulta nova). Restam:
  MEDIUM o admin da Setes troca a senha do usuário que o Super LIBEROU e herda a delegação (Q-PV37); LOW leitura do vínculo da Setes
  (Q-PV35), id 1 literal no mundo do grupo (Q-PV34), telas do Super vinculáveis a cliente (Q-PV32), menu duplicado se a tela delegável
  sair do grupo Super, liberação lida pelo schema do token (defesa em profundidade). Sondas: `adversarial-pv11-gate.test.ts` (35).
- **Gate adversarial do delta, re-prova: 0,76 — PASSOU** (sem HIGH/CRITICAL; nenhum outro caminho de tomar a conta do Super — as outras
  portas da conta, desvínculo, e-mail de login do Super na própria conta, `/auth` por e-mail resistiram). MEDIUM **corrigido na sessão**:
  a barreira contava só vínculos VIVOS — com um vínculo super REVOGADO (`active='N'`) ou um vínculo com outro estabelecimento
  soft-deletado, o admin do cliente trocava a senha e, quando o Super revivesse o vínculo (`setInstitutionLinks` revive a linha), entrava
  como super → agora a barreira conta TODO vínculo existente, vivo ou adormecido (o escopo de 404 segue pelo vínculo vivo com o próprio
  estabelecimento; `listActiveUserLinks` devolve `alive`). Restam: MEDIUM o liberado editável pelo admin da Setes (Q-PV37); MEDIUM
  ANTERIOR e FORA do delta — força bruta no `/auth/change-password` (Q-PV38); LOW a barreira lê os vínculos fora da transação da gravação
  (o Super vinculando a conta no meio não barra a escrita — janela de milissegundos, só o Super abre); os LOW da 1ª passada. Sondas:
  `adversarial-pv11-gate.test.ts` (46; 4 `it.failing` documentam os achados abertos — depois da D-PV12 são 3: a sonda do liberado virou
  teste que FIXA a semântica decidida, `[DECIDIDO D-PV12]`, para ninguém "consertar" depois). Suíte do setes-api depois da re-prova: **2225
  testes, 137 suítes, verdes** (31 pulados — os ao vivo); app 641 · nfse-api 965 (inalterada pelo delta).
- ⚠️ Merge: `admin.repository.ts` conflita com a `grupo-leitores` (ela mudou o corpo de `listInterfacesWithGrant`; aqui virou re-export da
  peça, que já tem o filtro dela) — resolver ficando com a peça; `admin.service.ts` tem a MESMA linha nos dois.

### 11.10 Execução das D-PV19…D-PV40 (2026-10-20 → 2026-10-21, sessão própria, nas WORKTREES `privilegios-crud` — NADA commitado)

**Onde**: `D:\Gestao2027\privilegios\{setes-api,setes-app,nfse-api}` (branch `privilegios-crud`, sobre api 50b928f · app 5a06d73 ·
nfse b62d55b) + worktree NOVA `D:\Gestao2027\privilegios\sql` (branch `privilegios-crud` a partir do `main` 9f4fcf3 do repo `sql`).
Banco: só leitura (sondas e a prova do seed 68 em schema descartável). setes-sync/sincronizador não lidos. ⚠️ O `.env` da worktree do
setes-api NÃO existia (o §11.5 registrou a cópia temporária apagada); foi RECRIADO como link físico do vivo (`mklink /H`) para a suíte
rodar — é ignorado pelo git. Fora de escopo e NÃO tocados: fusão com `privilegios-catalogo` (D-PV14/D-PV42), D-PV33, D-PV43, D-PV46,
merge, publicação, `errors:gen`.

#### 11.10.1 O que foi feito, decisão a decisão

| Decisão | setes-api | setes-app | nfse-api / sql |
|---|---|---|---|
| **D-PV17** | — | `CurrentInterface` ganhou o MENU como fonte (`menu` = módulos carregados, `bindRoute(path)` liga a tela ao item do módulo da rota `/home/<chave>/…`, `listenable`); o `MenuBloc` entrega o menu ao carregar e a `HomePage` religa a cada navegação (`Modular.to.addListener`); `can` = FALSO com o menu carregado e a tela fora dele; menu ausente (deep link antes do `/menus`) libera — a API decide. "Configurações Gerais" liga à interface DELA (`interfaceKey` explícita pelos `arguments`). | — |
| **D-PV19** (3b) | `DELETE /api/users/:id` SAIU (rota/controller/service/repository); `editUser` recusa trocar o e-mail de login — 409 `LOGIN_EMAIL_IMMUTABLE`; "ativo" = `tb_institution_has_user.active` do estabelecimento alvo (admin = JWT; super = `institutionId` do corpo — 400 sem alvo com `active`); `GET /users/:id?institutionId=` devolve o ativo do vínculo em foco (sem foco = `null`); lista = `COALESCE(ihu.active, u.active)` e mostra o vínculo INATIVO; **A-PV13 morreu** — `assertAccountManageable` só protege a conta do super (vivo ou adormecido); o escopo do admin inclui o vínculo INATIVO (é o que ele reativa). | cadastro sem lixeira; e-mail `readOnly` na edição (tela e diálogo do Estabelecimento); checkbox "ativo" só para o admin (na tela global do super não há foco); diálogo do Estabelecimento manda `institutionId` no GET/PUT; `UserDelete` (usecase/evento/bind) removido. | — |
| **D-PV21** | `orders`/`service-orders` `POST /:id/items` e `DELETE /:id/items/:itemId`, `order-returns` `DELETE /:id/items/:itemId` → `privilegeAct(ALTERAR)` (os `PUT` já eram A pelo verbo; negociação `PUT` = A); INSERIR só abre, EXCLUIR só apaga. | item novo/tirar item nas três telas ← ALTERAR. | — |
| **D-PV23/D-PV30** | `state-tax-rates` sob `adminGuard`; `GET/PUT /api/entities/:id/tax` REMOVIDAS (controller/service/swagger); `POST /api/billing/validate` sob FATURAR pela interface do RAMO (`resolveFromBody`). As 3 sondas `it.failing` do gate anterior viraram CERCAS. | — | — |
| **D-PV25/D-PV26** | peça `@shared/auth/configure-privilege` (`configureVerdict`/`canConfigure`/`assertCanConfigure` — veredito CONFIGURAR da interface ALVO pela MESMA peça das guardas); `interface-configs.service`: `target 'I'` = CONFIGURAR em X (a conferência `isAdmin` saiu); `interface-fields.service`: salvar campo = CONFIGURAR em X; os `PUT` dos dois painéis passam na guarda com VISUALIZAR (navegar); `canConfigure` sai em cada config/campo resolvido (aditivo — `GET /:id` e `/key/:k`). | engrenagem (`RegisterConfigButton`) só com `can('CONFIGURAR')`; o painel decide o alvo (`I` × `U`) por `canConfigure` da API, não pelo perfil (`_isAdmin` saiu); o cadastro de usuário oferece o verbo porque o catálogo o traz (seed 68). | **seed 68** (worktree `sql`): CONFIGURAR (11) e CONSULTAR (12) em `tb_privilege`; pares CONFIGURAR DERIVADOS do catálogo (toda interface com config ou campo + `general-configs`); CONSULTAR em bank-slips/orders/service-orders/order-returns; ALTERAR dos painéis `interface-configs`/`interface-fields`/`general-configs` removido (soft — C1); conferência falha alto. **Provado em `prova_seed68_descartavel`** (cópia das 5 tabelas de `setes_central`): 157 → **197** pares (39 CONFIGURAR + 4 CONSULTAR − 3 ALTERAR), 2ª execução idempotente, ALTERAR revivido é removido de novo, par removido pelo Super NÃO revive, par impossível FALHA alto; `setes_central` intacto (157/9) — **NÃO aplicado**. |
| **D-PV27** | `POST /bank-slips/:id/reapply`: a guarda pede VISUALIZAR (chegar ao boleto); a POLÍTICA `bank-slips.reapply-policy.ts` lê a VOZ do evento (`peekReapplyEvent`, sem trava) e exige ALTERAR (R → liquidação) ou CANCELAR (C/V → cancelamento) ANTES de executar. | reaplicar ← `p.kind == 'R' ? ALTERAR : CANCELAR`. | — |
| **D-PV29** | cache do VEREDITO em `require-privilege.ts` por (institution, schema, usuário, interface, privilégio), TTL `PRIVILEGE_VERDICT_CACHE_TTL_MS` (60 s; 0 desliga — a suíte roda desligada pelo setup `test-setup/privilege-cache.ts`), teto 50.000 entradas; invalidado em `setUserPrivileges` (usuário), `setInstitutionInterfaceLink` (institution), `updateUserCascade` com ativo e `setInstitutionLinks` (usuário); sem cache para o super; `privilege-verdict-cache.test.ts` prova guarda/reuso/invalidação por escopo/expiração. | — | — |
| **D-PV31** | `PUT /api/core/theme` sob `adminGuard`. | — | — |
| **D-PV32** | peça `@shared/entity/own-establishment.ts` reescrita: `isOwnEstablishment`, `isOwnEstablishmentDocument` (criação — pelo documento, ANTES da transação), `ownEstablishmentChanges` + `assertOwnEstablishmentChainUnchanged` (compara só o que o corpo TROUXE com a cadeia/tributação gravadas) → 409 `OWN_ESTABLISHMENT_READ_ONLY` com os campos nomeados; os 4 papéis (customers/providers/carriers/collaborators) PULAM a escrita da cadeia e de `tb_entity_tax` quando a entity é a institution e gravam só a linha do papel; `GET` devolve `ownEstablishment`; o 409 `ROLE_IS_OWN_ESTABLISHMENT` da criação SAIU (código removido do catálogo). | `ownEstablishment` nos 4 objetos (fromJson/copyWith/mergeFiscal); peça `OwnEstablishmentFrozen` + `freezeChainTabs` congela as abas da cadeia e a Tributação (as do papel seguem vivas) com a frase `register.ownEstablishment` (pt/en). | — |
| **D-PV34** | peça `@shared/institution-interfaces`: `setInstitutionInterfaceLink(schema, inst, iface, linked)` — leitura TRAVANTE da linha, upsert (corrida de PK inexistente — PADROES §9 regras 10/12), idempotente (`changed:false`); `PUT /api/institution-interfaces/:id/interfaces/:interfaceId {linked}` e `PUT /api/admin/institutions/:id/interfaces/:interfaceId {linked}`; os `PUT` da LISTA inteira saíram das duas portas; trilha só quando muda. | `InstitutionInterfacesSource.setInterface(inst, iface, linked)` nos dois datasources; a aba grava UMA marca e reflete o estado devolvido pela API. | — |
| **D-PV35** | `STRUCTURAL_INTERFACE_KEYS` virou constante da peça (o onboarding a importa); `isSellableInterface` (kind T/R fora do grupo Super); porta delegada: não vendável = 400 `INTERFACE_NOT_SELLABLE`, revogar estrutural = 409 `INTERFACE_STRUCTURAL_LOCKED`, lista só vendáveis (`sellableOnly`); a aba do Super (`/api/admin`) segue com o catálogo inteiro. | — | — |
| **D-PV36** | `featureFlagMiddleware` ignora módulo guardado (`isGatedModule` da própria guarda — `flagApplies`); `insertDefaultFlags` só cria flag para `FLAG_ONLY_MODULES` = core, users, modules, establishment, billing, state-tax-rates; cerca `feature-flags-d-pv36.test.ts` (lista × `listGatedModules()` disjuntas; todo item montado no gateway). O DROP das linhas = DDL à parte. | — | — |
| **D-PV37/D-PV38** | `isOwnVendorInstitution(id)` em `roles.ts` (módulo-folha), re-exportado com `SETES_INSTITUTION_ID` pela peça `@shared/institution-interfaces`; os consumidores (`super-delegation`, `users.service` ×2, `institution-interfaces.service`, `core.service`, `auth.service`) usam o predicado; `GET /api/institution-interfaces/:id` da Setes pelo liberado = 403 `SETES_INTERFACES_SUPER_ONLY` (um predicado nas três portas). | — | — |
| **D-PV39** | `interfaceAcquiredFor(inst, interfaceId)` em `require-privilege.ts`: super escapa (D-PV24) OU tela delegável + Setes OU contrato. | — | — |
| **D-PV24** | `escapesLicense(inst)` = a regra única; `licensedFor`, `interfaceAcquiredFor` e a elegibilidade da Módulos (`listEligibleInterfaces`/`findIneligibleInterfaceIds(…, ignoreLicense)` para o super — catálogo inteiro de kind 'T' FORA do grupo Super) a consomem. | — | — |
| **D-PV40** | `bank-slips` `POST /refresh` e `/:id/refresh` = CONSULTAR (12); `register`/`pay-sandbox` = TRANSMITIR; constante `PRIVILEGE_CONSULTAR` (e `CATALOGAR` 10 reservado) em `privileges.ts`. | consulta silenciosa ao abrir Boletos, "Atualizar com o banco", "Consultar" do boleto e "Consultar" da OS no fisco ← CONSULTAR. | nfse-api: `src/modules/privileges.ts` (`PRIVILEGE_CONSULTAR = 12` — LOCAL até o núcleo recebê-la, Q-PV56); `refresh` por nota e `passScope` da passada conferem CONSULTAR; `transmit` segue TRANSMITIR; `privilegios-d-pv40.test.ts` + cerca lida das rotas. |
| **D-PV20** | `scripts/sql/dpv20-contrato-setes.sql` (NÃO aplicado): lido SÓ LEITURA do dev — 28 flags vivas da institution 1 × catálogo vendável + as 4 estruturais nomeadas = **29** interfaces (14 já contratadas + **15 novas**: bank-accounts, billing, carriers, categories, collaborators, contracts, customers, financial-plans, general-configs, interface-configs, modules, payment-types, providers, salesmen, users); fora: `state-tax-rates` (sem interface), `partnerships` (flag `deleted='S'` — D-PV22), `interface-fields` (sem flag, não estrutural — Q-PV57). Idempotente, por `i18n_key`, conferência falha alto. | — | — |

**Códigos de erro** (catálogo `error-codes.ts`; `npm run errors:gen` NÃO rodou — escreve no banco): novos `LOGIN_EMAIL_IMMUTABLE`,
`OWN_ESTABLISHMENT_READ_ONLY`, `INTERFACE_STRUCTURAL_LOCKED`, `INTERFACE_NOT_SELLABLE`; REMOVIDO `ROLE_IS_OWN_ESTABLISHMENT`; descrição
alterada `USER_MANAGED_BY_SUPER` (sem a cláusula "outro estabelecimento").

**Arquivos** (fora os testes): setes-api — `shared/auth/{privileges,roles,require-privilege,super-delegation,module-privilege-gate,
delegable-interfaces(novo),configure-privilege(novo)}.ts`, `shared/institution-interfaces/index.ts`, `shared/entity/own-establishment.ts`,
`shared/errors/error-codes.ts`, `shared/bank-slip-registration/index.ts`, `gateway/{router,feature-flag.middleware}.ts`,
`modules/{users/*, institution-interfaces/*, admin/{routes,service,repository}, institutions/repository, interface-configs/{service,routes,
privilege-policy}, interface-fields/{service,routes}, modules/{repository,service,controller}, bank-slips/{routes,registration.controller,
registration.service,reapply-policy(novo)}, orders/routes, service-orders/routes, order-returns/routes, entities/{routes,controller,service},
billing/routes, core/{routes,service}, auth/service, customers|providers|carriers|collaborators/{repository,interface}}`, `test-setup/
privilege-cache.ts` (novo) + `package.json` (setupFiles), `scripts/sql/dpv20-contrato-setes.sql` (novo). nfse-api — `modules/privileges.ts`
(novo), `modules/guards.ts`, `modules/nfse/nfse.routes.ts`. setes-app — `shared/session/current_interface.dart`, `shared/register/
register_config_button.dart`, `shared/entity/widgets/own_establishment_frozen.dart` (novo), `shared/institution_interfaces/{source,grant,tab}`,
`shared/interface_config/entity`, `shared/users/{datasource,entity}`, `modules/home/{bloc/menu_bloc,page/home_page}`, `modules/
{orders,service_orders,order_returns}/…/page`, `modules/bank_slips/…/{page,detail_view}`, `modules/service_orders/…/fiscal_section`,
`modules/interface_configs/…/page`, `modules/{customers,providers,carriers,collaborators}/{entity,page}`, `modules/institution_interfaces/
datasource`, `modules/institutions/{datasource,users_tab}`, `modules/users/{module,repository,impl,bloc,event,page}` (usecase `user_delete`
APAGADO), `assets/translations/{pt,en}.json`. sql — `68_privilege_configure_consult_seed.sql` (novo).

#### 11.10.2 Testes

- setes-api: **2324 testes, 142 suítes** (31 pulados — os ao vivo), `npx tsc --noEmit` limpo. Novos: `privilege-verdict-cache` (D-PV29, 11),
  `feature-flags-d-pv36` (cerca + middleware, 7), `configure-privilege` (D-PV24/25/26/39 — veredito, painéis, `canConfigure`, 12),
  `bank-slips-reapply-policy` (D-PV27/D-PV40 pela borda real, 11), `institution-interfaces-d-pv34` (D-PV34/35/37/38 nas duas portas, 10);
  reescritos: `own-establishment-role` (D-PV32 — peça + cerca estática dos 4 papéis), `adversarial-pv11-gate` (marca por marca; D-PV19/36/38
  — 3 `[DECIDIDO]`, 3 `it.failing` que já eram: menu duplicado, força bruta pré-existente, corrida da barreira), `adversarial-pv2-gate`
  (as 3 sondas da Q-PV14/Q-PV25/Q-PV26 viraram cercas; seção D-PV32 com 8 sondas, inclusive "não é oráculo de outro tenant" e a
  varredura dos escritores da cadeia sem a porta avulsa), `users.test` (D-PV19), `privilegios-rotas-d-pv2` (D-PV21/25/27/40; verbos 11/12),
  `super-delegation-d-pv11` (marca), `modules.test` (3º argumento da elegibilidade).
- nfse-api: **1154 testes, 70 suítes** (185 + 2 suítes pulados — os ao vivo), `tsc` limpo; novo `privilegios-d-pv40.test.ts` (6).
- setes-app: `flutter analyze` sem issues; suíte ****655 testes verdes** (28 pulados)**. Novos: `current_interface_test` (D-PV17, 9), `own_establishment_frozen_test`
  (D-PV32, 3); reescritos `institution_interfaces_tab_test` (marca), `crud_privileges_test` (+ menu), `service_order_fiscal_section_test` e os
  `adversarial_r6…r16` (CONSULTAR no setUp — D-PV40).
- Sonda SÓ-LEITURA no banco real (pares que o código consome × catálogo vivo): **145 pares consumidos** (gateway + políticas + ramos +
  CONFIGURAR derivado); faltam no `setes_central` exatamente os do **seed 68** (39 × CONFIGURAR, 4 × CONSULTAR) e os 2 da tela do
  **seed 65** (`institution-interfaces` × V/A — seed não aplicado) — nenhum outro par consumido está fora do catálogo.

#### 11.10.3 Gates (skills `revisar-riscos-sistemicos` + `testar-adversarial`, sobre o delta)

- **Socrático, 1ª passada: 0,68 — REPROVOU** (3 pontos de retrabalho, corrigidos na sessão): (1) **a marca inseria com `INSERT` puro
  depois de `FOR UPDATE` em PK INEXISTENTE** (trava de intervalo, compatível — PADROES §9 regra 12): duas marcas simultâneas do mesmo par
  chegariam as duas ao INSERT → `ER_DUP_ENTRY` → 500 → virou upsert (a tabela só tem a PK como UNIQUE — regra 10); (2) **o cache do
  veredito não varria expirados** → teto `VERDICT_CACHE_MAX` (50.000; acima disso limpa); (3) **o escopo do admin era "vínculo VIVO"** —
  com o ativo no vínculo (D-UC2) o admin não alcançava o usuário INATIVO para reativá-lo (404 no GET e no PUT) → o escopo passou a
  "vínculo não excluído" (`listActiveUserLinks` devolve `deleted`). Pontos que pedem decisão: Q-PV55…Q-PV58 (abaixo).
  **Re-score: 0,76 — PASSOU.**
  ```json
  { "alvo": "D-PV19…D-PV40 nas três APIs/app (setes-api, nfse-api, setes-app) + seed 68 + script D-PV20",
    "score": 0.76,
    "pontosAbertos": [
      "Com vários processos Node (Onda 4), uma revogação de privilégio feita num processo vale nos outros só na expiração do TTL de 60 s — o que acontece se a janela de 60 s cair numa ação irreversível (faturar, transmitir)? (D-PV29: limite registrado; a institution já está na chave)",
      "A A-PV13 morreu: o admin do cliente X troca a senha de um login que o Super também vinculou ao cliente Y — até a onda 0 do convidado (D-UC6, senha do titular), qual é a exposição real? (vínculo cruzado só o Super cria — Q-PV55)",
      "A conferência 'mudou?' da D-PV32 lê a cadeia pelo pool ANTES da transação do papel: duas edições simultâneas do próprio estabelecimento (uma pelo Meu Estabelecimento) podem fazer o papel passar com dado que já mudou — o que se perde é só o 409 informativo, nunca uma escrita (a cadeia não se grava pelo papel)",
      "O menu virou a fonte dos privilégios no app (D-PV17): a tela montada ANTES do /menus chegar fica com `can` liberado até o próximo rebuild — quem decide é a API; vale registrar como limite de UX ou forçar o rebuild?"
    ],
    "dicaArquitetural": "Veredito de privilégio, licença e 'adquirida' saem de UMA peça (`require-privilege`): toda conferência nova entra nela, nunca ao lado.",
    "questoesParaRodada": ["Q-PV55", "Q-PV56", "Q-PV57", "Q-PV58"] }
  ```
- **Adversarial, 1ª passada: 0,74 com 1 MEDIUM — REPROVOU pelo achado** (corrigido na sessão): **a rota do reaplicar estava ABERTA na
  guarda** (`openRoute`, para a política decidir pela voz) — quem não tem NEM VISUALIZAR em boletos sondava a existência de apresentação/evento
  (404 × 403 antes da política) → a guarda passou a pedir VISUALIZAR (chegar ao boleto) e a política segue decidindo o EFEITO (D-PV27 mantida);
  sonda virou teste (`bank-slips-reapply-policy.test.ts`). Resistiu: grafias do id da Setes nas três portas (D-PV38), corpo/`interfaceId`
  inválidos e fora do catálogo na marca, estrutural/não vendável pela porta delegada (o Super também obedece à regra da porta), idempotência
  da marca, truques de URL/verbo da D-PV11 refeitos para a marca, A-PV13 morta sem reabrir a tomada da conta do SUPER (vínculo super vivo ou
  adormecido segue barrando), DELETE de usuário = 404 para todos, e-mail de login imutável (inclusive para o do Super), reaplicar com
  TRANSMITIR/CONSULTAR negado, consultar com TRANSMITIR negado (nos boletos e no fisco), CONFIGURAR da interface ALVO (ALTERAR/CONFIGURAR
  do painel não configuram Clientes), super grava config em tela não contratada (D-PV24 — latente), D-PV32: 6 grafias do id, 409 sem vazar
  id/CNPJ/schema, outro tenant não é oráculo, `personType 'N'` não alcança a entity do emitente, varredura dos escritores da cadeia.
  Restam (LOW, registrados): a janela do deep link no app; o cache entre processos (limite da D-PV29); `tb_user.active` (credencial) segue lido
  no login e nunca mais escrito pelo cadastro — conta que já estava `'N'` fica inativa em TODOS os estabelecimentos (limite — a reativação é
  do operador até a frente do convidado decidir); a flag `institution-interfaces` do seed 65 nasce MORTA (D-PV36 — módulo guardado).
  **Re-prova: 0,80 — PASSOU** (sem HIGH/CRITICAL).
  ```json
  { "alvo": "guarda/políticas/peças das D-PV19…D-PV40 pela borda HTTP real (setes-api e nfse-api, banco dublado) + sondas estáticas",
    "score": 0.80, "passou": true,
    "vulnerabilidades": [
      { "tipo": "DATA_EXPOSURE", "severidade": "MEDIUM", "descricao": "POST /bank-slips/:id/reapply aberto na guarda: sem privilégio algum em boletos, o 404/403 da política revelava a existência de apresentação/evento — CORRIGIDO (VISUALIZAR na guarda)", "evidencia": "provado (bank-slips-reapply-policy.test.ts)" },
      { "tipo": "AUTH_BYPASS", "severidade": "LOW", "descricao": "app: tela montada antes do /menus chegar libera os botões até o próximo rebuild (a API decide)", "evidencia": "analisado (current_interface.dart)" },
      { "tipo": "RACE_CONDITION", "severidade": "LOW", "descricao": "revogação de privilégio vale nos OUTROS processos só na expiração do TTL (60 s) — limite da D-PV29 até a Onda 4", "evidencia": "analisado (require-privilege.ts)" },
      { "tipo": "DATA_EXPOSURE", "severidade": "LOW", "descricao": "tb_user.active deixou de ser escrito pelo cadastro: conta já 'N' fica inativa em todos os estabelecimentos até o operador", "evidencia": "analisado (users.repository.ts / auth.service.ts)" }
    ],
    "casosNaoTestados": [
      "Corrida real de duas marcas do MESMO par (o upsert resolve por construção — regra 10; sem prova em banco descartável nesta sessão)",
      "Passeio logado (engrenagem só com CONFIGURAR, boletos com CONSULTAR, aba de interfaces por marca, papel do próprio estabelecimento congelado) — depende do seed 68 e da D-PV20 aplicados"
    ] }
  ```

#### 11.10.4 Assunções executadas (A-PVn — ratificar)

- **A-PV16** — o ALTERAR de `general-configs` saiu do catálogo junto com o dos dois painéis: a exceção da A-PV8 (ALTERAR da "Configurações
  Gerais" abria o painel dela) foi substituída pelo CONFIGURAR nela (D-PV25 regra 2) — par sem consumidor é defeito (C1). Se o Valdo quiser
  manter o ALTERAR lá, o seed 68 tira a chave da lista de remoção.
- **A-PV17** — reaplicar: VISUALIZAR na guarda do roteador (chegar ao boleto) + o privilégio do EFEITO na política (gate adversarial; a
  D-PV27 fala só do efeito).
- **A-PV18** — D-PV24 na Módulos: para o super o catálogo inteiro de kind 'T' FORA do grupo Super (o menu do cliente nunca renderiza o grupo
  Super — regra do menu, não licença); a decisão diz "catálogo inteiro de kind 'T'".
- **A-PV19** — "ativo" do usuário: `GET /users/:id` sem foco (super na tela global) devolve `active: null` e a tela esconde o checkbox; a lista
  sem foco cai em `tb_user.active` (a credencial). O PUT do super com `active` exige `institutionId`.
- **A-PV20** — D-PV32: "tenta mudar" = diferença entre o que o corpo TROUXE e o gravado (campo ausente e lista ausente não são mudança —
  mesma convenção da cadeia); a comparação normaliza `''`/`null` e números.
- **A-PV21** — D-PV20: `interface-fields` ficou FORA do contrato da Setes (sem flag e não estrutural) — ver Q-PV57.

#### 11.10.5 Questões — Rodada 6 (aguardam o Valdo; nenhuma trava a entrega)

- **Q-PV55 — a janela da A-PV13 morta**: até a onda 0 do convidado (D-UC6: o admin define só a senha INICIAL; "minha senha"/"esqueci" do
  titular), o admin do cliente X pode redefinir a senha de um login que o Super também vinculou ao cliente Y (ou à Setes) e entrar em Y com
  o perfil dele. Hoje vínculo cruzado só o Super cria. (a) **aceitar como limite até a onda 0** (merge desta onda antes da do convidado —
  a ordem já prevista); (b) interino: o admin só redefine senha de conta cujos vínculos são todos com o próprio estabelecimento (a A-PV13 só
  para a SENHA); (c) a onda 0 do convidado entra antes do merge. **Rec.: (a)** — é o que a D-PV19 decidiu, com a trilha no log.
- **Q-PV56 — a constante CONSULTAR da nfse-api**: vive em `nfse-api/src/modules/privileges.ts` porque a worktree não toca o núcleo
  (`fiscal-api/src/erp/facts.ts`, junção para a árvore viva). (a) **mover para o núcleo na fusão/janela** (ao lado de TRANSMITIR/CANCELAR) e
  apagar a local; (b) deixar na nfse-api. **Rec.: (a)**.
- **Q-PV57 — `interface-fields` e `general-configs` no contrato**: a D-PV20 dá `general-configs` à Setes (nomeada) mas não `interface-fields`
  (sem flag, não estrutural); o onboarding dá as 4 estruturais (sem `general-configs`), então a D-PV35 a deixou fora da lista de estruturais.
  (a) **como está** — o Super contrata o painel de campos a quem precisar (D-PV11); (b) `interface-fields` e `general-configs` viram
  estruturais (onboarding + D-PV20 + lista da D-PV35). **Rec.: (a)**.
- **Q-PV58 — Módulos para o super (D-PV24)**: o grupo Super ficou fora da elegibilidade mesmo para o super (regra do menu do cliente).
  (a) **manter**; (b) "catálogo inteiro de kind 'T'" ao pé da letra, inclusive o grupo Super. **Rec.: (a)**.

#### 11.10.6 Limites conhecidos (conhecimento negativo)

- O cache do veredito (D-PV29) é por PROCESSO; a invalidação por salvar privilégio/contrato/vínculo vale só nele — a Onda 4 ganha roteiro
  (TTL curto é a defesa). Super nunca entra no cache.
- A flag técnica `institution-interfaces` da Setes (seed 65) e as flags dos módulos guardados ficam MORTAS (D-PV36) até o DDL que as apaga.
- `tb_user.active` (credencial) deixou de ser escrito pelo cadastro; o login ainda o lê.
- O app lê os privilégios do MENU: a tela aberta por deep link antes do `/menus` chegar fica liberada até o próximo rebuild (a API decide).
- A sonda dos pares × catálogo foi um script da sessão (rodado de dentro da worktree e apagado); a cerca permanente é a da D-PV9
  (`privilegios-catalogo`) — na fusão, `CONSUMED_PRIVILEGES` ganha: CONFIGURAR em toda interface com config/campo (dinâmico pela peça
  `configure-privilege`), CONSULTAR em bank-slips/orders/service-orders/order-returns, ALTERAR/CANCELAR do reaplicar (política), FATURAR do
  `validate` (ramo), a primitiva `interfaceAcquiredFor` e, no app, `RegisterConfigButton` (peça compartilhada → telas pelo grafo de import).

#### 11.10.7 Roteiro de publicação revisto (só com o "vai")

1. Aplicar `scripts/sql/dpv20-contrato-setes.sql` (D-PV20 — 15 interfaces novas no contrato da Setes; conferir de novo as 14 e as flags).
2. Aplicar o seed 65 (tela delegável) e DEPOIS o seed 68 (CONFIGURAR/CONSULTAR) em `setes_central` — reconferir o número do seed (66
   merchandise, 67 recuperação).
3. Fusão com `privilegios-catalogo` (D-PV14/D-PV15/D-PV42): o adaptador lê `listGatedRoutes()` + as entradas do §11.10.6; `error-codes.ts`
   junta as listas (aqui: +4 códigos, −1).
4. Merge da API + `npm run errors:gen` + nfse-api reiniciada à mão (Q-PV56: mover a constante ao núcleo nessa janela) + app publicado
   JUNTO (janela única — D-PV28).
5. Passeio logado: engrenagem/CONFIGURAR, boletos/CONSULTAR, aba de interfaces por marca, papel do próprio estabelecimento, usuário sem
   lixeira e e-mail imutável.

## 12. Cerca da D-PV9 — lista única + cerca + conferência no boot (2026-10-18, sessão própria, em WORKTREE — NADA commitado)

**Onde**: `D:\Gestao2027\privilegios-catalogo\setes-api` (branch `privilegios-catalogo`, base `main` f53a618). Só o setes-api muda;
nfse-api, fiscal-api, setes-app e o repo `sql` são LIDOS. Na pasta `privilegios-catalogo\` há junções `nfse-api` e `fiscal-api` (os testes
da F2a leem `../`) e o `.env` da worktree é um link físico do `.env` vivo (gitignored). Banco: só SELECT, sessão `READ ONLY`.
setes-sync/sincronizador não lidos. Coordenado por mensagem com a sessão da onda D-PV2 (§11.8 item 2).

### 12.1 O que foi feito

- **Lista única** `src/shared/auth/privilege-catalog.ts` — `CONSUMED_PRIVILEGES`, cada par com os consumidores EXATOS (`api` guarda/política
  do setes-api · `nfse` guarda da nfse-api · `app` botão) e onde: orders FATURAR/CANCELAR/TRANSMITIR · service-orders FATURAR/CANCELAR/
  TRANSMITIR · order-returns FATURAR (+ CANCELAR/TRANSMITIR ausentes por decisão — A-PV12) · settlements ALTERAR (o C1) e DESCONTO ·
  bank-charge-agreements DESCONTO = 12 pares (10 exigidos). Mais: `PRIVILEGE_ID` (nome = `tb_privilege.description`, que o app compara),
  `ORDER_BRANCH_INTERFACES` (domínio da `vw_order_interface`), `MENU_PRIVILEGE` (o menu consome VISUALIZAR em toda tela do cliente —
  REGRA, não par) e a conferência PURA `privilegeCatalogProblems`.
- **Cerca** `src/__tests__/privilege-catalog-fence.test.ts` (predicado `src/test-setup/privilege-fence.ts`, ~55 sondas):
  - setes-api por AST — primitivas `requirePrivilege`/`requirePrivilegeFor`/`userHasPrivilege`; função que REPASSA interface/privilégio por
    parâmetro vira primitiva derivada, seguida pelo SÍMBOLO (inclusive pelos barris `export *` das peças `@shared`); interface e privilégio
    resolvidos pelo ESCOPO LÉXICO (`PRIVILEGE_*` só vale importado de `@shared/auth/privileges`); resolver do `requirePrivilegeFor` = o
    símbolo de `billing.interface-resolver.ts`;
  - nfse-api — `requireBranchPrivilege` (o RAMO) e `passScope`; o núcleo `fiscal-api/src/erp/facts.ts` conferido (ids + `OrderInterfaceKey`);
  - setes-app por tokenizador de Dart (textos, raw, triplos, interpolação, bloco aninhado) — `CurrentInterface.can('NOME')` (ou `static
    const` de texto); módulo → i18n_key pelo `interfaceRoutes`; peça COMPARTILHADA → telas DERIVADAS do grafo de import (a exceção é
    EXCLUSÃO com motivo — subtrai, nunca substitui);
  - reprova: par fora da lista · entrada sem o consumidor exato ("não apodrece") · consumo ilegível · `PRIVILEGE_*` solto · SQL de
    `tb_user_has_privilege` por CONTAGEM por arquivo · leitores da concessão (`getUserPrivileges`, `getAllInterfacePrivileges`…) fora dos
    arquivos registrados · export novo das implementações (`require-privilege.ts`, `guards.ts`) sem classificação · `absentBy` em par de
    botão · `CurrentInterface.value` lido direto · `can` sem chamada (tear-off).
- **Ao vivo** `src/__tests__/privilege-catalog-live.test.ts` — lista ⊂ catálogo do banco (sessão READ ONLY provada): fecha o triângulo
  código → lista → catálogo no JEST, antes do deploy.
- **Boot** `src/shared/auth/assert-privilege-catalog.ts`, chamado em `server.ts` depois dos gatilhos da F2a — 4 SELECT no `setes_central`
  pelo MESMO predicado do `getAllInterfacePrivileges` (os botões do admin/super). Uma linha `[ALARME D-PV9]` por classe: par faltando ·
  nome trocado (comparado como o app: `toLowerCase`, sem trim) · nome repetido em outra linha · telas do cliente sem VISUALIZAR (C2) ·
  `i18n_key` repetida ou fora da forma canônica (comparada como o banco: sem caixa, acento e espaço no fim) · marca `absentBy`
  desatualizada. NUNCA lança (nem com getter de `.message` que lança, nem com logger quebrado) — sobe assim mesmo.
- **Script** `scripts/check-privilege-catalog.ts` — a mesma conferência fora do boot, READ ONLY, sai 1 com alarme.
- **Regra**: skills `setes-api/skills/novo-modulo.md` (item 5) e `setes-app/skills/criar-formulario-cadastro.md` (item 6),
  `setes-api/ARQUITETURA_MODULOS_API.md` ("Privilégio de AÇÃO").

### 12.2 Prova do C1 (ao vivo, só leitura)

O seed 64 já estava aplicado (§10). Reconstruído o catálogo de ANTES pelo MESMO predicado do boot sem as linhas que o seed criou
(`created_at < '2026-10-18 01:34'`): **23 pares → alarme EXATO `settlements × ALTERAR (2)`**, e em linha própria as 28 telas sem VISUALIZAR
(C2). Catálogo atual (157 pares) → nenhum alarme. Os testes puros repetem: catálogo de 23 = só o C1; os 157 pares lidos do próprio
`sql/64` = limpo; o boot com o catálogo de 23 grita as duas linhas.

### 12.3 Testes e gates

- setes-api, rodada FINAL (depois de todas as correções dos gates): suíte completa **130 arquivos · 2085 verdes (31 pulados) · 0 falha**
  (as 3 suítes da D-PV9: 89, inclusive a ao vivo); `npx tsc --noEmit` limpo.
- **Gate socrático** 0,72 → **0,80** ✅ (corrigidos: primitiva desconhecida — exports classificados, derivada pelo símbolo —; comparação de
  nome igual à do app; ids do núcleo; `absentBy` × botão; triângulo no jest; exclusão que subtrai).
- **Gate adversarial** 0,66 ✗ (5 MEDIUM de falso negativo da cerca, provados: constante resolvida pelo NOME sem escopo — lia o par
  ERRADO —, resolver aceito pelo nome, tear-off no Dart, `/*` dentro de texto, SQL registrado por arquivo) → corrigidos com sonda →
  re-gate **0,78** ✅ (MEDIUM novo: derivada importada pelo BARRIL some — corrigido depois, com sonda; LOWs baratos também: `loose` da
  nfse-api, `.can` citado em texto, `part`/import condicional no grafo, acento na `i18n_key`).
- A cerca da F2a (`f2a-a3-cerca`) pegou a própria entrega: o rótulo `'nfse-api'` em literal do `src/` violava a D-F4 → consumidor `'nfse'`.

### 12.4 Assunção executada (ratificar)

- **A-PV12 — RATIFICADA (Valdo, 2026-10-20; `order-returns × CONSULTAR` entra na mesma marca `absentBy` pelo mesmo motivo — D-PV40)** — `order-returns × CANCELAR` e `× TRANSMITIR` são consumidos só pela guarda do RAMO (`/billing/cancel…` e a nfse-api
  resolvem a interface pela `vw_order_interface`) e ficam AUSENTES do catálogo por decisão (`absentBy`): cancelar devolução é a Onda 2 do
  cancelamento (`invoice-cancel.ts:163` responde 409) e devolução é NF-e (a nfse-api não emite por ela). A tela não tem o botão. A marca
  deixa de valer se um botão consumir o par.

### 12.5 Questões — Rodada 4 (gates da D-PV9; nenhuma trava a entrega)

- **Q-PV16 — fusão com a D-PV2** [→ **D-PV14 = (a)**]: (a) **os módulos guardados entram pela `listGatedRoutes()` da D-PV2** (uma verdade só) e a lista à mão
  fica para o que não se deriva (atos fora do roteador, políticas, guardas da nfse-api, botões do app); quem chegar por último ao `main`
  escreve o adaptador (combinado por mensagem); (b) lista 100 % à mão (~130 entradas) com a cerca conferindo igualdade. **Rec.: (a)**.
- **Q-PV17 — o C1 em tempo de execução** [→ **D-PV15 = (a), EXECUTADA** (§12.8)]: tirar um par da lista pela tela Interfaces (o `syncInterfacePrivileges` apaga o que não veio no
  array) ou renomear um privilégio consumido na tela Privilégios recria o C1 na hora — o boot só vê no próximo restart. (a) **as duas
  telas recusam (409, nomeando o consumidor)** — integridade do catálogo, não autorização, então não contradiz a D-PV3; (b) só pedem
  confirmação; (c) limite conhecido. **Rec.: (a)**.
- **Q-PV18 — publicação bloqueante** [→ **D-PV16 = (a), EXECUTADA** (§12.8)]: (a) **o roteiro de publicação (deploy do setes-api/app e aplicação de seed de privilégios) roda
  `scripts/check-privilege-catalog.ts` e para com exit 1** — a D-PV9 só proíbe o BOOT de recusar subir; (b) só documentado. **Rec.: (a)**.
- **Q-PV19 — o teste ao vivo na suíte padrão** [→ **D-PV41 = (a)**, confirmada pelo Valdo em 2026-10-20: *"(a), siga a recomendação"* — obrigatório na suíte, sem código novo]: (a) **obrigatório, como está** — a suíte do setes-api já exige o banco em dezenas de
  suítes, e o banco do dev é o de produção (vermelho = o seed não foi ao banco ANTES do código); na Onda 4 (bancos separados) ele prova só
  o catálogo do dev e o roteiro (Q-PV18) cobre a produção; (b) opt-in no molde do `F2A_ADV_LIVE`. **Rec.: (a)**.
- **Q-PV20 — a interface de um botão no app** [→ **D-PV17 = (a)**, na entrega da Q-PV13]: hoje é a do ÚLTIMO item clicado no menu (`CurrentInterface`), não a do módulo da tela:
  pedido → "Devolver" navega para `/home/order-returns/` sem trocar a interface (`order_page.dart:534`), então o FATURAR da devolução olha
  os privilégios de `orders` (a cerca e a Q-G22 assumem a do MÓDULO). (a) **a do módulo**: navegação entre módulos troca o `CurrentInterface`
  pelo item do menu da tela de destino (sem o item no menu, `can` = falso) — junto da Q-PV13 da D-PV2 (privilégios de outras interfaces no
  app); (b) manter (a API decide). **Rec.: (a)**, na entrega da Q-PV13.

### 12.6 Limites conhecidos (conhecimento negativo)

- **O verde certifica uma COMBINAÇÃO de checkouts**: o setes-api da worktree + nfse-api/fiscal-api/setes-app/sql achados pelo ancestral
  mais próximo (ou `NFSE_API_DIR`/`SETES_APP_DIR`/`FISCAL_API_DIR`/`SQL_DIR`). Nesta rodada: as junções para o `main` da nfse-api e do
  núcleo, `D:\Gestao2027\setes-app` (main) e `D:\Gestao2027\sql`. Um merge no app pode deixar o setes-api vermelho sem tocar nele; CI de
  repositório único precisa das 4 variáveis.
- **Repositórios varridos = conjunto FECHADO** (setes-api, nfse-api, setes-app): guarda nova no núcleo `fiscal-api` ou na nfe-api precisa
  entrar no predicado (do núcleo hoje só os ids e o domínio do ramo são conferidos).
- Evasão DELIBERADA não é alvo: chave computada (`obj['require'+'Privilege']`), `export { X as Y }` sobre const não exportada, `var`
  içada (o tsc estrito recusa o uso), envoltório novo de um leitor da concessão dentro de arquivo já registrado, `MenuInterface.privileges`
  lido fora do `can` (objeto vindo do bloc).
- O boot só vê no próximo restart (o setes-api de produção roda sem watch); antes do deploy, quem confere é o teste ao vivo e o script.
- O app compara o privilégio pelo NOME e a API pelo id: renomear na tela Privilégios esconde o botão de todos (Q-PV17).

### 12.7 Publicação (só com o "vai")

1. Merge da branch `privilegios-catalogo` no `main` do setes-api — a árvore viva roda `tsx watch` (= deploy ao salvar); o boot passa a
   conferir (contra o catálogo de hoje sai OK).
2. Se a onda D-PV2 entrar antes ou junto: o adaptador do §11.8 item 2 (pares de `listGatedRoutes()`, `privilegeAct` como consumidor,
   classificação de `licensedFor`/`privilegeVerdict`/`denyPrivilege`/`resolveInterfaceId`, os sites do `crud_privileges.dart` com as
   exclusões de interface-configs/interface-fields, que só têm 2,6 no catálogo). Varredura só-leitura da worktree dela feita: 0 consumo
   ilegível; os pares do app estão todos no seed 64.
3. Ao remover a worktree: apagar as junções `privilegios-catalogo\{nfse-api,fiscal-api}` e o link do `.env`.

### 12.8 Rodada 5 executada (2026-10-18 — D-PV15 e D-PV16; mesma worktree, NADA commitado)

- **D-PV15 (Q-PV17)** — as telas do Super Interfaces e Privilégios RECUSAM (409, `fields[]` nomeando cada consumidor) o que recriaria o
  C1 na hora. Peça pura no fim de `src/shared/auth/privilege-catalog.ts` (`isMenuScreen` = o predicado do menu · `requiredPairsOf` = os
  pares consumidos sem os ausentes por decisão + VISUALIZAR de tela do menu · `privilegeConsumersOf` · `interfaceCatalogViolations` ·
  `privilegeCatalogViolations` · `assertNoCatalogViolation`), chamada em `interfaces.service.ts` (`assertCatalogKept` — criar, editar,
  excluir) e `privileges.service.ts` (criar, editar, excluir), ANTES de gravar. Recusa: (1) tirar par consumido — inclusive o
  `PUT /api/interfaces/:id` SEM `privilegeIds`, que zerava todos os vínculos (armadilha anterior à cerca); (2) tela do menu sem
  VISUALIZAR (na criação e ao virar R → T — D-GE19); (3) trocar/excluir a chave de interface que o código usa; (4) a chave REPETIDA em
  outra interface viva (a guarda resolve por `LIMIT 1`; comparação pela colação da coluna); (5) renomear/excluir privilégio consumido
  pelo NOME (só a caixa pode mudar — o app compara `toLowerCase` sem trim) e (6) dar a outra linha o nome de um consumido. Códigos novos
  `CATALOG_PAIR_IN_USE` · `INTERFACE_KEY_IN_USE` · `PRIVILEGE_IN_USE` (rodar `npm run errors:gen` na publicação — escreve em
  `setes_central.tb_error_catalog`). A guarda lê a MESMA lista da cerca e do boot: par novo na lista passa a ser protegido sem código
  novo (na fusão com a D-PV2, a lista em tempo de execução inclui os pares de `listGatedRoutes()` — D-PV14). Vale também para o SUPER
  (A-PV14 — é integridade do catálogo, não permissão; a D-PV3 trata das verificações de PERMISSÃO).
- **D-PV16 (Q-PV18)** — `apps/web/build-web.ps1` (setes-app, worktree `D:\Gestao2027\privilegios-catalogo\setes-app`, branch
  `privilegios-catalogo`) roda, ANTES do `flutter build`, a conferência do setes-api publicado junto (`-SetesApiDir`, padrão o irmão;
  `-CatalogEnvFile` = o `.env` do DESTINO) e PARA com exit ≠ 0; `-CheckOnly` faz só as conferências (URLs + catálogo). Provado no
  PowerShell 5.1: OK contra o dev; sem o setes-api → para; conferência com alarme → para. Atalho `npm run check:privileges` no setes-api.
  Roteiro do seed de privilégios: depois do `apply-seed`, `npm run check:privileges` tem de sair 0 (o §8 já pedia conferir os pares).
- **D-PV14 (Q-PV16)** e **D-PV17 (Q-PV20)** — sem código nesta worktree: D-PV14 vale na fusão com a D-PV2 (quem chegar por último ao
  `main` escreve o adaptador); D-PV17 entra na entrega da Q-PV13 da D-PV2 (o app troca o `CurrentInterface` pela tela de destino ao
  navegar entre módulos). Ambas avisadas à sessão da D-PV2.
- **Gates do delta** — socrático **0,76 ✅**; adversarial **0,72 ✅** → corrigidos os 3 MEDIUM e os LOW baratos → re-prova **0,80 ✅** (sem
  HIGH) → o MEDIUM novo da re-prova também corrigido. O que os gates acharam e já está no código, com teste:
  - a chave comparada EXATA para "a chave mudou" (o app procura a rota com a chave exata — trocar só caixa/acento/espaço do fim
    escondia a tela de todos); o DTO só aceita `^[a-z0-9]+(-[a-z0-9]+)*$`; a colação do banco fica só para a chave REPETIDA;
  - tela do menu que o código usa não vira recurso (R) nem vai ao grupo Super (o botão ficaria inalcançável);
  - CONSERTO de duplicata (sem ele, duas linhas com a mesma chave consumida só saíam por SQL): excluir ou renomear uma delas passa quando
    a OUTRA é equivalente — chave exata, o mesmo lugar no menu e todos os pares, inclusive o VISUALIZAR; a chave repetida só se confere
    quando a chave é nova na linha;
  - publicação: o `build-web.ps1` roda também a CERCA do app desta árvore contra a lista do setes-api irmão (`SETES_APP_DIR`), usa o
    `npm run` local, passa `DOTENV_CONFIG_OVERRIDE` (o `.env` vence o shell), mostra o banco conferido, o `.env` de destino tem de trazer
    `DB_HOST`/`DB_PORT`/`DB_USER`/`DB_PASSWORD` (`scripts/lib/require-target-env.ts` — senão a saída 2, com mensagem própria), caminhos
    literais, e avisa quando confere pelo `.env` do irmão. Provado no PowerShell 5.1 (OK; sem setes-api; alarme; `.env` sem banco).
  - Testes (rodada FINAL, depois de todas as correções): setes-api **131 arquivos · 2113 verdes (31 pulados) · 0 falha** (as 4 suítes
    da D-PV9: 117); `tsc` limpo. Ordem da publicação escrita no ps1: seed dos pares → setes-api → app.
- **Limites conhecidos do delta**: dois PUTs concorrentes na MESMA interface ainda podem gravar um estado que nenhum validou (leitura sem
  trava; `updateInterface` e `syncInterfacePrivileges` fora de transação) — telas só do Super, raro; o 409 traz o texto `where` da lista
  (só o super vê as duas telas); seeds e o `bootstrap-db.ts` não passam pela guarda (o teste ao vivo e o boot cobrem).

#### Questões — Rodada 6 (gates do delta D-PV15/D-PV16; nenhuma trava a entrega)

- **Q-PV50 — o escopo da guarda de chave**: hoje ela congela só as chaves que o código CONSOME por par (orders, service-orders,
  order-returns, settlements, bank-charge-agreements). Renomear `customers` → `clientes` na tela Interfaces passa: o app abre o
  `/home/pending/` para todos e as configs/campos da interface voltam ao padrão (são presos à chave), sem alarme. (a) **a guarda congela
  TODA chave que o código usa para abrir/montar a tela** — a lista das telas do app (`interfaceRoutes`, conferida pela cerca), as chaves
  com configs/campos e `general-configs`; renomear passa a exigir código + seed coordenados; (b) manter só as dos pares (renomear tela é
  ato raro do Super). **Rec.: (a)** — é a mesma deriva silenciosa do C1, pela porta da chave.
- **Q-PV51 — `i18n_key` única no BANCO**: a guarda confere a chave repetida no service (SELECT antes do INSERT/UPDATE — corrida possível;
  seed não passa por ela). (a) **coluna gerada `CASE WHEN deleted='N' THEN i18n_key END` + UNIQUE**, provada em schema descartável, pelo
  PADROES_BANCO + revisar-ddl, em entrega própria; (b) limite conhecido (o boot e o teste ao vivo acusam). **Rec.: (a)** — tabela pequena,
  só o Super escreve; fecha a corrida e o seed de uma vez.
- **Q-PV52 — `-CatalogEnvFile` obrigatório**: hoje o padrão é o `.env` do setes-api irmão (com aviso) — o destino de hoje É o dev (nada em
  produção). (a) **obrigatório quando a publicação for para outro ambiente (Onda 4)** — o roteiro do deploy na SaveInCloud passa o `.env`
  do destino; (b) obrigatório já. **Rec.: (a)**.
- **Q-PV53 — conserto de duplicata × contrato dos clientes**: o conserto deixa sair a linha EQUIVALENTE, mas os contratos
  (`tb_institution_has_interface`, `tb_module_has_interface`) apontam pelo id — se a linha que sai é a contratada, os clientes perdem a
  tela mesmo com a outra equivalente. (a) **antes de deixar sair, conferir em cada schema de cliente que a linha não é contratada** (ou
  migrar o vínculo para a que fica, no mesmo ato); (b) limite conhecido — duplicata de chave não existe hoje (conferido) e a criação está
  barrada. **Rec.: (b)** enquanto a Q-PV51 (a) não entra; com o UNIQUE, a duplicata deixa de existir.

### 12.9 Retomada da cerca (prompt curto — estado salvo em 2026-10-18, fim da sessão)

> **2026-10-18 (noite) — Fase 1 do plano de retomada (`prompts/plano_retomada_2026-10-18.md`, Valdo: "Commita")**: a cerca está COMMITADA
> na branch `privilegios-catalogo` — setes-api **8b1fe27** (os 18 caminhos abaixo) · setes-app **53a1497** (`build-web.ps1`; `.dart_tool/*`
> fora) — sem push e sem merge. O item 3 ("Commit, só com o 'vai'") está CUMPRIDO; o "NADA commitado" abaixo está SUPERADO só nesse ponto.
> Decisões (item 1), numeração (2), publicação (4) e limpeza (5) seguem valendo.

**Onde está o trabalho** (NADA commitado; as duas worktrees saem do `main` e ficam no disco até o "vai"):

- `D:\Gestao2027\privilegios-catalogo\setes-api` — branch `privilegios-catalogo`, base `main` f53a618.
  - Alterados: `package.json` (`check:privileges`), `src/server.ts` (boot), `src/shared/errors/error-codes.ts` (3 códigos),
    `src/modules/interfaces/interfaces.{dto,repository,routes,service}.ts`, `src/modules/privileges/privileges.{routes,service}.ts`.
  - Novos: `src/shared/auth/privilege-catalog.ts`, `src/shared/auth/assert-privilege-catalog.ts`, `src/test-setup/privilege-fence.ts`,
    `src/__tests__/privilege-catalog-{fence,boot,live,guard}.test.ts`, `scripts/check-privilege-catalog.ts`,
    `scripts/lib/require-target-env.ts`.
- `D:\Gestao2027\privilegios-catalogo\setes-app` — branch `privilegios-catalogo`, base `main` a450909. Só `apps/web/build-web.ps1`
  (UTF-8 com BOM e CRLF — o PowerShell 5.1 precisa do BOM).
- Fora do git: na pasta `privilegios-catalogo\`, as junções `nfse-api` e `fiscal-api` (os testes da F2a leem `../`); dentro da worktree
  do setes-api, o `.env` (gitignored), que é um link físico do `.env` vivo.
- Estado conferido ao salvar (2026-10-18): `npx tsc --noEmit` limpo; `npx jest src/__tests__/privilege-catalog src/__tests__/swagger-parse`
  = 5 suítes · 119 verdes (fence, boot, live, guard e swagger), inclusive a ao vivo. A suíte completa da rodada final deu 131 arquivos ·
  2113 verdes · 31 pulados · 0 falha.

**O que falta, em ordem**:

1. **Decisões do Valdo**:
   - **A-PV12** (§12.4, a relembrar): devolução × CANCELAR/TRANSMITIR ficam FORA do catálogo de propósito. Cancelar devolução é a
     Onda 2 do cancelamento (hoje dá 409), devolução é NF-e (a nfse-api não emite por ela) e a tela não tem os botões. A marca cai
     sozinha se um botão passar a consumir o par.
   - **A-PV14**: a guarda das telas do Super vale também para o super.
   - **Q-PV19** (§12.5): a resposta veio repetida como "Q-PV17 - a". Com (a), o teste ao vivo fica obrigatório na suíte e não há código
     novo. Com (b), o `privilege-catalog-live.test.ts` vira opt-in no molde do `F2A_ADV_LIVE`
     (`adversarial-f2a-a2-gate.test.ts:397`), e o roteiro da publicação (D-PV16) passa a ser o único a conferir o banco antes do deploy.
   - ~~**Q-PV50…Q-PV53** (§12.8)~~ → **DECIDIDAS 2026-10-20: D-PV42 (Q-PV50 a + chave técnica em inglês), D-PV43 (Q-PV51 a — UNIQUE, entrega própria), D-PV44 (Q-PV52 a), D-PV45 (Q-PV53 b)**; A-PV12/A-PV14 ratificadas; Q-PV19 = D-PV41. A (a) da Q-PV50 e a (a) da Q-PV51 são entregas próprias. A Q-PV51 é DDL: guardião, depois
     `PADROES_BANCO` + `revisar-ddl`, prova em schema descartável.
2. **Numeração**: a sessão da D-PV2 usa D-PV18+, A-PV15+, Q-PV40–49 e Q-PV54+. Antes de numerar algo novo da cerca, conferir o maior
   número no prompt e combinar com ela.
3. **Commit**, só com o "vai": nas duas branches `privilegios-catalogo`, com `git add` só dos caminhos listados acima. Os
   `.dart_tool/*` da worktree do app ficam de fora.
4. **Publicação** (§12.7 + o que a Rodada 5 somou):
   - (a) `npm run errors:gen` com os 3 códigos novos (escreve em `setes_central.tb_error_catalog`);
   - (b) a ordem é seed dos pares → setes-api → app;
   - (c) antes do `flutter build`, `build-web.ps1 -CheckOnly` (só as conferências) tem de sair 0;
   - (d) o merge do `error-codes.ts` com os 7 códigos da D-PV2 é SOMA. A branch dela, `privilegios-crud`, já está commitada e no
     GitHub (api 50b928f);
   - (e) a D-PV14: quem chegar por último ao `main` escreve o adaptador da `listGatedRoutes()` (§12.7 item 2).
5. **Limpeza**, ao remover a worktree: apagar as junções `privilegios-catalogo\{nfse-api,fiscal-api}` e o link do `.env`. É `rmdir`
   da junção, nunca apagar com recursão: a recursão apagaria o conteúdo do repo de verdade.

> **Prompt curto para a nova sessão**: "Retome a cerca da D-PV9 pelo §12.9 do
> `Infra-IA/prompts/prompt_privilegios_interfaces.md`. As worktrees são `D:\Gestao2027\privilegios-catalogo\{setes-api,setes-app}`
> (branch `privilegios-catalogo`, nada commitado). Antes de tudo, rode `npx tsc --noEmit` e
> `npx jest src/__tests__/privilege-catalog` no setes-api da worktree. Minhas respostas: A-PV12 …, A-PV14 …, Q-PV19 …,
> Q-PV50…Q-PV53 …. Regras: nada de commit, push ou seed sem o meu 'vai'; não editar `D:\Gestao2027\setes-api` (tsx watch = deploy);
> banco só em sessão READ ONLY; não ler setes-sync nem sincronizador."

## 13. Q-PV38 / D-PV13 — força bruta no código do `/auth/change-password` (2026-10-18, sessão própria, em WORKTREE — NADA commitado)

> ✅ **SEÇÃO VOLTA A VALER — a D-PV18 foi REVOGADA pela D-PV47 (Valdo, 2026-10-20: a recuperação volta, reforçada contra força bruta na porta pública); a branch `recuperacao-senha` existe (não foi apagada de fato) e as Q-RS/A-RS voltam à fila.** Nota histórica abaixo:
> ⚠️ ~~**SEÇÃO SUPERADA pela D-PV18**~~ (Valdo, 2026-10-18, noite: "estes aplicativos não precisam de recuperação de senha — remova tudo em
> relação a recuperação de senha")**. A branch `recuperacao-senha` (setes-api d19de9d · sql e1aa574) foi APAGADA — local e GitHub; os
> hashes ficam aqui como história (reflog, ~90 dias). O fluxo `/auth/recovery-password` + `/auth/change-password` e a tela "Esqueci minha
> senha" do app saem do `main` pela branch `sem-recuperacao-senha` (worktrees `D:\Gestao2027\sem-recuperacao\{setes-api,setes-app}`;
> merge API + app JUNTOS, só com o "vai"). Q-RS1…Q-RS6 e A-RS1…A-RS4 MORREM sem resposta. O que FICA desta seção é conhecimento:
> (1) a colação `utf8mb4_general_ci` iguala `gmaíl.com`/`gmaıl.com` a `gmail.com` — qualquer porta futura que mande um segredo ao e-mail
> vindo da REQUISIÇÃO repete o CRITICAL (mandar sempre ao e-mail GRAVADO); (2) a regra 13 do `PADROES_BANCO.md` §9 (leitura consistente
> dos filhos depois da trava do pai) continua válida como padrão — o caso que a provou deixou de existir.

**Onde**: `D:\Gestao2027\recuperacao-senha\{setes-api,sql}` (branch `recuperacao-senha`; base setes-api `main` f53a618, sql `main` 3672ee2);
junções `recuperacao-senha\{fiscal-api,nfse-api}` e `node_modules`. Mudam o setes-api e o repo `sql`; o setes-app NÃO muda (rotas,
corpos e envelopes iguais — a cerca do app que lê `auth.routes.ts` segue valendo). Banco: só leitura (`READ ONLY`) + schemas DESCARTÁVEIS
`setes_pwreset_probe_<pid>` (apagados). setes-sync e sincronizador NÃO lidos. Parecer do guardião (agente `setes-conceito`) ANTES do DDL.

### 13.1 Fatos (conferidos)

- O código vivia em `tb_user.activation_key` (texto puro) e o prazo era o `updated_at` do USUÁRIO: o PUT do admin (`updateUserCascade`)
  reiniciava os 15 min do código aberto, e não havia onde contar tentativas nem emissões — **maquete** (parecer do guardião).
  `TIMESTAMPDIFF(MINUTE…) <= 15` deixava a janela real em até 15:59; `changePassword` não conferia `active`; o recovery chamava o SMTP de
  forma SÍNCRONA só para e-mail existente (o tempo dizia quem existe).
- ⚠️ **Achado CRITICAL ANTERIOR, corrigido nesta entrega**: o código ia ao TEXTO da requisição, mas a busca do login casa pela colação
  `utf8mb4_general_ci` de `tb_mailing.email`, que iguala sem acento e sem caixa (conferido no banco, só leitura: `user@gmaíl.com`,
  `USER@Gmail.com ` e `user@gmaıl.com` = `user@gmail.com`). Quem registrasse o domínio `gmaíl.com` pediria o código da conta de
  `fulano@gmail.com` e o RECEBERIA — tomada de qualquer conta, inclusive a do super. Agora o código vai SEMPRE ao e-mail GRAVADO.
- Dobras da general_ci que o NFKD não faz, levantadas no banco (faixas Latin-1, Latin Extended-A/B): só `ß` = `s` e `ı` = `i`.
- 13 usuários; nenhum `activation_key` preenchido em 2026-10-18 (nada em voo na transição). Swagger anunciava `minLength: 8` com o código
  exigindo 5 (corrigido).

### 13.2 O que foi feito

- **`setes_central.tb_user_password_reset`** (script `sql/67_user_password_reset_ddl.sql` + espelho no `sql/01`): uma linha por código emitido;
  PK `(tb_user_id, seq)` — `seq` = MAX+1 POR USUÁRIO sob a trava da linha de `tb_user`; `code_hmac` char(64); `failed_attempts`; `used_at`
  (único fato depois da emissão, write-once); `created_at` NOT NULL = início do prazo. Vale só o código de MAIOR `seq`, não usado, dentro de
  15 min e com `failed_attempts` < 5 — **tudo derivado** (substituído, esgotado e vencido não são colunas). CHECKs: HMAC hex minúsculo de 64
  (recusa gravar o código puro por construção), `seq` > 0, tentativas ≥ 0. O script também LIMPA `activation_key` (sem DROP e sem ALTER —
  um MODIFY para COMMENT pediria trava de metadados na tabela do login).
- **O código nunca é guardado**: `code_hmac` = HMAC-SHA256 de `user:seq:hash da senha:e-mail de login gravado:código`; segredo derivado (HKDF,
  `password-reset-code:v1`) da chave PRIVADA de assinatura (`deriveProductSecret` em `@shared/auth/product-token`) — fora do banco e do
  repositório, sem segredo novo para provisionar. Trocar a senha ou o e-mail de login por QUALQUER caminho invalida o código aberto.
- `auth.service.ts`: `createPasswordResetCode`/`consumePasswordResetCode` devolvem VEREDITO (o throw fica fora da transação — a tentativa errada
  COMMITA o +1); a tentativa é julgada e contada sob a trava da linha do usuário (`FOR UPDATE WAIT 5` — rota pública não prende o pool);
  esgotado/vencido/usado não somam; toda recusa = a MESMA 401 `Código inválido ou expirado`; teto DURÁVEL de emissões por conta (3/hora e
  10/24 h), calado; o recovery responde depois da MESMA consulta para qualquer e-mail e a emissão + o SMTP correm em SEGUNDO PLANO
  (`waitForPendingPasswordResets`, `.catch` na borda); **piso do tempo de resposta** de 400 ms nas duas rotas (`withResponseFloor` — a
  transação da conta existente fica escondida nele); falha depois de achar a conta = resposta neutra, com **alarme** (`alarmNeutral`:
  contenção = só aviso; pane = ref + `recordCrash` na tb_crashlytics; o log leva só código/mensagem — o `err.sql` do mysql2 levaria o MD5).
- `findUserByEmail` devolve o e-mail GRAVADO e ficou determinístico (`ORDER BY u.id, m.id`); `updatePassword` segue limpando `activation_key`.
- **Limite por e-mail em memória** (`perEmailRateLimit`, `gateway/rate-limit.middleware.ts`): chave = SHA-256 da forma canônica
  (`@shared/auth/login-email` — corte em 320, NFKD sem marcas, minúsculas, `ß`→`s`, `ı`→`i`, só o espaço do FIM), 5/15 min no recovery e
  10/15 min no change, 429 IGUAL para qualquer e-mail, SEM cabeçalhos `RateLimit-*`. Camada de CARGA; a garantia é o teto por conta.
- **Boot**: `assertPasswordResetReady` (tabela + autoteste do HMAC) — sem um dos dois o setes-api NÃO sobe.
- Scripts: `pre-deploy-tz-check.ts` (comentário: o pedido novo nasceu em UTC, fora da conferência) e `reset-dev-data.ts` (o filho cai antes do
  usuário — FK NO ACTION). Prova nova `scripts/prove-password-reset-lock.ts`.
- **PADROES_BANCO v2.1**: §9 regra 13 NOVA (filhos de um pai serializador lidos CONSISTENTES depois da trava do pai, nunca com a faixa do
  filho travada — 1ª prova com `FOR UPDATE` no filho: 12 contas emitindo juntas = 1 deadlock que passou de 5 retentativas) e §7 (a rotação
  do `JWT_KID` mata os códigos abertos).

### 13.3 Testes e prova

- `src/__tests__/auth-password-reset-q-pv38.test.ts` (26, dublê do banco pelo texto do SQL, relógio do banco e trava de registro emulada):
  **5 erradas e a 6ª com o código CERTO = 401 sem trocar a senha**; controle 4 + certa = 200; **e-mail inexistente responde IGUAL** (recovery
  e change — status, corpo e TEMPO pelo piso); a mesma 401 para os 7 tipos de recusa; rajada paralela de 25 para no teto; o +1 é COMMITADO;
  pane × contenção (alarme só na pane, log sem `sql`); `WAIT 5`; recovery responde antes da emissão; SMTP fora da resposta; código ao e-mail
  GRAVADO (acento no domínio, caixa, espaço, ı); só o HMAC no banco; PUT do admin e troca do e-mail de login invalidam; código novo
  substitui; teto durável hora/dia; 429 igual para quem existe e quem não existe; chave de tamanho fixo e dobras; sem `RateLimit-*` do
  limite por e-mail; e-mail em array não escapa; 400 da senha curta antes de tocar o código; boot. Mutantes conferidos (tirar o teto, mandar
  ao texto da requisição, jogar o +1 num throw) — cada um derruba os testes certos.
- `src/__tests__/adversarial-q-pv38-gate.test.ts` (26 sondas dos dois passes do gate: `[RESISTIU]`, 3 `[CORRIGIDO]` e 1 `it.failing`
  `[ACHADO·LOW]` que fixa a fila provocada da Q-RS6).
- `scripts/prove-password-reset-lock.ts` (schema descartável, InnoDB real com `WAIT 5`, SQL do código real com o schema trocado na conexão,
  chave de assinatura DESCARTÁVEL; verde em 4 rodadas): DDL re-executável, `tb_user` sem ALTER e o código antigo LIMPO; CHECKs recusam HMAC
  maiúsculo/curto, código puro, seq 0, tentativas negativas; 25 erradas em paralelo param em 5 e o certo depois = esgotado; 10 emissões
  paralelas da mesma conta = 3 (seq 1,2,3); 40 contas em paralelo = 40 emitidas, 0 deadlock; PUT do admin invalida o código; vencido e
  reuso recusados; rodada mista de 96 operações em 32 contas = 0 erro, 0 deadlock; `setes_central` intacta antes/depois.
- Suíte inteira do setes-api (volta sem concorrência): **129 suítes · 2048 testes verdes** (31 pulados — os ao vivo), com cópia temporária do
  `.env` (apagada). Em voltas com a máquina carregada por outras sessões, suítes de tempo/timeout (F2a a2/a3, onda2 e a sonda desta tarefa)
  oscilaram e passaram isoladas — as tolerâncias de tempo das sondas desta tarefa foram folgadas depois disso (conhecimento negativo:
  teste de TEMPO com folga de dezenas de ms quebra na suíte inteira com a máquina ocupada).

### 13.4 Gates

- **Socrático, 1ª passada: 0,66 — REPROVOU.** HIGH NOVO desta entrega: o e-mail virava chave do limite em memória do tamanho que viesse (corpo
  de 2 MB) — um IP sozinho enchia a memória e derrubava a API. MEDIUM: `activation_key` não limpa (falso "em voo" no `pre-deploy-tz-check` e
  código antigo revivendo num rollback); oráculo de TEMPO (COMMIT só para conta existente). LOW: o neutro escondia pane; o boot não exercitava
  o HMAC; `FOR UPDATE` sem `WAIT` numa rota pública; `RateLimit-*` por e-mail revelando atividade de terceiro; comentário falso do normalizador;
  `ALTER` só para COMMENT na tabela do login; FK × `reset-dev-data`; números de questão ainda não registrados. **Todos corrigidos na sessão.**
- **Socrático, re-score: 0,80 — PASSOU.** Sobras corrigidas: `.catch` na borda do job, `ẞ` maiúsculo, log sem `err.sql`; o UPDATE do sql/67
  roda de novo depois do merge (roteiro §13.8).
- **Adversarial: 0,82 — PASSOU** (sem HIGH/CRITICAL; atacou a versão retrabalhada). MEDIUM: o change-password ainda distinguia conta existente
  (transação) de inexistente pelo tempo → **corrigido** pelo piso de 400 ms (sonda virou `[CORRIGIDO·MEDIUM]`). LOW restantes: resíduo de
  `getConnection` no recovery (escondido pelo piso), DoS do dono (Q-RS4), e-mail duplicado só recupera a conta de menor id, falha da PRÓPRIA
  busca do usuário = 500 (igual para todos — não é oráculo). Sem dobra da general_ci fora de `ß`/`ı`/`ſ` (busca ao vivo).
- **Delta pós-gate (piso, borda do job, log, forma canônica): 0,85 — PASSOU** (sem HIGH/CRITICAL). Corrigidos na sessão: `{"email":{"toString":1}}`
  dava 500 no limitador (coerção única `bodyText` no limitador e nas rotas — o que não vira texto = campo ausente = 400); `ẞ` maiúsculo caía no
  balde de `s`, que o banco não iguala (dobras voltaram para antes das minúsculas); piso medido com relógio monotônico. Resta LOW: o atacante
  consegue PROVOCAR a fila na trava da vítima (10 trocas + 5 emissões em 15 min) — com transação acima de ~27 ms a diferença volta (Q-RS6;
  sonda `it.failing` com latência emulada de 80 ms; banco local fica abaixo).

**Numeração própria desta tarefa** (molde do Q-UC da frente do usuário convidado — este prompt é escrito por várias sessões ao mesmo
tempo e a A-PV14 já foi usada pela cerca da D-PV9): questões **Q-RS1…Q-RS6**, assunções **A-RS1…A-RS4** ("recuperação de senha").

### 13.5 Assunções executadas (A-RSn — ratificar)

- **A-RS1 — RATIFICADA (Valdo, 2026-10-20)** — o modelo do guardião: `tb_user_password_reset` com PK por usuário, só `used_at` como fato, estado derivado; nome pela
  CONSEQUÊNCIA (reset), não pela origem (recovery); `activation_key` sem consumidor, LIMPA e sem DROP (o grupo do sync não a toca — Q4 do
  `setes-sync/prompt_indexacao_usuario_firebird.md`).
- **A-RS2 — RATIFICADA (Valdo, 2026-10-20)** — o código guardado como HMAC com segredo DERIVADO (HKDF) da chave de assinatura JWT; a rotação do `JWT_KID` mata os códigos
  abertos (≤ 15 min) — limite aceito (PADROES §7).
- **A-RS3 — RATIFICADA (Valdo, 2026-10-20)** — neutralidade completa: conta inativa recusa com a mesma 401; falha depois de achar a conta responde como "não existe" (com
  alarme); o recovery responde antes da emissão; piso de 400 ms no tempo das duas rotas.
- **A-RS4 — RATIFICADA (Valdo, 2026-10-20)** — limite por e-mail em memória (chave canônica com hash) como 2ª camada, além do durável por conta.

### 13.6 Questões (aguardam o Valdo — nenhuma trava a entrega)

> **2026-10-20 — RODADA FECHADA** (depois da D-PV47 devolver a seção à vida): A-RS1…A-RS4 RATIFICADAS; Q-RS1 → D-RS1 (valores mantidos) ·
> Q-RS2 → D-RS2 (proxy na Onda 4) · Q-RS3 → D-RS3 (segredo derivado do JWT) · Q-RS4 → D-RS4 (aviso por e-mail ao dono, SMTP real já) ·
> Q-RS5 → D-RS5 (prompt próprio de endurecer a autenticação; SMTP obrigatório em produção) · Q-RS6 → D-RS6 (medir na Onda 4). **Nenhuma
> questão aberta.** A publicação segue o §13.8, PRIMEIRA da ordem de merge do setes-api (sql/67 antes e depois), acrescida de: SMTP real
> no `.env` (D-RS4/D-RS5) e a mesma peça do código confirmando a troca do titular logado (D-UC7/D-UC8 — "minha senha" entra na onda 0 do
> convidado, não nesta janela).

- **Q-RS1 — os valores** [→ **D-RS1 (Valdo, 2026-10-20: "mantenho os valores")**: N = 5 · 15 min · 3/h e 10/24 h por conta · memória 5/15 min · piso 400 ms — como executado] (o N é decisão reservada do Valdo): N = 5 tentativas erradas por código; prazo 15 min (o atual); teto de 3 códigos
  por hora e 10 por 24 h por conta; memória 5/15 min no recovery e 10/15 min no change; piso de resposta 400 ms. Sob ataque contínuo: no
  máximo 50 palpites/dia por conta (~0,0056 %/dia, ~2 %/ano), cada código é um e-mail para a vítima; o preço é segurar o "esqueci a senha" da
  vítima por até 1 h (o login com a senha segue). **Rec.: manter.**
- **Q-RS2 — `app.set('trust proxy', …)` agora ou na Onda 4?** [→ **D-RS2 (Valdo, 2026-10-20) = Onda 4**, com o número exato de saltos, nunca `true`; item do roteiro de deploy junto da Q-I6] Hoje o setes-api roda SEM proxy na máquina do Valdo: ligar agora deixaria
  qualquer um forjar o IP pelo `X-Forwarded-For` e fugir do limite por IP. **Rec.: Onda 4** (deploy SaveInCloud, junto da Q-I6), com o
  número EXATO de saltos/IP do proxy, nunca `true`; até lá segura o limite por conta (durável), que não depende do IP.
- **Q-RS3 — segredo do HMAC** [→ **D-RS3 (Valdo, 2026-10-20) = (a)**, derivado da chave JWT, como está]: (a) derivado da chave JWT (como está); (b) segredo dedicado `PASSWORD_RESET_KEY_PATH`, boot recusa sem ele.
  **Rec.: (a)** — mesma guarda, nada a provisionar; trocar para (b) depois não muda o schema (só mata os códigos abertos na troca).
- **Q-RS4 — bloqueio da recuperação por terceiro** [→ **D-RS4 (Valdo, 2026-10-20) = (b), literal "b(vamos configurar)"**: e-mail de aviso ao DONO da conta quando um código esgota por erradas ou o teto por conta é atingido ("se não foi você, ignore; o login com a senha segue"), no máximo UM aviso por hora por conta (o aviso não entra no teto de códigos nem vira vetor de spam), enviado pela peça `@shared/mailer` com SMTP REAL configurado — o SMTP de produção entra nesta entrega (ver Q-RS5); a saída pelo admin não existe mais (D-UC8) e o script do operador (D-PV46) é só do Super] (quem sabe o e-mail da vítima queima cada código com 5 erradas e esgota o teto calado —
  até 24 h sem autoatendimento, recebendo os e-mails): (a) limite conhecido — a saída é o admin trocar a senha (D-PV12); (b) avisar o dono/o
  admin quando um código esgotar ou o teto for atingido; (c) o teto não contar emissão cujo código foi queimado por erradas. **Rec.: (a)**
  agora; (b) quando houver canal de aviso.
- **Q-RS5 — endurecer o resto da autenticação em tarefa própria?** [→ **D-RS5 (Valdo, 2026-10-20) = (a)**: prompt próprio `prompts/prompt_endurecer_autenticacao.md` (a abrir): limite por conta no `/auth/login`, teto global + alarme de erradas, política de senha (mínimo e composição), SMTP obrigatório em produção (boot recusa subir sem SMTP quando `NODE_ENV=production`); o SMTP em si é configurado JÁ, junto da D-RS4 — o `.env` do dev ganha o SMTP real da Setes (segredo fora do git) e o código deixa de ir ao log] O `/auth/login` não tem limite por conta (só o de 300/min por IP) e a
  senha mínima é 5 — é hoje a porta mais fraca (o ataque espalhado por muitas contas também não tem teto global nem alarme de erradas); e,
  sem SMTP configurado, o código vai ao LOG em claro (modo dev — o boot de produção deveria recusar subir sem SMTP?). (a) sim, prompt
  próprio (limite por conta no login + teto global/alarme + política de senha + SMTP obrigatório em produção); (b) não agora. **Rec.: (a).**

- **Q-RS6 — a fila PROVOCADA contra o piso** [→ **D-RS6 (Valdo, 2026-10-20) = (a)**: limite conhecido; medir o tempo real da transação do consume no banco da Onda 4 (item do roteiro de deploy); (b) se passar do limiar de ~27 ms no p99] (gate do delta): (a) limite conhecido — medir o tempo REAL da transação do consume no
  banco da Onda 4 (local: alguns ms, abaixo do limiar de ~27 ms); (b) subir o piso acima de N × t_tx no p99; (c) serializar também a
  conta inexistente por balde (trava em memória por e-mail canônico), para as duas filas ficarem iguais. **Rec.: (a)** agora, com a
  medição como item da Onda 4; (b) se a medição passar do limiar.

### 13.7 Limites conhecidos (conhecimento negativo)

- O piso esconde o trabalho só enquanto a conta existente cabe nele: banco sob carga a ponto de passar de 400 ms reabre a diferença.
- Reinício do processo (`tsx watch` = deploy) entre o COMMIT da emissão e o SMTP perde o e-mail; o código conta no teto — o usuário pede outro.
- E-mail de login duplicado (dado anômalo) só recupera a conta de menor id.
- Falha da PRÓPRIA busca do usuário (banco fora) = 500 nas duas rotas, igual para todos.
- A sessão JWT aberta antes da troca de senha segue válida até expirar (24 h) — não existe revogação de JWT (fora do escopo).
- O limite em memória zera no reinício e não soma entre instâncias (D-F9: 1 instância por serviço).

### 13.8 Publicação (só com o "vai") — REVISTA 2026-10-21 (D-RS4/D-RS5/D-PV46)

0. **SMTP REAL no `.env` vivo do setes-api ANTES do merge** (D-RS4/D-RS5): `SMTP_HOST`, `SMTP_PORT` (465 SSL ou 587 STARTTLS),
   `SMTP_USER` + `SMTP_PASSWORD` (os dois, ou nenhum), `SMTP_FROM` — valores fornecidos pelo Valdo, nunca em arquivo versionado;
   `SMTP_SECURE` pode ficar (a peça deriva a criptografia da porta e a ignora). Conferir com o pré-voo
   `npx tsx --require tsconfig-paths/register scripts/pre-deploy-tz-check.ts` (seção "D-RS5: SMTP do ambiente" — abre a conexão e
   autentica, sem enviar). Enquanto o dev não é produção (`NODE_ENV` ausente), SMTP ausente = aviso; com `NODE_ENV=production` o boot
   RECUSA subir sem SMTP completo. Com SMTP real configurado o código DEIXA de ir ao log. **Conferido em 2026-10-21 no dev: o `.env`
   vivo JÁ tem o SMTP da Setes (`setes.com.br:465`, SSL, com autenticação) e o pré-voo abriu a conexão e autenticou com sucesso — o
   código de recuperação do dev já sai por e-mail real, não pelo log; no destino da Onda 4 falta só `NODE_ENV=production`.**
1. Aplicar `sql/67_user_password_reset_ddl.sql` em `setes_central` (re-executável; cria as DUAS tabelas — pedido e aviso ao dono) — ANTES
   do código: o boot desta branch não sobe sem as duas.
2. Merge da branch `recuperacao-senha` no `main` do setes-api (árvore viva = deploy) e no `main` do repo `sql` (atenção: o `main` do sql
   já recebeu o seed 65 — o merge soma, não substitui); conferir no log do boot `Pedido de troca de senha (script 67): ok` e
   `E-mail (SMTP): smtp <host>:<porta> …`.
3. Rodar o sql/67 DE NOVO (limpa a `activation_key` que o código antigo ainda gravou entre o passo 1 e o merge; as tabelas já existem).
4. Passeio: pedir código, errar 5, a 6ª certa recusada, código novo funciona; e-mail inexistente responde igual; **conferir o aviso
   (D-RS4): depois da 5ª errada o DONO recebe o e-mail "Setes — aviso de segurança da sua conta" (neutro, sem código); errar mais 5 no
   código novo na mesma hora NÃO manda outro; pedir o 4º código na hora manda só se a hora ainda não tiver aviso** (linhas em
   `tb_user_password_reset_notice`, kind E/C — só leitura).
5. Ensaio do script do Super (D-PV46), sem `--vai`: `npx tsx --require tsconfig-paths/register scripts/reset-super-password.ts` lista o
   Super com o e-mail mascarado e "ENSAIO — nada gravado". O `--vai` NÃO faz parte da publicação (só quando a senha do Super se perder).
6. Códigos pedidos antes do deploy morrem — o usuário pede outro. O setes-app não muda; `errors:gen` não é preciso (nenhum código novo).
7. Depois: a onda 0 do convidado traz "minha senha" (D-UC7/D-UC8 — a MESMA peça do código confirma a troca do titular logado) e o
   prompt `prompts/prompt_endurecer_autenticacao.md` (D-RS5) organiza o resto da autenticação (Rodada 0 em §13.10.7).

### 13.9 Retomada (prompt curto) — ATUALIZADA 2026-10-21

> Retomar a recuperação de senha (§13 deste prompt — D-PV47 revogou a D-PV18; §13.6 FECHADO: A-RS1…A-RS4 ratificadas, D-RS1…D-RS6).
> Código na branch `recuperacao-senha` (worktrees `D:\Gestao2027\recuperacao-senha\{setes-api,sql}`; base setes-api `main` f53a618):
> commits d19de9d (api) · e1aa574 (sql) no GitHub **+ o delta de 2026-10-21 (D-RS4/D-RS5/D-PV46 — §13.10) NÃO commitado**. NADA no
> `main`, sql/67 NÃO aplicado. Esperam o Valdo: **A-RS5…A-RS11** (§13.10.4 — leitura da D-PV46 sem `tb_user.kind`/`updated_by`,
> momento do aviso C, texto único, Super inativo/2+ ativos recusados, `npm start` = produção, "ativo" = predicado do login, timeouts
> SMTP), **Q-RS7…Q-RS14** (§13.10.5 — nenhuma trava a entrega; Q-RS10/Q-RS11/Q-RS12/Q-RS14 já executadas pela recomendação, a
> ratificar) e a Rodada 0 do `prompt_endurecer_autenticacao.md` (Q-EA1…Q-EA12). Publicar só com o "vai", pelo §13.8 (SMTP real ANTES,
> sql/67 ANTES e DEPOIS do merge). Antes do merge, conferir conflito com a `privilegios-crud` (ela não toca `auth.*`, `mailer.ts`,
> `rate-limit.middleware.ts` nem `product-token.ts` até onde se viu) e rodar a suíte inteira com a máquina livre (testes de tempo).

### 13.10 Execução de D-RS4 / D-RS5 (código) / D-PV46 — 2026-10-21 (sessão própria, nas MESMAS worktrees; NADA commitado)

**Onde**: `D:\Gestao2027\recuperacao-senha\{setes-api,sql}` (branch `recuperacao-senha`, delta sobre d19de9d/e1aa574). O `.env` da
worktree do setes-api é link físico do vivo (recriado nesta sessão — não existia). Banco: `setes_central` só LIDA; schemas DESCARTÁVEIS
`setes_pwreset_probe_<pid>` (prova) e `setes_superpw_probe_<ts>` (teste do Super), apagados. Parecer do guardião (agente `setes-conceito`)
ANTES do DDL e da forma do script — resumido em §13.10.1. O setes-app NÃO muda (rotas, corpos e envelopes iguais).

#### 13.10.1 Parecer do guardião (2026-10-21) — o que entrou e o que foi recusado

- **Aviso ao dono = fato da CONTA, não do código** (no caso do teto não existe código): tabela IRMÃ `setes_central.tb_user_password_reset_notice`
  sob `tb_user` — PK `(tb_user_id, seq)` com `seq` MAX+1 sob a MESMA trava da linha de `tb_user` (regras 12/13), `kind` char(1) = a CAUSA
  de lista fechada, FORENSE (E = código esgotado por erradas · C = teto atingido; nunca vai ao e-mail), `created_at` = instante em que o
  sistema TOMOU a vaga da hora (o SMTP corre depois do COMMIT); **sem FK para o código**; **sem `sent_at`/status** (SMTP aceito ≠ entregue
  — não é fato nosso). Recusados: coluna no código (o aviso do teto penduraria numa linha que não o gerou), coluna em `tb_user` (MDL na
  tabela do login + um slot sem história), tabela genérica de notificações. Entrou no PRÓPRIO sql/67 (não aplicado, re-executável) +
  espelho no sql/01; `assertPasswordResetSchema` confere as DUAS tabelas.
- **Script do Super = (a) refinada**: o FATO vai na linha do domínio pela MESMA peça do fluxo normal (`updatePassword` do auth: senha +
  `activation_key = NULL` + `updated_at`; por construção mata qualquer código de recuperação aberto), sob `lockUserForPasswordReset`;
  o AUTOR (operador do SO) vai ao LOG + roteiro — `tb_user` não tem `updated_by`, e o `updated_by` da casa SIGNIFICA id de tb_user (gravar
  o id do super "mentiria" o autor; linha em `tb_user_password_reset` sem código seria abuso da peça). Conceito irmão registrado para o
  futuro: "senha INICIAL definida por TERCEIRO" (admin na criação — D-UC8; Super que cria Super; operador) — hoje nenhum deixa fato
  durável; se nascer (`tb_user_password_assignment`), o script passa a gravar nele com uma linha. **Divergência literal devolvida ao
  Valdo: a D-PV46 cita `tb_user.kind = 'super'` e `updated_by`, que não existem** (super = `tb_institution_has_user.kind = 'super'` na
  institution 1, como o `isSuper` do login) → **A-RS5**. Com 2+ Supers ATIVOS o script RECUSA e aponta a tela (um define a do outro —
  complemento da D-PV46) → **Q-RS7**.

#### 13.10.2 O que foi feito

- **D-RS4** — `auth.repository.ts`: `hasRecentPasswordResetNotice` (EXISTS na janela de 60 min, leitura consistente depois da trava) e
  `insertPasswordResetNotice` (MAX+1 por usuário + INSERT pela PK); `auth.service.ts`: `claimOwnerNotice` chamado na MESMA transação do
  gatilho — na tentativa errada que ESGOTA o código (`failedAttempts + 1 >= 5`, dentro de `judgePasswordResetCode`) e no pedido CALADO
  pelo teto (`issuePasswordResetCode`, veredito `capped`); os dois devolvem `{ verdict, notice? }` (os antigos `consumePasswordResetCode`
  / `createPasswordResetCode` seguem como atalhos só do veredito, para a prova e os testes); `sendOwnerNotice` (assunto
  `OWNER_NOTICE_SUBJECT` = "Setes — aviso de segurança da sua conta"; texto neutro único para as duas causas: "tentativas de recuperação
  não concluídas; se foi você, peça outro código; se não foi, ignore — nada mudou e o login com a sua senha segue") ao e-mail de login
  GRAVADO, depois do COMMIT, em segundo plano (`runInBackground` — a mesma borda do job da emissão; `waitForPendingPasswordResets`
  cobre os dois); falha do SMTP no aviso = log de erro, sem retentativa, a vaga fica tomada; em dev sem SMTP o aviso vai ao log (sem
  segredo). O +1 da tentativa e a vaga do aviso COMMITAM juntos; a 401 é a mesma; o piso de 400 ms esconde o INSERT a mais.
- **D-RS5 (código)** — `src/shared/mailer/mailer.ts`: `isProduction()` (`NODE_ENV === 'production'` exato), `mailerConfigProblems()`
  (host; porta inteira 1–65535, vazia = 587; usuário E senha ou nenhum dos dois; remetente = `SMTP_FROM` ou `SMTP_USER`),
  `describeMailerConfig()` (host:porta, SSL/STARTTLS, remetente, com/sem autenticação — NUNCA a senha), `assertMailerReady()` (produção
  sem SMTP completo = Error com as chaves e "D-RS5"; dev = resumo ou aviso de modo dev), `verifyMailerConnection(timeout)` (EHLO/
  STARTTLS/AUTH sem enviar, falha fechado por tempo/erro/configuração incompleta — só para o pré-voo, NUNCA no boot: SMTP fora não
  derruba a API). `server.ts`: `E-mail (SMTP): …` no boot, depois do script 67. `auth.service.ts`: o código vai ao log só se
  `!isMailerConfigured() && !isProduction()` (cinto além do boot). `.env.example`: `NODE_ENV` + bloco SMTP comentado ("valores reais só no
  `.env` vivo, fornecidos pelo Valdo na publicação"; `SMTP_SECURE` é ignorada — a porta manda). `scripts/pre-deploy-tz-check.ts`: seção
  "D-RS5: SMTP do ambiente" — em produção ausente/incompleto/sem resposta é item BLOQUEANTE; fora dela aviso.
- **D-PV46** — peça `src/modules/auth/super-password-reset.ts` (`listSuperAccounts`, `generateInitialPassword` 16 chars de alfabeto sem
  0/O/1/l/I ≈ 91 bits, `hashInitialPassword` = `md5Password`, `resetSuperPasswordTx` = trava → vínculo super na institution 1 → `updatePassword`;
  recusas `not-super` (inclusive conta inexistente/excluída — a mesma) e `inactive`; hash fora da forma recusado antes do banco) + CLI
  `scripts/reset-super-password.ts` (ensaio sem `--vai`; alvo implícito só com EXATAMENTE um Super ativo; `--user-id`/`--email` nomeiam
  entre inativos; 2+ ativos = recusa; `withDeadlockRetry`; senha impressa UMA vez no stdout; log `D-PV46: senha do Super REDEFINIDA pelo
  operador` com usuário do SO, host, instante, id e e-mail mascarado — nunca a senha). Nota de operação no `setes-api/CLAUDE.md` da
  worktree (seções "Recuperação de senha, aviso ao dono e SMTP" e "Senha perdida do SUPER").
- **sql**: `67_user_password_reset_ddl.sql` (cabeçalho D-RS4 + `tb_user_password_reset_notice`, CHECKs `seq > 0` e `kind IN ('E','C')`,
  FK NO ACTION para tb_user) e espelho em `01_setes_central_ddl.sql`. `scripts/reset-dev-data.ts` apaga os dois filhos antes do usuário.
- **Prova** `scripts/prove-password-reset-lock.ts` — passo 8 novo: 25 erradas em paralelo = 1 vaga (E); 10 pedidos calados na mesma hora =
  nenhuma vaga nova; hora seguinte (created_at recuado) = vaga C (seq 2); CHECK recusa kind 'X'; zero deadlock. **9/9 OK no InnoDB real**
  (schema descartável apagado; `setes_central` intacta antes/depois).

#### 13.10.3 Testes

- `auth-password-reset-q-pv38.test.ts` **37/37** (26 anteriores + 9 da D-RS4: 5ª errada = 1 aviso e a mesma 401; teto = 1 aviso no 4º
  pedido calado, sem gerar código; coalescência das duas causas e seq 2 na hora seguinte; neutralidade (inexistente nunca gera aviso nem
  linha; uma só resposta); vaga COMMITADA antes do e-mail e e-mail não segura a 401; rajada paralela = seq 1 e um e-mail; SMTP fora no aviso
  = 401 igual, log sem alarme, vaga tomada; texto neutro e e-mail GRAVADO; boot com as duas tabelas · + 2 da D-RS5: dev loga o código,
  produção nunca). O dublê ganhou a tabela irmã (handler ANTES dos do pedido — as regexes antigas casavam `…_notice`) e e-mails
  RESERVADOS `n1…n9@x.com` (o limite por e-mail em memória é do processo: reutilizar e-mail gasto dava 429 — lição de dublê).
- `adversarial-q-pv38-gate.test.ts` **26/26** (dublê com a irmã; `lastCode` só pelo e-mail do código; mock do `isProduction`).
- `adversarial-d-rs4-gate.test.ts` **23/23** (gate adversarial desta entrega — 19 `[RESISTIU]` + 4 `[CORRIGIDO]`; §13.10.6).
- `mailer-d-rs5.test.ts` **17/17** (peça real, nodemailer dublado: produção recusa ausente/incompleto/porta inválida/remetente ausente;
  completo sobe sem a senha no resumo; relay sem autenticação válido; dev = modo dev/⚠️; `Production`/`production ` SÃO produção com
  aviso de grafia, `prod` não é e o resumo nomeia; `SMTP_HOST` só espaços = não configurado; `verify` sem enviar, incompleto não conecta,
  erro sem a senha, tempo estourado = falha).
- `super-password-reset-d-pv46.test.ts` **11/11** (dublê: reset pela peça, recusas sem escrita — admin, inexistente, usuário inativo,
  VÍNCULO adormecido —, hash fora da forma, senha/alfabeto/md5, máscara · AO VIVO em schema descartável `setes_superpw_probe_*` com cópias
  vazias de 4 tabelas e usuários 9xxxxx: lista só os Supers da institution 1 (vínculo adormecido = inativo), recusa admin / 'super' de
  outra institution / vínculo excluído / inativo / vínculo adormecido / inexistente sem escrita, redefine só o Super ativo com o MESMO
  hash e `activation_key` limpa; `setes_central` com impressão digital igual antes/depois · o script sem `--vai` contra o banco real =
  ensaio, só leitura, nada gravado).
- Provas em InnoDB real: `prove-password-reset-lock.ts` **9/9** (passo 8: CHECK recusa 'X' e 'e') · `adv-d-rs4-probe.ts` do gate
  **7/7** (P1 agora RESISTIU: o +1 sobrevive à falha do aviso; P4 kind minúsculo recusado).
- Suíte inteira do setes-api na worktree, DEPOIS das correções dos gates (com a máquina ocupada por outras sessões): ver §13.10.6
  (números finais); antes delas: 131 suítes · 2087 verdes · 31 pulados. `tsc --noEmit` limpo.

**Correções dos gates no código (2026-10-21, mesma sessão)**: SAVEPOINT `owner_notice` em volta da vaga (`claimOwnerNotice` — falha do
aviso = `ROLLBACK TO SAVEPOINT` + alarme com a rota de origem; 1213 sobe para o retry); `isProduction()` normalizado + `nodeEnvWarning()`
no boot e no pré-voo; `isMailerConfigured()` aparado; código ao log em dev também quando o SMTP falha (A-RS12 — a conferência do mailer
fica FORA do try para erro de bug subir à borda do job); timeouts do transporte (A-RS11); `npm start` → `scripts/start-production.js`
(A-RS9); "Super ativo" = usuário E vínculo (A-RS10); `--user-id` só dígitos e argumento repetido recusado; CHECK do `kind` com
`COLLATE utf8mb4_bin` (sql/67 + 01); texto do aviso válido para as duas causas (Q-RS12).

#### 13.10.4 Assunções executadas (a ratificar)

- **A-RS5** — a D-PV46 lida SEM as colunas que cita: elegibilidade pelo vínculo `tb_institution_has_user.kind = 'super'` na institution da
  Setes (como o `isSuper` do login); autoria em `tb_user.updated_at` + LOG do script + nota de operação; nenhum ALTER em `tb_user`
  (parecer do guardião: `updated_by` da casa = id de tb_user; gravar o id do super mentiria o autor).
- **A-RS6** — o aviso 'C' é tomado no pedido CALADO (o 4º na hora / 11º no dia), não no 3º emitido: "teto atingido" = alguém bateu nele.
- **A-RS7** — texto do aviso ÚNICO para as duas causas e sem link de ação (a causa é só forense; um link seria vetor de phishing por
  imitação).
- **A-RS8** — o Super inativo é recusado pelo script (reativar é ato pela tela de outro Super; o script não reativa) e o script recusa
  2+ Supers ativos (um define a do outro pela tela — complemento da D-PV46).
- **A-RS9** (gate socrático, Q-RS11) — `npm start` É produção: `scripts/start-production.js` liga `NODE_ENV=production` quando a variável
  está vazia e sobe o `dist/`; `npm run dev`/`tsx watch` seguem dev. Sem dependência nova (nada instalado na worktree — o `node_modules`
  é junção do vivo).
- **A-RS10** (gate socrático, Q-RS14) — "Super ativo" no script = `tb_user.active = 'S'` E `tb_institution_has_user.active = 'S'` (o
  predicado do login — `getInstitutionsForUser`); vínculo adormecido = recusa `inactive`.
- **A-RS11** (gate socrático, LOW) — o transporte SMTP ganha tetos de tempo (`connectionTimeout` 15 s, `greetingTimeout` 15 s,
  `socketTimeout` 30 s): um SMTP mudo não prende o trabalho em segundo plano por 10 min (padrão do nodemailer). Não muda o comportamento
  de sucesso.
- **A-RS12** (gate adversarial, LOW) — em DEV, se o SMTP configurado FALHAR no envio do código, o código vai ao log (antes ia a lugar
  nenhum e consumia o teto); em produção a falha do SMTP real fica só no log de erro — o código nunca vai ao log de produção (D-RS5).
  `isMailerConfigured()` apara o host (`SMTP_HOST` só espaços = não configurado, igual ao `mailerConfigProblems`).

#### 13.10.5 Questões (aguardam o Valdo — nenhuma trava a entrega)

- **Q-RS7 — script com 2+ Supers ATIVOS**: (a) recusar e apontar a tela (como executado — a exceção fica mínima; "os dois perderam a senha"
  fica sem saída além do SQL manual); (b) permitir com `--user-id` explícito (cobre "os dois perderam"; o log registra). **Rec.: (a)**
  enquanto houver UM Super; rever quando nascer o 2º.
- **Q-RS8 — momento do aviso 'C'**: (a) no pedido calado (executado — A-RS6); (b) na 3ª emissão da hora ("você usou o limite"); (c) só
  na TRANSIÇÃO para o teto (1 aviso por "episódio" de teto, não 1/h enquanto o atacante insistir — fecha o pior caso de 34 e-mails/dia
  do gate adversarial: 10 códigos + 24 avisos). **Rec.: (a)** enquanto o volume for teórico; (c) se o passeio ou um cliente mostrar fadiga.
- **Q-RS9 — `OPS_ALERT_EMAIL`/alarme de operação** quando o SMTP falha repetidamente no aviso (hoje: log de erro, sem alarme na
  crashlytics — falha de SMTP não é pane nossa): (a) manter; (b) alarme depois de N falhas seguidas. **Rec.: (a)** até a Onda 2 do prompt
  de autenticação (teto global + alarme) decidir o canal de operação (Q-EA4).

- **Q-RS10 — o +1 da tentativa errada deve SOBREVIVER à falha do INSERT do aviso?** (gate socrático, MEDIUM: na 1ª forma o aviso vinha
  DEPOIS do +1 na mesma transação, sem savepoint — um GRANT da Onda 4 que esquecesse a tabela irmã faria toda 5ª errada desfazer o +1 e o
  código nunca esgotaria). (a) **SAVEPOINT em volta da vaga — EXECUTADO na sessão**: falha só no aviso = `ROLLBACK TO SAVEPOINT` + aviso
  no log, o +1 e a 401 seguem; (b) vaga em transação própria sob a trava do usuário depois do COMMIT do +1 (rec. do gate); (c) manter o
  limite. **Rec.: (a) como está** — mantém o parecer do guardião ("na MESMA transação que detectou o gatilho") e protege o fato primário;
  (b) só se o savepoint incomodar.
- **Q-RS11 — marcador de produção (gate socrático, MEDIUM: `isProduction()` é opt-in — nada no repositório liga `NODE_ENV=production`;
  um deploy da Onda 4 que esqueça a variável deixa o SMTP opcional e o código no log)**: (a) **`npm start` passa a ligar
  `NODE_ENV=production` por padrão (`scripts/start-production.js`, sem dependência nova) — EXECUTADO (A-RS9)**; o único caminho fail-open
  fica sendo `npm run dev`/`tsx watch` (a árvore viva de hoje); (b) manter opt-in e item do roteiro. **Rec.: (a)** + item do roteiro da
  Onda 4 mesmo assim (o deploy pode não usar `npm start`).
- **Q-RS12 — texto do aviso para a causa C** (gate socrático, LOW: "basta pedir um novo código" falha em silêncio por até 1 h quando o
  teto foi atingido): o texto ÚNICO foi AJUSTADO na sessão para valer nas duas causas ("se precisar de um novo código, peça-o mais
  tarde — por segurança, os pedidos ficam limitados por um tempo"). (a) manter o texto único (como executado); (b) texto próprio para C
  dizendo "aguarde até 1 h" (o canal é só do dono — não fere a neutralidade da RESPOSTA). **Rec.: (a)**.
- **Q-RS13 — o reset do Super pelo operador deve deixar FATO durável e/ou avisar o Super por e-mail?** (gate socrático, LOW: hoje só
  `updated_at` + log no host do operador). (a) nada agora (guardião: o fato "senha inicial definida por terceiro" nasce com a onda 0 do
  convidado, D-UC8); (b) e-mail neutro ao e-mail de login do Super ("sua senha foi redefinida pelo operador em T; se não reconhece,
  avise") pela peça `@shared/mailer` — sem DDL; (c) (a)+(b) depois. **Rec.: (b)** — barato e fecha o sinal fora da máquina; fica para o
  "vai" porque muda o comportamento descrito na D-PV46.
- **Q-RS14 — "Super ativo" no script = `tb_user.active` E `tb_institution_has_user.active`** (gate socrático, LOW: o script ignorava o
  `active` do vínculo e listaria como ativo um Super que o login recusa com 403). **EXECUTADO na sessão (A-RS10)**: o mesmo predicado
  do login; vínculo adormecido = `inactive` (recusa). Ratificar.

#### 13.10.6 Gates do delta

- **Socrático (agente, skill `revisar-riscos-sistemicos`): 0,77 — PASSOU** (sem HIGH/CRITICAL). MEDIUM: (1) o +1 da tentativa errada
  podia ser desfeito pela falha do INSERT do aviso (fato secundário desfazendo o primário) → **corrigido**: `SAVEPOINT` em volta da vaga
  (`claimOwnerNotice`), falha do aviso = log de aviso, o +1 e a 401 seguem (Q-RS10); (2) `NODE_ENV=production` é opt-in → **corrigido**:
  `npm start` liga produção por padrão (`scripts/start-production.js`), `tsx watch` segue dev (Q-RS11). LOW: texto do aviso para a
  causa C → **ajustado** (Q-RS12); ato do operador sem fato/sinal fora da máquina → Q-RS13; "ativo" do Super ≠ do login → **corrigido**
  (Q-RS14); `sendMail` sem teto de tempo (nodemailer: 10 min) e `pendingJobs` sem teto → **mitigado**: `connectionTimeout`/
  `greetingTimeout`/`socketTimeout` no transporte (15 s / 15 s / 30 s — A-RS11). Julgamento dos pontos do executor: todos aceitos
  (vaga antes do e-mail, aviso ao dono legítimo, `trust proxy` na Onda 4, senha no stdout — registrar que transcript/CI capturam
  stdout —, EXISTS pela PK, pré-voo com conexão real, e-mail GRAVADO; aviso por USUÁRIO e não por institution está certo: a credencial é
  global — D-UC1/D-UC3). Dica arquitetural: fato secundário nunca desfaz fato primário; todo ato de operador deixa FATO no banco, não
  só log (→ Q-RS13).
- **Adversarial (agente, skill `testar-adversarial`): 0,76 — PASSOU** (sem HIGH/CRITICAL). 23 sondas jest em
  `src/__tests__/adversarial-d-rs4-gate.test.ts` (19 `[RESISTIU]` + 4 `[ACHADO]` que viraram `[CORRIGIDO]` na sessão) + 7 sondas em
  InnoDB real (`scripts/adv-d-rs4-probe.ts`, schema `setes_advrs4_probe_<pid>` apagado) + ensaio real do script do Super (só leitura).
  **MEDIUM (o mesmo do socrático)**: INSERT do aviso negado (1142, GRANT da Onda 4) → o +1 da 5ª errada era desfeito, `failed` ficava em 4
  e o código CERTO depois TROCAVA a senha — provado em InnoDB (CHECK extra na irmã: 7 erradas → 4; `changed`) → **corrigido** com o
  SAVEPOINT (a sonda agora prova que o +1 sobrevive e o certo é recusado). **LOW corrigidos**: `NODE_ENV` com caixa/espaço desligava a
  exigência em silêncio → normalizado (`Production`/`production ` = produção) e `prod`/`produção` NOMEADOS no resumo do boot e no pré-voo
  (`nodeEnvWarning`); `SMTP_HOST` só espaços contava como configurado (código ia a lugar nenhum) → `isMailerConfigured` apara + em dev o
  código vai ao log também quando o SMTP do dev FALHA (A-RS12); vínculo super `active='N'` contava como Super ativo → A-RS10; CHECK do
  `kind` sob `unicode_ci` aceitava 'e'/'c' → `COLLATE utf8mb4_bin` no sql/67 e no 01 (prova e sonda conferem 'X' e 'e'). **LOW
  registrados como limite**: atacante no teto diário provoca até 10 códigos + 24 avisos = 34 e-mails/dia à vítima (antes: 10) —
  dentro do "≤ 1/h" da D-RS4; alternativa = avisar só na TRANSIÇÃO para o teto (Q-RS8 (c)). INFO: `--user-id` repetido/`1e1` →
  **corrigido** (argumento repetido recusado; só dígitos). RESISTIU: tempo/corpo/status da 5ª errada iguais aos da errada comum e da conta
  inexistente (Δ < 300 ms no piso); SMTP lento 1,5 s não segura a resposta; aviso não entra no teto; e-mail GRAVADO (`strase@` → `straße@`);
  texto E ≡ C sem dígito/link/kind; 2 "5ªs" em paralelo = 1 vaga; E + C na mesma hora = 1; fronteira 59:59/60:00 pelo NOW() do banco;
  deadlock injetado no INSERT do aviso reexecuta a transação inteira; boot nomeia a tabela/decisão certa por ausência; porta/credencial/
  remetente nas variantes do `.env`; senha SMTP ausente de todo resumo/erro (inclusive o erro real do `verify`); senha inicial sem viés
  (χ² em 110 000 símbolos), hash = o que o `login()` compara. Não exercitado: GRANT real sem INSERT (emulado por CHECK), reinício entre
  COMMIT e SMTP, `verify` contra o SMTP real (feito à parte pelo pré-voo: autenticou), `--vai` (proibido).

- **Depois das correções dos gates**: `tsc --noEmit` limpo; suítes-alvo 86/86 (q-pv38 37 · gate q-pv38 26 · gate d-rs4 23) + mailer 17 +
  Super 11; provas InnoDB 9/9 e 7/7; **suíte completa da worktree: 132 suítes · 2112 verdes · 31 pulados (ao vivo) · 0 falhas**;
  nenhum schema descartável sobrando; `setes_central` sem as tabelas do 67 (não aplicado), como antes.

**Limites conhecidos do delta (conhecimento negativo)**: reinício do processo entre o COMMIT da vaga e o SMTP perde o aviso e a hora
fica tomada (mesmo limite do código); o dono legítimo errando 5× recebe o aviso (texto neutro — fadiga de alarme é o preço da D-RS4);
34 e-mails/dia no pior caso; a senha do Super impressa no stdout é capturada por transcript do PowerShell/CI — o operador escolhe o
terminal; `trilha-primeiro-cliente.ts`/`smoke-inter-sandbox.ts` seguem comparando `NODE_ENV === 'production'` estrito (recusam rodar em
produção — com `Production` rodariam; ferramentas de dev, fora do delta).

#### 13.10.7 Prompt novo — endurecer a autenticação (D-RS5 (a))

`Infra-IA/prompts/prompt_endurecer_autenticacao.md` — **Rodada 0 ORGANIZADA**: inventário conferido no código (300/min por IP no gateway;
`/auth/login` sem limite por conta, sem contador, sem alarme, sem rastro; senha mínima 5 em MD5 maiúsculo sem sal; JWT 24 h sem refresh e
sem revogação — a guarda não confere `active`/vínculo, D-UC9 vai conferir; "Usuário inativo" como oráculo; `trust proxy` desligado — D-RS2),
riscos R1…R6, proposta em 5 ondas (limite por conta no login no molde da recuperação → teto global + alarme → política de senha →
scrypt com migração transparente do MD5 → revogação por `iat × tb_user.updated_at`), questões **Q-EA1…Q-EA12** com recomendação. Só
documento; nenhum código.

## Decisões arquiteturais registradas

### Rodada 1 — respondida em parte (Valdo, 2026-10-18)

- **D-PV1** (Q-PV1 = (b), divergiu da Rec.) — *"mantenha tudo, ainda vamos usar"*: o catálogo recebe JÁ o conjunto devido de cada tela
  (VISUALIZAR + o CRUD do que ela faz + as ações), mesmo antes de o código conferir INSERIR/ALTERAR/EXCLUIR/IMPRIMIR — a onda da D-PV2
  é quem os torna efetivos. Conjunto no §3.1.
- **D-PV2** (Q-PV2 = (a)) — onda própria que torna o CRUD efetivo, com UM ponto de consumo de cada lado: a fábrica no app e a guarda por
  roteador na API (GET → V, POST → I, PUT → A, DELETE → E), exceções nomeadas; o seed da tela vai antes do app.
- **D-PV3** (Q-PV3, divergiu da Rec.) — *"ficam com privilegio e o super deve escapar de todas as verificacoes"*: as telas do grupo Super
  também têm privilégios no catálogo (quais: A-PV3); o super escapa de todas as verificações (alcance sobre a licença: A-PV1).
- **D-PV4** (Q-PV4, divergiu da Rec.) — mesma resposta: as interfaces kind 'R' também têm privilégios (quais: A-PV2).
- **D-PV9** (Q-PV9 = (a)) — lista única dos pares (interface, privilégio) que o código consome + cerca por varredura (rotas e `.dart`) +
  o boot confere contra o catálogo e grita (sem recusar subir).

### Rodada 2 — FECHADA (Valdo, 2026-10-18: "Siga as recomendações da Rodada 2 (A-PV1 a A-PV4, Q-PV5', Q-PV6, Q-PV7, Q-PV8') e monte o seed provado em schema descartável")

- **A-PV1 confirmada** — o super escapa também da LICENÇA: tela não contratada não barra o super. **Revê a D-F37 só para o super**
  (admin e regular seguem barrados pela licença). Código na onda da D-PV2: setes-api `requirePrivilege`/`requirePrivilegeFor`/
  `requireInterfaceFor` + nfse-api `requireBranchPrivilege`/`passScope` (caminho fiscal → com os gates). Até lá vale o comportamento atual.
- **A-PV2 confirmada** — `partnerships` e `billing` = VISUALIZAR + ALTERAR; FATURAR/CANCELAR/TRANSMITIR seguem na tela do RAMO (Q-G22),
  nunca em `billing`.
- **A-PV3 confirmada** — telas do Super = VISUALIZAR, INSERIR, ALTERAR, EXCLUIR; em `institutions` emitir a chave do sync = ALTERAR.
- **A-PV4 confirmada** — `users` e `modules` = V, I, A, E; `establishment` = V, A — no catálogo já (a guarda é a D-PV5).
- **D-PV5** (Q-PV5' = (a)) — `users` e `establishment` seguem do perfil admin (`adminGuard`); na onda da D-PV2 o cadastro de privilégios
  NÃO as oferece a usuário regular (o catálogo fica para os botões do admin/super). `modules` segue a D-GE20 (onda 0 do grupo).
- **D-PV6** (Q-PV6 = (a)) — `interface-fields` segue salvando sem conferir admin até a onda da D-PV2, quando a guarda por roteador
  (PUT → ALTERAR) passa a decidir.
- **D-PV7** (Q-PV7 = (a)) — atos das telas de processo no catálogo existente, sem privilégio novo: settlements baixa = I · estorno = E ·
  trocar cobrança = A · desconto = 8; bank-slips emitir = I · liquidar = A · cancelar/estornar = 7 · registrar no banco = 9 · PDF = 4;
  checks depositar/descontar/devolver/usar em pagamento = A · estornar = 7; cashier abrir = I · sangria/fechar = A; orders/order-returns
  excluir o aberto = E. Os 11 pares entram no seed 64; o código passa a conferir na onda da D-PV2.
- **D-PV8** (Q-PV8' = (a)) — rotina mensal (`POST /service-orders/monthly-run`) sob **FATURAR**; excluir OS aberta
  (`DELETE /service-orders/:id`) sob **EXCLUIR**; CANCELAR fica só para cancelar NOTA. **Fecha a Q-R5.5** do
  `prompt_primeiro_cliente_setes.md` (nota lá). Efeito na onda da D-PV2.

### Rodada 3 — Valdo, 2026-10-18 (na sessão da onda da D-PV2: "considere que a Setes é um cliente do próprio sistema e o admin da Setes segue o padrão dos outros clientes. Apenas o Superuser entrando é que tem acesso a tudo. O admin da Setes com as devidas liberações feitas pelo Super user vai poder alterar as interfaces disponíveis para os clientes" + as 6 respostas, todas pela recomendação)

- **D-PV10** (fecha a **Q-PV11 = (a)**) — **a Setes é um cliente como os outros**: o admin da Setes segue o padrão de todo admin (só telas
  CONTRATADAS, todos os privilégios delas); **só o SUPER tem acesso a tudo** (A-PV1). Consequências: (1) a licença no CRUD fica como está
  (sem tirar os painéis de sistema da conferência — a Q-PV11 (b) cai); (2) o contrato da Setes recebe, antes de publicar, as telas que os
  admins dela usam, a começar pelas ESTRUTURAIS que todo cliente novo ganha no onboarding (`users`, `modules`, `interface-configs`, além
  da `establishment` que já tem) — é isso que devolve a engrenagem (fuso, teto de desconto) — decisão de implantação com o "vai" e a lista
  do Valdo; (3) **morre o atalho de flags da institution 1** (`flag.service.ts`: "a própria Setes tem acesso a tudo") — o super já escapa
  das flags no middleware; conferido (2026-10-18, só leitura): as flags da Setes cobrem todos os módulos que o app usa.
- **D-PV11** — **delegação do contrato de telas dos clientes ao usuário da Setes**, só pela liberação do Super:
  (a) o que se delega = o CONTRATO de telas de cada cliente (`tb_institution_has_interface` — quais telas cada estabelecimento tem); o
      catálogo de interfaces segue só do Super;
  (b) a liberação é POR USUÁRIO e SÓ o Super concede: o privilégio da tela delegada é marcado no cadastro do usuário da Setes, e **até o
      admin da Setes precisa estar marcado** (exceção à regra "admin passa o privilégio" — mesma forma da A-GE2 da Módulos); o admin
      nunca concede a si mesmo nem a outro;
  (c) o usuário liberado NÃO altera o contrato da PRÓPRIA Setes — só o Super;
  (d) só essa tela é delegável agora; as demais do grupo Super seguem só do Super (entram uma a uma quando o Valdo pedir);
  (e) **tela própria** "Interfaces dos clientes" (interface nova no grupo Super, `institution-interfaces` — o glossário do guardião proíbe
      "contrato" em código; o vínculo é `_has_`), com VISUALIZAR + ALTERAR próprios — não reaproveita a tela Estabelecimentos, cujo ALTERAR
      emite a chave do sincronizador (A-PV3).

### Rodada 4 — Valdo, 2026-10-18 (respostas à Q-PV37 e à Q-PV38, na sessão da onda da D-PV2)

- **D-PV12** (fecha a **Q-PV37 = (b)** — Valdo DIVERGIU da recomendação (a)): "troca de senha não pode ficar sobre o SuperUser por se
  tratar de tarefa de rotina; caso só o super faça, teríamos que elevar o nível do usuário para super, que não pode porque super é apenas
  1; então o admin pode trocar senha de todos menos do super — temos apenas este usuário sofrendo exceções ao longo do sistema". Fica a
  regra do código (`assertAccountManageable`): o admin mexe na conta (senha, e-mail, ativo, exclusão) de todos do próprio
  estabelecimento, MENOS a do super (vínculo super vivo ou adormecido); o usuário LIBERADO pelo Super segue editável pelo admin da Setes —
  a liberação não muda quem gere a conta. Risco aceito (o MEDIUM restante do gate): o admin da Setes que troca a senha do liberado entra
  com a liberação dele — a defesa é a trilha (o autor da troca vai ao log) e a escolha de QUEM o Super libera. Sem código novo; a sonda do
  gate virou teste que fixa a semântica. **RATIFICADA pelo Valdo (2026-10-18, "D-PV12 - Ratifico").**
- **A-PV13** (assunção a ratificar — ponto em que a frase "só o super sofre exceção" difere do código): a conta com vínculo com OUTRO
  estabelecimento continua só do Super (403 `USER_MANAGED_BY_SUPER`). É a correção do HIGH 2 do gate: sem ela, o admin de um cliente
  trocaria a senha de quem também é usuário (ou admin) da Setes ou de outro cliente e entraria lá com aquele perfil — o login é global.
  Vínculo com vários estabelecimentos já é ato exclusivo do super (`saveInstitutionLinks`), então o caso é raro e o Super já é quem o cria.
- **D-PV13** (fecha a **Q-PV38 = (a)**): força bruta no código de 6 dígitos do `/auth/change-password` = tarefa própria, iniciada em
  sessão separada em 2026-10-18; fora desta onda. **EXECUTADA em worktree (§13, 2026-10-18 — NADA commitado; Q-RS1…Q-RS6 e A-RS1…A-RS4 aguardam o Valdo).**
- **A-PV13 — cenário do Valdo (2026-10-18), sem ratificar**: "tenho dois clientes, o cliente 1 é fornecedor do cliente 2. O cliente 2
  poderia criar um usuário (o mesmo usado no cliente 1) com permissões diferentes, como tirar relatório de estoque. O cliente 1, ao
  logar, poderia escolher entre a própria empresa ou a empresa em que é fornecedor, vendo diferentes permissões. Analise se abrimos uma
  frente para isso". **Análise (código conferido na worktree, só leitura)**:
  - JÁ EXISTE: o login com N estabelecimentos ("Escolha a empresa" — `/auth/login` devolve `select` + `/auth/select-institution`,
    `/auth/switch-institution` sem sair); privilégio POR schema (`tb_user_has_privilege` no schema de cada cliente) — permissões
    diferentes em cada empresa já são o modelo.
  - FALTA: o admin do cliente 2 VINCULAR um login que já existe — hoje o cadastro recusa com 409 "e-mail já usado como login de outro
    usuário" (`assertLoginEmailFree`) e o vínculo com vários estabelecimentos é exclusivo do super (`saveInstitutionLinks`). Esse 409 já
    revela a qualquer admin que o e-mail existe em algum cliente (vazamento menor, anterior à onda — entra na frente).
  - O cenário PRECISA da A-PV13: sem ela, o admin do cliente 2 trocaria a senha do usuário do cliente 1 e entraria no cliente 1 com o
    perfil dele. O que a frente acrescenta é o DONO DA CREDENCIAL: quem criou o login (cliente 1) gere senha/e-mail/exclusão, como na
    D-PV12; quem só convidou (cliente 2) gere apenas o próprio vínculo (ativo/inativo) e os privilégios no próprio schema — nunca a
    credencial. Hoje, com 2 vínculos, nem o admin do dono troca a senha (só o Super) — a frente devolve isso a ele.
  - Pontos da frente (decisões do Valdo): aceite do usuário convidado (convite pendente até ele aceitar no login) × vínculo direto;
    perfil do convidado (só `user`, nunca admin da empresa que convida?); licença/assento do convidado; se o convite se amarra à
    relação comercial (o cliente 1 é `tb_provider` no cliente 2 — guardião conceitual); a busca do login sem revelar se o e-mail existe;
    a trilha (quem convidou, quem aceitou). Coordenar com a frente do grupo de estabelecimentos (mesmo schema — D-GE): lá o problema é
    vizinho, mas o vínculo já é dentro do mesmo grupo.
- **Q-PV39 — abrir a frente "usuário convidado entre estabelecimentos"?** (a) sim, prompt próprio com Rodada 0 (inventário de auth/users/
  login do app + parecer do guardião) em sessão separada; a A-PV13 fica como está até a frente definir o dono da credencial; (b) não
  agora — a A-PV13 vale e o vínculo cruzado segue só pelo Super. **Rec.: (a)** — o login e o privilégio por schema já sustentam o
  cenário; falta o convite com dono da credencial, e é TRANSVERSAL (setes-api auth/users, setes-app login/usuários, frente do grupo).

### Rodada 5 — Valdo, 2026-10-18 (respostas às questões da cerca da D-PV9, §12.5: "Q-PV16 - a · Q-PV17 - a · Q-PV18 - a · Q-PV17 - a · Q-PV20 - a"; "A-PV12 — me relembre")

- **D-PV14** (Q-PV16 = (a)) — na fusão com a D-PV2, os pares dos módulos guardados vêm da `listGatedRoutes()` (a mesma tabela que a
  guarda usa em produção — uma verdade só); a lista à mão fica com o que não se deriva (atos fora do roteador, políticas de controller,
  guardas da nfse-api, botões do app); quem chegar por último ao `main` escreve o adaptador.
- **D-PV15** (Q-PV17 = (a)) — as telas Interfaces e Privilégios RECUSAM (409, nomeando o consumidor) tirar do catálogo um par da lista,
  renomear um privilégio consumido e as variações que dão no mesmo (§12.8). EXECUTADA.
- **D-PV16** (Q-PV18 = (a)) — a publicação PARA quando a conferência do catálogo acusa alarme (o boot continua só gritando). EXECUTADA no
  `build-web.ps1` + roteiro do seed (§12.8).
- **D-PV17** (Q-PV20 = (a)) — no app, a interface de um botão é a do MÓDULO da tela; navegar entre módulos troca o `CurrentInterface`
  pelo item do menu da tela de destino (sem o item no menu, `can` = falso). Entra na entrega da Q-PV13 (D-PV2).
- **D-PV18** (Valdo, 2026-10-18, noite — literal: *"este aplicativos nao precisam de recuperacao de senha remova tudo em relacao a
  recuperacao de senha"*) — **os aplicativos NÃO têm recuperação de senha.** Saem do `main`: as rotas públicas `POST /auth/recovery-password`
  e `POST /auth/change-password` (service + repository: os três acessos a `tb_user.activation_key`), o fluxo "Esqueci minha senha" /
  alteração por código do setes-app (`packages/core/src/auth`: 2 páginas, 2 usecases, eventos/estado do bloc, datasource/repositório, link
  do login, as duas rotas em `_publicAuthPaths`, 16 chaves i18n do bloco `auth`), a variável `APP_CHANGE_PASSWORD_URL` e o item "chave de
  recuperação" do `pre-deploy-tz-check.ts`. FICAM: a coluna `tb_user.activation_key` no DDL (sem escritor — DROP é decisão de DDL à parte)
  e a peça `@shared/mailer` (sem consumidor; consumidor previsto = e-mail de convite do usuário convidado, D-UC4). A senha de um usuário é
  definida e trocada SÓ pelo administrador no cadastro de usuários (D-PV12 segue valendo). **Supera a D-PV13** (Q-PV38 — a branch
  `recuperacao-senha` foi apagada; Q-RS1…Q-RS6/A-RS1…A-RS4 sem objeto) e, por construção, fecha o CRITICAL que ela corrigia (sem fluxo, sem
  porta). Efeito colateral: a **A-UC2** da frente do usuário convidado perde o objeto → **Q-UC25** lá. Abre a **Q-PV54** (senha perdida do
  Super). Cercas: `setes-api/src/__tests__/no-password-recovery-fence.test.ts` (varre `src/`, `scripts/`, `.env.example`; 404 nas rotas;
  o service exporta só login/selectInstitution/switchInstitution) e `setes-app/packages/core/test/no_password_recovery_fence_test.dart`.
  Executada na branch `sem-recuperacao-senha` (worktrees `D:\Gestao2027\sem-recuperacao\{setes-api,setes-app}`): commits api **fbf01a3**
  (tsc limpo; auth + cerca 26/26; gate do delta 0,80/0,84, sem HIGH) · app **ad50385** (analyze limpo; core 81/81; web 634 verdes/27 skip;
  18 chaves `auth.*` fora; D-F218 sem objeto) — sem push nem merge. Publicar = "vai", **API e app JUNTOS** (o app antigo chamaria rota que
  não existe), sem DDL e sem `errors:gen`; tirar `APP_CHANGE_PASSWORD_URL` do `.env` vivo.
- **D-PV19** (Valdo, 2026-10-20 — rodada "uma pergunta por vez", item 3b do §11.8.1: *"(a), siga a recomendação"*) — **o 3b executa JÁ
  na branch `privilegios-crud`**, limitado ao que D-UC1…D-UC5 já fixam: a exclusão de usuário (`removeUser`) sai, o e-mail de login
  fica imutável, "ativo" passa a ser o vínculo `tb_institution_has_user.active` do próprio estabelecimento, e a **A-PV13 morre** (o
  dono da credencial é o titular — D-UC3). O convite interceptado (D-UC4) e o aceite ficam para a onda 0 da frente do usuário
  convidado, que nasce depois da fusão desta branch. Cada item com testes e os dois gates do delta, antes do roteiro do §11.8.
- **D-PV20** (Valdo, 2026-10-20 — lista de telas do contrato da Setes, implantação da D-PV10 item (2): *"(a), siga a recomendação"*) —
  **o contrato da Setes recebe, antes do merge, TUDO o que as flags liberam hoje** (os 26 módulos que o atalho da institution 1 dava),
  incluindo as estruturais `users`, `modules`, `interface-configs` e `general-configs`: o contrato passa a dizer exatamente o que o
  atalho dizia e os dois admins não perdem tela nem engrenagem no dia do merge. O que a Setes não deva ter, o Super tira depois pela
  tela "Interfaces dos clientes" (D-PV11). Implantação: a lista sai de `tb_feature_flag` da Setes × catálogo vendável (grupo Super fora),
  conferida contra as 14 já contratadas, e entra em `tb_institution_has_interface` do `setes_setes` ANTES do seed 65 e do app (§11.8 item 1).
- **D-PV21** (Valdo, 2026-10-20 — fecha a **Q-PV10 = (b)**: *"(b), siga a recomendação"*) — **todo ato sobre o documento ABERTO é
  ALTERAR** (itens, negociação, cheques da negociação): INSERIR = abrir o documento (pedido, OS, devolução), EXCLUIR = apagar o
  documento aberto. Quem lança pedido precisa de I + A; quem só pode tirar item NÃO pode apagar o pedido. Mesmo princípio da D-PV8 (um
  verbo, um sentido, sobre o DOCUMENTO). Na branch `privilegios-crud`: as rotas de item/negociação de `orders`, `service-orders` e
  `order-returns` passam de I/A/E por verbo HTTP para `privilegeAct('ALTERAR')`; o app ganha a mesma leitura no gate dos botões de item.
- **D-PV22** (Valdo, 2026-10-20 — fecha a **Q-PV12 = (a)**: *"(a), siga a recomendação"*) — **a interface 'R' (aba de papel, ex.:
  `partnerships` em Clientes) tem licença PRÓPRIA**, vendida no contrato junto da tela-mãe (implantação + aba Interfaces do Super);
  sem contrato a aba não aparece. É a D-GE19 ao pé da letra. Implantação: `partnerships` entra na lista da Setes pela D-PV20 se a
  flag dela estiver ligada; o onboarding de cliente novo NÃO a dá por padrão (não é estrutural).
- **D-PV23** (Valdo, 2026-10-20 — fecha a **Q-PV14 = (a)**: *"(a), siga a recomendação"*) — **as três portas de escrita fora da guarda
  fecham pelo caminho que já existe**: (1) `state-tax-rates` (MVA/FCP por UF × NCM) sob `adminGuard` até a tela nascer; (2) `GET/PUT
  /api/entities/:id/tax` RETIRADAS — a tributação se grava na transação do PAPEL (aba Tributação) e a do emitente pelo Meu
  Estabelecimento (mesma resposta da Q-PV25); (3) `POST /api/billing/validate` sob FATURAR pela interface do RAMO, com o mesmo
  resolvedor do `/invoice` (`billing.interface-resolver`). Sem interface nova no catálogo. Na branch `privilegios-crud`, com teste de
  cada porta (403/404) e a sonda do adversarial que achou o `entities/:id/tax` virando cerca.
- **D-PV24** (Valdo, 2026-10-20 — fecha a **Q-PV15 = (b)**, DIVERGIU da recomendação (a)) — **o Super escapa TAMBÉM das conferências
  de licença que não são guarda**: `isInterfaceAcquired` do painel de campos/configs (o Super grava config/campo de tela que a
  institution não contratou) e a elegibilidade do menu da tela Módulos (para o Super, o catálogo inteiro de kind 'T' é elegível em
  qualquer cliente). A A-PV1 vale literalmente: "o super escapa de TODAS as verificações". Consequências registradas: (1) config gravada
  pelo Super em tela não contratada fica latente e passa a valer no dia em que a tela for contratada — limite conhecido, anotado na
  peça `@shared/interface-config`; (2) a **Q-PV36** perde metade do objeto (o `page_size` do próprio Super persiste); sobra só o caso do
  usuário LIBERADO da Setes (não super) na tela delegada — decidir lá. Execução: o bypass entra na mesma peça que já lê `isSuper` para a
  guarda (uma regra, um lugar), com teste que fixa a semântica nos dois pontos.
- **D-PV25** (Valdo, 2026-10-20 — fecha a **Q-PV21 por opção PRÓPRIA**, literal: *"melhor seria se existir um PRIVILEGIO/verbo
  CONFIGURAR, desta maneira podemos entregar de forma individualizada e configuravel para cada usuario"*) — **nasce o privilégio
  CONFIGURAR (id 11, próximo livre depois de CATALOGAR = 10 da branch `merchandise`)**: "pode ajustar o comportamento desta tela" —
  gravar o valor da INSTITUTION (`'I'`) de uma config e o `required`/`caption`/`mask` de um campo da tela X exige **CONFIGURAR em X**,
  por QUALQUER caminho (engrenagem da tela X → painel, ou painel solto no menu Sistema com X selecionada). Regras: (1) uma regra, um
  lugar — o service dos painéis (`interface-configs`, `interface-fields`) resolve o veredito pela interface ALVO, não pela do painel;
  o VISUALIZAR do painel só deixa navegar; (2) "Configurações Gerais" = CONFIGURAR em `general-configs` (substitui a exceção da A-PV8);
  (3) o override PESSOAL `'U'` (itens por página etc.) segue aberto a qualquer usuário (A-PV6) — CONFIGURAR é sobre o dado da
  institution; (4) admin passa sempre (D32) e o Super escapa (A-PV1/D-PV24); (5) catálogo: o par (interface × CONFIGURAR) existe para
  TODA interface que tem config ou campo no catálogo (`tb_interface_has_config`/`tb_interface_has_field`) — derivado do catálogo no seed
  (número a conferir na hora: 66 = merchandise, 67 = reservado ao terminal → **68**), e o ALTERAR dos painéis perde o consumidor (sai dos
  pares deles — regra C1 da D-PV9: par sem consumidor é defeito); (6) app: a engrenagem só aparece com `can('CONFIGURAR')` da
  `CurrentInterface` (C1: botão vem do catálogo) e o cadastro de usuário oferece CONFIGURAR por tela como qualquer outro verbo; (7) cerca
  da D-PV9: o par novo entra em `CONSUMED_PRIVILEGES` E no seed ANTES do app. **Absorve a Q-PV27** (o valor `'I'` é de quem tem
  CONFIGURAR na tela, regular incluído — a decisão 4 do Framework de Configurações passa a dizer isso; confirmação no item seguinte).
- **D-PV26** (Valdo, 2026-10-20 — fecha a **Q-PV27 = (a)**, absorvida pela D-PV25: *"(a), siga a recomendação"*) — **o valor da
  INSTITUTION (`'I'`) de uma config da tela X é gravado por quem tem CONFIGURAR em X, regular incluído**; a decisão 4 do Framework de
  Configurações (`prompt_framework_configuracoes_sistema.md`) passa a dizer isso (anotar lá como superada em parte: "só o admin" →
  "quem tem CONFIGURAR"; admin segue passando). O ALTERAR dos painéis `interface-configs`/`interface-fields` sai do catálogo deles (sem
  consumidor — C1); `interface-configs.service.ts:99` troca a conferência `isAdmin` pelo veredito CONFIGURAR da interface alvo.
- **D-PV27** (Valdo, 2026-10-20 — fecha a **Q-PV22 = (b)** pelo princípio que ele enunciou, literal: *"o privilegio TRANSMITIR precisa
  existir, por que inserir e alterar boleto, nao pode presumir a transmissao como privilegio"*) — **PRINCÍPIO: o privilégio nomeia a
  FINALIDADE do ato do usuário, nunca o transporte, e nenhum verbo presume outro** — nos dois sentidos: INSERIR/ALTERAR o boleto não
  presumem TRANSMITIR (falar com o banco é ato próprio: registrar, consultar, simular), e TRANSMITIR não presume o EFEITO. Conferido no
  código da branch (`bank-slips.routes.ts`): emitir = I · liquidar = A · cancelar/estornar = CANCELAR · registrar/consultar/simular =
  TRANSMITIR · PDF = IMPRIMIR (buscado no banco, mas a finalidade é o documento) — a regra do Valdo JÁ está satisfeita. Pelo mesmo
  princípio, **`POST /bank-slips/:id/reapply` passa de TRANSMITIR para o privilégio do EFEITO reaplicado**: ALTERAR quando reaplica a
  liquidação (L), CANCELAR quando reaplica o cancelamento (C) — decidido pela voz do evento, no handler, antes de executar. É o mesmo
  desenho que a nfse-api já tem: `reconfirm` fala com o fisco mas exige CANCELAR, porque a finalidade é cancelar. A A-PV7 fica
  ("consultar = TRANSMITIR": a finalidade da consulta É perguntar ao terceiro) menos o "reaplicar". Não abre questão nova; atos do
  sistema (emissão automática source 'A', webhook) seguem sem privilégio de usuário.
- **D-PV28** (Valdo, 2026-10-20 — fecha a **Q-PV23 = (a)**: *"(a), siga a recomendação"*) — **a onda publica em JANELA ÚNICA**: merge da
  API na árvore viva + recarga do app publicado na :5051 em seguida + conferência logo depois (roteiro do §11.8); sem modo "registra e
  deixa passar". Pré-condições da janela: D-PV20 aplicada (contrato da Setes completo), seed 65 e o seed do CONFIGURAR (D-PV25)
  aplicados ANTES do app, `errors:gen`, nfse-api reiniciada à mão (A-PV1). Vale enquanto não houver usuário regular vivo e a produção
  for uma máquina só; na Onda 4 (SaveInCloud) a janela ganha roteiro próprio.
- **D-PV29** (Valdo, 2026-10-20 — fecha a **Q-PV24 = (b)**, DIVERGIU da recomendação (a): *"b (… cache dos privilegios para evitar round
  trip)"*) — **cache em memória do VEREDITO** (licença + privilégio) por (institution, usuário, interface), TTL curto no molde do
  `flag.service` (60 s), **invalidado ao salvar privilégio (`tb_user_has_privilege`), contrato (`tb_institution_has_interface`) ou
  vínculo de usuário** no mesmo processo — revogação imediata enquanto houver um processo só. Limite conhecido registrado para a Onda 4
  (vários processos Node): revogação feita num processo vale nos outros só na expiração do TTL — por isso o TTL é curto e não há
  cache do veredito do SUPER (ele não consulta). A institution entra na chave do cache desde já (a D-GE3 só troca o que o veredito lê).
  Mesma peça única `privilegeVerdict`; teste que prova a invalidação e a expiração; a cerca M5 mede o antes × depois.
- **D-PV30** (Valdo, 2026-10-20 — fecha a **Q-PV25 = (a)** pelo MODELO que ele enunciou, literal: *"temos tres vias para a tributacao,
  tributacao geral pelo Menu, tributacao por produto via mercadoria especifica para o registro atual, e tributacao por cliente
  funcionando com mesmo mecanismo da mercadoria"*) — **a REGRA de tributação tem três vias, todas pelo cadastro de origem**: (1) geral,
  pela tela Regras de tributação (seletor coringa); (2) por PRODUTO, criada a partir do cadastro da mercadoria (painel de vínculos da
  onda 1 — `merchandise`, `selector.productId`); (3) por CLIENTE, criada a partir do cadastro do cliente com o MESMO mecanismo
  (`selector.entityId`). Na tela da regra os dois campos do seletor seguem somente leitura (D38 do faturamento). **Fato conferido no
  código (2026-10-20): a via (3) ainda NÃO existe** — nenhuma ação do cadastro de clientes cria a regra do cliente (a D38 a deixou como
  "candidata"); hoje uma regra com `entityId` não tem porta de criação. Vira entrega própria "regra de tributação por cliente, a partir
  do cadastro" (irmã do painel de vínculos da mercadoria; registrar no `prompt_modulo_products.md` §10 como item da onda 1 do app ou
  onda seguinte — numerar lá). **A rota avulsa `GET/PUT /api/entities/:id/tax` não é nenhuma das três vias**: ela grava
  `tb_entity_tax`, os FATOS fiscais da relação (consumidor, regime, Simples, CNAE, `ind_ie_dest`, ISS retido…), que já se editam na aba
  Tributação do PAPEL (cliente/transportadora/fornecedor, na transação dele) e, para o emitente, no Meu Estabelecimento com as
  validações. **As duas rotas saem** (= D-PV23 item 2); sem consumidor no app.
- **D-PV31** (Valdo, 2026-10-20 — fecha a **Q-PV26 = (a)**: *"(a), siga a recomendação"*) — **`PUT /api/core/theme` passa a exigir
  admin** (marca da empresa; o super escapa — A-PV1); **`GET /interface-configs/key/:k` fica ABERTA** a qualquer autenticado da
  institution (a tela precisa da config para se montar; config de comportamento não é segredo). Nota para depois: se o tema ganhar
  tela própria, o verbo natural é CONFIGURAR em `establishment` (D-PV25) — hoje admin basta.
- **D-PV32** (Valdo, 2026-10-20 — fecha a **Q-PV28 = (b)**, DIVERGIU da recomendação (a)) — **o papel PODE ter a entity do próprio
  estabelecimento** (cliente interno para OS, fornecedor de si mesma etc.), **mas a cadeia (razão social, IE/IM, endereços, contatos) e
  a aba Tributação ficam SOMENTE LEITURA quando a entity é a institution** — o emitente só se edita pelo Meu Estabelecimento, com as
  validações dele. Execução na branch `privilegios-crud`: (1) o 409 interino `ROLE_IS_OWN_ESTABLISHMENT` da CRIAÇÃO sai; a peça
  `@shared/entity/own-establishment.ts` vira predicado `isOwnEstablishment(entityId, institution)`; (2) a API é quem garante: nos
  services de customers/providers/carriers/collaborators, PUT que altere a cadeia ou `tb_entity_tax` de entity = institution → 409
  `OWN_ESTABLISHMENT_READ_ONLY` (código novo no catálogo), campos PRÓPRIOS do papel (carteira, vendedor, limite…) seguem editáveis;
  (3) o GET do papel devolve `ownEstablishment: true` e o app congela a cadeia e a aba Tributação com a frase "edite pelo Meu
  Estabelecimento" (UX; a regra é da API); (4) o papel vindo do sincronizador com a própria empresa deixa de ser limite interino — passa
  a ser editável nos campos do papel; (5) a sonda do adversarial (admin reescrevendo o emitente pelo papel) vira cerca permanente; (6) a
  (c) — tributação do EMITENTE separada da RELAÇÃO em peça datada — fica para a D-IB7, sem prazo.
- **D-PV33** (Valdo, 2026-10-20 — fecha a **Q-PV30 = (a)**: *"(a), siga a recomendação"*) — **trilha do vínculo de telas e da delegação
  em tabela de eventos append-only** (quem, estabelecimento alvo, interface, concedeu/revogou, quando; no molde dos `_event` do
  produto; tabela do GRUPO ou do estabelecimento conforme PADROES §12 — o vínculo é do estabelecimento hoje, do grupo na onda 1 do
  grupo/D-GE22, decidir a forma com o guardião). Escrita pelas DUAS portas (aba do Super e tela delegada "Interfaces dos clientes") e
  pela concessão do privilégio delegado (D-PV11). **Entrega própria DEPOIS da janela** (não trava a publicação; o log segue até lá):
  guardião → `PADROES_BANCO` + `revisar-ddl` → prova em schema descartável → migration numerada na hora.
- **D-PV34** (Valdo, 2026-10-20 — fecha a **Q-PV31 = (a)**: *"(a), siga a recomendação"*) — **a aba de interfaces do cliente grava a
  DIFERENÇA por marca**: cada clique concede ou revoga UM id (`POST`/`DELETE` do vínculo, ou `PUT` com `{interfaceId, linked}`), nunca a
  lista inteira; a API é idempotente por marca (conceder o já concedido = 200 sem evento). Casa com a D-PV33 (um evento por marca, com
  autor). Vale para as DUAS portas (aba do Super e tela delegada). Entra na onda `privilegios-crud` junto da tela
  `institution-interfaces` (D-PV11); o app reflete o estado devolvido pela API após cada marca.
- **D-PV35** (Valdo, 2026-10-20 — fecha a **Q-PV32 = (a)**: *"(a), siga a recomendação"*) — **a porta delegada só vincula interfaces
  VENDÁVEIS** (kind 'T'/'R' fora do grupo Super) **e não revoga as ESTRUTURAIS** (`users`, `modules`, `interface-configs`,
  `establishment` — as do `grantStructuralInterfaces`, mais `general-configs` se o onboarding a der): marca de estrutural pela porta
  delegada = 409 `INTERFACE_STRUCTURAL_LOCKED`; tela do grupo Super não aparece na lista dela. A aba do Super segue com o catálogo
  inteiro. A lista "estruturais" é UMA constante na peça `@shared/institution-interfaces`, consumida pelo onboarding e pela guarda.
- **D-PV36** (Valdo, 2026-10-20 — fecha a **Q-PV33 = (a)**: *"(a), siga a recomendação"*) — **a flag técnica (`tb_feature_flag`) MORRE
  para os módulos que passam pela guarda por roteador**: o vínculo `tb_institution_has_interface` é a ÚNICA licença (D-F37/D-PV2);
  `isModuleEnabled` deixa de ser consultado nesses módulos (o middleware de flag só vale para o que não tem tela: rotas de sistema,
  webhooks, sync). Execução por etapas: (1) na onda `privilegios-crud`, os módulos sob `gatedModule` ignoram a flag; (2) cerca que
  acusa flag viva sem consumidor; (3) o DROP das linhas/da tabela é DDL à parte (não nesta janela). O onboarding (`insertDefaultFlags`)
  para de criar flag para módulo guardado. Liga à D-GE22 item 3 (contrato de telas é do grupo).
- **D-PV37** (Valdo, 2026-10-20 — fecha a **Q-PV34 = (b)**: *"(b), siga a recomendação"*) — **o literal `id 1` ("a própria Setes") fica
  até a onda 1 do grupo**; os 5 lugares ganham a MESMA constante nomeada (`SETES_INSTITUTION_ID`) na peça `@shared/institution-interfaces`
  para a troca ser um ato só, e o roteiro da onda 1 do grupo (`prompt_frente_grupo_estabelecimentos.md`) recebe a nota: "trocar a
  constante pelo predicado do grupo/schema (linha do grupo, D-GE1)". Anotar lá ao fechar esta rodada.
- **D-PV38** (Valdo, 2026-10-20 — fecha a **Q-PV35 = (a)**: *"(a), siga a recomendação"*) — **a porta delegada NÃO lê o vínculo da própria
  Setes**: `GET /api/institution-interfaces/:id` com `:id` = `SETES_INSTITUTION_ID` pelo usuário liberado (não super) = 403, o mesmo
  veredito do salvar (D-PV11 item c); a lista já a esconde. Um predicado só (`isOwnVendorInstitution`) nas três portas (lista, leitura,
  escrita), com teste.
- **D-PV39** (Valdo, 2026-10-20 — fecha a **Q-PV36 = (a)**: *"(a), siga a recomendação"*) — **tela do Super DELEGÁVEL conta como
  adquirida pela Setes para as configs dela**: o predicado "adquirida" (`isInterfaceAcquired`) ganha a cláusula "ou interface delegável
  (D-PV11 item d) e a institution é a Setes" — vale para o override pessoal `'U'` do usuário liberado (itens por página) e para o valor
  `'I'` por quem tiver CONFIGURAR nela (D-PV25). Metade da questão já tinha caído pela D-PV24 (o Super escapa).
- **D-PV40** (Valdo, 2026-10-20 — ao ratificar a A-PV7, literal: *"considere que transmitir e consultar sao dois verbos
  independentes"*) — **nasce o privilégio CONSULTAR (id 12)**: perguntar ao terceiro (banco ou fisco) a situação de um documento, sem
  mudar estado nele. **TRANSMITIR** fica para o que MUDA estado no terceiro: registrar o boleto, transmitir a nota, simular o pagamento
  no sandbox (`pay-sandbox` grava no banco de testes). Mapa dos atos: boleto — `POST /bank-slips/refresh` e `/:id/refresh` = CONSULTAR,
  `/:id/register` e `/:id/pay-sandbox` = TRANSMITIR, PDF = IMPRIMIR, reaplicar = efeito (D-PV27); fisco (nfse-api) — `transmit` =
  TRANSMITIR, `refresh` = CONSULTAR, `reconfirm`/`cancel` = CANCELAR (finalidade); o lote do app = o verbo de cada item. O RODÍZIO e a
  passada de pendentes são atos do SISTEMA: a filtragem por ramo contratado (D-F46/D-F47, `passScope`) passa a conferir o par
  (interface do ramo × CONSULTAR) no catálogo, não TRANSMITIR. Catálogo: pares CONSULTAR para `bank-slips` e para as interfaces dos
  ramos (`orders`, `service-orders`, `order-returns`) no mesmo seed do CONFIGURAR (D-PV25 — número a conferir, 68); cerca da D-PV9:
  entra em `CONSUMED_PRIVILEGES` E no seed antes do app; app: botões "Consultar"/"Atualizar no banco/fisco" gated por
  `can('CONSULTAR')`. Princípio da D-PV27 mantido: o verbo nomeia a finalidade do ato.
- **D-PV41** (Valdo, 2026-10-20 — fecha a **Q-PV19 = (a)**, a resposta que tinha vindo repetida) — **o teste ao vivo do catálogo
  (`privilege-catalog-live.test.ts`) fica OBRIGATÓRIO na suíte padrão do setes-api**: vermelho = o seed não foi ao banco antes do código.
  Na Onda 4 (bancos separados) ele prova só o dev; a produção é coberta pelo roteiro de publicação (D-PV16). Sem código novo.
- **D-PV42** (Valdo, 2026-10-20 — fecha a **Q-PV50 = (a)** com REGRA a mais, literal: *"Mas o padrao e manter em ingles e renomear
  customers para cliente nao pode"*) — (1) **a guarda de chave congela TODA chave que o código usa para abrir ou montar uma tela**: a
  lista de rotas do app (`interfaceRoutes`, conferida pela cerca), as chaves com configs/campos no catálogo e `general-configs` — não só
  as dos pares de privilégio; (2) **a `i18n_key` é identificador TÉCNICO, em inglês, no formato da rota (`^[a-z][a-z0-9-]*$`, espelho
  de `/home/<chave>`), e NÃO se renomeia**: a tela Interfaces valida o formato na criação e recusa (409) a troca da chave de uma
  interface já existente — renomear não é ato do produto; o nome que o usuário vê é tradução (i18n do app, D-BA29: nome traduzido no
  banco = item próprio). Mudar uma chave, se um dia for preciso, é código + seed coordenados, nunca pela tela.
- **D-PV43** (Valdo, 2026-10-20 — fecha a **Q-PV51 = (a)**: *"(a), siga a recomendação"*) — **`tb_interface.i18n_key` única no BANCO
  entre as vivas**: coluna gerada STORED `i18n_key_live = CASE WHEN deleted='N' THEN i18n_key END` + UNIQUE sobre ela (NULL das
  excluídas não colide), no `setes_central`. Entrega própria de DDL, DEPOIS da janela: guardião (forma) → `PADROES_BANCO` §9 regra 10 +
  `revisar-ddl` → prova em schema descartável (inclusive o replay idempotente e a sonda do CHECK/UNIQUE pelo NOME no boot) → migration
  numerada na hora. Fecha a corrida do service e cobre o seed; a conferência no service fica como mensagem amigável (409 antes do erro
  de UNIQUE).
- **D-PV44** (Valdo, 2026-10-20 — fecha a **Q-PV52 = (a)**: *"(a), siga a recomendação"*) — **`-CatalogEnvFile` do `build-web.ps1` fica
  opcional enquanto o destino é o dev** (padrão = `.env` do setes-api irmão, com aviso); **obrigatório na publicação para OUTRO
  ambiente** — item do roteiro de deploy da Onda 4 (SaveInCloud): o roteiro passa o `.env` do destino e o script recusa publicar sem
  ele quando `-Target` ≠ dev. Anotar no prompt da Onda 4 quando ela abrir.
- **D-PV45** (Valdo, 2026-10-20 — fecha a **Q-PV53 = (b)**: *"(b), siga a recomendação"*) — **limite conhecido**: o conserto de duplicata
  da tela Interfaces não varre os contratos dos clientes; duplicata de chave não existe hoje (conferido), a criação está barrada e o
  UNIQUE da D-PV43 a elimina por construção — quando a D-PV43 entrar, o conserto perde o objeto e SAI do código (anotar na entrega
  do UNIQUE). Conhecimento negativo no comentário da peça até lá.
- **D-PV46** (Valdo, 2026-10-20 — fecha a **Q-PV54 = (a)**: *"(a), siga a recomendação"*) — **senha perdida do SUPER = procedimento do
  OPERADOR, exceção explícita e documentada**: script `setes-api/scripts/reset-super-password.ts` (roda no servidor, com o `.env` do
  destino; só para `tb_user.kind = 'super'`; gera senha inicial aleatória, grava com o MESMO hash do login, imprime uma vez, registra
  quem rodou e quando no log e em `updated_by`); nenhuma porta HTTP; descrito no roteiro de operação da Infra-IA (nasce com a Onda 4 —
  até lá, nota no `setes-api/CLAUDE.md`). Complemento quando houver dois Supers: um define a senha do outro pela tela de Usuários do
  Super (a D-PV12 só proíbe o ADMIN). Entrega própria, pequena, fora da janela de privilégios.
- **D-PV47** (Valdo, 2026-10-20 — na Q-UC26 da frente do convidado, literal: *"b...reforce com o codigo para dificultar a forca bruta
  na porta publica"*) — **REVOGA a D-PV18**: os aplicativos TÊM recuperação de senha, com a porta pública "Esqueci minha senha"
  reforçada contra força bruta = a entrega endurecida da **D-PV13/Q-PV38 (§13 deste prompt, que VOLTA A VALER)** — branch
  `recuperacao-senha` (setes-api d19de9d · sql e1aa574; sql/67 `tb_user_password_reset`), que NÃO tinha sido apagada de fato (conferido
  em 2026-10-20: worktrees `recuperacao-senha/{setes-api,sql}` e `origin/recuperacao-senha` existem). A branch `sem-recuperacao-senha`
  (api fbf01a3 · app ad50385) é DESCARTADA sem merge. Ficam de pé desta rodada: D-UC6 (a senha é do titular; o admin não troca a
  definitiva) e D-PV46 (script do operador para o Super — vale ainda como saída sem e-mail). Voltam à fila: **Q-RS1…Q-RS6 e
  A-RS1…A-RS4** (§13.6/§13.9). Numeração de seeds: 67 = recuperação; 68 = CONFIGURAR/CONSULTAR (D-PV25/D-PV40); 69 = terminal.
- **A-PV14 — RATIFICADA (Valdo, 2026-10-20; integridade do catálogo, não acesso — convive com a D-PV24)** — a guarda vale também para o super: ela protege o DADO do catálogo, não a
  permissão de quem edita.
- ⏳ **Q-PV19** — a resposta veio repetida como "Q-PV17 - a"; a confirmar. **A-PV12** — o Valdo pediu para relembrar; a ratificar.
- Gates do delta (§12.8): socrático 0,76 · adversarial 0,72 → re-prova 0,80 (sem HIGH), achados corrigidos; **Q-PV50…Q-PV53** abertas.

## Questões pendentes

Nenhuma. Ficam para entregas próprias: a onda da D-PV2 (guardas por roteador + gates na fábrica + A-PV1 + D-PV5/D-PV6/D-PV8) e a cerca
da D-PV9. Aplicar o seed 64 em `setes_central` = só com o "vai".
**Cerca da D-PV9 (§12, 2026-10-18)**: Rodada 5 DECIDIDA (D-PV14…D-PV17; D-PV15/D-PV16 EXECUTADAS — §12.8); aguardam o Valdo: ratificar a **A-PV12** e a **A-PV14**, confirmar a **Q-PV19** (a resposta veio repetida como Q-PV17) e decidir **Q-PV50…Q-PV53** (gates do
delta, §12.8 — nenhuma trava a entrega). Merge = "vai" (setes-api e setes-app nas worktrees `privilegios-catalogo`).
**Onda da D-PV2 (§11, 2026-10-18)**: ratificar **A-PV5…A-PV11**; **Q-PV10…Q-PV15 e Q-PV21…Q-PV29** aguardam o Valdo — a **Q-PV11** (licença
no CRUD tira do admin da Setes os cadastros não contratados e a engrenagem das telas contratadas) trava a PUBLICAÇÃO; Q-PV11/Q-PV15/
Q-PV21/Q-PV27 decidem juntas (mesmo caminho); a Q-PV13 e a Q-PV20 (da cerca) são a mesma família (o app só conhece
os privilégios da tela aberta pelo menu) — decidir juntas.
**D-PV10/D-PV11 (§11.9, 2026-10-18)**: a Q-PV11 FECHOU pela D-PV10 = (a); a Q-PV37 fechou pela D-PV12 (b) e a Q-PV38 pela D-PV13
(tarefa própria, em sessão separada); D-PV12 RATIFICADA. **Q-PV30…Q-PV36** aguardam o Valdo — nenhuma trava a entrega; a **A-PV13**
(conta com vínculo com outro estabelecimento segue só do Super) aguarda a **Q-PV39** (abrir a frente do usuário convidado — Rec. (a)). Publicar = "vai" com a lista de telas do contrato da Setes (implantação da D-PV10)
+ seed 65 antes do app.

**Q-PV38 (§13, 2026-10-18)**: ~~EXECUTADA em worktree~~ → **SUPERADA pela D-PV18 (mesma noite)**: os aplicativos não têm recuperação de senha;
a branch `recuperacao-senha` foi apagada e Q-RS1…Q-RS6 / A-RS1…A-RS4 morreram sem objeto. Da Q-RS5 sobra só a ideia "endurecer o login
(força bruta na senha)" — tarefa própria se o Valdo quiser (hoje o rate limit por institution/IP é o que há).
**Rodada 2026-10-20 EXECUTADA (§11.10, 2026-10-21 — D-PV19…D-PV40 nas worktrees `privilegios-crud`, NADA commitado; seed 68 provado em
descartável e NÃO aplicado; script da D-PV20 gerado e NÃO aplicado)**: aguardam o Valdo **Q-PV55…Q-PV58** (§11.10.5) e a ratificação de
**A-PV16…A-PV21** (§11.10.4); nenhuma trava a entrega — o roteiro de publicação revisto está no §11.10.7.
**Q-PV54 (nova, da D-PV18 — aguarda o Valdo)**: sem recuperação, a senha perdida de um usuário é redefinida pelo admin do estabelecimento
(D-PV12) e a do admin pelo Super (ou por outro admin do mesmo estabelecimento). **E a senha perdida do próprio SUPER?** (a) procedimento
documentado do operador — UPDATE do hash em `setes_central.tb_user` numa sessão administrativa, registrado com data/motivo como exceção
explícita (PADROES §3.1) **(Recomendado)** · (b) um 2º usuário super de reserva, com senha guardada fora do sistema · (c) nada (aceitar o
risco). Nenhuma trava a publicação da `sem-recuperacao-senha`.
