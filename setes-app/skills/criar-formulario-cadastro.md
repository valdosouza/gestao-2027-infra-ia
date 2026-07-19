# Skill: Criar formulário de cadastro no setes-app (padrão customer_register)

**Status**: Vigente
**Origem**: Análise de `Infra-IA/codigo-aprendizado/weberpsetes/lib/app/modules/customer_register` (2026-07-10), a pedido do Valdo — os cadastros iniciais (País/Estado/Cidade) estavam visualmente pobres e sem apoio para FKs.
**Referências**: `prompt_fase1_fundacao.md` (decisões 11, 20, 21, 26), skills irmãs `campo-lookup-fk.md` e `internacionalizar-form.md`.
**Cadastro que herda a cadeia fiscal** (Institution/Customer/Provider/Collaborator/Bank): esta skill continua valendo para o contrato visual, mas a estrutura (abas compartilhadas, cascade, PF/PJ) vem de `cadastro-entidade-fiscal.md` — LER JUNTO.
**Quando usar**: SEMPRE que criar ou reformar uma tela de cadastro (CRUD) no setes-app.
**Tempo**: 30–60 min por cadastro

---

## Contrato visual (extraído do customer_register — manter em TODOS os cadastros)

1. **Tela de formulário** = `Scaffold` aninhado com `AppBar` própria:
   - `leading`: `IconButton(Icons.arrow_back_ios_rounded)` → volta para a pesquisa (SEM salvar)
   - `title`: o NOME DA INTERFACE DO MENU — o InterfaceFrame resolve
     `trCatalog(i18nKey, description, prefix: 'menu.interfaces')` e passa como
     parâmetro `title` obrigatório da página; o form usa esse valor puro
     ("Países"/"Countries"). SEM prefixo Adicionar/Editar e SEM chave
     `forms.<entidade>.title` própria (decisão do Valdo 2026-07-11: o título da
     tela é o mesmo nome clicado no menu).
   - `actions`: `IconButton(Icons.check, size: 30)` → salvar (ícone Android universal)
   - Excluir: `IconButton(Icons.delete_outline)` nas actions, só quando editando e `canDelete`
   - Cores SEMPRE do tema (`Theme.of(context).colorScheme`) — NUNCA hardcode como o
     app antigo (kBoxDecorationStyle azul). O tema por institution é a decisão 16.
2. **Abas quando houver GRUPOS NATURAIS de campos** (`TabBar` + `TabBarView`), como
   o customer_register (Principal / Endereço / Fone / Outros). Cadastro com poucos
   campos simples e sem agrupamento natural (ex.: Estado — código, país, sigla,
   nome, alíquota) → coluna única com scroll; não criar aba única artificial.
3. **Espaçamento**: `SizedBox(height: 10–16)` entre campos; `Padding` externo de 16.
4. **Ícones**: só Material Icons conhecidos do Android — `search`, `check`, `add`,
   `delete_outline`, `edit`, `arrow_back_ios_rounded`, `close`. Nada de ícones custom.
5. **Tela de pesquisa** (lista do cadastro) — mesmo estilo Android da tela de
   "Lista de Ordens" do app antigo (feedback do Valdo 2026-07-11):
   - `Scaffold` com `AppBar` no MESMO estilo do formulário (cores do tema, sem leading)
   - Título: "Lista de X" → `'register.listTitle'.tr(args: [widget.title])`
     com `register.listTitle = "Lista de {}"` (pt) / `"List of {}"` (en); X é o
     mesmo `title` recebido do InterfaceFrame (nome da interface no menu) —
     ex.: "Lista de Países" / "List of Countries"
   - **Novo registro = `FloatingActionButton` com `Icons.add` no canto inferior
     direito** (padrão Android) — NUNCA botão de texto "Novo" na barra de filtro
   - Campo filtro logo abaixo da AppBar, com sufixo `Icons.search`
   - `ListView.separated` com `Divider`; item = `ListTile` com `CircleAvatar` mostrando
     o `id` e o nome como título (padrão do widget_customer_list.dart)
   - Lista vazia → `Center(Text('register.emptyList'.tr()))`
   - Clique na linha inteira (InkWell) abre a edição — não obrigar clique num botão.
