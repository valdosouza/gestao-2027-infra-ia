# Prompt — Endurecer a autenticação do setes-api (login, senha, sessão)

**Status**: Rodada 1 FECHADA (2026-10-31 — D-EA1…D-EA12, "uma pergunta por vez", à luz da frente auth-api; NENHUMA questão aberta).
Execução pela D-EA10: revogação (D-EA7) e remoção do `Auth OK` (D-EA12) na COSTURA A1 (passo 4 do plano de retomada); depois Ondas 1+2 →
3 → 4, todas antes da A2. Mudaram de recomendação pela auth-api: Q-EA7 e Q-EA10. Antes: Rodada 0 ORGANIZADA (2026-10-21).
NENHUM código desta frente foi escrito; o que já existe (recuperação de senha endurecida, aviso ao dono, SMTP obrigatório em produção,
script do Super) está na branch `recuperacao-senha` e é PRÉ-REQUISITO (ver §1.3).
**Origem**: D-RS5 (Valdo, 2026-10-20 — fecha a Q-RS5 = (a): "prompt próprio de endurecer a autenticação"), nascida dos gates da
Q-PV38/D-PV13 (`prompt_privilegios_interfaces.md` §13). Numeração própria: questões **Q-EAn**, assunções **A-EAn**, decisões **D-EAn**.
**Referências**: `prompt_privilegios_interfaces.md` §13 (recuperação de senha, D-RS1…D-RS6, §13.10), `prompt_frente_usuario_convidado.md`
(D-UC6…D-UC12 — senha do titular, "minha senha", D-UC9 vínculo na guarda), `setes-api/prompt_fase2_gerenciamento_central.md` (decisão 2 =
MD5; decisão 14 = super só na institution 1; decisão 19 = JWT 24 h sem refresh), `database/PADROES_BANCO.md` (§3.1, §7, §9 regras 12–13),
`skills-genericas/refinar-prompt-arquitetura.md` (método). Grupo: setes-api ↔ setes-app (o setes-sync NÃO entra — regra dos dois grupos;
a `X-Api-Key` do sincronizador é outra porta).
**Escopo**: setes

---

## Contexto

A recuperação de senha (`/auth/recovery-password` + `/auth/change-password`) foi a primeira porta pública endurecida contra força
bruta (Q-PV38 → D-PV13 → D-PV47): teto de tentativas por código, teto de emissões por conta, resposta neutra em corpo/status/tempo,
código como HMAC, aviso ao dono (D-RS4), SMTP obrigatório em produção (D-RS5). O gate adversarial dela apontou o óbvio: **a porta mais
fraca agora é o `/auth/login`** — sem limite por conta, sem alarme, com senha mínima de 5 caracteres em MD5 sem sal e sessão de 24 h que
só morre por expiração. Esta frente organiza o endurecimento do RESTO da autenticação, em ondas, com as decisões reservadas ao Valdo.

## 1. Inventário — o que existe hoje (conferido no código em 2026-10-21, branch `recuperacao-senha` = `main` f53a618 + Q-PV38)

### 1.1 Portas e limites

| Porta | Guarda hoje | Lacuna |
|---|---|---|
| `POST /auth/login` | só o limite por IP do gateway: **300 req/60 s** (`rate-limit.middleware.ts`, chave = institution do JWT ou IP; cabeçalhos `RateLimit-*` ligados) | **nenhum limite POR CONTA**; nenhum contador de erradas; nenhum alarme; a falha não vai ao log (`fail()` só loga erro não-HTTP) |
| `POST /auth/select-institution` | token de seleção RS256, **5 min** | — (depende do login) |
| `POST /auth/switch-institution` | JWT final + revalida o vínculo no banco | — |
| `POST /auth/recovery-password` · `/change-password` | Q-PV38: 5 erradas/código, 3/h e 10/24 h por conta, memória por e-mail (5 e 10 por 15 min), piso 400 ms, HMAC, aviso ao dono 1/h (D-RS4) | `trust proxy` desligado — o limite por IP vale só sem proxy (D-RS2 → Onda 4) |
| `/api/*` | `authMiddleware`: assinatura RS256 + `kid` + `exp` (`product-token`) | **não confere se o usuário segue ativo nem se o vínculo segue vivo** (D-UC9 vai conferir o vínculo na guarda — frente do convidado) |
| `/hooks/bank-channel/*` | token do canal no path + limite por IP | fora desta frente (Onda 2 do Inter) |

### 1.2 Credencial, sessão e mensagens

- **Hash**: `md5Password` = MD5 **maiúsculo, sem sal** (`@shared/auth/password`; decisão 2 da Fase 2 — "risco de rainbow table aceito",
  2026-07). Comparação por igualdade de string (`toUpperCase() !==`), não em tempo constante. Vazamento do banco = senhas de 5–8
  caracteres recuperáveis em minutos.
- **Política de senha**: mínimo **5** caracteres, máximo 100 (`users.dto.ts` POST/PUT; `changePassword` recusa < 5 com 400). Sem
  composição, sem lista de senhas comuns, sem comparar com o e-mail, sem histórico. O app só reflete o mínimo.
- **Sessão**: JWT final RS256 com `kid`, **TTL 24 h, sem refresh** (decisão 19 da Fase 1; PADROES §7). **Não há revogação**: trocar a
  senha (pelo código, pelo admin ou pelo script do Super) ou inativar o usuário NÃO derruba a sessão aberta — vale até o `exp`
  (limite registrado no §13.7 do prompt de privilégios).
