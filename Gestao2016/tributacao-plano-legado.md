# Tributação — Plano de Correção e Otimização no LEGADO

**Escopo**: setes
**Fonte**: bugs e inconsistências encontrados no mapeamento `tributacao.md`
(P1–P12), com decisões do autor, 2026-08-16.
**Princípio**: correções CIRÚRGICAS em `componentes/tributacao.pas`, sem
reestruturar o legado — a reestruturação é o plano da web. Toda correção aguarda
compilação/validação do Valdo; sugerir teste antes/depois por nota (comparar XML).

---

## Fase 1 — BUGS de cálculo (afetam valor de imposto)

| # | Bug | Onde | Correção | Risco |
|---|---|---|---|---|
| B1 | PIS CST 99 com base > 0 seta alíquota mas NÃO calcula `vPIS` (COFINS irmão calcula) | `:3424-3428` | replicar o bloco do COFINS (`:3484-3489`): `vPIS := vBC × p/100` | baixo — isolado |
| B2 | Base IBS/CBS subtrai `vICMS` DUAS vezes (`ICMS.vICMS` + `ICMS.vicms` — Pascal case-insensitive, MESMO campo) | `:3199-3200` | remover uma das linhas | baixo — mas alto IMPACTO se reforma ligada |
| B3 | Base IBS/CBS NÃO soma `vFrete` (fórmula oficial comentada no código manda somar) | `:3192-3206` | adicionar `+ Pc_Prod.vFrete` | baixo |
| B4 | CST 51 via MANUAL sem frete na base (via regra tem — regra manda incluir) | `:2735-2737` | passar `Pc_Prod.vFrete` à `Fn_CalcBaseICMS` como na via regra (`:2575`) | baixo |
| B5 | CST 90 via MANUAL com base CHEIA (via regra usa base reduzida `TRB_RD_BS_ICMS`) | `:2787` | usar `Fn_CalcBaseICMS(TRB_RD_BS_ICMS, ...)` como em `:2627` | baixo |
| B6 | Base FCP-ST sem seguro/outras — diverge de `Fn_CalcBaseICMSST` (Q30: unificar) | `:376` | substituir o cálculo inline por chamada a `Fn_CalcBaseICMSST` | baixo |
| B7 | Base IPI = mercadoria + frete; RIPI art. 190 manda incluir seguro + demais acessórias cobradas do comprador (desconto incondicional já está fora — ok pelo STF RE 567.935) | `:3042` | `vBC := FValorMercadoria + vFrete + vSeg + vOutro` (resolver o comentário "precisamos avaliar") | baixo |
| B8 | ISSQN: `cMunFG` sobrescrito pelo IBGE da cidade do DESTINATÁRIO e alíquota da cidade do destinatário — decisão: município do PRESTADOR | `:3582` (sobrescrita de `:3545`) e `:3537` | remover a sobrescrita; alíquota da cidade do ESTABELECIMENTO | médio — muda NFS-e emitida; validar com prefeitura piloto |
| B9 | Desempate de regras: fallback final `locate('TRB_CODPRO', CodigoEstado)` passa código do ESTADO no campo PRODUTO — códigos de UF (41/42/43) colidem com ids reais de produto → regra ERRADA selecionada quando existir `TRB_CODPRO = código da UF` | `:951` | trocar o valor para o código do PRODUTO (`ITF_CODPRO`) | baixo de aplicar; impacto ALTO quando dispara (regra errada silenciosa) |

Ordem sugerida: B2/B3 primeiro se a reforma estiver ligada em algum cliente
(valor de imposto novo errado); senão B1 → B4/B5 → B6/B7 → B8 (o único com
efeito externo sensível).

## Fase 2 — LIMPEZAS (sem efeito de cálculo)

| # | Item | Onde | Ação |
|---|---|---|---|
| L1 | Linha morta do rastreio ST (critério `TRB_PRODUTO > 0` comentado; Q20: comportamento atual correto) | `:1965` | apagar o comentário |
| L2 | Bloco ICMS dentro de `Pc_DefineISSQN` (resíduo da conjugada — Q29: em desuso) | `:3530-3534` | remover com a descontinuação da conjugada |
| L3 | `gRed.pAliqEfet` do cadastro (`aliq_efe`) é lido e IMEDIATAMENTE sobrescrito pelo recalculado | `:3163-3165` (CBS; idem UF/Mun) | escolher UMA fonte (recalcular é o atual; remover a leitura morta do cadastro) |
| L4 | `TRB_AQ_SISCOMEX` selecionado no SQL da regra e nunca lido no cálculo (campo VIVO — usado fora; Q32) | `:502` | manter o campo; remover do SELECT do motor OU documentar por que está lá |
| L5 | Descontinuados a expurgar quando conveniente: `UN_Fatura_Srv`, `Un_Fatura_Web`, `ControllerPedidoVenda` + `TObjOrderSale`/`saveObjWeb`/`FillDataObjeto`/`ValidasaveObjWeb` | — | exclusão na revisão de versão (já decidido) |
| L6 | Métodos MORTOS na tributacao.pas (chamadas comentadas em `:2082/:2085/:2090`): `Pc_DefineRemetente`, `Pc_DefineDestinatario`, `Pc_DefineCasasDecimais` — as versões vivas estão em `un_geranfe3X.pas` (destinatário `:1005` com heurística p/ indicador inválido; casas decimais `:1076` correta) | tributacao.pas | remover métodos + chamadas comentadas (o "bug" da Q35 morre junto) | nenhum — código inalcançável |
| L7 | `un_geranfe3X.pas:1104`: `Lc_Tam_CodPro` comparado antes de inicializar (init em `:1113`) | un_geranfe3X.pas | inicializar antes do 2º loop | baixo |

## Fase 3 — OTIMIZAÇÕES estruturais (opcionais, maior alcance)

| # | Item | Motivação | Cuidado |
|---|---|---|---|
| O1 | Vias manual × regra: fazer a manual DELEGAR à via regra trocando só a fonte da alíquota | decisão Q21 ("manual segue a regra geral"); elimina a classe de bugs B4/B5 por construção | duplicação hoje é grande (2 × ~160 linhas por regime); testar CST a CST |
| O2 | Colapsar as ~20 rotinas `Pc_Obs_CST*/CSOSN*` em UMA consulta parametrizada por grupo | são o MESMO SQL com literal diferente (§P11) | manter os agregados específicos (CST 10 soma base/valor ST) |
| O3 | Extrair as bases para funções puras onde ainda é inline (FCP-ST → B6; ST já usa `Fn_CalcBaseICMSST`) | uma fórmula, um lugar | — |

## Verificação recomendada por correção

1. Escolher notas reais representativas do CST afetado (banco de homologação)
2. Gerar o XML ANTES e DEPOIS da correção; diff campo a campo
3. B8: emitir NFS-e em homologação da prefeitura piloto antes de liberar
4. Regra do gate de entrega do workspace (revisar-riscos-sistemicos +
   testar-adversarial) se a correção virar entrega formal
