# 📚 Histórico — Gestão 2027

**Propósito**: Arquivos históricos e documentação anterior (referência)
**Escopo**: setes

---

## 📋 Arquivos Históricos

### 1. **01_RELATORIO_CODIGO_INICIAL.md**
**Data**: 2026-07-01  
**Conteúdo**: Levantamento inicial do código existente

Relatório que documenta:
- Estado de setes-api (70 arquivos TS)
- Estado de Sincronizador (481 arquivos Delphi)
- Estado de setes-sync (não existia na época)
- Completude geral do projeto

**Quando usar**: Referência histórica, comparação "antes/depois"

---

### 2. **02_PLANO_DESACOPLAMENTO.md**
**Data**: 2026-07-01  
**Conteúdo**: Plano de separação setes-api vs setes-sync

Documento que descrevia:
- Estratégia de desacoplamento
- 8 etapas de implementação
- Migração de endpoints
- Testes e validação

**Status**: ✅ Implementado (plano completado)

**Quando usar**: Entender decisões de arquitetura tomadas

---

### 3. **03_ARQUITETURA_ANTERIOR.md**
**Data**: 2026-07-01  
**Conteúdo**: Versão anterior da arquitetura (antes do desacoplamento completo)

Diagrama da arquitetura no meio do processo.

**Status**: ❌ Obsoleto (usar ARQUITETURA.md na raiz)

**Quando usar**: Entender evolução arquitetural

---

### 4. **04_RASCUNHO_GERENCIAMENTO_CENTRAL.txt**
**Data**: 2026-07-04
**Conteúdo**: Rascunho original da Fase 2 (Gerenciamento Central)

**Status**: ❌ Superado — refinado em 5 rodadas de decisão até virar `../setes-api/prompt_fase2_gerenciamento_central.md` (21 decisões)

**Quando usar**: Exemplo de "antes" do método `../skills-genericas/refinar-prompt-arquitetura.md`

---

### 5. **rascunho_setes_app_fase1_2026-07-05.txt**
**Data**: 2026-07-05
**Conteúdo**: Rascunho original do setes-app (Prompt - Aplicativo Flutter.txt)

**Status**: ❌ Superado — refinado em 3 rodadas de decisão até virar `../setes-app/prompt_fase1_fundacao.md` (23 decisões)

**Quando usar**: Exemplo de "antes" do método `../skills-genericas/refinar-prompt-arquitetura.md`

---

## 🔄 Evolução do Projeto

```
2026-07-01: Planejamento
  ├── Levantamento de código (RELATORIO_CODIGO_INICIAL.md)
  ├── Plano de desacoplamento (PLANO_DESACOPLAMENTO.md)
  └── Arquitetura intermediária (ARQUITETURA_ANTERIOR.md)
      
2026-07-04: Execução Completa
  ├── Desacoplamento implementado ✅
  ├── setes-api finalizada ✅
  ├── setes-sync finalizada ✅
  ├── Database setup ✅
  ├── Integration tests ✅
  └── Arquitetura final (ARQUITETURA.md - na raiz)
```

---

## 📌 Por Que Mantemos Histórico

- ✅ **Referência**: Entender decisões passadas
- ✅ **Auditoria**: Rastrear evolução do projeto
- ✅ **Aprendizado**: Ver o que funcionou/não funcionou
- ✅ **Documentação**: Completude do conhecimento

---

## 🔗 Links para Documentação Atual

**Use estes ao invés dos históricos:**
- Arquitetura atual: `../ARQUITETURA.md`
- Índice geral: `../INDICE_CENTRAL.md`
- Mapa de skills: `../MAPA_SKILLS.md`
- Comece aqui: `../COMECE_AQUI.md`

---

**Nota**: Esta pasta é para referência. Trabalhe com documentos na raiz e em subpastas de projetos.
