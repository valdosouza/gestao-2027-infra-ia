# Densidade e layout das telas do setes-app web

**Status**: Ondas A (densidade no tema) e B (grade nos formulários) EXECUTADAS em WORKTREE em 2026-10-17, com passeio antes × depois feito (§4) —
`D:\Gestao2027\densidade\setes-app` (branch `densidade`, commit LOCAL 071b710 — sem push, sem merge). **Onda D (shell)
EXECUTADA em WORKTREE em 2026-10-18 (§7)** — `D:\Gestao2027\shell\setes-app` (branch `shell`, saiu do `main`): os dois bugs do
shell (formulário destruído ao cruzar o breakpoint; ☰ coberto no celular) CORRIGIDOS e provados em teste; D-DL6/D-DL7 decididas
pelo Valdo; o mesmo defeito no LOGIN também corrigido no branch (§7.1). 🎉 **PUBLICADO na produção em 2026-10-18 (§8)**: `main`
do setes-app = a450909 (merge da `densidade` no `shell`, fast-forward na árvore viva) e app reiniciado na :5051; push ao GitHub feito (2f621c1..a450909).
**Onda C (lista em tabela) e grade no resto do app EXECUTADAS em WORKTREE em 2026-10-20 (§9)** —
`D:\Gestao2027\densidade-c\setes-app` (branch `densidade-c`, saída do `main` a450909): testes verdes, gates 0,76/0,80, NADA
commitado; pendem o passeio antes × depois (API fora no dia) e as questões Q-DL8…Q-DL11.
**Origem**: pedido do Valdo (2026-10-17): as telas do sistema web aparecem grandes, com campos e listas largos
demais, e isso prejudica a renderização em telas menores. A sessão fez o diagnóstico como frontend sênior de
Flutter e, depois, executou as ondas A e B.
**Referências**: `setes-app/skills/criar-formulario-cadastro.md` (contrato visual, item 3 — layout),
`setes-app/ARQUITETURA_MODULOS.md`, `setes-app/prompt_fase1_fundacao.md` (decisão 5 — helper `Responsive`)
**Escopo**: setes

---

## 1. Diagnóstico (medido no navegador interno, logado, em 2026-10-17)

| Tela | O que acontecia |
|---|---|
| 1366×768 (notebook em 100 %) | menu fixo de 440 px (200 + 240) → sobram 926 px; CNPJ, IE e Data de Fundação com ~900 px de largura cada; lista de Clientes com 8 linhas (~65 px cada) |
| 1093×540 (o mesmo notebook com o Windows em 125 % — escala da máquina do Valdo) | fica abaixo do breakpoint de 1100 → layout de CELULAR (menu vira gaveta); duas barras + filtro + paginação ocupam quase metade da altura; 4 linhas de lista |

Causas, da maior para a menor:
1. **Formulário = coluna única sem limite** — `RegisterFormPage` era um `ListView` com um campo por linha; o
   mesmo valia para `entity_main_tab` e para as telas de processo.
2. **Lista = item de celular** — `RegisterSearchPage` usa `ListTile` de 2 linhas com avatar.
3. **Estrutura fixa da tela** — menu de 2 colunas sempre aberto, AppBar do shell + AppBar da tela (112 px),
   breakpoint `Responsive` medido pela JANELA (`MediaQuery`), não pela área útil.
4. **Tema sem densidade explícita** — sem `inputDecorationTheme`, `listTileTheme` ou `toolbarHeight`; texto do
   campo nos 16 px do Material 3.

**BUG achado na medição (pendente — §5)**: quando a janela cruza os 1100 px (ao maximizar ou restaurar), o
formulário aberto é DESTRUÍDO e quem estava digitando perde o conteúdo. Provado: o cadastro da A.S.M Alimentos
aberto em 1366 → redimensionado para 1093 → voltou para a lista. Causa: `home_page.dart` troca a árvore
inteira (`ContentHomeMobile` × `ContentHomeDesktop`) e o `RouterOutlet` é recriado.

Mitigação sem código (válida hoje): `Ctrl` + `−` no navegador — o Flutter web refaz o layout com o zoom
(no notebook em 125 %, zoom de 80 % devolve os 1366 px lógicos e o layout de desktop).

## 2. Decisões

- **D-DL1** (Valdo: "densidade fixa no tema" — a recomendação foi aceita): a densidade é FIXA por plataforma,
  nunca por largura: mouse e teclado (Windows, macOS e Linux, inclusive no navegador) = compacta; toque
  (Android, iOS) = padrão do Material. Não existe preferência do usuário (nenhuma mudança na API). Uma
  preferência "Compacto / Padrão", nos moldes do idioma em `tb_user_has_preference`, só entra se algum
  cliente pedir.
- **D-DL2**: os tokens moram em `SetesDensity` (`packages/core/lib/src/theme/setes_theme.dart`), como as cores:
  - campo: texto de 14 px e `contentPadding` 12 × 14 → **~41 px** (era 48 na densidade compacta do M3 e 56 no padrão);
    rótulo flutuante com base 16 → 12 px (`floatingLabelFontSize` — §4);
  - barras: `toolbarHeight` 48;
  - linhas de lista e itens de menu: `VisualDensity(horizontal: -2, vertical: -4)` → 40 px (uma linha) e
    56 px (duas linhas).
  A escolha é feita por `SetesTheme.build(compact:)`; o padrão é `SetesDensity.compactByPlatform`.
- **D-DL3**: grade `SetesFormGrid` (`packages/setes_widgets`) com 12 colunas medidas pela área DISPONÍVEL
  (`LayoutBuilder`, nunca `MediaQuery`), faixas do M3 (compacta < 600, média < 840, expandida ≥ 840), teto
  de 1200 px alinhado à esquerda e ordem declarada (linha a linha; quebra quando o próximo campo não cabe — a
  ordem de Tab não muda). Tamanho SEMÂNTICO, nunca em pixels:

  | Tamanho | Uso | Expandida | Média | Compacta |
  |---|---|---|---|---|
  | `small` | códigos, datas, documentos, valores | 3/12 | 4/12 | 12/12 |
  | `medium` | textos curtos, listas de apoio, e-mail | 4/12 | 6/12 | 12/12 |
  | `large` | nomes e descrições | 6/12 | 12/12 | 12/12 |
  | `full` | texto longo, seções, grupos de opções | 12/12 | 12/12 | 12/12 |

