# Skill: Converter Código Delphi para TypeScript

**Objetivo**: Ler código Delphi (Models, Data Objects) e reescrevê-lo como TypeScript/JavaScript para setes-api  
**Tempo**: ~30-45 minutos (depende da complexidade)  
**Pré-requisito**: Agente especializado "Delphi-to-TypeScript" ativo  

---

## 🎯 Quando usar

- ✅ Reescrever Models (TEntity → Entity interface)
- ✅ Reescrever Data Objects (TObjFiscal → EntityFiscal interface)
- ✅ Converter tipos Delphi → TypeScript
- ✅ Gerar Repository, Service, Routes
- ✅ Adicionar validação com Zod
- ✅ Documentar com Swagger

## ⚠️ Estrutura de saída (atualizado 2026-07-11)

Se o código Delphi convertido virar um **módulo de CADASTRO** (CRUD com tela no
setes-app), a saída DEVE seguir o padrão simétrico de 6 arquivos de
`Infra-IA/setes-api/ARQUITETURA_MODULOS_API.md`:
`<m>.interface.ts` + `<m>.dto.ts` (Zod) + `<m>.repository.ts` + `<m>.service.ts`
+ `<m>.controller.ts` + `<m>.routes.ts` (router fino) — inclua o doc no prompt do
agente. As seções abaixo com 3-4 arquivos valem só para endpoints avulsos em
módulos legados.

---

## 🔄 Fluxo de Trabalho

### Passo 1: Preparar código Delphi

**Origem dos arquivos:**
```
D:\gestaoweb\model\          → Models (tabelas)
D:\gestaoweb\DataObjects\    → Data Objects (agrupamentos)
```

**Se não tiver acesso direto:**
- Copiar arquivos `.pas` para D:\Gestao2027\Infra-IA\setes-api\delphi-source/
- Ou listar arquivos que quer converter

### Passo 2: Usar o Agente Especializado

**ID do Agente:** `a81b1668737619946`

**Comando para continuar:**
```
/SendMessage to: 'a81b1668737619946'

Você está na setes-api agora. Preciso converter código Delphi para TypeScript:

## Código Delphi a Converter

[Cole aqui os arquivos .pas]

## Estrutura esperada
- Models de tabelas de banco (TEntity, TCompany, etc.)
- Data Objects que agrupam modelos (TObjFiscal, TObjEntity, etc.)

## Resultado desejado
1. Interfaces/tipos TypeScript
2. Repository com queries MySQL
3. Service com lógica
4. Routes com endpoints
5. Validação com Zod
6. Documentação Swagger
```

### Passo 3: Revisar Geração

O agente vai:
1. ✅ Mapear tipos Delphi → TypeScript
2. ✅ Criar interfaces para cada Model/DataObject
3. ✅ Gerar repository com queries
4. ✅ Gerar service com validações
5. ✅ Gerar routes com endpoints
6. ✅ Adicionar Swagger JSDoc

**Checklist de validação:**
- [ ] Tipos mapeados corretamente
- [ ] Arrays/listas como `T[]`
- [ ] Nullable como `T | null`
- [ ] Foreign keys representadas
- [ ] Nomenclatura camelCase
- [ ] Multi-tenancy respeitado (`schemaName` em queries)

### Passo 4: Integrar no Projeto

**1. Criar pasta do módulo:**
```bash
mkdir -p src/modules/<nome>
```

**2. Copiar arquivos gerados:**
```
src/modules/<nome>/
├── <nome>.routes.ts       (do agente)
├── <nome>.service.ts      (do agente)
├── <nome>.repository.ts   (do agente)
└── types.ts               (tipos/interfaces)
```

**3. Registrar rota em `gateway/router.ts`:**
```typescript
import <nomeRoutes> from '@modules/<nome>/<nome>.routes'

router.use('/<nome>', <nomeRoutes>)
```

**4. Testar:**
```bash
npm run dev
curl http://localhost:3000/health
```

### Passo 5: Validar Feature Flag

**Adicionar flag no banco:**
```sql
INSERT INTO feature_flags (tenant_id, module_key, enabled)
VALUES ('tenant-001', '<nome>', true);
```

---

## 📋 Exemplo Completo

### Código Delphi Original

```delphi
TEntity = class
  FId: Integer;
  FName: string;
  FActive: Boolean;
  property Id: Integer read FId write FId;
  property Name: string read FName write FName;
  property Active: Boolean read FActive write FActive;
end;

TObjEntity = class
  FEntity: TEntity;
  FAddress: TAddress;
  property Entity: TEntity read FEntity write FEntity;
  property Address: TAddress read FAddress write FAddress;
end;
```

