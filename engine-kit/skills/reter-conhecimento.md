# Skill: Reter Conhecimento (o ciclo que faz a engine aprender)

**Quando usar**: ao FINAL de qualquer tarefa que gerou conhecimento novo — decisão,
padrão, procedimento repetível, documentação, lição aprendida. Obrigatória, mesmo sem
pedido explícito. É o que transforma cada migração em treino da engine: "humanos são
bons pensadores com péssima memória" — o processo compensa a memória.
**Escopo**: metodo

---

## 1. O que reter (teste rápido)

Retenha se a resposta for SIM para qualquer uma:
- Uma sessão futura SEM esta conversa precisaria disso para não errar?
- Foi uma decisão do dono que não está no código? (decisões nunca se perdem)
- É um procedimento que vai se repetir? (→ skill)
- Mudou o estado de um projeto? (fase concluída, estrutura renomeada, endpoint novo)

NÃO retenha: o que o código/git já registra por si; detalhes só desta conversa.

## 2. Onde cada tipo entra

| Tipo de conhecimento | Destino | Formato |
|---|---|---|
| Decisão de arquitetura/negócio | Seção "Decisões registradas" do prompt de fase vigente | Numeração contínua (nunca renumerar); código cita o nº nos comentários |
| Padrão permanente (vale p/ sempre) | Doc de referência do domínio (ex.: padrões de banco) | Destilado, sem histórico — só a regra vigente |
| Procedimento repetível | `<projeto>/skills/<verbo-objeto>.md` — ou skills genéricas se valer p/ qualquer projeto | Quando usar + workflow numerado + casos reais |
| Documentação de módulo/feature | `<projeto>/NN-NOME.md` (numeração sequencial) | Status, arquivos, como testar |
| Rascunho / prompt em otimização | `prompts/` | Versão de trabalho; nunca solto na raiz |
| Prompt de fase concluído | `<projeto>/prompt_faseN_<nome>.md` | Prompt fechado; rascunho de origem vai p/ HISTORICO/ |
| Análise/relato pontual | `HISTORICO/` | Com INDEX atualizado |
| **Insight de MÉTODO (portável)** | **Diário do produto da engine** (1 linha: data, insight, origem) | O que aprendido aqui serve a qualquer caso — destilado, sem conteúdo do caso |

## 3. Atualizações obrigatórias em cadeia

Ao criar/alterar qualquer arquivo acima, atualize NA MESMA tarefa:

1. **Índice central** — lista do projeto, fluxos (se nasceu um), tabela de histórico
   (data + o quê + versão), mapa rápido se mudou
2. **Estado do projeto mudou?** → arquivo de regras da raiz (seção "Estado atual")
3. **Há memória persistente do agente?** → atualizar o arquivo do tema + o índice dela
4. **Instrução antiga ficou obsoleta?** → não apagar: marcar SUPERADA apontando para a
   decisão que a substituiu

## 4. Convenções de escrita

- Nomes de arquivo: kebab-case para skills, MAIÚSCULAS.md para docs de referência
- Todo doc começa com: **Status/Versão, Origem, Referências** e **Escopo**
  (`metodo | <caso> | misto` — ver `censo-de-escopo.md`)
- Decisões citam o porquê em 1 linha (mesmo — e principalmente — as polêmicas:
  "mantido X — decisão do dono, risco registrado")
- Skills ganham seção "casos reais" quando nasceram de erros encontrados

## 5. Checklist de saída (copiar na resposta final da tarefa)

- [ ] Conhecimento novo identificado e classificado (tabela acima)
- [ ] Arquivo criado/atualizado no lugar certo, com Escopo
- [ ] Índice central atualizado (lista + histórico)
- [ ] Regras da raiz atualizadas se o estado do projeto mudou
- [ ] Memória do agente atualizada (se aplicável)
- [ ] Insight de método (se houve) destilado para o diário do produto
- [ ] Nada obsoleto ficou sem marca de SUPERADO
