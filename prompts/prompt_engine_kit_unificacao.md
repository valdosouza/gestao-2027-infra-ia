# Frente — Unificação do engine-kit (método portável a partir dos dois casos)

**Escopo**: misto (o plano, o mapa de técnicas e as regras de destilação são método; as evidências citadas por caminho são dos dois casos)
**Origem**: pedido do Valdo em 2026-10-20: "utilizar tudo que aprendemos no C:\Vault e no gestao-2027-infra-ia, pegar as melhores técnicas, fazer um merge de tudo e atualizar o engine-kit com as técnicas genéricas para serem aplicadas em outro projeto, seja um legado ou um projeto do zero".
**Aberto em**: 2026-10-20. **Casa do kit desde 2026-10-28**: `engine-kit/` deste repo (D-EK32, revê a D-EK1). **Estado**: Rodada 0 DECIDIDA em 2026-10-21 (D-EK1…D-EK9 = todas as Rec., §14). Fase 1 CONCLUÍDA LOCALMENTE (§15; kit canônico `C:\RAG\engine-kit-canonical` 0.7.0, lint 0/0, plugin validado e instalado). O push para o GitHub aguarda o "vai". Mapa ampliado para T01–T96: bloco M9 dos agentes de construção (D-EK10) e auditoria de `C:\Vault\AI` e das tools (§16). **⏯ Retomar pelo §13.**
**Regra dos dois grupos**: o Vault (caso Softworks) foi só LIDO. Toda mudança nele acontece em sessão própria, sob a governança dele (decisões `VAULT#N`, SVN). Nada de conteúdo de caso entra no kit: só o método destilado.
**Base do inventário**: este repo em `f4b1ada`; `C:\Vault` no estado de 2026-10-20; `C:\RAG\engine-kit` e `C:\RAG\engine-runtime` (sem git, última mudança em 2026-08-21).

---

## 1. O pedido e o que já está decidido (herdado, não se rediscute aqui)

- A engine é **método + base de conhecimento**, não um modelo treinado. O modelo é peça trocável (`rascunho_engine_modernizacao.md` §1).
- **O conteúdo de um caso nunca cruza empresas; só o método viaja.** O `misto` é destilado sob demanda (§2.1 do diário).
- A arquitetura tem 3 camadas: **método**, **runtime portável** e **caso** (`VAULT#2`, `C:\Vault\ecosystem\UserGuide\Engine-Kit-Unification-Blueprint.md`).
- O humano fica no comando: a IA organiza, evidencia e sugere; o dono decide; cada decisão é numerada e permanente.
- O formato é o de plugin do Claude Code (kit v0.3 deste repo, adotado do harness-kit).

## 2. Fatos

| # | Fato | Evidência |
|---|---|---|
| F1 | Existem **três cópias divergentes** do kit. **A** fica em `C:\RAG\engine-kit` (PT, v0.6, 2026-08-21). **B** é `engine-kit/` deste repo (EN, plugin, README v0.4 de 2026-09-04). **C** é `C:\RAG\engine-runtime` (v0.2/0.3). A é a v0.2 de B; elas se separaram em 2026-07-25 | diff das cópias; commit `501b5e2` |
| F2 | "v0.3" e "v0.4" significam coisas diferentes em A e em B. O `plugin.json` de B diz 0.3.0 e o README diz 0.4 | `engine-kit/.claude-plugin/plugin.json` |
| F3 | **A e C não estão em git.** Hoje a perda de um disco apaga o runtime e a skill de memória | `git -C C:\RAG\engine-kit` → erro |
| F4 | A tem o que B não tem: `engenharia-de-memoria` (5 classes, schema episódico, os dois loops, pipeline gate), a `PROPOSTA_UNIFICACAO` e o guia de secrets completo | `C:\RAG\engine-kit\skills\`, `seguranca-git\` |
| F5 | B tem o que A não tem: as 14 lições de legado em `assess-legacy-repo`, o agente `legacy-analyst`, o passo 0 da Rodada 0 (decisões vigentes + fato × intenção) e o formato de plugin | `engine-kit/skills/assess-legacy-repo/SKILL.md` |
| F6 | O Vault evoluiu dois meses depois do kit, sem destilar nada de volta. Ficaram de fora: cards atômicos, consolidação, fechamento único com `close-task.ps1`, Code Gate com os modos plan/SDD/TDD, gate de teste por baseline, prepare-only no harness, guardas de encoding e de reversão, adaptadores finos e registros por projeto | `C:\Vault\AI\Skills\`, `AI\Tools\`, `DECISIONS.md` (85 decisões) |
| F7 | Este repo também evoluiu depois da v0.4 sem levar nada ao kit. Ficaram de fora: o protocolo do prompt de frente, salvamento/retomada, o livro de premissas com o "vai", a worktree por frente, as cercas, os gates de entrega, a prova descartável, o arquivo de fonte oficial e os princípios de direção da migração | `prompts/prompt_privilegios_interfaces.md`, `skills-genericas/` |
| F8 | As ferramentas do Vault são descendentes mais novas das do runtime C: `validate-registry.ps1` de 10-20 e `memory_index.py` de 10-05, este com cards e dimensão de projeto | `C:\Vault\AI\Tools\Validation`, `AI\Tools\Memory\SOURCE.md` |
| F9 | As skills que o Vault executa são as dele (`~\.claude\skills\*` são junções para `C:\Vault\AI\Skills`). Nenhum plugin do kit está instalado em lugar nenhum | `C:\Users\fsouza\.claude\skills`, `plugins\` |
| F10 | Há vazamento de caso dentro das cópias do kit. Em A e B aparecem "Softworks", "setes", "Delphi/Firebird ERP case", `*.pas`, `svn propget` e "ERP multi-tenant". Em C aparecem `W:\vaults`, `G_Foo`, `ABSENCE` e o layout de versões do Vault | relatório do diff (lista no §7.3) |
| F11 | O kit só cobre **legado**. Não existe trilha para um projeto do zero | `engine-kit/INSTALLATION.md` |
| F12 | O kit é quase só prosa. O enforcement (hooks, scripts, permissões "ask") existe só nos casos | `C:\Vault\.claude\settings.json`; `C:\Users\fsouza\.claude\scripts\` |
| F13 | O inventário de 2026-10-20 deixou de fora seis agentes que CONSTROEM a base do caso W: curador do mapa, construtor de pipelines, mapeador de configurações, escritor de docs, analista de build e importador. Só a regra (T27) ou a escada (T63) tinham entrado. Achado do Valdo em 2026-10-21; corrigido no bloco M9 (T64–T73) e numa auditoria arquivo a arquivo de `C:\Vault\AI` (§16) | `C:\Vault\AI\Agent\` |

### 2.1 Achados objetivos (corrigir ≠ decidir)

| # | Achado | Correção |
|---|---|---|
| C1 | `RELATORIO_DADOS_SENSIVEIS.md` é rastreado e publicado em `github.com/valdosouza/gestao-2027-infra-ia`. Ele traz **3 chaves de API do Google literais** (linhas 27, 28 e 40) | **Do Valdo:** girar ou restringir as chaves no console. Depois, trocar os valores por `<REDACTED>` e, se o repo for público, avaliar a reescrita do histórico (BFG) |
| C2 | A regra `.gitignore:52 *secret*` impede que o guia de secrets do próprio kit seja versionado. `references/README.md` cita um `SECRETS_PROTECTION_SETUP.md` que não existe | Exceção cirúrgica no `.gitignore` (como a da linha 176) ao trazer o guia de A |
| C3 | `plugin.json` diz 0.3.0 e o README diz 0.4 | Uma fonte de versão, checada pelo `kit-lint` (§5.4) |
| C4 | `INDICE_CENTRAL.md` linha 28 diz "engine-kit v0.1" | Atualizar na Fase 4a |
| C5 | A skill `knowledge-retention` do Vault diz que o diário fica em `C:\RAG\engine-kit`, mas ele fica neste repo | Corrigir no Vault, em sessão própria (Fase 4b) |
| C6 | Rótulos de escopo errados. No Vault, `archive-card` e `feedback-analyst` estão como `method` mas têm conteúdo do caso. `skills-genericas/guardiao-conceitual.md` está como `metodo` mas cita tabelas e decisões da Setes | Reclassificar como `misto`. A versão de método nasce no kit |

## 3. Mapa de técnicas: o merge

> **Casa do mapa desde 2026-10-21**: `docs/techniques.csv` do kit (em inglês e neutro), que gera `docs/TECHNIQUES.md` e é checado pelo `kit-lint` (check 7). As tabelas deste §3 e do anexo ficam como espelho histórico; técnica nova entra primeiro no CSV do kit.

**Fontes**: S = este repo (caso Setes) · W = `C:\Vault` (caso Softworks) · K = cópias do kit (A/B/C).
**Maturidade** (auditoria de honestidade, sem promoção silenciosa):
- **2c**: operando em 2 casos.
- **1c**: operando em 1 caso, com evidência.
- **papel**: desenhado e nunca usado.

**Ação**:
- **importar**: já está neutra.
- **fundir**: há duas ou mais versões.
- **destilar**: tirar o caso.
- **candidata**: entra rotulada e opcional (Q-EK7).
- **desenho**: entra como proposta.

### M0 — O vaso (base de conhecimento)

| # | Técnica (nome neutro) | Regra em uma frase | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T01 | Regras raiz neutras + adaptadores finos | `AGENTS.md` é a verdade; `CLAUDE.md`, `.cursorrules` e copilot só apontam para ele | W `AGENTS.md`, `AI\EditorAdapters.md`; C template | 1c | destilar |
| T02 | Modelo de área de domínio | Cada área tem INDEX / PIPELINES / RULES / MEMORY / KNOWLEDGE / TICKETS; o código fica no projeto e o conhecimento no espelho | W Subject Model; S `ORGANIZACAO_PASTAS.md` | 2c | fundir |
| T03 | Colocação mecânica | Uma fórmula de caminho mais uma tabela de decisão definem onde cada arquivo entra; "não pergunte, crie" | W `projects_check.py`; S `ORGANIZACAO_PASTAS.md` | 2c | fundir |
| T04 | Índice é mapa, histórico é changelog | Índices são gerados e nunca editados à mão; têm orçamento de tamanho; o histórico vai para `CHANGELOG` | W `ledger_gen.py`, `decisions_index.py`; S (dor: índice de 301 KB) | 2c | destilar + lint |
| T05 | Validador registro × realidade | Uma linha de registro que contradiz o disco é bug | W `validate-registry.ps1` (mais novo que o de C) | 1c | importar W, parametrizar |
| T06 | Censo de escopo + SUPERSEDED | Toda doc tem uma linha de escopo; nada se apaga, ganha ponteiro | K A/B; W; S | 2c | fundir (token único, Q-EK2) |
| T07 | Grafo como instrumento | Consultar o grafo antes de ler código. Carimbar a defasagem. Validar god nodes contra uma verdade conhecida. Resolver nomes escopado ao corpus. Não rotular comunidades por LLM | W `AGENTS.md`; S diário 09-02 | 2c | fundir |
| T08 | Onboarding pela pergunta aberta | Um `<AREA>_KNOWLEDGE.md` com STATUS; o teste é uma pergunta simples | W `Lightweight-AI-Onboarding-Pattern` | 1c | candidata |

### M1 — Avaliar o legado (trilha legado)

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T09 | Avaliação fiel + 14 lições + `legacy-analyst` | Fotografia, não reforma; `arquivo:linha` em todo fato | K B | 1c | base do módulo |
| T10 | Doc legado é insumo, nunca verdade | Afirmação legada entra como hipótese até o código confirmar; nem a verificação do dono a promove | W `VAULT#27`; K B lição 14 | 2c | fundir |
| T11 | Leitura por agentes + re-checagem determinística | Os agentes fotografam e um script ou o grafo re-verifica. O condutor renumera colisões com uma tabela de-para. O brief do subagente fica salvo como molde | S `nfe-api/referencia-acbr/` | 1c | candidata |
| T12 | Conhecimento negativo | Toda onda registra o que não fazer e os limites aceitos | S (17 arquivos); W anti-patch | 2c | fundir |
| T13 | Arquivo de fonte oficial | SHA-256 + `.txt` ao lado. Cada conferência fecha como CONFIRMA, AJUSTA, DERRUBA ou NÃO OFICIAL, com página e linha. O formato do documento também é fonte de erro | S `nfe-api/integracoes/nfe-sefaz/CONFERENCIAS.md`, `riscados.py` | 1c | candidata |
| T14 | Direção da migração | O legado se adapta, nunca o destino. A chave de negócio reindexa; sem ela, o destino gera um UUID e devolve ao legado. Estado legado = evento espelho. Um 409 `*_NOT_SYNCED` auto-cura a ordem | S diário 07-19 | 1c | candidata (perfil legado) |
| T15 | Regras como dados | Catálogo estruturado → docs gerados. O catálogo é índice para escolher, não semente para implementar inteira | S `Gestao2016/`; K B | 1c | importar |
| T16 | Processo inverso + tabela de irmãos | Mapear o inverso antes de trocar de domínio; um processo irmão se documenta por diferenças | K B | 1c | importar |

