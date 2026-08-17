# Prompt — Paginação das Telas de Pesquisa (setes-app × setes-api)

**Status**: ✅ FECHADO e EXECUTADO (2026-08-03) — Rodada 0 aprovada integralmente pelo Valdo
("tudo ok, pode prosseguir"); implementação completa nas 4 ondas: piloto customers +
8 cadastros centrais + 6 do cliente (D7 executada) + telas de processo. Validação:
setes-api `tsc` limpo + 143/143 testes (9 novos de paginação); setes-app
`flutter analyze` sem issues. Seed 22 aplicado no banco dev.
**Criado**: 2026-08-03
**Escopo**: setes
**Método**: `Infra-IA/skills-genericas/refinar-prompt-arquitetura.md` (rodadas de decisão numeradas)

---

## Contexto

As telas de pesquisa que antecedem os formulários de registro **não têm paginação em nenhuma
das duas pontas**:

- **setes-api**: todos os GETs de lista seguem um padrão único — `?filter=` com `LIKE %x%`,
  `ORDER BY` fixo e **`LIMIT 200` hardcoded no SQL** (settlements 300, lookups 50/100,
  categories/financial-plans/users/payment-types sem limite nenhum). A resposta é o envelope
  `{ ok, data }` com **array puro** — sem `total`, `page` ou `hasMore`. Não existe helper
  compartilhado de listagem em `src/shared/` (cada repository copia o bloco
  `const like = ...` + `LIMIT 200`).
- **setes-app**: a fábrica `RegisterSearchPage<T>`
  (`apps/web/lib/app/shared/register/register_search_page.dart`) é o ponto único de UI das
  15 telas de cadastro, mas não tem `ScrollController`, `onLoadMore`, contagem nem página.
  O contrato de dados é `List<T>` puro em todas as camadas
  (`Future<List<X>> getList(String filter)` → `Either<Failure, List<X>>` → `<X>ListState.items`).
- **Consequência prática**: a lista **trunca silenciosamente em 200 registros** e o usuário
  depende do filtro para achar o registro — sem nenhum aviso de que há mais dados.

### Inventário do estado atual (levantado em 2026-08-03)

**API — 16 módulos de cadastro com GET de coleção** (17 endpoints) + 2 telas de processo:
countries, states, cities, cfop, interfaces, privileges, institutions, users (central);
customers (com filtro de carteira via config), collaborators, categories (árvore),
financial-plans (árvore), payment-types (vínculo + catálogo), contracts, bank-accounts,
interface-fields/interface-configs (vitrine) — e service-orders + settlements (processo).
Lookups auxiliares: salesman/carrier (LIMIT 50), banks/products (LIMIT 100).

**App — 15 telas usam a fábrica** `RegisterSearchPage` (customers, collaborators, countries,
states, cities, cfop, bank_accounts, contracts, institutions, interfaces, interface_configs,
interface_fields, payment_types, privileges, users). **Fora da fábrica**: categories e
financial_plans (árvore com `SetesTreeView`, sem filtro), service_orders (TabBar A/F com
filtro copiado à mão), settlements (tela operacional com seleção).

**Dois modelos de filtro coexistem no app**:
- (a) **Remoto** (maioria): `onFilterChanged` → bloc → `?filter=` na API (busca no Enter/lupa).
- (b) **Local** (4 módulos): bank_accounts, contracts, payment_types e financial_plans
  carregam tudo e filtram em memória (`_all` + `_filtered` no bloc) — a API desses módulos
  não aceita `filter` na listagem principal. ⚠️ Paginação remota quebra esse modelo (ver Q7).

**Referência histórica**: o app legado (`Infra-IA/codigo-aprendizado/weberpsetes`) usava
infinite scroll por página (`_scrollController` + `bloc.pageCustomer` no evento) — padrão
conhecido do Valdo, mas anterior à arquitetura atual de módulos.

