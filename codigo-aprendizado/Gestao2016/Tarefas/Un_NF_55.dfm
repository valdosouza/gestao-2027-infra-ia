object Fr_NF_55: TFr_NF_55
  Left = 185
  Top = 90
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o - Notas Fiscais'
  ClientHeight = 528
  ClientWidth = 884
  Color = clBtnFace
  Constraints.MinHeight = 577
  Constraints.MinWidth = 667
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Operacao
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 466
    Width = 884
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      884
      62)
    object Sb_Sair_0: TSpeedButton
      Left = 787
      Top = 4
      Width = 92
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
    end
  end
  object Pg_Notas: TPageControl
    Left = 0
    Top = 0
    Width = 884
    Height = 466
    ActivePage = tbs_nota
    Align = alClient
    TabOrder = 1
    object tbs_nota: TTabSheet
      Caption = 'Dados da Nota'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pnl_Cliente: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 438
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          Left = 478
          Top = 3
          Width = 68
          Height = 14
          Caption = 'Nota Fiscal N'#186
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 6
          Top = 3
          Width = 110
          Height = 14
          Caption = 'Natureza da Opera'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label39: TLabel
          Left = 592
          Top = 3
          Width = 87
          Height = 14
          Caption = 'N'#250'mero do Pedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object GroupBox2: TGroupBox
          Left = 4
          Top = 40
          Width = 745
          Height = 131
          Caption = ' Destinat'#225'rio / Rementente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label25: TLabel
            Left = 7
            Top = 14
            Width = 63
            Height = 14
            Caption = 'Raz'#227'o Social'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 432
            Top = 14
            Width = 68
            Height = 14
            Caption = 'C.N.P.J / C.P.F.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 7
            Top = 50
            Width = 46
            Height = 14
            Caption = 'Endere'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label28: TLabel
            Left = 491
            Top = 50
            Width = 29
            Height = 14
            Caption = 'Bairro'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label29: TLabel
            Left = 664
            Top = 50
            Width = 19
            Height = 14
            Caption = 'CEP'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 7
            Top = 88
            Width = 33
            Height = 14
            Caption = 'Cidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 397
            Top = 88
            Width = 24
            Height = 14
            Caption = 'Fone'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label32: TLabel
            Left = 351
            Top = 88
            Width = 33
            Height = 14
            Caption = 'Estado'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label33: TLabel
            Left = 585
            Top = 14
            Width = 88
            Height = 14
            Caption = 'Inscri'#231#227'o Estadual'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_RazaoSocial: TEdit
            Left = 5
            Top = 28
            Width = 422
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object E_Cnpj_CPf: TEdit
            Left = 429
            Top = 28
            Width = 151
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object E_Endereco: TEdit
            Left = 7
            Top = 65
            Width = 480
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object E_Bairro: TEdit
            Left = 489
            Top = 65
            Width = 170
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object E_Cep: TEdit
            Left = 662
            Top = 65
            Width = 77
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object E_Cidade: TEdit
            Left = 7
            Top = 102
            Width = 338
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object E_Fone: TEdit
            Left = 395
            Top = 102
            Width = 92
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object E_Estado: TEdit
            Left = 347
            Top = 102
            Width = 44
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
          end
          object E_Insc_Est: TEdit
            Left = 583
            Top = 28
            Width = 154
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
        end
        object GroupBox3: TGroupBox
          Left = 621
          Top = 191
          Width = 115
          Height = 132
          Caption = ' Data Limite '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Label6: TLabel
            Left = 6
            Top = 16
            Width = 80
            Height = 14
            Caption = 'Data da Emiss'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 5
            Top = 68
            Width = 67
            Height = 14
            Caption = 'Data da Sa'#237'da'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Dt_Emissao: TEdit
            Left = 5
            Top = 32
            Width = 104
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object E_Dt_Saida: TEdit
            Left = 5
            Top = 83
            Width = 103
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
        end
        object E_Nr_Nota: TEdit
          Left = 477
          Top = 18
          Width = 112
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object E_Natureza: TEdit
          Left = 4
          Top = 18
          Width = 470
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object E_Vl_Total: TEdit_Setes
          Left = 591
          Top = 18
          Width = 111
          Height = 22
          Alignment = taRightJustify
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = ''
        end
        object GroupBox1: TGroupBox
          Left = 4
          Top = 172
          Width = 584
          Height = 131
          Caption = 'Transportadora'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object Label5: TLabel
            Left = 7
            Top = 14
            Width = 63
            Height = 14
            Caption = 'Raz'#227'o Social'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 432
            Top = 14
            Width = 68
            Height = 14
            Caption = 'C.N.P.J / C.P.F.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label34: TLabel
            Left = 7
            Top = 50
            Width = 46
            Height = 14
            Caption = 'Endere'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label37: TLabel
            Left = 331
            Top = 50
            Width = 29
            Height = 14
            Caption = 'Bairro'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label44: TLabel
            Left = 504
            Top = 50
            Width = 19
            Height = 14
            Caption = 'CEP'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label45: TLabel
            Left = 7
            Top = 88
            Width = 33
            Height = 14
            Caption = 'Cidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label46: TLabel
            Left = 287
            Top = 88
            Width = 24
            Height = 14
            Caption = 'Fone'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label47: TLabel
            Left = 383
            Top = 88
            Width = 33
            Height = 14
            Caption = 'Estado'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label48: TLabel
            Left = 428
            Top = 88
            Width = 88
            Height = 14
            Caption = 'Inscri'#231#227'o Estadual'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Edit1: TEdit
            Left = 5
            Top = 28
            Width = 422
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object Edit2: TEdit
            Left = 429
            Top = 28
            Width = 152
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object Edit3: TEdit
            Left = 7
            Top = 65
            Width = 321
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object Edit4: TEdit
            Left = 329
            Top = 65
            Width = 170
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object Edit5: TEdit
            Left = 502
            Top = 65
            Width = 80
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object Edit6: TEdit
            Left = 7
            Top = 102
            Width = 278
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object Edit7: TEdit
            Left = 285
            Top = 102
            Width = 92
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object Edit8: TEdit
            Left = 379
            Top = 102
            Width = 44
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
          end
          object Edit9: TEdit
            Left = 426
            Top = 102
            Width = 154
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
        end
        object Panel3: TPanel
          Left = 2
          Top = 308
          Width = 872
          Height = 128
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 6
          object Label8: TLabel
            Left = 5
            Top = 4
            Width = 94
            Height = 12
            Caption = 'Base C'#225'lculo do ICMS'
            FocusControl = E_Bs_Icms
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 147
            Top = 4
            Width = 59
            Height = 12
            Caption = 'Valor do ICMS'
            FocusControl = E_Vl_Icms
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 283
            Top = 4
            Width = 111
            Height = 12
            Caption = 'Base C'#225'lculo ICMS Subst.'
            FocusControl = E_Bs_Icms_St
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 422
            Top = 4
            Width = 100
            Height = 12
            Caption = 'Valor ICMS Substitui'#231#227'o'
            FocusControl = E_Vl_Icms_St
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 6
            Top = 39
            Width = 58
            Height = 12
            Caption = 'Valor do Frete'
            FocusControl = E_Vl_frete
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 120
            Top = 39
            Width = 65
            Height = 12
            Caption = 'Valor do Seguro'
            FocusControl = E_Vl_Seguro
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 228
            Top = 39
            Width = 119
            Height = 12
            Caption = 'Outras despesas acess'#243'rias'
            FocusControl = E_Vl_Outras
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 351
            Top = 39
            Width = 48
            Height = 12
            Caption = 'Valor do IPI'
            FocusControl = E_Vl_IPI
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label16: TLabel
            Left = 560
            Top = 4
            Width = 100
            Height = 12
            Caption = 'Valor Total dos Produtos'
            FocusControl = E_VL_Produto
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 560
            Top = 39
            Width = 78
            Height = 12
            Caption = 'Valor Total da Nota'
            FocusControl = E_VL_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 4
            Top = 75
            Width = 47
            Height = 12
            Caption = 'Quantidade'
            FocusControl = E_Qtde
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 71
            Top = 75
            Width = 33
            Height = 12
            Caption = 'Esp'#233'cie'
            FocusControl = E_Especie
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 202
            Top = 75
            Width = 25
            Height = 12
            Caption = 'Marca'
            FocusControl = E_MArca
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 389
            Top = 76
            Width = 33
            Height = 12
            Caption = 'N'#250'mero'
            FocusControl = E_Numero
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label22: TLabel
            Left = 485
            Top = 76
            Width = 46
            Height = 12
            Caption = 'Peso Bruto'
            FocusControl = E_PesoBruto
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 603
            Top = 75
            Width = 54
            Height = 12
            Caption = 'Peso L'#237'quido'
            FocusControl = E_PesoLiquido
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 452
            Top = 39
            Width = 63
            Height = 12
            Caption = 'Valor Desconto'
            FocusControl = E_Vl_IPI
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Bs_Icms: TEdit_Setes
            Left = 4
            Top = 16
            Width = 137
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = ''
          end
          object E_Vl_Icms: TEdit_Setes
            Left = 144
            Top = 16
            Width = 136
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            Text = ''
          end
          object E_Bs_Icms_St: TEdit_Setes
            Left = 283
            Top = 16
            Width = 136
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            Text = ''
          end
          object E_Vl_Icms_St: TEdit_Setes
            Left = 422
            Top = 16
            Width = 137
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            Text = ''
          end
          object E_Vl_frete: TEdit_Setes
            Left = 4
            Top = 51
            Width = 111
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            Text = ''
          end
          object E_Vl_Seguro: TEdit_Setes
            Left = 116
            Top = 51
            Width = 110
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
            Text = ''
          end
          object E_Vl_Outras: TEdit_Setes
            Left = 227
            Top = 51
            Width = 119
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            Text = ''
          end
          object E_Vl_IPI: TEdit_Setes
            Left = 348
            Top = 51
            Width = 100
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            Text = ''
          end
          object E_VL_Produto: TEdit_Setes
            Left = 560
            Top = 16
            Width = 135
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Text = ''
          end
          object E_VL_Nota: TEdit_Setes
            Left = 560
            Top = 51
            Width = 135
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
            Text = ''
          end
          object E_Qtde: TEdit_Setes
            Left = 4
            Top = 89
            Width = 65
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
            Text = ''
          end
          object E_Especie: TEdit
            Left = 71
            Top = 89
            Width = 127
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
          end
          object E_MArca: TEdit
            Left = 200
            Top = 89
            Width = 184
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object E_Numero: TEdit
            Left = 387
            Top = 89
            Width = 93
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 13
          end
          object E_PesoBruto: TEdit_Setes
            Left = 483
            Top = 89
            Width = 117
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
            Text = ''
          end
          object E_PesoLiquido: TEdit_Setes
            Left = 602
            Top = 89
            Width = 93
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 15
            Text = ''
          end
          object E_Vl_Desconto: TEdit_Setes
            Left = 450
            Top = 51
            Width = 108
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
            Text = ''
          end
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Produtos da Nota'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 438
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Servi'#231'os da Nota'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 438
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object tbs_adicional: TTabSheet
      Caption = 'Informa'#231#245'es Adicionais'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 438
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object E_Obs: TMemo
          Left = 2
          Top = 2
          Width = 872
          Height = 434
          Align = alClient
          Lines.Strings = (
            'E_Obs')
          TabOrder = 0
        end
      end
    end
  end
  object Qr_ItensNota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ItensNotaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  ITF_CODIGO,'
      '  ITF_CODPRO, '
      '  MED_ABREVIATURA,'
      '  PRO_CODIGOFAB,'
      '   PRO_CODIGONCM,'
      '  PRO_ORIGEM,'
      '   PRO_TIPO,'
      '  PRO_DESCRICAO,'
      '  PRO_SERIE,'
      '  EMB_ABREVIATURA,'
      '  ITF_QTDE, '
      '  ITF_VL_UNIT,'
      '  ITF_ESTOQUE,'
      '  ITF_OPER,'
      '  ITF_CODEST,'
      '  CAST(( ITF_QTDE * ITF_VL_UNIT) AS DOUBLE PRECISION) AS  ITF_SUBTOTAL,'
      '   CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) AS DOUBLE PRECISION) ITF_VL_TOTAL,'
      '   ITF_AQ_COM,'
      '  CAST(( (ITF_QTDE * ITF_VL_UNIT) * (ITF_AQ_COM/100)) AS DOUBLE PRECISION) ITF_VL_COM,'
      '   ITF_VL_DESC,'
      '     PRO_VL_CUSTOMED,'
      '  ITF_AQ_DESC,'
      '  ITF_AQ_IPI,'
      '  ITF_AQ_ICMS,'
      '  ITF_CODTPR,'
      'ITF_VL_CUSTO,'
      ' itd_coditf_orig,'
      'NAT_CFOP,'
      'ITF_IMP_APROX'
      'FROM TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   INNER JOIN tb_embalagem '
      '   on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      '   LEFT OUTER JOIN tb_itens_dev '
      '   ON (tb_itens_dev.itd_coditf_orig = Tb_itens_nfl.itf_codigo) '
      '   left outer join tb_itens_icms'
      '   ON (ICM_CODITF = ITF_CODIGO)'
      '   LEFT OUTER JOIN TB_NATUREZA'
      '   ON (NAT_CODIGO = ICM_CODNAT)'
      ''
      'WHERE (ITF_CODNFL = :NFL_CODIGO) AND (ITF_OPER <> '#39'D'#39')'
      'AND tb_produto.pro_tipo <> '#39'S'#39)
    Left = 128
    Top = 480
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensNotaITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = 'TB_ITENS_NFL.ITF_CODIGO'
      Required = True
    end
    object Qr_ItensNotaITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = 'TB_ITENS_NFL.ITF_CODPRO'
    end
    object Qr_ItensNotaMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = 'TB_MEDIDA.MED_ABREVIATURA'
      Size = 5
    end
    object Qr_ItensNotaPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = 'TB_PRODUTO.PRO_CODIGOFAB'
      Size = 50
    end
    object Qr_ItensNotaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_ItensNotaITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = 'TB_ITENS_NFL.ITF_QTDE'
      Precision = 18
      Size = 3
    end
    object Qr_ItensNotaITF_VL_UNIT: TFloatField
      FieldName = 'ITF_VL_UNIT'
      Origin = 'TB_ITENS_NFL.ITF_VL_UNIT'
    end
    object Qr_ItensNotaITF_SUBTOTAL: TFloatField
      FieldName = 'ITF_SUBTOTAL'
    end
    object Qr_ItensNotaITF_VL_COM: TFloatField
      FieldName = 'ITF_VL_COM'
    end
    object Qr_ItensNotaITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = 'TB_ITENS_NFL.ITF_VL_DESC'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaPRO_TIPO: TStringField
      FieldName = 'PRO_TIPO'
      Origin = 'TB_PRODUTO.PRO_TIPO'
      Size = 1
    end
    object Qr_ItensNotaPRO_SERIE: TStringField
      FieldName = 'PRO_SERIE'
      Origin = 'TB_PRODUTO.PRO_SERIE'
      Size = 1
    end
    object Qr_ItensNotaEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = 'TB_EMBALAGEM.EMB_ABREVIATURA'
      Size = 5
    end
    object Qr_ItensNotaITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = 'TB_ITENS_NFL.ITF_ESTOQUE'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensNotaITF_OPER: TStringField
      FieldName = 'ITF_OPER'
      Origin = 'TB_ITENS_NFL.ITF_OPER'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensNotaITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = 'TB_ITENS_NFL.ITF_CODEST'
    end
    object Qr_ItensNotaITF_VL_TOTAL: TFloatField
      FieldName = 'ITF_VL_TOTAL'
    end
    object Qr_ItensNotaITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = 'TB_ITENS_NFL.ITF_AQ_COM'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaPRO_VL_CUSTOMED: TFloatField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = 'TB_PRODUTO.PRO_VL_CUSTOMED'
    end
    object Qr_ItensNotaITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = 'TB_ITENS_NFL.ITF_AQ_DESC'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = 'TB_ITENS_NFL.ITF_AQ_IPI'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = 'TB_ITENS_NFL.ITF_AQ_ICMS'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = 'TB_ITENS_NFL.ITF_CODTPR'
    end
    object Qr_ItensNotaITF_VL_CUSTO: TFloatField
      FieldName = 'ITF_VL_CUSTO'
      Origin = 'TB_ITENS_NFL.ITF_VL_CUSTO'
    end
    object Qr_ItensNotaITD_CODITF_ORIG: TIntegerField
      FieldName = 'ITD_CODITF_ORIG'
      Origin = 'TB_ITENS_DEV.ITD_CODITF_ORIG'
    end
    object Qr_ItensNotaNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = 'TB_NATUREZA.NAT_CFOP'
      Size = 10
    end
    object Qr_ItensNotaPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = 'TB_PRODUTO.PRO_CODIGONCM'
      Size = 50
    end
    object Qr_ItensNotaPRO_ORIGEM: TStringField
      FieldName = 'PRO_ORIGEM'
      Origin = 'TB_PRODUTO.PRO_ORIGEM'
      Size = 1
    end
    object Qr_ItensNotaITF_IMP_APROX: TBCDField
      FieldName = 'ITF_IMP_APROX'
      Origin = 'TB_ITENS_NFL.ITF_IMP_APROX'
      Precision = 18
      Size = 3
    end
  end
  object Ds_ItensNota: TDataSource
    AutoEdit = False
    DataSet = Qr_ItensNota
    Left = 128
    Top = 512
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_NotaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '     EMP_TIPO,'
      '    NFL_CODMHA,'
      '      PED_CODIGO, '
      '      NFL_CODIGO, '
      '      NFL_CODPED, '
      '     PED_CODFPG,'
      '      NAT_CODIGO,'
      '      NAT_DESCRICAO, '
      '      NAT_CFOP, '
      '      PED_NUMERO, '
      '      NFL_NUMERO, '
      '      NFL_VL_TL_NOTA, '
      '      EMP_CODIGO, '
      '      EMP_NOME, '
      '      EMP_CNPJ, '
      '      END_ENDER, '
      '      END_BAIRRO, '
      '      END_CEP, '
      '      END_FONE, '
      '      EMP_INSC_EST, '
      '      EMP_EMAIL,'
      '      NFL_DT_EMISSAO, '
      '      NFL_DT_SAIDA, '
      '      NFL_BS_ICMS, '
      '      NFL_VL_ICMS, '
      '      NFL_BS_ICMS_SUBST, '
      '      NFL_VL_ICMS_SUBST, '
      '      NFL_VL_TL_PROD, '
      '      NFL_VL_FRETE, '
      '      NFL_VL_SEGURO, '
      '      NFL_VL_DESP_ACESS, '
      '      NFL_VL_IPI,  '
      '      NFL_QT_PRODUTO, '
      '      NFL_CODTRP,'
      '      NFL_ESPECIE, '
      '      NFL_MARCA,  '
      '      NFL_PESO_BRUTO, '
      '      NFL_PESO_LIQ, '
      '    NFL_VOL_NUMERO,'
      '      CLB_NOME,  '
      '      NFL_STATUS, '
      '      NFL_TIPO, '
      '      PED_OBS, '
      '      NFL_VL_TL_SRV, '
      '      PED_VL_DESCONTO, '
      '      PED_DT_ALTERA, '
      '      PED_CODTRP, '
      '      NFE_CODSIT, '
      '      PED_PRAZO, '
      '      CDD_DESCRICAO, '
      '      UFE_SIGLA, PED_TIPO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '      INNER JOIN TB_PEDIDO tb_pedido'
      '      ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      ''
      '      INNER JOIN TB_EMPRESA tb_empresa'
      '      ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      ''
      '      INNER  JOIN TB_ENDERECO tb_endereco'
      '      ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      ''
      '      INNER JOIN TB_CIDADE tb_cidade'
      '      ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      ''
      '      INNER JOIN TB_UF tb_uf'
      '      ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      ''
      '      LEFT OUTER  JOIN TB_NATUREZA tb_natureza'
      '      ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT)'
      ''
      '      LEFT OUTER  JOIN TB_COLABORADOR tb_colaborador'
      '      ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)'
      ''
      '      LEFT OUTER  JOIN TB_RETORNO_NFE tb_retorno_nfe'
      '      ON (tb_retorno_nfe.NFE_CODNFL = tb_nota_fiscal.NFL_CODIGO)'
      'WHERE (NFL_CODIGO=:NFL_CODIGO)  '
      ''
      '')
    Left = 88
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_NotaEMP_TIPO: TIntegerField
      FieldName = 'EMP_TIPO'
      Origin = 'TB_EMPRESA.EMP_TIPO'
      Required = True
    end
    object Qr_NotaPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = 'TB_PEDIDO.PED_CODIGO'
      Required = True
    end
    object Qr_NotaNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = 'TB_NOTA_FISCAL.NFL_CODIGO'
      Required = True
    end
    object Qr_NotaNFL_CODPED: TIntegerField
      FieldName = 'NFL_CODPED'
      Origin = 'TB_NOTA_FISCAL.NFL_CODPED'
    end
    object Qr_NotaPED_CODFPG: TIntegerField
      FieldName = 'PED_CODFPG'
      Origin = 'TB_PEDIDO.PED_CODFPG'
      Required = True
    end
    object Qr_NotaNAT_CODIGO: TIntegerField
      FieldName = 'NAT_CODIGO'
      Origin = 'TB_NATUREZA.NAT_CODIGO'
    end
    object Qr_NotaNAT_DESCRICAO: TStringField
      FieldName = 'NAT_DESCRICAO'
      Origin = 'TB_NATUREZA.NAT_DESCRICAO'
      Size = 250
    end
    object Qr_NotaNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = 'TB_NATUREZA.NAT_CFOP'
      Size = 10
    end
    object Qr_NotaPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_NotaNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = 'TB_NOTA_FISCAL.NFL_NUMERO'
      Size = 10
    end
    object Qr_NotaNFL_VL_TL_NOTA: TBCDField
      FieldName = 'NFL_VL_TL_NOTA'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_TL_NOTA'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_NotaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_NotaEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = 'TB_EMPRESA.EMP_CNPJ'
      Size = 14
    end
    object Qr_NotaEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_NotaEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 100
    end
    object Qr_NotaEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_NotaEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = 'TB_ENDERECO.END_FONE'
      Size = 14
    end
    object Qr_NotaEMP_INSC_EST: TStringField
      FieldName = 'EMP_INSC_EST'
      Origin = 'TB_EMPRESA.EMP_INSC_EST'
      Size = 30
    end
    object Qr_NotaNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = 'TB_NOTA_FISCAL.NFL_DT_EMISSAO'
    end
    object Qr_NotaNFL_DT_SAIDA: TDateField
      FieldName = 'NFL_DT_SAIDA'
      Origin = 'TB_NOTA_FISCAL.NFL_DT_SAIDA'
    end
    object Qr_NotaNFL_BS_ICMS: TBCDField
      FieldName = 'NFL_BS_ICMS'
      Origin = 'TB_NOTA_FISCAL.NFL_BS_ICMS'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_ICMS: TBCDField
      FieldName = 'NFL_VL_ICMS'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_ICMS'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_BS_ICMS_SUBST: TBCDField
      FieldName = 'NFL_BS_ICMS_SUBST'
      Origin = 'TB_NOTA_FISCAL.NFL_BS_ICMS_SUBST'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_ICMS_SUBST: TBCDField
      FieldName = 'NFL_VL_ICMS_SUBST'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_ICMS_SUBST'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_TL_PROD: TBCDField
      FieldName = 'NFL_VL_TL_PROD'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_TL_PROD'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_FRETE: TBCDField
      FieldName = 'NFL_VL_FRETE'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_FRETE'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_SEGURO: TBCDField
      FieldName = 'NFL_VL_SEGURO'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_SEGURO'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_DESP_ACESS: TBCDField
      FieldName = 'NFL_VL_DESP_ACESS'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_DESP_ACESS'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_IPI: TBCDField
      FieldName = 'NFL_VL_IPI'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_IPI'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_QT_PRODUTO: TBCDField
      FieldName = 'NFL_QT_PRODUTO'
      Origin = 'TB_NOTA_FISCAL.NFL_QT_PRODUTO'
      Precision = 18
      Size = 3
    end
    object Qr_NotaNFL_ESPECIE: TStringField
      FieldName = 'NFL_ESPECIE'
      Origin = 'TB_NOTA_FISCAL.NFL_ESPECIE'
      Size = 10
    end
    object Qr_NotaNFL_MARCA: TStringField
      FieldName = 'NFL_MARCA'
      Origin = 'TB_NOTA_FISCAL.NFL_MARCA'
      Size = 10
    end
    object Qr_NotaNFL_PESO_BRUTO: TStringField
      FieldName = 'NFL_PESO_BRUTO'
      Origin = 'TB_NOTA_FISCAL.NFL_PESO_BRUTO'
      Size = 10
    end
    object Qr_NotaNFL_PESO_LIQ: TStringField
      FieldName = 'NFL_PESO_LIQ'
      Origin = 'TB_NOTA_FISCAL.NFL_PESO_LIQ'
      Size = 10
    end
    object Qr_NotaCLB_NOME: TStringField
      FieldName = 'CLB_NOME'
      Origin = 'TB_COLABORADOR.CLB_NOME'
      Size = 100
    end
    object Qr_NotaNFL_STATUS: TStringField
      FieldName = 'NFL_STATUS'
      Origin = 'TB_NOTA_FISCAL.NFL_STATUS'
      Size = 1
    end
    object Qr_NotaNFL_TIPO: TStringField
      FieldName = 'NFL_TIPO'
      Origin = 'TB_NOTA_FISCAL.NFL_TIPO'
      Size = 2
    end
    object Qr_NotaPED_OBS: TBlobField
      FieldName = 'PED_OBS'
      Origin = 'TB_PEDIDO.PED_OBS'
      Size = 8
    end
    object Qr_NotaNFL_VL_TL_SRV: TBCDField
      FieldName = 'NFL_VL_TL_SRV'
      Origin = 'TB_NOTA_FISCAL.NFL_VL_TL_SRV'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaPED_VL_DESCONTO: TBCDField
      FieldName = 'PED_VL_DESCONTO'
      Origin = 'TB_PEDIDO.PED_VL_DESCONTO'
      DisplayFormat = '0.00##'
      Precision = 18
      Size = 2
    end
    object Qr_NotaPED_DT_ALTERA: TSQLTimeStampField
      FieldName = 'PED_DT_ALTERA'
      Origin = 'TB_PEDIDO.PED_DT_ALTERA'
    end
    object Qr_NotaPED_CODTRP: TIntegerField
      FieldName = 'PED_CODTRP'
      Origin = 'TB_PEDIDO.PED_CODTRP'
    end
    object Qr_NotaNFE_CODSIT: TIntegerField
      FieldName = 'NFE_CODSIT'
      Origin = 'TB_RETORNO_NFE.NFE_CODSIT'
    end
    object Qr_NotaPED_PRAZO: TStringField
      FieldName = 'PED_PRAZO'
      Origin = 'TB_PEDIDO.PED_PRAZO'
      Size = 200
    end
    object Qr_NotaCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_NotaUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_NotaPED_TIPO: TIntegerField
      FieldName = 'PED_TIPO'
      Origin = 'TB_PEDIDO.PED_TIPO'
    end
    object Qr_NotaNFL_CODMHA: TIntegerField
      FieldName = 'NFL_CODMHA'
      Origin = 'TB_NOTA_FISCAL.NFL_CODMHA'
    end
    object Qr_NotaNFL_CODTRP: TIntegerField
      FieldName = 'NFL_CODTRP'
      Origin = 'TB_NOTA_FISCAL.NFL_CODTRP'
    end
    object Qr_NotaEMP_EMAIL: TStringField
      FieldName = 'EMP_EMAIL'
      Origin = 'TB_EMPRESA.EMP_EMAIL'
      Size = 100
    end
    object Qr_NotaNFL_VOL_NUMERO: TStringField
      FieldName = 'NFL_VOL_NUMERO'
      Origin = 'TB_NOTA_FISCAL.NFL_VOL_NUMERO'
      Size = 8
    end
  end
  object DS_Nota: TDataSource
    AutoEdit = False
    DataSet = Qr_Nota
    OnStateChange = DS_NotaStateChange
    Left = 96
    Top = 512
  end
  object Ds_Obs_Nota: TDataSource
    Left = 316
    Top = 447
  end
  object Qr_ItensSrv: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ItensSrvAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_DESCRICAO,'
      '  EMB_ABREVIATURA,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_DESC,'
      '  ITF_VL_UNIT,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '  CAST((ITF_QTDE * ITF_VL_UNIT) AS DOUBLE PRECISION) ITF_VL_SUBTOTAL ,'
      '    CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) AS DOUBLE PRECISION) ITF_VL_TOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   INNER join tb_embalagem tb_embalagem'
      '     on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = '#39'S'#39')'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    Left = 161
    Top = 480
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensSrvITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = 'TB_ITENS_NFL.ITF_CODIGO'
      Required = True
    end
    object Qr_ItensSrvITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = 'TB_ITENS_NFL.ITF_CODPED'
    end
    object Qr_ItensSrvITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = 'TB_ITENS_NFL.ITF_CODNFL'
    end
    object Qr_ItensSrvITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = 'TB_ITENS_NFL.ITF_CODPRO'
    end
    object Qr_ItensSrvPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_ItensSrvEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = 'TB_EMBALAGEM.EMB_ABREVIATURA'
      Size = 5
    end
    object Qr_ItensSrvITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = 'TB_ITENS_NFL.ITF_QTDE'
      Precision = 18
      Size = 3
    end
    object Qr_ItensSrvITF_VL_CUSTO: TFloatField
      FieldName = 'ITF_VL_CUSTO'
      Origin = 'TB_ITENS_NFL.ITF_VL_CUSTO'
      DisplayFormat = '0.00######'
    end
    object Qr_ItensSrvITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = 'TB_ITENS_NFL.ITF_VL_DESC'
      DisplayFormat = '0.00######'
      Precision = 18
      Size = 2
    end
    object Qr_ItensSrvITF_VL_UNIT: TFloatField
      FieldName = 'ITF_VL_UNIT'
      Origin = 'TB_ITENS_NFL.ITF_VL_UNIT'
      DisplayFormat = '0.00######'
    end
    object Qr_ItensSrvITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = 'TB_ITENS_NFL.ITF_AQ_COM'
      Precision = 18
      Size = 2
    end
    object Qr_ItensSrvMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = 'TB_MEDIDA.MED_ABREVIATURA'
      Size = 5
    end
    object Qr_ItensSrvITF_VL_SUBTOTAL: TFloatField
      FieldName = 'ITF_VL_SUBTOTAL'
      DisplayFormat = '0.00######'
    end
    object Qr_ItensSrvITF_VL_TOTAL: TFloatField
      FieldName = 'ITF_VL_TOTAL'
      DisplayFormat = '0.00######'
    end
  end
  object Ds_FormaPgto: TDataSource
    DataSet = Qr_FPgto
    Left = 521
    Top = 458
  end
  object Qr_FPgto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '   FIN_DATA,'
      '   FIN_PRAZO,'
      '   FIN_DT_VENCIMENTO,'
      '   FIN_NUMERO,'
      '   FIN_VL_PARCELA,'
      '   FIN_DT_PAGTO,'
      '   FIN_VL_PAGO,'
      '   FIN_DT_BAIXA,'
      '   FIN_TIPO,'
      '  FIN_OPERACAO'
      'FROM TB_FINANCEIRO'
      'WHERE ((FIN_CODPED=:NFL_CODPED) OR (FIN_CODNFL=:NFL_CODIGO))')
    Left = 521
    Top = 426
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODPED'
        ParamType = ptUnknown
        Size = 4
      end
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_FPgtoFIN_DATA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'FIN_DATA'
      Origin = 'TB_FINANCEIRO.FIN_DATA'
    end
    object Qr_FPgtoFIN_PRAZO: TStringField
      DisplayLabel = 'Forma de Pagto'
      FieldName = 'FIN_PRAZO'
      Origin = 'TB_FINANCEIRO.FIN_PRAZO'
      Size = 100
    end
    object Qr_FPgtoFIN_DT_VENCIMENTO: TDateField
      DisplayLabel = 'Vencimento'
      FieldName = 'FIN_DT_VENCIMENTO'
      Origin = 'TB_FINANCEIRO.FIN_DT_VENCIMENTO'
    end
    object Qr_FPgtoFIN_NUMERO: TStringField
      DisplayLabel = 'N'#186' Parcela'
      FieldName = 'FIN_NUMERO'
      Origin = 'TB_FINANCEIRO.FIN_NUMERO'
    end
    object Qr_FPgtoFIN_VL_PARCELA: TBCDField
      DisplayLabel = 'Vl. Parcela'
      FieldName = 'FIN_VL_PARCELA'
      Origin = 'TB_FINANCEIRO.FIN_VL_PARCELA'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_FPgtoFIN_DT_PAGTO: TDateField
      DisplayLabel = 'Dt. Pgto'
      FieldName = 'FIN_DT_PAGTO'
      Origin = 'TB_FINANCEIRO.FIN_DT_PAGTO'
    end
    object Qr_FPgtoFIN_VL_PAGO: TBCDField
      DisplayLabel = 'Vl. Pago'
      FieldName = 'FIN_VL_PAGO'
      Origin = 'TB_FINANCEIRO.FIN_VL_PAGO'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_FPgtoFIN_DT_BAIXA: TDateField
      DisplayLabel = 'Baixa'
      FieldName = 'FIN_DT_BAIXA'
      Origin = 'TB_FINANCEIRO.FIN_DT_BAIXA'
    end
    object Qr_FPgtoFIN_TIPO: TStringField
      FieldName = 'FIN_TIPO'
      Origin = 'TB_FINANCEIRO.FIN_TIPO'
      Size = 2
    end
    object Qr_FPgtoFIN_OPERACAO: TStringField
      FieldName = 'FIN_OPERACAO'
      Origin = 'TB_FINANCEIRO.FIN_OPERACAO'
      FixedChar = True
      Size = 1
    end
  end
  object dst_ItensSrv: TDataSource
    DataSet = Qr_ItensSrv
    Left = 161
    Top = 514
  end
  object Pop_Produto: TPopupMenu
    Left = 12
    Top = 492
    object CadastrodoProduto: TMenuItem
      Caption = 'Cadastro do Produto'
      OnClick = CadastrodoProdutoClick
    end
    object RegistraNmerodolote1: TMenuItem
      Caption = 'Registra N'#250'mero do lote'
      OnClick = RegistraNmerodolote1Click
    end
  end
  object Mnu_Operacao: TMainMenu
    Left = 49
    Top = 498
    object Mnu_Operacao_Tarefas: TMenuItem
      Caption = 'Tarefas'
      object Itm_CadastroDestinatrio: TMenuItem
        Caption = 'Cadastro Destinat'#225'rio'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Itm_Nfe_Operacao: TMenuItem
        Caption = 'Opera'#231#245'es NF-e'
      end
      object Itm_Nfe_Compl: TMenuItem
        Caption = 'Gerar Complementar'
      end
      object Itm_Carta_Correcao: TMenuItem
        Caption = 'Carta de Corre'#231#227'o'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Itm_ImprimirPedido: TMenuItem
        Caption = 'Imprimir Pedido'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object AtualizarosCustos1: TMenuItem
        Caption = 'Atualizar os Custos'
      end
      object CalcularaComisso1: TMenuItem
        Caption = 'Recalcular a Comiss'#227'o'
      end
      object AuditoriaEstoque1: TMenuItem
        Caption = 'Auditoria Estoque'
      end
      object CpiadePedidoNota1: TMenuItem
        Caption = 'C'#243'pia de Pedido/Nota'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MnuLucratividade: TMenuItem
        Caption = 'Lucratividade'
        OnClick = MnuLucratividadeClick
      end
    end
  end
end
