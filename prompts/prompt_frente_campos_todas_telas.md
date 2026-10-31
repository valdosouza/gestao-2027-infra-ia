# Frente — Campos configuráveis em TODAS as telas (cobertura do `interface-fields`)

**Escopo**: setes
**Status**: Rodadas 1 e 2 FECHADAS (2026-10-31 — D-CF1…D-CF5); Rodada 3 = cruzamento com a frente auth-api (§3.2 — **D-CF6**: lado API do
motor vira biblioteca que a auth-api também chama; **A-CF1 RATIFICADA**: o setes-api mantém o SELECT no registro e na licença, perde só a
escrita) — **NENHUMA questão aberta na frente**; nada disso trava a onda 4a; **roteiro de execução no §5 (2026-10-31, proposta — não decide)**; execução = onda própria DEPOIS do merge do bloco de privilégios (passo 4a do §2 de
`plano_retomada_2026-10-21.md`); `terminal`, `merchandise` e a D-IB99 (establishment) adotam o motor na própria frente — `terminals` JÁ
cumpre na branch (§2.1). (antes: Rodada 0 ORGANIZADA 2026-10-27 — inventário feito)
**Origem**: D-PV54 (Q-PV57 = (b), `prompt_privilegios_interfaces.md`) — o painel de campos vira ESTRUTURAL; o Valdo pediu, literal:
*"vamos com a opcao b....mas quero ter certeza se todas e como é estrutural devem ser todas as telas utlizem interface-fields...confirme
ou abra uma frente para resolver isso antes de avancar"*
**Transversal**: setes-api (módulos + `shared/field-config`), setes-app (páginas + `app/shared/field_config` + `app/shared/register`),
`sql/` (seeds de `tb_interface_has_field`). Não toca setes-sync (o sincronizador é ISENTO da obrigatoriedade comercial — decisão 17 da
Fase 2).

---

## 1. O que é o motor (resumo — fonte: `Infra-IA/setes-app/prompt_fase2_campos_configuraveis.md`)

Três camadas por TELA (interface):

1. **Catálogo** `setes_central.tb_interface_has_field` — os campos da tela, com o baseline técnico (obrigatório = DDL NOT NULL ∪ DTO),
   tipo e máscara padrão. Gerado por `setes-api npm run fields:gen` e semeado em `sql/` junto da interface. Sem reuso entre interfaces
   (tradeoff aceito na Fase 2).
2. **Ajuste do cliente** `tb_institution_has_field` (schema do cliente) — obrigatório/rótulo/máscara; o cliente só APERTA, nunca afrouxa.
3. **Aplicação** — o app lê `GET /api/interface-fields/key/<tela>` (rota aberta) e faz o merge custom → catálogo → código
   (`FieldConfigLoader` + `applyFieldConfig`); a API confere a mesma obrigatoriedade no salvar (`assertClientRequired`).

Edição: painel "Campos das Interfaces" (menu Sistema) e a engrenagem de cada tela — exige CONFIGURAR na tela-alvo (D-PV25). Com a
D-PV54 o painel é estrutural: todo cliente o recebe; a pergunta desta frente é se TODA tela responde a ele.

## 2. Inventário (Rodada 0 — 2026-10-27)

Método: script de leitura (`campos_inventario.py`, scratchpad da sessão) sobre a worktree `privilegios/` (setes-app + setes-api = `main`
+ bloco de privilégios) e os seeds de `sql/`. Colunas: **catálogo** = há linha em `tb_interface_has_field` em algum seed; **app** = a
página usa o motor; **api** = o módulo chama `assertClientRequired`. ⚠️ Limites: o banco estava PARADO — linha de catálogo gravada
direto no banco (sem seed) não aparece; "app"/"api" é por busca textual no módulo (página que usa o motor por peça compartilhada fora
da pasta do módulo aparece como N — conferir caso a caso na execução).

