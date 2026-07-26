# Engine de Modernização de Legado — Kit de Portabilidade

**Versão**: 0.2 (2026-07-19) — 1ª destilação, extraída do caso zero
**Escopo**: metodo
**Origem**: `Infra-IA/prompts/rascunho_engine_modernizacao.md` (diário do produto) — este kit é a materialização da fila `misto`/`metodo` do censo de escopo de 2026-07-19
**Casa canônica**: PROVISORIAMENTE aqui; a casa definitiva (cofre neutro, fora dos workspaces das empresas) será decidida na rodada de PI do produto

---

## O que é este kit

O conjunto mínimo e **portável** do método de modernização de legado: os documentos
que podem ser instalados em qualquer empresa/caso novo SEM carregar conteúdo de
nenhum caso anterior. Tudo aqui é `escopo: metodo` — neutralizado, sem nomes de
domínio, tabelas ou stack de nenhum cliente.

**A engine em uma frase**: avaliar o repositório legado → destilar os conceitos de
negócio da casca do sistema antigo → conduzir o dono do negócio por rodadas de
decisão registradas → reescrever em peças composáveis → reter cada aprendizado na
base de conhecimento.

## Conteúdo

| Arquivo | Papel na engine |
|---|---|
| `INSTALACAO.md` | Passo a passo executável de instalação num caso novo (Dia 1 / Dia 2+ / o que nunca fazer) |
| `ESTRUTURA_BASE_CONHECIMENTO.md` | Fase 0 — montar o "vaso": base de conhecimento governada (regras raiz, índice com histórico, simetria projeto↔conhecimento) |
| `skills/avaliar-repositorio-legado.md` | Fase 1 — avaliação fiel do legado (inventário, DE-PARA, pendências; em repositórios grandes: indexar antes de ler) |
| `skills/guardiao-conceitual.md` | Fase 2 — destilar conceitos: peças de lego, não maquetes (teste da maquete / fato gerador) |
| `skills/rodadas-de-decisao.md` | Fase 3 — o dono do negócio decide; decisões numeradas, permanentes, rastreáveis no código |
| `skills/reter-conhecimento.md` | Ciclo contínuo — o que reter, onde, e a cadeia de atualização obrigatória |
| `skills/censo-de-escopo.md` | Governança — classificar todo o acervo (`metodo × <caso> × misto`) em paralelo, com verificação |
| `seguranca-git/` | Higiene de versionamento e proteção de secrets (crítico em legados: assuma credencial hardcoded até prova em contrário) |

## Como instalar num caso novo

**Siga `INSTALACAO.md`** — passo a passo executável (comandos, ordem, checklists):
Dia 1 monta o vaso (base de conhecimento + regras + índice + conexão com ferramentas
existentes + censo do acervo), Dia 2+ liga a engine no legado (dimensionar → unidade
piloto → primeiro ciclo completo avaliar→conceituar→decidir→reter). Critério de
sucesso: UM ciclo completo rodado numa unidade piloto, tudo registrado na base.

## Regras de higiene do multi-caso (invioláveis)

- **Conteúdo de caso NUNCA cruza empresas.** Código, DDL, decisões de domínio,
  nomes de clientes: nada disso entra no kit nem viaja entre casos. Só o MÉTODO viaja.
- **O kit só recebe material `metodo`** (ou `misto` já destilado — princípio separado
  da instância). Na dúvida, fica de fora.
- **Melhorias do método descobertas num caso** voltam para o kit DESTILADAS (sem o
  contexto do caso) e são registradas no diário do produto.
- Decisões do dono do produto nunca se perdem: registradas numeradas, com o porquê.

## Versionamento do kit

Cada evolução: nova linha na tabela abaixo + atualizar a **Versão** no topo.

| Versão | Data | O quê |
|---|---|---|
| 0.1 | 2026-07-19 | Kit inicial extraído do caso zero: 5 skills + esqueleto da base + pacote de segurança git (11 docs neutralizados) |
| 0.2 | 2026-07-19 | `INSTALACAO.md` criado (feedback do dono: "como instalar" não estava executável) — passo a passo Dia 1/Dia 2+ com comandos, conexão com ferramentas existentes, unidade piloto e "o que nunca fazer" |
