# 04 — Autenticação Multi-Institution

**Status**: ✅ Implementado e testado (2026-07-04)
**Módulo**: `setes-api/src/modules/auth/` (repository, service, routes)
**Especificação completa**: `prompt_fase2_gerenciamento_central.md` (decisões 8, 10, 14, 16–19)
**Testes**: `src/__tests__/auth-login.test.ts` (11 testes)

---

## Conceito

Todo tenant é uma **institution** (`tb_institution`, id int). Login único em `setes_central` para Setes e clientes. Um usuário pode pertencer a N institutions com perfis diferentes em cada uma (`tb_institution_has_user.kind`).

## Endpoints

| Endpoint | Auth | Função |
|---|---|---|
| `POST /auth/login` | pública (rate limit por IP) | email+senha → JWT final (1 institution) ou lista+token de seleção (N) |
| `POST /auth/select-institution` | Bearer token de seleção | valida vínculo no banco → JWT final |
| `POST /auth/switch-institution` | Bearer JWT final | troca de empresa sem redigitar senha |

## Fluxo do login

1. MD5 da senha aplicado **no backend**; busca por email do grupo 2 (`sistema`)
2. Busca institutions ativas do usuário (`tb_institution_has_user` × `tb_institution`)
3. Decisão:
   - **0** → `403` (sem licença ativa)
   - **1** → JWT final direto
   - **N** → `200` com lista + token de seleção (`scope: 'select-institution'`, TTL 5 min, sem `institutionId` — não passa no auth.middleware)
4. Seleção/troca **sempre revalida o vínculo no banco** — nunca confia no body

## JWT final

```json
{ "institutionId": 1, "userId": 1, "role": "super", "schemaName": "setes_setes" }
```

- TTL **24h**, sem refresh token (decisão 19; refresh fica para o setes-app mobile)
- `role` = `kind` do vínculo; **`'super'` fora da institution 1 é rebaixado para `'user'`** (decisão 14, hard coded em `@shared/auth/roles.ts` → `SETES_INSTITUTION_ID = 1`, `isSuper()`)

## Integração com o gateway

- `req.institution: InstitutionPayload` (era `req.tenant`/`TenantPayload` — eliminado)
- `feature-flag.middleware`: bypass via `isSuper()`; institution 1 tem todos os módulos
- `rate-limit`: chave = `institutionId`
- Admin (`/api/admin/institutions`): guard `isSuper()`; onboarding cria `tb_entity`+`tb_institution` em transação (IDs MAX+1) + flags default + migrations

## Teste rápido (após rodar sql/01 e 02)

```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"valdo@setes.com.br","password":"12345"}'
# → { ok: true, token: "<JWT super/setes_setes>" }
```

⚠️ Senha do seed é `12345` (MD5) — trocar em qualquer ambiente exposto.
