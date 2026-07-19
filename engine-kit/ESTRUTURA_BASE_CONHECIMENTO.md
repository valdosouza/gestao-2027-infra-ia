# Estrutura da Base de Conhecimento (Fase 0 — montar o vaso)

**Escopo**: metodo
**Papel**: antes de avaliar qualquer código, monte o lugar onde o conhecimento vai
morar. Ferramenta de memória sem processo vira coleção de notas; o vaso é o processo.

---

## Princípios

1. **Simetria projeto ↔ conhecimento**: cada projeto de código `<raiz>\<projeto>` tem
   seu espelho `<raiz>\<base-conhecimento>\<projeto>`. Nenhum documento nasce solto.
2. **Regras na raiz**: um único arquivo de regras para agentes de IA na raiz do
   workspace (ex.: `CLAUDE.md`) — curto, apontando para a base; a base é a memória
   longa, o arquivo de regras é o cartão de embarque.
3. **Índice central com histórico versionado**: um `INDICE_CENTRAL.md` que mapeia
   docs/skills/agentes por projeto E acumula uma tabela de histórico (data → o quê →
   versão). O histórico é a memória episódica do caso.
4. **Nada se sobrescreve às cegas**: instrução superada não é apagada — é marcada
   SUPERADA apontando para a decisão que a substituiu.
5. **Todo documento carrega metadados**: Status/Versão, Origem, Referências e
   **Escopo** (`metodo | <caso> | misto` — ver `skills/censo-de-escopo.md`).
6. **Markdown puro** com links `[[assim]]` quando útil — a base inteira abre como
   vault do Obsidian de graça (grafo visual incluído).

## Esqueleto de pastas

```
<raiz-do-workspace>/
├── CLAUDE.md                       ← regras para agentes de IA (única exceção de arquivo solto)
├── <projeto-1>/  <projeto-2>/ ...  ← código
└── <base-conhecimento>/
    ├── INDICE_CENTRAL.md           ← mapa + histórico versionado (COMECE SEMPRE POR AQUI)
    ├── ORGANIZACAO_PASTAS.md       ← tabela de decisão: onde aloca cada arquivo novo
    ├── skills-genericas/           ← método (as skills deste kit)
    ├── <projeto-1>/                ← espelho: docs, prompts de fase, skills do projeto
    │   ├── INDEX.md
    │   ├── prompt_faseN_<nome>.md  ← prompts FECHADOS (com decisões numeradas)
    │   └── skills/
    ├── prompts/                    ← rascunhos e prompts EM otimização
    └── HISTORICO/                  ← superados, análises pontuais, rascunhos de origem
```

## Template mínimo do arquivo de regras (raiz)

```markdown
# <Caso> — Regras para agentes de IA

## ANTES DE QUALQUER TAREFA: consulte <base-conhecimento>/
1. Comece por INDICE_CENTRAL.md
2. Antes de criar/alterar objeto de domínio: skills-genericas/guardiao-conceitual.md
3. Para transformar rascunhos em prompts de fase: skills-genericas/rodadas-de-decisao.md
4. Ao terminar tarefa que gerou conhecimento novo: skills-genericas/reter-conhecimento.md
5. Escopo obrigatório: todo arquivo novo/tocado na base ganha `**Escopo**: metodo | <caso> | misto`

## Estado atual dos projetos (<data>)
- <projeto>: <fase/estado, com link para o prompt vigente>
```

## Template mínimo do índice central

```markdown
# Índice Central — <base-conhecimento>
**Versão**: 1.0 (acompanha o histórico)  **Última atualização**: <data>
**Escopo**: misto

## Mapa rápido por projeto
| Projeto | Docs | Skills | Status |

## Projetos detalhados
### <projeto> — função, docs (com 1 linha de resumo cada), skills, agentes

## Fluxos de trabalho recomendados
### "Quero <tarefa comum>" → passos numerados com os docs a ler

## Histórico de atualizações
| Data | O quê | Versão |
```

## A tripla de memória (ferramenta × processo)

| Camada | Ferramenta (exemplos) | Processo (este kit) |
|---|---|---|
| Recuperação do código | indexador/grafo do código, busca semântica | Fase 1 alimenta a base com o resultado |
| Memória do agente | memória persistente da ferramenta de IA | `reter-conhecimento` decide O QUE entra |
| Leitura humana | Obsidian sobre a base | índice + histórico + decisões numeradas |

A ferramenta guarda; o processo decide o que merece ser guardado, onde, e como será
reencontrado. Sem as duas camadas juntas, ou se perde conhecimento, ou se afoga nele.
