# Skill: Guardião Conceitual (peças de lego, não maquetes)

**Quando usar**: OBRIGATÓRIA antes de criar ou alterar qualquer OBJETO DE
DOMÍNIO — tabela nova, peça shared, módulo, conceito de negócio novo —
no mesmo status do `database/skills/revisar-ddl.md` (que continua valendo
para o DDL em si; esta skill valida o CONCEITO antes do DDL existir).
**Origem**: pensamento do Valdo registrado no prompt Parceria v2
(2026-07-19) — "peças de lego sem formato final; nuvem é sempre nuvem".
**Agente par**: `setes-conceito` (entra na orquestração para modelar
conceitos novos em peças).
**Escopo**: metodo

---

## O princípio (lego / nuvem)

O ERP é altamente complexo e ramifica de infinitas maneiras. Por isso ele
NÃO é uma maquete (formato final colado); é uma caixa de PEÇAS — cada
peça carrega UM conceito estável, e cada peça nova dá mais poder ao todo.

> **Nuvem é sempre nuvem**: infinitos formatos, e qualquer um que a veja
> sabe o que é. Um objeto bem conceituado mantém a identidade em qualquer
> combinação.

**Teste da maquete** (o caso real que originou esta skill): o trio
`tb_partnership/_customer/_partner` era uma maquete — modelava "parceria"
como entidade nomeada, formato herdado de um pensamento anterior. O
conceito REAL era a ANGARIAÇÃO (colaborador trouxe o cliente): UMA tabela
flat, e a regra de unicidade que a maquete exigia morreu POR CONSTRUÇÃO.
Quando a modelagem precisa de guardas para não se contradizer, desconfie:
provavelmente é maquete.

## Checklist do conceito (responder ANTES de modelar)

1. **Qual é o conceito ÚNICO deste objeto?** Uma frase, sem "e". Se
   precisar de "e", são duas peças.
2. **Ele nasce de quê?** (a Parceria nasce da angariação, não de um
   cadastro; o título nasce do faturamento; o movimento nasce da baixa.)
   Objeto que "nasce por criar um registro" sem fato gerador é suspeito.
3. **É peça ou composição?** Peça: não importa outras peças (address,
   phone, fiscal). Composição: SÓ combina peças (entity-fiscal,
   saveEntityFiscalChain). Nunca os dois.
4. **Sobrevive sozinho e combina sem ser alterado?** Peça boa entra em
   arranjo novo sem ganhar coluna/parâmetro "para o caso X".
5. **Alguma regra de aplicação existe só para impedir a estrutura de se
   contradizer?** (ex.: "cliente em só 1 parceria viva") → a estrutura
   está errada; refaça até a regra morrer por construção.
6. **Quando surgir o conceito irmão, ele AGREGA ou REFORMA?** Se a
   resposta é reformar esta peça, ela está no formato errado hoje.

## Inventário das peças existentes (combine antes de inventar)

| Peça/padrão | Conceito único | Onde |
|---|---|---|
| Cadeia de entidade fiscal | UMA pessoa/empresa, N papéis | `@shared/entity` + peças address/phone/social-media/fiscal |
| Papel local (customer/collaborator/...) | O que a entidade É para a institution | tb_<papel> (PK id+institution, herança por PK) |
| Catálogo × valor | Intrínseco do produto × escolha do cliente | tb_interface_has_field/config × tb_institution_has_* |
| Catálogo central iniciado pelo cliente | Compartilhado com dedupe por descrição | tb_payment_types (molde `@shared/payment-types`) |
| Referência central | Fato do mundo (não muda por cliente) | tb_country, tb_cfop, tb_bank |
| Backbone + ramos | UMA operação, N naturezas | tb_order + tb_order_<ramo> (id compartilhado) |
| Natureza por PRESENÇA × processo por ATO | O ramo diz "o que a operação é"; o processo diz "sob que ciclo ela está" — produtores diferentes, tabelas diferentes | tb_order_service (natureza: venda com serviço, sync, OS) × tb_service_order (ciclo da OS — só o módulo grava; migration 047, 2026-09-09). Sintoma de maquete: coluna com 3 significados vindos de 3 produtores (o `number` da natureza) e identidade por AUSÊNCIA de outro ramo |
| Detalhe universal + especialização | Item genérico × natureza do item | tb_order_item + tb_order_item_merchandise |
| Financeiro imutável | Dinheiro não se apaga — inverte | payment/statement N/E/R + settled_code N:1 |
| Vínculo N:N com atributos | Relação institution × catálogo | tb_institution_has_<x> |
| Peça transaction-aware | Regra reusável dentro de transação | funções (conn, ...) em `src/shared/` |
| Composição sobre peças | SÓ combina peças, com a POLÍTICA que não pode bifurcar entre chamadores | `@shared/entity` (cadeia fiscal) · `@shared/title-automation` (desfecho que a FORMA dá à parcela recém-nascida: baixa por contrato × boleto automático; 2026-09-13). Sintoma de recorte errado: precisar de um parâmetro `bloqueia: true/false` para caber um irmão — foi por isso que o CHEQUE ficou de fora |
| 3 tipos de tela | lista+form × árvore × processo | skills criar-formulario-cadastro / tela-de-processo |

