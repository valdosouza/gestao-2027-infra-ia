# Frente — Usuário convidado entre estabelecimentos (o mesmo login em clientes diferentes)

**Escopo**: misto (o conceito "dono da credencial × vínculo convidado", a busca do login sem revelar se o e-mail existe e o método de
separar o que é da CONTA GLOBAL do que é do VÍNCULO são portáveis; os pontos de código, as telas e as decisões são do Gestão 2027)
**Origem**: Q-PV39 do `prompts/prompt_privilegios_interfaces.md` (seção "Rodada 4" das Decisões, 2026-10-18). Ao avaliar a assunção A-PV13
("a conta com vínculo com OUTRO estabelecimento é só do Super"), o Valdo trouxe o cenário fornecedor × cliente e pediu para analisar se
abrimos uma frente. Esta é a Rodada 0 dela, aberta por sessão própria.
**Aberto em**: 2026-10-18. **Estado**: Rodada 0 ORGANIZADA — fatos (§2), o cenário passo a passo × o que falta (§3), parecer do guardião
(§4 — dois conceitos novos: o DONO da credencial = o cliente que a criou, e o CONVITE como fato próprio; o vínculo não muda de forma),
desenho em discussão (§5), conhecimento negativo (§6), questões **Q-UC1…Q-UC17** (§7, todas com recomendação). **Rodada 1 respondida EM
PARTE pelo Valdo na mesma sessão (2026-10-18) → D-UC1 (credencial nunca excluída, e-mail de login nunca muda — só se inativa), D-UC2
(inativar = o vínculo do próprio estabelecimento; os outros ficam iguais), D-UC3 (o dono do login é o dono do e-mail — diverge do guardião,
que punha o dono no cliente); a A-PV13 morre. 2ª resposta (mesmo dia) → D-UC4 (o convite é a CRIAÇÃO interceptada: vínculo inativo +
e-mail; o aceite ativa), D-UC5 (o perfil é de cada estabelecimento; "nada sobe para admin"), A-UC1 confirmada; análise das questões
restantes no §7.2 — sobram Q-UC11, Q-UC23, Q-UC24 + A-UC2…A-UC8 a ratificar (A-UC2 e A-UC3 primeiro).** Nada de código, DDL, seed ou commit. **⏯ Retomar pelo §11.**
**Regra dos dois grupos**: setes-sync e sincronizador NÃO foram lidos.
**Transversal**: toca setes-api (auth, users, institutions/onboarding, mailer), setes-app (login, troca de empresa, cadastro de usuários),
nfse-api (as guardas leem `tb_user_has_privilege` do schema do cliente — o convidado com privilégio fiscal transmitiria pelo cliente que o
convidou), a frente do grupo de estabelecimentos (`prompt_frente_grupo_estabelecimentos.md` — o mesmo mecanismo de "vincular um login que
já existe", dentro do mesmo cliente), a onda de privilégios (`prompt_privilegios_interfaces.md` — D-PV12, A-PV13, branch `privilegios-crud`
não mergeado) e a tarefa da força bruta no código de 6 dígitos (D-PV13 / Q-PV38, worktree `recuperacao-senha`, mexe no
`/auth/change-password`). Dizer isso de saída ao retomar.
**Consultas ao banco**: só leitura, sessão `READ ONLY` (o banco do dev é o de ensaio — `nada-em-producao`).
**Base do inventário**: `main` de cada repo (setes-api f53a618 · setes-app a450909); o que muda no branch `privilegios-crud` está marcado.

---

## 1. O pedido e o que já está decidido (herdado — não se rediscute aqui)

**Cenário do Valdo (literal, 2026-10-18)**: "tenho dois clientes, o cliente 1 é fornecedor do cliente 2. O cliente 2 poderia criar um
usuário (o mesmo usado no cliente 1) com permissões diferentes, como tirar relatório de estoque. O cliente 1, ao logar, poderia escolher
entre a própria empresa ou a empresa em que é fornecedor, vendo diferentes permissões. Analise se abrimos uma frente para isso."

**Ideia de partida** (da análise da Q-PV39): **dono da credencial** (quem criou o login gere senha, e-mail e exclusão) × **vínculo
convidado** (quem convidou gere só o próprio vínculo e os privilégios no próprio schema).

Herdado:
- **Decisão 10 da Fase 2**: `tb_user` controla só autenticação; `tb_institution_has_user.kind` é o perfil NAQUELE estabelecimento — "o mesmo
  usuário pode ter poderes diferentes por institution". O cenário já é o modelo; falta o ato de vincular um login que existe.
- **Decisão 14 da Fase 2**: `super` só vale no vínculo com a institution 1 (Setes). **Decisão 9 / D-F14 / D-GE16**: licença = o estabelecimento
  (`tb_institution.active`). **Decisão 19**: token final de 24 h sem refresh. **Decisão 23**: cliente nunca existe sem dono (o 1º admin nasce
  no onboarding).
- **D-PV10**: a Setes é cliente como os outros; só o super tem tudo. **D-PV12 (RATIFICADA)**: o admin mexe na conta (senha, e-mail, ativo,
  exclusão) de todos do próprio estabelecimento, menos a do super. **A-PV13 (NÃO ratificada — esta frente define; MORRE pela D-UC3)**: a conta com vínculo com
  OUTRO estabelecimento é só do Super. **D-PV13**: força bruta no código de 6 dígitos = tarefa própria (worktree `recuperacao-senha`).
- Frente do grupo: **D-GE3** privilégio POR estabelecimento (`tb_institution_id` volta à PK de `tb_user_has_privilege`); **D-GE14** o ato
  "estabelecimento no grupo" escolhe os admins ENTRE OS USUÁRIOS DO GRUPO, SEM E-MAIL NOVO; **D-GE15** admin do grupo DERIVADO (admin
  vinculado a todas as institutions do schema), sem `kind` novo; **D-GE21** a institution só enxerga o próprio schema.

## 2. Fatos (inventário só leitura no `main`; evidência com arquivo:linha)

### 2.1 setes-api — conta, vínculo, login

