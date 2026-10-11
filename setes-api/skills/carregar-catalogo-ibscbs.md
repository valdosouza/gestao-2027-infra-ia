# Skill: Carregar o catálogo IBS/CBS (rotina do Super)

**Status**: Vigente (2026-10-10 — D-IB32 da fase IBS/CBS)
**Objetivo**: Carregar/recarregar em `setes_central` o catálogo oficial do IBS/CBS (CST, cClassTrib com vigência e aplicabilidade
por documento, cIndOp, NBS) — em dev ou em produção — sem nunca gravar o que não foi conferido
**Referências**: `Infra-IA/prompts/prompt_fase_ibs_cbs.md` §10.5 (D-IB22…D-IB27), §11 (IB-1, A-IB1/A-IB2), §11.7 (D-IB28…D-IB33);
`Infra-IA/database/PADROES_BANCO.md` §5 ("carga de catálogo externo = ato com plano"); código: `setes-api/scripts/load-ibscbs-catalog.ts`
+ peça `setes-api/src/shared/ibscbs-catalog/`
**Tempo**: ~10 min (o ensaio leva ~1–2 min: a conferência consulta a Calculadora por par NFS-e × cClassTrib)
**Escopo**: misto (o ato com plano é método; as fontes e a Calculadora são do caso Setes/Brasil)

---

## 1. Quando rodar

- **1ª carga** de um ambiente (antes do deploy da migration 066 — o boot do setes-api exige o script `sql/61` aplicado).
- **Recarga** quando sair versão nova do IT 2025.002 (tabela cClassTrib), do Anexo VII (cIndOp) ou da NBS.
- **Lembrete mensal** (D-IB32) até os 9 cClassTrib da A-IB1 (000006, 200055, 200056, 400003, 400004, 550026…550029) aparecerem na
  Calculadora — enquanto não aparecem, ficam SEM aplicabilidade (não são oferecidos nem aceitos). O ensaio mostra quantos faltam
  (`conferencia.unconfirmed`).

## 2. Quem, de onde, com que credencial (D-IB32)

- **Quem**: o Valdo (ato do Super — decisão de negócio de quando trocar o catálogo de TODOS os clientes).
- **De onde**: a máquina dele, com o repositório `setes-api` (o build de produção NÃO leva `scripts/` nem `tsx`) e a Infra-IA (os `.xlsx`
  oficiais arquivados em `Infra-IA/setes-api/integracoes/nfse-adn/{classificacao-ibs-cbs,rtc-2026-10}/`).
- **Credencial**: `.env` apontando para o banco do ambiente com um usuário que só ESCREVE em `setes_central` e só LÊ `tb_service`,
  `tb_service_ibscbs` e `tb_product` dos schemas dos clientes (para o relatório de impacto — D-IB28 (b)); sem a leitura, o relatório lista
  o schema em `impactProblems` (nunca falha em silêncio).
- **Quando**: ENSAIO e ato fora do horário comercial — a carga segura FOR UPDATE na aplicabilidade SE e grava linhas de `tb_nbs` e
  de cIndOp; as LEITURAS do cadastro não esperam, mas o salvar de um serviço cuja FK aponta para uma linha que a carga alterou espera o
  fim da carga (checagem de FK). O relatório de impacto lê os clientes DEPOIS do rollback do ensaio (nenhuma trava central segura os N
  schemas) e não roda no ato.

## 3. Passo a passo

1. Baixar/conferir as fontes oficiais (README de cada pasta: URL, bytes, SHA-256). Versão nova = arquivar ao lado, com README.
2. **Ensaio** (padrão — transação desfeita), na pasta `setes-api`:
   ```
   npx tsx --require tsconfig-paths/register scripts/load-ibscbs-catalog.ts \
     --it "<…>/classificacao-ibs-cbs/it-2025-002-v1-70-cclasstrib.xlsx" --it-version "IT 2025.002 v1.70" \
     --indop "<…>/rtc-2026-10/anexovii-indop_ibscbs_v1-03-00-nt009.xlsx" --indop-version "Anexo VII v1.03.00"
   ```
