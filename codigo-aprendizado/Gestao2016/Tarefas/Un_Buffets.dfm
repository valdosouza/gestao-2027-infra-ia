object Fr_Buffets: TFr_Buffets
  Left = 89
  Top = -10
  BorderStyle = bsNone
  Caption = 'Vendas'
  ClientHeight = 746
  ClientWidth = 1272
  Color = clBtnFace
  Constraints.MinHeight = 746
  Constraints.MinWidth = 1024
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1272
    Height = 746
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    DesignSize = (
      1268
      742)
    object Sb_Adiciona: TSpeedButton
      Left = 12
      Top = 514
      Width = 217
      Height = 65
      Anchors = [akLeft, akBottom]
      Caption = 'ADICIONAR ITEM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_AdicionaClick
    end
    object Sb_Retira: TSpeedButton
      Left = 230
      Top = 514
      Width = 217
      Height = 65
      Anchors = [akLeft, akBottom]
      Caption = 'RETIRAR ITEM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_RetiraClick
    end
    object Sb_Confirma: TSpeedButton
      Left = 164
      Top = 697
      Width = 320
      Height = 65
      Anchors = [akLeft, akBottom]
      Caption = 'CONFIRMA PAGAMENTO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = Sb_ConfirmaClick
    end
    object Sb_Cancelar: TSpeedButton
      Left = 8
      Top = 697
      Width = 155
      Height = 65
      Anchors = [akLeft, akBottom]
      Caption = 'CANCELAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = Sb_CancelarClick
    end
    object Panel2: TPanel
      Left = 4
      Top = 4
      Width = 1260
      Height = 93
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = clWindow
      TabOrder = 0
      DesignSize = (
        1260
        93)
      object Label1: TLabel
        Left = 861
        Top = 48
        Width = 141
        Height = 23
        Anchors = [akTop, akRight]
        Caption = 'VALOR A PAGAR'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial Black'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lb_Vl_Total: TLabel
        Left = 1026
        Top = 37
        Width = 173
        Height = 45
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'R$ 199,99'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -32
        Font.Name = 'Arial Black'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object E_Vl_total: TLabel
        Left = 475
        Top = 29
        Width = 116
        Height = 45
        Alignment = taRightJustify
        Caption = '199,99'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -32
        Font.Name = 'Arial Black'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object Label3: TLabel
        Left = 4
        Top = 2
        Width = 1007
        Height = 19
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'TERMINAL DE VENDAS  - BUFFET - LAMAMA'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Lb_Data_Caixa: TLabel
        Left = 757
        Top = 2
        Width = 498
        Height = 19
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'DATA DO CAIXA - 05/03/2009'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object IM_Logo: TImage
        Left = 5
        Top = 21
        Width = 225
        Height = 70
        Cursor = crArrow
        AutoSize = True
        Center = True
        OnClick = IM_LogoClick
      end
    end
    object Panel8: TPanel
      Left = 1060
      Top = 514
      Width = 195
      Height = 247
      Anchors = [akRight, akBottom]
      Caption = 'Panel8'
      TabOrder = 1
      object Sb_7: TSpeedButton
        Left = 5
        Top = 5
        Width = 61
        Height = 59
        Caption = '7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_7Click
      end
      object Sb_8: TSpeedButton
        Left = 67
        Top = 5
        Width = 61
        Height = 59
        Caption = '8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_8Click
      end
      object Sb_9: TSpeedButton
        Left = 128
        Top = 5
        Width = 61
        Height = 59
        Caption = '9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_9Click
      end
      object Sb_4: TSpeedButton
        Left = 5
        Top = 64
        Width = 61
        Height = 59
        Caption = '4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_4Click
      end
      object Sb_5: TSpeedButton
        Left = 67
        Top = 64
        Width = 61
        Height = 59
        Caption = '5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_5Click
      end
      object Sb_6: TSpeedButton
        Left = 128
        Top = 64
        Width = 61
        Height = 59
        Caption = '6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_6Click
      end
      object Sb_1: TSpeedButton
        Left = 5
        Top = 123
        Width = 61
        Height = 59
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_1Click
      end
      object Sb_2: TSpeedButton
        Left = 67
        Top = 123
        Width = 61
        Height = 59
        Caption = '2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_2Click
      end
      object Sb_3: TSpeedButton
        Left = 128
        Top = 123
        Width = 61
        Height = 59
        Caption = '3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_3Click
      end
      object Sb_0: TSpeedButton
        Left = 6
        Top = 183
        Width = 60
        Height = 59
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_0Click
      end
      object Sb_Limpa: TSpeedButton
        Left = 66
        Top = 183
        Width = 123
        Height = 59
        Caption = 'Limpa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_LimpaClick
      end
    end
    object Grp_Pagamento: TGroupBox
      Left = 5
      Top = 593
      Width = 799
      Height = 99
      Anchors = [akLeft, akBottom]
      Caption = 'Totalizador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label6: TLabel
        Left = 416
        Top = 202
        Width = 126
        Height = 29
        Caption = 'Valor Troco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 7
        Top = 27
        Width = 131
        Height = 18
        Caption = 'VALOR DINHEIRO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 169
        Top = 27
        Width = 140
        Height = 18
        Caption = 'CART'#195'O CR'#201'DITO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 335
        Top = 27
        Width = 128
        Height = 18
        Caption = 'CART'#195'O D'#201'BITO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 497
        Top = 27
        Width = 105
        Height = 18
        Caption = 'FALTA PAGAR'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 647
        Top = 27
        Width = 141
        Height = 18
        Caption = 'VALOR DO TROCO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_VL_Dinheiro: TEdit_Setes
        Left = 5
        Top = 47
        Width = 160
        Height = 26
        Alignment = taRightJustify
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkFlat
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        Text = '0,00'
        OnChange = E_VL_DinheiroChange
        OnEnter = E_VL_DinheiroEnter
        OnExit = E_VL_DinheiroExit
      end
      object E_VL_Debito: TEdit_Setes
        Left = 331
        Top = 47
        Width = 160
        Height = 26
        Alignment = taRightJustify
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkFlat
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Text = '0,00'
        OnChange = E_VL_DebitoChange
        OnEnter = E_VL_DebitoEnter
        OnExit = E_VL_DebitoExit
      end
      object E_Vl_Credito: TEdit_Setes
        Left = 168
        Top = 47
        Width = 160
        Height = 26
        Alignment = taRightJustify
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkFlat
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        Text = '0,00'
        OnChange = E_Vl_CreditoChange
        OnEnter = E_Vl_CreditoEnter
        OnExit = E_Vl_CreditoExit
      end
      object E_Vl_Pagar: TEdit_Setes
        Left = 493
        Top = 47
        Width = 152
        Height = 26
        TabStop = False
        Alignment = taRightJustify
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkFlat
        Ctl3D = False
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        Text = '0,00'
      end
      object E_VL_Troco: TEdit_Setes
        Left = 646
        Top = 47
        Width = 147
        Height = 26
        TabStop = False
        Alignment = taRightJustify
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkFlat
        Ctl3D = False
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -32
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        Text = '0,00'
      end
    end
    object Panel3: TPanel
      Left = 4
      Top = 97
      Width = 1260
      Height = 415
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Panel3'
      TabOrder = 3
      object Pg_Terminal: TPageControl
        Left = 2
        Top = 2
        Width = 1256
        Height = 411
        ActivePage = Tbh_Pesquisa
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Style = tsFlatButtons
        TabOrder = 0
        OnChange = Pg_TerminalChange
        object Tbh_Buffet: TTabSheet
          Caption = 'BUFFETS'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 1248
            Height = 364
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              1248
              364)
            object Label8: TLabel
              Left = 978
              Top = 16
              Width = 180
              Height = 24
              Anchors = [akTop, akRight]
              Caption = 'PRE'#199'O POR KILO'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 978
              Top = 132
              Width = 201
              Height = 24
              Anchors = [akTop, akRight]
              Caption = 'PESO DA BALAN'#199'A'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label5: TLabel
              Left = 979
              Top = 233
              Width = 199
              Height = 24
              Anchors = [akTop, akRight]
              Caption = 'PRE'#199'O DO BUFFET'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object E_Preco_Buffet: TPanel
              Left = 978
              Top = 45
              Width = 257
              Height = 52
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Caption = '0,00'
              Color = clBlack
              Font.Charset = ANSI_CHARSET
              Font.Color = clLime
              Font.Height = -32
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Locked = True
              ParentFont = False
              TabOrder = 0
            end
            object E_Peso_Balanca: TPanel
              Left = 978
              Top = 155
              Width = 257
              Height = 52
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Caption = '0,00'
              Color = clBlack
              Font.Charset = ANSI_CHARSET
              Font.Color = clLime
              Font.Height = -32
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Locked = True
              ParentFont = False
              TabOrder = 1
            end
            object E_Vl_Buffet: TPanel
              Left = 978
              Top = 259
              Width = 257
              Height = 52
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Caption = '0,00'
              Color = clBlack
              Font.Charset = ANSI_CHARSET
              Font.Color = clLime
              Font.Height = -32
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Locked = True
              ParentFont = False
              TabOrder = 2
            end
            object StrGrd_Itens_Vda: TStringGrid
              Left = 2
              Top = 2
              Width = 960
              Height = 360
              Align = alLeft
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clScrollBar
              ColCount = 9
              DefaultRowHeight = 35
              FixedCols = 0
              RowCount = 2
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -24
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              GridLineWidth = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect]
              ParentFont = False
              TabOrder = 3
              OnDrawCell = StrGrd_Itens_VdaDrawCell
              ColWidths = (
                64
                64
                64
                64
                64
                64
                64
                64
                64)
              RowHeights = (
                35
                35)
            end
          end
        end
        object Tbh_Pesquisa: TTabSheet
          Caption = 'Pesquisa'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Pesquisa: TPanel
            Left = 0
            Top = 0
            Width = 1248
            Height = 364
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            Visible = False
            DesignSize = (
              1248
              364)
            object E_Bebidas: TEdit
              Left = 7
              Top = 7
              Width = 1233
              Height = 37
              Anchors = [akLeft, akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -24
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object DBGrid2: TDBGrid
              Left = 2
              Top = 51
              Width = 1244
              Height = 257
              Anchors = [akLeft, akTop, akRight, akBottom]
              DataSource = Ds_Produtos
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -24
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'PRO_DESCRICAO'
                  Title.Caption = 'PRODUTOS'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRO_VALOR'
                  Title.Caption = 'VALOR'
                  Width = 146
                  Visible = True
                end>
            end
            object Sb_Pesquisa: TButton
              Left = 1096
              Top = 311
              Width = 146
              Height = 47
              Anchors = [akRight, akBottom]
              Caption = 'OCULTAR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -24
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnClick = Sb_PesquisaClick
            end
          end
        end
      end
    end
  end
  object Qr_Ins_Ordem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'INSERT INTO TB_PEDIDO ('
      '  PED_CODIGO,'
      '  PED_NUMERO,'
      '  PED_TIPO,'
      '  PED_CODUSU,'
      '  PED_DATA,'
      '  PED_CODEMP,'
      '  PED_CODVDO,'
      '  PED_CODFPG,'
      '  PED_PRAZO,'
      '  PED_CODEND,'
      '  PED_QT_PRODUTO,'
      '  PED_VL_PRODUTO,'
      '  PED_VL_SERVICO,'
      '  PED_VL_IPI,'
      '  PED_VL_FRETE,'
      '  PED_ALIQ_DESCONTO,'
      '  PED_VL_DESCONTO,'
      '  PED_VL_PEDIDO,'
      '  PED_FATURADO,'
      '  PED_TP_CONTATO,'
      '  PED_OBS,'
      '  PED_DT_ENTREGA,'
      '  PED_CODMHA)'
      'VALUES ('
      '  :PED_CODIGO,'
      '  :PED_NUMERO,'
      '  1,'
      '  :PED_CODUSU,'
      '  :PED_DATA,'
      '  :PED_CODEMP,'
      '  :PED_CODVDO,'
      '  :PED_CODFPG,'
      '  :PED_PRAZO,'
      '  :PED_CODEND,'
      '  :PED_QT_PRODUTO,'
      '  :PED_VL_PRODUTO,'
      '  :PED_VL_SERVICO,'
      '  :PED_VL_IPI,'
      '  :PED_VL_FRETE,'
      '  :PED_ALIQ_DESCONTO,'
      '  :PED_VL_DESCONTO,'
      '  :PED_VL_PEDIDO,'
      '   '#39'N'#39','
      '  :PED_TP_CONTATO,'
      '  :PED_OBS,'
      '  :PED_DT_ENTREGA,'
      '  :PED_CODMHA)')
    Left = 256
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_NUMERO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODUSU'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_DATA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODEMP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODVDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODFPG'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_PRAZO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODEND'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_QT_PRODUTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_PRODUTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_SERVICO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_IPI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_FRETE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_ALIQ_DESCONTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_DESCONTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_PEDIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_TP_CONTATO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_OBS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_DT_ENTREGA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      'ITF_OPER,'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  PRO_VL_CUSTOMED,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_AQ_IPI,'
      '  ITF_AQ_COM,'
      '  ITF_AQ_ICMS,'
      '  ITF_AQ_DESC,'
      '  ITF_VL_DESC,'
      '  PRO_CODIGOFOR,'
      '  ITF_ESTOQUE,'
      '  ITF_CODTPR,'
      '  ITF_CODEST,'
      '  (ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL, '
      '   ((ITF_QTDE * ITF_VL_UNIT)  * ITF_AQ_IPI) / 100 AS ITF_VL_IPI'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      ''
      '   INNER JOIN TB_MEDIDA Tb_medida'
      '   ON  (Tb_medida.MED_CODIGO = Tb_produto.PRO_CODMED)'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = '#39'P'#39')'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    Left = 320
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Pedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  PED_CODIGO,'
      '  PED_CODEMP,'
      '  PED_CODVDO,'
      '  EMP_CONSUMIDOR,'
      '  EMP_MICRO,'
      '  UFE_CODIGO,'
      '  UFE_SIGLA,'
      '  EMP_FABRICA,'
      '  EMP_SUB_TRIB'
      'FROM TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (PED_CODIGO=:PED_CODIGO)  AND (END_TIPO = '#39'PRINCIPAL'#39')')
    Left = 288
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_PedidoPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = 'TB_PEDIDO.PED_CODEMP'
      Required = True
    end
    object Qr_PedidoPED_CODVDO: TIntegerField
      FieldName = 'PED_CODVDO'
      Origin = 'TB_PEDIDO.PED_CODVDO'
      Required = True
    end
    object Qr_PedidoEMP_CONSUMIDOR: TStringField
      FieldName = 'EMP_CONSUMIDOR'
      Origin = 'TB_EMPRESA.EMP_CONSUMIDOR'
      Size = 1
    end
    object Qr_PedidoEMP_MICRO: TStringField
      FieldName = 'EMP_MICRO'
      Origin = 'TB_EMPRESA.EMP_MICRO'
      Size = 1
    end
    object Qr_PedidoUFE_CODIGO: TIntegerField
      FieldName = 'UFE_CODIGO'
      Origin = 'TB_UF.UFE_CODIGO'
      Required = True
    end
    object Qr_PedidoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_PedidoEMP_FABRICA: TStringField
      FieldName = 'EMP_FABRICA'
      Origin = 'TB_EMPRESA.EMP_FABRICA'
      FixedChar = True
      Size = 1
    end
    object Qr_PedidoEMP_SUB_TRIB: TStringField
      FieldName = 'EMP_SUB_TRIB'
      Origin = 'TB_EMPRESA.EMP_SUB_TRIB'
      FixedChar = True
      Size = 1
    end
    object Qr_PedidoPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = 'TB_PEDIDO.PED_CODIGO'
      Required = True
    end
  end
  object Balanca: TACBrBAL
    Porta = 'COM1'
    Left = 408
    Top = 56
  end
  object Qr_Produtos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    OnCalcFields = Qr_ProdutosCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CAMPANHA'
      'FROM TB_PRODUTO PRO'
      '   INNER JOIN TB_GRUPOS tb_grupo'
      '   ON (tb_grupo.GRP_CODIGO = PRO.PRO_CODGRP)'
      'WHERE PRO_TIPO = '#39'P'#39' '
      '      AND GRP_DESCRICAO=:GRP_DESCRICAO')
    Left = 495
    Top = 37
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GRP_DESCRICAO'
        ParamType = ptUnknown
      end>
    object Qr_ProdutosPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = 'TB_PRODUTO.PRO_CODIGO'
      Required = True
    end
    object Qr_ProdutosPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_ProdutosPRO_VALOR: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PRO_VALOR'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object Qr_ProdutosPRO_CAMPANHA: TStringField
      FieldName = 'PRO_CAMPANHA'
      Origin = 'TB_PRODUTO.PRO_CAMPANHA'
      Size = 1
    end
  end
  object Ds_Produtos: TDataSource
    DataSet = Qr_Produtos
    Left = 495
    Top = 69
  end
  object Tm_PegaPeso: TTimer
    Interval = 2000
    OnTimer = Tm_PegaPesoTimer
    Left = 656
    Top = 168
  end
  object Qr_Preco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '   PRC_CODIGO,'
      '   PRC_CODTPR,'
      '  PRC_AQ_COM,'
      '  PRC_VL_VDA,'
      '   TPR_NOME'
      'FROM TB_TABELA_PRECO'
      '   INNER JOIN TB_PRECO'
      '   ON (PRC_CODTPR = TPR_CODIGO)'
      'WHERE (PRC_CODPRO=:PRO_CODIGO) '
      '              AND (PRC_CODTPR =:PRC_CODTPR)')
    Left = 456
    Top = 40
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end
      item
        DataType = ftUnknown
        Name = 'PRC_CODTPR'
        ParamType = ptUnknown
      end>
  end
end
