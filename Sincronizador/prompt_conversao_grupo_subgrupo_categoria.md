# Prompt — Conversão TB_GRUPOS/TB_SUBGRUPOS → TB_CATEGORY no bootstrap

**Escopo**: setes
**Origem**: rascunho do Valdo (2026-08-01) — "mudei a maneira como categorizar produtos:
Delphi usa tb_grupo/tb_subgrupo e a web tb_category; converter (não migrar) para a
estrutura de tabela única, vinculando tb_produto.PRO_CODCAT"
**Status**: ✅ IMPLEMENTADO (2026-08-01; limpeza prévia 2026-08-04) — aguarda compilação Delphi do Valdo
**Referências**: `prompt_construcao_banco_cliente.md` (bootstrap), `setes-sync/CONTRATOS_SYNC.md`
(/category e /merchandise), `setes-sync/MAPA_INDEXACAO.md` (linha 2 — Category),
`prompt_indexador_terminal_pdv.md` (perfil PDV)

---

## Contexto

O modelo novo de categorização de produtos é a `TB_CATEGORY` (mesma forma da web: árvore
por `POSIT_LEVEL`, caminho materializado `001.005` — porta do `@shared/tree-path`).
`TB_GRUPOS`/`TB_SUBGRUPOS` viram legado. Já existia uma rotina manual na tela de
configuração (`tas_config.Fc_GrupoToCategoria`) que dependia de clique, só cobria produto
com grupo E subgrupo e sobrescrevia `PRO_CODCAT` a cada execução.

## O que foi implementado

### 1. `DM.EnsureCategoryTable` (un_dm.pas — DDL, ANTES de EnsureTriggers)

- `GN_CATEGORY` + `TB_CATEGORY` (DDL fornecida pelo Valdo; PK em `ID` — na web a PK é
  id+institution, mas o banco local é de UMA instalação) + `TB_PRODUTO.PRO_CODCAT INTEGER`
  se faltar. Sintaxe válida em Firebird 2.5 e 5.0 (decisão 10 do bootstrap).
- Criada antes de `EnsureTriggers` para a `TG_SRC_CATEGORY` (catálogo Seq 3) nascer no
  mesmo start.

### 2. `DM.MigraGruposParaCategoria` (un_dm.pas — conversão, DEPOIS de EnsureTriggers)

- **Hierarquia de DOIS níveis**: grupo → categoria RAIZ (`POSIT_LEVEL` = id com 3 dígitos);
  subgrupo → FILHA do seu grupo (`INNER JOIN GRP_CODIGO = SBG_CODGRP`;
  `POSIT_LEVEL` = caminho do pai + `.` + id).
- **Ids NOVOS via GN_CATEGORY** — os códigos legados de grupo e subgrupo colidem entre si
  e não servem de id.
- **`PRO_CODCAT` na mesma passada, com SUBSTITUIÇÃO livre** (revisão do Valdo, 2026-08-01:
  o campo não está em uso): nível 2 pelo subgrupo (`PRO_CODSBG`) e, para produto SÓ com
  grupo (`PRO_CODSBG` vazio), a categoria raiz. O filtro `COALESCE(PRO_CODCAT,0) <> :id`
  nos UPDATEs existe SÓ para idempotência — UPDATE sem mudança ainda dispararia a
  `TG_SRC_PRODUTO` e reencheria a fila a cada start.
- **Idempotente por DESCRIÇÃO** (raiz = `POSIT_LEVEL` sem ponto; filha = debaixo do caminho
  do pai — mesma mecânica do `getAutoCreateBy*` do `ControllerDskCategory`): roda a cada
  start e converte também grupos que o desktop legado criar depois.
- **Passo 0 — LIMPEZA PRÉVIA** (Valdo, 2026-08-04): antes de converter, a rotina audita a
  `TB_CATEGORY` inteira contra os grupos/subgrupos materializados. Qualquer linha que a
  conversão NÃO produziria — raiz que não é grupo, filha que não é subgrupo do SEU grupo,
  3+ níveis, duplicata no mesmo nível, `POSIT_LEVEL` vazio (restos da rotina antiga do
  `tas_config`, testes, grupo renomeado no legado) — marca a tabela como SUJA: zera
  `TB_PRODUTO.PRO_CODCAT` (UPDATE dispara a TG_SRC_PRODUTO — produto sem grupo leva o NULL
  à web; os demais são regravados nos Passos 2/3), `DELETE FROM TB_CATEGORY` (não dispara
  trigger — TG_SRC_* não captura DELETE; quem viaja é a reconversão) e
  `SET GENERATOR GN_CATEGORY TO 0` (ids novos e compactos). Tabela já conforme passa
  ILESA — limpar a CADA start trocaria os ids e reencheria a fila (mesmo princípio do
  filtro `<>` dos UPDATEs).