3. **Conferir o relatório** (JSON):
   - `conferencia.unconfirmed` — linhas que a Calculadora ainda não tem (A-IB1/A-IB2) — sem aplicabilidade;
   - `conferencia.blocked` — linhas cujo ATRIBUTO diverge na Calculadora (aceitação na NFS-e, tributação regular) — perdem a
     aplicabilidade na NFS-e (D-IB28 (a));
   - `conferencia.divergences` — só informativo (o IT não aceita e a Calculadora aceita — vale o IT);
   - `relatorio.validity.deactivated` + chaves — linhas de vigência que SUMIRAM da fonte e ganham o fato "ausente desde a versão"
     (D-IB36; nunca são apagadas; a peça passa a ignorá-las) — ex.: o IT corrigiu a dIniVig de um código;
   - `relatorio.*.deactivatedKeys` — o que PERDE a presença nesta carga; `relatorio.impact` — serviços de cada cliente que usam
     cClassTrib/cIndOp que ficam SEM nenhuma aplicabilidade na NFS-e ou NBS que perde a presença (só no ensaio); `relatorio.shrink` + `AVISO_ENCOLHIMENTO` — perda > 10 % de alguma lista (D-IB28 (c)),
     em BRUTO (D-IB38). As listas que contam: presença do cClassTrib por modelo, presença do cIndOp, NBS e — desde a D-IB39 — a
     **história do cClassTrib** (linhas marcadas "ausente da fonte"; base = linhas presentes na fonte antes da carga — linha já marcada
     numa carga anterior não entra na base nem conta de novo). Na história, o relatório separa `codeInSource` (o código SEGUE na fonte
     com outra linha — ex.: o IT corrigiu a dIniVig) de `codeVanished` (o código sumiu da fonte — suspeita de IT antigo/errado).
     ⚠️ Limite conhecido (Q-IB44): ENCERRAR vigência em massa (dFimVig no passado) não marca linha ausente — não conta no limite nem
     aparece no impacto; conferir `relatorio.validity.updated` alto no ensaio.
4. **Ato**: o ensaio imprime `--vai --plano <hash>`. Rodar o MESMO comando com esse sufixo. Se a fonte, a leitura ou a data mudaram
   entre o ensaio e o ato, o plano não bate e NADA é gravado — rodar o ensaio de novo.
5. **Encolhimento intencional**: ensaio E ato com `--aceita-encolher` (o argumento entra no plano). Casos legítimos: a Receita extinguiu
   NBS em massa; o IT corrigiu a dIniVig de muitos códigos de uma vez (a história mostra `codeInSource` alto e `codeVanished` ≈ 0 — as linhas
   antigas ganham o fato "ausente desde a versão" e as novas entram). `codeVanished` alto sem nota da Receita = parar e conferir a versão do
   IT antes de aceitar.
6. Conferir depois: 2ª passada do ensaio = 100 % `unchanged`.

## 4. Pré-condições de deploy da fase (D-IB33)

- A migration **066** só vai a produção depois de o grupo do sync confirmar que o `/service/sincronize` NÃO faz REPLACE nem DELETE físico
  em `tb_service` (a FK `tb_service_ibscbs → tb_service` faria a sincronia desses serviços falhar com 1451).
- Ordem: `sql/61` e `sql/63` (fato "ausente da fonte" — D-IB36) em `setes_central` → carga do catálogo (este procedimento) →
  deploy do setes-api com a 066 (a peça de classificação LÊ a coluna do script 63: sem ela o cadastro de serviços dá 500).

## 5. Casos reais

- **2026-10-10 (gates da IB-1)**: a Calculadora é API "beta" — lista vazia, campo renomeado e servidor que TRAVA a 2ª requisição numa
  conexão keep-alive foram vistos/provados; por isso: lista vazia = recusa, estrutura mudada = erro alto, `Connection: close` + novas
  tentativas, e o ato só grava o plano do ensaio.
- **2026-10-10 (passeio logado)**: o Anexo VII tem 7 pares de cIndOp que só diferem no "Local do fornecimento" — a descrição carregada
  inclui essa coluna (sem ela 100301 e 100302 eram indistinguíveis na tela).
- **2026-10-10 (Rodada 3)**: 1ª conferência de atributos — 70 pares, 0 bloqueados, 1 divergência informativa (410028: o IT não aceita
  na NFS-e e a Calculadora aceita).
