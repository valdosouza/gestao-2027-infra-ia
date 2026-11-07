# Prompt — Endurecer a autenticação do setes-api (login, senha, sessão)

**Status**: Rodada 1 FECHADA (2026-10-31 — D-EA1…D-EA12, "uma pergunta por vez", à luz da frente auth-api). Rodada 2 ABERTA
(2026-11-01 — Q-EA13 → D-EA13: senha só de espaços recusada já, na costura do passo 4) — NENHUMA questão aberta.
**Preparação da execução FEITA (2026-11-01, seção final "⏸ Preparação da execução")**: pré-condição NÃO cumprida (passo 4 fora do `main`)
— só documento: leitura do auth, parecer do guardião, DDL em rascunho pelo `revisar-ddl`, plano de testes, pré-medição do scrypt. A
preparação abriu a fila **Q-EA14…Q-EA17 + A-EA1…A-EA9** (§P.6), a perguntar UMA por vez antes da onda de cada uma. Rodada 3: **D-EA14**
(aviso = `tb_user_login_block_notice`), **D-EA15** (aviso na falha que leva a 10) e A-EA1…A-EA8 ratificadas — a Onda 1 não tem
questão aberta; **D-EA16** (parte local do e-mail só conta com 4+ caracteres) e A-EA9 ratificada — a Onda 3 sem questão aberta; **D-EA17** (o peso
final do scrypt sai da medição no servidor real) e **D-EA18** (a Onda 4 executa já, com o peso provisório; o ajuste vira recálculo no
login) — fila ZERADA. **EXECUÇÃO INICIADA (2026-11-01)**: o passo 4 entrou no `main` (42278bf); **item 0 (script do Super, D-RS7 +
D-RS13) EXECUTADO em worktree `super-reset` com gates 0,78/0,75 ✅, NADA commitado** (§P.8); o item 0 abriu Q-EA19…Q-EA22 (uma por vez) —
**D-EA19** (aviso ANTES da senha), **D-EA20** (Super sem e-mail de login recusado) e **D-EA21** (e-mail mascarado em todo log da
mailer) decididas e executadas; **D-EA22** (corrida rebaixar × redefinir = limite conhecido) — questões do item 0 FECHADAS; **gates do
DELTA 0,77/0,75 ✅** com correções (§P.8); o delta abriu Q-EA23…Q-EA26 — **D-EA23** (regra única do e-mail de login) e **D-EA24**
(teto total de 60 s no aviso) decididas e executadas; **D-EA25** (2026-11-04: dado pessoal no log fora de `/auth` = frente própria);
**D-EA26** (2026-11-04: a peça de e-mail recusa destinatário que não seja um endereço único válido) — **executada 2026-11-04 com o gate do
delta final 0,80/0,78 sem HIGH (§P.10)**; o gate abriu Q-EA27…Q-EA29 — **D-EA27** (aparado = só o espaço do fim) decidida e executada; **D-EA28** (troca do e-mail × script = limite conhecido, teste que fixa) e **D-EA29** (censo dos e-mails ruins no pré-voo, alarme)
decididas e executadas — fila do item 0 ZERADA; **item 0 PUBLICADO 2026-11-05** (`main` 1270ba0, GitHub; §P.10); depois o ensaio do Valdo, o "vai" do merge e as Ondas 1+2.
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
  PRÓPRIA `tb_user_login_notice` *(NOME revisto pela D-EA14, 2026-11-01: `tb_user_login_block_notice`)* (mesmo molde da `tb_user_password_reset_notice`: PK `(tb_user_id, seq)`, `created_at` = instante em que
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
- **D-EA7 — EXECUTADA na costura A1 (2026-10-31 → 11-01, worktrees `privilegios/*`; §14 do `prompt_privilegios_interfaces.md`)**: a forma
  final pelo guardião = `tb_user.password_set_at DATETIME NULL` (UTC, ao segundo) ao lado do hash, exposta crua na `vw_user_link`, comparada
  na MESMA leitura da sessão (`password_set_at IS NULL OR password_set_at <= iat`). Assunções do guardião **RATIFICADAS** (Valdo,
  2026-11-01, literal: *"Ratificar todas"*): **A-1** T pelo relógio de quem ASSINA o token (nunca `NOW()` do banco — exceção nomeada à letra
  da PADROES §10 regra 1); **A-2** `iat = T` vale; **A-3** NULL sem backfill; **A-4** `iat` obrigatório nos dois verificadores, com o token
  de SELEÇÃO conferido.
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

**Rodada 2 — 2026-11-01**:

- **D-EA13** (Valdo, 2026-11-01 — fecha a **Q-EA13** = (b), literal: *"(b) Recusar já"*) — senha SÓ DE ESPAÇOS (`trim()` vazio) é
  RECUSADA na validação, JÁ, na costura do passo 4 (regra no DTO de usuários do setes-api, POST e PUT — o `it.failing` de
  `src/__tests__/adversarial-a1-delta-gate.test.ts` vira `it`); a peça da política da D-EA5 (Onda 3, API + espelho Dart) ABSORVE a regra
  depois, junto do mínimo 8. Espaços DENTRO da senha seguem válidos (frase-senha). Origem: gate adversarial do delta da costura A1 — o DTO
  aceitava '     ' (`z.string().min(5)`), e numa conta SEM credencial (vinda do sync) isso vira a 1ª senha que, pela D-PV48, só o titular
  troca; o app já barrava pela tela. **Efeito da auth-api**: nenhum — a regra vai com a peça da senha para a auth-api na A2. Recusados: (a)
  esperar a Onda 3; (c) não recusar. Repassada à sessão do passo 4 com o texto literal.
  **EXECUTADA 2026-11-01** (sessão do passo 4, commit LOCAL **745d2af** do setes-api, branch `privilegios-crud`, sem push — conferido):
  peça `newPasswordSchema` em `src/shared/auth/password.ts` (5 a 100 caracteres, `trim()` vazio recusado, espaço dentro vale) usada no
  `users` POST e PUT **e também no admin do onboarding** (`institutions.dto.ts`) — toda porta do cadastro que cria credencial, além da letra
  "DTO de usuários" (mesma intenção; a D-EA5 já previa as três portas de escrita). O `it.failing` do `adversarial-a1-delta-gate.test.ts`
  virou `it`; teste novo em `users-d-pv48-d-pv58.test.ts`. A peça da D-EA5 (Onda 3) absorve `newPasswordSchema` junto do mínimo 8.
  Registro da execução também no §14 do `prompt_privilegios_interfaces.md`.

**Rodada 3 — 2026-11-01 (a fila aberta pela preparação da execução — §P.6; uma por vez)**:

- **D-EA14** (Valdo, 2026-11-01 — fecha a **Q-EA14** = (a), literal: *"(a) login_block_notice"*) — a tabela do aviso ao dono da D-EA3 se
  chama **`tb_user_login_block_notice`** (revê só o NOME da letra da D-EA3, que trazia `tb_user_login_notice`; o resto da D-EA3 fica). Motivo
  (parecer do guardião, §P.3): a própria D-EA3 justificou a tabela própria por "bloqueio de login é outro processo" — o nome diz o processo;
  "login notice" costuma ser o aviso de acesso BEM-SUCEDIDO (aparelho novo), irmão possível de outra cadência que não pode dividir a
  coalescência 1/h desta tabela; "block" e não "lock" (trava é vocabulário do banco na casa). Constraints `fk_user_login_block_notice_to_user`
  e `ck_user_login_block_notice_seq` (o nome da FK é contrato da A2). **Efeito da auth-api**: nenhum — muda para o `auth_api` na A2 com as
  outras filhas, pelo nome novo. Recusado: (b) `tb_user_login_notice` (letra da D-EA3, simétrica com a irmã do 67).
- **D-EA15** (Valdo, 2026-11-01 — fecha a **Q-EA15** = (a), literal: *"(a) Ao atingir 10"*) — a vaga do aviso ao dono (D-EA3/D-EA14) é
  tomada na FALHA QUE LEVA A JANELA A 10 (contagem antes do INSERT = 9, sob a trava), no máximo 1 por hora por conta (coalescência
  `EXISTS created_at > NOW() - 1 HOUR`), sob `runIsolated` (D-RS10); a tentativa DURANTE o bloqueio não grava falha nem toma vaga — o caminho
  bloqueado fica só-leitura. Sob ataque contínuo a janela deslizante volta a 10 a cada falha que envelhece, o gatilho dispara de novo e a
  coalescência limita a 1/h (critério de sucesso 2). Motivo: é a letra "ao BLOQUEAR" da D-EA3 e cobre o stuffing que faz exatamente 10
  palpites e passa à próxima conta; no login as 10 erradas JÁ são o abuso (D-EA1), diferente da recuperação, onde 3 pedidos/h são legítimos
  e o aviso sai no pedido calado (D-RS8). **Efeito da auth-api**: nenhum — vai com o login na A2. Recusados: (b) a cada recusa durante o
  bloqueio (molde da D-RS8); (c) os dois.
- **A-EA1…A-EA8 RATIFICADAS** (Valdo, 2026-11-01, literal: *"Ratificar todas"* — o texto de cada uma no §P.6): A-EA1 falha e aviso valem
  com o ACESSO inativo (fatos da credencial); A-EA2 protocolo do login do §P.3 (senha conferida FORA da trava, pré-filtro sem trava, caminho
  certo também sob a trava, token assinado com a trava segura) + o limite da trava S das FKs de negócio até a A2; A-EA3 conta sem credencial
  = inexistente, sem linha; A-EA4 piso só nas recusas; A-EA5 volume sem retenção, medido; A-EA6 bloqueio sustentado = limite conhecido;
  A-EA7 sem a "2ª camada" 429 por e-mail; A-EA8 400 dos campos fica, corpo não-texto vira 400 (`bodyText`). **Com isto a Onda 1 não tem
  questão aberta** — executa no dia em que o passo 4 entrar no `main` (§P.7).
- **D-EA16** (Valdo, 2026-11-01 — fecha a **Q-EA16** = (a), literal: *"(a) Só com 4+ letras"*) — a regra da D-EA5 "a senha não pode conter
  a parte local do e-mail de login" só se aplica quando a parte local (o trecho antes do `@`) tem **4 ou mais caracteres**; a comparação é
  SEM maiúsculas e SEM acento (as duas pontas normalizadas do mesmo jeito, na peça `@shared/auth/password-policy` e no espelho Dart). Parte
  local de 1 a 3 caracteres = a regra não se aplica (o resto da política — mínimo 8, lista de comuns, igual à atual — segue valendo). Motivo:
  com `jo@…` toda senha com "jo" no meio seria recusada ("joaninha2026", "major-tom-88"); a regra quer pegar "valdo2026" para valdo@…, não
  coincidência de duas letras. **Efeito da auth-api**: nenhum — vai com a peça da política na A2. Recusados: (b) sempre; (c) só a senha
  IGUAL à parte local.
- **A-EA9 RATIFICADA** (Valdo, 2026-11-01, literal: *"Ratificar"*) — a lista de senhas comuns da D-EA5 é comparada SEM caixa ("Senha@123" =
  "senha@123"); vem de fonte pública com licença livre (ex.: SecLists, MIT) somada a uma lista brasileira; fica como ARQUIVO no setes-api,
  carregado uma vez (o boot recusa subir sem ele); o app guarda uma cópia e um teste confere o SHA-256 das duas. **Com isto a Onda 3 não tem
  questão aberta.**
- **D-EA17** (Valdo, 2026-11-01 — fecha a **Q-EA17** = (c), literal: *"(c) Medir no servidor"*) — o PESO final do scrypt (os parâmetros da
  D-EA9, `N=2^15,r=8,p=3`) é decidido pela MEDIÇÃO no servidor real, não pela máquina do dev (pré-medição de 2026-11-01: `p=3` ≈ 1,3 s por
  verificação aqui, `p=1` ≈ 0,4 s — §P.6). Valem em qualquer peso: o hash só é calculado com a conta FORA do bloqueio (pré-filtro — A-EA2) e
  o e-mail inexistente não calcula hash falso (o piso esconde). Recusados: (a) manter `p=3` e aceitar o piso acima de 1 s já; (b) `p=1`.
  ⚠️ **Choque com a ordem (achado ao registrar, dito ao Valdo)**: a recomendação desta questão dizia "até lá a Onda 4 do endurecer espera";
  mas a **D-AU11** exige o MD5 trocado ANTES da A2 e a **D-AU6** põe a A3 ANTES da Onda 4 do deploy (D-EA10 repete a ordem) — esperar o
  servidor do deploy para executar a Onda 4 empurraria a A2 e a A3 para depois do deploy. O jeito de conciliar é a **Q-EA18** (§P.6).
- **D-EA18** (Valdo, 2026-11-01 — fecha a **Q-EA18** = (a), literal: *"(a) Executar já"*) — a Onda 4 EXECUTA na ordem da D-EA10 (depois da
  Onda 3, antes da A2), com o peso da D-EA9 (`N=2^15,r=8,p=3`) como valor PROVISÓRIO; a medição no servidor real (D-EA17) confirma ou
  AJUSTA o peso depois, e o ajuste entra como troca de parâmetro: a peça reconhece "hash com parâmetros diferentes dos vigentes" e RECALCULA
  no próximo login certo, na mesma transação, pelo MESMO caminho da migração do MD5 (compare-and-set; sem tocar o `password_set_at` — não
  derruba sessão — exceção nomeada já registrada na cerca da D-EA7). Os parâmetros vigentes ficam num lugar só da peça (constante
  versionada, nunca no `.env` solto); o formato `scrypt$<params>$<sal>$<hash>` carrega os parâmetros de cada senha, então senhas com peso
  antigo seguem conferindo até o recálculo. Ordem da D-EA10/D-AU6/D-AU11 INTACTA (o MD5 sai antes da A2; a A3 antes do deploy). Motivo: hoje
  não há servidor público (memória "nada em produção") — o peso só pesa na máquina do dev até o deploy; esperar a medição travaria a A2.
  **Efeito da auth-api**: o recálculo por troca de parâmetro vai com a peça para a auth-api na A2 (como o do MD5). Recusados: (b) medir
  antes numa máquina igual à do servidor (a Onda 4 e a A2 esperariam); (c) A2/A3 depois do deploy (revia a D-AU6).
  **Com isto a fila da preparação (§P.6) está ZERADA — nenhuma questão aberta nesta frente.**

**Rodada 4 — 2026-11-01 (questões abertas pela EXECUÇÃO do item 0 — §P.8; uma por vez)**:

- **D-EA19** (Valdo, 2026-11-01 — fecha a **Q-EA19** = (b), literal: *"(b) Aviso primeiro"*) — no script do Super, o aviso da D-RS13 sai
  DEPOIS do COMMIT, FORA do `withDeadlockRetry` e **ANTES de a senha aparecer** no terminal: o sinal fora da máquina precede a entrega do
  segredo (o motivo da D-RS13). A espera é limitada pelos tetos do SMTP (15/15/30 s — D-RS17, ~1 min); o terminal avisa que cancelar na
  espera deixa a senha trocada e desconhecida — roda-se de novo (cada rodada, um aviso). O desfecho do aviso (enviado / ⚠ não enviado) é
  dito ANTES da senha. **EXECUTADA na mesma hora** na worktree `super-reset` (script + cerca S6 invertida + teste do adversarial "aviso antes
  da senha" + `CLAUDE.md` do setes-api; 59/59 + `adversarial-d-rs4-gate` 23/23; `tsc` limpo). Recusados: (a) senha primeiro + "NÃO feche";
  (c) sem a linha.
- **D-EA20** (Valdo, 2026-11-01 — fecha a **Q-EA20** = (a), literal: *"(a) Recusar"*; MUDA o comportamento descrito na D-PV46) — o script
  RECUSA, sem escrita, redefinir a senha de Super SEM e-mail de login (grupo 2, vivo, não vazio): o login é pelo e-mail — a senha nova não
  serviria para entrar, o aviso da D-RS13 não teria destino e a troca só derrubaria as sessões (D-EA7). Duas camadas: o ENSAIO anuncia
  "SEM E-MAIL DE LOGIN — o --vai será RECUSADO" e o `--vai` recusa antes da transação; o ATO (`resetSuperPasswordTx`) reconfere SOB a trava
  da linha do usuário (veredito `no-login-email`). A saída: cadastrar o e-mail de login do Super antes e rodar de novo (o script não
  cadastra e-mail — fora da exceção da D-PV46). **EXECUTADA na mesma hora** na worktree `super-reset` (peça + script + dublês dos dois
  testes + prova ao vivo no schema descartável com um Super ativo sem e-mail; 61/61; nenhuma sobra de schema descartável). Recusado: (b)
  manter a troca com o aviso no log.
- **D-EA21** (Valdo, 2026-11-01 — fecha a **Q-EA21** = (a), literal: *"(a) Mascarar em todos"*) — todo e-mail que vai ao LOG sai
  MASCARADO (`v***@setes.com.br` — 1ª letra + domínio), para TODO e-mail que a casa envia (código de recuperação, aviso ao dono — D-RS4 —,
  aviso ao Super — D-RS13): a regra é UMA e mora na peça de envio — `@shared/mailer` exporta `maskEmail` e `mailErrorForLog` (código,
  código de resposta do SMTP e a mensagem com TODO endereço mascarado; `response`/`rejected` do nodemailer nunca vão crus ao log); os logs
  da própria mailer ("Email enviado", modo sem SMTP) e dos chamadores (falha do envio da recuperação e da D-RS4, código em modo dev, aviso
  da D-RS4 em dev, aviso do Super) passam por ela; o `maskEmail` do módulo auth virou reexporte. O transporte recebe o endereço inteiro (só
  o LOG muda). Em dev o código de recuperação segue no log, agora com o e-mail mascarado. **EXECUTADA na mesma hora** na worktree
  `super-reset` (teste novo `mailer-mask-d-ea21.test.ts`; o `ADV-RS13-01` do gate virou `it`; dublês da mailer nos 4 arquivos de teste
  herdam as funções reais; mailer + recuperação + item 0 = 172 verdes). Recusados: (b) só no aviso do Super; (c) aceitar e corrigir o texto.
  Efeito na auth-api: nenhum — a mailer é da OPERAÇÃO (D-EA4); a regra vale para quem a usar.
- **D-EA22** (Valdo, 2026-11-01 — fecha a **Q-EA22** = (a), literal: *"(a) Limite conhecido"*) — a corrida "redefinir a senha do Super pelo
  script × outro Super rebaixar/revogar o vínculo pela tela de Usuários no MESMO instante" fica como LIMITE CONHECIDO: o
  `setInstitutionLinks` (módulo `users`) muda `kind`/`active` do vínculo sem a trava da linha do usuário, então a senha nova pode cair numa
  conta que, no COMMIT, já é admin; o desfecho é o de uma ordem válida ("redefine → rebaixa"), sem escalada de acesso — só a ordem no relógio
  se inverte. Os testes `ADV-RS16-02a/b` (`adversarial-super-reset-gate.test.ts`, ao vivo em schema descartável com a FK real) FIXAM a
  semântica (conhecimento negativo: não "consertar" sem decisão). Gatilho para rever: a A2 (os escritores de acesso mudam para a auth-api
  e a trava passa a ser a linha de `tb_user_credential`) ou um caso real. Recusado: (b) o `setInstitutionLinks` tomar a trava da linha do
  usuário como 1º passo (mexe no módulo `users`, fora deste item). Sem execução nova.
  **Com isto as questões do item 0 estão FECHADAS (D-EA19…D-EA22).**

**Rodada 5 — 2026-11-01 (questões abertas pelos gates do DELTA do item 0 — §P.8; uma por vez)**:

- **D-EA23** (Valdo, 2026-11-01 — fecha a **Q-EA23** = (a), literal: *"(a) Regra única"*) — "o e-mail de login do Super" para o script é UM,
  escolhido por UMA regra, na peça `pickLoginEmail` (`super-password-reset.ts`): o 1º (na ordem do id) e-mail de login vivo (grupo 2,
  vínculo e `tb_mailing` não excluídos) que, APARADO, é um endereço válido pelo MESMO `z.string().email()` do cadastro — devolvido aparado;
  nenhum válido = sem e-mail de login (recusa da D-EA20). A LISTA (`listSuperAccounts` traz os candidatos em `GROUP_CONCAT` na ordem do id)
  e o ENSAIO usam a peça; o ATO aplica a MESMA peça SOB a trava e devolve o escolhido no veredito (`{ status: 'reset', userId, loginEmail }`);
  o aviso da D-RS13 vai a ESSE e-mail (o script monta `{ ...target, loginEmail: verdict.loginEmail }`). Efeitos: 1º e-mail em branco + 2º
  válido → vale o 2º (o login entra por ele e o aviso sai a ele); espaço no fim → vale aparado; e-mail gravado como lista ou só de espaços
  → recusa ANTES da transação; e-mail trocado por SQL entre a lista e o ato → o aviso vai ao escolhido sob a trava. **EXECUTADA na mesma
  hora** na worktree `super-reset` (peça + script + dublês dos 3 testes; os achados ADV-EA20-01a/b/c e ADV-EA20-02 viraram `it` e os 3
  testes ao vivo foram reescritos para a regra nova; super-reset = 97 verdes). Recusados: (b) só alinhar a lista ao ato; (c) limite conhecido.
- **D-EA24** (Valdo, 2026-11-01 — fecha a **Q-EA24** = (a), literal: *"(a) Teto de 60 s"*) — a espera do aviso ao Super (D-EA19) tem TETO
  TOTAL de 60 s (`SUPER_NOTICE_CAP_MS`, corrida entre o envio e um relógio, na peça `sendSuperResetNotice`); estourado, o desfecho é
  `unconfirmed` — a tela diz "⚠ Aviso ao Super NÃO CONFIRMADO em 60 s (pode ainda sair — o desfecho vai ao log)" e a senha aparece; o envio
  SEGUE em segundo plano e o desfecho tardio (confirmado ou falhou) vai ao log, mascarado, nunca como rejeição solta; o processo só termina
  quando o servidor de e-mail responder ou desistir (a senha já está na tela). Junto, o transporte ganhou `dnsTimeout` de 15 s explícito
  (o padrão do nodemailer 6.10 é 30 s — o "DNS sem teto" do gate estava errado nesse ponto; o teto total segue necessário porque o
  `socketTimeout` conta só SILÊNCIO). Conhecimento negativo: os tetos do SMTP nunca limitam a espera TOTAL; quem precisa de teto total o
  põe por cima. **EXECUTADA na mesma hora** na worktree `super-reset` (peça + transporte + script; testes do teto com relógio curto —
  "unconfirmed", confirmação e falha tardias no log, relógio desligado no envio rápido; o `ADV-EA19-02` virou `it` e passa com o nodemailer
  REAL contra o SMTP local que pinga a resposta; 125 verdes nas suítes do item). Recusados: (b) outro teto; (c) limite conhecido.
- **D-EA25** (Valdo, 2026-11-04 — fecha a **Q-EA25** = (a), literal: *"a"*; perguntada pela frente da auth-api, §7 do
  `prompt_frente_auth_api.md`) — dado pessoal no log FORA de `/auth` (o `handleError` comum de `src/shared/http/controller-utils.ts:39`
  loga o `{ err }` cru do banco; o `sql` do mysql2 leva os parâmetros — e-mail, CPF, nome do cadastro; 47 arquivos de `src/modules` o usam)
  vira **FRENTE PRÓPRIA "dado pessoal no log"**: inventário de todo log da casa e correção de uma vez, com regra única. Nada muda no item 0
  (as três rotas públicas de `/auth` já foram corrigidas no delta — ADV-EA21-02) e a frente nova NÃO trava as Ondas nem a A2. Abrir a
  frente é da orquestradora da governança (todo trabalho nasce dela — D-GP28). Recusados: (b) estender já a todos os módulos dentro do item
  0; (c) limite conhecido fora de `/auth`.
- **D-EA26** (Valdo, 2026-11-04 — fecha a **Q-EA26** = (a), literal: *"(a) Recusar em todos"*) — a peça única de envio
  (`@shared/mailer`, `sendMail`) RECUSA (lança) destinatário que não seja UM endereço válido pelo `z.email()` do cadastro, para TODO
  e-mail da casa (recuperação de senha, aviso ao dono da D-RS4, aviso ao Super da D-RS13, e o que vier). A regra é uma e mora na peça,
  molde da D-EA21; a conferência própria do aviso ao Super passa a ser a da peça. Conferido em 2026-11-04 na worktree `super-reset`:
  `sendMail` (`src/shared/mailer/mailer.ts:186`) repassa `message.to` ao transporte sem conferir. Quem chama trata a recusa como
  falha de envio (a recuperação segue neutra — a resposta ao público não muda; o aviso ao Super dá 'failed'). Entra no item 0 e vai ao
  **gate do delta final** (§P.9 passo 2). Execução: só com o "sim" do Valdo para fechar o item 0. Recusado: (b) manter só no aviso ao Super.
  **EXECUTADA 2026-11-04** com o "Sim, executar" (§P.10).
- **D-EA27** (Valdo, 2026-11-04 — fecha a **Q-EA27** = (a), literal: *"(a) Só o do fim"*; aberta pelo gate socrático do delta final) —
  "aparado" na regra única do e-mail (D-EA23 × D-EA26) = SÓ o espaço (U+0020) do FIM, a MESMA igualdade com que o login acha a conta (PAD
  SPACE da colação). Espaço no início, tab, quebra, NBSP, BOM e afins nas pontas = RECUSA (o `z.email()` não os aceita). Motivo: com o
  `trim()` do JS o script do Super trocava a senha e avisava "a@x.com" numa conta gravada " a@x.com", com que ninguém entra (o motivo da
  D-EA20). Vale para TODO e-mail da casa (a peça é uma). **EXECUTADA na mesma hora** na worktree `super-reset` (commit local `5c397f6`):
  `singleMailAddress` corta só `/ +$/`; testes que fixavam o corte antigo ajustados (o gate adversarial final passou os brancos que não são
  o espaço do fim de "aceitos" para "recusados"). Recusado: (b) manter o `trim()` como limite conhecido.
- **D-EA28** (Valdo, 2026-11-05 — fecha a **Q-EA28** = (a), literal: *"(a) Limite conhecido"*; aberta pelo gate socrático do delta final) —
  a troca do e-mail de login pela tela (`syncLoginEmail`, módulo `users`, sem a trava da linha do usuário) no MESMO instante do ato do
  script do Super é LIMITE CONHECIDO, da mesma família e pela mesma razão da D-EA22: se a troca confirma depois de o ato ler o e-mail e antes
  do COMMIT, o ato grava e o aviso vai ao e-mail que o ato LEU (o velho) — desfecho de uma ordem serial válida ("redefine → troca o e-mail"),
  nada escala, a senha nunca vai a ninguém. Teste que FIXA a semântica: `[SEMÂNTICA D-EA28]` em
  `adversarial-super-reset-delta-gate.test.ts` (ao vivo, schema descartável). ⚠️ Escrito em 2026-11-05 com o MySQL do dev PARADO (serviço
  `mysql` Stopped — ligar exige administrador): a prova ao vivo do teste e a re-rodada da suíte ficam para quando o Valdo ligar o serviço.
  Recusado: (b) o módulo `users` tomar a trava da linha do usuário antes de trocar o e-mail (fora do item 0). **PROVADO ao vivo
  2026-11-05** com o MySQL de volta: `adversarial-super-reset-delta-gate` 34/34 (commit `fa5ff93`).
- **D-EA29** (Valdo, 2026-11-05 — fecha a **Q-EA29** = (a), literal: *"(a) Alarme no pré-voo"*; aberta pelo gate socrático do delta
  final) — o pré-voo do deploy (`scripts/pre-deploy-tz-check.ts`) faz o CENSO dos e-mails de login que a peça de envio recusaria
  (D-EA26/D-EA27) e mostra um ALARME com a contagem e os ids (e-mail mascarado — D-EA21), sem nunca barrar o deploy (não muda o código de
  saída). Motivo: para uma conta assim a recuperação de senha emite o código, consome o teto e não entrega — o único sinal era um
  `logger.error` por pedido; o censo deixa corrigir o cadastro antes de o titular precisar. **EXECUTADA na mesma hora** na worktree
  `super-reset` (commit local `1270ba0`): peça `src/modules/auth/login-email-census.ts` (`censusUnsendableLoginEmails` — a junção do login,
  o MESMO predicado `singleMailAddress`, só leitura), `checkLoginEmails` no pré-voo, teste `login-email-census-d-ea29.test.ts` (2/2);
  pré-voo rodado ao vivo no dev: 3 e-mails de login conferidos, nenhum com defeito. Recusados: (b) recusar subir; (c) só o log.
  **Fila do gate do delta final ZERADA (Q-EA27…Q-EA29).** Suíte inteira na `super-reset` depois da D-EA29, com o MySQL de volta:
  **167/167 arquivos, 2915 verdes, 34 pulados, 0 falha**; `tsc` limpo.
  *(Registro da D-EA27, que fica aqui pela ordem da escrita)* **Suíte inteira depois da D-EA27**:
  2910 verdes, 2 falhas de TEMPO sob carga (`adversarial-d-rs4-gate` "diferença < 300 ms" mediu 508 ms; `grupo-leitores-d-ge4` estourou
  5 s) — as duas passam isoladas (a do D-RS4, que tem o envio dublado e não passa pela peça, passou 2× seguidas); conhecimento negativo:
  na máquina do dev com outras sessões, cada rodada da suíte derruba um teste de tempo diferente — conferir isolado antes de chamar defeito.
- **D-EA30** (Valdo, 2026-11-05 — fecha a **Q-EA30** = (a), literal: *"(a) Entra com padrão"*; aberta pela re-prova dos gates das Ondas 1+2,
  ADV-REGATE-02) — no login com a senha certa, a admissão é decidida sob a trava; o bloco `context` ("é vendedor", decisão 17 — só ajuda de
  tela) é lido DEPOIS do COMMIT e, se a leitura falhar, a pessoa ENTRA com o contexto padrão (`isSalesman: false`) e sai alarme com ref
  (`alarmNeutral`) — nunca 500 (era oráculo da senha certa: a errada responde 401). **EXECUTADA** na `ondas12` (setes-api `aec9911`); o
  `it.failing` do gate virou `[CORRIGIDO D-EA30]`. Recusado: (b) recusar com a 401 + alarme.
- **D-EA31** (Valdo, 2026-11-05 — fecha a **Q-EA31** = (a), literal: *"(a) Limite conhecido"*; aberta pelo gate socrático das Ondas 1+2) —
  o token assinado no MESMO segundo de uma troca de senha concorrente sobrevive à troca (a revogação da D-EA7 compara
  `password_set_at <= iat`, os dois ao segundo): LIMITE CONHECIDO até a A2 (quando a credencial muda para `tb_user_credential`, a precisão
  pode ser revista). Sem código novo: a semântica JÁ está fixada pelo teste `fiscal-api/src/__tests__/access-a1.test.ts:138` ("semântica
  fixada — não corrigir"), pelo comentário em `fiscal-api/src/access/access.ts:84` e pela prova em descartável do setes-api
  (`password-set-at-d-ea7.test.ts`). Recusado: (b) comparação estrita (derrubaria o token emitido no mesmo segundo da própria troca).
- **D-EA32** (Valdo, 2026-11-05 — fecha a **Q-EA32** = (a), literal: *"(a) Sim, manter"*) — a linha de log da recusa do login (D-EA11)
  leva também o `userId` quando a conta foi achada (além do e-mail mascarado, IP, motivo e instante): com o e-mail mascarado, duas contas
  `v***@x` ficariam indistinguíveis na perícia (mesmo motivo da D-EA21). Complementa a letra da D-EA11. Sem código novo (já é assim na
  `ondas12`). Recusado: (b) tirar o número.
- **D-EA33** (Valdo, 2026-11-05 — fecha a **Q-EA33** = (a), literal: *"Mantenho o TExto"*) — o e-mail ao dono no bloqueio do login
  (D-EA3/D-EA15) fica com o texto da implementação, neutro: assunto "Setes — tentativas de acesso à sua conta"; corpo "Registramos, há
  pouco, tentativas de acesso à sua conta do Setes ERP que não foram concluídas. Se não foi você, troque a sua senha pela opção 'Esqueci
  minha senha' da tela de login. Não respondemos a este e-mail." — NÃO diz que a conta está bloqueada nem por quanto tempo (informação útil
  ao atacante). Sem código novo. Recusado: (b) acrescentar "o acesso fica suspenso por alguns minutos".
- **D-EA34** (Valdo, 2026-11-05 — fecha a **Q-EA34** = (a), literal: *"(a) Manter assim"*) — a linha `[ALARME LOGIN]` do LOG do alarme
  global (D-EA4) respeita o MESMO intervalo de 15 min do e-mail: no máximo uma a cada 15 min, para um ataque longo não inundar o log; cada
  recusa segue com a sua linha própria (D-EA11), nada se perde. Sem código novo (é o que `login-watch.ts` já faz). Recusado: (b) a linha de
  alarme a cada disparo, só o e-mail espaçado.
- **D-EA35** (Valdo, 2026-11-05 — fecha a **Q-EA35** = (a), literal: *"(a) Manter 400 ms"*) — o piso de tempo das recusas do login
  (`LOGIN_REFUSAL_FLOOR_MS` = 400 ms, copiado da recuperação) fica PROVISÓRIO na publicação das Ondas 1+2; o valor final sai da medição do
  p99 da resposta no SERVIDOR REAL, feita junto da D-EA17 (peso do scrypt). Sem código novo. Recusado: (b) medir agora no dev (não
  representa o servidor; exigiria reajuste).
- **D-EA36** (Valdo, 2026-11-05 — fecha a **Q-EA36** = (a), literal: *"(a) Pode baixar"*) — a lista de senhas comuns da D-EA5/A-EA9 = o
  arquivo `Passwords/Common-Credentials/10k-most-common.txt` do SecLists (MIT, (c) 2018 Daniel Miessler; SHA-256 `68782d6a…fdcce`, baixado
  em 2026-11-05) + uma lista BRASILEIRA escrita à mão (`setes-api/data/common-passwords-br.txt` — não há lista brasileira pública com
  licença clara), juntas por `scripts/gerar-common-passwords.ts` em `setes-api/data/common-passwords.txt` (só entradas de 8 a 100
  caracteres, em minúsculas, sem repetição — as menores já caem pelo tamanho; 2.231 entradas) e copiadas para o app como
  `setes_validators/lib/src/common_passwords.g.dart`. A conferência das duas cópias é ENTRADA POR ENTRADA (mais forte que o SHA-256 da
  A-EA9). Recusado: (b) o Valdo baixar à mão.
- **D-EA37** (Valdo, 2026-11-06 — fecha a **Q-EA37** = (a), literal: *"(a) Registrar no log"*) — a recusa "nova senha igual à atual" da
  troca pelo código (que não gasta o código nem conta erro — PP5) deixa UMA linha forense no log (`Troca de senha recusada: nova senha igual
  à atual (D-EA37)`, com a conta e o e-mail MASCARADO; nunca a senha nem o código) — rastro de quem tem o código e testa palpites da senha
  atual. EXECUTADA (setes-api `onda3`). Recusados: (b) contar também como erro do código; (c) deixar sem rastro.
- **D-EA38** (Valdo, 2026-11-06 — fecha a **Q-EA38** = (a), literal: *"(a) Ignorar as pontas"*) — a lista de senhas comuns compara a senha
  SEM o branco das pontas (a mesma lista explícita de brancos da peça): " 12345678" e "password " são recusadas como comuns; a senha GRAVADA
  segue como foi digitada e o espaço no meio continua valendo (frase-senha). Na peça e no espelho Dart, casos no vetor. EXECUTADA.
  Recusado: (b) deixar como estava.
- **D-EA39** (Valdo, 2026-11-06 — fecha a **Q-EA39** = (a), literal: *"(a) Recusar"*) — a política recusa senha com caractere que a
  pessoa não vê nem redigita (controle C0/DEL/C1 — inclusive tab, quebra de linha e U+0085 —, hífen suave, marcas de direção do texto,
  espaços de largura zero, U+FEFF) e meio emoji (substituto UTF-16 sem o par — o MD5 de hoje grava todos como U+FFFD), com o problema
  `invalid-char` ("A senha tem um caractere que não pode ser usado"); lista por UNIDADE UTF-16, igual na peça e no espelho; emoji inteiro,
  acento e espaços visíveis seguem valendo. EXECUTADA. Recusado: (b) deixar para a Onda 4.
- **D-EA40** (Valdo, 2026-11-06 — fecha a **Q-EA40** = (a), literal: *"(a) Limite conhecido"*) — na troca pelo código a regra do e-mail
  (D-EA16) julga o e-mail DIGITADO; a variante que a colação do banco iguala ao login (`ı` = `i`, `ß` = `ss`) acha a conta e deixa o
  titular — que tem o código — gravar uma senha com o nome do e-mail. LIMITE CONHECIDO (o titular escolhendo senha fraca, não ataque); o
  teste `[LIMITE CONHECIDO — D-EA40]` do `adversarial-onda3-gate.test.ts` fixa a semântica. Recusado: (b) julgar também com o e-mail da
  conta depois do código.
- **D-EA41** (Valdo, 2026-11-06 — fecha a **Q-EA41** = (a), literal: *"(a) Manter assim"*) — o `fields[].field` da recusa da senha aponta
  o NOME DO CAMPO QUE O CORPO TROUXE: `newPassword` na troca pelo código (`/auth/change-password`), `password` nos cadastros (users,
  `admin.password` no onboarding). Revê a letra do PP1/PA4 do §P.5 ("sempre `password`"); a tela ancora pelo caminho do corpo (Framework
  de Mensagens). Sem código novo. Recusado: (b) sempre `password` com tradução na tela.
- **D-EA42** (Valdo, 2026-11-06 — fecha a **Q-EA42** = (a), literal: *"(a) Limite conhecido"*) — no `PUT /api/users/:id` de conta que JÁ
  tem credencial, a política de senha (no DTO) fala antes do 409 `PASSWORD_OWNER_ONLY` (no service): quem chama a API direto com senha
  fraca vê primeiro "senha muito comum". LIMITE CONHECIDO — a tela nem mostra o campo de senha nessa conta. Sem código novo. Recusado: (b)
  inverter a ordem no fluxo do cadastro.
- **Fila da Onda 3 ZERADA** (D-EA36…D-EA42).
- **Gate do DELTA da Onda 3 (2026-11-06; 3a4cdb5..onda3 · e7119c6..onda3)**: socrático **0,80 ✅** · adversarial **0,84 ✅** (só LOW).
  Provado fora do jest: as 65.536 unidades UTF-16 em 5 formas de senha dão o MESMO branco, `invalid-char` e ORDEM de problemas em node e no
  Dart VM; o gerador reproduz a lista byte a byte. **Corrigidos** (cabem nas decisões): U+2028/U+2029 entram no `invalid-char` (D-EA39 —
  quebra de linha) e o sigma final `ς` dobra para `σ` nas duas pontas (D-EA16 — o `toLowerCase` do JS escreve Σ como ς no fim de palavra; o
  Dart VM não). **Limites conhecidos** (registro, sem decisão nova): seletores de variação U+FE00–FE0F e TAGs U+E0000–E007F seguem aceitos
  (fazem parte de emoji inteiro — D-EA39 "emoji inteiro vale"); o Dart VM (Android) tem tabela de caixa mais antiga em ~192 letras raras
  (Cherokee, Georgiano) — a API decide, o pior caso é a tela aceitar e a API recusar no campo; o boot confere a CONTAGEM da lista, não o
  conteúdo. Commits: setes-api `f40d9a8` (D-EA37) · `41aa476` (D-EA38) · `ed1a077` (D-EA39) · `5f1732c` (D-EA40) · `ea0555e` (delta) ·
  setes-app `384cae6` · `8ef508a` · `1039494`. Testes de TEMPO da recuperação (`adversarial-d-rs4-gate`, `adversarial-q-pv38-gate`) oscilam
  sob carga — passam isolados (49/49) e no `main`.
- **✅ PUBLICADO 2026-11-06** (Valdo: *"vai"*): o `main` do setes-api tinha andado (DEPLOY.E1.P1 de outra frente — núcleo fiscal pelo pacote
  `vendor/fiscal-api-1.0.0.tgz` + `package-lock.json` versionado) → juntado na `onda3` sem conflito (48cddd6; a junção `node_modules/fiscal-api`
  apagada ANTES do `npm ci`), suíte 175/175 (3124 verdes), `tsc` limpo → fast-forward no `main` do setes-api (**48cddd6**) e do setes-app
  (**1039494**), os dois no GitHub; na árvore viva `tsc` limpo, testes da política 156/156, `setes_validators` 152/152, boot de conferência
  (`Política de senha: lista de senhas comuns com 2231 entradas`; health 200) e desligado (não estava no ar). Nada de banco nesta onda.
  Worktrees `onda3\{setes-api, setes-app, sql, fiscal-api, nfse-api}` REMOVIDAS (junção da nfse-api apagada antes), branches `onda3`
  apagadas. **Próximo: Onda 4** (scrypt no lugar do MD5 — D-EA9 com o peso provisório da D-EA18; plano de testes H1–H10 no §P.5 item 3),
  com o "sim" do Valdo; depois a A2 da auth-api (§7.7 do `prompt_frente_auth_api.md`).

### P.14 ⏯ Onda 4 (scrypt) — desenho e ponto de retomada (2026-11-07; Valdo: "Sim, começar"; NADA de código ainda)

- **Onde**: worktree `D:\Gestao2027\onda4\setes-api` (branch `onda4`, a partir do `main` **48cddd6**, `.env` copiado) + irmãs destacadas
  `onda4\{sql, fiscal-api (main, build), nfse-api}` só para as cercas — `npm ci` disparado nas três (conferir que terminou). ⚠️ Ao remover,
  apagar ANTES a junção `nfse-api\node_modules\fiscal-api` (`cmd /c rmdir`); o setes-api agora usa o pacote `vendor/fiscal-api-1.0.0.tgz`
  (DEPLOY.E1.P1), sem junção.
- **Quem grava/confere senha hoje** (conferido 2026-11-07): `@shared/auth/password` (`md5Password`, `passwordMatches` — SÍNCRONA);
  escritores `users.service` (l. 139, 180), `institutions.service` (l. 104), `auth.service` `changePassword` (`md5(newPassword)` → `judgePasswordResetCode`),
  `super-password-reset.ts` (`hashInitialPassword` + o teste `/^[0-9A-F]{32}$/` na l. 165 — sai); leitores `auth.service` l. 160 (sob a trava,
  só quando o hash mudou), l. 212 (pré-veredito fora da trava), l. 591 (igual à atual — HOJE SOB A TRAVA). Testes que usam essas peças: ~40
  ocorrências em 13 arquivos (os fixtures montam hash por `md5Password` — continuam valendo como LEGADO).
- **Desenho proposto (cumpre D-EA9/D-EA18 e H1–H10)**:
  1. Peça `@shared/auth/password`: `hashPassword(plain): Promise<string>` (scrypt ASSÍNCRONO do `crypto` — nunca `scryptSync`: 1,3 s
     segurando o laço de eventos parariam a API inteira), sal 16 bytes, chave 32 bytes, formato `scrypt$N=32768,r=8,p=3$<sal b64>$<hash b64>`
     (≈ 92 caracteres ≤ 100); `checkPassword(plain, stored): Promise<{ ok, needsRehash, form: 'scrypt'|'md5'|'invalid' }>` — MD5 legado
     (32 hex) por `timingSafeEqual` com `needsRehash` quando bate; scrypt com os parâmetros DO VALOR GRAVADO, `needsRehash` quando bate e os
     parâmetros ≠ vigentes; parâmetros fora da lista ACEITA (N ∈ {2^14…2^17}, r = 8, p ∈ 1…4) ou forma desconhecida = `invalid` (recusa
     neutra + alarme, nunca cálculo); parâmetros VIGENTES numa constante só (`SCRYPT_CURRENT`); `maxmem` explícito (o teste fixa por quê).
     `md5Password` fica só para conferir/montar o LEGADO (cerca: nenhum escritor o chama).
  2. Escritores → `await hashPassword(...)` FORA de transação (o hash nunca sob a trava nem com conexão do pool presa).
  3. Login: pré-veredito `await checkPassword` fora da trava (só depois do pré-filtro — conta bloqueada e e-mail inexistente não calculam);
     se certo e `needsRehash`, o hash NOVO também é calculado FORA da trava; sob a trava: hash travado = lido → usa o pré-veredito (mudou →
     reconfere, caminho raro); admitido + `needsRehash` → `UPDATE … SET password = ? WHERE id = ? AND password = <lido>` (compare-and-set, SEM
     `password_set_at` — não derruba sessão; repositório novo `rehashPassword`), na MESMA transação. A regravação mata o código de
     recuperação aberto (HMAC amarrado ao hash — H5, linha no roteiro de deploy).
  4. Troca pelo código: o hash da nova (`hashPassword`) e o "igual à atual" (`checkPassword` contra o hash lido ANTES da trava) calculados
     FORA da trava; sob a trava, hash travado = lido → usa o pré-cálculo; mudou → reconfere (raro). Custo: 2 scrypt por tentativa da troca —
     contido pelo limite por e-mail (10/15 min) e por IP; registrar no gate.
  5. Script do Super: `await hashPassword`; o teste "32 hex" sai; o ato confere a forma nova.
  6. Testes H1–H10 (§P.5 item 3), cerca H6 (nenhum `createHash('md5')`/`md5Password` em escritor), prova H9 em schema descartável
     (`scripts/prove-scrypt-migration.ts`: 10 MD5 + 10 scrypt em logins paralelos), medição H8 (`scripts/measure-scrypt.ts`: p50/p95/p99 +
     pico de memória com 20 logins paralelos).
- **⚠️ QUESTÃO a levar ao Valdo DEPOIS da medição H8 (Q-EA43, ainda não perguntada)**: o piso das recusas do login é 400 ms (D-EA35,
  provisório) e o da recuperação também; com o scrypt `p=3` (≈ 1,3 s no dev) a conta EXISTENTE com senha errada responde em ~1,3 s e a
  INEXISTENTE em 0,4 s — o tempo diria quem tem cadastro (H7/H8 exigem o piso ACIMA do p99 do scrypt). Opções a apresentar com os números:
  (a) piso do login (e da troca pelo código) acima do p99 medido no dev, revisto na medição do servidor (D-EA17); (b) a conta inexistente
  calcula um scrypt falso (contraria a letra da D-EA9/H7 "conta inexistente NÃO calcula hash falso"); rec. provável (a).
- **⏯ Retomar (sessão nova)**: ler `D:\Gestao2027\CLAUDE.md`, este §P.14, o §P.5 item 3 (H1–H11), D-EA9/D-EA17/D-EA18/D-EA35 nas Decisões e
  o `CLAUDE.md` do `onda4\setes-api`; conferir se o `main` do setes-api andou (juntar na `onda4` se sim — a junção `node_modules/fiscal-api`
  não existe mais no setes-api); executar o desenho acima (1→6), suíte inteira, medição H8 → Q-EA43 ao Valdo (uma pergunta, palavras
  simples) → gates (dois agentes) → "vai" (sem banco: a coluna `password` varchar(100) já cabe) → Onda 4 publicada → A2 da auth-api.

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

**Rodada 2 — aberta 2026-11-01 (questão trazida pelo gate adversarial do delta da costura A1, sessão do passo 4)**:

- ✅ **Q-EA13 → D-EA13 (2026-11-01, (b) — recusar já, na costura do passo 4).** Texto original: **Q-EA13 — senha SÓ DE ESPAÇOS.** Fato (conferido 2026-11-01): o `userUpdateDto` do setes-api aceita `password` com
  `z.string().min(5)` (`users.dto.ts` POST e PUT, no `main` e na `privilegios-crud`) — '     ' passa e, numa conta SEM credencial (vinda
  do sync), vira a 1ª senha; pela D-PV48 depois só o titular troca. O app já fecha o caminho da tela (a aba Usuários do Estabelecimento
  manda `null` quando `trim()` dá vazio — commit local na `privilegios-crud`); a API segue aceitando. Teste que fixa o achado:
  `setes-api/src/__tests__/adversarial-a1-delta-gate.test.ts` ("PUT /api/users/:id com password só de espaços é recusado na validação",
  hoje `it.failing`). Com o mínimo 8 da D-EA5, oito espaços também passariam. Opções: (a) recusar quando `trim()` dá vazio, na peça da
  política da D-EA5 (Onda 3, API + espelho Dart) — até lá só o app barra; (b) igual a (a), mas a API já recusa AGORA, na costura do passo 4
  (regra no DTO de usuários, o `it.failing` vira `it`), e a peça da D-EA5 absorve depois; (c) não recusar (oito espaços seria só senha
  fraca). Espaços DENTRO da senha seguem válidos em qualquer opção (frase-senha). *(Rec.: (b) — o furo existe hoje pela API, a correção é
  uma linha com teste pronto e a Onda 3 pode demorar semanas.)*

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
   o token novo passa. *(Revisto pela D-EA7/D-AU8 e pela D-PV48: NA HORA, sem cache; o admin não troca senha de credencial existente —
   troca = código, "minha senha" ou script do Super. Já executado na costura A1.)*
7. Gates socrático ≥ 0,70 e adversarial sem HIGH/CRITICAL em cada onda; nenhuma senha, código ou e-mail inteiro em log.

## ⏯ Execução — prompt para a sessão nova (preparado 2026-11-01, a pedido do Valdo: "salve tudo e prepare um prompt para a nova etapa")

Estado ao preparar: decisões FECHADAS — recuperação D-RS1…D-RS18 (nenhuma questão aberta) e esta frente D-EA1…D-EA13 (nenhuma questão
aberta). Já executado na COSTURA A1 (passo 4, branch `privilegios-crud`, sessão própria, ainda SEM merge no `main` ao preparar): D-EA7
(`tb_user.password_set_at` + `iat`, inativação pela view viva — A-1…A-4 ratificadas), D-EA12 (`Auth OK` fora) e D-EA13 (`newPasswordSchema`,
commit local 745d2af). Nada desta frente além disso tem código.

Copiar para a sessão nova:

> Executar a frente "endurecer a autenticação" + o ajuste do script do Super no setes-api (e no setes-app na Onda 3), na ordem da
> D-EA10. Workspace `D:\Gestao2027`. ANTES de qualquer código, ler: `CLAUDE.md` da raiz; `Infra-IA/INDICE_CENTRAL.md`;
> `Infra-IA/prompts/prompt_endurecer_autenticacao.md` (decisões D-EA1…D-EA13 em "Decisões arquiteturais registradas" — o texto das
> ondas no §4 é a proposta da Rodada 0; onde divergir, vale a decisão); `prompt_privilegios_interfaces.md` §13.10.5 (D-RS7…D-RS18) e
> §14 (execução da costura A1); `prompt_frente_auth_api.md` §5–§6 (D-AU4, D-AU5, D-AU6, D-AU11 e as heranças da A2);
> `plano_retomada_2026-10-21.md` §2 (passo 10) e §6.3.
>
> **Pré-condição (conferir primeiro)**: o passo 4 do plano (bloco de privilégios + costura A1, branch `privilegios-crud`) está MERGEADO no
> `main` do setes-api. Ele mexe em `auth.service.ts`, `auth.repository.ts`, `auth.middleware.ts` e `super-password-reset.ts` — tudo o que
> esta frente toca. Se ainda não estiver no `main`, PARE e diga ao Valdo; nunca comece de outra base.
>
> **Ordem** (cada item em worktree própria a partir do `main`; parecer do guardião `setes-conceito` + `PADROES_BANCO` + `revisar-ddl`
> ANTES de qualquer DDL, prova em schema descartável; gates `revisar-riscos-sistemicos` ≥ 0,70 e `testar-adversarial` sem HIGH/CRITICAL;
> merge e publicação SÓ com o "vai" do Valdo — a árvore viva do setes-api roda `tsx watch` = deploy ao salvar, nunca editar lá):
> 0. **Script do Super** — D-RS7 (`--user-id`/`--email` também entre 2+ Supers ATIVOS; sem nome explícito continua recusando; a mensagem
>    deixa de citar a tela) + D-RS13 (depois de gravar, e-mail NEUTRO ao e-mail de login do Super pela `@shared/mailer`, sem link; falha do
>    envio = log, não desfaz) + reescrever a seção "Senha perdida do SUPER" do `setes-api/CLAUDE.md` (ainda cita a D-PV12, morta pela
>    D-PV48). Ficam como estão: D-RS14 (ativo = usuário E vínculo), D-RS15 (nada de `kind`/`updated_by` em `tb_user`), D-RS16 (Super
>    inativo é recusado, o script nunca reativa). O ensaio real do script é do Valdo (o classificador recusa o agente).
> 1. **Ondas 1+2** (nunca em paralelo com a onda 0 do convidado — as duas mexem no `login`): D-EA1 (10 erradas em 15 min, janela
>    deslizante, mesma 401 no mesmo tempo, sem botão; o script do Super não desbloqueia), D-EA2 (`tb_user_login_failure`, só falhas,
>    append-only, PK `(tb_user_id, seq)` sob a trava da linha do usuário — molde do sql/67; nasce em `setes_central`, muda para o `auth_api`
>    na A2), D-EA3 (`tb_user_login_notice`, aviso ao dono 1/h, texto neutro sem link, vaga sob SAVEPOINT — D-RS10), D-EA6 (UMA resposta
>    401 para senha errada/inexistente/inativo/sem vínculo; senha CERTA em conta inativa não conta como falha; o "login é o aceite" da
>    D-UC12 antes da contagem), D-EA11 (uma linha de log por falha: e-mail mascarado, IP, motivo interno), D-EA4 (contador em memória;
>    alarme acima de 100 falhas/min OU 30 contas/5 min → `[ALARME LOGIN]` + `recordCrash` + e-mail à operação 1/15 min; `OPS_ALERT_EMAIL`
>    OBRIGATÓRIO em produção, recusado no boot como o `assertMailerReady`; NUNCA bloqueia o login).
> 2. **Onda 3** (API e app JUNTOS): D-EA5 — peça `@shared/auth/password-policy` + espelho em `setes_validators` (mínimo 8, sem classes,
>    lista das 10 mil senhas mais comuns com as brasileiras, arquivo no repositório; recusa a parte local do e-mail de login e a igual à
>    atual; senhas existentes valem até a próxima troca), absorvendo o `newPasswordSchema` da D-EA13 (só espaços recusado). Portas:
>    criação (users e admin do onboarding), `/auth/change-password`, "minha senha" (D-UC7) se já existir.
> 3. **Onda 4** — D-EA9 (pré-requisito da A2, D-AU11): `scrypt` do `crypto` do Node, `N=2^15, r=8, p=3`, `maxmem` explícito, tempo e
>    memória MEDIDOS no gate; `scrypt$<params>$<sal>$<hash>` em base64 na mesma coluna (hex não cabe no varchar(100)); migração
>    transparente no login (MD5 legado confere e regrava na mesma transação); `timingSafeEqual` nos dois formatos; a regravação NÃO toca o
>    `password_set_at` (D-EA7 — não derruba sessão); o código de recuperação aberto daquela conta morre (aviso no roteiro de deploy);
>    trocar a peça `md5Password` cobre todos os escritores, e o script do Super deixa de validar a forma "32 hex".
>
> Depois disto vem a A2 da auth-api (fora deste prompt). Números de migration/seed: conferir o próximo livre na hora (075 = costura A1,
> 076 = `ib99`, seed 71 = `ib99`). Questão nova que aparecer = UMA por mensagem ao Valdo (memória `feedback-uma-pergunta-por-vez`),
> registrada em "Decisões arquiteturais registradas" deste prompt (próxima = D-EA14) + uma linha no §6.3 do plano. Ao fechar cada item:
> skill `atualizar-infra-ia` (INDICE com `git fetch` antes de numerar — o repositório tem dois clones e é PÚBLICO; `CLAUDE.md` da raiz;
> memória `endurecer-autenticacao`); commit da Infra-IA só dos próprios trechos, com o pedido do Valdo.

## ⏸ Preparação da execução (2026-11-01 — a pré-condição ainda NÃO está cumprida; só documento)

Sessão aberta pelo prompt acima. **Pré-condição conferida em 2026-11-01**: o `main` do setes-api está em **e61f9fe** (recuperação de senha +
D-GE4); o passo 4 (bloco de privilégios + costura A1) segue na branch `privilegios-crud` (ponta **42278bf**, com a D-EA7 e a D-EA13 —
745d2af), sem merge, em sessão própria. Por isso NENHUM código, branch ou worktree desta frente foi criado: a preparação abaixo é só
documento, para a execução começar no dia do merge sem reabrir leitura. Toda leitura de código foi feita na worktree
`D:\Gestao2027\privilegios\{setes-api,setes-app,sql}` SÓ PARA LER (nada editado lá); o banco do dev foi lido só por contagem.

### P.1 Números e estado conferidos (refazer a conferência na hora — outras frentes andam)

> **Atualização 2026-11-01 (mesma sessão, depois da fila zerada)**: o passo 4 ENTROU no `main` do setes-api — `main` = **42278bf** (o
> fast-forward da `privilegios-crud`; sql `main` = ff79a50; núcleo `main` = 9b19a9e); a worktree `privilegios` foi removida pela sessão do
> passo 4. **Pré-condição CUMPRIDA** — a execução começa pelo item 0 (§P.7). Números: sql livre = **74** (73 = `ib113`, sem merge);
> migration livre = **077** (075 no `main`, 076 = `ib99`).

- **Scripts sql** ocupados: 64–73 (66 `merchandise`, 67 recuperação, 68/70/72 `privilegios`, 69 `terminal`, 71 `ib99`, 73 `ib113`) →
  próximo livre **74**. **Migrations** do setes-api: 075 (`privilegios`), 076 (`ib99`) → próximo **077**. As duas tabelas novas são de
  `setes_central` (D-EA2/D-EA3): vão em SCRIPT sql numerado (molde do 67) + espelho no `sql/01`, não em migration por schema.
- **Banco do dev** (`setes_central.tb_user`, leitura de 2026-11-01): 13 usuários (3 vivos), **13 senhas MD5 em MAIÚSCULAS**, nenhuma
  vazia, nenhuma de outra forma; nenhuma tabela `tb_user_login*` ainda. `tb_user.password` = `varchar(100)`.

### P.2 Leitura do código (branch `privilegios-crud` 42278bf) — o que cada item toca

| Item | Arquivo · trecho | Hoje | Muda para |
|---|---|---|---|
| 0 | `src/modules/auth/super-password-reset.ts` + `scripts/reset-super-password.ts` (`pickTarget`) | 2+ Supers ATIVOS = recusa citando "a tela de Usuários do Super"; `--user-id`/`--email` só servem entre inativos; nenhum e-mail ao Super | D-RS7: nome explícito vale também entre ativos (sem nome segue recusando, mensagem sem a tela); D-RS13: e-mail neutro ao login do alvo DEPOIS do COMMIT, falha = log |
| 0 | `setes-api/CLAUDE.md` "Senha perdida do SUPER" | cita "Recusa … 2+ Supers ativos" e a tela | reescrita para D-RS7/D-RS13/D-RS14/D-RS16 (a D-PV12 já não aparece na versão da branch; o texto de 2+ ativos sim) |
| 1 | `src/modules/auth/auth.service.ts` `login` (l. 68–88) | sem transação, sem piso de tempo; compara MD5 por `toUpperCase() !==` (não constante); "Usuário inativo" (401) e "sem institution ativa" (**403**) saem DEPOIS da senha certa | D-EA1/D-EA6: trava da linha do usuário → contagem na janela → veredito; UMA 401 no MESMO piso; falha gravada; log da D-EA11 |
| 1 | `src/modules/auth/auth.routes.ts` `POST /auth/login` (l. 91–109) | lê `req.body` CRU — **achado da preparação**: `email` em array vira SQL inválido no mysql2 3.22 (`= 'a', 'b'`) → **500**; `password` objeto → `createHash().update(obj)` lança → **500** (o objeto no `email` vira `'[object Object]'` no 3.22 — conferido, sem injeção) | a coerção ÚNICA `bodyText` (`@shared/auth/login-email`), como a recuperação: não-texto = 400, nunca 500 |
| 1 | `auth.service.ts` `withResponseFloor`, `inPasswordResetTx`, `alarmNeutral`, `runInBackground`, `claimOwnerNotice` · `auth.repository.ts` `lockUserForPasswordReset` | moldes LOCAIS da recuperação | o login reusa os mesmos moldes (forma de compartilhar: §P.3) |
| 1 | `src/server.ts` (boot) | `assertPasswordResetReady` (script 67), `assertMailerReady` | + conferência das duas tabelas novas (script 74) e, na Onda 2, do `OPS_ALERT_EMAIL` em produção |
| 2 | `src/shared/mailer/mailer.ts` | única porta de e-mail; `assertMailerReady`/`mailerConfigProblems`/`isProduction` | `OPS_ALERT_EMAIL` entra na conferência de produção (molde D-RS5) + pré-voo `scripts/pre-deploy-tz-check.ts` |
| 3 | `src/shared/auth/password.ts` `newPasswordSchema` (5–100, só espaços recusado — D-EA13) · portas: `users.dto.ts` POST/PUT, `institutions.dto.ts` (admin), `auth.service.ts` `changePassword` (`length < 5` → 400) | mínimo 5 | peça `@shared/auth/password-policy` absorve o `newPasswordSchema` |
| 3 | app: `apps/web/.../users/presentation/page/user_page.dart` (l. 157–166, `minLength(5)`), `.../institutions/presentation/widget/institution_users_tab.dart` (l. 280–283, `minLength(5)`), `.../institutions/presentation/widget/institution_tab.dart` (l. 95, `< 5`), `packages/core/.../auth/presentation/page/change_password_page.dart` (l. 44, `< 5`) | 4 telas, 3 formas de escrever a mesma regra | um validador em `packages/setes_validators` (espelho) usado pelas 4 |
| 4 | `md5Password` em `users.service.ts` (l. 139 e 180), `institutions.service.ts` (l. 104), `auth.service.ts` (`changePassword`), `super-password-reset.ts` (`hashInitialPassword` + `/^[0-9A-F]{32}$/`) | todos os escritores passam pela peça (conferido de novo — confirma a D-EA9) | a peça grava `scrypt$…`; o login reconhece os dois formatos |

### P.3 Parecer do guardião (`setes-conceito`, 2026-11-01) — `tb_user_login_failure` (D-EA2) e o aviso da D-EA3

Pedido e lido nesta sessão (só leitura; o agente leu o molde do 67, o auth da `privilegios-crud`, PADROES §3/§3.1/§9/§10/§11 e a auth-api
§3–§6). Afirmações conferidas depois por leitura direta: a peça `@shared/db/savepoint.runIsolated` existe; FKs para
`setes_central.tb_user` em `tb_order` (migration 015), `tb_user_has_privilege` (003), `tb_institution_has_user` e nas filhas do 67.

- **Conceitos**: FALHA = "uma senha ERRADA foi julgada contra a credencial do usuário, num login ADMITIDO (conta fora do bloqueio), no
  instante T"; AVISO = "o sistema tomou a vaga horária de avisar o dono de que o login da conta foi bloqueado". Duas PEÇAS (fatos puros,
  sem regra embutida, sem coluna de estado); o `login` é a COMPOSIÇÃO (serializador da credencial + falha + vaga do aviso isolada + piso da
  recusa + mailer + log da D-EA11). O código fica no módulo `auth` (um consumidor só; o módulo inteiro muda para a auth-api na A2) — nada
  vai para `@shared`. **Nenhuma divergência com decisão do Valdo**; um nome diferente da letra da D-EA3 e o momento do aviso viram questões.
- **Nomes**: `tb_user_login_failure` CONFIRMADO (`_attempt` seria a opção (c) recusada na D-EA2). Aviso: recomenda
  **`tb_user_login_block_notice`** no lugar de `tb_user_login_notice` — a D-EA3 justificou a tabela própria por "bloqueio de login é outro
  processo"; "login notice" costuma ser o aviso de acesso BEM-SUCEDIDO (aparelho novo), um irmão possível de outra cadência → **Q-EA14**.
  Os nomes das FKs são CONTRATO da A2 (o DROP da FK entre bancos é pelo nome).
- **Falha** = PK + `created_at` + colunas padrão, sem `kind` (causa única; motivo só no log — D-EA11). **Grava**: senha errada contra
  credencial EXISTENTE, inclusive com usuário ou vínculo inativo/ausente (o fato é da CREDENCIAL; o acesso é a `vw_user_link` — D-AU5). **Não
  grava**: senha certa (qualquer estado — D-EA6), e-mail inexistente, **conta SEM credencial** (`password` NULL ou `''` — o predicado da
  A-PV23; na A2 "sem credencial" é a ausência da linha-mãe), tentativa DURANTE o bloqueio, recusa por contenção na trava.
- **Tentativa no bloqueio não grava** (nenhum palpite é julgado, nem o certo): ≤ 10 linhas por 15 min por conta (≤ 960/dia sob ataque, ~25–30
  MB/ano por conta atacada com o índice, sem retenção — §3.1); "50 erradas em paralelo" = exatamente 10 − (falhas já na janela); o bloqueio
  expira sozinho 15 min depois da 1ª das 10 (se a recusa gravasse, o próprio dono tentando de novo se bloquearia para sempre).
  **Conhecimento negativo**: o julgamento NÃO filtra por `password_set_at` — senão trocar a senha (até pelo script do Super) desbloquearia,
  contra a letra da D-EA1. **Limite conhecido**: quem conhece o e-mail mantém a conta bloqueada (~1 palpite a cada 90 s); o aviso 1/h é o
  sinal ao dono.
- **Leitura que decide**: índice **`idx_user_login_failure_window (tb_user_id, created_at)`** + `COUNT(*) … created_at > NOW() - INTERVAL 15
  MINUTE` (a letra da D-EA1; como o bloqueio não grava, a janela nunca passa de 10 entradas — `range` + `Using index`, qualquer que seja a
  história). Recusados: COUNT pelo prefixo da PK (varre a história sob a trava) e `ORDER BY seq DESC LIMIT 1 OFFSET 9` (exige a invariante
  "seq cresce com created_at", que o NTP quebra — teste da maquete). `deleted`/`updated_at` NÃO entram no julgamento (falha é fato que
  aconteceu; soft delete não desbloqueia — "sem botão" por construção). `created_at` = `NOW()` do banco em UTC (§10 regra 1 — a exceção do
  relógio da D-EA7 NÃO se aplica aqui).
- **Aviso**: sem `kind` (causa única = o nome); coalescência `EXISTS(created_at > NOW() - INTERVAL 60 MINUTE)` sob a trava (≤ 24 linhas/dia,
  sem índice extra); vaga sob SAVEPOINT pela peça `runIsolated` (D-RS10 — sem ele, um GRANT esquecido desfaria justamente a 10ª falha e a conta
  nunca bloquearia); destinatário = e-mail de login GRAVADO. Momento recomendado: **na falha que LEVA a janela a 10** ("ao BLOQUEAR" — D-EA3;
  cobre o stuffing que faz exatamente 10 e passa à próxima conta, e o caminho bloqueado fica só-leitura) → **Q-EA15**.
- **Protocolo do login** (pela trava da D-EA1 e a D-EA9 à frente): a senha é conferida FORA da trava; quatro ajustes — **(a)** o caminho da
  senha CERTA também passa pela trava antes de revelar o veredito (senão o 1205 → 401 vira palpite GRÁTIS: o errado não grava e o certo
  daria token); **(b)** sob a trava, o hash travado tem de ser o conferido (mudou = reconfere contra o travado); **(c)** pré-filtro SEM trava
  (COUNT consistente fora de transação): bloqueada = 401 sem conferir senha e sem trava — o scrypt e a fila não amplificam o ataque;
  **(d)** o token é assinado com a trava segura (fecha a troca de senha entre a admissão e a assinatura). Sequência:

  ```
  1. conta = findUserByEmail (fora de transação); sem conta, ou password NULL/'' → 401 (log: inexistente / sem credencial)
  2. pré-filtro: COUNT na janela (consistente, autocommit); ≥ 10 → 401 (log: bloqueado)
  3. veredito = confere(senha, conta.hash)                      -- FORA da trava (na Onda 4: scrypt)
  4. withDeadlockRetry: BEGIN
     a. SELECT id, password, active FROM setes_central.tb_user WHERE id = ? AND deleted = 'N' FOR UPDATE WAIT 5   -- 1º statement
        sumiu → 401 | hash ≠ conta.hash → reconfere contra o hash travado
     b. antes = COUNT(*) na janela (consistente — regra 13); antes ≥ 10 → 401, nada gravado, veredito NÃO olhado
     c. errada → INSERT (seq = MAX+1); se antes + 1 = 10: vaga do aviso via runIsolated (D-RS10); COMMIT → 401; e-mail depois, em 2º plano
     d. certa  → [Onda 4: regrava MD5 em scrypt sem tocar password_set_at — D-EA9]; vínculos (vw_user_link, consistente); D-UC12 só aqui;
                 inativo / sem vínculo → 401 sem gravar (D-EA6); senão assina o token → COMMIT → 200 (sem esperar o piso)
     1205 → 401 neutra, nada gravado, aviso de contenção no log; só 1213 reexecuta (regra 4)
  ```
- **Riscos registrados**: fila de logins da mesma conta (espera 5 s; acima, 401 neutra); tempo como oráculo sob contenção (limite já aceito
  na recuperação); a `vw_user_link`/`authMiddleware` leem consistente e não esperam; o PUT do cadastro trava `tb_entity` → `tb_user` sem
  ciclo com o login. ⚠️ **Toda tabela com FK para `tb_user` (pedido, privilégio, vínculo, filhas do 67) toma trava S na linha do usuário no
  INSERT até o COMMIT** — o login da MESMA conta espera a transação de negócio aberta e, passados 5 s, quem digitou a senha CERTA recebe
  "Email ou senha inválidos" (medir na prova; some na A2, quando a trava vira a linha de `tb_user_credential`, que nenhum negócio referencia).
  Recusado `FOR SHARE` no caminho certo (a regravação da D-EA9 promoveria S → X: dois logins paralelos = 1213 — regra 8).
- **Veículo**: script `sql/NN_user_login_failure_ddl.sql` em `setes_central` (NN = 74 hoje), re-executável, espelho no `sql/01` logo depois de
  `tb_user_password_reset_notice`; boot confere as DUAS tabelas pelas colunas (sem elas, toda senha errada viraria 500) — o índice não entra
  no boot (sem ele o login fica certo, só lento; conferido pelo EXPLAIN da prova); aplicar ANTES do setes-api (a árvore viva é deploy); fora
  do GRANT do usuário fiscal (D-AU12, lista positiva).
- **Nomes e peças no código**: `lockUserForPasswordReset`/`PASSWORD_RESET_LOCK_WAIT_SECONDS` passam a servir ao login → renomear pelo conceito
  (**`lockUserCredential`**/`CREDENTIAL_LOCK_WAIT_SECONDS` — o serializador de TODO fato da credencial; a A2 troca UMA função; nada de 2ª
  função de trava). `claimOwnerNotice` reimplementa à mão a receita do `runIsolated` → uma função do módulo auth sobre `runIsolated` +
  `alarmNeutral`, parametrizada pela PORTA da tabela de cada processo (nunca por um `kind` que misture processos). `withResponseFloor` →
  "piso da recusa neutra" do módulo auth com constante própria **`LOGIN_REFUSAL_FLOOR_MS`** (medida no gate e de novo na Onda 4). `maskEmail`
  sai do `super-password-reset.ts` para helper do módulo auth (log da D-EA11 — motivo interno ganha "sem credencial" e "contenção").
  `assertPasswordResetSchema` → conferência por LISTA (tabela, colunas, script, decisão) de todos os fatos da credencial. D-UC12 (convite
  aceito no login) só DEPOIS da admissão — senha certa em conta bloqueada nunca aceita convite.

### P.4 DDL — RASCUNHO pelo `revisar-ddl` (NÃO aplicado em lugar nenhum)

Texto do guardião (cabeçalho longo dele resumido aqui em comentário curto — o script final leva o cabeçalho completo no molde do 67, com o
conceito das duas tabelas, o protocolo de trava, o que NÃO grava e o efeito da A2). Nome do aviso DECIDIDO pela **D-EA14**.

```sql
-- NN — setes_central.tb_user_login_failure + tb_user_login_block_notice (D-EA1/D-EA2/D-EA3 — limite por conta no /auth/login)
-- Escopo: setes · molde sql/67 · Re-executável · aplicar em setes_central ANTES do setes-api (o boot confere as duas pelas colunas)
SET NAMES utf8mb4;
USE `setes_central`;

CREATE TABLE IF NOT EXISTS `tb_user_login_failure` (
  `tb_user_id` int(11)  NOT NULL COMMENT 'Usuario dono da credencial contra a qual a senha errada foi julgada',
  `seq`        int(11)  NOT NULL COMMENT 'N-esima falha do usuario: MAX+1 sob FOR UPDATE da linha tb_user',
  `created_at` datetime NOT NULL COMMENT 'Instante UTC (NOW do banco) do julgamento - a janela de 15 min da D-EA1 le este relogio',
  `updated_at` datetime DEFAULT NULL COMMENT 'Padrao da casa; fato imutavel - sem escritor depois do INSERT',
  `deleted`    char(1)  NOT NULL DEFAULT 'N' COMMENT 'Padrao da casa; sem escritor - o julgamento conta toda linha (soft delete nao desbloqueia)',
  PRIMARY KEY (`tb_user_id`, `seq`),
  KEY `idx_user_login_failure_window` (`tb_user_id`, `created_at`),
  CONSTRAINT `fk_user_login_failure_to_user` FOREIGN KEY (`tb_user_id`) REFERENCES `tb_user` (`id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ck_user_login_failure_seq` CHECK (`seq` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='D-EA2: senha errada julgada contra a credencial num login admitido; bloqueio = 10+ na janela de 15 min (derivado)';
-- revisar-ddl item 2 (abaixo): o índice também por fora, para o reexecutar CONSERTAR uma tabela criada sem ele
CREATE INDEX IF NOT EXISTS `idx_user_login_failure_window` ON `tb_user_login_failure` (`tb_user_id`, `created_at`);

CREATE TABLE IF NOT EXISTS `tb_user_login_block_notice` (
  `tb_user_id` int(11)  NOT NULL COMMENT 'Usuario dono da credencial avisado',
  `seq`        int(11)  NOT NULL COMMENT 'N-esimo aviso do usuario: MAX+1 sob FOR UPDATE da linha tb_user',
  `created_at` datetime NOT NULL COMMENT 'Instante UTC em que o sistema tomou a vaga da hora (e-mail sai depois do COMMIT)',
  `updated_at` datetime DEFAULT NULL COMMENT 'Padrao da casa; sem escritor depois do INSERT',
  `deleted`    char(1)  NOT NULL DEFAULT 'N' COMMENT 'Padrao da casa; sem escritor',
  PRIMARY KEY (`tb_user_id`, `seq`),
  CONSTRAINT `fk_user_login_block_notice_to_user` FOREIGN KEY (`tb_user_id`) REFERENCES `tb_user` (`id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ck_user_login_block_notice_seq` CHECK (`seq` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='D-EA3: vaga horaria do aviso ao dono de que o login da conta foi bloqueado (1/h por conta)';
```

Leituras e gravações (todas depois da trava; o pré-filtro usa a mesma contagem fora de transação):
`SELECT COUNT(*) FROM setes_central.tb_user_login_failure WHERE tb_user_id = ? AND created_at > NOW() - INTERVAL 15 MINUTE` ·
`SELECT COALESCE(MAX(seq), 0) + 1 … WHERE tb_user_id = ?` · `INSERT … (tb_user_id, seq, created_at, updated_at, deleted) VALUES (?, ?, NOW(),
NOW(), 'N')` · aviso no molde do 67 (`EXISTS` 60 min + MAX+1 + INSERT) dentro do `runIsolated`.

**Relatório do `revisar-ddl`** (2026-11-01; parser `sqlglot` 30.17 com `read='mysql'` = OK, 4 comandos — sem o `CREATE INDEX IF NOT EXISTS`,
que é sintaxe da MariaDB e se prova na aplicação em descartável):

1. **Estrutura**: PK `(tb_user_id, seq)` com as duas colunas declaradas; FK para `tb_user(id)`, que é PK; PK composta compatível com "N
   falhas/avisos por usuário" — ✅ sem achado.
2. **Re-executável × índice**: `CREATE TABLE IF NOT EXISTS` NÃO acrescenta o `idx_user_login_failure_window` a uma tabela que já exista sem
   ele (criada à mão num ensaio, ou por versão anterior do script) — e o boot, de propósito, não confere o índice. **Correção (aplicada no
   rascunho acima)**: `CREATE INDEX IF NOT EXISTS` logo depois do CREATE (MariaDB ≥ 10.1.4; o boot já detecta ≥ 10.3); a prova reaplica o script
   sobre uma tabela sem o índice e confere o EXPLAIN.
3. **Padrões da casa**: `tb_`, inglês, singular; `created_at`/`updated_at`/`deleted 'N'`; sem AUTO_INCREMENT (seq pela aplicação); `DEFAULT
   NULL` real; base certa (`setes_central` — fato da credencial, como o 67) — ✅. Comentário de TABELA (`COMMENT='…'`) é novidade frente ao 67
   (que não tem) — inofensivo; manter ou tirar por uniformidade é escolha de execução.
4. **Soft delete / pai apagado**: só INSERT; nenhum `DELETE`/`REPLACE`/`TRUNCATE`; o pai `tb_user` nunca é apagado fisicamente (§3.1 — o 67 já
   tem as mesmas FKs) — ✅.
5. **UNIQUE além da PK**: o índice NÃO é UNIQUE; nenhum `ON DUPLICATE KEY UPDATE` previsto (regra 10) — ✅.
6. **Collation**: nenhuma coluna de texto é comparada nem entra em JOIN (o `deleted` não decide nada) → sem CHECK com `COLLATE utf8mb4_bin` e
   sem risco de 1267; `utf8mb4_unicode_ci` como o 67 — ✅.
7. **CHECK**: `seq > 0` nas duas; o boot já confere que o banco aplica CHECK (`assertCheckConstraintsEnforced` — D-IB26) — ✅.
8. **Tempo**: `created_at` e a janela pelo MESMO `NOW()` do banco; o boot já confere a sessão em UTC (`assertSessionTimeZoneUtc` — Q-TZ1) — ✅.
9. **GRANT**: as duas ficam FORA do usuário fiscal (D-AU12 — lista positiva, estreitada na janela do passo 4). **Conferir na execução**
   (`SHOW GRANTS` do usuário da nfse-api depois do script) — se o passo 4 ainda tiver deixado `setes_central.*`, o GRANT novo é questão.
10. **Ordem/seed**: sem seed; CREATEs depois de `tb_user` (que já existe); espelho no `sql/01` logo depois de `tb_user_password_reset_notice` —
    ✅ (a fazer na execução).
11. **Segurança**: nenhuma senha, hash, IP ou e-mail nas tabelas (D-EA11) — ✅.

Nada aplicado: nem no dev, nem em schema descartável (a prova é da execução, depois do merge do passo 4).

### P.5 Plano de testes por item (o que cada gate precisa ver passar)

**Regras de todos os itens**: worktree própria a partir do `main` (com o passo 4 dentro); suíte inteira + `tsc` verdes; prova ao vivo SÓ
em schema descartável (molde `scripts/prove-password-reset-lock.ts`: cópia vazia de `tb_user`, SQL do código real com o schema trocado no
texto, `setes_central` conferido antes/depois, apaga no fim); gates `revisar-riscos-sistemicos` ≥ 0,70 e `testar-adversarial` sem
HIGH/CRITICAL (achado confirmado vira teste jest); nenhuma senha, código ou e-mail inteiro em log (varredura do JSON do logger nos testes).

**Item 0 — script do Super (D-RS7 + D-RS13)** — `src/__tests__/super-password-reset-d-pv46.test.ts` (dublê) + bloco ao vivo em descartável:
- S1 2+ Supers ATIVOS sem `--user-id`/`--email` → recusa (exit 2) e a mensagem NÃO cita tela nenhuma.
- S2 2+ ativos com `--user-id` de um deles → redefine aquele, e só aquele (o outro intocado: hash e `password_set_at`).
- S3 `--email` entre ativos → idem; e-mail de quem não é Super, ou de 2 Supers → recusa sem escrita.
- S4 Super inativo (usuário OU vínculo — D-RS14) segue recusado com nome explícito; o script nunca reativa (D-RS16).
- S5 depois do COMMIT sai UM e-mail ao e-mail de login GRAVADO do alvo, pela `@shared/mailer`: texto neutro com o instante na zona do
  estabelecimento da Setes (peça `@shared/time-zone`, config `time_zone` da institution 1), SEM link (regex `https?://` vazio), SEM a senha.
- S6 o e-mail sai FORA do `withDeadlockRetry` (deadlock simulado na 1ª volta → 1 envio só) e nunca antes do COMMIT (rollback = 0 envio).
- S7 `sendMail` lança → log de erro, a senha SEGUE trocada, a senha é impressa, exit 0 (D-RS13: falha do envio não desfaz).
- S8 dev sem SMTP → o aviso vai ao log como o da D-RS4 — sem a senha (varredura).
- S9 `password_set_at` gravado pela peça (D-EA7): o token anterior do Super recebe 401 `SESSION_REVOKED`.
- S10 `setes-api/CLAUDE.md`: a seção cita D-RS7/D-RS13/D-RS14/D-RS16, e nada de "tela de Usuários" como saída nem D-PV12.
- O ENSAIO real do script é do Valdo (o classificador recusa o agente) — dizer isso na entrega.

**Item 1 — Ondas 1+2** — testes de unidade com dublê (molde `auth-login.test.ts` + `auth-password-reset-q-pv38.test.ts`) e a prova
`scripts/prove-login-lock.ts` em descartável:
- L1 senha errada → 401 "Email ou senha inválidos" + 1 linha de falha; e-mail inexistente e conta SEM credencial (`password` NULL/`''`) → a
  MESMA 401, nenhuma transação, nenhuma linha.
- L2 senha CERTA em conta inativa, e senha certa sem vínculo vivo (`vw_user_link` vazia) → a MESMA 401 (o 403 morre), SEM linha de falha
  (D-EA6); senha ERRADA em conta inativa ou sem vínculo → linha de falha (palpite julgado contra a credencial — §P.3; A-EA1).
- L3 corpo, status e cabeçalhos IGUAIS nos 6 caminhos (errada, inexistente, sem credencial, inativo, sem vínculo, bloqueado) — corpo inteiro.
- L4 piso de tempo (`LOGIN_REFUSAL_FLOOR_MS`): TODO 401 responde ≥ piso (relógio controlado), o bloqueado pelo pré-filtro não sai mais cedo;
  o 200 sai sem esperar o piso (A-EA4).
- L4b pré-filtro: conta bloqueada NÃO confere a senha (espião na peça de conferência: zero chamadas) e NÃO toma a trava; a decisão de gravar
  é refeita sob a trava (pré-filtro diz "livre", 10 falhas chegam antes da trava → a tentativa seguinte é recusada sem gravar).
- L4c caminho CERTO sob a trava: com a linha do usuário presa por outra transação além de 5 s, a senha CERTA recebe a MESMA 401 (sem token)
  e a errada não grava — contenção não revela veredito; hash trocado entre a conferência e a trava → reconfere contra o travado.
- L5 10 erradas na janela → a 11ª com a senha CERTA = a mesma 401, sem token, sem linha nova; a falha mais velha envelhece (15 min) → a
  senha certa passa (janela DESLIZANTE, sem botão).
- L6 o script do Super troca a senha e NÃO desbloqueia (as falhas seguem; a senha nova também recebe 401 até a janela envelhecer).
- L7 lock wait (1205) na trava do login → a MESMA 401 + `logger.warn` (nunca 409 `RESOURCE_BUSY` — seria oráculo: conta inexistente
  nunca espera); deadlock (1213) → retentativa (`withDeadlockRetry`) e, esgotada, a mesma 401 + alarme com ref.
- L8 `email`/`password` não-texto (array, objeto, número) → 400, nunca 500 (`bodyText`).
- L9 log da D-EA11: UMA linha por falha com e-mail MASCARADO, IP, motivo interno (errada/inexistente/inativo/sem vínculo/bloqueado),
  instante — nunca a senha nem o e-mail inteiro.
- L10 aviso ao dono (D-EA3): vaga tomada na falha que LEVA a janela a 10 (Q-EA15), no máximo 1/h; tentativas no bloqueio não avisam nem
  gravam; o e-mail sai DEPOIS do COMMIT, em segundo plano (a 401 não espera o SMTP), ao e-mail de login GRAVADO; falha do INSERT do aviso
  (GRANT ausente simulado) → `runIsolated` desfaz só o aviso e a 10ª falha SOBREVIVE (D-RS10 — a conta bloqueia); e-mail inexistente nunca
  gera aviso; texto neutro sem link.
- L10b a troca de senha (código ou script do Super) NÃO filtra as falhas por `password_set_at` — a conta segue bloqueada (conhecimento
  negativo do §P.3).
- L13 **trava S das FKs**: login da MESMA conta enquanto uma transação de negócio dela insere em tabela com FK para `tb_user` (pedido) e
  segura o COMMIT por 6 s → medir e registrar (o esperado pelo parecer: 401 neutra depois de 5 s); 1 s → o login espera e passa.
- L11 seleção/troca de estabelecimento (`select-institution`/`switch-institution`) inalteradas; boot recusa subir sem as duas tabelas.
- L12 D-UC12 (o login é o aceite do convidado) ainda NÃO existe no `main` — se a onda 0 do convidado entrar antes, o aceite roda ANTES da
  contagem de vínculos ativos (D-EA6) e nunca em paralelo com esta onda (D-EA10).
- Prova `prove-login-lock.ts`: P1 DDL aplica e reaplica, CHECKs recusam o que devem; P2 **50 erradas em paralelo na mesma conta = exatamente
  10 linhas**, `seq` 1..10 sem buraco, zero deadlock que passe do retry; P3 40 contas × 3 erradas em paralelo = zero deadlock (regra 13 —
  leitura do filho consistente, sem FOR UPDATE de faixa); P4 rodada MISTA na mesma conta (erradas + certa + pedido e consumo de código da
  recuperação — as três filhas sob a MESMA trava) = zero deadlock; P5 `created_at` recuado → desbloqueia; P6 aviso: 50 erradas paralelas = 1
  linha de aviso, recuada 1 h → o próximo bloqueio toma `seq` 2; P7 a leitura que decide lê no máximo N linhas (EXPLAIN) com 10 mil falhas
  antigas da conta; P8 `setes_central` intocado.
- **Onda 2 (D-EA4)**, relógio controlado: A1 100 falhas/min não dispara, a 101ª dispara UMA vez; 30 contas distintas em 5 min não dispara, a
  31ª dispara; A2 dentro de 15 min, um e-mail à operação só; depois de 15 min, outro; A3 `[ALARME LOGIN]` no log + `recordCrash` com ref; A4
  o alarme NUNCA bloqueia (login certo de outra conta passa com o alarme no ar); A5 e-mail INEXISTENTE conta no contador; A6 memória com
  TETO: 1 milhão de e-mails distintos não crescem a estrutura (chave de tamanho fixo — `loginEmailBucket` — e corte na entrada acima do
  limiar); A7 boot em produção sem `OPS_ALERT_EMAIL` = não sobe (e com valor fora da forma de e-mail também), fora de produção vazio = só
  log; A8 falha do SMTP no e-mail de alarme = log, o login segue; A9 o pré-voo confere `OPS_ALERT_EMAIL` como confere o SMTP.

**Item 2 — Onda 3 (D-EA5)**, API e app juntos:
- PP1 a peça devolve a lista de problemas da senha; TODA porta usa a mesma peça e o mesmo `fields[{field:'password', message}]`:
  `POST /api/users`, `PUT /api/users/:id` (1ª senha de conta sem credencial — A-PV23), admin do onboarding (`institutions`),
  `/auth/change-password`, "minha senha" se já existir (D-UC7).
- PP2 7 caracteres recusa, 8 passa; 101 recusa; só espaços recusa (absorve a D-EA13 — o teste da D-EA13 segue verde); espaço dentro vale.
- PP3 lista de comuns (arquivo no repositório, carregado UMA vez; boot recusa subir sem ele): "12345678", "senha123" e as brasileiras
  recusadas; comparação sem caixa (proposta — §P.6).
- PP4 senha que contém a parte local do e-mail de login recusada, sem caixa e sem acento (`Valdo@…` × "VÁLDO2026" recusada), SÓ com parte
  local de 4+ caracteres (D-EA16): `jo@…` aceita "joaninha2026"; `abc@…` aceita "abc-12345"; `valdo@…` recusa "xvaldo99"; o MESMO julgamento
  no espelho Dart (vetor de casos compartilhado).
- PP5 **"igual à atual" só DEPOIS do código conferido**: no `/auth/change-password` a regra compara com o hash ATUAL; se rodasse antes de
  julgar o código, viraria ORÁCULO da senha atual sem código e sem o limite do login — a validação que não depende da conta (tamanho, lista,
  e-mail digitado) fica ANTES do código (como hoje, 400); a "igual à atual" fica DENTRO do julgamento, sob a trava, depois do código certo
  (e o código NÃO é consumido nessa recusa). Teste adversarial obrigatório (candidato a HIGH se errar).
- PP6 senha existente de 5 caracteres ainda LOGA (nada força troca); a senha inicial do script do Super (16 aleatórios) passa na política.
- PA1 espelho Dart em `packages/setes_validators` com os MESMOS casos — o teste Dart lê o vetor de casos do setes-api AO LADO (molde do
  `federal_id_test.dart`, que lê o vetor do núcleo); PA2 a lista do app = a lista da API (teste compara o SHA-256 dos dois arquivos); PA3 as
  4 telas do §P.2 usam o validador único e mostram a regra no campo; PA4 o 422 da API ancora no campo `password`; PA5 medir o tamanho do
  build web com a lista (decidir carregar sob demanda se pesar).

**Item 3 — Onda 4 (D-EA9)**:
- H1 formato `scrypt$<params>$<sal>$<hash>` em base64, sal de 16 bytes, `N=2^15, r=8, p=3`; maior valor ≤ 100 caracteres (cabe na coluna);
  `maxmem` EXPLÍCITO (128·N·r = 32 MiB = exatamente o padrão do Node — sem `maxmem` maior a chamada pode ser recusada: o teste fixa por quê).
- H2 certo/errado nos dois formatos com `timingSafeEqual`; hash fora das duas formas (texto puro, prefixo sem partes, base64 inválido,
  parâmetros fora da lista) = recusa neutra + alarme, nunca 500.
- H3 MD5 legado confere e REGRAVA em scrypt na MESMA transação; o 2º login compara scrypt; a regravação NÃO toca `password_set_at` (a cerca
  da D-EA7 já registra esta exceção nomeada — a sessão aberta NÃO cai).
- H4 regravação por compare-and-set (`WHERE id = ? AND password = <MD5 lido>`): senha trocada em paralelo (código da recuperação) nunca é
  sobrescrita pela migração.
- H5 a regravação mata o código de recuperação aberto (HMAC amarrado ao hash) — teste que fixa + linha no roteiro de deploy.
- H6 todos os escritores gravam scrypt pela peça (users POST/PUT, admin do onboarding, troca pelo código, script do Super); cerca por
  varredura: nenhum `createHash('md5')` de senha fora da peça; o script do Super deixa de exigir "32 hex".
- H7 **verificação FORA da trava** (protocolo do §P.3, já desde a Onda 1): o scrypt (centenas de ms, 32 MiB) roda ANTES de travar a linha e
  SÓ quando o pré-filtro diz "não bloqueada"; sob a trava só contar, decidir e gravar — senão cada login seguraria a linha e uma conexão do
  pool durante o hash; se o hash lido sob a trava ≠ o verificado, reverifica; conta inexistente NÃO calcula hash falso (o piso esconde).
- H8 MEDIÇÃO no gate: p50/p95/p99 do tempo e o pico de memória com 20 logins paralelos; o piso do login (L4) fica ACIMA do p99 do scrypt (a
  conta inexistente não calcula hash — sem isso o tempo diria quem existe); custo de CPU sob 300 req/min por IP registrado.
- H9 prova em descartável com os DOIS formatos (critério de sucesso 5): 10 contas MD5 + 10 scrypt em logins paralelos → todas migram, zero
  deadlock, `password_set_at` intacto.
- H10 **troca de PESO (D-EA18)**: com os parâmetros vigentes trocados na peça (ex.: `p=3` → `p=1` num teste), a senha gravada com o peso
  antigo AINDA confere (o peso vem do próprio valor gravado) e, no login certo, é RECALCULADA no peso novo na mesma transação, por
  compare-and-set, sem tocar o `password_set_at` (a sessão aberta não cai); login ERRADO nunca recalcula; senha já no peso vigente não é
  regravada (zero escrita no login comum); parâmetros vigentes num lugar só da peça (cerca: nenhum `N=`/`r=`/`p=` literal fora dela); o
  valor gravado com parâmetros FORA da lista aceita (ex.: `N` absurdo que estouraria a memória) = recusa neutra + alarme, nunca cálculo.
- H11 a medição no servidor real (D-EA17) vira tarefa do roteiro da Onda 4 do DEPLOY: rodar o mesmo script da H8 no servidor, registrar
  p50/p95/p99 e memória, e só então o Valdo confirma ou ajusta o peso (o ajuste = H10 em produção).

### P.6 Questões e assunções levantadas pela preparação (perguntar UMA por vez ao Valdo, antes da onda a que pertencem)

**Pré-medição do scrypt (fato, 2026-11-01 — máquina do dev, i7-8550U de 4 núcleos com os serviços do dev no ar, Node v21.7.3)**: por
verificação, `N=2^14,r=8,p=1` ≈ 190 ms · `N=2^15,r=8,p=1` ≈ 415 ms · **`N=2^15,r=8,p=3` (a D-EA9) ≈ 1,3 s** · `N=2^17,r=8,p=1` ≈ 2,0 s;
8 verificações em paralelo com o `crypto.scrypt` assíncrono = 3,0 s (o pool de threads do libuv tem 4 — ≈ 2,7 verificações/s nesta
máquina, e o MESMO pool atende `fs` e DNS: arquivo fiscal e SMTP esperariam na fila). Sem `maxmem` explícito o Node RECUSA `p=3`
(`ERR_CRYPTO_INVALID_SCRYPT_PARAMS` — 128·N·r = 32 MiB = o padrão). Valor de `$<params>$` com sal e hash em base64 = 92 caracteres (cabe
no `varchar(100)`). Leitura: a D-EA9 já manda confirmar por MEDIÇÃO no gate; o número acima é da máquina do dev carregada, não do servidor
da Onda 4 — mas, se o servidor ficar perto disso, o piso do login passa de 1 s e cada palpite contra conta EXISTENTE custa 1,3 s de CPU.

**Fila, na ordem de perguntar** (questões Q-EA uma por mensagem; as assunções A-EA podem ir juntas para ratificar, como as A-1…A-4 da
D-EA7 — "Ratificar todas"). Nenhuma trava a preparação; todas as da Onda 1 precisam estar fechadas ANTES do DDL e do código da Onda 1.

**Onda 1**
- ✅ **Q-EA14 → D-EA14 (2026-11-01, (a)).** Texto original: **Q-EA14 — nome da tabela do aviso** (guardião, §P.3): (a)
  **`tb_user_login_block_notice`** — nomeia o processo que a própria D-EA3 cita ("bloqueio de login") e não ocupa "aviso de login" (que
  costuma ser o de acesso bem-sucedido); (b) `tb_user_login_notice` — a letra da D-EA3, simétrica com a irmã do 67. *(Rec.: (a).)*
- ✅ **Q-EA15 → D-EA15 (2026-11-01, (a)).** Texto original: **Q-EA15 — momento do aviso ao dono**: (a) **na falha que LEVA a janela a 10** (a letra "ao BLOQUEAR"; cobre a rajada única e o ataque
  contínuo, até 1/h; o caminho bloqueado fica só-leitura); (b) a cada recusa DURANTE o bloqueio, até 1/h (molde da D-RS8 da recuperação) —
  não avisa quem faz exatamente 10 e passa à próxima conta, e põe escrita no caminho bloqueado; (c) os dois. *(Rec.: (a) — na recuperação o
  abuso começa no 4º pedido porque 3/h são legítimos; no login as 10 erradas JÁ são o abuso — D-EA1.)*
- ✅ **A-EA1** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — falha e aviso valem também com o ACESSO inativo (usuário ou vínculo inativo/ausente): são fatos da CREDENCIAL e não leem o
  acesso. Alternativas recusadas: só avisar com `tb_user.active = 'S'`; não gravar nada (a senha certa também dá 401).
- ✅ **A-EA2** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — protocolo do login do §P.3: caminho CERTO também sob a trava; 1205 = 401 sem gravar; hash reconferido sob a trava; pré-filtro
  do bloqueio sem trava e sem conferir senha; token assinado com a trava segura. Limite aceito junto: a trava S das FKs de negócio (L13) até
  a A2. Recusado: só o caminho errado sob a trava (palpite grátis sob contenção).
- ✅ **A-EA3** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — conta SEM credencial (`password` NULL ou `''`) = tratada como inexistente, sem linha (na A2 a linha ficaria sem pai).
- ✅ **A-EA4** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — piso de tempo SÓ nas recusas (todo 401); o 200 sai sem esperar (o token já distingue o sucesso). Recusado: piso em toda resposta
  (+ ~400 ms em todo login certo).
- ✅ **A-EA5** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — volume sem retenção (≤ 960 linhas/dia por conta atacada) aceito e medido; o índice tira o peso do login. Recusado: exceção à
  §3.1 para expurgar falhas antigas.
- ✅ **A-EA6** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — bloqueio sustentado por quem conhece o e-mail (~1 palpite a cada 90 s mantém a conta bloqueada) = LIMITE CONHECIDO, com gatilho
  para rever em passeio ou cliente. Recusado agora: "recuperação concluída encerra o bloqueio" (reveria a letra da D-EA1).
- ✅ **A-EA7** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — a "memória por e-mail (2ª camada), 20/15 min, 429" do texto da Onda 1 (§4) NÃO entra: a D-EA1/D-EA6 fixaram UMA 401 no mesmo
  tempo, e um 429 que só a conta existente pudesse provocar seria oráculo; o teto por IP do gateway e o alarme da D-EA4 cobrem o volume.
- ✅ **A-EA8** *(RATIFICADA 2026-11-01 — "Ratificar todas")* — o 400 "Os campos email e password são obrigatórios" fica (não depende da conta); só o corpo não-texto passa a 400 pela
  `bodyText` (hoje 500 — achado do §P.2).

**Onda 3**
- ✅ **Q-EA16 → D-EA16 (2026-11-01, (a)).** Texto original: **Q-EA16 — parte local CURTA do e-mail**: a D-EA5 recusa senha que CONTENHA a parte local do e-mail de login; com `jo@…` toda senha com "jo"
  cairia. (a) **aplicar só quando a parte local tem 4+ caracteres, sem caixa nem acento**; (b) sempre; (c) só recusar a senha IGUAL à parte
  local. *(Rec.: (a).)*
- ✅ **A-EA9** *(RATIFICADA 2026-11-01 — "Ratificar")* — a lista de comuns é comparada SEM caixa ("Senha@123" = "senha@123") e vem de fonte pública com licença livre (ex.: SecLists,
  MIT) + uma lista brasileira, guardada como arquivo no setes-api; o espelho do app confere o SHA-256.

**Onda 4**
- ✅ **Q-EA17 → D-EA17 (2026-11-01, (c)).** Texto original: **Q-EA17 — custo do scrypt × piso do login × CPU sob ataque** (com a pré-medição acima): (a) manter `N=2^15,r=8,p=3` e aceitar piso acima de
  1 s se o servidor medir perto disto (com `UV_THREADPOOL_SIZE` maior); (b) `N=2^15,r=8,p=1` (≈ 0,4 s aqui — abaixo do mínimo da OWASP que
  motivou o `p=3`); (c) **decidir só com a medição no servidor da Onda 4 do deploy; até lá a Onda 4 do endurecer espera**. Em qualquer opção:
  o hash só é calculado com a conta FORA do bloqueio (pré-filtro do §P.3) e a conta inexistente não calcula hash falso. *(Rec. provisória:
  (c) — a D-EA9 já mandava medir; o número desta máquina é sinal, não veredito.)*
- ✅ **Q-EA18 → D-EA18 (2026-11-01, (a)).** Texto original: **Q-EA18 — quando a Onda 4 executa, já que o peso final só sai da medição no servidor real (D-EA17)** — a D-AU11 exige o MD5 trocado
  ANTES da A2 e a D-AU6 põe a A3 ANTES do deploy; esperar o servidor do deploy empurra a A2 e a A3 para depois dele. Fato que ajuda: o
  formato `scrypt$<params>$<sal>$<hash>` GUARDA o peso junto de cada senha — trocar o peso depois é a MESMA migração transparente da troca
  do MD5 (quem logar com o peso antigo é recalculado no novo, na mesma transação, sem tocar o `password_set_at`). E hoje não há servidor
  público (memória "nada em produção") — o peso só pesa no dev até o deploy. (a) **executar a Onda 4 já com o peso da D-EA9 como
  PROVISÓRIO; a medição no servidor real confirma ou ajusta, e o ajuste entra como troca de parâmetro com recálculo no próximo login; a ordem
  da D-EA10/D-AU6/D-AU11 fica intacta**; (b) medir ANTES numa máquina igual à do servidor (ligar o plano da SaveInCloud só para medir), antes
  da A2 — a Onda 4 espera essa medição; (c) aceitar a A2 e a A3 DEPOIS do deploy (revê a D-AU6: o servidor público nasceria com a topologia
  que muda logo depois). *(Rec.: (a) — cumpre a D-EA17 sem travar a A2; o custo é a peça reconhecer "peso diferente do atual" e recalcular.)*

### P.7 Retomada — o que fazer no dia em que o passo 4 entrar no `main`

1. `git log` do `main` do setes-api: o merge da `privilegios-crud` está lá (procure 5931232/745d2af/42278bf ou o merge deles). Confira se o
   §P.2 ainda vale (`auth.service.ts`, `auth.repository.ts`, `super-password-reset.ts`, `password.ts` — mudaram depois de 42278bf?) e refaça
   o §P.1 (próximos números livres).
2. A fila do §P.6 está ZERADA (D-EA14…D-EA18 + A-EA1…A-EA9, 2026-11-01): comece pelo **item 0** (script do Super): worktree
   `D:\Gestao2027\super-reset\setes-api` (branch nova a partir do `main`), testes S1–S10, gates, entrega sem merge.
3. Ondas 1+2 em worktree própria — script `sql/74` (o rascunho do §P.4, já com `tb_user_login_block_notice` — D-EA14 — e o cabeçalho
   completo) + espelho no `sql/01` + prova `prove-login-lock.ts` em descartável ANTES do código; aviso na falha que leva a 10 (D-EA15);
   testes L1–L13 e A1–A9.
4. Onda 3 (D-EA5 + D-EA16 + A-EA9; testes PP/PA) e depois Onda 4 (D-EA9 com o peso PROVISÓRIO — D-EA18; testes H1–H10; a H11 vai para o
   roteiro do deploy). Cada uma: worktree própria, gates, "vai" para merge/publicação.

### P.8 Execução — item 0 (script do Super: D-RS7 + D-RS13) — 2026-11-01, com gates; NADA commitado

- **Onde**: worktree `D:\Gestao2027\super-reset\setes-api` (branch `super-reset`, a partir do `main` 42278bf) + irmãs DESTACADAS no
  `main` para as cercas entre repositórios: `super-reset\fiscal-api` (9b19a9e, `npm ci` + build), `super-reset\sql` (ff79a50) e
  `super-reset\nfse-api` (c6cc83d, `npm ci`). ⚠️ Ao remover: apagar ANTES as junções `setes-api\node_modules\fiscal-api` e
  `nfse-api\node_modules\fiscal-api` (memória `tooling-worktree-juncao-node-modules`) — hoje apontam para a irmã `super-reset\fiscal-api`,
  nunca para a árvore viva (conferido). `.env` e `package-lock.json` copiados da árvore viva (o lockfile do setes-api não é versionado).
- **O que mudou** (4 arquivos + 1 teste do gate): `src/modules/auth/super-password-reset.ts` — `pickSuperTarget` (D-RS7: alvo nomeado vale
  entre 2+ ativos; sem nome recusa; nenhuma recusa cita tela; e-mail vazio nunca casa), `inactiveTargetExit` (saída REAL do inativo: com
  outro ativo, a tela; sem outro, SQL manual — limite da D-RS16), `setesInstitutionZone` + `wallTimeInZone` (instante na zona do
  estabelecimento da Setes, falha = zona padrão), `superResetNoticeText` + `sendSuperResetNotice` (D-RS13: um e-mail ao e-mail de login
  GRAVADO, neutro, sem link, sem a senha, só para UM endereço válido pelo `z.email()` do cadastro; nunca lança; produção sem SMTP =
  'failed'); `scripts/reset-super-password.ts` (usa as peças; ENSAIO mostra o SMTP e o alvo inativo; o aviso sai DEPOIS do COMMIT e FORA do
  `withDeadlockRetry`, com "NÃO feche o terminal" antes); `CLAUDE.md` do setes-api — seção "Senha perdida do SUPER" reescrita para
  D-RS7/D-RS13/D-RS14/D-RS16 (sem "um Super define a do outro pela tela").
- **Testes**: `super-password-reset-d-pv46.test.ts` (S1–S8 + cerca S6 por âncoras obrigatórias + ensaio ao vivo por `spawnSync`, que
  separa a recusa — código 2 — da falha) e `adversarial-super-reset-gate.test.ts` (31 do gate, prova ao vivo em schema descartável com a FK
  real) = **59/59**; `tsc` limpo; suíte inteira com as irmãs: verde (as 7 falhas da 1ª rodada eram as cercas sem `sql`/`nfse-api` ao lado).
- **Gates**: socrático **0,78 ✅** (1 MEDIUM + 4 LOW) · adversarial **0,75 ✅** (5 LOW) — nenhum HIGH/CRITICAL. CORRIGIDOS na sessão:
  MEDIUM-1 (a linha "NÃO feche" — a ordem é a Q-EA19), LOW-2 (estado do SMTP no ensaio + ⚠ em "SMTP ausente" qualquer que seja o
  NODE_ENV), LOW-3/ADV-RS16-01 (ensaio e recusa do inativo com a saída real), LOW-4 (âncoras da cerca + `spawnSync`), ADV-RS13-02 (lista de
  endereços no e-mail gravado), ADV-RS7-01 (e-mail vazio na peça). FICAM: ADV-RS13-01 (`it.failing` — Q-EA21) e ADV-RS16-02 (semântica
  fixada — Q-EA22). Limites registrados pelo adversarial: COMMIT com desfecho incerto (perda de conexão no COMMIT = senha desconhecida e
  sem aviso; rodar de novo resolve — anterior a esta entrega); o script por `npx tsx` se vê como dev (só o `npm start` liga
  `NODE_ENV=production`) — por isso o ⚠ não depende do NODE_ENV; Ctrl+C durante o envio = troca sem aviso (Q-EA19).
- **Pendente**: as questões abaixo; o ENSAIO real do script é do Valdo (o classificador recusa o agente); merge/publicação só com o "vai".

**Questões do item 0 (uma por vez; nenhuma trava as Ondas 1+2)**:
- ✅ **Q-EA19 → D-EA19 (2026-11-01, (b) — EXECUTADA).** Texto original: **Q-EA19 — o aviso ao Super sai antes ou depois de a senha aparecer no terminal?** (gate socrático, Q-SR1) Hoje: senha primeiro, aviso
  depois + "NÃO feche". (a) manter assim (SMTP lento nunca segura a senha; fechar o terminal ainda mata o aviso); (b) **aviso primeiro, a
  senha só depois do desfecho** (até ~60 s de espera com SMTP mudo — D-RS17; Ctrl+C na espera = senha gravada e desconhecida, roda-se de
  novo, cada rodada um aviso); (c) sem a linha "NÃO feche". *(Rec.: (b) — o sinal fora da máquina precede a entrega do segredo, que é o
  motivo da D-RS13; a cerca S6 e o CLAUDE.md invertem.)*
- ✅ **Q-EA20 → D-EA20 (2026-11-01, (a) — EXECUTADA).** Texto original: **Q-EA20 — Super SEM e-mail de login: o script redefine a senha?** (gate socrático, Q-SR2) Hoje grava e imprime, mas o login é pelo
  e-mail — a senha nova não serve para entrar e não há aviso possível ('no-email'); a troca só derruba as sessões (D-EA7). (a) **recusar sem
  escrita** ("Super sem e-mail de login — corrija o e-mail antes"); (b) manter, com o aviso no log. *(Rec.: (a) — muda o comportamento
  descrito na D-PV46.)*
- ✅ **Q-EA21 → D-EA21 (2026-11-01, (a) — EXECUTADA).** Texto original: **Q-EA21 — o e-mail de login inteiro no log da `@shared/mailer`** (gate adversarial, ADV-RS13-01): a peça e o script mascaram, mas a
  mailer loga o destinatário INTEIRO ao enviar (`Email enviado` {to}) e no modo sem SMTP — o logger é o console, o e-mail aparece no mesmo
  terminal. A mailer serve também a recuperação e o aviso da D-RS4. (a) **mascarar o destinatário no log da própria mailer, para todos os
  e-mails da casa**; (b) mascarar só no aviso do Super; (c) aceitar e corrigir o texto do CLAUDE.md. *(Rec.: (a).)*
- ✅ **Q-EA22 → D-EA22 (2026-11-01, (a) — limite conhecido).** Texto original: **Q-EA22 — redefinição pelo operador × rebaixamento do vínculo por outro Super no mesmo instante** (gate adversarial, ADV-RS16-02 —
  ANTERIOR a esta entrega): `setInstitutionLinks` (módulo `users`) muda `kind`/`active` do vínculo sem a trava da linha do usuário; provado
  ao vivo que a senha nova pode cair numa conta que, no COMMIT, já é admin — o desfecho é o de uma ordem válida "redefine → rebaixa" (sem
  escalada). (a) **aceitar como limite conhecido** (os testes ADV-RS16-02a/b fixam a semântica); (b) `setInstitutionLinks` toma a trava da
  linha do usuário como 1º passo (mexe no módulo `users`, fora deste branch). *(Rec.: (a).)*

**Gates do DELTA do item 0 (2026-11-01 — D-EA19…D-EA21 + correções da 1ª rodada)**: socrático **0,77 ✅** (1 MEDIUM + 4 LOW) ·
adversarial **0,75 ✅** (5 LOW; arquivo novo `src/__tests__/adversarial-super-reset-delta-gate.test.ts`, 33 testes, nodemailer REAL contra
SMTP local de teste, prova ao vivo em schema descartável). Nenhum HIGH/CRITICAL. CORRIGIDOS na sessão (cabem em regra decidida): ADV-EA19-01
(`mailErrorForLog` nunca lança; o catch da peça blinda o log — a senha ainda aparece), ADV-EA21-01/L1 (`maskEmail` mascara TODO endereço
de valor gravado em lista), ADV-EA21-02 (as três rotas públicas de `/auth` param de logar o `err` cru — o `sql` do mysql2 levava o e-mail
digitado; agora código, errno e mensagem mascarada), M1 (o texto "~1 min" passa a dizer a verdade: servidor mudo ~1 min, lento/DNS passam
disso), L3 (o `CLAUDE.md` escopa a D-EA21 ao destinatário), L4 (comentários, cabeçalho do script com a D-EA20) e INFO (`userId` no log do
código em dev). Os 6 `it.failing` correspondentes viraram `it`; ficam 5 `it.failing` à espera das decisões abaixo (ADV-EA20-01a/b/c,
ADV-EA20-02, ADV-EA19-02). Suítes de auth/mailer/script = 217/217; `tsc` limpo. ⚠️ O `main` do setes-api ANDOU depois da base desta branch
(D-IB113: d5a7f35, 5cfd052 — sem arquivo em comum): antes do merge, trazer o `main` para a `super-reset`.

**Questões do delta (uma por vez; nenhuma trava as Ondas 1+2)**:
- ✅ **Q-EA23 → D-EA23 (2026-11-01, (a) — EXECUTADA).** Texto original: **Q-EA23 — qual é "o e-mail de login do Super" para o script?** (ADV-EA20-01/02, L2) A lista (fora da trava, 1º por id, sem filtrar
  branco), o ato (sob a trava, qualquer não vazio) e o aviso (`z.email()` no valor da lista) julgam de jeitos diferentes — provado ao vivo:
  1º e-mail só de espaços + 2º válido → o ato grava, o login entra pelo 2º e o aviso dá 'failed'; e-mail com espaço no fim → idem; e-mail
  trocado por SQL entre a lista e o ato → o aviso vai ao e-mail velho; e-mail só de espaços → o ensaio promete e o `--vai` recusa. Hoje 0
  linhas assim (o cadastro não deixa entrar). (a) **uma regra só, na peça: o ato, sob a trava, escolhe o e-mail de login que vale (vivo,
  aparado, endereço válido), o devolve no veredito e o aviso vai a ele; sem nenhum válido, recusa sem escrita; a lista e o ensaio usam a
  MESMA regra**; (b) só alinhar a lista ao ato (ignorar e-mail em branco); (c) limite conhecido. *(Rec.: (a).)*
- ✅ **Q-EA24 → D-EA24 (2026-11-01, (a) — EXECUTADA).** Texto original: **Q-EA24 — teto TOTAL da espera do aviso ao Super** (M1, ADV-EA19-02): o teto de 30 s do SMTP conta só silêncio e o DNS não tem teto —
  provado com o nodemailer real que um servidor que responde aos poucos prende o aviso sem fim (aos 62 s seguia pendente, senha gravada e
  não mostrada). (a) **teto total de 60 s no aviso (+ `dnsTimeout` no transporte); estourado, o desfecho é "⚠ aviso não confirmado em 60 s
  (pode ainda sair)" e a senha aparece**; (b) outro teto (ex.: 2 min); (c) limite conhecido, só o texto corrigido (já feito). *(Rec.: (a) —
  a D-EA19 foi aceita por ser uma espera limitada.)*