6. **Erros/avisos** → `SnackBar` (equivalente moderno do CustomToast do app antigo).
7. **Labels de campo por extenso** — o label repete a entidade: "Código do País" /
   "Country Code", "Nome do País" / "Country Name" — nunca palavra solta ("Código",
   "Nome") que não diz de quê (feedback do Valdo 2026-07-11).
8. **Tabulação** (feedback do Valdo 2026-07-11): Tab percorre os campos na ordem
   declarada e SÓ os editáveis — readOnly e botões de sufixo (Icons.search etc.)
   ficam fora da sequência (`ExcludeFocusTraversal`, já embutido no SetesTextField).
   Foco inicial no primeiro campo editável (`autofocus`); Enter = `TextInputAction.next`
   nos intermediários e `done` no último. A fábrica `RegisterFormPage` já faz tudo
   isso via `FocusTraversalGroup(OrderedTraversalPolicy)` — forms artesanais (com
   abas/lookup) devem repetir o padrão.

## Estrutura de arquivos do módulo (ARQUITETURA_MODULOS.md — 2026-07-11)

**1 interface = 1 módulo flutter_modular** com camadas completas (padrão weberpsetes):

```
apps/web/lib/app/modules/<interface>/          (ex.: countries, states, cities)
├── <interface>_module.dart                    (binds + ChildRoute('/'))
├── data/datasource/<x>_datasource.dart        (abstract + Impl com ApiClient)
├── data/repository/<x>_repository_impl.dart   (try/catch → Either)
├── domain/entity/<x>_entity.dart              (Equatable + fromJson)
├── domain/repository/<x>_repository.dart      (abstract, Either<Failure, T>)
├── domain/usecase/<x>_getlist|post|put|delete.dart
└── presentation/bloc/<x>_bloc|event|state.dart + presentation/page/<x>_page.dart
```

Registrar a interface em `home/interface_routes.dart` (i18nKey → rota) E como
ModuleRoute em `home_module.dart`. Módulo NUNCA importa módulo — lookups FK
compartilhados vivem em `app/shared/lookup/` (regra de promoção).

Widgets compartilhados vão em `packages/setes_widgets` (design system — decisão 11).
A fábrica de cadastros (`RegisterSearchPage`/`RegisterFormPage` em
`apps/web/lib/app/shared/register/`) é apresentação PURA controlada pelo bloc do
módulo: a pesquisa recebe items/loading prontos e o form dispara onSave/onDelete
como eventos. **Evoluir a fábrica** em vez de criar forms artesanais.

## Workflow

1. **Ler antes**: `Infra-IA/setes-app/INDEX.md` + `ARQUITETURA_MODULOS.md` +
   decisões 20/21/26 do prompt_fase1.
2. **Criar o módulo da interface** copiando de `app/modules/countries/` (simples) ou
   `app/modules/states/` (com lookup FK): camadas completas + Module com binds.
   Para FK, a entidade carrega `tbXxxId` E o campo de exibição (`xxxName`) que a API
   deve devolver via JOIN (se a API não devolve, adicionar no repository do setes-api);
   o lookup usa `app/shared/lookup/` (skill `campo-lookup-fk.md`).
3. **Bloc orquestra** pesquisa ↔ formulário (estados buildáveis + one-shot p/ SnackBar);
   a página só traduz estados em RegisterSearchPage/RegisterFormPage.
4. **Internacionalizar** tudo (ver skill `internacionalizar-form.md`) — pt.json + en.json.
5. **Registrar a rota**: `home/interface_routes.dart` (i18nKey → rota) +
   ModuleRoute em `home_module.dart`.
6. **Privilégios** (decisão 21): botões respeitam `MenuInterface.can('insert'|'update'|'delete')`
   — exceto módulo Super, que bypassa ACL (isSuper() é a única verificação).
7. **Validar**: `flutter analyze` no apps/web e nos packages tocados; abrir a tela e
   testar o ciclo criar → editar → excluir → pesquisar.

## Implementação já disponível (reforma do País, 2026-07-10)

- `SetesFormShell` (packages/setes_widgets) — casca do contrato visual item 1
  (AppBar com voltar/título/check/delete_outline, `saving` desabilita ações).
  `RegisterFormPage` já usa; formulários novos herdam de graça.
