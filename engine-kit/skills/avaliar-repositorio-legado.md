# Skill: Avaliar Repositório Legado (Fase 1 da engine)

**Quando usar**: primeiro contato da engine com um sistema legado — antes de qualquer
conceito, decisão ou linha de código novo. O produto desta fase é DOCUMENTAÇÃO FIEL do
que está implementado, que alimenta a base de conhecimento e as fases seguintes.
**Origem**: destilado do roteiro de análise do caso zero (migração de um serviço de
sincronização legado) + lição de escala do caso 2 (~2M linhas / 30 anos).
**Escopo**: metodo

---

## Papel do agente analisador

Engenheiro de software sênior especialista em análise de sistemas legados, migração de
dados e documentação técnica. A função é **ler o código-fonte e documentar fielmente o
que está implementado** — sem inferir intenções, sem sugerir melhorias, sem inventar
mapeamentos ausentes. (Melhorar é papel das Fases 2–3; aqui é fotografia.)

## Fase 1.0 — Dimensionar antes de ler (a lição de escala)

O primeiro ato é medir: linhas, arquivos, linguagens, idade, módulos.

- **Repositório pequeno** (lê-se em sessões): análise direta por agentes, fan-out por
  pasta/módulo com regras idênticas (o padrão do censo paralelo).
- **Repositório grande** (milhões de linhas): leitura direta NÃO escala. Indexe antes:
  grafo do código (quem chama quem, quem usa qual tabela) e/ou busca semântica
  (embeddings) sobre o fonte. A análise então navega o índice e lê só o que o índice
  aponta. Sem esta etapa, a avaliação vira amostragem disfarçada de censo.
- Em ambos: defina UNIDADES DE ANÁLISE (módulo, tela, entidade, integração) e mantenha
  um inventário com status — a avaliação é incremental e retomável, nunca "big bang".

## Contexto a preencher por caso (parametrização)

| Parâmetro | Exemplo |
|---|---|
| Stack de origem | <linguagem/framework legado> + <banco de origem> |
| Stack de destino | <linguagem/framework novo> + <banco/API de destino> |
| Ordem de prioridade de leitura | models de origem → models de destino → controllers/regras → configs/utilitários |
| Avisos de descarte | planos abandonados no código que devem ser IGNORADOS (ex.: framework X abandonado) |

## Estrutura obrigatória da documentação gerada

Markdown, seções fixas. Não omitir nenhuma — sem informação, escrever `⚠️ Não encontrado no código`.

1. **Visão geral do sistema** — até 10 linhas: o que faz, como os componentes se
   conectam, fluxo geral dos dados.
2. **Inventário de componentes** — tabelas por tipo (models de origem, models de
   destino, controllers/regras), cada um com responsabilidade, dependências e status
   ✅ Completo / ⚠️ Parcial / ❌ Vazio.
3. **Mapeamento DE-PARA por entidade** — por entidade: campo origem, tipo, campo
   destino, tipo, transformação aplicada. Regras: campo de origem sem destino →
   `⚠️ NÃO MAPEADO`; campo de destino sem origem → `⚠️ SEM ORIGEM`; transformação
   (cálculo, conversão) descrita objetivamente; **nunca inferir** mapeamento que não
   esteja explícito no código.
4. **Fluxo de dados por entidade** — lista sequencial: leitura → filtros → transformações
   → gravação/envio → tratamento de sucesso/erro (ou `⚠️ Não implementado`).
5. **Integrações externas identificadas** — endpoints/serviços/arquivos que o legado
   consome ou expõe, com payload e autenticação identificada.
6. **Pendências e inconsistências** — tudo que está incompleto, comentado, com TODO ou
   inconsistente. Objetivo, sem soluções. Severidade: 🔴 bloqueia migração de um
   conjunto de dados · 🟡 perda de dados/comportamento incorreto · 🟢 dívida sem
   impacto imediato.
7. **Resumo executivo** — tabela de contagens (entidades totais/completas/parciais/sem
   mapeamento, componentes completos/vazios, pendências críticas) + conclusão em 2–3
   frases: o que está funcional × o que falta.

## Regras que nunca devem ser quebradas

1. **Nunca** documentar algo que não esteja no código — se não existe, sinalizar com ⚠️
2. **Nunca** sugerir melhorias — isso é papel das fases seguintes
3. **Nunca** ignorar uma inconsistência — tudo vai para a seção 6
4. **Nunca** omitir uma seção — preencher com ⚠️ se necessário
5. Respeitar os avisos de descarte do caso (código de planos abandonados é ruído)

## Saída e encadeamento

- A documentação entra na base de conhecimento no espelho do projeto legado, com
  `**Escopo**: <caso>`.
- As **estruturas suspeitas de maquete** (seção 3 com mapeamentos tortuosos, guardas
  estranhas, tabelas-espelho de telas) viram fila de entrada do `guardiao-conceitual.md`.
- As **pendências 🔴/🟡** e as escolhas de rota viram questões das `rodadas-de-decisao.md`.
- O que a análise ensinar sobre COMO analisar → destilar para o diário do produto.

## Checklist final antes de entregar

- [ ] Todas as seções preenchidas
- [ ] Nenhum mapeamento inferido sem base no código
- [ ] Campos sem destino/origem marcados com ⚠️
- [ ] Inconsistências todas na seção 6
- [ ] Resumo executivo bate com os números das seções
- [ ] Fila de maquetes suspeitas e de questões entregue às fases 2–3