- ✅ **Q-EA25 → D-EA25 (2026-11-04, (a) — frente própria).** Texto original: **Q-EA25 — dado pessoal no log nas DEMAIS telas** (ADV-EA21-02 fora de `/auth`, L3): o `handleError` comum a todos os módulos loga o
  erro do banco cru — com o banco falhando, e-mail, CPF e nome de qualquer cadastro vão ao log (o `sql` do mysql2 vem com os parâmetros).
  (a) **frente própria "dado pessoal no log"** (inventário de todo log da casa; agora só as rotas de `/auth`, já feitas); (b) estender a
  D-EA21 já a todos os módulos; (c) limite conhecido fora de `/auth`. *(Rec.: (a).)*
- ✅ **Q-EA26 → D-EA26 (2026-11-04, (a) — a executar no item 0).** Texto original: **Q-EA26 — a peça de envio recusa destinatário que não seja UM endereço válido, para TODO e-mail da casa?** (socrático do delta, Q-B —
  risco ANTERIOR, exposto pelo delta) A recuperação de senha e o aviso da D-RS4 mandam ao e-mail gravado sem a conferência de endereço
  único que protege o aviso do Super: um e-mail gravado como lista ("a@x; b@y", de SQL ou carga do legado) faria o nodemailer mandar o
  CÓDIGO de recuperação a todos da lista. Hoje 0 linhas assim. (a) **o `sendMail` recusa (lança) destinatário que não seja um endereço
  válido pelo `z.email()` — a regra é uma e mora na peça, molde da D-EA21**; (b) manter só no aviso do Super. *(Rec.: (a).)*

