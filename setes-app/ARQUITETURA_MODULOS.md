# Arquitetura de Módulos do setes-app (1 interface = 1 módulo)

**Status**: Vigente (decisão do Valdo, 2026-07-11)
**Origem**: Refatoração que eliminou o módulo "super" agregador. Padrão comprovado do
weberpsetes (`Infra-IA/codigo-aprendizado/weberpsetes/lib`), adaptado ao monorepo.
**Substitui**: qualquer orientação anterior que agrupasse telas por "módulo de sistema".
**Escopo**: misto

---

## Conceitos (nunca confundir)

| Conceito | O que é | Onde vive |
|---|---|---|
| **Interface** | O que permite o usuário interagir e operar o banco (tb_interface) | 1 módulo flutter_modular próprio |
| **Módulo de sistema** | Agrupamento CONCEITUAL de interfaces — SÓ organização de menu | Apenas em tb_module/menu — NUNCA vira pasta ou código |
| **Módulo flutter_modular** | Unidade de código independente (binds + rota) | `app/modules/<interface>/` |

⚠️ Módulo de sistema e flutter_modular NÃO têm relação. O menu agrupa interfaces por
módulo de sistema; o código organiza 1 módulo POR INTERFACE.

## Estrutura de pastas

```
apps/web/lib/app/
├── shared/                          # compartilhado ENTRE módulos (nível app)
│   ├── register/                    # fábrica de cadastros (apresentação pura)
│   │   ├── register_form_page.dart  #   RegisterFormPage + RegisterField(.lookup)
│   │   └── register_search_page.dart#   RegisterSearchPage (controlada por bloc)
│   └── lookup/                      # lookups FK usados por 2+ módulos
│       ├── entity/<x>_lookup_entity.dart
│       └── datasource/<x>_lookup_datasource.dart
└── modules/
    ├── home/                        # shell: menu + RouterOutlet (UM content adaptativo — "Shell adaptativo único")
    │   ├── interface_routes.dart    # registro i18nKey → rota (+ navigateToInterface)
    │   └── home_module.dart         # ModuleRoute de CADA interface como filha de '/'
    └── <interface>/                 # ex.: countries, states, cities
        ├── <interface>_module.dart  # binds + ChildRoute('/')
        ├── data/
        │   ├── datasource/<x>_datasource.dart      # abstract + Impl(ApiClient)
        │   └── repository/<x>_repository_impl.dart # try/catch → Either
        ├── domain/
        │   ├── entity/<x>_entity.dart
        │   ├── repository/<x>_repository.dart      # abstract, Either<Failure, T>
        │   └── usecase/<x>_getlist|post|put|delete.dart
        └── presentation/
            ├── bloc/<x>_bloc|event|state.dart
            └── page/<x>_page.dart
```

## Onde colocar código compartilhado (regra de alocação)

1. `packages/core` — infra transversal SEM UI de negócio: ApiClient, Failure, sessão,
   helpers (jsonDouble/jsonInt, trCatalog, responsive).
2. `packages/setes_widgets` — design system puro (SEM easy_localization, SEM API).
3. `apps/web/lib/app/shared/` — código de NEGÓCIO do app usado por 2+ módulos
   (fábrica register, lookups FK).
4. `apps/web/lib/app/modules/<interface>/` — tudo que é de UMA interface.

**Regra de promoção**: o código nasce no módulo; quando um SEGUNDO módulo precisar,
promove para `shared/` (ou packages, se for infra/design). **Módulo NUNCA importa
módulo** — dependências cruzadas passam por shared (ex.: cities usa
`shared/lookup/state_lookup_datasource`, não o módulo states).

## Camadas (weberpsetes fiel — decisão do Valdo 2026-07-11)

- **datasource** (abstract + impl): fala com a setes-api via ApiClient; lança Failure.
  **Exceção nomeada (Q-G24 do cancelamento de nota, Valdo 2026-09-09)**: os endpoints de
  PROCESSO compartilhado `/api/billing/validate|invoice|cancel|cancel-waiver` — e, desde a F2a (D-F115, A3), as
  leituras `/api/billing/:orderId/cancel-plan|fiscal-effect` — podem ser chamados pelo datasource
  de qualquer módulo cujo DOCUMENTO passa por eles — hoje `orders` (venda), `order_returns`
  (devolução) e `service_orders` (cancelar a nota da OS; `cancel-waiver` = "manter a nota" diante da NFS-e
  substituída no fisco — D-F67, 2026-10-10). Fora dessa lista a regra continua:
  módulo fala só com o seu `/api/<módulo>` e com lookups em `shared/lookup`.
  **APIs fiscais (D-F4, Valdo 2026-10-03 — `Infra-IA/prompts/prompt_apis_fiscais_isoladas.md` §7/§12)**:
  o app passa a falar com as APIs DO PRODUTO — setes-api, **nfse-api** (e a futura nfe-api) — cada uma
  com base de URL própria (`--dart-define`, build publicado no Plesk) e **datasource DEDICADO por API e
  por módulo**; nunca cruza datasources (o datasource da nfse-api não chama o setes-api e vice-versa).
  O setes-api é PASSIVO diante das APIs fiscais; o mesmo JWT do login vale nas duas (RS256 — D-F13).
  Sagas que atravessam as duas (ex.: cancelar a nota com NFS-e autorizada = nfse-api `cancel` → setes-api
  `/api/billing/cancel`) são orquestradas pelo app, idempotentes e resumíveis. **Implementação da F2b (worktree
  `setes-app-f2b`, 2026-10-13 — §22.16 do prompt)**: `ProductToken` (um token, N clientes) + `ProductApiClient` → `ApiClient` (setes-api,
  EMISSOR do token) × `NfseApiClient` (nfse-api, envelope estrito) IRMÃOS (nunca subtipo — a injeção não cruza); o 401 de quem não
  emitiu o token só expira depois de o emissor confirmar (D-F148). Em `service_orders`: `service_order_nfse_datasource` (só a nfse-api) ×
  `service_order_invoice_datasource` (só `/api/billing/*`: plano, efeito, cancelar, manter); a saga é usecase de COMPOSIÇÃO sobre os dois
  repositórios (D-F139/D-F149). Em `establishment`: o emissor pela nfse-api (`/v1/emitter`). Chega à árvore viva na JANELA da F2a.
