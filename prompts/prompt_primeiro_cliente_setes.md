# Primeiro Cliente — Setes (entrega de ponta a ponta)

**Escopo**: misto (as ondas 2/3/4 — integração bancária, emissão fiscal e implantação em nuvem —
são método portável da engine; a configuração do cliente Setes é conteúdo `setes`)
**Aberto em**: 2026-09-13
**Origem**: `PrimeiroCliente-Setes.txt` (rascunho do Valdo)
**Estado**: Rodadas 1–5 DECIDIDAS (D1–D33) · Rodada 5 EXECUTADA 2026-09-19 (§11) · P0 FECHADO (D30–D32) · **Ondas 0 e 1 EXECUTADAS** · ordem D33: **Onda 2 (Inter) → 3 (NFS-e) → 4 (Produção)**; Onda 2 em planejamento (`prompt_onda2_banco_inter.md`)

---

## 1. Contexto

O primeiro cliente da Gestão 2027 é a **própria Setes**, que vende contratos de serviço de
software e manutenção via suporte. O objetivo do Valdo é **trilha de entrega de ponta a ponta**,
conferindo todos os processos, até o software em **produção**.

Os 7 processos do rascunho:

1. Cadastro de serviços
2. Cadastro de clientes
3. Cadastro de contratos
4. Cadastro de parcerias
5. Geração de cobrança mensal em lote
6. Emissão de boletos com envio para o **Banco Inter**
7. Emissão de **nota fiscal de serviço**

---

## 2. Diagnóstico do código real (2026-09-13)

| # | Processo | Estado | Onde vive |
|---|---|---|---|
| 1 | Serviços | **PRONTO** | `services`, `price-lists`, `service-tax-rules`, `service-list` (+ `@shared/service-tax-rule`) |
| 2 | Clientes | **PRONTO** | `customers` + entidade única + aba Tributação |
| 3 | Contratos | **PRONTO** | `contracts` + `tb_contract_item` + competência (migration 051) |
| 4 | Parcerias | **PRONTO** | aba do cliente — `tb_partnership` FLAT (`GET/PUT /api/customers/:id/partnership`); ordens PA na baixa |
| 5 | Cobrança mensal | **PARCIAL** | `POST /api/service-orders/monthly-run` **abre** as OS; faturar é 1 a 1 (`POST /:id/invoice`). **Falta o lote** |
| 6 | Boleto | **PARCIAL** | registro interno completo (`@shared/bank-slip`, eventos E/L/C/X, agrupado, desconto congelado). **Falta tudo do banco** |
| 7 | NFS-e | **PARCIAL** | a nota da OS nasce, mas SEM o ramo de serviço (achado A1/A2 da Onda 0). **Falta o ramo e a emissão fiscal** |
| 8 | Produção | **INEXISTENTE** | sem empacotamento, deploy, HTTPS, backup ou monitoramento |

Verificações que sustentam o diagnóstico:
- `setes-api/src/modules/` tem 44 módulos; não há nenhum arquivo com `cnab`, `remessa`, `nfse`,
  `rps` ou `inter` — as duas integrações externas **não começaram**.
- `shared/bank-slip/bank-slip.ts` (700 linhas) resolve o boleto como **fato interno**: emitir,
  cancelar, liquidar, estornar, agrupar, desconto. Nenhuma chamada sai da máquina.
- `monthlyRun` (`service-orders.repository.ts:519`) varre contratos vigentes na competência e
  injeta itens por cliente; o relatório é `{processed, opened, injected, skipped, errors}`.
- `setes-api` não tem Dockerfile, `ecosystem.config`, nem script de deploy; só `.env` de dev.

---

## 3. Rodada 1 — decisões do Valdo (2026-09-13)

**D1 — NFS-e pelo Padrão Nacional (ADN/Sefin).** A emissão vai ao ambiente nacional da NFS-e
(gov.br) com certificado A1, e não a webservice municipal. Consequência aceita: depende de o
município da Setes estar aderente ao ADN — **conferir antes da Onda 3** (é a 1ª tarefa dela).
Ganho: um conector só, que serve os próximos clientes.

**D2 — Banco Inter com credenciais prontas, escopo COMPLETO.** A conta PJ e a aplicação
(client_id/secret + certificado mTLS) já existem. A onda entrega **registro da cobrança + linha
digitável/PDF/QR Pix + baixa automática por webhook**, não só a emissão.

**D3 — Produção na SaveInCloud** (`https://saveincloud.com/pt-BR`): instância MySQL + Node
escalável com load balancer, domínio próprio — **`erp.setesgestao.com.br`** (setes-app web) e
**`api-erp.setesgestao.com.br`** (setes-api).

**D4 — Dados vêm do sincronizador do legado.** A base de produção da Setes é alimentada pelo
Gestao2016 via sincronizador, como no piloto de 2026-08-14.

**D5 — o achado A1 se corrige CHAMANDO as peças no caminho da OS.** A ordem de serviço NÃO passa
a delegar ao módulo `billing`: ela tem trava D5, ciclo próprio e cancelamento por ramo, e a fase
do cancelamento acabou de fechar. Duas portas, uma política.

**D6 — o lote fatura o que o operador SELECIONA na tela** (não "tudo que a competência abriu"):
segurar um cliente em negociação tem que ser possível.

**D7 — ordem que falha não derruba o lote**: cada uma fatura na própria transação e a recusada
sai no relatório com o motivo — mesma semântica do `errors[]` da rotina mensal.

**D8 — as 4 pendências do P0 serão configuradas com os valores do Valdo** (não com defaults meus).

> **Limite factual da D4** (não é objeção, é escopo): o catálogo do sync tem 33 classes e
> **nenhuma de contrato ou parceria** — esses dois processos **nascem na web** por cadastro.
> O sync traz cliente, serviço/produto e os movimentos. E, pela regra dos dois grupos, o
> `setes-sync` entra nesta fase **apenas como instância a publicar**, nunca como código a alterar.

---

## 4. Plano de ondas

### Onda 0 — Implantação do ambiente Setes + trilha E2E *(sem decisão pendente)*
Baixa as 6 tarefas de implantação acumuladas (§10.3 do `prompt_cancelamento_nota.md`) na base da
Setes e cria a **trilha de tracking**: um roteiro executável que percorre os 7 processos e reporta
onde parou. É a régua que vai medir cada onda seguinte.

### Onda 1 — Faturamento em lote da cobrança mensal
Hoje a rotina abre N ordens de serviço e o operador fatura uma a uma. Entrega: faturar o lote da
competência (API + tela), com relatório por ordem (faturada / recusada + motivo), reaproveitando
o `issueInvoice`, o contrato financeiro e a emissão automática de boleto que já existem.

### Onda 2 — Banco Inter (cobrança v3)
Peça de integração + provider Inter: registro, linha digitável/código de barras/PDF/QR Pix,
cancelamento no banco e **baixa por webhook** caindo na peça de liquidação que já existe
(`settleBankSlip`). O boleto interno não muda de modelo — ganha um espelho no banco.

### Onda 3 — NFS-e Nacional (ADN)
Conferir adesão do município; DPS → ADN com certificado A1; protocolo, chave de acesso, PDF
(DANFSe), cancelamento por evento. Estado derivado de evento, como nota e boleto.

### Onda 4 — Produção na SaveInCloud
Empacotamento (API Node + app Flutter web + MySQL), domínios e HTTPS, CORS de produção, variáveis
e segredos (certificados A1 e mTLS **nunca** no repositório), backup, log/monitoramento, e a
instância do `setes-sync` para a D4. Publicação e virada com o legado em paralelo.

---

## 5. Questões abertas (Rodada 2 — aguardam o Valdo)

- **Q1** — Município da Setes está aderente ao ADN nacional? (bloqueia a Onda 3; conferir na
  lista oficial antes de escrever qualquer linha do conector)
- ~~**Q2/Q3/Q7** — escopo e falha do lote~~ → **FECHADAS na Rodada 1** (D5/D6/D7 abaixo).
- **Q8** — o lote usa UMA forma de pagamento para todas as ordens. Cliente que paga por outro
  meio exige um segundo lote. Basta assim, ou a forma deve vir do cliente/contrato?
- **Q9** — `auto_bank_slip` é config da interface `billing`, mas a política "emitir boleto no
  faturamento" é do estabelecimento, não da tela de venda. Manter a chave única (hoje) ou mover
  para config de escopo I, neutra? (parecer do guardião conceitual, ponto 1)
- **Q4** — Onda 2: o webhook do Inter exige URL pública **antes** da Onda 4; publicar a API cedo
  (só o endpoint do webhook) ou reordenar 4 antes de 2?
- **Q5** — Onda 4: quem é o titular do domínio `setesgestao.com.br` e o DNS já está sob controle?
- **Q6** — Onda 4: virada big-bang ou a Setes roda web e legado em paralelo por N meses?
  (a D4 sugere paralelo, mas o sentido web→Firebird não existe — o que nascer na web **não
  volta** para o legado)

---

## 6. Registro de execução

### Onda 0 — EXECUTADA (2026-09-13)

Entregue: `setes-api/scripts/trilha-primeiro-cliente.ts` — a **régua da fase**. Percorre os 7
processos contra a API de verdade (HTTP) e reporta por etapa OK / FALHA / PENDENTE, com a onda
responsável no detalhe. Cada onda seguinte tem que virar PENDENTE em OK sem quebrar nenhum OK.

```
npx tsx --require tsconfig-paths/register scripts/trilha-primeiro-cliente.ts
npx tsx --require tsconfig-paths/register scripts/trilha-primeiro-cliente.ts --only=P0
```

