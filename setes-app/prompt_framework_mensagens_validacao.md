# Prompt FECHADO — Framework de Mensagens, Alertas e Validação

**Origem**: rascunho do Valdo "Modelo de mensagem de Alerta e validação"
(2026-07-19), refinado em 3 rodadas no MESMO dia (método
refinar-prompt-arquitetura). Diagnóstico (Explore) + parecer conceitual
(agente setes-conceito, estreia) em `prompts/prompt_mensagens_validacao.md`
→ HISTORICO após implementação.
**Status**: decisões FECHADAS; implementação AGUARDA "vamos implementar".
**Escopo**: setes

## O conceito (parecer setes-conceito)

TRÊS conceitos com fatos geradores próprios: **Validação** (julgamento de
dado contra REGRA — nunca da tela), **Mensagem** (comunicação de um
DESFECHO; severidade é atributo, canal deriva da severidade em UM lugar) e
**Decisão** (pergunta com retorno tipado Sim/Não/Cancelar). A tela NUNCA
toca SnackBar/Dialog — entrega o desfecho ao apresentador; a regra "o dev
tem que lembrar" morre por construção. Natureza deriva do status HTTP:
400/409 = corrigível (fields[]); 401 = sessão; 5xx/rede = técnica (ref).

## Decisões (R1–R8 + derivadas — Valdo, 2026-07-19)

| # | Decisão |
|---|---|
| R1 | Sucesso = SnackBar (sem clique); dialog para validação/erro/decisão |
| R2 | Rastro do erro técnico em TABELA: `tb_crashlytics` REFORMADA e movida p/ **setes_central** (R2a) — +`ref` (código exibido ao usuário), +`code` (catálogo R8), +`status_code`, message = JSON {message, stack, payload}; AUTO_INCREMENT mantido como exceção documentada (log não pode falhar por corrida — registrar em PADROES_BANCO) |
| R3 | **Uma pendência por vez**: dialog com a 1ª pendência → OK → foco no campo; a próxima só no próximo salvar (usuários se perdem com validações múltiplas) |
| R4 | Decisão 3-way obrigatória na estrutura: `showSetesDecision → yes/no/cancel` — Sim gera uma ação, Não gera OUTRA, Cancelar = indeciso, nada acontece |
| R5 | Adoção em **onda ÚNICA e COMPLETA**; "não deixar nada para trás, gerando débito técnico". **AMPLIADA pelo Valdo (rodada 4)**: valida-se **TODAS as telas-UI do sistema** — não só as 6 artesanais. Cada tela passa pela MATRIZ DE CONFORMIDADE (canal via ponte; validação pelo engine quando cadastro; dialogs de entrada validando; uma pendência por vez; fields[] ancorado; decisão 3-way onde couber; i18n; zero SnackBar/Dialog direto) e é CORRIGIDA na onda |
| R6 | Garantia = catálogo-primeiro (tb_interface_has_field no seed + DTO Zod são as DUAS fontes) + skill obrigatória `mensagem-e-validacao.md` + agente setes-form-builder ATUALIZADO (lê o catálogo, gera validators/FieldConfigLoader/ponte; PROIBIDO SnackBar/Dialog direto) |
| R7 | SEM campo de severidade no JSON (status HTTP discrimina por construção) |
| R8 | Catálogo de erros conhecidos HÍBRIDO: fonte = `shared/errors/error-codes.ts` (código+descrição+i18n nascem no commit do throw) + tabela de REFERÊNCIA `setes_central.tb_error_catalog` GERADA por `npm run errors:gen` (padrão fields:gen; nunca editada à mão) p/ joins SQL com a crashlytics; envelope vira `{error, code?, ref?, fields[]}` |

## As 6 peças (4 existem, 3 nascem/reformam)