| # | Fato | Evidência |
|---|---|---|
| U1 | **O login é GLOBAL**: `setes_central.tb_user` (id = `tb_entity.id`, herança por PK; só senha MD5, `active`, `activation_key` — SEM dono, SEM autor). O e-mail de login é `tb_mailing` × `tb_entity_has_mailing` **grupo 2 'sistema'** (central, único no grupo 2). O NOME do usuário é o nome da ENTITY central (`name_company`/`nick_trade`). | `sql/01_setes_central_ddl.sql:86-96`; `setes-api/src/shared/user/index.ts` (`LOGIN_GROUP_ID`, `findLoginEmailOwner`); `src/modules/auth/auth.repository.ts:17-31` (`findUserByEmail`, LIMIT 1) |
| U2 | **O vínculo** `setes_central.tb_institution_has_user`: PK (institution, user), `kind` varchar(20) NULL (`user`/`admin`/`super`), `active` NULL, `deleted`, datas — SEM quem criou, SEM origem, SEM estado de convite. | `sql/01_setes_central_ddl.sql:276-290`; domínio tipado em `src/modules/users/users.dto.ts` (`USER_KINDS`) |
| U3 | **Login com N estabelecimentos já existe**: 1 vínculo vivo → token final; N → `select` + `selectionToken` (5 min) → `POST /auth/select-institution`; `POST /auth/switch-institution` troca sem relogar. Os dois revalidam o vínculo no banco (`issueForInstitution`); `getInstitutionsForUser` exige vínculo E institution ativos e vivos, sem ORDER BY. `super` fora da Setes vira `user`. | `src/modules/auth/auth.service.ts:38-103`; `auth.repository.ts:34-51`; `auth.routes.ts` (`/switch-institution` com `authMiddleware`) |
| U4 | **O token não reconfere o vínculo**: o final (RS256, 24 h) carrega `{institutionId, userId, role, schemaName}` e o middleware só verifica a assinatura. Revogar o vínculo ou rebaixar o perfil vale no PRÓXIMO login/troca — até 24 h depois (mesma família da **Q-R5.6**: JWT de usuário soft-deletado vale até expirar). Os privilégios do regular são lidos por requisição (efeito imediato); o admin passa o privilégio. | `src/gateway/auth.middleware.ts:13-24`; `prompts/prompt_primeiro_cliente_setes.md:954` |
| U5 | **Privilégio POR SCHEMA**: `tb_user_has_privilege` no schema do cliente (PK user+interface+privilege, SEM institution — D-GE3 devolve). O cadastro de privilégios do admin é FORÇADO ao schema do JWT, só oferece interfaces contratadas e pares do catálogo, e exige vínculo vivo do usuário com o estabelecimento. | `sql/03_schema_cliente_ddl.sql:887-905`; `src/modules/users/users.service.ts` (`resolvePrivilegeTarget`, `assertUserLinkedTo`, `saveUserPrivileges`) |
| U6 | **O 409 que trava o cenário e vaza o e-mail**: o admin cria usuário SEMPRE vinculado à própria institution (perfil `user` ou `admin`; `super` recusado); e-mail que já é login de alguém → `409 "E-mail já usado como login de outro usuário"` com `fields[email]` — **oráculo**: qualquer admin descobre se um e-mail existe em QUALQUER cliente. O mesmo código, na mesma casa, já faz o contrário no `recovery-password` (resposta sempre genérica: "Se o email existir, um código foi enviado"). | `src/modules/users/users.service.ts` (`assertLoginEmailFree`, `createUser`); `src/modules/auth/auth.service.ts:114-116`; `auth.routes.ts` (`/recovery-password`) |
| U7 | **Editar e excluir do admin mexem na CONTA GLOBAL**, não no vínculo: o PUT grava o nome da entity central (`updateEntity`), `tb_user.active`, a senha e o e-mail de login (`syncLoginEmail` soft-deleta o login antigo); o DELETE é soft delete do `tb_user` — o login morre em TODOS os clientes, e o vínculo fica vivo na tabela. **Não existe "desvincular" nem "inativar só aqui" para o admin.** | `src/modules/users/users.repository.ts` (`updateUserCascade`, `deleteUser`); banco (§2.3): 13 vínculos vivos para 3 usuários vivos |
| U8 | **No `main` a credencial está desprotegida**: o escopo do admin é só "vínculo vivo com a minha institution" (`assertInScope`, 404 fora) ⇒ o admin do cliente 2 trocaria senha/e-mail/ativo de um usuário que também é do cliente 1 e entraria no cliente 1 com o perfil dele (HIGH 2 do gate da D-PV11). Só não acontece porque vincular a 2 estabelecimentos é ato do Super. **No branch `privilegios-crud` (50b928f, não mergeado)**: `assertAccountManageable` — conta com QUALQUER vínculo (vivo ou adormecido) `super` ou com outra institution → `403 USER_MANAGED_BY_SUPER`. | `users.service.ts` (`assertInScope`, `editUser`, `removeUser`) no `main`; `git diff main privilegios-crud -- src/modules/users/users.service.ts`; `prompt_privilegios_interfaces.md` §11.9 |
| U9 | **Vínculo com vários estabelecimentos = só o Super**: `GET/PUT /api/users/:id/institutions` (`assertSuper`); `setInstitutionLinks` concede a lista e REVOGA o resto (`active='N'`), e REVIVE linha existente (`ON DUPLICATE KEY UPDATE active='S'`). | `users.service.ts` (`fetchInstitutionLinks`, `saveInstitutionLinks`); `users.repository.ts` (`setInstitutionLinks`) |
| U10 | **Onboarding exige e-mail NOVO para o 1º admin** (mesmo 409): a pessoa que já é usuária de outro cliente e abre a própria empresa não consegue ser o admin dela com o mesmo login. | `src/modules/institutions/institutions.service.ts:66-76` |
| U11 | **A relação comercial entre estabelecimentos já é PAPEL**: a institution É uma entity (`tb_institution.id = tb_entity.id`, reusada pelo CNPJ — Entidade Única); todo estabelecimento nasce `tb_customer` da Setes. Logo "o cliente 1 é fornecedor do cliente 2" = `setes_<c2>.tb_provider` com `id` = id da institution do cliente 1 (papel do schema do cliente, PK id+institution). | `src/modules/institutions/institutions.repository.ts:107-146`; `src/shared/entity/entity-fiscal.ts:232-255` (`resolveExistingByDocument`) |
| U12 | **O usuário é uma PESSOA, não a empresa**: `tb_user.id = tb_entity.id` (e `= tb_salesman.id` quando é vendedor — `isSalesman` do `SessionContext`). O convidado é a pessoa que trabalha no cliente 1. No dev, 2 dos 3 usuários vivos não têm documento; o super é a entity 1 (a própria Setes, com CNPJ). | `src/shared/session-context/session-context.types.ts`; banco (§2.3) |
| U13 | **Não existe assento**: licença = estabelecimento; nenhum limite/contagem de usuários no código nem na Infra-IA (busca por `seat`, `assento`, `max_users`, `limite de usu`). | decisão 9 da Fase 2; D-F14; grep em `setes-api/src` e `Infra-IA/` |
| U14 | **Trilha só no log**: nenhuma tabela de auditoria; o autor vai ao `logger.info` (no branch `privilegios-crud` a concessão de privilégio já leva `byUserId`/`byInstitutionId`/`byRole`). | `users.controller.ts` (diff `main` × `privilegios-crud`) |
| U16 | **E-mail de credencial excluída fica PRESO para sempre** (achado do guardião, conferido): `findLoginEmailOwner` não junta `tb_user` (não olha `deleted`) e o DELETE do usuário não solta o login (grupo 2), mas o login exige `u.deleted='N'` ⇒ ninguém mais entra com aquele e-mail e todo cadastro com ele dá o 409. Um convite para esse e-mail nunca seria aceito. Defeito ANTERIOR à frente. | `setes-api/src/shared/user/index.ts:40-52`; `src/modules/users/users.repository.ts:189-194`; `auth.repository.ts:17-31` |
| U17 | **O login recusa quem tem ZERO vínculos** (403 "Usuário sem institution ativa") antes de qualquer outra coisa — o aceite de um convite pendente teria de vir antes dessa decisão. O login já devolve o PERFIL de cada vínculo na lista de escolha. | `src/modules/auth/auth.service.ts:68-70`; `auth.repository.ts:34-51` |
| U18 | **Peça parada candidata**: `tb_contact (id, tb_institution_id, tb_entity_owner_id)` no baseline, sem consumidor — dá o molde de nome `tb_<tabela>_<papel>_id` e é candidata se um dia "a pessoa representa o papel X neste cliente" virar requisito (Q-UC9). Tabela sem consumidor não é morta. | `setes-api/src/migrations/sql/001_baseline.sql:311-320` |
| U15 | **E-mail transacional existe**: `@shared/mailer` (SMTP do `.env`; sem SMTP o código vai ao log) e o modelo do e-mail do código de recuperação — molde para o e-mail de um convite. | `src/shared/mailer/mailer.ts:10-12`; `auth.service.ts:114-152` |

### 2.2 setes-app — login, troca de empresa, usuários (inventário do `main` a450909)

| # | Fato | Evidência (`CORE` = `packages/core/lib/src/`, `WEB` = `apps/web/lib/app/`) |
|---|---|---|
| W1 | **Tela "Escolha o estabelecimento" já existe**: lista nome + perfil CRU (`super`/`admin`/`user`, sem tradução), "Definir como padrão" grava no aparelho (pré-marca, não pula), F5 perde a seleção (só volta ao login). O `context` da resposta do `select-institution` é descartado. | `CORE/auth/presentation/page/select_institution_page.dart:50-113`; `CORE/auth/data/datasource/auth_remote_datasource.dart:32-39`; `CORE/auth/presentation/bloc/auth_bloc.dart:203-254` |
| W2 | **O app guarda só o JWT** (`ProductToken` único para todas as APIs do produto); empresa, nome e perfil vêm de `GET /api/core/me` (`role`) quando pedidos. | `CORE/shared/http/product_token.dart:25-48`; `CORE/auth/domain/entity/session_user.dart:4-25`; servidor: `setes-api/src/modules/core/core.service.ts:27,44` |
| W3 | **O app NUNCA chama `/auth/switch-institution`** (só comentários e testes): trocar de empresa = sair e entrar. Não há botão. "Sair" não limpa `SessionContext`, `AuthBloc` (singleton) nem `CurrentInterface` — numa troca sem sair ficariam velhos o `UserBadge` (busca `/me` só no `initState`), o `CurrentInterface.value` e o `_isSuper` da tela de Usuários. (A frente do grupo já apontou o mesmo — G4 — e a lição da F2b: a troca zera o estado dos blocs e o token de TODOS os clientes HTTP.) | `CORE/shared/http/api_client.dart:41-42,188`; `CORE/auth/presentation/widget/user_badge.dart:62-78,117-163`; `WEB/modules/users/presentation/page/user_page.dart:75,87-97` |
| W4 | **A empresa atual quase não aparece**: a barra mostra o nome do usuário e a logo da empresa; "empresa · perfil" só ao abrir o menu do usuário, como item desabilitado, perfil cru. | `user_badge.dart:91-131,165-172`; `WEB/modules/home/presentation/content/content_home.dart:61,76-118` |
| W5 | **Cadastro de usuários** (`/home/users/`): nome, apelido, e-mail de login, senha, ativo — SEM perfil; o POST do módulo não manda `institutionId`/`kind` (a API força o JWT, perfil `user`). Abas Dados / Permissões (esta só depois de salvar). Super vê a seção Estabelecimentos (todas as empresas, caixa + perfil, grava na hora); o admin vê só Privilégios da própria empresa. | `user_page.dart:22-202`; `WEB/shared/users/entity/user_entity.dart:63-69`; `WEB/modules/users/presentation/widget/user_institutions_section.dart:12,69-150` |
| W6 | **O 409 do e-mail não tem tratamento próprio**: ancora no campo pelo `fields[]` com o texto em PT da API. | `CORE/shared/http/api_client.dart:259-270`; `user_page.dart:276-282` |
| W7 | **Senha**: "Esqueci minha senha" (código de 6 dígitos, `POST /auth/recovery-password` + `/auth/change-password`, sem sessão) para quem tem o e-mail; admin e Super definem a senha de outro pelo formulário; **não existe "alterar minha senha" logado**. | `CORE/auth/presentation/page/recovery_password_page.dart`; `change_password_page.dart:38-119`; `user_badge.dart:117-163` |
| W8 | **Aba Usuários do Estabelecimento (Super)**: sempre CRIA usuário novo (perfil `admin`/`user`); não vincula existente. | `WEB/modules/institutions/presentation/widget/institution_users_tab.dart:12-15,74-87,294-323` |
| W9 | **Nenhum texto de convite** (`convit*`, `convid*`, `invite*`, `guest`) em i18n ou código. | `apps/web/assets/translations/pt.json`/`en.json` |

### 2.3 Banco do dev (só leitura, sessão `READ ONLY`, 2026-10-18)

- 1 institution (a Setes, `setes_setes`) — **o cenário não se reproduz no dev sem um 2º cliente** (a prova pede schema descartável com 2
  institutions, como a fixture `two-institutions.ts` da D-GE4).
- 3 usuários vivos, cada um com 1 vínculo; 10 usuários excluídos com o vínculo ainda `active='S'` (U7); 13 vínculos vivos ao todo
  (1 `super`, 2 `admin`, 10 `user`). Nenhum usuário em 2 estabelecimentos; nenhum e-mail de login repetido; todo usuário com 1 login.
- `setes_setes` tem uma `tb_institution_has_user` LOCAL vazia (resíduo; a fonte é a central) — fora desta frente.

## 3. O cenário passo a passo × o que já existe × o que falta

