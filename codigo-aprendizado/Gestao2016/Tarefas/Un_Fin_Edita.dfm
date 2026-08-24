object Fr_Fin_Edita: TFr_Fin_Edita
  Left = 373
  Top = 238
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Editar Registro do Financeiro'
  ClientHeight = 355
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 290
    Width = 516
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      516
      65)
    object SB_Gravar: TSpeedButton
      Left = 336
      Top = 5
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
      ExplicitLeft = 282
    end
    object Sb_Cancelar: TSpeedButton
      Left = 423
      Top = 5
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
      OnClick = Sb_CancelarClick
      ExplicitLeft = 369
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 516
    Height = 290
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label10: TLabel
      Left = 9
      Top = 4
      Width = 59
      Height = 14
      Caption = 'N'#186' Duplicata'
      FocusControl = E_N_Parcela
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 130
      Top = 4
      Width = 25
      Height = 14
      Caption = 'Valor'
      FocusControl = E_Vl_PARCELA
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 224
      Top = 4
      Width = 56
      Height = 14
      Caption = 'Vencimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 6
      Top = 134
      Width = 100
      Height = 14
      Caption = 'Observa'#231#227'o manual '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object sb_obs_nfe: TSpeedButton
      Left = 356
      Top = 254
      Width = 152
      Height = 27
      Caption = 'Observa'#231#245'es da Nota Fiscal'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      Transparent = False
      OnClick = sb_obs_nfeClick
    end
    object Label4: TLabel
      Left = 7
      Top = 42
      Width = 77
      Height = 14
      Caption = 'Reprograma'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_N_Parcela: TEdit
      Left = 6
      Top = 20
      Width = 117
      Height = 21
      MaxLength = 20
      TabOrder = 0
    end
    object E_Vl_PARCELA: TEdit_Setes
      Left = 126
      Top = 20
      Width = 91
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      Text = ''
    end
    object E_Data_Venc: TDateTimePicker
      Left = 221
      Top = 20
      Width = 100
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Obs: TMemo
      Left = 6
      Top = 148
      Width = 502
      Height = 103
      TabOrder = 5
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 318
      Top = 6
      Width = 194
      Height = 42
      TabOrder = 3
      ExplicitLeft = 318
      ExplicitTop = 6
      ExplicitWidth = 194
      ExplicitHeight = 42
      inherited Lb_FormaPagamento: TLabel
        Width = 188
      end
      inherited pnl_Forma: TPanel
        Width = 194
        Height = 28
        ExplicitWidth = 194
        ExplicitHeight = 28
        inherited SB_FormaPag: TSpeedButton
          Left = 168
          Height = 25
          ExplicitLeft = 168
          ExplicitHeight = 28
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 159
          ExplicitLeft = 0
          ExplicitTop = 14
          ExplicitWidth = 162
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 80
      Width = 505
      Height = 55
      Caption = 'Condi'#231#245'es especiais - Emiss'#227'o Duplicata'
      TabOrder = 4
      object Label1: TLabel
        Left = 5
        Top = 15
        Width = 43
        Height = 14
        Caption = 'Aliq Des.'
        FocusControl = E_Aliq_Desconto
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 58
        Top = 13
        Width = 52
        Height = 14
        Caption = 'Data Limite'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 152
        Top = 15
        Width = 100
        Height = 14
        Caption = 'Condi'#231#245'es Especiais'
        FocusControl = E_condicoesEspeciais
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Aliq_Desconto: TEdit_Setes
        Left = 3
        Top = 29
        Width = 53
        Height = 21
        Alignment = taRightJustify
        TabOrder = 0
        Text = ''
      end
      object E_DataLimite: TDateTimePicker
        Left = 58
        Top = 29
        Width = 91
        Height = 21
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object E_condicoesEspeciais: TEdit
        Left = 151
        Top = 29
        Width = 346
        Height = 21
        TabOrder = 2
      end
    end
    object E_Dt_Reprogramacao: TDateTimePicker
      Left = 6
      Top = 57
      Width = 102
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 6
    end
  end
  object Qr_Obs_Nfe: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT OBN_CODIGO, OBN_DETALHE FROM TB_OBS_NFE '
      'WHERE OBN_CODNFL=:OBN_CODNFL       '
      '  AND (OBN_TIPO = '#39'M'#39')            ')
    Left = 110
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OBN_CODNFL'
        ParamType = ptUnknown
      end>
  end
end
