# Verificação — comissão × margem no preço sincronizado + origem dos campos de mercadoria

**Status**: ✅ EXECUTADA 2026-10-17 (só leitura) · ✅ **Rodada DECIDIDA no mesmo dia** (Valdo: "pode seguir com as
recomendações" → D-SY1…D-SY7, §7) e EXECUTADA: patch 10 do sincronizador (aguarda compilação) + setes-sync (37/37 jest).
D-SY3 decidida mas TRAVADA pela D-SY4 (frente de comissão). ⚠️ As linhas citadas do `merchandise_send_web.pas`,
`merchandise.ts` e `ControllerPrice.pas` nos §1–§5 são as de ANTES do patch 10.
**Escopo**: setes
**Origem**: D-PR26 / Q-PR26 da frente de produtos (`Infra-IA/prompts/prompt_modulo_products.md` §13 + anexo 2
`prompt_modulo_products-legado-abas.md` §0.2 e §4) — tarefa do GRUPO DO SYNC (regra dos dois grupos: a frente de produtos
não lê setes-sync/sincronizador). Pedido junto: as perguntas de origem de campo do §12 e do anexo 2 §4.
**Referências**: `setes-sync/src/modules/sync/endpoints/price.ts`, `merchandise.ts`, `salesman.ts` ·
`sincronizador/classes/price_send_web.pas`, `merchandise_send_web.pas`, `salesman_send_web.pas` ·
`sincronizador/origen/model/tblPreco.pas`, `tblProduto.pas`, `tblcolaborador.pas` · `setes-api/src/shared/commission/commission.ts` ·
legado `D:\Gestao2016` (citado como `G16/…`). Docs vivos do sync: `MAPA_INDEXACAO.md`, `CONTRATOS_SYNC.md`.

---

## 1. Veredito: a inversão de 2013 NÃO existe no sync atual

O mapeamento invertido existe só no envio de 2013 (aposentado). Toda a cadeia de hoje grava a COMISSÃO em `aliq_kickback`
e a MARGEM em `aliq_profit`, que é o que o setes-api lê.

| Elo | Evidência | `PRC_AQ_COM` (comissão) → | `PRC_MAR_LRC` (margem) → |
|---|---|---|---|
| Envio de 2013 (aposentado) | `G16/Funcao/ws_gestao2013.pas:1605-1606` | `aliq_profit` ❌ | `aliq_kickback` ❌ |
| Roteador do legado | `G16/Roteador/function/un_server_to_web.pas:464`, `un_terminal_to_web.pas:1012` (`Comissao := AliComissao`) | `aliq_kickback` ✅ | `aliq_profit` ✅ |
| Sincronizador (modelo de origem) | `origen/model/tblPreco.pas:47-48` (`PRC_AQ_COM` = `AliComissao`), `:53-54` (`PRC_MAR_LRC` = `MargemLucro`) | — | — |
| Sincronizador (envio) | `classes/price_send_web.pas:54-55` | `aliqKickback` ✅ | `aliqProfit` ✅ |
| setes-sync | `price.ts:23-24` (DTO) e `:97-105` (INSERT/UPDATE com lista de colunas) | `aliq_kickback` ✅ | `aliq_profit` ✅ |
| setes-api (leitor) | `shared/commission/commission.ts:63-68` (com `kickback_product='S'`) | lê como comissão ✅ | — |

**Semântica no legado (conferida)**: `PRC_AQ_COM` é a comissão (a venda lê `select prc_aq_com …`, `G16/Tarefas/Un_Itens_Produto.pas:1868`);
`PRC_MAR_LRC` é a margem (`ChangePriceByMargem` / `Fc_CalcularMargemPeloPreco`, `G16/Arquivos/Un_Produtos.pas:3533`). No próprio
envio de 2013 a tabela de preço mandava `TPR_MAR_LRC aliq_profit` (`ws_gestao2013.pas:1562`, certo): a troca de 2013 foi só no `TB_PRECO`.

**Histórico (git)**: o sincronizador nunca inverteu — no commit inicial `61855af` (2026-07-04) o envio já fazia `Comissao := AliComissao`
(campo `aliq_kickback` do `TPrice`, serializado pelo `TJson.ObjectToJsonString`); `c2d791c` e `d89ddb2` mantêm `aliqKickback ← AliComissao`.
O setes-sync no commit inicial (`57d93d2`) nem gravava alíquota (só `value`); o `583ab6d` (2026-07-25) já grava certo. Não houve janela
em que o sync gravasse invertido.

### 1.1 Conhecimento negativo (armadilhas que ficaram)

- **`sincronizador/destiny/controller/ControllerPrice.pas:139-140` tem a inversão de 2013** (`updateList`: `MargemLucro ←
  aliq_kickback`, `Comissao ← aliq_profit`). Está DORMENTE: nenhum chamador (só declaração `:32` e corpo `:125`). Se o sentido web →
  Firebird (D16, fase própria) for montado reaproveitando este método, a inversão volta. → Q-SY2. **REMOVIDO (D-SY2,
  patch 10)** — no lugar ficou um comentário que proíbe ressuscitá-lo.
- **Legado, fora do sync**: a validação "Alíquota de comissão não pode ser zero" (config `PRO_VALIDA_AQ_COM`) confere a MARGEM
  (`G16/Arquivos/Un_Produtos.pas:1881`, `:1924`, `:2951`). A tela web não deve copiar essa regra.

## 2. Achado colateral — é ele que hoje desliga a comissão por produto do cliente sincronizado

O setes-api só usa a alíquota do produto quando `tb_salesman.kickback_product = 'S'` (`commission.ts:63`; domínio S/N em
`setes-api/src/modules/salesmen/salesmen.routes.ts:57`). O sync manda para essa coluna **outro campo do legado**:

- No legado, "recebe por produto" é **`CLB_COM_VDA = 'S'`** (`G16/Tarefas/Un_Itens_Produto.pas:1861`; `G16/Funcao/Un_Fc_Comissao.pas:1121`
  via `It_Mtz_Vendedores[2]`). **`CLB_CALC_COM_VDA`** é o MODO do cálculo (o valor `'C'` entra com a alíquota do cadastro do vendedor —
  `Un_Fc_Comissao.pas:1123`, `:1137`; `G16/Tarefas/Un_Itens_Produto_Ext.pas:1482` testa `'V'`).
- O modelo do legado dá o nome errado: `G16/model/tblcolaborador.pas:166-167` — `[FieldName('CLB_CALC_COM_VDA')] property
  ComissaoPorProduto` (o `CLB_COM_VDA` é `ComissaoVenda`, `:160-161`). O nome foi copiado para o Roteador
  (`un_server_to_web.pas:565`) e para o sincronizador (`origen/model/tblcolaborador.pas:165-166` → `classes/salesman_send_web.pas:256`:
  `kickbackProduct ← ComissaoPorProduto`).
- O setes-sync aceita qualquer caractere (`salesman.ts:37`) e grava como veio (`:115-123`).

**Efeito**: `kickback_product` recebe o modo do cálculo (`'C'`, `'V'`…), fora do domínio S/N ⇒ a comissão por produto **nunca liga** para
vendedor sincronizado: a web paga sempre a alíquota do vendedor, inclusive a quem o legado paga por produto. Não há reparo de `tb_price` a
fazer — o defeito está no flag do vendedor.

**Divergência de semântica (frente de comissão, não do sync)**: no legado, com "recebe por produto", a fórmula COMBINA a alíquota do
vendedor e a do item conforme `CLB_CALC_COM_VDA` (`Un_Itens_Produto.pas:1859-1878`, `Un_Fc_Comissao.pas:1121-1140`); o setes-api
SUBSTITUI pela alíquota do produto (`commission.ts:63-68`). Com `PRC_AQ_COM = 0` sincronizado como `0` (não NULL), ligar o flag sem
resolver isso faria a comissão cair a ZERO nesses produtos. → Q-SY3/Q-SY4 (a ordem importa).

## 3. Dimensionamento no MySQL de dev (2026-10-17, só SELECT em sessão READ ONLY)

O dev tem UM schema de cliente, `setes_setes` (a Setes; a "produção" de hoje é a mesma máquina). Não existe outro cliente sincronizado para medir.

| Medida | Valor |
|---|---|
| Schemas com `tb_price` / `tb_salesman` | 1 / 1 (`setes_setes`) |
| `tb_price` — linhas (vivas / apagadas) | 47 (44 / 3) |
| `tb_price` com `aliq_kickback` ≠ 0 | **0** |
| `tb_price` com `aliq_profit` ≠ 0 | 3 — 17500 · 4500 · 3000 (valores de margem; nenhuma comissão chega a isso), gravadas pela carga do piloto (2026-08-14 20:02 UTC), **na coluna certa** |
| Demais 31 linhas | nascidas no cadastro de serviços do setes-api (alíquotas NULL) |
| `tb_salesman` | 2 vivos: id 1 `kickback_product` NULL · id 264 **`'C'`** (carga de 2026-08-14 20:03 UTC — prova do §2) |
| Vendedores com `kickback_product='S'` | **0** |
| `tb_commission` | 4 lançamentos (alíquota do vendedor; nenhum por produto) |
| Mercadorias (`kind` P/M) | 1 (criada em 2026-09-09, fora da carga); 77 serviços |

Contraprova do risco: se a inversão existisse, a margem 17500 cairia em `aliq_kickback` e o `clampAliq` (`commission.ts:79-81`) a
transformaria em comissão de 100 %.

Conferência para repetir na implantação de cada cliente (só leitura; `<schema>` = schema do cliente):

```sql
SELECT tb_institution_id, COUNT(*) linhas, SUM(aliq_kickback <> 0) comissao_nz, SUM(aliq_profit <> 0) margem_nz,
       MAX(aliq_kickback) comissao_max, MAX(aliq_profit) margem_max
  FROM <schema>.tb_price WHERE deleted = 'N' GROUP BY 1;
SELECT kickback_product, COUNT(*) FROM <schema>.tb_salesman WHERE deleted = 'N' GROUP BY 1;
```

Assinatura de inversão: `comissao_max` com cara de margem (dezenas/centenas) e `margem_max` pequeno. Valor fora de S/N na 2ª consulta = §2.

## 4. Respostas à frente de produtos (anexo 2 §4 e §12 do prompt)

Caminho de toda a mercadoria: `TB_PRODUTO` → `origen/controller/ControllerProduto.pas` `FillDataObjects` → `classes/merchandise_send_web.pas`
`GenerateJson` → `setes-sync/…/merchandise.ts`.

| Coluna web | Origem no Firebird | Sincronizador | setes-sync | Observação |
|---|---|---|---|---|
| `tb_stock.codebar` | `PRO_CODIGOBAR` (`tblProduto.pas:143-144`) | `merchandise_send_web.pas:167` | `merchandise.ts:67` (até 20), `:298`/`:307` | sem validação GS1/DV — o item (3) do §12 vale como está |
| `tb_stock.st` | `PRO_SUB_TRIB` (`:221-222`) | `:168` | `:68` (`snFlag('N')`) | — |
| `tb_stock.outline` | `PRO_FORA_LINHA` (`:275-276`) | `:179` | `:81` | status de catálogo guardado no estoque (anexo 2 §3) |
| `tb_merchandise.composition` | `PRO_COMPOSICAO` como está, `'1'`…`'6'` (`G16/Arquivos/Un_Produtos.pas:1009-1014`) | `:157` | `:60` (`legacyChar` — decisão do Valdo de 2026-08-01) | o Swagger (`merchandise.ts:148`) e o `CONTRATOS_SYNC.md:144` ainda dizem S/N — desatualizados |
| `tb_merchandise.manuf_sign_ind_scale` | **nenhuma** — o sincronizador manda `'N'` FIXO | `:158-159` | `:61` | ⚠️ o TODO "Firebird não tem campo equivalente" é FALSO: o modelo tem `[FieldName('INDESCALA')] IndicacaoEscala` (`tblProduto.pas:281-282`), nunca lido; o legado grava S/N com padrão marcado (`Un_Produtos.pas:1033`, `:1344`). Todo produto sincronizado diz "escala NÃO relevante" — conferir no acervo da NE-4 se isso exige CNPJFab → Q-SY5 |
| `tb_merchandise.kind_tributary` | `PRO_TRIBUTACAO` (finalidade 1–7) como está (`:260-261`) | `:150` | `:51` (1 caractere) | sem tradução para o 0–7 da API |
| `PRO_CODMED_TRIB` | no modelo (`MedidaTributavel`, `:158-159`) | **não enviado** (nunca lido) | — | unidade tributável não chega à web |
| `PRO_QTDE_TRIB` | fora do modelo | **não enviado** | — | idem (achado 0.1); é o pedido (2) do §12 |
| unidade / embalagem / divisor | `PRO_CODMED` / `PRO_CODEMB` / `PRO_DIVISOR` | `:166` / `:165` (pela descrição) / `:169` | `:203`/`:202` (catálogo central) / `:71` (0 aceito) | insumo do mapa legado → níveis do §12 |
| `tb_merchandise.application` | `PRO_APLICACAO` | `:156`, sem decodificar | `:57`, `:265` (como veio) | **chega em Base64**: o legado grava `EncodeBase64(AnsiString(...))` (`Un_Produtos.pas:1018`) e lê `DecodeBase64` (`:1469`); o sincronizador não decodifica (o único Base64 dele é o do XML, `file_send_web.pas`). Decodificado dá bytes na página de código ANSI do Windows, não UTF-8. Linhas gravadas antes do Base64: não mensurável no dev (0 linhas) → Q-SY6 |
| `identifier` e `id_internal` | ambos `PRO_CODIGOFAB` | `FillDataObjects` | `:233`, `:262` | confirma a duplicata do anexo 2 §3 |
| `tb_product.tb_category_id` | `PRO_CODCAT`; ≤ 0 vira **2** fixo | `FillDataObjects` | `:216-225` (409 se não sincronizada) | após o bootstrap, `PRO_CODCAT` é a árvore de grupo/subgrupo (`Sincronizador/prompt_conversao_grupo_subgrupo_categoria.md`) |

**Gravação por lista de colunas** (item (4) do §12): o setes-sync faz UPDATE com colunas explícitas nas três tabelas
(`merchandise.ts:238-244`, `:270-276`, `:306-312`) — nunca REPLACE; o UPDATE de `tb_stock` preserva `quantity`/`minimum`. Coluna nova em
`tb_merchandise` não é apagada pelo sync.

### 4.1 `TB_PRODUTO` compartilhado por N estabelecimentos do mesmo Firebird

- O sincronizador tem **UMA chave por instalação** (`SISWEB\FApiKey`, `function/un_sincroniza.pas:71`, `:81`, `:100`); o setes-sync resolve
  institution e schema pela chave (D12). **Nenhuma classe de envio lê `*_CODMHA`** (busca em `classes/` e `function/`: zero; o único uso
  no controller de produto é `DesativarTodos`, `ControllerProduto.pas:304-318`, fora do envio). `PRO_CODMHA` consta como "NÃO MAPEADO"
  em `Sincronizador/Documentacao.md:225`.
- Logo, o produto (PK só `PRO_CODIGO`, sequência única) chega **UMA vez**, na institution da chave, com `id = PRO_CODIGO`. Não há
  distribuição por estabelecimento: os outros estabelecimentos do mesmo Firebird não existem como institutions para o sync.
- Corolário (não aprofundado aqui): os MOVIMENTOS de um Firebird com vários estabelecimentos também vão todos para a institution da chave.
  O sync assume hoje 1 Firebird = 1 estabelecimento. Encosta na frente "matriz × filiais" (§11 do prompt de produtos) → Q-SY7.

## 5. Desvios de documentação achados (corrigir junto com a correção que o Valdo decidir)

- `CONTRATOS_SYNC.md:144` (`"composition": "N"`, `"manufSignIndScale": "S"`) e `:288` (`"kickbackProduct": "S"`) não batem com o que o
  Delphi manda (`'1'`…`'6'`, `'N'` fixo, modo do cálculo).
- Swagger de `merchandise.ts:148` (`composition` enum S/N).
- TODO falso em `merchandise_send_web.pas:158`.

## 6. Questões para o Valdo (rodada do grupo do sync) — TODAS DECIDIDAS em 2026-10-17 pela recomendação (§7)

**Q-SY1 — Q-PR26 (inversão comissão × margem).** **(a)** encerrar a D-PR26 como "não procede no sync atual", sem script de reparo (o
sync nunca gravou invertido; dev com 0 linhas), e pôr a conferência do §3 no roteiro de implantação **(Recomendado)** · (b) script de
reparo mesmo assim.

**Q-SY2 — `ControllerPrice.updateList` com a inversão, sem chamador.** **(a)** remover o método morto do sincronizador (a direção web →
Firebird, D16, será escrita na fase própria) **(Recomendado)** · (b) corrigir as 2 linhas e manter · (c) deixar com este aviso.

**Q-SY3 — flag "comissão por produto" do vendedor.** **(a)** o Delphi passa a mandar `kickbackProduct ← CLB_COM_VDA` (S/N), o setes-sync
valida S/N (`snFlag`), e o reparo é reenfileirar os colaboradores (o dado certo está no Firebird); o modo do cálculo (`CLB_CALC_COM_VDA`)
não ganha casa agora — nasce com a frente de comissão se for preciso **(Recomendado — "quem aposenta se adapta", D15; só DEPOIS da
Q-SY4)** · (b) o setes-sync traduz · (c) manter como está.

**Q-SY4 — semântica da comissão por produto (decisão da frente de comissão, registrada aqui porque trava a Q-SY3).** Legado combina
vendedor + item conforme o modo; setes-api substitui pela alíquota do produto. **(a)** a frente de comissão decide antes de ligar a Q-SY3;
até lá o flag fora do domínio é inofensivo (comissão = alíquota do vendedor para todos) **(Recomendado)** · (b) ligar a Q-SY3 já, aceitando
comissão zero nos produtos com `PRC_AQ_COM = 0`.

**Q-SY5 — indEscala fixo em 'N'.** **(a)** o sincronizador lê `INDESCALA` (o modelo já tem) e manda; reenvio dos produtos; entra no mesmo
pacote do §12 (antes de um cliente sincronizado emitir pela nfe-api) **(Recomendado)** · (b) esperar a NE-4/D-PR10.

**Q-SY6 — `PRO_APLICACAO` em Base64.** **(a)** o sincronizador decodifica (Base64 → texto ANSI → UTF-8) antes de enviar, tolerando valor
que não seja Base64 (manda como está), + reenvio **(Recomendado — contrato com texto limpo)** · (b) o setes-sync decodifica · (c) a web lê
Base64.

**Q-SY7 — Firebird com vários estabelecimentos.** **(a)** até a frente "matriz × filiais": limite registrado — o roteiro de implantação
pergunta quantos estabelecimentos o Firebird tem e só implanta com 1; depois, o sync ganha chave por estabelecimento + filtro por
`*_CODMHA` nos movimentos + o catálogo compartilhado pela chave do catálogo (§11 do prompt de produtos) **(Recomendado)** · (b) aceitar
tudo numa institution.

## 7. Decisões arquiteturais registradas

### Rodada 1 — FECHADA (Valdo, 2026-10-17: "pode seguir com as recomendações")

- **D-SY1**: a D-PR26 fecha como "não procede no sync atual" — sem script de reparo (o sync nunca gravou invertido; dev
  com 0 linhas). A conferência do §3 entrou no `Sincronizador/roteiro-implantacao-cliente.md` (Fase 5): rodar em cada
  implantação; assinatura de inversão = parar e avisar o Valdo.
- **D-SY2**: `ControllerPrice.updateList` (destiny, sem chamador, com a inversão de 2013) REMOVIDO do sincronizador
  (patch 10). A direção web → Firebird (D16) se escreve na fase própria.
- **D-SY3** (decidida, **TRAVADA pela D-SY4**): o Delphi passará a mandar `kickbackProduct ← CLB_COM_VDA` (S/N), o setes-sync
  valida S/N (`snFlag`) e o reparo é reenfileirar os colaboradores (Primeira carga → Colaboradores). O modo do cálculo
  (`CLB_CALC_COM_VDA`) não ganha casa agora. Registrado no `CONTRATOS_SYNC.md` (seção do /salesman) para ninguém executar antes.
- **D-SY4**: a fórmula da comissão por produto (legado combina vendedor + item conforme o modo; setes-api substitui) é decisão
  da FRENTE DE COMISSÃO e vem ANTES da D-SY3; até lá o flag fora do domínio é inofensivo (comissão = alíquota do vendedor
  para todos). Pesa na D-PR9 (comissão na grade de preço) da frente de produtos.
- **D-SY5**: indEscala real — o sincronizador manda `INDESCALA` (S/N; fora disso `''`), e o setes-sync grava vazio/ausente
  como NULL ("não informado"; antes o default `'S'` inventava "relevante"). Patch 10 + `merchandise.ts` + teste
  `src/__tests__/merchandise.body.test.ts`. Produtos já sincronizados: reenvio (Primeira carga → Produtos, sem período).
- **D-SY6**: `PRO_APLICACAO` decodificado no sincronizador do mesmo jeito do legado (`String(DecodeBase64(AnsiString(...)))`,
  synacode), tolerando valor que não tenha forma de Base64 (segue como está). Mesmo reenvio da D-SY5.
- **D-SY7**: até a frente "matriz × filiais", 1 Firebird = 1 estabelecimento é LIMITE do sync — o roteiro de implantação
  (Fase 0) confere `NFL_CODMHA`/`PED_CODMHA` e não implanta Firebird com mais de um estabelecimento com movimento. O desenho
  definitivo (chave por estabelecimento + filtro por `*_CODMHA` + catálogo compartilhado) nasce com aquela frente.

**Desvios de documentação do §5**: corrigidos (`CONTRATOS_SYNC.md`, Swagger do `merchandise.ts`, TODO falso removido).

**Prova e gates da execução (2026-10-17)**:
- setes-sync: `npm test` 37/37 (5 novos em `merchandise.body.test.ts`), `tsc --noEmit` limpo. Smoke contra o banco NÃO rodado
  (gravaria no `setes_setes`, que é a produção de hoje) — a gravação mudou só `?? null` no valor do indEscala.
- Sincronizador: `msbuild Sincronizador.dproj` (Debug/Win32) com saída numa pasta TEMPORÁRIA — 0 erro, 0 aviso nas units
  alteradas; `merchandise_send_web.dcu` gerado. O `destiny/controller/ControllerPrice.pas` NÃO entra no executável e nem compila
  neste projeto (o `BaseController` do destiny usa `MainModule`, do uniGUI) — a remoção da D-SY2 não muda o binário.
  O executável oficial, a execução e o reenvio continuam com o Valdo.
- Gate socrático (inline, proporcional ao delta): **0,82** — pontos abertos: (1) a NE-4 precisa ler NULL como "omitir a tag"
  (registrado no `CONTRATOS_SYNC.md` e no §13 do prompt de produtos); (2) Base64 decodificado com a página ANSI da máquina que
  roda o sincronizador — outra localidade troca acentos (mesma premissa do legado); (3) produtos já gravados ficam com `'N'`
  até o reenvio.
- Gate adversarial (inline): **0,80, sem HIGH/CRITICAL** — LOW: texto puro com forma de Base64 e sem caractere de controle
  depois de decodificado seria decodificado (o legado faz o mesmo ao abrir a tela); LOW: payload sem o bloco `merchandise`
  regrava o indEscala como NULL (antes regravava `'S'`; nenhum envio atual omite o bloco). `null` JSON e minúscula seguem
  recusados com 400, como antes (o Delphi normaliza).

**Fora da rodada (achado ao executar)**: o fallback de `GetBrandName` em `merchandise_send_web.pas:38` perdeu o "Ã" numa
conversão antiga — o arquivo guarda o caractere de substituição U+FFFD (bytes EF BF BD, arquivo UTF-8 SEM BOM, que o Delphi
lê como ANSI). Quando a marca não existe no Firebird, sai `N` + lixo + `O INFORMADA` e o setes-sync cria uma marca CENTRAL
com esse nome (o fallback do servidor só vale para descrição vazia). Dev: nenhuma marca assim em `setes_central.tb_brand`
(latente). Não corrigido aqui (tarefa própria — trocar o literal por ASCII `'NAO INFORMADA'` ou mandar vazio e deixar o
fallback do setes-sync agir).
