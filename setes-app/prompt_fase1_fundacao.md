# Prompt — setes-app · Fase 1: Fundação Flutter Multi-plataforma

**Status**: ✅ FECHADO — rodadas 0–3 concluídas; 23 decisões registradas; questões pendentes: nenhuma
**Origem**: `Prompt - Aplicativo Flutter.txt` (rascunho de 2026-07-05) — skill: `skills-genericas/refinar-prompt-arquitetura.md`
**Numeração de fase**: por projeto (setes-app Fase 1 ≠ setes-api Fase 1)
**Escopo**: setes

---

## Contexto

O **setes-app** é o front-end Flutter (Web, Android e futuramente iOS) do arcabouço **Gestão 2027**.
Ele consome exclusivamente a **setes-api** (porta 3000), que gerencia a base `setes_central` e os
schemas de cliente `setes_<nome>`. O app **nunca acessa o banco diretamente** — toda menção a
"consulta SQL" neste prompt significa *endpoint da setes-api que executa a consulta* (Decisão 1).

**Herdado da Fase 2 do setes-api** (`Infra-IA/setes-api/prompt_fase2_gerenciamento_central.md`, decisões 16–21):

- Login multi-institution: `POST /auth/login` → 1 institution = JWT direto; N = lista + `POST /auth/select-institution`
- JWT: `{ institutionId (int), userId, role, schemaName }`, TTL 24h — **nunca** `tenantId` (string)
- Tabelas centrais: `tb_institution`, `tb_feature_flag`, `tb_interface`, `tb_privilege`, `tb_interface_has_privilege`
- Decisões que estavam adiadas para este projeto e foram fechadas aqui: institution padrão (Decisão 15); refresh token segue para fase futura (Decisão 9); `tb_profile` segue futura

**Projeto exemplo** (analisar antes de propor, salvo técnica obsoleta ou danosa):
`Infra-IA/codigo-aprendizado/weberpsetes/` — Clean Architecture; responsividade com arquivos
`*_mobile / *_tablet / *_desktop` separados; estrutura de testes unitários por módulo.

**Referências reaproveitáveis**:

- `Infra-IA/setes-app/temp/Agent_Context_App.md` — **stack oficial desta fase** (Decisão 12)
- `Infra-IA/setes-app/temp/THEME_EXAMPLE.md` — estrutura de tema
- `Infra-IA/codigo-aprendizado/GestaoERPApps/core/` — core de referência (auth, common, error, permission, shared, splash, widgets) (Decisão 19)

---

## Objetivos

1. Criar a **estrutura do repositório** setes-app: monorepo com packages Dart (Decisão 10)
2. Criar o **design system Setes**: todo widget Flutter encapsulado em widget `Setes*` antes do uso (Decisão 11)
3. Implementar **internacionalização** com `easy_localization`, idioma por usuário persistido em `tb_user_has_preference` (Decisões 13–14)
4. Implementar **temas e logomarca por institution**: `tb_institution_theme` + logo em storage servido pela API (Decisão 16)
5. Implementar **responsividade** no padrão weberpsetes (helper `Responsive` + arquivos por breakpoint) (Decisão 5)
6. Implementar o **workflow de autenticação** com seleção de estabelecimento e padrão local no dispositivo (Decisão 15)
7. Implementar o **shell web**: menu vertical de módulos → menu de interfaces → frame de renderização, montado via `GET /api/core/menus` (Decisões 21–22)
8. Implementar os módulos **Super** e **Sistema** com seus cadastros preparatórios
9. Implementar o **framework fábrica de cadastros** por composição + genéricos (Decisão 20)
10. Manter os **dois níveis de autorização**: `tb_feature_flag` = gate técnico de módulos da API; `tb_institution_has_interface` = contrato comercial (Decisões 17 e 23)
11. Para cada item, **mapear os impactos em setes-api e banco** (seção Impactos) e ordenar a implementação

---

## Workflow

### 1. Autenticação

