# Skill: Novo módulo de cadastro na setes-api (padrão simétrico)

**Status**: Vigente (substituiu o TBD em 2026-07-11)
**Objetivo**: Criar módulo de cadastro na setes-api espelhando o módulo gêmeo do setes-app
**Referência canônica**: `Infra-IA/setes-api/ARQUITETURA_MODULOS_API.md` (LER antes — regras e checklist)
**Modelos prontos**: `src/modules/countries/` (simples, código digitado + 409),
`src/modules/interfaces/` (id MAX+1 + N:N), `src/modules/privileges/` (mínimo, id MAX+1)
**Tempo**: ~20-30 min
**Escopo**: setes

---

## Regra de ouro

1 cadastro = 1 módulo com o MESMO nome (plural) nos dois projetos:
`setes-api/src/modules/<plural>/` ↔ `setes-app/apps/web/lib/app/modules/<plural>/`.
O lado app é responsabilidade do agente `setes-form-builder` (skill criar-formulario-cadastro.md).

## Passo 1 — Decidir o código (PERGUNTAR ao Valdo se não estiver claro)

- **Padrão externo** (BACEN, IBGE...): id digitado pelo usuário → `<m>CreateDto` com
  `id: z.number().int().positive()`, service valida `<m>IdExists` (INCLUINDO deleted='S')
  → 409; `ER_DUP_ENTRY` → 409 (corrida); PUT nunca altera id. Modelo: countries.
- **Sem padrão externo**: id `COALESCE(MAX(id),0)+1` no repository → sem 409;
  Código readOnly no app. Modelo: privileges.

## Passo 2 — Criar os 6 arquivos

```
src/modules/<plural>/
├── <plural>.interface.ts    tipos Row/Input (camelCase = shape do fromJson do app)
├── <plural>.dto.ts          Zod de entrada + z.infer
├── <plural>.repository.ts   SQL puro (pool.query; deleted='N' em list/get; soft delete)
├── <plural>.service.ts      regra (404 via fetch antes de edit/remove, 409, MAX+1, N:N)
├── <plural>.controller.ts   HTTP↔service: safeParse do DTO, parseId, envelope { ok, data },
│                            handleError — importa de '@shared/http/controller-utils'
└── <plural>.routes.ts       router FINO: router.get('/', controller.list)... + Swagger JSDoc
                             (path completo nos docs: /api/super/<plural>)
```

Copie o módulo modelo mais próximo e adapte — não escreva do zero.

## Passo 3 — Montar no gateway (guard POR MÓDULO)

`src/gateway/router.ts`: a URL segue o módulo — `/api/<plural>` espelha
`/home/<plural>` do app ("super" é só agrupador de menu: não vira pasta NEM URL —
decisão do Valdo 2026-07-11). Cadastro do catálogo central usa `superGuard`;
cadastro de cliente futuro usa o guard próprio dele, na mesma posição.

```ts
router.use('/<plural>', superGuard, <plural>Routes)   // → /api/<plural>
```

### Cadastro que o LEGADO alimenta → `catalogOwnerGuard` (D-PR41 revista + D-PR47/D-PR51, Rodada 7 de produtos — 2026-10-20)

Se a tabela do cadastro é **ID LOCAL no `Infra-IA/setes-sync/MAPA_INDEXACAO.md`** (o legado manda o id DELE — ex.: `tb_product.id` =
`PRO_CODIGO`, upsert pela PK no setes-sync) e a web cunha id por MAX+1 nela, o módulo **monta com `catalogOwnerGuard`**
(`src/gateway/catalog-owner.guard.ts`): a guarda pergunta "quem é o DONO do catálogo?" lendo o FATO `tb_institution.source_kind`
(peça `@shared/catalog-owner` — D-PR47: W nativo web · L transição do desktop legado · P PDV), **nunca a chave do sincronizador** (ela é
só autenticação; a pausa é interruptor de emergência — D-PR48). Em L a web só CONSULTA (escrita = 409 `CATALOG_LEGACY_OWNED`); em W/P
escreve. Sem a guarda o id da web cai no espaço do gerador do legado e o próximo envio SOBRESCREVE a linha sem aviso. É um MÉTODO
aplicado caso a caso (Valdo), não um bloqueio geral.

