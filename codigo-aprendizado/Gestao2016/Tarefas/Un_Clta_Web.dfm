object Fr_Clta_Web: TFr_Clta_Web
  Left = 307
  Top = 53
  BorderStyle = bsSingle
  Caption = 'Consultas de Transa'#231#245'es na Internet'
  ClientHeight = 568
  ClientWidth = 990
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_ConsultaWeb: TPageControl
    Left = 0
    Top = 0
    Width = 990
    Height = 568
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object tbs_Pergunta_Produto: TTabSheet
      Caption = 'Perguntas de Produtos'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 982
        Height = 540
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          982
          540)
        object Label3: TLabel
          Left = 3
          Top = 242
          Width = 489
          Height = 24
          Alignment = taCenter
          Anchors = [akLeft, akBottom]
          AutoSize = False
          Caption = 'PERGUNTA DO COMPRADOR'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object Label4: TLabel
          Left = 492
          Top = 242
          Width = 488
          Height = 24
          Alignment = taCenter
          Anchors = [akLeft, akRight, akBottom]
          AutoSize = False
          Caption = 'RESPOSTA DO VENDEDOR'
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object GroupBox1: TGroupBox
          Left = 2
          Top = 2
          Width = 978
          Height = 65
          Align = alTop
          Caption = ' Digite sua op'#231#227'o de busca '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 173
            Top = 21
            Width = 104
            Height = 14
            Caption = 'Descri'#231#227'o do Produto'
          end
          object Label2: TLabel
            Left = 596
            Top = 21
            Width = 77
            Height = 14
            Caption = 'Nome do Cliente'
          end
          object E_BuscaProduto: TEdit
            Left = 168
            Top = 37
            Width = 420
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 3
          end
          object E_Data_Ini_0: TDateTimePicker
            Left = 4
            Top = 37
            Width = 79
            Height = 22
            Date = 39580.000000000000000000
            Time = 39580.000000000000000000
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object E_Data_Fim_0: TDateTimePicker
            Left = 84
            Top = 37
            Width = 82
            Height = 22
            Date = 39580.999988425930000000
            Time = 39580.999988425930000000
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object ChBx_Periodo_0: TCheckBox
            Left = 6
            Top = 21
            Width = 128
            Height = 13
            Caption = 'Data Inicial    Data Final'
            TabOrder = 0
            OnClick = ChBx_Periodo_0Click
          end
          object E_buscaCliente_0: TEdit
            Left = 591
            Top = 37
            Width = 385
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 4
          end
        end
        object DBG_Pesq_Questionario: TDBGrid
          Left = 2
          Top = 67
          Width = 978
          Height = 174
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          DataSource = Ds_Pesq_Questionario
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
          ParentFont = False
          PopupMenu = Pmu_Opcao
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = DBG_Pesq_QuestionarioDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'PPR_DATA_PERGUNTA'
              Title.Caption = 'Data Pergunta'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_CODIGOFAB'
              Title.Caption = 'C'#243'digo Produto'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 127
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o do produto'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 601
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PPR_NOME'
              Title.Caption = 'Nome do Cliente'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 332
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PPR_EMAIL'
              Title.Caption = 'Email do Cliente'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 371
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PPR_DATA_RESPOSTA'
              Title.Caption = 'Data da Resposta'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Visible = True
            end>
        end
        object E_Pergunta: TDBMemo
          Left = 3
          Top = 266
          Width = 488
          Height = 189
          Anchors = [akLeft, akBottom]
          DataField = 'PPR_PERGUNTA'
          DataSource = Ds_Pesq_Questionario
          TabOrder = 3
        end
        object E_Resposta: TDBMemo
          Left = 492
          Top = 266
          Width = 488
          Height = 189
          Anchors = [akLeft, akRight, akBottom]
          DataField = 'PPR_RESPOSTA'
          DataSource = Ds_Pergunta_Produto
          TabOrder = 2
        end
        object Panel2: TPanel
          Left = 2
          Top = 473
          Width = 978
          Height = 65
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 4
          DesignSize = (
            978
            65)
          object Sb_Despublicar: TSpeedButton
            Left = 703
            Top = 7
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Despublicar - F9'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = Sb_DespublicarClick
          end
          object SB_Alterar_Pergunta: TSpeedButton
            Left = 163
            Top = 6
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_Alterar_PerguntaClick
          end
          object SB_Excluir_Pergunta: TSpeedButton
            Left = 253
            Top = 6
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_Excluir_PerguntaClick
          end
          object SB_Gravar_Pergunta: TSpeedButton
            Left = 343
            Top = 6
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Gravar - F5'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_Gravar_PerguntaClick
          end
          object SB_Cancelar_Pergunta: TSpeedButton
            Left = 433
            Top = 6
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Cancelar - F6'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_Cancelar_PerguntaClick
          end
          object SB_buscar_Pergunta: TSpeedButton
            Left = 524
            Top = 6
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Pesquisar - F7'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_buscar_PerguntaClick
          end
          object Sb_Sair_0: TSpeedButton
            Left = 884
            Top = 7
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Sair- Esc'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = Sb_Sair_0Click
          end
          object Sb_Publicar: TSpeedButton
            Left = 614
            Top = 7
            Width = 90
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Publicar - F8'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = Sb_PublicarClick
          end
          object Label5: TLabel
            Left = 23
            Top = 43
            Width = 118
            Height = 13
            Caption = 'Pergunta Não publicada'
          end
          object Lb_Legenda_Publicada: TLabel
            Left = 5
            Top = 43
            Width = 17
            Height = 13
            AutoSize = False
            Color = clRed
            ParentColor = False
          end
          object Sb_Ver_Produtos: TSpeedButton
            Left = 793
            Top = 6
            Width = 90
            Height = 54
            Hint = 'Cadastro de Produtos'
            Caption = 'Ver Produto - F10'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = Sb_Ver_ProdutosClick
          end
        end
      end
    end
    object tbs_PedidoInternet: TTabSheet
      Caption = 'Pedidos do Com'#233'rcio Eletr'#244'nico'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 982
        Height = 540
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Pg_Pedidos: TPageControl
          Left = 2
          Top = 2
          Width = 978
          Height = 536
          ActivePage = TabSheet5
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = Pg_PedidosChange
          object TabSheet3: TTabSheet
            Caption = 'Pedidos'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Panel4: TGroupBox
              Left = 0
              Top = 435
              Width = 970
              Height = 70
              Align = alBottom
              TabOrder = 0
              DesignSize = (
                970
                70)
              object Sb_Sair_1_0: TSpeedButton
                Left = 874
                Top = 12
                Width = 90
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Sair- Esc'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                OnClick = Sb_Sair_1_0Click
              end
              object SB_buscar_Pedido: TSpeedButton
                Left = 784
                Top = 11
                Width = 90
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Pesquisar - F7'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                OnClick = SB_buscar_PedidoClick
              end
              object SB_Faturar: TSpeedButton
                Left = 513
                Top = 11
                Width = 90
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Faturar - F3'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                Transparent = False
                OnClick = SB_FaturarClick
              end
              object Sb_Ver_Nota_Fiscal: TSpeedButton
                Left = 603
                Top = 11
                Width = 90
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Nota Fiscal - F4'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                Transparent = False
                OnClick = Sb_Ver_Nota_FiscalClick
              end
              object Sb_Ver_Cliente: TSpeedButton
                Left = 423
                Top = 11
                Width = 90
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Cliente - F2'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                Transparent = False
                OnClick = Sb_Ver_ClienteClick
              end
              object Sb_Excluir_Pedido: TSpeedButton
                Left = 693
                Top = 11
                Width = 90
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Excluir - F5'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                OnClick = Sb_Excluir_PedidoClick
              end
            end
            object Panel6: TPanel
              Left = 0
              Top = 65
              Width = 970
              Height = 327
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 1
              object Dbg_Pedidos: TDBGrid
                Left = 2
                Top = 2
                Width = 966
                Height = 323
                Align = alClient
                DataSource = Ds_Pesq_Pedidos
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                ParentFont = False
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -13
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                OnDrawColumnCell = Dbg_PedidosDrawColumnCell
                OnTitleClick = Dbg_PedidosTitleClick
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'PGE_CD_STATUS'
                    Title.Caption = 'Situa'#231#227'o'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PED_NUMERO'
                    Title.Caption = 'Pedido'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'NFL_NUMERO'
                    Title.Caption = 'Nota Fiscal'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'EMP_NOME'
                    Title.Caption = 'Nome do cliente'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 277
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'PED_DATA'
                    Title.Caption = 'Data'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 66
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'PGE_TRANSACAO'
                    Title.Caption = 'Transa'#231#227'o'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 103
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PED_VL_PEDIDO'
                    Title.Caption = 'Valor Pedido'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 87
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_VL_LOJA'
                    Title.Caption = 'Valor Loja'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 70
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_VL_TOTAL'
                    Title.Caption = 'Valor Total'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 100
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_VL_DESCONTO'
                    Title.Caption = 'Valor Desconto'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_VL_ACRESCIMO'
                    Title.Caption = 'Valor Acr'#233'scimo'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_FRM_PAGTO'
                    Title.Caption = 'Forma Pagamento'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 222
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_PARCELAS'
                    Title.Caption = 'Parcelas'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_STATUS'
                    Title.Caption = 'Status'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 371
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_VL_FRETE'
                    Title.Caption = 'Valor Frete'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_TIPO_FRETE'
                    Title.Caption = 'Tipo do Cr'#233'dito'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Width = 117
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PGE_DT_CREDITO'
                    Title.Caption = 'Data Cr'#233'dito'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = []
                    Visible = True
                  end>
              end
            end
            object GroupBox3: TGroupBox
              Left = 0
              Top = 392
              Width = 970
              Height = 43
              Align = alBottom
              Caption = 'Situa'#231#227'o das Transa'#231#245'es - Clique nos bot'#245'es para filtrar'
              TabOrder = 2
              object Im_NaoRegistrada: TImage
                Left = 7
                Top = 19
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  07544269746D617036040000424D360400000000000036000000280000001000
                  0000100000000100200000000000000400000000000000000000000000000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
                  FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000FF000000
                  FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF007F7F7F000000FF000000FF0000000000FF00FF000000FF000000
                  FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF007F7F7F000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
                  FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
                  FF000000FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF000000FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF000000FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF007F7F7F000000FF0000000000FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF007F7F7F000000FF0000000000FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00}
                Transparent = True
                OnClick = Im_NaoRegistradaClick
              end
              object Im_EmAndamento: TImage
                Left = 128
                Top = 19
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  07544269746D617036040000424D360400000000000036000000280000001000
                  0000100000000100200000000000000400000000000000000000000000000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
                  00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000000000000000BFBFBF00BFBFBF007F7F
                  7F007F7F7F007F7F7F000000000000000000FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF0000000000BFBFBF00BFBFBF007F7F7F00000000000000
                  0000000000007F7F7F007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00
                  FF00FF00FF0000000000BFBFBF00BFBFBF0000000000FFFFFF0000FFFF00FFFF
                  FF0000FFFF00FFFFFF00000000007F7F7F007F7F7F0000000000FF00FF00FF00
                  FF00FF00FF0000000000BFBFBF0000000000FFFFFF0000000000000000000000
                  00000000000000000000FFFFFF00000000007F7F7F0000000000FF00FF00FF00
                  FF0000000000BFBFBF007F7F7F00FFFFFF00000000000000000000FFFF000080
                  8000008080000000000000000000FFFFFF007F7F7F007F7F7F0000000000FF00
                  FF0000000000BFBFBF000000000000FFFF000000000000FFFF000080800000FF
                  FF0000808000008080000000000000FFFF00000000007F7F7F0000000000FF00
                  FF0000000000FFFFFF0000000000FFFFFF000000000000FFFF0000FFFF0000FF
                  FF0000FFFF000080800000000000FFFFFF00000000007F7F7F0000000000FF00
                  FF0000000000FFFFFF000000000000FFFF0000000000FFFFFF0000FFFF0000FF
                  FF000080800000FFFF000000000000FFFF0000000000BFBFBF0000000000FF00
                  FF0000000000FFFFFF007F7F7F00FFFFFF000000000000000000FFFFFF00FFFF
                  FF0000FFFF000000000000000000FFFFFF007F7F7F00BFBFBF0000000000FF00
                  FF00FF00FF0000000000BFBFBF0000000000FFFFFF0000000000000000000000
                  00000000000000000000FFFFFF0000000000BFBFBF0000000000FF00FF00FF00
                  FF00FF00FF0000000000FFFFFF00BFBFBF0000000000FFFFFF0000FFFF00FFFF
                  FF0000FFFF00FFFFFF0000000000BFBFBF00BFBFBF0000000000FF00FF00FF00
                  FF00FF00FF00FF00FF0000000000FFFFFF00BFBFBF007F7F7F00000000000000
                  0000000000007F7F7F00BFBFBF00BFBFBF0000000000FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FFFFFF00FFFF
                  FF00BFBFBF00BFBFBF000000000000000000FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
                  00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00}
                Transparent = True
                OnClick = Im_EmAndamentoClick
              end
              object Im_Autorizada: TImage
                Left = 251
                Top = 19
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  07544269746D617036040000424D360400000000000036000000280000001000
                  0000100000000100200000000000000400000000000000000000000000000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
                  00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000000000000000BFBFBF00BFBFBF007F7F
                  7F007F7F7F007F7F7F000000000000000000FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF0000000000BFBFBF00BFBFBF007F7F7F00000000000000
                  0000000000007F7F7F007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00
                  FF00FF00FF0000000000BFBFBF00BFBFBF0000000000FFFFFF0000FF0000FFFF
                  FF0000FF0000FFFFFF00000000007F7F7F007F7F7F0000000000FF00FF00FF00
                  FF00FF00FF0000000000BFBFBF0000000000FFFFFF0000000000000000000000
                  00000000000000000000FFFFFF00000000007F7F7F0000000000FF00FF00FF00
                  FF0000000000BFBFBF007F7F7F00FFFFFF00000000000000000000FF00000080
                  0000008000000000000000000000FFFFFF007F7F7F007F7F7F0000000000FF00
                  FF0000000000BFBFBF000000000000FF00000000000000FF00000080000000FF
                  000000800000008000000000000000FF0000000000007F7F7F0000000000FF00
                  FF0000000000FFFFFF0000000000FFFFFF000000000000FF000000FF000000FF
                  000000FF00000080000000000000FFFFFF00000000007F7F7F0000000000FF00
                  FF0000000000FFFFFF000000000000FF000000000000FFFFFF0000FF000000FF
                  00000080000000FF00000000000000FF000000000000BFBFBF0000000000FF00
                  FF0000000000FFFFFF007F7F7F00FFFFFF000000000000000000FFFFFF00FFFF
                  FF0000FF00000000000000000000FFFFFF007F7F7F00BFBFBF0000000000FF00
                  FF00FF00FF0000000000BFBFBF0000000000FFFFFF0000000000000000000000
                  00000000000000000000FFFFFF0000000000BFBFBF0000000000FF00FF00FF00
                  FF00FF00FF0000000000FFFFFF00BFBFBF0000000000FFFFFF0000FF0000FFFF
                  FF0000FF0000FFFFFF0000000000BFBFBF00BFBFBF0000000000FF00FF00FF00
                  FF00FF00FF00FF00FF0000000000FFFFFF00BFBFBF007F7F7F00000000000000
                  0000000000007F7F7F00BFBFBF00BFBFBF0000000000FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FFFFFF00FFFF
                  FF00BFBFBF00BFBFBF000000000000000000FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
                  00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00}
                Transparent = True
                OnClick = Im_AutorizadaClick
              end
              object Label7: TLabel
                Left = 28
                Top = 19
                Width = 90
                Height = 16
                Caption = 'N'#227'o registrada'
              end
              object Label8: TLabel
                Left = 149
                Top = 19
                Width = 91
                Height = 16
                Caption = 'Em andamento'
              end
              object Label9: TLabel
                Left = 272
                Top = 19
                Width = 64
                Height = 16
                Caption = 'Autorizada'
              end
              object Label11: TLabel
                Left = 371
                Top = 19
                Width = 88
                Height = 16
                Caption = 'N'#227'o aprovada'
              end
              object Label12: TLabel
                Left = 494
                Top = 19
                Width = 66
                Height = 16
                Caption = 'Cancelada'
              end
              object Im_Cancelada: TImage
                Left = 473
                Top = 19
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  07544269746D617036040000424D360400000000000036000000280000001000
                  0000100000000100200000000000000400000000000000000000000000000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
                  FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
                  FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF007F7F7F000000
                  00007F7F7F00FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00
                  FF00FF00FF000000FF000000FF000000FF000000FF00FF00FF00000000000000
                  000000000000FF00FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00
                  FF00FF00FF000000FF00FF00FF000000FF000000FF000000FF007F7F7F000000
                  00007F7F7F00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00
                  FF000000FF000000FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00
                  FF000000FF000000FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00
                  FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F7F000000
                  00007F7F7F00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00
                  FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00000080000000
                  0000000080000000FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00
                  FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
                  0000000000000000FF000000FF00FF00FF00FF00FF000000FF000000FF00FF00
                  FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00000000000000
                  0000000000000000FF000000FF000000FF00FF00FF000000FF00FF00FF00FF00
                  FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00000000000000
                  000000000000FF00FF000000FF000000FF000000FF000000FF00FF00FF00FF00
                  FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF007F7F7F000000
                  00007F7F7F00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
                  FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
                  FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00}
                Transparent = True
                OnClick = Im_CanceladaClick
              end
              object Im_NaoAprovada: TImage
                Left = 350
                Top = 19
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  07544269746D617036040000424D360400000000000036000000280000001000
                  0000100000000100200000000000000400000000000000000000000000000000
                  0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
                  00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000000000000000BFBFBF00BFBFBF007F7F
                  7F007F7F7F007F7F7F000000000000000000FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF0000000000BFBFBF00BFBFBF007F7F7F00000000000000
                  0000000000007F7F7F007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00
                  FF00FF00FF0000000000BFBFBF00BFBFBF0000000000FFFFFF000000FF00FFFF
                  FF000000FF00FFFFFF00000000007F7F7F007F7F7F0000000000FF00FF00FF00
                  FF00FF00FF0000000000BFBFBF0000000000FFFFFF0000000000000000000000
                  00000000000000000000FFFFFF00000000007F7F7F0000000000FF00FF00FF00
                  FF0000000000BFBFBF007F7F7F00FFFFFF0000000000000000000000FF000000
                  8000000080000000000000000000FFFFFF007F7F7F007F7F7F0000000000FF00
                  FF0000000000BFBFBF00000000000000FF00000000000000FF00000080000000
                  FF000000800000008000000000000000FF00000000007F7F7F0000000000FF00
                  FF0000000000FFFFFF0000000000FFFFFF00000000000000FF000000FF000000
                  FF000000FF000000800000000000FFFFFF00000000007F7F7F0000000000FF00
                  FF0000000000FFFFFF00000000000000FF0000000000FFFFFF000000FF000000
                  FF00000080000000FF00000000000000FF0000000000BFBFBF0000000000FF00
                  FF0000000000FFFFFF007F7F7F00FFFFFF000000000000000000FFFFFF00FFFF
                  FF000000FF000000000000000000FFFFFF007F7F7F00BFBFBF0000000000FF00
                  FF00FF00FF0000000000BFBFBF0000000000FFFFFF0000000000000000000000
                  00000000000000000000FFFFFF0000000000BFBFBF0000000000FF00FF00FF00
                  FF00FF00FF0000000000FFFFFF00BFBFBF0000000000FFFFFF000000FF00FFFF
                  FF000000FF00FFFFFF0000000000BFBFBF00BFBFBF0000000000FF00FF00FF00
                  FF00FF00FF00FF00FF0000000000FFFFFF00BFBFBF007F7F7F00000000000000
                  0000000000007F7F7F00BFBFBF00BFBFBF0000000000FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FFFFFF00FFFF
                  FF00BFBFBF00BFBFBF000000000000000000FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
                  00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00}
                Transparent = True
                OnClick = Im_NaoAprovadaClick
              end
              object Im_Faturada: TImage
                Left = 572
                Top = 19
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  07544269746D617036030000424D360300000000000036000000280000001000
                  0000100000000100180000000000000300000000000000000000000000000000
                  0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00000000FF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF
                  0000FF0000FF00000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FFFF00FF00FF0000FF0000FF00000000FF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF0000FF
                  0000FF0000FF0000FF00000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                  00FFFF00FFFF00FF00FF0000FF0000FF0000FF0000FF0000FF00000000FF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7F7F00FF0000FF000000
                  00FF00FF00FF0000FF0000FF00000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
                  00FF7F7F7F00FF00000000FF00FFFF00FFFF00FFFF00FF00FF0000FF00000000
                  FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FF00FF0000FF0000FF00000000FF00FFFF00FFFF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF0000FF00
                  000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FF00FF0000FF00000000FF00FFFF00FFFF00FFFF
                  00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  7F7F7F00FF00000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7F7F00FF00000000FF00FFFF
                  00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FF00FF0000FF00000000FF00FFFF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                  00FF}
                Transparent = True
                OnClick = Im_FaturadaClick
              end
              object Label13: TLabel
                Left = 593
                Top = 19
                Width = 54
                Height = 16
                Caption = 'Faturada'
              end
            end
            object Grp_Pesquisa: TGroupBox
              Left = 0
              Top = 0
              Width = 970
              Height = 65
              Align = alTop
              Caption = ' Digite sua op'#231#227'o de busca '
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              object Label10: TLabel
                Left = 330
                Top = 16
                Width = 93
                Height = 14
                Caption = 'Nome/Raz'#227'o Social'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label36: TLabel
                Left = 167
                Top = 15
                Width = 60
                Height = 13
                AutoSize = False
                Caption = 'Pedido'
                FocusControl = E_BuscaPedido
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label15: TLabel
                Left = 249
                Top = 15
                Width = 60
                Height = 13
                AutoSize = False
                Caption = 'Nota Fiscal'
                FocusControl = E_BuscaNota
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object E_Data_Ini_1: TDateTimePicker
                Left = 7
                Top = 31
                Width = 77
                Height = 22
                Date = 39580.356281493060000000
                Time = 39580.356281493060000000
                Enabled = False
                TabOrder = 0
              end
              object E_Data_Fim_1: TDateTimePicker
                Left = 84
                Top = 31
                Width = 80
                Height = 22
                Date = 39580.356281493060000000
                Time = 39580.356281493060000000
                Enabled = False
                TabOrder = 1
              end
              object ChBx_Periodo_1: TCheckBox
                Left = 8
                Top = 16
                Width = 128
                Height = 12
                Caption = 'Data Inicial   Data Final'
                TabOrder = 5
                OnClick = ChBx_Periodo_1Click
              end
              object E_BuscaPedido: TEdit
                Left = 165
                Top = 31
                Width = 79
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
              end
              object E_buscaCliente_1: TComboBox
                Left = 329
                Top = 31
                Width = 451
                Height = 22
                Style = csSimple
                CharCase = ecUpperCase
                TabOrder = 4
              end
              object E_BuscaNota: TEdit
                Left = 247
                Top = 31
                Width = 79
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
              end
            end
          end
          object TabSheet4: TTabSheet
            Caption = 'Itens do Pedido'
            ImageIndex = 1
            object Lb_DetalhesPedido: TLabel
              Left = 0
              Top = 0
              Width = 970
              Height = 20
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              BiDiMode = bdLeftToRight
              Caption = 'DETALHES DO PEDIDOS'
              Color = clNavy
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentColor = False
              ParentFont = False
              Transparent = False
            end
            object DBG_Produtos: TDBGrid
              Left = 0
              Top = 20
              Width = 970
              Height = 423
              Align = alClient
              Color = clMoneyGreen
              DataSource = Ds_ItensVda
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clNavy
              TitleFont.Height = -11
              TitleFont.Name = 'Arial'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'PRO_CODIGOFAB'
                  Title.Caption = 'Codigo F'#225'brica'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRO_DESCRICAO'
                  Title.Caption = 'Descri'#231#227'o Produto'
                  Width = 281
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'MED_ABREVIATURA'
                  Title.Caption = 'Unidade'
                  Width = 47
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'ITF_QTDE'
                  Title.Alignment = taCenter
                  Title.Caption = 'Qtde'
                  Width = 52
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ITF_VL_UNIT'
                  Title.Caption = 'Valor Unit'#225'rio'
                  Width = 69
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ITF_VL_DESC'
                  Title.Alignment = taCenter
                  Title.Caption = 'Desconto'
                  Width = 85
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ITF_VL_SUBTOTAL'
                  Title.Caption = 'SubTotal'
                  Width = 76
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ITF_VL_TOTAL'
                  Title.Caption = 'Total'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ITF_AQ_COM'
                  Title.Caption = 'Aliq Com'
                  Width = 49
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ITF_VL_IPI'
                  Title.Caption = 'Valor IPI'
                  Visible = True
                end>
            end
            object Pnl_Separacao: TPanel
              Left = 0
              Top = 443
              Width = 970
              Height = 62
              Align = alBottom
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 1
              DesignSize = (
                970
                62)
              object Sb_Separacao: TSpeedButton
                Left = 878
                Top = 4
                Width = 86
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Separa'#231#227'o'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                OnClick = Sb_SeparacaoClick
              end
            end
          end
          object TabSheet5: TTabSheet
            Caption = 'Etiqueta de Endere'#231'amento'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Panel7: TPanel
              Left = 0
              Top = 0
              Width = 970
              Height = 505
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              DesignSize = (
                970
                505)
              object Label14: TLabel
                Left = 6
                Top = 7
                Width = 143
                Height = 13
                Caption = 'Tipo da Etiqueta a ser utilzada'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object SB_Etiqueta: TSpeedButton
                Left = 415
                Top = 21
                Width = 23
                Height = 22
                Caption = '...'
                OnClick = SB_EtiquetaClick
              end
              object Sb_Transportadora: TSpeedButton
                Left = 417
                Top = 96
                Width = 25
                Height = 22
                Caption = '...'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                OnClick = Sb_TransportadoraClick
              end
              object SB_Imprimir_Etiqueta: TSpeedButton
                Left = 813
                Top = 446
                Width = 75
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Imprimir - F11'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                OnClick = SB_Imprimir_EtiquetaClick
              end
              object Sb_Sair_1_2: TSpeedButton
                Left = 888
                Top = 446
                Width = 75
                Height = 54
                Anchors = [akRight, akBottom]
                Caption = 'Sair - ESC'
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Layout = blGlyphTop
                ParentFont = False
                OnClick = Sb_Sair_0Click
              end
              object DBLCB_Etiqueta: TDBLookupComboBox
                Left = 6
                Top = 22
                Width = 406
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                KeyField = 'CGE_CODIGO'
                ListField = 'CGE_DESCRICAO'
                ListSource = Ds_Etiqueta
                ParentFont = False
                TabOrder = 0
              end
              object Chbx_Imp_Remetente: TCheckBox
                Left = 6
                Top = 47
                Width = 353
                Height = 17
                Caption = 'Imprimir os dados do Remente'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object Chbx_Imp_Transportador: TCheckBox
                Left = 6
                Top = 79
                Width = 353
                Height = 17
                Caption = 'Imprimir os dados do Transportador'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                OnClick = Chbx_Imp_TransportadorClick
              end
              object DBLCB_Transportadora: TDBLookupComboBox
                Left = 6
                Top = 97
                Width = 406
                Height = 21
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                KeyField = 'EMP_CODIGO'
                ListField = 'EMP_FANTASIA'
                ListSource = DM_ListaConsultas.Ds_ListaTransportadora
                ParentFont = False
                TabOrder = 3
              end
              object Chbx_Imp_Pedido: TCheckBox
                Left = 6
                Top = 123
                Width = 353
                Height = 17
                Caption = 'Imprimir os dados da Pedido'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object StrGrd_Envio: TStringGrid
                Left = 448
                Top = 3
                Width = 515
                Height = 435
                ColCount = 7
                DefaultColWidth = 40
                DefaultRowHeight = 18
                RowCount = 2
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
                ParentFont = False
                TabOrder = 5
                OnClick = StrGrd_EnvioClick
                OnDrawCell = StrGrd_EnvioDrawCell
              end
              object Chbx_Imp_Destinatario: TCheckBox
                Left = 6
                Top = 63
                Width = 353
                Height = 17
                Caption = 'Imprimir os dados do Destinat'#225'rio'
                Checked = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                State = cbChecked
                TabOrder = 6
              end
            end
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Configura'#231#245'es Gerais'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 982
        Height = 540
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          982
          540)
        object Label6: TLabel
          Left = 304
          Top = 12
          Width = 42
          Height = 13
          Alignment = taCenter
          Caption = 'minuto(s)'
        end
        object ChBx_MsgComercioEletronico: TCheckBox
          Left = 7
          Top = 31
          Width = 570
          Height = 17
          Caption = 
            'Ativar Mensagens do na '#224'rea de trabalho para perguntas sobre pro' +
            'dutos ou atualiza'#231#227'o de pedidos'
          TabOrder = 0
          OnMouseDown = ChBx_MsgComercioEletronicoMouseDown
        end
        object ChBx_IntervaloComercioEletronico: TCheckBox
          Left = 7
          Top = 10
          Width = 235
          Height = 17
          Caption = 'Programar verifica'#231#227'o de mensagem a cada '
          TabOrder = 1
          OnMouseDown = ChBx_IntervaloComercioEletronicoMouseDown
        end
        object UpDown1: TUpDown
          Left = 284
          Top = 8
          Width = 16
          Height = 21
          Associate = E_Intervalo
          Min = 1
          Max = 60
          Position = 1
          TabOrder = 2
          OnClick = UpDown1Click
        end
        object E_Intervalo: TEdit_Setes
          Left = 243
          Top = 8
          Width = 41
          Height = 21
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 3
          Text = '1'
        end
        object Btn_Aplicar: TButton
          Left = 897
          Top = 510
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          Enabled = False
          TabOrder = 4
          OnClick = Btn_AplicarClick
        end
        object Btn_Ok: TButton
          Left = 743
          Top = 510
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 5
          OnClick = Btn_OkClick
        end
        object Btn_Cancelar: TButton
          Left = 822
          Top = 510
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 6
          OnClick = Btn_CancelarClick
        end
      end
    end
  end
  object Qr_Pesq_Questionario: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterScroll = Qr_Pesq_QuestionarioAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select PPR_CODIGO                                        '
      ',PPR_CODPRO                                            '
      ',PRO_DESCRICAO                                         '
      ',PRO_CODIGOFAB'
      ',PPR_NOME                                              '
      ',PPR_EMAIL                                             '
      ',PPR_DATA_PERGUNTA                                     '
      ',PPR_PERGUNTA                                          '
      ',PPR_DATA_RESPOSTA                                     '
      ',PPR_RESPOSTA                                          '
      ',PPR_PUBLICADO                                         '
      ',PPR_CODWEB                                          '
      'from TB_PERGUNTA_PRODUTO tb_pergunta                    '
      '   INNER JOIN TB_PRODUTO tb_produto'
      'ON (tb_produto.PRO_CODIGO = tb_pergunta.PPR_CODPRO) '
      'where PPR_CODIGO IS NOT NULL                 ')
    Left = 12
    Top = 480
  end
  object Ds_Pesq_Questionario: TDataSource
    DataSet = Qr_Pesq_Questionario
    Left = 12
    Top = 512
  end
  object Tb_Pergunta_Produto: TSTDataSet
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BeforePost = Tb_Pergunta_ProdutoBeforePost
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from TB_PERGUNTA_PRODUTO'
      'where'
      '  PPR_CODIGO = :PPR_CODIGO')
    RefreshSQL.Strings = (
      'Select '
      '  PPR_CODIGO,'
      '  PPR_DATA_RESPOSTA,'
      '  PPR_RESPOSTA,'
      '  PPR_PUBLICADO'
      'from TB_PERGUNTA_PRODUTO '
      'where'
      '  PPR_CODIGO = :PPR_CODIGO')
    SelectSQL.Strings = (
      'Select '
      '  PPR_CODIGO,'
      '  PPR_DATA_RESPOSTA,'
      '  PPR_RESPOSTA,'
      '  PPR_PUBLICADO'
      'from TB_PERGUNTA_PRODUTO '
      'where'
      '  PPR_CODIGO = :PPR_CODIGO')
    ModifySQL.Strings = (
      'update TB_PERGUNTA_PRODUTO'
      'set'
      '  PPR_DATA_RESPOSTA = :PPR_DATA_RESPOSTA,'
      '  PPR_RESPOSTA = :PPR_RESPOSTA,'
      '  PPR_PUBLICADO = :PPR_PUBLICADO'
      'where'
      '  PPR_CODIGO = :PPR_CODIGO')
    ParamCheck = True
    UniDirectional = False
    Left = 44
    Top = 480
  end
  object Ds_Pergunta_Produto: TDataSource
    DataSet = Tb_Pergunta_Produto
    OnStateChange = Ds_Pergunta_ProdutoStateChange
    Left = 44
    Top = 512
  end
  object Pmu_Opcao: TPopupMenu
    Left = 76
    Top = 480
    object Enviaremailresposta1: TMenuItem
      Caption = 'Enviar e-mail resposta'
      OnClick = Enviaremailresposta1Click
    end
  end
  object ImageList1: TImageList
    Left = 108
    Top = 481
    Bitmap = {
      494C010106002800280010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000FF000000FF
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000007B7B7B0000FF0000000000000000
      000000000000000000000000000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B0000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B0000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD007B7B7B000000000000000000000000007B7B7B007B7B7B007B7B
      7B0000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD007B7B7B000000000000000000000000007B7B7B007B7B7B007B7B
      7B0000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD007B7B7B000000000000000000000000007B7B7B007B7B7B007B7B
      7B000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000000000007B7B7B00000000007B7B7B00000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000BDBDBD00BDBD
      BD0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000BDBDBD00BDBD
      BD0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000BDBDBD00BDBD
      BD0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF00000000007B7B
      7B007B7B7B00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007B7B7B000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007B7B7B000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007B7B7B00000000000000000000000000000000000000FF00000000000000
      FF000000FF000000FF007B7B7B00000000007B7B7B0000000000000000000000
      00000000FF000000FF00000000000000000000000000BDBDBD007B7B7B00FFFF
      FF00000000000000000000FFFF0000848400008484000000000000000000FFFF
      FF007B7B7B007B7B7B00000000000000000000000000BDBDBD007B7B7B00FFFF
      FF00000000000000000000FF000000840000008400000000000000000000FFFF
      FF007B7B7B007B7B7B00000000000000000000000000BDBDBD007B7B7B00FFFF
      FF0000000000000000000000FF0000008400000084000000000000000000FFFF
      FF007B7B7B007B7B7B0000000000000000000000FF000000FF00000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000000000BDBDBD000000000000FF
      FF000000000000FFFF000084840000FFFF0000848400008484000000000000FF
      FF00000000007B7B7B00000000000000000000000000BDBDBD000000000000FF
      00000000000000FF00000084000000FF000000840000008400000000000000FF
      0000000000007B7B7B00000000000000000000000000BDBDBD00000000000000
      FF00000000000000FF00000084000000FF000000840000008400000000000000
      FF00000000007B7B7B0000000000000000000000FF000000FF00000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF000084840000000000FFFF
      FF00000000007B7B7B00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FF000000FF000000FF000000FF00000084000000000000FFFF
      FF00000000007B7B7B00000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000FF000000FF000000FF000000FF000000840000000000FFFF
      FF00000000007B7B7B0000000000000000000000FF000000FF00000000000000
      000000000000000000007B7B7B00000000007B7B7B0000000000000000000000
      0000000000000000FF000000FF000000000000000000FFFFFF000000000000FF
      FF0000000000FFFFFF0000FFFF0000FFFF000084840000FFFF000000000000FF
      FF0000000000BDBDBD00000000000000000000000000FFFFFF000000000000FF
      000000000000FFFFFF0000FF000000FF00000084000000FF00000000000000FF
      000000000000BDBDBD00000000000000000000000000FFFFFF00000000000000
      FF0000000000FFFFFF000000FF000000FF00000084000000FF00000000000000
      FF0000000000BDBDBD0000000000000000000000FF000000FF00000000000000
      000000000000000000000000840000000000000084000000FF00000000000000
      0000000000000000FF000000FF000000000000000000FFFFFF007B7B7B00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FFFF000000000000000000FFFF
      FF007B7B7B00BDBDBD00000000000000000000000000FFFFFF007B7B7B00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FF00000000000000000000FFFF
      FF007B7B7B00BDBDBD00000000000000000000000000FFFFFF007B7B7B00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000FF000000000000000000FFFF
      FF007B7B7B00BDBDBD0000000000000000000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000FF000000FF00000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BDBDBD000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BDBDBD000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BDBDBD00000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000FF0000000000000000000000000000000000FFFFFF00BDBD
      BD0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000BDBD
      BD00BDBDBD000000000000000000000000000000000000000000FFFFFF00BDBD
      BD0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF0000000000BDBD
      BD00BDBDBD000000000000000000000000000000000000000000FFFFFF00BDBD
      BD0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF0000000000BDBD
      BD00BDBDBD00000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000000000000000000000000000000000000000FFFF
      FF00BDBDBD007B7B7B000000000000000000000000007B7B7B00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD007B7B7B000000000000000000000000007B7B7B00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD007B7B7B000000000000000000000000007B7B7B00BDBDBD00BDBD
      BD000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000007B7B7B00000000007B7B7B0000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      F9FFF9FF00000000F0FFF0FF00000000F0FFF0FF00000000E07FE07F00000000
      C07FC07F00000000843F843F000000001E3F1E3F00000000FE1FFE1F00000000
      FF1FFF1F00000000FF8FFF8F00000000FFC7FFC700000000FFE3FFE300000000
      FFF8FFF800000000FFFFFFFF00000000FFFFFFFFFFFFFFFFF83FF83FF83FF83F
      E00FE00FE00FE00FC007C007C007CC478003800380038463800380038003A073
      00010001000131F900010001000138F90001000100013C790001000100013C39
      0001000100013C198003800380039C0B8003800380038C43C007C007C007C467
      E00FE00FE00FE00FF83FF83FF83FF83F00000000000000000000000000000000
      000000000000}
  end
  object Qr_Pesq_Pedidos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  PED_CODIGO,'
      '  PED_CODEMP,'
      '  PGE_CODIGO,'
      '  PED_NUMERO,'
      '  NFL_NUMERO,'
      '  EMP_NOME,'
      '  PED_DATA,'
      '  PGE_TRANSACAO,'
      '  PED_VL_PEDIDO,'
      '  PED_FATURADO,'
      '  PGE_VL_LOJA,'
      '  PGE_VL_TOTAL,'
      '  PGE_VL_DESCONTO,'
      '  PGE_VL_ACRESCIMO,'
      '  PGE_FRM_PAGTO,'
      '  PGE_PARCELAS,'
      '  PGE_STATUS,'
      '  PGE_CD_STATUS,'
      '  PGE_VL_FRETE,'
      '  PGE_TIPO_FRETE,'
      '  PGE_DT_CREDITO'
      'FROM TB_PEDIDO'
      '   INNER JOIN TB_EMPRESA'
      '   ON (EMP_CODIGO = PED_CODEMP)'
      '   LEFT OUTER JOIN TB_PAG_ELETRONICO'
      '   ON (PGE_CODPED = PED_NUMERO)'
      '   LEFT OUTER JOIN TB_NOTA_FISCAL'
      '   ON (NFL_CODPED = PED_CODIGO) '
      'WHERE PED_TIPO =1 AND PED_FATURADO = '#39'N'#39)
    Left = 140
    Top = 481
  end
  object Ds_Pesq_Pedidos: TDataSource
    DataSet = Qr_Pesq_Pedidos
    Left = 142
    Top = 510
  end
  object Qr_ItensVda: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ItensVdaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      ' PRO_SERIE,'
      'EMB_ABREVIATURA,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '  ITF_AQ_DESC,'
      '  ITF_VL_DESC,'
      '  ITF_AQ_IPI,'
      '  ITF_CODEST,'
      '  ITF_CODTPR,'
      '  ITF_ALTURA,'
      '  ITF_LARGURA,'
      '  ITF_ESTOQUE,'
      '  PRO_VL_CUSTOMED,'
      
        '  (((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC)  * ((ITF_AQ_IPI)/100' +
        ')) ITF_VL_IPI,'
      '  ((ITF_QTDE * ITF_VL_UNIT) ) ITF_VL_SUBTOTAL,'
      '  ((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) ITF_VL_TOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   left join tb_embalagem tb_embalagem'
      '     on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      'WHERE (ITF_CODPED =:PED_CODIGO) '
      'ORDER BY PRO_DESCRICAO'
      '  ')
    Left = 177
    Top = 480
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_ItensVda: TDataSource
    DataSet = Qr_ItensVda
    Left = 176
    Top = 512
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '      NFL_CODIGO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '    INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      'WHERE (NFL_CODPED=:PED_CODIGO) '
      ''
      '')
    Left = 208
    Top = 480
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object DS_Nota: TDataSource
    AutoEdit = False
    DataSet = Qr_Nota
    Left = 208
    Top = 512
  end
  object Ds_Cliente: TDataSource
    Left = 240
    Top = 480
  end
  object Qr_Etiqueta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_EtiquetaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  CGE_CODIGO,'
      '  CGE_DESCRICAO,'
      '  CGE_PG_ALTURA,'
      '  CGE_PG_LARGURA,'
      '  CGE_SUPERIOR,'
      '  CGE_INFERIOR,'
      '  CGE_DIREITA,'
      '  CGE_ESQUERA,'
      '  CGE_ET_ALTURA,'
      '  CGE_ET_LARGURA,'
      '  CGE_DIS_COLUNA,'
      '  CGE_TYPEFONTE,'
      '  CGE_SIZEFONTE,'
      '  CGE_PAGESIZE,'
      '  CGE_NR_COLUNA'
      'FROM TB_CFG_ETIQUETA')
    Left = 272
    Top = 481
  end
  object Ds_Etiqueta: TDataSource
    DataSet = Qr_Etiqueta
    Left = 272
    Top = 513
  end
end
