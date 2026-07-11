# Prompt Técnico APP - Flutter


## Contexto para o assistente de código

Você está trabalhando em um projeto Flutter seguindo os padrões estabelecidos abaixo. 
Sempre que criar, editar ou revisar código, respeite rigorosamente estas convenções. 
Não introduza bibliotecas, padrões ou abordagens que conflitem com as escolhas já feitas, a menos que seja explicitamente solicitado.

## 1. Stack e Versões

| Tecnologia | Versão mínima |
|---|---|
| Flutter | 3.41+ |
| Dart | 3.11+ |
| Kotlin (Android) | 2.1.0 |
| Android Gradle Plugin | 8.8 |
| Gradle | 8.10.2 |
| compileSdk | 36 |
| NDK | 28.2.13676358 |

---

## 2. Arquitetura

**Clean Architecture** com três camadas por módulo: `data`, `domain`, `presentation`.

Estrutura de pastas de um módulo:

```
lib/app/modules/<nome_modulo>/
├── data/
│   ├── datasource/
│   ├── model/
│   └── repository/
├── domain/
│   ├── entity/
│   ├── repository/
│   └── usecase/
├── presentation/
│   ├── bloc/
│   ├── page/
│   ├── widget/
│   ├── content/
│   └── menu/
└── <nome>_module.dart
```

Regras gerais:
- `domain` nunca importa de `data` ou `presentation`.
- `data` implementa interfaces definidas em `domain`.
- `presentation` consome apenas `domain` (use cases e entities).
- Retorno de operações assíncronas: `Either<Failure, T>` via `dartz`.

---

## 3. Gerenciamento de Estado

**BLoC** com `bloc` + `flutter_bloc`. Padrão obrigatório:

```dart
// Events
abstract class MeuEvent extends Equatable {}
class MeuCarregar extends MeuEvent {
  @override List<Object?> get props => [];
}

// States
abstract class MeuState extends Equatable {}
class MeuInitial extends MeuState { @override List<Object?> get props => []; }
class MeuLoading extends MeuState { @override List<Object?> get props => []; }
class MeuLoaded extends MeuState {
  const MeuLoaded({required this.data});
  final MeuModel data;
  @override List<Object?> get props => [data];
}
class MeuError extends MeuState {
  const MeuError({required this.message});
  final String message;
  @override List<Object?> get props => [message];
}

// Bloc
class MeuBloc extends Bloc<MeuEvent, MeuState> {
  MeuBloc({required this.usecase}) : super(MeuInitial()) {
    on<MeuCarregar>(_onCarregar);
  }
  final MeuGet usecase;

  Future<void> _onCarregar(MeuCarregar event, Emitter<MeuState> emit) async {
    emit(MeuLoading());
    final result = await usecase();
    result.fold(
      (failure) => emit(MeuError(message: failure.message)),
      (data)    => emit(MeuLoaded(data: data)),
    );
  }
}
```

---

## 4. Injeção de Dependência e Rotas

- **flutter_modular v5** para rotas e módulos.
- **injectable** + **get_it** para injeção de dependências.
- Cada feature vive em seu próprio `Module`.

### Padrão de widget com bloc injetável (obrigatório para testabilidade)

```dart
class MeuWidget extends StatefulWidget {
  const MeuWidget({super.key, this.bloc});

  /// Optional bloc for tests; when null, uses `Modular.get<MeuBloc>()`.
  final MeuBloc? bloc;

  @override
  State<MeuWidget> createState() => _MeuWidgetState();
}

class _MeuWidgetState extends State<MeuWidget> {
  late MeuBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.bloc ?? Modular.get<MeuBloc>();
    if (widget.bloc == null) {
      Future.delayed(const Duration(milliseconds: 100)).then((_) async {
        await Modular.isModuleReady<MeuModule>();
      });
    }
  }
  // ...
}
```

> **Atenção:** Em doc comments com genéricos (`Modular.get<MeuBloc>()`), sempre use backticks para evitar o warning `unintended_html_in_doc_comment`.

---

## 5. Padrão de Testes

### 5.1 Estrutura de pastas

