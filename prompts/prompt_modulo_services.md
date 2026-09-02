# Prompt — Módulo de Cadastro de Serviços (web)

**Escopo**: setes
**Estado**: EXECUTADO nos dois lados (2026-09-02) — rodadas 1–2 FECHADAS
(D1–D7). API: módulos `services` + `price-lists` (6 arquivos cada, kind='S'
fixo em INSERT/WHERE, identifier=id em branco, grade tb_price na transação,
lookups categoria/plano), router + flags default, 15 testes novos (463
total), swagger. App: módulos `services` (2 abas: Principal + Preços) e
`price_lists` (setes-form-builder, verificado: 29 arquivos, analyze limpo;
correção minha: i18n_key/rota `price-lists` com HÍFEN — convenção
/api ↔ /home). Seed sql/42 (interfaces 33/34 grupo Registers kind 'T',
contrato Setes, page_size, flags retroativas) aplicado em dev. Smoke E2E
12/12 (POST→GET→PUT→DELETE + ataques: mercadoria invisível via /services
404; FK 400 fields; grade duplicada 400; 401). Menu/lista/form validados no
Browser. GATES (2026-09-02): socrático 0.80 ✅ — pontos abertos: (1)
syncPrices soft-deleta o preço de TODAS as tabelas fora da grade, inclusive
de tabelas já soft-deletadas (histórico de tabela morta some no próximo
save — LOW, a grade só mostra vivas); (2) assertRefs faz 1 SELECT por linha
da grade (N pequeno — tabelas de preço são poucas); (3) MAX+1 da tb_product
é compartilhado com o futuro módulo products e com o sync — coberto pela D3
(liberação só sem legado). Adversarial 0.85 ✅ sem HIGH/CRITICAL — 12
ataques executados no dev (mercadoria invisível via /services nos 3 verbos;
FK inexistente 400 fields; grade duplicada 400; 401 sem token; ciclo
POST→GET→PUT→DELETE com identifier=id e remoção de preço por null); LOW:
DELETE de tabela de preço não checa uso (decisão: soft delete livre,
preços viram histórico). Commits: api 062922b · app 914e326 · sql 1b46b5f
· Infra-IA 8c5c4a5.
**Revisão estrutural (2026-09-02, pedido do Valdo)**: conformidade com
ARQUITETURA_MODULOS(_API).md e D1–D7 confirmada; 2 desvios de fronteira
corrigidos — (1) page consumindo o datasource PRINCIPAL do módulo para
lookups (presentation → data): extraído `service_lookup_datasource.dart`
(categoria/plano) e `cfop_lookup_datasource.dart` no tax_rules (o mesmo
desvio existia lá, meu) — regra reafirmada: page só toca lookup datasource
dedicado (padrão StateLookupDatasource), escrita passa por usecase/bloc;
(2) app services chamava /api/price-lists (endpoint do módulo vizinho):
criado GET /api/services/price-lists — módulo do app fala SÓ com o seu
/api/<m>.
**Origem**: pedido do Valdo ("veja como está na programação o cadastro de
serviço" → não existe produtor web); fase Faturamento Fiscal e Financeiro.

---

## Contexto (verificado no código, 2026-09-01)

- Serviço JÁ está modelado (D2, prompt_notas_mercadoria_servico.md,
  2026-07-26): `tb_product` com `kind='S'`; a natureza é por AUSÊNCIA de
  especialização (mercadoria P/M tem tb_merchandise + tb_price + tb_stock;
  serviço não tem nada além da linha da tb_product).
- NÃO existe módulo de cadastro de produto nem de serviço na web — nenhum
  INSERT em tb_product no setes-api. Serviço nasce só pelo setes-sync
  (/service/sincronize) ou SQL manual.
- Consumidores atuais (lookups kind='S', só leitura): contracts,
  service-orders, orders (ramo service); billing lê kind (ISSQN).
- tb_product: id, identifier varchar(50), tb_institution_id (PK
  id+institution), description, tb_category_id, tb_financial_plans_id,
  promotion, highlights, active, published, note, deleted.

## Parecer setes-conceito (resumo)

- **Conceito**: item do catálogo do cliente cuja natureza é serviço —
  nenhum conceito novo, nenhuma tabela nova, nenhum DDL.
- **Arquitetura**: peça `@shared/product` (transaction-aware, recebe kind;
  kind='S' nunca toca especialização — invariante POR CONSTRUÇÃO) +
  composição módulo `services` (API+app simétricos, tela lista+form que
  chama a peça com kind='S' fixo).
- **Não é maquete**: a regra "serviço não tem estoque/preço" morre por
  construção. Viraria maquete se o INSERT vivesse dentro do módulo — com a
  peça, o futuro módulo `products` (P/M) AGREGA (reusa @shared/product +
  acrescenta merchandise/price/stock) sem reformar `services`.
- **Analogia correta**: invoice-merchandise × invoice-service do sync (um
  conceito, dois canais por natureza) — NÃO salesmen/collaborators.
- **Peças reusadas**: tb_category (lookup árvore), tb_financial_plans
  (lookup árvore), MAX+1 FOR UPDATE, @shared/list paginado + escapeLike,
  fábrica Register* + lookups FK, campos configuráveis, interface nova no
  seed (kind 'T'), i18n pt/en.
- **Fora desta frente**: tb_service/coluna nova (natureza é kind, nunca
  tabela paralela); módulo products completo; preço no catálogo de serviço
  (valor vive no USO — contrato/OS/pedido); qualquer mudança no
  /service/sincronize (regra dos dois grupos).
- **Nomes**: módulo/URL/tela `services` (/api/services ↔ /home/services;
  não colide com service-orders); i18n forms.services.*; peça
  src/shared/product/.

## Rodada 1 — decisões (2026-09-01)

- **D1 (Q2 — identifier)**: campo ABERTO (editável) no form; se vier em
  branco, a API preenche com o próprio `id` na criação.
- **D2 (Q3)**: `published`/`promotion`/`highlights` EXPOSTOS no form.
- **D3 (Q4 — sync)**: SEM guarda de colisão de id — o form de
  serviço/produto só será LIBERADO para o cliente quando ele não usar
  mais o legado; enquanto usar, tudo vem do legado (liberação =
  contrato/interface, decisão comercial do Valdo, não código).
- **D4 (Q5 — preço)**: serviço TEM preço e segue a MESMA lógica do preço
  de mercadoria — `tb_price` por tabela de preço (`tb_price_list`)
  disponível. Verificado: tb_price ancora em tb_product_id (nível
  produto), então preço de serviço NÃO quebra o modelo D2 (a
  especialização de mercadoria é tb_merchandise/tb_stock, não o preço).
  Consequência: a peça de preço é COMPARTILHADA produto×serviço desde já.

## Rodada 2 — decisões (2026-09-01, rodada FECHADA)

- **D5 (Q1 metade 1 — arquitetura)**: apesar de ser a MESMA tabela
  (tb_product), a arquitetura segue CAMINHOS INDIVIDUAIS — mercadoria e
  serviço tratados separadamente. Ou seja: o módulo `services` tem seu
  próprio repository escrevendo tb_product com kind='S' FIXO (invariante
  do módulo); NÃO se cria peça @shared/product unificando os dois
  caminhos — quando o cadastro de produtos vier, ele terá o caminho dele.
  (parecer setes-conceito recomendava a peça; decisão do Valdo prevalece
  e fica registrada.)
- **D6 (Q1 metade 2)**: TELAS IRMÃS — "Serviços" hoje e "Produtos" no
  futuro como interfaces separadas no menu, cada uma vendável (kind 'T');
  nada é aposentado depois.
- **D7 (Q6)**: INCLUIR nesta frente o cadastro "Tabelas de Preço"
  (módulo price-lists: description, validity, modality, published) E a
  edição da tb_price pelo PRÓPRIO cadastro de serviço (grade de preços
  por tabela no form, salva na transação do serviço).

## Escopo executável (fechado)

1. API módulo `price-lists` (schema do cliente, PK id+institution,
   MAX+1, lista paginada) — tb_price_list.
2. API módulo `services` — tb_product kind='S' fixo: lista paginada
   (filtro kind='S'), POST/PUT com identifier = id quando em branco (D1),
   published/promotion/highlights no contrato (D2), grade prices[]
   (tb_price_list_id → price_tag) sincronizada na MESMA transação
   (presença = sincroniza).
3. App: módulos `price_lists` e `services` (fábrica Register*, lookups
   categoria/plano financeiro, grade de preços no form de serviço),
   i18n pt/en, interfaces novas no seed (id dinâmico), menu Cadastros.
4. Sem guarda de sync (D3 — liberação comercial por interface).
5. Testes + swagger + gates socrático/adversarial.
