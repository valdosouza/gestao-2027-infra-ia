# Agente Especializado Delphi → TypeScript

**Status**: ✅ Ativo e Pronto  
**ID**: `a81b1668737619946`  
**Criado**: 2026-07-04  
**Para**: Valdo (valdo@setes.com.br)

---

## 🎯 O que é

Um agente Claude especializado em:
- ✅ Converter código Delphi → TypeScript
- ✅ Reescrever Models e Data Objects
- ✅ Gerar Repository, Service, Routes
- ✅ Validação com Zod
- ✅ Documentação Swagger
- ✅ Respeitar padrões setes-api

---

## 📍 Onde está

**Armazenamento**: Sistema interno do Cowork (Claude Desktop)  
**Arquivo Local**: D:\Gestao2027\Infra-IA\setes-api\skills\delphi-to-typescript.md  
**ID Agente**: a81b1668737619946

---

## 🚀 Como Usar

### Opção 1: Via Skill (Recomendado)

```bash
# 1. Leia a skill
D:\Gestao2027\Infra-IA\setes-api\skills\delphi-to-typescript.md

# 2. Siga o workflow
# 3. Use SendMessage para continuar com o agente
```

### Opção 2: Continuação Direta

Se você está em uma conversa anterior com o agente:

```
/SendMessage to: 'a81b1668737619946'

[Sua solicitação de conversão Delphi]
```

---

## 📚 Conhecimento do Agente

O agente foi treinado com:

### Arquitetura Setes-API
- Stack: Node.js, Express, TypeScript, MySQL
- Padrão: Routes → Service → Repository
- Multi-tenancy por schema
- Feature flags por módulo
- Autenticação JWT
- Validação com Zod
- Documentação Swagger JSDoc

### Padrões de Conversão Delphi → TypeScript
- Mapeamento completo de tipos
- Models → Interfaces
- Data Objects → Interfaces compostas
- Relacionamentos (FK, arrays)
- Enums e tipos
- Nomenclatura (camelCase)
- Nullable (T | null)

### Exemplo de Conversão

**Delphi:**
```delphi
TEntity = class
  FId: Integer;
  FName: string;
  property Id: Integer read FId write FId;
  property Name: string read FName write FName;
end;
```

**TypeScript Gerado:**
```typescript
export interface Entity {
  id: number
  name: string
}

export async function getEntity(id: number, schemaName: string): Promise<Entity> {
  const conn = await getConnection(schemaName)
  const [rows] = await conn.query<Entity[]>(
    'SELECT id, name FROM entity WHERE id = ?',
    [id]
  )
  return rows[0]
}
```

---

## 🔄 Fluxo de Trabalho Típico

```
1. Você: "Converter essas classes Delphi"
   ↓
2. Agente: Lê e mapeia os tipos
   ↓
3. Agente: Gera Repository, Service, Routes
   ↓
4. Você: Integra no projeto (copiar arquivos)
   ↓
5. Você: Registra rota em gateway/router.ts
   ↓
6. Você: Testa com npm run dev
```

---

## 🎓 Documentação de Referência

**Em memória (auto-atualizada):**
- `[[setes-api-architecture]]` — Padrões gerais
- `[[delphi-to-typescript-patterns]]` — Padrões de conversão

**Em Infra-IA:**
- `setes-api/skills/delphi-to-typescript.md` — Skill (este arquivo)
- `MAPA_SKILLS.md` — Índice de todas as skills
- `INDEX.md` — Documentação setes-api

**Em setes-api:**
- `CLAUDE.md` — Guia técnico (git do projeto)
- `src/modules/_template/` — Template padrão

---

## 💡 Exemplos de Uso

### Exemplo 1: Converter um Model simples

```
Agente, converter esta classe Delphi:

[Cole arquivo: TEntity.pas]

Preciso:
1. Interface TypeScript
2. Repository com CRUD
3. Service com validações
4. Routes com 3 endpoints GET/POST/DELETE
5. Swagger docs
```

### Exemplo 2: Converter Data Object complexo

```
Agente, converter este Data Object:

[Cole arquivo: TObjFiscal.pas]

Observações:
- TObjFiscal agrupa TEntity + TCompany + TAddress
- Preciso de um endpoint que retorne tudo junto
- Validação: name obrigatório, address opcional
```

### Exemplo 3: Adicionar ao módulo existente

```
Agente, adicionar novo endpoint ao módulo "customer":

[Cole arquivo: TCustomerExtra.pas]

Contexto:
- Módulo "customer" já existe
- Adicione no final de customer.repository.ts
- Crie novo service para este extra
- Agregue tudo em uma nova rota
```

---

## ✅ Checklist Pós-Geração

Depois que o agente gera os arquivos:

- [ ] Copiar arquivos para `src/modules/<nome>/`
- [ ] Adicionar rota em `gateway/router.ts`
- [ ] Feature flag adicionada ao banco
- [ ] `npm run dev` sem erros
- [ ] Testar `/health` (deve retornar 200)
- [ ] Testar novo endpoint com JWT
- [ ] Validação Zod funcionando
- [ ] Swagger docs acessível

---

## 🐛 Se algo der errado

| Problema | Solução |
|----------|---------|
| "Agente não lê arquivo" | Copie/cole o conteúdo do `.pas` direto |
| "TypeScript não compila" | Compartilhe erro com agente (`npm run build`) |
| "Query SQL falha" | Verifique nome tabela/colunas no schema |
| "Feature flag bloqueando" | Insira flag no banco: `INSERT INTO feature_flags ...` |
| "Endpoint 404" | Verifique se registrou rota em `router.ts` |

---

## 🔗 Links Úteis

**Skill correspondente:**
- [delphi-to-typescript.md](./delphi-to-typescript.md)

**Documentação setes-api:**
- [INDEX.md](./INDEX.md) — Start here
- [DOCUMENTACAO.md](./DOCUMENTACAO.md) — Docs completas
- [01-DESACOPLAMENTO.md](./01-DESACOPLAMENTO.md) — Arquitetura

**Projeto setes-api:**
- GitHub: D:\Gestao2027\setes-api
- Porta: 3000
- Swagger: http://localhost:3000/docs (quando rodando)

---

## 📞 Contato

**Seu agente:**
- ID: `a81b1668737619946`
- Comando: `/SendMessage to: 'a81b1668737619946'`

**Suporte técnico:**
- Email: valdo@setes.com.br
- Projeto: Gestão 2027
- Time: Infra-IA

---

## 📝 Histórico

| Data | O quê | Status |
|------|-------|--------|
| 2026-07-04 | Criado agente especializado | ✅ |
| 2026-07-04 | Documentação de padrões | ✅ |
| 2026-07-04 | Skill delphi-to-typescript | ✅ |
| 2026-07-04 | Integração ao MAPA_SKILLS | ✅ |

---

*Documento criado para Valdo — Gestão 2027 Infra-IA*  
*Última atualização: 2026-07-04*
