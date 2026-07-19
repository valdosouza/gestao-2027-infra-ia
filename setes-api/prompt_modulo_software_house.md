# Documentação — Módulo Software House no Backbone `tb_order` (v4)
**Escopo**: setes

> **Uso:** prompt mestre para o Claude Desktop. Cole as seções 1–7 (contexto +
> regras + financeiro + decisões) + a fase em andamento em cada sessão.
> **Status v4:** camada financeira incorporada — fluxo fechado ponta a ponta
> (ordem → fatura → título → baixa → movimento → parceria).
>
> **Premissas:**
> - A Setes é cliente dela mesma; todo objeto deve ser genérico
>   (orientação a objeto, baixo acoplamento, múltiplos reusos).
> - **Mentalidade ERP:** nenhuma ponta solta. Etapas puladas por ora ficam
>   **registradas na seção Pendências** para execução futura (nada "some").

---

## 1. Contexto do Sistema (colar sempre)

Sistema de gestão multi-ramo. Toda operação passa pelo backbone `tb_order`:

- **`tb_order`** — pai; o `id` amarra tudo, da operação até o financeiro.
- **Ramos:** `tb_order_sale`, `tb_order_purchase`, `tb_order_stock_adjust`,
  `tb_order_stock_transfer`, `tb_order_bonus`, `tb_order_production`.
- **Complementares:** `tb_order_totalizer`, `tb_order_shipping`,
  `tb_order_billing`, `tb_order_cost`, `tb_order_item` (detalhe universal).

Padrões da base: multi-tenant por `tb_institution_id`, soft delete
(`deleted char(1) default 'N'`), `active char(1)`, auditoria
(`created_at`/`updated_at`), nomenclatura singular `tb_*`.
Bases: `setes_central` (compartilhado entre todos), `setes_setes` (base do
migration) → `setes_+schemas` (schema por cliente).

## 2. Conceito-chave: Faturamento ≠ Cobrança

Acontecem em tempos diferentes:

- **Faturar** = emitir a nota e gerar os títulos com vencimento futuro
  (`tb_financial` + `tb_financial_bills`). Ordem fechada = ordem faturada.
- **Cobrar/receber** = evento posterior: a **baixa** (`tb_financial_payment`)
  e o **movimento** (`tb_financial_statement`). Inadimplência é problema do
  financeiro, nunca da ordem.
- A **baixa do recebimento** é o gatilho da rotina de parcerias (gera títulos
  `kind = PA`).

## 3. Mapa de Módulos

| Módulo | Situação | Objeto principal |
|---|---|---|
| Cadastro de serviços prestados | **Pronto** (`tb_product`) | `tb_product` |
| Cadastro de colaborador | **Pronto** | — |
| Contratos | **Em desenvolvimento** | `tb_contract` + `tb_contract_item` |
| Parcerias | A modelar | `tb_partnership` → bills `PA` |
| Tarefas / atendimentos | A modelar | `tb_order_service` + itens |
| Ordem de serviço (ciclo mensal) | A modelar | `tb_order_service` |
| Faturamento + fiscal (NFS-e Nacional) | Parcial (`tb_invoice`, `tb_cfop`) | rotina + emissão |
| **Financeiro (títulos, baixa, movimento)** | **Modelo definido (v4)** | `tb_financial*` |
| Cadastros bancários | Modelo definido (v4) | `tb_bank*` |

## 4. Regras de Negócio do Ciclo de Serviços

### 4.1 Serviços prestados
`tb_product` (grupo Cadastros): Manutenção de Software, Manutenção +
Atendimentos, Desenvolvimento, Otimizações. Base do faturamento e da NFS-e.

### 4.2 Contratos
- Data inicial obrigatória; final opcional; **N produtos** (`tb_contract_item`);
  valor de mensalidade; **dia** de vencimento.