```ts
router.use('/<plural>', catalogOwnerGuard, <plural>Routes)   // hoje: merchandise, services, price-lists, categories, financial-plans, bank-accounts
```

E na MESMA entrega: (1) a tabela entra em `LEGACY_OWNED_TABLES` (`@shared/catalog-owner` — o catálogo de base da D-PR52 + plano de
contas e contas bancárias da D-PR51) e o módulo em `LEGACY_OWNED_MODULES` — a cerca de montagem (`catalog-owner-guard.test.ts`) e a
cerca por varredura (`adversarial-r7-gate.test.ts`: só os módulos guardados e as peças deles escrevem nessas tabelas) conferem as duas;
(2) o Swagger das rotas de escrita documenta o 409 `CATALOG_LEGACY_OWNED`; (3) teste da guarda pelo app real (molde
`src/__tests__/adversarial-merchandise-r3-guard.test.ts`). **Não há reconferência dentro da transação** (a `assertNoActiveSyncKey` da
Rodada 6 morreu): o fato é MONOTÔNICO — L → W/P pelo ato "encerrar a transição" (`POST /api/institutions/:id/end-legacy-transition`),
nunca de volta — logo quem passou pela guarda nunca é alcançado por um fechamento. **O que o legado NÃO produz fica FORA da guarda**, em
rota própria montada ANTES do módulo guardado (D-PR45: `services.fiscal.routes.ts` — regra de ISS e presunção IBS/CBS do serviço; cada
fato com o seu escritor). Pedido (`tb_order`) NÃO entra: a origem é separada pelo `terminal` (Valdo, Rodada 6 — Q-SY14/D-TM13).

## Passo 4 — Regras que NUNCA quebram

- FK para exibição: LEFT JOIN devolvendo `<pai>Name` (o app mostra no lookup)
- N:N pertence ao módulo que o gerencia (ex.: tb_interface_has_privilege em interfaces/)
- Módulo nunca importa módulo; 2+ usam → `shared/`
- **Cadastro que herda a cadeia fiscal** (Institution/Customer/Provider/Collaborator/Bank):
  NÃO reimplementar a cadeia — ela está pronta e desacoplada em `src/shared/`
  (`address/`, `phone/`, `social-media/`, `fiscal/` = peças com toggle F/J/N; `entity/` =
  tb_entity + `entity-fiscal.ts` de composição + barrel `@shared/entity`). O repository do
  concreto só abre a transação, chama `saveEntityFiscalChain(conn, id|null, input, updatedBy)`
  (Fase 3: devolve `{id, reused}` — REUSA a entity pelo CPF/CNPJ; o app nunca manda
  entityId), trata o 409 de papel duplicado (id em fields[0] — modelo customers) e cuida
  da PRÓPRIA tabela. Guia completo: skill `setes-app/skills/cadastro-entidade-fiscal.md`.
