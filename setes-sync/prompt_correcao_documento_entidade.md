# Prompt — Correção de documento (graduação do sem-doc): manter tb_entity.id

**Escopo**: setes
**Origem**: rascunho do Valdo (2026-07-25) + análise do código
**Status**: FECHADO na Rodada 1 (2026-07-25) — 4 decisões registradas; em execução
**Pai**: `Infra-IA/setes-sync/prompt_revisao_processo_atualiza_entidade.md` (5 decisões) + D3/D4 da revisão do sync

---

## Contexto

Registros de Cliente/Fornecedor/Transportadora/Colaborador que sincronizaram SEM documento
(`personType='N'`, com `EXTERNALCODE` gravado no Firebird) podem ser corrigidos no Gestão
desktop, passando a ter CPF/CNPJ válido.

**Objetivo**: ao corrigir, a entity na web MANTÉM o mesmo `tb_entity.id` (histórico de vendas
e financeiro preservado) — o documento "gradua" a entity de `tb_no_doc` para
`tb_person`/`tb_company`.

## Estado atual do código (por que hoje NÃO funciona)

- `saveSyncEntity` (sync.entity.ts) só consulta `externalCode` quando `personType='N'`.
  Com documento válido o payload vira F/J e o motor resolve SÓ por documento: não achando,
  **cria entity nova** → o papel migra para a entity nova e o histórico fica na antiga (racha).
- O Delphi já envia `externalCode` SEMPRE que preenchido (mesmo com F/J) — o payload da
  graduação já chega completo hoje; falta o servidor tratá-lo.
- O `upsertFiscal` já tem o **toggle triplo**: gravar `tb_person`/`tb_company` numa entity
  soft-deleta as outras especializações (incl. `tb_no_doc`) — a graduação reusa esse mecanismo.

## Workflow da correção (alvo)

Endpoint recebe payload com **CPF/CNPJ preenchido** (Delphi já validou dígito — decisão 2 do
prompt pai) **E `externalCode` preenchido**:

| Caso | Documento já existe? | externalCode resolve? | Ação |
|---|---|---|---|
| **A. Graduação** | NÃO | SIM (tb_no_doc → entity E1) | Grava `tb_person`/`tb_company` na E1 (toggle soft-deleta `tb_no_doc`), atualiza cadeia (last-write-wins), papel segue em E1. Retorna sinal de LIMPAR externalCode (⚠️ Q1) — o Sincronizador limpa `TB_EMPRESA/TB_COLABORADOR.EXTERNALCODE` |
| **B. Regravação pós-graduação** | SIM, na MESMA entity E1 | SIM (aponta E1) ou órfão | Idempotente: update normal por documento + sinal de limpar (o Firebird ainda não limpou) |
| **C. Conflito** | SIM, em OUTRA entity E2 | SIM (aponta E1) | NUNCA mescla: segue atualizando E1 como sem-doc (documento NÃO é gravado), registra CONFLITO para ação manual (⚠️ Q2) |
| **D1. Órfão, doc livre** | NÃO | NÃO (não existe em tb_no_doc) | Segue por documento (cria/atualiza) + sinal de limpar + warning (decisão 3) |
| **D2. Órfão, doc ocupado** | SIM (outra entity) | NÃO | CONFLITO manual: registra em tb_sync_conflict + 409 `EXTERNAL_CODE_ORPHAN` — nada é gravado (refinamento do Valdo na decisão 3) |

Sem externalCode no payload → fluxo normal já implementado (nada muda).
`tb_no_doc` na graduação: **soft delete** (`deleted='S'`, padrão do toggle já existente —
`external_id` preservado para auditoria). Correção objetiva, não questão.

### Lado Sincronizador (Delphi)

- Ao receber o sinal de limpar: `UPDATE <tabela-da-classe> SET EXTERNALCODE = NULL WHERE <chave> = :codigo`
  (usa o mesmo alvo por classe da decisão 1 do prompt pai: TB_EMPRESA×TB_COLABORADOR).
- Próximos ciclos: payload sai só com o documento — índice definitivo.

## ⚠️ Importante — impedir CPF/CNPJ "roubado" (histórico de terceiros)

Ameaça: alguém digita o CPF real de uma pessoa X no cadastro de outra pessoa Y.

**Proteções que o DESENHO já dá (sem consulta externa):**
1. A graduação só acontece via `externalCode` — que só o registro legítimo do Firebird possui.
   Nunca há mesclagem automática de entities: o caso C (doc já pertence a outra entity) SEMPRE
   vira ação manual. **Roubar o histórico de OUTRA entity é impossível por construção.**
2. Dígito verificador validado nas duas pontas (Delphi + Zod).