| Situação | Telas | Nº |
|---|---|---|
| **Completo** (catálogo + app + api) | bank-accounts, bank-charge-agreements, banks, cfop, cities, contracts, countries, interfaces, modules, payment-types, privileges, service-tax-rules, services, settlement-rules, states, users | 16 |
| **App sem o motor** (catálogo + api) | categories (árvore), financial-plans (árvore), service-orders (processo), settlements (processo), tax-rules (6 abas) | 5 |
| **Sem catálogo** | price-lists (app + api), salesmen (só app), orders (só api) | 3 |
| **API sem conferência** | service-list (catálogo + app), salesmen | 2* |
| **Nada** — cadeia de entidade | customers, collaborators, carriers, providers, establishment, institutions | 6 |
| **Nada** — processo | bank-slips, cashier, checks, order-returns | 4 |
| **Nada** — painéis do sistema | interface-configs, interface-fields, institution-interfaces | 3 |
| **Nascendo sem** (outras branches) | terminals (branch `terminal`, onda 0), merchandise (branch `merchandise` — app da onda 1 ainda não feito) | 2 |

\* salesmen conta em "sem catálogo" e em "API sem conferência". `partnerships` (aba 'R' de Clientes) tem catálogo no seed 17 e nenhum
módulo próprio no app (vive dentro de customers).

**Conclusão da Rodada 0**: NÃO dá para confirmar "todas as telas" — 16 de 38 módulos do app cumprem as três camadas. Os buracos têm
padrão: árvore, processo, abas, cadeia de entidade (peça compartilhada `@shared/entity` / `app/shared/entity`) e painéis do sistema.

### 2.1 Reconferência (2026-10-31 — mesmo script, sobre o `main` e as worktrees `privilegios`, `terminal`, `merchandise`)

- **`main`** (setes-api f53a618 · setes-app a450909 · sql 9f4fcf3): IGUAL ao inventário — 16 completas, nenhuma tela coberta desde 27/10.
  A worktree `privilegios` só acrescenta `institution-interfaces` (painel, fora do escopo pela D-CF1).
- **CORREÇÃO da linha "Nascendo sem"**: `terminals` (branch `terminal`, commit de salvaguarda 2026-10-27) JÁ cumpre as três camadas — seed
  69 com as linhas de `tb_terminal` (`description`, `kind`, `active`), `FieldConfigLoader` + `applyFieldConfig` na `terminal_page.dart`,
  `assertClientRequired(…,'terminals')` no POST/PUT. Na onda, só entra na cerca.
- **`merchandise`** (branch `merchandise`): catálogo (seed 66) + `assertClientRequired(…, MERCHANDISE_FIELD_PATHS)` na API; falta o app
  da onda 1 (a regra já está no `prompt_modulo_products.md`, linha "Campos configuráveis").
- **Catálogo órfão**: a interface 18 `partnerships` (kind 'R' desde o seed 20 — a parceria virou ABA de Clientes, API em `/api/customers`)
  tem 4 linhas vivas no catálogo (`tb_customer_id`, `tb_collaborator_id`, `rate`, `active`) que nenhum código lê nem confere → a cerca da
  D-CF2 reprovaria ("linha do catálogo que nenhum código declara"). Vira a **Q-CF5**.
- Limite que continua valendo: banco PARADO — linha gravada direto no banco não aparece; a execução confere no banco vivo (§5.1).

## 3. Rodada 1 — questões (uma por vez)

- ✅ **Q-CF1 → D-CF1 (2026-10-27, (a)).** Texto original: **o que é "todas as telas"**: (a) **toda tela que GRAVA dado digitado pelo usuário** — cadastro comum, árvore, entidade e
  processo (inclusive os diálogos do processo: abrir caixa, emitir boleto, devolução) —, fora os painéis do sistema que só editam
  CONFIGURAÇÃO de outra tela (interface-fields, interface-configs, institution-interfaces); (b) só CADASTROS (lista+formulário, árvore,
  entidade) — processo fora; (c) literalmente todas, inclusive os painéis. **Rec.: (a)** — onde o usuário digita, o cliente pode querer
  apertar; painel de configuração não tem dado próprio a apertar.