### M1g — Enquadrar o projeto do zero (trilha nova)

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T17 | Rascunho → rodadas → prompt fechado | Organizar o rascunho como está, com marcas ⚠️ e varredura de resíduos; os ids de decisão são citados no código | S `skills-genericas/refinar-prompt-arquitetura.md`; W `decision-rounds` | 2c | fundir |
| T18 | Pipeline de requisitos | RF / RNF / BR, Given/When/Then e cenários TC-P/N/B/R a partir do documento, sem ler código | W `cr-requirements-analysis` | 1c | destilar |
| T19 | Validação × mensagem × decisão | Validação julga, mensagem comunica, decisão devolve a escolha; envelope `{error, code, ref, fields[]}`; o catálogo gera a tabela | S `skills-genericas/mensagem-e-validacao.md` | 1c | candidata (padrão de produto) |

### M2 — Conceituar

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T20 | Guardião conceitual | Teste da maquete e fato gerador. Tabela de **palavras ocupadas**. Padrões: natureza por presença × processo por ato; voz do terceiro × efeito nosso; peça ciente de transação. Uma decisão com condição vira item de entrega | K A/B; W; S `skills-genericas/guardiao-conceitual.md` (neutralizar) | 2c | fundir |

### M3 — Decidir

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T21 | Rodadas de decisão | Passo 0: decisões vigentes e fato × intenção. Cada questão tem evidência, opções fechadas e UMA Rec. A divergência fica registrada com as palavras do dono | K B; W; S | 2c | fundir |
| T22 | Ids por namespace + índice gerado | `KEY#N` ≡ `D-PV2`; faixas reservadas para sessões paralelas; nunca renumerar | W `DECISIONS.md`, `decisions_index.py`; S (808 ids) | 2c | fundir (Q-EK4) |
| T23 | Livro de premissas + palavra de liberação | Seguir a Rec. como A-n a ratificar. Nada é commitado, publicado, semeado ou implantado sem o "vai" | S (16 arquivos) | 1c | fundir com T29 |
| T24 | Regras de negócio "Stay" | Um arquivo por regra, com histórico Autorizado/Negado append-only; o agente para no Negado | W `VAULT#72–75` | 1c | candidata |
| T25 | Pessoas não são papéis | Nunca inferir papel a partir de um campo do tracker | W `VAULT#56` | 1c | importar (template AGENTS) |

### M4 — Executar a mudança

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T26 | Prompt de frente como especificação viva | Cabeçalho + 12 seções + blocos por onda; **com orçamento**: cada onda executada vai para um anexo | S (~25 prompts) | 1c forte | template |
| T27 | Pipeline Gate | Não desenhar correção sobre processo não mapeado | W `VAULT#11` | 1c | importar |
| T28 | Code Gate + passagem única | PLAN, SPEC ou teste vermelho primeiro. Frase STOP literal. O "go" fica no WORKLOG. Cada arquivo é escrito uma vez. Modos plan/SDD/TDD | W `AI\Orchestration\change-workflow.md` | 1c | destilar (1 skill, 3 modos) |
| T29 | Prepare-only para o irreversível | O agente prepara commit, merge, deploy e escrita no tracker; o humano executa. A lista "ask" do harness garante isso. Banco em READ ONLY. O agente nunca digita senha | W `governance-workflow.md`, hotfix; S | 2c | fundir |
| T30 | Salvamento e retomada | Registrar worktree, branch e hashes, o estado verificado, os passos restantes, os próximos ids livres e um prompt curto colável. O checkpoint leva só os hunks da frente | S (18 arquivos) | 1c forte | importar |
| T31 | Worktree por frente | A árvore viva é produção. Verde certifica uma combinação de checkouts. O último a chegar na main escreve o adaptador | S `prompt_privilegios_interfaces.md` §11–12 | 1c | destilar |
| T32 | Partição de propriedade | O código de outro grupo é lido só pelo nome; a necessidade vira pedido no doc do grupo | S (21 arquivos) | 1c | importar |
| T33 | Prova descartável + janela de corte | Schema descartável: contar → rodar de novo, idempotente → a variante impossível falha alto. Seeds pela chave natural. Runbook com critério de entrada e aborto, ensaiado com hosts bloqueados | S `fiscal-api/scripts/ensaio-janela/` | 1c | destilar |
| T34 | Anti-patch | Silenciar um crash é achado, não correção | W `AGENTS.md` | 1c | importar |
| T35 | Deriva entre versões ativas | Comparar a unidade em cada branch ativo antes de planejar | W | 1c | candidata (multi-branch) |
| T36 | Intake compartilhado | Reusar o dossiê da semana; consumir em vez de buscar de novo | W `vso-ticket-analysis` | 1c | candidata |