- Objeto genérico; extensões por acoplamento, não por alteração do núcleo.
- Histórico de valores praticados: `tb_invoice` + camada `tb_financial`
  (limite consciente: não guarda a trilha "quando/por que o contrato mudou").

### 4.3 Parcerias
- **Amarrada ao cliente**; soma dos percentuais ≤ **90%** (Setes 10% fixo).
- Baixa do recebimento → loop parceiros → gera **`tb_financial_bills` com
  `kind = 'PA'`** (colaborador × percentual × valor pago). Parcial coberto.
- Sem vigência própria: histórico está nos títulos/movimentos gerados.
- Estorno: **lançamento inverso + marcação** — regras na seção 5.5 (sem
  exclusão, nem soft).

### 4.4 Tarefas
Para clientes sem atendimento incluído ou que extrapolaram o tempo (controle
de tempo **manual até segunda ordem**). Registram **valor fechado**. São a
origem dos itens cobráveis da ordem aberta.

### 4.5 Ciclo mensal (tela manual, módulo Tarefas/rotinas)
1. Ordem aberta o mês inteiro acumulando itens (`tb_order_item`).
2. Abrir/faturar intra-mês é permitido; fechamento considera só **abertas**.
3. Unicidade: **máx. 1 ordem aberta por cliente** — aplicação + unique em
   coluna gerada (`IF(status='A', CONCAT(inst,'-',cliente), NULL)`).
4. Fechamento no último dia do mês; vencimento no **5º dia útil** seguinte
   (→ `tb_financial.dt_expiration`).
5. Rotina (botão, sem agendamento): clientes ativos → ordem aberta recebe
   itens do contrato; sem ordem → abre nova com itens do contrato.
   - Cliente novo no mês: **pró-rata 30 dias corridos**
     (`valor × dias_ativos / 30`).
   - Cliente cancelado com ordem aberta: **faturamento parcial**.
6. **Gerar Faturamento**: emite NFS-e, fecha a ordem (aberta → faturada),
   gera `tb_financial` + `tb_financial_bills` (`kind='RA'`).
7. Baixa futura → parcerias (4.3).

### 4.6 Máquina de estados da ordem
`aberta` → `faturada`. Nota + títulos nascem na transição. Pagamento vive no
financeiro. Cancelamento via soft delete.

### 4.7 Fiscal — NFS-e Nacional
- Serviço não usa CFOP (`tb_cfop` segue para NF-e de mercadoria).
- LC 214/2025: padrão nacional obrigatório desde 01/01/2026 (ADN; base
  futura do IBS/CBS). Emissão: API do Emissor Nacional **ou** emissor
  próprio integrado ao ADN.
- **D13 adiada deliberadamente** para aliviar os entregáveis atuais — a
  escolha do caminho de emissão fica registrada na seção Pendências.

## 5. Camada Financeira — Ponta a Ponta (novo na v4)

Cadeia: `tb_order` (faturada) → `tb_financial` → `tb_financial_bills` →
`tb_financial_payment` (baixa) → `tb_financial_statement` (movimento).

### 5.1 `tb_financial` — valores finais do faturamento
Registro por **parcela** (`parcel`), vinculado a `tb_order_id`. Guarda
`dt_expiration` (vencimento), `tb_payment_types_id` e `tag_value`. É o
histórico de contratos faturados, atendimentos realizados e valores a pagar.
**Sem `id`** — PK natural `(tb_institution_id, tb_order_id, terminal, parcel)`.

### 5.2 `tb_financial_bills` — o título (estende `tb_financial`)
- **`number`**: nº da order + nº do invoice / nº da parcela — ex. `1/1-1`,
  `1/1-2`.
- **`kind`** (natureza do título):
  - `RA` — Recebimento Automático: veio de processo anterior do sistema
    (faturamento/documento vinculado). *O ciclo mensal gera RA.*
  - `RM` — Recebimento Manual: cobrança emitida sem vínculo (dívida antiga).
  - `PA` — Pagamento Automático: gerado por processo anterior — *recebimentos
    que geram valor a pagar aos parceiros de contrato.*
  - `PM` — Pagamento Manual: sem vínculo (energia/água/internet etc.).