- ✅ **Q-CF2 → D-CF2 (2026-10-27, (a)).** Texto original: **gate validador, no molde da D-PV50/D-PV51**: campo declarado no código da tela (app + DTO da API) = campo no catálogo, nos
  dois sentidos, cobrado por cerca no teste e na publicação (alarme no boot, D-PV52). (a) **sim, cerca por tela**; (b) só a regra
  escrita nas skills (como hoje). **Rec.: (a)** — sem cerca, a tela nova nasce sem o motor (é o caso de `terminals` agora).
- ✅ **Q-CF3 → D-CF3 (2026-10-27, (a)).** Texto original: **cadeia de entidade**: o catálogo é POR PAPEL (customers, collaborators, carriers, providers, establishment, institutions —
  cada um com as suas linhas, coerente com "sem reuso entre interfaces" da Fase 2), mas o formulário é a peça compartilhada. (a) **por
  papel, a peça recebe a config da interface que a monta**; (b) um catálogo único da cadeia. **Rec.: (a)** — mantém a decisão da Fase 2
  e cada papel pode apertar diferente (ex.: e-mail obrigatório só no cliente).
- ✅ **Q-CF4 → D-CF4 (2026-10-31, (a)).** Texto original: **quando executa**: (a) **onda própria DEPOIS do merge do bloco de privilégios** (a D-PV54 só mexe em listas de contrato e não
  depende da cobertura; as telas que já têm o motor funcionam no dia do merge), com as branches `terminal`/`merchandise` adotando o motor
  antes do merge delas; (b) a cobertura entra ANTES do merge do bloco. **Rec.: (a)** — o "antes de avançar" do Valdo fica cumprido nas
  DECISÕES (esta rodada fecha antes da Q-PV58), e o código não trava a cadeia de merges.

### 3.1 Rodada 2 — 2026-10-31, FECHADA no mesmo dia (achado da reconferência do §2.1)

- ✅ **Q-CF5 → D-CF5 (2026-10-31, (a)).** Texto original: **o catálogo da parceria** (interface 18 `partnerships`, recurso vendável kind 'R' que virou ABA de Clientes no seed 20; API da
  aba em `/api/customers`): as 4 linhas vivas do catálogo dela não têm leitor no app nem conferência na API, e a cerca da D-CF2 as
  reprovaria. (a) **a aba de parcerias aplica o catálogo da interface `partnerships`** — no app a aba, montada dentro de Clientes, carrega
  a config de `partnerships`; na API o salvar da parceria confere com `assertClientRequired(…,'partnerships', …)`; a cerca confere a aba
  contra a interface 18 (molde da D-CF3, com a diferença de que quem monta é Clientes e o dono do dado é o recurso); (b) as linhas da 18
  morrem (soft delete) e os campos da parceria entram no catálogo de `customers` — a aba vira só parte da tela Clientes; (c) exceção
  PERMANENTE nomeada na cerca, sem motor na aba. **Rec.: (a)** — o recurso é vendido à parte (decisão 13 do Framework de Configurações),
  cada interface tem o seu catálogo (Fase 2, "sem reuso") e as linhas já existem; (b) mistura no catálogo de Clientes campos de um recurso
  que o cliente pode não ter contratado. Não trava a Rodada 1 nem o bloco de privilégios; precisa estar decidida antes do bloco C (§5.3).

### 3.2 Rodada 3 — cruzamento com a frente auth-api (2026-10-31)

Pedido do Valdo, antes do commit: *"verifique o que vai interferir e vamos nos ajustar se preciso for"*. Lido o
`prompt_frente_auth_api.md` no estado de 31/10 17:35 (D-AU1…D-AU4 decididas; Q-AU5…Q-AU12 abertas) e conferido no código
(`privilegios-crud`) o que o motor de campos usa do lado do acesso:

- `shared/field-config/field-config.repository.ts:48` — resolve a tela pela chave: `SELECT id FROM setes_central.tb_interface WHERE
  i18n_key = ?` (em toda montagem de tela e em todo `assertClientRequired`);
