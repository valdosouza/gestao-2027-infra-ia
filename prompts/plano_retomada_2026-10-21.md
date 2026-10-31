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
| **Recuperação de senha** | D-PV18 REVOGADA (D-PV47): a recuperação VOLTA, endurecida. Branch `recuperacao-senha` (api d19de9d · sql e1aa574) + D-RS4/D-RS5/D-PV46 executados na worktree (19 + 2 arquivos sem commit; §13.10 do prompt de privilégios); `sem-recuperacao-senha` DESCARTADA (worktrees e branches removidas) | ✅ MERGEADA 2026-10-31 (api 9144652 · sql 66fc17c; sql/67 aplicado; boot ok — §2 passo 2) | passeio com o Valdo · ensaio do script do Super · push | Valdo |
| **Grupo — D-GE4** | ✅ PUBLICADA 2026-10-31 (`main` e61f9fe, GitHub — §2 passo 3) | — | — |
| **Privilégios — lote D-PV19…D-PV40** | EXECUTADO na worktree `privilegios/{setes-api 74, setes-app 54, nfse-api 5, sql 1}` sobre a branch `privilegios-crud`; gates 0,76/0,80; §11.10 | commit de salvaguarda → fusão com `privilegios-catalogo` (D-PV14/D-PV42 — NÃO feita) → script D-PV20 → seeds 65 + 68 → `errors:gen` → janela única API + app + nfse-api (restart manual) | 10 itens do §3 (nenhum trava) |
| **Produtos — Rodada 7** | Rodada 6 REFEITA na worktree `merchandise/{setes-api 53, sql 3}` (branch `merchandise`): `tb_institution.source_kind` W/L/P + `@shared/catalog-owner` + `catalogOwnerGuard` + ato `end-legacy-transition` + rotas fiscais do serviço (D-PR45); gates fechados; "Rodada 7 — execução/gates" | commit de salvaguarda → rebase sobre o `main` pós-privilégios → `taxrules-ncm` junto → janela (migrations 071/072/073 + seed 66) — **condição da janela (Q-PR62): o form de Institutions do app com o seletor W/L/P** → onda 1 do APP | 8 itens do §3; Q-SY24/Q-SY25 (sync, conferência) |
| **Terminal — onda 0** | PREPARADA na worktree `terminal/{setes-api 14, setes-app 8, sql 2}` (branch `terminal` do `main`): migration 074 (`tb_terminal`, `tb_terminal_holder`, DROP `tb_devices`), peça `@shared/terminal`, módulo `terminals` API + app, seed 69; §10 do prompt | commit de salvaguarda → merge DEPOIS de privilégios e produtos → troca dos ~200 literais (D-TM16) → ondas 2/3 no grupo do sync | 12 itens do §3 |
| **NE-2 (nfe-api)** | EXECUTADA nas worktrees `ne2/{fiscal-api 12, nfe-api 12}` (branch `ne2`): E1–E5, 001 provada no descartável; gates 0,76/0,78; §15.9 | commit de salvaguarda → publicação pela D-NE168 (núcleo ff + build + push; 001 no `fiscal_api` do dev) — independente do ERP | 4 itens do §3 (Q-NE170 antes da NE-6) |
| **Densidade — onda C + grade** | EXECUTADA na worktree `densidade-c/setes-app` (69 arquivos; peça `SetesDataList`); testes 27/80/639; gates 0,76/0,80; §9 | commit de salvaguarda → merge no app (ordem com `privilegios-crud`: conflito previsto na fábrica) → `flutter run` :5051 | nenhum item aberto |
| **Convidado — onda 0** | só decisões (D-UC6…D-UC12) | sessão própria DEPOIS da fusão de privilégios (mesmo `users.service.ts`): "minha senha" + código, aceite pelo login, inativação na hora (D-UC9), colunas do vínculo (D-UC10, guardião) | ordem |
| **Grupo — onda 0** | só decisões (D-GE3, D-GE20) | sessão própria DEPOIS do bloco privilégios | ordem |
| **CNPJ alfanumérico** | branch `cnpj` nos 4 repos (GitHub), onda 1 + R3–R5 | rebase + janela | grupo do sync (CHECK) |
| **IBS/CBS** | IB-4 pendente (fisco de H); D-IB99 (2026-10-31) — regime vira configuração por estabelecimento | prova em H; **configuração do regime no ar antes de 01/01/2027** (sessão própria, §14 do prompt) | IB-4 externo |
| **auth-api** (2026-10-31) | Rodada 1 FECHADA (`prompt_frente_auth_api.md` — D-AU1…D-AU12) | costura A1 no passo 4 + GRANT da nfse-api na mesma janela → ondas 0 → Q-EA9 → A2 → A3 antes da Onda 4 | ordem dos merges |
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
   ✅ **EXECUTADO 2026-10-31 (passos 1 e 2, Valdo: "Sim, vai")** — detalhe no §13.11 do prompt de privilégios: MariaDB iniciado pelo Valdo
   (administrador); ⚠️ os `node_modules` de TODOS os repositórios (e os `.dart_tool` do app) tinham sido APAGADOS em 2026-10-27 17:30–17:31,
   causa não registrada — reinstalados por `npm ci` (fiscal-api 413 + `dist` refeito · nfse-api 434 · setes-api 478 · worktree com o lockfile
   da API viva, que é ignorado no git); suíte da branch 132/132 suítes · 2112 verdes · 31 pulados; pré-voo SMTP ok (`setes.com.br:465`
   SSL); sql/67 aplicado ANTES e DEPOIS; setes-api `main` = **9144652** (ff), sql `main` = **66fc17c** (merge com o seed 65); boot com
   `script 67: ok` + `E-mail (SMTP) …`; serviços nas abas "setes-api 3000", "nfse-api producao", "setes-app web 5051"; resposta neutra
   conferida (e-mail inexistente = 200 genérico); **passeio FEITO com o Valdo** (5 erradas → aviso E por e-mail, código esgotado recusado,
   código novo trocou a senha — §13.11). **Pendem**: ensaio do script do
   Super (o classificador recusou rodá-lo pelo agente — Valdo roda). Push dos dois `main` FEITO 2026-10-31 (api 9144652 · sql 66fc17c).