- **Mensagens do login**: "Email ou senha inválidos" (401) cobre conta inexistente e senha errada — neutro; mas **"Usuário inativo" (401)
  e "Usuário sem institution ativa" (403) revelam que a conta EXISTE** (oráculo de enumeração, pequeno).
- **Log**: o `authMiddleware` grava `Auth OK` com institution e path em TODA requisição autenticada (volume, não segurança); falha de
  login não deixa rastro; sucesso de login não deixa rastro além do `Auth OK` das chamadas seguintes.
- **Quem define a senha**: hoje o admin cria e TROCA a senha de qualquer usuário do seu estabelecimento (menos a do super — D-PV12). A
  onda 0 do convidado muda isso (D-UC6/D-UC8: o admin define só a INICIAL; "minha senha" = senha atual + código por e-mail — D-UC7).
- **Super**: senha perdida = script do operador `scripts/reset-super-password.ts` (D-PV46, executado na branch `recuperacao-senha`).
- **Ambiente**: `CORS_ORIGIN=*` no dev; HTTPS só pelo deploy (Onda 4/F3); `NODE_ENV` ausente no dev (produção = `production` exato — D-RS5).

### 1.3 Pré-requisitos já executados (branch `recuperacao-senha`, 2026-10-18/21 — publicar ANTES desta frente)

Recuperação endurecida (Q-PV38/D-PV13), aviso ao dono (D-RS4, `tb_user_password_reset_notice`), SMTP obrigatório em produção
(D-RS5 — `assertMailerReady` no boot, `.env.example`, pré-voo), script do Super (D-PV46). Esta frente REUSA três moldes de lá:
(1) teto DURÁVEL por conta em tabela filha de `tb_user`, lido e gravado sob a trava da linha do usuário (PADROES §9 regras 12–13);
(2) resposta NEUTRA em corpo/status/tempo (piso de resposta); (3) e-mail ao dono pela peça `@shared/mailer`, 1/h, texto neutro.

## 2. Riscos (o que o inventário permite hoje)

| # | Risco | Cenário concreto | Severidade |
|---|---|---|---|
| R1 | **Força bruta / credential stuffing no login** | 300 req/min por IP = 18 000 palpites/h contra UMA conta; distribuído em 100 IPs, sem teto; a vítima nem sabe | ALTA |
| R2 | **Senhas fracas em MD5 sem sal** | mínimo 5 → "12345", "setes" passam; vazamento do dump = 100 % das senhas curtas quebradas; a MESMA senha reutilizada em outros serviços cai junto | ALTA |
| R3 | **Sessão sem revogação** | token roubado (ou de usuário INATIVADO/demitido) vale até 24 h depois; trocar a senha não expulsa o invasor | MÉDIA-ALTA |
| R4 | **Sem alarme de onda** | ataque espalhado por muitas contas (R1 distribuído) passa em silêncio; ninguém da Setes é avisado | MÉDIA |
| R5 | **Oráculo "Usuário inativo"** | confirma que o e-mail existe (base para R1/R2 e para phishing) | BAIXA |
| R6 | **Limite por IP sem `trust proxy` na Onda 4** | atrás do proxy TODO cliente vira UM IP → o limite de 300/min derruba o uso legítimo, ou (se ligado como `true`) o atacante forja o IP | MÉDIA (D-RS2 já decide: Onda 4, número exato de saltos) |

## 3. Objetivos (numerados)

1. Limite POR CONTA no `/auth/login`, durável e neutro (molde da recuperação) — fecha R1 por conta.
2. Teto GLOBAL de erradas + alarme (sem bloqueio global) — fecha R4; dá visibilidade ao R1 distribuído.
3. Política de senha (mínimo e composição) nas três portas de escrita (criação, troca por código, "minha senha") — fecha metade do R2.
4. Hash de senha com sal e custo (migração transparente a partir do MD5) — fecha a outra metade do R2 (decisão reservada: revê a decisão 2).
5. Revogação de sessão: troca de senha e inativação derrubam o JWT aberto — fecha R3 (compõe com a D-UC9).
6. Mensagens neutras no login (R5) e a ordem de deploy com a Onda 4 (R6 — só reafirma D-RS2).
7. SMTP obrigatório em produção — **já coberto** pela D-RS5 (nada a fazer aqui além de conferir no pré-voo).

## 4. Proposta em ondas (cada onda = branch própria, gates socrático ≥ 0,70 + adversarial sem HIGH, publicação com "vai")

### Onda 1 — limite por conta no login (R1) + mensagem neutra (R5)
- **Peça**: `setes_central.tb_user_login_failure` (nome a fechar com o guardião — Q-EA2), filha de `tb_user`, PK `(tb_user_id, seq)`,
  `seq` MAX+1 sob a trava da linha do usuário, `created_at` UTC, `deleted` (nada se apaga — §3.1). **Só falhas** são gravadas (o sucesso
  não precisa de linha: o bloqueio expira pelo TEMPO — Q-EA2). Estado DERIVADO: `COUNT(created_at > NOW() - janela) ≥ N` = conta
  bloqueada até a falha mais velha da janela envelhecer.
