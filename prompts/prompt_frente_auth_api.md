# Frente — auth-api (autenticação + TODA a permissão do produto)

**Escopo**: setes
**Status**: Rodada 1 FECHADA (2026-10-31 — D-AU1…D-AU12; NENHUMA questão aberta). Execução pela D-AU6: costura A1 dentro do bloco de
privilégios (passo 4 do plano de retomada) + estreitar o GRANT da nfse-api na mesma janela (D-AU12) → ondas 0 do grupo e do convidado →
troca do hash (Q-EA9, D-AU11) → A2 (projeto `auth-api`) → A3 antes da Onda 4. (antes: Rodada 0 ORGANIZADA — inventário + guardião) (`memory/feedback-uma-pergunta-por-vez`). Nenhum código, DDL, seed ou commit desta frente. **2026-11-04: §7 "Caminho até a A2"** (cadeia conferida, decisões em ordem, dias); D-EA25 e D-EA26 decididas — próximo: o "sim" para fechar o item 0 do endurecer.
**Origem** (Valdo, 2026-10-31, ao ser perguntado da A-PV24 — a casa única da regra interface × privilégio —, literal): *"vamos criar uma
frente em que possamos criar uma auth-api que faria além da autenticação cuidaria de toda a parte de permissão seja para setes-app,
setes-api, nfe-api ou nfse-api ou outra api"*.
**⚠️ TRANSVERSAL** (dizer de saída ao retomar): setes-api (auth, users, privileges, interfaces, institution-interfaces, modules, core),
setes-app (login, seleção, `CurrentInterface`, menu), nfse-api (guardas), núcleo `fiscal-api` (`src/auth`, `src/erp/facts.ts`), nfe-api,
`sql/`. Branches em curso que tocam o assunto: `privilegios-crud` (+ `privilegios-catalogo`), `recuperacao-senha`, frente do convidado,
frente do grupo, `prompt_endurecer_autenticacao.md`. **Fora**: setes-sync e sincronizador (regra dos dois grupos — ver Q-AU9).
**Numeração própria**: questões **Q-AUn**, assunções **A-AUn**, decisões **D-AUn**.
**Método**: `skills-genericas/refinar-prompt-arquitetura.md` + `skills-genericas/guardiao-conceitual.md`.

---

## 0. Contexto — por que a frente

Hoje a autenticação (login, seleção de estabelecimento, emissão do JWT RS256 com kid — D-F13) e TODO o catálogo de permissões vivem no
setes-api; a nfse-api e o núcleo `fiscal-api` verificam o mesmo JWT e conferem privilégio por SQL direto no banco do produto; o app
decide botões por `CurrentInterface.can()`. Fatos conferidos no código em 2026-10-31 (worktree `privilegios/`, branch `privilegios-crud`):

- A regra do veredito "U pode V em I" existe em **quatro cópias + o app**: `setes-api/src/shared/auth/require-privilege.ts`,
  `fiscal-api/src/erp/facts.ts:137` (comentário literal: *"mesma SQL do setes-api"*), as guardas da nfse-api (`src/modules/guards.ts`) e o
  SQL do menu (`setes-api/src/modules/core/core.repository.ts`). `isSuper`/`isAdmin`/"institution 1" duplicados em
  `setes-api/src/shared/auth/roles.ts` e `fiscal-api/src/auth/product-jwt.ts` (parecer do guardião, §3 abaixo).
- O token leva o **`role`** (`setes-api/src/shared/auth/product-token.ts:107`) — rebaixar um admin só vale quando o token vence (24 h).
- A senha é **MD5 sem salt, hex maiúsculo** (`setes-api/src/shared/auth/password.ts:8-9`) — tema da Q-EA9.
- ⚠️ **Achado de segurança**: o usuário de banco da nfse-api tem `GRANT SELECT ON setes_central.*` (`nfse-api/ops/grants.sql`, seção 1) —
  lê `tb_user.password` (o hash MD5) e o código de recuperação, que ele não usa. Ver Q-AU12.

Precedente direto: a extração das APIs fiscais (`prompt_apis_fiscais_isoladas.md` §7 — D-F4 app cliente direto, D-F9 topologia 1 MySQL +
Node, D-F10/D-F15 leitura do ERP por views + GRANT mínimo, D-F12/D-F17 pastas e núcleo como biblioteca, D-F13 mesmo login RS256,
D-F19 "extrair no dev e só então a Onda 4").

## 1. Decisões vigentes que a frente toca (não se decide nada aqui — só o mapa)

| Decisão | O que diz | Efeito na frente |
|---|---|---|
| D-F13 | mesmo login; JWT RS256 com kid emitido pelo setes-api | o emissor passaria a ser a auth-api |
| D-F4 | o app fala com as APIs do produto por datasources dedicados | a auth-api vira mais um datasource do app |
| D-F9 | 1 MySQL + Node (setes-api, setes-sync, nfse-api, nfe-api) + Plesk | Q-AU7 (5ª instância) |
| D-F15 / D-F32 | leitura entre serviços por VIEW + GRANT mínimo | molde da conferência (Q-AU3) |
| **D-PV49** | o catálogo de privilégios mora num lugar só — **o setes-api**, "onde a interface nasce" | **a Q-AU1 (a) a REVÊ** |
| D-PV50…D-PV53 | regra definitiva interface × privilégio; igualdade registrado = operado; boot só alarma; API cita o verbo pelo NOME | a auth-api é o lado "registrado" da igualdade |
| D-PV29 | cache do veredito por PROCESSO (TTL) | Q-AU8 (N instâncias × revogação na hora) |
| D-PV56…D-PV60 | verbos independentes no propósito; todo verbo leva o VISUALIZAR na concessão; corrige ao salvar | regra da ESCRITA da concessão — muda de dono, não de forma |
| D-PV47 / D-RS* / D-PV48 / A-PV22 / A-PV23 | recuperação de senha volta; só o titular troca; script do Super; 1ª senha = criação da credencial | credencial é peça da auth-api (Q-AU5 pode matar a A-PV23 por construção) |
| D-UC1…D-UC12 | credencial do titular, nunca excluída; ativo = vínculo; convite; D-UC9 inativação vale NA HORA | vínculo e convite são peças da auth-api; "na hora" pesa na Q-AU3/Q-AU8 |
| D-GE3 / D-GE19…D-GE23 / PADROES §12 | privilégio POR estabelecimento; contrato de telas do GRUPO | `tb_user_has_privilege` ganha institution; licença é do grupo |
| Q-EA1…Q-EA12 | endurecer a autenticação (limite por conta, fato da falha, hash, revogação, TTL) | onde executam depende da Q-AU6; hash = Q-AU11 |
| A-PV24 (em suspenso) | casa única do texto da regra | resolvida pela Q-AU1/Q-AU2 |

## 2. Inventário (Rodada 0 — 2026-10-31)

