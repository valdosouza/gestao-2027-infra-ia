# Skill: Cadastro complexo com cadeia de entidade fiscal (ObjectEntity → ObjectEntityFiscal → Concreto)

**Status**: Vigente (2026-07-11; hierarquia de papéis registrada 2026-07-17)
**Objetivo**: Gerar cadastros que herdam a cadeia fiscal (Institution, Customer, Provider, Carrier, Collaborator→Salesman, Bank)
**Referências**: `ARQUITETURA_MODULOS.md` (app), `Infra-IA/setes-api/ARQUITETURA_MODULOS_API.md` (API),
legado `Infra-IA/codigo-aprendizado/weberpsetes/lib/app/modules/customer_register` (UI de referência)
**Primeiro caso real**: Institution/Estabelecimento (2026-07-11)
**Escopo**: setes

---

## A cadeia no banco (herança por PK compartilhada — decisão 1 da Fase 2)

```
tb_entity (id, name_company, nick_trade, aniversary, tb_linebusiness_id, note)
├── tb_person  (id FK→entity, cpf UNIQUE, rg, birthday...)        ← Pessoa Física
├── tb_company (id FK→entity, cnpj UNIQUE, ie, im, crt...)        ← Pessoa Jurídica
├── tb_address      (PK id+kind, id FK→entity, FKs país/UF/cidade, main)
├── tb_phone        (PK id+kind, id FK→entity)          ⚠️ SINGULAR, não tb_phones
├── tb_social_media (PK id+kind, id FK→entity)
├── tb_entity_has_mailing (N:N com tb_mailing + tb_mailing_group) ← fora até 2ª rodada
└── concretos: tb_institution / tb_customer / tb_provider / tb_carrier / tb_collaborator / tb_salesman / tb_bank
    (id FK→entity + campos específicos; ver "Hierarquia de papéis" abaixo)
```

## Hierarquia de papéis concretos (Valdo, 2026-07-17)

```
ObjectEntity
└── ObjectEntityFiscal
    ├── Customer
    ├── Provider
    ├── Carrier
    ├── Bank
    ├── Institution
    └── Collaborator          ← pode ser SÓ administrativo
        └── Salesman          ← precedência OBRIGATÓRIA: todo vendedor É colaborador
```

- Herança por PK em TODOS os níveis: `tb_salesman.id` = `tb_collaborator.id` = `tb_entity.id`.
- **Estado atual do DDL** (sql/03): `tb_salesman`, `tb_carrier` e `tb_collaborator`
  (criada 2026-07-18 — migration 008; campos do legado tblCollaborator.pas
  reescritos, typo fahters_name corrigido p/ fathers_name) existem no schema do
  cliente com PK `(id, tb_institution_id)` e FK `id → setes_central.tb_entity`.
  Precedência Collaborator→Salesman AINDA PENDENTE: será instituída na
  APLICAÇÃO quando o cadastro de salesman nascer (criar salesman exige o
  colaborador; FK física descartada por ora — schemas com salesman sincronizado
  do legado a inviabilizam).
- **Uso em sessão**: "é vendedor" = `EXISTS tb_salesman WHERE id = userId (JWT) AND
  tb_institution_id = institutionId (JWT) AND deleted='N'` — possível hoje graças à
  herança por PK (`tb_user.id` = `tb_entity.id`); é a base do filtro de carteira do
  framework de configurações (prompt_framework_configuracoes_sistema.md).

REGRAS que derivam do DDL:
- Filhas de apoio têm PK `(id, kind)`: id = id da ENTITY; "vários registros" = vários kinds.
  A UI deve impedir kind duplicado; trocar o kind = soft delete do antigo + insert do novo.
- PF×PJ é TOGGLE: preenche tb_person OU tb_company (CPF/CNPJ válido decide). Trocar o tipo
  na edição = soft delete da especialização antiga + insert da nova (mesmo id).
