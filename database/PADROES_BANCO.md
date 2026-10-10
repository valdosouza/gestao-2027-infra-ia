# Padrões de Banco de Dados — Setes (Gestão 2027)

**Versão**: 1.0
**Origem**: 21 decisões arquiteturais da Fase 2 (Gerenciamento Central), registradas em `setes-api/prompt_fase2_gerenciamento_central.md`
**Scripts canônicos**: `D:\Gestao2027\sql\01..05_*.sql`
**Escopo**: misto

Este documento é a **referência permanente** para criar qualquer tabela nova. Toda DDL nova deve passar pela skill `database/skills/revisar-ddl.md` antes de executar.

---

## 1. Nomenclatura

- Toda tabela inicia com `tb_`, nomes em inglês, singular (`tb_customer`, não `tb_customers`)
- FK: coluna = nome da tabela referenciada + `_id` (`tb_linebusiness` → `tb_linebusiness_id`)
- Tabelas N:N: `tb_<a>_has_<b>` (`tb_entity_has_mailing`, `tb_institution_has_user`)
- Schemas de cliente: prefixo `setes_<nome>` (validação `/^setes_[a-z0-9_]+$/`); o schema da própria Setes é `setes_setes`

## 2. Herança por PK compartilhada (padrão central)

Tabelas-filhas de `tb_entity` usam `id` como **PK e FK ao mesmo tempo** para `tb_entity.id`:
`tb_company`, `tb_person`, `tb_user`, `tb_institution`, `tb_address`, `tb_phone`, `tb_social_media`, `tb_customer` e futuras.

- Foge deliberadamente do padrão `tb_entity_id` — decisão por similaridade/herança (ObjEntity → ObjEntityFiscal)
- Exceção: tabelas N:N mantêm o padrão `tb_<tabela>_id`
- Tabelas "lista por tipo" (endereço, telefone, rede social) usam PK composta (`id`, `kind`) — um registro por tipo
- **Herança em DOIS níveis** (Valdo, 2026-07-17): `tb_salesman` herda de `tb_collaborator`, que herda de `tb_entity` — todo vendedor É colaborador (precedência obrigatória); colaborador pode ser só administrativo. O `id` é o mesmo na cadeia inteira. `tb_collaborator` CRIADA em 2026-07-18 (sql/03 + migration 008; PK `(id, tb_institution_id)`, FK `id → setes_central.tb_entity`); a precedência será instituída na APLICAÇÃO quando o cadastro de salesman nascer (FK física descartada — schemas com salesman sincronizado do legado a inviabilizam). Hierarquia completa: Entity → EntityFiscal → {Customer, Provider, Carrier, Bank, Institution, Collaborator → Salesman} (detalhes: `setes-app/skills/cadastro-entidade-fiscal.md`)

## 3. Colunas padrão em toda tabela

```sql
`created_at` datetime,
`updated_at` datetime,
`deleted`    char(1) NOT NULL DEFAULT 'N'
```

- Flags booleanas: `char(1)` com `'S'`/`'N'` (nunca `'Y'`, nunca boolean — exceção: `tb_feature_flag.enabled` boolean por compatibilidade com o flag.service)
- Datas: nunca `0000-00-00` (falha em modo estrito); seeds usam `NOW()` ou datas reais
- Defaults: `DEFAULT NULL` real, nunca a string `'NULL'`

## 4. IDs

- `int(11)`, **gerados pela aplicação** (`SELECT COALESCE(MAX(id),0)+1 ... FOR UPDATE` dentro de transação)
- **Sem AUTO_INCREMENT** em nenhuma tabela — **EXCEÇÃO documentada** (Valdo,
  2026-07-19, Framework de Mensagens R2): `setes_central.tb_crashlytics`
  mantém AUTO_INCREMENT — log de erro não pode falhar por corrida de lock
  justamente quando algo já deu errado; a chave de consulta real é o `ref`
  (UNIQUE) exibido ao usuário

## 5. Separação setes_central × setes_<schema>

**Regra de ouro: as duas bases NUNCA têm as mesmas tabelas.**

