# Prompt de fase — Framework de campos configuráveis + validação de cadastros

**Status**: FECHADO (2026-07-12, 22 decisões em 4 rodadas) — **IMPLEMENTADO em 2026-07-12**
**Início/Fechamento**: 2026-07-12
**Método**: `skills-genericas/refinar-prompt-arquitetura.md` (rodadas de decisão numeradas)
**Projetos**: setes-api + setes-app + sql (central e schema do cliente)
**Escopo**: setes

> **Implementação (2026-07-12)**: DDL aplicado (sql/01, sql/03, migration 004,
> seed sql/07 — 5 telas-piloto + interface 7 do painel). API: `shared/validation`
> (dígito verificador CPF/CNPJ, máscara #/A), erro por campo via `parseBody`,
> `shared/field-config` (cache TTL + `assertClientRequired` nos 5 pilotos),
> módulo `interface-fields` (isento de feature flag, como o core) e
> GET /api/institutions/fiscal-exists; 54/54 testes. App: package
> `setes_validators` (14 testes), fábrica com merge custom→catálogo→código,
> máscara na digitação + unmask no save, `FieldConfigLoader` nos 5 pilotos e
> painel `interface_fields` (vitrine → campos → dialog); flutter analyze limpo.

---

## Contexto

Cadastros precisam de validação padronizada (obrigatório, CPF/CNPJ, formatos, duplicidade)
E o cliente precisa poder configurar, por interface, o comportamento dos campos
(obrigatoriedade, caption, máscara) via painel — partindo de um baseline técnico
imutável que garante a integridade do banco.

É a descida de um nível na hierarquia que já existe:
- Nível TELA (feito): `tb_interface` (catálogo central) × `tb_institution_has_interface` (contrato, schema do cliente)
- Nível CAMPO (este prompt): `tb_interface_has_field` (catálogo central) × `tb_institution_has_field` (especialização, schema do cliente)

## Decisões registradas (Valdo, 2026-07-12)

1. **Modelo em 3 camadas**: UI = feedback imediato (espelha a API); API = fonte da verdade
   (repete tudo da UI + o que exige banco, ex.: duplicidade 409); Banco = última defesa
   (NOT NULL/UNIQUE/FK apenas do baseline técnico).
2. **Invariante**: o cliente só APERTA (torna obrigatório o que era opcional) — nunca
   afrouxa o baseline técnico. Campo configurável é NULLABLE no banco; a obrigatoriedade
   comercial é garantida na API.
3. **Escopo v1 da configuração**: obrigatoriedade + caption + máscara. SEM ocultar
   campo (visibilidade fica para depois).
4. **Catálogo central `tb_interface_has_field`**: campos POR INTERFACE, sem vínculo/reuso
   entre interfaces (duplicação consciente — tradeoff aceito pela independência).
   Característica intrínseca do produto → vive em `setes_central`.
5. **Especialização `tb_institution_has_field`** no schema do cliente.
   `tb_institution_has_interface` permanece intacta (contrato comercial das telas).
6. **Workflow do painel** (módulo Sistema/Admin no app):
   - Lista TODAS as interfaces do produto (vitrine comercial — instigar compra),
     destacando as adquiridas; filtros por módulo e nome.
   - Interface adquirida → lista de TODOS os campos, inclusive os travados
     (o cliente precisa saber que existem e que são fixos).
   - Campo permitido → editar caption, required e mask.
7. **Montagem da UI (engine)**: ao montar a tela, verifica se há definição customizada
   (`tb_institution_has_field`); se não houver, usa o modo padrão (`tb_interface_has_field`).
   Caminho claro e único: ou padrão, ou custom.
8. **Piloto**: telas já criadas — countries, states, cities, privileges, interfaces
   (impacto assumido nas telas existentes).
9. **Operação do painel**: qualquer usuário do cliente com privilégio na tela
   (interface de cliente, distinta das interfaces do Super).
10. **Registros antigos**: comportamento natural — ao editar registro que não atende
    obrigatoriedade criada depois, precisa preencher para salvar.
11. **Tool de povoamento do catálogo**: informa interface + tabelas envolvidas
    (interface ≠ tabela; pode haver várias tabelas) e a tool popula
    `tb_interface_has_field`; o refino é manual.
    **IMPLEMENTADA**: `setes-api/scripts/gerar-interface-fields.ts`
    (`npm run fields:gen -- --interface <id> --tables <t1,t2> [--out x.sql] [--apply]`).
    Gera seed SQL revisável (INSERT IGNORE re-executável); exclui colunas de auditoria;
    kind mapeado do information_schema; required baseline = IS_NULLABLE='NO';
    nome repetido entre tabelas entra só na 1ª (PK composta).

## DDL proposto (refinado sobre o rascunho do Valdo — pendente Rodada 3)

Ajustes aplicados ao rascunho, todos por PADROES_BANCO.md:
(a) singular `tb_institution_has_field` (não "fields"); (b) flags `char(1)` 'S'/'N'
(não boolean); (c) PK composta no catálogo; (d) a tabela do cliente ganhou `field_name`
(o rascunho não tinha a chave do campo — sem ela não se sabe qual campo a config afeta);
(e) catálogo ganhou `required` = baseline técnico ('S' = travado no painel — necessário
para a decisão 6 "mostrar os que não pode alterar"); (f) `required` do cliente
DEFAULT NULL = herda o catálogo; (g) `table_name` no catálogo (sugestão: rastreia a
origem, ajuda engine e manutenção manual — a tool já gera).

```sql
-- setes_central (adicionar ao sql/01_setes_central_ddl.sql após revisar-ddl)
CREATE TABLE IF NOT EXISTS `tb_interface_has_field` (
  `tb_interface_id` int(11) NOT NULL,
  `field_name`      varchar(100) NOT NULL,             -- nome da coluna conforme a tabela
  `table_name`      varchar(100) DEFAULT NULL,         -- origem (interface ≠ tabela)
  `kind`            varchar(50)  NOT NULL,             -- String|Integer|Float|Boolean|Date
  `required`        char(1)      NOT NULL DEFAULT 'N', -- baseline técnico: 'S' = travado
  `created_at`      datetime DEFAULT NULL,
  `updated_at`      datetime DEFAULT NULL,
  `deleted`         char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_interface_id`, `field_name`),
  CONSTRAINT `fk_ihf_interface` FOREIGN KEY (`tb_interface_id`)
    REFERENCES `tb_interface` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- setes_<schema> (adicionar ao sql/03_schema_cliente_ddl.sql + migration)
