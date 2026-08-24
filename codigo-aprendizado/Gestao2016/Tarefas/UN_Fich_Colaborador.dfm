object Fr_FichaColab: TFr_FichaColab
  Left = 161
  Top = 135
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Ficha Financeira do Colaborador'
  ClientHeight = 509
  ClientWidth = 998
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object StrGrid_Mostra: TStringGrid
    Left = 0
    Top = 0
    Width = 998
    Height = 445
    Align = alClient
    BiDiMode = bdRightToLeft
    Color = clCream
    ColCount = 26
    Ctl3D = False
    DefaultColWidth = 70
    DefaultRowHeight = 18
    RowCount = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect, goThumbTracking]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnDrawCell = StrGrid_MostraDrawCell
    ColWidths = (
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70)
    RowHeights = (
      18
      18)
  end
  object Pnl_botao: TPanel
    Left = 0
    Top = 445
    Width = 998
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      998
      64)
    object SB_Imprimir: TSpeedButton
      Left = 825
      Top = 5
      Width = 87
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Imprimir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
    end
    object SB_Sair_0: TSpeedButton
      Left = 912
      Top = 5
      Width = 87
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
    end
  end
  object Qr_Ficha: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT FPT_HISTORICO, FPT_MES, SUM(FPT_VL_CREDITO) FPT_VENC, SUM' +
        '(FPT_VL_DEBITO) FPT_DESC'
      'FROM TB_FOLHAPAGTO'
      'WHERE (FPT_CODCLB=:FPT_CODCLB) AND'
      '               (FPT_ANO=:FPT_ANO)'
      'GROUP BY FPT_HISTORICO, FPT_MES'
      'ORDER BY  FPT_HISTORICO')
    Left = 128
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FPT_CODCLB'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPT_ANO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Ficha: TDataSource
    DataSet = Qr_Ficha
    Left = 128
    Top = 104
  end
end
