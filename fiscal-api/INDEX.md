# fiscal-api — Índice (espelho de conhecimento do NÚCLEO COMUM)

**⏯ F2a — etapa A1 EXECUTADA com gates 0,74/0,72 (2026-10-12 — `../prompts/prompt_apis_fiscais_isoladas.md` §22.6–§22.7; D-F109…D-F123): veredito da reconferência com motivo, leitor escopado pela VIDA (`readFamilyTransmissions(…, vida)`), superfície `fiscal-api/reading` em lista explícita (sem o booleano da prova nem o SELECT cru), CHECKs binários de `model`/`environment` (núcleo) e `kind`/`source`/`environment` (nfse-api) re-executáveis com sondas pelo NOME da constraint, `assertFamilyViewsReadable`, cercas por `SETES_API_DIR`; PUBLICADA (núcleo 1cc8e99 · nfse a930827 · infra 9cb8612); próximo: A2 — ⏯ prompt de retomada no §22.8.** **Rodada 0 (antes)**: inventário do setes-api (14 rotas, ponto de corte, leituras × views, JWT, 065 já publicada e não lida pelo ERP) + parecer do guardião ("o leitor segue o escritor": leitores pelas views só na JANELA da virada; porta única `fiscal-voice`; `f2a_fiscal_passivo` = congelar a escrita fiscal do ERP) + ordem A1→A2→A3 (worktree)→janela antes de 30/11; aguardam o Valdo Q-F115…Q-F123. **⏯ NE-1a PARTE 2 — passo 7 (N17, leitura de XML por PARSER) EXECUTADO com GATES do delta 0,74/0,72 (2026-10-12 — `../prompts/prompt_onda_nfe_sefaz.md` §12.9.7.3–§12.9.7.4; D-NE85…D-NE90 pelas recomendações; "parte 2b" PUBLICADA (núcleo 604117a · nfse ebbaf44 · infra afcbebb))**: `xml/reader.ts` = o LEITOR de XML do fisco (`parseXml` ESTRITO por GRAMÁTICA numa varredura única antes do @xmldom 0.8.15 — via `require`, sem os tipos do DOM; tetos 1 MB/64 níveis — D-NE88; valor vazio = ausente e `grupo-vazio` — D-NE85; nome QUALIFICADO × LOCAL nos namespaces da família — D-NE86; CDATA por CAMPO — D-NE87; recusa = `XmlUnreadableError(motivo, posição)` sem conteúdo — D-F100); `verifyXml` acha a assinatura pelo leitor; `FISCAL_DANFSE_XML_UNREADABLE` no catálogo (D-NE89); cerca `tagReads` (nenhuma leitura de XML por recorte em produção); 405 testes. Em pauta: Q-NE93 (teto do corpo HTTP) e D-NE82 (c). **⏯ NE-1a PARTE 2 — passos 1–6 EXECUTADOS com GATES (2026-10-12 — `../prompts/prompt_onda_nfe_sefaz.md` §12.9.7–§12.9.7.2; "parte 2a" PUBLICADA — núcleo 27d2aa6 · nfse 38980bb · infra f72fba4)**: `establishment/issuer-models.ts` (cerca da virada POR MODELO — D-NE10/D-NE73), `emitter/emitter.ts` (vivas pelas views de todas as famílias; família não instalada = 0 — D-NE76), `erp/invoice-tx.ts` (`withInvoiceTx(pool, quemPede, ref, …)` → `InvoiceTx` com IDENTIDADE — registro privado D-NE81, cópias congeladas, `open`), `voice/event-table.ts` (`defineVoiceFamily` — escritor GENÉRICO da voz por descritor, funil, rótulo da família), `voice/policy.ts` + `voice/outcome.ts` (política em peças: idempotência, C por kind, reserva K/liberação N, desfecho → voz com `unhandledOutcome`), `transport/https-json.ts` (`ca` só quando dito; cadeia do SERVIDOR → 409 `FISCAL_AUTHORITY_CHAIN_UNTRUSTED` — D-NE57), `reading.ts` = superfície `fiscal-api/reading` para a F2a (D-NE77); cerca D-F31 com exceção NOMEADA (verbo + alvo + ligação); 356 testes. Próximo: passo 7 (N17 — parser XML em `src/xml/`). **⏯ NE-1a PARTE 1 PUBLICADA (2026-10-12 — `../prompts/prompt_onda_nfe_sefaz.md` §12.9.3–§12.9.5)**: vocabulário com P/D e `KIND_CLASS`, PROJEÇÃO COMUM com o registro como FATO (`authorityRecorded`), leitura POR família (`voice/families/`), `InvoiceRef` (`ref/`), predicados/mapas que falham alto, `familyViewQueryMany`, `util/readonly-set.ts`; gates 0,76/0,76; 256 testes; D-NE61 (a denegada barra pelo FATO: o mapa recusa D sem registro). Nenhuma questão aberta; próximo: parte 2 (máquina em PEÇAS — D-NE58). **Antes (2026-10-11 — §21.17 do prompt — Rodada 23 DECIDIDA: D-F107 o CHECK da F2a protege a lista da família · D-F108 na NE-1a o DESCRITOR da família (`VoiceFamily<K>`) carrega a lista de escrita e o escritor comum do núcleo é genérico nela, com o funil — nota de implantação no `prompt_onda_nfe_sefaz.md` §12.8; nenhuma questão aberta na frente; próximo do núcleo: NE-1a; reconciliação no §20)**: D-F1…D-F108 (D-F105/D-F106: a cerca e o escritor são da FAMÍLIA NFS-e — no núcleo a cerca só olha SQL; o núcleo não tem escritor da voz hoje — 208 testes; D-F102/D-F103: conhecimento negativo em `voice/kinds.ts` — S sem saída, `kind` sem CHECK até a F2a; D-F104: prova booleana até a F2a; D-F101: a prova falha fechado com irmã VIVA — `FINAL_TRANSMISSION_KINDS`, `lastKind` obrigatório no tipo; D-F100: `AuthorityHttpError.body` nunca guarda a resposta trocada; D-F98: causa FECHADA do ambíguo — `errors/ambiguous-cause.ts`, `tagAmbiguous`/`ambiguousCauseOf`; D-F99: a prova falha fechado com tentativa da mesma identidade em voo e com irmã sem identidade; D-F97: `reconfirmationProven(candidata, vida)` — E2404 posterior à última apresentação do Id; vida e identidade obrigatórias; D-F92: a prova da reconferência não tem prazo — conhecimento negativo no `reconfirmationProven`; D-F90 no núcleo: `TransmissionView.nfseNotGeneratedAt` e `reconfirmationProven` pelo E2404 explícito; no núcleo, Rodadas 12–14: `CANCEL_EVENT_CODES`, `HUMAN_EFFECT_CANCEL_CODES`, `localCancelPending` exclui substituição e de ofício — D-F68/D-F82; 80 testes) (numeração unificada da 3ª sessão de 2026-10-04 com a sessão de 2026-10-10). No núcleo: D-F57 (lacuna (b) pela LINHA SE) e a cerca D-F31 por LISTA BRANCA (`src/__tests__/fence.ts`); 78 testes (inclui o `adversarial-f1r8` da 3ª sessão e o `adversarial-r8` de 10/10). Aberta da frente: Q-F62 (IM do CNC de H — nfse-api). Próximo do núcleo: NE-1 (generalizar para 55/65 ANTES da F2a — D-NE).
**Status**: 🔨 F1 EXECUTADA e GATES FECHADOS (2026-10-04) + Rodada 4 EXECUTADA (D-F36…D-F40) + **Rodada 6 DECIDIDA e EXECUTADA (2026-10-04, 2ª sessão — §17 do prompt: D-F41…D-F45)** — biblioteca do núcleo com 44 testes; migrations 002 (aluguel), 003 (`cutover_at` — virada como fato write-once) e **004 (CHECK do domínio do modelo — 1º CHECK da casa, conferido no boot por `assertIssuerModelDomainEnforced`)**; `lockIssuerRows` trava POR LINHA da PK (nunca faixa — PADROES §9 regra 8); peça `runShortCommand` (D-F41 — comando curto com espera curta na sessão, restaurada; aluguel do rodízio); `openIssuer` com o schema usa o predicado COMPLETO da cerca. Pendem Q-F51…Q-F53 e o gate do delta da Rodada 6.
**Projeto**: `D:\Gestao2027\fiscal-api` — **biblioteca** do núcleo comum (D-F17); não roda sozinha. Repo `valdosouza/gestao-2027-fiscal-api` (PRIVADO, criado e publicado 2026-10-04).
**Consumida por**: `nfse-api` (porta 3002 — `Infra-IA/nfse-api/INDEX.md`) e `nfe-api` (porta 3003, futura — `Infra-IA/nfe-api/INDEX.md`)
**Escopo**: misto (o conceito "um emitente habilitado declara um documento ao fisco e recebe a voz dele" e a separação núcleo × fonte de fatos são método; ADN, SEFAZ, tabelas e dados da Setes são conteúdo do caso zero)