- `RegisterField` tem `readOnly` (campo visível e não editável — ex.: código
  imutável na edição) e `RegisterFormPage` já traz confirmação de exclusão
  (`register.confirmDelete`) + SnackBar de sucesso/erro (`register.saved` /
  `register.deleted` / `register.error`; erro da API — `Failure.message` — é exibido).
- `RegisterSearchPage` tem `avatarBuilder` (CircleAvatar com o código), filtro com
  sufixo `Icons.search` + `register.filterHint`, carga inicial na abertura, linha
  inteira clicável, `ListView.separated`, `register.emptyList`, AppBar própria no
  estilo do form e `FloatingActionButton` (Icons.add) para novo registro.
- `SetesTextField` ganhou `readOnly`, `hint`, `suffixIcon`/`onSuffixPressed`.
- `SetesRadioGroup<T>` + `SetesRadioOption<T>` (setes_widgets, 2026-07-17 —
  Rodada 4 do customers): radiobox de escolha ÚNICA em domínio minúsculo
  visível de uma vez (Sim/Não, Liberado/Bloqueado); renderiza como campo do
  form (InputDecorator com label/borda), aceita `helperText` explicativo e
  fica fora da sequência de Tab (mesma regra dos checkboxes). Para domínio
  maior use SetesDropdown; para FK, SetesLookupField.
- `SetesLookupField` + `showSetesLookup<T>` existem em setes_widgets e a
  fábrica tem `RegisterField.lookup(...)` para FK (reforma do Estado,
  2026-07-11 — ver campo-lookup-fk.md). Código do estado = código IBGE da UF
  (Paraná 41), informado na inclusão e imutável na edição (mesma regra do
  País/BACEN); POST /super/states dá 409 se o código existir, mesmo excluído.
- `RegisterFormPage` tem `extraChildren: List<Widget>` (cadastro de
  Interfaces, 2026-07-11): widgets renderizados APÓS os campos, dentro do
  Form/ListView — para seções que a fábrica não parametriza (ex.: grupo de
  checkboxes). O estado desses widgets vive na PÁGINA do módulo (como o id
  do lookup) — nunca nos values do onSave. Checkboxes ficam fora do Tab
  (`ExcludeFocusTraversal`); labels vindos do banco (ex.: description da
  tb_privilege) NÃO se traduzem.
- Chaves `register.*` completas já existem em pt.json/en.json (ver
  `internacionalizar-form.md`). Título: a página recebe `required this.title`
  do InterfaceFrame (nome da interface no menu via trCatalog); pesquisa usa
  `'register.listTitle'.tr(args: [widget.title])`, form usa `widget.title` puro.
  NÃO existe chave `forms.<entidade>.title`.

## Casos reais

- 2026-07-10: País/Estado/Cidade nasceram só com campos texto — FK digitada como número
  puro (tbCountryId, tbStateId), sem lista de apoio, visual "formulário cru". Esta skill
  existe para nenhum cadastro novo nascer assim.
- 2026-07-10: reforma do País. **Decisão do Valdo**: o código (id) do país é padrão
  mundial BACEN (Brasil = 1058), informado pelo usuário na INCLUSÃO e imutável na
  edição — NÃO é sequencial. Backend: POST /super/countries aceita `{id, name}`
  (Zod id int positivo), 409 se o código já existir MESMO com deleted='S'
  (código nunca é reaproveitado); PUT não altera o id. Nem toda tabela usa
  MAX+1 — perguntar quando o código for padrão externo (BACEN, IBGE...).
- 2026-07-11: feedback do Valdo na 1ª versão reformada do País: (a) botão "Novo"
  na barra de filtro não é usual → FloatingActionButton com Icons.add no canto
  inferior direito, como no app Android antigo; (b) tela de pesquisa também tem
  AppBar no estilo do form, com título "Lista de Países"; (c) título do form
  composto ("Adicionar — País") não é usual → o título é o NOME DA INTERFACE DO
  MENU, passado pelo InterfaceFrame (2ª rodada do feedback: nem `forms.*.title`
  — a fonte é o menu, garantindo consistência tela × menu); (d) labels soltos
  ("Código", "Nome") → por extenso ("Código do País", "Nome do País").
  Lembrete: easy_localization NÃO recarrega os JSONs em hot reload — chave crua
  na tela após adicionar tradução = fazer restart completo do app antes de
  concluir que é bug.

