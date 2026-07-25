# Tarefa: Verificar cobertura da setes-sync vs classes do Sincronizador Delphi

**Escopo**: setes

> Origem: handoff da sessão claude.ai (celular) de 2026-07-25 — conversa "Acesso aos trabalhos no Claude desktop".

## ✅ EXECUTADA em 2026-07-25 (Claude Code) — resultado

- **Veredito**: GitHub estava desatualizado, mas a causa real era outra — a revisão Ondas 1–6
  **nunca tinha sido commitada** (working tree inteiro pendente sobre o "Initial commit" de 04/07).
- 28 endpoints ativos: TODOS existem com paths corretos (hífen); `/invoice-return-service` já
  existe (SET_ON='N'); `/invoice-rectification` segue como gap da Rodada 4.
- Contrato D14, auth D12 (tb_sync_api_key → institution+schema) e remoção dos 7 rest* (D23): CONFORMES.
- **14/14 testes verdes** (com MySQL local no ar).
- **Publicado**: commit `583ab6d` em `origin/feature/fase2-gerenciamento-central`
  (`.dev-sync-key` adicionada ao .gitignore antes). Merge para `main` = decisão em aberto.
- **Sincronizador**: `.gitignore` Delphi criado; `config` (payload real de cliente), `__history/`,
  `*.identcache/*.stat/*.local` removidos do versionamento; código de ontem (Onda 0 + patches
  02/03) commitado — push `7943279` em `origin/main`.
- **Expurgo CONCLUÍDO (2026-07-25)**: Valdo autorizou o `git filter-repo` — `config`,
  `__history/`, `*.identcache/*.stat/*.dproj.local` removidos de TODO o histórico e force
  push aceito (HEAD novo `4a47628`; backup mirror pré-expurgo no scratchpad da sessão).
  O arquivo `config` local segue no disco (ignorado pelo .gitignore). Obs.: clones/forks
  antigos de terceiros ainda teriam o dado; caches do GitHub expiram com o tempo.

## Contexto (já verificado em 25/07 — não repetir)

Uma auditoria feita contra o GitHub `valdosouza/gestao-2027-setes-sync` (último commit 04/07, "Initial commit") mostrou que aquela versão é **anterior à revisão das Ondas 1–6**:

- Envelope antigo `{id: 200/500}` em `sync.response.ts` (esperado: `{ok, id, externalCode}`)
- 11 rotas sem hífen (`/bankaccount`, `/paymentType`, `/pricelist`, `/stocklist`, `/stockbalance`, `/stockstatement`, `/ordersale`, `/orderpurchase`, `/orderstockadjust`, `/financialplans`, `/financialStatement`)
- 5 endpoints ativos ausentes: `/measure`, `/invoice`, `/invoice-merchandise`, `/invoice-return-55`, `/invoice-return-65`
- 7 endpoints `rest*` do módulo restaurante aposentado (D23) ainda presentes

O README dos patches (`patches-revisao-2026-07/README.md` no repo do Sincronizador) afirma que a setes-sync local (`D:\Gestao2027\setes-sync`) já passou nos smokes das Ondas 1–6. **Hipótese a confirmar**: a local está correta e o GitHub está para trás.

## O que fazer

### 1. Confirmar se o GitHub está desatualizado

Em `D:\Gestao2027\setes-sync`:

```
git remote -v
git fetch origin
git status
git log --oneline -5
git log --oneline origin/main..HEAD   # commits locais não publicados
git diff --stat origin/main           # diferença real de conteúdo
```

Reportar: quantos commits a local está à frente e se há mudanças não commitadas.

### 2. Verificar cobertura dos 28 endpoints ativos

Buscar em `src/modules/sync/endpoints/` (e rotas registradas em `sync.specific.routes.ts`) se todos os paths abaixo existem como POST, exatamente com estes nomes (hífen incluído; case não importa):