### M5 — Verificar

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T37 | Plano de teste obrigatório | Vermelho primeiro, com log; `exempt: motivo` é uma linha escrita, nunca silêncio | W `VAULT#78` | 1c | importar |
| T38 | Gate por diff de baseline | Bloqueia só falha nova. A pré-existente é registrada. "Não rodou aqui" não é falha. O rollout começa em warn-only | W `VAULT#80/83`, `cwtest.ps1` | 1c | princípio core, ferramenta candidata |
| T39 | Gates de entrega | Socrático ≥ 0,70. Adversarial sem HIGH/CRITICAL. Cada achado vira sonda permanente: [RESISTIU], [CORRIGIDO] ou [DECIDIDO] (`it.failing`). Passeio logado do dono | S `skills-genericas/revisar-riscos-sistemicos.md`, `testar-adversarial.md` (50 arquivos) | 1c forte | destilar |
| T40 | Cercas | Para uma invariante que deriva em silêncio: lista única + scanner estático + teste vivo read-only + alarme de boot + publish que para + recusa 409 | S `prompt_privilegios_interfaces.md` §12 | 1c | destilar |
| T41 | Verificação em browser | Spec agnóstica; relatório PASS/FAIL com valores literais; login sempre humano | W `web-test-agent` | 1c | destilar |
| T42 | Revisão do resultado | Revisar o resultado, nunca uma revisão isolada; handshake open → acknowledged → resolved | W `code-review-workflow.md` | 1c | importar |
| T43 | Teste de saída / dry run | Provar o processo num item real antes de declará-lo pronto | W `VAULT#81` | 1c | importar |
| T44 | Teste incremental por níveis de dependência | Tabela por tabela, para no primeiro erro; reset só com aprovação | S `RESUMO-SISTEMA-TESTES-SINCRONIZADOR.md` | papel | desenho |

### M6 — Fechar e reter

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T45 | Fechamento único + script | Um só fechador: texto do tracker + log + decisão de card + checagens mecânicas | W `ad-finalization`, `close-task.ps1` | 1c | destilar (tracker plugável) |
| T46 | Cadeia de retenção | Teste de retenção → destino → índice → regras → memória → SUPERSEDED, na mesma tarefa | K A/B; W; S `atualizar-infra-ia.md` | 2c | fundir |
| T47 | Log episódico com claims + memória antes/depois | Claims fact/inference/hypothesis com confiança e evidência; flag `consolidated` | K A; W (299 logs) | 1c | fundir |
| T48 | Ciclos de consolidação | A partir de 5 logs: sobreviventes, cadeias, becos e contradições; nada se apaga | W `memory-consolidation` (6 ciclos) | 1c | importar |
| T49 | Cards atômicos | Uma regra por arquivo; só fato ≥ 0,8; reforçar em vez de duplicar; proveniência neutra quanto ao VCS | W `archive-card` (210 cards) | 1c | destilar (tirar `svn_*`) |
| T50 | Índice de memória derivado | SQLite FTS5 reconstruível a partir dos `.md` | W `memory_index.py` | 1c | runtime |
| T51 | Diário do produto + prazo de lição | Um insight por linha, append-only. A lição vai ao kit em até 1 sessão. O prompt mestre se auto-melhora (STATUS/LEARNINGS) | S diário; `PROMPT-GESTAO2016-KNOWLEDGE.md` | 1c | importar |

### M7 — Higiene e guardas

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T52 | Pacote git-security | Formato de B + o guia de secrets de A; corrigir C2 | K A/B | 2c | fundir |
| T53 | Relatório de dados sensíveis | Tabela tipo / local / linha / risco + plano. **Nunca o valor** (C1) | S | 1c | template |
| T54 | Guarda de encoding | Política de charset configurável. Hook pós-edit e pré-commit. Acusa hunks que mudam só o charset | W `encoding-guard.ps1` | 1c | candidata (svn → git) |
| T55 | Guarda de reversão | Alertar quando a mudança local remove linhas commitadas há pouco | W `~\.claude\scripts\revert-guard.ps1` | 1c | candidata |
| T56 | Config MCP por ambiente | O canônico é versionado e a ativação local não. O merge faz backup. Segredos ficam como `<CONFIGURE>` | W `VAULT#57/69/76` | 1c | importar |
| T57 | Agente de setup de ambiente | Perfis; cada bloco checa antes e roda só o que falta | W `env-setup` | 1c | candidata |

### M8 — Autoaperfeiçoamento e autoria

| # | Técnica | Regra | Fontes | Mat. | Ação |
|---|---|---|---|---|---|
| T58 | Analista de feedback | Minera os logs e propõe edições nos agentes; um humano aprova | W, C | papel (0 relatórios) | desenho (reescrever para ler claims) |
| T59 | `evaluate-harness` | Trace por sessão → score → Pareto → promover ou rejeitar por dados | S diário 08-03 | papel | desenho |
| T60 | Auditoria de honestidade | Todo status diz "operando" ou "desenho" | W `AI-Engine-2026-08-24.md` | 1c | core (aplica-se ao próprio kit) |
| T61 | Merge adoção-primeiro | Aposentar só com contraparte. Migrar por script, com dry-run. Não "consertar" conteúdo durante a migração | W `Vault-Engine-Merge-Plan`, `migrate_engine.py` | 1c | core (rege ESTA frente) |
| T62 | Guia de autoria agente × skill | Agente = julgamento; skill = procedimento; seções obrigatórias; menos de 500 linhas | W `AGENT-FRAMEWORK.md`, `SKILL-FRAMEWORK.md` | 1c | destilar |
| T63 | Escada de abstração da documentação | Um manifesto; níveis por profundidade; status fixos | W `abstraction-ladder-docs` | 1c | candidata (Onda 1, junto com T64–T66) |

### M9 — Construção do ecossistema de conhecimento (incluído em 2026-10-21, D-EK10)

Estes são os agentes que **constroem e mantêm** a base de conhecimento, não os que mudam o código. O inventário original deixou de fora seis deles (F13); o Valdo apontou a lacuna.