Levantamento somente-leitura (agente Explore, 2026-10-31) das worktrees `privilegios/` (branch `privilegios-crud`),
`privilegios-catalogo/`, `recuperacao-senha/`, `ne2/` e do núcleo; achados centrais conferidos no disco pela sessão. ⚠️ O estado atual está
REPARTIDO entre três branches sem merge: guarda por roteador em `privilegios-crud`, cerca D-PV9 em `privilegios-catalogo` (anterior à
guarda — 16 pares), recuperação endurecida em `recuperacao-senha`.

### 2.1 Autenticação (setes-api)

- Rotas `POST /auth/login`, `/select-institution`, `/recovery-password`, `/change-password`, `/switch-institution`
  (`modules/auth/auth.routes.ts`); `/auth` público com o rate limit genérico (300/min por institution ou IP —
  `gateway/rate-limit.middleware.ts`); **sem limite por e-mail no login**.
- Login: acha o usuário pelo e-mail de login = e-mail do grupo 2 da CADEIA DE ENTIDADE (`tb_entity_has_mailing` + `tb_mailing` —
  `auth.repository.ts`), compara MD5, lista vínculos ativos; 1 vínculo → token final; N → token de SELEÇÃO (5 min) + lista;
  `resolveRole` rebaixa a `user` o super fora da institution 1. `tb_user.id = tb_entity.id`: o login depende de dado do ERP.
- Token (`shared/auth/product-token.ts`, peça única): RS256 com kid (HS256 recusado); final `{institutionId, userId, role, schemaName}`,
  24 h, **sem refresh**; `exp` obrigatório; boot recusa sem chave. A resposta do login traz também `context` (`isSalesman`, de `tb_salesman`
  no schema do cliente — `shared/session-context`, cache 60 s) — dado do ERP, não de acesso.
- **Sem logout nem revogação** no servidor (o app só apaga o token — `user_badge.dart`); `/auth/switch-institution` sem uso no app (só
  citada em comentário/teste).
- Senha: MD5 maiúsculo sem salt em `setes_central.tb_user.password` (usado também pelo cadastro e pelo onboarding). Recuperação: no `main`/
  `privilegios-crud`, código de 6 dígitos em `tb_user.activation_key`; na `recuperacao-senha` (4 arquivos, ~1,2 mil linhas), tabelas
  `tb_user_password_reset` + `_notice` (sql/67), código só como HMAC-SHA256 com chave **derivada por HKDF da chave privada do JWT**
  (`deriveProductSecret`, `product-token.ts:103`) — acoplamento: a recuperação acompanha a chave de assinatura.
- Variáveis (nomes): setes-api `JWT_PRIVATE_KEY_PATH`, `JWT_KID`, `JWT_PUBLIC_KEYS`, `PRIVILEGE_VERDICT_CACHE_TTL_MS`,
  `FLAG_CACHE_TTL_MS`, `SESSION_CONTEXT_CACHE_TTL_MS`, `SMTP_*`; nfse-api/nfe-api `JWT_PUBLIC_KEYS`/`JWT_PUBLIC_KEY_PATH`; núcleo
  `ERP_FACTS_CACHE_TTL_MS`.

### 2.2 Verificação nas outras pontas

- **nfse-api / nfe-api**: `productAuth`/`ProductTokenVerifier` do núcleo (`fiscal-api/src/auth/product-jwt.ts`), kid obrigatório, 401 com
  log por classe; identidade reconferida no banco (`erp.assertInstitutionSchema` lê `setes_central.tb_institution`). nfse-api: guardas
  `licensed`, `requireBranchPrivilege` (interface do ramo por `vw_order_interface`), `passScope`, `requireAdmin` (14 chamadas); sem cache de
  veredito. nfe-api: só autentica + `requireAdmin` em `/v1/emitter` (privilégio por ramo fica para a NE-5).
- **setes-app**: `CurrentInterface.can` (60 chamadas em 18 arquivos) lê o menu de `/api/core/menus` (libera enquanto o menu não chegou —
  UX; quem decide é o 403 da API); `SessionUser.isAdmin`; modo super por `role=='super' && institutionId==1`; `SetesAuthGuard` só confere
  o `exp`; token em `LocalPrefs` (localStorage/SharedPreferences, chave `session_token`); o `NfseApiClient` usa o MESMO token e confirma
  401 da nfse-api no emissor por `GET /api/core/me`. Sem cliente da nfe-api ainda.

### 2.3 Autorização no setes-api

- Guardas de módulo: `superGuard`/`superWriteGuard`, `adminGuard`, `gatedModule` (28 módulos; verbo HTTP → V/I/A/E) + 56 `privilegeAct`
  e 7 `openRoute` em 14 arquivos de rotas; `requirePrivilege`/`requirePrivilegeFor`/`requireInterfaceFor` (~37 usos, sobretudo billing).
- Núcleo da decisão `privilegeVerdict` (`require-privilege.ts`): licença antes do privilégio (`escapesLicense`/`licensedFor` — super passa
  tudo; admin passa o privilégio, não a licença; regular precisa de `tb_user_has_privilege`); cache por processo, TTL 60 s, invalidado em
  `users.repository` e `shared/institution-interfaces`. Mais: `delegatedSuperVerdict`, `configureVerdict`, políticas avulsas (desconto,
  canal bancário, escopo do admin em `users.service`), `featureFlagMiddleware` (fora dos módulos guardados — D-PV36).
- Cerca D-PV9 (só na `privilegios-catalogo`): `CONSUMED_PRIVILEGES` + varredura por AST/tokenizador de setes-api, nfse-api, app e ids do
  núcleo (`src/test-setup/privilege-fence.ts`, ~1 mil linhas); alarme no boot; `npm run check:privileges` trava o `build-web.ps1` (D-PV16).
  Ainda não lê `gatedModule`/`privilegeAct` (D-PV14 — `listGatedRoutes()` já existe como insumo).

### 2.4 Tabelas — onde moram, quem lê, quem escreve

| Tabela | Onde | Lê | Escreve |
|---|---|---|---|
| `tb_user` | central | setes-api | setes-api (users, onboarding, troca de senha) |
| `tb_institution_has_user` (`kind` = perfil) | central | setes-api | setes-api |
| `tb_user_has_privilege` | **cliente** | setes-api; **nfse-api via núcleo** (`facts.ts`) | setes-api (users) |
| `tb_privilege` | central | setes-api; nfse-api só pelos ids | setes-api (privileges) |
| `tb_interface` | central | setes-api; **nfse-api via núcleo** | setes-api (interfaces) |
| `tb_interface_has_privilege` | central | setes-api (menus, users, cerca) | setes-api (interfaces) |
| `tb_institution_has_interface` (licença) | **cliente** | setes-api; **nfse-api via núcleo** | setes-api (institution-interfaces, onboarding) |
| `tb_module`, `tb_module_has_interface` | cliente | setes-api (menus) | setes-api (modules) |
| `tb_feature_flag`, `tb_user_has_preference` | central | setes-api | setes-api |
| `tb_user_password_reset(_notice)` | central | recuperacao-senha | recuperacao-senha |
| `tb_institution` (sem coluna de tipo — "a Setes" = id 1 fixo no código, duplicado no núcleo) | central | setes-api; nfse/nfe (`assertInstitutionSchema`) | setes-api |
| `tb_sync_api_key` | central | setes-sync (não investigado — fronteira) | setes-api (`institutions.repository.ts`) |

