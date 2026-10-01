# Prompt — Onda: Pesquisa Avançada nas telas de pesquisa

**Escopo**: setes
**Origem**: rascunho do Valdo `prompts/PromptBuscaAvancada.txt` (2026-09-30) — "vamos tratar como uma onda separada"
**Estado**: **Onda 1 ENTREGUE + Rodada 2 + Q-BA16 + onda TZ-1 do fuso (gates 0.76/0.78 ✅) (2026-09-30)** — antes: **Onda 1 ENTREGUE (2026-09-30)** — D-BA1…D-BA11 (Valdo) + D-BA12…D-BA15 (assunção do guardião); pilotos
customers + service-orders nos dois lados; gates socrático 0.68 → **0.78 ✅** · adversarial 0.66 → **0.84 ✅**; API 1497/1497 ·
app 159/159 · smoke ao vivo 17/17 · Rodada 2 EXECUTADA (§9.3: D-BA16…D-BA19; **Q-BA16 aberta** — pedido de explicação) · fuso TZ-1 + Rodada 2 executados (§10–§10.4) · **PUBLICADO 2026-09-30** · pendem passeio logado e Q-TZ9
**Método**: `skills-genericas/refinar-prompt-arquitetura.md` · antes do DDL/peça: `skills-genericas/guardiao-conceitual.md`
**Relacionados**: `setes-app/prompt_paginacao_telas_pesquisa.md` (D1–D10 — o contrato de lista que esta onda estende),
`setes-app/prompt_framework_configuracoes_sistema.md` (cascata usuário → institution → default),
`setes-app/prompt_fase2_campos_configuraveis.md` (catálogo de campos por interface), skill `mensagem-e-validacao`

---

## 1. Contexto

O rascunho, fiel:

> Nas telas de pesquisa temos a lista com o resultado e um campo filtro, e isso está prejudicando o tempo para
> procurar algo mais específico.

O que o código mostra hoje (levantamento 2026-09-30):

- **API** — `@shared/list` (`parseListQuery`) lê UM texto livre `filter` + `page`/`pageSize` e devolve o envelope
  `{ok, data, page, pageSize, total}`. Cada repository decide sozinho onde o `filter` bate (ex.: customers:
  `nick_trade LIKE ? OR name_company LIKE ?`), com `escapeLike`. **34 módulos** consomem a peça.
- **App** — a fábrica `RegisterSearchPage<T>` (`apps/web/lib/app/shared/register/`) tem UM `SetesTextField` de
  filtro + lista + `RegisterPagingBar`. A linha é montada por `rowBuilder: List<String>` — **a fábrica não sabe
  quais campos o registro tem nem de que tipo são** (só recebe textos prontos). **28 telas** usam a fábrica;
  **10 não usam** (telas de processo: orders, service_orders, settlements, checks, bank_slips, cashier,
  order_returns; árvores: categories, financial_plans; home).
- **O filtro atual já é REMOTO** — a D7 da paginação aposentou o filtro em memória: ele busca na base inteira,
  não só na página carregada.
- Não existe hoje nenhum lugar que declare "estes são os campos pesquisáveis desta tela, com este tipo".

## 2. Objetivos

1. Adicionar ao framework das telas de pesquisa uma **pesquisa avançada**: um botão na tela abre vários
   critérios de busca, de acordo com os dados daquela tela.
