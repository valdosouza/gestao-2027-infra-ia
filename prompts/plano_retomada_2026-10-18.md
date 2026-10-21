# Plano de retomada — frentes abertas da noite de 2026-10-17 → 2026-10-18

**Escopo**: setes
**Gerado em**: 2026-10-18 (domingo), a pedido do Valdo: "analise de todos os chats trabalhados desde ontem à noite que não foram
encerrados … compile num plano de execução, em ordem, checando o que deve ser commitado".
**Fonte**: 19 sessões do app Claude Code em `D:\Gestao2027` desde 2026-10-17 22:00, `git status`/`git worktree list` de TODOS os
repositórios e worktrees (2026-10-18 ~16:30), os pontos de retomada (⏯) de cada prompt da Infra-IA e as últimas mensagens das sessões.
**Natureza**: documento de COORDENAÇÃO. Não decide nada; aponta o §/prompt onde cada frente retoma e a ordem recomendada. Cada "vai",
"commita" e resposta às questões numeradas continua sendo do Valdo. Quando as etapas daqui forem cumpridas, mover para `HISTORICO/`.

---

## 0. Em uma tela

| Bloco | Estado | O que falta | Bloqueio |
|---|---|---|---|
| **Ambiente** | ✅ FEITO 2026-10-18 (noite): setes-api :3000 · nfse-api :3002 · app :5051 no ar, em abas do Terminal (health 200 · 200 · página 200); boot do setes-api sem migration pendente, 9 gatilhos da F2a conferidos | — | — |
| **Higiene** | ✅ FEITO em parte 2026-10-18: `nfse-api/package.json` revertido; 12 worktrees ♻ removidas com as branches (pastas `ib3/`, `ne1b/`, `shell/` apagadas); dartvm da :5000 parado; pacote Firebird apagado da Infra-IA (era cópia, hash a hash, do kit `C:\Temp\Firebird-2.5-e-5.0`, que ficou) | — | — |
| **Sync (D-SY10/11/13, patch 11)** | ✅ COMMITADO 2026-10-18 (noite), só os caminhos do §10.7: setes-sync **edbaad4** · sincronizador **b6c6ebe** (sem push) | A-SY1 + Q-SY15…Q-SY23 → implantação (Fase 4) | decisões; build oficial do patch 11 (Valdo) |
| **Recuperação de senha** | ❌ **REMOVIDA — D-PV18 (Valdo, 18/10 noite): "os aplicativos não precisam de recuperação de senha"**. Branch `recuperacao-senha` APAGADA (local + GitHub); o fluxo que EXISTIA no `main` sai pela branch `sem-recuperacao-senha` (worktrees `sem-recuperacao/{setes-api,setes-app}`): ✅ API **fbf01a3** (tsc limpo · auth 26/26 com a cerca) · app **ad50385** (analyze limpo · core 81/81 · web 634 verdes/27 skip) — commitados na branch, sem merge | merge **API + app JUNTOS** com o "vai" (fecha o CRITICAL da colação por construção: sem fluxo, sem porta) | "vai"; Q-PV54 (senha perdida do Super) e Q-UC25 (senha do convidado) abertas, não travam |
| **Grupo — D-GE4 leitores** | branch `grupo-leitores` ff2795f **no GitHub** (push 2026-10-18 noite), sem merge; gates 0,78/0,84 | "vai" → merge na árvore viva (sem DDL) | nenhum |
| **Privilégios — onda D-PV2** | branch `privilegios-crud` no GitHub (api 50b928f · app 5a06d73 · nfse b62d55b); seed 65 no `main` do sql, NÃO aplicado | 3a (D-PV17) · 3b (D-UC1…D-UC5) · roteiro §11.8 · fusão com a cerca e com `grupo-leitores` | lista de telas do contrato da Setes (D-PV10) + decisão do 3b |
| **Privilégios — cerca D-PV9** | ✅ COMMITADO 2026-10-18 (noite) na branch `privilegios-catalogo`: setes-api **8b1fe27** · setes-app **53a1497** (sem push/merge) | A-PV12 · A-PV14 · Q-PV19 · Q-PV50…Q-PV53 → publicação §12.7 | decisões (nenhuma trava a entrega) |
| **Produtos — onda 1 API + R4/R5/R6** | ✅ COMMITADO 2026-10-18 (noite) na branch `merchandise`: setes-api **2171f20** · sql **8b8cedf** (sem push/merge); 071/072/seed 66 NÃO aplicados; suíte 138/141 (2.112 testes, 0 falha) | Rodada 7 → janela §9 → onda 1 do APP | **Q-PR52 TRAVA a janela**; Q-PR53…Q-PR56, Q-PR50, Q-PR51, D-PR42; Q-SY14 (grupo do sync) |
| **Produtos — D-PR13 NCM** | ✅ COMMITADO 2026-10-18 (noite) na branch `taxrules-ncm`: setes-api **b651354** · setes-app **ef99e60** (app sobre 2f621c1 → rebase; sem push/merge) | entra na janela de produtos (merge) | nenhum |
| **CNPJ alfanumérico (onda 1 + R3–R5)** | branch `cnpj` dos 4 repos **no GitHub** (push 2026-10-18 noite); núcleo e app DIVERGIRAM do `main` | rebase; janela §8.5+§8.16 | retorno do grupo do sync + "vai" |
| **nfe-api — NE-2 Rodada 0** | só documento (§15); D-NE158/D-NE159 decididas | Q-NE160…Q-NE168 (revisão uma a uma) → E1…E5 | decisões |
| **Usuário convidado** | só documento (D-UC1…D-UC5) | A-UC2/A-UC3 · Q-UC11/23/24 · A-UC4…A-UC8 → guardião/DDL | decisões; código só após fusão da `privilegios-crud` |
| **Terminal (tb_terminal) + debate Terminal×Grupo×PDV** | só documentos (+ DDL rascunho) | Q-TM1…Q-TM7 + A-TM1…A-TM5 · Q-TG1…Q-TG14 | decisões; ondas 2/3 após patch 11 commitado |
| **Densidade/layout (A, B, D, login)** | PUBLICADO (`main` a450909, GitHub) | onda C (lista em tabela) · grade nas telas de processo · passeio logado (pulado) | nenhum |
| **nfe-api — NE-1b** | PUBLICADO (núcleo abce0b8) | — | — |
| **IBS/CBS — IB-4** | IB-3 publicada; prova em H pendente (fisco de H com E1000) | prova em H quando o fisco normalizar | externo · ⚠️ Q-IB1 (regime) até **30/10/2026** |

