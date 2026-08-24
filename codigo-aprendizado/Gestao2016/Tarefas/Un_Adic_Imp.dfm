object Fr_Adic_Imp: TFr_Adic_Imp
  Left = 188
  Top = 69
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Detalhes da Adi'#231#227'o'
  ClientHeight = 194
  ClientWidth = 392
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
  object Pnl_Fundos: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 130
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 64
      Top = 5
      Width = 88
      Height = 14
      Caption = 'N'#250'mero da Adi'#231#227'o'
      FocusControl = E_Numero
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 4
      Top = 87
      Width = 89
      Height = 14
      Caption = 'Valor do Desconto'
      FocusControl = E_Vl_Desconto
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 101
      Top = 88
      Width = 127
      Height = 14
      Caption = 'N'#250'mero Pedido de Compra'
      FocusControl = E_Nr_Pedido
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 238
      Top = 89
      Width = 124
      Height = 14
      Caption = 'Item do Pedido de Compra'
      FocusControl = E_Item_Cpa
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 200
      Top = 5
      Width = 102
      Height = 14
      Caption = 'Sequ'#234'ncia da Adi'#231#227'o'
      FocusControl = E_Sequencia
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Codigo: TEdit
      Left = 5
      Top = 21
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object E_Numero: TEdit
      Left = 64
      Top = 21
      Width = 134
      Height = 21
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = E_NumeroKeyPress
    end
    object E_Vl_Desconto: TEdit
      Left = 4
      Top = 103
      Width = 94
      Height = 21
      TabOrder = 4
    end
    object E_Nr_Pedido: TEdit
      Left = 101
      Top = 104
      Width = 134
      Height = 21
      TabOrder = 5
    end
    object E_Item_Cpa: TEdit
      Left = 238
      Top = 105
      Width = 129
      Height = 21
      TabOrder = 6
    end
    object E_Sequencia: TEdit
      Left = 200
      Top = 21
      Width = 105
      Height = 21
      TabOrder = 2
    end
    inline Fm_ListaFornecedores: TFm_ListaFornecedores
      Left = 5
      Top = 45
      Width = 385
      Height = 39
      TabOrder = 3
      ExplicitLeft = 5
      ExplicitTop = 45
      ExplicitWidth = 385
      inherited pnl_01: TPanel
        Width = 385
        ExplicitWidth = 385
        inherited ChBx_Nome: TCheckBox
          Left = 42
          ExplicitLeft = 42
          ExplicitTop = 1
          ExplicitHeight = 14
        end
        inherited ChBx_Fantasia: TCheckBox
          Left = 168
          ExplicitLeft = 168
          ExplicitTop = 1
          ExplicitHeight = 14
        end
      end
      inherited pnl_02: TPanel
        Width = 385
        ExplicitWidth = 385
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 357
          ExplicitLeft = 357
        end
        inherited SB_Empresas: TSpeedButton
          Left = 332
          ExplicitLeft = 332
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitLeft = 1
          ExplicitTop = 1
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 264
          ExplicitLeft = 66
          ExplicitTop = 1
          ExplicitWidth = 264
        end
      end
    end
  end
  object pnl_botoes: TPanel
    Left = 0
    Top = 130
    Width = 392
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      392
      64)
    object SB_Gravar: TSpeedButton
      Left = 222
      Top = 6
      Width = 78
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
      OnClick = SB_GravarClick
      ExplicitLeft = 202
    end
    object SB_Cancelar: TSpeedButton
      Left = 306
      Top = 5
      Width = 78
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
      OnClick = SB_CancelarClick
      ExplicitLeft = 286
    end
  end
end