| Vive em `setes_central` | Vive em `setes_<schema>` |
|---|---|
| Cadastro: `tb_entity`, `tb_company`, `tb_person`, `tb_address`, `tb_phone`, `tb_social_media`, `tb_mailing*` | Operacional do cliente: `tb_customer` e demais tabelas de movimento |
| Autenticação/licença: `tb_user`, `tb_institution`, `tb_institution_has_user`, `tb_sync_api_key`, `tb_feature_flag` | Configuração do institution (decisão 18 setes-app): `tb_institution_has_interface` (contrato comercial), `tb_module`, `tb_module_has_interface`, `tb_user_has_privilege` |
| UI/permissões — **catálogo**: `tb_privilege`, `tb_interface`, `tb_interface_has_privilege` | |
| Preferências/tema (setes-app Fase 1): `tb_user_has_preference`, `tb_institution_theme` | |
| Referência geográfica: `tb_country`, `tb_state`, `tb_city` | |
| Referência fiscal: `tb_cfop`, `tb_ncm`, `tb_cest`, `tb_tax_*`, `tb_deter_base_*`, `tb_discharge_icms` | |

- Dois níveis de autorização (decisão 17 setes-app): `tb_feature_flag` = gate técnico de módulos da API (central); `tb_institution_has_interface` = contrato comercial por tela (schema do cliente). A tela de cliente do Super mantém as duas coerentes.

- **Par catálogo × valor** (padrão consolidado — Fase 2 campos + Framework de
  Configurações 2026-07-18): característica intrínseca do produto vive UMA vez
  no catálogo em `setes_central` (`tb_interface_has_field`,
  `tb_interface_has_config`); a escolha do cliente vive no `setes_<schema>`
  (`tb_institution_has_field`, `tb_institution_has_config`) com FK composta
  cross-schema para o catálogo (COLLATE precisa coincidir — utf8mb4_unicode_ci).
  Valor só existe quando DIVERGE do herdado. Em `tb_institution_has_config`,
  `tb_user_id` na PK usa **sentinel 0** = valor da institution (coluna de PK
  não aceita NULL); >0 = override do usuário (só quando o catálogo marca
  `scope='U'`). Resolução: usuário → institution → default do catálogo.

- **Collation em JOIN por VARCHAR — schema do cliente é MISTO por construção**
  (Q-N2 da negociação do pedido, Valdo 2026-09-07): o baseline 001 cria as tabelas
  em `utf8mb4_general_ci` (151 tabelas) e as migrations novas em
  `utf8mb4_unicode_ci` (34). `coluna = coluna` VARCHAR entre collations distintas
  explode com erro 1267 SÓ contra o banco real (`coluna = ?` não) — caso real:
  `tb_order_item.kind = tb_order_item_tax_rule.kind` em `@shared/order`. Regra:
  **tabela nova que faz JOIN por VARCHAR com tabela do baseline adota a collation
  dela** (precedente `tb_order_item_return`, sql/03); `COLLATE` explícito no JOIN
  só como exceção documentada no código. Convergir o schema inteiro é projeto
  próprio (não decidido). FK cross-schema para a central continua exigindo
  `utf8mb4_unicode_ci` (item acima).
  **Coluna nova que REFERENCIA catálogo central nasce `utf8mb4_unicode_ci` POR
  COLUNA, mesmo dentro de tabela general_ci do baseline** (D-IB25, fase IBS/CBS,
  Valdo 2026-10-10): o par natural de JOIN dela é o catálogo central (unicode_ci),
  não as colunas vizinhas — `CHAR(6) CHARACTER SET utf8mb4 COLLATE
  utf8mb4_unicode_ci`. Caso real: `classification_code`/`place_indicator_code`/`nbs`
  em `tb_invoice_service` (o `national_code` antigo da mesma tabela ficou general_ci —
  armadilha 1267 latente, sem JOIN hoje).
