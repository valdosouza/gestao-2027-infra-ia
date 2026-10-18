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
  `tb_user_has_privilege` — decidir as duas juntas.
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

## Questões pendentes

Nenhuma. Ficam para entregas próprias: a onda da D-PV2 (guardas por roteador + gates na fábrica + A-PV1 + D-PV5/D-PV6/D-PV8) e a cerca
da D-PV9. Aplicar o seed 64 em `setes_central` = só com o "vai".
