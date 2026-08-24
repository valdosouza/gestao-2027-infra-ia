object Fr_Fatura_Cst: TFr_Fatura_Cst
  Left = 372
  Top = 18
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Par'#226'metros de Gera'#231#227'o de Notas Fiscais - Faturamento'
  ClientHeight = 548
  ClientWidth = 679
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 679
    Height = 296
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label9: TLabel
      Left = 11
      Top = 167
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
      Height = 272
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object Lb_TipoParcelamento: TLabel
        Left = 6
        Top = 2
        Width = 97
        Height = 16
        Caption = 'Parcelamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 5
        Top = 248
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
        Left = 99
        Top = 246
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
      object StGrd_Prazo: TStringGrid
        Left = 5
        Top = 18
        Width = 210
        Height = 223
        Color = clMoneyGreen
        ColCount = 3
        DefaultRowHeight = 20
        RowCount = 10
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
        ParentFont = False
        ScrollBars = ssNone
        TabOrder = 0
        OnClick = StGrd_PrazoClick
        OnDrawCell = StGrd_PrazoDrawCell
        OnKeyPress = StGrd_PrazoKeyPress
        OnSelectCell = StGrd_PrazoSelectCell
        OnSetEditText = StGrd_PrazoSetEditText
        ColWidths = (
          64
          64
          64)
        RowHeights = (
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20)
      end
      object Tpk_Prazo: TDateTimePicker
        Left = 45
        Top = 39
        Width = 91
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        Date = 38500.743145937500000000
        Time = 38500.743145937500000000
        Checked = False
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = Tpk_PrazoChange
      end
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 3
      Width = 173
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
        Left = 86
        Top = 35
        Width = 78
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object E_Dt_Emissao: TDateTimePicker
        Left = 6
        Top = 35
        Width = 78
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 0
        OnExit = E_Dt_EmissaoExit
      end
      object chbx_data_saida: TCheckBox
        Left = 88
        Top = 19
        Width = 76
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
        OnClick = chbx_data_saidaClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 6
      Top = 69
      Width = 449
      Height = 97
      Caption = 'Informa'#231#245'es sobre o Transporte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
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
      object Label2: TLabel
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
      object Label5: TLabel
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
    object E_Obs: TMemo
      Left = 5
      Top = 181
      Width = 447
      Height = 92
      TabOrder = 3
    end
    object ChBx_Duplicata: TCheckBox
      Left = 5
      Top = 276
      Width = 106
      Height = 17
      Caption = 'Imprimir Duplicata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 481
    Width = 679
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      679
      67)
    object SB_Sair_0: TSpeedButton
      Left = 583
      Top = 7
      Width = 89
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
    object SB_Confirmar: TSpeedButton
      Left = 493
      Top = 7
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
  end
  object E_M_Nota: TMemo
    Left = 680
    Top = 4
    Width = 465
    Height = 145
    TabOrder = 2
  end
  object E_M_Fisco: TMemo
    Left = 680
    Top = 156
    Width = 465
    Height = 145
    TabOrder = 3
  end
  object Panel4: TPanel
    Left = 0
    Top = 296
    Width = 679
    Height = 185
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object Pg_Resumo: TPageControl
      Left = 2
      Top = 2
      Width = 675
      Height = 181
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Dados da Nota'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 667
          Height = 153
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
          object Label33: TLabel
            Left = 536
            Top = 39
            Width = 111
            Height = 14
            Caption = 'Valor Total dos Servi'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 536
            Top = 110
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
          object Label10: TLabel
            Left = 595
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
          object E_Vl_Bs_Icms_St: TEdit_Setes
            Left = 269
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
            TabOrder = 2
            Text = ''
          end
          object E_Vl_Icms_St: TEdit_Setes
            Left = 401
            Top = 17
            Width = 130
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
            Width = 129
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
            Width = 129
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
            Width = 127
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
            Width = 129
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
            Width = 130
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
            Width = 130
            Height = 21
            Alignment = taRightJustify
            TabOrder = 8
            Text = '0,00'
          end
          object E_VL_Frete: TEdit_Setes
            Left = 6
            Top = 52
            Width = 130
            Height = 21
            Alignment = taRightJustify
            TabOrder = 5
            Text = '0,00'
          end
          object E_VL_Servico: TPanel
            Left = 535
            Top = 52
            Width = 125
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
          object E_VL_Nota: TPanel
            Left = 535
            Top = 123
            Width = 127
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
            TabOrder = 19
          end
          object E_Qt_Produto: TEdit_Setes
            Left = 6
            Top = 88
            Width = 130
            Height = 21
            Alignment = taRightJustify
            TabOrder = 10
            Text = '0,00'
            OnChange = E_Qt_ProdutoChange
          end
          object E_Especie: TEdit
            Left = 138
            Top = 88
            Width = 104
            Height = 21
            Enabled = False
            MaxLength = 10
            TabOrder = 11
          end
          object E_PesoLiq: TEdit_Setes
            Left = 352
            Top = 88
            Width = 108
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 13
            Text = ''
          end
          object E_PesoBruto: TEdit_Setes
            Left = 244
            Top = 88
            Width = 105
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 12
            Text = ''
          end
          object E_PlacaVeiculo: TMaskEdit
            Left = 463
            Top = 88
            Width = 72
            Height = 21
            TabOrder = 14
            Text = ''
          end
          object E_RNTC: TEdit
            Left = 592
            Top = 88
            Width = 70
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
          object E_vol_Numero: TEdit
            Left = 138
            Top = 123
            Width = 129
            Height = 21
            Enabled = False
            MaxLength = 8
            TabOrder = 18
          end
          object lb_Vl_desconto: TPanel
            Left = 269
            Top = 124
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
            TabOrder = 20
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
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Recebimento'
        ImageIndex = 1
        object GroupBox8: TGroupBox
          Left = 1
          Top = -7
          Width = 672
          Height = 149
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label19: TLabel
            Left = 455
            Top = 11
            Width = 84
            Height = 14
            Caption = 'Valor em Dinheiro'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 566
            Top = 11
            Width = 81
            Height = 14
            Caption = 'Valor em cheque'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 455
            Top = 123
            Width = 98
            Height = 20
            Caption = 'Valor Troco:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_VL_Troco: TLabel
            Left = 555
            Top = 124
            Width = 109
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label23: TLabel
            Left = 455
            Top = 53
            Width = 77
            Height = 14
            Caption = 'Valor em Cart'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 566
            Top = 53
            Width = 37
            Height = 14
            Caption = 'Cr'#233'dito '
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 454
            Top = 96
            Width = 85
            Height = 20
            Caption = 'Devolu'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_Devolucao: TLabel
            Left = 554
            Top = 96
            Width = 109
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object E_VL_Dinheiro: TEdit_Setes
            Left = 455
            Top = 25
            Width = 100
            Height = 24
            Alignment = taRightJustify
            TabOrder = 0
            Text = '0,00'
            OnChange = E_VL_DinheiroChange
            OnEnter = E_VL_DinheiroEnter
            OnExit = E_VL_DinheiroExit
          end
          object E_VL_Cheque: TEdit_Setes
            Left = 565
            Top = 25
            Width = 100
            Height = 24
            Alignment = taRightJustify
            TabOrder = 1
            Text = '0,00'
            OnChange = E_VL_ChequeChange
            OnEnter = E_VL_ChequeEnter
            OnExit = E_VL_ChequeExit
          end
          object E_Vl_Cartao: TEdit_Setes
            Left = 455
            Top = 67
            Width = 100
            Height = 24
            Alignment = taRightJustify
            TabOrder = 2
            Text = '0,00'
            OnChange = E_Vl_CartaoChange
            OnEnter = E_Vl_CartaoEnter
            OnExit = E_Vl_CartaoExit
          end
          object E_Vl_Credito: TEdit_Setes
            Left = 564
            Top = 67
            Width = 100
            Height = 24
            Alignment = taRightJustify
            TabOrder = 3
            Text = '0,00'
            OnChange = E_Vl_CreditoChange
            OnEnter = E_Vl_CreditoEnter
            OnExit = E_Vl_CreditoExit
          end
          inline Fm_CentroCusto: TFm_CentroCusto
            Left = 4
            Top = 11
            Width = 450
            Height = 71
            TabOrder = 4
            ExplicitLeft = 4
            ExplicitTop = 11
            ExplicitHeight = 71
            inherited Grb_Cta_CentroCusto: TGroupBox
              Height = 71
              ExplicitHeight = 71
            end
          end
        end
      end
    end
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT MAX(NFL_NUMERO) FROM TB_NOTA_FISCAL WHERE (NFL_TIPO = '#39'SI' +
        #39') OR (NFL_TIPO = '#39'EI'#39')')
    Left = 424
    Top = 8
  end
  object PrintDialog1: TPrintDialog
    Left = 520
    Top = 136
  end
  object QR_Duplicata: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '    FIN_CODPED,'
      '    FIN_DT_VENCIMENTO, '
      '    FIN_VL_PARCELA,'
      '    FPT_DESCRICAO,'
      '    PED_PRAZO'
      'FROM TB_FINANCEIRO'
      '   INNER JOIN TB_PEDIDO tb_pedido'
      '   ON  (tb_pedido.PED_CODIGO= Tb_financeiro.FIN_CODPED)  '
      '   INNER JOIN TB_FORMAPAGTO Tb_formapagto'
      '   ON  (Tb_formapagto.FPT_CODIGO = Tb_pedido.PED_CODFPG)  '
      'WHERE'
      '   FIN_CODPED =:FIN_CODPED'
      'ORDER BY FIN_NUMERO')
    Left = 528
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_CODPED'
        ParamType = ptUnknown
      end>
  end
  object Qr_Orcamento: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CTC_NUMERO, CTC_DATA'
      'FROM TB_COTACAO'
      'WHERE CTC_CODPED=:CTC_CODPED')
    Left = 457
    Top = 11
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODPED'
        ParamType = ptUnknown
      end>
  end
  object Qr_Conserto_: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CST_CODPED'
      'FROM TB_CONSERTO tb_conserto'
      'WHERE '
      '  (CST_CODPED=:PED_CODIGO)')
    Left = 564
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Qr_Pedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  PED_CODIGO,'
      '  PED_CODEMP,'
      '  PED_CODVDO,'
      '  EMP_CONSUMIDOR,'
      '  EMP_IGNORAR_ST,'
      '  EMP_NOME,'
      '  EMP_MICRO,'
      '  UFE_CODIGO,'
      '  UFE_SIGLA,'
      '  EMP_FABRICA,'
      '  EMP_SUB_TRIB,'
      '  EMP_INSC_EST,'
      '  EMP_CNPJ,'
      '  CDD_DESCRICAO,'
      '  END_NUMERO,'
      '  END_PAIS,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_ENDER,'
      ' ped_codend,'
      ' PED_VL_PEDIDO,'
      'PED_PRAZO,'
      'PED_DATA,'
      
        'PED_VL_SERVICO, PED_VL_PRODUTO, PED_VL_ODESPESA, PED_VL_IPI, PED' +
        '_VL_FRETE, PED_VL_DESCONTO, PED_NUMERO,PED_CODFPG, FPT_DESCRICAO'
      ''
      'FROM TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '   INNER JOIN TB_PAIS tb_pais'
      '   ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      '   INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON(tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG)'
      ''
      'WHERE (PED_CODIGO=:PED_CODIGO) ')
    Left = 200
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Endereco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  END_CODIGO,'
      '  END_CODEMP,'
      '  END_CNPJ,'
      '  END_TIPO,'
      '  END_ENDER,'
      '  END_NUMERO,'
      '  END_COMPLEM,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_CODCDD,'
      '  CDD_DESCRICAO,'
      '  END_REGIAO,'
      '  END_CODUFE,'
      '  UFE_SIGLA,'
      '  END_CONTATO,'
      '  END_FONE,'
      '  END_FAX,'
      '  END_CELULAR,'
      '  END_PAIS'
      'FROM TB_ENDERECO'
      '         INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODIGO=:END_CODIGO)')
    Left = 394
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'END_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Moral_Frete: TDataSource
    DataSet = DM.Qr_Modal_Frete
    Left = 366
    Top = 77
  end
  object Qr_Parcelamento: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_PARCELAMENTO'
      'WHERE PAR_CODPED=:PAR_CODPED'
      'ORDER BY PAR_PARCELA')
    Left = 620
    Top = 10
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PAR_CODPED'
        ParamType = ptUnknown
      end>
  end
  object IBT_Faturamento: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 174
    Top = 11
  end
end