- **Banco SEM modo estrito no dev** (MariaDB 10.4: `@@sql_mode = IGNORE_SPACE,
  NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION`, constatado na IB-0 da fase
  IBS/CBS): VARCHAR/CHAR acima do tamanho TRUNCAM em silêncio e `INSERT IGNORE`
  rebaixa até erro de FK a aviso. Regras: **nunca `INSERT IGNORE` em migration/backfill**
  (use `INSERT … SELECT … WHERE NOT EXISTS`); **loader de catálogo confere forma e
  tamanho antes de gravar** ("o que valida é o que grava"); **domínio fechado = CHECK**
  (D-IB26 — o boot confere que o motor aplica CHECK: `assertCheckConstraintsEnforced` em
  `@shared/db/connection`, INSERT fora do domínio numa transação desfeita tem de ser
  RECUSADO, senão a API não sobe); flag de catálogo `NOT NULL` SEM default (ausência de
  dado não pode virar "não exige"). Coluna SNAPSHOT sem FK (ex.: código congelado na
  nota) ganha CHECK de FORMATO (`col IS NULL OR col REGEXP '^[0-9]{6}$'`) — mas o CHECK
  vê o valor JÁ truncado: quem grava continua conferindo o tamanho.
- **Carga de catálogo central a partir de fonte EXTERNA é um ATO com PLANO** (IB-1 da
  fase IBS/CBS, gates de 2026-10-10 — molde `scripts/load-ibscbs-catalog.ts`): ENSAIO por
  padrão (transação + ROLLBACK, relatório com as CHAVES que perdem presença); o ato só
  grava com o hash do plano que o ensaio mostrou (fonte, leitura ou data mudou = nada
  gravado); fonte VAZIA ou com estrutura mudada = recusa da carga inteira (nunca "tudo
  vira ausente"); presença (some da fonte → `deleted='S'`, volta → revive) e linha de
  vigência nunca apagada; arquivo baixado é dado não confiável — leitor com teto de
  bytes E orçamento de memória.

- **Catálogo central INICIADO PELO CLIENTE** (3º padrão de catálogo — Formas de
  Pagamento, Valdo 2026-07-18): a tabela vive em `setes_central` mas quem
  alimenta é o CLIENTE — dedupe por DESCRIÇÃO dentro da transação (existe =
  reusa/vincula; não existe = MAX+1 e vincula — reuso entre clientes, mesmo
  espírito da entidade única). O uso por institution fica em
  `setes_<schema>.tb_institution_has_<x>` (atributos do vínculo, ex.:
  enable/app_mobile/max_parcels/usage_preference — migration 012). Na linha
  do catálogo, a DESCRIÇÃO é imutável (chave do reuso); atributos técnicos
  como `id_nfce` são editáveis pela tela — o PUT atualiza a linha CENTRAL,
  valendo para todos os clientes vinculados. O cliente nunca exclui a linha
  compartilhada — por isso o vínculo tem `enable` (desabilitar por um
  tempo). Helpers em `@shared/payment-types` (molde; upsertLink sem attrs
  NÃO sobrescreve a configuração existente do vínculo — só ressuscita).
- `tb_interface.kind char(1) NOT NULL DEFAULT 'T'` (decisão 13 do Framework):
  'T' = tela (vai a menu), 'R' = recurso/aba vendável (NUNCA vai a menu — os
  ramos da montagem filtram `kind='T'`). A coluna legada varchar(26) foi
  reaproveitada; bootstrap-db.ts normaliza valores antigos para 'T'.

- FKs do schema do cliente para a central são **cross-schema explícitas**: `REFERENCES setes_central.tb_entity (id)`
- Script 04 (`sql/04_schema_cliente_cleanup.sql`) remove dos schemas o que foi centralizado

## 6. Autenticação e permissões

- `tb_user` controla **somente autenticação** (1 registro por entity; PK simples `id`)
- Senha: MD5 sem salt (decisão registrada; risco de rainbow table aceito), hash aplicado **no backend**, nunca na query
- Perfil do usuário: `tb_institution_has_user.kind` — **por institution** (o mesmo usuário pode ter poderes diferentes em cada empresa)
- `'super'` só vale na institution 1 (Setes) — hard coded no backend (`@shared/auth/roles.ts`)
- Licença do cliente: `tb_institution.active`
- Email de login: grupo 2 (`sistema`) em `tb_mailing_group`

## 7. JWT (setes-api)

```json
{ "institutionId": 1, "userId": 1, "role": "super", "schemaName": "setes_setes" }
```

- `institutionId` int (nunca `tenantId` string — nomenclatura antiga eliminada)
- TTL 24h, sem refresh token (relogin diário; refresh fica para o setes-app)
- Fluxo multi-institution: ver `setes-api/04-AUTH-MULTI-INSTITUTION.md`

## 8. Validação antes de executar

```bash
pip install sqlglot --break-system-packages
python3 -c "import sqlglot; sqlglot.parse(open('arquivo.sql').read(), read='mysql'); print('OK')"
```

E rodar o checklist completo: `database/skills/revisar-ddl.md`.

## 9. Locks, isolamento e leituras que decidem (2026-09-09 — Q-A6/Q-G17 do cancelamento de nota)

Regras que os gates do financeiro (contrato, boleto, cheque, negociação, cancelamento) provaram
a ferro: cada uma nasceu de um CRITICAL/HIGH real.

1. **REPEATABLE READ é invariante** — fixado por conexão no pool (`shared/db/connection.ts`) e
   conferido no boot (`assertIsolationLevel`). Todo gap/range lock da casa (trava D5 em UNIQUE,
   MAX+1 `FOR UPDATE`, numeração pelo índice, leituras travantes dos planos) só existe nesse
   nível; um default diferente do servidor desligaria tudo em silêncio.
2. **Leitura que DECIDE trava** — leitura que decide gravação, bloqueio OU mensagem faz
   `FOR UPDATE` (ou `LOCK IN SHARE MODE`). Sob REPEATABLE READ a leitura consistente vê o
   snapshot de ANTES de esperar o lock: decide com o passado. Subquery dentro de um `SELECT …
   FOR UPDATE` NÃO trava (só a tabela externa) — `NOT EXISTS`/`EXISTS` que decidem precisam de
   leitura travante própria.
3. **Ordem canônica de locks do financeiro**: pedido → nota → título (`tb_financial`) → cheque
   (`tb_check` → `tb_check_event`) → baixa (`tb_financial_payment`) → extrato; boletos
   (`tb_bank_slip` → `_title`) e devoluções depois. Toda peça nova entra nessa ordem; quem
   precisa inverter, reexecuta.
4. **Toda transação que cruza esses locks usa `withDeadlockRetry`** (`@shared/db/deadlock-retry`,
   3 tentativas): o InnoDB escolhe a vítima e desfaz a transação inteira — reexecutar do zero é
   seguro; propagar é 500. Lock wait (1205) NÃO reexecuta: vira 409 RESOURCE_BUSY na borda
   (`@shared/db/contention`, transversal).
5. **MAX+1 sob `FOR UPDATE` com índice cujo prefixo é o WHERE** (settled_code, tb_check,
   `tb_invoice.number_seq`): o lock fica no intervalo do negócio (institution/modelo/série), não na
   tabela inteira. Coluna VARCHAR que participa de MAX numérico ganha coluna GERADA indexada.
6. **Contadores de relatório só depois do commit** — uma tentativa desfeita pelo retry não pode
   ser contada duas vezes (rotina mensal da OS).
7. **Quem CUNHA número por MAX+1 trava a institution ANTES** (`@shared/db/counters`
   `lockInstitutionCounters`, 1º lock da transação): `SELECT MAX(...) FOR UPDATE` num índice
   secundário deixa gap lock no supremum e gap locks são COMPATÍVEIS entre si — N transações
   passam do MAX com o mesmo número e deadlockam no INSERT; o retry (3×) não segura 6
   concorrentes (Q-A12: 47 % de 500 abrindo OS; 50 % abrindo venda com 2). Um X de uma linha
   serializa só os cunhadores. Duas formas: (a) 1º lock da transação — abrir pedido/OS/devolução,
   abrir/retirar do caixa e a baixa em lote (`settleBatchTx` cunha o código ANTES do laço de
   títulos); (b) DENTRO do cunhador compartilhado quando a transação já travou outras coisas —
   `nextSettledCode` (fonte única de todo movimento: estorno, cheque, boleto, auto-baixa do
   faturamento) toma o X ali (Q-A18) e aceita o retry contra as portas (a). O ciclo estrutural
   existe (porta (a) segura o X e espera a linha do pedido mais novo, que faturamento/cancel
   seguram) — o InnoDB mata a porta (a), barata de reexecutar (Q-G26 mede o convoy). Contadores
   que ficam SÓ no retry (provado 10/10): nº da nota, id do cheque, id do boleto e o `tb_order.id`
   cunhado no meio da baixa (ordem PA) e do cheque devolvido (título CH). **Espera limitada (D-A23,
   2026-09-11)**: o X é tomado com `FOR UPDATE WAIT 10` (MariaDB ≥ 10.3, detectado no boot —
   `detectLockWaitSupport`; sem suporte cai no `innodb_lock_wait_timeout` com aviso): 1 detentor lento
   não prende o pool inteiro por 50 s; quem espera mais recebe 1205 → 409 RESOURCE_BUSY e NÃO reexecuta
   (falhar cedo é o objetivo — só deadlock 1213 reexecuta).
8. **Sem PROMOÇÃO de trava na mesma linha** (2026-10-04 — extração fiscal, provado em banco descartável no MariaDB 10.4):
   quem já segura uma linha por trava de REGISTRO (busca pela PK completa: `… WHERE pk = ? FOR UPDATE`, UPDATE pela PK) não
   pede depois, na mesma transação, uma trava de FAIXA que a contenha (`… WHERE prefixo_da_pk = ? FOR UPDATE`): a faixa
   pede next-key na mesma linha e, com um 3º já na FILA dela (ex.: um UPDATE em autocommit), o InnoDB fecha um ciclo e
   mata a vítima menor com 1213 — que sobe cru para quem não reexecuta. Duas saídas: (a) a trava mais LARGA é o 1º lock da
   transação; (b) **"travar todas as linhas da chave X" = PK completa por linha** (`prefixo = ? AND col IN (lista fechada
   do domínio) FOR UPDATE`) — toda trava naquela linha fica de registro, e os valores AUSENTES levam só trava de intervalo
   (não espera ninguém e ainda segura o INSERT concorrente da mesma chave). Caso real: `lockIssuerRows` do `fiscal-api`
   (PUT da habilitação × aluguel do rodízio). Teste que fixa: `adversarial-f1r6.live.test.ts` §D "determinístico".

## 10. Tempo: instante em UTC, data de negócio na zona do estabelecimento (2026-09-30 — Q-TZ1)

Decisão do Valdo (prompt_pesquisa_avancada.md §10): **a sessão do banco é UTC** (`timezone: 'Z'` no
mysql2 + `SET time_zone = '+00:00'` por conexão, conferido no boot) e o **"hoje" é do estabelecimento**
(config `time_zone` da interface establishment, peça `@shared/time-zone`).

1. **INSTANTE** (created_at/updated_at, carimbo de evento, hora do caixa) = `NOW()` — fica em UTC.
2. **DATA DE NEGÓCIO** (dt_record, dt_emission, vencimento, data de pagamento, "hoje" de uma validação)
   NUNCA é `CURDATE()`, `CURRENT_DATE`, `DATE(NOW())` nem `new Date()` do processo: vem de
   `todayFor(schema, institution)` como parâmetro (`?`). Aritmética de dias = calendário puro sobre
   'YYYY-MM-DD' (`addDays`), nunca getters locais de `Date`. **DENTRO DE TRANSAÇÃO passe a conexão
   dela** (`todayFor(schema, institution, conn)`) — nunca uma 2ª conexão do pool com locks seguros (C1
   do gate da onda TZ-1: o padrão que já travou a API). A cerca `time-zone-fence.test.ts` reprova
   `CURDATE(`, `CURRENT_DATE`, `DATE(NOW())`, `new Date().toISOString().slice(0, 10)` e
   `getTimezoneOffset()` fora da peça.
3. **Voz de terceiro** (fisco, banco) com hora: grava o INSTANTE UTC (`toUtcDb`; sem offset = hora de
   Brasília). Idempotência por (kind, dt) casa também a forma antiga (hora de parede) — transição.
4. **Apresentação**: instante com hora sai para o app na hora da zona (`withZoneWall`/`toZoneWall`), na
   FRONTEIRA HTTP — a lógica interna compara em UTC. Coluna DATE sai por `DATE_FORMAT(…,'%Y-%m-%d')`.
5. **Critério de pesquisa sobre DATETIME** (`storage: 'datetime'`) converte só as PONTAS
   (`CONVERT_TZ(?, '+00:00', @@session.time_zone)`), nunca a coluna.
6. Dado gravado antes de 2026-09-30 está em hora de parede de SP — **data de corte** (Q-TZ3), sem backfill.
   ⚠️ **Q-TZ4**: o **setes-sync** (mesmo banco, outro grupo) ainda grava na hora LOCAL da sessão dele — até ele
   adotar esta regra (tarefa do projeto setes-sync), a data de corte só vale para tabelas de autoria EXCLUSIVA da
   API; DATETIME de tabela que o sync também escreve (ex.: `tb_customer.created_at` de cliente sincronizado) pode
   estar em hora de SP mesmo depois do corte. **Deploy**: rodar antes `scripts/pre-deploy-tz-check.ts` (Q-TZ5 —
   nada em voo; Q-TZ6 — fuso do MySQL do ambiente: se já for UTC, a premissa do corte muda e é registrada).
7. Coluna de instante NUNCA tem `ON UPDATE current_timestamp()` se for fato gravado uma vez (bug do
   `tb_cashier.hr_begin`, migration 064).
8. **Relógio único por operação** (Q-TZ8): o middleware de `app.ts` fixa o instante da requisição
   (`runWithOperationClock`); todo `todayFor` dela usa esse instante — um faturamento às 23:59:59 não grava
   dias diferentes. Só DATA DE NEGÓCIO; instante real (dhEmi, created_at) segue o agora de verdade.
   **Lote** (faturamento em lote, rotina mensal, fila do webhook): relógio POR ITEM (`runWithOperationClock(new
   Date(), …)` em volta de cada item — Q-TZ9). **Guarda contra o mundo externo** (banco/fisco julgam pelo agora:
   vencimento no passado, pagamento no futuro) passa o agora real explícito: `todayFor(…, new Date())`.
9. **Pasta do arquivo fiscal** (Q-TZ7): mês contábil na zona do estabelecimento (`saveFiscalXml(…, zone)`); a busca
   tenta o mês da zona e o da hora oficial (arquivos de antes).

## 11. Banco de SERVIÇO e contrato de leitura entre serviços (2026-10-04 — extração fiscal, D-F7/D-F15/D-F27/D-F32)

Origem: `prompts/prompt_apis_fiscais_isoladas.md` §14/§15 — as APIs fiscais (`nfse-api`, `nfe-api`, núcleo `fiscal-api`)
rodam na MESMA instância MySQL do produto, com banco próprio.

1. **Banco de serviço NUNCA se chama `setes_*`** (casaria com o `SCHEMA_RE` dos schemas de cliente): `fiscal_api`.
   Escopo por LINHA (`tb_institution_id` — id global de `setes_central`), sem schema por cliente; sem FK para outro banco.
2. **Migrations com namespace por projeto** (`_migrations (project, version)`) e trava nomeada no executor — duas
   instâncias do serviço sobem juntas. Cada dono cria as SUAS tabelas (núcleo × família — D-F35).
3. **Contrato de leitura entre serviços = VIEW publicada** (D-F15/D-F32): quem lê o banco do outro lê SÓ a view (versionada
   como uma API), nunca a tabela interna. A view NÃO pode ter subconsulta na LISTA do SELECT, GROUP BY, DISTINCT ou LIMIT —
   o MariaDB/MySQL não a FUNDE e a materializa inteira a cada leitura (com 1000 clientes, varredura). "Último evento" vai
   no ON (`NOT EXISTS (… x.event > e.event)` ou `e.event = (SELECT MAX …)`); conferir `EXPLAIN` (select_type PRIMARY,
   acesso por chave) antes de publicar. Tipos e regras de leitura da view saem de UMA biblioteca (D-F33), nunca duas cópias.
4. **Serialização entre serviços = a MESMA linha travada** (D-F27): o `FOR UPDATE` na linha da nota (`tb_invoice` do
   cliente) é o ponto comum; quem trava primeiro a nota e só depois as suas tabelas (ordem nota → linhas do serviço).
   Leitura que decide sobre o banco do OUTRO serviço é travante (`LOCK IN SHARE MODE`) ou feita depois da trava da nota
   (o snapshot do REPEATABLE READ nasce na 1ª leitura consistente — §9 regra 2).
5. **Permissão por GRANT, não por disciplina** (D-F31): o usuário do serviço tem SELECT no ERP e controle total só no
   banco dele; o INSERT no ERP pela conexão do serviço tem que falhar (prova no `nfse-api/ops/grants.sql`).
   ⚠️ MariaDB 10.4 aceita `FOR UPDATE` só com SELECT; MySQL 8.0.22+ exige também DELETE/LOCK TABLES/UPDATE na tabela.
6. **Segredo em coluna só CIFRADO** (D-F16): AES-256-GCM, chave-mestra fora do banco e do repositório, versão por linha,
   AAD = identidade da linha (`<tabela>:<chave>` — a cifra copiada para outra linha não abre).
7. **Exclusão mútua de ROTINA entre instâncias = ALUGUEL por UPDATE atômico numa linha** (coluna `*_lease_until`;
   `UPDATE … SET lease = NOW()+n WHERE … AND (lease IS NULL OR lease < NOW())` → `affectedRows = 1` ganhou), nunca
   `GET_LOCK` com a conexão RETIDA enquanto a rotina pede outra conexão ao pool (gates da F1 fiscal: N passadas × pool
   de N = serviço travado para sempre). Aluguel > orçamento da rotina; queda do processo = o aluguel vence sozinho; quem
   não obtém o aluguel PULA (`skipped`), não espera. `GET_LOCK` fica para o executor de migrations (uma conexão só).
   **O comando do aluguel tem ESPERA CURTA** (D-F41, 2026-10-04): se outra transação segura a LINHA (escrevendo a
   habilitação), o UPDATE não espera o lock wait padrão (50 s) — `innodb_lock_wait_timeout` curto só na sessão daquele
   comando (UPDATE não aceita `WAIT n`) e 1205 → 409 RESOURCE_BUSY; deadlock reexecuta 1× com aviso (seguro só porque o
   comando roda em AUTOCOMMIT — o 1213 já o desfez). Peça: `runShortCommand` do núcleo `fiscal-api`.
8. **Candidata de rodízio/lote é filtrada INTEIRA no SQL, antes do LIMIT** — filtrar em memória depois do LIMIT deixa as
   linhas descartadas presas no topo e o rodízio para em silêncio (gate socrático HIGH da F1 fiscal).
9. **Fato NOSSO não carrega o instante da voz do outro sistema**: a UNIQUE `(…, kind, dh)` é a idempotência da VOZ
   externa (o fisco); reserva/liberação que nós gravamos (K/N do cancelamento) vão com `dh` NULL — com o instante, K → N
   → K no mesmo segundo colidia na UNIQUE (500, provado ao vivo). O "quando" do fato nosso é o `created_at`.
10. **Migração por etapas sem dual-write**: enquanto dois sistemas PODEM escrever o mesmo fato, só um escreve por
    institution — e QUEM escreve é um **FATO MONOTÔNICO na própria linha** que o escritor trava (D-F39: `cutover_at`
    write-once, NULL = réplica), NUNCA configuração por processo (a lista em variável de ambiente divergia entre
    instâncias e abria em silêncio — gates da F1). A condição vai NO COMANDO que cunha número / toma aluguel
    (`… AND cutover_at IS NOT NULL`), não só na borda; leitura velha de um fato monotônico só RECUSA (sem TOCTOU). O ato
    da virada trava a linha da ORIGEM como 1º comando (antes de qualquer leitura não travante) e vira TODAS as linhas da
    institution na mesma transação. A re-sincronia origem → destino FALHA ALTO ao achar no destino fato que a origem não
    tem ou diverge dela (`INSERT IGNORE` sozinho calaria a divergência); depois da virada a origem é CONGELADA e qualquer
    mudança nela é dual-write. **O ato também APOSENTA a linha da ORIGEM** na mesma transação (D-F44, 2026-10-04 — `deleted='S'`
    na habilitação SE do ERP, escrita UMA vez pelo script com a credencial do dono da origem): o lado da origem fecha POR
    CONSTRUÇÃO (quem lá lê só linha viva não cunha mais), em vez de depender de procedimento; quando a linha da origem carrega
    OUTRO conceito junto (a série da nota), o ato CONFERE que aposentá-la não muda esse conceito e falha alto se mudar. **Só migra o
    que muda de casa** (D-F42): filtro POSITIVO pelo conceito do destino, nunca "tudo menos X" — a linha que é só do conceito que
    fica na origem não vira réplica. **Domínio fechado vira CHECK** (D-F45): o 1º CHECK da casa (`ck_establishment_issuer_model`)
    + conferência no boot de que o motor o aplica (MySQL < 8.0.16 aceita e ignora em silêncio).