**Peças existentes reutilizáveis**:
- Framework de Configurações (`tb_interface_has_config` × `tb_institution_has_config`,
  resolução usuário → institution → default, engrenagem já presente na tela de lista via
  `configModuleKey`) — candidato natural para persistir "itens por página" (Q4).
- `shared/http/controller-utils.ts` (API) e `packages/core` (app) — lares naturais dos
  helpers novos.
- Filtro de carteira do customers é aplicado **dentro do SQL** (`customers.service.ts:34-40` →
  4º argumento do repository) — qualquer `COUNT(*)` de total precisa reaplicar o mesmo
  predicado; a contagem tem que sair da MESMA cláusula WHERE da listagem.

### Fronteira (regra canônica dos dois grupos — D1 da revisão do sync)

Esta fase toca **somente setes-app × setes-api**. Os endpoints `/sync/*` da setes-sync têm
protocolo próprio (com `limit` parametrizado) e **não são tocados**.

---

## Objetivos

1. Criar o **contrato de paginação da API**: query params padronizados, clamp de limites,
   envelope de resposta com metadados — implementado UMA vez em `src/shared/list/` e
   consumido por todos os endpoints de lista (fim do `LIMIT 200` copiado).
2. Evoluir a **fábrica `RegisterSearchPage`** para gerenciar paginação — as 15 telas herdam
   sem reescrever tela nenhuma (mudança concentrada na fábrica + um helper de bloc).
3. Permitir que o **usuário escolha o número de itens por página** (mecanismo e persistência
   definidos nas questões Q1/Q4/Q5).
4. Estender o padrão às **telas de processo** (service-orders, settlements) e definir o
   destino das telas fora da fábrica (árvores, lookups — Q6).
5. Garantir que **toda tela futura nasce paginada**: atualizar as skills
   `criar-formulario-cadastro.md` (app) e `novo-modulo.md` (api) para que o padrão seja
   herdado por construção.

---

## Workflow (visão ponta a ponta proposta)

```
Usuário abre a tela de pesquisa
  → página dispara <X>ListRequested(filter: '', page: 1)   [initState, como hoje]
  → bloc resolve pageSize (decisão Q4) e chama usecase(filter, page, pageSize)
  → datasource monta /api/<modulo>?filter=&page=&pageSize=
  → API: shared/list parseia e CLAMPA page/pageSize
  → repository: 1 SELECT com LIMIT ? OFFSET ? + contagem (decisão Q2)
      (mesma cláusula WHERE nos dois — inclusive carteira do vendedor)
  → resposta: envelope paginado (formato na decisão Q3)
  → state da lista ganha os metadados (page, pageSize, total/hasMore)
  → RegisterSearchPage renderiza a lista + controles de paginação (decisão Q1)
Usuário muda página / muda itens-por-página / filtra
  → novo evento com os parâmetros → mesmo ciclo (filtro sempre volta à página 1)
```

**Regra de recarga**: salvar/excluir/voltar do form recarrega **a página corrente** com o
último filtro (o bloc já guarda `_filter`; passa a guardar `_page`/`_pageSize` também).

---

## Especificações técnicas propostas

### API — `src/shared/list/` (novo, greenfield)

- `parseListQuery(req, opts)` → `{ filter, page, pageSize, offset }` com clamp
  (page ≥ 1; pageSize dentro dos valores permitidos — Q5) e defaults.
- Helper de envelope paginado (formato — Q3).
- Cada repository de lista troca `LIMIT 200` por `LIMIT ? OFFSET ?` e ganha a função de
  contagem irmã **com a mesma cláusula WHERE** (se Q2 = total real).
- `ORDER BY` ganha desempate estável por `id` (Q8) — obrigatório para OFFSET não "pular"
  nem repetir registros entre páginas.
- Swagger: bloco `parameters` padrão (filter/page/pageSize) documentado em todos os
  `*.routes.ts` adaptados, na mesma entrega (regra vigente do Swagger obrigatório).

### App — camadas compartilhadas