### P.9 ⏯ Retomar — estado ao encerrar a sessão de 2026-11-01 (Valdo: "salve tudo e vamos encerrar esta sessao")

- **Código**: item 0 (script do Super) + D-EA19…D-EA24 + correções dos gates, na worktree `D:\Gestao2027\super-reset\setes-api`, branch
  `super-reset` — **commit LOCAL de salvaguarda `e8c9ee7`** (sobre o `main` 42278bf; sem push, sem merge). Irmãs destacadas na mesma pasta:
  `super-reset\{fiscal-api, sql, nfse-api}` (só para as cercas entre repositórios; nada mudou nelas). ⚠️ Ao remover: apagar ANTES as junções
  `setes-api\node_modules\fiscal-api` e `nfse-api\node_modules\fiscal-api` (memória `tooling-worktree-juncao-node-modules`).
- **Verde ao encerrar**: suíte inteira do setes-api na worktree 161/161 arquivos (2748 testes, 31 pulados, 0 falha); `tsc` limpo; nenhum
  schema descartável sobrando no banco do dev. Arquivos de teste novos: `adversarial-super-reset-gate.test.ts`,
  `adversarial-super-reset-delta-gate.test.ts`, `mailer-mask-d-ea21.test.ts` (o resto são ajustes em testes existentes).
