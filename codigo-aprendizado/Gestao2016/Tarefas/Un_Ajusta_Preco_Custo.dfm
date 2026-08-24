object Fr_AjustaPrecoCusto: TFr_AjustaPrecoCusto
  Left = 447
  Top = 115
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ajusta Pre'#231'o de Custo'
  ClientHeight = 298
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Geral: TPageControl
    Left = 0
    Top = 0
    Width = 456
    Height = 233
    ActivePage = tbs_Multiplos
    Align = alClient
    TabOrder = 1
    object tbs_Multiplos: TTabSheet
      Caption = 'Base de Troca'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 205
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 4
          Width = 438
          Height = 13
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Selecione o Grupo'
          ExplicitWidth = 88
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 46
          Width = 438
          Height = 13
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Selecione o Sub-Grupo'
          ExplicitWidth = 110
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 88
          Width = 438
          Height = 13
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Selecione a Marca'
          ExplicitWidth = 89
        end
        object DBLCB_Grupo: TDBLookupComboBox
          AlignWithMargins = True
          Left = 5
          Top = 21
          Width = 438
          Height = 21
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          KeyField = 'GRP_CODIGO'
          ListField = 'GRP_DESCRICAO'
          ListSource = DM.Ds_Grupo
          TabOrder = 0
          OnKeyDown = DBLCB_GrupoKeyDown
        end
        object DBLCB_SubGrupo: TDBLookupComboBox
          AlignWithMargins = True
          Left = 5
          Top = 63
          Width = 438
          Height = 21
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          KeyField = 'SBG_CODIGO'
          ListField = 'SBG_DESCRICAO'
          ListSource = DM.Ds_SubGrupo
          TabOrder = 1
          OnKeyDown = DBLCB_SubGrupoKeyDown
        end
        object DBLCB_Marca: TDBLookupComboBox
          AlignWithMargins = True
          Left = 5
          Top = 105
          Width = 438
          Height = 21
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          KeyField = 'MRC_CODIGO'
          ListField = 'MRC_DESCRICAO'
          ListSource = DM.Ds_marcaProduto
          TabOrder = 2
          OnKeyDown = DBLCB_MarcaKeyDown
        end
        object chbx_ValidaGrupoSubgrupo: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 185
          Width = 438
          Height = 15
          Align = alBottom
          Caption = 'Retirar obrigatoriedade dos Grupo, Subgrupo'
          TabOrder = 3
        end
        object ListBox: TListBox
          Left = 452
          Top = 21
          Width = 241
          Height = 217
          ItemHeight = 13
          TabOrder = 4
        end
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 130
          Width = 438
          Height = 48
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          TabOrder = 5
          object Label4: TLabel
            Left = 0
            Top = 2
            Width = 28
            Height = 13
            Caption = 'Pre'#231'o'
          end
          object E_VL_Preco: TEdit_Setes
            Left = 0
            Top = 21
            Width = 113
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 233
    Width = 456
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      456
      65)
    object Gg_Progresso: TGauge
      Left = 5
      Top = 16
      Width = 271
      Height = 41
      Anchors = [akLeft, akRight, akBottom]
      Progress = 0
      ExplicitTop = 29
      ExplicitWidth = 210
    end
    object SB_Confirmar: TSpeedButton
      Left = 282
      Top = 6
      Width = 85
      Height = 55
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 228
    end
    object SB_Sair_0: TSpeedButton
      Left = 365
      Top = 5
      Width = 85
      Height = 55
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 311
    end
  end
  object Qr_Fornecedor: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  EMP_CODIGO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      'EMP_CODVDOR'
      'FROM TB_EMPRESA'
      'WHERE EMP_ATIVA = '#39'S'#39
      'ORDER BY EMP_NOME')
    Left = 316
    Top = 34
  end
  object Ds_Fornecedor: TDataSource
    DataSet = Qr_Fornecedor
    Left = 316
    Top = 81
  end
end
