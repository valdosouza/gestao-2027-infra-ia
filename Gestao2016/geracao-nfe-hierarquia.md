# Geração/Autorização de NF-e — análise da hierarquia (frente irmã da tributação)

**Escopo**: setes
**Fonte**: instrução do autor (árvore de heranças) + verificação no código, 2026-08-16
**Objetivo**: entender a interconectividade para desenhar um modelo melhor na web.

## 1. A árvore verificada (com tamanhos)

```
TForm
└── TFr_GeraNfe3x                     Ajuda/un_geranfe3X.pas          3.772 linhas  ← A BASE
    ├── TTasGeraNfeSchemas            view/.../tas_gera_nfe_schemas     173  — baixar schemas XSD
    ├── TTasGeraNfeInutiliza          view/.../tas_gera_nfe_inutiliza   281  — inutilizar numeração
    ├── TTasGeraNfeConfig             view/.../tas_gera_nfe_config      725  — config (paths, SSL, certificado)
    ├── TTasGeraNfeAutorizacao        view/.../tas_gera_nfe_autorizacao 1.552 — AUTORIZAÇÃO NF-e (55)
    │   ├── TTasGeraNfeOperacao       view/.../tas_gera_nfe_operacao    164  — consulta de lote
    │   ├── TFr_GeraNfe_Vda           Ajuda/un_geranfe_vda              337  — venda (boleto/duplicata/email/whats)
    │   ├── TFr_GeraNfe_Cpa           Ajuda/un_geranfe_cpa              169  — compra (cancelamento próprio)
    │   └── TFr_GeraNfe_Ajt           Ajuda/un_geranfe_ajt              190  — ajuste (cancelamento próprio)
    └── TTasGeraNfceAutorizacao       view/.../tas_gera_nfce_autorizacao 1.860 — AUTORIZAÇÃO NFC-e (65)
        ├── TTasGeraNfceAutorizacaoLote view/.../..._autorizacao_lote    227  — lote offline
        └── TTasGeraNfceOperacao      view/.../tas_gera_nfce_operacao   497  — operações/cancelamento em massa
```

Total: ~9.950 linhas. NFS-e fica FORA desta árvore (`un_geranfe_Srv = class(TForm)`
— origem diferente, decisão registrada no processo-pedido-nota D3).

## 2. O que cada nível carrega

### A base `TFr_GeraNfe3x` (3.772 linhas) — três personalidades numa classe

1. **Montadora do XML/DANFE**: família `PreencheDanfe*` — Ide, Emitente,
   Destinatário (com a heurística de IE inválida — Q34), casas decimais, itens,
   TODOS os impostos (ICMS/IPI/II/PIS/COFINS/ISSQN + IBS/CBS/Seletivo da reforma),
   totalizador, transportadora, pagamento, cobrança, InfAdic, comércio exterior,
   veículos novos, combustível, responsável técnico, CNPJs autorizados.
2. **Validadora de cancelamento**: `validaCancela{CarregarNota,Inventario,
   Financeiro,NotaServico,Lote}`, `cancelaNotaComplementar`, `CancelaCtrlIcmsST`
   (desfaz o rastreio de ST — elo com tributação §P2.8).
3. **Comunicadora/persistidora**: email, WhatsApp, impressão, `TrataRetorno`
   (virtual), `Fc_AtivaRetornoNFe`, `SaveNfeEletronica`.

**Hooks virtuais** (o contrato real da hierarquia): `FormataTela`, `CriarVariaveis`,
`IniciaVariaveis`, `FinalizarVariaveis`, `ImagemBotao`, `TrataRetorno`,
`ValidaCancelamentoNotas`, `ImprimeDuplicata`, `ConfirmaEnviaNFe/Boleto`,
`ConfirmaImprimeBoleto`, `PreencheDanfeIde`, `PreencheDanfeInfAdic`,
`CarregaComponenteNFE`.

### ⚠️ O barramento global

O componente ACBr **NÃO pertence à hierarquia**: vive em **`Fr_Principal.Nfe`**
(form principal). TODAS as telas manipulam esse único componente global — e a
própria `ttributacao` preenche o MESMO objeto (`It_Nfe`). A hierarquia inteira é
acoplada por estado global, não por parâmetros.

### Os cinco filhos diretos — três papéis DIFERENTES de herança

| Papel da herança | Classes | Avaliação |
|---|---|---|
| Reuso de "shell" de tela | Schemas, Inutiliza, Config | Herdam 3.772 linhas de montadora de XML para usar meia dúzia de hooks visuais — "é um gerador de NF-e?" NÃO. Herança por conveniência |
| Especialização de MODELO | Autorizacao (55) × NfceAutorizacao (65) | São IRMÃS, não mãe/filha — o fluxo de autorização foi DUPLICADO (1.552 × 1.860 linhas; botões `Sb_NF_*` × `Sb_NFC_*` espelhados) |
| Especialização de PROCESSO | Vda, Cpa, Ajt (sob Autorizacao) | A parte SAUDÁVEL: folhas pequenas (169–337) que só sobrescrevem `ValidaCancelamentoNotas`/`Pc_CancelaNFe_Pendente` e pós-autorização (boleto/duplicata/envio na venda) |