- **Decisões desta sessão**: D-EA14…D-EA24 + A-EA1…A-EA9 (Rodadas 3–5 em "Decisões arquiteturais registradas").
- **Falta, NESTA ordem**:
  1. ~~**Q-EA25**~~ → **D-EA25** (2026-11-04: frente própria, nada no item 0); ~~**Q-EA26**~~ → **D-EA26** (2026-11-04: (a), a peça
     recusa — EXECUTAR com o "sim"). Fila do item 0 ZERADA. (Texto anterior: perguntar ao Valdo **Q-EA26** (`sendMail` só
     para UM endereço válido — rec. (a)); executar o que couber no item 0 (a Q-EA26 (a) mexe na `@shared/mailer`).)
  2. **Gate do delta FINAL** (socrático + adversarial) sobre o que entrou DEPOIS dos gates do delta: D-EA23 (`pickLoginEmail`, veredito com
     `loginEmail`), D-EA24 (teto de 60 s, `dnsTimeout`) e o que a Q-EA26 trouxer.
  3. Trazer o `main` do setes-api para a `super-reset` (o `main` andou com a D-IB113 — d5a7f35/5cfd052, sem arquivo em comum) e rodar a suíte.
  4. O **ensaio real** do script é do Valdo (o classificador recusa o agente): `npx tsx --require tsconfig-paths/register
     scripts/reset-super-password.ts` (sem `--vai`) na worktree.
  5. Merge/publicação do item 0 só com o "vai" do Valdo (a árvore viva do setes-api é deploy ao salvar).
  6. Depois: **Ondas 1+2** pelo §P.7 passo 3 (o rascunho do script 74 do §P.4 já com `tb_user_login_block_notice` — D-EA14; aviso na falha
     que leva a 10 — D-EA15; protocolo do §P.3 ratificado — A-EA2).

