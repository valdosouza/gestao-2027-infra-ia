# tributacao.pas — o coração fiscal (frente ABERTA)

**Escopo**: setes
**Fonte**: instrução do autor (Valdo, 2026-08-16) + verificação no código
**Código**: `componentes/tributacao.pas` (5.847 linhas, classe `ttributacao`)
**Objetivo declarado**: documentar TODOS os pipelines para gerar este código na web.
**Regra de ouro (do autor)**: tributação no Brasil é crítica — na dúvida, PERGUNTAR.

## 1. O conceito: Regra de Tributação

O sistema busca em `TB_TRIBUTACAO` UMA regra que satisfaça a combinação
destinatário × produto. Sem regra, não há cálculo; sem cálculo, não há nota.

### Componentes da regra (instrução do autor)

**Destinatário**
- Estado da federação (ex.: PR/SC/RS)
- Consumidor final ou não
- Optante pelo Simples Nacional ou não
- Vendas com ST serão ignoradas ou não

**Produto**
- Origem da mercadoria (tabela nacional 0–8):
  | Cód | Significado |
  |---|---|
  | 0 | Nacional, exceto as indicadas nos códigos 3, 4, 5 e 8 |
  | 1 | Estrangeira — importação direta, exceto a indicada no código 6 |
  | 2 | Estrangeira — adquirida no mercado interno, exceto a do código 7 |
  | 3 | Nacional, conteúdo de importação > 40% e ≤ 70% |
  | 4 | Nacional, produção conforme processos produtivos básicos (Ajustes) |
  | 5 | Nacional, conteúdo de importação ≤ 40% |
  | 6 | Estrangeira — importação direta, sem similar nacional (lista CAMEX/gás natural) |
  | 7 | Estrangeira — mercado interno, sem similar nacional (lista CAMEX/gás natural) |
  | 8 | Nacional, conteúdo de importação > 70% |
- Finalidade para tributação:
  | Cód | Finalidade |
  |---|---|
  | 0 | Outras (notas de ajuste que não seguem a finalidade original) |
  | 1 | Revenda |
  | 2 | Produção |
  | 3 | Consignado |
  | 4 | Industrialização |
  | 5 | Consumo interno |
  | 6 | Prestação de serviço |
  | 7 | Ativo imobilizado |
- Sujeito a Substituição Tributária ou não
- NCM pode ser usado como parâmetro da regra

### Anatomia de TB_TRIBUTACAO (verificada — `model/tbltributacao.pas`, 40 campos)

Seletores da regra: `TRB_ESTADO`, `TRB_CONSUMIDOR`, `TRB_MICRO`, `TRB_ST_ICMS`,
`TRB_ORIGEM`, `TRB_PRODUTO` (= finalidade), `TRB_CODIGONCM`, `TRB_CODPRO`,
`TRB_CODEMP`, `TRB_CODMHA`, `TRB_CODNAT`, `TRB_SENTIDO`, `TRB_SUB_TRI`.

Resultado da regra (o que ela devolve): CSTs por imposto (`TRB_CODTBI_ICMS_NR`,
`TRB_CODTBI_ICMS_SN`, `TRB_CODTBI_IPI`, `TRB_CODTBI_PIS`, `TRB_CODTBI_CFS`),
modalidades de base (`TRB_CODMDB_ICMS_NR`, `TRB_CODMDB_ICMS_ST`), alíquotas
(`TRB_AQ_ICMS`, `TRB_AQ_IPI`, `TRB_AQ_PIS`, `TRB_AQ_COFINS`, `TRB_AQ_ISS`,
`TRB_AQ_DIF`, e de importação/apuração: `TRB_AQ_II`, `TRB_AQ_AFRMM`,
`TRB_AQ_SISCOMEX`, `TRB_AQ_IRPJ`, `TRB_AQ_CSLL`), reduções (`TRB_RD_AQ_ICMS`,
`TRB_RD_BS_ICMS`, `TRB_RD_BS_ICMS_ST`), flags (`TRB_DIFERIDO`, `TRB_DESTAQUE`),
observação fiscal (`TRB_CODOBS`) e `TB_TAXES_ID` (elo novo — ver Q15).

## 2. O motor de busca da regra (verificado)

SQL montado em `CriaSqlTributacao` (`tributacao.pas:542-567`), parâmetros ligados
em ~`:890-926`. O WHERE real:

```sql
WHERE ( (TRB_CODPRO = :produto) OR (TRB_CODPRO = 0) )          -- regra por produto OU genérica
  AND ( (TRB_CODEMP = :cliente) OR (TRB_CODEMP = 0) )          -- regra por cliente OU genérica
  AND ( (TRB_CODIGONCM = :ncm) OR (TRB_CODIGONCM IS NULL) OR (TRB_CODIGONCM = '') )
  AND ( TRB_ORIGEM     = :origem_do_produto )                   -- PRO_ORIGEM
  AND ( TRB_ST_ICMS    = :st )
  AND ( TRB_CONSUMIDOR = :consumidor_final )
  AND ( TRB_MICRO      = :optante_simples )
  AND ( TRB_CODMHA     = :estabelecimento )
  AND ( NAT_SENTIDO    = :sentido )                             -- It_Sentido (E/S)
  AND ( TRB_PRODUTO    = :finalidade )                          -- PRO_TRIBUTACAO
  -- estado: mesma UF → exato; interestadual → exato OU coringa (0/NULL)
ORDER BY TRB_CODIGONCM DESC                                     -- regra com NCM vence a genérica
```

Sutilezas confirmadas no código (a web NÃO pode perder nenhuma):

1. **Fallback genérico**: `TRB_CODPRO = 0` e `TRB_CODEMP = 0` são coringas — regra
   específica convive com genérica.
2. **Especificidade por NCM**: `ORDER BY TRB_CODIGONCM DESC` faz a regra com NCM
   preenchido vencer a sem NCM. É o mecanismo de precedência.
3. **Estado com dois regimes**: mesma UF exige `TRB_ESTADO` exato; interestadual
   aceita coringa `0`/`NULL` (`:563-565`).
