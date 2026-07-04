# Skill: Revisar DDL (checklist de inconsistências)

**Quando usar**: antes de executar qualquer DDL novo ou alterado (tabela nova, migração, seed).
**Tempo**: ~15 min
**Origem**: 20+ inconsistências reais encontradas e corrigidas na Fase 2 (Gerenciamento Central) — cada item abaixo aconteceu de verdade.
**Referência de padrões**: `database/PADROES_BANCO.md`

---

## Workflow

1. Validar sintaxe com parser MySQL:
   ```bash
   python3 -c "import sqlglot; sqlglot.parse(open('arquivo.sql').read(), read='mysql'); print('OK')"
   ```
2. Rodar o checklist abaixo, item a item
3. Produzir relatório numerado: **inconsistência → correção sugerida** (não corrigir sem decisão do Valdo em itens arquiteturais)
4. Decisões tomadas viram entrada permanente na seção "Decisões arquiteturais" do prompt do projeto

## Checklist

### Estrutura
- [ ] **PK declarada existe como coluna?** (caso real: `ADD PRIMARY KEY (tb_entity_id)` mas a coluna chamava `id`)
- [ ] **Colunas duplicadas por variação de nome?** (caso real: `tb_line_business_id` E `tb_linebusiness_id` na mesma tabela)
- [ ] **FK aponta para coluna que existe?** (caso real: FK em `tb_entity_id` após a coluna ser renomeada para `id`)
- [ ] **FK composta cobre a PK composta do destino?** (caso real: `tb_user_id` referenciando PK (`id`,`kind`))
- [ ] **Tabela referenciada por FK tem PK/índice?** (caso real: `tb_mailing` e `tb_mailing_group` sem PK nenhuma)
- [ ] **PK composta compatível com o requisito?** (caso real: PK (`id`,`kind`) × "múltiplos endereços" — confirmar se 1-por-tipo é intencional)

### Padrões da casa (PADROES_BANCO.md)
- [ ] Prefixo `tb_`, inglês, singular; N:N como `tb_a_has_b`
- [ ] Colunas `created_at`/`updated_at`/`deleted char(1) 'N'` presentes
- [ ] Flags `'S'`/`'N'` (caso real: `main DEFAULT 'Y'` destoando)
- [ ] Sem AUTO_INCREMENT (IDs pela aplicação); sem `DEFAULT 0` em coluna que é FK (caso real: `tb_phone.id DEFAULT 0` quebraria a FK)
- [ ] `DEFAULT NULL` real, não a string `'NULL'` (caso real: `tb_interface.position`)
- [ ] Nomes em inglês (caso real: `acao_botao` → `button_action`)
- [ ] Tabela vive na base certa? (central × schema do cliente — nunca as duas)
- [ ] FK cross-schema explícita quando referencia a central (caso real: `tb_customer` referenciando `tb_entity` local inexistente)

### Seeds e execução
- [ ] **Seed compatível com o DDL final?** Colunas do INSERT existem? (caso real: seed com `salt` e `kind` após remoção das colunas)
- [ ] **FKs do seed satisfeitas?** (caso real: endereço com país/estado/cidade sem as linhas de `tb_country/state/city`)
- [ ] Sem datas `0000-00-00` (falha em modo estrito) — usar `NOW()`
- [ ] **Ordem de dependência**: CREATEs e INSERTs na ordem das FKs (caso real: `tb_institution_has_user` criada antes de `tb_user`/`tb_institution`)
- [ ] Script re-executável? (`CREATE TABLE IF NOT EXISTS` com constraints no CREATE, não em ALTER solto)

### Segurança
- [ ] Hash de senha aplicado no backend, nunca comparado na query SQL
- [ ] Nenhum dado sensível real em seeds commitados

## Saída esperada

Relatório no formato usado na Fase 2:

```
## ⚠️ Inconsistências encontradas
1. **<tabela> — <problema>**: <evidência>. **Correção**: <sugestão>.
2. ...
```
