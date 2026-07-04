# Skill genérica: Atualizar o Infra-IA (como reter conhecimento)

**Quando usar**: ao FINAL de qualquer tarefa que gerou conhecimento novo — decisão arquitetural, padrão, procedimento repetível, documentação de módulo, lição aprendida. Obrigatória, mesmo sem pedido explícito do Valdo.
**Tempo**: 5–15 min

---

## 1. O que reter (teste rápido)

Retenha se a resposta for SIM para qualquer uma:
- Uma sessão futura SEM esta conversa precisaria disso para não errar?
- Foi uma decisão do Valdo que não está no código? (decisões nunca se perdem)
- É um procedimento que vai se repetir? (→ skill)
- Mudou o estado de um projeto? (fase concluída, tabela renomeada, endpoint novo)

NÃO retenha: o que o código/git já registra por si; detalhes só desta conversa.

## 2. Onde cada tipo entra

| Tipo de conhecimento | Destino | Formato |
|---|---|---|
| Decisão arquitetural | Seção "Decisões arquiteturais registradas" do prompt de fase em `Infra-IA/<projeto>/prompt_faseN_*.md` | Numeração contínua (nunca renumerar); código/SQL citam o nº nos comentários |
| Padrão permanente (vale p/ sempre) | Doc de referência do domínio (ex.: `database/PADROES_BANCO.md`) | Destilado, sem histórico — só a regra vigente |
| Procedimento repetível | `<projeto>/skills/<verbo-objeto>.md` ou `skills-genericas/` se valer p/ qualquer projeto | Quando usar + workflow numerado + casos reais |
| Documentação de módulo/feature | `Infra-IA/<projeto>/NN-NOME.md` (numeração sequencial: 01, 02...) | Status, arquivos, como testar |
| Prompt em otimização (rascunho/trabalho) | `Infra-IA/prompts/` | Versão de trabalho; nunca na raiz do D:\Gestao2027 |
| Prompt de fase concluído | `Infra-IA/<projeto>/prompt_faseN_<nome>.md` | Cópia do prompt fechado; rascunho de origem vai para `HISTORICO/` |
| Análise/relato pontual | `HISTORICO/` | Com INDEX.md atualizado |

## 3. Atualizações obrigatórias em cadeia

Ao criar/alterar qualquer arquivo acima, atualize NA MESMA tarefa:

1. **`INDICE_CENTRAL.md`** — 4 pontos:
   - Lista de docs/skills do projeto na seção detalhada (marcar ⭐ NOVO)
   - Seção "Fluxos de Trabalho" se nasceu um fluxo novo
   - Tabela "Histórico de Atualizações" (data + o quê + versão)
   - Tabela "Mapa Rápido" (contagens/status) se mudou
2. **Estado do projeto mudou?** → atualizar `D:\Gestao2027\CLAUDE.md` (seção "Estado atual dos projetos") e o `CLAUDE.md` do repo afetado
3. **Sessão Cowork?** → atualizar também a memória persistente (arquivo do tema + MEMORY.md)
4. **Instrução antiga ficou obsoleta?** → não apagar: marcar como SUPERADA apontando para a decisão que a substituiu

## 4. Convenções de escrita

- Português; nomes de arquivo em kebab-case para skills, MAIUSCULAS.md para docs de referência
- Todo doc começa com: **Status/Versão, Origem (qual fase/conversa), Referências**
- Decisões citam o porquê em 1 linha (ex.: "MD5 mantido — decisão do Valdo, risco registrado")
- Skills têm seção "casos reais" quando nasceram de erros encontrados (ex.: `revisar-ddl.md`)

## 5. Checklist de saída (copiar na resposta final da tarefa)

- [ ] Conhecimento novo identificado e classificado (tabela acima)
- [ ] Arquivo criado/atualizado no lugar certo
- [ ] INDICE_CENTRAL.md atualizado (lista + histórico)
- [ ] CLAUDE.md atualizado se o estado do projeto mudou
- [ ] Memória Cowork atualizada (se aplicável)
- [ ] Nada obsoleto ficou sem marca de SUPERADO
