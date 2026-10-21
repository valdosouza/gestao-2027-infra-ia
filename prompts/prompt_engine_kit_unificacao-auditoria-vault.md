# Anexo — Auditoria de `C:\Vault\AI` e das tools do Vault (frente da unificação do engine-kit)

**Escopo**: misto (as técnicas e as tools são método; os caminhos citados são do caso W, que só foi lido)
**Frente**: `prompts/prompt_engine_kit_unificacao.md` (§16 aponta para cá)
**Data**: 2026-10-21

---

## Auditoria (2026-10-21)

Pedido do Valdo: "verifique o que podemos melhorar com C:\vault\AI e as tools do vault". Foi feita uma leitura arquivo a arquivo de `Agent\`, `Skills\` (com os scripts dentro), `Orchestration\`, `EditorAdapters.md`, `Tools\**`, `C:\Vault\.claude\` e `C:\Users\fsouza\.claude\scripts\`, contra o mapa T01–T73. Nada foi alterado no Vault.

### 1. Técnicas genéricas que faltavam (T74–T96)

| # | Técnica (nome neutro) | Regra em uma frase | Fonte (W) | Mód. | Mat. | Ação · Onda |
|---|---|---|---|---|---|---|
| T74 | Diário de instalação reversível | Cada mudança na máquina é uma linha JSON; a desinstalação desfaz da mais nova para a mais velha; a instalação só roda por pedido explícito | `Tools\TestSuite\lib\Install.ps1` | M7 | 1c | runtime · **1** |
| T75 | Vigia de commits + agente de proposta headless | Classificar cada revisão por padrão de caminho (correção / teste / misto / não testável) e esperar uma carência. O primeiro claim vence por conflito no VCS. O script roda a suíte; o agente só escreve na pasta da proposta e sempre fecha um REPORT; um humano promove | `Orchestration\core-test-suite-workflow.md` §3; `Tools\TestSuite\lib\Decide.ps1`, `Proposals.ps1`, `watch.prompt.md` | M5 | 1c | destilar (função de decisão pura) · **2** |
| T76 | Integridade da evidência de teste | Ler sempre "testes encontrados" (o runner sai 0 com zero testes) e fechar a conta antes + adicionados − substituídos = encontrados. "Vermelho" tem de ser asserção, não erro de compilação. O valor esperado vem da leitura do código, nunca colado de uma execução. A linha SUSPEITA vai para backlog. Virar uma mutação é a prova mínima, não a completa | `core-test-suite-workflow.md` §4–5; `Skills\cw-csv-cases` | M5 | 1c | core · **2** |
| T77 | Portão de cobertura | O agente integrador é dono das listas de cobertura compartilhadas; o verde dos workers não o dispensa; a entrega diz "listas de cobertura: atualizadas / conferidas" | `core-test-suite-workflow.md` | M5 | 1c | core · **2** |
| T78 | Empacotamento da mudança | Todo arquivo novo é adicionado ao VCS ao nascer; nenhum arquivo não versionado na entrega; correção e testes em dois commits (a correção primeiro), em changelists com o nome do item | `core-test-suite-workflow.md` §3a; `ad-finalization` passo 4 | M6 | 1c | core · **3** |
| T79 | Backport por diff isolado | Uma pasta de comparação por revisão (antes / depois / diff / manifesto). O diff sai da linha que bate com o destino. Ordem: novos → reversões → avanços → diff isolado. Validar cada arquivo antes do próximo; nunca copiar um arquivo inteiro de outra linha | `Skills\hotfix-orchestrator\svn-policy.md`, `hotfix-backport` | M4 | 1c | candidata (multi-branch) · **2** |
| T80 | Forense de revisões do item | Nunca julgar uma revisão sozinha. Mapear todas as revisões do item, classificar as sobreposições (mantida / desfeita / reintroduzida / conflito), nomear a revisão culpada e marcar frases "decidimos" como evidência de desenho | `Orchestration\code-review-workflow.md`; `bug-analyzer-system` | M5 | 1c | core · **2** (com T42) |
| T81 | Depuração pelo ponto de divergência | Resultado errado sem crash: sintoma → memória → mapa de estado → primeira instrução que diverge; a correção vai ali | `Agent\delphi-specialist-dev.md` (só a regra) | M4 | 1c | core · **2** |
| T82 | Integridade de caminho / contrato primeiro | Nunca citar símbolo que não foi lido; uma mudança entre camadas só termina quando todas as camadas resolvem na mesma árvore | idem | M4 | 1c | core · **2** |
| T83 | Análise de estado compartilhado (transversal) | Quando mais de um pipeline escreve o mesmo estado: matriz de escritores (quem insere ou remove, quando, atrás de qual portão), matriz de portões por ambiente e histórico de falhas cruzadas. Célula desconhecida diz "desconhecido" | `Skills\cw-pipeline-template` (Transversal) | M1 | 1c | core · **4** |
| T84 | Leitura com paridade de override | Um passo que cai num método sobrescrito cita o override, a base e as condições do predecessor | `cw-pipeline-template`; `bug-analyzer-system` 7b.4 | M1 | 1c | candidata (sistemas com sobreposição por cliente) · **4** |
| T85 | Pack de revisão + ida e volta das respostas | O pack tira a descoberta da reunião. Cada tipo de conteúdo tem um só arquivo dono. As perguntas só saem depois de o dono confirmar. As respostas são citadas literais, classificadas (respondida / parcial / aberta / nova) e registradas como decisões | `Skills\cr-review-pack` | M3 | 1c | destilar · **1** |
| T86 | Guarda de isolamento entre clientes | O fechamento falha se o conjunto de mudanças toca o projeto de outro cliente | `Tools\Memory\projects_check.py --check-scope` | M7 | 1c | runtime · **1** |
| T87 | Validador do inventário de projetos | Raízes de projeto ↔ linhas do registro, nos dois sentidos. O `project:` de cada doc bate com a pasta. Uma data marcada vira aviso em falha | `projects_check.py` | M0 | 1c (modo estrito ainda papel) | runtime · **1** |
| T88 | Guarda de local aposentado | Arquivo normativo não pode apontar para caminho aposentado, em todas as grafias: drive, UNC e barra normal | `Tools\Validation\close-task.ps1` §3 | M7 | 1c | runtime · **1** |
| T89 | Portão de aposentadoria de fonte congelada | Fotografar o acervo antigo e relatar a deriva com mapa velho → novo. Aposentar só com deriva zero ou depois de um humano importar ou descartar cada item | `Tools\Validation\vault_sync_check.py` | M8 | 1c (usado uma vez) | candidata, com T61 · **3** |
| T90 | Fixação do ferramental | Pin exato ou fonte vendorizada; subir versão é decisão; nunca `@latest`; nunca rodar o `init` de uma ferramenta na raiz da base | `Tools\Graphify\SOURCE.md`, `Tools\Ruflo\SOURCE.md` | M7 | 1c | core · **1** |
| T91 | Lista de ferramentas por agente | Cada persona declara as suas ferramentas, para o limite de ferramentas de um cliente não derrubar em silêncio as de memória | `Tools\Editors\make-copilot-stubs.py` | M0 | 1c | com T01 · **1** |
| T92 | Portão de entregável | A língua do artefato é fixa (o chat segue o usuário); nunca na raiz; o `.md` é a fonte e os binários são exportações ao lado | `Skills\deliverable-standards` | M6 | 1c | core · **3** |
| T93 | Higiene de link e proveniência | Link só para `.md`; arquivo-fonte como texto puro, com a linha fora do link; todo doc derivado leva revisão / data / autor / mensagem da fonte | `Agent\docs-writer.md` | M6 | 1c | com T69 · **2** |
| T94 | Sonda de dados somente leitura | O executor de consultas recusa palavras de escrita e DDL sem flag explícita; autenticação integrada; limite de linhas | `Tools\SQL\Invoke-CwSql.ps1`; o caso S usa a mesma regra (sessão READ ONLY) | M1 | **2c** (regra) / 1c (ferramenta) | core · **4** |
| T95 | Camada de IA neutra quanto ao cliente | Nenhum nome de cliente em agentes e skills; o específico do cliente fica num arquivo de notas por cliente, alcançado por ponteiro | `Agent\custom-table.md` | M9 | 1c | core · **1** |
| T96 | Relatório semanal por evidência | "Sim" = trabalhou e entregou; filtrar pelo campo de autor; datar pela data de mudança, não pela de revisão | `Skills\cw-weekly-update` | M6 | 1c | candidata · **3** |

### 2. Técnicas já mapeadas que ganham detalhe (aplicar na onda de cada uma)

- **T01**: stubs gerados a partir de um vocabulário neutro de ferramentas. Ferramenta nova traz, na mesma tarefa, o ponto de montagem, a linha de inventário e a linha da matriz de suporte. O fallback manual é "leia o AGENTS.md e siga".
- **T04**: um ledger gerado de "o que foi arquivado quando". A data vem do front-matter, senão do nome do arquivo, senão do mtime (marcado `~`). Há um ledger por projeto mais a visão cruzada, e só os projetos alterados são regenerados.
- **T07**: comparar a data do build do grafo com a última mudança no VCS e marcar a evidência velha como `graph-stale`. O construtor noturno só atualiza uma cópia limpa, commita só os caminhos derivados e roda só com código (sem chave de LLM). A camada mesclada é uma árvore de hardlinks base + sobreposição.
- **T22**: checagem de citação (`KEY#N` tem que existir; "decisão N" solta gera aviso), esqueleto `--init` e falha em número duplicado ou sem data.
- **T24**: o portão da regra de negócio dispara em três pontos. No plano / spec / teste, para no Negado. Na revisão, bloqueia regressão para um Negado. No fechamento, recusa se nenhuma linha cobre um comportamento visível ou se a mudança implementa uma questão aberta.
- **T26**: pack de contexto para quem implementa, com as listas "não toque" e de smoke.
- **T28**: a spec passa por rascunho → aprovada → revisada, e cada revisão abre um novo portão. Há uma tabela de conformidade RF a RF, cada uma com o teste que a prende. Cópia de trabalho suja é risco declarado. O "go" é registrado com data e palavras. Um plano sem Test plan não está pronto para o portão.
- **T29 / T45**: escrita no tracker: ler antes, `test /rev` otimista, mostrar e perguntar antes de substituir texto de outra pessoa, nunca postar comentário e conferir que cada campo foi gravado. A lista "ask" do harness é o gêmeo executável da regra escrita.
- **T36**: o ruído é filtrado. O feedback de reversão do QA é a entrada principal. Itens relacionados só entram se trouxerem nota de dev. Anexos são convertidos em texto.
- **T37 / T38**: `exempt` dispensa o teste novo, nunca a suíte. `skip:` e `not run here:` são linhas escritas. Os códigos "ocupado" e "ausente aqui" não são resultado. O baseline só é gravado de uma cópia limpa. Quem encontra a falha pré-existente a corrige em seguida, num commit separado.
- **T41**: uma spec para três motores; localizadores semânticos primeiro; vereditos PASS / FAIL / BLOCKED / MANUAL; um caso de controle de regressão; limpeza mesmo no FAIL; nunca afirmar um texto que você mesmo digitou.
- **T42**: as revisões abertas aparecem antes de trabalho novo. Achado sem `arquivo:linha` e sem cenário de falha é descartado. Autorrevisão nunca substitui a revisão independente.
- **T54 / T55**: o wrapper do hook faz grep no stdin antes de subir o PowerShell. O PostToolUse devolve o achado ao contexto e o PreToolUse responde `ask` no commit. Hunks que mudam só o charset são achados dobrando as linhas.
- **T56 / T57**: o `.mcp.json` de ativação é local, nunca versionado. Há um perfil por SO e um modelo sem segredo, com placeholders que viram prompts. O merge toca só `mcpServers`, o segredo local vence, há backup antes e a edição é feita com o cliente fechado. No setup, os comandos de rede são mostrados antes de rodar, e a checagem final é uma pergunta real respondida pela base.
- **T67 / T68 / T69 / T70 / T71**: os detalhes da auditoria confirmam o bloco M9. No T68, o pipeline de cliente é um delta que aponta para o da base. No T69, há tabela de roteamento por categoria e recibo de arquivamento de 5 linhas. No T70, o veredito é LIMPO / SUFICIENTE / QUEBRADO. No T71, uma falha deixa a pasta intacta e registrada como `pending`.
- **T09 / T11**: registro de hipóteses com vocabulário fixo de status, uma hipótese por turno, versão nova do documento único de análise e nenhuma correção durante a validação.
- **T14**: preferir um hook a copiar um arquivo da base; arrumar o código preserva regras e mensagens; bug suspeito é listado, não corrigido.
- **T35**: o diff lê docs, não código; se o doc falta, relata e para.

