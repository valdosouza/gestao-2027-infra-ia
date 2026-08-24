object Fr_Ctrl_Lote_Entrada: TFr_Ctrl_Lote_Entrada
  Left = 536
  Top = 200
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Controle de Entrada de Lotes'
  ClientHeight = 388
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 86
    Width = 473
    Height = 241
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object dbgrid_lote: TDBGrid
      Left = 2
      Top = 2
      Width = 469
      Height = 237
      Align = alClient
      DataSource = Ds_Qr_Lote
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
          FieldName = 'MLT_DATA'
          Title.Caption = 'Data'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLT_NUMERO'
          Title.Caption = 'N'#250'mero'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 195
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MLT_QTDE'
          Title.Caption = 'Quantidade'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 83
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLT_CERTIFICADO'
          Title.Caption = 'Certificado'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 176
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLT_DT_VENCIMENTO'
          Title.Caption = 'Vencimento'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end>
    end
  end
  object Pnl_Botao: TPanel
    Left = 0
    Top = 327
    Width = 473
    Height = 61
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = #39
    TabOrder = 1
    DesignSize = (
      473
      61)
    object Sb_Gravar: TSpeedButton
      Left = 230
      Top = 4
      Width = 77
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
      Transparent = False
      OnClick = Sb_GravarClick
    end
    object SB_Sair_0: TSpeedButton
      Left = 390
      Top = 4
      Width = 77
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
      OnClick = SB_Sair_0Click
    end
    object Sb_Excluir: TSpeedButton
      Left = 159
      Top = 4
      Width = 77
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
      Transparent = False
      OnClick = Sb_ExcluirClick
    end
    object Sb_Alterar: TSpeedButton
      Left = 82
      Top = 4
      Width = 77
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
      Transparent = False
      OnClick = Sb_AlterarClick
    end
    object Sb_Cancelar: TSpeedButton
      Left = 313
      Top = 4
      Width = 77
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
      Transparent = False
      OnClick = Sb_CancelarClick
    end
    object Sb_Inserir: TSpeedButton
      Left = 5
      Top = 4
      Width = 77
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Inserir - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = Sb_InserirClick
    end
  end
  object Pnl_Fundos: TPanel
    Left = 0
    Top = 0
    Width = 473
    Height = 86
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentBackground = False
    TabOrder = 2
    object Label11: TLabel
      Left = 119
      Top = 2
      Width = 76
      Height = 13
      Caption = 'N'#250'mero do Lote'
    end
    object Label12: TLabel
      Left = 4
      Top = 2
      Width = 26
      Height = 13
      Caption = 'Data:'
    end
    object Label18: TLabel
      Left = 383
      Top = 42
      Width = 85
      Height = 13
      Caption = 'Data Vencimento:'
    end
    object Label1: TLabel
      Left = 313
      Top = 41
      Width = 55
      Height = 13
      Caption = 'Quantidade'
    end
    object Label2: TLabel
      Left = 295
      Top = 2
      Width = 105
      Height = 13
      Caption = 'N'#250'mero do Certificado'
    end
    object Label41: TLabel
      Left = 4
      Top = 43
      Width = 85
      Height = 14
      Caption = 'Marca do produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Marca: TSpeedButton
      Left = 284
      Top = 56
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_MarcaClick
    end
    object E_Nr_Lote: TEdit
      Left = 117
      Top = 16
      Width = 173
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
    end
    object E_Qt_Produto: TEdit
      Left = 312
      Top = 56
      Width = 67
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_Nr_Certificado: TEdit
      Left = 293
      Top = 16
      Width = 173
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
    end
    object E_Dt_Lote: TMaskEdit
      Left = 4
      Top = 16
      Width = 108
      Height = 21
      EditMask = '!##/##/####;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
    end
    object E_Dt_Vencimento: TMaskEdit
      Left = 382
      Top = 56
      Width = 89
      Height = 21
      EditMask = '!##/##/####;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 5
      Text = '  /  /    '
    end
    object Dblcb_MarcaAE: TDBLookupComboBox
      Left = 4
      Top = 57
      Width = 280
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'MRC_CODIGO'
      ListField = 'MRC_DESCRICAO'
      ListSource = DM.Ds_marcaProduto
      ParentFont = False
      TabOrder = 3
    end
  end
  object Qr_Lote: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterScroll = Qr_LoteAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    CLT_CODIGO,'
      '    CLT_CODMHA,'
      '    CLT_CODEMP,'
      '    CLT_NUMERO,'
      '    CLT_CERTIFICADO,'
      '    CLT_CODPRO,'
      '    CLT_CODMRC,'
      '    CLT_DT_VENCIMENTO,'
      '    CLT_QT_ENTRADA,'
      '    CLT_QT_SAIDA,'
      '    CLT_QT_SALDO,'
      '    MLT_CODIGO,'
      '    MLT_DATA,'
      '    MLT_QTDE'
      'FROM TB_CTRL_LOTE'
      '   INNER JOIN TB_MOVIMENTO_LOTE'
      '   ON (MLT_CODCLT = CLT_CODIGO)'
      'WHERE MLT_CODVCL=:MLT_CODVCL and MLT_TIPO=:MLT_TIPO'
      '')
    Left = 46
    Top = 183
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MLT_CODVCL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MLT_TIPO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Qr_Lote: TDataSource
    DataSet = Qr_Lote
    Left = 46
    Top = 235
  end
end
