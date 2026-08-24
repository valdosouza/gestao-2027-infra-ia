object Fr_Crm: TFr_Crm
  Left = 303
  Top = 146
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Qualificar Clientes'
  ClientHeight = 457
  ClientWidth = 789
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
  OnShow = FormShow
  DesignSize = (
    789
    457)
  PixelsPerInch = 96
  TextHeight = 13
  object SB_Qualificar: TSpeedButton
    Left = 473
    Top = 412
    Width = 78
    Height = 41
    Anchors = [akRight, akBottom]
    Caption = 'Qualificar - F3'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
      333333333337FF3333333333330003333333333333777F333333333333080333
      3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
      33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
      B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
      BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
      B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
      3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
      333333333337F33333333333333B333333333333333733333333}
    Layout = blGlyphTop
    NumGlyphs = 2
    ParentFont = False
    OnClick = SB_QualificarClick
  end
  object SB_Sair: TSpeedButton
    Left = 707
    Top = 412
    Width = 78
    Height = 41
    Anchors = [akRight, akBottom]
    Caption = 'Sair - Esc'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301111111110333337F333333337F33330111111111
      0333337F333333337F333301111111110333337F333333337F33330111111111
      0333337F333333337F333301111111110333337F333333337F33330111111111
      0333337F3333333F7F333301111111B10333337F333333737F33330111111111
      0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
      0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
      0333337F377777337F333301111111110333337F333333337F33330111111111
      0333337FFFFFFFFF7F3333000000000003333377777777777333}
    Layout = blGlyphTop
    NumGlyphs = 2
    ParentFont = False
    OnClick = SB_SairClick
  end
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 789
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'CRM - Gerenciamento de Relacionamento com Clientes'
    Color = clActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ExplicitWidth = 522
  end
  object Sb_Imprimir: TSpeedButton
    Left = 629
    Top = 412
    Width = 78
    Height = 41
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir - F5'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    Layout = blGlyphTop
    NumGlyphs = 2
    ParentFont = False
    OnClick = Sb_ImprimirClick
  end
  object Lb_Status: TLabel
    Left = 4
    Top = 437
    Width = 70
    Height = 16
    Caption = 'Conclu'#237'do'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sb_analise: TSpeedButton
    Left = 395
    Top = 412
    Width = 78
    Height = 41
    Anchors = [akRight, akBottom]
    Caption = 'Analisar - F2'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      033333777777777773333330777777703333333773F333773333333330888033
      33333FFFF7FFF7FFFFFF0000000000000003777777777777777F0FFFFFFFFFF9
      FF037F3333333337337F0F78888888887F037F33FFFFFFFFF37F0F7000000000
      8F037F3777777777F37F0F70AAAAAAA08F037F37F3333337F37F0F70ADDDDDA0
      8F037F37F3333337F37F0F70A99A99A08F037F37F3333337F37F0F70A99A99A0
      8F037F37F3333337F37F0F70AAAAAAA08F037F37FFFFFFF7F37F0F7000000000
      8F037F3777777777337F0F77777777777F037F3333333333337F0FFFFFFFFFFF
      FF037FFFFFFFFFFFFF7F00000000000000037777777777777773}
    Layout = blGlyphTop
    NumGlyphs = 2
    ParentFont = False
    OnClick = sb_analiseClick
  end
  object sb_atualizar: TSpeedButton
    Left = 551
    Top = 412
    Width = 78
    Height = 41
    Anchors = [akRight, akBottom]
    Caption = 'Atualizar - F4'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333FF3FFFF3FFF33FF003000030003
      300077377773777F377703330033370337037FFF77F3377FF77F700007333300
      0003777777333377777F303003333330370337F77F333337377F303073333333
      070337F77F333333777F3700733333333003377773333333377F330033333333
      30033377F3333333377F33073333333333033377333333333373333333333333
      33333333FF3333333FF3333973333333793333377FF3333377F3333999333339
      993333377733333777F33339933333339933333773FF333377F3333939733379
      39333337377FFF77373333333399999333333333337777733333}
    Layout = blGlyphTop
    NumGlyphs = 2
    ParentFont = False
    OnClick = sb_atualizarClick
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 40
    Width = 377
    Height = 66
    Caption = 'Qualificar clientes com base no per'#237'odo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 10
      Top = 33
      Width = 17
      Height = 13
      Caption = 'De'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 186
      Top = 34
      Width = 20
      Height = 13
      Caption = 'At'#233
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object E_DataIni: TDateTimePicker
      Left = 32
      Top = 27
      Width = 145
      Height = 24
      Date = 39137.000318819440000000
      Time = 39137.000318819440000000
      TabOrder = 0
    end
    object E_DataFim: TDateTimePicker
      Left = 215
      Top = 27
      Width = 145
      Height = 24
      Date = 39137.000318819440000000
      Time = 39137.000318819440000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 3
    Top = 283
    Width = 187
    Height = 150
    Caption = 'Classifica'#231#227'o Manual'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label15: TLabel
      Left = 83
      Top = 16
      Width = 95
      Height = 13
      AutoSize = False
      Caption = 'Consumo At'#233
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 10
      Top = 35
      Width = 77
      Height = 13
      AutoSize = False
      Caption = '1 Estrela   :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 11
      Top = 58
      Width = 77
      Height = 13
      AutoSize = False
      Caption = '2 Estrelas :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 11
      Top = 80
      Width = 77
      Height = 13
      AutoSize = False
      Caption = '3 Estrelas :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label13: TLabel
      Left = 11
      Top = 102
      Width = 77
      Height = 13
      AutoSize = False
      Caption = '4 Estrelas :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label14: TLabel
      Left = 11
      Top = 124
      Width = 77
      Height = 13
      AutoSize = False
      Caption = '5 Estrelas :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object E_Vl_Manual_1: TEdit_Setes
      Left = 90
      Top = 32
      Width = 90
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 0
      Text = '0,00'
    end
    object E_Vl_Manual_2: TEdit_Setes
      Left = 90
      Top = 54
      Width = 90
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 1
      Text = '0,00'
    end
    object E_Vl_Manual_3: TEdit_Setes
      Left = 90
      Top = 76
      Width = 90
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 2
      Text = '0,00'
    end
    object E_Vl_Manual_4: TEdit_Setes
      Left = 90
      Top = 98
      Width = 90
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 3
      Text = '0,00'
    end
    object E_Vl_Manual_5: TEdit_Setes
      Left = 90
      Top = 120
      Width = 90
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 4
      Text = '0,00'
    end
  end
  object GroupBox5: TGroupBox
    Left = 4
    Top = 112
    Width = 389
    Height = 170
    Caption = 'Avalia'#231#227'o Geral'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object GroupBox2: TGroupBox
      Left = 5
      Top = 18
      Width = 189
      Height = 147
      Caption = 'Classifica'#231#227'o Sistema'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label4: TLabel
        Left = 10
        Top = 35
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '1 Estrela   :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 11
        Top = 58
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '2 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 11
        Top = 80
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '3 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 11
        Top = 102
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '4 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 11
        Top = 124
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '5 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 87
        Top = 16
        Width = 95
        Height = 13
        AutoSize = False
        Caption = 'Consumo At'#233
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object E_Vl_Sistema_1: TEdit_Setes
        Left = 89
        Top = 32
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 0
        Text = '0,00'
      end
      object E_Vl_Sistema_2: TEdit_Setes
        Left = 89
        Top = 54
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 1
        Text = '0,00'
      end
      object E_Vl_Sistema_3: TEdit_Setes
        Left = 89
        Top = 76
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 2
        Text = '0,00'
      end
      object E_Vl_Sistema_4: TEdit_Setes
        Left = 89
        Top = 98
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 3
        Text = '0,00'
      end
      object E_Vl_Sistema_5: TEdit_Setes
        Left = 89
        Top = 120
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 4
        Text = '0,00'
      end
    end
    object GroupBox4: TGroupBox
      Left = 196
      Top = 18
      Width = 189
      Height = 147
      Caption = 'Segmenta'#231#227'o Clientes'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label21: TLabel
        Left = 83
        Top = 16
        Width = 95
        Height = 13
        AutoSize = False
        Caption = 'Quantidade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label16: TLabel
        Left = 10
        Top = 35
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '1 Estrela   :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 11
        Top = 58
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '2 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label18: TLabel
        Left = 11
        Top = 80
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '3 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label19: TLabel
        Left = 11
        Top = 102
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '4 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label20: TLabel
        Left = 11
        Top = 124
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '5 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object E_Qt_Sistema_1: TEdit_Setes
        Left = 89
        Top = 32
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 0
        Text = '0,00'
      end
      object E_Qt_Sistema_2: TEdit_Setes
        Left = 89
        Top = 54
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 1
        Text = '0,00'
      end
      object E_Qt_Sistema_3: TEdit_Setes
        Left = 89
        Top = 76
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 2
        Text = '0,00'
      end
      object E_Qt_Sistema_4: TEdit_Setes
        Left = 89
        Top = 98
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 3
        Text = '0,00'
      end
      object E_Qt_Sistema_5: TEdit_Setes
        Left = 89
        Top = 120
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 4
        Text = '0,00'
      end
    end
  end
  object GroupBox6: TGroupBox
    Left = 396
    Top = 112
    Width = 389
    Height = 170
    Caption = 'Avalia'#231#227'o do Per'#237'odo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object GroupBox7: TGroupBox
      Left = 5
      Top = 18
      Width = 189
      Height = 147
      Caption = 'Classifica'#231#227'o Sistema'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label23: TLabel
        Left = 10
        Top = 35
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '1 Estrela   :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label24: TLabel
        Left = 11
        Top = 58
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '2 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label25: TLabel
        Left = 11
        Top = 80
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '3 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label26: TLabel
        Left = 11
        Top = 102
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '4 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label27: TLabel
        Left = 11
        Top = 124
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '5 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label28: TLabel
        Left = 87
        Top = 16
        Width = 95
        Height = 13
        AutoSize = False
        Caption = 'Consumo At'#233
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object E_Vl_Periodo_1: TEdit_Setes
        Left = 89
        Top = 32
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 0
        Text = '0,00'
      end
      object E_Vl_Periodo_2: TEdit_Setes
        Left = 89
        Top = 54
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 1
        Text = '0,00'
      end
      object E_Vl_Periodo_3: TEdit_Setes
        Left = 89
        Top = 76
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 2
        Text = '0,00'
      end
      object E_Vl_Periodo_4: TEdit_Setes
        Left = 89
        Top = 98
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 3
        Text = '0,00'
      end
      object E_Vl_Periodo_5: TEdit_Setes
        Left = 89
        Top = 120
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 4
        Text = '0,00'
      end
    end
    object GroupBox8: TGroupBox
      Left = 196
      Top = 18
      Width = 189
      Height = 147
      Caption = 'Segmenta'#231#227'o Clientes'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label29: TLabel
        Left = 83
        Top = 16
        Width = 95
        Height = 13
        AutoSize = False
        Caption = 'Quantidade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label30: TLabel
        Left = 10
        Top = 35
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '1 Estrela   :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label31: TLabel
        Left = 11
        Top = 58
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '2 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label32: TLabel
        Left = 11
        Top = 80
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '3 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label33: TLabel
        Left = 11
        Top = 102
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '4 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label34: TLabel
        Left = 11
        Top = 124
        Width = 77
        Height = 13
        AutoSize = False
        Caption = '5 Estrelas :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object E_Qt_Periodo_1: TEdit_Setes
        Left = 89
        Top = 32
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 0
        Text = '0,00'
      end
      object E_Qt_Periodo_2: TEdit_Setes
        Left = 89
        Top = 54
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 1
        Text = '0,00'
      end
      object E_Qt_Periodo_3: TEdit_Setes
        Left = 89
        Top = 76
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 2
        Text = '0,00'
      end
      object E_Qt_Periodo_4: TEdit_Setes
        Left = 89
        Top = 98
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 3
        Text = '0,00'
      end
      object E_Qt_Periodo_5: TEdit_Setes
        Left = 89
        Top = 120
        Width = 92
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        TabOrder = 4
        Text = '0,00'
      end
    end
  end
  object Panel1: TPanel
    Left = 194
    Top = 290
    Width = 593
    Height = 46
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object ChBx_TabManual: TCheckBox
      Left = 5
      Top = 4
      Width = 234
      Height = 21
      Caption = 'Qualificar pela Tabela Manual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = ChBx_TabManualClick
    end
    object ChBx_TabAuto: TCheckBox
      Left = 5
      Top = 23
      Width = 355
      Height = 21
      Caption = 'Qualificar pela Tabela de Avalia'#231#227'o do Per'#237'odo'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      OnClick = ChBx_TabAutoClick
    end
  end
  object Panel2: TPanel
    Left = 194
    Top = 338
    Width = 593
    Height = 67
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel2'
    TabOrder = 5
    object ChBx_ClienteMovim: TCheckBox
      Left = 7
      Top = 25
      Width = 347
      Height = 21
      Caption = 'Qualificar apenas para os Clientes do Per'#237'odo.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      WordWrap = True
    end
    object ChBx_RelPos: TCheckBox
      Left = 7
      Top = 44
      Width = 566
      Height = 21
      Caption = 
        'Ap'#243's qualificar clientes imprimir relat'#243'rio com resumo de opera'#231 +
        #245'es.'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      WordWrap = True
    end
    object ChBx_ClassGeral: TCheckBox
      Left = 7
      Top = 5
      Width = 234
      Height = 21
      Caption = 'Atualizar Classifica'#231#227'o Geral'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object Qr_Vendas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT NFL_CODEMP, SUM(NFL_VL_TL_NOTA) TOTAL'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '    INNER JOIN TB_PEDIDO tb_pedido'
      '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      'WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = 1)'
      'GROUP BY NFL_CODEMP')
    Left = 192
    Top = 424
  end
  object Qr_Tabela: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CRM_CLASSES'
      'ORDER BY CRM_CODIGO')
    Left = 224
    Top = 424
  end
  object Qr_ZeraEstrela: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE TB_EMPRESA'
      'SET EMP_CLASSE = NULL')
    Left = 256
    Top = 424
  end
end
