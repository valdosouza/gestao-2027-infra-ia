object Fr_Fatura_Cpa: TFr_Fatura_Cpa
  Left = 425
  Top = 62
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Par'#226'metros de Gera'#231#227'o de Notas Fiscais - Faturamento'
  ClientHeight = 525
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object E_M_Nota: TMemo
    Left = 680
    Top = 4
    Width = 465
    Height = 145
    TabOrder = 0
  end
  object E_M_Fisco: TMemo
    Left = 680
    Top = 156
    Width = 465
    Height = 145
    TabOrder = 1
  end
  object Panel4: TPanel
    Left = 0
    Top = 273
    Width = 680
    Height = 183
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Pg_Resumo: TPageControl
      Left = 2
      Top = 2
      Width = 676
      Height = 179
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Totais da Nota'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 668
          Height = 151
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label22: TLabel
            Left = 6
            Top = 3
            Width = 105
            Height = 14
            Caption = 'Base C'#225'lculo do ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 141
            Top = 3
            Width = 67
            Height = 14
            Caption = 'Valor do ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 271
            Top = 3
            Width = 124
            Height = 14
            Caption = 'Base C'#225'lculo ICMS Subst.'
            FocusControl = E_Vl_Bs_Icms_St
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 403
            Top = 3
            Width = 114
            Height = 14
            Caption = 'Valor ICMS Substitui'#231#227'o'
            FocusControl = E_Vl_Icms_St
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label28: TLabel
            Left = 7
            Top = 39
            Width = 68
            Height = 14
            Caption = 'Valor do Frete'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label29: TLabel
            Left = 140
            Top = 39
            Width = 78
            Height = 14
            Caption = 'Valor do Seguro'
            FocusControl = E_Vl_Seguro
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 271
            Top = 39
            Width = 141
            Height = 14
            Caption = 'Outras despesas acess'#243'rias'
            FocusControl = E_Vl_Outras
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 403
            Top = 39
            Width = 53
            Height = 14
            Caption = 'Valor do IPI'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label32: TLabel
            Left = 536
            Top = 3
            Width = 117
            Height = 14
            Caption = 'Valor Total dos Produtos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label34: TLabel
            Left = 5
            Top = 74
            Width = 55
            Height = 14
            Caption = 'Quantidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 603
            Top = 74
            Width = 27
            Height = 14
            Caption = 'RNTC'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 7
            Top = 110
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
          object Label12: TLabel
            Left = 143
            Top = 110
            Width = 90
            Height = 14
            Caption = 'N'#250'mero do Volume'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 536
            Top = 38
            Width = 90
            Height = 14
            Caption = 'Valor Total da Nota'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label39: TLabel
            Left = 273
            Top = 110
            Width = 100
            Height = 14
            Caption = 'Desconto Concedido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label35: TLabel
            Left = 246
            Top = 74
            Width = 94
            Height = 14
            Caption = 'Peso Bruto (em Kg)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label36: TLabel
            Left = 354
            Top = 74
            Width = 102
            Height = 14
            Caption = 'Peso L'#237'quido (em Kg)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label38: TLabel
            Left = 141
            Top = 74
            Width = 38
            Height = 14
            Caption = 'Especie'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label37: TLabel
            Left = 465
            Top = 74
            Width = 64
            Height = 14
            Caption = 'Placa Ve'#237'culo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 542
            Top = 74
            Width = 13
            Height = 14
            Caption = 'UF'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Vl_Bs_Icms_St: TEdit_Setes
            Left = 269
            Top = 17
            Width = 128
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = ''
          end
          object E_Vl_Icms_St: TEdit_Setes
            Left = 401
            Top = 17
            Width = 129
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object E_Vl_Seguro: TEdit_Setes
            Left = 138
            Top = 52
            Width = 128
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            Text = ''
          end
          object E_Vl_Outras: TEdit_Setes
            Left = 269
            Top = 52
            Width = 128
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            Text = ''
          end
          object E_VL_Produto: TPanel
            Left = 535
            Top = 17
            Width = 133
            Height = 22
            Alignment = taRightJustify
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentBackground = False
            ParentFont = False
            TabOrder = 4
          end
          object E_VL_ICMS: TEdit_Setes
            Left = 138
            Top = 17
            Width = 128
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '0,00'
          end
          object E_VL_Bs_ICMS: TEdit_Setes
            Left = 6
            Top = 17
            Width = 129
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,00'
          end
          object E_VL_IPI: TEdit_Setes
            Left = 401
            Top = 52
            Width = 129
            Height = 21
            Alignment = taRightJustify
            TabOrder = 8
            Text = '0,00'
          end
          object E_VL_Frete: TEdit_Setes
            Left = 6
            Top = 52
            Width = 129
            Height = 21
            Alignment = taRightJustify
            TabOrder = 5
            Text = '0,00'
          end
          object E_Qt_Produto: TEdit_Setes
            Left = 6
            Top = 88
            Width = 129
            Height = 21
            Alignment = taRightJustify
            TabOrder = 10
            Text = '0,00'
            OnChange = E_Qt_ProdutoChange
          end
          object E_RNTC: TEdit
            Left = 591
            Top = 88
            Width = 71
            Height = 21
            TabOrder = 16
          end
          object E_Marca: TEdit
            Left = 6
            Top = 123
            Width = 130
            Height = 21
            Enabled = False
            MaxLength = 10
            TabOrder = 17
          end
          object E_Vol_Numero: TEdit
            Left = 138
            Top = 123
            Width = 129
            Height = 21
            Enabled = False
            MaxLength = 8
            TabOrder = 18
          end
          object E_VL_Nota: TPanel
            Left = 535
            Top = 51
            Width = 134
            Height = 22
            Alignment = taRightJustify
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 9
          end
          object E_Vl_desconto: TPanel
            Left = 269
            Top = 123
            Width = 126
            Height = 22
            Alignment = taRightJustify
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clRed
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 19
          end
          object E_Especie: TEdit
            Left = 138
            Top = 88
            Width = 103
            Height = 21
            Enabled = False
            MaxLength = 10
            TabOrder = 11
          end
          object E_PesoLiq: TEdit_Setes
            Left = 352
            Top = 88
            Width = 107
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 13
            Text = ''
          end
          object E_PesoBruto: TEdit_Setes
            Left = 244
            Top = 88
            Width = 104
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 12
            Text = ''
          end
          object E_Uf_Veiculo: TDBLookupComboBox
            Left = 539
            Top = 88
            Width = 51
            Height = 21
            KeyField = 'UFE_CODIGO'
            ListField = 'UFE_SIGLA'
            ListSource = DM.Ds_UF
            TabOrder = 15
          end
          object E_PlacaVeiculo: TMaskEdit
            Left = 463
            Top = 88
            Width = 72
            Height = 21
            TabOrder = 14
            Text = ''
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 456
    Width = 680
    Height = 69
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 585
      Top = 5
      Width = 90
      Height = 59
      Margins.Left = 1
      Align = alRight
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 582
      ExplicitTop = 10
      ExplicitHeight = 54
    end
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 493
      Top = 5
      Width = 90
      Height = 59
      Margins.Right = 1
      Align = alRight
      Caption = 'Confirmar - F10'
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 273
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object Label9: TLabel
      Left = 8
      Top = 169
      Width = 100
      Height = 14
      Caption = 'Observa'#231#227'o da Nota'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 458
      Top = 4
      Width = 218
      Height = 264
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object Label2: TLabel
        Left = 2
        Top = 2
        Width = 144
        Height = 19
        Align = alTop
        Alignment = taCenter
        Caption = 'Outros Par'#226'metros'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object Label3: TLabel
        Left = 7
        Top = 220
        Width = 99
        Height = 13
        Caption = 'Consolidar Custo N.F'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ChBx_AutorizacaoNFE: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 22
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Solicitar autoriza'#231#227'o NF-e'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object Chbx_Frete: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 60
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Somar o Frete ao Valor Total da Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object ChBx_SomaICMS: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 79
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Somar o ICMS ao Valor Total da Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object ChBx_Nota_Manual: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 41
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Informar N'#250'mero da Nota Manualmente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        WordWrap = True
      end
      object Chbx_SomaIPI_Bs_ICMS: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 98
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Somar o IPI na Base de ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object Chbx_SomaIPI_Bs_ICMS_St: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 117
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Somar o IPI na Base de ICMS Subst. Trib.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object ChBx_Distribuir_ICMS: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 136
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Distribuir o Valor do ICMS normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object ChBx_Distribuir_ICMS_ST: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 155
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Distribuir o Valor do ICMS - Subs. Tribut'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object ChBx_Distribuir_IPI: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 174
        Width = 208
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Distribuir o Valor do IPI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object E_ConsCustoNF: TEdit_Setes
        Left = 6
        Top = 235
        Width = 102
        Height = 22
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Text = ''
      end
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 3
      Width = 178
      Height = 65
      Caption = ' Datas '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Label6: TLabel
        Left = 10
        Top = 19
        Width = 40
        Height = 14
        Caption = 'Emiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Dt_Saida: TDateTimePicker
        Left = 89
        Top = 35
        Width = 81
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object E_Dt_Emissao: TDateTimePicker
        Left = 6
        Top = 35
        Width = 81
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 0
      end
      object chbx_data_saida: TCheckBox
        Left = 89
        Top = 19
        Width = 54
        Height = 17
        Caption = 'Sa'#237'da'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
      end
    end
    object E_Obs: TMemo
      Left = 5
      Top = 187
      Width = 447
      Height = 79
      TabOrder = 2
    end
    object GroupBox5: TGroupBox
      Left = 6
      Top = 70
      Width = 449
      Height = 97
      Caption = 'Informa'#231#245'es sobre o Transporte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object Sb_Transportadora: TSpeedButton
        Left = 417
        Top = 29
        Width = 25
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_TransportadoraClick
      end
      object Label7: TLabel
        Left = 7
        Top = 14
        Width = 114
        Height = 14
        Caption = 'Nome da Transportador'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label33: TLabel
        Left = 7
        Top = 53
        Width = 97
        Height = 14
        Caption = 'Modalidade do Frete'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object DBLCB_Transportadora: TDBLookupComboBox
        Left = 6
        Top = 30
        Width = 406
        Height = 21
        KeyField = 'EMP_CODIGO'
        ListField = 'EMP_FANTASIA'
        ListSource = DM_ListaConsultas.Ds_ListaTransportadora
        TabOrder = 0
        OnKeyDown = DBLCB_TransportadoraKeyDown
      end
      object Dblcb_Modal_Frete: TDBLookupComboBox
        Left = 6
        Top = 68
        Width = 435
        Height = 21
        KeyField = 'MDF_GRUPO'
        ListField = 'DESCRICAO'
        ListSource = Ds_Moral_Frete
        TabOrder = 1
        OnKeyDown = DBLCB_TransportadoraKeyDown
      end
    end
  end
  object Ds_Moral_Frete: TDataSource
    DataSet = DM.Qr_Modal_Frete
    Left = 390
    Top = 253
  end
end