### TypeScript Gerado

**types.ts:**
```typescript
export interface Entity {
  id: number
  name: string
  active: boolean
}

export interface ObjEntity {
  entity: Entity
  address: Address
}
```

**entity.repository.ts:**
```typescript
import { getConnection } from '@shared/db/connection'

export async function getEntity(id: number, schemaName: string): Promise<Entity | null> {
  const conn = await getConnection(schemaName)
  try {
    const [rows] = await conn.query<Entity[]>(
      'SELECT id, name, active FROM entity WHERE id = ?',
      [id]
    )
    return rows[0] || null
  } finally {
    conn.release()
  }
}
```

**entity.service.ts:**
```typescript
import { getEntity } from './entity.repository'

export async function getEntityData(id: number, schemaName: string): Promise<Entity> {
  const entity = await getEntity(id, schemaName)
  if (!entity) throw new Error('Entity não encontrada')
  return entity
}
```

**entity.routes.ts:**
```typescript
import { Router, Request, Response } from 'express'
import { getEntityData } from './entity.service'
import logger from '@shared/logger/logger'

const router = Router()

/**
 * @swagger
 * /entity/{id}:
 *   get:
 *     summary: Get Entity by ID
 *     tags:
 *       - Entity
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *     responses:
 *       200:
 *         description: Entity found
 *       404:
 *         description: Entity not found
 */
router.get('/:id', async (req: Request, res: Response) => {
  try {
    const data = await getEntityData(Number(req.params.id), req.tenant!.schemaName)
    res.json({ ok: true, data })
  } catch (err) {
    logger.error('Erro em entity/get', { err })
    res.status(500).json({ error: 'Erro interno' })
  }
})

export default router
```

---

## 🔍 Mapeamento de Tipos Referência

| Delphi | TypeScript | Nota |
|--------|-----------|------|
| `string` | `string` | |
| `Integer` | `number` | |
| `Int64` | `number \| bigint` | Grande volume |
| `Boolean` | `boolean` | |
| `Double` | `number` | |
| `TDate` / `TDateTime` | `string` | ISO 8601: "2026-07-04T10:30:00Z" |
| `GUID` | `string` | UUID |
| Enum | `type Enum = 'a' \| 'b'` | String literal |
| Class | `interface` | Sem implementação |
| `TList<T>` | `T[]` | Array tipado |
| Nullable | `T \| null` | |

---

## ✅ Checklist de Qualidade

- [ ] Todos os tipos foram mapeados
- [ ] Nenhum `any` sem justificativa
- [ ] Nomenclatura em camelCase
- [ ] Multi-tenancy respeitada
- [ ] Validação com Zod adicionada
- [ ] Swagger docs completo
- [ ] Testes de exemplo criados
- [ ] Feature flag registrada
- [ ] Rota registrada em router.ts
- [ ] npm run dev sem erros

---

## 🐛 Troubleshooting

### "Erro ao mapear tipos Delphi"
→ Copiar arquivo `.pas` completo para o agente  
→ Incluir todas as dependências (classes que são usadas)

### "TypeScript não compila"
→ Rodar `npm run build` e compartilhar erros com agente  
→ Pode ser falta de tipos ou importações

### "Query SQL falha"
→ Verificar nome da tabela (deve existir no schema)  
→ Validar nomes de colunas

### "Feature flag bloqueando acesso"
→ Verificar se foi inserida corretamente  
→ Validar `tenant_id` e `module_key`

---

## 📚 Documentação Relacionada

- **[[setes-api-architecture]]** — Padrões gerais da API
- **[[delphi-to-typescript-patterns]]** — Padrões de conversão
- **CLAUDE.md** — Guia técnico completo

---

## 🎓 Material Referência

**Padrões setes-api:**
- Routes → Service → Repository (3 camadas)
- Multi-tenant com schemaName
- Validação com Zod
- Logger centralizado
- Swagger JSDoc

**Padrões TypeScript:**
- Strict mode ativado
- Path aliases (@shared, @modules, etc.)
- Async/await obrigatório
- Tipos explícitos (nada de any)

---

## 📞 Contato & Suporte

**Agente especializado:**
- ID: `a81b1668737619946`
- Use `/SendMessage to: 'a81b1668737619946'` para continuar

**Estrutura de código:**
- Veja `src/modules/_template/` para template
- Veja `src/modules/core/` para exemplo completo

---

*Última atualização: 2026-07-04*  
*Skill criada para Valdo (valdo@setes.com.br) — Gestão 2027*
