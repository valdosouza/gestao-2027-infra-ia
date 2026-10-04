# fiscal-api — Índice (espelho de conhecimento do NÚCLEO COMUM)

**Status**: 🔨 F1 EXECUTADA e GATES FECHADOS (2026-10-04) + Rodada 4 EXECUTADA (D-F36…D-F40) + **Rodada 6 DECIDIDA e EXECUTADA (2026-10-04, 2ª sessão — §17 do prompt: D-F41…D-F45)** — biblioteca do núcleo com 44 testes; migrations 002 (aluguel), 003 (`cutover_at` — virada como fato write-once) e **004 (CHECK do domínio do modelo — 1º CHECK da casa, conferido no boot por `assertIssuerModelDomainEnforced`)**; `lockIssuerRows` trava POR LINHA da PK (nunca faixa — PADROES §9 regra 8); peça `runShortCommand` (D-F41 — comando curto com espera curta na sessão, restaurada; aluguel do rodízio); `openIssuer` com o schema usa o predicado COMPLETO da cerca. Pendem Q-F51…Q-F53 e o gate do delta da Rodada 6.
**Projeto**: `D:\Gestao2027\fiscal-api` — **biblioteca** do núcleo comum (D-F17); não roda sozinha. Repo `valdosouza/gestao-2027-fiscal-api` (a criar pelo Valdo).
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

transporte mTLS + XMLDSig paramétrico · `tb_emitter` (A1 cifrado) + `tb_issuer` (habilitação por modelo) · máquina tentativa × voz · storage do XML · auth pelo JWT do produto · base da fonte de fatos Gestão 2027 (SÓ-SELECT) · migrations e views do `fiscal_api`.

## Regras inegociáveis para quem for codificar

1. Nenhum `tb_invoice`/`tb_order`/`tb_entity*` FORA da fonte de fatos (cerca por teste — §12.8-1).
2. Estado DERIVADO da última voz; 2xx ilegível = ambíguo; recusa de REGRA ≠ transitório.
3. Nenhum `Map/Set` de controle em memória; o que cruza com o setes-api serializa pela trava nomeada da instância, tomada ANTES do BEGIN (§12.4).
4. Segredo nunca em claro em coluna, log ou resposta; senha do PKCS#12 não persiste (D-N5).
5. `PADROES_BANCO.md` (UTC, REPEATABLE READ, contadores sob lock) + `revisar-ddl.md` antes de DDL; gates socrático ≥ 0,70 + adversarial sem HIGH.

## Referências

- Método: `../skills-genericas/refinar-prompt-arquitetura.md` · `../skills-genericas/guardiao-conceitual.md`
- Precedentes: apresentação × voz do boleto (`../prompts/prompt_onda2_banco_inter.md`); serviço Node separado operando sobre os bancos do produto = setes-sync (`../setes-sync/`)
- Produção: Onda 4 em `../prompts/prompt_primeiro_cliente_setes.md` (herda a topologia D-F9)