- **Fluxo do login**: achar a conta (como hoje) → transação: trava da linha do usuário → contar falhas na janela → se bloqueada:
  NÃO confere a senha, responde a MESMA 401 "Email ou senha inválidos" (sem 423/429: um status próprio diria "a conta existe e está
  sob ataque") → senão confere; errada = INSERT da falha e 401; certa = emite o token (sem gravar nada). **Piso de resposta** como na
  recuperação (o caminho bloqueado é mais curto — o piso esconde). Conta inexistente: mesma 401 depois do mesmo piso.
- **Aviso ao dono** (molde D-RS4): ao BLOQUEAR, e-mail neutro 1/h — "registramos tentativas de acesso que não foram concluídas; se não
  foi você, troque a senha" — fato próprio ou `kind` novo na `_notice`? (Q-EA3 — guardião).
- **Super e admin**: o mesmo limite (o super é a conta mais valiosa); a saída do super bloqueado é esperar a janela ou o script D-PV46.
- **Memória por e-mail** (2ª camada, como na recuperação): 20/15 min por e-mail canônico, 429 igual para quem existe e quem não.
- "Usuário inativo"/"sem institution ativa" → a MESMA 401 "Email ou senha inválidos" (Q-EA6); o app já trata 401 genericamente.
- Entregáveis: migration/script sql numerado (próximo livre após 69), `auth.service.ts`/`auth.repository.ts`, testes com dublê +
  prova em schema descartável (molde `prove-password-reset-lock.ts`), Swagger do `/auth/login`.

### Onda 2 — teto global + alarme (R4)
- Contador em MEMÓRIA de falhas por minuto (processo único — D-F9) + contas distintas com falha em 5 min; acima do limiar → **alarme**
  (log `[ALARME LOGIN]` + `recordCrash` com ref + e-mail à operação da Setes pela peça `@shared/mailer`, 1 por 15 min). **Sem bloqueio
  global** (bloqueio global = DoS feito por nós mesmos). Limiares: Q-EA4.
- Falha de login passa a deixar rastro no log (sem senha, sem e-mail inteiro — mascarado como no script do Super).

### Onda 3 — política de senha (R2, metade) — toca o setes-app
- Regra ÚNICA em peça compartilhada (`@shared/auth/password-policy` + espelho Dart em `setes_validators`, como a validação shared da
  Fase 2): mínimo **8** (Q-EA5), sem exigir classes (NIST SP 800-63B: tamanho vale mais que composição), recusar as senhas da lista de
  comuns (top 10 k, PT-BR incluído — arquivo no repo), recusar senha que contenha a parte local do e-mail de login, recusar igual à
  atual (quando houver atual). Aplicada nas três portas de escrita: `POST/PUT /api/users` (inicial), `/auth/change-password` (código) e o
  futuro "minha senha" (D-UC7). Senhas existentes mais curtas SEGUEM válidas até a próxima troca (Q-EA5). O app mostra a regra no campo.

### Onda 4 — hash com sal e custo (R2, outra metade) — DECISÃO RESERVADA (revê a decisão 2 da Fase 2)
- `scrypt` do próprio `crypto` do Node (sem dependência nova; N=2^15, r=8, p=1, sal de 16 bytes) gravado como
  `scrypt$<params>$<salt>$<hash>` na MESMA coluna `tb_user.password` (varchar(100) cabe). O login reconhece o prefixo: hash legado (32
  hex) compara em MD5 e, se bater, **REGRAVA no formato novo na mesma transação** (migração transparente, sem janela e sem pedir troca);
  sem prefixo e sem 32 hex = recusa. O HMAC do código de recuperação carrega o hash da senha — regravar o hash INVALIDA o código aberto
  (comportamento já desejado: a senha "mudou de forma"). Impacto no sync: nenhum (`/user/sincronize` cria usuário com `password NULL`).
  Impacto no app: nenhum (manda texto puro por HTTPS, como hoje). Impacto no script D-PV46: usa a mesma peça de hash.
- Comparação em tempo constante (`timingSafeEqual`) nos dois formatos.

### Onda 5 — revogação de sessão (R3) — compõe com a D-UC9 do convidado

> ⚠️ *REVISTA 2026-10-31 (D-EA7/D-EA10): não é mais onda — entra na COSTURA A1 (passo 4 do plano), sem cache (D-AU8), com fato próprio
> "senha definida em T" ao lado do hash (não o `tb_user.updated_at`); a inativação já é coberta pela view viva. O texto abaixo é a
> proposta da Rodada 0.*
- **Fato "credencial/estado mudou em T"**: hoje `tb_user.updated_at` só muda com senha (`updatePassword`, `updateUserCascade`) ou
  `active` — já é esse fato (conferido no código; o sync não toca `tb_user` depois de criar). A guarda compara `iat` do token com
  `updated_at` (cache 60 s por usuário, como as flags): token mais velho que a última mudança = 401 `SESSION_REVOKED` → o app refaz o
  login. A D-UC9 (vínculo vivo) entra na mesma leitura. Q-EA7 decide entre isso e uma tabela de sessões.
- TTL do token: manter 24 h (decisão 19) — com revogação, encurtar perde o sentido (Q-EA8).

### Onda 4 do deploy (SaveInCloud) — fora desta frente, só reafirmado
`trust proxy` com o número exato de saltos (D-RS2), HTTPS, `CORS_ORIGIN` pelo domínio, SMTP real no `.env` vivo (D-RS4/D-RS5), medir o
tempo real da transação do consume (D-RS6). Nenhuma onda daqui deve ligar `trust proxy`.

## 5. Scripts / entregáveis previstos

| Onda | Entregável | Quando |
|---|---|---|
| 1 | `sql/7N_user_login_failure_ddl.sql` (+ espelho sql/01) · `auth.*` · `prove-login-lock.ts` · testes | após o merge da `recuperacao-senha` |
| 2 | peça `@shared/auth/login-watch` (memória) + alarme · testes | junto ou logo após a 1 |
| 3 | `@shared/auth/password-policy` + `setes_validators` (Dart) + lista de senhas comuns · telas (campo com a regra) | API e app JUNTOS |
| 4 | `@shared/auth/password` (scrypt + MD5 legado) · regravação no login · testes · prova de migração em descartável | depois da 3 |
| 5 | ~~guarda `authMiddleware` (iat × updated_at, cache)~~ → D-EA7: fato próprio da senha na leitura viva · `ErrorCodes.SESSION_REVOKED` · app refaz login | ~~com a onda 0 do convidado~~ → COSTURA A1, passo 4 do plano (D-EA10) |

## Decisões arquiteturais registradas

**Rodada 1 — 2026-10-31 ("uma pergunta por vez"; lida à luz da frente auth-api — `prompt_frente_auth_api.md` §5, D-AU1…D-AU12)**:

- **D-EA1** (Valdo, 2026-10-31 — fecha a **Q-EA1** = (a), literal: *"segue a recomendacao"*) — limite POR CONTA no `/auth/login`: **10
  erradas em 15 min, janela DESLIZANTE**; ao atingir, a conta fica bloqueada até a falha mais velha da janela envelhecer (sem botão de
  desbloquear, sem chamado); resposta SEMPRE a mesma 401 "Email ou senha inválidos" no mesmo tempo (piso), inclusive para a senha CERTA
  durante o bloqueio. Vale para todos os perfis, admin e Super. **Correção da proposta (§4, Onda 1)**: o script do Super (D-PV46) troca a
  senha mas NÃO apaga as falhas — não desbloqueia; a saída do Super bloqueado é ESPERAR a janela. **Efeito da auth-api**: o número não
  muda; o bloqueio nasce no setes-api e vai para a auth-api na A2 junto da tabela de falhas (D-AU4/D-AU5). Recusados: (b) 5 em 15 min;
  (c) bloqueio progressivo.
- **D-EA2** (Valdo, 2026-10-31 — fecha a **Q-EA2** = (a), literal: *"siga a recomendacao"*) — o fato da falha de login mora em tabela
  FILHA `tb_user_login_failure` (nome final conferido pelo guardião ANTES do DDL): só FALHAS (sucesso não grava), append-only (nada se
  apaga — PADROES §3.1), PK `(tb_user_id, seq)` com `seq` MAX+1 sob a trava da linha do usuário (regras 12/13), `created_at` UTC; o
  "bloqueado" é DERIVADO (contagem na janela da D-EA1), nunca coluna de estado. **Efeito da auth-api (caminho)**: AGORA nasce em
  `setes_central` chaveada por `tb_user_id` (D-AU6), sob a trava de `tb_user`, no MESMO molde das filhas do sql/67; na A2 muda para o
  `auth_api` com elas, sem reforma — a trava passa a ser a linha de `tb_user_credential` e a FK para `tb_user` cai (sem FK entre bancos —
  PADROES §11.1; D-AU5 já nomeia esta tabela). Recusados: (b) colunas `failed_logins`/`locked_until` em `tb_user` (estado em vez de fato,
  na tabela que perde a credencial); (c) tabela de todas as tentativas (volume sem retenção possível).
- **D-EA3** (Valdo, 2026-10-31 — fecha a **Q-EA3** = (b), literal: *"segue recomendacao"*) — ao BLOQUEAR a conta (D-EA1) o dono recebe
  e-mail NEUTRO, no máximo 1/h, texto único sem link de ação (molde D-RS4/D-RS12): "registramos tentativas de acesso que não foram
  concluídas; se não foi você, troque a senha" (pela D-PV48 = o titular pede código pela recuperação). O fato da vaga mora em tabela IRMÃ
  PRÓPRIA `tb_user_login_notice` (mesmo molde da `tb_user_password_reset_notice`: PK `(tb_user_id, seq)`, `created_at` = instante em que
  o sistema tomou a vaga, sem `sent_at`; vaga sob SAVEPOINT na transação do gatilho — D-RS10; falha do SMTP = log — D-RS9). Consequência
  aceita: conta atacada no login E na recuperação recebe até 2 avisos/h (um de cada processo — princípio da D-RS8). **Efeito da
  auth-api**: nenhum na recomendação — nasce em `setes_central` e muda para o `auth_api` na A2 com as outras filhas (D-AU4, D-EA2); ter um
  dono só NÃO justifica tabela genérica de avisos (recusada pelo guardião na D-RS4). Recusados: (a) `kind` 'L' na tabela "reset" (o nome
  mentiria); (c) sem aviso.
- **D-EA4** (Valdo, 2026-10-31 — fecha a **Q-EA4** = (a), literal: *"segue recomendacao"*) — teto GLOBAL do login = ALARME, nunca bloqueio:
  contador em MEMÓRIA do processo (pega também e-mail inexistente, que a `tb_user_login_failure` da D-EA2 não grava) dispara acima de
  **100 falhas/min OU 30 contas distintas com falha em 5 min** → linha `[ALARME LOGIN]` no log + `recordCrash` (tb_crashlytics, com ref) +
  e-mail à OPERAÇÃO no máximo 1 a cada 15 min. Nova chave `.env` **`OPS_ALERT_EMAIL`**, OBRIGATÓRIA em produção junto do SMTP (o boot
  recusa subir sem ela, molde D-RS5/`assertMailerReady`; fora de produção vazia = só log). Hoje não existe e-mail de operação (conferido
  2026-10-31: alarmes só vão a log + `tb_crashlytics`). **Efeito da auth-api / precisão da D-RS9**: o alarme do login NASCE no setes-api
  (o endurecer roda antes da A2 — D-AU6/D-AU11) e MUDA com o login para a auth-api na A2; o CANAL (`OPS_ALERT_EMAIL` + `@shared/mailer`) é
  da OPERAÇÃO, não da auth-api — qualquer processo o usa (setes-api agora, auth-api depois, nfse-api para os alarmes fiscais no futuro).
  A frase da D-RS9 "nasce na auth-api depois da extração" fica lida assim. **Limite conhecido**: contador por processo — vale enquanto o
  login roda numa instância só (setes-api hoje; auth-api com instância própria — D-AU7); com N instâncias cada uma conta a sua parte.
  Recusados: (b) bloqueio global de 1 min (auto-DoS); (c) só log.
- **D-EA5** (Valdo, 2026-10-31 — fecha a **Q-EA5** = (a), literal: *"segue a recomendacao"*) — política de senha ÚNICA (peça
  `@shared/auth/password-policy` + espelho Dart em `setes_validators`, molde da validação shared da Fase 2): **mínimo 8**, máximo 100,
  SEM classes obrigatórias (NIST SP 800-63B); recusa senha da LISTA de comuns (top 10 k, PT-BR incluído — arquivo no repositório), senha
  que contenha a parte local do e-mail de login e senha igual à atual (quando houver atual). Vale nas TRÊS portas de escrita: senha
  inicial (`POST /api/users`), troca pelo código (`/auth/change-password`) e o futuro "minha senha" (D-UC7) — o MESMO `fields[]` na API e
  a MESMA mensagem no app, que mostra a regra no campo. Senhas existentes mais curtas SEGUEM válidas até a próxima troca (nada força troca
  no deploy). Hoje: mínimo 5 (`users.dto.ts` POST/PUT e `changePassword` — conferido 2026-10-31). **Efeito da auth-api**: nenhum na
  recomendação — a regra é parte da credencial (D-AU1): nasce no setes-api e muda para a auth-api na A2 com os escritores da senha; o
  espelho segue no app. A senha inicial do script do Super (16 caracteres aleatórios) já cumpre. Recusados: (b) 12 + classes; (c) manter 5.
- **D-EA6** (Valdo, 2026-10-31 — fecha a **Q-EA6** = (a), literal: *"siga recomedacao"*) — o login responde a MESMA 401 "Email ou senha
  inválidos", no MESMO tempo (piso), para senha errada, e-mail inexistente, usuário INATIVO e usuário SEM estabelecimento ativo; o motivo
  real vai só ao log interno (forense — molde da D-EA11 a decidir). **Correção do inventário (§1.2/R5)**: conferido no código em
  2026-10-31 (`auth.service.ts` `login`): "Usuário inativo" (401) e "sem institution ativa" (403) só saem DEPOIS da senha conferida — não
  são só oráculo de existência, CONFIRMAM SENHA CERTA (útil para reúso em outros serviços, ex.: conta de ex-funcionário). A senha CERTA
  em conta inativa/sem vínculo NÃO conta como falha para o bloqueio da D-EA1 (a senha estava certa; a resposta é a mesma). Efeito aceito:
  o inativado legítimo pode pedir recuperação, trocar a senha e continuar recusado — descobre com o admin (é o que a inativação impõe).
  **Efeito da auth-api**: nenhum na recomendação — o login vai para a auth-api na A2 com a mesma regra; "credencial viva + vínculo vivo"
  já compõe a leitura única (D-AU3) e a inativação vale na hora (D-AU8): a sessão aberta cai, o login devolve a mesma resposta neutra. A
  regra do convidado (D-UC12: o login é o aceite) roda ANTES da contagem de vínculos ativos. Recusado: (b) manter as mensagens.
- **D-EA7** (Valdo, 2026-10-31 — fecha a **Q-EA7** = (a) REVISTA pela auth-api, literal: *"siga recomendacao"*) — revogação de sessão em
  DOIS caminhos: (1) **inativação** (usuário OU vínculo) = pela leitura de acesso VIVA (`vw_user_access` só devolve acesso com credencial
  e vínculo vivos — D-AU3 (2), sem cache — D-AU8): cai NA HORA, sem comparar instante; (2) **troca de senha** = `iat` do token × FATO
  PRÓPRIO "senha definida em T" (ex.: `password_changed_at`, forma final pelo guardião antes do DDL) gravado AO LADO do hash e SÓ pelos
  escritores da senha — criação do usuário, troca pelo código (`/auth/change-password`), "minha senha" (D-UC7), script do Super (D-PV46);
  token com `iat` anterior = 401 `SESSION_REVOKED` → o app refaz o login. A migração transparente do hash no login (Q-EA9) NÃO mexe no fato
  (mesma senha, outro formato). O fato vai COM o hash para `tb_user_credential` na A2 (D-AU5/D-AU11). A comparação entra na MESMA leitura
  (D-AU3 (4)). **Mudança de recomendação pela auth-api (dita ao Valdo)**: a Rodada 0 recomendava `iat × tb_user.updated_at` com cache de
  60 s — (i) o cache morreu (D-AU8); (ii) a inativação já é coberta pela view viva; (iii) `tb_user.updated_at` é o fato ERRADO: conferido em
  2026-10-31, TODO salvar do cadastro do usuário o toca (`main` `users.repository.ts` `updateUserCascade`; `privilegios-crud` idem,
  inclusive só o nome) — editar o nome derrubaria as sessões; e na A2 a senha sai da `tb_user`. **Momento**: NÃO espera a onda 5 — entra na
  COSTURA A1 (bloco de privilégios, passo 4 do plano — D-AU6), junto da D-UC9. Recusados: (b) `iat × updated_at` sem cache (revoga em
  qualquer edição); (c) tabela de sessões (fica para quando houver pedido de "sair de todos os aparelhos"); (d) nada.
- **D-EA8** (Valdo, 2026-10-31 — fecha a **Q-EA8** = (a), literal: *"segue rec."*) — o token final segue com **TTL de 24 h, sem refresh**
  (decisão 19 da Fase 1 / PADROES §7 mantidos). Motivo: com a D-EA7 (inativação na hora pela view; troca de senha pelo `iat`) a defesa
  que importa já existe; encurtar só incomoda e não fecha o token roubado de quem não trocou a senha. Gatilho para rever: exigência
  EXTERNA (cliente/auditoria) → (c) 1 h + refresh. **Efeito da auth-api**: nenhum na recomendação — na A2 a auth-api emite com o mesmo
  TTL; pela D-AU3 o token leva só a IDENTIDADE (sem `role`) e pela D-AU8 o acesso é relido vivo a cada requisição — token longo não
  carrega permissão velha. Recusados: (b) 8 h; (c) 1 h + refresh (agora).
- **D-EA9** (Valdo, 2026-10-31 — fecha a **Q-EA9** = (a), literal: *"segue rec..."*; REVÊ a decisão 2 da Fase 2 — MD5 aposentado) — hash
  de senha = **`scrypt` do `crypto` do Node** (sem dependência nova), parâmetros **`N=2^15, r=8, p=3`** (≈ 32 MiB por verificação —
  equivalente ao MÍNIMO da tabela da OWASP; a proposta da Rodada 0 trazia `p=1`, abaixo dele — CORRIGIDO), valor final confirmado por
  MEDIÇÃO no gate (tempo e memória por login; `maxmem` explícito), sal de 16 bytes, gravado na MESMA coluna como
  `scrypt$<params>$<sal>$<hash>` em base64 (cabe no varchar(100); hex não cabe). **Migração TRANSPARENTE no login**: hash legado (32 hex)
  confere em MD5 e, se bater, REGRAVA no formato novo na mesma transação; sem prefixo e sem 32 hex = recusa; comparação em tempo
  constante (`timingSafeEqual`) nos dois formatos. Conferido em 2026-10-31: TODOS os escritores passam por `md5Password`
  (`@shared/auth/password`) — cadastro de usuário (`users.service`), 1º admin do onboarding (`institutions.service`), troca pelo código
  (`auth.service`) e script do Super (`super-password-reset.ts`, que também valida a forma "32 hex" — muda junto) — trocar a peça cobre
  todos. Efeitos: (1) o HMAC do código de recuperação inclui o hash (`passwordResetHmac`) → a regravação no login MATA o código aberto
  daquela conta (≤ 15 min após o deploy; aviso no roteiro); (2) a regravação NÃO é "senha nova" para a D-EA7 (não toca o fato
  "senha definida em T", não derruba sessão). Node instalado = v21.7.3, SEM `crypto.argon2` (conferido). **Efeito da auth-api**: só a
  ORDEM, já fixada pela D-AU11 — executa no setes-api ANTES da A2; na A2 a coluna muda de banco já no formato novo e as MD5 restantes
  seguem migrando no login pelo MESMO código levado para a auth-api. Recusados: (b) bcrypt/argon2 por dependência nativa (compila no
  deploy); (c) manter MD5.
- **D-EA10** (Valdo, 2026-10-31 — fecha a **Q-EA10** = (a) REVISTA pela auth-api, literal: *"siga rec.."*) — ORDEM: (1) passo 4 do plano de
  retomada (bloco de privilégios + COSTURA A1, já com a revogação da D-EA7 — a "Onda 5" deixa de ser onda); (2) a partir do `main` depois
  dele: **Ondas 1+2 → 3 → 4**, cada uma em branch própria com gates (socrático ≥ 0,70, adversarial sem HIGH) e "vai"; (3) **A2** (extração
  da auth-api — já depois das ondas 0 do grupo e do convidado); (4) **A3**; (5) Onda 4 do deploy — o servidor público nasce endurecido.
  TODAS as ondas antes da A2 (a D-AU11 exige só a 4; as outras também, para a A2 só MUDAR DE LUGAR — "uma mudança de risco por vez").
  Podem intercalar com os passos 5–8 do plano, MENOS a Onda 1 com a onda 0 do convidado (as duas mexem no `login` — D-UC12): nunca em
  paralelo. **Mudança de recomendação pela auth-api (dita ao Valdo)**: a Rodada 0 punha a revogação como Onda 5 "com a onda 0 do
  convidado" e não amarrava as ondas à extração. Recusados: (b) ondas 1–4 depois da A2, direto na auth-api (a A2 levaria o MD5 — contraria
  a D-AU11); (c) tudo numa janela. Passo 10 do §2 do `plano_retomada_2026-10-21.md` ajustado.