---

## 1. Sessões desde ontem à noite e como terminaram

| Hora (18/10) | Sessão | Frente | Em disco | Commit | Retomar por |
|---|---|---|---|---|---|
| 17/10 23:09 | Status dos projetos Setess | coordenação | — | — | — (disparou os gates da NE-1b) |
| 02:20 / 11:52 | 03 - rendereização Screens → 05 - Onda D shell | densidade/layout | `main` a450909 | ✅ publicado | `prompt_densidade_layout_web.md` §5/§6 |
| 03:54 | Gates do motor Infra-AI e Claude | pergunta (gates = skills da Infra-IA, não do Claude) | — | — | nada pendente |
| 12:15 | 06 - Corrigir leitores D-GE4 | grupo de estabelecimentos | worktree `grupo-leitores` | ⚠️ LOCAL ff2795f | `prompt_frente_grupo_estabelecimentos.md` §10/§12 |
| 12:44 | 01 - API-NFe sem finalização CNPJ | nfe-api NE-1b | núcleo abce0b8 | ✅ publicado | — (próximo = NE-2) |
| 14:40 | Terminal × matriz/filiais × PDV | debate | `prompt_frente_terminal_grupo_pdv.md` | ✅ Infra-IA | §9 dele |
| 14:53 | 04 - Conferir inversão comissão × margem | grupo do sync | doc + patch 10 (já commitado 00:07) | ✅ | `setes-sync/verificacao-comissao-margem-mercadoria.md` |
| 15:14 | 13 - Executar Rodada 6 de produtos | produtos (API) | worktree `merchandise` | ❌ 68 arquivos | `prompt_modulo_products.md` §9 |
| 15:15 | Frente tb_terminal | terminal | `prompt_frente_terminal.md` + DDL rascunho | ✅ Infra-IA | §8 dele |
| 15:15 | 12 - Usuário convidado Rodada 0 | usuário convidado | `prompt_frente_usuario_convidado.md` | ✅ Infra-IA | §11 dele |
| 15:16 | 14 - Prompt Onda NFe Sefaz §14.20 | nfe-api NE-2 Rodada 0 | `prompt_onda_nfe_sefaz.md` §15 | ✅ Infra-IA | §15.8 (Q-NE160) |
| 15:16 / 15:17 | 02 - Cadastro de produto · Produtos módulo prompt | produtos (coordenação) | §9 salvo | ✅ Infra-IA | `prompt_modulo_products.md` §9 |
| 15:17 | 11 - Executar D-SY10, D-SY11 e D-SY13 | grupo do sync | setes-sync + sincronizador | ❌ 33 arquivos | `verificacao-comissao-margem-mercadoria.md` §10.7 |
| 15:18 | 09 - Cerca D-PV9 | privilégios | worktrees `privilegios-catalogo` | ❌ 19 arquivos | `prompt_privilegios_interfaces.md` §12.9 |
| 15:19 | 08 - Onda D-PV2 | privilégios | worktrees `privilegios` | ✅ branch no GitHub | §11.8.1 |
| 15:19 | 07 - Privilégios devidos das 31 telas | privilégios R0–R2 | sql/64 APLICADO; sql 3672ee2 | ✅ | — (fechada) |
| 16:13 | 10 - Força bruta no /auth/change-password (Q-PV38) | recuperação de senha | ~~worktrees `recuperacao-senha`~~ → **MORTA pela D-PV18** (noite de 18/10): branch apagada; o fluxo sai do `main` | ❌ apagada | §13 do prompt de privilégios (nota SUPERADA) |
| (17/10 16:01) | Serviços de API e setes-app | ambiente | subiu 3000/3002/5051 — HOJE todos fora | — | skill `dev-server-orchestrator` |
| (17/10) | D-PR13 (NCM 8 dígitos) | produtos | worktrees `taxrules-ncm` | ❌ 10 arquivos | `prompt_modulo_products.md` (D-PR13) |

Sessões de outros workspaces no período (Gestao2016, pipoteca, lottery) ficam fora deste plano.

---

## 2. Estado git — repositório a repositório (2026-10-18 ~16:30)

Legenda: ✅ = igual ao GitHub · ⚠️ = commit só local · ❌ = alteração sem commit · ♻ = branch já integrado ao `main` (worktree removível).

