# Prompt — Indexação de Usuários do Firebird (TB_PEDIDO.PED_CODUSU → tb_order.tb_user_id)

**Escopo**: setes
**Origem**: rascunho `Tratamentos de usuario dos firebird.txt` (Valdo, 2026-07-26) + varredura de código 2026-07-26
**Status**: FECHADO na Rodada 1 (2026-07-26) — 8 decisões registradas, questões zeradas; EXECUTADO no mesmo dia (setes-sync + Delphi; aguarda compilação do Valdo)
**Regras-mãe**: D1–D24 de `prompt_revisao_sincronizador_setes_sync.md` (D3: nunca código local; D4: UUID p/ sem-documento) + `MAPA_INDEXACAO.md` + `CONTRATOS_SYNC.md` + precedentes da revisão de entidades (2026-07-25: write-back por classe, EXTERNALCODE por tabela)
**Resolve**: pendência nº 1 da Rodada 4 do `MAPA_INDEXACAO.md` (fallback do tb_user_id)

---

## Contexto

- Delphi: `TB_PEDIDO.PED_CODUSU` → `TB_USUARIO.USU_CODIGO` (login simples `USU_LOGIN`, sem e-mail como identidade)
- Web: `tb_order.tb_user_id` NOT NULL, FK → `setes_central.tb_user`
- Na web, **usuário É entity**: `tb_user.id` = `tb_entity.id` (PK compartilhada, "tb_user controla SOMENTE autenticação", senha + activation_key; login por e-mail)
- `TB_COLABORADOR.CLB_CODUSU` liga colaborador → usuário (nem todo usuário tem colaborador; nem todo colaborador tem usuário)
- `TB_USUARIO` tem `USU_NOME`, `USU_ATIVO`, `USU_LEVEL` e campos de e-mail/SMTP (dados de operação, não identidade — não viajam, decisão 3)

### Circunstâncias do rascunho (mapeadas)

| # | Circunstância | Caminho de indexação |
|---|---|---|
| 1 | Colaborador vinculado ao usuário, com CPF/CNPJ válido | **DOCUMENTO** — mesma entity do colaborador (motor `sync.entity.ts`) |
| 2 | Colaborador sem usuário vinculado | Não assina pedido (PED_CODUSU sempre aponta para TB_USUARIO) — segue só o fluxo /salesman; nada a fazer aqui |
| 3 | Usuário sem colaborador (pode ser ex-funcionário) | **UUID** — `TB_USUARIO.EXTERNALCODE` próprio (bootstrap cria a coluna; write-back por classe) |
| 3b | Usuário COM colaborador, mas colaborador SEM documento válido | **REUSA** `TB_COLABORADOR.EXTERNALCODE` (mesma pessoa = mesma entity); vazio → segura o envio até o /salesman rodar (auto-heal) |

## Workflow implementado

### A. Nova frente de sincronia: Usuário

1. Classe `TUserSendWeb` (TB_USUARIO, seed Seq 39, trigger `TG_SRC_USUARIO` via bootstrap) — roda SÓ no servidor (perfil PDV desliga a Seq 39 — decisão 8)
2. Cascata de indexação no Delphi (decisão 2): colaborador com doc válido → `personType F/J` + documento; colaborador sem doc → `TB_COLABORADOR.EXTERNALCODE` (vazio = não envia neste ciclo); sem colaborador → `TB_USUARIO.EXTERNALCODE` (vazio no 1º ciclo → API cria e devolve → write-back)
3. Endpoint `/user/sincronize`: cadeia pelo motor + `tb_user` SEM credencial (`password NULL`, `active='N'`) criado só se não existe (decisão 1/4) + vínculo `tb_institution_has_user` com `kind='SYNC'` e `active` = USU_ATIVO (decisões 3/7)

### B. Movimentos identificam o autor (decisões 5/6)