- 2026-07-11: cadastro de Interfaces (tb_interface) — primeira tela nova na
  arquitetura 1 interface = 1 módulo. **Decisões do Valdo**: (a) id automático
  MAX+1 gerado no BACKEND (sem padrão externo tipo BACEN/IBGE) — campo Código
  readOnly SEMPRE, vazio na inclusão e preenchido na edição, sem validação 409;
  (b) a tela gerencia também os vínculos N:N (tb_interface_has_privilege) via
  checkboxes — ids selecionados em `Set<int>` no estado da página, enviados
  como `privilegeIds` no body; o PUT sincroniza com INSERT ... ON DUPLICATE KEY
  UPDATE active='S', deleted='N' + soft delete dos não selecionados;
  (c) campos de domínio aberto (kind, position) = texto livre. A fábrica
  ganhou `extraChildren` para a seção de checkboxes — evoluir a fábrica em
  vez de form artesanal (decisão 20).
- 2026-07-11: consultas de Estado e Cidade voltavam lista vazia (País funcionava).
  Causa: mysql2 devolve DECIMAL como STRING ("12.00") por padrão — o
  `fromJson` fazia `as num?` e estourava; o catch do `_search` engolia e
  devolvia `[]` (a lista "sumia" assim que algum registro ganhava valor
  decimal). Correção dupla: `decimalNumbers: true` no pool
  (setes-api `src/shared/db/connection.ts`) + `fromJson` tolerante
  (`_asDouble` aceita num E string — geo_entities.dart). Em TODO cadastro
  novo com campo decimal: nunca usar `as num` direto no fromJson, e nunca
  engolir exceção de parse silenciosamente no onSearch.

## Checklist de saída

- [ ] AppBar com voltar/título/check (e delete quando aplicável)
- [ ] FKs com SetesLookupField (id salvo, nome exibido, campo não editável)
- [ ] Zero strings hardcoded — tudo via .tr() em pt.json E en.json
- [ ] i18nKey roteado no interface_frame.dart
- [ ] flutter analyze limpo

## Campos configuráveis (Fase 2 — OBRIGATÓRIO em toda tela nova, 2026-07-12)

Prompt: `Infra-IA/setes-app/prompt_fase2_campos_configuraveis.md` (22 decisões).

1. **Catálogo**: toda tela nova ganha suas linhas em `setes_central.tb_interface_has_field`
   — rode na setes-api: `npm run fields:gen -- --interface <id> --tables <t1,t2>`,
   revise o .sql (required baseline = DDL NOT NULL ∪ DTO obrigatório) e aplique.
   **Campo novo em tela existente = linha nova no catálogo** (mesma tool).
2. **Engine na página**: `with FieldConfigLoader` + `loadFieldConfig('<modulo>')` no
   initState + `fields: applyFieldConfig([...], fieldConfig)` na fábrica
   (shared/field_config + shared/register/field_config_merge.dart).
3. **Validadores**: use `SetesValidators.*` (package setes_validators — espelho do
   shared/validation da API). Retornam CHAVE i18n (`forms.validation.*`); a fábrica
   traduz. Override manual: parâmetro `message`. Máscara `#`/`A` via `RegisterField.mask`
   (o valor vai SEM máscara no onSave — decisão 19).

- [ ] Linhas da tela no catálogo (fields:gen) — campo novo incluído
- [ ] FieldConfigLoader + applyFieldConfig ligados na página

- 2026-07-12: cadastro de Usuário em DUAS ABAS (pedido do Valdo) — a fábrica
  ganhou `extraTabs: List<RegisterTab>` (evoluir a fábrica em vez de form
  artesanal, decisão 20): campos + extraChildren ficam na aba principal
  (rótulo via `mainTabLabel`) e cada RegisterTab vira aba própria com
  conteúdo/rolagem da página. A aba principal fica em keep-alive — o check
  do shell valida o Form mesmo com outra aba aberta. Sem extraTabs o layout
  é o original (zero impacto nas telas existentes).

## Configurações do sistema (Framework de Configurações, 2026-07-18)

Prompt: `Infra-IA/setes-app/prompt_framework_configuracoes_sistema.md` (17 decisões).
Nível COMPORTAMENTO da hierarquia (tela → campo → configuração).

