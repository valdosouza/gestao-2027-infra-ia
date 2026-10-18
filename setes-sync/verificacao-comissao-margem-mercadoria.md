# Verificação — comissão × margem no preço sincronizado + origem dos campos de mercadoria

**Status**: ✅ EXECUTADA 2026-10-17 (só leitura) · §8 = pedidos da frente de produtos de 2026-10-18 (só leitura; respostas do Valdo no §8.6 — D-SY8, D-SY10 e D-SY11 a executar) · §9 = Rodada 5 de produtos (D-SY12 e D-SY13 decididas no §9.4; §9.5–9.6 Q-SY14 decidida = `tb_terminal` (D-SY14, frente transversal a abrir); D-SY10, D-SY11 e D-SY13 EXECUTADAS no §10 — patch 11 + setes-sync 76/76, gates 0,72/0,76; A-SY1 e Q-SY15…Q-SY23 aguardam o Valdo; ⏯ retomar pelo §10.7, nada commitado) · ✅ **Rodada DECIDIDA no mesmo dia** (Valdo: "pode seguir com as
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

O dev tem UM schema de cliente, `setes_setes` (a Setes; NADA do Gestão 2027 está em produção — Valdo, 2026-10-18: é o ambiente de desenvolvimento e ensaio). Não existe outro cliente sincronizado para medir.

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
  (gravaria no `setes_setes`, o schema de ensaio do dev) — a gravação mudou só `?? null` no valor do indEscala.
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

## 8. Pedidos da frente de produtos — Rodada 4 dela (2026-10-18, SÓ LEITURA)

Origem: mensagem da sessão de produtos (D-PR35/D-PR37/D-PR39/Q-PR38' do `prompts/prompt_modulo_products.md` §18). Nada foi alterado
em código nem em dado; as linhas citadas do `merchandise.ts` são as de DEPOIS do patch D-SY5 (+3).

### 8.1 D-PR37 — `DELETE`/`REPLACE INTO`/`TRUNCATE` (regra do `PADROES_BANCO.md` §3.1)

- **setes-sync, código do serviço (`src/`, fora testes)**: ZERO. Exclusão é sempre `deleted = 'S'` (endereço/fone/rede social/fiscal da cadeia,
  itens e ramos das ordens, itens da promoção) e o `/merchandise` com `deleted='S'` só marca as 3 linhas. Nenhum `REPLACE INTO`/`TRUNCATE`.
  Os únicos `DELETE` de `src/` estão em `src/__tests__/sync.entity.test.ts:66-71,216-217` (limpeza das linhas que o teste cria).
- **`tb_merchandise` e a 071**: INSERT e UPDATE com LISTA de colunas (`merchandise.ts:273-279` e `:283-288`) — as 2 colunas novas da 071
  (`taxable_trade_level`/`default_sale_trade_level`) nascem NULL e o UPDATE não as toca. Só o `merchandise.ts` escreve em `tb_merchandise`.
  A 071 não cria níveis para produto existente (sem INSERT) e o sync nunca apaga produto ⇒ nenhum caminho do sync dá 1451.
- **setes-sync, scripts** (rodam à mão, contra o `setes_setes` — ambiente de ensaio; nada está em produção):
  - `scripts/smoke-*.ts` apagam FISICAMENTE o que criaram (produto, mercadoria, estoque, preço, categoria, ordens, notas, financeiro,
    entidades e itens CENTRAIS de marca/embalagem/medida/forma por descrição). ⚠️ `smoke-onda3.ts:71` apaga `tb_category` por FAIXA
    (`id BETWEEN 900 AND 904`) — num schema real com essas ids apagaria categoria verdadeira.
  - ⚠️ **`scripts/reset-institution-sync-data.ts`** (2026-08-09): `SET FOREIGN_KEY_CHECKS=0` + `DELETE FROM` em 35 tabelas do schema
    (inclui `tb_product`, `tb_merchandise`, `tb_price`, `tb_category`, `tb_stock`) **e `DELETE FROM` em `tb_entity`/`tb_company`/
    `tb_person`/`tb_no_doc`/`tb_address`/`tb_phone` da `setes_central` com `WHERE id <> KEEP_ENTITY_ID`** — o comentário diz "só as
    entidades desse institution", o código apaga as de TODOS os clientes e das próprias institutions. Fixo em `setes_pipoteca` (schema que
    já não existe no dev), dry-run por padrão, `--confirm` executa. Não conhece a `tb_merchandise_trade_unit` (com as FKs desligadas
    deixaria níveis órfãos).
- **Sincronizador**: não escreve no MySQL (os controllers `destiny/` — acesso direto ao MySQL — não entram no executável; build de
  conferência de 2026-10-17: só o `TypesCollection` de `destiny/controller`). No Firebird, o que roda de fato é técnico ou documentado:
  fila `TB_SINCRONIA` (limpeza de 48h em `ControllerSincronia.pas`; `un_dm.pas:417` e `:1032` no bootstrap), catálogo
  `TB_LISTA_SINCRONIA` (`un_dm.pas:393-407`, Seqs aposentadas) e `TB_CATEGORY` (`un_dm.pas:948`, limpeza prévia da D7 da conversão
  grupo/subgrupo, com motivo no `Sincronizador/prompt_conversao_grupo_subgrupo_categoria.md`). Os `DELETE` dos controllers copiados do
  legado (`ControllerProduto.deleteaLL`, `ControllerTabelaPreco.DeleteItens`, `ControllerPedido*`, `ControllerFinanceiro.deleteByNota`…)
  compilam mas não têm chamador nos fluxos (envio, recebimento, bootstrap, primeira carga); `function/un_adjust_invoice.pas` nem compila.

### 8.2 D-PR39 — unidade de medida deduplicada pela ABREVIAÇÃO (o que muda no setes-sync)

Hoje: `sync.catalog.ts:26-66` deduplica TODO catálogo central por `UPPER(TRIM(description))` binário (D17); o `/measure`
(`measure.ts:66`) e o `/merchandise` (`merchandise.ts:209`) chamam por DESCRIÇÃO — o Delphi manda `stock.nameMeasure` = `MED_DESCRICAO`
(`merchandise_send_web.pas`, `GetMeasureName`) e o fallback `'UND'` é usado como DESCRIÇÃO (no dev, `UND` é a abreviação da linha
"UNIDADE": um produto sem medida criaria uma 2ª linha "UND" sem abreviação). O que mudaria:
1. `ensureCatalogItem` passa a receber a chave por tabela (a mesma `dedupeBy` da peça `@shared/central-catalog` do setes-api — medida =
   `abbreviation`), com a mesma comparação `UPPER(TRIM(x)) COLLATE utf8mb4_bin`; a descrição vira atributo gravado só na criação.
2. `/measure` exige a abreviação (o legado tem `MED_ABREVIATURA`; medida sem ela → regra a decidir, Q-SY10).
3. Contrato do `/merchandise`: o Delphi passa a mandar a ABREVIAÇÃO da medida (campo novo, ex. `stock.measureAbbreviation`; "quem
   aposenta se adapta") e o fallback `'UND'` vira abreviação.
4. ⚠️ **Trava**: o sync cria item central com `FOR UPDATE` + `MAX(id) FOR UPDATE` (o que a regra 11 do `PADROES_BANCO.md` §9 provou que
   não serializa: 1213) e SEM a trava nomeada do setes-api (`GET_LOCK('setes_central.<tabela>', 10)`, `@shared/central-catalog`). Com os
   dois escrevendo, a mesma abreviação pode nascer duas vezes. O sync precisa adotar a MESMA trava, com o MESMO nome.
5. Ordem: o lado do sync entra ANTES ou JUNTO do setes-api — enquanto um deduplica por descrição e o outro por abreviação, o catálogo
   central ganha linhas repetidas. Dev hoje: 3 medidas (UNIDADE/UND, KILOGRAA/KG, LITRO/LT), nenhuma abreviação repetida.

### 8.3 D-PR35 — `tb_measure.abbreviation` de 5 para 6

O legado manda no máximo 5: `MED_ABREVIATURA` é o domínio `"Descricao_5"` = `VARCHAR(5)` (`G16/Scripts/dominios.sql:29`;
`CriarTodasAsTabelas.sql:2067`). O `/measure` valida `max(5)` (`measure.ts:19`), que continua cabendo numa coluna de 6. Alargar para 6
**não quebra nada** do sync. No dev a maior abreviação tem 3 caracteres.

### 8.4 Q-PR38' — `kind` das categorias sincronizadas

- **Toda categoria sincronizada é `'P'`**: a conversão grupo/subgrupo grava `KIND = 'P'` fixo (`un_dm.pas:768-774`), o
  `category_send_web.pas:53` manda esse KIND e o setes-sync troca vazio por `'P'` (`category.ts:26-29`).
- **O legado não marca categoria de serviço**: `TB_GRUPOS`/`TB_SUBGRUPOS` não têm coluna de tipo (`CriarTodasAsTabelas.sql:1413-1426`).
  O único sinal é o `PRO_TIPO = 'S'` dos produtos dentro do grupo (um grupo pode misturar).
- O `/service` não confere o kind da categoria (`service.ts:97-101`). Dev: 2 categorias "GERAL" `'P'` (ids 8 e 9) com os 77 serviços.
- ⚠️ O sync REGRAVA `tb_category_id` do produto a cada envio (`service.ts:121`, `merchandise.ts:243`) — recategorizar na web um
  produto sincronizado se perde no próximo envio.

### 8.5 Questões para o Valdo (grupo do sync)

**Q-SY8 — `reset-institution-sync-data.ts`.** **(a)** remover o script (reset de cliente de teste = apagar o schema/institution pelo
onboarding do setes-api, não por DELETE solto na central) **(Recomendado)** · (b) reescrever escopado (só entidades sem papel em outro
schema) e registrar como exceção do §3.1 · (c) manter.

**Q-SY9 — smokes com DELETE físico no `setes_setes`.** **(a)** registrar como exceção do §3.1 "o smoke apaga só o que ele mesmo criou,
por id exato" e trocar a faixa do `smoke-onda3.ts:71` por ids exatos; rodar smokes num schema/institution descartável quando houver
**(Recomendado)** · (b) converter para soft delete · (c) manter.

**Q-SY10 — executar a D-PR39 no sync.** **(a)** itens 1–5 do §8.2: chave por tabela no `ensureCatalogItem`, abreviação obrigatória no
`/measure` (medida sem abreviação no legado resolve pela descrição, como hoje, com aviso no log), abreviação no contrato do `/merchandise`
(patch no Delphi + reenvio dos produtos) e a trava nomeada do setes-api, entrando antes ou junto do merge do setes-api
**(Recomendado)** · (b) o sync segue pela descrição e a divergência fica como limite conhecido.

**Q-SY11 — insumo para a Q-PR38'.** **(a)** sem mudança no sync: a web aceita serviço em categoria `'P'` para cliente sincronizado
**(Recomendado do lado do sync — é o que o legado tem)** · (b) a conversão do bootstrap marca `'S'` o grupo/subgrupo cujos produtos são
TODOS `PRO_TIPO = 'S'` (grupo misto fica `'P'`) + reenvio das categorias.

### 8.6 Respostas do Valdo (2026-10-18)

- **Fato corrigido**: NADA do Gestão 2027 está em produção — o `setes_setes` e a máquina do Valdo são ambiente de desenvolvimento e
  ensaio. As NFS-e emitidas no ambiente de PRODUÇÃO do fisco foram testes, feitas porque a homologação estava com problema (já resolvido).
- **D-SY8** (= Q-SY8): o `reset-institution-sync-data.ts` é ferramenta de ENSAIO em ambiente de teste e "eventualmente vai morrer" —
  fica, registrado como exceção no `PADROES_BANCO.md` §3.1. Os smokes seguem a mesma natureza (apagam o que criaram, no ambiente de ensaio)
  e entraram na mesma linha da exceção.
- **D-SY10** (= Q-SY10, D-PR39): medida é ÚNICA na `setes_central` e a busca pela ABREVIAÇÃO existe para unificar o cadastro de todos os
  clientes; **o setes-sync e o setes-api usam a MESMA sistemática** (chave = abreviação, `UPPER(TRIM(x))` binário, e a mesma trava nomeada
  `GET_LOCK('setes_central.tb_measure')`). Execução = itens 1–5 do §8.2 (a fazer).
- **D-PR35**: ok (5 → 6 não quebra o sync).
- **D-SY11** (= Q-SY11, Q-PR38'): existe categoria por natureza — MERCADORIA = `'P'`, SERVIÇO = `'S'` — e a recategorização acontece
  OBRIGATORIAMENTE NA ORIGEM (sincronizador), nunca na web. **Checagem pedida pelo Valdo** ("tratamos isso no sincronizador quando ele
  inicia — checar"): o tratamento existe — o "Preparar o banco" (`MnuPreparaLocalClick` → `DM.EnsureSincronia(True)` →
  `MigraGruposParaCategoria`, `un_dm.pas:731-1022`; o start automático NÃO converte, `un_dm.pas:1049-1061`) converte grupo/subgrupo em
  `TB_CATEGORY` e reaponta `PRO_CODCAT` — mas **ignora o `PRO_TIPO`**: toda categoria nasce `'P'` (`un_dm.pas:768-774`) e os serviços são
  reapontados para a mesma categoria das mercadorias (Passos 2/3, `un_dm.pas:1006-1022`). Resultado no dev: os 77 serviços em 2 categorias
  "GERAL" `'P'`. Ajuste proposto (a fazer): a conversão separa por natureza — para cada grupo/subgrupo nasce a categoria `'P'` se houver
  produto `P`/`M` nele e a categoria `'S'` (mesmo nome, árvore `'S'` própria) se houver serviço; cada produto é reapontado para a
  categoria da SUA natureza; o `category_send_web` já manda o KIND. Depois do reenvio, o setes-sync pode recusar serviço em categoria
  `'P'` (e mercadoria em `'S'`) — hoje o `/service` não confere (`service.ts:97-101`).

## 9. Pedidos da frente de produtos — Rodada 5 dela (2026-10-18, SÓ LEITURA)

### 9.1 D-PR41 — de onde vem o `tb_product.id` do que chega do legado

- **É o `PRO_CODIGO`, sem remapeamento**: o Delphi manda `id = FCtrl.Registro.Codigo` (`merchandise_send_web.pas`, `service_send_web.pas:70`)
  e o setes-sync faz upsert pela PK `(id, tb_institution_id)` — `SELECT … FOR UPDATE` e depois UPDATE ou INSERT (`merchandise.ts:228-257`,
  `service.ts:108-139`). Não há externalCode/UUID para produto (`MAPA_INDEXACAO.md` #5/#5b: "ID LOCAL ✅", mesmo espaço para P/M/S). O
  legado gera o código pelo `GN_PRODUTO` (`ControllerProduto.insert`).
- **Colisão**: a premissa do "ID LOCAL" é que só o legado cria a linha. Com a D-PR41 a web cria `tb_product` por MAX+1 no MESMO espaço:
  - **legado → linha da web**: quando o gerador do legado chegar a um id que a web já usou, o envio SOBRESCREVE a linha — o UPDATE troca
    `kind`, `identifier`, `description`, `tb_category_id`, `active`, `deleted` (`service.ts:118-125`; o `/merchandise` ainda cria
    `tb_merchandise`/`tb_stock` com esse id). Sem erro e sem aviso: o serviço da web vira o produto do legado. O preço da web na `tb_price`
    (PK institution + tabela + produto) também é sobrescrito pelo preço do legado.
  - **web → código do legado**: a web não colide com o que já chegou (o MAX+1 pula), mas pega códigos que o legado ainda vai gerar — dá no
    mesmo caso acima, mais tarde.
- **Dev (`setes_setes`, que tem a chave do sincronizador)**: ids 1–15 vieram da carga do legado (10/08); 16–79 nasceram na web e nos
  ensaios (24/08 a 15/10). O próximo código que o `GN_PRODUTO` da Setes gerar (não li o Firebird) cai em cima de uma dessas linhas.
- Vale o mesmo para qualquer tabela "ID LOCAL ✅" do MAPA em que a web passar a criar linha num cliente com sincronizador (categoria,
  tabela de preço…).

### 9.2 D-PR43 — chave do sincronizador inativa

- **O setes-sync recusa**: `resolveApiKey` só aceita `active = 'S' AND deleted = 'N'` (`sync.auth.middleware.ts:31-36`) e responde
  **401 `{ok:false, error:'API Key invalida'}`** (`:61-64`) — a mesma resposta da chave inexistente. ⚠️ A chave VÁLIDA fica em cache
  por **5 minutos** no processo (`:22-29`; o negativo não é guardado): desativar vale em até 5 min.
- **O sincronizador não para nem tenta de novo**: o status HTTP vai para `Retorno.ID` (`general_web.pas:209`) e a mensagem do corpo
  ("API Key invalida") vai para o `SRC_LOG` de CADA registro da fila tentado no ciclo (`un_send_to_web_server.pas:100-110`); o checkpoint
  só anda no 200. A fila só pega `SRC_LOG` vazio (`ControllerSincronia.pas:407,425,495`) e a limpeza de 48h só apaga `SRC_LOG = 'OK'` ⇒
  tudo que mudou enquanto a chave estava inativa fica ESTACIONADO para sempre. Ao reativar a chave, nada reenvia sozinho: é preciso limpar
  a marca (`UPDATE TB_SINCRONIA SET SRC_LOG = NULL WHERE SRC_LOG IS NOT NULL AND SRC_LOG <> '' AND SRC_LOG <> 'OK'` —
  `Sincronizador/roteiro-implantacao-cliente.md`, "Reenviar registros que FALHARAM"). O ciclo segue até o fim, um 401 por registro.

### 9.3 Questões para o Valdo (grupo do sync)

**Q-SY12 — identidade do produto criado na web em cliente com sincronizador (D-PR41).** **(a)** o que nasce na web nesse cliente usa uma
FAIXA de id que o legado não alcança (ex.: a partir de 1.000.000.000 — o MAX+1 da peça `@shared/product-id` passa a ser calculado dentro
da faixa) e o setes-sync recusa (409, nunca sobrescreve) produto do legado com id dessa faixa — prevenção + cinto **(Recomendado)** · (b)
só a guarda no setes-sync: id do legado que cai numa linha nascida na web → 409 e o produto do legado fica estacionado até resolver à mão
(exige gravar a ORIGEM da linha) · (c) o serviço criado na web desce para o legado (direção web → Firebird, D16 — fase própria) e o código
passa a ser do legado.

**Q-SY13 — chave inativa (D-PR43).** **(a)** o setes-sync responde um código próprio para chave existente e inativa (ex.: 403
`SYNC_KEY_INACTIVE`) e o sincronizador, ao receber recusa de AUTENTICAÇÃO (401/403), PARA o ciclo sem marcar o `SRC_LOG` — os registros
seguem pendentes e vão sozinhos quando a chave voltar; os 5 min de cache ficam como limite conhecido **(Recomendado)** · (b) manter: cada
registro do ciclo fica estacionado com "API Key invalida" e a reativação exige o UPDATE do roteiro.

### 9.4 Respostas do Valdo (2026-10-18)

- **D-PR41 revista (frente de produtos)**: a web NÃO insere nada num cliente com chave de sincronia ATIVA — tudo o que é relacionado a
  produto; a guarda vira um MÉTODO aplicado cadastro a cadastro, conforme cada caso. (Execução no setes-api — frente de produtos.)
- **D-PR42**: ok (frente de produtos).
- **D-SY12** (= Q-SY12): sem faixa de id agora. Enquanto o desktop existir, a web não cria produto em cliente com sincronizador (acima), então
  não há colisão. O desktop vai morrer; o que fica é o PDV — e para o PDV a atualização é INVERSA: o cadastro é inserido e atualizado na WEB
  e replicado na base local (a direção web → Firebird da D16, fase própria). Aí o id passa a ser da web.
- **D-SY13** (= Q-SY13): o sincronizador que recebe chave inativa fica INATIVO e PARA a sincronia; só volta quando o usuário ATIVAR
  manualmente, depois que a chave voltar a ficar ativa. Enquanto a chave estiver inativa, toda tentativa manual fica inerte. Desenho para a
  execução: (1) o setes-sync distingue a chave existente e inativa (código próprio, ex.: 403 `SYNC_KEY_INACTIVE`) da chave inexistente (401);
  (2) o sincronizador, ao receber essa recusa, interrompe o ciclo SEM marcar o `SRC_LOG` (os registros ficam pendentes, nada se perde),
  grava o estado "sincronia inativa" localmente (persiste entre aberturas) e o timer não dispara mais; (3) o botão de ativar consulta a chave
  no setes-sync: ativa → limpa o estado e retoma; inativa → nada acontece; (4) os 5 min de cache da chave válida no setes-sync ficam como
  limite conhecido. Assunção a confirmar: a chave INEXISTENTE (401) tem o mesmo efeito.

### 9.5 Resposta do Valdo à Q-SY12 na frente de produtos + conferência do `terminal` dos pedidos (2026-10-18)

- **Palavras do Valdo** (na sessão de produtos, "Rodada 6" do `prompts/prompt_modulo_products.md`): a regra da mercadoria vale para o
  serviço, que divide a mesma base; não há colisão quando a web bloqueia o INSERT de produto, serviço e tabela de preço em
  estabelecimento com chave de sincronia ATIVA. Um MÉTODO de guarda vale para os outros cadastros que aparecerem. "Sobre pedidos temos um
  campo terminal para determinar se o pedido veio do sincronizador ou da internet"; o PDV terá um terminal por PDV. Quanto ao resto, vale
  a recomendação (Q-SY13 = (a), coberta pela D-SY13 em execução). A frente de produtos executa a guarda `syncWriteGuard` do setes-api
  (/merchandise, /services, /price-lists, /categories). Risco residual que ela levou ao Valdo: na Setes os ids 16–79 de `tb_product`
  já nasceram na web e seguem no espaço do legado.
- ⚠️ **Conferência do `terminal` (só leitura, dev)**: HOJE o terminal NÃO separa pedido da web de pedido do sincronizador.
  - Os 7.949 pedidos do `setes_setes` estão TODOS no terminal 0. A PK de `tb_order` é `(id, tb_institution_id, terminal)`.
  - O setes-api grava e lê pedido com `terminal = 0` fixo (`setes-api/src/shared/order/order.ts:48,57,91`). O 0 é também o terminal do
    "Servidor Local" do sincronizador (`Sincronizador/prompt_indexador_terminal_pdv.md`, decisão 1: 0 = servidor local, 1..N = PDVs).
  - O id da web segue o máximo + 1 da institution: os pedidos do legado (NFL_CODIGO) vão até ~6.531 (carga de 10–14/08); da web nasceram
    6.532–8.013 (22/08 a 15/10), no MESMO terminal 0.
  - Consequência, igual à do produto (§9.1): quando o legado gerar o próximo NFL_CODIGO, ele cai em cima de um pedido da web. O `/order-*`
    faz upsert pela PK e regrava o pedido, a nota (`tb_invoice`, mesmo id) e os itens (snapshot: os itens da web viram `deleted='S'`).
  - Só não acontece se o legado da Setes não gerar mais nota (não li o Firebird) — a premissa vale para qualquer cliente que use os dois.

**Q-SY14 — pedido da web × pedido do sincronizador no mesmo terminal.** **(a)** o pedido nascido na web ganha um TERMINAL próprio que o
sincronizador nunca usa (ex.: um número reservado "internet"), e o setes-api passa a gravar e ler com ele — a PK passa a separar as
origens, como o Valdo descreveu **(Recomendado)** · (b) a mesma guarda dos cadastros: a web não cria pedido em estabelecimento com chave de
sincronia ativa · (c) aceitar o risco enquanto o legado da Setes não gerar mais nota. Em qualquer opção, os pedidos 6.532–8.013 do dev
ficam onde estão (ambiente de ensaio).

### 9.6 Resposta do Valdo à Q-SY14 (2026-10-18) — `tb_terminal`

- **D-SY14**: criar a peça `tb_terminal` (`tb_institution_id`, `id`, `description`) — o REGISTRO dos terminais de cada estabelecimento.
  Ela identifica o que vem do desktop legado (seja 0 ou 1, isso deixa de importar) e de cada PDV. Caso da Pipoteca: 1 servidor + 7 PDVs —
  cada um precisa estar REGISTRADO para poder mandar pedido, e cada terminal tem o seu próprio pedido nº 1 (a PK
  `(id, tb_institution_id, terminal)` já separa os espaços). Leitura: terminal não registrado não recebe pedido.
- **Fatos para o desenho** (dev, só leitura): `terminal` já está na PK de **55 tabelas** do schema do cliente (pedido e ramos, itens e
  tributos do item, nota e ramos, voz/transmissão da NFS-e, financeiro/títulos/baixas/extrato, caixa, comissão, OS, séries e sequências de
  NF-e). Todo dado de hoje está no terminal 0. O setes-api grava e lê pedido com `terminal = 0` fixo (`setes-api/src/shared/order/order.ts`).
  O sincronizador manda o terminal do registro do Windows (`SISWEB\TERMINAL`, `DM.GbTerminal`; 0 = servidor local, 1..N = PDVs —
  `Sincronizador/prompt_indexador_terminal_pdv.md`), com a MESMA chave para todos os terminais do estabelecimento.
- **Em aberto** (para a Rodada 0 da frente, com o guardião — é objeto de domínio novo, CLAUDE.md item 2):
  - qual terminal a WEB usa (um registro próprio, ex. "Internet" — é o que resolve a Q-SY14);
  - quem registra o terminal (tela do admin? só o Super?) e se o `id` é o número configurado no `SISWEB\TERMINAL`;
  - o que o setes-sync responde para terminal não registrado (código próprio, e o efeito no sincronizador — compare com a D-SY13);
  - a migração dos dados no terminal 0 (de quem é a linha 0 hoje: servidor local × web);
  - FK das 55 tabelas para a `tb_terminal` ou validação na porta;
  - a regra do grupo de estabelecimentos (`PADROES_BANCO.md` §12: a tabela é do grupo OU do estabelecimento — terminal é do estabelecimento);
  - a direção inversa do PDV (D-SY12).
- Frente TRANSVERSAL (setes-api + app + setes-sync + sincronizador) — não cabe só no grupo do sync.

**Respostas do Valdo aos pontos em aberto (2026-10-18)** — entram como decisões de partida da frente `tb_terminal`:
- **Terminal da web = 0, sempre** (cenário 3, o recomendado por ele). Todo o resto vem depois: o servidor local do sincronizador e os PDVs
  recebem terminais ≥ 1 (cenários 1 e 2 descartados). Muda a convenção de hoje (`SISWEB\TERMINAL` 0 = servidor local).
- **Quem registra**: o terminal é registrado NA WEB e DISTRIBUÍDO ao sincronizador/PDV (o número sai da web, não do registro do Windows).
- **Terminal não registrado**: o setes-sync recusa com a mensagem "Terminal não registrado, verifique".
- **Migração do terminal 0**: nenhuma — tudo está em teste; quando subir em produção, a sincronia de cada cliente é refeita do zero. A base
  central segue o padrão.
- **Sem chave estrangeira** para a `tb_terminal` nas 55 tabelas: o terminal é só identificação para a organização.
- **Matriz × filiais e PDV recebendo o cadastro da web**: frente PRÓPRIA, em sessão própria, para debater.
- ➡️ **Frente aberta (2026-10-18)**: `Infra-IA/prompts/prompt_frente_terminal.md` — Rodada 0 ORGANIZADA (D-TM1…D-TM7 = as respostas acima; parecer do guardião: `tb_terminal` + vínculo `tb_terminal_holder` + `kind` W/L/P; ondas 0–4; Q-TM1…Q-TM7 aguardam o Valdo).

## 10. Execução — D-SY10, D-SY11 e D-SY13 (2026-10-18)

Sessão própria do grupo do sync (pedida pela sessão de produtos). Regra dos dois grupos respeitada: setes-api/setes-app só LIDOS
(a peça `@shared/central-catalog` da worktree `merchandise` como referência). NADA commitado. Patch do sincronizador:
`sincronizador/patches-revisao-2026-07/11_medida_categoria_chave_inativa.md`.

### 10.1 D-SY10 — medida pela ABREVIAÇÃO, mesma sistemática do setes-api

- **`setes-sync/src/modules/sync/sync.catalog.ts`** (reescrito): `CATALOG_DEDUPE_KEY` = a `dedupeBy` do setes-api (medida =
  `abbreviation`; marca, embalagem e forma = `description`); `resolveCatalogKey` (medida sem abreviação cai na descrição, com aviso no
  log — um por descrição por processo); comparação `UPPER(TRIM(x)) COLLATE utf8mb4_bin`; o que não é chave é atributo da CRIAÇÃO; revive
  de linha soft-deletada só quando não há VIVA com a mesma chave (`ORDER BY (deleted = 'S'), id` — o setes-api só enxerga vivas).
- **`ensureAndLinkCatalogItem`** (marca, embalagem e medida — o TIPO impede criá-las dentro de transação aberta; `ensureCatalogItem` com
  `FOR UPDATE` ficou só para a forma de pagamento): (1) leitura SEM trava da linha VIVA — decide só no positivo; o caso comum (o item já
  existe) não toma a trava global; (2) criação/revive sob a trava IGUAL à do setes-api — `GET_LOCK('setes_central.<tabela>', 10)` ANTES
  da transação, transação própria SÓ com tabela central, `RELEASE_LOCK` no `finally`, sem a trava em 10 s = **409 `RESOURCE_BUSY`**,
  espera curta da sessão devolvida no fim, conexão que falha ao soltar a trava é DESCARTADA; (3) vínculo no schema do cliente FORA da
  seção global (diferença consciente da peça do setes-api: o INSERT do vínculo pede S na linha da institution e pode esperar o
  `lockInstitutionCounters` do faturamento — esperar o lock de UM cliente segurando a trava de TODOS pararia a frota; achado do gate
  socrático). Cada passo usa e devolve a sua conexão: a requisição nunca segura duas (pool de 20).
- `/measure` (`endpoints/measure.ts`): `abbreviation` obrigatória no payload (sem o campo → 400); vazia/`null` resolve pela descrição.
  `max(5)` mantido (cabe na coluna de 6 da D-PR35).
- `/merchandise` (`endpoints/merchandise.ts`): `stock.measureAbbreviation` (novo); `nameMeasure` segue aceito (executável antigo →
  descrição); fallback `'UND'` = ABREVIAÇÃO (criada, se faltar, como "UNIDADE"); `merchandiseCatalogInputs`; `assertCategorySynced`
  ANTES do catálogo (o 409 `CATEGORY_NOT_SYNCED` não cria item central) e de novo dentro da transação; os 3 catálogos resolvidos ANTES de
  pegar a conexão da transação do produto.
- `/brand` e `/package` pelo mesmo caminho (os dois também têm o setes-api como 2º escritor). As 6 chamadas de forma de pagamento
  ajustadas à assinatura nova (sem mudança de comportamento).
- `scripts/smoke-onda3.ts`: abreviação ÚNICA do smoke (com `'MT'` a dedupe reusaria uma medida real e a limpeza do smoke a apagaria) +
  checagem do dedupe pela abreviação. Smoke NÃO rodado (grava no `setes_setes`).
- **Delphi** `classes/merchandise_send_web.pas`: `GetMeasure` manda `measureAbbreviation` (`Registro.Abreviatura`) e `nameMeasure`
  (`Registro.Descricao`); medida inexistente = abreviação `'UND'`.
- `database/PADROES_BANCO.md` §9 regra 11 (v2.2): o "limite: o setes-sync cria itens centrais pelo protocolo dele" ficou SUPERADO para
  marca/embalagem/medida; segue valendo para a forma de pagamento (Q-SY17). ⚠️ O comentário equivalente na peça
  `setes-api/src/shared/central-catalog/index.ts` ("Limite conhecido: o setes-sync cria itens centrais pelo protocolo dele") é do OUTRO
  grupo — atualizar na frente de produtos.

### 10.2 D-SY11 — categoria por natureza, recategorização só na origem

- **Delphi** `un_dm.pas` `MigraGruposParaCategoria` (só no "Preparar o banco"): natureza de cada subgrupo e de cada grupo (produtos
  diretos) por 2 consultas agregadas (`SUM(CASE WHEN PRO_TIPO = 'S' …)`); subgrupo `'S'` se tem serviço, `'P'` se tem mercadoria OU não
  tem produto; grupo = a natureza dos diretos + a de cada filha; grupo sem produto = `'P'`. Raiz e filha reencontradas por DESCRIÇÃO +
  KIND (`AchaOuCriaCategoria`); `PRO_CODCAT` reapontado por natureza (`PRO_TIPO = 'S'` → `'S'`; qualquer outro — P/M, `'A'` aposentado,
  vazio — → `'P'`, como hoje). Passo 0: KIND fora de P/S, natureza que o grupo/subgrupo não tem, filha de natureza diferente da do pai e
  duplicata da mesma descrição E natureza = sujeira. Corrigido junto: a checagem da filha olhava só o 1º grupo com a descrição do pai (dois
  grupos com o mesmo nome — a conversão junta os dois na mesma raiz — davam sujeira a cada execução). PDV continua sem converter.
- ⚠️ No 1º "Preparar o banco" depois do patch a Setes cai no Passo 0 (as 2 "GERAL" `'P'` do dev só têm serviço): reset com o generator a
  0 — os ids RECOMEÇAM do 1 e podem cair em cima de ids vivos na web com outro significado; o reset volta sempre que a natureza de um
  grupo mudar no legado → **Q-SY16**.
- O `category_send_web` já mandava o KIND e o `/category` já exigia pai do mesmo kind — sem mudança no setes-sync. Recusar serviço em
  categoria `'P'` = **Q-SY15** (não executado).

### 10.3 D-SY13 — chave inativa deixa o sincronizador INATIVO

- **setes-sync** `sync.auth.middleware.ts`: 401 `SYNC_KEY_MISSING` (sem header), 401 `SYNC_KEY_INVALID` (inexistente ou `deleted='S'`),
  **403 `SYNC_KEY_INACTIVE`** (existente e `active='N'`); `lookupApiKey`/`refreshApiKey` (cache de 5 min só da válida — limite
  conhecido). `endpoints/synckey.ts` (**novo**): `GET /sync-key/status`, registrado ANTES do guard em `sync.specific.routes.ts` (o guard
  faz `next('router')` em caminho sem "sincronize"), lê o banco SEM cache e acerta o cache; não expõe institution/schema. Swagger do
  esquema `ApiKeyAuth` com as recusas.
- **Delphi**: `function/un_sync_key_state.pas` (**nova**; estado no `CONFIG.INI` `SISWEB\SincroniaInativa` + desde + motivo numa linha só;
  `IsRecusaDaChave` = 401 qualquer — A-SY1 — ou 403 `SYNC_KEY_INACTIVE`; `MarcarSincroniaInativa` nunca levanta — falha vai para o
  `log_api_data.txt`; `ConsultarChaveSincronia`); `classes/general_web.pas` (`ErrorCode`, `AuthRefused`);
  `function/un_send_to_web_server.pas` e `un_receive_from_web_server.pas` (recusa → sem `SRC_LOG`, sem checkpoint, marca inativa, para
  registro e tabelas; o recebimento passa a mandar a chave — sem ela qualquer linha `WAY='R'` derrubaria a sincronia inteira);
  `function/un_sincroniza.pas` (ciclo não começa inativo); `uMain.pas`/`uMain.dfm` (Tarefas → **Ativar sincronia**; timers parados;
  Iniciar/F5 e timers inertes, sem reposicionar checkpoint).
- Fato do código: o "registro do Windows, seção SISWEB" dos documentos é o `CONFIG.INI` ao lado do executável (`Fc_Aq_Geral`,
  `function/un_sistema.pas`).
- ⚠️ "Nada se perde" vale até o "Preparar o banco": ele zera a fila, inclusive o pendente acumulado com a sincronia inativa (registrado no
  patch 11 e no roteiro — rodar com a sincronia ativa e a fila vazia).
- Interação com a D-SY14 (`tb_terminal`, §9.6): "terminal não registrado" é outra recusa que não é erro do registro — o mesmo mecanismo
  (não marcar o `SRC_LOG`, parar) serve; desenho na frente do terminal.

### 10.4 Prova e gates

- setes-sync: `tsc --noEmit` limpo; **jest 76/76** (37 + 39 novos: `sync.catalog.test.ts` 16 — protocolo com conexão e pool falsos
  que registram a ordem; `sync.auth.test.ts` 9 — recusas, `/sync-key/status`, cache; `measure.contract.test.ts` 9 — contrato da
  medida; `merchandise.flow.test.ts` 5 — ordem categoria → catálogos → transação do produto, nunca duas conexões). Nada grava no banco.
- Prova SÓ LEITURA no MariaDB 10.4.20 do dev: dedupe por abreviação (`'und'`, `'UND '` → id 1), `ORDER BY (deleted = 'S')`,
  `GET_LOCK`/`RELEASE_LOCK`, espera curta da sessão e devolução (50/86400), leitura da chave. Dev: 3 medidas, nenhuma abreviação viva
  repetida; `tb_package.abbreviation` é VARCHAR(3); `api_key` UNIQUE; 2 categorias `'P'` no `setes_setes`.
- Sincronizador: `msbuild` Debug/Win32 com saída em pasta TEMPORÁRIA — 0 erro, nenhum aviso/dica nas units alteradas,
  `Sincronizador.res` com os mesmos bytes; nenhum caractere fora do ASCII nos trechos novos dos `.pas`/`.dfm`. Revisão estática do SQL
  Firebird (2.5/5.0).
- **Gate socrático: 0,72 ✅** (sem HIGH). Retrabalho feito na sessão: trava só para criar + leitura sem trava + vínculo fora da seção
  global; comentário falso "forma de pagamento = um escritor" corrigido (vira Q-SY17); `MarcarSincroniaInativa` que levantasse dentro da
  recusa marcaria o `SRC_LOG` do registro anterior; "ids novos" corrigido nos docs (o generator volta a 0). Pontos abertos → Q-SY16…Q-SY21.
- **Gate adversarial: 0,76 ✅, sem HIGH/CRITICAL** (30 testes temporários contra banco falso em memória com trava nomeada + retrato
  REPEATABLE-READ + pool de N conexões: 4 `/merchandise` concorrentes com a mesma medida nova = 1 linha; pool de 1 conexão termina).
  MEDIUM que exige decisão → **Q-SY22** (semântica fixada em teste). LOW corrigidos: motivo do INI sem CR/LF; falha silenciosa ao gravar
  o INI agora vai para o log; `ApiKey` do recebimento; comentário do `GetMeasure`; dica de proxy/URL na mensagem do "Ativar"; aviso do
  "Preparar o banco". LOW que ficam: 1205 → 500 cru (Q-SY18), executável antigo com abreviação NULL (Q-SY20), 401 de intermediário
  (Q-SY19), cache × guarda da web (Q-SY23), "Ativar sincronia" com HTTP síncrono na UI (até 15 s).
- Não testado (fica para a prova com o Valdo): 401/403 no executável real (o `TRESTRequest` do 10.2 não deve levantar exceção num 401 —
  se levantar, o registro ganha `SRC_LOG`); a trava contra o MariaDB real com o setes-api criando em paralelo; `MigraGruposParaCategoria`
  num Firebird real já convertido.

### 10.5 O que falta do Valdo

1. setes-sync novo no ar ANTES (ou junto) do setes-api com a medida por abreviação, e o executável novo no MESMO dia (Q-SY20).
2. Build oficial do sincronizador (patch 11) → com a sincronia ativa e a fila vazia: **Tarefas → Prepara Local** → **Primeira carga:
   Categorias + Medidas/Unidades + Produtos, sem período** (rebobinar `LAST_UPDATE` não reenvia). Roteiro:
   `Sincronizador/roteiro-implantacao-cliente.md`.
3. Prova da D-SY13 com a chave do estabelecimento de ensaio (passo a passo no patch 11).
4. Ratificar **A-SY1** e decidir as questões abaixo.

### 10.6 Assunção e questões para o Valdo (grupo do sync)

**A-SY1 (a ratificar)** — a chave INEXISTENTE (401) tem o mesmo efeito da inativa (403): sincronia inativa até "Ativar sincronia".
Implementado como "qualquer 401" (inclusive sem corpo do setes-sync) — ver Q-SY19.

**Q-SY15 — serviço em categoria `'P'` (e mercadoria em `'S'`) no setes-sync, depois do reenvio.** **(a)** depois do reenvio de todos os
clientes sincronizados, `/service` e `/merchandise` recusam com 409 `CATEGORY_KIND_MISMATCH` (a natureza só se acerta na origem; hoje a
recusa estaciona o registro — ver Q-SY18) **(Recomendado)** · (b) só aviso no log · (c) não conferir.

**Q-SY16 — reset da conversão (Passo 0) em cliente já sincronizado.** O generator volta a 0: ids recomeçam do 1 e caem em ids vivos na web
com outro significado (o `/category` faz upsert pelo id e move a subárvore); as categorias que a reconversão não reproduz ficam VIVAS na
web; o reset volta sempre que a natureza de um grupo muda no legado; o `DELETE FROM TB_CATEGORY` não está entre as exceções do
`PADROES_BANCO.md` §3.1. **(a)** com `TB_CATEGORY` já existente, a conversão fica INCREMENTAL: cria a árvore que falta e reaponta, a
linha que deixou de ser produzida vira `DELETED='S'` (viaja como soft delete) e o generator segue do MAX (nenhum id reusado)
**(Recomendado)** · (b) manter o reset da D7 + Primeira carga obrigatória, registrando o DELETE como exceção do §3.1 e aceitando as
órfãs vivas na web.

**Q-SY17 — forma de pagamento tem dois escritores.** O setes-api (`@shared/payment-types`) cria a mesma linha central comparando
`description = ?` na colação `_ci` (funde acentos: 'CARTÃO' = 'CARTAO') e sem trava nomeada; o setes-sync compara binário e cria dentro da
transação do pedido com `FOR UPDATE` (dois pedidos com a mesma forma NOVA ao mesmo tempo = 1213 → 500 → pedido estacionado). **(a)** a
MESMA trava `setes_central.tb_payment_types` e a MESMA comparação nos dois, com a resolução antes da transação do pedido no sync (como a
D-SY10) **(Recomendado)** · (b) limite conhecido.

**Q-SY18 — erro transitório estaciona o registro para sempre.** O sincronizador grava `SRC_LOG` em todo não-200 (só a recusa da chave
escapa) e a fila só pega `SRC_LOG` vazio: 409 `RESOURCE_BUSY`, `CATEGORY_NOT_SYNCED`/`PARENT_NOT_SYNCED` fora de ordem, 1205/1213 (hoje
500 cru no sync) e o 500 do middleware com o banco fora param o registro até o UPDATE manual do roteiro. **(a)** o setes-sync mapeia
1205/1213 para 409 `RESOURCE_BUSY` e o sincronizador trata uma lista FECHADA de códigos transitórios como "não marca o `SRC_LOG`, para a
tabela neste ciclo, tenta no próximo" — o mesmo mecanismo da D-SY13 (cuidado: dependência que nunca chega viraria nova tentativa a cada
ciclo) **(Recomendado)** · (b) manter o estacionamento + UPDATE manual.

**Q-SY19 — qualquer 401 desliga a sincronia (A-SY1).** Um proxy/basic auth do Plesk ou uma URL errada respondendo 401 deixa TODOS os
sincronizadores e PDVs inativos; a volta é um clique em cada máquina (a mensagem do "Ativar" já manda conferir chave e URL). **(a)** manter
qualquer 401 enquanto a Q-SY18 não existir — a alternativa hoje estaciona TODO registro do ciclo, o que é pior **(Recomendado)** · (b) só
401 com o corpo do setes-sync (`{ok:false}` com `SYNC_KEY_*`); 401 de terceiro = transitório (depende da Q-SY18).

**Q-SY20 — janela de transição da medida.** O executável antigo resolve a medida pela DESCRIÇÃO: quando ela não casa com a central, nasce
uma linha com abreviação NULL (inclusive a "UND" do fallback antigo), invisível à dedupe por abreviação do setes-api e do executável novo
— o vínculo velho fica no lookup do cliente. **(a)** servidor e executável novos no MESMO dia + conferência, depois do reenvio, das linhas
`abbreviation IS NULL` criadas no intervalo (`setes_central.tb_measure`) **(Recomendado)** · (b) o servidor trata o `nameMeasure` 'UND' do
executável antigo como abreviação.

**Q-SY21 (sem urgência) — revive de linha central soft-deletada (D17).** Quando o Super corrigir um dado central (ex.: "KILOGRAA") pelo
soft delete sem criar a substituta, o próximo envio do legado o revive. **(a)** soft delete central = correção/fusão: o sync não revive —
usa a viva da mesma chave ou cria **(Recomendado)** · (b) manter o revive.

**Q-SY22 — duas medidas do MESMO Firebird com a mesma abreviação** (achado MEDIUM do gate adversarial — consequência da D-SY10; com a
chave por descrição só acontecia com descrição idêntica). Ex.: UNIDADE/UND viva e UNIDADE VELHA/und com `DELETED='S'`: dividem a linha
central e o vínculo, e o ÚLTIMO `/measure` decide o `active` — se o excluído vier depois, a medida viva some das listas de apoio do cliente
(`assertCatalogItemLinked` do setes-api dá 422) e o `/merchandise` não religa. Semântica fixada em teste até a decisão. **(a)** o Delphi não
manda o `deleted='S'` de medida cuja abreviação também pertence a uma medida VIVA do mesmo Firebird (quem aposenta se adapta)
**(Recomendado)** · (b) o `/measure` com `deleted='S'` nunca desativa o vínculo da medida (a central é compartilhada) · (c) aceitar.
A consulta das medidas de mesma abreviação entrou no roteiro (Fase 1).

**Q-SY23 — cache de 5 min da chave × guarda da web (D-PR41 revista).** Desligada a chave, a web libera na hora a criação de produto
(lê o banco) enquanto o setes-sync ainda aceita o legado por até 5 min no MESMO espaço de id: a colisão do §9.1 reabre nessa janela.
**(a)** tirar o cache da chave válida (é uma leitura pela UNIQUE `api_key` por requisição) **(Recomendado)** · (b) a guarda da web espera
5 min depois de desligar · (c) aceitar (limite conhecido de hoje).

### 10.7 ⏯ Ponto de retomada (salvo 2026-10-18, a pedido do Valdo: "salve tudo para recomeçarmos depois")

> **2026-10-18 (noite) — Fase 1 do plano de retomada (`prompts/plano_retomada_2026-10-18.md`, Valdo: "Commita")**: o passo (1) abaixo foi
> CUMPRIDO — commit só dos caminhos desta seção, no `main` LOCAL de cada repositório, **sem push**: setes-sync **edbaad4** (20 arquivos) ·
> sincronizador **b6c6ebe** (11 arquivos). Ficaram de fora, como listado: `scripts/reset-institution-sync-data.ts` e `Sincronizador.dproj`.
> O "NADA commitado" está SUPERADO; "nem publicado" segue valendo (push = implantação, passo (3)).

**Estado**: tudo salvo em disco e NADA commitado nem publicado. Conferido no momento do salvamento: setes-sync `tsc` limpo e jest
76/76; sincronizador compila (msbuild Debug/Win32 em pasta temporária, EXIT=0). setes-sync NÃO está no ar (porta 3001 livre).

**Arquivos desta execução, por repositório** (para um commit só por estes caminhos — os repositórios têm mudanças de OUTRAS sessões):
- `setes-sync`: `src/modules/sync/sync.catalog.ts`, `sync.auth.middleware.ts`, `sync.specific.routes.ts`,
  `endpoints/{synckey (novo),measure,merchandise,brand,package,paymenttype,customer,financial,financialstatement,ordersale,orderservice}.ts`,
  `src/shared/swagger/swagger-config.ts`, `scripts/smoke-onda3.ts`,
  `src/__tests__/{sync.catalog,sync.auth,measure.contract,merchandise.flow}.test.ts` (novos). ⚠️ NÃO é desta execução:
  `scripts/reset-institution-sync-data.ts` (outra sessão).
- `sincronizador`: `un_dm.pas`, `uMain.pas`, `uMain.dfm`, `classes/{general_web,merchandise_send_web}.pas`,
  `function/{un_send_to_web_server,un_receive_from_web_server,un_sincroniza}.pas`, `function/un_sync_key_state.pas` (novo),
  `patches-revisao-2026-07/{README.md,11_medida_categoria_chave_inativa.md (novo)}`. ⚠️ NÃO é desta execução: `Sincronizador.dproj`
  (já estava alterado antes).
- `Infra-IA`: `setes-sync/{verificacao-comissao-margem-mercadoria,CONTRATOS_SYNC,MAPA_INDEXACAO}.md`,
  `Sincronizador/roteiro-implantacao-cliente.md`; trechos em `INDICE_CENTRAL.md` (v10.29) e `database/PADROES_BANCO.md` (v2.2, §9
  regra 11) — estes dois têm alterações de outras sessões juntas. Raiz: `D:\Gestao2027\CLAUDE.md` (não é repositório git).

**Para recomeçar** (prompt curto): "Retomar o grupo do sync pelo §10.7 do `setes-sync/verificacao-comissao-margem-mercadoria.md`:
(1) se eu disser 'commita', commitar só os caminhos do §10.7 em cada repositório, sem push; (2) decidir A-SY1 e Q-SY15…Q-SY23 (§10.6) —
as que eu decidir viram rodada executável; (3) implantação com o Valdo: setes-sync no ar → build oficial do patch 11 → Preparar o banco
com a sincronia ativa e a fila vazia → Primeira carga (Categorias, Medidas, Produtos) → prova da D-SY13 (passo a passo no patch 11)."

**Dependências com outras frentes**: a frente `tb_terminal` (D-SY14, `prompts/prompt_frente_terminal.md`) espera o patch 11 commitado para
as ondas 2/3; a frente de produtos tem o cartão "Alinhar central-catalog do setes-api ao sync" (comentário desatualizado + vínculo dentro
da trava global no setes-api).
