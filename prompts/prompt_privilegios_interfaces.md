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
C1 provado ao vivo; gates 0,80/0,78; NADA commitado; A-PV12 e Q-PV16…Q-PV20 aguardam o Valdo).**
**Onda da D-PV2 EXECUTADA em worktree em 2026-10-18 (§11 — guarda por roteador + A-PV1 na API e na nfse-api + fábrica do app; worktrees
`privilegios/*`, branch `privilegios-crud`; gates 0,76/0,82 com 2 HIGH anteriores à onda corrigidos por barreiras INTERINAS; NADA
commitado; A-PV5…A-PV11 a ratificar; Q-PV10…Q-PV15 e Q-PV21…Q-PV29 aguardam o Valdo — a Q-PV11 trava a PUBLICAÇÃO).**
**D-PV10/D-PV11 DECIDIDAS e EXECUTADAS na mesma worktree em 2026-10-18 (§11.9 — a Setes é cliente comum, D-PV10 fecha a Q-PV11 = (a);
tela delegável "Interfaces dos clientes"; seed `sql/65` provado, não aplicado; gates do delta 0,74 · adversarial 0,64 → re-prova 0,76;
NADA commitado; D-PV12 fecha a Q-PV37 = (b) — o admin troca a senha de todos menos do super; D-PV13 = Q-PV38 em tarefa própria;
Q-PV30…Q-PV36 + A-PV13 aguardam o Valdo).**
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

- **A-PV5** — as leituras cruzadas viram lista de apoio do PRÓPRIO módulo (regra vigente "módulo só fala com o seu /api"), reproduzindo o
  conjunto de hoje; a escrita cruzada "Devolver" fica como está (abrir devolução = INSERIR em `order-returns` — o sentido certo).
- **A-PV6** — `PUT /interface-configs/key/:moduleKey/:name` (o override PESSOAL do itens/página que TODA lista grava) aberto como a leitura
  por chave — e por ser aberto, **só `target: 'U'`**: o valor da institution (`'I'`) tem UMA porta, a do painel guardado (`PUT
  /:id/:name`); pela chave responde 403 `CONFIG_INSTITUTION_VIA_PANEL` (achado do gate socrático: eram duas portas para o mesmo ato, e a
  aberta era a mais fraca). O app só grava `'U'` pela chave.
- **A-PV7** — falar com o BANCO = TRANSMITIR (registrar — D-PV7 — e também consultar, simular no sandbox e reaplicar a voz dele), simétrico
  ao fisco, onde consultar também é TRANSMITIR (`nfse-api` `refresh`/rodízio).
- **A-PV8** — o privilégio da "Configurações Gerais" vale no painel de configs filtrado nela (vitrine + o `:id` dela); outra tela, só o do
  painel (`interface-configs`).
- **A-PV9** — canal API da conta bancária: toda escrita = ALTERAR (o inventário do §3 já dizia "canal = A").
- **A-PV10** — D-PV5 vale para qualquer usuário-alvo (o cadastro nunca oferece users/establishment; admin não precisa — passa o privilégio).
- **A-PV11** — A-PV1 alcança também as LEITURAS fiscais da nfse-api (`requireBranchInterface`, `requireAnyInterface`, `visibleInterfaces`) —
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
- **Q-PV13 — privilégios de OUTRAS interfaces no app (F6)**: (a) o `/api/core/menus` (ou `/me`) entrega, junto da tela, os privilégios das
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

### 11.8 Publicação — roteiro (só com o "vai"; NADA commitado)

1. Decidir a **Q-PV11** e, se (a), contratar na Setes as telas que os admins usam (conferir de novo que não há usuário regular vivo).
2. Juntar com a cerca da D-PV9 (sessão própria, worktree `privilegios-catalogo`): a lista dela deve ler `listGatedRoutes()` e os
   consumos do app (`CurrentInterface.can('NOME')` literal nas telas; a fábrica via `CrudPrivileges` — peça compartilhada a registrar
   com as telas que cobre) — avisado por mensagem; a cerca dela exige `requirePrivilege`/primitivas registradas: a guarda por roteador
   (`modulePrivilegeGate`) e as 3 primitivas novas de `require-privilege.ts` (`licensedFor`, `privilegeVerdict`, `denyPrivilege`) entram
   no registro dela no merge.
3. App: os branches `densidade`/`shell` mexem na `RegisterFormPage` — merge com atenção (o portão é um parâmetro e duas condições).
4. Publicar **API e app JUNTOS** (as rotas antigas que o app lia continuam existindo, mas o app novo precisa das rotas próprias); nfse-api
  = restart manual (produção roda tsx SEM watch).
5. `npm run errors:gen` no setes-api (3 códigos novos: `PRIVILEGE_ADMIN_PROFILE`, `CONFIG_INSTITUTION_VIA_PANEL`,
   `ROLE_IS_OWN_ESTABLISHMENT`; e a descrição do `INTERFACE_NOT_ALLOWED` mudou — o super passa).
