# fiscal-api/vetores — vetores de teste neutros das regras fiscais (legado e web leem os mesmos)

**Escopo**: método (entrada e saída esperada de cada regra; nada de cliente, credencial nem código de produto)
**Criado em**: 07/11/2026, por decisão do Valdo: o ERP Desktop (legado) e o sistema web reaproveitam o mesmo conhecimento fiscal; conhecer → planejar → organizar a execução → só então o código.
**Companheiros**: [`../regras/REGRAS.md`](../regras/REGRAS.md) (o enunciado de cada regra; a coluna "Vetor" aponta para cá), [`../regras/MATRIZ.md`](../regras/MATRIZ.md) (o estado de cada lado).

## A ideia

Cada regra fiscal que tem resposta numérica ou lógica ganha **casos de teste em JSON**: entrada, saída esperada, grau da prova e fonte. O teste do ERP Desktop (Delphi) e o da web (TypeScript) **leem o mesmo arquivo**: se os dois passam, os dois implementam a mesma regra, sem ninguém reescrever o exemplo à mão. Quando o fisco mudar uma regra, muda-se o vetor uma vez e os dois lados acusam.

## Os arquivos (56 regras no catálogo; 15 têm vetor hoje)

| Arquivo | Função testada | Regras | Casos |
|---|---|---|---|
| [`conta-por-dentro.json`](conta-por-dentro.json) | Item de NF-e do regime normal com o preço final: ICMS, base do IBS/CBS, IBS, CBS e `vProd`, fechando em centavos | RF-PRC-02, RF-PRC-03, RF-PRC-04, RF-BC-04 | 48 (os 8 do documento 02, com o exemplo da SEFA-PR, mais 40 gerados com semente fixa) |
| [`nfse-vtotnf.json`](nfse-vtotnf.json) | `vTotNF` da NFS-e com IBS e CBS por fora, por regime e ano | RF-PRC-08 | 10 (9 da regra E1555 e 1 observado em H) |
| [`nfse-simples.json`](nfse-simples.json) | `vReceitaBrutaSN` e presença do grupo `gTribSN` | RF-SN-10, RF-SN-11 | 7 + 8 |
| [`obrigatoriedade.json`](obrigatoriedade.json) | A partir de que competência a declaração de IBS/CBS é obrigatória, por documento e regime; e 2 casos **observados em H** (E0855 não recusa o Simples; `<gIBSCBS/>` vazio é aceito) | RF-CAL-03, RF-CAL-04, RF-NFS-07, RF-CLS-02 | 11 + 2 |
| [`leiaute-nfse.json`](leiaute-nfse.json) | Qual pacote XSD a autoridade aceita por documento, ambiente e instante | RF-NFS-02, RF-NFS-03 | 6 |
| [`nfe-diversos.json`](nfe-diversos.json) | `vBC` da NF-e (UB16-10), CST como prefixo do `cClassTrib` (E0959), chave referenciada na devolução (VC02-14) | RF-BC-03, RF-CLS-02, RF-DEV-03 | 6 + 5 + 3 |

## Formato

- Cada arquivo tem `funcao`, `versao`, `regras` (os IDs do catálogo), `convencao`, `descricao` e uma ou mais listas `casos…`. Cada caso tem `id`, `descricao`, `grau` (**T** escrito na norma · **L** leitura nossa · **E** observado em homologação ou produção), `fonte`, `entrada` e `saida`.
- **Valores e alíquotas são strings decimais**, nunca número JSON, para não perder precisão: `"123.64"`, `"0.12"` (= 12%). Reais com 2 casas. Datas `AAAA-MM-DD`; instantes em UTC `AAAA-MM-DDTHH:MM:SSZ`. Campo sem valor é `null`.
- A **ordem dos campos de saída não importa**; compare cada campo.

## Como ler no Delphi e na web (a implementar em cada produto, fora desta pasta)

- **Delphi 10.2 (ERP Desktop):** `System.JSON` (`TJSONObject.ParseJSONValue` sobre o texto do arquivo em UTF-8). Converta as strings com `TFormatSettings.Invariant` para `Currency` (valores) e `Extended` (alíquotas), ou trabalhe em **centavos inteiros**; implemente o arredondamento **meio para cima** de forma explícita, sem depender do arredondamento padrão do `Round`. Um projeto de teste (como os de `Tests\` do Gestão) lê cada arquivo e compara campo a campo.
- **Web (TypeScript):** `JSON.parse`; use centavos inteiros (`bigint`) ou uma biblioteca decimal, nunca `number` para dinheiro. O caminho do arquivo pode vir do pacote da Infra-IA ou de uma cópia por script.

## A referência e a prova

[`referencia/referencia.py`](referencia/referencia.py) é a "resposta certa" de cada regra em Python puro (só biblioteca padrão). [`referencia/gerar_e_verificar.py`](referencia/gerar_e_verificar.py) gera os JSON e os reverifica:

```
cd fiscal-api/vetores/referencia
python gerar_e_verificar.py gerar        # reescreve os JSON a partir da referência
python gerar_e_verificar.py verificar    # recalcula tudo e compara; código de saída 0 se nada falhou
```

Resultado em 07/11/2026: **69 verificações, 0 falhas.** Os 8 vetores do documento 02 batem com a tabela publicada lá (inclusive o caso que usa o ajuste de 1 centavo), e **30.000 itens aleatórios fecham 100%** (`vProd + vIBS + vCBS = P`; 9,0% usam o ajuste de 1 centavo dentro da tolerância de 0,01 da NT).

## Limites da prova (leia antes de confiar)

- **A referência não é independente das fontes:** foi escrita por quem leu a norma. O que protege é que cada caso cita a fonte e o grau. Só a conta "por dentro" foi conferida com um número publicado por terceiro (o exemplo da SEFA-PR: preço 123,64, ICMS 14,84, base 100,00, IBS 0,10, CBS 8,70, `vProd` 114,84).
- Os casos de grau **E** são o que a autoridade fez em homologação em 01/11/2026 (notas 8014 e 8015 da nfse-api); valem para aquele pacote e aquela data e **precisam ser confirmados em produção**.
- **Fora dos vetores, de propósito** (sem texto fechado na norma): `tpRBSN` 9; o arredondamento de `vIBSSN` e `vCBSSN`; o optante pendente com `regApIBSCBSSN` 1 ou 2 no `vTotNF`; o caso "nenhuma chave" da VC02-14; as exceções 1 e 2 da UB16-10 (PIS/COFINS por substituição tributária), que a NT marca como "implementação futura".
- **Achado ao montar os vetores:** a lista da UB16-10 nos documentos `01` e no catálogo omitia o `vICMSMono`; foi corrigida em 07/11/2026 depois de ler o texto da NT.

## Como acrescentar um vetor

1. Ache o ID da regra em `../regras/REGRAS.md` (ou crie a regra antes).
2. Escreva a função em `referencia/referencia.py` e o gerador em `referencia/gerar_e_verificar.py`; rode `gerar` e `verificar`.
3. Preencha a coluna "Vetor" da regra e atualize a matriz. Cite a fonte e o grau em cada caso.
4. Dado sensível nunca entra (senha, token, certificado, CNPJ ou e-mail de cliente).

## O que falta

Vetores para as regras que ainda não têm (alíquotas por data, `pCredSN` pelo mês da operação, devolução com o crédito do art. 379 quando a apuração existir, classificação pelo Anexo VIII).

**Calendário:** os vetores de obrigatoriedade e de leiaute **leem o calendário único** (`../calendario/fatos.json`); a referência não guarda data própria. Regerados a partir dele, os vetores saíram idênticos aos que já estavam publicados.