- **`situation`**: `N` Normal (forma de recebimento indefinida) |
  `D` Destinada (usuário definiu: boleto/cheque/carteira).
- **`operation`**: `C` crédito a favor da empresa | `D` débito contra a
  empresa. **Combinações invertidas sinalizam créditos a compensar na
  baixa**: (`RA`/`RM`)+`D` = cliente tem crédito com a empresa;
  (`PA`/`PM`)+`C` = empresa tem crédito com o fornecedor.
- **`stage`**: `N` não enviado a banco/caixa | `B` finalizado em Banco |
  `C` finalizado em Caixa.
- **Sem `id`** — PK natural `(tb_institution_id, tb_order_id, terminal, parcel)`,
  espelhando `tb_financial`.

### 5.3 `tb_financial_payment` — a baixa (estende `tb_financial`)
Registra recebimento **ou** pagamento: `interest_value` (juros),
`late_value` (multa/mora), `discount_aliquot`, `paid_value`,
`dt_payment` / `dt_real_payment` (**`dt_payment`** = data prevista/lançada
da baixa; **`dt_real_payment`** = data em que o valor efetivamente
entrou/saiu — compensação), e **`settled_code`**.
**Sem `id`** — PK `(tb_institution_id, tb_order_id, terminal, parcel, event)`,
onde `event int` é o sequencial de eventos da parcela (baixa=1, estorno=2,
rebaixa=3...), necessário por causa do estorno imutável (5.5) e do pagamento
parcial.

**`settled_code`** vincula a baixa ao movimento financeiro em relação
**N:1** — várias baixas podem compartilhar o mesmo código, gerando **um
único registro** no movimento (ex.: cliente paga 3 títulos de uma vez em um
único PIX). Geração: **`MAX+1 FOR UPDATE` por instituição** (padrão da base).

### 5.4 `tb_financial_statement` — o movimento financeiro
Onde as operações se finalizam a crédito/débito; o saldo estabelece a saúde
de caixa. `tb_bank_account_id = 0` → **Caixa**; `> 0` → conta corrente.
Campos de apoio: `future` (lançamento futuro), `conferred` (conciliação),
`dt_original`, `doc_reference`, plano financeiro de crédito e débito.

### 5.5 Estorno de baixa (D12 revisada — imutabilidade)
**Princípio: financeiro não se apaga — nem soft.** Baixa registrada e
movimento vinculado são imutáveis. Estorno = **lançamento inverso** que
compensa os valores + **marcação de cancelado** no original.

Mecânica:
1. **Lançamento inverso:** novo `tb_financial_payment` de estorno + novo
   registro em `tb_financial_statement` com crédito/débito invertidos e
   `settled_code` próprio.
2. **Marcação (recomendação):** campo `status char(1)` em
   `tb_financial_payment` e `tb_financial_statement` —
   `N` normal · `E` estornado (original cancelado) · `R` registro de estorno
   (o inverso). Relatórios de valores vigentes filtram `status='N'`.
3. **Vínculo:** o registro inverso aponta o original
   (`tb_financial_payment_id_origin` / equivalente no statement). Trilha
   auditável pelo vínculo; consulta barata pelo status.
4. **Motivo:** `reversal_reason varchar(100)` no registro inverso (usuário e
   data já vêm da auditoria padrão).
5. **Título volta a aberto:** estado derivado — título em aberto = sem
   payment com `status='N'`.
6. **Bills `PA` de parceria derivadas da baixa estornada:** em cadeia — se
   ainda abertas, marcação de canceladas (sem delete); se já pagas ao
   parceiro, estorno inverso nelas também.