```
/brand/sincronize              /category/sincronize
/measure/sincronize            /package/sincronize
/merchandise/sincronize        /price-list/sincronize
/price/sincronize              /stock-list/sincronize
/stock-balance/sincronize      /promotion/sincronize
/financial-plans/sincronize    /payment-type/sincronize
/customer/sincronize           /provider/sincronize
/salesman/sincronize           /bank-account/sincronize
/order-sale/sincronize         /order-purchase/sincronize
/order-stock-adjust/sincronize /invoice/sincronize
/invoice-merchandise/sincronize /stock-statement/sincronize
/financial/sincronize          /financial-statement/sincronize
/cashier/sincronize            /invoice-return-55/sincronize
/invoice-return-65/sincronize  /filexml/sincronize
```

Futuros (SET_ON='N' — anotar se existem, sem exigir): `/invoice-return-service/sincronize`, `/invoice-rectification/sincronize`.

### 3. Verificar contrato de resposta

Em `sync.response.ts` (ou equivalente):

- Sucesso: HTTP 200 com `{ok: true, id}` e `externalCode` quando aplicável
- Erro: HTTP ≠ 200 com `{ok: false, error}`
- Dependência ausente: HTTP 409 com code `*_NOT_SYNCED`

Conferir também se a auth por `X-Api-Key` resolve institution + schema via `setes_central.tb_sync_api_key` (o payload NÃO deve exigir `tb_institution_id`).

### 4. Verificar limpeza do módulo restaurante

Os 7 endpoints `rest*` (restgroup, restsubgroup, restmenu, restgrouphasattribute, restgrouphasmeasure, restgrouphasoptional, restmenuhasingrediente) devem ter sido removidos ou estar claramente desativados (D23).

### 5. Cruzar com CONTRATOS_SYNC.md

Se `Infra-IA/setes-sync/CONTRATOS_SYNC.md` estiver acessível, usar como fonte da verdade e apontar qualquer divergência entre contrato, código local e o seed do Delphi (`function/un_sincronia_seed.pas` no repo do Sincronizador — 37 entradas, 28 ativas).

## Saída esperada

- **Veredito**: GitHub desatualizado? SIM/NÃO (com base no passo 1)
- Tabela 28 endpoints ativos → EXISTE / FALTA / PATH DIVERGENTE na local
- Contrato de resposta: CONFORME / DIVERGENTE (detalhar)
- rest*: REMOVIDOS / PRESENTES
- **Ação recomendada**: se a local estiver correta e à frente → commit + push para `valdosouza/gestao-2027-setes-sync`; listar o que falta se houver gap real

## Status dos patches no Sincronizador Delphi (auditado em 25/07 — commit 1e3fef5)

**Já aplicados no código — não refazer:**

- Onda 0: `EnsureSincronia` no `un_dm.pas` (cria/semeia TB_LISTA_SINCRONIA)
- Patch 02: X-Api-Key como header + envelope `{ok,...}` parseado inline em `general_web.pas`; chave lida de `SISWEB\FApiKey` (`un_sincroniza.pas:73`)
- Patch 03: bank_account monta JSON direto de `FCtrl.Registro` (bug morto)

**Pendências reais — considerar no plano:**

- Patch 04 NÃO aplicado: `RegisterClass(TInvoiceReturnServiceSendWeb)` segue comentado (`uMain.pas:1004`); decisão do RunScript (C4) em aberto
- DDL Firebird (01) é manual por cliente: EXTERNALCODE + DELETED em 23 tabelas + UPDATE dos nulos — a Onda 0 NÃO cobre isso
- Patch 05: remodelagem dos data objects — validar classe a classe o que já foi feito
- **Segurança**: o arquivo `config` na raiz do repo público `gestao-2027-sincronizador` contém payload real de cliente (CNPJ, IE, endereço, telefones) — tornar o repo privado ou expurgar o arquivo/histórico

## Não fazer

- Não alterar código sem apresentar o diagnóstico antes
- Não rodar migrations ou tocar em banco de produção
- Não ativar endpoints com SET_ON='N' (NFS-e e Carta de Correção aguardam patch 04)
