object Fr_Composicao: TFr_Composicao
  Left = 263
  Top = 205
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Composi'#231#227'o'
  ClientHeight = 117
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 52
    Width = 664
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitTop = 45
    object SB_Gravar: TBitBtn
      AlignWithMargins = True
      Left = 421
      Top = 5
      Width = 78
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Gravar - F5'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 0
      OnClick = SB_GravarClick
      ExplicitLeft = 415
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Pesquisar: TBitBtn
      AlignWithMargins = True
      Left = 501
      Top = 5
      Width = 78
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Pesquisar- F7'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 1
      OnClick = Sb_PesquisarClick
      OnMouseMove = Sb_PesquisarMouseMove
      ExplicitLeft = 493
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Sair_0: TBitBtn
      AlignWithMargins = True
      Left = 581
      Top = 5
      Width = 78
      Height = 55
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair- Esc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 2
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 571
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 664
    Height = 52
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitHeight = 225
    object Label4: TLabel
      Left = 89
      Top = 4
      Width = 111
      Height = 13
      Caption = 'Descri'#231#227'o da opera'#231#227'o'
      FocusControl = E_Descricao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 576
      Top = 5
      Width = 55
      Height = 13
      Caption = 'Quantidade'
      FocusControl = E_Qtde
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 9
      Top = 4
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = E_Descricao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 87
      Top = 19
      Width = 487
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnEnter = E_DescricaoEnter
      OnExit = E_DescricaoExit
    end
    object E_Qtde: TEdit_Setes
      Left = 575
      Top = 19
      Width = 82
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
      OnEnter = E_QtdeEnter
      OnExit = E_QtdeExit
    end
    object E_CodPro: TEdit
      Left = 6
      Top = 19
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = E_CodProEnter
      OnExit = E_CodProExit
    end
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Estoque
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 320
    Top = 24
  end
end