| # | Técnica (nome neutro) | Regra em uma frase | Fontes | Mat. | Ação · Onda |
|---|---|---|---|---|---|
| T64 | Curador do mapa do ecossistema | O spec/manifesto é a fonte e o HTML é descartável. **Modo A** (gerador por manifesto) para nível sem versão feita à mão; **modo B** (estender) quando já existe uma página aprovada, que nunca passa pelo gerador genérico. Diagrama antes de prosa enquanto o assunto se decompõe. Toda página abaixo do topo tem back-link. Layout auto-ajustado (declarar linha, não pixel). Paridade só depois de comparar com o aprovado. Uma nova caixa no topo é decisão, não conteúdo | W `AI\Agent\ecosystem-map-curator.md` + `abstraction-ladder-docs` (`generator.py`, `extend_handauthored.py`); 11 manifestos/specs | 1c | destilar o agente + scripts em `runtime/ladder/` · **Onda 1** |
| T65 | Grafo da árvore de abstração | Um grafo derivado e legível por máquina de toda a árvore (diagramas, caixas, folhas, fonte de registro, palavras-chave), para os agentes navegarem por ele em vez de seguir hrefs. Nunca editado à mão; grafo velho = registro velho | W `tree_index.py` | 1c | candidata, `runtime/ladder/` · **Onda 1** |
| T66 | Catálogo de agentes e skills gerado | O catálogo é regenerado dos arquivos REAIS de agentes e skills, nunca mantido à mão. Acusa a skill que existe só na máquina local e não na base: lacuna a resolver, não ruído | W `catalog_gen.py` | 1c | importar; serve também ao próprio kit (o README passa a ter a tabela de skills gerada) · **Onda 1** |
| T67 | Mapeador de configurações | Conta como setting: propriedade de configuração, chave de INI/ENV, flag lida do banco e **flag fixa no código** (setting congelada na compilação, marcada à parte). Verificar o alcance (código morto, compilação condicional inativa). Registro com status e coluna de áreas; a flag que cruza áreas é marcada. Roda antes de qualquer mapeamento de pipeline | W `settings-mapper` (6 registros) | 1c | destilar (padrões de busca viram parâmetro da stack) · **Onda 4** |
| T68 | Construtor de pipelines | Pipeline = sequência disparada por um conjunto de settings. Antes de mapear, perguntar quais settings estão ativas no ambiente investigado. Um doc por área + condição (`PIPE_<AREA>_<CONDICAO>`). Análise de colisão (primeiro vence, último vence, erro, sobrescrita silenciosa). Consultar a camada mesclada (base + sobreposições = o que roda de fato) e checar o frescor do grafo. É o agente que satisfaz o Pipeline Gate (T27) | W `pipeline-builder` (94 pipelines) | 1c | destilar · **Onda 4** |
| T69 | Escritor único de documentação | Um só agente escreve docs de unidade. O template sai do TIPO da unidade, que é parâmetro do caso. Ao atualizar, validar as seções obrigatórias e reescrever só o que mudou. Um doc de dados documenta UMA tabela; as relacionadas são citadas, nunca descritas. Verificar antes de linkar. Não especular (nota explícita). Modo QA: sintoma → causa → solução → passos de verificação | W `docs-writer` + `cw-docs-*` | 1c | destilar (o roteamento por tipo vira tabela do caso) · **Onda 2** |
| T70 | Analista de build | O build é registrado como dado (projeto → comando) e a saída fica fora da cópia de trabalho. "Compilou com avisos" não é verde: cada aviso arriscado vira achado com `arquivo:linha` e correção real, nunca silenciado por diretiva. O relatório fica arquivado no ticket | W `build-analyst` (15 relatórios) | 1c | candidata (stacks compiladas; compilador plugável) · **Onda 2** |
| T71 | Importador de pastas de trabalho locais | Portão de backup confirmado. A primeira pasta é SEMPRE supervisionada. Deduplicar contra a base, curar o reutilizável, versionar só aquela pasta, apagar o local só depois. Fila manual para o ambíguo, com decisão humana | W `legacy-ticket-importer` + skill | 1c | candidata (entrada de acervo disperso, trilha legado) · **Onda 4** |
| T72 | Bloco de governança padrão em todo agente | Todo agente termina com o mesmo bloco obrigatório: linha de Scope, guardião antes de objeto de domínio, rodadas para decisões, cadeia de retenção na mesma tarefa, prepare-only para o irreversível | W (Blueprint passo 3: os 20 agentes) | 1c | template `templates/AGENT.template.md` + `AUTHORING.md` · **Onda 1** |
| T73 | Fábrica por moldes | Duas peças escritas à mão viram MOLDES. Agentes paralelos geram as demais a partir do molde + o esquema REAL + regras inegociáveis. Reescrever guiado pelo esquema > traduzir o código antigo: todos os agentes acharam código legado quebrado contra o DDL real | S diário 07-19; `setes-api/skills/novo-modulo.md`, `setes-app/skills/criar-formulario-cadastro.md`, agente form-builder (o equivalente "construção" do caso Setes) | 1c | destilar · **Onda 2** |

Também mudam duas técnicas já mapeadas:
- **T35** (deriva entre versões) ganha o agente que a executa: o diff por pipeline entre duas versões (adicionados, removidos, alterados, settings, notas de migração), vindo de W `version-diff`. Continua candidata e vai para a Onda 4.
- **T57** (setup de ambiente) continua candidata e vai para a Onda 1, junto com o vaso.

### 3.1 Contradições entre as cópias e a resolução proposta

| # | Contradição | Resolução |
|---|---|---|
| X1 | Onde vivem as decisões: na seção do prompt de frente (A/B/S) ou em `DECISIONS.md` por projeto (C/W)? | Q-EK4 |
| X2 | A Rec. é obrigatória (B) ou só "quando houver" (W)? | Sempre UMA Rec.; se for neutra, dizer que é neutra e por quê (A-EK1) |
| X3 | Artefatos gerados ficam fora da base (C) ou versionados dentro (W)? | Q-EK5 (perfil solo × equipe) |
| X4 | Sync de skills por cópia com precedência (C) ou por junção (W)? | O plugin é o mecanismo primário; junção só para outras ferramentas; a precedência kit < projeto < caso continua |
| X5 | Token de escopo: `Escopo` (A) ou `Scope` (W)? | Q-EK2 |
| X6 | Arquivo raiz: `CLAUDE.md` + índice (A/B) ou `AGENTS.md` + adaptadores (C/W)? | `AGENTS.md` é a verdade e os outros são adaptadores (T01) |
| X7 | Formato da memória: marcadores `CORRECTION:` (C) ou claims YAML (A/W)? | Claims YAML. Os marcadores viram um tipo de claim. O analista de feedback é reescrito |
| X8 | O diário do produto fica neste repo ou em A? | `JOURNAL.md` dentro do kit (só método). O rascunho daqui ganha um ponteiro |
| X9 | A memória semântica mora no INDEX e nos pipelines (A) ou em cards (W)? | Cards são a camada primária; INDEX e pipelines são o mapa |

## 4. Parecer do guardião conceitual (aplicado ao próprio kit)

- **O kit não pode ser maquete de nenhum dos dois casos.** No teste, cada skill tem que dizer o seu fato gerador sem nomear o caso. Uma regra que só existe por causa de uma ferramenta do caso (SVN, Delphi, tracker específico) fica no caso, e o kit expõe um **ponto de extensão**. Exemplo: o "tracker" é plugável no fechamento.
- **Uma peça por conceito.** O Vault tem três agentes orquestradores (plan / SDD / TDD) para preservar hábitos de desenvolvedores, que é um motivo do caso. No kit isso vira **uma** skill de Code Gate com três modos.
- **O protocolo do prompt de frente (S) e o Code Gate (W) são o mesmo conceito em escalas diferentes.** A frente é o épico com rodadas e o ticket é a unidade com PLAN, STOP e go. Os dois entram como **um ciclo em dois níveis**, não como duas peças concorrentes.
- **A tabela de palavras ocupadas é método; as palavras são conteúdo.** O kit leva a tabela vazia com o protocolo de consulta.

## 5. Desenho-alvo

### 5.1 Estrutura do repositório único

```
engine-kit/                         (casa canônica: Q-EK1)
├── .claude-plugin/plugin.json      (versão única, checada pelo kit-lint)
├── README.md · CHANGELOG.md · JOURNAL.md (diário do produto, só método)
├── AGENTS.md                       (regras para quem edita o kit)
├── skills/<nome>/SKILL.md          Camada 1: método
├── agents/<nome>.md                Camada 1: personas de julgamento
├── templates/                      AGENTS.md, DECISIONS.md, prompt de frente, PLAN, SPEC, WORKLOG,
│                                   log episódico, card, INDEX de área, bloco de retomada, runbook de janela,
│                                   relatório de dados sensíveis, tabela de palavras ocupadas
├── runtime/                        Camada 2: kit-lint, validate-registry, close-task, decisions-index,
│                                   ledger-gen, memory-index, sync-skills, encoding-guard, revert-guard,
│                                   ladder/ (gerador do mapa, extensor, árvore de abstração, catálogo)
├── hooks/hooks.json                guardas em warn-only por padrão (Q-EK6)
├── profiles/                       legacy.md · greenfield.md · solo.md · team.md
└── docs/                           INSTALLATION.md (2 trilhas) · ADOPTION-LEVELS.md · KNOWLEDGE-BASE-STRUCTURE.md
                                    · AUTHORING.md (agente × skill) · MATURITY.md · ARCHITECTURE.md (3 camadas)
```

A Camada 3 (o caso) nunca entra no repo. Cada caso mantém fora do kit a sua **deny-list de vazamento**, porque a própria lista nomeia clientes. O kit entrega só o scanner.

### 5.2 Skills do kit unificado (proposta, cerca de 22)

