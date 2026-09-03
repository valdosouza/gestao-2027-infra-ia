# Prompt — Regra de Tributação de Serviço (ISS)

**Escopo**: setes
**Estado**: RODADAS 1–2 FECHADAS (2026-09-02) — D1–D14; Onda 1 em execução.
**Origem**: rascunho do Valdo `Regra de tributacao de servicos.txt` + artigo
`Articles/iss-curitiba-aliquotas.md` (Curitiba = exemplo; vale para qualquer
município). Fase Faturamento Fiscal e Financeiro.

---

## O problema (diagnóstico confirmado no código)

- Serviço = `tb_product kind='S'` (D2 das notas); cadastro web nasceu em
  2026-09-02 (prompt_modulo_services.md). O serviço NÃO tem onde gravar o
  item da LC 116 (Q28 de tributacao.md foi decidida — "item POR PRODUTO" —
  mas nunca ganhou coluna).
- Regra de tributação atual = seletor de MERCADORIA (origem, NCM, ST,
  CFOP...) + peças ICMS/IPI/PIS-COFINS/II; DTO exige ao menos uma peça.
  Serviço nunca passa por regra: o `validate` do billing pula kind='S'.
- ISS hoje: `calcIssqn` com alíquota = `tb_city.aliq_iss` do município do
  PRESTADOR (Q27), retenção/exigibilidade/incentivo = flags do TOMADOR em
  `tb_entity_tax`. UMA alíquota por cidade contradiz a lei (Curitiba: 2 /
  2,5 / 4 / 5% por faixa de atividade; item LC 116 classifica) e contradiz
  a regra "dado interpretável fica no schema do cliente" (MVA/FCP).
- `tb_order_item_issqn` JÁ tem `listservice` e `tax_code` — vazios (fundação
  esperando produtor, não DDL novo).
- tributacao.md §6.5(c) deixou a porta aberta: "peça ISS não nasce, salvo
  override" — o Valdo agora diz que sobrou o caso.

## Parecer setes-conceito (resumo)