```
test/
├── helpers/
│   ├── pump_app.dart               # pumpApp, pumpAndSettleSafe
│   ├── fake_<modulo>_bloc.dart
│   ├── fake_<modulo>_repository.dart
│   └── test_config.dart
├── fixtures/
│   └── fixture_reader.dart
└── app/
    ├── core/
    └── modules/
        └── <modulo>/
            ├── data/model/<model>_test.dart
            └── presentation/
                ├── widget/<widget>_test.dart
                └── menu/<menu>_test.dart

integration_test/
├── app_test.dart
├── test_app_module.dart            # AppModule com AuthModuleTest
├── auth_module_test.dart
└── integration_fakes.dart
```

### 5.2 Fake Repository e Fake Bloc

```dart
// test/helpers/fake_meu_bloc.dart

class FakeMeuRepository implements MeuRepository {
  FakeMeuRepository({this.model});
  final MeuModel? model;

  @override
  Future<Either<Failure, MeuModel>> get() async {
    return Right(model ?? MeuModel.empty());
  }
}

class FakeMeuBloc extends MeuBloc {
  FakeMeuBloc({MeuModel? initialData})
      : super(usecase: MeuGet(repository: FakeMeuRepository(model: initialData))) {
    if (initialData != null) {
      // ignore: invalid_use_of_protected_member
      emit(MeuLoaded(data: initialData));
    }
  }

  void emitState(MeuState s) => emit(s);
}
```

### 5.3 Widget Tests

```dart
testWidgets('exibe dados quando estado é MeuLoaded', (tester) async {
  final bloc = FakeMeuBloc(initialData: MeuModel(nome: 'Teste'));

  await tester.pumpApp(
    SizedBox(height: 800, child: MeuWidget(bloc: bloc)),
    size: const Size(400, 800),
  );

  expect(find.text('Teste'), findsOneWidget);
});
```

Regras:
- Sempre passe o fake bloc; nunca dependa de `Modular.get` nos testes.
- Widgets com raiz `Expanded` devem ser envolvidos em `Column` ou `SizedBox(height: X)`.
- Prefira `find.text`, `find.byType`, `find.byIcon`, `find.textContaining`.

### 5.4 Unit Tests de Model

Cobrir obrigatoriamente:
- `empty()` → valores padrão corretos.
- `fromJson` com snake_case → camelCase.
- `fromJson` com campo numérico: testar `int` e `double`.
- `fromJson` com campos `null` → defaults.
- `toJson` → round-trip quando existir.

### 5.5 Integration Tests (E2E)

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('fluxo completo de login', (tester) async {
    await tester.pumpWidget(ModularApp(
      module: TestAppModule(),
      app: AppWidget(),
    ));
    // navegar, interagir, assertar elementos estáveis
  });
}
```

### 5.6 Boas Práticas Anti-flake

1. Evitar `pumpAndSettle` com timeout longo; preferir pumps explícitos.
2. Usar fakes determinísticos; nunca depender de rede, relógio ou aleatoriedade.
3. Assertivas estáveis; evitar textos que mudam com i18n.
4. Rodar integration tests com `-d windows` ou `-d chrome`.

---

## 6. Depreciações e Migrações (Flutter 3.32+)

### Radio → RadioGroup

```dart
RadioGroup<bool>(
  groupValue: valor,
  onChanged: (v) => setState(() => valor = v!),
  child: Column(
    children: [
      RadioGroupTile(value: true,  label: const Text('Sim')),
      RadioGroupTile(value: false, label: const Text('Não')),
    ],
  ),
)
```

Quando desabilitado:
```dart
IgnorePointer(
  ignoring: true,
  child: RadioGroup<bool>(...),
)
```

---

## 7. Configuração de Build

```bash
# Android APK
flutter clean && flutter pub get && flutter build apk

# App Bundle (Play Store)
flutter build appbundle

