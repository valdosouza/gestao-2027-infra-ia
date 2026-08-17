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
