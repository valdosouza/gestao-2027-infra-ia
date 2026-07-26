# Skill: Guardião Conceitual (peças de lego, não maquetes)

**Quando usar**: OBRIGATÓRIA antes de criar ou alterar qualquer OBJETO DE DOMÍNIO —
tabela nova, peça compartilhada, módulo, conceito de negócio novo. Esta skill valida
o CONCEITO antes de qualquer DDL/código existir. Em modernização de legado, é a Fase 2:
destilar o conceito real de negócio da casca do sistema antigo.
**Escopo**: metodo

---

## O princípio (lego / nuvem)

Um sistema de negócio é altamente complexo e ramifica de infinitas maneiras. Por isso
ele NÃO é uma maquete (formato final colado); é uma caixa de PEÇAS — cada peça carrega
UM conceito estável, e cada peça nova dá mais poder ao todo.

> **Nuvem é sempre nuvem**: infinitos formatos, e qualquer um que a veja sabe o que é.
> Um objeto bem conceituado mantém a identidade em qualquer combinação.

**Teste da maquete** (caso real do caso zero, anonimizado): um trio de tabelas modelava
"parceria" como entidade nomeada com estrutura própria — formato herdado do sistema
anterior. O conceito REAL era muito mais simples (um vínculo direto entre duas partes
com um percentual): UMA tabela flat — e a regra de unicidade que a maquete exigia
("parte só pode estar em 1 parceria viva") **morreu por construção**. Quando a
modelagem precisa de guardas para não se contradizer, desconfie: provavelmente é maquete.

**Em legado, a maquete é a regra, não a exceção**: 30 anos de sistema acumulam formatos
de decisões que já morreram. O trabalho da Fase 2 é perguntar a cada estrutura antiga:
"qual conceito você estava tentando expressar?" — e modelar O CONCEITO, não a estrutura.

## Checklist do conceito (responder ANTES de modelar)

1. **Qual é o conceito ÚNICO deste objeto?** Uma frase, sem "e". Se precisar de "e",
   são duas peças.
2. **Ele nasce de quê?** Todo objeto de negócio tem um FATO GERADOR (o título nasce do
   faturamento; o movimento nasce da baixa). Objeto que "nasce por criar um registro"
   sem fato gerador é suspeito.
3. **É peça ou composição?** Peça: não importa outras peças. Composição: SÓ combina
   peças. Nunca os dois.
4. **Sobrevive sozinho e combina sem ser alterado?** Peça boa entra em arranjo novo
   sem ganhar coluna/parâmetro "para o caso X".
5. **Alguma regra de aplicação existe só para impedir a estrutura de se contradizer?**
   → a estrutura está errada; refaça até a regra morrer por construção.
6. **Quando surgir o conceito irmão, ele AGREGA ou REFORMA?** Se a resposta é reformar
   esta peça, ela está no formato errado hoje.

## Inventário de peças (construa o do SEU caso)

Mantenha na base de conhecimento uma tabela viva: **peça/padrão → conceito único →
onde vive**. Antes de inventar peça nova, combine as existentes. Padrões que se
repetem entre casos (semente para o inventário do caso novo):

| Padrão | Conceito único |
|---|---|
| Entidade única × papéis | UMA pessoa/empresa no mundo; N papéis por contexto (cliente, fornecedor, colaborador) |
| Catálogo × valor | O que é intrínseco do produto × o que é escolha de cada cliente/instância |
| Referência central | Fato do mundo que não varia por cliente (país, banco, código fiscal) |
| Backbone + ramos | UMA operação, N naturezas (documento único com especializações por tipo) |
| Detalhe universal + especialização | Item genérico × atributos da natureza do item |
| Histórico imutável | O que tem valor legal/financeiro não se apaga — inverte-se com trilha (evento de estorno referencia o original) |
| Vínculo N:N com atributos | A relação entre duas peças é ela mesma uma peça (com seus próprios atributos) |

## Checklist de nomenclatura

- O NOME é o conceito, não o formato nem a origem legada. Se o nome precisa de
  comentário para ser entendido, o nome está errado.
- Papel ≠ entidade; catálogo ≠ vínculo ≠ processo — o leitor sabe qual é pelo nome/lugar.
- Nomenclatura do legado NUNCA vaza para o sistema novo em conteúdo visível (banco,
  telas, i18n); legado só aparece em documentação interna de mapeamento.
- Registre as convenções do caso (prefixos, idioma, singular/plural, FKs,
  discriminadores) num doc de padrões — e cite-o em toda revisão.

## Saída esperada

Parecer curto: **conceito** (1 frase) · **peça ou composição** · **peças reusadas** ·
**o que NÃO entrou** (e por quê) · **nomes**. Divergência conceitual = parar e discutir
com o dono do produto (decisões dele nunca se perdem — ver `rodadas-de-decisao.md`).