- id da entity: `SELECT COALESCE(MAX(id),0)+1 FROM tb_entity FOR UPDATE` DENTRO da transação.
- Soft delete SEMPRE (deleted='S'); licença/status por `active` quando a tabela tiver.

## Domínio (iguais no app e conceituais na API)

- `ObjectEntity` — entity + List<Address> + List<Phone> + List<SocialMedia>
- `ObjectEntityFiscal extends ObjectEntity` — + person? | company? + personType (F/J)
- `ObjectInstitution extends ObjectEntityFiscal` — + campos de tb_institution (schemaName, active)
  (Customer/Provider/Collaborator/Bank: mesmo desenho, cada um no SEU módulo)

App: as classes base (`object_entity.dart`, `object_entity_fiscal.dart` + Address/Phone/SocialMedia)
vivem em `app/shared/entity/domain/` — usadas por 5+ módulos (regra de promoção). A concreta
(`object_institution.dart`) vive no módulo dela.

## UI (app) — form com ABAS (caso de grupos naturais da criar-formulario-cadastro.md item 2)

```
SetesFormShell (voltar/título/check/delete — contrato visual intacto)
└── TabBar + TabBarView
    ├── Principal      → EntityMainTab   (COMPARTILHADA — app/shared/entity/widgets/)
    ├── Endereços      → AddressListTab  (COMPARTILHADA)
    ├── Fones          → PhoneListTab    (COMPARTILHADA)
    ├── Redes Sociais  → SocialMediaTab  (COMPARTILHADA)
    └── [Específica]   → do módulo (ex.: InstitutionTab) — ÚNICA aba não compartilhada
```

**Semântica da aba Principal (decisão do Valdo, 2026-07-18 — vale para TODOS
os cadastros da cadeia; implementada UMA vez na EntityMainTab compartilhada):**
- O toggle **Pessoa Física / Pessoa Jurídica / Sem Documento vem PRIMEIRO** —
  ele redefine os rótulos dos campos seguintes (semântica mantém a coerência).
- Rótulos dos campos de tb_entity por tipo:
  | Campo | PF e Sem Documento | PJ |
  |---|---|---|
  | name_company | Nome Completo (`forms.entity.nameCompanyPerson`) | Razão Social (`forms.entity.nameCompany`) |
  | nick_trade | Apelido (`forms.entity.nickTradePerson`) | Nome Fantasia (`forms.entity.nickTrade`) |
- **UMA data só por tipo** (refinado no mesmo dia — sem duplicidade):
  PF = Data de Nascimento (person.birthday), PJ = Data de Fundação
  (company.dt_foundation), Sem Documento = Aniversário (entity.aniversary —
  o campo da entity SÓ aparece no modo 'N').
- As mensagens de campo obrigatório do `_save` das páginas usam a MESMA chave
  dinâmica por personType (customer/collaborator/institution são o modelo).

Contrato de genericidade das abas compartilhadas (Step 3 do spec — ZERO mudança p/ reutilizar):
- Recebem DADOS + CALLBACKS (`value` + `onChanged`), tipados nas classes de `shared/entity/domain`.
- NUNCA importam bloc/entidade/datasource de módulo concreto (grep de `modules/` dentro de
  `shared/entity/` deve voltar vazio).
- O rascunho (draft) do objeto completo vive no BLOC do módulo concreto; as abas só editam
  as fatias que recebem. Salvar = 1 evento com o objeto inteiro.
- Lookups de UF/cidade nas abas usam `shared/lookup` (já existente).

## API — cascade em transação ÚNICA (cadeia em `src/shared/entity/`)

A cadeia na API é COMPARTILHADA sob `setes-api/src/shared/` (espelho do
`app/shared/entity/` do app — extração de 2026-07-12; desacoplada em peças
SOLID e depois CADA OBJETO NA SUA PASTA, feedbacks do Valdo no mesmo dia):

