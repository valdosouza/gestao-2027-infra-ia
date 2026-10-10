# nfe-api — Índice (espelho de conhecimento)

**Status**: ⏸ pasta SEM código por decisão (D-F20, Valdo 2026-10-03) — código só com o 1º cliente de mercadoria (D-E20) e depois do IBS/CBS (D-F22). **2026-10-10: Rodada 0 da nfe-api ORGANIZADA** (`../prompts/prompt_onda_nfe_sefaz.md` §11 — pedido do Valdo "vamos nos preparar para montar a api-nfe"; **Rodada 1 DECIDIDA** — D-NE1…D-NE26 no §11.7: D-F20 suspensa em parte (NE-0…NE-3 liberadas); próximo: NE-0 = levantamento oficial em `integracoes/nfe-sefaz/`).
**Projeto**: `D:\Gestao2027\nfe-api` — serviço futuro (NF-e 55 / NFC-e 65 pela SEFAZ), porta prevista **3003**, contrato `/v1`, sobre o núcleo `D:\Gestao2027\fiscal-api`.
**Escopo**: misto

---

## Comece aqui

- `../prompts/prompt_onda_nfe_sefaz.md` — Rodadas 0/1 da NF-e (D-E1…D-E25; §9 enquadra as telas de configuração do legado). **Onde houver conflito, vale o `../prompts/prompt_apis_fiscais_isoladas.md` §7/§12**: a NF-e nasce NA nfe-api, nunca no ERP; série/número do 55/65 são do ERP (D-F21, diverge da D-E2); a API lê o banco do produto (D-F10) e não aplica efeito (D-F11).
- Antes do código: levantamento oficial em `integracoes/nfe-sefaz/` (MOC 7.0, NT 2025.002 IBS/CBS, schemas PL, autorizadores por UF, cStat) — ainda não feito.