### P.10 Fechamento do item 0 — 2026-11-04 (Valdo: "Sim, executar"; pela frente da auth-api, `prompt_frente_auth_api.md` §7)

- **Passos 1–3 do §P.9 FEITOS** na worktree `D:\Gestao2027\super-reset\setes-api`, commits LOCAIS na branch `super-reset` (sem push, sem
  merge no `main`): `939b6bc` D-EA26 · `80d1ab8` merge do `main` (5cfd052, D-IB113 — sem conflito) · `acff626` correções do gate. Irmã
  `super-reset\sql` movida para o `main` do sql (2232b84, script 73); `super-reset\fiscal-api` FICA em 9b19a9e (o `main` do núcleo andou para
  c2c0a2f com a NE-2 de outra sessão — não entra aqui).
- **D-EA26 executada**: peça `singleMailAddress` (aparado + `z.string().email()`; não-texto = recusa) + `MailRecipientRejectedError`
  (`MAIL_RECIPIENT_INVALID`, mensagem mascarada) na `@shared/mailer`; `sendMail` recusa ANTES do transporte e do modo dev; `pickLoginEmail` e
  o aviso ao Super pelo MESMO predicado. Testes: `mailer-recipient-d-ea26.test.ts` (35 — o 1º achou o TypeError do não-texto, corrigido) e o
  bloco D-EA26 do `auth-password-reset-q-pv38.test.ts` (recuperação em PRODUÇÃO com e-mail gravado como lista: resposta 200 neutra, código só
  no HMAC, erro mascarado, nenhum código no log); fixture `a@x` → `a@x.com` no `mailer-d-rs5`.