| Repo / worktree | Branch @ commit | vs `main` | Estado | Ação |
|---|---|---|---|---|
| `setes-api` (árvore viva = deploy) | `main` f53a618 | — | ✅ limpo | subir :3000 |
| `grupo-leitores/setes-api` | `grupo-leitores` ff2795f | +1 | ⚠️ sem upstream | push de salvaguarda; merge com "vai" |
| `privilegios/setes-api` | `privilegios-crud` 50b928f | +1 | ✅ no GitHub | 3a/3b; fusão; merge na janela |
| `privilegios-catalogo/setes-api` | `privilegios-catalogo` @f53a618 | 0 | ❌ 18 arq (9 M + 9 novos) | commit só dos caminhos do §12.9 |
| ~~`recuperacao-senha/setes-api`~~ | ~~d19de9d~~ | — | ❌ APAGADA (D-PV18, 18/10 noite — local e GitHub) | — |
| `sem-recuperacao/setes-api` (NOVA, D-PV18) | `sem-recuperacao-senha` **fbf01a3** | +1 | ✅ commit (7 arquivos; tsc limpo, auth 26/26 + cerca), sem push | merge API + app JUNTOS com o "vai" |
| `sem-recuperacao/setes-app` (NOVA, D-PV18) | `sem-recuperacao-senha` **ad50385** | +1 | ✅ commit (23 arquivos: 4 apagados, 18 chaves i18n, 7 testes ajustados, cerca Dart; analyze limpo, core 81/81, web 634/27 skip), sem push | idem |
| `merchandise/setes-api` | `merchandise` @f53a618 | 0 | ❌ 66 arq (31 M + 35 novos) | commit de salvaguarda; Rodada 7 |
| `taxrules-ncm/setes-api` | `taxrules-ncm` @f53a618 | 0 | ❌ 4 arq | commit; merge junto da janela de produtos |
| `cnpj/setes-api` | `cnpj` dcf4e1e | +2 (ff) | ⚠️ sem upstream | push de salvaguarda |
| `setes-api-f2a` · `setes-api-ib2` · `ib3/` · `ne1b/` | f2a · ib2 · ib3 · ne1b | 0 à frente | ♻ | remover worktree + branch |
| `setes-app` (árvore viva) | `main` a450909 | — | ✅ (só `.dart_tool`) | subir :5051 |
| `privilegios/setes-app` | `privilegios-crud` 5a06d73 | +1 / main+3 | ✅ no GitHub, DIVERGIU (densidade/shell) | merge com atenção à `RegisterFormPage` |
| `privilegios-catalogo/setes-app` | `privilegios-catalogo` @a450909 | 0 | ❌ `apps/web/build-web.ps1` | commit (sem `.dart_tool`) |
| `taxrules-ncm/setes-app` | `taxrules-ncm` @2f621c1 | 0 / main+3 | ❌ 6 arq, base ANTERIOR a densidade/shell | commit; rebase sobre a450909 |
| `cnpj/setes-app` | `cnpj` db92f38 | +2 / main+3 | ⚠️ DIVERGIU | push; rebase na janela |
| `densidade/` · `shell/` · `setes-app-f2b` · `ib3/setes-app` | densidade · shell · f2b · ib3 | 0 à frente | ♻ | parar o dartvm :5000 (PID 18532) e remover |
| `sql` | `main` 9f4fcf3 | — | ✅ (64 APLICADO · 65 NÃO aplicado) | — |
| ~~`recuperacao-senha/sql`~~ | ~~e1aa574~~ | — | ❌ APAGADA (D-PV18) — o número de seed **67 ficou livre** | — |
| `merchandise/sql` | `merchandise` @7cdce7e | 0 / main+2 | ❌ `03_schema_cliente_ddl.sql` + `66_merchandise_interface_seed.sql` | commit; rebase (64/65 chegaram depois) |
| `fiscal-api` (núcleo) | `main` abce0b8 | — | ✅ limpo | — |
| `cnpj/fiscal-api` | `cnpj` 5cb70a2 | +3 / **main+17** | ⚠️ DIVERGIU com a NE-1b | push; **rebase obrigatório** antes da janela |
| `ib3/fiscal-api` · `ne1b/fiscal-api` | ib3 · ne1b | 0 à frente | ♻ | remover |
| `nfse-api` | `main` 62c5fcf | — | ❌ `package.json` com lixo de `npm init` (main/keywords/author/license) | `git checkout -- package.json` |
| `privilegios/nfse-api` | `privilegios-crud` b62d55b | +1 | ✅ no GitHub | merge na janela de privilégios (restart manual) |
| `cnpj/nfse-api` | `cnpj` 1d09e83 | +7 (ff) | ⚠️ sem upstream | push de salvaguarda |
| `ib3/nfse-api` · `ne1b/nfse-api` | ib3 · ne1b | 0 à frente | ♻ | remover |
| `nfe-api` | `main` a9ef9ac | — | ✅ limpo | NE-2 |
| `setes-sync` | `main` e54acc2 | — | ❌ 16 M + 5 novos (D-SY10/11/13) | commit SÓ os caminhos do §10.7 (⚠️ `scripts/reset-institution-sync-data.ts` é de outra sessão — fora) |
| `sincronizador` | `main` 025c2bc | — | ❌ 10 M + 2 novos (patch 11) | commit SÓ os caminhos do §10.7 (⚠️ `Sincronizador.dproj` já estava alterado antes — fora) |
| `Infra-IA` | `main` f4b1ada | — | ✅ commitada e no GitHub; untracked `Sincronizador/scripts/firebird50/pacote/` (2 `.exe` = 36 MB + cópias idênticas dos scripts rastreados); submódulo `codigo-aprendizado/GestaoERPApps` sujo (75 alterações internas, `apps/budget_sales` — outro projeto) | pacote FORA do git (ignorar a pasta ou mover para fora do repo); submódulo não é desta noite — não tocar |
| `D:\Gestao2027\CLAUDE.md` | (não é git) | — | atualizado pelas sessões | — |

**Junções a lembrar na limpeza** (`rmdir` da junção, NUNCA remoção recursiva — apagaria o repositório de verdade):
`privilegios-catalogo\{fiscal-api,nfse-api}` · `recuperacao-senha\{fiscal-api,nfse-api}` · `merchandise\{fiscal-api,nfse-api}` ·
`privilegios\fiscal-api` · `grupo-leitores\{fiscal-api,nfse-api}` · `taxrules-ncm\{fiscal-api,nfse-api}`. Dentro das worktrees do
setes-api, o `.env` é link físico do `.env` vivo (gitignored).

**Banco (dev = "produção" da Setes)**: sql/64 APLICADO (157 pares) · sql/65 NÃO aplicado (antes do app da D-PV2) · sql/67 MORREU com a branch
(D-PV18 — o número 67 fica livre; a frente `tb_terminal` passa a usar 67) · 071/072 + seed 66 NÃO aplicados (rodam no boot da
árvore viva no merge do `merchandise`) · CHECK do CNPJ aguarda o grupo do sync.