- DECIMAL vira number (`decimalNumbers: true` no pool — nunca remover)
- DDL nova? ANTES: `Infra-IA/database/PADROES_BANCO.md` + skill revisar-ddl
- **GET de lista SEMPRE paginado** (2026-08-03 —
  `Infra-IA/prompts/prompt_paginacao_telas_pesquisa.md`, D1–D10; molde =
  `customers`): repository recebe `query: ListQuery` (`@shared/list`) e devolve
  `PagedRows<Row>` — const `where` COMPARTILHADA entre o SELECT da página
  (`LIMIT ? OFFSET ?`) e o `SELECT COUNT(*)` irmão (mesmo escopo/filtro por
  construção — D2); ORDER BY estável com desempate por id (D8); NUNCA `LIMIT`
  fixo no SQL. Controller: `const query = await parseListQuery(req, '<modulo>')`
  (o 2º argumento resolve o default de pageSize pela config `page_size` do
  usuário — D4) + `res.json(pagedEnvelope(query, ...))` →
  `{ ok, data, page, pageSize, total }` (D3). Swagger declara `page`/`pageSize`.
  A interface nova entra no seed `sql/22_page_size_config_seed.sql`.
  Exceções (D6): lookups de apoio (LIMIT fixo pequeno) e árvores
  (categories/financial-plans); relatórios com totais (ex.: extrato) não paginam.
  Lista com HAVING sobre alias calculado: COUNT via subquery (molde
  `settlements.listBills`).
- **TEMPO** (2026-09-30 — `database/PADROES_BANCO.md` §10): data de negócio SÓ por `todayFor(schema,
  institution, conn)` (em transação, a conexão dela — nunca 2ª conexão do pool); zero `CURDATE()`/`new Date()`
  como dia (a cerca `time-zone-fence.test.ts` reprova); **laço longo** (lote, rotina, fila) envolve CADA item em
  `runWithOperationClock(new Date(), …)`; guarda contra banco/fisco passa o agora real (`todayFor(…, new Date())`);
  instante com hora sai para o app por `withZoneWall` na fronteira HTTP.
- **PESQUISA AVANÇADA na lista** (2026-09-30 — `Infra-IA/prompts/prompt_pesquisa_avancada.md`,
  D-BA1…D-BA15; molde = `customers` e `service-orders`): lista nova nasce com a
  LISTA BRANCA de critérios `export const <M>_SEARCH_CRITERIA: readonly SearchCriterion[]`
  no `<m>.repository.ts` (o SQL mora com quem é dono do SQL; o módulo fornece só a
  EXPRESSÃO — o operador é da peça pelo `kind`); critério sobre outra tabela =
  SUBSELECT/EXISTS correlacionado que carrega `tb_institution_id` + `deleted='N'` do
  alvo (NUNCA JOIN novo — duplicaria o COUNT); `options` reusa a constante do domínio
  do dto; `labelKey` = `search.<modulo>.<key>`; `lookup` = caminho do PRÓPRIO módulo.
  Repository anexa `${query.criteria.sql}` à `where` e `...query.criteria.params` aos
  params (depois do escopo). Controller: `parseListQuery(req, '<modulo>', <M>_SEARCH_CRITERIA)`
  + `GET /<m>/search-criteria` → `publicCriteria(...)` (expressão nunca sai), registrada
  ANTES de `/:id`. Swagger declara `criteria`. Índice revisado por critério (D-BA11).
  **Onda 2 (2026-10-03, parecer do guardião — §12.6 do prompt)**: o ESCOPO (schema, institution,
  vínculo em foco) vive na QUERY BASE; o critério referencia ALIAS da base ou tabela de
  `setes_central` — a expressão NUNCA carrega `?` nem `${schemaName}` (lista branca é `const`,
  nunca função do escopo). Relação 1:1 (vínculo em foco, soma por pai) entra como LEFT JOIN /
  derived table na base — coluna da linha e critério viram a MESMA expressão; relação 1:N só com
  `shape: 'set'` (lookup → `? IN (subselect escopado)`, com teste de escopo). Papel da cadeia de
  entidade usa `entityRoleSearchCriteria(moduleKey, alias)` + `roleStatusSearchCriteria` de
  `@shared/entity` (alias interno com prefixo próprio — `RESERVED_ALIASES`; alias igual ao da base
  casa a tabela inteira). TODA tela tem o critério de NOME/descrição (D-BA21). Lista de apoio de
  critério responde `{ id, name }` (coluna `name` ADITIVA se o lookup já existe para o form).
  Lista branca nova entra em `scripts/explain-pesquisa-avancada.ts` (cerca M5 — rodar antes de
  dar por pronto) e na matriz `search-criteria-onda2.test.ts`.
  **Catálogo servido = catálogo aceito**: se o `/search-criteria` filtra por escopo (carteira, Super,
  foco), a LISTA compila contra a MESMA lista filtrada (`<m>SearchCriteriaFor(scope)`) — chave não servida
  = 400. Id opcional na query string (`?stateId=`, `?institutionId=`) SEMPRE por `parseOptionalQueryId`
  de `@shared/http/controller-utils` (nunca `Number(req.query.x)` — NaN no SQL = 500).
  **Onda 3 (2026-10-04)**: módulo com MAIS de uma lista publica um catálogo POR LISTA
  (`/<m>/<lista>/search-criteria`, lookups sob `/<m>/<lista>/…`, labelKey `search.<m>-<lista>.*`).
  Cálculo com peça dona (saldo do título) entra no critério pela forma SOBRE ALIAS da peça
  (`OPEN_BALANCE_OF('f','pp')` + `PRINCIPAL_PAID_JOIN_SQL` na query base) — nunca fórmula própria,
  nunca a forma correlacionada com `${schema}` dentro da lista branca.

