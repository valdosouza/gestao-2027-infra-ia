# Padrões de Banco de Dados — Setes (Gestão 2027)

**Versão**: 1.0
**Origem**: 21 decisões arquiteturais da Fase 2 (Gerenciamento Central), registradas em `setes-api/prompt_fase2_gerenciamento_central.md`
**Scripts canônicos**: `D:\Gestao2027\sql\01..05_*.sql`

Este documento é a **referência permanente** para criar qualquer tabela nova. Toda DDL nova deve passar pela skill `database/skills/revisar-ddl.md` antes de executar.

---

## 1. Nomenclatura

- Toda tabela inicia com `tb_`, nomes em inglês, singular (`tb_customer`, não `tb_customers`)
- FK: coluna = nome da tabela referenciada + `_id` (`tb_linebusiness` → `tb_linebusiness_id`)
- Tabelas N:N: `tb_<a>_has_<b>` (`tb_entity_has_mailing`, `tb_institution_has_user`)
- Schemas de cliente: prefixo `setes_<nome>` (validação `/^setes_[a-z0-9_]+$/`); o schema da própria Setes é `setes_setes`

## 2. Herança por PK compartilhada (padrão central)

Tabelas-filhas de `tb_entity` usam `id` como **PK e FK ao mesmo tempo** para `tb_entity.id`:
`tb_company`, `tb_person`, `tb_user`, `tb_institution`, `tb_address`, `tb_phone`, `tb_social_media`, `tb_customer` e futuras.

- Foge deliberadamente do padrão `tb_entity_id` — decisão por similaridade/herança (ObjEntity → ObjEntityFiscal)
- Exceção: tabelas N:N mantêm o padrão `tb_<tabela>_id`
- Tabelas "lista por tipo" (endereço, telefone, rede social) usam PK composta (`id`, `kind`) — um registro por tipo

## 3. Colunas padrão em toda tabela

```sql
`created_at` datetime,
`updated_at` datetime,
`deleted`    char(1) NOT NULL DEFAULT 'N'
```

- Flags booleanas: `char(1)` com `'S'`/`'N'` (nunca `'Y'`, nunca boolean — exceção: `tb_feature_flag.enabled` boolean por compatibilidade com o flag.service)
- Datas: nunca `0000-00-00` (falha em modo estrito); seeds usam `NOW()` ou datas reais
- Defaults: `DEFAULT NULL` real, nunca a string `'NULL'`

## 4. IDs

- `int(11)`, **gerados pela aplicação** (`SELECT COALESCE(MAX(id),0)+1 ... FOR UPDATE` dentro de transação)
- **Sem AUTO_INCREMENT** em nenhuma tabela

## 5. Separação setes_central × setes_<schema>

**Regra de ouro: as duas bases NUNCA têm as mesmas tabelas.**

| Vive em `setes_central` | Vive em `setes_<schema>` |
|---|---|
| Cadastro: `tb_entity`, `tb_company`, `tb_person`, `tb_address`, `tb_phone`, `tb_social_media`, `tb_mailing*` | Operacional do cliente: `tb_customer` e demais tabelas de movimento |
| Autenticação/licença: `tb_user`, `tb_institution`, `tb_institution_has_user`, `tb_sync_api_key`, `tb_feature_flag` | |
| UI/permissões: `tb_privilege`, `tb_interface`, `tb_interface_has_privilege` | |
| Referência geográfica: `tb_country`, `tb_state`, `tb_city` | |
| Referência fiscal: `tb_cfop`, `tb_ncm`, `tb_cest`, `tb_tax_*`, `tb_deter_base_*`, `tb_discharge_icms` | |

- FKs do schema do cliente para a central são **cross-schema explícitas**: `REFERENCES setes_central.tb_entity (id)`
- Script 04 (`sql/04_schema_cliente_cleanup.sql`) remove dos schemas o que foi centralizado

## 6. Autenticação e permissões

- `tb_user` controla **somente autenticação** (1 registro por entity; PK simples `id`)
- Senha: MD5 sem salt (decisão registrada; risco de rainbow table aceito), hash aplicado **no backend**, nunca na query
- Perfil do usuário: `tb_institution_has_user.kind` — **por institution** (o mesmo usuário pode ter poderes diferentes em cada empresa)
- `'super'` só vale na institution 1 (Setes) — hard coded no backend (`@shared/auth/roles.ts`)
- Licença do cliente: `tb_institution.active`
- Email de login: grupo 2 (`sistema`) em `tb_mailing_group`

## 7. JWT (setes-api)

```json
{ "institutionId": 1, "userId": 1, "role": "super", "schemaName": "setes_setes" }
```

- `institutionId` int (nunca `tenantId` string — nomenclatura antiga eliminada)
- TTL 24h, sem refresh token (relogin diário; refresh fica para o setes-app)
- Fluxo multi-institution: ver `setes-api/04-AUTH-MULTI-INSTITUTION.md`

## 8. Validação antes de executar

```bash
pip install sqlglot --break-system-packages
python3 -c "import sqlglot; sqlglot.parse(open('arquivo.sql').read(), read='mysql'); print('OK')"
```

E rodar o checklist completo: `database/skills/revisar-ddl.md`.
