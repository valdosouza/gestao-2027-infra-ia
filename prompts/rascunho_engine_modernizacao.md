# Rascunho — Engine de Modernização de Legado (produto)

**Status**: RASCUNHO / diário de produto — Rodada 0 do `refinar-prompt-arquitetura` ainda NÃO iniciada (gatilho abaixo)
**Escopo**: metodo
**Origem**: conversa estratégica com o Valdo em 2026-07-19 (memória Cowork `engine-ml.md`)
**Referências**: `skills-genericas/guardiao-conceitual.md`, `skills-genericas/refinar-prompt-arquitetura.md`, `skills-genericas/atualizar-infra-ia.md`

---

## 1. Visão (palavras do Valdo, 2026-07-19)

> "Tudo pra mim vira produto vendável. Mas produto deve primeiro estar maduro, e nada
> melhor que casos/problemas/questões reais para treinar o modelo. Esse modelo precisa
> ser construído de uma maneira que eu possa portar para outra empresa como um produto,
> avaliando repositório de código legado e reescrever o software como estou fazendo com
> o meu software."

**Tradução em produto**: uma engine portável que (a) avalia um repositório de código
legado, (b) destila os conceitos de negócio da casca do sistema antigo, (c) conduz o
dono do negócio por rodadas de decisão registradas, e (d) reescreve o software em peças
composáveis. A migração do Gestão 2027 (Delphi → TypeScript/Flutter) é o **caso zero**
(dogfooding): a Setes é o cliente nº 1 do próprio produto.

**Natureza técnica**: NÃO é um modelo de ML treinado do zero. É agentes + RAG
(base de conhecimento própria recuperada para o contexto de um modelo de fundação).
O modelo é peça trocável; o ativo é o MÉTODO + a base de conhecimento. Portar para
outra empresa = trocar a base indexada, não retreinar.

## 2. Estratégia decidida (2026-07-19)

1. **NÃO separar método × conteúdo Setes agora** — regra dos três casos: com n=1 a
   fronteira da abstração seria chutada (uma "engine genérica" extraída de um caso só
   seria maquete da Setes — o próprio teste do guardião conceitual aplicado ao produto).
   Método ainda em mutação acelerada (guardião conceitual e framework de mensagens
   nasceram na mesma semana desta decisão).
2. **Marcar em vez de separar**: todo arquivo novo/tocado na Infra-IA ganha
   `**Escopo**: metodo | setes | misto` no cabeçalho (regra registrada na skill
   `atualizar-infra-ia.md`). Quando chegar a hora, a extração vira um filtro, não
   uma arqueologia.
3. **Revisão do sincronizador = caso nº 2 de graça**: outro Delphi legado, de natureza
   diferente (serviço de integração, não telas). Testa se o método generaliza além de
   "ERP com formulários". A dívida pendente e o teste de portabilidade do produto são
   a mesma tarefa.
4. **Gatilho da separação real** (o que vier primeiro):
   - revisão do sincronizador concluída (n=2 provado), OU
   - primeira empresa candidata real aparecer.
   Ao disparar: este rascunho entra na `refinar-prompt-arquitetura` (Rodada 0).

### 2.1 Caso nº 2 REAL: Softworks (mesma data, 2026-07-19)

O Valdo também atua como desenvolvedor na **Softworks**: projeto de ~2 milhões de linhas
e 30 anos de desenvolvimento, onde ele JÁ começou a engine com outra composição de peças —
indexação do código em grafo ("Grafify"), memória persistente ("Ruflo") e **Obsidian**
para a documentação humana. Leitura estratégica:

- Softworks testa a dimensão que o caso zero NÃO testa: **escala** (2M LOC inviabiliza
  "ler tudo"; força indexação+RAG desde o dia 1). O sincronizador segue como caso interno
  (testa natureza: serviço × telas); Softworks é o caso externo (testa escala e portabilidade).
- Stack de ferramentas ≠ método: Softworks tem o SUBSTRATO (indexar/memorizar/visualizar);
  o Gestão 2027 tem o PROCESSO (guardião conceitual, rodadas de decisão, cadeia de retenção,
  escopo). A engine é a união das duas metades.
- **Regra de higiene entre casos: conteúdo de caso NUNCA cruza empresas — só o método
  viaja.** Nada de `setes` vai para a Softworks; nada do código Softworks entra aqui.
  Destilação dos `misto` acontece SOB DEMANDA do caso 2 (necessidade real, não especulação).

## 3. Inventário inicial — o que já é o quê (2026-07-19)

