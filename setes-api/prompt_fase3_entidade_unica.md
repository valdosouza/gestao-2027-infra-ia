# Prompt — Fase 3: Entidade Única (unicidade de cadastro + papéis + sem documento)

**Status**: ✅ CONCLUÍDA em 2026-07-15 (núcleo) + Rodada 4 Tributação em
2026-07-16/17 (decisões 14–19: tb_entity_tax, wallet→payment type, tb_company
slim — API/banco validados E2E 10/10; aba Tributação no app entregue na mesma
rodada). 19 decisões registradas.
E2E validado (10/10): by-document acha a Setes; POST customer com o CNPJ dela
reusou a entity 1 (`{id:1, reused:true}`); papel duplicado → 409 com id;
sem-doc → tb_no_doc com UUID v4; updated_by gravado. Testes 78/78, tsc e
flutter analyze limpos. **Onda 2 pendente**: telas de cadastro de Salesman e
Carrier (decisão 11); revisão do sync com reindexação (decisão 12).
**Método**: `Infra-IA/skills-genericas/refinar-prompt-arquitetura.md`
**Origem**: rascunho do Valdo (chat 2026-07-15) + referência Delphi
`D:\gestaoweb\files\cad_entity_fiscal.pas` → `TCadEntityFiscal.saveEntityFiscal` (linha 456)

---

## Contexto

A cadeia de entidade fiscal (ObjectEntity → ObjectEntityFiscal → Concreto) está
implementada e desacoplada em `setes-api/src/shared/` (peças address/phone/
social-media/fiscal + composição entity/entity-fiscal.ts). O primeiro concreto
(Institution) está entregue. Hoje o fluxo de criação SEMPRE gera id novo
(`MAX+1 FOR UPDATE`) e trata CPF/CNPJ repetido como ERRO (409).

**Ponto de inflexão**: `setes_central` guarda TODAS as entidades conhecidas —
das entidades dos clientes da Setes E dos clientes dos clientes da Setes. A
mesma pessoa física/jurídica pode ter VÁRIOS papéis em vários schemas:

> A entidade F.D. Souza - Setes - CNPJ 07.742.094/0001-13:
> - em `setes_central`: a entity fiscal Setes
> - em `setes_central`: papel **Institution** (licença + geração do schema setes_setes)
> - em `setes_setes`: papel **Customer** (a Setes é cliente de si mesma)
> - em `setes_genio`: papel **Provider** (fornece o sistema ao cliente Genio)
> - em `setes_docecenter`: papel **Customer** (compra chocolates na Doce Center)

**Princípio da unicidade**: não repetir cadastros. Chaves naturais: `cpf`
(tb_person) e `cnpj` (tb_company) — o Delphi legado já faz isso
(`getIDbyCPF`/`getIDbyCNPJ` antes de criar; achou → reaproveita o Codigo).

**Segundo ponto de inflexão**: na vida real há pessoas que não fornecem
documento e o cliente não quer perder a venda → terceira via de identificação
(`tb_no_doc`), também necessária para a sincronia com bases legadas sem
CPF/CNPJ (setes-sync).

**Fatos do código/DDL que ancoram a fase** (verificados 2026-07-15):
- `deleteInstitution` já preserva a cadeia (soft delete só do papel) ✅
- `tb_customer` JÁ EXISTE em `sql/03_schema_cliente_ddl.sql` com **PK composta
  `(id, tb_institution_id)`** — o papel de cliente é POR INSTITUTION (um schema
  pode abrigar filiais), FKs cross-schema para a central ✅
- Campos atuais da tb_customer: tb_salesman_id, tb_carrier_id, credit_status,
  credit_value, wallet, consumer, multiplier, by_pass_st, active

## Objetivos

1. Trocar o "sempre id novo" por **buscar-antes-de-criar**: CPF/CNPJ informado →
   procurar entity existente; achou → REAPROVEITAR o id para o novo papel;
   não achou → aí sim `MAX+1 FOR UPDATE`. Busca definitiva DENTRO da transação
   do salvar (o app busca ao sair do campo só para UX/prefill — decisão 9).
2. Permitir que a MESMA entity tenha vários papéis (institution, customer,
   provider, collaborator, bank, carrier...) em schemas/institutions distintos,
   sem duplicar a cadeia em `setes_central`.
3. Criar a terceira via de identificação **sem documento** (`tb_no_doc` +
   personType 'N'), com `external_id` para casar com registros do sincronizador.