1. Tela inicial de login (referência visual: `codigo-aprendizado/GestaoERPApps/core/lib/src/auth`)
2. `POST /auth/login` retorna as institutions vinculadas ao usuário:
   - **1 institution** → JWT final direto → tela home
   - **N institutions** → tela "Escolha o estabelecimento":
     - lista de institutions + opção de marcar um **estabelecimento padrão**
     - o padrão **não** pula a tela — apenas vem pré-selecionado para o usuário avançar sem escolher toda vez (Decisão 3)
     - o padrão é gravado **localmente no dispositivo** — localStorage/cookies no web, `shared_preferences` nos apps (Decisão 15)
     - escolha → `POST /auth/select-institution` → JWT final → home
3. Carregar tema/logo da institution e idioma do usuário (preferência) → montar menus

### 2. Montagem dos menus na home (`GET /api/core/menus` — Decisões 1, 21)

Consulta que o endpoint executa no `setes_<schema>` do JWT (referência):

1. Selecionar interfaces registradas em módulos: `tb_module` (campo `tb_module.description`) × `tb_module_has_interface`
2. `UNION` com interfaces ainda não usadas em nenhum módulo: `tb_institution_has_interface` INNER JOIN `tb_interface` (central), agrupando por `tb_interface.group_default`
3. A junção de `tb_module.description` + `tb_interface.group_default` monta o **menu vertical de módulos**
4. Clique no módulo → segundo menu com as interfaces disponíveis
5. Filtro final por usuário: `tb_user_has_privilege` determina quais módulos e interfaces aparecem e, ao abrir a interface, quais privilégios o usuário tem (visualizar, inserir, alterar, excluir, autorizar…)

O endpoint retorna a árvore **já filtrada** pelos privilégios do usuário — o app só renderiza (Decisão 21):

```json
[{ "module": { "id": 1, "description": "Sistema", "icon": 0 },
   "interfaces": [{ "id": 10, "description": "Estabelecimentos", "linkName": "/institution",
                    "privileges": ["view", "insert", "update", "delete"] }] }]
```

Layout do shell web — menus **por clique**, nunca suspensos no mouse-over (Decisão 22):

```
| Módulos---|                        ______________________________________
| Super     |==>|Menus--------------||                                      |
| Sistema   |   |Estabelecimentos   ||                                      |
| Projeto   |   |Países             ||    Frame que renderiza as telas      |
| Vendas    |   |Estados            ||    apontadas pelo menu               |
| Compras   |   |Cidades            ||                                      |
                |CFOP               ||______________________________________|
```

### 3. Padrão de operação dos cadastros

**Tela de pesquisa** (inicial de cada cadastro):

- Lista com alguns campos que identificam o registro
- Campo de filtro sobre os campos da lista
- Botão Pesquisar (carrega a lista) e botão Visualizar (abre o formulário completo)

**Formulário de cadastro** (inserir / alterar / excluir):

- Campos do objeto + botões Salvar e Cancelar
- Exclusão **sempre lógica**: `deleted = 'S'` (Decisão 4)

---

## Especificações por domínio

### A. Estrutura do repositório — monorepo com packages Dart (Decisão 10)

```
setes-app/
├── melos.yaml / pubspec.yaml (workspace)
├── packages/
│   ├── core/                    # compartilhado entre web, android e ios
│   │   └── lib/src/
│   │       ├── auth/            # autenticação + seleção de estabelecimento
│   │       ├── common/
│   │       ├── core/
│   │       ├── error/
│   │       ├── permission/
│   │       ├── shared/
│   │       └── splash/
│   └── setes_widgets/           # design system Setes (seção B)
└── apps/
    └── web/                     # app web multi-módulos (shell + menus dinâmicos)
```

Referência de estrutura do core: `codigo-aprendizado/GestaoERPApps/core/lib/src/`.
Fases futuras (Decisão 9): `apps/budget_sales`, `apps/stock_count`, `apps/budget_autocenter`,
`apps/erp_authorization` (domínio `com.setes.<app>`) e deploy iOS dos mesmos apps.

### B. Design system — widgets encapsulados com prefixo `Setes` (Decisão 11)

- **Nenhum widget do Flutter (ou de package externo) é usado diretamente nas telas.**
  Todo widget é encapsulado em um widget da casa e só este é usado no sistema —
  permite trocar widgets obsoletos/sem atualização sem impactar o sistema inteiro.
  - Ex.: `Text()` → `SetesText`; `ListTile` → `SetesListTile`; `CircularProgressIndicator` → `SetesCircularProgressIndicator`
