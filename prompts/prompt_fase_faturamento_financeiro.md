# Prompt — Fase: Faturamento Fiscal e Financeiro (web)

**Escopo**: setes
**Estado**: Onda 1 ENTREGUE nos dois lados + GATES EXECUTADOS (2026-08-16 —
6 achados corrigidos, seed 28 dos catálogos fiscais criado/aplicado; ver seção
"Gates da Onda 1"). Próximo: RODADA do Valdo (RA-Q1..Q4 + Q-G1/Q-G2/Q-G4) →
ondas seguintes (W2 cálculo por item → faturamento → W3 financeiro).
**Fontes** (mapeamento do legado, fonte-da-verdade): `Infra-IA/Gestao2016/tributacao.md`
(P1–P14, T1–T8), `tributacao-plano-web.md`, `processo-pedido-nota.md`, `financeiro.md`,
`geracao-nfe-hierarquia.md`. Decisões numeradas abaixo citam as questões de origem (Qn).

---

## Contexto

O aprendizado do legado Gestao2016 fechou três frentes: processo pedido→nota
(Q1–Q12), tributação (P1–P14 + T1–T8, Q13–Q36) e financeiro (§1–§6 + QF1–QF3 +
sub-frentes cheque/cartão/caixa). A web JÁ possui: order-backbone (1 nota = 1 order,
ramos sale/service), `tb_invoice` com ramos merchandise/service, `tb_product.kind
P|M|S`, settlements IMUTÁVEIS (Software House DP1–DP12), `tb_payment_types`,
bank-accounts, Framework de Configurações, Entidade Única. A autorização/transmissão
está GUARDADA (modelo definido em geracao-nfe-hierarquia.md §4; miolo não mapeado) —
**o marco desta fase é nota PRONTA com impostos calculados + financeiro completo, não
nota transmitida**.

## Objetivos

1. Regra de Tributação na web: `tb_tax_rule` (seletor) + peças por tributo
   (presença = incidência), motor de busca com as 6 sutilezas preservadas
2. Cálculo por item conforme legislação (pilha de bases T3, ordem T1), para
   mercadoria E serviço, gravado por item na nota
3. Financeiro nascendo do faturamento (2 vias: automática pela negociação do
   pedido; manual/confirmativa na esteira), com meios, baixas, estorno em cadeia,
   caixa, cheque e cartão
4. Nenhuma regressão nos contratos vivos: espelho 5.5 do sync (`CONTRATOS_SYNC.md`),
   endpoints /order-*/invoice-* existentes

## Workflow (preservado do legado, corrigido por decisão)

### W1 — Pedido → Nota (já implementado na web; esta fase CONSOME)
Ordem com ramos + negociação (forma+prazo) → faturamento.

### W2 — Faturamento fiscal (novo)
1. Para cada item: buscar regra (motor §2 do tributacao.md — coringas, precedência
   NCM, estado exato×coringa, finalidade 0 no ajuste, presencial, escolha por item)
2. Regra não encontrada → INTERROMPE com alerta descritivo (produto a produto +
   critérios do destinatário) — mesmo conteúdo do legado (§3)
3. Calcular na ordem T1: rateio (resíduo no último) → IPI → ICMS (FCP antes do
   regime) → II → PIS/COFINS → ISSQN (kind S) → IBS/CBS (último, base subtrativa)
4. Persistir itens+impostos → gerar observações fiscais (catálogo, T6) → cabeçalho
5. Nota mercadoria+serviço = ramos; cada ramo autorizará no seu documento (fase futura)

### W3 — Financeiro (novo)
1. Nascimento na confirmação do faturamento (automático pela negociação OU tela
   confirmativa) — depois disso, manutenção SÓ no módulo financeiro.
   **Materialização (decisão 25)**: se o pedido tem parcelamento elaborado, usa-o;
   senão, o PRAZO gera o parcelamento neste momento — o financeiro nunca lê o
   prazo diretamente
2. Meios: espécie (à vista→caixa; a prazo→CARTEIRA), PIX (à vista→conta corrente),
   CHEQUE (baixa com o cheque; dívida vira o cheque), BOLETO (baixa por
   extrato/retorno/API — nunca no nascimento), CARTEIRA (manual)
3. Vida: juros/mora do cliente (sem automação, exceto boleto), reprogramação por meio
4. Morte: cancelamento não-autorizado → soft-delete total + ordem volta à origem;
   nota autorizada cancelada → ordem NÃO volta (cópia de ordem) + financeiro
   soft-delete COM estorno em cadeia das baixas; estorno em dinheiro exige caixa aberto