3. **Grupo** — `grupo-leitores`: merge ff → push.
   ✅ **EXECUTADO 2026-10-31 (Valdo: "Sim, vai")**: o `main` tinha andado (recuperação), então o `main` foi JUNTADO na branch, na worktree
   (merge `e61f9fe`, sem conflito — nenhum arquivo em comum), suíte no código juntado **134/134 suítes · 2150 verdes · 31 pulados** (worktree
   com `npm ci` pelo lockfile vivo e cópia TEMPORÁRIA do `.env`, apagada), depois `main` fast-forward → **e61f9fe**; API reiniciada pelo
   watch com boot completo; `/api/core/menus` 200 (6 módulos · 38 telas) no app; push do `main` e da branch (`ff2795f..e61f9fe`).
4. **Bloco privilégios** (sessão própria, depois de 2 e 3): fusão `privilegios-crud` ↔ `privilegios-catalogo` (D-PV14 adaptador
   `listGatedRoutes()` em `CONSUMED_PRIVILEGES`; D-PV42 chave técnica; `error-codes` = soma; Q-PV56 CONSULTAR para o núcleo) → script D-PV20
   (`scripts/sql/dpv20-contrato-setes.sql`) → seeds 65 + 68 → `errors:gen` → janela única API + app (merge sobre a450909 com atenção à fábrica)
   + nfse-api restart. Decidir antes os 10 itens de privilégios do §3 (nenhum trava). **+ COSTURA A1 da auth-api (D-AU6, 2026-10-31)**:
   na mesma sessão, o veredito vira UMA peça com UM SQL (view `vw_user_access`) lida pelo setes-api, pelo núcleo e pelo menu — morrem as 4
   cópias; D-UC9/D-GE3/Q-EA7 entram nela; SEM cache do veredito (D-AU8); na MESMA janela, o GRANT do `fiscal_api` em `setes_central` passa
   a listar só as tabelas lidas (D-AU12) (`prompt_frente_auth_api.md` D-AU3/D-AU6/D-AU8/D-AU12). A extração (A2 — projeto `auth-api`) vem depois das
   ondas 0 do grupo e do convidado, e a A3 antes da Onda 4.
4a. **Campos — onda da D-CF4** (sessões próprias, depois de 4; inserido 2026-10-31): worktree `campos` a partir do `main` pós-privilégios →
   bloco 0 (cerca da D-CF2 com exceção nomeada de toda tela ainda não coberta) → A (service-list, price-lists, salesmen, tax-rules) → B
   (árvores) → C (cadeia de entidade, D-CF3; aba de parcerias pelo catálogo de `partnerships`, D-CF5) → D (processo e diálogos) → exceções zeradas. 7–9 sessões, sem prazo
   externo; não trava 5–8. Roteiro: `prompt_frente_campos_todas_telas.md` §5. `terminal` já cumpre o motor; `merchandise` e a aba do
   regime IBS/CBS (D-IB99) adotam na própria frente. A costura A1 da auth-api entra no passo 4 (D-AU6), então o 4a parte do `main`
   depois dela (cruzamento no §3.2 do prompt de campos).
5. **Grupo — onda 0** (sessão própria): D-GE20/A-GE2 (`gatedModule('modules')`), D-GE3 (veredito com institution — o cache da D-PV29 já tem a chave).
6. **Produtos**: rebase `merchandise` sobre o `main` pós-privilégios (conflitos esperados: `router.ts`, `privileges.ts`, `error-codes.ts`) +
   `taxrules-ncm` → onda 1 do APP (sessão própria; inclui o seletor W/L/P no form de Institutions = condição da janela, Q-PR62) → janela
   (071/072/073 no boot, seed 66, trilha P1).
7. **Terminal — onda 0**: merge da `terminal` (migration 074, seed 69) → troca dos literais (D-TM16, sessão própria) → ondas 2/3 no grupo do sync.
8. **Convidado — onda 0** (sessão própria, depois de 4): D-UC8…D-UC12 + D-UC10 (guardião + DDL) + "minha senha" com a peça do código (D-UC7).
9. **Fora da cadeia, a qualquer hora com "vai"**: publicação da NE-2 (D-NE168; roteiro §15.9.4 do prompt da NF-e) · merge da `densidade-c` no app.
   **Janela do modo estrito do núcleo (D-NE172)**: fora da cadeia do ERP, mas ANTES da NE-5 (medir os escritores da nfse-api antes).
