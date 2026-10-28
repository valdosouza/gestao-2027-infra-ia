# Plano de retomada — 2026-10-21 (sucede o de 2026-10-18)

**Escopo**: setes
**Gerado em**: 2026-10-21 (madrugada), a pedido do Valdo: *"salve tudo e prepare um prompt para a retomada do assunto em outra sessão"*.
**Fonte**: a sessão coordenadora de 2026-10-20 (rodada de decisões "uma pergunta por vez" + seis sessões de execução em worktree),
`git status`/`worktree list` de TODOS os repositórios (2026-10-21 ~02:00), as seções de execução escritas por cada sessão nos prompts.
**Natureza**: COORDENAÇÃO. Não decide nada; diz onde cada coisa está, a ordem recomendada e o que depende do Valdo. Sucede
`plano_retomada_2026-10-18.md` (as Fases 0–1 dele estão cumpridas; o que restava dele está reescrito aqui). Quando tudo daqui for cumprido,
os dois vão para `HISTORICO/`.

---

## 0. Em uma tela

| Bloco | Estado em 2026-10-21 | O que falta | Bloqueio |
|---|---|---|---|
| **Decisões** | 92 itens FECHADOS em 2026-10-20 (D-PV19…D-PV47, D-UC6…D-UC12, D-PR45…D-PR52, D-TM8…D-TM22, D-NE160…D-NE168, D-RS1…D-RS6; INDICE 10.35) | **58 itens novos** levantados pelas seis sessões (§3) + Q-IB1 (30/10) | só o Valdo, um por vez (regra `memory/feedback-uma-pergunta-por-vez`) |
| **Recuperação de senha** | D-PV18 REVOGADA (D-PV47): a recuperação VOLTA, endurecida. Branch `recuperacao-senha` (api d19de9d · sql e1aa574) + D-RS4/D-RS5/D-PV46 executados na worktree (19 + 2 arquivos sem commit; §13.10 do prompt de privilégios); `sem-recuperacao-senha` DESCARTADA (worktrees e branches removidas) | commit de salvaguarda → "vai" → sql/67 antes e depois → merge api + sql → SMTP real no `.env` | **credenciais SMTP (Valdo)**; "vai" |
| **Grupo — D-GE4** | branch `grupo-leitores` ff2795f no GitHub, sem merge | "vai" → merge ff | nenhum |
| **Privilégios — lote D-PV19…D-PV40** | EXECUTADO na worktree `privilegios/{setes-api 74, setes-app 54, nfse-api 5, sql 1}` sobre a branch `privilegios-crud`; gates 0,76/0,80; §11.10 | commit de salvaguarda → fusão com `privilegios-catalogo` (D-PV14/D-PV42 — NÃO feita) → script D-PV20 → seeds 65 + 68 → `errors:gen` → janela única API + app + nfse-api (restart manual) | 10 itens do §3 (nenhum trava) |
| **Produtos — Rodada 7** | Rodada 6 REFEITA na worktree `merchandise/{setes-api 53, sql 3}` (branch `merchandise`): `tb_institution.source_kind` W/L/P + `@shared/catalog-owner` + `catalogOwnerGuard` + ato `end-legacy-transition` + rotas fiscais do serviço (D-PR45); gates fechados; "Rodada 7 — execução/gates" | commit de salvaguarda → rebase sobre o `main` pós-privilégios → `taxrules-ncm` junto → janela (migrations 071/072/073 + seed 66) — **condição da janela (Q-PR62): o form de Institutions do app com o seletor W/L/P** → onda 1 do APP | 8 itens do §3; Q-SY24/Q-SY25 (sync, conferência) |
| **Terminal — onda 0** | PREPARADA na worktree `terminal/{setes-api 14, setes-app 8, sql 2}` (branch `terminal` do `main`): migration 074 (`tb_terminal`, `tb_terminal_holder`, DROP `tb_devices`), peça `@shared/terminal`, módulo `terminals` API + app, seed 69; §10 do prompt | commit de salvaguarda → merge DEPOIS de privilégios e produtos → troca dos ~200 literais (D-TM16) → ondas 2/3 no grupo do sync | 12 itens do §3 |
| **NE-2 (nfe-api)** | EXECUTADA nas worktrees `ne2/{fiscal-api 12, nfe-api 12}` (branch `ne2`): E1–E5, 001 provada no descartável; gates 0,76/0,78; §15.9 | commit de salvaguarda → publicação pela D-NE168 (núcleo ff + build + push; 001 no `fiscal_api` do dev) — independente do ERP | 4 itens do §3 (Q-NE170 antes da NE-6) |
| **Densidade — onda C + grade** | EXECUTADA na worktree `densidade-c/setes-app` (69 arquivos; peça `SetesDataList`); testes 27/80/639; gates 0,76/0,80; §9 | commit de salvaguarda → merge no app (ordem com `privilegios-crud`: conflito previsto na fábrica) → `flutter run` :5051 | nenhum item aberto |
| **Convidado — onda 0** | só decisões (D-UC6…D-UC12) | sessão própria DEPOIS da fusão de privilégios (mesmo `users.service.ts`): "minha senha" + código, aceite pelo login, inativação na hora (D-UC9), colunas do vínculo (D-UC10, guardião) | ordem |
| **Grupo — onda 0** | só decisões (D-GE3, D-GE20) | sessão própria DEPOIS do bloco privilégios | ordem |
| **CNPJ alfanumérico** | branch `cnpj` nos 4 repos (GitHub), onda 1 + R3–R5 | rebase + janela | grupo do sync (CHECK) |
| **IBS/CBS** | IB-4 pendente (fisco de H) | prova em H; **Q-IB1 até 30/10** | externo |
| **Endurecer autenticação** | prompt NOVO `prompt_endurecer_autenticacao.md` (Rodada 0 organizada, Q-EA1…Q-EA12) | decisões → onda própria | 12 itens do §3 |