2. **Backend**: o GET da lista passa a aceitar um conjunto de critérios estruturados (o rascunho diz "um json com
   vários parâmetros") — sem perder paginação, contagem nem os escopos de segurança.
3. **Frontend**: TODA tela de pesquisa (as atuais e as novas) ganha o botão; os critérios oferecidos são os da
   própria tela.
4. **Manter o filtro rápido** que já existe.
5. **Otimização**: o usuário escolhe quais critérios aparecem para ele.

## 3. Workflow proposto (para decidir nas questões)

```
Tela de pesquisa
  ├─ campo filtro rápido (como hoje)                         ← Q-BA6
  ├─ botão "Pesquisa avançada" (só aparece se o módulo declarou critérios)
  │     → painel/dialog com os critérios do módulo            ← Q-BA2/Q-BA3/Q-BA7
  │        (tipo decide o controle: texto, período, faixa de valor, lookup de FK, lista de opções, sim/não)
  │     → "Pesquisar": critérios viajam para a API junto com filter/page/pageSize   ← Q-BA1
  │     → volta à página 1; chips com os critérios ativos acima da lista + "limpar"
  └─ lista paginada (envelope de sempre; total conta com TODOS os critérios)

API
  parseListQuery lê filter + critérios
  → valida contra a LISTA BRANCA do módulo (critério desconhecido = 400; valor inválido = 422 com fields[])
  → cada critério vira predicado SQL parametrizado (a coluna vem SEMPRE do código, nunca do cliente)
  → mesma WHERE no SELECT e no COUNT (D2 da paginação) + escopos intocáveis (institution, carteira, soft delete)
```

**Invariantes (não são questão — são regra que já existe)**:
- critério NUNCA fura escopo: institution, carteira do vendedor (Framework de Configurações D15), soft delete;
- nome de coluna nunca vem do cliente — o cliente manda a CHAVE do critério; o código traduz;
- valor em placeholder, texto com `escapeLike`;
- erro no formato do Framework de Mensagens (`{error, code, fields[]}`, `expected` quando couber);
- "o que valida é o que grava": valor de dinheiro/data normalizado pela mesma peça que o cadastro usa
  (`@shared/money`, datas do `shared/validation`);
- conteúdo visível sem legado (i18n pt/en para todo rótulo de critério).

## 4. Especificação — peças candidatas (a confirmar pelo guardião após a Rodada 1)

| Peça | Lado | Papel |
|---|---|---|
| `@shared/list` estendido (`parseListQuery` + `criteria`) | API | ler, validar contra a lista branca e montar o WHERE |
| definição de critérios por módulo (`<m>.search.ts`?) | API | lista branca: chave → coluna/expressão SQL, tipo, operador, lookup |
| `GET /api/<m>/search-fields` (?) | API | expõe ao app os critérios do módulo (tipo, rótulo i18n, lookup) — Q-BA2 |
| `AdvancedSearchPanel` + chips | app `shared/register` | renderiza critérios por tipo; reusado pela fábrica E pelas telas de processo |
| `RegisterSearchPage` com `searchFields`/`onCriteriaChanged` | app | botão aparece quando há critérios |
| preferência do usuário (quais critérios aparecem) | ambos | Q-BA7 |

## 5. ⚠️ Questões pendentes (Rodada 1)

**Q-BA1 — Como os critérios viajam no GET**
Problema: o rascunho pede "GET que recebe um json". GET com corpo não é suportado de forma confiável (proxies e o
`http` do Flutter Web descartam). Opções:
(a) **mesmo endpoint da lista, critérios num parâmetro `criteria` = JSON codificado na URL**
(`/api/customers?filter=&page=1&criteria=%7B...%7D`) — mantém o endpoint, o envelope e a paginação;
(b) endpoint novo `POST /api/<m>/search` com corpo JSON — dois caminhos para a mesma lista;
(c) parâmetros planos (`city=12&createdFrom=2026-01-01`) — sem JSON, mas colide com nomes existentes.
Atenção comum a (a) e (c): CPF/CNPJ digitado no critério vai para a URL (log de acesso) — hoje o `filter` já vai.
*(Rec.: (a) — um endpoint só por lista, o `parseListQuery` ganha `criteria` e os 34 módulos não mudam de
contrato; teto de tamanho do parâmetro com 400 legível.)*

**Q-BA2 — Onde vive a lista de critérios de cada tela**
Problema: hoje nada declara "campos pesquisáveis" — o app só tem textos prontos (`rowBuilder`).
(a) **no código do módulo da API** (lista branca chave → SQL + tipo), exposta ao app por
`GET /api/<m>/search-fields` — uma fonte só, a mesma que valida;
(b) tabela central nova `tb_interface_has_search_field` (catálogo Super, molde do `tb_interface_has_field`)
+ tradução para SQL continua no código — duas fontes que precisam casar;
(c) reaproveitar `tb_interface_has_field` com uma coluna `searchable` — mas o catálogo de campos é do
FORMULÁRIO (campos da tabela), e a pesquisa precisa de coisas que não são campo do form (período de datas,
status derivado, "tem título em aberto").
*(Rec.: (a) — a ponte critério→coluna TEM que ser código (segurança), então a tabela só duplicaria; a
preferência do usuário (Q-BA7) é que mora em dado.)*

**Q-BA3 — Quais dados viram critério**
Problema: o rascunho diz "de acordo com os dados disponíveis na lista", mas a lista mostra só 2–3 textos
(ex.: cliente = nome + documento). Opções:
(a) só o que aparece na linha da lista;
(b) **os dados do registro que o usuário reconhece na tela (lista + formulário)**, curados por módulo
(cliente: cidade, estado, vendedor, PF/PJ, ativo, data de cadastro, documento; OS: período, status, cliente,
contrato, valor);
(c) todo campo da tabela.
*(Rec.: (b) — curado por módulo na definição da Q-BA2; (c) expõe coluna técnica e cria critério sem índice.)*

**Q-BA4 — Operadores**
(a) **o TIPO decide o operador, sem escolha do usuário**: texto = contém; número/valor/data = faixa (de…até);
FK = escolher um registro pelo lookup (`SetesLookupField`); domínio = uma ou mais opções; sim/não = switch;
(b) o usuário escolhe o operador (igual, contém, começa com, maior que…) — mais poder, tela bem mais pesada.
*(Rec.: (a) na 1ª onda; (b) vira questão futura se aparecer caso real.)*

**Q-BA5 — Como os critérios se combinam**
(a) **todos em E (AND)**; (b) permitir OU entre grupos.
*(Rec.: (a) — é o modelo mental de "mais específico" do rascunho.)*

**Q-BA6 — O filtro que já existe**
Problema: o rascunho diz "manter o filtro para os itens que já tem na lista que foi carregada". Hoje o filtro
NÃO é local: desde a D7 da paginação ele busca na base inteira (a lista carregada é só uma página de 25).
(a) **manter o filtro rápido exatamente como é (remoto) e somá-lo em E com os critérios avançados**;
(b) voltar a ter um filtro LOCAL sobre a página já carregada — desfaz a D7 e só enxerga a página visível.
*(Rec.: (a). Se a intenção era outra — ex.: "não perder o que já foi filtrado ao abrir a avançada" — a (a)
cobre: os critérios e o filtro sobrevivem juntos e aparecem como chips.)*

**Q-BA7 — Personalização (a "otimização" do rascunho)**
O usuário escolhe quais critérios aparecem (e a ordem). Onde guardar:
(a) **Framework de Configurações**: uma config por interface (ex.: `search_fields`, lista de chaves, scope U)
— herda de graça a cascata usuário → institution → default (o admin define o padrão do cliente, o usuário
ajusta o seu), como o `page_size` já faz;
(b) tabela própria de preferência de pesquisa.
Quando: junto na 1ª onda × onda seguinte.
*(Rec.: (a), e na onda SEGUINTE — primeiro provar critérios fixos por módulo; a personalização só esconde/ordena
o que o módulo já declara.)*

**Q-BA8 — Os critérios sobrevivem a quê**
(a) **como o filtro e a página hoje: salvar/excluir/voltar do formulário devolve à mesma pesquisa; sair da tela
limpa**; (b) persistir a última pesquisa por usuário; (c) pesquisas salvas com nome ("favoritas").
*(Rec.: (a); (c) fica em "fora de escopo" como candidata.)*

**Q-BA9 — Abrangência e ordem**
28 telas da fábrica + 10 fora dela. O rascunho pede "toda tela, nova e atual".
(a) **Onda 1 = peça nos dois lados + botão na fábrica (aparece só quando o módulo declara critérios) + pilotos
(Q-BA10); Onda 2 = as demais telas da fábrica, módulo a módulo; Onda 3 = telas de processo** (usam o mesmo
painel, fora da fábrica); árvores (categories, financial_plans) ficam fora, como na D6 da paginação;
(b) tudo de uma vez.
Regra para o futuro: tela/endpoint NOVO nasce com critérios declarados (entra nas skills `novo-modulo.md` e
`criar-formulario-cadastro.md`, como a paginação entrou).
*(Rec.: (a).)*

**Q-BA10 — Pilotos**
*(Rec.: `customers` (fábrica, maior variedade de tipos: texto, FK de cidade/vendedor, domínio PF/PJ, data,
e já tem o escopo de carteira — prova que o critério não fura) + `service_orders` (processo que a Setes usa
todo mês: período, status, cliente, contrato, valor). Alternativa: `orders` no lugar de `service_orders`.)*

**Q-BA11 — Desempenho**
Problema: critério em coluna sem índice + `LIKE '%x%'` + `COUNT` com a mesma WHERE = varredura completa em
tabela grande (pedidos, títulos).
(a) **cada critério declarado passa pela revisão de índice (`database/skills/revisar-ddl.md`); índice novo =
migration do módulo na mesma entrega; texto livre continua `contém`** ; (b) texto passa a ser "começa com"
para usar índice.
*(Rec.: (a) — o volume do cliente zero é pequeno, mas a regra nasce agora para não virar dívida.)*

## 6. Decisões arquiteturais registradas

**Rodada 1 DECIDIDA (Valdo 2026-09-30: "siga as recomendações")** — todas pela recomendação:

- **D-BA1** Critérios viajam no MESMO endpoint da lista, parâmetro `criteria` = JSON na query string;
  `parseListQuery` ganha `criteria`; teto de tamanho com 400 legível.
- **D-BA2** A lista de critérios de cada tela vive no CÓDIGO do módulo da API (lista branca chave → SQL + tipo),
  exposta ao app por `GET /api/<m>/search-fields`; nenhuma tabela nova.
- **D-BA3** Critérios = dados do registro que o usuário reconhece (lista + formulário), CURADOS por módulo.
- **D-BA4** O tipo decide o operador (texto = contém; número/valor/data = faixa de…até; FK = lookup; domínio =
  uma ou mais opções; sim/não = switch). Usuário não escolhe operador.
- **D-BA5** Critérios combinam em E.
- **D-BA6** O filtro rápido fica como é (remoto) e soma em E com os critérios; chips + "limpar".
- **D-BA7** Personalização pelo Framework de Configurações (config por interface, cascata usuário → institution →
  default) — na ONDA SEGUINTE.
- **D-BA8** Critérios sobrevivem como filtro/página hoje (volta do form mantém; sair da tela limpa).
- **D-BA9** Onda 1 = peça nos dois lados + botão na fábrica + pilotos; Onda 2 = demais telas da fábrica;
  Onda 3 = telas de processo; árvores fora. Tela nova nasce com critérios (skills atualizadas).
- **D-BA10** Pilotos: `customers` + `service-orders`.
- **D-BA11** Cada critério passa pela revisão de índice; índice novo = migration na mesma entrega.

**Parecer do guardião (`setes-conceito`, 2026-09-30) — peça de lego, nenhuma tabela nova.** As 4 decisões que ele
levantou foram EXECUTADAS pela recomendação dele, como ASSUNÇÃO (reversível — o Valdo pode divergir):

- **D-BA12** A declaração mora no `<m>.repository.ts` (constante `<M>_SEARCH_CRITERIA`) — as expressões dependem
  dos aliases da query base; o molde de 6 arquivos do módulo não muda.
- **D-BA13** Critério DERIVADO (ex.: "tem título em aberto") entra como `bool` só na forma `EXISTS` escopado
  (`tb_institution_id` + `deleted='N'` do alvo), com teste de escopo. Nenhum nos pilotos.
- **D-BA14** Nomes: `SearchCriterion` (definição) / `SearchCriteriaValues` (valores) / `GET /api/<m>/search-criteria`
  / `app/shared/search/`. "field" (catálogo do formulário + `fields[]` do erro) e "filter" (filtro rápido) são
  palavras OCUPADAS e ficaram fora do conceito novo.
- **D-BA15** Com a carteira do vendedor TRAVADA, o critério "vendedor" não é servido (só apresentação — o escopo
  já é garantido pelo AND da lista).

## 9. Onda 1 — execução (2026-09-30)

**API (setes-api)**
- Peça `@shared/list/search-criteria.ts`: `compileCriteria` (lista branca → fragmento ` AND (...)` parametrizado;
  operador pelo kind — texto contém com `escapeLike`, várias expressões em OU; faixas `>= / <=`, data com fim
  inclusivo `< DATE_ADD(?, INTERVAL 1 DAY)`; money por `round2`; lookup = id inteiro > 0; options = IN do domínio;
  bool com `boolValues` ou predicado derivado), `publicCriteria` (projeção sem `expr`), `NO_CRITERIA`, tetos
  (2000 chars, 20 chaves, texto 100). `escapeLike` foi para `escape-like.ts` (evita ciclo de import).
- `parseListQuery(req, moduleKey?, searchCriteria?)` → `ListQuery.criteria` SEMPRE presente; `criteria` enviado a
  módulo sem lista branca = 400 (chave desconhecida). Erros: 400 `SEARCH_CRITERIA_INVALID` (malformado, repetido,
  grande, chave desconhecida) · 422 `SEARCH_CRITERION_INVALID` com `fields[]` = chave do critério.
- Pilotos: `customers` (document [CPF/CNPJ só dígitos], city, salesman [lookup próprio], personType [reusa
  `PERSON_TYPES` exportado de `@shared/entity`], active, createdAt) e `service-orders` (customer [lookup NOVO
  `GET /service-orders/customer-lookup`], dtRecord, totalValue, number, invoiceNumber — a aba A/F segue `status`).
  `GET /<m>/search-criteria` nos dois, antes de `/:id`; Swagger com `criteria`, 400 e 422.
- **D-BA11 — revisão de índice: nenhuma migration.** As duas listas são DIRIGIDAS pela tabela principal filtrada
  pela institution (índice existente); todo critério é filtro residual numa junção 1:1 pela PK (subselect
  correlacionado na cadeia central, `tb_order`/`tb_order_totalizer`/`tb_invoice` pela PK). Onde o critério poderia
  dirigir o plano o índice já existe: `idx_service_customer (institution, customer)`, `uk_service_order_number
  (institution, number)`, índice de `tb_salesman_id`. Volume do dev: 260 clientes, 610 OS. Reavaliar quando uma
  lista de volume grande (pedidos/títulos) receber critérios na Onda 2.

**App (setes-app)**
- `app/shared/search/`: `SearchCriterion`/`SearchRange`/`SearchLookupValue`/`SearchCriteriaValues` (JSON do
  `criteria`, vazio descartado), `SearchCriteriaDatasource` AMARRADO ao `basePath` do módulo (lookup fora dele =
  `ArgumentError`), `showAdvancedSearch` (controle pelo kind, validação de data/número/faixa antes de enviar),
  `SearchCriteriaChips` (x por critério + "Limpar").
- `RegisterSearchPage`: botão `Icons.manage_search` com badge da contagem + chips abaixo do filtro — só aparece
  com critérios carregados (tela sem critérios = idêntica).
- `customers` (fábrica) e `service_orders` (processo, sem fábrica): critério na cadeia datasource → usecase → bloc
  (`_criteria` sobrevive ao filtro, à paginação, à troca de aba e à volta do form/detalhe; todo emit de lista leva
  os critérios); na OS a assinatura da SELEÇÃO do lote inclui os critérios (a lista vista mudou ⇒ seleção zera).
- i18n `search.*` pt/en (rótulos, opções `personTypeOptions.F/J/N`, faixas).

**Provas**: API 28 testes novos (`search-criteria.test.ts`) + 5 antigos ajustados ao `ListQuery.criteria` · app 6
testes novos (`search_criteria_test.dart`) + 2 stubs mocktail ajustados · `flutter analyze` limpo · **smoke ao vivo
17/17** (`scripts/smoke-pesquisa-avancada.ts`, somente leitura): `personType=J` = 248 na API e no banco;
ativo 92 + inativo 168 = 260; CNPJ digitado com máscara acha o cliente; 400/422 corretos; `/api/cities` com
`criteria` = 400; OS por cliente/nº/valor+período conferidas.

### 9.1 Gates (2026-09-30)

**1ª rodada — os dois REPROVARAM pelo MESMO HIGH**: socrático **0.68** · adversarial **0.66** (~95 ataques ao
vivo). **H1**: critério `money` finito gigante (`{"totalValue":{"from":1e307}}`) passava no `Number.isFinite`, o
`round2` estourava para `Infinity` e o mysql2 escreve `Infinity` CRU no SQL → coluna desconhecida → **500** + linha
no crashlytics, disparável por qualquer usuário logado. Lição (regra da peça): **o valor é conferido DEPOIS de
normalizado** — o que vai ao banco é o que foi validado (mesma família da regra "o que valida é o que grava").

Corrigidos em sessão:
- H1 → `MAX_RANGE_MAGNITUDE = 1e13` conferido após `parseNumber`/`round2`; string numérica só decimal simples
  (fim do `'0x10'`/`'1e3'` via `Number()`); lookup exige `Number.isSafeInteger`.
- M1 (app lia "1.500" como 1,5 — dinheiro R$ 1,50) → `AdvancedSearchNumbers.parse`: ponto = milhar, vírgula = único
  decimal, mesmo teto da API.
- M3 (parte objetiva) → o painel valida o teto de 100 caracteres (o 422 fica inalcançável pela tela).
- L1 → documento que fica sem dígitos = 422 (antes voltava a lista inteira com o chip dizendo o contrário).
- L2 → `invoiceNumber` pela coluna gerada `inv.number_seq` (migration 045), nunca varchar × número.
- L4 → mensagem própria para `criteria[a]=1`; app DESCARTA critério de kind desconhecido (API mais nova).
- L6 (pré-existente) → `listProductsLookup` da OS com `escapeLike`.
- Resistiu (provado ao vivo): `__proto__`/`constructor` como chave, parâmetro repetido/aninhado, tetos de
  tamanho/chaves/texto, injection e metacaracteres de LIKE, options fora do domínio, datas inválidas, faixa invertida,
  total = soma das páginas sem duplicata (54/54, 337/337, 260/260), `/search-criteria` sem expressão, módulos fora do
  piloto com 400 legível.
- Teste do gate: `src/__tests__/search-criteria-adversarial.test.ts` (36). Suíte **1494/1494** · app **159/159**.

**Re-score socrático: 0.78 ✅** (H1/M1/M3-objetiva/L1/L2/L4/L6 conferidos no código; resíduo baixo: nota com número
não numérico tem `number_seq = 0` e aparece em faixa que começa em 0; o painel recusa "1234.56" com ponto decimal —
coerente com pt-BR).

**Re-prova adversarial: 0.84 ✅** — 46 ataques novos nas bordas da correção, zero 500, sem HIGH/CRITICAL (teto 1e13
exato passa, 1e13+1 = 422; `'1.'`/`'.5'`/`'+5'`/`'1,5'` = 422; lookup `2**53` = 422; `"00005"` casa o id 5). Suíte final
**1497/1497**.

**M5 registrado (não corrigível agora)**: os subselects correlacionados custam ~5 buscas por PK por linha, nos
dois SELECTs — medir com volume real (EXPLAIN + carga) ANTES da Onda 2 levar critérios a pedidos/títulos.

### 9.2 ⚠️ Questões pendentes (Rodada 2 — nascidas nos gates)

- **Q-BA12** Critério "cidade": casa com QUALQUER endereço principal do cliente (`EXISTS`) × com um endereço escolhido
  por tipo? Hoje é o 1º em ordem alfabética do tipo (`LIMIT 1`) — cliente com comercial em Curitiba e entrega em SP
  não aparece em "São Paulo". *(Rec.: `EXISTS` sobre qualquer endereço `main='S'` — "o cliente tem endereço nessa
  cidade" é o que o usuário quer dizer.)*
- **Q-BA13** Lookup de cliente da OS (`/service-orders/customer-lookup`, novo): lista TODOS os clientes da
  institution — o vendedor com carteira travada em Clientes passa a ver nomes fora da carteira por aqui. (a) respeitar
  a mesma trava da carteira; (b) só clientes que têm OS; (c) aberto como está. *(Rec.: (a) — a carteira é regra da
  PESSOA, não da tela; reusar o resolvedor do customers via peça.)*
- **Q-BA14** Fuso dos critérios de data sobre DATETIME: servidor de banco × `America/Sao_Paulo` fixo × fuso do
  estabelecimento. Se a produção (SaveInCloud) rodar em UTC, o cadastro das 22h do dia 30 cai no dia 01. *(Rec.:
  fixar o fuso da sessão do pool em `America/Sao_Paulo` na Onda 4 — decisão transversal, vale para toda leitura
  de timestamp, não só a pesquisa.)*
- **Q-BA15** Lookup "Vendedor" da pesquisa inclui vendedores INATIVOS? Carteira é histórico (Onda 2 do salesman).
  *(Rec.: sim na PESQUISA — lookup próprio sem o filtro `active`; a atribuição no form continua só ativos.)*
- **Q-BA16** Critério recusado com 422: o app DESCARTA o critério recusado × mantém e só avisa? Hoje mantém e a lista
  trava até remover o chip (com o painel validando os mesmos limites, o 422 só vem de API mais nova/divergente).
  *(Rec.: descartar os critérios apontados em `fields[]` e recarregar, com o aviso da ponte de mensagens.)*

### 9.3 Rodada 2 DECIDIDA e EXECUTADA (Valdo 2026-09-30)

> "siga as recomendações, Q-BA14 - Criar uma variavel no estabelecimento para definir o fuso do sistema como um
> todo | Q-BA15 - somente ativos | Q-BA16 preciso de mais explicacoes"

- **D-BA16 (= Q-BA12, Rec.)** "Cidade" casa com QUALQUER endereço principal do cliente — a expressão concatena as
  cidades de todos os endereços `main='S'` (`GROUP_CONCAT`), o operador "contém" continua da peça, nenhum JOIN novo.
  Ao vivo: CURITIBA 140 na API = 140 no banco.
- **D-BA17 (= Q-BA13, Rec. a)** A carteira é da PESSOA: peça nova **`@shared/customer-wallet`** (`walletSalesmanId`,
  promovida do customers no 2º consumidor); customers e o lookup de cliente da OS perguntam a ela. Testes: vendedor
  travado só vê a carteira no lookup; não vendedor sem restrição.
- **D-BA18 (= Q-BA14 — Valdo DIVERGIU da Rec.)** **Variável de FUSO no estabelecimento** para o sistema inteiro.
  Parecer do guardião (assunções executadas): config `time_zone` do Framework de Configurações na interface
  `establishment` (kind Options, scope I, default `America/Sao_Paulo`, **seed sql/60**, sem DDL — fuso é
  comportamento, não identidade nem fato fiscal); opções = as 4 zonas oficiais (Noronha UTC-2, Brasília UTC-3,
  AM/MT/MS/RO/RR UTC-4, Acre UTC-5 — `options` é varchar(255); zonas regionais se o horário de verão voltar); default
  FIXO (derivar da cidade exigiria `time_zone` em 5.570 cidades — evolução registrada). Peça **`@shared/time-zone`**
  (`institutionZone`, `todayIn`, `dayStartUtc` — cobre o dia sem meia-noite do horário de verão, provado com SP
  04/11/2018 — `nextDay`; Intl, sem lib, sem cache próprio). Critério de data ganhou `storage: 'date'|'datetime'`:
  DATETIME converte só as PONTAS (`col >= CONVERT_TZ(?, '+00:00', @@session.time_zone)` com o início do dia NA ZONA
  como instante UTC; fim = início do dia seguinte), coluna intacta (índice preservado; funciona sem as tabelas de
  fuso do MySQL). `customers.createdAt` = datetime; `service-orders.dtRecord` = date. Tela "Meu Estabelecimento"
  ganhou a engrenagem do Framework (`SetesFormShell.actions`). **A aplicação no SISTEMA INTEIRO é fase própria —
  §10.**
- **D-BA19 (= Q-BA15)** Lookup "Vendedor" da pesquisa: SOMENTE ATIVOS (como está; nenhuma mudança).
- **Q-BA16** — Valdo pediu mais explicação; segue aberta (explicação entregue no chat de 2026-09-30).

Provas: API **1504/1504** · app **159/159** · analyze limpo (app + setes_widgets) · seed 60 aplicado no dev · smoke ao
vivo **20/20**.

## 10. Rodada 0 — FUSO DO ESTABELECIMENTO NO SISTEMA INTEIRO (fase própria, D-BA18)

A variável existe e a pesquisa consome. "O sistema como um todo" é transversal: **~387 usos de `NOW()`/
`CURRENT_TIMESTAMP`/`CURDATE()`/`new Date()` em 66 arquivos da API**; o pool não fixa `time_zone` (dev: `SYSTEM` =
America/Sao_Paulo); `created_at` nasce do relógio do SERVIDOR; datas de negócio (`dt_record` etc.) vêm em parte do app
como 'YYYY-MM-DD'.

**⚠️ Achado do guardião que é PRÉ-REQUISITO DA ONDA 4 (produção)**: `tax-authority/dps-builder.ts:72` e
`invoice-transmission/branches/service.ts:289` calculam o `dhEmi` da NFS-e com `getTimezoneOffset()` do PROCESSO Node
— com o servidor de produção em UTC, a nota sairia com offset `-00:00` (data/hora de emissão errada no fisco).

Estratégias (parecer do guardião):
- **A** `SET time_zone` por conexão com a zona do estabelecimento — o pool atende várias institutions; `pool.query`
  sem conexão explícita escapa; DATETIME não converte (dado misto).
- **B** UTC em tudo (sessão, `TZ` do Node, driver), converter só na leitura — modelo mais limpo para instantes;
  exige corte/backfill do dado gravado em hora local e conversão na apresentação.
- **C** Só as DATAS DE NEGÓCIO calculadas na zona (`todayIn`), instantes no relógio do servidor — mudança mínima,
  instante continua ambíguo se o servidor mudar de fuso.

Questões (Rodada 1 desta fase):
- **Q-TZ1** Estratégia: *(Rec.: C como 1º passo com B como destino — fixar a sessão do pool em `'+00:00'` com
  conferência no boot (como o REPEATABLE READ), proibir `CURDATE()`/`new Date()` como data de negócio — tudo por
  `todayIn` —, e censar os ~387 usos separando INSTANTE de DATA DE NEGÓCIO.)*
- **Q-TZ2** `dhEmi` da NFS-e pela zona do estabelecimento ANTES da Onda 4 *(Rec.: sim — é correção, não escolha.)*
- **Q-TZ3** Dado já gravado em hora local quando vier a fase B: backfill × data de corte *(Rec.: data de corte com a
  premissa anotada.)*

### 9.4 Q-BA16 DECIDIDA e EXECUTADA (Valdo 2026-09-30: "opção a")

- **D-BA20** Critério RECUSADO pela API (422 `SEARCH_CRITERION_INVALID` ou 400 `SEARCH_CRITERIA_INVALID` com
  `fields[]`) é DESCARTADO pelo bloc, o usuário é avisado (`search.criterionRemoved`, com os `fields[]` da API) e
  a lista recarrega com os demais — nunca fica travada. `SearchCriteriaValues.withoutRejected(failure)` (null quando a
  falha não aponta critério presente — sem laço). customers e service_orders; teste de bloc prova: 1ª chamada com 2
  critérios → recusa → 2ª chamada só com o válido + aviso.

### 10.1 Rodada 1 do fuso DECIDIDA e EXECUTADA — onda TZ-1 (Valdo 2026-09-30: "Q-TZ siga as recomendações")

- **D-TZ1 (= Q-TZ1)** Estratégia C→B: sessão do banco em UTC (`timezone: 'Z'` no mysql2 + `SET time_zone =
  '+00:00'` por conexão + `assertSessionTimeZoneUtc` no boot); TODA data de negócio por `todayFor(schema,
  institution)`. Censo (agente, 549 linhas): 28 pontos N (data de negócio) + 15 M — todos tratados: **zero
  `CURDATE()`** no código; helpers locais `todayIso`/`localTodayIso`/`localIsoDate` MORRERAM; `addDays` virou
  calendário puro sobre string; caixa (`dtRecord` do movimento/transferência era UTC — bug pré-existente após as
  21h — agora pelo hoje da zona). Regra destilada em `database/PADROES_BANCO.md` §10.
- **D-TZ2 (= Q-TZ2)** `dhEmi`/`dhEvento` da NFS-e pela zona do estabelecimento (`nowIsoIn` — antes `getTimezoneOffset`
  do processo Node; produção em UTC mandaria `-00:00`). Pré-requisito da Onda 4 FECHADO.
- **D-TZ3 (= Q-TZ3)** Data de corte: linhas gravadas antes de 2026-09-30 ficam em hora de parede de SP (sem backfill).
- **Assunções executadas (coerentes com o destino B)**: voz do fisco/banco gravada como INSTANTE UTC (`toDbDateTime`
  → `toUtcDb`; sem offset = hora de Brasília) e **idempotência de transição** (casa UTC OU a hora de parede antiga —
  sem isso uma liquidação já gravada viraria 2º evento); instantes com hora saem para o app na zona (`withZoneWall` na
  fronteira: visão fiscal, apresentações do boleto, caixa — `hrBegin/hrEnd` eram `String(Date)` do Node); pasta do
  arquivo fiscal pelo MÊS em America/Sao_Paulo (residual: zona configurável ≠ pasta — registrado).
- **Bug pré-existente corrigido**: `tb_cashier.hr_begin` com `ON UPDATE current_timestamp()` — o fechamento sobrescrevia
  a hora de abertura → **migration 064** (aplicada no dev).
- Testes: setup global do jest (`src/test-setup/time-zone.mock.ts`) fixa a RESOLUÇÃO da zona no default (os testes de
  repositório simulam o pool em sequência); funções puras seguem reais. API **1512/1512** · app **161/161**.
- **Prova ao vivo** (2026-09-30 22h02 em Brasília = 01/10 01h02 UTC): sessão `+00:00`, `NOW()` = UTC, "hoje do
  estabelecimento" = **2026-09-30** (com `CURDATE()` seria 01/10); `hr_begin` sem ON UPDATE; smoke 20/20.
- **Q-TZ4 (nova, aguarda o Valdo)**: o **setes-sync** (outro grupo, mesmo banco) segue gravando `created_at` na hora
  LOCAL da sessão dele — dado misto a partir de agora. *(Rec.: aplicar a mesma regra no setes-sync em tarefa própria
  daquele projeto — a fronteira dos dois grupos impede mexer daqui.)*

### 10.2 Gates da onda TZ-1 (2026-09-30)

- **Adversarial 0.78 ✅** (1500 instantes aleatórios 1970–2100 × 12 zonas, viradas de horário de verão; 71 testes em
  `time-zone-adversarial.test.ts`). Corrigidos: **MEDIUM** `createdAt.to = 9999-12-31` → `nextDay` '+010000-01' →
  `RangeError` → 500 (agora 422: ano fora de 1900–9998; ao vivo 422); LOWs: `toUtcDb` recusa data/hora impossível e
  ano < 1000, `toZoneWall` só aceita DATETIME, idempotência de transição só casa a forma antiga ANTES do corte
  (`TZ_CUTOVER_WALL`).
- **Socrático 0.58 ✗ → retrabalho**: **CRITICAL C1** — `todayFor` ia ao POOL (2ª conexão) DENTRO de transações (o
  padrão que já travou a API, 0/40 faturamentos), escondido dos testes pelo mock global. Correção: `institutionZoneFor`
  com consulta PRÓPRIA pelo `q` recebido (cache TTL) e TODA chamada em transação passa a `conn` dela; teste
  `time-zone-resolution.test.ts` exercita a implementação REAL (1 consulta pela conn, ZERO no pool). L1 (SET da
  conexão nova falhava em silêncio → log de erro), L2 (`formatDateTimeTz` sem offset = Brasília), L5 (cerca
  `time-zone-fence.test.ts`). API **1597/1597**. **Re-score socrático 0.76 ✅** — L7 (cache próprio do fuso não era
  invalidado ao salvar a config) corrigido em sessão: `interface-configs` chama `invalidateInstitutionZone`.

**⚠️ Questões da Rodada 2 do fuso (aguardam o Valdo)**:
- **Q-TZ4** setes-sync (mesmo banco) segue gravando na hora LOCAL → dado misto continua nascendo (critério
  `createdAt` de cliente vindo do sync desloca 3h; idade da chave de recuperação se o sync tocar o usuário). *(Rec.: o
  sync adota a mesma regra em tarefa daquele projeto; até lá a data de corte vale só para tabelas de autoria exclusiva
  da API — anotar no PADROES §10.6.)*
- **Q-TZ5** Idades calculadas sobre DATETIME gravado ANTES da troca (carência K→N da NFS-e, reserva em voo da NFS-e e
  do boleto, chave de recuperação) disparam na virada: pré-condição operacional de deploy ("nada em voo", conferida
  por script) × tratamento no código. *(Rec.: pré-condição com script — o efeito é só na virada.)*
- **Q-TZ6** Conferir `@@global.time_zone`/`system_time_zone` do MySQL de PRODUÇÃO antes do deploy (se já for UTC, a
  premissa da data de corte muda por ambiente). *(Rec.: sim — pré-requisito da Onda 4.)*
- **Q-TZ7** Pasta fiscal `<cnpj>/<ano>/<mês>`: mês na zona do ESTABELECIMENTO (igual ao `dCompet`) × mês oficial de
  Brasília (hoje); a raiz é compartilhada com o setes-sync? *(Rec.: zona do estabelecimento para arquivo novo, busca
  nas pastas vizinhas na virada do mês.)*
- **Q-TZ8** Relógio ÚNICO por operação: um "hoje" capturado na entrada do serviço e passado adiante (vencimentos,
  `dt_emission`, evento, cheque, estorno) — hoje cada `todayFor` lê o relógio; às 23:59:59 um faturamento pode gravar
  dias diferentes. *(Rec.: sim, regra nova no PADROES §10.)*
- Registrados sem ação: L3 (aviso de prazo de cancelamento 3h antes para `dhProc` antigo), L4 (`hr_begin` de caixas já
  fechados continua com a hora do fechamento — a 064 corrige só o futuro), L6 (contrato de instante: convertidos saem
  como parede sem offset; demais `created_at` crus).

### 10.3 Rodada 2 do fuso DECIDIDA e EXECUTADA (Valdo 2026-09-30: "siga as recomendações")

- **D-TZ4 (= Q-TZ4)** O setes-sync adota a mesma regra em tarefa do PROJETO setes-sync (fronteira dos dois grupos —
  tarefa separada criada); até lá a data de corte só vale para tabelas de autoria exclusiva da API (PADROES §10.6).
- **D-TZ5 (= Q-TZ5)** Pré-condição de deploy: `scripts/pre-deploy-tz-check.ts` (somente leitura; exit 1 se houver
  cancelamento K sem resposta, DPS reservado sem evento, boleto apresentado sem resposta ou chave de ativação recente).
  Dev: tudo zero.
- **D-TZ6 (= Q-TZ6)** O mesmo script mostra o fuso GLOBAL/SISTEMA do MySQL do ambiente — pré-requisito da Onda 4
  (se a produção já rodar em UTC, a premissa do corte muda e é registrada). Dev: SYSTEM = America/Sao_Paulo.
- **D-TZ7 (= Q-TZ7)** Pasta fiscal = mês contábil na zona do ESTABELECIMENTO (`saveFiscalXml/findFiscalXml(…, zone)`);
  busca tenta o mês da zona e o da hora oficial (arquivos de antes). Nota no Acre às 23:30 de 30/09 → pasta 09.
- **D-TZ8 (= Q-TZ8)** Relógio ÚNICO por operação: `@shared/time-zone/operation-clock` (AsyncLocalStorage) + middleware
  em `app.ts`; todo `todayFor` da requisição usa o instante de entrada. Só data de negócio (dhEmi segue o agora real).
- Achado ao rodar o script: a correção L1 gerava FALSO erro (o evento `connection` entrega a conexão crua, em estilo
  callback) — corrigido; o SET sempre executou (sessão `+00:00` conferida).
- PADROES_BANCO §10 itens 6 (nota Q-TZ4 + script de deploy), 8 (relógio único) e 9 (pasta fiscal). API **1603/1603**.

### 10.4 Gate do delta + publicação (2026-09-30)

- Socrático do delta Q-TZ4…Q-TZ8: **0.78 ✅** (sem CRITICAL/HIGH/MEDIUM; relógio da requisição sobrevive ao
  body-parser — `raw-body` amarra o callback ao AsyncResource; saves/finds fiscais todos fora de transação). LOWs:
  script de pré-deploy pode errar o diagnóstico se o GLOBAL for UTC com o sistema local; janela das chaves vira ~60 min
  reais (basta: TTL 15 min); falta teste HTTP do relógio pós-body-parser.
- **Q-TZ9 (nova, aguarda o Valdo)**: relógio único vale para a REQUISIÇÃO inteira (lote mensal de 18 min que cruza a
  meia-noite usa "ontem" até o fim) × por ORDEM dentro do lote; e as guardas contra o mundo externo (vencimento no
  registro do boleto, "pagamento no futuro") usam o relógio congelado × o agora real. *(Rec.: relógio por ordem no
  lote; guardas externas no agora real.)*
- Adversarial do delta: **0.80 ✅** (91 testes; relógio sobrevive ao `express.json`, sem vazamento entre operações). MEDIUM
  do script de pré-deploy (decidia pelo fuso do SO mesmo com o GLOBAL fixado) + LOWs (SQL quebrado virava luz verde;
  `findFiscalXml` aceitava `../..`) corrigidos no commit de acompanhamento da api. Registrados: fila do webhook roda no
  relógio da requisição que enfileirou (Q-TZ9); busca de H olha a pasta de P (compatibilidade Q-N38a).
- **PUBLICADO no GitHub (main)**: api `ad42018` · app `532cd44` · sql `2a82507` · Infra-IA (este commit).

### 10.5 Q-TZ9 DECIDIDA e EXECUTADA (Valdo 2026-09-30: "siga as recomendações")

- **D-TZ9a** Relógio POR ORDEM nos lotes: faturamento em lote (cada ordem e a passada extra do RESOURCE_BUSY), rotina
  mensal (a transação de cada cliente) e cada item da fila do webhook do banco (no momento em que é processado) rodam em
  `runWithOperationClock(new Date(), …)` — um lote que cruza a meia-noite não grava o "ontem" depois dela.
- **D-TZ9b** Guardas contra o MUNDO EXTERNO usam o AGORA real (`todayFor(…, new Date())`): vencimento no passado ao
  registrar o boleto no banco, "pagamento no futuro" na liquidação (D-G36) e o dia de fallback quando o banco não manda a
  data da situação. O relógio congelado vale só para os fatos internos da operação.
- PADROES_BANCO §10.8 atualizado. API **1625/1625**. Gate socrático do delta **0.80 ✅** (sem questão nova; LOW: a regra
  do relógio por item não tem cerca automática → entrou no checklist da skill `novo-modulo`).

## 11. Passeio logado (2026-09-30, Claude in Chrome com o Valdo autenticado)

Servidor do app estava de 29/09 (antes de tudo — web-server não recompila no F5): reiniciado; tela branca era a
compilação antiga. Roteiro e evidências:
- **Clientes**: painel com os 6 critérios traduzidos; Cidade "Curitiba" + Pessoa jurídica + Ativo Sim → **53**
  (conferido no banco: 53); chips + selo "3"; remover o chip Ativo → 134; filtro rápido "comercio" soma → 41; critérios
  sobrevivem à ida/volta do formulário (D-BA8).
- **Ordens de Serviço**: painel com 5 critérios; Valor total de "150" até "1.000,00" → chip "de R$ 150,00 até R$
  1.000,00" (pt-BR lido como mil — M1) → 3 abertas; critério sobrevive à troca de aba (Faturadas: 28, inclusive a 7374
  "Cancelada"); lookup de cliente "K2" + valor → 27.
- **Meu Estabelecimento**: engrenagem no AppBar → painel com "Fuso horário do estabelecimento … Brasília (UTC-3) —
  padrão do sistema" (não alterado).
- **Achado CORRIGIDO no passeio** (app, commit local): ao voltar do formulário o campo "Filtro" vinha VAZIO com a lista
  ainda filtrada (o "Limpar" da pesquisa avançada parecia deixar 70 em vez de 260) — `RegisterSearchPage.filter` + as
  27 telas da fábrica passam `state.filter`; re-provado ao vivo.
- **Achado registrado (pré-existente)**: o título do painel de configurações mostra a descrição técnica da interface em
  inglês ("Configurações das Interfaces · My Establishment") em vez do nome traduzido do menu.

## 7. Fora de escopo (candidatas)

Pesquisas salvas com nome · operador escolhido pelo usuário · OU entre critérios · exportar resultado
(CSV/planilha) · ordenação por coluna escolhida pelo usuário · pesquisa avançada nos lookups (`SetesLookupField`).

## 8. Critérios de sucesso (rascunho — fecham com a Rodada 1)

1. Nas telas-piloto, o botão "Pesquisa avançada" abre os critérios do módulo; pesquisar volta à página 1 e o
   `total` confere com a contagem no banco para a mesma combinação.
2. Filtro rápido + critérios combinam em E; chips mostram o que está ativo; "limpar" volta à lista cheia.
3. Critério desconhecido → 400; valor inválido → 422 com `fields[]` apontando o critério; nunca 500.
4. Vendedor com carteira não enxerga cliente fora dela por nenhuma combinação de critérios (teste jest).
5. Tela sem critérios declarados continua idêntica (o botão não aparece).
6. i18n pt/en completo; `flutter analyze` limpo; suíte da API verde; gates (socrático ≥ 0.70 + adversarial sem
   HIGH/CRITICAL) antes de dar por pronto.
