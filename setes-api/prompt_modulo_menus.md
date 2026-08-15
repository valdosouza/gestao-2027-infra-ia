# Prompt — Módulo de Menus do Cliente (CRUD de tb_module / camada 2 do menu)

**Status**: FECHADO e EXECUTADO em 2026-08-04 (Rodada 1 D1–D4 em bloco pelo Valdo;
gates socrático 0.78 + adversarial 0.84 com correções aplicadas; API 193/193,
app analyze limpo + testes verdes). Entrega: migration 023 nos 2 schemas dev,
módulos gêmeos `modules` (API adminGuard+flag × app lista+form com vínculo
ordenável), assertSchema CENTRALIZADO em @shared/db/schema, getMenus por
position + icon string, seed sql/26 aplicado, fábrica ganhou
hint/trailingBuilder/deleteConfirmMessage, util materialIconByName.
Rodada FECHADA em 2026-08-15: Q5 decidida (alternativa c) e Q6 encerrada sem
objeto (não existe app publicado). Ver abaixo.
**Escopo**: setes
**Origem**: `Infra-IA/setes-api/06-SUGESTAO-CRUD-MODULOS-MENU.md` (cross-knowledge
do projeto VGR, 2026-08-03) + "pode seguir com o módulo de menus" (Valdo, 2026-08-04)
**Método**: `Infra-IA/skills-genericas/refinar-prompt-arquitetura.md`
**Referência pronta**: `D:\ProjetoVGR\api\src\modules\system-modules\` (padrão 6
arquivos com sync transacional de vínculos ordenados) + `core.service.ts` do VGR

---

## Contexto

O menu do setes tem duas camadas. A camada 1 (cadastro de interfaces +
privilégios + contrato) está completa. A camada 2 — módulos personalizados
pelo CLIENTE (`tb_module` + `tb_module_has_interface`, no schema do cliente)
— é SÓ LEITURA: o `getMenus` já monta módulos administrados primeiro e agrupa
as sobras por `group_default`, mas não existe endpoint de escrita nem tela.
Personalizar o menu hoje = INSERT manual no schema do cliente.

Estado real verificado (2026-08-04):
- `tb_module` (sql/03): id, description, `link_name` NOT NULL (legado, nunca
  lido pelo menu), `image_icon` INT (lido pelo getMenus como moduleIcon),
  timestamps, deleted. **SEM coluna de ordem.**
- `tb_module_has_interface`: PK (module, interface), active, deleted.
  **SEM coluna de ordem.**
- `getModuleInterfaces` ordena por `m.description, i.description` (alfabético
  — sem ordem gerenciada); o ramo roda em produção quase sempre vazio.
- Chave i18n `menu.interfaces.modules` já existe no pt/en esperando a tela.
- `assertSchema` (regex de schema) está quadruplicada na API — centralizar
  na entrega (housekeeping aprovado na sugestão 06).

## Objetivos

1. CRUD de módulos de menu no padrão simétrico (API 6 arquivos × módulo
   flutter), escopado pelo schema do JWT.
2. Vínculo ORDENADO de interfaces (a ordem do array do PUT é a ordem do
   menu — padrão VGR: position por linha, sync transacional com
   revoga-o-que-saiu + upsert com `ON DUPLICATE KEY UPDATE deleted='N'`).
3. Ordem dos próprios módulos no menu vertical (position no tb_module).
4. Validações: interface vinculada precisa estar CONTRATADA
   (tb_institution_has_interface viva), kind='T' e fora do grupo Super → 422.
5. Exclusão graciosa: deletar módulo soft-deleta vínculos; as telas VOLTAM
   ao agrupamento por group_default (comportamento que o getMenus já tem).
6. `getMenus` passa a ordenar por position (módulos e interfaces).
7. Centralizar `assertSchema` em peça shared (fim da quadruplicação).
8. Interface nova no catálogo (grupo Sistema) + seed; lista nasce paginada
   (regra da casa) se a tela tiver lista de pesquisa.

## DDL prevista (migration 023 + sql/03 canônico)

- `tb_module`: + `position INT DEFAULT NULL`; destino de `link_name` e
  `image_icon` = Questão 4.
- `tb_module_has_interface`: + `position INT DEFAULT NULL`.

## Decisões arquiteturais registradas (Rodada 1 — Valdo, 2026-08-04)

1. **D1 — Módulo `modules`**: /api/modules ↔ /home/modules, pasta `modules`
   nos dois lados; usa a chave i18n `menu.interfaces.modules` existente.
2. **D2 — adminGuard**: super OU admin do cliente (molde users) — personalizar
   o menu é ação administrativa; escopo = schema do JWT.
3. **D3 — Tela lista+form com vínculo ORDENÁVEL**: form da fábrica com lista
   de interfaces vinculadas (subir/descer) + lookup das contratadas para
   adicionar; a ordem do array do PUT é a ordem do menu.
4. **D4 — Legado do tb_module fora**: migration dropa `link_name` e converte
   `image_icon` INT → `VARCHAR(50)` com nome de ícone Material (app renderiza
   pelo nome; regra "sem legado no sistema").

## Gates da entrega (2026-08-04)

- **Socrático 0.78 ✅**; correções aplicadas na entrega: PUT valida existência
  DENTRO da transação (`WHERE deleted='N'` + affectedRows → 404 — mata a
  ressurreição de vínculos no cruzamento PUT×DELETE), `getUngroupedInterfaces`
  ignora vínculos de módulo morto (tela nunca some dos dois ramos do menu),
  migration 023 anula `image_icon` puramente numérico (nunca é nome Material).
- **Adversarial 0.84 ✅ (sem HIGH/CRITICAL)**; fechos aplicados: teto INT no
  `position` (1e21 dava 500 técnico), `interfaceIds.max(200)`, DELETE na MESMA
  ordem de locks do PUT (janela de deadlock fechada). Registrados como LATENTES
  (inalcançáveis hoje): GROUP_CONCAT >180 vínculos trunca (catálogo tem ~26);
  gap lock do MAX+1 em tabela VAZIA pode dar ER_DUP_ENTRY→500 (retry resolve;
  padrão da casa); TOCTOU contrato revogado entre check e commit (sem exposição
  no menu — getMenus refiltra).

## ⚠️ Questões para rodada do Valdo (dos gates — não decididas)

**Q5 — Vínculo que ficou INELEGÍVEL depois de criado** — ✅ **DECIDIDA E
EXECUTADA (Valdo, 2026-08-15): alternativa (c) — 422 só para ids NOVOS.**
A elegibilidade barra o que o ADMIN faz, não o que o Super fez pelas costas
dele. `assertEligible` recebe os vínculos ATUAIS do módulo (`getModule` já
devolve `interfaceIds`) e só checa o que não estava lá; o id herdado é
preservado com sua position. POST não herda nada (módulo novo checa tudo).
Por que não (b) — dropar em silêncio: o vínculo sobrevivente faz a
**recontratação** devolver a tela ao módulo certo sozinha (o `NOT EXISTS`
de `getUngroupedInterfaces` enxerga o vínculo vivo); dropado, o admin teria
que remontar o menu na mão. Sem risco de exposição: `getMenus` faz INNER
JOIN com `tb_institution_has_interface` ativa — tela não contratada nunca
aparece no menu, mesmo com o vínculo vivo.
No app, a linha órfã deixou de ser um número solto: `moduleInterfaceLabel`
cai em `register.module.screenUnavailable` ("Tela não contratada (#id)").
3 testes novos (17 no modules.test.ts).

**Q6 — Sincronia de implantação app × API** — ❌ **ENCERRADA SEM OBJETO
(Valdo, 2026-08-15): não existe app publicado.** A pergunta pressupunha um
consumidor do contrato antigo em campo; o setes-app nunca foi implantado
(projeto novo), o único consumidor de `/api/core/menus` é este repo — já
atualizado e tolerante — e o Sincronizador não passa por aqui (grupo do
setes-sync, D1). Confirmado no banco: `setes_setes` já tem `image_icon`
`varchar(50)` e ZERO módulos, então `icon` nunca saiu como string.
(`setes_ws` não é schema de cliente deste projeto.)
📌 Nota para quando houver 1ª implantação do app: a incompatibilidade era
ASSIMÉTRICA — app novo tolera int, app antigo faz `icon as num?` e o cast
derruba o menu INTEIRO. Bundle web fica em cache do navegador, então
mudança de contrato quer guardrail de versão (app compara versão da API e
força reload) — frente própria, fora deste módulo.

## Questões pendentes

**Nenhuma.** Q5 decidida (alternativa c) e Q6 encerrada sem objeto, ambas
em 2026-08-15.

## Fora de escopo desta fase

- Reordenação de grupos default (group_default é do catálogo central/Super)
- Menu por USUÁRIO (personalização individual) — camada não existe no modelo

## Critérios de sucesso (rascunho — fecham com as decisões)

1. Admin cria módulo "Financeiro X" com 3 telas ordenadas → menu do
   institution reflete ordem imediatamente; demais telas seguem nos grupos.
2. Deletar o módulo devolve as telas ao group_default sem órfãos.
3. Interface não contratada/Super/kind 'R' no vínculo → 422.
4. tsc + testes verdes; analyze limpo; Swagger visível; gates da casa.
