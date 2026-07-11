# Arquitetura de Módulos da API — simetria com o setes-app

**Status**: Vigente (decisão do Valdo, 2026-07-11)
**Espelho no app**: `Infra-IA/setes-app/ARQUITETURA_MODULOS.md` (LER junto)
**Aplicado em**: countries, states, cities, interfaces, privileges (migração do antigo `modules/super`)

---

## Regra de ouro: 1 cadastro = 1 módulo, com o MESMO nome nos dois lados

```
setes-api  src/modules/countries/          setes-app  app/modules/countries/
├── countries.interface.ts   ←tipos→       ├── domain/entity/country_entity.dart
├── countries.dto.ts         ←contrato→    ├── (validators do form)
├── countries.repository.ts  ←dados→       ├── data/datasource/
├── countries.service.ts     ←regra→       ├── domain/usecase/
├── countries.controller.ts  ←orquestra→   ├── presentation/bloc/
└── countries.routes.ts      ←plug→        └── countries_module.dart
```

Nomes de pasta no PLURAL e idênticos nos dois projetos (countries, states, cities,
interfaces, privileges...). Ao criar um cadastro novo, criam-se DOIS módulos gêmeos.

## Responsabilidade de cada arquivo (SRP)

| Arquivo | Faz | NUNCA faz |
|---|---|---|
| `<m>.interface.ts` | Tipos Row/Input (shape camelCase que o app consome) | Lógica |
| `<m>.dto.ts` | Schemas Zod de entrada + tipos inferidos | Acesso a banco |
| `<m>.repository.ts` | SQL puro (pool.query) | Regra de negócio, HTTP |
| `<m>.service.ts` | Regra de negócio (404, 409, MAX+1, sincronização N:N) | SQL, req/res |
| `<m>.controller.ts` | HTTP ↔ service: valida DTO, status codes, envelope `{ ok, data }` | SQL, regra |
| `<m>.routes.ts` | Router fino (verbo → controller) + Swagger JSDoc | Handlers inline |

Compartilhados: `shared/http/controller-utils.ts` (handleError, parseId) — todo controller usa.

## "Super" NÃO é módulo — nem em pasta, nem em URL

Igual ao app (módulo de sistema nunca vira pasta): "Super" é só agrupador de MENU.
A URL segue o MÓDULO, não o agrupador (decisão do Valdo, 2026-07-11):
**`/api/<modulo>` espelha `/home/<modulo>` do app** — /api/countries, /api/cities...

O guard é aplicado POR MÓDULO no `gateway/router.ts`:

```ts
router.use('/countries',  superGuard, countriesRoutes)   // → /api/countries
router.use('/states',     superGuard, statesRoutes)      // → /api/states
...
```

`gateway/super.guard.ts` = isSuper (decisão 2026-07-09) — usado pelos cadastros do
catálogo central. Cadastros de cliente futuros recebem guard próprio na mesma
posição (por módulo). Mudar o agrupador no menu NUNCA muda URL nem pasta.

## Padrões que mantêm a consistência a 150+ cadastros

1. **Contrato JSON**: envelope `{ ok, data }`; alias SQL camelCase = nome do campo no
   fromJson do app; DECIMAL vira number (`decimalNumbers: true` no pool — nunca remover).
2. **Códigos**: padrão externo (BACEN/IBGE) → id digitado + 409 (mesmo deleted='S') +
   ER_DUP_ENTRY→409; sem padrão externo → MAX+1 no backend, campo readOnly no app.
   SEMPRE perguntar ao Valdo qual é o caso.
3. **Soft delete universal**: `deleted='S'`, listas e gets filtram `deleted='N'`.
4. **FK para exibição**: LEFT JOIN devolvendo `<pai>Name` (JOIN de banco não é
   acoplamento de módulo). N:N pertence ao módulo que o gerencia (ex.:
   tb_interface_has_privilege vive em interfaces/).
5. **Módulo nunca importa módulo** (mesma regra do app). Precisou em 2+ módulos →
   promove para `shared/`.
6. **Workflow do cadastro novo**: agente `setes-form-builder` cria os DOIS lados;
   checklist no final deste doc.

## Migração realizada (estratégia usada — repetir se surgir outro monolito)

1. Extrair compartilhados (guard, controller-utils) SEM mudar comportamento.
2. Criar módulos novos movendo código VERBATIM (Swagger junto), 1 entidade por vez.
3. Recompor o gateway; `tsc --noEmit` a cada passo. (Na migração real as URLs
   mudaram de /api/super/<m> para /api/<m> na mesma rodada — datasources do app
   atualizados juntos, um replace por módulo.)
4. Deletar o monolito só depois de `grep` confirmar zero referências.
5. Smoke: /health + rota nova sem JWT (401 = cadeia viva); flutter analyze no app.

## Checklist para cadastro novo (lado API)

- [ ] Pasta `src/modules/<plural>/` com os 6 arquivos no padrão acima
- [ ] Montagem no `gateway/router.ts` em `/api/<plural>` com o guard certo por módulo
- [ ] Zod no dto; envelope `{ ok, data }`; alias camelCase; soft delete
- [ ] Swagger JSDoc em todas as rotas (tag = nome do módulo)
- [ ] `npx tsc --noEmit` limpo
- [ ] Módulo gêmeo no app com o MESMO nome (ARQUITETURA_MODULOS.md do setes-app)
