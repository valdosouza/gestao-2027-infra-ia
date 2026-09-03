# Gestão 2016 (legado Delphi) — índice do aprendizado

**Escopo**: setes

Espelho de conhecimento do código legado em `Infra-IA/codigo-aprendizado/Gestao2016/`.
Corpus construído sob instrução do AUTOR do sistema (Valdo), com cada afirmação
VERIFICADA contra o código antes de ser registrada.

## Como este corpus é construído

1. O autor dita a frente (o que é, quem dispara, o que grava, o que não pode acontecer)
2. Cada afirmação é conferida no código-fonte real
3. Divergência entre memória do autor e código é REGISTRADA, nunca silenciada —
   é o achado mais valioso do assessment (ver `guardiao-conceitual` e a Fase 1 do
   `engine-kit/skills/assess-legacy-repo`)
4. Nada é documentado sem estar no código; o que falta é marcado com ⚠️
5. **Revisão de desenho com sugestão de IA (regra explícita desde 2026-08-16, pedido
   do autor)**: quando o mapeamento expõe uma decisão de desenho para a web (peça
   lego/nuvem), a IA PROPÕE alternativas de desenho proativamente, marcadas como
   SUGESTÃO, com prós/contras — e a decisão é SEMPRE do Valdo (mesma governança do
   `guardiao-conceitual`/`setes-conceito`). Sugestão aceita vira decisão registrada;
   recusada é arquivada com o porquê.

## Governança da iniciativa "Investigação de Conhecimento" (aberta 2026-09-02)

Prompt mestre auto-retomável: `Infra-IA/prompts/PROMPT-GESTAO2016-KNOWLEDGE.md`.
Workspace da iniciativa (Decisão 1 do Valdo): **`D:\Gestao2016\Infra-IA\Gestao\`** — dentro do projeto legado.
Estado em `STATUS.md` de lá (SEMPRE começar por ele) · contexto/escopo/taxonomia em `BRIEFING.md` · lições em
`LEARNINGS.md` · fases em `01-grafo/` … `05-regras/`. Os seis docs abaixo permanecem AQUI (espelho do Gestao2027). Escopo do código: `Apps\` FORA (a remover), `Roteador\` = projeto próprio.

## Documentos

| Documento | Conteúdo |
|---|---|
| [processo-pedido-nota.md](processo-pedido-nota.md) | Venda / Compra / Ajuste — tb_pedido → tb_nota_fiscal (o tronco do ERP) — Q1–Q12 fechadas |
| [tributacao.md](tributacao.md) | O coração fiscal (`componentes/tributacao.pas`) — mapeamento fonte-da-verdade: Regra de Tributação, motor, P1–P12 mapeados (faltam P13/P14), redesenho §6.5 |
| [tributacao-plano-web.md](tributacao-plano-web.md) | PLANO WEB: o que construir mantendo o processo — modelo `tb_tax_rule` + peças, pipelines conforme legislação, o que não vai |
| [tributacao-plano-legado.md](tributacao-plano-legado.md) | PLANO LEGADO: correções cirúrgicas (B1–B9), limpezas (L1–L7), otimizações (O1–O3), verificação por XML antes/depois |
| [geracao-nfe-hierarquia.md](geracao-nfe-hierarquia.md) | Frente da autorização (GUARDADA 2026-08-16, pendências na §5): árvore TFr_GeraNfe3x (12 classes, ~9.950 linhas), diagnóstico das 3 heranças, modelo web = pipeline + strategy + hooks |
| [financeiro.md](financeiro.md) | Financeiro INSTRUÍDO E VERIFICADO 2026-08-16 (conceito/nascimento/meios/vida/morte + cheque/cartão/caixa; QF1–QF3 fechadas; descontada e fechamento adiados; §6 = prontidão para código) |

**Prompt de fase em otimização**: `Infra-IA/prompts/prompt_fase_faturamento_financeiro.md`
(Rodada 1 aberta — 22 decisões herdadas registradas + 6 questões R1-Q1..Q6)

## Grafo de navegação (graphify)

**Vigente (2026-09-02)**: `D:\Gestao2016\graphify-out\graph.json` — 37.559 nós / 58.651 arestas,
100% AST/regex local (0 tokens LLM), sem Apps/Roteador; Roteador isolado em `D:\Gestao2016\Roteador\graphify-out`.
Cobertura e lacunas: `D:\Gestao2016\Infra-IA\Gestao\01-grafo\COBERTURA.md`. Rebuild SÓ por
`D:\Gestao2016\.claude\graphifyuild_graph.py` (resolvedor de units homônimas — LEARNINGS #2).

SUPERADO: `codigo-aprendizado/Gestao2016/graphify-out/graph.json` (15/08, cópia de julho) — 36.540 nós, 49.181 arestas,
99% extraído de AST real. Serve para NAVEGAR (quem chama quem, o que quebra se eu mexer
aqui): `graphify explain`, `query`, `affected`, `path`, `god-nodes`.

⚠️ **As comunidades do graphify NÃO definem módulos**: o clustering agrupa por
acoplamento de `imports` e no Delphi toda unit importa `env.pas`/`STQuery.pas`
(coesão medida: 0,01–0,02). Exemplo concreto do erro: `UN_Pedido_Vda` foi parar na
comunidade "NFe XML Generation & Config". A definição de módulo vem do AUTOR.
