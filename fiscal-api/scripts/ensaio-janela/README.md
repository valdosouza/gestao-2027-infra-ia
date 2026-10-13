# Ensaio da JANELA da F2a e passeio logado da F2b — instância descartável

**Escopo**: misto (o método — ensaiar o ato irreversível numa cópia isolada, com o mundo externo BLOQUEADO no processo — é portável;
portas, nomes de banco e hosts do fisco/banco são do caso Setes)
**Origem**: 4ª sessão de 2026-10-13 (`prompts/prompt_apis_fiscais_isoladas.md` §22.46) — o Valdo escolheu "Instância descartável" para o
passeio; o mesmo ambiente ensaiou os passos 3–5 do roteiro da janela (§22.13), inclusive o `--vai`, sem tocar a produção.

## Por que uma 2ª INSTÂNCIA (e não um schema descartável)

O SQL do setes-api fixa `setes_central.` em ~80 arquivos e o schema do cliente é `setes_setes`: uma cópia com outro NOME não funciona. A
cópia tem de ter os MESMOS nomes — logo, outro servidor MariaDB (mesmo binário do XAMPP, outra porta, outro datadir).

## Riscos que o kit fecha (todos achados na montagem)

| Risco | Fechamento |
|---|---|
| a cópia tem notas AUTORIZADAS em P e o A1 real — "Cancelar nota" numa delas iria ao fisco de PRODUÇÃO | `block-hosts.js` (preload via `NODE_OPTIONS=--require …`) recusa DNS/TCP/TLS para `sefin.nfse.gov.br`, `adn.nfse.gov.br` e o Inter de produção; a habilitação da cópia vai para **H** |
| `dotenv` lê o `.env` da worktree, que aponta para a PRODUÇÃO (3306) | as variáveis do passeio são exportadas ANTES (o `dotenv` não sobrescreve) e `probe.js` (`SELECT @@port, @@datadir`) roda antes de cada passo — nada com `--vai` sem a sonda dizer 3307 |
| o token do passeio valeria na produção (mesma chave) | `genkey.js` gera um par RS256 próprio; `JWT_KID=passeio` no setes-api e `JWT_PUBLIC_KEYS=passeio=…` na nfse-api |
| XML, cofre, SMTP do setes-api escreveriam/enviariam de verdade | `STORAGE_PATH`/`SECRETS_PATH` para pastas vazias do scratchpad; `SMTP_HOST=127.0.0.1 SMTP_PORT=1` |
| senha de produção na cópia | usuários `setes`/`fiscal_api` recriados na cópia com SENHAS NOVAS (o dump não leva `mysql.user`) |
| ver o que o navegador entrega num 502/504 do proxy (D-F181/D-F188) | `proxy.js` na frente de cada API devolve a página do nginx SEM CORS, por regex de caminho e N vezes (`proxy-mode.json`) |

## Receita (Git Bash; `S` = pasta de trabalho fora dos repositórios)

1. `mysql_install_db.exe --datadir=$S/data --port=3307 --password=<root novo>`; completar o `my.ini` com `bind-address=127.0.0.1`,
   `basedir`/`plugin_dir` do XAMPP e o `sql_mode`/charset/`innodb_lock_wait_timeout` da produção; subir `mysqld.exe
   --defaults-file=$S/data/my.ini --console` em segundo plano.
2. Usuários na cópia: `setes@'%'` (ALL *.* WITH GRANT — é o definer das views/gatilhos) e `fiscal_api@{localhost,127.0.0.1,::1,%}` com os
   GRANTs da produção (SELECT `setes_central`.*, ALL `fiscal_api`.*, SELECT `setes_%`.*).
3. `mysqldump --single-transaction --routines --triggers --events --databases setes_central setes_setes fiscal_api` da 3306 (só leitura)
   → restaurar na 3307.
4. Na cópia: `UPDATE … tb_establishment_issuer SET environment='H', dps_last_number=900` nos DOIS lados (ERP e `fiscal_api`).
5. Ambientes: `env-api.sh` (PORT 3010, DB 127.0.0.1:3307 `setes`, STORAGE/SECRETS/SMTP isolados, `JWT_PRIVATE_KEY_PATH` do passeio,
   `JWT_KID=passeio`, `CORS_ORIGIN=http://localhost:5052`) e `env-nfse.sh` (PORT 3012, DB 3307 `fiscal_api`, `JWT_PUBLIC_KEYS=passeio=…`,
   `STORAGE_PATH` isolado, `CORS_ORIGINS=http://localhost:5052`) + `PASSEIO_BLOCK_HOSTS` + `NODE_OPTIONS="--require <kit>/block-hosts.js"`.
6. Ensaio da janela (o roteiro do §22.13, na cópia): nfse-api `npm run db:migrate` → `npm run migrate:setes` → ensaio do ato (DB_USER =
   dono do ERP) → ensaio do aborto (worktree `f2a`) → subir o setes-api da worktree SEM watch (`npx tsx --require tsconfig-paths/register
   src/server.ts`) e ler o log → re-sincronia + contagens → ensaio sem bloqueio → PARAR o setes-api → `--vai` → subir de novo.
7. Passeio: nfse-api da cópia (:3012) sem watch; `node proxy.js` (:3011 → :3010, :3013 → :3012); `flutter build web
   --dart-define-from-file=<API_URL=http://localhost:3011, NFSE_API_URL=http://localhost:3013> -o $S/web` na worktree `f2b`;
   `node static.js $S/web` (:5052, no-cache); o Valdo digita a senha no navegador (o agente nunca).
8. Fim: parar os processos (conferir pela PORTA e pelo caminho da linha de comando que é a worktree/cópia — nunca o PID da produção) e
   apagar a pasta `S` (datadir incluído).

Resultado do ensaio de 2026-10-13: §22.46.3 do prompt (exit 0 + só o D-F50 antes do merge; aborto sem recusa; boot com a 069 e os 9
gatilhos; origem = réplica; `--vai` `committed: true`; produção conferida intacta depois).