### 3. Tools a portar para o `runtime/`

| Ferramenta (W) | Trabalho genérico | Esforço · o que parametrizar | Valor | Onda |
|---|---|---|---|---|
| `Validation\close-task.ps1` | Fechamento mecânico numa chamada: registros, Scope dos tocados, portão de teste (aviso), caminhos aposentados, ledger, decisões, índice | M · `svn status` → adaptador de VCS; padrões aposentados e portão de teste como dados | Alto | 3 |
| `Memory\decisions_index.py` | Registros por projeto → índice gerado + checagem de citação | P · descoberta de registros por tabela de projetos | Alto | 1 |
| `Memory\projects_check.py` | Inventário, `project:` × pasta, guarda entre clientes | M · as raízes viram globs (hoje fixas no layout do caso); `ENFORCE_FROM` como parâmetro | Alto | 1 |
| `Memory\ledger_gen.py` | Ledger de atividade gerado | P · mapa de tipos como config | Médio | 1 |
| `Editors\encoding-guard.ps1` | UTF-8 inválido, não-ASCII novo, hunk só de charset | P · `svn cat -r BASE` → `git show HEAD:`; extensões como parâmetro | Alto | 1 |
| `~\.claude\scripts\revert-guard.ps1` | Avisa quando a mudança remove linhas commitadas há pouco | M · blame/log → git; regex do ticket como parâmetro; **corrigir o defeito do `cwd`** (§16.5) | Alto | 1 |
| `Editors\gen-claude-agent-stubs.py`, `make-copilot-stubs.py` | Agente neutro → stubs por ferramenta, com lista de ferramentas e `--check` | P · tirar edições pontuais embutidas; mapa de ferramentas como dado | Médio | 1 |
| `Editors\merge-mcp-config.js`, `run-mcp-tool.js`, `setup-*.ps1`, `MCP\mcp.model.json` | Ativação por editor a partir de um modelo canônico; smoke test de MCP | P–M · os ramos do tracker vão para um arquivo de regras | Médio | 1 |
| `Graphify\merge_tree.py` | Árvore incremental de hardlinks base + sobreposição | P | Alto | 1 |
| `Graphify\rebuild-merged.ps1`, `nightly-rebuild.ps1`, `install-graphify.ps1` | Reconstrução pelo construtor designado; instalação com pin | M · ler o `REGISTRY_GRAPHS` em vez de clientes fixos; adaptador de VCS | Alto | 1 |
| `TestSuite\cwtest.ps1` + `lib\` | Orquestrador de suíte, baseline, vigia, claims, hooks, diário de instalação, runner com job object | G no todo; portar em peças M (Install, Decide, Classify, Baseline, Process); o framework de teste e o VCS ficam no caso | Alto | 2 |
| `Skills\web-test-agent\runner\run.mjs` | Runner Playwright guiado por spec | P–M · seletor de "login pronto" como parâmetro | Médio–alto | 2 |
| `Build\build.ps1` + `projects.json` | Projetos como dado, env por máquina, saída fora da árvore, `summary.json` por código de aviso | G para o compilador do caso; portar o contrato do `summary.json` + esqueleto | Médio | 2 |
| `Migration\migrate_engine.py` | Merge de base guiado por manifesto: dry-run em staging, `--apply` em lotes, nunca apaga nem renomeia | G · portar só o esqueleto | Médio | 3 |
| `Validation\vault_sync_check.py` | Portão de aposentadoria (T89) | P | Baixo–médio | 3 |
| `MCP\vso-attachments.ps1` | Anexos do tracker + Office → texto | M · o extrator de texto é genérico, o tracker não | Médio | 4 |
| `SQL\Invoke-CwSql.ps1` | Sonda somente leitura (T94) | P · hoje só MSSQL | Médio | 4 |
| `C:\Vault\.claude\settings.json` (lista "ask") + hooks do usuário | Enforcement no harness | Vira a pasta `hooks/` do kit, em warn-only (EK#6) | Alto | 1 |

Ficam no caso: `OpenCode\*`, `Ruflo\*` (só as regras de pin e de "nada de `init` na raiz" sobem, como T90), `Build\projects.json`, `TestSuite\lib\Api.ps1`, o servidor MCP de SVN e os templates de doc por prefixo de unidade.

### 4. Melhorias nos arquivos que o kit JÁ tem

- **`retain-knowledge`**:
  - Ganha linhas de destino para card, pipeline, setting e log episódico.
  - Todo fato ≥ 0,8 recebe a decisão "card novo / card reforçado / sem card (por quê)".
  - A área com ≥ 5 logs não consolidados é sinalizada.
  - Claims novos são comparados com os antigos.
  - As regras raiz só mudam se o estado do workspace mudou.
  - Termina com o script de fechamento e o portão de entregável. (Onda 3)
- **`decision-rounds`**: a EK#4 já decidiu `KEY#N`, mas o texto da skill ainda não diz isso. Faltam:
  - a rodada nomeia o projeto;
  - um registro casa por decisão, com a coluna "aplica-se a";
  - regenerar o índice depois de cada rodada;
  - o comentário no código leva a tag do projeto;
  - arquivos `RULE-<slug>.md` com histórico Autorizado/Negado;
  - a escolha técnica de um único ticket fica no dossiê. (**Onda 1, primeiro item**)
