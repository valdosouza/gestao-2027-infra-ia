# Prompt — Fase 2: Gerenciamento Central (Superusuário e Cadastro Unificado)
**Escopo**: setes

## Contexto

A Setes, desenvolvedora e mantenedora do sistema, também será **cliente do próprio sistema**.
Esta fase reorganiza a base `setes_central` (criada na Fase 1) para suportar:

- Login unificado (Setes e clientes logam pela mesma tela, autenticando em `setes_central`)
- Cadastro unificado
              Em setes_central
                Entidade do sistema como um todo para todos 
                    Todos os institutions herdaram dados daqui e alimentaram esses dados com novas informacoes
                Essa entidade sera um institution do sistema capaz de gerenciar um ERP com cliente, fornecedores, colaboradore etc
                Esse institution sera um tenant (por isso adaptar institution para nao ter duplicidade de responsabilidade)

- Interface UI do módulo **Super** (exclusivo do superusuário)
- Tabelas de referência centralizadas , sem replicação por schema

**Conceito central:** 
    `tb_entity` = tblEntity -> tabela/model que inicia a representacao de algo
    ObjEntity é o agrupamento de outros model's que comeca a incorpar a informacao deixando ela mais substancial
      `tb_entity`
      TListAddress -> `tb_address` ;
      `tb_mailing`
      `tb_social_media`;
      TListPhone -> `tb_phone`
    
      representa todo mundo que usa o sistema — usuário, institution, customer, provider, carrier, bank etc

    ObjEntityFiscal herda de ObjEntity e recebe outras especializacoes como tb_company or tb_person
      tb_company define a entidade como uma pessoa juridica que possue um cnpj "Documento fiscal do Brasil que o qualifica"
      tb_person define a entidade como uma pessoa fisica que possue um cpf "Documento fiscal do Brasil que o reconhece a existencia da pessoa real"     
---

## Objetivos

