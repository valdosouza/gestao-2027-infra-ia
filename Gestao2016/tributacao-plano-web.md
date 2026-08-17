# Tributação — Plano de Desenvolvimento na WEB

**Escopo**: setes
**Fonte**: derivado do mapeamento `tributacao.md` (P1–P12) + decisões do autor
(Q13–Q33), 2026-08-16. Este documento é o INSUMO DE PLANO: o que construir na web,
mantendo o processo do legado e corrigindo-o onde a legislação manda.
**Regra**: divergência entre este plano e o legado é INTENCIONAL apenas onde
listada em §5 (correções por decisão); todo o resto PRESERVA o processo.

---

## 1. O conceito que se preserva

**Regra de Tributação** = combinação destinatário × produto que, encontrada,
fornece CST/alíquotas por tributo; NÃO encontrada, INTERROMPE o faturamento com
alerta descritivo (produto a produto + critérios do destinatário) até o usuário
criar a regra. Tributação é POR ITEM; a nota é totalizador.

Processos que a web mantém intactos (refs → `tributacao.md`):

| Processo | Ref |
|---|---|
| Motor de busca com 6 sutilezas (coringas produto/cliente, precedência por NCM, estado exato×coringa, finalidade 0 no ajuste, operação presencial, RegraDireta) | §2 |
| Alerta "Regra não encontrada" — mesmo conteúdo: por produto (ST, finalidade, origem por extenso) + bloco do destinatário | §3 |
| Escolha de regra POR ITEM na digitação (gatilho do modo direto) | §P2.6b |
| Override do cliente: `IgnorarCalculoST` sobrescreve o ST do produto ANTES da busca (só na via combinada) | Q18 |
| Despacho por regime do emitente: CRT 3/2 → CST; CRT 1 → CSOSN | §P2.3 |
| Validação mínima local + Receita como validador final (códigos de erro dela sustentam o suporte) | Q17, §P12 |
| Assimetria de UF no ST: alíquota/MVA pela UF do DESTINATÁRIO; própria pela UF do EMITENTE | §P3.1 |
| MVA original × ajustada por decisão no faturamento; alívio do Simples | §P3.2 |
| FCP por UF × PREFIXO de NCM; 3 situações de incidência; FCP antes do regime p/ entrar no ST | §P7 |
| Rastreio do ST retido por unidade (CST 60/CSOSN 500), sem filtro de finalidade | §P2.8, Q20 |
| Estoque decidido pelo FLAG DO ITEM (`ITF_ESTOQUE`), direção pelo tipo da nota | processo-pedido-nota §5.5/Q12 |

## 2. O modelo de dados novo (redesenho §6.5)

`tb_tax_rule` (SELETOR: estado, consumidor, simples, ST, origem, finalidade, NCM,
produto, cliente, estabelecimento, natureza/sentido, obs, `tb_taxes_id`) + peças
1:1 opcionais — **presença = incidência**:

| Peça | Conteúdo | Decisão |
|---|---|---|
| `tb_tax_rule_icms` | CST/CSOSN (FK catálogo), modBC, alíq, reduções, diferimento, destaque | (b) da §6.5 |
| `tb_tax_rule_icms_st` | modBC ST, flag propagação de redução | (b) |
| `tb_tax_rule_ipi` | CST (FK), alíquota | rascunho do autor |
| `tb_tax_rule_pis_cofins` | UMA forma, `kind P|C` — "PIS = COFINS" por construção | Q24 + (d) |
| `tb_tax_rule_ii` | II + AFRMM + SISCOMEX + IRPJ + CSLL (código VIVO) | Q32 |
| — (sem peça ISS) | ISS vem de prestador/produto/cliente (§4) | Q27/Q28 + (c) |
| `tb_taxes` (existente) | reforma IBS/CBS — cabeçalho + esferas CBS/IBS_UF/IBS_Mun | Q15 |

Catálogos referenciados: tabelas de CST (`TBI_GRUPO` — hoje `TB_TRIB_ICMS_NR/SN`,
`TB_TRIB_IPI`...), observação fiscal, `TB_MVA_UF_NCM` e `TB_FCP_UF_NCM`.

**MVA/FCP ficam NO SCHEMA DO CLIENTE** — dado fiscal interpretável não se
compartilha entre institutions (decisão Q22; briga de contadores não se media).
Tela de MVA: própria, vinculada ao Estado, sem editar o Estado.

## 3. Pipelines por tributo (fórmulas conforme legislação)

- **ICMS próprio**: despacho por CST (tabela §P2.5) sobre
  `Fn_CalcBaseICMS = (mercadoria líquida + IPI? + frete_se_CST51) − red%`;
  exceção constitucional do IPI (contribuinte + finalidade 2/4 + IPI>0 → fora).
  **UMA implementação por CST; a via manual só troca a FONTE da alíquota** (Q21).
