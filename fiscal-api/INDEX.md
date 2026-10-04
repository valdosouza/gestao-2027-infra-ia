# fiscal-api — Índice (espelho de conhecimento)

**Status**: 🧭 Fase 0 — Rodada 1 PARCIALMENTE DECIDIDA (2026-10-03): D-F1…D-F3 registradas; **nada de código até as decisões Q-F2…Q-F26 fecharem**
**Projeto**: `D:\Gestao2027\fiscal-api` (Node.js + TypeScript, porta 3002 — repo próprio `valdosouza/gestao-2027-fiscal-api`, a criar)
**Atende**: qualquer cliente licenciado (inclusive a Setes) e seus múltiplos aplicativos — setes-api, apps web/Android/iOS, apps de venda de terceiros — para EMITIR e AUTORIZAR documentos fiscais (NFS-e pelo ADN nacional; NF-e/NFC-e pela SEFAZ)
**Escopo**: misto (o conceito "serviço de documento fiscal que não conhece o ERP" é método; ADN, SEFAZ, tabelas e dados da Setes são conteúdo do caso zero)

---

## Comece aqui

- **`../prompts/prompt_apis_fiscais_isoladas.md`** — prompt em otimização (Rodadas 0/1). Vira `prompt_fase1_fiscal_api.md` aqui quando fechar.
  - §1 inventário MEDIDO do que hoje vive no setes-api (NFS-e em produção desde 2026-09-29) · §3 parecer do guardião conceitual · §4 fronteira (o que migra × o que fica) · §5 arquitetura (`/v1`, licenciado/app/emitente, fluxo, banco `fiscal_api`, multi-app, dimensionamento para 1000, estrutura do projeto) · §6 ondas F0–F5 com esforço + frentes irmãs S1–S3 · §7 decisões D-F · §8 questões Q-F · §10 critérios de aceite
- Origem fiscal: `../prompts/prompt_onda3_nfse_adn.md` (NFS-e — D-N1…D-N32, produção) e `../prompts/prompt_onda_nfe_sefaz.md` (NF-e — D-E1…D-E25, Rodada 1 decidida, não executada)
- Contratos oficiais dos fiscos: hoje em `../setes-api/integracoes/nfse-adn/` (ADN/Sefin Nacional); `nfe-sefaz/` ainda não levantado — passam para `integracoes/` aqui quando a F1 começar

## O conceito (parecer do guardião, 2026-10-03)

> *Um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele.*

A API responde pelo **FORMATO e pela CONVERSA** (leiaute, assinatura XMLDSig, mTLS com o A1, tentativa, voz append-only, XML em arquivo, PDF). O sistema que chama responde pelo **CONTEÚDO** (o que foi vendido/prestado, por quem, a quem, com que imposto). A API **não calcula imposto** e **não conhece pedido, nota, cliente ou cadeia** de quem chama — teste do terceiro cego: o Gestao2016 não tem `tb_entity`; tudo que o contrato exigir e ele não puder mandar está do lado errado da cerca.

## Decisões-chave (detalhe no prompt §7)

- **D-F1** `fiscal-api` é UM projeto/serviço com famílias `/v1/nfse` e `/v1/nfe` (nome pelo conceito, não pelo documento; cofre duplicado por documento = maquete). Dois processos por família é topologia de deploy, não modelo.
- **D-F2** Todo cliente consome direto, com múltiplos apps: `tb_licensee` (cliente) → `tb_licensee_app` (credencial por aplicativo, escopos, token curto) → `tb_emitter`/`tb_issuer` (CNPJ + A1 + habilitação por modelo). O setes-api é UM dos apps.
- **D-F3** Escala alvo: 1000 clientes emitindo e autorizando — F3 = produção escalável (2+ instâncias, storage de objeto, cofre criptografado, worker, teste de carga como aceite).
- Herdadas e vigentes: D-N31 (um A1 por estabelecimento), D-E1 (habilitação por MODELO), D-E6 (UMA política da voz, estratégia por ramo), D-I10/D-I25/D-I28 (voz do terceiro × efeito nosso; pendência + reaplicar), D-E20 (NF-e só com o 1º cliente de mercadoria — vale para o QUANDO; o ONDE é a API).

## Regras inegociáveis para quem for codificar (quando a F1 abrir)

1. Nenhum import de `tb_invoice`, `tb_order`, `tb_entity*` — a cerca é testada por lint/grep (critério §10.1).
2. Estado é DERIVADO da última voz da última tentativa — nunca coluna `status`; 2xx ilegível = ambíguo (502/K), nunca aceite; recusa de REGRA ≠ transitório.
3. Idempotência POR CONSTRUÇÃO: UNIQUE `(licensee, emitter, external_code)` — retry acha o documento, nunca cria o segundo.
4. Nenhum `Map/Set` de controle em memória de processo (lote/rodízio/trava) — trava no banco (`FOR UPDATE WAIT n`) ou worker.
5. Segredo nunca em coluna, log ou resposta; A1 abre no upload (PKCS#12 → PEM), senha não persiste (D-N5).
6. Padrões herdados do workspace: `PADROES_BANCO.md` (UTC na sessão, REPEATABLE READ, contadores sob lock), envelope de erro `{error, code, fields[]}`, Swagger obrigatório, módulo de cadastro em 6 arquivos (`ARQUITETURA_MODULOS_API.md`), gates socrático ≥ 0,70 + adversarial sem HIGH antes de "pronto".

## Como vai rodar em dev (previsto para a F1)

- `fiscal-api/.env` (`PORT=3002`, `DB_*` → banco `fiscal_api`, `SECRETS_PATH`, `STORAGE_PATH`, `JWT_SECRET` dos tokens de app) → `npm run dev`
- setes-api aponta para ela por `FISCAL_API_URL` + credencial de app (`tb_licensee_app` da institution) — F2
- Smoke: `scripts/smoke-adn-h.ts` com o A1 real da Setes (vence 08/10/2026) · Carga: `scripts/carga-fiscal.ts` contra fisco falso

## Referências

- Método: `../skills-genericas/refinar-prompt-arquitetura.md` · `../skills-genericas/guardiao-conceitual.md` (palavras ocupadas: emissor, transmissão, voz, autoridade, chave, segredo, canal)
- Precedentes de desenho: apresentação × voz do boleto (`../prompts/prompt_onda2_banco_inter.md`), API key por institution do sync (D12 em `../setes-sync/prompt_revisao_sincronizador_setes_sync.md`)
- Deploy/produção: Onda 4 em `../prompts/prompt_primeiro_cliente_setes.md` (D3 SaveInCloud; Q5/Q6 abertas)
