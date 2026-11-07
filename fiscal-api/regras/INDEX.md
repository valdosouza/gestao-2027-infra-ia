# fiscal-api/regras — registro de regras fiscais com ID estável e a matriz legado × web

**Escopo**: método
**Criado em**: 07/11/2026, por decisão do Valdo: o ERP Desktop (legado, vivo até os clientes migrarem) e o sistema web reaproveitam o mesmo conhecimento de NF-e e NFS-e; **conhecer → planejar → organizar a execução → só então o código.** Casa única: `Infra-IA/fiscal-api`.

## O que há aqui

| Arquivo | Para quê |
|---|---|
| [`REGRAS.md`](REGRAS.md) | O **catálogo**: cada regra lida da norma ou provada em homologação, com ID estável, fonte, vigência e grau (T texto, L leitura nossa, E empírico, N não verificado) |
| [`MATRIZ.md`](MATRIZ.md) | A **matriz**: o estado de cada regra no legado e na web (L, D, I, T, H, P), as divergências entre os dois lados e a ação proposta, e as decisões de produto lado a lado |
| [`../fontes/INDEX.md`](../fontes/INDEX.md) | As fontes oficiais (acervo único) |
| `../01-…`, `../02-…`, `../03-…` | A leitura por extenso: base de cálculo e transição, conta "por dentro", NFS-e |

## Regras de uso

1. **Antes de pesquisar, decidir ou codificar um assunto fiscal, procure o ID aqui.** Se a regra existe, use a leitura e a prova que já estão registradas; se não existe, acrescente.
2. **ID novo = próximo número da área.** O ID nunca muda e nunca é reaproveitado. Regra que cai vira "(revogada em AAAA-MM-DD)" na mesma linha.
3. **Toda regra cita a fonte** (artigo, NT, anexo, regra de validação) e o **grau**. Prova em homologação ou produção entra como **E**, com a data e o documento de teste.
4. **A decisão de produto não mora no catálogo.** Cada sistema decide e cita o ID da regra (D-EM e D-AP no legado, D-IB, D-F e D-NE na web). A diferença entre as decisões aparece na matriz.
5. **Quem mexe no estado de uma regra num dos lados atualiza a matriz no mesmo commit.** A matriz tem a data da última conferência de cada lado no cabeçalho; `?` quer dizer que ninguém conferiu.
6. **Dado sensível nunca entra** (senha, token, certificado, CNPJ ou e-mail de cliente). Documentação e código são livres (Valdo, 07/11/2026).

## Áreas e contagem em 07/11/2026

CAL 8 · BC 5 · PRC 8 · SN 13 · DEV 4 · CLS 5 · NFS 9 · NFE 4 — **56 regras**.

## O que vem depois (peças combinadas)

1. ~~**Vetores de teste neutros**~~ — **feito em 07/11/2026**: [`../vetores/INDEX.md`](../vetores/INDEX.md), 6 arquivos JSON com 100 casos para **15 das 56 regras** (a coluna "Vetor" do catálogo aponta para cada um), lidos pelo teste do Delphi e pelo da web; verificação 69/69. Faltam vetores para as demais regras.
2. ~~**Calendário único de fatos com data**~~ — **feito em 07/11/2026**: [`../calendario/INDEX.md`](../calendario/INDEX.md), 55 fatos (obrigatoriedade, leiaute, transição por ano e marcos), verificados contra o catálogo; os vetores de obrigatoriedade e de leiaute já leem daí. Falta cada lado adotar o calendário com um teste de contrato (divergência 6 da matriz).
3. **Fichas de implementação** por entrega, cada uma dizendo a regra (ID), a decisão de produto, o arquivo e a função onde mora em cada lado, os testes e o critério de pronto.
