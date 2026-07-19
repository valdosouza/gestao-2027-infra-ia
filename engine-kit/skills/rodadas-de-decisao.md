# Skill: Rodadas de Decisão (rascunho → prompt executável)

**Quando usar**: sempre que houver um rascunho de ideias (texto solto, anotações, DDL
colado, prompt mestre do dono do negócio) que precisa virar um plano executável de
fase/projeto. É a Fase 3 da engine: o dono do negócio DECIDE; nada se decide por ele.
**Origem do método**: caso zero — um rascunho de centenas de linhas virou prompt
fechado com dezenas de decisões numeradas, DDL validado e código com testes.
**Escopo**: metodo

---

## O método

O rascunho não é corrigido silenciosamente. Ele é **organizado como está** e os
problemas viram **questões numeradas** que o dono do projeto decide. Cada decisão é
registrada permanentemente. Repete-se até zerar pendências.

### Rodada 0 — Organizar
1. Reestruturar o rascunho no formato padrão de prompt de fase:
   `Contexto → Objetivos → Workflow → Especificações agrupadas → Critérios de sucesso`
2. Manter o conteúdo fiel; marcar problemas com ⚠️ no ponto exato + referência à questão
3. Criar a seção **"⚠️ Questões pendentes (rodada N)"** — cada item:
   **problema → evidência → correção sugerida** (perguntas objetivas, com opções quando possível)

### Rodadas 1..N — Decidir e aplicar
1. O dono responde as questões (no chat ou editando o arquivo direto — sempre
   **releia o arquivo antes de editar**, ele muda entre rodadas)
2. Aplicar cada decisão no documento; varrer resíduos com busca textual (nomes antigos,
   colunas removidas, referências órfãs)
3. Mover decisões para a seção permanente **"Decisões registradas"** (numeração
   contínua entre rodadas — vira o diário de bordo do projeto)
4. Novos problemas descobertos ao aplicar → nova rodada de questões
5. Convergência: **"Questões pendentes: Nenhuma"** + lista do que ficou explicitamente
   para fases futuras

### Fechamento — Executar
1. Gerar os entregáveis (scripts, código, docs) **citando o número das decisões nos
   comentários** (`-- decisão 14`) — rastreabilidade total
2. Validar programaticamente (parser SQL, compilador, testes) antes de entregar
3. Copiar o prompt final para a pasta do projeto na base de conhecimento e destilar
   padrões novos para os docs de referência; o rascunho de origem vai para HISTORICO/

## Regras que fazem funcionar

- **Nunca decidir pelo dono** em item de arquitetura/negócio — sugerir com
  "(Recomendado)" e esperar
- **Nunca perder decisão**: se foi decidido, entra na seção permanente com número —
  e números NUNCA são reaproveitados/renumerados
- **Sempre varrer resíduos** após cada mudança de nomenclatura (busca pelos nomes antigos)
- **Distinguir** "corrigir" (erro objetivo) de "decidir" (escolha entre alternativas
  válidas) — só o segundo vira questão
- Itens adiados vão para "Fora de escopo / fases futuras" — não somem, mudam de lugar
- Decisão pode ser REVISADA em rodada futura: ganha nota "REVISADA pela decisão N",
  nunca é apagada

## Estrutura de seções do prompt final

```markdown
# Prompt — Fase N: <nome>
## Contexto
## Objetivos (numerados)
## Workflow (fluxos passo a passo, com tabelas de decisão)
## <Especificações agrupadas por domínio>
## Entregáveis (tabela: item → o que faz → quando)
## Decisões registradas (1..N, permanente)
## Questões pendentes (zerada no fechamento)
## Fora de escopo desta fase
## Critérios de sucesso (numerados, testáveis)
```

## Por que isto é o diferencial da engine

Qualquer um pluga IA num repositório legado. O que não se copia é o processo
humano-no-comando: a IA organiza, evidencia e sugere; o dono do negócio decide; a
decisão vira registro permanente rastreável até a linha de código. Em sistemas com
décadas de história, é isso que impede a reescrita de repetir os erros que o legado
já cometeu — e de perder os acertos que ele acumulou.
