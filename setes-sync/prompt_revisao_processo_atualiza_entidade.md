# Prompt — Revisão: processo que atualiza Entidades (Cliente/Fornecedor/Transportadora/Colaborador) → setes-sync

**Escopo**: setes
**Origem**: rascunho `REvisao processo atualiza entidade.txt` (Valdo, 2026-07-25) + varredura de código 2026-07-25
**Status**: FECHADO na Rodada 1 (2026-07-25) — 5 decisões registradas, questões zeradas; em execução
**Regras-mãe**: D1–D24 de `Infra-IA/setes-sync/prompt_revisao_sincronizador_setes_sync.md` (D3: nunca emp_codigo; D4: UUID p/ sem-documento) + `MAPA_INDEXACAO.md` + `CONTRATOS_SYNC.md`

---

## Contexto

Processo que sincroniza entidades do sistema desktop (Delphi + Firebird) para a setes-sync (Node/TS + MySQL):

- `TB_EMPRESA` centraliza a maior parte dos cadastros (`EMP_CODIGO` como id local)
  - `TB_CLIENTE` especializa (CLI_CODEMP)
  - `TB_FORNECEDOR` especializa (FOR_CODEMP)
  - `TB_TRANSPORTADORA` especializa
- `TB_COLABORADOR` é tabela totalmente independente (`CLB_CODIGO`, tem `CLB_CPF`) e deve entrar no processo como as demais

Na web: UMA entity por CPF/CNPJ em `setes_central` (Fase 3 — Entidade Única), papéis (`tb_customer`/`tb_provider`/`tb_carrier`/`tb_collaborator`/`tb_salesman`) no schema do cliente.

## O que JÁ ESTÁ implementado e conferido no código (2026-07-25 — não refazer)

| Item do rascunho | Estado real | Evidência |
|---|---|---|
| Reindexação `emp_codigo` → `tb_entity.id` por CPF/CNPJ | ✅ motor `sync.entity.ts` (busca dentro da transação, `FOR UPDATE`, last-write-wins) | `setes-sync/src/modules/sync/sync.entity.ts:176-209` |
| Sem documento → `tb_no_doc` + código devolvido | ✅ `personType='N'` → UUID v4 (não "hash") em `tb_no_doc.external_id`, devolvido como `externalCode` no envelope | `fiscal.repository.ts:45-55`, `sync.response.ts` |
| 1º ciclo sem doc/sem externalCode → cria; 2º ciclo com externalCode → atualiza | ✅ `findEntityIdByExternalCode`; não achou → 404 `EXTERNAL_CODE_NOT_FOUND` | `sync.entity.ts:107-116,185-194` |
| Gravação do retorno no Firebird | ✅ para `TB_EMPRESA.EXTERNALCODE` (⚠️ SÓ ela — ver Q1) | `un_send_to_web_server.pas:72-73,108-114` |
| Coluna EXTERNALCODE no Firebird | ✅ bootstrap `EnsureExternalCode` cria em `TB_EMPRESA` (⚠️ não em TB_COLABORADOR — Q1) | `un_dm.pas:412-419` |
| API valida CPF/CNPJ (dígito verificador, rejeita 111... etc.) | ✅ Zod `.refine(isValidCpf/isValidCnpj)` → 400 com campo | `fiscal.dto.ts:12-25`, `validators.ts:17-49` |
| Cliente | ✅ `/customer/sincronize` (Onda 4) com salesman/carrier por documento, entityTax | `endpoints/customer.ts` |
| Fornecedor | ✅ `/provider/sincronize` (Onda 4); mesmo CNPJ de cliente cai na MESMA entity (D3) | `endpoints/provider.ts` |
| Colaborador/Vendedor | ✅ `/salesman/sincronize` grava `tb_collaborator` SEMPRE + `tb_salesman` quando o bloco vem (precedência PADROES_BANCO §2); seed Seq 15 `TB_COLABORADOR/CLB_CODIGO` | `endpoints/salesman.ts:80-124`, `un_sincronia_seed.pas:110-113` |

## ⚠️ Gaps confirmados na varredura (viram as questões abaixo)