7. **Estorno parcial (resolve a antiga P2):** num `settled_code`
   compartilhado, estorna-se apenas os payments desejados gerando inversos
   dos valores exatos; o movimento original permanece íntegro e o inverso
   compensa a parte estornada.

### 5.6 Cadastros bancários de suporte
- `tb_bank` (**setes_central** — compartilhado, mesmo caminho de
  institution/customer/collaborator, aba Banco).
- `tb_bank_account` (por schema): conta corrente do cliente da Setes —
  agência/conta com DV, limite, gerente.
- `tb_bank_historic` (por schema): históricos de extrato por banco, para
  apoiar a **conciliação** (`conferred`).

## 6. Fluxo Consolidado Ponta a Ponta — Sequência Confirmada

Identidade do backbone: `tb_order.id` = `tb_order_service.id` =
`tb_order_item.id` = `tb_invoice.id` = chave do `tb_financial`
(`tb_order_id`).

1. **`tb_order`** — base inicial.
2. **`tb_order_service`** — especialização do serviço (DDL abaixo).
3. **`tb_order_item`** — itens do serviço (avulsos durante o mês).
4. **`tb_order_totalizer`** — totaliza os itens.
5. **`tb_order_billing`** — a cobrança da ordem (condições/parcelamento que
   servirão de base para o financeiro).
6. **Rotina mensal** — injeta os **itens do contrato** na ordem aberta (ou
   abre nova); pró-rata 30 dias; parcial de cancelado.
7. **Faturamento** — `tb_invoice` (registro interno da fatura; os
   `tb_order_item` "vão de brinde" para a nota). Ordem: aberta → faturada.
8. **Emissão oficial da NFS-e Nacional** — **Futuro** (P1 confirmada).
9. **Geração do financeiro** — `tb_financial` → `tb_financial_bills`
   (`RA`, vencimento 5º dia útil) → `tb_financial_payment` (baixa).
10. **Baixa no Banco ou Caixa** — `tb_financial_statement`
    (`tb_bank_account_id` 0 = Caixa, >0 = conta).
11. **Parcerias** — a baixa do recebimento gera bills `PA` por colaborador
    (% × pago), que percorrem os passos 9–10 novamente na ponta do pagar.

```
Tarefas/extras ──► tb_order_service (aberta) ◄── itens do contrato (rotina mensal)
          totalizer + billing (condições de cobrança)
                            │  Gerar Faturamento
                            ▼
              tb_invoice (interno; NFS-e oficial = futuro)
                            ▼
              tb_financial + bills RA (venc. 5º dia útil)
                            ▼  baixa (payment, settled_code)
              tb_financial_statement (banco/caixa)
                            ▼
              bills PA parceiros ─► baixa ─► statement
```