| Passo do cenário | Hoje | Falta |
|---|---|---|
| 1. O admin do cliente 2 traz para o cliente 2 o login que a pessoa já usa no cliente 1 | **Recusado** com 409 que revela o e-mail (U6); só o Super vincula (U9, W8) | **decidido**: a criação interceptada — vínculo inativo + e-mail + aceite (D-UC4); falta onde fica "aguardando aceite" (Q-UC23) |
| 2. O cliente 2 dá permissões diferentes (ex.: relatório de estoque) | **Existe**: privilégio por schema para o perfil `user` (U5), tela de Permissões (W5) | **decidido**: o perfil é do estabelecimento que usa (D-UC5 — leitura na A-UC3); com o grupo, o privilégio por estabelecimento (D-GE3) |
| 3. Ao logar, a pessoa escolhe entre a própria empresa e a que a convidou | **Existe** a tela de escolha com o perfil (U3, U17, W1); trocar = sair e entrar (W3) | onde o titular aceita (Q-UC24 — Rec.: no login, antes do 403 de zero vínculos, U17); "minha empresa × convidado" na escolha (onda 2); trocar sem sair (onda 3 do grupo) |
| 4. Permissões diferentes em cada empresa | **Existe** (decisão 10: `kind` por vínculo + privilégio por schema) | — |
| 5. O admin do cliente 2 não pode tomar a conta (senha/e-mail) e entrar no cliente 1 | `main`: **furado** (U8); branch `privilegios-crud`: só o Super mexe (A-PV13) — nem o admin do cliente 1 troca mais a senha do próprio funcionário | **decidido**: o dono do login é o dono do e-mail (D-UC3) e o e-mail não muda (D-UC1); a senha é só do titular pela recuperação (A-UC2 — confirmar) |
| 6. O cliente 2 tira o acesso do convidado | **Não existe** para o admin: só inativar/excluir a CONTA GLOBAL (U7), que derruba o login no cliente 1 | **decidido**: inativa o PRÓPRIO vínculo, os outros ficam iguais (D-UC2); falta o código e o efeito imediato × 24 h (U4, Q-UC11) |
| 7. O cliente 1 desliga o funcionário | excluir/inativar a conta derruba o acesso a TODOS os clientes (U7) e prende o e-mail (U16) | **decidido**: só inativa o próprio vínculo; a credencial nunca é excluída (D-UC1) — ⚠️ e-mail corporativo (§6 item 9) |
| 8. Quem fez o quê | só log (U14) | quem convidou e quando aceitou (Q-UC23); o resto no log |

## 4. Parecer do guardião (`setes-conceito`, 2026-10-18 — integrado)

> ⚠️ O "dono = o CLIENTE que criou" e a peça 1 deste parecer foram **SUPERADOS pela D-UC3** (o dono do login é o dono do e-mail) — ver o
> "Ajuste pelas respostas do Valdo" no fim desta seção. O resto segue como proposta.

**Conceitos** — dois objetos novos, cada um com UM conceito; o vínculo existente NÃO muda de forma:

| Objeto | Conceito (uma frase, sem "e") | Nasce de quê |
|---|---|---|
| **Dono da credencial** | o CLIENTE que administra os dados de acesso de uma credencial | do nascimento da credencial (cadastro do usuário ou onboarding) |
| **Convite** | o pedido de um estabelecimento para que o titular de um e-mail aceite ser usuário dele | do ato do admin de convidar |
| Vínculo `tb_institution_has_user` (já existe) | o perfil de uma credencial num estabelecimento | do nascimento da credencial, do vínculo direto dentro do grupo (D-GE14) ou do ACEITE de um convite |

**Teste da maquete — o que reprova**:
- **"Pendente" como estado do vínculo**: todo leitor do vínculo (login, guardas, lista de usuários, admin derivado do grupo — D-GE15) teria de
  aprender que pendente não vale; e o convite para um e-mail sem login não tem `tb_user_id` para entrar na PK. Com o convite como fato
  separado e o vínculo nascendo só do aceite, a regra morre por construção.
- **`kind = 'guest'`**: a coluna passaria a carregar perfil E origem. "Convidado" é DERIVADO (o dono da credencial é outro cliente).
- **Dono derivado do vínculo mais antigo**: quando o dono revoga o próprio vínculo, o poder passa em silêncio ao convidante, que toma a conta
  (o mesmo argumento que derrubou o `MIN(id)` para a fundadora do grupo).
- **Dono "por ausência de convite"**: identidade por ausência — sintoma de maquete já listado na skill.
- **Flag de dono no vínculo**: exigiria a guarda "exatamente um dono por credencial".
- **A barreira da A-PV13 como está**: reprova o grupo (filial = outra institution do MESMO cliente — §6 item 7); com "dono = meu cliente"
  o problema desaparece.
- Dois convites pendentes para o mesmo par (estabelecimento, e-mail): sem guarda — vale o ÚLTIMO (molde `attempt` da transmissão e da
  apresentação do boleto); os anteriores ficam como história.

**Peças**:
1. **Dono = fato da credencial**: coluna `setes_central.tb_user.tb_institution_owner_id` = a CHAVE DO GRUPO (o cliente) do estabelecimento
   onde a credencial nasceu (PADROES §12 regra 1; hoje chave do grupo = a própria institution ⇒ neutro). Gravada UMA vez no nascimento; só
   muda por ato de transferência (Q-UC12). `NULL` = nenhum cliente administra (ficam o titular e o Super). Backfill: credencial com 1
   vínculo recebe aquele cliente; com vários ou nenhum, `NULL` — preserva por construção o comportamento de hoje (só o Super). Mora no
   `tb_user` porque é UM valor por credencial e é assunto de autenticação (decisão 10); uma tabela por schema deixaria dois clientes
   reivindicarem a mesma credencial.
2. **Convite**: `setes_central.tb_user_invitation` (na central — o login só lê a central e precisa ver o convite antes de existir schema
   escolhido). Forma proposta: PK `(tb_institution_id, tb_mailing_id, attempt)` (o endereço reaproveita `tb_mailing`, com `UNIQUE` e o molde
   `syncLoginEmail`) · `tb_user_inviter_id` · `outcome char(1)` (vazio = pendente; A aceito; R recusado; X retirado pelo convidante — domínio
   com `CHECK`) · `outcome_at` · `tb_user_responder_id` · colunas padrão. **Uma transição só** (emitido → um desfecho terminal): desfecho
   gravado uma vez na linha basta (precedente: `cutover_at`); eventos append-only são o molde de ciclos com várias transições (cheque,
   boleto). Expiração DERIVADA do tempo (`created_at` + constante da peça — proposta 7 dias), como o código de recuperação. Sem coluna de
   perfil enquanto a Q-UC6 for (a) (se entrar depois, é uma coluna a mais, não reforma). História: nunca se apaga (PADROES §3.1); revogar
   o vínculo depois não toca o convite.
3. **Composição** na peça `@shared/user` (que já existe) — dois predicados DERIVADOS + o ato de vincular:
   - **P1 `canLinkDirectly`**: a credencial tem vínculo vivo com alguma institution do grupo de quem pede (o nascimento é o caso zero). Cobre
     a D-GE14 (admins da filial escolhidos entre os usuários do grupo). P1 falso ⇒ o caminho é o convite.
   - **P2 `canManageCredential`** (e-mail, senha, nome): é o Super, OU (o dono é o cliente do admin E P1 E nenhum vínculo `super`, vivo ou
     adormecido). **P2 substitui a barreira da A-PV13**; com 1 vínculo por credencial dá exatamente o resultado de hoje (neutro).
   - **Aceite**: composição em transação única que grava o desfecho A e cria (ou revive) o vínculo com perfil `user`.
   - O dono só age com vínculo VIVO no próprio cliente: se ele revoga o próprio vínculo, o poder sai dele (o escopo de hoje já dá 404) e NÃO
     passa ao convidante; a credencial fica com o titular (código de 6 dígitos) e o Super. Religar a pessoa depois = convite — fecha o caso
     "ex-empregador religa em silêncio e assume a conta usada no cliente 2".
4. **Reusadas**: `tb_user` (credencial) · `tb_institution_has_user` (perfil, sem coluna nova) · `tb_user_has_privilege` no schema de quem
   convidou (por estabelecimento depois da D-GE3) · login com N vínculos (`select`/`switch`) · código de 6 dígitos (o titular gere a própria
   senha) · `tb_mailing` · `@shared/group` · molde `attempt` · gravação única monotônica (`cutover_at`) · soft delete (§3.1) · resposta
   genérica do `recoveryPassword`.

**O que NÃO entrou (e por quê)**: estado pendente no vínculo, `kind` 'guest', flag de dono (maquetes) · dono derivado (muda de mãos em
silêncio) · amarração à relação comercial `tb_provider` (prenderia o vínculo ao ciclo de vida do papel sem acrescentar nada à autorização —
Q-UC8) · assento (não existe; se nascer, a unidade é o vínculo vivo do estabelecimento — Q-UC13) · tabela de "admissão" pessoa × grupo
(derivada dos vínculos vivos — P1) · eventos do convite (uma transição só) · autor da revogação do vínculo como fato (vai ao log; virar fato
é decisão própria — Q-UC14) · transferência de dono (Q-UC12) · escopo de dados por fornecedor (Q-UC9) · convite no onboarding (o 1º admin
segue com e-mail novo, decisão 23 — Q-UC16) · e-mail de aviso como requisito (é UX: o aceite não depende de SMTP, o convite aparece no
login).

**Coerência com o grupo (pergunta H)**: é a MESMA peça de vínculo, com UMA política derivada de fatos (P1/P2) — nem parâmetro por tipo de
relação, nem dois conceitos. Dentro do grupo, o caminho é o direto (D-GE14); para outro cliente, o convite. Dependência do grupo: só a chave
do grupo — hoje = a própria institution, então esta frente pode andar ANTES da onda 1 do grupo.

**Nomes**: `tb_user.tb_institution_owner_id` (padrão `tb_<tabela>_<papel>_id` do `tb_contact` — `tb_institution_id` puro precisaria de
comentário, o que a skill reprova) · `tb_user_invitation` · peças `@shared/user` (predicados) e `@shared/user-invitation`. Linhas PROPOSTAS
para o glossário de palavras ocupadas da skill do guardião (entram só com a decisão — esta Rodada 0 não edita a skill):