5. Caixa por dia/usuário; cheque com 2 elos de quitação; cartão com contrato
   (taxa+prazo → lançamento futuro + conciliação)

## Decisões arquiteturais registradas (herdadas do mapeamento — permanentes)

| # | Decisão | Origem |
|---|---|---|
| 1 | Regra de Tributação decomposta: `tb_tax_rule` (seletor) + peças 1:1 por tributo; **presença = incidência** | §6.5 tributacao.md |
| 2 | PIS e COFINS = UMA peça/implementação (`kind P\|C`) — "PIS igual a COFINS" | Q24 |
| 3 | ISS do município do PRESTADOR (cMunFG + alíquota) | Q27 |
| 4 | Item LC 116 POR produto-serviço (config global morre) | Q28 |
| 5 | Base IPI = mercadoria líquida de desconto incondicional + frete + seguro + acessórias (RIPI 190 + STF RE 567.935) | Q25 |
| 6 | Base IBS/CBS pela fórmula oficial (frete somado; ICMS 1×) | Q33 |
| 7 | FCP-ST usa a MESMA função de base do ICMS-ST | Q30 |
| 8 | Via manual segue a REGRA GERAL (só troca a fonte da alíquota) | Q19/Q21 |
| 9 | `TB_MVA_UF_NCM`/FCP no SCHEMA DO CLIENTE — dado fiscal interpretável NÃO se compartilha; tela vinculada ao Estado (imutável) | Q22 |
| 10 | SEM peça ISS na regra (ISS vem de prestador/produto/cliente) | Q27/Q28 + §6.5c |
| 11 | Peça II completa (II+AFRMM+SISCOMEX+IRPJ+CSLL — código vivo) | Q32 |
| 12 | Nota conjugada (serviço no XML da 55) MORTA; ramos autorizam separado | Q29/Q8 |
| 13 | Financeiro SEPARADO do faturamento; após confirmação, manutenção só no módulo | financeiro §3.1/§3.2 |
| 14 | Boleto NÃO baixa no nascimento (baixa por extrato/retorno/API) | QF1 |
| 15 | Cancelamento com baixas → ESTORNO EM CADEIA antes do soft-delete | QF2 |
| 16 | Meio de pagamento por classificação TIPADA (fim do match por descrição) | QF3 |
| 17 | Cheque = PORTADOR DE DÍVIDA: baixa do título COM o cheque; 2 elos de quitação (origem/destino → FIN_CODQTC); devolução gera título NOVO via nota avulsa | financeiro §5.1 |
| 18 | TEF fora da retaguarda (só PDV) | financeiro §5.3 |
| 19 | Caixa por DIA e USUÁRIO (nunca 2 no dia); dinheiro/cheque/cancelamento exigem caixa aberto | financeiro §5.4 |
| 20 | Nota autorizada cancelada: ordem NÃO volta (documento oficial); oferece cópia de ordem | financeiro §3.6 |
| 21 | Validação local mínima; Receita é o validador final (códigos dela sustentam o suporte) | Q17 |
| 22 | Ordem de cálculo é GRAFO (IBS/CBS por último); rateio com resíduo; persistir antes de observar; configs no Framework | T1/T2/T6/T7 |
| 23 | Peças da regra RATIFICADAS em bloco (a–h da §6.5): `tb_tax_rule` (seletor, incl. ST e `tb_taxes_id`) + `tb_tax_rule_icms` (próprio, com diferimento/destaque) + `tb_tax_rule_icms_st` + `tb_tax_rule_ipi` + `tb_tax_rule_pis_cofins` (kind P\|C) + `tb_tax_rule_ii`; CSTs por FK aos catálogos | R1-Q1 |
| 24 | Financeiro do ERP usa as MESMAS PEÇAS de settlement/estorno/movimento do Software House; o TÍTULO é tabela própria ligada ao order (reusar peça ≠ reusar tabela) | R1-Q2 |
| 25 | Negociação em DUAS vias com materialização ÚNICA: cliente simples usa o PRAZO (template `003 - 028/056/084`, datas predefinidas); cliente que negocia usa o PARCELAMENTO elaborado. **Regra: o financeiro consome SEMPRE o parcelamento; se não existir, o prazo GERA o parcelamento no faturamento** (um único caminho de consumo) | R1-Q3 |
| 26 | Meio de pagamento TIPADO via `kind` na `tb_payment_types`, **mantendo a descrição** (kind classifica, descrição continua livre); **PIX = kind próprio** (baixa em conta corrente × caixa) | R1-Q4 |
| 27 | Escopo da fase no financeiro: TÍTULO + baixas + estorno em cadeia + CAIXA; **cheque e cartão-contrato = onda 2** | R1-Q5 |
| 28 | Entrega: API + telas de CADASTRO nesta fase; telas de PROCESSO (faturar/baixar) na onda seguinte | R1-Q6 |
| 29 | O faturamento do ERP é o TERCEIRO PRODUTOR das MESMAS `tb_financial` + `tb_financial_bills` (junto do espelho 5.5 do sync e do Software House) — NENHUMA tabela de título nova; settlements/estorno/espelho funcionam sem alteração. Esclarecimento da 24: "reusar peça ≠ reusar tabela" significa que título, baixa e movimento são TRÊS conceitos/peças — não que o título ganhe tabela paralela | R2-Q1 |
| 30 | `tb_tax_ruler` do baseline (espelho largo da TB_TRIBUTACAO, sem endpoint de sync que a alimente) é APOSENTADA — drop na migration com checagem de dados por schema antes; a regra de tributação nasce na web já decomposta (família `tb_tax_rule*`), sem migração de linhas | R2-Q2 |
| 31 | Template de prazo segue **STRING LIVRE** na `deadline` do `tb_order_billing` (formato `028/056/084`) — SEM catálogo `tb_payment_term` nesta fase (recomendação de catálogo DECLINADA pelo autor; se a repetição justificar no futuro, o catálogo agrega sem reforma — a coluna já seria o snapshot) | R2-Q3 |
| 32 | `kind` na `tb_payment_types` com domínio COMPLETO desde já (espécie/PIX/cheque/boleto/carteira/cartão/outros — classificar ≠ implementar); backfill das linhas centrais por **MAPA DETERMINÍSTICO `id_nfce` → kind** (01→espécie, 02→cheque, 03/04→cartão, 05→carteira, 15→boleto, 17→PIX; sem id_nfce → outros p/ revisão) — id_nfce é o FPT_TIPO_NFCE no formato novo, já predefinido; NENHUMA heurística de texto. Cadastro de forma pelo CLIENTE mantém o padrão do catálogo: dedupe por DESCRIÇÃO na central (nunca duplica) + preenchimento privado de `tb_institution_has_payment_types`; forma nova define o kind no cadastro (sugerido pelo id_nfce) | R2-Q4 |
| 33 | FKs físicas SÓ em colunas INT (collation dos catálogos centrais sem normalização); integridade de CST/modBC/CFOP pela peça `@shared/tax-rule` | achado 1 do DDL |
| 34 | `tb_cashier.tb_user_id` — padrão da casa mantido JÁ (não adiado): rename coordenado executado nos dois endpoints /cashier web + docs vivos + FieldName do model destiny Delphi (contrato HTTP intacto — o nome da coluna não viaja no payload) | achado 3 do DDL |

