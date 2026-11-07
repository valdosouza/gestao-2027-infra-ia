# fiscal-api/processo — mapa único do processo de NF-e, NFC-e e NFS-e

**Escopo**: método (o processo segundo a norma e o estado de cada implementação; nada de cliente, credencial nem dado pessoal)
**Criado em**: 07/11/2026, por pedido do Valdo: "precisamos deste processo mapeado como material único para depois planejarmos o que fazer no ERP Desktop primeiro e depois reaproveitar o material e o conhecimento adquirido para fazer na web".
**Companheiros**: [`NFE.md`](NFE.md) (NF-e modelo 55 e NFC-e modelo 65), [`NFSE.md`](NFSE.md) (NFS-e), [`../regras/REGRAS.md`](../regras/REGRAS.md) (as regras da Reforma, com ID), [`../vetores/INDEX.md`](../vetores/INDEX.md), [`../calendario/INDEX.md`](../calendario/INDEX.md), [`../fontes/INDEX.md`](../fontes/INDEX.md).

## O que este material é (e o que não é)

- **É o mapa do processo inteiro**, etapa por etapa, do cálculo do item até a guarda do documento: o que a norma exige, onde está a fonte no acervo, quais regras do catálogo (RF) se aplicam, o que o **ERP Desktop** faz hoje (separando o que é do **Gestão em Delphi** do que é do **ACBr**) e o que a **web** tem ou planeja (qual componente).
- **Serve a duas decisões, nesta ordem:** (1) o que fazer primeiro no ERP Desktop (as lacunas e riscos de cada etapa estão marcados); (2) como reaproveitar, na web, o conhecimento e o material (a norma, as regras, os vetores e o calendário são os mesmos; o que muda é quem implementa).
- **Não é** um plano nem uma decisão: a priorização é o passo seguinte, com o Valdo. Também **não substitui o oficial**: onde a fonte oficial não está no acervo, a célula diz isso.

## Como ler

- Cada documento tem uma **tabela-resumo** (uma linha por etapa, para ordenar por lacuna) e, abaixo, **notas por etapa** onde há detalhe que não cabe na célula.
- **Etapa** = `PR-NFE-NN` (NF-e e NFC-e) ou `PR-NFS-NN` (NFS-e). O ID nunca muda e nunca é reaproveitado.
- **Norma:** onde o processo está descrito na fonte oficial arquivada (capítulo do MOC, NT, manual, resolução) e, quando a base legal não está no acervo, **"lei-base a trazer"**.
- **RF:** regras do catálogo `../regras/REGRAS.md` que tocam a etapa.
- **Gestão / ACBr / Web:** o estado em cada implementação: **I** implementada · **P** parcial · **—** ausente · **?** não verificado · **plano** só planejada, sem código. Para a web, o componente entre parênteses.

## Fontes do mapa (e o grau de confiança)

| Lado | De onde veio | Confiança |
|---|---|---|
| Processo oficial da NF-e | Sumário do MOC 7.00 (Visão Geral, Anexos I a III) e as NTs do acervo `../../nfe-api/integracoes/nfe-sefaz/` | Alta para a estrutura; o detalhe de cada serviço está no MOC e nos XSD |
| Processo oficial da NFS-e | Resolução CGNFS-e 3/2023, manuais da API do contribuinte e do ADN, anexos I e II, NT 008 e 009 (acervo `nfse-adn/`) | Alta para a estrutura |
| Gestão (Delphi) e ACBr no legado | Inventário de leitura do código de `D:\Gestao2016` e do ACBr instalado (trunk2 r48887), feito em 07/11/2026 com `arquivo:linha`; o estado é "o que o código mostra", não "o que foi testado em produção" | Média: confirmar pontos críticos antes de decidir |
| Web | Índices da `nfse-api` e da `nfe-api`, prompts das ondas e o código lido em 07/11/2026 (estado até 01/11/2026 no que vem dos prompts) | Média |

## A legislação-base que NÃO está no acervo (a trazer)

O acervo tem as Notas Técnicas, o MOC, os XSD e os manuais, mas **nenhum texto da legislação-base do processo**. Para o mapa ficar "segundo a legislação" (e não só segundo as NTs), faltam:

| Documento | Para que etapas | Observação |
|---|---|---|
| Ajuste SINIEF 07/05 (institui a NF-e) e suas alterações | PR-NFE-01 a PR-NFE-16 (obrigações do emitente, cancelamento, guarda, DANFE) | O MOC cita; o texto primário não está |
| Ajuste SINIEF 19/16 (institui a NFC-e) | PR-NFE-14 | idem |
| Convênios ICMS e RICMS do Paraná (CFOP, CST, base, ST, DIFAL, FCP) | PR-NFE-01 e PR-NFE-13 | Hoje a tributação do item não tem fonte primária no acervo |
| LC 87/96 (Kandir) e LC 24/75 (convênios) | PR-NFE-01 | base do ICMS |
| LC 116/2003 (ISS e lista de serviços) | PR-NFS-03 | A lista existe como Anexo B do ADN, o texto da lei não |
| Código Tributário Nacional (decadência, guarda) | PR-NFE-15, PR-NFS-10 | prazos de guarda |
| Leis municipais do ISS dos municípios atendidos (alíquota, retenção, local de incidência) | PR-NFS-03, PR-NFS-12 | por município; só o de Curitiba tem manual no acervo |
| Guia Prático da EFD ICMS/IPI e da EFD Contribuições | PR-NFE-15 | integração com o SPED |

Quem for baixar segue a regra do manifesto: **uma vez só, na Infra-IA, com origem, data e SHA-256** (`../fontes/INDEX.md`).

## Fora deste mapa

MDF-e, CT-e e demais documentos eletrônicos; NFS-e Via (exploração de via); apuração e escrituração (a frente de apuração está nos planos do ERP Desktop). Entram quando o Valdo pedir.
