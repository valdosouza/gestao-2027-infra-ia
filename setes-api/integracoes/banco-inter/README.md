# Banco Inter — referência da API (Cobrança v3, OAuth, Banking)

**Escopo**: setes (contratos públicos de um terceiro, guardados aqui porque o portal só os serve
renderizados no navegador)
**Origem**: specs OpenAPI extraídas do bundle do portal `developers.inter.co` em 2026-09-19
(`docusaurus-plugin-redoc`, arquivos `swagger-*-yaml`). São as MESMAS specs que o portal renderiza —
reextrair quando o Inter mudar o contrato (o `changelog` do portal avisa).
**Consumidor**: Onda 2 da fase Primeiro Cliente (`Infra-IA/prompts/prompt_onda2_banco_inter.md`) —
peça `@shared/bank-channel` + adaptador `adapters/inter.ts`.

| Arquivo | O quê | Usado em |
|---|---|---|
| `cobranca-v3.openapi.json` | API Cobrança (Boleto com Pix) v3 — emitir, consultar, editar, PDF, cancelar, sumário, pagar (sandbox), webhook e callbacks | Onda 2 |
| `oauth-token.openapi.json` | Autenticação OAuth — `POST /oauth/v2/token` | Onda 2 (peça bank-channel) |
| `banking-v2.openapi.json` | API Banking v2 — extrato, saldo, pagamentos, Pix, webhooks | futuro (conciliação bancária pelo mesmo canal) |

## Fatos confirmados na spec (o que o modelo da Onda 2 assume)

**Ambientes**: produção `https://cdpj.partners.bancointer.com.br/{cobranca/v3|oauth/v2|banking/v2}` ·
sandbox `https://cdpj-sandbox.partners.uatinter.co/...`. Header opcional `x-conta-corrente` (minúsculo)
em toda chamada da cobrança — obrigatório quando a aplicação tem mais de uma conta.

**Token**: `POST /oauth/v2/token`, `application/x-www-form-urlencoded`: `client_id`, `client_secret`,
`grant_type=client_credentials`, `scope` (ex.: `boleto-cobranca.read boleto-cobranca.write`) — sob
mTLS (certificado + chave da aplicação, emitidos pelo próprio Inter, validade 1 ano). Resposta
`access_token`, `token_type`, `expires_in` (3600), `scope`. **Rate limit 5/min** — o token tem que ser
CACHEADO e reutilizado (1 h).

**Emitir** `POST /cobrancas` → `200 {codigoSolicitacao}` (assíncrono). Body obrigatório: `seuNumero`
(**max 15**), `valorNominal`, `dataVencimento` (YYYY-MM-DD), `numDiasAgenda` (0..60 dias corridos após
o vencimento para o cancelamento automático no banco), `pagador{cpfCnpj, tipoPessoa FISICA|JURIDICA,
nome ≤100, endereco ≤100, cidade ≤60, uf, cep 8}` (+ `bairro` opcional). Opcionais: `desconto`
(`PERCENTUALDATAINFORMADA|VALORFIXODATAINFORMADA` + `quantidadeDias`), `multa` (`PERCENTUAL|VALORFIXO`),
`mora` (`TAXAMENSAL|VALORDIA`), `mensagem{linha1..5 ≤78}`, `beneficiarioFinal`, `formasRecebimento`,
`notaFiscal{chaveNFe, numero, serie, dataEmissao, parcela, naturezaOperacao}`. O QR Pix sai sozinho se a
conta tiver chave Pix cadastrada.

**Consultar** `GET /cobrancas/{codigoSolicitacao}` → `cobranca{codigoSolicitacao, seuNumero,
dataEmissao, dataVencimento, valorNominal, tipoCobranca, situacao, dataSituacao (date),
valorTotalRecebido, origemRecebimento BOLETO|PIX, motivoCancelamento, arquivada, descontos, multa, mora,
pagador}` + `boleto{nossoNumero ≤11, codigoBarras 44, linhaDigitavel 47}` (ausente em
EM_PROCESSAMENTO) + `pix{txid, pixCopiaECola}` (ausente se não deu para gerar) + `notaFiscal`.
**Rate limit 120/min produção · 10/min sandbox.** **Janela do sandbox: só responde das 8h às 20h, de
segunda a sexta** (fato do cadastro do Valdo em developers.inter.co, 2026-09-20) — fora disso tudo é
BANK_UNAVAILABLE; o smoke avisa antes de rodar.

**Situações** (consulta): `EM_PROCESSAMENTO`, `A_RECEBER`, `RECEBIDO`, `MARCADO_RECEBIDO`, `ATRASADO`,
`CANCELADO`, `EXPIRADO`, `FALHA_EMISSAO`, **`PROTESTO`**. No **callback** só: `RECEBIDO`, `A_RECEBER`,
`MARCADO_RECEBIDO`, `CANCELADO`, `EXPIRADO`, `FALHA_EMISSAO` (ATRASADO e PROTESTO não notificam).

**Cancelar** `POST /cobrancas/{codigoSolicitacao}/cancelar {motivoCancelamento ≤50}` → **202**
(assíncrono — confirmar pela consulta). **PDF** `GET .../pdf` → `{pdf: base64}`. **Editar**
`PATCH /cobrancas/{codigoSolicitacao} {dataVencimento?, valorNominal?}` → `{status
PROCESSANDO|SUCESSO|FALHA, codigoEdicao}` (10/min). **Listar** `GET /cobrancas?dataInicial&dataFinal
[&seuNumero&situacao&filtrarDataPor…]` paginado — é por aqui que se reconcilia um órfão por
`seuNumero`. **Sandbox**: `POST /cobrancas/{codigoSolicitacao}/pagar {pagarCom: BOLETO|PIX}` → 204
simula o pagamento.

**Webhook**: `PUT /cobrancas/webhook {webhookUrl https://…}` (204) · `GET` (`webhookUrl, criacao,
atualizacao`; 404 se não há) · `DELETE`; **5/min**. Callback = array de `{codigoSolicitacao, seuNumero,
situacao, dataHoraSituacao (date-time), valorTotalRecebido, origemRecebimento, nossoNumero,
codigoBarras, linhaDigitavel, txid, pixCopiaECola}`. Em não-2xx o Inter **reenvia até 4× (20, 30, 60 e
120 min)**. `GET /cobrancas/webhook/callbacks?dataHoraInicio&dataHoraFim[&codigoSolicitacao]` lista os
disparos (tentativa, sucesso, httpStatus, mensagemErro); `POST /webhook/callbacks/retry
{codigoSolicitacao[≤50]}` reenvia.

## Consequências registradas no prompt da Onda 2
- `seuNumero ≤ 15` → `tb_bank_slip.our_number` (hoje `String(id)`) cabe; a peça valida o tamanho.
- `numDiasAgenda` obrigatório → decisão Q18 (recomendado 60: o cancelamento é ATO nosso, não janela).
- Cancelamento 202 → "banco primeiro" = aceite do pedido; a confirmação vem pela consulta (evento C
  do banco só quando a situação virar CANCELADO).
- Rate limit do sandbox (10/min) → a consulta ativa ao abrir a tela é THROTTLED (só apresentações
  vivas não consultadas nos últimos N minutos) e o token é cacheado.
- `PROTESTO` entra no vocabulário da voz do banco (kind `P`, sem efeito no boleto).
- ATRASADO/PROTESTO nunca chegam por callback → só a consulta os vê (mais um motivo para "webhook =
  gatilho, consulta = verdade").