## Palavras já OCUPADAS (consulte antes de nomear)

Palavra reusada em conceito novo é como coluna com três significados: o leitor
não sabe qual. Esta lista nasceu da rodada "contrato" (Valdo, 2026-09-13): a
palavra tinha SEIS sentidos, três visíveis ao usuário, e a colisão só apareceu
quando duas telas ficaram lado a lado no menu.

| Palavra | Já significa | Se o seu conceito novo for parecido |
|---|---|---|
| **contrato** | (1) mensalidade do cliente `tb_contract` · (2) contrato COMERCIAL das telas `tb_institution_has_interface` ("Contrato de interfaces") · (3) contratação de cobrança com o banco `tb_bank_charge_agreement` · (4) `tb_bank_account.dt_contract` · (5) contrato de API (comentários) | NÃO use. Previsão configurada = `_rule`; vínculo = `_has_`; acordo com terceiro = `_agreement` |
| **regra** (`_rule`) | previsão configurada que o motor consulta: `tb_tax_rule`, `tb_service_tax_rule`, `tb_settlement_rule` | use para "o que o sistema deve presumir até o fato acontecer" |
| **ordem** (`tb_order`) | backbone de QUALQUER operação (venda, compra, OS, ajuste) | ramo novo entra como `tb_order_<ramo>`, nunca como tabela paralela |
| **conta** | `tb_bank_account` (corrente) × `tb_cashier` (caixa) × header `x-conta-corrente` do Inter (derivado da corrente — D-I14) | diga qual |
| **registro / registrar** | (1) apresentação do boleto ao BANCO por API `tb_bank_slip_registration` (Onda 2 Inter) · (2) "registro" = linha de tabela em comentários antigos · (3) `dt_record` das baixas · (4) **registro FISCAL** (NE-1a, D-NE56): `authority_recorded` = o FISCO registrou o documento da tentativa, em qualquer ambiente (fato publicado na view da família — NFS-e: chave presente; NF-e: protocolo) × `isFiscalRecord` = registrado E em produção (Q-CA5) | boleto "registrado" é o que o banco ACEITOU (evento `G`); documento fiscal "registrado" é o fato da view, NUNCA a presença da chave (na NF-e a chave é nossa desde a reserva); nunca use para "gravei no banco de dados" |
| **família (fiscal)** | o RAMO da nota no `fiscal_api` (`InvoiceBranch` = `service` × `merchandise`): tabelas, views, lista de escrita da voz e regras de leitura POR família (`VoiceFamilyReading`, `VoiceFamily<K>`); 55 e 65 são a MESMA família (mercadoria). Cerca, emissão e aluguel são por MODELO (a linha da habilitação) — NE-1a | nunca vira coluna; não confundir com "modelo" (SE/55/65) nem com "família de produto" |
| **canal** | `tb_bank_account_channel` = a conta corrente fala com o SEU banco por API (segredos + ambiente + token de entrada; D-I3/D-I4) | não é "canal de venda", nem "canal de atendimento"; integração nova com banco = adaptador no MESMO canal |
| **apresentação** | 1 boleto × N tentativas de registro no banco (`attempt`); o banco responde com a VOZ dele (`_registration_event`, append-only) — estado DERIVADO do último evento | "reapresentar" = nova tentativa, nunca UPDATE da anterior |
| **integração** | palavra de comentário, não de tabela: o que existe é `canal` (conta×banco) + `adaptador` (`@shared/bank-channel/adapters/<banco>`) + `apresentação` (o fato) | não crie `tb_integration*`; diga qual das três peças |
| **segredo** | `@shared/secret-store`: arquivo em `SECRETS_PATH/<schema>/<owner>/<id>/<S|P>/<name>` (D-I1: dono + finalidade; certificado mTLS do canal ≠ certificado A1 do emissor fiscal — este é único por estabelecimento, pasta `P` fixa, D-N31) | nunca coluna de tabela, nunca no JSON de resposta — a tela só vê PRESENÇA + validade |
| **emissor** | `tb_establishment_issuer` = a HABILITAÇÃO do estabelecimento para falar com um fisco, por MODELO do documento (SE · 55 · 65): ambiente + série + contador `dps_last_number` (Onda 3, D-N4/D-N18); a AUTORIDADE é derivada do modelo, nunca coluna; o A1 é UM por ESTABELECIMENTO no cofre — serve a todos os modelos e aos dois ambientes do fisco (D-N31, 2026-09-28; o ambiente congela só o HOST da tentativa). `tb_invoice.issuer` (institution que emitiu a nota) é OUTRA coisa | não é "quem emite a nota" (isso é `issuer` da nota) nem "emitente" do DPS (`prest` = a institution como pessoa jurídica). Modelo novo = linha nova, nunca coluna nova |
| **transmissão** | `tb_invoice_service_transmission` = 1 nota × N tentativas (`attempt`) de apresentar o DPS ao fisco, no ambiente CONGELADO da tentativa (D-N6); estado DERIVADO do último evento (`_transmission_event`). Irmã da "apresentação" do boleto — a mesma peça de método, outro terceiro | "retransmitir" = nova tentativa (nova vida = novo nDPS/Id), nunca UPDATE; nada de `status` em coluna |
| **voz (do fisco / do banco)** | evento append-only que o TERCEIRO produziu: `_transmission_event` A/R/F/C/K/N + `_registration_event` do boleto; `source` P (pedido) · Q (consulta) · W (webhook). Só a voz muda estado; o efeito local (C da nota, L do boleto) é aplicado pela composição em SAVEPOINT e nunca inventado | "gravei um evento" sem resposta do terceiro NÃO é voz: é K (em voo) ou F por recusa explícita — 2xx ilegível é AMBÍGUO (502), nunca aceite |
| **autoridade** | o fisco (ADN/Sefin Nacional para SE; SEFAZ para 55/65) atrás de `@shared/tax-authority` (adaptador por autoridade, vocabulário único em `types.ts`) — derivada do modelo pelo emissor | não confundir com privilégio/autorização do usuário (`require-privilege`) nem com "autorizada" (evento A da transmissão) |
| **chave** | (1) chave de ACESSO da NFS-e/NF-e (50/44 dígitos, cunhada pelo fisco/por nós — `access_key`) · (2) chave PRIVADA do par PEM no cofre · (3) `tb_sync_api_key` do sincronizador · (4) chave primária em comentários | diga qual: `accessKey` só com o tamanho exato (o adaptador recusa o resto); chave privada nunca sai do cofre |
| **virada** | (extração fiscal, D-F39) o FATO "a emissão deste estabelecimento passou do ERP para a API fiscal no instante T" — `tb_establishment_issuer.cutover_at` no `fiscal_api`, write-once e monotônico (NULL → instante, nunca volta); o ato é por INSTITUTION (`migrate:setes --cutover`) | não use para "troca de ambiente H→P" (isso é a habilitação mudando de ambiente) nem para "migração de dados"; reversão = decisão nova e outra forma (evento) |
| **réplica** | linha SE do `fiscal_api` COPIADA da origem pelo `migrate:setes` enquanto o ERP emite (`cutover_at` NULL) — só SE (D-F42; a 55/65 nasce virada na nfe-api): só leitura para a API — abrir emissor, cunhar nDPS, tomar aluguel e escrever o emitente recusam | não confundir com "cópia de segurança" nem com replicação de banco |
| **série** | DOIS conceitos: a **série da NOTA** (`tb_invoice.serie` — ERP, cunhada no faturamento pela linha do modelo em `tb_establishment_issuer` do ERP, default '1'; D-F21) × a **série do DPS** (`tb_establishment_issuer.serie` do `fiscal_api`, compõe o Id do DPS — D-F30) | diga SEMPRE qual; no ERP a linha 55/65 da habilitação é só série da nota (D-F42/D-F44) |
| **dispensa** (`tb_invoice_cancel_waiver`) | decisão HUMANA de MANTER a nota cuja NFS-e o fisco cancelou por SUBSTITUIÇÃO (e105102) — fato da NOTA (nota × chave; motivo + autor), nunca coluna da voz do fisco; só em produção; é HISTÓRIA: os leitores só a mostram como decisão vigente com a nota viva (D-F67/D-F80/D-F81, 2026-10-10) | NÃO use para isenção, perdão de dívida, desconto nem "desativar a cobrança" (ato futuro, B09 do legado); decisão humana nova sobre um fato de terceiro = fato próprio do objeto decidido |
| **custódia** | estado `custody` do CHEQUE (`@shared/check` — em mãos da empresa) | NÃO use para "quem detém a emissão" (isso é a **virada**) nem para guarda de segredo (isso é o **cofre**/`secret-store`) |
| **competência** | DOIS sentidos: (1) o mês do CONTRATO (`tb_contract_item_competence.competence`, 'YYYY-MM' — idempotência da rotina mensal, D-A29) × (2) a competência FISCAL da nota = `dCompet` do DPS = `tb_invoice.dt_emission` (o dia do faturamento — D-IB64) | diga SEMPRE qual; parâmetro de peça fiscal = `competenceDate`, nunca `competence` solto; a competência do contrato NUNCA é data fiscal (maquete nº 7 da IB-2) |
| **classificação / presunção / declaração (IBS/CBS)** | **classificação** = a LINHA do cClassTrib no catálogo central (`tb_tax_ibscbs_classification*`, com vigência); **presunção** = o que o CADASTRO do serviço presume (`tb_service_ibscbs` + `tb_service.nbs` — peça `@shared/service-ibscbs`); **declaração** = o trio cClassTrib + cIndOp + NBS que a NOTA apresenta ao fisco, congelado no ramo `tb_invoice_service` (IB-2, D-IB62/D-IB71) | o serviço "tem" presunção, a nota "leva" declaração; ausência da declaração antes da obrigação NÃO é fato (nunca coluna de motivo — D-IB65) |
| **regime** | (1) `tb_entity_tax.tax_regime` = CRT (serve também ao DESTINATÁRIO — motor de mercadoria) × (2) o ENQUADRAMENTO inteiro do emitente (opSimpNac, regApTribSN, regApIBSCBSSN) — peça datada `tb_establishment_tax_regime` quando nascer (D-IB7/D-IB66) | diga qual; "regime regular" do IBS/CBS (opção CGSN 194) é um TERCEIRO sentido |
| **barreira** | (APIs fiscais / F2a, D-F141) o bloco TIPADO `fiscal.barrier` do plano de cancelamento — o que a voz do fisco impede de cancelar (e o predicado do rodízio) | NÃO use para a obrigação legal do grupo IBS/CBS — essa é `ibscbsObligationStart` (constante datada da peça de classificação, D-IB13/D-IB66); nem "obrigações do DPS" (= Anexo I) |
| **critério (pesquisa)** | definição de um critério da PESQUISA AVANÇADA de uma lista: `SearchCriterion` (key, kind, labelKey, expr, lookup?, options?) declarada no `<m>.repository.ts` e servida sem `expr` por `GET /api/<m>/search-criteria`; os valores do usuário são `SearchCriteriaValues` / `?criteria=<json>` (prompt_pesquisa_avancada.md, D-BA14) | não é "campo" (`tb_interface_has_field`, `fields[]` do erro) nem "filtro" (o texto rápido `filter`); o operador é da peça pelo `kind`, nunca do módulo |
| **unidade de venda** (`tb_merchandise_trade_unit`) | um NÍVEL da mercadoria: unidade (`tb_measure`) × FATOR em unidades-base × GTIN próprio (nível 1 = base, fator 1); a mercadoria DESIGNA qual nível é o tributável e qual é o vendido por omissão (prompt_modulo_products.md §12, D-PR15/D-PR16, 2026-10-17) | não é "unidade de medida" (`tb_measure` — CX de 12 e CX de 24 são a mesma medida) nem "embalagem" (`tb_package`, descritiva); a caixa com GTIN-14 é OUTRO nível do MESMO produto, nunca outro produto |
| **GTIN × código de barras** | **GTIN** = código GS1 (8/12/13/14 + DV) que vai no `cEAN`/`cEANTrib` da NF-e — fato do NÍVEL da unidade de venda; **código de barras próprio** (balança, prefixo 2, circulação restrita) vai no `cBarra` e NÃO vale como GTIN (D-PR17) | o `tb_stock.codebar` do legado mistura os dois; ausência de GTIN = NULL, o literal "SEM GTIN" é só do XML |
| **`_list` (depósito × tabela de preço)** | `tb_stock_list` = DEPÓSITO (onde a mercadoria está) × `tb_price_list` = TABELA DE PREÇO (por quanto se vende) | diga qual; nunca "lista" solta |
| **published** | no produto, `published` = publicar na INTERNET (`PRO_INTERNET` do legado, mapeamento de 2013) — flag de e-commerce; default 'N' no cadastro web (D-PR29, 2026-10-18) | não é "disponível para venda" (isso é `active`); lookup de pedido NUNCA filtra por ele |
| **grupo (de estabelecimentos)** | (frente matriz × filiais — `prompts/prompt_frente_grupo_estabelecimentos.md`, D-PR20/D-PR21) o conjunto de estabelecimentos que um cliente da Setes opera sob um mesmo compartilhado = o CLIENTE por decisão comercial = o SCHEMA `setes_<cliente>`; o único fato próprio do grupo é a FUNDADORA (gravada uma vez); a "chave do grupo" é o id dela — nome proposto `groupInstitutionId` (Rodada 0); **uma tabela é do grupo OU do estabelecimento, nunca das duas** (Q-GE2) | não é "grupo econômico", nem a raiz do CNPJ, nem "a matriz é dona" (fundadora ≠ matriz ≠ licenciado); não confundir com grupo/subgrupo do legado (= categoria raiz/filha); "chave do grupo" é o 5º sentido de **chave** |