---

## 3. Decisões do Valdo que destravam cada bloco

Em ordem de impacto (o que destrava mais primeiro). Recomendações já estão em cada prompt; aqui só o inventário.

1. **Produtos — Rodada 7** (`prompt_modulo_products.md`, "Rodada 6 — gates"): **Q-PR52** (TRAVA a janela — a guarda no `services` tira da
   Setes o único escritor da regra de ISS/classificação IBS-CBS dos serviços do legado; Rec. (a) rota própria fora da guarda) · Q-PR53 (antes
   do 1º cliente com legado) · Q-PR54 · Q-PR55 · Q-PR56 · Q-PR50 (ids 16–79 da Setes no espaço do legado) · Q-PR51 (`financial-plans`/
   `bank-accounts` também guardados) · confirmar D-PR42. Junto: **Q-SY14** (grupo do sync — todos os pedidos no terminal 0).
2. **Privilégios — onda D-PV2** (§11.8.1): executar JÁ o **3b** (efeito da D-UC1…D-UC5 no branch: `removeUser` sai, e-mail de login imutável,
   "ativo" = vínculo, A-PV13 morre) ou deixar para a onda do convidado? · **lista de telas do contrato da Setes** (implantação da D-PV10) ·
   ratificar A-PV5…A-PV11 · Q-PV10…Q-PV15, Q-PV21…Q-PV36 (nenhuma trava).
3. **Privilégios — cerca D-PV9** (§12.9): ratificar A-PV12 e A-PV14 · confirmar Q-PV19 (resposta veio repetida) · Q-PV50…Q-PV53 (Q-PV51 é DDL →
   guardião + PADROES + prova em descartável).
4. ~~Recuperação de senha~~ → **SEM OBJETO (D-PV18, 18/10 noite)**: Q-RS1…Q-RS6/A-RS1…A-RS4 morreram. No lugar: **Q-PV54** (senha perdida
   do SUPER — Rec. procedimento documentado do operador) e **Q-UC25** na frente do convidado (quem define/troca a senha do titular — Rec.: o
   titular logado troca a própria; o admin só define a inicial). Nenhuma trava a publicação.
5. **Grupo do sync** (§10.6/§10.7): "commita" · A-SY1 · Q-SY15…Q-SY23 → viram rodada executável; implantação (build oficial do patch 11 é
   do Valdo, no Delphi).
6. **Grupo de estabelecimentos**: só o "vai" da D-GE4 (nenhuma questão aberta); depois abrir a onda 0.
7. **Usuário convidado** (§11): confirmar A-UC2 (senha só pela recuperação) e A-UC3 (vínculo interceptado = `user`) · Q-UC11 · Q-UC23 · Q-UC24 ·
   ratificar A-UC4…A-UC8.
8. **Terminal**: Q-TM1…Q-TM7 + A-TM1…A-TM5 (`prompt_frente_terminal.md` §6) e Q-TG1…Q-TG14 (`prompt_frente_terminal_grupo_pdv.md` §6) —
   reconciliar as duas (Q-TG1/2/3/7/9/14 tratam do mesmo objeto).
9. **nfe-api NE-2** (§15.8): Q-NE160…Q-NE168, uma a uma (o Valdo pediu assim).
10. **CNPJ alfanumérico**: nenhuma questão; só o retorno do grupo do sync (acordo do CHECK e da forma no Firebird) + "vai" da janela.
11. **IBS/CBS**: Q-IB1 — opção pelo regime regular, com o contador, **até 30/10/2026** (prazo externo).

---

## 4. Plano de execução (ordem recomendada)

### Fase 0 — Ambiente e higiene (hoje; sem decisão de arquitetura; ~30 min)

> **EXECUTADA 2026-10-18 (noite, nesta mesma sessão — Valdo: "Faça esta tarefa aqui")**
> - Item 1 ✅: setes-api (`npm run dev`, aba "setes-api 3000") — boot: JWT RS256 kid default · REPEATABLE-READ · fuso +00:00 · CHECK aplicado ·
>   catálogo IBS/CBS ok · views do fisco (família service) · **Migrations: nenhuma pendente** · **9 gatilhos da F2a** · porta 3000; nfse-api
>   (`npx tsx --require tsconfig-paths/register src/server.ts`, SEM watch, aba "nfse-api producao") — CORS 5000/8080/5051, porta 3002;
>   app (`apps/web/run-dev.ps1`, aba "setes-app web 5051") — `is being served at http://localhost:5051` em ~68 s. Health: `/health` 200,
>   `/v1/health` 200 (`db`, `masterKey`, `storage` true), `GET /` da :5051 = 200.
> - Item 2 ✅: `nfse-api/package.json` — eram só os 4 campos de `npm init`; `git checkout -- package.json`; `git status` limpo.
> - Item 3 ✅ (Valdo: "pode remover"): o `pacote/` era CÓPIA do kit original `C:\Temp\Firebird-2.5-e-5.0` (9 arquivos, SHA-256 iguais um a
>   um, montado em 2026-10-13 pela sessão "Scripts instalação Firebird 2.5 e 5.0" para instalar 2.5 + 5.0 lado a lado em OUTRO PC). A cópia
>   dentro da Infra-IA foi apagada; o original ficou. Os 4 arquivos que só existem no kit (`instalar-firebird25-e-50.ps1`, `INSTALAR.bat`,
>   `REMOVER-firebird50.bat`, `LEIA-ME.txt`) continuam em `C:\Temp` — ⚠️ pasta volátil; se o kit for para a Infra-IA um dia, só os scripts
>   (nunca os `.exe`).
> - Item 4 ✅: dartvm 18532 (:5000) parado; **12 worktrees removidas** com `git worktree remove --force` (as 3 do setes-app só tinham
>   `.dart_tool/*` modificados) e `git branch -d` nas 12 branches (todas 0 à frente do `main`): setes-app densidade/shell/f2b/ib3; setes-api
>   f2a/ib2/ib3/ne1b; fiscal-api ib3/ne1b; nfse-api ib3/ne1b. Pastas `ib3/`, `ne1b/` e `shell/` apagadas (vazias). **Lição**: as junções
>   NÃO estavam na raiz das pastas, e sim DENTRO das worktrees — `ne1b/{setes-api,nfse-api}\node_modules` → `node_modules` do repo vivo, e
>   `node_modules\fiscal-api` → núcleo (em f2a, ib2, ib3/setes-api, ib3/nfse-api); todas desfeitas com `rmdir` ANTES do `worktree remove`
>   (alvos conferidos intactos: 349/324/311 entradas nos `node_modules` vivos). Regra para a próxima limpeza: varrer ReparsePoints até
>   profundidade 2 dentro da worktree, não só na pasta-mãe.
> - Item 5 ✅: submódulo, `.dart_tool/*`, setes-sync e sincronizador intocados.
> - Sobras na raiz, fora do escopo (não tocadas): `densidade/comparativo/` (4 arquivos do passeio antes × depois da frente de densidade —
>   candidatos a ir para a Infra-IA ou ao lixo) e `seed/` (9 `.sql` de 2026-07 — cidades/países/CFOP/interface/privilégio, inclusive
>   `*_firebird.sql`; viola a estrutura fixa da raiz — decidir destino).