| Peça | Status | Onde |
|---|---|---|
| A. Contrato `{error, code?, ref?, fields[]}` | EXISTE (+code/ref) | http-error/controller-utils |
| B. Rastro: tb_crashlytics central + error-codes.ts + errors:gen | REFORMA/NASCE | shared/errors + sql/01 |
| C. Regras shared (setes_validators × shared/validation × catálogo Fase 2) | EXISTE | packages + shared |
| D. Failure (+supportRef/code; defaults via i18n) | EXISTE (+ajustes) | packages/core |
| E. Apresentador `showSetesMessage(kind)` + `showSetesDecision` | NASCE | setes_widgets |
| F. Ponte desfecho→apresentação (tela nunca escreve feedback) | NASCE | app/shared/feedback + fábrica |

## Plano de ondas (executar após o "vamos implementar")

1. **Onda A — Fundação**: peças B+E+F; API: error-codes.ts + errors:gen +
   tb_error_catalog + tb_crashlytics central (migration derruba a local do
   baseline) + handleError grava crash com ref/code; app: apresentador +
   ponte + Failure ajustada (defaults i18n); skill mensagem-e-validacao.md
   + atualização do setes-form-builder; PADROES_BANCO (exceção AI).
2. **Onda B — Adoção completa em TODAS as telas-UI (R5 ampliada)**:
   MATRIZ DE CONFORMIDADE tela a tela (inventário abaixo) + correção de
   tudo na onda. Grupos: (a) artesanais — contracts, bank_accounts,
   service_orders, settlements, payment_types, aba parceria: canal +
   Form/validators/FieldConfigLoader + fields[] no campo;
   (b) canônicas — countries, states, cities, cfop, privileges, users,
   interfaces: já têm engine; trocar listener pela ponte + uma pendência
   por vez + fields[] ancorado + auditar completude dos validators;
   (c) compostas — customers/collaborators/institutions (abas da cadeia
   fiscal: principal, endereços, fones, redes, e-mail?, tributação,
   interfaces, usuários, privilégios, parceria) e árvores categories/
   financial_plans: auditar cada ABA e cada dialog de entrada;
   (d) processos — service_orders (dialogs de item/rotina/faturar) e
   settlements (dialogs de baixa/estorno/filtros);
   (e) painéis e infra — interface_fields, interface_configs, theme,
   auth (login, escolha de institution, recuperação/troca de senha),
   home/menu (erros de carga de menu);
   (f) dialogs compartilhados — endereço/fone/rede social/lookup.
   API: assertClientRequired nos 5 módulos sem ele; erros de todos os
   módulos com code do catálogo. ENTREGÁVEL: a matriz preenchida
   (tela × itens do checklist × status) anexada ao doc da entrega.
3. **Onda C — Varredura**: 409s padronizados com code+fields, mensagens
   do core no i18n, smoke E2E, docs/INDICE/memória.

## Notas da IMPLEMENTAÇÃO (Ondas A–C EXECUTADAS em 2026-07-19)

**Onda A**: contrato `{error, code?, ref?, fields[]}` no handleError/parseBody;
tb_crashlytics reformada na CENTRAL (migration 017 derrubou a local) com
gravação fire-and-safe + ref exibido ao usuário; error-codes.ts (20 códigos)
+ `npm run errors:gen` → tb_error_catalog; apresentador
`showSetesMessage`/`showSetesDecision` no design system; ponte
`app/shared/feedback/feedback.dart`; fábrica com uma-pendência-por-vez +
`showServerFieldError`; Failure.code/supportRef + defaults i18n; skill
`mensagem-e-validacao.md` + setes-form-builder atualizado + exceção AI no
PADROES_BANCO. **Peças extraídas na onda**: `form_pendency.dart`
(PendencyField/ensureNoPendency/showServerFieldFeedback, com `beforeFocus`
p/ troca de aba) e `field_config_of.dart` (merge manual do catálogo).

**Onda B (6 grupos de agentes em paralelo)**: TODAS as telas-UI conformes —
matriz consolidada abaixo. Padrões estabelecidos: bloc `*ActionFailure`
carrega o Failure INTEIRO; DUP_ROLE decidido por `failure.code` (nunca por
string); forms compostos trocam de ABA antes do foco da pendência; página
de PACKAGE (theme/auth do core) usa o apresentador diretamente (espelho da
ponte em `auth_feedback.dart`); dialogs de ENTRADA são permitidos, mas
validam uma-pendência internamente.