## Passo 5 — Validar

```bash
npx tsc --noEmit                                # limpo
# API em npm run dev (tsx watch) recarrega sozinha:
curl http://localhost:3000/health               # boot ok
curl http://localhost:3000/api/<plural>         # 401 sem JWT = rota viva
# Swagger: conferir que as rotas novas aparecem em http://localhost:3000/docs
```

⚠️ **Swagger só enxerga arquivos dos globs `apis`** em
`src/shared/swagger/swagger-config.ts` (`src/modules/**/*.routes.ts` e
`src/modules/sync/endpoints/*.ts` já cobertos — lição de 2026-07-12, quando 43
rotas documentadas ficaram invisíveis no /docs). Doc `@swagger` SEMPRE no
`<m>.routes.ts`; rota em arquivo fora do padrão → adicionar o glob.

## Checklist de saída

- [ ] 6 arquivos no padrão; nomes de pasta idênticos ao módulo do app
- [ ] Código: digitado+409 OU MAX+1 (decisão registrada no comentário do service)
- [ ] Envelope `{ ok, data }`; alias SQL camelCase; soft delete deleted='S'
- [ ] Swagger em todas as rotas (tag = módulo; security BearerAuth; responses
      200/201/400/401/403/500) e rotas VISÍVEIS em /docs; montado em /api/<plural> com o guard certo
- [ ] tsc limpo + smoke; módulo gêmeo no app criado/atualizado
- [ ] Tabela ID LOCAL do MAPA_INDEXACAO (o legado alimenta)? → `catalogOwnerGuard` + `LEGACY_OWNED_TABLES`/`LEGACY_OWNED_MODULES` + 409 `CATALOG_LEGACY_OWNED` no Swagger (Passo 3)
- [ ] Interface + privilégios no seed (seção abaixo) — aplicado ANTES do app

## Interface e privilégios (OBRIGATÓRIO em toda tela nova — D-GE19 + D-PV1…D-PV9, 2026-10-18)

Prompt: `Infra-IA/prompts/prompt_privilegios_interfaces.md`. Valdo (D-GE19): *"para cada tela desenvolvido devemos criar um registro com
os devidos priviegios"*.

1. **Toda tela nasce com o registro em `setes_central.tb_interface`** (seed com `i18n_key` = nome do módulo, `group_default`, `kind` 'T'
   tela / 'R' recurso) **e os seus privilégios em `tb_interface_has_privilege`, no MESMO seed**. Vale para TODA tela — inclusive as do
   grupo Super e as kind 'R' (D-PV3/D-PV4).
