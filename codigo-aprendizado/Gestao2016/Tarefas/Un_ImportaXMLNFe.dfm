inherited Fr_ImportaXMLNFe: TFr_ImportaXMLNFe
  Left = 334
  Top = 34
  Caption = 'Importa'#231#227'o do XML da Nota Fiscal'
  ClientHeight = 670
  ClientWidth = 897
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 903
  ExplicitHeight = 719
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 897
    Height = 153
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label5: TLabel
      Left = 7
      Top = 68
      Width = 407
      Height = 13
      Caption = 
        'Neste processo ser'#225' efetuado a sua manifesta'#231#227'o em rela'#231#227'o a Not' +
        'a Fiscal Eletr'#244'nica'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label34: TLabel
      Left = 8
      Top = 83
      Width = 368
      Height = 13
      Caption = 
        'Desta forma ser'#225' poss'#237'vel fazer leitura dos dados pelo n'#250'mero da' +
        ' Chave NF-e'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label37: TLabel
      Left = 8
      Top = 98
      Width = 414
      Height = 13
      Caption = 
        'Caso o arquivo for informado localmente a manifesta'#231#227'o do destin' +
        'at'#225'rio n'#227'o acontecer'#225
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 423
      Height = 63
      Caption = 'Informe a Chave da Nota Fiscal Eletr'#244'nica'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Lb_Nr_Caracteres: TLabel
        Left = 6
        Top = 44
        Width = 121
        Height = 13
        Caption = 'N'#250'mero de Caracteres : 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object E_Chave: TEdit_Setes
        Left = 5
        Top = 17
        Width = 412
        Height = 25
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 44
        ParentFont = False
        TabOrder = 0
        Text = ''
        OnChange = E_ChaveChange
        OnEnter = E_ChaveEnter
        OnKeyPress = E_ChaveKeyPress
      end
    end
    object GroupBox4: TGroupBox
      Left = 427
      Top = 2
      Width = 342
      Height = 63
      Caption = 'Manifesta'#231#227'o do Destinat'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      inline FmListaEventosNfe: TFmListaEventosNfe
        Left = 2
        Top = 16
        Width = 338
        Height = 45
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        TabOrder = 0
        ExplicitLeft = -193
        ExplicitTop = 11
        inherited pnl_linha_1: TPanel
          Width = 338
          inherited Sb_open: TSpeedButton
            Left = 314
          end
          inherited Dblcb_Lista: TDBLookupComboBox
            Width = 314
            Height = 22
            ExplicitHeight = 22
          end
        end
        inherited pnl_top: TPanel
          Width = 338
          inherited L_name_list: TLabel
            Width = 332
            ExplicitLeft = -1
            ExplicitTop = 0
            ExplicitWidth = 326
            ExplicitHeight = 16
          end
        end
      end
    end
    object ChBx_XML_Terceiro: TCheckBox
      Left = 7
      Top = 112
      Width = 720
      Height = 17
      Caption = 
        'Quero Importar um XML que n'#227'o foi emitido para o meu CNPJ (O Arq' +
        'uivo XML desve estar no Computador)'
      TabOrder = 2
    end
    object ChBx_Manifestacao: TCheckBox
      Left = 7
      Top = 127
      Width = 720
      Height = 17
      Caption = 'Efetuar a manifesta'#231#227'o do destinat'#225'rio '
      TabOrder = 3
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 607
    Width = 897
    Height = 63
    Align = alBottom
    TabOrder = 1
    object SB_Processo: TSpeedButton
      AlignWithMargins = True
      Left = 655
      Top = 4
      Width = 77
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Ler XML - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ProcessoClick
      ExplicitLeft = 491
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 732
      Top = 4
      Width = 77
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Confirmar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitTop = 6
    end
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 812
      Top = 4
      Width = 81
      Height = 55
      Align = alRight
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 646
      ExplicitTop = 5
      ExplicitHeight = 54
    end
  end
  object Pg_Notas: TPageControl [2]
    Left = 0
    Top = 153
    Width = 897
    Height = 454
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 2
    OnChange = Pg_NotasChange
    ExplicitTop = 142
    ExplicitHeight = 465
    object tbs_nota: TTabSheet
      Caption = 'Dados da Nota'
      ExplicitHeight = 437
      object Pnl_Cliente: TPanel
        Left = 0
        Top = 0
        Width = 889
        Height = 426
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 437
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
          Width = 50
          Height = 14
          Caption = 'Valor Total'
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
          Width = 587
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
          object Label29: TLabel
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
          object Label32: TLabel
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
          object Label33: TLabel
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
          object E_Endereco: TEdit
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
          object E_Bairro: TEdit
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
          object E_Cep: TEdit
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
          object E_Cidade: TEdit
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
          object E_Fone: TEdit
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
          object E_Estado: TEdit
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
          object E_Insc_Est: TEdit
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
        object GroupBox3: TGroupBox
          Left = 589
          Top = 39
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
          object E_Dt_Emissao: TMaskEdit
            Left = 4
            Top = 32
            Width = 101
            Height = 22
            Alignment = taCenter
            EditMask = '!99/99/0000;1;_'
            MaxLength = 10
            TabOrder = 0
            Text = '  /  /    '
          end
          object E_Dt_Saida: TMaskEdit
            Left = 4
            Top = 84
            Width = 103
            Height = 22
            Alignment = taCenter
            EditMask = '!99/99/0000;1;_'
            MaxLength = 10
            TabOrder = 1
            Text = '  /  /    '
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
        object PageControl1: TPageControl
          Left = 2
          Top = 275
          Width = 885
          Height = 149
          ActivePage = TabSheet1
          Align = alBottom
          TabOrder = 5
          ExplicitTop = 286
          object TabSheet1: TTabSheet
            Caption = 'Totalizador'
            object Panel3: TPanel
              Left = 0
              Top = 0
              Width = 877
              Height = 121
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
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
          object TabSheet2: TTabSheet
            Caption = 'Observa'#231#227'o'
            ImageIndex = 1
            object E_Obs: TMemo
              Left = 0
              Top = 0
              Width = 877
              Height = 121
              Align = alClient
              Lines.Strings = (
                'E_Obs')
              TabOrder = 0
            end
          end
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Itens da Nota'
      ImageIndex = 1
      ExplicitHeight = 437
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 889
        Height = 426
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 437
        object Dbg_items: TDBGrid
          Left = 2
          Top = 2
          Width = 885
          Height = 356
          Align = alClient
          DataSource = ds_itens_nota
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = Dbg_itemsDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'codigo'
              ReadOnly = True
              Width = 0
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'item'
              ReadOnly = True
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descricao'
              ReadOnly = True
              Width = 350
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'unidade'
              ReadOnly = True
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'qtde'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valorUnitario'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valorDesconto'
              ReadOnly = True
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valorTotal'
              ReadOnly = True
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'codigoNota'
              ReadOnly = True
              Width = 130
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'loteNumero'
              Width = 127
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'loteVencimento'
              Width = 93
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'codigoBarras'
              ReadOnly = True
              Width = 131
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'codigoInterno'
              ReadOnly = True
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descricaoInterna'
              ReadOnly = True
              Width = 357
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'codigoEstoque'
              ReadOnly = True
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descricaoEstoque'
              ReadOnly = True
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ncmNota'
              ReadOnly = True
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'origemNota'
              ReadOnly = True
              Width = 0
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'stNota'
              ReadOnly = True
              Width = 0
              Visible = True
            end>
        end
        object Panel7: TPanel
          Left = 2
          Top = 384
          Width = 885
          Height = 40
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          ExplicitTop = 395
          DesignSize = (
            885
            40)
          object Sb_Produto: TBitBtn
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 140
            Height = 34
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Aplicar c'#243'digo interno'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
              333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
              0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
              0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
              33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
              B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
              3BB33773333773333773B333333B3333333B7333333733333337}
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 0
            OnClick = Sb_ProdutoClick
          end
          object Sb_Estoque: TBitBtn
            AlignWithMargins = True
            Left = 145
            Top = 3
            Width = 140
            Height = 34
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Definir Estoque'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
              333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
              0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
              0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
              33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
              B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
              3BB33773333773333773B333333B3333333B7333333733333337}
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 1
            OnClick = Sb_EstoqueClick
          end
          object sb_RecarregaLista: TBitBtn
            AlignWithMargins = True
            Left = 287
            Top = 3
            Width = 140
            Height = 34
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Recarregar Lista'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              555555FFFFFFFFFF55555000000000055555577777777775FFFF00B8B8B8B8B0
              0000775F5555555777770B0B8B8B8B8B0FF07F75F555555575F70FB0B8B8B8B8
              B0F07F575FFFFFFFF7F70BFB0000000000F07F557777777777570FBFBF0FFFFF
              FFF07F55557F5FFFFFF70BFBFB0F000000F07F55557F777777570FBFBF0FFFFF
              FFF075F5557F5FFFFFF750FBFB0F000000F0575FFF7F777777575700000FFFFF
              FFF05577777F5FF55FF75555550F00FF00005555557F775577775555550FFFFF
              0F055555557F55557F755555550FFFFF00555555557FFFFF7755555555000000
              0555555555777777755555555555555555555555555555555555}
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 2
            OnClick = sb_RecarregaListaClick
          end
          object ChBx_Cad_Produto_Auto: TCheckBox
            Left = 716
            Top = 2
            Width = 160
            Height = 17
            Anchors = [akRight, akBottom]
            Caption = 'Cadastrar o produto pelo XML'
            TabOrder = 3
          end
          object ChBx_AtualizarEstoque: TCheckBox
            Left = 716
            Top = 18
            Width = 155
            Height = 17
            Anchors = [akRight, akBottom]
            Caption = 'N'#227'o atualizar Estoque'
            TabOrder = 4
          end
          object Sb_Replicar_item: TBitBtn
            AlignWithMargins = True
            Left = 429
            Top = 3
            Width = 140
            Height = 34
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Replicar Item'
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
              3333333333333333FF3333333333333003333333333333377F33333333333307
              733333FFF333337773333C003333307733333777FF333777FFFFC0CC03330770
              000077777FF377777777C033C03077FFFFF077FF77F777FFFFF7CC00000F7777
              777077777777777777773CCCCC00000000003777777777777777333330030FFF
              FFF03333F77F7F3FF3F7333C0C030F00F0F03337777F7F77373733C03C030FFF
              FFF03377F77F7F3F333733C03C030F0FFFF03377F7737F733FF733C000330FFF
              0000337777F37F3F7777333CCC330F0F0FF0333777337F737F37333333330FFF
              0F03333333337FFF7F7333333333000000333333333377777733}
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 5
            OnClick = Sb_Replicar_itemClick
          end
        end
        object Panel8: TPanel
          Left = 2
          Top = 358
          Width = 885
          Height = 26
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 2
          ExplicitTop = 369
          object Lb_Total_Itens_Nota: TLabel
            AlignWithMargins = True
            Left = 183
            Top = 3
            Width = 36
            Height = 18
            Margins.Top = 1
            Align = alLeft
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 20
          end
          object Lb_Total_Itens_Calculado: TLabel
            AlignWithMargins = True
            Left = 844
            Top = 3
            Width = 36
            Height = 18
            Margins.Top = 1
            Align = alRight
            Alignment = taRightJustify
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 20
          end
          object Label40: TLabel
            AlignWithMargins = True
            Left = 5
            Top = 3
            Width = 172
            Height = 18
            Margins.Top = 1
            Align = alLeft
            Caption = 'Valor Itens na Nota : '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 20
          end
          object Label41: TLabel
            AlignWithMargins = True
            Left = 623
            Top = 3
            Width = 215
            Height = 18
            Margins.Top = 1
            Align = alRight
            Alignment = taRightJustify
            Caption = 'Valor Calculado dos itens :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 20
          end
        end
      end
    end
    object tbs_financeiro: TTabSheet
      Caption = 'Dados financeiros'
      ImageIndex = 3
      ExplicitHeight = 437
      object Pnl_Financeiro: TPanel
        Left = 0
        Top = 0
        Width = 889
        Height = 426
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 437
        object Label4: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 28
          Width = 879
          Height = 13
          Align = alTop
          Caption = 
            '       Ao confirmar, na etapa que gera o financeiro ser'#225' poss'#237've' +
            'l revisar e alterar o parcelamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 448
        end
        object Label35: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 116
          Width = 879
          Height = 13
          Align = alTop
          Caption = 
            '       Por padr'#227'o o sistema s'#243' atualiza o custo de notas de comp' +
            'ra ou notas com valor financeiro informado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 499
        end
        object Chbx_CreditoFinanceiro: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 70
          Width = 879
          Height = 17
          Align = alTop
          Caption = 'Gerar cr'#233'dito no Contas '#224' Receber'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ChBx_FinManual: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 47
          Width = 879
          Height = 17
          Align = alTop
          Caption = 'Informar Finaceiro Manualmente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Chbx_Financeiro: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 879
          Height = 17
          Align = alTop
          Caption = 
            'O Sistema vai gerar o financeiro conforme informa'#231#227'o na parte co' +
            'bran'#231'a - TAG de Duplicata ou TAG de Faturamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object Chbx_ForcaCusto: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 93
          Width = 879
          Height = 17
          Align = alTop
          Caption = 'For'#231'ar atualiza'#231#227'o do custo independente da opera'#231#227'o da nota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ChBx_CalculoCustoMedioBonificacao: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 135
          Width = 879
          Height = 17
          Align = alTop
          Caption = 'Efetuar o c'#225'lculo do custo m'#233'dio para transa'#231#245'es de bonifica'#231#245'es'
          TabOrder = 4
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Refer'#234'ncia CFOP'
      ImageIndex = 4
      ExplicitHeight = 437
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 889
        Height = 426
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 437
        DesignSize = (
          889
          426)
        object StrGrd_CFOP: TStringGrid
          Left = 2
          Top = 2
          Width = 885
          Height = 381
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clMoneyGreen
          ColCount = 7
          DefaultColWidth = 40
          DefaultRowHeight = 18
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          ParentFont = False
          TabOrder = 0
          OnDrawCell = StrGrd_CFOPDrawCell
          ExplicitHeight = 392
          ColWidths = (
            40
            40
            40
            40
            40
            40
            40)
          RowHeights = (
            18
            18)
        end
        object Sb_CFOP: TBitBtn
          Left = 7
          Top = 389
          Width = 140
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Aplicar c'#243'digo interno'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
            333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
            0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
            0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
            33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
            B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
            3BB33773333773333773B333333B3333333B7333333733333337}
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          OnClick = Sb_CFOPClick
          ExplicitTop = 400
        end
      end
    end
    object tbs_adicional: TTabSheet
      Caption = 'Informa'#231#245'es Adicionais'
      ImageIndex = 5
      ExplicitHeight = 437
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 889
        Height = 426
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 437
        object GroupBox5: TGroupBox
          Left = 3
          Top = 4
          Width = 212
          Height = 63
          Caption = 'Controle de Retorno das Notas Fiscais'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Lb_Controle: TLabel
            Left = 7
            Top = 15
            Width = 153
            Height = 14
            Caption = 'Informe a Nota Fiscal de Origem'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_DocVinculado: TEdit_Setes
            Left = 6
            Top = 31
            Width = 105
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = ''
          end
        end
        object GroupBox6: TGroupBox
          Left = 219
          Top = 4
          Width = 331
          Height = 63
          Caption = 'C'#225'culo do Custo do Frete - (Caso n'#227'o conste na Nota Fiscal'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Label36: TLabel
            Left = 7
            Top = 15
            Width = 72
            Height = 14
            Caption = 'Informe o valor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_VL_Frete_Extra: TEdit_Setes
            Left = 6
            Top = 31
            Width = 105
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,00'
          end
        end
        object GroupBox7: TGroupBox
          Left = 554
          Top = 4
          Width = 156
          Height = 63
          Caption = 'Informe Custos Adicionais '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Label38: TLabel
            Left = 7
            Top = 15
            Width = 72
            Height = 14
            Caption = 'Informe o valor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Vl_Outras_Extra: TEdit_Setes
            Left = 3
            Top = 33
            Width = 105
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,00'
          end
        end
      end
    end
    object tbs_processo: TTabSheet
      Caption = 'Acompanhamento do Processo'
      ImageIndex = 2
      ExplicitHeight = 437
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 889
        Height = 426
        ActivePage = TabSheet4
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 437
        object TabSheet4: TTabSheet
          Caption = 'Informa'#231#245'es para o Sistema'
          ExplicitHeight = 409
          object MemoResp: TMemo
            Left = 0
            Top = 0
            Width = 881
            Height = 398
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Courier'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            ExplicitHeight = 409
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Retorno da Receita'
          ImageIndex = 1
          ExplicitHeight = 409
          object MM_REceita: TMemo
            Left = 0
            Top = 0
            Width = 881
            Height = 398
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Courier'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            ExplicitHeight = 409
          end
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Teste'
      ImageIndex = 6
      TabVisible = False
      ExplicitHeight = 437
      object Scx_Parcela: TScrollBox
        Left = 0
        Top = 0
        Width = 889
        Height = 426
        HorzScrollBar.Visible = False
        VertScrollBar.Smooth = True
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 437
      end
    end
  end
  object OpenDialogo: TOpenDialog
    FileName = 'C:\gestao2002\trunk\Gestao2002\Source\Gestao.dproj.local'
    Filter = 'Arquivos NFe|*.xml'
    Options = [ofReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 504
    Top = 64
  end
  object ds_itens_nota: TDataSource
    DataSet = cds_itens_nota
    Left = 544
    Top = 272
  end
  object cds_itens_nota: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 544
    Top = 216
    object cds_itens_notaitem: TStringField
      FieldName = 'item'
      Size = 5
    end
    object cds_itens_notacodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_itens_notadescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o do Produto/Servi'#231'o'
      FieldName = 'descricao'
      Size = 100
    end
    object cds_itens_notaunidade: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'unidade'
    end
    object cds_itens_notaqtde: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'qtde'
    end
    object cds_itens_notavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorUnitario'
    end
    object cds_itens_notavalorDesconto: TFloatField
      DisplayLabel = 'Valor Desconto'
      FieldName = 'valorDesconto'
    end
    object cds_itens_notavalorTotal: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'valorTotal'
    end
    object cds_itens_notacodigoNota: TStringField
      FieldName = 'codigoNota'
    end
    object cds_itens_notacodigoInterno: TIntegerField
      DisplayLabel = 'C'#243'd Interno'
      FieldName = 'codigoInterno'
    end
    object cds_itens_notacodigoFabrica: TStringField
      FieldName = 'codigoFabrica'
    end
    object cds_itens_notabarras: TStringField
      FieldName = 'barras'
    end
    object cds_itens_notadescricaoInterna: TStringField
      DisplayLabel = 'Vinculado ao Produto interno'
      FieldName = 'descricaoInterna'
      Size = 100
    end
    object cds_itens_notacodigoEstoque: TIntegerField
      FieldName = 'codigoEstoque'
    end
    object cds_itens_notadescricaoEstoque: TStringField
      DisplayLabel = 'Descri'#231#227'o do Estoque'
      FieldName = 'descricaoEstoque'
      Size = 50
    end
    object cds_itens_notancmNota: TStringField
      DisplayLabel = 'N.C.M'
      FieldName = 'ncmNota'
      Size = 10
    end
    object cds_itens_notaorigemNota: TStringField
      FieldName = 'origemNota'
      Size = 2
    end
    object cds_itens_notastNota: TStringField
      FieldName = 'stNota'
      Size = 2
    end
    object cds_itens_notaduplicate: TStringField
      FieldName = 'duplicate'
      Size = 1
    end
    object cds_itens_notaloteNumero: TStringField
      DisplayLabel = 'N'#250'mero Lote'
      FieldName = 'loteNumero'
      Size = 50
    end
    object cds_itens_notaloteVencimento: TDateField
      DisplayLabel = 'Vencimento Lote'
      FieldName = 'loteVencimento'
      EditMask = '!99/99/0000;1;_'
    end
    object cds_itens_notafrete: TFloatField
      FieldName = 'frete'
    end
    object cds_itens_notaseguro: TFloatField
      FieldName = 'seguro'
    end
    object cds_itens_notaoutras: TFloatField
      FieldName = 'outras'
    end
    object cds_itens_notavalortotalFixo: TFloatField
      FieldName = 'valortotalFixo'
    end
  end
end