### 2.5 Administração de acesso (endpoints × telas)

`/api/users` (adminGuard — `modules/users` + aba Usuários de Institutions) · `/api/privileges`, `/api/interfaces` (superGuard) ·
`/api/institution-interfaces` (gatedModule delegável) · `/api/admin/institutions/:id/interfaces`, `/feature-flags` (super local) ·
`/api/modules` (adminGuard) · `/api/core/me`, `/menus`, `/preferences`, `/theme` · `/auth/*` (login, seleção, recuperação, troca).

### 2.6 Tamanho do que sairia

- setes-api: ~65 arquivos / ~6,4 mil linhas de produção (`shared/auth`, `gateway` sem o router, `modules/auth`, `users`, `core` me/menus,
  `privileges`, `interfaces`, `institution-interfaces`, `modules`, `admin`, `feature-flags`, `session-context`, `shared/institution-interfaces`,
  `shared/user`, vitrine) + cerca (~1,5 mil) + ~18 testes (~2,4 mil). Não sai mas muda: ~100 marcações de guarda em 14 arquivos de rotas
  (passam a ler o veredito por biblioteca).
- nfse-api: 2 arquivos / 127 linhas; núcleo: `product-jwt.ts` (264) + ~60 linhas de `facts.ts`.
- app: sobretudo a URL base do login/admin (áreas envolvidas ~8 mil linhas).
- ⚠️ Partes que NÃO extraem limpo: e-mail de login pela cadeia de entidade (`tb_entity`), `isSalesman` no login, HMAC da recuperação pela
  chave do JWT — todos tratados pelas peças do §3 (credencial com o próprio e-mail; `context` fica no setes-api via `/api/core/me`; a chave
  vai junto com a recuperação).

## 3. Parecer do guardião (`setes-conceito`, 2026-10-31 — somente leitura)

**Conceito**: a auth-api é a **autoridade de acesso** do produto — responde "este portador pode exercer este verbo nesta interface deste
estabelecimento?". É um SERVIÇO que compõe peças, não uma peça: há dois fatos geradores — o **login** (credencial apresentada → token) e a
**concessão** (ato de quem concede → licença, vínculo, verbo); o veredito é a composição dos dois. O ganho é **um dono só do veredito**
(hoje quatro cópias), não um processo a mais.

| Peça | Fato gerador | Hoje |
|---|---|---|
| **Credencial** (hash, recuperação, falhas) | criação pelo admin / convite interceptado (D-UC4/D-UC8) | colunas de `tb_user` + sql/67 + Q-EA2 |
| **Token** (chave privada, kid, rotação, seleção, revogação) | login / seleção | `product-token.ts` |
| **Vínculo e perfil** (usuário × estabelecimento, user/admin/super, estado do convite — D-UC10) | ato do admin | `tb_institution_has_user` |
| **Registro interface × verbo** (D-PV50 itens 1–3) | desenvolvimento da interface | `tb_interface`, `tb_privilege`, `tb_interface_has_privilege` |
| **Concessão em dois níveis**: licença (Setes → estabelecimento, D-GE22) e privilégio (admin → usuário, D-PV57…D-PV60) | venda / ato do admin | `tb_institution_has_interface` × `tb_user_has_privilege` |
| **Veredito** "U pode V em I no estabelecimento X" | composição | as quatro cópias |

Licença e privilégio são o MESMO conceito (concessão) em níveis diferentes — mesma dona.

**Não é dela**: a operação em si; a DECLARAÇÃO de quais pares cada API opera (D-PV50 item 5 — fica no repositório de cada API; a auth-api é
o outro lado da igualdade da D-PV51); a pessoa e a cadeia fiscal (`tb_entity`); o menu (`tb_module*` — arranjo, D-GE20); catálogos de
campos e configs (comportamento, não acesso); preferências/tema; `session-context`; `tb_feature_flag` (a D-PV36 já a tirou do caminho).

**Como as outras APIs conferem** (Q-AU3): (a) permissões no token — enorme e velho por 24 h, contradiz a D-UC9 (o `role` no token já
tem esse defeito); (b) chamada HTTP à auth-api por requisição com cache — um dono, mas salto a mais, serviço mais quente, ponto único de
falha, chamada entre serviços que a D-F4 evitou; (c) VIEW publicada pela auth-api (`vw_user_access`, molde D-F15/D-F32: uma linha por
usuário × estabelecimento × interface × verbo permitido, já dobrando licença, vínculo vivo, credencial viva e perfil) — zero salto,
revogação na hora por construção, regra num SQL só; exige o leitor na mesma instância (D-F9 garante) e view fundível (PADROES §11.3), por
schema (precedente `vw_order_interface`, migration 068); (d) **combinação (Rec.)**: token só com identidade (`userId`, `institutionId`,
`schemaName`, `kid`, `iat` — sem `role`); veredito pela view para as APIs da instância; endpoint `/v1/access` para o app (menu e botões em
lote) e para API fora da instância; D-UC9 e Q-EA7 viram uma leitura só.

**Onde moram os dados** (Q-AU4): (i) tudo onde está, só o DONO da escrita muda (por GRANT); (ii) banco próprio `auth_api` para tudo — quebra
as FKs (ex.: `tb_user_has_privilege` → `setes_central.tb_user`, `sql/03_schema_cliente_ddl.sql`) e as linhas de negócio que guardam o
autor; PADROES §11.1 obrigaria a derrubá-las — maquete; (iii) **híbrido (Rec.)**: `auth_api` recebe só o NOVO e SECRETO (credencial,
recuperação, falhas, avisos); registro, vínculo e concessões ficam em `setes_central`/schema do cliente com escrita só pela auth-api e
leitura pela view; `tb_user_has_privilege` ganha `tb_institution_id` (D-GE3, PADROES §12).

**Onde vira maquete — o que NÃO levar do setes-api**:
- `tb_user` mistura dois conceitos: o ATOR (id = entity, autor do movimento, criado também pelo setes-sync sem senha) e a CREDENCIAL. Teste
  da maquete: a A-PV23 ("a 1ª senha numa conta sem senha é a criação da credencial") só existe para a estrutura não se contradizer. Com
  `tb_user_credential` separada, "sem credencial" = ausência da linha (Q-AU5).
- `role` no token; `kind` do vínculo misturando PERFIL (user/admin/super) com ORIGEM ('SYNC'); e-mail de login lido da cadeia de cadastro
  (pela D-UC1 ele nunca muda — é fato da credencial); MD5; cache em memória por processo copiado para N serviços (N janelas de revogação);
  números de privilégio no contrato (o contrato é por NOME — chave da interface + verbo, como a D-PV53); inventar `tb_role`/RBAC (perfil +
  verbo genérico — D-PV27 — já é o modelo).