- **repository** (abstract no domain + impl no data): converte exceção em
  `Either<Failure, T>` (dartz — decisão 12).
- **usecases**: 1 arquivo por operação — `<X>Getlist`, `<X>Post`, `<X>Put`, `<X>Delete`.
- **bloc**: orquestra pesquisa ↔ formulário. Estados BUILDÁVEIS (`<X>ListState`,
  `<X>FormState`) + estados ONE-SHOT para SnackBar (`<X>ActionSuccess` com chave i18n,
  `<X>ActionFailure` com mensagem). A página usa BlocConsumer: `buildWhen` filtra os
  buildáveis, `listenWhen` os one-shot.
- **page**: traduz estados em widgets da fábrica. Estado do lookup FK
  (`_fkId`/`_fkName`) vive na página (setState em `_openNew`/`_openEdit`).
- **fábrica Register\***: apresentação PURA. RegisterSearchPage recebe
  `items`/`loading` prontos e notifica `onFilterChanged`/`onNew`/`onView`;
  RegisterFormPage valida e DISPARA `onSave(values)`/`onDelete` (void — quem executa
  é o bloc). A carga inicial é evento do bloc no initState da página.
- **paginação (2026-08-03 — OBRIGATÓRIA em lista nova)**: contrato
  `PagedResult<T>` (packages/core) atravessa datasource → usecase → state;
  a página repassa `page/pageSize/total` + `onPageChanged`/`onPageSizeChanged`
  à RegisterSearchPage — a barra (« X de Y » + seletor de itens/página) é o
  widget compartilhado `RegisterPagingBar` (shared/register), que também
  PERSISTE a escolha do usuário (config `page_size`, scope U) pela chave do
  módulo. Telas de processo fora da fábrica usam o `RegisterPagingBar`
  diretamente. Árvores (SetesTreeView) e lookups FK não paginam. Receita
  completa: skill `criar-formulario-cadastro.md` + molde `customers`;
  decisões em `Infra-IA/prompts/prompt_paginacao_telas_pesquisa.md`.

## Navegação (RouterOutlet)

- HomeModule: `ChildRoute('/', child: HomePage, children: [ModuleRoute de cada interface])`.
- O conteúdo central do shell é `RouterOutlet()` — UM shell adaptativo (`home/presentation/content/content_home.dart`), ver abaixo.
- Clique no menu → `navigateToInterface(item)` (`home/interface_routes.dart`):
  resolve a rota pelo `i18nKey` e navega com `arguments = nome da interface no menu`
  (título das telas). Sem rota → `/home/pending/` (placeholder).
- A rota de cada módulo monta a page com
  `args.data as String? ?? trCatalog('<i18nKey>', ...)` (fallback p/ refresh na URL).
- `/home/welcome/` é o conteúdo inicial (HomePage navega para lá quando abre em `/home`).
- Binds de um módulo só vivem enquanto sua rota está ativa (DI correto do modular).

## Shell adaptativo único (2026-10-18, onda D da densidade — `Infra-IA/prompts/prompt_densidade_layout_web.md` §5–§7)

- **Uma árvore só** (`ContentHome`): o shell nunca escolhe entre dois contents pela largura. O `RouterOutlet` fica SEMPRE na mesma
  posição (filho com chave de um `Row` que existe em toda largura); o que muda é o CONTEÚDO do espaço do menu (colunas × vazio) e da
  barra. ⚠️ **CONHECIMENTO NEGATIVO**: o antigo `Responsive(mobile: ContentHomeMobile, desktop: ContentHomeDesktop)` recriava o
  `RouterOutlet` ao cruzar o breakpoint (maximizar/restaurar a janela) — a tela aberta nascia de novo e o formulário em edição voltava
  para a lista, perdendo a digitação. É EXCEÇÃO à decisão 5 da Fase 1 (page + contents por breakpoint): `Responsive` só serve onde
  nada guarda estado que o usuário não pode perder. Provas: `apps/web/test/home_shell_resize_test.dart` (1366 → 1093 → coluna
  recolhida → 800 → 1366, texto e foco intactos, o form nasce 1 vez) e `home_shell_drawer_test.dart` (☰ a 375 px).
