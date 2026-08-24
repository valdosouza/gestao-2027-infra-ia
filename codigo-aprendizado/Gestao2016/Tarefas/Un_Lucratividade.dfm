object Fr_Lucratividade: TFr_Lucratividade
  Left = 208
  Top = 154
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lucratividade do Item'
  ClientHeight = 445
  ClientWidth = 735
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
    Top = 380
    Width = 735
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      735
      65)
    object SB_Insere: TSpeedButton
      Left = 193
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
      OnClick = SB_InsereClick
    end
    object SB_Altera: TSpeedButton
      Left = 284
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
      OnClick = SB_AlteraClick
    end
    object SB_Exclui: TSpeedButton
      Left = 375
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
      OnClick = SB_ExcluiClick
    end
    object SB_Grava: TSpeedButton
      Left = 466
      Top = 7
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
      OnClick = SB_GravaClick
    end
    object SB_Cancela: TSpeedButton
      Left = 557
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
      OnClick = SB_CancelaClick
    end
    object Sb_Sair_0: TSpeedButton
      Left = 649
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
    Width = 735
    Height = 55
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Lb_Valor: TLabel
      Left = 610
      Top = 10
      Width = 25
      Height = 14
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 4
      Top = 10
      Width = 57
      Height = 14
      Caption = 'Tipo do Item'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 537
      Top = 10
      Width = 48
      Height = 14
      Caption = 'Opera'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Kind: TSpeedButton
      Left = 511
      Top = 26
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_KindClick
    end
    object Dblcb_Kind_Lucratividade: TDBLookupComboBox
      Left = 4
      Top = 26
      Width = 505
      Height = 22
      KeyField = 'ID'
      ListField = 'DESCRIPTION'
      ListSource = DM_ListaConsultas.Ds_Kind_Lucratividade
      TabOrder = 0
    end
    object Cb_Operacao: TComboBox
      Left = 536
      Top = 26
      Width = 72
      Height = 22
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        'D'#201'BITO'
        'CR'#201'DITO')
    end
    object E_valor: TEdit_Setes
      Left = 609
      Top = 26
      Width = 102
      Height = 22
      Alignment = taRightJustify
      TabOrder = 2
      Text = ''
    end
  end
  object Dbg_Pesq_Cliente: TDBGrid
    Left = 0
    Top = 55
    Width = 735
    Height = 325
    Align = alClient
    Color = clCream
    DataSource = Ds_Lucratividade
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
        FieldName = 'DESCRIPTION'
        Title.Caption = 'Item Avalidado'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPERATION'
        Title.Caption = 'Opera'#231#227'o'
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CURRENT_VALUE'
        Title.Caption = 'Valor '
        Width = 99
        Visible = True
      end>
  end
  object Qr_Lucratividade: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select lucro.*, kind.description'
      'from TB_LUCRATIVIDADE lucro'
      '  inner join  TB_KIND_LUCRATIVIDADE kind'
      'on (kind.ID = lucro.TB_KIND_LUCRATIVIDADE_ID)'
      'where lucro.TB_ITENSNLF_ID=:ITF_CODIGO')
    Left = 440
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITF_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Lucratividade: TDataSource
    DataSet = Qr_Lucratividade
    Left = 440
    Top = 144
  end
end
