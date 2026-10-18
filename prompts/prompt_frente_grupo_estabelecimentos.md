# Frente — Grupo de estabelecimentos (matriz × filiais no mesmo schema)

**Escopo**: misto (o conceito "o grupo é o schema; a tabela é do grupo OU do estabelecimento" e o método de varrer todo SQL que não
filtra pela institution são portáveis; os pontos de código, o legado e as decisões são do Gestão 2027)
**Origem**: Valdo, 2026-10-17, na frente do cadastro de produtos — "consegue me ajudar a criar uma estrutura em que matriz e filiais possam
compartilhar produtos?" → desenho do guardião (§11 do `prompt_modulo_products.md`) → **D-PR20…D-PR23** (frente PRÓPRIA, grupo = schema por
decisão comercial, origem/finalidade do bem compartilhadas, preço = tabelas do grupo + vínculo da filial) e **D-PR24** (a onda 1 de produtos
não depende desta frente). Rodada 0 pedida pelo Valdo: "faça esta tarefa aqui: Rodada 0 da frente matriz × filiais (grupo = schema)".
**Aberto em**: 2026-10-17. **Estado**: Rodada 0 ORGANIZADA (anexo + guardião §3 + ondas §5). **Rodada 1 FECHADA 2026-10-18 ("siga as
recomendações") — D-GE1…D-GE17**; regra nova no `PADROES_BANCO.md` §12; tarefa própria da D-GE4 proposta. **Rodada 2 FECHADA
2026-10-18** (A-GE1 confirmada + D-GE18). **D-GE4 EXECUTADA 2026-10-18 em worktree (§12 — 4 leitores corrigidos, zero DDL,
gates 0,78/0,84; commit LOCAL ff2795f na branch `grupo-leitores` (2026-10-18, "vai" do Valdo), sem push e sem merge)**. **Rodada 3 (§12.4–§12.5, achada pelo gate socrático da D-GE4): D-GE19 (o Módulos só REORGANIZA as
telas do contrato; toda tela nasce com interface + privilégios), D-GE22 (o contrato de telas é do GRUPO — o da matriz vale
obrigatoriamente para as filiais; D-GE23: sem tela a mais na filial), D-GE20 (menu editado por quem tem
a tela Módulos no cadastro do usuário; A-GE2: o admin passa como sempre) e D-GE21 (institution nunca muda de schema). ⚠️ 31 das 40 interfaces do
catálogo sem privilégio (§12.5) — tarefa própria: `prompt_privilegios_interfaces.md` (Rodada 0 organizada 2026-10-18, Q-PV1…Q-PV9)**.
Nada de DDL ou seed desta frente.
**Anexo**: `prompt_frente_grupo_estabelecimentos-inventario.md` (o que aguenta N por schema · o que QUEBRA, por risco · docs 1:1 × N ·
classificação catálogo × operação com o legado · o que quebra ao chavear pelo grupo · papéis de entidade — tudo com arquivo:linha).
**Regra dos dois grupos**: setes-sync e sincronizador NÃO foram lidos — o que depende deles está no §7 (pedido ao grupo do sync).
**Transversal**: toca setes-api (auth, onboarding, ~30 leitores), setes-app (troca de estabelecimento, onboarding), fiscal-api (fonte de
fatos) e nfse-api (guards que leem privilégio). Dizer isso de saída ao retomar.

---

## 1. Por que agora e o que já está decidido

1. Hoje **1 institution = 1 schema = 1 CNPJ** (`UNIQUE KEY schema_name` — `sql/01_setes_central_ddl.sql:272`) e nada liga institutions.
   Um cliente com filiais cadastraria produto, cliente, plano… em cada uma.
2. As PKs `(id, tb_institution_id)` do schema do cliente vieram do `gestao_setes`, que guardava N estabelecimentos por schema; o legado
   (um Firebird com N estabelecimentos) É este modelo — produto ÚNICO, estoque e regra fiscal por estabelecimento.
3. **Decidido** (D-PR20…D-PR23): o grupo É o schema `setes_<cliente>` com N institutions, definido por decisão COMERCIAL (nunca pela raiz
   do CNPJ); a chave do compartilhado = a institution FUNDADORA, gravada uma vez; compartilhado = produto, fiscal do bem, marca, unidades de
   venda, categoria, plano financeiro, tabelas de preço + grade; por institution = estoque, regra tributária/MVA/FCP/ISS, emissor, caixa,
   financeiro, custo e QUAIS tabelas de preço a filial usa. **Condição embutida da D-PR22**: o contador confirma as origens 1×2 e 6×7 antes
   de a 1ª filial compartilhar o catálogo.

## 2. Fatos que decidem (resumo — detalhe e evidência no anexo)

| # | Fato | Consequência |
|---|---|---|
| G1 | JWT, flags, caches, contadores, nº da nota, emissor/série, motor da regra, fiscal-api e nfse-api JÁ trabalham por institution | a maior parte do sistema aguenta N por schema sem mudança |
| G2 | **Vazamentos latentes** (inofensivos com 1 institution por schema): cofre do canal bancário por schema + id da conta (que é MAX+1 POR institution); `tb_user_has_privilege` SEM institution — lido também pelo fisco (TRANSMITIR/CANCELAR); contrato de interfaces lido sem filtro (menu = união); observação fiscal juntada só por `o.id`; webhook do banco acha o canal só pelo token; impacto IBS/CBS conta o schema | onda 0 da frente — e alguns leitores podem ser corrigidos JÁ (Q-GE4) |
| G3 | **Institution errada**: `core.repository.ts:4-18` (`rows[0]` sem ORDER BY); migration 043 (`LIMIT 1`); `establishment_code` = schema; cada institution nova vira `tb_customer` da Setes | corrigir no onboarding/leitores |
| G4 | **Onboarding bloqueado**: UNIQUE `schema_name` + 409 + DTO + app; admin com e-mail novo obrigatório; o app não chama `switch-institution` | onda de onboarding |
| G5 | **Legado × web** — plano de contas POR estabelecimento no legado (`TB_PLANOCONTAS` PK com `PLC_CODMHA`, conferido) × decidido compartilhado; formas de pagamento GLOBAIS no legado × vínculo por institution na web; FCP COMPARTILHADO no legado × por institution na web; permissões POR estabelecimento no legado (`TB_PERMISSAO` PK com `PER_CODMHA`, conferido) e no baseline web × **a migration 003 tirou a institution** | divergências a decidir (§4, §6) |
| G6 | Papéis no legado: cliente/fornecedor/transportadora COMPARTILHADOS (termos comerciais na TB_EMPRESA global; limite de crédito global × dívida da filial ativa); colaborador/vendedor compartilhados por padrão | Q-GE9/Q-GE10 |
| G7 | `tb_entity_tax` é MISTA: com id = institution guarda o regime do EMITENTE (`simples_regime`, `simples_assessment`, `simples_total_tax_aliquot`, `special_tax_regime`, `cnae` — `sql/03:785-825`, conferido); com id = cliente, o fiscal do PAPEL | colide com papéis do grupo (Q-GE11) |
| G8 | `tb_service.tb_service_tax_rule_id` com FK composta amarra a regra de ISS (do estabelecimento) à linha do bem (do grupo) | vínculo próprio (Q-GE13) |

## 3. Parecer do guardião (`setes-conceito`, 2026-10-17 — integrado)

**Conceito**: o conjunto de estabelecimentos que um cliente da Setes opera sob um mesmo compartilhado. Nasce da decisão comercial (D-PR21);
a casa física é o schema (D-PR20). **Sem tabela de membros** — um `tb_institution_group` repetiria o que `schema_name` já diz e exigiria a
guarda "mesmo grupo = mesmo schema" (maquete).

**O único fato próprio do grupo é a FUNDADORA** (a institution sob a qual o compartilhado é arquivado, gravada uma vez). Casa recomendada:
**tabela de linha única no próprio schema** (uma por schema por construção; backfill de hoje = a institution que já existe). Descartadas:
coluna em `tb_institution` (N cópias que precisam concordar), tabela central por schema (recria o `tenants` que a decisão 4 da Fase 2 absorveu),
`MIN(id)` derivado (uma institution antiga que entre no grupo — fusão de clientes — deslocaria a chave em silêncio).

**Regra estrutural (a mais importante)**: como a chave do grupo é o id da fundadora, **uma tabela é do GRUPO OU do ESTABELECIMENTO, nunca das
duas** — numa tabela mista, a linha do grupo e a linha da fundadora teriam a MESMA PK. (Vira a 5ª regra de alocação da onda 1 de produtos —
Q-GE2.)

**Fundadora ≠ matriz ≠ licenciado ≠ cliente comercial**: fundadora = chave técnica, não manda em nada; matriz = fato da RFB sobre o CNPJ, sem
regra no sistema (não vira coluna); licenciado = o estabelecimento (decisão 9 da Fase 2: `tb_institution.active`; D-F14); cliente comercial =
o grupo.

**Onda 0 — "o schema aguenta N institutions sem vazar"** (com 1 institution por schema, NADA muda):
| Item | Forma certa | Quando |
|---|---|---|
| Cofre do canal bancário | caminho pela identidade completa do dono (institution + conta) + mover os diretórios | onda 0 |
| Privilégio | `tb_institution_id` VOLTA à PK (como no baseline, no legado e na **decisão 10 da Fase 2**: "o mesmo usuário pode ter poderes diferentes por institution"); leitores no setes-api e na fonte de fatos do fiscal-api (guards da nfse-api) | onda 0, 1º item (3 repos; fiscal em produção) |
| Contrato lido sem filtro · observação fiscal · webhook · `core.repository` `rows[0]` | só no LEITOR: filtrar pela institution, juntar pela PK inteira, conferir a institution da URL — zero DDL | **JÁ** (a observação põe texto na NOTA; o webhook é fronteira de confiança) — Q-GE4 |
| Menus | não é vazamento se o menu for do grupo (Q-GE5) | — |
| Impacto IBS/CBS · laços sem DISTINCT | percorrer por schema / pela chave do grupo | onda 0 |
| `tb_order_cost` sem institution (PK por pedido, que é MAX+1 por institution ⇒ colide) | sem consumidor na web | pedido ao grupo do sync |
- **Cerca permanente**: o método do inventário vira teste — todo SQL do schema do cliente sem `tb_institution_id` falha, salvo a lista branca
  do schema (`tb_module*`, a linha do grupo).
- **Fixture com 2 institutions no MESMO schema**: hoje chave do grupo = institution e nenhum teste distingue as duas; é ela que prova a onda 1.

**Fronteira grupo × estabelecimento (recomendações)**:
- **Plano financeiro: compartilhado (confirma a D-PR20)** — diverge do legado, mas o arranjo da web é CONSISTENTE: o vínculo da filial
  aponta o plano do grupo (a operação aponta o catálogo); o legado fazia o inverso (forma global → plano por estabelecimento).
  `payment-types.repository.ts:46-51` passa a juntar pela chave do grupo.
- **Formas de pagamento: o vínculo continua POR estabelecimento** — diverge do legado (global) com motivo: TEF, parcelas e regras de
  recebimento apontam a conta corrente DA FILIAL.
- **FCP: por estabelecimento, junto do MVA** — o motor lê do estabelecimento do pedido, um escopo só; o FCP compartilhado do legado era a exceção.
- **Categoria**: do grupo (a de vitrine do legado nasce com o e-commerce). **Promoção**: nasce com o consumidor (D-PR27), no formato da D-PR23.
- **Papéis: do GRUPO**, como no legado (a frase da Fase 3 `:48-50` era observação do DDL, não decisão). A dívida aberta é por estabelecimento e
  sai do financeiro; termos próprios de uma filial, se um dia precisarem, viram peça de especialização que SOMA sem reformar a do grupo.
- **`tb_entity_tax` colide com papéis do grupo**: na transferência filial → matriz (CFOP 5.151/5.152) a linha (A, A) seria ao mesmo tempo o
  regime do emitente A e o fiscal do papel A ⇒ pré-requisito: os fatos do EMITENTE saem para a peça do estabelecimento que a frente IBS/CBS já
  prevê (`tb_establishment_tax_regime`, D-IB7/D-IB66) — coordenar com aquela frente, não inventar peça.
- **Privilégios**: por estabelecimento. **Menus**: do grupo, filtrados pelo contrato de cada estabelecimento.
- **Configurações e campos**: por estabelecimento (o fuso pode diferir entre filiais), CLONADOS quando a filial nasce — uma camada "grupo"
  exigiria tabela nova pela regra estrutural.

**Peças e costuras**:
- **`@shared/group`**: `groupInstitutionOf(conn, schema)` lê a linha do grupo (cache permanente — o fato é imutável); entra no escopo da
  requisição `{ institutionId, groupInstitutionId }`, no molde do relógio único (Q-TZ8). Nem no JWT (identidade mínima), nem em view (esconde o
  escopo e atrapalha o FOR UPDATE).
- **Regra única para não bifurcar as ~30 queries**: tabela do grupo filtra por `groupInstitutionId`; tabela de operação por `institutionId`;
  NUNCA `p.tb_institution_id = x.tb_institution_id` entre as duas. A lista `GROUP_TABLES` mora na peça e alimenta a cerca. Hoje os dois valores
  são iguais ⇒ cada edição é PROVADAMENTE neutra.
- **Nome**: `groupInstitutionId` (é um id de institution); evita "catálogo" (papéis e plano também usam) e "chave" sozinha (já tem 4 sentidos
  no glossário; entra como 5º, "chave do grupo").
- **Contadores**: `@shared/product-id` recebe a chave do grupo (regra 4 da D-PR24); a regra 7 do PADROES §9 ganha ORDEM FIXA quando a
  transação cunha os dois tipos de número — proposta: estabelecimento → grupo.
- **Fonte de fatos do fiscal-api**: o catálogo lido pela chave do grupo (o GRANT `setes\_%` já cobre).
- **Serviço × regra de ISS**: vínculo `tb_institution_has_service` (estabelecimento × serviço → `tb_service_tax_rule_id`, FK composta pela
  institution do ESTABELECIMENTO); a coluna do bem só morre depois que o sync se adaptar (ele escreve `tb_service`).
- **Filial × tabela de preço**: `tb_institution_has_price_list` (casa da D-PR23). Bônus: `tb_price_ibfk_2` (só por id) fica correta por
  construção — todas as tabelas de preço do schema terão a mesma chave.

**Auth, onboarding e licença**:
- **Dois atos sobre a MESMA composição**: "cliente novo" (schema novo + linha do grupo + fundadora; o 409 de schema em uso fica AQUI) ×
  "estabelecimento no grupo" (sem migrations, sem linha do grupo; flags e contrato estrutural reaproveitados; admins escolhidos entre os usuários
  do grupo, sem e-mail novo). O `UNIQUE schema_name` cai.
- **Admin do grupo**: DERIVADO (admin vinculado a todas as institutions do schema), sem `kind` novo.
- **`switch-institution` no app**: a troca zera o estado dos blocs e o token de TODOS os clientes HTTP (setes-api e nfse-api — lição da F2b).
- **Licença**: por estabelecimento (decisão 9 e D-F14 seguem valendo). **Cliente faturável**: o grupo é UM `tb_customer` pagador na Setes — o
  onboarding da filial deixa de criar cliente (`institutions.repository.ts:135-146`).

## 4. Divergências apontadas (o Valdo decide)

1. **Migration 003 × decisão 10 da Fase 2** (interna, já existe hoje): a decisão 10 diz "o mesmo usuário pode ter poderes diferentes por
   institution"; a 003 recriou `tb_user_has_privilege` SEM `tb_institution_id` (o baseline tinha) — Q-GE3.
2. **Plano de contas**: D-PR20 (compartilhado) × legado (por estabelecimento) — o guardião confirma a D-PR20 com motivo — Q-GE6.
3. **Formas de pagamento**: web (vínculo por estabelecimento) × legado (global) — Q-GE7.
4. **FCP**: web (por estabelecimento) × legado (compartilhado) — Q-GE8.
5. **Papéis**: web hoje (por institution; frase da Fase 3 `:48-50`) × legado (do grupo) — Q-GE9/Q-GE10.
6. **Decisão 16 da Fase 2** ("todo tenant é tratado como institution"): o texto fica inexato (o tenant — o schema — passa a ter N
   institutions); o JWT não muda. Não exige decisão nova, só a anotação.
7. **Q22** ("dado fiscal interpretável não se compartilha entre institutions"): foi decidida para CLIENTES diferentes; no grupo vale para a
   regra/MVA/FCP (por estabelecimento), e o fiscal do BEM (NCM/CEST/origem/finalidade) é compartilhado (D-PR22).

## 5. Ondas (proposta do guardião)

| Onda | Conteúdo | Observação |
|---|---|---|
| **0** | vazamentos latentes (cofre, privilégio, impacto IBS/CBS, laços) + cerca + fixture com 2 institutions | NEUTRA com 1 institution por schema; os leitores de G2 podem ir JÁ (Q-GE4) |
| **1** | linha do grupo + `@shared/group` + leitores (setes-api e fonte fiscal) pela regra única + contadores + `tb_institution_has_service` + `tb_institution_has_price_list` | NEUTRA (os dois valores ainda iguais) |
| **2** | papéis do grupo + saída do regime do emitente de `tb_entity_tax` (com a frente IBS/CBS) | depende de Q-GE9…Q-GE11 |
| **3** | onboarding em dois atos + `switch-institution` no app + licença/comercial | **gate**: condição da D-PR22 (contador) + cerca verde. **Por último**: filial aberta antes das ondas 1–2 criaria catálogo e papéis próprios no schema — unificar depois é migração com conflito |
- **Onda 1 do cadastro de produtos**: independente; ganha só a 5ª regra de alocação (Q-GE2); `tb_merchandise_trade_unit` já usa a chave do
  `tb_product`.

## 6. Questões — Rodada 1 (TODAS DECIDIDAS em 2026-10-18 pela recomendação — D-GE1…D-GE17)

**Q-GE1 — Casa da fundadora (o fato do grupo).** **(a)** tabela de linha única no próprio schema **(Recomendado)** · (b) coluna em
`tb_institution` · (c) tabela central por schema.

**Q-GE2 — A regra "a tabela é do GRUPO ou do ESTABELECIMENTO, nunca das duas" entra no `PADROES_BANCO.md` e como 5ª regra de alocação da
onda 1 de produtos?** **(a)** sim **(Recomendado)** · (b) não.

**Q-GE3 — Privilégio por estabelecimento?** (diverge da migration 003, coerente com a decisão 10 da Fase 2, o baseline e o legado) **(a)** por
estabelecimento — `tb_institution_id` volta à PK de `tb_user_has_privilege`, leitores no setes-api e na fonte de fatos do fiscal-api
**(Recomendado)** · (b) do schema, como hoje.

**Q-GE4 — Leitores com defeito latente (contrato sem filtro, observação fiscal só por id, webhook só pelo token, `core.repository` `rows[0]`).**
**(a)** corrigir JÁ, em tarefa própria (zero DDL, neutro hoje) **(Recomendado)** · (b) esperar a onda 0.

**Q-GE5 — Menus.** **(a)** do grupo, filtrados pelo contrato de cada estabelecimento **(Recomendado)** · (b) por estabelecimento.

**Q-GE6 — Plano financeiro.** **(a)** confirmar compartilhado (D-PR20 — diverge do legado; a forma da filial aponta o plano do grupo)
**(Recomendado)** · (b) por estabelecimento, como no legado.

**Q-GE7 — Vínculo das formas de pagamento.** **(a)** por estabelecimento (TEF/parcelas/regras apontam a conta da filial) **(Recomendado)** ·
(b) do grupo, como no legado.

**Q-GE8 — FCP.** **(a)** por estabelecimento, junto do MVA **(Recomendado)** · (b) do grupo, como no legado.

**Q-GE9 — Papéis de entidade (cliente, fornecedor, transportadora, colaborador, vendedor).** **(a)** do GRUPO, com especialização futura por
filial se precisar **(Recomendado)** · (b) por estabelecimento, como hoje.

**Q-GE10 — Se Q-GE9 = (a): o limite de crédito do grupo é comparado com a dívida de quem?** **(a)** do grupo inteiro **(Recomendado)** ·
(b) da filial que vende, como no legado.

**Q-GE11 — Regime do emitente em `tb_entity_tax`.** **(a)** sai para a peça do estabelecimento da frente IBS/CBS (`tb_establishment_tax_regime`)
**(Recomendado)** · (b) fica, e os papéis ficam por estabelecimento.

**Q-GE12 — Configurações e campos configuráveis.** **(a)** por estabelecimento, CLONADOS quando a filial nasce **(Recomendado)** · (b) camada do
grupo em tabela nova.

**Q-GE13 — Vínculo serviço × regra de ISS (`tb_institution_has_service`).** **(a)** FK física carregando o `groupInstitutionId` do serviço
**(Recomendado)** · (b) validação na peça, sem FK.

**Q-GE14 — Onboarding.** **(a)** dois atos ("cliente novo" × "estabelecimento no grupo"), admins escolhidos entre os usuários existentes
**(Recomendado)** · (b) um ato só, com e-mail novo obrigatório.

**Q-GE15 — Admin do grupo.** **(a)** derivado (admin vinculado a todas as institutions do schema) **(Recomendado)** · (b) `kind` novo.

**Q-GE16 — Licença e faturamento da Setes.** **(a)** licença por estabelecimento + UM cliente pagador (o grupo) **(Recomendado)** · (b) cada
filial é cliente faturável · (c) o grupo como licenciado (diverge da D-F14 e da decisão 9).

**Q-GE17 — Ordem das ondas.** **(a)** onboarding por ÚLTIMO (onda 3) **(Recomendado)** · (b) onboarding primeiro.

## 7. Pedido ao grupo do sync (não lido por esta frente)

Quem escreve `tb_service.tb_service_tax_rule_id`, os papéis (`tb_customer`…), `tb_order_cost` e privilégios · o uso de `establishment_code` ·
o `LIMIT 1` da migration 043 em schema com legado multi-estabelecimento · como um Firebird com N estabelecimentos (`Gb_CodMha`) vira N
institutions num schema — e o registro "1 Firebird = 1 estabelecimento" de `setes-sync/verificacao-comissao-margem-mercadoria.md:132,167` ·
`PRO_CODMHA` (não viaja hoje — "1 chave = 1 institution").

## 8. Fora de escopo

Matriz como conceito (fato da RFB sem regra) · grupo econômico com vários clientes Setes · consolidação contábil entre filiais ·
transferência de estoque entre filiais (processo próprio) · telas de relatório do grupo · qualquer mudança no setes-sync/sincronizador.

## 9. Critérios de sucesso (da frente)

1. Com 2 institutions no MESMO schema (fixture), nenhum leitor vaza dado de uma para a outra — a cerca reprova SQL do schema do cliente sem
   `tb_institution_id` fora da lista branca.
2. Privilégio dado na matriz NÃO vale na filial (setes-api e nfse-api).
3. Produto, categoria, plano, tabelas de preço e papéis (se Q-GE9 (a)) cadastrados uma vez valem em todas as filiais; estoque, regra fiscal,
   emissor, caixa e financeiro seguem por filial.
4. Abrir filial num schema existente sem e-mail novo; trocar de filial no app sem sair.
5. Cada onda NEUTRA com 1 institution por schema (o que existe hoje não muda de comportamento).
6. Gates socrático ≥ 0,70 e adversarial sem HIGH/CRITICAL por onda; nada publicado sem o "vai".

## 10. Retomada

```
Retome a frente do grupo de estabelecimentos pelo Infra-IA/prompts/prompt_frente_grupo_estabelecimentos.md.
⚠️ Frente TRANSVERSAL (setes-api auth/onboarding/leitores, setes-app, fiscal-api, nfse-api).
Estado: Rodadas 1 e 2 FECHADAS (D-GE1…D-GE18 + A-GE1); D-GE4 executada (§12); D-GE19…D-GE23 + A-GE2 (§12.5); NENHUMA questão aberta.
Próximo: abrir a ONDA 0 (vazamentos latentes + cerca + fixture com 2 institutions;
o privilégio por estabelecimento — D-GE3 — vai por janela com plano: toca o caminho fiscal de produção).
A tarefa própria da D-GE4 (leitores sem filtro, zero DDL) foi EXECUTADA na worktree grupo-leitores (§12) — publicar só com o "vai";
a fixture two-institutions (src/test-setup) é a semente da fixture da onda 0. A-GE2 resolvida (o admin passa como sempre); a D-GE22/D-GE23 (contrato só do grupo) entra na onda 1;
a D-GE20 (guarda de privilégio no /api/modules) entra na onda 0 junto da D-GE3.
Confira antes se a frente IBS/CBS já criou tb_establishment_tax_regime (D-GE11 — pré-requisito da onda 2).
```

## 11. Questões — Rodada 2 (TODAS DECIDIDAS em 2026-10-18 pela recomendação — A-GE1 confirmada, D-GE18)

**A-GE1 (assunção — confirmar)**: a D-GE10 (limite de crédito contra a dívida do GRUPO) cria a 1ª leitura AGREGADA de OPERAÇÃO — o saldo em
aberto do cliente somado sobre os estabelecimentos do schema. Forma: `tb_institution_id IN (<institutions do schema>)` resolvido pela peça
`@shared/group`, nunca "sem filtro"; a cerca da onda 0 ganha uma lista nomeada `GROUP_AGGREGATE_READS` (hoje com 1 item: o saldo do cliente
para o crédito) — leitura agregada fora dela reprova.

**Q-GE18 — Quem pode EDITAR o que é do grupo?** Com catálogo (produto, categoria, plano, tabelas de preço), papéis (D-GE9) e menus (D-GE5)
do grupo, uma alteração feita na filial vale para todas. **(a)** catálogo e papéis: quem tem a interface + privilégio em QUALQUER
estabelecimento do grupo (como no legado — o dado é do grupo); estrutura de MENU: só o admin do grupo (D-GE15) **(Recomendado)** · (b) tudo só
pelos usuários da fundadora · (c) tudo por qualquer admin de qualquer estabelecimento.

## 12. D-GE4 EXECUTADA — leitores latentes corrigidos sem DDL (2026-10-18, worktree; commit LOCAL ff2795f na branch `grupo-leitores` (2026-10-18, "vai" do Valdo), sem push e sem merge)

Tarefa própria pedida pela D-GE4. Worktree `D:\Gestao2027\grupo-leitores\setes-api` (branch `grupo-leitores`, base f53a618; junções
só-leitura `grupo-leitores\{fiscal-api,nfse-api}` e `node_modules` → árvore viva). Zero DDL, zero seed. **Neutro com 1 institution por
schema**: a institution que o código passa a exigir é a única que o schema tem (o gate socrático conferiu no dev, só leitura: 0 linhas de
contrato/canal com outra institution, nenhuma regra apontando observação).

### 12.1 O que mudou

| # | Leitor | Defeito com 2 institutions no schema | Correção |
|---|---|---|---|
| A3 | `admin.repository.ts` `listInterfacesWithGrant` (tela do Super) | mostrava o contratado da OUTRA — e o salvar (`setInstitutionInterfaces`, que já era escopado) COPIAVA para a alvo o que a tela mostrou; a tela das duas saía duplicada | `ihi.tb_institution_id = ?` no LEFT JOIN, pela institution ALVO |
| A3 | `core.repository.ts` `getModuleInterfaces`/`getUngroupedInterfaces` (menu) | menu = UNIÃO dos contratos; tela das duas duplicada no módulo | filtro pela institution do JWT; os módulos seguem do GRUPO (D-GE5); ordem dos `?`: contrato antes do privilégio |
| A3 | `modules.repository.ts` `listEligibleInterfaces`/`findIneligibleInterfaceIds` (+ service/controller, tipo `MenuScope`) | o admin vinculava ao menu tela que só a outra contratou; lookup duplicado | elegível = contratada pelo estabelecimento do JWT (ver Q-GE19) |
| A4 | `billing.repository.ts` `getRuleObservationNotes` | junção só por `o.id` (PK `(id, tb_institution_id)`) ⇒ a nota saía com o texto da outra | junta pela PK inteira com a institution da REGRA (as duas tabelas são do estabelecimento — PADROES §12) |
| A6 | `bank-channel.repository.ts` `findBankChannelByInboundToken` + rota do webhook | token de outra institution do schema era aceito e processado sob a institution da URL | `c.tb_institution_id = ?` (a da URL); token de outra = a MESMA 404 do token desconhecido (corpo, cabeçalhos e nº de consultas iguais — provado) |
| B8 | `core.repository.ts` `getInstitutionInfo` (`/api/core/info`, nome no `/api/core/me`) | `WHERE schema_name = ?` + `rows[0]` sem ORDER BY ⇒ a filial via a matriz | `WHERE i.id = ? AND i.schema_name = ?` (os dois saem da MESMA linha de `tb_institution` no login — `auth.repository.ts:34-50`) |

Todos os predicados novos caem em PK ou UNIQUE (contrato `(tb_institution_id, tb_interface_id)`, observação `(id, tb_institution_id)`, canal
`uk_bank_channel_inbound`, institution `id`). Swagger dos três endpoints atualizado.

### 12.2 Testes

- `src/__tests__/grupo-leitores-d-ge4.test.ts` (11 casos) — escrito ANTES da correção: **10 vermelhos em f53a618 pelo motivo certo** (o 11º é
  o caso positivo do webhook), verdes depois. Pela superfície que NÃO muda de assinatura (serviço/HTTP), para o mesmo teste provar o antes e
  o depois.
- `src/__tests__/grupo-leitores-d-ge4-adversarial.test.ts` (27 casos) — a sonda do gate adversarial promovida a cerca.
- **Fixture `src/test-setup/two-institutions.ts`**: pool falso com as linhas das DUAS institutions (matriz 7, filial 8, `setes_acme`) que só
  aplica o filtro de institution que o PRÓPRIO SQL expressa (`scopedByInstitution`, `joinsByInstitution`, `paramOf`). Semente da fixture da
  onda 0 — a prova contra o MariaDB real segue sendo da onda 0.
- Ajustados por mudança de assinatura: `menus-kind`, `modules` (o `SCOPE` usa institution 70 — não colide com id de interface),
  `bank-channel-webhook`, `onda2-adversarial`.
- **Suíte completa: 129/129 suítes · 2034 verdes · 31 pulados** (os blocos AO VIVO da F2a, só com `F2A_ADV_LIVE=1` — as 3 suítes leem o
  `.env` só para montar a lista: na worktree rodaram com cópia temporária do `.env` da raiz, apagada ao fim). `tsc --noEmit` limpo.

### 12.3 Gates

- **Socrático 0,78 ✅** — pontos abertos: elegibilidade do menu do GRUPO pela sessão (assimetria remove × re-adiciona; rótulo "Tela não
  contratada" para tela da irmã) → Q-GE19; D-GE18 ainda não aplicada (qualquer admin edita o menu; `fetchModule` fora da transação ⇒ última
  gravação apaga o vínculo da irmã) → Q-GE20; `getRuleObservationNotes`/`findDeadRuleIds` confiam que o vínculo item × regra é do
  estabelecimento do pedido (LOW — para a cerca da onda 0); institution que muda de schema (D-GE14) ⇒ token vivo no schema velho → Q-GE21;
  menu cruza contrato POR estabelecimento × privilégio POR schema até a D-GE3.
- **Adversarial 0,84 ✅** (29 ataques, nenhum HIGH/CRITICAL). MEDIUM achado e CORRIGIDO na sessão: uma linha nova do bloco `@swagger` do
  webhook sem o ` * ` — YAML inválido, a rota sumia do `/api-docs` e a cerca `swagger-parse.test.ts` ficou vermelha (⚠️ conhecimento
  negativo: rodar a cerca do Swagger sempre que mexer em bloco `@swagger`). LOW conhecidos, sem correção: `/api/core/info` com par
  (institution, schema) incoerente responde 500 genérico (já era assim para institution inexistente; só acontece com a D-GE14 — Q-GE21); o
  `observationId` da regra não é conferido contra a institution no salvar (`tax-rules.dto.ts:29` — candidato a 422); tempo do webhook
  distingue "institution existe" (já era; ids não são segredo).

### 12.4 Questões — Rodada 3 (achadas pelo gate socrático da D-GE4; nenhuma bloqueia a onda 0)

**Q-GE19 — Elegibilidade de uma tela ao menu do GRUPO (D-GE5).** **(a)** contrato do estabelecimento da SESSÃO, como ficou na D-GE4
(conservador; o admin logado na matriz não consegue pôr de volta uma tela que só a filial contrata, e vê "Tela não contratada" para ela) ·
**(b)** UNIÃO dos contratos do grupo — `tb_institution_id IN (<institutions do schema>)` pela `@shared/group`, 2º item da lista
`GROUP_AGGREGATE_READS` (A-GE1); a EXIBIÇÃO do menu continua filtrada pelo contrato de cada estabelecimento **(Recomendado — conversa com
"menu do grupo filtrado na exibição" e com a D-GE18; entra na onda 1, com a peça)**.

**Q-GE20 — Quando a D-GE18 (só o admin do grupo edita o menu) passa a valer, e o que protege o menu até lá?** **(a)** na onda 3 (quando
o admin do grupo existir de fato), e já na onda 0 a gravação do módulo relê os vínculos atuais DENTRO da transação, com trava, para não
apagar o vínculo da irmã **(Recomendado)** · (b) tudo na onda 3.

**Q-GE21 — Institution que muda de schema (fusão de clientes, onboarding da D-GE14).** **(a)** o ato invalida as sessões vivas daquela
institution (novo login) e o par (institution, schema) do JWT que não confere vira 401 tipado, não 500 **(Recomendado — entra na onda 3)** ·
(b) só documentar.

### 12.5 Respostas do Valdo à Rodada 3 (2026-10-18)

- **D-GE19** (Q-GE19) — Valdo (literal, depois de "vincular a que exatamente?"): *"temos um cadastro de interface, para cada tela
  desenvolvido devemos criar um registro com os devidos priviegios,, essas interfaces farao parte do contrato com o cliente e os menus que o
  cliente podera ver e o modulo podera reorganiza-los"*. Regra: (1) toda tela desenvolvida nasce com o registro de INTERFACE e os seus
  PRIVILÉGIOS no catálogo; (2) as interfaces entram no CONTRATO com o cliente, e o menu mostra só o contratado; (3) a tela **Módulos só
  REORGANIZA** as telas do contrato — nunca concede nem libera tela. A leitura (b) para o grupo (união dos contratos dos estabelecimentos)
  ficou **sem objeto pela D-GE22**: o contrato é UM só, do grupo, então a lista de telas ao montar o menu = o contrato do grupo, igual em todo
  estabelecimento (as opções (a) e (b) da Q-GE19 coincidem).
  - ⚠️ **Achado ao conferir a regra (1) no dev, 2026-10-18, só leitura**: **31 das 40 interfaces do catálogo NÃO têm privilégio
    nenhum** em `tb_interface_has_privilege` — entre elas `modules` (26), `customers`, `users`, `privileges`, `interfaces`, `states`,
    `collaborators`, `categories`, `financial-plans`, `cfop`, `payment-types`, `contracts`, `salesmen`, `carriers`, `providers`, `banks`,
    `tax-rules`, `cashier`, `establishment`, `price-lists`, `services`, `service-list`, `service-tax-rules`, `settlement-rules`,
    `bank-slips`, `checks` (e as kind 'R' `partnerships`/`billing`). Os privilégios hoje são cadastrados pela tela Interfaces do Super
    (`sql/06` linha 9) e os seeds de interface não os trazem — só os de AÇÃO (`sql/51`…`sql/59`). Efeito: usuário NÃO admin não recebe
    VISUALIZAR nessas telas (o cadastro de privilégios do usuário só oferece o que a interface tem — regra da Q-G29) e a D-GE20 não tem
    o que conceder na Módulos. Tarefa própria proposta (inventário dos privilégios devidos por tela + seed + regra nas skills de módulo novo).
    → **Rodada 0 ORGANIZADA em `prompt_privilegios_interfaces.md` (2026-10-18)**: inventário das 40 telas; INSERIR/ALTERAR/EXCLUIR/IMPRIMIR
    sem consumidor nenhum (só ALTERAR em settlements); defeitos C1 ("trocar cobrança" escondido até do admin — falta ALTERAR no catálogo) e
    C2 (orders/service-orders/settlements/order-returns/bank-charge-agreements sem VISUALIZAR); zero usuário regular em produção; a Módulos
    (26) NÃO está no contrato da Setes. Ligações com esta frente: Q-PV5 (privilégios da `modules` entram com a onda 0 da D-GE20; decidir junto
    da A-GE2). Q-PV1…Q-PV9 aguardam o Valdo.
- **D-GE20** (Q-GE20) — Valdo (literal): *"o menu so se edita tendo acesso ao grupo modulos e para isso precisa ser definido no cadastro do usuario,
  sendo admin ou nao..."*. Leitura: quem edita o menu do grupo é quem tem a tela **Módulos** concedida no cadastro do usuário (privilégio),
  e não o perfil. **Revê a parte do menu da D-GE18** ("só o admin do grupo"). Consequências: hoje `/api/modules` é protegido só pelo
  `adminGuard` (`setes-api/src/gateway/router.ts:83`) e a interface `modules` não tem privilégios no catálogo (`sql/26`) ⇒ a troca para a
  guarda de privilégio entra na onda 0, JUNTO da D-GE3 (privilégio por estabelecimento — senão o privilégio da Módulos dado na matriz valeria
  na filial). A proteção técnica recomendada na Q-GE20 (reler os vínculos DENTRO da transação, com trava) segue valendo: dois usuários com a
  Módulos podem editar o mesmo menu do grupo. → **2026-10-18 (onda da D-PV2, `prompt_privilegios_interfaces.md` §11, worktree
  `privilegios-crud`, não publicada)**: a guarda por roteador existe — a troca do `adminGuard` vira UMA linha no gateway
  (`router.use('/modules', ...gatedModule('modules', modulesRoutes))`); ficou para a onda 0, junto da D-GE3. **A-GE2 RESOLVIDA (Valdo,
  2026-10-18)**: *"o admin passa como sempre (regra geral da casa); só o não admin precisa da tela Módulos concedida no cadastro do usuário
  para editar o menu"* — vale a regra geral (D-F37, D31/D32): admin e super passam o privilégio; o usuário regular precisa de V/I/A/E na
  `modules` (a licença segue valendo para todos, salvo o super — A-PV1). Sem exceção nova: a troca do `adminGuard` pelo `gatedModule` faz
  exatamente isso. Fecha a ligação com a Q-PV5 do `prompt_privilegios_interfaces.md`.
- **D-GE21** (Q-GE21 ENCERRADA, sem objeto) — Valdo (literal): *"por que um institution mudaria de schema, o isntitution so deve ver o
  proprio schema e aqui que eh previamente compartilhado via consulta, nunca o schema por inteiro"*. Uma institution NUNCA muda de schema (o grupo
  é definido de antemão — D-PR21); a institution enxerga o próprio dado + o que é compartilhado por consulta, nunca o schema inteiro (é a
  regra que a D-GE4 aplicou nos 4 leitores e que a cerca da onda 0 vai cobrar). O 500 do `/api/core/info` com par (institution, schema)
  incoerente fica como limite conhecido — o caso não nasce. A D-GE1 segue igual (a fundadora em linha única não dependia da fusão).