| Módulo | Skills | Técnicas |
|---|---|---|
| M0 | `kb-setup`, `scope-census` | T01–T08 |
| M1 | `assess-legacy-repo` (+ agente `legacy-analyst`), `official-source-archive`*, `migration-direction`* | T09–T16 |
| M1g | `frame-greenfield` (rascunho → rodadas → prompt fechado + requisitos) | T17–T19 |
| M2 | `conceptual-guardian` | T20 |
| M3 | `decision-rounds` (com namespaces, premissas e palavra de liberação) | T21–T25 |
| M4 | `front-protocol` (spec viva + salvamento/retomada + worktree + partição), `change-gate` (pipeline gate + plan/SDD/TDD + prepare-only + anti-patch), `disposable-proof` | T26–T36 |
| M5 | `test-gate`, `delivery-gates` (socrático + adversarial + sondas), `fences`, `browser-verification`, `result-review` | T37–T44 |
| M6 | `close-and-retain` (fechador + cadeia), `memory-engineering`, `memory-consolidation`, `archive-card` | T45–T51 |
| M7 | `git-security`, `git-setup`, `git-commit-push`, `git-push` (+ guardas no `runtime/`) | T52–T57 |
| M8 | `AUTHORING.md`, `MATURITY.md`; `feedback-analyst`† e `evaluate-harness`† | T58–T63 |
| M9 | agentes `ecosystem-curator`*, `settings-mapper`, `pipeline-builder`, `docs-writer`, `build-analyst`*, `folder-importer`*; skills `abstraction-ladder`*, `mold-factory`; `templates/AGENT.template.md` (bloco de governança) | T64–T73 |

\* candidata (opcional, rotulada) · † desenho (proposta, sem promessa de funcionar)

### 5.3 Duas trilhas e três níveis de adoção

| | Legado | Do zero |
|---|---|---|
| Dia 1 | Vaso (M0) + censo do acervo existente | Vaso (M0) |
| Entrada | Avaliar (M1): dimensionar → indexar → unidade piloto | Enquadrar (M1g): rascunho → Rodada 0 |
| Depois | Conceituar → Decidir → ciclo por frente (M4–M6) | Mesmo ciclo |
| Critério de sucesso | 1 ciclo completo numa unidade piloto, tudo registrado | 1 frente do rascunho à entrega pelos gates, com decisões registradas |

| Nível | Quando | O que liga |
|---|---|---|
| **1 Essencial** | Dia 1, qualquer projeto | `AGENTS.md` + adaptador, linha de escopo, rodadas de decisão, cadeia de retenção, git-security, salvamento/retomada, prepare-only |
| **2 Governado** | A partir da 1ª frente | Prompt de frente, guardião, Code Gate, test gate, gates de entrega, fechamento único, logs com claims |
| **3 Escala** | Base com mais de ~50 docs, legado com mais de ~500 arquivos, ou equipe com mais de 1 pessoa | Grafo/RAG, índice de memória, consolidação, cards, cercas, validador, baseline-diff, hooks, feedback |

Os níveis respondem à dor do "dono é o gargalo": um projeto novo não deve receber 22 skills no primeiro dia.

### 5.4 `kit-lint` (a peça executável que impede a próxima deriva)

O `kit-lint` checa cinco coisas:
1. A versão é igual no `plugin.json` e no README.
2. A deny-list de cada caso não acusa nenhum vazamento.
3. Os links internos não estão quebrados.
4. Toda doc tem linha de escopo `method`.
5. Toda skill tem menos de 500 linhas e traz o rótulo de maturidade.

Ele roda antes de cada commit do kit e é a condição de saída de todas as fases.

## 6. Fases

| Fase | O quê | Saída (critério) |
|---|---|---|
| **0 — Rodada 0** | Respostas Q-EK1…Q-EK9. Só Q-EK1…Q-EK3 bloqueiam; o resto segue como premissa | Decisões D-EK registradas neste arquivo |
| **1 — Fonte única** | 1.1 Criar o repo canônico, importando B **com histórico** (`git subtree split` de `engine-kit/`). 1.2 Trazer de A a skill de memória (traduzida), a `PROPOSTA_UNIFICACAO` (vira `docs/ARCHITECTURE.md`) e o guia de secrets (corrige C2). 1.3 Trazer C para `runtime/`, usando as versões mais novas de W, parametrizadas e sem `W:\`. 1.4 Escrever o manifesto de migração (CSV: arquivo de origem → destino → ação), com dry-run. 1.5 Escrever o `kit-lint` v0 e fixar a versão 0.7.0. 1.6 Marcar A, C e `engine-kit/` daqui como SUPERSEDED, com ponteiro e sem apagar | Um repo; manifesto 100% mapeado; `kit-lint` verde; o plugin instala num repo vazio |
| **2 — Ondas por módulo** | Cada módulo funde S e W de uma vez. **Onda 1 Fundação**: M0 + M3 + M7, mais da M9 o curador e a escada (T63–T65), o catálogo gerado (T66), o bloco de governança dos agentes (T72) e o setup de ambiente (T57). **Onda 2 Ciclo**: M4 + M5, mais o escritor único de docs (T69), o analista de build (T70) e a fábrica por moldes (T73). **Onda 3 Reter**: M6 + M8. **Onda 4 Entradas**: M1 + M1g + M2 + `profiles/` + `INSTALLATION` com 2 trilhas + níveis de adoção, mais o mapeador de configurações (T67), o construtor de pipelines (T68), o diff entre versões (T35) e o importador (T71). Cada técnica entra com rótulo de maturidade e evidência anônima (ex.: "ERP legado, ~2,4 mil arquivos") | Por onda: `kit-lint` verde, censo do kit 100% `method`, cada skill com menos de 500 linhas |
| **3 — Prova (testes de saída)** | **3a Do zero**: um repo vazio com os níveis 1 e 2 leva uma frente do rascunho à entrega pelos gates. **3b Legado**: um legado pequeno, sem ligação com os dois casos (Q-EK9), recebe avaliação, unidade piloto e 1 ciclo completo. Ao fim, o teste da pergunta aberta | Os ciclos rodam **só com o kit**, sem ler o Vault nem este repo; os achados viram linhas do `JOURNAL` → v1.0.0 |
| **4 — Retorno aos casos** | **4a Setes (este repo)**: instalar o plugin; `skills-genericas/` vira ponteiro ou SUPERSEDED; o histórico do `INDICE_CENTRAL` vai para um `CHANGELOG`; os 5 docs de entrada viram 1; C4. **4b Softworks (Vault)**: em sessão própria e sob `VAULT#N`, as skills "Ported from engine-kit" passam a apontar a versão do kit, as ferramentas descendentes recebem o upstream e entram C5 e C6. **4c Protocolo de retorno**: uma melhoria de método num caso vira linha no `JOURNAL` em até 1 sessão e é destilada na próxima minor | Os dois casos consomem o kit; nenhuma cópia divergente viva |

**Paralelismo**: a Onda 1 vem primeiro, porque define templates e tokens que as outras usam. As Ondas 2, 3 e 4 tocam módulos disjuntos e podem rodar em paralelo, cada uma numa worktree do repo do kit (T31). Quem chegar por último na main resolve o README e o CHANGELOG.

## 7. Conhecimento negativo (o que NÃO levar, ou levar como alerta)

### 7.1 Do caso Softworks (aposentado e por quê)
- **Pastas espelho fora da base** (desktop, share de rede): duas superfícies de edição sempre derivam.
- **Cópia de skills por `robocopy /MIR`**: perdeu edições locais. Usar plugin ou junção.
- **Ignore global que escondia `.md`**: a base não estava versionada (639 arquivos recuperados). A instalação deve checar isso.
- **`.mcp.json` da máquina commitado**: quebrou todas as outras máquinas.
- **Memória primária num daemon de terceiros**: virou cache descartável, e o daemon nem lia a config.
- **Agendamento sobre um cliente MCP stub**: removido.
- **Gate bloqueante desde o primeiro dia de rollout**: teve de virar warn-only.
- **Mover a mesma coisa 3 vezes em 6 dias**: decida o lugar antes de mover.

### 7.2 Do caso Setes (dores visíveis)
- **Histórico dentro do índice**: `INDICE_CENTRAL.md` tem 301 KB, 85% deles changelog.
- **Prompts monolíticos escritos por várias sessões**: 724 KB e 332 KB. Geraram namespaces improvisados e respostas ambíguas, como "Q-PV17 - a" dada duas vezes.
- **Cinco docs de entrada sobrepostos e velhos**, um deles citando ids efêmeros de agentes como recurso permanente.
- **O segredo literal dentro do relatório de segredos** (C1).
- **O enforcement fora do repo**: CLAUDE.md e agentes não versionados aqui, sem hooks.
- **Rotulagem de comunidades do grafo por LLM**: 3,3 milhões de tokens sem definir módulos, contra 0 tokens do grafo local.
- **Rejeitados do harness-kit**: `project-memory` e `scope-refinement` colidem com o humano no comando.