- `packages/core`: classe `PagedResult<T>` (`items`, `page`, `pageSize`, `total`/`hasMore`)
  — o contrato `List<T>` das camadas vira `PagedResult<T>` nos módulos adaptados.
- `RegisterSearchPage<T>` v2: novos parâmetros (nomes finais na implementação) —
  metadados da página + callbacks `onPageChanged`/`onPageSizeChanged` — e o widget de
  controles conforme Q1. Telas que não passarem os parâmetros novos continuam funcionando
  (defaults null → comportamento atual), permitindo migração por ondas.
- Bloc: os eventos `<X>ListRequested` ganham `page` (e o state os metadados). Avaliar um
  mixin/helper compartilhado para não copiar a mecânica em 15 blocs.
- i18n: chaves novas no bloco `register.*` (pt/en) para os controles de paginação.

---

## Entregáveis executados (2026-08-03)

| Entregável | O quê | Status |
|---|---|---|
| `setes-api/src/shared/list/` | parseListQuery (clamp + default via config), pagedEnvelope, PagedRows | ✅ |
| `sql/22_page_size_config_seed.sql` | config `page_size` (Options 10/25/50/100, default 25, scope U) nas 17 interfaces de lista | ✅ aplicado em dev |
| `PUT /api/interface-configs/key/:moduleKey/:name` | gravação do override por chave de módulo (N3) | ✅ |
| `packages/core` `PagedResult<T>` | contrato paginado do app | ✅ |
| Fábrica v2 + `RegisterPagingBar` + i18n | barra « X de Y » + seletor, persistência da escolha (N7) | ✅ |
| Piloto customers | ponta a ponta, incl. COUNT com carteira (testes) | ✅ |
| Onda 2 — 8 cadastros centrais | countries, states, cities, cfop, interfaces, privileges, institutions, users | ✅ |
| Onda 3 — 6 do cliente + D7 | collaborators, contracts, bank-accounts, payment-types (+filter), vitrines interface-fields/configs; filtro local aposentado | ✅ |
| Onda 4 — processo | service-orders (abas), settlements (bills/settled, seleção multi-página N8); extrato fora (N10) | ✅ |
| Skills/arquitetura | criar-formulario-cadastro.md, novo-modulo.md, ARQUITETURA_MODULOS.md, ARQUITETURA_MODULOS_API.md | ✅ |
| Swagger + testes | page/pageSize em todos os GETs adaptados; 143/143 (9 novos em `list-pagination.test.ts`) | ✅ |

---

## Decisões arquiteturais registradas

Rodada 0 aprovada em bloco pelo Valdo (2026-08-03) — todas as recomendações viraram decisão:

1. **D1 — UI**: barra de paginação explícita no rodapé da lista (« anterior | página X de Y |
   próxima ») + seletor de itens por página. Sem infinite scroll.
2. **D2 — Total real**: `COUNT(*)` no mesmo request, com a MESMA cláusula WHERE da listagem
   (inclusive carteira do vendedor); envelope carrega `total`; título pode exibir "(N)".
3. **D3 — Envelope**: metadados no topo — `{ ok, data, page, pageSize, total }`; endpoint
   adaptado responde paginado SEMPRE (sem `page` na query = página 1 com default). Sem
   caminho retrocompat duplo; app e API migram juntos, onda a onda.
4. **D4 — Persistência da escolha**: config `page_size` no Framework de Configurações
   (catálogo central, scope U, resolução usuário → institution → default; o seletor da tela
   grava a config do usuário). Zero tabela nova.
5. **D5 — Valores**: pageSize ∈ {10, 25, 50, 100}, default 25, teto absoluto 200; API clampa
   valor fora do conjunto.
6. **D6 — Recorte**: 15 telas da fábrica + telas de processo (service-orders, settlements)
   entram; árvores (categories, financial-plans) FORA (carregam hierarquia inteira);
   lookups FK FORA (pesquisa incremental já mitiga).
7. **D7 — Fim do filtro local**: bank-accounts, contracts e payment-types ganham `filter`
   remoto na API e entram na paginação; o filtro em memória dos blocs é aposentado
   (financial-plans segue a regra de árvore da D6).
