# Skill: Censo de Escopo (classificar o acervo do caso)

**Quando usar**: (a) ao instalar a engine num caso que JÁ tem documentação acumulada —
censo retroativo do acervo inteiro; (b) continuamente — todo arquivo novo/tocado na
base de conhecimento nasce classificado. Classificar o próprio repositório é a Fase 1
da engine aplicada a si mesma (dogfooding).
**Caso real de origem**: censo retroativo do caso zero (2026-07-19) — 88 documentos
classificados por 4 agentes paralelos em minutos, com 1 única colisão de nomenclatura;
revelou que ~40% do acervo era portável (estimativa prévia: 20–30%).
**Escopo**: metodo

---

## O princípio: marcar ≠ separar

- **Marcar** é barato, reversível (1 linha por arquivo) e paga imediatamente: a
  separação física futura vira um FILTRO, não uma arqueologia.
- **Separar** (extrair/mover/abstrair) é caro e erra quando feito cedo demais (regra
  dos três casos: abstração extraída de 1 caso é chute). Adie a separação; jamais a marcação.
- Deixar acervo existente sem avaliar = débito que cresce. O censo retroativo é
  obrigatório na instalação.

## Os três valores

Linha no cabeçalho de todo documento: `**Escopo**: metodo | <caso> | misto`

| Valor | Significado | Destino futuro |
|---|---|---|
| `metodo` | Portável para qualquer empresa/legado (processo, prática genérica) | Kit da engine |
| `<caso>` | Conteúdo do caso (domínio, DDL, telas, decisões de negócio, setups da infra) | Fica no caso — NUNCA cruza empresas |
| `misto` | Princípio portável amarrado à stack/domínio do caso | Fila de destilação: separar princípio (→ metodo) da instância (fica no caso), SOB DEMANDA de um caso novo |

## Workflow do censo retroativo

1. **Inventário**: liste todos os `.md` da base. EXCLUA código copiado/vendorizado
   (repositórios de estudo não são documentos de conhecimento — registre a exclusão).
2. **Regras escritas UMA vez**: definição dos 3 valores + formato de inserção (a linha
   entra no FIM do bloco de metadados colado ao título; sem reformatar nada além) +
   instrução "se já existe linha `**Escopo**:`, pular e REPORTAR".
3. **Fan-out paralelo**: divida os arquivos em grupos por pasta e lance N agentes com
   as MESMAS regras. Cada agente lê só o cabeçalho (~30 linhas) — o suficiente para
   classificar; lê mais apenas em dúvida real. Dicas de classificação por grupo ajudam,
   mas o agente julga pelo conteúdo.
4. **Retorno estruturado**: cada agente devolve `arquivo | escopo | justificativa
   (≤8 palavras)` + pulados. Colisões de nomenclatura reportadas viram correção
   explícita (ex.: renomear a linha antiga que usava o mesmo nome com outro sentido).
5. **Verificação programática**: busca (grep) por `^\*\*Escopo\*\*:` — confira 1
   ocorrência por arquivo e some por valor. Números não conferem = investigar.
6. **Consolidação**: tabela-resumo (valor × quantidade × leitura do que significa) no
   diário do produto + histórico do índice central. A coluna `misto` é a fila de
   destilação nomeada.

## Regra contínua (pós-censo)

Entra na skill de retenção de conhecimento e no arquivo de regras da raiz: **todo
arquivo novo ou tocado ganha a linha de Escopo**. Sem exceção — é o que mantém o
acervo 100% classificado para sempre.

## Lições registradas (casos reais)

- Classificação paralela com regras idênticas é consistente: 4 agentes, 88 docs,
  1 colisão (e era problema real de nomenclatura, não divergência de julgamento).
- O censo muda a percepção do acervo: o núcleo portável tende a ser MAIOR do que a
  intuição estima — sem censo, valor de produto fica invisível.
- Colisão clássica: "Escopo" já usado com outro sentido em docs antigos → renomear o
  campo antigo (preserva o significado) e aplicar o novo.
