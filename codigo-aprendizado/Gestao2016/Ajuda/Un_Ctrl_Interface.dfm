object Fr_Ctrl_Interface: TFr_Ctrl_Interface
  Left = 312
  Top = 172
  Caption = 'Controle de Interfaces'
  ClientHeight = 421
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_botao: TPanel
    Left = 0
    Top = 355
    Width = 657
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      657
      66)
    object SB_Aplicar: TSpeedButton
      Left = 469
      Top = 6
      Width = 92
      Height = 54
      Anchors = [akBottom]
      Caption = 'Aplicar - F5'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_AplicarClick
    end
    object Sb_Sair_0: TSpeedButton
      Left = 563
      Top = 6
      Width = 91
      Height = 54
      Anchors = [akBottom]
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
    object SB_Add_Tudo: TSpeedButton
      Left = 6
      Top = 2
      Width = 109
      Height = 24
      Caption = 'Marcar todos'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_Add_TudoClick
    end
    object SB_Retirar_Tudo: TSpeedButton
      Left = 116
      Top = 2
      Width = 107
      Height = 24
      Caption = 'Desmarcar todos'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333FFF33FF333FFF339993370733
        999333777FF37FF377733339993000399933333777F777F77733333399970799
        93333333777F7377733333333999399933333333377737773333333333990993
        3333333333737F73333333333331013333333333333777FF3333333333910193
        333333333337773FF3333333399000993333333337377737FF33333399900099
        93333333773777377FF333399930003999333337773777F777FF339993370733
        9993337773337333777333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_Retirar_TudoClick
    end
    object lb_qtd_itens: TLabel
      Left = 4
      Top = 27
      Width = 128
      Height = 13
      Caption = 'C'#243'digo do Cliente na Setes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Cd_Cliente: TSpeedButton
      Left = 108
      Top = 41
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_Cd_ClienteClick
    end
    object Label1: TLabel
      Left = 137
      Top = 27
      Width = 129
      Height = 13
      Caption = 'C'#243'digo do Projeto na Setes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 242
      Top = 41
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object E_Cd_Cliente_setes: TEdit_Setes
      Left = 4
      Top = 41
      Width = 99
      Height = 21
      TabOrder = 0
      Text = ''
      OnChange = E_Cd_Cliente_setesChange
    end
    object E_Cd_Projeto_setes: TEdit_Setes
      Left = 137
      Top = 42
      Width = 99
      Height = 21
      TabOrder = 1
      Text = ''
      OnChange = E_Cd_Cliente_setesChange
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 657
    Height = 355
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object PG_Informacoes: TPageControl
      Left = 339
      Top = 2
      Width = 4
      Height = 130
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
    end
    object Pn_Modulos: TPanel
      Left = 2
      Top = 2
      Width = 337
      Height = 130
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvLowered
      TabOrder = 1
      object Panel2: TPanel
        Left = 2
        Top = 2
        Width = 333
        Height = 16
        Align = alTop
        BevelInner = bvLowered
        Caption = 'M'#243'dulos'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Dbg_modulo: TDBGrid
        Left = 2
        Top = 18
        Width = 333
        Height = 110
        Align = alClient
        Ctl3D = False
        DataSource = Ds_Modulo
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
        ParentCtl3D = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = Dbg_moduloCellClick
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'MOD_CODIGO'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MOD_DESCRICAO'
            Title.Caption = 'Descri'#231#227'o'
            Width = 195
            Visible = True
          end>
      end
    end
    object Panel3: TPanel
      Left = 327
      Top = 2
      Width = 328
      Height = 130
      Align = alRight
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvLowered
      TabOrder = 2
      object Panel4: TPanel
        Left = 2
        Top = 2
        Width = 324
        Height = 16
        Align = alTop
        BevelInner = bvLowered
        Caption = 'Menus'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Dbg_Menus: TDBGrid
        Left = 2
        Top = 18
        Width = 324
        Height = 110
        Align = alClient
        Ctl3D = False
        DataSource = Ds_Menus
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
        ParentCtl3D = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = Dbg_MenusCellClick
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'MNU_CODIGO'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MNU_DESCRICAO'
            Title.Caption = 'Descri'#231#227'o'
            Width = 195
            Visible = True
          end>
      end
    end
    object Panel5: TPanel
      Left = 2
      Top = 132
      Width = 653
      Height = 221
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvLowered
      TabOrder = 3
      object Panel6: TPanel
        Left = 2
        Top = 2
        Width = 649
        Height = 16
        Align = alTop
        BevelInner = bvLowered
        Caption = 'Itens Menu'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Chlb_Interface: TCheckListBox
        Left = 2
        Top = 18
        Width = 649
        Height = 201
        Align = alClient
        Columns = 3
        Style = lbOwnerDrawFixed
        TabOrder = 1
      end
    end
  end
  object Qr_Modulo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MODULO')
    Left = 91
    Top = 36
  end
  object Ds_Modulo: TDataSource
    DataSet = Qr_Modulo
    Left = 91
    Top = 64
  end
  object Qr_Menus: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MENUS'
      'WHERE MNU_CODMOD=:MOD_CODIGO')
    Left = 115
    Top = 36
    ParamData = <
      item
        DataType = ftInteger
        Name = 'MOD_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_Menus: TDataSource
    DataSet = Qr_Menus
    Left = 123
    Top = 64
  end
  object Qr_Interface: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  IFC_SISTEMA,'
      '  IFC_CODIGO,'
      '  IFC_CODMNU,'
      '  IFC_DESCRICAO,'
      '  IFC_FR_NAME'
      'FROM TB_INTERFACE tb_interface'
      'WHERE (IFC_CODMNU=:MNU_CODIGO )'
      '')
    Left = 147
    Top = 36
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MNU_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_ItemMenu: TDataSource
    DataSet = Qr_Interface
    Left = 155
    Top = 64
  end
  object Qr_Atualiza: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'UPDATE OR INSERT INTO TB_INTERFACE (IFC_CODIGO, IFC_DESCRICAO, I' +
        'FC_FR_NAME, IFC_CODMNU, IFC_SISTEMA)'
      
        '                            VALUES (:IFC_CODIGO, :IFC_DESCRICAO,' +
        ' :IFC_FR_NAME, :IFC_CODMNU, :IFC_SISTEMA)'
      '                          MATCHING (IFC_CODIGO);')
    Left = 204
    Top = 36
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IFC_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_DESCRICAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_FR_NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_CODMNU'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_SISTEMA'
        ParamType = ptUnknown
      end>
  end
  object Qr_acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'UPDATE OR INSERT INTO TB_INTERFACE (IFC_CODIGO, IFC_DESCRICAO, I' +
        'FC_FR_NAME, IFC_CODMNU, IFC_SISTEMA)'
      
        '                            VALUES (:IFC_CODIGO, :IFC_DESCRICAO,' +
        ' :IFC_FR_NAME, :IFC_CODMNU, :IFC_SISTEMA)'
      '                          MATCHING (IFC_CODIGO);')
    Left = 300
    Top = 36
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IFC_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_DESCRICAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_FR_NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_CODMNU'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IFC_SISTEMA'
        ParamType = ptUnknown
      end>
  end
end