- **D-DL4**: na fábrica, `RegisterField.size` (padrão `large`; o `RegisterField.lookup` nasce `medium`) é
  preservado por `applyFieldConfig`; os `extraChildren` viram UMA linha inteira abaixo dos campos. Na aba
  principal da entidade (`entity_main_tab` — clientes, fornecedores, transportadoras, colaboradores,
  estabelecimentos): nome e apelido/fantasia em `large`; documentos e datas em `small`; o toggle F/J/N em `full`.
- **D-DL5** (Valdo): as ondas A e B vêm primeiro, numa worktree, com antes e depois mostrados no navegador.
  C e D ficam para depois (§5).
- **D-DL6** (Valdo, 2026-10-18 — "Uma barra no desktop", a recomendação): com o menu ao lado NÃO existe barra do shell — a
  logomarca vai para o topo da coluna de módulos e o usuário, o idioma e o tema para o pé dela; a única barra é a da tela
  aberta (+48–56 px de altura). Na gaveta (área estreita) fica uma barra do shell ENXUTA: ☰ + logomarca + o botão do usuário
  só com o ícone (nome, idioma, tema e Sair dentro do menu dele), mais a barra da tela. Só o shell muda — nenhuma das ~30 telas.
  Alternativas recusadas: "uma barra em toda largura" (o ☰ entraria na barra de cada tela: ~20 arquivos e o risco de tela sem
  barra deixar o celular sem menu) e "duas barras, só o ☰" (não ganha altura).
- **D-DL7** (Valdo, 2026-10-18 — "840 px + coluna recolhível", a recomendação): o menu fica ao lado a partir de **840 px de
  ÁREA ÚTIL** (`LayoutBuilder` — a faixa "expandida" do M3, a mesma da `SetesFormGrid`); abaixo, gaveta. A 2ª coluna
  (interfaces do módulo) recolhe com « no cabeçalho dela e volta com um clique no módulo (que mostra › enquanto recolhida).
  O notebook em 125 % (1093 px) passa a ter o menu ao lado: conteúdo com 653 px (coluna aberta) ou 893 px (recolhida).
  Alternativas recusadas: manter 1100 px; trilho só de ícones abaixo de 1200 px.

## 3. Execução das ondas A e B (worktree `densidade`, 2026-10-17)

- `packages/core/lib/src/theme/setes_theme.dart` — `SetesDensity` + `build(compact:)`.
- `packages/setes_widgets/lib/src/setes_form_grid.dart` — `SetesFormGrid`, `SetesFormGridItem`, `SetesFieldSize`.
- `apps/web/lib/app/shared/register/register_form_page.dart` (+ `field_config_merge.dart`) — a grade na fábrica.
- 11 telas da fábrica com o tamanho de cada campo (bancos, CFOP, cidades, países, interfaces, módulos,
  privilégios, vendedores, serviços LC 116, estados, usuários).
- `apps/web/lib/app/shared/entity/widgets/entity_main_tab.dart` — a grade na aba principal.
- Testes: `setes_widgets/test/setes_form_grid_test.dart` (faixas, ordem, quebra, teto) e
  `core/test/theme/setes_theme_density_test.dart` (tokens, plataforma, altura do campo 56 → 38–42).
- Suítes: core 80/80 · setes_widgets 10/10 · app web 631/631 (28 pulados de antes). O `ibscbs_ib3_test` lê o
  setes-api IRMÃO em `../../../setes-api`; nesta worktree o irmão não existe (`densidade/` só tem o app), então ele
  falha até rodar com `SETES_API_DIR=D:/Gestao2027/setes-api`. Com essa variável passa 18/18 — é ambiente, não
  regressão.
- ⚠️ Conhecimento negativo de teste: para medir tema em widget test, depois de `pumpWidget` com OUTRO
  `MaterialApp`, é obrigatório `pumpAndSettle()` — o `MaterialApp` ANIMA a troca de tema (`AnimatedTheme`),
  e sem ele a medição lê o tema antigo.

## 4. Antes × depois (passeio de 2026-10-17 — o Valdo logado na :5000, o agente só navegou)