### 7.3 Vazamentos a limpar na Fase 1 (dentro das cópias do kit)
- **A**: `INSTALACAO.md` linhas 4, 14, 52 e 88; `README.md` linhas 4, 6 e 65; `PROPOSTA_UNIFICACAO.md` linha 99. No `seguranca-git/`: seções Delphi, "ERP multi-tenant", o layout de 5 repos e a stack Firebase/Android.
- **B**: `assess-legacy-repo/SKILL.md` linhas 15 e 135; `README.md` linhas 5 e 96; `decision-rounds/SKILL.md` linha 17; `INSTALLATION.md` linhas 4, 59 e 96; os mesmos restos em `git-security/references`.
- **C**: `build-memory-index.ps1` linhas 11–14; `memory_index.py` linha 11; `sync-skills.ps1` linha 15; `README.md` linha 59; templates com core/custom/merged e "INI / CODE / CUSTOM".

## 8. Questões da Rodada 0

**Q-EK1 — Casa canônica do kit.** O README diz "provisoriamente aqui". O §4 do diário deixa a PI em aberto ("o método é meu × o código é do empregador"). A e C nem estão em git (F3).
- (a) Repo git privado e neutro do Valdo (ex.: `github.com/valdosouza/engine-kit`), consumido como plugin pelos dois casos.
- (b) Manter em `gestao-2027-infra-ia/engine-kit`.
- (c) `C:\RAG\engine-kit` local, com git novo.

**Rec. (a)**: resolve a fronteira de PI, porque nenhum empregador hospeda o método, e os dois casos passam a consumir a mesma versão.

**Q-EK2 — Língua e token de escopo.** B e o Vault estão em inglês; A e este repo, em português.
- (a) Inglês, com `**Scope**: method | case | mixed`. O `kit-lint` e o validador aceitam `Escopo`, `metodo`, `misto`, `setes` e `webwise` como aliases.
- (b) Português.
- (c) Bilíngue.

**Rec. (a)**: o ecossistema de plugins e o caso 2 já falam inglês. Os docs do dono em cada caso continuam na língua do caso.

**Q-EK3 — O runtime fica dentro do kit ou num repo irmão?** (pergunta 1 em aberto no Blueprint)
- (a) Dentro (`runtime/`): uma versão, uma instalação.
- (b) Repo irmão.

**Rec. (a)**: as três camadas continuam separadas como pastas; o que divergiu foi justamente o par de repos sem versão comum.

**Q-EK4 — Ids de decisão.** Este repo usa prefixo por frente (`D-PV2`, 808 ids). O Vault usa `KEY#N` por projeto.
- (a) Namespace + número como conceito único: a frente ou o projeto é o namespace, `PV#2` ≡ `D-PV2`, com índice gerado.
- (b) Um `DECISIONS.md` por projeto.
- (c) Os dois formatos lado a lado.

**Rec. (a)**: preserva todos os ids que já existem nos dois casos e resolve as faixas de sessões paralelas.

**Q-EK5 — Artefatos derivados (grafo, índice de memória).**
- (a) Por perfil: `solo` deixa fora da base e reconstruível; `team` versiona, com um construtor designado.
- (b) Sempre fora.
- (c) Sempre dentro.

**Rec. (a)**: cada caso tomou a decisão certa para o seu tamanho.

**Q-EK6 — Enforcement dos hooks.**
- (a) Warn-only por padrão; bloquear por decisão do projeto.
- (b) Bloqueante desde a instalação.

**Rec. (a)**: lição de rollout do caso 2 (§7.1).

**Q-EK7 — Técnicas comprovadas em um caso só.**
- (a) Entram rotuladas como `candidate` (opcionais).
- (b) Esperam o 2º caso.
- (c) Entram como core.

**Rec. (a)**: respeita a regra dos três casos sem perder o aprendizado. Hoje, ~45 das 63 técnicas são 1c.

**Q-EK8 — Versão.**
- (a) 0.7.0 na consolidação (Fase 1) e 1.0.0 só depois da Fase 3.
- (b) 1.0.0 já na consolidação.

**Rec. (a)**: 1.0 promete portabilidade, e ela só é provada fora dos dois casos.

**Q-EK9 — Projeto de prova da trilha legado (Fase 3b).**
- (a) Um legado open-source pequeno, sem relação com os casos.
- (b) O Sincronizador (caso Setes, já conhecido).
- (c) Esperar o 3º caso real.

**Rec. (a)**: prova a portabilidade sem contaminação e sem esperar. O 3º caso real, quando vier, confirma.

## 9. Premissas (seguem até o Valdo ratificar ou derrubar)

- **A-EK1**: X2 se resolve por "sempre UMA Rec.; se for neutra, dizer que é neutra e por quê".
- **A-EK2**: nada em A, B ou C é apagado; ganha SUPERSEDED com ponteiro (T06, T61).
- **A-EK3**: o Vault é lido, nunca escrito por esta frente. A Fase 4b acontece em sessão aberta lá.
- **A-EK4**: nenhum commit, push ou criação de repo remoto sem o "vai".
- **A-EK5 a A-EK8**: ratificadas em 2026-10-22 como D-EK13, D-EK16, D-EK19 e D-EK20 (§14).
- **A-EK9**: ratificada em 2026-10-28 como D-EK31 (§14).

## 10. Entregáveis (só depois do "vai")

1. O repo canônico com B importado com histórico, mais A e C fundidos (Fase 1).
2. `migration-manifest.csv` e `kit-lint` v0.
3. As quatro ondas (Fase 2), cada uma num commit próprio com uma linha no CHANGELOG.
4. Os relatórios das provas 3a e 3b.
5. Os pacotes de retorno: 4a aqui e 4b como brief para a sessão do Vault.

## 11. Fora de escopo (move, nunca some)

- **Forma comercial do produto** (serviço × licença, preço, nome): fica para a rodada de produto, no §4 do diário.
- **Serviço central de memória** (`Central-Memory-Service-Decision` do Vault) e **abstração de runner multi-ferramenta** (IAgentRunner): entram como desenho no `JOURNAL`, sem implementação.
- **Migrar conteúdo de qualquer caso para o kit**: é proibido por definição.

## 12. Critérios de sucesso

1. Existe **uma** cópia canônica do kit, versionada em git e com versão coerente.
2. O `kit-lint` dá zero vazamentos com as deny-lists dos dois casos.
3. Cada técnica do mapa (T01–T73 e as que a auditoria do §16 acrescentar) tem destino: core, candidata, desenho ou "não levar", com rótulo e evidência.
4. O plugin instala num repo vazio em até 15 minutos, e o Nível 1 funciona sem ler nenhum caso.
5. As provas 3a e 3b terminam com relatório e entradas no `JOURNAL`.
6. Os dois casos consomem o kit e não sobra nenhuma cópia divergente viva.

## 13. ⏯ Retomar daqui