1. **Subir a "produção" local**: setes-api :3000 (`tsx watch`, aplica migrations — o `main` f53a618 não tem migration nova), nfse-api :3002
   (sem watch), app :5051 (`run-dev.ps1`). Skill `dev-server-orchestrator`. Conferir `/health` e `/v1/health`. Enquanto isso não acontece, o
   app abre em "Sem resposta do serviço — NETWORK · setes-api".
2. **Reverter** `nfse-api/package.json` (lixo de `npm init`): `git checkout -- package.json` na árvore viva.
3. **Pacote Firebird** (`Infra-IA/Sincronizador/scripts/firebird50/pacote/`): 36 MB de `.exe` não entram no git. Opções: (a) acrescentar
   `Sincronizador/scripts/firebird50/pacote/` ao `.gitignore` da Infra-IA (os `.ps1`/`.md` são cópias idênticas dos rastreados; o `LEIA-ME`
   e os `.bat` são do pacote de instalação no outro PC) **(Recomendado)** · (b) mover a pasta para fora do repo.
4. **Worktrees já integradas ao `main`** (♻ na tabela do §2): parar o dartvm :5000 (PID 18532) e remover `densidade`, `shell`, `setes-app-f2b`,
   `setes-api-f2a`, `setes-api-ib2`, `ib3/*` (4), `ne1b/*` (3) com `git worktree remove` + `git branch -d` (todos 0 à frente do `main`). Não
   remover as que têm trabalho (privilegios, privilegios-catalogo, recuperacao-senha, merchandise, taxrules-ncm, grupo-leitores, cnpj).
5. **Não tocar**: o submódulo `codigo-aprendizado/GestaoERPApps` (sujeira de outro projeto, anterior a esta noite) e os `.dart_tool/*`.

### Fase 1 — Commits e pushes de SALVAGUARDA (com "commita"; nada vai para o `main`)

Objetivo: nenhum trabalho da noite fica só em arquivo solto. Cada commit só com os caminhos da própria tarefa (lição da sessão paralela).

| # | Repo(s) | O quê | Caminhos |
|---|---|---|---|
| 1.1 | setes-sync · sincronizador | commit do patch 11 / D-SY10-11-13 | lista do §10.7 (`verificacao-comissao-margem-mercadoria.md`); FORA: `reset-institution-sync-data.ts`, `Sincronizador.dproj` |
| 1.2 | privilegios-catalogo/{setes-api,setes-app} | commit da cerca D-PV9 | lista do §12.9; FORA: `.dart_tool/*` |
| 1.3 | merchandise/{setes-api,sql} | commit da onda 1 + R4/R5/R6 (estado "pronto, espera decisão") | tudo da worktree (66 + 2); a Q-PR52 pode mudar o PUT de serviços depois — é retrabalho sobre commit, não sobre arquivo solto |
| 1.4 | taxrules-ncm/{setes-api,setes-app} | commit da D-PR13 | 4 + 6 arquivos; FORA: `.dart_tool/*` |
| 1.5 | grupo-leitores/setes-api · cnpj/{4 repos} | `git push -u origin <branch>` (só o branch) | — |

Depois da Fase 1 todo repositório fica com `git status` limpo (fora `.dart_tool`, o pacote e o submódulo).

> **EXECUTADA 2026-10-18 (noite) — Valdo: "Commita: Fase 1 … sem push nem merge; push só das branches grupo-leitores e cnpj"**
> Varredura de segredos nos diffs e nas branches a empurrar: limpa (o único casamento foi uma senha `12345` de fixture de teste na `cnpj`;
> `fiscal-api/src/secret/certificate.ts` é código do núcleo). Mensagens sem acento, no estilo da casa, com os testes da hora do salvamento.
>
> | # | Repo | Commit | Ficou de fora (de outra sessão) |
> |---|---|---|---|
> | 1.1 | setes-sync (`main`) | **edbaad4** `feat(sync): …(D-SY10/D-SY11/D-SY13)` — 20 arquivos | `scripts/reset-institution-sync-data.ts` |
> | 1.1 | sincronizador (`main`) | **b6c6ebe** `feat(sincronia): patch 11 …` — 11 arquivos | `Sincronizador.dproj` |
> | 1.2 | privilegios-catalogo/setes-api | **8b1fe27** `Privilegios D-PV9: cerca … + D-PV15` — 18 arquivos | — |
> | 1.2 | privilegios-catalogo/setes-app | **53a1497** `Privilegios D-PV16: build-web.ps1 …` — 1 arquivo | `.dart_tool/*` |
> | 1.3 | merchandise/setes-api | **2171f20** `Produtos (mercadoria) onda 1 da API + Rodadas 4-6 …` — 66 arquivos (`.env` não entrou) | — |
> | 1.3 | merchandise/sql | **8b8cedf** `Produtos onda 1: seed 66 … espelho da 071 …` — 2 arquivos | — |
> | 1.4 | taxrules-ncm/setes-api | **b651354** `Regra de tributacao D-PR13: NCM … (peca isNcm)` — 4 arquivos | — |
> | 1.4 | taxrules-ncm/setes-app | **ef99e60** `Regra de tributacao D-PR13: NCM … espelho Dart` — 6 arquivos | `.dart_tool/*` |
> | 1.5 | push `-u origin` | `setes-api` grupo-leitores · `cnpj` em setes-api, setes-app, fiscal-api, nfse-api — 5 branches novas no GitHub, 0 à frente | — |
>
> ⚠️ Os commits de `setes-sync` e `sincronizador` estão no `main` LOCAL desses repos (eles não trabalham em branch) — **sem push**, como pedido;
> o push é ato da Fase 4. Nenhum merge em `main` algum do setes-api/app/sql/núcleo/nfse-api.

