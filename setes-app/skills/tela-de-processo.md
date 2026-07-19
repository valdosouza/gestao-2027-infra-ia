# Skill: Tela de Processo (3º tipo de tela do produto)

**Quando usar**: ao criar/alterar telas que ORQUESTRAM um fluxo de negócio
(ordem que muda de estado, rotinas com relatório, ações transacionais),
em vez de manter um cadastro. 1º caso real: **Ordens de Serviço /
ciclo mensal** (módulos `service-orders` na API × `service_orders` no app,
Onda 4 do Módulo Software House, 2026-07-19).
**Tipos anteriores**: lista+form (fábrica Register*) e árvore
(SetesTreeView) — ver `criar-formulario-cadastro.md`.

---

## O que muda em relação a um cadastro

| Cadastro (lista+form/árvore) | Processo |
|---|---|
| CRUD sobre uma tabela | Transições de ESTADO sobre o backbone (`tb_order.status` — DP7) |
| Salvar = upsert | Ações nomeadas: abrir, incluir item, faturar, cancelar, rotina |
| Form com campos | Detalhe com sub-recursos + dialogs de ação |
| Validação por campo | Regras de máquina de estados (409 quando o estado não permite) |

## Padrões obrigatórios — API

1. **1 interface = 1 módulo** (6 arquivos) — igual cadastro; a diferença é
   o SHAPE das rotas: sub-recursos e ações POST nomeadas:
   `POST /api/<m>` (abrir) · `POST /api/<m>/:id/items` · `PUT/DELETE
   /api/<m>/:id/items/:itemId` · `POST /api/<m>/:id/<acao>` (ex.:
   /invoice) · `POST /api/<m>/<rotina>` (ex.: /monthly-run) ·
   `GET /api/<m>/<sugestao>` (defaults de tela — ex.:
   /expiration-suggestion).
2. **Máquina de estados no repositório**: helper `lockOpenOrder`-like — o
   registro-alvo é lido `FOR UPDATE` e o estado é validado ANTES de
   qualquer escrita; estado errado = **409** com mensagem de negócio (o
   app só exibe). Toda ação é transação única.
3. **Travas de unicidade**: coluna mantida pela APLICAÇÃO na MESMA
   transação da transição (ex.: `open_lock` — D5/DP7; coluna GERADA não
   cruza tabelas) + UNIQUE como rede da corrida; pré-checagem para
   devolver 409 amigável.
4. **Cálculos de negócio em funções PURAS** (`<m>.calc.ts`) com testes
   jest próprios — pró-rata, quotas de parcela, sugestões de data. Regra
   DP1: sugestão de data é DEFAULT de tela; quem decide é o usuário
   (a API não impõe).
5. **Rotinas em lote**: transação POR ITEM DO LOTE (cliente a cliente —
   falha de um não derruba o lote), IDEMPOTENTES por competência, e
   devolvem RELATÓRIO `{ processed, opened, injected, skipped, errors[] }`
   — nunca um ok seco (mentalidade ERP: nada silencioso).
6. **Totalizadores derivados** (`tb_order_totalizer`): recalculados no
   SERVIDOR a cada mudança de item — o app nunca soma por conta própria.

## Padrões obrigatórios — app (Flutter)

1. Módulo completo (domain/data/presentation + bloc) como cadastro; o
   BLOC ganha estados de PROCESSO: lista por status (abas), detalhe,
   execução de ação (saving) e one-shots de sucesso/erro — a mensagem dos
   409 de negócio vai para a SnackBar como veio da API.
2. **Lista com ABAS por status** (Abertas × Faturadas) consultando a API
   com `?status=`; FAB = ação de abertura; AppBar = ações de rotina.
3. **Dialog de rotina**: pede a competência, executa e apresenta o
   RELATÓRIO retornado (não só "ok").
4. **Detalhe dirigido pelo estado**: aberto = sub-lista editável por
   dialogs (cada operação chama a API e RECARREGA o detalhe — o total vem
   do servidor); fechado = somente leitura com os dados do desfecho
   (nº da fatura, emissão).
5. **Dialog da ação terminal** (ex.: Gerar Faturamento): campos da decisão
   do usuário com DEFAULTS vindos da API (sugestão de vencimento), sempre
   editáveis.
6. Projeções locais para lookups de outros domínios (módulo NUNCA importa
   módulo): clientes, produtos, formas de pagamento (filtrar `enable='S'`).
7. Grupo de menu novo exige a chave `menu.groups.<Grupo>` no i18n pt/en.

## Checklist de entrega

- [ ] Swagger completo das ações (409s documentados) — memória swagger-obrigatorio
- [ ] Testes jest das funções puras de cálculo
- [ ] Smoke E2E do CICLO INTEIRO em dev (abrir → agir → transicionar → conferir efeitos colaterais: financeiro/totalizer/trava)
- [ ] flutter analyze zero issues; i18n pt/en completos
- [ ] Cadeia Infra-IA (doc do módulo → INDICE_CENTRAL → memória)