## Parecer conceitual (setes-conceito, 2026-08-16) — síntese

Todas as peças auditadas passaram no teste do fato gerador. Constraints de desenho
que o parecer FIXOU (não são decisões novas — derivam das já registradas):

- As 6 sutilezas do motor viram **UMA peça transaction-aware** (`shared/tax-rule`)
  — nunca espalhadas por endpoint (a paridade do critério 1 depende disso)
- **Presença = "a regra DEFINE o tributo"**: CST de isenção (ICMS 40/41, PIS 07/08)
  é PRESENÇA com alíquota nula — o XML exige o grupo com CST mesmo sem imposto.
  Ausência ≠ isenção. Registrar no DDL e no motor
- O título financeiro **JÁ EXISTE** no baseline (`tb_financial` +
  `tb_financial_bills`, kinds R*/P*, PK inst+order+terminal+parcel) — settlements,
  estorno em cadeia e espelho 5.5 funcionam sem alteração se o ERP usar as mesmas
- Via simples da negociação já vive em `tb_order_billing` (payment_type + plots +
  deadline); a peça NOVA é só `tb_order_installment` (parcelamento elaborado;
  presença = elaborado, ausência = prazo gera)
- Caixa REUSA `tb_cashier` (existente, alimentada pelo sync); o que nasce é o GATE
  (`shared/cashier.requireOpenCashSession`) + trava "1/dia/usuário" no padrão
  `open_lock`; **saldo do caixa DERIVADO** de `tb_financial_statement` conta 0
  (nunca duas fontes; `tb_cashier_items` fica p/ conferência futura)
