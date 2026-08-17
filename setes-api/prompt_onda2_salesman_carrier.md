# Prompt — Entidade Única Onda 2: Cadastros de Vendedor (Salesman) e Transportadora (Carrier)

**Status**: FECHADO — Rodada 1 decidida pelo Valdo em 2026-08-03 (D1–D5); em implementação
**Escopo**: setes
**Origem**: pendência programada na decisão 11 da Fase 3
(`Infra-IA/setes-api/prompt_fase3_entidade_unica.md`) + decisão 16 do Framework de
Configurações (`Infra-IA/setes-app/prompt_framework_configuracoes_sistema.md`).
**Método**: `Infra-IA/skills-genericas/refinar-prompt-arquitetura.md`

---

## Contexto

- A Onda 2 foi programada na Fase 3 (decisão 11): telas de cadastro de Salesman e
  Carrier ficaram para depois, mas a DDL canônica e os lookups (salesman-lookup /
  carrier-lookup no módulo customers) entraram naquela fase.
- O cadastro de **Collaborator já foi entregue** (interface 12, seed sql/10, módulos
  simétricos api+app com a cadeia fiscal completa — molde da onda).
- As três tabelas existem no `sql/03`: `tb_collaborator`, `tb_salesman`
  (active default 'N', aliq_kickback, kickback_product, flex_value), `tb_carrier`
  (só active) — herança por PK: `tb_salesman.id = tb_collaborator.id = tb_entity.id`.
- Precedência (decisão 16 do config framework): colaborador pode ser só
  administrativo; TODO vendedor É colaborador. O comentário do DDL registra: a
  precedência será instituída NA APLICAÇÃO quando o cadastro de salesman nascer
  (FK física inviável agora — schemas com salesman sincronizado do legado).
- O filtro de carteira (config `restrict_customer_to_salesman`) já usa
  `tb_salesman` via session-context; o refino "só vendedor ATIVO" ficou pendente
  (decisão 15 do config framework).

## Parecer conceitual (guardião — peças de lego)