- Todo widget compartilhável entre apps vive em `packages/setes_widgets`
  (ex. de referência: `GestaoERPApps/core/lib/src/shared/widgets/custom_circular_progress_indicator.dart`)
- **Widget × componente**: no Flutter são o mesmo conceito — "componente" é o termo genérico
  (Delphi usa "componente"), "widget" é a materialização Flutter. Termo oficial: **widget** (Decisão 8)

### C. Internacionalização (Decisões 13–14)

- Mecanismo: `flutter_localizations` + `intl` + **`easy_localization`** (traduções em JSON, troca de idioma em runtime sem rebuild)
- Cada usuário escolhe o idioma; preferência persistida em `tb_user_has_preference` (`setes_central`)
- DDL proposto (⚠️ validar via `revisar-ddl` no fechamento):

```sql
-- setes_central — preferências do usuário (Decisão 14); primeira chave: 'locale'
CREATE TABLE `tb_user_has_preference` (
  `tb_user_id` int(11) NOT NULL,
  `preference_key` varchar(50) NOT NULL,
  `preference_value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_user_has_preference`
  ADD PRIMARY KEY (`tb_user_id`,`preference_key`),
  ADD CONSTRAINT `fk_uhp_to_user` FOREIGN KEY (`tb_user_id`) REFERENCES `tb_user` (`id`);
```

- **Impacto na API**: `GET/PUT /api/core/preferences` (ler/gravar por chave)

### D. Temas e logomarcas por institution (Decisão 16)

- O **estabelecimento** define sua identidade visual (cores, logomarca)
- Modelo: tabela própria `tb_institution_theme` em `setes_central`; logomarca como **arquivo em storage servido pela API** (nunca BLOB)
- DDL proposto (⚠️ validar via `revisar-ddl` no fechamento):

```sql
-- setes_central — tema por institution (Decisão 16)
CREATE TABLE `tb_institution_theme` (
  `id` int(11) NOT NULL,                      -- = tb_institution.id (herança por PK, decisão 1 da Fase 2)
  `primary_color` varchar(9) DEFAULT NULL,    -- #AARRGGBB
  `secondary_color` varchar(9) DEFAULT NULL,
  `logo_path` varchar(255) DEFAULT NULL,      -- servido por GET /api/core/theme/logo
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_institution_theme`
  ADD PRIMARY KEY (`id`),
  ADD CONSTRAINT `fk_theme_to_institution` FOREIGN KEY (`id`) REFERENCES `tb_institution` (`id`);