- O MENU segue no setes-api, mas lê o veredito em vez de refazer o SQL.

**Ordem proposta** (Q-AU6) — extrair DEPOIS dos merges (molde D-F19), decidindo a frente AGORA para nenhuma branch criar uma 5ª cópia:
- **A0 (agora)**: Rodada 0 + decisões Q-AU.
- **A1 — costura, dentro do bloco de privilégios e das ondas 0 do grupo/convidado**: o veredito vira UMA peça com um SQL (a view), lida pelo
  setes-api, pelo núcleo e pelo menu; D-UC9, D-GE3 e Q-EA7 entram nela; as tabelas novas da recuperação (sql/67) e do endurecer (Q-EA2)
  nascem chaveadas por `tb_user_id` como filhas da credencial (mudam de banco sem reforma).
- **A2 — projeto `auth-api`**: recebe os escritores (login, users, privileges, interfaces, institution-interfaces) e a chave privada; o
  setes-api perde a escrita por GRANT.
- **A3**: antes da Onda 4 (não publicar topologia que muda logo depois — D-F19).
Redesenhar antes dos merges invalidaria os gates de cinco branches cujo comportamento a auth-api herda sem mudança.

**Nomes propostos**: serviço/pasta/repo `auth-api`, porta **3004** (3000–3003 ocupadas), `/v1` (D-F8); banco `auth_api` (nunca `setes_*`);
subpath de leitura `auth-api/access` (biblioteca, molde D-F33 — substitui a verificação do token e as funções de privilégio de
`fiscal-api/src/auth` e `erp/facts.ts`); peça no setes-api `@shared/access`; view `vw_user_access`; credencial `tb_user_credential` (1:1,
PK `tb_user_id`) com `tb_user_password_reset*` e `tb_user_login_failure` como filhas. Evitar **"sessão"** (ocupada: `session-context`,
sessão de caixa — dizer "token"/"login") e **"contrato"** (ocupada — dizer **licença**).

## 4. Rodada 1 — questões (uma por vez; recomendação do guardião entre parênteses, conferida)

- ✅ **Q-AU1 → D-AU1 (2026-10-31, (a)).** Texto original: **Escopo da auth-api.** (a) credencial, token, vínculo e perfil, registro interface × verbo, as duas concessões (licença e
  privilégio) e o veredito; (b) só autenticação — permissão fica no setes-api (a D-PV49 segue de pé); (c) (a) + menu, campos e configs.
  **Rec.: (a)** — é o pedido do Valdo; REVÊ a D-PV49 ("o catálogo mora na auth-api"), mantendo o princípio do verbo genérico.
- ✅ **Q-AU2 → D-AU2 (2026-10-31, (a)).** Texto original: **Dono de `tb_interface`.** (a) a auth-api (é o REGISTRO da D-PV50; campos e configs seguem apontando pela chave); (b) fica no
  setes-api e a auth-api lê por view. **Rec.: (a)** — a D-PV50 diz "registrada no sistema", não "numa API".
- ✅ **Q-AU3 → D-AU3 (2026-10-31, (d)).** Texto original: **Como as APIs conferem.** (a) token; (b) chamada HTTP; (c) view; (d) combinação (§3). **Rec.: (d)** — token sem `role`,
  veredito por view, endpoint para o app.