- **D-EA11** (Valdo, 2026-10-31 — fecha a **Q-EA11** = (a), literal: *"segue rec,"*) — rastro forense da falha de login = UMA linha de LOG
  por falha (inclusive e-mail inexistente, que a `tb_user_login_failure` não grava): e-mail MASCARADO (molde do script do Super), IP,
  motivo INTERNO (senha errada / inexistente / inativo / sem vínculo / bloqueado — o que a D-EA6 tirou da resposta), instante; NUNCA a
  senha nem o e-mail inteiro; nada a mais no banco (o fato durável segue só a filha da D-EA2). Limite conhecido: até o `trust proxy` da
  Onda 4 do deploy (D-RS2), atrás de proxy o IP é o do PROXY. **Efeito da auth-api**: nenhum na recomendação — nasce no setes-api com as
  Ondas 1+2 e muda com o login na A2. Recusado: (b) tabela de auditoria (cresce sem retenção possível — §3.1 — e duplica a D-EA2).
- **D-EA12** (Valdo, 2026-10-31 — fecha a **Q-EA12** = (a), literal: *"segue rec."*) — a linha `logger.info('Auth OK', …)` do
  `authMiddleware` do setes-api (`src/gateway/auth.middleware.ts`, só lá — conferido 2026-10-31 que nfse-api/núcleo não têm) é REMOVIDA;
  o `runAsActor` (autor para quem registra erro — D-F151) fica. Sem nível "debug" novo no logger (hoje só `info`/`warn`/`error`). Momento:
  na COSTURA A1 (passo 4 do plano), onde o middleware já é reescrito para ler a `vw_user_access` (D-AU3/D-AU8); se a costura não tocar
  nele, vai na Onda 1. **Efeito da auth-api**: só o momento. Recusados: (b) nível debug por variável de ambiente; (c) manter.
  **Rodada 1 FECHADA (D-EA1…D-EA12) — nenhuma questão aberta nesta frente.** Execução pela D-EA10.

