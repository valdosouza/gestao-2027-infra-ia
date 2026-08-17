# setes-app — Índice (espelho de conhecimento)

**Status**: 🔨 Fase 1 em implementação — backend PRONTO (endpoints + migration 003); esqueleto do monorepo Flutter CRIADO (2026-07-05, ver `D:\Gestao2027\setes-app\README.md`)
**Projeto**: `D:\Gestao2027\setes-app` (Flutter — monorepo: packages/core, packages/setes_widgets, apps/web)
**Atende**: usuário final, consumindo `setes-api` (`/auth/*` e `/api/*` com JWT)
**Escopo**: setes

---

## Comece aqui

- **`prompt_fase1_fundacao.md`** — prompt executável da Fase 1 (23 decisões registradas, fechado em 2026-07-05)
  - Escopo: monorepo, design system `Setes*`, i18n (easy_localization + `tb_user_has_preference`), tema por institution (`tb_institution_theme`), responsividade weberpsetes, auth multi-institution, shell web com menus via `GET /api/core/menus`, módulos Super e Sistema, fábrica de cadastros por composição + genéricos
  - Fora de escopo: apps Android (`budget_sales`, `stock_count`, `budget_autocenter`, `erp_authorization`), iOS, refresh token
- **`prompt_fase2_campos_configuraveis.md`** — Fase 2: framework de campos configuráveis + validação de cadastros (22 decisões, fechado em 2026-07-12)
  - Escopo: catálogo `tb_interface_has_field` (central) × `tb_institution_has_field` (schema do cliente — required/caption/mask, cliente só aperta o baseline técnico); painel Sistema/Admin (vitrine de todas as interfaces); engine custom→catálogo na fábrica de cadastros; package `setes_validators` (app) espelhando `src/shared/validation/` (API); erro por campo `{error, fields[]}`; duplicidade CPF/CNPJ ao sair do campo + 409 no salvar; piloto nas 5 telas existentes
  - Tool pronta: `setes-api/scripts/gerar-interface-fields.ts` (`npm run fields:gen`) — gera seed do catálogo via information_schema

## Decisões-chave (detalhe no prompt)

- Dois níveis de autorização: `tb_feature_flag` = gate técnico de módulos da API (mantida); `tb_institution_has_interface` = contrato comercial (decisão 17)
- Config do cliente no schema do cliente: `tb_module`, `tb_module_has_interface`, `tb_user_has_privilege`, `tb_institution_has_interface` em `setes_<schema>` (decisão 18)
- Super opera cross-schema recebendo `institutionId` alvo (decisão 23); `03_schema_cliente_ddl.sql` ganha as 4 tabelas novas
- Stack oficial: `temp/Agent_Context_App.md` (BLoC, flutter_modular v5, dartz; drift só nos apps Android)

## Como rodar em dev (portas nos .env — 2026-08-03)

- **setes-api**: porta em `setes-api/.env` (`PORT=...`; dotenv) → `npm run dev`
- **setes-app web**: `apps/web/.env` (`WEB_PORT` = porta do dev server; `API_URL` =
  endereço da setes-api, vira `AppConfig.baseApiUrl` via dart-define) → rodar
  `apps/web/run-dev.ps1` (lê o .env e monta `--web-port` + `--dart-define-from-file`).
  `.env.example` ao lado; nunca subir o flutter "na mão" com porta divergente do .env.

## Referências

- Stack/testes: `temp/Agent_Context_App.md` · Tema: `temp/THEME_EXAMPLE.md`
- Decisões vigentes da API: `../setes-api/prompt_fase2_gerenciamento_central.md`
- Fluxo de auth consumido: `../setes-api/04-AUTH-MULTI-INSTITUTION.md`
- Código de aprendizado: `../codigo-aprendizado/weberpsetes/` (responsividade, clean arch) e `../codigo-aprendizado/GestaoERPApps/core/` (core de referência)
- Rascunho de origem: `../HISTORICO/rascunho_setes_app_fase1_2026-07-05.txt`