- **Gate do delta final** (D-EA23 + D-EA24 + D-EA26): socrático **0,80 ✅** (5 pontos abertos, LOW/INFO) · adversarial **0,78 ✅** (1 MEDIUM
  + 3 LOW; arquivo `adversarial-super-reset-final-gate.test.ts`, 69 testes — nodemailer REAL `jsonTransport` em 18 endereços com cara de
  ataque que o validador aceita: UM destinatário no envelope; 37 recusados antes do transporte; prova AO VIVO em schema descartável, CHECKSUM
  de `setes_central` igual). Nenhum HIGH/CRITICAL. **CORRIGIDOS na sessão** (cabem nas regras decididas): ADV-FG-01 MEDIUM (a lista partia
  pelo `\n` um e-mail gravado inválido num pedaço válido que só a lista escolhia — D-EA23: o SQL da lista deixa FORA o candidato com quebra
  de linha, o mesmo que o ato recusa; e a lista CORTADA pelo `group_concat_max_len` — MySQL 8 padrão 1024 — é recusada alto); ADV-FG-02 (log
  e linha da senha com o e-mail que o ATO escolheu); ADV-FG-03 (a máscara aceita a aspa simples da parte local — D-EA21); a leitura da zona
  do aviso ganhou teto de 5 s (`SUPER_ZONE_CAP_MS`) e vem ANTES da promessa dos 60 s; a conferência do aviso ao Super é a da peça (era mais
  estrita); `CLAUDE.md` com D-EA25/D-EA26. Os 5 `it.failing` viraram `it` `[CORRIGIDO]`; teste novo `super-reset-final-gate-fixes.test.ts`.