# Web
flutter build web
```

Se o projeto estiver em `D:` e o cache em `C:`, adicionar em `android/gradle.properties`:
```properties
kotlin.incremental=false
```

---

## 8. Análise e Qualidade

- `dart analyze` deve concluir **sem issues** antes de qualquer PR.
- Usar `flutter_lints` no `analysis_options.yaml`.
- Corrigir todos os itens da aba Problems antes de abrir PR.
- Preferir `const` constructors onde possível.
- Usar `Theme.of(context)`; evitar cores e tamanhos hardcoded.
- Extrair widgets privados quando `build()` crescer.

---

## 9. Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  # DI e rotas
  get_it: ^8.3.0
  flutter_modular: ^5.0.3
  modular_bloc_bind: ^1.0.1
  injectable: ^2.7.1
  # Estado
  bloc: ^8.1.4
  flutter_bloc: ^8.1.6
  equatable: ^2.0.8
  # Funcional
  dartz: ^0.10.1
  # HTTP
  http: ^1.6.0
  # Utilitários
  intl: ^0.20.2
  shared_preferences: ^2.5.3
  logger: ^2.6.2
  # Firebase
  firebase_core: ^3.15.2
  firebase_crashlytics: ^4.3.10
  firebase_analytics: ^11.6.0
  firebase_performance: ^0.10.1+10
  mobile_scanner: ^7.2.0
  # ORM principal
  drift: ^2.28.1
  # Setup multiplataforma simplificado (Android/iOS/Web em um só lugar)
  drift_flutter: ^0.2.4
  # SQLite nativo para Android/iOS (obrigatório)
  sqlite3_flutter_libs: ^0.5.29
  # Para path do banco no dispositivo
  path_provider: ^2.1.5
  path: ^1.9.1
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mocktail: ^1.0.4
  mockito: ^5.6.3
  build_runner: ^2.11.1
  json_serializable: ^6.11.2
  flutter_lints: ^5.0.0
  # Gerador de código (obrigatório para o drift funcionar)
  drift_dev: ^2.28.1
```

> Remova dependências que não forem necessárias no novo projeto. Sempre explique o motivo ao adicionar uma nova.

---

## 10. Comandos de Referência

| Objetivo | Comando |
|---|---|
| Testes unitários + widget | `flutter test` |
| Integration tests | `flutter test integration_test -d windows` |
| Análise de código | `flutter analyze` |
| Cobertura | `flutter test --coverage` |
| Limpar e obter deps | `flutter clean && flutter pub get` |

---

## 11. Git e PR

- Branch: `feature/<nome-descritivo>` ou `fix/<nome-descritivo>`.
- Commit: mensagem clara e objetiva em ou inglês (consistente no projeto).
- PR: título descritivo; descrever o que mudou e por quê.
- Nunca abrir PR com `dart analyze` reportando issues.

---

## 12. Checklist para Novo Módulo

- [ ] Criar estrutura de pastas `data/`, `domain/`, `presentation/` dentro de `lib/app/modules/<modulo>/`.
- [ ] Implementar entity, repository interface, use case em `domain/`.
- [ ] Implementar model (`fromJson`, `toJson`, `empty()`), datasource, repository em `data/`.
- [ ] Implementar bloc (events, states, bloc) em `presentation/bloc/`.
- [ ] Adicionar parâmetro opcional `bloc` nos widgets que consomem bloc.
- [ ] Registrar o módulo em `AppModule` ou no módulo pai.
- [ ] Criar fake repository e fake bloc em `test/helpers/fake_<modulo>_bloc.dart`.
- [ ] Criar unit tests do model em `test/app/modules/<modulo>/data/model/`.
- [ ] Criar widget tests em `test/app/modules/<modulo>/presentation/widget/`.
- [ ] Adicionar fluxo E2E em `integration_test/app_test.dart`.
- [ ] Atualizar `TESTING.md`.
- [ ] Rodar `flutter test` e `flutter test integration_test -d windows`.
- [ ] Garantir `flutter analyze` sem issues.

---

## 13. Regras Gerais para o Assistente

- Sempre null-safety. Seguir Effective Dart.
- Ao alterar UI, manter comportamento existente salvo instrução contrária.
- Sempre criar ou atualizar testes ao adicionar lógica.
- Ao editar `pubspec.yaml`, justificar cada dependência adicionada.
- Saída: fornecer alterações de código com caminho do arquivo e explicação mínima.
- Não introduzir novas libs de gerenciamento de estado ou DI sem ser solicitado.
- Não duplicar constantes (ex: `baseApiUrl`); manter fonte única da verdade.

---