10. **Depois da janela de privilégios**: DDLs próprios D-PV33 (trilha `_event` do vínculo), D-PV43 (UNIQUE da `i18n_key`); D-PR59 (colunas do ato);
    regra de tributação por cliente (D-PV30); limpeza (§1 ♻). **Endurecer a autenticação (D-EA10, 2026-10-31)**: a revogação (D-EA7)
    entra no passo 4 (costura A1); depois dele, a partir do `main`: Ondas 1+2 → 3 → 4 (hash — pré-requisito da A2, D-AU11), cada uma com
    gates e "vai", TODAS antes da A2; intercalam com 5–8, menos a Onda 1 com a onda 0 do convidado (as duas mexem no `login`).

---

## 3. Decisões pendentes do Valdo — 58 itens (uma por vez; onde cada uma mora)

| Bloco | Itens | Onde | Trava? |
|---|---|---|---|
| Privilégios (Rodada 6 da onda) | **Q-PV55** (senha cruzada até a onda 0 do convidado — Rec. a) · Q-PV56 (CONSULTAR para o núcleo — Rec. a) · Q-PV57 (`interface-fields`/`general-configs` no contrato — Rec. a) · Q-PV58 (Módulos para o super sem o grupo Super — Rec. a) · A-PV16…A-PV21 | `prompt_privilegios_interfaces.md` §11.10.4–§11.10.5 | não |
| Produtos (Rodada 7, execução) | Q-PR59 (motivo/autor do ato em colunas — Rec. a) · Q-PR60 (chave no destino P — executado a) · Q-PR61 (destino P recusado até o sync — executado a) · Q-PR62 (form de Institutions = condição da janela — Rec. a) · Q-PR63 · A-PR4…A-PR6 | `prompt_modulo_products.md` "Rodada 7 — execução/gates" | Q-PR62 condiciona a janela |
| NE-2 | Q-NE169 (UNIQUE da prova sem institution — Rec. a) · **Q-NE170** (de onde o ERP lê o AMBIENTE ao cunhar o nNF — Rec. a, ANTES da NE-6) · Q-NE171 (`deleted` nunca na faixa — Rec. a) · Q-NE172 (`sql_mode` estrito no pool do núcleo — transversal) | `prompt_onda_nfe_sefaz.md` §15.9 | Q-NE170 antes da NE-6 |
| Terminal (onda 0) | Q-TM8 (admissão do L literal × derivada) · Q-TM9 (escopo do UNIQUE do L no grupo) · Q-TM10 (nome do header) · Q-TM11 (`POST /:id/restore`) · Q-TM12 (porta das três saídas do L) · Q-TM13 (fechamento "em parte") · Q-TM14 (estruturais auto-curativas) · A-TM6…A-TM10 | `prompt_frente_terminal.md` §10 | não |
| Recuperação (D-RS4/D-RS5/D-PV46) | Q-RS7 (2+ Supers ativos) · Q-RS8 (momento do aviso C) · Q-RS9 (`OPS_ALERT_EMAIL`) · Q-RS10 (+1 sobrevive à falha do aviso) · Q-RS11 (marcador de produção) · Q-RS12 (texto do aviso) · Q-RS13 (fato do reset do Super) · Q-RS14 ("Super ativo") · A-RS5…A-RS12 | `prompt_privilegios_interfaces.md` §13.10 | não |
| **auth-api (2026-10-31)** | ~~Q-AU1…Q-AU12~~ → D-AU1…D-AU12 (FECHADA no mesmo dia) | `prompt_frente_auth_api.md` §5 | — |
| Endurecer autenticação | Q-EA1…Q-EA12 (limite por conta, fato da falha, aviso, teto global, política de senha, oráculo "inativo", revogação, TTL do JWT, hash — reservada —, ordem, log forense, `Auth OK`) | `prompt_endurecer_autenticacao.md` | onda própria |
| Campos em todas as telas | Rodadas 1 e 2 FECHADAS (D-CF1…D-CF5 — a D-CF5, 2026-10-31: a aba de parcerias aplica o catálogo de `partnerships`) · cruzamento com a auth-api: **A-CF1 RATIFICADA** (2026-10-31: o setes-api mantém SELECT no registro e na licença, perde só a escrita — leitura da D-AU4; levar à frente auth-api) · ~~Q-CF6~~ → **D-CF6** (2026-10-31: o lado API do motor vira biblioteca que a auth-api também chama nas telas que a A2 leva — `users`, `privileges`, `interfaces`, abas de `institutions`) — NENHUMA questão aberta | `prompt_frente_campos_todas_telas.md` §3.2/§4 | não |
| IBS/CBS | ~~Q-IB1~~ → **D-IB99** (2026-10-31): regime = configuração por estabelecimento; executar antes de 01/01/2027 | `prompt_fase_ibs_cbs.md` §14 | não |
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

---

## 6. Execução

### 6.1 Conferência + passo 0 do §2 — commits de salvaguarda (2026-10-27, Valdo: "Commita")

Conferência do §1: bateu (nenhuma sessão entre 21 e 27/10). O +1 arquivo nas worktrees do app é
`packages/core/.flutter-plugins-dependencies` apagado (gerado) — ficou FORA do commit, junto com `.dart_tool`. Varredura de segredos
nas mudanças: só fixtures de teste e placeholders do `.env.example`. **MariaDB (serviço `mysql`) PARADO** e nenhum serviço no ar.