`--only=P0` roda só a conferência de implantação e **não cria nada**; a trilha completa cria
serviço, contrato, parceria, OS, nota e título a cada execução (ids no rodapé para conferência).

**1ª corrida no dev (setes_setes, institution 1): 10 OK · 10 PENDENTE · 0 FALHA.**
A cadeia contrato → cobrança mensal → OS → faturamento → título fecha ponta a ponta.

| Etapa | Resultado |
|---|---|
| P0.1 `max_parcels` | PENDENTE — 6/6 formas com limite 1 |
| P0.2 privilégios FATURAR/CANCELAR | PENDENTE — nenhum vínculo ativo de usuário regular |
| P0.3 política de desconto (seed 55) | OK — privilégio 8 nas 2 interfaces |
| P0.4 teto do desconto | PENDENTE — sem valor → default 0 |
| P0.5 `auto_bank_slip` | PENDENTE — 'N' |
| P0.6 contrato financeiro | OK — 1 forma |
| P0.7 carteira de cobrança | OK — 1 ativa |
| P1 serviços · P2 clientes · P3 contratos · P4 parcerias | **OK** |
| P5 cobrança mensal (abertura) | **OK** — abriu 1 OS, injetou 1 item |
| P6 faturamento da OS | **OK** — nota 6542, título de R$ 250,00 |

### Dois achados da Onda 0 (mudam o escopo das ondas 1 e 3)

**A1 — o faturamento da OS não passa pelas peças do financeiro por forma.**
`tryIssueBankSlipsOnBilling` e `tryAutoSettleByContract` são chamadas **só** em
`billing.repository` (venda). O caminho da OS (`service-orders.repository.ts:766`) emite a nota e
grava `tb_financial`/`tb_financial_bills` direto. Consequência para a Setes, cuja receita inteira
é contrato → OS: **a cobrança mensal não emite boleto nem baixa pelo contrato financeiro**, e
ligar `auto_bank_slip` não muda nada. Entra na **Onda 1** junto com o lote — é a mesma porta.

**A2 — a nota da OS nasce sem o ramo de serviço.** A chamada passa `serviceTotal: null`, então
não há linha em `tb_invoice_service` (deliberado: a nota da OS era "fatura interna", DP8). Sem o
ramo não há base de ISS para a NFS-e. Entra na **Onda 3**, antes do conector do ADN.

Nenhum dos dois é regressão: são o limite exato de onde a fase anterior parou — e é por isso que
a trilha existe.

---

### Onda 1 — EXECUTADA (2026-09-13)

Entregue nos dois lados. **805/805** jest (api) · **45/45** + analyze limpo (app) · trilha ao vivo
**14 OK · 7 PENDENTE · 0 FALHA**.

**Peça nova** `@shared/db/savepoint` — `runIsolated(conn, name, label, fn, context)`: trecho
opcional dentro de transação. Guarda a sutileza que estava inline duas vezes: `ROLLBACK TO
SAVEPOINT` que FALHA significa que o deadlock matou a transação inteira → propaga o erro
original; só o rollback bem-sucedido autoriza seguir sem o trecho.

**Composição nova** `@shared/title-automation` — `applyTitleAutomation`. Conceito (parecer do
guardião conceitual, 2026-09-13): *o desfecho que a FORMA DE PAGAMENTO dá à parcela recém-nascida*.
Fato gerador = o título nascendo. Dois desfechos mutuamente exclusivos por construção (a auto-baixa
recusa `kind` 'Q' e 'B' por KIND_FIXED; o boleto só emite em 'B'). Resolve sozinha a config
`auto_bank_slip` (novo `getConfigContentFor` — fonte única; era o chamador que precisava saber
que a config existe, e foi por isso que a OS nasceu sem ela). **Fora da composição**: o cheque
(ato declarado do usuário, obrigatório, derruba a nota de propósito), comissão/devolução/status
(fatos do pedido) e a emissão da nota (a montante). Nome `billing-automation` foi REJEITADO —
`billing` é nome de módulo e a entrega existe justamente para a OS não depender dele.

**A1 corrigido (D5)**: `service-orders.repository.generateInvoice` chama a composição depois de
gravar os títulos e antes do A→F. `billing.repository` passou a chamar a MESMA composição no lugar
do bloco inline — os nomes dos savepoints foram preservados (`auto_settle`, `auto_bank_slip`), e a
suíte do billing passa **sem alteração**, o que é a prova de que a extração é neutra para a venda.
Efeito colateral consciente: a ordem virou baixa → boleto → cheque (era baixa → cheque → boleto);
as três agem sobre parcelas disjuntas por `kind`, então nenhuma delas vê o resultado da outra.

**Lote (D6/D7)**: `POST /api/service-orders/batch-invoice` com `requirePrivilege('service-orders',
FATURAR)`; cada ordem na própria transação; id repetido conta uma vez (o 2º viraria um 409 que o
operador não cometeu); **HTTP 200 mesmo com falha parcial** — o lote não é uma operação única, é N
faturamentos independentes, e quem conta a história é `results[]`. Falha técnica não vaza detalhe
para o cliente (vai a log com stack). Limite 200 por lote.

**App**: checkbox na aba Abertas (só com `can('FATURAR')`), ação "Faturar selecionadas" com contador
na AppBar, dialog de condições reaproveitado do faturamento avulso, relatório com as recusadas e o
motivo. A seleção **sobrevive** às recusadas: o operador corrige e repete só elas.

### Achado novo da Onda 1 (implantação)

**A3 — o boleto automático dispara pelo `kind='B'` da forma, não pelo nome.** No dev, a forma
"6 - BOLETO" estava com `kind='O'` e por isso nenhum boleto era emitido, com toda a configuração
correta. Virou a conferência **P0.8** da trilha. Duas chaves de dev foram viradas para provar o A1
ao vivo (boleto 91/92 emitidos no faturamento da OS): `auto_bank_slip` = 'S' e a forma 6 para
`kind='B'` — **decisão de configuração do Valdo, não minha** (item da D8).

### Resíduo da Onda 1 no dev

Trilha executada 6 vezes: serviços 19–24, contratos 19–24, OS 7656–7661, notas 6540–6545,
boletos 91–92. Podem ser ignorados ou limpos.

### Gate socrático da Onda 1 — **0.73 PASSOU** (2026-09-13)

Nenhuma regressão no faturamento da VENDA: a extração é fiel (mesma data local, mesma sutileza do
1213 no savepoint, mesmos motivos silenciosos) e a suíte do billing passou sem alteração.
Multi-tenant, autorização, idempotência do lote e contadores conferidos e limpos.

Achados para corrigir em sessão (não pedem decisão):
- **H1** — a composição lia a config `auto_bank_slip` pelo `pool` **dentro** da transação: uma
  SEGUNDA conexão enquanto a primeira segura o X da institution e os títulos. Com 20 conexões no
  pool e `waitForConnections: true`, faturamentos concorrentes podem se travar mutuamente. Antes do
  refactor essa leitura era feita FORA da transação.
- **H2** — o lote capturava o erro no service, antes do `handleError`, então a **contenção**
  (1205/1213) chegava ao operador como `INTERNAL_ERROR` — código que nem existe no catálogo —
  em vez do `RESOURCE_BUSY` transversal (D-A3). O operador não distinguia "tente de novo" de bug.
- **M1** — ordem de locks: a composição entrou antes do cheque (baixa → boleto → cheque), contra a
  regra 3 do PADROES §9 (cheque → baixa → extrato; boleto DEPOIS).
- **M2** — a seleção da tela sobrevivia à paginação e ao filtro (o comentário do código prometia o
  contrário): dava para faturar ordem que o operador não estava vendo.
- **L1** — `autoBankSlip` continuava resolvido e trafegando em `billing.service`/`persistInvoice`,
  agora morto: duas fontes para a mesma flag.
- **L2** — `runIsolated` interpola o nome do savepoint direto no SQL (hoje só literais).

### Questões da Rodada 2 abertas pelo gate (aguardam o Valdo)

- **Q-P1** — `auto_bank_slip` mora na interface `billing`, mas agora governa também o faturamento
  da ORDEM DE SERVIÇO, cujo ramo é `service-orders` (privilégio, seed 53 e gate da tela são todos
  pelo ramo). Cliente que contratou OS **sem** a interface `billing` tem o boleto automático regido
  por uma config de interface que ele não possui. Fica assim (política de empresa), vira config
  própria do ramo, ou sobe para escopo transversal? *(é a mesma Q9 vista de outro ângulo)*
- **Q-P2** — o lote responde 200 com `ok: true` mesmo com `invoiced: 0` e `failed: 200`. Mantém,
  ou 207/422 quando nada faturou, ou `ok` derivado de `failed === 0`? É contrato, não código.
- **Q-P3** — ordem que falha por CONTENÇÃO dentro do lote: o lote reexecuta sozinho ao final (uma
  passada extra) ou devolve marcada como "tente de novo" e a decisão fica com o operador?
- **Q-P4** — a seleção deve sobreviver à paginação de propósito (marcar ao longo de várias
  páginas) ou ser limpa a cada recarga? *(corrigi para limpar — o comentário do código prometia
  isso; se você quiser o contrário, é trocar uma linha)*

### Gate adversarial da Onda 1 — **0.55 REPROVOU** → corrigido em sessão (2026-09-13)

Três HIGH **provados ao vivo**, dois deles pré-existentes que a Onda 1 tornou alcançáveis em massa:

- **A-1 (HIGH) — travamento PERMANENTE do pool.** A composição lia `auto_bank_slip` pelo `pool`
  DENTRO da transação: 2ª conexão com a 1ª presa segurando locks. Prova: **0 de 40 faturamentos
  concluídos em 45 s, API pendurada** (não é lentidão — para tudo até reiniciar). Pior: no caminho
  da VENDA a leitura era feita ANTES da transação, e era ela que aquecia o cache e protegia a venda
  por acidente. **Corrigido**: `resolveTitleAutomationConfig` roda antes do `beginTransaction` nos
  dois caminhos e o valor entra como parâmetro. Re-prova: **40/40 em 1,1 s, API viva**.
- **A-2 (HIGH) — `generateInvoice` cunhava número sem travar a institution** (regra 7 do PADROES §9):
  6 de 12 faturamentos concorrentes morriam com 1213 depois dos 3 retries. Defeito do caminho da OS,
  não da Onda 1 — mas o lote o tornou rotina. **Corrigido**: `lockInstitutionCounters` como 1º lock.
- **A-3 (HIGH) — `dtExpiration: '2026-13-45'` era ACEITA** e virava `0000-00-00` no título e no
  **boleto, que é imutável por decisão**. **Corrigido**: peça `isValidIsoDate` (formato + calendário).
- **A-4 (MEDIUM) — parcela de R$ 0,00 do rateio cancelava TODOS os boletos da ordem**, em silêncio:
  `issueBankSlip` recusa saldo zero com 409 e o erro subia pelo savepoint do bloco. **Corrigido**:
  a composição ignora parcela de valor zero (não há o que baixar nem o que cobrar).
- **A-5 (MEDIUM) — "faturada" não quer dizer "cobrada".** Contenção, 0 carteiras ou 2 carteiras
  deixam a nota sem baixa e sem boleto, e o relatório dizia só "faturada". Para a Setes isso é um
  lote "100 % faturado" e **zero cobrado**. **Corrigido**: `autoSettled`/`bankSlipsIssued` por linha
  e `uncharged` no relatório e na tela.

### Re-score socrático — **0.76 PASSOU** (2026-09-13), com um HIGH que eu tinha deixado pela metade

As 6 correções da 1ª passada fecham o que ele apontou, e a varredura confirmou que **nenhuma outra
peça shared lê do `pool` dentro de transação**. Mas ele cobrou, com razão: *corrigir a PORTA do
ataque não fecha a CLASSE*. A validação de data tinha ficado só em service-orders e contracts,
enquanto `bank-slips` (o próprio artefato imutável do achado), `settlements`, `orders`, `checks`,
`billing`, `financial-contracts`, `bank-accounts`, `price-lists` e `collaborators` seguiam com regex
de formato puro. **Fechado**: a peça `isValidIsoDate` está nos 9 DTOs.

Mais dois fechados na mesma passada:
- **tripwire do A-1**: a invariante mais cara da onda era defendida por um comentário. Agora há teste
  que cai se alguém mover a leitura de volta para dentro da composição — e o docblock de
  `getConfigContentFor`, que literalmente convidava ao erro ("roda DENTRO de uma transação"), virou
  o aviso contrário.
- **minha correção do M2 passou do alvo**: o escopo da seleção entrava também no estado de LOADING,
  então qualquer recarga limpava tudo — inclusive a recarga logo após o lote, matando a promessa de
  "repetir só as recusadas". Agora só lista CARREGADA define o escopo.

Duas questões novas do re-score (aguardam o Valdo):
- **Q-P5** — o relatório deve distinguir cobrança PARCIAL (x de n parcelas com boleto) da integral,
  ou `uncharged` binário basta? Hoje uma nota de 3 parcelas com 1 boleto conta como cobrada.
- **Q-P6** — 200 ordens síncronas numa requisição × timeout do load balancer da SaveInCloud
  (Onda 4): baixa o teto, fixa o timeout do LB, ou o lote vira processo assíncrono com relatório
  consultável? Está amarrada à Onda 4.

**Provas finais da Onda 1**: 823/823 jest · 47/47 + analyze limpo · 40 faturamentos concorrentes em
1,1 s sem 500 · trilha E2E 14 OK · 7 PENDENTE · 0 FALHA.

### Re-prova adversarial — **0.68**, e o que ela ensinou (2026-09-13)

**Nenhuma regressão** das 9 correções: as 6 que dependiam de prova ao vivo morreram medidas —
21 chamadas concorrentes (faturamentos + lote + baixas + aberturas) em **1,0 s** sem 500 e com a
API viva; rotina mensal concorrente com 6 faturamentos 7/7; contenção devolvendo `RESOURCE_BUSY`
por linha; `uncharged` correto nos dois lotes (dinheiro 4/4 sem cobrança × boleto com 4 boletos
reais). Auth, bordas, multi-tenant e colisão de rota limpos.

O HIGH que ela levantou (`POST /settlements` com `2026-13-45` → 201) era **código anterior ao
fechamento da classe** — a re-prova começou antes do patch dos 9 DTOs. Conferido ao vivo depois:
`settlements` e `bank-slips` recusam `2026-13-45`, `2026-02-30` e `0000-00-00` com 400
VALIDATION_FAILED no campo. A linha corrompida que o gate criou (`tb_financial_statement` 976 +
`tb_financial_payment` settled_code 827) foi soft-deletada; **zero** movimentos vivos com
`dt_record = '0000-00-00'` no dev.

Dois MEDIUM novos eram REAIS e pré-existentes ao alvo — mesma regra da casa, "o que valida é o que
grava" (Q-A27), e por isso foram corrigidos agora:

- **A-6 — clamp silencioso do DECIMAL no item da OS**: `unitValue: 1e12` voltava 201 e o banco
  gravava `9999.999999`; `quantity: 1e9` virava `999999.9999`. A nota nascia com total diferente do
  enviado. **Corrigido**: tetos do DECIMAL no DTO (`unit_value` 10,6 · `quantity` 10,4).
- **A-7 — nota e título de valor ZERO**: a guarda `SERVICE_ORDER_ITEM_VALUE_REQUIRED` validava em
  FLOAT, então `unitValue: 0.001` passava, o DECIMAL gravava 0,00 e a OS faturava **consumindo
  número de nota** com título de 0,00 — e, depois da correção A-4, em silêncio total (sem baixa,
  sem boleto, sem erro). **Corrigido**: a guarda confere em CENTAVOS pela peça `@shared/money`.
  Prova ao vivo: 1e12 → 400, 1e9 → 400, 0,001 → 422, 0,004 → 422, 50,00 → 201.

Também fechados: `bankSlipsIssued` no resultado do billing (simetria com a OS) e o docblock de
`findOpenCashierId` (gêmea que usa `pool` e não tem chamador — armadilha pronta para reintroduzir
o A-1).

**Achado da própria trilha**: ela pegava "a última OS do schema" e acusou FALHA quando outra prova
faturou essa OS no meio. Agora pega a OS **ABERTA do cliente da trilha** — régua não pode depender
de quem mais está usando o dev.

### Pendências da Onda 1 (aguardam o Valdo)