**Onda C**: codes nos erros conhecidos dos módulos (DUP_DOCUMENT, DUP_ROLE,
CONFLICT_RETRY, ROLE_MISSING, ORDER_*, TITLE/BANK/REVERSAL, RATE_SUM,
REQUIRED_FIELDS, VALIDATION_FAILED); assertClientRequired nos 5 módulos
que faltavam (14/14 módulos de negócio); smoke E2E do fluxo de erro (409
com code ✓; ref gravado e JOIN com o catálogo ✓). 134/134 testes API;
analyze ZERO issues; **zero `ScaffoldMessenger.showSnackBar` vivo** em
apps/web (só o apresentador — verificado por grep).

### MATRIZ DE CONFORMIDADE (tela × checklist — tudo ✅ em 2026-07-19)

Colunas: ponte · engine/validators · uma-pendência · fields[] ancorado ·
decisão 3-way · i18n · zero-feedback-direto.

| Grupo | Telas (todas ✅ nas 7 colunas) |
|---|---|
| Canônicas | countries (piloto), states, cities, cfop, privileges, interfaces (+seção Configurações), users (+abas Estabelecimentos/Privilégios) |
| Artesanais | payment_types, contracts (+dialog de item), bank_accounts (com MÁSCARA do cliente) |
| Processos | service_orders (lista/detalhe/dialogs item-rotina-faturamento), settlements (3 abas + dialogs baixa/estorno/filtros) |
| Compostas | customers (7 abas, DUP_ROLE por code→askDecision, prefill→askDecision), collaborators (5 abas), institutions (7 abas + Interfaces/Usuários autônomas) |
| Árvores/Painéis | categories, financial_plans, interface_fields, interface_configs, theme (apresentador direto — package) |
| Infra | login, escolha de institution, recovery, change password, home/menu, dialogs shared (endereço/fone/rede), lookup |

Ressalvas registradas (não-funcionais): helper de pendência de dialog
duplicado (privado) em service_orders/settlements — candidato a promoção
p/ form_pendency; lookup em queda de rede mostra a chave core.errors.*
crua (fronteira sem-easy_localization do design system); theme/auth sem
Failure completo no cubit (fora do escopo — natureza julgada local).

### Correção pós-onda (2026-07-31) — "Validação falhou" genérico

Bug real no cadastro de Estabelecimento: o Zod de DTOs COMPOSTOS (cadeia
fiscal) devolve `fields[]` com paths ANINHADOS (`entity.nameCompany`,
`person.cpf`, `company.cnpj`, `addresses.0.zipCode`) enquanto as telas
declaram names PLANOS — só `schemaName` ancorava; todo o resto caía no
fallback genérico "Validação falhou" (violando o próprio checklist da
skill). Além disso as mensagens default do Zod eram técnicas e em inglês.
Três correções:

1. **API — error map global PT-BR**: `src/shared/validation/zod-pt.ts`
   (importado por efeito no app.ts) traduz os issues comuns do Zod para
   mensagens objetivas ("Campo obrigatório", "Informe no máximo N
   caracteres", "Valor deve ser maior que 0"...). Mensagem explícita no
   DTO tem precedência; datas ganharam mensagem própria (AAAA-MM-DD).
2. **App — ancoragem tolerante**: `matchesServerFieldPath` (form_pendency)
   casa o name do campo com o path exato OU com o ÚLTIMO segmento —
   usada no showServerFieldFeedback (híbridos) e no showServerFieldError
   da fábrica.
3. **App — fallback nunca genérico**: fields[] presente sem campo na tela
   → dialog `feedback.serverField` = "Campo \"X\": mensagem" (i18n pt/en),
   em vez de mostrar só o `error` do envelope.

## Diagnóstico de referência (2026-07-19)

49 SnackBars default em 26 arquivos; 0 componentes de feedback; 40+
`_warn()` manuais nas telas novas; fields[] da API descartado pelo app;
500 irrastreável; assertClientRequired em 9 de 14 módulos; mensagens PT
cruas do backend na tela. Detalhes no prompt de trabalho (HISTORICO).