Mesmos dados e mesmo tamanho de tela: produção (:5051) × worktree (:5000). Imagens lado a lado em
`D:\Gestao2027\densidade\comparativo\` (fora do repositório).

| Tela | Antes | Depois |
|---|---|---|
| Clientes, aba Principal (PJ), 1366×768 | 6 linhas de campos, cada um com ~900 px | 2 linhas: Razão Social + Fantasia; CNPJ + IE + IM + Data |
| Cidades (fábrica), 1366×768 | 7 linhas | 2 linhas: Código + Estado + Nome; IBGE + População + Densidade + Área |
| Lista de Clientes, 1366×768 | 8 linhas visíveis | 9 linhas (ganho só da densidade — a lista em tabela é a onda C) |
| Clientes, aba Principal, 1093×540 (Windows em 125 %) | o formulário não cabe (a Data de Fundação fica abaixo da dobra) | 2 linhas, cabe com folga |
| Celular 375×812 (toque) | um campo por linha | igual (densidade padrão, linha inteira) |

Achado no passeio e corrigido na mesma sessão: com o texto do campo em 14 px, o rótulo flutuante caiu para
10,5 px (o Material o reduz a 75 %). Agora `SetesDensity.floatingLabelFontSize = 16` no
`inputDecorationTheme.floatingLabelStyle` → 12 px, como era; só o tamanho, a cor de foco/erro continua do
Material (`_getFloatingLabelStyle` mescla por cima).

## 5. Pendências

1. ~~**BUG do formulário destruído ao cruzar o breakpoint**~~ — **CORRIGIDO na onda D (§7)**: shell adaptativo único, o
   `RouterOutlet` numa posição estável da árvore.
2. ~~**BUG: no celular (375 px) o ☰ do menu não aparece**~~ — **CORRIGIDO na onda D (§7)**: barra estreita enxuta (D-DL6).
   Causa medida: as ações somavam ~360 px e a `AppBar` as alinha à direita POR CIMA do leading — o logo (uma `Image`,
   que absorve o toque) cobria o ☰ e o título sumia.
3. ~~**Onda C — lista em tabela no desktop**~~ — **EXECUTADA em worktree 2026-10-20 (§9)**: peça `SetesDataList`
   (setes_widgets), a fábrica e a lista de OS desenham tabela com cabeçalho e linha de 36 px a partir de 840 px de área;
   item no celular. 27 listas da fábrica declaram as colunas.
4. ~~**Onda D — estrutura da tela**~~ — **EXECUTADA (§7)**: breakpoint pela área útil (840 px, D-DL7), 2ª coluna recolhível,
   uma barra só no desktop (D-DL6).
5. ~~**Grade no resto do app**~~ — **EXECUTADA em worktree 2026-10-20 (§9.3)**: 165 das 195 `SetesTextField` em
   grade (as 30 que ficaram têm motivo — filtro de lista, dialog de um campo, linha de tabela, barra de pesquisa).
6. ~~**Publicação**~~ — **EXECUTADA em 2026-10-18 (§8)** (Valdo: "vai"): `main` = a450909, app reiniciado na :5051 e push
   ao GitHub feito.
7. ~~**Mesmo defeito no LOGIN**~~ — **CORRIGIDO em 2026-10-18 no mesmo branch `shell` (§7.1)** (Valdo: "faça esta tarefa
   aqui"): `ContentLogin` único; o `Responsive` ficou sem consumidor.
8. **Passeio logado da onda D (o "depois")** — o Valdo pediu para pular em 2026-10-18; o "antes" da produção está no §7.
   Roteiro no §7.
9. **Passeio da onda C e da grade (antes × depois)** — ficou para a publicação: no dia da execução (2026-10-20) o setes-api
   :3000 e o app :5051 estavam fora do ar (§9.6).

## 6. ⏯ Retomada

"Retome a frente de densidade do setes-app pelo §9 de `Infra-IA/prompts/prompt_densidade_layout_web.md`: a onda C (lista em
tabela) e a grade no resto do app estão EXECUTADAS na worktree `D:\Gestao2027\densidade-c\setes-app` (branch `densidade-c`, saída
do `main` a450909), com testes e gates fechados, NADA commitado. Faltam: as questões Q-DL8…Q-DL11 (§9.7), o passeio antes × depois
(§9.6 — subir o setes-api :3000 e `flutter run -d chrome --web-port 5000` na worktree) e, com o "vai", commit → merge no `main` →
app na :5051 → push. Portas livres do CORS da nfse-api: 5000 e 8080."

## 7. Execução da onda D — shell (worktree `shell`, 2026-10-18)

Worktree `D:\Gestao2027\shell\setes-app`, branch `shell` saído do `main` (2f621c1) — independente da `densidade` (nenhum
arquivo em comum). App da worktree: `.env` com `WEB_PORT=8080`; entrada `setes-app-web-shell` no `.claude/launch.json`.

**Arquivos**
- `apps/web/lib/app/modules/home/presentation/content/content_home.dart` ⭐ — UM content adaptativo (`ContentHome` +
  `HomeLayout`): `LayoutBuilder` decide só o conteúdo do espaço do menu (colunas × vazio), a barra (nenhuma × enxuta) e a
  gaveta; o `RouterOutlet` é o filho com chave `home-shell-outlet` de um `Row` que existe em TODA largura. Menu lateral:
  logomarca no topo da coluna de módulos, usuário + idioma + tema no pé; cabeçalhos das duas colunas na altura e na cor da
  barra (com a barra da tela formam uma faixa); « recolhe a 2ª coluna, › no módulo aberto quando recolhida.
- `content_home_desktop.dart` e `content_home_mobile.dart` APAGADOS; `page/home_page.dart` usa o `ContentHome`.
- `presentation/bloc/menu_bloc.dart` — `MenuInterfacesCollapseToggled` + `MenuLoaded.interfacesCollapsed` (clicar num
  módulo mostra a coluna de novo).
- core: `UserBadge` (`compact: true` = só o ícone, nome no topo do menu; `entriesBuilder` = itens extras montados com o
  contexto do PRÓPRIO badge — o do popup morre antes de o item rodar; nome com reticências quando a largura é limitada);
  `LanguageSelector.labelOf/change` (a troca de idioma reaproveitável no menu do usuário); `Responsive.build` pela área
  útil (`LayoutBuilder`) + aviso do conhecimento negativo.
- setes_widgets: `SetesScaffold.appBarTitleWidget` (logomarca como título); `SetesIconButton.color`.
- i18n pt/en: `home.collapseInterfaces`, `home.expandInterfaces`.

**Provas** (o Modular é singleton — um cenário por arquivo; apoio comum em `test/support/home_shell_harness.dart`)
- `apps/web/test/home_shell_resize_test.dart`: o `ContentHome` real com um formulário (forma do `SetesFormShell`) no
  `RouterOutlet`; 1366 → 1093 (menu ao lado) → 2ª coluna recolhida → 800 (cruza os 840: gaveta) → 1366 — o texto digitado
  e o FOCO sobrevivem e o formulário nasce UMA vez. Inverso conferido: com duas árvores por largura o texto some.
- `apps/web/test/home_shell_drawer_test.dart`: 375×812 com o `UserBadge` REAL (nome longo) e logomarca LARGA (160 px) — o
  toque no centro do ☰ abre a gaveta com os módulos, o botão do usuário não cobre o ☰ e o nome não está na barra. Inverso
  conferido: com as ações antigas (logo + nome + idioma + tema) o toque no ☰ não abre a gaveta.
- Suítes (com `SETES_API_DIR=D:/Gestao2027/setes-api`): app web 634/634 (27 pulados de antes) · core 76/76 ·
  setes_widgets 5/5 · `flutter analyze` limpo nos três. Gates do harness (revisar-riscos + adversarial) NÃO rodados — o
  piloto deles é setes-api/setes-sync; a mudança é só de apresentação do shell.

**Antes (produção :5051, 2026-10-18)**: a 375×812 o logo é pintado POR CIMA do ☰ (só a borda dele aparece) e o título
"Setes ERP" some; a 1093×540 o app cai no layout de celular (gaveta), com duas barras (112 dos 540 px) e 4 linhas na lista
de Clientes. **Depois logado: PENDENTE** — o Valdo pediu para pular o passeio (o app da worktree pede login na 8080, outra
origem; o agente nunca digita senha). Para fazer: subir `setes-app-web-shell`, o Valdo entra, e conferir 375 / 1093 / 1366
com um formulário aberto ao redimensionar.

**Conhecimento negativo (testes de widget do shell)**
- Com um campo focado o cursor pisca para sempre: `pumpAndSettle` nunca assenta e o teste TRAVA (sem erro, até o limite) —
  depois do foco, `pump` com duração.
- `await bloc.close()` dentro do relógio falso do `testWidgets` nunca completa (trava) — `await tester.runAsync(bloc.close)`.
- Logomarca de teste NÃO pode ser `SizedBox` vazio: ele deixa o toque passar e esconderia o bug do ☰ — a `Image` real
  absorve o toque (`testLogo` usa `ColoredBox`).
- Na worktree, `ChildRoute('/customers')` filho de `ChildRoute('/')` responde em `/home/customers` (SEM barra final);
  `/home/customers/` dá `RouteNotFound`.
- PowerShell 5.1: `Get-Content`/`Set-Content` sem `-Encoding` estragam UTF-8 (acentos viram `Ã©`) — editar fonte só com
  a ferramenta de edição.

### 7.1 Login — o mesmo defeito, corrigido no mesmo branch (2026-10-18)

Valdo: "faça esta tarefa aqui" (o card de follow-up proposto ao fim da onda D). A `LoginPage` (core) escolhia entre
`ContentLoginDesktop` e `ContentLoginMobile` pelo `Responsive` — duas árvores, com o `LoginForm` (controllers de usuário e senha)
em posições diferentes. Cruzar 1100 px com o login aberto recriava o formulário: o que tinha sido digitado sumia.

- `packages/core/lib/src/auth/presentation/content/content_login.dart` ⭐ — UM `ContentLogin`: `LayoutBuilder` pela área útil, o
  mesmo limite de antes (1100 px) e a MESMA aparência dos dois lados (largo = formulário de 400 px sem margem; estreito = largura
  toda com 24 px de margem; seletor de idioma com 12 × 8 px de folga). Os widgets da moldura existem nas duas larguras e só mudam
  de medida. ⚠️ `SingleChildScrollView(padding: null)` tira o `Padding` da árvore e o filho muda de posição — usar `EdgeInsets.zero`.
- `content_login_desktop.dart` e `content_login_mobile.dart` APAGADOS; `page/login_page.dart` usa o `ContentLogin`.
- `Responsive` (core) ficou SEM consumidor — mantido, com o aviso; não é peça morta.
- Prova `apps/web/test/login_resize_test.dart` (no app: o logo da Setes é asset que só o app declara): a `LoginPage` REAL com o
  `EasyLocalization` de verdade (o seletor de idioma lê `context.locale`); 1366 → 800 → 1366 com usuário, senha, "Lembrar
  credenciais" e foco intactos, e o MESMO `State` do `LoginForm`. Escrito ANTES da correção: falhava (usuário vazio em 800 px).
- Suítes (com `SETES_API_DIR=D:/Gestao2027/setes-api`): app web 635/635 (27 pulados de antes) · core 76/76 · `flutter analyze`
  limpo nos dois.
- Navegador (app da worktree na 8080, sem login): `usuario.teste` digitado no Usuário a 1200 px → 800 px (formulário na largura
  toda) → 1200 px, o texto e o cursor intactos (conferido também pelo `input` do DOM). A senha não foi tocada; nada enviado.
- Conhecimento negativo de teste: a fonte do teste (Ahem) desenha cada letra como um quadrado do tamanho da fonte — a linha
  "Lembrar credenciais" + "Esqueci minha senha" estoura os 400 px SÓ no teste; `textScaleFactorTestValue = 0.5` resolve. O
  `EasyLocalization` sobe no teste sem `ensureInitialized()` com `saveLocale: false` e um `AssetLoader` que lê o JSON do app (o app
  não declara `shared_preferences`).
- Navegador com o painel OCULTO: a página roda em segundo plano e a imagem atrasa — o texto digitado só aparece na captura
  seguinte; conferir pelo DOM (`input.value`) antes de concluir que o clique falhou.

## 8. Publicação (2026-10-18 — Valdo: "vai")

- Na worktree `shell`: `git merge densidade` → a450909 (merge sem conflito: os branches não tinham arquivo em comum). Suítes
  sobre o código COMBINADO (com `SETES_API_DIR`): app web 635/635 (27 pulados de antes) · core 80/80 · setes_widgets 10/10 ·
  `flutter analyze` limpo nos três.
- Árvore viva `D:\Gestao2027\setes-app`: `git merge --ff-only shell` → `main` = a450909 (de 2f621c1); só os `.dart_tool/*`
  seguem modificados fora de commit, como antes.
- App de produção reiniciado na :5051 (`run-dev.ps1`, aba do Terminal "setes-app web 5051"). ⚠️ Achado: no momento do
  "vai" NADA de produção estava no ar — nem a 5051, nem o setes-api (3000), nem a nfse-api (3002); só a 5000 da worktree
  `densidade`. No começo da sessão os três estavam de pé (provável reinício do app desktop fechando as abas do Terminal).
  As APIs NÃO foram religadas aqui: o boot do setes-api aplica migrations (decisão do Valdo). Com a API fora, a casa abre no
  aviso "Sem resposta do serviço — `NETWORK · setes-api`" — o shell novo só aparece de verdade com a API de volta.
- Push ao GitHub (Valdo: "vai"): `2f621c1..a450909`. As APIs de produção ficaram para o Valdo subir. As worktrees `densidade` e `shell` ficam (branches já integrados ao `main`); podem ser removidas quando
  ninguém mais trabalhar nelas — a onda 1 do cadastro de produtos nasceria sobre a `densidade`: agora nasce sobre o `main`.

## 9. Execução da onda C e da grade no resto do app (worktree `densidade-c`, 2026-10-20)

Worktree `D:\Gestao2027\densidade-c\setes-app`, branch `densidade-c` saída do `main` (a450909). Sessão aberta por outra sessão
(tarefa: onda C + grade, com testes e gates, SEM commit). Nada commitado, nada aplicado fora da worktree. Diff: 62 arquivos
modificados + 6 novos (peça, 2 testes de peça, 3 provas de tela). ⚠️ As branches em curso que tocam o app (`privilegios-crud`,
`cnpj`, `taxrules-ncm`) foram SIMULADAS em merge de 3 vias contra os arquivos desta worktree (`git merge-file` com o
merge-base de cada uma, CRLF normalizado): **zero conflitos** — a `RegisterFormPage`/`RegisterFormShell`/`CrudPrivileges` não
foram tocadas aqui; na `register_search_page.dart` a `privilegios-crud` mexe no FAB, esta onda no `_buildList`.

### 9.1 Onda C — a peça `SetesDataList` (setes_widgets)

- `packages/setes_widgets/lib/src/setes_data_list.dart` ⭐ — lista de registros que vira TABELA no desktop e continua ITEM no
  celular. A tela entrega as células como texto (`cellsOf`) e a peça decide pela largura DISPONÍVEL (`LayoutBuilder`): **≥ 840 px**
  (`SetesFormGrid.expandedBreakpoint` — o mesmo corte do menu ao lado, D-DL7) = cabeçalho com os rótulos das `columns` + UMA linha
  de **36 px** por registro (`rowHeight`), cada célula numa coluna; abaixo = o `SetesListTile` de duas linhas de sempre
  (`CircleAvatar` do código, 1ª célula título, demais no subtítulo com " · " — a célula vazia some). A peça só desenha: seleção,
  toque e paginação continuam do dono.
- `SetesListColumn(label, kind, flex)` — o TIPO decide o alinhamento: `text` à esquerda (flex 3), `number` à direita, `date` no
  centro, `status` à esquerda e estreita (flex 1). Sem `columns`: tabela SEM cabeçalho, colunas pela maior linha da página (1ª flex 3,
  demais 2) — a fábrica decide a forma; tela nenhuma PRECISA mudar para ganhar a tabela. Com `columns`: célula que sobra entra na
  última (" · "), célula que falta fica vazia.
- `codeOf`/`codeLabel` = coluna estreita do código (64 px, à direita) × avatar no celular; `onToggle`/`isSelected`/`canToggle` = caixa
  de seleção do lote (na tabela, `Checkbox` compacto de 32 px dentro da linha; no celular, antes do avatar); `trailingOf`/
  `trailingLabel` = widget do fim (selo) como ÚLTIMA coluna, texto em uma linha com reticências; `subtitleOf` = a frase do celular
  quando as células cruas da tabela não servem de subtítulo. ⚠️ Exige ALTURA limitada (como o `ListView` que substitui).
- `apps/web/lib/app/shared/register/register_search_page.dart` — `_buildList` usa a peça; parâmetro novo `columns`
  (`List<SetesListColumn>?`); `codeLabel = register.colCode`. Nada mais mudou na fábrica (a `privilegios-crud` mexe no FAB).
- **27 listas da fábrica com `columns`** (rótulos = as chaves dos campos do próprio form, no padrão "por extenso"; novas
  `register.colCode/colName/colStatus/colModules`, `forms.contract.colPeriod/colMonthly`, `forms.taxRules.colPieces`, pt + en).
  REGRA nova (skill `criar-formulario-cadastro.md` item 5): célula em POSIÇÃO FIXA — `cond ? valor : ''`, nunca `if (cond) valor`
  (com `if` a coluna "anda" entre linhas; a vazia some do subtítulo no celular). Corrigidas nas 10 listas que tinham `if`: contas
  bancárias (gerente), carteiras (inativa, nosso número), CFOP (abreviada), interfaces (grupo, i18n), configs e campos de interface
  (módulos), formas de pagamento (código NF-e, app mobile), tabelas de preço (vigência), regras de ISS (trib. nacional), regras de
  tributação (estado), regras de recebimento (validade).
- **Lista de OS** (`service_orders/presentation/page/service_order_page.dart`, `_buildListBody`): colunas Nº · Cliente · Nota · Data ·
  Itens · Total · NFS-e (`forms.serviceOrder.colNumber…colFiscal`); a seleção do lote (`_selected`) e o selo fiscal (`_fiscalSeal`)
  são os mesmos nas duas formas; `subtitleOf` mantém a frase de antes no celular ("Nota N · data · Itens: N · Total: R$ …").
- i18n: pt/en simétricos (script conferiu TODA chave `.tr()` dos arquivos tocados nos dois JSON: 0 faltando).

### 9.2 Provas da onda C

- `packages/setes_widgets/test/setes_data_list_test.dart` (10): cabeçalho + linha de 36 px; alinhamento por tipo; sem colunas = sem
  cabeçalho e coluna fixa; sobra na última; toque × caixa (marcar não abre a linha); widget do fim; celular = avatar/título/subtítulo;
  **839 px item, 840 px tabela**; célula vazia sem " · " solto; `subtitleOf`; caixa antes do avatar.
- `apps/web/test/density_c_cities_table_test.dart` — a `CityPage` REAL (Modular com binds de teste, repositório mocktail,
  traduções pt): 1366×768 = tabela (Cód. · Nome da Cidade · Estado, código numa coluna, linha de 36 px, `RegisterPagingBar`,
  "2 registros"), filtro rápido dispara o bloc e a lista volta, toque abre a `RegisterFormPage` e o voltar devolve a tabela;
  375×812 = 2 `ListTile` + 2 `CircleAvatar`, sem rótulos; 871 px de janela (839 de área) ainda item, 872 tabela.
- `apps/web/test/density_c_customers_table_test.dart` — a `CustomerPage` REAL (8 datasources mock): tabela (Cód. · Nome · Razão
  Social · Situação), células da mesma coluna alinhadas entre linhas, paginação "próxima" pede a página 2 e continua tabela, filtro,
  toque faz o GET e abre o form; celular = subtítulo "Setes Sistemas Ltda · Ativo".
- `apps/web/test/density_c_service_orders_table_test.dart` — a `ServiceOrderPage` REAL (harness do gate adversarial): tabela com os
  7 cabeçalhos, número à direita, data no centro, selo na última coluna, 2 caixas; marcar uma OS → badge "1" na AppBar; 375 px =
  item com caixa + avatar e "Itens: 2", a seleção sobrevive, marcar a 2ª → badge "2"; de volta a 1366 as duas continuam marcadas.
  Mais o molde das OS faturadas (sem FATURAR = sem caixa).
- Inversos conferidos: antes da onda, a 1366 px a lista era `ListTile` (os testes de tabela falhariam na estrutura antiga — sem
  rótulos e sem linha de 36 px).

### 9.3 Grade no resto do app (`SetesFormGrid` — D-DL3/D-DL4)

Executada por 3 agentes em paralelo (grupos A financeiro · B pedidos/contratos/tributos · C entidades/admin/dialogs), um arquivo por
vez, SEM mudar comportamento (controllers, validators, foco, `onChanged`, i18n, ordem dos campos). Regras aplicadas: sequência de
campos → `SetesFormGrid(items: [SetesFormGridItem(size: …)])` na mesma ordem (os `SizedBox(16)` somem); `Row(Expanded, Expanded)` só
de campos é DISSOLVIDO (a grade pareia); campo + botão fica UM item; não-campo no meio = item `full`; dialog com 4+ campos alargado
para **640 px** (faixa média: 3 `small` ou 2 `medium` por linha), com menos mantém a largura; `FocusTraversalOrder` preservado.

| Arquivo | Campos | Resultado |
|---|---|---|
| `settlements/…/settlement_page.dart` | 10 | 8 em grade (filtro do Movimento conta `medium` + datas `small`; baixa: juros/multa/desconto/pago `small`; lote 720 px: conta `medium`, datas `small`, total `full`); 2 fora: filtro da lista, dialog de estorno (1 campo) |
| `bank_charge_agreements/…/bank_charge_agreement_page.dart` | 11 | 11 (convênio, 7 encargos, dias de protesto, nosso número `small`; conta `medium`; rádios, "Encargos", instrução `full`) |
| `bank_accounts/…/bank_account_page.dart` | 9 | 9 (agência, conta, DVs, datas, limite `small`; banco, telefone, gerente `medium`) |
| `bank_accounts/…/bank_account_channel_section.dart` | 5 | 4 (ambiente, client_id, client_secret `medium`; PEMs e interruptor `full`); 1 fora: caminho do webhook (só leitura, sozinho) |
| `bank_slips/…/bank_slip_detail_view.dart` | 6 | 4 (linha digitável `large`, Pix `full`; Baixar: valor/data `small`); 2 fora: Cancelar e Estornar (1 campo cada) |
| `bank_slips/…/bank_slip_issue_dialog.dart` | 2 | 0 — busca da lista de títulos + vencimento numa `Row` com o resumo ao vivo |
| `bank_slips/…/bank_slip_page.dart` · `checks/…/check_page.dart` | 1 + 1 | 0 — filtro da lista |
| `checks/…/check_action_dialogs.dart` | 9 | 7 (datas e taxa `small`, lookups `medium`, observação `full`; "Descontar" 420 → 640); 2 fora: "Retorno bom" e "Estornar" (1 campo) |
| `cashier/…/cashier_page.dart` | 3 | 3 (Retirar: valor `small`, histórico `large`; Fechar: valor por forma `small`, 640 px com 3+ formas). ⚠️ Achado: a grade como filho direto do `content` esticava o dialog até o teto — causa e correção na peça (§9.5) |
| `financial_plans/…/financial_plan_page.dart` | 2 | 2 (código `small`, descrição `large`, nível `medium`; rádios/ativo `full` — bloco movido para `_buildOptions()`) |
| `settlement_rules/…/settlement_rule_page.dart` | 5 | 5 (forma, conta `medium`; taxa, prazo, validade `small`; rádio, observação `full`) |
| `orders/…/order_page.dart` | 4 | 3 (dialog do item 420 → 640: Mercadoria/Serviço `full`, produto `large`, quantidade/valor/desconto `small`; "Novo pedido" 420: cliente/vendedor `medium`); 1 fora: filtro |
| `orders/…/order_checks_dialog.dart` | 6 | 6 (dialog do cheque 460 → 640: banco `medium`, agência/conta/número/valor/data `small`, emitente `large`, tipo `full`) |
| `orders/…/order_negotiation_section.dart` | 4 | 2 (forma `medium`, prazo `small` — substituem o corte próprio em 560 px); 2 fora: linhas da tabela de parcelas |
| `order_returns/…/order_return_page.dart` | 2 | 0 — filtro da lista + dialogs de 1 campo |
| `contracts/…/contract_page.dart` | 5 | 5 (cliente, forma `medium`; datas, dia `small`; checkbox `full`; dialog do item: produto `large`, valor `small`) |
| `services/…/service_page.dart` | 5 | 4 (identificador e lookups `medium`, descrição `large`, rádios/observação `full`; IBS/CBS: lookups `medium`, CST `small`); 1 fora: preço = linha da tabela |
| `price_lists/…/price_list_page.dart` | 3 | 3 (descrição `large`, vigência/modalidade `small`, rádio `full`) |
| `payment_types/…/payment_type_page.dart` | 3 | 3 (descrição `large`, código NF-e e planos `medium`, máx. parcelas `small`, checkboxes `full`) |
| `categories/…/category_page.dart` | 2 | 2 (código `small`, descrição `large`, nível `medium`, ativo `full`) |
| `service_tax_rules/…/service_tax_rule_page.dart` | 3 | 3 (estado, cidade, trib. nacional `medium`; item LC 116 `large`; alíquota, cód. municipal `small`) |
| `tax_rules/…/icms_tab.dart` · `selector_tab.dart` · `pis_cofins_tab.dart` · `ipi_tab.dart` · `ii_tab.dart` | 4+3+2+1+1 | 11 (combos do catálogo `large`, alíquotas/reduções/NCM/produto/cliente/CFOP `small`, finalidade/estado/sentido `medium`, rádios `full`; o interruptor "definir nesta regra" fica no topo, fora da grade) |
| `cfop/…/cfop_page.dart` | 1 | 0 — tela da fábrica; o texto longo já está em linha inteira nos `extraChildren` |
| `collaborators/…/collaborator_tab.dart` | 10 | 10 (datas, salário, título/zona/seção, reservista, PIS `small`; pai/mãe `large`; checkbox `full`) |
| `customers/…/customer_tab.dart` · `customer_partnership_tab.dart` | 2 + 2 | 4 (vendedor/transportadora `medium`; crédito/multiplicador `small`; parceiro: colaborador `medium`, percentual `small`) |
| `shared/entity/…/address_list_tab.dart` | 6 | 6 (dialog 520 → 640: tipo/complemento/bairro/país/UF/cidade `medium`, logradouro `large`, número/CEP `small`, principal `full`) |
| `shared/entity/…/phone_list_tab.dart` · `social_media_list_tab.dart` · `entity_tax_tab.dart` | 3 + 2 + 1 | 6 (tipo `medium`, contato/link `large`; tributação: regime e indicador de IE `large`, exigibilidade `medium`, nº do processo `small`) |
| `establishment/…/establishment_page.dart` · `establishment_issuer_section.dart` | 7 + 2 | 9 (razão/fantasia/regime/apuração `large`, Simples/regime especial `medium`, documento/IE/IM/alíquota/CNAE `small`; emissor: senha `medium`, ambiente `medium` + série `small`) |
| `institutions/…/institution_tab.dart` | 6 | 5 (schema, nome/apelido/e-mail/senha do admin, checkbox); 1 fora: chave de sincronização (campo + botão copiar) |
| `institutions/…/institution_users_tab.dart` | 4 | 4 (dialog 460 → 640: nome/apelido `large`, e-mail/senha/perfil `medium`) |
| `institutions/…/institution_interfaces_tab.dart` · `users/…/user_privileges_section.dart` | 1 + 1 | 0 — barra de filtro da lista |
| `interfaces/…/interface_configs_section.dart` · `interface_fields/…/interface_fields_page.dart` | 4 + 2 | 6 (dialog 480 → 640: nome `medium`, descrição `large`, tipo `medium`, opções `large`, padrão; campo: rótulo `large`, máscara `small`) |
| `interface_configs/…/interface_configs_page.dart` · `shared/billing/cancel_invoice_dialog.dart` · `service_orders/…/service_order_keep_invoice_dialog.dart` | 1+1+1 | 0 — dialog de 1 campo (420/460 px): a grade não mudaria nada |
| `service_orders/…/service_order_fiscal_section.dart` | 3 | 3 (nº da NFS-e `small`, chaves de acesso `large`) |
| `service_orders/…/service_order_page.dart` (esta sessão) | 7 | 5 (item: serviço `full`, quantidade/valor/desconto `small`, 420 → 640; faturar: forma `medium`, parcelas/vencimento `small`, interruptor do lote `full`, 420 → 640); 2 fora: filtro da lista, rotina mensal (2 campos, 360 px) |
| `shared/search/advanced_search_panel.dart` · `shared/register/register_search_page.dart` | 3 + 1 | 0 — painel da pesquisa avançada e filtro da lista (não são formulário) |
| `shared/entity/widgets/entity_main_tab.dart` · `shared/register/register_form_page.dart` | 11 + 1 | já na grade desde a onda B (a fábrica desenha cada `RegisterField` na grade) |

**Total: 165 de 195 `SetesTextField` em grade; 30 fora, todas com motivo** (8 filtros de lista, 10 dialogs de um campo, 8 linhas de
tabela/`Row` com botão/busca de lookup, 4 do painel de pesquisa e filtro da fábrica). Decisões de tamanho fora da tabela do D-DL3,
tomadas pelos agentes e registradas: combos de catálogo fiscal (CST/CSOSN/modalidade/desoneração/regime) em `large` porque o rótulo é
"código - descrição" longo; chaves de acesso de 50 dígitos e linha digitável em `large`; client_id/secret e convênio como chave
(`medium`/`small`); espaçamento de 8/12 px entre campos virou os 16 da grade; títulos de seção com 16/16.

### 9.4 Verificação

- `flutter analyze`: limpo em `apps/web`, `packages/setes_widgets`, `packages/core`.
- Suítes: setes_widgets **27/27** (10 da peça + 6 adversariais + 5 da grade, com a prova nova do dialog) · core **80/80** ·
  app web (com `SETES_API_DIR=D:/Gestao2027/setes-api`) **639/639** (27 pulados de antes). A ÚNICA falha da 1ª rodada era a
  cerca de código do gate `adversarial_r12_gate_test.dart` (R12-ADV-06/D-F187), que procurava na fonte da página de OS o literal
  `CircleAvatar(child: SetesText('${order.number ?? order.id}'))`; a invariante (a lista identifica a OS pelo número que o
  operador vê) continua — agora pelo `codeOf: (order) => '${order.number ?? order.id}'` da peça — e a cerca foi atualizada para
  esse literal (comentário no teste).
- Testes de widget que os agentes rodaram sobre os arquivos convertidos: `order_negotiation_section_test` 15/15 ·
  `establishment_issuer_section_test` 10/10 · `service_order_fiscal_section_test` 16/16 · `service_order_keep_invoice_dialog_test` 3/3.

### 9.5 Gates (skills `revisar-riscos-sistemicos.md` + `testar-adversarial.md`, adaptadas ao app)

**Socrático — score 0,76 ✅** (alvo: `SetesDataList`, `RegisterSearchPage`, lista de OS, 27 `columns`, ~50 arquivos com a grade).
Pontos abertos (viraram as questões do §9.7): (1) com 5–7 colunas entre 840 e ~1000 px o texto é cortado com reticências e o usuário
não vê o resto sem abrir o registro — e se o cliente tiver razões sociais compridas? (→ Q-DL9); (2) o corte dos 840 px é medido na
ÁREA DA LISTA: no notebook em 125 % (1093 px) com a 2ª coluna do menu aberta sobram 621 px e a lista fica em item — a tabela só
aparece com a coluna recolhida (893 → 861 px de área): é o que o Valdo quer? (→ Q-DL8); (3) célula com prefixo ("Mensalidade: R$ …",
"Conta: …") sob um cabeçalho com o mesmo nome fica redundante na tabela — a lista de OS ganhou `subtitleOf` para separar as duas
formas, as da fábrica não (→ Q-DL10); (4) os agentes alargaram 9 dialogs de 420–520 para 640 px e trocaram respiros de 8/12 por 16 —
"sem mudar comportamento" vale para a lógica, mas é mudança visual a ratificar (→ A-DL1/Q-DL11); (5) a grade sob `IntrinsicWidth`
(`AlertDialog` sem `SizedBox(width)`) quebra em tempo de execução — como a próxima tela não cai nisso? → conhecimento negativo na
peça e nas skills (abaixo); (6) a peça exige altura limitada como o `ListView` — mesmo limite de antes, documentado.
Dica arquitetural: a forma da lista é da PEÇA e o tipo da célula é da TELA — nunca pixels nem `MediaQuery` em tela nenhuma.

**Adversarial — score 0,80 ✅, sem HIGH/CRITICAL depois das correções.** Achados:
- **MEDIUM (provado e CORRIGIDO)**: selo fiscal longo na última coluna quebrava em DUAS linhas e estourava os 36 px da linha —
  a célula do fim agora impõe `maxLines: 1` + reticências pelo `DefaultTextStyle` (teste "840 px, 7 colunas … selo LARGO").
- **MEDIUM (achado do agente A no caixa, provado e CORRIGIDO na peça)**: a `SetesFormGrid` como filho direto do `content` de um
  `AlertDialog` ocupava TODA a altura disponível (o `Align` esticava: dialog até o teto da tela, 712 px na prova) → `heightFactor: 1`
  no `Align` da grade; teste "num dialog (altura limitada) a grade tem só a altura das linhas" — conferido que FALHA sem a correção
  (grade de 712 px) e passa com ela.
- **Analisado (sem achado)**: `LayoutBuilder` da grade sob o `IntrinsicWidth` do `AlertDialog` — os 25 `content:` com grade estão
  todos sob `SizedBox(width: N)` (a largura fixa responde à pergunta intrínseca antes de chegar à grade); conhecimento negativo
  escrito na peça (`setes_form_grid.dart`) e nas skills.
- **Provado sem achado**: 10 colunas sem rótulo a 840 px com textos compridos (reticências, sem exceção); lista vazia com e sem
  colunas; 320 px com código + caixa + selo; largura infinita (rolagem horizontal) cai no item e o próprio `ListView` acusa — limite
  conhecido; seleção do lote sobrevive a 1366 → 375 → 1366; i18n: 0 chave faltando em pt e en; merge de 3 vias simulado contra
  `privilegios-crud`/`cnpj`/`taxrules-ncm`: 0 conflitos.
- **Limite conhecido (LOW)**: o item do celular com texto comprido no subtítulo cresce sem teto (era assim); no celular um dialog de
  640 px é limitado pelo próprio `AlertDialog` e a grade cai para um campo por linha.
- Casos não testados: tema escuro/alto contraste do cabeçalho; teclado no celular com a grade dentro de dialog rolável (os dialogs
  mantêm o `SingleChildScrollView` que já tinham); passeio logado com dados reais (§9.6).

### 9.6 Passeio antes × depois — PENDENTE (para a publicação)

No dia da execução o setes-api :3000 e o app :5051 estavam fora do ar; o passeio visual ficou para a publicação. Roteiro: subir o
setes-api; na worktree `apps/web`: `.env` com `WEB_PORT=5000` (porta livre no CORS da nfse-api) e `flutter run -d chrome --web-port
5000`; o Valdo entra (o agente nunca digita senha); conferir Clientes, Cidades e OS a 1366×768 (tabela: cabeçalho, 36 px por linha,
quantas linhas cabem × as 9 de antes), a 1093×540 com a 2ª coluna do menu aberta (item) e recolhida (tabela), e a 375×812 (item);
abrir um cliente (abas Cliente/Endereço/Fone/Tributação na grade), uma OS (dialogs do item e do faturamento a 640 px) e uma conta
bancária; capturas em `D:\Gestao2027\densidade-c\comparativo\` (fora do repositório), como no §4.

### 9.7 Questões para o Valdo (numeração da frente: Q-DL8…)

- **Q-DL8 — corte da tabela**: (a) manter 840 px de ÁREA da lista (= D-DL7; no notebook em 125 % a tabela aparece com a 2ª coluna do
  menu recolhida) ou (b) baixar para 600 px (faixa média do M3 — a tabela já a 1093 px com o menu inteiro aberto, mas as listas de 5–7
  colunas ficam apertadas). **Rec.: (a)** — é a regra decidida para o shell e a grade; mudar é trocar UMA constante
  (`SetesDataList.tableMinWidth`).
- **Q-DL9 — texto cortado na tabela**: (a) aceitar as reticências (o detalhe está a um clique) ou (b) `Tooltip` com o texto inteiro ao
  passar o mouse em toda célula. **Rec.: (a)** por ora; (b) é mudança só na peça se incomodar no passeio.
- **Q-DL10 — célula com prefixo sob o cabeçalho** ("Mensalidade: R$ 1,00" na coluna "Mensalidade"): (a) deixar e limpar lista a lista
  quando cada tela for tocada, (b) dar `subtitleOf` à fábrica (como na OS) e separar as duas formas nas 27 listas agora. **Rec.: (a)**.
- **Q-DL11 / A-DL1 — dialogs alargados para 640 px** (9 dialogs com 4+ campos: endereço, usuário do estabelecimento, config do
  catálogo, item do pedido, cheque, descontar na factoring, fechar caixa, item e faturamento da OS) e respiro 8/12 → 16: ratificar como
  regra ("dialog com 4+ campos = 640 px, a faixa média da grade") ou voltar às larguras antigas (a grade então não pareia nada).
  **Rec.: ratificar (A-DL1).**

Conhecimento negativo desta onda (também na peça e nas skills): a `SetesFormGrid` precisa de `SizedBox(width)` acima dela dentro de
`AlertDialog` (o `LayoutBuilder` não responde largura intrínseca) e o `Align` sem `heightFactor` ocupa a altura toda quando ela é
limitada; `git merge-file` com `git show` dá conflito em TODA linha se o arquivo da árvore está em CRLF — normalizar antes
(`tr -d '\r'`); no `flutter test`, `tester.getSize(find.byType(AlertDialog))` mede o `Align` de tela inteira, não a superfície — medir
o `Material` ancestral do conteúdo.