```
src/shared/
├── address/       address.types|dto|repository.ts  ← SÓ tb_address (syncAddresses, listAddresses)
├── phone/         phone.types|dto|repository.ts    ← SÓ tb_phone (syncPhones, listPhones)
├── social-media/  social-media.types|dto|repository.ts ← SÓ tb_social_media
├── fiscal/        fiscal.types|dto|repository.ts   ← SÓ person/company (FiscalInput, upsertFiscal,
│                                                      getPerson/getCompany)
└── entity/        entity.types|dto|repository.ts   ← SÓ tb_entity (nextEntityId, insert/updateEntity,
               │                                       getEntityBase)
               ├── entity-fiscal.ts  ← COMPOSIÇÃO: EntityFiscalInput/Full, entityFiscalBody,
               │                       withFiscalRefinements, saveEntityFiscalChain, getEntityFiscalFull
               └── index.ts          ← barrel da CADEIA — consumidores importam de '@shared/entity'
```

**Direção de dependência (inegociável)**: composição → peças. address/phone/
social-media/fiscal NUNCA importam nada de entity/ — recebem `conn` +
`entityId` + lista (o vínculo com a entity é só o parâmetro);
`entity-fiscal.ts` é o ÚNICO que importa as peças (paths relativos
`../address/...`). ISP: quem precisa só de telefones importa
`@shared/phone/phone.repository` sem carregar a cadeia.

- O concreto ESTENDE os tipos compostos (`InstitutionInput extends
  EntityFiscalInput`, `InstitutionFull extends EntityFiscalFull`) e importa
  do barrel `'@shared/entity'`.
- DTO do concreto: `withFiscalRefinements(entityFiscalBody.extend({...}))` —
  refinements SEMPRE por último (`.extend` não existe em ZodEffects).
- Escrita TRANSACTION-AWARE (1º parâmetro = `conn`); leitura
  `getEntityFiscalFull(id)` usa pool (3 listas deleted='N', DATE_FORMAT nas datas).

A cadeia opera SEMPRE em setes_central (fato do DDL: o schema do cliente tem
só a tabela concreta, FK cross-schema para setes_central.tb_entity) — por
isso os helpers não recebem schema. **O repository do CONCRETO só orquestra**:

```ts
const conn = await pool.getConnection()
await conn.beginTransaction()
try {
  // Fase 3 (Entidade Única): busca-antes-de-criar DENTRO da transação —
  // CPF/CNPJ conhecido REUSA a entity (reused=true) e atualiza a cadeia
  // (last-write-wins); inédito → MAX+1 FOR UPDATE. Toggle F/J/N (N =
  // tb_no_doc + UUID). updatedBy = userId do JWT (rastro).
  const { id, reused } = await saveEntityFiscalChain(conn, idOuNull, input, updatedBy)
  // Papel duplicado (decisão 2 da Fase 3): 409 com o id em fields[0] —
  // checar a PRÓPRIA tabela antes do INSERT (modelo: customers.repository).
  // INSERT/UPDATE tabela concreta (tb_institution, tb_customer...)
  await conn.commit()
} catch (e) { await conn.rollback(); throw e } finally { conn.release() }
```

Prefill (Fase 3): `GET /api/entities/by-document?personType=F|J&doc=` devolve a
cadeia completa + papéis (informativos) para o app pré-preencher ao sair do
campo — o POST NUNCA envia entityId (decisão 9; a API resolve de novo com lock).

- Módulo no padrão simétrico de 6 arquivos (novo-modulo.md); shared/entity
  NUNCA importa módulo (mesma regra do app — grep limpo).
- GET :id: `getEntityFiscalFull(id)` + campos da tabela concreta compostos
  no repository do módulo.
- Efeitos PÓS-commit (ex.: provisionar schema) NUNCA dentro da transação (DDL não tem rollback).

## Caso Institution (Estabelecimento) — decisões do Valdo 2026-07-11

- POST absorve o onboarding: cadeia em transação → commit → `runMigrationsForSchema(schemaName)`
  → active='S' só se a migração passar (falhou: institution fica active='N' e o erro volta ao app).
  `POST /api/admin/institutions` (onboarding antigo) foi APOSENTADO; GET/PUT de
  interfaces/feature-flags continuam no admin.
