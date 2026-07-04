# Skill genérica: Refinar Prompt de Arquitetura (rodadas de decisão)

**Quando usar**: sempre que houver um rascunho de ideias (txt solto, anotações, DDL colado) que precisa virar um prompt executável de fase/projeto.
**Tempo**: 2–5 rodadas curtas (assíncronas)
**Origem**: metodologia usada na Fase 2 (Gerenciamento Central) — rascunho de 538 linhas virou prompt fechado com 21 decisões, 5 scripts SQL validados e código refatorado com testes.

---

## O método

O rascunho não é corrigido silenciosamente. Ele é **organizado como está** e os problemas viram **questões numeradas** que o dono do projeto decide. Cada decisão é registrada permanentemente. Repete-se até zerar pendências.

### Rodada 0 — Organizar
1. Reestruturar o rascunho no formato padrão de prompt de fase:
   `Contexto → Objetivos → Workflow → DDL/Especificações agrupadas → Critérios de sucesso`
2. Manter o conteúdo fiel; marcar problemas com ⚠️ no ponto exato + referência à questão
3. Criar a seção **"⚠️ Questões pendentes (rodada N)"** — cada item: **problema → evidência → correção sugerida** (perguntas objetivas, com opções quando possível)

### Rodadas 1..N — Decidir e aplicar
1. Usuário responde as questões (pode responder no chat ou editar o arquivo direto — sempre **releia o arquivo antes de editar**, ele muda entre rodadas)
2. Aplicar cada decisão no documento; varrer resíduos com grep (nomes antigos, colunas removidas em seeds, referências órfãs)
3. Mover decisões para a seção permanente **"Decisões arquiteturais registradas"** (numeração contínua entre rodadas — vira o "diário de bordo" do projeto)
4. Novos problemas descobertos ao aplicar → nova rodada de questões
5. Convergência: **"Questões pendentes: Nenhuma"** + lista do que ficou explicitamente para fases futuras

### Fechamento — Executar
1. Gerar os entregáveis (scripts SQL, código, docs) **citando o número das decisões nos comentários** (`-- decisão 14`) — rastreabilidade total
2. Validar programaticamente (parser SQL, tsc, testes) antes de entregar
3. Copiar o prompt final para `Infra-IA/<projeto>/` e destilar padrões novos para os docs de referência (ex.: `database/PADROES_BANCO.md`)

## Regras que fazem funcionar

- **Nunca decidir pelo usuário** em item arquitetural — sugerir com "(Recomendado)" e esperar
- **Nunca perder decisão**: se foi decidido, entra na seção permanente com número
- **Sempre varrer resíduos** após cada mudança de nomenclatura (grep pelos nomes antigos)
- **Distinguir** "corrigir" (erro objetivo: PK em coluna inexistente) de "decidir" (escolha: MD5 vs bcrypt)
- Itens adiados vão para "Fora de escopo / fases futuras" — não somem, mudam de lugar

## Estrutura de seções do prompt final

```markdown
# Prompt — Fase N: <nome>
## Contexto
## Objetivos (numerados)
## Workflow (fluxos passo a passo, com tabelas de decisão)
## <Especificações/DDL agrupadas por domínio>
## Scripts/Entregáveis (tabela: script → o que faz → quando rodar)
## Decisões arquiteturais registradas (1..N, permanente)
## Questões pendentes (zerada no fechamento)
## Fora de escopo desta fase
## Critérios de sucesso (numerados, testáveis)
```
