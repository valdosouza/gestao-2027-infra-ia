# Frente de debate — Terminal × Grupo de estabelecimentos × PDV recebendo o cadastro da web

**Escopo**: misto (o método — antes de abrir a 2ª direção de uma sincronia, nomear UM escritor por dado e fazer a guarda perguntar
"quem escreve", não "existe credencial" — é portável; os fatos, o legado e as decisões são do Gestão 2027)
**Origem**: Valdo, 2026-10-18, ao responder os pontos em aberto da `tb_terminal` (`setes-sync/verificacao-comissao-margem-mercadoria.md`
§9.6, último item): *"Matriz × filiais e PDV recebendo o cadastro da web: frente PRÓPRIA, em sessão própria, para debater"*.
**Aberto em**: 2026-10-18. **Estado**: **Rodada 0 — SÓ LEITURA e desenho** (fatos com arquivo:linha, mapa, parecer do guardião integrado,
opções com recomendação). Nada de código, DDL, seed ou commit. **Q-TG1…Q-TG14 aguardam o Valdo.**
**Natureza**: frente de DEBATE — não executa nada. Cada decisão daqui é ENTREGUE à frente dona do objeto (§7) e executada lá.
**Transversal**: setes-api (guarda, pedidos, caixa), setes-app (registro de terminais), setes-sync (recusa, catálogo do grupo, projeção do PDV),
sincronizador (perfil da instalação, direção inversa), fiscal-api (`WEB_TERMINAL` na borda), Gestao2016 (o PDV que fica). **Regra dos dois
grupos**: o objeto desta frente É a fronteira (a D-SY14 nasceu transversal), por isso os dois grupos foram LIDOS; nenhuma decisão daqui muda um
grupo a partir do outro — cada grupo executa a sua parte na própria frente.
**Frentes vizinhas (lidas, não editadas)**: `prompt_frente_grupo_estabelecimentos.md` (+ inventário) · `prompt_modulo_products.md` §11 e
Rodada 6 (em execução noutra sessão) · `Sincronizador/prompt_indexador_terminal_pdv.md` · `setes-sync/prompt_revisao_sincronizador_setes_sync.md`
(D16) · `setes-sync/verificacao-comissao-margem-mercadoria.md` §9.4–§9.6 · **Frente tb_terminal** (sessão paralela; o
`prompt_frente_terminal.md` ainda NÃO existia ao fechar esta Rodada 0 — conferir ao retomar e reconciliar as questões).

---

## 0. Em uma tela

1. **O conflito central**: a guarda `syncWriteGuard` pergunta *"este estabelecimento tem chave de sincronia ativa?"* — mas o que ela quer saber
   é *"quem escreve os cadastros: o sistema antigo ou a web?"*. Hoje as duas perguntas têm a mesma resposta. No alvo da D-SY12 (desktop morto,
   PDVs vivos) **a chave continua ativa (os PDVs a usam) e o escritor passa a ser a web** — a guarda, como está, trava exatamente o que o PDV
   precisa. A chave é AUTENTICAÇÃO; "quem escreve" é AUTORIDADE — dois fatos.
2. **Segundo conflito, já no código**: o sincronizador decide "sou PDV" por `GbTerminal <> 0` em 4 pontos. Com a D-SY14 (web = 0, servidor
   local ≥ 1) o servidor local passaria a se comportar como PDV — desliga o envio de cadastros, não converte categorias, ignora o EXTERNALCODE.
3. **Recomendação de fundo (guardião)**: "quem escreve os cadastros do GRUPO" é um fato do grupo — um PONTEIRO na linha do grupo (D-GE1) para
   o par `(institution, terminal)` que alimenta os cadastros; vazio = a web. Um fato só atende 4 consumidores: a guarda da web, a recusa do
   setes-sync, o perfil distribuído ao sincronizador e quem alimenta o PDV. A passagem para a web é um ATO de mão única (molde da virada D-F44).
4. **Terminal é do ESTABELECIMENTO** (operação — `PADROES_BANCO.md` §12); numeração por estabelecimento; o 0 é a web, constante sem linha.
5. **Identidade do terminal gerada pela web** e distribuída; o setes-sync deriva `(institution, terminal)` dela e não confia no número do payload —
   fecha o risco de dois PDVs com o mesmo número sobrescreverem os pedidos um do outro.
6. **O PDV da filial recebe uma PROJEÇÃO** (derivada, nunca tabela): catálogo do grupo × vínculos da filial + operação da filial; o pedido sai
   `(id, filial, terminal do PDV)`.
7. **Ordem sugerida**: `tb_terminal` + linha do grupo antecipada com o ponteiro → grupo ondas 0/1 → guarda pelo ponteiro + direção inversa do PDV
   → grupo ondas 2/3.

---

## 1. Decisões de partida (já tomadas — não se rediscutem aqui)

