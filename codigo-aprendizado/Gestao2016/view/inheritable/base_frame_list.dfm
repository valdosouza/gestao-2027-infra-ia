object BaseFrameList: TBaseFrameList
  Left = 0
  Top = 0
  Width = 494
  Height = 47
  TabOrder = 0
  object pnl_linha_1: TPanel
    Left = 0
    Top = 20
    Width = 494
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Sb_open: TSpeedButton
      Left = 470
      Top = 0
      Width = 24
      Height = 21
      Align = alRight
      Caption = '...'
      ExplicitLeft = 441
      ExplicitTop = 11
      ExplicitHeight = 22
    end
    object Dblcb_Lista: TDBLookupComboBox
      Left = 0
      Top = 0
      Width = 470
      Height = 21
      Align = alClient
      ListSource = Ds_Lista
      TabOrder = 0
      OnKeyDown = Dblcb_ListaKeyDown
    end
  end
  object pnl_top: TPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object L_name_list: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 67
      Height = 14
      Margins.Bottom = 1
      Align = alClient
      Caption = 'nome da Lista'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
  object Ds_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 81
    Top = 57
  end
  object Qr_Lista: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Listas
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 32
    Top = 48
  end
  object IBT_Listas: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 156
    Top = 46
  end
end
