object fr_info_baixa_lote: Tfr_info_baixa_lote
  Left = 506
  Top = 171
  Caption = 'Informa'#231#227'o Baixa Lote'
  ClientHeight = 215
  ClientWidth = 558
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 154
    Width = 558
    Height = 61
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      558
      61)
    object SB_Gravar: TSpeedButton
      Left = 378
      Top = 5
      Width = 87
      Height = 52
      Anchors = [akRight, akBottom]
      Caption = 'Confirmar- F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_GravarClick
    end
    object Sb_Cancelar: TSpeedButton
      Left = 465
      Top = 5
      Width = 87
      Height = 52
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
  end
  object pnl_fundos: TPanel
    Left = 0
    Top = 0
    Width = 558
    Height = 154
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label2: TLabel
      Left = 5
      Top = 8
      Width = 113
      Height = 13
      Caption = 'Data de Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_Data_Pag: TDateTimePicker
      Left = 5
      Top = 25
      Width = 113
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
      Left = 2
      Top = 48
      Width = 554
      Height = 41
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 48
      ExplicitHeight = 41
      inherited Sb_ContaBancaria: TSpeedButton
        Height = 26
      end
    end
  end
end