- **D-GE22** (Valdo, 2026-10-18, depois da explicação do que é o "menu do grupo" — literal): *"o contrato da matriz deve ser extendido para
  a filia obrigatoriamente por design"*. O **contrato de interfaces (`tb_institution_has_interface`) é do GRUPO** (PADROES §12 regra 1):
  uma só lista de telas por cliente, guardada sob a chave do grupo (a fundadora — D-GE1; "matriz" na fala do Valdo); toda filial tem
  obrigatoriamente o mesmo contrato. **Revê a D-GE5** ("filtrados pelo contrato de CADA estabelecimento" → filtrados pelo contrato do
  GRUPO, o mesmo para todos) e a classificação do inventário §4 (a linha "Configuração" deixa de incluir `tb_institution_has_interface`;
  campos e configs seguem por estabelecimento — D-GE12). A **licença** continua POR ESTABELECIMENTO (`tb_institution.active` —
  D-GE16/D-F14): contrato de telas ≠ licença. Consequências (onda 1, junto da `@shared/group`; hoje NEUTRO — chave do grupo = institution):
  1. Todo leitor do contrato passa a ler pela chave do grupo (`groupInstitutionId`): os 3 da D-GE4 (admin `listInterfacesWithGrant`, core
     `getModuleInterfaces`/`getUngroupedInterfaces`, modules `listEligibleInterfaces`/`findIneligibleInterfaceIds` — o filtro que a D-GE4
     pôs troca de parâmetro, sem mudar de forma), a guarda `institutionHasInterface` (`setes-api/src/shared/auth/require-privilege.ts:141-151`),
     `users.repository.ts:253`, `interface-vitrine.repository.ts:40,84` e **a fonte de fatos do fisco** (`fiscal-api/src/erp/facts.ts:155` —
     caminho de PRODUÇÃO da nfse-api, vai na janela com plano). Entram na lista `GROUP_TABLES` da cerca.
  2. Escritores: a tela do Super (aba Interfaces do Institution — `setInstitutionInterfaces`) grava o contrato do GRUPO — aberta numa
     filial, mostra e grava o do grupo; `grantStructuralInterfaces` (`institutions.repository.ts:275-296`) só no ato "cliente novo"
     (D-GE14), nunca no ato "estabelecimento no grupo".
  3. Gate técnico: `tb_feature_flag` (central, por institution) acompanha o contrato (decisão 17) ⇒ gravar o contrato do grupo acerta as
     flags de TODAS as institutions do grupo (ou a flag passa a ser lida pela chave do grupo — escolher na onda 1).
