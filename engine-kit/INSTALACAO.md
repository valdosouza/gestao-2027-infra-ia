# Instalação do Kit num Caso Novo — passo a passo executável

**Escopo**: metodo
**Cenário-exemplo usado abaixo**: instalar na `<empresa>` (ex.: Softworks), workspace
`C:\<empresa>\` com o repositório legado em `C:\<empresa>\<repo-legado>\`, já existindo
ferramentas de indexação de código, memória de IA e Obsidian. Adapte os caminhos.

---

## Antes de sair de casa (5 min)

1. Copie a pasta `engine-kit/` inteira para um meio SEU (repo pessoal privado ou
   pendrive) — o kit é o método, e o método é seu.
2. Confira que NADA além do kit vai junto: nenhum arquivo `setes`/de outro caso.
   Teste rápido: busque por nomes do caso anterior dentro da cópia — tem que dar zero.

## Dia 1 — montar o vaso (30–60 min, sem tocar em código ainda)

### Passo 1 — Criar a base de conhecimento

No workspace da empresa:

```powershell
# raiz do workspace (ajuste)
cd C:\<empresa>
New-Item -ItemType Directory -Force base-conhecimento
New-Item -ItemType Directory -Force base-conhecimento\skills-genericas
New-Item -ItemType Directory -Force base-conhecimento\<repo-legado>       # espelho do projeto
New-Item -ItemType Directory -Force base-conhecimento\prompts
New-Item -ItemType Directory -Force base-conhecimento\HISTORICO
New-Item -ItemType Directory -Force base-conhecimento\seguranca-git
```

O nome `base-conhecimento` é sugestão — use o que fizer sentido na empresa. O que NÃO
é negociável: uma pasta única, espelho por projeto, e as subpastas de processo
(`prompts/`, `HISTORICO/`).

### Passo 2 — Instalar o kit dentro dela

```powershell
Copy-Item <origem-do-kit>\skills\*            base-conhecimento\skills-genericas\
Copy-Item <origem-do-kit>\seguranca-git\*     base-conhecimento\seguranca-git\ -Recurse
Copy-Item <origem-do-kit>\ESTRUTURA_BASE_CONHECIMENTO.md  base-conhecimento\
Copy-Item <origem-do-kit>\README.md           base-conhecimento\LEIA-ME-ENGINE.md
```

### Passo 3 — Criar o arquivo de regras na raiz

Crie `C:\<empresa>\CLAUDE.md` (ou o arquivo de regras da ferramenta de IA usada lá)
a partir do template em `ESTRUTURA_BASE_CONHECIMENTO.md`, preenchendo:
- `<Caso>` → nome da empresa
- regra de escopo → `metodo | <empresa> | misto` (ex.: `metodo | softworks | misto`)
- seção "Estado atual" → uma linha por projeto, ainda que seja só "avaliação não iniciada"

### Passo 4 — Criar o índice central

Crie `base-conhecimento\INDICE_CENTRAL.md` a partir do template. Versão 1.0, primeira
linha do histórico: `<data> | Base de conhecimento criada + kit da engine instalado | 1.0`.
A partir daqui, TODA alteração na base passa pelo índice (skill `reter-conhecimento.md`).

### Passo 5 — Conectar as ferramentas que já existem

Ferramenta não se joga fora — se registra e se governa:

| Já existe | O que fazer |
|---|---|
| Obsidian | Abrir `base-conhecimento\` como vault (ou incluir a pasta no vault atual). Os links `[[assim]]` funcionam nativamente |
| Indexador de código (grafo/busca) | Registrar no índice central como recurso da Fase 1 (nome, onde roda, o que indexa). Ele é o motor da Fase 1.0 |
| Memória da ferramenta de IA | Registrar no índice. Regra: a FERRAMENTA guarda; a skill `reter-conhecimento.md` decide O QUE e ONDE — memória sem processo vira ruído |
| Documentação já gerada (pelo indexador ou à mão) | NÃO refazer: mover/linkar para o espelho do projeto na base e rodar o **censo** nela (passo 6) |

### Passo 6 — Censo do acervo existente

Rode `skills-genericas\censo-de-escopo.md` sobre todos os `.md` que a empresa já tem
na base: valores `metodo | <empresa> | misto`. Saída: tabela-resumo no índice central.
(Se o acervo for grande, use o fan-out paralelo descrito na skill.)

**Fim do Dia 1**: vaso montado, ferramentas conectadas, acervo classificado. Nenhuma
linha de código lida ainda — e é assim mesmo.

## Dia 2+ — ligar a engine no legado

### Passo 7 — Dimensionar o repositório (Fase 1.0)

```powershell
cd C:\<empresa>\<repo-legado>
# volumetria por extensão (ajuste as extensões à stack local)
Get-ChildItem -Recurse -Include *.pas,*.dfm,*.sql,*.cs,*.vb |
  Group-Object Extension |
  Select-Object Name, Count, @{n='Linhas';e={($_.Group | Get-Content | Measure-Object -Line).Lines}}
```

Registre no espelho do projeto: total de arquivos/linhas por linguagem, módulos
aparentes, idade. **Regra de decisão**: se não dá para ler em algumas sessões (milhões
de linhas), a Fase 1 SÓ roda em cima do índice do código — a leitura direta é
amostragem disfarçada.

### Passo 8 — Definir unidades de análise e escolher o piloto

Liste as unidades (módulo, tela, entidade, integração) numa tabela com status
`pendente | em análise | documentada` no espelho do projeto. Escolha **UMA** unidade
piloto — pequena, mas de ponta a ponta (ex.: uma entidade que nasce numa tela, grava
no banco e sai num relatório). Nada de big bang.

### Passo 9 — Rodar a Fase 1 no piloto

Use `skills-genericas\avaliar-repositorio-legado.md` como prompt do agente: preencha a
tabela de parametrização (stack origem/destino, ordem de leitura, avisos de descarte) e
mande analisar SÓ a unidade piloto. Saída: doc com as 7 seções no espelho do projeto,
`**Escopo**: <empresa>`.

### Passo 10 — Fechar o primeiro ciclo completo

1. As estruturas suspeitas de maquete do piloto → parecer via `guardiao-conceitual.md`
2. As escolhas de rota → primeira rodada via `rodadas-de-decisao.md`.
   **Defina explicitamente quem é o dono das decisões neste caso** (você? o gestor? o
   arquiteto da empresa?) — sem dono nomeado, o método não funciona.
3. Ao terminar: `reter-conhecimento.md` (índice + regras da raiz + memória)
4. O que você aprendeu sobre o MÉTODO (não sobre a empresa) → anotar para levar
   destilado de volta ao diário do produto e ao kit

**Critério de sucesso da instalação**: um ciclo completo (avaliar → conceituar →
decidir → reter) rodado numa unidade piloto, com tudo registrado na base. A partir
daí é repetição com escala.

## O que NUNCA fazer

- Levar qualquer conteúdo de outro caso (nem "só um exemplo") — o kit já tem os
  exemplos anonimizados de que o método precisa
- Colocar a base de conhecimento da empresa no SEU repo pessoal, ou o kit (seu método)
  misturado no repo da empresa sem clareza — conteúdo do caso é da empresa; método é
  seu; a fronteira fica limpa se cada um mora na sua casa
- Pular o censo "porque o acervo é pequeno" — é barato e é o que mantém a fronteira
  acima auditável
- Começar a reescrever código antes do primeiro ciclo completo do piloto
