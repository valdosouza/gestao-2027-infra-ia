# Prompt em otimização — Modelo de Mensagem, Alerta e Validação

**Origem**: rascunho do Valdo `Modelo de mensagem de Alera e validacao.md`
(nesta pasta). **Status**: RODADA 1 ABERTA (avaliação feita em 2026-07-19;
NADA implementado — ordem expressa do Valdo: avaliar tudo antes).
**Escopo**: setes

---

## 1. Diagnóstico do estado atual (levantamento Explore, 2026-07-19)

O diagnóstico do Valdo ("fraco/amador") está CORRETO, e com um agravante
honesto: as telas mais novas (Ondas 2–6 do Software House) são as maiores
devedoras.

- **Canal de mensagem**: 49 SnackBars em 26 arquivos, 100% com
  comportamento default (~4s, sem ação) — o "banner sutil que some".
  ZERO componente de feedback no design system (não existe SetesAlert).
  Dialogs existem só para confirmações/entrada.
- **Dois padrões de formulário concorrentes**: 7 módulos canônicos usam
  RegisterFormPage (Form + setes_validators + field-config); as telas
  novas (contracts 12, service_orders 11, settlements 10, bank_accounts 7
  `_warn()`s) validam com ifs manuais + SnackBar, SEM Form, SEM engine da
  Fase 2 — a obrigatoriedade configurada pelo cliente NÃO se aplica nelas.
- **`{error, fields[]}` produzido pela API e DESCARTADO pelo app**: o erro
  nunca volta ao campo; `Failure.fieldMessage` só é usado p/ extrair o id
  do 409 de papel duplicado.
- **Mensagem PT do backend exibida CRUA** (failure.message → SnackBar sem
  i18n); defaults do Failure em PT hardcoded no core.
- **Suporte às cegas**: 500 = `{error:'Erro interno'}` sem requestId/
  código de rastro — irrastreável (grep: 0 ocorrências de correlação).
- **assertClientRequired**: 9 módulos usam; contracts/bank-accounts/
  service-orders/settlements/payment-types/customers NÃO. 409 de
  duplicidade inconsistente entre módulos (uns com fields, outros sem;
  service-orders/settlements com regra no repository).

## 2. Parecer conceitual (setes-conceito, 2026-07-19)

TRÊS conceitos com fatos geradores distintos: **Validação** (julgamento de
dado contra regra — nasce da REGRA), **Mensagem** (comunicação de um
desfecho — nasce do DESFECHO; SEVERIDADE é atributo dela e o CANAL deriva
da severidade em UM lugar) e **Decisão** (pergunta que devolve escolha
tipada Sim/Não/Cancelar — peça separada, mão dupla).

Teste da maquete: o desenho atual reprova — a severidade só existe na
cabeça de quem escreveu a tela, e a regra implícita "o dev tem que lembrar
de validar" existe só para a estrutura não se contradizer. Ela morre por
construção quando a tela NUNCA toca SnackBar/Dialog — só entrega o
desfecho a um apresentador único.

**6 peças, 4 já existem**:
| Peça | Status | Onde |
|---|---|---|
| A. Contrato de desfecho `{error, fields[]}` + status HTTP | EXISTE | http-error/controller-utils |
| B. Rastro do erro técnico (`ref` no 500, logado, exibido p/ suporte) | NASCE | handleError |
| C. Regras shared (setes_validators × shared/validation × catálogo Fase 2) | EXISTE (subutilizada) | packages + shared |
| D. Failure com fields[] (+ supportRef) | EXISTE | packages/core |
| E. **Apresentador**: `showSetesMessage(kind: success/info/validation/error)` + `showSetesDecision → yes/no/cancel` | NASCE (o coração) | setes_widgets |
| F. Ponte desfecho→apresentação (a página nunca escreve feedback) | NASCE | app/shared/feedback + fábrica |

Natureza deriva do status por construção: 400/409 = validação corrigível
(fields[]); 401 = sessão; 5xx/rede = técnica (ref). NÃO entra: tabela de
mensagens, catálogo por cliente, campo de severidade no JSON, matar o
SnackBar (vira canal exclusivo de sucesso).

## 3. RODADA 1 — decisões do Valdo (com recomendação)

| # | Questão | Recomendação |
|---|---|---|
| R1 | Sucesso: SnackBar ou dialog? | SnackBar (fluxo feliz sem clique); dialog p/ validação/erro/decisão |
| R2 | Erro técnico ganha código de rastro (`ref` no 500 + log)? | Sim; sem tabela por ora |
| R3 | Dialog de validação lista as pendências ou só foca o campo? | Dialog OK listando + inline nos campos + foco no 1º inválido |
| R4 | Decisão Sim/Não/Cancelar é peça separada da mensagem? | Sim (`showSetesDecision`, retorno tipado) |
| R5 | Adoção retroativa nas telas novas | Onda curta SÓ do canal (mecânica); engine Fase 2 conforme tela for tocada |
| R6 | Garantia: skill obrigatória `mensagem-e-validacao.md` (status do revisar-ddl), citada nas skills de tela; agente só se o drift persistir | Skill agora; agente depois se precisar |
| R7 | Campo de severidade no envelope JSON? | NÃO (status já discrimina; redundância contradiz) |
| R8 | Mensagens de NEGÓCIO do backend (PT hardcoded) exibidas no dialog | Aceitar PT por ora (produto é PT-BR); catálogo por código de erro = peça futura que AGREGA |