### O que `TTasGeraNfeAutorizacao` adiciona (o pipeline de verdade)

`AutorizaNFe`, `Fc_DefineNumeroNotaNFe` (numeração), `Fc_ValidaAutorizacaoNFe`,
`Pc_ConsultaNFe`, `Pc_CancelaNFe`/`Pc_CancelamentoNotasNFe`, `Fc_UpdateRetornoNFe`
(grava TB_RETORNO_NFE), `TrataRetorno` override, `ImprimeNFe`,
`Pc_DocFiscalReferenciada`.

## 3. Leitura da interconectividade (o diagnóstico)

1. **UI e processo fundidos**: a máquina fiscal vive em handlers de botão de TForm.
2. **Acoplamento por estado global** (`Fr_Principal.Nfe`) — a ordem de quem mexeu
   por último no componente define o resultado.
3. **A variação por PROCESSO é pequena e bem isolada** (169–337 linhas: cancelamento
   + pós-autorização) — o legado ACERTOU essa fronteira; é peça de lego que a web
   preserva como interface.
4. **A variação por MODELO é grande e duplicada** (55 × 65 gêmeos de ~1.700 linhas)
   — o legado ERROU essa fronteira; é a maior fonte de retrabalho.
5. **Operações do ciclo de vida** (inutilizar, consultar, lote, config) não são
   "geradores de NF-e" — são comandos independentes que herdaram a base por
   conveniência de tela.

## 4. Modelo proposto para a web (sugestões — regra 5; decisões do Valdo)

### 4.1 Trocar a herança de telas por um PIPELINE de serviços

```
montar (dados+impostos, já calculados pela tributação)
  → validar (mínimo local — princípio Q17)
  → assinar
  → transmitir
  → tratar retorno (assíncrono: segundos a minutos)
  → persistir retorno (TB_RETORNO_* por modelo; ciclo 0-3)
  → pós-autorização (hooks por processo)
```

Na web não existe a tela: autorização é JOB assíncrono com estados — o ciclo
0=Pendente/1=Enviada/2=Autorizada/3=Cancelada JÁ está modelado nas tabelas de
retorno por modelo (Q13).

### 4.2 As três dimensões viram três mecanismos DIFERENTES (não três heranças)

| Dimensão | Hoje | Na web |
|---|---|---|
| MODELO (55/65/NFS-e) | classes gêmeas duplicadas | **Strategy** de layout/transmissão/retorno — UM pipeline, N estratégias (mata a duplicação NF-e×NFC-e; NFS-e entra como estratégia RPS→número, Q4) |
| PROCESSO (venda/compra/ajuste) | folhas com overrides | **Hooks** de pós-autorização e validação de cancelamento — interface pequena, como as folhas já provam (169–337 linhas) |
| OPERAÇÃO (inutilizar/consultar/cancelar/lote) | subclasses da base | **Comandos** independentes sobre o mesmo core |
| CONFIG (paths/SSL/certificado) | tela-classe de 725 linhas | **Dados** (tabela por estabelecimento) — no app, tela comum de cadastro |

### 4.3 Regras herdadas do diagnóstico

- **Sem estado global**: contexto de emissão POR REQUISIÇÃO (a web já força isso;
  não recriar o barramento em singleton/service global).
- A montadora de XML consome o RESULTADO da tributação (peças calculadas) — as duas
  frentes se encontram na fronteira `itens tributados → documento`, e nada mais.
- Validações de cancelamento por processo = a MESMA peça que hoje vive nas folhas
  (inventário, financeiro, lote, complementar) — catalogar como regras nomeadas.
- Elo com o sincronizador: os retornos por modelo já têm classes de envio no patch
  04 (`TInvoiceReturn*SendWeb`) — o desenho web do retorno deve casar com esses
  contratos.

## 5. Pendências desta frente

- Mapear o MIOLO de `AutorizaNFe`/`TrataRetorno` (o fluxo de transmissão e a máquina
  de estados real) — próximo passo natural
- Contingência (série 900, `tpEmis`, dhCont — visto na tributação `:2067`)
- Eventos: CC-e (rectification — gap da Rodada 4 do sync), cancelamento como evento
- NFC-e offline/lote (o que `AutorizacaoLote` faz de especial)
- Confrontar com `Infra-IA/setes-sync/CONTRATOS_SYNC.md` (invoice-return-55/65/service)