- **D-GE23** (Q-GE23 — a filial pode ter alguma tela A MAIS que a matriz?) — Valdo, 2026-10-18: **(a) não — um contrato só por
  grupo; se a filial precisar de uma tela, o grupo contrata e todas passam a ter.** `tb_institution_has_interface` é 100% do grupo (§12
  regra 1), sem vínculo de extras por filial; coerente com UM cliente pagador (D-GE16).
- A-GE2 RESOLVIDA (ver D-GE20): o admin passa como sempre. **NENHUMA questão aberta na frente** — próximo = onda 0.

## Decisões arquiteturais registradas

Herdadas da frente de produtos (2026-10-17): D-PR20 (frente própria; grupo = schema; chave = fundadora gravada uma vez) · D-PR21 (grupo por
decisão comercial) · D-PR22 (origem/finalidade do bem compartilhadas; condição: contador confirma origens 1×2 e 6×7) · D-PR23 (preço =
tabelas do grupo + vínculo da filial) · D-PR24 (onda 1 de produtos com 4 regras de alocação; a peça do grupo nasce aqui).

### Rodada 1 — FECHADA (Valdo, 2026-10-18: "siga as recomendações nas Q-GE1 a Q-GE17") — D-GEn = Q-GEn (a)

- **D-GE1**: a FUNDADORA (o único fato do grupo) mora numa **tabela de linha única no próprio schema** do cliente; backfill de hoje = a
  institution que já existe no schema. Nada de tabela de membros (o schema diz quem é do grupo).