- ✅ **Q-AU4 → D-AU4 (2026-10-31, (iii)).** Texto original: **Onde moram os dados.** (i) onde estão; (ii) banco próprio para tudo; (iii) híbrido (§3). **Rec.: (iii)**.
- ✅ **Q-AU5 → D-AU5 (2026-10-31, (a)).** Texto original: **Separar a credencial do usuário-ator.** (a) `tb_user_credential` no `auth_api` (revê PADROES §6 "tb_user controla somente
  autenticação"; a A-PV23 morre por construção); (b) segue em `tb_user`. **Rec.: (a)**.
- ✅ **Q-AU6 → D-AU6 (2026-10-31, (a)).** Texto original: **Ordem.** (a) A0 → costura A1 dentro dos merges → A2 → A3 antes da Onda 4; (b) redesenhar antes dos merges; (c) só depois da
  Onda 4. **Rec.: (a)**.
- ✅ **Q-AU7 → D-AU7 (2026-10-31, (a)).** Texto original: **Topologia (D-F9): 5ª instância Node e 4ª URL no build.** (a) instância própria pequena (tráfego = login e concessão; o
  veredito é lido pela view); (b) começa como processo junto do setes-api. **Rec.: (a)**.
- ✅ **Q-AU8 → D-AU8 (2026-10-31, (a)).** Texto original: **Cache × "na hora" com N instâncias** (D-PV29 × D-UC9). (a) view lida a cada requisição, sem cache do veredito (uma consulta
  indexada); (b) manter TTL de 60 s. **Rec.: (a)**.
- ✅ **Q-AU9 → D-AU9 (2026-10-31, (a)).** Texto original: **`tb_sync_api_key`** (hoje emitida pelo setes-api, módulo institutions). (a) fora da frente — é do outro grupo, registrada como
  candidata; (b) a auth-api emite e revoga, o setes-sync só verifica. **Rec.: (a)**.
- ✅ **Q-AU10 → D-AU10 (2026-10-31, (a)).** Texto original: **Credencial de aplicativo sem humano** (frente S1; a D-F13 a pôs no setes-api). (a) passa para a auth-api quando a S1 nascer;
  (b) fica no setes-api. **Rec.: (a)**, sem execução agora.
- ✅ **Q-AU11 → D-AU11 (2026-10-31, (a)).** Texto original: **Hash.** (a) a auth-api só nasce depois da Q-EA9 decidida e executada; (b) nasce já com o hash novo e a migração transparente.
  **Rec.: (a)** — um caminho de migração só.
- ✅ **Q-AU12 → D-AU12 (2026-10-31, (a)).** Texto original: **GRANT da nfse-api em `setes_central`** (achado do §0 — independe da frente). (a) estreitar JÁ, na janela do bloco de
  privilégios: só as tabelas/colunas que o núcleo lê (nunca `password`/código de recuperação); (b) esperar a A1/A2 (a view resolve).
  **Rec.: (a)** — hoje um vazamento do usuário fiscal entrega os hashes MD5 de todos os logins.

## 5. Decisões

- **D-AU1** (Valdo, 2026-10-31 — fecha a **Q-AU1** = (a), literal: *"Acesso completo (a)"*) — a auth-api é a AUTORIDADE DE ACESSO do
  produto e dona das seis peças do §3: credencial (senha, recuperação, falhas), token (chave, kid, emissão, seleção, revogação), vínculo
  usuário × estabelecimento e perfil, registro interface × verbo (D-PV50 itens 1–3), as duas concessões (licença Setes → estabelecimento e
  privilégio admin → usuário, com a regra das D-PV57…D-PV60 na escrita) e o VEREDITO. Fora: a operação, a declaração dos pares que cada API
  opera (fica em cada repositório — D-PV50 item 5), a pessoa/cadeia fiscal, o menu, campos e configs, preferências, `session-context`,
  feature flags. **REVÊ a D-PV49**: o catálogo de privilégios mora na AUTH-API (não no setes-api); seguem de pé o princípio do verbo
  genérico (D-PV27/D-PV49 (3)) e a citação pelo NOME (D-PV53). A A-PV24 (casa do texto da regra) passa a ser da auth-api — forma na
  execução.
- **D-AU2** (Valdo, 2026-10-31 — fecha a **Q-AU2** = (a), literal: *"A auth-api (a)"*) — a auth-api é DONA de `tb_interface` (o
  REGISTRO da D-PV50: chave `i18n_key`, descrição, `kind` T/R) junto com `tb_privilege` e `tb_interface_has_privilege`. Ficam no setes-api,
  apontando para a tela pela CHAVE: catálogos de campos (`tb_interface_has_field`) e de configs (`tb_interface_has_config`) e o menu (que
  usa `group_default`/`position` — se essas colunas ficam na tabela da auth-api ou migram para o arranjo do menu é detalhe da execução, com
  o guardião). Consequência aceita: a tela "Interfaces" do Super fala com DUAS APIs (registro na auth-api; catálogo de configs — hoje
  `interfaces.routes.ts:122/157` — no setes-api).
- **D-AU3** (Valdo, 2026-10-31 — fecha a **Q-AU3** = (d), literal: *"Combinação (d)"*) — (1) o TOKEN leva só a IDENTIDADE (`userId`,
  `institutionId`, `schemaName`, `kid`, `iat`, `exp`) — o `role` SAI do token; (2) as APIs da mesma instância de banco (setes-api, núcleo
  `fiscal-api` → nfse-api/nfe-api) conferem pelo VEREDITO publicado pela auth-api como VIEW (`vw_user_access` — uma linha por usuário ×
  estabelecimento × interface × verbo permitido, já compondo licença, vínculo vivo, credencial viva e perfil; molde D-F15/D-F32; fundível —
  PADROES §11.3; por schema do cliente como a `vw_order_interface`), lida VIVA — revogação na hora por construção (D-UC9); (3) o app e
  qualquer API fora da instância usam `GET /v1/access` da auth-api (menu e botões em lote — perfil e "sou admin/super" saem daqui, não do
  token: `SessionUser.isAdmin` e o modo super da tela de usuários mudam); (4) a revogação de sessão da Q-EA7 (`iat` × fato da credencial)
  entra na MESMA leitura. Cache do veredito: Q-AU8.
- **D-AU4** (Valdo, 2026-10-31 — fecha a **Q-AU4** = (iii), literal: *"Híbrido (iii)"*) — banco próprio **`auth_api`** (nunca `setes_*`)
  só com o NOVO e SECRETO: credencial (hash, e-mail de login — forma: Q-AU5), recuperação de senha (`tb_user_password_reset*` do sql/67),
  falhas de login (Q-EA2) e avisos ao dono. Ficam ONDE ESTÃO, com ESCRITA só pela auth-api (o setes-api perde a escrita por GRANT) e
  leitura pela view da D-AU3: `tb_interface`, `tb_privilege`, `tb_interface_has_privilege`, `tb_institution_has_user` (`setes_central`);
  `tb_user_has_privilege` e `tb_institution_has_interface` (schema do cliente) — as FKs com o negócio (autor dos movimentos, usuário)
  seguem de pé. `tb_user_has_privilege` ganha `tb_institution_id` (D-GE3, PADROES §12). Efeito no achado do §0: o segredo sai do alcance
  de quem lê o banco do produto (o GRANT `SELECT setes_central.*` da nfse-api deixa de alcançar hash) — o estreitamento imediato segue na
  Q-AU12.
- **D-AU5** (Valdo, 2026-10-31 — fecha a **Q-AU5** = (a), literal: *"Separar (a)"*) — nasce **`tb_user_credential`** no banco `auth_api`
  (1:1 com o usuário, PK `tb_user_id`, sem FK entre bancos — PADROES §11.1), com o hash, o e-mail de LOGIN (fato da credencial, imutável
  — D-UC1; o login deixa de ser lido da cadeia de cadastro `tb_entity_has_mailing`) e as filhas (`tb_user_password_reset*`,
  `tb_user_login_failure`). `tb_user` segue em `setes_central` como o ATOR (id = entity; autor dos movimentos; criado também pelo
  setes-sync sem credencial). "Usuário sem credencial" = AUSÊNCIA da linha: a **A-PV23 deixa de ser exceção** (criar a credencial = criar
  a linha, uma vez só — a D-PV48 vale por construção). REVÊ o PADROES §6 ("tb_user controla somente autenticação") — atualizar na
  execução, junto do DDL (guardião + `revisar-ddl`). Migração das senhas atuais (MD5) para a nova tabela: com o hash novo — Q-AU11/Q-EA9.
- **D-AU6** (Valdo, 2026-10-31 — fecha a **Q-AU6** = (a), literal: *"Costura e depois extrair (a)"*) — ORDEM, molde D-F19:
  **A0** (agora) decisões Q-AU; **A1 — COSTURA** dentro do bloco de privilégios (passo 4 do §2 do plano de retomada) e das ondas 0 do grupo
  e do convidado: as branches entram COMO ESTÃO (gates preservados) e, na mesma sessão do bloco, o veredito vira UMA peça com UM SQL (a
  view `vw_user_access`) lida pelo setes-api, pelo núcleo e pelo menu — as 4 cópias morrem; D-UC9, D-GE3 e Q-EA7 entram nessa peça;
  tabela nova de credencial nasce chaveada por `tb_user_id` (muda de banco sem reforma); nenhuma branch cria uma 5ª cópia (regra para
  produtos, terminal, convidado, grupo). **A2** — projeto `auth-api`: recebe os escritores (login, users, privileges, interfaces,
  institution-interfaces), a chave privada, a credencial (D-AU5) e o banco `auth_api` (D-AU4); o setes-api perde a escrita por GRANT; token
  sem `role` (D-AU3). **A3** — antes da Onda 4 (não publicar topologia que muda logo depois). Custo aceito: o passo 4 cresce com a costura;
  a onda de campos (4a) parte do `main` depois dela.
- **D-AU7** (Valdo, 2026-10-31 — fecha a **Q-AU7** = (a), literal: *"Instância própria"*) — a auth-api é serviço PRÓPRIO desde a A2:
  pasta/repositório `auth-api` (raiz do workspace + espelho `Infra-IA/auth-api/`, regra de simetria), porta **3004**, `/v1`, deploy próprio
  (molde nfse-api); acrescenta à topologia da D-F9 o 5º processo Node e a 4ª URL no build do app (por configuração — `build-web.ps1`). A
  chave privada do token e a credencial saem do processo do ERP. Tráfego baixo por construção (login, seleção, administração de acesso,
  `/v1/access`); o veredito de cada requisição das outras APIs é lido da view, sem passar por ela.
- **D-AU8** (Valdo, 2026-10-31 — fecha a **Q-AU8** = (a), literal: *"Sem cache (a)"*) — SEM cache do veredito: toda requisição protegida
  lê `vw_user_access` VIVA (uma consulta indexada por usuário × estabelecimento × interface × verbo) — a revogação vale na hora em todas
  as APIs por construção (D-UC9), sem invalidação entre processos. **REVÊ a D-PV29** (cache por processo, TTL 60 s) a partir da costura A1
  (some `PRIVILEGE_VERDICT_CACHE_TTL_MS`). Item do gate da A1: `EXPLAIN` da view fundível, sem tabela temporária (PADROES §11.3). Se a
  medição mostrar peso, a decisão volta ao Valdo COM números (nunca reabrir cache por conta própria — conhecimento negativo).
- **D-AU9** (Valdo, 2026-10-31 — fecha a **Q-AU9** = (a), literal: *"Fica fora (a)"*) — a chave de sincronia (`tb_sync_api_key`, credencial
  de MÁQUINA do sincronizador no setes-sync) fica FORA da auth-api: o setes-api segue emitindo (módulo institutions) e o setes-sync segue
  verificando, sem mudança (regra dos dois grupos). Candidata registrada para rever COM o grupo do sync quando houver motivo — nunca
  decidida a partir desta frente. Na A2 a emissão continua no setes-api (não sai com os escritores de acesso).
  **Ampliada pelo Valdo no mesmo dia** (ao ler a Q-AU10, literal: *"aqui precisa registrar que as notas/pedidos que vem via setes-sync é
  apenas para manter histórico, toda autorização é feita no próprio pdv e os dados sincronizados são apenas para gerar dados para
  gerenciamento........então setes-sync fica fora do auth-api"*) — o **setes-sync INTEIRO fica fora da auth-api**, não só a chave: os
  pedidos e notas que chegam pelo sync são HISTÓRICO para o gerenciamento; a autorização (fiscal e de quem opera) acontece no PRÓPRIO PDV/
  retaguarda; nenhum dado sincronizado passa por veredito de acesso, e nenhuma pessoa opera pela porta do sync. Fato de domínio que vale
  além desta frente (registrado na memória `regra-dois-grupos-sync`).
- **D-AU10** (Valdo, 2026-10-31 — fecha a **Q-AU10** = (a), literal: *"Na auth-api (a)"*) — a credencial de APLICATIVO sem humano da frente
  S1 (D-F6: apps de TERCEIROS que operam direto na web — criam pedido no setes-api e pedem autorização à nfe-api/nfse-api; não é o PDV do
  legado, que fica no sync — D-AU9) nasce na AUTH-API, ao lado da credencial de pessoa: id + segredo só em hash trocados por token curto,
  um emissor de token só no produto. O setes-api segue dono do CONTRATO público de pedidos/faturamento da S1. Nada se executa agora (a S1
  não tem prompt aberto). **REVÊ em parte a D-F13** (a parte "credencial de aplicativo = S1, no setes-api, que emite o token").
- **D-AU11** (Valdo, 2026-10-31 — fecha a **Q-AU11** = (a), literal: *"Antes (a)"*) — ORDEM do hash: a troca do MD5 (Q-EA9 — algoritmo
  segue reservado ao Valdo na frente de endurecer) é decidida e EXECUTADA no setes-api, na onda de endurecer a autenticação, ANTES da A2;
  na A2 a credencial só muda de banco (`tb_user.password` → `tb_user_credential`, D-AU5), já no hash novo — as MD5 que sobrarem seguem
  migrando no login, pelo MESMO código levado para a auth-api. Uma mudança de risco por vez (banco × formato nunca juntos). Pré-requisito
  da A2: Q-EA9 executada.
- **D-AU12** (Valdo, 2026-10-31 — fecha a **Q-AU12** = (a), literal: *"Estreitar já (a)"*) — independe da frente: na JANELA do bloco de
  privilégios, o GRANT do usuário `fiscal_api` em `setes_central` deixa de ser `SELECT setes_central.*` e passa a LISTAR só as tabelas que o
  núcleo e as APIs fiscais leem. Conferido em 2026-10-31 (varredura do código de produção de `fiscal-api`, `nfse-api`, `nfe-api`): NENHUM lê
  `tb_user`; leem `tb_institution`, `tb_company`, `tb_entity`, `tb_person`, `tb_address`, `tb_city`, `tb_state`, `tb_interface`,
  `tb_interface_has_config`, `tb_tax_ibscbs_classification` (+ `tb_privilege` com a D-PV53). Na execução: a lista sai de VARREDURA do código
  (cerca no teste: tabela de `setes_central` lida pelo código ⊂ GRANT — tabela nova que o núcleo passar a ler entra no GRANT junto), provada
  em cópia descartável antes da janela; `tb_user`, `tb_user_password_reset*` e afins FORA. O `SELECT` nos schemas de cliente (`setes\_%`)
  segue — estreitar lá é outra conversa (a view da D-AU3 é o caminho).
  **Rodada 1 da frente FECHADA (D-AU1…D-AU12)** — próximo: execução pela ordem da D-AU6 (costura A1 no passo 4 do plano de retomada).
- **Costura A1 EXECUTADA em worktree (2026-10-31 → 11-01, passo 4 do plano 10-21)** — registro, provas, medição da D-AU8 e roteiro da
  janela no §14 do `prompt_privilegios_interfaces.md`. Assunções do parecer do guardião **A-AU1…A-AU4 e A-AU6…A-AU10 RATIFICADAS** (Valdo,
  2026-11-01, literal: *"Ratificar todas"*); a **A-AU5** virou a **D-PV62** (super e admin só por par REGISTRADO); a **A-AU11** (UNIQUE em
  `tb_interface.i18n_key` e `tb_privilege.description`) NÃO foi executada — questão própria (Q-PV67, §14 de lá).

## 6. Fora de escopo / candidatas

- Chave de sincronia (`tb_sync_api_key`) — Q-AU9; credencial de aplicativo (S1) — Q-AU10.
- Menu (`tb_module*`), campos e configs — ficam no setes-api (salvo Q-AU1 (c)).
- **Herança para a A2 (2026-10-31)**: o passo de boot que concede as telas ESTRUTURAIS a toda institution ativa (D-TM29,
  `prompt_frente_terminal.md` §10.10) nasce no setes-api e MUDA para a auth-api na A2, junto da escrita da licença.
- **Herança para a A2 (2026-10-31, D-RS15)**: o script `reset-super-password.ts` (D-PV46 + D-RS7/D-RS13/D-RS14) grava a credencial, logo
  MUDA para a auth-api na A2 junto dos outros escritores dela (D-AU6); passa a gravar em `tb_user_credential` (D-AU5) — e, se nascer o fato
  "senha definida por terceiro" ao lado dela, grava nele (`prompt_privilegios_interfaces.md` §13.10.5).
- **Entra na COSTURA A1 (2026-10-31, D-EA7 do `prompt_endurecer_autenticacao.md`)**: a revogação da D-AU3 (4) tem forma decidida —
  inativação pela view viva (sem instante); troca de senha pelo `iat` × fato próprio "senha definida em T" AO LADO do hash (nunca
  `tb_user.updated_at`, que todo salvar do cadastro toca), gravado só pelos escritores da senha; vai com o hash para `tb_user_credential`
  na A2. Tabelas da frente de endurecer que nascem antes da A2 em `setes_central` e mudam para o `auth_api` na A2: `tb_user_login_failure`
  (D-EA2) e `tb_user_login_notice` (D-EA3); canal de alarme `OPS_ALERT_EMAIL` é da operação (D-EA4). A linha `Auth OK` do
  `authMiddleware` sai na mesma costura (D-EA12). **Pré-requisito da A2 (D-AU11) DECIDIDO**: Q-EA9 → D-EA9 (`scrypt` nativo
  `N=2^15, r=8, p=3`, migração transparente no login) — falta EXECUTAR (Onda 4 do endurecer, depois das Ondas 1+2 e 3 — D-EA10).

## 7. Caminho até a A2 (2026-11-04 — frente da auth-api, sessão aberta pela orquestradora `local_7e8ede3a`)

**Pedido** (Valdo, 2026-11-04, pela orquestradora): *"abra uma sessão sobre auth-api, precisamos resolvê-la antes de continuar as
outras"*. **Como foi conferido** (só documento e código — nada presumido): este prompt; `prompt_endurecer_autenticacao.md` (Decisões,
§P.7–§P.9); `prompt_frente_usuario_convidado.md` (D-UC8, "Questões pendentes"); `prompt_privilegios_interfaces.md` (D-RS13, Q-RS13);
`prompt_frente_grupo_estabelecimentos.md` (D-GE3, §5, §10); `prompt_frente_campos_todas_telas.md` (§3.2, D-CF6, §5); na governança
(`D:\Setes-Governanca`, só leitura) `dados/auth-api.md`, `dados/setes-api.md`, `dados/setes-app.md`, `dados/FORMATO.md` §3 e a conta
`python -I ferramentas/conferir_dados.py dados --hoje 2026-11-04`; no código, a worktree `super-reset` (commit local `e8c9ee7` sobre o
`main` 42278bf; o `main` andou para 5cfd052 com a D-IB113) e `src/shared/http/controller-utils.ts:39` (o `handleError` comum loga
`{ err }` cru — 47 arquivos de `src/modules` o usam).

**Estado da conta em 04/11**: auth-api 2/12 passos (só a A0); os 10 restantes em "decisão a tomar" E "impedidos"; nenhum pronto para
começar; faltam 15–24 dias só da auth-api (A2 12–18 + A3 1–3 + deploy 2–3).

### 7.1 A cadeia conferida (o que segura a A2)

A A2 (`auth-api:AUTH.E2`) depende de quatro coisas do setes-api (governança: `AUTH.E2 → setes-api:AUTH.E5 · GRUPO.E3.P1 · CONV.E2`, e
`AUTH.E2.P4 → setes-api:CAMPO.E10.P1.T1`). A ordem vem das decisões: **D-AU11** (o MD5 sai antes da A2), **D-EA10** (TODAS as ondas
1+2 → 3 → 4 antes da A2; A2 depois das ondas 0 do grupo e do convidado), **D-AU6** (idem), **D-CF6** (o lado API do motor de campos vira
biblioteca, "execução: na A2").

| # | Elo | Segura | Fonte conferida | Estado em 04/11 |
|---|---|---|---|---|
| 1 | **Q-EA25** (erro cru do banco no log das demais telas) e **Q-EA26** (e-mail só para UM endereço) | `setes-api:SENHA.E7.P2` (fechar e publicar o item 0) → `AUTH.E3` (Ondas 1+2) → `AUTH.E4` (+ `setes-app:AUTH.E2.P1`, Onda 3) → `AUTH.E5` (Onda 4, scrypt) → toda a A2 | endurecer §P.8 (texto das duas, SEM ✅) e §P.9 passo 1; §P.7 (item 0 antes das ondas); D-EA10 | **abertas**. A fila única diz "respondidas em outra sessão" no sentido de "lá, não aqui" — aquela sessão foi arquivada em 01/11 (D-GP33) sem registrar decisão |
| 1b | Ensaio real do script do Super (sem `--vai`) | `SENHA.E7.P2.T3` — e por ele os 10 passos "impedidos" da auth-api | endurecer §P.9 passo 4; governança: impedimento de 01/11 | **ação só do Valdo** (o classificador recusa o agente) |
| 2 | **P-111** — "senha inicial definida por terceiro" vira registro durável? nasce com a credencial da auth-api ou na onda do convidado? | `setes-api:CONV.E2.P5` ("minha senha") → `CONV.E2.P6` (gates e janela) → toda a A2 | D-RS13 deixa as duas casas em aberto ("nasce depois, com a credencial da auth-api (D-AU5) / onda 0 do convidado (D-UC8)"); §6 deste prompt (D-RS15: "se nascer o fato…"); o prompt do convidado NÃO a registra (lá "nenhuma questão aberta", próximo número D-UC13) | **aberta só na governança** — falta virar questão de uma frente (proposta: do convidado, Q-UC28) |
| 3 | `setes-api:GRUPO.E3.P1` (privilégio por estabelecimento, D-GE3) | toda a A2 | grupo §10 e D-GE3 ("janela com plano: toca TRANSMITIR/CANCELAR"); a nota de 03/11 no fim do prompt do grupo (B2) não muda a onda 0 | **sem decisão pendente; pronto para começar** (processo conhecido, 2 dias). D-AU6/D-EA10 dizem "onda 0 do grupo"; a governança exige só o P1 (o único que toca concessão — P2 é o menu, que fica no setes-api; P3/P4 não são acesso). Leitura coerente com as decisões |
| 4 | `setes-api:CAMPO.E10.P1.T1` (motor de campos como subpath, D-CF6) + **P-CAMPO-4** (onde mora o pacote) | só `auth-api:AUTH.E2.P4` (escritores e GRANT) → P5 → P6 → P7 | D-CF6: "onde mora o pacote e a forma da leitura são **detalhe de execução, com o guardião**"; "execução: na A2" | ⚠️ ver §7.4: a governança põe o CAMPO.E10 depois do fecho da onda de campos inteira (CAMPO.E9), o que nenhum documento pede |
| 5 | Na própria auth-api: **P-1** (o que a A3 inclui) | só `AUTH.E3.P1` e o deploy — NÃO a A2 | D-AU6 ("A3 — antes da Onda 4", sem conteúdo); §3 "Ordem proposta" (idem) | aberta (decisão) |
| 5b | **P-2** (`group_default`/`position`) e **P-3** (casa do texto da regra, A-PV24) | `AUTH.E2.P4` e `AUTH.E2.P6` | D-AU2 e D-AU1 entregam as duas à execução, com o guardião | localizadas — resolvem-se no passo, não pedem o Valdo |

Restrição de calendário (não decisão): a Onda 1 do endurecer (`AUTH.E3`) e o aceite do convidado (`CONV.E2.P3`) mexem no `login` — nunca
em paralelo (D-EA10, D-UC12). A medição do peso do scrypt no servidor real (`P-AUTH-1`, suspeita) NÃO trava a Onda 4: a D-EA18 manda
executar com o peso provisório.

### 7.2 Decisões que faltam, em ordem de quem destrava mais

1. **Q-EA25** — junto da 2 destrava a cadeia mais longa: 7 passos do setes-api + 1 do app (item 0 → Ondas 1+2 → 3 → 4) e, por ela, os 7
   passos da A2. Recomendação do prompt: (a) frente própria "dado pessoal no log".
2. **Q-EA26** — mesma cadeia; a (a) mexe na `@shared/mailer` e entra no gate do delta final do item 0.
3. **P-111** — destrava `CONV.E2.P5` e `P6` (o convidado inteiro; P1–P4 já podem andar sem ela). Precisa antes ser escrita como questão
   da frente do convidado (Q-UC28).
4. **P-CAMPO-4** — destrava o `CAMPO.E10` (e por ele `AUTH.E2.P4…P7`). Pela letra da D-CF6 é detalhe de execução; se o Valdo confirmar
   isso, deixa de ser decisão dele e se resolve com o guardião no próprio passo.
5. **P-1** (conteúdo da A3) — não segura a A2; só depois dela.

Ações do Valdo que também seguram (não são decisões): o ensaio real do script do Super (`SENHA.E7.P2.T3`) e os "vai" de cada publicação
(item 0, Ondas 1+2, 3, 4, onda 0 do grupo, convidado).

### 7.3 Passos do setes-api/app a executar antes da A2 (estimativas da governança, em dias)

| Cadeia | Passos | Dias | Pronto hoje? |
|---|---|---|---|
| Endurecer (crítica) | `SENHA.E7.P2` 1 → `AUTH.E3.P1` 1 · `P2` 1–2 · `P3` 1 → `AUTH.E4.P1` 1–2 · `setes-app:AUTH.E2.P1` 1 · `AUTH.E4.P2` 1 → `AUTH.E5.P1` 1–2 · `P2` 1 | **9–12** | não (Q-EA25/26 + ensaio) |
| Convidado | `CONV.E2.P1` 1–2 → `P2` 2 → `P3` 1–2 → `P4` 1; `P5` 1–2; `P6` 2 | **8–11** | P1 sim; P5/P6 não (P-111) |
| Grupo | `GRUPO.E3.P1` 2 (janela com plano) | **2** | sim |
| Campos | `CAMPO.E10.P1` 1–2 | **1–2** (ou +7–8 da onda de campos inteira e as cadeias de produtos, terminal e IBS/CBS, se ficar a dependência do §7.4) | não |

Somados em fila: **20–27 dias** antes da A2 (sem a onda de campos). Em paralelo — endurecer ao lado de convidado, grupo e campos, com o
`CONV.E2.P3` fora da janela da Onda 1 — o caminho crítico é o endurecer: **~10–13 dias** (o +1 é o desvio do P3). Depois, a A2: 12–18.

### 7.4 Achados para a orquestradora (dados da governança — a frente só aponta)

- **`setes-api:CAMPO.E10` depende de `CAMPO.E9.P1`** (fecho da onda de campos, que por sua vez espera `PROD.E7.P2`, `TERM.E3.P2` e
  `IBS.E6.P5`, dois deles impedidos). Nenhum documento pede isso: a D-CF6 diz só "execução: na A2" e "a cerca da D-CF2 varre os dois
  repositórios" (o que pede a CERCA existir — `CAMPO.E5` —, não o fecho). Como está, a A2 herda a onda de campos inteira (7–8 dias + três
  frentes). Sugestão de pedido de mudança: `CAMPO.E10 → CAMPO.E5.P1` (ou sem dependência, com a T3 "a cerca varre a auth-api" só quando a
  cerca existir).
