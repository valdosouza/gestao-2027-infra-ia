# Skill: Novo módulo de cadastro na setes-api (padrão simétrico)

**Status**: Vigente (substituiu o TBD em 2026-07-11)
**Objetivo**: Criar módulo de cadastro na setes-api espelhando o módulo gêmeo do setes-app
**Referência canônica**: `Infra-IA/setes-api/ARQUITETURA_MODULOS_API.md` (LER antes — regras e checklist)
**Modelos prontos**: `src/modules/countries/` (simples, código digitado + 409),
`src/modules/interfaces/` (id MAX+1 + N:N), `src/modules/privileges/` (mínimo, id MAX+1)
**Tempo**: ~20-30 min

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
- DECIMAL vira number (`decimalNumbers: true` no pool — nunca remover)
- DDL nova? ANTES: `Infra-IA/database/PADROES_BANCO.md` + skill revisar-ddl

## Passo 5 — Validar

```bash
npx tsc --noEmit                                # limpo
# API em npm run dev (tsx watch) recarrega sozinha:
curl http://localhost:3000/health               # boot ok
curl http://localhost:3000/api/<plural>         # 401 sem JWT = rota viva
```

## Checklist de saída

- [ ] 6 arquivos no padrão; nomes de pasta idênticos ao módulo do app
- [ ] Código: digitado+409 OU MAX+1 (decisão registrada no comentário do service)
- [ ] Envelope `{ ok, data }`; alias SQL camelCase; soft delete deleted='S'
- [ ] Swagger em todas as rotas (tag = módulo); montado em /api/<plural> com o guard certo
- [ ] tsc limpo + smoke; módulo gêmeo no app criado/atualizado