4. Ajustar o fluxo do app: o cadastro inicia pela interface do papel
   (institution/customer/...), o tipo de pessoa (F / J / N) decide o caminho,
   e a busca por documento acontece ao sair do campo — prefill aberto a
   qualquer usuário autenticado É a feature (decisão 10).
5. Entregar **Customer** como primeiro papel novo validando o reuso ponta a
   ponta (decisão 8), com aba completa incluindo lookups de salesman/carrier
   (decisão 11).

## Workflow

O cadastro inicia pela interface do papel (institution/customer etc.):

| Tipo | Fluxo |
|---|---|
| **F — Pessoa Física** | Ao sair do campo CPF: `GET /api/entities/by-document` (decisão 3). Achou → prefill da cadeia + aviso informativo dos papéis existentes; salvar REUSA o id e atualiza a cadeia (decisão 1). Não achou → segue digitando; salvar cria cadeia nova (MAX+1). |
| **J — Pessoa Jurídica** | Idem, por CNPJ em tb_company. |
| **N — Sem documento** | Sem busca (não há chave para deduplicar). Salvar cria entity nova + tb_no_doc com external_id UUID v4 gerado no backend (decisão 5). |

Regras transversais:
- O app NUNCA manda entityId no POST: a API SEMPRE resolve pelo documento
  DENTRO da transação com lock (decisão 9) — o by-document do app é só UX.
- Entity já tem ESTE papel nesta institution → 409 "já cadastrado como <papel>"
  com o id no payload; o app oferece abrir em edição (decisão 2).
- Edição N→F/J (cliente informou o doc depois): permitida se o doc for inédito;
  doc já pertence a outra entity → 409 orientando correção manual (decisão 6).
- tb_mailing / tb_entity_has_mailing: FORA desta fase (decisão 7).

Sequência de persistência (cadeia atual + terceiro braço):
`tb_entity` → tb_address / tb_phone / tb_social_media →
tb_person OU tb_company OU tb_no_doc (exclusão mútua em `upsertFiscal`) →
tabela do papel (tb_institution, tb_customer...).

Referência de comportamento: Delphi `saveEntityFiscal` — se `Codigo = 0`,
`getIDbyCPF/CNPJ` preenche; `SaveEntity` sempre ATUALIZA os dados da entity
com o que está na tela (last-write-wins — decisão 1).

## DDL — tb_no_doc (setes_central)

Ajustada aos `PADROES_BANCO.md` (herança por PK compartilhada; deleted char(1);
sem AUTO_INCREMENT). Passar pela skill `database/skills/revisar-ddl.md` antes
de executar; entra nos scripts canônicos (`sql/02_*` central) e na migration.

```sql
CREATE TABLE tb_no_doc (
  id          INT(11)      NOT NULL,               -- PK = FK → setes_central.tb_entity.id
  external_id VARCHAR(255) NOT NULL,               -- UUID v4 (app) ou chave do legado (sync)
  created_at  DATETIME     DEFAULT NULL,
  updated_at  DATETIME     DEFAULT NULL,
  deleted     CHAR(1)      NOT NULL DEFAULT 'N',
  PRIMARY KEY (id),
  UNIQUE KEY uk_no_doc_external (external_id),
  CONSTRAINT fk_no_doc_entity FOREIGN KEY (id) REFERENCES tb_entity (id)
);
```

Rastro mínimo da decisão 1 (last-write-wins): coluna `updated_by INT(11) DEFAULT
NULL` (userId do JWT) nas tabelas da cadeia — tb_entity, tb_person, tb_company,
tb_no_doc, tb_address, tb_phone, tb_social_media. Populada pelos helpers de
escrita; sem FK (é rastro, não relacionamento). ⚠️ confirmada na decisão 1
("com ou sem" — incluída por custo baixo; remover se o Valdo preferir).

## Impactos no código

- **`shared/fiscal/`** — toggle vira TRIPLO F/J/N (decisão 4): tb_no_doc entra
  na peça (mesma responsabilidade: identificação da entity); `upsertFiscal`
  ganha o terceiro braço e mantém a exclusão mútua (trocar tipo = soft delete
  da especialização antiga + insert da nova, mesmo id); `PersonType` vira
  `'F' | 'J' | 'N'`; novo `NoDocRow` + repository (UUID v4 no insert).