## ⚠️ Questões pendentes (Rodada 0) — uma por vez, com recomendação

- ✅ **Q-EA1 → D-EA1 (2026-10-31, (a)).** Texto original: **Q-EA1 — limite por conta no login: valores.** Problema: sem teto por conta, 18 000 palpites/h por IP. Opções: (a) **10 erradas em 15
  min → bloqueio até a mais velha envelhecer (janela deslizante de 15 min)**; (b) 5 em 15 min (mais rígido; mais chamados de suporte);
  (c) bloqueio progressivo (15 min, 1 h, 24 h). **Rec.: (a)** — dez erradas não acontecem por engano de digitação, e a janela deslizante
  dispensa "desbloquear" (o admin não precisa de botão; o super bloqueado espera 15 min ou usa o D-PV46). Resposta SEMPRE a mesma 401.
- ✅ **Q-EA2 → D-EA2 (2026-10-31, (a)).** Texto original: **Q-EA2 — onde mora o fato da falha.** Opções: (a) **tabela filha `tb_user_login_failure` (só falhas, append-only, PK por usuário +
  seq, sob a trava da linha de `tb_user` — regras 12/13)**; (b) colunas `failed_logins`/`locked_until` em `tb_user` (ALTER na tabela do
  login + estado em vez de fato — o gate da Q-PV38 reprovou o molde); (c) tabela de TODAS as tentativas (sucesso incluído — 1 linha por
  login, milhões/ano, sem política de retenção possível com o §3.1). **Rec.: (a)**, nome final pelo guardião ANTES do DDL.
