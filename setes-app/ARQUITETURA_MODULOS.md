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
    ├── home/                        # shell: menu + RouterOutlet
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

## Navegação (RouterOutlet)

- HomeModule: `ChildRoute('/', child: HomePage, children: [ModuleRoute de cada interface])`.
- O conteúdo central dos shells (desktop/mobile) é `RouterOutlet()`.
- Clique no menu → `navigateToInterface(item)` (`home/interface_routes.dart`):
  resolve a rota pelo `i18nKey` e navega com `arguments = nome da interface no menu`
  (título das telas). Sem rota → `/home/pending/` (placeholder).
- A rota de cada módulo monta a page com
  `args.data as String? ?? trCatalog('<i18nKey>', ...)` (fallback p/ refresh na URL).
- `/home/welcome/` é o conteúdo inicial (HomePage navega para lá quando abre em `/home`).
- Binds de um módulo só vivem enquanto sua rota está ativa (DI correto do modular).

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
