# CNPJ alfanumérico — acervo oficial

**Escopo**: misto (as regras da RFB, do ITI, do Bacen e o leiaute da NFS-e valem para qualquer produto; a leitura de cada uma é do Gestão 2027)
**Arquivado em**: 2026-10-15, D-CJ1 da frente `prompts/prompt_frente_cnpj_alfanumerico.md` (§6.1), com o "vai" do Valdo (nome, origem e
tamanho conferidos antes; o gov.br recusa HEAD com 403 — o tamanho veio de um pedido de 1 byte, e o baixado bateu byte a byte).
**Por que está aqui**: como `../nfse-adn/` e `../banco-inter/`, documentos públicos de terceiros guardados com o TEXTO extraído
(`pdftotext -layout`) para o agente ler sem ir ao portal. O PDF/ZIP original é a fonte; o `.txt` é cópia de leitura.

| Arquivo | O que é | Origem | Bytes | SHA-256 |
|---|---|---|---|---|
| `rfb-perguntas-respostas-cnpj-alfanumerico.pdf` (+ `.txt`) | RFB — Perguntas e Respostas, CNPJ Alfanumérico (52 perguntas, 14 páginas) | https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/publicacoes/perguntas-e-respostas/cnpj/cnpj-alfanumerico.pdf | 801.190 | `c59ab587536ca22f634373cd6a0603afc834f286d3f557e60ad488f4e6264835` |
| `rfb-manual-dv-cnpj.pdf` (+ `.txt`) | Serpro/RFB — Cálculo dos dígitos verificadores de CNPJ alfanumérico (4 páginas) | https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/publicacoes/documentos-tecnicos/cnpj/manual-dv-cnpj.pdf | 718.374 | `7bb839f6c9beb968bd5bb67d31dd5db090d2333be55815759cfb293e639b4754` |
| `esquemas-nfse-rtc-v1-01-20260727.zip` (+ `xsd-nfse-producao-restrita-v1.01-20260727/`, 10 XSD) | NFS-e Padrão Nacional — XSD 1.01 da PRODUÇÃO RESTRITA ("NFSe-ESQUEMAS_XSD-PRODREST-v1.01-20260727"; o servidor entrega como `ESQUEMAS-NFSe-RTC_v1.01_20262707.zip`, data invertida pelo portal) | https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/producao-restrita/esquemas-nfse-rtc-v1-01-20260727.zip (página "Documentação Técnica (Homologação/testes)", atualizada 28/07/2026) | 34.933 | `6c7e0510d3ecff4454f291f4e10b742d27a4818f23aab181494f96d0ea79f3dc` |
| `iti-doc-icp-04-v8.3-compilado.pdf` (+ `.txt`) | ITI — DOC-ICP-04 v8.3 compilado (Res. CG ICP-Brasil 212, de 30/01/2025, já com a Res. 215, de 19/03/2025) | https://www.gov.br/iti/pt-br/assuntos/legislacao/documentos-principais/resolucao179_doc-icp-04_compilada.pdf | 732.810 | `0603dbb47ea9f1928a5e6f72168a2f6dfe1ad2796b394aa6ad6ac92282a9c9a8` |
| `bcb-drn-cnpj-alfanumerico-v1.02.pdf` (+ `.txt`) | Bacen — DRN "CNPJ Alfanumérico" v1.02 (22/05/2025) | https://www.bcb.gov.br/content/estabilidadefinanceira/sicornoticias/DRN%20-%20CNPJ%20Alfanum%C3%A9rico.pdf (Last-Modified 06/08/2025) | 362.107 | `e0f996183a1fe39adae77a904519475c78590322252d1b70264c33217c18be0b` |

**Só referenciados (já arquivados em outro acervo)**: NT 009 v1.01 da NFS-e → `../nfse-adn/nt009.txt`; XSD 1.01 de PRODUÇÃO (09/02/2026) →
`../nfse-adn/xsd/Schemas/1.01/`; contrato da API Cobrança v3 do Inter → `../banco-inter/`; NT Conjunta 2025.001 e NT 2026.004 da NF-e →
`../../../nfe-api/integracoes/nfe-sefaz/`.