| Ativo | Classificação | Vira no produto |
|---|---|---|
| `skills-genericas/guardiao-conceitual.md` + agente setes-conceito | **método puro** | Destilação de conceitos — separar regra de negócio da casca do legado (teste da maquete/fato gerador) |
| `skills-genericas/refinar-prompt-arquitetura.md` | **método puro** | Rodadas de decisão do dono do negócio; nenhuma decisão se perde |
| `skills-genericas/atualizar-infra-ia.md` | **método puro** | Ciclo de aprendizado da engine (cada migração deixa a base mais esperta) |
| `setes-api/skills/delphi-to-typescript.md` + agente Delphi→TS | **misto** | Fase de avaliação/conversão do legado (hoje amarrado a Delphi→TS e à stack Setes) |
| `Sincronizador/Agent_Analise_Inicial_Migration.md` | **misto** | Molde da fase "avaliar repositório legado" |
| `ARQUITETURA_MODULOS.md` / `ARQUITETURA_MODULOS_API.md` (simetria 1 interface = 1 módulo) | **misto** | O *princípio* (simetria, peças, promoção) é método; a stack (flutter_modular/Express) é escolha do caso |
| `database/PADROES_BANCO.md`, frameworks (campos/configs/mensagens), decisões D*/DP*/R* | **setes** (conteúdo do caso zero) | Evidência/treino; o *formato* das decisões numeradas é método |
| Agente setes-form-builder, telas, módulos, DDLs | **setes** | Fábrica do caso zero |

### 3.1 Censo retroativo COMPLETO (2026-07-19 — 1º ensaio da Fase 1 da engine)

Decisão do Valdo na mesma conversa: deixar o acervo existente sem avaliação geraria
débito para a engine — e classificar o próprio repositório É dogfooding da fase de
avaliação. Executado por 4 agentes paralelos com as mesmas regras; verificado por grep.

**Resultado: 88 documentos marcados** (fora do censo: `codigo-aprendizado/` — código de
estudo copiado, não documento de conhecimento):

| Escopo | Qtde | % | Leitura |
|---|---|---|---|
| `metodo` | 16 | 18% | Núcleo portável: 3 skills genéricas + git-github inteiro (10) + proteção de secrets + prompt de testes Flutter + este rascunho |
| `misto` | 20 | 23% | Candidatos a destilação: arquiteturas de simetria (app+api), agente/skill Delphi→TS, roteiro de análise de legado, padrões de banco, revisar-ddl, mensagem-e-validacao, skills de formulário/tela-de-processo, docs organizacionais da raiz (índice/mapa/organização) |
| `setes` | 52 | 59% | Caso zero: prompts de fase, docs de módulo, setups da infra, HISTORICO completo |

Interpretação para o produto: ~40% do acervo (metodo+misto) tem valor direto de engine —
mais do que a estimativa inicial de 20–30%. A fila de destilação futura é a coluna
`misto` (20 arquivos): em cada um, separar o princípio (vira doc de método) da instância
(fica no caso). Colisão resolvida no censo: `prompt_fase2_campos_configuraveis.md` usava
`**Escopo**:` como lista de projetos → renomeada para `**Projetos**:`.

## 4. Questões em aberto (candidatas às futuras rodadas — NÃO numerar ainda)

- Forma do produto: serviço conduzido pela Setes (consultoria assistida por engine) ×
  ferramenta licenciada que a outra empresa opera? (maturidade sugere começar serviço)
- A engine promete stack de saída fixa (a da Setes) ou stack por cliente? (simetria
  app×api é método; Flutter/Express são escolha)
- Legado suportado: só Delphi/Firebird no início, ou linguagem-agnóstico desde já?
- Onde vive a base RAG por cliente (isolamento, sigilo de código de terceiros)?
- Precificação: por projeto de migração × assinatura da engine?
- Nome do produto.
- **PI / propriedade intelectual**: o método evolui em dois empregos (Setes + Softworks).
  Onde vive a cópia canônica do método (cofre neutro do Valdo?) e como manter limpa a
  fronteira "método é meu × código é do empregador"? (não é jurídico resolvido — é
  disciplina de separação documentada desde já)

## 5. Diário de insights (append-only — uma linha por insight, qualquer sessão)

