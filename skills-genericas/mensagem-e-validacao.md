# Skill: Mensagem e Validação (OBRIGATÓRIA em toda tela e endpoint)

**Quando usar**: SEMPRE que criar/alterar tela-UI ou endpoint — mesmo
status do `revisar-ddl` (DDL) e do `guardiao-conceitual` (conceito).
**Origem**: Framework de Mensagens, Alertas e Validação
(`setes-app/prompt_framework_mensagens_validacao.md` — decisões R1–R8 do
Valdo, 2026-07-19). O conceito: **Validação** julga dado contra REGRA;
**Mensagem** comunica um DESFECHO (severidade → canal em UM lugar);
**Decisão** pergunta e devolve escolha tipada. A tela NUNCA fala sozinha.
**Escopo**: misto

---

## As 6 peças (usar, nunca recriar)

| Peça | Onde |
|---|---|
| Contrato `{error, code?, ref?, fields[]}` | API `@shared/errors` + `controller-utils` |
| Catálogo de erros (fonte) + tabela derivada | `shared/errors/error-codes.ts` + `npm run errors:gen` |
| Rastro técnico | `setes_central.tb_crashlytics` (ref exibido ao usuário) |
| Regras shared | `setes_validators` (app) × `src/shared/validation` (API) × catálogo `tb_interface_has_field` |
| Apresentador | `setes_widgets`: `showSetesMessage(kind)` + `showSetesDecision` |
| Ponte | `app/shared/feedback/` — ÚNICO caminho de feedback das telas |

## Checklist — LADO APP (tela)

- [ ] **PROIBIDO** `ScaffoldMessenger`/`showSnackBar`/`AlertDialog` direto
      na tela — todo feedback via ponte (`showSuccessFeedback`,
      `showFailureFeedback`, `showValidationFeedback`, `askDecision`).
- [ ] Sucesso = SnackBar (R1, via ponte); validação/erro = DIALOG com OK.
- [ ] **UMA pendência por vez** (R3): 1ª pendência → dialog → foco no
      campo; nunca a tela inteira vermelha.
- [ ] Confirmações/decisões via `askDecision` (Sim/Não/Cancelar tipado —
      R4; Cancelar SEMPRE possível quando Sim e Não geram ações distintas).
- [ ] Cadastro usa a fábrica (Form + `setes_validators` +
      `FieldConfigLoader`) — catálogo do cliente aplicado; telas de
      processo validam seus DIALOGS de ação com os mesmos validators.
- [ ] `fields[]` do backend ANCORADO no campo (`showServerFieldError` da
      fábrica ou equivalente) — nunca só a mensagem genérica.
- [ ] Textos por i18n pt/en; mensagem PT do backend passa intacta pela
      ponte (`.tr()` em chave inexistente devolve a própria string).

## Checklist — LADO API (endpoint)

- [ ] Toda rejeição = `HttpError(status, msg, fields?, code?)` — NUNCA
      `res.json` manual de erro; controller usa `handleError`/`parseBody`.
- [ ] Erro CONHECIDO leva `code` do `error-codes.ts` (código novo = criar
      no MESMO commit do throw + rodar `npm run errors:gen` na entrega).
- [ ] Erro por campo SEMPRE com `fields[]` (decisão 20 Fase 2) — inclusive
      409 de duplicidade.
- [ ] Cadastro chama `assertClientRequired(moduleKey, body)` no service
      (obrigatórios configurados pelo cliente).
- [ ] Regra de negócio no SERVICE (404/409); repository lança apenas o que
      exige transação (lock de estado).
- [ ] 500 nunca tratado na mão — `handleError` gera `ref` + grava
      `tb_crashlytics` sozinho.

## Workflow "catálogo primeiro" (R6)

Tela nova nasce NESTA ordem: (1) seed com `tb_interface_has_field` da
interface (as regras técnicas de required/kind/mask); (2) DTO Zod na API
(baseline técnico); (3) SÓ ENTÃO a tela — o agente setes-form-builder LÊ o
catálogo e gera os validators correspondentes. As DUAS fontes da validação
são o catálogo e o DTO; nada nasce na cabeça do dev.

## Entregável por tela: linha na MATRIZ DE CONFORMIDADE

`tela × [ponte | engine/validators | uma-pendência | fields[] ancorado |
decisão 3-way | i18n | zero-feedback-direto] × status` — anexada ao doc da
entrega (padrão criado na Onda B do framework).
