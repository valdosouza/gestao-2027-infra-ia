# Skill genérica: Testar adversarial (QA que tenta quebrar a entrega)

**Quando usar**: como GATE junto com `revisar-riscos-sistemicos.md` — depois dos testes verdes, antes de dar a entrega por pronta. Enquanto a revisão socrática questiona a arquitetura, aqui o papel é ATACAR a implementação: casos de borda, contrato violado e vulnerabilidades que o caminho feliz não cobre.
**Tempo**: 15–30 min por entrega
**Escopo**: misto
**Origem**: adaptada da skill `adversarial-qa` do [harness-kit](https://github.com/romabeckman/harness-kit) (MIT) — análise 2026-08-03; princípio portável (QA adversarial com verdito e severidade), amarrado aqui aos contratos Setes.

---

## 1. Papel

Você é o **QA adversarial**: seu objetivo é quebrar a implementação. Sucesso = encontrar o caso que ninguém testou. A spec do projeto define a fronteira do comportamento correto — tudo que a spec promete e o código não cumpre é achado.

## 2. Spec de referência por projeto

| Projeto | Fronteira do comportamento correto |
|---|---|
| setes-api | Swagger do endpoint + `ARQUITETURA_MODULOS_API.md` + decisões do prompt de fase do módulo + envelope de erro `{error, code?, ref?, fields[]}` + envelope paginado `{ok, data, page, pageSize, total}` |
| setes-sync | `CONTRATOS_SYNC.md` (fonte da verdade do contrato) + `MAPA_INDEXACAO.md` (como cada entidade indexa) + códigos 409 documentados |
| setes-app | Validação shared (`setes_validators`), fluxo de mensagem única (`mensagem-e-validacao.md`), campos configuráveis (required/máscara por cliente) |

## 3. Vetores de ataque da casa

**Genéricos**
1. Borda de entrada: null, string vazia, zero, negativo, número gigante, unicode/acentos, payload sem campo obrigatório, campo com tipo errado.
2. Injeção: valor de campo com `'; DROP --`, `%`, `_` em filtros LIKE — os repositories usam placeholder SEMPRE?
3. Autorização: chamar o endpoint SEM token, com token de outro institution, com perfil regular sem privilégio — vaza existência (200/404 errado)?
4. Duplicidade/concorrência: mesmo POST duas vezes; dois clientes gravando o mesmo recurso.

**Específicos setes-api**
5. Paginação: `page=0`, `page=99999`, `pageSize=-1`, `pageSize=10000` — o COUNT usa a MESMA where da lista (carteira incluída)?
6. Multi-tenant: id de recurso de OUTRO institution na URL — 404 sem vazar?
7. Cadeia de entidade: mesmo CPF/CNPJ em papéis diferentes reusa a entity? 409 de papel duplicado devolve o id?
8. Soft delete / reuso: criar com código que já existiu excluído (regra 409 mesmo excluído nos códigos externos).

**Específicos setes-sync**
9. Idempotência: reenviar o MESMO envelope — duplica linha, quota, movimento?
10. Envelope parcial: bloco opcional ausente (`user`, `invoice`) — cai no fallback correto SEM sobrescrever dado real?
11. Conflito de documento: documento de uma entity enviado para outra — vai para `tb_sync_conflict` (nunca mescla)?
12. Códigos 409 do contrato (EXTERNAL_CODE_ORPHAN, USER_NOT_SYNCED, papel duplicado): cada um dispara no cenário certo e NÃO dispara fora dele?
13. Ordem de dependência: enviar movimento antes do cadastro que ele referencia — erro claro ou lixo gravado?

## 4. Workflow

1. Ler a spec (tabela §2) e listar as PROMESSAS do contrato (status codes, envelopes, invariantes).
2. Montar a matriz de ataque: vetores §3 aplicáveis × promessas da spec.
3. Executar de verdade o que for executável (curl/smoke contra dev; jest quando já há harness de teste). O que não der para executar, analisar no código e marcar como `analisado` (não `provado`).
4. Classificar cada achado por severidade: LOW / MEDIUM / HIGH / CRITICAL.
5. Emitir o verdito (§5). **Gate**: qualquer HIGH/CRITICAL reprova a entrega independente do score; score < 0.70 reprova.
6. **Achado confirmado vira teste permanente**: reproduziu um bug → escreva o teste jest que o fixa ANTES de corrigir (o relatório não substitui o teste).

## 5. Formato do verdito

```json
{
  "alvo": "modulo/endpoint atacado",
  "score": 0.00,
  "passou": false,
  "vulnerabilidades": [
    { "tipo": "SQL_INJECTION|AUTH_BYPASS|VAZAMENTO_TENANT|RACE_CONDITION|DATA_EXPOSURE|...", "severidade": "LOW|MEDIUM|HIGH|CRITICAL", "descricao": "onde, com qual input, qual efeito", "evidencia": "provado (comando/teste) | analisado (arquivo:linha)" }
  ],
  "casosNaoTestados": [
    "Cenário de borda que a suíte atual não cobre (candidato a teste novo)"
  ]
}
```

- `passou` = true SOMENTE se score ≥ 0.70 E sem vulnerabilidade HIGH/CRITICAL.
- Achado acionável: "injeção no parâmetro X do filtro da lista de clientes" — nunca "risco de injeção" genérico.

## 6. Casos reais (calibração)

- **Graduação do sem-doc (19/19 testes)**: os casos A/B/C/D1/D2 do motor de documento nasceram exatamente de enumerar bordas de contrato — este é o padrão a repetir.
- **Onda 3 do sync**: 3 agentes em paralelo acharam código antigo quebrado contra o DDL real — atacar contra o banco REAL (não contra o que a doc diz) encontra o que a leitura não vê.
- **Seed × banco já semeado**: mais de um patch precisou de UPDATE manual porque o bootstrap era idempotente demais — vetor permanente: "o que acontece num banco que JÁ passou pela versão anterior?".
- **Onda 1 tax-rules (2026-08-16)**: 212 testes verdes (todos mockados) e a entrega estava INUTILIZÁVEL no banco real — a lista dava 500 (coluna `st.description` inexistente) e os 8 catálogos CST existiam VAZIOS (nenhum seed; todo POST caía em 422). Dois HIGH que só o smoke contra o dev encontrou. Vetor permanente: um ciclo E2E real (POST→GET→PUT→DELETE) por módulo novo, sempre; e "tabela de catálogo nova: quem a povoa? o seed está no pacote?".