- Cheque (onda 2): elos pela QUITAÇÃO (`origin/destination_settled_code` — espelho
  do CHQ_QT_REC/PAG); devolução = composição pura (nota avulsa→título novo);
  levar à onda 2 o confronto flags mutáveis × baixas como EVENTOS
- Nomes validados; comentário de DDL deve distinguir catálogo CST (`tb_tax_*`) ×
  regra (`tb_tax_rule_*`)

## ⚠️ Questões pendentes (Rodada 2 — do parecer conceitual)

- ~~R2-Q1~~ — RESPONDIDA (Opção A → decisão 29)
- ~~R2-Q2~~ — RESPONDIDA (aposentar → decisão 30)
- ~~R2-Q3~~ — RESPONDIDA (string livre → decisão 31; catálogo declinado)
- ~~R2-Q4~~ — RESPONDIDA (domínio completo + mapa id_nfce→kind → decisão 32)

**Rodada 2: ZERADA (2026-08-16). 34 decisões registradas (32 + achados do DDL).**

## Onda 1 — ENTREGUE nos dois lados (2026-08-16)

**API**: peça `@shared/tax-rule` (motor com as 6 sutilezas + desempate
B9-corrigido + validação de CST nos catálogos) + módulo `tax-rules` (6 arquivos,
lista paginada com flags has*, /catalogs, cascata transacional, Swagger) + seed
sql/27 (interface 27 Registers, campos, page_size) + flag default/retroativa.
212/212 testes api + 32/32 sync; smoke ok (health/401/Swagger).

**APP** (setes-form-builder, 18 arquivos em `modules/tax_rules` + rotas + i18n
pt/en ~95 chaves): form artesanal molde carriers com 6 abas (Seletor + uma por
tributo com TOGGLE = presença; ICMS-ST desabilitado sem ICMS ligado), pendency
ancorada no PATH do payload (`icms.cstNr`, `pisCofins.P.cst`...) casando o
fields[] dos 400/422 da API com troca de aba no foco, draft preserva
observationId/taxesId (PUT não os zera), números como texto até o toJson.
`flutter analyze`: No issues found.

## ⚠️ Questões pendentes (rodada do APP — decisões do Valdo)

- **RA-Q1**: Produto/Cliente no seletor ficaram como campos NUMÉRICOS opcionais
  (não existe lookup compartilhado de Produto/Entity em app/shared; o de
  contratos é privado). Quando o cadastro de Produtos nascer, promover
  `ProductLookupDatasource` a shared e trocar por `SetesLookupField`?
  **(Recomendado: sim, na onda do cadastro de produtos)**
- **RA-Q2**: presença das peças na LISTA como tokens de texto ("ICMS + IPI") —
  evoluir a fábrica (rowBuilder com widgets) para chips visuais, ou texto basta?
- **RA-Q3**: `direction` virou dropdown "Ambos/Entrada/Saída" (vazio = coringa) —
  confirmar que "Ambos" é a leitura certa do NULL (e não "não se aplica").
- **RA-Q4**: ordem das abas Seletor → ICMS → ICMS-ST → IPI → PIS/COFINS →
  Importação (ordem do legado) — confirmar ou reordenar.

**Depois da rodada** (RA-Q1..Q4 + Q-G1/Q-G2/Q-G4 abaixo): ondas seguintes
(W2 cálculo por item → faturamento → W3 financeiro).

## Gates da Onda 1 — EXECUTADOS (2026-08-16; correções sem decisão aplicadas)

**Resultado: a entrega como estava REPROVARIA (socrático ~0.66) — corrigida na
própria sessão de gate → APROVADA: socrático 0.82 ✅, adversarial sem
HIGH/CRITICAL remanescente.** 216/216 testes api (4 novos fixam os achados);
`flutter analyze`/testes do app limpos. E2E REAL provado contra o banco dev:
POST 201 → GET com peças → PUT ressincroniza presença → flags has* na lista →
DELETE → 404; clamp de paginação ok; sem flag = 403.

Achados corrigidos (nenhum exigia decisão):

1. **HIGH provado (API)**: `GET /api/tax-rules` devolvia **500 no banco real** —
   a lista selecionava `st.description`, mas `tb_state` usa `name`. Os 212
   testes (mockados) não viam. Corrigido no repository + assert no teste.
