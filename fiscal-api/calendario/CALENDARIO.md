# fiscal-api/calendario — linha do tempo dos fatos com data

**Gerado a partir de [`fatos.json`](fatos.json) em 2026-11-07. Não edite este arquivo: edite o JSON e rode `python calendario.py gerar`.**
**Grau:** T escrito na norma ou no portal oficial · L leitura nossa · E observado em homologação ou produção · N não verificado ou a conferir. **Regras:** os IDs do catálogo (`../regras/REGRAS.md`).

| Data | ID | O quê | Grau | Regras | Fonte |
|---|---|---|---|---|---|
| desde sempre | FT-LAY-01 | Leiaute DPS em H: xsd-20260209, versão 1.01 (desde o primeiro envio) | E | RF-NFS-02, RF-NFS-03 | nfse-api, layout-calendar.ts (D-IB110): o pacote de 09/02/2026 vale desde o primeiro envio |
| desde sempre | FT-LAY-03 | Leiaute DPS em P: xsd-20260209, versão 1.01 (desde o primeiro envio) | L | RF-NFS-02, RF-NFS-03 | nfse-api, layout-calendar.ts (D-IB111): a produção segue o pacote de 09/02/2026 até o fisco anunciar a data do pacote novo (nenhuma data publicada em 07/11/2026) |
| desde sempre | FT-LAY-04 | Leiaute EVENT em H: xsd-20260209, versão 1.01 (desde o primeiro envio) | E | RF-NFS-02, RF-NFS-03 | nfse-api, layout-calendar.ts: o pedido de evento é idêntico nos dois pacotes (tiposEventos e pedRegEvento iguais byte a byte) |
| desde sempre | FT-LAY-05 | Leiaute EVENT em P: xsd-20260209, versão 1.01 (desde o primeiro envio) | E | RF-NFS-02, RF-NFS-03 | nfse-api, layout-calendar.ts |
| 2025-01-16 | FT-MRC-01 | LC 214/2025 (Reforma Tributária do Consumo) | T | RF-CAL-01 | texto da LC 214; citada no Anexo VII da NFS-e |
| 2026-01-01 | FT-MRC-02 | NFS-e: declarar IBS/CBS passa a ser permitido (E0850: só a partir da competência 01/01/2026) | T | RF-NFS-06 | Anexo VI v1.04.01, regra E0850 |
| 2026-01-01 | FT-TRN-01 | 2026: IBS alíquota de 0,1% — alíquota estadual de teste, compensada com PIS/COFINS | T | RF-CAL-01 | LC 214 arts. 343, 346, 348 |
| 2026-01-01 | FT-TRN-02 | 2026: CBS alíquota de 0,9% — alíquota de teste, compensada com PIS/COFINS | T | RF-CAL-01 | LC 214 arts. 343, 346, 348 |
| 2026-04-29 | FT-MRC-03 | Decreto 12.955 (regulamento da CBS) | T | RF-CAL-05 | texto do decreto |
| 2026-04-30 | FT-MRC-04 | Resolução CGIBS 6/2026 (regulamento do IBS) | T | RF-CAL-05 | ATC RFB/SUFIS/CGIBS 7/2026 (considerandos) |
| 2026-07-01 | FT-MRC-05 | CNPJ alfanumérico passa a ser implementado (a partir de julho de 2026) — Em 08/06/2026 saiu o schema da NF-e (NT 2026.004 v1.01) | T | RF-NFS-05 | NT SE/CGNFS-e 009 v1.01, item 2.1 |
| 2026-07-30 | FT-MRC-06 | Ato Conjunto RFB/CGIBS 4/2026 (obrigatoriedade dos documentos com IBS/CBS) | T | RF-CAL-03, RF-CAL-04 | Ato Conjunto 4/2026 |
| 2026-08-01 | FT-MRC-07 | Fim da carência de penalidade pela falta dos campos de IBS/CBS (1º dia do 4º mês depois de 29/04/2026) — A data de publicação da parte comum do regulamento do IBS não foi conferida | L | RF-CAL-05 | Decreto 12.955 art. 619 I; Ato Conjunto 1/2025 art. 3º |
| 2026-08-03 | FT-MRC-08 | NFS-e: consulta pública com os grupos de IBS/CBS e DANFSe pela NT 008 no ar | T | RF-NFS-09 | portal da NFS-e, Atualizações e Implantações (21/10/2026) |
| 2026-08-03 | FT-OBR-01 | Obrigatória a declaração de IBS/CBS: NFe (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º |
| 2026-08-03 | FT-OBR-02 | Obrigatória a declaração de IBS/CBS: NFCe (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º |
| 2026-08-03 | FT-OBR-03 | Obrigatória a declaração de IBS/CBS: CTe (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (CT-e modelo 57) |
| 2026-08-03 | FT-OBR-04 | Obrigatória a declaração de IBS/CBS: CTeOS (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (CT-e OS modelo 67) |
| 2026-08-03 | FT-OBR-05 | Obrigatória a declaração de IBS/CBS: MDFe (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (MDF-e modelo 58) |
| 2026-08-03 | FT-OBR-06 | Obrigatória a declaração de IBS/CBS: GTVe (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (GTV-e modelo 64) |
| 2026-08-03 | FT-OBR-07 | Obrigatória a declaração de IBS/CBS: NF3e (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (NF3e modelo 66) |
| 2026-08-10 | FT-MRC-09 | NFS-e: Emissor Nacional Web com destaque de IBS/CBS pela NT 004 e CNPJ alfanumérico, em produção — Em produção o leiaute ainda é o da NT 004 | T | RF-NFS-02 | portal da NFS-e, Atualizações e Implantações (21/10/2026) |
| 2026-09-28 | FT-MRC-10 | ATC RFB/SUFIS/CGIBS 7/2026: aprova a NT 009 v1.01 (Anexo VI v1.04, Anexo VII v1.02) e a NT 010 — O painel municipal ganha, no mesmo dia, a função de antecipar o Emissor Nacional para optantes do Simples | T | RF-NFS-01 | ATC 7/2026 |
| 2026-10-01 | FT-MRC-11 | Publicadas no portal: NT 009 v1.01 (datada de 11/09/2026), NT 2025.002 v1.52, NT 2026.007 v1.10, NT 2026.008 v1.00, NT 2026.010 v1.00 e o IT 2025.002 v1.70 (ATC 8 de 29/09/2026) | T | RF-NFS-01, RF-NFE-01, RF-CLS-01 | portal da NFS-e; Portal NF-e; README das fontes |
| 2026-10-01 | FT-MRC-12 | NFS-e: regra E0855 (obrigatório declarar IBS/CBS desde a competência 01/10/2026) — Observado em H em 01/11/2026 (nota 8015): não recusou a NFS-e de optante do Simples com competência 11/2026 e sem o grupo | T | RF-NFS-07, RF-CAL-04 | Anexo VI v1.04.01, regra E0855 |
| 2026-10-01 | FT-OBR-08 | Obrigatória a declaração de IBS/CBS: NFSe (regime normal, serviços da alínea d) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (serviços da lista da LC 116 não incluídos nas alíneas a, b e c) |
| 2026-10-01 | FT-OBR-10 | Obrigatória a declaração de IBS/CBS: NFCom (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (NFCom modelo 62) |
| 2026-10-20 | FT-LAY-02 | Leiaute DPS em H: xsd-20261020, versão 1.01 (a partir de 2026-10-20T21:10:00Z) | E | RF-NFS-02, RF-NFS-03 | portal da NFS-e: pacote da produção restrita publicado em 20/10/2026 às 18h10 de Brasília (21:10 UTC); a nota 8014 com o pacote antigo recebeu E1235 em 01/11/2026. O instante exato da troca no servidor não é publicado |
| 2026-10-20 | FT-MRC-13 | Produção restrita da NFS-e adota o pacote XSD da NT 009 (18h10 de Brasília): reposicionamento de CST e cClassTrib, novos fatos geradores 99.02 a 99.04 e o grupo vAjusteBC — A data da NT 009 em produção não foi publicada | E | RF-NFS-02, RF-NFS-04, RF-NFS-05 | portal da NFS-e (21/10/2026) |
| 2026-10-26 | FT-MRC-14 | Anexo VIII v1.02.00 (correlação item da LC 116 × NBS × cAtvSN × indOp × cClassTrib) | T | RF-CLS-04 | portal da NFS-e (biblioteca de documentação técnica) |
| 2026-10-27 | FT-MRC-15 | Comunicado do Portal NF-e adia a produção das NTs da reforma para 16/11/2026 (o de 05/10 já tinha adiado a homologação) | T | RF-CAL-07 | comunicados do Portal NF-e de 05/10 e 27/10/2026 |
| 2026-10-30 | FT-MRC-16 | Publicadas as NT 2026.005 v1.00 (Simples), NT 2025.002 v1.53 e NT 2026.008 v1.01 (e as v1.11 da 2026.007 e v1.01 da 2026.006, só com datas) | T | RF-SN-13, RF-DEV-03, RF-PRC-06 | Portal NF-e |
| 2026-10-30 | FT-MRC-17 | Prazo, em 2026, da opção do optante pelo regime regular de IBS/CBS (o híbrido) | L | RF-SN-07 | manual do CGSN da opção; CGSN 194 (citado na D-IB1 da web) |
| 2026-11-01 | FT-MRC-18 | NFS-e do ME/EPP: o município com emissor próprio só compartilha com o ADN até a competência 01/11/2026 (E0163), e o ME/EPP do Simples pode usar o emissor nacional em qualquer município a partir de 01/11/2026 (E0039) — No dia 01/11/2026 as duas regras valem (menor ou igual, igual ou posterior) | L | RF-SN-12 | Anexo VI v1.04.01, regras E0163 e E0039 |
| 2026-11-11 | FT-MRC-19 | Fim dos serviços de inutilização em AC, BA e SP | T | RF-CAL-08 | NT 2023.002 v1.02 |
| 2026-11-16 | FT-MRC-20 | Produção das NTs 2025.002 v1.52/v1.53, 2026.006, 2026.007, 2026.008 e dos campos da 2026.005 (e rejeição 180 do CRT) | T | RF-CAL-07, RF-SN-13 | comunicado do Portal NF-e de 27/10/2026; NTs |
| 2026-12-01 | FT-MRC-21 | DANFE da reforma (IBS/CBS/IS) em produção | T | RF-NFE-04, RF-CAL-07 | NT 2026.010 v1.00 |
| 2026-12-01 | FT-OBR-09 | Obrigatória a declaração de IBS/CBS: NFSe (regime normal, serviços demais) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (plataformas digitais, subitens 1.03, 1.05, 1.09 e 16.01, bens imateriais, taxas condominiais, locações e cessões, demais serviços) |
| 2026-12-01 | FT-OBR-11 | Obrigatória a declaração de IBS/CBS: NFGas (regime normal) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º (NFGas modelo 76; NFAg 75, NF-e ABI 77 e BP-e semiurbano, metropolitano e aéreo na mesma data) |
| 2026-12-01 | FT-OBR-14 | Obrigatória a declaração de IBS/CBS: NFe (regime normal, sujeito passivo de IBS/CBS que não é contribuinte do ICMS) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º, § 4º |
| 2026-12-14 | FT-MRC-22 | NF-e de saída não referencia NFC-e/CF-e (BA02-35, VC02-40, I08-180) | T | RF-CAL-08 | NT 2026.002 v1.11 |
| 2026-12-15 | FT-MRC-23 | Prazo do Senado para fixar a alíquota de referência da CBS de 2027; sem resolução valem as do TCU (11,3%, CBS 11,2%) — A data do prazo precisa de conferência: o levantamento citou 31/10 e depois 15/12/2026 | N | RF-CAL-02 | LC 214 art. 349 § 1º II; levantamento de 31/10/2026 |
| 2027-01-01 | FT-MRC-24 | Virada: PIS/COFINS extintos, CBS cheia, Simples obrigado a declarar IBS/CBS em todos os documentos e pCredSN do mês da operação — O pCredSN do mês da operação é leitura nossa (a CGSN 140 art. 60 diz mês anterior) | T | RF-CAL-01, RF-CAL-04, RF-SN-05 | LC 214 art. 542; Ato Conjunto 4/2026 art. 1º § 1º; LC 123 art. 23 § 2º |
| 2027-01-01 | FT-OBR-12 | Obrigatória a declaração de IBS/CBS: todos os documentos (regime simples) | T | RF-CAL-04 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º, § 1º (todos os documentos do optante, inclusive a NFS-e) |
| 2027-01-01 | FT-OBR-13 | Obrigatória a declaração de IBS/CBS: NFe (regime normal, fornecimentos monofásicos) | T | RF-CAL-03 | Ato Conjunto RFB/CGIBS 4/2026, art. 1º, § 2º |
| 2027-01-01 | FT-TRN-03 | 2027: PIS/COFINS extinto — leis do PIS e da COFINS revogadas em 01/01/2027 | T | RF-CAL-01, RF-DEV-01 | LC 214 art. 542 |
| 2027-01-01 | FT-TRN-04 | 2027: CBS alíquota de referência menos 0,1 p.p. — de 2027 a 2028 a CBS é a alíquota de referência fixada pelo Senado menos 0,1 ponto percentual; valor da referência pendente (11,3% do TCU daria 11,2%) | T | RF-CAL-01, RF-CAL-02 | LC 214 art. 347 |
| 2027-01-01 | FT-TRN-05 | 2027: IBS-UF alíquota de 0,05% — IBS estadual de 0,05% de 2027 a 2028 | T | RF-CAL-01 | LC 214 arts. 344, 349 |
| 2027-01-01 | FT-TRN-06 | 2027: IBS-MUN alíquota de 0,05% — IBS municipal de 0,05% de 2027 a 2028 | T | RF-CAL-01 | LC 214 arts. 344, 349 |
| 2027-04-05 | FT-MRC-25 | Fim da autorização assíncrona da NF-e (rejeição 129) | T | RF-CAL-08 | NT 2023.002 v1.02 |
| 2029-01-01 | FT-TRN-07 | 2029: ICMS/ISS reduzido em 10% — ICMS e ISS reduzidos em 10%; o IBS passa a ter a alíquota de referência estadual e municipal (Senado) | T | RF-CAL-01 | LC 214 arts. 349, 360, 361, 367 |
| 2030-01-01 | FT-TRN-08 | 2030: ICMS/ISS reduzido em 20% — ICMS e ISS reduzidos em 20%; marco de recalibração da CBS (art. 368) | T | RF-CAL-01 | LC 214 arts. 362, 367, 368 |
| 2031-01-01 | FT-TRN-09 | 2031: ICMS/ISS reduzido em 30% — ICMS e ISS reduzidos em 30% | T | RF-CAL-01 | LC 214 arts. 363, 367 |
| 2032-01-01 | FT-TRN-10 | 2032: ICMS/ISS reduzido em 40% — ICMS e ISS reduzidos em 40% | T | RF-CAL-01 | LC 214 arts. 364, 367 |
| 2033-01-01 | FT-TRN-11 | 2033: ICMS/ISS extinto — ICMS e ISS extintos (revogação do Decreto-lei 406/68, da LC 87/96 e da LC 116/2003 em 01/01/2033); IBS integral | T | RF-CAL-01 | LC 214 arts. 543, 367 |
