inherited Fr_Lanca_PlanoContas: TFr_Lanca_PlanoContas
  Left = 333
  Top = 183
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Lan'#231'amento de Contas Contabeis / Gerencial'
  ClientHeight = 252
  ClientWidth = 460
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 466
  ExplicitHeight = 301
  PixelsPerInch = 96
  TextHeight = 13
  object Panel8: TPanel [0]
    Left = 0
    Top = 0
    Width = 460
    Height = 187
    Align = alClient
    Alignment = taRightJustify
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Lb_Instrucao: TLabel
      Left = 8
      Top = 5
      Width = 449
      Height = 45
      AutoSize = False
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    inline Fm_CentroCusto: TFm_CentroCusto
      Left = 3
      Top = 41
      Width = 450
      Height = 71
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 41
      ExplicitHeight = 71
      inherited Grb_Cta_CentroCusto: TGroupBox
        Height = 71
        ExplicitHeight = 71
      end
    end
    inline Fm_CentroResultado: TFm_CentroResultado
      Left = 6
      Top = 114
      Width = 451
      Height = 71
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 6
      ExplicitTop = 114
      ExplicitHeight = 71
      inherited Grb_Cta_Resultado: TGroupBox
        Height = 71
        ExplicitHeight = 71
        inherited E_Codigo_Plano: TEdit_Setes
          OnExit = nil
        end
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 187
    Width = 460
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      460
      65)
    object SB_Gravar: TSpeedButton
      Left = 280
      Top = 6
      Width = 87
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
      OnClick = SB_GravarClick
      ExplicitLeft = 290
    end
    object SB_Cancelar: TSpeedButton
      Left = 367
      Top = 6
      Width = 87
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
      OnClick = SB_CancelarClick
      ExplicitLeft = 377
    end
  end
end