- **Proteção pós-incidente (2026-07-16)**: nas listas da cadeia, payload SEM a
  lista (`undefined`) = NÃO TOCAR no banco; só `[]` explícito limpa os kinds.
  Motivo: um POST de teste sem as listas soft-deletou endereços/fones/redes da
  entity 1 via last-write-wins (rastreado pelo `updated_by`; dados restaurados).
- **`entity-fiscal.ts`** — `entityFiscalBody`: personType `z.enum(['F','J','N'])`,
  refinements do toggle cobrem N (nem person nem company); `saveEntityFiscalChain`
  ganha o ramo de REUSO (resolve id pelo doc dentro da transação ⚠️ Q9);
  `assertFiscalNotDuplicated` só permanece para os conflitos reais (edição com
  doc de outra entity; N→F/J com doc existente — decisão 6);
  `getEntityFiscalFull` deriva personType em 3 valores.
- **Novo endpoint compartilhado** `GET /api/entities/by-document?personType=F|J&doc=...`
  (decisões 3 e 10): devolve a cadeia completa + lista de papéis existentes
  (informativo). Montado com authMiddleware comum (qualquer usuário logado) —
  o prefill aberto É a feature; rate-limit existente contém varredura.
  Swagger obrigatório (regra 2026-07-12).
- **App `shared/entity/`** — SegmentedButton com 3 opções (F/J/Sem documento);
  modo N esconde bloco CPF/CNPJ/IE; ao sair do campo doc: by-document →
  achou → dialog "Entidade já cadastrada (papéis: ...) — carregar dados?" →
  prefill do draft. Validações de required por tipo.
- **Módulo customers (gêmeos app+API)** — padrão simétrico de 6 arquivos +
  skill cadastro-entidade-fiscal.md; repository filtra pela institution do JWT
  (PK composta id+tb_institution_id); aba específica COMPLETA (decisão 11):
  credit_status, credit_value, wallet, consumer, multiplier, by_pass_st,
  active + lookups de salesman e carrier no padrão countries/states
  (`shared/lookup`; usuário nunca digita id; campo readonly exibe o nome
  via JOIN — nome vem de setes_central.tb_entity).
- **DDL canônica de tb_salesman e tb_carrier** (decisão 11): as tabelas existem
  no banco legado SEM primary key (dump colado pelo Valdo na Rodada 2) — a
  versão canônica entra em `sql/03_schema_cliente_ddl.sql` + migration com
  PK `(id, tb_institution_id)`, FK cross-schema `id → setes_central.tb_entity(id)`
  e colunas padrão, no molde da tb_customer. Campos do legado preservados:
  salesman (active, aliq_kickback, kickback_product, flex_value) e carrier
  (active). Passar pela skill revisar-ddl. A FK/índice de tb_customer.tb_carrier_id
  ("implementação futura" no script) é ativada nesta fase.
- **Institution** — refatorado para o fluxo novo (busca antes de criar); resto
  intacto (onboarding/migrações não mudam).

## Decisões arquiteturais registradas

1. **Reuso com last-write-wins** (2026-07-15): ao reaproveitar entity existente,
   o salvar do novo papel ATUALIZA os dados compartilhados da cadeia (como o
   Delphi). Governança fina (permissão por origem, aprovação, campos travados)
   fica para fase futura, baseada em necessidade real. Rastro mínimo:
   `updated_by` nas tabelas da cadeia (Valdo delegou "com ou sem" — incluída
   por custo baixo).
2. **Papel duplicado** (2026-07-15): entity já tem o papel NESTA institution →
   409 "já cadastrado como <papel>" com o id no payload; o app oferece abrir o
   registro em edição. (Refinado: por INSTITUTION, não por schema — PK da
   tb_customer é `(id, tb_institution_id)`.)
3. **Busca por documento** (2026-07-15): endpoint ÚNICO compartilhado
   `GET /api/entities/by-document?personType&doc`, devolvendo cadeia completa +
   papéis existentes; papéis são só INFORMATIVOS (não bloqueiam).
