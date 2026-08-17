# Prompt — Framework de Configurações do Sistema

**Status**: ✅ IMPLEMENTADO (2026-07-18) — 17 decisões em 4 rodadas (fechado 2026-07-17)
**Escopo**: setes

## Notas da implementação (2026-07-18)

- **tb_interface.kind já existia** como varchar(26) texto livre (seeds antigos
  gravavam 'N'): a decisão 13 foi aplicada REAPROVEITANDO a coluna —
  bootstrap-db.ts normaliza valores legados para 'T' e aperta o tipo para
  char(1) NOT NULL DEFAULT 'T'; seeds 06/07/08 corrigidos para 'T'; o campo
  virou dropdown Tela×Recurso na tela de Interfaces (DTO enum T/R).
- **CRUD do catálogo** vive no módulo interfaces (/api/interfaces/:id/configs,
  superGuard do módulo — "na área da tela de Interfaces", decisão 7); painel e
  consumo no módulo interface-configs (sem guard, isento de feature flag).
- **Vitrine promovida**: listVitrine/interfaceExists/isInterfaceAcquired saíram
  do interface-fields para @shared/interface-vitrine (API) e a
  InterfaceVitrineEntity para app/shared/interface_vitrine (2º consumidor).
- **Re-hidratação do SessionContext**: o bloco `context` também sai em
  GET /api/core/me — a Home re-hidrata a cada entrada (login, F5, troca de
  institution); no app o preenchimento único acontece em HomePage (o AuthBloc
  do core não sobrevive à navegação para /home).
- **Nota (b) implementada nos DOIS alvos**: salvar valor igual ao herdado
  (default p/ institution; institution→default p/ override) REMOVE a linha.
- Seed: interfaces 10 (interface-configs, painel) e 11 (general-configs,
  "Configurações Gerais") no grupo Sistema — sql/09_interface_configs_seed.sql.
- **"Configurações Gerais" no menu** (fix 2026-07-18): a interface 11 não tem
  módulo próprio (não é tela — é a DONA das configs sem tela, decisão 3); o
  clique no menu abre o painel interface-configs já filtrado nela
  (special-case em interface_routes.dart, mesmo caminho da engrenagem).
- Testes: interface-config.test.ts (resolução+cache), customers-carteira.test.ts
  (enforcement decisão 15), menus-kind.test.ts (regressão decisões 12/13),
  auth-login.test.ts (bloco context fora do JWT). 99/99 verdes.
**Método**: `skills-genericas/refinar-prompt-arquitetura.md` (rodadas de decisão numeradas)
**Escopo previsto**: setes-api + setes-app + sql (central e schema do cliente)
**Origem**: rascunho do Valdo (2026-07-17) — modernização da tela de configurações do Delphi (TB_GERAL + Config.ini)

---

## Contexto

Muitos clientes com necessidades diferentes; impossível criar uma tela para cada um.
No Delphi isso é resolvido com uma tela de configuração com "zilhão" de opções que
ativam/desativam comportamentos (abas de Projetos/Extintores/Parceria no cliente;
abas de Produção/Fornecedores/Impostos/Aplicações/Composição no produto).

**Calcanhar de aquiles conhecido** (trade-off de toda software house):
- Um sistema por cliente → morre na manutenção
- Um sistema com zilhão de configurações → código macarrônico + suporte que não
  lembra das opções (morre no atendimento)

**Resposta estrutural desta fase (decisão 1)**: separar o que o Delphi mistura —
o VENDÁVEL vira interface no catálogo (some via contrato `tb_institution_has_interface`);
`tb_*_config` guarda só PREFERÊNCIA/COMPORTAMENTO.

**Legado Delphi (referência, NÃO reusar)**:
- `Config.ini` — opções por PC (ex.: impressora)
- `TB_GERAL` — configurações sistêmicas por institution:
  `GRL_CAMPO` (nome), `GRL_DESCRICAO` (descrição), `GRL_CONTEUDO` (valor),
  `GRL_CODMHA` (institution). Campos aposentados: GRL_CODIGO, GRL_GRUPO, GRL_DETALHES.
