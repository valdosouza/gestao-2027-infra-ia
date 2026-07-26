# Roteiro de Implantação — Sincronizador por Cliente

**Escopo**: setes

> Origem: handoff da sessão claude.ai (celular) de 2026-07-25 — conversa "Acesso aos trabalhos no Claude desktop".

Aplicar em CADA instalação (Gestao2016 + Sincronizador local). Pré-requisitos globais (uma vez só, antes de qualquer cliente): setes-sync publicada e no ar com as Ondas 1–6; Sincronizador compilado com os patches (Onda 0, 02 e 03 já estão no código; 04 ainda pendente — NFS-e fica de fora até aplicar).

## Fase 0 — Preparação (antes de ir ao cliente)

- Criar a chave da instalação em `setes_central.tb_sync_api_key`: INSERT (id, api_key, tb_institution_id, establishment_code, active='S') — uma chave POR estabelecimento; anotar o valor
- Confirmar a URL base da setes-sync (porta 3001) acessível a partir da rede do cliente
- Fazer backup/cópia do banco Firebird do cliente e validar o DDL na cópia primeiro (o script avisa: não testado em produção)

## Fase 1 — Banco Firebird do cliente (Gestao2016)

Rodar `patches-revisao-2026-07/01_firebird_ddl.sql`:

- `ALTER TABLE TB_EMPRESA ADD EXTERNALCODE VARCHAR(36)` + índice `IDX_EMPRESA_EXTERNALCODE`
- `ADD DELETED CHAR(1) DEFAULT 'N'` nas 23 tabelas sincronizadas (TB_MARCA_PRODUTO ... TB_CAIXA — lista completa no script)
- `UPDATE ... SET DELETED='N' WHERE DELETED IS NULL` em TODAS as 23 (Firebird legado não aplica default em linhas existentes) + COMMIT
- Conferir antes com `00_inventario_tb_lista_sincronia.sql` se o inventário real do cliente bate com a lista do DDL (clientes antigos podem ter divergência de schema)

## Fase 2 — Configuração do Sincronizador (registro do Windows, seção SISWEB)

- `FApiKey` = chave criada na Fase 0 (**a MESMA para todos os terminais do estabelecimento** — decisão 2 do indexador terminal)
- `FPathURL` = URL base da setes-sync (porta 3001)
- `TERMINAL` = número do terminal desta instalação (**0 = Servidor Local/Base única; 1..N = PDVs** — decisões 1 do `prompt_indexador_terminal_pdv.md`, 2026-07-26)
- Conferir intervalo / nominuto (ciclo de 5 min padrão)
- NÃO configurar mais institution no payload — a chave resolve institution + schema no servidor

### Clientes com PDVs (terminais de checkout com Firebird próprio)

- UMA instalação do Sincronizador POR BASE: servidor (`TERMINAL=0`) + cada PDV (`TERMINAL=N`,
  `BDPathBDLocal` apontando para a base do PDV)
- No PDV o seed nasce com **perfil de movimento** (decisão 3): cadastros Seq 1–16 e 38
  SET_ON='N' (chegam ao PDV pela retaguarda); movimento Seq 17–29 ativo
- ⚠️ RETAGUARDA: o bootstrap NÃO toca mais na `TB_SYNC_TABLE` (decisão 4 — reversão do drop);
  se alguma base dev rodou o bootstrap antigo, recriar a tabela pela DDL de
  `Gestao2016\Scripts\Banco2022\CriarTodasAsTabelas.sql:3225-3233`

## Fase 3 — Primeiro start (bootstrap automático)

- Substituir o executável pelo build novo e iniciar
- O `EnsureSincronia` roda no DataModuleCreate: cria a TB_LISTA_SINCRONIA se não existir e semeia os 38 registros (Seq 38 = transportadora, revisão de entidades 2026-07-25)
- Conferir: `SELECT COUNT(*) FROM TB_LISTA_SINCRONIA` → 38; Carta de Correção e os 7 rest* devem estar com SET_ON='N' (NFS-e nasce 'S' desde o patch 04)
- DESC_TRIGGER fica NULL — preencher manualmente só se o motor exigir

## Fase 4 — Sincronização inicial (UMA entidade por vez, ordem D8)

Ativar/testar nesta ordem, validando cada uma antes da próxima:

1. brand → 2. category → 3. measure → 4. package → 5. merchandise →
6. price-list → 7. price → 8. stock-list → 9. stock-balance →
10. promotion → 11. financial-plans → 12. payment-type →
12b. **carrier** (transportadora — ANTES do customer; revisão de entidades 2026-07-25) →
12c. salesman (idem — o customer referencia vendedor/transportadora por PAPEL) →
13. customer → 14. provider → 15. ~~salesman~~ (movido p/ 12c) → 16. bank-account →
17. order-sale → 18. order-purchase → 19. order-stock-adjust →
20. invoice → 21. invoice-merchandise → 22. stock-statement →
23. financial → 24. financial-statement → 25. cashier →
26. invoice-return-55 → 27. invoice-return-65 → 28. filexml

Validações por entidade:

- HTTP 200 com `{ok:true, id}` → registro marcado como enviado
- HTTP ≠ 200 → `{ok:false, error}` gravado em `TB_SINCRONIA.SRC_LOG`
- HTTP 409 `*_NOT_SYNCED` → dependência fora de ordem; o ciclo de 5 min reenvia sozinho (auto-cura) — não é erro de implantação
- Cadastro SEM CPF/CNPJ **ou com documento INVÁLIDO** (revisão de entidades: inválido = sem doc) → response traz `externalCode` → conferir gravação em `TB_EMPRESA.EXTERNALCODE` (ou `TB_COLABORADOR.EXTERNALCODE` no colaborador) e REENVIAR o registro → não pode duplicar (teste obrigatório)
- XMLs (filexml): conferir chegada em disco no servidor, estrutura `<cnpj>/<ano>/<mes>/`

## Fase 5 — Encerramento

- Deixar o ciclo automático rodando e acompanhar 2–3 ciclos completos
- Revisar `TB_SINCRONIA.SRC_LOG` — zerar pendências ou justificar
- Registrar: cliente, data, chave criada, versão do executável

## Fora do escopo desta implantação

- ~~NFS-e (invoice-return-service): só após aplicar o patch 04~~ **Patch 04 APLICADO em
  2026-07-25** — NFS-e entra na Fase 4 como entidade 29 (após filexml), nasce SET_ON='S'
  no seed novo; bancos já semeados precisam do UPDATE manual (ver patch 04)
- Carta de Correção (invoice-rectification): aguarda a Rodada 4 (endpoint não existe) — SET_ON='N'
- Sentido web → Firebird (GetSincronize): fase própria (D16), não mexer