8. **D8 — Ordenação**: ORDER BY atual de cada lista + desempate estável por `id`;
   ordenação escolhida pelo usuário = fase futura.
9. **D9 — Migração**: piloto em `customers` (caso mais rico) → ondas pelos demais;
   fábrica com defaults null permite convivência durante a transição.
10. **D10 — OFFSET**: paginação por LIMIT/OFFSET nesta fase; keyset/cursor registrado como
    otimização futura para listas de movimento de alto volume.

---

## Notas da implementação (2026-08-03)

Refinamentos decididos DURANTE a execução (dentro das decisões D1–D10):

- **N1 — `page_size` catalogada POR INTERFACE** (17 linhas — 15 fábrica + service-orders
  + settlements; seed `sql/22_page_size_config_seed.sql`, idempotente por `i18n_key`):
  cada tela lembra o próprio tamanho; interface de lista NOVA deve entrar no seed 22.
- **N2 — default resolvido NA API**: sem `pageSize` na query, `parseListQuery(req, moduleKey)`
  resolve a config `page_size` (usuário → institution → default, cache TTL) — a preferência
  persistida vale em qualquer dispositivo sem o app precisar ler config para paginar.
- **N3 — PUT por chave de módulo**: novo `PUT /api/interface-configs/key/:moduleKey/:name`
  (o app conhece o moduleKey, não o id da interface). O seletor da fábrica persiste o
  override do usuário por aí, silenciosamente (falha não quebra a tela).
- **N4 — envelope compatível com leitores antigos**: `data` continua sendo o array, então
  datasources que leem só `json['data']` (lookups FK) seguem funcionando; os lookups de
  país/estado/cidade passam a pedir `pageSize=100` explícito para manter o alcance.
- **N5 — recuo de página vazia**: excluir o último item da última página recua o bloc para
  a última página existente (nunca exibe página vazia com total > 0).
- **N6 — resposta da API é a fonte da verdade no bloc**: `_page`/`_pageSize` são
  re-sincronizados com o envelope devolvido (clamp/config aplicados pela API).
- **N7 — `RegisterPagingBar` extraído** (Onda 4): a barra saiu da fábrica para
  `app/shared/register/register_paging_bar.dart` — a fábrica a monta, e as telas de
  processo (service-orders, settlements) a usam diretamente no rodapé.
- **N8 — seleção multi-página no settlements**: a seleção de títulos virou
  `Map<orderId-parcel, SettlementBill>` no BLOC (título inteiro na chave) — sobrevive a
  página/filtro, somas corretas com seleção fora da página visível, objetos atualizados
  quando a chave reaparece; só baixa/estorno limpam.
- **N9 — COUNT com HAVING** (`listBills`): o total envolve o SELECT interno (com o
  HAVING sobre aliases calculados) numa subquery `SELECT COUNT(*) FROM (...) t` — molde
  para qualquer lista futura com HAVING.
- **N10 — extrato NÃO pagina**: `listStatements` é relatório com totais/saldo sobre
  todas as linhas — paginar quebraria a semântica (exceção registrada na skill
  novo-modulo.md).
- **N11 — lista de apoio sobre endpoint paginado**: pede `pageSize=100` explícito
  (lookups geo, privilégios do form de interfaces, aba Usuários do Institution,
  lookup de clientes do contracts, resolução por chave do interface_configs).

## Questões pendentes

**Nenhuma.** (As 10 questões da Rodada 0 foram aprovadas em bloco e movidas para as
Decisões D1–D10 acima; o texto original das questões segue abaixo como histórico.)

<details>
<summary>Histórico — Questões da Rodada 0 (respondidas)</summary>