---

## 1. Estado git — repositório a repositório (2026-10-21 ~02:00)

Legenda: ✅ igual ao GitHub · ⚠️ commit só local · ❌ alteração SEM commit (trabalho das sessões de 2026-10-20/21) · ♻ removível.

| Repo / worktree | Branch @ commit | Estado | Ação |
|---|---|---|---|
| `setes-api` (árvore viva = deploy, `tsx watch`) | `main` f53a618 | ✅ limpo | só janelas |
| `privilegios/setes-api` | `privilegios-crud` @ 50b928f | ❌ 74 arquivos (lote D-PV19…D-PV40) | commit de salvaguarda ("commita") |
| `privilegios/setes-app` | `privilegios-crud` @ 5a06d73 | ❌ 54 arquivos | idem (sem `.dart_tool`) |
| `privilegios/nfse-api` | `privilegios-crud` @ b62d55b | ❌ 5 arquivos (CONSULTAR local — Q-PV56) | idem |
| `privilegios/sql` (NOVA) | `privilegios-crud` @ 9f4fcf3 | ❌ `68_privilege_configure_consult_seed.sql` | idem |
| `privilegios-catalogo/{setes-api,setes-app}` | `privilegios-catalogo` 8b1fe27 / 53a1497 | ⚠️ sem push | fusão com `privilegios-crud` (D-PV14/D-PV42) |
| `merchandise/setes-api` | `merchandise` @ 2171f20 | ❌ 53 arquivos (Rodada 7) | commit de salvaguarda |
| `merchandise/sql` | `merchandise` @ 8b8cedf | ❌ 3 arquivos | idem |
| `taxrules-ncm/{setes-api,setes-app}` | `taxrules-ncm` b651354 / ef99e60 | ⚠️ sem push | merge junto da janela de produtos |
| `terminal/{setes-api,setes-app,sql}` (NOVAS) | `terminal` @ f53a618 / a450909 / 9f4fcf3 | ❌ 14 / 8 / 2 arquivos | commit de salvaguarda |
| `recuperacao-senha/setes-api` | `recuperacao-senha` @ d19de9d | ❌ 19 arquivos (D-RS4/D-RS5/D-PV46) | commit de salvaguarda |
| `recuperacao-senha/sql` | `recuperacao-senha` @ e1aa574 | ❌ 2 arquivos (sql/67 com a coluna do aviso) | idem |
| `ne2/fiscal-api` · `ne2/nfe-api` (NOVAS) | `ne2` @ abce0b8 / a9ef9ac | ❌ 12 / 12 arquivos | commit de salvaguarda |
| `ne2/nfse-api` · `ne2/setes-api` | HEAD solto @ `main` | ♻ auxiliares da NE-2 (suíte da nfse-api contra o núcleo novo) | `git worktree remove` na limpeza (junções `node_modules/fiscal-api` → `ne2/fiscal-api`, não ao vivo) |
| `ne2/qa-adv` + logs em `ne2/` | — | artefatos do gate | apagar na limpeza |
| `densidade-c/setes-app` (NOVA) | `densidade-c` @ a450909 | ❌ 69 arquivos | commit de salvaguarda |
| `grupo-leitores/setes-api` | `grupo-leitores` ff2795f | ✅ | "vai" → merge |
| `cnpj/{setes-api,setes-app,fiscal-api,nfse-api}` | `cnpj` | ✅ no GitHub | rebase + janela (sync) |
| `setes-app` (viva) | `main` a450909 | ✅ | — |
| `nfse-api` · `nfe-api` · `fiscal-api` · `sql` (vivos) | `main` 62c5fcf · a9ef9ac · abce0b8 · 9f4fcf3 | ✅ | — |
| `setes-sync` · `sincronizador` | `main` edbaad4 · b6c6ebe | ⚠️ 1 commit à frente, sem push | Fase 4 do plano anterior (grupo do sync) |
| `Infra-IA` | `main` | ❌ 16 arquivos das sessões + este plano | **commit deste salvamento** |

