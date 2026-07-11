# Skill: Campo lookup para chave estrangeira (FK) no setes-app

**Status**: Vigente
**Origem**: Padrão do app antigo (`customer_register_address_widget.dart` — campos UF e
Cidade — e `customer_register_city_list_widget.dart`), adaptado ao design system setes_widgets.
**Referências**: `criar-formulario-cadastro.md` (contrato visual), decisão 11 (setes_widgets)
**Quando usar**: TODO campo de formulário que grava um id de outra tabela (tb_xxx_id).
O usuário NUNCA digita id — ele escolhe numa lista com filtro.

---

## Comportamento (regra do Valdo, 2026-07-10)

1. O campo mostra o **nome/descrição** do registro relacionado — **não editável** (readOnly).
2. Sufixo do campo: `IconButton(Icons.search)` que abre a **lista de apoio**.
3. A lista tem **campo filtro no topo** (pesquisa incremental) + itens em
   `ListView.separated` (ListTile com CircleAvatar do id + nome).
4. Ao escolher: grava o **id** no modelo, exibe a **descrição** no campo, fecha a lista.
5. Lookup dependente (ex.: Cidade depende do Estado escolhido): passar o id-pai no
   `onSearch`; se o pai ainda não foi escolhido, mostrar SnackBar pedindo para
   escolher o pai primeiro (no app antigo, cidade buscava por tbStateId).

## Widgets do design system (packages/setes_widgets)

**JÁ IMPLEMENTADOS** (reforma do Estado, 2026-07-11) em
`packages/setes_widgets/lib/src/setes_lookup_field.dart` e `setes_lookup.dart`,
exportados no barrel.

**Datasources/entidades de lookup COMPARTILHADOS** (refatoração 2026-07-11 —
ARQUITETURA_MODULOS.md): vivem em `apps/web/lib/app/shared/lookup/`
(`country_lookup_datasource.dart`, `state_lookup_datasource.dart` + entidades
mínimas `CountryLookup`/`StateLookup`). O módulo que precisa faz o bind no seu
próprio Module (ex.: StatesModule binda CountryLookupDatasource) — módulo NUNCA
importa a entidade/datasource de outro módulo. Lookup novo: nasce em shared se
2+ módulos usam; senão nasce dentro do próprio módulo.

Diferenças em relação ao esboço abaixo:

- `showSetesLookup` recebe `filterHint` e `emptyText` OBRIGATÓRIOS e já
  traduzidos pelo chamador (`'register.filterHint'.tr()` / `'register.emptyList'.tr()`)
  — o pacote setes_widgets NÃO depende de easy_localization.
- `SetesLookupField` envolve tudo em `ExcludeFocusTraversal` (item 8 do
  contrato visual: lookup fica fora do Tab).
- A fábrica ganhou `RegisterField.lookup(name, label, display, onPick,
  validatorMessage)` — renderiza SetesLookupField sem controller; o id fica no
  ESTADO DA PÁGINA (nunca entra nos values do onSave). Uso real: state_page.dart.

Esboço original (referência de comportamento):

### 1. `SetesLookupField` — o campo no formulário

```dart
import 'package:flutter/material.dart';

/// Campo de FK: mostra a descrição (readOnly) + ícone de pesquisa que abre
/// a lista de apoio. O id fica no estado do form, nunca é digitado.
class SetesLookupField extends StatelessWidget {
  const SetesLookupField({
    required this.label,
    required this.display,     // descrição atual ('' se nada escolhido)
    required this.onSearch,    // abre a lista de apoio
    this.onClear,              // opcional: limpa a escolha (Icons.close)
    this.validatorMessage,     // se != null e display vazio, mostra erro
    super.key,
  });

  final String label;
  final String display;
  final VoidCallback onSearch;
  final VoidCallback? onClear;
  final String? validatorMessage;

  @override
  Widget build(BuildContext context) => TextFormField(
        key: ValueKey(display), // força rebuild quando a escolha muda
        initialValue: display,
        readOnly: true,
        onTap: onSearch,        // clicar no campo também abre a lista
        validator: (_) =>
            (validatorMessage != null && display.isEmpty) ? validatorMessage : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onClear != null && display.isNotEmpty)
                IconButton(icon: const Icon(Icons.close, size: 20), onPressed: onClear),
              IconButton(icon: const Icon(Icons.search, size: 20), onPressed: onSearch),
            ],
          ),
        ),
      );
}
```

