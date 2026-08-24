object Fr_VehicleCheckList: TFr_VehicleCheckList
  Left = 250
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ChekList do Ve'#237'culo'
  ClientHeight = 561
  ClientWidth = 847
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
  object Panel1: TPanel
    Left = 398
    Top = 2
    Width = 448
    Height = 560
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label8: TLabel
      Left = 5
      Top = 324
      Width = 64
      Height = 14
      Caption = 'Kilometragem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 5
      Top = 246
      Width = 60
      Height = 14
      Caption = 'Observa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 164
      Top = 447
      Width = 111
      Height = 14
      Caption = 'Data e hora de Entrada'
      FocusControl = E_Dt_Entrada
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 309
      Top = 465
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F77777FFF333333009999900
        3333333777777777FF33330998FFF899033333777333F3777FF33099FFFCFFF9
        903337773337333777F3309FFFFFFFCF9033377333F3337377FF098FF0FFFFFF
        890377F3373F3333377F09FFFF0FFFFFF90377F3F373FFFFF77F09FCFFF90000
        F90377F733377777377F09FFFFFFFFFFF90377F333333333377F098FFFFFFFFF
        890377FF3F33333F3773309FCFFFFFCF9033377F7333F37377F33099FFFCFFF9
        90333777FF37F3377733330998FCF899033333777FF7FF777333333009999900
        3333333777777777333333333000003333333333377777333333}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
    object Label11: TLabel
      Left = 340
      Top = 447
      Width = 72
      Height = 14
      Caption = 'N'#250'mero Prisma'
      FocusControl = E_Nr_Prisma
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Km: TEdit_Setes
      Left = 5
      Top = 341
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'E_Km'
    end
    object GroupBox2: TGroupBox
      Left = 5
      Top = 5
      Width = 265
      Height = 125
      Caption = 'Situa'#231#227'o dos Pneus'
      TabOrder = 1
      object RG_PneuDianteiro: TRadioGroup
        Left = 5
        Top = 14
        Width = 84
        Height = 105
        Caption = 'Dianteiro'
        Items.Strings = (
          'Ruim'
          'Bom'
          'Excelente')
        TabOrder = 0
      end
      object RG_PneuTraseiro: TRadioGroup
        Left = 90
        Top = 14
        Width = 84
        Height = 105
        Caption = 'Traseiro'
        Items.Strings = (
          'Ruim'
          'Bom'
          'Excelente')
        TabOrder = 1
      end
      object RG_PneuEstepe: TRadioGroup
        Left = 175
        Top = 14
        Width = 84
        Height = 105
        Caption = 'Estepe'
        Items.Strings = (
          'Ruim'
          'Bom'
          'Excelente')
        TabOrder = 2
      end
    end
    object RG_Combustivel: TRadioGroup
      Left = 275
      Top = 5
      Width = 84
      Height = 125
      Caption = 'Combustivel'
      Items.Strings = (
        'Etanol'
        'Gasolina'
        'Flex'
        'Diesel'
        'G.N.V')
      TabOrder = 2
    end
    object GroupBox3: TGroupBox
      Left = 5
      Top = 131
      Width = 438
      Height = 115
      Caption = 'Acess'#243'rios e itens do Ve'#237'culo'
      TabOrder = 3
      object cbx_macaco: TCheckBox
        Left = 8
        Top = 16
        Width = 110
        Height = 17
        Caption = 'Macaco'
        TabOrder = 0
      end
      object cbx_manual: TCheckBox
        Left = 8
        Top = 31
        Width = 110
        Height = 17
        Caption = 'Manual'
        TabOrder = 1
      end
      object cbx_Extintor: TCheckBox
        Left = 8
        Top = 46
        Width = 110
        Height = 17
        Caption = 'Extintor'
        TabOrder = 2
      end
      object cbx_Radio: TCheckBox
        Left = 8
        Top = 61
        Width = 110
        Height = 17
        Caption = 'R'#225'dio'
        TabOrder = 3
      end
      object cbx_Abs: TCheckBox
        Left = 8
        Top = 76
        Width = 110
        Height = 17
        Caption = 'ABS'
        TabOrder = 4
      end
      object cbx_DirHidraulica: TCheckBox
        Left = 8
        Top = 91
        Width = 110
        Height = 17
        Caption = 'Dire'#231#227'o Hidr'#225'ulica'
        TabOrder = 5
      end
      object cbx_Calotas: TCheckBox
        Left = 321
        Top = 61
        Width = 110
        Height = 17
        Caption = 'Calotas'
        TabOrder = 6
      end
      object cbx_ArQuente: TCheckBox
        Left = 321
        Top = 76
        Width = 110
        Height = 17
        Caption = 'Ar Quente'
        TabOrder = 7
      end
      object cbx_triangulo: TCheckBox
        Left = 156
        Top = 16
        Width = 110
        Height = 17
        Caption = 'Tri'#226'ngulo'
        TabOrder = 8
      end
      object cbx_ChaveRoda: TCheckBox
        Left = 156
        Top = 31
        Width = 110
        Height = 17
        Caption = 'Chave de Roda'
        TabOrder = 9
      end
      object cbx_Antena: TCheckBox
        Left = 156
        Top = 46
        Width = 110
        Height = 17
        Caption = 'Antena'
        TabOrder = 10
      end
      object cbx_AcendCigarro: TCheckBox
        Left = 156
        Top = 61
        Width = 110
        Height = 17
        Caption = 'Acendedor Cigarro'
        TabOrder = 11
      end
      object cbx_ArCondicionado: TCheckBox
        Left = 156
        Top = 76
        Width = 110
        Height = 17
        Caption = 'Ar Condicionado'
        TabOrder = 12
      end
      object cbx_outros: TCheckBox
        Left = 321
        Top = 16
        Width = 110
        Height = 17
        Caption = 'Outros'
        TabOrder = 13
      end
      object cbx_Documentos: TCheckBox
        Left = 321
        Top = 31
        Width = 110
        Height = 17
        Caption = 'Documentos'
        TabOrder = 14
      end
      object cbx_Tapetes: TCheckBox
        Left = 321
        Top = 46
        Width = 110
        Height = 17
        Caption = 'Tapetes'
        TabOrder = 15
      end
    end
    object Rg_Valvulas: TRadioGroup
      Left = 361
      Top = 5
      Width = 81
      Height = 125
      Caption = 'N'#176' V'#225'lvulas'
      Items.Strings = (
        '08'
        '16'
        '20'
        '24')
      TabOrder = 4
    end
    object E_Obs: TMemo
      Left = 5
      Top = 262
      Width = 437
      Height = 61
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_Dt_Entrada: TMaskEdit
      Left = 163
      Top = 464
      Width = 83
      Height = 22
      Color = clHighlightText
      EditMask = '!99/99/0000;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 6
      Text = '  /  /    '
    end
    object E_Hr_Entrada: TMaskEdit
      Left = 249
      Top = 464
      Width = 55
      Height = 22
      Color = clHighlightText
      EditMask = '00:00;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    object Panel2: TPanel
      Left = 2
      Top = 494
      Width = 444
      Height = 64
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 8
      DesignSize = (
        444
        64)
      object SB_Gravar: TSpeedButton
        Left = 266
        Top = 5
        Width = 85
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
      end
      object SB_Cancelar: TSpeedButton
        Left = 351
        Top = 5
        Width = 85
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
      end
    end
    object GroupBox4: TGroupBox
      Left = 6
      Top = 386
      Width = 120
      Height = 105
      Caption = 'Legenda Inspe'#231#227'o'
      TabOrder = 9
      object Label1: TLabel
        Left = 11
        Top = 22
        Width = 15
        Height = 15
        AutoSize = False
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 11
        Top = 41
        Width = 15
        Height = 15
        AutoSize = False
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 33
        Top = 20
        Width = 51
        Height = 16
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 33
        Top = 41
        Width = 59
        Height = 16
        Caption = 'Riscado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 11
        Top = 61
        Width = 15
        Height = 15
        AutoSize = False
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 33
        Top = 62
        Width = 70
        Height = 16
        Caption = 'Quebrado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 11
        Top = 81
        Width = 15
        Height = 15
        AutoSize = False
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label10: TLabel
        Left = 34
        Top = 81
        Width = 75
        Height = 16
        Caption = 'Amassado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object E_Nr_Prisma: TEdit_Setes
      Left = 335
      Top = 464
      Width = 106
      Height = 22
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = ''
    end
  end
  object GroupBox1: TPanel
    Left = -3
    Top = -1
    Width = 399
    Height = 564
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'GroupBox1'
    TabOrder = 1
    object carro_10: TImage
      Left = 147
      Top = 174
      Width = 104
      Height = 199
      Hint = 'N'
      AutoSize = True
      OnClick = carro_10Click
    end
    object carro_01: TImage
      Left = 3
      Top = 2
      Width = 394
      Height = 24
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_01Click
    end
    object carro_02: TImage
      Left = 3
      Top = 26
      Width = 77
      Height = 33
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_02Click
    end
    object carro_03: TImage
      Left = 80
      Top = 26
      Width = 67
      Height = 33
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_03Click
    end
    object carro_04: TImage
      Left = 147
      Top = 26
      Width = 104
      Height = 148
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_04Click
    end
    object carro_05: TImage
      Left = 251
      Top = 26
      Width = 66
      Height = 33
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_05Click
    end
    object carro_12: TImage
      Left = 3
      Top = 273
      Width = 144
      Height = 100
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_12Click
    end
    object carro_13: TImage
      Left = 251
      Top = 273
      Width = 146
      Height = 100
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_13Click
    end
    object carro_14: TImage
      Left = 3
      Top = 373
      Width = 149
      Height = 117
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_14Click
    end
    object carro_15: TImage
      Left = 152
      Top = 373
      Width = 91
      Height = 117
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_15Click
    end
    object carro_16: TImage
      Left = 243
      Top = 373
      Width = 154
      Height = 117
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_16Click
    end
    object carro_06: TImage
      Left = 317
      Top = 26
      Width = 80
      Height = 33
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_06Click
    end
    object carro_07: TImage
      Left = 3
      Top = 59
      Width = 144
      Height = 115
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_07Click
    end
    object carro_08: TImage
      Left = 251
      Top = 59
      Width = 146
      Height = 115
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_08Click
    end
    object carro_09: TImage
      Left = 3
      Top = 174
      Width = 144
      Height = 99
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_09Click
    end
    object carro_17: TImage
      Left = 3
      Top = 490
      Width = 80
      Height = 40
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_17Click
    end
    object carro_18: TImage
      Left = 83
      Top = 490
      Width = 71
      Height = 40
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_18Click
    end
    object carro_19: TImage
      Left = 154
      Top = 490
      Width = 87
      Height = 40
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_19Click
    end
    object carro_20: TImage
      Left = 241
      Top = 490
      Width = 73
      Height = 40
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_20Click
    end
    object carro_21: TImage
      Left = 314
      Top = 490
      Width = 83
      Height = 40
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_21Click
    end
    object carro_11: TImage
      Left = 251
      Top = 174
      Width = 146
      Height = 99
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_11Click
    end
    object carro_22: TImage
      Left = 3
      Top = 530
      Width = 394
      Height = 32
      Hint = 'N'
      AutoSize = True
      Center = True
      OnClick = carro_22Click
    end
  end
  object fACBrDownload: TACBrDownload
    SizeRecvBuffer = 0
    Proxy.ProxyTimeout = 90000
    FTP.FtpTimeout = 300000
    Left = 558
    Top = 354
  end
end
