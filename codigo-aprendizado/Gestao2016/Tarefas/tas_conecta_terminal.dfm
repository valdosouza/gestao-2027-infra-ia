object TasConectaTerminal: TTasConectaTerminal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lista de Terminais'
  ClientHeight = 309
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Dbg_Lista: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 856
    Height = 236
    Align = alClient
    DataSource = Ds_Lista
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnl_botao: TPanel
    Left = 0
    Top = 242
    Width = 862
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 672
      Top = 5
      Width = 90
      Height = 57
      Align = alRight
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 489
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 768
      Top = 5
      Width = 89
      Height = 57
      Align = alRight
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
  end
  object Ds_Lista: TDataSource
    DataSet = cds_Lista
    Left = 232
    Top = 120
  end
  object cds_Lista: TClientDataSet
    PersistDataPacket.Data = {
      870000009619E0BD010000001800000004000000000003000000870002696404
      000100000000000B6465736372697074696F6E01004900000001000557494454
      480200020064000B706174685F73657276657201004900000001000557494454
      480200020064000D706174685F64617461626173650100490000000100055749
      4454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 64
    object cds_Listaid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 12
      FieldName = 'id'
    end
    object cds_Listadescription: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 40
      FieldName = 'description'
      Size = 100
    end
    object cds_Listapath_server: TStringField
      DisplayLabel = 'Servidor'
      DisplayWidth = 37
      FieldName = 'path_server'
      Size = 100
    end
    object cds_Listapath_database: TStringField
      DisplayLabel = 'Banco de Dados'
      DisplayWidth = 70
      FieldName = 'path_database'
      Size = 100
    end
  end
end