### 2. `showSetesLookup<T>` — a lista de apoio com filtro

```dart
import 'package:flutter/material.dart';

/// Lista de apoio genérica (padrão customer_register_city_list_widget):
/// filtro no topo, ListView.separated, CircleAvatar com id, retorna o item
/// escolhido via Navigator.pop.
Future<T?> showSetesLookup<T>({
  required BuildContext context,
  required String title,                              // ex.: 'lookup.states'.tr()
  required Future<List<T>> Function(String filter) onSearch,
  required int Function(T item) itemId,
  required String Function(T item) itemLabel,
  String? filterHint,                                 // default 'register.filterHint'.tr()
}) =>
    showDialog<T>(
      context: context,
      builder: (_) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
          child: _SetesLookupBody<T>(
            title: title, onSearch: onSearch,
            itemId: itemId, itemLabel: itemLabel, filterHint: filterHint,
          ),
        ),
      ),
    );

class _SetesLookupBody<T> extends StatefulWidget { /* ... */ }

class _SetesLookupBodyState<T> extends State<_SetesLookupBody<T>> {
  List<T> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _search('');            // carrega lista inicial já na abertura
  }

  Future<void> _search(String filter) async {
    setState(() => _loading = true);
    final items = await widget.onSearch(filter);
    if (mounted) setState(() { _items = items; _loading = false; });
  }

  // build: Column[
  //   AppBar-like header: BackButton/close + Text(title),
  //   TextField(filtro, prefixIcon: Icons.search, onChanged: _search),  ← incremental
  //   Expanded(
  //     _loading ? ProgressIndicator
  //     : _items.isEmpty ? Center(Text('register.emptyList'.tr()))
  //     : ListView.separated(
  //         itemBuilder: (_, i) => ListTile(
  //           leading: CircleAvatar(child: Text('${widget.itemId(_items[i])}')),
  //           title: Text(widget.itemLabel(_items[i])),
  //           onTap: () => Navigator.of(context).pop(_items[i]),
  //         ),
  //         separatorBuilder: (_, __) => const Divider(height: 1),
  //       ),
  //   ),
  // ]
}
```

## Uso no formulário (exemplo: Estado escolhe País)

```dart
int?    _countryId;      // inicializado com _editing?.tbCountryId
String  _countryName = ''; // inicializado com _editing?.countryName ?? ''

SetesLookupField(
  label: 'forms.state.country'.tr(),
  display: _countryName,
  validatorMessage: 'register.required'.tr(),
  onSearch: () async {
    final picked = await showSetesLookup<CountryEntity>(
      context: context,
      title: 'lookup.countries'.tr(),
      onSearch: _ds.listCountries,
      itemId: (c) => c.id,
      itemLabel: (c) => c.name ?? '',
    );
    if (picked != null) {
      setState(() { _countryId = picked.id; _countryName = picked.name ?? ''; });
    }
  },
)
```

No salvar: enviar `_countryId` (nunca texto). A entidade precisa do campo de exibição
(`countryName`) vindo da API via JOIN — se faltar, ajustar o repository do setes-api
(`LEFT JOIN` na tabela pai, alias camelCase).

## Checklist

- [ ] Campo readOnly — id nunca digitável
- [ ] Ícone Icons.search abre a lista; clicar no campo também
- [ ] Lista com filtro incremental no topo e carga inicial na abertura
- [ ] CircleAvatar com id + nome no item
- [ ] API devolve o nome do relacionado (JOIN) para exibir na edição
- [ ] Lookup dependente valida o pai antes de abrir