- **`memory-engineering`**: fundir os cards e a consolidação.
  - O card tem front-matter com `id`, `project`, `version`, `tickets`, `entities`, `supersedes` e proveniência de VCS, e seções Problema / Regra / Padrão de correção / Anti-patch / Arquivos-chave / Evidência, em menos de 60 linhas.
  - Reforçar em vez de duplicar: duas confirmações independentes levam a 0,95. Uma contradição gera um card novo com `supersedes`.
  - A consolidação trata uma área por ciclo e nunca cria um doc-despejo. (Onda 3)
- **`scope-census`**:
  - Regra de colocação para doc com YAML (logo depois do `---`).
  - Classes de exclusão: gerado, vendorizado, runtime, config de editor, estado de ferramenta.
  - Retomada de execução interrompida.
  - Checagem só dos alterados no fechamento. (Onda 1)
- **`validate-registry.ps1`**: modo `-Changed` (status do VCS) e exclusão documentada do estado de ferramenta. (Onda 1)
- **`assess-legacy-repo` / `legacy-analyst`**: o registro de hipóteses (T09/T11). (Onda 4)
- **`conceptual-guardian`**: "nova entidade de pipeline" como gatilho. (Onda 4)

### 5. Defeitos achados no próprio Vault (corrigir lá, Fase 4b, sob a governança dele)