CREATE TABLE IF NOT EXISTS `tb_institution_has_field` (
  `tb_institution_id` INT NOT NULL,
  `tb_interface_id`   INT NOT NULL,
  `field_name`        VARCHAR(100) NOT NULL,
  `field_caption`     VARCHAR(100) DEFAULT NULL, -- NULL = caption padrão (i18n do app)
  `required`          CHAR(1) DEFAULT NULL,      -- NULL = herda catálogo; 'S' só aperta
  `mask`              VARCHAR(50) DEFAULT NULL,  -- NULL = sem máscara custom
  `created_at`        DATETIME DEFAULT NULL,
  `updated_at`        DATETIME DEFAULT NULL,
  `deleted`           CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`tb_institution_id`, `tb_interface_id`, `field_name`),
  CONSTRAINT `fk_inhf_institution` FOREIGN KEY (`tb_institution_id`)
    REFERENCES `setes_central`.`tb_institution` (`id`),
  CONSTRAINT `fk_inhf_field` FOREIGN KEY (`tb_interface_id`, `field_name`)
    REFERENCES `setes_central`.`tb_interface_has_field` (`tb_interface_id`, `field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## Peças de implementação (visão de entregáveis)

1. **DDL + seeds** das 5 telas-piloto (tool + revisão manual + revisar-ddl).
2. **API**: `src/shared/validation/` (cpf/cnpj com dígito verificador, cep, fone,
   máscara — decisão 18) consumido pelos DTOs Zod; `field-config.service` (cache TTL,
   molde do flag.service) + helper genérico `assertRequiredFields(values, config)`
   no service dos módulos (decisões 1 e 2); erro por campo `{error, fields[]}`
   (decisão 20); endpoint de existência de CPF/CNPJ (decisão 21); endpoints do painel
   (listar campos por interface, salvar config) e endpoint de consumo (config
   resolvida por interface p/ o app).
3. **App — camada de validação base**: package `setes_validators` (decisão 22),
   funções componíveis (required/minLength/cpf/cnpj/cep/phoneBR/onlyDigits/...),
   mensagens i18n com override manual; máscaras via inputFormatters (decisão 16);
   gravação sempre sem máscara (decisão 19); checagem antecipada de duplicidade
   ao sair do campo (decisão 21).
4. **App — engine de merge**: a fábrica `RegisterFormPage` continua dona de ordem,
   lookups, teclado e abas; caption/required/mask do campo vêm do merge
   custom → catálogo → código (decisão 7). Abas compartilhadas da cadeia fiscal
   recebem a config do CONTEXTO que as abriu.
5. **App — painel Sistema/Admin** (decisão 6): módulo novo no padrão simétrico.
6. **Skills**: checklist "campo novo = linha nova no catálogo (rodar tool)" em
   criar-formulario-cadastro.md e novo-modulo.md (mitiga drift catálogo × código).

## Decisões da Rodada 3 (Valdo, 2026-07-12)

12. **DDL refinado APROVADO** — ajustes (a)–(g) confirmados (singular, char(1) S/N,
    PK composta no catálogo, field_name + PK tripla no cliente, `required` baseline no
    catálogo, `required` do cliente NULL = herda, `table_name` no catálogo).
13. **Kind `Date` incluído** (String | Integer | Float | Boolean | Date).
14. **Caption**: o catálogo NÃO guarda caption — modo padrão usa o i18n do app
    (field_name → chave forms.*); o custom do cliente é texto único (sem pt/en).
15. **Piloto confirmado**: countries/states/cities/privileges/interfaces — semear
    catálogo + telas consomem config, SEM mudar colunas dessas tabelas.
16. **Máscara**: padrão técnico `#` = dígito, `A` = letra, demais caracteres literais
    (ex.: `(##) #-####-####`) — validada na UI e na API.
17. **Sincronizador ISENTO** da obrigatoriedade comercial — rotas /sync validam só o
    baseline técnico.
18. **Funções de validação SÃO SHARED** (CPF/CNPJ/CEP/fone/etc.): vivem em código
    compartilhado — na API em `src/shared/validation/`, no app em package/shared — e
    cada tela/módulo as aplica INDIVIDUALMENTE (aplicação explícita, tela a tela;
    nada automático). Vale para as duas pontas: app valida com a shared dele, API
    revalida com a shared dela (API = fonte da verdade, decisão 1).
19. **Dados gravados SEM máscara**: fone, CEP e qualquer campo mascarado gravam só os
    dígitos/caracteres; a máscara é só de digitação/exibição.
20. **Payload de erro por campo APROVADO**: `{ "error": "...", "fields": [{ "field",
    "message" }] }` — sai do safeParse do Zod + validações de service.

## Decisões da Rodada 4 (Valdo, 2026-07-12)

21. **Duplicidade de CPF/CNPJ em dois momentos**: verificação ANTECIPADA ao sair do
    campo (app consulta endpoint de existência na API e avisa na hora) + bloqueio
    final no salvar (409 — garantia de integridade, API fonte da verdade).
22. **Biblioteca de validadores do app**: package novo `setes_validators` em
    `setes-app/packages/` (Dart puro, sem dependência de tela) — espelho do
    `src/shared/validation/` da API; aplicado tela a tela (decisão 18).
