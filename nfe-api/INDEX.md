# nfe-api — Índice (espelho de conhecimento)

**Status**: ⏸ pasta SEM código por decisão (D-F20, Valdo 2026-10-03) — código só com o 1º cliente de mercadoria (D-E20) e depois do IBS/CBS (D-F22). **2026-10-10: Rodada 0 da nfe-api ORGANIZADA** (`../prompts/prompt_onda_nfe_sefaz.md` §11 — pedido do Valdo "vamos nos preparar para montar a api-nfe"; **Rodada 1 DECIDIDA** — D-NE1…D-NE26 no §11.7: D-F20 suspensa em parte (NE-0…NE-3 liberadas); próximo: NE-0 = levantamento oficial em `integracoes/nfe-sefaz/`). **2026-10-10 (tarde): plano ajustado pela leitura do ACBr** (§12 do prompt — NE-1 partida em 1a antes da F2a / 1b depois; F4 = 35–51 sessões; **Rodada 2 DECIDIDA (D-NE27…D-NE54, §12.7)**). **⏯ 2026-10-12: §12.9 = NE-1a PARTE 1 EXECUTADA com gates 0,76/0,76 (D-NE56…D-NE62, D-NE66/68/69/70/71 — §12.9.3–§12.9.5; D-NE61: a denegada barra pelo FATO da view, Q-NE67 rejeitada); nenhuma questão aberta; próximo: parte 2 da NE-1a → F2a. D-NE55: a NE-0 vai para DEPOIS da F2a.** **§12.8 = nota de implantação da NE-1a para a escrita da voz POR FAMÍLIA** (D-F105/D-F106/D-F108 das APIs fiscais — o descritor da família carrega a lista de escrita; a NF-e pode produzir S/P/D com a saída na mesma entrega).
**Projeto**: `D:\Gestao2027\nfe-api` — serviço futuro (NF-e 55 / NFC-e 65 pela SEFAZ), porta prevista **3003**, contrato `/v1`, sobre o núcleo `D:\Gestao2027\fiscal-api`.
**Escopo**: misto

---

## Comece aqui

- `../prompts/prompt_onda_nfe_sefaz.md` — Rodadas 0/1 da NF-e (D-E1…D-E25; §9 enquadra as telas de configuração do legado). **Onde houver conflito, vale o `../prompts/prompt_apis_fiscais_isoladas.md` §7/§12**: a NF-e nasce NA nfe-api, nunca no ERP; série/número do 55/65 são do ERP (D-F21, diverge da D-E2); a API lê o banco do produto (D-F10) e não aplica efeito (D-F11).
- Antes do código: levantamento oficial em `integracoes/nfe-sefaz/` (MOC 7.0, NT 2025.002 IBS/CBS, schemas PL, autorizadores por UF, cStat) — ainda não feito.
- ⭐ `referencia-acbr/00-INDEX.md` — leitura do ACBr (motor NF-e do legado; referência de TERCEIRO, só conferência — D-NE19):
  5 relatórios (transporte/serviços · modelo/XML/chave/assinatura · IBS/CBS na NF-e e no DPS · 198 regras de validação como
  dado em `.json` · eventos/inutilização/DANFE) + **18 itens de conhecimento NEGATIVO** (o que o ACBr faz e a nfe-api não deve
  copiar). Consumido pelo §12 do prompt.