| Data | Insight | Origem |
|---|---|---|
| 2026-07-19 | Financeiro imutável + multi-tenant + tb_crashlytics são decisões de negócio que já servem de substrato de ML/telemetria | conversa estratégica |
| 2026-07-19 | Guardião conceitual detectou maquete real (trio tb_partnership) no 1º uso — evidência de que a fase "destilar conceitos" funciona | Parceria v2 (índice 5.5) |
| 2026-07-19 | O diferencial não copiável é o processo humano-no-comando (rodadas de decisão), não o acesso a LLM | conversa estratégica |
| 2026-07-19 | Classificar o acervo existente ≠ separar: marcação retroativa é barata, reversível e É a Fase 1 da engine ensaiada em casa (apontado pelo Valdo contra a minha proposta de marcar só ao tocar) | censo retroativo |
| 2026-07-19 | 4 agentes paralelos com regras idênticas classificaram 88 docs em ~4 min com 1 única colisão — evidência de que a fase de avaliação da engine é paralelizável | censo retroativo |
| 2026-07-19 | Softworks (2M LOC/30 anos) = caso nº 2 real; testa ESCALA, dimensão que o caso zero não testa — em 2M LOC a fase de avaliação exige grafo+RAG, não leitura direta | conversa Softworks |
| 2026-07-19 | O caso 2 chegou com as peças que o caso zero não tinha (indexação em grafo, memória dedicada, Obsidian) e SEM as que o caso zero tem (processo/governança) — a engine é a união; nenhum caso sozinho a completa | conversa Softworks |
| 2026-07-19 | Higiene de multi-caso: conteúdo de caso nunca cruza empresas; só o método viaja; destilar `misto` sob demanda do caso que precisa | conversa Softworks |
| 2026-07-19 | **Kit v0.1 materializado em `Infra-IA/engine-kit/`** (README + Fase 0 + 5 skills + segurança git neutralizada). 1ª destilação de `misto` concluída: avaliar-repositorio-legado (do Agent_Analise, + Fase 1.0 de dimensionamento/indexação). A neutralização por agente FUNCIONA como fase da engine (11 docs, varredura final zero resíduos) — e sinalizou 1 string em formato de chave real (era exemplo; o Valdo encurtou o texto para eliminar a ambiguidade): neutralizar acervo é também auditoria de vazamento, e falso positivo tratado ainda melhora o doc | montagem do kit |
| 2026-07-19 | Caso nº 2 (sync) fechou prompt em 3 rodadas NO MESMO DIA — o método generaliza de telas ERP para integração de sistemas; a Rodada 0 com leitura do CÓDIGO real (achados A1–A10) foi decisiva: o rascunho pedia "revisar", o código revelou "reescrever a gravação" (defasado 2 fases em relação ao destino) | revisão do sincronizador |
| 2026-07-19 | Princípio de direção do Valdo p/ modernização: **"o sistema que será aposentado é o que se adapta ao formato novo, nunca o contrário"** (D15/D22 do prompt do sync) — o legado paga o custo da tradução; o destino permanece limpo. Candidato a regra do método no kit | revisão do sincronizador |
| 2026-07-19 | Padrão de indexação entre gerações de sistema: chave de negócio (CPF/CNPJ) reindexa; sem chave de negócio → UUID gerado no destino e DEVOLVIDO ao legado, que o persiste (tb_empresa.externalCode) — o legado vira portador da chave do sistema novo. Generalizável a qualquer migração com ids locais conflitantes | revisão do sincronizador |
| 2026-07-19 | Implementação das 6 ondas em UM DIA com agentes paralelos guiados por MOLDES (2 moldes escritos à mão → 8 endpoints por agentes, depois 9): o padrão "molde + DDL real + regras inegociáveis" escala; TODOS os agentes acharam código legado quebrado contra o DDL real (colunas inexistentes) — evidência de que "reescrever guiado pelo esquema" > "traduzir o código antigo" | implementação do sync |
| 2026-07-19 | Sistema imutável por eventos × legado que só conhece estado: a ponte é a SEMÂNTICA DE ESPELHO (estado do legado = evento único upsertável; imutabilidade plena só para eventos nascidos no destino). Candidata a padrão do método p/ qualquer migração com event sourcing no destino | implementação do sync |
| 2026-07-19 | 409 com code `*_NOT_SYNCED` transforma a ordem de dependências em problema AUTO-CURÁVEL: a fila do legado reenvia no próximo ciclo e a carga converge sem orquestração central — padrão p/ qualquer sync incremental com dependências | implementação do sync |
| 2026-08-03 | Análise do harness-kit (D:\harness-kit): a engine tem retenção mas NÃO tem auto-avaliação — o loop tracer→evaluator→meta-harness (trace por sessão, score composto, fronteira de Pareto, candidato promovido/rejeitado por dados) é a peça de método que falta no kit (candidata: skill `evaluate-harness`). Segundo achado: o SDK `hrns` (abstração IAgentRunner com runners Claude/Copilot/Cursor/Gemini) é arquitetura de referência pronta p/ a PORTABILIDADE entre ferramentas que a visão da engine exige. Adotados de imediato (destilados p/ skills-genericas): gate socrático + QA adversarial. Rejeitados: project-memory/scope-refinement (colidem com simetria Infra-IA e human-in-command das rodadas) | análise harness-kit |
| 2026-09-02 | Indexação de legado com SUBPROJETOS copiados na mesma árvore: ferramenta de grafo que resolve units por nome global escolhe a cópia errada e DESCARTA silenciosamente as arestas de herança do projeto principal (god nodes viraram a soma de dois projetos). Regra de método: resolução escopada ao corpus + validar god nodes contra uma verdade conhecida antes de confiar no índice. Bônus: grafo 100% local custou 0 tokens contra 3,3M da rotulagem LLM de agosto, que não definia módulos | Gestao2016-Knowledge F1 (LEARNINGS #2/#3) |
