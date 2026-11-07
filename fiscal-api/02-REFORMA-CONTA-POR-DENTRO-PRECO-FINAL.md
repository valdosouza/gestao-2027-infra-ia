# Reforma Tributária — a conta "por dentro" do ICMS com o preço final (IBS/CBS dentro do preço)

**Escopo**: método (fórmulas, exemplo oficial e vetores de teste; nada de cliente, credencial nem código de produto — este repositório é PÚBLICO)
**Origem**: ERP Desktop (Gestão 2026), 07/11/2026; validada em números. Serve ao setes-app, ao setes-api e às APIs fiscais que precisarem calcular o item de uma NF-e/NFC-e de 2027
**Pré-requisito**: `01-REFORMA-BASE-DE-CALCULO-E-TRANSICAO.md` (base do IBS/CBS, art. 12 da LC 214)
**Convenção**: **[texto]** · **[leitura nossa]** · **[não verificado]** (ver o `01`)

## 1. O problema

Em 2027 o item da nota leva IBS e CBS **por fora** da própria base (LC 214, art. 12, § 2º, I). O ICMS **não integra a base do IBS/CBS** de 2026 a 2032 (art. 12, § 2º, V). Em sentido contrário, a SEFA-PR (Consulta 48/2026, citada na pergunta 2854 do portal SAC) diz que o IBS e a CBS **integram a base do ICMS** do regime normal, calculado "por dentro". Parece circular: o ICMS depende do IBS/CBS, e a base do IBS/CBS depende do ICMS.

## 2. Decisão de produto que desfaz a circularidade: o preço cadastrado é o preço final

Se o lojista registra R$ 100,00 e esse é o valor que o cliente paga (todos os tributos dentro), então:

- o **ICMS** é calculado sobre esse valor, como hoje: `ICMS = t × P`;
- a **base do IBS/CBS** sai por álgebra, depois do ICMS.

**Símbolos (por item, regime normal):** `P` = valor cobrado do item (já com tudo, sem IPI); `t` = alíquota do ICMS; `a` = soma das alíquotas **efetivas** de IBS (UF + município) e de CBS, já com as reduções; `S` = a base do IBS/CBS que o sistema calcularia sem a correção, isto é, a soma da regra UB16-10 com o `vProd` igual ao valor cobrado (`S = P − ICMS − PIS − COFINS − …`).

**Fórmulas [leitura nossa, conferida com o exemplo oficial]:**

1. `ICMS = t × P`
2. `vBC (IBS/CBS) = S ÷ (1 + a)`; para o caso simples, `vBC = (P − ICMS) ÷ (1 + a)`
3. `vIBS = vBC × aIBS` e `vCBS = vBC × aCBS`
4. `vProd (líquido de IBS/CBS) = P − (vIBS + vCBS)`; `vItem = P`

**Parâmetro de exclusão do IBS/CBS da base do ICMS** (só para quem tem decisão judicial): `ICMS = t × P ÷ (1 + a − t × a)`. Fórmula fechada, sem circularidade; não implementada no ERP Desktop.

## 3. Conferência com o exemplo da SEFA-PR

Preço sem ICMS, IBS e CBS = R$ 100,00; IBS 0,1%; CBS 8,7% (alíquotas só de exemplo); ICMS 12%.

| Passo | Valor |
|---|---|
| Preço final `P` = 108,80 ÷ (1 − 12%) | R$ 123,64 |
| ICMS = 12% × 123,64 | R$ 14,84 |
| Base do IBS/CBS = (123,64 − 14,84) ÷ 1,088 | R$ 100,00 |
| IBS | R$ 0,10 |
| CBS | R$ 8,70 |
| `vProd` = 123,64 − 8,80 | R$ 114,84 |

O resultado é **igual ao exemplo oficial da SEFA-PR, centavo a centavo**.

## 4. Fechamento em centavos

Com valores arredondados a 2 casas, a soma `vProd + vIBS + vCBS` pode ficar 1 centavo fora de `P`. **[texto]** A NT 2025.002 v1.53 (regra UB35-10) aceita **tolerância de 0,01** a mais ou a menos no valor do IBS e da CBS. **Simulação** (30.000 itens aleatórios, ICMS de 0 a 19,5%, CBS de 8,7% a 11,2%): ajustando `vProd` e, quando preciso, 1 centavo no IBS ou na CBS **dentro dessa tolerância**, `vItem = P` em **100%** dos casos; em 8,9% foi preciso o ajuste de 1 centavo. Sem a tolerância, 9,4% dos itens ficariam 1 centavo fora.

Algoritmo usado (referência para quem implementar):