2. **HIGH provado (operacional)**: os **8 catálogos fiscais centrais estavam
   VAZIOS** (nenhum seed os alimentava) — nenhuma regra podia ser criada (todo
   CST caía no 422 da decisão 33) e `/catalogs` vinha vazio. Criado e aplicado
   `sql/28_catalogos_fiscais_seed.sql` com as listas VERIFICADAS no legado
   (`Funcao/un_Conversao.pas` — CST ICMS/IPI/PIS/COFINS, modBC NR/ST), CSOSN
   oficial (grupos 101/102/500/900 confirmados no tributacao.pas) e desoneração
   do layout NF-e (legado fixa 0 — não constrange).
3. **MEDIUM (motor)**: a via RegraDireta (sutileza 6) buscava a regra **sem
   `tb_institution_id`** — regra de outro estabelecimento do mesmo schema
   tributaria a nota. Corrigido em `match.ts` + teste.
4. **MEDIUM (decisão 33)**: a peça prometia validar CST/modBC/**CFOP**, mas só
   cobria CST/modBC. `findInvalidCatalogCodes` agora valida `selector.cfopId`
   contra `tb_cfop` (422 com fields[] provado por smoke).
5. **MEDIUM (app, M1)**: desligar o ICMS deixava a ST **ligada e travada**
   (toggle desabilitado + pendência apontando para controle inacessível).
   Desligar o ICMS agora derruba a ST junto (P3.3).
6. **MEDIUM (app, M2)**: o `fields[]` de PIS/COFINS chega do Zod como
   `pisCofins.0.cst` e o form declarava `pisCofins.P.cst` — **nunca ancorava**
   (caía no dialog cru, sem trocar de aba). Tradução índice→kind pela ordem do
   toJson do draft.

Pontos abertos registrados (sem retrabalho obrigatório): validação de catálogo
fora da transação (catálogo é do Super, baixa rotatividade); `/catalogs` sem
cache (8 queries/chamada — candidato a TTL como o field-config); teto 100 nas
alíquotas do DTO; `tb_observation` ainda não existe (observationId aguarda W2);
LOWs estáticos do app (L1 `deferredAliq` oculto viaja no payload; L3 religar um
toggle só restaura o digitado com a aba montada; L5 fromJson tolera kind
duplicado vindo do banco).

### Questões para rodada (dos gates — decisões do Valdo)

- **Q-G1** (paridade do motor — amarra com RA-Q3): o WHERE do legado SEMPRE
  filtra `NAT_SENTIDO = :sentido` (§2 do tributacao.md) e a Q14 fixou "sentido
  da natureza = componente da regra em tempo de busca"; o motor web hoje NÃO
  filtra sentido nenhum — uma regra de entrada casaria item de saída. Como
  modelar: **(a)** `direction` do seletor participa do match com NULL = Ambos
  (recomendado — o app já apresenta o dropdown assim), ou **(b)** sentido entra
  só pela natureza (`tb_cfop.way`) quando o W2 tiver o item/natureza?
- **Q-G2** (NCM parcial): o cadastro aceita NCM de 2–8 dígitos e o match é por
  IGUALDADE exata — fiel ao legado (prefixo é regra SÓ do FCP, P7.1). Uma regra
  com NCM `84` nunca casa produto `84713012`. Manter fiel (recomendado) ou
  restringir o cadastro a NCM pleno para evitar regra morta por engano?
- **Q-G4** (conteúdo do seed 28): entraram as listas DO LEGADO (verificadas);
  os códigos oficiais que o legado não tinha ficaram FORA — ICMS monofasia
  02/15/53/61 (NT 2023.001) e PIS/COFINS de crédito/entrada (05, 49, 50–56,
  60–67, 70–75, 98). Incluir já ou quando a frente correspondente nascer?

## Scripts/Entregáveis do DDL (aplicados em dev 2026-08-16; 199/199 testes verdes)

| Script | O que faz | Decisões |
|---|---|---|
| `setes-api/migrations/025_tax_rule_family.sql` | `tb_tax_rule` (seletor) + 5 peças + DROP `tb_tax_ruler` (checagem D30 executada: 0 linhas em setes_setes; inexistente em setes_ws) | 1/23/30 |
| `setes-api/migrations/026_order_installment.sql` | `tb_order_installment` (parcelamento elaborado; PK espelha tb_financial) | 25/29/31 |
| `setes-api/migrations/027_payment_types_kind_central.sql` | `kind` na central + backfill por mapa id_nfce→kind (idempotente por information_schema — a migration roda por schema) | 16/26/32 |
| `sql/03_schema_cliente_ddl.sql` | blocos canônicos das 7 tabelas novas | — |
| `sql/01_setes_central_ddl.sql` | `kind` no canônico da tb_payment_types + domínio documentado | — |

### Relatório revisar-ddl (executado)

1. **FK string cross-schema × collation** — catálogos centrais criados SEM COLLATE
   explícito; FK física de string quebraria (caso real PADROES §5). Resolução:
   FKs físicas SÓ em colunas INT (entity/state/discharge/order/payment_types);
   CSTs/modBC/cfop validados pela peça `@shared/tax-rule`. FK física pode voltar
   após auditoria de collation dos catálogos.
2. **`cst` da pis_cofins sem FK física** — catálogos distintos por kind
   (tb_tax_pis × tb_tax_cofins); validação por kind na aplicação.
3. **`tb_taxes_id` sem FK** — `tb_taxes` (reforma) ainda não existe na web;
   criar FK quando nascer.
4. **Baseline sem colisão** — nenhuma das 7 tabelas existe no 001_baseline
   (checklist do caso tb_collaborator: ok).
5. **Resíduos varridos** — nenhum `.ts` referencia `tb_tax_ruler`.
6. **⚠️ Dados de DEV expostos pelo backfill**: linhas com `id_nfce` errado/nulo
   herdaram kind fiel ao erro ("3 - CARTAO DE DEBITO" com id_nfce '01' → 'E';
   "1 - DINHEIRO" sem id_nfce → 'O'). O MAPA é fiel; o dado de dev está sujo —
   é exatamente o caso da revisão pela tela do Super previsto na D32. Em
   produção o id_nfce vem do FPT_TIPO_NFCE (confiável).
7. ~~`tb_cashier.tb_userid` adiado~~ → **EXECUTADO na mesma rodada (decisão 34)**:
   Valdo decidiu manter o padrão `tb_user_id` JÁ. Verificado que o contrato HTTP
   não carrega o nome da coluna (payload Delphi montado à mão em
   cashier_send_web.pas) → ajuste contido no lado web: migration 028 (CHANGE
   COLUMN guardado por information_schema), endpoints /cashier dos DOIS lados
   (setes-sync e sync legado do setes-api), docs vivos (CONTRATOS_SYNC,
   MAPA_INDEXACAO, prompt_indexacao_usuario) e `FieldName` do model destiny
   Delphi (cosmético — sem recompilação urgente). Aplicado em dev; 199/199
   (api) + 32/32 (sync) verdes; varredura de resíduos zerada.
8. **Decisão 33 (ratificação do achado 1)**: FKs físicas SÓ em colunas INT —
   confirmado pelo Valdo ("use colunas int para ficarem sem risco"); strings
   validadas pela peça @shared/tax-rule.
9. **Dados de dev do backfill (achado 2)**: o PRÓPRIO Valdo corrige as linhas
   pela tela, garantindo o cadastro — sem ação de código.

## Fora de escopo desta fase

Autorização/transmissão (guardada — pipeline+strategy definidos), **cheque e
cartão-contrato (onda 2 do financeiro — decisão 27)**, **telas de processo (onda
seguinte — decisão 28)**, Receber Descontada, fechamento financeiro × caixa, TEF,
boleto por API Inter (requisito registrado), reforma IBS/CBS crédito
presumido/monofásico/seletivo (estruturas modeladas, implementação quando o
regulamento fechar), correções do LEGADO (plano próprio:
tributacao-plano-legado.md B1–B9/L1–L7/O1–O3).

## Critérios de sucesso

1. Regra criada na web casa os MESMOS itens que o legado casaria (paridade do motor,
   incluindo coringas/precedência/estado)
2. Nota de venda mercadoria+serviço calculada na web bate com o legado campo a campo
   nos CSTs cobertos — EXCETO onde há decisão de correção (5/6/7/8: divergência
   esperada e documentada)
3. Regra ausente → 422 com o conteúdo do alerta do legado (produto + critérios)
4. Financeiro nasce na MESMA transação do faturamento; baixa à vista automática
   por meio (caixa × conta) conforme W3
5. Cancelamento com baixas dispara estorno em cadeia; sem caixa aberto, operação
   em dinheiro é bloqueada
6. Espelho 5.5 do sync continua íntegro (testes de contrato verdes)
7. Gates do workspace: revisar-riscos-sistemicos ≥ 0.70 + testar-adversarial sem
   HIGH/CRITICAL