- Variáveis globais de sessão (ex.: `GB_CD_VENDEDOR`, setada no login lendo
  colaborador × cargo vendedor) — substituídas pelo padrão da decisão 17.
- Referência do filtro de carteira: `D:\Gestao2016\Tarefas\Un_Pesq_Empresa.pas`.

**Hierarquia de configurabilidade do produto web** (este prompt é o 3º nível):
- Nível TELA (feito): `tb_interface` (catálogo) × `tb_institution_has_interface` (contrato, schema do cliente)
- Nível CAMPO (feito, Fase 2): `tb_interface_has_field` (catálogo) × `tb_institution_has_field` (config do cliente)
- Nível COMPORTAMENTO (este prompt): `tb_interface_has_config` (catálogo) × `tb_institution_has_config` (valores do cliente)

**Montagem canônica de menus (decisão 12 — PRESERVAR)**:
- `tb_interface.group_default` = agrupamento (módulo) definido pela Setes
- `tb_module` + `tb_module_has_interface` (schema do cliente) = organização própria do cliente
- As duas estruturas são EXCLUSIVAS: cliente que cria a própria estrutura não usa as duas
- Exceções na montagem: módulo Super (usuários super) e módulo Sistema (usuários admin)

## Objetivos

1. Substituir TB_GERAL por um modelo de configuração com catálogo (o suporte enxerga
   nome + descrição + default de TODAS as opções — ataca o "suporte não lembra").
2. Vincular cada configuração à interface (tela) dona dela — a tela de configuração
   vira um framework montado a partir do catálogo, sem tela artesanal por opção.
3. Permitir valor por institution e, quando o catálogo autorizar, por usuário.
4. Cliente só vê configurações que fazem sentido para ele: o vendável é contrato
   (decisão 1); preferência aparece para todos que têm a tela (decisão 8).
5. Acesso contextual: ícone na tela de LISTA (decisão 11) → tela de configurações já
   filtrada naquela interface.
6. Substituir as variáveis globais do Delphi por um padrão de estado de sessão
   (decisão 17) — 1º consumidor: `isSalesman` do filtro de carteira.

## Workflow (consolidado pelas decisões)

1. **Cadastro da configuração (Super)**: na tela de Interfaces (interface 6), seção
   "Configurações" (padrão da seção de privilégios) cadastra as configs daquela
   interface: nome, descrição, kind, options, default, scope (decisão 7).
2. **Contrato (Super)**: nada muda — visibilidade do vendável já deriva de
   `tb_institution_has_interface` (decisão 1); sem gate extra para preferência (decisão 8).
3. **Uso (cliente)**: painel `interface_configs` (vitrine no molde do
   `interface_fields` da Fase 2, grupo Sistema — decisão 9) + ícone de engrenagem na
   tela de LISTA abrindo o painel já filtrado na interface corrente (decisões 7 e 11).
   Admin edita valores da institution; usuário comum edita só os próprios overrides
   de configs scope 'U' (decisão 4).
4. **Consumo (engine)**: valor efetivo resolvido por
   **usuário → institution → default do catálogo** (decisão 4), endpoint de config
   resolvida por interface + cache TTL na API (molde do field-config da Fase 2).
5. **Config por dispositivo** (ex-Config.ini, ex.: impressora): armazenamento local
   do app, fora do banco (decisão 5).

## DDL aprovado nas decisões 2, 3, 4, 6 e 13 (pendente revisar-ddl + sqlglot no fechamento)

```sql
-- setes_central — CATÁLOGO (característica intrínseca do produto)
CREATE TABLE IF NOT EXISTS `tb_interface_has_config` (
  `tb_interface_id` int(11) NOT NULL,
  `name`            varchar(50)  NOT NULL,             -- chave da configuração (ex-GRL_CAMPO)
  `description`     varchar(255) NOT NULL,             -- ex-GRL_DESCRICAO — obrigatória: é o que salva o suporte
  `kind`            varchar(50)  NOT NULL,             -- String|Integer|Float|Boolean|Date|Options (decisão 6)
  `options`         varchar(255) DEFAULT NULL,         -- lista fechada p/ kind Options: "A=Por item;B=Por total"
  `default_content` varchar(100) NOT NULL,             -- padrão inicial do produto
  `scope`           char(1)      NOT NULL DEFAULT 'I', -- 'I'=só institution; 'U'=admite override por usuário (decisão 4)
  `created_at`      datetime DEFAULT NULL,
  `updated_at`      datetime DEFAULT NULL,
  `deleted`         char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_interface_id`, `name`),
  CONSTRAINT `fk_ihc_interface` FOREIGN KEY (`tb_interface_id`)
    REFERENCES `tb_interface` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- setes_central — marcador tela × recurso (decisão 13; migration em tb_interface)