4. **Finalidade 0 forçada no ajuste**: quando `It_Cd_Natureza > 0`, o sistema liga
   `NAT_CODIGO` e força `TRB_PRODUTO := '0'` (`:901-904`, comentário: "Por ser Ajuste
   de Estoque informar o CFOP e finalidade de tributação = 0") — é a materialização
   da "finalidade 0 - Outras" instruída.
5. **Operação presencial interestadual** (`:911-921`): se `IndicaPresenca = 1` e o
   destinatário é NÃO contribuinte (`IndicadorInscricaoEstadual` 1 ou 9) de outra UF,
   a busca usa a UF DO EMITENTE — cliente de fora comprando presencialmente é tratado
   como operação interna.
6. **Modo RegraDireta**: busca por `TRB_CODIGO` exato, pulando toda a combinação (Q16).

## 3. Regra não encontrada = processo INTERROMPIDO (verificado)

Instrução: o sistema acumula as características e emite alerta exato. Confirmado —
`It_M_Fisco: TStringList` (`:160`) acumula POR PRODUTO que ficou sem regra
(`:1169-1195`): código/descrição, se está sob ST, a finalidade (ou "não foi definido")
e a origem por extenso. No fim (`:1290-1317`) anexa o bloco do destinatário —
estado, Consumidor × Revenda, optante ou não do Simples — e dispara:

> "Regra de Tributação não encontrada para os seguintes Produtos. (...)
> Existe regra para estes critérios relacionado ao destinatário?"

`Result := False; exit` — o faturamento PARA, aguardando a criação da regra.

Alerta paralelo (não bloqueante hoje): Código de Benefício Fiscal com tamanho errado
(`It_M_CodBeficioFiscal`, `:1320-1330` — o `Result := False` está COMENTADO). → Q17

## 4. Tributação é POR ITEM (instruído + verificado)

"A NF-e não calcula impostos para a nota como um todo — item a item; a nota é apenas
um totalizador." Confirmado na estrutura: `Pc_AtualizarItens` percorre itens e chama
`Pc_AtualizarItensICMS/IPI/PIS/COFINS/ISSQN(Pc_Item)`; totais somados depois
(`Pc_SomaValorIBSCBS`, `Total.ICMSTot`).

## 5. Inventário de pipelines (levantamento inicial — cada um vira seção própria)

| # | Pipeline | Âncoras no código | Status do mapeamento |
|---|---|---|---|
| P1 | Busca da regra (motor) | `CriaSqlTributacao`, `Fc_tributacao`, `Fc_DefineTributacao` | ✅ mapeado (§2) |
| P2 | ICMS normal | `Pc_CalculaIcmsRegra`, `Pc_InformaIcmsManual`, `Fn_CalcBaseICMS`, `Fn_IPIIntegraNaBaseICMS` | ✅ mapeado (§P2) |
| P3 | ICMS ST | `Fn_CalcBaseICMSST` (MVA), `Pc_Abrir_Aliquota_UF_ST`, `Pc_Aliquota_UF_ST/NR`, `Pc_ControleRastreioICMSST`, `TRB_RD_BS_ICMS_ST` | ✅ mapeado (§P3) |
| P4 | IPI | `Pc_DefineIPI` (cálculo) + `Pc_AtualizarItensIPI` (grava) | ✅ mapeado (§P4-P5) |
| P5 | PIS / COFINS | `Pc_DefinePIS/COFINS` (cálculo) + `Pc_AtualizarItensPIS/COFINS` (grava) | ✅ mapeado (§P4-P5) |
| P6 | ISSQN | `Pc_DefineISSQN` (cálculo) + `Pc_AtualizarItensISSQN` (grava) | ✅ mapeado (§P6) |
| P7 | FCP (Fundo de Combate à Pobreza) | `tributaFCP(ncm)`, `CalculoFundoCombatePobreza` | ✅ mapeado (§P7) |
| P8 | Diferimento | `TRB_DIFERIDO`, `TRB_AQ_DIF` | ✅ coberto no P2 (CST 51) + §P8 |
| P9 | Importação | `Pc_DefineII`; DI/adições vivem FORA (frente da Compra) | ✅ mapeado (§P9) |
| P10 | **IBS/CBS (reforma tributária)** | família `Pc_DefineIBSCBS_*` + `Pc_AtualizaIBSCBS_*` | ✅ mapeado (§P10) |
| P11 | Observações fiscais CST/CSOSN | `Pc_Obs_CST00..90`, `Pc_Obs_CSOSN101..900`, `Pc_Busca_Obs`, `TRB_CODOBS` | ✅ mapeado (§P11) |
| P12 | Validações pré-XML | `Fc_Valida` + família | ✅ mapeado (§P12) |
| P13 | Montagem NF-e (dados) | `Pc_DefineDestinatario/Remetente`, `Pc_DefineCasasDecimais`, `CalculaValorMercadoria` | ✅ mapeado (§P13) |
| P14 | Geração da nota + itens | `Fc_DefineTributacao`, `Pc_Gera_NotaFiscal`, `Pc_AtualizarItens*` | ✅ mapeado (§P14) |

## P2 — ICMS (mapeado no código, 2026-08-16; aguarda validação do autor)

Entrada por item: `Pc_CalculaIcmsRegra` (`:1893`). Antes do imposto em si, o método
resolve três coisas que condicionam TODO o cálculo:

### P2.1 Destino da operação (`idDest`, `:1902-1922`)

- `IndicaPresenca = 1` + destinatário não contribuinte (IE = 9) → **interna** (mesmo
  interestadual — espelho da sutileza 5 do motor)
- País ≠ 1058 (Brasil) → **exterior** (`idEstrangeiro` recebe a IE do destinatário)
- Mesma UF ou NFC-e → interna; senão → interestadual

### P2.2 Indicador de IE do destinatário (`indIEDest`, `:1924-1941`)

`IndicadorInscricaoEstadual`: 1 = contribuinte (informa a IE), 2 = isento,
9 = não contribuinte, default isento. **NFC-e força não contribuinte.**

### P2.3 Despacho por regime do EMITENTE (`:1946-1949`)

`CodigoRegimeTributario`: **3 (Normal) ou 2 → CST** (`Pc_RegimeTributarioNormal`);
**1 (Simples) → CSOSN** (`Pc_RegimeTributarioSimplesNacional`). FCP é calculado ANTES
(`:1945`, comentário: "informar este antes para incluir o eventual valor na ST").

### P2.4 As bases centralizadas (funções puras — extraí-las é obrigatório na web)

**`Fn_CalcBaseICMS` (`:2431`)**: `Base = (VlProd + IPI? + frete) − red%`, onde `IPI?` é
decidido por **`Fn_IPIIntegraNaBaseICMS` (`:2402`)** — IPI fica FORA da base só quando
os 3 requisitos valem juntos: destinatário contribuinte + finalidade 2/4
(Produção/Industrialização) + IPI > 0 (exceção constitucional, art. 155 §2º XI).
Nos demais casos IPI INTEGRA a base.

**`Fn_CalcBaseICMSST` (`:2460`)**: `Base ST = (VlProd + IPI + frete + seguro + outras)
× (1 − red%) × MVA` — no ST o IPI **sempre** compõe (Lei Kandir); todos os encargos
transferíveis ao adquirente entram antes da MVA.

### P2.5 Despacho por CST (regime normal, `:2471-2634`)

| CST | Comportamento |
|---|---|
| 00 | Base cheia; `vICMS = vBC × (alíq − red_alíq)` |
| 10 | ICMS normal + ST **só se destinatário Revenda** (`TRB_CONSUMIDOR='N'`); consumidor final → nada |
| 20 | Base reduzida (`TRB_RD_BS_ICMS`) |
| 30 | Isento de ICMS próprio, MAS calcula ICMS "temporário" só para apurar o ST e **zera o normal no fim** (`:2540-2559`) |
| 40/41/50 | Isenta / não tributada / suspensão — sai sem calcular |
| 51 | Diferimento: `vICMSOp` cheio, `pDif = TRB_AQ_DIF`, `vICMSDif` destacado, `vICMS = op − diferido`; base inclui FRETE (única que passa frete à `Fn_CalcBaseICMS`) |
| 60 | ST já retido antes — zera e delega ao rastreio (§P2.8) |
| 70 | Base reduzida + ST (ST só p/ Revenda) |
| 90 | Outros — base reduzida + alíq reduzida |

### P2.6 Variante MANUAL (`Pc_InformaIcmsManual`, `:2002` → `:2636-2794`)

Mesmo despacho por CST, com UMA diferença: a alíquota vem do ITEM
(`ITF_AQ_ICMS`) em vez da tabela por UF — o usuário informa.

**Decisão do autor (2026-08-16): a via manual deve SEGUIR a regra geral.** As duas
divergências encontradas entre as vias são DESVIOS, não comportamento a reproduzir:

- CST 51 manual sem frete na base (`:2735-2737`) → errado; a regra manda INCLUIR frete
- CST 90 manual com base cheia (`:2787`) → errado; a regra usa base reduzida
  (`TRB_RD_BS_ICMS`)

Na web: UMA implementação por CST; manual só troca a FONTE da alíquota.

### P2.6b Escolha de regra POR ITEM = o gatilho do modo RegraDireta (Q16+Q19)

Ao digitar o item no pedido, o usuário pode ESCOLHER qual regra de tributação usar.
A escolha é gravada em **`TB_ITENS_NFL_TRIBUTACAO`** (`model/tblItensNflTributacao.pas`
— campos `TB_ORDER_ITENS_ID`, `TB_TAX_RULER_ID`, `CFOP`, `SET_FINANCIAL`; nomenclatura
inglesa = tabela da geração nova), pela tela de itens (`Un_Itens_Produto.pas`).

Verificado o fluxo em `Fc_tributacao` (`:863-877`): por item,
`TributacaoDireta.getByKey(ITF_CODIGO)` consulta a escolha; **se existe → modo
RegraDireta** (`WHERE TRB_CODIGO = :escolhida`, pulando toda a combinação do motor);
se não existe → busca combinada normal (e só nessa via o `IgnorarCalculoST` do cliente
age). Um único mecanismo responde Q16 e Q19.

### P2.7 De onde vêm alíquotas e MVA (`:820-870`, `:742-795`)

Tabela **`TB_MVA_UF_NCM`** (`model/tblMvaUfNcm.pas`, campos `MUN_*`), chave
UF do estabelecimento × NCM × estabelecimento: `MUN_ALIQ_INTERNA` (alíquota interna)
e `MUN_MR_VL_AGREGADO` (MVA). Em cima disso:

- **MVA ajustada** interestadual: `MVA_aj = MVA × (100 − ALQ_inter) / (100 − ALQ_intra)`
  (`:765-767`), com propagação da redução de base ao ST quando `TRB_RD_BS_ICMS_ST='S'`
- **Alívio do Simples** (`:772-795`): destinatário optante + MVA > 0 + config
  `GRL_G_DECRETO108352014='S'` → SC usa 30% da margem; demais UFs: alíquota ST < 18%
  OU benefício ICMS → 50%, senão 30%

### P2.8 Rastreio do ST retido (`Pc_ControleRastreioICMSST`, `:1955-2000`)

Para CST 60 / CSOSN 500: baixa POR UNIDADE vendida os registros de ST retido na
compra (`TControllerCtrlIcmsST`, tabela TB_CTRL_ICMS_ST), ligando cada unidade ao
item de saída (`Destino = ITF_CODIGO`). Não roda para consumidor final nem quando
`TRB_SENTIDO = 'E'`. O critério `TRB_PRODUTO > 0` comentado em `:1965` (removido
09/06/2022): **decisão do autor (2026-08-16) — o comportamento ATUAL está certo;
ignorar a linha morta.** Na web, o rastreio não filtra por finalidade.

### P2.9 CSOSN (Simples, `:2797+`) — IMPLEMENTADO (2026-08-21)

Grupos tratados: 101 (com crédito), 102/103/300, 400, 201 (com ST + crédito),
202/203 (com ST), 500 (retido), 900 (outros). Também em par regra × manual.

**Motor implementado** (`calcIcmsCsosn` em `setes-api/src/shared/tax-rule/calc.ts`,
evidência `Pc_RegimeTributarioSimplesNacional` linha a linha): antes do
despacho por grupo, SEMPRE calcula `vICMSOp` (base×aliq, nunca zerado),
`vICMS` com diferimento opcional (gate `destinationIsResale`, mesmo
TRB_CONSUMIDOR='N' já usado no ST do CST) e ST pela MESMA fórmula do CST
(`vICMSST = base×aliq − vICMS_próprio`, "por dentro"). Base SEMPRE inclui
frete (única exceção além do CST 51) e IPI pela mesma regra
`icmsIpiIntegratesBase`. Depois o grupo zera seletivamente ICMS/ST/crédito
— tabela `CSOSN_GROUPS` no código. Dois achados LITERAIS do legado,
replicados sem "correção": CSOSN 400 NÃO zera o ICMS próprio (só o ST);
CSOSN 500 NÃO zera o crédito SN (só ICMS+ST). FCP próprio/FCP-ST (P7.3)
estendidos para aceitar código CSOSN além de CST (mesma base).

**Crédito SN**: alíquota vem de config NOVA da institution
(`billing`/`sn_credit_aliq`, seed `sql/33`, kind Float, default '0') — não
é campo da regra nem do produto (evidência: legado lê a config global
`GRL_G_AQ_CRED_ICMS` em venda/compra/ajuste/cupom, SEMPRE a mesma).
Persistido em `tb_order_item_icms.cred_calc_aliq`/`.cred_expl_value` —
colunas do baseline sem produtor até aqui. `IcmsPiece.csosn` já existia
desde a Onda 1; sem DDL nova.

Bloqueio "emitente Simples: CSOSN ainda não disponível" (`loadContext` em
`billing.service.ts`) REMOVIDO — faturamento de emitente do Simples está
liberado. 12 testes novos em `tax-calc.test.ts` + 2 em `billing.test.ts`;
308/308 api.

## P3 — ICMS ST (mapeado no código, 2026-08-16; aguarda validação do autor)

Complementa o P2 (bases e despacho por CST já estão lá). O que é próprio do ST:

### P3.1 Assimetria de UF — a regra de ouro do ST

- **Alíquota/MVA do ST**: `TB_MVA_UF_NCM` consultada pela **UF do DESTINATÁRIO**
  (`Pc_Abrir_Aliquota_UF_ST`, `:801` — `Pedido.Empresa.Endereco.CodigoEstado`) × NCM
  × estabelecimento
- **Alíquota própria (NR)**: mesma tabela, mas pela **UF do ESTABELECIMENTO/emitente**
  (`:822`)

ST pertence ao destino; ICMS próprio, à origem. A web precisa manter as DUAS chaves.

### P3.2 MVA original × MVA ajustada — decisão POR FATURAMENTO

`UtilizarMvaOrginal` é um **checkbox nas telas de faturamento**
(`chbx_Mva_Original` — `UN_Fatura_Vda.pas:860`, `UN_Fatura_Ajt.pas:237`). Desmarcado
(padrão), o sistema ajusta a MVA pela **carga tributária REAL** (`:746-767`):

1. Reduz as alíquotas pela redução de base da regra (`TRB_RD_BS_ICMS`), propagando ao
   ST só se `TRB_RD_BS_ICMS_ST = 'S'`
2. `MVA_aj = MVA × (100 − ALQ_inter_reduzida) / (100 − ALQ_intra_reduzida)`
3. Alívio do Simples (§P2.7): decreto via config, SC 30%, demais 50%/30%

### P3.3 Alíquota própria buscada sob demanda no Simples (`Pc_Aliquota_UF_NR`, `:808`)

Só busca a alíquota interna NR quando ela está zerada E o CSOSN é 201/202/203 —
comentário do código: o cálculo do ST precisa da alíquota do ICMS próprio para o
delta (`vICMSST = BC_ST × alq_ST − vICMS_próprio`), mesmo quando o Simples não
destaca ICMS próprio.

### P3.4 Universo de itens tributados (`:708-717`)

A query-base junta `TB_ITENS_NFL × TB_PEDIDO × TB_PRODUTO × TB_MEDIDA (+ série)` e
**exclui `ITF_OPER 'D' e 'T'`** (devolução e troca — as abas Devolução/Troca da tela
de pedido). No ECF, serviço sai conforme config `OSR_G_SERVICO_ECF`. → **Q23**

## P4–P5 — IPI, PIS e COFINS (mapeados no código, 2026-08-16; aguardam validação)

Padrão comum aos três: **cálculo** (`Pc_Define*`) separado da **persistência**
(`Pc_AtualizarItens*` grava `TB_ITENS_IPI/PIS/COFINS` por item da nota, só quando
`It_AutorizacaoNFE`). A regra casada fornece CST e alíquota; a base é
`FValorMercadoria` (valor líquido do item).

### P4 — IPI (`Pc_DefineIPI`, `:3028-3054`)

- Só roda se a regra tem `CST_IPI` preenchido; `cEnq = '999'` fixo (comentário:
  "tabela a ser criada pela RFB, informar 999 enquanto não for criada")
- Só os CSTs **00/49/50/99** calculam: `vBC = FValorMercadoria + frete` — comentário
  vivo: "precisamos avaliar se podemos incluir os restantes" (seguro/outras) → **Q25**
- Alíquota: `TRB_AQ_IPI` da regra; se zero, **fallback para a do item**
  (`ITF_AQ_IPI`, `:3045-3048`)
- Demais CSTs (isenções/saídas): só o CST vai à nota, sem valores

### P5 — PIS (`Pc_DefinePIS`, `:3389`) e COFINS (`Pc_DefineCOFINS`, `:3448`)

Estrutura espelhada; default **CST 07 (isenta) com tudo zerado** — só calcula se
`TRB_AQ_* > 0` OU `CST_*` preenchido na regra. Despacho por CST:

| CST | Comportamento |
|---|---|
| 01/02 | Ad valorem: `vBC = FValorMercadoria`, alíquota da regra |
| 03 | Por quantidade: `qBCProd = ITF_QTDE`, `vAliqProd = ITF_VL_UNIT` → **Q26** |
| 99 | Base > 0 → ad valorem; base zero → por quantidade |
| demais | Ad valorem (mesma fórmula de 01/02) |

⚠️ **Assimetria PIS × COFINS encontrada (`:3424-3428` vs `:3484-3489`)**: no CST 99
com base > 0, o COFINS calcula `vCOFINS`; o PIS só seta a alíquota e **NÃO calcula
`vPIS`**. → **Q24**

### Vistos no caminho (pertencem a P9/P10)

- **II (importação)**: `vII = vBC × TRB_AQ_II` (`:3380-3385`)
- **Imposto Seletivo** (`Pc_DefineISel`, `:3510`): corpo INTEIRO comentado — stub da
  reforma aguardando implementação

## P6 — ISSQN (mapeado no código, 2026-08-16; aguarda validação do autor)

### P6.0 O laço mestre por item (achado estrutural, `:2280-2360`)

O loop que percorre `Qr_ItensPedido` está organizado pelos **grupos de letras do XML
da NF-e**: N-ICMS → P-II → Q-PIS → (R-PIS ST: **vazio**) → S-COFINS → (T-COFINS ST:
**vazio**) → U-ISSQN → IBS/CBS (gate `Gb_Reforma_Tributaria`). O despacho do ISSQN é
pelo TIPO DO ITEM: **`PRO_TIPO = 'S'` → `Pc_DefineISSQN`** (`:2322-2325`) — coerente
com a decisão da web (natureza pela presença do ramo; kind do produto).
Totalizações: as do ICMS/IPI/PIS/COFINS rodam sob gate de autorização; a do ISSQN
**sempre** roda (`:2351`).

### P6.1 O cálculo (`Pc_DefineISSQN`, `:3524-3596`)

| Elemento | Fonte |
|---|---|
| `vBC` | `FValorMercadoria` (líquido do item); `vDeducao = ITF_VL_DESC` |
| **Alíquota** | **cadastro da CIDADE do destinatário** (`Pedido.Endereco.Cidade.AliqISS`) — não vem da regra de tributação |
| `vISSQN` | `vBC × alíq / 100`, arredondado a 2 casas (comentário: "para atender o Barela, 24/05/2018") |
| `cListServ` (item LC 116) | **config global `OSR_G_NFSE_CL116`** (`:978`) — UM código para todos os serviços do estabelecimento |
| `cServico` | `ITF_CODPRO` (código do produto-serviço) |
| ISS retido | flag do CLIENTE `issretido='S'` → `indISSRet=1`, `vISSRet = vISSQN` inteiro |
| Exigibilidade | `cliente.IssExigibilidade` armazenado 0-based, **+1** para o padrão da NF-e (`:3578`) |
| Incentivo/processo | flags do cliente (`IssIncentivoFiscal`, `IssNumeroProcesso`) |

Nota: `TRB_AQ_ISS` existe na regra (§1) mas o cálculo NÃO o usa — alíquota vem da
cidade. O campo da regra parece morto neste fluxo. (Incluído em Q27.)

### P6.2 Esquisitices encontradas (→ questões)

1. **`cMunFG` atribuído DUAS vezes**: primeiro IBGE do ESTABELECIMENTO (`:3545`),
   depois SOBRESCRITO pelo IBGE da cidade do PEDIDO/destinatário (`:3582`) — vale o
   último. Para a LC 116 a regra geral é o município do PRESTADOR (com lista de
   exceções). → **Q27**
2. **Bloco ICMS dentro do ISSQN** (`:3530-3534`): seta `orig`/`CST`/`modBC` do ICMS e
   ajusta `ICMS.vBC` (que nunca foi calculado ali — provável no-op/resíduo). → **Q29**

## P7 — FCP (mapeado no código, 2026-08-16; aguarda validação do autor)

Calculado ANTES do despacho de regime (`:1945`) para o valor entrar no ST.

### P7.1 Alíquota por UF × prefixo de NCM (`tributaFCP`, `:3974-3999`)

Tabela **`TB_FCP_UF_NCM`**, filtrada pela **UF do DESTINATÁRIO** (`TB_STATE_ID`,
`:2052` — nomenclatura nova). O casamento do NCM é por **PREFIXO**: o NCM da tabela
pode ser parcial (capítulo/posição) e casa com o início do NCM do produto — primeira
linha que casar vence. Permite regra por capítulo inteiro.

### P7.2 Quando o FCP incide (`:329-338`)

Alíquota > 0 E uma das três situações:
1. Operação INTERNA + consumidor final + produto SEM ST
2. Operação INTERNA + produto COM ST
3. INTERESTADUAL + consumidor final + NÃO contribuinte (cenário DIFAL)

### P7.3 Os dois FCPs

- **FCP próprio** (CST 00/10/20/51/70/90, CSOSN 101/102/103/900):
  `vBCFCP = FValorMercadoria`; `vFCP = base × alíq`
- **FCP-ST** (produto com ST + CST 10/30/70/90, CSOSN 201/202/203/900):
  `vBCFCPST = (mercadoria + IPI + frete) × MVA` — ⚠️ seguro/outras COMENTADOS
  (`:376`), **divergindo de `Fn_CalcBaseICMSST` que os inclui** → **Q30**
- CST 60/CSOSN 500: zera FCP-ST retido (não destaca)

Nota: o constructor instancia `ICMSFCP: TControllerIcmsFCP` (tabela `TB_ICMS_FCP`),
mas ele NÃO é usado no cálculo — → **Q31**.

## P8 — Diferimento (coberto no P2; síntese)

O cálculo mora INTEIRO no CST 51 (§P2.5, via regra `:2569-2590` e manual
`:2731-2752`): `vICMSOp` cheio → `pDif = TRB_AQ_DIF` → `vICMSDif` destacado →
`vICMS = operação − diferido`. O flag `TRB_DIFERIDO` da regra NÃO participa do
cálculo — é seletor/atributo usado só na manutenção de regras
(`ControllerTributacao.pas:263,323`). Pendência herdada: base com frete na via
regra × sem frete na manual (decidido na Q19: seguir a regra, COM frete).

## P9 — Importação (mapeado, 2026-08-16; dentro da tributacao.pas é FINO)

`Pc_DefineII` (`:3373-3387`): só ad valorem — `vII = FValorMercadoria × TRB_AQ_II`;
`vDespAdu` e `vIOF` zerados. O aparato real de importação (DI, adições) vive FORA
da tributacao.pas: `ControllerAdicaoImportacao`/`ControllerDocumentoImportacao`,
telas `Un_Adic_Imp`/`UN_Pedido_Cpa`, models `tblAdicaoImportacao`/`tblItensImport`/
`tblItensII` — pertence à frente da COMPRA (futura).

⚠️ Campos da regra sem uso no cálculo: `TRB_AQ_AFRMM`, `TRB_AQ_IRPJ`, `TRB_AQ_CSLL`
não são nem selecionados; `TRB_AQ_SISCOMEX` é selecionado (`:502`) mas nunca lido.
→ **Q32**

## P10 — IBS/CBS, a reforma tributária (mapeado, 2026-08-16; aguarda validação)

### P10.1 Como liga e de onde vêm os dados

- **Gate**: `Gb_Reforma_Tributaria` — CHECKBOX na tela de configuração
  (`Un_Configuracao.pas:685`). Cliente liga a reforma quando quiser.
- **Fonte**: a regra de tributação velha carrega `TB_TAXES_ID` → `tb_taxes`
  (institution + id, `:3058-3060`), que fornece `CST` (3 primeiros chars) e
  `cClassTrib`. **`tb_taxes` tem sub-registros por ESFERA** (`ControllerTaxes`):
  `CBS`, `IBS_UF`, `IBS_Mun` — cada um com `aliquota`, `aliq_dif`, `aliq_red`,
  `aliq_efe` (+ `tb_taxes_incidency`).

### P10.2 A base (`Pc_DefineIBSCBS_IBS_Base`, `:3182-3211`)

Segue a fórmula oficial (comentada no código): `vBC = vProd + vFrete + vSeg + vOutro
+ vII − vDesc − vPIS − vCOFINS − vICMS − vICMSUFDest − vFCP − vFCPUFDest − vISSQN
+ vIS`. **DOIS desvios entre comentário e código** (`:3192-3206`):

1. **`vFrete` NÃO é somado** — a fórmula oficial manda `(+) vFrete`, o código não tem
2. **`vICMS` é subtraído DUAS vezes** — `Pc_Imposto.ICMS.vICMS` e
   `Pc_Imposto.ICMS.vicms` (`:3199-3200`; Pascal é case-insensitive → MESMO campo)

→ **Q33**

### P10.3 O padrão por esfera (IBS Mun `:3213` / IBS UF `:3265` / CBS `:3136`)

Idêntico nos três: alíquota do cadastro → diferimento (`vDif = vBC × p × pDif`) →
devolução (`vDevTrib = 0` fixo) → redução (`pAliqEfet = p × (1 − red/100)` —
**recalculada, sobrescrevendo o `aliq_efe` do cadastro**) → valor
(`v = vBC × pAliqEfet − vDif − vDevTrib`, só se `pAliqEfet > 0`). Comentários citam
os artigos da LC 214/2025 (alíquotas de transição 2026: CBS 0,9%, IBS UF 0,1%,
IBS Mun 0%).

### P10.4 O que é STUB (corpo comentado — aguarda regulamento/implementação)

`Pc_DefineIBSCredPres` / `Pc_DefineCBSCredPres` (crédito presumido, Anexo IV),
`Pc_DefineIBSCBSMono` (monofásico/combustíveis, art. 178), `Pc_DefinegTransfCred`
(transferência de crédito), `Pc_DefineISel` (Imposto Seletivo). `Pc_DefineTribCompraGov`
tem 3 atribuições (parcial). Na web: modelar as ESTRUTURAS, implementar quando o
regulamento fechar.

### P10.5 Persistência

`Pc_AtualizaIBSCBS` (`:5436`) grava a cadeia própria: **`TB_IBSCBS`** (cabeçalho por
item) + **`TB_CBS`** + grupos (`TB_GRUPO_UB`, créd. presumido etc.) — espelho relacional
dos grupos do XML.

## P11 — Observações fiscais (IMPLEMENTADO 2026-08-22)

### Estrutura descoberta: os CSTs são CATÁLOGOS

`CST_ICMS`, `CSOSN_ICMS`, `CST_IPI` etc. que o cálculo lê NÃO são colunas da regra —
vêm de JOIN com **tabelas-catálogo de CST** (`TB_TRIB_ICMS_NR`, `TB_TRIB_ICMS_SN`,
`TB_TRIB_IPI`, ... — o código do CST vive em `TBI_GRUPO`; a regra guarda o FK
`TRB_CODTBI_*`). No redesenho (§6.5), as peças referenciam esses catálogos.

### O motor de observações (`Pc_Obs_NotaFiscal`, `:4185+`)

Duas espécies gravadas em `NotaFiscal.Observacoes`:
- **Tipo 'M'** (manual): memo da tela de faturamento + info de revenda de veículos
- **Tipo 'F'** (fiscal): por CST/CSOSN — DEPOIS de os itens persistirem, cada rotina
  `Pc_Obs_CSTxx`/`Pc_Obs_CSOSNxxx` consulta `TB_ITENS_ICMS × catálogo CST ×
  TB_OBSERVACAO` (obs vinculada à regra via `TRB_CODOBS` → gravada no item como
  `ICM_CODOBS`), agrega valores (ex.: CST 10 soma base/valor do ST por texto de
  observação) e insere o texto legal na nota

Despacho por regime (normal → CST00..90; Simples → CSOSN101..900) + obs de regra
geral, ISSQN e imposto aproximado (config `GRL_G_IMPOSTO_APROX` + natureza contendo
'VENDA').

**Sugestão p/ web (regra 5)**: as ~20 rotinas quase idênticas colapsam em UMA
consulta parametrizada por grupo de CST + catálogo — o conteúdo é dado, não código.

**IMPLEMENTADO (2026-08-22)** — extração completa das ~20 rotinas por agente
dedicado (leitura literal, sem normalizar) revelou 3 bugs REAIS no legado,
não nuances de design:

1. **CST 80 é no-op**: procedimento vazio no despacho — nunca gerava
   observação. Não existe no nosso domínio (`calc.ts` não tem CST 80).
2. **CSOSN 400 nunca dispara**: o SQL exige `OBS_CODMHA` mas o código nunca
   faz o bind — comparação com NULL sempre falha.
3. **CSOSN 201 tem placeholder trocado**: recalcula base/valor do ST mas
   tenta substituir tokens já consumidos numa rodada anterior — esses dois
   valores nunca chegam ao texto final, mesmo com o comentário do código
   sugerindo que sim; o texto real mostra a alíquota de crédito duplicada.

**Decisão do Valdo**: corrigir os 3 na web (não replicar os bugs). Mantido
fielmente: quando há mais de uma observação distinta cadastrada pro mesmo
grupo, usa só a 1ª (padrão em ~10 das ~19 rotinas, com ou sem agregação —
achado consolidado #6 da extração).

**Motor**: `setes-api/src/modules/billing/billing.observations.ts`
(`REGIME_GROUPS` — tabela declarativa por CST/CSOSN) + wiring em
`billing.service.ts` (constrói os textos com os itens JÁ calculados) +
`billing.repository.ts` (leituras: observações gerais `general='2'`,
observação por regra via `tb_tax_rule.tb_observation_id`, catálogo IBPT
`setes_central.tb_ncm`). Persistido em `tb_invoice.note` (concatenado,
1 texto por linha — o XML final só tem 1 campo `infCpl` mesmo).

**Gap registrado**: CST 60/70 (rastreio de ST retido, P2.8) ficam sem
observação regime-específica até essa frente nascer — `calc.ts` não
calcula os campos `_RET` necessários (fora de escopo desde a Onda 1 do W2).

**Imposto Aproximado (Lei 12.741/2012) — escopo trazido de volta pelo
Valdo** (a IA tinha sugerido deixar fora por falta de tabela IBPT — Valdo
apontou que `setes_central.tb_ncm` já existia com
`aliq_nac/aliq_imp/aliq_est/aliq_mun`, sem produtor). Percentual por item
(`ITF_IMP_APROX`) persistido em `tb_order_item_tax_rule.approx_tax_aliq`
(migration 032) sempre, independente de config — só a OBSERVAÇÃO agregada
na nota é gated (`billing/approx_tax_enabled`, seed sql/34, + só venda).
Textos literais replicados: `"Valor aprox Imp. Nacional R$ X (Y)%"` +
`"| Imp. Estadual..."` + `"| Imp. Municipal..."`, concatenados sem
separador (achado: se a 1ª esfera for zero, o texto começa direto com
"| Imp. Estadual" — replicado como está).

## P12 — Validações pré-XML (mapeado, 2026-08-16; aguarda validação)

`Fc_Valida` (`:989`) orquestra, cada bloco com mensagem própria e acumulação:

| Validação | Quando roda | O quê |
|---|---|---|
| `Fc_Valida_Dados_Emitente_NFE` | emitente contribuinte (IE ind. 1) | completude cadastral do emitente |
| `Fc_Valida_Dados_Destinatario_NFE` | pulada em NFC-e | completude do destinatário (ex.: "Cidade IBGE não encontrado") |
| `Fc_Valida_Itens_Nota` (`:1138`) | sempre | É o laço da REGRA — alimenta `It_M_Fisco` (§3) |
| `Fc_ValidaUsoNCM` (`:1801`) | sempre | NCMs dos itens da nota |
| `Fc_Valida_CNPJ/CPF/Insc_Estadual` | chamadas pelos blocos acima | dígitos/formato |

Coerente com a decisão da Q17: valida-se o MÍNIMO local (cadastro completo, regra
existe, NCM ok); o resto é da Receita.

## P13 — Montagem dos dados da NF-e (mapeado, 2026-08-16; aguarda validação)

- **`CalculaValorMercadoria`** (`:296`): `FValorMercadoria = unit × qtde − desconto`
  — a base universal de TODOS os tributos.
- **`Pc_DefineRemetente`** (`:4006`): Emit inteiro do cadastro do estabelecimento
  (truncagens a 60 chars, IE sem máscara, CRT do regime).
- **`Pc_DefineDestinatario`** (`:4057`): Dest do cliente/endereço. ⚠️ o default do
  `indIEDest` aqui é **contribuinte**, enquanto no fluxo do ICMS (§P2.2, `:1938`)
  o default é **isento** — divergência entre as duas montagens → **Q34**.
- **`Pc_DadosdoTransporte`** (`:4001`): corpo **VAZIO** — transporte é preenchido
  fora (tela de faturamento).
- **`Pc_DefineCasasDecimais`** (`:4116`): varre os itens para achar o MÁXIMO de
  casas decimais (DANFE `vUnCom`/`qCom`). ⚠️ a linha logo APÓS o loop sobrescreve o
  máximo acumulado com o valor do ÚLTIMO item — derrota a própria lógica → **Q35**.

## P14 — Geração da nota (mapeado, 2026-08-16; aguarda validação)

### `Fc_DefineTributacao` (`:934`) — pós-match

1. **Desempate quando a busca devolve >1 regra** (`:941-951`): locate por cliente →
   estado+produto → estado → produto. ⚠️ o último locate passa o **código do
   ESTADO no campo TRB_CODPRO** (`:951`) → **Q36**.
2. Alíquota da regra (`TRB_AQ_ICMS`) pode ser TROCADA pela interna do NCM
   (`Pc_Aliquota_UF_NR/ST` — §P3).
3. **Negação de regra de outro estado em operação interna** (`:963-968`): se mesma
   UF e a regra casada é de OUTRO estado → `Result = -1`, regra negada.
4. Variáveis ISS legadas (configs `OSR_G_NFSE_TRIB`/`CL116`, `TRB_AQ_ISS`) — mortas
  pelo desenho web (Q27/Q28); `It_Subst_Tributario` (`TRB_SUB_TRI` = operação como
  SUBSTITUTO); `NAT_CFOP` da natureza.

### `Pc_Gera_NotaFiscal` (`:1029`) — o cabeçalho

Deriva **`NFL_TIPO` exatamente como instruído** (§5.7 do processo-pedido-nota):
`It_Sentido='S'` → `SI`; entrada com autorização própria → `EI`; sem → `EE`.
Série: contingência (tipo emissão 2) → `900`, senão config `NFE_SERIE`. Totais
copiados de `Total.ICMSTot` (+ ISSQN); totais IBS/CBS ainda em STUB comentado;
`It_SomaICMSNaNota` soma ICMS ao total quando aplicável; `Situacao='F'`,
`Modelo 55/65` (NFC-e), `NotaFiscal.insere`.

### `Pc_AtualizarItens` (`:5593`) — persistência por item

Loop sobre `Det[]`: `Pc_AtualizarItensNota` (ajustes no item: custo etc.) →
ICMS/IPI/PIS/COFINS **só se o emitente é contribuinte** (IE indicador '1') →
ISSQN **sempre**.

## 6. Depois da tributação: autorização (instruído — verificar na frente da NF-e)

Registros de impostos prontos → geração do XML → validação e assinatura → envio à
Receita → controle de recepção (segundos a minutos):

| Cód | Situação |
|---|---|
| 0 | Pendente |
| 1 | Enviada |
| 2 | Autorizada |
| 3 | Cancelada |

Mensagens correspondentes localizadas em `Ajuda/un_geranfe3X.pas` ("Nota já enviada,
porém ainda não possui autorização", "Nota já autorizada", "Nota Fiscal Cancelada",
"Não é possível cancelar uma nota não enviada"). ⚠️ ONDE o código 0–3 é persistido
não foi localizado ainda → Q13. Esta cadeia (XML/assinatura/envio/recepção) é frente
irmã — `un_geranfe3X.pas` / `TTasGeraNfeAutorizacao` — fora do escopo deste arquivo.

## 6.5 Redesenho da Regra de Tributação (rodada de desenho ABERTA, 2026-08-16)

**Rascunho do autor**: decompor `TB_TRIBUTACAO` (40 campos, "agrupando muita
informação que não é usada ao mesmo tempo") em cabeçalho + tabelas por tributo
(`TB_TRIBUTACAO_ICMS`, `_ICMS_NR`, `_ICMS_ST`, `_IPI`, `_PIS`, `_CFS`, `_II`,
`_ISS`). Preocupações declaradas: preciosismo; elegância × performance; campos que
parecem código morto (SISCOMEX).

**Revisão de IA (regra 5 — sugestões; decisões do Valdo):**

### O que o mapeamento CONFIRMA na proposta

1. **A separação SELETOR × RESULTADO é real no código**: o WHERE do motor (§2) usa
   só um subconjunto (estado, consumidor, micro, ST, origem, finalidade, NCM,
   produto, cliente, estabelecimento, natureza/sentido); o resto é resultado por
   tributo. A decomposição espelha o uso real.
2. **Presença = incidência mata dois males de uma vez**: hoje o cálculo usa gates
   artificiais ("CST vazio → pula", "TRB_AQ > 0 OU CST ≠ ''"); com satélites 1:1
   opcionais, o gate vira EXISTE A PEÇA → tributa. É o mesmo padrão
   natureza-pela-presença-do-ramo da web, e elimina a "impressão de código morto":
   campo não usado deixa de existir na linha.
3. **A objeção de performance NÃO se aplica**: o matching só precisa do CABEÇALHO
   (todos os campos do WHERE ficam nele); as peças são buscadas DEPOIS do match,
   1:1, por PK — custo marginal. Elegância e performance não conflitam aqui.
4. **Simetria com a reforma**: `tb_taxes` JÁ é exatamente esse desenho (cabeçalho +
   filhas por esfera CBS/IBS_UF/IBS_Mun). A regra velha decomposta fica isomórfica
   à nova — um único padrão mental.

### Ajustes sugeridos ao rascunho

- **(a) `TRB_ST_ICMS` pertence ao SELETOR**, não à peça ICMS — está no WHERE do
  motor (`TRB_ST_ICMS = :st`). No rascunho aparece dentro de `_ICMS`/`_ICMS_NR`.
- **(b) Colapsar `_ICMS` × `_ICMS_NR`** (o rascunho duplica os mesmos campos nas
  duas): bastam DUAS peças — **ICMS próprio** (CST/CSOSN, modBC, alíq, reduções,
  diferimento `TRB_AQ_DIF`/`TRB_DIFERIDO`, destaque `TRB_DESTAQUE` — é atributo de
  ICMS: vira `ItensIcms.Destacar`) e **ICMS-ST** (modBC ST, flag de propagação
  `TRB_RD_BS_ICMS_ST`; alíquota/MVA continuam vindo de `TB_MVA_UF_NCM`).
- **(c) A peça ISS provavelmente NÃO precisa existir**: pelas decisões Q27/Q28, o
  ISS vem do MUNICÍPIO DO PRESTADOR + item LC 116 POR PRODUTO + flags do cliente —
  a regra não fornece nada (o `TRB_AQ_ISS` já é morto hoje). Se sobrar algum caso de
  override por regra, aí sim a peça nasce.
- **(d) PIS e COFINS com a MESMA FORMA** (decisão Q24): ou duas tabelas gêmeas, ou
  UMA peça com `kind P|C` — a segunda opção materializa o "PIS = COFINS" por
  construção.
- **(e) A peça II isola o bloco de importação** — inclusive os campos hoje sem uso
  (AFRMM/SISCOMEX/IRPJ/CSLL, Q32): se a decisão for mantê-los, ficam contidos na
  peça; se forem mortos, a peça nasce só com `aliq_ii`.
- **(f) `TB_TAXES_ID` permanece no cabeçalho** como elo — a peça da reforma É a
  `tb_taxes`, já decomposta.
- **(g) `TRB_CODOBS` (observação fiscal) fica no cabeçalho** — é da regra, não de
  um tributo.
- **(h) Nomenclatura web**: `tb_tax_rule` (cabeçalho/seletor) + `tb_tax_rule_icms`,
  `tb_tax_rule_icms_st`, `tb_tax_rule_ipi`, `tb_tax_rule_pis_cofins` (ou gêmeas),
  `tb_tax_rule_ii` — seguindo o padrão `tb_taxes`.

### Sobre "preciosismo"

O mapeamento sugere que NÃO é: a tabela larga é a CAUSA direta dos dois problemas
que o autor citou (campos não usados juntos; impressão de código morto). O único
risco real é o inverso — fatiar demais (caso das três tabelas de ICMS do rascunho).
Duas peças de ICMS + presença-como-incidência é o ponto de equilíbrio.

**Status**: aguarda decisões do autor sobre (a)–(h).

## 7. Análises transversais (CONCLUÍDAS, 2026-08-16 — onde os pipelines se tocam)

### T1 — A ORDEM de cálculo é uma cadeia de dependências (não estética)

Por item, no laço mestre: **rateio** (`:2145`) → **IPI** (`:2180`) → **ICMS** (com
FCP ANTES do regime, `:1945`) → **II** → **PIS** → **COFINS** → **ISSQN** (se kind
'S') → **IBS/CBS** (se reforma). Cada posição é obrigatória:

1. Rateio primeiro — todas as bases consomem `vFrete/vSeg/vOutro` do item
2. IPI antes do ICMS — `Fn_CalcBaseICMS`/`ST` consomem `IPI.vIPI`
3. Destino/indIE (P2.1/P2.2) antes do FCP — o gate do FCP lê `idDest`/`indIEDest`
4. FCP antes do regime — o valor entra na composição do ST
5. PIS/COFINS/ICMS/FCP/ISSQN antes do IBS/CBS — a base da reforma é SUBTRATIVA
   (desconta os valores CALCULADOS de todos eles). **IBS/CBS é obrigatoriamente o
   ÚLTIMO.**

**Regra p/ web**: a ordem é um GRAFO DE DEPENDÊNCIAS explícito, não uma lista — se
paralelizar, respeitar as arestas acima.

### T2 — Rateio de frete/seguro/outras: proporcional com RESÍDUO no último

`:2145-2168`: proporção = valor líquido do item / valor do pedido (arredondada PARA
BAIXO, 4 casas); cada item recebe `total × proporção` (para baixo, 2 casas); o
ÚLTIMO item recebe `total − soma dos anteriores`. Fecha o total EXATO por
construção. **Padrão a preservar na web** (senão totais da nota não batem e a
Receita rejeita).

### T3 — A pilha de bases (quem compõe quem)

```
mercadoria líquida = unit × qtde − desconto          (CalculaValorMercadoria — raiz)
├── PIS/COFINS  = mercadoria
├── ISSQN       = mercadoria (dedução = desconto)
├── FCP próprio = mercadoria
├── II          = mercadoria
├── IPI         = mercadoria + frete (+ seguro/outras — B7)
├── ICMS        = mercadoria + IPI? + frete(só CST51)  − red%   (IPI? = exceção art.155)
├── ICMS-ST     = (mercadoria + IPI + frete + seguro + outras) × (1−red%) × MVA
│   └── FCP-ST  = mesma base ST (B6 unifica)
└── IBS/CBS     = mercadoria + seguro + outras + frete(B3) + II
                  − desconto − PIS − COFINS − ICMS(1×, B2) − FCP − ISSQN + IS
```

### T4 — A REGRA é o hub: uma linha alimenta sete consumidores

CSTs (via catálogos `TB_TRIB_*`), alíquotas/reduções (ICMS/IPI/PIS/COFINS/II),
diferimento (CST 51), flag substituto (`TRB_SUB_TRI`), observação fiscal
(`TRB_CODOBS` → `ICM_CODOBS` → motor de obs), CFOP/natureza (`NAT_CFOP`), e a ponte
da reforma (`TB_TAXES_ID` → `tb_taxes`). O redesenho §6.5 fatia o hub em peças SEM
quebrar o papel de hub (o cabeçalho continua sendo o ponto de encontro).

### T5 — Os cadastros ATRAVESSAM os pipelines (dimensões, não parâmetros)

| Cadastro/flag | Onde age |
|---|---|
| Cliente.ConsumidorFinal | seletor da regra + gate do ST (CST 10/30/70) + gate do FCP + rastreio |
| Cliente.OptantePeloSimples | seletor + alívio de MVA |
| Cliente.IgnorarCalculoST | PRÉ-busca (sobrescreve o ST do produto) |
| Cliente.IndicadorIE | indIEDest + exceção do IPI na base ICMS + gate FCP interestadual |
| Cliente.IssRetido/Exigibilidade/Incentivo | ISSQN |
| Emitente.CodigoRegimeTributario | despacho CST × CSOSN + CRT do XML |
| Emitente.IndicadorIE = '1' | GATE DE PERSISTÊNCIA (só grava ICMS/IPI/PIS/COFINS se contribuinte) |
| Produto.PRO_TIPO / SUB_TRIB / ORIGEM / NCM / TRIBUTACAO | despacho ISSQN × ICMS; seletores; FCP por prefixo |
| UF×NCM (`TB_MVA_UF_NCM`, `TB_FCP_UF_NCM`) | alíquotas ST (UF destino) × NR (UF origem) × FCP (UF destino) |

### T6 — Persistir ANTES de observar

O motor de observações (§P11) lê os itens JÁ GRAVADOS (`TB_ITENS_ICMS`) para
agregar valores — logo a ordem é: calcular → gravar itens → gerar observações →
gravar cabeçalho. Inverter quebra as obs.

### T7 — Configurações espalhadas (`Fc_Tb_Geral`) — inventário

Vivas: `GRL_G_IMPOSTO_APROX`, `GRL_G_DECRETO108352014` (MVA Simples), `NFE_SERIE`,
`NFE_SEM_CODIGO_BARRAS`, `OSR_G_SERVICO_ECF`. Mortas p/ web: `OSR_G_NFSE_CONJ`
(Q29), `OSR_G_NFSE_TRIB`/`CL116` (Q27/Q28). **Na web**: todas migram para o
Framework de Configurações (catálogo por interface) — nenhuma config órfã em
`Fc_Tb_Geral`.

### T8 — Reforma em paralelo, não em substituição

IBS/CBS calcula JUNTO com o sistema atual (gate por config do cliente), consumindo
os RESULTADOS dele (T3) — não é um "modo novo", é uma CAMADA ADICIONAL com fonte
própria (`tb_taxes`). O desenho web deve permitir os dois simultâneos por anos
(transição LC 214 até 2033).

## 8. Questões

### Abertas

*(nenhuma aberta no momento)*

### Respondidas

- ~~Q34~~ (2026-08-16, investigação) — a divergência DISSOLVE: `Pc_DefineRemetente`/
  `Pc_DefineDestinatario` da tributacao.pas são **CÓDIGO MORTO** (chamadas comentadas
  em `:2082/:2085`). A montagem REAL do destinatário está em
  **`un_geranfe3X.pas:1005-1051`**, que além dos casos 1/2/9 tem uma HEURÍSTICA
  DELIBERADA para indicador inválido (comentário: "corrigir o erro... índice x valor
  real"): CNPJ + IE preenchida → contribuinte; CNPJ sem IE → não contribuinte;
  CPF → não contribuinte. NFC-e → não contribuinte. ⚠️ Nuance que fica: o
  `indIEDest` setado pelo fluxo do ICMS (§P2.2) é o usado pela CONDIÇÃO 3 do FCP
  durante o cálculo; o do geranfe3X é o que vai ao XML. Na web: UMA montagem, com a
  heurística do geranfe3X, ANTES do cálculo.
- ~~Q35~~ (2026-08-16, investigação) — o "bug" só existe em CÓDIGO MORTO: a chamada
  de `Pc_DefineCasasDecimais` está comentada (`:2090`); a versão REAL é
  `PreencheDanfeCasasDecimais` (`un_geranfe3X.pas:1076`), que faz o máximo
  CORRETAMENTE para `vUnCom` e `qCom`. (Nota menor da versão viva: `Lc_Tam_CodPro`
  é comparado em `:1104` antes de inicializado em `:1113` — inofensivo aparente,
  registrar na limpeza.)
- ~~Q36~~ (2026-08-16, investigação) — **BUG REAL em código VIVO** (vira B9 do plano
  legado). `Fc_DefineTributacao` roda no laço mestre (`:2115`); no desempate, o
  fallback final `locate('TRB_CODPRO', CodigoEstado)` (`:951`) passa o código do
  ESTADO no campo PRODUTO. Gravidade concreta: códigos IBGE de UF (41=PR, 42=SC,
  43=RS) COLIDEM com ids reais de produto — se existir regra com `TRB_CODPRO=41`,
  ela é selecionada INDEVIDAMENTE para pedidos do PR. Se o locate falha, o cursor
  fica na 1ª linha (ordem NCM DESC — aceitável). Correção: passar o código do
  PRODUTO.
- ~~Q32~~ (2026-08-16) — decisão: **código VIVO** — AFRMM/SISCOMEX/IRPJ/CSLL ficam
  DENTRO da peça II do redesenho (§6.5-e). Agem fora da tributacao.pas (frente da
  Compra/importação, a mapear).
- ~~Q33~~ (2026-08-16) — decisão: **ajustar conforme a legislação** — na web a base
  do IBS/CBS segue a fórmula oficial (comentada no próprio código): soma `vFrete`,
  subtrai `vICMS` UMA vez. Os dois desvios do Delphi são bugs, não comportamento.
- ~~Q30~~ (2026-08-16) — decisão: **SIM, unificar** — na web o FCP-ST usa a MESMA
  função de base do ICMS-ST (`Fn_CalcBaseICMSST`, com seguro/outras).
- ~~Q31~~ (2026-08-16) — `TB_ICMS_FCP` NÃO é morta: é a PERSISTÊNCIA do FCP por item
  da nota. Verificado: `Pc_AtualizarItensICMS` grava base/percentual/valor dos três
  FCPs (próprio, ST, ST retido) quando algum é > 0 (`:5713-5727`). Espelho do padrão
  cálculo × gravação dos demais tributos.
- ~~Q27~~ (2026-08-16) — decisão: **ISS do município do PRESTADOR**. Na web, `cMunFG`
  e alíquota vêm do estabelecimento emitente; a sobrescrita pela cidade do
  destinatário (`:3582`) e a alíquota do tomador são desvios, não reproduzir.
- ~~Q28~~ (2026-08-16) — decisão: **item da LC 116 POR PRODUTO** (campo do serviço,
  kind 'S') na web; a config global `OSR_G_NFSE_CL116` morre.
- ~~Q29~~ (2026-08-16) — **nota conjugada (serviço DENTRO da NF-e 55) está em DESUSO
  e NÃO vai para a web**; o bloco ICMS dentro do `Pc_DefineISSQN` é resíduo dela.
  ⚠️ Distinguir dos conceitos vivos: o PEDIDO conjugado (1 order, ramos sale+service)
  e a NOTA mista continuam — o que morre é o serviço tributado DENTRO do XML da
  NF-e de mercadoria via `OSR_G_NFSE_CONJ` (reforça a anotação da Q8 do
  processo-pedido-nota: cada ramo autoriza no seu documento — NF-e × NFS-e).
- ~~Q24~~ (2026-08-16) — decisão do autor: **PIS deve ser IGUAL ao COFINS**. O CST 99
  com base > 0 sem cálculo de `vPIS` é BUG; na web, uma única implementação
  parametrizada serve os dois tributos.
- ~~Q25~~ (2026-08-16) — instrução: investigar material oficial. **Resultado da
  investigação (fontes abaixo)**: RIPI/2010 (Decreto 7.212, art. 190) — a base do IPI
  na saída é o VALOR TOTAL DA OPERAÇÃO: preço do produto + frete + **demais despesas
  acessórias cobradas ou debitadas ao comprador** (seguro e outras cobradas do
  comprador INTEGRAM). E STF RE 567.935 (repercussão geral, unânime): **descontos
  incondicionais NÃO integram** a base do IPI (§2º do art. 14 da Lei 4.502/64
  declarado inconstitucional nesse ponto).
  **Para a web**: `vBC_IPI = mercadoria líquida de desconto incondicional + frete +
  seguro + outras acessórias` — o código atual (só frete) está INCOMPLETO; o
  comentário ":3042" se resolve incluindo seguro/outras. (Sugestão de IA conforme
  regra 5; decisão final do Valdo.)
  Fontes: [Portal Tributário — IPI Base de Cálculo](http://www.portaltributario.com.br/tributario/ipi-base-de-calculo.htm),
  [STF — RE 567.935](https://www.stf.jus.br/arquivo/cms/noticiaNoticiaStf/anexo/RE567935.pdf),
  [STF notícia — descontos incondicionais fora da base](https://stf.jusbrasil.com.br/noticias/137614161/descontos-incondicionais-nao-integram-base-de-calculo-do-ipi-decide-stf).
- ~~Q26~~ (2026-08-16) — confirmado pelo autor: no CST 03, `vAliqProd = ITF_VL_UNIT`
  é o comportamento correto. Manter na web.
- ~~Q22~~ (2026-08-16) — manutenção de `TB_MVA_UF_NCM`: hoje é uma aba na tela da UF;
  o desenho `ControllerUf → ControllerMvaUfNcm` PODE continuar (só a UI muda). Na web:
  **tela própria VINCULADA ao Estado, sem permitir alterar os dados do Estado** (Estado
  é catálogo central — trio geográfico). Sem importação externa.
  **DECISÃO FINAL (revisão do autor na mesma rodada): a tabela fica no SCHEMA DO
  CLIENTE — sem compartilhamento, sem colaboração.** A ideia inicial de alimentação
  colaborativa entre clientes foi levantada e DESCARTADA pelo autor; a sugestão de IA
  (catálogo central com procedência + override por institution) foi ARQUIVADA junto.
  **Porquê registrado**: MVA é interpretação — cada contador tem sua própria leitura;
  divergência entre clientes viraria briga que a Setes não tem como mediar. Dado
  fiscal interpretável NÃO se compartilha entre institutions.
- ~~Q23~~ (2026-08-16) — o conceito fecha com o PED_TIPO (processo-pedido-nota §1):
  - **Tipo 1 (Venda)**: só regras de SAÍDA, CFOPs de saída
  - **Tipo 2 (Compra)**: só regras de ENTRADA, CFOPs de entrada
  - **Tipo 3 (Ajuste)**: o PEDIDO se comporta como venda/compra; a tela de FATURAMENTO
    muda — campos para informar se é saída ou entrada + combobox de CFOP; o sistema
    busca a regra POR CFOP com `TRB_PRODUTO = 0` (finalidade "Outras"). Verificado no
    motor: `It_Cd_Natureza > 0` → filtro `NAT_CODIGO` + `TRB_PRODUTO := '0'`
    (`:901-904`).
  - **Origem do vínculo manual (P2.6b)**: o ajuste foi um dos casos que motivaram a
    escolha de regra POR ITEM. Dois caminhos do usuário: (a) muitos itens com o MESMO
    CFOP → define um CFOP para todos na tela de faturamento; (b) poucos itens, cada um
    com seu CFOP → cria a regra e VINCULA item a item (`TB_ITENS_NFL_TRIBUTACAO`).
  - **Devolução e troca são FRENTES SEPARADAS** (fora da tributação da nota de venda
    por construção — `ITF_OPER D/T` excluídos). Entram na fila de frentes futuras.
- ~~Q14~~ (2026-08-16) — os dois sentidos têm papéis DIFERENTES: `TRB_SENTIDO` é
  auxiliar de CADASTRO da regra (aponta se o lookup lista CFOPs de entrada ou de
  saída — controla o preenchimento); preenchida a lista, quem participa da REGRA em
  tempo de busca é `NAT_SENTIDO` (da natureza/CFOP escolhido). O uso de `TRB_SENTIDO`
  no rastreio (`:1966`) funciona porque ele espelha o sentido da natureza que ele
  mesmo filtrou. Na web: sentido no cadastro = filtro de lookup; sentido da natureza
  = componente da regra.
- ~~Q15~~ (2026-08-16) — SIM: `TB_TAXES_ID` liga a regra à `tb_taxes` (reforma
  IBS/CBS). Verificado: `model/tblTaxes.pas` tem `TB_INSTITUTION_ID`, `description`,
  `tb_taxes_incidency_id`, `CST` e `CLASSTRIB` — nomenclatura já no padrão web; e
  `tributacao.pas:3059` carrega `FTaxes` da regra casada, alimentando o pipeline P10.
  A regra de tributação VELHA é a porta de entrada dos tributos NOVOS.
- ~~Q16/Q19~~ (2026-08-16) — UM mecanismo: escolha de regra POR ITEM na digitação do
  pedido, gravada em `TB_ITENS_NFL_TRIBUTACAO`; existir a escolha É o gatilho do modo
  RegraDireta (§P2.6b). CST 51: a regra manda INCLUIR o frete — variante manual sem
  frete é desvio, não reproduzir.
- ~~Q20~~ (2026-08-16) — comportamento atual correto; linha comentada em `:1965` é
  morta, ignorar (§P2.8).
- ~~Q21~~ (2026-08-16) — manual deve SEGUIR a regra geral; CST 90 manual com base
  cheia é desvio, não reproduzir (§P2.6).
- ~~Q13~~ (2026-08-16) — status 0–3 persistido por MODELO de nota:
  `TB_RETORNO_NFE.NFE_CODSIT` (modelo 55), `TB_RETORNO_NFC.NFC_CODSIT` (modelo 65),
  `TB_RETORNO_NSE.NFS_CODSIT` (serviço). Verificado: `model/tblRetornoNfe.pas`,
  `tblRetornoNfCe.pas` e `tblRetornoNFS.pas` carregam os três `*_CODSIT`. Simetria
  com a numeração (§ Q4 do processo-pedido-nota): cada modelo tem sua tabela de
  RETORNO, e é nela que vive o ciclo 0–3.
- ~~Q17~~ (2026-08-16) — INTENCIONAL. Decisão de arquitetura do autor: muitas regras
  são difíceis demais de sustentar no sistema; em vários casos NÃO se trata para
  **empurrar a responsabilidade para a Receita** — ela retorna erros com códigos que
  sustentam o suporte (dizem o que deve ser feito). A Receita é o validador final;
  o sistema não duplica toda validação dela. **Princípio a PRESERVAR na web.**
- ~~Q18~~ (2026-08-16) — o campo é `TB_EMPRESA.EMP_IGNORAR_ST` (na web deve ficar em
  `tb_customer`). Verificado o mecanismo (`tributacao.pas:883-887`): parte do
  `PRO_SUB_TRIB` do item; se o produto É ST e o cliente tem `IgnorarCalculoST = 'S'`,
  força `Lc_Sub_Trib := 'N'` ANTES da busca — o flag do destinatário SOBRESCREVE o ST
  do produto, e a regra é procurada como não-ST.

### Método de trabalho desta frente

Um pipeline por rodada (P2 → P14): autor instrui o comportamento → verificação no
código → seção própria neste arquivo → divergências viram questões. Análises
transversais (§7) só depois dos pipelines mapeados. Regra de ouro: PERGUNTAR.
