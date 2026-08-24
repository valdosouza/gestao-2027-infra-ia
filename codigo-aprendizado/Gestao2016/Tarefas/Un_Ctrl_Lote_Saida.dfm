object Fr_Ctrl_Lote_Saida: TFr_Ctrl_Lote_Saida
  Left = 455
  Top = 160
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Controle de Sa'#237'da de Lotes'
  ClientHeight = 403
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
    Top = 176
    Width = 473
    Height = 166
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object dbgrid_lote: TDBGrid
      Left = 2
      Top = 2
      Width = 469
      Height = 162
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
          Width = 129
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
          Width = 95
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
          Width = 103
          Visible = True
        end>
    end
  end
  object Pnl_Botao: TPanel
    Left = 0
    Top = 342
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
      Left = 190
      Top = 4
      Width = 91
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
      Left = 372
      Top = 4
      Width = 91
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
      Left = 99
      Top = 4
      Width = 91
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
    object Sb_Cancelar: TSpeedButton
      Left = 281
      Top = 4
      Width = 91
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
      Left = 8
      Top = 4
      Width = 91
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
    Height = 176
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 135
      Width = 55
      Height = 13
      Caption = 'Quantidade'
    end
    object E_Qt_Produto: TEdit
      Left = 5
      Top = 150
      Width = 107
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 469
      Height = 131
      DataSource = Ds_LoteDisponivel
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      TabOrder = 1
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
          Width = 129
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLT_QT_SALDO'
          Title.Caption = 'Saldo Quantidade'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 100
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
          Width = 97
          Visible = True
        end>
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
      'WHERE CLT_CODIGO =:CLT_CODIGO'
      'AND MLT_SENTIDO = '#39'S'#39
      '')
    Left = 78
    Top = 207
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MLT_CODVCL'
        ParamType = ptUnknown
      end>
  end
  object Ds_Qr_Lote: TDataSource
    DataSet = Qr_Lote
    Left = 78
    Top = 235
  end
  object Qr_LoteDisponivel: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '    CLT_CODIGO,'
      '   MLT_DATA,'
      '    CLT_CODMHA,'
      '    CLT_CODEMP,'
      '    CLT_NUMERO,'
      '    CLT_CERTIFICADO,'
      '    CLT_CODPRO,'
      '    CLT_DT_VENCIMENTO,'
      '    CLT_QT_SALDO'
      'FROM TB_CTRL_LOTE'
      '   INNER JOIN TB_MOVIMENTO_LOTE'
      '   ON (MLT_CODCLT = CLT_CODIGO)'
      
        'WHERE (CLT_CODPRO =:CLT_CODPRO) AND (CLT_QT_SALDO > 0) AND MLT_S' +
        'ENTIDO = '#39'E'#39
      'UNION'
      'SELECT DISTINCT'
      '    CLT_CODIGO,'
      '   MLT_DATA,'
      '    CLT_CODMHA,'
      '    CLT_CODEMP,'
      '    CLT_NUMERO,'
      '    CLT_CERTIFICADO,'
      '    CLT_CODPRO,'
      '    CLT_DT_VENCIMENTO,'
      '    CLT_QT_SALDO'
      'FROM TB_CTRL_LOTE'
      '   INNER JOIN TB_MOVIMENTO_LOTE'
      '   ON (MLT_CODCLT = CLT_CODIGO)'
      '   INNER JOIN TB_PRODUTO'
      '   ON (PRO_CODIGO = CLT_CODPRO)'
      '  INNER JOIN tb_prod_prod'
      '  ON (tb_prod_prod.ppd_codpro_D = PRO_CODIGO)'
      
        'WHERE (ppd_codpro_m =:CLT_CODPRO) AND (CLT_QT_SALDO > 0) AND MLT' +
        '_SENTIDO = '#39'E'#39)
    Left = 46
    Top = 207
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CLT_CODPRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CLT_CODPRO'
        ParamType = ptUnknown
      end>
  end
  object Ds_LoteDisponivel: TDataSource
    DataSet = Qr_LoteDisponivel
    Left = 46
    Top = 235
  end
end