- schema_name: imutável na edição; padrão `setes_<nome>`.
- Aba E-mails: fora desta rodada.

## Caso real: Institution/Estabelecimento (2026-07-11 — 1ª implementação da cadeia)

Entregue no padrão desta skill; o que ficou de REUTILIZÁVEL para os próximos
(Customer/Provider/Collaborator/Bank):

- **`app/shared/entity/`** criado: `domain/object_entity.dart` (ObjectEntity +
  EntityAddress/EntityPhone/EntitySocialMedia com fromJson/toJson),
  `domain/object_entity_fiscal.dart` (PersonData/CompanyData/ObjectEntityFiscal
  com copyWith; datas com wrapper `String? Function()?` para permitir limpar;
  `cpfDigits`/`cnpjDigits` tiram máscara no toJson). Grep de `modules/` dentro
  de shared/entity volta VAZIO (contrato de genericidade validado).
- **4 abas compartilhadas** em `shared/entity/widgets/`: `entity_main_tab.dart`
  (toggle PF/PJ com SegmentedButton, fora do Tab), `address_list_tab.dart`
  (lookups país/UF/cidade — cidade DEPENDENTE, SnackBar pede a UF),
  `phone_list_tab.dart`, `social_media_list_tab.dart` + apoios
  `entity_list_common.dart` (EntityListScaffold com FAB heroTag próprio por aba,
  kindValidator de unicidade, confirmação de remoção) e `entity_date.dart`
  (dd/mm/aaaa ↔ ISO). Módulo concreto entra só com a aba específica + bloc.
- **Draft no bloc**: `InstitutionFormState(draft, creating, saving)` +
  `InstitutionDraftChanged` a cada fatia editada; abas podem ser desmontadas
  pelo TabBarView sem perder nada (reconstroem do draft). Validação do salvar
  é PROGRAMÁTICA no form view (as abas podem não estar montadas — Form.validate
  não alcança); chave nova `register.requiredField` ("Preencha o campo: {}").
- **SetesTextField ganhou `onChanged`** (setes_widgets) — necessário para as
  abas empurrarem fatias ao draft.
- **`city_lookup_*` em shared/lookup**: `list(filter, {required stateId})` —
  GET /api/cities?filter=&stateId= (1º lookup dependente do shared).