- **O login segue a mesma regra** (`ContentLogin` no core, 2026-10-18): o `LoginForm` (controllers de usuário e senha) fica numa
  posição fixa e só a moldura muda de medida — 400 px fixos a partir de 1100 px de área útil, largura toda com 24 px de margem
  abaixo. ⚠️ Moldura que muda de medida nunca pode SUMIR da árvore: `SingleChildScrollView(padding: null)` tira o `Padding` e o
  filho muda de posição — use `EdgeInsets.zero`. Prova: `apps/web/test/login_resize_test.dart`. Desde então nenhuma tela usa o
  `Responsive` (fica no core com o aviso; não é peça morta, só sem consumidor).
- **Breakpoint pela ÁREA ÚTIL** (`LayoutBuilder`, nunca `MediaQuery`): menu ao lado a partir de **840 px** (D-DL7 — faixa "expandida" do
  M3, a mesma da `SetesFormGrid`); abaixo, gaveta com ☰. O `Responsive` do core também mede pela área útil.
- **Barra (D-DL6)**: com o menu ao lado NÃO há barra do shell — logomarca no topo da coluna de módulos, usuário + idioma + tema no pé
  dela; os cabeçalhos das colunas têm a altura e a cor da barra da tela (uma faixa só). Na gaveta: barra enxuta = ☰ + logomarca +
  `UserBadge(compact: true)` (nome, idioma, tema e Sair dentro do menu dele). ⚠️ As ações da barra estreita NUNCA podem somar mais que
  a largura livre: a `AppBar` alinha as ações à direita POR CIMA do leading — com ~360 px de ações o logo (uma `Image`, que absorve o
  toque) cobria o ☰ a 375 px e o menu ficava sem acesso.
- **2ª coluna recolhível (D-DL7)**: botão « no cabeçalho dela (`MenuInterfacesCollapseToggled` no `MenuBloc`); recolhida, o módulo
  aberto mostra ›; clicar num módulo a mostra de novo.
- Tela sem barra própria (welcome, pending) aparece sem barra com o menu ao lado — normal; no celular a barra do shell segue lá.

## Checklist para criar módulo de interface novo

1. Criar `app/modules/<interface>/` com as camadas acima (copiar de `countries/` ou
   `states/` — este último tem lookup FK).
2. FK? Se o lookup já existe em `shared/lookup`, usar; senão criar lá SE for usado por
   2+ módulos (senão nasce no próprio módulo).
3. Registrar em `home/interface_routes.dart` (mapa) E `home_module.dart` (ModuleRoute).
4. i18n pt/en (skill internacionalizar-form.md) — labels por extenso.
5. `flutter analyze` limpo em apps/web e packages tocados.

## Caso real (2026-07-11)

País/Estado/Cidade nasceram dentro de `app/modules/super/` (módulo de sistema
materializado em código): datasource único com 3 entidades, entidades num arquivo só,
sem rotas próprias (InterfaceFrame com switch de i18nKey instanciava as pages).
Problemas: módulo inchado, alto acoplamento, difícil reutilizar. A refatoração
desmontou o super/ em countries/, states/ e cities/ com camadas completas, criou
app/shared (register + lookup) e trocou o InterfaceFrame por RouterOutlet + rotas.

## Rota de escape — endereço desconhecido (2026-10-14, passeio logado da F2b)

Sem `WildcardRoute` o `selectRoute` do flutter_modular lança o `RouteNotFound` e a tela fica **em branco**. Regra:

- **Raiz**: `WildcardRoute(child: RouteFallback)` no `AppModule` (`app/shared/routing/route_fallback.dart` → vai a `/home/`; sem sessão a
  guarda de `/home` manda ao login).
- **Casa**: o escape vive **NOS FILHOS** do `ChildRoute('/')` do `HomeModule`, por ÚLTIMO, mostrando o `WelcomeFrame`.
- ⚠️ **CONHECIMENTO NEGATIVO**: escape no nível do `HomeModule` (ou o da raiz sozinho) captura `/home/welcome/` — o redirecionamento
  que a `HomePage` faz de `/home/` — e a casa entra em **LAÇO** (a casa nasce a cada ~1,3 s e repete `/api/core/*`). Provado no
  navegador e em `apps/web/test/route_fallback_loop_test.dart` (mede quantas vezes a casa nasce: tem de ser 1).
- Módulo novo de cadastro NÃO precisa de escape próprio (o da casa cobre `/home/<qualquer-coisa>/`); só endereço desconhecido DENTRO
  de um módulo de interface (`/home/customers/nada/`) segue sem cerca.
- Testes de roteamento: o Modular é singleton — um cenário por arquivo (`route_fallback_*_test.dart`).
