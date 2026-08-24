object Fr_Mailing: TFr_Mailing
  Left = 208
  Top = 154
  Caption = 'Lista de Emails'
  ClientHeight = 442
  ClientWidth = 931
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 377
    Width = 931
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      931
      65)
    object SB_Ins_Mailing: TSpeedButton
      Left = 306
      Top = 7
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
      OnClick = SB_Ins_MailingClick
    end
    object SB_Alt_Mailing: TSpeedButton
      Left = 397
      Top = 7
      Width = 91
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
      OnClick = SB_Alt_MailingClick
    end
    object SB_Exc_Mailing: TSpeedButton
      Left = 488
      Top = 7
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
      OnClick = SB_Exc_MailingClick
    end
    object SB_Grv_Mailing: TSpeedButton
      Left = 573
      Top = 6
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
      OnClick = SB_Grv_MailingClick
    end
    object SB_Can_Mailing: TSpeedButton
      Left = 670
      Top = 7
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
      OnClick = SB_Can_MailingClick
    end
    object SB_Pes_Mailing: TSpeedButton
      Left = 762
      Top = 7
      Width = 91
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
      OnClick = SB_Pes_MailingClick
    end
    object Sb_Sair_0: TSpeedButton
      Left = 853
      Top = 7
      Width = 81
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
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 931
    Height = 55
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label28: TLabel
      Left = 325
      Top = 10
      Width = 92
      Height = 14
      Caption = 'Endere'#231'o de e-mail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 760
      Top = 10
      Width = 66
      Height = 14
      Caption = 'Tipo de e-mail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 5
      Top = 10
      Width = 82
      Height = 14
      Caption = 'Nome do Contato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_EMAIL: TMaskEdit
      Left = 323
      Top = 26
      Width = 433
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
    object Cb_Tipo_Email: TComboBox
      Left = 759
      Top = 26
      Width = 171
      Height = 22
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        'PRINCIPAL'
        'FINANCEIRO'
        'COMERCIAL'
        'OR'#199'AMENTO'
        'COMPRAS'
        'VENDAS'
        'NF-E (envio 1)'
        'NF-E (envio 2)'
        'NF-E (envio 3)'
        '')
    end
    object E_Contato: TMaskEdit
      Left = 2
      Top = 26
      Width = 318
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
  end
  object Dbg_Pesq_Cliente: TDBGrid
    Left = 0
    Top = 55
    Width = 931
    Height = 322
    Align = alClient
    Color = clCream
    DataSource = Ds_Qr_Mailing
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MLG_NOME'
        Title.Caption = 'Nome do Contato'
        Width = 309
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MLG_EMAIL'
        Title.Caption = 'Endere'#231'o de e-mail'
        Width = 410
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MLG_TIPO'
        Title.Caption = 'Tipo de e-mail'
        Width = 161
        Visible = True
      end>
  end
  object Qr_Mailing: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select *'
      'from tb_mailing'
      'where mlg_codemp=:emp_codigo')
    Left = 440
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'emp_codigo'
        ParamType = ptUnknown
      end>
    object Qr_MailingMLG_CODEMP: TIntegerField
      FieldName = 'MLG_CODEMP'
      Origin = '"TB_MAILING"."MLG_CODEMP"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_MailingMLG_TIPO: TStringField
      FieldName = 'MLG_TIPO'
      Origin = '"TB_MAILING"."MLG_TIPO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 100
    end
    object Qr_MailingMLG_EMAIL: TStringField
      FieldName = 'MLG_EMAIL'
      Origin = '"TB_MAILING"."MLG_EMAIL"'
      Size = 100
    end
    object Qr_MailingMLG_NOME: TStringField
      FieldName = 'MLG_NOME'
      Origin = '"TB_MAILING"."MLG_NOME"'
      Size = 100
    end
  end
  object Ds_Qr_Mailing: TDataSource
    DataSet = Qr_Mailing
    Left = 440
    Top = 144
  end
end