**Q1 — Modelo de UI da paginação na `RegisterSearchPage`**
Problema: "paginação" pode ser três UIs diferentes; o pedido cita explicitamente "usuário
escolhe o número de itens por página", o que pede controle visível.
Evidência: legado weberpsetes usava infinite scroll por página; a fábrica atual não tem
nenhum hook de scroll.
Opções:
- (a) **Barra de paginação explícita** (« anterior | página X de Y | próxima ») + seletor
  de itens/página no rodapé da lista. Previsível, casa com "escolher itens por página" e
  com Web/desktop. **(Recomendado)**
- (b) Infinite scroll (carrega a próxima página ao chegar no fim) + seletor de tamanho do
  lote. Fluido no mobile, mas "total de páginas" perde sentido e a posição se perde ao
  voltar do form.
- (c) Botão "Carregar mais (N restantes)" no fim da lista + seletor. Meio-termo simples.

**Q2 — Total de registros: contar ou não?**
Problema: mostrar "página X de Y" / "N registros" exige um `COUNT(*)` extra com o MESMO
WHERE da listagem (inclusive carteira do vendedor); só saber "tem mais" sai de graça
(truque de pedir pageSize+1).
Evidência: filtro de carteira é aplicado dentro do SQL (`customers.service.ts:34-40`) —
contagem na tabela crua daria número errado.
Opções:
- (a) **COUNT real** no mesmo request, envelope com `total`. Volumes de cadastro são
  pequenos/médios e o WHERE é indexável; permite título "Lista de Clientes (N)" como no
  legado. **(Recomendado)**
- (b) Só `hasMore` (pageSize+1). Mais barato, mas sem "página X de Y" — combinaria com
  Q1(b)/(c), não com Q1(a).

**Q3 — Formato do envelope e retrocompatibilidade**
Problema: hoje TODO GET de lista responde `{ ok, data: [...] }`; onde entram os metadados
e o que acontece com quem chamar sem `page`?
Opções (formato):
- (a) **Metadados no topo**: `{ ok, data, page, pageSize, total }`. Simples, `data`
  continua sendo o array — datasources atuais não quebram. **(Recomendado)**
- (b) Aninhado: `{ ok, data, meta: { page, pageSize, total } }`.
Opções (compat):
- (c) **Endpoint adaptado responde paginado SEMPRE** (sem `page` na query = página 1 com
  pageSize default). App e API evoluem juntos, onda a onda; sem ramificação de código.
  **(Recomendado)**
- (d) Paginar só quando `page` vier na query (retrocompat total, mas dois caminhos de
  código para sempre).

**Q4 — Onde persiste a escolha de "itens por página" do usuário**
Problema: o usuário escolhe o tamanho — isso vale só para a sessão, para o navegador, ou
é preferência persistida por usuário?
Evidência: o Framework de Configurações já existe exatamente para isso (scope U, resolução
usuário → institution → default, engrenagem já presente na tela de lista via
`configModuleKey`) — e a escolha viraria também um item vendável/configurável por cliente.
Opções:
- (a) **Config `page_size` no Framework de Configurações** — 1 config no catálogo,
  semeada para as interfaces de lista; o seletor da tela grava a config do usuário (scope U)
  e o default vem da cadeia institution → default. Zero tabela nova. **(Recomendado)**
- (b) Só em memória (volta ao default a cada visita à tela).
- (c) localStorage/por dispositivo (fora do padrão do sistema, não viaja entre dispositivos).

**Q5 — Valores permitidos e default de pageSize**
Problema: precisa de um conjunto fechado (clamp na API) e um default.
Sugestão: **10 / 25 / 50 / 100, default 25** — e a API clampa qualquer valor fora do
conjunto para o mais próximo permitido (teto absoluto 200, o limite atual). Confirme ou
ajuste os números.

**Q6 — Quais listas entram nesta fase**
Problema: nem toda lista é uma "tela de pesquisa de cadastro".
Proposta de recorte:
- (a) **15 telas da fábrica**: TODAS entram. **(Recomendado)**
- (b) **Telas de processo** (service-orders, settlements): entram na onda final desta fase
  **(Recomendado)** ou ficam para fase própria?