| Palavra | Já significa | Se o seu conceito novo for parecido |
|---|---|---|
| **dono (da credencial)** | o CLIENTE (chave do grupo) que administra e-mail e senha de uma credencial (`tb_user.tb_institution_owner_id`); gravado no nascimento; só age com vínculo vivo no cliente dono. ≠ **titular** (a pessoa, que gere a própria senha pelo código) · ≠ "cliente nunca existe sem dono" (o 1º admin, decisão 23 da Fase 2) · ≠ dono do segredo (`secret-store`) | diga qual; "convidado" é DERIVADO (o dono é outro cliente), nunca coluna nem `kind` |
| **convite** (`tb_user_invitation`) | pedido de um estabelecimento para que o titular de um e-mail aceite ser usuário dele; vale a última tentativa do par; desfecho A/R/X gravado uma vez; só o aceite cria o vínculo | não use para convite comercial/marketing/e-commerce nem para transferir o dono |

**Divergências com decisões vigentes (o Valdo decide)**:
1. **D-PV12 (ratificada), pelo texto literal**: "o admin troca a senha de todos do próprio estabelecimento menos o super". O convidado É do
   estabelecimento de quem convidou ⇒ lida ao pé da letra, a D-PV12 REABRE o HIGH 2 (o admin do cliente 2 troca a senha e entra no cliente 1
   como a pessoa) → **Q-UC3**.
2. **A-PV13 (não ratificada)**: a barreira por "vínculo com outro estabelecimento" reprova o grupo; é trocada pelo P2 → **Q-UC2**.
3. **O cadastro de usuários de hoje mexe na conta global** ("Ativo" grava `tb_user.active`, "Excluir" apaga a credencial —
   `users.repository.ts:149-170`, `:189-194`) → **Q-UC5**.
4. **"Dono" ganha um 3º sentido** (decisão 23 e `secret-store`) — resolvido pela linha nova do glossário.
5. Compatíveis sem decisão nova: decisão 10 da Fase 2, D-GE14, D-GE15, D-GE18, D-PV10.

**Ajuste pelas respostas do Valdo (D-UC1…D-UC3, 2026-10-18)** — o parecer acima fica como história; vale o seguinte:
- A **peça 1 NÃO entra**: o dono não é um cliente, é o TITULAR do e-mail (D-UC3) — nenhuma coluna `tb_user.tb_institution_owner_id`, nenhum
  backfill, nenhuma transferência (Q-UC12 sem objeto). A prova de dono é a que a casa já usa: o código enviado ao e-mail.
- A **peça 2 (convite) segue** como proposta. "Convidado" passa a ser DERIVADO do fato do convite (o vínculo que nasceu de um convite
  aceito), não de "o dono é outro cliente".
- **P1 segue** (vínculo direto dentro do grupo — D-GE14). **P2 encolhe**: não há e-mail para trocar nem credencial para excluir (D-UC1); sobram
  a senha (Q-UC18), a senha inicial (Q-UC20), o nome (Q-UC21) e a inativação global (Q-UC19). "Ativo"/"Excluir" do cadastro = o vínculo (D-UC2).
- A credencial nunca é excluída nem muda de e-mail (D-UC1) ⇒ a credencial é IMUTÁVEL na identidade — o mesmo princípio da "entity existente
  é imutável" do sync.
- **Glossário** (linha proposta revista): **dono (do login)** = o TITULAR do e-mail de login (a pessoa que controla a caixa), provado pelo
  código no e-mail; ≠ "cliente nunca existe sem dono" (decisão 23) ≠ dono do segredo (`secret-store`). "Convidado" = vínculo nascido de
  convite aceito, nunca coluna nem `kind`. A linha de **convite** fica como acima.

**2º ajuste (D-UC4/D-UC5, 2ª resposta do Valdo)** — a **peça 2 (convite como tabela própria) também NÃO entra** (salvo se a Q-UC23 for (b)):
- O convite é a CRIAÇÃO interceptada: o vínculo nasce INATIVO no ato do admin e o aceite o ativa. A objeção do parecer a "pendente no
  vínculo" não se aplica: o pendente é `active='N'`, que todo leitor já trata como fora (login, guardas, lista, admin derivado do grupo) — não
  é estado novo. E o convite a e-mail SEM login (que tornava a tabela própria obrigatória, por não haver `tb_user_id` na PK) não existe: sem
  login, o estabelecimento CRIA.
- O que falta é distinguir "aguardando aceite" de "inativado" e saber quem convidou — fato gravado uma vez no vínculo (Q-UC23 (a)); o
  guardião confere a forma antes do DDL.
- Linha **convite** do glossário, revista: o ato em que um estabelecimento vincula, INATIVO, um login que já existe, e avisa o titular por
  e-mail; o aceite do titular ativa o vínculo; não é tabela nem `kind` — "convidado" = vínculo nascido assim.

## 5. Desenho (decidido em parte — D-UC1…D-UC5; o resto pelas recomendações)

**Quem pode o quê sobre a credencial e o vínculo** (depois das D-UC1…D-UC5; o que depende de assunção está marcado):

| Ato | Quem |
|---|---|
| Excluir a credencial (nem soft delete) | **ninguém**, nem o Super (D-UC1, A-UC1) |
| Trocar o e-mail de login | **ninguém**, nem o Super (D-UC1, A-UC1) |
| Senha (troca e inicial) | o **titular**, pela recuperação — global entre os estabelecimentos (D-UC3, A-UC2) |
| Nome da pessoa (entity central) | quem criou, enquanto não houver vínculo ativo com outro estabelecimento; depois o Super (A-UC7) |
| Inativar a credencial inteira (`tb_user.active`) | ninguém pela tela; o Super inativa os vínculos (A-UC5) |
| Criar usuário com e-mail novo | o admin e o Super, com o perfil que quiserem — `user`/`admin` (D-UC5) |
| Criar com e-mail que já é login (= convidar) | o admin e o Super — vínculo INATIVO + e-mail (D-UC4); perfil: A-UC3 |
| Ativar o vínculo interceptado pela 1ª vez | só o **titular**, aceitando (D-UC4; onde: Q-UC24) |
| Inativar / reativar o próprio vínculo ("demitir") | o admin daquele estabelecimento; os outros ficam iguais (D-UC2, A-UC8) |
| Privilégios no próprio schema | o admin daquele estabelecimento ("o dono do perfil" — D-UC5) |

**Fluxo DECIDIDO (D-UC4, com as recomendações das Q-UC23/Q-UC24)**: (1) o admin do cliente 2 abre "novo usuário" e informa o e-mail (e
o perfil); (2) e-mail sem login → cria a credencial como hoje (o cliente 2 é o 1º; senha pela recuperação — A-UC2); (3) e-mail que já é
login → o sistema intercepta: grava o vínculo do cliente 2, INATIVO, com o perfil, quem convidou e quando (Q-UC23), e manda o e-mail de
aviso; a lista mostra o e-mail "aguardando aceite", sem o nome (A-UC4); (4) a pessoa entra com o login de sempre, vê o cliente 2 aguardando
aceite e aceita (Q-UC24) → o vínculo fica ativo; (5) o admin do cliente 2 concede os privilégios (o relatório de estoque do cenário); (6) a
pessoa escolhe a empresa no login; (7) o cliente 2 "demite" = inativa o próprio vínculo — o cliente 1 segue igual (D-UC2).

**A D-PV12 depois da D-UC1…D-UC5**: das quatro coisas que ela dava ao admin ("senha, e-mail, ativo, exclusão"), o e-mail e a exclusão
deixam de existir (D-UC1), o "ativo" passa a ser do vínculo (D-UC2) e a senha passa ao titular pela recuperação (A-UC2) — confirmada a
A-UC2, a D-PV12 fica SUPERADA por inteiro.

## 6. Conhecimento negativo (o que NÃO fazer — vale qualquer que seja a decisão)

1. **Nunca dizer a quem convida ONDE o e-mail é login nem o NOME da pessoa antes do aceite** — o fluxo da D-UC4 já revela que o e-mail é
   login "em algum lugar" (A-UC4, limite aceito); o resto seria oráculo de enumeração entre clientes (U6).
2. **O ato sobre o VÍNCULO nunca toca a CONTA GLOBAL**: nome da entity central, e-mail de login, senha e `tb_user.active` são da
   credencial (U1, U7). Hoje o mesmo PUT do cadastro grava os dois — é a raiz do HIGH 2 (U8). Pela D-UC1, o e-mail de login nunca muda e a
   credencial nunca é excluída — nenhum caminho novo pode reintroduzir isso (nem "corrigir o e-mail", nem "limpar usuário antigo").
3. **`tb_user.active = 'N'` desliga a pessoa em TODOS os clientes** (U7) — não serve para "tirar o convidado"; inativar no estabelecimento é
   o vínculo (D-UC2). O soft delete do `tb_user` morre (D-UC1). E-mail digitado errado na criação = credencial nova com o e-mail certo +
   inativar o vínculo da errada (a errada fica sem vínculo vivo ⇒ o login dá 403 por construção, U17) — A-UC1.
4. **O `kind` do vínculo vira o `role` do JWT, e `admin` passa privilégio** (U4, U5): convidado `admin` = acesso a todo o contratado do
   anfitrião (e às telas do perfil admin — `users`, `establishment`, D-PV5). "Nada sobe para admin" (D-UC5): o perfil nunca passa sozinho de
   um estabelecimento para outro nem muda no aceite; se o vínculo interceptado pode nascer `admin` é a A-UC3.
5. **Revogar o vínculo só pega no próximo login** (token de 24 h, U4). Enquanto não houver reconferência por requisição, "revogado" quer
   dizer "não renova"; um convidado regular perde as telas na hora só se os privilégios forem revogados junto (Q-UC11).
6. **Privilégio sem institution na PK** (U5): com o grupo, o privilégio dado ao convidado num estabelecimento valeria nos outros do mesmo
   schema — a D-GE3 corrige; convite num cliente com filiais depende dela.
7. **A barreira da A-PV13 conta "vínculo com OUTRA institution"** (U8): com o grupo, a filial é outra institution do MESMO cliente ⇒ o admin
   do grupo perderia a gestão dos próprios usuários (colide com D-GE14/D-GE15). Quem decide "é de fora" não pode ser a institution — é o
   cliente (o schema) ou um fato de origem. **Resolvido pela D-UC3**: o dono é o titular do e-mail, então a barreira não depende de
   institution nenhuma; o que sobra de "só o meu cliente" é o nome da pessoa (A-UC7), e é pelo GRUPO.