- **D-GE2**: **uma tabela é do GRUPO ou do ESTABELECIMENTO, nunca das duas** — regra nova do `database/PADROES_BANCO.md` (§12) e 5ª regra
  de alocação da onda 1 do cadastro de produtos (`prompt_modulo_products.md` §11/§16).
- **D-GE3**: privilégio POR ESTABELECIMENTO — `tb_institution_id` VOLTA à PK de `tb_user_has_privilege` (coerente com a decisão 10 da Fase 2,
  o baseline e o legado; corrige a migration 003); leitores no setes-api e na fonte de fatos do fiscal-api (guards da nfse-api). Onda 0, 1º
  item — toca o caminho fiscal de PRODUÇÃO (TRANSMITIR/CANCELAR): entra por janela com plano, como a F2a.
- **D-GE4**: os leitores com defeito latente — contrato de interfaces sem filtro (`admin.repository.ts:36-93`, `core.repository.ts:149-203`,
  `modules.repository.ts:86-123`), observação fiscal juntada só por id (`billing.repository.ts:338-355`), webhook do banco só pelo token
  (`bank-channel-webhook.routes.ts:72-86`), `core.repository.ts:4-18` (`rows[0]`) — são corrigidos **JÁ, em tarefa própria** (zero DDL,
  neutro com 1 institution por schema).