---

## Comece aqui

- **`../prompts/prompt_apis_fiscais_isoladas.md`** — prompt da extração fiscal (Rodadas 0–2). **§7 = D-F1…D-F26 (permanentes) · §12 = plano VIGENTE** (topologia, fronteira, modelo candidato do `fiscal_api`, serialização, auth, cofre, ondas, critérios). §3–§6/§10/§11 = registro das Rodadas 0/1 (superadas onde conflitam com o §12). Vira `prompt_fase1_*.md` aqui quando a F1 fechar.
- Origem fiscal: `../prompts/prompt_onda3_nfse_adn.md` (NFS-e — D-N1…D-N38, produção desde 2026-09-29) e `../prompts/prompt_onda_nfe_sefaz.md` (NF-e — D-E1…D-E25)
- Contrato oficial do ADN: hoje em `../setes-api/integracoes/nfse-adn/` (muda para `../nfse-api/integracoes/` na F1)

## O desenho em uma tela (Rodada 2 do Valdo, 2026-10-03)

| Decisão | O que fixa |
|---|---|
| **D-F4** | setes-api PASSIVO: nunca chama as APIs fiscais; o setes-app (e qualquer front-end) é o cliente direto |
| **D-F9** | SaveInCloud: 1 instância MySQL (todos os schemas + `fiscal_api`) · Node setes-api · Node setes-sync · Node nfse-api · Node nfe-api · Plesk com o build Flutter apontando para as três APIs |
| **D-F10** | a API fiscal LÊ o banco do produto (o app manda só a referência da nota) por uma **fonte de fatos** isolada; o núcleo é cego ao ERP |
| **D-F11** | o EFEITO no ERP (C local) é do setes-api, lendo a voz direto no `fiscal_api`; sem recibo/webhook/federação |
| **D-F12/D-F17** | três pastas: `fiscal-api` (núcleo, biblioteca) · `nfse-api` · `nfe-api` (serviços por família) |
| **D-F13** | mesmo login do produto, JWT **RS256** (as APIs fiscais só têm a chave pública) |
| **D-F14** | sem `tb_licensee`: licenciado = institution; licença = interface do ramo contratada |
| **D-F15** | contrato de leitura por VIEWs + GRANT mínimo (API fiscal só SELECT no ERP; setes-api só SELECT nas views) |
| **D-F16** | A1 CIFRADO no `fiscal_api` (AES-256-GCM, chave-mestra em variável de ambiente); XML atrás de interface de storage |
| **D-F7/D-F8** | banco `fiscal_api` único (nunca `setes_*`); `/v1` na URL |
| **D-F18/D-F19** | corte da Setes por migração única, H antes de P; extrair no dev, depois a Onda 4 já na topologia final |
| **D-F20/D-F21/D-F22** | nfe-api sem código até o 1º cliente de mercadoria; série/número do 55/65 no ERP; IBS/CBS fase própria (marco 01/01/2027) |