**Conceito**: o ISS de um serviço é definido pelo enquadramento do serviço
na Lista de Serviços (LC 116) dentro do município onde ele incide. Três
fatos geradores distintos → três peças (nenhuma é "peça ISS dentro da
tb_tax_rule"):

| Peça | Conceito | Onde |
|---|---|---|
| `tb_service_list` (NOVA) | item da LC 116 + local de incidência (P prestador / E execução) | setes_central (referência, como tb_cfop); seed oficial; módulo Super `service-list` |
| `tb_service_tax_rule` (NOVA) | o que o MUNICÍPIO cobra de um item: alíquota + código municipal; UNIQUE (institution, cidade, item) = unicidade do FATO | schema do cliente; módulo `service-tax-rules` |
| `tb_service` (especialização, Q28 materializada) | qual item o serviço É (+ código municipal se Q4) — espelho de tb_merchandise (PK compartilhada) | schema do cliente; campos no módulo `services` |
| `@shared/service-tax-rule` (peça nova) | resolve (institution, município de incidência, item) → regra; `calcIssqn` migra | setes-api (D5: caminho individual — fora de @shared/tax-rule) |

**Teste da maquete**: (A) regra que casa por seletor = maquete por excesso
(nenhum eixo do seletor de mercadoria serve; a chave é determinística);
(B) FK direta serviço → regra (texto literal do Valdo) = maquete por
rigidez nas exceções da LC 116 (incidência onde executa → outra cidade →
"ignorar a FK" vira guarda); (C) recomendado: serviço carrega o ITEM, a
regra se resolve por chave — o "lookup direto no serviço" continua, aponta
o enquadramento.

**Reusado sem alterar**: `tb_entity_tax` do tomador (retenção,
exigibilidade, incentivo, nº processo) e do emitente (CRT); `tb_order_item_issqn`
(ganha produtores de listservice/tax_code); `calcIssqn` (mesma fórmula,
outra fonte de alíquota); `tb_city`/IBGE; padrão validate/invoice do
billing (D42/R5-Q3); `tb_taxes_id` (elo da reforma IBS).

**Fora**: peça ISS na família tb_tax_rule; afrouxar o "ao menos uma peça"
da regra de mercadoria (a queixa 1 do rascunho se resolve por a regra de
serviço ser OUTRO objeto); seletor por tomador na alíquota; regime/ISS
fixo na regra (é do emitente); retenção na regra (é do tomador); emissão
NFS-e (frente própria); cálculo IBS/CBS; qualquer toque no setes-sync;
regra municipal compartilhada na central (Q8.1).

**Nomes a NÃO usar**: `tb_tax_rule_service` (lê como peça 1:1 da tb_tax_rule);
`tb_lc116` (legado/lei no nome visível).

## Questões da rodada (decisões do Valdo — recomendação do parecer entre parênteses)

- **Q1 — Chave × FK**: o serviço aponta a REGRA (FK direta, texto literal)
  ou o ITEM da lista, com a regra resolvida por (institution, município de
  incidência, item)? (rec.: ITEM — mata a guarda das exceções por construção)
- **Q2 — "Cidade do requerente"**: requerente = prestador (mantém Q27) ou
  tomador (reforma Q27)? (rec.: manter Q27 como regra geral; item de EXCEÇÃO
  da LC 116 → município do tomador. Q2.1: endereço do tomador serve de proxy
  do local de execução, ou a OS/pedido informa o município?)
- **Q3 — Onde mora o enquadramento**: (a) especialização `tb_service`
  (espelho tb_merchandise — natureza continua sendo `kind`; isto é atributo
  fiscal, papel do NCM na mercadoria); (b) colunas na tb_product; (c) só a
  FK da Q1(a). (rec.: a)
- **Q4 — Código de tributação municipal**: da regra (cidade × item) ou do
  serviço (dois serviços do mesmo item com códigos diferentes)? (rec.: no
  enquadramento do serviço, regra traz default; se for 1:1 com o item, só
  na regra)
- **Q5 — Simples Nacional / ISS fixo**: (a) motor ignora a alíquota da
  regra quando CRT 1/2 — e informa o quê na NFS-e?; (b) o cliente cadastra
  a alíquota que efetivamente informa e o motor não interfere; ISS fixo =
  flag no emitente. (rec.: b + flag) — matéria fiscal, decisão do Valdo.
- **Q6 — Serviço sem regra**: bloqueia (issue no validate + 422 no invoice,
  paralelo do D42) ou avisa (R5-Q4 aceitou ISS zero)? (rec.: bloquear —
  R5-Q4 superada para serviço)
- **Q7 — Vínculo gravado por item**: (a) não grava — resolução determinística,
  resultado vai para tb_order_item_issqn; (b) grava para paridade com
  tb_order_item_tax_rule (coluna/tabela irmã). RegraDireta para serviço?
  (rec.: a, sem RegraDireta até haver caso)
- **Q8 — `tb_city.aliq_iss`**: (a) dropar (+ seed 06d e catálogo de campos
  do cities) — fonte única = regra; (b) manter como fallback. (rec.: a)
  Q8.1: regra municipal COMPARTILHADA na central? (rec.: NÃO — Setes viraria
  responsável fiscal pelo dado interpretável)
- **Q9 — Exigibilidade/incentivo/nº processo** continuam no tomador
  (decisão 15 da Fase 3)? Tecnicamente são da operação. (rec.: não mexer
  agora; pendência para a NFS-e nativa)
- **Q10 — Lista LC 116**: só seed ou módulo Super `service-list` editável
  (molde cfop)? (rec.: seed oficial + módulo Super mínimo)
- **Q11 — Ondas**: (1) tb_service_list seed + tb_service + campos no
  services; (2) tb_service_tax_rule + módulos gêmeos; (3) caminho kind='S'
  no billing + @shared/service-tax-rule + produtores listservice/tax_code +
  drop aliq_iss. (rec.: nesta ordem)

## Rodada 1 — decisões do Valdo (2026-09-02)

- **D1 (Q1)**: FK LITERAL — o serviço aponta a REGRA (`tb_service.tb_service_tax_rule_id`).
  Consequência: o item da lista vive na REGRA (cidade × item → alíquota +
  código); o serviço herda o item pela regra apontada. (parecer recomendava
  apontar o item; decisão do Valdo prevalece — exceções da LC 116 ficam
  registradas como limitação conhecida, ver Rodada 2/Q2.)
- **D2 (Q2)**: terminologia = TOMADOR (não "requerente"); "prestador serve
  de proxy" — sentido a confirmar na Rodada 2.
- **D3 (Q3)**: especialização `tb_service` com PK/FK compartilhada com
  `tb_product` (espelho da tb_merchandise).
- **D4 (Q4)**: código de tributação municipal fica na REGRA.
- **D5 (Q5)**: alíquota fica na REGRA (Valdo pediu mais explicação — ver
  Rodada 2; assunção provisória: motor NÃO interfere por regime, ISS fixo
  fora até haver caso).
- **D6 (Q6)**: serviço sem regra BLOQUEIA (issue no validate + 422 no invoice,
  paralelo do D42).
- **D7 (Q7)**: PARIDADE com mercadoria — vínculo gravado por item (tabela
  irmã de tb_order_item_tax_rule para a regra de serviço; RegraDireta
  também? — confirmar na Rodada 2).
- **D8 (Q8)**: `tb_city.aliq_iss` MORRE (migration + seed 06d + catálogo de
  campos do cities); regra municipal NÃO é compartilhada na central.
- **D9 (Q9)**: exigibilidade/incentivo/nº processo continuam no TOMADOR.
- **D10 (Q10)**: lista LC 116 = seed oficial + módulo Super `service-list`.
- **D11 (Q11)**: ondas aprovadas — REORDENADAS pela D1 (o serviço aponta a
  regra, então a regra nasce antes do enquadramento): (1) `tb_service_list`
  seed + módulo Super; (2) `tb_service_tax_rule` + módulos gêmeos
  `service-tax-rules` + `tb_service` + lookup da regra no cadastro de
  serviço; (3) caminho kind='S' no billing + `@shared/service-tax-rule` +
  vínculo por item + produtores listservice/tax_code + drop aliq_iss.

## Rodada 2 — esclarecimentos pendentes

- **Q2 (cidade da regra × tomador)**: com FK literal, o serviço aponta UMA
  regra com UMA cidade. Leituras possíveis de "tomador; prestador serve de
  proxy": (a) a regra carrega a cidade do ESTABELECIMENTO (prestador como
  proxy do tomador — caso geral, mesma cidade) e o billing não confere a
  cidade do tomador; (b) a regra carrega a cidade de incidência e o billing
  CONFERE contra a cidade do tomador (divergência → issue bloqueante, D6).