**Banco (dev = "produção" da Setes)**: sql/64 aplicado · 65, 66, 67, 68, 69 NÃO aplicados · migrations 071/072/073 (merchandise) e 074 (terminal) NÃO aplicadas · nenhum
descartável sobrou (conferido); existe um banco `undefined` (anterior, não é das sessões — conferir e apagar). **Serviços**: nenhum no ar
(3000/3002/5051). **MariaDB**: no ar.

---

## 2. Ordem de execução recomendada (cada passo com o "vai")

0. **Commits de salvaguarda** (com "commita"; só os caminhos de cada tarefa; nada vai para `main`): privilegios (4 repos) · merchandise (2) ·
   terminal (3) · recuperacao-senha (2) · ne2 (2) · densidade-c (1). Depois: `git status` limpo em toda worktree (fora `.dart_tool`).
1. **Subir os serviços** (skill `dev-server-orchestrator`): setes-api :3000 (`npm run dev`), nfse-api :3002 (sem watch), app :5051.
2. **Recuperação** — `recuperacao-senha`: SMTP real no `.env` vivo (Valdo) → sql/67 em `setes_central` → merge api + sql → sql/67 de novo →
   boot `Pedido de troca de senha (script 67): ok` → passeio (§13.8 do prompt de privilégios, revisto pelo §13.10).
3. **Grupo** — `grupo-leitores`: merge ff → push.
4. **Bloco privilégios** (sessão própria, depois de 2 e 3): fusão `privilegios-crud` ↔ `privilegios-catalogo` (D-PV14 adaptador
   `listGatedRoutes()` em `CONSUMED_PRIVILEGES`; D-PV42 chave técnica; `error-codes` = soma; Q-PV56 CONSULTAR para o núcleo) → script D-PV20
   (`scripts/sql/dpv20-contrato-setes.sql`) → seeds 65 + 68 → `errors:gen` → janela única API + app (merge sobre a450909 com atenção à fábrica)
   + nfse-api restart. Decidir antes os 10 itens de privilégios do §3 (nenhum trava).
5. **Grupo — onda 0** (sessão própria): D-GE20/A-GE2 (`gatedModule('modules')`), D-GE3 (veredito com institution — o cache da D-PV29 já tem a chave).
6. **Produtos**: rebase `merchandise` sobre o `main` pós-privilégios (conflitos esperados: `router.ts`, `privileges.ts`, `error-codes.ts`) +
   `taxrules-ncm` → onda 1 do APP (sessão própria; inclui o seletor W/L/P no form de Institutions = condição da janela, Q-PR62) → janela
   (071/072/073 no boot, seed 66, trilha P1).
7. **Terminal — onda 0**: merge da `terminal` (migration 074, seed 69) → troca dos literais (D-TM16, sessão própria) → ondas 2/3 no grupo do sync.
8. **Convidado — onda 0** (sessão própria, depois de 4): D-UC8…D-UC12 + D-UC10 (guardião + DDL) + "minha senha" com a peça do código (D-UC7).
9. **Fora da cadeia, a qualquer hora com "vai"**: publicação da NE-2 (D-NE168; roteiro §15.9.4 do prompt da NF-e) · merge da `densidade-c` no app.
10. **Depois da janela de privilégios**: DDLs próprios D-PV33 (trilha `_event` do vínculo), D-PV43 (UNIQUE da `i18n_key`); D-PR59 (colunas do ato);
    regra de tributação por cliente (D-PV30); onda de endurecer a autenticação (após Q-EA1…Q-EA12); limpeza (§1 ♻).

---

## 3. Decisões pendentes do Valdo — 58 itens (uma por vez; onde cada uma mora)