### Fase 2 — Publicações no setes-api, na ordem que evita conflito

O `setes-api/main` é o ponto de encontro de 6 branches. Ordem pelo tamanho do conflito e pela urgência:

1. ~~Recuperação de senha (`recuperacao-senha`)~~ → **Remoção da recuperação de senha** (`sem-recuperacao-senha`, **D-PV18**) — PRIMEIRO:
   tira do `main` o fluxo inteiro e, com ele, o CRITICAL anterior (sem porta, sem tomada de conta pela colação). Não conflita com
   `privilegios-crud`: na API toca só `auth.{routes,service,repository}.ts`, `mailer.ts` (comentário), `.env.example`,
   `pre-deploy-tz-check.ts` + a cerca nova; no app só `packages/core/src/auth`, `api_client.dart`/`product_token.dart` (comentário e
   `_publicAuthPaths`), i18n `auth.*` e testes. Sem DDL, sem `errors:gen`. Roteiro: "vai" → merge ff da API na árvore viva (`tsx watch`
   recarrega) **e do app**, juntos (o app antigo mostraria "Esqueci minha senha" chamando rota que já não existe) → `flutter run` :5051
   reiniciado → tirar `APP_CHANGE_PASSWORD_URL` do `.env` vivo (gitignored; a var morta é inofensiva) → passeio: login OK, tela de login sem
   o link, `POST /auth/recovery-password` e `/auth/change-password` = 404.
   **Execução 2026-10-18 (noite)**: API **fbf01a3** (tsc limpo; `auth-login` + `auth.middleware` + cerca `no-password-recovery-fence` =
   26/26); app **ad50385** por agente na worktree irmã, conferido no disco e no diff (4 arquivos apagados; bloc sem os 2 eventos, 2 estados,
   usecases e `_recoveryEmail`; `_publicAuthPaths` = login + seleção; link "Esqueci minha senha" fora com o `Row`/`Spacer` que só existiam
   para ele; **18 chaves `auth.*`** sem consumidor removidas em pt/en — inclusive `email`/`emailHint`, que só as telas apagadas usavam; 7
   testes ajustados; cerca Dart provada mordendo). `flutter analyze` limpo nos dois pacotes; `flutter test` core 81/81 · web 634 verdes /
   27 skip pré-existentes / 0 vermelho. O conhecimento negativo **D-F218** (troca de senha não idempotente) perdeu o objeto. **Gate do
   delta do app**: revisão do diff + suíte completa; sem HIGH; ponto aberto único = o comentário da cerca das rotas no `le gate` cita as
   rotas antigas (pasta `test`, fora da varredura — aceito). **Gate do delta da API (socrático 0,80 · adversarial 0,84, sem HIGH)** — pontos abertos:
   (1) senha perdida do SUPER não tem mais saída no produto → **Q-PV54** (Rec.: procedimento documentado do operador, exceção explícita);
   (2) publicar API e app JUNTOS (o app velho na :5051 chamaria 404 — UX, não segurança); (3) `.env` vivo com a var morta; (4) a coluna
   `activation_key` fica sem escritor (dado morto, sem efeito; DROP = decisão de DDL à parte). Provado: 404 nas 2 rotas (jest, roteador
   real), o service exporta só login/selectInstitution/switchInstitution, varredura de `src/`, `scripts/` e `.env.example` sem token do
   fluxo. Analisado: gateway sem lista de rotas públicas (nada a tirar), rate limit indiferente, nfse-api/fiscal-api não conhecem o fluxo.
2. **Grupo — D-GE4** (`grupo-leitores`): "vai" → merge ff na árvore viva (sem DDL; gates 0,78/0,84) → push. Vai ANTES da D-PV2 porque a
   D-PV11 reusou a mesma linha do `admin.repository.ts` (na fusão, "ficar com a peça" `@shared/institution-interfaces`).
3. **Bloco Privilégios** (`privilegios-crud` + `privilegios-catalogo`), uma janela só — roteiro §11.8 (itens 1–7) + §12.7:
   - no branch `privilegios-crud`: executar **3a** (D-PV17 — a interface do botão é a do MÓDULO da tela; navegar entre módulos troca o
     `CurrentInterface`) e, conforme a decisão, **3b**; testes + os dois gates do delta;
   - **fusão** `privilegios-crud` ↔ `privilegios-catalogo`: `error-codes.ts` é SOMA (7 + 3 códigos); **D-PV14** — quem chega por último
     escreve o adaptador que põe `listGatedRoutes()` em `CONSUMED_PRIVILEGES` (a D-PV15 recusa tirar par consumido); registrar na cerca
     `modulePrivilegeGate` + `licensedFor`/`privilegeVerdict`/`denyPrivilege`; **Q-PV53** (vínculo pelo id em `tb_institution_has_interface`)
     toca a peça da D-PV11 — conferir; fusão com `grupo-leitores` (item 2);
   - **app**: merge sobre a450909 com atenção à `RegisterFormPage` (portão = parâmetro + 2 condições); `build-web.ps1 -CheckOnly` tem de
     sair 0 (D-PV16 para a publicação com alarme do catálogo);
   - **implantação**: lista de telas do contrato da Setes (D-PV10; conferir que não há usuário regular vivo) → **seed 65 ANTES do app** →
     `npm run errors:gen` → publicar **API e app JUNTOS** → nfse-api = restart manual (A-PV1);
   - commit leva as sondas dos gates (`adversarial-pv2-gate.test.ts`); limpeza: junções + link do `.env` (`rmdir`).