- **Estado (2026-10-28)**: o kit fica em `engine-kit/` deste repo (v0.7.0; D-EK32, decidida pelo Valdo em 2026-10-28). A pasta foi substituída pela exportação do commit `7fdf06a` e enviada ao GitHub na `main` em 2026-10-28 (o repo é público), junto com o mapa `engine-kit-mapa/` e estes documentos; a auditoria de higiene tirou do kit o manifesto da consolidação e o apelido `VAULT_ROOT` (anexo §29). As deny-lists ficam fora do repo, em `C:\RAG\case-denylists\`.
  - O repositório antigo `C:\RAG\engine-kit-canonical` virou histórico: README marcado SUPERSEDED (`7c54e51`), nada mais se edita lá. A `main` dele parou em `55a271e`; o branch `wave3-retain` guarda os commits, só locais, de cada etapa de teste: `f7078de` (`exit-test-3a-stage2`), `dc9800a` (`exit-test-stage3`), `7cc659f` (`exit-test-stage4`), `431d11a` (`exit-test-stage5`), `9d3d6f0` (`exit-test-stage6`), `dd0b9ee` (`exit-test-stage7`) e `c3401de` (`exit-test-stage8`). Nada foi enviado. Com a D-EK32, o fechamento da frente vira o commit deste repo (o merge no repositório antigo deixa de ser necessário).
  - Registro: 96 de 96 técnicas no kit.
- **Histórico** (o detalhe está no anexo `-execucao.md`):
  - Fase 1: §15.
  - Onda 1: §17-§18, kit `5c91565`.
  - Onda 2: §19-§20, kit `55a271e`.
  - Ondas 3 e 4: §21-§22, `f7078de`.
  - Fase 3: §23-§27. Mudança de casa: §28. Higiene e envio: §29.
  - Decisões: D-EK1 a D-EK32, com o espelho no §14 e a casa no `DECISIONS.md` do kit.
- **Pendente do Valdo, fora dos testes**:
  1. O "vai" para criar o repositório privado no GitHub (Rec. `valdosouza/engine-kit`) e fazer o push. Não há `gh` nesta máquina.
  2. C1: girar ou restringir as chaves.
  3. O "vai" para commitar neste repo os documentos da frente (prompt, anexos, deny-list, INDICE, diário, ponteiros).
  4. Os 4 pontos antigos da Onda 2: as faixas do gate socrático (0,85 / 0,75 / 0,70); o commit de checkpoint × a palavra de liberação; a leitura da EK#6 no `test-gate`; as frases literais do Code Gate.
- **Fase 3, testes de saída** (`C:\RAG\exit-tests\`; cada etapa roda num subagente restrito ao kit, numa tag fixa; o log dela gera correções no kit e linhas no `JOURNAL`):
  - **3a, do zero** (biblioteca fictícia, `3a-greenfield`; o código na pasta irmã `3a-greenfield-app`, WS#13): etapas 1 a 5.
    - Resultado: do rascunho de 22 linhas a uma onda entregue e ainda não percorrida - três rodadas (41 decisões), o prompt fechado com requisitos, um "vai", passada única, o portão de testes e três deltas com portões; 139 testes, 5 falhas esperadas.
    - **Devido**: o percurso da dona (Valdo, 2026-10-28: "Ficam devidos"); a Rodada 3 (Q-BIB28-32) com a revisão 1 do plano e o seu "vai"; Q-WS6; "liberado", só depois do percurso; as execuções que esta máquina não faz (7-Zip, pendrive, computador do balcão, navegador).
  - **3b, legado** (`spring-framework-petclinic` só lido, `3b-legacy`): etapas 1 a 4.
    - Resultado: do pedido do dono a uma primeira mudança aprovada e preparada (dois patches e o roteiro em `TICKETS/LEGADO-W1/PATCH/`, conferidos numa cópia), ainda não ensaiada; achados por etapa 22 -> 14 -> 14 -> 9, nenhum bloqueante.
    - **Devido**: o ensaio por uma pessoa ainda sem nome (Valdo, 2026-10-28: "Ficam devidos"); Q-LEGADO8, Q-WS6, Q-WS7, R-LEGADO12, R-LEGADO13 e quem aplica; "liberado".
  - A mensagem "Ficam devidos" veio sem o resto do texto do botão: as rodadas abertas continuam perguntas (nada foi lido além das duas palavras).
  - Correções: 29 achados em `dd0b9ee` e 19 em `c3401de`; os achados antigos foram todos confirmados nas etapas seguintes (13 de 13 no 3a, 16 de 16 no 3b). O `JOURNAL` do kit tem as 33 lições dos dois outboxes, cada uma com o lugar onde assentou (2 seguem `open`).
  - Fixtures do condutor: as respostas literais e os fatos inventados ficam em `resposta-do-dono-*.md` de cada teste.
- **Q-EK28 a Q-EK30 respondidas em 2026-10-28**: viraram D-EK29 a D-EK31 (EK#29 a EK#31), todas na Rec. (§14); kit `9d3d6f0`, tag `exit-test-stage6`.
- **Custo fixo do plugin**: ~3.780 tokens por sessão (30 skills, 10 agentes). O lint imprime o custo e as descrições fora do padrão (15; D-EK18).
- **Vault (Fase 4b)**: V1-V7 corrigidos em 2026-10-21; são 34 itens na changelist SVN `VAULT-AI-FIXES`, com commits preparados e não executados. Continuam abertos:
  - V6 parcial (pins do `opencode.json`; teste em WSL);
  - V3b depois da `VAULT85`;
  - a VAULT#86 (revisão da VAULT#6);
  - o `Build Status` dos `GRAPHS.md`;
  - V8: aposentar o `ecosystem\index\manifest.json`.
- **Próximos ids livres**: Q-EK31, D-EK33, A-EK10, C7, T97, V9.
- **Prompt curto para colar**: "Retomar `prompts/prompt_engine_kit_unificacao.md` pelo §13: Fase 3 no ponto mais longe (kit em `engine-kit/` deste repo, D-EK32; histórico das etapas no repositório antigo `C:\RAG\engine-kit-canonical`). Seguir o 3a e o 3b até a próxima parada do dono, só com o kit e numa versão fixa; achados corrigidos no kit e no `JOURNAL.md`; commit e merge finais só quando o Valdo encerrar a frente."

## 14. Decisões registradas

### Rodada 0 (2026-10-21)

Resposta do Valdo, literal: "Siga as recomendações da Rodada 0 (Q-EK1 a Q-EK9) e comece a Fase 1."

**Casa das decisões**: o `DECISIONS.md` do kit canônico (EK#1…EK#9, por D-EK4/T22). D-EKn ≡ EK#n; esta lista é só o espelho da rodada.

| D | = | Resumo |
|---|---|---|
| D-EK1 | Q-EK1 (a) | Repositório git privado e neutro do Valdo, consumido como plugin pelos casos. Local: `C:\RAG\engine-kit-canonical`; o remoto aguarda o "vai" |
| D-EK2 | Q-EK2 (a) | Inglês; `**Scope**: method \| case \| mixed`, com aliases PT aceitos pelo lint e pelo validador |
| D-EK3 | Q-EK3 (a) | O runtime fica dentro do kit (`runtime/`, `templates/`) |
| D-EK4 | Q-EK4 (a) | Id = namespace + número (`PV#2` ≡ `D-PV2`), com índice gerado |
| D-EK5 | Q-EK5 (a) | Artefatos derivados por perfil: solo fora da base, equipe versionado |
| D-EK6 | Q-EK6 (a) | Hooks em warn-only por padrão |
| D-EK7 | Q-EK7 (a) | Técnica de 1 caso entra rotulada (`proven` / `operating` / `candidate` / `design`) |
| D-EK8 | Q-EK8 (a) | 0.7.0 agora; 1.0.0 só depois da Fase 3 |
| D-EK9 | Q-EK9 (a) | A prova da trilha legado é um legado open-source pequeno e sem relação com os casos |

As premissas A-EK1…A-EK4 seguem valendo.

### Instrução direta (2026-10-21)

- **D-EK10**: os agentes de construção do ecossistema entram no mapa (bloco M9, T64–T73) e nas ondas: Onda 1 (curador, escada, árvore, catálogo, bloco de governança), Onda 2 (escritor de docs, analista de build, fábrica por moldes) e Onda 4 (mapeador de configurações, construtor de pipelines, diff entre versões, importador). Valdo, literal: "Sim, inclua os agentes de construção do ecossistema no mapa (T64+) e no plano das ondas." Casa: EK#10 no `DECISIONS.md` do kit.
- **Pedido seguinte, na mesma sessão**: "verifique o que podemos melhorar com C:\vault\AI e as tools do vault". Virou uma auditoria arquivo a arquivo (§16).
- **D-EK11 = Q-EK10 (a)** e **D-EK12 = Q-EK11 (b)**. Valdo, literal: "Feche a Onda 1: trate as 14 técnicas pendentes dela (…), seguindo as Rec. de Q-EK10 e Q-EK11." O merge de MCP mantém do local só os segredos. Em modo equipe, o build commita o registro que carimbou, e só quando ele estava limpo. Casa: EK#11 e EK#12 no `DECISIONS.md` do kit.

### Questões das Ondas 2 a 4 (2026-10-22)

Valdo, literal: "Siga as recomendações de Q-EK12 a Q-EK20: registre como decisões (D-EK13 em diante, EK#13 em diante no DECISIONS.md do kit) e depois comece a Fase 3 (testes de saída), ainda sem commit nem merge." Casa: EK#13 a EK#21 no `DECISIONS.md` do kit.