**Lição de método da rodada**: a D15 daquela fase tinha MANTIDO um nome ruim
**em troca** de uma condição ("o rótulo da tela deve distinguir"). A condição
não foi cumprida na entrega, e um ano-luz depois a confusão apareceu como se
fosse erro de modelagem. **Decisão com condição embutida precisa virar item de
verificação da entrega** — senão a troca vira só a metade cara.

## Checklist de nomenclatura

- O NOME é o conceito, não o formato: `tb_partnership` (o acordo), nunca
  `tb_partnership_customer_link`. Inglês, singular, `tb_`.
- Papel ≠ entidade (customer é papel; entity é a pessoa). Catálogo ≠
  vínculo ≠ processo — o leitor sabe qual é pelo nome/lugar.
- Colunas de FK: `tb_<tabela>_id`; discriminadores em `char(1)` com
  domínio documentado no DDL.
- Módulo/URL/tela espelhados: `/api/<m>` = `/home/<m>` = pasta.
- Se o nome precisa de comentário para ser entendido, o nome está errado.

## Saída esperada

Parecer curto: **conceito** (1 frase) · **peça ou composição** ·
**peças reusadas** · **o que NÃO entrou** (e por quê) · **nomes**.
Divergência conceitual = parar e discutir com o Valdo (decisões dele
nunca se perdem).