- **Roda DEPOIS de EnsureTriggers de propósito**: os INSERT/UPDATE caem na `TB_SINCRONIA`
  e a web recebe categorias e produtos no ciclo normal (raízes antes das filhas;
  catálogo Seq 3 category < Seq 6 produto).
- `ENABLED` ← `GRP_ATIVO`/`SBG_ATIVO` (default 'S'); `DELETED` propagado; `KIND` = 'P';
  `TB_INSTITUTE_ID` = 1 (valor LOCAL — não viaja no /category/sincronize, D12).

### 3. `category_send_web.pas` — parentId REAL (fecha TODO antigo)

O `parentId` era hardcoded 0 (a hierarquia NUNCA chegava à web). Agora é derivado do
`POSIT_LEVEL`: o PENÚLTIMO segmento do caminho é o id do pai; sem ponto = raiz (0).
Pai ainda não sincronizado → 409 `PARENT_NOT_SYNCED` e a fila reprocessa (contrato Onda 3).

### 4. `tas_config.Fc_GrupoToCategoria` — delega ao motor do bootstrap

Vira reexecução manual de `DM.MigraGruposParaCategoria` (mesmo precedente do
`MnuPreparaLocal` → `EnsureSincronia`). Implementação antiga removida.

## Decisões registradas

1. **Conversão no bootstrap, não migração de dados avulsa** (Valdo, 2026-08-01) — roda
   sozinha na preparação do banco, a cada start, sem SQL manual por cliente.
2. **Dois níveis fixos** — nível 1 = grupo, nível 2 = subgrupo do grupo (INNER JOIN).
3. **Ids novos pelo GN_CATEGORY** — códigos legados não viram id (colisão grupo×subgrupo).
4. **`PRO_CODCAT` é SUBSTITUÍDO livremente** (revisão do Valdo, 2026-08-01) — o campo não
   estava em uso no legado, então a conversão manda nele; o filtro `<>` nos UPDATEs é só
   idempotência (não reencher a fila com UPDATE de linha já correta). SUPERADA a versão
   inicial "só preenche onde vazio".
5. **PDV não converte** (`GbTerminal <> 0` sai no início) — no PDV a conversão criaria ids
   próprios e colidiria com o que a retaguarda do Gestao2016 replicar (mesma pendência da
   replicação de EXTERNALCODE — Q8).
6. **parentId derivado do POSIT_LEVEL no envio** — sem FK de pai no Firebird; o servidor
   recalcula o `posit_level` dele pela árvore (nunca viaja).
7. **Limpar a tabela antes de converter** (Valdo, 2026-08-04) — a conversão só confia em
   `TB_CATEGORY` que ela mesma produziu. A limpeza é CONDICIONADA à detecção de sujeira
   (não incondicional): limpar a cada start trocaria os ids a cada start e reencheria a
   fila. Consequências aceitas: (a) grupo RENOMEADO no legado dispara UMA reconversão
   completa (ids trocam; antes a categoria órfã ficava para sempre); (b) se a web JÁ tinha
   recebido categorias da tabela suja, os ids antigos acima do novo máximo ficam órfãos lá
   (DELETE não viaja) — na implantação em curso a primeira carga resolve por upsert.
   ⚠️ Se um dia o desktop novo criar categoria PRÓPRIA direto na TB_CATEGORY de banco que
   ainda tem TB_GRUPOS, a detecção a veria como sujeira — nesse cenário a limpeza precisa
   de marca de origem (revisar antes).

## Critérios de sucesso

1. Bootstrap em banco legado: cada grupo vira categoria raiz, cada subgrupo vira filha,
   `PRO_CODCAT` preenchido (subgrupo > grupo-somente), tudo na `TB_SINCRONIA`.
2. Segundo start: nenhuma categoria duplicada, nenhum UPDATE em produto já categorizado.
3. Web recebe a árvore com a hierarquia correta (subgrupo debaixo do grupo, não raiz).
4. Grupo criado depois pelo desktop legado aparece como categoria no start seguinte.
5. Banco com TB_CATEGORY suja (restos da rotina antiga): start zera e reconverte do zero;
   o start SEGUINTE não limpa de novo (tabela conforme = ilesa).

## Pendências

- Compilação Delphi (Valdo).
- Fc_GrupoToCategoria antiga usava `getAutoCreateByGrupo/BySubGrupo` do
  `ControllerDskCategory` — as funções continuam existindo (outros fluxos), mas a
  conversão oficial é a do `un_dm`.
