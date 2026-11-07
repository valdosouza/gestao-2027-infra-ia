# Reforma Tributária — NFS-e com IBS/CBS: o que os atos oficiais exigem e o que ainda falta levantar

**Escopo**: método (datas e artigos oficiais; nada de cliente, credencial nem código de produto — este repositório é PÚBLICO)
**Origem**: levantamento feito em 07/11/2026 na frente do ERP Desktop (Gestão 2026), a pedido do Valdo, para uso do setes-app, do setes-api e da `nfse-api`
**Pré-requisitos**: `01-REFORMA-BASE-DE-CALCULO-E-TRANSICAO.md` e `02-REFORMA-CONTA-POR-DENTRO-PRECO-FINAL.md`
**Status**: **PARCIAL** — datas e artigos conferidos nos atos; o levantamento do que o ACBr/leiaute nacional já suportam e a contagem de clientes estão em andamento (ver o fim)
**Convenção**: **[texto]** · **[leitura nossa]** · **[não achei]** (ver o `01`)

## 1. Obrigatoriedade dos documentos eletrônicos com IBS/CBS

**[texto] Ato Conjunto RFB/CGIBS nº 4, de 30/07/2026, art. 1º**: a obrigatoriedade de emitir os documentos fiscais eletrônicos com as informações do IBS e da CBS (art. 112 dos regulamentos) começa para os fatos geradores a partir de:

| Documento | Data |
|---|---|
| NF-e (modelo 55) e NFC-e (modelo 65) | 03/08/2026 |
| CT-e (57), CT-e OS (67), MDF-e (58), GTV-e (64), NF3e (66) | 03/08/2026 |
| **NFS-e — serviços da lista da LC 116 não incluídos nas alíneas a, b e c (alínea d)** | **01/10/2026** |
| NFS-e — plataformas digitais (art. 22, § 1º, LC 214); serviços dos subitens 1.03, 1.05 e 1.09; subitem 16.01; bens imateriais; taxas condominiais; locações e cessões; demais serviços | **01/12/2026** |
| NFCom (62) | 01/10/2026 |
| NFGas (76), NFAg (75), NF-e ABI (77), BP-e semiurbano/metropolitano e aéreo | 01/12/2026 |

- **[texto] Simples Nacional (art. 1º, § 1º):** para os optantes, a obrigatoriedade de emissão de **todos** os documentos dos incisos do caput, **inclusive a NFS-e**, começa em **01/01/2027** (e não nas datas da tabela acima). Fornecimentos monofásicos na NF-e: 01/01/2027 (§ 2º). NF-e do sujeito passivo de IBS/CBS que **não é contribuinte do ICMS**: 01/12/2026 (§ 4º).
- **[leitura nossa]** Portanto, na NFS-e, o regime normal está sujeito às datas de 01/10/2026 e 01/12/2026, e o optante do Simples, a 01/01/2027. Releia o texto completo do ato antes de aplicar a um caso concreto.
- **[texto]** **Ato Conjunto nº 1/2025, art. 2º, § 3º**: a NFS-e de padrão nacional tem competências específicas do **CGNFS-e** (LC 214, art. 62, § 4º) e do **CGSN** (LC 123, art. 26).

## 2. Penalidades e carência

- **[texto]** Ato Conjunto nº 1/2025, art. 3º: **até o primeiro dia do quarto mês subsequente à publicação da parte comum dos regulamentos** do IBS e da CBS, não há penalidade pela falta de registro dos campos de IBS/CBS nos documentos fiscais. O parágrafo único diz que a apuração de 2026 é **meramente informativa**, sem efeitos tributários, desde que cumpridas as obrigações acessórias.
- **[leitura nossa]** O Decreto 12.955 (Regulamento da CBS) é de 29/04/2026; contando 4 meses, a carência da CBS acaba em **01/08/2026**, o que fecha com a data de 03/08/2026 do Ato 4/2026 para NF-e e NFC-e. A data de publicação da parte comum do regulamento do **IBS** (Resolução CGIBS 6/2026) não foi conferida.
- **[texto]** Ato Conjunto nº 4/2026, art. 2º: um ato conjunto posterior instituiria o **programa de conformidade** de 2026 (o Ato 5/2026 está na pasta de fontes; **[não lido a fundo]**).

## 3. O que as fontes locais NÃO trazem

- **[não achei]** O leiaute da NFS-e de padrão nacional (campos e grupo de IBS/CBS, versão do leiaute) e as notas técnicas do CGNFS-e: não estão na pasta de fontes. É preciso baixá-los do portal da NFS-e nacional.
- **[não achei]** Em qual versão do leiaute o grupo de IBS/CBS passa a ser **rejeitado quando ausente** na produção do ambiente nacional (diferente da data de obrigatoriedade legal acima).
- **[não verificado]** Como o Simples Nacional informa o IBS/CBS na NFS-e em 2027 (o equivalente do `gTribSN` da NT 2026.005 da NF-e).

## 4. Quem emite NFS-e hoje no ERP Desktop (levantado em 07/11/2026; só números agregados, sem nomes)

Consulta de leitura em 39 das 40 cópias locais de bancos de clientes (uma cópia está corrompida e não abriu; as cópias são fotos de 05–06/11/2026):

| Achado | Resultado |
|---|---|
| Clientes com NFS-e registrada em 2026 | **3** de 39 (de 14 a 526 notas no ano; a mais recente em 22/09/2026) |
| Provedor dessas 3 | **Padrão Nacional** (ADN), ambiente de **produção** |
| Regime dessas 3 | as 3 são **optantes do Simples (CRT 1)** |
| Clientes com NFS-e configurada por provedor municipal, sem nota em 2026 | 2 (um provedor de IPM e um de ISS de capital) |
| Clientes de regime normal (CRT 3) com NFS-e em 2026 | **0** |

- **[leitura nossa]** Como todos os emissores de NFS-e do ERP Desktop são optantes do Simples, a obrigatoriedade deles começa em **01/01/2027** (Ato 4/2026, art. 1º, § 1º), e não em 01/10 ou 01/12/2026. A exposição imediata é pequena; a de 01/01/2027 vale para os 3.
- **Limite:** a amostra são cópias locais de 39 bases, não a produção; um cliente sem cópia local não aparece.

## 5. A preencher

- O que o **ACBr** instalado no ERP Desktop (trunk2 r48887) suporta de IBS/CBS na NFS-e, em quais provedores e quais campos o chamador precisa preencher.
- Onde, no código de emissão de NFS-e do ERP Desktop, entraria o grupo de IBS/CBS.
