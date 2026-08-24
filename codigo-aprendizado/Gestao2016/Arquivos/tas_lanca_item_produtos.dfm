object TasLancaItemProdutos: TTasLancaItemProdutos
  Left = 315
  Top = 256
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Lan'#231'a Itens'
  ClientHeight = 157
  ClientWidth = 652
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 157
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 155
    DesignSize = (
      652
      157)
    object Label1: TLabel
      Left = 6
      Top = 46
      Width = 83
      Height = 13
      Caption = 'Nome do Produto'
      FocusControl = E_Produto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 7
      Top = 7
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = E_CodPro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SB_Gravar: TBitBtn
      Left = 410
      Top = 98
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F5'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 2
      OnClick = SB_GravarClick
      ExplicitTop = 96
    end
    object Sb_Pesquisar: TBitBtn
      Left = 488
      Top = 98
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Pesquisar- F7'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 3
      OnClick = Sb_PesquisarClick
      OnMouseMove = Sb_PesquisarMouseMove
      ExplicitTop = 96
    end
    object Sb_Sair_0: TBitBtn
      Left = 566
      Top = 98
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- Esc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      TabOrder = 4
      OnClick = Sb_Sair_0Click
      ExplicitTop = 96
    end
    object E_CodPro: TEdit
      Left = 6
      Top = 23
      Width = 115
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
    object E_Produto: TEdit
      Left = 6
      Top = 61
      Width = 638
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnEnter = E_ProdutoEner
      OnExit = E_ProdutoExit
    end
  end
end