4. Bloco opcional `user` (`{userDocument}` OU `{userExternalCode}`) nos 5 endpoints: order-sale, order-purchase, order-stock-adjust, cashier, financial-statement
5. Bloco presente → resolve (`sync.user.ts`) → 409 `USER_NOT_SYNCED` se usuário ainda não sincronizado (auto-heal); ausente → fallback de transição (pedidos: usuário mais antigo; caixa: NULL; extrato: 0)
6. `tb_user_id`/`tb_user_id` entram no `ON DUPLICATE KEY UPDATE` **somente quando o bloco veio** — reenvio corrige o autor dos registros gravados com fallback, e o fallback nunca sobrescreve um autor real

## Decisões arquiteturais registradas (Valdo, 2026-07-26 — Rodada 1)

1. **(Q1) Autor legado = tb_user SEM credencial**: `/user/sincronize` cria a linha em `tb_user` com `password NULL`, `active='N'` (nunca loga). Zero DDL — coerente com o modelo (activation_key já prevê usuário criado antes de ativar). Se a pessoa um dia virar usuária web real, é a MESMA entity/linha — só ganha senha pelo fluxo admin normal. Credencial NUNCA nasce do sync.
2. **(Q2) Cascata de indexação confirmada**: documento do colaborador → externalCode do colaborador (reuso — impede a mesma pessoa de virar duas entities) → externalCode próprio do TB_USUARIO. Colaborador sem doc e sem externalCode = segura o envio (auto-heal via /salesman).
3. **(Q3) Contrato mínimo + origem marcada**: payload sem e-mail/level/SMTP (USU_USU_EMAIL não é identidade; e-mail na web é credencial). `tb_institution_has_user.kind='SYNC'` marca a origem; exibição/filtro na tela de usuários é mudança de app → fase própria (D1).
4. **(Q4) Não-invasão da credencial**: entity que JÁ é usuária web real → sync não toca `password/active/activation_key`; e `active/deleted` do vínculo só são atualizados quando o vínculo nasceu do sync (`kind='SYNC'`). Cadastro (nome etc.) segue last-write-wins normal.
5. **(Q5) Fallback de transição mantido**: bloco `user` ausente (executável antigo/PDV sem doc) → comportamento anterior. Morte do fallback = item da Rodada 4, quando todos os clientes estiverem no executável novo.
6. **(Q6) Escopo estendido — todos os movimentos**: caixa (`tb_user_id`) e movimento financeiro (`tb_user_id`) ganharam o bloco `user` nesta mesma frente ("importante identificar o usuário de cada operação").
7. **(Q7) Ex-funcionários sincronizam**: o histórico precisa deles. `USU_ATIVO` → `active` do VÍNCULO institution×user; deleted do legado → `deleted='S'` no VÍNCULO (nunca na entity/tb_user).
8. **(Q8) PDV só resolve por DOCUMENTO**: `EXTERNALCODE` não é replicado pela retaguarda do Gestao2016 → no PDV (`GbTerminal <> 0`) a cascata só usa o CPF do colaborador (dado replicado); sem doc → sem bloco → fallback (decisão 5). Limitação aceita e REGISTRADA NA MEMÓRIA do projeto: **revisar replicação/sincronia na retaguarda** (memória `retaguarda-replicacao-externalcode`).

## Entregáveis EXECUTADOS (2026-07-26 — mesmo dia do fechamento)