- **P-CAMPO-4** está com gate `decisão`; a D-CF6 a entregou à execução com o guardião (como P-2/P-3, que estão `localizada`).
- **P-111** está só na governança; precisa morar numa frente (proposta: convidado).
- **Fila única §0**: "Q-EA25 e Q-EA26 → respondidas em outra sessão" — a sessão foi arquivada sem registrar; seguem abertas e passam para
  esta frente (D-GP9: uma sessão por assunto — o assunto aqui é o caminho da auth-api).

### 7.5 Ponto de retomada

Próxima pergunta ao Valdo: **Q-EA25** (texto simples no relatório da sessão e na linha de 2026-11-04 de
`D:\Setes-Governanca\orquestracao\notas-das-frentes.md`). Ao voltar a resposta: registrar como **D-EA25** no
`prompt_endurecer_autenticacao.md` (Decisões + ✅ no §P.8) e trazer a **Q-EA26**; depois P-111 (registrar antes como Q-UC28 no prompt do
convidado), depois P-CAMPO-4. Execução de código só com o "sim" do Valdo para cada passo (governança de código: worktree, gates, "vai").

**2026-11-04 (mesmo dia)**: Q-EA25 → **D-EA25** (Valdo, *"a"*: frente própria "dado pessoal no log"; nada muda no item 0; abrir a frente
é da orquestradora). Próxima pergunta: **Q-EA26**.
**Regra de condução (D-GP53, Valdo, 2026-11-04, avisada pela orquestradora)**: perguntas e "vai" desta frente vão ao Valdo DIRETO na
sessão da frente — a governança não as leva; a cada parada segue uma linha em `D:\Setes-Governanca\orquestracao\notas-das-frentes.md`,
só como registro.
**2026-11-04**: Q-EA26 → **D-EA26** (Valdo, *"(a) Recusar em todos"*: a peça de e-mail recusa destinatário que não seja um endereço único
válido). Com ela o elo 1 do §7.1 fica SEM decisão pendente: `setes-api:SENHA.E7.P2` passa a esperar só o "sim" para executar (D-EA26 no
item 0 + gate do delta final + trazer o `main` + suíte) e, depois, o ensaio do Valdo e o "vai" do merge. Próxima pergunta: o "sim" do item 0.
**2026-11-04 — "Sim, executar"**: item 0 fechado na `super-reset` (commits locais 939b6bc · 80d1ab8 · acff626) — D-EA26 executada, `main`
trazido, gate do delta final socrático 0,80 · adversarial 0,78 sem HIGH, achados corrigidos (registro no §P.10 do
`prompt_endurecer_autenticacao.md`). O gate abriu **Q-EA27…Q-EA29** (nenhuma HIGH); com elas, o ensaio do Valdo e o "vai", o
`SENHA.E7.P2` fecha e as Ondas 1+2 (`AUTH.E3`) podem começar. Próxima pergunta: **Q-EA27**.
**2026-11-04**: Q-EA27 → **D-EA27** (*"(a) Só o do fim"*: aparado = só o espaço do fim, como o login; executada, `5c397f6`). Próxima: **Q-EA28**.
