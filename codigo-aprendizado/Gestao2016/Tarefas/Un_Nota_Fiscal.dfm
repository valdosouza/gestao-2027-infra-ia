object Fr_Nota_Fiscal: TFr_Nota_Fiscal
  Left = 324
  Top = 13
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o - Notas Fiscais'
  ClientHeight = 541
  ClientWidth = 716
  Color = clBtnFace
  Constraints.MinHeight = 578
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_corpo: TPanel
    Left = 0
    Top = 0
    Width = 716
    Height = 479
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object PG_Principal: TPageControl
      Left = 2
      Top = 2
      Width = 712
      Height = 475
      ActivePage = Tbs_Servico
      Align = alClient
      MultiLine = True
      TabOrder = 0
      object tbs_nota: TTabSheet
        Caption = 'Dados Notas'
        ImageIndex = 4
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 704
          Height = 177
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = 'Panel4'
          TabOrder = 0
          object Label3: TLabel
            Left = 7
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
          object Label4: TLabel
            Left = 310
            Top = 3
            Width = 27
            Height = 14
            Caption = 'CFOP'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label38: TLabel
            Left = 371
            Top = 3
            Width = 72
            Height = 14
            Caption = 'N'#250'mero Pedido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 479
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
          object Label39: TLabel
            Left = 593
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
            Left = 2
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
              Left = 58
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
            object Label5: TLabel
              Left = 7
              Top = 14
              Width = 33
              Height = 14
              Caption = 'C'#243'digo'
            end
            object E_RazaoSocial: TDBEdit
              Left = 56
              Top = 28
              Width = 371
              Height = 22
              DataField = 'EMP_NOME'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object E_Cnpj_CPf: TDBEdit
              Left = 429
              Top = 28
              Width = 152
              Height = 22
              DataField = 'EMP_CNPJ'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object E_Endereco: TDBEdit
              Left = 7
              Top = 65
              Width = 321
              Height = 22
              DataField = 'END_ENDER'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object E_Bairro: TDBEdit
              Left = 329
              Top = 65
              Width = 170
              Height = 22
              DataField = 'END_BAIRRO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object E_Cep: TDBEdit
              Left = 502
              Top = 65
              Width = 80
              Height = 22
              DataField = 'END_CEP'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
            object E_Cidade: TDBEdit
              Left = 7
              Top = 102
              Width = 278
              Height = 22
              DataField = 'CDD_DESCRICAO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object E_Fone: TDBEdit
              Left = 285
              Top = 102
              Width = 92
              Height = 22
              DataField = 'END_FONE'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object E_Estado: TDBEdit
              Left = 379
              Top = 102
              Width = 44
              Height = 22
              DataField = 'UFE_SIGLA'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object E_Insc_Est: TDBEdit
              Left = 426
              Top = 102
              Width = 154
              Height = 22
              DataField = 'EMP_INSC_EST'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object E_CodCli: TDBEdit
              Left = 7
              Top = 28
              Width = 48
              Height = 22
              DataField = 'EMP_CODIGO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
          object E_Natureza: TDBEdit
            Left = 5
            Top = 18
            Width = 297
            Height = 22
            DataField = 'NAT_DESCRICAO'
            DataSource = DS_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object E_Cfop: TDBEdit
            Left = 310
            Top = 18
            Width = 57
            Height = 22
            DataField = 'NAT_CFOP'
            DataSource = DS_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object E_Pedido: TDBEdit
            Left = 370
            Top = 18
            Width = 107
            Height = 22
            DataField = 'PED_NUMERO'
            DataSource = DS_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object E_Nota: TDBEdit
            Left = 478
            Top = 18
            Width = 112
            Height = 22
            DataField = 'NFL_NUMERO'
            DataSource = DS_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object E_Vl_Total: TDBEdit
            Left = 583
            Top = 18
            Width = 115
            Height = 22
            DataField = 'NFL_VL_TL_NOTA'
            DataSource = DS_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object GroupBox3: TGroupBox
            Left = 583
            Top = 40
            Width = 115
            Height = 132
            Caption = ' Data Limite '
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
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
            object E_Dt_Emissao: TDBEdit
              Left = 5
              Top = 32
              Width = 104
              Height = 22
              DataField = 'NFL_DT_EMISSAO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 0
            end
            object E_Dt_Saida: TDBEdit
              Left = 5
              Top = 83
              Width = 103
              Height = 22
              DataField = 'NFL_DT_SAIDA'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 1
            end
          end
        end
        object Pg_Totalizador: TPageControl
          AlignWithMargins = True
          Left = 0
          Top = 180
          Width = 704
          Height = 140
          Margins.Left = 0
          Margins.Right = 0
          ActivePage = TabSheet2
          Align = alTop
          TabOrder = 1
          object TabSheet2: TTabSheet
            Caption = 'Totalizador'
            object Label8: TLabel
              Left = 3
              Top = 2
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
              Left = 145
              Top = 2
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
              Left = 281
              Top = 2
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
              Left = 420
              Top = 2
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
              Left = 4
              Top = 37
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
              Left = 142
              Top = 37
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
              Left = 281
              Top = 37
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
              Left = 420
              Top = 37
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
              Left = 558
              Top = 2
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
              Left = 558
              Top = 37
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
              Left = 2
              Top = 73
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
              Left = 69
              Top = 73
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
              Left = 200
              Top = 73
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
              Left = 387
              Top = 74
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
              Left = 483
              Top = 74
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
              Left = 601
              Top = 73
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
            object E_Bs_Icms: TDBEdit
              Left = 2
              Top = 14
              Width = 137
              Height = 22
              DataField = 'NFL_BS_ICMS'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object E_Vl_Icms: TDBEdit
              Left = 142
              Top = 14
              Width = 136
              Height = 22
              DataField = 'NFL_VL_ICMS'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object E_Bs_Icms_St: TDBEdit
              Left = 281
              Top = 14
              Width = 136
              Height = 22
              DataField = 'NFL_BS_ICMS_SUBST'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object E_Vl_Icms_St: TDBEdit
              Left = 420
              Top = 14
              Width = 137
              Height = 22
              DataField = 'NFL_VL_ICMS_SUBST'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object E_Vl_frete: TDBEdit
              Left = 2
              Top = 49
              Width = 137
              Height = 22
              DataField = 'NFL_VL_FRETE'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
            object E_Vl_Seguro: TDBEdit
              Left = 142
              Top = 49
              Width = 136
              Height = 22
              DataField = 'NFL_VL_SEGURO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object E_Vl_Outras: TDBEdit
              Left = 281
              Top = 49
              Width = 136
              Height = 22
              DataField = 'NFL_VL_DESP_ACESS'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object E_Vl_IPI: TDBEdit
              Left = 420
              Top = 49
              Width = 135
              Height = 22
              DataField = 'NFL_VL_IPI'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object E_VL_Produto: TDBEdit
              Left = 558
              Top = 14
              Width = 135
              Height = 22
              DataField = 'NFL_VL_TL_PROD'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object E_VL_Nota: TDBEdit
              Left = 558
              Top = 49
              Width = 135
              Height = 22
              DataField = 'NFL_VL_TL_NOTA'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object E_Qtde: TDBEdit
              Left = 2
              Top = 87
              Width = 65
              Height = 22
              DataField = 'NFL_QT_PRODUTO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object E_Especie: TDBEdit
              Left = 69
              Top = 87
              Width = 127
              Height = 22
              DataField = 'NFL_ESPECIE'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
            end
            object E_MArca: TDBEdit
              Left = 198
              Top = 87
              Width = 184
              Height = 22
              DataField = 'NFL_MARCA'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object E_Numero: TDBEdit
              Left = 385
              Top = 87
              Width = 93
              Height = 22
              DataField = 'NFL_VOL_NUMERO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
            end
            object E_PesoBruto: TDBEdit
              Left = 481
              Top = 87
              Width = 117
              Height = 22
              DataField = 'NFL_PESO_BRUTO'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 14
            end
            object E_PesoLiquido: TDBEdit
              Left = 600
              Top = 87
              Width = 93
              Height = 22
              DataField = 'NFL_PESO_LIQ'
              DataSource = DS_Nota
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
            end
          end
          object TabSheet1: TTabSheet
            Caption = 'Forma de Pagamento/Parcelas'
            ImageIndex = 4
            OnShow = TabSheet1Show
            object Dbg_Financeiro: TDBGrid
              Left = 0
              Top = 0
              Width = 696
              Height = 112
              Align = alClient
              Color = clMoneyGreen
              DataSource = Ds_FormaPgto
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clNavy
              TitleFont.Height = -9
              TitleFont.Name = 'Arial'
              TitleFont.Style = []
              OnDrawColumnCell = Dbg_FinanceiroDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'FIN_PRAZO'
                  Title.Caption = 'Prazo'
                  Visible = False
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'FIN_DT_VENCIMENTO'
                  Title.Alignment = taCenter
                  Title.Caption = 'Vencimento'
                  Width = 110
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FIN_NUMERO'
                  Title.Alignment = taCenter
                  Title.Caption = 'Duplicata'
                  Width = 148
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FIN_VL_PARCELA'
                  Title.Alignment = taCenter
                  Title.Caption = 'Valor Parcela'
                  Width = 108
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'FIN_DT_PAGTO'
                  Title.Alignment = taCenter
                  Title.Caption = 'Data Pagto'
                  Width = 105
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FIN_VL_PAGO'
                  Title.Alignment = taCenter
                  Title.Caption = 'Valor Pago'
                  Width = 91
                  Visible = True
                end>
            end
          end
        end
        object pnl_observacao: TPanel
          Left = 0
          Top = 323
          Width = 704
          Height = 124
          Align = alClient
          TabOrder = 2
          DesignSize = (
            704
            124)
          object Label40: TLabel
            Left = 4
            Top = 3
            Width = 116
            Height = 14
            Caption = 'Observa'#231#245'es do Pedido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 407
            Top = 3
            Width = 92
            Height = 14
            Caption = 'Nome do Vendedor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label43: TLabel
            Left = 407
            Top = 42
            Width = 101
            Height = 14
            Caption = 'Forma de Pagamento'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object sb_obs_nfe: TSpeedButton
            Left = 543
            Top = 84
            Width = 152
            Height = 37
            Anchors = [akRight, akBottom]
            Caption = 'Observa'#231#245'es da Nota Fiscal'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            Transparent = False
            OnClick = sb_obs_nfeClick
          end
          object Sb_Financeiro: TSpeedButton
            Left = 404
            Top = 84
            Width = 130
            Height = 37
            Hint = 'Contas '#224' Receber'
            Anchors = [akRight, akBottom]
            Caption = 'Financeiro '
            Flat = True
            Glyph.Data = {
              36080000424D3608000000000000360400002800000020000000200000000100
              08000000000000040000120B0000120B00000001000000000000000001000000
              020099CC9900F5FFF50098CB9800F2FFF200F7FFF700F1FFF100EEFFEE0097CC
              970097CA9700CCFFCC00D0EFD000E9FFE900DBFFDB00EBFFEB00F9FFF900EDFF
              ED00CEFFCE0000CCFF00DDFFDD00E7FFE70095CA9500D8FFD800D5FFD5003399
              CC00E5FFE50098979800C8F4FF0096C9960043DAFF00E3FFE300E1FFE100D1FF
              D100D4F7FF00FBFFFB00D3ECD30037D7FF00DFFFDF006BE2FF002AD5FF0083E6
              FF00FFFFFF00BBF2FF0016D1FF00B0F0FF00C0E3C000A5EDFF00BFEFBF001FD3
              FF00B9DEB900D4EFD4007FE5FF00BDE1BD00D3FFD300D7FFD700BBECBB009DCD
              E6004CDBFF009BEBFF0094C9940000CBFF009ACD9A0086E7FF00C4E4C4007BE4
              FF00B4DCB40074E4FF004CA5D200ABD5EA00DFF9FF00CAF1CA005CDFFF00AFD8
              AF00C4EFC40064E0FF00FDFFFD00B8EAB800409FCF00D0ECD0008EC6E20077BB
              DD0054DDFF0093EAFF009DCF9D009FD09F00CCE5F2008CE9FF0081C0DF0003CD
              FF00ABD6AB0057ABD500C8E9C800A2D2A200B8DBED000ECFFF00A3D4A300D7EA
              F50063B0D70093C89300C6F2C6006CB5DA00C3E0EF009CCE9C00E0EFF700A7D2
              A700C8E5C800FEFFFE00A7D9A700D7F0D700E1F2E100B3E4B300D0E9D000CCEB
              CC00CCE7CC00E9F9E900E3F6E300EAF4F900EAFBFF00C3F5C300AFE0AF00DCF3
              DC00ACDCAC00A6D5A600C7F8C70009CEFF00E7F4E700C1E8C100CDF5CD00DEF6
              DE00C5E5C600D1F6D100C9FCC9009ACE9A00DBEEDB009A9F9B00F3F8FC00D7EC
              D700E5F8E500A2CDA200D6F3D600D1FAD100EFFCEF00ECF6EB00FBFEFF00DAF7
              DA0000C7FF00CDF9CD00F4FDFF009DC99D00EDF9ED00F0FAF000E4FBE400A2A5
              A200F4FDF400CCFCCC00ECFCEC00A2989500E1F9E100EBFCEB00A8ACA900DDFB
              DD0006CAFB00E8FCE800D5F8D500D6FCD600F7FAFD0098A49900D9FBD90005CC
              FF00DFFDDF00F7FDF700F1FDF100F2FCF20050CCC900E6FBE60062C7EB0008CB
              FC00F4FBF4009AC69A00D4FCD400B2B9B300DBFCDB00A7CC9000E2FCE20000CE
              FF007AD8F500FBFDFE00BDCCBD00EAFDEA00D2FDD20082E7FA00E6ECE600F9FF
              FA00C8D8C800D3E0D30070CFEF00F8FDF80090DEF60097C29700FFFFF600FAFD
              FA0059BAE1008EACAF00BDE4F300FFFFF9005BBDD100DFE6DF0018D0FA0002CF
              FF000ACDFA0040BFDC0026C6EC00FEFEF000FFFFFD007ABAC2006ADBE600EFF6
              E100ECF3D800F8FFF1002FD2F30074E2F10078ADB80011C9F60046D6EE00DEF1
              D1006FBCE0005AD2D50001D0FF0037C9E80097B49700EFFFEB00C8F3EC001CCC
              F300C1DAAA00FBFAEA00CDE1B60046C6E000A1E9EB0086E2E700D9E8C4000BD3
              FF009AE0D80086CCA6009DE8EB00C5EED800E2F5E900AEE6D500D8F3E700F1FF
              F200EEFCE6006ECCB600D9FBF0009BCC98009BCC970000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000119100000000000000000000000000000000000000000000000000
              00000002154F5507020000000000000000000000000000000000000000000000
              00001D60150904A3AC0200000000000000000000000000000000000000000000
              005C3E1A493E711D085D09000000000000000000000000000000000000000002
              1702421F020F0F1D2E05047B1B00000000000000000000000000000000000280
              0E022055780FAF1109064F3C1B27000000000000000000000000000000040418
              164720041A540A07601603161B1919130000000000000000000000000B04BE7C
              630E16470D026332030A73AB1B19191959000000000000000000020B7A543602
              178D042009711102077904031B44441919270000000000000000021202217804
              1704B6A83C0D116C090763321B625B44444E290000000000000000856C120236
              4D0226091A0C0F08028A050287516562625B44B7000000000000000212606C37
              022682A8710C0C9F081D03491B505858516565C8020000000000023012022155
              600E80471A1591334F0742061B453939505851C8490400000000020B0A6F1802
              174A8D261F1A0D0F240C0510875E5E45453950EC061654000000008404120236
              30A51426A11A150D114F4F031B565666665E39B7066E098E000000047C84127F
              1817A569327F8C0D0F086D1B5246686156665EEA6305025A080202040B773836
              1817B369427F4F0D0F081B342B1C2288756861CD0A7905020700020B0B4D3821
              18370E8B49351A150F1B533B2D2B1C22908875C8730403423C0000006C0B3830
              3018171426201A9EDF2A29532F2D2B1C222A2AB7031D6C070400000000022112
              3030170E142699132227433F533B2D2B1C2290B779060908AF02000000000002
              21BE647C141B481E3A4827433F532F2D2B1C34C80403351D0F02000000000000
              005537471B3431281E3A4827433F3B2F1C486A82066007093300000000000000
              000085D73B7D2C3125253A4827413F943D2A4C964005ACA30400000000000000
              000000341E137D2C31251E3A48439013C57E8610062E40085502000000000000
              000000003D2F3D5F2C28251E5257F706966E8972240335321102000000000000
              0000000000007D2A5F2C28283407050610237040329770810000000000000000
              00000000000000003F2D27250C9E050306236B2A234002000000000000000000
              000000000000000000133D161133240306104C6E960000000000000000000000
              000000000000000000000000027407242410C304000000000000000000000000
              0000000000000000000000000000020574060200000000000000000000000000
              0000000000000000000000000000000004000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = Sb_FinanceiroClick
          end
          object E_Ped_Obs: TDBMemo
            Left = 2
            Top = 20
            Width = 399
            Height = 89
            DataField = 'PED_OBS'
            DataSource = DS_Nota
            TabOrder = 0
          end
          object E_Vendedor: TDBEdit
            Left = 407
            Top = 20
            Width = 287
            Height = 22
            DataField = 'CLB_NOME'
            DataSource = DS_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object E_Prazo: TDBEdit
            Left = 406
            Top = 59
            Width = 288
            Height = 22
            DataField = 'PED_PRAZO'
            DataSource = DS_Nota
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
        end
      end
      object Tbs_Produto: TTabSheet
        Caption = '&Produtos'
        DragMode = dmAutomatic
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        object Pnl_Produto: TPanel
          Left = 0
          Top = 0
          Width = 704
          Height = 406
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object DBG_Produtos: TDBGrid
            Left = 2
            Top = 2
            Width = 700
            Height = 277
            Align = alClient
            Color = clMoneyGreen
            DataSource = Ds_ItensNota
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Lucida Console'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick]
            ParentFont = False
            PopupMenu = Pop_Produto
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clNavy
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            OnTitleClick = DBG_ProdutosTitleClick
            Columns = <
              item
                Expanded = False
                FieldName = 'ITF_SEQUENCIA'
                Title.Caption = 'Item'
                Width = 40
                Visible = True
              end
              item
                ButtonStyle = cbsNone
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'Codigo F'#225'brica'
                Width = 99
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o Produto'
                Width = 270
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MED_ABREVIATURA'
                Title.Caption = 'Unidade'
                Width = 51
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_QTDE'
                Title.Caption = 'Qtde'
                Width = 52
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_UNIT'
                Title.Caption = 'Valor Unit'#225'rio'
                Width = 76
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_SUBTOTAL'
                Title.Caption = 'SubTotal'
                Width = 83
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_DESC'
                Title.Caption = 'Desconto'
                Width = 85
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_TOTAL'
                Title.Caption = 'Total'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_AQ_COM'
                Title.Caption = 'Aliq. Com'
                Width = 58
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_COM'
                Title.Caption = 'Vl. Comiss'#227'o'
                Width = 98
                Visible = True
              end>
          end
          object Pg_Imposto: TPageControl
            Left = 2
            Top = 279
            Width = 700
            Height = 125
            ActivePage = tbs_icms
            Align = alBottom
            TabOrder = 1
            object tbs_icms: TTabSheet
              Caption = 'ICMS'
              object DBGrid1: TDBGrid
                Left = 0
                Top = 0
                Width = 692
                Height = 96
                Align = alClient
                Color = clMoneyGreen
                DataSource = Ds_Icms
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Lucida Console'
                Font.Style = []
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick]
                ParentFont = False
                PopupMenu = Pop_Produto
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clNavy
                TitleFont.Height = -11
                TitleFont.Name = 'Arial'
                TitleFont.Style = []
                OnTitleClick = DBG_ProdutosTitleClick
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'NAT_CFOP'
                    Title.Caption = 'C.F.O.P'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'NAT_DESCRICAO'
                    Title.Caption = 'Descri'#231#227'o C.F.O.P'
                    Width = 343
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICM_VL_BC_NR'
                    Title.Caption = 'Valor Base'
                    Width = 91
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICM_AQ_NR'
                    Title.Caption = 'Aliquota'
                    Width = 51
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICM_VL_NR'
                    Title.Caption = 'Valor '
                    Width = 79
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'TEMFINANCEIRO'
                    Title.Caption = 'Financeiro'
                    Visible = True
                  end>
              end
            end
            object tbs_ipi: TTabSheet
              Caption = 'IPI'
              ImageIndex = 1
              TabVisible = False
            end
            object tbs_pis: TTabSheet
              Caption = 'PIS'
              ImageIndex = 2
              TabVisible = False
            end
            object tbs_cofins: TTabSheet
              Caption = 'COFINS'
              ImageIndex = 3
              TabVisible = False
            end
            object tbs_II: TTabSheet
              Caption = 'II'
              ImageIndex = 4
              TabVisible = False
            end
            object tbs_dev_ajustes: TTabSheet
              Caption = 'Itens Devolvido pelo Ajuste'
              ImageIndex = 5
              OnShow = tbs_dev_ajustesShow
              object DBGrid2: TDBGrid
                Left = 0
                Top = 0
                Width = 692
                Height = 96
                Align = alClient
                Color = clMoneyGreen
                DataSource = Ds_ItensDevAjuste
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Lucida Console'
                Font.Style = []
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick]
                ParentFont = False
                PopupMenu = Pop_Produto
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clNavy
                TitleFont.Height = -11
                TitleFont.Name = 'Arial'
                TitleFont.Style = []
                OnTitleClick = DBG_ProdutosTitleClick
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'ITF_SEQUENCIA'
                    Title.Caption = 'Item'
                    Width = 40
                    Visible = True
                  end
                  item
                    ButtonStyle = cbsNone
                    Expanded = False
                    FieldName = 'PRO_CODIGOFAB'
                    Title.Caption = 'Codigo F'#225'brica'
                    Width = 99
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PED_NUMERO'
                    Title.Caption = 'Pedido'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PRO_DESCRICAO'
                    Title.Caption = 'Descri'#231#227'o Produto'
                    Width = 322
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'MED_ABREVIATURA'
                    Title.Caption = 'Unidade'
                    Width = 51
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ITF_QTDE'
                    Title.Caption = 'Qtde'
                    Width = 52
                    Visible = True
                  end>
              end
            end
          end
        end
        object Pnl_Produto_rodape: TPanel
          Left = 0
          Top = 406
          Width = 704
          Height = 41
          Align = alBottom
          TabOrder = 1
          object Sb_Vend_Comissao: TSpeedButton
            AlignWithMargins = True
            Left = 586
            Top = 4
            Width = 114
            Height = 33
            Align = alRight
            Caption = 'Vendedores - F9'
            Enabled = False
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
              BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
              BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
              BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
              BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
              EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
              EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
              EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
              EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
            NumGlyphs = 2
            ParentFont = False
            Transparent = False
            ExplicitLeft = 579
            ExplicitTop = 222
            ExplicitHeight = 32
          end
        end
      end
      object Tbs_Servico: TTabSheet
        Caption = 'Servi'#231'os'
        ImageIndex = 1
        OnShow = Tbs_ServicoShow
        object Pnl_Servico: TPanel
          Left = 0
          Top = 0
          Width = 704
          Height = 399
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object DBG_Servicos: TDBGrid
            Left = 2
            Top = 2
            Width = 700
            Height = 395
            Align = alClient
            Color = clMoneyGreen
            DataSource = dst_ItensSrv
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Lucida Console'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clNavy
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ITF_CODPRO'
                Title.Caption = 'Codigo Servi'#231'o'
                Width = 85
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o Servi'#231'o'
                Width = 282
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MED_ABREVIATURA'
                Title.Caption = 'Unidade'
                Width = 56
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_QTDE'
                Title.Caption = 'Qtde'
                Width = 57
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_UNIT'
                Title.Caption = 'Valor Unit'#225'rio'
                Width = 79
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_SUBTOTAL'
                Title.Caption = 'SubTotal'
                Width = 76
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_DESC'
                Title.Caption = 'Desconto'
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_TOTAL'
                Title.Caption = 'Total'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_AQ_COM'
                Title.Caption = 'Aliq Com'
                Visible = True
              end>
          end
        end
        object Pnl_Servico_Rodape: TPanel
          Left = 0
          Top = 399
          Width = 704
          Height = 48
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Sb_Tecnico: TSpeedButton
            AlignWithMargins = True
            Left = 603
            Top = 5
            Width = 96
            Height = 38
            Align = alRight
            Caption = 'T'#233'cnicos - F9'
            Enabled = False
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
              BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
              BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
              BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
              BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
              EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
              EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
              EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
              EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
            NumGlyphs = 2
            ParentFont = False
            Transparent = False
            OnClick = Sb_TecnicoClick
            ExplicitLeft = 610
            ExplicitTop = 6
            ExplicitHeight = 32
          end
          object Sb_Servico: TSpeedButton
            AlignWithMargins = True
            Left = 470
            Top = 5
            Width = 127
            Height = 38
            Align = alRight
            Caption = 'Detalhe Servi'#231'o - F8'
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              333333333333FF3333333333333C0C333333333333F777F3333333333CC0F0C3
              333333333777377F33333333C30F0F0C333333337F737377F333333C00FFF0F0
              C33333F7773337377F333CC0FFFFFF0F0C3337773F33337377F3C30F0FFFFFF0
              F0C37F7373F33337377F00FFF0FFFFFF0F0C7733373F333373770FFFFF0FFFFF
              F0F073F33373F333373730FFFFF0FFFFFF03373F33373F333F73330FFFFF0FFF
              00333373F33373FF77333330FFFFF000333333373F333777333333330FFF0333
              3333333373FF7333333333333000333333333333377733333333333333333333
              3333333333333333333333333333333333333333333333333333}
            NumGlyphs = 2
            ParentFont = False
            Transparent = False
            OnClick = Sb_ServicoClick
            ExplicitTop = 222
            ExplicitHeight = 32
          end
        end
      end
      object Tbs_Devolucao: TTabSheet
        Caption = 'Devolu'#231#227'o'
        ImageIndex = 3
        OnShow = Tbs_DevolucaoShow
        object DBG_Devolucao: TDBGrid
          Left = 0
          Top = 0
          Width = 704
          Height = 447
          Align = alClient
          Color = clMoneyGreen
          DataSource = Ds_ItensDev
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowSelect]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clNavy
          TitleFont.Height = -11
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'PRO_CODIGOFAB'
              Title.Caption = 'Codigo F'#225'brica'
              Width = 86
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o Produto'
              Width = 282
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MED_ABREVIATURA'
              Title.Caption = 'Unidade'
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_QTDE'
              Title.Caption = 'Qtde'
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_UNIT'
              Title.Caption = 'Valor Unit'#225'rio'
              Width = 69
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_TOTAL'
              Title.Caption = 'SubTotal'
              Width = 76
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_AQ_COM'
              Title.Caption = 'Aliq Com'
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_DESC'
              Title.Caption = 'Desconto'
              Width = 85
              Visible = True
            end>
        end
      end
      object Tbs_Conserto: TTabSheet
        Caption = 'Conserto'
        ImageIndex = 4
        OnShow = Tbs_ConsertoShow
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 704
          Height = 257
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            704
            257)
          object Label58: TLabel
            Left = 7
            Top = 90
            Width = 79
            Height = 14
            Caption = 'Defeito Relatado'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label59: TLabel
            Left = 4
            Top = 169
            Width = 199
            Height = 14
            Caption = 'Defeito Constatado/Solu'#231#227'o Apresentada'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label60: TLabel
            Left = 377
            Top = 82
            Width = 247
            Height = 14
            Caption = 'Nome do T'#233'cnico (Somente para conserto Externo)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label61: TLabel
            Left = 377
            Top = 120
            Width = 104
            Height = 14
            Caption = 'Situa'#231#227'o do Conserto'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label62: TLabel
            Left = 483
            Top = 43
            Width = 58
            Height = 14
            Caption = 'Valor Pe'#231'as'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label63: TLabel
            Left = 589
            Top = 43
            Width = 66
            Height = 14
            Caption = 'Valor M. Obra'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label64: TLabel
            Left = 713
            Top = 42
            Width = 69
            Height = 14
            Anchors = [akTop]
            BiDiMode = bdLeftToRight
            Caption = 'Data Conserto'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            ExplicitLeft = 707
          end
          object Label65: TLabel
            Left = 375
            Top = 42
            Width = 56
            Height = 14
            BiDiMode = bdLeftToRight
            Caption = 'Valor Custo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
          end
          object Label66: TLabel
            Left = 554
            Top = 2
            Width = 129
            Height = 14
            Caption = 'N'#250'mero S'#233'rie/Identifica'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label67: TLabel
            Left = 8
            Top = 2
            Width = 44
            Height = 14
            Caption = 'Aparelho'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label68: TLabel
            Left = 182
            Top = 2
            Width = 30
            Height = 14
            Caption = 'Marca'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label69: TLabel
            Left = 380
            Top = 2
            Width = 34
            Height = 14
            Caption = 'Modelo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label70: TLabel
            Left = 9
            Top = 40
            Width = 56
            Height = 14
            Caption = 'Acess'#243'rios'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label71: TLabel
            Left = 480
            Top = 231
            Width = 93
            Height = 20
            Caption = 'Valor Total:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_VL_Total: TLabel
            Left = 576
            Top = 231
            Width = 115
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label24: TLabel
            Left = 376
            Top = 160
            Width = 77
            Height = 14
            Caption = 'Data de Entrega'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBMemo2: TDBMemo
            Left = 5
            Top = 104
            Width = 365
            Height = 62
            DataField = 'CST_RELATADO'
            DataSource = ds_conserto
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
          end
          object DBMemo3: TDBMemo
            Left = 5
            Top = 185
            Width = 365
            Height = 67
            DataField = 'CST_CONSTATADO'
            DataSource = ds_conserto
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 6
          end
          object DBEdit2: TDBEdit
            Left = 587
            Top = 57
            Width = 105
            Height = 21
            DataField = 'CST_VL_MOBRA'
            DataSource = ds_conserto
            TabOrder = 9
          end
          object DBEdit3: TDBEdit
            Left = 481
            Top = 57
            Width = 105
            Height = 21
            Color = clWhite
            DataField = 'CST_VL_PECAS'
            DataSource = ds_conserto
            TabOrder = 8
          end
          object DBEdit4: TDBEdit
            Left = 704
            Top = 57
            Width = 78
            Height = 21
            Anchors = [akTop]
            BiDiMode = bdRightToLeftNoAlign
            DataField = 'CST_DT_CONSERTO'
            ParentBiDiMode = False
            TabOrder = 10
          end
          object DBEdit5: TDBEdit
            Left = 374
            Top = 57
            Width = 105
            Height = 21
            BiDiMode = bdRightToLeftNoAlign
            Color = clWhite
            DataField = 'CST_VL_CUSTO'
            DataSource = ds_conserto
            ParentBiDiMode = False
            TabOrder = 7
          end
          object E_NumSerie: TDBEdit
            Left = 552
            Top = 17
            Width = 138
            Height = 21
            CharCase = ecUpperCase
            DataField = 'CST_NUMERO'
            DataSource = ds_conserto
            TabOrder = 3
          end
          object db_aparelho: TDBEdit
            Left = 5
            Top = 17
            Width = 172
            Height = 21
            CharCase = ecUpperCase
            DataField = 'CST_APARELHO'
            DataSource = ds_conserto
            TabOrder = 0
          end
          object db_marca: TDBEdit
            Left = 178
            Top = 17
            Width = 189
            Height = 21
            CharCase = ecUpperCase
            DataField = 'CST_MARCA'
            DataSource = ds_conserto
            TabOrder = 1
          end
          object db_modelo_conset: TDBEdit
            Left = 374
            Top = 17
            Width = 176
            Height = 21
            CharCase = ecUpperCase
            DataField = 'CST_MODELO'
            DataSource = ds_conserto
            TabOrder = 2
          end
          object MM_Acessorios: TDBMemo
            Left = 6
            Top = 54
            Width = 362
            Height = 35
            DataField = 'CST_ACESSORIO'
            DataSource = ds_conserto
            TabOrder = 4
          end
          object DBEdit9: TDBEdit
            Left = 376
            Top = 97
            Width = 314
            Height = 21
            CharCase = ecUpperCase
            DataField = 'EMP_NOME'
            DataSource = ds_conserto
            TabOrder = 11
          end
          object DBEdit10: TDBEdit
            Left = 376
            Top = 135
            Width = 315
            Height = 21
            CharCase = ecUpperCase
            DataField = 'SIT_DESCRICAO'
            DataSource = ds_conserto
            TabOrder = 12
          end
          object DBEdit1: TDBEdit
            Left = 374
            Top = 175
            Width = 195
            Height = 21
            CharCase = ecUpperCase
            DataField = 'CST_DT_ENTREGA'
            DataSource = ds_conserto
            TabOrder = 13
          end
        end
      end
    end
  end
  object pnl_rodape: TPanel
    Left = 0
    Top = 479
    Width = 716
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      716
      62)
    object Sb_Sair_0: TSpeedButton
      Left = 618
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
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 614
    end
  end
  object Qr_ItensNota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
    AfterScroll = Qr_ItensNotaAfterScroll
    OnCalcFields = Qr_ItensNotaCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  it.ITF_CODIGO,'
      '  it.ITF_CODPRO, '
      '  md.MED_ABREVIATURA,'
      '  pd.PRO_CODIGOFAB,'
      '  pd.PRO_CODIGONCM,'
      '  pd.PRO_ORIGEM,'
      '  pd.PRO_TIPO,'
      '  pd.PRO_DESCRICAO,'
      '  pd.PRO_SERIE,'
      '  eb.EMB_ABREVIATURA,'
      '  it.ITF_QTDE,'
      '  it.ITF_VL_UNIT,'
      '  it.ITF_ESTOQUE,'
      '  it.ITF_OPER,'
      '  it.ITF_CODEST,'
      '  it.ITF_AQ_COM,'
      '  CAST(( (it.ITF_QTDE * it.ITF_VL_UNIT) * (it.ITF_AQ_COM/100)) AS DOUBLE PRECISION) ITF_VL_COM,'
      '  it.ITF_VL_DESC,'
      '  pd.PRO_VL_CUSTOMED,'
      '  it.ITF_AQ_DESC,'
      '  it.ITF_AQ_IPI,'
      '  it.ITF_AQ_ICMS,'
      '  it.ITF_CODTPR,'
      '  it.ITF_VL_CUSTO,'
      '  it.ITF_IMP_APROX,'
      '  it.ITF_SEQUENCIA'
      'FROM TB_ITENS_NFL it'
      '   INNER JOIN TB_PRODUTO pd'
      '   ON  (pd.PRO_CODIGO = it.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA md'
      '   ON  (md.MED_CODIGO = pd.PRO_CODMED)'
      '   INNER JOIN tb_embalagem eb'
      '   on (eb.emb_codigo = pd.pro_codemb)'
      'WHERE (it.ITF_CODNFL =:NFL_CODIGO) AND (it.ITF_OPER <> '#39'D'#39')'
      'AND pd.pro_tipo <> '#39'S'#39
      'ORDER BY it.ITF_SEQUENCIA')
    Left = 160
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_ItensNotaITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensNotaITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensNotaMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensNotaPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensNotaPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = '"TB_PRODUTO"."PRO_CODIGONCM"'
      Size = 50
    end
    object Qr_ItensNotaPRO_ORIGEM: TStringField
      FieldName = 'PRO_ORIGEM'
      Origin = '"TB_PRODUTO"."PRO_ORIGEM"'
      Size = 1
    end
    object Qr_ItensNotaPRO_TIPO: TStringField
      FieldName = 'PRO_TIPO'
      Origin = '"TB_PRODUTO"."PRO_TIPO"'
      Size = 1
    end
    object Qr_ItensNotaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensNotaPRO_SERIE: TStringField
      FieldName = 'PRO_SERIE'
      Origin = '"TB_PRODUTO"."PRO_SERIE"'
      Size = 1
    end
    object Qr_ItensNotaEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensNotaITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensNotaITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensNotaITF_OPER: TStringField
      FieldName = 'ITF_OPER'
      Origin = '"TB_ITENS_NFL"."ITF_OPER"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensNotaITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensNotaITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_VL_COM: TFloatField
      FieldName = 'ITF_VL_COM'
      ProviderFlags = []
    end
    object Qr_ItensNotaITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensNotaITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_IMP_APROX: TBCDField
      FieldName = 'ITF_IMP_APROX'
      Origin = '"TB_ITENS_NFL"."ITF_IMP_APROX"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensNotaITF_VL_TOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_TOTAL'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object Qr_ItensNotaITF_VL_SUBTOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_SUBTOTAL'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object Qr_ItensNotaITF_SEQUENCIA: TIntegerField
      FieldName = 'ITF_SEQUENCIA'
      Origin = '"TB_ITENS_NFL"."ITF_SEQUENCIA"'
    end
  end
  object Ds_ItensNota: TDataSource
    AutoEdit = False
    DataSet = Qr_ItensNota
    Left = 168
    Top = 160
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
    ForcedRefresh = True
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
      '     PED_CODVDO,'
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
      '      UFE_SIGLA, PED_TIPO,NFL_MODELO'
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
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_NotaEMP_TIPO: TIntegerField
      FieldName = 'EMP_TIPO'
      Origin = '"TB_EMPRESA"."EMP_TIPO"'
      Required = True
    end
    object Qr_NotaNFL_CODMHA: TIntegerField
      FieldName = 'NFL_CODMHA'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODMHA"'
    end
    object Qr_NotaPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotaNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotaNFL_CODPED: TIntegerField
      FieldName = 'NFL_CODPED'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODPED"'
    end
    object Qr_NotaPED_CODFPG: TIntegerField
      FieldName = 'PED_CODFPG'
      Origin = '"TB_PEDIDO"."PED_CODFPG"'
      Required = True
    end
    object Qr_NotaNAT_CODIGO: TIntegerField
      FieldName = 'NAT_CODIGO'
      Origin = '"TB_NATUREZA"."NAT_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object Qr_NotaNAT_DESCRICAO: TStringField
      FieldName = 'NAT_DESCRICAO'
      Origin = '"TB_NATUREZA"."NAT_DESCRICAO"'
      Size = 250
    end
    object Qr_NotaNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = '"TB_NATUREZA"."NAT_CFOP"'
      Size = 10
    end
    object Qr_NotaPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_NotaNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_NUMERO"'
      Size = 10
    end
    object Qr_NotaNFL_VL_TL_NOTA: TBCDField
      FieldName = 'NFL_VL_TL_NOTA'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_TL_NOTA"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = '"TB_EMPRESA"."EMP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_NotaEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = '"TB_EMPRESA"."EMP_CNPJ"'
      Size = 14
    end
    object Qr_NotaEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = '"TB_ENDERECO"."END_ENDER"'
      Size = 100
    end
    object Qr_NotaEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = '"TB_ENDERECO"."END_BAIRRO"'
      Size = 100
    end
    object Qr_NotaEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = '"TB_ENDERECO"."END_CEP"'
      Size = 8
    end
    object Qr_NotaEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
    object Qr_NotaEMP_INSC_EST: TStringField
      FieldName = 'EMP_INSC_EST'
      Origin = '"TB_EMPRESA"."EMP_INSC_EST"'
      Size = 30
    end
    object Qr_NotaEMP_EMAIL: TStringField
      FieldName = 'EMP_EMAIL'
      Origin = '"TB_EMPRESA"."EMP_EMAIL"'
      Size = 100
    end
    object Qr_NotaNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = '"TB_NOTA_FISCAL"."NFL_DT_EMISSAO"'
    end
    object Qr_NotaNFL_DT_SAIDA: TDateField
      FieldName = 'NFL_DT_SAIDA'
      Origin = '"TB_NOTA_FISCAL"."NFL_DT_SAIDA"'
    end
    object Qr_NotaNFL_BS_ICMS: TBCDField
      FieldName = 'NFL_BS_ICMS'
      Origin = '"TB_NOTA_FISCAL"."NFL_BS_ICMS"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_ICMS: TBCDField
      FieldName = 'NFL_VL_ICMS'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_ICMS"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_BS_ICMS_SUBST: TBCDField
      FieldName = 'NFL_BS_ICMS_SUBST'
      Origin = '"TB_NOTA_FISCAL"."NFL_BS_ICMS_SUBST"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_ICMS_SUBST: TBCDField
      FieldName = 'NFL_VL_ICMS_SUBST'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_ICMS_SUBST"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_TL_PROD: TBCDField
      FieldName = 'NFL_VL_TL_PROD'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_TL_PROD"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_FRETE: TBCDField
      FieldName = 'NFL_VL_FRETE'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_FRETE"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_SEGURO: TBCDField
      FieldName = 'NFL_VL_SEGURO'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_SEGURO"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_DESP_ACESS: TBCDField
      FieldName = 'NFL_VL_DESP_ACESS'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_DESP_ACESS"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_IPI: TBCDField
      FieldName = 'NFL_VL_IPI'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_IPI"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_QT_PRODUTO: TBCDField
      FieldName = 'NFL_QT_PRODUTO'
      Origin = '"TB_NOTA_FISCAL"."NFL_QT_PRODUTO"'
      Precision = 18
      Size = 3
    end
    object Qr_NotaNFL_CODTRP: TIntegerField
      FieldName = 'NFL_CODTRP'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODTRP"'
    end
    object Qr_NotaNFL_ESPECIE: TStringField
      FieldName = 'NFL_ESPECIE'
      Origin = '"TB_NOTA_FISCAL"."NFL_ESPECIE"'
      Size = 10
    end
    object Qr_NotaNFL_MARCA: TStringField
      FieldName = 'NFL_MARCA'
      Origin = '"TB_NOTA_FISCAL"."NFL_MARCA"'
      Size = 10
    end
    object Qr_NotaNFL_PESO_BRUTO: TStringField
      FieldName = 'NFL_PESO_BRUTO'
      Origin = '"TB_NOTA_FISCAL"."NFL_PESO_BRUTO"'
      Size = 10
    end
    object Qr_NotaNFL_PESO_LIQ: TStringField
      FieldName = 'NFL_PESO_LIQ'
      Origin = '"TB_NOTA_FISCAL"."NFL_PESO_LIQ"'
      Size = 10
    end
    object Qr_NotaNFL_VOL_NUMERO: TStringField
      FieldName = 'NFL_VOL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_VOL_NUMERO"'
      Size = 8
    end
    object Qr_NotaCLB_NOME: TStringField
      FieldName = 'CLB_NOME'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 100
    end
    object Qr_NotaNFL_STATUS: TStringField
      FieldName = 'NFL_STATUS'
      Origin = '"TB_NOTA_FISCAL"."NFL_STATUS"'
      Size = 1
    end
    object Qr_NotaNFL_TIPO: TStringField
      FieldName = 'NFL_TIPO'
      Origin = '"TB_NOTA_FISCAL"."NFL_TIPO"'
      Size = 2
    end
    object Qr_NotaPED_OBS: TBlobField
      FieldName = 'PED_OBS'
      Origin = '"TB_PEDIDO"."PED_OBS"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object Qr_NotaNFL_VL_TL_SRV: TBCDField
      FieldName = 'NFL_VL_TL_SRV'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_TL_SRV"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaPED_VL_DESCONTO: TBCDField
      FieldName = 'PED_VL_DESCONTO'
      Origin = '"TB_PEDIDO"."PED_VL_DESCONTO"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaPED_DT_ALTERA: TSQLTimeStampField
      FieldName = 'PED_DT_ALTERA'
      Origin = '"TB_PEDIDO"."PED_DT_ALTERA"'
    end
    object Qr_NotaPED_CODTRP: TIntegerField
      FieldName = 'PED_CODTRP'
      Origin = '"TB_PEDIDO"."PED_CODTRP"'
    end
    object Qr_NotaNFE_CODSIT: TIntegerField
      FieldName = 'NFE_CODSIT'
      Origin = '"TB_RETORNO_NFE"."NFE_CODSIT"'
    end
    object Qr_NotaPED_PRAZO: TStringField
      FieldName = 'PED_PRAZO'
      Origin = '"TB_PEDIDO"."PED_PRAZO"'
      Size = 200
    end
    object Qr_NotaCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = '"TB_CIDADE"."CDD_DESCRICAO"'
      Size = 60
    end
    object Qr_NotaUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = '"TB_UF"."UFE_SIGLA"'
      FixedChar = True
      Size = 2
    end
    object Qr_NotaPED_TIPO: TIntegerField
      FieldName = 'PED_TIPO'
      Origin = '"TB_PEDIDO"."PED_TIPO"'
    end
    object Qr_NotaNFL_MODELO: TStringField
      FieldName = 'NFL_MODELO'
      Origin = '"TB_NOTA_FISCAL"."NFL_MODELO"'
      Size = 2
    end
    object Qr_NotaPED_CODVDO: TIntegerField
      FieldName = 'PED_CODVDO'
      Origin = '"TB_PEDIDO"."PED_CODVDO"'
      Required = True
    end
  end
  object DS_Nota: TDataSource
    AutoEdit = False
    DataSet = Qr_Nota
    Left = 88
    Top = 160
  end
  object Qr_Conserto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CONSERTO tb_conserto'
      '  LEFT OUTER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_conserto.CST_CODFOR)'
      '  INNER JOIN TB_SITUACAO tb_situacao'
      '  ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT)'
      'WHERE '
      '  (CST_CODPED=:PED_CODIGO)')
    Left = 548
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Qr_ItensSrv: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
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
      '  CAST((ITF_QTDE * ITF_VL_UNIT) AS NUMERIC(18, 9)) ITF_VL_SUBTOTAL ,'
      '    CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) AS NUMERIC(18, 9)) ITF_VL_TOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   left join tb_embalagem tb_embalagem'
      '     on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = '#39'S'#39')'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    Left = 241
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensSrvITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensSrvITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensSrvITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
    end
    object Qr_ItensSrvITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensSrvPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensSrvEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensSrvITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensSrvITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensSrvITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensSrvITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensSrvITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensSrvMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensSrvITF_VL_SUBTOTAL: TFMTBCDField
      FieldName = 'ITF_VL_SUBTOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 9
    end
    object Qr_ItensSrvITF_VL_TOTAL: TFMTBCDField
      FieldName = 'ITF_VL_TOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 9
    end
  end
  object Ds_FormaPgto: TDataSource
    DataSet = Qr_FPgto
    Left = 481
    Top = 162
  end
  object Qr_FPgto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = DS_Nota
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
    Left = 481
    Top = 114
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
    object Qr_FPgtoFIN_PRAZO: TStringField
      FieldName = 'FIN_PRAZO'
      Origin = '"TB_FINANCEIRO"."FIN_PRAZO"'
      Size = 200
    end
    object Qr_FPgtoFIN_DT_VENCIMENTO: TDateField
      FieldName = 'FIN_DT_VENCIMENTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_VENCIMENTO"'
    end
    object Qr_FPgtoFIN_NUMERO: TStringField
      FieldName = 'FIN_NUMERO'
      Origin = '"TB_FINANCEIRO"."FIN_NUMERO"'
    end
    object Qr_FPgtoFIN_VL_PARCELA: TBCDField
      FieldName = 'FIN_VL_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PARCELA"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_FPgtoFIN_DT_PAGTO: TDateField
      FieldName = 'FIN_DT_PAGTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_PAGTO"'
    end
    object Qr_FPgtoFIN_VL_PAGO: TBCDField
      FieldName = 'FIN_VL_PAGO'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PAGO"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object Qr_FPgtoFIN_DT_BAIXA: TDateField
      FieldName = 'FIN_DT_BAIXA'
      Origin = '"TB_FINANCEIRO"."FIN_DT_BAIXA"'
    end
    object Qr_FPgtoFIN_TIPO: TStringField
      FieldName = 'FIN_TIPO'
      Origin = '"TB_FINANCEIRO"."FIN_TIPO"'
      Size = 2
    end
    object Qr_FPgtoFIN_OPERACAO: TStringField
      FieldName = 'FIN_OPERACAO'
      Origin = '"TB_FINANCEIRO"."FIN_OPERACAO"'
      FixedChar = True
      Size = 1
    end
  end
  object dst_ItensSrv: TDataSource
    DataSet = Qr_ItensSrv
    Left = 241
    Top = 162
  end
  object ds_conserto: TDataSource
    DataSet = Qr_Conserto
    Left = 553
    Top = 162
  end
  object Mnu_Operacao: TMainMenu
    Left = 41
    Top = 114
    object Mnu_Operacao_Tarefas: TMenuItem
      Caption = 'Tarefas'
      object Itm_CadastroDestinatrio: TMenuItem
        Caption = 'Cadastro Destinat'#225'rio'
        OnClick = Itm_CadastroDestinatrioClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Itm_Nfe_Operacao: TMenuItem
        Caption = 'Opera'#231#245'es NF-e'
        OnClick = Itm_Nfe_OperacaoClick
      end
      object Itm_Nfe_Compl: TMenuItem
        Caption = 'Gerar Complementar'
        OnClick = Itm_Nfe_ComplClick
      end
      object Itm_Carta_Correcao: TMenuItem
        Caption = 'Carta de Corre'#231#227'o'
        OnClick = Itm_Carta_CorrecaoClick
      end
      object AnexarXML1: TMenuItem
        Caption = 'Anexar XML'
        OnClick = AnexarXML1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Itm_ImprimirPedido: TMenuItem
        Caption = 'Imprimir Pedido'
        OnClick = Itm_ImprimirPedidoClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MnuAlterarVendedor: TMenuItem
        Caption = 'Alterar Vendedor'
        OnClick = MnuAlterarVendedorClick
      end
      object AtualizarosCustos1: TMenuItem
        Caption = 'Atualizar os Custos'
        OnClick = AtualizarosCustos1Click
      end
      object CalcularaComisso1: TMenuItem
        Caption = 'Recalcular a Comiss'#227'o'
        OnClick = CalcularaComisso1Click
      end
      object AuditoriaEstoque1: TMenuItem
        Caption = 'Auditoria Estoque'
        OnClick = AuditoriaEstoque1Click
      end
      object CpiadePedidoNota1: TMenuItem
        Caption = 'C'#243'pia de Pedido/Nota'
        OnClick = CpiadePedidoNota1Click
      end
      object EnviaPedido1: TMenuItem
        Caption = 'Envia Pedido'
        OnClick = EnviaPedido1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MnuLucratividade: TMenuItem
        Caption = 'Lucratividade'
        OnClick = MnuLucratividadeClick
      end
      object MnuCustoPedido: TMenuItem
        Caption = 'Custo Pedido'
        OnClick = MnuCustoPedidoClick
      end
      object AplicarLote1: TMenuItem
        Caption = 'Aplicar Lote'
        OnClick = AplicarLote1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Acompanhamento1: TMenuItem
        Caption = 'Acompanhamento'
        OnClick = Acompanhamento1Click
      end
    end
  end
  object Qr_ItensDev: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPRO, '
      '  ITF_CODPED,'
      '  MED_ABREVIATURA,'
      '  PRO_CODIGOFAB,'
      '   PRO_TIPO,'
      '  PRO_DESCRICAO,'
      '  EMB_ABREVIATURA,'
      '  ITF_QTDE, '
      '  ITF_VL_UNIT,'
      '  ITF_ESTOQUE,'
      '  ITF_CODEST,'
      '  CAST((ITF_QTDE * ITF_VL_UNIT) AS NUMERIC(18, 9)) AS  ITF_SUBTOTAL,'
      '   CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) AS NUMERIC(18, 9)) ITF_VL_TOTAL,'
      '   ITF_AQ_COM,'
      '  CAST(( (ITF_QTDE * ITF_VL_UNIT) * (ITF_AQ_COM/100)) AS DOUBLE PRECISION) ITF_VL_COM,'
      '   ITF_VL_DESC,'
      '     PRO_VL_CUSTOMED,'
      '  ITF_AQ_DESC,'
      '  ITF_AQ_IPI,'
      '  ITF_AQ_ICMS,'
      '  ITF_CODTPR,'
      'ITF_VL_CUSTO'
      'FROM TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   INNER JOIN tb_embalagem tb_embalagem'
      '   on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      'WHERE (ITF_CODNFL = :NFL_CODIGO) and ITF_OPER = '#39'D'#39' '
      'AND tb_produto.pro_tipo <> '#39'S'#39)
    Left = 352
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensDevITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensDevITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensDevITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensDevMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensDevPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensDevPRO_TIPO: TStringField
      FieldName = 'PRO_TIPO'
      Origin = '"TB_PRODUTO"."PRO_TIPO"'
      Size = 1
    end
    object Qr_ItensDevPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensDevEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensDevITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensDevITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensDevITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensDevITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensDevITF_SUBTOTAL: TFMTBCDField
      FieldName = 'ITF_SUBTOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 9
    end
    object Qr_ItensDevITF_VL_TOTAL: TFMTBCDField
      FieldName = 'ITF_VL_TOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 9
    end
    object Qr_ItensDevITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensDevITF_VL_COM: TFloatField
      FieldName = 'ITF_VL_COM'
      ProviderFlags = []
    end
    object Qr_ItensDevITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensDevPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensDevITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensDevITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensDevITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensDevITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensDevITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
  end
  object Ds_ItensDev: TDataSource
    AutoEdit = False
    DataSet = Qr_ItensDev
    Left = 352
    Top = 168
  end
  object Pop_Produto: TPopupMenu
    Left = 580
    Top = 212
    object CadastrodoProduto: TMenuItem
      Caption = 'Cadastro do Produto'
      OnClick = CadastrodoProdutoClick
    end
    object RegistraNmerodolote1: TMenuItem
      Caption = 'Registra N'#250'mero do lote'
      OnClick = RegistraNmerodolote1Click
    end
    object RegistraNmerodeSrie1: TMenuItem
      Caption = 'Registra N'#250'mero de S'#233'rie'
      OnClick = RegistraNmerodeSrie1Click
    end
    object InformaoCombustivel1: TMenuItem
      Caption = 'Informa'#231#227'o Combustivel'
      OnClick = InformaoCombustivel1Click
    end
  end
  object Qr_Icms: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
    ForcedRefresh = True
    OnCalcFields = Qr_IcmsCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select nt.nat_cfop, nt.nat_descricao, IC.icm_vl_bc_nr, ic.icm_aq' +
        '_nr, ic.icm_vl_nr, itb.set_financial'
      'from tb_itens_icms ic'
      '   inner join tb_natureza nt'
      '   on (nt.nat_codigo = ic.icm_codnat)'
      '   LEFT OUTER JOIN tb_itens_nfl_tributacao itb'
      '   on (itb.tb_order_itens_id = ic.icm_coditf)'
      'where ic.icm_coditf =:ITF_cODIGO')
    Left = 652
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ITF_CODIGO'
        ParamType = ptInput
      end>
    object Qr_IcmsNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = '"TB_NATUREZA"."NAT_CFOP"'
      Size = 10
    end
    object Qr_IcmsNAT_DESCRICAO: TStringField
      FieldName = 'NAT_DESCRICAO'
      Origin = '"TB_NATUREZA"."NAT_DESCRICAO"'
      Size = 250
    end
    object Qr_IcmsICM_VL_BC_NR: TFMTBCDField
      FieldName = 'ICM_VL_BC_NR'
      Origin = '"TB_ITENS_ICMS"."ICM_VL_BC_NR"'
      Precision = 18
      Size = 6
    end
    object Qr_IcmsICM_AQ_NR: TBCDField
      FieldName = 'ICM_AQ_NR'
      Origin = '"TB_ITENS_ICMS"."ICM_AQ_NR"'
      Precision = 18
      Size = 2
    end
    object Qr_IcmsICM_VL_NR: TFMTBCDField
      FieldName = 'ICM_VL_NR'
      Origin = '"TB_ITENS_ICMS"."ICM_VL_NR"'
      Precision = 18
      Size = 6
    end
    object Qr_IcmsSET_FINANCIAL: TStringField
      FieldName = 'SET_FINANCIAL'
      Origin = '"TB_ITENS_NFL_TRIBUTACAO"."SET_FINANCIAL"'
      FixedChar = True
      Size = 1
    end
    object Qr_IcmsTEMFINANCEIRO: TStringField
      FieldKind = fkCalculated
      FieldName = 'TEMFINANCEIRO'
      Calculated = True
    end
  end
  object Ds_Icms: TDataSource
    DataSet = Qr_Icms
    Left = 649
    Top = 170
  end
  object Qr_ItensDevAjuste: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Interface
    ForcedRefresh = True
    AfterScroll = Qr_ItensDevAjusteAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  it.ITF_CODIGO,'
      '  it.ITF_SEQUENCIA,'
      '  pe.ped_numero,'
      '  pe.Ped_data,'
      '  pe.ped_tipo,'
      '  it.ITF_CODPRO, '
      '  MED_ABREVIATURA,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  itdev.itf_qtde'
      'FROM TB_ITENS_NFL it'
      '   INNER JOIN tb_itens_dev dev'
      '   ON (dev.itd_coditf_orig = it.itf_codigo)'
      '   INNER JOIN tb_itens_nfl itDev'
      '   on (itDev.itf_codigo = dev.itd_coditf_dest)'
      '   INNER JOIN TB_PEDIDO pe'
      '   on (pe.ped_codigo = itDev.itf_codped)'
      '   INNER JOIN TB_PRODUTO pr'
      '   ON  (pr.PRO_CODIGO = itDev.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA me'
      '   ON  (me.MED_CODIGO = pr.PRO_CODMED)'
      '   INNER JOIN tb_embalagem em'
      '   on (em.emb_codigo = pr.pro_codemb)'
      'WHERE (it.ITF_CODNFL = :NFL_CODIGO)'
      'ORDER BY it.ITF_SEQUENCIA')
    Left = 416
    Top = 128
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensDevAjusteITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensDevAjusteITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensDevAjusteMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensDevAjustePRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensDevAjustePRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensDevAjusteITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensDevAjusteITF_SEQUENCIA: TIntegerField
      FieldName = 'ITF_SEQUENCIA'
      Origin = '"TB_ITENS_NFL"."ITF_SEQUENCIA"'
    end
    object Qr_ItensDevAjustePED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
  end
  object Ds_ItensDevAjuste: TDataSource
    AutoEdit = False
    DataSet = Qr_ItensDevAjuste
    Left = 416
    Top = 176
  end
  object IBT_Interface: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Left = 48
    Top = 480
  end
end