2. **Quais privilégios = o que a tela FAZ** (D-PV1), no catálogo existente (`@shared/auth/privileges`): VISUALIZAR (6) sempre — é o que
   põe a tela no menu do usuário regular; INSERIR (1) se cria, ALTERAR (2) se altera, EXCLUIR (3) se exclui, IMPRIMIR (4) se imprime; e cada
   privilégio de AÇÃO que a rota ou o botão exige (FATURAR 5, CANCELAR 7, DESCONTO 8, TRANSMITIR 9). Privilégio NOVO no `tb_privilege` só
   quando um ato precisa de autoridade diferente (como o DESCONTO) — e passa pelo guardião.
3. **Seed por `i18n_key`, nunca por id fixo de interface** (lição do seed 40v1: o `INSERT IGNORE` silenciou a colisão), no molde dos
   seeds `sql/51`…`sql/59`, com **conferência no fim** (pares esperados que faltam = 0).
4. **O seed vai ANTES do app**: os botões do admin e do super vêm do CATÁLOGO da interface (`core.service.ts` — `getAllInterfacePrivileges`);
   par que falta no catálogo esconde o botão até do admin (defeito C1: "trocar cobrança" ficou invisível de 2026-09-13 a 2026-10-18).
5. **Todo par que o código consome** (`requirePrivilege`/`requirePrivilegeFor` na rota, `userHasPrivilege` numa política de controller,
   `requireBranchPrivilege`/`passScope` na nfse-api, `CurrentInterface.can('X')` no app) entra na lista única da D-PV9
   (`src/shared/auth/privilege-catalog.ts` — `CONSUMED_PRIVILEGES`, com os consumidores exatos). A CERCA
   (`src/__tests__/privilege-catalog-fence.test.ts`) reprova par consumido fora da lista, entrada que nenhum código consome mais e consumo
   ilegível (interface/privilégio que não dá para ler estaticamente — resolvido pelo ESCOPO, nunca pelo nome solto); o teste AO VIVO
   (`privilege-catalog-live.test.ts`, só leitura) reprova se o par não estiver no catálogo do banco; o BOOT confere de novo e grita
   `[ALARME D-PV9]` no log (sobe assim mesmo) — `scripts/check-privilege-catalog.ts` faz a mesma conferência fora do boot (sai 1 com
   alarme). Guarda nova de consumo DINÂMICO (ex.: privilégio pelo verbo HTTP) = registrar a primitiva em `src/test-setup/privilege-fence.ts`
   (`API_PRIMITIVES`, aceita vários privilégios fixos) com o que ela consome; export novo em `require-privilege.ts` exige classificação
   no teste; `can()` numa peça compartilhada do app = registro `APP_SHARED_CONSUMERS` (telas derivadas do grafo de import; exceção =
   exclusão com motivo). Detalhes: §12 do prompt (entregue em worktree `privilegios-catalogo` em 2026-10-18 — até o merge, só lá).
   **Rodada 5 (D-PV15/D-PV16)**: as telas do Super Interfaces e Privilégios RECUSAM (409) tirar do catálogo um par da lista, criar
   tela do menu sem VISUALIZAR, trocar/repetir a chave que o código usa (a chave só na forma `^[a-z0-9]+(-[a-z0-9]+)*$`) e renomear
   privilégio consumido — então o seed da tela nova é o caminho, não a tela; e o `build-web.ps1` do app PARA a publicação se o
   catálogo do destino não cobre a lista ou se o app consome par fora dela (ordem: seed → setes-api → app).
6. **Super escapa de todas as verificações** (D-PV3) — os privilégios das telas do Super servem aos botões dele e ao dia em que a tela for
   delegada. Alcance sobre a licença (tela não contratada): A-PV1 do prompt, a confirmar.