| Origem | Decisão | Peso nesta frente |
|---|---|---|
| D-SY14 + respostas do §9.6 | `tb_terminal (tb_institution_id, id, description)` registra os terminais de cada estabelecimento; **web = 0 sempre**; servidor local e PDVs ≥ 1; registrado NA WEB e distribuído; setes-sync recusa terminal não registrado ("Terminal não registrado, verifique"); sem migração do terminal 0 (sincronia refeita do zero); **sem FK** nas 55 tabelas | o objeto que conversa com tudo |
| D-SY12 | o desktop vai morrer; **fica o PDV**; para o PDV a atualização é INVERSA (cadastro inserido/atualizado na web e replicado na base local); "aí o id passa a ser da web" | o alvo |
| D-SY13 | chave inativa → sincronizador INATIVO até ativação manual | a chave é UMA para servidor e PDVs |
| D-PR41 revista (Rodada 6 de produtos) | a web não INSERE produto, serviço, tabela de preço nem categoria em estabelecimento com chave de sincronia ATIVA — método `syncWriteGuard` + `@shared/sync-key` | a guarda que conflita com o alvo |
| D-PR43 · D-PR47 (Q-PR47) | interruptor da chave (`PUT /api/institutions/:id/sync-api-key/active`, super); religar recusa se a web escreveu desde o desligamento | hoje o interruptor é o único jeito de "sair do sistema antigo" |
| D16 (revisão do sync) | sentido web → Firebird = fase própria ("Sync Fase 2 — Recebimento") | a direção inversa do PDV é ela |
| Indexador PDV — decisões 1–3 | terminal pela instalação (`SISWEB\TERMINAL`); **chave por ESTABELECIMENTO, a mesma em todos os terminais**; perfil PDV = só movimento | a 1 está superada em parte pela D-SY14 (convenção do 0); a 3 conflita (T8) |
| D1 · D12 | o sincronizador só fala com o setes-sync; UMA chave por instalação/cliente → resolve institution + schema | chave ≠ terminal; a projeção do PDV mora no setes-sync |
| D-SY7 | 1 Firebird = 1 estabelecimento é LIMITE (roteiro, Fase 0) até a frente matriz × filiais | multi-estabelecimento no Firebird |
| D-PR20…D-PR23 · D-GE1/D-GE2 | grupo = schema; chave do grupo = fundadora, numa linha única do schema; catálogo, categoria, tabelas de preço e grade do GRUPO; a filial usa um subconjunto das tabelas (vínculo `tb_institution_has_price_list`) | o que é do grupo; a casa do ponteiro |
| D-GE3 · D-GE7 · D-GE8 · D-GE9 · D-GE14 · D-GE16 · D-GE17 · D-GE18 · D-GE22 | privilégio por estabelecimento; formas por estabelecimento; FCP por estabelecimento; papéis do grupo; onboarding em dois atos; licença por estabelecimento; ondas 0→3; dado do grupo editado por quem tem a interface em qualquer estabelecimento; contrato de telas do grupo | o que desce ao PDV de cada filial |
| D-NE12 | `terminal` por parâmetro no núcleo fiscal; `WEB_TERMINAL = 0` só na borda | já coerente com a D-SY14 |
| D-PR37 | nada se apaga fisicamente (soft delete) | a exclusão desce ao PDV como `deleted='S'` |

## 2. Fatos (código e banco de dev — só leitura, 2026-10-18)