**O que NÃO é coberto sem consulta externa:** doc válido de terceiro que ainda NÃO existe na
base (caso A) — a entity ganha um documento que pertence a outra pessoa no mundo real, mas o
dano fica confinado à própria entity (o histórico dela, não o de terceiros).

**Opções de verificação governamental (⚠️ Q4):**
- **CNPJ**: consulta pública gratuita (BrasilAPI `/cnpj/v1/` ou ReceitaWS) → comparar razão
  social retornada com `nameCompany` (similaridade normalizada); divergência → conflito manual.
- **CPF**: NÃO existe consulta pública gratuita (privacidade); Serpro "Consulta CPF" é pago e
  exige contrato. Alternativa parcial: e-Social/SEFAZ com certificado digital (complexo).

## Questões pendentes

**Nenhuma** (Rodada 1, 2026-07-25 — decididas pelo Valdo, ver seção de decisões).

## Fora de escopo

- Mesclagem manual de entities conflitantes (ferramenta administrativa futura)
- Tela de fila de conflitos no Super (se Q2=a, a tabela nasce preparada)
- Verificação governamental (se Q4=a — desenho registrado acima)

## Critérios de sucesso (esboço)

1. Sem-doc corrigido → mesma `tb_entity.id` antes/depois; pedidos/financeiro/notas da entity intactos
2. `tb_no_doc` soft-deletada; `tb_person`/`tb_company` criada com o documento
3. Firebird limpo: EXTERNALCODE = NULL após o ciclo da correção; ciclo seguinte indexa por documento
4. Documento de OUTRA entity → nada muda nas duas entities + conflito registrado
5. Reenvio (idempotência): repetir o payload da graduação não duplica nem erra
6. Testes cobrindo os casos A/B/C/D + smoke do ciclo completo

## Entregáveis EXECUTADOS (2026-07-25 — mesmo dia do fechamento)

| Entregável | Decisão | Onde |
|---|---|---|
| Graduação no motor: casos A/B/C/D1/D2 (B detecta tb_no_doc soft-deletada da mesma entity) | 1/2/3 | `setes-sync/src/modules/sync/sync.entity.ts` (saveSyncEntity) |
| `clearExternalCode` no envelope (`syncSuccess`) + repasse nos 4 endpoints de entidade | 1 | `sync.response.ts`, `endpoints/{customer,provider,carrier,salesman}.ts` |
| `tb_sync_conflict` central com dedupe (INSERT via pool — sobrevive ao rollback do 409) | 2 | `sql/01_setes_central_ddl.sql` + criada no MySQL dev |
| 409 `EXTERNAL_CODE_ORPHAN` (órfão + documento ocupado — nada gravado) | 3 | `sync.entity.ts` |
| Delphi: property `ClearExternalCode` (ParseRetornoEnvelope) + `ClearExternalCode()` limpa a tabela da classe | 1 | `general_web.pas`, `un_send_to_web_server.pas` |
| Docs: envelope + seção "Graduação do sem-doc" no CONTRATOS_SYNC; swagger dos 4 endpoints | — | `CONTRATOS_SYNC.md` |
| 5 testes novos (A, B, C, D1, D2) | — | `src/__tests__/sync.entity.test.ts` |

**Validação**: `tsc --noEmit` limpo + **19/19 testes verdes** (14 anteriores + 5 da graduação).
Delphi: aguarda compilação do Valdo. Verificação governamental: fase futura (decisão 4).

## Decisões arquiteturais registradas (Valdo, 2026-07-25 — Rodada 1)

1. **(Q1) Sinal de limpar = campo explícito `clearExternalCode:true`** no envelope de sucesso.
   Delphi ganha a property `ClearExternalCode` no ParseRetornoEnvelope e limpa
   (`UPDATE ... SET EXTERNALCODE = NULL`) na tabela/campo da classe (write-back da decisão 1
   do prompt pai).
2. **(Q2) Conflitos em tabela central** `setes_central.tb_sync_conflict` (institution, documento,
   external_code, entity do doc × entity do externalCode, origem/endpoint, resolved 'S'/'N') com
   dedupe por UNIQUE — fila consultável de ação manual (futura tela no Super) + log estruturado.
3. **(Q3, com refinamento do Valdo) Órfão com documento válido**: segue o fluxo por documento
   + sinal de limpar + warning **SOMENTE se o documento ainda não existir na setes_central**
   (caso D1). Se o documento já pertencer a outra entity (caso D2): conflito manual registrado
   + 409 `EXTERNAL_CODE_ORPHAN` — nada é gravado automaticamente.
4. **(Q4) Verificação governamental = fase futura registrada**: CNPJ via BrasilAPI/ReceitaWS
   comparando razão social; CPF apenas com Serpro (pago). Não entra agora — a proteção do
   histórico de terceiros já está garantida pelo desenho (graduação só via externalCode do
   próprio registro; conflito nunca mescla).