Commits (só os caminhos de cada tarefa; SEM push, SEM merge; `main` de todos intactos):

| Worktree | Branch | Commit | Arquivos |
|---|---|---|---|
| `privilegios/setes-api` · `setes-app` · `nfse-api` · `sql` | `privilegios-crud` | 3e161a5 · c8e74d4 · 0fbaa09 · e3e90a7 | 74 · 54 · 5 · 1 |
| `merchandise/setes-api` · `sql` | `merchandise` | cdf7eeb · 62f2312 | 51 (+2 renomes 072→073) · 3 |
| `terminal/setes-api` · `setes-app` · `sql` | `terminal` | 81fbf24 · 0d5dc34 · e7fb26b | 21 · 22 · 2 |
| `recuperacao-senha/setes-api` · `sql` | `recuperacao-senha` | 9144652 · 082e35e | 19 · 2 |
| `ne2/fiscal-api` · `nfe-api` | `ne2` | 6edb45f · e615f29 | 12 · 34 |
| `densidade-c/setes-app` | `densidade-c` | 0bb9261 | 69 |

Branches com upstream ficaram 1 commit à frente do GitHub (`privilegios-crud` ×3, `recuperacao-senha` ×2); as demais são só locais.
Próximo do §2: passo 1 (subir os serviços — o MariaDB exige administrador) e as decisões do §3 a partir da Q-PV55.

### 6.2 Decisões de 2026-10-27 (uma por vez)

- **Q-PV55 → D-PV48** (fora das opções): nenhuma janela — depois de criada a credencial só o titular troca a senha, pela recuperação;
  vale para admin e Super; EXECUTAR na `privilegios-crud` antes do merge (entra no passo 4 do §2). Nasceram **A-PV22** (script D-PV46
  como única exceção) e **A-PV23** (conta do sync sem senha: a 1ª senha do admin = criação da credencial) — ratificar no bloco.
- **Q-PV56 → D-PV49** (corrigida pelo Valdo no mesmo dia): privilégio num lugar só, no **SETES-API** (operado pelo setes-app, onde a
  interface nasce) — as APIs fiscais deixam de guardar número (saem o 7/9 do núcleo e o 12 da nfse-api) na janela do bloco; o verbo é
  genérico, o sentido vem do par interface × privilégio (reafirma a D-PV27). Nasceu a **Q-PV59** (como a API fiscal cita o privilégio:
  pelo nome do verbo resolvido em `tb_privilege` × view do setes-api).
- **D-PV50 — REGRA DEFINITIVA** (Valdo): interface registrada em `tb_interface`; `tb_privilege` = todos os verbos do sistema; só o
  vínculo `tb_interface_has_privilege` diz o que a interface opera; o código opera o par registrado e o usuário recebe permissão sobre
  ele; vale para TODA API e vira GATE VALIDADOR de cada interface. Conferido: o método já estava escrito e cercado (D-PV9) no setes-api,
  nfse-api e app — lacunas: cerca fora do `main` (branch `privilegios-catalogo`), lado fiscal sem a regra escrita, nfe-api fora da cerca,
  boot só alarma, inverso (par registrado sem código) não conferido, núcleo com número. Nasceram **A-PV24** (casa do sistema:
  `skills-genericas/interface-e-privilegios.md`), **Q-PV60** (igualdade × inclusão — próxima) e **Q-PV61** (boot); a Q-PV59 volta depois.
- **Q-PV60 → D-PV51** ((a)): igualdade POR INTERFACE — registrado = operado nos dois sentidos; par registrado sem código reprova o gate,
  salvo marca "reservado" com motivo na lista única. Conferência viva vira igualdade; 1ª medição dos pares sobrando com o MariaDB no ar;
  retirar par = soft delete.
- **Q-PV61 → D-PV52** ((a)): o boot só alarma (inclusive o par sobrando); quem barra é o teste (gate de entrega) e a publicação.
- **Q-PV59 → D-PV53** ((a)): a API fiscal cita o privilégio pelo NOME do verbo, resolvido em `tb_privilege` (molde da interface); saem
  os números do núcleo e da nfse-api na janela do bloco; a cerca lê um formato só (app + APIs). Forma do gate da D-PV50 FECHADA.
- **Q-PV57 → D-PV54** ((b)): `interface-fields` e `general-configs` viram estruturais (onboarding + D-PV20 + D-PV35). Condição do
  Valdo: confirmar que TODAS as telas usam o motor de campos — não se confirmou (16 de 38) → **frente nova**
  `prompt_frente_campos_todas_telas.md` (inventário + Q-CF1…Q-CF4), decidida ANTES da Q-PV58.
  Próximo número: D-PV55 · A-PV25 · Q-PV62. Sobram no bloco: Q-PV58 e as ratificações A-PV16…A-PV24 — depois da frente de campos.
- **Frente de campos — Q-CF1 → D-CF1** ((a)): o motor é obrigatório em toda tela que grava dado digitado (cadastro, árvore, entidade,
  processo e os diálogos do processo); fora só os painéis de configuração.