- **Q-P7 (LOW-9 do gate)** — com a correção A1, toda mensalidade em forma com contrato financeiro
  nasce BAIXADA. Cancelar essa nota passa a exigir estorno manual da baixa (409 legível: "Título
  7927/1 tem baixa de 55,50 — estorne a baixa antes"). É o comportamento que você quer para a
  cobrança mensal, ou o cancelamento deve estornar a baixa AUTOMÁTICA junto?
- **A-8 (MEDIUM, não corrigido — ligado à Q-P6)**: sob contenção, cada linha do lote custa ~11 s
  (o `FOR UPDATE WAIT 10`). Um lote de 200 com um detentor lento passa de meia hora numa única
  requisição, e se o cliente desistir o relatório — única prova do que foi cobrado — se perde. No
  caminho feliz são ~50 ms por linha. A resposta é a Q-P6 (teto menor × timeout do LB × lote
  assíncrono), que está amarrada à Onda 4.
- **Q-P5** — `uncharged` é binário: nota de 3 parcelas com 1 boleto conta como cobrada.

**Estado final da Onda 1**: **825/825** jest · **47/47** + analyze limpo · trilha **14 OK · 7
PENDENTE · 0 FALHA** · 16 faturamentos concorrentes em 0,7 s sem 500.

---

## 7. Rodada 2 — a confusão da palavra "contrato" (2026-09-13)

O Valdo: *"foi feita uma confusão entre contrato financeiro para baixa automática e contrato no
cliente para gerar faturamento em lote... vamos trabalhar isso para não ter mais confusões"*.

### O fato que enquadra tudo: a condição de uma decisão não foi cumprida

`prompt_contrato_financeiro_baixa_automatica.md:202` — **D15**: mantém `tb_financial_contract` e o
módulo `financial-contracts`, *"Rótulo da tela deve **distinguir** do contrato comercial do Software
House (`tb_contract`)"*. A Q8 daquela rodada já tinha levantado a colisão e recomendado
`tb_settlement_contract`; o Valdo optou por manter o nome **em troca** do rótulo que separasse. O
rótulo saiu "Contratos Financeiros", ao lado de "Contratos". Ficou a metade cara da decisão e faltou
a metade barata — e é daí que a confusão nasceu, não de erro de modelagem.

### Parecer do guardião conceitual

- **Nenhum dos dois é maquete.** `tb_contract` (mensalidade) tem fato gerador claro e a idempotência
  da rotina virou FATO, não guarda (`tb_contract_item_competence` — a regra morreu por construção).
  `tb_financial_contract` é especialização legítima do vínculo institution×forma.
- **O nome errado é o do financeiro**: "contrato financeiro" não diz contraparte, nem objeto, nem
  efeito — precisava de 3 linhas de comentário no DDL e de um texto de ajuda na tela. O nome certo
  é o da família que a casa já usa: `tb_tax_rule` → "Regras de Tributação", logo
  **`tb_settlement_rule` → "Regras de Recebimento"**.
- **"Contrato" tinha SEIS sentidos** no sistema, três visíveis ao usuário: mensalidade do cliente ·
  contrato financeiro · "Contrato de interfaces atualizado" (o contrato comercial das telas,
  `tb_institution_has_interface`) · carteira de cobrança ("contratação com o banco") · "Data do
  Contrato da Conta" · contrato de API nos comentários.
- **Alerta para a Onda 2**: se o objeto financeiro tivesse nome de "acordo com o banco", as
  credenciais do Banco Inter seriam atraídas para dentro dele e ele viraria gaveta. Credencial é da
  CONTA (`tb_bank_account`), não da forma nem da carteira.

### Decisões da rodada (Valdo)

**D9 — separar de verdade: rótulo + tabela + módulo.** Reabre a D15.
`tb_financial_contract` → **`tb_settlement_rule`**; módulo `financial-contracts` →
**`settlement-rules`** (`/api/settlement-rules` ↔ `/home/settlement-rules`); telas
**"Regras de Recebimento"** × **"Contratos de Mensalidade"**. Feito agora porque o Inter e o
recorrente multiplicariam as 122 ocorrências — e porque o `setes-sync` não consome nenhuma das duas
tabelas (grep zero), então o outro grupo não é tocado.

**D10 — a D16 fica de pé**: o cadastro CONTINUA aceitando regra em forma de cheque/boleto, que o
motor ignora (`KIND_FIXED`). Mas o aviso saiu da TELA e virou comentário na peça — instrução ao
usuário não é lugar de regra do motor; o limite agora está onde o próximo programador lê.

**D11 — o recorrente continua só de SERVIÇO.** Registrado como limite DELIBERADO (a Setes só vende
serviço), não como lacuna: as duas guardas `kind='S'` e o destino fixo em Ordem de Serviço ficam.
As tabelas já são agnósticas (item é produto + valor), então generalizar depois não pede coluna nova.

**D12 — `payment_day` ganha o efeito que o nome promete.** Era coluna informativa sem produtor.
Agora o vencimento sugerido vem do dia do CONTRATO que alimentou a ordem
(`GET /service-orders/expiration-suggestion?...&orderId=`), com a regra da DIVERGÊNCIA: dois
contratos do mesmo cliente com dias diferentes na mesma ordem não têm "o dia do contrato" — volta ao
5º dia útil, porque escolher um (o menor, o maior) seria decidir pelo usuário sem ele saber.

### Execução

- **migration 052** `RENAME TABLE` (uma instrução, como a 039 fez com a carteira) + `sql/03`
  canônico; **seed 56** migra o catálogo das bases já semeadas (i18n_key, `table_name` do catálogo
  de campos, `module_key` da feature flag); seeds **46/47 renomeados** e reescritos para nascerem
  certos.
- API: módulo e arquivos renomeados, 15 arquivos de identificadores, rota `/api/settlement-rules`.
- App: módulo `settlement_rules` (15 arquivos), i18n pt/en reescrito (os rótulos falam de
  **taxa da operadora** e **prazo de recebimento**, não de "contrato").
- Trilha: P0.6 virou "regras de recebimento por forma" e P3 "Contrato de mensalidade" — a régua
  agora usa o vocabulário separado.

**Provas**: 833/833 jest · 47/47 + analyze limpo · trilha **14 OK · 7 PENDENTE · 0 FALHA** · ao
vivo: `/api/settlement-rules` 200 com a regra preservada, `/api/financial-contracts` **404**,
`/api/contracts` 200, e a sugestão da ordem 7953 (contrato dia 10) = **2026-10-10** contra a
genérica 2026-10-07.

⚠️ **Ordem de implantação**: seed 56 ANTES de publicar o app — o menu casa pela `i18n_key`, então
entre o seed e o deploy o item fica sem tradução (mesma classe da Q6 do módulo de menus).

### D13 — Q-P8 DECIDIDA e EXECUTADA (Valdo: "cada ordem vencer no dia do seu contrato")

O vencimento deixou de ser condição ÚNICA do lote. `dtExpiration` virou **opcional** em
`POST /service-orders/batch-invoice`:

| Situação | O que acontece |
|---|---|
| Sem `dtExpiration` (modo normal da mensalidade) | Cada ordem vence no `payment_day` do SEU contrato, no mês seguinte à **última** competência injetada nela |
| Com `dtExpiration` | OVERRIDE explícito do operador — vale para o lote inteiro (nem consulta contrato) |
| Ordem sem contrato (OS avulsa) ou com contratos que DIVERGEM no dia | **Recusada** com `ORDER_NO_CONTRACT_DUE_DAY` e motivo legível — o lote **nunca inventa data** |

Duas escolhas que precisam ficar registradas porque não eram óbvias:
- **A competência mais RECENTE manda**: OS que não foi faturada em setembro recebe também os itens de
  outubro — está se cobrando tudo que acumulou, então a referência é o mês mais novo, não o primeiro.
- **Divergência não é empate a desempatar**: dois contratos do mesmo cliente com dias diferentes na
  mesma ordem não têm "o dia do contrato". Escolher o menor ou o maior seria decidir pelo usuário sem
  ele saber — por isso a ordem é recusada com motivo, não faturada com um palpite.

Peça `contractDueReference` (dia + competência, com a regra da divergência), código novo no catálogo
de erros, `dtExpiration` em cada linha do relatório (agora as datas divergem, e o operador precisa
ver qual ordem ficou com qual). Na tela: switch **"Vencimento pelo contrato de cada ordem"** ligado
por padrão no lote, com o campo de data aparecendo só quando ele é desligado; o relatório passou a
listar as faturadas com ordem · vencimento · nota.

**Provas ao vivo**: dois clientes com contratos de dia **8** e **22**, mesmo lote, **sem data** →
títulos gravados com `2026-10-08` e `2026-10-22` (conferido em `tb_financial`); OS avulsa no mesmo
lote → `ORDER_NO_CONTRACT_DUE_DAY`, e faturada normalmente quando o operador informa a data.
Trilha: **15 OK · 7 PENDENTE · 0 FALHA** (P6c novo prova o vencimento pelo contrato).
839/839 jest · 50/50 + analyze limpo no app.

---

## 8. Rodada 3 — o processo de cobrança segundo o Valdo (2026-09-13)

O Valdo descreveu o fluxo real e apontou uma confusão minha. Os 9 passos dele:
ordem a partir do contrato → faturar (nota não autorizada) → financeiro → **do financeiro** saem os
boletos → transmitir ao Inter → Inter gera o boleto oficial e envia ao cliente → vincular o
registro do Inter ao sistema → webhook atualiza o status → pago, baixa conforme o retorno.

### A confusão que eu estava carregando

Eu tratava o boleto como se nascesse **no faturamento** (chave `auto_bank_slip`, 1 boleto por
parcela). No processo dele quem decide é o **financeiro**: os títulos nascem e depois se escolhe
como cada dívida será cobrada, podendo juntar parcelas ou faturamentos num boleto só.

O agrupamento manual **já existe** e eu não tinha destacado: `POST /api/bank-slips` aceita N
títulos do MESMO cliente, de ordens diferentes, com o lookup `GET /bank-slips/open-titles`.

**Achado que muda a implantação**: os dois caminhos são EXCLUDENTES por construção — título com
boleto vigente recusa outro (`TITLE_HAS_OPEN_SLIP`). Logo **`auto_bank_slip` = 'S' impede o
agrupamento manual**: cada título já sai com boleto próprio. Para a Setes a chave fica
**DESLIGADA**, e o P0.5 da trilha estava me empurrando para o lado errado (era eu quem tinha
ligado no dev, para provar o A1).

### D14 — a forma de pagamento é do CONTRATO · EXECUTADA

Fecha o par com a D13: o contrato diz **quando** (dia) e **como** (forma) o cliente paga, e a Q8 do
lote morre junto.

Migration **053** (`tb_contract.tb_payment_types_id`, NULL = informar no faturamento — a PRESENÇA
decide, nunca uma coluna "usa_contrato"); sem FK, porque a forma é central e quem valida
"habilitada" é a peça `assertPaymentRules`, que já roda nas três portas.

No lote, `paymentTypeId` virou **opcional**, com o mesmo desenho da data:

| Situação | O que acontece |
|---|---|
| Sem forma no corpo | Cada ordem usa a forma combinada no SEU contrato |
| Com forma | Override do operador para o lote inteiro (com data E forma, nem consulta contrato) |
| Contrato sem forma combinada, ou contratos que divergem | **Recusada** com `ORDER_NO_CONTRACT_PAYMENT_TYPE` — o lote não escolhe forma |

A peça virou `contractBillingReference` (dia + forma + competência) e resolve os dois campos
**independentes**: dois contratos do mesmo cliente podem combinar no dia e divergir na forma; cada
um que diverge vira null sozinho.

Na tela: campo "Forma de Pagamento Combinada" no contrato (vazio = informar no faturamento) e, no
lote, o switch passou a ser **"Usar as condições do contrato de cada ordem"** — com ele ligado, nem
data nem forma são pedidas.

**Prova ao vivo**: cliente 260 com contrato dia 12/boleto e cliente 259 com dia 27/dinheiro,
faturados no MESMO lote sem informar nada → títulos `2026-10-12` forma 6 e `2026-10-27` forma 1.
853/853 jest · 51/51 app · analyze limpo.

### A régua foi corrigida junto

A trilha estava medindo o processo ERRADO: cobrava `auto_bank_slip` ligada e esperava o boleto
nascer do faturamento. Agora:
- **P0.5 inverteu**: a chave tem que estar **DESLIGADA** (com ela ligada o agrupamento manual é
  impossível — título com boleto vigente recusa outro);
- **P6c** confere dia **e** forma vindos do contrato;
- **P7 emite o boleto DO FINANCEIRO** (`POST /bank-slips`), que é o processo real, e **P7a** prova
  a D15 (o título fica destinado ao boleto).

Estado: **16 OK · 7 PENDENTE · 0 FALHA**.

### D15 — emitir boleto DESTINA o título (regra BOL-02 do legado) · EXECUTADA

Não era cosmético: a baixa grava **no pagamento** a forma que está no título
(`settlement-batch.ts:229`), e é por ela que saem extrato e comissão. Sem destinar, título faturado
em "dinheiro" e pago por boleto registrava o recebimento como **dinheiro**.

Agora `issueBankSlip` grava a forma de boleto no título. Resolução: forma explícita > única forma
`kind='B'` habilitada; com 2+ formas a peça **recusa e pede** qual (`BANK_SLIP_PAYMENT_TYPE_AMBIGUOUS`),
porque adivinhar seria escolher pelo usuário. Título que já nasceu em boleto não é tocado — o
faturamento já escolheu. Três códigos novos no catálogo; 844/844.
**Prova ao vivo**: título 7933/1 em forma 1 (DINHEIRO) → emitido o boleto 255 → forma 6 (BOLETO).

Falta a segunda metade da D15: **mudar a forma de cobrança no financeiro**, independente de boleto.
É ATO novo e não tem casa hoje (não existe módulo de títulos; `tb_financial` só é tocada pelo
soft-delete do cancelamento) — precisa do guardião antes, não de improviso.

### D16 — as DUAS referências do boleto convivem

Nosso número interno (cunhado pela faixa da carteira) **e** o registro do Inter. Um não substitui o
outro: o nosso amarra o boleto ao título e sobrevive a qualquer troca de banco; o do Inter é a
identidade dele para consulta, webhook e baixa.

### Análise da API do Inter (Cobrança v3) — para planejar a Onda 2

| Item | O que a API faz |
|---|---|
| Ambientes | sandbox `cdpj-sandbox.partners.uatinter.co/cobranca/v3/` · produção `cdpj.partners.bancointer.com.br/cobranca/v3/` |
| Autenticação | OAuth2 `client_credentials` em `/oauth/v2/token` **+ certificado mTLS**; conta no header `X_INTER_CONTA_CORRENTE` |
| Emissão | **assíncrona** (`emitirCobrancaAsync`): a resposta devolve **só o `codigoSolicitacao`** |
| Identificador nosso | `seuNumero` vai no payload — é aqui que o nosso número entra |
| Dados do boleto | `nossoNumero`, `linhaDigitavel`, `codigoBarras`, `pixCopiaECola` vêm na **consulta** posterior, não na emissão |
| Situações | `EM_PROCESSAMENTO`, `A_RECEBER`, `RECEBIDO`, `MARCADO_RECEBIDO`, `ATRASADO`, `CANCELADO`, `EXPIRADO`, **`FALHA_EMISSAO`** |
| Webhook | criar / consultar / excluir + histórico de callbacks; payload traz `codigoSolicitacao`, `seuNumero`, `situacao`, `dataHoraSituacao` |
| Outras | consulta detalhada, PDF do boleto, cancelamento/baixa com motivo |

**O que isso impõe ao modelo** (a decidir na Onda 2):
1. **A emissão não é instantânea nem garantida.** `FALHA_EMISSAO` existe. O boleto passa a ter um
   estado que hoje não temos: *enviado ao banco, ainda sem registro*. Nosso `tb_bank_slip` já é
   append-only com eventos E/L/C/X — o registro bancário é fato novo (evento próprio? peça própria?).
2. **Duas chaves, dois donos** (D16): `seuNumero` = nosso número; `codigoSolicitacao` = identidade do
   Inter, e é por ela que o webhook chega. Precisa de índice, porque toda notificação entra por ela.
3. **Credencial é da CONTA** (parecer do guardião): `tb_bank_integration` pendurada em
   `tb_bank_account`, não na carteira nem na forma — senão o objeto vira gaveta.
4. **O webhook exige URL pública** → a Onda 2 depende da Onda 4, ou de publicar só esse endpoint antes.
5. **A baixa já existe** (`settleBankSlip` credita na conta da carteira): o que falta é o gatilho vir
   do banco em vez do operador. `RECEBIDO` → liquida; `ATRASADO`/`CANCELADO`/`EXPIRADO` → estado.

### D17 — a RENEGOCIAÇÃO é ato do financeiro (Valdo 2026-09-13)

> *"é normal que um financeiro tenha uma renegociação, então o que seria dinheiro pode ser alterado
> para pagamento em boleto... a casa da alteração é no financeiro... faturamento permanece igual."*

Fecha a segunda metade da decisão 1 da rodada 3 e resolve onde o ato mora: **no financeiro**, sobre
o TÍTULO já existente. O faturamento **não muda** — ele continua gravando a condição que valia no
momento da nota; renegociar é um fato POSTERIOR, do título, não uma reabertura do faturamento.

Consequências que já dá para fixar antes de implementar:
- a emissão do boleto (D15) é um caso PARTICULAR dessa alteração — destina o título porque decidiu
  como a dívida será cobrada. A alteração manual é o caso GERAL;
- a casa é a tela do financeiro (hoje `settlements` — "Baixa de Títulos"), não o módulo de pedidos
  nem o de OS;
- guardas que a peça vai precisar: título aberto (sem quitação), sem boleto vigente (senão a
  cobrança em curso e a forma se contradizem), e forma habilitada na institution;
### D18 — a renegociação é UPDATE simples no título (Valdo 2026-09-13)

> *"use o update simples no financeiro, pois a ordem billing, installment tem o registro de como foi
> negociado inicialmente"*

**Não** é evento append-only, e o argumento é estrutural: a negociação ORIGINAL já é imutável em
outro lugar — `tb_order_billing` (forma + prazo, gravada no ato do faturamento, inclusive no caminho
da OS) e `tb_order_installment` (parcelas combinadas do pedido de venda). O título carrega o estado
**vigente** da dívida; o histórico do que foi combinado vive no pedido.

Isso mantém a coerência da casa sem inventar tabela: dinheiro MOVIMENTADO continua append-only
(`tb_financial_payment`/`_statement`, que nunca se apagam), e a CONDIÇÃO de cobrança é estado, não
movimento.

**Limite conhecido, aceito**: com UPDATE simples, renegociações sucessivas não deixam rastro
intermediário — o título mostra a forma atual e `updated_at`, e o ponto de partida é o
`tb_order_billing`. Se um dia for preciso auditar "quantas vezes esta dívida foi renegociada", aí
sim vira fato; hoje não há caso que peça isso.

*(a implementar — rodada própria; a casa é a tela do financeiro)*

---

## 9. Rodada 4 — redirecionar a cobrança do título (2026-09-13)

### Gate socrático do acumulado (rename + D13/D14/D15) — **0.68 REPROVOU**

- **HIGH-1** — a forma combinada no contrato não tem porta de validação: DTO só exige inteiro
  positivo, a validação real (`assertPaymentRules`) só roda no faturamento, e o lookup da tela chama
  `/api/payment-types` **sem filtrar `enable='S'`**. O erro nasce num cadastro calmo e explode no dia
  da cobrança, dentro do lote, depois de N ordens faturadas. *(corrigir)*
- **HIGH-2** — TOCTOU: `contractBillingReference` é lido FORA da transação de `generateInvoice`.
  Regressão do padrão que a negociação do pedido já tinha fixado ("resolver DENTRO da transação,
  após o FOR UPDATE"); janela real é a rotina mensal injetando competência nova. *(corrigir)*
- **HIGH-3** — a D15 gravou "destinado a boleto" e nenhum caminho desfaz (C, X, estorno,
  `FALHA_EMISSAO` do Inter): baixa posterior em dinheiro sai classificada como boleto. → **D20**.
- **MEDIUM** — o doc-comment da `issueBankSlip` ainda afirma "NÃO toca tb_financial", contradizendo
  o código logo abaixo (a mesma "metade barata" que gerou a rodada do rename). *(corrigir)*
- **LOW** — dois comentários com o caminho antigo do app; `GET /expiration-suggestion` sem
  `requirePrivilege`; vencimento no passado silencioso no lote.
- **O rename passou limpo**: zero resíduo em app e sync, seed 56 idempotente cobrindo as três chaves,
  schema novo nascendo certo pela cadeia 001..053.

### Parecer do guardião — o ato tem peça própria

**Conceito**: *redirecionar a cobrança de um título* — apontar, no título vivo, COMO aquela dívida
será cobrada daqui para frente. Fato gerador: a repactuação, POSTERIOR ao faturamento.

`tb_financial` já É a condição vigente de cobrança da parcela (quanto/quando/como) — a D18 não é
atalho, é a leitura correta da peça que já existe. **Zero DDL.**

**A D15 é o caso PARTICULAR do mesmo ato**, e a prova do recorte é que ela satisfaz todas as guardas
do geral **sem bypass**: `issueBankSlip` já provou, sob FOR UPDATE, título vivo, saldo > 0, nenhum
boleto vigente e forma habilitada de boleto. O UPDATE inline vira chamada à peça; o que FICA no
boleto é a regra de QUAL forma (política do instrumento).

Duas guardas que eu ia escrever e **não** existem:
- *"só título a receber"* — é regra do BOLETO, não do título: pagar o fornecedor por outro meio é o
  mesmo conceito. A carteira do financeiro já lista os dois sentidos;
- *"não mexer em título de nota cancelada"* — morre por construção (o cancelamento soft-deleta).

E a que mais importa: **a baixa copia a forma do título para o PAGAMENTO no ato**, então dinheiro
passado carrega a forma congelada e mudar o título nunca reescreve história — é exatamente por isso
que o UPDATE simples da D18 não é maquete.

### Decisões da rodada (Valdo)

- **D19** — a peça escreve a condição INTEIRA (forma + vencimento opcional); a TELA desta onda expõe
  só a forma. Evita reformar peça e rota depois, e fecha uma divergência que já existe hoje: boleto
  agrupado com vencimento novo deixa boleto e título com datas diferentes.
- **D20** (Q-S1 / HIGH-3) — boleto cancelado, estornado ou com falha de emissão **deixa o título em
  boleto**; quem corrige é o operador, pela renegociação. Limite conhecido e aceito: com o Inter esse
  estado deixa de ser exceção — a tela do financeiro é a saída.
- **D21** — autoridade: `requirePrivilege('settlements', ALTERAR)` (privilégio 2 existente, sem
  privilégio novo no catálogo).
- **D22** — nomes: peça `@shared/title-charge` (`retargetTitleCharge`), rota
  `PUT /api/settlements/bills/:orderId/:parcel/charge`. Nomear pelo CONCEITO (condição de cobrança),
  não pelo campo — o vencimento entra sem trocar a rota. **Item de verificação da entrega**: linha na
  tabela de palavras ocupadas da skill separando `bank_charge` (acordo com o banco) de
  `title charge` (condição do título) — é a lição da rodada "contrato".

### Gate adversarial do acumulado — **0.58 REPROVOU** → corrigido em sessão

- **A-H1 (HIGH)** — a D15 validava `paymentTypeId` no DTO e o **service DESCARTAVA** ao montar o
  input da peça: forma explícita ignorada em silêncio e, com 2+ formas `kind='B'`, a API virava
  **beco sem saída** (pedia "informe qual" e informar dava o mesmo 422). **Os testes passavam porque
  chamavam a PEÇA direto, nunca o service** — o verde mentia exatamente na camada onde o contrato
  estava quebrado. Corrigido + teste novo `bank-slips-service-issue.test.ts`, na camada certa.
- **A-H2 (HIGH)** — `COUNT(DISTINCT tb_payment_types_id)` IGNORA NULL: contrato com forma combinada
  convivendo com outro "informar no faturamento" fazia o lote adotar a forma do irmão e faturar —
  com baixa automática e **débito de taxa de 2,5% numa forma que o operador nunca escolheu**.
  Corrigido: `COUNT(*)` × `COUNT(coluna)` — só há forma combinada quando TODOS combinaram a mesma.
- **A-H3 (HIGH)** — cancelar o boleto não desfaz a destinação → **D20** (decisão do Valdo: fica em
  boleto; a saída é a renegociação, que esta rodada entrega).
- **MEDIUM** — forma do contrato sem validação na porta (= HIGH-1 do socrático, corrigido);
  **rename incompleto onde mais importa**: o módulo renomeado ainda dizia "Contrato financeiro
  {id} não encontrado" e "já tem contrato financeiro" nos 404/409, e nos summaries do Swagger
  publicado (corrigido — 24 arquivos da API e 11 do app); Swagger desatualizado (corrigido).
- **LOW** — ordem inexistente no lote mandava "acerte o contrato do cliente" (corrigido: existência
  conferida antes, `ORDER_NOT_FOUND` nos dois caminhos); doc-comment mentiroso da `issueBankSlip`
  (corrigido, com o registro de que ele mentiu).
- **Resistiu ao ataque**: forma desabilitada/soft-deletada no contrato → recusa; concorrência da D15
  (2 emissões, emissão ‖ baixa, emissão ‖ cancelamento de nota) limpa; rollback da destinação quando
  a emissão falha depois dela; seed 56 aplicado 2× é no-op perfeito; schema novo 001..053 sem erro.

### Renegociação ENTREGUE (D17–D22)

**Peça `@shared/title-charge`** (`retargetTitleCharge`) — *redirecionar a cobrança de um título*.
Zero DDL. Guardas por REÚSO: título vivo e travado (`FOR UPDATE`), saldo pela peça única
`title-balance`, forma habilitada por `assertPaymentTypesEnabled`. A peça **não conhece boleto** —
"sem cobrança vigente" é regra do instrumento, exportada como `findOpenSlip` e composta pelo MÓDULO,
para o geral não importar o particular.

**A D15 virou chamadora da peça**: o `UPDATE` inline saiu do boleto; lá ficou só a política de QUAL
forma. O teste velho, que espiava o SQL inline, foi reescrito para provar a **delegação** — e ganhou
o caso que o gate pediu: com 2+ formas, informar a forma **resolve** o impasse.

**Rota** `PUT /api/settlements/bills/:orderId/:parcel/charge` com `requirePrivilege('settlements',
ALTERAR)` (D21). Sub-recurso `charge` (a CONDIÇÃO), não `payment-type` (o campo) — o vencimento
entra sem trocar a rota (D22).

**Tela**: ação na linha do título na carteira do financeiro, gated por `can('ALTERAR')`.

**Provas ao vivo** (título 7983/1): dinheiro → boleto; com boleto vigente recusa com motivo legível
("cancele o boleto antes"); cancelado o boleto o título **fica** em boleto (D20) e a renegociação o
traz de volta a dinheiro; forma inexistente → 400 PAYMENT_TYPE_UNAVAILABLE.
**872/872 jest · 55/55 app · analyze limpo.**

### Questão aberta para a próxima rodada

- **Q-R1** (MEDIUM do adversarial) — as condições do lote são resolvidas pelos contratos VIVOS no
  momento do faturamento, não pelas competências já injetadas: excluir ou editar um contrato muda a
  cobrança de item que ele já gerou. Atrito com o princípio da D-A36 ("nada é reescrito no
  passado"). Amarrar a condição ao item injetado (na `tb_contract_item_competence`) resolveria — é
  decisão sua.

---

## 10. Checkpoint — COMMITADO em 2026-09-13

`main` nos quatro repositórios (sem push — o Valdo pediu só o commit):

| Repo | Commit |
|---|---|
| sql | `b2e0b34` |
| setes-api | `fcf96dd` |
| setes-app | `5512f4e` |
| Infra-IA | `3d94013` |

Provas do checkpoint: **872/872** jest · **55/55** + analyze limpo (app) · trilha
**16 OK · 7 PENDENTE · 0 FALHA**.

**Aguardam o Valdo**: os 3 valores do P0 (limite de parcelas, teto do desconto, quais usuários
recebem FATURAR/CANCELAR), **Q-R1** (condições do lote vindas do contrato VIVO × da competência
injetada), Q-P2/Q-P3/Q-P5/Q-P6 (contrato do lote) e a ordem das próximas ondas — Inter (2), NFS-e
(3) ou produção (4), lembrando que o webhook do Inter exige URL pública.

---

## 11. Rodada 5 — as questões acumuladas das Ondas 0/1 e da renegociação (2026-09-19)

Retomada da sessão de 2026-09-13. Apresentei as 7 questões abertas com alternativas e recomendação;
o Valdo respondeu **"siga as recomendações, P0 e ondas eu respondo depois"**. Ficam para ele: os 3
valores do P0 (`max_parcels` por forma, teto do desconto ou privilégio DESCONTO, quem recebe
FATURAR/CANCELAR) e a ORDEM das ondas (recomendei 4 → 2 → 3, porque o webhook do Inter exige URL
pública; se for 4, preciso também da Q5 — titular do domínio/DNS — e da Q6 — virada big-bang ×
paralelo).

### Decisões (Valdo, pelas recomendações)

- **D23 (Q-R1)** — as condições de cobrança são **congeladas no fato da competência**: a rotina
  mensal grava `payment_day` e `tb_payment_types_id` em `tb_contract_item_competence` no ato da
  injeção; o lote lê dali. Editar ou excluir o contrato só governa meses FUTUROS (mesmo princípio da
  D-A36 e do desconto como fato do ato). A OS cancelada devolve a competência e a reinjeção é ato
  NOVO — grava as condições de então. Alternativa rejeitada: manter o contrato vivo mandando.
- **D24 (Q-P2)** — **MANTER** 200 com `ok: true` mesmo com `invoiced: 0`: `ok` no envelope significa
  "a operação pedida executou", e a operação é "tentar N faturamentos e relatar". Derivar `ok` de
  `failed === 0` ou responder 207/422 faria a ponte do app tratar o relatório como erro e descartá-lo.
  Conhecimento negativo: comentário no controller + teste que fixa a semântica.
- **D25 (Q-P3)** — ordem recusada por **contenção** ganha **UMA passada extra ao final do lote**
  (quem a segurava normalmente já soltou); se continuar ocupada, volta marcada `retryable: true` e o
  relatório traz `retryable`. Repetir é decisão do operador (a tela mantém a ordem marcada). Sem
  estado novo, sem fila; só contenção é repetida — recusa de negócio não.
- **D26 (Q-P5)** — cobrança **por parcela**: cada linha faturada traz `chargedParcels`
  (baixadas + com boleto — desfechos disjuntos por `kind`) e `chargeableParcels` (parcelas com valor
  > 0, denominador que vem da composição `title-automation`). `uncharged` passa a contar QUALQUER
  parcela sem cobrança (a parcial inclusive) e `partiallyCharged` é o subconjunto 0 < cobradas <
  cobráveis. Tela mostra "cobradas x/n" na linha parcial.
- **D27 (Q-P6 / A-8)** — **teto 50 ordens por requisição** (era 200). Sob contenção cada linha custa
  até ~11 s (`FOR UPDATE WAIT 10`); 200 numa requisição passava de meia hora e, se o cliente
  desistisse, o relatório — única prova do que foi cobrado — se perdia. O app **fatia a seleção em
  blocos de 50, em sequência, e agrega os relatórios** (contadores recontados das linhas — fonte
  única). Bloco que falha inteiro DEPOIS de outro já ter faturado não vira Failure (o relatório do que
  foi cobrado se perderia): suas ordens e as dos blocos seguintes entram como recusadas "tente de
  novo" (`BATCH_ABORTED`, código local da tela) com o motivo; só o 1º bloco falhando sobe como
  Failure (403/400 como sempre). Lote assíncrono fica como candidata da Onda 4, se ela provar
  necessidade.
- **D28 (Q-P7)** — **MANTER**: mensalidade que nasceu baixada pela regra de recebimento bloqueia o
  cancelamento da nota IGUAL à baixa manual (409 legível "estorne a baixa antes"). Não é cascata como
  o cheque em custódia: o cheque é PORTADOR da dívida; a baixa por regra é dinheiro que ENTROU
  conforme o combinado, e desfazê-la é ato do financeiro com rastro próprio. Conhecimento negativo:
  comentário no plano de cancelamento + teste.
- **D29 (Q-P1 / Q9)** — **MANTER** `auto_bank_slip` na interface `billing`: é política da EMPRESA sobre
  o nascimento do título, e `resolveTitleAutomationConfig` é a fonte ÚNICA de qual chave governa —
  mover um dia é trocar uma linha. Limite conhecido registrado no código: cliente que contratar OS
  SEM a interface `billing` resolve pelo default do catálogo ('N'). Reabrir só se esse cliente existir.

### Parecer do guardião (D23 — alterar objeto de domínio)

**Conceito**: o fato "a rotina faturou o item X do contrato C na competência Y" passa a carregar as
condições que o contrato tinha NAQUELE ato. Não é peça nova nem coluna "para o caso X": é o mesmo
fato ganhando os atributos do seu próprio momento — exatamente como a baixa grava a forma do título no
pagamento (D18) e o boleto congela as taxas da carteira. **Peça** (não composição), sem FK para
`tb_payment_types` (vive em setes_central — mesma razão da 053). NULL na forma mantém a semântica da
053 ("informar no faturamento"). Regra que MORREU por construção: o JOIN com `tb_contract` na leitura
do lote (o fato basta; contrato excluído continua contando na regra "todos combinam a mesma forma",
porque o item dele continua na OS). Nome mantido: `tb_contract_item_competence` (o conceito não mudou).

### Execução (2026-09-19)

**API** — migration **054** (`ADD COLUMN IF NOT EXISTS payment_day, tb_payment_types_id` + backfill
pelo contrato de hoje, idempotente por `payment_day IS NULL`; aplicada no dev: 75 competências, 0 sem
dia, 50 sem forma — legítimo) e DDL canônico `sql/03`; `monthlyRun` grava as condições no INSERT e no
revive (`ON DUPLICATE KEY UPDATE`); `contractBillingReference` lê de `comp.*` sem JOIN;
`invoiceOrderBatch` reescrito em `invoiceOneInBatch` + passada extra para `RESOURCE_BUSY` (D25) +
`chargedParcels/chargeableParcels/partiallyCharged/retryable` (D26); `TitleAutomationResult.chargeable`
(parcelas com valor) propagado para `InvoiceResult.chargeableParcels` da OS e do billing (simetria);
DTO `BATCH_INVOICE_MAX_ORDERS = 50` (D27); comentários D24 (controller), D28 (`invoice-cancel.ts`
bloco 2c), D29 (`resolveTitleAutomationConfig`); Swagger do lote atualizado. Testes: suíte nova
`service-orders-batch-rodada5.test.ts` (D24/D25/D26/D27), D23 em `contract-payment-day` (SQL lê do
fato, sem JOIN) e `contracts-service-product` (INSERT leva dia e forma), D28 em `invoice-cancel`.
**888/888** jest.

**App** — `BatchInvoiceEntry` (+`chargedParcels`, `chargeableParcels`, `retryable`, getters
`uncharged`/`partiallyCharged`, construtor `aborted`), `BatchInvoiceReport` (+`partiallyCharged`,
`retryable`, `fromEntries`, `merge`), constante `batchInvoiceChunkSize = 50`; bloc fatia em sequência e
agrega (1º bloco falhando → Failure; depois → linhas `BATCH_ABORTED`); tela sem teto local, relatório
com "cobradas x/n", "tente de novo", contagens de parcial e de repetíveis; i18n pt/en (5 chaves novas,
`batchTooMany` removida). Testes novos: entidade (D25/D26/D27) e **bloc** (fatiamento 50/50/20, ids
repetidos, bloco que falha depois de outro faturado, 1º bloco falhando) — mocktail sobre o repositório.
**66/66** flutter test · analyze limpo.

**Trilha** — P6c passa a conferir o vencimento e a forma contra o FATO da competência (D23) e nasce
**P6d** (cobrança por parcela no relatório). Achado da própria régua: o cliente da trilha acumulava
17 contratos SEM forma (anteriores à D14) na mesma OS aberta e a regra "todos combinam a mesma forma"
recusava o lote — comportamento CERTO do produto, resíduo da própria trilha. A trilha agora **limpa o
próprio resíduo** antes de contratar (cancela a OS aberta do cliente pela API e desativa os contratos
antigos dele). Corrida: **17 OK · 7 PENDENTE · 0 FALHA** (nota 6774, boleto 262 do título 7984/1).

**Ambiente**: o serviço `mysql` do dev estava parado e exige administrador — o Valdo o subiu à mão
("mysql foi erguido"); a API de dev subiu pelo `preview_start` (launch.json `setes-api`).

### Gate socrático da Rodada 5 — **0.72 PASSOU** (2026-09-19), 1 HIGH e 3 MEDIUM corrigidos em sessão

- **H1 — duplo disparo do lote no app** *(corrigido)*: o lote leva minutos sob contenção, a AppBar
  continua viva e a seleção NÃO é limpa no loading (de propósito, para repetir só as recusadas) — um 2º
  clique disparava um lote IGUAL em paralelo (contenção auto-infligida, dois relatórios se
  sobrescrevendo). Agora: flag de reentrância no bloc (`_batchRunning`, mesmo padrão do cancelamento
  de nota) + botão desabilitado com a lista em loading. Teste no bloc: 2º disparo é ignorado, uma
  chamada só, um relatório só.
- **M1 — TOCTOU das condições do lote** *(corrigido)*: `contractBillingReference` lia pelo pool, fora
  da transação, de uma tabela que a rotina mensal escreve concorrentemente — entre a leitura e o lock
  da ordem podia entrar um fato com outra forma, e a nota saía com a condição envelhecida (regra 2
  do PADROES §9; padrão já fixado na negociação do pedido). Agora `InvoiceInput.termsFromContract`
  diz QUAIS condições vieram do fato e `generateInvoice` as **reconfere DENTRO da transação, após o
  lock da ordem, com `FOR UPDATE` nos fatos** (`contractBillingReferenceTx` + `resolveInvoiceTermsTx`);
  a leitura de fora fica para a recusa antecipada e o relatório; o resultado devolve o que foi
  GRAVADO (`InvoiceResult.dtExpiration/paymentTypeId`) e a linha do relatório usa isso. Faturamento
  avulso e override total não reconferem nada (sequência de queries inalterada). Suíte nova
  `service-orders-terms-tx.test.ts` (5 casos).
- **M2 — mensagens contradiziam a D23** *(corrigido)*: "acerte o contrato do cliente" não resolve o
  mês já injetado. Mensagens em módulo próprio `service-orders.messages.ts` (fonte única das duas
  portas), distinguindo **OS avulsa** (nenhum fato — "informe no lote ou fature pela ordem") de
  **fatos divergentes/sem forma** ("informe no lote; editar o contrato só vale para meses futuros —
  remova o item ou cancele a OS e rode a cobrança de novo"); catálogo `error-codes.ts` atualizado.
- **M4 — sair da tela no meio dos blocos** *(padrão aplicado; política é a Q-R5.2)*: o laço checa
  `isClosed` antes de cada bloco e antes do emit final.
- **M3** (passada extra dobra o pior caso) → **Q-R5.1**. **L1** `BATCH_ABORTED` é código local da
  tela, fora do catálogo — documentado. **L3** D26 não quebra consumidor (verificado: só a venda lê
  `autoSettled`, ninguém deriva "não cobrada" do par zero). **L4/L5/L6** coerentes.

### Gate adversarial da Rodada 5 — **0.78 PASSOU** (2026-09-19), 0 HIGH/CRITICAL, 2 MEDIUM

Provado ao vivo no dev: D23 (contrato editado 12/1 → 20/2 depois da injeção: título saiu 12/1;
cancelar a OS devolveu a competência com o fato preservado e a reinjeção gravou as condições NOVAS;
contrato **excluído** → o fato ainda vale e a OS fatura; backfill 054 em replay = 0 linhas); D25
(trava segurada o tempo todo → `RESOURCE_BUSY` + `retryable: true`, **resíduo zero** — sem nota,
sem título, `number_seq` intacto; trava solta aos 12 s → passada extra faturou UMA vez); D26 (boleto
3 parcelas com `auto_bank_slip=N` → 0/3; rateio 0,01 em 3 → 0/1; forma com regra → 1/1; linha
recusada sem `chargedParcels`); D27 (51 → 400 no campo; 50× o mesmo id → `requested 1`; bordas
0/−1/string/float/JSON quebrado → 400; id de outra institution → sem vazar); D28 (cancelar nota
baixada automaticamente → 409 legível); **2 lotes paralelos com as MESMAS 5 ordens → 2 + 3 = 5
notas sequenciais, zero 500**; autorização 401/403.

- **A1 (MEDIUM) — fatos congelados DIVERGENTES na mesma OS** *(mensagem corrigida em sessão; a regra
  é a Q-R5.4)*: contrato editado entre dois meses NÃO faturados deixa fatos 5/1 (jul) × 6/2 (ago) na
  MESMA OS; o agregado colapsa em null e o lote recusa. Antes da D23 esse cenário faturava (as duas
  competências liam o contrato vivo). Teste do gate (`adversarial-rodada5.test.ts`) virou permanente
  e passa com as mensagens novas.
- **A2 (MEDIUM) — D25 dobra o pior caso da D27** *(→ Q-R5.1; premissa do DTO corrigida)*: com a linha
  da institution travada UMA ordem custou **22,4 s** (2 × `WAIT 10`), não os ~11 s do comentário;
  bloco de 50 atrás do MESMO lock ≈ 18 min síncronos, e a passada extra insiste em todas.
- LOW *(corrigidos)*: Swagger declarava `paymentTypeId` obrigatório no lote (D14 o torna opcional);
  a linha do relatório no app ignorava `paymentTypeId` (agora carrega a forma usada).
- LOW *(pré-existentes, fora do alvo → questões)*: `POST /service-orders/monthly-run` e
  `DELETE /service-orders/:id` sem privilégio de AÇÃO (Q-R5.5); JWT de usuário soft-deletado
  autentica — só o privilégio o barra (Q-R5.6); rateio 0,01 em 3 grava dois títulos de 0,00
  (informativo; a D26 os exclui do denominador).
- Não testado ao vivo: cobrança PARCIAL real (exigiria `auto_bank_slip='S'` + falha numa parcela),
  timeout real do LB da SaveInCloud, saturação do pool com 20 lotes, rotina mensal concorrente com o
  lote no MESMO cliente.

**Provas finais da rodada**: **897/897** jest (api) · **67/67** flutter test + analyze limpo (app) ·
trilha **17 OK · 7 PENDENTE · 0 FALHA** (rodada 3× no dia, inclusive com a reconferência M1 ao vivo).

### Questões da Rodada 5 (aguardam o Valdo)

- **Q-R5.1** (D25 × D27 × Onda 4) — orçamento de TEMPO do lote sob trava da institution: (a) pular a
  passada extra quando a 1ª já consumiu mais que N s; (b) abortar o resto do bloco no 1º
  `RESOURCE_BUSY` vindo do lock da institution (as seguintes vão falhar igual, 10 s cada),
  devolvendo-as `retryable` sem esperar; (c) manter e aceitar até ~18 min por bloco. Depende do
  timeout do LB da SaveInCloud — conhecer ANTES de fixar. **Rec.: (b)** — é a mesma contenção, e a
  prova do lote não pode depender de quem segura o lock.
- **Q-R5.2** (D27/app) — operador sai da tela (ou fecha a aba do navegador) no meio dos blocos: PARAR
  de enviar os blocos seguintes (hoje: para se o bloc fechar; o que já rodou fica na aba Faturadas)
  ou SEGUIR até o fim sem relatório? Barreira modal com progresso "bloco i de n" evita a pergunta na
  maioria dos casos. **Rec.: parar + barreira modal.**
- **Q-R5.3** (D23, visibilidade) — na recusa por fatos divergentes, mostrar QUAL competência/contrato
  divergiu (a OS mistura fatos de N contratos; contrato excluído nem aparece na lista)? **Rec.: sim**,
  em `fields[]` do relatório (uma linha por competência: mês, contrato, dia, forma) — zero DDL.
- **Q-R5.4** (D23, regra) — fatos congelados DIVERGENTES na mesma OS (contrato editado entre meses não
  faturados): (a) recusar, como hoje (o lote não escolhe pelo usuário; saída = override no lote ou
  cancelar a OS e reinjetar); (b) faturar pela competência mais RECENTE; (c) a rotina abrir OS
  separada quando as condições mudam. **Rec.: (a)** — é a consequência honesta da D23, e a Q-R5.3
  tira o beco.
- **Q-R5.5** (pré-existente) — `monthly-run` e `DELETE /service-orders/:id` sem privilégio de ação:
  criar privilégios (ex.: COBRANCA para a rotina; CANCELAR já existe, id 7) ou aceitar que qualquer
  usuário com a interface abre a cobrança do mês? **Rec.: rotina sob FATURAR (id 5) e DELETE da OS
  sob CANCELAR (id 7) — sem privilégio novo.**
- **Q-R5.6** (pré-existente, transversal) — JWT de usuário soft-deletado continua válido até expirar;
  barrar no gateway (consulta por request, ou cache curto) ou aceitar a janela do token?
  **Rec.: barrar com cache TTL curto**, tarefa transversal fora desta fase.

### D30 — resposta ao P0.1 (Valdo 2026-09-19): cobrança recorrente não tem parcelas

> "Onda 0, valores a cobrar mensalmente: o que estiver no contrato; como são cobranças recorrentes
> não tem parcelas, o parcelamento pode ser resolvido no faturamento individual."

- **Valor** = o que está no contrato (já era: a rotina injeta o item do contrato com pró-rata no mês
  de entrada/saída; nada mudou).
- **Lote = 1 parcela, sempre.** `batchInvoiceDto.parcels` aceita só 1 (omitido vale 1; 2+ → 400 no
  campo, com a mensagem apontando a porta certa — nunca silenciado); cinto no service. O dialog do
  lote no app **não mostra** mais o campo de parcelas. O faturamento INDIVIDUAL da ordem
  (`POST /:id/invoice`) continua parcelando, sob o `max_parcels` da forma.
- **P0.1 deixa de ser pendência**: limite 1 nas formas basta para a Setes; subir `max_parcels` é
  configuração de quem precisar parcelar, não pré-requisito da fase. A trilha reporta OK.
- Efeito colateral consciente sobre a D26: no lote a cobrança por parcela só pode ser 0/1 ou 1/1 (a
  "parcial" só volta a existir no resultado do faturamento individual, que carrega os mesmos campos).

### D31 / D32 — respostas ao P0.4 e ao P0.2 (Valdo 2026-09-19)

> "1 — sobre desconto: usar o max_discount_aliquot para quem não tem privilégio e, para quem tem
> privilégio, o desconto é liberado total. 2 — faturar e cancelar são privilégios (lembrando que
> esses privilégios atingem somente usuário não admin, pois o admin pode tudo)."

- **D31 (P0.4)** — confirma a D-G32 do cancelamento para a Setes: `max_discount_aliquot` é o teto de
  quem NÃO tem o privilégio DESCONTO (id 8); quem tem, desconto liberado (até saldo − 0,01, D-G35).
  Já é assim no código (porta manual da baixa e carteira do boleto, D-G36). **Valor da Setes**: não
  foi dito um percentual — o default 0 ("sem privilégio, nenhum desconto") é política válida e é o que
  vale até o Valdo informar outro número; a trilha só exige a chave no catálogo (seed 55) e reporta
  o valor em vigor.
- **D32 (P0.2)** — confirma a D-G5: FATURAR (5) e CANCELAR (7) são privilégios de AÇÃO atribuídos por
  usuário na tela de Usuários, e atingem SÓ usuário não admin — admin e super passam sempre
  (`requirePrivilege` na API; no app o gate `CurrentInterface.can` segue o contexto que a API devolve).
  Pré-requisito da fase é o CATÁLOGO (seeds 51–54), não a quantidade de vínculos: a trilha passa a
  conferir o catálogo e só informa quantos usuários regulares têm o privilégio.

Com D30–D32 o **P0 está fechado** para a Setes (valores: 1 parcela na recorrência; teto 0 sem
privilégio; privilégios por usuário). Trilha: **20 OK · 4 PENDENTE · 0 FALHA** — os 4 pendentes são
as ondas 2/3/4 (P7b Inter, P8a/P8b NFS-e, P9 produção).

### D33 — ordem das ondas (Valdo 2026-09-19): **Inter → NFS-e → Produção**

> "inter / NFSe / Producao"

Diverge da recomendação (4 → 2 → 3). Consequência aceita: o **webhook** do Inter não tem URL pública
até a Onda 4 — a Onda 2 entrega o conector inteiro (registro, consulta, PDF/QR, cancelamento) e o
ENDPOINT do webhook pronto e testado, mas o cadastro do webhook no Inter e a baixa automática por
notificação só ligam em produção; até lá, a **consulta ativa** (polling por `codigoSolicitacao`) faz o
papel do webhook. Isso fecha a Q4 ("publicar cedo × reordenar"): nenhum dos dois — polling como ponte.
Q5/Q6 ficam para a Onda 4. Plano da Onda 2: `prompts/prompt_onda2_banco_inter.md` (Rodada 0 + questões).