- ✅ **Q-EA3 → D-EA3 (2026-10-31, (b)).** Texto original: **Q-EA3 — aviso ao dono ao bloquear.** Opções: (a) **`kind` novo 'L' (login bloqueado) na `tb_user_password_reset_notice`**, com a
  coalescência 1/h já existente — mas a tabela se chama "reset": o nome passaria a mentir; (b) tabela irmã própria `tb_user_login_notice`
  (mesmo molde); (c) sem aviso. **Rec.: (b)** — o guardião da D-RS4 nomeou pela consequência (o PROCESSO de recuperação); bloqueio de
  login é outro processo; o custo é uma tabela igual à irmã. Texto neutro: "tentativas de acesso não concluídas; se não foi você,
  troque a senha" (a troca pela recuperação é a saída certa — o atacante não conhece a senha).
- ✅ **Q-EA4 → D-EA4 (2026-10-31, (a) com `OPS_ALERT_EMAIL` obrigatório em produção).** Texto original: **Q-EA4 — teto global e alarme.** Opções: (a) **alarme quando > 100 falhas/min no processo OU > 30 contas distintas com falha em 5
  min; e-mail à operação 1 por 15 min; nunca bloqueia**; (b) alarme + bloqueio global do `/auth/login` por 1 min (auto-DoS); (c) só log.
  **Rec.: (a)**. Destinatário do e-mail: nova chave `.env` `OPS_ALERT_EMAIL` (vazia = só log; em produção obrigatória? — (a2) sim,
  junto do SMTP; Rec.: sim).