**Descartado**: a página de versões do ITI tem outro PDF rotulado "V.8.3" (`…/resolucoes/resolucoes-old/Resolucao179_DOCICP04_8.3_compilada.pdf`,
723.953 bytes, SHA-256 `a0c1e2b6…bcf859`) — é a mesma v8.3 SEM a Res. 215/2025; o link principal é o mais recente.

## Fatos conferidos no arquivo (2026-10-15)

- **DV** (Manual, §1.1–1.2): 12 caracteres alfanuméricos + 2 DV numéricos; valor de cada caractere = ASCII − 48; pesos 2 a 9 da direita para a
  esquerda, recomeçando depois do 8º; resto 0 ou 1 → DV 0, senão 11 − resto; o 2º DV repete sobre os 13. Exemplo resolvido:
  `12.ABC.345/01DE-35` (somatórios 459 e 424).
- **XSD da produção restrita × produção (mesma versão 1.01)**:

  | tipo simples | produção restrita (H, 27/07/2026) | produção (P, 09/02/2026) |
  |---|---|---|
  | `TSCNPJ` | `[0-9A-Z]{14}` | `[0-9]{14}` |
  | `TSCPF` | `[0-9]{11}` | `[0-9]{11}` |
  | `TSIdDPS` | `DPS[0-9]{7}(1[0-9]{14}\|2[0-9A-Z]{14})[0-9]{20}` | `DPS[0-9]{42}` |
  | `TSIdNFSe` | `NFS[0-9]{9}[0-9A-Z]{14}[0-9]{27}` | `NFS[0-9]{50}` |
  | `TSChaveNFSe` | `[0-9]{6}([0-9A-Z]{14})[0-9]{30}` ⚠️ | `[0-9]{50}` |
  | Id do pedido de evento | `PRE[0-9]{8}(1[0-9]{14}\|2[0-9A-Z]{14})[0-9]{33}` | `PRE[0-9]{56}` |
  | `TSIdEvento` | `EVT[0-9]{8}(1[0-9]{14}\|2[0-9A-Z]{14})[0-9]{36}` | `EVT[0-9]{59}` |

  ⚠️ **Defeito do `TSChaveNFSe` de H**: reserva as letras nas posições 7–20 — o mesmo recorte do padrão de 44 posições da chave da NF-e/DF-e
  (`[0-9]{6}([0-9A-Z]{14})[0-9]{24}`, linha 216 do mesmo XSD), copiado para a chave de 50; na chave da NFS-e a inscrição fica nas posições
  10–23 (cMun 7 + ambiente 1 + tpInsc 1), como o próprio `TSIdNFSe` e o Id do pedido de evento (`PRE` + 8 dígitos + tpInsc + 14) mostram. Nunca
  copiar esse padrão para a nossa leitura da voz (D-CJ7). Repare também que o XSD admite letra nas 14 posições, inclusive nos 2 DV; a RFB não
  (forma geral `[0-9A-Z]{12}[0-9]{2}`).
- **Certificado (DOC-ICP-04 v8.3)**: os tipos de usuário final passam a ser A3/A4 (só pessoa física), **SE-S/SE-H (selo eletrônico, só pessoa
  jurídica — PC 2.16.76.1.2.201.n / 202.n)**, T3/T4, AE-S/AE-H, A CF-e-SAT e OM-BR — **não existe mais "A1" na lista** (§1.1.5–1.1.7, Res. 211/2024).
  Perfil do SE-S (Anexo I): titular `CN = <Razão Social>` e **`serialNumber = <número CNPJ>`**; o otherName OID 2.16.76.1.3.3 ("nas 14 posições o
  número do CNPJ da pessoa jurídica titular") é "obrigatório com restrição" — mantido provisoriamente até 31/12/2028 "para que as aplicações possam
  ser ajustadas para obtenção dessa informação pelo atributo serialNumber (OID 2.5.4.5)"; depois, opcional. Pessoa física: `serialNumber = <número
  CPF>` + OID 2.16.76.1.3.1. **O documento não diz se o `serialNumber` vem com máscara** — "<número CNPJ>" só; a D-CJ6 continua exigindo uma amostra
  REAL de SE-S antes do código.
- **Bacen (DRN v1.02)**: catálogo do SFN — `CNPJ` `[0-9A-Z]{12}[0-9]{2}`, ISPB `[0-9A-Z]{8}`, `IdentcSacdrAvalst` do DDA (boleto) aceita letra.