| Bloco | Itens | Onde | Trava? |
|---|---|---|---|
| Privilégios (Rodada 6 da onda) | **Q-PV55** (senha cruzada até a onda 0 do convidado — Rec. a) · Q-PV56 (CONSULTAR para o núcleo — Rec. a) · Q-PV57 (`interface-fields`/`general-configs` no contrato — Rec. a) · Q-PV58 (Módulos para o super sem o grupo Super — Rec. a) · A-PV16…A-PV21 | `prompt_privilegios_interfaces.md` §11.10.4–§11.10.5 | não |
| Produtos (Rodada 7, execução) | Q-PR59 (motivo/autor do ato em colunas — Rec. a) · Q-PR60 (chave no destino P — executado a) · Q-PR61 (destino P recusado até o sync — executado a) · Q-PR62 (form de Institutions = condição da janela — Rec. a) · Q-PR63 · A-PR4…A-PR6 | `prompt_modulo_products.md` "Rodada 7 — execução/gates" | Q-PR62 condiciona a janela |
| NE-2 | Q-NE169 (UNIQUE da prova sem institution — Rec. a) · **Q-NE170** (de onde o ERP lê o AMBIENTE ao cunhar o nNF — Rec. a, ANTES da NE-6) · Q-NE171 (`deleted` nunca na faixa — Rec. a) · Q-NE172 (`sql_mode` estrito no pool do núcleo — transversal) | `prompt_onda_nfe_sefaz.md` §15.9 | Q-NE170 antes da NE-6 |
| Terminal (onda 0) | Q-TM8 (admissão do L literal × derivada) · Q-TM9 (escopo do UNIQUE do L no grupo) · Q-TM10 (nome do header) · Q-TM11 (`POST /:id/restore`) · Q-TM12 (porta das três saídas do L) · Q-TM13 (fechamento "em parte") · Q-TM14 (estruturais auto-curativas) · A-TM6…A-TM10 | `prompt_frente_terminal.md` §10 | não |
| Recuperação (D-RS4/D-RS5/D-PV46) | Q-RS7 (2+ Supers ativos) · Q-RS8 (momento do aviso C) · Q-RS9 (`OPS_ALERT_EMAIL`) · Q-RS10 (+1 sobrevive à falha do aviso) · Q-RS11 (marcador de produção) · Q-RS12 (texto do aviso) · Q-RS13 (fato do reset do Super) · Q-RS14 ("Super ativo") · A-RS5…A-RS12 | `prompt_privilegios_interfaces.md` §13.10 | não |
| Endurecer autenticação | Q-EA1…Q-EA12 (limite por conta, fato da falha, aviso, teto global, política de senha, oráculo "inativo", revogação, TTL do JWT, hash — reservada —, ordem, log forense, `Auth OK`) | `prompt_endurecer_autenticacao.md` | onda própria |
| IBS/CBS | **Q-IB1** regime 2027 — **prazo 30/10/2026** (contador) | `prompt_fase_ibs_cbs.md` | externo |
| Grupo do sync (conferências) | Q-SY24 (upsert de categoria regrava `kind`/`posit_level`?) · Q-SY25 (upsert de serviço preserva `tb_service_tax_rule_id`?) · contrato `SYNC_TRANSITION_ENDED` · patch 12 (terminal) | `prompt_modulo_products.md` / `prompt_frente_terminal.md` | não |

---

## 4. Regras que valem (relembrar ao abrir cada sessão)

- `D:\Gestao2027\setes-api` = `tsx watch` = deploy ao salvar; nfse-api "produção" sem watch; núcleo `fiscal-api` consumido no restart. Nada se
  edita na árvore viva fora de janela decidida. Trabalho = worktree (`<frente>/<repo>`), com `.env` em link físico e `node_modules` em junção —
  **ao remover uma worktree, `rmdir` das junções ANTES** (varrer ReparsePoints até profundidade 2).
- Commit, push, seed, migration, merge só com "vai"/"commita"; `git add` só dos caminhos da tarefa; sessões paralelas nunca escrevem nos mesmos arquivos.
- Banco: só leitura fora de janela; DDL provado antes em schema descartável (apagar ao fim). Fronteira dos grupos (sync × produto).
- Gates em cada delta (socrático ≥ 0,70 + adversarial sem HIGH/CRITICAL); achado que exige decisão = questão numerada.
- Decisões com o Valdo: **UMA por mensagem** (contexto + opções + recomendação), nunca lista; registrar no prompt da frente antes da próxima.
- Ao fechar cada etapa: prompt da frente → `INDICE_CENTRAL.md` → `CLAUDE.md` da raiz → memória (skill `atualizar-infra-ia`).

## 5. Prompt curto para a próxima sessão (colar)

> Retome a coordenação das pendências de setes-api, nfse-api, nfe-api e setes-app pelo `Infra-IA/prompts/plano_retomada_2026-10-21.md`
> (sucede o de 2026-10-18). Comece pelo §0 e pelo §1 (confira `git status`/`worktree list` de todos os repositórios: deve bater com a
> tabela; se bater, nada se perdeu). Ordem: §2 — primeiro os commits de salvaguarda das seis worktrees (com o meu "commita"), depois subir
> os serviços, depois a cadeia de merges. Decisões pendentes: §3 — me traga UMA por mensagem, com contexto e recomendação, começando pela
> Q-PV55; registre cada resposta no prompt da frente antes da próxima. Regras do §4. Não toque na árvore viva do setes-api; nada de
> commit/push/seed/migration/merge sem o meu "vai".