## 4. RODADA 1 — respostas do Valdo (2026-07-19)

| # | Decisão |
|---|---|
| R1 | ✅ Sucesso = SnackBar; dialog p/ validação/erro/decisão |
| R2 | ✅ REVISADA: rastro em TABELA — reusar/melhorar a `tb_crashlytics` do baseline ("log na tabela é melhor"); avaliar melhorias na estrutura |
| R3 | ✅ REVISADA: **foca SÓ no campo** — usuários têm problema com múltiplas validações simultâneas (uma pendência por vez) |
| R4 | ✅ Estrutura DEVE prever Sim/Não/Cancelar — há casos em que Sim gera uma ação, Não gera OUTRA ação, e o usuário indeciso precisa do Cancelar |
| R5 | ⏳ Pediu explicação melhor (respondida na rodada 2) |
| R6 | ⏳ Discussão aberta: o AGENTE que cria telas precisa SABER as validações para já criar certo (proposta na rodada 2) |
| R7 | ✅ Sem campo de severidade no JSON |
| R8 | ✅ REVISADA: **catálogo de erros conhecidos AGORA** (não futuro) — ajuda análise junto com a tb_crashlytics |

## 5. RODADA 2 — respostas do Valdo (2026-07-19)

- **R2a** ✅: tb_crashlytics vai para a **setes_central** (suporte enxerga
  todos os clientes numa consulta). AUTO_INCREMENT mantido como exceção
  documentada (recomendação sem objeção — log não pode falhar por corrida).
- **R3a** ✅ (consequência direta da R3, sem objeção): uma pendência por
  vez — dialog com a 1ª pendência → OK → foco no campo; a próxima aparece
  no próximo salvar.
- **R5** ✅: **PRIMEIRA ONDA COMPLETA — "não deixar nada para trás,
  gerando débito técnico"**: canal novo + engine da Fase 2 nas 6 telas
  artesanais na MESMA onda de adoção.
- **R6** ✅ (proposta sem objeção): catálogo-primeiro + skill obrigatória
  `mensagem-e-validacao.md` + setes-form-builder ATUALIZADO para ler o
  catálogo e gerar validators/FieldConfigLoader/ponte (proibido SnackBar
  direto).
- **R8** ⏳: Valdo pediu mais conversa — não entendeu "tabela criaria
  sincronização de deploy sem ganho". Explicação + proposta HÍBRIDA na
  rodada 3: arquivo como fonte (código e erro nascem no mesmo commit) +
  tabela de REFERÊNCIA derivada automaticamente por gerador (padrão
  fields:gen) para os joins SQL com a crashlytics.

## 6. Rodada 2 — material original (análises)

- **R2a**: tb_crashlytytics hoje: por schema, PK (id,institution) com
  AUTO_INCREMENT (única do produto), origen varchar(100), message blob.
  Melhorias propostas: +`ref` (código de rastro exibido ao usuário),
  +`code` (catálogo R8), +`status_code`, message guarda JSON
  {message, stack, payload}; KEY created_at. Questões: (a) mantém no
  SCHEMA do cliente ou sobe p/ setes_central (suporte enxerga todos os
  clientes numa consulta — recomendo CENTRAL)? (b) AUTO_INCREMENT vira
  exceção documentada do padrão (log não pode falhar por corrida de
  MAX+1 — recomendo manter AI e registrar em PADROES_BANCO)?
- **R3a**: desenho "uma pendência por vez": no salvar, a 1ª pendência
  vira dialog OK → foco no campo (inline marca só ele); corrigiu → salvar
  de novo mostra a próxima. Confirmar.
- **R5 (explicação)**: duas frentes distintas — (i) trocar o CANAL
  (SnackBar de erro → apresentador) nas telas existentes é mecânico e
  rápido (1 onda curta cobre tudo); (ii) adotar o ENGINE da Fase 2
  (Form + catálogo de campos + assertClientRequired) nas 6 telas
  artesanais é reescrita de form POR TELA (trabalho grande). Recomendo:
  onda única para (i); (ii) por tela conforme forem tocadas — OU uma onda
  dedicada se o Valdo priorizar. Decidir.
- **R6 (proposta)**: não é agente novo — é dar OLHOS ao executor:
  (a) workflow "catálogo primeiro" (toda tela nova já nasce com seu
  tb_interface_has_field no seed + DTO Zod — as DUAS fontes da validação);
  (b) skill `mensagem-e-validacao.md` obrigatória; (c) ATUALIZAR o agente
  setes-form-builder para LER o catálogo da interface e gerar os
  validators + FieldConfigLoader + ponte de feedback (nunca SnackBar
  direto). setes-conceito guarda o conceito; form-builder executa com
  validação nativa. Confirmar.
- **R8a**: catálogo de erros como ARQUIVO compartilhado
  (shared/errors/error-codes.ts — código estável por erro conhecido,
  ex.: DUP_DOCUMENT, ORDER_INVOICED, RATE_SUM_EXCEEDED) gravado no
  envelope `{error, code, ref?, fields[]}` e na coluna `code` da
  crashlytics (agregação SQL). Alternativa: tabela-catálogo central.
  Recomendo ARQUIVO (nasce e evolui com o build, como DTO). Decidir.
