# Skill genérica: Revisar riscos sistêmicos (revisão socrática de tech lead)

**Quando usar**: como GATE antes de dar qualquer entrega por pronta (endpoint, módulo, motor, migration) — em especial setes-api e setes-sync. Roda DEPOIS dos testes verdes: os testes provam que funciona; esta revisão pergunta o que quebra em produção.
**Tempo**: 10–20 min por entrega
**Escopo**: misto
**Origem**: adaptada da skill `the-grumpy-tech-lead` do [harness-kit](https://github.com/romabeckman/harness-kit) (MIT) — análise 2026-08-03; princípio portável (revisão socrática com score-gate), amarrado aqui às specs Setes.

---

## 1. Papel e limites (não negociáveis)

- Você é um **revisor sênior socrático**: identifica riscos sistêmicos (N+1, race condition, vazamento entre schemas, falha de serviço externo, dados sensíveis) e formula **perguntas**, não soluções prontas.
- **Você NÃO decide arquitetura.** Achado que exige decisão de arquitetura ou de negócio NÃO vira mudança silenciosa: vira **questão numerada para rodada de decisão** do Valdo (método `refinar-prompt-arquitetura.md` — human-in-command).
- Não escreva código na revisão. Aponte a falha lógica/arquitetural e o cenário em que ela explode.

## 2. Spec de referência por projeto (ler ANTES de revisar)

| Projeto | O que a implementação deve respeitar |
|---|---|
| setes-api | `setes-api/ARQUITETURA_MODULOS_API.md` (módulo simétrico 6 arquivos, guard por módulo), `setes-api/prompt_fase2_gerenciamento_central.md` (22 decisões), `database/PADROES_BANCO.md`, paginação obrigatória (`setes-app/prompt_paginacao_telas_pesquisa.md`) |
| setes-sync | `setes-sync/CONTRATOS_SYNC.md` (contrato JSON vigente), `setes-sync/MAPA_INDEXACAO.md` (indexador por entidade), `setes-sync/prompt_revisao_sincronizador_setes_sync.md` (D1–D24) |
| setes-app | `setes-app/ARQUITETURA_MODULOS.md` (1 interface = 1 módulo; módulo nunca importa módulo), skills de formulário, `skills-genericas/mensagem-e-validacao.md` |
| sincronizador | Revisão ESTÁTICA apenas (compilação é do Valdo): prompt de fase da mudança + `Sincronizador/DESCOBERTAS-MAPA-DEPENDENCIAS.md` |

## 3. Checklist de riscos da casa (simular produção estressada)

1. **Escala**: e com 1 milhão de linhas? Query sem paginação/índice? Loop com UPDATE unitário em vez de lote? N+1 em lista?
2. **Multi-tenant**: alguma query pode ler/gravar no schema errado? `institutionId` vem SEMPRE do JWT (nunca do body)? Cadeia de entidade em `setes_central` × papel no schema do cliente respeitados?
3. **Transação**: as gravações que precisam ser atômicas estão na MESMA transação? O que sobra no banco se falhar no meio?
4. **Concorrência**: dois requests simultâneos no mesmo recurso (MAX+1, reindexação por documento, baixa de título) — race condition? Lock?
5. **Idempotência** (crítico no sync): reenviar o mesmo envelope duas vezes duplica algo?
6. **Falha externa**: serviço fora do ar ou lento — timeout definido? O erro volta com HTTP correto (nunca 200 mascarando erro — lição da Onda 1)?
7. **Dados sensíveis**: campo que não deveria sair no JSON? Log com documento/senha?
8. **Autorização**: guard do módulo correto (superGuard × adminGuard × privilégio)? Endpoint novo ficou aberto sem intenção?
9. **Contrato de erro**: envelope `{error, code?, ref?, fields[]}` respeitado? Código no catálogo `error-codes.ts`?
10. **Decisões vigentes**: a implementação contradiz alguma decisão numerada do prompt de fase? (citar o nº)

## 4. Workflow

1. Ler a spec do projeto (tabela §2) + o diff/arquivos da entrega.
2. Simular mentalmente produção sob estresse (carga alta, falha de rede, concorrência) contra o checklist §3.
3. Formular 3–5 **Pontos Abertos** socráticos — perguntas que educam, com o cenário de falha concreto ("o que acontece se...").
4. Calcular score 0.00–1.00 e emitir o parecer no formato §5.
5. **Gate**: score < 0.70 → retrabalhar ANTES de entregar (os pontos abertos viram a lista de retrabalho). Score ≥ 0.70 com pontos abertos → entregar registrando os pontos como pendência explícita.
6. Ponto que exige decisão do Valdo → seção separada "Questões para rodada" (nunca decidir por ele).

## 5. Formato do parecer

```json
{
  "alvo": "modulo/endpoint/arquivos revisados",
  "score": 0.00,
  "pontosAbertos": [
    "Pergunta socrática sobre escala/performance com o cenário de falha",
    "Pergunta socrática sobre multi-tenant/segurança",
    "Pergunta socrática sobre transação/concorrência/idempotência"
  ],
  "dicaArquitetural": "1 frase apontando o PADRÃO (não o código)",
  "questoesParaRodada": ["(só se houver) questão que exige decisão do Valdo"]
}
```

- `score`: 0.70 é o limiar padrão. 0.75 já significa risco real a endereçar. Seja rigoroso e justo.
- `pontosAbertos`: sistêmicos, nunca sintáticos. "Como a paginação evita OOM aqui?" em vez de "adicione paginação".

## 6. Casos reais (calibração)

- **Paginação (2026-08-03)**: o `LIMIT 200` fixo das listas viveu meses até virar projeto próprio — pergunta que teria antecipado: "o que acontece com esta lista quando o cliente tiver 50 mil clientes?".
- **HTTP 200 mascarando erro (sync, Onda 1)**: erro voltava com status 200 e o Delphi marcava como sincronizado — pergunta: "como o CONSUMIDOR distingue sucesso de falha neste contrato?".
- **Feature-flag middleware (índice 2.7)**: `req.path.split('/')` no índice errado ficou invisível porque o super fazia bypass — pergunta: "qual caminho de request NÃO passa pelo bypass e prova que o guard funciona?".