- **Suíte**: antes das correções 2835 verdes + 1 falha de CARGA (`adversarial-f2a-a3-gate`, que passou isolado 27/27 — a suíte rodou junto
  dos gates); suítes do item 131/131 depois das correções; **suíte inteira depois das correções: 166/166 arquivos, 2909 verdes, 34
  pulados, 0 falha**; `tsc` limpo.
- **Censo no dev** (só leitura, pelo socrático): 3 logins vivos, 0 que a peça recusaria, 0 com espaço nas pontas.
- **Questões novas do gate (uma por vez; nenhuma é HIGH — o item pode ser publicado com elas como pendência explícita)**:
  - ✅ **Q-EA27 → D-EA27 (2026-11-04, (a) — EXECUTADA, `5c397f6`).** Texto original: **Q-EA27 — "aparado" é qual corte?** O ato e a peça aparam pelo `trim()` do JS (espaço do início, tab, quebra, NBSP); o login acha a
    conta por igualdade com PAD SPACE (ignora só o espaço do FIM). Login gravado " a@x.com" ou "a@x.com\t" → o script troca a senha e avisa
    "a@x.com", mas o login com "a@x.com" não acha a conta (contradiz o motivo da D-EA20). (a) **só o espaço do FIM é aparado (a mesma
    igualdade do login); qualquer outro branco nas pontas = recusa**; (b) manter o `trim()` (limite conhecido; dado só por SQL; 0 linhas no
    dev). *(Rec.: (a).)*
  - ✅ **Q-EA28 → D-EA28 (2026-11-05, (a) — limite conhecido; teste escrito, prova ao vivo pendente do MySQL).** Texto original: **Q-EA28 — troca do e-mail de login pela tela no mesmo instante do ato do script** (`syncLoginEmail` do módulo `users` troca sem a
    trava da linha do usuário): o aviso pode ir ao e-mail velho. (a) **estender o limite conhecido da D-EA22 ao e-mail, com teste que fixa
    a semântica**; (b) o módulo `users` toma a trava da linha do usuário antes de trocar o e-mail (mexe fora do item 0). *(Rec.: (a) — mesma
    família e mesma razão da D-EA22.)*
  - ✅ **Q-EA29 → D-EA29 (2026-11-05, (a) — EXECUTADA, `1270ba0`).** Texto original: **Q-EA29 — censo dos logins que a D-EA26 recusaria**: a recuperação de uma conta assim emite o código, consome o teto e não entrega
    (o único sinal é um `logger.error` por pedido). (a) **entra no pré-voo do deploy (`scripts/pre-deploy-tz-check.ts`) como ALARME**; (b)
    como recusa de subir; (c) só o log a cada pedido (como está). *(Rec.: (a).)*
