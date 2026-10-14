# APIs Fiscais Isoladas — `nfse-api` (NFS-e/ADN) e `nfe-api` (NF-e/NFC-e/SEFAZ)

**Status**: Rodada 2 DECIDIDA (2026-10-03) — §8 zerada; **Rodada 4 (gates da F1) DECIDIDA 2026-10-04 → D-F36…D-F40, execução no §16**: D-F1…D-F26 (§7). A Rodada 2 mudou o centro do desenho: setes-api PASSIVO (D-F4); a API fiscal LÊ o banco do produto por uma fonte de fatos isolada (D-F10); o efeito no ERP é do setes-api lendo a voz no `fiscal_api` (D-F11); **três pastas** — `fiscal-api` (núcleo, biblioteca), `nfse-api`, `nfe-api` (D-F12/D-F17); mesmo login com JWT assimétrico (D-F13); sem `tb_licensee` (D-F14); views + GRANT mínimo (D-F15); A1 cifrado no banco (D-F16). Plano vigente: **§12**. Em execução: **F0** — parecer do guardião sobre o modelo (§13) abriu a Rodada 3 — **ZERADA em 2026-10-04 (D-F27…D-F35)**; modelo final no **§14**. **F0 FECHADA; F1 EXECUTADA (2026-10-04, §15)** — núcleo `fiscal-api` (29 testes) + `nfse-api` (102 + 45 ao vivo), `fiscal_api` criado e dados da Setes migrados; **GATES FECHADOS** (socrático 0.75 · adversarial 0.80 — 3 rodadas, 3 retrabalhos, §15.4). **Rodada 6 (2026-10-04, 2ª sessão — §17)**: 4 falhas ao vivo resolvidas (promoção de trava → trava POR LINHA), gates do delta 0.80/0.78, D-F41…D-F45 decididas e executadas (aluguel com espera curta, migrate:setes só SE, porte ao setes-api, o ato da virada aposenta a SE do ERP, CHECK do domínio do modelo); fiscal-api 44 · nfse-api 143 + 130 ao vivo. **Reconciliação 2026-10-10 (§20)**: os dois históricos — a 3ª sessão de 2026-10-04 (outro clone, D-F46…D-F53, §17.5/§18) e a sessão de 2026-10-10 desta máquina (renumerada D-F54…D-F59, §19) — unificados; Q-F52 = (b) bloqueio total; revive da SE com os dois fechamentos (D-F50 + D-F56/D-F58); **Q-F62 aberta**. fiscal-api 78 · nfse-api 240 + 150 ao vivo.
**Origem**: pedido do Valdo em 2026-10-03, ao fechar a fase de emissão de NFS-e: *"isolar as APIs do sistema porque o consumo pode ser feito por outras aplicações e eu posso dar escala para elas"*
**Referências**: `prompt_onda3_nfse_adn.md` (NFS-e — ENTREGUE, produção desde 2026-09-29) · `prompt_onda_nfe_sefaz.md` (NF-e — Rodadas 0/1 decididas, nada executado além das peças comuns do §10) · `prompt_primeiro_cliente_setes.md` (Onda 4 — produção na SaveInCloud, ainda INEXISTENTE) · `skills-genericas/guardiao-conceitual.md` · `setes-sync/prompt_revisao_sincronizador_setes_sync.md` D12 (API key por institution — precedente de API consumida por terceiro) · método: `skills-genericas/refinar-prompt-arquitetura.md`
**Escopo**: misto (o conceito "serviço de documento fiscal que não conhece o ERP" é método portável; tabelas, ADN, SEFAZ e dados da Setes são conteúdo do caso zero)

> Este documento NÃO decide. Organiza o que existe, mede o esforço e transforma cada escolha arquitetural em questão numerada (§8) com recomendação. Decisões do Valdo entram na §7 com numeração permanente (D-F1…).

> **⏯ RETOMAR POR AQUI — §22.49 (PROMPT DE RETOMADA CURTO — gates do último delta → a JANELA) — 4ª sessão de 2026-10-13/14 (§22.46):
> gates R15/R16, Rodada 16 (D-F199…D-F203), ENSAIO DA JANELA na instância descartável (passos 3–5 + `--vai` — PASSOU), PASSEIO LOGADO FEITO
> (NFS-e 3 autorizada em H e cancelada pela saga; 502/504 provocados → D-F204…D-F207) e mais três rodadas de gates do app (0,76/0,78 →
> D-F208…D-F212; 0,74/0,76 → D-F213…D-F217; 0,80/0,80 → D-F218…D-F220). Commits LOCAIS: núcleo 945ad2d · nfse 61d0bbe · api 8556491 ·
> app ebd040c. Próximo: gates do delta 5f6d3be..ebd040c → critério de entrada → a JANELA (passo 6b = D-F207).**
> *Antes:* **§22.48 — gates do delta 60df1df..5f6d3be → a JANELA.**
> *Antes:* **§22.47 — passeio montado, parado no login.**
> *Antes:* **§22.45 — Rodada 15 da F2a/F2b EXECUTADA (2026-10-13, §22.44: gates da Rodada 14
> 0,80/0,84 e D-F195…D-F198 pela autorização em pé); tudo em commit LOCAL (núcleo 945ad2d · nfse 61d0bbe · api 8556491 · app 95d829d).**
> *Antes:* **§22.43 — gates da Rodada 13 FEITOS (socrático 0,79 · adversarial 0,80, sem HIGH) e a Rodada 14
> DECIDIDA e EXECUTADA (2026-10-13, §22.42: D-F192…D-F194 — o roteiro protege a guarda do aborto (ensaio do aborto no passo 3; nenhuma SE
> nativa no fiscal_api de produção até a 1ª janela), a releitura da OS ABERTA morre com o lote por cima, o plano abre com a MESMA OS a
> caminho); tudo em commit LOCAL (núcleo 945ad2d · nfse 61d0bbe · api 8556491 · app 822fdf9); gates do delta da Rodada 14 em §22.42.3.
> AUTORIZAÇÃO EM PÉ (Valdo 2026-10-13: "Q-F197 … Q-F201 - siga recomendações"): as questões dos gates seguintes seguem a recomendação, salvo
> passo irreversível/fora da frente/gates divergentes sem saída/HIGH ou CRITICAL. Depois: passeio logado e a JANELA.**
> *Antes:* **§22.41 — gates da Rodada 12 FEITOS (socrático 0,72 · adversarial 0,72 — 1 MEDIUM cada, o MESMO:
> o desfecho citava o id interno, não o número da OS) e a Rodada 13 DECIDIDA e EXECUTADA (2026-10-13, §22.40: D-F187…D-F191 — o número que a
> tela mostra no desfecho e nos relatórios, o 2º diálogo pelo Navigator raiz, o aborto só antes da 1ª janela, a OS a caminho pedida de novo;
> D-F188 adiada para depois do passeio); tudo em commit LOCAL (núcleo 945ad2d · nfse 61d0bbe · api 0db9310 · app 9a5d2a8); gates do delta
> (Rodada 13) em §22.40.3. Depois: passeio logado e a JANELA.**
> *Antes:* **§22.39 — Rodada 12 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.38: D-F182…D-F186 —
> a mesma OS reaberta é relida e o desfecho fora da OS leva o número dela, trava de duplo clique por nota, a decisão do diálogo vai ao bloc
> vivo, a frase neutra nos atos fiscais, "de onde rodar" neutro no tempo); tudo em commit LOCAL (núcleo 945ad2d · nfse c967dcf · api f67f459 ·
> app 495267b); gates do delta (correções do §22.36 + Rodada 12) em §22.38.3. Depois: passeio logado e a JANELA.**
> *Antes:* **§22.37 — gates do delta da Rodada 11 FEITOS (2026-10-13, §22.34.3: socrático 0,76 ·
> adversarial 0,82, sem HIGH/MEDIUM) e as correções sem decisão EXECUTADAS (§22.36: o ensaio do `--cutover` interrompido imprime os
> bloqueios; a falha montada pelo app pela LISTA `ClientFailureCodes.all`); tudo em commit LOCAL (núcleo 945ad2d · nfse 74aa6d5 · api
> f67f459 · app da2b749); AGUARDAM o Valdo Q-F190…Q-F194 (§22.36.3). Depois: passeio logado e a JANELA.**
> *Antes:* **§22.35 — Rodada 11 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.34: D-F179…D-F181 —
> a trava H1 completa da rotina mensal e do "Transmitir pendentes", o "ref" da linha do lote só do servidor, a frase neutra da rede); tudo
> em commit LOCAL (núcleo 945ad2d · nfse 56b684d · api f67f459 · app 5983b29); gates do delta (correções do §22.32 + Rodada 11) em §22.34.3.
> Depois: passeio logado e a JANELA.**
> *Antes:* **§22.33 — gates do delta COMBINADO (correções da R9 + Rodada 10) FEITOS (2026-10-13,
> §22.30.3: socrático 0,74 · adversarial 0,76, sem HIGH) e as correções sem decisão EXECUTADAS (§22.32: a marca "a caminho" só morre onde o
> detalhe nasce; o ato no detalhe confere a tela que capturou; a frase única também no "sem F2a" e no D-F110); tudo em commit LOCAL (núcleo
> 945ad2d · nfse 56b684d · api f67f459 · app 89997e6); AGUARDAM o Valdo Q-F187…Q-F189 (§22.32.3). Depois: passeio logado e a JANELA.**
> *Antes:* **§22.31 — Rodada 10 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.30: D-F175…D-F178 —
> o mínimo garantido na linha dos kids, status HTTP/"sem conexão" na linha incerta, as saídas longas respeitam a OS aberta e o botão da rotina
> mensal travado, o detalhe preservado não é relido = conhecimento negativo); tudo em commit LOCAL (núcleo 4c225f7 · nfse 1779a7a · api
> f67f459 · app 3174d54); gates do delta COMBINADO (correções da R9 + R10) em §22.30.3. Depois: passeio logado e a JANELA.**
> *Antes:* **§22.29 — gates da Rodada 9 (socrático 0,76 · adversarial 0,78) com as correções EXECUTADAS
> (2026-10-13, §22.28: UM contador da tela no bloc — vale o último pedido —, a voz gravada junto do detalhe, a falha do 1º bloco respeita a
> OS aberta, uma frase por estado da lápide no ato e no ensaio); tudo em commit LOCAL (núcleo 44e3a5a · nfse 1779a7a · api f67f459 · app
> 09777d3); AGUARDAM o Valdo Q-F183…Q-F186 (§22.26.4); os gates do delta destas correções rodam JUNTO com a próxima rodada. Depois: passeio
> e a JANELA.**
> *Antes:* **§22.27 — Rodada 9 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.26: D-F172…D-F174 —
> `exp` sem teto até mexerem nos leitores, limite do resumo dos kids aceito, o detalhe aberto não é derrubado pela lista nem pelo fim do
> lote) + correções dos gates da Rodada 8 (socrático 0,80 · adversarial 0,84); tudo em commit LOCAL (núcleo fe71164 · nfse 0e1ae9d · api
> cf4b22e · app 3766f39); gates do delta da Rodada 9 em §22.26.3; aguardam o Valdo Q-F183/Q-F184 (§22.24.4). Depois: passeio e a JANELA.**
> *Antes:* **§22.25 — Rodada 8 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.24: D-F170/D-F171 —
> kids mais frequentes no resumo do log do 401, "não tentadas" com contador próprio) + correções dos gates da Rodada 7 (socrático 0,78 ·
> adversarial 0,74 — token não-JSON = 401, recarga superada não emite, o ato da nfse-api sempre olha a lápide); tudo em commit LOCAL (núcleo
> 92811fc · nfse 267b4b0 · api 6dbb5af · app 13cdd92); gates do delta da Rodada 8 em §22.24.3; aguarda o Valdo a Q-F180 (§22.22.4).
> Depois: passeio logado e a JANELA.**
> *Antes:* **§22.23 — Rodada 7 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.22: D-F165…D-F169 —
> kid/exp obrigatórios no núcleo, RESOURCE_BUSY antes do fisco = limite conhecido, kid distinto no log do 401, "incertas — consulte" no
> relatório do lote, lista em loading com lote no ar) + correções dos gates da Rodada 6 (socrático 0,77 · adversarial 0,80); tudo em commit
> LOCAL (núcleo 8704085 · nfse 7bf6ea9 · api f5d2be2 · app e89231e); gates do delta da Rodada 7 em §22.22.3. Depois: passeio logado e a JANELA.**
> *Antes:* **§22.21 — Rodada 6 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.20: D-F157…D-F164 —
> a classe do 401 no log do núcleo, linha da substituição pelo efeito do ERP, lotes param só no módulo, LÁPIDE com versão SENTINELA, contenção
> num ato = desconhecido, linha incoerente pulada com alarme no rodízio); tudo em commit LOCAL (api 99da896 · núcleo c0a8d35 · nfse 391fef7 ·
> app 3b5b2b6); gates do delta da Rodada 6 em §22.20.3. Depois: passeio logado e a JANELA.**
> *Antes:* **§22.19 — Rodada 5 da F2a/F2b DECIDIDA e EXECUTADA (2026-10-13, §22.18: D-F148…D-F156 —
> sessão confirmada pelo emissor, releitura do plano, voz fonte × contrato com o autor, reaplicar a trava, LÁPIDE do aborto, C/K ⇒ registro, 500
> num ato = desconhecido, bloc fechado ao sair da tela); re-gates da F2b 0,78/0,75 com correções; gates do delta da Rodada 5 em §22.18.4; tudo
> em commit LOCAL; gates do delta da Rodada 5 socrático 0,76 · adversarial 0,72 (sem HIGH) com correções (api b271e03 · núcleo 01bba49 ·
> nfse 5e61686 · app 6d94a6d). AGUARDAM o Valdo: Q-F165…Q-F172 (§22.18.5); depois: passeio logado e a JANELA.**
> *Antes:* **§22.17 — Rodada 4 da F2a + Rodada 1 da F2b DECIDIDAS ("siga as recomendações" → D-F130…D-F147)
> e EXECUTADAS (2026-10-13, §22.16): backend na worktree `f2a` + núcleo + nfse-api, gates do DELTA 0,74/0,72 (sem HIGH) com as correções;
> F2b no app em WORKTREE `setes-app-f2b` (branch `f2b`); tudo em commit LOCAL (push só com o "vai"). AGUARDAM o Valdo: Q-F156…Q-F159 (§22.16.6)
> + as questões dos gates da F2b; depois: passeio logado da F2b e a JANELA (roteiro do §22.13, com o aborto da D-F134).**
> *Antes:* **§22.15 — GATES DA A3 FEITOS (2026-10-13, §22.13: socrático 0,73 · adversarial 0,72, sem HIGH; correções na sessão; roteiro da
> janela REVISTO) + F2b Rodada 0 (§22.14: inventário + guardião); Q-F138…Q-F155 abertas (decididas depois — D-F130…D-F147).**
> *Antes:* **§22.12 — etapa A3 da F2a EXECUTADA na WORKTREE `setes-api-f2a` (branch `f2a`, 2026-10-13 —
> §22.11; D-F128/D-F129): porta da voz, plano/dispensa/selo/efeito pelo núcleo, 14 rotas removidas, `069_f2a_fiscal_passivo` (gatilhos),
> prova de aceite 0 divergência. PENDENTES: os GATES da A3 (lançados e interrompidos na troca de sessão — relançar), a F2b (Rodada 0) e a
> janela. Antes: A2 PUBLICADA (main f5eee3b; RS256 em produção — D-F124…D-F127).**
> *Antes:* **§22 — F2a ABERTA (Rodada 0, 2026-10-12): inventário do setes-api + parecer do guardião + ordem proposta
> (A1 núcleo/nfse-api → A2 setes-api sem depender de onde a voz mora → A3 lote da janela em WORKTREE → janela única com a virada e a F2b,
> antes de 30/11); Rodada 1 DECIDIDA (D-F109…D-F117, §22.6); etapa A1 EXECUTADA com gates 0,74/0,72 → Rodada 2 DECIDIDA (D-F118…D-F123, §22.7) e PUBLICADA (núcleo 1cc8e99 · nfse a930827); próximo:
> etapa A2 — ⏯ PROMPT DE RETOMADA no §22.8 (setes-api em WORKTREE; inclui a `vw_order_interface` com COLLATE binário). A NE-1a está COMPLETA (parte 2b publicada — `prompt_onda_nfe_sefaz.md` §12.9.7.4).**
>
> *Antes:* **§21.17 — Rodada 23 DECIDIDA (D-F107…D-F108, 2026-10-11): o CHECK da F2a protege a lista da família e, na NE-1a,
> o descritor da família carrega a lista de escrita — as duas se EXECUTAM na F2a e na NE-1a (nota da NE-1a no `prompt_onda_nfe_sefaz.md`
> §12.8); nenhuma questão aberta nesta frente; próximo: NE-1a (Rodada 0 aberta — `prompt_onda_nfe_sefaz.md` §12.9) → F2a (corte 30/11)
> → NE-0 (D-NE55: o levantamento da SEFAZ saiu do caminho crítico). (D-F67…D-F106 publicadas: prova da
> reconferência, alarme com causa fechada, voz S e `kind` como conhecimento negativo com cerca por AST, escritor da NFS-e pela lista
> positiva da família + funil em execução — Rodada 22 no §21.16). Antes: §21.7–§21.15,
> §21 e §20**: este documento juntou DOIS históricos que divergiram — a 3ª
> sessão de 2026-10-04 (feita em outro clone, publicada no `main`: D-F46…D-F53, §17.5/§18) e a sessão de 2026-10-10 desta
> máquina (§19, renumerada: D-F54…D-F59). Decisões vigentes **D-F1…D-F106** (§7). Escolhas do Valdo na reconciliação (§20.3):
> **Q-F52 = (b) bloqueio total** (a D-F46 vale; a D-F55 — "licença só na transmissão nova" — foi REVOGADA e o código dela saiu)
> e **os dois fechamentos do revive da SE** (D-F50 — o ato exige a F2a — + D-F56/D-F58 — guarda no setes-api). Provas da
> reconciliação: `fiscal-api` 78 · `nfse-api` 240 unit + **150/150 ao vivo** (1ª rodada ao vivo do código da 3ª sessão) ·
> `explain:leituras` OK. **Aberta: Q-F62** (o "Indicador Municipal" do Emissor Nacional de produção restrita — o Valdo lê e
> informa; §19.7/§20.5). Depois: smoke em H com OS nova → gate do delta (TSString/D-F59 + reconciliação) → NE-0/NE-1 → **F2a**
> (com a migration `NNN_f2a_fiscal_passivo.sql` — D-F50) → virada → F2b. Marco duro: IBS/CBS em 01/01/2027.
>
> *Histórico dos pontos de retomada anteriores*: 3ª sessão de 2026-10-04 → §17.5/§18; sessão de 2026-10-10 → §19.8; 2ª sessão
> de 2026-10-04 → §17.4.

---

## 1. Contexto — fatos verificados no disco (2026-10-03)

### 1.1 O que a NFS-e já é hoje (dentro do setes-api)

A Onda 3 entregou a emissão de NFS-e pelo ADN nacional como peças `@shared/*` do **setes-api**, consumidas pelo módulo `billing` (rotas `/api/billing/fiscal*`) e pelo módulo `establishment` (habilitação do emissor). Está em **produção real**: NFS-e nº 704 autorizada em 2026-09-29, DANFSe e cancelamento provados no mesmo dia.

| Peça | Arquivos | Linhas | Lê tabela do ERP? | Natureza |
|---|---|---|---|---|
| `shared/tax-authority` | types · adapters/adn · dps-builder · https-json · xmldsig | 1.054 | **não** | transporte puro: assina XML, fala mTLS com o fisco, devolve fatos crus |
| `shared/invoice-transmission` | invoice-transmission (840) · branches/service (599) · transmission.repository (532) · kinds | 1.992 | **sim** — `tb_invoice`, `tb_invoice_service`, `tb_invoice_event`, `tb_entity_tax`, `tb_city`, cadeia da entity | composição: reserva de tentativa → fisco fora da transação → voz → efeito; estratégia por ramo |
| `shared/fiscal-issuer` | fiscal-issuer · repository | 416 | só `tb_establishment_issuer` + transmissões | habilitação do emissor: PKCS#12 → par PEM no cofre, abre o par, valida validade/CN |
| `shared/danfse` | danfse | 168 | não | render do PDF a partir do XML autorizado (pdfkit) |
| `shared/secret-store` | secret-store | 149 | não | cofre em arquivos `SECRETS_PATH/<schema>/<owner>/<id>/<S|P>/<name>` — **compartilhado com o canal do banco** (owner `bank-account`) |
| `modules/billing` (parte fiscal) | billing.fiscal.controller (113) · billing.fiscal.service (144) · 9 rotas em billing.routes | ~300 | sim (privilégio por ramo, autoria JWT) | fronteira HTTP ↔ composição; lote com orçamento de 60 s e trava `runningBatch` |
| `modules/establishment` (parte issuer) | issuer.controller (61) · dto (35) · service (169) · 5 rotas | ~265 | sim | upload do A1, linha por modelo |
| Testes | 7 arquivos (`tax-authority` 372 · `invoice-transmission` 502 · `fiscal-issuer` 317 · `secret-store` 75 · `danfse` 71 · adversarial 83 · fiscal-folder-zone 40) | 1.460 | mocks na fronteira (`pool`, repository, adapter) | portáveis — mockam o que a peça importa, não o banco |
| Migrations | 058 (ramo + emissor + transmissão + voz) · 059 (chave do DPS) · 060 (contador + kind N) · 061 (`invoice_event` = vida da nota) · 062/063 (`tb_entity_tax` Simples) | — | 062/063 são fatos do EMITENTE no ERP (ficam) | 058–061 criam as tabelas candidatas a migrar |
| Códigos de erro | 23 `FISCAL_*` / `INVOICE_SERVICE_*` (de 296 no catálogo) | — | — | contrato de erro já estável |
| Dependências npm | `node-forge` (PKCS#12) · `xml-crypto` (XMLDSig) · `pdfkit` (DANFSe) | — | — | migram junto |
| Arquivos em disco | `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mes>/` (`*-dps.xml`, `*-nfse.xml`, `*-evt101101.xml`) · `SECRETS_PATH/<schema>/establishment/<inst>/P/certificate.pem + private.key` | — | — | o A1 real da Setes já está no cofre do dev (vence 08/10/2026) |

**Consumidores no app** (setes-app): 17 arquivos Dart (2 do emissor em `establishment`, 15 do fiscal em `service_orders`) + 4 testes — todos falam SÓ com `/api/billing/fiscal*` e `/api/establishment/issuer*` do setes-api (regra "módulo do app fala só com o seu `/api/<m>`"). **Se o setes-api continuar sendo a porta do app, o app não muda.**

**O que a transmissão lê do ERP e o que é só do fisco** (fato que define a fronteira — §4):
- *Do ERP, no momento da transmissão*: a nota viva emitida pela institution (`readServiceInvoice` — `tb_invoice` + ramo `tb_invoice_service` congelado no faturamento), o emitente (cadeia + `tb_entity_tax`: CNPJ, IM, cMun IBGE, opSimpNac/regApTribSN/regEspTrib, pTotTribSN — `buildEmitter`), o tomador (cadeia — `buildRecipient`), a cidade de incidência (IBGE), o fuso do estabelecimento (`institutionZoneFor`), o último evento da nota (MEDIUM-3: "a nota mudou no intervalo?"), o lock da nota e o lock de contadores da institution.
- *Só do fisco*: habilitação (ambiente, série, contador nDPS), par PEM, tentativa (`attempt`, ambiente congelado, `dps_id`, chave 50, número, `dh_proc`, `last_queried_at`), voz (S/A/R/C/K/F/N com código cru, fonte P/Q), XML em disco, DANFSe, prazo do PAM (cache).
- *O efeito*: a voz C do fisco produz `cancelInvoice` local em SAVEPOINT (porta única `applyCancelEffect`); recusa local = fato gravado + pendência (`FISCAL_EFFECT_PENDING`, `countPendingEffects`) — **o padrão "voz do terceiro × efeito nosso" já existe e já tolera separação no tempo** (D-I10/D-I25/D-I28 da Onda 2).

### 1.2 Estado de produção e escala — fatos

- **Onda 4 (deploy) não existe**: o setes-api não tem Dockerfile, `ecosystem.config` nem script de deploy; só `.env` de dev. A "produção" fiscal de 2026-09-29 foi o ambiente P do FISCO (tpAmb 1) acionado do dev. Decisão D3 da fase Primeiro Cliente: SaveInCloud, `api-erp.setesgestao.com.br`.
- **Estado em memória que NÃO sobrevive a 2+ instâncias** (achado desta leitura): `runningRefresh` (`invoice-transmission.ts:708`, 1 rodízio por institution), `runningBatch` (`billing.fiscal.service.ts:58`, 1 lote por institution), `termsCache` (`branches/service.ts:498`, só cache — inofensivo). Quem escala horizontalmente precisa trocar os dois primeiros por trava no banco ou aceitar "1 por instância".
- **Cofre e XML em filesystem local** (`SECRETS_PATH`, `STORAGE_PATH`): 2+ instâncias exigem volume compartilhado ou backend de objeto/KMS — a peça já diz "cofre/KMS entra ATRÁS desta interface quando a produção pedir".
- **Volume da Setes**: cobrança mensal em lote (teto 50 ordens/requisição — D27), centenas de NFS-e/mês. A escala que justifica serviço próprio é a da **NFC-e (modelo 65, PDV)** — milhares/dia por cliente — e a de **outros consumidores**.
- **Precedente de API consumida por terceiro**: setes-sync autentica por `X-Api-Key` resolvida em `setes_central.tb_sync_api_key` (institution + schema por JOIN, cache 5 min) — D12 da revisão do sync.

### 1.3 Estado da NF-e — fatos

- Rodadas 0 e 1 DECIDIDAS (D-E1…D-E25, "siga as recomendações", 2026-09-21). **D-E20 (a)**: as peças comuns nasceram com a Onda 3 (feito — `tb_establishment_issuer` com PK por MODELO, `xmldsig` paramétrico `sha1|sha256`, UMA composição `@shared/invoice-transmission` com `branches/`, motor de PDF único); **a NF-e em si espera o 1º cliente de mercadoria**. Nada de `adapters/sefaz.ts`, `branches/merchandise.ts`, `tb_invoice_merchandise_transmission`, `tb_invoice_number_void`, DANFE.
- O ERP já congela no faturamento os fatos do ramo de mercadoria (6 snapshots por item: `tb_order_item_icms/_fcp/_ipi/_pis/_cofins/_issqn`; `tb_invoice_merchandise`) — o builder do XML consome RESULTADO da tributação, nunca recalcula (§3.11 da NF-e; §4.3 do diagnóstico do legado).
- **IBS/CBS (NT 2025.002)**: obrigatório na NF-e/NFC-e do regime regular desde **03/08/2026**; Simples Nacional em **01/01/2027** (Ato Conjunto RFB/CGIBS nº 4/2026 — premissa corrigida em 2026-09-30). O motor `@shared/tax-rule` (1.099 linhas) **não calcula IBS/CBS** — pré-requisito de qualquer NF-e real (Q-E17), que vive no ERP, não na API fiscal.
- Contrato oficial da SEFAZ (MOC 7.0, NTs, schemas PL, autorizadores por UF, cStat) **ainda não levantado** (`integracoes/nfe-sefaz/` não existe). O da NFS-e existe em `setes-api/integracoes/nfse-adn/`.

### 1.4 Calibração de esforço (ondas reais desta mesma stack)

| Onda | Calendário | Tamanho | Observação |
|---|---|---|---|
| Onda 2 — Banco Inter (conector REST + mTLS + webhook, 3 peças, migration 055/056/057, app) | 2026-09-19 → 21 (3 dias) + gates/smoke até 21 | 948 → 1.056 testes | fisco/banco com contrato JSON documentado |
| Onda 3 — NFS-e ADN (DDL + emissor + transporte + composição + DANFSe + app + 3 rodadas de gates + 1ª produção) | 2026-09-20 → 30 (10 dias) | ~6,5 k linhas (código + testes), 7 migrations, 23 códigos de erro, 9 rotas | fisco DESCONHECIDO: a 1ª sessão real cravou contrato, assinatura e 4 códigos E0xxx |
| Cancelamento autorizado D3/D4 + rodadas Q-CA/Q-ADV | 2026-09-29 → 30 (2 dias) | 1.387 → 1.429 testes | delta sobre peça existente |

Unidade usada abaixo: **sessão** = bloco de ~4 h de trabalho Valdo + agente, com testes verdes ao fim. Faixa com ±40 % — o que encurta é código já provado sendo MOVIDO; o que alonga é fisco novo (SEFAZ) e dependência externa (DNS, SaveInCloud, homologação).

### 1.5 Rodada 1 — o que o Valdo trouxe (2026-10-03, 2ª mensagem; texto fiel)

> "quero tratar fiscal-api como novo projeto seguindo as estruturas do setes-app incluindo a documentação de Gestao2027\Infra-IA... mas cada cliente incluindo a setes poderá fazer o uso da api, incluindo aplicativos de vendas que poderá criar orders e enviar para autorização, múltiplos apps, acessando o próprio ambiente do cliente através da web ou app android/iOS consumindo apis que devem ser publicadas de maneira que a escala de uso aguente o consumo de 1000 clientes emitindo e autorizando notas"

O que isso muda no desenho:

| Antes (Rodada 0) | Agora (Rodada 1) | Efeito |
|---|---|---|
| Consumidor principal = setes-api; terceiros "um dia" | **Todo cliente** (inclusive a Setes) consome a API diretamente, com **múltiplos aplicativos** (web, Android, iOS, apps de venda de terceiros) | licenciado = o CLIENTE (D-F2, fecha Q-F17); nasce a credencial POR APLICATIVO (§5.8); contrato, CORS, documentação e limites de nível público desde a F1 |
| Escala "nascer escalável" sem número | **1000 clientes emitindo e autorizando** | requisito não-funcional com número (D-F3): dimensionamento §5.9; F3 vira "produção escalável" (2+ instâncias, storage de objeto, cofre criptografado, worker, teste de carga) |
| `fiscal-api` como nome recomendado pelo guardião | **`fiscal-api` é novo PROJETO de 1º nível** com espelho `Infra-IA/fiscal-api/` | D-F1 fecha Q-F1 e Q-F6; estrutura §5.10 criada nesta sessão (sem código) |
| Pedido/nota só no ERP | "aplicativos de vendas que poderá criar orders e enviar para autorização" | ⚠️ **Q-F21**: onde vive o PEDIDO desses apps — no ambiente do cliente (setes-api, que então orquestra faturar + autorizar) ou a `fiscal-api` passa a aceitar pedidos? A leitura fiel ao parecer §3 é a primeira; a segunda recria o ERP dentro da API fiscal |

Leitura adotada para "seguindo as estruturas do setes-app": o mesmo TRATAMENTO que os projetos existentes têm — pasta própria na raiz, repositório git próprio, `CLAUDE.md` do repo, espelho `Infra-IA/<projeto>/` com `INDEX.md` + prompts fechados + skills, linha nas tabelas fixas (CLAUDE.md da raiz, `ORGANIZACAO_PASTAS.md`, `INDICE_CENTRAL.md`). O CÓDIGO segue o molde do setes-api (Node/TS: `gateway/ · modules/ · shared/ · migrations/`, módulo em 6 arquivos — `ARQUITETURA_MODULOS_API.md`), porque a fiscal-api é uma API, não um app Flutter. Se o Valdo quis algo diferente com "setes-app", é a Q-F26.

---

## 2. Objetivos (numerados)

1. **Isolar a emissão de NFS-e** num serviço próprio (pedido: `nfse-api`; parecer §3.E: `fiscal-api`, família `/nfse` — Q-F1) consumível por qualquer aplicação autenticada — sem conhecer pedido, nota ou cadeia do ERP.
2. **Transformar o setes-api em CONSUMIDOR** desse serviço, sem mudar o setes-app (a porta do app continua `/api/billing/fiscal*` e `/api/establishment/issuer*`).
3. **Nascer escalável**: instâncias sem estado em memória que precise ser único; travas no banco; cofre e XML em backend compartilhável; contrato versionado (`/v1`).
4. **Preparar a família NF-e** (pedido: `nfe-api`; parecer: família `/nfe` do mesmo serviço — NF-e 55, NFC-e 65 apontada) sobre o MESMO núcleo (emissor, cofre, transmissão/voz, assinatura, transporte, PDF) — a NF-e **nasce na API, nunca no ERP** (parecer §3.I-6), respeitando a D-E20 (execução com o 1º cliente de mercadoria) salvo decisão nova.
5. **Zero regressão** na Setes: as 704+ NFS-e já emitidas, o A1 no cofre, XMLs em disco e a trilha `trilha-primeiro-cliente.ts` (P8a/P8b) continuam OK após o corte.
6. Gates do método (socrático ≥ 0,70 · adversarial sem HIGH) em cada onda; a API fiscal entra em produção **antes** do ERP como piloto da Onda 4 — ou junto, conforme Q-F10.

---

## 3. Parecer do guardião conceitual (Rodada 0)

> Parecer do agente `setes-conceito` (2026-10-03), colado como veio. **Diverge do rascunho inicial (§4–§5) em quatro pontos, já refletidos abaixo e nas questões §8**: (1) o conceito é UMA API (`fiscal-api`), duas só como topologia; (2) o ERP não guarda ESTADO fiscal — só o VÍNCULO nota × documento; (3) a série do 55 é de quem NUMERA (ERP), a do DPS é de quem DECLARA (API) — D-E2 diverge; (4) o banco da API não pode casar com o prefixo `setes_<cliente>`.

Fatos conferidos no disco: `shared/tax-authority/*`, `shared/invoice-transmission/*` (composição + `branches/service.ts` + repositório), `fiscal-issuer`, `secret-store`, `danfse`, `billing.fiscal.service.ts`, `establishment.issuer.service.ts`, bloco `fiscal` de `invoice-cancel.ts`, DDL de `tb_establishment_issuer`/`tb_invoice_service_transmission(_event)`, `tb_sync_api_key` + `sync.auth.middleware.ts`. Nenhuma decisão do INDICE_CENTRAL trata de isolamento; as que o parecer TOCA (D-E2, D-N7) estão devolvidas nos pontos 2 e 3.

### 3.A Conceito

**Conceito único**: *um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele.* A hipótese do rascunho acerta no que NEGA (não calcula imposto; não conhece pedido/nota) e esconde um "e" no que afirma: "assina, fala, guarda voz e XML" é UM processo (a declaração), mas "recebe fatos do emitente" junta fatos geradores distintos:

| # | Conceito (uma frase) | Fato gerador | Hoje | Natureza |
|---|---|---|---|---|
| 1 | Este CNPJ fala com o fisco com o SEU A1, por modelo/ambiente | upload do A1 + linha por modelo | `tb_establishment_issuer` + cofre | peça (habilitação) |
| 2 | Este documento foi declarado ao fisco: N tentativas × voz × XML | o pedido de transmissão | `_transmission` + `_event` + disco | peça (apresentação × voz — a mesma peça de método do boleto) |
| 3 | Quem pode PEDIR ao serviço, por quais emitentes | licenciamento do consumidor | não existe (`tb_sync_api_key` é outro fato) | peça de fronteira — não é fiscal |

A API é a **composição** das três: a política "como tratamos a voz de um fisco" é o `invoice-transmission.ts` de hoje SEM o efeito local. O arquivo se parte em dois: política da voz (API) × montador do pedido + efeito (ERP). **Teste do terceiro cego**: o Gestao2016 não tem `tb_entity` — tudo que o contrato exigir e ele não puder MANDAR está do lado errado da cerca.

### 3.B Fronteira

Regra de corte: **o ERP responde pelo CONTEÚDO (o que foi vendido/prestado, por quem, a quem); a API, pelo FORMATO e pela CONVERSA (leiaute/Anexo I, assinatura, transporte, voz, arquivo).**

| MIGRA para a API | FICA no ERP | VIAJA no contrato |
|---|---|---|
| `tax-authority` inteira (adn, https-json mTLS, xmldsig paramétrico, dps-builder = forma do leiaute) | ramo `tb_invoice_service` congelado no faturamento (`dps_number` aposentado — é identidade do documento na API); `tb_invoice_event` E/C; `cancelInvoice`; `buildCancelPlan` (bloco `fiscal` lê o VÍNCULO local + a API) | fatos do emitente: CNPJ, IM, cMun IBGE, opSimpNac/regApTribSN/regEspTrib, pTotTribSN — lidos de `tb_entity*`/`tb_entity_tax` pelo ERP |
| `fiscal-issuer` (habilitação por modelo, PKCS#12→PEM, `openIssuer`, guardas de transmissão viva ao mudar ambiente) re-chaveada pelo emitente | `buildEmitter`/`buildRecipient`/`buildDpsBase` viram o MONTADOR do pedido (os 422 de cadastro incompleto são do ERP); L8 (base ISS ≠ valor); `assertTransmittable`; vida da nota (D-N27) | fatos do tomador (documento, nome, endereço) |
| `secret-store` owner do A1 (a peça é UMA; o owner `bank-account` fica no ERP — D-I1 preservada) | privilégios TRANSMITIR/CANCELAR por ramo e resolver de interface; telas "No fisco"/"Emissor fiscal" viram CLIENTES da API | fatos do serviço/itens congelados (cTribNac, cTribMun, vServ, retenção, exigibilidade, descrição, dCompet) |
| transmissão (attempt, ambiente congelado, write-once, `last_queried_at`, reconciliação por dps_id/chave, K→N, rodízio, órfã) + voz append-only | `tb_entity_tax` (o regime também alimenta a regra de ISS) | `dhEmi`/`dhEvento` com offset da zona (Q-TZ2); motivo do cancelamento; autoria opaca (`external_user`) |
| arquivo `STORAGE_PATH/<cnpj>/<ano>/<mes>` (já é por CNPJ), DANFSe/DANFE (função pura do XML), PAM, matriz do Anexo I (`emitterDpsFacts`: E0166/E0712 são conhecimento do fisco) | — | — |

Transmissão e voz são **da API**. O ERP guarda **(1) o vínculo** nota × documento, por VIDA e por MODELO (conjugada = 2 documentos) — fato do ERP ("entreguei esta vida à API como documento X", ato de quem tem TRANSMITIR) e âncora do plano de cancelamento com a API fora (sem vínculo = nunca declarada = cancela local sem perguntar a ninguém; com vínculo = pergunta à API antes, como a Q-ADV1b já faz) — e **(2) o efeito** (`tb_invoice_event` C). Nenhuma coluna de estado fiscal no ERP: estado é DERIVADO na API; lista e detalhe leem por lote de referências (ponto 4).

### 3.C Identidade

Três papéis, três peças: **licenciado** (quem chama, chave) → **emitente** (CNPJ em cujo nome falamos, dono do A1 — pela D-N29 o A1 É do CNPJ, logo o emitente pode NASCER do upload) → **habilitação** (emitente × modelo: ambiente, série/contador do SE). `tb_sync_api_key` NÃO serve: seu conceito é "esta instalação do legado escreve no schema desta institution" — amarra a `tb_institution`, o acoplamento que a isolação quer cortar. Peça nova, no banco próprio da API. UNIQUE `(licenciado, emitente, external_code)` dá POR CONSTRUÇÃO a idempotência que o Inter não dava (Q11: seuNumero não era único) — retry pós-timeout acha o documento em vez de criar o segundo.

### 3.D O efeito atravessa a fronteira

É **fiel** — é a forma pura do modelo. O SAVEPOINT era conveniência de banco compartilhado; o invariante sempre foi "só a voz muda estado; o efeito é aplicado pela composição; recusa = fato + pendência" (D-I10). Com dois serviços, TODA aplicação de efeito vira o que o webhook do Inter já é: voz chega (notificação ou consulta) → efeito na transação do ERP → ack à API com a referência do efeito; sem ack = pendente (espelho exato de `PENDING_EFFECT_WHERE` e da reaplicação D-I25). Guardas: at-least-once exige efeito idempotente (`recordCancelVoice` já é por KIND; `applyCancelEffect` já devolve o C existente); a API registra que o licenciado ACUSOU (`licensee_effect` no lugar de `invoice_event` na voz) sem saber o que o efeito é. Vira maquete se o ERP decidir por estado em cache em vez da voz, se a API conhecer `tb_invoice_event`, ou se um C local nascer sem voz.

### 3.E Uma API ou duas

Conceitualmente **UMA**: um emitente, um A1 (D-N31), uma habilitação por modelo (D-E1), uma política (D-E6 — "o legado errou nos gêmeos 55×65"), estratégia por documento. **(iii)** duas APIs com cofre próprio = o emitente sobe o MESMO A1 em dois cofres e tem duas habilitações para um CNPJ — "mesmo fato em dois lugares" + "composição gêmea por modelo", que o §3.11 da NF-e já lista como maquete. **(ii)** só é legítima como TOPOLOGIA de (i): um repo, um banco, um cofre, dois processos (`--family nfse|nfe`). **(i) Recomendado.** Nomear o serviço pelo DOCUMENTO (`nfse-api`/`nfe-api`) repete o erro de `tb_nfse` paralela: o nome é o conceito (emissão fiscal), o documento é o ramo.

### 3.F Nomes

| Objeto | Nome | Por quê / colisões evitadas |
|---|---|---|
| Serviço | `fiscal-api` (famílias `/nfse`, `/nfe`) | conceito, não documento |
| Quem chama | `tb_licensee` (Recomendado) · alt. `tb_client` | "licença" já é o sentido de `tb_institution.active` (PADROES §6); livre no acervo. `client` colide com "cliente" = tenant e com customer; `consumer` com consumidor final (indFinal); `credential` é como os comentários chamam o A1 |
| Emitente | `tb_emitter` (cnpj, `time_zone` — pasta do mês Q-TZ7; cofre `emitter/<id>/P/`) | "emitente" já é a palavra do `prest` do DPS |
| Habilitação | `tb_issuer` (PK `tb_emitter_id, model`) — sucessora de `tb_establishment_issuer` | "emissor" continua = habilitação |
| Documento no serviço | `tb_fiscal_document` (raiz: emitente, modelo, `external_code`, número) + transmissão/voz por FAMÍLIA de autoridade (ADN × SEFAZ — fatos diferem, D-E6) | "documento" sozinho = CPF/CNPJ no ERP (`by-document`); DF-e é o termo oficial |
| Referência do consumidor | `external_code` | palavra da casa para "id no outro sistema" (sync) |
| Vínculo no ERP | `tb_invoice_fiscal_document` (nota, vida, modelo, id na API) — sem FK, molde `tb_bank_slip_title` | vínculo ≠ estado |
| Notificação | colunas `notified_at` + `licensee_effect` na voz; URL do licenciado + `inbound_token` (molde do canal); receptor no ERP `/hooks/fiscal-document/:inst/:token` (molde `/hooks/bank-channel`) | sem `tb_notification`: "avisamos" é fato da voz, como `last_queried_at` é "olhamos" |

### 3.G O que NÃO entra (e por quê)
Reuso de `tb_sync_api_key` (fato gerador ≠) · estado fiscal em coluna do ERP (decidido fora = status) · schema-por-cliente dentro da API (um banco, escopo por linha `tb_licensee_id`) · cópia da cadeia de entidade na API (teste do terceiro cego) · cálculo de imposto na API · `tb_integration*`/`tb_nfe*`/`tb_nfse*` · usuário do ERP como FK na API (autoria é texto opaco) · segunda tabela de voz no ERP (duas verdades).

### 3.H Onde vira maquete
Cofre/emissor duplicado por API · API que conhece `tb_invoice`/`tb_order` · ERP que cancela local sem perguntar à API quando HÁ vínculo · "status" sincronizado por cron · série do 55 na API (quem numera é o ERP — ponto 2) · `external_code` sem UNIQUE · callback sem consulta (D33: polling faz a ponte; os dois convivem, uma porta de efeito só).

### 3.I Pontos que exigem decisão do Valdo (levados à §8 como Q-F16…Q-F20 e revisões de Q-F1/Q-F5/Q-F6/Q-F8)

1. **Granularidade do licenciado para o próprio ERP**: (a) um por institution — espelho da D12, cerca do emitente feita pela API, chave no cofre `establishment/<inst>` (Recomendado; custo: provisionamento no POST de institutions com uma credencial de serviço) · (b) um para o setes-api inteiro com N emitentes (mais simples; a cerca por CNPJ fica só no ERP).
2. **D-E2 diverge** ("série no emissor aposenta `invoice_serie`" pressupunha emissor e numeração no mesmo lugar): a série do 55 é fato de quem NUMERA (ERP); a do DPS, de quem DECLARA (API). (a) API guarda série/contador só do SE; 55/65 numeram no ERP e a série viaja no payload (Recomendado) · (b) API guarda as séries de todos e o ERP a lê antes de cunhar (ERP não numera com a API fora — maquete).
3. **D-N7 relaxa** ("voz C → C local na MESMA transação" é impossível entre serviços): confirmar o invariante como "C local SÓ da voz; efeito na transação do ERP; recusa ou falha = pendência visível e reaplicável" (Recomendado) — já é o que vale para o C vindo da consulta.
4. **Leitura de estado pelo ERP**: (a) sem espelho — lista e detalhe por lote de referências; API fora = selo "indisponível" e ações fiscais 503 (Recomendado: zero coluna de estado) · (b) espelho de exibição escrito SÓ pela notificação, nunca decisório — se a latência da lista doer.
5. **Banco da API**: nome fora do prefixo `setes_<cliente>` (`setes_fiscal` casaria com `SCHEMA_RE`) — ex.: `fiscal_api`; um banco, escopo por linha.
6. **Ordem**: (a) extrair AGORA com a NFS-e em produção como piloto, contrato já paramétrico por família — a NF-e nasce na API, nunca no ERP (Recomendado) · (b) NF-e no ERP primeiro e extrair as duas depois (paga a extração duas vezes).
7. **Palavra do licenciado**: `tb_licensee` × `tb_client` — palavra é decisão do Valdo (lição "contrato").

*Arquivos lidos pelo guardião (nenhum editado)*: guardiao-conceitual.md · PADROES_BANCO.md · INDICE_CENTRAL.md · os dois prompts fiscais (§3/§4/§8/§10) · `tax-authority/{types,xmldsig,dps-builder,https-json}.ts` + `adapters/adn.ts` · `invoice-transmission/*` · `fiscal-issuer/*` · `secret-store.ts` · `danfse.ts` · `invoice-cancel.ts` (bloco `fiscal`, 322–373) · `billing.fiscal.service.ts` · `establishment.issuer.service.ts` · `sync.auth.middleware.ts` · `sql/03_schema_cliente_ddl.sql` (479–525) · `sql/05_sync_api_key.sql`.

---

## 4. Fronteira proposta — o que migra, o que fica, o que nasce

> ⚠️ **SUPERADA onde conflitar com o §12** (Rodada 2: a API lê o ERP — D-F10; efeito no setes-api — D-F11; dois projetos + núcleo — D-F12/D-F17).

Hipótese organizadora, **confirmada pelo parecer §3.A/§3.B com duas correções**: *um emitente habilitado declara um documento fiscal ao fisco e recebe a voz dele* — a API responde pelo FORMATO e pela CONVERSA (leiaute, assinatura, transporte, voz, arquivo); o ERP responde pelo CONTEÚDO (o que foi vendido/prestado, por quem, a quem). Não calcula imposto. Não conhece pedido, nota, cliente ou cadeia do ERP. Correções do parecer sobre o rascunho: (1) a matriz do Anexo I (`emitterDpsFacts` — E0166/E0712) é conhecimento do FISCO e migra; (2) o ERP **não guarda estado fiscal** — guarda o VÍNCULO nota × documento (Q-F16).

| Peça hoje (setes-api) | Destino | Trabalho | Linhas |
|---|---|---|---|
| `tax-authority/*` (types, adn, dps-builder, https-json, xmldsig) | **`fiscal-api`** (núcleo comum às famílias) | MOVER sem mudança de contrato; `AuthorityContext` continua recebendo o par PEM | 1.054 |
| `secret-store` | **copiar** para o núcleo (owner `emitter`); o setes-api MANTÉM a sua para o canal do banco | COPIAR + renomear owner; o caminho deixa de ter `<schema>` (identidade = emitente) | 149 |
| `fiscal-issuer` | núcleo | MOVER + reindexar: PK `(institution, model)` → `(emitente CNPJ, model)`; validação do CN × CNPJ já existe (D-N29b) | 416 |
| `transmission.repository` + máquina de estados de `invoice-transmission.ts` (reserva → fisco → voz → reconciliação K/F → refresh/rodízio) | `fiscal-api` (política da voz, por família de autoridade) | MOVER + reindexar: `(institution, invoice, terminal, attempt)` → `(documento, attempt)`; a "nota mudou?" (MEDIUM-3) fica no ERP (vida da nota no `external_code`) | ~1.400 |
| `branches/service.ts` — leitura do ERP (`readServiceInvoice`, `buildEmitter`, `buildRecipient`, `buildDpsBase`, `assertTransmittable`, L8) | **FICA no setes-api** como *montador do pedido* (`@shared/fiscal-client/nfse-facts.ts`) — os 422 de cadastro incompleto são do ERP | ADAPTAR: o resultado deixa de virar XML aqui e vira o PAYLOAD da API (`DpsInput` sem série/nDPS — já é assim: `DpsBase`); **`emitterDpsFacts` (matriz do Anexo I) MIGRA**; **`dps_number`/`lockDpsNumber` morrem no ramo** (a identidade do documento é da API — §3.B) | ~350 ficam / ~250 migram |
| `applyCancelEffect` / `reconfirmBeforeLocalCancel` / bloco `fiscal` do `buildCancelPlan` | **FICA no setes-api** | ADAPTAR: o bloco lê o VÍNCULO (FOR UPDATE) e pergunta à API ANTES da transação (a Q-ADV1b já faz isso com o fisco); sem vínculo = nunca declarada = cancela local sem perguntar; efeito idempotente + ack à API (`licensee_effect`) | ~300 |
| `danfse` | `fiscal-api` — `GET /v1/nfse/documents/{id}/danfse` | MOVER (função pura do XML); o nome/município do emitente passam a vir de `tb_emitter` (hoje vêm da cadeia) | 168 |
| `billing.fiscal.*` + 9 rotas · `establishment.issuer.*` + 5 rotas | **FICAM** como porta do app | ADAPTAR: service chama o cliente HTTP em vez da composição; privilégios TRANSMITIR/CANCELAR continuam aqui (Q-F11) | ~565 |
| `tb_establishment_issuer` · `tb_invoice_service_transmission` · `_event` (058–061) | **nascem no banco do serviço** como `tb_licensee` · `tb_emitter` · `tb_issuer` (emitente × modelo) · `tb_fiscal_document` + transmissão/voz por FAMÍLIA de autoridade (§3.F) | DDL novo (`revisar-ddl`) + **migração única dos dados da Setes** (transmissões, vozes, XMLs, A1) | 6 tabelas + script |
| Vínculo no ERP: `tb_invoice_fiscal_document` (nota × vida × modelo × id do documento na API; sem FK, molde `tb_bank_slip_title`) | **novo no setes-api** | NOVO: **sem coluna de estado** (§3.B/§3.I-4 — estado é derivado na API e lido por lote de referências); alternativa (b) espelho de EXIBIÇÃO escrito só pela notificação = Q-F16 | 1 tabela |
| Testes (7 arquivos) | 5 migram (mocks na fronteira já isolam `pool`/adapter), 2 ficam/adaptam (cancel adversarial, folder-zone) | ADAPTAR nomes de módulo e chaves | 1.460 |
| `runningRefresh` / `runningBatch` em memória | morrem | trava no banco (linha do emitente `FOR UPDATE WAIT`) ou semântica "1 por instância" declarada | — |

**O que NÃO migra (e por quê)**: `tb_invoice_event` E/C e `cancelInvoice` (vida da nota é do ERP); `calcIssqn`, `@shared/service-tax-rule`, `@shared/tax-rule` (imposto é do ERP — a API declara, não calcula); `tb_entity_tax` 062/063 (fatos do emitente são CADASTRO do ERP e viajam no payload — Q-F15; o regime também alimenta a regra de ISS); privilégios de ação (autorização de USUÁRIO é do ERP; o serviço autentica o LICENCIADO); `lockInvoice`/`lockInstitutionCounters` (o contador nDPS migra para o serviço; o lock da nota e a numeração do 55/65 ficam — §3.I-2); a cadeia de entidade (teste do terceiro cego: o Gestao2016 não tem `tb_entity`).

---

## 5. Arquitetura proposta (Rodada 0 — tudo sujeito às Q-F)

> ⚠️ **SUPERADA onde conflitar com o §12** — em especial §5.1 (contrato por fatos), §5.2/§5.8 (licenciado/app — D-F13/D-F14), §5.3 (setes-api cliente — D-F4), §5.4 (cofre em arquivo — D-F16), §5.6/§5.10 (um projeto — D-F17). §5.5 e §5.9 seguem valendo.

### 5.1 Contrato externo da `fiscal-api` — família `/v1/nfse` (OpenAPI design-first)

Vocabulário: o do adaptador (`DpsInput`, `CancelEventInput`, `ParsedNfse`) — já é o vocabulário do XSD, não do ERP. Nomes conforme o parecer §3.F (`licensee` · `emitter` · `issuer` · `fiscal document` · `externalCode`).

| Recurso | Operação | Semântica |
|---|---|---|
| `POST /v1/emitters` · `GET /v1/emitters/{cnpj}` · `PUT /v1/emitters/{cnpj}/models/{SE}` | habilitação | emitente = CNPJ + identidade fiscal mínima (cMun IBGE, IM, nome, fuso IANA) + linha por modelo (ambiente H/P, série, contador) |
| `PUT /v1/emitters/{cnpj}/certificate` (.pfx + senha) · `GET` (só metadados) · `DELETE` | cofre | PKCS#12 → par PEM; senha nunca persiste (D-N5); UM A1 por emitente (D-N31) |
| `POST /v1/nfse/documents` | transmitir | corpo = fatos do DPS (competência, prestador: regTrib/pTotTribSN, tomador, serviço, valores, `dhEmi` com offset da zona) + `externalCode` (id do consumidor) + `externalUser` (autoria opaca); idempotência POR CONSTRUÇÃO pelo UNIQUE `(licensee, emitter, external_code)` — retry pós-timeout ACHA o documento (§3.C); **síncrono** com o ADN: 201 A (chave, número, dhProc) · 422 R (códigos E0xxx no `fields[]`) · **202 K/em voo** no desfecho ambíguo (nada fecha — D-I21) |
| `GET /v1/nfse/documents/{id}` · `GET /v1/nfse/documents?externalCode=a,b,c` (lote) | estado | linha do tempo (vozes), estado derivado da última voz da última tentativa, chave, número, pendências; o lote por referências é como a lista do ERP mostra o selo fiscal (Q-F16) |
| `POST /v1/nfse/documents/{id}/attempts` | reapresentar | `attempt + 1` só com a anterior resolvida (R/F); mesma vida = mesmo nDPS (D-N3/D-N18) |
| `POST /v1/nfse/documents/{id}/refresh` · `POST /v1/emitters/{cnpj}/refresh` | consulta | voz por consulta (source Q), rodízio por `last_queried_at`, orçamento de tempo |
| `POST /v1/nfse/documents/{id}/cancel` {motivo} | cancelar no fisco | e101101 síncrono; voz C; **o efeito no ERP é do consumidor** (§5.3) |
| `POST /v1/nfse/documents/{id}/events/{n}/ack` {effectRef} | acusar efeito | o licenciado diz "apliquei o efeito desta voz" (`licensee_effect` na voz — §3.D); voz sem ack = pendência visível dos dois lados |
| `GET …/xml` · `GET …/danfse` · `GET …/events` | arquivos | XML autorizado / evento de cancelamento / PDF nosso |
| `GET /v1/health` · `GET /v1/emitters/{cnpj}/authority-status` | operação | prazo do PAM (D-N15) e disponibilidade |
| Notificação (opcional, Q-F4) | callback | `POST` na URL do licenciado com `inbound_token` (molde do canal do banco) a cada voz nova — só GATILHO de consulta, nunca fonte de verdade (D-I9); `notified_at` na voz; receptor no ERP `/hooks/fiscal-document/:inst/:token` (molde `/hooks/bank-channel`) |

Regras herdadas que o contrato fixa: estado DERIVADO da última voz (nunca coluna `status`); 2xx ilegível = ambíguo (502/K), nunca aceite; recusa de REGRA ≠ transitório (`retryable`); erros com `{error, code, fields[{field, message, expected?}]}` (framework de mensagens).

### 5.2 Identidade e autenticação

- **Licenciado** (`tb_licensee` — parecer §3.C/§3.F; alternativa `tb_client`, Q-F20): quem chama, com chave (`X-Api-Key`, hash no banco, precedente D12 do sync) ou OAuth2 client-credentials (Q-F3). É dono de N emitentes. Autoriza o *acesso*, não a *ação*: TRANSMITIR/CANCELAR por usuário continuam no ERP (Q-F11). Para o próprio setes-api: um licenciado por institution (cerca feita pela API) × um para o ERP inteiro — Q-F17.
- **Emitente** (`tb_emitter`) = CNPJ em cujo nome falamos, dono do A1 (pela D-N29 o A1 É do CNPJ — o emitente pode NASCER do upload), com `time_zone` (pasta do mês, Q-TZ7). **Habilitação** (`tb_issuer`, PK emitente × modelo) = ambiente + série/contador **só do SE** (a série do 55/65 é de quem numera, o ERP — Q-F18). O setes-api mapeia `institution → CNPJ` (`tb_company.cnpj` da própria entity). Cofre: `SECRETS_PATH/emitter/<id>/P/` (um A1 por emitente — D-N31), sem `<schema>`.
- Rate limit por licenciado; idempotência pelo UNIQUE `(licensee, emitter, external_code)` (§3.C); auditoria por licenciado (quem pediu o quê, `externalUser` opaco).

### 5.3 O fluxo que atravessa a fronteira (NFS-e)

> ⚠️ Este fluxo (setes-api chamando a fiscal-api) está EM REVISÃO pela §11: o Valdo quer o setes-app como cliente direto e o setes-api passivo. A versão candidata do fluxo está em §11.3; esta fica como registro da Rodada 1 até a Q-F27 decidir.

```
setes-api (billing.fiscal.service)                 fiscal-api (família nfse)                ADN
  1. readServiceInvoice + buildDpsBase  ──► fatos  (FICA: ERP monta o PEDIDO; 422 de cadastro são do ERP)
  2. grava o VÍNCULO nota×vida×modelo → externalCode (ato de quem tem TRANSMITIR)
     ─ POST /v1/nfse/documents {externalCode, fatos} ──► UNIQUE(licensee, emitter, external_code): acha ou cria o documento
                                                       reserva attempt (lock emitente·série) → nDPS; assina; *-dps.xml ──► POST /nfse
                                                       voz A/R (source P) · ambíguo = K em voo  ◄──────────── 2xx / 4xx / timeout
  3. ◄── 201 {documentId, attempt, state A, chave, nº}   |  422 R (fields[])   |  202 K
  4. completa o vínculo com o documentId — transação do ERP, SEM o fisco dentro; NENHUMA coluna de estado (Q-F16)
  5. lista/detalhe/selo fiscal: GET /documents?externalCode=a,b,c (lote); API fora = selo "indisponível", ações fiscais 503;
     "Consultar" = POST /refresh
  6. cancelar nota: buildCancelPlan lê o VÍNCULO FOR UPDATE → sem vínculo = nunca declarada = cancela local; com vínculo =
     GET /documents/{id} ANTES da transação (como reconfirmBeforeLocalCancel já faz) → POST /cancel → voz C →
     cancelInvoice local na transação do ERP (idempotente) → POST .../events/{n}/ack; sem ack = pendência visível nos dois lados
     + "Reaplicar efeito" (D-I25)
```

O que muda de verdade: hoje voz e efeito moram na MESMA transação (SAVEPOINT). O parecer §3.D fixa que isso era conveniência de banco compartilhado — o invariante sempre foi "só a voz muda estado; o efeito é aplicado pela composição; recusa = fato + pendência" (D-I10). Com dois serviços, TODA aplicação de efeito vira o que o webhook do Inter já é; a D-N7 relaxa para "C local SÓ da voz; efeito na transação do ERP; falha = pendência reaplicável" (Q-F19). Vira maquete se o ERP decidir por estado em cache em vez da voz, se a API conhecer `tb_invoice_event`, ou se um C local nascer sem voz.

### 5.4 Persistência e arquivos

- Banco próprio **`fiscal_api`** (Q-F5 — NUNCA `setes_<algo>`: casaria com o `SCHEMA_RE` dos schemas de cliente, §3.I-5), um banco com escopo por linha `tb_licensee_id`: `tb_licensee` · `tb_emitter` (CNPJ, nome, cMun IBGE, IM, `time_zone`) · `tb_issuer` (emitente × modelo: ambiente, série/contador do SE) · `tb_fiscal_document` (emitente, modelo, `external_code` UNIQUE por licenciado×emitente, número) · transmissão (attempt, ambiente congelado, dps_id, chave, número, dh_proc, last_queried_at) e voz (append-only: kind + código cru + source + dh + `notified_at` + `licensee_effect`) **por FAMÍLIA de autoridade** (ADN × SEFAZ — fatos diferem, D-E6); amanhã inutilização (família NF-e). Mesma forma das 058–061 — só a chave muda.
- Migrations próprias do serviço (runner igual ao do setes-api); regra PADROES_BANCO (UTC na sessão, REPEATABLE READ, contadores por lock — §9/§10) herdada.
- XML em `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mes>/` (já é assim); cofre e storage atrás de interface com backend trocável (filesystem → objeto/KMS) — pré-requisito de 2+ instâncias.
- **Migração única dos dados da Setes**: `tb_establishment_issuer` → `tb_emitter` + `tb_issuer`; transmissões + vozes → documento/tentativa/voz com `external_code = <invoiceId>:<vida>`; XMLs copiados; A1 copiado para `emitter/<id>/P/`; o VÍNCULO do ERP (`tb_invoice_fiscal_document`) nasce do mesmo script; `dps_number` do ramo deixa de ser lido. Corte com homologação H antes de P (Q-F7).

### 5.5 Escala — o que o serviço precisa ter desde o 1º dia

1. Instância sem estado único: nenhum `Map/Set` de controle (lote/rodízio) — trava do emitente no banco (`FOR UPDATE WAIT n`, D-A23).
2. Serialização por construção: 1 tentativa viva por documento; contador por emitente×série sob lock (regra 7 do PADROES §9).
3. UNIQUE `(licensee, emitter, external_code)` por construção (replay = acha o documento e devolve o estado, nunca 2ª NFS-e — a chave repetida foi achado real da Q-N33; `seuNumero` não único foi o da Q11 do Inter).
4. Orçamento de tempo por requisição (o ADN leva segundos por DPS) e lote fora da API: quem lota é o consumidor (como hoje) ou uma fila interna com relatório consultável (candidata, não desta onda).
5. Logs estruturados com `documentId`/`externalCode`/`licensee`; `/health` que prova banco + cofre; métricas mínimas (documentos/dia por licenciado — contagem DERIVADA das tentativas, nada a modelar — Q-F12).

### 5.6 Repositórios, pastas e espelho de conhecimento (impacto na raiz fixa)

A raiz `D:\Gestao2027` tem tabela FIXA de pastas (CLAUDE.md / `ORGANIZACAO_PASTAS.md` §1). Qualquer opção abaixo exige atualizar as duas tabelas e criar o espelho `Infra-IA/<projeto>/` (regra de simetria).

| Opção | Pastas/repos | Prós | Contras |
|---|---|---|---|
| (a) duas pastas `nfse-api/` e `nfe-api/`, cada uma seu repo, cofre próprio | 2 repos + 2 espelhos | literal ao pedido | **maquete pelo parecer §3.E**: o emitente sobe o MESMO A1 em dois cofres e tem duas habilitações para um CNPJ; núcleo duplicado |
| (b) um repo `fiscal-api/` **com dois PROCESSOS por família** (`--family nfse` / `--family nfe`), um banco `fiscal_api`, um cofre | 1 repo + 1 espelho; 2 deployáveis | escala e deploy independentes por família; D-N31 por construção; código comum sem pacote publicado | legítima SÓ como topologia de (c) — mesma base de código, mesma verdade; disciplina de fronteira entre famílias |
| (c) **`fiscal-api/`** único — famílias `/v1/nfse` e `/v1/nfe` no mesmo processo **(Recomendado pelo guardião — conceito ÚNICO: um emitente, um A1, uma habilitação por modelo, uma política da voz)** | 1 repo, 1 espelho, 1 deployável | mais simples; nome pelo CONCEITO (emissão fiscal), não pelo documento (`tb_nfse` paralela foi o erro do legado) | escala uniforme — se a NFC-e pedir perfil próprio, vira (b) sem mudar modelo |

### 5.7 Deploy

Dockerfile (Node 20, `npm ci`, `tsc`, `node dist/server.js [--family nfse|nfe]`), `docker-compose` de dev (MySQL + setes-api + fiscal-api), variáveis (`DB_*`, `SECRETS_PATH`, `STORAGE_PATH`, `FISCAL_API_KEYS_PEPPER`), volumes para cofre/XML, HTTPS pelo LB da SaveInCloud, `pre-deploy` check (molde `scripts/pre-deploy-tz-check.ts`). A `fiscal-api` é candidata a **1º serviço publicado** (superfície pequena, contrato fechado, trilha P8 como régua) — Q-F10.

### 5.8 Multi-app por cliente (Rodada 1 — D-F2)

Três níveis, três fatos geradores — a estrutura do parecer §3.C ganha um nível abaixo do licenciado:

| Nível | Peça | Fato gerador | O que carrega |
|---|---|---|---|
| Cliente | `tb_licensee` | licenciamento (o cliente contrata a emissão) | identidade comercial, limites (req/min, documentos/dia), URL de notificação + `inbound_token`, `active` |
| Aplicativo | `tb_licensee_app` ⚠️ nome na Q-F20 | o cliente AUTORIZA um app a chamar em seu nome (setes-api, app Android de vendas, sistema de terceiro…) | `app_id` público + `secret` (só hash), **escopos** (`nfse:write`, `nfse:read`, `nfe:write`, `emitter:admin`), emitentes permitidos (todos do licenciado ou lista), `revoked_at`, `last_used_at` |
| Emitente | `tb_emitter` / `tb_issuer` | o A1 + a habilitação por modelo | como no §3.F |

Autenticação (revisa a Q-F3): o app troca `app_id + secret` por um **token curto** (`POST /v1/auth/token`, client-credentials simplificado, JWT de ~1 h assinado pela fiscal-api) e chama com `Authorization: Bearer`. A chave em si nunca viaja em cada requisição e a revogação é imediata na próxima troca. **Aplicativo móvel/web do usuário final NÃO guarda o secret**: ou opera através do backend do cliente (setes-api, que é um `tb_licensee_app` com escopo pleno), ou recebe do backend um token curto já trocado (token exchange) — Q-F22. Rate limit e auditoria por app (`externalUser` opaco continua sendo a autoria dentro do app). CORS liberado por lista de origens do licenciado (web direta); Swagger/OpenAPI público com exemplos por família é parte da entrega, não documentação interna.

Autorização de AÇÃO continua do ERP (Q-F11): a fiscal-api sabe que o app PODE emitir pelo emitente X; quem dentro do cliente pode apertar "transmitir" é regra do sistema que chama.

### 5.9 Dimensionamento para 1000 clientes (Rodada 1 — D-F3; premissas marcadas, número real = Q-F23)

| Premissa (a confirmar) | Valor assumido | Documentos/dia |
|---|---|---|
| 60 % dos clientes = serviços (NFS-e) | 600 × 30/mês ÷ 22 | ~800 |
| 40 % = mercadoria com NF-e | 400 × 20/dia útil | ~8.000 |
| metade dos de mercadoria tem PDV (NFC-e) | 200 lojas × 200/dia | ~40.000 |
| **Total** | | **~49.000/dia** (≈ 1,7/s média em 8 h; pico ≈ 5/s) |

Consequências de engenharia (o que a F3 precisa provar, não só declarar):

| Dimensão | Número derivado | Implicação |
|---|---|---|
| Concorrência com o fisco | 5/s × 1–3 s por autorização → 5–15 chamadas simultâneas | 2 instâncias Node bastam para a CPU; o gargalo é o fisco — orçamento por requisição, `keep-alive` por emitente, fail-closed quando a autoridade cai (regra D-I8) |
| Linhas no banco | ~5 por documento (documento, tentativa, 2 vozes, ack) → ~250 k/dia → **~60 M/ano** | índices por `(licensee, emitter, external_code)` e `(emitter, created_at)`; **particionamento por ano ou arquivamento** a partir do 1º ano; nunca `SELECT` sem escopo de licenciado |
| XML em disco | 8–15 KB × 49 k → **0,5–0,75 GB/dia → ~200 GB/ano** | filesystem local NÃO serve a 2+ instâncias nem a esse volume: **storage de objeto (S3-compatível)** atrás da interface que já existe (`storageRoot()`); retenção legal 5 anos |
| Certificados A1 | ≥ 1.000 pares PEM (N por cliente com filiais), renovação anual | cofre **criptografado em repouso** (KMS ou chave-mestra) atrás de `secret-store`; **alerta de vencimento por licenciado** (o A1 da Setes vence 08/10/2026 — caso zero do alerta) |
| Consultas ao fisco | rodízio por emitente; SEFAZ pune consulta repetida (cStat 656) | o `refresh` sai da requisição e vira **worker** com orçamento global e por emitente (mata `runningRefresh` por construção); NF-e assíncrona (recibo 103/105) exige o mesmo worker — Q-F25 |
| Lote do ERP | D27: 50 ordens/requisição, 60 s | continua no CONSUMIDOR; a fiscal-api é por documento. Fila interna só se um licenciado pedir "transmitir 5.000" — fora desta fase |
| Observabilidade | 1000 clientes = 1000 "ele disse que a nota não saiu" | log estruturado com `licensee/app/emitter/externalCode/documentId`, métricas por licenciado (documentos, rejeições por E0xxx, latência do fisco), `/health` que prova banco + cofre + storage |

Teste de carga como critério de aceite (§10.9): script `scripts/carga-fiscal.ts` contra um fisco FALSO (stub do ADN com latência e falhas configuráveis) simulando 1000 licenciados / 5 req/s por 30 min: p95 < 5 s fora do tempo do fisco, zero 500, zero documento duplicado, 2 instâncias.

### 5.10 Estrutura do projeto `fiscal-api` (Rodada 1 — D-F1; criada nesta sessão SEM código)

```
D:\Gestao2027\fiscal-api\                 ← repo próprio (valdosouza/gestao-2027-fiscal-api), porta 3002
├── CLAUDE.md                              regras para agentes (fronteira, nomes, teste do terceiro cego)
├── README.md                              estado: F0 — nada de código até D-F fechar F1
├── .env.example · package.json · tsconfig.json (paths @gateway/@modules/@shared — molde setes-api)
├── src/
│   ├── gateway/        auth por token de app (JWT curto) · rate limit por app · router /v1 · CORS por licenciado
│   ├── modules/        licensees · licensee-apps · emitters · issuers · nfse (documents/attempts/events/xml/danfse/ack) · nfe (F4) · auth (token) · hooks (notificação de saída)
│   ├── shared/         tax-authority (adn · sefaz) · xmldsig · secret-store (owner emitter) · storage (fs → objeto) · fiscal-document (máquina de estados por FAMÍLIA) · pdf (danfse · danfe) · db · errors · logger · swagger · time-zone
│   ├── migrations/sql/ banco `fiscal_api` (runner = molde do setes-api)
│   └── __tests__/
├── scripts/            migrate-from-setes-api.ts · smoke-adn-h.ts · carga-fiscal.ts · pre-deploy-check.ts
└── (contratos oficiais ficam no espelho: Infra-IA/fiscal-api/integracoes/ — hoje em Infra-IA/setes-api/integracoes/nfse-adn)

Infra-IA\fiscal-api\                      ← espelho de conhecimento (regra de simetria)
├── INDEX.md                               START HERE (criado 2026-10-03)
├── prompt_fase1_fiscal_api.md             (quando este prompt fechar — hoje em prompts/)
└── skills/                                (nascem com a F1: novo-modulo-fiscal, nova-familia-de-autoridade)
```

Entrou nas tabelas fixas da raiz (CLAUDE.md, `ORGANIZACAO_PASTAS.md`) e no `INDICE_CENTRAL.md` nesta sessão. Módulo de cadastro na fiscal-api segue `ARQUITETURA_MODULOS_API.md` (6 arquivos, `/v1/<modulo>`); o módulo `nfse` é tela de PROCESSO (molde `bank-slips`), não cadastro.

---

## 6. Plano em ondas e esforço

> ⚠️ **SUPERADO pelo §12.7** (ondas e esforço revistos na Rodada 2).

| Onda | Entrega | Tamanho | Esforço (sessões) | Calendário | Depende de |
|---|---|---|---|---|---|
| **F0 — Decisões + contrato** | Rodadas 1..N deste prompt (Q-F2…Q-F26); OpenAPI `v1` da `fiscal-api` (família nfse + auth de apps) escrito ANTES do código (design-first, nível PÚBLICO: exemplos, códigos de erro, limites), já paramétrico por família; DDL do `fiscal_api` revisado (`revisar-ddl`) | 1 OpenAPI (~800 linhas) + DDL (7 tabelas) | 3–4 | 2–3 dias | Valdo (decisões) |
| **F1 — `fiscal-api`, família nfse** | repo `fiscal-api/` (D-F1); mover tax-authority/xmldsig/secret-store/fiscal-issuer/danfse/máquina de estados + repository re-chaveado por emitente/documento; `emitterDpsFacts` (Anexo I); shell do serviço (**licenciado + apps + token curto + escopos + CORS por licenciado**, UNIQUE de idempotência, rate limit por app, OpenAPI servido, health, logger, migrations próprias); DTOs zod do payload; testes migrados + novos; script de migração dos dados da Setes; smoke contra o ADN H com o A1 real | ~3,7 k linhas movidas/adaptadas + ~2,4 k novas + ~2,3 k testes | 10–14 | 7–10 dias úteis (inclui 2 rodadas de gates) | F0 |
| **F2 — setes-api consumidor** | `@shared/fiscal-client` (HTTP, mapeamento de erros → `FISCAL_*`, retry só em `retryable`); `branches/service.ts` vira montador do pedido; VÍNCULO `tb_invoice_fiscal_document` + ack de efeito + pendências; `billing.fiscal.service` e `establishment.issuer.service` chamam o cliente; lista com selo por lote de referências (ou espelho de exibição — Q-F16); `buildCancelPlan.fiscal` lê vínculo + pergunta à API; `dps_number` aposentado no ramo; trilha P8a/P8b OK; app INALTERADO; corte H → P da Setes | ~2,1 k linhas alteradas + ~500 testes + 1 migration | 5–7 | 4–5 dias úteis (gates do delta) | F1 |
| **F3 — Produção ESCALÁVEL (piloto da Onda 4; D-F3)** | Dockerfile, compose, variáveis/segredos fora do repo, HTTPS/DNS (`fiscal.setesgestao.com.br`?), **2+ instâncias atrás do LB**, **storage de objeto para XML** atrás de `storageRoot()`, **cofre criptografado em repouso** atrás de `secret-store`, **worker de refresh/rodízio** (fim do `runningRefresh`), alerta de vencimento de A1 por licenciado, particionamento/arquivamento planejado, métricas por licenciado, backup, pre-deploy check, **teste de carga `carga-fiscal.ts`** (1000 licenciados × 5 req/s × 30 min contra fisco falso); `fiscal-api` publicada e o setes-api do dev apontando para ela | infra + ~1,2 k linhas (worker, storage/cofre adaptadores, carga) | 6–10 | 1–2 semanas + espera externa (DNS, SaveInCloud: oferta de objeto/KMS — Q-F25) | F2 + Q5/Q6 da fase Primeiro Cliente |
| **F4 — família nfe (NF-e 55) — nasce NA API, nunca no ERP (§3.I-6)** | levantamento oficial (`integracoes/nfe-sefaz/`: MOC 7.0, NT 2025.002, schemas PL, autorizadores, cStat); `adapters/sefaz.ts` (SOAP 1.2: autorização síncrona/assíncrona com recibo, consulta protocolo, status, evento 110111, inutilização) + `authorizers.ts`; builder NF-e 4.00 com grupos ICMS/CSOSN/IPI/PIS/COFINS/ICMSUFDest **+ IBS/CBS**; chave 44 (série e número vêm do ERP no payload — Q-F18) + cDV; validação XSD; voz com P e D; inutilização de faixa; DANFE A4 (motor pdfkit); ERP: `branches/merchandise.ts` como montador do pedido (6 snapshots + cadeia + NCM/CEST/EAN + transporte), vínculo por ramo, bloco fiscal por ramo, cópia de ordem #20, aba "Numeração"; app: seção "No fisco" no pedido faturado | ~8 k linhas novas no serviço + ~2 k no ERP + ~1,5 k Dart + ~3 k testes | 25–35 | 5–7 semanas (≥ 3 rodadas de gates; 1ª sessão real na SEFAZ-PR H crava cStat e assinatura) | **D-E20** (1º cliente de mercadoria) · fase IBS/CBS no motor (Q-F14) · e-CNPJ do cliente |
| **F5 — NFC-e 65 (PDV)** | QR Code v2 + CSC no cofre, contingência off-line (tpEmis 9) com transmissão posterior, prazo de cancelamento em minutos, série por terminal, DANFE NFC-e (bobina), fila assíncrona para volume | ~4 k serviço + PDV no app (onda própria do PDV) | 15–25 | 3–5 semanas | F4 + onda do PDV |

**Totais (Rodada 1)**: `fiscal-api` com NFS-e em produção ESCALÁVEL (F0–F3) = **24–35 sessões ≈ 5–6 semanas de calendário** com gates (era 18–27 na Rodada 0 — a diferença é multi-app, contrato público e produção para 1000); família NF-e (F4) = **+25–35 sessões ≈ 5–7 semanas**, só com fato gerador; NFC-e (F5) = +15–25. Comparação: a Onda 3 inteira (fisco desconhecido) levou 10 dias — F1+F2 movem código provado, por isso a faixa parecida apesar do volume maior. O parecer §3.I-6 pesa a favor de extrair AGORA: fazer a NF-e dentro do ERP e extrair depois paga a extração duas vezes.

**Frentes IRMÃS que a visão da Rodada 1 exige e que NÃO são da fiscal-api** (dimensionadas para o Valdo decidir se entram, quando e onde):

| Frente | Por quê a visão precisa dela | Tamanho | Onde vive |
|---|---|---|---|
| **S1 — setes-api como plataforma para apps de venda** (Q-F21 leitura (a)) | "aplicativos de vendas que criam orders e enviam para autorização" hoje só existem como setes-app com JWT de usuário; um app de terceiro precisa de credencial de APLICATIVO por institution, escopos, contrato `/v1` público de pedidos + faturamento + "faturar e autorizar" numa chamada (PDV não espera duas), documentação pública | 8–12 sessões | setes-api (prompt próprio — molde deste: licenciado/app vira `tb_institution_app`?) |
| **S2 — setes-api em escala de 1000 clientes** (Q-F24) | fatos do código hoje: `runMigrationsForAllInstitutions` roda as migrations dos N schemas a CADA boot (1000 schemas = minutos de boot e deploy serial); pool único `connectionLimit: 20`; rate limit 300/min por institution em memória; `interface-config` cache por processo | 3–5 sessões de DIAGNÓSTICO (medir com 1000 schemas sintéticos) antes de qualquer correção | setes-api (fase própria) |
| **S3 — IBS/CBS** (Q-F14) | pré-requisito da família NF-e e da própria NFS-e da Setes em 01/01/2027 | fase própria (motor + 2 builders) | setes-api motor + fiscal-api builders |

**Riscos que puxam para o teto**: (1) homologação do ADN só com o A1 real da Setes (vence **08/10/2026** — renovar antes de F1 terminar); (2) SaveInCloud/DNS fora do nosso controle (F3); (3) SEFAZ-PR em homologação exige e-CNPJ de empresa com IE — a Setes não emite NF-e (F4 precisa do cliente); (4) IBS/CBS é fase do motor do ERP, não da API — sem ela a NF-e de regime regular é rejeitada desde 03/08/2026; (5) XSD validation em Node não é nativa (libxmljs2 ou `xmllint` externo) — decidir na F4.

---

## 7. Decisões registradas (D-F — permanente; numeração contínua)

- **D-F1 (Valdo, 2026-10-03) — `fiscal-api` é UM novo projeto de primeiro nível**, com o mesmo tratamento dos projetos existentes: pasta `D:\Gestao2027\fiscal-api\` (repo próprio), espelho `Infra-IA/fiscal-api/` (INDEX + prompts fechados + skills), linha nas tabelas fixas da raiz. Fecha a **Q-F1** na opção (i) do guardião — uma API nomeada pelo CONCEITO, famílias `/v1/nfse` e `/v1/nfe` — e a **Q-F6** na opção (c). Topologia em dois processos por família (opção (ii)) continua disponível como decisão de deploy, sem mudar modelo. Leitura de "seguindo as estruturas do setes-app" registrada no §1.5 (estrutura de PROJETO; o código segue o molde do setes-api). *Por quê*: palavras do Valdo; coerente com o parecer §3.E (um emitente, um A1, uma política da voz).
- **D-F2 (Valdo, 2026-10-03) — todo cliente, inclusive a Setes, consome a API diretamente, com múltiplos aplicativos** (web, Android, iOS, apps de venda de terceiros), cada um acessando o PRÓPRIO ambiente do cliente. Consequências: licenciado = o CLIENTE (fecha a **Q-F17** em (a) — um `tb_licensee` por institution/cliente); nasce a credencial por APLICATIVO (`tb_licensee_app`, §5.8 — nome na Q-F20) com escopos e revogação; token curto por app (revisa a Q-F3, §5.8); CORS por licenciado; OpenAPI de nível público desde a F1. ~~O setes-api passa a ser UM dos apps do licenciado (escopo pleno), não o único consumidor.~~ ⚠️ **Esta frase está EM REVISÃO pela 3ª mensagem do Valdo (§11, Q-F27): ele não quer o setes-api como cliente da fiscal-api — o setes-app (e qualquer front-end) é o cliente.** As demais partes da D-F2 (licenciado = cliente, múltiplos apps, credencial por app, token curto) seguem valendo. *Por quê*: palavras do Valdo; a cerca por cliente é feita pela API (a D12 do sync já fazia por institution).
- **D-F3 (Valdo, 2026-10-03) — requisito não-funcional: a API publicada deve aguentar 1000 clientes emitindo e autorizando notas.** Vira dimensionamento (§5.9, premissas a confirmar na Q-F23), redefine a F3 como "produção ESCALÁVEL" (2+ instâncias, storage de objeto, cofre criptografado, worker, teste de carga como critério de aceite §10.9) e expõe as frentes irmãs S1/S2 (§6) que a fiscal-api não resolve sozinha. *Por quê*: número dado pelo Valdo; sem número, "escalável" não é testável.
- **D-F4 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F27 em (a)) — o setes-api é PASSIVO diante da fiscal-api: NUNCA a chama.** O setes-app (e qualquer front-end) é o cliente direto da fiscal-api. O setes-api (1) expõe os FATOS do documento (`GET /api/<ramo>/:orderId/fiscal-facts` — o `buildDpsBase` serializado + `externalCode` determinístico; os 422 de cadastro incompleto continuam do ERP), (2) emite o token FEDERADO que o app apresenta à fiscal-api, (3) VERIFICA offline o RECIBO assinado pela fiscal-api que o app porta (`POST /api/<ramo>/:orderId/fiscal-receipt`) e só então grava o vínculo e aplica o efeito, (4) recebe webhook de ENTRADA com o mesmo recibo (vozes sem humano). Os três mecanismos (federação, recibo assinado, webhook de entrada) são CONDIÇÃO da decisão — sem eles "o app é o cliente" vira "o ERP acredita no app" (maquete, §11.6). A frase "o setes-api é UM dos apps" da D-F2 MORRE; o resto da D-F2 vale. **A regra canônica "setes-app só fala com setes-api"** (D1 da revisão do sync; `ARQUITETURA_MODULOS.md` do app) passa a ser: *o app fala com as APIs DO PRODUTO por datasources DEDICADOS por API e por módulo; nunca cruza datasources; Sincronizador ↔ setes-sync segue intacto.* Consequências no plano (§11.4): F2 vira **F2a (setes-api passivo)** + **F2b (setes-app cliente — os 17 arquivos Dart do fiscal MUDAM)**; F1 ganha federação, recibos assinados com rotação de chave e CORS como caminho principal; a `trilha-primeiro-cliente.ts` vira um front-end que bate nas duas APIs; critério de aceite §10.12 passa a valer; F0–F3 = **30–43 sessões ≈ 6–8 semanas**. *Por quê*: palavras do Valdo ("não quero que setes-api vire cliente e sim o setes-app vire cliente de fiscal-api como qualquer outro front-end"); ERP sem dependência de saída (fiscal-api fora não derruba faturamento nem baixa); o A1 nunca transita pelo ERP; front-end de terceiro é cidadão de 1ª classe.
- **D-F5 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F28 em (a)) — emissão iniciada pelo SERVIDOR fica fora por construção, registrada como conhecimento negativo.** Sem chamada de saída, a rotina mensal não transmite sozinha e `fiscal_auto_transmit` (D-N9) só existe como "o app transmite logo após faturar" (dentro de uma tela, com humano). Hoje transmitir já é ato explícito do usuário — nada se perde hoje. **Não "consertar" depois** criando chamada de saída do setes-api à fiscal-api por conveniência: se um dia for preciso, nasce como decisão NOVA (a opção (b) — um único processo servidor-a-servidor como `tb_licensee_app` só para rotinas sem humano — fica registrada como caminho, não como autorização). *Por quê*: coerência com a D-F4; o modelo não impede a exceção futura.
- **D-F6 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F21 em (a)) — o PEDIDO dos aplicativos de venda vive no ambiente do cliente (setes-api).** Pedido e faturamento (impostos congelados) nascem no setes-api; a fiscal-api só recebe o documento PRONTO (fatos congelados) e nunca aceita pedido, item ou preço. Com a D-F4, "faturar e autorizar" é saga do FRONT-END: faturar no setes-api → `fiscal-facts` → fiscal-api → recibo de volta ao setes-api. O que a visão "apps de venda de terceiros criando orders" exige do setes-api é a frente irmã **S1** (setes-api como plataforma para apps: credencial de aplicativo por institution, contrato público de pedidos/faturamento), em prompt PRÓPRIO, fora desta fase. Atender quem NÃO usa o ERP ("motor de nota" que recebe pedido) é produto diferente — fora, sem prompt aberto. *Por quê*: a opção (b) recriaria o ERP dentro da API fiscal e contradiz o parecer §3 (conteúdo no ERP; formato e conversa na API).
- **D-F7 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F5 em (a)) — banco próprio `fiscal_api`, único, escopo por linha** (nunca `setes_<algo>` — casaria com o `SCHEMA_RE`). Vive na MESMA instância MySQL dos schemas do produto (topologia D-F9).
- **D-F8 (Valdo, 2026-10-03, Rodada 2 — fecha a Q-F13) — `/v1` na URL desde o 1º dia**; sem `Accept-Version`. O `/api` interno do setes-api segue acompanhando o app.
- **D-F9 (Valdo, 2026-10-03, Rodada 2 — topologia de produção na SaveInCloud, texto fiel)**: *"Instância MySQL — com todos os schemas e IP próprio · Instância node setes-api · Instância node setes-sync · Instância node nfe-api ou fiscal-api (prefiro projeto próprio) · Instância node nfse-api ou fiscal-api (prefiro projeto próprio) · Instância Plesk gerenciador de domínio — com o domínio que será o gate de acesso do cliente — com a publicação do build do Flutter apontando para setes-api, nfe-api, nfse-api."* Leitura: banco `fiscal_api` (D-F7) dentro da instância MySQL comum; **duas instâncias Node fiscais (uma por família)**; o build Flutter publicado no Plesk aponta para TRÊS bases de URL (coerente com a D-F4: o app é cliente direto). Consequência imediata: instâncias separadas NÃO compartilham filesystem → o cofre do A1 e o arquivo de XML não podem ficar em disco local de uma instância (as duas famílias usam o MESMO A1 — D-N31) — entra na Q-F25. Se "projeto próprio" significa UM repo com dois processos ou DOIS repos: Q-F31 → decidida na D-F12 (dois projetos).
- **D-F10 (Valdo, 2026-10-03, Rodada 2 — resposta à Q-F15 + Q-F29 (a)) — a API fiscal LÊ o banco do produto para montar o XML e controla o ciclo de comunicação inteiro.** Texto fiel: *"considere que o setes-app envia a informação de um order para autorização, a nfe-api/nfse-api deve coletar tudo o que precisa do banco para gerar o xml e controlar o ciclo de comunicação incluindo envio, autorização ou cancelamento"*. O app manda só a REFERÊNCIA (nota/pedido); a API lê `setes_central` + `setes_<cliente>` na mesma instância MySQL (molde do setes-sync: serviço Node separado operando sobre os bancos do produto). **Porta isolada (Q-F29 (a))**: toda leitura do ERP vive em UM módulo — a *fonte de fatos Gestão 2027* — atrás de uma interface que entrega os fatos do documento (o `DpsBase` de hoje); o NÚCLEO (assinatura, transporte, tentativa, voz, arquivo, PDF) não conhece `tb_*` do ERP — a cerca do §10.1 passa a ser "nenhum `tb_invoice`/`tb_order`/`tb_entity*` FORA da fonte de fatos". Fecha a **Q-F2 em (a)** (tentativa, voz, nDPS, XML, DANFSe na API) e ABSORVE a **Q-F15** (nada de fatos no contrato: emitente, tomador, serviço, regime e pTotTribSN são lidos de `tb_entity*`/`tb_entity_tax`/ramo congelado no momento da transmissão; o `fiscal_api` guarda só habilitação + A1 + documento/tentativa/voz). **Revisa o parecer §3**: "API cega ao ERP" vale para o NÚCLEO, não para o serviço — a API é serviço do PRODUTO Gestão 2027; o teste do terceiro cego passa a valer para o núcleo (outra fonte de fatos — ex.: payload de um ERP de terceiro — é um adaptador novo, nunca reescrita). *Por quê*: palavras do Valdo; extração muito mais barata (o código de hoje já lê o ERP); o setes-sync é precedente de serviço separado sobre os mesmos bancos.
- **D-F11 (Valdo, 2026-10-03, Rodada 2 — Q-F30 (a)) — o EFEITO no ERP é do setes-api, lendo a VOZ direto no banco `fiscal_api`.** O app pede "Cancelar nota" ao setes-api; ele confere a voz C no `fiscal_api` (mesma instância) antes de cancelar local — sem recibo assinado, sem webhook, sem federação. Voz C sem C local = pendência visível e reaplicável (padrão `FISCAL_EFFECT_PENDING`/`countPendingEffects` de hoje). O setes-api continua sem chamar a API fiscal por HTTP (essência da D-F4 mantida); a API fiscal NUNCA escreve no ERP (só lê — candidata a ser garantida por GRANT, Q-F34). ABSORVE a **Q-F4** (a voz chega ao ERP pelo banco), a **Q-F16 em (a)** (nenhuma coluna de estado no ERP; selo e plano de cancelamento leem o estado DERIVADO no `fiscal_api`) e a **Q-F19** (C local SÓ com voz C lida do banco fiscal; efeito idempotente na transação do ERP; recusa = pendência). **SUPERA os mecanismos da D-F4** (`fiscal-facts`, recibo assinado JWS, webhook de entrada, token federado): a condição que eles protegiam — "o ERP nunca acredita no app" — é satisfeita pelo banco compartilhado (o app nunca porta estado; o ERP lê a verdade). Critério §10.12 reescrito em §10. *Por quê*: decisão do Valdo; mesma instância MySQL (D-F9) torna a leitura direta possível e transacional.
- **D-F12 (Valdo, 2026-10-03, Rodada 2 — Q-F31 (b)) — DOIS projetos, `nfse-api` e `nfe-api`, com NÚCLEO COMUM; o mesmo banco `fiscal_api` e o mesmo cofre.** REVISA a **D-F1** (que fixava UM projeto `fiscal-api`): "fiscal" continua sendo o nome do CONCEITO, do banco (`fiscal_api`, D-F7) e do núcleo; os deployáveis são dois, um por família, com escala independente (D-F9). O núcleo comum (assinatura XMLDSig, transporte mTLS, cofre, storage, máquina de tentativa × voz, habilitação, PDF, porta da fonte de fatos) é UM só — o mesmo A1 serve as duas famílias (D-N31) e há UMA habilitação por modelo por emitente (D-E1); duplicar o núcleo seria a maquete do §3.E. Onde o núcleo vive e como é consumido: Q-F33. A pasta `D:\Gestao2027\fiscal-api\` criada na D-F1 (sem código, git local sem remoto) é reorganizada conforme a Q-F33.
- **D-F13 (Valdo, 2026-10-03, Rodada 2 — Q-F32 (a)) — mesmo login do produto, assinatura ASSIMÉTRICA.** *(EXECUTADA no setes-api na A2 da F2a, 2026-10-12, worktree `f2a` — `@shared/auth/product-token`, §22.9)* O setes-api passa a assinar o JWT com par de chaves (hoje HS256 com `JWT_SECRET`, `auth.service.ts:63`); as APIs fiscais validam só com a chave PÚBLICA (nunca conseguem forjar token) e conferem TRANSMITIR/CANCELAR no schema do cliente pelo mesmo resolver do setes-api. ABSORVE a **Q-F3** (credencial de aplicativo sem humano — server-to-server, app de terceiro — é da frente S1, no setes-api, que emite o token), a **Q-F11** (a REGRA de privilégio continua do ERP; a porta fiscal a aplica lendo o ERP) e a **Q-F22** (o app usa o mesmo JWT curto; nenhum secret no dispositivo). A D-F2 segue valendo no "todo cliente, múltiplos apps" — mas a credencial por aplicativo (`tb_licensee_app`) sai da API fiscal e vai para a S1. O setes-sync (X-Api-Key) não muda.
- **D-F14 (Valdo, 2026-10-03, Rodada 2 — Q-F20 revista (a)) — NÃO existe `tb_licensee`: licenciado = institution do produto.** O JWT já traz `institutionId`; a licença fiscal = contrato de interface do produto (`tb_institution_has_interface` das telas fiscais), lido no schema do cliente pela porta fiscal. O emitente no `fiscal_api` é chaveado pela institution (+ CNPJ como atributo verificado contra o A1 — D-N29b), com habilitação por MODELO (D-E1); limites por config. REVISA a D-F2 (o "licenciado = cliente" fica, sem tabela própria) e os nomes do §3.F (`tb_licensee`/`tb_licensee_app` morrem nesta fase). *Por quê*: um fato a menos em dois lugares; coerente com D-F10/D-F13 (serviço do produto, mesmo login).
- **D-F15 (Valdo, 2026-10-03, Rodada 2 — Q-F34 (a)) — contrato de leitura por VIEWS publicadas + GRANT mínimo.** A API fiscal tem usuário MySQL com **só SELECT** em `setes_central`/`setes_*` (a D-F11 "a API fiscal nunca escreve no ERP" vira garantia de BANCO, não de disciplina) e controle total só no `fiscal_api`; o setes-api tem usuário com SELECT **só nas VIEWs publicadas** do `fiscal_api` (estado derivado por nota/vida/modelo, pendência de efeito). Tabela interna de um lado muda sem quebrar o outro; a view é o contrato e entra no versionamento como o OpenAPI. A **serialização transmitir × cancelar local** (hoje o mesmo `FOR UPDATE` na nota) é desenho da F0 — candidata: trava nomeada da instância (`GET_LOCK('fiscal:<schema>:<nota>', n)`), que não exige privilégio de escrita na tabela do outro lado. *Por quê*: decisão do Valdo; fronteira testável por GRANT.
- **D-F16 (Valdo, 2026-10-03, Rodada 2 — Q-F25 revista (a)) — A1 CRIPTOGRAFADO no banco `fiscal_api` desde a F1; XML atrás da interface de storage.** O cofre do A1 deixa de ser arquivo (`SECRETS_PATH`) e vira linha cifrada no `fiscal_api` (chave-mestra em variável de ambiente; KMS depois, atrás da mesma interface) — as duas instâncias fiscais (D-F9) leem o MESMO A1 sem disco compartilhado (D-N31 por construção). XML/DANFSe atrás de `storage`: filesystem no dev; backend de produção (objeto S3-compatível ou volume compartilhado) decidido na F3 com o que a SaveInCloud oferecer. Senha do PKCS#12 continua sem persistir (D-N5). *Por quê*: instâncias separadas não compartilham filesystem; o A1 é pequeno e precisa estar nas duas famílias; o XML é volumoso (§5.9).
- **D-F17 (Valdo, 2026-10-03, Rodada 2 — Q-F33 (b)) — `fiscal-api` é a BIBLIOTECA do núcleo comum (repo próprio, não roda sozinha); `nfse-api/` e `nfe-api/` são pastas/repos próprios que a consomem** — dependência `file:../fiscal-api` no dev, tag git no deploy. Três pastas na raiz (`fiscal-api` · `nfse-api` · `nfe-api`). A pasta `fiscal-api/` criada na D-F1 MUDA DE PAPEL (de serviço para biblioteca): sem porta, sem `server.ts`; o que roda (gateway, rotas `/v1`, health, OpenAPI servido) vive nos dois projetos de família, que compõem o núcleo. Fecha a Q-F31/D-F12 quanto ao "onde" e ABSORVE a **Q-F26** (a estrutura de projeto é esta; código no molde do setes-api; administração do emitente é tela do setes-app consumindo a API da família). *Por quê*: palavras do Valdo ("prefiro projeto próprio" para cada instância; "núcleo em fiscal-api"); custo aceito: mudança no núcleo = tag nova + atualização nos dois projetos.
- **D-F18 (Valdo, 2026-10-03, Rodada 2 — Q-F7 (a)) — corte dos dados da Setes por MIGRAÇÃO ÚNICA, homologação H antes de produção P, sem dual-write.** Script único copia emissor/habilitação, transmissões, vozes, XMLs e o A1 (agora cifrado no banco — D-F16) do setes-api para o `fiscal_api`; reconciliação por `dps_id` e trilha P8 são a prova; o DANFSe da nº 704 tem que renderizar igual.
- **D-F19 (Valdo, 2026-10-03, Rodada 2 — Q-F10 (a)) — extrair no DEV, depois a Onda 4.** F1 (núcleo `fiscal-api` + `nfse-api`) → F2 (setes-api passivo + setes-app cliente) no dev → **F3 = Onda 4 do produto inteiro já na topologia final da D-F9** (MySQL com todos os schemas, setes-api, setes-sync, nfse-api, Plesk com o build Flutter). A Onda 4 do `prompt_primeiro_cliente_setes.md` passa a herdar essa topologia. *Por quê*: não publicar uma topologia que muda logo depois.
- **D-F20 (Valdo, 2026-10-03, Rodada 2 — Q-F8 (a)) — `nfe-api` nasce AGORA como pasta + `CLAUDE.md` + espelho `Infra-IA/nfe-api/`, SEM código.** D-E20 mantida para o QUANDO: levantamento oficial da SEFAZ (`integracoes/nfe-sefaz/`) e código vêm com o 1º cliente de mercadoria (e depois do IBS/CBS — Q-F14). O núcleo `fiscal-api` já nasce paramétrico por família (estratégia por família de autoridade — D-E6).
- **D-F21 (Valdo, 2026-10-03, Rodada 2 — Q-F18 (a)) — série e número do 55/65 são cunhados pelo ERP no faturamento** (como hoje); a fonte de fatos os lê. A API guarda série/contador SÓ do DPS (modelo SE). Diverge da D-E2 (registrado no parecer §3.I-2): `tb_establishment_issuer.serie` do 55 fica no ERP; a linha SE migra.
- **D-F22 (Valdo, 2026-10-03, Rodada 2 — Q-F14 (a)) — IBS/CBS é FASE PRÓPRIA, com marco duro 01/01/2027** (Simples Nacional, inclusive a NFS-e da Setes). O MOTOR (cálculo + congelamento no setes-api) pode começar em PARALELO à extração; o BUILDER do grupo IBS/CBS do DPS entra na `nfse-api` depois da F1. Pré-requisito também da F4 (NF-e).
- **D-F23 (Valdo, 2026-10-03, Rodada 2 — Q-F23 (a)) — o §5.9 é PREMISSA de projeto até a F3**; o teste de carga da F3 (fisco falso, 2 instâncias) fixa o número real.
- **D-F24 (Valdo, 2026-10-03, Rodada 2 — Q-F24 (a)) — S2 (setes-api em escala 1000) começa por DIAGNÓSTICO**: fase própria mede boot, deploy e pool com 1000 schemas sintéticos — incluindo a leitura dos schemas pelas APIs fiscais (D-F10) — antes de qualquer correção.
- **D-F25 (Valdo, 2026-10-03, Rodada 2 — Q-F9 (a)) — legado Gestao2016 como consumidor = candidato FORA desta fase.** Exigiria uma 2ª fonte de fatos (payload) e decisão própria sobre a regra dos dois grupos.
- **D-F26 (Valdo, 2026-10-03, Rodada 2 — Q-F12) — cobrança/metering fora desta fase**; "documentos por institution/mês" é consulta DERIVADA das tentativas/vozes, nada a modelar.

- **D-F27 (Valdo, 2026-10-03, Rodada 3 — correção de premissa na resposta à Q-F35) — as APIs fiscais PODEM ESCREVER no ERP.** Texto fiel: *"na verdade a nfse-api e nfe-api podem escrever no ERP (schemas central e cliente)"*. REVISA a **D-F15** na parte "usuário MySQL só com SELECT em `setes_central`/`setes_*`" (a parte das VIEWs publicadas para o setes-api segue valendo). Consequências: (1) a garantia "a API fiscal nunca escreve no ERP" deixa de ser de BANCO — o que a API escreve no ERP passa a ser lista explícita com cerca por teste (escopo na Q-F44); (2) a serialização transmitir × cancelar local VOLTA a ser o `FOR UPDATE` na linha da nota (`tb_invoice`), provado pelos gates da Onda 3 — a trava nomeada `GET_LOCK` do §12.4 deixa de ser necessária (os três riscos que o guardião apontou nela, §13.1-5 (a)/(b), morrem com ela); a transação da nfse-api cruza `setes_<cliente>` e `fiscal_api` na MESMA conexão (mesma instância — D-F9); (3) a Q-F35 (onde mora o nDPS) é reaberta com a premissa corrigida.
- **D-F28 (Valdo, 2026-10-03, Rodada 3 — Q-F37 e Q-F38) — o cancelamento é uma OPERAÇÃO EM LINHA conduzida pelo app; nada de vínculo gravado nem job.** Texto fiel: *"considere uma operação em linha: app solicita o cancelamento da nfe/nfse via api própria (nfe/nfse); o retorno deve retornar para o App com a mensagem de ok ou não ok; conforme a mensagem o app avança com o envio do cancelamento para a setes-api"* e, na Q-F38, *"considere a resposta da pergunta anterior"*. Leitura: (1) `POST /v1/nfse/invoices/{id}/cancel` responde ok (voz C gravada) ou não ok (recusa/indisponível — o app NÃO avança); (2) com ok, o app envia o cancelamento ao setes-api (`POST /api/billing/cancel`), que confere a voz C e aplica o C local (D-F11); (3) **nenhuma tabela/coluna de vínculo do efeito** — pendência DERIVADA (voz C na vida vigente × nota ainda não-C), motivo recalculado pelo plano na hora (= Q-F37 (c)); (4) **nenhum job/worker de efeito** (= Q-F38 sem (a)): a voz C que chega sem humano (cancelada no portal, descoberta por consulta) fica como pendência VISÍVEL na lista/detalhe e é aplicada quando o app, num contato seguinte, recebe a voz e envia o cancelamento ao setes-api. **Conhecimento negativo**: não criar job de efeito no setes-api nem efeito aplicado pela API fiscal sem decisão nova.
- **D-F29 (Valdo, 2026-10-03, Rodada 3 — Q-F39 (a)) — pré-condições do cancelamento: o app CONSULTA o plano no setes-api antes de pedir o cancelamento à API fiscal (consultivo — mudou no meio = pendência, como a D-F11 aceita), e o setes-api EXIGE prova LIDA NO BANCO da reconfirmação**: para tentativa vigente com F por consulta em produção (Q-ADV1b), só cancela localmente se a view mostrar conferência no fisco (~~`last_queried_at`~~ → **`nfse_not_generated_at`, o E2404 EXPLÍCITO — D-F90 SUPERA em parte este texto, 2026-10-11**) POSTERIOR ao F — nunca a palavra do app. A nfse-api NÃO reimplementa o plano (bifurcaria a política).

- **D-F30 (Valdo, 2026-10-04, Rodada 3 — Q-F35 reaberta (b)) — o DPS de cada VIDA da nota mora no `fiscal_api`: peça `tb_invoice_service_dps`.** Uma linha por vida (nota × terminal × evento E que abriu a vida): série + nDPS + Id do DPS gravados UMA vez (write-once), UNIQUE `(tb_institution_id, dps_id)` de volta; o contador continua no emissor SE (D-N18). Tudo o que é da DECLARAÇÃO fica junto no `fiscal_api`; o ramo do ERP fica só com fatos comerciais — `tb_invoice_service.dps_number` deixa de ser lido e escrito (coluna APOSENTADA, sem DROP até decisão — "tabela sem consumidor não é morta"). Fecha por construção as duas armadilhas do guardião (§13.1-2): vida nova = linha nova (nunca herda o Id de vida cancelada) e a série fica congelada na vida (trocar a série no emissor não muda o Id de quem já tem DPS). A chave do fisco continua na TENTATIVA (D-N26 e R3-1 intactas); a opção (c) (chave também no DPS) fica registrada para rodada futura.
- **D-F31 (Valdo, 2026-10-04, Rodada 3 — Q-F44 (a)) — o que as APIs fiscais escrevem no ERP é LISTA FECHADA com cerca por teste.** Com a D-F30, a lista hoje é: **nenhuma escrita de dado** — só a trava de linha (`SELECT … FOR UPDATE` na `tb_invoice` da nota) que serializa transmitir × cancelar local (D-F27). O C local continua do setes-api (D-F11/D-F28). Escrever qualquer coisa nova no ERP a partir de uma API fiscal = decisão nova (entra na lista + no teste). Usuário MySQL das APIs fiscais: escrita permitida pelo GRANT (D-F27), disciplina garantida pelo teste.
- **D-F32 (Valdo, 2026-10-04, Rodada 3 — Q-F40 (b)) — POLÍTICAS do ERP que as APIs fiscais precisam são publicadas pelo setes-api como VIEWs no schema do cliente**, e o próprio setes-api passa a ler delas (uma verdade só): a **interface do RAMO por pedido** (hoje `resolveOrderInterface` — ciclo da OS × âncora da devolução × venda, D-A31) e a **VIDA vigente da nota** (último evento E/C — D-N27). "Admin passa" (D32), fuso por config e a matriz do Anexo I (Q-N36) ficam em código, com teste de contrato entre os dois lados. As views nascem por migration do setes-api (todas as institutions).
- **D-F33 (Valdo, 2026-10-04, Rodada 3 — Q-F41 (c)) — a biblioteca `fiscal-api` exporta o CONTRATO DE LEITURA da voz** (tipos das views do `fiscal_api`, regra da vigente `currentOf` — D-N26, `fiscalStateOf`, kinds, vida) e o **setes-api também depende dela** (dependência de código, sem HTTP — continua passivo, D-F4). As views ficam no molde do `TX_SELECT` (fundíveis; nada de `ROW_NUMBER` antes de EXPLAIN — frente S2).
- **D-F34 (Valdo, 2026-10-04, Rodada 3 — Q-F42 (b)) — nomes no `fiscal_api`: `tb_establishment_certificate`** (o A1 do estabelecimento: certificado público + chave privada cifrada + validade; o `cnpj` é o do CN, fato do certificado) e **`tb_establishment_issuer`** (habilitação por modelo — mesmo nome de hoje: "muda de casa, não de conceito"). `tb_emitter`/`tb_issuer` do §12.3 morrem; "emitente" continua sendo o `prest` do DPS, lido do ERP.
- **D-F35 (Valdo, 2026-10-04, Rodada 3 — Q-F43 (b)) — DDL por dono**: o núcleo `fiscal-api` cria `tb_establishment_certificate`, `tb_establishment_issuer` e o EXECUTOR de migrations (trava nomeada + namespace por projeto em `_migrations`); cada família cria as suas tabelas e views (`nfse-api`: DPS, transmissão, voz + views para o setes-api). A `nfe-api` AGREGA sem tocar o núcleo (D-F20).

**Rodada 3 ZERADA em 2026-10-04** (Q-F35, Q-F37…Q-F44 decididas; Q-F36 sem objeto). Modelo final da F0 no **§14**.

**Rodada 4 (aberta pelos gates da F1 — §15.4) — DECIDIDA em 2026-10-04 pelo Valdo: "siga as recomendações".** Execução no §16.
- **D-F36 (= Q-F45 (a)) — smoke no ADN de HOMOLOGAÇÃO pela nfse-api ANTES da virada**, numa habilitação de homologação com
  SÉRIE PRÓPRIA (900) e numa nota de TESTE, sem tocar a numeração de produção do setes-api; tudo o que o smoke grava no
  `fiscal_api` (DPS da vida, tentativas, vozes, contador, habilitação) é DESFEITO no fim e a cópia volta a ser a da origem
  (`migrate:setes`). Falar com o fisco continua exigindo o **"vai"** do Valdo na hora (o A1 vence em 08/10/2026).
- **D-F37 (= Q-F46 (b)) — a LICENÇA vale para TODOS**: admin passa só o PRIVILÉGIO (TRANSMITIR/CANCELAR), nunca a interface do
  ramo não contratada (D-F14). Antes de ligar a regra, o DADO é acertado: a institution 1 contrata `service-orders` (emitia
  344 OS sem a interface no contrato). O setes-api passa a fazer o mesmo na F2a (entra na lista da F2a).
- **D-F38 (= Q-F47 (a)) — teto de idade das AUTORIZADAS no rodízio = prazo de cancelamento do município (PAM) + 30 dias de
  margem** (contado do `dh_proc`; sem o PAM, 60 dias — o de Curitiba). Depois disso o fisco não aceita mais cancelamento pelo
  emitente e a voz não muda: a nota sai do rodízio (a consulta manual continua possível). Vivas (em voo/S/K) não têm teto.
- **D-F39 (= Q-F48 (a)) — a CERCA DA VIRADA é FATO no `fiscal_api`**, na habilitação: quem detém a emissão do modelo
  (o ERP ou o serviço), trocado pelo `migrate:setes` na re-sincronia FINAL (virada), na MESMA transação, e lido por todas as
  instâncias. A variável `FISCAL_LEGACY_INSTITUTIONS` sai. Modelagem pelo guardião + `revisar-ddl` (§16).
- **D-F40 (= Q-F49 (a)) — custo das leituras que crescem com o histórico é CRITÉRIO DE ACEITE**: teto p95 < 300 ms por
  chamada com 200 mil notas na página de pendentes e nas candidatas do rodízio, medido no teste de carga da F3 / diagnóstico
  da S2 (D-F23/D-F24), com `EXPLAIN` na cerca (script `nfse-api/scripts/explain-leituras.ts`).

**Rodada 6 (aberta pela retomada de 2026-10-04 — gate socrático do delta das 4 falhas + conferência "o que foi movido saiu
do setes-api?") — DECIDIDA em 2026-10-04 pelo Valdo: "siga as recomendações".** Execução no §17. Na mesma sessão o Valdo decidiu
Q-F50 ("manter" — refinada pelo guardião) e Q-F56 ("sim") → D-F44/D-F45; Q-F51…Q-F53 seguem abertas.
- **D-F41 (= Q-F54) — o comando do ALUGUEL do rodízio tem ESPERA CURTA**: quem não obtém a linha da habilitação em poucos
  segundos recebe 409 `RESOURCE_BUSY` (molde da D-A23 do setes-api) em vez de esperar o lock wait padrão do InnoDB (50 s) —
  alinha o comando ao texto "quem não obtém PULA, não espera" (PADROES §11). Deadlock continua reexecutando 1× (`leaseCommand`).
- **D-F42 (= Q-F55) — o `migrate:setes` copia e vira SÓ a habilitação SE**: as linhas 55/65 continuam no ERP (D-F21 — série e
  número do 55/65 são do ERP; D-F20 — nfe-api sem código até o 1º cliente de mercadoria). Modelagem pelo guardião (§17).
- **D-F43 (= pergunta (a) da conferência) — durante o dual-run, a correção que os gates fizeram na nfse-api e que vale também
  para o caminho do setes-api (ainda o de PRODUÇÃO) é PORTADA para o setes-api**: o setes-api é quem emite até a virada; nada
  foi removido dele (a remoção das 14 rotas e 6 peças é da F2a — §15.5-3). 1º porte: caracteres de controle no texto livre do
  DPS/evento. Assunção A14 (contestável): o inventário dos demais achados da F1 que valem para o setes-api é pendência própria.
- **D-F44 (= Q-F50 (a), refinada pelo guardião — Valdo: "manter") — o ATO da virada APOSENTA a habilitação SE do ERP**
  (`deleted='S'`) na MESMA transação que vira o `fiscal_api` — escrita UMA vez pelo SCRIPT (`nfse-api/scripts/cutover-erp.ts`,
  nunca pelo serviço), item novo da lista fechada da D-F31 (cerca por teste em `src/` e `scripts/`); o setes-api fica fechado por
  construção (lê e cunha com `deleted='N'` → 409 FISCAL_ISSUER_MISSING sem mudar código). CONFERÊNCIA embutida: a linha SE do ERP
  também é a SÉRIE DA NOTA — série efetiva ≠ '1' = falha alta antes de qualquer escrita. Credencial do ato = a do dono do ERP.
  Para a F2a: a tabela do ERP passa a significar só a série da nota; ambiente da SE e `dps_last_number` ficam sem consumidor e
  são aposentados SEM DROP. A linha 55/65 do ERP não é tocada.
- **D-F45 (= Q-F56 (a) — Valdo: "sim") — o domínio do `model` da habilitação é FATO DO BANCO**: `CHECK (model IN ('SE','55','65'))`
  na migration 004 do núcleo (1º CHECK da casa) + o boot confere que o motor APLICA CHECK (`assertIssuerModelDomainEnforced` —
  falha alto em MySQL < 8.0.16 ou CHECK NOT ENFORCED). Modelo novo = migration do núcleo que estende o domínio.
- **D-F46 (= Q-F52 (b) — Valdo, 2026-10-04: "bloqueio total, o cliente vai precisar arranjar outra maneira") — ramo que
  deixa de ser contratado = BLOQUEIO TOTAL na API fiscal, inclusive do que já foi emitido**: sem a interface do ramo em
  `tb_institution_has_interface`, transmitir, consultar, cancelar no fisco e ler XML/DANFSe devolvem 403
  `INTERFACE_NOT_ALLOWED` — para todos, admin incluído (fecha a D-F37 pelo lado do "depois"). A obrigação fiscal já assumida
  (cancelar no prazo do município, guardar o XML, reconciliar nota em voo/K) é do cliente fora do produto (portal do ADN,
  contador) — o contrato comercial manda. *Consequência para o código (coerência no sentido inverso)*: a passada do rodízio
  (`POST /v1/nfse/refresh`) hoje passa na guarda com UM ramo contratado e consulta as candidatas de TODOS os ramos — passa a
  filtrar as candidatas pelos ramos contratados em que quem pede tem o privilégio (ou é admin), no SQL antes do LIMIT (molde
  do `listPendingServiceInvoices`). *Por quê*: licença é o que se vendeu; o produto não presta serviço fiscal a ramo não
  contratado. ~~Risco aceito e registrado: nota em voo no momento do corte fica sem reconciliação pelo produto.~~ → REFINADA pela
  **D-F47** (a passada fecha as vivas do ramo cortado).
- **D-F47 (= Q-F57 (b) — Valdo, 2026-10-04) — a PASSADA do rodízio continua fechando a tentativa JÁ VIVA (sem voz/S/K) de
  ramo que saiu do contrato** (refina a D-F46): fechar o que estava em curso não é serviço novo. A autorizada (A/N) de ramo
  cortado NÃO volta ao rodízio; consultar, cancelar e ler a nota continuam 403 para todos. Admin com NADA contratado pode rodar
  a passada só sobre essas vivas (usuário comum sem ramo com privilégio: 403). *Por quê*: sem isso a nota órfã ficava viva para
  sempre e `countLiveTransmissions` travava o emitente inteiro (trocar ambiente, excluir habilitação/A1) — achado MEDIUM-1 do
  gate socrático (§18).
- **D-F48 (= Q-F58 (a) — Valdo, 2026-10-04: "recomendação") — a re-sincronia (`migrate:setes` sem `--cutover`) usa UMA
  TRANSAÇÃO POR INSTITUTION** (revisa o "tudo ou nada" global da D-F18 só na re-sincronia; a virada continua uma transação
  só). A institution que falha volta sozinha (nada dela gravado), as demais seguem, e o script sai ≠ 0 listando as que
  falharam. *Por quê*: o tudo-ou-nada global não protegia invariante entre institutions e segurava FOR UPDATE nas
  habilitações VIRADAS de todas até o commit final (§18, MEDIUM-2).
- **D-F49 (Valdo, 2026-10-04: "vamos manter") — a D-F7 (banco `fiscal_api` próprio) está CONFIRMADA, com o motivo VERDADEIRO
  registrado: NÃO é desempenho.** Na mesma instância MySQL (D-F9) um banco à parte não muda memória, disco nem CPU, e a consulta
  que cruza `fiscal_api` × `setes_*` custa o mesmo; nem prepara servidor próprio no futuro (as leituras da nfse-api JUNTAM os
  dois bancos — só funcionam na mesma instância). A ESCALA vem das instâncias Node separadas (D-F9/D-F12), independente de onde
  as tabelas vivem. O que o banco próprio dá: (1) as tabelas fiscais existem UMA vez (escopo por linha) — coluna nova = 1 ALTER,
  não 1 por schema de cliente; (2) segurança por construção — o MySQL não concede privilégio por TABELA num padrão `setes\_%`,
  então tabelas fiscais dentro dos schemas exigiriam escrita da API fiscal no ERP inteiro de todos os clientes (desfaz a D-F15)
  e poriam a chave privada do A1 ao alcance de tudo que mexe no ERP; (3) já feito e provado — voltar custaria semanas antes do
  marco do IBS/CBS (01/01/2027). Critério do Valdo para quando a dúvida voltar: "estratégia por estratégia, prefiro junto" —
  separar só com ganho concreto, como estes. O custo próprio (cópia/réplica/virada) é de TRANSIÇÃO e morre depois da virada.
- **D-F50 (= Q-F59 (a) — Valdo, 2026-10-04: "segue recomendações") — a virada exige o FATO de que a F2a do setes-api está
  aplicada no schema do cliente**: `migrate:setes --cutover` lê `<schema>._migrations` procurando o nome FIXO
  **`f2a_fiscal_passivo`** (arquivo `NNN_f2a_fiscal_passivo.sql` da F2a — contrato entre os dois repos; se a F2a sair em mais de
  um arquivo, ESTE nome vai no ÚLTIMO) em autocommit, antes da transação. Ausente = o ato real recusa sem escrever; o
  `--dry-run` segue e reporta "bloqueios" (sai 0 — o roteiro da virada lê o JSON). Permissão negada/conexão perdida sobem cruas.
  *Por quê*: antes da F2a a tela "Emissor fiscal" do setes-api regrava a SE (`deleted='N'`) e reviveria a linha que a D-F44
  aposenta (nDPS repetido — R2-2). Continua procedimental: o rollback do DEPLOY do setes-api depois da virada, e aplicar a
  migration por `db:migrate` antes do código da F2a estar servindo.
- **D-F51 (= Q-F60 (a) — Valdo, 2026-10-04) — a CONSULTA grava F "sem resposta" com o mesmo critério do transmitir**: tentativa
  EM VOO (sem voz) há ≥ `IN_FLIGHT_MINUTES` cujo DPS o fisco NÃO conhece (E2404 estruturado — 404 ilegível, 5xx ou fisco fora
  continuam ambíguos) recebe F (source Q) sob a trava da nota — na rota por nota e na passada, para TODO ramo. Um veredito só
  nos dois caminhos (refina a regra herdada "F só conclusivo": este é o conclusivo da Onda 2, HIGH-3). Quem perde a corrida
  devolve a voz lida sob a trava e não carimba `last_queried_at` (a prova da D-F29 exige consulta POSTERIOR à voz). *Por quê*:
  sem isso a em voo de ramo cortado nunca fechava e travava o emitente (D-F47; gate r9).
- **D-F52 (= Q-F61 (a) — Valdo, 2026-10-04: "recomendação") — o F "sem resposta" gravado por CONSULTA volta ao rodízio UMA vez,
  24 h depois** (`F_REVISIT_HOURS`): só F de source Q, sem chave, na ÚLTIMA tentativa da vida (retransmitida = fora), de ramo com
  privilégio (cortado = não — D-F46), dentro do teto da D-F38; "uma vez" = `last_queried_at` anterior ao F + 24 h (a revisita
  carimba depois). Achou a NFS-e → A (A depois de F é permitido); não achou → só carimba. *Por quê*: fecha a única janela em que
  a voz F pode mentir (ADN com atraso de propagação) antes que o cliente fature outra nota para o mesmo serviço.
- **D-F53 (= Q-F53 (a) — Valdo, 2026-10-04: "crie no seed essas permissões para que ao implantar em produção eu não tenha
  problemas") — o usuário `fiscal_api` tem controle TOTAL nas cópias descartáveis `fiscal_api_adv_*`, e só nelas**: `GRANT ALL
  PRIVILEGES ON \`fiscal\_api\_adv\_%\`.* TO 'fiscal_api'@'%'` no script de implantação `nfse-api/ops/grants.sql` (seção 1b,
  idempotente, roda antes do 1º boot; inócuo em produção, onde não há cópias; conferência no item 3 do script). *Por quê*: os
  ataques ao vivo podem rodar com o usuário que só LÊ o ERP — teste errado fica impedido de escrever no ERP por construção (hoje
  é só detecção pelo CHECKSUM). GRANT aplicado no dev pelo Valdo (2026-10-04). Harness trocado: o ATAQUE (pool
  da cópia e migrations dela) roda com o usuário do SERVIÇO (DB_USER do .env da nfse-api — se for o dono do ERP, a suíte falha
  alto); o DONO fica só para a faxina (copiar, apagar, CHECKSUM) e os processos filhos (ensaio da virada — D-F44). Prova nova no
  `r5.live` §G: DELETE/UPDATE no ERP pelo pool do ataque = 1142. Limitação aceita: o serviço é dono do `fiscal_api` real (lá
  segue a detecção por CHECKSUM — `it.failing [Q-F53]`). **Falta a 1ª rodada ao vivo com o harness novo.**

**Decisões da sessão de 2026-10-10 desta máquina — RENUMERADAS na reconciliação (§20.2; a numeração original está no §19 e no
branch `sessao-2026-10-10`):**

- **D-F54 (= Q-F51 (a) — Valdo 2026-10-10: "o restante pode seguir as recomendações"; era a D-F46 desta máquina) — a nota do
  smoke em homologação (D-F36) vem de uma OS de TESTE faturada AGORA pelo setes-api** (regra de ISS atual: código nacional +
  código municipal vazio ou de 3 dígitos), para um cliente INTERNO da Setes e valor simbólico; depois do smoke, a nota é
  cancelada localmente. É o único caminho que prova o DPS montado pela regra atual. Pré-condição: o A1 RENOVADO no cofre e na
  réplica (§19.1). Escolher o cliente/serviço e falar com o fisco (`smoke:adn-h … --vai`) continuam pedindo o "vai" na hora.
  (Na prática a OS escolhida foi de cliente externo — Blessing Chocolates, §19.4 — porque a Setes como tomadora cai na RN 238.)
- ~~**D-F55 (= Q-F52 (a) — era a D-F47 desta máquina) — a LICENÇA barra só a TRANSMISSÃO NOVA**~~ → **REVOGADA na reconciliação
  (Valdo 2026-10-10: "(b) bloqueio total")**: a Q-F52 já tinha sido decidida em 2026-10-04 como (b) (D-F46 — "o cliente vai
  precisar arranjar outra maneira"); a (a) entrou aqui pelo "siga as recomendações" sem a (b) à vista. O código da D-F55
  (`hasFiscalObligation`, `licensedOrCommitted`, `{ newTransmission }`) SAIU da nfse-api; valem D-F46/D-F47/D-F51/D-F52.
- *(a D-F48 desta máquina = **D-F53** acima — mesma decisão (Q-F53 (a)); o GRANT foi completado nos quatro hosts do usuário com o
  "vai" de 2026-10-10 — `ops/grants.sql` item 5, só no dev — e o harness unificado ataca com o serviço e só o ENSAIO do ato leva o
  dono, por `ownerEnv` explícito.)*
- **D-F56 (= Q-F63 (a) — Valdo 2026-10-10: "siga as recomendações"; era a D-F49) — a habilitação SE com numeração emitida só sai
  pelo ATO da virada**: o setes-api (guarda portada no dual-run, molde D-F43) recusa REVIVER a SE excluída (409
  `FISCAL_ISSUER_RETIRED`) e recusa EXCLUÍ-LA (409, código renomeado para `FISCAL_ISSUER_CUTOVER_ONLY` pela D-F58). Revê o "sem
  mudar código do setes-api" da D-F44. **Convive com a D-F50** (escolha do Valdo na reconciliação — "os dois"): a guarda fecha a
  janela até a F2a em toda versão que a contenha; a D-F50 garante a ordem F2a → virada. §19.3.
- **D-F57 (= Q-F64 (a) — idem; era a D-F50) — a lacuna (b) da cerca da virada olha a LINHA SE** ("sem linha SE no `fiscal_api` +
  SE no ERP"), no predicado `emissionStillInErp`, na guarda `assertEmitterWritable` e na decisão réplica × congelada da
  re-sincronia (agora dentro da `resyncInstitution` da D-F48); o "ato por institution" da D-F39 fica para réplica. A cerca por
  família (55/65 independentes da SE) é a D-NE10 (onda NE-1 da nfe-api). §19.3.
- **D-F58 (= Q-F65 (a) — Valdo 2026-10-10: "siga as recomendações"; era a D-F51) — no dual-run a habilitação SE do ERP só muda
  pelo ATO**: o setes-api não REVIVE a SE excluída nem EXCLUI a SE, QUALQUER que seja o contador (substitui o critério
  `dps_last_number > 0` da D-F56 — o ato também aposenta SE com contador 0, ADV-R8-01). Custo aceito: trocar a SE de um cliente no
  dual-run = ato ou SQL. §19.5.
- *(a D-F52 desta máquina = **D-F51** acima — mesma decisão (a consulta fecha com F a tentativa interrompida); fica a
  implementação da 3ª sessão, `recordInterruptedFailure`, que também trata a corrida perdida — gate r10.)*
- **D-F59 (= Q-F67 (a) — Valdo 2026-10-10, IM "01 06 501.367-7"; era a D-F53) — a IM do PRESTADOR vai ao DPS só em
  HOMOLOGAÇÃO**: é FATO do emitente (`tb_company.im`); o AMBIENTE da habilitação decide (H exige — E0116; P recusa — E0120,
  Q-N35), nos DOIS montadores (setes-api, porte do dual-run — D-F43; nfse-api). §19.6. O CNC de H ainda não reconhece a IM
  gravada — **Q-F62**.
- **D-F60 (= Q-F62 (a) — Valdo 2026-10-10: "IM: 50136779") — a IM da Setes no CNC de HOMOLOGAÇÃO de Curitiba é `50136779`**
  (o "Indicador Municipal" do Emissor Nacional de produção restrita: 8 dígitos e contém o 501.367-7 do alvará — forma do CNC,
  não dado de teste) → gravada como FATO do emitente (`setes_central.tb_company.im`, era `01065013677`); o DPS só a envia em H
  (D-F59) e P segue sem IM (Q-N35). Provada pela 1ª AUTORIZAÇÃO da nfse-api em homologação (§21).
- **D-F61 (= Q-F68 (a) — Valdo 2026-10-10: "(a) Nos dois, já") — a leitura dos eventos de cancelamento segue o contrato REAL da
  Sefin** (cravado ao vivo em H e P, §21.2/§21.4): `GET /nfse/{chave}/eventos/{tipo}/1` para cada código de cancelamento (101101,
  105102, 105104, 305101); 404 só com o envelope JSON da Sefin = "sem esse evento"; `arquivoXml` = base64 do texto gzip+base64; 405
  (e 406/415 — Rodada 11) = contrato do adaptador → 502 ambíguo, nunca "DPS rejeitado". Nos DOIS adaptadores (porte D-F43).
- **D-F62 (= Q-F69 (a) — Valdo 2026-10-10: "siga as recomendações") — manter os 4 GETs tipados** (único contrato provado ao vivo) e o
  aluguel da passada da nfse-api cobrir o PIOR caso de uma candidata (6 idas × 30 s + folga = **210 s**); o orçamento de 20 s do
  setes-api fica como está (estoura numa nota lenta — morre na F2a).
- **D-F63 (= Q-F70 — idem) — no GET tipado, 200 que não se confere como cancelamento GERADO desta chave é AMBÍGUO** (ilegível, outra
  chave, eco, outro tipo; `eventos: []`) — nunca "autorizada" (gravaria N falso num K). A R2-2 (d) "segue autorizada" era da LISTA
  `GET /eventos`, que a Sefin não tem.
- **D-F64 (= Q-F71 — idem) — cancelamento por SUBSTITUIÇÃO (e105102) lido por consulta: voz C SIM, efeito local automático NÃO**
  (existe uma NFS-e substituta que o ERP não conhece): pendência visível, só ação humana; a suspensão é pegajosa e guarda o motivo do
  fisco. `NfseQuery.cancelled.eventCode` nos dois serviços. Fim da pendência = Q-F74; contrato da F2a = Q-F75.
- **D-F65 (= Q-F72 — idem) — 401/403 numa rota de EVENTO depois do 200 do GET /nfse da mesma nota é falha DA NOTA** (502 ambíguo: o
  rodízio carimba e segue); 401/403 no GET /nfse e 5xx/timeout continuam parando a passada.
- **D-F66 (= Q-F73 (a) — idem) — TSString: NFC antes do filtro; fora do Latin-1, a letra-base** (Š→S, č→c; sem base Latin-1, sai); o
  filtro Latin-1 vale para TODO texto livre do DPS/evento (escolha registrada).
- **D-F67 (= Q-F74 (a) — Valdo 2026-10-10: "siga as recomendações") — fim da pendência da SUBSTITUIÇÃO (e105102) = ato humano
  "manter a nota"**: a decisão é FATO da nota (`tb_invoice_cancel_waiver` — motivo e autor, D-F72/D-F73), tira a voz da pendência,
  do rodízio de 15 min e do lote "Transmitir pendentes"; a tela "No fisco" mostra a chave da NFS-e SUBSTITUTA; a outra saída é cancelar
  a nota (o cancelamento liga a voz como efeito). Voz C VIGENTE com a nota viva nunca se reapresenta ao fisco: 409
  `FISCAL_NFSE_SUBSTITUTED` (105102) / `FISCAL_EFFECT_PENDING` (demais). Rota `POST /api/billing/cancel-waiver` (setes-api).
- **D-F68 (= Q-F75 (a) — idem) — na nfse-api o código do evento é FATO estruturado na voz do `fiscal_api`** e
  `localCancelPending` (núcleo) exclui a substituição — contrato da F2a: o app nunca aplica sozinho o C de um e105102;
  `isSubstitutionCancel` no núcleo; 409 `FISCAL_NFSE_SUBSTITUTED` no transmit; a tela recebe `substitution.substituteAccessKey`.
- **D-F69 (= Q-F76 (a) — idem) — rota perguntada × código do XML divergentes = AMBÍGUO** (`unknown`/502), **salvo quando o XML diz
  substituição** (fica a marca mais restritiva — sem efeito automático), nos dois adaptadores.
- **D-F70 (= Q-F77 — Valdo 2026-10-10: "Sim, siga tudo", parecer do guardião) — o DDL da voz é da FAMÍLIA** (migration 002 da
  nfse-api — a voz nasce na 001 da família, D-F35), nunca do núcleo.
- **D-F71 (= Q-F78 — idem) — sem coluna nova: `authority_code` da voz C guarda o TIPO do evento de cancelamento** (101101 · 105102
  · 105104 · 305101 — `tiposEventos_v1.01.xsd`; CHECK de domínio só na voz C; resposta direta ao nosso pedido = 101101). Backfill
  determinístico IGUAL nos dois bancos (067 do setes-api · 002 da nfse-api): marca de texto "(e105102)" → 105102; source P → 101101;
  C de consulta sem marca → NULL (lida como cancelamento comum).
- **D-F72 (= Q-F79 — idem) — "manter a nota" exige o privilégio CANCELAR na interface do RAMO** (mesmo resolvedor do cancelamento).
- **D-F73 (= Q-F80 — idem) — motivo obrigatório** (1–255), gravado com o autor.
- **D-F74 (= Q-F81 — idem) — só a SUBSTITUIÇÃO se dispensa** (voz C vigente 105102, nota viva, sem efeito aplicado); 101101/105104/
  305101 seguem o caminho do efeito (aplicar ou cancelar manualmente) — 409 `INVOICE_CANCEL_WAIVER_NOT_APPLICABLE`.
- **D-F75 (= Q-F82 — idem) — o código só SOBE para 105102, nunca volta** (`setCancelEventCode` no setes-api; promoção de mão única e
  conferência de divergência também no `migrate:setes`).
- **D-F76 (= Q-F83 — idem) — a chave da SUBSTITUTA não tem coluna**: deriva do `chSubstituta` do XML do evento arquivado
  (`<chave>-evt101101.xml` — nome herdado, R11-07), validada `^[0-9A-Z]{50}$`, só exibição (ausente = "indisponível").
- **D-F77 (= Q-F84 (a) — Valdo 2026-10-10: "siga as recomendações", gate socrático da Rodada 13) — a voz C que é a resposta ao
  NOSSO pedido (source P, e101101 provado) NUNCA é promovida**: leitura posterior que diga outro tipo é contradição do fisco (502
  `FISCAL_AUTHORITY_UNKNOWN_RESPONSE` + `logger.error`, nada gravado) — a "marca mais restritiva" (D-F69/D-F75) abriria o "manter a
  nota" (D-F67) para uma nota sem NFS-e válida e sem substituta; e o efeito LOCAL pendente dessa voz é retentado SEM o fisco
  (`retryLocalCancelEffect` — o fato do fisco já está provado). A D-F75 segue valendo para vozes por CONSULTA (Q).
- **D-F78 (= Q-F85 (a) — idem) — a consulta HUMANA de uma voz C relê o fisco SÓ para arquivar o XML do evento que faltou** (Q-N38;
  na substituição, também a chave da substituta — D-F76): grava o arquivo se a resposta for o cancelamento DESTE código; a voz nunca
  muda por aí; o rodízio nunca relê por um arquivo (`fromRun`). Nos dois serviços (setes-api e nfse-api).
- **D-F79 (= Q-F86 (a) — idem) — a dispensa é FATO DO ERP; a pendência é UM predicado**: no setes-api tela, transmissão e rodízio
  contam pelo mesmo SQL (`countPendingEffects`) — a cópia em memória da tela saiu. Plano da F2a: o setes-api expõe `cancelWaiver` e
  `pendingEffects` em rota própria por pedido; a nfse-api fica só com o fisco (`localCancelPending`, `substitution`); o app compõe
  as duas leituras (nunca degrada em silêncio).
- **D-F80 (= Q-F87 (a) — idem) — homologação não se mantém**: em H a dispensa é recusada (409 `INVOICE_CANCEL_WAIVER_NOT_APPLICABLE`
  — "sem valor jurídico, cancele a nota") e o app esconde o "Manter a nota". **Assunção A-F80 (desvio técnico da letra "a voz de H
  não bloqueia a transmissão em P")**: o Id do DPS é da VIDA da nota, não do ambiente (D-N3: o nDPS é write-once por vida) — uma
  tentativa em P na MESMA vida reusaria o Id da tentativa de H e colidiria com o leitor único pela chave (D-N26) e com a
  reconciliação de órfã (R3-1). A saída que não bloqueia é a da Q-CA5b: cancelar a nota de H (cancelável localmente) abre vida nova,
  que transmite em P com DPS novo; o 409 de H passa a apontar esse caminho.
- **D-F81 (= Q-F88 (a) — idem) — a dispensa é HISTÓRIA**: a linha fica; os leitores só a apresentam como decisão vigente enquanto a
  nota está viva (`findCurrentCancelWaiver` — cabeçalho vivo e último evento ≠ C).
- **D-F82 (= Q-F89 — idem) — o cancelamento DE OFÍCIO (e305101) espera o humano**: voz C sim, efeito local suspenso (pendência —
  "cancele a nota"), sem caminho de "manter" (não há substituta); sai do rodízio junto com a substituição (`HUMAN_EFFECT_CANCEL_CODES`
  no núcleo e no setes-api; `localCancelPending` exclui os dois). O e105104 (deferido a pedido do contribuinte) segue automático.
- **D-F83 (= A-F80 confirmada — Valdo 2026-10-10: "siga as recomendações") — em HOMOLOGAÇÃO a saída da voz C é cancelar a nota**
  (cancelável localmente — Q-CA5b) e faturar de novo: a vida nova transmite em P com DPS novo. O Id do DPS é da VIDA, não do ambiente
  (D-N3) — uma tentativa em P na mesma vida colidiria com o leitor único pela chave (D-N26) e com a reconciliação de órfã (R3-1).
- **D-F84 (= Q-F90 — idem; supera a escolha do L7 da Rodada 14) — GET tipado que traz TIPOS DIFERENTES de cancelamento desta chave é
  AMBÍGUO** (`unknown` → 502, nada gravado, `logger.error` de contrato divergente) — nenhuma marca, nenhum efeito (como a D-F63): nem o
  tipo perguntado (a marca menos restritiva) nem a substituição (abriria o "manter a nota" sobre uma resposta que se contradiz). Itens
  repetidos do MESMO tipo valem. Nos dois adaptadores.
- **D-F85 (= Q-F91 — idem) — a chave da SUBSTITUTA só é exibida se for do MESMO emitente**: posições 9–23 da chave de 50 (tipo de
  inscrição + inscrição) iguais às da substituída (`sameIssuerKey`), além do formato e de ser ≠ da própria chave (R13-04). Só exibição
  (D-F76) — nunca regra.
- **D-F86 (= Q-F92 (a) — Valdo 2026-10-11: "siga as recomendações") — o laço dos GETs tipados PARA no primeiro tipo achado**:
  CONHECIMENTO NEGATIVO — premissa da D-F61 ("o fisco registra UM cancelamento por NFS-e"); contradição ENTRE rotas não é procurada
  de propósito (até 3 GETs a mais por nota cancelada contra uma impossibilidade fiscal). Reabrir só se a prova ao vivo M4 mostrar
  dois cancelamentos para a mesma chave. Comentário no laço dos dois adaptadores + teste que fixa.
- **D-F87 (= Q-F93 (a) — idem) — a nota "ambígua para sempre" segue FAIL-CLOSED; a saída é o ALARME da F3**: o rodízio (setes-api e
  nfse-api) registra `logger.error('Fisco ambíguo persistente: …', {institutionId, invoiceId, attempt, lastKind})` — só a composição
  sabe QUAL nota (o log do adaptador não tem esse contexto e não leva a chave). Ato humano com evidência só com caso real; teto de
  tentativas NÃO ("ambíguo nunca fecha").
- **D-F88 (= Q-F94 (a) — idem) — no GET tipado conta TODO evento GERADO desta chave**: tipo fora do domínio de cancelamento (e105105
  indeferido, e101103…) junto de outro também é contradição → ambíguo (o GET por tipo + sequência só deveria devolver o tipo).
- **D-F89 (= Q-F95 — idem) — "mesmo tipo repetido vale" só com o MESMO conteúdo**: código, Id, dhProc, dhEvento, nSeq, cMotivo,
  xMotivo e chSubstituta iguais (`eventSignature`); divergente → ambíguo (o que se exibe/aplica não depende da ordem da lista).
- **D-F90 (= Q-F96 (c) — idem; SUPERA em parte a D-F29) — a prova da reconfirmação exige o "NFS-e não gerada" EXPLÍCITO**: coluna
  `nfse_not_generated_at` na tentativa (`fiscal_api`, migration 003 da nfse-api + view `vw_invoice_service_transmission`), gravada
  SÓ na resposta E2404, por escritor próprio (`recordNfseNotGenerated`) e só se a última voz da tentativa ainda é a que a pergunta viu
  (resposta velha não pousa — gate r10); relógio NOSSO; sem backfill. `reconfirmationProven = nfse_not_generated_at > last_event_at`
  (núcleo). `last_queried_at` volta a ser SÓ o throttle do rodízio (o 502 persistente o carimba e nunca prova). Parecer do guardião
  (§21.10): fato da TENTATIVA, nunca voz (E2404 depois do F não muda o estado derivado); nome pelo próprio E2404 — "não consta" é
  palavra ocupada (voz N) e `not_found` convidaria a gravar em qualquer 404.
- **D-F91 (= Q-F97 (a) — Valdo 2026-10-11: "siga as recomendações") — o alarme do ambíguo cobre TODA porta que pergunta ao fisco**:
  `logAmbiguousFiscal(origin, {institutionId, invoiceId, attempt, lastKind})` (setes-api e nfse-api) registra "Fisco ambíguo
  persistente" com a ORIGEM — `rodizio` (com tentativa e última voz), `consulta` (a consulta pedida pela tela — invólucro do
  `refreshServiceTransmission`) e `reconferencia` (antes do cancelamento local, com a tentativa); um registro por ocorrência, nunca a
  chave. O alarme da F3 AGREGA por nota (primeira/última vez, contagem), sem depender da janela do rodízio (D-F38/D-F52).
- **D-F92 (= Q-F98 (a) — idem) — a prova da reconferência NÃO tem prazo de validade** (CONHECIMENTO NEGATIVO): qualquer E2404
  POSTERIOR ao F vale, inclusive o da revisita de 24 h (D-F52) semanas antes do cancelamento — o DPS foi enviado uma vez; 24 h depois
  do F o "não gerada" é conclusivo. Não inventar janela; reabrir só se a prova ao vivo M4 mostrar NFS-e gerada tarde.
- **D-F93 (= Q-F99 (a) — idem) — a assinatura do evento (D-F89) soma `nDFSe`, o autor (`CNPJAutor`/`CPFAutor`), `ambGer` e `tpAmb`**:
  divergência FORA dos 8 campos decidia, pela ordem da lista, qual XML ia para o arquivo fiscal (R16-01).
- **D-F94 (= Q-F100 (b) — Valdo 2026-10-11: "siga as recomendações") — o alarme leva só o CÓDIGO e um rótulo SEM DÍGITOS**
  (`reason` = a mensagem com toda sequência de dígitos trocada por `#`, até 160): a mensagem inteira podia levar o Id de DPS de OUTRA
  nota, que embute o CPF/CNPJ de outro prestador (R17-02). Nunca a chave, nunca documento.
- **D-F95 (= Q-F101 (b) — idem) — a origem do alarme é dita EXPLICITAMENTE por quem chama** (`AmbiguousOrigin`): a consulta da tela
  passa `origin: 'consulta'`; o transmitir registra `transmissao` no passo 0b (GET /dps e a consulta pela chave); rodízio e
  reconferência seguem registrando por si — nunca deduzida pela ausência de flags (R17-03).
- **D-F96 (= Q-F102 (a)+(c) — idem) — a assinatura do evento usa o MESMO leitor do parse** (`firstText`, exportado pelo montador —
  atributos e escapes iguais aos do resto do adaptador) **e, na repetição, o XML arquivado é escolhido de forma DETERMINÍSTICA** (o
  menor na ordem do texto) — nunca a ordem da lista do fisco (R17-01; `verAplic` segue fora da assinatura, mas o arquivo não depende
  mais da ordem).
- **D-F97 (= Q-F103 (b) — idem; corrige a premissa da D-F92) — o E2404 tem de ser POSTERIOR à ÚLTIMA apresentação do Id do DPS em
  QUALQUER tentativa da vida** (o maior entre a reserva e a última voz de cada tentativa com o MESMO Id e ambiente): as tentativas da
  vida reapresentam o MESMO Id (D-N3/D-F30) — "o DPS foi enviado uma vez" era falso. `reconfirmationProven(candidata, vida)` no
  núcleo; a F2a passa a vida inteira.
- **D-F98 (= Q-F104 (c)+(b) — Valdo 2026-10-11: "siga as recomendações"; SUPERA a D-F94 no conteúdo do `reason`) — o Id do DPS de
  TERCEIRO nunca entra em mensagem, e o alarme leva uma CAUSA de lista FECHADA**: (c) a mensagem "NFS-e de OUTRO DPS" — o warn do
  adaptador e o 502 que o app mostra — diz só "Id divergente"; (b) o `reason` do alarme "Fisco ambíguo persistente" é a causa marcada
  no erro por quem PRODUZ o ambíguo (`tagAmbiguous`), lida por `ambiguousCauseOf` só da lista `AMBIGUOUS_CAUSES` (fora dela ou sem
  marca = `nao-classificada`; a marca é um Symbol, nunca serializa). A máscara de dígitos da D-F94 deixava passar as LETRAS de um CNPJ
  alfanumérico (R18-01/R18-02). Núcleo `fiscal-api/src/errors/ambiguous-cause.ts`; espelho no setes-api
  (`shared/tax-authority/ambiguous-cause.ts`).
- **D-F99 (= Q-F105 (b) — idem) — tentativa da MESMA identidade SEM VOZ derruba a prova da reconferência**: `reconfirmationProven`
  falha FECHADO enquanto houver na vida tentativa com o mesmo Id do DPS e ambiente e sem voz (`lastEventAt` nulo — em voo: só há o
  instante da RESERVA e o POST pode chegar ao fisco depois do E2404). A reconferência da nfse-api segue carimbando o E2404 (a opção (c),
  recusar 409, não foi escolhida); quem LÊ a prova (a F2a) não a aceita até a tentativa ganhar voz.
- **D-F100 (= Q-F106 (a) — Valdo 2026-10-11: "siga as recomendações") — CONHECIMENTO NEGATIVO: nada da "resposta trocada" é
  guardado** (nem hash do Id alheio — CPF se quebra por força bruta —, nem o corpo cru): o alarme (institution, nota, causa, instante)
  basta para o chamado à Sefin e o caso se reproduz consultando de novo. Reabrir só se a resposta trocada acontecer de verdade.
  Comentário nos dois `adn.ts` e nas duas composições.
- **D-F101 (= Q-F107 (b) — idem; estende a D-F99) — "em voo" = tentativa VIVA**: `reconfirmationProven` falha FECHADO com tentativa
  da mesma identidade sem voz FINAL (`FINAL_TRANSMISSION_KINDS` — A/R/C/F/N; S "enviado" e K são vivas; `lastKind` ausente = viva) —
  o MESMO predicado do `isLiveTransmission` (barreira do plano de cancelamento e do rodízio). `lastKind` entrou no contrato da prova.
- **D-F102 (= Q-F108 (a) — Valdo 2026-10-11: "siga as recomendações") — CONHECIMENTO NEGATIVO: a voz S ("enviado") não tem
  produtor nem SAÍDA**: a D-F51 (`isInterruptedInFlight`) só fecha tentativa SEM voz. Quem criar produtor de S dá a ela, NA MESMA
  ENTREGA, a saída da D-F51 (idade da voz S ≥ `IN_FLIGHT_MINUTES` + E2404 → F) — senão a prova da reconferência (D-F101) fica falsa
  para sempre e o transmitir em 409. Cerca: "nenhum produtor de voz S" (adversarial-r20-gate da nfse-api) + o teste que afirma que a
  consulta NÃO fecha a irmã S (troca-se pelo veredito F no dia do produtor). S fica no vocabulário (tabela sem consumidor não é morta).
- **D-F103 (= Q-F109 (a) até a F2a, (b) na migration dela — idem) — o domínio de `kind` não é conferido no banco**: `CHAR(1)` sem CHECK
  em colação `_ci` (migration 001 da nfse-api — um "f" é F para o SQL e VIVA para o código). Até a F2a: os escritores são tipados, NUNCA
  gravar voz por fora do código. **A migration da F2a ganha o CHECK do domínio em colação binária, conferido no boot (molde da D-F45).**
- **D-F104 (= Q-F110 (a) — idem) — a prova da reconferência fica BOOLEANA até a F2a**: o veredito com MOTIVO (barreira e prova numa
  chamada só — molde `verdictOf`, D-IB47) se decide na rodada da F2a, com o caso real; até lá valem os itens (5)/(6) da nota de
  implantação (§21.14).
- **D-F105 (= Q-F111 (a) — Valdo 2026-10-11: "siga as recomendações") — a D-F102 vale SÓ para a família NFS-e**
  (`tb_invoice_service_transmission_event`): a NF-e produz S LEGÍTIMO (NE-3) e define a saída dele na própria rodada (consulta pela
  chave/recibo — D-NE33). A cerca (`nfse-api/src/__tests__/voice-kind-fence.ts`) mira a família: SQL só na tabela da NFS-e; no NÚCLEO (onde
  a NE-1a põe a máquina comum) só o SQL — nunca o literal `kind: 'S'`, que lá é da NF-e.
- **D-F106 (= Q-F112 (b) — idem) — o escritor da voz da NFS-e é tipado pelo vocabulário DA FAMÍLIA, em lista POSITIVA**:
  `SERVICE_VOICE_WRITE_KINDS = ['A','R','C','K','F','N'] as const satisfies readonly TransmissionEventKind[]` e o tipo
  `ServiceVoiceWriteKind` DERIVADO dela (a 1ª forma, `Extract<…>`, evaporava calada se o tipo comum virasse `any` — ressalva do
  adversarial R22) em `TransmissionEventInput.kind` (nfse-api e setes-api) e no `OUTCOME_KIND` — sem S já agora e sem os kinds que a NE-1a
  trouxer para o tipo comum (P/D da NF-e). O TIPO pega o produtor SEMÂNTICO (constante, shorthand, mapa, parâmetro) que nenhuma cerca
  textual pega. O CHECK do banco continua na F2a (item (7)). Correções do gate R22 (§21.16), executadas na sessão e reversíveis pelo
  Valdo: FUNIL em execução no escritor (recusa kind fora da lista, sensível a caixa, antes de qualquer query), `OUTCOME_KIND` congelado,
  cerca de CHAMADA + ESCRITOR ÚNICO na peça `voice-kind-fence.ts` (`writerCallFlags`/`voiceWriterViolations`/`VOICE_SQL_WRITERS`).
- **D-F107 (= Q-F113 (a) — Valdo 2026-10-11: "siga as recomendações da Rodada 23") — o CHECK da F2a (item (7) da nota, D-F103) protege a
  lista da FAMÍLIA na tabela da voz da NFS-e**: domínio = A/R/C/K/F/N em colação BINÁRIA — a MESMA constante `SERVICE_VOICE_WRITE_KINDS`
  do tipo (UMA fonte); a sonda do boot (molde da D-F45) e um teste comparam a constante com o DDL; a conferência antes do ALTER conta, no
  `fiscal_api` E na origem do setes-api, `kind` fora da lista ou da caixa — inclusive S. S segue no vocabulário COMUM (D-F102 — tabela
  sem consumidor não é morta), mas a tabela da NFS-e não o aceita; a NF-e decide o domínio da tabela DELA na NE-2 (D-F105).
- **D-F108 (= Q-F114 (a) — idem) — quando a máquina da voz for para o núcleo (NE-1a, D-NE13), o DESCRITOR da família carrega a lista de
  escrita**: `VoiceFamily<K>` com a tabela da voz e `writeKinds: readonly K[]`; o escritor comum é genérico em K (a porta do núcleo é
  PROPRIEDADE-FUNÇÃO, nunca método — método é bivariante e deixaria gravar S) e confere a lista em EXECUÇÃO (o funil da D-F106 vai junto
  com a máquina); a cerca do núcleo vira ESCRITOR ÚNICO (SQL de escrita em `*_transmission_event` só no escritor do descritor). A nfse-api
  declara a família de serviço com `SERVICE_VOICE_WRITE_KINDS`; a NF-e declara a dela (pode ter S/P/D com saída — D-F105). Rejeitadas:
  (b) invólucro tipado na nfse-api + cerca de import (o genérico seguiria aberto a S); (c) só o CHECK da F2a (o domínio comum tem S).
  Nota de implantação em `prompt_onda_nfe_sefaz.md` §12.8.
- **D-F109 (= Q-F115 (b) — Valdo 2026-10-12: "siga as recomendações" — Rodada 1 da F2a, §22.4) — o núcleo expõe o VEREDITO da reconferência com motivo**: `reconfirmationVerdict(vida)` em
  `fiscal-api/reading` (`provada` · `irma-viva` · `apresentada-depois` · `sem-e2404` · `sem-identidade` · `instante-invalido` ·
  `nao-exigida`), usado pelo plano do setes-api e pelo `/reconfirm` da nfse-api — a ordem "irmã viva primeiro" (nota (1) da F2a) fica num
  lugar só; `reconfirmationProven` passa a ser `verdict === 'provada'`. REVÊ a D-F104 (booleano até a F2a). A política do ERP (Q-CA5b, destino
  da nota) segue no plano do ERP.
- **D-F110 (= Q-F116 (a) — idem) — `068_f2a_fiscal_passivo` CONGELA a escrita fiscal do ERP por construção** *(errata 2026-10-12, gates da A2: o NOME é o fato — a nfse-api confere `_migrations.name`; o NÚMERO é o próximo livre na janela, porque a 068 foi usada pela A2 — `068_order_interface_view_bin`; o runner agora falha alto com número repetido)*: triggers BEFORE INSERT/UPDATE com
  SIGNAL nas tabelas de tentativa e voz do ERP e na linha SE de `tb_establishment_issuer` (sem revive S→N, sem mudar `environment`/
  `dps_last_number`, sem INSERT de SE; N→S permitido — o ato da D-F44) + COMMENTs de aposentadoria sem DROP (`environment`, `dps_last_number`,
  `tb_invoice_service.dps_number`, as duas tabelas = "origem congelada"). O nome passa a significar "o ERP deixou de escrever a voz fiscal".
  1º trigger de TRAVA da casa → regra nova no PADROES + `revisar-ddl`; o ensaio da virada confere os triggers. DROP = decisão futura.
- **D-F111 (= Q-F117 (c) — idem) — transição pela FONTE da voz**: antes da janela só o que não depende de onde a voz mora (A1 núcleo/nfse-api;
  A2 setes-api — views da 065, D-F37, RS256, conferência no boot); janela ÚNICA para congelamento + troca dos leitores + remoção das 14 rotas +
  virada + F2b, antes de 30/11. Conhecimento negativo: leitor do setes-api pelas views ANTES da virada lê a RÉPLICA atrasada (duas verdades).
- **D-F112 (= Q-F118 (a) — idem) — a SÉRIE da nota por modelo é leitura só no ERP**: peça `@shared/invoice-series` (`invoiceSerieFor` — o que
  sobra de `@shared/fiscal-issuer`) sobre a tabela do ERP; sem tela até o 1º cliente de mercadoria; a SE fica '1' depois do ato. A forma
  definitiva (config × tabela) se decide com o leiaute real da NF-e.
- **D-F113 (= Q-F119 (a) — idem) — família INSTALADA = o catálogo `VOICE_READINGS` da versão da biblioteca**: o boot do setes-api confere a view
  de cada família do catálogo (com `authority_recorded` — nota (9)); ordem de deploy: serviço da família ANTES do setes-api. Sem view-catálogo,
  sem GRANT nas tabelas base.
- **D-F114 (= Q-F120 (a) — idem) — a pendência do EFEITO no ERP é UMA classificação derivada**: `fiscalEffectOf` sobre a vigente da vida vigente
  → `none` · `apply` (= `localCancelPending` do núcleo) · `decide` (substituição sem dispensa) · `cancel` (de ofício), mais a dispensa vigente.
  A contagem por `invoice_event IS NULL` (forma do vínculo morto — D-F28) sai. "Pendência" nunca sozinha (glossário).
- **D-F115 (= Q-F121 (b) — idem) — duas rotas do ERP para o app**: `GET /api/billing/:orderId/cancel-plan` (consultiva, não travante — D-F29) e
  `GET /api/billing/:orderId/fiscal-effect` (D-F79/D-F114); o app compõe com a nfse-api (fisco).
- **D-F116 (= Q-F122 (a) — idem) — a cópia do A1 no cofre do setes-api é APAGADA na janela**, depois que o `/v1/health` da nfse-api decifrar o A1
  do `fiscal_api` — com o "vai" do Valdo (rollback proibido pela D-F50; 2ª chave privada = só exposição).
- **D-F117 (= Q-F123 (a) — idem) — a F2a se desenvolve numa WORKTREE** (`D:\Gestao2027\setes-api-f2a`, branch `f2a`) com `.env`/`secrets`/
  `node_modules` próprios; as cercas dos irmãos que leem `D:/Gestao2027/setes-api/src` passam a ler `SETES_API_DIR` (padrão: a árvore viva) e
  FALHAM ALTO quando o arquivo esperado some (hoje `existsSync` pula calado); merge na árvore viva só por item aprovado (A2) e, o lote A3, só na
  janela. Conhecimento negativo: a árvore `setes-api/` roda em `tsx watch` e É a produção da Setes — salvar = deploy; o boot aplica migrations.
- **D-F118 (= Q-F124 — Valdo 2026-10-12 — Rodada 2 da F2a, gates da A1, §22.7; os gates divergiram: perguntada à parte, "tirar da superfície") — o booleano `reconfirmationProven` NÃO sai pela
  superfície `fiscal-api/reading`**: segue a prova de UMA candidata (sem a barreira da vida, como os gates R18–R21 o fixaram) e fica no barrel
  (nfse-api, testes); quem decide o cancelamento (setes-api) enxerga, por compilação, só o VEREDITO (D-F109). Corrige o texto da D-F109 ("Proven =
  verdict === provada"): o booleano é o motivo `provada` da MESMA regra para UMA candidata, sem a barreira.
- **D-F119 (= Q-F125 (b) — idem) — o leitor público é ESCOPADO PELA VIDA**: `readFamilyTransmissions(q, família, db, ref, vida)`; o lote por
  PARES nota × vida (as vidas vigentes vêm da `vw_invoice_life` do ERP); linha de vida não pedida = falha alta; o veredito, como o `currentOf`,
  recusa lista que mistura notas ou vidas. O histórico de vidas é da tela "No fisco" (nfse-api).
- **D-F120 (= Q-F131 (a) — idem) — `environment` (tentativa e habilitação) e `source` (voz) são domínio fechado BINÁRIO**: CHECK H/P e P/Q nas
  mesmas migrations 005 (núcleo e nfse-api), sondas no boot; o mapa interno da nfse-api recusa ambiente fora de H/P (antes virava H).
- **D-F121 (= Q-F130 (a) — idem) — quem decide lê a voz DEPOIS do `FOR UPDATE` da nota**: o 1º comando da transação que decide é a trava da
  nota no ERP (PADROES_BANCO §11 regra 12); o leitor do núcleo não trava; cerca no plano da A3.
- **D-F122 (= Q-F132 (a) — idem) — nenhum código desliga o CHECK na sessão** (`SET SESSION check_constraint_checks = 0` — o MariaDB deixa,
  sem privilégio extra): PADROES_BANCO §11 regra 11 + cerca por AST no núcleo (núcleo, nfse-api, setes-api, nfe-api).
- **D-F123 (= Q-F133 (a) — idem) — as migrations 005 são RE-EXECUTÁVEIS** (`DROP/ADD CONSTRAINT IF [NOT] EXISTS`): processo morto entre o
  ALTER e o registro em `_migrations` não trava o próximo boot. Só MariaDB (como as 002/003) — a ida para MySQL 8 na F3 revê a cadeia.
- **D-F124 (= Q-F134 (a) — Valdo 2026-10-12, gates da A2 da F2a, §22.9.3) — a A2 foi PUBLICADA na hora** para conter o segredo HS256 de
  produção que estava num script de repositório PÚBLICO: `.env` vivo com a chave RS256 ANTES do merge, fast-forward do `main` até f5eee3b,
  `JWT_SECRET` retirada depois do boot novo; provado em produção que o token HS256 com o segredo vazado dá 401 (§22.9.4).
- **D-F125 (= Q-F135 (a) — idem) — a D-F37 vale em TODA guarda de ação** (FATURAR, ALTERAR, TRANSMITIR, CANCELAR e as leituras fiscais):
  licença é o que se vendeu (D-F14); super/admin passam só o privilégio. Um cliente que contrate `orders` sem `order-returns` não fatura
  devolução, nem o admin.
- **D-F126 (= Q-F136 (a) — idem) — leitura da VIDA por view travante exige UMA linha**: o `lockInvoice` do setes-api recusa mais de uma linha
  da `vw_invoice_life` (409 RESOURCE_BUSY, retryable) — conhecimento negativo do motor (PADROES §11 regra 13); a A3 leva a MESMA recusa ao
  `erp.lockInvoice` do núcleo e a todo leitor escopado pela vida (D-F119). Rejeitado: voltar ao leitor direto em `tb_invoice_event` (2ª cópia).
- **D-F127 (= Q-F137 (a) — idem) — a conferência do boot das views das famílias (`assertFamilyViewsReadable`, D-F113) entra na A3**, junto da
  porta `fiscal-voice` — antes da janela nada no setes-api lê o `fiscal_api`.
- **D-F128 (= A-F115 confirmada — Valdo 2026-10-13: "siga as recomendações", A3 da F2a, §22.11) — o plano de cancelamento CONSULTIVO
  (`GET /api/billing/:orderId/cancel-plan`) é o MESMO `buildCancelPlan` do POST numa transação SEMPRE desfeita**: nada é gravado; as
  travas duram a leitura (lock wait → 409 RESOURCE_BUSY). Uma política só — a versão "não travante" seria uma 2ª cópia do plano. Precisa a
  D-F115 ("consultiva, não travante"): "não travante" = não segura nada além da leitura.
- **D-F129 (= A-F110 confirmada — idem) — a `f2a_fiscal_passivo` também recusa o DELETE físico** nas tabelas de tentativa/voz do ERP e na
  linha SE da habilitação (o código só faz soft delete; uma linha apagada faria a re-sincronia acusar "fato que a origem não tem").
- **Rodada 4 da F2a (gates da A3) e Rodada 1 da F2b — Valdo 2026-10-13: "siga as recomendações" (§22.13.2/§22.14.3; execução no §22.16)**:
- **D-F130 (= Q-F138 (b)) — a voz do fisco ILEGÍVEL em execução degrada a LISTA e fecha a DECISÃO com código próprio**: a lista de OS devolve
  as linhas com o selo `unavailable` + alarme com a referência; as rotas que decidem (`cancel`, `cancel-waiver`, `cancel-plan`,
  `fiscal-effect`) respondem 503 `FISCAL_VOICE_UNAVAILABLE` — nunca 500 genérico. O boot segue não subindo sem as views (D-F113).
- **D-F131 (= Q-F139 (a)) — o `GET …/cancel-plan` exige o privilégio CANCELAR do ramo (a guarda do POST) e espera trava por pouco tempo**
  (sessão da consulta com `innodb_lock_wait_timeout` curto, molde da D-F41): quem não pode cancelar não segura a nota; estourou = 409
  `RESOURCE_BUSY` em segundos. Revê a D-F128 só na guarda e na espera (o plano segue o MESMO do POST).
- **D-F132 (= Q-F140 (b)) — o usuário próprio do setes-api no banco fica para a F3**: conhecimento negativo (o `setes` tem ALL — a D-F15 vale
  pela cerca por AST até lá) + sonda no boot da F3 ("INSERT no `fiscal_api` negado ao usuário do setes-api").
- **D-F133 (= Q-F141 (b)) — o núcleo na janela por checklist**: HEAD e `dist` do núcleo conferidos e registrados no passo 4; proibido
  recompilar o núcleo na máquina de produção até a F3; na F3, tag/tarball versionado como dependência (R13).
- **D-F134 (= Q-F142 (a)) — aborto antes do `--vai` por script ensaiado**: válido SÓ até o passo 5 da janela (DROP dos 9 gatilhos, remover a
  linha `f2a_fiscal_passivo` do `_migrations`, reverter o código, re-sincronizar), provado em banco descartável antes da janela; depois do
  `--vai` o rollback segue proibido (D-F50). *(EMENDADA pela D-F153: a linha não é removida — vira a LÁPIDE `f2a_fiscal_passivo_abortada`,
  gravada ANTES de derrubar os gatilhos.)*
- **D-F135 (= Q-F143 (a)) — o boot do setes-api confere os 9 gatilhos de TRAVA pelo nome** (depois do runner, molde das sondas de CHECK —
  D-F45/D-IB26): faltando ou diferente = o setes-api não sobe. Uma lista só com o ato da nfse-api (cerca).
- **D-F136 (= Q-F144 (a)) — voz A/N ⇒ registro, no mapa da família do núcleo**: `mapTransmissionView` recusa (falha alta) a tentativa cuja
  última voz é A/N sem `authority_recorded` — o molde da D-NE61 (D sem registro); o plano cai em erro fechado, nunca libera o cancelamento local.
- **D-F137 (= Q-F145 (a)) — o modelo 55 sai da aba "Emissor fiscal"**: a aba é SE + A1 pela nfse-api; a série do 55 fica só-leitura no ERP
  sem tela (D-F112) até o 1º cliente de mercadoria.
- **D-F138 (= Q-F146 (a)) — app multi-API**: uma classe `ApiClient`, N instâncias por base de URL (tipos distintos para a injeção), token num
  `ProductToken` ÚNICO lido a cada requisição; 401 numa requisição que LEVOU token = sessão morta → limpa e vai ao login (global, no core).
- **D-F139 (= Q-F147 (a)) — a saga do cancelamento é usecase de COMPOSIÇÃO no módulo** sobre dois repositórios (nfse × ERP), retomada por
  DERIVAÇÃO (reler `fiscal-effect`), nunca diário no cliente; `app/shared/fiscal` só no 2º consumidor (regra de promoção).
- **D-F140 (= Q-F148 (a)) — `effect=apply` = botão "Aplicar o cancelamento na nota"** que abre o PLANO; o humano confirma e dá o motivo (caixa
  aberto se `cashierOpen` pedir). O app nunca aplica sozinho.
- **D-F141 (= Q-F149 (a)) — a barreira fiscal do plano é TIPADA**: o bloco `fiscal` do `cancel-plan` carrega `barrier {kind:
  authorized|in-flight|cancel-in-flight|reconfirm, reason?, attempt}` (o `FiscalCancelBarrier` serializado) — na worktree `f2a`, antes da janela.
- **D-F142 (= Q-F150 (a)) — os botões do fisco pelo estado do servidor**: `state` da nfse-api + `currentAttempt` (campo NOVO, aditivo, na visão —
  a vigente pelo `currentOf` do núcleo) + `effect` + barreira; o kind é só rótulo.
- **D-F143 (= Q-F151 (a)) — `FISCAL_CUTOVER_PENDING` sem estado próprio no app**: a mensagem passa direto; o build da F2b sai DEPOIS do ato
  (passo 5 → 6); o selo do emissor usa `cutoverAt`.
- **D-F144 (= Q-F152 (a)) — erros: a mensagem da API passa direto** (Framework de Mensagens); constantes só para os códigos que MUDAM a tela.
- **D-F145 (= Q-F153 (a)) — o lote de transmissão é da OS, filtrado NO SERVIDOR**: parâmetro `interfaceKey` nas pendentes da nfse-api; lista
  fotografada na confirmação (todas as páginas, até um teto); 1 por vez; segue em erro da nota; PARA em erro sistêmico.
- **D-F146 (= Q-F154 (a)) — `NFSE_API_URL` por `--dart-define`** (build sem ele falha alto) e `CORS_ORIGINS` explícita por ambiente (dev
  `:5051`; produção a origem do Plesk); o boot de PRODUÇÃO da nfse-api recusa lista vazia ou `*`.
- **D-F147 (= Q-F155 (a)) — cache do Flutter web**: `no-cache` em `index.html`/`flutter_bootstrap.js`/`main.dart.js` no Plesk + aviso de
  recarregar; sem lápide nas 14 rotas.
- **D-F148 (= Q-F160 (a), Valdo 2026-10-13 — gates da F2b, F2B-SOC-01/ADV-06) — quem decide que a sessão morreu é QUEM EMITIU o token**:
  o 401 de uma API que NÃO emitiu o token (a nfse-api — chave de assinatura nova que ela ainda não conhece, institution divergente) não
  derruba a sessão sozinho: o app confirma com o EMISSOR (`GET /api/core/me` no setes-api); recusou = a sessão morreu (expira); aceitou = a
  sessão fica e a tela diz "o serviço não reconheceu a sessão" (`SESSION_NOT_ACCEPTED`) — nunca laço de login. Cerca (c) da questão:
  na JANELA, conferir que a nfse-api aceita o token do kid VIGENTE do setes-api antes de reabrir o uso (roteiro do §22.13).
- **D-F149 (= Q-F161 (a), Valdo 2026-10-13 — F2B-SOC-02) — a saga relê o PLANO imediatamente antes do fisco**: entre a leitura da tela e a
  confirmação passa o tempo humano (o motivo); se o plano relido não for mais "só a NFS-e autorizada impede" (ou não se ler), a saga NÃO vai
  ao fisco ("a situação mudou"). A janela que sobra é aceita e se recupera pelo efeito `apply` (D-F140). *(D-F158: essa janela é a chamada
  INTEIRA ao fisco — reserva K + termos até 3 s + o evento até 30 s ≈ 35 s, ou o timeout do gateway —, não "segundos".)*
- **D-F150 (= Q-F162 (a), Valdo 2026-10-13 — F2B-SOC-12) — rótulo NEUTRO "Cancelar nota"** na seção "No fisco" (era "Cancelar NFS-e", que
  em homologação só cancelava a nota): o que acontece no fisco a FRASE do plano diz (barreira `authorized`: cancelar a NFS-e no fisco e a
  nota; sem barreira: só a nota) — o app nunca decide pelo `environment` (D-F142).
- **D-F151 (= Q-F156 (b), Valdo 2026-10-13 — F2AR4-SOC-05) — a voz ilegível diz se a FONTE falhou ou o CONTRATO não fecha**: o app recebe o
  MESMO 503 `FISCAL_VOICE_UNAVAILABLE` (não ramifica); a mensagem e o alarme separam fonte (erro do driver/servidor — "tente de novo em
  instantes") de contrato (o mapa da família recusou a linha, argumento inválido — "INCOERENTE, tentar de novo não resolve: informe o
  código"); o alarme leva a causa na origem e o AUTOR da requisição (peça `@shared/request-actor`, fixada pelo `authMiddleware`).
- **D-F152 (= Q-F157 (b), Valdo 2026-10-13) — a conferência dos 9 gatilhos no boot segue GLOBAL + ferramenta "reaplicar a trava do schema
  X"** (`setes-api/scripts/f2a-reapply-freeze.ts` — só as instruções de gatilho da migration, e só as dos que faltam/diferem (gate
  adversarial da Rodada 5, R5-ADV-04), `USE` + como o runner; a conferência do boot
  é a pós-condição; recusa com a lápide ou sem a migration registrada); a quarentena POR INSTITUTION fica para a F3.
- **D-F153 (= Q-F158 (c), Valdo 2026-10-13) — o aborto deixa a LÁPIDE** no `_migrations` (a versão da migration com o nome
  `f2a_fiscal_passivo_abortada`): o código ANTIGO sobe normalmente (sem o arquivo, o runner não a vê); o código NOVO RECUSA subir sobre ela
  (mensagem própria — PADROES §11 regra 14); voltar à F2a = ato deliberado (`f2a-abort-before-cutover.ts … --retirar-lapide --vai`).
  *(Emendada pela D-F162: a lápide tem versão SENTINELA `F2A-ABORT`, não o número da migration; a recusa é pelo NOME.)*
- **D-F154 (= Q-F159 (a), Valdo 2026-10-13) — voz C/K (pressupõe a autorização) ⇒ registro**, no mesmo molde da D-F136: o mapa comum do
  núcleo e o `mapTx` da nfse-api falham ALTO com C (cancelada) ou K (cancelamento em voo) sem registro (antes: efeito `apply` e o POST
  soft-deletava a nota). 0 linhas assim no dado de 2026-10-13. *(D-F161: a mesma incoerência dá frases diferentes em cada porta — ERP
  "INCOERENTE", ato "resultado incerto", consulta "indisponível" —, sempre para o lado conservador; aceito.)*
- **D-F155 (= Q-F163 (a), Valdo 2026-10-13 — F2B-ADV-01) — o 500 da nfse-api num ATO (transmitir, cancelar no fisco, reconferir) é desfecho
  DESCONHECIDO** ("resultado incerto — consulte"; conta para a parada de 3 seguidos do lote); nas LEITURAS segue falha comum.
- **D-F156 (= Q-F164 (a), Valdo 2026-10-13 — F2B-ADV-03; decide a Q-R5.2 do `prompt_primeiro_cliente_setes.md`) — sair da tela PARA os
  lotes**: o Modular fecha o `ServiceOrderBloc` no `onDispose`, e `stopBatches()` (chamado pelo `dispose` da página e pelo `onDispose`)
  para o lote fiscal depois da nota em voo e o de FATURAMENTO depois do bloco em voo; o que já foi feito fica na lista; tela fechada = sem
  relatório. Conhecimento negativo (CORRIGIDO pelo gate socrático da Rodada 5 — R5-SOC-02, sonda no bloc 8.1.4): o `close()` do bloc 8
  termina logo (cancela os emitters) e o `isClosed` vira true; o handler em andamento NÃO é interrompido — continua até o fim, com as
  emissões viradas no-op. Por isso o laço do lote consulta um sinal a CADA unidade (`isClosed` ou a parada). A causa real do F2B-ADV-03 era
  o Modular nunca fechar o bloc (o bind sem `onDispose`). *(Emendada pela D-F160: o sinal é SÓ o `onDispose` do módulo.)*
- **D-F157 (= Q-F165 (a), Valdo 2026-10-13 — F2B-SOCD-01) — a CLASSE de cada 401 do produto vai ao LOG, nunca o token**: o `productAuth` do
  núcleo classifica a recusa (`missing`, `malformed`, `unknown_kid` — com o kid SANEADO `[A-Za-z0-9._-]` ≤ 64, que não é segredo —,
  `expired`, `invalid`, `no_identity`, `identity_mismatch` = 401 do conferidor de identidade) e registra com limite POR CLASSE por minuto
  (5; o excedente vira UMA linha de "suprimidas" na janela seguinte — throttle de LOG, não estado de controle); a frase do kid desconhecido
  leva o kid (o app já mostra "código: frase" de origem — F2B-SOCD-07); o log nunca derruba a resposta. A ROTAÇÃO do `JWT_KID` passa a
  exigir publicar a NOVA chave pública em toda API do produto ANTES de o setes-api virar (PADROES §7).
- **D-F158 (= Q-F166 (a), Valdo 2026-10-13 — F2B-SOCD-05) — a janela que sobra na D-F149 é aceita com o teto REAL documentado** (≈ 35 s ou
  o timeout do gateway; nesse intervalo baixa/boleto/cheque não olham o K em voo — se mudarem, o fisco cancela e a nota fica com o efeito
  `apply`). Só doc.
- **D-F159 (= Q-F167 (b), Valdo 2026-10-13 — re-gate adversarial da F2b) — voz do fisco fora + efeito `decide` = a linha do ERP**: "NFS-e
  SUBSTITUÍDA no fisco (segundo o sistema; os detalhes do fisco estão indisponíveis agora) — decida…" junto do "Manter a nota" (que nunca
  aparece sem dizer por quê); com o bloco da VOZ visível, a linha não se repete. Cada fonte mostra as próprias ações (F2B-SOC-11); o ERP
  reconfere no POST.
- **D-F160 (= Q-F168 (a), Valdo 2026-10-13 — R5-SOC-01) — os lotes param SÓ no `onDispose` do MÓDULO**: o `dispose` da página também roda
  quando a janela cruza 1100 px (o `Responsive` troca o layout desktop × mobile, cada um com o seu `RouterOutlet` — a página é recriada, o
  módulo não) e calava o lote sem o operador sair. Preservar o `RouterOutlet` na troca de layout (perda de estado de QUALQUER tela ao
  redimensionar) fica como item próprio de UX do shell.
- **D-F161 (= Q-F169 (a), Valdo 2026-10-13 — R5-SOC-08) — as frases da incoerência C/K sem registro ficam como estão** (ERP "INCOERENTE",
  ato "resultado incerto", consulta "indisponível" — todas conservadoras; a D-F154 é alarme; 0 linhas hoje). Só doc.
- **D-F162 (= Q-F170 (a), Valdo 2026-10-13 — R5-ADV-01/02) — a LÁPIDE com versão SENTINELA `F2A-ABORT`**: o aborto troca a linha da
  migration por `(F2A-ABORT, f2a_fiscal_passivo_abortada)` — o número volta a ficar livre (a próxima migration do `main` com ele não
  derruba o código ANTIGO, que é o que roda depois de um aborto); a recusa do código da F2a é pelo NOME; linha da migration E lápide juntas
  = o aborto recusa. Cabe no `VARCHAR(10)`; o runner do `main` ignora versão sem arquivo e não decide por ordem de número (conferido).
- **D-F163 (= Q-F171 (a), Valdo 2026-10-13 — Q-F168-ADV-02) — 409 `RESOURCE_BUSY` num ATO = desfecho DESCONHECIDO no app** ("resultado
  incerto — consulte"; conta para a parada de 3 seguidos do lote): a nfse-api o devolve também quando a gravação da voz DEPOIS do fisco
  esbarra numa trava. Leituras seguem falha comum.
- **D-F164 (= Q-F172 (a), Valdo 2026-10-13 — R5-ADV-05) — a linha INCOERENTE é pulada COM alarme no rodízio**: `listRefreshCandidates`
  (nfse-api) recebe um aviso opcional — sem ele falha alto como antes (o leitor da NOTA nunca a engole); a passada do rodízio pula a linha
  (log de erro com ref + o relatório da passada com `INTERNAL` e a ref), marca `last_queried_at` (não volta no topo de toda passada) e
  segue com as coerentes. *(Gates da Rodada 6 — R6-SOC-07/R6-ADV-04: só a INCOERÊNCIA de DADO é pulada — `IncoherentTransmissionError`;
  a projeção torta relança.)*
- **D-F165 (= Q-F173 (a), Valdo 2026-10-13 — gate socrático da Rodada 6, R6-SOC-05) — o verificador do núcleo exige `kid` e `exp`, como o
  do setes-api** ("dois leitores, uma resposta"): token sem `kid` (ausente, vazio, não-texto) = 401 `malformed` "Token sem kid"; sem `exp`
  = 401 `invalid` "Token sem validade (exp)". A chave "padrão" deixa de ser fallback para token sem kid (só nomeia a 1ª da configuração).
  Não quebra configuração: o setes-api sempre assina com `kid` e `exp` (F2A2-ADV-07).
- **D-F166 (= Q-F174 (a), Valdo 2026-10-13 — gate socrático da Rodada 6, R6-SOC-06) — `RESOURCE_BUSY` ANTES do fisco num ato também é
  "resultado incerto"** (reserva da transmissão que mudou no meio, `lockInvoice` com > 1 linha, lock wait/deadlock residual, "tentativa
  mudou" na reconferência): limite CONHECIDO da D-F163, coerente com a D-F155 (falha não-negócio num ato = desconhecido) — a releitura
  mostra a verdade e nada irreversível acontece; custa a frase "tente de novo" e o lote parar com frase de incerteza sob contenção
  sustentada. Código próprio para a falha DEPOIS do fisco (e o "tente de novo" de volta) quando o worker do rodízio (F3) mexer no contrato.
- **D-F167 (= Q-F175 (b), Valdo 2026-10-13 — R6-ADV-01) — o log do 401 mostra a 1ª ocorrência de cada KID DISTINTO (por classe) na janela**,
  além do limite de 5 por classe: o kid é lido antes da assinatura, e kids inventados por um anônimo ocupavam a cota de `unknown_kid` — o
  kid REAL de uma rotação mal publicada (o caso da D-F157) sumia. Conjunto LIMITADO a 16 por janela (memória fixa); o resumo conta só o
  que NÃO foi ao log.
- **D-F168 (= Q-F176 (a), Valdo 2026-10-13 — R6-ADV-05) — o relatório do lote fiscal separa "incertas — consulte"**: o desfecho DESCONHECIDO
  (D-F155/D-F163 — `isUnknownAuthorityOutcome`) tem contador e linha próprios ("resultado incerto — consulte a situação no fisco antes de
  transmitir de novo"); nunca "recusada / tente novamente" — a NFS-e pode ter sido autorizada. As não tentadas (lote parado) seguem com as
  recusadas.
- **D-F169 (= Q-F177 (a), Valdo 2026-10-13 — R6-ADV-06/R6-SOC-08) — com um lote no ar, a lista sai em `loading`**: a página recriada no meio
  do lote (cruzar 1100 px — D-F160) pede a lista; sem isto a trava H1 dos botões reabria e a tela parecia ociosa com o lote rodando. Vale para
  os dois lotes (faturamento e fiscal); cada um baixa a própria marca ANTES da recarga final (a lista final sai livre).
- **D-F170 (= Q-F178 (b), Valdo 2026-10-13 — R7-SOC-01/R7-ADV-02) — o resumo do log do 401 lista os kids MAIS FREQUENTES da janela**:
  16 contadores pelo algoritmo Space-Saving (memória fixa; a contagem pode SUPERESTIMAR, nunca subestimar) — todo kid com mais de 1/17 das
  recusas com kid fica na lista; o de uma rotação mal publicada (toda sessão, toda requisição) vence qualquer volume de kids inventados (os
  16 forjados no começo da janela esgotavam o conjunto da D-F167). Linha própria, junto do resumo das suprimidas e só quando houve supressão.
- **D-F171 (= Q-F179 (a), Valdo 2026-10-13 — R7-SOC-02) — "não tentadas" com contador e linha próprios no relatório do lote fiscal**
  ("Não tentadas: N — o lote parou antes delas"; a linha "Ordem N: não tentada — o lote parou antes dela") — nunca "recusadas" nem com a
  frase da falha que parou o lote.
- **D-F172 (= Q-F180 (a), Valdo 2026-10-13 — Q-F178-ADV-03) — `exp` SEM teto por enquanto** (só quem tem a chave privada emite; o setes-api
  assina com 24 h); o teto `exp ≤ agora + 24 h + folga` entra nos DOIS leitores (núcleo e setes-api) na próxima vez que alguém mexer neles —
  pegaria um bug de `exp` em milissegundos. Só doc.
- **D-F173 (= Q-F181 (a), Valdo 2026-10-13 — R8-SOC-01/R8-ADV-01) — o limite do resumo dos kids é ACEITO como conhecimento negativo**: com 16
  contadores o Space-Saving garante só os kids com MAIS DE 1/16 das recusas com kid da janela; um atacante com ~16× o volume do kid real
  (distintos) ou com 16 kids REPETIDOS um pouco mais frequentes o esconde — um kid não autenticado não se distingue de um forjado com memória
  fixa (3ª volta no mesmo ponto: D-F157 → D-F167 → D-F170). O canal confiável do kid real é a frase do 401 que o app mostra. Textos corrigidos
  (JSDoc, teste); os testes do gate que provam o limite ficam como `it.failing` "[LIMITE CONHECIDO]".
- **D-F174 (= Q-F182 (b), Valdo 2026-10-13 — R8-SOC-04) — o detalhe aberto não é derrubado**: entrar no detalhe (ver OS / abrir OS) INVALIDA
  a recarga da lista em voo (contador de geração do `_reloadList` — R7-SOC-03), e o fim de um lote (faturamento ou fiscal) com uma OS aberta
  mostra o RELATÓRIO e não recarrega a lista (voltar à lista recarrega). Um lote de até 500 notas leva dezenas de minutos; abrir uma OS no meio
  é uso legítimo. *(Implementação revista pelas correções dos gates da Rodada 9 — §22.28: UM contador da tela, vale o último pedido; o pedido
  de detalhe a caminho também conta como "no detalhe"; as operações longas não cancelam o detalhe pedido.)*
- **D-F175 (= Q-F183 (b), Valdo 2026-10-13 — R8-ADV-01) — a linha dos kids imprime o MÍNIMO GARANTIDO**: o Space-Saving guarda o ERRO de
  cada contador (o mínimo herdado ao entrar no lugar de outro) e a linha imprime `count − erro` (nunca superestima): o kid inventado visto
  uma vez aparece com ~1, o real com a sua contagem; ordenada por ele. Limite conhecido (D-F173): o real despejado e readmitido só garante o
  que viu desde a última entrada.
- **D-F176 (= Q-F184 (b), Valdo 2026-10-13 — R8-ADV-03) — a linha incerta sem código mostra o STATUS HTTP** ("HTTP 503" — o suporte sabe
  que foi o proxy) e, com a rede caída, "sem conexão" (o texto da exceção — o `supportRef` da rede — não vai à tela).
- **D-F177 (= Q-F185 (a), Valdo 2026-10-13 — R9-SOC-03) — a regra da D-F174 em TODA saída longa** (rotina mensal, pendentes do lote fiscal):
  com a OS aberta (ou a caminho) o desfecho aparece e a lista não é recarregada; o botão da rotina mensal fica TRAVADO pelo loading, como os
  botões de lote (H1).
- **D-F178 (= Q-F186 (a), Valdo 2026-10-13) — o detalhe preservado NÃO é relido no fim do lote** (conhecimento negativo, comentário no bloc +
  teste que fixa a semântica): a UI não chega a uma OS do lote aberta durante ele (a lista é spinner; o FAB cria OS NOVA) e o servidor protege
  (409/trava da nota); reler no meio de uma ação reabriria os botões em voo.
- **D-F179 (= Q-F187 (a), Valdo 2026-10-13 — R10-SOC-02/R10-ADV-01) — a trava H1 COMPLETA da rotina mensal e do "Transmitir pendentes"**:
  cada uma com a SUA trava de reentrância no bloc (`_monthlyRunning`, `_fiscalPendingRunning` — como o `_batchRunning`) e as duas no
  `_batchInFlight` da D-F169 — a lista fica em loading enquanto elas rodam (aba, filtro, pesquisa avançada ou página recriada no meio não
  reabrem os botões); cada uma baixa a marca ANTES da recarga final. Operações longas DIFERENTES juntas: quem impede é a página (todo botão
  longo é `state.loading ? null`); o bloc não cruza as travas (os dois lotes juntos são caso provado da D-F169).
- **D-F180 (= Q-F188 (a), Valdo 2026-10-13 — R10-SOC-04; os gates divergiam) — na linha incerta do lote, o "ref" só quando veio do envelope
  do SERVIDOR**: a falha que o próprio app monta (`CLIENT_*` — resposta ilegível, configuração) mostra só o código; o texto inteiro segue na
  mensagem do ato avulso (F2B-ADV-12 fica — o rastro para o suporte é abrir a OS e "Consultar").
- **D-F181 (= Q-F189 (a), Valdo 2026-10-13 — R10-ADV-04) — a linha da rede diz uma frase NEUTRA**: "sem resposta do serviço — rede, proxy ou
  tempo" (no app WEB a página 502/503/504 do proxy sem CORS também chega como `NetworkFailure` — "sem conexão" mandava o suporte atrás da
  internet do cliente); no passeio logado, provocar um 502/504 do proxy para ver o que o navegador entrega.
- **D-F182 (= Q-F190 (a), Valdo 2026-10-13 — R11-SOC-01/02 = R11-ADV-02) — o desfecho de um ato cuja tela SAIU no meio** (página recriada):
  a MESMA OS reaberta é RELIDA no fim do ato (pela tela de AGORA, conferida de novo na chegada); outra OS ou a lista: o desfecho leva o
  NÚMERO da OS ("OS 7374: NFS-e autorizada — …" — `orderId` nos one-shots, prefixo pela ponte). A lista desatualizada depois de faturar NÃO
  é relida (se corrige ao abrir a OS) — D-F202: idem depois de cancelar a OS.
- **D-F183 (= Q-F191 (a), Valdo 2026-10-13 — R11-SOC-02 = R11-ADV-03) — a trava de duplo clique é POR NOTA** (`Set<int>` das OS em voo no
  Transmitir e no cancelar/"manter a nota"): o clique na OUTRA OS vai; quem protege a nota é a trava DELA na nfse-api/ERP.
- **D-F184 (= Q-F192 (a), Valdo 2026-10-13 — R11-SOC-03) — a decisão confirmada num diálogo vai ao bloc se ELE está vivo** (`_dispatch`
  confere o `isClosed`), não pelo `mounted` da página (os diálogos abrem no Navigator raiz e sobrevivem à página recriada; o servidor confere
  tudo de novo — D-F149). Entre DOIS diálogos encadeados a página ainda precisa estar montada (o 2º abre pelo contexto dela).
- **D-F185 (= Q-F193 (a), Valdo 2026-10-13 — R11-SOC-05 = R11-ADV-04) — a frase NEUTRA também nos atos fiscais e na seção "No fisco"**: só
  nas chamadas à nfse-api (o repositório troca a mensagem da `NetworkFailure` por "Sem resposta do serviço — rede, proxy ou tempo."; o tipo e
  o ref seguem). Mudar `core.errors.network` no app inteiro fica para depois do 502/504 provocado no passeio logado.
- **D-F186 (= Q-F194 (a), Valdo 2026-10-13 — R11-ADV-05) — DE ONDE rodar os scripts do setes-api nas frases do ato: texto neutro no tempo**
  ("a partir da árvore do setes-api com a F2a (a worktree até a janela; a árvore principal depois)" — UMA constante, nas frases da lápide e do
  D-F110): a virada é por institution, as próximas não podem apontar para uma cópia velha.
- **D-F187 (= Q-F195-SOC-01 (a), Valdo 2026-10-13 — R12-SOC-01) — o desfecho e os relatórios de lote citam o número que a TELA mostra**:
  o Nº da OS (`number ?? id` — o mesmo da lista e do detalhe; no dev os 344 ids diferem dos números) no prefixo "OS N:" (D-F182) e no
  relatório do lote de faturamento; no lote FISCAL, o nº da NOTA que a pendente já traz. Nunca a chave interna.
- **D-F188 (= Q-F195-SOC-02 (b), Valdo 2026-10-13 — R12-SOC-04)**: a frase neutra na aba "Emissor fiscal" (módulo establishment) é decidida
  JUNTO com o `core.errors.network` do app inteiro, depois do 502/504 provocado no passeio logado (D-F185).
- **D-F189 (= Q-F195-SOC-03 (a), Valdo 2026-10-13 — R12-SOC-06) — fechar os descartes silenciosos que sobraram**: o 2º diálogo encadeado
  (motivo do cancelamento no fisco) abre pelo Navigator RAIZ (o "sim" do 1º não se perde com a página recriada); o plano do cancelamento da
  MESMA OS reaberta abre; a pesquisa avançada vai por `_dispatch` (aplica no BLOC); o aviso de documento indisponível (XML/DANFSe) leva o
  prefixo "OS N:".
- **D-F190 (= Q-F195-SOC-04 (a), Valdo 2026-10-13 — R12-SOC-08) — o aborto da F2a só ANTES da 1ª janela**: o script recusa quando
  QUALQUER institution da instalação já virou (`cutover_at` no `fiscal_api`) — depois do merge da F2a na árvore principal, a lápide num
  schema faria o boot recusar para TODOS; e as frases da lápide voltam a citar a WORKTREE da F2a (o D-F110 segue com o texto neutro da
  D-F186).
- **D-F191 (= Q-F195-SOC-05, Valdo 2026-10-13 — R12-SOC-02/03)**: (a) para o R12-SOC-02 — a marca "a caminho" carrega a OS
  (`_pendingDetailOrder`): o ato que termina com a MESMA OS a caminho não leva prefixo e PEDE a OS de novo (o pedido em voo perde a vez — ele
  pode ter lido antes do efeito); (b) para o R12-SOC-03 — a releitura de um ato antigo na MESMA OS reaberta com OUTRO ato em voo nela emite o
  detalhe sem `saving` = limite conhecido (comentário + teste que fixa a semântica; as travas por nota cobrem Transmitir/Cancelar/Manter e
  o servidor protege o resto).
- **D-F192 (= Q-F196-SOC-01 (a), Valdo 2026-10-13 — R13-SOC-01) — a guarda da D-F190 fica pelo fato `cutover_at` e o ROTEIRO a protege**:
  toda habilitação que nasce pela nfse-api já nasce com `cutover_at` (D-F39) — então (i) o ENSAIO do aborto (sem `--vai`) entra no passo 3 da
  janela, ANTES do merge, e tem de responder SEM recusa; (ii) pré-condição da janela: NENHUMA habilitação SE criada pela nfse-api no
  `fiscal_api` de produção até a 1ª janela (o passeio logado da F2b não cria habilitação nesse banco). Zero código.
- **D-F193 (= Q-F196-SOC-02 (a), Valdo 2026-10-13 — R13-SOC-02) — a releitura de um ATO morre se o detalhe ABERTO saiu por um lote
  confirmado por cima** (a regra do R10-SOC-03 volta: `act: true`); só a OS A CAMINHO por escolha do operador (ver/abrir) vence o lote
  (D-F174) — a releitura dela segue como pedido de detalhe "a caminho" (D-F191 (a)).
- **D-F194 (= Q-F196-SOC-03 (a), Valdo 2026-10-13 — R13-SOC-04) — o plano do cancelamento abre também com a MESMA OS a caminho**
  (`_showsOrder`), coerente com a D-F191 (a).
- **D-F195 (= Q-F197-SOC-01 (a), Valdo 2026-10-13 — autorização em pé; R14-SOC-01) — a recusa do ENSAIO do aborto no passo 3 PARA a
  janela antes do passo 4**, com o procedimento no roteiro (§22.13): identificar a linha (`SELECT tb_institution_id, model, created_at,
  tb_user_id, deleted FROM fiscal_api.tb_establishment_issuer WHERE cutover_at IS NOT NULL`), provar que ela nunca transmitiu (0
  tentativas), APAGAR FISICAMENTE só com o "vai" do Valdo na hora (a exclusão lógica continua contando) e ensaiar de novo. A pré-condição
  vira: NENHUMA linha com `cutover_at` no `fiscal_api` de produção — qualquer modelo, qualquer institution, viva ou excluída.
- **D-F196 (= Q-F197-SOC-02 (a), Valdo 2026-10-13 — R14-SOC-04) — o plano que chega com a tela em OUTRA OS ou na lista some sem aviso**
  = conhecimento negativo (comentário na guarda; o GET não tem efeito; uma frase convidaria a decidir sem ver a OS — R10-SOC-03).
- **D-F197 (= Q-F197-ADV-01 (a), Valdo 2026-10-13 — R14-ADV-01) — o ato nascido com a OS A CAMINHO (o plano aberto sobre a lista — D-F194)
  não marca `saving`** = limite conhecido, a família da D-F191 (b) (comentário no `_beginDetailAct`; o ACHADO do gate fica pulado com o
  motivo; a trava por nota barra o 2º envio).
- **D-F198 (= Q-F197-ADV-02 (a), Valdo 2026-10-13 — R14-ADV-02) — one-shots IGUAIS seguidos viram UM** (`Equatable` + o bloc descarta estado
  igual) = conhecimento negativo (comentário no estado): nenhuma regra pode contar avisos iguais seguidos.
- **D-F199 (= Q-F198-SOC-01 (a) = Q-F198-ADV-01 (a), Valdo 2026-10-13 — autorização em pé; R15-SOC-01 = R15-ADV-01, os dois gates
  concordaram) — UM predicado "a tela capturada ainda é o detalhe DESTA OS"** (`_stillOnActDetail(screen, orderId)`) em todo ponto que
  re-emite o detalhe capturado ou tira o operador dele (o fim sem recarga, a troca de aba do Faturar); as decisões "a tela é a OS do ato"
  (prefixo, releitura, plano, lista depois de cancelar a OS) são do `_showsOrder`. Nada alcançável pela página muda — a garantia sai da
  página e vai para o bloc (o plano da A nunca abre sobre a B; o fim de um ato da A não tira o operador da B nem desmarca o `saving` dela).
- **D-F200 (= Q-F198-SOC-02 (a), Valdo 2026-10-13 — R15-SOC-03; premissa CORRIGIDA pelo gate da Rodada 16, R16-SOC-01 = Q-F199-SOC-01
  (a)) — a RECONFERÊNCIA nascida com a OS a caminho (a porta da D-F194) não tem trava por nota no app** = conhecimento negativo: o 2º clique
  manda outra reconferência. Ela é aceita porque a DUPLICATA É INOFENSIVA — não porque o servidor serializa: a reconferência é um `GET /dps`
  no fisco (sem efeito) e a prova do E2404 pousa por UPDATE condicional à última voz vista (D-F90, sem trava longa); duas reconferências
  juntas viram dois GET e dois carimbos (o 2º mais novo, ainda posterior ao F — a prova da D-F94 continua válida) e as duas dizem
  "provada"; só o caminho em que o fisco ACHA a nota passa pela trava da nota (`withInvoiceTx` — reconciliação).
- **D-F201 (= Q-F198-ADV-02 (a), Valdo 2026-10-13 — R15-ADV-02) — a cascata do `saving` na MESMA OS** (a releitura do 1º ato reabriu os
  botões; o operador disparou o 3º; o fim do 2º — que nasceu depois de a releitura do 1º ser PEDIDA, no mesmo contador — o desmarca) =
  conhecimento negativo, a família da D-F191 (b): não há contador de atos por OS (o R14-ADV-01 recusado na D-F197); as travas por nota e o
  servidor protegem.
- **D-F202 (= Q-F199-SOC-02 (a), Valdo 2026-10-13 — autorização em pé; R16-SOC-04) — a cláusula da D-F182 vale também para "Cancelar
  OS"**: a lista desatualizada depois de faturar OU de cancelar a OS NÃO é relida (página recriada no meio do ato, a lista carregada antes
  do commit — clicar na OS excluída dá 404, que vira falha e recarga). Sem código.
- **D-F203 (= Q-F199-ADV-01 (a), Valdo 2026-10-13 — autorização em pé; R16-ADV-01) — o Faturar na OS aberta com OUTRO ato dela relido no
  meio RELÊ a OS em vez de trocar para a aba Faturadas** (a releitura do outro ato subiu o contador — a raiz da D-F201): a nota aparece no
  detalhe; a aba fica para o operador. Conhecimento negativo (comentário no `_endDetailAct`); a alternativa (decidir pela tela de agora)
  reintroduziria o "a tela não mudou" que a D-F199 aposentou.
- **D-F204 (= D-F188 decidida — Valdo 2026-10-13, passeio logado: "Frase neutra no app todo") — `core.errors.network` NEUTRO no app
  inteiro** ("Sem resposta do serviço — rede, proxy ou tempo." / "No response from the service — network, proxy or timeout."), a aba
  "Emissor fiscal" incluída. Provado no navegador: o 502/504 do proxy SEM CORS chega ao app web como `net::ERR_FAILED`/"Failed to fetch" —
  igual à rede caída; "Falha de conexão com o servidor" mandava o suporte atrás da internet do cliente.
- **D-F205 (= P-01 (a), Valdo 2026-10-13) — a falha de rede leva um código CURTO do serviço** (`NETWORK · setes-api` / `NETWORK ·
  nfse-api` — `serviceLabel` do `ProductApiClient`); a exceção crua do Dart (com a URL interna) vai só para o log. Revê o docstring antigo da
  `NetworkFailure` ("expor a causa real"): no navegador o texto cru nunca foi pista.
- **D-F206 (= P-03 (a), Valdo 2026-10-13) — falha de CARGA de lista = estado de erro com "Tentar novamente"**, nunca "Não encontramos
  nenhum registro em nossa base". Feito na lista de OS (`loadFailed`); as ~28 listas da fábrica (`RegisterSearchPage`) = tarefa própria.
- **D-F207 (= P-05 (a), Valdo 2026-10-13) — dado de produção antes de reabrir o uso na janela**: as 7 notas "sem NFS-e" da OS (ids
  8004–8010, sobras da trilha de 28/09) têm o código municipal "0102" CONGELADO e nunca transmitem (a nfse-api e o caminho atual recusam —
  `FISCAL_DPS_INVALID`, cTribMun = 3 dígitos) → CANCELAR as 7 pela tela; as regras de ISS 1, 3 e 4 (ativas, "0102", sem serviço ligado)
  → DESATIVAR. Com o "vai" na hora (passo 6b do §22.13).
- **D-F208 (= PSO-SOC-01 (b), Valdo 2026-10-13: "siga as recomendações") — o texto cru da falha de rede vai para o CONSOLE por
  `debugPrint`** (no release do web o `developer.log` do dart2js é no-op — a D-F205 prometia um log que não existia; no Android futuro,
  logcat): a causa técnica (certificado, DNS, conexão recusada) fica para o suporte; a URL aparece só no console do próprio navegador.
- **D-F209 (= PSO-SOC-03 (a)) — o P-04 tem EXCEÇÃO para o 400 de DTO** (`code` de validação genérica — `error: 'Validação falhou'`): aí
  a mensagem do CAMPO sozinha é a certa; nos demais (422 de domínio como o `FISCAL_DPS_INVALID`) vai a principal + a do campo; teste do
  listener com os três casos. Levar a regra à PEÇA da ponte (valendo no app inteiro) = pendência registrada.
- **D-F210 (= PSO-SOC-05 (a)) — os repositórios do core (auth, menu, preference, theme) param de rotular erro de LEITURA como rede**:
  `catch (_) → invalidResponseFailure(err)` (a regra da F2B-ADV-12), porque a rede real já chega como `Failure` pelo `ApiClient`.
- **D-F211 (= PSO-ADV-06 (a) = PSO-SOC-06, Valdo 2026-10-13) — falhas de rede IGUAIS seguidas viram UM diálogo** (com o código curto da
  D-F205 elas ficaram iguais; a D-F198 as junta) = conhecimento negativo (comentário na `sealed class ServiceOrderState`).
- **D-F212 (= PSO-ADV-07 (a)) — o código curto não vai aos AVISOS do ato fiscal** (`ServiceOrderFiscalNotice` — o desfecho desconhecido):
  o aviso nasce de um ato de UM serviço; aceito.
- **D-F213 (= LD-ADV-05 (a), gates do último delta, 2026-10-13) — a guarda cruzada da fotografia × lote fiscal é de UM lado só**
  (conhecimento negativo no handler do lote): a fotografia não começa com o lote no ar; o lote (evento direto) pode começar com a fotografia
  no ar — pela página não se chega (o lote nasce do diálogo MODAL da fotografia — a I3 da D-F199).
- **D-F214 (= LD-ADV-09 = LD-SOC-03 (a), Valdo 2026-10-14) — a falha MONTADA pelo cliente (`ClientFailureCodes.all`) é TÉCNICA** nas
  duas pontes (app `feedback.dart` e `isTechnicalFailure` do core), mesmo sem ref — nunca "Atenção" para resposta ilegível/configuração.
- **D-F215 (= LD-SOC-07 (b), Valdo 2026-10-14) — o console da falha de rede leva só o CAMINHO** (sem a query — CPF/CNPJ do prefill,
  filtro digitado) e a causa sem o `uri=`; a causa técnica fica.
- **D-F216 (= LD-ADV-03 (a) + LD-SOC-08 (b), Valdo 2026-10-14) — os leitores do core exigem `{ ok: true }`** (`envelopeOk`; todas as rotas
  `/auth/*` e `/api/core/*` respondem assim — conferido no setes-api, worktree e árvore viva) e o erro de leitura leva o código curto
  `INVALID_RESPONSE · <serviço>` (`invalidResponseFailure(e, service:)`; o texto cru vai ao console — a regra da D-F208).
- **D-F217 (= LD-ADV-10 (a), Valdo 2026-10-14) — o recuo "página esvaziou" só quando a página pedida passou do total de páginas**
  (na lista de OS; as outras listas entram na tarefa das 28 listas): o servidor com COUNT diferente da lista fazia o bloc pedir a mesma
  página sem parar.
- **D-F218 (= Q-LE1 (a), Valdo 2026-10-14) — a troca de senha NÃO é idempotente** (o servidor consome o código): resposta ilegível ou
  rede na volta com a senha já trocada = "Código inválido" na nova tentativa; a saída do operador é entrar com a senha nova ou pedir outro
  código. Conhecimento negativo (comentário no `AuthRemoteDatasource.changePassword`).
- **D-F219 (= LE-ADV-02 (a), Valdo 2026-10-14) — o token que o RELÓGIO do aparelho já dá por vencido não entra**: o AuthBloc confere o `exp`
  (`jwtExpiry`) antes de `AuthAuthenticated` → erro técnico `CLIENT_CLOCK` ("a data e a hora deste computador parecem erradas…"), com a
  hora do aparelho no código (`CLOCK · <hora>`); token sem `exp` legível = resposta ilegível. Antes a guarda recusava e o login voltava MUDO.
- **D-F220 (= LE-ADV-07 (b), Valdo 2026-10-14) — a query de QUALQUER URL dentro da causa sai antes do console** (além do `uri=` da
  D-F215). Conhecimento negativo: o console do próprio navegador registra a requisição que falhou — fora do alcance do app.
- **D-F20 — suspensa EM PARTE pela D-NE1 (Valdo 2026-10-10)**: as ondas NE-0…NE-3 da nfe-api (levantamento oficial, núcleo
  generalizado, esqueleto + DDL, adaptador SEFAZ provado em H só nos serviços que não exigem emitente com IE) podem ter código;
  builder de autorização em produção continua esperando o 1º cliente de mercadoria (`prompt_onda_nfe_sefaz.md` §11.7).

**§8 ZERADA em 2026-10-03 (Rodada 2).** O plano consolidado que substitui §4–§6/§10/§11 onde houver conflito está no §12.

---

## 8. ⚠️ Questões pendentes — Rodada 1 (recomendação entre parênteses)

- ~~**Q-F1 Uma API, duas ou duas com núcleo comum?**~~ → **DECIDIDA = D-F1** (opção (i): `fiscal-api` única com famílias; (ii) fica como topologia de deploy).
- ~~**Q-F2 Transmissão e voz moram no serviço ou no ERP?**~~ → **DECIDIDA = D-F10** ((a), na API). Texto original: (a) **no serviço** (tentativa, voz, nDPS, XML, DANFSe); o ERP guarda só o VÍNCULO nota × documento (estado: Q-F16) · (b) no ERP; o serviço é só transporte (assina + mTLS + parse). *(Rec.: (a), confirmada pelo guardião §3.B — em (b) cada consumidor reimplementa a parte que os gates provaram ser a difícil: K em voo, reconciliação, ambíguo nunca fecha, 1 viva por documento; e o par PEM teria que viajar por chamada.)*
- ~~**Q-F3 Autenticação dos aplicativos**~~ → **ABSORVIDA pela D-F13** (mesmo login do produto; credencial de app sem humano = S1). Texto original: (revisada pela D-F2 — múltiplos apps por cliente desde o 1º dia): (a) API key fixa por app no header (`X-Api-Key`, precedente D12) · (b) **credencial por app (`app_id` + `secret` só em hash) trocada por TOKEN CURTO (`POST /v1/auth/token`, JWT ~1 h) — client-credentials simplificado, §5.8** · (c) OAuth2 completo (authorization server). *(Rec.: (b) — a chave nunca viaja por requisição, revogação é imediata na próxima troca, serve de base ao token exchange para apps móveis (Q-F22); (a) é frágil com N apps por cliente; (c) é peso sem consumidor que o exija.)*
- ~~**Q-F4 Como a voz nova chega ao ERP**~~ → **ABSORVIDA pela D-F11** (o setes-api lê a voz no `fiscal_api`). Texto original:: (a) **resposta síncrona do próprio pedido + `refresh` sob demanda/rotina** (como hoje) · (b) + callback HTTP assinado na URL da conta como GATILHO de consulta (regra do webhook do Inter). *(Rec.: (a) na F1/F2; (b) como opção da conta na F3, quando houver URL pública.)*
- ~~**Q-F5 Banco do serviço**~~ → **DECIDIDA = D-F7**. Texto original: (a) **`fiscal_api` único, escopo por linha `tb_licensee_id`** · (b) schema por cliente como o ERP. *(Rec.: (a) — o serviço não tem "cliente do ERP"; tem licenciado e emitente. O nome NÃO pode ser `setes_<algo>`: casaria com o `SCHEMA_RE` dos schemas de cliente — §3.I-5.)*
- ~~**Q-F6 Pastas e repos**~~ → **DECIDIDA = D-F1** (pasta `fiscal-api/` + espelho `Infra-IA/fiscal-api/`, criados em 2026-10-03; repo GitHub `valdosouza/gestao-2027-fiscal-api` a criar pelo Valdo).
- ~~**Q-F7 Corte dos dados da Setes**~~ → **DECIDIDA = D-F18**. Texto original: (a) **migração única (script) + corte com H antes de P**, sem dual-write · (b) dual-run (ERP grava nos dois) por N dias. *(Rec.: (a) — dual-write em transmissão fiscal cria duas verdades; a trilha P8 e a reconciliação por `dps_id` são a prova.)*
- ~~**Q-F8 D-E20 mantida?**~~ → **DECIDIDA = D-F20** (nfe-api pasta + espelho agora, sem código). Texto original: A NF-e em si espera o 1º cliente de mercadoria. O que antecipar da família nfe: (a) **só o contrato OpenAPI já paramétrico por família + levantamento oficial da SEFAZ (`integracoes/nfe-sefaz/`) + a estratégia por família prevista no código da F1** · (b) executar F4 agora porque a API é produto. *(Rec.: (a) — sem cliente não há homologação real nem e-CNPJ com IE; IBS/CBS (Q-F14) precede qualquer NF-e. Em qualquer caso, pelo §3.I-6 a NF-e **nasce na API, nunca no ERP** — a D-E20 segue valendo para o QUANDO, não para o ONDE.)*
- ~~**Q-F9 Legado Gestao2016 como 2º consumidor da `nfse-api`?**~~ → **DECIDIDA = D-F25**. Texto original: Curitiba exige NFS-e nacional desde 01/01/2026 — o webservice municipal do legado morreu. (a) registrar como candidato (fora desta fase) · (b) planejar `TNfseSendWeb` no sincronizador · (c) o legado chama a `nfse-api` direto. *(Rec.: (a) — a regra dos dois grupos (sincronizador ↔ setes-sync) precisaria de decisão própria antes de nascer um 3º grupo.)*
- ~~**Q-F10 Ordem**~~ → **DECIDIDA = D-F19** (extrair no dev; F3 = Onda 4 na topologia D-F9). Texto original: (a) **F1 → F2 no dev → F3 publica a `nfse-api` como piloto da Onda 4** · (b) Onda 4 do ERP inteiro primeiro, extrair depois. *(Rec.: (a) — a extração não depende de produção, e publicar primeiro o serviço pequeno ensina a SaveInCloud com menos superfície.)*
- ~~**Q-F11 Autorização de AÇÃO**~~ → **ABSORVIDA pela D-F13** (regra do ERP, aplicada pela porta fiscal lendo o schema do cliente). Texto original: (TRANSMITIR/CANCELAR por usuário) fica no ERP; o serviço só autentica a CONTA e registra o `requestedBy` opaco que o consumidor mandar. *(Rec.: sim — privilégio é do usuário do ERP; o serviço não tem usuário.)*
- ~~**Q-F12 Produto/cobrança do serviço**~~ → **DECIDIDA = D-F26**. Texto original: (metering por documento, planos): fora desta fase; só garantir que "documentos emitidos por conta/mês" seja consulta derivada das tentativas. *(Rec.: fora; nada a modelar.)*
- ~~**Q-F13 Versionamento**~~ → **DECIDIDA = D-F8**. Texto original: `/v1/` desde o 1º dia (contrato externo), `Accept-Version` não. *(Rec.: sim — diferente do `/api` interno, que acompanha o app.)*
- ~~**Q-F14 IBS/CBS**~~ → **DECIDIDA = D-F22**. Texto original: é pré-requisito da F4 (NF-e regime regular desde 03/08/2026; Simples 01/01/2027 — inclusive a NFS-e da Setes). Vive no motor do ERP (`tb_order_item_ibscbs` + regra) e no builder dos dois documentos. (a) **fase própria "IBS/CBS" antes da F4 e antes de 01/01/2027 para a NFS-e** · (b) dentro da F4. *(Rec.: (a) — toca os dois documentos e o motor; não é da API fiscal.)*
- ~~**Q-F15 O que do emitente é CADASTRO no serviço × o que viaja por documento**~~ → **ABSORVIDA pela D-F10** (nada viaja: a API lê do ERP). Texto original:: (a) **cadastro: CNPJ, nome, cMun IBGE do emitente, IM, fuso IANA, ambiente/série por modelo; por documento: regTrib (opSimpNac/regApTribSN/regEspTrib), pTotTribSN, tomador, serviço, valores** · (b) tudo no cadastro do emitente. *(Rec.: (a) — regime e alíquota efetiva mudam no tempo e são fatos da competência; o XML congela; o ERP já os valida (422 `FISCAL_EMITTER_INCOMPLETE`); a API aplica a matriz do Anexo I (`emitterDpsFacts`) e devolve o mesmo `fields[]`.)*

**Acrescentadas pelo parecer do guardião (§3.I):**

- ~~**Q-F16 Estado fiscal no ERP**~~ → **DECIDIDA = D-F11** ((a): nenhuma coluna de estado; o ERP lê o estado derivado no `fiscal_api`). Texto original:: (a) **sem espelho — lista e detalhe por lote de referências (`GET /documents?externalCode=…`); API fora = selo "indisponível" e ações fiscais 503** · (b) espelho de EXIBIÇÃO escrito só pela notificação, nunca decisório. *(Rec.: (a) — zero coluna de estado; "status sincronizado por cron" é maquete. (b) só se a latência da lista de OS doer de verdade — medir antes.)*
- ~~**Q-F17 Granularidade do licenciado**~~ → **DECIDIDA = D-F2** (um licenciado por CLIENTE; o setes-api é um `tb_licensee_app` de escopo pleno de cada licenciado, provisionado no onboarding da institution).
- ~~**Q-F18 D-E2 diverge — quem guarda a série**~~ → **DECIDIDA = D-F21**. Texto original: a série do 55/65 é fato de quem NUMERA (ERP); a do DPS, de quem DECLARA (API). (a) **API guarda série/contador só do SE; 55/65 numeram no ERP e série + número viajam no payload** · (b) API guarda as séries de todos e o ERP a lê antes de cunhar. *(Rec.: (a) — em (b) o ERP não numera com a API fora = maquete; `tb_establishment_issuer.serie` do 55 fica no ERP, a linha SE migra.)*
- ~~**Q-F19 D-N7 relaxa**~~ → **DECIDIDA = D-F11** (C local só com voz C lida do banco fiscal). Texto original:: "voz C → C local na MESMA transação" é impossível entre serviços. Confirmar o invariante como **"C local SÓ da voz; efeito na transação do ERP, idempotente; recusa ou falha = pendência visível e reaplicável; ack à API"**. *(Rec.: confirmar — já é o que vale para o C vindo da consulta.)*
- ~~**Q-F20 Palavras**~~ → **DECIDIDA = D-F14** (sem `tb_licensee`: licenciado = institution; credencial de app vai para a S1). Texto original: licenciado = `tb_licensee` × `tb_client`; credencial por aplicativo (D-F2) = `tb_licensee_app` × `tb_app` × `tb_app_credential`. *(Rec. do guardião: `tb_licensee` — "licença" já é o sentido de `tb_institution.active`; `client` colide com cliente/tenant/customer; `consumer` com consumidor final. Para o app: `tb_licensee_app` — diz de quem é e o que é; "app" está livre na tabela de ocupadas. Palavra é decisão do Valdo — lição "contrato".)*

**Acrescentadas pela Rodada 1 (2ª mensagem do Valdo, §1.5):**

- ~~**Q-F21 Onde vive o PEDIDO dos aplicativos de venda?**~~ → **DECIDIDA = D-F6** (no setes-api; S1 em prompt próprio). Texto original: "Apps de venda que criam orders e enviam para autorização": (a) **o pedido nasce no AMBIENTE DO CLIENTE (setes-api: `tb_order` + faturamento com os impostos congelados) e o setes-api orquestra "faturar e autorizar" numa chamada; a fiscal-api só recebe o documento pronto** · (b) a fiscal-api aceita PEDIDOS (itens, preços) e produz a nota — o que exige cálculo de imposto, catálogo de produtos/regras e cadastro de clientes dentro dela. *(Rec.: (a) — (b) recria o ERP dentro da API fiscal e contradiz o parecer §3 ("a API responde pelo FORMATO; o ERP pelo CONTEÚDO"); o que (a) exige é a frente irmã S1 (setes-api como plataforma para apps, com "faturar e autorizar" síncrono para PDV). Se a intenção for atender quem NÃO usa o ERP, isso é um produto diferente — "motor de nota" — e merece prompt próprio.)*
- ~~**Q-F22 Acesso DIRETO de app móvel/web do usuário final à fiscal-api**~~ → **ABSORVIDA pela D-F13** (mesmo JWT curto do produto). Texto original:: (a) **não guarda secret no dispositivo: o backend do cliente (setes-api) é o `tb_licensee_app` e repassa um token curto já trocado (token exchange) ou faz a chamada** · (b) o app móvel carrega a credencial do licenciado (secret extraível do APK/IPA) · (c) só via backend, nunca direto. *(Rec.: (a) — direto quando precisar (PDV offline-first consultando estado), seguro porque o token expira; (b) é vazamento por construção.)*
- ~~**Q-F23 Perfil de carga dos 1000 clientes**~~ → **DECIDIDA = D-F23**. Texto original: (as premissas do §5.9 são chute): quantos são serviço × mercadoria × PDV, documentos/dia típicos e pico (Black Friday, fechamento de mês), quantos estabelecimentos por cliente (A1 por CNPJ). *(Rec.: responder com a base do legado — o Gestao2016 tem a estatística real dos clientes atuais da Setes; sem isso, a F3 dimensiona pelo §5.9 e o teste de carga fixa o número.)*
- ~~**Q-F24 setes-api em escala de 1000 clientes (frente irmã S2)**~~ → **DECIDIDA = D-F24**. Texto original: hoje o boot roda migrations em TODOS os schemas (`runMigrationsForAllInstitutions`), o pool é único (`connectionLimit: 20`), o rate limit é em memória por processo. (a) **diagnóstico com 1000 schemas sintéticos ANTES de decidir** (medir boot, deploy, pool) · (b) decidir já: migrations sob demanda/por versão gravada, pool dimensionado, rate limit compartilhado. *(Rec.: (a) — fato antes de intenção; a fiscal-api não depende disso, mas a visão "1000 clientes criando pedidos" depende.)*
- ~~**Q-F25 Infra de produção para a escala**~~ → **DECIDIDA = D-F16** (A1 cifrado no banco desde a F1; XML trocável, backend na F3). Texto original: storage de objeto S3-compatível para XML (200 GB/ano) e cofre criptografado em repouso (KMS ou chave-mestra) — a SaveInCloud oferece? (a) **descobrir na F3 e adaptar atrás das interfaces que já existem (`storageRoot()`, `secret-store`)** · (b) exigir desde a F1 (atrasa a extração). *(Rec.: (a) — as interfaces já isolam o backend; o worker de refresh entra na F3 em qualquer caso.)*
- ~~**Q-F26 "Seguindo as estruturas do setes-app"**~~ → **ABSORVIDA pela D-F17** (três pastas; código no molde do setes-api). Texto original: a leitura adotada (§1.5) é "mesmo tratamento de projeto" com código no molde do setes-api. Se o Valdo quis dizer outra coisa (ex.: monorepo com `packages/` + `apps/` como o setes-app, ou um app Flutter de administração da fiscal-api), corrigir aqui. *(Rec.: manter a leitura; um app de administração dos licenciados/emitentes, se vier, é tela do setes-app (Super) consumindo a fiscal-api — não um app novo.)*

**Acrescentadas pela 3ª mensagem do Valdo (§11 — "setes-api não vira cliente; o setes-app vira cliente da fiscal-api como qualquer front-end"):**

- ~~**Q-F27 Papel do setes-api perante a fiscal-api**~~ → **DECIDIDA = D-F4** (setes-api PASSIVO). Texto original: (a) **PASSIVO — NUNCA chama a fiscal-api: expõe os FATOS do documento, emite o token federado para o app, VERIFICA recibos assinados que o front-end traz (vínculo + efeito), recebe webhook de entrada com o mesmo recibo** (§11.2) · (b) não orquestra, mas pode CONSULTAR (GET) a fiscal-api para listas e plano de cancelamento — cliente só de leitura · (c) manter a D-F2 como estava (setes-api orquestra, app inalterado). *(Rec.: (a) — é o que o Valdo pediu e fecha SEM hearsay (o ERP nunca acredita no app, só na assinatura da fiscal-api); (b) é meia-medida que cria exatamente a dependência de saída que ele quer evitar. Consequência registrável: a regra canônica "setes-app só fala com setes-api" (D1 da revisão do sync; `ARQUITETURA_MODULOS.md` do app) vira "o app fala com os datasources DEDICADOS das APIs do produto; nunca cruza datasources" — decisão explícita, com atualização de memória e CLAUDE.md.)*
- ~~**Q-F28 Emissão iniciada pelo SERVIDOR fica fora por construção**~~ → **DECIDIDA = D-F5** (aceitar; conhecimento negativo). Texto original (§11.2-4): sem chamada de saída, a rotina mensal não transmite sozinha e `fiscal_auto_transmit` (D-N9) só existe como "o app transmite logo após faturar". Hoje transmitir já é ato explícito do usuário — nada se perde HOJE; perde-se a opção futura. (a) **aceitar e registrar como conhecimento negativo** · (b) reservar exceção: um ÚNICO processo servidor-para-servidor do setes-api como `tb_licensee_app` só para rotinas sem humano. *(Rec.: (a); se um dia for preciso, (b) nasce como decisão nova — nada no modelo impede.)*


**Rodada 3 — acrescentadas pelo parecer do guardião sobre o modelo da F0 (§13, 2026-10-03):**

- ~~**Q-F35 Onde mora o nDPS (número do DPS da vida)**~~ → **DECIDIDA = D-F30** ((b) `tb_invoice_service_dps` no `fiscal_api`) — foi REABERTA pela D-F27 (as APIs fiscais podem escrever no ERP; nova opção (d) = manter no ramo do ERP como hoje). Texto original: (a) na tentativa, com regra de cópia (candidato §12.3) · (b) **`tb_invoice_service_dps` por VIDA (série + nDPS + `dps_id` write-once; UNIQUE `(inst, dps_id)` volta); a chave do fisco continua na tentativa** · (c) (b) + chave/número/`dhProc` também no DPS (a D-N26 e a órfã R3-1 morrem por construção, mas reabre código de três rodadas adversariais). *(Rec.: (b); (c) registrada para rodada futura.)*
- ~~**Q-F36 Tentativas sem vida na migração**~~ → **SEM OBJETO** (fato, §13.3): 19/19 tentativas da Setes têm vida; a coluna da vida nasce NOT NULL e o script de migração falha alto se achar NULL.
- ~~**Q-F37 Vínculo do efeito no ERP**~~ → **DECIDIDA = D-F28** (operação em linha; nada gravado — pendência derivada). Texto original: (a) tabela `tb_invoice_fiscal_effect` · (b) colunas de causa no `tb_invoice_event` · (c) **nada novo — pendência DERIVADA (voz C na vida vigente × nota ainda não-C) e motivo recalculado pelo plano na hora**. *(Rec.: (c); (a) se quiser trilha explícita; (b) não serve à conjugada.)*
- ~~**Q-F38 Aplicar o C local quando a voz C chega sem humano**~~ → **DECIDIDA = D-F28** (sem job; pendência visível até o próximo contato do app). Texto original: (cancelada no portal; A tardia): (a) job interno no setes-api (singleton por `GET_LOCK`, autor = usuário de SISTEMA a definir) · (b) só quando um humano abre a nota/lista · (c) GET com efeito colateral · (d) saga do app. *(Rec.: (d) + (a) — a saga cobre o caso com humano; o job é a rede de segurança; (c) nunca.)*
- ~~**Q-F39 Pré-condições do cancelamento que saem de casa**~~ → **DECIDIDA = D-F29** ((a)). Texto original: (plano local ANTES do fisco; reconfirmação Q-ADV1b): (a) **o app consulta o plano no setes-api antes de pedir o cancelamento à nfse-api (consultivo — mudou no meio = pendência, como a D-F11 aceita); e o setes-api EXIGE, para F por consulta em produção, `last_queried_at` posterior ao F na view (prova legível da reconfirmação)** · (b) a nfse-api reimplementa o plano. *(Rec.: (a); (b) bifurca a política.)*
- ~~**Q-F40 Políticas do ERP que a nfse-api precisa**~~ → **DECIDIDA = D-F32** ((b) views no schema do cliente). Texto original: (interface do ramo — `resolveOrderInterface`; vida; admin passa; fuso; matriz do Anexo I): (a) copiar para a nfse-api com teste de contrato · (b) **o setes-api publica as políticas como VIEWs no schema do cliente (simétrico à D-F15) e passa ele mesmo a ler delas**. *(Rec.: (b) para interface do ramo e vida; (a) para o resto.)*
- ~~**Q-F41 Onde vive a regra da vigente/vida**~~ → **DECIDIDA = D-F33** ((c) biblioteca). Texto original:: (a) cada serviço implementa a sua · (b) a view entrega a vigente por (nota, vida) com `ROW_NUMBER` · (c) **a biblioteca `fiscal-api` exporta o contrato de leitura (tipos das views, `currentOf`, `fiscalStateOf`, kinds) para a nfse-api E para o setes-api; a view fica no molde do `TX_SELECT`, fundível**. *(Rec.: (c); (b) só depois de EXPLAIN — frente S2.)*
- ~~**Q-F42 Nomes no `fiscal_api`**~~ → **DECIDIDA = D-F34** ((b)). Texto original: (a) `tb_emitter` / `tb_issuer` · (b) **`tb_establishment_certificate` + manter `tb_establishment_issuer`**. *(Rec.: (b).)*
- ~~**Q-F43 Quem cria o DDL das tabelas de família**~~ → **DECIDIDA = D-F35** ((b)). Texto original: (a) o núcleo cria todas · (b) **o núcleo cria certificado, habilitação e o executor de migrations (trava + namespace por projeto); cada família cria as suas**. *(Rec.: (b) — a nfe-api AGREGA sem tocar o núcleo, D-F20.)*
- ~~**Q-F44 O que as APIs fiscais escrevem no ERP**~~ (nova, aberta pela D-F27) → **DECIDIDA = D-F31** ((a) lista fechada + cerca por teste; hoje: nada além do `FOR UPDATE` da nota). Opções eram: (a) lista fechada com cerca por teste · (b) livre.

### 8.R4 Rodada 4 — abertas pelos gates da F1 (2026-10-04; contexto no §15.4) — DECIDIDA 2026-10-04 ("siga as recomendações" → D-F36…D-F40)

- ~~**Q-F45 Quando fazer o smoke no ADN de HOMOLOGAÇÃO pela nfse-api**~~ → **DECIDIDA = D-F36** (a recomendação). (critério §12.8-4; fala com o fisco — exige "vai"): (a) **ANTES da virada, numa habilitação SE própria de homologação com SÉRIE PRÓPRIA (ex.: 900), tirando a institution da cerca só durante o smoke** — prova mTLS/DPS/voz pela nova casa sem tocar a numeração de produção do setes-api · (b) DEPOIS da virada (F2a), já com a nfse-api dona da emissão · (c) não fazer em H (o caminho já foi provado em produção pelo setes-api; a nfse-api herdou o código). *(Rec.: (a) — o A1 vence em **08/10/2026**; renovado o A1, o smoke prova também o upload pelo `/v1/emitter`. ⚠️ (a) exige trocar o ambiente da habilitação da institution 1 de P para H no `fiscal_api` — que hoje é cópia da produção do setes-api — e devolvê-lo com o `migrate:setes` depois.)*
- ~~**Q-F46 "Admin passa" vale também para a LICENÇA?**~~ → **DECIDIDA = D-F37** (a recomendação). Hoje (igual ao setes-api, D32 da Onda 3) o ADMIN transmite/cancela nota de ramo NÃO contratado (a licença só é conferida para o usuário comum — gates da F1). (a) **manter** (admin passa privilégio E licença — a licença é contrato comercial, o admin do cliente não a contorna de propósito) · (b) licença vale para TODOS (admin passa só o privilégio) — e o setes-api passa a fazer o mesmo na F2a. *(Rec.: (b) — licença é o que se vendeu; hoje a institution 1 do dev emite OS sem `service-orders` contratada, o que mostra que o dado precisa ser acertado ANTES de ligar a regra. Teste `it.failing` "[Q-F46]" fixa o comportamento atual.)*
- ~~**Q-F47 Teto de idade para revisitar AUTORIZADAS no rodízio**~~ → **DECIDIDA = D-F38** (a recomendação). (hoje: a cada 24 h, para sempre — D-N21; a candidata autorizada nunca sai da lista enquanto a nota não for C): (a) **teto = prazo de cancelamento do município (PAM) + margem (ex.: 60 + 30 dias)** — depois disso o fisco não aceita mais cancelamento pelo emitente e a voz não muda · (b) teto fixo (ex.: 120 dias) · (c) manter sem teto. *(Rec.: (a); sem teto o rodízio cresce com o histórico — ver Q-F49.)*
- ~~**Q-F48 Onde mora a CERCA DA VIRADA (D-F18)**~~ → **DECIDIDA = D-F39** (a recomendação). — hoje variável de ambiente `FISCAL_LEGACY_INSTITUTIONS` por instância (estrita desde o retrabalho 2: item mal escrito impede o boot; ausente = nenhuma): (a) **fato no `fiscal_api`** — custódia da emissão na linha da habilitação (`'setes-api' | 'nfse-api'`), trocada pelo próprio `migrate:setes` na re-sincronia FINAL, na mesma transação, e lida por TODAS as instâncias (a virada vira um ato atômico; nenhuma instância diverge) · (b) continua na variável, mas FAIL-CLOSED: ausente = erro de boot; valor explícito para "nenhuma" (ex.: `none`) · (c) como está (ausente = nenhuma), aceito como risco só do dev até a F2a. *(Rec.: (a) — o socrático R2 mostrou que, com a cerca aberta por engano, dois contadores de nDPS cunham o MESMO Id de DPS para notas diferentes e a conferência R2-2 passa justamente porque os Ids são iguais; (b) é o mínimo se ficar na configuração. (a) é DDL no núcleo — passa pelo guardião + revisar-ddl.)*
- ~~**Q-F49 O custo das leituras que crescem com o histórico entra como critério de aceite?**~~ → **DECIDIDA = D-F40** (a recomendação). (página de pendentes = COUNT + página sobre todas as notas do cliente via 3 views com NOT EXISTS por linha; candidatas do rodízio = MAX correlacionado sobre todas as tentativas da institution com OR que não usa o índice de `last_queried_at`): (a) **sim — teto de tempo por chamada (ex.: p95 < 300 ms com 200 mil notas) no teste de carga da F3 / diagnóstico da S2 (D-F23/D-F24), com `EXPLAIN` na cerca** · (b) fica para quando doer. *(Rec.: (a); medido hoje no dev: 1ª página dos pendentes 119–206 ms com 386 notas — não diz nada sobre 200 mil.)*


### 8.R5 Rodada 5 — aberta pela execução da Rodada 4 (guardião + gates, §16) — FECHADA: Q-F50 = D-F44 · Q-F51 = D-F54 (2026-10-10; ADIADA em 2026-10-04) · Q-F52 = D-F46 ((b), 2026-10-04; a (a) de 2026-10-10 — D-F55 — REVOGADA na reconciliação) · Q-F53 = D-F53

- ~~**Q-F50 Como fechar o LADO DO ERP na virada?**~~ → **DECIDIDA = D-F44** ("manter" a (a) refinada — §17). (refinada pelos gates da Rodada 4 — §16.4). O ato `migrate:setes
  --cutover` grava `cutover_at` no `fiscal_api`, mas o contador do setes-api NUNCA lê esse fato: uma instância esquecida ou
  um ROLLBACK do deploy do setes-api depois da virada cunharia o MESMO nDPS na mesma série (cenário R2-2); e, até a F2a, o
  setes-api pode criar habilitação SE no ERP para institution que NASCEU na API (lacuna inversa). (a) **o ato da virada
  APOSENTA a habilitação SE do ERP (`deleted='S'`) na mesma transação** — escrita UMA vez pelo SCRIPT (nunca pelo serviço),
  item novo na lista fechada da D-F31; a reserva do setes-api que esperava a trava acorda e recebe 409
  `FISCAL_ISSUER_MISSING` sem mudar código do setes-api · (b) até perder as rotas fiscais, o setes-api LÊ o fato numa view do
  `fiscal_api` antes de cunhar (leitura passiva no molde da D-F11) — muda código do setes-api · (c) só a ordem de deploy: a F2a
  remove as rotas fiscais E a habilitação SE da tela "Emissor fiscal"; rollback do setes-api depois da virada proibido por
  procedimento; a re-sincronia periódica fica como detecção. *(Rec.: (a) — fecha por construção com uma escrita única e
  auditável; (b) é a alternativa se a D-F31 não admitir o item; a linha 55/65 do ERP — série do faturamento, D-F21 — não é
  tocada em nenhuma.)*
  **Refinamento do guardião (2026-10-04, parecer da D-F42 — §17):** a linha SE do ERP carrega DOIS conceitos — a SÉRIE DA
  NOTA interna (`tb_invoice.serie`, lida pelo faturamento e pela OS) e a habilitação para falar com o fisco. (a) com
  `deleted='S'` aposenta também a série da nota SE: faturamento e OS passam a usar o default '1'. Hoje NÃO muda nada (a série
  SE da Setes é '1'; as 903 notas SE do dev são série '1'). *(Rec. refinada: manter (a), com a condição virando CONFERÊNCIA do
  próprio ato — série SE do ERP ≠ '1' → falha alta; e registrar para a F2a que a tabela do ERP passa a significar só a série
  da nota — ambiente da SE e `dps_last_number` ficam sem consumidor e são aposentados SEM DROP.)*
- ~~**Q-F51**~~ → **DECIDIDA = D-F54** (2026-10-10, (a); o A1 foi renovado — §19.1). ⏸ **Q-F51 — ADIADA pelo Valdo (2026-10-04): "ignore, pois está programada a renovação" do A1** — o prazo de 08/10/2026 deixa
  de pressionar o smoke; a origem da nota de teste volta à mesa depois da renovação. Texto original: **De onde vem a NOTA DE
  TESTE do smoke da D-F36?** Hoje há ZERO notas elegíveis (300 conferidas: 294 sem código
  nacional — anteriores à D-N11a —, 6 com `cTribMun` "0102" — anteriores à D-N26b) e o A1 vence em 08/10/2026. (a) **faturar
  uma OS de TESTE no dev pelo setes-api** (regra de ISS atual — código nacional + código municipal vazio ou de 3 dígitos):
  consome a numeração e gera financeiro no ERP que guarda a produção da Setes — escolher cliente/serviço/valor e cancelar a
  nota localmente depois · (b) corrigir o código nacional de um serviço antigo e usar uma nota existente (escrita em cadastro
  fiscal de produção) · (c) fazer o smoke DEPOIS de renovar o A1 (a renovação entra pelo setes-api + `migrate:setes`, porque
  o `fiscal_api` é réplica) · (d) não fazer o smoke em H (Q-F45 (c)). *(Rec.: (a) com um cliente interno da própria Setes e
  valor simbólico — é o único caminho que prova o DPS montado pela regra atual; (c) se o prazo do A1 apertar.)*
- ~~**Q-F52 Licença (D-F37) × obrigação fiscal JÁ assumida**~~ → **DECIDIDA = D-F46** ((b) bloqueio total — Valdo,
  2026-10-04; a recomendação era (a); **reconfirmada na reconciliação de 2026-10-10** — a (a) dada na sessão desta máquina,
  D-F55, foi REVOGADA, §20.3). Texto original: quando o ramo deixa de ser contratado, o que acontece com o que
  já foi emitido? Hoje, nada passa: NFS-e em voo ou em K deixa de ser reconciliada pela consulta/rodízio, o cancelamento
  dentro do prazo do município e o XML/DANFSe que o cliente tem de guardar ficam bloqueados — inclusive para o admin; e a
  passada de quem tem UM ramo contratado consulta notas de ramo NÃO contratado. (a) **a licença barra só a transmissão NOVA;
  consulta, cancelamento no fisco e leitura do já emitido continuam** (a obrigação nasceu quando o ramo era contratado) · (b)
  como está — bloqueio total · (c) leitura sobrevive, ações não. *(Rec.: (a) — o contrato comercial não pode impedir o
  cumprimento de obrigação fiscal já assumida; a passada filtra as candidatas pelos ramos contratados OU com NFS-e viva.)*
- ~~**Q-F53 Os ataques ao vivo voltam a rodar com o usuário de SELECT MÍNIMO da D-F31?**~~ → **DECIDIDA = D-F53** ((a); a D-F48 desta máquina é a MESMA decisão — §20.2). O harness das cópias descartáveis
  usa o usuário do setes-api (ALL PRIVILEGES ON *.* — escreve no ERP que guarda a produção da Setes); hoje a defesa é
  DETECÇÃO (o `drop()` confere o CHECKSUM do `fiscal_api` real, da `_migrations` e de 8 tabelas do ERP). (a) **GRANT ALL em
  `fiscal\_api\_adv\_%`.* para o usuário `fiscal_api`** (só as cópias; o do setes-api só cria/apaga a cópia) — a defesa
  volta a ser por construção · (b) manter a detecção · (c) como estava. *(Rec.: (a) — é mudança de permissão no servidor de
  produção da Setes: só com o "vai" do Valdo; um `it.failing` "[Q-F53]" fixa o estado atual.)*

### 8.R6 Rodada 6 — aberta pelo gate socrático do delta das 4 falhas (2026-10-04, §17) — DECIDIDA 2026-10-04 ("siga as recomendações" → D-F41…D-F43; Q-F56 "sim" → D-F45)

- ~~**Q-F54 Espera no comando do ALUGUEL**~~ → **DECIDIDA = D-F41**. O UPDATE do aluguel esperava até 50 s (lock wait padrão)
  pela linha da habilitação; renovar estourando + devolver no `finally` = ~100 s presos na requisição de quem abriu a tela.
  (a) manter 50 s (nenhum detentor longo por desenho) · (b) **espera curta só no comando do aluguel → 409 `RESOURCE_BUSY`**
  (D-A23). *(Rec.: (b).)*
- ~~**Q-F55 O `migrate:setes` copia e vira TODOS os modelos da habilitação do ERP**~~ → **DECIDIDA = D-F42**. Hoje copia
  qualquer linha da institution (serie/contador só para SE) e o `--cutover` vira todas — uma linha 55 do ERP viraria
  "habilitação 55 virada" sem API que a emita e a série do 55 ficaria em dois lugares (no dev o ERP só tem SE: latente).
  (a) **copiar e virar só a SE** · (b) como está. *(Rec.: (a), com parecer do guardião — toca o "ato por institution" da D-F39.)*
- ~~**(a)/(b) da conferência "o que foi movido saiu do setes-api?"**~~ → **DECIDIDA = D-F43** (portar a correção do DPS).
- ~~**Q-F56 (nasceu do parecer do guardião sobre a D-F42)**~~ → **DECIDIDA = D-F45** ("sim"). **Domínio do `model` da habilitação como FATO DO BANCO?**
  A regra "travar todas as linhas da chave = PK por linha com a lista fechada" (PADROES §9 regra 8) só é verdadeira se o
  domínio for fechado no banco; hoje é VARCHAR(2) sem CHECK e o fechamento é só em código (`ISSUER_MODELS` — o retrabalho do
  delta fez a trava e a contagem enxergarem o mesmo domínio). (a) **`CHECK (model IN ('SE','55','65'))` na migration 004 do
  núcleo (dono da tabela — D-F35; 1º CHECK da casa) + o boot do núcleo confere que o motor APLICA CHECK** (MariaDB ≥ 10.2
  aplica; MySQL < 8.0.16 aceita e ignora em silêncio — o motor da SaveInCloud ainda não foi conferido, risco 3 do §13) · (b)
  só em código, como está. Modelo novo (57…) = migration do núcleo que estende o domínio. NÃO entra: CHECK "réplica ⇒ SE"
  (é história da migração, não fato do núcleo) nem tabela-catálogo de modelos (lê-la antes do FOR UPDATE recriaria o
  snapshot antes da trava). *(Rec.: (a), passando pelo `revisar-ddl`.)*

### 8.R7 Rodada 7 — aberta pelos gates do delta da Rodada 6 + D-F46 (2026-10-04, 3ª sessão — §18) — Q-F57…Q-F61 DECIDIDAS (D-F47/D-F48/D-F50/D-F51/D-F52)

- ~~**Q-F57 Nota VIVA de ramo descontratado trava o emitente inteiro (consequência da D-F46).**~~ → **DECIDIDA = D-F47** ((b)). Uma tentativa em voo / S / K de
  um ramo que saiu do contrato nunca mais reconcilia (a passada a filtra; a rota por nota dá 403 a todos), mas
  `countLiveTransmissions` conta TODOS os ramos — e a guarda do emitente (`emitter.service.ts`) passa a recusar PARA SEMPRE
  trocar o ambiente, excluir a habilitação e excluir o A1, também para o ramo que continua contratado. Mesmo resolvida no
  portal do ADN, o `fiscal_api` nunca fica sabendo. (a) `countLiveTransmissions` conta só os ramos contratados (o emitente fica
  livre; a nota órfã fica "viva" para sempre no `fiscal_api`) · (b) refinar a D-F46: a passada continua reconciliando nota JÁ
  VIVA de ramo cortado (não é serviço novo, é fechar o que estava em curso; consultar, cancelar e ler continuam 403) · (c) ato
  do admin "encerrar sem reconciliar" com motivo (voz nova, auditável) · (d) manter: o cliente recontrata o ramo para
  destravar. *(Rec.: (b) — é o mínimo que não deixa estado eterno no banco e não reabre nada da D-F46 para o usuário; (a)
  esconde o problema; (d) depende do comercial para destravar o fiscal.)*
- ~~**Q-F58 A re-sincronia trava as habilitações VIRADAS de todas as institutions até o fim.**~~ → **DECIDIDA = D-F48** ((a)). `resyncAll` usa UMA transação
  para todas (D-F18 "tudo ou nada"); com a trava por linha do §17.2, as linhas viradas ficam FOR UPDATE até o commit final —
  durante uma re-sincronia longa, transmitir/cancelar nelas esperam até 50 s e voltam 409, a passada volta 409 em 3 s.
  (a) transação POR institution (o tudo-ou-nada global não protege nenhum invariante ENTRE institutions) · (b) pular as viradas
  na passada geral e conferi-las (`assertFrozen`) numa transação curta própria · (c) manter e rodar só em janela de
  manutenção. *(Rec.: (a) — com 1 institution hoje é igual; com várias, é a única que não para quem já virou.)*
- ~~**Q-F59 O ato da virada confere POR CONSTRUÇÃO que a F2a está no ar?**~~ → **DECIDIDA = D-F50** ((a)). Até a F2a, o `upsertIssuer` do setes-api (tela
  "Emissor fiscal", `ON DUPLICATE KEY UPDATE … deleted='N'`) REVIVE a linha SE que a D-F44 aposentou — e a tela, mostrando "sem
  habilitação SE", convida o admin a recriá-la; o contador congelado do ERP volta a cunhar nDPS já usados (R2-2). Hoje só a
  re-sincronia seguinte detecta e a defesa é a flag `--confirmo-setes-api-parado`. (a) o ato confere um FATO do setes-api
  (ex.: a migration da F2a que tira a SE da tela aplicada no schema) e recusa sem ele · (b) manter procedimental + detecção.
  *(Rec.: (a) — a virada só acontece depois da F2a de qualquer jeito; conferir custa uma leitura.)*
  **Resposta do Valdo (2026-10-04), em esclarecimento:** "considere que o schema central e o schema de cliente permanecem o
  mesmo, estamos apenas usando APIs separadas para dar escala — serviços de autorização de NFS-e e NF-e precisam ser
  turbinados quando forem muito requisitados, e não uma API monobloco."
  Esclarecido na mesma sessão: o banco fiscal FICA (D-F49); a Q-F59 volta à pergunta original ((a) × (b)).
- ~~**Q-F60 (gate do delta D-F47/D-F48, §18.2) A passada grava F "sem resposta" por CONSULTA?**~~ → **DECIDIDA = D-F51** ((a)). A D-F47 não destrava o emitente
  num subcaso: tentativa EM VOO cujo DPS o fisco não conhece (envio que nunca chegou). A consulta só marca `last_queried_at`; o
  único escritor do F "sem resposta" é `reconcileInterrupted`, que roda só no TRANSMITIR — 403 para ramo cortado. A órfã fica
  viva para sempre, trava o emitente e volta ao topo do rodízio a cada 5 min com uma chamada ao ADN. (a) a passada grava o F
  por consulta depois de `IN_FLIGHT_MINUTES` com o fisco sem o DPS, como o transmitir já faz — para TODO ramo · (b) só para
  ramo cortado · (c) não; a D-F47 registra o subcaso como risco aceito. Mexe na regra herdada "F só conclusivo" (D-N) — o
  mesmo critério que o transmitir já usa. *(Rec.: (a) — um veredito conclusivo só, nos dois caminhos; (b) cria regra
  diferente por licença para o mesmo fato do fisco.)*
- ~~**Q-F61 (gate r10, §18.3) A tentativa fechada com F POR CONSULTA volta ao rodízio uma vez para pegar NFS-e gerada tarde?**~~ → **DECIDIDA = D-F52** ((a)).
  Depois da D-F51 o 1º E2404 com ≥ 10 min fecha a tentativa e a passada não a olha mais; se o ADN gerar a NFS-e com atraso de
  propagação, só a reconfirmação da D-F29, uma consulta manual ou uma retransmissão (o MESMO Id — D-N3) a acham. Risco: o cliente
  vê "falhou" e fatura OUTRA nota para o mesmo serviço. (a) F de source Q sem chave volta ao rodízio UMA vez depois de 24 h
  (dentro do teto da D-F38) · (b) risco aceito. *(Rec.: (a) — uma consulta a mais por nota interrompida, e fecha a única
  janela em que a voz F pode mentir.)*
---

### 8.R8 Rodada 8 — aberta pelo gate socrático do delta da sessão de 2026-10-10 desta máquina (§19.2) — DECIDIDA 2026-10-10 ("siga as recomendações" → D-F56/D-F57)

> Nesta máquina estas questões eram Q-F57/Q-F58 (Rodada 7) — renumeradas na reconciliação (§20.2), porque a 3ª sessão de
> 2026-10-04 já tinha usado Q-F57…Q-F61 para outras perguntas (§8.R7 acima).

- ~~**Q-F63**~~ → **D-F56**. Fechar o REVIVE da habilitação SE aposentada pelo ato (guarda portada ao setes-api × procedimento ×
  remoção das rotas antes do ato). *(Rec.: (a) guarda no setes-api — texto no §19.2.)* Mesmo problema da Q-F59 da 3ª sessão
  (→ D-F50, outra solução); na reconciliação o Valdo ficou com AS DUAS.
- ~~**Q-F64**~~ → **D-F57**. A lacuna (b) da cerca olha a LINHA SE (= Q-NE10 da Rodada 0 da nfe-api). *(Rec.: (a) — texto no §19.2.)*

### 8.R9 Rodada 9 — aberta pelo gate adversarial do delta (r8 desta máquina = r11 na sequência unificada) e pelo smoke em H (2026-10-10, §19.4) — Q-F65/Q-F66/Q-F67 DECIDIDAS (D-F58/D-F51/D-F59) · ⚠️ Q-F62 (§19.6) AGUARDA O VALDO

> Nesta máquina eram Q-F59/Q-F60/Q-F61 (Rodada 8); a Q-F62 manteve o número.

- ~~**Q-F65**~~ → **D-F58**. A SE do ERP imutável no dual-run qualquer que seja o contador (ADV-R8-01 MEDIUM). *(Rec.: (a).)*
- ~~**Q-F66**~~ → **= D-F51** (mesma resposta da Q-F60 da 3ª sessão). A consulta fecha com F a tentativa em voo sem NFS-e quando o
  ramo saiu do contrato (ADV-R8-02). *(Rec.: (a).)* Com a (b) da Q-F52 a rota por nota de ramo cortado é 403 — quem fecha é a
  PASSADA (D-F47 + D-F51; provado ao vivo no r11 §A).
- ~~**Q-F67**~~ → **D-F59** (executada; o CNC de H ainda recusa a IM — **Q-F62**, §19.6). A autorização em H exige a IM (E0116) e
  P a recusa (E0120): IM como fato do emitente, enviada só em H. *(Rec.: (a).)*
- ~~**Q-F62 — Qual é a IM que o CNC de HOMOLOGAÇÃO tem para a Setes em Curitiba?**~~ → **DECIDIDA = D-F60** ((a) — Valdo
  2026-10-10 leu o "Indicador Municipal" no Emissor Nacional de produção restrita: `50136779`; provada no smoke em H, §21).

### 8.R10 Rodada 10 — aberta pelo smoke em H da Q-F62 (2026-10-10, §21) — Q-F68 DECIDIDA (D-F61)

- ~~**Q-F68 — Corrigir a leitura dos eventos de cancelamento nos adaptadores ADN?**~~ → **DECIDIDA = D-F61** ((a), executada — §21.4). Os DOIS adaptadores (setes-api — PRODUÇÃO
  hoje — e nfse-api) leem o cancelamento por `GET /nfse/{chave}/eventos`, que a Sefin Nacional NÃO atende (405, `Allow: POST`
  — cravado ao vivo em H, §21.2): toda consulta de NFS-e AUTORIZADA falha (rodízio de 24 h da D-N21, "consultar" da tela "No
  fisco", reconsulta da nfse-api) e o cancelamento feito FORA do produto nunca é visto. (a) **corrigir nos dois adaptadores
  AGORA (porte D-F43 ao setes-api): para cada código de cancelamento (101101, 105102, 105104, 305101) `GET
  /nfse/{chave}/eventos/{tipo}/1` (para no 1º 200); 200 = `eventos[]` com `arquivoXml` em base64 do texto gzip+base64 → o
  mesmo `parseEventXml` + `isGeneratedEventFor`; 404 SÓ com o envelope JSON da Sefin (`versaoAplicativo`, sem `eventos`) =
  "sem esse evento"; 404 HTML ou qualquer outra forma = ambíguo (erro, nunca voz — molde do E2404); o 405 de rota deixa de sair
  como "DPS rejeitado"** — com testes das respostas cravadas, gate do delta e reinício do setes-api · (b) só na nfse-api (o
  setes-api perde as rotas fiscais na F2a) · (c) só registrar. *(Rec.: (a) — o setes-api é a produção até a F2a (corte 30/11)
  e o rodízio dele é a única rede que pega cancelamento feito no portal; a forma correta é dada pelo fisco, não por
  preferência. Custo: até 4 GETs a mais por autorizada consultada, só enquanto não houver cancelamento.)*

### 8.R11 Rodada 11 — aberta pelos gates do delta da D-F61 (2026-10-10, §21.5) — DECIDIDA ("siga as recomendações" → D-F62…D-F66)

- ~~**Q-F69** custo/fonte dos eventos no rodízio~~ → **D-F62** ((a) 4 GETs tipados + aluguel 210 s; (b) era sondar a lista do host ADN).
- ~~**Q-F70** 200 tipado que não fala desta chave~~ → **D-F63** (ambíguo).
- ~~**Q-F71** C de substituição (e105102) por consulta~~ → **D-F64** (voz sim, efeito automático não).
- ~~**Q-F72** 401/403 numa rota de evento~~ → **D-F65** (falha da nota).
- ~~**Q-F73** TSString~~ → **D-F66** ((a) NFC + letra-base; Latin-1 em todo texto livre).

### 8.R12 Rodada 12 — aberta pelo re-gate da Rodada 11 (2026-10-10, §21.6) — DECIDIDA ("siga as recomendações" → D-F67…D-F69)

Texto completo e recomendações no §21.6: **Q-F74** fim da pendência da substituição (Rec.: ato humano "ciência — manter a nota" +
chave da substituta na tela) · **Q-F75** contrato da F2a para a substituição (Rec.: `event_code` estruturado na voz do `fiscal_api`) ·
**Q-F76** rota × código do XML divergentes (Rec.: ambíguo, salvo quando o XML diz substituição).

### 8.R13 Rodada 13 — aberta pelo parecer do guardião sobre o "manter a nota" (2026-10-10, §21.7) — DECIDIDA ("Sim, siga tudo" → D-F70…D-F76)

- ~~**Q-F77** onde mora o DDL da voz~~ → **D-F70** (família) · ~~**Q-F78** coluna nova × reuso~~ → **D-F71** (`authority_code`) ·
  ~~**Q-F79** privilégio~~ → **D-F72** (CANCELAR do ramo) · ~~**Q-F80** motivo~~ → **D-F73** (obrigatório) · ~~**Q-F81** quais
  cancelamentos se dispensam~~ → **D-F74** (só 105102) · ~~**Q-F82** o código muda?~~ → **D-F75** (só sobe para 105102) ·
  ~~**Q-F83** chave da substituta~~ → **D-F76** (do XML, sem coluna).

### 8.R14 Rodada 14 — aberta pelo gate socrático da Rodada 13 (2026-10-10, §21.7) — DECIDIDA ("siga as recomendações" → D-F77…D-F82)

- ~~**Q-F84** proveniência da voz × promoção/dispensa~~ → **D-F77** · ~~**Q-F85** recuperar o XML do e105102~~ → **D-F78** ·
  ~~**Q-F86** quem serve a decisão depois da F2a~~ → **D-F79** · ~~**Q-F87** homologação~~ → **D-F80** (+ assunção A-F80) ·
  ~~**Q-F88** a dispensa é história ou estado~~ → **D-F81** · ~~**Q-F89** efeito do 305101/105104~~ → **D-F82**.

### 8.R15 Rodada 15 — aberta pelos gates da Rodada 13 (2026-10-10, §21.8) — DECIDIDA ("siga as recomendações" → D-F83…D-F85)

Texto completo no §21.8: **A-F80** (confirmar: em H a saída é cancelar a nota — o Id do DPS é da vida) · **Q-F90** (GET tipado com o
tipo perguntado E um e105102 — Rec.: ambíguo) · **Q-F91** (`chSubstituta` × CNPJ da chave — Rec.: sim, baixo valor).

### 8.R16 Rodada 16 — aberta pelos gates da Rodada 15 (2026-10-10, §21.9) — DECIDIDA ("siga as recomendações", 2026-10-11 → D-F86…D-F90)

Texto completo e recomendações no §21.9: **Q-F92** contradição ENTRE rotas tipadas (Rec.: manter "para no primeiro" + conhecimento
negativo) · **Q-F93** saída da nota "ambígua para sempre" (Rec.: fail-closed + alarme da F3 com institution e nota) · **Q-F94** tipo
fora do domínio no mesmo GET tipado (Rec.: ambíguo) · **Q-F95** mesmo tipo com conteúdo divergente (Rec.: ambíguo) · **Q-F96** prova da
D-F29 forjada pelo carimbo do rodízio na nfse-api (Rec.: a prova exige o "não achou" explícito — antes da F2a).

### 8.R17 Rodada 17 — aberta pelos gates da Rodada 16 (2026-10-11, §21.10) — DECIDIDA ("siga as recomendações" → D-F91…D-F93)

Texto completo e recomendações no §21.10: **Q-F97** alcance do alarme (Rec.: também reconferência e consulta por nota, agregado por
nota) · **Q-F98** validade da prova (Rec.: "posterior ao F" + conhecimento negativo) · **Q-F99** assinatura da D-F89 (Rec.: somar
`nDFSe`, autor, `ambGer`, `tpAmb`).

### 8.R18 Rodada 18 — aberta pelos gates da Rodada 17 (2026-10-11, §21.11) — DECIDIDA ("siga as recomendações" → D-F94…D-F97)

Texto completo e recomendações no §21.11: **Q-F100** o que o alarme leva do erro (Rec.: só código + rótulo sem dígitos) · **Q-F101**
rótulo do ambíguo do transmitir (Rec.: origem explícita "transmissao", também no GET /dps do passo 0b) · **Q-F102** leitor da
assinatura do evento (Rec.: o mesmo `firstText` do parse + arquivar de forma determinística no empate) · **Q-F103** prova × nova
apresentação do mesmo Id (Rec.: o E2404 tem de ser posterior à ÚLTIMA apresentação do Id na vida).

### 8.R19 Rodada 19 — aberta pelos gates da Rodada 18 (2026-10-11, §21.12) — DECIDIDA ("siga as recomendações" → D-F98…D-F99)

Texto completo e recomendações no §21.12: **Q-F104** o Id do terceiro na mensagem do "NFS-e de OUTRO DPS" (Rec.: a mensagem nunca
interpola o Id + rótulo fechado por causa) · **Q-F105** tentativa da mesma identidade em voo (Rec.: a prova falha fechado com tentativa
sem voz).

### 8.R20 Rodada 20 — aberta pelos gates da Rodada 19 (2026-10-11, §21.13) — DECIDIDA ("siga as recomendações" → D-F100…D-F101)

Texto completo e recomendações no §21.13: **Q-F106** guardar evidência da "resposta trocada" (Rec.: não — conhecimento negativo) ·
**Q-F107** o que conta como "em voo" na D-F99 (Rec.: tentativa da mesma identidade VIVA, incluindo a voz S).

### 8.R21 Rodada 21 — aberta pelos gates da Rodada 20 (2026-10-11, §21.14) — DECIDIDA ("siga as recomendações" → D-F102…D-F104)

Texto completo e recomendações no §21.14: **Q-F108** a voz S não tem saída (Rec.: conhecimento negativo — quem criar produtor de S dá a
ela a saída da D-F51) · **Q-F109** `kind` sem CHECK de domínio (Rec.: conhecimento negativo até a F2a; CHECK binário na migration dela) ·
**Q-F110** (opcional) o contrato da prova para a F2a (Rec.: manter o booleano; o veredito com motivo se decide na F2a).

### 8.R22 Rodada 22 — aberta pelos gates da Rodada 21 (2026-10-11, §21.15) — DECIDIDA ("siga as recomendações" → D-F105…D-F106) e EXECUTADA (§21.16)

Texto completo e recomendações no §21.15: **Q-F111** a D-F102 vale para qual família (Rec.: só a NFS-e — a NF-e define a saída do S dela
na própria rodada; decidir antes da NE-1a) · **Q-F112** proteção do domínio do escritor da NFS-e (Rec.: tipo da família — sem S já agora,
sem P/D na NE-1a; CHECK na F2a).

### 8.R23 Rodada 23 — aberta pelos gates da Rodada 22 (2026-10-11, §21.16) — DECIDIDA ("siga as recomendações da Rodada 23" → D-F107…D-F108; execução na F2a e na NE-1a — §21.17)

Texto completo e recomendações no §21.16: **Q-F113** qual domínio o CHECK da F2a (item (7)) protege na tabela da NFS-e (Rec.: (a) a lista
da FAMÍLIA — a mesma constante do tipo; sonda do boot e teste comparam constante × DDL) · **Q-F114** onde mora a lista de escrita da
família quando o escritor for para o núcleo na NE-1a (Rec.: (a) o descritor da família no núcleo carrega a lista — `VoiceFamily<K>` —,
o escritor comum é genérico nela e a confere em execução; a cerca do núcleo vira "escritor único").

## 9. Fora de escopo desta fase

Cálculo de imposto (continua no ERP) · IBS/CBS (fase própria — Q-F14) · NFC-e/PDV (F5, onda própria) · carta de correção, contingência SVC/EPEC, manifestação do destinatário, DF-e distribuição (compra) · metering/cobrança do serviço · sentido web → legado · substituição de NFS-e, análise fiscal e101103 · webservice municipal (D1 da Onda 3 matou).

---

## 10. Critérios de sucesso (testáveis)

> ⚠️ **SUPERADOS onde conflitarem com o §12.8**; o item 12 (recibo assinado) morreu com a D-F11.

1. `fiscal-api` sobe sozinha (sem `setes_central`), com `fiscal_api` vazio + migrations próprias; `/v1/health` prova banco e cofre; OpenAPI servido em `/docs`; **nenhum import de `tb_invoice`/`tb_order`/`tb_entity`** (teste do terceiro cego — cerca por teste de lint/grep).
2. Licenciado + emitente (CNPJ da Setes) + A1 (.pfx + senha → PEM; senha em lugar nenhum) via `/v1`; par inválido/vencido/CN ≠ CNPJ → 4xx legível (D-N29b/D-N30b).
3. `POST /v1/nfse/documents` com os fatos da OS → 201 com chave 50 e número no ADN **H**; replay com o mesmo `externalCode` → mesma resposta, nenhuma 2ª tentativa (UNIQUE por construção); DPS rejeitado → 422 com E0xxx no `fields[]`; timeout simulado → 202 em voo e `refresh` reconcilia por `dps_id`.
4. setes-api: trilha `trilha-primeiro-cliente.ts` P8a/P8b OK contra a `fiscal-api`; lista de OS com selo fiscal por lote de referências (API parada → "indisponível", nunca 500); "Cancelar nota" com NFS-e autorizada → voz C no serviço + C local no ERP + ack; falha local simulada → pendência visível nos dois lados + "Reaplicar efeito" fecha; nota SEM vínculo cancela local sem chamar a API; **nenhum arquivo Dart alterado**.
5. Migração dos dados da Setes: as transmissões/vozes/XMLs existentes aparecem no serviço com `external_code` = nota:vida e o vínculo nasce no ERP; DANFSe da nº 704 renderiza igual; H depois P sem reemitir nada.
6. Escala: 2 instâncias da `fiscal-api` contra o mesmo banco, 6 pedidos concorrentes do mesmo `externalCode` → 1 documento, 1 tentativa viva, zero 500 (molde das provas de corrida das rodadas anteriores); nenhum `Map/Set` de controle em memória.
7. Gates por onda: socrático ≥ 0,70 · adversarial sem HIGH/CRITICAL; achado confirmado vira teste.
8. Família nfe (F4, quando houver fato gerador): NF-e autorizada em homologação da SEFAZ-PR com XML válido no XSD, DANFE renderizado, inutilização de faixa homologada, cancelamento 110111 e denegação tratada como D sem efeito automático.
9. **Carga (D-F3)**: `scripts/carga-fiscal.ts` com 1000 licenciados × 5 req/s × 30 min contra fisco FALSO, em 2 instâncias: p95 < 5 s fora do tempo do fisco, zero 500, zero documento duplicado, nenhum estado em memória de processo; relatório anexado ao prompt.
10. **Multi-app (D-F2)**: dois apps do mesmo licenciado com credenciais independentes emitem pelo mesmo emitente; revogar um não afeta o outro; token expirado → 401 legível; app sem escopo `nfse:write` → 403; app web direta só das origens do licenciado (CORS); nenhum secret em claro no banco, no log ou na resposta.
11. **Operação para 1000**: alerta de vencimento de A1 por licenciado (o da Setes em 08/10/2026 é o caso zero), métricas por licenciado visíveis, `/health` prova banco + cofre + storage.
12. **Se Q-F27 = (a)** — setes-api passivo: nenhuma chamada HTTP de saída do setes-api para a fiscal-api (cerca por grep em `src/`); recibo com assinatura inválida/expirada/de outro licenciado → 401/409 e NADA muda na nota; nota com "declaração solicitada" sem recibo → cancelamento local 409 `FISCAL_RECEIPT_REQUIRED`; app fechado entre o passo 2 e 3 da saga → ao reabrir, o app recupera pelo `externalCode` e completa, sem 2º documento; webhook de entrada com recibo C aplica o efeito sem humano; selo fiscal da lista = último recibo verificado.

---

## 11. Análise — setes-app como cliente DIRETO da fiscal-api (Valdo, 2026-10-03, 3ª mensagem)

> ⚠️ **Registro histórico.** A direção (app cliente direto, setes-api passivo) foi decidida na D-F4; os MECANISMOS desta análise (recibo assinado, federação, webhook de entrada) foram SUPERADOS pela D-F10/D-F11/D-F13 (leitura direta do banco na mesma instância + mesmo login).

> "não quero que setes-api vire cliente e sim o setes-app vire cliente de fiscal-api como qualquer outro front-end... analise isso"

### 11.1 O que a frase muda

| Antes (D-F2 como registrada) | Pedido |
|---|---|
| setes-api = `tb_licensee_app` de escopo pleno; orquestra "faturar → fatos → fiscal-api → vínculo → efeito"; app continua falando só com `/api`, **inalterado** | setes-app (e qualquer front-end) fala DIRETO com a fiscal-api; **o setes-api não chama a fiscal-api** |
| Regra canônica dos dois grupos: setes-app ↔ setes-api × Sincronizador ↔ setes-sync (D1 da revisão do sync); app: "módulo fala só com o seu `/api/<m>`" | nasce uma 3ª aresta: setes-app ↔ fiscal-api. Se confirmado, é decisão EXPLÍCITA: o app consome N APIs do produto, cada módulo com datasources dedicados por API, nunca cruzados |

Não muda o CONCEITO nem a fronteira do parecer §3 (conteúdo no ERP; formato e conversa na API). Muda o **PORTADOR** dos fatos e das vozes: em vez do servidor, o front-end.

### 11.2 As quatro perguntas que o desenho tem que responder — e como responde sem furar a fronteira

1. **Quem monta os FATOS do documento?** O conteúdo é do ERP (§3.B: emitente, tomador, serviço congelado, valores, zona). → O setes-api expõe `GET /api/<ramo>/:orderId/fiscal-facts` = o `buildDpsBase` de hoje SERIALIZADO (o payload do `POST /v1/nfse/documents`) + `externalCode` determinístico (`<schema>:<invoiceId>:<vida>`), e grava na nota a INTENÇÃO ("declaração solicitada"). O app REPASSA à fiscal-api. O ERP continua dono do conteúdo; o app é portador. Um front-end de terceiro produz os fatos do próprio sistema dele. Os 422 de cadastro incompleto continuam do ERP (nascem no `fiscal-facts`).
2. **Como o usuário do app se autentica na fiscal-api sem carregar o segredo do licenciado?** (Q-F22) → **federação de identidade**: a fiscal-api confia em tokens emitidos pelo backend do LICENCIADO — chave pública/JWKS registrada em `tb_licensee`. O setes-api já emite JWT para o app; passa a emitir também um token curto para a fiscal-api (claims: `licensee`, `emitters` permitidos, escopos, `externalUser`). O setes-api vira **emissor de identidade confiado**, não cliente. Front-end de terceiro com backend próprio faz o mesmo; sistema servidor usa `tb_licensee_app` + `POST /v1/auth/token`.
3. **Como o ERP sabe o que o fisco disse, sem perguntar à fiscal-api e sem acreditar no app?** → **RECIBO ASSINADO**: toda voz que a fiscal-api devolve (A, R, F, C, K, N) vem num JWS assinado pela fiscal-api (chave pública conhecida do setes-api, com rotação) contendo `documentId`, `externalCode`, `emitter`, `kind`, `dh`, chave/número. O app repassa o recibo (`POST /api/<ramo>/:orderId/fiscal-receipt`); o setes-api verifica a assinatura OFFLINE, grava o vínculo e aplica o efeito. **Hearsay morre por construção**: um app não consegue "contar" ao ERP que o fisco cancelou — só portar o recibo. A D-N7 relaxada (Q-F19) vira: *C local SÓ com recibo C verificado*; "nunca cancela no escuro" vira *nota com vínculo e sem recibo conclusivo → 409 `FISCAL_RECEIPT_REQUIRED` ("consulte na fiscal-api e traga o estado")*. Alternativa examinada: verificar a assinatura do PRÓPRIO fisco no XML da NFS-e/evento (ICP-Brasil) — mais pesado e não cobre F/K/R; fica como opção.
4. **E quando não há humano na tela?** (voz C descoberta pelo worker da fiscal-api — cancelada no portal; A tardia depois de K) → **webhook de ENTRADA** no setes-api (`/hooks/fiscal-document/:inst/:token`, molde do Inter — D-I9) carregando o MESMO recibo assinado. Receber webhook não é ser cliente: nenhuma chamada de saída. **O que fica impossível sem chamada de saída: EMISSÃO iniciada pelo servidor** (rotina mensal transmitindo sozinha; `fiscal_auto_transmit` da D-N9 fora de uma tela). Hoje transmitir é ato explícito do usuário — nada se perde hoje; perde-se a opção futura → Q-F28.

### 11.3 A saga no front-end (3 passos) e a recuperação

```
1. app → setes-api   GET  /api/<ramo>/:orderId/fiscal-facts        → fatos + externalCode; nota marcada "declaração solicitada"
2. app → fiscal-api  POST /v1/nfse/documents (token federado)       → 201 A · 422 R · 202 K  — sempre com RECIBO assinado
3. app → setes-api   POST /api/<ramo>/:orderId/fiscal-receipt {jws} → verifica assinatura, grava vínculo (documentId), aplica efeito
```

- App fecha/rede cai entre 2 e 3: a nota fica "declaração solicitada sem recibo"; ao reabrir, o app consulta `GET /v1/nfse/documents?externalCode=` (UNIQUE: acha o documento ou nada — §3.C) e completa o passo 3. Idempotente nos três passos; a fiscal-api nunca cria 2º documento para o mesmo `externalCode`.
- Lote "Transmitir pendentes": o app fatia e repete a saga por item (já faz isso na cobrança mensal — D27); o orçamento de 60 s do servidor e o `runningBatch` morrem por construção.
- Lista com selo fiscal: (i) o app consulta a fiscal-api por lote de `externalCode` (Q-F16 (a)) ou (ii) o ERP mostra o **último recibo verificado** — um espelho LEGÍTIMO, porque nasceu de assinatura, não de cache. Isso reabre a Q-F16 a favor de (ii) "espelho por recibo", que o guardião aceitaria (não é "status sincronizado por cron": é fato assinado portado).
- Cancelar nota: `buildCancelPlan.fiscal` lê vínculo + último recibo; recibo A vigente → o app precisa cancelar na fiscal-api PRIMEIRO e trazer o recibo C; recibo R/F conclusivo → cancela local; sem recibo conclusivo → 409.
- A1 e habilitação: o upload do `.pfx` vai do app DIRETO à fiscal-api — o certificado nunca passa pelo ERP (ganho). Telas Super de licenciado/app/emitente no setes-app consomem a fiscal-api.

### 11.4 O que muda no plano (F2 vira duas frentes; o app MUDA)

| Antes (Rodada 1) | Com o setes-api passivo (Q-F27 (a)) |
|---|---|
| F2 "setes-api consumidor": `@shared/fiscal-client`, 5–7 sessões, **app inalterado** | **F2a — setes-api PASSIVO** (`fiscal-facts`, `fiscal-receipt` com verificação JWS, vínculo + efeito, webhook de entrada, token federado, cerca "zero saída" por grep): 4–6 sessões · **F2b — setes-app CLIENTE** (módulo/datasource `fiscal` apontando para a fiscal-api, token, saga resumível, lote no cliente, DANFSe/XML direto, upload do A1 direto, telas Super de licenciado/app/emitente): 6–9 sessões — **17 arquivos Dart de hoje mudam + novos** |
| F1 shell: token por app | F1 ganha federação (JWKS por licenciado), recibos assinados (chave da fiscal-api + rotação), CORS por licenciado como caminho PRINCIPAL, endpoints de arquivo pensados para browser/mobile: +2–3 sessões |
| `trilha-primeiro-cliente.ts` bate só no setes-api | a trilha vira um FRONT-END: bate nas duas APIs e porta recibos (régua do corte) |
| Total F0–F3: 24–35 sessões | **30–43 sessões ≈ 6–8 semanas** |

### 11.5 Ganhos e custos (sem maquiar)

**Ganhos**: fiscal-api front-end-first de verdade (o PDV/NFC-e autoriza do dispositivo, um salto a menos — relevante para a F5); ERP menor e SEM dependência de saída (fiscal-api fora não derruba faturamento nem baixa); o A1 nunca transita pelo ERP; front-end de terceiro é cidadão de 1ª classe desde o 1º dia; `runningBatch` e o orçamento de lote do servidor morrem.

**Custos**: cada front-end reimplementa a saga de 3 passos (mitigar com receita publicada + SDK Dart/TS); o app muda (não mudava); sem emissão iniciada pelo servidor (Q-F28); o estado do ERP fica ATRÁS do fisco até um recibo chegar (webhook mitiga); mais superfície de segurança (CORS, token no browser, chaves de verificação e rotação); o lote passa a depender da sessão do usuário (fechar a aba = parar — Q-R5.2 já existia).

### 11.6 Leitura do guardião aplicada (sem nova rodada do agente)

O parecer §3 continua inteiro: conteúdo no ERP, formato/conversa na API, API cega ao ERP. O que ele proíbe continua proibido, com outro transporte: C local sem voz → *sem recibo*; estado em cache decisório → *só recibo verificado*; "ERP cancela sem perguntar quando há vínculo" → *sem recibo conclusivo, 409*. Palavra nova a ocupar se decidido: **recibo** (`receipt`) = a voz assinada pela fiscal-api para quem a porta — não colide com "voz" (fato cru do fisco), "registro" (boleto no banco) nem "protocolo" (número do fisco). Nome candidato da tabela do ERP: `tb_invoice_fiscal_receipt` (substitui `tb_invoice_fiscal_document` — o vínculo passa a ser o 1º recibo).

**Recomendação**: Q-F27 (a) — fazer exatamente o que o Valdo pediu, com os três mecanismos (federação, recibo assinado, webhook de entrada) como condição; sem eles, "o app é o cliente" vira "o ERP acredita no app", e isso o guardião chamaria de maquete.

---

## 12. Plano consolidado pós-Rodada 2 (2026-10-03) — VIGENTE

> Substitui §4, §5, §6, §10 e §11 **onde conflitarem** (essas seções ficam como registro das Rodadas 0/1). Toda linha cita a decisão que a sustenta. O que ainda é DESENHO (não decisão) está marcado *candidato F0* e passa pelo guardião + `revisar-ddl` antes de virar DDL.

### 12.1 Topologia e projetos (D-F9, D-F12, D-F17, D-F7)

```
                      Plesk (domínio = gate do cliente) — build Flutter (setes-app)
                         │ JWT do produto (RS256 — D-F13)      │                │
                         ▼                                      ▼                ▼
                 setes-api :3000                         nfse-api :3002     nfe-api :3003 (sem código — D-F20)
             (ERP; PASSIVO: nunca chama                  ├─ núcleo: fiscal-api (BIBLIOTECA — dependência local no dev, tag no deploy)
              as APIs fiscais — D-F4)                    └─ ADN · DPS · DANFSe · fonte de fatos do ramo de serviço
                         │                                      │
                         │ SELECT só nas VIEWs do fiscal_api    │ SELECT só em setes_central/setes_* (D-F15)
                         ▼                                      ▼ controle total só no fiscal_api
            ┌──────────────── Instância MySQL única (D-F9) ─────────────────┐
            │ setes_central · setes_<cliente>… · fiscal_api (D-F7) │ setes-sync :3001 (inalterado)
            └────────────────────────────────────────────────────────────────┘
```

| Pasta na raiz | Papel | Roda? | Repo |
|---|---|---|---|
| `fiscal-api/` | **núcleo comum** (D-F17): transporte mTLS, XMLDSig, cofre cifrado, storage de XML, habilitação/emitente, máquina tentativa × voz, motor de PDF, autenticação pelo JWT do produto, base da fonte de fatos Gestão 2027, migrations do `fiscal_api` | não (biblioteca) | `valdosouza/gestao-2027-fiscal-api` (a criar pelo Valdo) |
| `nfse-api/` | serviço da família NFS-e (ADN): gateway `/v1`, OpenAPI servido, health, ADN + DPS + DANFSe, fonte de fatos do ramo de serviço | sim, :3002 | `valdosouza/gestao-2027-nfse-api` (a criar) |
| `nfe-api/` | serviço da família NF-e/NFC-e (SEFAZ) | não nesta fase (D-F20) | `valdosouza/gestao-2027-nfe-api` (a criar quando houver código) |

### 12.2 Fronteira revisada (D-F10, D-F11, D-F14, D-F21)

| Peça hoje no setes-api | Destino | Observação |
|---|---|---|
| `tax-authority/{https-json, xmldsig, types}` | **núcleo** | transporte e assinatura paramétricos por família |
| `tax-authority/{adapters/adn, dps-builder}` | **nfse-api** | específicos do ADN/DPS |
| `secret-store` (owner `establishment`) | **núcleo**, reescrita: A1 CIFRADO no `fiscal_api` (D-F16) | o setes-api MANTÉM a sua para o canal do banco (owner `bank-account`, D-I1) |
| `fiscal-issuer` | **núcleo** | `tb_establishment_issuer` → `fiscal_api.tb_issuer`; PKCS#12 → par PEM igual |
| `invoice-transmission.ts` (política da voz) + `transmission.repository.ts` | **núcleo** (máquina) + **nfse-api** (estratégia do ramo) | tabelas passam para o `fiscal_api`; o EFEITO sai (D-F11) |
| `branches/service.ts` — leitura do ERP (`readServiceInvoice`, `buildEmitter`, `buildRecipient`, `buildDpsBase`, `emitterDpsFacts`, L8) | **nfse-api**, como FONTE DE FATOS (D-F10) | só-leitura no ERP (D-F15); os 422 de cadastro incompleto continuam com os mesmos códigos |
| `branches/service.ts` — `lockDpsNumber`/`setDpsNumber` (`tb_invoice_service.dps_number`) | **morre** no ERP | o nDPS da vida vive na tentativa do `fiscal_api` (a API não escreve no ERP) |
| `danfse` | **nfse-api** (motor pdfkit no núcleo) | nome/município do emitente lidos do ERP pela fonte de fatos |
| `applyCancelEffect` / `buildCancelPlan.fiscal` / `reconfirmBeforeLocalCancel` | **FICAM no setes-api** | leem a voz nas VIEWs do `fiscal_api` (D-F11); a reconfirmação no fisco (Q-ADV1b) passa a ser pedida pelo APP à nfse-api antes do cancelamento local |
| `billing.fiscal.*` (9 rotas) + `establishment.issuer.*` (5 rotas) | **morrem no setes-api** | o app chama a nfse-api direto (D-F4); o setes-api fica só com o efeito e o plano |
| privilégios TRANSMITIR/CANCELAR por ramo | REGRA no ERP; APLICADA pela nfse-api lendo o schema do cliente (D-F13) | o resolver de interface do ramo vira leitura da fonte de fatos |
| `runningBatch` / lote de 60 s | **morre** | o lote é do app (fatia e repete — molde D27) |
| `runningRefresh` (Map em memória) | **morre** | trava no banco ou worker (F3); nenhum `Map/Set` de controle |

### 12.3 Banco `fiscal_api` — modelo CANDIDATO F0 (guardião + `revisar-ddl` antes do DDL)

> ⚠️ **SUPERADO pelo §14** (Rodada 3: `tb_establishment_certificate`/`tb_establishment_issuer` — D-F34; DPS por vida — D-F30; sem vínculo de efeito — D-F28; DDL por dono — D-F35).

Princípio: as tabelas da Onda 3 MUDAM DE CASA, não de conceito — mesma forma, mesma chave natural (`tb_institution_id` é global em `setes_central`), sem FK para o ERP (outro banco). O que muda: o efeito sai da voz; o A1 entra no banco cifrado; o nDPS da vida passa para a tentativa.

| Tabela (candidata) | Origem | PK | Notas |
|---|---|---|---|
| `tb_emitter` | cofre em arquivo (`SECRETS_PATH/<schema>/establishment/<inst>/P/`) | `tb_institution_id` | A1 do estabelecimento (D-N31, D-F14): `cnpj` (do CN, conferido com o ERP no upload — D-N29b), certificado PEM (público), chave privada CIFRADA (AES-256-GCM: cifra + iv + tag + versão da chave-mestra — D-F16), metadados públicos (subject, notBefore, notAfter, fingerprint) gravados no upload para o alerta de vencimento sem decifrar |
| `tb_issuer` | `tb_establishment_issuer` (058/060) | `(tb_institution_id, model)` | ambiente H/P; série e `dps_last_number` só fazem sentido no SE (D-F21: 55/65 numeram no ERP) |
| `tb_invoice_service_transmission` | idem (058/059/061) | `(tb_institution_id, tb_invoice_id, terminal, attempt)` | + `dps_number` (o nDPS da tentativa, que hoje mora no ramo do ERP); `invoice_event` = VIDA da nota (D-N27) |
| `tb_invoice_service_transmission_event` | idem (058/060) | `(…, attempt, event)` | append-only; **sem `invoice_event`** (o efeito é fato do ERP — D-F11) |
| controle de migrations | — | — | migrations próprias do `fiscal_api`, aplicadas pelo núcleo sob trava nomeada (duas instâncias sobem juntas) |

VIEWs publicadas para o setes-api (D-F15): `vw_invoice_service_transmission` (tentativa + última voz — o `TX_SELECT` de hoje) e `vw_invoice_service_transmission_event` (vozes). A VIDA vigente (D-N27) e a vigente por chave (D-N26) são aplicadas pelo LEITOR do setes-api, que conhece o `tb_invoice_event` dele.

No ERP (setes-api, migration nova): o vínculo do EFEITO — *candidato* `tb_invoice_fiscal_effect` (nota × modelo × tentativa × evento da voz → evento C local produzido, ou motivo da recusa). Pendência = voz C (view) sem efeito aplicado. Substitui a coluna `invoice_event` da voz.

### 12.4 Serialização entre os dois serviços (D-F15) — candidato F0

> ⚠️ **SUPERADO pela D-F27**: com as APIs fiscais podendo escrever no ERP, a serialização volta a ser o `FOR UPDATE` na linha da nota (`tb_invoice`), como na Onda 3; a trava nomeada abaixo fica como registro.

Hoje transmitir × cancelar local se serializam pelo `FOR UPDATE` na mesma `tb_invoice`. Com GRANT só-leitura de cada lado, a trava comum vira **trava nomeada da instância**: `GET_LOCK('fiscal:<institutionId>:<invoiceId>', 10)` — sem privilégio de escrita na tabela do outro, mesma instância MySQL (D-F9). Regras: (1) toma-se a trava ANTES do `BEGIN` (sob REPEATABLE READ a 1ª leitura fixa o snapshot — regra 2 do PADROES §9) e solta-se DEPOIS do `COMMIT`/`ROLLBACK`; (2) a nfse-api a segura na RESERVA da tentativa (relê vida e último evento da nota no ERP); (3) o setes-api a segura no plano + cancelamento local (relê a vigente nas views); (4) timeout = 409 `RESOURCE_BUSY`, nunca reexecuta (D-A23). Conferir na F0 se o MySQL da SaveInCloud é MariaDB ou MySQL 8 (`GET_LOCK` múltiplo por sessão existe nos dois desde MariaDB 10.0.2 / MySQL 5.7).

### 12.5 Autenticação (D-F13) — candidato F0

setes-api assina o JWT em **RS256** com `kid` (par de chaves fora do repo: `JWT_PRIVATE_KEY_PATH`; a pública vai para a nfse-api por configuração `JWT_PUBLIC_KEY_PATH`, rotação por `kid`); payload inalterado (`institutionId`, `userId`, `role`, `schemaName`). Corte: tokens HS256 antigos deixam de valer (relogin — o app já reloga diário). A nfse-api: valida assinatura + expiração; confere `schemaName` × `setes_central.tb_institution`; licença = interface do ramo contratada (D-F14); privilégio TRANSMITIR/CANCELAR pelo mesmo resolver do setes-api (admin passa — D32). CORS: origens do domínio do Plesk (configuração).

### 12.6 Cofre e XML (D-F16)

Chave-mestra `FISCAL_MASTER_KEY` (32 bytes, base64) por ambiente, fora do repo; AES-256-GCM; `cipher_key_version` permite rotação (reabre com a antiga, regrava com a nova). Senha do PKCS#12 nunca persiste (D-N5). XML: interface `FiscalStorage` (fs no dev, `STORAGE_PATH/<cnpj>/<H|P>/<ano>/<mês>` — Q-N38a/Q-TZ7 mantidos); no dev a nfse-api aponta para o MESMO `STORAGE_PATH` do setes-api (os XMLs da Setes ficam onde estão); backend de produção na F3.

### 12.7 Ondas revisadas e esforço (D-F19, D-F20, D-F22, D-F24)

| Onda | Entrega | Esforço (sessões) |
|---|---|---|
| **F0 — desenho** | guardião sobre o modelo §12.3–12.5; DDL do `fiscal_api` + views + script de GRANT (`revisar-ddl`); OpenAPI `v1` da nfse-api (design-first); contrato da fonte de fatos (interface TS); migration do vínculo de efeito no ERP; esqueleto dos 3 projetos | 2–3 |
| **F1 — núcleo + nfse-api** | biblioteca `fiscal-api` (mover/adaptar transporte, assinatura, emissor, máquina tentativa × voz, cofre cifrado, storage, auth RS256, db/erros/log/fuso) + serviço `nfse-api` (rotas `/v1`, OpenAPI servido, health, ADN, DPS, DANFSe, fonte de fatos do serviço); testes migrados + novos; script de migração dos dados da Setes (D-F18); smoke no ADN **H** com o A1 real | 8–11 |
| **F2a — setes-api passivo** | remover as peças fiscais e as 14 rotas; leitor das views (selo da lista, plano de cancelamento, pendências); aplicador do efeito + vínculo; JWT RS256; cerca "zero chamada de saída para as APIs fiscais" (grep); trilha `trilha-primeiro-cliente.ts` como FRONT-END das duas APIs | 3–5 |
| **F2b — setes-app cliente** | datasource dedicado da nfse-api (base URL por `--dart-define`), os 17 arquivos Dart do fiscal + aba "Emissor fiscal" apontando para a nfse-api, lote no cliente, regra canônica nova em `ARQUITETURA_MODULOS.md` | 4–6 |
| **F3 = Onda 4 do produto (D-F19)** | topologia D-F9 na SaveInCloud (MySQL único com usuários/GRANTs por serviço, setes-api, setes-sync, nfse-api, Plesk com o build), HTTPS/DNS, chaves (JWT, mestra) fora do repo, backend do XML, teste de carga contra fisco falso (D-F23), alerta de vencimento de A1 | 6–10 + espera externa |
| **IBS/CBS (D-F22) — fase própria, em paralelo** | motor no setes-api pode começar já; builder do grupo IBS/CBS no DPS entra na nfse-api depois da F1; **marco duro 01/01/2027** | prompt próprio |
| **S2 (D-F24)** | diagnóstico com 1000 schemas sintéticos (setes-api + leitura da nfse-api) | 3–5 (fase própria) |
| **F4/F5** | NF-e / NFC-e na `nfe-api`, só com fato gerador (D-F20/D-E20) | 25–35 / 15–25 |

**Total F0–F3 ≈ 23–35 sessões (5–7 semanas)**. Mais barato que o §11.4 (30–43) porque a leitura direta do banco (D-F10/D-F11) dispensa recibo assinado, federação e webhook; mais caro que mover dentro do mesmo processo porque o app muda (F2b) e nascem três projetos.

**Riscos com data**: (1) o A1 real da Setes **vence em 08/10/2026** — sem renovação não há smoke em H na F1 nem emissão em produção *(2026-10-10: VENCEU e foi RENOVADO — novo vence 05/10/2027; §19.1)*; (2) **01/01/2027** — IBS/CBS na NFS-e da Setes: F0–F2 precisam terminar até meados de novembro para o builder entrar na nfse-api a tempo, ou o builder entra provisoriamente no setes-api (decidir se a F1 atrasar) *(DECIDIDO 2026-10-10 — D-IB15 de `prompt_fase_ibs_cbs.md`: F2a antes de dezembro e o grupo só na nfse-api; corte 30/11/2026 — sem virada até lá, o grupo entra nas duas cópias do montador)*; (3) MySQL da SaveInCloud (MariaDB × MySQL 8) muda detalhes de GRANT/trava — conferir na F0.

### 12.8 Critérios de sucesso revistos (substituem §10 onde conflitarem)

1. `nfse-api` sobe com `fiscal_api` + migrations próprias; `/v1/health` prova banco, chave-mestra (decifra um vetor de teste) e storage; OpenAPI em `/docs`; **nenhum `tb_invoice`/`tb_order`/`tb_entity*` FORA da fonte de fatos** (cerca por teste).
2. Usuário MySQL da nfse-api só com SELECT em `setes_central`/`setes_*`: um `INSERT` no ERP pela conexão dela falha (prova de GRANT, D-F15); usuário do setes-api lê as views e não lê as tabelas internas.
3. Token do setes-api (RS256) aceito pela nfse-api; token adulterado/expirado/HS256 → 401; usuário sem TRANSMITIR → 403; institution sem a interface do ramo → 403.
4. `POST /v1/nfse/invoices/{id}/transmit` → 201 A no ADN H com a chave; replay → 409 "já autorizada" (nunca 2ª NFS-e); DPS rejeitado → 422 com E0xxx; timeout → em voo e o refresh reconcilia por `dps_id`.
5. Cancelamento: app → nfse-api `cancel` (voz C) → setes-api `POST /api/billing/cancel` lê a voz C na view e aplica o C local + vínculo do efeito; recusa local = pendência visível e reaplicável; nota sem tentativa cancela local sem tocar a nfse-api; transmitir × cancelar concorrentes (6 de cada) → zero 500, nenhum C local com tentativa viva.
6. Migração da Setes (D-F18): emissor, tentativas, vozes e A1 no `fiscal_api`; DANFSe da nº 704 igual; trilha P8 OK; nada reemitido.
7. setes-api sem nenhuma chamada HTTP para as APIs fiscais (cerca por grep em `src/`); setes-app fala com a nfse-api só pelo datasource dedicado.
8. Gates por onda: socrático ≥ 0,70 · adversarial sem HIGH/CRITICAL; achado confirmado vira teste.
9. Carga (F3, D-F23): 2 instâncias da nfse-api, fisco falso, p95 < 5 s fora do fisco, zero 500, zero documento duplicado.

---

## 13. Parecer do guardião sobre o modelo da F0 (setes-conceito, 2026-10-03) — Rodada 3

> Avaliou o §12.3–12.6 DENTRO das D-F1…D-F26. Fatos que ele citou foram conferidos no código e no banco do dev antes de entrar aqui (§13.3). Os pontos de decisão viraram Q-F35…Q-F43 no §8.

### 13.1 Veredito por item

| # | Item do candidato | Veredito | Por quê (resumo) |
|---|---|---|---|
| 1 | manter `tb_invoice_service_transmission(_event)` no `fiscal_api` | **fiel** | `tb_fiscal_document` só existia para consumidor estrangeiro com `external_code` — morreu com D-F10/F14/F25; seria uma 3ª identidade para (nota, vida, modelo). Conjugada = dois ramos = duas famílias de tabela (backbone `tb_invoice` no ERP × `tb_invoice_<ramo>_transmission` no `fiscal_api`). Ajuste: a máquina do núcleo recebe o REPOSITÓRIO da família (`transmission.repository.ts:13-15` já prevê) |
| 2 | nDPS na tentativa com regra de cópia | **maquete** | fato da VIDA repetido em N linhas + regra para não se contradizer; a 059 teve de derrubar a UNIQUE `(inst, dps_id)`. Armadilhas: `LIFE_WHERE` mostra tentativa sem vida em TODA vida (`transmission.repository.ts:98-102`) → herdaria o nDPS de vida cancelada (mesmo Id → fisco ecoa a NFS-e cancelada, Q-N33); a série é RELIDA a cada reserva (`invoice-transmission.ts:193/203`) → trocar a série no meio da vida muda o Id. Peça proposta: **`tb_invoice_service_dps`** — o DPS de UMA vida (PK nota × terminal × `life_event`; série + nDPS + `dps_id` write-once; UNIQUE `(inst, dps_id)` volta; contador segue no emissor) — D-N3/D-N18 por CONSTRUÇÃO |
| 3 | vínculo do efeito `tb_invoice_fiscal_effect` | **ajuste — provavelmente não entra** | no máximo UMA voz C por nota × vida × modelo (HIGH-3a + D-N26) → vínculo DERIVÁVEL: pendência = voz C na vida vigente com a nota ainda não-C; idempotência = "a nota já é C" (`applyCancelEffect` já faz). Motivo de recusa gravado é estado em cache (envelhece quando a baixa é estornada) — recalcular pelo plano. Colunas de causa no `tb_invoice_event` não servem à conjugada (duas vozes C → um C local) |
| 4 | efeito sem humano | decisão | hoje NÃO há worker: o refresh é `POST` de quem abre a tela e aplica o efeito na mesma requisição. Tradução fiel = saga do app (quem recebe a voz C da nfse-api pede ao setes-api) + job interno como rede de segurança (não é chamada de saída; produz FATO do ERP, não copia estado). GET com efeito colateral: nunca |
| 5 | trava nomeada `GET_LOCK` | **fiel com 3 ajustes** | (a) construção, não disciplina: `cancelInvoice` confere `IS_USED_LOCK(nome) = CONNECTION_ID()` (três produtores de C local: `billing.service.ts:864` + os dois caminhos fiscais); pedir a trava no MEIO de transação que já segura linhas = espera cruzada InnoDB × trava nomeada que nenhum detector vê; (b) a VOZ que vira final → autorizada (A por consulta depois de R/F) também toma a trava; (c) duas pré-condições que o ERP verificava sozinho saem de casa — plano local ANTES do pedido ao fisco (`:596-598`) e a reconfirmação Q-ADV1b (`:298-331`): se o setes-api só confiar que o app reconfirmou, é "o ERP acredita no app" (maquete do §11.6). Detalhes: `terminal` no nome da trava; virar regra 8 do PADROES §9 |
| 6 | views como contrato | **fiel — não é cache** | fonte lida na hora, no mesmo snapshot, sob a trava. Riscos: (i) POLÍTICA em dois códigos — a vigente (`currentOf`, `:236-240`) e a vida (D-N27) na nfse-api (decide transmitir) e no setes-api (decide cancelar); (ii) view com `ROW_NUMBER`/`GROUP BY` não funde e vira temporária — com 1000 clientes, varredura |
| 7 | fonte de fatos | **fiel para FATOS; ajuste para POLÍTICAS** | o núcleo fica cego se a cerca for teste; privilégio é leitura do ERP → adaptador Gestão 2027, mas como porta própria (núcleo define `facts` × `grants`). Problema é o CONTEÚDO: `resolveOrderInterface` (ciclo da OS, âncora da devolução, D-A31), "admin passa" (D32), vida, fuso por config e a matriz do Anexo I (Q-N36 também a aplica no save do estabelecimento) são POLÍTICAS que o setes-api segue usando — copiar = duas verdades |
| 8 | palavras | ajustes | `tb_emitter` → **`tb_establishment_certificate`** ("emitente" já é o `prest` ocupado e convida a guardar fatos do emitente que a D-F10 manda ler do ERP; o conceito é o A1 — D-N31; o `cnpj` é o do CN, fato do certificado) · `tb_issuer` → **manter `tb_establishment_issuer`** (renomear contraria "muda de casa, não de conceito" e piora a colisão com `tb_invoice.issuer`) · "efeito" = fato LOCAL que a voz do terceiro produz no ERP (registrar) · "fonte de fatos" ok em prosa; no código `erp-facts` (`source` já é a coluna P/Q da voz) · **"vida"** = intervalo entre um E e o C seguinte — coluna `life_event` (hoje `invoice_event` significa VIDA na tentativa (061) e EFEITO na voz (058)) |

### 13.2 O que NÃO entra / onde vira maquete (do parecer)

NÃO entra: `tb_fiscal_document`, `tb_licensee`, fatos do emitente no `fiscal_api`, `dps_number` na tentativa, motivo de recusa persistido, coluna de status/"última voz", FK entre bancos, DDL de família no núcleo, `tb_invoice_service.dps_number` depois da migração, `Map` de controle em memória.
Vira maquete: (1) nDPS copiado entre tentativas · (2) política do ERP copiada na nfse-api · (3) `currentOf` em dois códigos · (4) efeito com tabela/motivo gravado · (5) trava nomeada só por disciplina · (6) ERP aceitando cancelamento local sem prova legível da reconfirmação · (7) nfse-api reimplementando o plano de cancelamento · (8) certificado crescendo com fatos do emitente.

### 13.3 Conferência dos fatos citados (2026-10-03)

- `invoice.ts:251` — o revive zera `dps_number` (nova vida = novo nDPS) ✔ · `billing.service.ts:857` — `reconfirmBeforeLocalCancel` roda ANTES do `cancelInvoice` ✔ · `invoice-transmission.ts:193/203` — a série vem do emissor relido a cada reserva ✔.
- Banco do dev (`setes_setes`, MariaDB 10.4.20): 19 tentativas / 21 vozes / 3 notas — 7971 (1 tentativa, P, com chave), 8005 (1, H, sem chave), **8011 (17 tentativas, TODAS com o mesmo Id de DPS, 13 em H e 4 em P, chave na 17ª)** — a vida já atravessa o ambiente com o mesmo nDPS (prova viva do item 2). **19/19 tentativas têm vida (`invoice_event` = 1)** → a Q-F36 do guardião (tentativas sem vida na migração) **não tem objeto no dado real**: a coluna nasce NOT NULL e o script de migração FALHA ALTO se achar NULL. `setes_ws` não tem as tabelas fiscais (nada a migrar).

---

## 14. Modelo final da F0 (pós-Rodada 3, 2026-10-04) — VIGENTE

> Substitui §12.3–§12.5 onde conflitar. Decisões: D-F27…D-F35 sobre as D-F1…D-F26.

### 14.1 Quem é dono de quê

| Banco / schema | Dono (DDL) | O que tem | Quem lê | Quem escreve |
|---|---|---|---|---|
| `fiscal_api` — comum | núcleo `fiscal-api` (D-F35) | `_migrations` (com namespace), `tb_establishment_certificate`, `tb_establishment_issuer` | nfse-api, nfe-api | nfse-api, nfe-api |
| `fiscal_api` — família NFS-e | `nfse-api` (D-F35) | `tb_invoice_service_dps` (D-F30), `tb_invoice_service_transmission`, `tb_invoice_service_transmission_event` + VIEWs `vw_invoice_service_dps`, `vw_invoice_service_transmission`, `vw_invoice_service_transmission_event` | nfse-api; setes-api SÓ pelas VIEWs (D-F15) | nfse-api |
| `setes_<cliente>` — políticas | setes-api (D-F32) | VIEWs `vw_order_interface` (interface do ramo por pedido) e `vw_invoice_life` (vida vigente da nota) | setes-api E nfse-api | — (views) |
| `setes_<cliente>` / `setes_central` — fatos | setes-api / sync | nota, ramo congelado, cadeia, `tb_entity_tax`, configs, privilégios | nfse-api pela fonte de fatos `erp-facts` (D-F10) | setes-api; a nfse-api SÓ trava a linha da nota (D-F31) |

### 14.2 Serialização (D-F27)

Volta o protocolo da Onda 3: **`SELECT … FOR UPDATE` na linha da nota (`setes_<cliente>.tb_invoice`)** dentro da transação de quem decide — a nfse-api na reserva da tentativa (e nas vozes que gravam sob a nota, como hoje), o setes-api no plano + cancelamento local. A transação da nfse-api usa UMA conexão que cruza `setes_<cliente>` e `fiscal_api` (mesma instância — D-F9). Ordem de locks: institution (contador) → nota → emissor → DPS da vida → tentativa. A trava nomeada do §12.4 morreu.

### 14.3 Cancelamento (D-F28/D-F29/D-F11)

```
app → setes-api   GET  plano de cancelamento (consultivo)                 bloqueios locais? → para aqui
app → nfse-api    POST /v1/nfse/invoices/{id}/reconfirm   (só se a vigente é F por consulta em P — Q-ADV1b)
app → nfse-api    POST /v1/nfse/invoices/{id}/cancel      → ok (voz C gravada) | não ok (o app NÃO avança)
app → setes-api   POST /api/billing/cancel                → lê a voz C na view (FOR UPDATE na nota) → C local
```
Sem vínculo gravado: pendência = voz C na vida vigente × nota ainda não-C (derivada, nas duas telas). Sem job: voz C sem humano fica pendente e visível até o próximo contato do app. Nota sem tentativa / R / F conclusivo → o app vai direto ao setes-api.

### 14.4 O que muda na F1/F2 por causa da Rodada 3

- F1 (nfse-api): `tb_invoice_service_dps` substitui `lockDpsNumber`/`setDpsNumber` (ERP) e a cópia do nDPS; a fonte de fatos lê a vida e a interface do ramo pelas VIEWs do ERP (D-F32); a máquina da voz vem da biblioteca, com o repositório da família injetado (§13.1-1); a lista do que a nfse-api escreve no ERP é testada (D-F31 — hoje: nada, só `FOR UPDATE`).
- F2a (setes-api): migration das VIEWs de política (D-F32) + `resolveOrderInterface`/vida passam a ler delas; dependência da biblioteca `fiscal-api` para o contrato de leitura (D-F33); `buildCancelPlan.fiscal` lê a vigente pelas views do `fiscal_api` + exige a prova da reconfirmação (D-F29); `tb_invoice_service.dps_number` aposentado.

### 14.5 DDL da F0 — revisado (`revisar-ddl`) e provado (2026-10-04)

| Arquivo | Dono (D-F35) | Conteúdo | Estado |
|---|---|---|---|
| `fiscal-api/src/migrations/sql/001_core_baseline.sql` | núcleo | `tb_establishment_certificate`, `tb_establishment_issuer` | escrito; aplica na F1 (o executor do núcleo cria `fiscal_api` e `_migrations` com namespace) |
| `nfse-api/src/migrations/sql/001_nfse_baseline.sql` | família NFS-e | `tb_invoice_service_dps`, `tb_invoice_service_transmission`, `tb_invoice_service_transmission_event` + `vw_invoice_service_transmission`, `vw_invoice_service_transmission_event` | escrito; aplica na F1 |
| `setes-api/src/migrations/sql/065_fiscal_policy_views.sql` + espelho no `sql/03` | setes-api | `vw_order_interface`, `vw_invoice_life` (D-F32) | **APLICADA no dev** (`setes_setes`, 2026-10-04) |

Prova: (1) sqlglot OK nos três (o `sql/03` inteiro já falhava ANTES desta mudança — `ADD KEY IF NOT EXISTS` do MariaDB, fora do sqlglot); (2) banco DESCARTÁVEL `fiscal_api_f0probe` no MariaDB 10.4.20 do dev: duas passadas (re-executável), carga com o dado REAL da Setes (3 DPS · 19 tentativas · 21 vozes), última voz da view × `TX_SELECT` de hoje = **0 divergências**, `EXPLAIN` fundido (acesso por chave), UNIQUE `(institution, dps_id)` → `ER_DUP_ENTRY`, FK tentativa → DPS da vida → `ER_NO_REFERENCED_ROW_2`; banco apagado ao fim; (3) views de política contra a lógica de hoje: **0 divergências** em 7.947 pedidos (`resolveOrderInterface`) e 7.430 notas (`LAST_INVOICE_EVENT_KIND_SQL` / MAX(E)), sem linha duplicada, `EXPLAIN` fundido (const pela PK).

Checklist: PK/FK em colunas existentes ✔ · padrões `tb_`/inglês/singular ✔ · `created_at`/`updated_at`/`deleted` ✔ · sem AUTO_INCREMENT (chaves naturais) ✔ · `DEFAULT NULL` real ✔ · base certa (`fiscal_api` — D-F7; políticas no schema do cliente — D-F32) ✔ · sem FK entre bancos (decisão) ✔ · nenhum JOIN por VARCHAR entre collations ✔ · re-executável ✔ · ordem de dependência ✔ · sem seed com dado sensível ✔ · `dps_id` 45 posições (DPS + cMun 7 + tpInsc 1 + CNPJ 14 + série 5 + nDPS 15) ✔.
Para a F1: a conexão do núcleo fixa `time_zone '+00:00'` e REPEATABLE READ (PADROES §9/§10 — instantes UTC); ordem de locks institution → nota (ERP) → emissor → DPS → tentativa; na migração D-F18 a série sai do próprio Id (`SUBSTRING(dps_id, 26, 5)`) e o nDPS dos 15 finais.

---

## 15. Execução da F1 — núcleo `fiscal-api` + serviço `nfse-api` (2026-10-04)

> Código entregue nas pastas da D-F17; decisões citadas nos comentários do código. Gates em §15.4.

### 15.1 O que nasceu

| Onde | O quê | Origem / decisão |
|---|---|---|
| `fiscal-api/src/db/` | pool com REPEATABLE READ + UTC por conexão e conferência no boot; `withTransaction` com retry de deadlock; `assertSchema`; executor de migrations com namespace `(project, version)` + `GET_LOCK` | PADROES §9/§10; D-F35 |
| `fiscal-api/src/auth/product-jwt.ts` | verificação RS256 só com chave PÚBLICA (rotação por `kid`; HS256 recusado por construção); `isAdmin`/`isSuper` iguais ao setes-api; middleware com conferência da identidade no banco | D-F13 |
| `fiscal-api/src/secret/` | `MasterKeyRing` (AES-256-GCM, versão, AAD = linha); certificado A1 (PKCS#12 → folha, validação do par, e-CNPJ do PRÓPRIO emitente) | D-F16; D-N5/D-N29 |
| `fiscal-api/src/establishment/` | `tb_establishment_certificate` + `tb_establishment_issuer` no `fiscal_api`; `openIssuer` (409s na ordem; decifra só na chamada); `nextDpsNumber` | D-F34; D-N18/D-N31 |
| `fiscal-api/src/transport/` | `https-json` (mTLS, tradução de falhas, `afterHandshake`) e `xmldsig` — MOVIDOS sem mudança | Onda 3 |
| `fiscal-api/src/storage/` | `FiscalStorage` + `FsFiscalStorage` (layout `<cnpj>/<H|P>/<ano>/<mês>`, mês da zona, tmp+rename) | D-F16; Q-N38a/Q-TZ7 |
| `fiscal-api/src/voice/` | vocabulário da voz + CONTRATO DE LEITURA (tipos das views, `currentOf`, `fiscalStateOf`, `localCancelPending`, `reconfirmationCandidate`/`Proven`) — o mesmo que o setes-api vai importar | D-F33; D-F28/D-F29 |
| `fiscal-api/src/erp/facts.ts` | fonte de fatos BASE (D-F10): políticas pelas views da 065 (D-F32), privilégio/licença, fuso, cadeia de entidade, `tb_entity_tax`, IBGE, CNPJ do estabelecimento e a TRAVA da nota (`FOR UPDATE` + `LOCK IN SHARE MODE` no último evento + vida) | D-F10/D-F27/D-F31 |
| `nfse-api/src/authority/` | dialeto ADN + montagem do DPS/evento — MOVIDOS (só imports) | Onda 3 |
| `nfse-api/src/facts/service-facts.ts` | fonte de fatos do ramo de serviço (`readServiceInvoice`, `buildEmitter`, `buildRecipient`, `buildDpsBase`, `emitterDpsFacts`, pendentes) — sem `dps_number` do ERP | D-F10/D-F30 |
| `nfse-api/src/nfse/` | repositório da família (DPS da vida, tentativa, voz; nenhuma referência ao ERP — a vida chega por parâmetro) + COMPOSIÇÃO `transmission.ts` (transmitir, consultar, reconfirmar com PROVA, cancelar no fisco em linha com RESERVA K, rodízio por ALUGUEL na linha da habilitação — gates, §15.4 —, tela, XML, DANFSe) | D-F27…D-F30; Onda 3 |
| `nfse-api/src/modules/` + `app.ts` | `/v1/emitter` (admin) e `/v1/nfse` (privilégio do RAMO pela view `vw_order_interface`; leitura = interface contratada), `/v1/health`, `/docs` + `/v1/openapi.yaml` (design-first), CORS por lista, envelope de erro da casa | D-F8/D-F13/D-F14 |
| `nfse-api/scripts/` | `migrate.ts` · `migrate-from-setes-api.ts` (migração única + RE-SINCRONIA até a virada) · `mint-dev-token.ts` (só dev até a F2a) | D-F18 |
| `nfse-api/ops/grants.sql` | GRANTs de produção + nota MariaDB × MySQL 8 sobre leitura travante | D-F15/D-F31 |
| `setes-api` migration **065** + espelho no `sql/03` | `vw_order_interface`, `vw_invoice_life` — APLICADA no dev | D-F32 |

### 15.2 Provas

- **Testes**: `fiscal-api` 23 (cofre/AAD/rotação, PKCS#12 real, `openIssuer` sobre banco falso, contrato de leitura, JWT inclusive confusão RS256→HS256, storage, corte de migrations, CERCAS do núcleo cego e de `Map/Set`) · `nfse-api` 65 (23 de transporte/ADN PORTADOS sem mudança + 3 DANFSe + 28 da composição + 11 da borda HTTP com a cerca OpenAPI × rotas e a cerca "tabela do ERP só em `src/facts/`").
- **Banco real (MariaDB 10.4.20 do dev)**: usuário `fiscal_api` com SELECT no ERP — `FOR UPDATE` e `LOCK IN SHARE MODE` PASSAM, `INSERT` no ERP → `ER_TABLEACCESS_DENIED_ERROR` (critério §12.8-2 provado); migrations do `fiscal_api` aplicadas e idempotentes.
- **Migração D-F18** (`migrate:setes`, ensaio + real + 2ª passada sem efeito): 1 habilitação (SE em **P**), A1 cifrado (CNPJ 07742094000113, **vence 08/10/2026**), 3 DPS de vida, 19 tentativas, 21 vozes, todos os XMLs achados pelo storage da nfse-api (mesmo `STORAGE_PATH`).
- **Ao vivo (nfse-api :3002, sem tocar o fisco)**: `/v1/health` 200 (banco, chave-mestra, storage); emitente com o A1 decifrando; nota 8011 = **NFS-e 704** cancelada (17 tentativas, chave na 17ª — igual ao setes-api), 7971 = 705 cancelada, 8005 = falha em H; XML da 704 e DANFSe servidos; lista de pendentes; transmitir nota cancelada → 409 sem fisco; token HS256 atual do setes-api → 401 (esperado até a F2a); CORS só para a origem da lista.

### 15.3 Correções de rumo feitas na execução (sem decisão nova — "corrigir", não "decidir")

1. **Rodízio sem voz C**: a consulta ativa revisitava C a cada 15 min para retentar o efeito local; com a D-F28 o efeito é do setes-api — C saiu do rodízio.
2. **Pendentes do lote** só listam nota com evento E na web (`last_kind = 'E'`): a nota sincronizada da origem aparecia como pendente e sempre falhava com 409.
3. **Trava da nota = `FOR UPDATE` na `tb_invoice` + `LOCK IN SHARE MODE` no último evento** (leitura travante compartilhada, regra 2 do PADROES §9 — sem trava exclusiva em linha de evento do ERP); a vida vem na mesma leitura e todo `FOR UPDATE` do repositório da família recebe a vida por parâmetro (nunca junção com o ERP).
4. **Migração = re-sincronia até a virada**: enquanto o setes-api for o caminho de produção, a origem vence nos campos mutáveis (contador por GREATEST, chave/número por COALESCE, A1 renovado = fingerprint diferente → recifra), vozes só acrescentam, DPS da vida é write-once. ⚠️ Rodar de novo NA VIRADA (F2a), com o caminho antigo parado.
5. **Mensagem de erro sem nome de tabela** (`INVOICE_SERVICE_BRANCH_MISSING`).

### 15.4 Gates da F1 (2026-10-04)

**Rodada 1 (código como entregue no §15.1): socrático 0.62 ✗ · adversarial 0.58 ✗.**
- HIGH: (1) vida que atravessa H→P — o titular do Id do DPS e o "minter" da reconfirmação ignoravam o AMBIENTE: a chave de
  PRODUÇÃO pousava na tentativa de HOMOLOGAÇÃO (forma real da 704 e da 8005) e o cancelamento ia ao host de H; (2) rodízio
  filtrava a vida vigente em JS DEPOIS do LIMIT — linhas descartadas presas no topo, rodízio parava em silêncio; (3) o rodízio
  segurava a conexão do `GET_LOCK` e pedia outra ao pool — N passadas × pool de N = serviço travado para sempre; (4) nada
  impedia a nfse-api de emitir pela institution que o setes-api ainda emite (D-F18 "sem dual-write").
- MEDIUM: `FOR UPDATE` redundante sob a trava da nota (gap lock antes do contador → deadlock entre notas vizinhas, provado
  com 6 notas em paralelo); dois "Cancelar NFS-e" simultâneos = dois e101101 (o 2º voltava "recusado" com a NFS-e já
  cancelada); corrida resposta direta × rodízio pousando a mesma chave; licença (D-F14) não conferida nas AÇÕES do
  usuário comum; lote de pendentes sem paginação, preso na cabeça e listando voz C.
- LOW: 404 para nota inexistente; caractere de controle no motivo; CNPJ do estabelecimento inválido aceitava qualquer A1;
  DELETE do A1 com transmissão viva; health não via versão de chave-mestra faltando.

**Retrabalho 1 (todos corrigidos na sessão, cada achado virou teste):** titular/minter por ambiente + `findKeyHolder`;
candidatas filtradas inteiras no SQL (join com `vw_invoice_life`, vivas antes de autorizadas); ALUGUEL `refresh_lease_until`
(migration **002** do núcleo — UPDATE atômico, 60 s); cerca `FISCAL_LEGACY_INSTITUTIONS` (ações e escritas do emitente →
409 `FISCAL_CUTOVER_PENDING`; `migrate:setes` só para a cerca e FALHA ALTO em dual-write — tentativa/DPS/voz que a origem
não tem); leituras não travantes sob a trava da nota; RESERVA K antes do fisco (recusa/preparo local/credencial → N;
ambíguo → o K fica); reservada que perde a corrida fecha com F "envio reconciliado"; licença nas ações (admin → Q-F46);
pendentes paginados (`page`/`pageSize`, envelope da casa) só dos ramos visíveis e sem A/N/S/K/C; o resto dos LOW.
Achado NOVO do ataque ao vivo nesse retrabalho: K → N → K na mesma tentativa dentro do mesmo segundo colidia na UNIQUE
`(…, kind, dh)` → 500 — **K e o N de liberação são fatos NOSSOS e vão com `dh` NULL** (a UNIQUE é a idempotência da voz
do fisco). Contrato: o YAML dizia `localEffectPending` (o código devolve `localCancelPending`) e não tinha `atAuthority`.

**Rodada 2: socrático 0.75 ✅ · adversarial 0.60 ✗ (nenhum HIGH em nenhum dos dois).**
- Socrático: as 8 correções conferidas no código (arquivo:linha). MEDIUM: cerca por variável de ambiente libera tudo quando
  falta ou vem mal escrita → **Q-F48**; aluguel devolvido sem conferir o dono; custo das leituras que crescem com o
  histórico → **Q-F49**. LOW: `FOR UPDATE` restante na consulta/voz C; vigente em duas cópias (SQL × `currentOf`) sem teste;
  texto técnico na voz N; relatório da passada com ids de ramo não contratado; `skipped` enganoso.
- Adversarial (testes `adversarial-f1r2*.ts`): MEDIUM **DELETE do A1 × reserva em curso** — a 1ª leitura não travante da
  reserva criava o snapshot do REPEATABLE READ ANTES da trava da habilitação; a reserva que esperava o DELETE acordava,
  lia o A1 do snapshot e assinava com o certificado já apagado (provado: 1 tentativa e 1 envio ao fisco depois do DELETE);
  MEDIUM cerca mal escrita (`"1;7"`) virava conjunto vazio = cerca aberta, sem log; LOW aluguel sem dono (provado: A apaga o
  aluguel de B e C roda junto), passada sem habilitação respondia `skipped`, erro técnico cru no 200 sem `logger.error`, 6
  status devolvidos fora do YAML e `reconfirm` sem schema.

**Retrabalho 2 (corrigidos na sessão; os `it.failing` do QA viraram `it`):** na reserva, emissor `FOR UPDATE` + A1 `LOCK IN
SHARE MODE` logo depois da trava da nota e ANTES de qualquer leitura não travante (`openIssuer` com `forUpdate` lê o A1
ATUAL); `legacyFromEnv` ESTRITO (item mal escrito impede o boot) + cerca no log de boot; aluguel com TOKEN do dono
(`acquireRefreshLease` devolve o `refresh_lease_until` gravado; `releaseRefreshLease(…, token)` só apaga o próprio); passada
sem habilitação → 409 `FISCAL_ISSUER_MISSING`; erro técnico da passada → `Erro interno (ref X)` + `logger.error` com o mesmo
ref; voz N sem texto técnico; YAML com os status reais + `ReconfirmResult`; `FOR UPDATE` restante sob a trava da nota
removido; teste ao vivo de equivalência "vigente do SQL = `currentOf`" (9 vidas reais, inclusive a 704 — zero divergência).

**Re-prova adversarial (Rodada 3 — delta do retrabalho 2): 0.80 ✅ — nenhum HIGH/CRITICAL/MEDIUM.** Provado ao vivo
(`adversarial-f1r3.live.test.ts`): troca do A1 × reserva em curso → a reserva assina com o A1 NOVO; troca P→H × reserva → tudo
em H; exclusão da habilitação × reserva → 409 sem reservar; cancelamento LOCAL do setes-api segurando a nota não prende o
emitente (PUT habilitação 40 ms, aluguel 10 ms); lote de 12 notas já autorizadas em 299 ms (todas 409, contador intacto);
estresse misto (5 notas + escritores do emitente + aluguel) com zero 500/RESOURCE_BUSY/deadlock e nDPS contíguos; nenhum
ciclo na ordem nota → emissor → A1 (S) → DPS → tentativa. 4 LOW, **corrigidos na sessão** (viraram `it`): cerca feita só de
separadores (`","`) abria — agora falha o boot; status reais da CONSULTA (reconfirm 422/502, refresh 422) + 413/415 + teto do
`page` no YAML; corpo com charset/encoding não suportado virava 500 com ref sem token — agora 415 `UNSUPPORTED_MEDIA_TYPE` no
envelope (e qualquer 4xx do parser com o status dele); contenção numa nota da passada vira `RESOURCE_BUSY` (warn), não
"erro interno".
**Fechamento dos gates da F1: socrático 0.75 ✅ · adversarial 0.80 ✅** (o único `it.failing` restante é a Q-F46).

**Provas finais:** `fiscal-api` 29/29 · `nfse-api` 102 + 45 ao vivo (3 suítes: banco real do dev + fisco FALSO + transporte
bloqueado), zero 500 · `fiscal_api` IDÊNTICO à origem depois de cada ataque (19 tentativas, 21 vozes, A1 com o mesmo
fingerprint, aluguel nulo, nenhuma linha marcada pelos ataques; `migrate:setes` sem divergência). Nada falou com o fisco
real; nada commitado.

**Assunções tomadas nos retrabalhos ("corrigir, não decidir" — confirmar na Rodada 4 junto com as Q-F45…Q-F49):**
A1 reserva K antes do fisco, N na recusa/preparo/credencial, K/N com `dh` NULL · A2 cerca da virada por variável ESTRITA,
ausente = nenhuma (implementa a D-F18 até a Q-F48) · A3 re-sincronia: o A1 de `not_after` mais novo vence; dual-write = falha
alta · A4 pendentes paginados, sem C e só dos ramos visíveis (nenhum ramo = lista vazia, não 403) · A5 titular da chave
procurado no ambiente da tentativa · A6 passada sem habilitação = 409 · A7 `/v1/health` é READINESS (503 quando falta no anel
uma versão de chave que cifra A1 vivo) — não usar como liveness na SaveInCloud (derrubaria todos os tenants).

**Resíduo conhecido (não reprovou; registrado para a F2/F3):** a passada é manutenção da institution — consulta notas de ramo
não contratado e devolve os ids delas no relatório (LOW, D-F14 em leitura); K preso se o fisco responder 404 ao GET da chave
antes da carência (analisado); o cancelamento passa por `buildEmitter` (exige `opSimpNac`) — cadastro tributário limpo depois
da emissão bloqueia o cancelamento no fisco (422 + N); `migrate:setes` compara a voz só por kind e confere XML com zona fixa;
leitura de institution na cerca serve CÓPIA até o próximo `migrate:setes` (risco só se o app ler a nfse-api antes da F2b); a
reserva agora trava o emissor antes de responder 409 "já autorizada" (serializa a institution por milissegundos no lote);
Q-N28b da Onda 3 (recusa "já cancelada" grava N e devolve 409 até a consulta trazer o C). Da re-prova (analisados, não
provados): sessão sem `SET time_zone` numa conexão nova desloca o aluguel (o boot confere uma conexão só); a futura nfe-api
apagando o A1 compartilhado precisa da MESMA guarda de transmissão viva (D-N31 — guarda de todas as famílias); leitura travante
da `vw_invoice_life` pode segurar por milissegundos o evento E da próxima nota faturada (medir na F2a); prova da reconfirmação
no mesmo segundo do F é recusada pelo setes-api (fail-closed, só UX); habilitação migrada com série NULL × YAML `serie`
não-nullable.

### 15.5 Pendências para fechar a F1 e abrir a F2

1. **Smoke no ADN de HOMOLOGAÇÃO com o A1 real** (critério §12.8-4) — fala com o fisco (sandbox): QUANDO e COMO = **Q-F45**; depois da escolha, **"vai" do Valdo**; e o A1 vence em **08/10/2026**.
2. **Dual-run até a virada**: o setes-api continua transmitindo em produção; a nfse-api NÃO emite por estabelecimento cuja habilitação é RÉPLICA (`cutover_at` NULL — D-F39; 409 `FISCAL_CUTOVER_PENDING`, recusado também no núcleo). A virada (F2a) = parar o caminho antigo → `npm run migrate:setes -- --cutover <id> --confirmo-setes-api-parado` (re-sincronia final + `cutover_at` na MESMA transação; falha alto em dual-write ou transmissão viva na origem; Q-F50 decide se aposenta a habilitação SE do ERP no mesmo ato) → setes-api passa a ler as views e a assinar RS256 → app (F2b) aponta para a nfse-api.
3. **F2a (setes-api passivo)** — ⚠️ D-F50: a F2a cria a migration de nome EXATO `NNN_f2a_fiscal_passivo.sql` (sem ela a virada
   recusa): RS256 + par de chaves (o de dev já está em `setes-api/secrets/jwt/`, fora do git), leitor das views pela biblioteca (D-F33) com leitura travante, `buildCancelPlan.fiscal` + prova da reconfirmação (D-F29), selo da lista, `resolveOrderInterface`/vida lendo as views da 065 (D-F32), remoção das 14 rotas e peças fiscais, cerca "zero chamada às APIs fiscais".
4. **Repos GitHub** `valdosouza/gestao-2027-fiscal-api` e `-nfse-api` (e `-nfe-api`) — criar (Valdo); hoje git local.


## 16. Execução da Rodada 4 (D-F36…D-F40 — Valdo: "siga as recomendações", 2026-10-04)

### 16.1 O que foi feito

| Decisão | Execução | Prova |
|---|---|---|
| **D-F37** licença para todos | DADO acertado antes da regra: `setes_setes.tb_institution_has_interface` ganhou `service-orders` (interface 20) para a institution 1 — ela emitia 344 OS sem a interface no contrato. Guardas (`nfse-api/src/modules/guards.ts`): a licença é conferida antes do privilégio, para TODOS; o admin passa só o privilégio; pendentes do admin só dos ramos contratados. **F2a**: o setes-api passa a fazer o mesmo. | unit (admin sem ramo → 403 em ação e leitura; com ramo → 201) + ao vivo (o admin transmite a OS porque o ramo é contratado) |
| **D-F38** teto do rodízio | `listRefreshCandidates` com `COALESCE(dh_proc, created_at) >= NOW() - teto`; teto = `cancelDaysOf` (PAM do município do emitente, cache 1 h, no ambiente da habilitação) + 30; qualquer falha → 60 + 30 (nunca bloqueia a passada). A consulta manual da nota continua. | unit (PAM 45 → 75 dias; A1 vencido → 90) + ao vivo (SQL real) |
| **D-F39** cerca = fato | Parecer do guardião (§16.2) → migration **003** do núcleo `cutover_at` (aplicada no dev: institution 1 = RÉPLICA, o estado da cerca anterior; nenhum UPDATE); `openIssuer` recusa réplica (toda conversa com o fisco passa por ele); `nextDpsNumber` e `acquireRefreshLease` com a condição NO comando; habilitação criada pela API nasce virada (revive/ON DUPLICATE nunca toca); predicado `emissionStillInErp` (réplica viva ou excluída · ou, sem linha, habilitação SE do ERP viva ou excluída — `erp.erpServiceIssuerExists`, tolera a tabela ausente depois da F2a); `requireCutover` lê o fato; `FISCAL_LEGACY_INSTITUTIONS` APOSENTADA (definida = boot falha). `migrate:setes`: escopo pelo dado (toda institution com habilitação SE no ERP), virada = CONGELADA (`assertFrozen`: origem com tentativa nova ou contador além do da API → falha alta), ato `--cutover <id> --confirmo-setes-api-parado` (trava a habilitação do ERP como 1º comando, depois o `fiscal_api`; recusa transmissão viva na origem; re-sincroniza; vira TODAS as linhas da institution). | núcleo 32/32 (réplica não abre/cunha/aluga; predicado nos 5 casos) · ensaio `--cutover 1 … --dry-run` = 1 linha virada e desfeita · sem a flag → recusa · as 3 suítes ao vivo viram a habilitação só durante o ataque (CHECKSUM idêntico, institution 1 volta réplica) |
| **D-F40** custo como critério | Critério registrado (p95 < 300 ms com 200 mil notas, F3/S2) + `nfse-api/scripts/explain-leituras.ts` (`npm run explain:leituras`; EXPLAIN de view exige `SHOW VIEW` — usuário de diagnóstico em `EXPLAIN_DB_USER`, o do serviço NÃO ganha o privilégio). Hoje: nenhuma subconsulta dependente varre por linha; pendentes ~14 ms e rodízio ~2 ms no dev; a tabela que dirige a página de pendentes é a de EVENTOS da nota com `filesort` — o ponto a medir com volume. | script contra o dev |
| **D-F36** smoke H antes da virada | Por causa do write-once (D-F39), o smoke NÃO vira a habilitação real: `nfse-api/scripts/smoke-adn-homologacao.ts` (`npm run smoke:adn-h`) recria um banco DESCARTÁVEL `fiscal_api_smoke` pelas migrations, copia o A1, cria a habilitação H/série 900 já virada (contador por minuto → Id novo a cada execução), roda transmitir → consultar → XML/DANFSe → cancelar no fisco → consultar, e APAGA o banco no fim (`--manter` preserva); o ERP só é lido (nota travada por instantes); o `fiscal_api` real é intocado. Sem `--vai` só confere; `--candidatas` lista notas elegíveis. | sem fisco: pré-condições conferidas; **nenhuma nota elegível no dev hoje** (300 conferidas: 294 sem código nacional — anteriores à D-N11a —, 6 com `cTribMun` "0102" — anteriores à D-N26b) |

### 16.2 Parecer do guardião sobre a D-F39 (setes-conceito, 2026-10-04) — aplicado

Peça, não maquete: **coluna write-once monotônica** (`cutover_at`; NULL = réplica) — sem tabela de eventos (a reversão é
proibida pelo desenho; evento modelaria o que não pode acontecer). **Dado por linha (institution, model), ato por
institution** (o A1 é um por estabelecimento — virar por modelo prenderia o A1). **Condição no próprio comando que
cunha** (`nextDpsNumber`, aluguel), não só na borda. **Lacuna** (institution emitida pelo ERP e ainda não migrada) fechada
pelo predicado lendo a habilitação SE do ERP (viva ou excluída — o contador tem história); "copiar todas antes" seria
maquete (dependeria de alguém ter rodado o script). Nomes evitados: "custódia" (estado do cheque), "detém" (D-N26), "dono"
(token do aluguel), "origem" (re-sincronia); valores com nome de serviço (`'nfse-api'` numa linha 55 seria falso).

**Assunções tomadas na execução (forma, não conceito — contestáveis na próxima rodada):** A8 formato `cutover_at`
anulável no lugar dos valores `'setes-api'|'nfse-api'` do texto da Q-F48 · A9 smoke da D-F36 em banco DESCARTÁVEL (a
virada temporária que a D-F36 implicava é proibida pelo write-once) · A10 até a F2a, NÃO criar habilitação SE pela tela do
setes-api para institution que nasceu na API (conhecimento negativo; o `migrate:setes` detecta depois e falha alto) ·
A11 transmissão viva na origem durante a virada = falha alta (nunca reconciliar pelo `dps_id` no ato) · A12 os testes ao
vivo viram a habilitação real só durante o ataque e a devolvem réplica no `afterAll` (CHECKSUM conferido).

### 16.3 Pendências

1. **Smoke da D-F36**: falta uma **OS de TESTE faturada agora** pelo setes-api (regra de ISS com código nacional e código
   municipal vazio ou de 3 dígitos — a regra 2 do dev já está corrigida) — escrita no ERP da Setes, **decisão do Valdo**
   (qual cliente/serviço/valor) = **Q-F51**; depois, `npm run smoke:adn-h -- --nota <id>` (confere) e, com o **"vai"**,
   `… --nota <id> --vai`. O A1 vence em **08/10/2026**. *(2026-10-10: venceu e foi renovado — novo vence 05/10/2027; a origem da nota = D-F54; §19.1.)*
2. **Q-F50, Q-F51, Q-F52, Q-F53** (§8.R5) — aguardam o Valdo.
3. **F2a** (lista do §15.5 + D-F37): setes-api aplica a licença para todos; ato da virada com o setes-api parado.
4. Gates do delta da Rodada 4: §16.4.

### 16.4 Gates do delta da Rodada 4

**Rodada 1: socrático 0.65 ✗ · adversarial 0.70 (no limite, sem HIGH).**
- MEDIUM (os dois): o prazo do PAM (D-F38) entrou no CAMINHO CRÍTICO da passada — o deadline era fixado antes de
  `cancelDaysOf` (A1 + emitente + convênio com 30 s de transporte, falha sem cache): convênio lento = nenhuma candidata
  consultada, nem as vivas; e a leitura [INCERTO] do convênio, antes só AVISO (D-N15), passou a TIRAR notas do rodízio.
- MEDIUM (socrático): os ataques ao vivo viravam a habilitação REAL (P, A1 real) do `fiscal_api` e a devolviam no `afterAll`
  — jest morto no meio = réplica VIRADA (o cenário R2-2). E a virada fecha só um lado → **Q-F50 refinada** (§8.R5).
- LOW: rodízio direto na réplica respondia `skipped`; o cancelamento direto gravava K e N na tentativa copiada antes de
  recusar; `storeCertificate` do núcleo escrevia o A1 de uma réplica; `assertFrozen` não via VOZ nova da origem; o
  `NOT EXISTS` dos pendentes era MATERIALIZADO varrendo o histórico de TODAS as institutions (a cerca só avisava); prazo
  absurdo (data lida como dias) virava `DATE_SUB` NULL e tirava TODAS as autorizadas; guarda fraca antes do `DROP DATABASE`
  do smoke e Id de DPS repetido no mesmo minuto; a visão do emitente não mostrava a virada.
- Questões para o Valdo: **Q-F50** (refinada), **Q-F51** (nota de teste do smoke), **Q-F52** (licença × obrigação já emitida).

**Retrabalho (corrigido na sessão; os `it.failing` do QA viraram `it`):** prazo do PAM fora do caminho crítico — espera no
máximo 3 s, a falha também fica em cache (10 min), valor fora de 1–3650 dias é descartado, o teto NUNCA é menor que o padrão
(`max(PAM, 60) + 30` — assunção **A13**: leitura errada do convênio só ALARGA a revisita) e o orçamento da passada conta
DEPOIS do teto; o relatório diz `authorizedMaxDays` e `ceilingSource`; o repositório limita o teto ao domínio do SQL;
cancelamento confere a réplica ANTES de qualquer voz; passada na réplica = 409 `FISCAL_CUTOVER_PENDING`; o núcleo recusa
escrever/apagar o A1 de réplica; `assertFrozen` acusa voz nova da origem; os pendentes passam a institution como CONSTANTE
no `NOT EXISTS` (materialização por chave) e a cerca do EXPLAIN reprova materialização que varre; smoke só apaga
`fiscal_api_smoke[_sufixo]` ≠ banco da instância, Id por segundo e preserva o banco se a NFS-e de H ficar autorizada sem
cancelar; `cutoverAt` na visão do emitente (e `enabled` = virada + A1). **Ataques ao vivo em CÓPIA DESCARTÁVEL**
(`src/__tests__/live-harness.ts`: `fiscal_api_adv_r1…r4` = migrations + cópia das 5 tabelas + virada só na cópia; o
`afterAll` apaga a cópia e FALHA se o CHECKSUM do `fiscal_api` real mudou) — o banco real não é mais virado por teste.

**Provas:** `fiscal-api` 32/32 · `nfse-api` 115 unit + 71 ao vivo (4 suítes, cópias descartáveis), zero 500 · `fiscal_api`
real idêntico à origem (19 tentativas, 21 vozes; institution 1 réplica) · nenhum banco descartável sobrando · EXPLAIN sem
aviso nem falha.

**Re-prova (rodada 2 do delta): socrático 0.75 ✅ · adversarial 0.65 ✗ (sem HIGH).** O retrabalho abriu uma REGRESSÃO MEDIUM
(os dois gates): o `clearCertificate` passou a abrir a transação com a conferência da réplica por leitura NÃO travante —
o snapshot do REPEATABLE READ nascia antes da trava da habilitação e o DELETE do A1 contava 0 vivas com uma reserva
recém-comitada (provado pela rota: 200, A1 apagado, tentativa em voo sem certificado). LOW: cancelamento direto e
`storeCertificate` não viam réplica EXCLUÍDA nem a lacuna (b); cache do PAM sem "uma consulta por vez" e uma falha tardia
encolhia o teto (contra a A13); o aluguel de 60 s não cobria uma candidata de 2 × 30 s (consulta dobrada); o harness só
DETECTAVA (usuário com ALL — **Q-F53**) e não conferia `_migrations` nem o ERP; cópia que sobrava de jest morto ficava
virada; o smoke apagava a evidência da execução anterior e o envio ambíguo; o PAM do CANCELAMENTO seguia sem limite;
re-sincronia segurava trava compartilhada na origem durante a conferência de XML.

**Retrabalho 2 (corrigido na sessão; `it.failing` → `it`):** escrever/apagar o A1 começa por `assertEmitterWritable` —
`lockIssuerRows` (FOR UPDATE nas linhas da habilitação: a 1ª instrução é a TRAVA) + réplica viva/excluída + lacuna (b) pela
habilitação SE do ERP (a peça recebe `schemaName`); cancelamento direto usa o predicado COMPLETO `emissionStillInErp` antes de
qualquer voz; PAM com UMA consulta por vez (por município/ambiente e por institution), falha mantém o último prazo conhecido
(+10 min — A13), teto cacheado por institution (o A1 não é decifrado a cada passada); o cancelamento espera o PAM no
máximo 3 s e descarta valor implausível; aluguel de 90 s RENOVADO antes de cada candidata (`renewRefreshLease`; perdido =
a passada para); harness confere `_migrations` + ERP e apaga cópias `fiscal_api_adv_*` que sobraram; smoke recusa apagar
evidência anterior (sem `--descartar-evidencia`) e preserva envio sem voz; re-sincronia confere XML depois do commit.

**Provas:** `fiscal-api` 33/33 · `nfse-api` 127 unit + 96 ao vivo (5 suítes em cópias descartáveis), zero 500 · `fiscal_api`
real idêntico à origem; nenhuma cópia sobrando; `migrate:setes --dry-run` limpo.

**Re-prova FINAL do delta: socrático 0.80 ✅ · adversarial 0.70 ✅ (no limite; nenhum HIGH) — GATES DO DELTA DA RODADA 4
FECHADOS.** Pontos restantes (sem decisão de arquitetura), corrigidos DEPOIS dos gates, nesta mesma sessão:
- MEDIUM (adversarial): o DELETE do A1 ainda concluía com um CANCELAMENTO no fisco em curso — a reserva K não passava pela
  trava da habilitação → a decisão do cancelamento agora faz `getIssuer(..., FOR UPDATE)` depois da nota e antes do K
  (ordem nota → habilitação, a mesma da reserva da transmissão).
- LOW: consulta ao convênio pendurada para sempre → idade máxima de 60 s para a promessa pendente (`PENDING_MAX_AGE_MS`);
  `migrate:setes` dizia "FALHA (nada gravado)" sobre um commit já feito → a conferência de XML pós-commit vira AVISO no
  relatório; smoke com `--vai` apagava o banco em qualquer saída por erro → só o caminho feliz COMPLETO apaga; harness com
  varredura ≠ validador e vigilância com NULL silencioso → corrigidos (+ 3 tabelas do `setes_central`); a habilitação
  (`upsertIssuer`/`softDeleteIssuer`) ganhou a cerca NO NÚCLEO (`assertEmitterWritable` movido para o repositório; as
  peças recebem `schemaName`).

**⚠️ ESTADO AO SALVAR A SESSÃO (2026-10-04, pedido do Valdo "salve para iniciar uma nova seção"):** `fiscal-api` 33/33 ·
`nfse-api` 133/133 unit · ao vivo **104/108 — 4 FALHAS a resolver na próxima sessão** (todas depois das correções pós-gate):
1. `adversarial-f1r6.live.test.ts` §D — **DEADLOCK cru (1213 `ER_LOCK_DEADLOCK`) na PASSADA do rodízio** concorrente com
   reserva × PUT do A1 × PUT da habilitação (1ª de 4 rodadas). Provável causa: `lockIssuerRows` (FOR UPDATE por FAIXA da
   institution, agora também em `upsertIssuer`/`softDeleteIssuer`) × `renewRefreshLease`/`acquireRefreshLease` (UPDATE de
   linha fora de transação). Ações: (a) traduzir contenção do aluguel para `RESOURCE_BUSY`/parar a passada (nunca 1213
   cru); (b) avaliar trocar a faixa por linhas pontuais (PK) no `lockIssuerRows`.
2. `adversarial-f1r6.live.test.ts` §A (cenário + "[corrigido] DELETE do A1 NÃO conclui com a reserva K viva") — o
   CENÁRIO descrevia a ordem antiga (DELETE conta 0 e o K entra no intervalo); com o cancelamento travando a habilitação
   a sequência muda. Reescrever o cenário para a ordem nova e conferir que o DELETE recusa (409) ou que o cancelamento
   espera e vê o A1 apagado (FISCAL_CERT_MISSING + N).
3. `adversarial-f1r4.live.test.ts` §C "réplica EXCLUÍDA … upsertIssuer direto TAMBÉM recusa" — a expectativa
   `[deleted, cutover_at] = ['S', null]` divergiu (ver o Received na próxima execução; a cópia `fiscal_api_adv4` recebe
   `copyFrom` no `finally`).
Comando: `cd nfse-api && NFSE_ADV_LIVE=1 npx jest src/__tests__/adversarial-f1r6.live.test.ts src/__tests__/adversarial-f1r4.live.test.ts --runInBand`.
Banco ao salvar: `fiscal_api` real IDÊNTICO à origem (19 tentativas, 21 vozes, institution 1 RÉPLICA `cutover_at` NULL,
aluguel nulo); nenhuma cópia `fiscal_api_adv*` sobrando; `migrate:setes --dry-run` limpo. Nada falou com o fisco real;
**NADA COMMITADO** (fiscal-api, nfse-api, nfe-api, setes-api 065, sql, Infra-IA — commit/push só com o Valdo).

## 17. Retomada de 2026-10-04 (2ª sessão) — as 4 falhas ao vivo, gates do delta e Rodada 6 (D-F41…D-F45)

### 17.1 As 4 falhas do §16.4 — causa e correção (sem decisão nova)

| Falha | Causa (provada) | Correção |
|---|---|---|
| r6 §D — 1213 cru na passada do rodízio | **Promoção de trava**: `saveIssuer`/`removeIssuer` faziam `getIssuer(…FOR UPDATE)` (trava de REGISTRO na linha SE) e depois `lockIssuerRows` pedia a FAIXA da institution (next-key na mesma linha); com o UPDATE do aluguel em autocommit na FILA dessa linha, o InnoDB fechava um ciclo e matava o aluguel. Provado em banco descartável no MariaDB 10.4.20 (faixa → 1213; por linha → zero) — e a faixa ainda segurava o INSERT da institution vizinha | `lockIssuerRows` trava as LINHAS da PK (`model IN (ISSUER_MODELS)`) — PADROES §9 regra 8 (nova); teste DETERMINÍSTICO no r6 §D (falha com a faixa, passa por linha) |
| r6 §A (cenário + "[corrigido]") | o cenário era da ordem antiga; esperar o cancelamento com o bloqueador preso só produzia lock wait de 50 s nos dois (o detector de timeout do 10.4 varre a cada segundo) | cenário reescrito: o cancelamento ESPERA a trava da habilitação que o DELETE segura; depois do retrabalho do gate (abaixo) ele vê o A1 apagado SOB a trava e recusa ANTES do K — nenhuma voz, nenhum pedido ao fisco |
| r4 §C — `openIssuer` na réplica EXCLUÍDA | `getIssuer` só enxerga linha viva → "configure a habilitação" (FISCAL_ISSUER_MISSING) numa réplica | sem linha viva, `openIssuer` confere a cerca (com o schema: predicado COMPLETO `emissionStillInErp`) → 409 FISCAL_CUTOVER_PENDING |

### 17.2 Gates do delta (socrático 0.80 ✅ · adversarial r7 0.78 ✅, nenhum HIGH/MEDIUM) e retrabalho

Socrático: a trava por linha preserva as garantias da faixa (lacuna (b) inclusive); nenhum outro caminho promove trava. Adversarial
(`adversarial-f1r7.live.test.ts`, cópia `fiscal_api_adv_r7`): 8 rodadas concorrentes embaralhadas sem 1213/1205/500 cru, nDPS
estritamente crescente. LOWs corrigidos na sessão (sem decisão): peça direta com "configure a habilitação" na réplica excluída/lacuna
(b) → `openIssuer` recebe o schema e a passada confere a cerca antes (F1/F2); dois contadores da cerca → `issuerRowsState` no MESMO
domínio da trava (F3, depois fechado no banco pela D-F45); K gravado sem conferir o A1 → a decisão do cancelamento abre o emissor
TRAVANDO (habilitação FOR UPDATE + A1 travante) e recusa antes do K (fecha a janela "processo caído entre K e N = K vivo sem A1");
cerca como 1ª instrução no PUT/DELETE da habilitação (evita ABBA quando a nfe-api tiver o 55); a re-sincronia decide réplica ×
congelada pela leitura TRAVANTE (o COUNT sem trava deixava o ON DUPLICATE KEY reescrever uma linha virada em paralelo); comentários.
**Limitações ACEITAS (it.failing que as fixam no r7):** F4 — trava de INTERVALO de chave ausente alcança a institution vizinha na
CRIAÇÃO de habilitação (a faixa fazia o mesmo; criação concorrente é ato de implantação; deadlock reexecutado, esgotado = 409 sem
gravar); F6 — parada da passada por contenção: a devolução esbarra na mesma trava e o aluguel vence sozinho em ≤ 90 s (PADROES §11.7).
Achado de teste: no MariaDB 10.4 um UPDATE em AUTOCOMMIT que espera trava NÃO aparece no INNODB_TRX (provado) — detectar pelo
`SHOW FULL PROCESSLIST`.

### 17.3 Rodada 6 — execução (D-F41…D-F45)

| Decisão | Execução | Prova |
|---|---|---|
| **D-F41** espera curta no aluguel | peça `runShortCommand` do núcleo (`db/tx.ts`): conexão própria em AUTOCOMMIT só durante o comando, `innodb_lock_wait_timeout` = 3 s na SESSÃO, a anterior guardada numa variável da sessão e RESTAURADA (falhou = conexão descartada, nunca volta ao pool com a espera curta), deadlock reexecuta 1× com aviso, o resto = 409 RESOURCE_BUSY; tomar, renovar e DEVOLVER o aluguel passam por ela | núcleo `tx.test.ts` (6); r7 §E4: servidor com 50 s → a passada pela rota devolve 409 em ~4 s e as conexões voltam com 50 |
| **D-F42** migrate:setes só SE | parecer do guardião: **peça** com filtro POSITIVO (`model = SERVICE_MODEL`); a linha 55/65 do ERP é só a SÉRIE DA NOTA (fica no ERP); a SE carrega série da nota + habilitação ao fisco e só a 2ª muda de casa; não existe virada de 55/65 (nasce virada na nfe-api); réplica de outro modelo no `fiscal_api` = FALHA ALTA com a instrução de DELETE físico; escopo pelo MESMO predicado do núcleo (`erp.erpServiceIssuerExists`); `--cutover` trava a SE do ERP pela PK (a 55 do faturamento fica livre) e o `fiscal_api` por linha; pós-condição `emissionStillInErp` = falso na mesma transação | r6 §H (réplica 55 → resync e cutover falham alto; sem ela, passa) |
| **D-F43** portar correção ao setes-api durante o dual-run | caracteres de controle no texto livre do DPS/evento (achado LOW do gate da F1) portado para `setes-api/src/shared/tax-authority/dps-builder.ts` + teste. Conferido junto: **nada foi removido do setes-api** — as 14 rotas (9 `/api/billing` + 5 `/api/establishment/issuer`) e as 6 peças fiscais seguem lá e o app ainda chama só o setes-api (remoção = F2a; troca do app = F2b) | `tax-authority.test.ts` 24/24 + suíte do setes-api |
| **D-F44** (= Q-F50 (a) refinada, Valdo: "manter") o ato da virada APOSENTA a habilitação SE do ERP | `scripts/cutover-erp.ts` (só script — o serviço nunca o importa): conferência ANTES de qualquer escrita — série efetiva da NOTA SE (`serie ?? '1'`, espelho exato do setes-api) ≠ '1' = falha alta; `UPDATE … SET deleted='S'` na linha SE viva, na MESMA transação da virada; o setes-api lê/cunha sempre com `deleted='N'` → a reserva dele recebe 409 FISCAL_ISSUER_MISSING sem mudar código. Item novo da LISTA FECHADA da D-F31, com cerca por teste que varre `src/` E `scripts/` (`app.test.ts` "CERCA D-F31": a única escrita no ERP do projeto é essa). Credencial do ato = a do DONO do ERP (o usuário `fiscal_api` só lê o ERP → o UPDATE é negado e o ato inteiro volta). **Os testes ao vivo NUNCA rodam o ato real contra o ERP do dev** (é o que emite a produção da Setes): só `--dry-run` (executa a escrita e desfaz na mesma transação); a virada da CÓPIA é feita pelo teste | r6 §H "ensaio": `linhasViradas 1` + `habilitacaoErpAposentada 1` e o ERP idêntico depois; unit `cutover-erp.test.ts` (série); r4 §C reescrito |
| **D-F45** (= Q-F56 (a), Valdo: "sim") domínio do `model` como fato do banco | migration **004** do núcleo `CHECK (model IN ('SE','55','65'))` (1º CHECK da casa; aplicada no dev); boot da nfse-api chama `assertIssuerModelDomainEnforced` — um modelo fora do domínio, numa transação sempre desfeita, tem de ser RECUSADO pelo banco, senão o boot falha (MySQL < 8.0.16 ignora CHECK) | dev: CHECK registrado e aplicado (4025), zero resíduo; r7 §G: INSERT réplica/virada e UPDATE para 'XX' recusados; trava = contagem em 3 estados; núcleo `cofre.test.ts` (3) |

### 17.4 Provas ao fechar a sessão e pendências

`fiscal-api` 44/44 · `nfse-api` 143 unit + **130 ao vivo** (7 suítes em cópias descartáveis — r7 20/20), zero 500 · `setes-api`
tax-authority 24/24 · `fiscal_api` real: migration 004 aplicada, institution 1 RÉPLICA, 19 tentativas/21 vozes, nenhuma cópia sobrando.
**Gate do delta da Rodada 6 (D-F41…D-F45 + retrabalho) NÃO rodado** — próximo passo antes de "pronto".
Pendências: Q-F51 ADIADA (renovação do A1 programada), ~~Q-F52~~ DECIDIDA = D-F46 (bloqueio total — CÓDIGO FEITO, ver §17.5),
Q-F53 (GRANT dos ataques ao vivo); F2a (setes-api passivo: remover as 14 rotas e as 6 peças, licença para todos — D-F37, pré-condição do ato);
inventário dos demais achados da F1 que valem para o setes-api (A14 da D-F43). PUBLICADO 2026-10-04 nos repos PRIVADOS `valdosouza/gestao-2027-fiscal-api` · `-nfse-api` · `-nfe-api` (os demais do projeto são públicos — mudar a visibilidade é decisão do Valdo).

### 17.5 D-F46 executada (2026-10-04, 3ª sessão — nuvem)

| O quê | Onde | Prova |
|---|---|---|
| `requireAnyPrivilege` passa a DEVOLVER os ramos em que quem pede pode agir (contratado + TRANSMITIR; admin = todos os contratados); nenhum → 403 como antes | `nfse-api/src/modules/guards.ts` | `app.test.ts` "D-F46: a PASSADA só consulta…" |
| a passada usa o MESMO domínio da rota por nota (`service-orders`, `orders`, `order-returns` — `erp.orderInterface`); antes a guarda olhava só os 2 primeiros e a passada consultava TODAS as notas | `nfse.routes.ts` (`PASS_INTERFACES`) | idem (devolução contratada com privilégio entra) |
| filtro no SQL das candidatas, ANTES do LIMIT: `LEFT JOIN vw_order_interface` (D-F32) + `COALESCE(interface_key,'orders') IN (?)`; lista vazia = nenhuma consulta; sem a opção = SQL de antes (chamada interna) | `nfse/repository.ts` `listRefreshCandidates`, `transmission.ts` | `passada-ramos.test.ts` (3), `transmission.test.ts` (1) |
| `explain:leituras` captura o SQL da passada COM o filtro (D-F40) | `scripts/explain-leituras.ts` | — |
| contrato `/v1/nfse/refresh` descreve a regra | `openapi/nfse-api.v1.yaml` | cerca contrato × rotas verde |

`nfse-api` 148 unit (131 ao vivo pulados — sem banco na nuvem), `tsc` limpo. **Falta na máquina do Valdo**: rodar as suítes
ao vivo e `npm run explain:leituras` (o plano com o JOIN novo na view de política — D-F40).

## 18. Gates do delta da Rodada 6 + D-F46 (2026-10-04, 3ª sessão — nuvem; agentes que não fizeram a entrega)

**Socrático 0,76 ✅** (`revisar-riscos-sistemicos`; nenhum HIGH; 2 MEDIUM + 5 LOW) · **Adversarial r8 0,80 ✅** (`testar-adversarial`;
nenhum HIGH/CRITICAL; 2 MEDIUM + 5 LOW; `adversarial-f1r8.test.ts` no núcleo (8, todos resistidos) e na nfse-api (18)). Só
unitário: as suítes ao vivo pedem o banco do dev.

| Achado | Sev. | Destino |
|---|---|---|
| [r8-cancel-idem] o retrabalho do §17.2 pôs o `openIssuer` travante ANTES das saídas sem fisco: retry com voz C e A1 vencido/apagado = 409 FISCAL_CERT_* (contrato: 200 `atAuthority=false`); nota nunca transmitida = "envie o .pfx" (contrato: FISCAL_NOT_AUTHORIZED) | MEDIUM (provado) | **CORRIGIDO** (sem decisão): a conferência do A1 sob a trava foi para logo antes do K; o "nenhum K vivo sem A1" continua provado (`it` "resistiu") |
| [r8-resync-55] re-sincronia pulava institution sem SE no ERP antes de conferir réplica de outro modelo → institution travada sem saída | LOW (provado) | **CORRIGIDO**: leitura NÃO travante das linhas antes do `continue` (travar pegaria gap lock em institution sem linha) |
| nota viva de ramo descontratado trava o emitente para sempre | MEDIUM | Q-F57 → **D-F47 EXECUTADA** (§18.1) |
| re-sincronia segura a trava das viradas de todas as institutions | MEDIUM | Q-F58 → **D-F48 EXECUTADA** (§18.1) |
| setes-api revive a SE aposentada antes da F2a | MEDIUM/LOW | **Q-F59** |
| aluguel por institution: a passada de um conjunto de ramos dá `skipped` a quem tem outro | LOW | aceito (atraso, sem dado errado) |
| `interfaces` opcional = sem filtro em chamada interna; pendentes com 2 ramos × passada/rota com 3 | LOW | aceito; a rota sempre passa (teste); pendentes = transmissão NOVA (devolução não gera SE) |
| boot prova que o motor aplica CHECK, não que o domínio do CHECK = `ISSUER_MODELS` instalado; 004 não reexecutável | LOW | registrar para a F4 (nfe-api estende o domínio) |
| `runShortCommand` não encurta `lock_wait_timeout` (metadados — ALTER concorrente) | LOW | F3 (deploy rolante) |
| `requireCutover` antes das guardas: ramo não contratado em institution não virada vê 409 da cerca, não 403 | LOW | aceito (mesma empresa; o bloqueio vale) |
| `--cutover --dry-run` segura o FOR UPDATE da SE de produção do ERP e exige o `--confirmo` | LOW | ensaio curto; registrar no roteiro da virada |
| regex da CERCA D-F31 não pega `UPDATE IGNORE`/`DELETE t FROM`/multi-tabela | LOW | endurecer quando mexer na cerca |

Provas: `fiscal-api` 52/52 · `nfse-api` 166 unit (131 ao vivo pulados) · `tsc` limpo nos dois. **Na máquina do Valdo**: suítes
ao vivo + `npm run explain:leituras` (JOIN novo da D-F46). Próximo: Q-F53, Q-F57…Q-F59 → F2a.

### 18.1 D-F47 e D-F48 executadas (2026-10-04, 3ª sessão)

| Decisão | Onde | Prova |
|---|---|---|
| **D-F47** passada fecha as vivas do ramo cortado | `guards.ts` `passScope` (substitui `requireAnyPrivilege`: devolve `interfaces` = contratados com privilégio e `liveOnlyInterfaces` = cortados; admin com nada contratado passa só com os cortados); `listRefreshCandidates`: `AND (ramo IN (?) OR (ramo IN (?) AND (le.kind IS NULL OR le.kind IN ('S','K'))))`, antes do LIMIT | `passada-ramos.test.ts` (5), `app.test.ts`, `adversarial-f1r8.test.ts` (admin sem nada contratado → só vivas; usuário comum 403), `transmission.test.ts` |
| **D-F48** re-sincronia por institution | `scripts/migrate-from-setes-api.ts` `resyncAll` + `resyncInstitution` (begin/commit por institution; falha = rollback dela, segue, sai ≠ 0 com a lista; relatório JSON ganha `failures`); a mensagem final do script deixou de dizer "nada gravado" sempre | `adversarial-f1r8.test.ts` "[D-F48]" (2 institutions: a 1ª volta, a 2ª grava, exit 1) |

`nfse-api` 169 unit (131 ao vivo pulados), `tsc` limpo. `explain:leituras` captura o SQL mais largo (os dois grupos). **Na máquina do
Valdo**: suítes ao vivo (as de re-sincronia — r2/r4/r5/r6 — passam a ver uma transação por institution) + `explain:leituras`.

### 18.2 Gate do delta D-F47/D-F48 (socrático 0,74 ✅ · adversarial r9 0,78 ✅ — nenhum HIGH)

`adversarial-f1r9.test.ts` (19): precedência AND/OR do filtro novo provada por um oráculo que traduz o WHERE real (o filtro não
escapa da institution nem do bloco de idade); `passScope` com listas disjuntas; `--dry-run` com várias institutions desfaz todas;
o FOR UPDATE de cada institution vive só na transação dela. Achados: **[r9-inflight-never-closes] MEDIUM (provado)** — em voo
sem DPS no fisco nunca fecha pela passada → **Q-F60**; **[r9-resync-rollback-throws] LOW (provado) — CORRIGIDO**: o rollback
da institution é protegido (conexão que não desfaz é descartada; a próxima institution usa outra) e o relatório sai sempre;
LOWs aceitos: `countLiveTransmissions` sem filtro de vida/terminal × candidatas da vida vigente (anterior ao delta — depende do
setes-api recusar vida nova com tentativa viva); admin sem nada contratado ainda abre o A1 e consulta o prazo do município
antes de saber se há viva; commit gravado com confirmação perdida relatado como falha (re-sincronia idempotente).
`nfse-api` 187 unit (131 ao vivo pulados), `tsc` limpo.

### 18.3 D-F50/D-F51 executadas + gate do delta (socrático 0,80 ✅ · adversarial r10 0,84 ✅ — nenhum HIGH/MEDIUM)

| Decisão | Onde | Prova |
|---|---|---|
| **D-F50** virada confere a F2a | `scripts/migrate-from-setes-api.ts` (`F2A_MIGRATION_NAME`, `setesApiF2aApplied` antes da transação; `bloqueios` no dry-run); `r4.live` aceita a recusa pela F2a (o "já VIRADA" segue provado no `r5.live`) | `adversarial-f1r8` "[D-F50]" (2), `adversarial-f1r10` (1146/1142/conexão, dry-run, schema hostil) |
| **D-F51** F por consulta | `transmission.ts` `recordInterruptedFailure` (comum a transmitir e consultar) + `refreshServiceTransmission`; OpenAPI do `/refresh` por nota | `transmission.test.ts` (3), `adversarial-f1r9` "[r9-inflight-never-closes][corrigido]", `adversarial-f1r10` (fisco lento/fora não fecha; só E2404 estruturado; borda 9/10 min; H × P; irmã com chave; ordem de travas; corrida com o transmitir) |

Gate r10 (`adversarial-f1r10.test.ts`, 34): **[r10-lost-race-stale] LOW (provado) — CORRIGIDO** (quem perde a corrida do F devolve a
voz lida e não carimba). LOWs aceitos: F2a em mais de um arquivo (o nome vai no último); migration por `db:migrate` antes do
deploy e rollback de deploy = procedimento; dry-run com bloqueio sai 0 (o roteiro lê o JSON); "10 min ⇒ o POST acabou" é
premissa (timeout do transporte é de ociosidade — anterior ao delta). Nova: **Q-F61** (revisita única do F por consulta).
`nfse-api` 223 unit (131 ao vivo pulados), `tsc` limpo.

### 18.4 D-F52 executada (2026-10-04)

`nfse/repository.ts` `listRefreshCandidates`: 4º grupo do OR — `le.kind = 'F' AND le.source = 'Q' AND t.access_key IS NULL`, F há ≥ 24 h e
dentro do teto, `last_queried_at < F + 24 h`, `NOT EXISTS` tentativa posterior na vida; ordenado junto das autorizadas. Literais
(constante e teto já dentro do domínio) — nenhum parâmetro novo. Prova: `adversarial-f1r9.test.ts` "D-F52" (o oráculo que traduz o
WHERE real ganhou os átomos novos; matriz de 9 linhas). `nfse-api` 224 unit, `tsc` limpo. Na máquina do Valdo: `explain:leituras`
(o `NOT EXISTS` correlacionado usa a PK da tentativa).


## 19. Sessão de 2026-10-10 desta máquina (renumerada na reconciliação — §20)

> Esta seção era o §17.5…§17.12 desta máquina. Na reconciliação com a 3ª sessão de 2026-10-04 (§17.5/§18, outro clone) os
> números de decisão, de questão e de seção foram convertidos para a numeração unificada (tabela §20.2) — inclusive no texto
> abaixo. O gate adversarial que aqui se chama "r8" é o **r11** da sequência unificada (ids ADV-R8-xx mantidos). A D-F55
> (licença só na transmissão nova) foi REVOGADA na reconciliação.

### 19.1 Retomada de 2026-10-10 — A1 renovado, Rodada 5 fechada, D-F55 executada (REVOGADA na reconciliação — §20.3), preparação da nfe-api

**1. O A1 — conferido no disco (2026-10-10).**

| Onde | Certificado | Validade |
|---|---|---|
| Cofre do setes-api (`secrets/setes_setes/establishment/1/P/certificate.pem`) — o caminho de PRODUÇÃO até a virada | o ANTIGO (e-CNPJ A1, CN …:07742094000113) | 08/10/2025 → **08/10/2026 20:05 UTC — VENCIDO** |
| Réplica no `fiscal_api` (cópia do cofre pela `migrate:setes`) | o ANTIGO | idem |
| Repositório de certificados do Windows (CurrentUser\My) | **RENOVADO** — e-CNPJ A1, AC SAFEWEB RFB v5, CN …:07742094000113, chave privada presente | **05/10/2026 → 05/10/2027** |
| `D:\Modelos\Setes\Certificado Digital e-CPF A1 -F. D. SOUZA … - 1011666973.pfx` (gravado 10/10/2026 12:29) | o arquivo da renovação (o nome diz "e-CPF", o certificado instalado é e-CNPJ; o setes-api confere o CNPJ do emitente — D-N29) | — |

Entre 08/10 20:05 UTC e o envio do novo, o setes-api recusa transmitir (409 "Certificado digital A1 do emissor expirou") — a
Setes não emite NFS-e nesse intervalo. **Caminho da renovação no dual-run** (o `fiscal_api` é RÉPLICA — D-F39): (a) o Valdo
envia o `.pfx` + senha pela aba "Emissor fiscal" do setes-api (o agente NUNCA digita a senha — D-N5); (b) `npm run
migrate:setes -- --dry-run` e depois `npm run migrate:setes` na nfse-api (SEM `--cutover`): fingerprint diferente → recifra o
A1 novo na réplica; (c) re-rodar as suítes ao vivo. Achado da sessão: com o A1 vencido na réplica, 20 dos 51 ataques ao vivo das
suítes f1 e r4 falham (409 do emissor no lugar do 422 esperado, e a cascata) — IGUAL com e sem a D-F55 (conferido com `git
stash`), ou seja, é o certificado, não o código.

**Feito no mesmo dia (13:27):** o Valdo enviou o `.pfx` pela aba "Emissor fiscal"; cofre conferido (CN …:07742094000113, AC
SAFEWEB RFB v5, 05/10/2026 → 05/10/2027, SHA-256 `48:15:23:3C:…`, par certificado × chave conferido); `migrate:setes
--dry-run` → "RENOVADO (CNPJ 07742094000113, vence 2027-10-05)", 0 XML faltando; `migrate:setes` real → commit; réplica no
`fiscal_api` com a mesma impressão digital e `cutover_at` NULL (continua réplica). Re-prova: f1 + r4 **51/51** (as 20 falhas
eram o certificado) e as 7 suítes ao vivo **131/131** — já com a D-F55 e as correções do gate (§19.2).

**2. Rodada 5 FECHADA (D-F54, D-F55 [revogada na reconciliação] e D-F53 — nesta máquina eram D-F46…D-F48; §7).**

**3. D-F55 executada (nfse-api, não commitada) — REVOGADA na reconciliação; o código saiu (§20.4):** `src/nfse/repository.ts` (`hasFiscalObligation`,
`institutionHasFiscalObligation`), `src/modules/guards.ts` (`licensedOrCommitted`; `requireBranchPrivilege(…, { newTransmission })`
obrigatório; `requireBranchInterface` e `requireAnyPrivilege` aceitam obrigação assumida), `nfse.routes.ts` (transmit = nova;
refresh/reconfirm/cancel = sobre o já declarado). Testes: `app.test.ts` +2 (D-F55 por nota e na passada; privilégio continua;
admin não passa a licença da transmissão nova), `adversarial-f1.live` (expectativa por nova × assumida), `adversarial-f1r4.live`
(título: "sem obrigação assumida"). nfse-api 145/145 unit, typecheck limpo. Gate do delta da D-F55 junto com o da Rodada 6.

**4. Pedido do Valdo (2026-10-10): "vamos nos preparar para montar a api-nfe".** A D-F20 dizia "nfe-api sem código até o 1º
cliente de mercadoria" — o pedido é de PREPARAÇÃO (Rodada 0 da nfe-api: inventário + questões), não de código. Rodada 0
ORGANIZADA em `prompt_onda_nfe_sefaz.md` §11 (Q-NE1…Q-NE26; Q-NE1 = suspender a D-F20 em parte; Q-NE10 = Q-F64).

**5. Pendências (ordem):** ~~envio do A1 (Valdo) → re-sincronia da réplica → re-rodar os ataques ao vivo~~ (FEITO — item 1) → gate
ADVERSARIAL do delta (Rodada 6 + D-F55 + correções; socrático FEITO — §19.2) → Q-F63/Q-F64 → D-F53 com o "vai" (GRANT + harness) → D-F54 (OS de teste + smoke em H com o "vai") → F2a → F2b.

### 19.2 Gate socrático do delta da Rodada 6 + D-F55 (2026-10-10) — **0.72 ✅**, sem HIGH/CRITICAL

Revisão (agente, só leitura; achados conferidos no código antes de aceitar): `runShortCommand` restaura a espera ou descarta a
conexão; a trava por linha da PK não deixou promoção no SERVIÇO; a ordem é nota → habilitação → A1 em todos os caminhos
(inclusive nfse-api × setes-api no dual-run); CHECK aplicado e conferido no boot; filtro só SE na cópia e no ato; a escrita no
ERP é uma só, na transação da virada. Achados:

| Id | Sev. | Achado (conferido) | Destino |
|---|---|---|---|
| **M1** | MEDIUM | o PUT da habilitação do setes-api REVIVE a linha SE que o ato aposentou (`ON DUPLICATE KEY UPDATE … deleted='N'`, `setes-api/src/shared/fiscal-issuer/fiscal-issuer.repository.ts:57-73`) com o contador congelado — instância esquecida/rollback + um clique na aba "Emissor fiscal" = mesmos nDPS que a nfse-api já cunhou (R2-2 reaberto) | **Q-F63** (decisão) |
| **M2** | MEDIUM | o cancelamento abria o emissor INTEIRO (A1 + chave-mestra) ANTES de olhar a voz C → com cancelamento já feito e A1 vencido, o ok idempotente da D-F28 virava 409/503 | **CORRIGIDO** (`nfse-api/src/nfse/transmission.ts`: estado primeiro, `openIssuer` travante logo antes do K — mesma ordem de travas) + teste |
| **M3** | MEDIUM | o ATO gravava por padrão e argumento desconhecido era ignorado — um `--dry-run` digitado errado aposentaria a SE de produção | **CORRIGIDO** (`migrate-from-setes-api.ts`: lista FECHADA de argumentos; o ato é ENSAIO por padrão e só grava com `--vai`; `--vai` + `--dry-run` = erro) + `migrate-args.test.ts` |
| L1 | LOW | passo 5 do `--cutover` fazia UPDATE pela FAIXA da institution depois de travar por registro (regra 8 violada no próprio script) | **CORRIGIDO** (UPDATE pela PK: `model IN (ISSUER_MODELS)`) |
| L2 | LOW | porte parcial da D-F43: o `normalizeCancelMotive` do setes-api media o piso de 15 ANTES de tirar o controle → Error cru (500) | **CORRIGIDO** no setes-api + `cancel-motive-control.test.ts` |
| L3 | LOW | a trava "por linha" depende do PLANO (`range` de 3 pontos na PK); o teste prova um plano numa tabela quase vazia | pendência: `lockIssuerRows` na cerca de `EXPLAIN` (`scripts/explain-leituras.ts`) |
| L4 | LOW | a re-sincronia é UMA transação e agora trava as linhas SE de todas as viradas até o commit | pendência (escala: 1000 institutions — transação por institution na re-sincronia) |
| L5 | LOW | a lacuna (b) não distingue modelo — uma linha 55 da futura nfe-api esconde uma SE do ERP | **Q-F64** (= Q-NE10 da Rodada 0 da nfe-api — decide-se uma vez) |
| L6 | LOW | a cerca D-F31 vivia só na nfse-api | **CORRIGIDO**: cerca de escrita no ERP também no NÚCLEO (`fiscal-api/src/__tests__/contrato.test.ts`, com prova de que a regex não é cega) |
| L7 | LOW | domínio do modelo em dois lugares (CHECK × `ISSUER_MODELS`) e versões diferentes do núcleo por serviço | pendência (o boot confere a versão do núcleo × migrations aplicadas) |
| L8 | LOW | o produto JÁ exige MariaDB (002/003 usam `ADD COLUMN IF NOT EXISTS`); Galera multi-primário não é detectado | pendência da F3 (escrever "MariaDB ≥ 10.3, primário único" e conferir na SaveInCloud) |
| L9 | LOW | o ato usa a credencial do DONO com os mesmos nomes de variável do serviço; o boot não confere que o serviço só LÊ o ERP | pendência (assert de GRANT no boot; variáveis próprias do ato) |

**Q-F63 — Fechar o REVIVE da habilitação SE aposentada pelo ato (M1)?** (a) **portar ao setes-api AGORA (molde D-F43) a
guarda: o PUT da SE recusa (409) reviver linha `deleted='S'` com `dps_last_number > 0`** — vira pré-condição do ato (rollback
para versão anterior proibido por procedimento) · (b) só procedimento (rollback proibido; re-sincronia detecta) · (c) a F2a
remove as rotas `/api/establishment/issuer` antes do ato. *(Rec.: (a) — uma guarda fecha por construção para toda versão que a
contenha; revê o "sem mudar código do setes-api" da D-F44.)*

**Q-F64 — Lacuna (b) olha a LINHA SE?** (a) **sim: "sem linha SE no `fiscal_api` + SE no ERP", no predicado e na re-sincronia**;
o "ato por institution" da D-F39 fica para réplica · (b) como está + conhecimento negativo estendido à nfe-api · (c) cerca
inteira por modelo. *(Rec.: (a), com o guardião; o resto da cerca por família = Q-NE10.)*

**Provas depois das correções**: `fiscal-api` 45/45 · `nfse-api` 149/149 unit (131 ao vivo pulados) · `setes-api`
cancelamento/autoridade 58/58 · typecheck limpo nos três. **Gate ADVERSARIAL do delta: pendente** — os ataques ao vivo dependem
do A1 vigente na réplica (hoje 20/51 falham pelo certificado) e, pela D-F53, do GRANT com o "vai".

### 19.3 Rodada 7 DECIDIDA (Valdo 2026-10-10: "siga as recomendações e rode o gate adversarial") — D-F56/D-F57 executadas

| Decisão | Execução | Prova |
|---|---|---|
| **D-F56** (= Q-F63 (a)) | setes-api: peça `lockIssuerHistory` (`@shared/fiscal-issuer` — história da linha SE travada pela PK, 1ª instrução da transação: `deleted` + `dps_last_number`); `saveIssuer` recusa reviver SE excluída COM numeração (409 `FISCAL_ISSUER_RETIRED`); **`removeIssuer` recusa excluir SE com numeração (409 `FISCAL_ISSUER_HAS_HISTORY`) — assunção A15 (contestável): fechar só o revive deixaria sem volta uma exclusão por engano no dual-run (a emissão da empresa pararia); com as duas guardas, `deleted='S'` + numeração só nasce do ATO da virada**. A linha travada é a MESMA que o ato trava primeiro (PK) — sem ABBA. SE sem numeração e o 55 seguem livres | `fiscal-issuer.test.ts` +3 (24/24) |
| **D-F57** (= Q-F64 (a)) | núcleo: `lockIssuerRows`/`issuerRowsState` devolvem `serviceRows` (linhas SE) na MESMA leitura; `assertEmitterWritable` e `emissionStillInErp` decidem a lacuna (b) pela LINHA SE; `resyncAll` decide réplica × congelada pela LINHA SE (uma 55/65 virada não congela nem esconde a SE). O resto da cerca por família (55/65 independentes da SE) = Q-NE10 → D-NE10, executada na onda NE-1 | `cofre.test.ts` (+4 asserções: 55 virada + SE no ERP = ainda do ERP); fiscal-api 45/45 · nfse-api 149/149; `dist/` do núcleo reconstruído; `migrate:setes --dry-run` sem mudança para a Setes |

**D-F53 — GRANT EXECUTADO ("vai" do Valdo, 2026-10-10)**: `GRANT ALL PRIVILEGES ON fiscal\_api\_adv%.* TO 'fiscal_api'` nos
quatro hosts do usuário (localhost, 127.0.0.1, ::1, %) — padrão = o que o validador do harness aceita (`^fiscal_api_adv[a-z0-9_]*$`,
inclui `fiscal_api_adv4`/`fiscal_api_advr6`; o `adv\_%` da recomendação original não os cobria). Achado: o `fiscal_api@%` já tinha
`fiscal\_api\_adv\_%` (origem não registrada — subconjunto, mantido) e as conexões locais usam o `@localhost`, que NÃO tinha nada.
Provado com o próprio usuário: cria/escreve/apaga a cópia; `UPDATE setes_setes…` → ER_TABLEACCESS_DENIED_ERROR; banco fora do
padrão → ER_DBACCESS_DENIED_ERROR. Documentado em `nfse-api/ops/grants.sql` item 5 (só dev). **Pendente da D-F53: o HARNESS**
(`live-harness.ts`) passar a atacar com o `fiscal_api` — o usuário do setes-api só cria/apaga a cópia; o ENSAIO do ato (`--cutover`
sem `--vai`) e qualquer preparação que hoje escreva no ERP real precisam de credencial separada e explícita (inventariar antes de
trocar; feito depois do gate adversarial, que usa o harness agora).

**Gate ADVERSARIAL do delta inteiro** (D-F55, M2, M3, L1, L2, L6, D-F56, D-F57): **0.76 ✅** — §19.4.

### 19.4 Gate ADVERSARIAL do delta (2026-10-10) — **0.76 ✅**, sem HIGH/CRITICAL · correções · harness D-F53 · OS de teste (D-F54)

**Gate** (agente, só cópias descartáveis `fiscal_api_adv_r11`, nenhum `--vai`, fisco falso; CHECKSUM do real e do ERP iguais):
refutados com prova — 6 cancelamentos simultâneos = 1 pedido ao fisco; voz C + A1 apagado = ok idempotente (M2); 8 rodadas
cancelar × DELETE do A1 × PUT/DELETE da habilitação sem K órfão, 500, 1213 ou 1205; L1 (passo 5 pela PK — a forma antiga dá
1213); D-F57 coerente em 22 estados (travante × contagem × predicado × guarda); ato sem `--vai` = ensaio; "obrigação" não fura a
licença (transmissão nova, tentativa excluída, outra institution). Achados (conferidos no código):

| Id | Sev. | Achado | Destino |
|---|---|---|---|
| ADV-R8-01 | MEDIUM | o ATO aposenta a SE com `dps_last_number = 0` (cliente que nunca emitiu pelo ERP) — fica igual a "SE excluída sem história" e o PUT do setes-api a REVIVE: o setes-api cunharia nDPS 1, 2… na mesma série que a nfse-api já usa (mesmo Id de DPS em duas notas). Precondição = a do M1 (rotas fiscais do setes-api presentes depois do ato) | **Q-F65** |
| ADV-R8-02 | LOW | tentativa EM VOO sem NFS-e no fisco não fecha (F) quando o ramo saiu do contrato: só a transmissão (passo 0b) grava o F, e a licença barra a transmissão (provado ao vivo) | **Q-F66** |
| ADV-R8-03 | LOW | argumento repetido / id não canônico (`--cutover 1 --cutover abc`, `0x1`) viravam o ato da institution 1 | **CORRIGIDO** (repetido falha; id `^[1-9][0-9]{0,9}$`) |
| ADV-R8-04 | LOW | `npm run migrate:setes --dry-run` SEM o `--`: o npm engolia a flag e a re-sincronia GRAVAVA | **CORRIGIDO** (`npmSwallowedFlags` — flag deste script em `npm_config_*` = recusa) |
| ADV-R8-05 | LOW | obrigação da institution sem `terminal = 0` (a da nota tinha) | **CORRIGIDO** |
| ADV-R8-06 | LOW | 12 formas de escrita qualificada passavam pela cerca D-F31 do núcleo | **CORRIGIDO**: peça de teste `fiscal-api/src/__tests__/fence.ts` — LISTA BRANCA (alvo de escrita = nome simples de tabela), maiúsc./minúsc., modificadores, DDL, UPDATE…JOIN, `??`; comentários tirados pelo COMPILADOR (string com `//` intacta) |
| ADV-R8-07 | LOW | U+FFFE/U+FFFF, surrogate solto (inclusive o do corte em 255 no meio de emoji) e largura zero chegavam ao xMotivo assinado | **CORRIGIDO** nas duas `normalizeCancelMotive` (setes-api e nfse-api) |
| ADV-R8-08 | LOW | `--cutover` no estado "55 virada + SE só no ERP" falhava "já VIRADA" (passo 2 contava qualquer linha) | **CORRIGIDO** (passo 2 pela LINHA SE, como a re-sincronia — D-F57) |

**Q-F65 — A SE do ERP fica imutável (nem revive nem exclusão) durante o dual-run, qualquer que seja o contador?** (a) **sim — a
guarda da D-F56 deixa de olhar `dps_last_number`: com a nfse-api no produto, a SE do ERP só muda pelo ATO** · (b) o ATO grava uma
marca na linha aposentada (ex.: `tb_user_id` nulo + `updated_at` do ato) e a guarda olha a marca · (c) como está (a precondição é a
mesma do M1 — rotas fiscais do setes-api presentes depois do ato). *(Rec. do gate: (a) — fecha por construção; custo: um admin que
quiser trocar a SE de um cliente sem emissão no dual-run passa pelo ato ou por SQL.)*

**Q-F66 — Quem fecha a tentativa EM VOO sem NFS-e quando o ramo saiu do contrato?** (a) **a CONSULTA (refresh) fecha com F "envio
interrompido" pela MESMA regra E2404 que a transmissão usa no passo 0b** — consulta é obrigação já assumida (D-F55) · (b) liberar só o
passo 0b da transmissão para ramo não contratado · (c) como está (fica "em andamento" até recontratar). *(Rec. do gate: (a).)*

**Provas depois das correções**: fiscal-api 70/70 · nfse-api 160 unit · setes-api suítes tocadas 90/90 (gate rodou a suíte inteira:
1837/1837) · ao vivo **150/150** (8 suítes; `it.failing` restantes = ADV-R8-01/Q-F65, ADV-R8-02/Q-F66 e o limite da D-F53).

**D-F53 — harness EXECUTADO**: `live-harness.ts` ataca com o usuário do SERVIÇO (`fiscal_api` do `.env` da nfse-api; recusa
subir com o dono); o DONO só cria/copia/apaga a cópia e vigia os CHECKSUMs; `env` (re-sincronia na cópia) = serviço; **`ownerEnv`
EXPLÍCITO só para o ENSAIO do ato** (`--cutover` — r4/r5/r6/r11) e para criar o banco do smoke; observação (PROCESSLIST/INNODB_TRX)
segue com o dono (o serviço não tem `PROCESS`). Prova r5 §G: pool do ataque = `fiscal_api@localhost`, sem escrita global nem em
`setes*`. **Limite fixado (`it.failing` "[D-F53 — limite]")**: o `fiscal_api` REAL é o banco do próprio serviço — ali a defesa segue
DETECÇÃO (CHECKSUM); prevenção exigiria um usuário de teste próprio (decisão nova, se quiser).

**D-F54 — OS de teste (Valdo: "utilize uma das OS abertas e não faturadas"; escolha: OS 7223, Blessing Chocolates LTDA, Curitiba,
1 item regra 2, R$ 10,00 — a Setes como tomadora foi descartada: RN 238/E0202 "prestador = tomador" no Anexo I da DPS)**:
faturada pelo setes-api (nota 6792, "6 - BOLETO", venc. 20/10, sem baixa automática nem boleto) → `smoke:adn-h --nota 7860`
(conferência OK) → `--vai` em banco descartável (`fiscal_api_smoke`, H, série 900): **o fisco de HOMOLOGAÇÃO recusou com E0116
— "A IM deve ser informada para o emitente prestador… conforme informações complementares registradas no CNC NFS-e do
município"** (o mesmo de 2026-09-28; em PRODUÇÃO é o contrário — E0120, CNC sem registro complementar → Q-N35 tirou a IM) → nota
cancelada localmente (evento C; OS 7223 de volta a 'A', trava D5 restaurada, 0 nota viva, 0 título vivo). Pipeline da nfse-api
provado contra o fisco real até a recusa de regra (envio mTLS, DPS assinado, leitura da voz R, consulta); a AUTORIZAÇÃO em H
depende da IM → **Q-F67**.

**Q-F67 — Como provar a AUTORIZAÇÃO da nfse-api em homologação, se o CNC de H exige a IM e o de P a recusa?** (a) **informar a IM
da Setes só em H**: a IM entra como FATO do emitente (`tb_company.im`, hoje NULL) e o DPS a inclui quando o ambiente da habilitação
é H (P segue sem IM — Q-N35); exige o número da IM da Setes em Curitiba · (b) aceitar a recusa E0116 como prova do pipeline em H e
deixar a 1ª autorização pela nfse-api para a VIRADA em P (com o setes-api pronto para voltar) · (c) homologar com outro emitente
que tenha IM no CNC de H. *(Rec.: (a) — é a única que prova a autorização ANTES da virada; a regra "IM por ambiente" é dado do
fisco, não preferência.)*

### 19.5 Rodada 8 (parcial) DECIDIDA e EXECUTADA (Valdo 2026-10-10: "siga as recomendações nas Q-F65 e Q-F66") — D-F58/D-F51

| Decisão | Execução | Prova |
|---|---|---|
| **D-F58** (= Q-F65 (a)) | setes-api `saveIssuer`: SE EXCLUÍDA não revive, qualquer que seja o contador (409 `FISCAL_ISSUER_RETIRED`); `removeIssuer`: a SE não se exclui pelo ERP (409 `FISCAL_ISSUER_CUTOVER_ONLY` — o código `FISCAL_ISSUER_HAS_HISTORY` da D-F56 foi RENOMEADO, nunca publicado); a história da linha segue sendo a 1ª trava (a mesma do ato); a guarda de "transmissão viva" no DELETE da SE ficou inalcançável e SAIU; SE nova (sem linha) e 55/65 seguem livres | `fiscal-issuer.test.ts` + `adversarial-r8-delta-fiscal.test.ts` (ADV-R8-01 virou `it`) — 31/31 |
| **D-F51** (= Q-F66 (a); era a D-F52 desta máquina — na reconciliação ficou a implementação da 3ª sessão, `recordInterruptedFailure`, mesma regra) | nfse-api: peça `closeInterruptedSend` — UMA regra para os dois caminhos (passo 0b da transmissão e a CONSULTA): reserva sem voz ≥ `IN_FLIGHT_MINUTES` + fisco sem NFS-e para o Id (E2404) = F "envio interrompido"; em voo recente a consulta segue só marcando `last_queried_at`. Efeito colateral desejado: a PASSADA do rodízio também conclui a interrompida | `transmission.test.ts` +1; ao vivo r8 A2 (ramo fora do contrato: a consulta conclui com F, cancelamento → 409 `FISCAL_NOT_AUTHORIZED`, nada declarado ao fisco); ao vivo 150/150 |

Q-F67 (IM só em H) segue aberta — espera o número da IM da Setes.

### 19.6 D-F59 (= Q-F67 (a), Valdo 2026-10-10: IM "01 06 501.367-7… pode seguir") — executada; o CNC de H ainda recusa

**Risco achado ANTES de gravar a IM**: os dois montadores de DPS (setes-api `branches/service.ts` e nfse-api
`facts/service-facts.ts`) mandavam a IM do prestador SEMPRE que `tb_company.im` existisse — a Q-N35 ("sem IM") era cumprida só
pelo campo vazio. Gravar a IM primeiro faria a PRODUÇÃO da Setes (setes-api, habilitação P) receber E0120. Ordem seguida:
(1) código nos dois montadores — a IM do PRESTADOR entra no DPS só quando o ambiente da habilitação é **H** (a do tomador não
muda) + testes "P sai sem `<IM>`" nos dois (setes-api `invoice-transmission.test.ts` 33/33 · nfse-api `transmission.test.ts`
44/44); o setes-api estava PARADO (nenhuma emissão em voo) e subiu já com a regra; (2) **IM gravada**:
`setes_central.tb_company.im = '01065013677'` (id 1, CNPJ 07742094000113 — dígitos, sem máscara; a linha estava NULL).

**Smoke em H, 2ª vez** (OS 7223 refaturada — nota 6792 de novo, nº reaproveitado (D3/D4); DPS evidência em
`nfse-api/storage-smoke/2026-10-10T20-10-08-035Z`): o DPS levou `<prest><CNPJ>07742094000113</CNPJ><IM>01065013677</IM>…` com
`tpAmb 2` e **o fisco recusou de novo com E0116**. Pela RN 198 do Anexo I, a E0116 vale também quando a IM informada **não
identifica** o registro complementar no CNC (CNPJ + `cLocEmi` + IM): o CNC de HOMOLOGAÇÃO tem um registro complementar da Setes
em Curitiba, mas com a IM em OUTRA forma (sem o DV? com máscara?) ou outro número. A API do contribuinte não consulta o CNC
(`parametros_municipais` só traz convênio/alíquotas/retenções/benefícios). Nota cancelada localmente de novo (vida E,C,E,C; OS
7223 em 'A', trava D5, 0 título vivo). **Não** se tentaram formatos às cegas contra o fisco.

**Q-F62 — Qual é a IM que o CNC de HOMOLOGAÇÃO tem para a Setes em Curitiba?** O Valdo confere no Emissor Nacional
(produção restrita, entrando com o e-CNPJ) o registro complementar (cadastro → IM) e diz a forma exata · alternativa: tentar 2–3
formas (sem DV `0106501367`, com máscara `01.06.501.367-7`) em H, uma por smoke. *(Rec.: conferir no Emissor Nacional — o valor
gravado no cadastro é FATO e não pode ser chutado; se a forma de H for diferente da real, decidir se o DPS adapta ou se o
município corrige o CNC.)*

### 19.7 Pesquisa aprofundada — IM × CNC de Curitiba na PRODUÇÃO RESTRITA (Valdo 2026-10-10: "procure na internet… para resolvermos de vez")

**O que a regra diz** (Anexo I, RN 198 / E0116): havendo registro complementar no CNC para CNPJ + `cLocEmi`, a DPS tem de levar a
IM **que identifica unicamente** esse registro — IM ausente OU que não casa = E0116. Sem registro complementar = E0120 (RN 200).

**Fatos achados**
- Produção de Curitiba: DANFSe real (mar/2026, CNPJ 40.560.449/0001-29, Curitiba) com "Inscrição Municipal: -" — Curitiba NÃO
  carrega registro complementar no CNC de PRODUÇÃO (coerente com a nossa E0120 → Q-N35).
- Produção RESTRITA de Curitiba TEM registro complementar da Setes (E0116 sem IM). Nem `01065013677` (11 dígitos — o número do
  alvará "01 06 501.367-7") nem `5013677` (forma da ajuda do Cadastro Sincronizado da Receita: em Curitiba "preencher com os 7
  (sete) últimos dígitos incluindo o dígito verificador") identificaram o registro — as duas recusadas com E0116 em 2026-10-10
  (evidência: `nfse-api/storage-smoke/2026-10-10T20-10-08-035Z` e `…T20-19-53-407Z`).
- Relatos de integradores em Curitiba (fórum ACBr, dez/2025–jan/2026): zeros à esquerda NÃO resolvem ("Fui testando colocando um
  zero de cada vez"); "aqui está aprovando com 8 dígitos"; a solução confirmada: **"entra pelo emissor nacional e simula o
  preenchimento de uma nfse, após selecionar a competência vai ter um campo 'indicador municipal', essa é a inscrição que vc vai
  passar"**; outro resolveu porque "cadastrou no portal nacional o CNPJ e IM". Em Manaus a forma aceita foi 15 dígitos com zeros.
  Na Nuvem Fiscal, um caso de Curitiba concluiu que a homologação "não tem as empresas (ou a IM enviada)".
- O manual de Curitiba para o Emissor Nacional: escolhido o município emissor, "o sistema automaticamente preencherá o Indicador
  Municipal (inscrição municipal- IMU)" — o valor vem do CNC.
- A API do CNC (`distribCNC`/`cncUnico`, manual "Municípios CNC API") é de MUNICÍPIO — o contribuinte não lê o próprio registro
  complementar por API. A API de parâmetros municipais não traz IM.

**Conclusão**: a IM do CNC de produção restrita NÃO é derivável do número do alvará — a única fonte confiável é o campo
"Indicador Municipal" do Emissor Nacional de produção restrita (https://www.producaorestrita.nfse.gov.br/EmissorNacional/) com o
e-CNPJ da Setes. **Não se chutam mais formas contra o fisco.** O cadastro voltou à IM informada pelo Valdo (`01065013677`).

**Q-F62 (refinada) — o Valdo lê o "Indicador Municipal" no Emissor Nacional de produção restrita.** Conforme o valor: (a) se for
uma forma do MESMO número (ex.: só a parte `501.367-7`, ou com zeros) → a forma vai ao cadastro e vale para H; (b) se for número
DIFERENTE (dado de teste da prefeitura) → a IM de homologação vira dado PRÓPRIO da habilitação H (não do emitente), porque P
segue sem IM e o cadastro real não pode carregar dado de teste; (c) se o campo vier VAZIO → o CNC de H está incoerente; pedir à
Prefeitura de Curitiba (nif@curitiba.pr.gov.br) o ajuste do registro complementar de homologação.

Fontes: ajuda do Cadastro Sincronizado (Receita) — www38.receita.fazenda.gov.br/cadsincnac/…/Numero_da_Inscricao_Municipal.htm ·
fórum ACBr tópicos 85976, 88679, 89172 · manual Curitiba mid.curitiba.pr.gov.br/2025/00461932.pdf · Nuvem Fiscal tópicos 4324,
4959 (só pelos resumos — o site barra leitura automática) · gov.br/nfse "manual-municipios-cnc-api" v1.2 · pynfse-nacional (GitHub).

### 19.8 Teste em PRODUÇÃO (Valdo 2026-10-10: "faça a emissão em produção e depois o teste de cancelamento com o motivo teste") — ponto de retomada daquela sessão (SUBSTITUÍDO pelo §20)

**Emissão e cancelamento em PRODUÇÃO pelo setes-api** (caminho de produção até a virada; tomador escolhido pelo Valdo: OS 7223,
Blessing Chocolates LTDA, R$ 10,00): faturada (nota 6792) → `POST /api/billing/transmit` → **NFS-e nº 706 AUTORIZADA** (chave
`41069022207742094000113000000000070626100245979187`, DPS nº 4 série 1, dhProc 2026-10-10 17:23:21 UTC, SEM `<IM>` — D-F59 em P)
→ 1º `POST /api/billing/fiscal/cancel` com motivo "teste" **RECUSADO 400 sem detalhe**.

**Achado de PRODUÇÃO (corrigido na sessão)**: o motivo curto ganhava o complemento `" — Cancelamento solicitado pelo emissor"` com o
TRAVESSÃO U+2014 — fora do `TSString` do XSD (`[!-ÿ]{1}[ -ÿ]{0,}[!-ÿ]{1}`, só U+0020–U+00FF) → o fisco recusava o evento pelo esquema.
Valia para TODO motivo < 15 caracteres e, por tabela, para qualquer texto livre do DPS com caractere acima de U+00FF (travessão, aspas
curvas, emoji). Correção nos DOIS projetos (setes-api `tax-authority/dps-builder.ts` + `branches/service.ts`; nfse-api
`authority/dps-builder.ts` + `nfse/transmission.ts`): peça `toTsString` (tipografia → ASCII, resto acima de U+00FF sai) dentro do
`text()` de todo campo do DPS/evento e no `normalizeCancelMotive` (antes do piso de 15); complemento com hífen ASCII. Testes:
`ts-string.test.ts` nos dois + 4 expectativas que fixavam o travessão + `onda3-adversarial (21)` (o texto com "—" e "日本" não "volta
igual" — o fisco o recusaria). setes-api 117/117 nas suítes tocadas · nfse-api 164 unit.
→ 2º `fiscal/cancel` "teste" (motivo enviado: `teste - Cancelamento solicitado pelo emissor`) **ACEITO pelo fisco de produção** (voz C);
o setes-api aplicou o C LOCAL no mesmo ato (D3/D4): OS 7223 = **'C' para sempre** (nota 6792 fica registrada como cancelada; 0 título
vivo; vida da nota `…7:E,8:C`). Réplica re-sincronizada (`migrate:setes`, sem `--cutover`: +1 DPS, +1 tentativa, +2 vozes A/C, XML ok).
A **1ª tentativa de cancelamento em produção** desta fase passou a ter prova real (a 704 de 2026-09-29 tinha motivo ≥ 15).

**Dados de produção tocados nesta sessão (para auditoria)**: `setes_central.tb_company.im` da Setes = `01065013677` (era NULL;
testado `5013677` e revertido); OS 7223 (pedido 7860): faturada/cancelada 3× em H (nota pendente, nº 6792 reaproveitado) e 1× em P
(NFS-e 706 autorizada + cancelada → OS 'C'); contador `dps_last_number` da SE do ERP 3 → 4; `fiscal_api` réplica em dia.

#### Ponto de retomada daquela sessão (histórico — substituído pelo §20)

**Abertas para o Valdo**: **Q-F62** — ler o "Indicador Municipal" no Emissor Nacional de PRODUÇÃO RESTRITA
(https://www.producaorestrita.nfse.gov.br/EmissorNacional/, e-CNPJ, emissão completa → Prestador → município Curitiba →
competência) e informar o valor exato (§19.7 — a forma não é derivável). Depois: ajustar conforme o caso (a)/(b)/(c) e refazer o
smoke em H com uma OS NOVA (a 7223 agora é 'C'; candidatas do mesmo perfil — Curitiba, regra 2, R$ 10: **OS 7226 Autophox**, 7222).

**Nada foi commitado nesta sessão** (depois: publicado no branch `sessao-2026-10-10` e reconciliado no `main` — §20) (o Valdo pediu "salve tudo" — arquivos no disco + Infra-IA/memória). A commitar quando ele
pedir, SÓ os caminhos desta sessão (há uma SESSÃO PARALELA mexendo na Infra-IA — ver abaixo):
- **setes-api**: `establishment.issuer.service.ts`, `error-codes.ts`, `fiscal-issuer.repository.ts`, `branches/service.ts`,
  `tax-authority/dps-builder.ts`, testes `fiscal-issuer`, `invoice-transmission`, `onda3-adversarial`, novos `adversarial-r8-delta-fiscal`,
  `cancel-motive-control`, `ts-string`.
- **nfse-api**: `CLAUDE.md`, `ops/grants.sql`, `scripts/migrate-from-setes-api.ts`, `src/authority/dps-builder.ts`,
  `src/facts/service-facts.ts`, `src/modules/guards.ts`, `src/modules/nfse/nfse.routes.ts`, `src/nfse/repository.ts`,
  `src/nfse/transmission.ts`, `src/__tests__/live-harness.ts` + testes (app, transmission, adversarial f1/r4/r5/r6/r7 live e r5 unit,
  novos r8 live/unit, `migrate-args`, `ts-string`).
- **fiscal-api**: `establishment.repository.ts`, `establishment.ts`, testes `cofre`, `contrato`, novos `adversarial-r8`, `fence.ts`.
  (`dist/` reconstruído depois da D-F57 — `npm run build` de novo se o núcleo mudar.)
- **nfe-api**: `CLAUDE.md`.
- **Infra-IA** (desta sessão): `INDICE_CENTRAL.md`, `fiscal-api/INDEX.md`, `nfe-api/INDEX.md`, `nfse-api/INDEX.md`,
  `prompts/prompt_apis_fiscais_isoladas.md`, `prompts/prompt_onda_nfe_sefaz.md`, `setes-api/integracoes/nfse-adn/README.md`.
  ⚠️ **NÃO são desta sessão** (sessão paralela — provavelmente a fase IBS/CBS): `prompts/prompt_fase_ibs_cbs.md` (novo — a D-NE4
  pedia esse prompt), `prompts/prompt_onda3_nfse_adn.md`, `prompts/prompt_fase_faturamento_financeiro.md`,
  `prompts/rascunho_engine_modernizacao.md`, `nfe-api/referencia-acbr/`, `setes-api/integracoes/nfse-adn/legislacao-ibs-cbs/`,
  `…/rtc-2026-10/`. Conferir com o Valdo antes de commitá-los.
- Banco: nada de DDL nesta sessão; GRANT do dev (D-F53) já aplicado; `sql/` sem mudança.

**Provas no fim da sessão**: fiscal-api 70/70 · nfse-api 164 unit + **150/150 ao vivo** (com o usuário do serviço) · setes-api
1837/1837 (suíte inteira antes das correções do TSString; suítes tocadas depois 117/117 — rodar a inteira de novo ao retomar).

**Próximos passos (ordem)**: (1) Q-F62 → smoke em H com OS nova; (2) commit (só os caminhos acima) com o "vai"; (3) gate do delta do
TSString/D-F59 (socrático + adversarial — mudança em produção); (4) D-NE: NE-0 (levantamento oficial da SEFAZ) e NE-1 (núcleo
generalizado ANTES da F2a); (5) F2a/F2b; (6) conferir com a sessão paralela o prompt IBS/CBS (D-NE4).

## 20. Reconciliação dos dois históricos (2026-10-10)

**Escopo**: misto (o método — reconciliar dois históricos de decisão por SIGNIFICADO, não por número — é portável; o conteúdo é
do caso Setes)

### 20.1 O que aconteceu

A 3ª sessão de 2026-10-04 rodou num OUTRO clone (nuvem, só testes unitários) e publicou no `main` de nfse-api, fiscal-api e
Infra-IA as decisões D-F46…D-F53 (§17.5/§18, §8.R7). Esta máquina partiu do `main` ANTERIOR a ela e, em 2026-10-10, numerou
D-F46…D-F53 com OUTROS significados (§19); publicou no branch `sessao-2026-10-10` dos cinco repositórios sem tocar o `main`.
Pedido do Valdo (2026-10-10): "reconciliando o branch `sessao-2026-10-10` com o `origin/main` … me traga as decisões
conflitantes D-F46…D-F53 para eu escolher e depois siga pela Q-F62".

**Lição de método (conhecimento negativo)**: número de decisão NÃO é identidade — a comparação foi por significado. Das oito
colisões, só DUAS eram conflito de verdade; duas eram a MESMA decisão com número diferente; quatro eram complementares.

### 20.2 Tabela de equivalência (numeração unificada)

| Esta máquina (2026-10-10) | Unificada | Situação |
|---|---|---|
| D-F46 = Q-F51 (a) — OS de teste do smoke em H | **D-F54** | vale |
| D-F47 = Q-F52 (a) — licença barra só a transmissão nova | **D-F55** | **REVOGADA** — vale a D-F46 (b) da 3ª sessão |
| D-F48 = Q-F53 (a) — ataques com o usuário de SELECT mínimo | **= D-F53** | mesma decisão; execução unificada (GRANT nos 4 hosts do dev) |
| D-F49 = Q-F57 → **Q-F63** — guarda da SE com numeração no setes-api | **D-F56** | vale (critério substituído pela D-F58); convive com a D-F50 |
| D-F50 = Q-F58 → **Q-F64** — lacuna (b) pela LINHA SE | **D-F57** | vale |
| D-F51 = Q-F59 → **Q-F65** — SE do ERP imutável no dual-run | **D-F58** | vale |
| D-F52 = Q-F60 → **Q-F66** — a consulta fecha a interrompida | **= D-F51** | mesma decisão; fica a implementação da 3ª sessão |
| D-F53 = Q-F61 → **Q-F67** — IM do prestador só em H | **D-F59** | vale |
| Q-F62 — IM do CNC de H | **Q-F62** | aberta (número mantido) |
| §17.5…§17.12 · §8.R7/§8.R8 | §19.1…§19.8 · §8.R8/§8.R9 | — |
| gate adversarial "r8" (`adversarial-f1r8[.live]`, `fiscal_api_adv_r8`) | **r11** (`adversarial-f1r11[.live]`, `fiscal_api_adv_r11`) | ids ADV-R8-xx mantidos |

Commits desta máquina continuam no branch `sessao-2026-10-10` com a numeração ORIGINAL (história); o `main` tem a unificada.

### 20.3 Decisões do Valdo na reconciliação (2026-10-10)

1. **Q-F52 → (b) bloqueio total** (opção recomendada na rodada de reconciliação: era a resposta EXPLÍCITA de 2026-10-04 e não
   havia fato novo). Ramo fora do contrato = 403 para todos em transmitir, consultar, reconferir, cancelar e ler; a passada do
   admin só fecha as tentativas JÁ VIVAS (D-F47); a obrigação fiscal já assumida é do cliente fora do produto (portal do ADN).
   A D-F55 vira registro revogado; o código dela saiu.
2. **Revive da SE aposentada → os DOIS fechamentos**: D-F50 (o ato `--vai` exige `f2a_fiscal_passivo` em `_migrations`) +
   D-F56/D-F58 (guarda no setes-api, já em uso). Contrato para a F2a: a migration da F2a tem o nome FIXO
   `NNN_f2a_fiscal_passivo.sql` (se a F2a sair em mais de um arquivo, este nome vai no último).
3. Publicar no `main` com os testes verdes ("Sim, push no main").

### 20.4 Execução da reconciliação

| Repo | O que foi feito |
|---|---|
| fiscal-api | merge sem conflito (`adversarial-f1r8` da nuvem + `adversarial-r8`/`fence.ts` daqui) + renumeração D-F50→D-F57; `dist/` reconstruído |
| nfse-api | 9 conflitos. **guards/rotas/repositório = 3ª sessão** (passScope; D-F55 fora). **transmission.ts** = `recordInterruptedFailure` da 3ª sessão + `normalizeCancelMotive` com TSString (correção de produção daqui). **Script do ato** = junção: re-sincronia por institution (D-F48) + `[r8-resync-55]` + conferência da F2a (D-F50) + ensaio por padrão e `--vai` (M3) + passo 5 pela PK (L1) + decisão pela linha SE (D-F57/ADV-R8-08); as funções puras de argumento (ADV-R8-03/04) foram para `scripts/migrate-args.ts` (os testes da 3ª sessão carregam o script esperando o `main()`; os daqui importam as funções sem dispará-lo). **Harness** = o daqui (ataque com o serviço; o dono só no ENSAIO por `ownerEnv`) — o da nuvem passava o dono a todo processo filho. **`ops/grants.sql`**: seção 1b com `fiscal\_api\_adv%` (cobre adv4/advr6/adv_r11) + item 5 só dev (hosts locais). Gate r8 daqui → **r11**, seção A reescrita para provar a (b) AO VIVO |
| setes-api | renumeração (D-F49/51/53 → D-F56/58/59) commitada SÓ nos 7 arquivos desta frente, pelo índice (o working copy tem trabalho NÃO commitado da sessão paralela de IBS/CBS — `error-codes.ts` inclusive — que ficou intacto) |
| nfe-api | `CLAUDE.md` → D-F1…D-F59 |
| Infra-IA | este documento (§7, §8.R5/R8/R9, §19, §20), INDICE_CENTRAL, `nfse-api/INDEX.md`, `prompt_onda_nfe_sefaz.md`, README da integração ADN — feito numa worktree à parte: o working copy da Infra-IA tem trabalho NÃO commitado da sessão paralela (ACBr/IBS-CBS) |

**Achados ao rodar ao vivo pela 1ª vez o código da 3ª sessão** (nenhum de produção):
- r4: o teste da D-F37 esperava 403 na passada do admin sem nada contratado — a D-F47 mudou isso de propósito (a passada roda
  só sobre as vivas; aqui nenhuma) e a nuvem não podia rodar o teste. Ajustado (passada 200, `checked` 0).
- Testes de script da 3ª sessão chamavam o "ato real" sem `--vai` — com o M3 isso virou ensaio; passaram a usar `--vai`.
- r11 §C extraía o SQL do passo 2 do script — a refatoração `apiIssuerRows` da 3ª sessão o moveu; extração ajustada.
- r11 §D6: o fixture fixava o contador da SE em 3; a NFS-e 706 de produção (§19.8) levou o ERP a 4 e a re-sincronia acusou
  — corretamente — "dual-write". O fixture passou a ler o contador real.
- **f1: "o ERP mudou durante o ataque"** — a sessão paralela aplicou a migration `ibscbs_service_classification` (066) no
  `setes_setes` às 18:07:36 (local), no meio da suíte; o `tb_invoice_service` foi reconstruído (colunas
  `classification_code`, `place_indicator_code`, `nbs`). O harness acusou certo; a re-rodada passou. **Lição**: suíte ao vivo
  e migration de outra frente no MESMO dev se atropelam — combinar a janela quando houver sessão paralela.

**Provas**: `fiscal-api` 78/78 · `nfse-api` 240 unit + **150/150 ao vivo** (8 suítes; a 1ª rodada ao vivo do código da 3ª
sessão) · `explain:leituras` OK (rodízio 3,0 ms; o `NOT EXISTS` da D-F52 por `idx_invoice_service_transmission_life`; precisa
de `EXPLAIN_DB_USER` — o usuário do serviço não tem EXPLAIN nas views) · `setes-api` suítes tocadas 68/68 · typecheck limpo.

### 20.5 Próximos passos (ordem)

1. ~~**Q-F62**~~ — FEITO (D-F60, §21): o Valdo leu o "Indicador Municipal" no Emissor Nacional de produção restrita; aplicado (a) do
   §8.R9 e refazer o smoke em H com uma OS NOVA (a 7223 é 'C'; candidatas: OS 7226 Autophox, 7222 — Curitiba, regra 2, R$ 10).
2. Gate do delta do TSString/D-F59 (mudança em produção) + da reconciliação (socrático + adversarial).
3. D-NE: NE-0 (levantamento oficial da SEFAZ) e NE-1 (núcleo generalizado ANTES da F2a).
4. **F2a** (setes-api passivo; migration `NNN_f2a_fiscal_passivo.sql` — D-F50) → virada → F2b. Corte da F2a: 30/11 (D-IB15).
5. Pendências da 3ª sessão que seguem: LOWs aceitos do §18 (registro para a F3/F4).

## 21. Q-F62 fechada — 1ª AUTORIZAÇÃO da nfse-api em homologação (2026-10-10) + achado na leitura de eventos (D-F61…D-F66)

**Escopo**: misto (o método — cravar ao vivo o contrato real do fisco antes de corrigir, e só em homologação — é portável; dados e
números são do caso Setes)

### 21.1 Execução (Valdo: "Q-F62 - IM: 50136779" · "vai, pode seguir com a OS 7226")

| Passo | Resultado |
|---|---|
| IM no cadastro (D-F60) | `setes_central.tb_company.im` `01065013677` → **`50136779`** (UPDATE guardado pelo valor anterior; 1 linha). ⚠️ o 1º carimbo saiu com `NOW()` numa sessão crua = horário LOCAL; refeito com `UTC_TIMESTAMP()` (PADROES §10 — script avulso no banco também segue a regra) |
| Faturamento | OS **7226** (pedido 7863, Autophox Comercial LTDA / "STRONIC", 1 × R$ 10,00, serviço 1) pelo setes-api — `POST /api/service-orders/7863/invoice` (forma 6 boleto, 1 parcela, venc. 20/10) → nota **6793**, sem baixa automática nem boleto |
| Conferência | `smoke:adn-h -- --nota 7863` → pré-condições OK (A1 até 05/10/2027, H, série 900, nada enviado) |
| **Smoke com `--vai`** | banco descartável `fiscal_api_smoke`, H, série 900, DPS com `<IM>50136779</IM>` → **NFS-e de homologação nº 2 AUTORIZADA** (chave `41069022207742094000113000000000000226101344429240`, DPS `DPS410690220774209400011300900000001791668584`) → XML + DANFSe → **cancelamento NO FISCO de H aceito** (e101101) → consulta final = voz C. Vida da tentativa A,K,C; banco descartável APAGADO; `fiscal_api` real intocado; evidência em `nfse-api/storage-smoke/2026-10-10T21-43-03-050Z` |
| Desfazer no ERP | `POST /api/billing/cancel` (nota pendente → soft delete): vida da nota E,C; **OS 7226 de volta a 'A'**; 0 nota viva, 0 título vivo |

**Provado**: o pipeline INTEIRO da nfse-api contra o fisco real em H — mTLS, DPS assinado com a IM por ambiente (D-F59),
autorização, XML/DANFSe, evento de cancelamento. A regra "IM do CNC = 8 dígitos" de Curitiba (relatos de integradores) se
confirmou: nem o nº do alvará (11 dígitos) nem os 7 últimos dígitos com DV passavam; o "Indicador Municipal" do Emissor Nacional é
a fonte.

### 21.2 Achado: a Sefin Nacional NÃO atende `GET /nfse/{chave}/eventos` (cravado ao vivo em H, `SefinNacional_1.6.0`)

O passo 2 do smoke ("consultar" a NFS-e autorizada) falhou com `FISCAL_DPS_REJECTED — Fisco rejeitou (405)`. Diagnóstico SÓ DE
LEITURA, em homologação, sobre a NFS-e de teste nº 2 (A1 do cofre do setes-api, mTLS):

| GET (base `…/SefinNacional`) | Resposta |
|---|---|
| `/nfse/{chave}` | **200** — `nfseXmlGZipB64` (a consulta da NFS-e em si funciona) |
| `/nfse/{chave}/eventos` | **405**, `Allow: POST`, `{"message":"The requested resource does not support http method 'GET'."}` — o item (b) do manual da API do contribuinte NÃO existe na Sefin |
| `/nfse/{chave}/eventos/101101` | 404 em **HTML** (página do servidor — rota inexistente) |
| `/nfse/{chave}/eventos/101101/1` | **200** — `{ dataHoraProcessamento, tipoAmbiente, versaoAplicativo, eventos: [{ chaveAcesso, tipoEvento: 101101, numeroPedidoRegistroEvento: 1, dataHoraRecebimento, arquivoXml }] }` |
| `/nfse/{chave}/eventos/105102/1`, `…/105104/1`, `…/305101/1`, `…/101101/2` | **404 com o envelope JSON da Sefin** (`dataHoraProcessamento`, `tipoAmbiente`, `versaoAplicativo`; sem `eventos`) = "esse evento não existe" |

`arquivoXml` = **base64 do TEXTO gzip+base64** (duas camadas de base64; decodificado uma vez começa com `H4sI`) → `<evento versao="1.01">`
com `infEvento Id="EVT…101101001"`, `dhProc` e `chNFSe` = a chave pedida — o `parseEventXml` + `isGeneratedEventFor` de hoje servem.

**Consequência (os DOIS adaptadores — setes-api, que é PRODUÇÃO hoje, e nfse-api — têm o mesmo código e os mesmos hosts)**: toda
consulta de NFS-e AUTORIZADA falha — o rodízio de 24 h das autorizadas (D-N21), o "consultar" da tela "No fisco" e a reconsulta da
nfse-api —, e um cancelamento feito FORA do produto (portal do ADN, de ofício) nunca é visto. Nenhuma voz espúria é gravada (a
consulta falha antes de escrever — conferido na linha do tempo do smoke), mas a mensagem engana: um 405 de rota sai como
"Fisco rejeitou" com código de DPS rejeitado. Decisão aberta: **Q-F68** (§8.R10).

### 21.3 Próximos passos (ordem)

1. ~~**Q-F68**~~ — FEITO (D-F61, §21.4; Rodada 11 no §21.5).
2. Gate do delta (TSString/D-F59 + reconciliação + correção da Q-F68), socrático + adversarial.
3. D-NE: NE-0 (levantamento oficial da SEFAZ) e NE-1 (núcleo generalizado ANTES da F2a).
4. **F2a** (setes-api passivo; migration `NNN_f2a_fiscal_passivo.sql` — D-F50) → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.4 D-F61 executada (= Q-F68 (a), Valdo 2026-10-10: "(a) Nos dois, já")

| O quê | Onde | Prova |
|---|---|---|
| Leitura do cancelamento por TIPO + SEQUÊNCIA: para cada código (101101, 105102, 105104, 305101) `GET /nfse/{chave}/eventos/{tipo}/1`, parando no 1º que existir; 404 só com o envelope JSON da Sefin = "sem esse evento" (`isSefinNoEventEnvelope`); 404 em HTML/fora do envelope = 502 ambíguo; 200 sem `eventos[]` = 502; `arquivoXml` decodificado em 2 camadas, tolerando 1 camada e XML cru (`decodeEventFile`); lista que não se lê = `unknown`; evento de OUTRA chave/ecoado = não é voz sobre esta (R2-2 (d), semântica de antes — segue para o próximo código e fica `authorized`) | `setes-api/src/shared/tax-authority/adapters/adn.ts` e `nfse-api/src/authority/adn.ts` (`cancelEventXmls`, laço do `queryNfse`) — mesmo texto nos dois (porte D-F43) | `tax-authority.test.ts` (setes-api) e `authority.test.ts` (nfse-api): +4 testes cada com as respostas CRAVADAS ao vivo; helper `sefinTypedEvents` no `onda3-adversarial-r3` traduz as listas antigas para a forma real |
| **405 deixa de ser "DPS rejeitado"**: 405 = método inexistente na rota = contrato do adaptador → 502 `FISCAL_AUTHORITY_UNKNOWN_RESPONSE` (numa transmissão fica EM VOO e é reconciliada pelo `GET /dps`, nunca R); o 501 já caía no 5xx (503) | `setes-api/src/shared/tax-authority/https-json.ts` e `fiscal-api/src/transport/https-json.ts` | idem (+ transmit com 405 → 502; 501 → 503) |
| Sonda só de leitura do adaptador corrigido contra o fisco real | `nfse-api/scripts/probe-query.ts <chave> [H\|P]` | **H**: NFS-e de teste nº 2 → `cancelled` (dhEvento 18:43:04, motivo do smoke) · **P**: NFS-e **706** → `cancelled` (dhEvento 17:29:54, "teste - Cancelamento solicitado pelo emissor") |

**Contrato de PRODUÇÃO conferido igual ao de H** (só leitura, sobre a 706): `GET …/eventos` = 405 `Allow: POST`; `…/eventos/101101/1` = 200
(`tipoAmbiente: 1`, `SefinNacional_1.6.0`); `…/eventos/105102/1` = 404 com o envelope JSON.

**Fato do fisco (registrado, sem correção)**: o evento DEVOLVIDO pela Sefin de H traz texto com acentuação DUPLA — o pedido que
enviamos tem `ç` = `c3 a7` (conferido no XML guardado pelo smoke), o evento gerado devolve `c3 83 c2 a7` ("Ã§") com `encoding="utf-8"`.
Efeito: o motivo lido de volta pode vir com acentos estragados (cosmético; a voz C e a conferência por chave não dependem do texto).
Não se aplica heurística de reparo; se incomodar na tela, decidir à parte.

⚠️ **O setes-api do dev roda em `tsx watch`** (processo da porta 3000 = `tsx watch … src/server.ts`): toda edição em `src/` RECARREGA o
serviço que atende a produção da Setes — a D-F61 entrou no ar ao ser salva (antes do gate), junto com o trabalho NÃO commitado da
sessão paralela de IBS/CBS. Risco avaliado como baixo (o código antigo falhava em TODA consulta de autorizada; o novo falha para o lado
seguro). **Lição**: em produção o setes-api não pode rodar em modo watch — registrar na F3 (deploy) e, até lá, editar o setes-api
sabendo que é "deploy ao salvar".

**Provas**: fiscal-api 78 · nfse-api 242 unit · setes-api suítes do fisco 247 · suíte inteira do setes-api: 1920/1920 · gates do
delta (D-F61 + TSString/D-F59 + junção do script do ato): socrático 0,74 ✅ (re-gate da Rodada 11: 0,76 ✅) · adversarial 0,72 ✅ (re-gate: 0,77 ✅).

### 21.5 Gates do delta da D-F61 e Rodada 11 (Valdo 2026-10-10: "siga as recomendações" → D-F62…D-F66)

**Gates do delta (D-F61 + TSString/D-F59 + junção do script do ato), agentes que não fizeram a entrega**: socrático **0,74 ✅** ·
adversarial **0,72 ✅** — nenhum HIGH/CRITICAL; 5 MEDIUM do socrático (M1 aluguel/orçamento × 6 idas ao fisco; M2 falha de UMA rota de
evento parando a passada para sempre; M3 = DF61-01/02 do adversarial: 200 tipado que não se confere virava "autorizada" e gravava N
falso num K; M4 o C por consulta liga pela 1ª vez em produção — e o 105102; M5 quebra de contrato invisível) + LOWs (DF61-03…09,
L1…L8). Testes: `adversarial-df61-gate.test.ts` nos dois projetos.

**Rodada 11** (questões propostas pelo socrático, recomendações minhas aceitas em bloco):

| Decisão | O quê | Onde |
|---|---|---|
| **D-F62** (= Q-F69 (a)) | manter os 4 GETs tipados (o ÚNICO contrato provado ao vivo, H e P); aluguel da passada da nfse-api **90 → 210 s** (6 idas × 30 s + folga); o orçamento de 20 s do setes-api fica (estoura numa nota lenta — DF61-08 — e morre na F2a) | `nfse-api/src/nfse/transmission.ts` `REFRESH_LEASE_SECONDS` |
| **D-F63** (= Q-F70) | no GET TIPADO um 200 diz "o evento existe": o que não se confere como cancelamento GERADO desta chave (ilegível mesmo com gzip válido, outra chave, eco, outro tipo) = `unknown` (502, nada gravado — sem N falso); 200 com `eventos: []` = 502. A R2-2 (d) "segue autorizada" era da LISTA `GET /eventos`, que a Sefin não tem | os dois `adn.ts` |
| **D-F64** (= Q-F71) | cancelamento por **SUBSTITUIÇÃO (e105102)** lido por consulta: a VOZ C fica (texto "por SUBSTITUIÇÃO (e105102)"), o efeito local NÃO é automático — pendência visível, só por ação humana; a suspensão é PEGAJOSA (re-consulta contraditória não aplica sozinha) e a nota dela carrega o motivo do fisco. `NfseQuery.cancelled.eventCode` nos dois | setes-api `invoice-transmission.ts` (`recordCancelVoice`, `SUBSTITUTION_EFFECT_SUSPENDED`); nfse-api grava só a voz com o texto (o efeito é do setes-api — D-F28) |
| **D-F65** (= Q-F72) | 401/403 numa rota de EVENTO depois do 200 do GET /nfse da MESMA nota = falha DA NOTA (502 ambíguo, `logger.error` próprio): o rodízio carimba e segue; 401/403 no GET /nfse e 5xx/timeout continuam parando a passada | os dois `adn.ts` |
| **D-F66** (= Q-F73 (a)) | `toTsString` normaliza **NFC** antes do filtro; fora do Latin-1 cai na **letra-base** (Š→S, č→c; o "í" fica) e o que não tem base Latin-1 sai; o filtro Latin-1 vale para TODO texto livre do DPS/evento (escolha registrada — o fisco serializa mal fora do ASCII) | os dois `dps-builder.ts` |
| técnicos | envelope do 404 só vale no AMBIENTE perguntado (`tipoAmbiente` 1=P, 2=H) e sem `erro`/`erros`/`eventos` (L8); `cut()` — corte sem espaço final (L2/DF61-05); **405/406/415 → 502** com `logger.error` "Contrato do fisco divergente" (DF61-09/M5); rollback do ATO protegido (L6) | `adn.ts`, `dps-builder.ts`, `https-json.ts` (setes-api + núcleo), `migrate-from-setes-api.ts` |

**Re-gate do retrabalho**: socrático **0,76 ✅** · adversarial **0,77 ✅** — sem regressão (setes-api 281 nas suítes do fisco, nfse-api
260, núcleo 78). 7 LOW: corrigidos na sessão R11-02 (a nota da suspensão apagava o motivo), R11-03b (suspensão pegajosa), R11-04 (o NFC
juntava letra + marca fora do Latin-1 e o filtro apagava a LETRA — "Ševčík" → "evík"; agora "Sevcík"), R11-05 (log de erro do 200 que
não se confere; mensagem certa do 401/403 de evento); ficam R11-01, R11-03a, R11-06 (= Q-F74…Q-F76) e R11-07 (o XML do e105102 é
arquivado como `-evt101101.xml`). Testes: `adversarial-r11-gate.test.ts` nos dois projetos (`it.failing` = pendentes).

**Provas finais**: fiscal-api 78 · nfse-api 273 unit + ao vivo 150/150 (8 suítes; o r7 tinha o aluguel antigo de 90 s fixo na asserção — passou a ler a constante) · setes-api suítes do fisco 298 e suíte inteira 1920/1920 (antes
das correções R11-xx) · sondas só de leitura com o código final: H nº 2 e P **706** → `cancelled`.

⚠️ Lição de ferramenta: `jest --runInBand` do setes-api termina os testes e NÃO sai (handle aberto) — rodar com `--forceExit`.

### 21.6 Pendências e questões abertas (Rodada 12 DECIDIDA — D-F67…D-F69; execução no §21.7)

**Rodada 12 (aberta pelo re-gate) — DECIDIDA em 2026-10-10 ("siga as recomendações" → D-F67…D-F69, §21.7)**:
- ⚠️ **Q-F74 (R11-01)** — a pendência da substituição (D-F64) não tem fim: a voz C suspensa volta ao fisco a cada 15 min PARA SEMPRE
  (3 idas por passada) e aparece no lote "Transmitir pendentes" com 409. (a) **ato humano "ciência — manter a nota"** que encerra a
  pendência sem cancelar (grava o desfecho na voz) e a tira do rodízio e do lote; a tela mostra a chave da SUBSTITUTA (`chSubstituta`
  do e105102) · (b) só tirar do rodízio (fica no lote) · (c) como está. *(Rec.: (a).)*
- ⚠️ **Q-F75 (R11-06, só na F2a)** — na nfse-api a C de substituição responde `localCancelPending: true`, que pela D-F28 manda o app
  aplicar o C local sem humano. (a) **o código do evento vira FATO estruturado na voz do `fiscal_api` (coluna `event_code` — DDL no
  núcleo, guardião + revisar-ddl) e `localCancelPending` exclui a substituição** · (b) só `localCancelPending` lendo o texto da voz.
  *(Rec.: (a) — texto livre não é contrato; decidir antes da F2a.)*
- ⚠️ **Q-F76 (R11-03a)** — rota perguntada × código do XML divergentes (pedi 105102, veio um e101101 desta chave; ou o contrário).
  (a) **ambíguo, SALVO quando o XML diz substituição** (fica a marca mais restritiva — sem efeito automático) · (b) sempre ambíguo ·
  (c) vale o XML, como hoje. *(Rec.: (a).)*

**LOW registrados (sem decisão nova)**: DF61-03 (campo obrigatório esvaziado pelo TSString → recusa R do fisco em vez de 422 local) ·
DF61-04 (tamanho do XSD não conferido: bairro 62 > 60, IM 20 > 15) · DF61-07 (corrida do ambiente da IM — H lido fora, P na reserva:
E0120 → R; a retransmissão se corrige) · DF61-08 (orçamento do setes-api estoura numa nota lenta) · R11-07 (nome do XML do e105102) ·
L3/L7 do socrático (ambiente congelado só na assinatura; setes-api antigo como escritor ativo depois do ato — procedimento da virada) ·
M5 → alarme por padrão de log na F3 · **o setes-api do dev roda em `tsx watch` (deploy ao salvar) — produção não pode rodar assim (F3)**.

**Pede o Valdo**: prova ao vivo do C POR CONSULTA (M4) — cancelar uma NFS-e de H pelo Emissor Nacional (fora do produto) e ver o
rodízio achar e aplicar o efeito (101101) ou suspender (105102).

**Próximos passos (ordem)**: Q-F74…Q-F76 → D-NE: NE-0/NE-1 (núcleo generalizado ANTES da F2a) → **F2a** (setes-api passivo; migration
`NNN_f2a_fiscal_passivo.sql` — D-F50; Q-F75 antes) → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.7 Rodadas 12, 13 e 14 — a substituição (e105102) ganha fim humano (D-F67…D-F82), 2026-10-10 — ⏯ RETOMAR POR AQUI

**Rodada 12** (Valdo: "siga as recomendações" → **D-F67** (= Q-F74 (a)), **D-F68** (= Q-F75 (a)), **D-F69** (= Q-F76 (a))). O
desenho do "manter a nota" passou pelo **guardião** (parecer: a decisão humana é FATO da NOTA, não coluna da voz — a voz é do
fisco; sem coluna nova na voz: `authority_code` já é "o código cru do fisco"; o DDL da voz é da família), que abriu Q-F77…Q-F83 —
**Rodada 13** (Valdo: "Sim, siga tudo (Recomendado)" — incluindo a migration 067 aplicada no banco de PRODUÇÃO ao salvar) →
**D-F70…D-F76**. Os gates da Rodada 13 abriram Q-F84…Q-F89 — **Rodada 14** (Valdo: "siga as recomendações") → **D-F77…D-F82**.

| Onde | O quê |
|---|---|
| setes-api **067** (`067_fiscal_cancel_code_and_cancel_waiver.sql`) | backfill do código nas vozes C (marca de texto só em voz de CONSULTA → 105102; source P → 101101); MODIFY do comentário; CHECK `ck_invoice_service_transmission_event_cancel_code` (domínio só na voz C); tabela **`tb_invoice_cancel_waiver`** (PK nota × chave; motivo + autor obrigatórios; CHECK da chave 44/50; FK → `tb_invoice`). **Aplicada em PRODUÇÃO 2026-10-10 21:00** (provada antes 2× num schema descartável com o split do runner; backfill = 3 vozes C → 101101). Espelho no `sql/03` |
| nfse-api **002** (`002_cancel_event_code.sql`) | o mesmo backfill/MODIFY/CHECK na voz do `fiscal_api` (D-F70) — aplicada no dev (réplica = origem) |
| núcleo (`fiscal-api/src/voice`) | `CANCEL_EVENT_CODES`, `SUBSTITUTION_CANCEL_CODE`, `EX_OFFICIO_CANCEL_CODE`, `HUMAN_EFFECT_CANCEL_CODES`; `localCancelPending` exclui o efeito humano; `isSubstitutionCancel`/`isHumanEffectCancel`; erro `FISCAL_NFSE_SUBSTITUTED` |
| setes-api composição | `recordCancelVoice` grava o código (P = 101101), promoção de mão única (`setCancelEventCode`), voz P nunca promovida (D-F77 → 502), suspensão de 105102 e 305101; transmit: voz C vigente = SEMPRE 409 (`FISCAL_NFSE_SUBSTITUTED` / `FISCAL_EFFECT_PENDING`; em H aponta "cancele a nota"); refresh: C de efeito humano não se retenta, C P pendente retenta o efeito SEM o fisco (`retryLocalCancelEffect`), consulta humana arquiva o XML do evento que faltou (`archiveCancelEventIfMissing`, nunca no rodízio — `fromRun`); rodízio e lote excluem C de efeito humano / C vigente; tela: `substitution {substituteAccessKey, waived}` + `cancelWaiver` (só vigente — D-F81) + `pendingEffects` pelo SQL único |
| setes-api peça + rota | `@shared/invoice/invoice-cancel-waiver` (`waiveSubstitutedCancel` · `findCancelWaiver` · `findCurrentCancelWaiver`) + **`POST /api/billing/cancel-waiver`** `{orderId, reason}` (CANCELAR do ramo — D-F72; Swagger); erros `FISCAL_NFSE_SUBSTITUTED` e `INVOICE_CANCEL_WAIVER_NOT_APPLICABLE` |
| nfse-api | voz C com o código (D-F68); transmit 409 `FISCAL_NFSE_SUBSTITUTED`; tela com `substitution.substituteAccessKey`; consulta humana de C arquiva o XML que faltou (best-effort — R13-06); `migrate:setes` espelha a regra de mão única (preenche NULL, sobe para 105102) e confere o código na divergência |
| adaptadores ADN (os dois) | D-F69 (tipo perguntado × XML: ambíguo salvo 105102); L6 (bloco `<e101101>` embutido leva o código); L7 (entre os itens, o do tipo perguntado) |
| setes-app (`service_orders`) | seção "No fisco": aviso da substituição + chave da SUBSTITUTA (copiar; "indisponível" sem XML), botão **"Manter a nota"** (CANCELAR; só P — D-F80; dialog com motivo 1–255), linha "Nota mantida em … — motivo"; "Transmitir" escondido em toda voz C vigente (L4); i18n pt/en |

**Gates**: Rodada 13 — socrático **0,74 ✅** (M1 → D-F77, M2 → D-F78, M3 → D-F79; L1 → D-F81, L5 → D-F80; L2/L3/L4/L6/L7 corrigidos
na sessão) · adversarial **0,80 ✅** sem HIGH (R13-01/R13-05 corrigidos durante o gate; R13-02 backfill por texto só em voz de
consulta, R13-04 a própria chave não é a substituta, R13-06 arquivar é best-effort na nfse-api — corrigidos na sessão; **R13-03 →
Q-F90**). Testes: `adversarial-r13-gate.test.ts` nos dois serviços (o `it.failing` que fica = Q-F90) + blocos "RODADA 13/14" no
`adversarial-r11-gate.test.ts` + `invoice-cancel-waiver.test.ts`.

**Provas**: fiscal-api 80 · nfse-api 307 unit + ao vivo 150/150 · setes-api **2020/2020** (a suíte inteira; a única suíte que não
compila é WIP da sessão paralela de IBS/CBS — `ibscbs-classification.test.ts` à frente do código dela, fora deste delta) · app
**203/203**, analyze limpo. Sondas na API de produção só de recusa (409/400/404, nada gravado).

**Lições**: (1) setes-api em `tsx watch` = deploy ao salvar e a migration roda no boot sem transação — **DDL provado antes num schema
descartável, e o DDL antes do código** (falha de migration no boot = `process.exit(1)` = produção fora); (2) backfill por TEXTO livre só
vale onde o texto é nosso — o motivo digitado pelo usuário pode conter a marca (R13-02); (3) a "marca mais restritiva" deixa de ser
segura quando a marca abre uma porta MENOS restritiva (o "manter") — proveniência decide (D-F77).

### 21.8 Pendências e questões abertas (Rodada 15 DECIDIDA — D-F83…D-F85; execução no §21.9)

**Rodada 15 (aberta pelos gates da Rodada 13 — aguardam o Valdo)**:
- ⚠️ **A-F80 (confirmar)** — a letra da Q-F87 (a) dizia "a voz de H não bloqueia a transmissão em P"; executado como "em H, cancele a
  nota (cancelável localmente) e fature de novo" porque o Id do DPS é da VIDA, não do ambiente (uma tentativa em P na mesma vida
  reusaria o Id da de H — D-N3/D-N26/R3-1). *(Rec.: confirmar.)*
- ⚠️ **Q-F90 (R13-03)** — o GET tipado de `/eventos/101101/1` traz o tipo perguntado E um e105102 da mesma chave: vale a marca mais
  restritiva (D-F69), o tipo perguntado (L7 + D-F77) ou é AMBÍGUO? *(Rec.: ambíguo — 502, nenhuma marca, nenhum efeito, como a D-F63;
  forma de resposta não cravada da Sefin.)*
- **Q-F91 (R13-04, só exibição)** — validar `chSubstituta` também contra o CNPJ do emitente embutido na chave? (a igual à própria chave
  já é recusada). *(Rec.: sim, quando a chave nacional for conferível; baixo valor.)*

**LOW registrados**: os da §21.6 seguem (DF61-03/04/07/08, R11-07 — o XML do e105102 é arquivado como `-evt101101.xml`, L3/L7 do
socrático da Rodada 11, M5 → alarme na F3, `tsx watch` em produção). Novos: lista de OS sem selo "substituída — aguardando decisão"
(L4b do socrático da Rodada 13 — só se descobre abrindo a OS); ordem de travas "manter" (nota → transmissão) × rota fiscal de
cancelamento (transmissão → nota) — ciclo 1213 absorvido pelo retry (L2).

**Pede o Valdo**: prova ao vivo do C POR CONSULTA (M4 da Rodada 11) — cancelar uma NFS-e de H pelo Emissor Nacional (por
substituição, para ver a tela nova; ou 101101) e ver a consulta suspender (105102) ou aplicar (101101).

**Próximos passos (ordem)**: Rodada 15 (A-F80, Q-F90, Q-F91) → D-NE: NE-0/NE-1 (núcleo generalizado ANTES da F2a) → **F2a** (setes-api
passivo; migration `NNN_f2a_fiscal_passivo.sql` — D-F50; contrato da tela pela D-F79: o setes-api expõe `cancelWaiver`/`pendingEffects`
em rota própria por pedido, a nfse-api só o fisco) → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.9 Rodada 15 — D-F83…D-F85 (Valdo 2026-10-10: "siga as recomendações") — Rodada 16 DECIDIDA no §21.10

| Decisão | O quê | Onde |
|---|---|---|
| **D-F83** (= A-F80 confirmada) | em H a saída da voz C é cancelar a nota e faturar de novo (o Id do DPS é da vida) — nada de código novo; o 409 de H já aponta | — |
| **D-F84** (= Q-F90) | GET tipado com TIPOS DIFERENTES de cancelamento desta chave = `unknown` (502, nada gravado, `logger.error`) — supera o L7; mesmo tipo repetido vale; a D-F69 segue depois | os dois `adn.ts` |
| **D-F85** (= Q-F91) | chave da substituta só exibida se do MESMO emitente (`sameIssuerKey`: posições 9–23 da chave 50) | `substituteKeyOf` nos dois serviços |

**Gates do delta**: socrático **0,80 ✅** (nenhum MEDIUM+; L3 — JSDoc órfão na nfse-api, comentários de "hoje" no teste do R13-03,
teste da ordem inversa — corrigidos na sessão; L1 → Q-F92, L2 → Q-F93) · adversarial **0,80 ✅** (nenhum HIGH+; R15-01 LOW → Q-F94; R15-02 MEDIUM ANTERIOR ao delta, latente até a F2a → Q-F96; a
nota cosmética do JSDoc já estava corrigida pelo L3). Testes: `adversarial-r15-gate.test.ts`
nos dois serviços + blocos "RODADA 14" (L7 → D-F84) e R13-03/R13-04 do `adversarial-r13-gate.test.ts`.

**Provas**: setes-api **2047/2047** (suíte inteira, com a Rodada 4 do IBS/CBS da sessão paralela) · nfse-api 309 unit + ao vivo
**150/150** · núcleo 80 (sem mudança). Nada de DDL nesta rodada.

**Rodada 16 (aberta pelos gates da Rodada 15 — aguardam o Valdo)**:
- ⚠️ **Q-F92 (L1)** — a D-F84 só pega contradição DENTRO de um GET tipado; o laço pergunta 101101 → 105102 → 105104 → 305101 e PARA no
  primeiro achado: rota 101101 limpa + um e105102 na rota dele = "cancelada 101101" e o C local nasce. (a) **manter "para no primeiro"
  e registrar a premissa da D-F61 ("cancelamento é único por nota") como conhecimento negativo, com teste que fixa o comportamento** ·
  (b) perguntar as rotas restantes (até 3 GETs a mais, só nas achadas canceladas). *(Rec.: (a) — impossibilidade fiscal; reabrir só se
  a prova ao vivo M4 mostrar outra coisa.)*
- ⚠️ **Q-F93 (L2)** — saída para a nota "ambígua para sempre" em produção (K em voo ou reconferência presos em 502 por resposta
  contraditória PERSISTENTE da Sefin): (a) **manter fail-closed e fazer do alarme da F3 a saída — o rodízio registra o 502 persistente
  COM institution e nota (o log do adaptador não tem esse contexto)** · (b) ato humano com evidência, no molde do "manter a nota" ·
  (c) teto de tentativas no K ambíguo. *(Rec.: (a) agora; (b) só com caso real; (c) não — "ambíguo nunca fecha".)*
- ⚠️ **Q-F94 (R15-01 do adversarial)** — a D-F84 só conta tipos de CANCELAMENTO: um evento gerado desta chave de tipo fora do domínio
  (e105105 indeferido, e101103…) no mesmo GET tipado é filtrado antes — `[e105105, e105104]` na rota 105104 vira "cancelled 105104" e o
  C local nasce. (a) **conta como contradição (ambíguo)** · (b) filtrado, como hoje. *(Rec.: (a) — o GET por tipo + sequência só deveria
  devolver o tipo perguntado.)*
- ⚠️ **Q-F95 (contexto do adversarial)** — "mesmo tipo repetido vale" vale também com CONTEÚDO divergente? Hoje dois e105102 com
  `chSubstituta` diferentes dão cancelled 105102 com o XML do primeiro (a substituta exibida depende da ordem). *(Rec.: conteúdo
  divergente também é ambíguo.)*
- ⚠️ **Q-F96 (R15-02 do adversarial — MEDIUM ANTERIOR ao delta, D-F52 × D-F63; latente até a F2a)** — na nfse-api o rodízio revisita
  um F de envio interrompido em P; GET /dps acha a chave mas a consulta pela chave volta AMBÍGUA (502) → falha persistente carimba
  `last_queried_at` fora da transação → `reconfirmationProven` vira `true` = a prova que LIBERA o cancelamento local, embora o fisco
  tenha acabado de mostrar a NFS-e ("não se prova no escuro"). Hoje nenhum código do setes-api lê essa prova (o cancelamento atual
  reconfere na hora e falha fechado — provado). (a) não carimbar a candidata F em erro persistente · (b) marca própria de "não achou" ·
  (c) **a prova exige o "não achou" registrado explicitamente**. *(Rec.: (c) — decidir antes da F2a.)*

**Seguem da §21.8**: LOW registrados, prova ao vivo M4 (Valdo), e os próximos passos: Rodada 16 → NE-0/NE-1 → **F2a** (contrato da
tela pela D-F79) → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.10 Rodada 16 — D-F86…D-F90 (Valdo 2026-10-11: "siga as recomendações") — Rodada 17 DECIDIDA no §21.11

| Decisão | O quê | Onde |
|---|---|---|
| **D-F86** (= Q-F92 (a)) | o laço dos GETs tipados para no primeiro tipo achado — conhecimento negativo no código (premissa da D-F61) + teste que fixa | os dois `adn.ts` |
| **D-F87** (= Q-F93 (a)) | fail-closed; o rodízio registra "Fisco ambíguo persistente" com institution, nota, tentativa e última voz (para o alarme da F3) | `runRefresh` (setes-api) · passada da nfse-api |
| **D-F88** (= Q-F94 (a)) | todo evento GERADO desta chave conta no GET tipado — tipo fora do domínio de cancelamento também é contradição | os dois `adn.ts` |
| **D-F89** (= Q-F95) | mesmo tipo repetido só vale com conteúdo idêntico (`eventSignature`) | os dois `adn.ts` |
| **D-F90** (= Q-F96 (c)) | prova da D-F29 = E2404 EXPLÍCITO: `nfse_not_generated_at` (migration **003** da nfse-api + view; aplicada no dev, `explain:leituras` OK), escritor `recordNfseNotGenerated` guardado pela última voz vista, chamado só no E2404 (reconferência e consulta pelo Id do DPS); `reconfirmationProven` no núcleo lê a coluna nova | `fiscal-api/src/voice/reading.ts` · `nfse-api/src/nfse/{repository,transmission}.ts` · `migrate-from-setes-api.ts` (cabeçalho) |

**Parecer do guardião (D-F90)**: aprovado com 3 correções aplicadas — (1) nome `nfse_not_generated_at` (repete o E2404 e a constante
`DPS_NOT_GENERATED_CODE`; `not_found` convidaria a gravar em qualquer 404 — a armadilha da Q-ADV1a; "não consta" é da voz N; prefixo
`last_` na view é "da última voz"); (2) escritor PRÓPRIO, nunca parâmetro no `touchQueriedAt` (uma peça, um conceito); (3) guarda de
resposta velha no próprio UPDATE (`COALESCE(MAX(e.event),0) = voz vista` — o defeito do gate r10 sobre a coluna que libera o
cancelamento). Fato da TENTATIVA, nunca voz (um E2404 depois do F não muda o estado derivado — voz nova quebraria `fiscalStateOf`,
`isLiveTransmission` e `reconfirmationCandidate`); relógio NOSSO; sem backfill; sem índice (lida pela PK); sem janela de validade
(conhecimento negativo: a D-F29 nunca teve — não inventar). `migrate:setes` não copia a coluna (nasce NULL na réplica: F do ERP migrado
exige reconferência nova depois da virada).

**Gates do delta**: socrático **0,80 ✅** (nenhum MEDIUM+; corrigidos na sessão: LOW-1 contrato do adaptador — `queryDpsAccessKey` devolve
`null` SÓ com E2404 explícito (o `null` virou prova); LOW-2 o teste ao vivo confere a prova pela coluna nova; LOW-4 a reconferência com a
guarda recusada responde 409 `RESOURCE_BUSY` "consulte de novo", nunca "reconferido"; LOW-3 → Q-F97; validade da prova → Q-F98) ·
adversarial **0,82 ✅** (nenhum HIGH+; R16-02 = LOW-4, resistiu; R16-03 — o E2404 de OUTRO ambiente valia como prova — corrigido na
sessão aplicando a regra do L8 ao E2404; R16-01 → Q-F99). Testes: `adversarial-r16-gate.test.ts` nos dois serviços (o `it.failing` que
fica = Q-F99) + bloco "RODADA 16" do `adversarial-r11-gate.test.ts` + D-F90 no `adversarial-r15-gate.test.ts`/`transmission.test.ts`.

**LIÇÃO (produção, ~8 min)**: a 1ª versão da correção R16-03 recusava todo E2404 cujo `tipoAmbiente` não fosse o do ambiente perguntado —
mas a forma REAL do E2404 (sonda de 2026-09-30, Q-ADV2f) traz **`"tipoAmbiente": 0`**: o adaptador do setes-api (produção, deploy ao
salvar) passaria a tratar o "DPS sem NFS-e" verdadeiro como ambíguo. O teste que fixa a forma real pegou na hora; corrigido em ~8 min
(só 1/2 explícito do OUTRO ambiente é ambíguo; 0/ausente seguem aceitos). Banco de produção conferido: nenhuma voz e nenhuma consulta
no intervalo. REGRA: conferir o envelope REAL cravado antes de endurecer um leitor de resposta do fisco.

**Provas**: setes-api **2087**/2106 (as 19 falhas são a bomba-relógio de data do boleto — fora deste delta) · nfse-api 329 unit + ao vivo **150/150** · núcleo 80. ⚠️ A suíte inteira do setes-api acusa 19 falhas em 3
suítes do BOLETO (Onda 2) — bomba-relógio de DATA nos testes (vencimento fixo `2026-10-10`, vencido em 11/10; o código recusa
corretamente) — fora deste delta; tarefa própria sugerida ao Valdo.

**Rodada 17 (aberta pelos gates da Rodada 16 — aguardam o Valdo)**:
- ⚠️ **Q-F97 (LOW-3 do socrático)** — o alarme da D-F87 só cobre o rodízio: a consulta/reconferência pedida pela TELA devolve 502 sem log
  com a nota, o F candidato sai do rodízio depois da única revisita (D-F52) e a autorizada ambígua some no teto da D-F38. (a) **registrar
  "Fisco ambíguo persistente" (institution, nota, tentativa) também na reconferência e na consulta por nota; o alarme agrega por nota
  (primeira/última vez, contagem), sem depender da janela do rodízio** · (b) só o rodízio. *(Rec.: (a) — a Q-F93 prometeu a reconferência.)*
- ⚠️ **Q-F98 (socrático)** — validade da prova: a D-F29/D-F90 aceita qualquer E2404 POSTERIOR ao F, inclusive o da revisita automática de
  24 h; na F2a o cancelamento local pode se apoiar numa prova de semanas. (a) **manter "posterior ao F" e registrar como conhecimento
  negativo (o DPS foi enviado uma vez; 24 h depois o E2404 é conclusivo)** · (b) exigir prova recente (o app reconfere imediatamente
  antes). *(Rec.: (a) — reabrir só se a prova ao vivo M4 mostrar NFS-e gerada tarde.)*
- ⚠️ **Q-F99 (R16-01 do adversarial)** — a assinatura da D-F89 compara 8 campos: dois e101101 do mesmo Id que divergem FORA deles (ex.:
  `nDFSe` 1 × 2) passam como repetição, e o XML arquivado depende da ordem (a voz C sai igual). (a) **somar `nDFSe`, autor, `ambGer`,
  `tpAmb` à assinatura** · (b) comparar o `infEvento` inteiro normalizado (risco de ambíguo falso por formatação) · (c) manter os 8 campos
  e arquivar de forma DETERMINÍSTICA (ex.: o menor XML canônico), sem depender da ordem. *(Rec.: (a) — os campos do XSD que o fisco
  preenche são poucos; (c) se (a) prender nota por ruído.)*

**Seguem**: LOW da §21.8, prova ao vivo M4 (Valdo), nota de implantação da F2a (a nfse-api com a migration 003 sobe ANTES do setes-api
com o núcleo novo — a view muda), e os próximos passos: Rodada 17 → NE-0/NE-1 → **F2a** → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.11 Rodada 17 — D-F91…D-F93 (Valdo 2026-10-11: "siga as recomendações") — Rodada 18 DECIDIDA no §21.12

| Decisão | O quê | Onde |
|---|---|---|
| **D-F91** (= Q-F97 (a)) | "Fisco ambíguo persistente" com a ORIGEM em toda porta que pergunta ao fisco: rodízio (tentativa + última voz), consulta da tela (invólucro do `refreshServiceTransmission`), reconferência (`reconfirmBeforeLocalCancel` → `reconfirmCandidate`); helper único `logAmbiguousFiscal`; nunca a chave | `invoice-transmission.ts` (setes-api) · `nfse/transmission.ts` (nfse-api) |
| **D-F92** (= Q-F98 (a)) | a prova da reconferência não tem prazo — conhecimento negativo no `reconfirmationProven` + teste | `fiscal-api/src/voice/reading.ts` |
| **D-F93** (= Q-F99 (a)) | assinatura do evento + `nDFSe`, autor, `ambGer`, `tpAmb` (`tagText`) | os dois `adn.ts` |

**Gates do delta**: socrático **0,78 ✅** · adversarial **0,80 ✅** (nenhum HIGH+; o invólucro é transparente — mesmo retorno, a MESMA exceção; nenhum log duplicado; nunca a chave de acesso no alarme; LOW-4 e D-F90 preservadas no split da reconferência). Achados LOW que dependem de decisão: R17-01 (o `tagText` não lê atributo/CDATA como o `firstText` — a R16-01 reabre por outra forma; `verAplic` fora da assinatura) → Q-F102 · R17-02 (o alarme leva a mensagem inteira — o erro "NFS-e de OUTRO DPS" embute o CPF/CNPJ de outro prestador) → Q-F100 · R17-03 (o ambíguo do TRANSMITIR — passo 0b — sai rotulado "consulta" e o GET /dps ambíguo do 0b não alarma) → Q-F101; e a premissa da D-F92 ("o DPS foi enviado UMA vez" — falsa pela D-N3/D-F30) → Q-F103. Testes: `adversarial-r17-gate.test.ts` nos dois serviços (`it.failing` = os pendentes) + blocos "RODADA 17" no `adversarial-r11-gate.test.ts` e no `adversarial-r15-gate.test.ts`. Fora do delta, registrado: o log do transporte para 405/406/415 (`fiscal-api/src/transport/https-json.ts`) grava a URL, que contém a chave de acesso.

**Provas**: setes-api **2091**/2110 (idem — 19 da bomba-relógio do boleto) · nfse-api 358 unit + ao vivo **150/150** · núcleo 80.

**Seguem**: LOW da §21.8, prova ao vivo M4 (Valdo), o ALARME da F3 (agrega "Fisco ambíguo persistente" por nota — D-F87/D-F91), nota de
implantação da F2a (a nfse-api com a migration 003 sobe ANTES do setes-api com o núcleo novo), a tarefa da bomba-relógio de data dos
testes do boleto (fora desta frente), e os próximos passos: Rodada 18 → NE-0/NE-1 → **F2a** → virada → F2b. Corte da F2a: 30/11 (D-IB15).

**Rodada 18 (aberta pelos gates da Rodada 17 — aguardam o Valdo)**:
- ⚠️ **Q-F100 (R17-02)** — o que o alarme leva do erro: (a) a mensagem inteira (hoje — o "NFS-e de OUTRO DPS" traz o Id do DPS alheio,
  que embute o CPF/CNPJ de outro prestador) · (b) **só o código + um rótulo sem dígitos** · (c) mascarar sequências de 11+ dígitos.
  *(Rec.: (b).)*
- ⚠️ **Q-F101 (R17-03)** — o ambíguo do TRANSMITIR (passo 0b, `reconcileInterrupted`) sai rotulado "consulta" pela ausência de flags, e o
  GET /dps ambíguo do 0b não alarma: (a) aceitar "consulta" · (b) **origem EXPLÍCITA passada pelo chamador ("transmissao"), também no
  GET /dps do 0b — a origem deixa de ser deduzida por ausência** · (c) não alarmar no transmitir. *(Rec.: (b).)*
- ⚠️ **Q-F102 (R17-01)** — dois leitores do mesmo XML no adaptador (o `tagText` novo × o `firstText` do parse): atributo/CDATA divergentes
  leem `null` dos dois lados e passam como repetição (a R16-01 reabre); `verAplic` ficou fora. (a) **o `tagText` passa a ser o `firstText`
  do parse** · (b) assinatura = o XML canônico inteiro (fecha o `verAplic`; risco de ambíguo falso) · (c) **escolher o XML arquivado de
  forma determinística quando as assinaturas empatam**. *(Rec.: (a) + (c).)*
- ⚠️ **Q-F103 (D-F92 × D-N3)** — a premissa da D-F92 ("o DPS foi enviado UMA vez") é falsa: tentativas da mesma vida reapresentam o MESMO
  Id do DPS (D-N3/D-F30); uma tentativa nova recusada não invalida a prova antiga da candidata. (a) manter e corrigir só o comentário ·
  (b) **o E2404 tem de ser POSTERIOR à ÚLTIMA apresentação do Id em QUALQUER tentativa da vida** (barato, falha fechado). *(Rec.: (b).)*

### 21.12 Rodada 18 — D-F94…D-F97 (Valdo 2026-10-11: "siga as recomendações") — Rodada 19 DECIDIDA no §21.13

| Decisão | O quê | Onde |
|---|---|---|
| **D-F94** (= Q-F100 (b)) | o alarme leva `code` + `reason` (mensagem com dígitos trocados por `#`) — nunca a mensagem inteira | `logAmbiguousFiscal` (setes-api, nfse-api) |
| **D-F95** (= Q-F101 (b)) | origem EXPLÍCITA (`AmbiguousOrigin`): a tela passa `origin: 'consulta'` (`billing.fiscal.service.ts`, `nfse.routes.ts`); o transmitir registra `transmissao` no passo 0b (envolve o `reconcileInterrupted`) | `invoice-transmission.ts` · `nfse/transmission.ts` |
| **D-F96** (= Q-F102 (a)+(c)) | assinatura do evento pelo `firstText` do parse (exportado pelos `dps-builder.ts`); na repetição, o XML arquivado é o menor na ordem do texto | os dois `adn.ts` |
| **D-F97** (= Q-F103 (b)) | `reconfirmationProven(candidata, vida)`: o E2404 posterior à ÚLTIMA apresentação do Id (reserva ou última voz) em qualquer tentativa da vida com o mesmo Id e ambiente | `fiscal-api/src/voice/reading.ts` |

**Gates do delta**: socrático **0,76 ✅** · adversarial **0,78 ✅** (nenhum HIGH+; nenhum chamador de produção perdeu o alarme — cerca
estática; sem duplicata no 0b; escolha determinística nunca escolhe eco/outra chave). Corrigidos na sessão (sem decisão nova):
**R18-03 (MEDIUM latente — entra com a F2a)** a identidade da candidata (Id do DPS + ambiente) ausente fazia a prova voltar à regra
anterior em silêncio → sem identidade = falha FECHADO; **R18-04** `lifeList` virou OBRIGATÓRIA (o padrão `[candidata]` falhava aberto);
**R18-06** instante fora do formato `YYYY-MM-DD HH:MM:SS` = falha FECHADO; **R18-07** XML do fisco que o leitor não consegue ler
(entidade numérica fora do Unicode — inclusive no `xMotivo`, anterior ao delta) virava RangeError cru (500 na tela; no rodízio sem
alarme nem carimbo) → resposta ILEGÍVEL = ambígua (502). Testes: `adversarial-r18-gate.test.ts` nos TRÊS projetos (os `it.failing` que
ficam = Q-F104/Q-F105); os testes antigos de `reconfirmationProven` com 1 argumento passam por um helper com identidade + vida.

**Provas**: setes-api **2148**/2167 (as 19 falhas são a bomba-relógio de data dos testes do boleto — fora desta frente) · nfse-api 403 unit + ao vivo **150/150** · núcleo 94.

**Rodada 19 (aberta pelos gates da Rodada 18 — aguardam o Valdo)**:
- ⚠️ **Q-F104 (R18-01/R18-02)** — a mensagem do erro "NFS-e de OUTRO DPS" interpola o Id do DPS do TERCEIRO: o `reason` da D-F94 só tira
  dígitos (um CNPJ ALFANUMÉRICO — emitido desde 07/2026 — sobra como letras) e o Id inteiro (com CPF/CNPJ do terceiro) segue no `warn`
  do adaptador e no corpo do 502 que o app mostra. (a) manter a máscara · (b) rótulo FECHADO por causa (lista de valores), sem texto da
  resposta · (c) **a mensagem nunca interpola o Id do terceiro — só "Id divergente"**. *(Rec.: (c) + (b) — fecha os três destinos.)*
- ⚠️ **Q-F105 (R18-05)** — tentativa da MESMA identidade EM VOO na vida: só tem o instante da RESERVA; um E2404 que caia entre a reserva e
  a chegada do POST conta como prova (hoje quem segura é o plano de cancelamento — `isLiveTransmission`). (a) manter · (b)
  **`reconfirmationProven` falha fechado sempre que houver tentativa da mesma identidade sem voz** · (c) além disso, a reconferência da
  nfse-api recusa 409 com tentativa viva. *(Rec.: (b) — barato e coerente com o "falha fechado" da D-F97.)*

**Seguem**: LOW da §21.8, prova ao vivo M4 (Valdo), o ALARME da F3 (agrega "Fisco ambíguo persistente" por nota — D-F87/D-F91/D-F94),
nota de implantação da F2a (nfse-api com a migration 003 sobe ANTES do setes-api com o núcleo novo; a F2a chama
`reconfirmationProven(candidata, vida)` com a linha COMPLETA da view), a tarefa da bomba-relógio de data dos testes do boleto (fora
desta frente), e os próximos passos: Rodada 19 → NE-0/NE-1 → **F2a** → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.13 Rodada 19 — D-F98…D-F99 (Valdo 2026-10-11: "siga as recomendações") — Rodada 20 DECIDIDA no §21.14

| Decisão | O quê | Onde |
|---|---|---|
| **D-F98** (= Q-F104 (c)+(b)) | a mensagem "NFS-e de OUTRO DPS" diz só "Id divergente" (warn do adaptador e 502 do app); o `reason` do alarme é a CAUSA da lista FECHADA `AMBIGUOUS_CAUSES` — `tagAmbiguous` em todo produtor do 502 ambíguo, `ambiguousCauseOf` no alarme (fora da lista/sem marca = `nao-classificada`; marca em Symbol) | núcleo `errors/ambiguous-cause.ts` + espelho `setes-api/shared/tax-authority/ambiguous-cause.ts`; os dois `adn.ts`, os dois transportes (405/406/415), as duas composições |
| **D-F99** (= Q-F105 (b)) | `reconfirmationProven` falha FECHADO com tentativa da MESMA identidade sem voz (`lastEventAt` nulo — em voo); a reconferência da nfse-api segue carimbando o E2404 ((c) não escolhida) | `fiscal-api/src/voice/reading.ts` |

**Gates do delta**: socrático **0,80 ✅** · adversarial **0,80 ✅** (nenhum HIGH+; a causa chega ao alarme por TODO caminho real — catch
que relança, contenção/retry, `withTransaction` do núcleo, rodízio, 0b, reconferência; o Id/CPF/CNPJ alfanumérico do terceiro não sai por
nenhuma porta; cerca estática nos três projetos: todo produtor do código nasce dentro de `tagAmbiguous` com causa literal da lista).
Corrigidos na sessão (sem decisão nova):
- **R19-01 (MEDIUM latente — entra com a F2a)**: irmã da vida SEM identidade (projeção sem Id do DPS/ambiente) era descartada como "outra
  identidade" e a prova passava (o R18-03 do lado da vida) → falha FECHADO.
- **R19-03 (LOW, nos dois adaptadores)**: a chave do `GET /dps` não era conferida contra o emitente — numa resposta trocada a chave de
  OUTRO emitente (com o CPF/CNPJ dele) virava URL do `GET /nfse/{chave}` (e o transporte grava a URL no log em 405/rede) e, se a NFS-e
  alheia viesse sem `infDPS/@Id`, POUSAVA na nossa tentativa com voz A → `key.slice(8,23)` (tpInsc + inscrição) tem de ser o do Id do DPS
  (`slice(10,25)`), senão `dps-fora-do-contrato`. **Layout conferido nas 3 chaves REAIS de produção antes de endurecer** (lição do
  R16-03); a chave de teste dos gates r17/r19 não tinha o tpInsc — corrigida para o layout real.
- **R19-04 / S6 (LOW, setes-api)**: o rollback do `withInvoiceTx` sem guarda trocava o ambíguo pelo erro do rollback (500, sem alarme,
  sem carimbo) → mesmo idioma do `withTransaction` do núcleo.
- **S3 (LOW)**: seis saídas `unknown` do GET tipado caíam todas em `situacao-ilegivel` → o adaptador diz a causa (`unknownCause`):
  `evento-contraditorio` (D-F84/D-F88/D-F89/D-F69, além da D-F77), `evento-ilegivel` e `evento-nao-conferido` (D-F63) — 2 causas novas
  nas duas cópias; `situacao-ilegivel` fica como reserva.
- **S5 (LOW, anterior ao delta)**: XML ilegível no POST /nfse e na resposta ao pedido de cancelamento virava exceção crua (500) → 502
  ambíguo (`nfse-ilegivel` / `evento-ilegivel`).
- **S1 (LOW)**: o espelho do setes-api ganhou o teste do núcleo (`ambiguous-cause.test.ts`) e a cerca de igualdade (no r19 do setes-api).
Testes: `adversarial-r19-gate.test.ts` nos TRÊS projetos (o `it.failing` que fica = Q-F107) + `ambiguous-cause.test.ts` (núcleo e setes-api).

**Provas**: setes-api 2203 (as 19 falhas = bomba-relógio de data do boleto, fora desta frente) · nfse-api 451 unit + ao vivo 150/150 · núcleo 124.

**Nota de implantação da F2a (dos gates)**: (1) conferir a tentativa VIVA (barreira do plano — `isLiveTransmission`) ANTES de
`reconfirmationProven`, para o 409 dizer "transmissão em andamento" e não "reconfira" (a nfse-api ainda carimba a prova com tentativa em
voo — o app mostra a recusa do setes-api, senão entra em laço); (2) passar a VIDA inteira com as linhas COMPLETAS da view, incluindo as
em voo — nunca filtrar por "tem voz"; se a tela precisar do MOTIVO de "não provado", pedir ao núcleo um veredito com motivo (molde
`verdictOf` da D-IB47); (3) o espelho do setes-api (lista de causas, adaptador, transporte, `logAmbiguousFiscal`) MORRE na F2a — o alarme
passa a vir só da nfse-api; a F3 agrega por institution + nota + causa + origem e trata `nao-classificada` como defeito; (4) o
`migrate:setes` não copia a prova (D-F90): todo F migrado exige reconferência nova; tentativa migrada em voo segura a prova até o rodízio.

**Rodada 20 (aberta pelos gates da Rodada 19 — aguardam o Valdo)**:
- ⚠️ **Q-F106 (socrático)** — guardar alguma EVIDÊNCIA da "resposta trocada"? Pela D-F98 (c) nada da resposta alheia fica. (a) **manter
  assim e registrar como conhecimento negativo** (o alarme leva institution, nota, causa e instante — basta para chamado à Sefin; o caso se
  reproduz consultando de novo) · (b) HMAC-SHA256 do Id alheio no log do adaptador (segredo do servidor — hash simples de CPF se quebra
  por força bruta) · (c) corpo cru em área de acesso restrito com prazo de descarte. *(Rec.: (a) — reabrir se acontecer de verdade.)*
- ⚠️ **Q-F107 (adversarial R19-02 = socrático S4)** — o que conta como "em voo" na D-F99? A voz S ("enviado") é VIVA para o
  `isLiveTransmission` e para o SQL do rodízio, mas tem instante: com uma irmã S, um E2404 2 s depois dela prova contra uma apresentação
  que pode ainda não ter chegado (hoje S não tem produtor — latente). (a) manter "sem voz" literal + conhecimento negativo (quem criar
  produtor de S revisita a D-F99) · (b) **falha FECHADO com tentativa da mesma identidade VIVA** (`!lastEventAt ||
  !FINAL_TRANSMISSION_KINDS.has(lastKind)`; `lastKind` entra no contrato, ausente = viva) · (c) (b) + falha fechado com irmã que detém a
  chave (hoje só o `reconfirmationCandidate` barra). *(Rec.: (b) — barato e alinha a prova ao `isLiveTransmission` e ao rodízio.)*

**Seguem**: LOW registrados (o log do transporte grava a URL com a NOSSA chave/Id em 405/rede — R17/R19-S7; os da §21.8), prova ao vivo M4
(Valdo), o ALARME da F3, a tarefa da bomba-relógio de data dos testes do boleto (fora desta frente), e os próximos passos: Rodada 20 →
NE-0/NE-1 → **F2a** → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.14 Rodada 20 — D-F100…D-F101 (Valdo 2026-10-11: "siga as recomendações") — Rodada 21 DECIDIDA no §21.15

| Decisão | O quê | Onde |
|---|---|---|
| **D-F100** (= Q-F106 (a)) | CONHECIMENTO NEGATIVO: nada da resposta trocada é guardado — nem hash do Id alheio, nem corpo cru; o alarme basta | comentário nos dois `adn.ts`, nas duas composições, no `AuthorityHttpError.body` (núcleo + espelho) e no `logAmbiguousFiscal` |
| **D-F101** (= Q-F107 (b)) | "em voo" = tentativa VIVA: a prova falha FECHADO com irmã da mesma identidade sem voz FINAL (`FINAL_TRANSMISSION_KINDS`; S e K vivas; `lastKind` ausente/null = viva) — o predicado do `isLiveTransmission` | `fiscal-api/src/voice/reading.ts` |

**Gates do delta**: socrático **0,82 ✅** · adversarial **0,84 ✅** (nenhum HIGH+; o delta só acrescenta `return false` — o único risco
é falso negativo permanente, e ele só aparece no R20-01, latente; candidata montada pelo leitor real prova sem irmã viva; varredura A–Z/a–z
mostra que o predicado da prova é exatamente `!isLiveTransmission`; a D-F100 se confirma em transmitir, consulta, 0b e reconferência, com
agulhas que incluem o blob gzip+base64 da NFS-e alheia). Corrigidos na sessão (sem decisão nova):
- **S1 (socrático)**: a resposta TROCADA ainda VIAJAVA no erro — `AuthorityHttpError.body` com o envelope da NFS-e do terceiro (gzip+base64,
  invisível à busca por texto do r19); nada o gravava, mas nada fixava → `unknownResponse(…, { foreign: true })` entrega o `body` VAZIO
  (transmitir: outro DPS/sem Id/chave JSON≠XML; consultar: outra chave/sem identidade; GET /dps: chave de outro emitente) + teste.
- **R20-02 / S2**: `lastKind` era opcional no tipo da prova — projeção sem `last_kind` compilava e nunca provava (laço "reconfira" na
  F2a) → obrigatório no tipo (`null` aceito = viva); o fallback de execução segue falhando fechado.
- **S3**: título do teste do R19-02 citava Q-F106 (era a Q-F107).
Testes: `adversarial-r20-gate.test.ts` no núcleo (67) e na nfse-api (20; o `it.failing` que fica = Q-F108); o contexto que fixava o corpo cru
no erro virou regressão.

**Provas**: setes-api 2209 (as 19 falhas = bomba-relógio de data do boleto, fora desta frente) · nfse-api 472 unit + ao vivo 150/150 · núcleo 191.

**Nota de implantação da F2a — somam-se aos itens (1)–(4) do §21.13**: (5) `lastKind` faz parte da prova — a vida e a candidata vêm SÓ de
`transmissionViewSelect` + `mapTransmissionView` (nunca SELECT próprio); a suíte da F2a precisa de pelo menos um caso POSITIVO (prova =
true) com linha real da view, porque a falha fechada esconde erro de projeção; (6) barreira e prova têm o mesmo PREDICADO mas não o mesmo
CONJUNTO (a barreira olha o `currentOf`, a prova todas as irmãs da identidade) — hoje dá no mesmo porque a reserva só deixa viva a última
tentativa; vida migrada pelo `migrate:setes` ou produtor de S numa tentativa antiga quebra a equivalência (laço "reconfira" no app) —
ver Q-F110.

**Rodada 21 (aberta pelos gates da Rodada 20 — aguardam o Valdo)**:
- ⚠️ **Q-F108 (adversarial R20-01, LOW latente)** — a voz S não tem SAÍDA: a D-F51 (`isInterruptedInFlight`) só fecha tentativa SEM voz; com
  uma irmã S sem chave, o rodízio a revisita para sempre (ouve E2404 e não fecha), a reconferência carimba o E2404 mas o núcleo diz "não
  provado" para sempre e o transmitir fica em 409. Hoje S não tem produtor (teste "resistiu" confere). (a) **conhecimento negativo junto da
  voz S em `kinds.ts` e da D-F101: quem criar produtor de S dá a ela a saída da D-F51** · (b) estender a D-F51 já (S com idade ≥
  `IN_FLIGHT_MINUTES` + E2404) · (c) tirar S do vocabulário. *(Rec.: (a) — barato; (c) contraria "tabela sem consumidor não é morta".)*
- ⚠️ **Q-F109 (adversarial R20-03, LOW, só com dado gravado por fora)** — `kind` é `CHAR(1)` sem CHECK de domínio em colação `_ci`: um "f"
  minúsculo é F para o SQL do rodízio e VIVA para o código; candidata "f" com uma R depois faz o seletor devolver null e a barreira passar (a
  F2a cancelaria localmente sem a reconferência da D-F29 — anterior ao delta). (a) conhecimento negativo (os escritores são tipados) · (b)
  CHECK de `kind` em colação binária, conferido no boot (molde da D-F45), na próxima migration da nfse-api · (c) normalizar no leitor.
  *(Rec.: (a) até a F2a, (b) na migration dela.)*
- ⚠️ **Q-F110 (socrático, opcional)** — o contrato da prova para a F2a: (a) **manter `reconfirmationProven` booleano + itens (5)/(6) na nota
  da F2a** · (b) o núcleo expõe já `reconfirmationVerdict(candidata, vida)` com motivo (`provada`, `irma-viva`, `apresentada-depois`,
  `sem-e2404`, `sem-identidade`, `instante-invalido`) — barreira e prova numa chamada só (molde `verdictOf`, D-IB47) · (c) só a barreira
  do plano passa a usar `some(isLiveTransmission)` sobre a vida. *(Rec.: (a) — sem consumidor antes da F2a; a rodada da F2a decide (b) com
  o caso real na mão.)*

**Seguem**: LOW registrados (log do transporte com a NOSSA chave/Id na URL; os da §21.8), prova ao vivo M4 (Valdo), o ALARME da F3, a
tarefa da bomba-relógio de data dos testes do boleto (fora desta frente), e os próximos passos: Rodada 21 → NE-0/NE-1 → **F2a** → virada →
F2b. Corte da F2a: 30/11 (D-IB15).

### 21.15 Rodada 21 — D-F102…D-F104 (Valdo 2026-10-11: "siga as recomendações") — Rodada 22 DECIDIDA no §21.16

| Decisão | O quê | Onde |
|---|---|---|
| **D-F102** (= Q-F108 (a)) | CONHECIMENTO NEGATIVO: a voz S não tem produtor nem saída; quem criar produtor de S abre, na mesma entrega, os DOIS portões da D-F51 (o predicado `isInterruptedInFlight` E a reconferência sob a trava) | `kinds.ts` do núcleo, `transmission-kinds.ts` do setes-api, os dois `isInterruptedInFlight`; cerca `nfse-api/src/__tests__/voice-kind-fence.ts` |
| **D-F103** (= Q-F109 (a) → (b) na F2a) | `kind` sem CHECK de domínio: escritores tipados (exceto a cópia do `migrate:setes`, que herda o domínio da origem); CHECK binário na migration da F2a — item (7) abaixo | `kinds.ts`, `reconfirmationCandidate` |
| **D-F104** (= Q-F110 (a)) | a prova fica BOOLEANA até a F2a; o veredito com motivo se decide na rodada da F2a | `reading.ts` |

**Gates do delta**: socrático **0,72 ✅** · adversarial **0,80 ✅** (nenhum HIGH+; delta sem mudança de comportamento; hoje NENHUM caminho grava S
nem `kind` fora de {A,R,C,K,F,N} — conferido por AST em todas as chamadas ao escritor; o teste de conhecimento negativo passa pelo motivo
certo). Corrigidos na sessão (sem decisão nova):
- **R21-01 / S3 (LOW)**: a cerca da D-F102 era uma regex sobre o texto com comentários tirados por outra regex — 10 grafias de produtor de S
  passavam (aspas duplas, crase, ternário, cast, computada, `ev.kind = 'S'`, SQL cru…), o `/*` do XPath `//*[@Id=…]` do `xmldsig.ts` a
  deixava CEGA a 17 linhas reais, e 4 escritores da voz ficavam fora da varredura (a cópia do `migrate:setes`, a migration 002, o
  repositório e as migrations do setes-api) → **peça de teste compartilhada `voice-kind-fence.ts`**: AST do TypeScript (lição ADV-R8-06 —
  comentário sai pelo compilador; qualquer grafia), `.sql` statement a statement, escopo = TODO lugar que escreve na voz da NFS-e
  (nfse-api src/scripts/migrations, núcleo, setes-api — pasta + migrations); zero falso positivo no código real. O aviso do `kinds.ts` diz
  exatamente o que ela vê (e que NÃO vê produtor semântico — Q-F112).
- **R21-03 (LOW)**: o aviso apontava só UM dos dois portões da saída de S → os três lugares nomeiam o predicado E a reconferência sob a
  trava (`recordInterruptedFailure` / `reconcileInterrupted` — abrir só o predicado faz a S monopolizar o rodízio no ramo "perdeu a corrida").
- **R21-04 / S4 (LOW)**: o teste de conhecimento negativo engolia exceção (`settle`) e ficava verde sem a decisão → aguarda a chamada e
  ancora `{changed:false, kind:'S'}` + o carimbo "nós olhamos".
- **R21-05 (LOW)**: "os escritores são tipados" esquecia a cópia do `migrate:setes` → nomeada no aviso e no item (7).
- **S6 (LOW)**: o vocabulário próprio do setes-api (`transmission-kinds.ts`) ganhou a nota.
Testes: `adversarial-r21-gate.test.ts` no núcleo (9) e na nfse-api (34; os `it.failing` que ficam = produtores semânticos, Q-F112).
Resíduo LOW registrado: a cerca de LOGS do r20 ainda usa a regex `uncomment` (mesma janela cega do `xmldsig.ts`, linhas 55–71 — hoje sem
nenhum log ali); trocar pela AST quando for tocada. Instabilidade observada: `adversarial-f1r2` falhou UMA vez sob carga ("Cannot log after
tests are done") e passou isolado e na repetição.

**Provas**: setes-api 2219 (as 19 falhas = bomba-relógio de data do boleto, fora desta frente) · nfse-api 506 unit + ao vivo 150/150 · núcleo 200.

**Nota de implantação da F2a — item (7) (D-F103)**: a migration da **nfse-api** (família de serviço, banco `fiscal_api`) que a F2a trouxer
ganha o CHECK do domínio de `kind` em colação BINÁRIA, conferido no boot (molde da D-F45). Antes do ALTER: conferir `kind` fora do domínio
ou da caixa no `fiscal_api` **e na origem do setes-api**; conferir no MariaDB 10.4 se o `INSERT IGNORE` da cópia do `migrate:setes`
rebaixa a violação do CHECK a AVISO (a linha some e o passo 6 falha com a mensagem "dual-write", que engana); a sonda do boot usa `'f'`
(nunca `'ZZ'` — um CHECK `_ci` passaria na sonda).

**Rodada 22 (aberta pelos gates da Rodada 21 — aguardam o Valdo)**:
- ⚠️ **Q-F111 (socrático S1, MEDIUM latente mas planejado)** — a D-F102 vale para QUAL família? A NE-1a (D-NE13/D-NE14, ANTES da F2a)
  leva a máquina de transmissão para o núcleo e a NE-3 produz S na NF-e: se o S da NF-e ficar no núcleo, a cerca dispara contra um
  produtor LEGÍTIMO (pressão para apagá-la); se ficar na nfe-api, ela é cega — e a saída que a D-F102 pede (E2404) a SEFAZ não tem.
  (a) **só a NFS-e** (`tb_invoice_service_transmission_event`): a cerca mira o escritor dessa família; a NF-e define a saída do S DELA na
  própria rodada (consulta pela chave/recibo — D-NE33) · (b) regra GLOBAL: toda família que produzir S dá a saída na mesma entrega, cada
  uma com o veredito conclusivo do seu fisco, e a cerca varre nfse-api, nfe-api e núcleo · (c) manter o texto atual. *(Rec.: (a), decidida
  antes da NE-1a.)*
- ⚠️ **Q-F112 (socrático S2 + adversarial R21-02)** — quando e como entra a proteção do domínio do escritor da NFS-e? Hoje o tipo do
  escritor (`TransmissionEventInput.kind: TransmissionEventKind`) ACEITA S — produtor semântico (constante, shorthand, mapa, parâmetro)
  escapa de qualquer cerca textual; e na NE-1a o tipo comum ganha P/D (vivas e sem saída na NFS-e) antes do CHECK da F2a. (a) CHECK
  binário já na 1ª migration da nfse-api que a NE-1a trouxer · (b) **o escritor da NFS-e é tipado pelo vocabulário DA FAMÍLIA — sem S
  já agora (`Exclude<…,'S'>`, uma linha de tipo, com o aviso da D-F102 no próprio tipo) e sem P/D quando a NE-1a vier; o CHECK fica na
  F2a (item (7))** · (c) manter tudo na F2a. *(Rec.: (b) — pega toda forma TypeScript sem DDL antes da F2a; se a NE-1a já tiver migration,
  (a).)*

**Seguem**: LOW registrados (log do transporte com a NOSSA chave/Id na URL; a cerca de logs com a regex antiga; os da §21.8), prova ao vivo M4
(Valdo), o ALARME da F3, a tarefa da bomba-relógio de data dos testes do boleto (fora desta frente — outra sessão, decisão do Valdo), e os
próximos passos: Rodada 22 → NE-0/NE-1 → **F2a** → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.16 Rodada 22 — D-F105…D-F106 (Valdo 2026-10-11: "siga as recomendações") — EXECUTADA e PUBLICADA (Rodada 23 decidida no §21.17)

> **Histórico**: a 1ª sessão foi encerrada a pedido do Valdo no meio das correções dos gates; o código ficou no working tree e em backup
> nos branches `wip/rodada-22` (fiscal-api `6d7d72d` · nfse-api `49383ba` · setes-api `dcb7a43`). Uma 2ª sessão no mesmo dia (Valdo:
> "termine a execução da Rodada 22") conferiu o working tree = backup (blob a blob), fechou a lista PENDENTE abaixo, publicou no `main` e
> apagou os `wip/rodada-22`. O setes-api do dev já rodava o funil e o mapa congelado desde a 1ª sessão (`tsx watch`).

| Decisão | O quê | Onde |
|---|---|---|
| **D-F105** (= Q-F111 (a)) | a D-F102 vale SÓ para a família NFS-e; a cerca mira a família: SQL só na tabela da NFS-e; no núcleo só SQL (`sqlOnly`) | `nfse-api/src/__tests__/voice-kind-fence.ts` + `voice-kind-fence.test.ts` (novo) |
| **D-F106** (= Q-F112 (b)) | o escritor da voz da NFS-e aceita só a lista POSITIVA da família — `SERVICE_VOICE_WRITE_KINDS = ['A','R','C','K','F','N'] as const satisfies readonly TransmissionEventKind[]` e o tipo `ServiceVoiceWriteKind` DERIVA dela | `repository.ts` da nfse-api e `transmission.repository.ts` do setes-api; `OUTCOME_KIND` nos dois |

**Gates do delta**: socrático **0,76 ✅** · adversarial **0,80 ✅** (nenhum HIGH+; hoje nenhum caminho grava S; toda forma SEM cast que põe kind fora
da família direto no objeto do escritor NÃO compila — literal, constante, shorthand, mapa, parâmetro, ternário, não-nulo, genérico, spread
antes — medido com o tsconfig real, nos dois projetos).

**JÁ FEITO na sessão (working tree + `wip/rodada-22`)** — sem decisão nova; os dois gates convergiram (a Q-F114 (b) do socrático — "rede
além do tipo até a F2a" — foi executada aqui porque o adversarial a classificou como correção de sessão: **o Valdo pode reverter**):
- **R22-03** funil em EXECUÇÃO: os dois `insertTransmissionEvent` recusam kind fora da lista (sensível a caixa — o `'s'` também) ANTES de
  qualquer query (`throw Error('D-F106: …')`) — fecha cast, spread, JSON e `as any` (o tipo some no JS).
- **R22-02** `OUTCOME_KIND` = `Object.freeze(...)` nos dois lados (`Object.assign`/`Reflect.set` compilavam sem cast).
- Ressalva do adversarial (`any` no tipo comum apagava a D-F106 calado) fechada: o tipo da família DERIVA da constante.
- **S2** comentário: P = viva (em processamento), **D = FINAL (denegada)** — o texto antigo "P/D vivos" levaria NF-e denegada a ficar em voo.
- **S3** comentário: a D-NE33 é o **P** (consulta do recibo); o S da NF-e, se existir, sai pela consulta da NOSSA chave (§3.2/D-NE7).
- Peça da cerca (`voice-kind-fence.ts`): **R22-07** SQL em mais grafias (aspas duplas, INSERT/REPLACE sem INTO e com modificadores,
  `` `kind` `` com crase, CASE/IF no SET); **R22-06** tabela por CONSTANTE resolvida no template; **R22-01/R22-04/R22-05** nova
  `writerCallFlags` (chamada ao escritor nu/namespace/alias/cast da função; objeto da voz literal SEM spread/cast; kind literal da família
  ou `OUTCOME_KIND[…]`; mutação do `OUTCOME_KIND`; SQL de escrita na voz fora dos escritores autorizados) + `voiceWriterViolations()` +
  `VOICE_SQL_WRITERS` (ESCRITOR ÚNICO: os dois repositórios + a cópia do `migrate:setes`). `voice-kind-fence.test.ts` 10/10; o código REAL
  não tem violação (nem produtor de S, nem chamada/escritor fora da regra).

**FECHAMENTO (2ª sessão de 2026-10-11 — sem decisão nova, só conversão de teste e testemunhas)**:
1. **Gate r22 convertido** — `it.failing` → `it('[CORRIGIDO na sessão] …')` e os "contexto" que fixavam o comportamento ANTIGO passaram a
   fixar o NOVO. nfse-api (`adversarial-r22-gate.test.ts`, 45/45): a réplica local `callFenceFlags` SAIU — a camada (W) é a `writerCallFlags`
   da peça (o teste 0 confere que tudo o que o predicado do r21 recusa, a peça recusa); a matriz do ATAQUE 1 com a coluna (W) medida pela
   peça (nada escapa: `ESCAPES = []`; o que escapava antes ficou como histórico em `ESCAPED_BEFORE`); 1b: o spread posterior e o "s"/S/P/D
   são RECUSADOS pelo funil sem nenhuma query, `Object.assign` no mapa LANÇA `TypeError`, `Reflect.set` devolve `false`; ATAQUE 3: com o
   comum `string` ou `any` a lista da família CONTINUA A/R/C/K/F/N (a ressalva do `Extract` fechada — com `any` só o "comum" compila, e o
   funil o pega); o erro do tsc agora mostra o tipo derivado EXPANDIDO (`"A" | "R" | …`), não o nome; ATAQUE 4: os escritores SQL reais =
   `VOICE_SQL_WRITERS`. Núcleo (`adversarial-r22-gate.test.ts`, 8/8): as 2 falhas eram testes que fixavam a 1ª forma (`Extract`) e a regex
   antiga da cerca — agora fixam a constante + tipo derivado + funil (texto da família) e o `VOICE_TABLE`/`S_LIT` da cerca.
   **Q-F113 do texto dos testes = Q-F114 desta seção** (R22-08 — os testes foram escritos antes da numeração do socrático; renomeado).
2. **S1** — no r21 (teste "DECIDIDO — D-F106"), testemunhas `@ts-expect-error` presas à CHAMADA `repo.insertTransmissionEvent(…)` com S, P,
   D e o vocabulário comum, dentro de função que não roda (F segue aceito); o comentário "em execução o JS não confere" corrigido (o funil confere).
3. **S6** — `setes-api/src/__tests__/service-voice-write-kind.test.ts` (5): lista = A/R/C/K/F/N; `@ts-expect-error` no escritor REAL (S/P/D/
   comum) e no `OUTCOME_KIND.local = …` (Readonly); funil recusa S/P/D/"s"/"a"/vazio/ausente e o spread posterior SEM nenhuma query; os seis
   gravam; `Object.isFrozen` + `Object.assign` lança + `Reflect.set` = false.
4. **Provas**: núcleo **208/208** (`tsc` limpo, `build` refeito) · nfse-api **561 unit** (150 ao vivo pulados) + **150/150 ao vivo**
   (`NFSE_ADV_LIVE=1`, cópias descartáveis — a 1ª rodada ao vivo saiu com código 255 sem resumo legível; a 2ª, 150/150) · setes-api: `tsc`
   limpo; `--runInBand` **2229/2248** — as **19 falhas conhecidas** do boleto do Inter (`bank-slip-registration`, `onda2-adversarial`,
   `onda2-gate-rework` — todas `BANK_SLIP_EXPIRATION_PAST`, data fixa dos fixtures; outra sessão). Em paralelo o Jest do setes-api caiu no
   encerramento (`kill EPERM` dos workers no Windows) e um arquivo não reportou: rodar com `--runInBand`.
5. **Docs**: §7 (D-F106 na forma final), §8.R22 EXECUTADA, §8.R23 aberta, CLAUDE.md dos três projetos fiscais + raiz, INDEX, INDICE_CENTRAL,
   memória. Commit SÓ dos caminhos desta frente; push no `main`; `wip/rodada-22` apagados depois de publicado (conferido antes: o
   `main` contém todo o código de produção dos backups — a diferença era só testes e CLAUDE.md desta sessão).
   **PUBLICADO 2026-10-11**: núcleo f6aeb03 · nfse a23fea6 · api 6bd6f83 · nfe-api 35ce356 · infra (o commit desta seção).

**Rodada 23 (aberta pelos gates da Rodada 22 — DECIDIDA: D-F107/D-F108, §21.17)**:
- **Q-F113 (socrático S4)** — qual domínio o CHECK do item (7) da F2a protege na tabela da NFS-e? (a) **a lista da FAMÍLIA** (A/R/C/K/F/N
  — a mesma constante do tipo; a sonda do boot e um teste comparam a constante com o DDL; a conferência antes do ALTER conta também S nas
  duas pontas) · (b) o vocabulário comum · (c) decidir na F2a. *(Rec.: (a).)*
- **Q-F114 (adversarial R22-08, MEDIUM latente/planejado)** — onde mora a lista de escrita da família quando o escritor for para o núcleo
  na NE-1a (D-NE13)? (a) **o descritor da família no núcleo carrega a lista (`VoiceFamily<K>`); o escritor comum é genérico nela e a confere
  em execução; a cerca do núcleo vira "escritor único"** · (b) a nfse-api mantém um invólucro tipado como ÚNICO caminho e uma cerca proíbe
  importar o escritor genérico · (c) deixar para o CHECK da F2a (não resolve — o domínio comum tem S). *(Rec.: (a), antes da NE-1a.)*

**Nota de implantação da NE-1a (proposta dos gates — MOVIDA para o `prompt_onda_nfe_sefaz.md` §12.8 com a D-F108; texto original abaixo)**: (1) a escrita da voz segue POR
FAMÍLIA — a porta do núcleo é PROPRIEDADE-FUNÇÃO, nunca método (método é bivariante: aceitaria o escritor estreito e deixaria gravar S —
provado com `tsc --strict`), ou o escritor é genérico com `kind: WriteKindOf<F>`; (2) testemunhas `@ts-expect-error` de S/P/D presas ao
escritor que a máquina REALMENTE chama; (3) nenhum "S antes do POST" comum às famílias — quem produzir S na NF-e entrega a saída junto;
(4) P entra no tipo comum como VIVA e **D em `FINAL_TRANSMISSION_KINDS`**; os `default` dos dois `fiscalStateOf` viram `switch` exaustivo
(`never`) — kind novo quebra a compilação em vez de virar `in_flight`; (5) o escritor genérico do núcleo entra na lista branca da cerca
(no núcleo ela segue `sqlOnly` — D-F105; `${table}` é invisível a ela); (6) a lista da família tem UMA fonte, reusada pelo CHECK da F2a
(Q-F113); (7) depois da extração: `voiceSProducers()`, `voiceWriterViolations()`, as testemunhas e a suíte inteira da nfse-api (unit + 150).

**Aviso da sessão IBS/CBS (2026-10-11)**: a IB-2 prevê o enquadramento DATADO do emitente (`tb_establishment_tax_regime`, D-IB7/D-IB35), que
troca os leitores de `tb_entity_tax` em `fiscal-api/src/erp/facts.ts`, `nfse-api/src/facts/service-facts.ts` e no dual-run do setes-api —
combinar antes; nada será feito sem decisão do Valdo.

**Seguem (inalterados)**: LOW registrados (log do transporte com a NOSSA chave/Id na URL; a cerca de LOGS do r20 com a regex antiga; os da
§21.8), prova ao vivo M4 (Valdo), o ALARME da F3, a bomba-relógio de data do boleto (outra sessão), e: Rodada 22 (fechar) → Rodada 23 →
NE-0/NE-1 → **F2a** → virada → F2b. Corte da F2a: 30/11 (D-IB15).

### 21.17 Rodada 23 — D-F107…D-F108 (Valdo 2026-10-11: "siga as recomendações da Rodada 23") — ⏯ RETOMAR POR AQUI

| Decisão | O quê | Executa em |
|---|---|---|
| **D-F107** (= Q-F113 (a)) | o CHECK do item (7) protege a lista da FAMÍLIA (A/R/C/K/F/N), binário, UMA fonte com o tipo | migration da nfse-api na **F2a** |
| **D-F108** (= Q-F114 (a)) | na extração da máquina para o núcleo, o DESCRITOR da família carrega a lista de escrita; escritor comum genérico nela, com o funil em execução; cerca do núcleo = escritor único | **NE-1a** (nota no `prompt_onda_nfe_sefaz.md` §12.8) |

**Sem código de comportamento nesta rodada** — as duas decisões têm lugar de execução marcado e nada a fazer antes dele. Feito agora:
comentários no ponto de uso (`fiscal-api/src/voice/kinds.ts`, `nfse-api/src/nfse/repository.ts`) e os títulos dos testes de contexto que
fixavam a alternativa (a) (`adversarial-r22-gate` do núcleo e da nfse-api) passaram a citar a D-F108. Sem gate: nenhuma mudança de
comportamento (os mesmos testes, mesmos resultados).

**Nota de implantação da F2a — item (7) REVISTO (D-F103 + D-F107; substitui o texto do §21.15)**: a migration da **nfse-api** (banco
`fiscal_api`) que a F2a trouxer ganha o CHECK de `kind` na tabela da voz da NFS-e com o domínio **A/R/C/K/F/N em colação BINÁRIA** (forma
exata pelo `revisar-ddl`), tirado da constante `SERVICE_VOICE_WRITE_KINDS` — um teste compara a constante com o DDL e a sonda do boot
(molde da D-F45) tenta gravar `'S'` E `'f'` e exige a recusa das duas (nunca `'ZZ'` — um CHECK `_ci` ou sobre o vocabulário comum
passaria). Antes do ALTER: contar `kind` fora da lista ou da caixa (inclusive S) no `fiscal_api` E na origem do setes-api; conferir no
MariaDB 10.4 se o `INSERT IGNORE` da cópia do `migrate:setes` rebaixa a violação do CHECK a AVISO (a linha some e o passo 6 falha com a
mensagem "dual-write", que engana) — se rebaixar, a cópia confere a lista antes de inserir.

**Nota de implantação da F2a — itens (8) e (9) (NE-1a parte 1, gate socrático M5, 2026-10-11 — `prompt_onda_nfe_sefaz.md` §12.9.4)**:
(8) a F2a decide REGISTRO FISCAL só por `isFiscalRecord(currentOf(…))` do núcleo (fato `authority_recorded` da view — D-NE56); a linha
`fiscalRecord = !!tx?.accessKey && tx.environment === 'P'` de `setes-api/src/shared/invoice/invoice-cancel.ts:350` NÃO é portada (na NF-e a
chave é nossa desde a reserva — portá-la é o bug da NF-e rejeitada tratada como registro); cerca no setes-api contra `accessKey` decidindo
registro. (9) a nfse-api sobe com as migrations 003 **e 004** ANTES do setes-api novo, e o setes-api confere no boot que a view publica
`authority_recorded` (molde D-F45/D-IB26) — sem isso o `mapCommonView` estrito do núcleo derruba com 500 a lista de OS na 1ª leitura. A
leitura em LOTE (selo da lista de OS) usa `familyViewQueryMany` do núcleo (terminal por parâmetro), nunca um WHERE próprio com
`terminal = 0`; e, pela D-NE66 (b) (gates da NE-1a), a F2a recebe do núcleo um leitor que JÁ MAPEIA (`readFamilyTransmissions`) — o par
`familyViewQuery`/`…Many` + linha crua deixa de ser o caminho público (os predicados já falham alto com a linha crua — D-NE66 (a)).

**Nota de implantação da F2a — itens (10) a (12) (NE-1a parte 2, gates dos passos 1–6, 2026-10-12 — `prompt_onda_nfe_sefaz.md` §12.9.7.2)**:
(10) D-NE77: o setes-api importa SÓ `fiscal-api/reading` (a superfície de leitura — projeção comum, `VOICE_READINGS`, predicados,
`InvoiceRef`; o leitor que já mapeia da D-NE66 (b) entra nela); o barrel completo é das famílias — a cerca está no núcleo
(`ne1a-superficie.test.ts`, lê o `setes-api/src`) e quebra no 1º import fora do subpath. (11) D-NE84: a migration da F2a põe o CHECK
BINÁRIO do `model` em `tb_establishment_issuer` (hoje a 004 do núcleo avalia `IN ('SE','55','65')` na colação _ci — 'se' passa), junto
do CHECK da lista da família (D-F107). (12) D-NE76: a contagem de transmissões vivas (DELETE do A1 / troca de ambiente) trata família NÃO
instalada no `fiscal_api` como 0 — nenhum serviço condiciona o boot às migrations de outra família; tabela sem view segue falhando fechado.

**Próximo**: nenhuma questão aberta nesta frente. Ordem (D-NE55, Valdo 2026-10-11 — `prompt_onda_nfe_sefaz.md` §12.9: a NE-0 saiu do
caminho crítico): NE-1a (núcleo generalizado, com a D-F108 — Rodada 0 aberta no §12.9 de lá) → **F2a** (setes-api passivo, com a D-F107)
→ virada → F2b → NE-0. Corte da F2a: 30/11 (D-IB15).


## 22. F2a — setes-api PASSIVO: Rodada 0 (2026-10-12) — inventário + parecer do guardião + ordem proposta — Rodada 1 DECIDIDA (D-F109…D-F117, §22.6)

> Valdo (2026-10-12, depois de publicar a NE-1a parte 2b): *"pode seguir para a F2a"*. Corte: **30/11/2026** (D-IB15). Nada foi editado no
> setes-api nesta rodada — ele roda em `tsx watch` na árvore servida e É a produção da Setes (salvar = deploy). Fontes: agente Explore (só
> leitura, 11 itens) e agente `setes-conceito` (só leitura); os pontos que decidem foram conferidos no código antes de entrar aqui
> (`invoice-cancel.ts:329-350`, `require-privilege.ts:63`, `migrations/runner.ts`, `src/migrations/sql/065…067`).

### 22.1 Fatos do inventário (Explore, 2026-10-12 — só leitura; `SA` = setes-api, `NF` = nfse-api, `FA` = fiscal-api)

**As 14 rotas** (`SA/src/gateway/router.ts:145` `/billing`, `:87` `/establishment`): billing — `POST /billing/transmit` (routes:233), `POST
/billing/fiscal/transmit-batch` (:261, `runningBatch` — **sem par na nfse-api**), `GET /fiscal/pending` (:275), `POST /fiscal/refresh` (:302, rodízio
— o app NÃO usa), `POST /fiscal/cancel` (:337), `POST /fiscal/:orderId/refresh` (:355), `GET /fiscal/:orderId` (:369), `…/xml` (:384), `…/danfse`
(:399); establishment — `GET /issuer` (:120), `PUT|DELETE /issuer/certificate` (:159/:160), `PUT|DELETE /issuer/:model` (:206/:207). Todas têm par
em `NF/src/modules/nfse/nfse.routes.ts` / `emitter/emitter.routes.ts`, exceto o lote. **Fora das 14, fala com o fisco**: `POST /billing/cancel` →
`reconfirmBeforeLocalCancel` consulta o ADN direto (`invoice-transmission.ts:351/:357`) e pode gravar voz pelo refresh (:360) — a rota FICA.

**Ponto de corte (o que FICA depende do que MORRE)**: `invoice-cancel.ts:14-16` e `invoice-cancel-waiver.ts:7-9` → `transmission.repository`
(`latestTransmission`, `isLiveTransmission`, `isAuthorized`, `findTransmissionEventByKind`, **`setTransmissionEventEffect` = ESCRITA na voz**
— `invoice-cancel.ts:461`); `billing.service.ts:858` → `reconfirmBeforeLocalCancel` (adaptador ADN); `service-orders.service.ts:48` →
`getServiceFiscalSummaries` (selo); `billing.service.ts:688` e `service-orders.repository.ts:1076` → `getIssuer` (SÉRIE da nota) no módulo
`fiscal-issuer` que morre (puxa `secret-store`/`node-forge`); `applyCancelEffect` (`invoice-transmission.ts:404`) fica pelo §12.2 mas **todos os
chamadores morrem** (`recordCancelVoice`, `retryLocalCancelEffect`); ciclo de import `invoice-transmission` ↔ `@shared/invoice`.

**Leituras × views**: `TX_SELECT` → `transmissionViewSelect`/`mapTransmissionView` (a view NÃO tem `ageMinutes`/`lastEventAgeMinutes`);
`LIFE_WHERE` (aceita `invoice_event IS NULL`) → `vw_invoice_life` + `inLife` (no `fiscal_api` a vida é NOT NULL); `latestTransmission` →
`currentOf` (por `authorityRecorded`); `countPendingEffects` + `WAIVED_SQL` → **sem coluna equivalente** (D-F28: sem coluna de efeito no
`fiscal_api`) — o `localCancelPending` do núcleo NUNCA marca pendente 305101/105102 e não conhece a dispensa; `findTransmissionEventByKind` lê
`invoice_event` (a view de eventos NÃO o tem); `fiscalRecord = !!tx?.accessKey && …` (`invoice-cancel.ts:350` — nota (8): não portar);
`fiscalStateOf` 7 estados → 9 no núcleo; **prova da reconferência** hoje não é LIDA — o setes-api pergunta ao fisco; `nfse_not_generated_at` só
existe no `fiscal_api` (003/004). Views da nfse-api: `vw_invoice_service_transmission` (004 — com `authority_recorded` bin) e
`vw_invoice_service_transmission_event` (001 — sem `invoice_event`); núcleo sem views; GRANT do `setes_api` COMENTADO em `NF/ops/grants.sql:32-33`.
`fiscal-api/reading` exporta vocabulário, projeção, predicados, `familyViewQuery/Many`, família de serviço (`reconfirmationCandidate/Proven`,
`localCancelPending`), `InvoiceRef`; **`readFamilyTransmissions` (notas (8)/(10)) NÃO existe**; `erp.invoiceLife/orderInterface` só no barrel.

**Dual-run**: `FISCAL_ISSUER_RETIRED`/`_CUTOVER_ONLY` (D-F56/D-F58) morrem com as rotas 13/14 (a D-F50 assume); portes da D-F43, funil D-F106,
`transmission-kinds.ts`, espelho `ambiguous-cause` + `logAmbiguousFiscal` morrem (nota (3)); `connection.ts` só cita o `fiscal_api` em comentário.

**JWT**: assina HS256 com `JWT_SECRET` (`auth.service.ts:43-45/:63`, seleção :88/:96); valida em `gateway/auth.middleware.ts:13-14` sem `algorithms`;
par de dev em `SA/secrets/jwt/` (fora do git); a nfse-api só aceita RS256 com `kid` (`FA/src/auth/product-jwt.ts`) e recusa o token de seleção;
`mint-dev-token.ts` existe "só até a F2a"; scripts (trilha, smokes, generate-token) e ~20 testes assinam HS256.

**Views D-F32**: JÁ EXISTEM (`065_fiscal_policy_views.sql`: `vw_order_interface`, `vw_invoice_life`) — **ninguém no setes-api as lê**; a nfse-api
e o núcleo leem. `resolveOrderInterface` (`billing.interface-resolver.ts:16-23`) usa `tb_service_order` direto; a view parte de `tb_order`.

**Migrations**: `SA/src/migrations/sql/`, última 067 → próxima **068**; runner decide pela VERSÃO (número), grava `name` = resto do nome, SEM
transação; aplica no BOOT da API (`server.ts:21`) em todo schema ativo, no `db:migrate` e no onboarding. A nfse-api confere
`name = 'f2a_fiscal_passivo'` (`migrate-from-setes-api.ts:377-404`).

**Testes**: 28 arquivos (~470 `it`) cobrem o que morre; 7 (~113) ficam e leem transmissão; 5 (~75) ficam mas mockam `fiscal-issuer` com `requireActual`.

**setes-app (F2b)**: 2 datasources chamam 13 das 14 rotas (`service_order_fiscal_datasource.dart`, `establishment_issuer_datasource.dart`); base de
URL ÚNICA; nenhuma referência à nfse-api; a entidade lê `pendingEffects`, `events[].invoiceEvent`, `cancelWaiver`, `substitution.waived` — a nfse-api
devolve `localCancelPending` e `substitution` sem `waived`, sem `cancelWaiver`. **Trilha**: só o P8b usa rotas fiscais; assina HS256.

**Dev**: `npm run dev` = `tsx watch` na árvore servida (porta 3000 no ar); setes-api NÃO depende de `fiscal-api` hoje; `package-lock.json` no
`.gitignore`; sem worktrees.

**Riscos levantados**: R1 `applyCancelEffect` órfão · R2 `cancelInvoice` grava na voz (sem coluna no `fiscal_api`, setes-api só SELECT) · R3
`getIssuer` (série) mora no módulo que morre · R4 a série do 55 perde o único editor (rota 13) · R5 pendência diverge (`countPendingEffects` ×
`localCancelPending`) — D-F79 pede predicado único · R6 `readFamilyTransmissions` não existe · R7 leitura TRAVANTE sobre view DEFINER com só
SELECT [INCERTO] · R8 migration roda no BOOT da produção, sem transação, decidida pelo NÚMERO · R9 cercas dos irmãos leem o caminho fixo do
setes-api (`existsSync` pula em silêncio se o arquivo some) · R10 F2a sem F2b quebra o app (13 rotas; lote sem par; payload diferente) · R11
`/billing/cancel` fala com o fisco hoje · R12 tudo que assina HS256 muda · R13 dependência `file:` sem lock versionado · R14 "migration da F2a" =
duas coisas (CHECKs no `fiscal_api` × `068_f2a_fiscal_passivo` no ERP) · R15 divergências pequenas (resolver × view, vida NULL, 7 → 9 estados).

### 22.2 Parecer do guardião (`setes-conceito`, 2026-10-12)

**Conceito**: o setes-api passa a LER a voz do fisco ONDE ela é escrita, para decidir os fatos do ERP sobre a nota. **Fato gerador da F2a = a
VIRADA** (D-F39 — muda quem escreve a voz) ⇒ regra que responde quase tudo: **o leitor segue o escritor** (regra 10 do PADROES §11 espelhada).
É COMPOSIÇÃO: o ERP compõe os predicados do núcleo (`fiscal-api/reading`) com fatos dele (nota, vida, dispensa); a ÚNICA peça nova do ERP é a
**porta de leitura do `fiscal_api`** (`src/shared/fiscal-voice/` — único lugar que lê o `fiscal_api`, importa só o subpath — D-NE77).

| O que fica | Fato gerador | Veredito |
|---|---|---|
| efeito (C local) | ato humano no ERP condicionado à voz | peça existente (`cancelInvoice`); o "vínculo do efeito" (`setTransmissionEventEffect`, `invoice-cancel.ts:457-464`) é RESÍDUO do modelo que a D-F28 matou — sai |
| plano | pedido de cancelamento (ERP) | composição do ERP (D-F29); bloco fiscal montado pelos predicados do núcleo |
| prova (E2404) | resposta do fisco gravada pela nfse-api | a regra JÁ está no núcleo (`families/service.ts:101-160`) — o ERP exige, nunca reimplementa |
| dispensa | decisão de uma pessoa (ERP — D-F79) | fica; `invoice-cancel-waiver.ts` reescrita sobre a porta |
| pendência do efeito | voz C vigente × nota não-C × dispensa | UMA função derivada (`src/shared/invoice/invoice-fiscal-effect.ts` — `fiscalEffectOf`); a contagem por `e.invoice_event IS NULL` de hoje é **maquete** (forma do vínculo morto; a coluna não existe no `fiscal_api`) |
| selo da lista de OS | voz mostrada numa lista do ERP | fica (SQL do ERP na mesma instância, pela porta) |

**Duas "pendências" que NÃO são a mesma**: `localCancelPending` do núcleo = "o app pode aplicar o C sozinho" (exclui substituição e de ofício)
× pendência do ERP = "voz C esperando efeito OU decisão humana" (inclui as duas) — nomes diferentes (Q-F120). **Decidem por COLUNA crua hoje**
(além do `fiscalRecord` da nota (8)): `invoice-cancel.ts:333` `homologationAuthorized = isAuthorized(tx) && tx.environment === 'H'` → barreira
pelos fatos do núcleo `isLiveTransmission(cur) || (isAuthorized(cur) && isFiscalRecord(cur))` (⚠️ `isLive || isFiscalRecord` NÃO serve: barraria a
voz C em produção, que é o caminho do efeito); `invoice-cancel-waiver.ts:97/101` (`!tx.accessKey`, `environment !== 'P'`) →
`isSubstitutionCancel(cur)`/`isFiscalRecord(cur)`; `transmission.repository.ts:251-254` (`currentOf` pela chave) → `currentOf` do núcleo (pelo
registro); `LIFE_WHERE` (vida que aceita NULL) morre por construção; prosa `invoice-cancel.ts:36` "pendente (sem chave)" → "sem registro fiscal".
**Fato que a view NÃO publica**: "família instalada?" (D-NE76) — com GRANT só nas views o setes-api não distingue "view ausente" (falha
fechado) de "família não instalada" (Q-F119). O setes-api NÃO precisa da view de eventos (a tela "No fisco" é da nfse-api) — GRANT mínimo = só
a view de tentativas.

**Views D-F32**: já existem (065 — `vw_order_interface`, `vw_invoice_life`) e são lidas pelo núcleo/nfse-api; a vida vigente JÁ tem dono. A F2a
faz a 2ª metade: o setes-api passa a LER delas (`resolveOrderInterface` → `vw_order_interface`; `lockInvoice`/`LAST_INVOICE_EVENT_KIND_SQL` →
`vw_invoice_life`). **Maquete**: views novas por consumidor; view no ERP com JOIN no `fiscal_api` (amarra deploys, DDL ×1000); manter o resolver TS
"provado igual" à view (duas verdades com um teste de cola); levar "admin passa"/fuso/Anexo I para SQL; coluna de estado fiscal em `tb_invoice`.

**`f2a_fiscal_passivo` honesto**: o runner grava `_migrations` depois dos statements e o BOOT aplica — com `tsx watch`, o `.sql` salvo na árvore
viva entra no próximo restart com o código ANTIGO servindo; um marcador vazio MENTE. O fato que a D-F50 protege é **"o ERP deixou de escrever a
voz fiscal"**, garantido pelo banco seja qual for o código (Q-F116). Não entram nela: CHECK de `kind` (migration da nfse-api — D-F107), CHECK
binário de `model` (migration do NÚCLEO — a tabela é dele, D-F35; o item (11) da nota dizia nfse-api), GRANTs (operação).

**Transição**: "leitores pelas views com as rotas antigas ainda escrevendo" é **maquete** — antes da virada a voz vive no ERP e o `fiscal_api` tem
só a RÉPLICA (atrasada até o próximo `migrate:setes`): o plano lendo a réplica pode liberar o cancelamento local (soft-delete, número liberado) de
uma NFS-e recém-autorizada na origem. "Tudo numa janela" pesa demais. Rec.: **cortar pela FONTE da voz** (Q-F117). Riscos de "duas verdades" no
dual-run: leitor na réplica × escritor na origem; política em dois códigos (resolver TS × view — JÁ existe); vocabulário/predicados copiados
(`transmission-kinds.ts`, `currentOf` pela chave, espelho do `ambiguous-cause`); A1 em dois cofres; contador do nDPS em dois lugares; coluna de
vínculo no ERP × pendência derivada no núcleo.

**Palavras ocupadas**: *pendência/pendente* (5 sentidos — nunca sozinha) · *vigente* (tentativa · vida · dispensa) · *viva* (tentativa ·
cabeçalho · nota não cancelada) · *selo* (fiscal da OS × classificação IBS/CBS) · *réplica* (depois da virada as tabelas do ERP são a **origem
congelada**, não réplica) · *recibo* (morto com a D-F11; dono na NF-e — nRec) · *emissor/issuer* (a tabela do ERP deixa de ser habilitação) ·
*fiscal* (`@shared/fiscal` = cadeia de documentos da entidade) · *reconferência* (prosa) = `reconfirm*` (código). **Nomes**: `src/shared/fiscal-
voice/` · `src/shared/invoice/invoice-fiscal-effect.ts` (`fiscalEffectOf`) · `src/shared/invoice-series/` (`invoiceSerieFor` — o que sobra de
`@shared/fiscal-issuer`) · `GET /api/billing/:orderId/cancel-plan` e `GET /api/billing/:orderId/fiscal-effect` · `068_f2a_fiscal_passivo.sql`
(combinar o número com a IB-2). **Não entra**: vínculo do efeito, job de efeito, reconferência pelo setes-api (D-F4), view cruzada entre bancos,
leitura das tabelas internas do `fiscal_api` (D-F15), leitor de fonte dupla pela `cutover_at`, DROP.

### 22.3 Ordem interna (VIGENTE — D-F111 + D-F117)

| Etapa | O quê | Onde | Publica quando |
|---|---|---|---|
| **A1 — núcleo e nfse-api** | `readFamilyTransmissions` (nota (8)/(10)) + `reconfirmationVerdict` (Q-F115) no subpath `fiscal-api/reading`; migration do NÚCLEO com o CHECK binário de `model` (D-NE84); migration 005 da nfse-api com o CHECK binário de `kind` A/R/C/K/F/N + sonda do boot `'S'` e `'f'` (D-F107; contar antes fora da lista/caixa no `fiscal_api` E na origem; conferir o `INSERT IGNORE` do `migrate:setes` no MariaDB 10.4); GRANT do `setes_api` só na view de tentativas (`ops/grants.sql`) | repos do núcleo e da nfse-api (não servem produção) | gate do delta → publicar |
| **A2 — setes-api, o que NÃO depende de onde a voz mora** | dependência `fiscal-api` (só o subpath; cerca de import); `resolveOrderInterface` e vida pelas views da 065 (prova de equivalência no molde da 065 — elimina a duplicidade que JÁ existe); D-F37 nas rotas do ERP (conferir antes, no dado, quem perde acesso — molde da D-F37 de 2026-10-04); RS256 com `kid` no token final e no de seleção (relogin; scripts e ~20 testes); conferência no boot da view com `authority_recorded` + família instalada (nota (9), Q-F119) | worktree da F2a → merge na árvore viva POR ITEM aprovado | cada item: testes + gate do delta → merge (= deploy) |
| **A3 — setes-api, o lote da janela** | porta `fiscal-voice`; plano, dispensa, selo e `fiscalEffectOf` pela porta (predicados do núcleo, nada por coluna crua); rotas `cancel-plan`/`fiscal-effect` (Q-F121); `invoice-series` (Q-F118); remoção das 14 rotas + peças + espelhos + `setTransmissionEventEffect`; migration `068_f2a_fiscal_passivo` (Q-F116); cercas da F2a; **prova de aceite: leitor novo na réplica recém-sincronizada × leitor velho na origem = 0 divergência** (selo, bloco fiscal do plano, pendência, prova) | worktree — NÃO entra na árvore viva antes da janela | gates socrático + adversarial ANTES da janela |
| **F2b — setes-app** (Rodada 0 própria) | datasources dedicados da nfse-api; a tela "No fisco" compõe nfse-api (fisco) + setes-api (`fiscal-effect`, dispensa — D-F79); lote no cliente; emissor/A1 direto na nfse-api; série da nota pelo ERP | worktree do app | junto da janela |
| **Janela (B)** | parar o uso → merge do A3 na árvore viva (o boot aplica a 068) → `migrate:setes -- --cutover 1 --confirmo-setes-api-parado --vai` (com o "vai") → build da F2b publicado (cuidado com o cache do Flutter web) → trilha (front-end das duas APIs) → reabrir | árvore viva | **antes de 30/11** |
| **Depois** | apagar o A1 do cofre do setes-api (Q-F122, "vai"); F3 (Onda 4) | — | — |

Esforço: A1 ≈ 1 sessão · A2 ≈ 1–2 · A3 ≈ 2–3 · F2b ≈ 4–6 · janela ≈ 1 → **9–13 sessões** até 30/11 (≈ 7 semanas de calendário).

### 22.4 Questões da Rodada 1 da F2a — DECIDIDAS (§22.6)

- ⚠️ **Q-F115 — contrato da prova da reconferência agora que existe consumidor (revisita a D-F104)**: (a) manter `reconfirmationProven`
  booleano; o ERP compõe a ordem "irmã viva primeiro" (nota (1)) · (b) **o núcleo expõe `reconfirmationVerdict(vida)` com motivo** (`provada` ·
  `irma-viva` · `apresentada-depois` · `sem-e2404` · `sem-identidade` · `instante-invalido` · `nao-exigida`), usado pelo plano do ERP e pelo
  `/reconfirm` da nfse-api · (c) o bloco fiscal inteiro do plano vai para o núcleo. *(Rec.: (b) — a ordem fica num lugar só e acaba o laço
  "reconfira"; (c) tira do ERP uma política dele — Q-CA5b, destino da nota, D-F29.)*
- ⚠️ **Q-F116 — o que a `068_f2a_fiscal_passivo` CONTÉM (D-F50)**: (a) **congela a escrita fiscal do ERP por construção** — triggers BEFORE
  INSERT/UPDATE com SIGNAL nas tabelas de tentativa e voz do ERP e na linha SE de `tb_establishment_issuer` (sem revive S→N, sem mudar
  `environment`/`dps_last_number`, sem INSERT de SE; **N→S permitido** — é o ato da D-F44) + COMMENTs de aposentadoria sem DROP
  (`environment`, `dps_last_number`, `tb_invoice_service.dps_number`, as duas tabelas = "origem congelada"); o nome passa a significar "o ERP
  deixou de escrever a voz fiscal" · (b) só COMMENTs (garantia por procedimento) · (c) renomear as tabelas do ERP (quebra a re-sincronia final).
  *(Rec.: (a) — custo: 1º trigger de TRAVA da casa → regra nova no PADROES + `revisar-ddl`; o ensaio da virada confere os triggers; ganhos: a
  re-sincronia lê origem congelada, rollback de código pós-virada falha fechado, a lacuna (b) fica inalcançável, a D-F56/D-F58 vira fato de banco.)*
- ⚠️ **Q-F117 — desenho da transição (produção ao vivo + o app chama 13 das 14 rotas)**: (a) tudo junto numa janela · (b) 2a-i leitores pelas
  views com as rotas antigas servindo + 2a-ii remoção na janela · (c) **antecipar só o que não depende de onde a voz mora (A1/A2); janela única
  para congelamento + troca dos leitores + remoção das rotas + virada + F2b**. *(Rec.: (c) — a (b) cria duas verdades: plano lendo a réplica
  atrasada pode liberar o cancelamento local de NFS-e recém-autorizada.)*
- ⚠️ **Q-F118 — a SÉRIE da nota por modelo depois que saem as 5 rotas do emissor (D-F21/D-F44)** — a tabela do ERP já mistura habilitação com
  série (a 058 semeou a linha 55 de `invoice_serie`); a rota 13 era o ÚNICO editor da série do 55: (a) **leitor só-leitura `@shared/invoice-
  series` sobre a tabela, sem tela até o 1º cliente de mercadoria; SE fica '1' depois do ato** · (b) a série vira config do Framework na
  interface billing, por modelo · (c) rota fina só para a série. *(Rec.: (a) — a forma definitiva se decide com o leiaute real da NF-e.)*
- ⚠️ **Q-F119 — "família instalada" com GRANT mínimo (D-NE76)**: (a) **o catálogo `VOICE_READINGS` da versão da biblioteca É a lista das
  famílias instaladas; o boot do setes-api confere a view de cada uma; ordem de deploy: serviço da família antes do setes-api** · (b) view-catálogo
  publicada no `fiscal_api` · (c) GRANT de leitura nas tabelas base. *(Rec.: (a) — generaliza o item (9) sem peça nova.)*
- ⚠️ **Q-F120 — forma do predicado ÚNICO da pendência do efeito no ERP (D-F79)**: (a) **classificação derivada da vigente da vida vigente:
  `none` · `apply` (= `localCancelPending` do núcleo) · `decide` (substituição sem dispensa) · `cancel` (de ofício), mais a dispensa vigente** · (b)
  contagem (`pendingEffects: number`, como hoje) · (c) booleano. *(Rec.: (a) — a contagem era a forma do vínculo morto e o app precisa saber
  QUAL ação mostrar.)*
- ⚠️ **Q-F121 — rotas do ERP para o app (D-F29 + D-F79)**: (a) uma rota com plano + efeito · (b) **duas: `GET /api/billing/:orderId/cancel-plan`
  (consultiva, não travante) e `GET /api/billing/:orderId/fiscal-effect`** · (c) só a do efeito; o plano segue só no POST. *(Rec.: (b) — plano e
  estado do efeito são dois conceitos.)*
- ⚠️ **Q-F122 — a cópia do A1 no cofre do setes-api depois da virada**: (a) **apagar na janela, depois que o `/v1/health` da nfse-api decifrar o
  A1 do `fiscal_api`** (com o "vai") · (b) manter N dias como rollback · (c) manter. *(Rec.: (a) — o rollback é proibido pela D-F50; 2ª chave
  privada é só exposição.)*
- ⚠️ **Q-F123 (condução) — onde a F2a é desenvolvida, com a árvore do setes-api servindo a produção em `tsx watch`**: (a) **worktree git
  `D:\Gestao2027\setes-api-f2a` (branch `f2a`) com `.env`/`secrets`/`node_modules` próprios (cópias locais, fora do git); testes ali (mocks e cópias
  descartáveis); as cercas dos irmãos que leem `D:/Gestao2027/setes-api/src` passam a ler `SETES_API_DIR` (padrão: a árvore viva) e FALHAM ALTO
  quando o arquivo esperado some (hoje `existsSync` pula em silêncio — R9); merge na árvore viva só por item aprovado (A2) e, o lote A3, só na
  janela** · (b) desenvolver na árvore viva com o código novo inerte atrás de flag (cada save publica; erro de import derruba a produção) · (c)
  trocar o serviço do dev de `tsx watch` para build congelado durante a F2a (salvar não publica, mas o restart ainda aplica as migrations do disco).
  *(Rec.: (a).)*

### 22.5 Sem decisão (correções óbvias da execução)

1. Comentário "Tabela ausente (depois da F2a)" em `fiscal-api/src/erp/facts.ts:284-294` contradiz a D-F44 (sem DROP) — corrigir o texto.
2. Item (11) da nota: o CHECK binário de `model` é migration do NÚCLEO (tabela dele — D-F35), não da nfse-api.
3. `vw_order_interface.interface_key` vem de literais (CASE) sem COLLATE e a nfse-api o compara no SQL (`service-facts.ts:333`) — conferir com
   `SET NAMES` em duas colações (PADROES §11 regra 3); se cair, recriar no molde da 004 da nfse-api (`COLLATE utf8mb4_bin`).
4. Tirar `dps_number = NULL` do revive em `setes-api/src/shared/invoice/invoice.ts:251` (coluna aposentada — D-F30).
5. `nfse-api/ops/grants.sql:29-33`: o `setes_api` só precisa da view de TENTATIVAS.
6. RS256: `gateway/auth.middleware.ts:13-14` fixa `algorithms: ['RS256']`; o token de seleção (`auth.service.ts:88/96`) ganha marca própria (a
   nfse-api já o recusa) e nunca vale como token final.
7. Leitura fiscal do plano travante (LOCK IN SHARE MODE) ou DEPOIS da trava da nota (PADROES §11 regra 4); conferir no MySQL 8 da F3 a leitura
   travante numa view DEFINER tendo só SELECT [INCERTO no inventário — R7].
8. Cercas da F2a: zero HTTP para as APIs fiscais; só o subpath `fiscal-api/reading`; nenhum `accessKey`/`environment === 'H'|'P'`/
   `last_queried_at` decidindo registro ou prova fora do núcleo; nenhuma leitura das tabelas congeladas no `src`.
9. Nota conjugada: o plano percorre `VOICE_READINGS` pelos ramos presentes (a NE-2 confere o que a D produz no plano).
10. Combinar o número 068 com a IB-2 (também cria migrations no setes-api); pela D-F50 o nome fixo vai no ÚLTIMO arquivo da F2a.
11. Os três serviços rodam a MESMA tag do núcleo (checklist de deploy da F3); a `package-lock.json` do setes-api está no `.gitignore` — a
    dependência `file:../fiscal-api` precisa de pino na F3 (R13).
12. Glossário da skill do guardião: entram pendência, vigente, viva, selo e origem congelada.
13. Os testes que mockam `../shared/fiscal-issuer` com `requireActual` (5 suítes que ficam) passam a mockar `@shared/invoice-series` (R3).
14. Scripts que leem as tabelas de transmissão do ERP (`pre-deploy-tz-check.ts:53-61`, `repair-authorized-cancel.ts:59`) — conferir na A3
    (origem congelada: leitura histórica continua válida; decisão nova, nunca).

### 22.6 Rodada 1 da F2a — DECIDIDA (Valdo 2026-10-12: "siga as recomendações")

| Questão | Decisão |
|---|---|
| Q-F115 (b) | **D-F109** veredito da reconferência com motivo no núcleo |
| Q-F116 (a) | **D-F110** `068_f2a_fiscal_passivo` congela a escrita fiscal do ERP (triggers + COMMENTs, sem DROP) |
| Q-F117 (c) | **D-F111** transição pela fonte da voz — A1/A2 antes, janela única para o resto |
| Q-F118 (a) | **D-F112** série da nota = `@shared/invoice-series` só-leitura |
| Q-F119 (a) | **D-F113** família instalada = `VOICE_READINGS` da biblioteca; boot confere as views |
| Q-F120 (a) | **D-F114** pendência do efeito = classificação `none/apply/decide/cancel` |
| Q-F121 (b) | **D-F115** `GET …/cancel-plan` + `GET …/fiscal-effect` |
| Q-F122 (a) | **D-F116** A1 do cofre do setes-api apagado na janela (com o "vai") |
| Q-F123 (a) | **D-F117** worktree `setes-api-f2a`; cercas por `SETES_API_DIR` e falhando alto |

**Próximo**: etapa **A1** (núcleo + nfse-api — §22.3). Corte da F2a: 30/11 (D-IB15).


### 22.7 Etapa A1 — executada + gates do delta (2026-10-12) — socrático **0,74 ✅** · adversarial **0,72 ✅** (nenhum CRITICAL/HIGH; 2 MEDIUM) — Rodada 2 da F2a DECIDIDA (D-F118…D-F123)

**O que a A1 entregou (antes dos gates)**: núcleo — `reconfirmationVerdict(vida)` com motivo (D-F109; o booleano virou o motivo `provada`
de `proofReason`), leitor que já mapeia `readFamilyTransmissions`/`…Many` (D-NE66 (b); `familyViewQuery*` saiu do caminho público para
`voice/view-query.ts`), `assertCheckRefuses` (sonda genérica de CHECK), migration 005 (CHECK binário de `model` — D-NE84); nfse-api —
migration 005 (CHECK binário de `kind` — D-F107), sonda do boot, `nfseNotGeneratedAt` na linha interna, `/reconfirm` pelo veredito
(tentativa viva → 409 com a mensagem do transmitir, sem ir ao fisco; `verdict` relido DEPOIS), OpenAPI, GRANT mínimo (só a view de
tentativas). Fatos medidos (só leitura / banco descartável `fiscal_api_adv_*`): MariaDB 10.4.20; dados reais todos no domínio (`kind`
A/C/F/R, `source` P, `environment` H/P, `model` SE — no `fiscal_api` e na origem `setes_setes`). **Achado para a A2**: a
`vw_order_interface` da 065 do setes-api dá erro 1267 numa conexão `utf8mb4_general_ci` (`interface_key` vem de literais sem COLLATE; o
padrão do mysql2 é `unicode_ci`, por isso hoje passa) — recriar no molde da 004 da nfse-api (`COLLATE utf8mb4_bin`), migration do setes-api.

**Gate socrático (agente independente) — 0,74**: três achados confirmados por sonda — (1) vidas MISTURADAS liberavam o cancelamento (vida
H registrada + cancelada local + vida nova em P com F por consulta → `nao-exigida`; o `currentOf` recusava a mistura, o veredito não);
(2) duas respostas públicas que discordavam (o booleano `true`, o veredito `irma-viva` com tentativa viva de outra identidade); (3)
`irma-viva` com candidata (irmã final sem `lastEventAt`) → `find(isLive)!` undefined → TypeError/500 no `/reconfirm`. Correções sugeridas:
veredito recusa lista mista; irmã sem instante = `instante-invalido`; sonda com PK própria; ROLLBACK que falha → destruir a conexão;
`mapTx` estrito para a prova; OpenAPI com os dois códigos; comentários vencidos; doc "depois da trava"; MySQL 8 como conhecimento
negativo; D-F117 nas cercas e D-F113 no núcleo (eram da A1). Questões Q-F124/Q-F125.

**Gate adversarial (agente independente — gates `fiscal-api/src/__tests__/adversarial-f2a-a1-gate.test.ts` e
`nfse-api/src/__tests__/adversarial-f2a-a1-gate.test.ts`, parte viva em `fiscal_api_adv_gatea1*`) — 0,72**: **F2A1-01 MEDIUM** (o mesmo
(1) do socrático, provado com a view 004 e o mapa reais); **F2A1-08 MEDIUM** — na forma da cópia do `migrate:setes` (`INSERT IGNORE …
SELECT`) o MariaDB 10.4.20 **REBAIXA** a violação do CHECK a aviso 4025 e a voz some calada (a 005 afirmava o contrário — a sonda da
sessão só tinha testado a forma `VALUES`); LOW F2A1-02 (o (3)), 03 (o (2)), 04 (o SELECT cru `familyViewSelect`/`transmissionViewSelect`
ainda saía pela superfície), 05 (a sonda aceitava a recusa de QUALQUER CHECK), 06 (OpenAPI × K), 07 (as duas linhas da sonda do `kind` com
a mesma PK). Resistiu: barreira antes do fisco em todos os vivos; veredito relido honesto; varredura de 2.100 vidas incoerentes; CHECK
binário ao vivo nas duas tabelas; sondas não sujam a sessão; 005 sobre dado fora do domínio falha e não registra; caso positivo pela view
004 real. Questões Q-F130…Q-F133.

**Decisões (Valdo, 2026-10-12)** — Q-F124 dividiu os gates (socrático: manter o booleano + cerca; adversarial: booleano = veredito) e foi
perguntada à parte; as outras pelas recomendações:

| Decisão | O quê |
|---|---|
| **D-F118** (= Q-F124 — "tirar da superfície") | o booleano `reconfirmationProven` segue a prova de UMA candidata (sem a barreira da vida — como os gates R18–R21 o fixaram) e SAI da superfície `fiscal-api/reading` (fica no barrel — nfse-api e testes): quem decide o cancelamento enxerga, por compilação, só o VEREDITO |
| **D-F119** (= Q-F125 (b)) | o leitor público é ESCOPADO PELA VIDA: `readFamilyTransmissions(q, família, db, ref, vida)` e o lote por PARES nota × vida (o setes-api lê as vidas vigentes na `vw_invoice_life`); linha de vida não pedida = falha alta; o veredito (como o `currentOf`) recusa lista mista |
| **D-F120** (= Q-F131 (a)) | `environment` (tentativa e habilitação) e `source` (voz) com CHECK BINÁRIO (H/P, P/Q) nas mesmas 005 + sondas do boot; o `mapTx` também passa a recusar ambiente fora de H/P |
| **D-F121** (= Q-F130 (a)) | quem decide lê a voz DEPOIS do `FOR UPDATE` da nota (o 1º comando da transação — PADROES §11 regra 12); o leitor não trava; cerca no plano da A3 |
| **D-F122** (= Q-F132 (a)) | nenhum código usa `check_constraint_checks` (a sessão desligaria o CHECK) — PADROES §11 regra 11 + cerca por AST no núcleo |
| **D-F123** (= Q-F133 (a)) | as 005 são RE-EXECUTÁVEIS (`DROP/ADD CONSTRAINT IF [NOT] EXISTS` — só MariaDB; a F3 revê a cadeia se o motor for MySQL 8) |

**Correções de sessão (sem decisão nova)**: veredito com `assertOneInvoiceLife` (nota e vida na linha, no tipo); `irma-viva` ⇔
`isLiveTransmission` (irmã final sem instante = `instante-invalido`); `/reconfirm` sem `!` (guarda com 409); superfície `fiscal-api/reading`
virou LISTA EXPLÍCITA (fora: `familyViewSelect`, `transmissionViewSelect`, `reconfirmationProven`, `assertOneInvoiceLife`; a cerca confere
"módulos − lista de fora" — export novo quebra até alguém decidir); `CheckProbe` com o NOME da constraint (recusa de outro CHECK = falha com
diagnóstico), PK própria por sonda, valor anterior de `foreign_key_checks` restaurado, BEGIN antes de mexer na sessão, ROLLBACK que falha →
conexão destruída; `assertIssuerEnvironmentDomainEnforced` e `assertServiceVoiceDomainsEnforced` (kind/source/ambiente) no boot da nfse-api,
mais `assertFamilyViewsReadable` (D-F113 — a view de cada família do catálogo responde ao SELECT publicado; também para o boot do setes-api
na A2); lote com estabelecimento e terminal conferidos; `migrate:setes` confere o domínio da ORIGEM (kind da família, source P/Q, binários)
ANTES da cópia das vozes (F2A1-08); `mapTx` estrito (`nfseNotGeneratedAt` presente, ambiente H/P); OpenAPI do `/reconfirm` com
FISCAL_TRANSMISSION_IN_PROGRESS e FISCAL_CANCEL_IN_FLIGHT e o aviso "`nao-exigida` ≠ pode cancelar"; comentários vencidos (`kinds.ts`,
`issuer-models.ts`, `establishment.repository.ts`, `facts.ts`, `service.ts`); as 005 renomeadas (`005_issuer_domains_binary.sql` do núcleo,
`005_service_transmission_domains.sql` da nfse-api — nada publicado antes). **D-F117 nas cercas**: helper `SETES_API_DIR`/`setesApiPath`/
`mustExist`/`relWorkspace` (`fiscal-api/src/__tests__/setes-api-dir.ts` e `nfse-api/src/__tests__/voice-kind-fence.ts`); as cercas que
vigiam o setes-api (r13, r19, r21, r22 dos dois lados, `voice-kind-fence`, `ne1a-superficie`) leem a worktree quando `SETES_API_DIR` aponta e
FALHAM ALTO quando o que vigiam some (a A3 revisa cada uma na mesma entrega que remove o arquivo).

**Testes convertidos**: gates da A1 (núcleo e nfse-api) — `it.failing` → `[CORRIGIDO na sessão]`/`[CORRIGIDO — D-F119]`/`[DECIDIDO — D-F118…]`;
contextos Q-F130…Q-F133 → `[DECIDIDO]`; r8/cofre (recusa pelo nome da constraint; a do CHECK _ci antigo NÃO prova); r21 (a cópia confere a
origem; CHECK por expressão isolada); r18/r20/`transmission.test.ts` (o `/reconfirm` pelo veredito); `ne1a-leitura` (lote por pares);
`ne1a-registro`/`adversarial-ne1a-gate` (linha interna com a prova); `ne1a-superficie` (lista explícita); `f2a-a1` (núcleo — D-F113,
D-F120, D-F122) e `f2a-a1-nfse` reescrito.

**Provas**: núcleo **463/463** (`tsc` limpo, `dist/` refeito) · nfse-api **691 unit** + ao vivo **183/183** (as 150 + o gate da A1 com a parte viva em `fiscal_api_adv_gatea1*`, criados do zero e apagados) · nada aplicado no `fiscal_api` do dev (as 005 entram no próximo boot/`db:migrate` da nfse-api, depois de publicadas).


**PUBLICADA a A1 (Valdo: "salva tudo e vamos abrir uma nova seção", 2026-10-12)** — núcleo 1cc8e99 · nfse a930827 · infra 9cb8612.

#### 22.8 ⏯ PROMPT DE RETOMADA — etapa A2 da F2a (colar numa sessão nova)

```
Retome a F2a (setes-api PASSIVO) do Gestão 2027 pela etapa A2. Leia primeiro D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22 inteiro (Rodada 0 → §22.1–§22.5; Rodada 1 → §22.6; A1 + gates +
Rodada 2 → §22.7) e as decisões D-F109…D-F123 no §7. A1 PUBLICADA (núcleo 1cc8e99 · nfse a930827). Nenhuma questão aberta.

REGRAS DURAS (não negociar):
- A árvore D:\Gestao2027\setes-api roda em `tsx watch` e É a produção da Setes: salvar um arquivo = deploy; o boot aplica as
  migrations do disco. NADA da F2a se escreve nela fora do merge de um item APROVADO (D-F117).
- A F2a se desenvolve na WORKTREE D:\Gestao2027\setes-api-f2a (branch `f2a`, criada a partir do `main` do setes-api) com .env,
  secrets/ e node_modules PRÓPRIOS (cópias locais, fora do git — nunca imprimir conteúdo deles). Testes ali (mocks e bancos
  descartáveis); as cercas do núcleo e da nfse-api leem SETES_API_DIR (padrão: a árvore viva) e falham alto quando o arquivo
  vigiado some — rodar as suítes do núcleo/nfse com SETES_API_DIR=D:\Gestao2027\setes-api-f2a para ver a worktree.
- Ordem (D-F111, §22.3): A2 = só o que NÃO depende de onde a voz mora, item a item, cada um com testes + gate do delta e
  merge na árvore viva (= deploy) só com o "pode publicar" do Valdo; A3 (porta fiscal-voice, plano/dispensa/selo/fiscalEffectOf,
  rotas cancel-plan/fiscal-effect, invoice-series, remoção das 14 rotas, migration 068_f2a_fiscal_passivo com os triggers da
  D-F110) fica na worktree e só entra na JANELA única da virada (com a F2b), antes de 30/11.
- NUNCA `migrate:setes --cutover … --vai` fora da janela decidida; testes ao vivo só em cópias descartáveis.
- Decisões de arquitetura são do Valdo; recomendações que se contradizem entre os gates são perguntadas à parte.
- Commit só dos caminhos da frente, mensagem em arquivo UTF-8 sem BOM (`git commit -F`); editar com ferramenta de edição ou
  Node em UTF-8 (nunca Set-Content; o heredoc do Bash corta barras invertidas — script por arquivo).

ITENS DA A2 (§22.3 + §22.5 + o achado da A1):
1. Worktree `setes-api-f2a` + dependência `fiscal-api` SÓ pelo subpath `fiscal-api/reading` (cerca D-NE77 já existe no núcleo);
   a package-lock do setes-api está no .gitignore — anotar o pino da dependência para a F3.
2. `vw_order_interface` (migration 065) com `interface_key` COLLATE utf8mb4_bin — dá erro 1267 numa conexão
   utf8mb4_general_ci (achado da A1, §22.7) — migration NOVA do setes-api (combinar o número com a IB-2; a 068 fica reservada
   para o `f2a_fiscal_passivo` — D-F50 quer o nome fixo no ÚLTIMO arquivo da F2a).
3. `resolveOrderInterface` e o leitor da VIDA (`lockInvoice`/`LAST_INVOICE_EVENT_KIND_SQL`) lendo `vw_order_interface` e
   `vw_invoice_life` (D-F32 — elimina a duplicidade que JÁ existe), com prova de equivalência no molde da 065.
4. D-F37 nas rotas do ERP (o admin passa só o privilégio, nunca a licença do ramo — `require-privilege.ts:63/97/139`):
   conferir ANTES, no dado, quem perderia acesso (molde da D-F37 de 2026-10-04).
5. JWT RS256 com `kid` (D-F13) no token final e no de seleção (marca própria; nunca vale como final); `auth.middleware`
   com `algorithms: ['RS256']`; scripts (trilha, smokes, generate-token) e ~20 testes que assinam HS256; relogin dos usuários.
6. Boot do setes-api: `assertFamilyViewsReadable` (D-F113) com o usuário de leitura do `fiscal_api` — exige o GRANT do
   `setes_api` na view de tentativas (`nfse-api/ops/grants.sql`) e a conexão ao `fiscal_api`; ordem de deploy: nfse-api antes.
   ⚠️ Pesar com o Valdo se este item entra antes da janela (o boot do setes-api passaria a depender do `fiscal_api` no ar).
7. Antes de tudo: aplicar no `fiscal_api` do DEV as migrations 005 da A1 (`npm run db:migrate` na nfse-api — a habilitação de
   lá é RÉPLICA; dados conferidos dentro dos domínios) e rodar `npm run migrate:setes -- --dry-run` para ver a re-sincronia
   com a conferência nova da origem.
Para cada item: testes, gates do delta (socrático ≥ 0,70 + adversarial sem HIGH), docs (§22.9+), e só então o merge.
Corte da F2a: 30/11 (D-IB15).
```

### 22.9 Etapa A2 — executada na WORKTREE (2026-10-12) — itens 1–5 prontos; item 6 aguarda o Valdo; NADA na árvore viva

**Onde**: worktree `D:\Gestao2027\setes-api-f2a`, branch `f2a` (criada do `main` 6bd6f83 — D-F117), com `.env` (PORT 3010, sem `JWT_SECRET`,
com `JWT_PRIVATE_KEY_PATH`/`JWT_KID`), `secrets/` e `node_modules` copiados da árvore viva (fora do git). ⚠️ **Nunca `npm run dev` na
worktree**: o `.env` aponta para o MESMO MySQL da produção e o boot aplica as migrations do disco da worktree em todo schema ativo.
Testes ali (mocks) e provas só de leitura no banco real; DDL só em banco descartável.

**Item 7 (antes de tudo)**: `npm run db:migrate` na nfse-api aplicou no `fiscal_api` do dev as 005 da A1 (`fiscal-api/005_issuer_domains_binary`,
`nfse-api/005_service_transmission_domains`); `npm run migrate:setes -- --dry-run` limpo (setes_setes: 1 habilitação, mesmo A1, 20 tentativas
re-sincronizáveis, 0 vozes novas, 0 falhas).

| Commit (`f2a`) | Item | O quê | Prova |
|---|---|---|---|
| `a41406e` | 1 | dependência `fiscal-api: file:../fiscal-api` (só o subpath `fiscal-api/reading` — cerca D-NE77 do núcleo); nenhum import ainda; pino na F3 (a `package-lock` segue no `.gitignore` — R13) | `node_modules` da worktree = o da viva + `fiscal-api` (diff de versões de topo) |
| `889bad5` | 2–3 | migration **068** `order_interface_view_bin` (`interface_key` `COLLATE utf8mb4_bin`); `resolveOrderInterface` lê `vw_order_interface`; `lockInvoice` = `FOR UPDATE` na nota (1º comando) + vida/último evento da `vw_invoice_life` em `LOCK IN SHARE MODE` (molde do `erp.lockInvoice` do núcleo; `lifeEvent` no retorno — a A3 escopa a leitura da voz pela vida, D-F119); `LAST_INVOICE_EVENT_KIND_SQL` e `CURRENT_RETURN_SQL` leem a `vw_invoice_life` — uma definição de "último evento" só (D-F32) | 1267 reproduzido na view VIVA numa conexão `general_ci`; a 068 em banco descartável (`f2a_probe_068`, apagado): 0 erro nas 3 colações, contagens iguais (344/51/7.552), view fundida; `scripts/prove-policy-views.ts` (SÓ LEITURA, no banco real): regra antiga × leitores novos em **7.947 pedidos, 7.432 notas e 7 vínculos de devolução — zero divergência**, 0 ramo/evento órfão, EXPLAIN por chave |
| `318f994` | 4 | D-F37 nas 3 guardas (`requirePrivilege`, `requirePrivilegeFor`, `requireInterfaceFor`): licença (interface contratada) para TODOS antes do privilégio; admin/super passam só o privilégio; lista = só as contratadas | dado conferido ANTES: a única institution ativa contrata `orders`/`service-orders`/`order-returns`/`settlements` e não há privilégio ativo de usuário comum — ninguém perde acesso |
| `aa13633` | 5 | D-F13: `@shared/auth/product-token` — RS256 com `kid` (`JWT_PRIVATE_KEY_PATH`, `JWT_KID` padrão `default`, `JWT_PUBLIC_KEYS` = chaves anteriores na rotação); token FINAL recusa `scope` e exige a forma (schema pelo padrão); token de SELEÇÃO exige `scope` e recusa `institutionId`; boot não sobe sem a chave (`assertJwtKeys`); `JWT_SECRET` só gera aviso; scripts e testes assinam pela chave (setup do jest gera o par de TESTE uma vez) | o token emitido passa no verificador REAL do núcleo com a pública da nfse-api; o de seleção é recusado lá; o par de dev existente (2048 bits) confere com a pública que a nfse-api usa |

**Achado de SEGURANÇA (fechado pelo item 5 quando publicado)**: o `JWT_SECRET` HS256 de PRODUÇÃO era idêntico ao valor fixo em
`setes-api/scripts/generate-token.ts`, versionado desde 2026-07-04 num repositório **PÚBLICO** (`valdosouza/gestao-2027-setes-api`) — qualquer
pessoa podia assinar um token de `super`. Com o RS256 o segredo deixa de valer (HS256 recusado por construção); o script passou a assinar pela
chave do `.env`. O histórico do git continua com o valor (inofensivo depois do item 5).

**Provas da A2**: setes-api — `tsc` limpo; suíte **2.252 ok + 20 falhas PRÉ-EXISTENTES idênticas às do `main`** (nome a nome: 19 da bomba-relógio
do boleto + 1 da cerca de fuso — falso positivo num COMENTÁRIO em `cashier.repository.ts:95`, desde a IB-1); núcleo **463/463** e nfse-api **691**
com `SETES_API_DIR=D:/Gestao2027/setes-api-f2a` (cercas da D-F117 lendo a worktree).

**Observação de UX (fora da F2a)**: o setes-app não tem tratamento global de 401 (`api_client.dart` lança `UnauthorizedFailure`, ninguém o
captura para voltar ao login) — o deploy do RS256 se comporta como a expiração diária de 24 h: o usuário vê "Token inválido ou expirado" e entra
de novo.

#### 22.9.1 Gates do delta da A2 — socrático **0,73 ✅** · adversarial **0,70 ✅** (nenhum CRITICAL/HIGH no delta; 4 MEDIUM)

Agentes independentes; achado confirmado vira teste em `setes-api/src/__tests__/adversarial-f2a-a2-gate.test.ts` (parte viva opt-in
`F2A_ADV_LIVE=1`, banco descartável `f2a_adv_a2_*` criado e apagado). **Corrigidos na sessão** (commit `e0331dc`):

| Achado | O quê | Correção |
|---|---|---|
| **F2A2-ADV-02** MEDIUM (os DOIS gates; provado ao vivo) | `vw_invoice_life … LOCK IN SHARE MODE` só é fresca nas tabelas do JOIN — os `NOT EXISTS` da view (o "último evento") leem o RETRATO do REPEATABLE READ; retrato aberto ANTES da trava da nota + re-faturamento no intervalo (E1, C2 → E3) = 4 linhas, a 1ª velha. O leitor antigo (`FOR UPDATE … LIMIT 1`) era fresco | `lockInvoice` RECUSA mais de uma linha → 409 `RESOURCE_BUSY` (refazer abre retrato novo depois da trava); nunca "pega a primeira". Conhecimento negativo no PADROES §11 regra 13 |
| **F2A2-ADV-04** MEDIUM | o runner decide pelo NÚMERO — outra frente com a mesma versão (a IB-2) faria uma migration ser pulada calada | o boot FALHA ALTO com versão repetida nos arquivos ou versão aplicada com outro nome (conferido antes: os 67 nomes aplicados batem com os arquivos); D-F110 com errata (o número do `f2a_fiscal_passivo` é o próximo livre na janela) |
| **F2A2-ADV-01/01b** MEDIUM | o lote de transmissão passava com QUALQUER ramo contratado e o item pulava a licença | licença do ramo por item, para todos (D-F37) |
| **F2A2-ADV-07** LOW | token sem `exp` valia para sempre | `exp` obrigatório |
| socrático 8/10, adversarial 08 | 401 sem `code`; códigos fora do catálogo; cerca do subpath só no núcleo; EXPLAIN da prova com id inexistente ("Impossible WHERE") | `code` no 401; `INTERFACE_NOT_ALLOWED`/`UNAUTHORIZED` no catálogo; `f2a-fiscal-api-fence.test.ts` na suíte do setes-api; prova com ids reais (falha se a tabela vier nula) |

**Limites conhecidos (código que MORRE na A3; hoje os 4 ramos estão contratados)**: `POST /fiscal/refresh` sem escopo de ramo (ADV-01c); `GET
/fiscal/pending` sem licença (ADV-06); o "plano do cancelamento fiscal" abre o retrato antes da trava da nota (ADV-02b — com a correção do
ADV-02 o efeito é 409 retryable, nunca vida velha); cópias de "último evento" em `lastInvoiceEventAny`/rodízio/`LIFE_WHERE` (ADV-09).
**Para a A3**: todo leitor escopado pela vida (D-F119) exige 1 linha da view ou trava a nota antes de qualquer leitura; o `erp.lockInvoice` do
núcleo tem o MESMO molde (seguro hoje só porque `withInvoiceTx` põe a trava como 1º comando) — levar a mesma recusa; o comentário de
`fiscal-api/src/erp/facts.ts:282` cita a 068 (corrigir junto).

**Pendências de deploy (não são do código)**: (1) o `.env` da árvore viva NÃO tem `JWT_PRIVATE_KEY_PATH`/`JWT_KID` — publicar o item 5 sem
isso derruba a produção no boot (falha segura: nunca volta ao HS256); o par existe em `setes-api/secrets/jwt/` e confere com a pública da
nfse-api; (2) relogin de todos — o app não trata 401 globalmente; (3) espelho da 068 no `sql/03` (com `SET NAMES utf8mb4` antes — latin1 dá 1253).

**Provas depois das correções**: setes-api 2.278 ok + as MESMAS 20 falhas do `main` (nome a nome); `tsc` limpo; prova de equivalência
refeita (zero divergência, EXPLAIN por chave em ids reais); parte viva do gate (1267 × 068 e o fato do motor) em banco descartável, apagado.

#### 22.9.2 Roteiro de PUBLICAÇÃO da A2 (= deploy; só com o "pode publicar" do Valdo)

Os commits do `f2a` são lineares sobre o `main` 6bd6f83 — publicar = `git -C D:/Gestao2027/setes-api merge --ff-only <commit>` (mesmos
hashes; se o `main` andou — a IB-2 —, rebase do `f2a` antes e suíte de novo). Em ordem:
1. **`.env` da árvore viva ANTES de tudo**: `JWT_PRIVATE_KEY_PATH=./secrets/jwt/setes-api.private.pem` + `JWT_KID=default`; tirar `JWT_SECRET`
   (o `tsx watch` não relê o `.env` sozinho — nada muda até o próximo restart).
2. `npm install` na árvore viva (cria o link `node_modules/fiscal-api`; conferir que as versões de topo não mudaram — na worktree só entrou o
   `fiscal-api`).
3. `merge --ff-only f5eee3b` (tudo da A2 — ponta do `f2a`) → o `tsx watch` reinicia → boot: "JWT do produto: RS256, kid 'default'" + "Migration aplicada: 068 -
   order_interface_view_bin" no `setes_setes`. Conferir no log; `scripts/prove-policy-views.ts` de novo na árvore viva (só leitura).
4. Relogin (Sair e entrar no app); trilha (`scripts/trilha-primeiro-cliente.ts`, assina pela chave nova).
5. Espelho da 068 no `sql/03`; push dos repos (setes-api público — o segredo antigo segue no histórico, inofensivo depois do RS256).
Publicação por item (cherry-pick) continua possível se o Valdo quiser só parte — o item 5 sozinho exige o passo 1.

#### 22.9.3 Rodada 3 da F2a — questões abertas pelos gates da A2 — DECIDIDAS (Valdo 2026-10-12: as quatro recomendações → D-F124…D-F127)

- ⚠️ **Q-F134 (URGENTE) — contenção do segredo HS256 vazado (repositório público desde 2026-07-04)**: (a) **publicar a A2 agora** pelo
  roteiro do §22.9.2 (o RS256 aposenta o segredo; relogin de todos) · (b) só girar o `JWT_SECRET` no `.env` vivo agora (novo valor
  aleatório + restart; relogin) e publicar a A2 depois · (c) esperar o fluxo normal. *(Rec.: (a) se a publicação for hoje; senão (b)
  imediatamente — enquanto o segredo velho vale, qualquer um assina token de super. O log "Auth OK" não distingue token forjado: não há
  como auditar o passado.)*
- **Q-F135 — escopo da D-F37 nas ações NÃO fiscais** (FATURAR em billing/OS/devolução, ALTERAR em settlements): (a) **licença para todos em
  toda guarda de ação** (EXECUTADO assim — coerente com a D-F14; impacto zero no dado de hoje) · (b) restringir às ações fiscais
  (TRANSMITIR/CANCELAR e leituras Q-N32). *(Rec.: (a); consequência: um cliente que contrate `orders` sem `order-returns` não fatura
  devolução, nem o admin.)*
- **Q-F136 — leitor da vida pela view travante** (F2A2-ADV-02, EXECUTADO como assunção): (a) **`lockInvoice` exige 1 linha da view; mais =
  409 retryable; levar a mesma recusa ao `erp.lockInvoice` do núcleo na A3** · (b) voltar ao leitor travante direto em `tb_invoice_event`
  (fresco por construção, mas 2ª cópia da regra — contraria a D-F32) · (c) só conhecimento negativo. *(Rec.: (a).)*
- **Q-F137 — item 6 da A2 (`assertFamilyViewsReadable` no boot do setes-api, D-F113)**: (a) **vai para a A3**, junto da porta
  `fiscal-voice` — antes da janela nada no setes-api lê o `fiscal_api`, a conferência não protegeria nada e o boot passaria a depender do
  `fiscal_api` no ar e do GRANT · (b) entra já na A2. *(Rec.: (a).)*
- (procedimento, sem questão) transição do RS256 no app: avisar "Sair e entrar" no deploy; o tratamento global de 401 (→ login) entra na F2b.

#### 22.9.4 A2 PUBLICADA na árvore viva (2026-10-12, D-F124) — produção da Setes em RS256

Pelo roteiro do §22.9.2: `.env` vivo ganhou `JWT_PRIVATE_KEY_PATH`/`JWT_KID` (cópia do anterior no scratchpad da sessão) → `git merge --ff-only
f5eee3b` no `main` da árvore viva → o `tsx watch` reiniciou (PID 22984 → 26648), `/health` ok, **068 aplicada no `setes_setes` às 21:38 UTC**
(`interface_key` = `utf8mb4_bin`; a view responde em `general_ci` e `unicode_ci`) → `JWT_SECRET` retirada do `.env` → `npm install` (só o
link `fiscal-api` entrou; versões de topo iguais; o servidor não reiniciou). **Provas em produção (só leitura)**: token RS256 → 200 em
`/api/core/me`; **token HS256 com o segredo vazado → 401** `{"error":"Token inválido","code":"UNAUTHORIZED"}`; token de seleção em /api → 401;
leitura fiscal da OS 7374 (licença `service-orders`) → 200; `scripts/prove-policy-views.ts` na árvore viva → zero divergência. Espelho da
068 no `sql/03`. A trilha (`trilha-primeiro-cliente.ts`) NÃO foi rodada (escreve dados de teste na produção — rodar com o Valdo).
**Relogin**: todo token HS256 em uso virou 401 — no app, "Sair e entrar" (sem tratamento global de 401 até a F2b).
**PUBLICADA no GitHub (Valdo: "vai", 2026-10-12)**: setes-api f5eee3b · sql 5f7d694 · infra a91abd9 (scan antes do push: nenhum arquivo
sensível, nenhuma chave privada, o segredo antigo fora do diff). Serviços reiniciados para o teste do Valdo (setes-api :3000 em RS256 ·
setes-app web :5051). A worktree `setes-api-f2a` continua para a A3 (branch `f2a` = `main` agora).

#### 22.10 ⏯ PROMPT DE RETOMADA — etapa A3 da F2a (colar numa sessão nova)

```
Retome a F2a (setes-api PASSIVO) do Gestão 2027 pela etapa A3. Leia primeiro D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22 inteiro (Rodada 0 → §22.1–§22.5; Rodada 1 → §22.6; A1 → §22.7;
A2 → §22.9, gates §22.9.1, publicação §22.9.4) e as decisões D-F109…D-F127 no §7. A2 PUBLICADA (setes-api main f5eee3b:
068, leitores pelas views da 065, D-F37 em toda guarda, JWT RS256 com kid). PADROES_BANCO §11 regras 11–14.

REGRAS DURAS (não negociar):
- A árvore D:\Gestao2027\setes-api roda em `tsx watch` e É a produção da Setes: salvar = deploy; o boot aplica as migrations.
  O lote da A3 NÃO entra nela antes da JANELA única (D-F111) — fica na worktree D:\Gestao2027\setes-api-f2a (branch `f2a`,
  hoje = main; `.env` com PORT 3010 e RS256; NUNCA `npm run dev` nela: o .env aponta para o MySQL de produção).
- Rodar a suíte do setes-api SEM editar nada durante a execução (baseline contaminada); a base tem 20 falhas pré-existentes
  (19 bomba-relógio do boleto + 1 falso positivo da cerca de fuso num comentário de cashier.repository.ts:95).
- Testes ao vivo só em banco descartável; nunca `migrate:setes --cutover … --vai` fora da janela; decisões são do Valdo.
- Commit só dos caminhos da frente, mensagem em arquivo UTF-8 sem BOM; push só com o "vai".

ITENS DA A3 (§22.3 + D-F110…D-F127):
1. Porta `src/shared/fiscal-voice/` (único lugar que lê o `fiscal_api`; só `fiscal-api/reading` — D-NE77; cerca já na suíte:
   `f2a-fiscal-api-fence.test.ts`) + conferência do boot `assertFamilyViewsReadable` (D-F113/D-F127; GRANT do `setes_api` só na
   view de tentativas — nfse-api/ops/grants.sql; ordem de deploy: nfse-api antes).
2. Plano do cancelamento, dispensa ("manter a nota"), selo da lista de OS e `fiscalEffectOf` (D-F114) pela porta, com os
   predicados do núcleo (nada por coluna crua — `accessKey`/`environment`/`last_queried_at` não decidem fora do núcleo); leitura
   da voz DEPOIS do FOR UPDATE da nota (D-F121) e escopada pela VIDA do `lockInvoice` (D-F119) — exigir 1 linha (D-F126; levar a
   mesma recusa ao `erp.lockInvoice` do núcleo e corrigir o comentário da 068 em fiscal-api/src/erp/facts.ts:282).
3. Rotas `GET /api/billing/:orderId/cancel-plan` e `GET /api/billing/:orderId/fiscal-effect` (D-F115); `@shared/invoice-series`
   (D-F112); remoção das 14 rotas + peças fiscais + espelhos + `setTransmissionEventEffect` (os limites ADV-01c/ADV-06/ADV-02b do
   gate da A2 morrem aqui); as cercas dos irmãos que vigiam esses arquivos (SETES_API_DIR — D-F117) revistas na MESMA entrega.
4. Migration `NNN_f2a_fiscal_passivo` (D-F110 — o NÚMERO é o próximo livre na janela; o runner falha alto com número repetido):
   triggers de trava (1º trigger de TRAVA da casa → regra nova no PADROES + revisar-ddl) + COMMENTs, sem DROP.
5. Prova de aceite: leitor novo na réplica recém-sincronizada × leitor velho na origem = 0 divergência (selo, bloco fiscal do
   plano, pendência, prova).
Gates socrático + adversarial ANTES da janela; a F2b (app) tem Rodada 0 própria (inclui o tratamento global de 401 → login).
Corte da F2a: 30/11 (D-IB15).
```

### 22.11 Etapa A3 — executada na WORKTREE (2026-10-12/13) — NADA na árvore viva; entra só na JANELA (D-F111), junto da F2b

> Valdo (2026-10-12, depois de publicar a A2): *"siga para a A3"*. Tudo na worktree `D:\Gestao2027\setes-api-f2a` (branch `f2a`, sobre o
> `main` publicado f5eee3b) e em commits LOCAIS do núcleo e da nfse-api (sem push). ⚠️ **A A3 NÃO pode ir sozinha para a árvore viva**:
> o setes-app de hoje chama as 14 rotas que ela remove — só com a F2b (Rodada 0 própria), na janela única.

| Commit | O quê |
|---|---|
| setes-api `ca81906` | **bloco 1** — porta `src/shared/fiscal-voice/` (o ÚNICO leitor do fiscal_api; só `fiscal-api/reading`; escopada pela VIDA; `FISCAL_DB_NAME`, nunca `setes_*`); `src/shared/invoice/invoice-fiscal-effect.ts` (barreira do cancelamento local pelos predicados do núcleo — viva barra; autorizada barra só com registro fiscal, Q-CA5b — + VEREDITO da reconferência D-F109: o setes-api nunca pergunta ao fisco, D-F4; `fiscalEffectOf` none/apply/decide/cancel, D-F114; selo em lote nota × vida; registro fiscal = `isFiscalRecord`, nota (8)); plano de cancelamento, "manter a nota" e selo da lista de OS pela porta DEPOIS da trava da nota (D-F121), sem o vínculo do efeito gravado na voz (D-F28/D-F110); rotas `GET /api/billing/:orderId/cancel-plan` e `GET /api/billing/:orderId/fiscal-effect` (D-F115); REMOVIDAS as 9 rotas fiscais do billing + 5 do emissor, `@shared/invoice-transmission`, `tax-authority`, `danfse`, `fiscal-issuer` (a série → `@shared/invoice-series`, D-F112); `dps_number` aposentada no revive; conferência das views no boot (D-F113/D-F127); trilha P8b pela nfse-api; 28 suítes do código morto removidas; testes novos sobre LINHAS REAIS da view com o mapa da família (nota (5), caso positivo da prova incluso); cerca da A3 por AST (`f2a-a3-cerca.test.ts`: nada de URL/porta das APIs fiscais; fiscal_api só na porta; nada das tabelas fiscais do ERP; habilitação só como série; nada de `environment === 'H'|'P'`, `lastQueriedAt` ou `!!accessKey` decidindo) |
| setes-api `873f0b7` | **bloco 2** — migration **`069_f2a_fiscal_passivo`** (D-F110): 9 gatilhos de TRAVA (`tg_f2a_freeze_*` — o 1º da casa, PADROES §11 regra 15 + `revisar-ddl`): tentativas e vozes do ERP = ORIGEM CONGELADA (INSERT/UPDATE/DELETE recusados, errno 1644); linha SE da habilitação só aceita o ATO da virada (N→S — o UPDATE exato do `cutover-erp.ts`), sem INSERT de SE (nem `'se'`), revive, troca de ambiente/contador/modelo ou DELETE; 55/65 livres; COMMENTs de aposentadoria sem DROP; re-executável. Número = o próximo livre HOJE; o NOME é o fato (D-F50) e o arquivo tem de ser o ÚLTIMO (teste) — renumerar na janela se a IB-2 publicar migration antes. `splitStatements` do runner exportado (a prova usa o divisor do boot) |
| setes-api `2938161` · `354d615` | comentários (estado fiscal lido pela porta; `pre-deploy-tz-check` sobre a origem congelada — §22.5 item 14: leitura histórica válida, o ato recusa virar com tentativa viva) · **prova de aceite** `scripts/prove-f2a-aceite.ts` (lado novo) + `scripts/prove-f2a-aceite-origem.ts` (lado velho — roda com o código da árvore viva ANTES do merge) |
| núcleo `c2cd4c6` | D-F126 no `erp.lockInvoice` (mais de uma linha da view de vida = 409 RESOURCE_BUSY); comentário da 068 → nome fixo; cercas r19/r22 com `setesApiPathUntilF2a` (D-F117 revisto: o arquivo vigiado existe até a A3; ausente SÓ com a F2a aplicada — a migration de nome fixo no `SETES_API_DIR` — e aí a cerca confere o "depois") |
| nfse-api `8541025` | o mesmo nas cercas r19/r21/r22/`voice-kind-fence` (`VOICE_SQL_WRITERS` sem o escritor do setes-api depois da F2a) |

**Assunções — CONFIRMADAS (Valdo 2026-10-13: "siga as recomendações" → D-F128/D-F129)**: **A-F115** — o `GET …/cancel-plan` roda o MESMO `buildCancelPlan` do POST numa transação SEMPRE desfeita (as travas duram a leitura; lock wait → 409 RESOURCE_BUSY): a D-F115 diz "consultiva, não travante"; tornar o plano não travante exigiria uma 2ª versão dele (política em duas cópias). **A-F110** — a 069 também recusa o DELETE físico (a decisão nomeia INSERT/UPDATE).

**Provas**: setes-api — `tsc` limpo; suíte **1.713 ok + as mesmas 20 falhas do `main`** (bloco 1; os blocos seguintes somaram testes); núcleo **466/466** e nfse-api **691** com `SETES_API_DIR` na árvore viva E na worktree; **069 em banco descartável 25/25** (`scripts/prove-f2a-passivo.ts` — cada escrita barrada pelo errno 1644, o ato passa, 55 livre, colunas com tipo/nulo/padrão iguais); **prova de aceite: 4 notas com tentativa no ERP, ZERO divergência** (selo, bloco fiscal, registro, pendência — réplica recém-sincronizada pelo `migrate:setes`, que só escreve no `fiscal_api`). Antes disso, o `migrate:setes -- --dry-run` limpo e as 005 da A1 aplicadas no `fiscal_api` do dev.

**Roteiro da JANELA (B) — detalha o §22.3** (com o "vai" do Valdo em cada passo irreversível):
1. F2b pronta (build do app que fala com a nfse-api — emissor, transmitir, consultar, cancelar no fisco, XML/DANFSe, lote no cliente — e com o setes-api só para `cancel-plan`/`fiscal-effect`/`cancel`/`cancel-waiver`; tratamento global de 401).
2. Avisar e PARAR o uso; nfse-api no ar com as migrations 001–005 (as views) — ordem de deploy D-F113; GRANT de SELECT na view de tentativas ao usuário do setes-api (`nfse-api/ops/grants.sql` — no dev o `setes` já lê).
3. Prova de aceite: lado velho (árvore viva) → `npm run migrate:setes` → lado novo (worktree) = 0 divergência fora do "reconfirm" esperado.
4. Conferir o número da `NNN_f2a_fiscal_passivo` contra o `main` (a IB-2) — renumerar se preciso (o teste exige que seja a última); `git -C setes-api merge --ff-only f2a` (rebase antes se o `main` andou) → o `tsx watch` reinicia → boot: "Voz do fisco (views): fiscal_api — família(s) service" + "Migration aplicada: 069 - f2a_fiscal_passivo".
5. `npm run migrate:setes -- --cutover 1 --confirmo-setes-api-parado` (ENSAIO) → com o "vai": `… --vai` (D-F44: aposenta a SE do ERP — o gatilho deixa o N→S passar).
6. Publicar o build da F2b (cache do Flutter web); relogin.
7. Trilha (`scripts/trilha-primeiro-cliente.ts` — front-end das duas APIs; P8b pela nfse-api) → reabrir.
8. Depois: apagar o A1 do cofre do setes-api (D-F116, com o "vai"); push dos repos; F3 (Onda 4).

**Gates da A3**: lançados (socrático + adversarial, agentes independentes) e INTERROMPIDOS na troca de sessão a pedido do Valdo — nenhum
resultado parcial, nenhum banco descartável nem arquivo de teste sobrou. 1º passo da próxima sessão: relançá-los (§22.12).

**Salvo (Valdo 2026-10-13: "salve tudo para nova seção")**: worktree `setes-api-f2a` branch `f2a` = ca81906 · 873f0b7 · 2938161 · 354d615 (+ docs
desta seção), publicada como BRANCH `f2a` no GitHub do setes-api (o `main` NÃO muda — a A3 só entra na janela); núcleo c2cd4c6 e nfse-api
8541025 publicados no `main` deles (valem antes e depois da F2a — as cercas passam nas duas árvores); Infra-IA com esta seção.

#### 22.12 ⏯ PROMPT DE RETOMADA — gates da A3 → F2b → janela da F2a (colar numa sessão nova)

```
Retome a F2a (setes-api PASSIVO) do Gestão 2027. Leia D:Gestao2027CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.11 (A3 executada + roteiro da JANELA) e o §22.12 (este prompt);
consulte §22.2/§22.3 e as decisões D-F109…D-F129 (§7) só quando precisar. A2 PUBLICADA (setes-api main f5eee3b — RS256 em produção).
A3 PRONTA na worktree D:Gestao2027setes-api-f2a (branch f2a; também no GitHub como branch f2a). Núcleo c2cd4c6 / nfse-api 8541025 no main.

REGRAS DURAS
- D:Gestao2027setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A A3 SÓ entra na
  JANELA, junto da F2b (o app de hoje chama as 14 rotas que a A3 remove). Nunca npm run dev na worktree (o .env aponta para o MySQL de
  produção). Nunca migrate:setes --cutover … --vai fora da janela. Testes ao vivo só em bancos descartáveis (prefixo f2a_*), apagados no fim.
- Rodar a suíte do setes-api SEM editar arquivos durante a execução; a base tem 20 falhas pré-existentes (19 bomba-relógio do boleto +
  1 falso positivo da cerca de fuso — há chip para isso). As cercas do núcleo/nfse-api: rodar com SETES_API_DIR nas DUAS árvores.
- Edição em UTF-8 pela ferramenta de edição ou script Node em ARQUIVO (heredoc com escapes aninhados falha); commit só dos caminhos da
  frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.

PASSO 1 — GATES DA A3 (em paralelo, agentes independentes, run_in_background): alvo = git diff f5eee3b..f2a na worktree + núcleo
c2cd4c6 + nfse-api 8541025.
  • socrático: skill Infra-IA/skills-genericas/revisar-riscos-sistemicos.md (score ≥ 0,70) — perguntas-chave: a janela do §22.11 é
    executável sem estado intermediário quebrado? o boot agora depende do fiscal_api — falha em RUNTIME vira 500 em quais rotas (lista de
    OS)? o GET cancel-plan (D-F128) gera contenção? a prova de aceite com 4 notas prova o quê? algo ainda decide por coluna crua?
  • adversarial: skill Infra-IA/skills-genericas/testar-adversarial.md (sem HIGH/CRITICAL) — testes NOVOS em
    src/__tests__/adversarial-f2a-a3-gate.test.ts; atacar o cancelamento local de NFS-e AUTORIZADA em produção (vidas misturadas, prova
    forjada, irmã viva, minúsculas, view sem authority_recorded), o "manter a nota" fora da substituição em P, as rotas novas, e FURAR os
    gatilhos da 069 em banco descartável (INSERT IGNORE, REPLACE, ON DUPLICATE KEY UPDATE, TRUNCATE — não dispara gatilho de DELETE —,
    LOAD DATA, UPDATE multi-tabela, 'SE ' com espaço); o ato exato do nfse-api/scripts/cutover-erp.ts tem de passar.
  Correções em sessão; achado que exige decisão → questão numerada (Q-F134+ já usadas: começar em Q-F138) com recomendação.
PASSO 2 — F2b (setes-app) Rodada 0: inventário dos 2 datasources que chamam as 14 rotas (service_order_fiscal_datasource.dart,
  establishment_issuer_datasource.dart), o que a nfse-api devolve (openapi/nfse-api.v1.yaml) × o que a tela consome, datasources dedicados
  da nfse-api (D-F4), a tela "No fisco" compondo nfse-api (fisco) + setes-api (cancel-plan, fiscal-effect, cancel, cancel-waiver — D-F115),
  lote no cliente, emissor/A1 direto na nfse-api, tratamento global de 401 (relogin), cache do Flutter web; parecer do guardião
  (setes-conceito) e Rodada 1 de questões para o Valdo. F2b em worktree do app.
PASSO 3 — a JANELA pelo roteiro do §22.11 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15).
Ao fim de cada passo: docs (§22.13+), INDICE_CENTRAL, CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```


### 22.13 Gates da A3 (2026-10-13) — socrático **0,73 ✅** · adversarial **0,72 ✅** (nenhum CRITICAL/HIGH) — correções da sessão + Rodada 4 da F2a (Q-F138…Q-F144)

> Valdo (2026-10-13, prompt do §22.12): "PASSO 1 — gates da A3 (em paralelo, agentes independentes)". Agentes que NÃO fizeram a entrega;
> alvo = `f5eee3b..f2a` da worktree + núcleo c2cd4c6 + nfse-api 8541025. Achado confirmado vira teste em
> `setes-api/src/__tests__/adversarial-f2a-a3-gate.test.ts` (parte viva opt-in `F2A_ADV_LIVE=1`, bancos `f2a_adv_a3_*` criados e apagados).

**Socrático 0,73** (checklist da skill, peso igual + item "janela executável"): núcleo da A3 sólido (predicados do núcleo, leitura pela vida,
trava da nota antes da voz, 1 linha da view de vida); notas baixas em falha externa (0,55 — o boot depende do `fiscal_api`; em execução vira
500), concorrência (0,60 — o GET do plano trava) e janela (0,60 — o intervalo entre o `migrate:setes` do passo 3 e o `--vai`). Limites
ADV-01c/ADV-06/ADV-02b/ADV-09 da A2 confirmados MORTOS. **Adversarial 0,72** (42/42 com a parte viva): resistiram vidas misturadas, prova
forjada (E2404 anterior/igual/fora do formato), irmã viva, minúsculas (`a`/`c`/`se`/`p`/`s` falham alto ou viram vivas), D-F126 (2 linhas
→ 409), "manter a nota" fora da substituição em P (409 sem escrita em 11 casos), rotas novas (403/400/404/409 sem transação nem escrita;
deadlock 3× → 409), selo em lote, e os gatilhos da 069 contra INSERT IGNORE (VALUES/SELECT), REPLACE, ON DUPLICATE KEY UPDATE, UPDATE/DELETE
IGNORE e multi-tabela, UPDATE sem mudança, LOAD DATA LOCAL, `sql_mode=''`/`foreign_key_checks`/`check_constraint_checks`/`unique_checks`,
'SE'/'se'/'Se'/'SE '/'ＳＥ'/'SEX' truncado; o ATO exato do `cutover-erp.ts` passa e é idempotente.

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| F2A3-SOC-01 | MEDIUM | entre o `migrate:setes` do passo 3 e o `--vai` nada garante réplica = origem (voz A gravada no intervalo fica fora; o app velho ainda chama `POST /billing/cancel`, que lê a réplica) | **roteiro revisto** (abaixo): ensaio do ato ANTES do merge, re-sincronia + contagens depois do boot, uso parado até o `--vai` |
| F2A3-SOC-02 · ADV-03 | MEDIUM | `fiscal_api` ilegível em EXECUÇÃO → a lista de OS INTEIRA (Faturadas/Todas) e as 4 rotas de billing caem em 500 com crashlytics | **Q-F138** |
| F2A3-SOC-03 · Q-F141-ADV | MEDIUM | `GET …/cancel-plan` só exige a licença e trava X (pedido, nota, OS + trava D5, títulos — inclusive de OUTROS pedidos no boleto agrupado) por até 50 s | **Q-F139** |
| F2A3-SOC-04 | MEDIUM | o setes-api conecta como `setes` com ALL `*.*`; o usuário `setes_api` do `grants.sql` não nasce em passo nenhum — a D-F15 fica só na cerca por AST | **Q-F140** |
| F2A3-SOC-05 | MEDIUM | R13 em produção: `file:../fiscal-api` aponta para o `dist` da árvore onde a NE-1b desenvolve — recompilar o núcleo muda a produção no próximo restart | **Q-F141** |
| F2A3-SOC-06 | LOW | sem plano de aborto antes do `--vai` (reverter o código sobe, mas toda escrita fiscal do código velho bate no gatilho → 500) | **Q-F142** |
| F2A3-SOC-07 | MEDIUM | a prova de aceite cobre 2 classes do dado real (C já aplicado em P; F 403 em H) — fidelidade da cópia/mapa, não o comportamento | **critério de entrada da janela** = prova de aceite + as classes sintéticas do gate adversarial AO VIVO (vidas misturadas, prova forjada, irmã viva, substituição, de ofício, dispensa) |
| F2A3-SOC-08 | LOW | ainda decidia pela chave (`!tx.accessKey` no "manter a nota"; `current?.accessKey ?` no `fiscal-effect`) e pela letra (`lastKind === 'K'`/`!== 'C'`) | **corrigido**: `fiscalRecordKey` (a chave é IDENTIDADE, lida só depois de `isFiscalRecord`; registro sem chave falha alto); estado pelo `fiscalStateOf` do núcleo; cerca (d) ampliada por AST — a chave como CONDIÇÃO (`!x`, `x ?`, `if (x)`, `&&`/`\|\|`/`??`) e letra exclusiva da voz (S/A/N/K/R/F) comparada à mão; exceção NOMEADA só dentro de `fiscalRecordKey`; meta-teste das formas |
| F2A3-SOC-09 | LOW | `scripts/repair-authorized-cancel.ts` decide "registro fiscal" pela coluna crua sobre a origem congelada | **corrigido**: com a F2a aplicada no schema o script RECUSA (aposentado — §22.5 item 14) |
| F2A3-SOC-10 | LOW | `f2a-passivo-migration.test.ts` exigia a 069 como ÚLTIMA do REPOSITÓRIO (a 1ª migration da IB-2 depois da janela quebraria a suíte) | **corrigido**: "a última DA F2a" (068 `order_interface_view_bin` < 069); o número contra o `main` segue conferido no passo 4 da janela |
| F2A3-SOC-11 | LOW | `merge --ff-only` de ~90 arquivos sob o `tsx watch` pode subir árvore parcial | **roteiro**: parar o processo → merge → subir → ler o log |
| F2A3-SOC-12 | LOW | `cancellable` do GET ignorava a D16 (caixa aberto) — o app iria ao fisco e o POST pararia em `NO_OPEN_CASHIER` | **corrigido**: `effects.cashierOpen` (o caixa do OPERADOR, null quando não toca o caixa) e `cancellable` = sem bloqueio E caixa aberto quando preciso; Swagger |
| F2A3-ADV-01 | MEDIUM | voz A/N em PRODUÇÃO numa tentativa SEM `authority_recorded` (linha incoerente — nenhum CHECK "A ⇒ registro") → barreira `none` → o POST soft-deleta a nota e libera o número. 0 linhas assim hoje; o código da nfse-api não produz | **Q-F144** |
| F2A3-ADV-02 | LOW | '105102 ' passava no CHECK do código da voz C (colação PAD SPACE — o `_bin` do MariaDB 10.4 também) e o ERP lia `apply` em vez de `decide` | **corrigido**: migration **006** da nfse-api (`CHAR_LENGTH = 6` + lista binária, re-executável), sonda do boot ('105102 ' e '1051020' recusados pelo CHECK de NOME certo), conferência da ORIGEM no `migrate:setes` (o `INSERT IGNORE … SELECT` rebaixaria a violação a aviso); dado conferido antes: 3 vozes C, todas '101101' (6 caracteres), nos dois lados; PADROES §11 regra 16 |
| F2A3-ADV-04 | MEDIUM | o ATO conferia só `_migrations.name`; `DROP TRIGGER` (o `setes` tem ALL) deixa a escrita voltar | **corrigido no ATO** (é o texto da D-F110: "o ensaio da virada confere os triggers"): `f2aFreezeTriggersMissing` em `scripts/cutover-erp.ts` — os 9 pelo NOME no `information_schema.TRIGGERS` (tabela, BEFORE, evento, corpo com `SIGNAL 45000`); faltando = bloqueio no ensaio, recusa no ato; usuário sem o privilégio TRIGGER vê lista vazia → recusa (falha fechada); cerca: a lista = a da 069 quando a F2a está no `SETES_API_DIR`; prova VIVA (o gate chama a função real contra o banco descartável depois do DROP). O BOOT do setes-api conferir também = **Q-F143** |
| F2A3-ADV-05 | LOW | trocar o dono da linha SE (`tb_institution_id`) passava no gatilho (DELETE + INSERT disfarçados) | **corrigido** na 069 (`NOT (NEW.tb_institution_id <=> OLD.tb_institution_id)`); prova em `prove-f2a-passivo.ts` e no gate ao vivo |
| F2A3-ADV-06 | LOW | `TRUNCATE` não dispara gatilho de DELETE (com `foreign_key_checks=0` apaga a tentativa também) | **conhecimento negativo**: PADROES §11 regra 15 + teste que FIXA a semântica (a perda é acusada pela re-sincronia do ato) |

**Correções sem decisão também feitas**: OpenAPI da nfse-api — `FiscalView.substitution` (o código devolvia e o contrato não dizia —
achado do guardião da F2b); `ARQUITETURA_MODULOS.md` do app — a exceção nomeada inclui `cancel-plan|fiscal-effect` (D-F115).

**Provas depois das correções**: ver §22.13.1.

**Roteiro da JANELA (B) — REVISTO pelos gates** (substitui o do §22.11; cada passo irreversível com o "vai"):
1. **Critério de entrada**: F2b pronta (build que fala com a nfse-api e com o setes-api só em `cancel-plan`/`fiscal-effect`/`cancel`/
   `cancel-waiver`; 401 global); suítes verdes; gate adversarial da A3 com `F2A_ADV_LIVE=1` verde (as classes sintéticas — SOC-07);
   Q-F138…Q-F144 decididas e executadas.
2. Avisar e PARAR o uso (o app velho chama `POST /billing/cancel` até o build novo — SOC-01); nfse-api no ar com as migrations 001–006
   (D-F113); GRANT de SELECT na view de tentativas ao usuário do setes-api (`nfse-api/ops/grants.sql`). **Cerca da D-F148**: a nfse-api
   ACEITA o token do kid VIGENTE do setes-api (`JWT_PUBLIC_KEYS` da nfse-api contém o `JWT_KID` do setes-api — um GET autenticado qualquer da
   nfse-api com o token de uma sessão de teste dá 200, nunca 401 "chave desconhecida") antes de reabrir o uso.
3. **ENSAIO do ato ANTES do merge**: `npm run migrate:setes -- --cutover 1 --confirmo-setes-api-parado` (dry-run — o bloqueio D-F50 é
   esperado aqui; o resto do ato roda e desfaz sobre o dado de hoje). **Critério de sucesso (R12-SOC-07)**: exit **0** e o relatório com
   `cutover` (+ `bloqueios` só com o D-F50 esperado). Exit **1** com `interrompidoPor` = o ensaio NÃO passou (transmissão viva, ERP sem SE,
   já virada, série, pós-condição — §22.36) — resolver ANTES do passo 4, nunca seguir pelo `bloqueios` sozinho. Prova de aceite: lado velho
   (árvore viva) → `npm run migrate:setes` → lado novo (worktree) = 0 divergência fora do "reconfirm" esperado. **D-F192**: no MESMO passo,
   o ENSAIO do aborto (`npx tsx --require tsconfig-paths/register scripts/f2a-abort-before-cutover.ts setes_setes 1`, sem `--vai`, a partir
   da worktree `f2a`) tem de responder SEM recusa — a guarda da D-F190 conta QUALQUER `cutover_at` do `fiscal_api`, e habilitação criada
   pela nfse-api já nasce virada (D-F39): pré-condição da janela = NENHUMA habilitação SE criada pela nfse-api no `fiscal_api` de produção
   até a 1ª janela. **R13-SOC-06**: numa instalação com várias institutions com SE no ERP, o 1º `--vai` fecha o aborto de TODAS (o merge
   congela todos os schemas no boot) — todos os ensaios e abortos vêm ANTES do 1º `--vai`. **R14-SOC-02**: o ensaio do aborto ANTES do
   merge responde `{ dryRun: true, triggers: [], migrationRow: false, tombstone: false }` (uma `tombstone: true` de tentativa anterior
   passa "sem recusa" mas derruba o boot no passo 4 — tratar ANTES); o D-F50 "esperado" do ensaio do ATO é o da frase "sem F2a"; conferir que
   `FISCAL_DB_NAME` NÃO está exportado no shell (o `.env` da worktree não o define — o padrão é `fiscal_api`). **D-F195**: se o ensaio do
   aborto RECUSAR, a janela PARA aqui — identificar a linha com `cutover_at` (`SELECT tb_institution_id, model, created_at, tb_user_id,
   deleted FROM fiscal_api.tb_establishment_issuer WHERE cutover_at IS NOT NULL`), provar 0 tentativas dela, apagar FISICAMENTE só com o "vai"
   do Valdo na hora e ensaiar de novo; a pré-condição vale para QUALQUER modelo/institution, viva ou excluída.
4. Conferir o número da `NNN_f2a_fiscal_passivo` contra o `main` (a IB-2); **PARAR o processo do setes-api** → `git -C setes-api merge
   --ff-only f2a` (rebase antes se o `main` andou) → SUBIR → ler o log: "Voz do fisco (views): fiscal_api — família(s) service" +
   "Migration aplicada: 069 - f2a_fiscal_passivo" (SOC-11).
5. `npm run migrate:setes` (re-sincronia sobre a origem AGORA congelada) + conferir as contagens de tentativas/vozes origem × réplica;
   ensaio `--cutover 1 --confirmo-setes-api-parado` de novo — **sem bloqueio** (D-F50 e os 9 gatilhos, F2A3-ADV-04) → com o "vai":
   `… --vai` (D-F44). **Ponto sem volta.** Até aqui o uso continua PARADO (SOC-01).
6. Publicar o build da F2b com `no-cache` em `index.html`/`flutter_bootstrap.js`/`main.dart.js` (Q-F155); relogin. **R16-SOC-07**: o
   build (`apps/web/build-web.ps1`) é ENSAIADO antes do dia da janela — no passeio de 2026-10-13 o `flutter build web` QUEBROU na migração
   interna do flutter_tools que lê o `apps/web/.gitignore` como UTF-8 (estava em cp1252; corrigido no app `41f8867`); o `flutter run` não
   passa por ela, por isso nunca tinha aparecido.
6b. **D-F207** (com o "vai" na hora, uso ainda PARADO): cancelar pela tela as 7 notas "sem NFS-e" da trilha (ids 8004–8010, código
   municipal "0102" congelado — nunca transmitem) e desativar as regras de ISS 1, 3 e 4 ("0102", sem serviço). Conferir depois: o lote
   "Transmitir notas sem NFS-e" acha 0 notas e nenhuma regra ativa tem código fora de vazio/3 dígitos.
7. Trilha (`scripts/trilha-primeiro-cliente.ts` — P8b pela nfse-api) → reabrir.
8. Depois: apagar o A1 do cofre do setes-api (D-F116, "vai"); push dos repos; F3 (Onda 4). ⚠️ Checklist da F3 (D-F132 × D-F135 —
   F2AR4-SOC-08): o usuário PRÓPRIO do setes-api não terá o privilégio TRIGGER (senão ele mesmo apagaria a trava) e o `information_schema`
   vem VAZIO para ele — o boot recusaria; a conferência dos 9 gatilhos passa a um usuário de DIAGNÓSTICO (molde do `EXPLAIN_DB_USER`).

**Aborto entre os passos 4 e 5** (D-F134 — `scripts/f2a-abort-before-cutover.ts`, rodado a partir da WORKTREE `f2a`, onde o script e a
migration existem — F2AR4-SOC-03): (1) PARAR o processo do setes-api (o boot do código novo reaplicaria a trava a cada restart do
`tsx watch`); (2) ensaio `npx tsx --require tsconfig-paths/register scripts/f2a-abort-before-cutover.ts setes_setes 1` → relata as donas do
schema, os 9 gatilhos e a linha; (3) com o "vai": `… setes_setes 1 --vai --confirmo-setes-api-parado` (DDL — definitivo; a linha vira a
LÁPIDE da D-F153 — versão SENTINELA `F2A-ABORT`, D-F162: o número da migration fica livre — e a pós-condição é conferida); (4) reverter o código da árvore viva para a ponta anterior ao merge (registrada no passo 4);
(5) subir o setes-api (código antigo — a lápide não o afeta) e rodar o ENSAIO de novo — `triggers: []`, `migrationRow: false`,
`tombstone: true`; (6) `npm run migrate:setes` na nfse-api (re-sincronia); (7) o app fica no build anterior. Se o código da F2a subir por
engano sobre o schema abortado, o boot RECUSA (lápide). Voltar à F2a depois = `… setes_setes 1 --retirar-lapide --vai` e o merge de novo.
O script do aborto RECUSA se QUALQUER dona do schema já virou (SE aposentada ou `cutover_at`), se o id não é dono do schema ou não tem a
linha SE, e quando a linha da migration está no `_migrations` mas não se VEEM os 9 gatilhos (privilégio TRIGGER do usuário — ou gatilho
apagado à mão: reaplicar a trava antes e abortar de novo). Ele grava a LÁPIDE ANTES de derrubar os gatilhos (R5-SOC-05): se cair no meio,
rodar de novo termina o serviço. O aborto age POR SCHEMA e o boot do código da F2a confere a trava em TODO schema ativo — numa
instalação com mais de um schema, o passo (3) é para CADA schema ativo (hoje, 2026-10-13: só a institution 1 / `setes_setes`). Depois do
`--vai` do ato: rollback PROIBIDO (D-F50). **D-F190**: o aborto só existe ANTES da 1ª janela — o script RECUSA quando QUALQUER institution
da INSTALAÇÃO já virou (depois do merge, a lápide num schema faria o boot recusar para TODAS); o `--retirar-lapide` segue valendo.
**Trava faltando no boot** (D-F152): `npx tsx --require tsconfig-paths/register scripts/f2a-reapply-freeze.ts setes_setes [--vai]` — roda
SÓ o DROP+CREATE dos gatilhos que FALTAM ou DIFEREM (os certos ficam de pé — R5-ADV-04), com UMA conexão (o `USE` vale só nela; recusa
pool — R5-SOC-07), e confere pela conferência do boot. RECUSA com a LÁPIDE (a F2a foi abortada ali — voltar é o `--retirar-lapide`) e sem a migration registrada (o boot a aplica
inteira). Sem `--vai` é ensaio.

#### 22.13.1 Provas (2026-10-13)

- **setes-api (worktree `f2a`)**: `tsc` limpo; suíte **1.748 ok + as MESMAS 20 falhas pré-existentes** (nome a nome: 19 da bomba-relógio do
  boleto em `bank-slip-registration`/`onda2-adversarial`/`onda2-gate-rework` + 1 da cerca de fuso); gate adversarial da A3 **42/42 com
  `F2A_ADV_LIVE=1`** (restam como `it.failing` só a ADV-01 e a ADV-03, que dependem da Rodada 4); `scripts/prove-f2a-passivo.ts` em banco
  descartável **26/26** (o caso novo do dono da linha SE incluído).
- **nfse-api**: `tsc` limpo; **697/697** com `SETES_API_DIR` na worktree E na árvore viva; ao vivo **150/150** (`NFSE_ADV_LIVE=1 npx jest
  live --runInBand`, cópias `fiscal_api_adv_*`); testes novos: `f2a-a3-gatilhos.test.ts` (conferência dos 9 gatilhos + cerca da lista ×
  069), `f1r10` (ato real recusa / ensaio relata o bloqueio D-F110 com gatilho faltando ou nenhum visível), `f2a-a1-nfse` (sonda do código).
- **núcleo**: **466/466** nas duas árvores (a cerca r21 passou a conhecer a 006).
- Nenhum banco `f2a_*`/`fiscal_api_adv_*` sobrou; a nfse-api do dev NÃO está no ar — a 006 não foi aplicada no `fiscal_api` do dev (entra no
  próximo `db:migrate`/boot, no passo 2 da janela).

#### 22.13.2 Rodada 4 da F2a — questões abertas pelos gates da A3 (Q-F138…Q-F144) — DECIDIDAS (Valdo 2026-10-13: "siga as recomendações" → D-F130…D-F136, §7; execução no §22.16)

- **Q-F138 — o `fiscal_api` ilegível em EXECUÇÃO (SOC-02 + ADV-03)**: (a) manter o 500 · (b) **a lista de OS DEGRADA (as linhas voltam; o
  selo vira `unavailable` + alarme com a referência do crash) e as rotas que DECIDEM (`cancel`, `cancel-waiver`, `cancel-plan`,
  `fiscal-effect`) respondem 503 `FISCAL_VOICE_UNAVAILABLE` (falha fechada TIPADA, nunca 500 genérico)** · (c) 503 para a lista inteira.
  *(Rec.: (b) — o selo é informativo e não decide; quem decide falha fechado com código próprio. O boot continua não subindo sem as views
  — D-F113.)*
- **Q-F139 — o `GET …/cancel-plan` travante (SOC-03)**: (a) **exigir o privilégio CANCELAR do ramo (a MESMA guarda do POST) + espera curta
  de trava só na sessão da consulta (molde da D-F41 — `innodb_lock_wait_timeout` curto; estourou = 409 `RESOURCE_BUSY` em segundos)** ·
  (b) só a espera curta · (c) manter a D-F128 como está. *(Rec.: (a) — quem não pode cancelar não precisa do plano, e quem só olha não
  segura a nota que a nfse-api trava como 1º comando; a tela não faz polling do plano.)*
- **Q-F140 — menor privilégio do setes-api no banco (SOC-04)**: (a) criar o usuário `setes_api` NA janela · (b) **adiar para a F3:
  conhecimento negativo no §22.11 + sonda no boot da F3 ("INSERT no `fiscal_api` negado ao usuário do setes-api")** · (c) manter.
  *(Rec.: (b) — trocar o usuário de produção sob a pressão da janela traz mais risco que ganho; a cerca por AST cobre o código até lá.)*
- **Q-F141 — pino do núcleo (SOC-05, R13)**: (a) tarball/tag versionado como dependência do setes-api e da nfse-api JÁ · (b) **checklist
  na janela (HEAD e `dist` do núcleo conferidos e registrados) + proibido recompilar o núcleo na máquina de produção até a F3; (a) na F3**
  · (c) deixar o R13 para a F3. *(Rec.: (b) agora e (a) na F3.)*
- **Q-F142 — aborto antes do `--vai` (SOC-06)**: (a) **roteiro/script de aborto válido SÓ até o passo 5 (DROP dos 9 gatilhos, remover a
  linha `f2a_fiscal_passivo` do `_migrations`, reverter o código, re-sincronizar), escrito e ensaiado em banco descartável antes da janela**
  · (b) só conserto para frente. *(Rec.: (a) — depois do `--vai` o rollback continua proibido pela D-F50.)*
- **Q-F143 — os 9 gatilhos conferidos também no BOOT do setes-api (ADV-04, extensão)**: (a) **sim — depois do runner, no molde das sondas
  de CHECK (D-F45/D-IB26): gatilho faltando ou diferente = o setes-api não sobe** · (b) só o ato (feito nesta sessão) · (c) só conhecimento
  negativo. *(Rec.: (a) — o congelamento protege a VIDA INTEIRA depois da virada, não só o instante do ato.)*
- **Q-F144 — invariante "voz A/N ⇒ registro" (ADV-01)**: (a) **no mapa da família no núcleo (`mapTransmissionView`): voz A/N sem
  `authority_recorded` falha ALTO, como a D-NE61 faz com a D** — o plano cai em erro (fechado), nunca libera o cancelamento local ·
  (b) predicado novo do núcleo para a barreira (autorizada barra salvo registro de homologação) · (c) só conhecimento negativo.
  *(Rec.: (a) — o mesmo molde já decidido para a NF-e; 0 linhas hoje.)*


### 22.14 F2b — setes-app CLIENTE da nfse-api: Rodada 0 (2026-10-13) — inventário + parecer do guardião + Rodada 1 (Q-F145…Q-F155)

> Valdo (2026-10-13, prompt do §22.12): "PASSO 2 — F2b (setes-app) Rodada 0". Fontes: agente Explore (só leitura) e agente `setes-conceito`
> (só leitura); os fatos que decidem foram conferidos no disco (`api_client.dart`, `app_config.dart`, `nfse-api/.env` CORS, rotas da
> nfse-api, `getOrderFiscalEffect`). Nada foi editado no setes-app. A F2b se desenvolve em WORKTREE do app (a criar com a Rodada 1 decidida).

#### 22.14.1 Fatos do inventário (`APP` = `setes-app/apps/web/lib/app`, `CORE` = `setes-app/packages/core/lib/src`, `NF` = `nfse-api`)

- **Só DOIS datasources chamam as 14 rotas**: `APP/modules/service_orders/data/datasource/service_order_fiscal_datasource.dart` (visão,
  transmit, refresh, xml, danfse, cancel no fisco, cancel-waiver — este FICA no setes-api —, pendentes, lote) e
  `APP/modules/establishment/data/datasource/establishment_issuer_datasource.dart` (emissor + A1). O app NÃO chama `cancel-plan` nem
  `fiscal-effect`. `POST /api/billing/cancel` está em `service_order_datasource.dart:147` e `orders/.../order_datasource.dart:246`.
- **Rede**: `ApiClient` com base ÚNICA (`AppConfig.baseApiUrl` = `String.fromEnvironment('API_URL')`, compilação; dev `run-dev.ps1`
  `--dart-define-from-file=.env`, porta 5051); `Bind.singleton<ApiClient>` e todo módulo `i.get<ApiClient>()`; **token = campo da
  INSTÂNCIA** (`api_client.dart:17`), gravado em 4 lugares (`auth_bloc.dart:170`, `login_page.dart:38`, `setes_auth_guard.dart:22`) e limpo
  no logout (`user_badge.dart:41`); **401 → `UnauthorizedFailure` que NINGUÉM captura** (vira diálogo; só o guard confere `exp` ao trocar
  de rota); sem timeout nem retry.
- **nfse-api** (`NF/openapi/nfse-api.v1.yaml`, `src/modules/nfse/nfse.routes.ts`, `emitter/emitter.routes.ts`): o MESMO token serve (RS256
  com kid; a pública é a do setes-api); **CORS = `http://localhost:5000,http://localhost:8080` no `.env` do dev — o app roda em 5051** (cai
  em "Failed to fetch"); emitente só admin (403 `ADMIN_REQUIRED`); antes da virada toda ação/escrita do emitente = 409
  `FISCAL_CUTOVER_PENDING`. Pares: transmit → `POST /v1/nfse/invoices/{id}/transmit` (201 só com A; ambíguo 502/503) · lote → **SEM PAR**
  · pendentes → `GET /v1/nfse/invoices/pending` (PAGINADO 25/100, com `interfaceKey` — mistura `orders` e `service-orders`) · cancelar no
  fisco → `POST …/cancel {reason}` + depois `POST /api/billing/cancel` (`nextStep: apply-local-cancel`) · consulta → `POST …/refresh` ·
  visão → `GET …/{id}` + `GET /api/billing/:id/fiscal-effect` · XML/DANFSe → `GET …/xml|danfse` · emissor → `/v1/emitter*` (**só SE**: 55/65
  = 422 `FISCAL_MODEL_NOT_SUPPORTED`) · NOVO `POST …/reconfirm`.
- **O que a tela perde/ganha**: `pendingEffects` (int), `substitution.waived`, `cancelWaiver` e `events[].invoiceEvent` NÃO vêm da
  nfse-api → efeito/dispensa vêm do `fiscal-effect` (`effect` none/apply/decide/cancel + `cancelWaiver`); kind **N** (autorizada depois de
  K) sem rótulo e `isAuthorized` só aceita 'A'; cancel no fisco sem `kind` (`atAuthority`, `transmissionEvent`, `warnings`, `nextStep`); o
  `CancelResult` assume 'C' por padrão; com registro fiscal a OS vira 'C' mas o bloc força a aba Abertas e a mensagem diz "voltou a
  aberta"; emitente com `cutoverAt` e `enabled` = virada feita E A1 vigente (antes da virada o selo "sem certificado" mente); série 1–49999
  (o app aceita 0 e 50000+); o app não tem catálogo `code`→i18n (os códigos novos chegam como mensagem PT da API).
- **setes-api (A3)**: `cancel-plan` `{orderId, invoiceNumber, cancellable, blocks[], fiscalRecord, effects{…, touchesCash, cashierOpen}}`;
  `fiscal-effect` `{orderId, lifeEvent, invoiceCancelled, effect, cancelWaiver}`; `POST cancel` e `cancel-waiver` compatíveis com o app.
- **Testes**: 74 em 8 arquivos leem a forma antiga; NÃO existe teste de widget da seção "No fisco". **Build web**: `index.html` padrão, sem
  service worker próprio; produção = build no Plesk (sem config de deploy no repo). **i18n**: 59 `forms.serviceOrder.fiscal*`, 34
  `forms.establishment.issuer*`; mortas/enganosas: `fiscalEffectRow`, `fiscalSent`, `fiscalCancelInFlight`, `fiscalPendingRow`,
  `fiscalCancelled`, `issuerModel55`.
- **Riscos R-B1…R-B16**: token por instância · CORS · `NFSE_API_URL` · cancelamento em 3 passos retomável · `/reconfirm` sem UI · visão de
  duas fontes com uma falha só · kind N · lote no cliente paginado e misturado · transmit 201 só A · emissor só SE e pré-virada · destino da
  OS · 401 · datasource que mistura APIs · 74 testes da forma antiga · deploy/cache · i18n.

#### 22.14.2 Parecer do guardião (`setes-conceito`, 2026-10-13)

**Conceito**: o app é o **portador do ato humano** sobre a nota até as duas autoridades que o julgam — o fisco (pela nfse-api) e o ERP
(pelo setes-api). **Fato gerador**: a VIRADA + a remoção das 14 rotas (o leitor segue o escritor, agora no cliente). É COMPOSIÇÃO de
apresentação — nenhuma peça de domínio nova. Orquestra só a ORDEM (D-F28: o fisco fala primeiro); quem decide é a API que recebe cada ato;
a retomada é por DERIVAÇÃO (reler `fiscal-effect` = `apply`), nunca diário no cliente.

**O app NUNCA vira**: juiz do cancelamento local por coluna crua (`blocksLocalCancel` por `environment != 'H'` — entity:337 — é exatamente o
que a cerca da A3 proíbe no setes-api); juiz da dispensa (`canWaiveCancel` — o `effect=decide` responde); reimplementação do `currentOf`
(`transmissions.last` ≠ D-N26); tabela de semântica de kinds (`finals`, `isAuthorized` só 'A'); cache/diário de estado fiscal; botão
escondido por regra própria; erro de rede num POST fiscal tratado como "não aconteceu" (é "desfecho desconhecido — releia").

**Peças**: `ProductToken` em `packages/core/.../auth/` (o JWT do login, um para N APIs, lido a CADA requisição; as 4 escritas passam por
ele) · `ApiClient` × N instâncias (tipo fino `NfseApiClient` para a injeção, base `AppConfig.nfseApiUrl`) · expiração global (401 numa
requisição que LEVOU token = sessão morta → limpa e vai ao login; 401 sem token segue para a tela) · `service_order_nfse_datasource.dart`
(só nfse-api) + `service_order_invoice_datasource.dart` (só `/api/billing`: plano, efeito, cancel, waiver — exceção nomeada) — o
`service_order_fiscal_datasource.dart` MORRE (mistura duas APIs sob "fiscal") · saga do cancelamento = usecase de composição no módulo
sobre DOIS repositórios · `establishment_nfse_issuer_datasource.dart` (`/v1/emitter*`) · painel "No fisco" com DUAS fontes e DUAS falhas
(falhar o `fiscal-effect` = "efeito indisponível", nunca "nada pendente" — D-F79). **`app/shared/fiscal/` NÃO agora** (regra de promoção:
nasce em `service_orders`; sobe no 2º consumidor — NFS-e da venda conjugada em `orders` ou a NF-e); o cliente HTTP nasce no core (infra
com 2 consumidores desde o 1º dia).

**Achado (lacuna da A3)**: o bloco `fiscal` do plano só traz TEXTO (`invoice-cancel.ts:366-372`) — a tela precisa saber QUAL ação oferecer
(Cancelar NFS-e / Consultar / aguarde / Reconferir); o tipo já existe (`FiscalCancelBarrier`) — falta serializar (Q-F149).

**Sagas**: (a) cancelar com NFS-e autorizada = `GET cancel-plan` → `POST /v1/…/cancel` → `POST /api/billing/cancel` (falha no 3º = reler
`fiscal-effect` → `apply`; repetir o 3º = 409 `INVOICE_NOT_CANCELLABLE` "já cancelada" = já feito, reler; 502/503 no 2º = o K fica,
reler; o destino da tela vem do STATUS relido do pedido, nunca do "Abertas" fixo) · (b) reconferir = barreira `reconfirm` → `/reconfirm` →
reler o PLANO (o `verdict` só escolhe a frase; `nao-exigida` ≠ "pode cancelar") · (c) manter a nota = `effect=decide` → motivo →
`cancel-waiver` · (d) `effect=cancel` = texto + "Cancelar nota" (abre o plano) · (e) transmitir = 201 autorizada / 422 E0xxx / 409 / 502-503
ou timeout = "resultado incerto, consulte" (sem retry automático, nunca) · (f) lote (Q-F153). Botões pelo `state` do servidor + `effect` +
barreira tipada + `CurrentInterface.can` — o servidor dá a última palavra.

**Vocabulário**: `effect` na UI — `apply` "O fisco cancelou a NFS-e; falta cancelar a nota no sistema" (ação "Aplicar o cancelamento na
nota"), `decide` "NFS-e substituída no fisco; decida" (Manter · Cancelar nota), `cancel` "O fisco cancelou (de ofício / homologação);
cancele a nota", desconhecido = neutro sem ação; enum Dart com fallback `unknown` (o `state` também — núcleo 9 × contrato 7). Kind N só
rótulo ("cancelamento não aconteceu; a NFS-e segue autorizada"). "Transmitir pendentes" → **"Transmitir notas sem NFS-e"**; nunca
"pendente" sozinho. i18n novas: `kindN`, `effect.*`, reconferir + motivos do veredito, `applyLocalCancel`, `outcomeUnknown`,
`issuerAwaitingCutover`. Selo do emissor pelos FATOS (`cutoverAt` nulo → "aguardando a migração da emissão"; A1 ausente/vencido → "sem
certificado"). Evitar "fiscal" sozinho, "sessão" (AuthSession/SessionContext/caixa), "réplica"/"virada" na tela de usuário comum.

**Maquete se**: entidade única "visão fiscal" fundindo as duas APIs num `fromJson` (duas fontes, uma falha, degrada calado); `app/shared/
fiscal` genérico antes da NF-e; diário da saga no LocalPrefs; filtro por `interfaceKey` no CLIENTE sobre página paginada (a página 1 esconde
notas); botão sumindo por regra própria; catálogo COMPLETO de códigos no app (2ª cópia das mensagens); portar os 27 testes da entidade que
fixam derivações que morrem; lápide/compatibilidade nas 14 rotas. **Não entra**: tela Super de licenciado/app (D-F14/D-F13); 55/65 no
emissor; webhook/recibo (D-F11); rodízio pelo app; "No fisco" na venda (`orders` — ⚠️ lacuna que já existe hoje: venda conjugada com NFS-e
autorizada não tem como cancelar a NFS-e pela tela de pedidos); A1 por duas APIs (decidir com a nfe-api).

#### 22.14.3 Rodada 1 da F2b — questões (Q-F145…Q-F155) — DECIDIDAS (Valdo 2026-10-13: "siga as recomendações" → D-F137…D-F147, §7; execução no §22.16)

- **Q-F145 — o modelo 55 na aba "Emissor fiscal"**: (a) **sai da aba: só SE + A1 pela nfse-api; a série do 55 fica só-leitura no ERP, sem
  tela (D-F112)** · (b) card 55 só-leitura por uma rota nova do ERP · (c) card "em breve". *(Rec.: (a).)*
- **Q-F146 — cliente HTTP multi-API e sessão**: (a) **uma classe `ApiClient`, N instâncias por base de URL (tipos distintos para a
  injeção), token num `ProductToken` ÚNICO lido a cada requisição, 401 global só quando a requisição levou token** · (b) um `ApiClient` só,
  roteando por prefixo de URL · (c) token copiado em cada cliente. *(Rec.: (a) — a (c) é perigosa: trocar de institution deixaria o 2º
  cliente agindo com o token velho, no estabelecimento errado.)*
- **Q-F147 — onde fica o orquestrador da saga do cancelamento**: (a) **usecase de composição no módulo sobre dois repositórios, retomada por
  derivação** · (b) o bloc chama as duas APIs direto · (c) `app/shared/fiscal` por família desde já. *(Rec.: (a).)*
- **Q-F148 — `effect=apply` sem humano no fisco** (voz C que chegou por consulta/portal): (a) **botão "Aplicar o cancelamento na nota" que
  abre o PLANO; o humano confirma, digita o motivo e precisa de caixa aberto se `touchesCash` (agora `cashierOpen` no plano)** · (b) o app
  aplica sozinho ao abrir o detalhe · (c) só mensagem. *(Rec.: (a) — o C local cancela boleto, estorna cheque e mexe no caixa: nunca sem
  confirmação humana.)*
- **Q-F149 — barreira fiscal TIPADA no plano** (achado do guardião — lacuna da A3): (a) **o bloco `fiscal` do `cancel-plan` ganha
  `barrier {kind: authorized|in-flight|cancel-in-flight|reconfirm, reason?, attempt}`, serializando o `FiscalCancelBarrier` que já existe —
  mudança na worktree `f2a`, antes da janela** · (b) o app interpreta a mensagem · (c) o app deduz a barreira das tentativas da nfse-api.
  *(Rec.: (a) — (b)/(c) recriam o plano em Dart.)*
- **Q-F150 — como a tela escolhe os botões do fisco**: (a) **pelo `state` da nfse-api + `currentAttempt` (campo NOVO e aditivo na visão —
  a vigente pelo `currentOf` do núcleo) + `effect` + barreira; kind só como rótulo** · (b) a nfse-api devolve `actions` (booleanos) · (c)
  pelos kinds, como hoje. *(Rec.: (a) — a (b) aumenta o contrato e ainda depende do privilégio local.)*
- **Q-F151 — `FISCAL_CUTOVER_PENDING` no app**: (a) **sem estado próprio: a mensagem da API passa direto e o build sai DEPOIS do ato
  (passo 5 → 6 da janela); o selo do emissor usa `cutoverAt`** · (b) "modo consulta" na seção ao receber o código · (c) a nfse-api expõe
  `cutoverPending` na visão. *(Rec.: (a) — institution NOVA não nasce presa à virada: `requireCutover` olha a linha SE do ERP.)*
- **Q-F152 — códigos de erro → i18n**: (a) **a mensagem da API passa direto (Framework de Mensagens); constantes só para os códigos que
  MUDAM o comportamento da tela** (`INVOICE_CANCEL_BLOCKED`, `INVOICE_CANCEL_WAIVER_NOT_APPLICABLE`, `INVOICE_NOT_CANCELLABLE`,
  `FISCAL_DPS_REJECTED`, `FISCAL_AUTHORITY_UNKNOWN_RESPONSE`/`UNAVAILABLE`, `RESOURCE_BUSY`, `FISCAL_CUTOVER_PENDING`) · (b) catálogo
  completo no core · (c) a nfse-api traduz por `Accept-Language`. *(Rec.: (a).)*
- **Q-F153 — o lote de transmissão** (fato: o lote de hoje transmite também notas de `orders` — a rota antiga aceita os dois ramos):
  (a) **escopo = notas da OS, filtro `interfaceKey` NO SERVIDOR (parâmetro novo da nfse-api); a lista é fotografada na confirmação (todas
  as páginas, até um teto); 1 por vez, na ordem da API; segue em erro DA nota (422/409/502 → "consulte"); PARA em erro sistêmico (401, 403,
  `FISCAL_CERT_*`, `FISCAL_ISSUER_MISSING`, `FISCAL_CUTOVER_PENDING`, N× 503 seguidos)** · (b) a (a) sem filtro (todas as que o usuário
  pode transmitir, como hoje) · (c) transmissão paralela. *(Rec.: (a), conferindo no dado da janela quantas notas sem NFS-e não são de OS —
  a Setes fatura pela OS.)*
- **Q-F154 — CORS e `NFSE_API_URL`**: (a) **`--dart-define NFSE_API_URL` no `AppConfig` (molde do `API_URL`), build sem o define FALHA
  ALTO; `CORS_ORIGINS` explícita por ambiente (dev `:5051`; produção a origem do Plesk); o boot de produção da nfse-api recusa lista vazia
  ou `*`** · (b) `config.json` em tempo de execução · (c) proxy de mesma origem no Plesk. *(Rec.: (a), coerente com a D-F4.)*
- **Q-F155 — cache do Flutter web na janela**: (a) **cabeçalho `no-cache` em `index.html`, `flutter_bootstrap.js` e `main.dart.js` no
  Plesk + aviso de recarregar; a integridade já está no servidor (o build velho só recebe 404 e o "Cancelar nota" dele passa pelo plano)**
  · (b) a (a) + checagem de versão mínima · (c) lápide 410 nas 14 rotas. *(Rec.: (a).)*

**Esforço da F2b** (§22.3: 4–6 sessões) — mantido: core (token/cliente/401) ≈ 1 · datasources + entidades + sagas de `service_orders` ≈
2 · emissor ≈ 0,5 · lote ≈ 0,5 · testes de widget da seção + gates ≈ 1–1,5.


#### 22.15 ⏯ PROMPT DE RETOMADA — Rodada 4 da F2a + Rodada 1 da F2b → execução → janela (colar numa sessão nova)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.13 (gates da A3 + roteiro da JANELA REVISTO + Q-F138…Q-F144) e o §22.14
(F2b Rodada 0 + Q-F145…Q-F155); §22.11 (A3) e §22.2/§22.3 só quando precisar. A2 PUBLICADA (setes-api main f5eee3b — RS256 em produção).
A3 + correções dos gates na worktree D:\Gestao2027\setes-api-f2a (branch f2a — commit local; push só com o "vai"); núcleo e nfse-api
com as correções dos gates em commit local no main deles (006 da nfse-api NÃO aplicada em banco nenhum fora dos descartáveis).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A A3 SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev na worktree (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai fora da
  janela. Testes ao vivo só em bancos descartáveis (f2a_*, fiscal_api_adv_*), apagados no fim.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas FALHAM — script em arquivo); commit só dos caminhos
  da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.

PASSO 1 — com as respostas do Valdo às Q-F138…Q-F155: registrar D-F130+ no §7 e executar o que cabe ANTES da janela:
  setes-api (worktree f2a): Q-F138 (degradação da voz em execução), Q-F139 (guarda/espera do cancel-plan), Q-F143 (boot confere os 9
  gatilhos), Q-F149 (barreira tipada no plano); núcleo: Q-F144 (A/N ⇒ registro no mapa); nfse-api: Q-F150 (currentAttempt na visão),
  Q-F153 (filtro interfaceKey nas pendentes), Q-F154 (CORS explícito, boot recusa vazio/*); Q-F142 (roteiro/script de aborto ensaiado em
  banco descartável); Q-F141 (checklist do núcleo na janela). Gates do DELTA (socrático ≥ 0,70 + adversarial sem HIGH).
PASSO 2 — F2b em WORKTREE do app (D:\Gestao2027\setes-app-f2b, branch f2b): ProductToken + ApiClient por API + 401 global (core),
  datasources dedicados (nfse × invoice) de service_orders, saga do cancelamento (usecase de composição, retomada por derivação),
  "No fisco" com duas fontes/duas falhas, emissor SE pela nfse-api, lote no cliente, i18n (mortas saem; novas entram), testes de widget
  da seção; agente setes-form-builder só com conferência no disco; passeio logado (Claude in Chrome, o Valdo logado) contra a nfse-api
  e a worktree em portas de teste (nunca a produção); gates.
PASSO 3 — a JANELA pelo roteiro REVISTO do §22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15).
Ao fim de cada passo: docs (§22.16+), INDICE_CENTRAL, CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```


### 22.16 Rodada 4 da F2a + Rodada 1 da F2b — DECIDIDAS e EXECUTADAS (2026-10-13) — gates do DELTA 0,74 / 0,72 (sem HIGH/CRITICAL)

> Valdo (2026-10-13): "siga as recomendações" → Q-F138…Q-F155 viraram D-F130…D-F147 (§7). Tudo em commit LOCAL (push só com o "vai");
> a árvore viva do setes-api NÃO foi tocada; testes ao vivo só em bancos descartáveis (`f2a_*`, `fiscal_api_adv_*`), apagados no fim.

#### 22.16.1 O que foi executado (backend antes da janela)

| Repo | Commit | O quê |
|---|---|---|
| setes-api (worktree `f2a`) | `7abea48` | D-F130 porta da voz TIPADA (`FiscalVoiceUnavailableError` 503 `FISCAL_VOICE_UNAVAILABLE` + `ref` do alarme; contenção 1205/1213 sobe crua); lista de OS DEGRADA (selo `unavailable`); D-F131 `GET …/cancel-plan` com a guarda CANCELAR do ramo + espera curta de 3 s na sessão (devolvida ou a conexão é descartada); D-F135 o boot confere os 9 gatilhos (`assertF2aFreezeTriggers`, depois do runner); D-F134 script de aborto + prova; D-F141 barreira TIPADA `barrier {kind, reason?, attempt}` |
| núcleo | `24ab152` | D-F136 voz A/N ⇒ registro no mapa comum (molde da D-NE61) |
| nfse-api | `6a33982` | D-F142 `currentAttempt` na visão; D-F145 `interfaceKey` nas pendentes (filtro NO SERVIDOR); D-F146 CORS explícito (boot recusa vazia/`*`) |
| setes-app (worktree `f2b`) | `289de28` | a F2b inteira — §22.16.3 |
| setes-api `f2a` · núcleo · nfse-api | `1a5af8e` · `4cb74d9` · `5107863` | as CORREÇÕES dos gates do delta — §22.16.2 |

D-F132 (usuário próprio na F3) e D-F133 (checklist do núcleo na janela) são de roteiro: §22.13 (passo 8 e o checklist do passo 4). D-F137…
D-F147 do app: §22.16.3.

#### 22.16.2 Gates do DELTA (Rodada 4 da F2a + backend da F2b) — socrático **0,74 ✅** · adversarial **0,72 ✅**

Agentes independentes. O socrático teve nota baixa em contrato de erro (0,55 — o Swagger do `POST /cancel` sumiu), escala e multi-tenant
(0,65), e retomada (0,65 — o re-congelamento silencioso depois do aborto). O adversarial rodou 40/40 com a parte viva (`F2A_ADV_LIVE=1`) +
8/8 na nfse-api. Resistiram:
- D-F130: toda forma de voz ilegível → 503 sem a causa no corpo; contenção crua; erro do ERP → 500, nunca "voz ilegível".
- D-F131: 403 sem abrir conexão; ao vivo, 409 em 3,4 s e a conexão devolvida com o valor que tinha.
- D-F141: barreira sem dado indevido.
- D-F135: AFTER, tabela, evento, maiúsculas e "sem privilégio" acusados.
- D-F134: 11 formas de argumento ruim dão "uso:".
- D-F136 em todo leitor.
- D-F145: `interfaceKey` hostil → 400.

Achados confirmados viraram teste (`setes-api/src/__tests__/adversarial-f2a-r4-gate.test.ts`, `nfse-api/src/__tests__/adversarial-f2a-r4-gate.test.ts`):

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| F2AR4-SOC-01 · ADV-08 | MEDIUM | `barrier {kind, reason?, attempt}` sem aspas num mapa YAML → o swagger-jsdoc DESCARTA o bloco: o `POST /api/billing/cancel` sumiu do OpenAPI | **corrigido** + cerca NOVA `swagger-parse.test.ts` (`failOnErrors` sobre os MESMOS arquivos/opções do /api-docs — `swaggerOptions` exportado) |
| F2AR4-SOC-02 · ADV-01 | MEDIUM | o aborto conferia a virada só da institution DIGITADA e derrubava os gatilhos do SCHEMA inteiro (typo ou filial = rollback depois da virada — provado ao vivo) | **corrigido**: escopo do SCHEMA — o id tem de ser dono (`setes_central.tb_institution.schema_name`) e ter a linha SE; QUALQUER dona virada = recusa |
| F2AR4-SOC-03 | MEDIUM | a ordem do aborto só documentada e contraditória (script só na `f2a`); nada exigia o processo parado — o `tsx watch` reaplicaria a 069 e a trava voltaria calada | **corrigido**: `--vai` exige `--confirmo-setes-api-parado`; pós-condição conferida depois do `--vai`; roteiro do §22.13 reescrito (worktree `f2a`; ensaio de novo depois do boot do código antigo). A lápide = **Q-F158** |
| F2AR4-ADV-02 | MEDIUM | a conferência dos gatilhos (boot e ATO) aceitava o CORPO trocado — SIGNAL sob IF que nunca vale, em comentário, a trava da SE de versão anterior (provado ao vivo) | **corrigido nos dois lados**: o corpo NORMALIZADO (`normalizeTriggerBody` — comentários fora, espaços colapsados, literais intactos) comparado com o da migration; na nfse-api a lista do ato leva o corpo e a cerca o confere contra a 069 do `SETES_API_DIR`; prova viva: os 7 corpos reais, como o MariaDB os GUARDA, normalizam igual ao da migration |
| F2AR4-SOC-04 | LOW (MEDIUM na meta D-F3) | `TRIGGER_SCHEMA = ?` varre TODOS os bancos (EXPLAIN: "Scanned all databases") | **corrigido**: `EVENT_OBJECT_SCHEMA = ?` (boot, ato, aborto, provas) |
| F2AR4-ADV-03 | LOW | o plano só encurtava o `innodb_lock_wait_timeout` — trava de METADADOS (LOCK TABLES/ALTER/dump) esperava o `lock_wait_timeout` do servidor (86400 s) | **corrigido**: os dois encurtados e devolvidos juntos; prova viva (409 em segundos) |
| F2AR4-ADV-04 | LOW | POST cancel/cancel-waiver: rollback sem catch na conexão MORTA substituía o 503 por 500 (e 2º alarme) | **corrigido**: rollback que rejeita não substitui o erro e a conexão quebrada é DESCARTADA |
| F2AR4-ADV-05 | LOW | linha "registrada sem chave" → `fiscalRecordKey` lançava FORA da porta → 500 | **corrigido no núcleo**: o mapa da FAMÍLIA de serviço recusa registro sem chave (dentro da porta → 503). O inverso (chave sem registro) segue a D-NE68 (b) — tentar o invariante no mapa COMUM quebrou fixtures da NF-e (lá a chave de 44 é nossa) |
| F2AR4-SOC-06 | LOW | a D-F136 valia só no mapa do núcleo — o `mapTx` da nfse-api dava `state: authorized` para a mesma linha torta | **corrigido**: `mapTx` recusa A/N sem registro (dois leitores, uma resposta) |
| F2AR4-ADV-06 | LOW | linha no `_migrations` sem gatilho visível (sem privilégio TRIGGER) → o `--vai` tirava a linha e "concluía" | **corrigido**: recusa nomeando o privilégio TRIGGER |
| F2AR4-ADV-07 | LOW | `--vai --vai` passava do parser | **corrigido**: flag repetida/desconhecida = "uso:" sem conectar |
| F2AR4-SOC-07 · ADV-09 | LOW | regra de CORS só no boot da nfse-api; aceitava maiúsculas, `:80`/`:443`, `:99999`, `*.dominio`, `http://` fora de localhost — e o `corsFor` compara por igualdade | **corrigido no NÚCLEO** (a nfe-api herda): `corsOriginProblem`/`assertCorsOrigins` — só a origem CANÔNICA (`new URL(o).origin === o`, host DNS), `http://` só em `localhost`/`127.0.0.1`, sem curinga; `corsFor` recusa na montagem; `nfse-api/src/cors-origins.ts` reexporta |
| F2AR4-SOC-05 | LOW | o `guarded` põe argumento inválido/contrato num 503 "tente de novo" (bug fixo parece passageiro; uma linha incoerente põe `unavailable` na página inteira; alarme com `userId: 0`) | **Q-F156** |
| F2AR4-SOC-08 | LOW | §22.16 inexistente; roteiro do aborto desatualizado; TRIGGER × D-F132 só no código | **corrigido**: este §, roteiro do §22.13 e o checklist da F3 no passo 8 |

#### 22.16.3 F2b no app — worktree `D:\Gestao2027\setes-app-f2b` (branch `f2b`, `289de28`)

- **core**:
  - `ProductToken`: um token do produto para N clientes, com ouvinte de expiração.
  - `ApiClient` × N instâncias por base: `NfseApiClient` com `NFSE_API_URL` por `--dart-define`.
  - 401 GLOBAL só quando o token ENVIADO é o vigente (resposta velha depois do relogin não derruba a sessão nova — D-F138).
  - `AppConfig.missingConfiguration`: o build sem `NFSE_API_URL` abre a tela de configuração, nunca chama o lugar errado (D-F146).
- **service_orders** — duas fontes, duas falhas (D-F139):
  - `service_order_nfse_datasource` (só a nfse-api `/v1/nfse/invoices/...`) × `service_order_invoice_datasource` (só `/api/billing/*`: plano, efeito, cancelar, manter).
  - O `service_order_fiscal_datasource` MORREU (misturava duas APIs).
  - A entidade não deriva fato fiscal (D-F142): `state`, `currentAttempt` e `effect` vêm do servidor; kind só rótulo; N com rótulo próprio.
- **Saga** (`service_order_cancel_invoice.dart` — usecase de composição):
  - o fisco primeiro (D-F28); recusa ou desfecho desconhecido nunca chega ao ERP;
  - o fisco cancelou e a nota não → `authorityCancelled` → aviso e releitura (efeito `apply` → "Aplicar o cancelamento na nota" = a mesma saga sem o fisco — D-F140);
  - todo cancelamento abre o PLANO e decide pela barreira TIPADA (D-F141):
    - bloqueio local ou caixa fechado → lista;
    - sem barreira → motivo;
    - só a autorizada → confirmar → motivo → fisco + nota;
    - reconferir → reconferência;
    - em voo → aviso.
- **Lote "Transmitir notas sem NFS-e"** — NO APP (D-F145):
  - lista FOTOGRAFADA: todas as páginas, `interfaceKey=service-orders`, teto 500, sem repetir; página que falha = falha inteira;
  - uma nota por vez; erro DA nota vira linha e o lote segue;
  - PARA em erro sistêmico: 401, 403, `FISCAL_CERT_*`, `FISCAL_ISSUER_MISSING`, `FISCAL_CUTOVER_PENDING`, cofre, ou 3 desconhecidos seguidos;
  - tela fechada para sem relatório.
- **establishment**: aba do emissor pela nfse-api (`/v1/emitter`), só a NFS-e (D-F137), série 1–49999 recusada antes da API, selo pelos FATOS ("Aguardando a migração da emissão" com `cutoverAt` nulo).
- **Seção "No fisco"** extraída para widget próprio (`presentation/widget/service_order_fiscal_section.dart`):
  - voz indisponível e efeito indisponível ditos cada um pelo que é;
  - botões por `state`, `effect` e privilégio;
  - nota cancelada = só leitura.
- **i18n pt/en**: mortas saem (`fiscalEffectRow`, `fiscalSent`, `fiscalCancelled`, `fiscalCancelInFlight`, `fiscalPendingRow`, `issuerModel55`); novas entram (kind N, efeitos, reconferência, desfecho desconhecido, aplicar na nota, emissor aguardando).
- **Testes**: app **241/241** · core **18/18** · `flutter analyze` limpo. Novos:
  - `service_order_cancel_saga_test.dart`: saga, reações do bloc e contratos dos dois datasources;
  - `service_order_fiscal_batch_bloc_test.dart`: fotografia, parada sistêmica e um lote por vez;
  - `service_order_fiscal_section_test.dart`: 13 testes de widget;
  - `service_order_fiscal_cancel_waiver_test.dart` e `service_order_fiscal_entity_test.dart` reescritos;
  - `test/support/service_order_bloc_factory.dart`.
- **Passeio logado: NÃO feito**. Precisa da nfse-api e do setes-api da worktree no ar, e o `.env` das worktrees aponta para o MySQL de PRODUÇÃO. Fica para um ambiente de teste decidido ou para a própria janela (passo 7 — trilha); ver §22.16.6.

#### 22.16.4 Gates da F2b (app, `289de28`) — socrático **0,74 ✅** · adversarial **0,68 ✗** (sem HIGH/CRITICAL) → correções + D-F148…D-F150 (`bbeb1d6`) → re-gates

Agentes independentes. **Socrático 0,74**: o desenho segue as decisões (fisco primeiro, retomada por derivação, duas fontes/duas falhas,
barreira tipada, lote no app, servidor com a última palavra); notas baixas em falha externa (0,60), transação entre as duas autoridades
(0,65) e decisões vigentes (0,70). **Adversarial 0,68** (38 + 11 testes, 19 resistiram): saga (recusa/504 no fisco nunca chega ao ERP; bloc
fechado no meio conclui o ERP; "manter" durante a saga ignorado; 401 depois do fisco = `authorityCancelled`), respostas tortas (efeito/
estado/barreira desconhecidos neutros; `currentAttempt` inexistente não pega a última), lote (401, ids repetidos, 3× rede, teto), 401 global
(atrasado, simultâneo, ouvinte que se remove), AppModule real, emissor (série, `cutoverAt` nulo, 55 fora).

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| F2B-SOC-01 · ADV-06 | MEDIUM | 401 da nfse-api que não é sessão morta (kid novo desconhecido) derrubava o login do ERP — laço a cada OS faturada | **D-F148** (= Q-F160 (a)) — `ProductToken.confirm` + `ApiClient.sessionAlive` (`GET /api/core/me`), confirmações juntas = 1 pergunta, falha do confirmador não prova a morte |
| F2B-SOC-02 | MEDIUM | o plano envelhece no tempo humano antes do ato irreversível no fisco | **D-F149** (= Q-F161 (a)) — a saga relê o plano antes do fisco (estágio `plan`) |
| F2B-SOC-03 · ADV-02 | MEDIUM | o lote não parava com `FISCAL_AUTHORITY_AUTH_FAILED`/`CHAIN_UNTRUSTED`/`FISCAL_EMITTER_INCOMPLETE` (cada nota queima nDPS + voz F) | **corrigido**: erro SISTÊMICO (+ `SESSION_NOT_ACCEPTED`, `CLIENT_CONFIGURATION`) |
| F2B-ADV-01 · SOC-04 | MEDIUM | 502/503/504 do gateway (sem código) e erro de leitura não eram desfecho desconhecido — Transmitir/saga com falha seca; o lote não parava | **corrigido**: 408/502/503/504 sem código + `CLIENT_INVALID_RESPONSE` = desconhecido. O **500** = **Q-F163** |
| F2B-ADV-03 | MEDIUM | o Modular nunca fecha o bloc — `isClosed` nunca vira true e "tela fechada para o lote" (D-F145) não valia | **corrigido** pela TELA: o `dispose` da página manda `ServiceOrderFiscalBatchStopRequested` (para depois da nota em voo, sem relatório). Fechar o bloc no `onDispose` (corta também o lote de faturamento — Q-R5.2 aberta) = **Q-F164** |
| F2B-ADV-04 | MEDIUM | 2xx sem o envelope (HTML do host errado, 302 de proxy) virava "não transmitida"/"nada pendente"/"autorizada"/"ok" | **corrigido**: envelope ESTRITO na nfse-api (cliente) e nos datasources fiscais (`envelopeData`/`envelopePage`) → `CLIENT_INVALID_RESPONSE` (o setes-api segue tolerante — rotas antigas fora do envelope) |
| F2B-ADV-05 | LOW | `total` mentiroso + mesma página = até 10⁷ GETs | **corrigido**: página sem nota nova encerra + teto de páginas |
| F2B-ADV-07 | LOW | Transmitir sem trava de reentrância | **corrigido** |
| F2B-SOC-05 · ADV-08 | LOW | com a nota já cancelada (outra aba) o aviso dizia "aplicar na nota" | **corrigido**: `INVOICE_NOT_CANCELLABLE` antes de `authorityCancelled` |
| F2B-SOC-06 | LOW | `state` ausente = "nunca transmitida" + Transmitir | **corrigido**: `NfseState.unknown` (neutro) |
| F2B-SOC-07 · ADV-09 | LOW | bloco fiscal sem barreira = "o fisco não barra"; a página ignorava `cancellable`; plano sem `orderId` = nota 0 | **corrigido**: barreira desconhecida, `cancellable` exigido, plano com o id PEDIDO |
| F2B-SOC-08 · ADV-13 | LOW | `NfseApiClient extends ApiClient` — trocar a ordem dos binds cruzava as APIs | **corrigido**: `ProductApiClient` → `ApiClient` × `NfseApiClient` IRMÃOS |
| F2B-SOC-09 | LOW | build sem as URLs só falhava DEPOIS do upload | **corrigido**: `apps/web/build-web.ps1` recusa antes |
| F2B-ADV-10 | LOW | URL com barra final (`//v1`), sem esquema (= "rede caída"), http em produção | **corrigido**: base normalizada; base torta = `CLIENT_CONFIGURATION`; `AppConfig.urlProblems` na abertura |
| F2B-SOC-10 | LOW | o `ref` do 503 não chegava à seção | **corrigido**: código de suporte junto da falha de cada fonte |
| F2B-SOC-11 | LOW | voz indisponível escondia "Aplicar o cancelamento na nota"; Consultar sem TRANSMITIR | **corrigido** |
| F2B-ADV-11 | LOW | ouvinte que lança calava os outros; a aba velha apagava o login novo salvo | **corrigido**: ouvintes isolados + `lastExpired` |
| F2B-ADV-12 | LOW | tipo trocado = texto cru do Dart na tela; 201 torto = "recusada" | **corrigido**: falha do catálogo; num ato = desconhecido |
| F2B-SOC-12 | LOW | "Cancelar NFS-e" em homologação só cancelava a nota | **D-F150** (= Q-F162 (a)) |
| F2B-SOC-13 | LOW | teto do lote calado | **corrigido**: dito na confirmação (relatório perdido no 401 = aceito: o 401 leva ao login) |
| F2B-ADV-14 | LOW | chave i18n crua no detalhe do aviso e nas linhas do lote | **corrigido** (`.tr()`) |
| F2B-ADV-15 | LOW | ambiente ausente virava "H" (salvar trocaria P → H); desconhecido derrubava o dropdown | **corrigido**: desconhecido = sem seleção; salvar exige escolher |
| F2B-ADV-16 | LOW | senha errada no `/auth/login` com sessão viva na memória expirava a sessão | **corrigido**: `/auth/*` sem o Bearer da sessão |
| F2B-SOC-14 | LOW | `ARQUITETURA_MODULOS.md` desatualizado; §22.16 inexistente | **corrigido** |

Provas (`bbeb1d6`): app **284 + 3 pulados** (só os de DECISÃO: Q-F163 e Q-F164 ×2) · core do app **34/34** · `flutter analyze` limpo.
Re-gates do DELTA (`289de28..bbeb1d6`): §22.16.7.

#### 22.16.5 Provas (2026-10-13, depois das correções)

- **setes-api (worktree `f2a`)**:
  - `tsc` limpo;
  - suíte **1.793 ok + as MESMAS 20 falhas pré-existentes** (19 bomba-relógio do boleto em `bank-slip-registration`/`onda2-adversarial`/`onda2-gate-rework` + 1 cerca de fuso);
  - gates ao vivo (A3 + Rodada 4) **82/82** com `F2A_ADV_LIVE=1`;
  - `prove-f2a-abort.ts` em banco descartável **11/11**: novos casos — id que não é dono, OUTRA dona virada, estado incoerente;
  - cerca `swagger-parse.test.ts` 2/2, conferida contra o bloco quebrado.
- **núcleo**: **475/475** com `SETES_API_DIR` nas duas árvores (`f2a-r4-nucleo.test.ts` novo).
- **nfse-api**: **712** + 165 ao vivo pulados, nas duas árvores; ao vivo **150/150** (cópias `fiscal_api_adv_*`).
- **app**: 241/241 · core do app 18/18.
- Nenhum banco `f2a_*`/`fiscal_api_adv_*` sobrou.

#### 22.16.6 Questões da Rodada 4/F2b — DECIDIDAS (Valdo 2026-10-13: Q-F160…Q-F162 e depois Q-F156…Q-F159, Q-F163, Q-F164 — "siga as recomendações" → D-F148…D-F156, §7; execução no §22.18)

- **Q-F156 — classificação da falha da porta da voz (F2AR4-SOC-05)**: (a) manter tudo como 503 "tente de novo" · (b) **mesmo 503 e mesmo
  código para o app, mas o alarme e a mensagem separam "fonte" (erro do banco/servidor — "tente de novo em instantes") de "contrato"
  (mapa/argumento — "dado incoerente, acione o suporte", sem prometer "em instantes"); o alarme leva o usuário da requisição** · (c)
  contrato/argumento vira 500 INTERNAL. *(Rec.: (b) — a F2b não ramifica e a triagem fica honesta.)*
- **Q-F157 — um schema com gatilho faltando derruba o boot de TODOS (D-F135)**: (a) manter global · (b) **global agora + ferramenta
  "reaplicar a trava do schema X" (a mensagem de erro manda reaplicar e não há ferramenta) + quarentena por institution registrada para a
  F3** · (c) quarentena já. *(Rec.: (b) — 1 schema hoje; a quarentena exige decidir o que uma institution "em quarentena" pode fazer.)*
- **Q-F158 — o aborto deixa um fato que impeça o re-congelamento silencioso**: (a) só o roteiro corrigido (feito) · (b) a (a) + a flag de
  processo parado + id do schema (feito) · (c) **a (b) + uma LÁPIDE no `_migrations` (a versão da 069 com outro nome — o runner do código
  novo já recusa alto número repetido com nome diferente, PADROES §11 regra 14): voltar à F2a vira um ato deliberado (tirar a lápide)**.
  *(Rec.: (c) — reaproveita uma regra que já existe.)*
- **Q-F159 — estender a D-F136 para C/K (F2AR4-ADV, questão do gate adversarial)**: voz que PRESSUPÕE autorização (C cancelada, K
  cancelamento em voo) sem registro é linha incoerente; hoje um C sem registro em P dá efeito `apply` e o POST SOFT-DELETA a nota (número
  liberado) em vez de mantê-la viva com o C (D3/D4) — fixado como `[FATO]` no teste; 0 linhas assim hoje. (a) **sim, no mesmo molde (mapa
  da família falha alto)** · (b) só conhecimento negativo. *(Rec.: (a).)*
- **Q-F160…Q-F162 — DECIDIDAS** (Valdo 2026-10-13: "siga as recomendações" → D-F148…D-F150, §7).
- **Q-F163 — o 500 da nfse-api num ATO (transmitir, cancelar no fisco, reconferir) é desfecho DESCONHECIDO? (F2B-ADV-01)**: (a) **sim —
  nada garante que o ato não aconteceu (a nfse-api pode ter falhado DEPOIS de falar com o fisco); a tela diz "resultado incerto —
  consulte" e o lote conta para a parada de 3 seguidos; nas LEITURAS segue falha comum** · (b) não — 500 é bug do servidor, falha comum.
  *(Rec.: (a) — o 502/503/504 do gateway já é; o 500 da própria nfse-api tem a mesma incerteza.)*
- **Q-F164 — o Modular fechar o `ServiceOrderBloc` no `onDispose` (F2B-ADV-03)**: hoje NENHUM bloc do app é fechado (o Modular 5 só
  descarta `Disposable`/`onDispose`); a parada do lote fiscal já vem da PÁGINA (dispose). Fechar o bloc (a) **sim, `onDispose: (b) =>
  b.close()` neste módulo — o que também corta o lote de FATURAMENTO entre blocos ao sair da tela (decide a Q-R5.2 junto)** · (b) só a
  parada pela página (feito) e a Q-R5.2 segue aberta · (c) `onDispose` em todos os módulos do app (varredura). *(Rec.: (a) — o `_runBatch`
  do faturamento já checa `isClosed` entre blocos: a intenção escrita é parar; o que já foi faturado fica na lista.)*

#### 22.16.7 Re-gates do delta da F2b (`289de28..bbeb1d6`) — socrático **0,78 ✅** · adversarial **0,75 ✅** (sem HIGH/CRITICAL)

Os achados do gate anterior confirmados FECHADOS (com `--run-skipped`, só os testes de DECISÃO falhavam — Q-F163/Q-F164 → D-F155/D-F156).
Resistiram: confirmador da D-F148 (sem laço; token trocado no meio; relogin; tokens diferentes), `/auth` públicas, envelope estrito contra
TODAS as rotas reais da nfse-api, releitura da D-F149 (caixa fechado na releitura; 504 na releitura = falha comum), leituras com 408/502/503/
504 = "indisponível", parada do lote com o bloc ocioso, seção (Aplicar com a voz indisponível, código de suporte, Consultar exige TRANSMITIR).
Achados novos (todos corrigidos na sessão — app `5c80e20`, junto com D-F155/D-F156):

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| F2B-RG-01 | MEDIUM | `build-web.ps1` UTF-8 sem BOM: o Windows PowerShell 5.1 (o da máquina) lê pela página ANSI e o "—" quebra o parse — o guarda nunca rodava | **corrigido**: arquivo com BOM; cerca que faz o parse pelo PS 5.1 |
| F2B-RG-02 | LOW | o script aceitava consulta/fragmento (o app recusa → build publicado abre a tela de erro) e loopback numa publicação | **corrigido**: a regra do app + https, sem loopback, sem credenciais, porta 1–65535 |
| F2B-RG-03 · ADV-11 | LOW | várias abas: o cache do SharedPreferences fazia a aba velha apagar o login novo | **corrigido**: `LocalPrefs.getSessionTokenFresh` (reload) antes de comparar |
| F2B-RG-04 · SOCD-02 | LOW | isenção de `/auth/*` por PREFIXO tirava o Bearer da `/auth/switch-institution` (exige a sessão) | **corrigido**: LISTA das 4 rotas públicas |
| F2B-RG-05 · SOCD-04 | LOW | a releitura da D-F149 não conferia o `orderId` | **corrigido** (plano de outra nota = falha técnica, nunca o fisco) |
| F2B-RG-06 · SOCD-03 | LOW | a pergunta ao emissor sem prazo pendurava a chamada da nfse-api (e as seguintes, pela deduplicação) | **corrigido**: 15 s = "não prova a morte" |
| F2B-RG-07 · SOCD-08 | LOW | a aba do emissor fora do envelope estrito (`{}` = "sem certificado"; tipo trocado = spinner eterno) | **corrigido**: `envelopeData` + falha do catálogo |
| F2B-RG-08 | LOW | `urlProblems` aceitava porta fora da faixa, credenciais na URL, host torto | **corrigido** |
| F2B-SOCD-07 | LOW | `SESSION_NOT_ACCEPTED` perdia o código de origem; comentário do AppModule velho | **corrigido**: `supportRef` = "código: frase" de origem |
| F2B-SOCD-06 | LOW | voltar à tela com uma nota em voo ignorava o lote novo sem aviso | **coberto pela D-F156** (bloc novo por tela; o antigo para depois da nota em voo) |
| F2B-SOCD-01 | MEDIUM | o `SESSION_NOT_ACCEPTED` não deixa rastro para o suporte (o `productAuth` do núcleo não loga o 401; o app não tem telemetria) | **Q-F165** |
| F2B-SOCD-05 | LOW | a janela que sobra na D-F149 é a chamada inteira ao fisco (~35 s ou o timeout do gateway), não "segundos" | **Q-F166** |
| F2B-RG Q-01 | — | voz indisponível + efeito `decide`: "Manter a nota" aparece sem a frase que explica a substituição (ela vinha da voz) | **Q-F167** |

#### 22.17 ⏯ PROMPT DE RETOMADA — questões Q-F156+ → passeio logado → JANELA (colar numa sessão nova)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.16 (Rodada 4 da F2a + Rodada 1 da F2b EXECUTADAS, gates do delta e da F2b,
Q-F156+) e o roteiro da JANELA no §22.13 (com o aborto da D-F134); §22.14 e §7 (D-F130…D-F147) quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta 1a5af8e+) · núcleo 4cb74d9+ ·
nfse-api 5107863+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 289de28+).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela. Testes ao vivo só em bancos descartáveis (f2a_*, fiscal_api_adv_*), apagados no fim.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist).
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas FALHAM — script em arquivo); commit só dos caminhos
  da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.

PASSO 1 — com as respostas do Valdo às Q-F156…Q-F159 e Q-F163/Q-F164 (+ as dos re-gates, §22.16.7): registrar D-F151+ no §7, executar (worktree f2a / núcleo / nfse-api / app) e rodar os
  gates do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo roteiro do §22.13
  (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.18+), INDICE_CENTRAL, CLAUDE.md da raiz,
  memória apis-fiscais-isoladas.
```


### 22.18 Rodada 5 da F2a/F2b — DECIDIDA e EXECUTADA (2026-10-13) — D-F151…D-F156

> Valdo (2026-10-13): "Q-F156 a Q-F159, Q-F163, Q-F164 — siga recomendações" (e antes "Q-F160, Q-F161, Q-F162 — siga recomendações" →
> D-F148…D-F150, executadas no app `bbeb1d6` — §22.16.4). Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.18.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| setes-api (worktree `f2a`) | `22388d9` | D-F151 (`voiceFailureCause` fonte × contrato; mensagens; alarme com o autor — `@shared/request-actor` no `authMiddleware`); D-F152 (`scripts/f2a-reapply-freeze.ts`; o boot aponta para ela); D-F153 (lápide no aborto + `--retirar-lapide`; runner com mensagem própria; nomes em `src/migrations/f2a-names.ts`); D-F154 (o teste que fixava o "apply" virou o da decisão) |
| núcleo | `de5924c` | D-F154: `AUTHORIZATION_PRESUPPOSED_KINDS` no vocabulário; `mapCommonView` recusa C/K sem registro |
| nfse-api | `4a1a9a4` | D-F154 no `mapTx` |
| app (worktree `f2b`) | `5c80e20` | D-F155, D-F156 (`stopBatches()` + `onDispose`) e as correções dos re-gates (§22.16.7) |

#### 22.18.2 Provas (2026-10-13)

- setes-api `f2a`: `tsc` limpo; suíte **1.805 + as MESMAS 20 pré-existentes** (19 boleto + 1 fuso); gates ao vivo (A3 + R4) **82/82**;
  `prove-f2a-abort.ts` em banco descartável **16/16** (lápide, recusa do runner sobre a lápide, `--retirar-lapide`, reaplicar a trava — com
  a lápide recusa; derrubado à mão volta e a conferência do boot passa); `f2a-rodada5.test.ts` 13/13.
- núcleo **476/476** nas duas árvores · nfse-api **713** + 165 ao vivo pulados (as duas árvores).
- app **305 + 1 pulado** (Q-F167) · core do app **46/46** · `flutter analyze` limpo · `build-web.ps1` parseado pelo PowerShell 5.1.
- Dado (só SELECT, 2026-10-13): última voz por tentativa — `fiscal_api` e origem iguais: C registrada em P ×3, F em H ×1, R em H ×13, R em P
  ×3; nenhum K; nenhuma C/K sem registro (a D-F154 não prende nada de hoje).

#### 22.18.3 Q-R5.2 (`prompt_primeiro_cliente_setes.md` §11) — DECIDIDA junto (D-F156)

Sair da tela no meio do lote de FATURAMENTO = PARAR de enviar os blocos seguintes (o em voo termina; o que já rodou fica na aba Faturadas;
sem relatório). A "barreira modal com progresso" da recomendação original fica como melhoria de UX (não feita).

#### 22.18.4 Gates do delta da Rodada 5 (`1a5af8e..22388d9` · `4cb74d9..de5924c` · `5107863..4a1a9a4` · `bbeb1d6..5c80e20`)

**Socrático: 0,76 ✅** (sem CRITICAL/HIGH; 1 MEDIUM + 7 LOW; sondas reais: flutter_modular 5.0.3, bloc 8.1.4, mysql2 3.22.4 — só SELECT
no dev; suítes conferidas pelo agente: setes-api 1.805 + as MESMAS 20 · núcleo 476 · nfse-api 713 · app 305+1 · core 46).

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| R5-SOC-01 | MEDIUM | o `stopBatches()` no `dispose` da PÁGINA dispara também quando a janela cruza 1100 px (o `Responsive` troca o layout desktop × mobile e cada um tem o seu `RouterOutlet` — a página é recriada, o MÓDULO não): o lote para calado sem o operador sair | **Q-F168** |
| R5-SOC-02 | LOW | o conhecimento negativo da D-F156 estava ERRADO: o `close()` do bloc 8 termina logo e o `isClosed` vira true — o handler em andamento é que segue até o fim | **corrigido** (texto da D-F156 + comentários do bloc) |
| R5-SOC-03 | LOW | a lápide presa ao NÚMERO: a F2a renumerada num rebase (069 → 071) voltava calada; outra migration no número da lápide caía na mensagem genérica | **corrigido** (pelo NOME; número RESERVADO — PADROES §11 regra 14) |
| R5-SOC-04 | LOW | os 3 erros do POOL do mysql2 (`Pool is closed.`, `No connections available.`, `Queue limit reached.`) não têm `code`/`errno` → saíam "contrato"; `POOL_CLOSED`/`POOL_ENQUEUELIMIT` são do pacote `mysql` (mortos) | **corrigido** |
| R5-SOC-05 | LOW | o aborto derrubava os gatilhos ANTES da lápide (queda no meio = estado que o próprio aborto recusa) e "concluía" com gatilho escondido por privilégio | **corrigido**: lápide primeiro; linha registrada exige ver os 9 |
| R5-SOC-06 | LOW | roteiro com as recusas do ABORTO depois do comando de reaplicar; D-F134 sem a marca da emenda; "para cada schema ativo" | **corrigido** (texto) |
| R5-SOC-07 | LOW | `reapplyF2aFreeze` aceitava um pool (o `USE` numa conexão, os CREATE em outra) | **corrigido**: tipo + recusa em execução |
| R5-SOC-08 | LOW | a mesma C/K sem registro dá 3 frases (ERP "INCOERENTE" · ato da nfse-api "resultado incerto" · consulta "indisponível") — sempre para o lado conservador | **Q-F169** |

Pontos abertos sem achado (registrados): o pool CHEIO não tem prazo de espera (a leitura da voz espera sem 503 nem alarme — o mysql2 não
tem `acquireTimeout`); uma linha incoerente PERSISTENTE grava um alarme por carga da lista (D-F130; 0 linhas hoje).

**Adversarial: 0,72 ✅** (sem CRITICAL/HIGH; 1 MEDIUM + 8 LOW; achados anteriores seguem FECHADOS — com `--run-skipped` só o teste de
decisão Q-F167 falha; ataques AO VIVO só em bancos descartáveis `f2a_advr5_*`, apagados). Resistiram: fonte × contrato contra erros REAIS
(ECONNREFUSED, 1146, 1054, conexão morta por KILL; 1205 de metadados sobe cru para o 409), o autor do alarme com 2 requisições simultâneas
resolvidas na ordem inversa, nenhuma rota sem `authMiddleware` alcança a porta, C/K ⇒ registro nos fluxos legítimos (núcleo e nfse-api),
D-F155 (ato × leitura × 3 seguidos), D-F156 pelo `onDispose`, prazo de 15 s × relogin, lista de `/auth`. FATO registrado: voltar à tela
cria um bloc NOVO que manda a mesma nota em paralelo com o antigo — quem serializa é a trava da nfse-api.

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| R5-ADV-01 | MEDIUM | = R5-SOC-03: a lápide só valia para a MESMA versão — a F2a renumerada (069 → 071, o roteiro manda renumerar contra o `main`) re-congelava o ERP CALADO (provado com o runner real) | **corrigido** (pelo NOME) |
| R5-ADV-02 | LOW | a lápide OCUPA a versão 069 em produção: a próxima migration do `main` com o 069 derruba o boot do código ANTIGO com a frase genérica | **corrigido em parte** (o runner da F2a diz "RESERVADA"); o do `main` → **Q-F170** |
| R5-ADV-03 | LOW | = R5-SOC-04 (`Pool is closed.` saía "contrato") | **corrigido** |
| R5-ADV-04 | LOW | reaplicar derrubava e recriava os 9 um a um: entre o DROP e o CREATE de cada um a escrita congelada PASSOU (provado ao vivo — `slipped = 1` no contador da SE, gatilho que NÃO faltava) | **corrigido**: só o DROP+CREATE do que falta/difere |
| R5-ADV-05 | LOW | uma tentativa K/C sem registro faz `listRefreshCandidates` (nfse-api) lançar para a lista INTEIRA — a consulta ativa do estabelecimento para | **Q-F172** |
| R5-ADV-06 | LOW | `AUTHORIZATION_PRESUPPOSED_KINDS` era lista à mão no arquivo cujo contrato diz "deriva da `KIND_CLASS`" (o evento da NF-e entraria fora da regra) | **corrigido**: atributo `presupposesAuthorization` na classe |
| R5-ADV-07 | LOW | = R5-SOC-02 + 3 caminhos `await <diálogo>` → `_bloc.add` sem `mounted` (bloc agora fecha no `onDispose` → StateError) | **corrigido** |
| R5-ADV-08 | LOW | `build-web.ps1` × `urlProblems` × navegador: host que termina em número sem ser IPv4 válido aceito nos dois; ponto final / `localhost.` / sublinhado aceitos só no script; `0.0.0.0`/`[::]` passavam | **corrigido**: a MESMA regra nos dois |
| R5-ADV-09 | LOW | (anterior ao delta, mesma linha) `body['error'] as String?` lançava TypeError com o JSON de erro de um gateway | **corrigido** |
| Q-F168-ADV-02 | — | 409 `RESOURCE_BUSY` num ATO (a gravação da voz DEPOIS do fisco esbarrou numa trava) aparece como "tente de novo" | **Q-F171** |

**Correções da sessão** (commits LOCAIS): setes-api `b271e03` · núcleo `01bba49` · nfse-api `5e61686` (testes do gate) · app `6d94a6d`.
Provas depois delas: setes-api **1.821 + as MESMAS 20** (19 boleto + 1 fuso) · gates ao vivo (A2+A3+R4+R5, bancos descartáveis) **119/119** ·
`prove-f2a-abort.ts` **18/18** (nenhum banco sobrou) · núcleo **481/481** nas duas árvores (`dist` reconstruído) · nfse-api **718** + 165
pulados nas duas árvores · core do app **54/54** · app **320 + 2 pulados** (decisões Q-F167 e Q-F171) · `flutter analyze` limpo nos dois.

#### 22.18.5 Questões da Rodada 5 e dos seus gates — DECIDIDAS (Valdo 2026-10-13: "Q-F165 a Q-F172 - siga recomendações" → D-F157…D-F164, §7; execução no §22.20)

- **Q-F165 — canal do alarme do `SESSION_NOT_ACCEPTED` (F2B-SOCD-01)**: hoje nenhum log registra o 401 da nfse-api por kid desconhecido ou
  institution divergente; o suporte só fica sabendo por telefone. (a) **o `productAuth` do núcleo loga `warn` por 401 com a CLASSE (kid
  desconhecido — com o kid, que não é segredo —, expirado, institution divergente, sem identidade), nunca o token, com limite por minuto; e o
  roteiro de rotação do `JWT_KID` passa a exigir publicar a chave pública na nfse-api ANTES de virar** · (b) a (a) + o app reportar ao
  crashlytics central do setes-api (porta de telemetria nova) · (c) só a cerca da janela. *(Rec.: (a) — fica no núcleo, a nfe-api herda.)*
- **Q-F166 — a janela que sobra na D-F149 (F2B-SOCD-05)**: a chamada inteira ao fisco (reserva K + termos até 3 s + o evento até 30 s ≈ 35 s,
  ou o timeout do gateway) — nesse intervalo baixa/boleto/cheque não olham o K em voo; se mudar, o fisco cancela e a nota fica (`apply`).
  (a) **aceitar e DOCUMENTAR o teto real (≈ 35 s / timeout do gateway) no lugar de "segundos"** · (b) baixa, boleto e cheque recusam com K em
  voo (o ERP passa a ler a voz nesses atos). *(Rec.: (a) — raro e recuperável pelo `apply`; a (b) espalha a leitura da voz por módulos.)*
- **Q-F167 — "Manter a nota" com a voz indisponível (re-gate adversarial da F2b)**: com o efeito `decide` e a voz do fisco fora, o botão
  aparece sem a frase que explica a substituição (ela vinha da voz). (a) esconder o botão até a voz voltar · (b) **uma linha a partir do
  efeito do ERP ("NFS-e substituída no fisco — decida") — cada fonte mostra as próprias ações (F2B-SOC-11); o ERP reconfere no POST**.
  *(Rec.: (b).)*
- **Q-F168 — onde o app decide que "a tela saiu" (R5-SOC-01)**: (a) **só no `onDispose` do MÓDULO** — tirar o `stopBatches()` do
  `dispose` da página (o módulo só é descartado ao navegar para outra tela; provado na sonda) · (b) manter os dois e preservar o
  `RouterOutlet` na troca de layout (árvore única no shell — resolve também a perda de estado de QUALQUER tela ao redimensionar, que já
  existe hoje) · (c) aceitar e documentar. *(Rec.: (a) agora — local e fiel à intenção da D-F156; a (b) vira item próprio de UX do shell.)*
- **Q-F169 — a frase da incoerência C/K sem registro (R5-SOC-08)**: (a) **aceitar e documentar** (0 linhas hoje; a D-F154 é alarme) ·
  (b) a nfse-api ganha um código próprio para a incoerência ANTES do ato ("nada foi feito — suporte") e o app a trata como falha comum.
  *(Rec.: (a).)*
- **Q-F170 — a forma da LÁPIDE (R5-ADV-01/02)**: hoje a lápide ocupa a versão da migration (069) no `_migrations`; o runner da F2a já
  recusa pelo NOME e chama o número de RESERVADO, mas o código ANTIGO (o `main`, que é o que roda depois de um aborto) cai na frase genérica
  "duas migrations com o mesmo número" se o `main` ganhar uma 069 — com o `tsx watch`, salvar o arquivo derruba a produção. (a) **lápide
  com versão SENTINELA (`F2A-ABORT` — cabe no `VARCHAR(10)`; o runner do `main` ignora versão sem arquivo e não ordena por número —
  conferido) e recusa pelo nome**: fecha os dois · (b) manter a versão e registrar a reserva (PADROES §11 regra 14 — feito). *(Rec.: (a).)*
- **Q-F171 — 409 `RESOURCE_BUSY` num ATO (Q-F168-ADV-02)**: a nfse-api devolve-o quando a gravação da voz, DEPOIS de falar com o fisco,
  esbarra numa trava (lock wait); hoje o app mostra "tente de novo". (a) **tratar como desfecho DESCONHECIDO ("resultado incerto —
  consulte") nos atos, pela mesma razão da D-F155** · (b) manter. *(Rec.: (a); leituras seguem falha comum.)*
- **Q-F172 — uma linha incoerente no rodízio (R5-ADV-05)**: uma tentativa K/C sem registro faz a lista de candidatas da consulta ativa
  lançar INTEIRA (para o estabelecimento todo). (a) **pular a linha COM alarme dentro da lista do rodízio; o leitor da NOTA continua
  falhando alto** · (b) manter (a D-F154 é alarme; 0 linhas hoje). *(Rec.: (a).)*

**Pendências antes da janela** (em 2026-10-13, antes da Rodada 6): decidir Q-F165…Q-F172 (FEITO — §22.20); o PASSEIO LOGADO da F2b (ambiente: a decidir — as
worktrees apontam para o MySQL de produção; alternativa: na janela, depois do passo 5, como parte da trilha do passo 7); conferir na janela
quantas notas sem NFS-e não são de OS (D-F145); push dos repos só com o "vai".

#### 22.19 ⏯ PROMPT DE RETOMADA — Q-F165+ → passeio logado → JANELA (SUPERADO pelo §22.21)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.18 (Rodada 5 EXECUTADA — D-F151…D-F156; gates do delta; Q-F165+), o §22.16
(Rodada 4 + F2b + re-gates) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE da D-F153; reaplicar a trava — D-F152); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta b271e03+) · núcleo 01bba49+ ·
nfse-api 5e61686+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 6d94a6d+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist).
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas FALHAM — script em arquivo); .ps1 com BOM (PS 5.1);
  commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.

PASSO 1 — com as respostas do Valdo às Q-F165…Q-F172 (§22.18.5): registrar D-F157+ no §7, executar e rodar os gates do delta.
PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo roteiro do §22.13 (cada passo
irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.20+), INDICE_CENTRAL, CLAUDE.md da raiz, memória
apis-fiscais-isoladas.
```

### 22.20 Rodada 6 da F2a/F2b — DECIDIDA e EXECUTADA (2026-10-13) — D-F157…D-F164

> Valdo (2026-10-13): "Q-F165 a Q-F172 - siga recomendações". Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.20.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| núcleo | `c0a8d35` | D-F157: `ProductAuthError` com a classe, `authRejectLog` (limite por classe/minuto), `safeKid`, `productAuth(…, onReject)`; teste `rodada6-auth-log.test.ts`; `dist` reconstruído |
| nfse-api | `391fef7` | D-F164: aviso opcional em `listRefreshCandidates`; a passada pula com alarme, relata com ref e marca `last_queried_at` (referência pela MESMA `refOfTx` — cerca D-NE12) |
| setes-api (worktree `f2a`) | `99da896` | D-F162: `F2A_TOMBSTONE_VERSION = 'F2A-ABORT'`; o aborto troca versão e nome; linha + lápide = recusa; a lápide numérica antiga segue recusada pelo nome (e reservando o número) |
| app (worktree `f2b`) | `3b5b2b6` | D-F159 (`fiscalEffectDecideRow` pt/en), D-F160 (o `dispose` da página não para mais os lotes), D-F163 (`RESOURCE_BUSY` no classificador dos atos); NENHUM teste pulado |
| Infra-IA | (este) | §7 D-F157…D-F164 + emendas (D-F149/D-F153/D-F154/D-F156); PADROES_BANCO v1.5 (§7 rotação do `JWT_KID`; §11 regra 14 lápide sentinela) |

D-F158 e D-F161 = só doc (§7).

#### 22.20.2 Provas (2026-10-13)

- setes-api `f2a`: `tsc` limpo; suíte **1.823 + as MESMAS 20** (19 boleto + 1 fuso); gates ao vivo (A2+A3+R4+R5) **119/119**;
  `prove-f2a-abort.ts` **20/20** em banco descartável (lápide sentinela; a 069 do `main` roda sobre o schema abortado; linha + lápide =
  recusa); nenhum banco `f2a_*`/`fiscal_api_adv*` sobrou.
- núcleo **485/485** nas duas árvores · nfse-api **719** + 165 pulados nas duas árvores · nfse-api AO VIVO (fisco falso, cópias
  descartáveis) **150/150**.
- app **321/321** (nenhum pulado — as decisões destravaram Q-F167 e Q-F171) · core do app **54/54** · `flutter analyze` limpo.

#### 22.20.3 Gates do delta da Rodada 6 (`b271e03..99da896` · `01bba49..c0a8d35` · `5e61686..391fef7` · `6d94a6d..3b5b2b6`)

**Socrático: 0,77 ✅** (sem CRITICAL/HIGH; 1 MEDIUM + 9 LOW; sondas no `dist` do núcleo e de widget; só SELECT no dev) · **Adversarial:
0,80 ✅** (6 LOW; ataques ao vivo em `f2a_advr6_*`/`fiscal_api_adv_r6`, apagados; achados anteriores seguem FECHADOS — gates A2/A3/R4/R5 ao
vivo 125/125, `prove-f2a-abort` 20/20, nfse-api ao vivo 150/150 com o CHECKSUM do `fiscal_api` e do ERP iguais antes e depois). Resistiram:
o kid hostil (CRLF, NUL, RTL, 10 mil caracteres) saneado no log e na frase, token gigante (431 do Node), 70 mil recusas = 35 linhas, o log
que lança, o ciclo inteiro da lápide sentinela ao vivo (inclusive o runner do `main` rodando uma 069 nova), duas incoerentes no topo do
LIMIT sem fome, `RESOURCE_BUSY` só "incerto" no estágio do fisco, D-F159/D-F160 nas telas.

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| R6-SOC-01 | MEDIUM | "a decisão sobre a nota já foi registrada" aparecia com o efeito do ERP INDISPONÍVEL e com `cancel` em homologação (onde não há "manter") | **corrigido**: a frase de "decidida" só com a dispensa gravada ou a nota cancelada; senão a NEUTRA |
| R6-SOC-02 | LOW | o resumo das suprimidas dizia "no minuto anterior" mesmo horas depois | **corrigido**: diz QUANDO a janela começou (`windowStartedAt`) |
| R6-SOC-03 | LOW | a rota (do atacante) ia inteira ao log | **corrigido**: só ASCII visível, até 200 |
| R6-SOC-04 | LOW | HS256 indistinguível de assinatura RS256 errada; kid não-texto "(kid undefined)" | **corrigido**: `alg` no log da classe `invalid`; kid não-texto/vazio = D-F165 |
| R6-SOC-05 | LOW | o núcleo aceitava token sem `exp` e sem `kid` (o setes-api recusa) | **D-F165** (= Q-F173 (a)) |
| R6-SOC-06 | LOW | `RESOURCE_BUSY` ANTES do fisco também vira "incerto" | **D-F166** (= Q-F174 (a)) |
| R6-SOC-07 · R6-ADV-04 | LOW | o aviso do rodízio engolia também a PROJEÇÃO torta (regressão do SELECT = todas puladas e carimbadas) | **corrigido**: `IncoherentTransmissionError` só para o dado torto; o resto relança |
| R6-SOC-08 · R6-ADV-06 | LOW | página recriada (1100 px) com o lote no ar: a lista vem `loading: false`, a trava H1 reabre e a tela parece ociosa | **Q-F177** |
| R6-SOC-09 | LOW | roteiro da rotação do `JWT_KID` sem: kid idêntico nos `.env`, migração da forma `JWT_PUBLIC_KEY_PATH` → lista, reinício das instâncias, PROVA antes de virar | **corrigido** (PADROES §7) |
| R6-SOC-10 | LOW | o ato da nfse-api, com a LÁPIDE, dizia "aplique a F2a"; "reaplique a migration" anterior à D-F152 | **corrigido**: frase de COMO voltar (`--retirar-lapide`) e a ferramenta `f2a-reapply-freeze.ts` |
| R6-ADV-01 | LOW | o limite é só por classe: um anônimo forja 5 `unknown_kid`/min (o kid é lido antes da assinatura) e o kid real de uma rotação mal publicada some | **Q-F175** |
| R6-ADV-02 | LOW | relógio que VOLTA deixava a janela aberta e o excedente calado | **corrigido**: `t < início` abre janela nova |
| R6-ADV-03 | LOW | `bearer <tok>` / `Token <tok>` eram "missing" ("não veio token" quando veio) | **corrigido**: outro esquema = `malformed` |
| R6-ADV-05 | LOW | o relatório do lote fiscal conta o desfecho DESCONHECIDO como "Recusada" + "tente novamente" (o oposto da D-F163) | **Q-F176** |

**Correções da sessão** (commits LOCAIS — §22.20.4): núcleo (D-F165 + R6-SOC-02/03/04 + R6-ADV-02/03) · nfse-api (R6-SOC-07/10 + testes
dos gates) · app (R6-SOC-01) · setes-api (só o teste do gate). FATOS registrados pelo adversarial (sem achado): voltar à tela cria um bloc
NOVO que manda a mesma nota em paralelo (a trava da nfse-api serializa); depois de corrigida à mão a linha incoerente, "Última consulta"
mostra a hora em que ela foi pulada; a sentinela já ocupada por uma linha escrita à mão faz o aborto falhar fechado com o `ER_DUP_ENTRY` cru.

#### 22.20.4 Questões dos gates da Rodada 6 — DECIDIDAS (Valdo 2026-10-13: "Q-F173 e Q-F174" e "Q-F175 a Q-F177 - siga recomendações" → D-F165…D-F169, §7; execução no §22.22)

- **Q-F175 — o log do 401 sob kid forjado (R6-ADV-01)**: (a) aceitar · (b) **logar a 1ª ocorrência de cada kid DISTINTO na janela (conjunto
  limitado a 16) além do limite por classe** · (c) o resumo das suprimidas lista os kids distintos. *(Rec.: (b) — o kid real de uma rotação
  mal publicada sempre aparece.)*
- **Q-F176 — o relatório do lote fiscal (R6-ADV-05)**: (a) **categoria "incertas — consulte" com contador e frase próprios** (o desfecho
  desconhecido — D-F155/D-F163 — nunca vira "recusada / tente novamente") · (b) manter. *(Rec.: (a).)*
- **Q-F177 — o lote no ar com a página recriada (R6-ADV-06/R6-SOC-08)**: (a) **o bloc mantém a lista em `loading` enquanto um lote roda**
  (a trava H1 continua e a tela mostra que algo roda) · (b) estado "lote em andamento" próprio que a página recriada respeite · (c) aceitar
  até o item de UX do shell (preservar o `RouterOutlet` — D-F160). *(Rec.: (a).)*

#### 22.21 ⏯ PROMPT DE RETOMADA — Q-F175…Q-F177 → passeio logado → JANELA (SUPERADO pelo §22.23)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.20 (Rodada 6 EXECUTADA — D-F157…D-F164; gates do delta no §22.20.3), o §22.18
(Rodada 5 + gates), o §22.16 (Rodada 4 + F2b) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA — D-F153/D-F162; reaplicar a
trava só do que falta — D-F152); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta 99da896+) · núcleo c0a8d35+ ·
nfse-api 391fef7+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 3b5b2b6+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist).
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo); .ps1 com BOM
  (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.

PASSO 1 — com as respostas do Valdo às Q-F175…Q-F177 (§22.20.4): registrar D-F167+ no §7, executar e rodar os gates do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo roteiro do
§22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.22+), INDICE_CENTRAL, CLAUDE.md da
raiz, memória apis-fiscais-isoladas.
```

### 22.22 Rodada 7 da F2a/F2b + correções dos gates da Rodada 6 — EXECUTADAS (2026-10-13) — D-F165…D-F169

> Valdo (2026-10-13): "Q-F173 e Q-F174 - siga recomendações" (D-F165/D-F166) e "Q-F175 a Q-F177 - siga recomendações" (D-F167…D-F169).
> Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.22.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| núcleo | `8704085` | D-F165 (kid/exp obrigatórios), D-F167 (kid distinto no log, conjunto ≤ 16), R6-SOC-02/03/04, R6-ADV-02/03; testes `rodada6-auth-log`, `rodada7-auth-kids`, gate adversarial R6, `contrato` (os tokens de "sem identidade" agora com `exp`); `dist` reconstruído |
| nfse-api | `7bf6ea9` | R6-SOC-07/R6-ADV-04 (`IncoherentTransmissionError` — só a incoerência de DADO é pulada), R6-SOC-10 (o ato reconhece a LÁPIDE — a leitura original fica intacta; a lápide só é procurada para a FRASE quando a F2a está ausente); testes do gate R6 + ato com a lápide |
| setes-api (worktree `f2a`) | `f5d2be2` | o teste do gate adversarial R6 (o ciclo da lápide sentinela ao vivo) |
| app (worktree `f2b`) | `e89231e` | D-F168 (`uncertain`/`uncertainRows` + chaves pt/en), D-F169 (`_batchInFlight` no `_reloadList`), R6-SOC-01 (frase neutra); testes destravados (nenhum pulado) |

D-F166 = só doc (§7).

#### 22.22.2 Provas (2026-10-13)

- setes-api `f2a`: suíte **1.827 + as MESMAS 20** (19 boleto + 1 fuso); gates ao vivo (A2+A3+R4+R5+R6) **125/125**; `prove-f2a-abort.ts` **20/20**;
  nenhum banco `f2a_*`/`fiscal_api_adv*` sobrou.
- núcleo **502/502** nas duas árvores · nfse-api **724** + 165 pulados nas duas árvores · nfse-api AO VIVO (fisco falso, cópias
  descartáveis) **156/156** (150 + o gate R6).
- app **339/339** (nenhum pulado) · core do app **54/54** · `flutter analyze` limpo.
- Lição: teste que simula o banco pela FORMA exata da consulta (8 testes do ato na nfse-api) acusa qualquer mudança de SQL — a leitura
  nova entrou SEPARADA, sem mexer na antiga.

#### 22.22.3 Gates do delta da Rodada 7 (`c0a8d35..8704085` · `391fef7..7bf6ea9` · `99da896..f5d2be2` · `3b5b2b6..e89231e`)

Resultados no §22.22.3-bis (logo abaixo do prompt de retomada §22.23).

#### 22.23 ⏯ PROMPT DE RETOMADA — gates da Rodada 7 → passeio logado → JANELA (SUPERADO pelo §22.25)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.22 (Rodada 7 EXECUTADA — D-F165…D-F169; gates do delta no §22.22.3), o §22.20
(Rodada 6 + gates), o §22.18 (Rodada 5) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA — D-F153/D-F162; reaplicar a
trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta f5d2be2+) · núcleo 8704085+ ·
nfse-api 7bf6ea9+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, e89231e+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez (suítes ao vivo em paralelo no mesmo MySQL se atropelam).
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit` (o paralelo cai com kill EPERM).
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo); .ps1 com BOM
  (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.
  Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores.

PASSO 1 — se os gates do delta da Rodada 7 (§22.22.3) deixaram questões: com as respostas do Valdo, registrar D-F170+ no §7, executar e
rodar os gates do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo roteiro do
§22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.24+), INDICE_CENTRAL, CLAUDE.md da
raiz, memória apis-fiscais-isoladas.
```

#### 22.22.3-bis Resultado dos gates do delta da Rodada 7

**Socrático: 0,78 ✅** (5 LOW) · **Adversarial: 0,74 ✅** (1 MEDIUM + 5 LOW; achados anteriores seguem fechados — com `ADV_SHOW=1` só os novos
falham; nfse-api ao vivo 156/156 com o CHECKSUM do `fiscal_api` e do ERP iguais; setes-api ao vivo 128/128). Resistiram: `exp` de tipo
estranho, a ordem das checagens (sem oráculo), kid estranho (`__proto__`), 100 mil kids com memória fixa e resumo exato, a leitura original
do ato intacta, D-F168/D-F169 em todas as combinações, a matriz de 8 casos da frase da substituição.

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| R7-ADV-01 | MEDIUM | token com corpo que NÃO é JSON fazia o `jws` lançar no decode → 500 `INTERNAL` com stack no log, sem o limite do log do 401 (o setes-api responde 401) | **corrigido**: decode protegido → 401 `malformed` |
| R7-SOC-01 · R7-ADV-02 | LOW | 16 kids forjados esgotam o conjunto da D-F167 e o kid real some | **D-F170** (= Q-F178 (b)) |
| R7-SOC-02 · R7-ADV-05/06 | LOW | parada por incertas com o "tente novamente" do servidor; não tentadas como recusadas com a frase da falha; a incerta perdia código e `supportRef` | **corrigido** (frase própria da parada; linha incerta com código + ref; não tentada diz que não foi tentada) + contador → **D-F171** (= Q-F179 (a)) |
| R7-SOC-03 | LOW | a recarga pedida no meio do lote que responde DEPOIS da recarga final sobrescrevia a lista com a foto velha | **corrigido**: contador de geração — a recarga superada não emite |
| R7-SOC-04 | LOW | textos: cabeçalho do verificador ("token sem kid usa a padrão"), `.env.example` da nfse-api (lista vai em `JWT_PUBLIC_KEYS`), JSDoc do `mapTx` | **corrigido** |
| R7-SOC-05 · R7-ADV-03 | LOW | o ato só olhava a lápide sem a linha da F2a: linha + lápide (SQL à mão) virava | **corrigido**: lê a lápide SEMPRE (falha fechado); linha + lápide = recusa |
| R7-ADV-04 | LOW | aborto pela METADE (lápide + gatilhos): a frase mandava `--retirar-lapide`, que recusa esse estado | **corrigido**: "termine o aborto" |
| F2AR4-ADV-05 | — | o `it.failing` passava VAZIO (a pré-condição foi invertida pela correção da Rodada 4) | **corrigido**: vira `[CORRIGIDO]` afirmando o 503 pela porta |
| Q-F178-ADV-03 | — | `exp` finito gigante aceito (núcleo e setes-api iguais) | **Q-F180** |

#### 22.22.4 Questões dos gates da Rodada 7

- Q-F178 (= Q-F178-SOC-01/ADV-01) e Q-F179 (= Q-F178-SOC-02) — **DECIDIDAS** (Valdo 2026-10-13: "Q-F178 e Q-F179 - siga recomendações" →
  D-F170/D-F171). Q-F178-ADV-02 (o ato com linha + lápide e aborto pela metade) ficou coberta pelas correções R7-SOC-05/R7-ADV-04 sem a
  troca para `name IN (?, ?)` (a leitura original intacta — os 8 testes do ato não mudaram).
- **Q-F180 — teto da validade (`exp`) do token (Q-F178-ADV-03) — AGUARDA o Valdo**: (a) **aceitar sem teto agora** (o setes-api assina com
  24 h; só quem tem a chave privada emite) **e pôr o teto nos DOIS leitores (`exp ≤ agora + 24 h + folga`) na próxima vez que alguém mexer
  neles** — pegaria um bug de `exp` em milissegundos · (b) teto já. *(Rec.: (a).)*

### 22.24 Rodada 8 da F2a/F2b + correções dos gates da Rodada 7 — EXECUTADAS (2026-10-13) — D-F170/D-F171

> Valdo (2026-10-13): "Q-F178 e Q-F179 - siga recomendações". Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.24.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| núcleo | `92811fc` | D-F170 (Space-Saving no `authRejectLog`), R7-ADV-01 (decode protegido), R7-SOC-04 (cabeçalho); testes `rodada8-auth-topkids`, gate adversarial R7 (o FATO do 500 superado), posições do log ajustadas; `dist` reconstruído |
| nfse-api | `267b4b0` | R7-SOC-05/R7-ADV-03/04 (o ato: lápide sempre, linha + lápide, aborto pela metade), R7-SOC-04 (`.env.example`, JSDoc); testes do gate R7 (FATOS superados) e do ato |
| setes-api (worktree `f2a`) | `6dbb5af` | testes: gate adversarial R7; F2AR4-ADV-05 vira `[CORRIGIDO]` |
| app (worktree `f2b`) | `13cdd92` | D-F171 (`notTried`/`notTriedRows`, partes do resumo pt/en), R7-SOC-02 (frase da parada por incertas; incerta com código + `supportRef`; linha da não tentada), R7-SOC-03 (geração no `_reloadList`); testes (nenhum pulado) |

#### 22.24.2 Provas (2026-10-13)

- setes-api `f2a`: suíte **1.831 + as MESMAS 20** (19 boleto + 1 fuso); gates ao vivo (A2…R7) **129/129**; `prove-f2a-abort.ts` ok; nenhum
  banco `f2a_*`/`fiscal_api_adv*` sobrou.
- núcleo **516** (+1 pulado — o FATO do 500, superado) nas duas árvores · nfse-api **735** + 167 pulados (165 ao vivo + 2 FATOS superados)
  nas duas árvores · nfse-api AO VIVO **166** (+2 pulados).
- app **354/354** (nenhum pulado) · core do app **54/54** · `flutter analyze` limpo.

#### 22.24.3 Gates do delta da Rodada 8 (`8704085..92811fc` · `7bf6ea9..267b4b0` · `f5d2be2..6dbb5af` · `e89231e..13cdd92`)

Resultados no §22.24.3-bis (logo abaixo do prompt de retomada §22.25).

#### 22.25 ⏯ PROMPT DE RETOMADA — Q-F180 + gates da Rodada 8 → passeio logado → JANELA (SUPERADO pelo §22.27)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.24 (Rodada 8 EXECUTADA — D-F170/D-F171; gates do delta no §22.24.3), o §22.22
(Rodada 7 + gates — Q-F180 no §22.22.4), o §22.20 (Rodada 6) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA —
D-F153/D-F162; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta 6dbb5af+) · núcleo 92811fc+ ·
nfse-api 267b4b0+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 13cdd92+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo); .ps1 com BOM
  (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.
  Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. Teste que simula o banco pela FORMA da consulta acusa
  qualquer SQL novo — leitura nova entra SEPARADA.

PASSO 1 — com as respostas do Valdo à Q-F180 e às questões dos gates da Rodada 8 (§22.24.3): registrar D-F172+ no §7, executar e rodar os
gates do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo roteiro do §22.13
(cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.26+), INDICE_CENTRAL, CLAUDE.md da raiz,
memória apis-fiscais-isoladas.
```

#### 22.24.3-bis Resultado dos gates do delta da Rodada 8

**Socrático: 0,80 ✅** (4 LOW) · **Adversarial: 0,84 ✅** (3 LOW; achados anteriores seguem fechados — com `ADV_SHOW=1`/`--run-skipped`
0 falhas; ao vivo setes-api 132/132, `prove-f2a-abort` 20/20, nfse-api 176). Resistiram: 26 formas de token que não decodifica (todas 401
no log do 401, nenhum `logger.error`), Space-Saving com 1 milhão de recusas (memória fixa, resumo exato), o ato com a lápide falhando fechado
em todos os estados (a cadeia do aborto interrompido provada AO VIVO), o relatório do lote contra um ORÁCULO em 3.000 lotes aleatórios, o
contador de geração contra respostas fora de ordem.

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| R8-SOC-01 · R8-ADV-01 | LOW | a garantia escrita da D-F170 ("> 1/17", "vence qualquer volume") é falsa: com 16 contadores, só > N/16; 16 kids repetidos ou ~16× o volume escondem o real; a contagem herdada não se distingue da real | **D-F173** (= Q-F181 (a)) — texto corrigido; erro por contador = **Q-F183** |
| R8-SOC-02 · R8-ADV-03 | LOW | a linha incerta sem código nem ref terminava em "()" (o gateway sem envelope — o caso mais comum); "o lote parou" mesmo quando a 3ª incerta era a última nota | **corrigido** (complemento só com conteúdo; "parou" só quando sobrou nota); status HTTP no lugar = **Q-F184** |
| R8-SOC-03 · R8-ADV-02 | LOW | o ENSAIO do ato dizia só "ABORTADA" nos estados "linha + lápide" e "aborto pela metade" (o ato real distingue); a frase mandava rodar o aborto "no setes-api" (só existe na worktree da F2a); sem o privilégio TRIGGER a contagem dá 0 | **corrigido** (o ensaio distingue os três estados; as frases dizem "a partir da WORKTREE da F2a" e avisam do TRIGGER) |
| R8-SOC-04 | LOW | o FAB "Abrir OS" e a rotina mensal não respeitam a trava do loading: abrir uma OS durante o lote (ou com uma recarga lenta) e a lista tirava o operador do detalhe | **D-F174** (= Q-F182 (b)) |

#### 22.24.4 Questões dos gates da Rodada 8

- Q-F180 (= Q-F178-ADV-03), Q-F181 (= Q-F181-SOC-01) e Q-F182 (= Q-F181-SOC-02) — **DECIDIDAS** (Valdo 2026-10-13: "Q-F180 a Q-F182 - siga
  recomendações" → D-F172…D-F174).
- **Q-F183 — a linha dos kids mais frequentes com o MÍNIMO garantido (Q-F181-ADV-01)**: (a) aceitar (D-F173) · (b) **guardar o erro de cada
  contador (o mínimo herdado ao entrar) e imprimir `count − erro` (o mínimo garantido) — 16 números a mais de memória; a linha fica honesta: o
  kid inventado visto uma vez aparece com ~0, o real com a sua contagem** · (c) a (b) + porteiro de admissão para kids vistos uma vez. *(Rec.:
  (b) — barato; (c) não muda a natureza: volume continua vencendo.)*
- **Q-F184 — a linha incerta sem código nem ref (Q-F181-ADV-02)**: (a) sem complemento (FEITO — R8-SOC-02) · (b) **mostrar o status HTTP no lugar
  ("HTTP 503") — diz ao suporte que foi o proxy, sem inventar código; e na rede caída mostrar "sem conexão" no lugar do texto da exceção** ·
  (c) manter (a). *(Rec.: (b).)*

### 22.26 Rodada 9 da F2a/F2b + correções dos gates da Rodada 8 — EXECUTADAS (2026-10-13) — D-F172…D-F174

> Valdo (2026-10-13): "Q-F180 a Q-F182 - siga recomendações". Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.26.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| núcleo | `fe71164` | D-F173 (JSDoc com a garantia real e o limite conhecido); testes do gate R8 (o limite como `it.failing` "[LIMITE CONHECIDO]") |
| nfse-api | `0e1ae9d` | R8-SOC-03/R8-ADV-02 (o ensaio distingue os três estados; frases com a worktree da F2a e o TRIGGER); testes do gate R8 e dos três estados |
| setes-api (worktree `f2a`) | `cf4b22e` | o teste do gate R8 (a cadeia do aborto interrompido ao vivo) |
| app (worktree `f2b`) | `3766f39` | D-F174 (geração ao entrar no detalhe; fim do lote com OS aberta = só o relatório), R8-SOC-02 (`uncertainDetail`; "parou" só com nota restante); FATOS dos gates R6/R8 viram decisões; nenhum teste pulado |

D-F172 = só doc (§7).

#### 22.26.2 Provas (2026-10-13)

- setes-api `f2a`: suíte **1.833 + as MESMAS 20** (19 boleto + 1 fuso); gates ao vivo (A2…R8) **132/132**; `prove-f2a-abort.ts` ok; nenhum
  banco descartável sobrou.
- núcleo **524** (+1 pulado) nas duas árvores · nfse-api **745** + 168 pulados nas duas árvores · nfse-api AO VIVO **175** (+3 FATOS superados).
- app **368/368** (nenhum pulado) · core do app **54/54** · `flutter analyze` limpo.

#### 22.26.3 Gates do delta da Rodada 9 (`92811fc..fe71164` · `267b4b0..0e1ae9d` · `6dbb5af..cf4b22e` · `13cdd92..3766f39`)

Resultados no §22.26.3-bis (logo abaixo do prompt de retomada §22.27).

#### 22.27 ⏯ PROMPT DE RETOMADA — Q-F183/Q-F184 + gates da Rodada 9 → passeio logado → JANELA (SUPERADO pelo §22.29)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.26 (Rodada 9 EXECUTADA — D-F172…D-F174; gates do delta no §22.26.3), o §22.24
(Rodada 8 + gates — Q-F183/Q-F184 no §22.24.4), o §22.22 (Rodada 7) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA —
D-F153/D-F162; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta cf4b22e+) · núcleo fe71164+ ·
nfse-api 0e1ae9d+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 3766f39+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo); .ps1 com BOM
  (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.
  Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. Teste que simula o banco pela FORMA da consulta acusa
  qualquer SQL novo — leitura nova entra SEPARADA.

PASSO 1 — com as respostas do Valdo às Q-F183/Q-F184 e às questões dos gates da Rodada 9 (§22.26.3): registrar D-F175+ no §7, executar e
rodar os gates do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo roteiro do
§22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.28+), INDICE_CENTRAL, CLAUDE.md da
raiz, memória apis-fiscais-isoladas.
```

#### 22.26.3-bis Resultado dos gates do delta da Rodada 9

**Socrático: 0,76 ✅** (6 LOW) · **Adversarial: 0,78 ✅** (4 LOW; achados anteriores seguem fechados — com `ADV_SHOW=1` só os 2 "[LIMITE
CONHECIDO]" do R8; `--run-skipped` nos gates r6–r8 do app 39/39). Resistiram: a D-F174 nos dois lotes (OS aberta pelo FAB no meio, um
relatório só, nenhuma recarga), as corridas no fim do lote, as saídas pelo detalhe, a parada do lote em todas as combinações (o oráculo de
3.000 lotes do R8 segue verde), o ensaio do ato falhando fechado, a garantia do Space-Saving em 1.500 janelas aleatórias.

| Achado | Sev. | O quê | Destino |
|---|---|---|---|
| R9-SOC-01 · R9-ADV-01 | LOW | a falha do 1º bloco do lote (504 do proxy num bloco de 50) recarregava a lista por cima da OS aberta pelo FAB | **corrigido** (a guarda da D-F174 também nesse fim) |
| R9-SOC-02 | LOW | a tela PRESA no spinner: o lote emitia a lista em loading sem limpar o `_detail`; no fim, "OS aberta" impedia a recarga | **corrigido**: a tela que vira lista limpa o `_detail` (`_showListLoading`) |
| R9-SOC-04 · R9-ADV-02 | LOW | o contador só subia no fim da carga do detalhe: (i) a lista em voo aparecia por cima do POST; (ii) o detalhe vencia SEMPRE, até uma troca de aba pedida DEPOIS (detalhe na tela com `_detail` nulo, botões sem `saving`) | **corrigido** (dica do socrático): UM contador da TELA — vale o último pedido; o pedido de detalhe a caminho conta como "no detalhe" para as recargas AUTOMÁTICAS; as operações longas não cancelam o detalhe pedido |
| R9-ADV-03 | LOW | DETALHE VELHO: a carga abandonada de A gravava a voz no meio da carga — cabeçalho de B com a seção "No fisco" de A, o Transmitir de A mandando B | **corrigido**: a voz volta como VALOR (`_fetchFiscal`) e é gravada JUNTO do detalhe, depois da conferência do pedido |
| R9-SOC-05 · R9-ADV-04 | LOW | o ensaio distinguia os três estados mas não com as frases do ato (sem o comando que resolve, sem o `--retirar-lapide`, sem o aviso do TRIGGER); a frase mandava rodar o ensaio "no setes-api" | **corrigido**: `tombstonePhrase` — UMA frase por estado para o ato e o ensaio (cobre a Q-F185-ADV-03 (a)); o D-F110 do ensaio avisa do TRIGGER |
| R9-SOC-06 | LOW | a cerca cruzada do setes-api passava CALADA se a nfse-api irmã sumisse | **corrigido**: falha alto (D-F117) |
| R9-SOC-03 · Q-F185-ADV-01 | LOW | as outras saídas longas (rotina mensal, pendentes do lote fiscal) ainda recarregam por cima da OS aberta; o botão da rotina mensal sem a trava do loading | **Q-F185** |
| (fato) | — | uma OS do lote aberta no detalhe fica com o status de antes no fim do lote (a UI não chega lá hoje; o servidor protege — 409) | **Q-F186** |

#### 22.26.4 Questões dos gates da Rodada 9 — DECIDIDAS (Valdo 2026-10-13: "Q-F183 a Q-F186 - siga recomendações" → D-F175…D-F178, §7; execução no §22.30)

- **Q-F183** e **Q-F184** — §22.24.4 (o mínimo garantido na linha dos kids; o status HTTP na linha incerta).
- **Q-F185 — as outras saídas longas com uma OS aberta no meio (R9-SOC-03/Q-F185-ADV-01)**: (a) **a regra da D-F174 em TODA saída longa
  (rotina mensal, pendentes do lote fiscal) — mostra o desfecho e não recarrega com a tela no detalhe — E o botão da rotina mensal travado pelo
  loading, como os botões de lote (H1)** · (b) só a regra · (c) aceitar. *(Rec.: (a) — a metade do R8-SOC-04 que ficou de fora.)*
- **Q-F186 — o detalhe preservado não é relido no fim do lote (fato do socrático da Rodada 9)**: (a) **aceitar como conhecimento negativo
  (comentário + teste que fixa a semântica)** — hoje a UI não chega lá (durante o lote a lista é spinner e o FAB cria OS NOVA) e o servidor
  protege · (b) reler só quando a OS aberta é do lote e não está em `saving` · (c) reler sempre. *(Rec.: (a) — reler no meio de uma ação
  reabriria os botões em voo.)*
- Q-F185-ADV-02 (geração única) e Q-F185-ADV-03 (uma frase para ato e ensaio) ficaram COBERTAS pelas correções R9-SOC-04 e R9-ADV-04.

### 22.28 Correções dos gates da Rodada 9 — EXECUTADAS (2026-10-13)

> Sem decisão nova (correções que os gates apontaram e a dica arquitetural do socrático). Tudo em commit LOCAL.

| Repo | Commit | O quê |
|---|---|---|
| núcleo | `44e3a5a` | teste do gate R9 (a garantia por par classe:kid; 1.500 janelas) |
| nfse-api | `1779a7a` | `tombstonePhrase` (uma frase por estado — ato e ensaio); o D-F110 do ensaio com o aviso do TRIGGER; teste do gate R9 |
| setes-api (worktree `f2a`) | `f67f459` | a cerca cruzada do gate R8 falha alto sem a nfse-api |
| app (worktree `f2b`) | `09777d3` | `_screenGeneration` (vale o último pedido), `_showListLoading` (limpa o `_detail`; operações longas não cancelam o detalhe pedido), `_pendingDetailScreen`/`_onDetail` (aberto OU a caminho), `_fetchFiscal` (a voz como valor, gravada com o detalhe), a guarda nos três fins de lote; testes dos gates (provas de antes superadas, cerca do fonte nova) |

**Provas (2026-10-13)**: setes-api **1.833 + as MESMAS 20** · gates ao vivo **132/132** · `prove-f2a-abort` ok · núcleo **526** (+1) nas duas
árvores · nfse-api **749** + 169 pulados nas duas árvores · nfse-api ao vivo **179** (+4 FATOS superados) · app **389** (+4 provas
superadas puladas) · core **54** · `flutter analyze` limpo · nenhum banco descartável sobrou. Os gates do delta destas correções
(`fe71164..44e3a5a` · `0e1ae9d..1779a7a` · `cf4b22e..f67f459` · `3766f39..09777d3`) rodam JUNTO com os da próxima rodada (as Q-F183…Q-F186
mexem nos mesmos arquivos).

#### 22.29 ⏯ PROMPT DE RETOMADA — Q-F183…Q-F186 → gates do delta → passeio logado → JANELA (SUPERADO pelo §22.31)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.28 (correções dos gates da Rodada 9), o §22.26 (Rodada 9 + gates — Q-F183…Q-F186
no §22.26.4), o §22.24 (Rodada 8) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA — D-F153/D-F162; reaplicar a trava só do
que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta f67f459+) · núcleo 44e3a5a+ ·
nfse-api 1779a7a+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 09777d3+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo); .ps1 com BOM
  (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai". Decisões de arquitetura são do Valdo.
  Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. Teste que simula o banco pela FORMA da consulta acusa
  qualquer SQL novo — leitura nova entra SEPARADA. No bloc do app: UM contador da tela (vale o último pedido); operações longas não cancelam
  o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe é emitido.

PASSO 1 — com as respostas do Valdo às Q-F183…Q-F186 (§22.26.4): registrar D-F175+ no §7, executar e rodar os gates do delta (cobrindo
também as correções do §22.28). PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo
roteiro do §22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.30+), INDICE_CENTRAL,
CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```

### 22.30 Rodada 10 da F2a/F2b — DECIDIDA e EXECUTADA (2026-10-13) — D-F175…D-F178

> Valdo (2026-10-13): "Q-F183 a Q-F186 - siga recomendações". Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.30.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| núcleo | `4c225f7` | D-F175 (`topErrors` no Space-Saving; a linha com `count − erro`, ordenada por ele); teste `rodada10-auth-guaranteed` (propriedade em 500 janelas: o mínimo nunca passa da contagem real); os testes dos gates R8/R9 que fixavam "nunca subestima" mudam para "nunca superestima"; `dist` reconstruído |
| app (worktree `f2b`) | `3174d54` | D-F176 (`httpStatus`/`network` na linha do lote; "sem conexão" pt/en), D-F177 (`_onDetail` no fim da rotina mensal e das pendentes; o botão da rotina mensal com `state.loading ? null`), D-F178 (comentário + teste: uma carga só do detalhe); os testes dos gates R8/R9 ajustados ao formato decidido |

nfse-api e setes-api sem mudança nesta rodada (pontas 1779a7a e f67f459 — §22.28).

#### 22.30.2 Provas (2026-10-13)

- núcleo **528** (+1 pulado) nas duas árvores · nfse-api **749** + 169 pulados nas duas árvores · nfse-api AO VIVO **179** (+4 FATOS superados; nenhum banco descartável sobrou) · app
  **393** (+4 provas superadas puladas) · core do app **54** · `flutter analyze` limpo. setes-api sem delta nesta rodada (a última suíte:
  1.833 + as MESMAS 20; ao vivo 132/132 — §22.28).

#### 22.30.3 Gates do delta COMBINADO (correções da Rodada 9 + Rodada 10: `fe71164..4c225f7` · `0e1ae9d..1779a7a` · `cf4b22e..f67f459` · `3766f39..3174d54`)

**Socrático 0,74 ✅** (limiar 0,70; nenhum CRITICAL/HIGH/MEDIUM — 5 LOW; as suítes na base) e **adversarial 0,76 ✅** (sem HIGH/CRITICAL —
3 LOW provados no bloc do app + 1 LOW analisado). Os dois gates acharam as MESMAS três coisas no bloc:

| Achado | O quê | Destino |
|---|---|---|
| R10-SOC-01 = R10-ADV-02 | a marca "a caminho" (`_pendingDetailScreen`) morria logo depois do GET da OS e ANTES da voz do fisco — o `_detail` só nasce depois: nessa janela `_onDetail` era falso e o fim da rotina mensal (ou da fotografia das pendentes) recarregava a lista e DESCARTAVA a OS faturada que o operador abriu | corrigido (§22.32) — a dica do socrático: "aberto" e "a caminho" são UM estado |
| R10-SOC-02 = R10-ADV-01 | a trava da rotina mensal e do "Transmitir pendentes" é só o `state.loading` da página: qualquer recarga da lista no spinner (aba, filtro, pesquisa avançada, página recriada) devolve a lista LIVRE e reabre os botões — provado: 2ª rotina e lote de faturamento em paralelo; duas fotografias e dois diálogos. O servidor protege contra cobrança dupla (competência relida com `FOR UPDATE` — D-A29/D-A35) | **Q-F187** |
| R10-SOC-03 = R10-ADV-03 | o ato NO detalhe não conferia a tela: a falha re-emitia o detalhe capturado por cima da lista (voz e efeito nulos — "NFS-e não transmitida" numa nota autorizada; o 2º clique sem `saving`) ou por cima de OUTRA OS (cabeçalho de A com a voz de B — a classe do R9-ADV-03); o sucesso relia com a tela de DEPOIS do ato e, com a lista chegando depois, a tela ficava presa no spinner no fim do lote | corrigido (§22.32) — a regra vigente "vale o último pedido" (R9-SOC-04); é a opção (a) da Q-F187-ADV-04 do adversarial (a (b) — o ato vence a lista da página recriada — só se o Valdo quiser divergir) |
| R10-SOC-04 = Q-F187-ADV-02 | a resposta 2xx que o app não lê (`invalidResponseFailure`) é incerta num ato e leva o texto cru do Dart como "ref" na linha do lote | **Q-F188** (os gates divergem) |
| R10-SOC-05 | a "frase única" do ato e do ensaio valia só nos três estados da lápide: o "sem F2a" e o D-F110 diziam coisas diferentes (o ensaio do D-F110 sem o comando do reaplicar; o do "sem F2a" sem o porquê) | corrigido (§22.32) |
| R10-ADV-04 (analisado) | no app WEB a nfse-api é outra origem (CORS): a página 502/503/504 do proxy da hospedagem sem `Access-Control-Allow-Origin` não chega ao app — vira `NetworkFailure` e a linha diz "(sem conexão)" com a rede BOA; o "HTTP 503" da D-F176 só aparece se o proxy puser CORS na página de erro (ou no Android) | **Q-F189** |

**Resistiram**: D-F175 contra um atacante ADAPTATIVO que vê o estado interno (kids repetidos, empates, tabela cheia antes — com o kid real
acima de 1/m o mínimo garantido é a contagem EXATA em 96 combinações; nenhuma contagem passa da real; a virada da janela e o relógio que volta
zeram o erro; abaixo de 1/16 é o limite já registrado na D-F173); D-F176 na matriz inteira de falhas (502/503/504/408 sem corpo, 500 cru,
INTERNAL com ref, RESOURCE_BUSY, 2xx sem envelope, rede com e sem detalhe, 401/403/422 — nunca "()" nem o texto da exceção da rede);
`tombstonePhrase` IDÊNTICA no ato e no ensaio nos 5 casos (linha + lápide, metade com 4/9/corpos trocados, abortada); as sequências do bloc
(página recuada com OS aberta no meio, marca "a caminho" velha, fim do lote fiscal com o GET do detalhe falhando depois, rotina mensal 403 com
a OS aberta, critério recusado no spinner do lote). Suítes dos gates = a base (setes-api 1.833 + as MESMAS 20, conferidas teste a teste; ao
vivo 132/132 · nfse-api ao vivo 179 + 4) + os testes novos dos gates (`fiscal-api/src/__tests__/adversarial-r10-gate.test.ts`,
`nfse-api/src/__tests__/adversarial-r10-gate.test.ts`, `setes-app-f2b/apps/web/test/adversarial_r10_gate_test.dart`).

#### 22.31 ⏯ PROMPT DE RETOMADA — gates do delta combinado → passeio logado → JANELA (SUPERADO pelo §22.33)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.30 (Rodada 10 EXECUTADA — D-F175…D-F178; gates do delta combinado no §22.30.3),
o §22.28 (correções dos gates da Rodada 9), o §22.26 (Rodada 9) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA —
D-F153/D-F162; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta f67f459+) · núcleo 4c225f7+ ·
nfse-api 1779a7a+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 3174d54+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo; em string CRUA do
  Dart `\n` é literal); .ps1 com BOM (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai".
  Decisões de arquitetura são do Valdo. Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. No bloc do app: UM
  contador da tela (vale o último pedido); operações longas não cancelam o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe
  é emitido; toda saída longa respeita `_onDetail`.

PASSO 1 — se os gates do delta combinado (§22.30.3) deixaram questões: com as respostas do Valdo, registrar D-F179+ no §7, executar e
rodar os gates do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7). PASSO 3 — a JANELA pelo roteiro do
§22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.32+), INDICE_CENTRAL, CLAUDE.md da
raiz, memória apis-fiscais-isoladas.
```

### 22.32 Correções dos gates do delta combinado — EXECUTADAS (2026-10-13)

> Sem decisão nova (as correções que os dois gates apontaram e a regra vigente "vale o último pedido"). Tudo em commit LOCAL; a árvore viva
> do setes-api não foi tocada.

#### 22.32.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| app (worktree `f2b`) | `89997e6` | R10-SOC-01/ADV-02: `_pendingDetailScreen` só morre onde o `_detail` nasce (junto da voz do fisco) ou na falha que volta à lista. R10-SOC-03/ADV-03: `_stillOnDetail(screen)` (a tela capturada pelo ato ainda é o detalhe ABERTO — nenhum pedido de tela depois e o detalhe não saiu por um lote confirmado por cima) + `_beginDetailAct`/`_endDetailAct` em TODO ato no detalhe; a releitura de um ato (`_reloadDetail(…, act: true)`) nem pede a OS se a tela saiu; faturar/cancelar a OS só trocam a aba se a tela ainda é o detalhe; o plano do cancelamento só abre sobre o detalhe que o pediu. Testes: 4 novos em `service_order_batch_bloc_test` + o gate R10 do adversarial (as 3 provas FATO viraram `[CORRIGIDO]`, os 2 ACHADOS rodam sempre; o R10-ADV-01 segue pulado até a Q-F187); o teste do R8 que faturava SEM detalhe aberto (caminho que a tela não tem) passa a abrir a OS antes; a cerca do fonte do R9 lê a conferência nova (`live()`) |
| nfse-api | `56b684d` | R10-SOC-05: `f2aMissingPhrase` e `freezeMissingPhrase` — o ato e o ensaio com o MESMO texto também no "sem F2a" e no D-F110 (o reaplicar `scripts/f2a-reapply-freeze.ts <schema> --vai` a partir da WORKTREE da F2a); o teste do gate R10 + a prova nova da igualdade |
| núcleo | `945ad2d` | só o teste do gate R10 (D-F175 contra o atacante adaptativo) |

setes-api sem mudança (ponta f67f459).

#### 22.32.2 Provas (2026-10-13)

núcleo **531** (+1 pulado) nas duas árvores · nfse-api **752** + 169 pulados nas duas árvores · nfse-api AO VIVO **182 (+4 FATOS superados; `live` + os gates r6–r10)** · app
**413** (+5 pulados: as 4 provas superadas do R9 e o ACHADO do R10-ADV-01, que aguarda a Q-F187; os 2 FATOS dele rodam) · core do app **54** ·
`flutter analyze` limpo · setes-api sem delta (1.833 + as MESMAS 20; ao vivo 132/132 — conferidos pelo gate) · nenhum banco descartável sobrou.

#### 22.32.3 Questões dos gates do delta combinado — DECIDIDAS (Valdo 2026-10-13: "Q-F187 a Q-F189 - siga recomendações" → D-F179…D-F181, §7; execução no §22.34)

- **Q-F187 — a trava da rotina mensal e do "Transmitir pendentes" (R10-SOC-02 = R10-ADV-01)**: hoje é só o `state.loading` da página e
  qualquer recarga da lista no spinner a reabre (provado: 2ª rotina e lote de faturamento em paralelo; duas fotografias e dois diálogos). O
  servidor protege contra cobrança dupla; o custo é contenção, 409 e relatórios duplicados. (a) **a trava H1 completa: flag de reentrância no
  bloc (como `_batchRunning`) + a rotina mensal e a fotografia das pendentes entram no `_batchInFlight` (a lista fica em loading enquanto
  elas rodam — D-F169 estendida)** · (b) só a flag de reentrância · (c) aceitar (o servidor é idempotente). *(Rec.: (a) — é o que o "como os
  botões de lote (H1)" da D-F177 promete; os dois gates recomendam.)*
- **Q-F188 — o "ref" da linha incerta quando a falha é do CLIENTE (R10-SOC-04 = Q-F187-ADV-02)**: a resposta 2xx que o app não lê é incerta
  num ato e a linha do lote leva o texto cru do Dart como "ref" ("ref type 'Null' is not a subtype…"). Os gates DIVERGEM: (a) **na linha do
  lote, "ref" só quando veio do envelope do SERVIDOR; falha do cliente mostra só o código** (socrático) · (b) manter — é o único rastro para o
  suporte (adversarial; F2B-ADV-12) · (c) a regra (a) também na mensagem do ato avulso. *(Rec.: (a) — a linha do lote é resumo para o
  operador e o texto do Dart não é referência que o suporte consulte; o rastro continua na mensagem do ato avulso (F2B-ADV-12 fica): abrir a
  OS e "Consultar" mostra o erro inteiro.)*
- **Q-F189 — a frase da rede no app WEB (R10-ADV-04, analisado)**: com CORS, a página de erro do proxy vira "(sem conexão)" com a rede boa.
  (a) **frase neutra ("sem resposta do serviço — rede, proxy ou tempo") e, no passeio logado, provocar um 502/504 do proxy para ver o que o
  navegador entrega** · (b) pôr CORS nas páginas de erro do proxy da SaveInCloud (Onda 4) · (c) aceitar. *(Rec.: (a) — a frase não pode mandar
  o suporte atrás da internet do cliente; a (b) depende da hospedagem que ainda não existe.)*

#### 22.33 ⏯ PROMPT DE RETOMADA — Q-F187…Q-F189 → gates do delta → passeio logado → JANELA (SUPERADO pelo §22.35)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.32 (correções dos gates do delta combinado — Q-F187…Q-F189 no §22.32.3), o §22.30
(Rodada 10 — D-F175…D-F178; gates no §22.30.3), o §22.28 (correções da R9) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE
SENTINELA — D-F153/D-F162; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta f67f459+) · núcleo 945ad2d+ ·
nfse-api 56b684d+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 89997e6+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo; em string CRUA do
  Dart `\n` é literal); .ps1 com BOM (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai".
  Decisões de arquitetura são do Valdo. Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. No bloc do app: UM
  contador da tela (vale o último pedido); operações longas não cancelam o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe
  é emitido — e a marca "a caminho" morre ALI; toda saída longa respeita `_onDetail`; todo ato no detalhe confere a tela que capturou ao
  começar (`_stillOnDetail`).

PASSO 1 — com as respostas do Valdo às Q-F187…Q-F189 (§22.32.3): registrar D-F179+ no §7, executar e rodar os gates do delta (cobrindo
também as correções do §22.32). PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7) — com a Q-F189 (a), provocar
um 502/504 do proxy. PASSO 3 — a JANELA pelo roteiro do §22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de
cada passo: docs (§22.34+), INDICE_CENTRAL, CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```

### 22.34 Rodada 11 da F2a/F2b — DECIDIDA e EXECUTADA (2026-10-13) — D-F179…D-F181

> Valdo (2026-10-13): "Q-F187 a Q-F189 - siga recomendações". Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.34.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| app (worktree `f2b`) | `5983b29` | D-F179 (`_monthlyRunning`/`_fiscalPendingRunning` — trava de reentrância própria — no `_batchInFlight`; cada uma baixa a marca antes da recarga final; os lotes seguem com as SUAS travas — a 1ª versão cruzava as travas e derrubou o teste dos dois lotes juntos da D-F169, voltou), D-F180 (`clientMade` = código `CLIENT_*` → linha sem "ref"), D-F181 (`fiscalBatchNoResponse` pt/en); o gate R10 com as provas FATO das questões viradas `[DECIDIDO]` — nenhum teste pulado nele |

nfse-api, núcleo e setes-api sem mudança nesta rodada (pontas 56b684d · 945ad2d · f67f459 — §22.32).

#### 22.34.2 Provas (2026-10-13)

app **414** (+4 provas superadas do R9 puladas) · core do app **54** · `flutter analyze` limpo. Núcleo/nfse-api/setes-api sem delta nesta
rodada (§22.32.2: núcleo 531 · nfse-api 752 + 169 · nfse-api ao vivo 182 + 4 · setes-api 1.833 + as MESMAS 20).

#### 22.34.3 Gates do delta (correções do §22.32 + Rodada 11: `3174d54..5983b29` · `1779a7a..56b684d` · `4c225f7..945ad2d`)

**Socrático 0,76 ✅** (nenhum CRITICAL/HIGH/MEDIUM — 6 LOW, dois anteriores ao delta) e **adversarial 0,82 ✅** (sem HIGH/CRITICAL/MEDIUM —
5 LOW, 4 provados + 1 analisado; fuzz de 400 sequências aleatórias do bloc sem spinner/`saving` preso, sem detalhe com a voz de outra OS e
com as travas sempre soltas). As correções do §22.32 e a Rodada 11 fazem o que prometem (toda emissão do detalhe conferida; a marca "a
caminho" só morre com o `_detail`; as travas da D-F179 baixadas no `finally`; a frase do ato e do ensaio igual nos 5 ramos). O que sobra
está na BORDA do "vale o último pedido" — só alcançável com a página RECRIADA no meio de um ato (cruzar 1100 px, girar o tablet; fora isso o
`busy` desabilita o voltar e os botões):

| Achado | O quê | Destino |
|---|---|---|
| R11-SOC-01 = R11-ADV-02 | a MESMA OS reaberta não é relida no fim do ato: "Transmitir" em X, página recriada, X reaberta, o fisco autoriza → o aviso diz "autorizada" e o detalhe segue com a voz de antes (recusada/não transmitida, botão Transmitir ativo); antes do §22.32 esse caso relia (perdeu junto com a correção do "outra OS"). Variante: depois de faturar, a lista recriada continua mostrando a OS em Abertas. O servidor protege (409 + releitura, plano relido) | **Q-F190** |
| R11-SOC-02 = R11-ADV-03 | as travas de duplo clique `_transmitting`/`_invoiceCancelling` são do BLOC inteiro: com o ato da OS A no ar (página recriada), "Transmitir"/"Manter a nota" na OS B somem em silêncio — e o desfecho de A ("NFS-e autorizada — chave KA") aparece sobre B, que nunca foi transmitida | **Q-F190** (o número da OS no desfecho) + **Q-F191** (trava por nota) |
| R11-SOC-03 (anterior ao delta; lido no código) | os diálogos abrem no Navigator raiz e sobrevivem à recriação da página; ao confirmar, o `if (!mounted) return` descarta a decisão sem aviso (motivo do cancelamento, lote, rotina mensal, OS nova) — o bloc está vivo (singleton do módulo, D-F160) | **Q-F192** |
| R11-SOC-04 | a D-F180 reconhecia a falha do app pelo PREFIXO `CLIENT_` (convenção) — `SESSION_NOT_ACCEPTED` é do app sem o prefixo (hoje inócuo: é sistêmica, linha recusada) | corrigido (§22.36) |
| R11-SOC-05 = R11-ADV-04 | a frase neutra só na linha do lote: o ato avulso e a seção "No fisco" dizem "Falha de conexão com o servidor" (`core.errors.network`) com o texto do Dart como ref | **Q-F193** |
| R11-SOC-06 = R11-ADV-01 | o ENSAIO do `--cutover` que falhava DENTRO da transação (transmissão viva, ERP sem SE, já virada, série, pós-condição) engolia os bloqueios D-F50/D-F110 já conferidos — o ato real responderia primeiro por eles (provado: F2a ausente + transmissão viva = o ato diz "F2a", o ensaio só "reconcilie") | corrigido (§22.36) — o socrático: sem decisão; o adversarial: a opção (a) da Q-F190-ADV-01, a recomendada |
| R11-ADV-05 (analisado) | as frases do ato mandam rodar os scripts do setes-api "a partir da WORKTREE da F2a" — depois do merge na janela, as viradas das PRÓXIMAS institutions (alvo 1000) apontariam para uma cópia possivelmente velha | **Q-F194** |

**Resistiram**: D-F179 (a falha, a página recriada e o módulo fechado deixam a lista LIVRE no fim; "voltar" com a rotina no ar devolve a lista
ainda em loading; com o lote fiscal no ar o bloc recusa a fotografia; a falta de trava CRUZADA não é risco real — os quatro pontos de
entrada das operações longas ficam atrás de `state.loading ? null` ou de diálogo modal); D-F180 com toda falha que o app monta
(`invalidResponseFailure`, envelopes estritos, configuração; o ref do SERVIDOR segue — INTERNAL, RESOURCE_BUSY, FISCAL_AUTHORITY_UNAVAILABLE;
nenhum servidor emite `CLIENT_*`); D-F181 nas duas línguas (a chave antiga sumiu); a falha de um ato com a MESMA OS reaberta no meio não
volta por cima nem prende o `saving`; as frases do ato e do ensaio nos ramos testados (1146, permissão, a precedência lápide > "sem F2a" >
D-F110, sem marca de molde vazada). Suítes dos gates = a base (setes-api 1.833 + as MESMAS 20; ao vivo 132/132) + os testes novos
(`nfse-api/src/__tests__/adversarial-f2a-r11-gate.test.ts` — o nome `adversarial-r11-gate` já é da Rodada 11 da D-F61 —,
`setes-app-f2b/apps/web/test/adversarial_r11_gate_test.dart`, com o fuzz).

#### 22.35 ⏯ PROMPT DE RETOMADA — gates do delta → passeio logado → JANELA (SUPERADO pelo §22.37)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.34 (Rodada 11 EXECUTADA — D-F179…D-F181; gates do delta no §22.34.3), o §22.32
(correções dos gates do delta combinado), o §22.30 (Rodada 10) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA —
D-F153/D-F162; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta f67f459+) · núcleo 945ad2d+ ·
nfse-api 56b684d+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 5983b29+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez. A contagem ao vivo da nfse-api é a de
  `NFSE_ADV_LIVE=1 npx jest live adversarial-r6-gate … adversarial-rN-gate --runInBand --forceExit` (`live` sozinho = só os *.live).
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo; em string CRUA do
  Dart `\n` é literal); .ps1 com BOM (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai".
  Decisões de arquitetura são do Valdo. Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. No bloc do app: UM
  contador da tela (vale o último pedido); operações longas não cancelam o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe
  é emitido — e a marca "a caminho" morre ALI; toda saída longa respeita `_onDetail` e fica no `_batchInFlight` com trava própria; todo
  ato no detalhe confere a tela que capturou ao começar (`_stillOnDetail`).

PASSO 1 — se os gates do delta (§22.34.3) deixaram questões: com as respostas do Valdo, registrar D-F182+ no §7, executar e rodar os gates
do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7) — provocar um 502/504 do proxy (D-F181). PASSO 3 — a
JANELA pelo roteiro do §22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.36+),
INDICE_CENTRAL, CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```

### 22.36 Correções dos gates do delta da Rodada 11 — EXECUTADAS (2026-10-13)

> Sem decisão nova. Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.36.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| nfse-api | `74aa6d5` | R11-SOC-06 = R11-ADV-01: o ENSAIO do `--cutover` interrompido por um erro duro DENTRO da transação imprime o relatório com os bloqueios D-F50/D-F110 já conferidos (`{ dryRun, committed: false, bloqueios, interrompidoPor }`) e segue saindo com 1; o teste do gate R11 (`adversarial-f2a-r11-gate`) com o FATO e o ACHADO viraram `[CORRIGIDO]` (comparação pelo relatório JSON — o que o roteiro da janela lê) |
| app (worktree `f2b`) | `da2b749` | R11-SOC-04: `ClientFailureCodes.all` no pacote core (a falha MONTADA pelo app — resposta ilegível, configuração, sessão não aceita) e a linha do lote (D-F180) pela lista, não pelo prefixo; cerca no teste (todo código declarado na classe entra na lista); o gate R11 do adversarial (fuzz de 400 sequências; R11-ADV-02/03 pulados até a Q-F190/Q-F191); comentários do gate R8 com a frase da D-F181 |

núcleo e setes-api sem mudança (pontas 945ad2d · f67f459).

#### 22.36.2 Provas (2026-10-13)

app **424** (+6 pulados: as 4 provas superadas do R9 e os 2 ACHADOS do R11 que aguardam a Q-F190/Q-F191) · core do app **54** · `flutter
analyze` limpo no app e no core · nfse-api **758** + 169 pulados nas duas árvores · nfse-api AO VIVO **188 (+4 FATOS superados; `live` + os gates r6–r10 e f2a-r11)** · núcleo sem delta (531) ·
setes-api sem delta (1.833 + as MESMAS 20; ao vivo 132/132 — conferidos pelos gates) · nenhum banco descartável sobrou.

#### 22.36.3 Questões dos gates do delta da Rodada 11 — DECIDIDAS (Valdo 2026-10-13: "Q-F190 a Q-F194 - siga recomendações" → D-F182…D-F186, §7; execução no §22.38)

> Todas na BORDA do "vale o último pedido": só com a página RECRIADA no meio de um ato (ou um diálogo aberto). O servidor protege em todas
> (nada irreversível acontece) — o risco é o operador LER errado.

- **Q-F190 — o desfecho de um ato cuja tela saiu no meio (R11-SOC-01/02 = R11-ADV-02)**: (a) **a MESMA OS reaberta: o fim do ato relê o
  detalhe com a tela de AGORA (conferida de novo na chegada); outra OS ou a lista: o desfecho leva o NÚMERO da OS ("OS 7374: NFS-e
  autorizada — chave …")** · (b) só o número da OS no desfecho · (c) aceitar como limite conhecido. *(Rec.: (a) — o operador não pode ler o
  desfecho de X como se fosse de Y, nem ver "autorizada" sobre a voz "recusada" da mesma nota; a lista desatualizada depois de faturar se
  corrige ao abrir a OS e fica de fora.)*
- **Q-F191 — as travas de duplo clique são do bloc inteiro (R11-SOC-02 = R11-ADV-03)**: com o ato da OS A no ar, o clique em
  "Transmitir"/"Manter a nota" na OS B some em silêncio. (a) **trava POR NOTA (`Set<int>` de OS em voo) — o clique da outra OS vai; quem
  protege a nota é a trava DELA na nfse-api/ERP** · (b) aviso "a OS N ainda está no fisco" · (c) aceitar. *(Rec.: (a) — a trava do bloc é só
  contra o duplo clique na MESMA nota.)*
- **Q-F192 — a decisão confirmada num diálogo que sobreviveu à recriação da página (R11-SOC-03, anterior ao delta)**: hoje o `if (!mounted)
  return` da página recriada descarta a decisão sem aviso (motivo do cancelamento, lote, rotina mensal, OS nova). (a) **despachar ao bloc
  se ELE está vivo (`isClosed`), não pelo `mounted` da página** · (b) avisar e pedir a confirmação de novo · (c) aceitar. *(Rec.: (a) — o
  bloc é o singleton do módulo (D-F160) e o servidor relê o plano (D-F149): despachar é seguro.)*
- **Q-F193 — a frase neutra também nos atos fiscais e na seção "No fisco" (R11-SOC-05 = R11-ADV-04)**: (a) **só nas chamadas à nfse-api — o
  aviso dos atos fiscais e a falha da voz na seção** · (b) mudar `core.errors.network` no app inteiro · (c) aceitar. *(Rec.: (a), e decidir
  a (b) depois de provocar o 502/504 do proxy no passeio logado (D-F181) — também no ato avulso.)*
- **Q-F194 — "a partir da WORKTREE da F2a" nas frases do ato (R11-ADV-05, analisado)**: (a) **texto neutro: "a partir da árvore do
  setes-api com a F2a (a worktree até a janela; a árvore principal depois)" — nas frases da lápide e do D-F110** · (b) manter e reescrever
  na 2ª virada. *(Rec.: (a) — barato, e a frase vale para as ~1000 viradas seguintes.)*

#### 22.37 ⏯ PROMPT DE RETOMADA — Q-F190…Q-F194 → gates do delta → passeio logado → JANELA (SUPERADO pelo §22.39)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.36 (correções dos gates do delta da Rodada 11 — Q-F190…Q-F194 no §22.36.3), o
§22.34 (Rodada 11 — D-F179…D-F181; gates no §22.34.3), o §22.32 (correções do delta combinado) e o roteiro da JANELA no §22.13 (aborto com
a LÁPIDE SENTINELA — D-F153/D-F162; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta f67f459+) · núcleo 945ad2d+ ·
nfse-api 74aa6d5+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, da2b749+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez. A contagem ao vivo da nfse-api é a de
  `NFSE_ADV_LIVE=1 npx jest live adversarial-r6-gate … adversarial-r10-gate adversarial-f2a-r11-gate --runInBand --forceExit`.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo; em string CRUA do
  Dart `\n` é literal); .ps1 com BOM (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai".
  Decisões de arquitetura são do Valdo. Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. No bloc do app: UM
  contador da tela (vale o último pedido); operações longas não cancelam o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe
  é emitido — e a marca "a caminho" morre ALI; toda saída longa respeita `_onDetail` e fica no `_batchInFlight` com trava própria; todo
  ato no detalhe confere a tela que capturou ao começar (`_stillOnDetail`). A falha montada pelo app = `ClientFailureCodes.all`.

PASSO 1 — com as respostas do Valdo às Q-F190…Q-F194 (§22.36.3): registrar D-F182+ no §7, executar e rodar os gates do delta (cobrindo
também as correções do §22.36). PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7) — provocar um 502/504 do proxy
na linha do lote E no ato avulso (D-F181). PASSO 3 — a JANELA pelo roteiro do §22.13 (cada passo irreversível com o "vai"), antes de 30/11
(D-IB15). Ao fim de cada passo: docs (§22.38+), INDICE_CENTRAL, CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```

### 22.38 Rodada 12 da F2a/F2b — DECIDIDA e EXECUTADA (2026-10-13) — D-F182…D-F186

> Valdo (2026-10-13): "Q-F190 a Q-F194 - siga recomendações". Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.38.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| app (worktree `f2b`) | `495267b` | D-F182 (`_rereadAfterAct`: relê se a tela ainda é a do ato OU a MESMA OS reaberta — pela tela de agora, `act: true` confere de novo na chegada; `_outcomeOrder`: o `orderId` nos one-shots `ActionSuccess`/`ActionFailure`/`FiscalNotice`/`FiscalWarnings` quando a tela é outra OS ou a lista; a página prefixa "OS N: " — `about` na ponte `showSuccessFeedback`/`showFailureFeedback`; a OS cancelada reaberta volta à lista; o faturamento da MESMA OS reaberta relê o detalhe), D-F183 (`_transmitting`/`_invoiceCancelling` viraram `Set<int>`), D-F184 (`_dispatch` — `if (!_bloc.isClosed)` — nos diálogos que despacham e nos callbacks do detalhe; `mounted` só entre dois diálogos encadeados e onde a página usa o próprio estado/contexto), D-F185 (`ServiceOrderNfseRepositoryImpl._guard`: `on NetworkFailure` → a mesma `NetworkFailure` com `forms.serviceOrder.fiscalNoResponse`); testes: gate R11 (provas FATO → `[DECIDIDO]`, ACHADOS R11-ADV-02/03 rodando, a prova do repositório e a do duplo clique na MESMA nota), cerca do R5 pela regra da D-F184 |
| nfse-api | `c967dcf` | D-F186 (`F2A_TREE` — UMA constante com o texto neutro no tempo, nas frases da lápide e do D-F110); os testes que citavam "WORKTREE da F2a" (f1r10, gate R10, gate f2a-r11 — o FATO do R11-ADV-05 virou `[DECIDIDO D-F186]`); a cerca de fonte do gate R8 manteve a forma da linha do comando |

núcleo e setes-api sem mudança (pontas 945ad2d · f67f459).

#### 22.38.2 Provas (2026-10-13)

app **428** (+4 provas superadas do R9 puladas) · `flutter analyze` limpo · nfse-api **758** + 169 pulados nas duas árvores · nfse-api AO VIVO
**188 (+4 FATOS superados)** · nenhum banco descartável sobrou. Núcleo e setes-api sem delta (núcleo 531 · setes-api 1.833 + as MESMAS 20; ao vivo 132/132).

#### 22.38.3 Gates do delta (correções do §22.36 + Rodada 12: `5983b29..495267b` · `56b684d..c967dcf`)

**Socrático 0,72 ✅** (1 MEDIUM + 7 LOW) e **adversarial 0,72 ✅** (1 MEDIUM + 5 LOW, sem HIGH/CRITICAL). O MEDIUM é o MESMO nos dois
(R12-SOC-01 = R12-ADV-06): o prefixo "OS N:" da D-F182 usava o `orderId` (o id INTERNO) e não o número que a tela mostra (`number ?? id`)
— no dev as 344 OS têm número ≠ id (a OS "7374" da NFS-e 704 tem id 8011); quando os números alcançarem a faixa dos ids, "OS N:" seria lido
como o desfecho de OUTRA OS. Os LOW: a OS reaberta ainda A CAMINHO ficava sem releitura e com prefixo (R12-SOC-02 = R12-ADV-02); a releitura
de um ato antigo tirava o `saving` de outro ato na mesma OS e duas releituras chegavam fora de ordem (R12-SOC-03 = R12-ADV-01); a frase
neutra não chegou à aba "Emissor fiscal" (R12-SOC-04 = R12-ADV-03); a cerca de `ClientFailureCodes.all` não via a classe inteira
(R12-SOC-05 = R12-ADV-04); descartes silenciosos que sobraram — o "sim" do 1º diálogo encadeado, o plano da MESMA OS reaberta, a pesquisa
avançada pelo `mounted`, o documento de outra OS sem identificação (R12-SOC-06 + Q-F195-ADV-01); o ensaio interrompido com a mesma cara do
esperado no passo 3 (R12-SOC-07); o "de onde rodar" da lápide e o aborto depois da 1ª janela (R12-SOC-08 = R12-ADV-05). **Resistiram**: D-F182
no fuzz de 300 sementes (887 desfechos na própria OS, 382 fora — zero número errado), D-F183 (dois atos em OS diferentes fora de ordem; o 2º
clique na mesma nota ignorado), D-F184 (decisões depois da página recriada sem evento errado nem duplicado), D-F185 com os repositórios reais,
o ensaio interrompido (um relatório só, exit 1) e a D-F186 letra a letra. Questões Q-F195 (5 do socrático + 3 do adversarial) — DECIDIDAS
(Valdo 2026-10-13: "Q-F195 - siga recomendações" → D-F187…D-F191, §7; execução no §22.40; a Q-F195-ADV-02 ficou coberta pela D-F190 e a
Q-F195-ADV-03 é a D-F187).

#### 22.39 ⏯ PROMPT DE RETOMADA — gates do delta → passeio logado → JANELA (SUPERADO pelo §22.41)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.38 (Rodada 12 EXECUTADA — D-F182…D-F186; gates do delta no §22.38.3), o §22.36
(correções dos gates da Rodada 11), o §22.34 (Rodada 11) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA — D-F153/D-F162;
reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta f67f459+) · núcleo 945ad2d+ ·
nfse-api c967dcf+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 495267b+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez. A contagem ao vivo da nfse-api é a de
  `NFSE_ADV_LIVE=1 npx jest live adversarial-r6-gate … adversarial-r10-gate adversarial-f2a-r11-gate --runInBand --forceExit`.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo; em string CRUA do
  Dart `\n` é literal); .ps1 com BOM (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai".
  Decisões de arquitetura são do Valdo. Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. No bloc do app: UM
  contador da tela (vale o último pedido); operações longas não cancelam o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe
  é emitido — e a marca "a caminho" morre ALI; toda saída longa respeita `_onDetail` e fica no `_batchInFlight` com trava própria; todo
  ato no detalhe confere a tela que capturou (`_stillOnDetail`), relê pela peça `_rereadAfterAct` e marca o desfecho fora da OS com
  `_outcomeOrder`; trava de duplo clique POR NOTA; a página despacha decisão de diálogo por `_dispatch` (bloc vivo). A falha montada pelo
  app = `ClientFailureCodes.all`.

PASSO 1 — se os gates do delta (§22.38.3) deixaram questões: com as respostas do Valdo, registrar D-F187+ no §7, executar e rodar os gates
do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7) — provocar um 502/504 do proxy na linha do lote E no
ato avulso (D-F181/D-F185; decide se `core.errors.network` muda no app inteiro). PASSO 3 — a JANELA pelo roteiro do §22.13 (cada passo
irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.40+), INDICE_CENTRAL, CLAUDE.md da raiz, memória
apis-fiscais-isoladas.
```

### 22.40 Rodada 13 da F2a/F2b — DECIDIDA e EXECUTADA (2026-10-13) — D-F187…D-F191

> Valdo (2026-10-13): "Q-F195 - siga recomendações". Tudo em commit LOCAL; a árvore viva do setes-api não foi tocada.

#### 22.40.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| app (worktree `f2b`) | `9a5d2a8` | D-F187 (`_shownNumbers` — o `number ?? id` da lista e do detalhe; `orderNumber` nos one-shots no lugar do id; `numbers` no relatório do lote de faturamento; o lote FISCAL pelo nº da NOTA da pendente — "Nota {}"), D-F189 (o motivo do cancelamento no fisco pelo Navigator RAIZ; o plano da MESMA OS reaberta abre; a pesquisa avançada por `_dispatch`; XML/DANFSe de outra OS: "OS N: documento aberto em nova aba"/indisponível), D-F191 (`_pendingDetailOrder` + `_showsOrder`; a releitura do fim do ato é um PEDIDO NOVO de detalhe da OS — o em voo perde a vez, o que fecha também as releituras fora de ordem; o `saving` de outro ato = limite conhecido, fixado em teste); testes: o gate R12 do adversarial (fuzz com o oráculo da D-F191; FATOs → `[CORRIGIDO]`/`[DECIDIDO]`; o R12-ADV-03 pulado pela D-F188), D-F187 no batch bloc, a cerca de `ClientFailureCodes.all` pela classe inteira |
| nfse-api | `61d0bbe` | D-F190 (`F2A_WORKTREE` nas frases da LÁPIDE — o aborto só existe antes da 1ª janela; o D-F110 segue com `F2A_TREE`); o gate R12 do adversarial (FATO/ACHADO do R12-ADV-05 → `[DECIDIDO D-F190]`; o RESISTIU da D-F186 revisto) e os testes que citavam a frase |
| setes-api (worktree `f2a`) | `0db9310` | D-F190 (o `abortF2aPassivo` RECUSA quando QUALQUER institution da instalação já virou — `cutover_at` no `fiscal_api`; o `--retirar-lapide` não tem a guarda); teste `f2a-rodada13` |

Junto (doc): o critério de sucesso do ensaio no passo 3 da janela (R12-SOC-07 — exit 0 com `cutover`; exit 1 com `interrompidoPor` = não
passou) e a nota da D-F190 no roteiro do aborto (§22.13). D-F188 (a frase neutra na aba "Emissor fiscal") fica para depois do passeio.

#### 22.40.2 Provas (2026-10-13)

app **444** (+5 pulados: as 4 provas superadas do R9 e o R12-ADV-03 da D-F188 — 442 antes dos 2 testes dirigidos da D-F187) · `flutter analyze` limpo · nfse-api **765** (+169) na árvore F2a · **763** (+171 — os testes do aborto pulam onde o script não existe) na árvore principal (1 falha que NÃO se repetiu ao rodar sozinha — carga em paralelo com a suíte do setes-api) · nfse-api AO VIVO **195 (+4 FATOS superados)** · setes-api **1.836 + as MESMAS 20** · setes-api AO VIVO **132/132** · `prove-f2a-abort` **ok** · nenhum banco
descartável sobrou.

#### 22.40.3 Gates do delta (Rodada 13: `495267b..9a5d2a8` · `c967dcf..61d0bbe` · `f67f459..0db9310`)

**Socrático 0,79 ✅** (1 MEDIUM + 5 LOW) e **adversarial 0,80 ✅** (3 LOW, sem MEDIUM/HIGH/CRITICAL). Os dois acharam as mesmas três coisas:

| Achado | O quê | Destino |
|---|---|---|
| R13-SOC-01 (MEDIUM) = R13-ADV-03 | a guarda da D-F190 conta QUALQUER `cutover_at` do `fiscal_api` — e toda habilitação que NASCE pela nfse-api já nasce virada (D-F39): uma SE de uma institution nova/de teste criada pela nfse-api no `fiscal_api` de produção antes da janela faz o aborto recusar com uma frase FALSA ("a F2a está na árvore principal desde a 1ª janela") — no pior momento (entre os passos 4 e 5). Hoje não acontece (uma linha só, a SE réplica da Setes); provado ao vivo com a peça real do núcleo | **D-F192** (o roteiro protege; zero código) |
| R13-SOC-02 = R13-ADV-01 | a releitura do fim do ato (agora um pedido "a caminho" — D-F191) ressuscitava o detalhe por cima de um lote confirmado DEPOIS de ela começar (perdeu o `act: true` da R12 — regressão parcial do R10-SOC-03) | **D-F193** |
| R13-SOC-04 = R13-ADV-02 | o plano do cancelamento da MESMA OS reaberta ainda A CAMINHO era descartado em silêncio (`_detail?.id` em vez do `_showsOrder` da D-F191) | **D-F194** |
| R13-SOC-03 | o 2º diálogo da cadeia abria com o MÓDULO fora (bloc fechado) e o motivo era descartado — a guarda era `root.mounted`, não o bloc vivo | corrigido (`_bloc.isClosed` na cadeia — a regra da D-F184) |
| R13-SOC-05 | fallbacks da D-F187 caem no id (hoje inalcançáveis: número da OS NOT NULL/único; 150 notas sem número, nenhuma nas pendentes); o fuzz da R12 sem número ≠ id | o fuzz do gate R13 já usa número ≠ id (250 sementes, zero número errado) |
| R13-SOC-06 | numa instalação com várias institutions, o 1º `--vai` fecha o aborto de TODAS | nota no roteiro (§22.13) |

**Resistiram**: D-F187 (fuzz com o número de cada OS = o id de OUTRA — 953 desfechos na própria OS e 377 fora, zero número errado; 62
relatórios de faturamento e 175 fiscais certos); D-F191 (o FAB não marca OS até o POST; o POST que falha apaga a marca; uma releitura por ato,
sem laço; o detalhe do OPERADOR a caminho vence o lote); D-F189 (widget: o contexto do Navigator raiz segue montado com a página desmontada e
o 2º diálogo devolve o motivo; XML/DANFSe de outra OS com "OS N:"); D-F190 (falha fechado; a ordem das recusas; a linha virada
soft-deletada conta; frases pt/en coerentes). Questões Q-F196 (3 do socrático = 3 do adversarial) — DECIDIDAS (Valdo 2026-10-13: "Q-F196 -
siga recomendações" → D-F192…D-F194, §7; execução no §22.42).

#### 22.41 ⏯ PROMPT DE RETOMADA — gates do delta → passeio logado → JANELA (SUPERADO pelo §22.43)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.40 (Rodada 13 EXECUTADA — D-F187…D-F191; gates do delta no §22.40.3), o §22.38
(Rodada 12 + gates no §22.38.3) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA — D-F153/D-F162, só ANTES da 1ª janela —
D-F190; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7; o critério do ensaio no passo 3); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta 0db9310+) · núcleo 945ad2d+ ·
nfse-api 61d0bbe+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 9a5d2a8+) · Infra-IA (main).

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. Testes ao vivo só em bancos descartáveis
  (f2a_*, fiscal_api_adv_*), apagados no fim — e um de cada vez. Contagem ao vivo da nfse-api:
  `NFSE_ADV_LIVE=1 npx jest live adversarial-r6-gate … adversarial-r10-gate adversarial-f2a-r11-gate adversarial-f2a-r12-gate --runInBand --forceExit`;
  do setes-api: `F2A_ADV_LIVE=1 NFSE_API_DIR=D:/Gestao2027/nfse-api npx jest adversarial-f2a --runInBand --forceExit` + `scripts/prove-f2a-abort.ts`.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo; em string CRUA do
  Dart `\n` é literal); .ps1 com BOM (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai".
  Decisões de arquitetura são do Valdo. Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. No bloc do app: UM
  contador da tela (vale o último pedido); operações longas não cancelam o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe
  é emitido — e a marca "a caminho" (que carrega a OS) morre ALI; toda saída longa respeita `_onDetail` e fica no `_batchInFlight` com
  trava própria; todo ato no detalhe confere a tela que capturou (`_stillOnDetail`), relê por um PEDIDO NOVO de detalhe da OS
  (`_rereadAfterAct` — só se a tela mostra, ou vai mostrar, a OS) e marca o desfecho fora da OS com o NÚMERO que a tela mostra
  (`_outcomeOrder`/`_shownNumbers`); trava de duplo clique POR NOTA; a página despacha decisão de diálogo por `_dispatch` (bloc vivo) e
  abre o 2º diálogo de uma cadeia pelo Navigator raiz. A falha montada pelo app = `ClientFailureCodes.all`.

PASSO 1 — se os gates do delta (§22.40.3) deixaram questões: com as respostas do Valdo, registrar D-F192+ no §7, executar e rodar os gates
do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7) — provocar um 502/504 do proxy na linha do lote E no
ato avulso (D-F181/D-F185) e decidir o `core.errors.network` do app inteiro JUNTO com a aba "Emissor fiscal" (D-F188). PASSO 3 — a JANELA
pelo roteiro do §22.13 (cada passo irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.42+), INDICE_CENTRAL,
CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```

### 22.42 Rodada 14 da F2a/F2b — DECIDIDA e EXECUTADA (2026-10-13) — D-F192…D-F194

> Valdo (2026-10-13): "Q-F196 - siga recomendações" — e AUTORIZAÇÃO EM PÉ para as seguintes ("Q-F197 … Q-F201 - siga recomendações"):
> as questões dos gates desta frente seguem a recomendação, salvo passo irreversível (janela, `--cutover --vai`, aborto `--vai` fora de
> descartável, push), algo fora da F2a/F2b, gates divergentes sem recomendação que resolva, ou achado HIGH/CRITICAL. Tudo em commit LOCAL; a
> árvore viva do setes-api não foi tocada.

#### 22.42.1 O que foi executado

| Repo | Commit | O quê |
|---|---|---|
| app (worktree `f2b`) | `822fdf9` | D-F193 (`_rereadAfterAct`: a OS ABERTA relê como ATO — `act: true`, morre com o lote por cima; só a OS A CAMINHO segue como pedido "a caminho"), D-F194 (o plano abre com `_showsOrder`), R13-SOC-03 (a cadeia de dois diálogos guardada pelo bloc vivo); o gate R13 do adversarial (FATOs → `[CORRIGIDO]`, ACHADOS rodando; o widget do Navigator raiz; o fuzz com número ≠ id); o oráculo do fuzz R12 pela D-F194 |
| setes-api (worktree `f2a`) | `8556491` | o gate R13 do adversarial (`adversarial-f2a-r13-gate` — os FATOs do R13-ADV-03 fixam o limite da D-F192, com a nota da decisão) |
| Infra-IA (§22.13) | — | D-F192 no passo 3 (o ensaio do aborto sem recusa; nenhuma SE nativa no `fiscal_api` de produção até a 1ª janela) + R13-SOC-06 (todos os ensaios e abortos antes do 1º `--vai`) |

núcleo e nfse-api sem mudança (pontas 945ad2d · 61d0bbe).

#### 22.42.2 Provas (2026-10-13)

app **453** (+5 pulados: as 4 provas superadas do R9 e o R12-ADV-03 da D-F188) · `flutter analyze` limpo · setes-api **1.842 + as MESMAS 20** · setes-api AO
VIVO **139/139** · `prove-f2a-abort` **ok** · nfse-api e núcleo sem delta (765 + 169 · 531 + 1; nfse ao vivo 195 + 4 — conferidos pelo gate) ·
nenhum banco descartável sobrou.

#### 22.42.3 Gates do delta (Rodada 14: `9a5d2a8..822fdf9` · `0db9310..8556491`)

**Socrático 0,80 ✅** (4 LOW + 2 INFO) e **adversarial 0,84 ✅** (2 LOW). Fechados: R13-ADV-01/02 (D-F193/D-F194 — fuzz estrito sem detalhe
ressuscitado em 300 sementes; o plano abriu as 186 vezes em que era a OS dele e nunca nas 56 em que não era), R13-SOC-03, R13-ADV-03 (a
pré-condição vale hoje). Novos: o roteiro da D-F192 detecta mas não remedeia (R14-SOC-01 → **D-F195**); o relatório esperado do ensaio do
aborto e o `FISCAL_DB_NAME` (R14-SOC-02 → roteiro); o fuzz só imprimia os contadores da D-F193/D-F194 (R14-SOC-03 → cerca); o plano fora
da OS some sem aviso (R14-SOC-04 → **D-F196**); `_beginDetailAct`/`_outcomeOrder` sem conferir a OS do ato (R14-SOC-05, latente →
endurecido); o número interno no diálogo do plano com nota sem número (R14-SOC-06, INFO, inalcançável — 253/253 notas de OS com número); o
ato nascido com a OS a caminho sem `saving` (R14-ADV-01 → **D-F197**); one-shots iguais seguidos (R14-ADV-02 → **D-F198**). Questões
Q-F197 — seguidas pela AUTORIZAÇÃO EM PÉ (execução no §22.44).

#### 22.43 ⏯ PROMPT DE RETOMADA — gates do delta → passeio logado → JANELA (SUPERADO pelo §22.45)

```
Retome a F2a/F2b (setes-api PASSIVO + setes-app cliente da nfse-api) do Gestão 2027. Leia D:\Gestao2027\CLAUDE.md e, no
Infra-IA/prompts/prompt_apis_fiscais_isoladas.md, o §22.42 (Rodada 14 EXECUTADA — D-F192…D-F194; gates do delta no §22.42.3), o §22.40
(Rodada 13 + gates no §22.40.3) e o roteiro da JANELA no §22.13 (aborto com a LÁPIDE SENTINELA só ANTES da 1ª janela — D-F190 — com o
ENSAIO dele no passo 3 — D-F192; reaplicar a trava só do que falta — D-F152; rotação do JWT_KID em PADROES §7; o critério do ensaio do ato
no passo 3); §7 quando precisar.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, ponta 8556491+) · núcleo 945ad2d+ ·
nfse-api 61d0bbe+ · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 822fdf9+) · Infra-IA (main).
AUTORIZAÇÃO EM PÉ (Valdo 2026-10-13): as questões dos gates desta frente seguem a RECOMENDAÇÃO sem esperar — salvo passo irreversível
(janela, --cutover --vai, aborto --vai fora de descartável, push), algo fora da F2a/F2b, gates divergentes sem saída ou achado HIGH/CRITICAL.

REGRAS DURAS
- D:\Gestao2027\setes-api roda em tsx watch e É a produção da Setes (salvar = deploy; o boot aplica migrations). A F2a SÓ entra na JANELA,
  junto da F2b. Nunca npm run dev / flutter run nas worktrees (o .env aponta para o MySQL de produção). Nunca migrate:setes --cutover … --vai
  fora da janela; os --vai dos scripts de aborto/reaplicar só em banco descartável fora da janela. NUNCA criar habilitação SE pela nfse-api no
  fiscal_api de produção antes da 1ª janela (D-F192). Testes ao vivo só em bancos descartáveis (f2a_*, fiscal_api_adv_*), apagados no fim — e
  um de cada vez. Contagem ao vivo da nfse-api:
  `NFSE_ADV_LIVE=1 npx jest live adversarial-r6-gate … adversarial-r10-gate adversarial-f2a-r11-gate adversarial-f2a-r12-gate --runInBand --forceExit`;
  do setes-api: `F2A_ADV_LIVE=1 NFSE_API_DIR=D:/Gestao2027/nfse-api npx jest adversarial-f2a --runInBand --forceExit` + `scripts/prove-f2a-abort.ts`.
- Suíte do setes-api SEM editar arquivos durante a execução; base = 20 falhas pré-existentes (19 boleto + 1 cerca de fuso). Cercas do
  núcleo/nfse-api com SETES_API_DIR nas DUAS árvores. Núcleo: `npm run build` depois de mexer (a nfse-api consome o dist) — nunca com uma
  suíte ao vivo da nfse-api rodando. Jest no Windows: `--json --outputFile` ou `--runInBand --forceExit`; suítes em PARALELO podem falhar
  por carga — repetir sozinha antes de concluir.
- Edição em UTF-8 pela ferramenta de edição (heredoc/`node -e` com barras invertidas e crases FALHAM — script em arquivo; em string CRUA do
  Dart `\n` é literal); .ps1 com BOM (PS 5.1); commit só dos caminhos da frente, mensagem em arquivo (git commit -F); push só com o "vai".
  Nunca mexer em código enquanto um agente de gate roda testes nas mesmas árvores. No bloc do app: UM contador da tela (vale o último
  pedido); operações longas não cancelam o detalhe pedido; o `_detail` e a voz nascem juntos onde o detalhe é emitido — e a marca "a
  caminho" (que carrega a OS) morre ALI; toda saída longa respeita `_onDetail` e fica no `_batchInFlight` com trava própria; todo ato no
  detalhe confere a tela que capturou (`_stillOnDetail`), relê pelo `_rereadAfterAct` (a OS ABERTA como ato — morre com o lote por cima;
  a OS A CAMINHO como pedido do operador) e marca o desfecho fora da OS com o NÚMERO que a tela mostra; trava de duplo clique POR NOTA; a
  página despacha decisão de diálogo por `_dispatch` (bloc vivo) e abre o 2º diálogo de uma cadeia pelo Navigator raiz, se o bloc está vivo.
  O fuzz dos gates precisa do oráculo da decisão vigente. A falha montada pelo app = `ClientFailureCodes.all`.

PASSO 1 — com os gates do delta da Rodada 14 (§22.42.3): se deixaram questões, seguir a RECOMENDAÇÃO (autorização em pé), registrar
D-F195+ no §7, executar e rodar os gates do delta. PASSO 2 — passeio logado da F2b no ambiente decidido (ou na janela, passo 7) — provocar um
502/504 do proxy na linha do lote E no ato avulso (D-F181/D-F185) e decidir o `core.errors.network` do app inteiro JUNTO com a aba "Emissor
fiscal" (D-F188); o passeio NÃO cria habilitação no fiscal_api de produção (D-F192). PASSO 3 — a JANELA pelo roteiro do §22.13 (cada passo
irreversível com o "vai"), antes de 30/11 (D-IB15). Ao fim de cada passo: docs (§22.44+), INDICE_CENTRAL, CLAUDE.md da raiz, memória
apis-fiscais-isoladas.
```

### 22.44 Rodada 15 da F2a/F2b — EXECUTADA (2026-10-13) — D-F195…D-F198 (autorização em pé)

| Repo | Commit | O quê |
|---|---|---|
| app (worktree `f2b`) | `95d829d` | R14-SOC-05 (`_beginDetailAct(emit, orderId)` só marca o detalhe DA OS do ato; `_outcomeOrder` pelo `_showsOrder`); D-F196/D-F197/D-F198 (comentários de conhecimento negativo; o ACHADO R14-ADV-01 pulado com o motivo); R14-SOC-03 (o fuzz R13 confere `resurrectedOverLongOp`/`planDroppedOnTheWay` == 0); o gate R14 do adversarial (fuzz de 300 sementes com o modelo do último pedido de tela) |
| Infra-IA (§7, §22.13) | — | D-F195…D-F198; no passo 3 da janela: o relatório esperado do ensaio do aborto, o D-F50 esperado ("sem F2a"), o `FISCAL_DB_NAME` e o procedimento da D-F195 |

núcleo, nfse-api e setes-api sem mudança (945ad2d · 61d0bbe · 8556491). **Provas**: app **463** (+6 pulados: as 4 provas superadas do R9,
o R12-ADV-03 da D-F188 e o R14-ADV-01 da D-F197) · `flutter analyze` limpo · setes-api 1.842 + as MESMAS 20 · ao vivo 139/139 ·
`prove-f2a-abort` ok · núcleo 531 + 1 · nfse-api 765 + 169 · nfse ao vivo 195 + 4 (conferidos pelos gates da R14) · nenhum banco
descartável sobrou.

#### 22.44.1 Gates do delta (Rodada 15: `822fdf9..95d829d`)

FEITOS em 2026-10-13 (4ª sessão) — resultado e execução no §22.46.

#### 22.45 ⏯ PROMPT DE RETOMADA CURTO (colar numa sessão nova)

```
Retome a F2a/F2b do Gestão 2027 pelo §22.45 do Infra-IA/prompts/prompt_apis_fiscais_isoladas.md (leia D:\Gestao2027\CLAUDE.md, o §22.44 e
o §22.13 — roteiro da JANELA; §7 = D-F1…D-F198). Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a
(branch f2a, 8556491) · núcleo 945ad2d · nfse-api 61d0bbe · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 95d829d).
AUTORIZAÇÃO EM PÉ: as questões dos gates seguem a RECOMENDAÇÃO sem esperar — salvo passo irreversível (janela, --cutover --vai, aborto --vai
fora de descartável, push, apagar linha do fiscal_api), algo fora da F2a/F2b, gates divergentes sem saída ou achado HIGH/CRITICAL.
REGRAS: D:\Gestao2027\setes-api (árvore viva) É a produção (tsx watch) — só leitura; nunca npm run dev/flutter run nas worktrees; nunca
criar habilitação no fiscal_api de produção (D-F192/D-F195); ao vivo só em bancos descartáveis, um de cada vez; nunca mexer em código com um
gate rodando nas mesmas árvores; edição por ferramenta/script em arquivo (UTF-8); commit só dos caminhos da frente com git commit -F.
PASSO 1 — gates do delta da Rodada 15 (`822fdf9..95d829d` no app; socrático + adversarial em paralelo, como no §22.42.3) → corrigir/
seguir recomendações → suítes (app 463+6; setes-api 1.842 + as mesmas 20; ao vivo 139 + prove-f2a-abort; núcleo 531; nfse 765 + ao vivo 195)
→ commit → docs (§22.46+, INDICE, CLAUDE.md, memória). PASSO 2 — passeio logado da F2b (provocar 502/504 do proxy; decidir
core.errors.network + Emissor fiscal — D-F188; NÃO criar habilitação). PASSO 3 — a JANELA pelo §22.13, cada passo irreversível com o "vai",
antes de 30/11.
```

### 22.46 Gates da Rodada 15 + Rodada 16 (D-F199…D-F202) + ENSAIO da janela e PASSEIO em instância descartável (2026-10-13, 4ª sessão)

> Valdo (2026-10-13, prompt do §22.45): PASSO 1 gates do delta → PASSO 2 passeio logado → PASSO 3 janela. Autorização em pé vigente.
> Pergunta da sessão (AskUserQuestion) — onde fazer o passeio: **"Instância descartável"** (a recomendação; alternativas: na janela,
> passo 7, ou pular).

#### 22.46.1 Gates do delta da Rodada 15 (`822fdf9..95d829d`, só o app)

**Socrático 0,80 ✅** (3 LOW + 3 INFO) e **adversarial 0,86 ✅** (1 LOW + 1 INFO; matriz dirigida 13 atos × 7 telas × 3 desfechos = 273
células sem erro; fuzz de página 300 sementes com `beginOnOtherDetail` = `oldRuleMayDiffer` = 0 — nada alcançável mudou; fuzz de eventos
DIRETOS 200 sementes, 3.783 atos). Os dois acharam a MESMA coisa: o endurecimento do R14-SOC-05 cobriu 2 dos 6 pontos que decidem por "a
tela não mudou" (R15-SOC-01 = R15-ADV-01) → **D-F199**. Demais: reconferência a caminho sem trava (R15-SOC-03 → **D-F200**), cascata do
`saving` (R15-ADV-02 → **D-F201**), o R14-SOC-05 sem teste (R15-SOC-02 → coberto pelo gate R15), oráculos frouxos (R15-SOC-04), parâmetro
morto (R15-SOC-05), comentário da D-F198 no lugar e no tempo errados (R15-SOC-06). Todas as recomendações (a) — autorização em pé.

#### 22.46.2 Rodada 16 — EXECUTADA (app `7bbbd04` + `41f8867`)

| Repo | Commit | O quê |
|---|---|---|
| app (worktree `f2b`) | `7bbbd04` | D-F199 (`_stillOnActDetail` no `_endDetailAct`/Faturar; plano e lista do "Cancelar OS" pelo `_showsOrder`); D-F200/D-F201 (comentários + teste `[DECIDIDO]`); `_outcomeOrder(orderId)`/`_unknownOutcome` sem a tela; D-F198 na `sealed class`; oráculos: R14 (2) exige a lista como 1ª emissão do passo, `verify` do plano no `[RESISTIU]` da D-F194, R13 `longOpOverDetail` com mínimo; gate R15 (`adversarial_r15_gate_test.dart`) ACHADOs → `[CORRIGIDO D-F199]`, cerca = 0 no fuzz direto |
| app (worktree `f2b`) | `41f8867` | `apps/web/.gitignore` cp1252 → UTF-8: o `flutter build web` QUEBRAVA (migração `ScrubGeneratedPluginRegistrant` do flutter_tools) — achado ao montar o passeio; o passo 6 da janela esbarraria nele (nota no §22.13) |

núcleo, nfse-api e setes-api sem mudança (945ad2d · 61d0bbe · 8556491). **Provas**: app **476 + 6 pulados** (o gate R15 com 13, nenhum
pulado) · core 54 · `flutter analyze` limpo. Gates do delta da Rodada 16 (`95d829d..41f8867`): socrático **0,80 ✅** (R16-SOC-01: a
premissa da D-F200 estava errada — corrigida no §7 antes de entrar; R16-SOC-04 → **D-F202**); adversarial — §22.46.5.

#### 22.46.3 ENSAIO da JANELA na instância descartável (passos 3–5 do §22.13 — PASSOU)

**Kit durável** (os scripts, sem senhas, + a receita): `Infra-IA/fiscal-api/scripts/ensaio-janela/README.md`.
Ambiente (tudo no scratchpad da sessão, fora dos repositórios): 2ª instância do MariaDB 10.4.20 do XAMPP na porta **3307** (datadir
próprio, `bind-address=127.0.0.1`, mesmos `sql_mode`/charset/lock wait da produção), restaurada de um `mysqldump --single-transaction`
SÓ-LEITURA de `setes_central` + `setes_setes` + `fiscal_api` (~10 MB); usuários `setes`/`fiscal_api` com SENHAS NOVAS (a da produção nunca
entra); na cópia, a habilitação SE em **H** (IM de H = fato do emitente — D-F60) e `dps_last_number` 900 (longe do histórico de H). Os
processos sobem com as variáveis do passeio por cima do `.env` (o `dotenv` não sobrescreve) — **sonda antes de cada passo** (`SELECT
@@port, @@datadir`) — e com um preload do Node (`--require block-hosts.js` via `NODE_OPTIONS`) que RECUSA DNS/TCP/TLS para
`sefin.nfse.gov.br`, `adn.nfse.gov.br` e o Inter de produção: a cópia tem notas AUTORIZADAS em P e o A1 real (um "Cancelar nota" numa delas
iria ao fisco de produção). JWT do passeio com par RS256 e `kid` próprios (o token não vale na produção); armazenamento, cofre e SMTP do
setes-api apontam para o scratchpad.

| Passo | Resultado |
|---|---|
| nfse-api `db:migrate` | `006 - cancel_event_code_exact` aplicada na cópia |
| 3 — re-sincronia | `issuers 1 · transmissions 20 · events 0 · failures []` (os 3 XMLs de P "faltando" = armazenamento vazio de propósito) |
| 3 — ensaio do ATO (`--cutover 1 --confirmo-setes-api-parado`, dono do ERP) | **exit 0**, `cutover {linhasViradas 1, habilitacaoErpAposentada 1}`, `bloqueios` = só o D-F50 "sem F2a" — o critério do R12-SOC-07 |
| 3 — ensaio do ABORTO (worktree `f2a`) | `{ dryRun: true, triggers: [], migrationRow: false, tombstone: false }` — sem recusa (D-F192/R14-SOC-02) |
| 4 — boot da F2a (worktree, sem watch, :3010) | "Voz do fisco (views): fiscal_api — família(s) service" · "Migration aplicada: 069 - f2a_fiscal_passivo" · "Gatilhos de TRAVA da F2a: 9 gatilho(s) em 1 schema(s)" |
| 5 — re-sincronia + contagens | origem × réplica = **20 tentativas · 23 vozes** nos dois lados |
| 5 — ensaio sem bloqueio | exit 0, `cutover`, **sem `bloqueios`** |
| 5 — `--vai` (com o setes-api PARADO) | `committed: true`; `fiscal_api`: H, `cutover_at` gravado; ERP: SE `deleted='S'` |

Produção conferida DEPOIS (só leitura, 3306): `fiscal_api` P/`cutover_at` NULL, ERP P/`deleted='N'`, nenhuma `f2a_fiscal_passivo` no
`_migrations`. Lição: o ensaio na cópia exercita o roteiro inteiro (inclusive o `--vai` e a ordem parar → ato → subir) sem tocar a
produção — repetir no dia da janela, ANTES do passo 2 real, se houver mudança nos repositórios desde este ensaio.

#### 22.46.4 Passeio logado da F2b — FEITO (2026-10-13, o Valdo logado no navegador do app; fisco de HOMOLOGAÇÃO com o "vai" dele)

| Passo | Resultado |
|---|---|
| lista "Faturadas" (253) | selo por linha pelo setes-api lendo a voz nas views (D-F130): "Cancelada" na 7374 (a NFS-e 704 de P), "Sem NFS-e" nas outras |
| detalhe da OS 7373 | "No fisco" pela nfse-api da cópia ("NFS-e ainda não transmitida") |
| **502 no ato avulso** (Transmitir, POST barrado no proxy) | o `OPTIONS` passa (204), o POST leva o 502 SEM CORS → o navegador entrega `net::ERR_FAILED` → `NetworkFailure` → aviso "resultado incerto — use Consultar" + a frase neutra (D-F185). NADA chegou à nfse-api |
| **504 na leitura da voz** | a seção degrada ("Situação fiscal indisponível") — mas o "código" era a exceção crua com a URL (**P-01** → D-F205) |
| **502 numa leitura do setes-api** | "Falha de conexão com o servidor" (**P-02** → D-F204) e, atrás, "Não encontramos nenhum registro" (**P-03** → D-F206) |
| **aba Emissor fiscal** | com 502: a mesma frase do app (D-F188 → D-F204); normal: A1 presente, válido até 05/10/2027, NFS-e "Habilitado" em **H** (a cópia virou) |
| **lote "Transmitir notas sem NFS-e"** (POST barrado) | fotografia = 7 notas; "Transmitidas 0 · Recusadas 0 · Incertas — consulte 3 · Não tentadas 4", parou em 3 desconhecidos seguidos, linha com o nº da NOTA e a frase neutra; 0 tentativas novas na cópia |
| **Transmitir em H** (OS 7373, nota 6789) | 1ª vez: 422 `FISCAL_DPS_INVALID` local (código municipal "0102") — a tela mostrou só "Esperado 3 dígitos" (**P-04** → corrigido: a mensagem principal vai junto) e o dado é da trilha (**P-05** → D-F207); corrigido SÓ na cópia o valor congelado da 8010 → **NFS-e 3 AUTORIZADA em homologação** (chave 4106902…1338, DPS …0901), "Voz do fisco" com a linha do tempo |
| **"Cancelar nota" pela saga** | o plano abriu sobre a OS dela; motivo; nota de H = cancelamento LOCAL (D-F83 — em H a saída é cancelar a nota): evento C com o motivo, nota desfeita, OS de volta a aberta; no `fiscal_api` só a voz A (a NFS-e 3 de H segue lá, sem efeito) |
| depois das decisões (build novo) | 502 do setes-api → "Sem resposta do serviço — rede, proxy ou tempo." + "NETWORK · setes-api" + "Não foi possível carregar a lista." com "Tentar novamente" (recarregou: 92 abertas); Emissor com 502 → frase neutra + "NETWORK · nfse-api" |

**Não reproduzido**: na 1ª abertura de Ordens de Serviço (build de RELEASE, painel do navegador mudando de tamanho) a página ficou em branco
com `Uncaught Error` minificado (o console mostrou o app "started" DUAS vezes — a página carregou duas vezes na abertura do painel — e um
módulo DISPOSED antes do erro); o mesmo caminho em release e em profile, pelo menu e pela rota, nos dois layouts e trocando a largura com a
tela aberta, NÃO repetiu. Fica de olho: se voltar, o build de release com `--source-maps` (`web-release/main.dart.js.map`) traduz a pilha.

Commit do app com as decisões: `f312f06` (app 491 + 5 pulados · core 55 · analyze limpo). Gates do delta `570324c..f312f06`: §22.46.6.

Topologia: setes-api da worktree `f2a` em :3010 e nfse-api em :3012 contra a 3307; proxy de FALHAS na frente de cada uma (:3011 → :3010,
:3013 → :3012) que, por um arquivo de controle (`proxy-mode.json` — modo `502|503|504|hang|reset`, regex do caminho, N vezes), devolve a
página de erro do nginx SEM cabeçalho CORS (a D-F181); build web da f2b (`flutter build web --dart-define-from-file` com as URLs dos
proxies) servido em :5052 com `no-cache`; navegador do app (o Valdo digita a senha — o agente nunca). Roteiro: selo fiscal da lista pela
nfse-api; OS de teste de cliente interno faturada → Transmitir em H → "Cancelar nota" pela saga; lote "Transmitir notas sem NFS-e"; 502/504
na linha do lote, no ato avulso e numa leitura do setes-api → decidir o `core.errors.network` + a aba "Emissor fiscal" (D-F188). As notas de
P da cópia NÃO são tocadas.

#### 22.46.5 Gates do delta da Rodada 16 (`95d829d..41f8867`) e as correções (app `570324c`)

**Socrático 0,80 ✅** (3 LOW + 4 INFO) e **adversarial 0,88 ✅** (3 LOW, NADA no produto — matriz de eventos diretos de 1.248 células sem
erro; 400 sequências NOVAS pela página + 300 diretas + as 500 do R15 sob oráculos mais fortes; `.gitignore`/`pubspec`/`.metadata`/`web/*`
em UTF-8 — cerca nova no gate R16). Correções (autorização em pé):

| Achado | O quê | Destino |
|---|---|---|
| R16-SOC-01 | a premissa da D-F200 ("o servidor serializa pela trava da nota") era FALSA — a reconferência não trava a nota; a duplicata é inofensiva (GET + carimbo condicional da D-F90) | **corrigida** no §7, no comentário e no nome do teste (Q-F199-SOC-01 (a)) |
| R16-SOC-02 = R16-ADV-02 | a tolerância do "desfecho engolido" (oráculo (2)) não conferia a CAUSA — no R15 nem a 1ª emissão | **corrigido** nos fuzz R14 e R15: só no passo de um `get`/`post` que FALHOU, com a lista como 1ª emissão |
| R16-SOC-03 | "hoje todo ato nasce no detalhe dele" é falso (D-F197/D-F184) | **corrigido**: o comentário da D-F199 cita os invariantes I1–I3 e a cerca (diferencial do fuzz de página) |
| R16-SOC-04 | a lista desatualizada depois de "Cancelar OS" (página recriada) — a D-F182 só falava em faturar | **D-F202** (texto) |
| R16-SOC-06 | o exemplo da D-F201 sem o detalhe do contador | **corrigido** (meia frase) |
| R16-SOC-07 | o build web pode voltar a quebrar sem ninguém ver | nota no passo 6 da janela (ensaiar o build antes) + cerca de decodificação no gate R16 |
| R16-ADV-01 | Faturar com outro ato da OS relido no meio relê em vez de trocar de aba | **D-F203** |
| R16-ADV-03 | o oráculo (7) do R15 reprovava por engano a D-F201 (só a chamada decisiva contava como irmão) | **corrigido**: qualquer parte da cadeia |
| R16-SOC-05 | contadores de pré-condição no fuzz (opcional) | não feito — os dirigidos cobrem |

**Provas**: app **488 + 6 pulados** · `flutter analyze` limpo. Commits LOCAIS do app nesta sessão: `7bbbd04` · `41f8867` · `570324c`.

#### 22.46.6 Gates do delta do passeio (`570324c..f312f06` — D-F204…D-F206 + P-04) e as correções (app `60df1df`)

**Socrático 0,76 ✅** (1 MEDIUM + LOW/INFO) e **adversarial 0,78 ✅** (só LOW — 600 sequências de fuzz da D-F206, matriz D-F205 de 50
combinações sem vazar URL/host/token, ponta a ponta com a página montada). Valdo: **"siga as recomendações"**. Os gates DIVERGIRAM só no
destino do texto cru (socrático (b) `debugPrint` × adversarial (a) aceitar) — seguido o (b), que cumpre os dois: o comentário vira verdade e
o texto vai a um lugar que existe em produção.

| Achado | O quê | Destino |
|---|---|---|
| PSO-SOC-01 (MEDIUM) = PSO-ADV-04 | `developer.log` é no-op no release do web (dart2js) — "vai só para o log" era falso | **D-F208** (`debugPrint`) |
| PSO-SOC-03 + PSO-ADV-08 | o P-04 piorava o 400 de DTO ("Validação falhou" genérico) e repetia a mensagem do campo | **D-F209** (`unanchoredFieldsText` na ponte; FISCAL_CANCEL_REFUSED com ramo próprio) |
| PSO-SOC-05 = PSO-ADV-03 | 10 fallbacks do core rotulavam erro de LEITURA como rede | **D-F210** |
| PSO-SOC-06 = PSO-ADV-06 · PSO-ADV-07 | falhas de rede iguais colapsadas; o código fora dos avisos | **D-F211** · **D-F212** (conhecimento negativo) |
| PSO-SOC-02 = PSO-ADV-01 · PSO-ADV-02 | o estado de falha perdia a página (o "Tentar novamente" ia à 1) e limpava a seleção das recusadas | **corrigido** (página/tamanho no estado; a seleção ignora a falha) |
| PSO-ADV-05 | a lista de OS com 200 fora do envelope dizia "nenhum registro" | **corrigido** (`envelopePage`) |
| PSO-SOC-04 | `core.errors.network` cru (sem `.tr()`) nas linhas do relatório do lote de faturamento | **corrigido** |
| PSO-ADV-09 (anterior ao delta) | o `finally` da operação longa ANTIGA apagava a trava da SEGUINTE (a H1 da D-F179 reabria — dois lotes fiscais da mesma nota no ar) | **corrigido**: trava COM DONO (`_RunLock`) nas 4 operações |
| PSO-SOC-07 | a regra da D-F206 fora das skills; as 28 listas sem pendência rastreável | **corrigido**: `criar-formulario-cadastro.md` + `tela-de-processo.md` (itens 8–9) + chip de tarefa |
| PSO-SOC-08/09 · PSO-SOC-05 do R13 | chaves duplicadas da frase; dois diálogos numa queda total | mantidos (limite conhecido) |

**Provas**: app **508 + 13 pulados** (as 8 provas SUPERADAS do gate do passeio entram nos pulados) · core **56** · `flutter analyze` limpo
nos dois. Os gates deste último delta (`f312f06..60df1df`) rodam junto com a próxima mudança de código ou no dia da janela.

#### 22.46.7 Gates do último delta (`f312f06..60df1df`, 2026-10-13/14) e as decisões D-F213…D-F217 (app `d08ac1b` + `5f6d3be`)

**Socrático 0,74 ✅** (1 MEDIUM) e **adversarial 0,76 ✅** (1 MEDIUM) — a trava COM DONO resistiu a 600 sequências com oráculos estritos.

| Achado | O quê | Destino |
|---|---|---|
| LD-ADV-01 (MEDIUM) | login com 200 sem token nem seleção = "sucesso" com token nulo → o AuthBloc girava para sempre | **corrigido** (`d08ac1b` — o datasource recusa; a regra da D-F210) |
| LD-SOC-01 (MEDIUM) × LD-ADV-07 | o código E do fisco "sumia" no FISCAL_CANCEL_REFUSED — era o FIXTURE (forma inventada); na forma REAL (`{field:'event', message:'E1235: …'}`) o código vem na principal | **corrigido**: fixture real + teste que exige o código (com a principal cortada em 255) + linha sem o nome técnico |
| LD-ADV-08 = LD-SOC-06 | `unanchoredFieldsText` não era total; o ramo do DTO pegava o 422 VALIDATION_FAILED com mensagem específica | **corrigido** (vazio → principal; DTO só no 400) |
| LD-ADV-04 = LD-SOC-02 | repositório da OS punha o texto do Dart como mensagem | **corrigido** na OS; os outros 36 → chip "Levar D-F209/D-F210 aos módulos do app" |
| LD-ADV-06 · LD-ADV-11 = LD-SOC-04 · LD-ADV-12 = LD-SOC-05 | recarga com o bloc fechado; seleção armada sobre lista que falhou; fuzz ainda tolerando o PSO-ADV-09 | **corrigidos** |
| LD-ADV-05 | guarda cruzada de um lado só | **D-F213** |
| LD-ADV-09 = LD-SOC-03 · LD-SOC-07 · LD-ADV-03 + LD-SOC-08 · LD-ADV-10 | natureza dos códigos do cliente; CPF no console; leitores do core sem envelope + código do Dart; recuo infinito | **D-F214…D-F217** (Valdo 2026-10-14, todas pela recomendação) |
| LD-SOC-09/10 | as 5 telas com a fórmula antiga; nomes de testes antigos | chip / nada |

**Provas**: app **538 + 20 pulados** (as 7 provas superadas do gate LD entram nos pulados) · core **56** · `flutter analyze` limpo. Os
gates deste delta (`60df1df..5f6d3be`) = o PASSO 0 do §22.48.

#### 22.46.8 Gates do delta `60df1df..5f6d3be` (2026-10-14) e as decisões D-F218…D-F220 (app `ebd040c`)

**Socrático 0,80 ✅** e **adversarial 0,80 ✅** — só LOW (nenhum MEDIUM/HIGH/CRITICAL). Resistiram: o fluxo de login em 21 formas de
resposta (nenhum spinner preso), o `envelopeOk` contra as rotas REAIS (todo 2xx de `/auth/*` e `/api/core/*` é `{ ok: true }` — worktree e
árvore viva iguais), a D-F214 nas duas pontes (13 falhas), a D-F138/D-F148 intactas, a D-F217 em 900 sequências, o `isClosed` em 8
combinações, a seleção × falha pela página real.

| Achado | O quê | Destino |
|---|---|---|
| LE-SOC-01 = LE-ADV-04 · LE-SOC-03 | a D-F216 só no `invalidResponseFailure` — `envelopeData`/`envelopePage`/envelope estrito sem código nem console (o caso Plesk-HTML) | **corrigido**: as três portas pelo `invalidResponseFailure` com o serviço; `service` obrigatório (sem default) |
| LE-ADV-01 · LE-ADV-03 | token `""` virava sessão; seleção sem estabelecimentos abria tela sem saída | **corrigidos** (a regra do LD-ADV-01) |
| LE-ADV-05 | a D-F217 comparava a página da RESPOSTA (proxy que ignora a query voltava ao laço) | **corrigido**: pela página PEDIDA |
| LE-SOC-05 = LE-ADV-06 | `FISCAL_DPS_REJECTED` ainda com "• dps: E0116" | **corrigido** (a regra do LD-SOC-01) |
| LE-SOC-02 · LE-SOC-07 · LE-SOC-08 | comentários falsos; `$error` cru no console; D-F211 × resposta ilegível | **corrigidos** / conhecimento negativo |
| LE-SOC-04 | D-F217 fora das skills e de ~32 blocs | **skills atualizadas** + o chip das listas cobre a D-F217 |
| Q-LE1 · LE-ADV-02 · LE-ADV-07 | troca de senha não idempotente; relógio adiantado = login mudo; query no meio da causa | **D-F218 · D-F219 · D-F220** |

**Provas**: app **562 + 27 pulados** · core **56** · `flutter analyze` limpo. Os gates do delta `5f6d3be..ebd040c` = o PASSO 0 do §22.49.

#### 22.46.9 Gates do delta `5f6d3be..ebd040c` (2026-10-14, 5ª sessão) — socrático **0,82 ✅** · adversarial **0,84 ✅** (app `5f7bda4`)

Agentes independentes em paralelo (o socrático só leu e rodou analyze/test; o adversarial criou `apps/web/test/adversarial_lf_gate_test.dart`
— 14 provas — e `packages/core/test/adversarial_lf_core_test.dart` — 20 provas). **Nenhum MEDIUM/HIGH/CRITICAL.** Resistiram: o fluxo do
login em 32 formas de token (invariante "`AuthAuthenticated` ⇒ a guarda aceita o MESMO token", nunca spinner preso), a fronteira do relógio
(23h59 entra, ≥ 24 h = `CLIENT_CLOCK`), a D-F216 nas três portas × 18 corpos hostis × as duas APIs (o corpo/query/token nunca vão ao
console), a D-F217 contra servidores hostis (40 sementes × 8 variantes × 22 ações: ≤ 2 GETs por ação, sem laço), `FISCAL_DPS_REJECTED` nas
formas REAIS do produtor (`fiscal-api/src/transport/https-json.ts` `rejectField` · `nfse-api/src/authority/adn.ts`), D-F218 (comentário
confere com `auth.repository.ts`).

| Achado | O quê | Destino |
|---|---|---|
| LF-SOC-02 | `service` ainda opcional em `invalidResponseFailure`/`invalidResponseCode` — falha sem o serviço reaparece com a próxima chamada | **corrigido**: `required` (4 testes antigos ajustados) |
| LF-SOC-01 | comentários diziam que todo `supportRef` das falhas `CLIENT_*` é código curto — `CLIENT_CONFIGURATION` leva a base URL/texto do erro | **corrigido** (comentários) |
| LF-ADV-04 | o regex da D-F220 só entendia `https?://` minúsculo | **corrigido** (qualquer esquema, qualquer caixa); a URL SEM esquema segue como conhecimento negativo (teste que a fixa) |
| LF-ADV-08 | rejeição `{field:'dps', message:''}` virava a linha "• " em branco | **corrigido** (linhas sem texto saem; todas vazias → mensagem principal da falha) |
| LF-SOC-03 = LF-ADV-01 · LF-ADV-02 | `CLIENT_CLOCK` sempre culpa o aparelho (um token já vencido NO servidor — TTL mal configurado — dá o mesmo sintoma); o `supportRef` sem `iat`/`exp` e a hora local sem fuso | **QUESTÃO para o Valdo** (é o AuthBloc — login/core, FORA da F2a/F2b): recomendação (a) = `iat`/`exp` e a hora em UTC no `supportRef` + `|agora − iat|` pequeno com `exp ≤ agora` ⇒ `INVALID_RESPONSE` |
| *(resposta do Valdo 2026-10-14: "Aplicar")* | LF-SOC-03 = LF-ADV-01 · LF-ADV-02 | **EXECUTADO** (app `0fdbfa3`): `jwtIssuedAt` em `jwt_utils.dart`; `|agora − iat| ≤ 5 min` com `exp ≤ agora` = `INVALID_RESPONSE · setes-api` (o servidor emitiu vencido); `iat` longe do relógio (ou sem `iat`) = `CLIENT_CLOCK` com `agora=…Z iat=…Z exp=…Z` no supportRef; app 576 + 27 · core 76. **Gates deste delta pequeno (`5f7bda4..0fdbfa3`, só `auth_bloc.dart`/`jwt_utils.dart`) rodam junto com a próxima mudança de código ou no dia da janela** |
| LF-ADV-05 · LF-ADV-07 · LF-ADV-09 · LF-ADV-10 · LF-ADV-03/06 · LF-SOC-04/05 | regex quadrático só em causa de dezenas de KB de espaços; `page`/`pageSize` da resposta sem limite; item de lista com id ilegível = 0; `ok:true` sem `data`; seleção `[{}]`; D-F218 sem frase "entre com a senha nova"; D-F217 só na lista de OS | **limites conhecidos** (o setes-api real limita page/pageSize, nunca emite item sem id nem `ok:true` sem `data`; nenhum texto do servidor entra na causa) — teste/comentário os fixa |

**Provas**: app **576 + 27 pulados** · core **76** · `flutter analyze` limpo nos dois. Critério de entrada (passo 1) — parcial desta sessão:
núcleo **531** · nfse-api **765** (com `SETES_API_DIR` na worktree) · setes-api worktree `f2a` **1.842 + as MESMAS 20 falhas** (19 da
bomba-relógio do boleto + 1 da cerca de fuso, nome a nome).

**Critério de entrada da janela (§22.13 passo 1) — CUMPRIDO (2026-10-14, 5ª sessão)**: setes-api worktree `f2a` — ao vivo **139/139**
(`F2A_ADV_LIVE=1 … adversarial-f2a`, 8 suítes, inclusive o gate da A3) + `scripts/prove-f2a-abort.ts` ok; nfse-api ao vivo **195 + 4 pulados**
(15 suítes); núcleo **531 + 1**; nfse-api **765** (com `SETES_API_DIR` na worktree); nenhum banco `f2a_*`/`fiscal_api_adv_*` sobrou. Build
web ENSAIADO (R16-SOC-07): `apps/web/build-web.ps1` com URLs https de ensaio → **exit 0**, `main.dart.js` 5,1 MB (⚠️ no PS 5.1 NÃO
redirecionar `2>&1` ao chamar o script — o stderr do `flutter` vira ErrorRecord e o `$ErrorActionPreference='Stop'` derruba). Os repositórios
do banco (núcleo `945ad2d` · nfse-api `61d0bbe` · setes-api `f2a` `8556491`) NÃO mudaram desde o ensaio da janela de 2026-10-13 (§22.46.3) →
**o ensaio na instância descartável não precisa ser refeito**. Falta, para a JANELA: (1) as URLs https REAIS de publicação do setes-api e da
nfse-api (`-ApiUrl`/`-NfseApiUrl`) e o destino do build (Plesk); (2) o Valdo presente para o "vai" de cada passo; (3) a decisão sobre o
`CLIENT_CLOCK` (acima).

#### 22.50 2º ENSAIO COMPLETO da janela na instância descartável com o código FINAL (2026-10-14, 5ª sessão — pedido do Valdo: "as URLs de verdade entram por configuração no deploy; quero testar agora")

Kit do §22.46.3 remontado do zero (MariaDB :3307 de um dump só-leitura novo, `setes`/`fiscal_api` com senhas novas, habilitação SE em **H**
e `dps_last_number` 900 nos DOIS lados, chaves RS256/`kid` `passeio`, fisco/Inter de produção BLOQUEADOS no processo, sondas `@@port` antes de
cada passo). Código: setes-api `f2a` 8556491 · nfse-api 61d0bbe · núcleo 945ad2d · app `f2b` 0fdbfa3. Resultado, passo a passo do §22.13:
`db:migrate` (006) → re-sincronia `issuers 1 · transmissions 20 · events 0 · failures []` → ENSAIO do ato **exit 0** só com o D-F50 "sem F2a"
→ ENSAIO do aborto `{dryRun:true, triggers:[], migrationRow:false, tombstone:false}` → boot da F2a "Voz do fisco (views): fiscal_api —
família(s) service" + "Migration aplicada: 069" + "Gatilhos de TRAVA da F2a: 9" → re-sincronia + contagens **origem = réplica (20 · 23)** →
ensaio SEM bloqueio (exit 0, sem `bloqueios`) → setes-api parado (porta + caminho conferidos) → `--vai` **`committed: true`** (`fiscal_api` H
com `cutover_at`; ERP SE `deleted='S'`) → subir. Produção conferida DEPOIS (só leitura, 3306): `fiscal_api` P/`cutover_at` NULL, ERP P/`deleted='N'`,
nenhuma 069. Passeio: setes-api :3010, nfse-api :3012, proxies de falhas :3011/:3013, build web com `flutter build web --dart-define-from-file`
(API_URL/NFSE_API_URL de localhost) servido em :5052. Lição: o Node no Windows exige caminho `C:/…` (não `/c/…`) em `NODE_OPTIONS --require`
e nas chaves.

**Passeio logado (2026-10-14, 5ª sessão — Claude in Chrome sobre o navegador do Valdo, sessão dele mantida; o agente nunca digitou senha)** —
build do código final (`0fdbfa3`) em :5052 contra a cópia: lista de OS abertas (91→92) e faturadas (253→252) pelo setes-api da F2a; **selo
fiscal por linha** pela voz do `fiscal_api` (7374 "Cancelada", 7368 "Falha · Homologação", demais "Sem NFS-e"); detalhe "No fisco" pela nfse-api
(OS 7373); **Transmitir** → 422 local `FISCAL_DPS_INVALID` com a mensagem principal + "Esperado 3 dígitos" (dado da trilha, cTribMun "0102" =
passo 6b da janela — nada foi ao fisco); **"Cancelar nota" pela saga** (ícone ⊗ do AppBar) com o plano lido pelo `cancel-plan`: nota 6789 → evento
`C` com o motivo, OS 7373 de volta a Aberta; 2ª nota (6788) bloqueada de forma LEGÍVEL enquanto o cliente tinha outra OS aberta (a 8010 — trava D5),
cancelada depois de cancelar a OS 7373; **502** no ato avulso → "O fisco não deu uma resposta conclusiva… use Consultar" + frase neutra; **lote**
com 502 em todo POST → "Incertas — consulte 3 · Não tentadas 3 — o lote parou antes delas" (uma linha por nota, com o nº da NOTA); lote
sem falha → 6 recusadas `FISCAL_DPS_INVALID`; **504 na lista do setes-api** → "Sem resposta do serviço — rede, proxy ou tempo." +
"NETWORK · setes-api" + "Não foi possível carregar a lista." + "Tentar novamente" (recarregou); aba **Emissor fiscal**: A1 presente, válido até
2027-10-05, NFS-e "Habilitado" em H. Console: só os `[ApiClient] falha de rede em <serviço> <caminho>` (sem query, sem `uri=`). **Não
exercitado**: Transmitir AUTORIZADA em H (o dado "0102" recusa antes — provado em 13/10 com o dado corrigido na cópia) e o `CLIENT_CLOCK`
(exige o relógio do aparelho; coberto pelos testes). **Não reproduzido (de novo)**: um `[EXCEPTION] Error` minificado no console, visto uma vez
na 1ª sessão do navegador — nenhuma das ações isoladas (abrir, transmitir, plano, cancelar nota/OS, 502/504, recarga) o repetiu; mesma
classe do item "Não reproduzido" do §22.46.4 (se voltar, `flutter build web --source-maps`).

**Encerramento do ensaio e investigação dos achados (2026-10-14, a pedido do Valdo)** — ambiente ENCERRADO (processos parados pela porta + linha
de comando; MariaDB :3307 desligado; datadir/dump/chaves APAGADOS; produção reconferida: `fiscal_api` P/`cutover_at` NULL, ERP P/`deleted='N'`,
nenhuma 069, mesmos PIDs 3000/3306; nenhum banco `f2a_*` sobrou). Investigação:

| Achado | Causa | Destino |
|---|---|---|
| **B1** o bloqueio do plano dizia "ordem de serviço **8010**" onde a lista mostra a OS **7373** | a frase citava `tb_service_order.id`; a tela mostra `number` (D-F187) | **corrigido** (setes-api `f2a` `4148f3a`): `findServiceOrderForReopen` devolve `blockingOrderNumber`; teste exige o número |
| **B1b** mesma classe no bloco "Devolução N aponta para esta nota" (a tela de Devoluções mostra `a.number`) | `r.id` | **corrigido** (`f2a` — subconsulta NÃO travante, a ordem de locks C1 não muda; ao vivo 139/139). **Limite conhecido**: o bloco "Título `<pedido>/<parcela>`" segue pelo id do pedido (a tela de Baixas é que decide o que mostra — não verificado) |
| **E1** `[EXCEPTION] Error` minificado + página em branco | traduzido com source maps (mesmo commit `0fdbfa3`): `ModularRouteInformationParser.selectRoute` (flutter_modular 5.0.3) lança o `RouteNotFound` — **qualquer rota desconhecida** (`#/nada-aqui/`, `#/home/nada-aqui/`) deixa a tela EM BRANCO com essa exceção; reproduzido de forma determinística; navegar de novo para `#/home/` recupera. O app não tem `WildcardRoute`. É a MESMA classe do "não reproduzido" de 13/10 (§22.46.4) — a causa lá foi uma rota que não resolveu na abertura | **QUESTÃO para o Valdo** (roteamento do app inteiro — fora da F2a/F2b): recomendação (a) = `WildcardRoute` no `AppModule` e no `HomeModule` redirecionando para `/home/` (logado) ou `/login`, + teste de widget |
| `/login` transitório na recarga com sessão mantida | **desenho**: `Modular.setInitialRoute('/login')` e a `LoginPage` encaminha a sessão salva para `/home/` (`login_page.dart:36-39`) | nada |
| cliques "perdidos" logo depois de fechar um diálogo | o clique cai durante a animação de fechamento da barreira modal (esperar ~1 s) — artefato da automação, não do app | nada |
| `FISCAL_DPS_INVALID` "0102" · 7368 "Falha · Homologação" · 7372 sem cancelar com outra OS aberta do cliente | dado da trilha (passo 6b) · dado de um teste anterior em H · trava D5 (1 OS aberta por cliente — por desenho, agora com a frase certa) | nada (6b na janela) |

#### 22.47 ⏯ PROMPT DE RETOMADA CURTO (SUPERADO pelo §22.48)

```
Retome a F2a/F2b do Gestão 2027 pelo §22.47 do Infra-IA/prompts/prompt_apis_fiscais_isoladas.md (leia D:\Gestao2027\CLAUDE.md, o §22.46 e
o §22.13 — roteiro da JANELA; §7 = D-F1…D-F203). Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a
(branch f2a, 8556491) · núcleo 945ad2d · nfse-api 61d0bbe · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 570324c).
AUTORIZAÇÃO EM PÉ: as questões dos gates seguem a RECOMENDAÇÃO sem esperar — salvo passo irreversível (janela, --cutover --vai fora de
cópia descartável, aborto --vai fora de descartável, push, apagar linha do fiscal_api), algo fora da F2a/F2b, gates divergentes sem saída ou
achado HIGH/CRITICAL.
REGRAS: D:\Gestao2027\setes-api (árvore viva) É a produção (tsx watch) — só leitura; nunca npm run dev/flutter run nas worktrees com o .env
delas; nunca criar habilitação no fiscal_api de produção (D-F192/D-F195); ao vivo só em bancos/instâncias descartáveis, um de cada vez;
nunca mexer em código com um gate rodando nas mesmas árvores; edição por ferramenta/script em arquivo (UTF-8); commit só dos caminhos da
frente com git commit -F.
PASSO 1 — o delta 41f8867..570324c do app é só comentário e oráculo de teste: rodar os gates dele JUNTO com a próxima mudança de código.
PASSO 2 — o passeio logado da F2b na instância descartável (§22.46.4; se o scratchpad da sessão anterior sumiu, remontar pelo kit
Infra-IA/fiscal-api/scripts/ensaio-janela/README.md — o ensaio dos passos 3–5 refaz junto): selo fiscal da lista; OS de teste de cliente
interno faturada → Transmitir em H → "Cancelar nota" pela saga; lote "Transmitir notas sem NFS-e"; 502/504 do proxy na linha do lote, no
ato avulso e numa leitura do setes-api → decidir o core.errors.network + a aba "Emissor fiscal" (D-F188); as notas de P da cópia NÃO são
tocadas; no fim, parar os processos (pela porta + caminho da worktree) e apagar a instância. PASSO 3 — a JANELA pelo §22.13 (cada passo
irreversível com o "vai"; ensaiar o build web antes — R16-SOC-07), antes de 30/11. Ao fim de cada passo: docs (§22.48+), INDICE_CENTRAL,
CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```

#### 22.48 ⏯ PROMPT DE RETOMADA CURTO — a JANELA (SUPERADO pelo §22.49)

```
Retome a F2a/F2b do Gestão 2027 pelo §22.48 do Infra-IA/prompts/prompt_apis_fiscais_isoladas.md (leia D:\Gestao2027\CLAUDE.md, o §22.46 —
passeio FEITO e o ensaio da janela na cópia — e o §22.13, roteiro da JANELA com o passo 6b da D-F207; §7 = D-F1…D-F217). Commits LOCAIS
(push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, 8556491) · núcleo 945ad2d · nfse-api 61d0bbe ·
setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, 5f6d3be) · Infra-IA (main).
AUTORIZAÇÃO EM PÉ: questões dos gates seguem a RECOMENDAÇÃO — salvo passo irreversível (cada passo da janela, --cutover --vai, push, apagar
linha do fiscal_api, escrita em dado de produção), algo fora da F2a/F2b, gates divergentes sem saída ou HIGH/CRITICAL.
REGRAS: D:\Gestao2027\setes-api (árvore viva) É a produção (tsx watch) — só leitura até o passo 4; nunca npm run dev/flutter run nas worktrees
com o .env delas; nunca criar habilitação no fiscal_api de produção antes do ato (D-F192/D-F195); edição por ferramenta/script em arquivo
(UTF-8); commit só dos caminhos da frente com git commit -F.
PASSO 0 — gates do delta 60df1df..5f6d3be do app (§22.46.7: login sem token, texto sem âncora total, D-F213…D-F217 — falha do cliente
técnica nas pontes, console sem query, leitores do core no envelope + código INVALID_RESPONSE, recuo de página) — socrático + adversarial;
corrigir (os gates de f312f06..60df1df já rodaram — §22.46.7).
PASSO 1 — critério de entrada do §22.13 (suítes; gate adversarial da A3 ao vivo; ensaio do build web pelo build-web.ps1 — R16-SOC-07); se os
repositórios mudaram desde 2026-10-13, refazer o ENSAIO da janela na cópia pelo kit Infra-IA/fiscal-api/scripts/ensaio-janela/README.md.
PASSO 2 — a JANELA pelo §22.13 com o Valdo, cada passo irreversível com o "vai" na hora (2 → 3 → 4 → 5 → 6 → 6b → 7 → 8), antes de 30/11.
Ao fim: docs (§22.49+), INDICE_CENTRAL, CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```

#### 22.49 ⏯ PROMPT DE RETOMADA CURTO — gates do último delta → a JANELA (colar numa sessão nova)

```
Retome a F2a/F2b do Gestão 2027 pelo §22.49 do Infra-IA/prompts/prompt_apis_fiscais_isoladas.md. Leia D:\Gestao2027\CLAUDE.md, o §22.46
(4ª sessão de 2026-10-13/14: ensaio da janela na cópia PASSOU, passeio logado FEITO, gates §22.46.1–§22.46.8) e o §22.13 (roteiro da
JANELA, com o passo 6b da D-F207); §7 = D-F1…D-F220.
Commits LOCAIS (push só com o "vai"): setes-api worktree D:\Gestao2027\setes-api-f2a (branch f2a, 8556491) · núcleo 945ad2d · nfse-api
61d0bbe · setes-app worktree D:\Gestao2027\setes-app-f2b (branch f2b, ebd040c) · Infra-IA (main).
AUTORIZAÇÃO EM PÉ: questões dos gates DESTA frente seguem a RECOMENDAÇÃO — salvo passo irreversível (cada passo da janela, --cutover --vai,
push, apagar linha do fiscal_api, escrita em dado de produção), algo FORA da F2a/F2b (login/core/pontes do app inteiro = perguntar),
gates divergentes sem saída ou HIGH/CRITICAL.
REGRAS: D:\Gestao2027\setes-api (árvore viva) É a produção (tsx watch) — só leitura até o passo 4 da janela; nunca npm run dev/flutter run
nas worktrees com o .env delas; nunca criar habilitação no fiscal_api de produção antes do ato (D-F192/D-F195); ao vivo só em bancos/
instâncias descartáveis; nunca mexer em código com um gate rodando na mesma árvore; edição pela ferramenta (UTF-8 — heredoc com barra
invertida ou \n FALHA); commit só dos caminhos da frente com git commit -F; fixture de teste na forma REAL do produtor (ler o produtor antes
de aceitar um achado).
PASSO 0 — gates do delta 5f6d3be..ebd040c do app (socrático + adversarial em paralelo, como no §22.46.8): D-F216 nas três portas do
envelope, token vazio/seleção vazia, recuo pela página pedida, FISCAL_DPS_REJECTED sem o nome técnico, D-F219 (CLIENT_CLOCK no AuthBloc —
jwtExpiry), D-F220 (query fora do console) → corrigir/seguir recomendações → suítes (app 562 + 27; core 56) → commit → docs (§22.46.9+).
PASSO 1 — critério de entrada da janela (§22.13 passo 1): suítes do setes-api (worktree f2a: 1.842 + as MESMAS 20; ao vivo 139/139 +
scripts/prove-f2a-abort.ts), núcleo (531), nfse-api (765 + ao vivo 195); gate adversarial da A3 com F2A_ADV_LIVE=1; ENSAIAR o build web
pelo apps/web/build-web.ps1 (R16-SOC-07 — exige URLs https de publicação); se os repositórios do banco mudaram desde 2026-10-13, refazer o
ENSAIO da janela (passos 3–5 + --vai) na instância descartável pelo kit Infra-IA/fiscal-api/scripts/ensaio-janela/README.md.
PASSO 2 — a JANELA pelo §22.13 COM o Valdo, cada passo irreversível com o "vai" na hora: 2 (parar o uso, nfse-api no ar com as migrations
001–006, GRANT, cerca do kid) → 3 (ensaio do ato + ensaio do aborto, os relatórios esperados) → 4 (merge f2a, subir, ler o log) → 5
(re-sincronia + contagens + ensaio sem bloqueio → --vai) → 6 (publicar o build da F2b com no-cache) → 6b (D-F207: cancelar as 7 notas da
trilha com cTribMun "0102" + desativar as regras de ISS 1/3/4) → 7 (trilha → reabrir) → 8 (A1 do cofre, push, F3). Antes de 30/11.
PENDÊNCIAS FORA DO CAMINHO CRÍTICO (chips abertos): "Levar D-F206/D-F217 às listas do app" e "Levar D-F209/D-F210 aos módulos do app".
Ao fim de cada passo: docs (§22.50+), INDICE_CENTRAL, CLAUDE.md da raiz, memória apis-fiscais-isoladas.
```