| Entregável | Decisão | Onde |
|---|---|---|
| Peça `sync.user.ts` (userRefBody + resolveUserId 409 USER_NOT_SYNCED + resolveFallbackUserId deduplicado) | 1/5 | `setes-sync/src/modules/sync/sync.user.ts` |
| Endpoint `/user/sincronize` (cadeia + tb_user fantasma + vínculo kind='SYNC') + rota + @swagger | 1/3/4/7 | `setes-sync/src/modules/sync/endpoints/user.ts` |
| Bloco `user` + tb_user_id no upsert condicional nos 3 pedidos | 5/6 | `endpoints/ordersale.ts`, `orderpurchase.ts`, `orderstockadjust.ts` |
| Bloco `user` no caixa (tb_user_id) e no extrato (tb_user_id) | 6 | `endpoints/cashier.ts`, `financialstatement.ts` |
| Teste 401 do /user + suíte completa | — | `src/__tests__/integration.test.ts` (20/20 verdes) |
| Bootstrap cria `TB_USUARIO.EXTERNALCODE` + índice; perfil PDV desliga Seq 39 | 1/8 | `sincronizador/un_dm.pas` (EnsureExternalCode / SeedListaSincroniaIfEmpty) |
| `DM.GetUserSyncRef` (cascata + regra PDV) | 2/8 | `sincronizador/un_dm.pas` |
| `TUserSendWeb` (molde salesman; write-back TB_USUARIO/USU_CODIGO) + RegisterClass + seed Seq 39 | 1/2/3 | `classes/user_send_web.pas`, `uMain.pas`, `function/un_sincronia_seed.pas` |
| Bloco `user` nos envios: order_sale/purchase/stock_adjust + cashier + financial_statement | 5/6 | `classes/*_send_web.pas` |
| Docs vivos: MAPA_INDEXACAO (linha 15c + pendência 1 resolvida) + CONTRATOS_SYNC (/user + blocos user) | — | `Infra-IA/setes-sync/` |

**Validação**: `tsc --noEmit` limpo + 20/20 testes verdes na setes-sync. Delphi: aguarda compilação do Valdo.

**⚠️ Banco dev já semeado** (o seed só roda com a TB_LISTA_SINCRONIA vazia) — rodar uma vez no Firebird dev do SERVIDOR:

```sql
INSERT INTO TB_LISTA_SINCRONIA (WAY, DESC_TABELA, KIND, DESC_PROCESS, SEQ, DESC_FIELD, NOTE, SET_ON, CLASS_NAME, END_POINT)
VALUES ('E', 'TB_USUARIO', 'CADASTRO', 'Usuario do sistema (autor das operacoes)', 39,
        'USU_CODIGO', 'Decisoes 1-3 (2026-07-26)', 'S', 'TUserSendWeb', '/user/sincronize');
```

(em PDVs já semeados, a mesma linha entra com `SET_ON='N'`; a coluna `TB_USUARIO.EXTERNALCODE` e a trigger `TG_SRC_USUARIO` nascem sozinhas no próximo start, via bootstrap.)

## Questões pendentes

**Nenhuma** (Rodada 1, 2026-07-26 — todas decididas pelo Valdo).

## Fora de escopo desta frente

- Morte do fallback de transição (Rodada 4 — exige todos os clientes no executável novo)
- Tela/filtro de usuários de origem SYNC no app (D1 — grupo setes-app × setes-api)
- Ativação de credencial de usuário fantasma (fluxo admin normal já existente)
- Replicação do EXTERNALCODE na retaguarda do Gestao2016 (memória `retaguarda-replicacao-externalcode`)
- Sentido web → Firebird (D16); demais pendências da Rodada 4 (tb_invoice × pedido; PK do stock_statement; CC-e)

## Critérios de sucesso

1. Pedido de venda/compra/ajuste sincronizado carrega o autor REAL (entity do usuário do Firebird), não o usuário mais antigo do institution ✅ (bloco `user` + resolveUserId)
2. Usuário-colaborador com CPF → mesma entity nos dois papéis (collaborator + user); sem duplicação ✅ (motor por documento)
3. Usuário sem colaborador e sem doc → externalCode em `TB_USUARIO.EXTERNALCODE`, 2º ciclo atualiza a MESMA entity ✅ (write-back por classe)
4. Usuário fantasma NÃO loga (password NULL, active='N') e usuário web real NUNCA tem credencial tocada pelo sync ✅ (criação condicional + IF kind='SYNC')
5. Reenvio de registro antigo corrige o autor; fallback nunca sobrescreve autor real ✅ (upsert condicional)
6. Nenhum registro encalhado: cascata segura o envio do usuário até o colaborador sincronizar; movimentos sem referência viajam com fallback ✅
7. 20/20 testes verdes + MAPA_INDEXACAO e CONTRATOS_SYNC atualizados no mesmo commit ✅
8. **Pendente da compilação**: smoke do ciclo completo no Firebird dev (usuário com/sem colaborador, pedido reenviado corrigindo autor)
