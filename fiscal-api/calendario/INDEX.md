# fiscal-api/calendario — calendário único dos fatos com data (NF-e, NFS-e e Reforma Tributária)

**Escopo**: método (datas de norma, portal e homologação; nada de cliente, credencial nem código de produto)
**Criado em**: 07/11/2026, por decisão do Valdo: o ERP Desktop (legado) e o sistema web reaproveitam o mesmo conhecimento fiscal; conhecer → planejar → organizar a execução → só então o código. Casa única: `Infra-IA/fiscal-api`.
**Companheiros**: [`../regras/REGRAS.md`](../regras/REGRAS.md) (cada fato aponta para as regras `RF-…` a que serve), [`../vetores/INDEX.md`](../vetores/INDEX.md) (os vetores de obrigatoriedade e de leiaute **leem este calendário**), [`../fontes/INDEX.md`](../fontes/INDEX.md) (as fontes).

## Por que existe

Em 07/11/2026 a mesma data tinha **duas constantes**: no legado, o grupo de IBS/CBS ia "pela data de emissão" (D-EM9); na web, a obrigação é uma constante por competência (`ibscbsObligationStart`, D-IB13) e o leiaute por ambiente é outra (`layout-calendar.ts`, D-IB110 e D-IB111). Quando o fisco anuncia ou adia uma data, dois lugares precisavam ser achados e mudados. Aqui há **um lugar só**.

## Os arquivos

| Arquivo | Para quê |
|---|---|
| [`fatos.json`](fatos.json) | **A fonte.** 55 fatos em 4 listas: `obrigatoriedade` (14), `leiaute` (5), `transicao` (11, por ano) e `marcos` (25: publicação, início, fim, produção, prazo e regra de rejeição) |
| [`CALENDARIO.md`](CALENDARIO.md) | A **linha do tempo legível**, ordenada por data, **gerada** do JSON (não edite à mão) |
| [`calendario.py`](calendario.py) | `gerar` escreve o `CALENDARIO.md`; `verificar` confere a integridade e se o `CALENDARIO.md` está em dia |

Cada fato tem `id` estável `FT-<TIPO>-<NN>` (OBR, LAY, TRN, MRC; nunca reaproveitado), a data, `regras` (IDs do catálogo), `fonte` e `grau` (**T** escrito na norma ou no portal · **L** leitura nossa · **E** observado em homologação ou produção · **N** não verificado ou a conferir).

## A prova de que é uma fonte só

- `python calendario.py verificar` confere: IDs únicos e no padrão, campos obrigatórios, graus válidos, datas válidas, **toda regra citada existe no catálogo** (56 regras), nenhuma obrigatoriedade repetida, linhas de leiaute em ordem de data, e o `CALENDARIO.md` igual ao que o JSON gera. Em 07/11/2026: **55 fatos, 0 erros.**
- A referência dos vetores (`../vetores/referencia/referencia.py`) **não guarda mais data própria**: lê a obrigatoriedade e o leiaute daqui. Regerados, os vetores saíram **idênticos byte a byte** aos que já estavam publicados, o que mostra que o calendário reproduz as constantes que o legado e a web já usavam.

## Como o legado e a web devem usar

- **Não acople em tempo de execução.** Cada lado pode manter a sua constante (no Delphi, uma constante ou o `atualizacao.ini`; na web, o `layout-calendar.ts` e a peça de classificação), **com um teste de contrato que lê o `fatos.json` e compara** (como os testes leem os vetores). Se o fisco mudar uma data, muda-se o `fatos.json` uma vez e o teste de cada lado acusa quem ficou para trás.
- Mais adiante dá para **gerar** a constante de cada lado a partir do JSON (por exemplo, o `[AliquotasIBSCBS]` do legado).
- **Quem muda uma data atualiza o calendário no mesmo commit**, roda `gerar` e `verificar`, e ajusta `atualizadoEm`.

## Fatos ainda em aberto (graus N e L)

| Fato | O que falta |
|---|---|
| FT-MRC-23 (prazo do Senado para a CBS de 2027) | Conferir a data (o levantamento citou 31/10 e depois 15/12/2026) e o valor da referência |
| FT-LAY-03 (leiaute em produção) | O fisco não publicou a data em que a produção adota o pacote de 20/10/2026 |
| FT-MRC-07 (fim da carência) | A data de publicação da parte comum do regulamento do IBS não foi conferida |
| FT-MRC-17 (prazo da opção do regime regular) | Conferir a norma (CGSN 194 foi citado pela web) |
| FT-MRC-18 (ME/EPP no ambiente nacional) | No dia 01/11/2026 as duas regras (E0163 e E0039) valem; leitura nossa |
| FT-MRC-12 (E0855) | Observado em H em 01/11/2026; confirmar em produção |
| FT-TRN-04 (CBS 2027) | O valor da alíquota de referência está pendente |

## O que ainda não está no calendário

- **Alíquotas efetivas por regime e classificação** (reduções de 60% e 100% por `cClassTrib`, alíquotas do IBS por UF e município): vêm da Calculadora e das tabelas oficiais; entram quando houver vetor de cálculo.
- **Faixas do Simples por mês** (para o `pCredSN` do mês da operação) e as tabelas dos Anexos da CGSN.
- **Vigência de cada `cClassTrib` e de cada CST** (o catálogo da web usa `valid_from`) e as versões da Calculadora.
- **Decisões de produto** com data (corte da NT do Simples, exe da virada): são de cada sistema e ficam nos planos, não aqui.