### 6.1 DDL de referência — `tb_order_service`
```sql
CREATE TABLE `tb_order_service` (
  `id` int(11) NOT NULL,
  `tb_institution_id` int(11) NOT NULL,
  `terminal` int(11) NOT NULL DEFAULT 0,      -- confirmado (padrão da base)
  `number` int(11) DEFAULT NULL,
  `tb_customer_id` int(11) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'A',      -- A=aberta | F=faturada (D6)
  `open_lock` varchar(30) GENERATED ALWAYS AS (
      IF(`status`='A' AND `deleted`='N',
         CONCAT(`tb_institution_id`,'-',`tb_customer_id`), NULL)) STORED,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`,`tb_institution_id`,`terminal`),
  UNIQUE KEY `uk_open_per_customer` (`open_lock`),  -- D5
  KEY `idx_cust_status` (`tb_institution_id`,`tb_customer_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```
Notas: `status` e `open_lock` são obrigatórios para D5/D6; a trava considera
`deleted` para ordem excluída não bloquear o cliente.

## 7. Decisões — FECHADAS

| # | Questão | Decisão |
|---|---|---|
| D1 | Tabela de contrato | Em desenvolvimento (cf. 4.2) |
| D2 | Cliente no meio do mês | **Pró-rata 30 dias corridos** |
| D3 | Cancelado com ordem aberta | Faturamento parcial |
| D4 | Tarefa: horas ou valor | Valor fechado |
| D5 | Unicidade de ordem aberta | Aplicação + constraint (coluna gerada) |
| D6 | Estados da ordem | Apenas `aberta` e `faturada` |
| D7 | Histórico de reajuste | `tb_invoice` + camada financeira |
| D8 | Rotina de faturamento | Manual (botão), sem agendamento |
| D9 | Produtos por contrato | N produtos (`tb_contract_item`) |
| D10 | Nível da parceria | Cliente |
| D11 | Vigência da parceria | Sem vigência — histórico no financeiro |
| D12 | Estorno de baixa | **Imutável — lançamento inverso + marcação `status` (5.5)** |
| D13 | Caminho de emissão NFS-e | **Adiada deliberadamente** (→ Pendências) |
| D14 | Controle de tempo contratado | Manual até segunda ordem |
| D15 | Semântica de ordem fechada | Fechada = faturada (cobrança é outro tempo) |

## 8. Pendências Registradas (nada se perde — mentalidade ERP)

| # | Pendência | Fase dona |
|---|---|---|
| P1 | ~~Caminho de emissão NFS-e~~ — **confirmado futuro**: `tb_invoice` é o registro interno; emissão oficial (Emissor Nacional × ADN) fica fora do escopo atual | Futuro |
| P11 | ~~`tb_order_billing`~~ — **resolvida: permanece no circuito, passo 5 da sequência** (após o totalizer; condições de cobrança que baseiam o financeiro) | — |
| P2 | ~~Estorno parcial em `settled_code` compartilhado~~ — **resolvida** pelo padrão de lançamento inverso (5.5.7); validar na Fase 4 | Fase 4 |
| P3 | Boleto/`situation='D'`: geração de boleto e remessa/retorno CNAB não especificados | **Futuro — confirmado (fora do escopo atual)** |
| P4 | Processo de conciliação bancária (`tb_bank_historic` × `conferred`): rotina a especificar | **Futuro — confirmado (fora do escopo atual)** |
| P5 | Regras de juros/multa/desconto na baixa (campos existem; cálculo não definido) | **Futuro — confirmado (baixa aceita valores informados manualmente)** |
| P6 | ~~Geração do `settled_code`~~ — **definido: `MAX+1 FOR UPDATE` por instituição** (mesmo padrão de IDs da base) | Fase 5 (DDL/índice) |
| P7 | ~~PKs dos DDLs~~ — **definido: remover `id` de `tb_financial` e `tb_financial_bills`; PK natural `(tb_institution_id, tb_order_id, terminal, parcel)`.** Em `tb_financial_payment`, a mesma chave colide com estorno (5.5) e pagamento parcial → **acrescentar discriminador `event int` ao final da PK** (sequencial da parcela: baixa=1, estorno=2, rebaixa=3...). `tb_financial_statement` mantém `id` próprio (não é amarrado a ordem) | Fase 5 (DDL) |
| P8 | ~~Semântica das datas~~ — **confirmado: `dt_payment` = data prevista/lançada da baixa; `dt_real_payment` = data em que o valor efetivamente entrou/saiu (compensação)** | Fase 5 (documentar no DDL) |
| P9 | Controle de tempo contratado deixa de ser manual (D14) | Futuro |
| P10 | Créditos a compensar (operation invertida) na apuração da baixa: algoritmo de compensação a especificar | **Futuro — confirmado (campos e semântica já registrados em 5.2)** |

## 9. Roteiro de Fases e Entregáveis

### Fase 1 — Domínio, Regras e Decisões ✅ (v4)

### Fase 2 — Modelo Conceitual ▶ próxima
**Prompt:** "Com base nas seções 1–8, desenhe o modelo conceitual: entidades,
relacionamentos e cardinalidades — `tb_order_service`, `tb_contract` +
`tb_contract_item`, `tb_partnership`, `tb_order_item`, `tb_invoice`,
`tb_financial`, `tb_financial_bills`, `tb_financial_payment`,
`tb_financial_statement`, `tb_bank*`. Diagrama Mermaid ER + justificativa de
2–3 linhas por entidade nova, respeitando as decisões da seção 7."
**Entregável:** ER + justificativas.

### Fase 3 — Rotina Mensal e Transição de Estados
**Prompt:** "Especifique a rotina de faturamento (pseudocódigo) com
`aberta`→`faturada`: pró-rata 30 dias corridos, faturamento parcial de
cancelado, reaproveitamento de ordem aberta (D5), geração de
`tb_financial`/`bills` `RA` com vencimento no 5º dia útil (especificar o
cálculo de dia útil). Diagrama de estados Mermaid."
**Entregável:** especificação + diagrama.

### Fase 4 — Rotina de Parcerias
**Prompt:** "Especifique: baixa do recebimento → parceiros do cliente →
geração de bills `PA` (% × pago), validação dos 90%, pagamento parcial, e
estorno pelo padrão de imutabilidade da seção 5.5 (lançamento inverso,
`status` N/E/R, cadeia nas bills `PA`, caso parcial em `settled_code`
compartilhado). Diagrama de sequência Mermaid."
**Entregável:** especificação + sequência.

### Fase 5 — Modelo Físico (DDL)
**Prompt:** "Converta o conceitual em DDL nos padrões da base, corrigindo
P7 (PKs compostas padrão `tb_invoice`), definindo P6 (`settled_code`) e P8
(datas da baixa), incluindo a coluna gerada + unique da D5. Índices: ordem
aberta por cliente, parceiros por cliente, contratos ativos, títulos por
vencimento/kind/stage, `settled_code`."
**Entregável:** DDL + índices + notas de migração.

### Fase 6 — Baixa, Movimento, Fiscal e Conciliação
**Prompt:** "Especifique: (a) apuração da baixa aceitando juros/multa/
desconto como valores informados (cálculo automático fica futuro — P5;
compensação de créditos por operation invertida também futura — P10);
(b) geração do
movimento via `settled_code` N:1 e estorno por lançamento inverso (5.5).
Emissão oficial da NFS-e fica fora (P1 futura) — especificar apenas o
registro interno em `tb_invoice`."
**Entregável:** especificação financeira/fiscal completa.

### Fase 7 — Casos de Teste
**Prompt:** "Matriz de cenários: cliente sem/com extras; ordem faturada
intra-mês + fechamento; pró-rata 30 dias; cancelado parcial; 2ª ordem aberta
(constraint); baixa múltipla com um `settled_code` (3 títulos, 1 PIX);
pagamento parcial com parceiros; estorno total e parcial; título PM
(despesa) ponta a ponta."
**Entregável:** matriz de testes.

---

## 10. Material Complementar Incorporado

- [x] "Controle de sistema da Setes" (v2)
- [x] Respostas D1–D15 (v3)
- [x] "Controle financeiro" — camada `tb_financial*` + bancos (v4)
- [x] Verificação de conformidade com a base + execução das Fases 2–7
      (v4.1, 2026-07-18 — seção 11 abaixo; entregáveis em
      `Infra-IA/setes-api/05-ORDEM-SERVICO-SOFTWARE-HOUSE.md`)

---

## 11. Notas de Conformidade com a Base (v4.1 — verificação 2026-07-18)

Verificação feita contra `Infra-IA/database/PADROES_BANCO.md`, skill
`revisar-ddl.md`, `ARQUITETURA_MODULOS_API.md` e o baseline real
(`setes-api/src/migrations/sql/001_baseline.sql`).

### 11.1 O que o baseline JÁ tem (o plano subestima o ponto de partida)

| Objeto do plano | Situação real no baseline |
|---|---|
| `tb_order` backbone + ramos + `tb_order_item`/`totalizer`/`billing` | **Existem** — PK `(id, tb_institution_id, terminal)`; ramos com FK composta p/ `tb_order`. `tb_order_item.kind` (varchar 50, default 'Sale') discrimina o ramo do item |
| `tb_financial` | **Existe** e a PK natural `(tb_institution_id, tb_order_id, terminal, parcel)` JÁ é a de P7 — a coluna `id` é vestigial (`DEFAULT NULL`); P7 = só dropar |
| `tb_financial_bills` | **Existe** com number/kind/situation/operation/stage e a mesma PK natural; falta tipar os domínios em `char(1)` |
| `tb_financial_payment` | **Existe** com juros/multa/desconto/datas/`settled_code`; falta o discriminador `event` na PK e os campos de estorno (`status`, vínculo de origem, motivo) |
| `tb_financial_statement` | **Existe** com `settled_code`, `future`, `conferred`, `dt_original`, `doc_reference` e `tb_financial_plans_id_cre/_deb`; falta `status` do estorno |
| `tb_partnership` + `tb_partnership_customer` + `tb_partnership_partner` | **Existem** mas **SEM NENHUMA PK** (caso clássico do checklist revisar-ddl) e com a coluna fora de padrão `tb_customer` (sem `_id`) — precisam de REALINHAMENTO |
| `tb_invoice` | **Existe** — PK `(id, tb_institution_id, terminal)`, serve como registro interno da fatura sem mudança estrutural |
| `tb_bank`, `tb_bank_account`, `tb_bank_historic` | **Existem por schema**; o plano quer `tb_bank` na central — mover é realinhamento com FK cross-schema |
| `tb_contract` / `tb_contract_item` / `tb_order_service` | **NÃO existem** — nascem novas |

### 11.2 Correções de padrão aplicadas nos entregáveis

1. **Premissa "setes_setes (base do migration)" é imprecisa** — `setes_setes`
   é o schema da PRÓPRIA Setes como cliente; migrations rodam em TODOS os
   schemas (`runMigrationsForSchema`). Corrigido na leitura.
2. Flags e domínios em `char(1)` `'S'/'N'` (kind `RA/RM/PA/PM` = `char(2)`);
   nunca varchar.
3. Tabelas novas/realinhadas: charset `utf8mb4_unicode_ci` (padrão das
   migrations 005+), `KEY updated_at` para sync incremental, FK cross-schema
   explícita para `setes_central` (institution/entity), IDs pela aplicação
   (`MAX+1 FOR UPDATE`), sem AUTO_INCREMENT.
4. `tb_order_service` (DDL da seção 6.1) ganhou: FK composta para
   `tb_order`, `KEY updated_at`, collation unicode_ci; `tb_customer_id`
   referencia `setes_central.tb_entity` (padrão pós-entidade única).
5. `tb_partnership_customer.tb_customer` → renomeada `tb_customer_id`.
6. Convergência com Formas de Pagamento v2 (mesmo dia): a
   `tb_institution_has_payment_types` já tem `usage_preference`
   'C'aixa/'B'anco/'A'mbos e `tb_financial_plans_id_cre/_deb` — a forma de
   pagamento do título já sabe para onde o movimento tende (stage B/C) e
   quais planos financeiros sugerir no statement.
7. **Financeiro imutável × coluna `deleted`**: a coluna padrão permanece
   (uniformidade da base), mas a REGRA DE APLICAÇÃO é que
   `tb_financial_payment` e `tb_financial_statement` nunca recebem delete
   (nem soft) — cancelamento só pelo par lançamento inverso + `status`.

### 11.3 Decisões provisórias tomadas na execução (⚠️ validar com o Valdo)

| # | Decisão provisória | Racional |
|---|---|---|
| DP1 | ✅ **REVISADA pelo Valdo (2026-07-18) — mudança de estratégia**: o **USUÁRIO decide a data de vencimento** no Gerar Faturamento ("podemos ter imprevistos"). O 5º dia útil (4.5.4) deixa de ser regra e vira apenas SUGESTÃO de default na tela (seg–sex). P12 (calendário de feriados) CANCELADA | Flexibilidade operacional > regra fixa |
| DP2 | ✅ **VALIDADA pelo Valdo (2026-07-18)**: `tb_bank` central = **catálogo de referência simples** (id + number FEBRABAN + description), como tb_country — NÃO entra na cadeia de entidade fiscal | O tb_bank do baseline é só número; banco-instituição-financeira ≠ papel de entity |
| DP3 | ✅ **VALIDADA pelo Valdo (2026-07-18)**: mensalidade do contrato = **soma dos `tb_contract_item.value`** (valor por produto); sem campo redundante no contrato | Evita dupla verdade; D9 pede N produtos |
| DP4 | ✅ **VALIDADA pelo Valdo (2026-07-18)**: parcerias mantêm o TRIO do baseline realinhado (partnership + _customer + _partner com PKs) | Aproveita dados existentes; D10 (nível cliente) atendido pela _customer |
| DP5 | ✅ **VALIDADA pelo Valdo (2026-07-18)**: vínculo do estorno = `origin_event int` no payment (a PK é composta; não existe "id" para apontar) e `tb_financial_statement_id_origin` no statement | Adapta a 5.5.3 à PK natural de P7 |
| DP6 | ✅ **REVISADA pelo Valdo (2026-07-18)**: `tb_order_item` vira detalhe UNIVERSAL enxuto — `tb_stock_list_id` e `tb_price_list_id` SAEM do item e vão para a especialização nova `tb_order_item_merchandise` (criada quando tratarmos itens de mercadoria). Serviço usa o item universal direto (`kind='Service'`), sem colunas de estoque | Orientação a objeto: item genérico + especialização por natureza |
| DP7 | ❌ **REVERTIDA pelo Valdo (2026-07-18)**: o status é controlado na **`tb_order`** (backbone), não na especialização. CONSEQUÊNCIA TÉCNICA na D5: coluna GERADA não enxerga outra tabela — `open_lock` da `tb_order_service` vira coluna NORMAL mantida pela APLICAÇÃO na MESMA transação que muda `tb_order.status` (preenche no abrir, esvazia no faturar/cancelar); a UNIQUE permanece como rede de proteção | Backbone é o dono do ciclo de vida |
| DP8 | ✅ **VALIDADA pelo Valdo (2026-07-18)**: registro interno da fatura de serviço com `tb_invoice.model = 'SE'` e `number` sequencial **MAX+1 por institution** | Discrimina do modelo 55/65 de mercadoria; emissão oficial é P1 |
| DP9 | ✅ **VALIDADA pelo Valdo (2026-07-18)**: `settled_code` gerado por `MAX+1 FOR UPDATE` sobre `tb_financial_payment` por institution | É onde o código nasce; statement herda |

### 11.4 Impacto no sincronizador (pendência existente AMPLIADA)

Os endpoints `/sync/financial*` gravam no formato antigo (inclusive a coluna
`id` que P7 remove). A revisão geral do sync já é pendência registrada
(CLAUDE.md; chip aberto para /sync/paymentType) — o realinhamento da Fase 5
DEVE entrar nessa revisão antes de rodar em schema com sincronizador ativo.

### 11.5 Pendência nova

| # | Pendência | Fase dona |
|---|---|---|
| P12 | ~~Calendário de feriados para o 5º dia útil~~ — **CANCELADA** (DP1 revisada: vencimento é informado pelo usuário no faturamento; 5º dia útil é só sugestão de default) | — |