6. O commit da onda leva as sondas dos gates (`adversarial-pv2-gate.test.ts` nos dois repositórios — achado confirmado vira teste).
7. Depois: a onda 0 do grupo troca o `adminGuard` da `/api/modules` por `gatedModule('modules', modulesRoutes)` (uma linha) + D-GE3
   (o `privilegeVerdict` passa a receber a institution — Q-PV24).

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

- **A-PV12** — `order-returns × CANCELAR` e `× TRANSMITIR` são consumidos só pela guarda do RAMO (`/billing/cancel…` e a nfse-api
  resolvem a interface pela `vw_order_interface`) e ficam AUSENTES do catálogo por decisão (`absentBy`): cancelar devolução é a Onda 2 do
  cancelamento (`invoice-cancel.ts:163` responde 409) e devolução é NF-e (a nfse-api não emite por ela). A tela não tem o botão. A marca
  deixa de valer se um botão consumir o par.

### 12.5 Questões — Rodada 4 (gates da D-PV9; nenhuma trava a entrega)

- **Q-PV16 — fusão com a D-PV2**: (a) **os módulos guardados entram pela `listGatedRoutes()` da D-PV2** (uma verdade só) e a lista à mão
  fica para o que não se deriva (atos fora do roteador, políticas, guardas da nfse-api, botões do app); quem chegar por último ao `main`
  escreve o adaptador (combinado por mensagem); (b) lista 100 % à mão (~130 entradas) com a cerca conferindo igualdade. **Rec.: (a)**.
- **Q-PV17 — o C1 em tempo de execução**: tirar um par da lista pela tela Interfaces (o `syncInterfacePrivileges` apaga o que não veio no
  array) ou renomear um privilégio consumido na tela Privilégios recria o C1 na hora — o boot só vê no próximo restart. (a) **as duas
  telas recusam (409, nomeando o consumidor)** — integridade do catálogo, não autorização, então não contradiz a D-PV3; (b) só pedem
  confirmação; (c) limite conhecido. **Rec.: (a)**.
- **Q-PV18 — publicação bloqueante**: (a) **o roteiro de publicação (deploy do setes-api/app e aplicação de seed de privilégios) roda
  `scripts/check-privilege-catalog.ts` e para com exit 1** — a D-PV9 só proíbe o BOOT de recusar subir; (b) só documentado. **Rec.: (a)**.
- **Q-PV19 — o teste ao vivo na suíte padrão**: (a) **obrigatório, como está** — a suíte do setes-api já exige o banco em dezenas de
  suítes, e o banco do dev é o de produção (vermelho = o seed não foi ao banco ANTES do código); na Onda 4 (bancos separados) ele prova só
  o catálogo do dev e o roteiro (Q-PV18) cobre a produção; (b) opt-in no molde do `F2A_ADV_LIVE`. **Rec.: (a)**.
- **Q-PV20 — a interface de um botão no app**: hoje é a do ÚLTIMO item clicado no menu (`CurrentInterface`), não a do módulo da tela:
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
  sessão separada em 2026-10-18; fora desta onda.
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

## Questões pendentes

Nenhuma. Ficam para entregas próprias: a onda da D-PV2 (guardas por roteador + gates na fábrica + A-PV1 + D-PV5/D-PV6/D-PV8) e a cerca
da D-PV9. Aplicar o seed 64 em `setes_central` = só com o "vai".
**Cerca da D-PV9 (§12, 2026-10-18)**: ratificar a **A-PV12**; **Q-PV16…Q-PV20** aguardam o Valdo (nenhuma trava a entrega; merge = "vai").
**Onda da D-PV2 (§11, 2026-10-18)**: ratificar **A-PV5…A-PV11**; **Q-PV10…Q-PV15 e Q-PV21…Q-PV29** aguardam o Valdo — a **Q-PV11** (licença
no CRUD tira do admin da Setes os cadastros não contratados e a engrenagem das telas contratadas) trava a PUBLICAÇÃO; Q-PV11/Q-PV15/
Q-PV21/Q-PV27 decidem juntas (mesmo caminho); a Q-PV13 e a Q-PV20 (da cerca) são a mesma família (o app só conhece
os privilégios da tela aberta pelo menu) — decidir juntas.
**D-PV10/D-PV11 (§11.9, 2026-10-18)**: a Q-PV11 FECHOU pela D-PV10 = (a); a Q-PV37 fechou pela D-PV12 (b) e a Q-PV38 pela D-PV13
(tarefa própria, em sessão separada); D-PV12 RATIFICADA. **Q-PV30…Q-PV36** aguardam o Valdo — nenhuma trava a entrega; a **A-PV13**
(conta com vínculo com outro estabelecimento segue só do Super) aguarda a **Q-PV39** (abrir a frente do usuário convidado — Rec. (a)). Publicar = "vai" com a lista de telas do contrato da Setes (implantação da D-PV10)
+ seed 65 antes do app.