4. **personType 'N' dentro de fiscal/** (2026-07-15): terceiro valor do enum é
   `'N'` (UI "Sem documento"); tb_no_doc vive na peça `shared/fiscal/` — mesma
   responsabilidade (identificação da entity), exclusão mútua F/J/N em UM lugar
   (`upsertFiscal`).
5. **tb_no_doc universal** (2026-07-15): TODA entity sem documento ganha linha
   em tb_no_doc; app gera `external_id` UUID v4 no backend; o sincronizador
   enviará a chave do legado como external_id (fase própria).
6. **Upgrade N→F/J sem merge** (2026-07-15): permitido quando o doc informado
   é inédito; doc já pertencente a outra entity → 409 orientando correção
   manual. Merge de cadastros distintos NÃO será construído ("não tem como dar
   merge em cadastros distintos" — Valdo).
7. **tb_mailing fora** (2026-07-15): tb_mailing/tb_entity_has_mailing não entram
   nesta fase (ortogonal à unicidade; aba E-mails segue em rodada futura).
8. **Escopo de entrega** (2026-07-15): refatorar cadeia + Institution para o
   fluxo novo e entregar **Customer** como primeiro papel novo; validação ponta
   a ponta = cadastrar a Setes como customer dela mesma em setes_setes
   reaproveitando a entity 1.
9. **POST sem entityId** (2026-07-15): o app NUNCA manda entityId no criar — a
   API SEMPRE resolve pelo documento DENTRO da transação com lock. O
   by-document é só prefill de UX. Fonte da verdade única, imune à corrida e a
   payload adulterado.
10. **Prefill aberto É a feature** (2026-07-15, palavras do Valdo): "qualquer
    cliente da Setes que tenha o número do CNPJ pode cadastrar como seu próprio
    cliente — essa é a beleza de não ter dados duplicados". Ex.: um cliente da
    Setes, ao digitar o CNPJ da Setes pela primeira vez, recebe o cadastro
    preenchido automaticamente usando o tb_entity.id existente.
    `/api/entities/by-document` com authMiddleware comum; cadeia completa no
    retorno; rate-limit existente contém varredura.
11. **Customer com aba completa + lookups** (2026-07-15): tb_salesman e
    tb_carrier EXISTEM no banco legado — o lookup segue o padrão
    countries/states (lista de apoio filtrável, campo readonly exibe o nome).
    As telas de CADASTRO de Salesman e Carrier ficam para outro momento, mas
    JÁ ENTRAM NA PROGRAMAÇÃO (onda 2 da fase ou fase seguinte — ambos derivam
    da cadeia fiscal e validam ainda mais o reuso). DDL canônica das duas
    tabelas entra NESTA fase (com PK/FKs que faltam no legado).
12. **Modelo central puro no schema do cliente** (2026-07-15, Rodada 3 —
    problema descoberto ao aplicar): o 001_baseline criava cópias LOCAIS da
    cadeia de entidade no schema do cliente, com tb_customer/tb_salesman
    apontando FKs para elas. Decisão do Valdo: (i) FKs de tb_customer/
    tb_salesman/tb_carrier realinhadas para setes_central (migration
    005_entidade_unica.sql); (ii) cópias locais de tb_entity/tb_person/
    tb_company/tb_address/tb_phone/tb_social_media/tb_mailing*/tb_linebusiness
    DROPADAS (núcleo cadastral do sql/04 absorvido no pipeline automático);
    (iii) tb_user/tb_institution locais PERMANECEM por ora (14+3 FKs
    operacionais do legado dependem delas); (iv) **ANOTADO para a revisão do
    sync**: os ids do Firebird deverão ser REINDEXADOS — no Firebird não há
    entity e o objeto enviado não se parece com as tabelas de origem; cada
    cliente/fornecedor vindo do setes-sync será reindexado por cpf/cnpj ou
    tb_no_doc.external_id. Endpoints /sync que gravavam nas cópias locais
    (customer, ordersale...) ficam pendentes dessa revisão.
13. **Institution nasce cliente da Setes** (Valdo, 2026-07-16): o cadastro de
    Institution é EXCLUSIVO do módulo Super (um único usuário). Todo
    institution criado ganha, NA MESMA transação do onboarding, uma linha em
    `setes_setes.tb_customer` (tb_institution_id = 1) — administração do
    contrato. Racional: setes_central e setes_setes "nascem casados" (são a
    estrutura para criar clientes); clientes DE VERDADE são os institutions,
    não a própria Setes. Idempotente (ON DUPLICATE revive). Implementação:
    institutions.repository.insertInstitutionCascade + constante SETES_SCHEMA
    em @shared/auth/roles.

### Rodada 4 — Tributação por entidade (Valdo, 2026-07-16)

