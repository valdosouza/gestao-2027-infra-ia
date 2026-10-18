# Arquitetura de Módulos da API — simetria com o setes-app

**Status**: Vigente (decisão do Valdo, 2026-07-11)
**Espelho no app**: `Infra-IA/setes-app/ARQUITETURA_MODULOS.md` (LER junto)
**Aplicado em**: countries, states, cities, interfaces, privileges (migração do antigo `modules/super`)
**Escopo**: misto

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
Cadeia de entidade fiscal (2026-07-12) — COMPARTILHADA entre os concretos
(Institution/Customer/Provider/Collaborator/Bank), cada objeto na SUA pasta sob `src/shared/`
(SOLID — SRP/ISP, decisão do Valdo): `shared/address/`, `shared/phone/`, `shared/social-media/`,
`shared/fiscal/` (peças independentes — types/dto/repository; escrita transaction-aware
recebendo `conn` + `entityId`) e `shared/entity/` (tb_entity + `entity-fiscal.ts` de COMPOSIÇÃO:
EntityFiscalInput/Full, `entityFiscalBody` sem effects + `withFiscalRefinements` por último,
`saveEntityFiscalChain(conn, id|null, input)`, `getEntityFiscalFull` + `index.ts` barrel —
consumidores da cadeia importam de '@shared/entity'). Direção de dependência: composição →
peças; as peças NUNCA importam entity/. A cadeia opera SEMPRE em setes_central — só a tabela
concreta muda de schema e fica no módulo. Detalhes: skill `setes-app/skills/cadastro-entidade-fiscal.md`.

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
   **GET de lista é PAGINADO por construção** (2026-08-03 —
   `Infra-IA/prompts/prompt_paginacao_telas_pesquisa.md`): envelope
   `{ ok, data, page, pageSize, total }` via `@shared/list`
   (`parseListQuery(req, '<modulo>')` + `pagedEnvelope`); repository com `where`
   compartilhada entre página (`LIMIT ? OFFSET ?`) e COUNT irmão; ORDER BY com
   desempate por id; NUNCA `LIMIT` fixo. Default de pageSize = config
   `page_size` do usuário (seed `sql/22`). Exceções: lookups de apoio, árvores
   e relatórios com totais. Receita completa: skill `novo-modulo.md`.
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
- [ ] Swagger JSDoc em todas as rotas (tag = nome do módulo; security por tipo:
      BearerAuth /api/*, ApiKeyAuth /sync/*, `[]` públicas). ⚠️ swagger-jsdoc só lê
      os globs `apis` de `src/shared/swagger/swagger-config.ts`
      (`src/modules/**/*.routes.ts` + `sync/endpoints/*.ts`) — doc fora deles não
      aparece no /docs. Conferir a rota nova em http://localhost:3000/docs
- [ ] `npx tsc --noEmit` limpo
- [ ] Módulo gêmeo no app com o MESMO nome (ARQUITETURA_MODULOS.md do setes-app)

## Privilégio de AÇÃO: rota × controller (2026-09-13, D-G32 do cancelamento de nota)

Privilégio de ação tem DOIS lugares legítimos — e só dois:

1. **Na ROTA**, com `requirePrivilege(interfaceKey, privilegeId)` ou
   `requirePrivilegeFor(privilegeId, resolver)`, quando a ação INTEIRA depende do privilégio
   (FATURAR, CANCELAR). O guard não lê o corpo além do necessário para resolver a interface.
2. **No CONTROLLER**, como POLÍTICA condicional, quando o privilégio só é exigido para um
   CONTEÚDO do corpo (D-G32: desconto na baixa — sem desconto, ninguém precisa de privilégio).
   A política é uma peça própria do módulo (`<modulo>.<politica>-policy.ts`), chamada depois do
   parse do DTO e antes do repositório, e devolve 403 com `fields[].expected` quando há teto.

Em ambos os casos vale a regra da Q-G29 (Valdo, 2026-09-10): **o privilégio existe na TABELA
(`tb_privilege` + vínculo `tb_interface_has_privilege` — seed), é OPÇÃO na TELA (o cadastro de
privilégios do usuário só oferece o que a interface tem) e o CÓDIGO valida pela interface do
RAMO**. Admin e super passam sempre. Teto configurável vive no Framework de Configurações
(scope I), nunca hard-coded.

**Toda tela nasce com interface + privilégios no seed** (D-GE19 + D-PV1…D-PV9, 2026-10-18 —
`Infra-IA/prompts/prompt_privilegios_interfaces.md`; passo a passo na skill `skills/novo-modulo.md`,
seção "Interface e privilégios"): VISUALIZAR + o CRUD do que a tela faz + as ações, inclusive nas telas
do Super e nas kind 'R'; seed por `i18n_key` ANTES do app — os botões do admin e do super vêm do
catálogo, e par faltando esconde o botão até do admin. O super escapa de todas as verificações (D-PV3).
Hoje (`main`) a API confere só os de AÇÃO; o CRUD vira guarda por roteador na onda da D-PV2 — abaixo.

## Guarda de privilégio POR ROTEADOR (D-PV2 — onda executada em worktree `privilegios-crud`, 2026-10-18; NÃO publicada)

Detalhe e decisões: `Infra-IA/prompts/prompt_privilegios_interfaces.md` §11. Até o merge, esta seção é a REGRA para módulo novo.

- **Um ponto só**: `src/shared/auth/module-privilege-gate.ts`. Módulo de tela do CLIENTE monta no gateway com
  `router.use('/<m>', ...gatedModule('<m>', routes))` — `<m>` = segmento da URL = `i18n_key` da interface. O VERBO decide:
  GET/HEAD → VISUALIZAR (6) · POST → INSERIR (1) · PUT/PATCH → ALTERAR (2) · DELETE → EXCLUIR (3), na interface do módulo.
- **Ato que não é CRUD** (mapa da D-PV7/D-PV8): marcador NA ROTA — `router.post('/reversal', privilegeAct(PRIVILEGE_EXCLUIR), ...)`;
  outra interface (aba kind 'R'): `privilegeAct(PRIVILEGE_VISUALIZAR, 'partnerships')`; interface pelos parâmetros: `DynamicInterfaces`.
  Rota sem privilégio (só leitura de motor que toda tela consome): `openRoute('motivo')`. Rota SEM marcador vale pelo verbo — esquecer o
  marcador NEGA, nunca libera. POST de criação fica pelo verbo e entra na lista fechada da cerca `privilegios-rotas-d-pv2.test.ts`.
- **Mesma conferência das guardas de ação** (`privilegeVerdict`): licença antes do privilégio (D-F37 — admin e regular só em tela
  CONTRATADA); o super passa as duas (A-PV1 — `licensedFor`); admin passa o privilégio. Interface fora do catálogo nega para todos.
- **Fora da guarda, por NOME**: core, erp, admin, entities, billing/* (guardas de ação pela interface do RAMO), geográficos (leitura
  aberta), roteadores do Super (`superGuard`), users/establishment (perfil admin — D-PV5), modules (`adminGuard` até a onda 0 — D-GE20).
- **Lista de apoio é do PRÓPRIO módulo** (premissa da D-PV2): a tela X nunca lê `/api/<outro>`; precisou do dado de outro cadastro →
  rota `/api/X/<y>-lookup` lendo a peça compartilhada (ex.: `@shared/bank-account`, `@shared/payment-types`). Com a guarda, chamar o
  módulo vizinho exigiria o privilégio da tela vizinha.
- **Tela do Super DELEGÁVEL (D-PV11, 2026-10-18)**: `gatedModule('<m>', routes, { delegatedSuper: true })` — o super passa; usuário da
  Setes (institution 1), **admin inclusive**, só com o privilégio marcado PELO SUPER no cadastro dele; outra institution: a tela não existe;
  sem licença (tela do Super não é vendida). Só chaves de `DELEGABLE_SUPER_INTERFACES` (`@shared/auth/super-delegation` — hoje só
  `institution-interfaces`); a montagem lança com outra. O cadastro de privilégios só oferece/grava essas telas quando quem edita é o super.
- **A Setes é cliente como os outros (D-PV10)**: nenhum atalho por `institutionId === 1` (as flags também não); só o SUPER tem tudo. A
  CONTA de usuário (senha, e-mail, ativo, exclusão — login global) é rotina do admin: ele altera a de todos do próprio estabelecimento,
  MENOS a do super (vínculo super vivo ou adormecido) e a de quem tem vínculo com outro estabelecimento (`assertAccountManageable` —
  D-PV12; o segundo caso é a A-PV13, a ratificar). O usuário liberado pelo Super segue editável pelo admin — não "consertar".
- **Conhecimento negativo**: a guarda acha a rota no `stack` do Router do **Express 4** (`route`, `regexp`, `keys`, `methods`,
  `route.stack[].handle`) — a prova `module-privilege-gate.test.ts` quebra se a forma mudar; sub-roteador (`router.use`) DENTRO de módulo
  guardado é recusado por `listGatedRoutes()` (a guarda não o enxergaria).
**Todo par que o código consome mora na lista única `src/shared/auth/privilege-catalog.ts`** (D-PV9, §12 do prompt): a cerca
`privilege-catalog-fence.test.ts` reprova guarda/política/botão com par fora dela (ou ilegível estaticamente) e o boot confere a lista
contra o catálogo — par faltando = `[ALARME D-PV9]` no log, sem recusar subir.