8. **O nome do usuário é a entity central** (U1, U12): o anfitrião que "corrige o nome" do convidado reescreve a pessoa para todos os
   clientes — mesma família da "entity existente é imutável" do sync (A-UC7).
9. **Quem controla a caixa de e-mail controla o login em TODOS os clientes** (consequência da D-UC3 — o código de redefinição vai ao
   e-mail): com e-mail CORPORATIVO (`joao@cliente1.com.br`), quando a pessoa sai do cliente 1 é o cliente 1 que fica com a caixa — e
   pode redefinir a senha e entrar no cliente 2 como ela. Defesa: o cliente 2 inativa o próprio vínculo (D-UC2) assim que souber, e a
   revogação imediata (Q-UC11); a tela do convite deve dizer que o acesso segue o e-mail. Registrar como limite conhecido — não há
   correção que não seja trocar de e-mail, e o e-mail não muda (D-UC1).

## 7. Questões — Rodada 1 (respondida EM PARTE pelo Valdo em 2026-10-18 — o status de cada uma vem logo abaixo dela)

Formato: problema → evidência → opções; a recomendada vem primeiro com "(Rec.)". **Respostas do Valdo (2026-10-18) → D-UC1…D-UC3**
(ver "Decisões"): a Q-UC2 e a Q-UC5 FECHARAM; a Q-UC3, a Q-UC4, a Q-UC12 e a Q-UC15 ficaram SEM OBJETO ou SUPERADAS; a Q-UC6 e a Q-UC16
foram reescritas; as perguntas que as respostas abriram são a **Rodada 2 (§7.1, Q-UC18…Q-UC21)**. **2ª resposta do Valdo (mesmo dia)** →
D-UC4, D-UC5, A-UC1 confirmada; o destino de cada questão e as que sobram estão no **§7.2**.

**Q-UC1 — Como nasce o vínculo de uma credencial de OUTRO cliente?** (aceite × vínculo direto) — Hoje o 409 recusa (U6) e só o Super vincula
(U9). Quem convida: o admin (a tela `users` é do perfil admin — D-PV5) e o Super.
- **(a) Convite com ACEITE do titular, já logado; o vínculo só nasce do aceite (Rec.)** — consentimento da pessoa, nenhum dado dela volta a
  quem convidou antes do aceite, e o convite aparece no login (não depende de SMTP).
- (b) Vínculo direto pelo e-mail: o admin vê o nome da pessoa na hora, sem consentimento, e a resposta revela se o e-mail existe.
- (c) O titular gera um código e passa ao admin: consentimento antes, mas a pessoa não vê a empresa nem o perfil que vai receber.
→ **DECIDIDA pelo Valdo — D-UC4** (fluxo próprio, perto da (a)): o 2º estabelecimento INICIA A CRIAÇÃO do usuário, o sistema
intercepta o registro existente e cria o vínculo com o estabelecimento da sessão, INATIVO, com o perfil que ele determinar; avisa por e-mail;
o ACEITE do titular ativa o vínculo — as mesmas credenciais para todos os estabelecimentos.

**Q-UC2 — Quem é o DONO da credencial?** — Hoje nenhum fato diz (U1, U2); a A-PV13 decide por "vínculo com outra institution", que reprova o
grupo (§6 item 7).
- **(a) Fato gravado no nascimento = a chave do grupo do CLIENTE que criou (`tb_user.tb_institution_owner_id`); só age com vínculo vivo no
  cliente dono; o P2 substitui a A-PV13 (Rec.)** — neutro hoje (1 vínculo por credencial); o grupo é UM dono por construção.
- (b) Derivado do vínculo mais antigo — o convidante herda a conta quando o dono sai.
- (c) A-PV13 como está — credencial com vínculo em dois clientes fica só com o Super; o dono perde a troca de senha do próprio funcionário.
→ **DECIDIDA pelo Valdo — D-UC3** (DIVERGIU das três opções): *"o dono do login é o dono do e-mail"* — o dono é o TITULAR (a pessoa que
controla a caixa de e-mail), não um cliente; nenhuma coluna de dono; a A-PV13 morre (a barreira deixa de depender de institution).

**Q-UC3 — Como se lê a D-PV12 (ratificada) com convidados?** — O texto literal "todos do próprio estabelecimento menos o super" inclui o
convidado (ele É do estabelecimento de quem convidou) ⇒ reabre o HIGH 2 (§4, divergência 1).
- **(a) "O admin troca a senha de todas as credenciais do PRÓPRIO CLIENTE menos a do super"; a credencial de outro dono fica fora; quem
  convidou nunca mexe na credencial (Rec.)** — a regra do Valdo ("só o super sofre exceção") continua valendo para PESSOAS: a exceção nova
  é de credencial, não de pessoa.
- (b) Literal — quem convidou troca a senha do convidado (e entra no cliente dono com o perfil dele).
→ **SUPERADA pela D-UC3** (não existe "cliente dono" para ler na D-PV12): a pergunta que sobra — o admin ainda define a senha de alguém? —
é a **Q-UC18**.
→ **Valdo (2026-10-18, 2ª resposta)**: *"já temos o sistema de recuperação de senha, que será global entre os institutions, a parte da troca de senha
pelo admin"* — registrada como **A-UC2** (leitura a confirmar).

**Q-UC4 — O admin do DONO troca senha e e-mail de uma credencial que também é convidada em outro cliente?** (= devolver ao admin do dono a
troca de senha) — Na branch `privilegios-crud` só o Super troca (U8).
- **(a) Sim — convidar um login é confiar em quem o administra (a tela do convite diz isso); o dano fica limitado ao que quem convidou
  concedeu; o autor vai ao log (Rec.)**.
- (b) O dono só DISPARA o código para o e-mail do titular (a pessoa troca); trocar o e-mail de login fica com o Super.
- (c) Só o Super (a A-PV13 de hoje).
→ **SEM OBJETO pela D-UC1/D-UC3**: o e-mail de login não muda (D-UC1) e não há admin "do dono" (D-UC3); a senha é a **Q-UC18** e o nome da
pessoa a **Q-UC21**.
→ **Valdo (2026-10-18, 2ª resposta)**: *"revisar, pode remover com novas definições"* — **REMOVIDA**.

**Q-UC5 — "Ativo" e "Excluir" do cadastro de usuários do cliente atuam no quê?** — Hoje na CONTA GLOBAL (U7): derrubam a pessoa em todos os
clientes e prendem o e-mail (U16).
- **(a) No VÍNCULO, para todos os admins: cada cliente desliga só o próprio acesso; desligar a credencial em todos os clientes e excluí-la
  ficam com o Super (Rec.)** — neutro hoje (1 vínculo por usuário) e evita mais e-mails presos.
- (b) O dono continua desativando e excluindo a credencial (derruba o convidado nos outros clientes); quem convidou atua só no vínculo.
→ **DECIDIDA pelo Valdo — D-UC1 + D-UC2** (= (a), sem a exclusão pelo Super): *"não há exclusão de usuários nem alteração de logins… o
estabelecimento pode desativar um usuário pelo `tb_institution_has_user`… para outros institution permanece igual"* + *"uma vez criado só
pode ser inativado"*. Inativar a credencial INTEIRA é a **Q-UC19**.
→ **Valdo (2026-10-18, 2ª resposta)**: *"não se exclui nem softdelete... e sim desativar no tb_institution_has_user"* — **D-UC2 refinada** (inativar =
`active='N'`, nunca `deleted`, nem no vínculo) e **A-UC1 CONFIRMADA**.

**Q-UC6 — Perfil do convidado** (reescrita pela D-UC3: "convidado" = o vínculo que nasceu de um convite aceito). — `admin` passa todo
privilégio e dá as telas do perfil admin (§6 item 4).
- **(a) Só `user`; o vínculo nascido de convite também não sobe para `admin` depois (Rec.)**.
- (b) `admin` também — quem é admin no cliente 1 passaria, por um convite, a administrar o cliente 2 (inclusive os usuários dele).
→ **DECIDIDA pelo Valdo — D-UC5**: *"Nada sobe para admin"*; o 1º estabelecimento cria o usuário com o perfil que quiser; o
estabelecimento que intercepta determina o perfil dele ali; "o dono do perfil deste usuário é o institution que deseja usá-lo". O que
"perfil" quer dizer no vínculo interceptado: **A-UC3** (a confirmar).

**Q-UC7 — Grão do convite.** — O cliente que convida pode ter filiais (frente do grupo).
- **(a) Um convite por estabelecimento; depois do aceite, o grupo que convidou estende a pessoa aos próprios estabelecimentos sem novo
  convite, enquanto houver vínculo vivo no grupo (é o P1, o mesmo predicado da D-GE14) (Rec.)**.
- (b) Um convite por estabelecimento, sempre.
- (c) Convite ao grupo inteiro (tabela a mais de "admissão" pessoa × grupo).
→ **SAI desta frente (análise pedida pelo Valdo)**: pela D-UC4 cada estabelecimento é um vínculo com aceite próprio; ligar direto
entre estabelecimentos do MESMO grupo já é a D-GE14 — detalhe do ato "estabelecimento no grupo" (onda 3 do grupo).

**Q-UC8 — O convite se amarra à relação comercial (o cliente 1 é `tb_provider` no cliente 2 — U11)?**
- **(a) Não: a relação comercial é CONTEXTO, não pré-requisito — o convite é da PESSOA, a relação comercial é entre EMPRESAS; vale para
  contador, consultor, representante, transportadora (Rec.)**.
