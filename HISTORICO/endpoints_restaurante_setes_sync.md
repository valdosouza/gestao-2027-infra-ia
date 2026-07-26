# [SUPERADO] Endpoints de restaurante da setes-sync (aposentados em 2026-07-19)

**Escopo**: setes
**Decisão**: D23 do `Infra-IA/setes-sync/prompt_revisao_sincronizador_setes_sync.md`

Na Onda 1 da revisão do sincronizador foram removidos de `setes-sync/src/modules/sync/endpoints/`
os 7 endpoints da vertical restaurante/delivery (cardápio), que já estavam FORA do registro de
rotas (`sync.specific.routes.ts`) desde 2026-07-01 — sobravam só os arquivos:

| Arquivo | Sincronizava |
|---|---|
| `restgroup.ts` | Grupo de cardápio (tb_rest_group) |
| `restsubgroup.ts` | Subgrupo (tb_rest_subgroup) |
| `restmenu.ts` | Item de menu (tb_rest_menu) |
| `restmenuhasingrediente.ts` | Ingredientes do item |
| `restgrouphasattribute.ts` | Atributos do grupo |
| `restgrouphasmeasure.ts` | Medidas do grupo |
| `restgrouphasoptional.ts` | Opcionais do grupo |

Se a vertical restaurante voltar um dia, os endpoints devem ser REESCRITOS no padrão da revisão
(reindexação por documento, envelope D14, contratos D22) — o código antigo era pré-Fases 2/3 e
não serve de molde.