- **D-GE5**: menus (`tb_module`, `tb_module_has_interface`) são do GRUPO, filtrados pelo contrato de cada estabelecimento.
- **D-GE6**: plano financeiro COMPARTILHADO (confirma a D-PR20; diverge do legado com motivo: a forma da filial aponta o plano do grupo —
  a operação aponta o catálogo).
- **D-GE7**: o vínculo das formas de pagamento (`tb_institution_has_payment_types`) segue POR ESTABELECIMENTO (TEF, parcelas e regras de
  recebimento apontam a conta corrente da filial) — diverge do legado (global) com motivo.
- **D-GE8**: FCP POR ESTABELECIMENTO, junto do MVA (um escopo só no motor) — diverge do legado (compartilhado).
- **D-GE9**: papéis de entidade (cliente, fornecedor, transportadora, colaborador, vendedor, parceria) são do GRUPO, como no legado; termos
  próprios de uma filial, se um dia precisarem, viram peça de especialização que SOMA. A frase da Fase 3 (`prompt_fase3_entidade_unica.md:48-50`,
  "o papel de cliente é POR INSTITUTION") deixa de valer para o grupo.
- **D-GE10**: o limite de crédito do cliente do grupo é comparado com a dívida do GRUPO inteiro (soma das filiais) — diverge do legado (dívida
  só da filial ativa). Consequência: leitura AGREGADA de operação — ver A-GE1 (§11, CONFIRMADA).