4. **Grupo — onda 0** (nasce da fusão acima): `adminGuard` da `/api/modules` → `gatedModule('modules', …)` (D-GE20/A-GE2) + D-GE3 (privilégio
   por estabelecimento, `privilegeVerdict` recebe a institution — Q-PV24) + cerca + fixture `two-institutions` (semente). Confira antes se
   `tb_establishment_tax_regime` já existe (D-GE11, pré-requisito da onda 2).

### Fase 3 — Produtos (depende da Rodada 7 e do bloco Privilégios no `main`)

1. **Rodada 7** com o Valdo (§3 item 1). A Q-PR52 decide o contrato do `PUT /api/services/:id`.
2. Executar as decisões na worktree `merchandise`; **rebase sobre o `main` pós-privilégios** — conflitos esperados em `src/gateway/router.ts`
   (`syncWriteGuard` × `gatedModule`), `src/shared/auth/privileges.ts` e `src/shared/errors/error-codes.ts` (soma); merge do `taxrules-ncm`
   (D-PR13) junto; reconferir os números **071/072** e o **seed 66** contra o `main` e TODAS as worktrees (hoje: 64, 65 no `main`; 67 na
   `recuperacao-senha`; 66 só aqui; 071/072 só aqui).
3. **Janela** (§9 do prompt, com "vai"): merge na árvore viva (071/072 rodam no boot em todos os schemas; a 072 não cria nada no dev — só a
   Setes, com chave ativa), `errors:gen`, seed 66, reconciliação pelo checklist do §18.2; trilha P1 com serviço do legado.
4. **Onda 1 do APP** (worktree NOVA a partir do `main` pós-privilégios — a fábrica mudou com `CrudPrivileges`/`RegisterFormShell`): ficha de 3
   abas + painel de vínculos (§10), interruptor da chave do sincronizador na tela de Institutions (D-PR43) e "só consulta" para cliente
   sincronizado (D-PR32). Pode começar em paralelo à Rodada 7; o risco é só a Q-PR52 mudar o PUT de serviços.

### Fase 4 — Grupo do sync (implantação) e o que ele destrava

1. Decidir A-SY1 e Q-SY15…Q-SY23 → rodada executável.
2. Implantação (§10.7): setes-sync no ar (:3001) → **build oficial do patch 11** (Delphi, Valdo) → Preparar o banco com a sincronia ativa e
   a fila vazia → Primeira carga (Categorias, Medidas, Produtos) → prova da D-SY13 (chave inativa = sincronizador INATIVO até Ativar).
3. Respostas que o grupo do sync deve a outras frentes: **Q-SY14** (terminal 0 = origem indistinguível — pedidos da web serão sobrescritos
   pelo legado), **Q-SY12**, o **acordo do CHECK do CNPJ alfanumérico** (destrava a janela do `cnpj`), e a pergunta do guardião da frente de
   debate (N estabelecimentos num Firebird: envio uma vez ou por estabelecimento, sob qual chave?).
4. Com o patch 11 commitado: ondas 2/3 da frente `tb_terminal` ficam liberadas.

### Fase 5 — Frentes em decisão (correm em paralelo, cada uma na sua sessão)

| Frente | Próximo passo | Depende de |
|---|---|---|
| **nfe-api NE-2** | Q-NE160…Q-NE168 uma a uma (§15.8) → E1 (esqueleto) → E2 (DDL da família provado no descartável) → E3…E5 → gates → publicação (Q-NE168); depois Rodada 0 da NE-3 (§15.5) | nada do ERP; se tocar o núcleo, rebase do `cnpj/fiscal-api` cresce |
| **CNPJ alfanumérico** | rebase do `cnpj` (núcleo DIVERGIU em 17 commits da NE-1b; app em 3 da densidade/shell) → janela da onda 1 + R3–R5 pelo §8.5 com a correção do §8.16 (nfse-api restart manual; app `flutter run` :5051; prova em H só em ensaio) → CHECK de forma | retorno do grupo do sync + "vai" |
| **Usuário convidado** | A-UC2/A-UC3 → Q-UC11/23/24 → guardião + PADROES + `revisar-ddl` → DDL em descartável → anotar no prompt de privilégios (Q-PV39 respondida, A-PV13 morta, D-PV12 encolhida) | onda 0 de código só DEPOIS da fusão da `privilegios-crud` (mesmo `users.service.ts`) e coordenada com a `recuperacao-senha` (A-UC2 usa esse sistema) |
| **Terminal + debate** | reconciliar os dois prompts; Rodada 1 decidida → D-TM8… no §9; ajustar DDL rascunho; onda 0/1 (setes-api/app) numa sessão; ondas 2/3 no grupo do sync | onda 0 só com D-PV2 e cerca no `main` (reconferir números 073/68); ondas 2/3 só com patch 11 commitado |
| **Densidade — onda C + grade + passeio** | worktree NOVA do `main`; lista em tabela no desktop (`rowBuilder` → colunas), grade nas ~195 `SetesTextField` das telas de processo/abas/dialogs; passeio logado da onda D (pulado em 18/10). Portas livres do CORS: 5000 e 8080 | nada; evitar correr junto da onda 1 do app de produtos nos mesmos arquivos da fábrica |
| **IBS/CBS — IB-4** | prova em H (instância de ensaio 3307 ou kit `fiscal-api/scripts/ensaio-janela/`): classificar na cópia, faturar, `smoke:adn-h -- --nota <id> --vai`; só depois classificar em produção (um serviço, uma nota) | fisco de H normalizar (E1000); **Q-IB1 até 30/10** |