- **ICMS-ST**: `Fn_CalcBaseICMSST = (mercadoria + IPI + frete + seguro + outras)
  × (1−red%) × MVA` — IPI SEMPRE entra (Lei Kandir). MVA ajustada + alívio Simples.
- **FCP**: própria sobre mercadoria; **FCP-ST usa a MESMA `Fn_CalcBaseICMSST`**
  (Q30 — unificado).
- **IPI**: `vBC = mercadoria líquida de desconto incondicional + frete + seguro +
  outras acessórias` (RIPI art. 190 + STF RE 567.935 — Q25); alíquota da regra com
  fallback para a do item; só CSTs 00/49/50/99 calculam.
- **PIS/COFINS**: peça única `kind P|C`; default isento (07) zerado; despacho
  01/02 ad valorem, 03 por quantidade (`vAliqProd = valor unitário` — Q26
  confirmado), 99 híbrido — **com cálculo nos DOIS tributos** (Q24).
- **ISSQN**: **município e alíquota do PRESTADOR** (Q27); **item LC 116 POR
  produto-serviço** (Q28); retenção/exigibilidade/incentivo do cliente; despacho
  por `kind = 'S'` do item. SEM bloco ICMS (resíduo da conjugada — Q29).
- **II**: ad valorem pela peça; DI/adições pertencem à frente da Compra.
- **IBS/CBS**: base pela FÓRMULA OFICIAL (soma frete; ICMS subtraído UMA vez —
  Q33); padrão por esfera (alíquota → diferimento → redução → efetiva → valor);
  estruturas de crédito presumido/monofásico/seletivo MODELADAS, implementação
  quando o regulamento fechar (§P10.4).
- **Observações fiscais**: catálogo + UMA consulta parametrizada por grupo de CST
  (as ~20 rotinas do legado viram DADO — §P11).
- **Montagem do destinatário**: UMA montagem, ANTES do cálculo, com a heurística do
  legado vivo (`un_geranfe3X:1005`) para indicador de IE inválido: CNPJ+IE →
  contribuinte; CNPJ sem IE → não contribuinte; CPF → não contribuinte; NFC-e →
  não contribuinte (Q34 — hoje cálculo e XML podem divergir porque são DUAS
  montagens; na web isso morre por construção).

## 4. O que NÃO vai para a web

- Nota conjugada `OSR_G_NFSE_CONJ` (serviço dentro do XML da NF-e 55) — em desuso (Q29)
- `TRB_AQ_ISS` na regra (morto — ISS não vem da regra)
- Config global `OSR_G_NFSE_CL116` (substituída pelo campo por serviço)
- Vias manuais divergentes (CST 51 sem frete, CST 90 base cheia)
- `UN_Fatura_Srv`, `Un_Fatura_Web`, `ControllerPedidoVenda`/ponte `saveObjWeb` (descontinuados)

## 5. Correções INTENCIONAIS embutidas no desenho web

(divergências deliberadas do legado, por decisão do autor — detalhes/âncoras no
`tributacao-plano-legado.md`): B1 PIS 99; B2/B3 base IBS/CBS; B4/B5 vias manuais;
B6 base FCP-ST; B7 base IPI; B8 ISS prestador.

## 6. Regras transversais que o desenho web DEVE respeitar (§7 do tributacao.md)

- **Ordem de cálculo = grafo de dependências** (T1): rateio → IPI → ICMS (FCP antes
  do regime) → II → PIS/COFINS → ISSQN → **IBS/CBS por último** (base subtrativa)
- **Rateio com resíduo no último item** (T2) — totais fecham exatos por construção
- **Pilha de bases** (T3) — uma função por base, composição explícita
- **Persistir itens ANTES de gerar observações** (T6)
- **Configs migram TODAS para o Framework de Configurações** (T7) — nenhuma órfã
- **Reforma é camada PARALELA por anos** (T8) — dois cálculos simultâneos até 2033

## 6.1 Pendências de desenho antes do prompt de fase

- Ratificação formal dos itens (a)–(h) da §6.5 (parcialmente decididos)
- Passar o conceito `tb_tax_rule` + peças pelo `guardiao-conceitual`/`setes-conceito`
  e o DDL por `PADROES_BANCO.md` + `revisar-ddl` (cadeia obrigatória)
- **Frente da autorização** (`geracao-nfe-hierarquia.md`): modelo pipeline + strategy
  por modelo + hooks por processo DEFINIDO (§4 de lá); pendem o miolo de
  `AutorizaNFe`/`TrataRetorno` (máquina de estados real), contingência, eventos
  (CC-e — gap da Rodada 4 do sync), NFC-e offline/lote, e o confronto com
  `CONTRATOS_SYNC.md` (invoice-return-55/65/service)
