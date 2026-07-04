# Organização de Pastas — Gestão 2027

**Versão**: 1.0 (2026-07-04)
**Propósito**: Definir onde CADA arquivo novo entra. Nenhum arquivo fica solto na raiz.
**Princípio**: simetria — para cada projeto de software em `D:\Gestao2027\<projeto>` existe um espelho `Infra-IA\<projeto>` com sua documentação. O código fica no projeto; o conhecimento fica no espelho.

---

## 1. A raiz D:\Gestao2027 (fixa — não criar nada novo aqui)

| Pasta/Arquivo | O quê | Quem atende |
|---|---|---|
| `CLAUDE.md` | Porta de entrada dos agentes de IA (Claude Code lê automaticamente). ÚNICO arquivo solto permitido na raiz | todos |
| `Infra-IA/` | Documentação, agentes, skills, prompts (repo git próprio) | todos |
| `setes-api/` | API principal ERP (repo git próprio) | setes-app |
| `setes-app/` | Aplicativo Flutter Web e Android (repo git próprio) | usuário final |
| `setes-sync/` | API de sincronização (repo git próprio) | sincronizador |
| `sincronizador/` | Cliente Delphi legado — lê gestão desktop e envia ao setes-sync (repo git próprio) | setes-sync |
| `sql/` | Scripts canônicos do banco (repo git próprio) — conhecidos por TODOS os projetos | todos |

**Regra**: arquivo novo na raiz = arquivo no lugar errado. A única exceção é o `CLAUDE.md` (função técnica: é onde o Claude Code procura).

## 2. Dentro de Infra-IA (espelho do conhecimento)

```
Infra-IA/
├── INDICE_CENTRAL.md        ← mapa de tudo (SEMPRE atualizar junto)
├── ORGANIZACAO_PASTAS.md    ← este arquivo
├── ARQUITETURA.md           ← visão geral (absorveu o antigo README da raiz)
├── COMECE_AQUI.md / MAPA_SKILLS.md / guias
├── prompts/                 ← prompts EM OTIMIZAÇÃO (rascunhos e versões de trabalho)
├── skills-genericas/        ← skills que valem para qualquer projeto
├── git-github/              ← guias e scripts de versionamento (ex.: publicar-fase2.ps1)
├── database/                ← PADROES_BANCO.md + skills de banco (espelho da pasta sql/)
├── codigo-aprendizado/      ← códigos de estudo/POCs (incorporado ao repo Infra-IA)
├── HISTORICO/               ← tudo que foi superado (nunca apagar, mover para cá)
├── setes-api/               ← espelho: INDEX, docs NN-*, prompts de fase fechados, skills/
├── setes-app/               ← espelho (em construção)
├── setes-sync/              ← espelho
├── Sincronizador/           ← espelho
└── integration/             ← testes E2E entre projetos
```

## 3. Tabela de decisão — "onde salvo este arquivo novo?"

| Tipo de arquivo | Destino |
|---|---|
| Código-fonte de um projeto | `D:\Gestao2027\<projeto>\` (nunca no Infra-IA) |
| Script SQL executável | `D:\Gestao2027\sql\` |
| Prompt que estou começando/otimizando | `Infra-IA\prompts\` |
| Prompt de fase FECHADO (decisões registradas) | `Infra-IA\<projeto>\prompt_faseN_<nome>.md` |
| Rascunho superado | `Infra-IA\HISTORICO\NN_*.md` (+ linha no INDEX.md de lá) |
| Documentação de módulo/feature | `Infra-IA\<projeto>\NN-NOME.md` |
| Padrão permanente de um domínio | `Infra-IA\<domínio>\PADROES_*.md` (ex.: database/PADROES_BANCO.md) |
| Skill de um projeto | `Infra-IA\<projeto>\skills\<verbo-objeto>.md` |
| Skill que vale para todos | `Infra-IA\skills-genericas\` |
| Script/guia de git e GitHub | `Infra-IA\git-github\` |
| Código de estudo/POC | `Infra-IA\codigo-aprendizado\` |
| Doc que ficou obsoleto | mover para `Infra-IA\HISTORICO\` com status SUPERADO |

## 4. Cadeia de atualização (nunca pular)

Criou/moveu arquivo → atualize `INDICE_CENTRAL.md` → se mudou estado de projeto, atualize `D:\Gestao2027\CLAUDE.md` → processo completo em `skills-genericas/atualizar-infra-ia.md`.

## 5. Versionamento

Cada pasta de primeiro nível (exceto `CLAUDE.md`) é um repositório git próprio com remoto no GitHub (`valdosouza/*`). Publicação por branch + PR: script `Infra-IA/git-github/publicar-fase2.ps1` (generalizar por fase). A raiz em si NÃO é repositório.
