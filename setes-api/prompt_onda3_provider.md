# Prompt — Entidade Única Onda 3: Cadastro de Fornecedor (Provider)

**Status**: FECHADO — Rodada 1 decidida pelo Valdo em 2026-08-03 (D1–D3); em implementação
**Escopo**: setes
**Origem**: retomada do projeto 2026-08-03 (pendência da decisão 8 da Fase 3 —
"papéis provider, collaborator, bank"; collaborator saiu na onda de 2026-07-18,
salesman/carrier na Onda 2 de 2026-08-03; provider agora; bank continua fora)
**Método**: `Infra-IA/skills-genericas/refinar-prompt-arquitetura.md`

## Contexto

- **Legado**: `tblProvider.pas` (sincronizador/destiny) prova que o papel NÃO tem
  campo próprio — só `id`, `tb_institution_id`, `active`, auditoria. O
  fornecedor legado é a cadeia fiscal + o papel "flag".
- **Sync já grava**: `setes-sync /provider/sincronize` (Onda 4 da revisão) usa o
  motor de reindexação e faz upsert em `tb_provider` com `{active, deleted}` —
  o cadastro web precisa conviver com linhas nascidas do sync.
- **Molde pronto**: Onda 2 acabou de entregar o carrier (cadeia fiscal completa
  + aba Tributação com a peça `shared/entity-tax` promovida no app). Provider é
  o MESMO desenho — parecer conceitual abaixo.
- **Achado estrutural (⚠️ → Q2)**: `tb_provider` NÃO está no `sql/03` canônico —
  existe só no `001_baseline.sql` (PK composta correta, `active` default 'N',
  SEM FK para `setes_central.tb_entity`). Ficou fora do realinhamento da
  migration 005 (Fase 3) porque nenhuma tela a consumia.

## Parecer conceitual (guardião — peças de lego)

- **Conceito único**: o que a entidade É para a institution no papel de
  fornecedor (peça "papel local" do inventário — nada novo).
- **Composição**: cadastro = cadeia de entidade fiscal (peça) + papel (peça) +
  tributação (peça) — zero conceito novo, zero coluna nova.
- **Nomes**: módulo `providers` (/api/providers × /home/providers), interface
  i18n_key `providers`, grupo Registers. Nenhuma divergência.

## Objetivos

1. Módulo `providers` na setes-api (6 arquivos, molde carriers): lista paginada,
   GET :id com cadeia + tax, POST/PUT cascade em transação (reuso por documento,
   409 DUP_ROLE com id, revive), DELETE soft.
2. Módulo `providers` no app (molde carriers): 6 abas (5 compartilhadas +
   ProviderTab com active), prefill by-document, paginação e engrenagem de
   nascença, i18n pt/en.
3. DDL: `tb_provider` entra no `sql/03` canônico + migration de realinhamento
   (conforme Q2).
4. Seed sql/24: interface 24 'providers' (Registers) + contrato Setes + gate
   técnico + page_size; flag em `insertDefaultFlags`.
5. Testes jest (molde salesmen-carriers.test.ts) + Swagger + skills conferidas.

## Decisões arquiteturais registradas (Valdo, 2026-08-03)

1. **D1 — Fornecedor ganha a aba Tributação**: mesma peça `shared/entity-tax`
   do customer/carrier, salva na transação do papel (fornecedor é quem emite
   nota contra a institution).
2. **D2 — tb_provider alinhada ao padrão dos irmãos**: bloco canônico no
   sql/03 + migration 022 (FK `id → setes_central.tb_entity` + FK institution
   cross-schema + `active` default 'S'), padrão das migrations 005/008/009.
   Seguro porque pós-revisão do sync todo id gravado já é entity.id e não há
   cliente implantado.
3. **D3 — `active` default 'S' no cadastro manual** (o sync continua enviando
   explícito; o default do DDL acompanha).

## Questões pendentes

**Nenhuma.** Rodada 1 decidida em bloco pelo Valdo (2026-08-03).

## Fora de escopo desta onda

- Papel **bank** (cadastro próprio — última pendência da decisão 8 da Fase 3).
  **RESOLVIDA em 2026-08-04**: bank NÃO é papel — cadastro geral do catálogo
  central (decisão do Valdo, alinhada à DP2); módulo `banks` (Super) entregue
  (interface 25, seed sql/25). Decisão 8 encerrada.
- Processo de **compras** (order-purchase na web) — o papel nasce para ele, mas
  o processo é fase própria
- Lookup de fornecedor em telas de terceiros (entra quando o consumidor existir)

## Notas da implementação — API (2026-08-03)

- **Módulo providers** (6 arquivos, clone do carriers): lista paginada com
  COUNT na mesma where, GET :id = cadeia + active + tax, POST/PUT cascade em
  transação (reuso por documento; 409 DUP_ROLE com id em fields[0]; revive de
  papel soft-deletado — inclusive linha nascida do sync; tax undefined = não
  tocar), DELETE soft. Swagger completo.
- **DDL (D2/D3)**: bloco canônico `tb_provider` no sql/03 (após tb_carrier) +
  migration `022_provider_realign.sql` (FK id→tb_entity + FK institution
  cross-schema + active default 'S'; baseline não tinha FK — nada a dropar).
  APLICADA em dev (setes_setes + setes_pipoteca).
- **Gateway/flags**: /api/providers sem superGuard; 'providers' no
  insertDefaultFlags.
- **Seeds**: sql/24 (interface 24 'providers' Registers + contrato Setes +
  gate técnico + page_size) APLICADO em dev; chave 'providers' na lista
  canônica do seed 22.
- **Testes**: providers.test.ts (7 casos — cascade com tax na transação, tax
  omitido não toca, DUP_ROLE, revive, CONFLICT_RETRY, 404). Suíte 160/160;
  tsc limpo.

## Notas da implementação — App (2026-08-03, agente setes-form-builder)

- **Módulo providers** (15 arquivos): espelho exato do carriers — 6 abas
  (Principal/Endereços/Fones/Redes/ProviderTab com active/EntityTaxTab — D1);
  `ObjectProvider extends ObjectEntityFiscal`; draft inteiro no bloc; prefill
  by-document só na criação; reused=true → SnackBar; 409 DUP_ROLE → decisão
  tipada "Abrir cadastro" (id de fields[0]); PendencyFields ancorando
  fields[] do servidor na aba certa; paginação da fábrica + engrenagem
  condicional (configModuleKey 'providers').
- Rotas em interface_routes.dart ('providers' → /home/providers/) e
  home_module.dart; i18n pt/en (menu.interfaces.providers "Fornecedores",
  forms.provider.*).
- `lookup.providers` NÃO criada — lookup de fornecedor em telas de terceiros
  fica para quando o consumidor (compras) existir.
- `flutter analyze` limpo (verificado também fora do agente).

## Critérios de sucesso

1. POST com CNPJ já conhecido reusa a entity (`reused=true`); papel duplicado →
   409 DUP_ROLE com id; linha do sync (deleted='S') revive pelo cadastro.
2. GET :id devolve cadeia completa (+ tax conforme Q1).
3. Lista paginada com envelope `{ok,data,page,pageSize,total}`; engrenagem
   condicional funcionando.
4. Suíte jest completa verde + tsc limpo + flutter analyze limpo.
5. Seed aplicado em dev; interface no menu (grupo Cadastros).