- (c) **Árvores** (categories, financial-plans): FORA — árvore não pagina; carrega a
  hierarquia inteira. **(Recomendado)**
- (d) **Lookups FK** (`showSetesLookup`, LIMIT 50/100): FORA desta fase — a pesquisa
  incremental já mitiga; padronizar depois se doer. **(Recomendado)** Alternativa: incluir
  com "carregar mais" simples.

**Q7 — Os 4 módulos de filtro LOCAL (bank_accounts, contracts, payment_types, financial_plans)**
Problema: eles carregam tudo e filtram em memória; paginação remota quebraria o filtro.
Evidência: comentário no próprio código ("a API limita a 200 — o filtro da tela é LOCAL");
a API desses módulos não aceita `filter` na listagem principal.
Correção sugerida: **uniformizar** — endpoints ganham `filter` remoto (mesmo LIKE dos
demais) e o filtro local é aposentado; bank_accounts, contracts e payment_types entram na
paginação como os outros (financial_plans segue a regra de árvore da Q6c). **(Recomendado)**
Alternativa: mantê-los locais e sem paginação (aceita o teto e a exceção ao padrão).

**Q8 — Ordenação**
Problema: OFFSET exige ORDER BY estável; e "sort escolhido pelo usuário" é um recurso à parte.
Correção sugerida: manter o ORDER BY atual de cada lista + **desempate por `id`**; ordenação
configurável pelo usuário = fora de escopo desta fase. **(Recomendado)**

**Q9 — Estratégia de migração e piloto**
Problema: 16+ endpoints e 15+ telas — big bang ou ondas?
Correção sugerida: **piloto em `customers`** (o caso mais rico: carteira no SQL, banner,
configModuleKey — se funcionar nele, funciona em todos) → ondas pelos demais, agrupando
módulos parecidos; a fábrica com defaults null permite conviver telas migradas e não
migradas durante a transição. **(Recomendado)** Alternativa: tudo de uma vez (entrega
única grande).

**Q10 — OFFSET × keyset (cursor)**
Problema: OFFSET degrada em tabelas muito grandes (o banco lê e descarta as linhas puladas).
Correção sugerida: **OFFSET nesta fase** — volumes de cadastro (clientes, cidades, CFOP)
são pequenos/médios e OFFSET é trivial de padronizar; keyset fica registrado como
otimização futura para listas de MOVIMENTO de alto volume. **(Recomendado)**

</details>

---

## Fora de escopo desta fase

- Endpoints `/sync/*` (setes-sync) — protocolo próprio, regra dos dois grupos (D1).
- Ordenação escolhida pelo usuário (ver Q8).
- Keyset/cursor pagination (ver Q10).
- Paginação dos lookups FK (se Q6d = Recomendado).
- Busca incremental (à medida que digita) na lista principal — hoje é Enter/lupa; mudar
  isso é outra discussão de UX.

---

## Critérios de sucesso

1. Nenhum repository de lista adaptado contém `LIMIT` hardcoded — todos consomem
   `src/shared/list/`.
2. Todo endpoint adaptado responde o envelope paginado e clampa page/pageSize; Swagger
   documenta os params novos na mesma entrega.
3. As 15 telas da fábrica paginam sem NENHUM código de paginação escrito na tela — tudo
   herdado da `RegisterSearchPage` v2 + helper de bloc.
4. O usuário escolhe itens por página e (conforme Q4) a escolha persiste.
5. Contagem/hasMore respeita TODOS os predicados do WHERE (provado por teste no piloto
   customers com carteira de vendedor ativa).
6. Salvar/excluir/voltar do form devolve o usuário à página e filtro onde estava.
7. Filtro novo sempre reinicia na página 1.
8. Telas em árvore permanecem íntegras (hierarquia completa, sem regressão).
9. Skills `criar-formulario-cadastro.md` e `novo-modulo.md` atualizadas — tela/endpoint
   novos nascem paginados por construção.
10. `flutter analyze` limpo + testes da API verdes (incluindo os novos de paginação).