- (b) Convite só quando a empresa da pessoa convidada (o cliente 1) é papel (`tb_provider`, `tb_customer`…) no cliente que convida.
→ **FECHADA pela D-UC4 = (a)**: o fluxo vale para qualquer estabelecimento ("pode ser recontratado por outro institution com
novo perfil"), sem pré-requisito comercial.

**Q-UC9 — Requisito a confirmar: o fornecedor convidado vê o estoque INTEIRO ou SÓ o dos produtos dele?**
- **(a) O privilégio basta na primeira onda (vê o que a tela mostra a qualquer usuário com aquele privilégio) (Rec.)**.
- (b) Só o dele — pede uma peça própria "a pessoa representa o papel X neste cliente" (candidata: `tb_contact`, U18) + um escopo no molde
  da carteira do vendedor; frente própria, não o convite.
→ **SAI desta frente (análise)**: é requisito de PRODUTO (escopo de dados por fornecedor), não do login; a 1ª onda usa só os
privilégios — volta como frente própria se o Valdo pedir.

**Q-UC10 — Busca do login sem revelar o e-mail.** — O 409 do cadastro é oráculo (U6); o `recovery-password` já responde igual (U6).
- **(a) O ato de convidar responde UMA frase, exista ou não o login ("se houver acesso com este e-mail, o convite foi registrado"); o 409
  do "Criar usuário" fica como limite conhecido (revela que o e-mail é login em algum lugar, nunca onde nem o nome) (Rec.)**.
- (b) Fechar de vez: todo "adicionar usuário" vira convite e a credencial nasce no aceite, com a senha definida pelo titular — muda o
  cadastro e o onboarding (decisão 23) e passa a depender de entrega de e-mail.
→ **Vira A-UC4 (análise)**: no fluxo da D-UC4 o resultado já difere ("aguardando aceite" × "criado"), então o admin sabe que o
e-mail é login EM ALGUM LUGAR — nunca onde nem o nome (antes do aceite a lista mostra só o e-mail e o estado). É a opção (a) com o limite
conhecido.

**Q-UC11 — A revogação vale na hora?** — O token de 24 h não reconfere o vínculo (U4); mesma família da Q-R5.6.
- **(a) A guarda que já lê o privilégio a cada requisição passa a conferir o vínculo VIVO — no setes-api E nas guardas da nfse-api (o app
  usa o mesmo token lá — D-F4); fecha junto a Q-R5.6 (Rec.)**.
- (b) Limite conhecido: vale no próximo login ou troca de empresa, até 24 h depois.
→ **SEGUE ABERTA (necessária)**: "demitir e inativar" (D-UC2) precisa valer na hora — senão o demitido opera até 24 h com o
token antigo, no setes-api e na nfse-api.

**Q-UC12 — Transferir o dono** (o cliente 1 saiu e o cliente 2 quer "adotar" a pessoa).
- **(a) Ato do Super, fora da primeira onda; até lá, sem dono ativo, a credencial fica com o titular (código) e o Super (Rec.)**.
- (b) Ato do titular aceitando um convite de adoção.
→ **SEM OBJETO pela D-UC3 + D-UC1**: o dono é o titular do e-mail, e o e-mail não muda — não há o que transferir.

**Q-UC13 — Licença/assento do convidado.** — Não existe assento (U13); a licença é o estabelecimento (decisão 9, D-F14, D-GE16).
- **(a) O convidado não consome nada do estabelecimento que convida; se um dia nascer assento, a unidade é o vínculo vivo do
  estabelecimento (convidado conta como qualquer usuário de lá) — sem peça nova agora (Rec.)**.
- (b) Nasce já o conceito de assento (limite de usuários por estabelecimento, convidado incluído) — frente comercial própria antes do
  convite.
→ **SAI desta frente (análise)**: não existe assento; se nascer, a unidade é o vínculo ATIVO do estabelecimento — o convidado
conta como qualquer usuário de lá.

**Q-UC14 — Trilha.** — Hoje só log (U14).
- **(a) O convite carrega a trilha como FATO (quem convidou, quem respondeu, quando, desfecho); revogar/reativar o vínculo, trocar perfil e
  trocar senha pelo dono vão ao log com o autor (`byUserId`/`byInstitutionId`, como a concessão de privilégio no `privilegios-crud`) (Rec.)**.
- (b) Também a vida do VÍNCULO vira fato (eventos de concessão/revogação/troca de perfil) — peça própria.
- (c) Tudo só no log.
→ **Absorvida pela Q-UC23** (o fato do aceite e quem convidou moram no mesmo lugar).

**Q-UC15 — E-mail preso de credencial excluída (U16, defeito anterior).**
- **(a) Excluir a credencial SOLTA o e-mail de login (o vínculo grupo 2 é soft-deletado junto; a credencial fica como história); o e-mail
  pode nascer de novo como credencial NOVA (Rec.)** — o `findLoginEmailOwner` e o login passam a concordar.
- (b) Cadastrar com o e-mail de uma credencial excluída REVIVE a antiga (molde do revive dos bancos/fornecedor) — reacende vínculos
  adormecidos, o caminho de tomada de conta que o gate da D-PV11 achou.
- (c) Limite conhecido (o e-mail morre com a credencial).
→ **SEM OBJETO pela D-UC1** (não existe mais exclusão ⇒ nenhum e-mail novo fica preso). Resíduo: as 10 credenciais excluídas do dev (dado
de ensaio — `nada-em-producao`) seguem com o e-mail preso; o `DELETE /api/users/:id` sai na onda 0 (§8).

**Q-UC16 — Onboarding de cliente novo cujo admin já tem login em outro cliente** (U10; reescrita pela D-UC3 — a pessoa é dona do próprio
login, então nada impede que ela seja admin de um cliente novo).
- **(a) No onboarding (ato do Super), informar um e-mail que já é login liga a credencial existente como 1º admin (vínculo direto — o Super
  já vincula hoje, U9; o oráculo não importa para o Super); a decisão 23 segue cumprida (Rec.)**.
- (b) O 1º admin segue com e-mail NOVO (decisão 23 como hoje) — a pessoa precisaria de um segundo e-mail só para o cliente novo.
→ **Vira A-UC6 (análise)**: o onboarding cria o 1º admin — vale a mesma interceptação da D-UC4 (o vínculo admin nasce inativo e
a pessoa aceita); a decisão 23 segue (o cliente nasce com o seu admin, aguardando o aceite). Supera a Rec. (a) acima.

**Q-UC17 — App: escolha da empresa e troca sem sair.** — O app nunca chama `/auth/switch-institution` (W3); o perfil sai cru (W1, W4).
- **(a) Nesta frente: convites pendentes no login, "minha empresa × convidado" e perfil traduzido na escolha e no menu do usuário; a troca
  sem sair (com o reset de estado da F2b — blocs, `CurrentInterface`, token de todos os clientes HTTP) é UMA entrega com a onda 3 do grupo
  (Rec.)**.
- (b) Tudo nesta frente, inclusive a troca sem sair.
- (c) Só o mínimo (convites pendentes); o resto fica para o grupo.
→ **Reduzida (análise)**: o necessário (onde o titular aceita) é a **Q-UC24**; "minha empresa × convidado" e o perfil
traduzido na escolha são detalhe de tela da onda 2; a troca sem sair vai com a onda 3 do grupo.

### 7.1 Questões — Rodada 2 (abertas pelas respostas D-UC1…D-UC3; aguardam o Valdo)

**Q-UC18 — O admin ainda DEFINE a senha de alguém?** — A D-PV12 (ratificada) diz "o admin troca a senha de todos menos do super — é
rotina"; a D-UC3 diz que o login é do dono do e-mail. Hoje o admin digita a senha nova no formulário (W7) — com convidados, quem digita a
senha de uma pessoa entra com ela em TODOS os clientes onde ela tem vínculo (o HIGH 2).
- **(a) O admin não digita senha de ninguém: "trocar senha" no cadastro vira DISPARAR o código de redefinição ao e-mail do titular (o mesmo
  do "Esqueci minha senha", W7) (Rec.)** — mantém o motivo da D-PV12 (rotina do admin, sem o Super) e respeita a D-UC3; o HIGH 2 morre por
  construção. Revê o texto da D-PV12 ("troca" → "dispara").
- (b) O admin define a senha só da credencial cujos vínculos são TODOS do próprio cliente (o grupo); com vínculo em outro cliente, só
  dispara o código.
- (c) A D-PV12 literal (o admin define a senha de todos do próprio estabelecimento menos o super) — reabre o HIGH 2 com convidados.
→ **Respondida pela fala do Valdo na Q-UC3 — A-UC2** (a confirmar).

**Q-UC19 — Quem inativa a credencial INTEIRA (`tb_user.active`, todos os estabelecimentos de uma vez)?** — A D-UC1 diz "uma vez criado só
pode ser inativado"; a D-UC2 dá ao estabelecimento só o próprio vínculo.
- **(a) Só o Super (conta comprometida, pedido do titular) (Rec.)** — o cadastro do cliente deixa de gravar `tb_user.active`.
- (b) Ninguém: não há inativação global — o Super revoga os vínculos um a um (U9); a coluna fica sem escritor.
- (c) O titular também (um "desativar minha conta").
→ **Vira A-UC5 (análise)**: **Valdo (2026-10-18, 2ª resposta)**: *"o institution que criou pode simplesmente demitir o usuário e inativá-lo; e este mesmo
usuário dono da credencial pode ser recontratado por outro institution com novo perfil"* — a inativação é sempre do VÍNCULO.

**Q-UC20 — Senha inicial da credencial nova.** — Hoje o admin que cria digita a senha (W5). Com a D-UC3, quem criou conhece a senha até o
titular trocar — e com ela entraria em qualquer cliente que convidar a pessoa depois.
- **(a) A credencial nasce SEM senha (`password` NULL — o login já recusa NULL, `auth.service.ts:59-62`) e o titular define a dele pelo
  código no e-mail no 1º acesso; o admin só dispara o código (Rec.)** — coerente com a Q-UC18 (a) e com a Q-UC10 (b); depende de entrega de
  e-mail (o SMTP já existe — U15).
- (b) Como hoje: o admin define na criação e o titular troca depois pelo código.
→ **Segue a A-UC2**: se o admin não define senha, também não define a INICIAL.

**Q-UC21 — Quem altera o NOME da pessoa (a entity central — U1, U12)?** — O nome não é login (a D-UC1 não o cobre), mas é o mesmo para todos
os clientes onde a pessoa tem vínculo.
- **(a) O admin altera o nome só enquanto a credencial tem vínculo SÓ no próprio cliente (o grupo); com vínculo em outro cliente, o nome
  fica só leitura para os admins (o Super altera) (Rec.)** — o anfitrião nunca reescreve a pessoa para o cliente dela.
- (b) Qualquer admin com vínculo vivo altera (como hoje) — reescreve a pessoa para todos.
- (c) Ninguém depois de criado (a mesma regra do e-mail).
→ **Vira A-UC7 (análise)**: o nome é da pessoa (da credencial), não do perfil.

### 7.2 O que sobra depois da 2ª resposta (análise pedida pelo Valdo: "analise a necessidade das outras questões")

Das questões Q-UC1…Q-UC24 (a Q-UC22 — reativar um vínculo já aceito — nasceu direto como a assunção A-UC8), ficam **três necessárias** + as assunções da seção "Decisões" para ratificar (A-UC2 e A-UC3 primeiro — mudam o código):

| Questão | Destino | Por quê |
|---|---|---|
| Q-UC1, Q-UC2, Q-UC5, Q-UC6, Q-UC8 | decididas (D-UC1…D-UC5) | respostas do Valdo |
| Q-UC3, Q-UC18, Q-UC20 | A-UC2 (confirmar) | a fala da Q-UC3 tem duas leituras |
| Q-UC4, Q-UC12, Q-UC15 | sem objeto / removidas | D-UC1 e D-UC3 |
| Q-UC7, Q-UC17 (troca sem sair) | frente do grupo (onda 3) | D-GE14 e a mesma tela de troca |
| Q-UC9, Q-UC13 | fora de escopo (§9) | requisito de produto / assento inexistente |
| Q-UC10, Q-UC16, Q-UC19, Q-UC21 | assunções A-UC4…A-UC7 | consequência direta das respostas |
| Q-UC14 | dentro da Q-UC23 | mesmo fato |
| Q-UC22 (reativar) | assunção A-UC8 | consequência de "ele aceitando o ativa" + "pode demitir e inativá-lo" |
| **Q-UC11, Q-UC23, Q-UC24** | **seguem abertas** | mudam segurança ou DDL e não saem das respostas |

**Q-UC23 — Onde fica o fato "aguardando aceite" (e quem convidou/aceitou)?** — Pela D-UC4 o vínculo nasce INATIVO no ato do admin; inativo
também é o vínculo de quem foi demitido (D-UC2). Sem um fato próprio, a tela não distingue "aguardando aceite" de "inativado", e o aceite
não sabe se é a 1ª ativação.
- **(a) No próprio vínculo: `tb_user_inviter_id` + `invited_at` gravados no ato do admin e `accepted_at` gravado UMA vez no aceite
  (`active='N'` + `accepted_at` NULL = aguardando aceite); na criação (1º estabelecimento) o vínculo nasce ativo e aceito; nenhum leitor
  muda (todos já exigem `active='S'`) (Rec.)** — antes do DDL: guardião + `revisar-ddl`.
- (b) Tabela própria do convite (o `tb_user_invitation` do parecer do guardião) — uma peça a mais para um fato que é do vínculo.
- (c) Sem fato: "aguardando" e "inativado" ficam iguais na tela; a trilha só no log.

**Q-UC24 — Onde o titular ACEITA?** — A D-UC4 diz "envia o e-mail avisando; ele aceitando ativa".
- **(a) No app, depois de entrar com o próprio login: o login mostra os vínculos aguardando aceite (antes do 403 de zero vínculos — U17) e
  ele aceita; o e-mail só avisa e leva ao app (Rec.)** — o aceite exige a senha; nenhuma porta pública nova com token (a força bruta do
  código de 6 dígitos — D-PV13 — mostra o custo desse tipo de porta).
- (b) Por um link no e-mail (token de uso único), sem entrar — prova a posse do e-mail (D-UC3), mas abre uma porta pública nova.
- (c) Os dois.

## 8. Ondas (proposta — depende das decisões)

| Onda | Conteúdo | Observação |
|---|---|---|
| **0** | separar no setes-api o que é da CONTA do que é do VÍNCULO (D-UC1/D-UC2): o `DELETE /api/users/:id` sai (API e app); o PUT deixa de chamar `syncLoginEmail` (e-mail só leitura na edição); "Ativo" do cadastro grava `tb_institution_has_user.active` do próprio estabelecimento, nunca `tb_user.active` nem `deleted`; o cadastro deixa de definir senha (A-UC2); nome pela A-UC7 | sem convite ainda; corrige o HIGH 2 do `main` de vez; coordenar com a fusão do `privilegios-crud` (mesmo `users.service.ts`) |
| **1** | a criação interceptada (D-UC4) no cadastro e no onboarding (A-UC6): o 409 do e-mail vira o ramo "vincular inativo + aviso pelo `@shared/mailer`"; o fato "aguardando aceite" (Q-UC23, com DDL — guardião + `revisar-ddl` antes); o aceite (Q-UC24) antes do 403 de zero vínculos; inativar vale na hora (Q-UC11) | fixture com 2 clientes em schemas diferentes (o dev tem 1 — §2.3) |
| **2** | app: aceite no login (Q-UC24), "aguardando aceite" na lista de usuários, e-mail só leitura na edição, sem campo de senha (A-UC2), "minha empresa × convidado" e perfil traduzido na escolha | a troca sem sair (`switch-institution` com o reset de estado da F2b) vai junto da onda 3 do grupo |
| gate | revisão socrática + adversarial (vetores: tomada de conta por quem convida, enumeração além de "existe em algum lugar", ativar o vínculo interceptado sem o aceite, aceite por outra pessoa, reativação de vínculo nunca aceito, token velho depois de inativar) | gate de entrega do CLAUDE.md |

## 9. Fora de escopo

- O grupo de estabelecimentos (matriz × filiais) — frente própria; aqui só a coerência (§4, pergunta H).
- Força bruta no código de 6 dígitos e a tabela de redefinição de senha — D-PV13, tarefa própria (worktree `recuperacao-senha`).
- Reconferir o vínculo a cada requisição / refresh token — família da Q-R5.6; aqui só a decisão do que a revogação promete (Q-UC11).
- Portal do fornecedor (o fornecedor vendo pedidos de compra, cotações) — produto novo; o convite só dá acesso às telas que o anfitrião
  já tem, com os privilégios que ele concede.
- Escopo de dados por fornecedor ("só o estoque dos produtos dele" — Q-UC9) — frente própria se o Valdo pedir.
- Assento / limite de usuários (Q-UC13) — não existe; se nascer, a unidade é o vínculo ativo do estabelecimento.
- Vínculo direto entre estabelecimentos do MESMO grupo (Q-UC7) e troca de empresa sem sair (Q-UC17) — onda 3 do grupo.
- setes-sync e sincronizador (regra dos dois grupos).

## 10. Critérios de sucesso (da frente)

1. A mesma pessoa entra com UM login e escolhe entre a própria empresa e a que a convidou, com o perfil e os privilégios de cada uma.
2. Nenhum caminho exclui uma credencial (nem soft delete) nem troca o e-mail de login (D-UC1); nenhum admin define a senha de ninguém
   (A-UC2) — prova adversarial (as sondas do HIGH 2 viram teste).
3. Criar usuário com e-mail que já é login nunca cria segunda credencial: grava o vínculo inativo, avisa por e-mail, e só o aceite do
   titular o ativa (D-UC4).
4. Nenhuma resposta do cadastro nem do onboarding diz ONDE o e-mail é login nem o nome da pessoa antes do aceite (A-UC4).
5. Inativar no estabelecimento mexe só no vínculo dele — os outros estabelecimentos ficam iguais (D-UC2); a trilha diz quem convidou, quem
   aceitou e quem inativou.
6. Fixture com 2 clientes em schemas diferentes + o grupo (2 institutions no mesmo schema) — as duas frentes passam pela mesma barreira.

## 11. Retomada

**Onde paramos (2026-10-18, fim da sessão)**: Rodada 0 organizada + duas respostas do Valdo → **D-UC1…D-UC5** (credencial nunca excluída
nem com e-mail alterado — só se inativa; inativar = `active='N'` do vínculo do próprio estabelecimento; o dono do login é o dono do
e-mail; o convite é a CRIAÇÃO interceptada — vínculo inativo + e-mail, o aceite ativa; o perfil é de cada estabelecimento). A análise do
que sobra está no **§7.2**. Nada de código, DDL, seed ou commit; nenhum arquivo de outra frente foi editado.

**O que falta, nesta ordem**:
1. O Valdo **confirmar a A-UC2** (a senha é só do titular pela recuperação — o cadastro não define senha, nem na criação) e a **A-UC3**
   (o vínculo interceptado nasce `user`; o estabelecimento escolhe os privilégios). As duas têm leitura alternativa que reabre risco.
2. Decidir **Q-UC11** (inativar vale na hora), **Q-UC23** (onde fica "aguardando aceite" — Rec. (a): colunas no vínculo) e **Q-UC24**
   (onde o titular aceita — Rec. (a): no app, depois do login); ratificar **A-UC4…A-UC8**.
3. Com a Q-UC23 decidida: parecer do guardião (`setes-conceito`) sobre a forma + `database/PADROES_BANCO.md` + skill
   `database/skills/revisar-ddl.md`; DDL provado em schema descartável (o dev tem 1 institution — §2.3).
4. Anotar no `prompt_privilegios_interfaces.md` (quando o Valdo autorizar editar aquele prompt): a Q-PV39 respondida por esta frente, a
   A-PV13 morta (D-UC3) e a D-PV12 sem "e-mail" e "exclusão" (D-UC1/D-UC2) — e, confirmada a A-UC2, superada por inteiro.
5. Ondas do §8, só com o "vai": a onda 0 mexe no mesmo `users.service.ts` da branch `privilegios-crud` (não mergeada) — depois da fusão
   dela ou junto; a tarefa da D-PV13 (worktree `recuperacao-senha`, `sql/67`) é o sistema de recuperação que a A-UC2 usa — coordenar.

**Prompt curto para abrir a próxima sessão**:

> Frente do usuário convidado (`Infra-IA/prompts/prompt_frente_usuario_convidado.md`). Ler o §11 (onde paramos), o §7.2 (o que sobra) e
> as Decisões (D-UC1…D-UC5 + A-UC1…A-UC8). ⚠️ TRANSVERSAL: setes-api (auth/users/onboarding), setes-app (login/usuários), frente do grupo,
> onda de privilégios (`privilegios-crud` não mergeado — mesmo `users.service.ts`) e a tarefa da D-PV13 (`recuperacao-senha`). Aplicar as
> respostas do Valdo, registrar D-UCn (próximo número: **D-UC6**), varrer resíduos, nova rodada se aparecer problema. Banco só leitura;
> nada de código/DDL/commit sem o "vai".

## Decisões arquiteturais registradas

Herdadas e válidas sem decisão nova: decisões 9, 10, 14, 19 e 23 da Fase 2 · D-F14 · D-PV10 · D-GE3, D-GE14, D-GE15, D-GE16, D-GE18, D-GE21.

### Rodada 1 — respondida em parte (Valdo, 2026-10-18, nesta sessão)

- **D-UC1** (Valdo, literal: *"não há exclusão de usuários nem alteração de logins"* + *"uma vez criado só pode ser inativado"*): a
  credencial (`tb_user` + e-mail de login) **nunca é excluída e o e-mail de login nunca muda** depois de criado; o que existe é INATIVAR.
  Consequências: o `DELETE /api/users/:id` e o soft delete do `tb_user` morrem; o PUT do cadastro deixa de trocar o e-mail
  (`syncLoginEmail`) — campo só leitura na edição; a Q-UC15 (e-mail preso) fica sem objeto; a Q-UC12 também.
- **D-UC2** (Valdo, literal: *"o estabelecimento pode desativar um usuário pelo tb_institution_has_user… ou seja, para outros institution
  permanece igual"*): **inativar no estabelecimento = `tb_institution_has_user.active` do PRÓPRIO estabelecimento**; os vínculos com os
  outros estabelecimentos ficam iguais. Fecha a **Q-UC5 = (a)**, com uma diferença da Rec.: não há exclusão nem pelo Super (D-UC1). Inativar
  a credencial inteira = Q-UC19. Não exige DDL (a coluna existe — U2).
  **Refinada pela 2ª resposta** (*"não se exclui nem softdelete... e sim desativar no tb_institution_has_user"*): inativar é `active='N'` —
  nunca `deleted='S'`, nem no `tb_user` nem no vínculo; "demitir" no estabelecimento que criou é só isso, e a credencial e os outros
  vínculos ficam iguais.
- **D-UC3** (Valdo, literal: *"o dono do login é o dono do email"*): o DONO do login é o **TITULAR do e-mail** (quem controla a caixa — a
  prova é o código enviado ao e-mail, que a casa já usa); nenhum cliente é dono. Fecha a **Q-UC2** DIVERGINDO da Rec. (a) (que punha o dono no
  CLIENTE que criou): a coluna `tb_user.tb_institution_owner_id` NÃO entra; "convidado" = vínculo nascido de convite aceito (derivado do
  fato do convite). Supera a Q-UC3 (vira a Q-UC18), deixa a Q-UC4 e a Q-UC12 sem objeto e reescreve a Q-UC6 e a Q-UC16. **A A-PV13 morre**
  (a barreira deixa de depender de "outra institution"); o que sobra da barreira é a A-UC2 (senha) e a A-UC7 (nome).
- **D-UC4** (fecha a **Q-UC1** e a **Q-UC8**; Valdo, literal: *"Segundo institution inicia a criação do usuário, o sistema intercepta o
  registro existente, vincula com o institution do domínio, o institution determina o perfil deste usuário neste novo institution como bem
  quiser e envia o e-mail para o usuário avisando; ele aceitando o ativa o usuário no tb_institution_has_user, usando as mesmas credenciais
  para todos os institutions"*): **o convite é a CRIAÇÃO interceptada** — o admin usa a tela de sempre ("novo usuário"); e-mail sem login =
  criação normal (o estabelecimento é o 1º); e-mail que já é login = o sistema NÃO cria outra credencial: grava o vínculo do estabelecimento
  da sessão, INATIVO, com o perfil escolhido, e avisa a pessoa por e-mail; o aceite ATIVA o vínculo. Vale para qualquer estabelecimento, sem
  pré-requisito comercial. Consequências: o 409 `assertLoginEmailFree` do cadastro deixa de existir (vira o ramo da interceptação); não há
  convite para e-mail sem login (o caso do parecer que exigia tabela própria some); onde o aceite acontece = Q-UC24; o fato "aguardando
  aceite" = Q-UC23.
- **D-UC5** (fecha a **Q-UC6**; Valdo, literal: *"Nada sobe para admin"* + *"Primeiro institution cria o usuário com o perfil que quiser"*
  + *"O dono do perfil deste usuário é o institution que deseja usá-lo"*): o PERFIL é de cada estabelecimento — quem cria escolhe o perfil
  (`user` ou `admin`; `super` nunca, decisão 14); o estabelecimento que intercepta define o perfil da pessoa ali; nada passa sozinho de um
  estabelecimento para outro, nem o aceite muda o perfil. O que "como bem quiser" permite no vínculo interceptado = **A-UC3**.
- **Efeito sobre a D-PV12 (ratificada)** — anotar no `prompt_privilegios_interfaces.md` quando o Valdo autorizar a edição daquele prompt:
  das quatro coisas que ela dava ao admin (senha, e-mail, ativo, exclusão), o e-mail e a exclusão deixam de existir (D-UC1), o "ativo" vai
  para o vínculo (D-UC2) e a senha segue a A-UC2 — confirmada a A-UC2, a D-PV12 fica toda SUPERADA (o admin gere o vínculo e o perfil; a
  credencial é do titular). A Q-PV39 de lá fica respondida pela abertura desta frente.
- **Efeito sobre o código em worktree** (branch `privilegios-crud`, não mergeado): a barreira `assertAccountManageable` (A-PV13) passa a
  proteger só o nome (A-UC7) — com a A-UC2 o cadastro não define mais senha; o `removeUser` some com a D-UC1.

### Assunções (A-UC1 CONFIRMADA; as demais a ratificar)

- **A-UC1 — CONFIRMADA** pela 2ª resposta ("não se exclui nem softdelete") — a D-UC1 vale para TODOS, inclusive o Super: ninguém exclui
  credencial nem muda e-mail de login. E-mail digitado errado na criação = credencial NOVA com o e-mail certo + inativar o vínculo da errada
  (sem vínculo ativo, a errada não entra — 403 do login, U17).
- **A-UC2 — a senha é só do titular, pelo sistema de recuperação** (leitura da fala da Q-UC3: *"já temos o sistema de recuperação de
  senha, que será global entre os institutions, a parte da troca de senha pelo admin"*): o cadastro de usuários deixa de DEFINIR senha —
  nem na troca, nem na criação; a credencial nova nasce sem senha (o login já recusa senha vazia — `auth.service.ts:59-62`) e a pessoa
  define a dela pela recuperação; o botão do admin, se ficar, só dispara o código ao e-mail do titular. ⚠️ A outra leitura — "o admin
  continua trocando a senha, à parte" — reabre o HIGH 2 com vínculo em vários estabelecimentos: o admin do cliente 2 define a senha e
  entra no cliente 1 como a pessoa. **Confirmar.** (Fecha as Q-UC18 e Q-UC20.)
- **A-UC3 — no vínculo interceptado o perfil é `user`; "como bem quiser" são os PRIVILÉGIOS** (leitura de *"Nada sobe para admin"* +
  *"determina o perfil deste usuário neste novo institution como bem quiser"*): só o estabelecimento que CRIA escolhe `admin`; quem
  intercepta vincula como `user` e concede os privilégios que quiser (o "relatório de estoque" do cenário). ⚠️ A outra leitura — quem
  intercepta também pode dar `admin` — faz a pessoa administrar os usuários e as telas do perfil admin do cliente 2. **Confirmar.**
- **A-UC4** (da Q-UC10) — o fluxo revela ao admin que o e-mail já é login EM ALGUM LUGAR (o resultado é "aguardando aceite", não "criado");
  nunca ONDE nem o NOME: antes do aceite a lista do cliente 2 mostra só o e-mail e o estado.
- **A-UC5** (da Q-UC19) — ninguém inativa a credencial inteira pela tela: o cadastro deixa de gravar `tb_user.active`; conta comprometida
  = o Super inativa os vínculos (U9).
- **A-UC6** (da Q-UC16) — o onboarding de cliente novo segue a D-UC4: e-mail do 1º admin que já é login vira vínculo `admin` INATIVO
  aguardando o aceite (a decisão 23 segue: o cliente nasce com o seu admin); o 409 do onboarding deixa de existir.
- **A-UC7** (da Q-UC21) — o nome é da pessoa (da credencial), não do perfil: quem intercepta NÃO altera o nome (o que o admin digitou é
  descartado — a credencial já tem nome); quem criou corrige o nome enquanto a credencial não tiver vínculo ATIVO com outro estabelecimento;
  depois, só o Super.
- **A-UC8** (reativar) — o aceite é a 1ª ativação de um vínculo interceptado; depois dele, o admin daquele estabelecimento inativa e reativa
  o PRÓPRIO vínculo direto (D-UC2), sem novo aceite (o consentimento com aquele estabelecimento já foi dado). Vínculo nunca aceito só ativa
  pelo aceite.

## Questões pendentes

Depois da 2ª resposta do Valdo (análise no §7.2):
- **Confirmar primeiro: A-UC2** (a senha é só do titular pela recuperação — o admin não define senha) e **A-UC3** (no vínculo interceptado o
  perfil é `user`; o estabelecimento escolhe os privilégios) — as duas têm uma leitura alternativa que reabre risco.
- **Abertas e necessárias: Q-UC11** (inativar vale na hora), **Q-UC23** (onde fica "aguardando aceite" — Rec.: colunas no vínculo) e
  **Q-UC24** (onde o titular aceita — Rec.: no app, depois do login).
- **Ratificar**: A-UC4…A-UC8.
- Nenhuma trava as frentes vizinhas; a onda 0 desta frente (§8) mexe no mesmo `users.service.ts` da branch `privilegios-crud` — executar
  só depois da fusão dela ou junto, com o "vai".