Prefixos: `API\` = `setes-api\src\` · `MERCH\` = worktree `D:\Gestao2027\merchandise\setes-api\src\` (frente de produtos, NÃO publicada) ·
`SYNC\` = `setes-sync\src\` · `SINC\` = `sincronizador\` · `G16\` = `D:\Gestao2016\` · `SQL\` = `sql\`. Banco: `setes_setes`/`setes_central`
em sessão READ ONLY (dev = ensaio — nada em produção).

| # | Fato | Evidência |
|---|---|---|
| T1 | `terminal` está na PK de **55 tabelas** do schema do cliente. Outras 6 têm a coluna FORA da PK: `tb_invoice_shipping` PK `(id, tb_institution_id)` — dois terminais com a mesma nota colidem —, `tb_stock_statement` PK só `id` (já registrado na Rodada 4 do sync), `tb_stock_list`, `tb_check_event`, `tb_contract_item_competence`, `tb_devices`; `tb_order_item_icms_fcp`/`_ipi_back` sem PK | `information_schema` |
| T2 | Dev: TUDO no terminal 0 (7.949 pedidos, 7.433 notas, 6 caixas); **1 institution por schema**; **1 chave** (institution 1, ativa); nenhuma `tb_terminal` em lugar nenhum | `information_schema` + SELECT |
| T3 | setes-api grava/lê operação com `terminal = 0` literal: **154 ocorrências em 27 arquivos** (pedido, nota, cancelamento, financeiro, baixas, boleto, cheque, comissão, OS, devolução, caixa). O caixa já nomeia a constante (`WEB_TERMINAL = 0`, `API\modules\cashier\cashier.repository.ts:18`; comentário `:11-15` "nunca colide com os terminais do PDV" — premissa que só a D-SY14 torna verdadeira). O id do pedido da web é `MAX(id)+1` da institution **sobre todos os terminais** (`API\modules\orders\orders.repository.ts:323-328`) | grep |
| T4 | Núcleo fiscal: `InvoiceRef {institutionId, invoiceId, terminal}` com `WEB_TERMINAL = 0` (`fiscal-api\src\ref\invoice-ref.ts:27`) | código |
| T5 | Chave: `setes_central.tb_sync_api_key` (`SQL\05_sync_api_key.sql:11-24`) **sem UNIQUE em `tb_institution_id`**; "uma por estabelecimento" só por código (`API\modules\institutions\institutions.repository.ts:302-336`); setes-sync resolve institution + schema pela chave (`SYNC\modules\sync\sync.auth.middleware.ts:51-71`); recusa 401/403 com códigos próprios (D-SY13, `:22-36`) | código |
| T6 | setes-sync grava o CATÁLOGO sob a institution DA CHAVE (`SYNC\modules\sync\endpoints\merchandise.ts:246-281`). Os endpoints de cadastro **não recebem `terminal`**; os de movimento recebem e só validam inteiro ≥ 0 (`ordersale.ts:69`) — nenhum registro consultado; upsert pela PK `(id, tb_institution_id, terminal)` | código |
| T7 | Guarda: `MERCH\gateway\sync-write.guard.ts:20-39` lê a institution **DA SESSÃO** (`:22`, `:28`) e pergunta `hasActiveSyncKey` (`MERCH\shared\sync-key\index.ts:11-16`); aplicada a `categories`, `services`, `price-lists`, `merchandise` (`MERCH\gateway\router.ts:153,204,205,209`); `SYNC_FED_TABLES` (`index.ts:25`) | worktree |
| T8 | **Sincronizador deduz "sou PDV" do NÚMERO**: `GbTerminal` lido de `SISWEB\TERMINAL` (`SINC\un_dm.pas:204`; a seção SISWEB mora no `CONFIG.INI` ao lado do executável — nota da sessão da D-SY13) e `GbTerminal <> 0` desliga os cadastros no seed (`:479-483`), pula a conversão de categorias (`:916`) e o EXTERNALCODE (`:1302`, `:1314`). Com a D-SY14 o servidor local (≥ 1) cairia em TODOS esses ramos | código |
| T9 | Direção inversa no sincronizador = **esqueleto**: `SINC\function\un_receive_from_web_server.pas` (laço que percorre a fila LOCAL e chama `receive`), `SINC\classes\general_web.pas:374` (`receive` vazio), `SINC\classes\receive\order_sale_receive_web.pas` (cópia da classe de conta bancária); o catálogo prevê `WAY='R'` (`SINC\function\un_sincronia_seed.pas:12-14`) mas **nenhuma linha R** no seed | código |
| T10 | **Gestao2016 — como o PDV recebe cadastro hoje**: a retaguarda empurra **15 cadastros** do Firebird do servidor para o do terminal (`G16\Controller\ControllerRetaguardaSendToLocal.pas:60-77`: usuário, cargo, colaborador, empresa, forma de pagamento, grupo, subgrupo, marca, medida, embalagem, produto, estoques, estoque, tabela de preço, preço); empresa reindexada por CPF/CNPJ com id local NOVO (`:197-232`); produto e preço com o MESMO id (`Sync_tb_produto`, `Sync_tb_preco`); cursor no terminal (`TB_SYNC_TABLE`, sentido `R`, `:79-98`). Regra tributária NÃO está na lista (a conferir de onde o PDV a lê) | código |
| T11 | **Gestao2016 — `TB_TERMINAL (ID, DESCRIPTION, PATH_SERVER, PATH_DATABASE)`**, PK `ID`, gerador `GN_TERMINAL`, **sem estabelecimento** (`G16\Scripts\Banco2022\CriarTodasAsTabelas.sql:3291-3297`): é o registro de INSTALAÇÕES (caminho do Firebird de cada terminal); conectar num terminal escolhe a empresa ativa DEPOIS (`G16\Tarefas\tas_conecta_terminal.pas:108-124`, `Pc_DefineEmpresaAtiva(0)`); o menu da retaguarda só abre com mais de 1 terminal (`G16\Controller\ControllerTerminal.pas:67-83`) | código |
| T12 | **Gestao2016 — o PDV não cria produto** (produto-coringa — regra PDV-01) **mas CRIA cliente** ("Informar CPF na nota" abre cadastro — PDV07/PDV-06) e **emite a NFC-e localmente** (PDV06); série por terminal no baseline web `tb_nfe_series (tb_institution_id, terminal, serie)` sem produtor (a Q-E16 reservou a série por terminal para a onda do PDV) | `D:\Gestao2016\Infra-IA\Gestao\04-processos\proc-nfce-pdv.md` |
| T13 | Baseline web: `tb_devices (id, tb_institution_id, identification, description, tb_user_id, terminal, serie_nf, app_name, shelf_life, download…)`, PK `(id, tb_institution_id, identification)` (`API\migrations\sql\001_baseline.sql:374-390`), **0 linhas, sem consumidor** — o gestao_setes amarrava DISPOSITIVO (identificação) ↔ terminal ↔ série ↔ validade | DDL + SELECT |
| T14 | Grupo: `@shared/group` e a linha do grupo ainda não existem (onda 1); o Firebird multi-estabelecimento manda TUDO para a institution da chave e `PRO_CODMHA` não viaja (`setes-sync/verificacao-comissao-margem-mercadoria.md` §4.1); `tb_product.id` do sistema antigo = `PRO_CODIGO`, upsert pela PK (§9.1 do mesmo doc) | docs + código |

## 3. Mapa das interações

### 3.1 Quem fala com quem — hoje (transição), alvo (D-SY12) e no grupo

```
HOJE (desktop vivo)                          ALVO D-SY12 (desktop morto)                 GRUPO (matriz A = fundadora, filial B)

 Desktop (servidor local, terminal ≥1*)       Web (terminal 0 de cada estabelecimento)    catálogo: chave do grupo (A)
   │ cadastro + movimento ──► setes-sync        │ ÚNICA escritora dos cadastros            operação: por estabelecimento
   │ retaguarda G16: 15 cadastros ──► PDV       │ cadastro ──► setes-sync ──► PDV (D16)    terminais: A {0, 1..n} · B {0, 1..m}
 PDV (terminal ≥1)                             PDV (terminal ≥1)                           ponteiro "quem escreve": linha do grupo
   │ movimento ──► setes-sync                   │ movimento ──► setes-sync                 PDV de B recebe: catálogo de A × vínculos
 Web (terminal 0)                              (chave do estabelecimento continua ATIVA)     de B + operação de B (regras, formas,
   │ cadastros: SÓ CONSULTA (guarda)                                                       operadores)
   │ pedido no terminal 0                                                                pedido do PDV de B = (id, B, m)
 * hoje 0 (a D-SY14 muda)                                                                pedido da web em B = (id, B, 0)