1. **Colaborador sem CPF não fecha o ciclo** (Q1): `TB_COLABORADOR` não tem coluna `EXTERNALCODE` (bootstrap só cria em TB_EMPRESA); `salesman_send_web.pas` NÃO envia externalCode (TODO explícito em :116-120); e `SaveExternalCode` grava SEMPRE em TB_EMPRESA — se a API devolvesse externalCode para um colaborador, o UPDATE cairia em `TB_EMPRESA WHERE EMP_CODIGO = CLB_CODIGO` (colisão de ids de tabelas diferentes).
2. **Validação de documento no Delphi está DESLIGADA** (Q2): `ValidaDocFiscal` com o corpo comentado (`Result := true` — "Retirada a validação pois estamos tratando documentos com numero invalidos") em customer/provider; só documento VAZIO ou a sentinela `'12345677654321'` viram `personType='N'`. Documento inválido (ex.: `111.111.111-11`) segue como F/J → API rejeita 400 → **registro encalha na fila para sempre** (reenvio infinito a cada ciclo de 5 min). As funções de dígito verificador JÁ EXISTEM (`UnFunctions.pas`: `CalculoCpf`, `CalculoCnpj` — rejeitam repetidos e vazio) mas não são chamadas no envio.
3. **personType do colaborador derivado errado** (correção objetiva, junto com Q2): `salesman_send_web.pas:81-87` — vazio→'N', 11 dígitos→'F', **qualquer outro tamanho→'J'**. CPF com lixo (10 ou 12 dígitos) vira "CNPJ" inválido → 400 → encalha.
4. **Transportadora NÃO sincroniza — e trava clientes** (Q4): não existe classe Delphi `TCarrierSendWeb` (só `ControllerTransportadora`/`tblCarrier` sem uso), não existe endpoint `/carrier/sincronize`, não existe linha no seed (37 classes), não existe INSERT em `tb_carrier` (a DDL MySQL existe). Consequência GRAVE: cliente com `carrierDocument` recebe **409 `CARRIER_NOT_SYNCED` eterno** — a auto-cura nunca resolve porque a transportadora nunca é enviada. Detalhe adicional: o 409 resolve por `findEntityIdByDocument`, que acha QUALQUER entity sem verificar o papel de transportadora.

## Workflow do processo (alvo, consolidado)

### Com documento (CPF/CNPJ válido)
1. Delphi valida dígito verificador ANTES de montar o payload (Q2)
2. Envia `personType='F'/'J'` + `person.cpf`/`company.cnpj` (sem máscara)
3. API resolve por documento DENTRO da transação:
   - existe em setes_central → atualiza (last-write-wins) + vincula papel no `setes_<schema>`
   - não existe → cria entity + cadeia + vincula papel
4. Retorno `{ok:true, id}` (sem externalCode)

### Sem documento (branco/nulo/INVÁLIDO — Q2)
1. Delphi envia `personType='N'` + `externalCode` SE já tiver (TB_EMPRESA.EXTERNALCODE ou TB_COLABORADOR.EXTERNALCODE — Q1)
2. API:
   - veio `externalCode` → busca `tb_no_doc.external_id`; achou → atualiza + vincula; NÃO achou → 404 `EXTERNAL_CODE_NOT_FOUND` (política: Q5)
   - sem `externalCode` → cria entity + `tb_no_doc` com UUID v4 novo
3. Retorno `{ok:true, id, externalCode}` — Delphi grava na tabela DA CLASSE (Q1):
   - Customer/Provider → `TB_EMPRESA.EXTERNALCODE` (WHERE EMP_CODIGO)
   - Salesman/Colaborador → `TB_COLABORADOR.EXTERNALCODE` (WHERE CLB_CODIGO)
4. **1º ciclo**: sem doc e sem externalCode → cria e devolve o código
   **2º ciclo**: sem doc com externalCode gravado → atualiza a MESMA entity (sem duplicar)

## Questões pendentes

**Nenhuma** (Rodada 1, 2026-07-25 — todas decididas pelo Valdo, ver seção de decisões).

## Fora de escopo desta revisão

- Sentido web → Firebird (GetSincronize) — fase própria (D16)
- Telas de cadastro Salesman/Carrier no app (Onda 2 da Fase 3 — decisão 11)
- Remoção da sentinela `'12345677654321'` do Gestão desktop (fase futura, ver Q3)

## Critérios de sucesso (esboço — fechar junto com as decisões)

1. Cliente/Fornecedor/Colaborador com CPF/CNPJ VÁLIDO → entity única reusada entre papéis (mesmo documento = mesmo id)
2. Cadastro com documento inválido/branco → entra como 'N', ganha externalCode, e o 2º ciclo ATUALIZA sem duplicar (teste obrigatório do roteiro de implantação)
3. Colaborador sem CPF → externalCode gravado em `TB_COLABORADOR.EXTERNALCODE` e reuso no 2º ciclo (se Q1=a)
4. Cliente com transportadora → sem 409 eterno (se Q4=a: carrier sincronizada antes, vínculo `tb_carrier_id` correto)
5. Nenhum registro encalhado na fila por 400 de documento (fila limpa após 2 ciclos)
6. 14+ testes da setes-sync verdes + smoke do ciclo completo

## Entregáveis EXECUTADOS (2026-07-25 — mesmo dia do fechamento)