1. **Migrar `tenants` → `tb_institution`**: levar a estrutura/dados da tabela `tenants` para `tb_institution` (criando os campos necessários) e remover `tenants`.
2. **Padronizar nomenclatura**: todas as tabelas de `setes_central` iniciam com `tb_`.
3. **Preparar os bancos** para a UI de Superusuário iniciar os cadastros.
4. **Cadastro de cliente** com referência nas duas bases:
   - `setes_central`: `tb_entity` (nome/apelido) + `tb_company` **ou** `tb_person` (PJ/PF) + `tb_address` (múltiplos endereços) + `tb_institution` (licenças; indexa operações do cliente via `tb_institution_id`)
   - `setes_<schema>`: `tb_customer` originado de `tb_entity`
   - Um único cadastro registra uma entity que pode ser especializado por heranca em setes_<schema>Customer, (setes_central.(Institution/Tenant).
5. **Cadastro de usuário** para permitir o login do cliente.

---

## Workflow

### 1. Login por tela única (fluxo multi-institution)

Setes e clientes autenticam na mesma tela, contra `setes_central`.
Nomenclatura padronizada: **todo tenant é uma institution** — o JWT passa a usar `institutionId` (a Fase 1 usava `tenantId`; ver Impacto na Fase 1 abaixo).

**Passo 1 — `POST /auth/login`** (público, sem JWT). Body: `email` + `password`.

- Backend aplica MD5 na senha e executa o select de autenticação (email do grupo 2 = "sistema")
- Falha → `401`

**Passo 2 — Buscar as institutions do usuário:**

```sql
SELECT i.id AS institutionId, i.schema_name AS schemaName, e.nick_trade AS name, ihu.kind AS profile
FROM tb_institution_has_user ihu
  INNER JOIN tb_institution i ON (i.id = ihu.tb_institution_id)
  INNER JOIN tb_entity e      ON (e.id = i.id)
WHERE ihu.tb_user_id = :userId
  AND ihu.active = 'S' AND ihu.deleted = 'N'
  AND i.active   = 'S' AND i.deleted   = 'N';
```

**Passo 3 — Decidir pela quantidade de institutions:**

| Resultado | Ação |
|---|---|
| 0 institutions | `403` — usuário sem institution ativa (licença inativa) |
| 1 institution | Emite o **JWT final** direto |
| N institutions | Retorna `200` com a **lista** + um **token de seleção** (JWT temporário: só `userId`, escopo `select-institution`, TTL 5 min). UI exibe "Escolha a empresa" |

**Passo 4 — `POST /auth/select-institution`** (apenas quando N > 1). Body: `institutionId`; header: token de seleção.

- Backend valida o vínculo em `tb_institution_has_user` (nunca confia só no body)
- Vínculo válido → emite o JWT final; inválido → `403`

**JWT final (payload):**

```json
{
  "institutionId": 1,
  "userId": 1,
  "role": "super",
  "schemaName": "setes_setes"
}
```

- TTL: **24h**, sem refresh token (relogin diário; refresh fica para o setes-app)
- `role` = `tb_institution_has_user.kind` do vínculo escolhido
- **Superusuário (hard coded)**: `role='super'` só é aceito quando `institutionId === 1` (institution da Setes). Em qualquer outra institution, `kind='super'` é ignorado/negado
- Pós-login: super → módulo **Super**; demais → módulo inicial do cliente (cadastro de módulos: outro momento)

**Passo 5 (opcional) — `POST /auth/switch-institution`**: com JWT final válido, troca de institution sem redigitar a senha (mesma validação do Passo 4, emite novo JWT).

**Impacto na Fase 1 (setes-api):**

- `TenantPayload` → `InstitutionPayload`: `tenantId` vira `institutionId` (número, não mais string), mantém `userId`, `role`, `schemaName`
- `auth.middleware`: sem mudança de lógica, só o payload
- `feature-flag.middleware` / `flag.service`: `isModuleEnabled(institutionId, ...)`; o bypass antigo `tenantId === 'setes'` vira `institutionId === 1 && role === 'super'`
- `rate-limit.middleware`: `keyGenerator` usa `institutionId`
- `core.repository.ts`: consulta `setes_central.tb_institution` (não mais `tenants`)

### 2. Modelo de dados de autenticação (`setes_central`)

```sql
-- Entidade: todo mundo que usa o sistema

CREATE TABLE `tb_linebusiness` (
  `id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_linebusiness` ADD PRIMARY KEY (`id`);

CREATE TABLE `tb_entity` (
  `id` int(11) NOT NULL,
  `name_company` varchar(100) DEFAULT '',
  `nick_trade` varchar(100) DEFAULT '',
  `aniversary` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `tb_linebusiness_id` int(11) DEFAULT NULL,
  `note` blob DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nick_trade` (`nick_trade`),
  ADD KEY `name_company` (`name_company`),
  ADD KEY `fk_entity_to_linebusiness` (`tb_linebusiness_id`),
  ADD CONSTRAINT `fk_entity_to_linebusiness` FOREIGN KEY (`tb_linebusiness_id`) REFERENCES `tb_linebusiness` (`id`);

-- Emails centralizados (sem repetição)
CREATE TABLE `tb_mailing` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_mailing`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

-- Tipos de email: principal / sistema (login) / nfe / contato
CREATE TABLE `tb_mailing_group` (
  `id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_mailing_group` ADD PRIMARY KEY (`id`);

INSERT INTO `tb_mailing_group` (`id`,`description`,`created_at`,`updated_at`) VALUES
  (1,'principal',NOW(),NOW()),
  (2,'sistema',NOW(),NOW()),
  (3,'nfe',NOW(),NOW()),
  (4,'contato',NOW(),NOW());

-- N:N — uma entidade usa o mesmo email para várias situações
CREATE TABLE `tb_entity_has_mailing` (
  `tb_entity_id` int(11) NOT NULL,
  `tb_mailing_id` int(11) NOT NULL,
  `tb_mailing_group_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_entity_has_mailing`
  ADD PRIMARY KEY (`tb_entity_id`,`tb_mailing_id`,`tb_mailing_group_id`),
  ADD KEY `tb_mailing_id` (`tb_mailing_id`),
  ADD KEY `tb_mailing_group_id` (`tb_mailing_group_id`),
  ADD CONSTRAINT `fk_ehm_to_entity` FOREIGN KEY (`tb_entity_id`) REFERENCES `tb_entity` (`id`),
  ADD CONSTRAINT `fk_ehm_to_mailing` FOREIGN KEY (`tb_mailing_id`) REFERENCES `tb_mailing` (`id`),
  ADD CONSTRAINT `fk_ehm_to_mailing_group` FOREIGN KEY (`tb_mailing_group_id`) REFERENCES `tb_mailing_group` (`id`);

-- Dados de autenticação
-- Redefinição: tb_user controla SOMENTE autenticação (1 registro por entity).
-- O perfil/papel do usuário fica em tb_institution_has_user.kind, por institution.
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `active` char(1) NOT NULL DEFAULT 'S',
  `activation_key` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_user` ADD PRIMARY KEY (`id`);
ALTER TABLE `tb_user`
  ADD CONSTRAINT `fk_user_to_entity` FOREIGN KEY (`id`)
  REFERENCES `tb_entity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Vínculo usuário × institution
-- `kind` = perfil do usuário NAQUELA institution: o mesmo usuário pode ter
-- poderes diferentes em institutions diferentes, definidos por cada uma delas.
CREATE TABLE `tb_institution_has_user` (
  `tb_institution_id` int(11) NOT NULL,
  `tb_user_id` int(11) NOT NULL,
  `kind` varchar(20) DEFAULT NULL,
  `active` char(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ⚠️ executar somente após criar tb_user e tb_institution (ordem do script)
ALTER TABLE `tb_institution_has_user`
  ADD PRIMARY KEY (`tb_institution_id`,`tb_user_id`),
  ADD KEY `tb_user_id` (`tb_user_id`),
  ADD CONSTRAINT `fk_ihu_to_user` FOREIGN KEY (`tb_user_id`) REFERENCES `tb_user` (`id`),
  ADD CONSTRAINT `fk_ihu_to_institution` FOREIGN KEY (`tb_institution_id`) REFERENCES `tb_institution` (`id`);
```

Select de autenticação (email do grupo 2 = "sistema"):

```sql
SELECT u.*
FROM tb_user u
  INNER JOIN tb_entity_has_mailing ehm ON (ehm.tb_entity_id = u.id) 
  INNER JOIN tb_mailing m ON (m.id = ehm.tb_mailing_id)
WHERE (m.email = :email) AND (u.password = :password)
  AND (ehm.tb_mailing_group_id = 2);
```

### 3. Seed do superusuário

Criar script que gera os dados do superusuário:

```sql
INSERT INTO `tb_entity` (`id`,`name_company`,`nick_trade`,`aniversary`,`created_at`,`updated_at`,`tb_linebusiness_id`,`note`)
VALUES (1,'F. D. SOUZA DESENVOLVIMENTO E LICENCIAMENTO DE PROGRAMAS','GESTAO COMPUTACIONAL SETES',NULL,'2024-01-19 00:00:00','2026-04-16 14:07:54',NULL,NULL);

INSERT INTO `tb_company` (`id`,`cnpj`,`ie`,`im`,`iest`,`dt_foundation`,`crt`,`crt_modal`,`ind_ie_destinatario`,`created_at`,`updated_at`,`iss_ind_exig`,`iss_retencao`,`iss_inc_fiscal`,`iss_process_number`,`send_xml_nfe_only`)
VALUES (1,'07742094000113',NULL,NULL,NULL,'2018-05-11','3','N','1',NOW(),'2024-01-19 08:54:37','01','N','N','0','N');

INSERT INTO `tb_address` (`id`,`street`,`nmbr`,`complement`,`neighborhood`,`region`,`kind`,`zip_code`,`tb_country_id`,`tb_state_id`,`tb_city_id`,`main`,`longitude`,`latitude`,`created_at`,`updated_at`)
VALUES (1,'RUA FAUSTINO JACOB STOFELLA','28','','ALTO BOQUEIRAO',NULL,'COMERCIAL','81770090',1058,41,4004,'S',NULL,NULL,'2024-01-19 08:54:37','2026-04-16 14:07:54');  

INSERT INTO `tb_mailing` (`id`,`email`,`created_at`,`updated_at`)
VALUES (1,'valdo@setes.com.br',NOW(),'2026-04-16 14:07:54');

INSERT INTO `tb_entity_has_mailing` (`tb_entity_id`,`tb_mailing_id`,`tb_mailing_group_id`,`created_at`,`updated_at`)
VALUES (1,1,1,'2026-04-16 14:07:54','2026-04-16 14:07:54'),(1,1,2,NOW(),'2022-04-26 14:10:14');

-- Senha MD5 (decisão: manter MD5; campo salt removido da tabela)
INSERT INTO `tb_user` (`id`,`password`,`active`,`activation_key`,`created_at`,`updated_at`)
VALUES (1,'827CCB0EEA8A706C4C34A16891F84E7B','S',NULL,NOW(),'2022-04-26 14:10:14');


INSERT INTO `tb_institution` (`id`,`schema_name`,`active`,`created_at`,`updated_at`) VALUES (1,'setes_setes','S',NOW(),NOW());
INSERT INTO `tb_institution_has_user` (`tb_institution_id`,`tb_user_id`,`kind`,`active`,`created_at`,`updated_at`) VALUES (1,1,'super','S',NOW(),NOW());
```

---

## Módulo Super — Interfaces UI

### Cadastro → Estabelecimentos

Cadastro é composto por ObjEntityFiscal + tb_institution que o qualifica com tal.

```sql
-- setes_central — PJ (preenchida quando a UI informar Pessoa Jurídica com CNPJ válido)
CREATE TABLE `tb_company` (
  `id` int(11) NOT NULL,
  `cnpj` char(14) NOT NULL DEFAULT '0',
  `ie` varchar(45) DEFAULT NULL,
  `im` varchar(45) DEFAULT NULL,
  `iest` varchar(45) DEFAULT NULL,
  `dt_foundation` date DEFAULT NULL,
  `crt` char(1) DEFAULT NULL,
  `crt_modal` char(1) DEFAULT NULL,
  `ind_ie_destinatario` varchar(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `iss_ind_exig` char(2) DEFAULT NULL,
  `iss_retencao` char(1) DEFAULT NULL,
  `iss_inc_fiscal` char(1) DEFAULT NULL,
  `iss_process_number` varchar(50) DEFAULT NULL,
  `send_xml_nfe_only` char(1) DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_company`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj` (`cnpj`),
  ADD CONSTRAINT `fk_company_to_entity` FOREIGN KEY (`id`) REFERENCES `tb_entity` (`id`);

-- setes_central — PF (preenchida quando a UI informar Pessoa Física com CPF válido)
CREATE TABLE `tb_person` (
  `id` int(11) NOT NULL,
  `cpf` char(11) NOT NULL,
  `rg` char(20) DEFAULT NULL,
  `rg_dt_emission` date DEFAULT NULL,
  `rg_organ_issuer` varchar(45) DEFAULT NULL,
  `rg_state_issuer` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `tb_profession_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_person`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD CONSTRAINT `fk_person_to_entity` FOREIGN KEY (`id`) REFERENCES `tb_entity` (`id`);

-- setes_central 
CREATE TABLE `tb_address` (
  `id` int(11) NOT NULL,
  `kind` varchar(100) NOT NULL DEFAULT 'COMERCIAL',
  `street` varchar(100) NOT NULL ,
  `nmbr` varchar(10) DEFAULT 'sn',
  `complement` varchar(100) DEFAULT NULL,
  `neighborhood` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,  
  `zip_code` varchar(15) DEFAULT NULL,
  `tb_country_id` int(11) NOT NULL,
  `tb_state_id` int(11) NOT NULL,
  `tb_city_id` int(11) NOT NULL,
  `main` char(1) NOT NULL DEFAULT 'S',
  `longitude` varchar(20) DEFAULT NULL,
  `latitude` varchar(20) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_address`
  ADD PRIMARY KEY (`id`, `kind`),        -- vários endereços por entidade, desde que de kind diferente (decisão)
  ADD CONSTRAINT `fk_address_to_entity` FOREIGN KEY (`id`) REFERENCES `tb_entity` (`id`),
  ADD KEY `fk_country_to_address` (`tb_country_id`),
  ADD KEY `fk_state_to_address` (`tb_state_id`),
  ADD KEY `fk_city_to_address` (`tb_city_id`),
  ADD CONSTRAINT `fk_country_to_address` FOREIGN KEY (`tb_country_id`) REFERENCES `setes_central`.`tb_country` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_state_to_address` FOREIGN KEY (`tb_state_id`) REFERENCES `setes_central`.`tb_state` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_city_to_address` FOREIGN KEY (`tb_city_id`) REFERENCES `setes_central`.`tb_city` (`id`) ON DELETE RESTRICT;

-- setes_central — Telefones 
CREATE TABLE `tb_phone` (
  `id` int(11) NOT NULL,
  `kind` varchar(20) NOT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `address_kind` varchar(100) DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_phone`
  ADD PRIMARY KEY (`id`,`kind`),
  ADD CONSTRAINT `fk_phone_to_entity` FOREIGN KEY (`id`) REFERENCES `tb_entity` (`id`);

-- setes_central — Social Media
CREATE TABLE `tb_social_media` (
  `id` int(11) NOT NULL,
  `kind` varchar(50) NOT NULL,
  `link` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_social_media`
  ADD PRIMARY KEY (`id`,`kind`),
  ADD CONSTRAINT `fk_social_media_to_entity` FOREIGN KEY (`id`) REFERENCES `tb_entity` (`id`);

-- setes_+(schema) — Customer

CREATE TABLE `tb_customer` (
  `id` INT NOT NULL,
  `tb_institution_id` INT NOT NULL,
  `tb_salesman_id` INT DEFAULT NULL,
  `tb_carrier_id` INT DEFAULT NULL,      -- FK/índice: implementação futura
  `credit_status` CHAR(1) DEFAULT NULL,
  `credit_value` DECIMAL(10,2) DEFAULT NULL,
  `wallet` CHAR(1) DEFAULT NULL,
  `consumer` CHAR(1) DEFAULT NULL,
  `multiplier` DECIMAL(10,2) DEFAULT NULL,
  `by_pass_st` CHAR(1) DEFAULT NULL,
  `active` CHAR(1) DEFAULT NULL,
  `created_at` DATETIME DEFAULT NULL,
  `updated_at` DATETIME DEFAULT NULL,
  `deleted` CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`, `tb_institution_id`),
  KEY `idx_tb_customer_institution` (`tb_institution_id`),
  KEY `idx_tb_customer_salesman` (`tb_salesman_id`),
  CONSTRAINT `fk_tb_customer_entity`
    FOREIGN KEY (`id`)
    REFERENCES `setes_central`.`tb_entity` (`id`)     -- cross-schema: entity vive na central
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_customer_institution`
    FOREIGN KEY (`tb_institution_id`)
    REFERENCES `setes_central`.`tb_institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_customer_salesman`
    FOREIGN KEY (`tb_salesman_id`)
    REFERENCES `setes_central`.`tb_entity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- setes_central — Estabelecimento propriamente dito (substitui `tenants`)
CREATE TABLE `tb_institution` (
  `id` int(11) NOT NULL,
  `schema_name` varchar(100) NOT NULL,
  `active` char(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_institution`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `schema_name` (`schema_name`),
  ADD CONSTRAINT `fk_institution_to_entity` FOREIGN KEY (`id`) REFERENCES `tb_entity` (`id`);
```

Regras da tela Estabelecimento:

- Registro formal do cliente com dados cadastrais oficiais
- Informar quais interfaces o cliente terá acesso no pacote adquirido
- Registrar o tenant na base `setes_central` (via `tb_institution`)

### Cadastro → Privilégios da interface

Operações disponibilizáveis por interface: Visualizar, Inserir, Alterar, Excluir, Autorizar etc.

```sql
-- setes_central
CREATE TABLE `tb_privilege` (
  `id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_privilege` ADD PRIMARY KEY (`id`);
```

### Cadastro → Interfaces UI

Telas do sistema (Cliente, Fornecedor, Produtos etc.). Aqui se define quais privilégios cada interface controla, para depois aplicar aos usuários.

```sql
-- setes_central
CREATE TABLE `tb_interface` (
  `id` int(11) NOT NULL,
  `group_default` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `kind` varchar(26) DEFAULT NULL,
  `position` varchar(10) DEFAULT NULL,
  `img_index` int(11) NOT NULL,
  `button_action` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_interface`
  ADD PRIMARY KEY (`id`),
  ADD KEY `position` (`position`),
  ADD KEY `kind` (`kind`);

CREATE TABLE `tb_interface_has_privilege` (
  `tb_interface_id` int(11) NOT NULL,
  `tb_privilege_id` int(11) NOT NULL,
  `active` char(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tb_interface_has_privilege`
  ADD PRIMARY KEY (`tb_interface_id`,`tb_privilege_id`),
  ADD KEY `tb_privilege_id` (`tb_privilege_id`),
  ADD CONSTRAINT `tb_interface_has_privilege_ibfk_1` FOREIGN KEY (`tb_interface_id`) REFERENCES `tb_interface` (`id`),
  ADD CONSTRAINT `tb_interface_has_privilege_ibfk_2` FOREIGN KEY (`tb_privilege_id`) REFERENCES `tb_privilege` (`id`);
```

---

## Tabelas de referência centralizadas (`setes_central`)

Telas/tabelas que não precisam ser replicadas em cada schema de cliente.

### Geográficas

```sql
CREATE TABLE `tb_country` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `tb_country` ADD PRIMARY KEY (`id`);

CREATE TABLE `tb_state` (
  `id` int(11) NOT NULL,
  `tb_country_id` int(11) NOT NULL,
  `abbreviation` varchar(2) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `aliquota` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `tb_state`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_state_to_country` (`tb_country_id`),
  ADD CONSTRAINT `fk_state_to_country` FOREIGN KEY (`tb_country_id`) REFERENCES `tb_country` (`id`);

CREATE TABLE `tb_city` (
  `id` int(11) NOT NULL,
  `tb_state_id` int(11) NOT NULL,
  `ibge` varchar(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `aliq_iss` decimal(10,2) NOT NULL DEFAULT 0.00,
  `population` int(11) DEFAULT 0,
  `density` decimal(10,2) DEFAULT 0.00,
  `area` decimal(10,2) DEFAULT 0.00,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `tb_city`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_city_to_state` (`tb_state_id`),
  ADD CONSTRAINT `fk_city_to_state` FOREIGN KEY (`tb_state_id`) REFERENCES `tb_state` (`id`);
```

### Fiscais

```sql
CREATE TABLE `tb_cfop` (
  `id` varchar(10) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `concise` varchar(60) DEFAULT NULL,
  `active` char(1) DEFAULT NULL,
  `register` int(11) DEFAULT NULL,
  `way` varchar(1) DEFAULT NULL,
  `jurisdiction` varchar(1) DEFAULT NULL,
  `note` blob DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `tb_cfop` ADD PRIMARY KEY (`id`);

CREATE TABLE `tb_ncm` (
  `number` varchar(10) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `exc` varchar(5) DEFAULT NULL,
  `tabela` int(11) DEFAULT NULL,
  `aliq_nac` decimal(10,3) DEFAULT NULL,
  `aliq_imp` decimal(10,3) DEFAULT NULL,
  `aliq_est` decimal(10,3) DEFAULT NULL,
  `aliq_mun` decimal(10,3) DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `tb_ncm` ADD PRIMARY KEY (`number`);

CREATE TABLE `tb_cest` (
  `cest` varchar(7) NOT NULL,
  `ncm` varchar(8) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `tb_cest` ADD PRIMARY KEY (`cest`);
```

Tabelas de situação tributária — todas com a mesma estrutura (`id`, `description`, `created_at`, `updated_at`, `deleted`, PK em `id`), variando só o tipo do `id`:

| Tabela | Conteúdo | Tipo do `id` |
|---|---|---|
| `tb_tax_icms_nr` | Situação Tributária — Regime Normal | `char(2)` |
| `tb_tax_icms_sn` | Situação Tributária — Simples Nacional | `char(3)` |
| `tb_deter_base_tax_icms` | Determinação de base de ICMS Normal | `char(2)` |
| `tb_deter_base_tax_icms_st` | Determinação de base de ICMS ST | `char(2)` |
| `tb_discharge_icms` | Desoneração | `int(11)` |
| `tb_tax_ipi` | Situação Tributária do IPI | `char(2)` |
| `tb_tax_pis` | Situação Tributária do PIS | `char(2)` |
| `tb_tax_cofins` | Situação Tributária do COFINS | `char(2)` |

```sql
-- Modelo (repetir para cada tabela acima, ajustando nome e tipo do id)
CREATE TABLE `tb_tax_icms_nr` (
  `id` char(2) NOT NULL DEFAULT '',
  `description` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` char(1) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `tb_tax_icms_nr` ADD PRIMARY KEY (`id`);
```

---

## Estrutura de Objetos (referência para o backend)

**ObjEntity** — agrupa os models que tornam a informação substancial:

- `tb_entity` (tblEntity) — model que inicia a representação de algo
- TListAddress → `tb_address` — múltiplos endereços (um por `kind`)
- `tb_entity_has_mailing` → `tb_mailing` — emails ligados à entidade
- TListPhone → `tb_phone` — telefones
- `tb_social_media` — redes sociais (uma por `kind`)

**ObjEntityFiscal** — herda de ObjEntity e recebe especializações:

- `tb_company` — pessoa jurídica (CNPJ)
- `tb_person` — pessoa física (CPF)

**Institution** = ObjEntityFiscal + `tb_institution` (que o qualifica como tenant/licenciado).

---

## Decisões arquiteturais registradas

1. **Herança por PK compartilhada**: tabelas-filhas de `tb_entity` (`tb_address`, `tb_phone`, `tb_company`, `tb_person`, `tb_user`, `tb_institution`, `tb_customer` e futuras) usam `id` como PK **e** FK para `tb_entity.id`. Foge deliberadamente do padrão `tb_entity_id` — decisão arquitetural por similaridade/herança. Tabelas N:N (`tb_entity_has_mailing`, `tb_institution_has_user`) continuam no padrão `tb_<tabela>_id`.
2. **Senha permanece MD5**; campo `salt` removido de `tb_user`. (Risco registrado: MD5 é reversível por rainbow table.)
3. **`tb_address` PK (`id`,`kind`)**: correto — permite vários endereços desde que de tipos diferentes.
4. **`tb_institution.schema_name`** adicionado (absorve `tenants`).
5. **`tb_interface`**: defaults `NULL` reais; `acao_botao` renomeado para `button_action`.
6. **Datas de seed**: `NOW()` ou datas reais (nunca `0000-00-00`).
7. **IDs gerados pela aplicação** — sem `AUTO_INCREMENT`.
8. **Superusuário** reconhecido por `tb_institution_has_user.kind = 'super'`.
9. **Licenças** controladas pelo campo `tb_institution.active`.
10. **Separação autenticação × perfil** (redefinição): `tb_user` controla somente autenticação — PK simples em `id`, sem `kind` e sem `tb_device_id`, 1 registro por entity (resolve o select de login). `tb_institution_has_user` tem PK (`tb_institution_id`,`tb_user_id`), FKs simples, e `kind` é o perfil do usuário naquela institution — o mesmo usuário pode ter poderes diferentes por institution.
11. **`tb_customer`** no schema do cliente com PK (`id`,`tb_institution_id`) e FKs cross-schema para `setes_central` (entity, institution, salesman). `tb_carrier_id`: implementação futura.
12. **`schema_name` da Setes** = `setes_setes` (padrão `setes_<schema>` vale para todos, inclusive a Setes).
13. **`tb_mailing.email` UNIQUE** confirmado; `tb_phone.id` sem default; ordem de execução por dependência ao gerar o script final.
14. **Escopo do 'super' (hard coded)**: `kind='super'` só vale no vínculo com a institution da Setes (`id=1`).
15. **Implementação futura**: ponte perfil × privilégios (`tb_profile`) e padronização de perfis (`kind` segue texto livre por ora).
16. **Nomenclatura**: todo tenant é tratado como **institution**. JWT passa de `tenantId` (string) para `institutionId` (int); fluxo de login multi-institution definido na seção Workflow (login → lista de institutions → seleção → JWT final).
17. **Institution padrão**: decisão adiada para o projeto **setes-app** (por ora, com N institutions a tela de escolha sempre aparece).
18. **Migração do JWT**: troca direta `tenantId` → `institutionId`, sem período de transição (não há clientes em produção).
19. **Sessão**: JWT final com **TTL 24h, sem refresh token** (relogin diário). Refresh token = implementação futura junto com o setes-app (mobile).
20. **Prefixo de schema**: todo schema de cliente segue `setes_<nome>` — validação do onboarding usa `/^setes_[a-z0-9_]+$/` (substituiu `gestao_`).
21. **Sincronizador**: `sync_api_keys` → `tb_sync_api_key` (script 05), indexada por `tb_institution_id` int com FK; `schema_name` deixa de ser duplicado (vem por JOIN de `tb_institution`).
22. **Feature flag — extração do moduleKey e módulos isentos (2026-07-12)**: o middleware é montado via `app.use('/api', ...)`, e o Express remove o prefixo do mount de `req.path` — o moduleKey é `req.path.split('/')[1]` (o índice `[2]` original lia o segmento errado, ex.: `status` em `/api/erp/status`; bug ficava invisível porque o super bypassa). Existe lista de isentos `FLAG_EXEMPT_MODULES = ['core']` — `core` serve o menu (`/api/core/menus`) e precisa responder para todo cliente autenticado antes de qualquer flag. Cadastros do catálogo central (countries, states...) NÃO entram na lista: já são bloqueados pelo `superGuard`, e negar por padrão é mais seguro. Teste de regressão em `src/__tests__/feature-flag.middleware.test.ts` (monta o middleware em `/api` como no app.ts).

23. **Onboarding completo — telas estruturais + primeiro admin (2026-08-15, decisão do Valdo; frente A2)**: `POST /api/institutions` deixou de entregar um cliente inutilizável. Dois buracos fechados: (a) a flag `'users'` NUNCA existiu em `defaultModules` — o admin do cliente tomava 403 ao gerenciar os próprios usuários; não era seed esquecido, porque `insertDefaultFlags` é o único lugar que cria flag para cliente novo (seed nenhum cobriria clientes futuros); (b) o onboarding não gravava NADA em `tb_institution_has_interface`, e como `getMenus` faz INNER JOIN com o contrato, **o menu de um cliente novo nascia vazio**. Decidido: existe um conjunto **ESTRUTURAL** de telas que não é produto vendável e nasce contratado — `users`, `modules` (menus do cliente) e `interface-configs` (`STRUCTURAL_INTERFACE_KEYS`, ids resolvidos por `i18n_key`, nunca literais); todo o resto do catálogo continua venda explícita do Super. E o **primeiro admin virou parte do onboarding** (bloco `admin` OBRIGATÓRIO no POST, vínculo `kind='admin'`): cliente nunca existe sem dono — antes era possível criar e ativar um cliente sem nenhum usuário. Ordem do service: e-mail de login livre (falha cedo, antes de qualquer escrita) → cadeia → flags → migrations → contrato estrutural + admin → `active='S'`; qualquer falha pós-commit deixa `active='N'`. Efeito colateral estrutural: a cascata da credencial (entity + tb_user + e-mail de login + vínculo) foi PROMOVIDA de `modules/users/users.repository` para a peça `@shared/user`, porque módulo não importa módulo — `users` e `institutions` consomem a mesma peça.

---

## Questões pendentes

Nenhuma — todas as rodadas (1 a 5) foram decididas e registradas acima. Próximos detalhamentos (perfis/privilégios, institution padrão, refresh token, cadastro de módulos) ficam para fases futuras.

---

## Scripts SQL consolidados (pasta `sql/`)

Regra de separação: **setes_central e setes_<schema> nunca têm as mesmas tabelas.** Cadastro, autenticação, licenças, interfaces/privilégios e referências geográficas/fiscais vivem só na central; o schema do cliente tem apenas tabelas operacionais (`tb_customer` etc.).

| Script | O que faz | Quando rodar |
|---|---|---|
| `01_setes_central_ddl.sql` | Cria `setes_central` completa em ordem de dependência (constraints no CREATE, re-executável). Cria `tb_feature_flag` (padronizada, por institution) e remove `feature_flags`/`tenants` da Fase 1 | 1º, uma vez |
| `02_setes_central_seed.sql` | Grupos de email, geografia mínima (Brasil/PR/Curitiba) e superusuário completo (entity+company+address+mailing+user+institution 1+vínculo 'super') | 2º, uma vez |
| `03_schema_cliente_ddl.sql` | Cria o schema do cliente com `tb_customer` (FKs cross-schema para a central). Modelo usa `setes_setes` — trocar por cliente | 3º, por cliente |
| `04_schema_cliente_cleanup.sql` | Remove do schema do cliente tudo que foi centralizado (com avisos de backup/migração). Não toca em `tb_customer` | 4º, por cliente |
| `05_sync_api_key.sql` | Cria `tb_sync_api_key` (padronizada, por institution) e remove `sync_api_keys` | 5º, uma vez |

⚠️ Impacto Fase 1 pendente de código: `flag.repository.ts` deve consultar `tb_feature_flag`/`tb_institution_id`; `core.repository.ts` consulta `tb_institution`; JWT com `institutionId` (decisões 16/18).

---

## Critérios de sucesso

1. `tenants` migrada para `tb_institution` (com `schema_name` e licenças) e removida; Fase 1 (`core.repository.ts`, feature flags) ajustada e funcionando
2. Todas as tabelas de `setes_central` com prefixo `tb_`
3. Login por tela única contra `setes_central` funciona para Setes e clientes
4. Usuário com 1 institution recebe JWT direto; com N institutions recebe lista + token de seleção e obtém o JWT final via `/auth/select-institution`
5. JWT final carrega `institutionId`/`schemaName` e os middlewares da Fase 1 funcionam com a nova nomenclatura
6. `valdo@setes.com.br` com vínculo `kind='super'` na institution 1 → módulo Super exibido; `kind='super'` em outra institution é negado
7. Cadastro de estabelecimento cria, numa única operação: `tb_entity` + `tb_company`/`tb_person` + `tb_address` + `tb_institution` (central) e `tb_customer` (schema do cliente)
8. Tabelas de referência (geográficas e fiscais) criadas e populadas na central
9. Usuário não-super loga e é direcionado ao módulo inicial (placeholder até o cadastro de módulos)
