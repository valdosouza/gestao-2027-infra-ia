object Fr_MostraRegraTributacao: TFr_MostraRegraTributacao
  Left = 262
  Top = 179
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lista de Regra de Tributa'#231#227'o para o item '
  ClientHeight = 323
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 654
    Height = 48
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 351
      Height = 16
      Caption = 'Foram encontradas duas ou mais regras para este produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 21
      Width = 363
      Height = 16
      Caption = 'Por favor selecione qual dever'#225' ser utilizada neste momento.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 48
    Width = 654
    Height = 240
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 650
      Height = 236
      Align = alClient
      DataSource = Ds_Tributacao
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NAT_CFOP'
          Title.Caption = 'C.F.O.P.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAT_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 483
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UFE_SIGLA'
          Title.Caption = 'Estado'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 48
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 288
    Width = 654
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      654
      35)
    object Button1: TButton
      Left = 573
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Qr_Tributacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '  TRB_CODIGO,'
      '  NAT_CFOP,'
      '  NAT_DESCRICAO,'
      '  UFE_SIGLA'
      'from "TB_TRIBUTACAO"'
      '     INNER JOIN TB_NATUREZA tb_natureza'
      '     ON (tb_natureza.NAT_CODIGO = TRB_CODNAT)'
      '     LEFT OUTER JOIN TB_UF'
      '    on (UFE_CODIGO = TRB_ESTADO)'
      'WHERE TRB_CODIGO IN (0)')
    Left = 344
    Top = 142
  end
  object Ds_Tributacao: TDataSource
    DataSet = Qr_Tributacao
    Left = 344
    Top = 176
  end
end