| D | = | Resumo |
|---|---|---|
| D-EK13 | Q-EK12 (a) | Um aviso arriscado novo do compilador devolve a mudança, salvo aceite do dono como decisão numerada |
| D-EK14 | Q-EK13 (a) | A porta `precommit` do `runtime/testing` entra nos hooks do plugin, com descoberta opt-in e só de aviso |
| D-EK15 | Q-EK14 (a) | Nenhum agente `browser-tester` até um segundo caso pedir |
| D-EK16 | Q-EK15 (a) | Id de card `K-YYYYMMDD-HHMM` |
| D-EK17 | Q-EK16 (a) | O `svn status` pode ignorar o `global-ignores` do cliente, opt-in e desligado por padrão |
| D-EK18 | Q-EK17 (a) | Descrições reescritas quando o arquivo for tocado; o lint conta as que faltam e vira erro no zero |
| D-EK19 | Q-EK18 (a) | A análise transversal mora em `PIPELINES/TRANSVERSAL.md` |
| D-EK20 | Q-EK19 (a) | A sonda de dados roda sem prova configurada, avisa e marca NOT PROVEN; `require_proof` liga a exigência |
| D-EK21 | Q-EK20 (a)+(c) | Um plugin + a linha "Adoption" do caso + lista por nível no `sync-skills.ps1`; dois plugins ficam prontos para virar decisão |

### Questões dos testes de saída (2026-10-27)

Valdo, literal: "Siga as recomendações da Rodada 0 do teste 3a (Q-WS1, Q-WS2 e Q-BIB1 a Q-BIB14) e de Q-EK21 a Q-EK23. Para os fatos R1 a R6, invente valores plausíveis e marque-os como fixture do teste. Depois continue o 3a até a entrega e comece o 3b." Casa: EK#22 a EK#24 no `DECISIONS.md` do kit.

| D | = | Resumo |
|---|---|---|
| D-EK22 | Q-EK21 (a) | O 3b roda no `spring-framework-petclinic`: clone raso, só leitura, nunca compilado |
| D-EK23 | Q-EK22 (a) | `conceptual-guardian`, `FRONT_PROMPT` e `OCCUPIED_WORDS` entram no nível 1 como peças situacionais da entrada greenfield |
| D-EK24 | Q-EK23 (a) | Cada etapa de teste roda numa versão fixa: commit local + tag local no branch de trabalho; sem merge na `main` e sem push até o fim da frente |

### Questões das etapas 3a-2 e 3b-1 (2026-10-27)

Valdo, literal, como chegou (a mensagem veio cortada depois da última palavra): "Siga as recomendações da Rodada 1 do 3a (Q-WS3, Q-WS4, Q-BIB15 a Q-BIB24), da Rodada 0 do 3b (Q-WS1 a Q-WS4, Q-LEGADO1 a Q-LEGADO6) e de Q-EK24 a Q-EK27. Para os fatos pedidos (R-WS1, R-BIB7, R-LEGADO1 a R-LEGADO8), invente valores plausíveis marcados como fixture. A palavra de liberação é "liberado". Casa: EK#25 a EK#28 no `DECISIONS.md` do kit.

| D | = | Resumo |
|---|---|---|
| D-EK25 | Q-EK24 (a) | Revê a D-EK23: guardião inteiro, `FRONT_PROMPT` e `OCCUPIED_WORDS` no nível 1 nas duas trilhas; a Rodada 0 do legado usa o `FRONT_PROMPT` |
| D-EK26 | Q-EK25 (a) | A rodada que fecha o prompt leva a subida ao nível 2 e o plano da primeira onda, com o "vai" pedido ali |
| D-EK27 | Q-EK26 (a) | Solo: a área de runtime pode ser uma pasta ignorada pelo VCS dentro da base |
| D-EK28 | Q-EK27 (a) | Teste-primeiro de unidade nova: o stub faz parte do artefato vermelho mostrado no gate |

### Questões das etapas 3a-3 e 3b-2 (2026-10-28)

Valdo, literal: "Siga as Rec. da Rodada 2 do 3a, do 3b (Q-LEGADO7, Q-WS5, padrões) e de Q-EK28 a Q-EK30; fatos R-BIB8 e R-LEGADO9-11 como fixture. Vai no plano W1 do 3a. Vai no vermelho W1.1 do 3a. Vai no plano LEGADO-W1 do 3b." Casa: EK#29 a EK#31 no `DECISIONS.md` do kit.

| D | = | Resumo |
|---|---|---|
| D-EK29 | Q-EK28 (a) | Uma árvore de código pode ficar numa pasta dentro da base quando é repositório próprio e o VCS da base a ignora; o registro de projetos a nomeia e as verificações que percorrem a pasta a excluem; fora da base continua o padrão |
| D-EK30 | Q-EK29 (a) | Um "vai" por onda: o plano pode levar passos teste-primeiro, com os vermelhos provados e mostrados junto, cobertos pelo mesmo "vai" |
| D-EK31 | Q-EK30 (a) | Ratifica a A-EK9: o `settings-mapper` varre com padrões "propostos" enquanto a confirmação vai na rodada que fecha |

### A casa do kit (2026-10-28)

Valdo, literal: "tudo deve ficar em C:\temp\gestao-2027-infra-ia\engine-kit, se caso for substituindo o que tiver dentro dela, para que o kit seja atualizado com o melhor dos dois mundos". Casa: EK#32 no `DECISIONS.md` do kit (a frase vai lá com o caminho omitido, porque um caminho de caso não entra no kit).

| D | = | Resumo |
|---|---|---|
| D-EK32 | decisão direta do Valdo (revê a D-EK1) | O kit mora em `engine-kit/` deste repo, substituindo a cópia antiga; o repositório `C:\RAG\engine-kit-canonical` fica como histórico (SUPERSEDED). Continua valendo: nenhum conteúdo de caso no kit (lint com as deny-lists antes de cada commit) |

## 15. Fase 1 — execução (2026-10-21)

Movida para o anexo `prompts/prompt_engine_kit_unificacao-execucao.md` (§15). Em resumo: o repositório canônico foi criado a partir do histórico do `engine-kit/`, A e C foram fundidos, o manifesto ficou 100% mapeado, o `kit-lint` e o plugin foram validados e instalados, e as cópias antigas foram marcadas SUPERSEDED.

## 16. Auditoria de `C:\Vault\AI` e das tools do Vault (2026-10-21)

Pedido do Valdo: "verifique o que podemos melhorar com C:\vault\AI e as tools do vault". Foi feita uma leitura arquivo a arquivo contra o mapa T01–T73. **O detalhe está no anexo `prompts/prompt_engine_kit_unificacao-auditoria-vault.md`** (o prompt ficou acima do orçamento de 60 KB; T04/T26). Em resumo:

- **T74–T96**: 23 técnicas genéricas que faltavam no mapa. As de maior peso: a integridade da evidência de teste, o vigia de commits com agente de proposta, o empacotamento da mudança, a forense de revisões, as guardas de isolamento entre clientes e de local aposentado, a fixação do ferramental, o diário de instalação reversível e a sonda de dados somente leitura.
- **Detalhe em ~20 técnicas já mapeadas** (T01, T04, T07, T22, T24, T26, T28, T29/T45, T36, T37/T38, T41, T42, T54–T57, T67–T71, T09/T11, T14, T35), a aplicar na onda de cada uma.
- **Tools a portar para `runtime/` e `hooks/`, por onda.** Onda 1: `decisions_index`, `projects_check`, `ledger_gen`, as guardas de encoding e de reversão, os geradores de stub, a ativação de MCP, `merge_tree`, o construtor noturno e a lista "ask" do harness como `hooks/`. Onda 2: as peças da suíte de testes, o runner Playwright e o contrato do build. Onda 3: `close-task` e o esqueleto de migração. Onda 4: anexos do tracker e a sonda SQL.
- **Melhorias nas skills que o kit já tem**: `decision-rounds` ainda sem `KEY#N` (é o primeiro item da Onda 1), `retain-knowledge`, `memory-engineering` (cards e consolidação), `scope-census`, `validate-registry`.
- **V1–V7**: defeitos do próprio Vault, a corrigir lá (Fase 4b). Exemplos: o `revert-guard` ignora o `cwd` do hook, os padrões de caminho aposentado ficaram incompletos e o construtor noturno tem clientes fixos no código. Foram corrigidos no mesmo dia (§13).

## 17. Ondas executadas

Os logs ficam no anexo `prompts/prompt_engine_kit_unificacao-execucao.md`: §17 tools da Onda 1 (kit `267883b`), §18 fechamento da Onda 1 (kit `5c91565`), §19 Onda 2 parte 1 (kit `b9b9960`), §20 fechamento da Onda 2 (kit `55a271e`), §21 Onda 3, §22 Onda 4, §23 e §24 Fase 3 (branch `wave3-retain`, tags `exit-test-3a-stage2` e `exit-test-stage3`).