```

- **Impacto na API**: `GET /api/core/theme` (app carrega após login), `PUT /api/core/theme` + upload de logo (cliente edita)
- Referência de estrutura de tema no app: `Infra-IA/setes-app/temp/THEME_EXAMPLE.md`

### E. Responsividade (padrão weberpsetes — Decisão 5)

Helper canônico (`weberpsetes/lib/app/core/shared/helpers/responsive.dart`):

- `Responsive(mobile:, tablet:, desktop:)` — breakpoints: mobile `< 850`, tablet `850–1099`, desktop `>= 1100`
- Cada tela tem arquivos separados por breakpoint, mantendo a renderização independente e limpa:
  `page/<tela>_page_mobile.dart`, `..._tablet.dart`, `..._desktop.dart` + `content/content_<breakpoint>_<tela>.dart`
- Aplicar da mesma maneira que o weberpsetes; avaliar e sugerir melhorias se houver

### F. Módulo Super (cadastros preparatórios — superusuário)

| Cadastro | Observações |
|---|---|
| Privilégios | Operações usadas nas interfaces (`tb_privilege` — já existe na central, Fase 2) |
| Interfaces | Cada interface UI registrada com módulo/grupo default e privilégios que gerencia (`tb_interface`, `tb_interface_has_privilege` — Fase 2) |
| Clientes | ObjCustomer ⇒ ObjEntityFiscal ⇒ ObjEntity (ref. Delphi: `codigo-aprendizado/DataObjetcs/objCustomer.pas`). ⚠️ Verificar o que a setes-api já contempla (Fase 2, critério 7: entity+company/person+address+institution+customer numa operação). Inclui: registro em `tb_institution` para o cliente usar o sistema; definição das interfaces do cliente; criação de pelo menos um usuário para o cliente ter acesso |
| CFOP / Países / Estados / Cidades | Tabelas de referência da central (já criadas na Fase 2) |

**Tela "Interfaces do cliente"** (chamada a partir do cadastro de cliente): de um lado `tb_interface`
(todas, central), do outro `tb_institution_has_interface` (as liberadas, no `setes_<schema>` do cliente —
Decisão 18) — listas lado a lado com setas para mover. O Super escreve no schema do cliente alvo (Decisão 23).
Ao liberar/cancelar interfaces, manter `tb_feature_flag` (módulos de API) coerente com o contrato (Decisão 17).

### G. Módulo Sistema (cadastros do próprio cliente)

| Cadastro | Observações |
|---|---|
| Estabelecimento | O próprio cliente edita (ObjEntityFiscal + `tb_institution` = objInstitution; ref. `codigo-aprendizado/DataObjetcs/objInstitution.pas`) |
| Usuário | Cliente cria outros usuários e define permissões: lista de módulos → interfaces → privilégios com checkbox |
| Módulo | Master-Detail: `tb_module` (master) + `tb_module_has_interface` (detail); a fonte das interfaces incluíveis é `tb_institution_has_interface`; listas lado a lado com setas. Uma interface pode estar em mais de um módulo |

**DDLs — todas em `setes_<schema>`** (Decisão 18; chaves definidas; ⚠️ FKs cross-schema via `revisar-ddl` no fechamento):

```sql
-- setes_<schema> — contrato comercial: interfaces liberadas para o cliente (Decisão 17)
CREATE TABLE `tb_institution_has_interface` (
  `tb_institution_id` int(11) NOT NULL,
  `tb_interface_id` int(11) NOT NULL,
  `active` char(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_institution_has_interface`
  ADD PRIMARY KEY (`tb_institution_id`,`tb_interface_id`);

-- setes_<schema> — módulos definidos pelo cliente
CREATE TABLE `tb_module` (
  `id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `link_name` varchar(255) NOT NULL,
  `image_icon` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_module`
  ADD PRIMARY KEY (`id`);

CREATE TABLE `tb_module_has_interface` (
  `tb_module_id` int(11) NOT NULL,
  `tb_interface_id` int(11) NOT NULL,
  `active` char(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_module_has_interface`
  ADD PRIMARY KEY (`tb_module_id`,`tb_interface_id`);

CREATE TABLE `tb_user_has_privilege` (
  `tb_user_id` int(11) NOT NULL,
  `tb_interface_id` int(11) NOT NULL,
  `tb_privilege_id` int(11) NOT NULL,
  `active` char(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_user_has_privilege`
  ADD PRIMARY KEY (`tb_user_id`,`tb_interface_id`,`tb_privilege_id`);
```

### H. Framework fábrica de cadastros — composição + genéricos (Decisão 20)

Como haverá muitos cadastros, criar widgets genéricos que acelerem a produção:

- `RegisterSearchPage<T>` — tela de pesquisa padrão (lista + filtro + pesquisar + visualizar)
- `RegisterFormPage<T>` — formulário padrão (campos + salvar/cancelar + exclusão lógica)
- **Descritor de campos por cadastro** parametriza os dois (labels, tipos, validações, privilégios)

Origem da ideia (cadeia de herança Delphi, para referência conceitual):
`TBaseForm → TRegisterForm → TEntityForm → TEntityFormFiscal → TInstitutionForm / TCustomerForm`.
No Flutter a mesma reutilização é obtida por **composição + genéricos**, não por herança profunda.

### I. Stack técnica oficial (Decisão 12)

Base: `Infra-IA/setes-app/temp/Agent_Context_App.md` — resumo do que fica valendo:

- Flutter 3.41+ / Dart 3.11+; Clean Architecture `data/domain/presentation` por módulo
- BLoC (`bloc` + `flutter_bloc` + `equatable`); `flutter_modular` v5 (rotas/DI) + `get_it`/`injectable`; `dartz` (`Either<Failure, T>`)
- **drift/sqlite somente nos apps Android** (offline) — o web opera online direto na API
- Testes: unit (models), widget (fake blocs), integration E2E; `flutter analyze` sem issues; padrões anti-flake do documento

---

## Impactos na setes-api e no banco (mapa de dependências)

| Item do app | Banco (onde) | setes-api (endpoints) | Situação |
|---|---|---|---|
| Login + seleção de institution | Fase 2 (pronto) | `/auth/login`, `/auth/select-institution`, `/auth/switch-institution` | ✅ Fase 2 |
| Institution padrão | — (local no dispositivo, Decisão 15) | — | ✅ só app |
| Idioma do usuário | `setes_central.tb_user_has_preference` (Decisão 14) | `GET/PUT /api/core/preferences` | 🔨 criar |
| Tema/logo | `setes_central.tb_institution_theme` + storage (Decisão 16) | `GET/PUT /api/core/theme` + logo | 🔨 criar |
| Menus dinâmicos | `setes_<schema>`: `tb_module`, `tb_module_has_interface`, `tb_institution_has_interface`, `tb_user_has_privilege` (Decisão 18) | `GET /api/core/menus` (Decisão 21) | 🔨 criar |
| Gate de módulos da API | `setes_central.tb_feature_flag` (mantida — Decisão 17) | `feature-flag.middleware` inalterado | ✅ Fase 2 |
| Licenciamento pelo Super | `tb_institution_has_interface` no schema do cliente **alvo** | endpoints Super cross-schema (Decisão 23) | 🔨 criar |
| CRUDs Super (privilégio, interface, cliente, CFOP, geo) | central (Fase 2) | CRUDs REST | 🔍 verificar o que já existe |
| CRUDs Sistema (estabelecimento, usuário, módulo, privilégios do usuário) | central + `setes_<schema>` | CRUDs REST | 🔨 criar |
| Onboarding de cliente | script `03_schema_cliente_ddl.sql` ganha as 4 tabelas novas | — | 🔨 atualizar |

Organizar a implementação de forma que Flutter e setes-api evoluam em paralelo: para cada
interface UI, primeiro fechar DDL (via `database/skills/revisar-ddl.md`) e endpoint, depois a tela.

---

## Decisões arquiteturais registradas

1. **App nunca acessa banco**: toda montagem dinâmica (menus, flags, temas) é servida por endpoints da setes-api. "Consulta SQL" no rascunho = consulta executada pelo endpoint.
2. **Nomenclatura herdada da Fase 2**: institution (nunca tenant), JWT `institutionId` int, tabelas `tb_*`, schemas `setes_<nome>`.
3. **Institution padrão** (fecha a decisão 17 da Fase 2): o padrão apenas vem pré-selecionado na tela de escolha — não pula a tela.
4. **Exclusão sempre lógica** via `deleted char(1) 'S'/'N'` (padrão `PADROES_BANCO.md`).
5. **Responsividade padrão weberpsetes**: helper `Responsive` (breakpoints 850/1100) + arquivos `page/content` separados por `mobile/tablet/desktop`.
6. **Clean Architecture por módulo** (`data/domain/presentation`) com testes unitários, de widget e E2E — padrão weberpsetes + `Agent_Context_App.md`.
7. **iOS fora desta fase**: serão os mesmos apps Android com deploy iOS, em fase futura.
8. **Termo oficial "widget"** (widget = componente; sem distinção técnica).
9. **Recorte da Fase 1** (Q1/Q10): fundação — estrutura, design system, i18n, temas, responsividade, auth, shell web, módulos Super e Sistema. Apps Android (`budget_sales`, `stock_count`, `budget_autocenter`, `erp_authorization`) e refresh token: fases seguintes.
10. **Monorepo com packages Dart** (Q2): `packages/core`, `packages/setes_widgets`, `apps/web`, futuros `apps/<android_app>`; orquestração com workspace/melos.
11. **Prefixo `Setes`** nos widgets encapsulados (Q3): `SetesText`, `SetesListTile` etc.
12. **Stack oficial = `Agent_Context_App.md`** (Q4), com drift/sqlite **somente nos apps Android** (offline); o web opera online direto na API.
13. **i18n com `flutter_localizations` + `intl` + `easy_localization`** (Q5a) — traduções em JSON, troca em runtime.
14. **Preferências do usuário em `tb_user_has_preference`** (`setes_central`, chave/valor) (Q5b); primeira preferência: `locale`.
15. **Institution padrão gravado localmente no dispositivo** (Q5c): localStorage/cookies no web, `shared_preferences` nos apps — não persiste no banco (não segue o usuário entre dispositivos — aceito).
16. **Tema em `tb_institution_theme`** (tabela própria na central) e **logomarca como arquivo em storage servido pela API** (Q6).
17. **Dois níveis de autorização** (Q7/Q13 — decisão revista na rodada 2, substitui a opção "b" da rodada 1): `tb_feature_flag` **mantida** como gate técnico de módulos da API (`feature-flag.middleware` inalterado — impede que institutions sem o módulo registrado executem operações); `tb_institution_has_interface` é o **contrato comercial** (telas adquiridas pelo cliente), alimentando menus e o controle de acesso dos usuários. A tela de cliente do Super mantém as duas coerentes ao vender/cancelar pacotes.
18. **Configuração do cliente vive no schema do cliente** (Q8): `tb_module`, `tb_module_has_interface`, `tb_user_has_privilege`, `tb_institution_has_interface` em `setes_<schema>` — são escolhas do institution. DDLs com chaves definidas (seção G); FKs cross-schema fechadas via `revisar-ddl` no fechamento.
19. **Referências do GestaoERPApps** copiadas para `Infra-IA/codigo-aprendizado/GestaoERPApps/` (Q9) — agentes enxergam dentro do workspace.
20. **Fábrica de cadastros por composição + genéricos** (Q11): `RegisterSearchPage<T>` / `RegisterFormPage<T>` + descritor de campos.
21. **`GET /api/core/menus`** retorna a árvore módulos→interfaces→privilégios já filtrada pelo usuário (Q12); o app só renderiza.
22. **Menus do shell acionados por clique** — nunca suspensos no mouse-over.
23. **Escrita cross-schema pelo Super** (Q14): endpoints do módulo Super recebem o `institutionId` **alvo**, validam `role='super'` + `institutionId === 1` (decisão 14 da Fase 2) e resolvem o schema alvo via `tb_institution.schema_name` — nunca usam o `schemaName` do próprio JWT para operar no cliente. O script `03_schema_cliente_ddl.sql` ganha as 4 tabelas novas (seção G) para o onboarding criar schemas completos.
24. **Legado de UI alinhado ao canônico** (Q15, decidida na implementação): a migration `001_baseline` do setes-api criava versões legadas de `tb_module` (`technical_name`/`acao_botao`), `tb_institution_has_module`, `tb_module_has_interface`, `tb_user_has_privilege` (PK com `tb_institution_id`) e cópias locais de `tb_interface`/`tb_privilege` no schema do cliente. A migration `003_setes_app_fase1.sql` faz DROP dessas versões e cria as 4 tabelas no formato canônico — sem migração de dados (sem clientes em produção; nenhum código sync/erp dependia delas). Catálogo de interface/privilégio vive só na central.
25. **Features do core são completas e reusáveis** (decidida na implementação, feedback do Valdo): no modelo GestaoERPApps, as features do `packages/core` (auth, splash, permission…) incluem **presentation** (bloc + pages + contents), não só domain/data. O core exporta módulos Modular prontos (ex.: `AuthModule`) e os apps apenas os roteiam, fornecendo os binds de infraestrutura (`ApiClient`, `LocalPrefs`), a rota `/home` e as chaves de tradução. É isso que garante o reuso do login inteiro entre web e apps Android.
26. **i18n do catálogo por chave + fallback** (Q16, decidida na implementação): `tb_interface` ganha a coluna `i18n_key`; o `GET /api/core/menus` devolve a chave junto da `description`. O app traduz via easy_localization com fallback no texto do banco (`trCatalog`, no core): interfaces = `menu.interfaces.<i18n_key>`, grupos (`group_default`) = `menu.groups.<texto>`, privilégios = `menu.privileges.<description>`. `tb_module` (criado pelo cliente) **não** se traduz — é dado do cliente. Novo idioma = novo JSON nos assets do app, sem DDL nem tela de CRUD de traduções.
27. **Tema por marcadores semânticos** (decidida na implementação): nenhuma tela define cor — tudo referencia marcadores (`SetesTokens` ThemeExtension: brandPrimary/Secondary, success/warning/danger/info, menuBackground/Selected) e `Theme.of(context)`. A fábrica `SetesTheme.build()` monta o ThemeData inteiro a partir de **duas** cores da institution (`tb_institution_theme`); padrão = **identidade Setes**: primária = **azul do "7" da logomarca redonda** (`#2E6DA4`), secundária = navy `#1B3A5F`; verde `#3E9B4F` fica como cor de apoio/destaques; neutros do weberpsetes `theme.dart`. Na **web um único estilo para todos os módulos**; cores por módulo/app (modelo THEME_EXAMPLE) ficam para os apps **Android** (fases futuras). Cliente personaliza numa paleta (`ThemeSettingsPage`), aplicação imediata via `ThemeCubit` + persistência no `PUT /api/core/theme`.

---

## Questões pendentes

Nenhuma — rodadas 0 a 3 + Q15 (implementação) decididas e registradas acima (24 decisões).
Detalhamentos que surgirem durante a implementação viram novas rodadas neste documento ou fases futuras.

---

## Status da implementação (backend)

**2026-07-05 — setes-api pronto para a Fase 1** (tsc limpo; 26 testes passando):

- DDLs: `sql/01` ganhou `tb_user_has_preference` e `tb_institution_theme`; `sql/03` e a migration `003_setes_app_fase1.sql` criam as 4 tabelas de configuração (decisões 14, 16, 18, 24)
- `GET/PUT /api/core/preferences` (decisão 14) · `GET/PUT /api/core/theme` com logo base64→storage (decisão 16, `STORAGE_PATH`)
- `GET /api/core/menus` — árvore filtrada por contrato + privilégios, bypass super (decisões 18, 21)
- `GET/PUT /api/admin/institutions/:id/interfaces` e `PUT .../feature-flags` — Super cross-schema (decisões 17, 23)

---

## Fora de escopo desta fase (Decisões 7, 9)

- iOS (deploy futuro dos mesmos apps Android)
- Apps Android: `budget_sales`, `stock_count`, `budget_autocenter`, `erp_authorization`
- Refresh token (entra com o primeiro app mobile — decisão 19 da Fase 2)
- Módulos de negócio (Projeto, Vendas, Compras) — aparecem no layout apenas como exemplo
- `tb_profile` / padronização de perfis (implementação futura — decisão 15 da Fase 2)

---

## Critérios de sucesso

1. Login com usuário de 1 institution → JWT → home direto
2. Login com usuário de N institutions → tela de escolha com o padrão pré-selecionado (gravado no dispositivo); escolha → home
3. Usuário grava idioma (persistido em `tb_user_has_preference`); o web reflete a troca imediatamente e na próxima sessão, em qualquer dispositivo
4. Tema/logomarca da institution aplicados após o login (duas institutions com visuais distintos comprovam)
5. Menus de módulos e interfaces montados 100% via `GET /api/core/menus` conforme `tb_module` + `tb_institution_has_interface` + privilégios do usuário — nada hard-coded; acionamento por clique
6. Superusuário (institution 1, `role='super'`) vê o módulo Super com: Privilégios, Interfaces, Clientes, CFOP, Países, Estados, Cidades
7. Cadastro de cliente pelo Super cria entity + company/person + address + institution, libera interfaces (no schema do cliente alvo) e cria o primeiro usuário do cliente
8. Usuário do cliente edita o próprio estabelecimento, cria usuários e define privilégios (módulo → interface → checkbox de privilégios)
9. Ao abrir uma interface, botões Inserir/Alterar/Excluir respeitam `tb_user_has_privilege`
10. Dois níveis de autorização funcionando: institution sem o módulo em `tb_feature_flag` recebe `403` na API; menus e telas respeitam o contrato `tb_institution_has_interface`
11. Toda tela implementada nos 3 breakpoints (mobile/tablet/desktop) via padrão `Responsive`
12. Nenhum uso direto de widget cru do Flutter nas telas (somente widgets `Setes*`)
13. `flutter analyze` sem issues; testes unitários, de widget e E2E passando