- **Conceito único de cada objeto**: papel local ("o que a entidade É para a
  institution") — peça já inventariada; NENHUMA tabela nova, zero DDL.
- **Salesman nasce de quê?** Da promoção de um colaborador (fato gerador: a
  institution decide que aquele colaborador vende). Não nasce de "criar um
  registro" solto — a pessoa já existe na cadeia.
- **Regra × construção**: a precedência Collaborator→Salesman pode ser validação
  (409) ou morrer POR CONSTRUÇÃO se o "novo vendedor" nascer de um lookup de
  colaboradores (Q1). O guardião recomenda a segunda.
- **Carrier**: papel completo de empresa externa — composição da cadeia fiscal no
  molde exato do customer/collaborator (reuso de entity por documento, 409 de
  papel duplicado devolvendo o id).
- **Peças reusadas**: `@shared/entity` (cadeia), `shared/entity-tax` (se Q2=sim),
  `shared/list` (paginação de nascença), `RegisterConfigButton`, fábrica
  Register* no app, abas compartilhadas `app/shared/entity`.

## Objetivos

1. **Cadastro de Carrier** — módulo simétrico `carriers` (API `/api/carriers` +
   app `/home/carriers`), cadeia fiscal completa, molde collaborator.
2. **Cadastro de Salesman** — módulo simétrico (nome conforme Q5), formato
   conforme Q1; campos do papel: active, aliq_kickback, kickback_product,
   flex_value.
3. **Precedência Collaborator→Salesman** instituída (Q1).
4. **Refino "vendedor ATIVO"** no session-context/carteira (Q3).
5. Entregáveis padrão: seeds (interfaces no grupo Registers + gate técnico +
   `fields:gen` + page_size no seed 22 + privilégios), Swagger nos *.routes.ts,
   i18n pt/en, testes API, `flutter analyze` limpo, listas nascendo paginadas.

## Decisões arquiteturais registradas (Valdo, 2026-08-03)

1. **D1 — Salesman é PROMOÇÃO de papel**: a lista mostra os vendedores; o "novo"
   abre o LOOKUP de colaboradores da institution; o form exibe a identificação do
   colaborador (readonly) + campos do papel editáveis (active, aliq_kickback,
   kickback_product, flex_value). A precedência Collaborator→Salesman morre POR
   CONSTRUÇÃO — não existe caminho para criar vendedor que não seja colaborador.
   Colaborador que já é vendedor → 409 de papel duplicado devolvendo o id
   (padrão da Fase 3); o app abre a edição.
2. **D2 — Carrier ganha a aba Tributação**: mesma peça `shared/entity-tax` do
   customer, salva na transação do papel.
3. **D3 — Refino "vendedor ATIVO" entra nesta onda**: `isSalesman`
   (session-context) e o filtro de carteira passam a exigir
   `tb_salesman.active='S'` além de `deleted='N'` — fecha a pendência da
   decisão 15 do Framework de Configurações.
4. **D4 — Desativar e excluir vendedor são LIVRES (somente soft-delete)**:
   nenhum bloqueio por carteira — `tb_customer.tb_salesman_id` permanece como
   histórico; o lookup deixa de oferecer o excluído; exclusão é sempre
   `deleted='S'` (nunca DELETE físico).
5. **D5 — Módulo do vendedor chama `salesmen`**: plural correto
   (/api/salesmen × /home/salesmen), padrão customers/collaborators/carriers.

## Questões pendentes

**Nenhuma.** Rodada 1 decidida em bloco pelo Valdo (2026-08-03).

## Notas da implementação — API (2026-08-03)

- **Módulo `carriers`** (6 arquivos, molde collaborators): cascade em transação
  única (cadeia + tb_carrier + `upsertEntityTax` quando `tax` vem no payload —
  D2); revive de papel soft-deletado; 409 DUP_ROLE com id; lista paginada.
- **Módulo `salesmen`** (6 arquivos): NÃO importa @shared/entity (D1 — o papel
  referencia a cadeia, nunca a edita). POST valida colaborador VIVO dentro da
  transação (404 se não for — por construção o app só oferece o lookup);
  `GET /api/salesmen/collaborator-lookup` (máx. 50, padrão roleLookup);
  GET :id devolve identificação readonly (nickTrade/nameCompany/document via
  COALESCE cpf/cnpj) + campos do papel. `active` default 'S' no cadastro
  manual — o default 'N' do DDL fica protegendo linhas nascidas do sync.
- **D3 aplicado em DOIS pontos**: `existsSalesman` (session-context) exige
  `active='S'`; e o `roleLookup` do customers (salesman-lookup/carrier-lookup)
  também só oferece papéis ATIVOS — vínculo histórico do cliente permanece (D4).
- **Gateway**: `/api/salesmen` e `/api/carriers` sem superGuard (privilégio da
  tela é do app); flags `salesmen`/`carriers` no `insertDefaultFlags` +
  seed 23 para institutions existentes.
- **Seeds**: `sql/23_salesmen_carriers_interface_seed.sql` (interfaces 22
  'salesmen' e 23 'carriers', grupo Registers; contrato Setes; gates técnicos;
  page_size das duas) + chaves novas na lista canônica do sql/22. Catálogo
  tb_interface_has_field NÃO faz parte do molde customers/collaborators —
  não criado (fields:gen fica disponível se o painel de campos precisar).
- **Testes**: `src/__tests__/salesmen-carriers.test.ts` (10 casos — promoção,
  404 sem colaborador, 409 DUP_ROLE, revive, soft delete D4, refino D3,
  service carriers). Suíte completa 153/153; tsc limpo. Seed 23 aplicado em dev.

## Notas da implementação — App (2026-08-03, agente setes-form-builder)

- **Tributação PROMOVIDA a peça shared** (regra de promoção — carriers é o 2º
  consumidor): `EntityTaxData` + domínios em
  `app/shared/entity/domain/entity_tax.dart` e `EntityTaxTab` em
  `app/shared/entity/widgets/entity_tax_tab.dart` (i18n neutro
  `forms.entityTax.*` — ex-`forms.customer.tax.*`, 28 chaves migradas).
  object_customer RE-EXPORTA a peça (consumidores intactos);
  customer_tax_tab.dart excluído.
- **Módulo carriers** (15 arquivos): molde collaborator com 6 abas — 5
  compartilhadas (Principal/Endereços/Fones/Redes/Tributação) + CarrierTab
  (checkbox active). Prefill by-document; reused=true → SnackBar; 409
  DUP_ROLE → decisão tipada "Abrir cadastro".
- **Módulo salesmen** (14 arquivos, D1): ObjectSalesman PLANO (sem cadeia).
  FAB da lista → showSetesLookup de colaboradores (collaborator-lookup no
  próprio SalesmanDatasource, padrão service_orders) → form da FÁBRICA com
  identificação readonly + aliqKickback (0–100)/flexValue (≥0) validados e
  kickbackProduct/active no DRAFT do bloc; 409 DUP_ROLE → abre a edição do
  id de fields[0].message.
- **Paginação de nascença** nos dois (PagedResult ponta a ponta; recuo de
  página vazia) + engrenagem condicional via configModuleKey.
- Rotas em interface_routes.dart + home_module.dart; i18n pt/en completos
  (menu.interfaces.salesmen/carriers, forms.carrier.*, forms.salesman.*).
- `flutter analyze` limpo (verificado também fora do agente).

## Decisões herdadas (não reabrir)

- Fase 3: reuso de entity por documento dentro da transação; 409 de papel
  duplicado devolve o id; personType 'N' via tb_no_doc; app nunca manda entityId.
- Decisão 16 (config framework): precedência Collaborator→Salesman.
- DDL canônica das 3 tabelas (sql/03) — sem alteração nesta onda.
- Padrões de entrega: módulo simétrico (ARQUITETURA_MODULOS_API.md ×
  ARQUITETURA_MODULOS.md), lista nasce paginada (envelope shared/list + seed 22),
  engrenagem condicional (RegisterConfigButton), Swagger na mesma entrega,
  i18n pt/en, campos configuráveis (fields:gen).

## Fora de escopo desta onda

- FK física `tb_salesman.id → tb_collaborator` (reavaliar na implantação — dados
  legados sincronizados inviabilizam agora; nota no DDL).
- Papéis provider e bank (fase própria, decisão 8 da Fase 3).
- Qualquer mudança em setes-sync/Sincronizador (regra dos dois grupos — o
  /carrier/sincronize do sync já existe e não é tocado por esta onda).

## Critérios de sucesso

1. Criar transportadora nova reusa entity por CNPJ/CPF (reused:true) e 409 de
   papel duplicado devolve o id.
2. Criar vendedor só é possível a partir de colaborador existente (por construção
   ou 409, conforme Q1).
3. Lookups do customer passam a listar os papéis criados pelas telas novas.
4. Listas novas nascem paginadas (envelope + barra + page_size persistido).
5. Engrenagem só aparece nas telas novas se houver config no catálogo.
6. Testes API verdes (suite completa) + flutter analyze limpo.
