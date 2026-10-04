# nfse-api — Índice (espelho de conhecimento)

**Status**: 🔨 F1 EXECUTADA e GATES FECHADOS (2026-10-04) + Rodada 4 EXECUTADA + **Rodada 6 DECIDIDA e EXECUTADA (2026-10-04, 2ª sessão — §17 do prompt)** — serviço com 143 testes + 130 ao vivo (7 suítes em cópias descartáveis, todas verdes; 2 limitações aceitas fixadas em `it.failing` — F4/F6 do r7). As 4 falhas pós-gate do §16.4 foram RESOLVIDAS (promoção de trava → trava por linha no núcleo). D-F41 aluguel com espera curta · D-F42 `migrate:setes` copia/vira SÓ a SE · D-F44 o ATO da virada APOSENTA a habilitação SE do ERP (`scripts/cutover-erp.ts` — a única escrita no ERP, cerca por teste em src/ e scripts/; testes ao vivo só em `--dry-run`) · D-F45 boot confere o CHECK do domínio. Cancelamento confere o A1 SOB a trava antes do K. Pendem o gate do delta da Rodada 6 e Q-F52/Q-F53 (Q-F51 ADIADA — renovação do A1 programada).
**Projeto**: `D:\Gestao2027\nfse-api` — serviço Node + TypeScript, porta **3002**, contrato `/v1` (D-F8), instância própria na SaveInCloud (D-F9). Repo `valdosouza/gestao-2027-nfse-api` (PRIVADO, criado e publicado 2026-10-04).
**Núcleo**: `D:\Gestao2027\fiscal-api` (biblioteca — `../fiscal-api/INDEX.md`)
**Atende**: setes-app (e qualquer front-end do produto), com o JWT do setes-api (RS256 — D-F13)
**Escopo**: misto

---

## Comece aqui

- **`../prompts/prompt_apis_fiscais_isoladas.md` §12** (plano vigente) e §7 (D-F1…D-F26).
- Regras da NFS-e que MIGRAM junto com o código: `../prompts/prompt_onda3_nfse_adn.md` (D-N1…D-N38 — ambíguo nunca fecha, F só conclusivo, vigente = quem detém a chave, vida da nota, cancelamento autorizado) e `../prompts/prompt_cancelamento_nota.md` §15 (D3/D4 — nota com registro fiscal cancelada FICA viva).
- Contrato oficial do ADN/Sefin Nacional: `../setes-api/integracoes/nfse-adn/` (muda para `integracoes/nfse-adn/` aqui na F1).

## O que a nfse-api faz (D-F10)

O app manda a REFERÊNCIA da nota (`/v1/nfse/invoices/{invoiceId}/…`); a nfse-api coleta no banco do produto (SÓ SELECT — D-F15) tudo o que o DPS precisa — nota e ramo de serviço congelado, emitente (cadeia + `tb_entity_tax`), tomador, cidade de incidência, zona do estabelecimento — e controla o ciclo inteiro com o fisco: envio, autorização, consulta, cancelamento no fisco, XML e DANFSe. O C LOCAL da nota é do setes-api, que lê a voz C nas views do `fiscal_api` (D-F11).

## Como vai rodar em dev (previsto para a F1)

`nfse-api/.env`: `PORT=3002`, `DB_*` (usuário com SELECT no ERP + controle do `fiscal_api`), `JWT_PUBLIC_KEY_PATH`, `FISCAL_MASTER_KEY`, `STORAGE_PATH` (o MESMO do setes-api no dev — os XMLs da Setes ficam onde estão) → `npm run dev`. Smoke no ADN H com o A1 real da Setes (**vence 08/10/2026**).
