object TasPrmStockTransfer: TTasPrmStockTransfer
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cofirma Transfer'#234'ncia'
  ClientHeight = 309
  ClientWidth = 591
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
  object pnl_EmitenteDestinatario: TPanel
    Left = 0
    Top = 0
    Width = 591
    Height = 76
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label8: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 581
      Height = 16
      Margins.Bottom = 10
      Align = alTop
      Alignment = taCenter
      Caption = 'informe os dados do Emitente/Destinat'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 280
    end
    inline Fm_ListaEmitenteDestinatario: TFm_ListaEmpresas
      Left = 2
      Top = 31
      Width = 587
      Height = 43
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 320
      ExplicitTop = 64
      ExplicitWidth = 587
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 587
        ExplicitWidth = 587
      end
      inherited pnl_02: TPanel
        Width = 587
        ExplicitWidth = 587
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 559
          ExplicitLeft = 559
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 534
          ExplicitLeft = 534
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 466
          ExplicitWidth = 464
        end
      end
    end
  end
  object pnl_Message: TPanel
    Left = 0
    Top = 76
    Width = 591
    Height = 166
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 49
    ExplicitWidth = 779
    ExplicitHeight = 192
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 149
      Width = 423
      Height = 13
      Align = alTop
      Caption = 
        '          Est'#225' tela ser'#225' fechada e assim poder'#225' baixar individua' +
        'lmente no modo tradicional.'
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 130
      Width = 246
      Height = 13
      Align = alTop
      Caption = '          O sistema prepara os dois pedidos de ajuste.'
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 108
      Width = 201
      Height = 16
      Margins.Left = 10
      Margins.Top = 10
      Align = alTop
      Caption = 'OP'#199#195'O 2 - Transfer'#234'ncia Fiscal.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 82
      Width = 224
      Height = 13
      Align = alTop
      Caption = '          N'#227'o ser'#225' feita nenhuma opera'#231#227'o fiscal.'
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 63
      Width = 293
      Height = 13
      Align = alTop
      Caption = '          Est'#225' op'#231#227'o registra Saida e entrada Automaticamente.'
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 41
      Width = 216
      Height = 16
      Margins.Left = 10
      Margins.Top = 10
      Align = alTop
      Caption = 'OP'#199#195'O 1 - Transfer'#234'ncia Interna.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 287
      Height = 16
      Margins.Bottom = 10
      Align = alTop
      Alignment = taCenter
      Caption = 'Para prosseguir temos as seguintes op'#231#245'es.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Pnl_Botton: TPanel
    Left = 0
    Top = 242
    Width = 591
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitLeft = -225
    ExplicitTop = 397
    ExplicitWidth = 1004
    object SB_Confirmar: TSpeedButton
      Left = 410
      Top = 2
      Width = 90
      Height = 63
      Align = alRight
      Caption = 'OP'#199#195'O 2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 817
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      Left = 500
      Top = 2
      Width = 89
      Height = 63
      Align = alRight
      Caption = 'Cancelar'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 919
      ExplicitTop = 6
    end
    object SB_Buscar: TSpeedButton
      Left = 318
      Top = 2
      Width = 92
      Height = 63
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alRight
      Caption = 'OP'#199#195'O 1'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_BuscarClick
      ExplicitLeft = 312
      ExplicitTop = 9
    end
  end
end