## O que o núcleo guarda (§12.2 do prompt)

**Inscrição federal (frente do CNPJ alfanumérico, D-CJ2 — onda 0 PUBLICADA em 2026-10-17: `main` 4b17b23 + `dist` reconstruído na janela, §8.16
do prompt da frente; o resto do branch `cnpj` — onda 1/rodadas 3–5 — espera o grupo do sync)**: peça PURA `src/federal-id/federal-id.ts` = 2º subpath publicado `fiscal-api/federal-id` (o setes-api o reexporta pelo
`@shared/validation`; ⚠️ o setes-api lê o `dist` — build do núcleo ANTES do merge dele) + vetor oficial `federal-id.vector.json` lido também pelo
espelho Dart; cerca `federal-id-fence` com predicado GÊMEO (`src/__tests__/federal-id-fence.ts`). Ver `../prompts/prompt_frente_cnpj_alfanumerico.md` §8.

**Base de PDF (NE-1b — PUBLICADA em 2026-10-18, `main` 4110957 + `dist`; janela D-NE123, §14.17 do `../prompts/prompt_onda_nfe_sefaz.md`)**: 3º subpath
`fiscal-api/pdf` (SÓ ele carrega `pdfkit 0.20.2` e `bwip-js 4.11.4` — versões EXATAS, D-NE124; índice/`reading`/`federal-id` não os carregam, provado
de dentro do setes-api): `createPdf` (folha A4/cm, `sheetStart` por folha, passada por folha com o TOTAL — "Folha n/N"; documento MARCADO, D-NE127),
`registerFontRoles`/`writeText`/`measureText` (fontes-padrão WinAnsi, porta ÚNICA de texto com lista FECHADA de opções; linha única = célula do DANFE;
`advance` para juntar trechos), `drawBars` (Code-128 HÍBRIDO C/A da chave pela NT Conjunta 2025.001 — o TEXTO da NT erra, vale o EXEMPLO),
`drawMatrix` (QR), `drawWatermark`. CONHECIMENTO NEGATIVO do pdfkit no `src/pdf/state.ts` (o `save()` só guarda a matriz; estado de texto vive no JS;
o quebrador de linha abre folha). Decisões D-NE117…D-NE152 (Rodadas 5–12) no §14 do prompt; a NE-5 (DANFE) nasce com a CERCA da família (D-NE129/
D-NE142 — `doc.text` cru, `doc.font` fora dos papéis, `clip()` fora de `save()`, `doc.on('pageAdded')` candidato).