1. **Ícone de engrenagem na tela de LISTA** (decisão 11 — PADRÃO, com ou sem
   configs no catálogo; ajuste 2026-07-18): basta passar
   `configModuleKey: '<modulo>'` no `RegisterSearchPage` — a fábrica renderiza
   a engrenagem, navega para `/home/interface-configs/` já filtrado
   (arguments `{'title','moduleKey','returnTo'}`) e o VOLTAR do painel retorna
   à tela chamadora (`returnTo`). Sem configs, o painel mostra "Não há
   configurações para esta interface". Referência: customer_page.dart.
2. **Consumo de config na página**: `with InterfaceConfigLoader` +
   `loadInterfaceConfig('<modulo>')` no initState; leia com
   `configContent('<name>')` / `configBool('<name>')`
   (shared/interface_config — molde do FieldConfigLoader). Resolução
   usuário → institution → default é feita pela API (cache TTL).
3. **Config nova = linha no catálogo** pela seção "Configurações" da tela de
   Interfaces (Super) — NUNCA tela artesanal por opção. Vendável NÃO é config:
   é interface `kind='R'` gateada pelo contrato (decisão 1).
4. **Estado de sessão** (decisão 17): fato derivado do usuário (ex.: isSalesman)
   vem do `SessionContext` (`app/shared/session/`) — preenchido na entrada da
   Home via /api/core/me; telas SÓ leem; enforcement é sempre da API.
   PROIBIDO variável global solta.

- [ ] Engrenagem na lista quando a interface tem configs
- [ ] InterfaceConfigLoader ligado quando a tela consome config

## Cadastro em ÁRVORE — 2º tipo de cadastro (Valdo, 2026-07-18)

Nem todo cadastro é lista+form: cadastros HIERÁRQUICOS (1º caso real:
Categorias de produtos/serviços — porta do Delphi reg_category.pas) usam
TREEVIEW. Moldes completos: `categories` (abas por domínio — kind define a
árvore) e `financial_plans` (árvore ÚNICA — Natureza/Tipo/Nível são radios
do form; matemática do caminho em `@shared/tree-path`, promovida no 2º
consumidor).

**Banco/API:**
- `posit_level` = caminho materializado (segmentos = código pad 3: '001',
  '001.005'); profundidade = nº de pontos; `KEY updated_at` p/ sync.
- O caminho nasce na CRIAÇÃO (caminho do pai + código) e é SEMPRE da API —
  matemática em funções puras (`categories.path.ts`: pathSegment/childPath/
  parentIdFromPath/isSelfOrDescendant — testadas em categories-tree.test.ts).
- GET ordenado por posit_level (ordem já é a da árvore) devolvendo `parentId`
  derivado; POST com `parentId` (null = raiz); PUT com `parentId` diferente =
  MOVER (recalcula a subárvore inteira em transação: CONCAT + SUBSTRING no
  prefixo; proibido ciclo — self/descendente — e pai de outro domínio);
  DELETE 409 com subníveis (só folhas — decisão do Valdo).
- Domínios paralelos (kind 'P' produtos × 'S' serviços) = árvores
  INDEPENDENTES; kind obrigatório no create e IMUTÁVEL.

**App:**
- `SetesTreeView` (setes_widgets): nós montados pelo módulo (`parentId` →
  filhos), expand/collapse, clique = edição, ação "+" no nó = SUBNÍVEL.
- Tela: AppBar (título + engrenagem manual — a fábrica não é usada) + abas
  por domínio + FAB = NÍVEL raiz (Delphi: dialog "Nível/SubNível" virou
  FAB + ação no nó).
- Form (SetesFormShell): descrição + "Nível Superior" = SetesLookupField da
  MESMA árvore (lista já carregada; exclui self+descendentes no cliente — a
  API revalida), limpar = raiz; ativo checkbox. Posição/código: API.
- Engine de campos (Fase 2) NÃO se aplica ao form de árvore v1 (form
  artesanal); o catálogo de campos existe só para documentação do painel.

- [ ] Caminho calculado só na API (app nunca monta posit_level)
- [ ] Mover valida ciclo/domínio; excluir bloqueado com filhos
- [ ] SetesTreeView + FAB raiz + ação de subnível no nó