- ✅ **Q-EA5 → D-EA5 (2026-10-31, (a)).** Texto original: **Q-EA5 — política de senha.** Opções: (a) **mínimo 8, sem classes obrigatórias, lista de senhas comuns, não conter o e-mail, não
  igual à atual; existentes valem até a próxima troca**; (b) mínimo 12 + classes (mais segura; usuários de PDV/balcão sofrem); (c) manter 5.
  **Rec.: (a)** — alinhada ao NIST e à realidade do balcão; a lista de comuns pega o que a composição não pega ("Senha@123").
- ✅ **Q-EA6 → D-EA6 (2026-10-31, (a)).** Texto original: **Q-EA6 — oráculo "Usuário inativo" / "sem institution ativa".** Opções: (a) **a MESMA 401 "Email ou senha inválidos" para os dois** (o
  usuário inativo descobre com o admin — é a condição que a inativação quer impor); (b) manter as mensagens (UX) e aceitar a enumeração.
  **Rec.: (a)**; o log interno guarda o motivo real (forense).
- ✅ **Q-EA7 → D-EA7 (2026-10-31, (a) REVISTA — fato próprio da senha, sem cache, na costura A1).** Texto original: **Q-EA7 — revogação de sessão.** Opções: (a) **`iat` do token × `tb_user.updated_at` (fato que já muda só com senha/active), lido com
  cache de 60 s na guarda, junto da conferência do vínculo da D-UC9**; (b) tabela `tb_user_session` (1 linha por login, revogação
  explícita, "sair de todos os aparelhos") — mais poder, mais linhas, mais DDL; (c) nada (manter o limite). **Rec.: (a)** agora — zero
  DDL, zero mudança no app além de tratar `SESSION_REVOKED` como 401; (b) fica para quando houver pedido de "sair de todos os aparelhos".
  ⚠️ Confirmar que NENHUM escritor toca `tb_user.updated_at` por outro motivo (hoje: `updatePassword`, `updateUserCascade`, D-PV46,
  sql/67 não — conferir o setes-sync na onda, por leitura: `/user/sincronize` cria, não atualiza).