transporte mTLS + XMLDSig paramétrico · `tb_establishment_certificate` (A1 cifrado — D-F34) + `tb_establishment_issuer` (habilitação por modelo, CHECK `SE/55/65` — D-F45) · contrato de leitura da voz (`voice/`) · storage do XML · auth pelo JWT do produto · base da fonte de fatos Gestão 2027 (leitura; a única "escrita" no ERP é a trava da nota — D-F27/D-F31) · migrations e views do `fiscal_api`. *(2026-10-10: a máquina tentativa × voz e o motor de PDF prometidos aqui ainda vivem na nfse-api — Q-NE13/Q-NE20 da Rodada 0 da nfe-api.)*

## Regras inegociáveis para quem for codificar

1. Nenhum `tb_invoice`/`tb_order`/`tb_entity*` FORA da fonte de fatos (cerca por teste — §12.8-1).
2. Estado DERIVADO da última voz; 2xx ilegível = ambíguo; recusa de REGRA ≠ transitório.
3. Nenhum `Map/Set` de controle em memória; o que cruza com o setes-api serializa pelo `FOR UPDATE` na linha da nota do ERP (D-F27 — a trava nomeada do §12.4 morreu); rodízio por ALUGUEL na linha da habilitação (UPDATE atômico, `runShortCommand` — D-F41).
4. Segredo nunca em claro em coluna, log ou resposta; senha do PKCS#12 não persiste (D-N5).
5. `PADROES_BANCO.md` (UTC, REPEATABLE READ, contadores sob lock) + `revisar-ddl.md` antes de DDL; gates socrático ≥ 0,70 + adversarial sem HIGH.

## Referências

- Método: `../skills-genericas/refinar-prompt-arquitetura.md` · `../skills-genericas/guardiao-conceitual.md`
- Precedentes: apresentação × voz do boleto (`../prompts/prompt_onda2_banco_inter.md`); serviço Node separado operando sobre os bancos do produto = setes-sync (`../setes-sync/`)
- Produção: Onda 4 em `../prompts/prompt_primeiro_cliente_setes.md` (herda a topologia D-F9)
