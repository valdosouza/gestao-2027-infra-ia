# Sugestão — CRUD de Módulos de Menu (tb_module)

**Data**: 2026-08-03 · **Origem**: cross-knowledge do projeto VGR
(`D:\ProjetoVGR`, Fase 1 dos controles administrativos) · **Status**:
✅ EXECUTADA em 2026-08-04 — virou o prompt fechado `prompt_modulo_menus.md`
(D1–D4 do Valdo) e foi implementada nos dois lados (módulos `modules`,
migration 023, seed sql/26). Este arquivo permanece como registro da origem.

---

## O gap identificado

O menu do setes tem duas camadas, e a segunda está pela metade:

**Camada 1 — cadastro de interfaces (completa).** Cada interface tem
`group_default` (módulo inicial padronizado pela Setes), privilégios via
`tb_interface_has_privilege`, e a concessão `tb_user_has_privilege` controla a
permissão. O `GET /api/core/menus` agrupa por `group_default`. Funciona 100%.

**Camada 2 — módulos personalizados pelo cliente (só leitura).** O DDL do
schema do cliente criou `tb_module` e `tb_module_has_interface` com intenção
declarada no seed (`06_setes_central_seed_fase1.sql`): *"criados pelo próprio
cliente no módulo Sistema"*. O `core.repository.ts` **lê** essas tabelas ao
montar o menu — mas o endpoint de escrita e a tela nunca foram implementados.
Não existe `/api/modules` nem pasta `modules/modules` no app web (a chave de
tradução `menu.interfaces.modules` até existe em `pt.json`, esperando a tela).

## Problemas que isso causa hoje

1. **Personalizar o menu exige editar o schema do cliente na mão** — INSERT
   direto em `tb_module`/`tb_module_has_interface`, sem validação, sem
   auditoria, sem tela. Com schema-por-cliente, N clientes = N schemas para
   editar manualmente.
2. **Caminho de código morto-vivo**: o ramo do `getMenus` que faz JOIN com
   `tb_module` roda em produção quase sempre sem dados — código pouco
   exercitado, onde bug dorme.
3. **`group_default` é do catálogo central**: reorganizar um grupo no cadastro
   de interfaces reorganiza o menu de TODOS os clientes ao mesmo tempo, e o
   cliente não tem válvula de escape gerenciada.
4. **i18n sem contrato**: módulo inserido na mão tem `description` livre, fora
   da cadeia `menu.groups.<key>`.

## A referência pronta no VGR

O VGR implementou exatamente essa metade que falta, com a mesma sistemática
(o cadastro de interfaces continua dono do menu; o módulo é camada opcional
por cima):

- **API**: `D:\ProjetoVGR\api\src\modules\system-modules\` — padrão 6 arquivos,
  `GET/POST/PUT/DELETE /api/system-modules`, com:
  - vínculo ordenado de interfaces (`position` por linha na
    `tb_module_has_interface`; a ordem do array do PUT é a ordem do menu);
  - sincronização transacional (revoga o que saiu, upsert do que entrou —
    `ON DUPLICATE KEY UPDATE deleted='N'`);
  - validação de que as interfaces existem (422);
  - exclusão graciosa: deletar módulo soft-deleta os vínculos e as telas
    **voltam ao `group_default`** — nada fica órfão.
- **Montagem do menu**: `D:\ProjetoVGR\api\src\modules\core\core.service.ts`
  (`getMenus`) — módulos administrados primeiro, sobras agrupadas por
  `group_default` como pseudo-módulos (`id: null`). Testes em
  `core\__tests__\core.service.spec.ts`.

## Adaptações necessárias para portar ao setes

| Diferença | VGR | Ajuste no setes |
|---|---|---|
| Tenancy | single-schema | escopar queries por `schemaName` do JWT (regex `assertSchema` — e aproveitar para centralizar a função hoje quadruplicada) |
| Convenção de id | AUTO_INCREMENT | `tb_module.id` no setes é MAX+1 decidido pela app — manter a convenção da casa |
| Guard | `requirePrivilege('system_modules')` | privilégio de tela via menu (padrão setes) ou guard de módulo, a decidir |
| Tela | Fase 4 do VGR (pendente) | módulo flutter `modules/system_modules` no `apps/web`, molde `SetesTreeView` (árvore módulo→interfaces) — a chave i18n `menu.interfaces.modules` já existe |
| Interface no catálogo | seed 019 do VGR | cadastrar a interface "Módulos" em `tb_interface` (grupo Sistema) + privilégios |

## Benefício

Fecha a intenção original da fase 1 do setes: o cliente organiza o próprio
menu por uma tela administrada, auditável e traduzível — e a edição manual de
schema deixa de existir como via de personalização.