- ✅ **Q-EA8 → D-EA8 (2026-10-31, (a)).** Texto original: **Q-EA8 — TTL do JWT.** Opções: (a) **manter 24 h (decisão 19) — com a revogação da Q-EA7 o risco do token longo cai**; (b) 8 h sem
  refresh (relogin no meio do expediente); (c) 1 h + refresh token (mexe no app e cria outro segredo). **Rec.: (a)**.
- ✅ **Q-EA9 → D-EA9 (2026-10-31, (a) com `p=3`).** Texto original: **Q-EA9 — hash da senha (revê a decisão 2 da Fase 2 — reservada ao Valdo).** ⚠️ *(2026-10-31 — D-AU11 da `prompt_frente_auth_api.md`: esta troca é EXECUTADA no setes-api ANTES da A2 (extração da auth-api); na A2 a credencial só muda de banco, já no hash novo. A frente auth-api também decide, na D-AU5, que a credencial vai para `tb_user_credential` no banco `auth_api` — as tabelas novas desta frente (Q-EA2) nascem chaveadas por `tb_user_id`, D-AU6.)* Opções: (a) **scrypt do Node com migração TRANSPARENTE
  no login (MD5 legado aceito e regravado)**; (b) bcrypt/argon2 (dependência nativa nova — pesa no deploy); (c) manter MD5 (risco
  aceito em 2026-07, quando a Setes era o único cliente). **Rec.: (a)** — sem dependência, sem janela, sem pedir troca a ninguém; o
  único efeito visível é o código de recuperação aberto morrer no 1º login depois do deploy (≤ 15 min, avisar no roteiro).
- ✅ **Q-EA10 → D-EA10 (2026-10-31, (a) REVISTA — revogação na costura A1; ondas 1–4 antes da A2).** Texto original: **Q-EA10 — ordem e corte.** Opções: (a) **Ondas 1+2 primeiro (porta pública), depois 3, 4 e 5; cada uma com gates e "vai"; todas
  depois do merge da `recuperacao-senha` e ANTES da Onda 4 do deploy (o servidor público nasce endurecido)**; (b) tudo numa janela só
  (mais risco, menos merges). **Rec.: (a)**.
- ✅ **Q-EA11 → D-EA11 (2026-10-31, (a)).** Texto original: **Q-EA11 — log de falhas de login (forense).** Opções: (a) **linha de log por falha com e-mail MASCARADO + IP + motivo interno, sem
  senha** e sem gravar no banco (o fato durável é a `_failure` da Q-EA2); (b) também em tabela de auditoria central. **Rec.: (a)**.
- ✅ **Q-EA12 → D-EA12 (2026-10-31, (a) — na costura A1).** Texto original: **Q-EA12 — `Auth OK` em toda requisição.** O `authMiddleware` loga institution + path a cada chamada autenticada (volume no log de
  produção; nenhum dado sensível). Opções: (a) **rebaixar para debug/remover (fica só o log de falhas)**; (b) manter. **Rec.: (a)** —
  item pequeno, pode entrar na Onda 1 ou na Onda 4 do deploy; não é segurança.

## Fora de escopo desta frente

- `X-Api-Key` do setes-sync / sincronizador (outro grupo — regra dos dois grupos); 2FA/TOTP (nenhum pedido; fica como ideia na Onda 5 se o
  Valdo quiser); SSO/OAuth; CAPTCHA (a resposta neutra + limite por conta cobrem o caso); "minha senha" e convite (onda 0 do convidado —
  D-UC6…D-UC12); `trust proxy`/HTTPS/CORS (Onda 4 do deploy — D-RS2); auditoria de LOGINS bem-sucedidos (ver Q-EA7 (b)).

## Critérios de sucesso (testáveis)

1. 11ª tentativa errada numa conta em 15 min recebe a MESMA 401 que a 1ª, em tempo igual ao de uma conta inexistente (piso), e a senha
   certa também é recusada enquanto a janela não envelhece; rajada paralela de 50 erradas = exatamente N linhas de falha (prova em
   descartável, zero deadlock).
2. E-mail de aviso ao dono sai 1 vez por hora por conta bloqueada; e-mail inexistente nunca gera aviso.
3. Alarme da Onda 2 dispara no limiar (teste com relógio controlado) e NUNCA bloqueia o `/auth/login`.
4. `POST /api/users`, `/auth/change-password` e "minha senha" recusam senha fora da política com o MESMO `fields[]` (API) e a MESMA
   mensagem (app, `setes_validators`); senha existente de 5 caracteres ainda loga até a próxima troca.
5. Login com hash MD5 legado passa e regrava em scrypt na mesma transação; o 2º login compara scrypt; prova em descartável com os dois
   formatos; `tsc` e suíte verdes.
6. Trocar a senha (código, admin, script D-PV46) ou inativar o usuário faz o token anterior receber 401 `SESSION_REVOKED` em ≤ 60 s;
   o token novo passa.
7. Gates socrático ≥ 0,70 e adversarial sem HIGH/CRITICAL em cada onda; nenhuma senha, código ou e-mail inteiro em log.