- **D-GE11**: o regime do EMITENTE (`simples_regime`, `simples_assessment`, `simples_total_tax_aliquot`, `special_tax_regime`, `cnae`) sai de
  `tb_entity_tax` para a peça do estabelecimento que a frente IBS/CBS já prevê (`tb_establishment_tax_regime`, D-IB7/D-IB66) — **coordenar com
  aquela frente; pré-requisito da onda 2**. `tb_entity_tax` fica só com o fiscal do PAPEL.
- **D-GE12**: configurações e campos configuráveis (`tb_institution_has_config`/`_field`) seguem POR ESTABELECIMENTO e são CLONADOS da
  fundadora quando a filial nasce.
- **D-GE13**: vínculo serviço × regra de ISS = **`tb_institution_has_service`** (estabelecimento × serviço → `tb_service_tax_rule_id`) com FK
  física carregando o `groupInstitutionId` do serviço; a coluna `tb_service.tb_service_tax_rule_id` só morre depois que o sync se adaptar.
- **D-GE14**: onboarding em DOIS ATOS sobre a mesma composição — "cliente novo" (schema novo + linha do grupo + fundadora; o 409 de schema
  em uso fica aqui) × "estabelecimento no grupo" (sem migrations, sem linha do grupo, flags e contrato estrutural reaproveitados, admins
  escolhidos entre os usuários do grupo, sem e-mail novo). O `UNIQUE schema_name` cai.