14. **tb_entity_tax por RELAÇÃO COMERCIAL** (schema do cliente, PK composta
    `id + tb_institution_id`, FKs cross-schema): QUALQUER entidade pode
    precisar de tributação para receber notas — não só clientes. Migration
    006_entity_tax.sql; canônico em sql/03.
15. **Valores canônicos**: `iss_exigibilidade CHAR(2)` com os 7 códigos do
    legado (01 Exigível … 07 Susp. administrativa — dropdown, não S/N);
    `tax_regime VARCHAR(100)` = CRT unificado (duplicidade do Delphi
    eliminada), dropdown com 4 rótulos canônicos — grava o RÓTULO completo,
    código NFe = 1º caractere (Lucro Real e Presumido compartilham o 3);
    `ind_ie_dest CHAR(1)` ∈ {1, 2, 9}.
16. **Campos fiscais SAEM da setes_central.tb_company** (fonte única =
    tb_entity_tax): crt, crt_modal, ind_ie_destinatario, iss_*,
    send_xml_nfe_only dropados da central (bootstrap ensureColumnDropped) —
    dados da base existente copiados ANTES (migration 006 copia
    consumer/by_pass_st do customer; one-off copiou os fiscais da company).
    tb_company fica: cnpj, ie, im, iest, dt_foundation.
17. **Peça compartilhada `shared/entity-tax`** (types/dto/repository, aceita
    conn OU pool): a aba Tributação salva JUNTO com o papel na MESMA transação
    (`tax` aninhado no payload do customer; omitido = não tocar). Endpoints
    avulsos p/ papéis futuros: GET/PUT /api/entities/:id/tax.
18. **wallet vira tb_payment_types_id** (INT NOT NULL DEFAULT 0): UI radiobox
    Sim/Não; 'S' → a API garante a forma de pagamento "Carteira"
    (fiado/pendurado) via autocreate MAX+1 com id_nfce '05' (Crédito Loja) —
    porta do `Fc_PegaFormaPgto` do Delphi; 'N' → 0. Objetivo: cliente comprar
    sem pagar na hora (tratativa no módulo de vendas). GET devolve `wallet`
    DERIVADO (id > 0).
19. **tb_customer emagrece**: consumer/by_pass_st migraram para tb_entity_tax;
    credit_status = radiobox [L]iberado/[B]loqueado (Zod restringe);
    multiplier NOT NULL DEFAULT 1; active DEFAULT 'S'.

## ⚠️ Questões pendentes (Rodada 2)

**Nenhuma.** Prompt pronto para fechamento (mover para
`Infra-IA/setes-api/prompt_fase3_entidade_unica.md` e executar).

## Fora de escopo desta fase

- Merge/fusão de entidades duplicadas (decisão 6 — não será construído)
- Integração do sincronizador gravando entities com external_id (fase própria
  do setes-sync — aqui só nasce a tabela pronta)
- Governança fina de edição dos dados compartilhados (decisão 1)
- Aba E-mails / tb_mailing (decisão 7)
- Papéis provider, collaborator, bank (decisão 8 — só Customer nesta fase)
- Telas de cadastro de Salesman e Carrier (decisão 11 — programadas para a
  onda 2 / fase seguinte; nesta fase entram DDL canônica + lookups)

## Critérios de sucesso

1. Cadastrar customer com o CNPJ da Setes em setes_setes NÃO cria entity nova —
   reaproveita o id 1 e cria só a linha em tb_customer (com prefill automático
   da cadeia ao digitar o CNPJ)
2. Cadastrar com CPF/CNPJ inédito cria a cadeia completa (comportamento atual preservado)
3. Cadastro sem documento cria entity + tb_no_doc com external_id UUID único
4. Papel duplicado na mesma institution → 409 com id; app oferece abrir em edição
5. Edição N→F/J com doc inédito migra a especialização; com doc existente → 409
6. Corrida de dois POSTs com o mesmo CNPJ termina com UMA entity e os dois papéis
   (ou 409 do papel duplicado) — nunca duas entities
7. Lookups de salesman/carrier funcionais no form do Customer (padrão
   countries/states), nome exibido via JOIN com setes_central.tb_entity
8. tsc limpo, testes verdes (incluindo os 4 do onboarding), Swagger das rotas
   novas visível no /docs, flutter analyze limpo
9. DDLs (tb_no_doc, tb_salesman, tb_carrier canônicas, updated_by) aprovadas
   pela skill revisar-ddl; scripts canônicos sql/ e migrations atualizados
