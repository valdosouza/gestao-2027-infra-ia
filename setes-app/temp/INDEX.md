# setes-app — Índice (espelho de conhecimento)

**Status**: ⏳ Projeto futuro — pasta criada para manter a simetria projetos × Infra-IA
**Projeto**: `D:\Gestao2027\setes-app` (Flutter Web e Android)
**Atende**: usuário final, consumindo `setes-api` (`/auth/*` e `/api/*` com JWT)

---

## O que já está decidido (herdado da Fase 2 do setes-api)

- Login multi-institution: `POST /auth/login` → 1 institution = JWT direto; N = tela "Escolha a empresa" + `/auth/select-institution`
- JWT: `{ institutionId, userId, role, schemaName }`, TTL 24h
- Decisões adiadas PARA este projeto: institution padrão (pular tela de escolha), refresh token (mobile), perfis padronizados/tb_profile
- Stack registrada no rascunho original: Flutter 3.41+, Dart 3.11+, Kotlin 2.1.0, AGP 8.8, Gradle 8.10.2, compileSdk 36 (confirmar na largada)

## Referências

- Decisões vigentes: `../setes-api/prompt_fase2_gerenciamento_central.md`
- Fluxo de auth que o app consome: `../setes-api/04-AUTH-MULTI-INSTITUTION.md`
- Onde criar docs/skills deste projeto: `../ORGANIZACAO_PASTAS.md`