- `modules/interface-fields/interface-fields.service.ts` — `interfaceAcquiredFor` (licença) e `canConfigure`/`assertCanConfigure`
  (CONFIGURAR, D-PV25).

| Decisão / questão da auth-api | Efeito na frente de campos | Ajuste |
|---|---|---|
| **D-AU1** (campos e configs NÃO são da auth-api; ela recebe os escritores na A2) | catálogo e ajuste ficam no setes-api — D-CF1…D-CF5 de pé. Mas o salvar de `users`, `privileges`, `interfaces` (3 das 16 telas completas), `institution-interfaces` (painel, fora) e das abas de licença/usuários de `institutions` sai do setes-api, e com ele o `assertClientRequired` | **Q-CF6** |
| **D-AU2** (registro `tb_interface` é da auth-api; campos/configs "seguem apontando pela chave") | "seguem" = como hoje: o contrato do motor já é pela chave. Com a D-AU4 a tabela fica em `setes_central` → a coluna `tb_interface_id` fica, sem DDL. O id passa a ser cunhado pela auth-api: o seed de campos de tela NOVA roda depois do registro dela | §5.1 item 5 corrigido |
| **D-AU3** (veredito pela view `vw_user_access`; `role` sai do token) | licença e CONFIGURAR do painel passam a vir de `@shared/access` (costura A1) — mesma regra, outra fonte; a montagem da tela (rota aberta) não muda | a onda parte do `main` depois da A1, se a Q-AU6 a puser no bloco de privilégios |
| **D-AU4** (híbrido: o setes-api "perde a escrita por GRANT", leitura pela view) | o motor precisa LER o registro (tela pela chave) e a vitrine do painel precisa da licença do ESTABELECIMENTO (todas as telas, as adquiridas em destaque — decisão 6 da Fase 2), que a view por usuário não responde | **A-CF1** |
| Q-AU5 (credencial separada — aberta) | o catálogo de `users` (seed 07) mistura cadeia (`name_company`, `nick_trade` em `tb_entity`), e-mail de login (`tb_mailing`) e `tb_user` (`password`, `active`); com a credencial no `auth_api` a tela fica com campos em dois donos | dentro da Q-CF6 |
| Q-AU6 (ordem — aberta) | decide se a A1 entra no passo 4 (bloco de privilégios) | nenhum: o passo 4a já é "depois do 4" e herda |
| D-CF5 × D-AU2 (`kind` 'R' passa a ser dado da auth-api) | a parceria segue pela chave `partnerships`; a licença do recurso, pela view | nenhum |

- ✅ **A-CF1 RATIFICADA** (Valdo, 2026-10-31, literal: *"Ratificar A-CF1"*) — leitura da D-AU4 pela frente de campos: o setes-api PERDE a ESCRITA no registro e nas concessões, mas MANTÉM o
  SELECT em `tb_interface` (resolver a tela pela chave — motor de campos, catálogo de configs, menu) e em `tb_institution_has_interface`
  (vitrine do painel de campos: o que o estabelecimento adquiriu); o VEREDITO (licença × usuário, CONFIGURAR) vem só da view. Sem esse
  SELECT o motor deixa de achar a tela. É detalhe de execução da D-AU4 — precisa constar também na frente auth-api.
