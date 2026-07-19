# Prompt FECHADO — Parceria v2 (angariação) + Guardião Conceitual

**Origem**: rascunho do Valdo `Infra-IA/prompts/Parceria.md` (2026-07-19),
refinado em 1 rodada de decisões e IMPLEMENTADO no mesmo dia.
**Contexto**: o trio tb_partnership/_customer/_partner (Onda 3 do Módulo
Software House) ficou "engessado" — parecido com um sistema anterior.

## Conceito

A parceria NÃO nasce pela criação de um registro. Ela nasce da
**ANGARIAÇÃO**: um colaborador trouxe um cliente para a empresa;
verifica-se quantos colaboradores atendem o cliente e combina-se um
percentual para cada um, conforme a interação. A parceria É do cliente.

## Decisões (D1–D7 — Valdo, 2026-07-19)

| # | Decisão |
|---|---|
| D1 | ✅ `tb_partnership` FLAT com PK natural `(tb_institution_id, tb_customer_id, tb_collaborator_id)` |
| D2 | ✅ SEM nome/descrição de parceria (histórico vive nos títulos — D11 do módulo) |
| D3 | ✅ Acesso pela ABA **Parceria** da tela de CLIENTE; módulo standalone `partnerships` APOSENTADO (API + tela) |
| D4 | ✅ Interface 18 'partnerships' vira `kind 'R'` — recurso VENDÁVEL que gateia a aba (Framework de Configurações, decisão 13) |
| D5 | ✅ Σ dos percentuais ≤ 90 permanece (10% da Setes fixos) — DTO + service + total ao vivo na aba |
| D6 | ✅ Migração: trio → linhas flat (migration 016) e DROP das 3 legadas |
| D7 | ✅ `active char(1)` — suspende o parceiro sem excluir a linha (suspenso NÃO entra no rateio da baixa) |

**Consequência estrutural**: a regra "cliente só em 1 parceria viva"
(guarda criada na Onda 3) MORREU POR CONSTRUÇÃO — evidência de que o
conceito novo é o certo (ver teste da maquete no guardião conceitual).

## Implementação (2026-07-19)

- **Banco**: migration `016_partnership_flat.sql` (conversão + FKs
  compostas p/ tb_customer/tb_collaborator locais) + `sql/03` canônico +
  seed `sql/20` (interface 18 kind R; flag 'partnerships' desativada —
  a API da aba vive sob a flag 'customers'; catálogo de campos realinhado).
- **API**: `GET/PUT /api/customers/:id/partnership` (sync por colaborador,
  Σ ativos ≤ 90, papéis validados na transação, lista vazia remove;
  respeita o filtro de carteira do fetchCustomer); módulo `partnerships`
  removido (gateway + defaultModules). `settlements` lê a flat (só
  `active='S'` entra no rateio das ordens PA).
- **App**: aba Parceria no customer_register (CRUD autônomo na edição,
  molde das abas Interfaces/Usuários); módulo standalone removido.
- **Smoke E2E**: aba grava 40% → baixa de 70 gera PA de 28 (venc +12d) →
  estorno compensa (PA+C) → parceiro suspenso não gera PA → soma>90 400.

## Guardião Conceitual (resultado esperado 2 do rascunho)

O pensamento "peças de lego / nuvem" virou artefato permanente:

- **Skill** `Infra-IA/skills-genericas/guardiao-conceitual.md` —
  OBRIGATÓRIA antes de criar/alterar objetos de domínio (CLAUDE.md item 2):
  princípio + teste da maquete + checklist de conceito + INVENTÁRIO das
  peças existentes + checklist de nomenclatura.
- **Agente** `setes-conceito` (`.claude/agents/setes-conceito.md`) — entra
  na orquestração para modelar conceitos novos em peças e devolver parecer
  (conceito · peça/composição · reuso · nomes · decisões p/ o Valdo).
