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
| Detalhe universal + especialização | Item genérico × natureza do item | tb_order_item + tb_order_item_merchandise |
| Financeiro imutável | Dinheiro não se apaga — inverte | payment/statement N/E/R + settled_code N:1 |
| Vínculo N:N com atributos | Relação institution × catálogo | tb_institution_has_<x> |
| Peça transaction-aware | Regra reusável dentro de transação | funções (conn, ...) em `src/shared/` |
| 3 tipos de tela | lista+form × árvore × processo | skills criar-formulario-cadastro / tela-de-processo |

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