- ✅ **Q-CF6 → D-CF6 (2026-10-31, (a)).** Texto original: **o motor nas telas cujo salvar vai para a auth-api** (`users`, `privileges`, `interfaces` — hoje completas — e as abas de
  licença e usuários de `institutions`; a A2 leva os escritores e a D-AU1 deixou campos fora da auth-api): (a) **o lado API do motor vira
  BIBLIOTECA** — a regra de `@shared/field-config` num subpath compartilhado (molde do `fiscal-api/reading`, D-F33); a auth-api confere com a
  MESMA peça, lendo o catálogo (`setes_central`) e o ajuste do cliente (schema do cliente) por view/GRANT mínimo (molde D-F15); o catálogo
  segue sendo do setes-api, e a tela com campos em dois donos (`users`) tem UM catálogo, conferido por quem recebe cada parte; (b) as telas
  de ADMINISTRAÇÃO DE ACESSO saem do escopo da D-CF1, como os painéis de configuração — o catálogo delas morre (soft delete) na A2; (c) o
  salvar dessas telas passa antes pelo setes-api (fachada) — chamada entre serviços que a D-F4/D-AU3 evitaram. **Rec.: (a)** — onde o
  usuário digita o cliente pode apertar (critério da D-CF1) e a regra fica em UM lugar; (b) devolveria ao "nada" 3 telas hoje completas.
  Não trava a onda 4a (essas telas não são tocadas nela); precisa estar decidida antes da A2 da auth-api.

## 4. Decisões

- **D-CF1** (Valdo, 2026-10-27 — fecha a **Q-CF1** = (a), literal: *"toda tela que grava dado digitado (cadastro, árvore, entidade e
  processo, com os diálogos), fora os painéis de configuração"*) — o motor de campos (catálogo + app + API) é OBRIGATÓRIO em toda tela
  que grava dado digitado pelo usuário: cadastro comum, árvore, cadeia de entidade e tela de processo, inclusive os diálogos do processo
  (abrir/fechar caixa, emitir boleto, devolução, negociação, cheques…). Fora: os painéis que só editam a CONFIGURAÇÃO de outra tela
  (`interface-fields`, `interface-configs`, `institution-interfaces`). Pelo inventário do §2 entram no escopo as 19 telas que hoje não
  cumprem as três camadas + `terminals` e `merchandise` (contagem corrigida em 2026-10-31: o texto dizia "22 … fora os 3 painéis", mas os
  22 do §2 já incluíam os 3 painéis; a lista nominal está no §5.2).
