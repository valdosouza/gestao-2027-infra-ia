# Prompt — Endurecer a autenticação do setes-api (login, senha, sessão)

**Status**: Rodada 0 ORGANIZADA (2026-10-21) — inventário, riscos, proposta em ondas e questões **Q-EA1…Q-EA12** aguardando o Valdo.
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
| 5 | guarda `authMiddleware` (iat × updated_at, cache) · `ErrorCodes.SESSION_REVOKED` · app refaz login | com a onda 0 do convidado (D-UC9) |

## Decisões arquiteturais registradas

(nenhuma ainda — a numeração **D-EA1…** começa na Rodada 1)

## ⚠️ Questões pendentes (Rodada 0) — uma por vez, com recomendação

- **Q-EA1 — limite por conta no login: valores.** Problema: sem teto por conta, 18 000 palpites/h por IP. Opções: (a) **10 erradas em 15
  min → bloqueio até a mais velha envelhecer (janela deslizante de 15 min)**; (b) 5 em 15 min (mais rígido; mais chamados de suporte);
  (c) bloqueio progressivo (15 min, 1 h, 24 h). **Rec.: (a)** — dez erradas não acontecem por engano de digitação, e a janela deslizante
  dispensa "desbloquear" (o admin não precisa de botão; o super bloqueado espera 15 min ou usa o D-PV46). Resposta SEMPRE a mesma 401.
- **Q-EA2 — onde mora o fato da falha.** Opções: (a) **tabela filha `tb_user_login_failure` (só falhas, append-only, PK por usuário +
  seq, sob a trava da linha de `tb_user` — regras 12/13)**; (b) colunas `failed_logins`/`locked_until` em `tb_user` (ALTER na tabela do
  login + estado em vez de fato — o gate da Q-PV38 reprovou o molde); (c) tabela de TODAS as tentativas (sucesso incluído — 1 linha por
  login, milhões/ano, sem política de retenção possível com o §3.1). **Rec.: (a)**, nome final pelo guardião ANTES do DDL.
- **Q-EA3 — aviso ao dono ao bloquear.** Opções: (a) **`kind` novo 'L' (login bloqueado) na `tb_user_password_reset_notice`**, com a
  coalescência 1/h já existente — mas a tabela se chama "reset": o nome passaria a mentir; (b) tabela irmã própria `tb_user_login_notice`
  (mesmo molde); (c) sem aviso. **Rec.: (b)** — o guardião da D-RS4 nomeou pela consequência (o PROCESSO de recuperação); bloqueio de
  login é outro processo; o custo é uma tabela igual à irmã. Texto neutro: "tentativas de acesso não concluídas; se não foi você,
  troque a senha" (a troca pela recuperação é a saída certa — o atacante não conhece a senha).
- **Q-EA4 — teto global e alarme.** Opções: (a) **alarme quando > 100 falhas/min no processo OU > 30 contas distintas com falha em 5
  min; e-mail à operação 1 por 15 min; nunca bloqueia**; (b) alarme + bloqueio global do `/auth/login` por 1 min (auto-DoS); (c) só log.
  **Rec.: (a)**. Destinatário do e-mail: nova chave `.env` `OPS_ALERT_EMAIL` (vazia = só log; em produção obrigatória? — (a2) sim,
  junto do SMTP; Rec.: sim).
- **Q-EA5 — política de senha.** Opções: (a) **mínimo 8, sem classes obrigatórias, lista de senhas comuns, não conter o e-mail, não
  igual à atual; existentes valem até a próxima troca**; (b) mínimo 12 + classes (mais segura; usuários de PDV/balcão sofrem); (c) manter 5.
  **Rec.: (a)** — alinhada ao NIST e à realidade do balcão; a lista de comuns pega o que a composição não pega ("Senha@123").
- **Q-EA6 — oráculo "Usuário inativo" / "sem institution ativa".** Opções: (a) **a MESMA 401 "Email ou senha inválidos" para os dois** (o
  usuário inativo descobre com o admin — é a condição que a inativação quer impor); (b) manter as mensagens (UX) e aceitar a enumeração.
  **Rec.: (a)**; o log interno guarda o motivo real (forense).
- **Q-EA7 — revogação de sessão.** Opções: (a) **`iat` do token × `tb_user.updated_at` (fato que já muda só com senha/active), lido com
  cache de 60 s na guarda, junto da conferência do vínculo da D-UC9**; (b) tabela `tb_user_session` (1 linha por login, revogação
  explícita, "sair de todos os aparelhos") — mais poder, mais linhas, mais DDL; (c) nada (manter o limite). **Rec.: (a)** agora — zero
  DDL, zero mudança no app além de tratar `SESSION_REVOKED` como 401; (b) fica para quando houver pedido de "sair de todos os aparelhos".
  ⚠️ Confirmar que NENHUM escritor toca `tb_user.updated_at` por outro motivo (hoje: `updatePassword`, `updateUserCascade`, D-PV46,
  sql/67 não — conferir o setes-sync na onda, por leitura: `/user/sincronize` cria, não atualiza).
- **Q-EA8 — TTL do JWT.** Opções: (a) **manter 24 h (decisão 19) — com a revogação da Q-EA7 o risco do token longo cai**; (b) 8 h sem
  refresh (relogin no meio do expediente); (c) 1 h + refresh token (mexe no app e cria outro segredo). **Rec.: (a)**.
- **Q-EA9 — hash da senha (revê a decisão 2 da Fase 2 — reservada ao Valdo).** Opções: (a) **scrypt do Node com migração TRANSPARENTE
  no login (MD5 legado aceito e regravado)**; (b) bcrypt/argon2 (dependência nativa nova — pesa no deploy); (c) manter MD5 (risco
  aceito em 2026-07, quando a Setes era o único cliente). **Rec.: (a)** — sem dependência, sem janela, sem pedir troca a ninguém; o
  único efeito visível é o código de recuperação aberto morrer no 1º login depois do deploy (≤ 15 min, avisar no roteiro).
- **Q-EA10 — ordem e corte.** Opções: (a) **Ondas 1+2 primeiro (porta pública), depois 3, 4 e 5; cada uma com gates e "vai"; todas
  depois do merge da `recuperacao-senha` e ANTES da Onda 4 do deploy (o servidor público nasce endurecido)**; (b) tudo numa janela só
  (mais risco, menos merges). **Rec.: (a)**.
- **Q-EA11 — log de falhas de login (forense).** Opções: (a) **linha de log por falha com e-mail MASCARADO + IP + motivo interno, sem
  senha** e sem gravar no banco (o fato durável é a `_failure` da Q-EA2); (b) também em tabela de auditoria central. **Rec.: (a)**.
- **Q-EA12 — `Auth OK` em toda requisição.** O `authMiddleware` loga institution + path a cada chamada autenticada (volume no log de
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