- **Q5 (Simples/ISS fixo)**: alíquota na regra; falta fechar se o motor
  faz algo com CRT 1/2 (nada = o cliente cadastra a alíquota que informa)
  e se ISS fixo entra agora.

## Rodada 2 — decisões (2026-09-02, FECHADA)

- **D12 (Q2)**: opção (b) — a regra carrega a CIDADE DE INCIDÊNCIA e o
  faturamento CONFERE contra a cidade do TOMADOR: divergência → issue
  bloqueante (D6). "Prestador como proxy" = o cliente normalmente cadastra
  a regra com a cidade do próprio estabelecimento (caso geral: tomador na
  mesma cidade).
- **D13 (Q5)**: alíquota na regra, o cliente cadastra a que efetivamente
  informa (Simples = alíquota do anexo); motor NÃO interfere por regime;
  ISS FIXO FORA até haver caso.
- **D14 (Q7)**: paridade completa — vínculo por item gravado (tabela irmã
  de tb_order_item_tax_rule) INCLUINDO RegraDireta (origin 'M') para
  serviço.

## Execução — Onda 1 (2026-09-02): Lista de Serviços LC 116

- DDL `tb_service_list` no sql/01 canônico (Referência fiscal, antes de
  tb_ncm): id varchar(10) = item, description 255, local_incidence P/E,
  active, colunas padrão; COLLATE utf8mb4_unicode_ci.
- Seed sql/43 (idempotente, sqlglot OK): CREATE IF NOT EXISTS + 199 itens
  (38 com incidência 'E' — exceções do art. 3º; 4.22/4.23/5.09/15.01/15.09
  ficam 'P' por força da ADI 5835/STF) + interface Super 'service-list'
  (id dinâmico = 35 em dev) + catálogo de campos + page_size. APLICADO em dev.
- API módulo `service-list` (6 arquivos, molde cfop: id digitado, 409 mesmo
  excluído, imutável; lista paginada com ORDER numérico do item;
  superGuard). Testes service-list.test.ts.
- App módulo `service_list` (setes-form-builder, molde cfop) — em execução.