- **D-GE15**: admin do grupo = DERIVADO (admin vinculado a todas as institutions do schema), sem `kind` novo.
- **D-GE16**: licença POR ESTABELECIMENTO (decisão 9 e D-F14 seguem valendo) + o grupo é UM cliente pagador da Setes (o ato "estabelecimento
  no grupo" não cria `tb_customer` na Setes).
- **D-GE17**: ordem das ondas 0 → 1 → 2 → 3 — onboarding por ÚLTIMO (gate: condição da D-PR22 + cerca verde).
- Consequências registradas: a decisão 16 da Fase 2 ("todo tenant é tratado como institution") ganha a anotação de que o tenant (o schema)
  pode ter N institutions — o JWT não muda; a Q22 vale para regra/MVA/FCP (por estabelecimento), e o fiscal do BEM é do grupo (D-PR22).

### Rodada 2 — FECHADA (Valdo, 2026-10-18: "siga as recomendações … A-GE1 e Q-GE18 do grupo")

- **A-GE1 CONFIRMADA**: a leitura AGREGADA de operação do grupo (1º caso: o saldo em aberto do cliente somado sobre os estabelecimentos,
  para o limite de crédito da D-GE10) é `tb_institution_id IN (<institutions do schema>)` resolvido pela peça `@shared/group` — nunca "sem
  filtro"; a cerca da onda 0 ganha a lista nomeada `GROUP_AGGREGATE_READS`, e leitura agregada fora dela reprova (`PADROES_BANCO.md` §12
  regra 3).
- **D-GE18**: quem EDITA o que é do grupo — catálogo (produto, categoria, plano, tabelas de preço) e papéis: quem tem a interface + o
  privilégio em QUALQUER estabelecimento do grupo (como no legado — o dado é do grupo); a estrutura de MENU (D-GE5): só o admin do grupo
  (D-GE15, derivado).
- **Questões pendentes da frente: NENHUMA.** Próximo = onda 0 (§5, §10).
