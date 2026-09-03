# ISS municipal — como funcionam as alíquotas (caso Curitiba)

> Referência rápida para o ERP / emissão de NFS-e. Última revisão: 2026-09-01.
> Fontes: LC federal 116/2003 e 157/2016; LC municipal 40/2001 (Código Tributário de Curitiba), art. 4º e 4º-A, com alterações das LC 107/2017 e 112/2018.

## 1. Moldura federal

- A Constituição dá ao município a competência de tributar serviços (ISS).
- A **LC 116/2003** define a **Lista de Serviços** (itens 1.01, 7.02, 14.01 etc.). Só o que está na lista pode ser tributado.
- **Teto:** 5% (LC 116/2003).
- **Piso:** 2% (LC 157/2016). Vedadas isenções, reduções de base ou créditos que resultem em carga menor que 2%, sob pena de improbidade administrativa.
- **Exceções ao piso:** construção civil (7.02 e 7.05) e transporte coletivo (16.01) podem ficar abaixo de 2%.

Consequência: quase todo município trabalha entre 2% e 5%. Curitiba tinha 0,5% para transporte coletivo e leasing e precisou subir para 2%.

## 2. Alíquotas de Curitiba (LC 40/2001, art. 4º)

| Alíquota | Serviços |
|---|---|
| 2% | Transporte coletivo; leasing; serviços para destinatários no exterior; escolas de ensino fundamental, pré-escola e ensino médio; call centers e assistência técnica remota |
| 2,5% | Limpeza e conservação; vigilância; corretagem de seguros; representação comercial; composição gráfica; recauchutagem de pneus |
| 4% | Hospitais, sanatórios, casas de saúde, prontos-socorros — alteração recente restringe a faixa de 4% a cooperativas de serviços de saúde |
| 5% | Demais atividades (inclui desenvolvimento de software, itens 1.x da lista) |

**Critério por trás das faixas:** decisão política/econômica do legislativo municipal — setores de mão de obra intensiva, saúde, educação e exportação recebem alíquota menor; serviços genéricos pagam o teto. Muda apenas por lei complementar municipal.

**Atenção:** existe projeto de lei na Câmara de Curitiba para reduzir o ISS de informática para 2% (incluir alínea "informática e congêneres" no art. 4º, I). Verificar se foi aprovado — impacta diretamente a software house.

## 3. Outras variáveis que mexem no cálculo

- **Simples Nacional:** a alíquota municipal não se aplica; o ISS vem embutido nas faixas dos anexos do Simples. Nenhuma redução municipal de ISS vale para optantes.
- **ISS fixo:** trabalho pessoal do próprio contribuinte (autônomos, sociedades uniprofissionais) paga tributo fixo anual, sem alíquota sobre faturamento.
- **Local de incidência:** regra geral da LC 116 é o município do estabelecimento prestador. Lista de exceções (construção, limpeza, vigilância, planos de saúde etc.) manda recolher no município onde o serviço é executado — origem da retenção na fonte pelo tomador e das disputas entre cidades.

## 4. Reforma Tributária (IBS/CBS)

- O ISS será extinto. O **IBS** substitui ISS + ICMS.
- Transição de **2029 a 2033**: redução gradual do ISS com alíquota do IBS subindo.
- Durante a transição as alíquotas municipais continuam valendo — a emissão de NFS-e convive com os dois regimes por alguns anos.

## 5. Próximos passos sugeridos

- Mapear os itens da LC 116 usados no ERP para as alíquotas atuais de Curitiba.
- Monitorar o projeto de redução do ISS de informática.
- Modelar no cadastro de serviços: item LC 116, alíquota municipal, flag de retenção na fonte, regime (normal / Simples / fixo).