| # | Defeito | Onde |
|---|---|---|
| V1 | Em modo commit-gate, o `revert-guard.ps1` usa o caminho padrão fixo em vez do `cwd` do payload do hook | `C:\Users\fsouza\.claude\scripts\revert-guard.ps1` |
| V2 | O cabeçalho do `revert-guard.ps1` diz que existe uma cópia canônica no Vault, mas ela não existe em `AI\Tools\Editors\` | idem |
| V3 | Os padrões de caminho aposentado do `close-task.ps1` não pegam as grafias UNC e com barra normal, e `docs-workflow.md` ainda aponta para o share antigo | `AI\Tools\Validation\close-task.ps1`; `AI\Orchestration\docs-workflow.md` |
| V4 | O `nightly-rebuild.ps1` diz que segue o registro de grafos, mas tem os clientes fixos no código | `AI\Tools\Graphify\nightly-rebuild.ps1` |
| V5 | O `gen-claude-agent-stubs.py` ainda descreve o sync antigo por cópia (as junções o substituíram) | `AI\Tools\Editors\gen-claude-agent-stubs.py` |
| V6 | O `opencode.json` usa `@latest`, contra a regra de pin; o `pyproject` do MCP de SVN tem pin divergente | `AI\Tools\OpenCode\`, `AI\Tools\MCP\svn\` |
| V7 | C5 e C6 (§2.1): o diário apontado para o lugar errado e rótulos de Scope errados; 5 skills "Ported from" ainda apontam para a cópia SUPERSEDED | `AI\Skills\knowledge-retention`, `archive-card`, `AI\Agent\feedback-analyst.md` |

### 6. As 10 adições de maior valor (ordem de ataque dentro das ondas)

1. `close-task` com a guarda de local aposentado (T45, T88).
2. Integridade da evidência de teste + empacotamento (T76, T78).
3. Vigia de commits com o agente de proposta e a função de decisão pura (T75).
4. Guardas de encoding e de reversão + o wrapper de hook, com a correção V1 (T54, T55).
5. `decisions_index` + portão da regra de negócio no plano, na revisão e no fechamento (T22, T24).
6. `projects_check`: inventário, isolamento entre clientes e data de enforcement (T86, T87).
7. `merge_tree` + reconstrução noturna pelo construtor designado (T07).
8. Forense de revisões + handshake da revisão (T80, T42).
9. Regras de card e consolidação dentro de `memory-engineering` (§16.4).
10. Diário de instalação reversível + pin + higiene da ativação de MCP (T74, T90, T56).