```

### 3.2 Um escritor por dado — onde o PDV entra

| Dado | Escopo (§12) | Escreve HOJE (desktop vivo) | Escreve no ALVO | Desce ao PDV? |
|---|---|---|---|---|
| Produto, serviço, categoria, marca/medida/embalagem, tabela de preço + grade | GRUPO | desktop (via setes-sync), web bloqueada | web | sim — catálogo do grupo; tabelas de preço só as do vínculo da filial (D-PR23) |
| Papéis (cliente, vendedor…) | GRUPO (D-GE9) | desktop + **PDV cria cliente** (T12) | web + PDV (cliente pelo CPF/CNPJ — entidade única, D3) | sim — Q-TG11 |
| Forma de pagamento (vínculo) | ESTABELECIMENTO (D-GE7) | desktop | web | só as habilitadas na filial |
| Regra tributária / MVA / FCP | ESTABELECIMENTO | web (tax-rules) | web | sim, as da filial — **não estava nos 15 da retaguarda** (T10: conferir de onde o PDV lê) |
| Usuários / privilégios | central / ESTABELECIMENTO (D-GE3) | desktop (usuário sincronizado sem credencial) | web | operadores da filial — credencial na Q-TG10 |
| Registro de terminais | ESTABELECIMENTO (Q-TG1) | — (não existe) | web (D-SY14) | cada instalação recebe o SEU registro (identidade — Q-TG7) |
| "Quem escreve os cadastros" | GRUPO (Q-TG3) | — (implícito na chave) | web (ato de mão única) | define o perfil de cada instalação |
| Série NFC-e por terminal | ESTABELECIMENTO × terminal | PDV (Firebird) | onda do PDV/NFC-e (Q-E16) | fora desta frente (§7) |
| Pedido, nota, caixa, financeiro | ESTABELECIMENTO | desktop/PDV (terminal ≥ 1) e web (0) | PDV (≥ 1) e web (0) | não desce (só sobe) |

## 4. Parecer do guardião (`setes-conceito`, 2026-10-18 — integrado)

**Conceito.** O terminal é o ESPAÇO DE NUMERAÇÃO das operações de um estabelecimento (cada terminal tem o seu pedido nº 1); nasce do ato de
cadastrar uma instalação que vai originar operação. **Terminal não é a máquina, não é a fonte dos cadastros e não é a credencial** — três
conceitos que o pedido mistura e que ficam em peças separadas.

1. **Escopo e numeração**: tabela do ESTABELECIMENTO, numeração por estabelecimento (regra 1 do §12 — o terminal compõe a PK das 55 tabelas
   junto do `tb_institution_id` de quem operou; numeração única no grupo seria regra sem consumidor). Uma máquina que serve 2 estabelecimentos
   (Firebird multi-estabelecimento) vira 2 terminais — certo, porque terminal não é máquina. O 0 é constante reservada da web, SEM linha (uma
   linha 0 editável ou desativável seria contradição); o setes-sync recusa o 0 sempre — a colisão da Q-SY14 morre na origem.
2. **A guarda faz a pergunta errada.** A chave é a AUTENTICAÇÃO do estabelecimento (ligado/parado — D-SY13); "quem escreve os cadastros" é fato do
   GRUPO (o catálogo é do grupo, D-GE18). Casa: um PONTEIRO na linha do grupo (D-GE1) — o par `(institution, terminal)` que alimenta os cadastros;
   vazio = a web. Um fato, quatro consumidores, nenhuma regra de coerência: (i) a guarda da web lê uma linha no escopo do grupo; (ii) o setes-sync
   aceita cadastro só do terminal apontado e, com o ponteiro vazio, responde 409 a todo cadastro (simétrico à guarda); (iii) o perfil do
   sincronizador é DISTRIBUÍDO pela web (o apontado envia cadastros; os demais só recebem e mandam movimento) — substitui o `GbTerminal <> 0`;
   (iv) quem alimenta o PDV: ponteiro preenchido = a retaguarda do desktop; vazio = a web (D16). Transição de **mão única**, molde do ato da virada
   (D-F44): o ponteiro nasce no ato "cliente novo com sincronizador"; o ato "a web assume os cadastros" esvazia o ponteiro e grava a data; não há
   volta (depois que a web escreveu, voltar recriaria a colisão da D-SY12); desativar o terminal apontado SEM esse ato é recusado — guarda de ATO,
   não de estrutura.
   - **Por que não "papel no terminal"** (a 1ª leitura desta Rodada 0): exige a regra "no máximo um terminal-fonte ativo no grupo", uma leitura
     agregada entre estabelecimentos (entraria na `GROUP_AGGREGATE_READS` da A-GE1) e uma guarda na desativação — regra que só existe para a
     estrutura não se contradizer = maquete. O ponteiro tem "no máximo um" por construção.
   - **Por que não `cutover_at` sozinho**: diz QUANDO a web assume, não QUEM é a fonte — o sincronizador continuaria deduzindo o perfil pelo número.
   - **Por que não chaves por tipo de terminal**: mistura autenticação com autoridade e fica no escopo errado (estabelecimento, não grupo).
3. **Identidade do terminal**: o risco MAIOR não é a filial errada — é **dois PDVs do mesmo estabelecimento com o mesmo número**: o upsert pela PK
   faz um sobrescrever o pedido do outro sem erro (a mesma classe da D-SY12). Identidade gerada PELA WEB no cadastro do terminal e distribuída
   (é o "distribuído" da D-SY14), no molde do `tb_no_doc.external_id`; o sincronizador manda a chave do estabelecimento (decisão 2 do indexador
   continua) + a identidade; o setes-sync DERIVA `(institution, terminal)` da identidade e nunca confia no número do payload; identidade
   desconhecida, desativada ou de outro estabelecimento = "Terminal não registrado". Limite conhecido: imagem de PDV clonada leva a mesma
   identidade (só uma "reivindicação na 1ª conexão" pegaria — não recomendada agora).
4. **O que o PDV recebe**: PROJEÇÃO como DERIVAÇÃO, nunca tabela — catálogo do grupo × vínculos do estabelecimento do terminal (tabelas de preço,
   formas, `tb_institution_has_service`), regras/MVA/FCP do estabelecimento, usuários com privilégio nele, papéis do grupo inteiros. Mora numa
   composição do setes-sync (D1), com a política escrita uma vez. O cursor fica no PDV (marca por `updated_at`, molde do `LAST_UPDATE` da
   `TB_LISTA_SINCRONIA`) — a web não guarda estado por terminal; a D-PR37 torna o pull completo por construção (exclusão desce como `deleted='S'`).
   Uma tabela "catálogo do PDV" seria cópia a manter em sincronia = maquete.
5. **Grupo com duas fontes de cadastro**: com o ponteiro a 2ª fonte não tem onde morar — a recusa é consequência da estrutura. O ato
   "estabelecimento no grupo" (D-GE14) recusa o entrante com desktop vivo em OUTRO Firebird enquanto o grupo tiver fonte; ele entra quando o desktop
   dele morrer (os produtos dele entram como cadastro NOVO na web — importação é ato próprio, nunca upsert por `PRO_CODIGO`) ou se for o MESMO
   Firebird (mesma fonte). Remapear `PRO_CODIGO` resolveria, mas é investir no que vai morrer (D-SY12).

**Maquetes apontadas**: `tb_devices` (junta 4 conceitos — identidade → `external_id` do terminal; série → `tb_nfe_series`; validade → licença
`tb_institution.active`; aplicativo) · papel/kind no terminal · tabela de projeção · chaves por tipo de terminal.
**Nomes propostos**: `tb_terminal (tb_institution_id, id, description, external_id, active, deleted, created_at, updated_at)` no schema do
cliente; na linha do grupo `register_source_institution_id` + `register_source_terminal` + `dt_register_cutover`; peça `@shared/terminal` no
setes-api (constante 0, cadastro) e leitor próprio no setes-sync (grupos separados). **Palavras a evitar**: "chave" para a identidade (já tem 5
sentidos); "habilitação" (é do emissor); "origem" (origem fiscal do bem); "legado"/"desktop" em coluna (nada de legado no banco); "fonte" esbarra
de leve em "fonte de fatos" do fiscal-api — aceitável, a confirmar.
**Limite conhecido do ponteiro** (desta sessão): num Firebird multi-estabelecimento, o servidor registrado no estabelecimento NÃO apontado se
comportaria como PDV — perde o recurso ao EXTERNALCODE na resolução do usuário (`un_dm.pas:1302,1314`); o caso só nasce se a D-SY7 cair.

## 5. As perguntas do Valdo, lidas pelos fatos

- **Terminal é do estabelecimento ou do grupo?** Do ESTABELECIMENTO: o terminal é a ORIGEM de uma operação, e a operação é de um CNPJ (pedido,
  caixa e série NFC-e — T1, T12; o PDV fica numa loja). O `TB_TERMINAL` do Gestao2016 não tinha estabelecimento (T11) porque lá o terminal era uma
  INSTALAÇÃO de banco servindo N estabelecimentos; na web o registro responde outra pergunta ("de onde veio esta operação"). → Q-TG1/Q-TG2.
- **Filial com PDV: qual catálogo e de qual terminal sai o pedido?** O PDV de B recebe o catálogo do GRUPO (chave A) recortado pelos vínculos
  de B + a operação de B; o pedido sai `(id, B, terminal do PDV)` — nunca na institution da fundadora. → Q-TG8.
- **PDV × `syncWriteGuard` — quando o desktop morre a guarda cai? por estabelecimento?** Como está, NÃO cai: pergunta "tem chave ativa" (T7) e a
  chave segue ativa porque os PDVs a usam (decisão 2 do indexador). E pergunta pelo estabelecimento DA SESSÃO, enquanto o catálogo é do GRUPO: a
  filial B sem chave escreveria no catálogo que o desktop da fundadora alimenta (o setes-sync sobrescreveria — T6, T14). Com o ponteiro, a guarda
  cai pelo ATO "a web assume os cadastros", no grupo inteiro. → Q-TG3, Q-TG4, Q-TG5.
- **Número do terminal e chave num grupo com N filiais**: N filiais = N chaves (D12 + decisão 2 do indexador) e N espaços de terminal; toda filial
  terá o "terminal 1". Com só `(chave, número)`, uma instalação com a chave errada ou dois PDVs com o mesmo número passam calados. → Q-TG7.
- **Terminal 0 quando o pedido é da filial**: cada estabelecimento tem o SEU 0 (`(id, B, 0)` ≠ `(id, A, 0)`); a sessão da web decide a
  institution. Não há conflito; resta a forma do 0 e quem mais é "web" (app de venda). → Q-TG9.
- **Ordem das frentes** → Q-TG12/Q-TG13.

## 6. Questões — Rodada 1 (aguardam o Valdo)

**Q-TG1 — O terminal é do ESTABELECIMENTO ou do GRUPO?** **(a)** do ESTABELECIMENTO: `tb_terminal.tb_institution_id` = a institution que opera
(§12 — operação); um servidor que atenda N estabelecimentos vira N registros **(Recomendado — pedido, caixa e série NFC-e são de um CNPJ; a PK das
55 tabelas já é `(…, tb_institution_id, terminal)`)** · (b) do GRUPO (um terminal servindo N filiais) — o pedido teria de carregar o
estabelecimento à parte do terminal.

**Q-TG2 — Numeração.** **(a)** por estabelecimento: cada um tem o seu 0 (web) e os seus 1..N; dois estabelecimentos do grupo têm "terminal 1"
**(Recomendado — consequência da Q-TG1 (a); "cada terminal tem o seu pedido nº 1", D-SY14)** · (b) única no grupo — regra sem consumidor (a PK
já separa por institution).

**Q-TG3 — Onde mora "quem escreve os cadastros do grupo".** **(a)** PONTEIRO na linha do grupo (D-GE1) para o par `(institution, terminal)` que
alimenta os cadastros; vazio = a web; mão única **(Recomendado — guardião: um fato, quatro consumidores, "no máximo um" por construção)** · (b) PAPEL
no terminal (`desktop` × `pdv`) + regra "no máximo um ativo no grupo" — exige leitura agregada e guarda de coerência (maquete) · (c) só um fato
datado de virada (`cutover_at`) — diz quando, não quem · (d) chaves por tipo de terminal — mistura autenticação com autoridade.
⚠️ **Em qualquer opção**, os 4 pontos do `un_dm.pas` que deduzem "sou PDV" do número (T8) precisam mudar JUNTO com a D-SY14 — o perfil passa a
ser DISTRIBUÍDO pela web (em (a): o terminal apontado envia cadastros; os demais só mandam movimento) — senão o servidor ≥ 1 vira PDV no 1º start.

**Q-TG4 — O que a guarda `syncWriteGuard` pergunta e como o sistema antigo SAI.** **(a)** a guarda pergunta "o ponteiro do grupo está
preenchido?"; o setes-sync aceita cadastro só do terminal apontado e, com o ponteiro vazio, recusa todo cadastro (409, simétrico); a saída é o ATO
"a web assume os cadastros" (super, com motivo; esvazia o ponteiro e grava a data; mão única — molde D-F44); desativar o terminal apontado sem o
ato = recusado; a chave volta a significar só AUTENTICAÇÃO — o interruptor da D-PR43 e a regra da D-PR47 deixam de ser a "saída do sistema
antigo" **(Recomendado)** · (b) manter "chave ativa" — trava o PDV no alvo · (c) manter "chave ativa" até o desktop morrer e então desligar a
chave (D-PR43) — **os PDVs param juntos** (D-SY13).

**Q-TG5 — A guarda olha o GRUPO ou o estabelecimento da sessão?** Hoje lê a institution DA SESSÃO (T7). **(a)** o GRUPO: a guarda resolve a chave
do grupo (`@shared/group`) e lê o ponteiro do catálogo do grupo; cadastro do ESTABELECIMENTO (regra tributária, formas) não passa por ela
**(Recomendado — o catálogo é um só, o escritor também; hoje neutro: grupo = institution)** · (b) o estabelecimento da sessão, como está — a filial
sem chave escreve no catálogo que o desktop da fundadora alimenta.

**Q-TG6 — Grupo com mais de uma FONTE de cadastros.** Dois Firebirds separados (matriz e filial, cada um com o seu desktop) têm espaços de
`PRO_CODIGO` que COLIDEM sob a chave do grupo (T14). **(a)** o ato "estabelecimento no grupo" (D-GE14) recusa o entrante com desktop vivo em OUTRO
Firebird enquanto o grupo tiver fonte (consequência do ponteiro único); ele entra quando o desktop dele morrer, com os produtos IMPORTADOS como
cadastro novo na web (ato próprio, nunca upsert por `PRO_CODIGO`); Firebird MULTI-estabelecimento = mesma fonte, mas segue no limite da D-SY7 até
um cliente real pedir **(Recomendado)** · (b) catálogo por estabelecimento enquanto houver 2 desktops — fere a D-PR20, e a unificação depois é
migração com conflito (D-GE17) · (c) remapear os ids do 2º desktop no setes-sync — investir no que vai morrer (D-SY12).

**Q-TG7 — Identidade do terminal.** O número sozinho deixa passar dois PDVs do mesmo estabelecimento com o mesmo número (um sobrescreve os pedidos
do outro pelo upsert — T6) e a chave da filial errada. **(a)** identidade gerada PELA WEB no registro (`external_id`, molde `tb_no_doc.external_id`)
e distribuída à instalação; o sincronizador manda chave + identidade; o setes-sync DERIVA `(institution, terminal)` da identidade e não confia no
número do payload; identidade de outro estabelecimento = recusa; limite conhecido: imagem clonada **(Recomendado — guardião)** · (b) identidade
gerada pela instalação no 1º start e PAREADA na web (exige um passo de pareamento; o número continua vindo da web) · (c) só `(chave, número)`, como
decidido. *O mecanismo de entrega (tela, cópia para o `CONFIG.INI`) é da Frente tb_terminal.*

**Q-TG8 — O que o PDV da filial RECEBE.** **(a)** PROJEÇÃO derivada numa composição do setes-sync: catálogo do GRUPO × vínculos da filial (tabelas
de preço — D-PR23; formas — D-GE7; `tb_institution_has_service`) + operação da filial (regras/MVA/FCP — D-GE8; operadores com privilégio nela —
D-GE3; o registro do próprio terminal) + papéis do grupo; cursor NO PDV; exclusão desce como `deleted='S'` (D-PR37) **(Recomendado)** · (b) o
catálogo inteiro do grupo, sem recorte — o PDV vende o que a filial não tem tabela/forma · (c) tabela própria "catálogo do PDV"/catálogo por filial —
cópia a manter (maquete) e fere a D-PR20.

**Q-TG9 — O terminal 0 (web).** **(a)** constante SEM linha (registro só de instalações, `id ≥ 1`); a constante e o rótulo ("Internet") numa peça
(`@shared/terminal` — hoje espalhada: `cashier.repository.ts:18`, `fiscal-api\src\ref\invoice-ref.ts:27`, 154 literais, T3); o setes-sync recusa
o 0 sempre **(Recomendado)** · (b) linha 0 criada no nascimento de cada estabelecimento (nos dois atos da D-GE14), protegida contra edição.
Consequência em qualquer opção: um app de venda que crie pedido OFFLINE com id local (D7 da revisão do sync) é INSTALAÇÃO — ganha terminal ≥ 1
como o PDV; um app ONLINE pelo setes-api é web (0).

**Q-TG10 — Operadores e credencial no PDV.** O PDV autentica LOCALMENTE (Firebird) e hoje recebe o usuário pela retaguarda (T10); a web guarda o
usuário na central com privilégio por estabelecimento (D-GE3). **(a)** a direção inversa leva ao PDV da filial os OPERADORES com privilégio nela e
uma credencial PRÓPRIA do PDV (PIN de operador mantido na web) — **nunca** a senha da web num banco local **(Recomendado — o Firebird do PDV não é
lugar para a credencial que abre o sistema inteiro)** · (b) levar o hash da senha da web e adaptar o PDV para conferi-lo · (c) o PDV mantém cadastro
local de operadores — 2º escritor do usuário.

**Q-TG11 — Cliente no PDV.** O PDV CRIA cliente (PDV07 — T12). **(a)** sobe pelo documento (entidade única, D3; papel do GRUPO, D-GE9; sem documento =
UUID da D4 devolvido pela web — o PDV não replica EXTERNALCODE hoje) e desce como papel do grupo a todos os PDVs do grupo; o tamanho da carga
inicial é detalhe da D16 **(Recomendado)** · (b) o cliente criado no PDV fica só nele e sobe com o movimento · (c) o PDV não cria cliente (só
consumidor sem cadastro).

**Q-TG12 — Ordem das frentes.** **(a)** (1) `tb_terminal` (escopo, identidade, recusa do 0) **+ a linha do grupo ANTECIPADA só com o ponteiro**
(backfill neutro: a institution que já existe; o ponteiro aponta o terminal do desktop no ato de registrá-lo) + os 4 pontos do `un_dm.pas` com o
perfil distribuído → (2) grupo ondas 0/1 (leitores, `@shared/group`) → (3) guarda pelo ponteiro + direção inversa do PDV (D16) lendo o catálogo
pela chave do grupo → (4) grupo ondas 2/3 (papéis; onboarding da filial — que já recusa a 2ª fonte, Q-TG6) **(Recomendado — cada passo é neutro
para o anterior; a direção inversa nasce falando "grupo" e não é refeita)** · (b) direção inversa antes do grupo (mais rápida para um cliente de 1
estabelecimento; refaz a leitura do catálogo depois) · (c) grupo inteiro antes do terminal — a D-SY14 espera, e a Q-SY14 (pedido da web × pedido
do servidor no mesmo terminal) segue aberta.

**Q-TG13 — Quem puxa (dado, não opinião).** Existe cliente com data para a direção inversa do PDV (a Pipoteca — 1 servidor + 7 PDVs — é 1
estabelecimento?) e existe cliente com filiais E desktop vivo? A resposta muda a Q-TG12: cliente de 1 estabelecimento sem filiais torna a (b)
aceitável; cliente com filiais e desktop puxa a Q-TG6 para já. *(Rec.: piloto da direção inversa num cliente de 1 estabelecimento.)*

**Q-TG14 — `tb_devices` (baseline, 0 linhas, sem consumidor — T13).** **(a)** DROP quando a Frente tb_terminal executar: o guardião fez o teste do
conceito — identidade → `external_id` do terminal, série → `tb_nfe_series`, validade → licença; não sobra fato **(Recomendado pelo guardião)** ·
(b) manter como fundação do app de venda offline até essa onda decidir. *(Cuidado registrado: "tabela sem consumidor não é morta" — aqui o DROP
vem do teste do conceito, não da falta de consumidor; DDL só com o "vai".)*

## 7. Para onde vai cada decisão (esta frente não executa)

| Questão | Frente dona | O que muda lá |
|---|---|---|
| Q-TG1, Q-TG2, Q-TG7, Q-TG9, Q-TG14 | **Frente tb_terminal** (sessão paralela) | forma da `tb_terminal` (escopo, identidade, 0 sem linha), recusa do setes-sync, entrega ao sincronizador, destino da `tb_devices` |
| Q-TG3 | **Frente tb_terminal** + **frente do grupo** (linha do grupo antecipada, D-GE1) + grupo do sync (perfil distribuído, `un_dm.pas`) | o ponteiro e o ato de mão única |
| Q-TG4, Q-TG5 | **frente de produtos** (método `syncWriteGuard`, skill `novo-modulo.md`; D-PR43/D-PR47 relidas) + frente do grupo (`@shared/group`) + grupo do sync (recusa simétrica) | predicado da guarda |
| Q-TG6 | **frente do grupo** (ato "estabelecimento no grupo", onda 3) + grupo do sync (D-SY7/Q-SY7) | recusa da 2ª fonte; importação como ato próprio |
| Q-TG8, Q-TG10, Q-TG11 | **direção inversa (D16)** — a abrir; grupo do sync + setes-api | projeção, operadores, clientes |
| Q-TG12, Q-TG13 | esta frente | ordem |

**Pedido ao grupo do sync** (pergunta do guardião): num Firebird com N estabelecimentos, o sincronizador envia os cadastros UMA vez ou por
estabelecimento, e sob qual chave? O ponteiro nomeia um só par `(institution, terminal)`.

**Ficam com outras frentes (não são questões daqui)**: série NFC-e por terminal, CSC e contingência (onda do PDV/NFC-e, Q-E16); o contador do pedido
da web hoje `MAX(id)` sobre todos os terminais (T3 — a Frente tb_terminal decide se filtra `terminal = 0`); tabelas com `terminal` fora da PK (T1 —
`tb_invoice_shipping` é a única que colide entre terminais do mesmo estabelecimento; `tb_stock_statement` já está na Rodada 4 do sync); de onde o
PDV do Gestao2016 lê a regra tributária (T10 — conferir quando a direção inversa abrir). ⚠️ A Rodada 6 de produtos (sessão em execução) implementa
a guarda pela chave e a D-PR47 — se a Q-TG4 (a) for decidida, o predicado muda depois; nada a desfazer agora.

## 8. Critérios de sucesso (da frente de debate)

1. Q-TG1…Q-TG14 decididas pelo Valdo e cada decisão registrada na frente dona (§7) com o número D-TGn.
2. Nenhum dado com dois escritores no alvo: para cada linha do §3.2, um escritor nomeado em cada fase (desktop vivo × desktop morto).
3. O caminho "o desktop morre" descrito como ATO (quem faz, o que muda na guarda, o que acontece com a chave e com os PDVs) — sem SQL manual.

## 9. Retomada

```
Retome a frente de debate Terminal × Grupo × PDV pelo Infra-IA/prompts/prompt_frente_terminal_grupo_pdv.md.
⚠️ TRANSVERSAL (setes-api, setes-app, setes-sync, sincronizador, fiscal-api, Gestao2016). Frente de DEBATE: não executa;
cada decisão vai para a frente dona (§7).
Estado: Rodada 0 (fatos T1–T14, mapa §3, parecer do guardião §4, Q-TG1…Q-TG14 com recomendação) — aguardando o Valdo.
Antes: confira se Infra-IA/prompts/prompt_frente_terminal.md (Frente tb_terminal) já existe e reconcilie
(as Q-TG1/2/3/7/9/14 podem ter sido respondidas lá).
```

## Decisões arquiteturais registradas

*As decisões da Rodada 1 (2026-10-20) estão numeradas como **D-TM8…** no §9 de `prompt_frente_terminal.md` (uma fila só, reconciliada): Q-TG1/Q-TG2 → D-TM8 · Q-TG3/4/5 → D-TM10 · Q-TG6 → D-TM17 · Q-TG7 → D-TM11 · Q-TG8 → D-TM18 · Q-TG9 → D-TM16 · Q-TG10 → D-TM19 · Q-TG11 → D-TM20 · Q-TG12/13 → D-TM21 (ordem pelo dado: sem filiais hoje; Pipoteca = piloto da direção inversa) · Q-TG14 → D-TM22. **Rodada 1 FECHADA 2026-10-20 — nenhuma questão aberta nesta frente de debate.***
