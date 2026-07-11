# Skill: Internacionalizar formulários no setes-app

**Status**: Vigente
**Origem**: Decisão 26 do prompt_fase1_fundacao.md (i18n via easy_localization) +
pedido do Valdo (2026-07-10): todo form novo nasce internacionalizado.
**Quando usar**: em TODO formulário/tela nova, e ao tocar em tela antiga com string fixa.

---

## Regras

1. **Zero strings hardcoded** em widgets — todo texto visível passa por `.tr()`
   (easy_localization). Inclui labels, títulos, hints, mensagens de erro/sucesso,
   textos de botão e colunas de lista.
2. **Sempre nos DOIS arquivos**: `apps/web/assets/translations/pt.json` e `en.json`.
   Chave sem tradução em um deles = bug (aparece a chave crua na tela).
3. Menus vindos do banco usam `trCatalog(i18nKey, description, prefix: 'menu.interfaces')`
   — fallback para a description do banco quando não há tradução (decisão 26).

## Estrutura de chaves (convenção)

```jsonc
{
  "register": {            // genéricas da fábrica de cadastros
    "search": "Pesquisar", "view": "Visualizar", "save": "Salvar",
    "cancel": "Cancelar",  "filter": "Filtro",   "filterHint": "Pesquise ou filtre aqui",
    "new": "Novo",         "delete": "Excluir",  "required": "Campo obrigatório",
    "invalidNumber": "Valor numérico inválido",
    "listTitle": "Lista de {}",   // título da pesquisa: .tr(args: ['Países']) → "Lista de Países" / en: "List of {}"
    "emptyList": "Não encontramos nenhum registro em nossa base.",
    "saved": "Registro salvo", "deleted": "Registro excluído",
    "confirmDelete": "Confirma a exclusão?", "error": "Não foi possível concluir a operação"
  },
  "lookup": {              // títulos das listas de apoio (campo-lookup-fk.md)
    "countries": "Lista de países", "states": "Lista de estados", "cities": "Lista de cidades"
  },
  "forms": {               // campos específicos por entidade: forms.<entidade>.<campo>
    // REGRA (Valdo 2026-07-11): labels POR EXTENSO repetindo a entidade —
    // nunca "Código"/"Nome" soltos. SEM chave "title": o título da tela é o
    // nome da interface no menu, passado pelo InterfaceFrame via trCatalog.
    "country": { "code": "Código do País", "name": "Nome do País" },
    "state":   { "country": "País", "abbreviation": "Sigla do Estado (UF)",
                 "name": "Nome do Estado", "aliquota": "Alíquota do Estado" },
    "city":    { "state": "Estado", "name": "Nome da Cidade",
                 "ibge": "Código IBGE", "aliqIss": "Alíquota ISS", "population": "População",
                 "density": "Densidade", "area": "Área" }
  }
}
```

- `menu.interfaces.<i18nKey>` — nome da tela no menu (já existente, decisão 26)
- `register.*` — vocabulário comum de qualquer CRUD (nunca duplicar por entidade)
- `forms.<entidade>.<campo>` — labels de campos (camelCase igual à entidade Dart)
- `lookup.<plural>` — título das listas de apoio

## Workflow

1. Escrever o widget já com `.tr()` — nunca "traduzir depois".
2. Adicionar as chaves novas em `pt.json` E `en.json` na mesma edição (mesma ordem
   de chaves nos dois arquivos, para diff fácil).
3. Reaproveitar `register.*` antes de criar chave nova — se a palavra já existe
   (Salvar, Cancelar, Filtro…), NÃO criar variante por entidade.
4. Conferir na tela: string aparecendo como `forms.state.name` crua = chave faltando
   OU app sem restart — easy_localization NÃO recarrega os JSONs em hot reload;
   sempre fazer restart completo antes de investigar.

## Checklist

- [ ] Nenhuma string literal visível no .dart do form
- [ ] pt.json e en.json com as MESMAS chaves (nas duas línguas)
- [ ] Vocabulário comum veio de register.* (sem duplicação)
- [ ] Labels de campo em forms.<entidade>.*, listas de apoio em lookup.*