ALTER TABLE `tb_interface`
  ADD COLUMN `kind` char(1) NOT NULL DEFAULT 'T';  -- 'T'=tela (vai a menu); 'R'=recurso/aba (NUNCA vai a menu)

-- setes_<schema> — VALORES escolhidos (só grava o que diverge do default)
CREATE TABLE IF NOT EXISTS `tb_institution_has_config` (
  `tb_institution_id` INT NOT NULL,
  `tb_interface_id`   INT NOT NULL,
  `name`              VARCHAR(50) NOT NULL,
  `tb_user_id`        INT NOT NULL DEFAULT 0,          -- 0 = valor da institution; >0 = override do usuário (decisão 4)
  `content`           VARCHAR(100) NOT NULL,
  `created_at`        DATETIME DEFAULT NULL,
  `updated_at`        DATETIME DEFAULT NULL,
  `deleted`           CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `tb_interface_id`, `name`, `tb_user_id`),
  CONSTRAINT `fk_inhc_institution` FOREIGN KEY (`tb_institution_id`)
    REFERENCES `setes_central`.`tb_institution` (`id`),
  CONSTRAINT `fk_inhc_config` FOREIGN KEY (`tb_interface_id`, `name`)
    REFERENCES `setes_central`.`tb_interface_has_config` (`tb_interface_id`, `name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

Notas de projeto (herdadas da Rodada 1):
(a) `field` → `name` — evita colisão semântica com o framework de CAMPOS da Fase 2
(config não é campo); (b) valor só existe quando diverge do default → a tela sempre
mostra o efetivo (default do catálogo com override por cima); (c) rascunho original
do Valdo (tb_config única, molde TB_GERAL) preservado no histórico da Rodada 1 e
superado pela decisão 2.

## Piloto — 3 configs da tela Clientes (decisões 10 e 14)

| name | kind | options | default | scope | Comportamento |
|---|---|---|---|---|---|
| `restrict_customer_to_salesman` | Boolean | — | `N` | I | Ligada: usuário-vendedor (decisão 15) só vê clientes da própria carteira (`tb_customer.tb_salesman_id = userId`); filtro FIXO e BLOQUEADO. Enforcement na API (lista e GET :id) |
| `default_person_type` | Options | `F=Pessoa Física;J=Pessoa Jurídica` | `J` | U | Cadastro novo abre com o tipo de pessoa pré-selecionado |
| `default_customer_kind` | Options | `C=Consumidor;R=Revenda` | `R` | U | Aba Tributação abre com Consumidor/Revenda pré-preenchido no cadastro novo |

~~`description` de cada uma cita o nome Delphi de origem para rastreio do
suporte.~~ **REVOGADO (Valdo, 2026-07-18)**: a description é o RÓTULO visto
pelo cliente no painel — NENHUMA referência a sistema legado/nome técnico em
conteúdo visível do sistema. O rastreio de origem (ex-GRL_*) fica na
documentação interna (este prompt e Infra-IA), nunca no banco/telas.

## Padrão de estado de sessão (decisão 17 — substitui as variáveis globais do Delphi)

**API (setes-api)**:
- JWT permanece IDENTIDADE MÍNIMA: `{ institutionId, userId, role, schemaName }` —
  invariante da Fase 2; nenhum fato derivado entra no token (token de 24h ficaria
  defasado e obrigaria relogin a cada mudança de papel).
- Fatos derivados de sessão (1º caso: `isSalesman`) vivem em
  `src/shared/session-context/` — resolvidos por request com cache TTL
  (molde field-config/flag.service): `isSalesman = EXISTS tb_salesman WHERE
  id = userId AND tb_institution_id = institutionId AND deleted='N'`
  (herança por PK: `tb_user.id` = `tb_entity.id` = `tb_salesman.id`).
- Enforcement de regra (ex.: filtro de carteira) é SEMPRE da API
  (repository/service) — nunca confia no app.

**App (setes-app)**:
- `SessionContext` ÚNICO em `app/shared/session/` — substituto dos `GB_*`:
  preenchido no login (a resposta do login ganha bloco `context`, ex.:
  `{ "isSalesman": true }`), somente leitura para as telas, limpo no logout.
- Uso no app é só UX (ex.: fixar/bloquear o campo de filtro de vendedor) —
  a segurança está na API.
- PROIBIDO variável global solta; valor novo de sessão = campo novo no
  SessionContext (app) + resolver no session-context (API), nesse caminho único.

## Peças de implementação (visão de entregáveis — fechar na convergência)

1. **DDL + migration**: catálogo + coluna `tb_interface.kind` em sql/01 (+ migration
   central); valores em sql/03 + migration nos schemas existentes; seed da interface
   "Configurações Gerais" (decisão 3), do painel `interface_configs` (decisão 9) e
   das 3 configs do piloto (decisões 10/14).
2. **Menus (decisão 13)**: os DOIS ramos da montagem (group_default e módulos do
   cliente) passam a filtrar `tb_interface.kind='T'` — com teste de regressão
   (decisão 12: montagem canônica intacta para todos os perfis).
3. **API**: módulo `interface-configs` no padrão simétrico (isento de feature flag,
   como o interface-fields) — endpoints do catálogo (CRUD, superGuard, na área da
   tela de Interfaces), endpoints do painel do cliente (listar por interface
   contratada, salvar valor institution/usuário conforme scope e perfil) e endpoint
   de consumo (config resolvida por interface: usuário → institution → default) com
   cache TTL (molde field-config). Swagger na mesma entrega.
4. **API — sessão + piloto**: `src/shared/session-context/` (decisão 17); bloco
   `context` na resposta do login; filtro de carteira no módulo customers
   (lista + GET :id) quando `restrict_customer_to_salesman='S'` e o usuário é
   vendedor (decisão 15); defaults resolvidos para o app.
5. **App — cadastro (Super)**: seção "Configurações" na tela de Interfaces
   (interface 6), padrão da seção de privilégios existente.
6. **App — painel do cliente**: módulo `interface_configs` (padrão simétrico +
   ARQUITETURA_MODULOS.md), vitrine no molde do `interface_fields`; renderização
   por kind (Boolean=switch, Options=dropdown via SetesDropdown, Date=datepicker,
   demais=campo com validação do kind); i18n pt/en.
7. **App — atalho contextual**: ícone de engrenagem na tela de LISTA (decisão 11;
   contrato visual da skill criar-formulario-cadastro.md) → painel filtrado na
   interface corrente. **Ajuste 2026-08-03 (Valdo)**: a engrenagem só APARECE se o
   módulo tem configurações no catálogo (antes aparecia sempre e o painel dizia
   "não há configurações") — peça única `RegisterConfigButton`
   (`app/shared/register/register_config_button.dart`): consulta o GET resolvido
   do módulo na montagem (cache de sessão) e some quando a lista vem vazia; usada
   pela fábrica (`configModuleKey`) e direto no AppBar das telas de
   processo/árvore (service_orders, settlements, categories, financial_plans —
   as réplicas manuais de IconButton foram removidas).
8. **App — sessão + engine de consumo**: `app/shared/session/` (decisão 17); loader
   de config resolvida (molde FieldConfigLoader); piloto na tela Clientes
   (pré-seleção PF/PJ, Consumidor/Revenda; filtro de vendedor fixo/bloqueado na
   lista quando restrito).
9. **Skills/docs**: atualizar criar-formulario-cadastro.md (ícone na lista + consumo
   de config), novo-modulo.md, PADROES_BANCO.md (par catálogo × valor de config;
   hierarquia de papéis JÁ registrada em 2026-07-17) e docs de auth (padrão de
   sessão da decisão 17).

## Decisões arquiteturais registradas (Valdo, 2026-07-17)

### Rodada 1

1. **Contrato × Configuração**: recurso VENDÁVEL (abas de Projetos/Extintores/
   Parceria etc.) NÃO é config — é INTERFACE no catálogo, gate automático pelo
   contrato `tb_institution_has_interface`. `tb_*_config` guarda somente
   preferência/comportamento (arredondamento, impressão, defaults...), visível para
   todo cliente que tem a tela. É a resposta estrutural ao "zilhão" do Delphi:
   separar contrato de preferência.
2. **Catálogo × valor separados**: `tb_interface_has_config` (setes_central) ×
   `tb_institution_has_config` (schema do cliente) — espelho do par da Fase 2.
   Descrição/kind/default vivem UMA vez no catálogo; a tela-framework nasce dele.
3. **Config sem tela dona**: vira interface real "Configurações Gerais" no catálogo
   (contratável como qualquer outra) — `tb_interface_id` permanece NOT NULL, zero
   caso especial.
4. **Escopo por usuário decidido no catálogo**: `scope` 'I' (só institution) ou 'U'
   (admite override por usuário). Resolução do valor efetivo:
   usuário → institution → default do catálogo. Sentinel `tb_user_id = 0` para o
   valor da institution (coluna de PK não aceita NULL). Admin edita valores da
   institution; usuário comum edita só os próprios overrides de configs 'U'.
5. **Config por dispositivo** (ex-Config.ini, ex.: impressora): armazenamento local
   do app (shared_preferences/localStorage), FORA do banco na v1 — some ao trocar de
   máquina, comportamento igual ao Config.ini.
6. **Domínio de `kind`**: String | Integer | Float | Boolean | Date | Options —
   alinhado à Fase 2 + `Options` com lista fechada no campo `options`
   (formato `"A=Por item;B=Por total"`); Boolean renderiza switch, Options dropdown.
7. **As 3 pontas do fluxo**: catálogo cadastrado na seção "Configurações" da tela de
   Interfaces (Super); painel do cliente = módulo novo `interface_configs` no molde
   da vitrine do `interface_fields`; ícone de engrenagem abre o painel já filtrado
   na interface corrente (posição do ícone: decisão 11).
8. **Sem gate de visibilidade residual**: nenhuma flag/tabela extra para esconder
   preferência por cliente — com a decisão 1, a necessidade tende a desaparecer;
   reavaliar apenas diante de caso real.

### Rodada 2

9. **Grupos no catálogo**: interface "Configurações Gerais" e painel
   `interface_configs` ambos no grupo **'Sistema'** (precedente: interfaces 7 e 8);
   painel operável por qualquer usuário do cliente com privilégio na tela
   (precedente: decisão 9 da Fase 2 de campos).
10. **Piloto = 3 configs da tela Clientes** (tabela na seção Piloto): restrição por
    carteira do vendedor (ex-`GRL_G_VEND_LIST_CLIENTE`), predominância do tipo de
    pessoa (PF × PJ) e predominância do tipo de cliente (Consumidor × Revenda, aba
    Tributação).
11. **Ícone de configuração fica na tela de LISTA** — o padrão do produto é sempre
    lista → cadastro; o atalho contextual pertence à lista.
12. **Montagem canônica de menus PRESERVADA** (registro de invariante):
    `tb_interface.group_default` (agrupamento Setes) × `tb_module` +
    `tb_module_has_interface` (organização própria do cliente) são estruturas
    EXCLUSIVAS na montagem do menu; exceções: módulo Super (usuários super) e
    módulo Sistema (usuários admin). Nada nesta fase altera essa montagem.

### Rodada 3

13. **Interface-recurso**: coluna `kind char(1) NOT NULL DEFAULT 'T'` em
    `tb_interface` — 'T' = tela (vai a menu), 'R' = recurso/aba (NUNCA vai a menu;
    a tela pai consulta o contrato para montar/omitir). Os DOIS ramos da montagem
    de menu filtram `kind='T'`; exclusividade e exceções da decisão 12 intactas.
    Nesta fase entram só a coluna + filtro; a 1ª aba vendável real fica para a fase
    que a construir.
14. **Especificação do piloto APROVADA** (tabela da seção Piloto): nomes novos em
    inglês snake_case (nome Delphi na description), predominâncias scope 'U',
    restrição de carteira scope 'I', defaults `N`/`J`/`R`.
15. **Regra da restrição de carteira** (modernização do fluxo Delphi
    GB_CD_VENDEDOR/cargo vendedor): "é vendedor" = existe registro em `tb_salesman`
    com `id = userId` e `tb_institution_id` do JWT (`deleted='N'`) — sem depender do
    cadastro de salesman (onda 2), pois a tabela já existe no sql/03 e a herança por
    PK garante `tb_user.id = tb_entity.id = tb_salesman.id`. Com a config ligada,
    o usuário-vendedor tem o filtro FIXADO e BLOQUEADO (lista e GET :id na API;
    campo travado na UI); quem não é vendedor não sofre restrição. Filtros
    adicionais da tela de pesquisa (como no Delphi Un_Pesq_Empresa.pas) ficam para
    o futuro.
16. **Hierarquia de papéis registrada** (pedido do Valdo — JÁ aplicada em
    `setes-app/skills/cadastro-entidade-fiscal.md` e `database/PADROES_BANCO.md`):
    Entity → EntityFiscal → {Customer, Provider, Carrier, Bank, Institution,
    Collaborator → Salesman}. Colaborador pode ser só administrativo; todo vendedor
    É colaborador (precedência OBRIGATÓRIA). `tb_collaborator` ainda não existe —
    quando a onda 2 a criar, instituir a precedência (criação de salesman exige
    colaborador; avaliar FK `id → tb_collaborator` no revisar-ddl da onda).
17. **Padrão de estado de sessão** (delegado pelo Valdo — "aplique a melhor
    prática"; RATIFICADO na Rodada 4): seção "Padrão de estado de sessão" acima —
    JWT identidade mínima (invariante); fatos derivados na API via
    `shared/session-context` com cache TTL; app com `SessionContext` único em
    `app/shared/session/` (login preenche via bloco `context`, logout limpa,
    telas só leem); enforcement sempre na API; proibida variável global solta.

## Questões pendentes

**Nenhuma.** Rodada 4 (2026-07-17) ratificou a decisão 17 (padrão de estado de
sessão: `isSalesman` fora do JWT, bloco `context` no login + cache por request na
API; `app/shared/session/` como caminho único dos ex-`GB_*`) — prompt fechado.

## Fora de escopo desta fase

- Migração dos valores do TB_GERAL do Delphi (depende da revisão do sync)
- Implementação da 1ª aba vendável real (Projetos/Extintores) — só coluna+filtro (decisão 13)
- Ocultar CAMPOS por config (continua adiado — Fase 2, decisão 3)
- Config por dispositivo além do armazenamento local (decisão 5)
- `tb_collaborator` + precedência Collaborator→Salesman (onda 2 da Entidade Única — decisão 16)
- Refino "só quem tem papel de vendedor ATIVO" e filtros extras da pesquisa de
  clientes (decisão 15)

## Critérios de sucesso (fechar na convergência)

1. DDL aprovado por revisar-ddl + sqlglot, aplicado em sql/01, sql/03 + migrations.
2. Super cadastra config no catálogo pela tela de Interfaces; aparece no painel do
   cliente sem nenhuma linha de código de tela nova.
3. Piloto completo na tela Clientes: restrição de carteira ligada → vendedor vê só
   a própria carteira (lista e GET :id) com filtro travado na UI; não-vendedor e
   admin veem tudo; predominâncias pré-preenchem cadastro novo (decisões 14/15).
4. Resolução usuário → institution → default coberta por testes na API.
5. Ícone na tela de LISTA abre o painel filtrado na interface corrente (decisão 11).
6. Menus idênticos aos atuais para todos os perfis com o filtro `kind='T'` ativo
   (teste de regressão da montagem canônica — decisões 12/13).
7. Suporte consegue listar todas as configs existentes com descrição (painel/endpoint).
8. Swagger dos endpoints novos na mesma entrega.