- **D-CF2** (Valdo, 2026-10-27 — fecha a **Q-CF2** = (a), literal: *"gate com cerca por tela — campo do código = campo do catálogo nos
  dois sentidos, cobrado no teste e na publicação"*) — nasce a CERCA DE CAMPOS, irmã da cerca da D-PV9/D-PV51: para cada tela do escopo
  da D-CF1, o conjunto de campos declarados no código (os `RegisterField` da página no app + o DTO/`assertClientRequired` da API) é
  IGUAL ao conjunto de linhas em `tb_interface_has_field` da interface. Reprova: tela do escopo sem catálogo; campo do código fora do
  catálogo; linha do catálogo que nenhum código declara. Cobrada no teste (gate de entrega de cada tela) e na publicação
  (`build-web.ps1`, molde da D-PV16); no boot só alarme (molde da D-PV52). Detalhes de execução (onde mora a lista, como a varredura lê
  os campos de peças compartilhadas, marca de exceção com motivo) ficam para a execução, com os gates.
- **D-CF3** (Valdo, 2026-10-27 — fecha a **Q-CF3** = (a), literal: *"catálogo por papel; o formulário compartilhado recebe a config da
  interface que o monta"*) — cada papel da cadeia de entidade (customers, collaborators, carriers, providers, salesmen, establishment,
  institutions) tem as SUAS linhas em `tb_interface_has_field` (mantém "sem reuso entre interfaces" da Fase 2); a peça compartilhada do
  formulário (`app/shared/entity` no app, `@shared/entity` na API) não conhece interface — recebe a config da interface que a monta e a
  aplica; a API confere pela interface do módulo que recebeu o salvar. A cerca da D-CF2 confere papel a papel. Ex.: e-mail obrigatório só
  no Cliente.
- **D-CF4** (Valdo, 2026-10-31 — fecha a **Q-CF4** = (a), literal: *"Depois (a)"*) — a cobertura do motor nas telas do escopo da D-CF1 é
  uma ONDA PRÓPRIA, executada DEPOIS do merge do bloco de privilégios (a D-PV54 não depende dela; as 16 telas completas funcionam no dia do
  merge). O "antes de avançar" do Valdo (D-PV54) fica cumprido pelas DECISÕES desta rodada, não pelo código. Consequência (molde da própria
  opção): tela que outra frente toca antes da onda adota o motor NESSA frente, antes do merge dela — `terminals` (branch `terminal`),
  `merchandise` (onda 1 do app) e `establishment` (aba do regime de IBS/CBS, D-IB99 — prazo 01/01/2027). Detalhe de execução, a confirmar
  nos gates (não decidido pelo Valdo): a cerca da D-CF2 nasce na onda; se nascer antes, as telas ainda não cobertas entram como exceção
  nomeada que encolhe até zero.
- **D-CF5** (Valdo, 2026-10-31 — fecha a **Q-CF5** = (a), literal: *"(a) o de partnerships"*) — a aba de parcerias de Clientes aplica o
  catálogo da interface 18 `partnerships` (recurso vendável kind 'R'), não o de `customers`: no app a aba, montada dentro de Clientes,
  carrega a config de `partnerships`; na API o salvar da parceria (rotas em `/api/customers`) confere com
  `assertClientRequired(…,'partnerships', …)`; a cerca da D-CF2 confere a aba contra a interface 18. As 4 linhas vivas do seed 20
  (`tb_customer_id`, `tb_collaborator_id`, `rate`, `active`) ficam e ganham leitor. Porquê: o recurso é vendido à parte (decisão 13 do
  Framework de Configurações) e cada interface tem o seu catálogo (Fase 2, "sem reuso"). Executa no bloco C (§5.3). A confirmar na
  execução: o painel "Campos das Interfaces" lista a interface 18 (kind 'R') para o cliente que a contratou.
- **D-CF6** (Valdo, 2026-10-31 — fecha a **Q-CF6** = (a), literal: *"(a) Sim, biblioteca"*) — o lado API do motor de campos (resolver a
  tela pela chave, compor catálogo × ajuste do cliente, `assertClientRequired` com os `<M>_FIELD_PATHS`) vira BIBLIOTECA compartilhada
  (molde do subpath `fiscal-api/reading`, D-F33), chamada pelo setes-api E pela auth-api. A auth-api confere com a MESMA peça o salvar das
  telas que recebe na A2 — `users`, `privileges`, `interfaces` e as abas de licença e de usuários de `institutions` —, lendo o catálogo
  (`setes_central.tb_interface_has_field`) e o ajuste do cliente (`tb_institution_has_field` no schema do cliente) por view/GRANT mínimo
  (molde D-F15). O catálogo e o ajuste continuam DO setes-api (D-AU1): só ele escreve (painel `interface-fields`). Tela com campos em dois
  donos (`users`: cadeia no setes-api, credencial — hash e e-mail de LOGIN em `tb_user_credential` — na auth-api, D-AU5) tem UM catálogo
  (a linha `email` do seed 07, hoje `tb_mailing`, passa a apontar a credencial na A2); cada API confere a parte que recebe. A cerca da
  D-CF2 varre os dois repositórios. Porquê: onde o usuário digita o cliente pode apertar (critério da D-CF1) e a regra fica em um lugar
  só — (b) devolveria 3 telas completas ao "nada"; (c) criaria chamada entre serviços. Execução: na A2 da auth-api (antes dela não há
  2º consumidor); onde mora o pacote (repositório/subpath) e a forma da leitura são detalhe de execução, com o guardião.

## 5. Roteiro de execução (2026-10-31 — PROPOSTA, não decide)

Escrito a pedido do Valdo ("fill them in") depois da reconferência do §2.1. É o "detalhe de execução" que a D-CF2 e a D-CF4 deixaram para a
onda: ordem, forma de cada tela e molde da cerca. Nada aqui é decisão; o que exigir escolha nos gates vira questão numerada (Q-CF6…).

### 5.1 Pré-condições

1. **Bloco de privilégios no `main`** (passo 4 do §2 de `plano_retomada_2026-10-21.md`). Em 2026-10-31 a `privilegios-crud` segue FORA do
   `main` (setes-api f53a618). A onda é o **passo 4a** daquele §2.
2. **Worktree própria** `D:\Gestao2027\campos\{setes-api,setes-app,sql}` (branch `campos`) a partir do `main` pós-privilégios — nunca na
   árvore viva (o setes-api roda `tsx watch` = deploy ao salvar).
3. **MariaDB no ar** para reconferir o inventário NO BANCO (linhas por `i18n_key` em `tb_interface_has_field`) — fecha o limite do §2.
4. ~~Q-CF5 decidida antes do bloco C~~ — FEITO: **D-CF5** (2026-10-31).
5. **Frente auth-api** (cruzamento completo no §3.2): o catálogo e o ajuste do cliente ficam no setes-api (D-AU1); o contrato do motor
   já é pela CHAVE (`/api/interface-fields/key/<tela>`, seeds por `i18n_key`) — é o "seguem apontando pela chave" da D-AU2; com a D-AU4 o
   registro fica em `setes_central`, então a coluna `tb_interface_id` do catálogo fica, sem DDL (corrige a leitura anterior deste item,
   que presumia trocar a coluna). Pela D-AU6 (2026-10-31) a costura A1 da auth-api entra NO bloco de privilégios (passo 4) — a onda parte
   do `main` DEPOIS dela e usa `@shared/access` no painel (licença e CONFIGURAR); pela A-CF1 (ratificada) o motor segue lendo `tb_interface` e a licença
   direto (SELECT), só o veredito vem da view. Pela D-CF6 o lado API do motor vira biblioteca na A2 —
   a onda escreve as conferências novas pela peça `@shared/field-config` de sempre, sem antecipar a extração.

### 5.2 Escopo nominal (D-CF1)

| Tela | O que falta | Forma da tela no app | Bloco |
|---|---|---|---|
| service-list | API (`assertClientRequired`) | fábrica `RegisterFormPage` | A |
| price-lists | catálogo | híbrida (`fieldConfigOf`) | A |
| salesmen | catálogo + API | fábrica (promoção do colaborador; papel da D-CF3) | A |
| tax-rules | app (6 abas) | híbrida, aba a aba | A |
| categories, financial-plans | app | árvore (`SetesTreeView`) | B |
| customers, collaborators, carriers, providers, institutions | tudo | peça `app/shared/entity` × `@shared/entity` | C |
| establishment | tudo, menos a aba do regime IBS/CBS (vem pronta da D-IB99) | peça da entidade + abas próprias | C |
| service-orders, settlements | app (catálogo + API já existem) | processo + diálogos | D |
| orders | catálogo + app (a API já chama `assertClientRequired`, hoje sem linha para conferir) | processo + diálogos (negociação, cheques) | D |
| order-returns, cashier, checks, bank-slips | tudo | processo + diálogos (devolução, abrir/fechar caixa, eventos do cheque, emitir/liquidar boleto) | D |
| terminals | nada — já cumpre na branch `terminal` (§2.1) | fábrica | entra na cerca no bloco 0 |
| merchandise | app da onda 1 | — | frente de produtos (D-CF4), a cerca confere |

São 19 telas na onda + `terminals` + `merchandise`. Fora (D-CF1): `interface-configs`, `interface-fields`, `institution-interfaces`.

### 5.3 Blocos (cada um = sessão própria, nesta ordem, com os gates de entrega)

- **Bloco 0 — a cerca primeiro (D-CF2)**, molde da cerca de privilégios (D-PV9/D-PV16/D-PV52 — `src/__tests__/privilege-catalog-fence.test.ts`
  + `src/test-setup/privilege-fence.ts` na branch `privilegios-catalogo`; publicação em `apps/web/build-web.ps1`):
  - varredura do CÓDIGO — app: os `RegisterField(name: …)` da página e os nomes passados a `fieldConfigOf` (tokenizador Dart da cerca de
    privilégios; peça compartilhada → telas pelo grafo de import); API: chaves do DTO Zod do create/update + `<M>_FIELD_PATHS`;
  - varredura do CATÁLOGO — offline pelos seeds de `sql/` (suíte) + AO VIVO, READ ONLY, contra `tb_interface_has_field` (teste ao vivo +
    `build-web.ps1`, molde da D-PV16); o boot só alarma (molde da D-PV52);
  - **exceção nomeada com motivo** = toda tela do §5.2 ainda não coberta; cada bloco seguinte tira as suas; no fecho a lista é VAZIA;
  - quando o repositório `auth-api` existir (A2), a varredura do lado API o lê também (repositório irmão, como a cerca de privilégios já
    lê a nfse-api e o app) — D-CF6;
  - a confirmar nos gates: onde mora a lista de exceções; como a varredura atribui o campo da peça compartilhada a N catálogos (D-CF3);
    linha técnica do catálogo que a tela não mostra (ex.: `id` gerado pela API × `id` digitado como no CFOP).
- **Bloco A — cadastros com pouco faltando**: service-list, price-lists, salesmen, tax-rules. Catálogos novos por `npm run fields:gen`
  (seed novo em `sql/`, interface por `i18n_key` — nunca id fixo, lição do seed 40v1); tax-rules aplica a config aba a aba com
  `fieldConfigOf` (molde dos híbridos: bank-accounts, contracts, services, settlement-rules).
- **Bloco B — árvores**: categories, financial-plans. Ligar o `FieldConfigLoader` no formulário do nó da `SetesTreeView` (hoje o motor só
  existe na fábrica e nos híbridos); a skill `setes-app/skills/criar-formulario-cadastro.md` ganha o passo no molde em árvore.
- **Bloco C — cadeia de entidade (D-CF3, 2 sessões)**: a peça `app/shared/entity` passa a receber a config (lista de `FieldConfigEntity`)
  de quem a monta; `@shared/entity` na API recebe a chave do módulo que recebeu o salvar; um catálogo por papel (o `fields:gen` com as
  tabelas da cadeia — entidade, pessoa/empresa, endereço, telefone, `tb_entity_tax` — e a do papel); a aba Tributação (`EntityTaxTab`)
  recebe a mesma config; a aba de parcerias aplica o catálogo de `partnerships` (D-CF5). Em `institutions` a onda cobre a cadeia de
  entidade; as abas de licença e de usuários vão para a auth-api na A2 e seguem a D-CF6 (não gastar a onda nelas). ⚠️ A onda 0 do convidado mexe em `users`/vínculos — conferir conflito de arquivos antes.
- **Bloco D — processo (2–3 sessões)**: inventariar, diálogo a diálogo, o que o usuário DIGITA (o que vem de lista ou é calculado não
  entra); o catálogo leva no `table_name` a tabela que recebe o dado; a skill `setes-app/skills/tela-de-processo.md` ganha o motor nos
  diálogos.
- **Fecho** (junto do último bloco): exceções zeradas; `build-web.ps1` barra; skills `novo-modulo`, `criar-formulario-cadastro`,
  `tela-de-processo` e `skills-genericas/mensagem-e-validacao.md` citam a cerca; agente `setes-form-builder` gera o catálogo; INDICE +
  CLAUDE.md.

### 5.4 Estimativa e gates

- **7–9 sessões** (0: 1 · A: 1 · B: 1 · C: 2 · D: 2–3). Sem prazo externo; a aba do regime IBS/CBS (D-IB99, 01/01/2027) NÃO espera a onda.
- Gates em cada bloco: `revisar-riscos-sistemicos` ≥ 0,70 + `testar-adversarial` sem HIGH/CRITICAL. Ataque obrigatório: o cliente
  APERTA um campo (`required = 'S'`) e o salvar sem ele dá 400 com `fields[]` ancorado nas duas pontas — inclusive nos diálogos de processo
  e na peça da entidade montada por papéis diferentes (o e-mail obrigatório só no Cliente não pode vazar para o Fornecedor).