- **Q-CF2 → D-CF2** ((a)): cerca de campos por tela — código = catálogo nos dois sentidos, no teste e na publicação; boot só alarma.
- **Q-CF3 → D-CF3** ((a)): catálogo por papel na cadeia de entidade; a peça compartilhada aplica a config da interface que a monta.
  Próxima: Q-CF4 (quando executa).

### 6.3 Retomada de 2026-10-31

Conferência do §1 + §6.1: bateu (nenhuma sessão entre 27 e 31/10; `main` de todos intactos; MariaDB parado, nenhum serviço no ar). Infra-IA
com as decisões de 27/10 ainda SEM commit.

- **Q-IB1 (vencida em 30/10) → D-IB99** (Valdo: *"por que tenho que responder isso e simplesmente não ter uma opção para configurar no
  sistema"*; Q-IB102 = (a)): o regime de IBS/CBS vira CONFIGURAÇÃO datada de cada estabelecimento (as três opções, padrão "não optar");
  escolher o regular grava e o faturamento recusa ("ainda não suportado") até o cálculo existir; REVÊ a D-IB66; a resposta da Setes vira dado
  na tela dela. **Item com data: no ar antes de 01/01/2027** — sessão própria (`prompt_fase_ibs_cbs.md` §14). Próxima: Q-CF4.
- **Q-CF4 → D-CF4** ((a)): a cobertura do motor de campos é onda PRÓPRIA depois do merge do bloco de privilégios (entra no §2 depois do
  passo 4); `terminal`, `merchandise` e a D-IB99 (establishment) adotam o motor na própria frente. Frente de campos com a Rodada 1 FECHADA.
  Próxima: Q-PV58.
- **Q-PV58 → D-PV55** ((a)): telas do grupo Super ficam fora da tela Módulos também para o Super (ratifica a A-PV18; código já assim).
  Próximo número: D-PV56 · A-PV25 · Q-PV62. Próxima: ratificar A-PV16 (depois A-PV17, A-PV19…A-PV24).
- **A-PV16 RATIFICADA** ((a)): o ALTERAR de `general-configs` sai; só o CONFIGURAR governa as configurações gerais (usuário comum com
  ALTERAR ali precisa receber CONFIGURAR — o seed 68 não copia concessões). Próxima: A-PV17.
- **D-PV56 — princípio** (Valdo, na A-PV17): os verbos são independentes, cada um cobrado pelo seu propósito, nenhum como condição de
  outro (estende a D-PV27). Aplicação em questão: A-PV17 (reaplicar) e os PUT dos painéis de configs/campos (VISUALIZAR do painel +
  CONFIGURAR). Próximo número: D-PV57.
- **D-PV57** (revê a D-PV56 no mesmo dia): propósitos independentes, mas a dependência do VISUALIZAR é real — escolher para o usuário um
  verbo que depende dele leva o VISUALIZAR da mesma interface automaticamente. **A-PV17 RATIFICADA** como executada (sem mudança de
  código); PUT dos painéis seguem a D-PV25. Próxima: **Q-PV62** (quais verbos dependem e onde a dependência mora); depois retirar o
  VISUALIZAR de quem tem dependente e as concessões antigas sem ele. Próximo número: D-PV58 · A-PV25 · Q-PV63.
- **Q-PV62 → D-PV58** ("Todos" — divergiu da Rec.): todo verbo, inclusive CONFIGURAR, leva o VISUALIZAR da mesma tela; regra única no
  código da concessão + tela de permissões, sem DDL. Próxima: **Q-PV63** (desmarcar o VISUALIZAR). Próximo número: D-PV59 · Q-PV64.
- **Q-PV63 → D-PV59** ((a)): desmarcar o VISUALIZAR na tela de permissões desmarca todos os verbos da tela (mostra antes de salvar).
  Próxima: **Q-PV64** (concessões antigas sem o VISUALIZAR). Próximo número: D-PV60 · Q-PV65.
- **Q-PV64 → D-PV60** ((b) — divergiu da Rec.): nenhum script nas concessões existentes; corrige quando o admin salvar de novo. Dependência
  do VISUALIZAR FECHADA (D-PV57…D-PV60). Próxima: ratificar A-PV19 (depois A-PV20…A-PV24). Próximo número: D-PV61 · A-PV25 · Q-PV65.
- **A-PV19 RATIFICADA** ((a)): visão global do Super = ativo da credencial; por estabelecimento = ativo do vínculo. Próxima: A-PV20.
- **A-PV20 RATIFICADA** ((a)): só a diferença real contra o gravado recusa a cadeia da própria empresa. **A-PV21 SUPERADA** pela D-PV54
  (sem pergunta). Próxima: A-PV22.
- **A-PV22 RATIFICADA** ((a)): o script do operador (D-PV46) é a única exceção à D-PV48. Achado: hash do login = MD5 (Q-EA9). Próxima: A-PV23.
- **A-PV23 RATIFICADA** ((a)): a 1ª senha do admin numa conta sem senha (vinda do sync) = criação da credencial. Próxima: A-PV24.
- **A-PV24 EM SUSPENSO**: o Valdo abriu a **frente auth-api** (autenticação + TODA a permissão para app e APIs) —
  `prompt_frente_auth_api.md`; a casa da regra interface × privilégio depende dela.
- **FRENTE auth-api ABERTA** (`prompt_frente_auth_api.md`): Rodada 0 (inventário + parecer do guardião); **Q-AU1…Q-AU12** aguardam o Valdo,
  uma por vez — a Q-AU6 (ordem) decide se a "costura" A1 entra no bloco de privilégios (passo 4 do §2); a Q-AU12 (estreitar o GRANT da
  nfse-api em `setes_central`, que hoje lê os hashes de senha) independe da frente. Próxima: Q-AU1.
- **Q-AU1 → D-AU1** ((a)): auth-api = acesso completo (credencial, token, vínculo/perfil, registro interface × verbo, licença e
  privilégio, veredito); **REVÊ a D-PV49** (catálogo mora na auth-api). Próxima: Q-AU2.
- **Q-AU2 → D-AU2** ((a)): `tb_interface` é da auth-api (registro); campos, configs e menu ficam no setes-api pela chave. Próxima: Q-AU3.
- **Q-AU3 → D-AU3** ((d)): token só com identidade (sem `role`); APIs da instância conferem pela view `vw_user_access` lida viva; app e
  APIs de fora por `GET /v1/access`. Próxima: Q-AU4.
- **Q-AU4 → D-AU4** ((iii)): banco `auth_api` só com credencial, recuperação, falhas e avisos; o resto fica onde está, escrito só pela
  auth-api. Próxima: Q-AU5.
- **Q-AU5 → D-AU5** ((a)): `tb_user_credential` no `auth_api` (hash + e-mail de login imutável + filhas); `tb_user` fica como ator; a
  A-PV23 deixa de ser exceção; revê PADROES §6 na execução. Próxima: Q-AU6.
- **Q-AU6 → D-AU6** ((a)): branches entram como estão; COSTURA A1 no passo 4 (veredito numa peça/view) e nas ondas 0 do grupo e do
  convidado; A2 extrai o projeto `auth-api`; A3 antes da Onda 4. §2 passo 4 atualizado. Próxima: Q-AU7.
- **Q-AU7 → D-AU7** ((a)): instância própria (pasta/repo `auth-api`, porta 3004, `/v1`, deploy próprio — 5º Node e 4ª URL na D-F9).
  Próxima: Q-AU8.
- **Q-AU8 → D-AU8** ((a)): sem cache do veredito — view lida viva a cada requisição; revê a D-PV29 a partir da A1; `EXPLAIN` fundível no
  gate da A1. Próxima: Q-AU9.
- **Q-AU9 → D-AU9** ((a)): chave de sincronia fora da auth-api (setes-api emite, setes-sync verifica; rever só com o grupo do sync).
  **Ampliada** (Valdo): o setes-sync INTEIRO fica fora — pedidos/notas do sync são histórico para gerenciamento; a autorização acontece no
  próprio PDV. Próxima: Q-AU10.
- **Q-AU10 → D-AU10** ((a)): credencial de aplicativo da S1 (apps de terceiros na web) nasce na auth-api — um emissor de token só; revê em
  parte a D-F13. Próxima: Q-AU11.
- **Q-AU11 → D-AU11** ((a)): a troca do MD5 (Q-EA9) executa no setes-api ANTES da A2; na A2 a credencial só muda de banco. Pré-requisito
  da A2: Q-EA9 executada. Próxima: Q-AU12.
- **Q-AU12 → D-AU12** ((a)): estreitar já o GRANT do `fiscal_api` em `setes_central` (só as tabelas lidas; nenhuma API fiscal lê
  `tb_user`), na janela do bloco. **Rodada 1 da auth-api FECHADA (D-AU1…D-AU12)**; A-PV24 absorvida pela D-AU1.
- **Q-PR59 → D-PR53** ((a)): autor e motivo do "Encerrar a transição" viram colunas write-once em `tb_institution`
  (`transition_ended_by`, `transition_end_reason`) + log; migration aditiva na `merchandise` (`prompt_modulo_products.md` Rodada 8).
  Próxima: Q-PR60 (ratificar A-PR4).
- **Q-PR60 → D-PR54** ((a)): no destino P a chave fica viva para os PDVs (o servidor desktop sai pelo fato + terminal L); no W morre.
  Ratifica a A-PR4, sem execução nova. Próxima: Q-PR61 (ratificar A-PR5).
- **Q-PR61 → D-PR55** ((a)): destino P BARRADO até o setes-sync honrar o fato (`SYNC_TRANSITION_ENDED`); ratifica a A-PR5, sem execução
  nova. Próxima: Q-PR62 (form de Institutions = condição da janela).
- **Q-PR62 → D-PR56** ((a)): `sourceKind` obrigatório; o seletor W/L/P na tela de Institutions é CONDIÇÃO DA JANELA de produtos. **Bloco de
  produtos FECHADO** (sobram só as conferências do grupo do sync). Próxima: NE-2 (Q-NE169).
- **Q-NE169 → D-NE169** ((a)): a UNIQUE da prova da inutilização fica sem institution (grão do fisco); a NE-5 traduz o 1062 em 409 tipado;
  a frente do grupo diz se um CNPJ vive em duas institutions (`prompt_onda_nfe_sefaz.md` §15.9.7). Próxima: Q-NE170.
- **Q-NE170 → D-NE170** ((a)): o ERP lê o ambiente do 55 por view publicada da habilitação no núcleo, viva ao cunhar o nNF, junto da view
  de faixas — executa na janela da NE-6. Próxima: Q-NE171.
- **Q-NE171 → D-NE171** ((a)): `tb_invoice_number_void` é append-only — `deleted` nunca é escrito (cerca por AST na NE-5). Próxima: Q-NE172.
- **Q-NE172 → D-NE172** ((a)): pool do núcleo em `sql_mode` estrito numa JANELA PRÓPRIA antes da NE-5 (medir antes os escritores da
  nfse-api em cópia descartável; gates dela no escopo). **Bloco da NE-2 FECHADO.** Próxima: terminal (Q-TM8).
- **Q-TM8 → D-TM23** ((a)): admissão do L literal — o ato inativa o L na mesma transação; o sync confere "vivo e ativo"
  (`prompt_frente_terminal.md` §10.10). Próxima: Q-TM9.
- **Q-TM9 → D-TM24** ((a)): UNIQUE do L por estabelecimento; "uma fonte por grupo" conferida no pareamento na onda do grupo (nota no
  prompt do grupo, junto da pergunta da D-NE169 sobre CNPJ em duas institutions). Próxima: Q-TM10.
- **Q-TM10 → D-TM25** ((a)): header do pareamento = `X-Sync-Holder` (contrato das ondas 2/3 com o grupo do sync). Próxima: Q-TM11.
- **Q-TM11 → D-TM26** ((a)): sem rota de reativação de terminal (ratifica a A-TM10). Próxima: Q-TM12.
- **Q-TM12 → D-TM27** ((a)): a porta do L é o pareamento (não pareado = livre; pareado = só pelo ato); ratifica a A-TM6 revista.
  Próxima: Q-TM13.
- **Q-TM13 → D-TM28** ((a)): onda 0 do terminal "preparada" (cerca congela os literais); troca dos ~140 literais em sessão própria
  depois dos merges (D-TM16). Próxima: Q-TM14.
- **Q-TM14 → D-TM29** ((a)): telas estruturais concedidas por passo de boot idempotente a toda institution ativa (muda para a auth-api
  na A2). **Bloco do terminal FECHADO** (sobram A-TM7/A-TM8/A-TM9 a ratificar). Próxima: A-TM7.
- **A-TM7 RATIFICADA**: leitura interina da origem só na branch `terminal`; na fusão vira a peça `sourceKindOf`. Próxima: A-TM8.
- **A-TM8 RATIFICADA**: L inativo pode nascer e existir; reativar passa pelas mesmas travas do nascimento. Próxima: A-TM9.
- **A-TM9 RATIFICADA**: lookup só ativos; lista da tela com inativos. **Terminal sem questão aberta.** Próxima: recuperação (Q-RS7).
- **Q-RS7 → D-RS7** ((b)): script do Super aceita `--user-id` entre 2+ Supers ativos (sem nome, recusa); a mensagem deixa de citar a
  tela (D-PV48). EXECUTAR em worktree com teste e "vai" (o script já está no `main`). Próxima: Q-RS8.
- **Q-RS8 → D-RS8** ((a)): aviso C no pedido calado, ≤ 1/h (ratifica a A-RS6); (c) só se houver fadiga. Próxima: Q-RS9.
- **Q-RS9 → D-RS9** ((a)): falha do SMTP no aviso só no log; canal de alarme decidido na Q-EA4 (auth-api). Próxima: Q-RS10.
- **Q-RS10 → D-RS10** ((a)): savepoint em volta do aviso — o +1 da tentativa errada sobrevive à falha do aviso. Próxima: Q-RS11.
- **Q-RS11 → D-RS11** ((a)): `npm start` = produção por padrão (ratifica a A-RS9) + item no roteiro da Onda 4. Próxima: Q-RS12.
- **Q-RS12 → D-RS12** ((a)): texto único do aviso, sem link de ação. Próxima: Q-RS13.
- **Q-RS13 → D-RS13** ((b)): o script do Super avisa o Super por e-mail neutro ao redefinir a senha; executar JUNTO da D-RS7 (mesmo
  script, worktree, teste, "vai").
- **Q-RS14 → D-RS14** ((a)): "Super ativo" no script = predicado do login (usuário E vínculo ativos); ratifica a A-RS10; já no `main`,
  sem execução nova. Próxima: A-RS5.
- **A-RS5 → D-RS15** ((a)): script do Super sem `tb_user.kind`/`updated_by` — Super pelo vínculo, autor no log, nenhum ALTER; o script
  muda para a auth-api na A2 (herança no §6 do prompt da auth-api). Próxima: A-RS8 (1ª metade).
- **A-RS8 (1ª metade) → D-RS16** ((a)): o script recusa Super inativo e nunca reativa (reativar = outro Super pela tela); o único Super
  inativo = SQL manual (limite conhecido). Próxima: A-RS11.
- **A-RS11 → D-RS17** ((a)): tetos do SMTP 15 s / 15 s / 30 s mantidos; vão com a recuperação para a auth-api na A2. Próxima: A-RS12.
- **A-RS12 → D-RS18** ((a)): fora de produção, código não entregue vai ao log; em produção nunca. **Recuperação sem questão aberta**
  (A-RS5…A-RS12 todas ratificadas — A-RS7 pela D-RS12). Na execução da D-RS7/D-RS13: reescrever a seção "Senha perdida do SUPER" do
  `setes-api/CLAUDE.md` (ainda cita D-PV12). Próxima: Q-EA1.
- **Q-EA1 → D-EA1** ((a)): login bloqueia a conta com 10 erradas em 15 min (janela deslizante, mesma 401, sem botão); o script do Super
  NÃO desbloqueia — o Super espera a janela (`prompt_endurecer_autenticacao.md`, Rodada 1). Próxima: Q-EA2.
- **Q-EA2 → D-EA2** ((a)): `tb_user_login_failure` filha, só falhas, append-only, trava do usuário; nasce em `setes_central` (molde
  sql/67) e muda para o `auth_api` na A2 sem reforma. Próxima: Q-EA3.
- **Q-EA3 → D-EA3** ((b)): aviso neutro ao dono ao bloquear, ≤ 1/h, em tabela irmã própria `tb_user_login_notice` (até 2 avisos/h com a
  recuperação — aceito). Próxima: Q-EA4.
- **Q-EA4 → D-EA4** ((a)): alarme do login (>100 falhas/min ou >30 contas em 5 min; log + crashlytics + e-mail 1/15 min), nunca
  bloqueia; `OPS_ALERT_EMAIL` obrigatório em produção; o canal é da operação (precisa a D-RS9). Próxima: Q-EA5.
- **Q-EA5 → D-EA5** ((a)): senha mínimo 8, sem classes, lista de comuns, sem o e-mail, ≠ atual; existentes valem até a próxima troca; peça
  única API + `setes_validators`. Próxima: Q-EA6.
- **Q-EA6 → D-EA6** ((a)): login com UMA resposta (401 neutra, mesmo tempo) para senha errada, inexistente, inativo e sem vínculo — as
  mensagens de hoje confirmavam SENHA CERTA (conferido no código); motivo só no log. Próxima: Q-EA7 (muda pela auth-api).
- **Q-EA7 → D-EA7** ((a) REVISTA): inativação cai na hora pela view viva; troca de senha pelo `iat` × fato próprio "senha definida em T"
  ao lado do hash (não o `tb_user.updated_at`, que todo salvar do cadastro toca); sem cache; entra na COSTURA A1 do passo 4 (D-AU6).
  Próxima: Q-EA8.
- **Q-EA8 → D-EA8** ((a)): token final segue 24 h sem refresh; rever só por exigência externa. Próxima: Q-EA9 (hash — reservada).
- **Q-EA9 → D-EA9** ((a)): MD5 aposentado (revê a decisão 2 da Fase 2) — `scrypt` nativo `N=2^15, r=8, p=3` (corrigido de p=1),
  migração transparente no login, mesma coluna; pré-requisito da A2 (D-AU11) agora DECIDIDO, falta executar. Próxima: Q-EA10 (muda pela
  auth-api).
- **Q-EA10 → D-EA10** ((a) REVISTA): revogação no passo 4; depois Ondas 1+2 → 3 → 4, todas antes da A2; Onda 1 nunca em paralelo com a
  onda 0 do convidado; passo 10 do §2 ajustado. Próxima: Q-EA11.
- **Q-EA11 → D-EA11** ((a)): uma linha de log por falha de login (e-mail mascarado, IP, motivo interno), nada a mais no banco. Próxima:
  Q-EA12 (última da fila).
- **Q-EA12 → D-EA12** ((a)): a linha `Auth OK` do `authMiddleware` sai, na costura A1. **Rodada do endurecer FECHADA (D-EA1…D-EA12)** e
  **FILA DESTA RODADA ZERADA** (recuperação D-RS14…D-RS18 + endurecer D-EA1…D-EA12, 2026-10-31).
- ~~⏯ RETOMAR A RODADA (2026-10-31, contexto alto)~~ — **CUMPRIDA no mesmo dia (sessão nova)**: Q-RS14 → A-RS5…A-RS12 → Q-EA1…Q-EA12
  respondidas uma por vez (linhas acima). **Rodada "uma pergunta por vez" de 31/10 SEM questão na fila.**
- **Execuções que nasceram em 31/10 (cada uma com "vai", em worktree)**: D-RS7+D-RS13 (script do Super — junto, reescrever "Senha perdida do
  SUPER" do `setes-api/CLAUDE.md`, D-RS16) · D-IB99 (regime de IBS/CBS, antes de 01/01/2027) · D-PR53 (colunas do ato, na `merchandise`) ·
  D-AU1…D-AU12 (costura A1 no passo 4 — com D-EA7 revogação e D-EA12 `Auth OK` — + GRANT da nfse-api) · endurecer Ondas 1+2 → 3 → 4
  (D-EA1…D-EA6, D-EA9, D-EA11; ordem D-EA10; todas antes da A2). **Infra-IA COMMITADA (Valdo, 2026-10-31: pull antes do commit)**:
  as decisões de 31/10 depois da D-AU12 (D-PR53…D-PR56, D-NE169…D-NE172, D-TM23…D-TM29, A-TM7…A-TM9, D-RS7…D-RS18, D-EA1…D-EA12) +
  INDICE 10.50…10.53 no commit **23068ef** (pull = já atualizado; só os 11 arquivos da rodada). Push: só com o pedido do Valdo.