- **API institutions/**: cascade em transação única (MAX+1 FOR UPDATE, upsert
  do toggle fiscal com soft delete da especialização trocada, diff por kind nas
  3 listas via INSERT ... ON DUPLICATE KEY UPDATE + deleted='S' nos ausentes).
  Datas SEMPRE com `DATE_FORMAT(x, '%Y-%m-%d')` no SELECT (senão o driver
  devolve Date com timezone). POST: cadeia → flags padrão → migração → active='S'
  (falhou: fica 'N' e HttpError 500 explica). `insertDefaultFlags` MIGROU do
  admin para institutions.repository. **2026-07-12**: a lógica da cadeia foi
  EXTRAÍDA para `src/shared/entity/` (seção API acima) — institutions virou
  consumidor (transação + tb_institution + flags; ~570 linhas viraram ~240).
- **Aposentado**: POST /api/admin/institutions + onboardInstitution
  (onboarding absorvido pelo cadastro); GET /admin/institutions e
  interfaces/feature-flags do admin permanecem. onboarding.test.ts reescrito
  para o service novo (4 casos, incluindo migração falhando → active='N').
- **Aba Usuários — 2026-07-12** (workflow do Valdo): 7ª aba
  (`institution_users_tab.dart`) — com muitos institutions, o Super libera o
  1º admin do cliente DAQUI: lista filtrada (GET /api/users?institutionId=) +
  botão + abre o dialog de cadastro com o institution IMPLÍCITO (POST com
  institutionId+kind — vínculo criado na MESMA transação da API). Consome
  `app/shared/users/` (entities+datasource PROMOVIDOS — regra de promoção,
  2º consumidor depois do módulo users). Guard da API virou adminGuard:
  admin do cliente gerencia os usuários do PRÓPRIO institution pelo módulo
  Sistema (escopo forçado no service; seção Estabelecimentos só p/ super).
- **Aba Interfaces (contrato comercial) — 2026-07-12**: 6ª aba do form
  (`institution_interfaces_tab.dart`), CRUD AUTÔNOMO fora do draft do bloc
  (precedente dos privilégios da tela Interfaces): consome os endpoints
  existentes GET/PUT /api/admin/institutions/:id/interfaces via
  InstitutionDatasource; cada toggle sincroniza na hora (PUT com a lista
  completa — a API concede e revoga com soft delete), com rollback local no
  erro; cabeçalhos por group_default. Só na EDIÇÃO (na inclusão o schema do
  cliente ainda não existe — a aba orienta salvar primeiro). Padrão a repetir
  em abas de vínculo que gravam FORA da transação da cadeia fiscal.

## Fase 3 — Entidade Única no APP (2026-07-15): toggle F/J/N + prefill + Customer

Segundo concreto entregue: **Customer** (`app/modules/customers/` — espelho de
institutions com 5 abas; aba específica CustomerTab com lookups salesman/carrier).
O que ficou de REUTILIZÁVEL para Provider/Collaborator/Bank:

- **Toggle TRIPLO F/J/N** na EntityMainTab (decisão 4): modo 'N' esconde o bloco
  fiscal; `NoDocData.externalId` é SOMENTE LEITURA (backend gera UUID v4);
  `fiscalToJson` com 'N' não envia person nem company. `ObjectEntityFiscal`
  ganhou `noDoc` + factory `fromChainJson(json)` (mesmo shape do GET :id e do
  by-document) — concreto novo: lembrar `super.noDoc` no construtor, `noDoc` no
  copyWith/mergeFiscal/fromJson.
- **Prefill by-document** (decisões 3/9/10): `shared/entity/data/
  entity_by_document_datasource.dart` (GET /api/entities/by-document; bind no
  Module de quem usa). A EntityMainTab recebe `byDocumentLookup` + `prefillEnabled`
  (true SÓ na criação): ao sair do campo CPF/CNPJ (wrapper `Focus` com
  `skipTraversal`/`canRequestFocus:false` + onFocusChange) com documento VÁLIDO
  (SetesValidators.isValidCpf/Cnpj), consulta e oferece dialog "Entidade já
  cadastrada (papéis) — carregar?"; sim = draft inteiro + controllers
  sincronizados. O id encontrado NUNCA entra no draft (o app não envia entityId —
  a API resolve o reuso na transação). Falha da consulta é silenciosa (é só UX).
- **POST devolve `{ id, reused }`**: reused=true → SnackBar informativo
  ('forms.customer.reusedEntity'); **409 de papel duplicado** (decisão 2) chega
  como `{ error, fields:[{field:'id', message:'<id>'}] }` — `Failure` (core)
  ganhou `fields`/`fieldMessage()`; o bloc emite one-shot `<X>DuplicateRole(id)`
  e a página oferece abrir em edição (dispara `<X>EditPressed(id)`).
- **Lookups de papel** em `shared/lookup`: `role_lookup_entity.dart` (RoleLookup
  id+name) + `salesman_lookup_datasource` / `carrier_lookup_datasource`
  (/api/customers/salesman-lookup|carrier-lookup — nome via JOIN tb_entity).
- **Menu do cliente**: interface 'customers' id 9, `group_default='Registers'`
  (chave de menu.groups → pt "Cadastros"), seed `sql/08_customers_interface_seed.sql`
  (tb_interface + contrato setes_setes + flag técnica 'customers' p/ institutions
  existentes; novas ganham via insertDefaultFlags).

## Onda 2 — Colaborador no APP e na API (2026-07-18)

Terceiro concreto entregue: **Collaborator** (`app/modules/collaborators/` +
`setes-api/src/modules/collaborators/`) — espelho FIEL do customers SEM a aba
Tributação (exclusiva do Customer) e SEM lookups de papel. Confirmou o molde:

- 5 abas (4 compartilhadas + CollaboratorTab: admissão/demissão dd/mm/aaaa via
  entity_date, salário decimal, filiação, título de eleitor, certificado
  militar, PIS, ativo); prefill by-document na criação; 409 de papel duplicado
  com "abrir cadastro".
- API: cascade `saveEntityFiscalChain` + tb_collaborator na mesma transação;
  DATE_FORMAT nas datas do GET; flag técnica 'collaborators'
  (insertDefaultFlags + seed sql/10 p/ institutions existentes); interface 12
  grupo 'Registers'.
- ⚠️ Lição (fix no mesmo dia): o 001_baseline.sql JÁ criava uma
  tb_collaborator legada (typo fahters_name) — a migration 008 virou
  DROP + CREATE canônico (realinhamento). Papel novo em schema de cliente:
  SEMPRE conferir se o baseline legado já tem a tabela (item novo do
  revisar-ddl.md).
- Custo de um papel novo SEM fatia extra: ~15 arquivos, zero mudança nas abas
  compartilhadas (contrato de genericidade validado pela 3ª vez).

## Fase 3 Rodada 4 — Tributação por entidade no APP (2026-07-17)

Aba "Tributação" no customers (tb_entity_tax — decisões 14–19). O que fica de
padrão para os próximos papéis (provider/collaborator):

- **`tax` é FATIA aninhada do concreto**: `EntityTaxData` (10 campos, nasceu em
  `customers/domain/entity/object_customer.dart` — promover a shared/entity
  quando o 2º papel precisar) com fromJson/toJson/copyWith; o GET :id devolve
  `tax` null quando a relação não tem tributação, mas o form SEMPRE envia
  (`toJson` usa `tax ?? const EntityTaxData()` — omitir = API não toca).
  A aba (`customer_tax_tab.dart`) recebe `value: draft.tax ?? EntityTaxData()`
  + `onChanged: (tax) => draft.copyWith(tax: tax)` — mesmo contrato das outras.
- **consumer/byPassSt NÃO existem mais no nível do customer** (migraram p/ tax);
  `wallet` é INTENÇÃO 'S'/'N' (radiobox Sim/Não com helperText) — a API resolve
  tb_payment_types_id/"Carteira" sozinha (decisão 18); creditStatus radiobox
  'L'/'B'; multiplier vazio assume 1 no toJson (DEFAULT do banco).
- **Dropdowns canônicos gravam o VALOR canônico** (rótulo completo no
  taxRegime — o CRT NFe é o 1º caractere; indIeDest '1'/'2'/'9';
  issExigibilidade '01'..'07'): constantes `kTaxRegimes`/`kIndIeDestCodes`/
  `kIssExigibilidadeCodes` no entity (espelho de entity-tax.types.ts da API);
  exibição via i18n (mapa valor→chave); valor fora do domínio cai para null
  no dropdown em vez de quebrar o build (`_known`).
- **Radiobox S/N** = `SetesRadioGroup<String>` com `register.yes`/`register.no`
  (chaves genéricas novas); checkbox continua SetesCheckbox (bool no domínio,
  'S'/'N' no toJson).

## Checklist de saída (além do checklist padrão dos módulos)

- [ ] Abas compartilhadas sem NENHUM import de módulo concreto (grep limpo)
- [ ] Toggle PF/PJ alterna campos na aba Principal e o upsert fiscal na API
- [ ] Kinds únicos por lista; remoção da UI = deleted='S' no banco (nunca DELETE)
- [ ] Transação única com FOR UPDATE no MAX+1; rollback testado (payload inválido no meio)
- [ ] Reuso validado: instanciar as abas com dados de outro cadastro não exige mudança nelas
