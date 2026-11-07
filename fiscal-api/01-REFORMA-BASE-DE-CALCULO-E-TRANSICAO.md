# Reforma Tributária (LC 214/2025) — base de cálculo, transição e regras do Simples: o que os textos oficiais dizem

**Escopo**: método (só fatos oficiais e leituras citadas; nada de cliente, credencial nem código de produto — este repositório é PÚBLICO)
**Origem**: levantamento feito em 07/11/2026 na frente do ERP Desktop (Gestão 2026), a pedido do Valdo, para ser reaproveitado pelo setes-app, setes-api e pelas APIs fiscais (`fiscal-api`, `nfe-api`, `nfse-api`)
**Companheiros**: `02-REFORMA-CONTA-POR-DENTRO-PRECO-FINAL.md` (a conta), `03-REFORMA-NFSE-IBSCBS.md` (NFS-e)
**Convenção**: **[texto]** = está escrito na norma citada · **[leitura nossa]** = interpretação, ainda sem confirmação do fisco · **[não achei]** = procurado nas fontes locais e não encontrado

## Fontes lidas (versões `.txt` guardadas na árvore do ERP Desktop)

`D:\Gestao2016\Docs\ReformaTributaria\Apuracao\fontes\` (repositório SVN privado; **não duplicadas aqui**):

| Arquivo | O que é |
|---|---|
| `legislacao\lc214-2025-norma-atualizada.htm.txt` | LC 214/2025 com as alterações da LC 227/2026 e da LC 235/2026 (texto da Câmara dos Deputados) |
| `legislacao\decreto12955-2026-regulamento-cbs-publicacao-original.htm.txt` | Decreto 12.955, de 29/04/2026 (Regulamento da CBS) |
| `cgsn\resolucao-cgsn-140-2018-multivigente.json.txt`, `resolucao-cgsn-190-2026.json.txt` | Resoluções do CGSN (Simples Nacional) |
| `nfe\NT_2025.002_v1.53_RTC.pdf.txt`, `NT_2026.005_v1.00_Simples_Nacional.pdf.txt`, `NT_2026.008_v1.01_valor_liquido.pdf.txt` | Notas técnicas da NF-e |
| `cgibs\ato-conjunto-*.txt` | Atos Conjuntos RFB/CGIBS |

**Lacuna das fontes:** a LC 123 consolidada **não** está na pasta (o Planalto bloqueia o download automático); o que vale dela aqui vem reproduzido na LC 214 e nas resoluções do CGSN. O texto extraído de PDF/HTML quebra "Art." e o número em linhas diferentes: normalize espaços antes de buscar.

## 1. Calendário da transição: 2026 a 2033 (LC 214, Título VIII, e arts. 542 e 543)

**[texto]** A transição **não termina em 2030**: vai de 2026 a 2033. Só o ICMS e o ISS saem ano a ano; o PIS/COFINS sai de uma vez em 2027.

| Ano | O que a lei prevê | Artigos |
|---|---|---|
| 2026 | Teste: IBS 0,1% (alíquota estadual) e CBS 0,9%, compensados com PIS/COFINS | 343, 346, 348 |
| 2027 | **PIS/COFINS extintos** (leis revogadas em 01/01/2027); CBS cheia, com alíquota de referência fixada pelo Senado; IBS 0,05% estadual + 0,05% municipal (até 2028) | 542, 344, 349 |
| 2027–2028 | CBS = alíquota de referência − 0,1 ponto percentual | 347 |
| 2029 | IBS estadual/municipal de referência (Senado); **ICMS/ISS reduzidos em 10%** | 349, 360, 361, 367 |
| 2030 | ICMS/ISS reduzidos em 20%; marco de recalibração da CBS (art. 368) | 362, 367, 368 |
| 2031 | ICMS/ISS reduzidos em 30% | 363, 367 |
| 2032 | ICMS/ISS reduzidos em 40% | 364, 367 |
| 2033 | **ICMS e ISS extintos** (revogação do Decreto-lei 406/68, da LC 87/96 e da LC 116/2003 em 01/01/2033); IBS integral | 543, 367 |

- **[leitura nossa]** Os pesos do art. 367 (receita-base dos entes subnacionais multiplicada por 10 em 2029, 5 em 2030, 10/3 em 2031, 10/4 em 2032 e 1 em 2033) refletem a participação do IBS de 10%, 20%, 30%, 40% e 100%.
- **IPI:** a LC 214 trata, no art. 454, só dos produtos ligados à Zona Franca de Manaus (alíquota zero a partir de 01/01/2027). A regra geral do IPI está na Constituição (EC 132), **[não achei]** nas fontes locais.

## 2. Base de cálculo do IBS e da CBS (LC 214, art. 12)

- **[texto]** Base = **valor da operação**: o valor integral cobrado pelo fornecedor a qualquer título, incluindo acréscimos, juros, multas, descontos **condicionais**, transporte cobrado, seguros e taxas (§ 1º).
- **[texto]** **Não integram a base** (§ 2º): o próprio IBS/CBS ("por fora"), o IPI, os descontos **incondicionais**, reembolsos de terceiros e, **de 01/01/2026 a 31/12/2032, o ICMS, o ISS, o PIS e a COFINS**.
- **[texto]** NT 2025.002 v1.53, regra UB16-10: o `vBC` do IBS/CBS é a soma de `vProd`, `vServ`, `vFrete`, `vSeg`, `vOutro`, `vII`, menos `vDesc`, `vPIS`, `vCOFINS`, `vICMS`, `vICMSUFDest`, `vFCP`, `vFCPUFDest`, `vISSQN`, mais `vIS` (confira o texto completo antes de implementar).
- **[texto]** Valor do IBS: `vIBSUF = vBC × pIBSUF/100 − vDif − vDevTrib`, com **tolerância de 0,01** a mais ou a menos (regra UB35-10).

## 3. Simples Nacional

- **[texto]** A base do DAS é a **receita bruta mensal** (CGSN 140, arts. 2º II e 16; LC 123, art. 18). A receita bruta é o produto da venda de bens e serviços, o preço dos serviços e o resultado em conta alheia, **excluídas as vendas canceladas e os descontos incondicionais**. Entram também o custo do financiamento nas vendas a prazo, gorjetas, royalties e patrocínio (art. 2º, § 4º); ficam de fora a venda de ativo imobilizado, juros e multas por atraso, brinde e amostra grátis (§ 5º).
- **[texto]** Na nota eletrônica, a CGSN 190 (art. 59, § 9º) manda indicar a base e os tributos "nos campos próprios, conforme o manual" da NT. A **NT 2026.005 não define a base**: só diz que `pIBSSN`/`pCBSSN` são a "alíquota efetiva" e `vIBSSN`/`vCBSSN` o "valor devido pelo Simples Nacional".
- **[texto]** O comprador não optante tem crédito "em montante equivalente ao cobrado por meio desse regime único" (LC 123, art. 23, § 1º-A, redação da LC 227/2026).
- **[leitura nossa]** Valor por item = alíquota efetiva × receita bruta da operação (`vProd + frete + seguro + outras despesas − desconto`). Nenhum texto lido sustenta descontar ICMS ou IPI dessa base.
- **[não verificado]** A lei exclui só o desconto **incondicional**; se o sistema subtrai todo o `vDesc`, é preciso saber se ele pode ser condicional.

### O percentual do crédito de ICMS (`pCredSN`): as fontes se contradizem

| Fonte | Faixa usada | Quando vale |
|---|---|---|
| **[texto]** CGSN 140, art. 60, § 1º | **mês anterior** à operação, por {[(RBT12 × alíquota nominal) − PD] ÷ RBT12} × % de distribuição do ICMS | hoje |
| **[texto]** LC 123, art. 23, § 2º (redação da LC 227/2026) e CGSN 190, art. 58, § 1º-A | **mês de operação**; no mês de início de atividade, a menor alíquota (§ 3º / § 1º-B) | a partir de 01/01/2027 |

A CGSN 190 **não revoga nem altera** o art. 60. **[leitura nossa]** A lei complementar prevalece: de 2027 em diante vale o **mês da operação**, e a CGSN deve ser ajustada.

## 4. Devolução em 2027 de venda feita antes de 2027

- **[texto]** LC 214, **art. 379** (reproduzido no Decreto 12.955, **art. 603**): os bens recebidos em devolução a partir de 01/01/2027, relativos a vendas anteriores a essa data, dão direito a **crédito de CBS** correspondente ao valor do PIS/Pasep e da COFINS que incidiram sobre as respectivas operações. O crédito só pode ser usado para **compensar a CBS** (vedados a compensação com outros tributos e o ressarcimento).
- **[texto]** Contexto: o art. 542 revoga o PIS/COFINS a partir de 01/01/2027 (Lei 10.637, arts. 1º a 5º-A; Lei 10.833, arts. 1º a 16; Lei 9.718, arts. 2º a 8º-B; LC 70, arts. 1º a 6º, entre outras); o cap. V (art. 378 em diante) trata dos créditos que sobram.
- **[leitura nossa]** O crédito nasce na **apuração da CBS** (PIS/COFINS da venda original, proporcional ao que voltou). A nota de devolução continua com PIS/COFINS zerados, porque não há incidência em 2027.
- **[texto]** NT 2025.002 v1.53, UB12-10, exceção 1: a NF-e de devolução (`finNFe=4`) ou complementar (`finNFe=2`) que referencia NF-e de data anterior a 2027 **não é obrigada** a levar o grupo IBS/CBS.
- **[não achei]** Campo da NF-e para esse crédito (só existem `vCredPres` e `vCredPresCondSus`, de crédito presumido) nem orientação nos manuais da RFB, na API de apuração e nas resoluções do CGIBS sobre como apropriá-lo na plataforma da CBS.

## 5. O que ainda precisa de resposta do fisco

1. Qual total o `vPag` deve igualar quando o `vNF` e o `vNFTot` diferem (regra de NT mais antiga, não presente nas fontes).
2. Como apropriar o crédito do art. 379 na plataforma da CBS.
3. Qual das duas leituras da NT 2026.008 v1.01 será validada para o `vProd` (ver `02-REFORMA-CONTA-POR-DENTRO-PRECO-FINAL.md`).
4. Se o `pCredSN` de 2027 será mesmo o do mês da operação, e a correção da CGSN 140, art. 60.