```python
from decimal import Decimal as D, ROUND_HALF_UP
import itertools
def r2(x): return x.quantize(D('0.01'), rounding=ROUND_HALF_UP)

def item_preco_final(P, t, a_ibs, a_cbs, tol=D('0.01')):
    """P = valor cobrado do item (D, sem IPI); t, a_ibs, a_cbs em fracao (0.12 = 12%)."""
    a = a_ibs + a_cbs
    icms = r2(P * t)
    vprod_real = P - ((P - P * t) / (1 + a)) * a            # solucao exata (nao arredondada)
    centavos = int((vprod_real * 100).to_integral_value())
    melhor = None
    for dv in range(-6, 7):                                  # procura o vProd (em centavos) perto da exata
        vprod = D(centavos + dv) / 100
        vbc = r2(vprod - icms)                               # UB16-10: vBC = vProd - vICMS (sem frete etc.)
        ibs0, cbs0 = r2(vbc * a_ibs), r2(vbc * a_cbs)
        for di, dc in itertools.product((0, 1, -1), (0, 1, -1)):
            ibs, cbs = ibs0 + D(di) / 100, cbs0 + D(dc) / 100
            if abs(ibs - vbc * a_ibs) > tol or abs(cbs - vbc * a_cbs) > tol or ibs < 0 or cbs < 0:
                continue
            chave = (abs(vprod + ibs + cbs - P), abs(di) + abs(dc), abs(dv))
            if melhor is None or chave < melhor[0]:
                melhor = (chave, vprod, vbc, ibs, cbs)
    return icms, melhor        # melhor[0][0] == 0 quando fecha vItem == P
```

### Vetores de teste (gerados com o algoritmo acima; IBS 0,1%)

| P (preço final) | ICMS % | CBS % | ICMS | vBC IBS/CBS | vIBS | vCBS | vProd | Ajuste de 1 centavo |
|---|---|---|---|---|---|---|---|---|
| 123,64 | 12 | 8,7 | 14,84 | 100,00 | 0,10 | 8,70 | 114,84 | não |
| 100,00 | 0 | 8,7 | 0,00 | 91,91 | 0,09 | 8,00 | 91,91 | não |
| 1000,00 | 17 | 11,2 | 170,00 | 745,73 | 0,75 | 83,52 | 915,73 | não |
| 59,90 | 18 | 8,7 | 10,78 | 45,14 | 0,05 | 3,93 | 55,92 | não |
| 15,37 | 12 | 11,2 | 1,84 | 12,16 | 0,01 | 1,36 | 14,00 | não |
| 2499,99 | 19,5 | 8,7 | 487,50 | 1849,71 | 1,85 | 160,93 | 2337,21 | **sim** |
| 0,99 | 7 | 8,7 | 0,07 | 0,85 | 0,00 | 0,07 | 0,92 | não |
| 987,65 | 4 | 11,2 | 39,51 | 851,88 | 0,85 | 95,41 | 891,39 | não |

Em todas as linhas: `vProd + vIBS + vCBS = P`.

## 5. Ordem do cálculo no motor

1. calcular o ICMS (e ST, FCP, IPI) como hoje, sobre o valor cobrado;
2. obter as **alíquotas efetivas** de IBS (UF + município) e de CBS, com as reduções (60%, 100% etc.) e a data de vigência;
3. só então calcular o `vBC` do IBS/CBS (`S ÷ (1 + a)`) e os valores;
4. por fim, o `vProd` líquido e o `vItem`.

Se o motor calcula o `vBC` **antes** das alíquotas efetivas (como acontece no ERP Desktop hoje), é preciso inverter essa ordem. Casos de borda para testar: ICMS zero (Simples com regime regular de IBS/CBS), reduções de alíquota, data 31/12/2026 contra 01/01/2027 (2026 não pode mudar), Imposto Seletivo (a fórmula acima não o cobre).

## 6. A ambiguidade da NT 2026.008 v1.01 (pergunta ao fisco, não opção do cliente)

O texto se contradiz sobre o `vProd` de 2027:

- **Leitura A (introdução da v1.01):** `vProd` **desconsidera** IBS/CBS/IS; `vItem` inclui todos os tributos; `vNFTot` = soma dos `vItem`. Com preço final: `vProd` líquido, `vNF` do XML líquido, `vUnCom`/`vUnTrib` líquidos (se a regra `vProd` = `vUnCom` × `qCom`, de NT mais antiga, continuar valendo) e `vNFTot` = total pago.
- **Leitura B (observação do campo I11 e regra VB01-10, que ficaram da v1.00):** `vProd` **contém** IBS/CBS. Com preço final: `vProd` e `vNF` ficam como hoje, e só o `vNFTot` muda (= `vNF`).
- Nas duas leituras o `vBC` do IBS/CBS é o mesmo (`S ÷ (1 + a)`). O que difere é só o preenchimento de `vProd`, `vUnCom`, `vNF` e `vNFTot`.
- **[proposta do ERP Desktop, não confirmada]** Um parâmetro **global** (não por cliente), entregue por arquivo de atualização como as alíquotas da CBS, para alternar entre A e B sem publicar versão nova.
- **[não verificado]** Qual total o `vPag` precisa igualar quando o `vNF` e o `vNFTot` diferem. A confirmação virá do Portal NF-e e da homologação de dezembro.

## 7. Decisões de produto tomadas no ERP Desktop (para comparar com a web)

| Ponto | Decisão do ERP Desktop |
|---|---|
| Preço do item | **só preço final**; sem opção de preço líquido (só voltaria se um cliente de venda para empresa pedisse) |
| `pCredSN` do Simples | continua um percentual manual por estabelecimento; deve ser o da faixa do **mês da operação** |
| Base do IBS/CBS do Simples | só a receita do item; sem variantes |
| PIS/COFINS da devolução de venda anterior a 2027 | sem opção na nota (valor zero); o crédito de CBS do art. 379 é item da **apuração** |
| Exclusão do IBS/CBS da base do ICMS | sem parâmetro, até algum cliente pedir |