---

## 5. Regras que valem para todas as fases (relembrar ao abrir cada sessão)

- `D:\Gestao2027\setes-api` roda `tsx watch` = **deploy ao salvar**; nada se edita na árvore viva fora de janela decidida. nfse-api de
  "produção" roda SEM watch (restart manual). O "produção" de hoje é a máquina do Valdo (dev/ensaio); só o ambiente de produção do FISCO é real.
- Commit, push, seed, migration e merge só com o "vai"/"commita" do Valdo; `git add` só dos caminhos da tarefa (sessões paralelas no mesmo repo).
- Banco: só sessão `READ ONLY` fora de janela; DDL provado antes em schema descartável.
- Frente TRANSVERSAL diz isso de saída (grupo, convidado, terminal, CNPJ, privilégios).
- Fronteira dos grupos: tarefa do setes-api/app/fiscal NÃO lê setes-sync nem sincronizador, e vice-versa (a frente de debate do terminal é a
  exceção registrada: o objeto dela É a fronteira).
- Gates (socrático ≥ 0,70 + adversarial sem HIGH/CRITICAL) em cada delta antes de dar por pronto; achado que exige decisão vira questão numerada.
- Ao fechar cada etapa deste plano: atualizar o prompt da frente, `INDICE_CENTRAL.md`, `CLAUDE.md` da raiz e a memória (skill
  `atualizar-infra-ia`). Quando todas as fases estiverem cumpridas, este arquivo vai para `HISTORICO/`.

## 6. Prompts curtos (colar na sessão certa)

- Sync: "Retomar o grupo do sync pelo §10.7 do `setes-sync/verificacao-comissao-margem-mercadoria.md`" (+ "commita").
- Cerca: "Retome a cerca da D-PV9 pelo §12.9 do `prompts/prompt_privilegios_interfaces.md`" (com as respostas A-PV12, A-PV14, Q-PV19, Q-PV50…53).
- Onda D-PV2: "Retome a onda da D-PV2 pelo §11.8.1 do `prompt_privilegios_interfaces.md`" (3a/3b + lista de telas da Setes).
- ~~Recuperação de senha~~ → Remoção (D-PV18): branch `sem-recuperacao-senha`; o que fica do assunto está na nota SUPERADA do §13 do
  `prompt_privilegios_interfaces.md`; decisões pendentes Q-PV54 (lá) e Q-UC25 (`prompt_frente_usuario_convidado.md` §11).
- Grupo: "Retome a frente do grupo de estabelecimentos pelo `prompt_frente_grupo_estabelecimentos.md`" (§10: "vai" da D-GE4 + onda 0).
- Produtos: "Retome a frente de produtos pelo §9 do `prompt_modulo_products.md`" (Rodada 7).
- nfe-api: "Retome a NE-2 pelo §15.8 do `prompt_onda_nfe_sefaz.md`, pela Q-NE160".
- Convidado: §11 do `prompt_frente_usuario_convidado.md`. Terminal: §8 do `prompt_frente_terminal.md` + §9 do `prompt_frente_terminal_grupo_pdv.md`.
- CNPJ: §9 do `prompt_frente_cnpj_alfanumerico.md`. Densidade: §6 do `prompt_densidade_layout_web.md`. IBS/CBS: §13.8 do `prompt_fase_ibs_cbs.md`.

## 7. Rodada de decisões 2026-10-20 — o que mudou neste plano

- **Recuperação de senha**: a D-PV18 foi REVOGADA (D-PV47). A branch `recuperacao-senha` (api d19de9d · sql e1aa574) NUNCA tinha sido
  apagada de fato e volta a ser o item 1 da Fase 2 (roteiro §13.8 do prompt de privilégios: sql/67 ANTES e DEPOIS do merge; + SMTP real no
  `.env` — D-RS4/D-RS5). A branch `sem-recuperacao-senha` (api fbf01a3 · app ad50385) é DESCARTADA: remover as worktrees
  `sem-recuperacao/{setes-api,setes-app}` e as branches locais (ato operacional, com "vai").
- **Bloco privilégios** cresceu: antes da fusão/janela a branch `privilegios-crud` executa D-PV19…D-PV39 (3b, CONFIGURAR, CONSULTAR,
  rotas fora da guarda, cache do veredito, papel da própria empresa, grava por marca…) com gates; seed **68** (CONFIGURAR/CONSULTAR);
  D-PV33 (trilha `_event`) e D-PV43 (UNIQUE da `i18n_key`) são entregas de DDL DEPOIS da janela; D-PV46 (script do Super) entrega pequena.
- **Produtos**: a Rodada 6 da branch `merchandise` é REFEITA sobre D-PR47/D-PR48/D-PR49/D-PR52 (coluna `catalog_source` com o guardião;
  `catalogOwnerGuard`; ato "encerrar a transição"; sem religar); Q-PR52 destravada (D-PR45). Q-SY24 ao grupo do sync (conferência).
- **Novas ondas de código na fila** (cada uma em sessão própria, depois dos merges acima): terminal onda 0 (D-TM8…D-TM22; literais só após
  `privilegios-crud` + `merchandise` no `main`), convidado onda 0 (D-UC6…D-UC12; mesmo `users.service.ts`), prompt de endurecer a
  autenticação (D-RS5), regra de tributação por cliente (D-PV30), NE-2 em `ne2/` (D-NE160…D-NE168).
- **Ordem de merge revista**: `recuperacao-senha` → `grupo-leitores` → bloco privilégios → onda 0 do grupo → produtos + `taxrules-ncm` →
  terminal onda 0 → convidado onda 0. Q-IB1 em aberto (30/10).