- **✅ PUBLICADO 2026-11-05** (Valdo: *"Ensaio ok, vai"* — o ENSAIO real do script, sem `--vai`, foi rodado pelo Valdo e passou):
  `main` do setes-api avançado direto (fast-forward) de `5cfd052` para **`1270ba0`** na árvore viva e enviado ao GitHub; o setes-api não
  estava no ar (nada recarregou); nada de banco nesta entrega (nenhum script novo de `sql/`). Worktrees `super-reset\{setes-api, fiscal-api,
  sql, nfse-api}` REMOVIDAS (junções `node_modules/fiscal-api` apagadas antes — apontavam para a irmã, não para a árvore viva) e a branch
  `super-reset` apagada (o conteúdo está no `main`). Suíte na ÁRVORE VIVA (irmãs vivas — núcleo `fiscal-api` em c2c0a2f, com a NE-2): 2910
  verdes e 5 falhas de TEMPO sob carga (rodada de 810 s; 2 testes estouraram 5 s, 2 medições de tempo fora do limite, o ensaio do script
  passou dos 120 s do `spawnSync`); os 5 arquivos re-rodados em fila (`--runInBand`): **158/158 verdes**. `tsc` limpo. **Próximo: Ondas
  1+2** pelo §P.7 passo 3 (worktree própria a partir deste `main`).
- *(histórico)* **Falta, NESTA ordem**: ~~Q-EA27~~ (D-EA27) → ~~Q-EA28~~ (D-EA28, provada ao vivo) → ~~Q-EA29~~ (D-EA29, executada) — fila ZERADA; o **ensaio real** do script pelo Valdo na worktree (§P.9 passo
  4 — `npx tsx --require tsconfig-paths/register scripts/reset-super-password.ts`, sem `--vai`); o **"vai"** do merge `super-reset` → `main`
  e do push (árvore viva = deploy); depois as Ondas 1+2.

### P.11 Ondas 1+2 — execução em worktree (2026-11-05; Valdo: "Sim, começar"; NADA publicado, NADA aplicado em `setes_central`)

- **Onde**: `D:\Gestao2027\ondas12\{setes-api, sql}` (branches `ondas12`, a partir dos `main` 1270ba0 / 2232b84) + irmãs destacadas
  `ondas12\{fiscal-api (main c2c0a2f, build), nfse-api}` só para as cercas (junções `node_modules/fiscal-api` apontam para a irmã — apagar
  ANTES de remover). Commits LOCAIS: sql **474bf2a** (script `74_user_login_failure_ddl.sql` + espelho no `01`) · setes-api **07c2f7c**
  (entrega) · **444c253** (correções dos gates) · **89d1ac4** (teste da re-prova).
- **O que entrou** (pelo §P.3–§P.5): `tb_user_login_failure` + `tb_user_login_block_notice` (D-EA2/D-EA14, boot recusa sem elas —
  `assertLoginLockReady`); login com limite por conta (D-EA1: 10/15 min, janela deslizante, senha certa recusada no bloqueio, sem
  desbloqueio por troca de senha), resposta única 401 com piso `LOGIN_REFUSAL_FLOOR_MS` = 400 ms (D-EA6; "Usuário inativo"/403 morreram),
  senha conferida fora da trava em tempo constante (`passwordMatches`), trava `lockUserCredential` (ex-`lockUserForPasswordReset`), aviso ao dono
  na falha que leva a 10 sob SAVEPOINT (D-EA15; receita única `claimNoticeSlot` também para a recuperação), uma linha de log por recusa
  (D-EA11), alarme global em memória `src/modules/auth/login-watch.ts` (D-EA4) com `OPS_ALERT_EMAIL` obrigatório em produção (boot +
  pré-voo), Swagger do `/auth/login`, `CLAUDE.md`. Testes `auth-login-lock-d-ea1` (34) + `login-watch-d-ea4` (15) cobrindo L1–L13/A1–A9.
  Prova `scripts/prove-login-lock.ts` em descartável: 50 erradas paralelas = 10 linhas, 0 deadlock, 1 aviso; EXPLAIN pelo índice; L13 =
  limite aceito (trava S de FK de negócio segura o login até 5 s → recusa neutra).
- **Gates**: 1ª rodada REPROVADA — socrático **0,66** · adversarial **0,62**, o MESMO **HIGH**: sob a trava do login (1 conexão + FOR
  UPDATE) o caminho da senha certa pedia OUTRA conexão ao pool (vínculos e contexto por `pool.query`; pool 20, sem prazo) → 20 logins
  certos simultâneos travavam a API inteira (provado com o pool dublado e a semântica do mysql2 provada ao vivo). **CORRIGIDO**: vínculos pela
  conexão da transação, assinatura (sem banco) segue sob a trava, o `context` lido DEPOIS do COMMIT. Junto: log do e-mail digitado só mascara
  endereço único (ADV-O12-03 — "e-mail + senha" no campo levava a senha ao log), teto de 320 caracteres no e-mail (acima = mesma recusa do
  inexistente, sem banco), uma linha por recusa na contenção. **Re-prova do delta: socrático 0,80 ✅ · adversarial 0,82 ✅**, sem HIGH.
  **Conhecimento negativo**: NUNCA `pool.*` com transação aberta (o mysql2 espera conexão sem prazo — teste `[SEMÂNTICA]` ao vivo); o
  `recordCrash` do `alarmNeutral` dentro do SAVEPOINT só não trava porque é sem `await` — nunca pôr `await` ali.
- **Suíte inteira** depois das correções: **170/170 arquivos, 2990 verdes, 34 pulados, 0 falha**; `tsc` limpo.
- **Questões (uma por vez, ao Valdo direto — D-GP53)**:
  - ✅ **Q-EA30 → D-EA30 (2026-11-05, (a) — EXECUTADA, `aec9911`).** Texto original: **Q-EA30 — contexto ilegível depois do COMMIT** (ADV-REGATE-02, LOW, aberto pela correção do HIGH): se a leitura do bloco "é vendedor"
    falhar depois da admissão, o login com a senha certa hoje responde 500 sem ref (a errada responde 401). (a) **entra com o contexto padrão
    (`isSalesman: false`) + alarme com ref — a admissão já foi decidida e o contexto é só ajuda de tela**; (b) recusa neutra 401 + alarme
    (como antes da correção). *(Rec.: (a).)*
  - ✅ **Q-EA31 → D-EA31 (2026-11-05, (a) — limite conhecido, já fixado por teste).** Texto original: **Q-EA31 — token assinado no mesmo segundo de uma troca de senha concorrente**: a revogação compara `password_set_at <= iat` ao
    segundo; uma troca que grava no MESMO segundo da assinatura deixa vivo o token recém-assinado. (a) **limite conhecido até a A2, com teste
    que fixa**; (b) comparação estrita (derruba também o token emitido no mesmo segundo da própria troca). *(Rec.: (a).)*
  - **Q-EA32…Q-EA35 (da implementação)** — ✅ Q-EA32 → D-EA32 (2026-11-05, (a)) · ✅ Q-EA33 → D-EA33 (2026-11-05, (a) manter o texto): `userId` na linha do log (D-EA11 lista e-mail mascarado, IP, motivo, instante; incluído porque
    duas contas `v***@x` ficariam indistinguíveis); o texto do aviso de bloqueio (segue a D-EA3, não diz "conta suspensa"); a linha
    `[ALARME LOGIN]` do log também respeita os 15 min; o piso de 400 ms provisório (medir no servidor real, junto da D-EA17).
- **Falta**: Q-EA30…Q-EA35 → executar o que couber → "vai" (janela: script 74 em `setes_central` ANTES do código; `OPS_ALERT_EMAIL` no
  `.env` vivo; merge `ondas12` → `main` nos dois repositórios + push) → Onda 3.

### P.12 ⏯ Retomar — estado ao encerrar a sessão de 2026-11-05 (Valdo: "salve tudo e abra uma nova sessão", contexto em 76%)

- **Código** (nada publicado, nada aplicado em `setes_central`): worktree `D:\Gestao2027\ondas12` — `setes-api` branch `ondas12` até
  **aec9911** (07c2f7c entrega · 444c253 correções do HIGH · 89d1ac4 teste da re-prova · aec9911 D-EA30); `sql` branch `ondas12` em **474bf2a**
  (script 74 + espelho no 01); irmãs destacadas `ondas12\{fiscal-api (c2c0a2f, build), nfse-api}` só para as cercas — ⚠️ ao remover, apagar
  ANTES as junções `setes-api\node_modules\fiscal-api` e `nfse-api\node_modules\fiscal-api` (`cmd /c rmdir`; apontam para a irmã).
- **Verde ao encerrar**: suíte inteira 170/170 (2990) antes da D-EA30; depois dela, os arquivos de login 61/61; `tsc` limpo; gates 0,80/0,82.
- **Decididas nesta sessão**: D-EA30 (contexto padrão + alarme), D-EA31 (mesmo segundo = limite conhecido), D-EA32 (`userId` no log),
  D-EA33 (texto do aviso mantido).
- **Falta, NESTA ordem**:
  1. **Q-EA34** — a linha `[ALARME LOGIN]` do LOG também respeita o intervalo de 15 min (a D-EA4 diz "no máximo 1 a cada 15 min" só para o
     e-mail; a implementação segurou também o log, para não inundar). (a) manter assim (rec.); (b) o log sai a cada disparo, só o e-mail espera.
  2. **Q-EA35** — o piso de tempo das recusas do login (`LOGIN_REFUSAL_FLOOR_MS` = 400 ms) é provisório (copiado da recuperação). (a) manter 400
     e medir o p99 no servidor real junto da D-EA17 (rec.); (b) medir agora no dev e ajustar antes da publicação.
  3. Rodar a suíte inteira de novo na `ondas12` (depois da D-EA30); se uma questão mexer em código, gate do delta.
  4. **"vai" da janela** (com o Valdo): conferir se o `main` do setes-api/sql andou (trazer para a `ondas12` e re-rodar) → aplicar o
     **script 74 em `setes_central` ANTES do código** (o boot recusa subir sem as tabelas) → pôr `OPS_ALERT_EMAIL` no `.env` vivo (obrigatório
     só em produção; fora dela vazio = só log) → fast-forward `ondas12` → `main` no setes-api e no sql + push → remover a worktree (junções antes).
  5. Depois: **Onda 3** (política de senha, API + app juntos — §P.5 item 2) → **Onda 4** (scrypt) → a A2 da auth-api (§7.7 do
     `prompt_frente_auth_api.md`).
- **2026-11-05 (sessão sucessora)**: passos 1–3 FEITOS — **D-EA34** e **D-EA35** decididas, ambas (a), sem código novo; suíte inteira na
  `ondas12` depois da D-EA30: 170/171 arquivos, 3004 verdes, 1 falha de TEMPO sob carga (`adversarial-d-rs4-gate`) que passou isolada 23/23 —
  sem gate do delta (nenhum código novo). `main` do setes-api (1270ba0) e do sql (2232b84) NÃO andaram. Falta o passo 4 (o "vai").
- **✅ PUBLICADO 2026-11-05** (Valdo: *"Vai"*): `main`s conferidos sem avanço (nem no GitHub) → script `sql/74` APLICADO em `setes_central`
  ANTES do código (as duas tabelas conferidas, com o índice da janela) → fast-forward no sql (2232b84 → **474bf2a**) e no setes-api
  (1270ba0 → **aec9911**), os dois enviados ao GitHub → na árvore viva `tsc` limpo e os testes do login 102/102 → boot de conferência
  (`Limite por conta do login (script 74): ok`; `OPS_ALERT_EMAIL` ausente = só log fora de produção; health 200) e desligado (não estava no
  ar) → worktrees `ondas12\{setes-api, sql, fiscal-api, nfse-api}` REMOVIDAS (junções apagadas antes; apontavam para a irmã), branches
  `ondas12` apagadas. ⚠️ **Ação do Valdo**: `OPS_ALERT_EMAIL` no `.env` vivo antes da produção (Onda 4/F3). **Próximo: Onda 3** (política de
  senha, API + app juntos — §P.5 item 2), com o "sim" do Valdo.

### P.13 Onda 3 — política de senha em worktree (2026-11-05; Valdo: "Sim, começar"; NADA publicado)

- **Onde**: `D:\Gestao2027\onda3\{setes-api, setes-app}` (branches `onda3`, a partir dos `main` aec9911 / b9f1f2a) + irmãs destacadas
  `onda3\{fiscal-api, nfse-api, sql}` só para as cercas (junções `node_modules/fiscal-api` em setes-api e nfse-api — APAGAR antes de remover).
  Commits LOCAIS: setes-api **3e54300** + **3a4cdb5** · setes-app **e7119c6**.
- **O que entrou**: peça `@shared/auth/password-policy` (mínimo 8, máximo 100, só espaços recusado — absorve o `newPasswordSchema` da
  D-EA13, que vira reexportação —, lista de comuns sem caixa, parte local do e-mail de 4+ caracteres sem caixa e sem acento por TABELA
  explícita, não NFD); `refinePassword` no objeto (users POST/PUT, admin do onboarding — `fields[]` no campo da senha); troca pelo código:
  o que não depende da conta vem ANTES do código (400 `newPassword`), a "igual à atual" só DEPOIS do código certo e sob a trava (422
  `PASSWORD_SAME_AS_CURRENT`, o código NÃO é gasto nem conta erro — PP5); boot recusa subir sem a lista (`assertPasswordPolicyReady`);
  Swagger. App: espelho `PasswordPolicy` em `setes_validators` (lê o VETOR `password-policy.vector.json` do setes-api ao lado e confere a
  lista entrada por entrada), `SetesValidators.password`, `RegisterField.formValidator` (regra que olha outro campo — sobrevive à
  `applyFieldConfig`), as 4 telas com a regra no campo (dica `forms.validation.password.hint`), i18n pt (= texto da API) e en; chaves
  antigas de "mínimo 5" removidas.
- **Provas**: suíte setes-api 172/172 (3063 verdes) — testes antigos com senha de 5–6 caracteres atualizados (o mínimo mudou de propósito);
  app: web 662, core 80, setes_validators 130; `tsc` e `flutter analyze` limpos. PA5 (peso no build web): a cópia Dart tem 34 KB de fonte —
  não medido no build.
- **Gates (2026-11-05)**: socrático **0,80 ✅** (7 LOW + 3 INFO) · adversarial **0,82 ✅** (8 LOW, 11 resistências; arquivo
  `src/__tests__/adversarial-onda3-gate.test.ts`). **PP5 RESISTIU** (a "igual à atual" não é oráculo sem o código). **CORRIGIDOS na sessão**
  (cabem nas regras decididas): "branco" por lista EXPLÍCITA igual nas duas pontas (o `trim()` do JS não apara U+0085 e o do Dart apara —
  oito NEL passavam na API); marcas combinantes U+0300–U+036F retiradas depois do `toLowerCase()` na lista E na regra do e-mail ("İLOVEYOU"
  passava na API e caía no app; acento em NFD escapava da D-EA16 nas duas pontas); BOM no início da lista; `newPassword` não-texto = 400
  como o login (A-EA8 — `{}` virava "[object Object]"); UMA pendência por campo no DTO; o boot confere a contagem do cabeçalho do gerador
  (lista truncada ou trocada não sobe); aviso MIT INTEIRO nas duas cópias; o sorteio da senha do Super passa pela peça; a tela de troca
  julga com o MESMO e-mail que o app envia. Casos novos no VETOR (as duas suítes os cumprem).
- **Questões (uma por vez, ao Valdo)**: Q-EA37 rastro no log da recusa "igual à atual" (quem tem o código pode testar ~10 palpites da
  senha atual sem barulho) · Q-EA38 a lista compara a senha APARADA (" 12345678" e "password " passam hoje) · Q-EA39 recusar caractere de
  controle/invisível e surrogate solto (o MD5 iguala surrogates soltos a U+FFFD) · Q-EA40 troca pelo código julga o e-mail DIGITADO (`ılda@`
  acha a conta `ilda@` pela colação e deixa gravar "ilda2026") · Q-EA41 o campo do erro na troca fica `newPassword` (nome do corpo) ou
  `password` (letra do PP1) · Q-EA42 no PUT de conta COM credencial a política fala antes do 409 `PASSWORD_OWNER_ONLY`.
- **Conhecimento negativo**: no PowerShell 5.1, `Set-Content -Encoding utf8` grava BOM e a crase de texto entre aspas duplas é ESCAPE
  (`` `n ``/`` `r ``/`` `f `` viram controle) — editar código por `Edit`/node, nunca por substituição em string do PS.
