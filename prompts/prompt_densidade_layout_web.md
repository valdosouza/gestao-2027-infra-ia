# Densidade e layout das telas do setes-app web

**Status**: Ondas A (densidade no tema) e B (grade nos formulários) EXECUTADAS em WORKTREE em 2026-10-17, com passeio antes × depois feito (§4) —
`D:\Gestao2027\densidade\setes-app` (branch `densidade`, commit LOCAL 071b710 — sem push, sem merge). **Onda D (shell)
EXECUTADA em WORKTREE em 2026-10-18 (§7)** — `D:\Gestao2027\shell\setes-app` (branch `shell`, saiu do `main`): os dois bugs do
shell (formulário destruído ao cruzar o breakpoint; ☰ coberto no celular) CORRIGIDOS e provados em teste; D-DL6/D-DL7 decididas
pelo Valdo; o mesmo defeito no LOGIN também corrigido no branch (§7.1). 🎉 **PUBLICADO na produção em 2026-10-18 (§8)**: `main`
do setes-app = a450909 (merge da `densidade` no `shell`, fast-forward na árvore viva) e app reiniciado na :5051; push ao GitHub feito (2f621c1..a450909).
Pendem a onda C (lista em tabela) e a grade no resto do app (§5).
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
3. **Onda C — lista em tabela no desktop**: o `rowBuilder` da `RegisterSearchPage` já devolve as células em
   lista; no desktop elas viram colunas (~36 px por linha), e no celular continua o item atual.
4. ~~**Onda D — estrutura da tela**~~ — **EXECUTADA (§7)**: breakpoint pela área útil (840 px, D-DL7), 2ª coluna recolhível,
   uma barra só no desktop (D-DL6).
5. **Grade no resto do app**: telas de processo (OS, pedido, baixas, boletos, contas, contratos…), abas de papel
   (Cliente, Colaborador, Tributação) e dialogs (endereço, fone). São ~195 `SetesTextField` em ~60 arquivos; a
   fábrica e a aba principal cobrem 16 telas.
6. ~~**Publicação**~~ — **EXECUTADA em 2026-10-18 (§8)** (Valdo: "vai"): `main` = a450909, app reiniciado na :5051 e push
   ao GitHub feito.
7. ~~**Mesmo defeito no LOGIN**~~ — **CORRIGIDO em 2026-10-18 no mesmo branch `shell` (§7.1)** (Valdo: "faça esta tarefa
   aqui"): `ContentLogin` único; o `Responsive` ficou sem consumidor.
8. **Passeio logado da onda D (o "depois")** — o Valdo pediu para pular em 2026-10-18; o "antes" da produção está no §7.
   Roteiro no §7.

## 6. ⏯ Retomada

"Retome a frente de densidade do setes-app pelo §5 de `Infra-IA/prompts/prompt_densidade_layout_web.md`: as ondas A, B e D
estão no `main` (a450909, publicado na :5051 em 2026-10-18 — §8); a onda C e a grade no resto do app saem de uma worktree NOVA
a partir do `main` (as worktrees `densidade` e `shell` já foram integradas). Portas livres do CORS da nfse-api: 5000 e 8080."

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