7. **Guarda POR ROTEADOR (D-PV2 — executada em worktree `privilegios-crud` em 2026-10-18, até o merge só lá; §11 do prompt)**: o módulo
   de tela do cliente monta no gateway com `router.use('/<m>', ...gatedModule('<m>', routes))` — GET → V, POST → I, PUT → A, DELETE → E
   na interface do módulo. Ato que não é CRUD = `privilegeAct(PRIVILEGE_X[, interface])` NA ROTA; leitura de motor sem privilégio =
   `openRoute('motivo')`; POST de criação fica pelo verbo e entra na lista fechada da cerca `privilegios-rotas-d-pv2.test.ts`. Lista de
   apoio de outro cadastro = rota do PRÓPRIO módulo (`/<m>/<y>-lookup`), nunca o app chamando o `/api` vizinho. Regra completa:
   `ARQUITETURA_MODULOS_API.md`, seção "Guarda de privilégio POR ROTEADOR".

- [ ] Seed da interface + privilégios por `i18n_key`, com conferência, aplicado antes do app
- [ ] Todo `requirePrivilege`/`can('X')` novo tem o par no seed E na lista única `CONSUMED_PRIVILEGES` (a cerca da D-PV9 cobra)

## Campos configuráveis (Fase 2 — OBRIGATÓRIO em todo módulo novo, 2026-07-12)

Prompt: `Infra-IA/setes-app/prompt_fase2_campos_configuraveis.md` (22 decisões).

1. **DTO/controller**: valide o body com `parseBody(dto, req, res)` (controller-utils) —
   erro sai `{ error, fields: [{ field, message }] }` (decisão 20). Regras de
   CPF/CNPJ/CEP/fone/máscara: `@shared/validation` (espelho do setes_validators do app).
2. **Obrigatoriedade comercial**: no create/update, ANTES do service:
   `await assertClientRequired(req.institution!, '<modulo>', body)` (@shared/field-config —
   valida só o que o cliente apertou; o técnico é do DTO).
3. **Catálogo**: semeie os campos do módulo: `npm run fields:gen -- --interface <id>
   --tables <t1,t2>` + revisão manual + aplicar. Painel/consumo já existem
   (/api/interface-fields — módulo isento de feature flag, como o core).
4. **Dados sem máscara** (decisão 19): fone/CEP/CPF/CNPJ só dígitos no banco e no DTO.
5. **Duplicidade fiscal** (decisão 21): a cadeia compartilhada já bloqueia (409 por campo);
   verificação antecipada via GET /api/institutions/fiscal-exists.

- [ ] parseBody + assertClientRequired no create/update
- [ ] Catálogo do módulo semeado (fields:gen)

## Configurações do sistema (Framework de Configurações, 2026-07-18)

Prompt: `Infra-IA/setes-app/prompt_framework_configuracoes_sistema.md` (17 decisões).

1. **Config nova** = linha em `setes_central.tb_interface_has_config` (cadastrada
   pela seção "Configurações" da tela de Interfaces — PUT /api/interfaces/:id/configs).
   NUNCA crie flag/coluna avulsa para preferência de cliente. Vendável NÃO é
   config: é interface `kind='R'` gateada pelo contrato.
2. **Enforcement no módulo**: leia o valor efetivo com
   `getConfigContent(scope, '<modulo>', '<name>')` (@shared/interface-config —
   resolução usuário → institution → default, cache TTL). Exemplo real: filtro
   de carteira em customers.service (restrict_customer_to_salesman + isSalesman
   do @shared/session-context).
3. **Fato de sessão novo** (decisão 17): campo em @shared/session-context
   (types + resolver com cache) — ele entra sozinho no bloco `context` do
   login e do /api/core/me. JWT continua identidade mínima; PROIBIDA variável
   global solta.
4. Painel/consumo do cliente já existem (/api/interface-configs — isento de
   feature flag, como o interface-fields).

- [ ] Preferência de comportamento virou config do catálogo (não flag avulsa)
- [ ] Enforcement de config no service/repository (nunca só no app)