| Entregável | Decisão | Onde |
|---|---|---|
| Endpoint `/carrier/sincronize` (grava tb_carrier, molde provider) + rota + @swagger | 4 | `setes-sync/src/modules/sync/endpoints/carrier.ts` |
| 409 por PAPEL no customer (`findRoleIdByDocument` → tb_salesman/tb_carrier) | 4 | `setes-sync/.../endpoints/customer.ts` |
| `DerivePersonType` na base (branco/sentinela/inválido → 'N'; 11 válidos → 'F'; 14 → 'J') | 2/3 | `sincronizador/classes/general_web.pas` |
| customer/provider/salesman usam DerivePersonType; `ValidaDocFiscal` morto removido | 2 | `classes/*_send_web.pas` |
| Write-back por classe: `ExternalCodeTable/KeyField` virtuais + `SaveExternalCode(pSendWeb)` | 1 | `general_web.pas` + `function/un_send_to_web_server.pas` |
| Bootstrap cria `TB_COLABORADOR.EXTERNALCODE` + índice | 1 | `un_dm.pas` (EnsureExternalCode) |
| salesman envia `externalCode` (TB_COLABORADOR) + override do write-back | 1 | `classes/salesman_send_web.pas` |
| `TCarrierSendWeb` (TB_TRANSPORTADORA, TRP_CODEMP=EMP_CODIGO) + RegisterClass + seed Seq 38 | 4 | `classes/carrier_send_web.pas`, `uMain.pas`, `function/un_sincronia_seed.pas` |
| Docs vivos: contrato /carrier + nota dos 409 por papel + linha 15b no MAPA + roteiro (ordem 12b/12c, count 38) | 4 | `CONTRATOS_SYNC.md`, `MAPA_INDEXACAO.md`, `roteiro-implantacao-cliente.md` |

**Validação**: `tsc --noEmit` limpo + 14/14 testes verdes na setes-sync. Delphi: aguarda compilação do Valdo.

**⚠️ Banco dev já semeado** (o seed só roda com a TB_LISTA_SINCRONIA vazia) — rodar uma vez no Firebird dev:

```sql
INSERT INTO TB_LISTA_SINCRONIA (WAY, DESC_TABELA, KIND, DESC_PROCESS, SEQ, DESC_FIELD, NOTE, SET_ON, CLASS_NAME, END_POINT)
VALUES ('E', 'TB_TRANSPORTADORA', 'CADASTRO', 'Transportadora (cadeia central + papel)', 38,
        'TRP_CODEMP', 'Decisao 4 (2026-07-25)', 'S', 'TCarrierSendWeb', '/carrier/sincronize');
```

(a coluna `TB_COLABORADOR.EXTERNALCODE` e a trigger `TG_SRC_TRANSPORTADORA` nascem sozinhas no próximo start, via bootstrap.)

## Decisões arquiteturais registradas (Valdo, 2026-07-25 — Rodada 1)

1. **(Q1) Colaborador fecha o ciclo do externalCode — frente completa**: bootstrap `EnsureExternalCode` cria também `TB_COLABORADOR.EXTERNALCODE VARCHAR(36)` + índice; `salesman_send_web` envia `externalCode` quando preenchido; `SaveExternalCode` grava na tabela/campo POR CLASSE (a classe informa o alvo do write-back — TB_EMPRESA/EMP_CODIGO por padrão, TB_COLABORADOR/CLB_CODIGO no salesman).
2. **(Q2) Documento inválido = sem documento**: validação de dígito verificador REATIVADA no envio (CalculoCpf/CalculoCnpj de UnFunctions); CPF/CNPJ branco ou inválido → `personType='N'` + fluxo externalCode. O documento inválido NÃO viaja (fica só no Firebird). Correção objetiva junto: derivação do personType no salesman (vazio/inválido→'N', 11 válidos→'F', 14 válidos→'J').
3. **(Q3) Sentinela `'12345677654321'` mantida como dupla proteção** na conversão explícita para 'N' (com a decisão 2 ela já cairia como inválida); remoção da sentinela do Gestão desktop fica para fase futura.
4. **(Q4) Transportadora — frente completa**: classe `TCarrierSendWeb` (molde provider, fonte TB_TRANSPORTADORA→TB_EMPRESA), endpoint `/carrier/sincronize` gravando `tb_carrier`, linha nova no seed (Seq 38, SET_ON='S', sincroniza junto dos papéis ANTES do customer), e os 409 do customer (`CARRIER_NOT_SYNCED` e também `SALESMAN_NOT_SYNCED`) passam a verificar o PAPEL no schema do cliente, não só a existência da entity.
5. **(Q5) 404 `EXTERNAL_CODE_NOT_FOUND` mantido explícito**: externalCode órfão = inconsistência real; intervenção manual (limpar EXTERNALCODE no Firebird) recria. Sem auto-cura silenciosa.
