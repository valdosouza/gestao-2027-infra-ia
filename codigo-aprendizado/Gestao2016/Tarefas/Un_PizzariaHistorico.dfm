object Fr_PizzariaHistorico: TFr_PizzariaHistorico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #218'ltimo Pedido'
  ClientHeight = 516
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 454
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object navegador: TDBNavigator
      AlignWithMargins = True
      Left = 5
      Top = 416
      Width = 472
      Height = 33
      DataSource = Ds_Historico
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alBottom
      ConfirmDelete = False
      TabOrder = 0
    end
    object M_Pedido: TMemo
      Left = 2
      Top = 2
      Width = 478
      Height = 411
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 454
    Width = 482
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      482
      62)
    object SB_Sair_0: TSpeedButton
      Left = 389
      Top = 4
      Width = 89
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 394
    end
  end
  object Qr_Historico: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterScroll = Qr_HistoricoAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select first 3 PED_CODIGO'
      'FROM tb_pedido'
      '  INNER JOIN TB_NOTA_FISCAL NF'
      '  ON (NFL_CODPED = PED_CODIGO)'
      'WHERE PED_CODEMP=:EMP_CODIGO'
      ' and PED_TIPO = 1'
      'order by ped_codigo desc')
    Left = 116
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_HistoricoPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object Ds_Historico: TDataSource
    DataSet = Qr_Historico
    Left = 112
    Top = 160
  end
end
