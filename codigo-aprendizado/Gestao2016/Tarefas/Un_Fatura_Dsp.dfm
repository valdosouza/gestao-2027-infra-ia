object Fr_Fatura_Dsp: TFr_Fatura_Dsp
  Left = 305
  Top = 170
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Par'#226'metros de Gera'#231#227'o de Notas Fiscais - Faturamento'
  ClientHeight = 534
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
    Height = 281
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
      TabOrder = 0
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
      TabOrder = 1
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
        ListSource = Ds_Transportadora
        TabOrder = 0
        OnKeyDown = DBLCB_TransportadoraKeyDown
      end
      object Dblcb_Modal_Frete: TDBLookupComboBox
        Left = 6
        Top = 68
        Width = 435
        Height = 21
        KeyField = 'MDF_CODIGO'
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
      TabOrder = 2
    end
    object ChBx_AutorizacaoNFE: TCheckBox
      Left = 458
      Top = 74
      Width = 145
      Height = 17
      Caption = 'Solicitar autoriza'#231#227'o NF-e'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object Chbx_SomaIPI_Bs_ICMS: TCheckBox
      Left = 458
      Top = 119
      Width = 185
      Height = 17
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
      Left = 458
      Top = 134
      Width = 189
      Height = 17
      Caption = 'Somar o IPI na Base de ICMS Subst. Trib.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object CkBx_Nota_Manual: TCheckBox
      Left = 458
      Top = 104
      Width = 216
      Height = 17
      Caption = 'Informar o N'#250'mero da Nota Manualmente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object ChBx_NF_Informatizada: TCheckBox
      Left = 458
      Top = 89
      Width = 185
      Height = 17
      Caption = 'Imprimir nota Fiscal Informatizada'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 467
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
    Top = 281
    Width = 679
    Height = 186
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object Pg_Resumo: TPageControl
      Left = 2
      Top = 2
      Width = 675
      Height = 182
      ActivePage = tbs_etiqueta
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
          Height = 154
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
            Left = 537
            Top = 39
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
            TabOrder = 18
          end
          object E_Qt_Produto: TEdit_Setes
            Left = 6
            Top = 88
            Width = 130
            Height = 21
            Alignment = taRightJustify
            TabOrder = 9
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
            TabOrder = 10
          end
          object E_PesoLiq: TEdit_Setes
            Left = 352
            Top = 88
            Width = 108
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 12
            Text = ''
          end
          object E_PesoBruto: TEdit_Setes
            Left = 244
            Top = 88
            Width = 105
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 11
            Text = ''
          end
          object E_PlacaVeiculo: TMaskEdit
            Left = 463
            Top = 88
            Width = 72
            Height = 21
            EditMask = '>LLL-0000;1;_'
            MaxLength = 8
            TabOrder = 13
            Text = '   -    '
          end
          object E_RNTC: TEdit
            Left = 592
            Top = 88
            Width = 70
            Height = 21
            TabOrder = 15
          end
          object E_Marca: TEdit
            Left = 6
            Top = 123
            Width = 130
            Height = 21
            Enabled = False
            MaxLength = 10
            TabOrder = 16
          end
          object E_vol_Numero: TEdit
            Left = 138
            Top = 123
            Width = 129
            Height = 21
            Enabled = False
            MaxLength = 8
            TabOrder = 17
          end
          object lb_Vl_desconto: TPanel
            Left = 535
            Top = 52
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
          object E_Uf_Veiculo: TDBLookupComboBox
            Left = 539
            Top = 88
            Width = 51
            Height = 21
            KeyField = 'UFE_CODIGO'
            ListField = 'UFE_SIGLA'
            ListSource = DM.Ds_UF
            TabOrder = 14
          end
        end
      end
      object tbs_etiqueta: TTabSheet
        Caption = 'Etiqueta de Endere'#231'amento'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 667
          Height = 154
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object GroupBox14: TGroupBox
            Left = 6
            Top = 3
            Width = 300
            Height = 46
            Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object E_PortaImpressao_dsp: TEdit
              Left = 7
              Top = 19
              Width = 227
              Height = 21
              TabOrder = 0
            end
            object E_SaltoImpressao_dsp: TEdit_Setes
              Left = 237
              Top = 19
              Width = 52
              Height = 21
              Alignment = taRightJustify
              TabOrder = 1
              Text = ''
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
  object Ds_Transportadora: TDataSource
    Left = 290
    Top = 73
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
      '  ped_codend,'
      '  PED_VL_PEDIDO,'
      '  PED_PRAZO, '
      '  PED_DATA, '
      '  PED_VL_PRODUTO, '
      '  PED_VL_ODESPESA, '
      '  PED_VL_IPI, '
      '  PED_VL_FRETE, '
      '  PED_VL_DESCONTO, '
      '  PED_NUMERO,'
      '  PED_CODFPG'
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
      'WHERE (PED_CODIGO=:PED_CODIGO) ')
    Left = 200
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_PedidoPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = 'TB_PEDIDO.PED_CODEMP'
      Required = True
    end
    object Qr_PedidoPED_CODVDO: TIntegerField
      FieldName = 'PED_CODVDO'
      Origin = 'TB_PEDIDO.PED_CODVDO'
      Required = True
    end
    object Qr_PedidoEMP_CONSUMIDOR: TStringField
      FieldName = 'EMP_CONSUMIDOR'
      Origin = 'TB_EMPRESA.EMP_CONSUMIDOR'
      Size = 1
    end
    object Qr_PedidoEMP_MICRO: TStringField
      FieldName = 'EMP_MICRO'
      Origin = 'TB_EMPRESA.EMP_MICRO'
      Size = 1
    end
    object Qr_PedidoUFE_CODIGO: TIntegerField
      FieldName = 'UFE_CODIGO'
      Origin = 'TB_UF.UFE_CODIGO'
      Required = True
    end
    object Qr_PedidoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_PedidoEMP_FABRICA: TStringField
      FieldName = 'EMP_FABRICA'
      Origin = 'TB_EMPRESA.EMP_FABRICA'
      FixedChar = True
      Size = 1
    end
    object Qr_PedidoEMP_SUB_TRIB: TStringField
      FieldName = 'EMP_SUB_TRIB'
      Origin = 'TB_EMPRESA.EMP_SUB_TRIB'
      FixedChar = True
      Size = 1
    end
    object Qr_PedidoPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = 'TB_PEDIDO.PED_CODIGO'
      Required = True
    end
    object Qr_PedidoEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = 'TB_EMPRESA.EMP_CNPJ'
      Required = True
      Size = 14
    end
    object Qr_PedidoCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_PedidoEND_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'TB_ENDERECO.END_NUMERO'
      Size = 10
    end
    object Qr_PedidoEND_PAIS: TIntegerField
      FieldName = 'END_PAIS'
      Origin = 'TB_ENDERECO.END_PAIS'
    end
    object Qr_PedidoEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 100
    end
    object Qr_PedidoEMP_INSC_EST: TStringField
      FieldName = 'EMP_INSC_EST'
      Origin = 'TB_EMPRESA.EMP_INSC_EST'
      Size = 30
    end
    object Qr_PedidoEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_PedidoEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_PedidoPED_CODEND: TIntegerField
      FieldName = 'PED_CODEND'
      Origin = 'TB_PEDIDO.PED_CODEND'
    end
    object Qr_PedidoPED_VL_PEDIDO: TBCDField
      FieldName = 'PED_VL_PEDIDO'
      Origin = 'TB_PEDIDO.PED_VL_PEDIDO'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_PRAZO: TStringField
      FieldName = 'PED_PRAZO'
      Origin = 'TB_PEDIDO.PED_PRAZO'
      Size = 200
    end
    object Qr_PedidoPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = 'TB_PEDIDO.PED_DATA'
      Required = True
    end
    object Qr_PedidoPED_VL_PRODUTO: TBCDField
      FieldName = 'PED_VL_PRODUTO'
      Origin = 'TB_PEDIDO.PED_VL_PRODUTO'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_ODESPESA: TBCDField
      FieldName = 'PED_VL_ODESPESA'
      Origin = 'TB_PEDIDO.PED_VL_ODESPESA'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_IPI: TBCDField
      FieldName = 'PED_VL_IPI'
      Origin = 'TB_PEDIDO.PED_VL_IPI'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_FRETE: TBCDField
      FieldName = 'PED_VL_FRETE'
      Origin = 'TB_PEDIDO.PED_VL_FRETE'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_VL_DESCONTO: TBCDField
      FieldName = 'PED_VL_DESCONTO'
      Origin = 'TB_PEDIDO.PED_VL_DESCONTO'
      Precision = 18
      Size = 2
    end
    object Qr_PedidoPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_PedidoPED_CODFPG: TIntegerField
      FieldName = 'PED_CODFPG'
      Origin = 'TB_PEDIDO.PED_CODFPG'
      Required = True
    end
    object Qr_PedidoEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT FIRST 16 SKIP 0'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  EMB_ABREVIATURA,'
      '  PRO_CODIGONCM,'
      '  PRO_ORIGEM,'
      '  ITF_QTDE, '
      '  ITF_VL_UNIT,'
      '  (ITF_QTDE * ITF_VL_UNIT) AS  ITF_SUBTOTAL,'
      '  ITF_AQ_IPI,'
      '  ITF_ESTOQUE,'
      '  ITF_AQ_ICMS'
      'FROM TB_ITENS_NFL tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      
        '   inner JOIN tb_medida tb_medida ON tb_medida.med_codigo = tb_p' +
        'roduto.pro_codmed'
      
        '   LEFT JOIN tb_embalagem tb_embalagem ON tb_embalagem.emb_codig' +
        'o = tb_produto.pro_codemb'
      'WHERE (ITF_CODNFL = :NFL_CODIGO)'
      'ORDER BY PRO_DESCRICAO'
      ''
      '')
    Left = 240
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
        Size = 4
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
    object Qr_EnderecoEND_CODIGO: TIntegerField
      FieldName = 'END_CODIGO'
      Origin = 'TB_ENDERECO.END_CODIGO'
      Required = True
    end
    object Qr_EnderecoEND_CODEMP: TIntegerField
      FieldName = 'END_CODEMP'
      Origin = 'TB_ENDERECO.END_CODEMP'
    end
    object Qr_EnderecoEND_CNPJ: TStringField
      FieldName = 'END_CNPJ'
      Origin = 'TB_ENDERECO.END_CNPJ'
      Size = 14
    end
    object Qr_EnderecoEND_TIPO: TStringField
      FieldName = 'END_TIPO'
      Origin = 'TB_ENDERECO.END_TIPO'
      Size = 100
    end
    object Qr_EnderecoEND_ENDER: TStringField
      FieldName = 'END_ENDER'
      Origin = 'TB_ENDERECO.END_ENDER'
      Size = 100
    end
    object Qr_EnderecoEND_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'TB_ENDERECO.END_NUMERO'
      Size = 10
    end
    object Qr_EnderecoEND_COMPLEM: TStringField
      FieldName = 'END_COMPLEM'
      Origin = 'TB_ENDERECO.END_COMPLEM'
      Size = 25
    end
    object Qr_EnderecoEND_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'TB_ENDERECO.END_BAIRRO'
      Size = 100
    end
    object Qr_EnderecoEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_EnderecoEND_CODCDD: TIntegerField
      FieldName = 'END_CODCDD'
      Origin = 'TB_ENDERECO.END_CODCDD'
    end
    object Qr_EnderecoCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_EnderecoEND_REGIAO: TStringField
      FieldName = 'END_REGIAO'
      Origin = 'TB_ENDERECO.END_REGIAO'
      Size = 25
    end
    object Qr_EnderecoEND_CODUFE: TIntegerField
      FieldName = 'END_CODUFE'
      Origin = 'TB_ENDERECO.END_CODUFE'
    end
    object Qr_EnderecoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_EnderecoEND_CONTATO: TStringField
      FieldName = 'END_CONTATO'
      Origin = 'TB_ENDERECO.END_CONTATO'
      Size = 100
    end
    object Qr_EnderecoEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = 'TB_ENDERECO.END_FONE'
      Size = 14
    end
    object Qr_EnderecoEND_FAX: TStringField
      FieldName = 'END_FAX'
      Origin = 'TB_ENDERECO.END_FAX'
      Size = 14
    end
    object Qr_EnderecoEND_CELULAR: TStringField
      FieldName = 'END_CELULAR'
      Origin = 'TB_ENDERECO.END_CELULAR'
      Size = 14
    end
    object Qr_EnderecoEND_PAIS: TIntegerField
      FieldName = 'END_PAIS'
      Origin = 'TB_ENDERECO.END_PAIS'
    end
  end
  object Qr_Nf_Eletronica: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '   NFE_CODIGO'
      '   ,NFE_CODEMP'
      '   ,NFE_AMBIENTE'
      '   ,NFE_EMISSAO'
      '   ,NFE_CERTIFICADO'
      '   ,NFE_REPOSITORIO'
      '   ,NFE_DFE_VISUALIZAR'
      '   ,NFE_DFE_ORIENTACAO'
      '   ,NFE_DFE_COB'
      '   ,NFE_DFE_FAT'
      '   ,NFE_DFE_DUP'
      '   ,NFE_DFE_TIPO'
      'from TB_NF_ELETRONICA'
      'WHERE NFE_CODEMP=:EMP_CODIGO')
    Left = 452
    Top = 10
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Tributacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select TRB_CODIGO'
      '      ,TRB_CODPRO'
      '      ,TRB_ORIGEM'
      '      ,TRB_CODTBI_ICMS_NR'
      '      ,TRB_CODTBI_ICMS_SN'
      '      ,TRB_CODMDB_ICMS_NR'
      '      ,TRB_CODMDB_ICMS_ST'
      '      ,TRB_CODDSI_ICMS'
      '      ,TRB_AQ_ICMS'
      '      ,TRB_RD_AQ_ICMS'
      '      ,TRB_RD_BS_ICMS'
      '      ,TRB_CODTBI_IPI'
      '      ,TRB_AQ_IPI'
      '      ,TRB_CODTBI_PIS'
      '      ,TRB_AQ_PIS'
      '      ,TRB_CODTBI_CFS'
      '      ,TRB_AQ_COFINS'
      '      ,TRB_AQ_IRPJ'
      '      ,TRB_AQ_CSLL'
      '      ,TRB_AQ_SISCOMEX'
      '      ,TRB_AQ_II'
      '      ,TRB_ST_ICMS'
      '      ,TRB_CONSUMIDOR'
      '      ,TRB_MICRO'
      '      ,TRB_DIFERIDO'
      '      ,TRB_DESTAQUE'
      '      ,TRB_CODOBS'
      '      ,TRB_CODNAT'
      '      ,TRB_ESTADO'
      '      ,TRB_CODMHA'
      '      ,TRB_SUB_TRI'
      '      ,NAT_CODIGO'
      'from "TB_TRIBUTACAO"'
      '     INNER JOIN TB_NATUREZA tb_natureza'
      '     ON (tb_natureza.NAT_CODIGO = TRB_CODNAT)'
      'WHERE ( ( TRB_CODPRO =:TRB_CODPRO ) OR ( TRB_CODPRO = 0 ) )   '
      '   AND      ( TRB_ORIGEM =:TRB_ORIGEM ) '
      '   AND      ( TRB_ST_ICMS = :TRB_ST_ICMS )'
      
        '   AND      ( ( TRB_ESTADO = :TRB_ESTADO ) OR ( TRB_ESTADO = 0 )' +
        ' OR ( TRB_ESTADO IS NULL) ) '
      '   AND      ( TRB_CONSUMIDOR =:TRB_CONSUMIDOR ) '
      '   AND      ( TRB_MICRO =:TRB_MICRO ) '
      '   AND      ( TRB_CODMHA=:TRB_CODMHA ) '
      '   AND      ( NAT_SENTIDO =:NAT_SENTIDO ) '
      '   AND      ( TRB_PRODUTO =:TRB_PRODUTO)'
      ' ')
    Left = 496
    Top = 9
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TRB_CODPRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_ORIGEM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_ST_ICMS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_ESTADO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_CONSUMIDOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_MICRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_CODMHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NAT_SENTIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_PRODUTO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Moral_Frete: TDataSource
    DataSet = DM.Qr_Modal_Frete
    Left = 366
    Top = 77
  end
  object IBT_Faturamento: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 174
    Top = 3
  end
  object Qr_Etiqueta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  CGE_CODIGO,'
      '  CGE_DESCRICAO,'
      '  CGE_PG_ALTURA,'
      '  CGE_PG_LARGURA,'
      '  CGE_SUPERIOR,'
      '  CGE_INFERIOR,'
      '  CGE_DIREITA,'
      '  CGE_ESQUERA,'
      '  CGE_ET_ALTURA,'
      '  CGE_ET_LARGURA,'
      '  CGE_DIS_COLUNA,'
      '  CGE_TYPEFONTE,'
      '  CGE_SIZEFONTE,'
      '  CGE_PAGESIZE,'
      '  CGE_NR_COLUNA'
      'FROM TB_CFG_ETIQUETA')
    Left = 536
    Top = 9
    object Qr_EtiquetaCGE_CODIGO: TIntegerField
      FieldName = 'CGE_CODIGO'
      Origin = 'TB_CFG_ETIQUETA.CGE_CODIGO'
    end
    object Qr_EtiquetaCGE_DESCRICAO: TStringField
      FieldName = 'CGE_DESCRICAO'
      Origin = 'TB_CFG_ETIQUETA.CGE_DESCRICAO'
      Size = 100
    end
    object Qr_EtiquetaCGE_PG_ALTURA: TBCDField
      FieldName = 'CGE_PG_ALTURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_PG_ALTURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_PG_LARGURA: TBCDField
      FieldName = 'CGE_PG_LARGURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_PG_LARGURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_SUPERIOR: TBCDField
      FieldName = 'CGE_SUPERIOR'
      Origin = 'TB_CFG_ETIQUETA.CGE_SUPERIOR'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_INFERIOR: TBCDField
      FieldName = 'CGE_INFERIOR'
      Origin = 'TB_CFG_ETIQUETA.CGE_INFERIOR'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_DIREITA: TBCDField
      FieldName = 'CGE_DIREITA'
      Origin = 'TB_CFG_ETIQUETA.CGE_DIREITA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_ESQUERA: TBCDField
      FieldName = 'CGE_ESQUERA'
      Origin = 'TB_CFG_ETIQUETA.CGE_ESQUERA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_ET_ALTURA: TBCDField
      FieldName = 'CGE_ET_ALTURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_ET_ALTURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_ET_LARGURA: TBCDField
      FieldName = 'CGE_ET_LARGURA'
      Origin = 'TB_CFG_ETIQUETA.CGE_ET_LARGURA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_DIS_COLUNA: TBCDField
      FieldName = 'CGE_DIS_COLUNA'
      Origin = 'TB_CFG_ETIQUETA.CGE_DIS_COLUNA'
      Precision = 18
      Size = 2
    end
    object Qr_EtiquetaCGE_TYPEFONTE: TStringField
      FieldName = 'CGE_TYPEFONTE'
      Origin = 'TB_CFG_ETIQUETA.CGE_TYPEFONTE'
      Size = 40
    end
    object Qr_EtiquetaCGE_SIZEFONTE: TIntegerField
      FieldName = 'CGE_SIZEFONTE'
      Origin = 'TB_CFG_ETIQUETA.CGE_SIZEFONTE'
    end
    object Qr_EtiquetaCGE_PAGESIZE: TStringField
      FieldName = 'CGE_PAGESIZE'
      Origin = 'TB_CFG_ETIQUETA.CGE_PAGESIZE'
      Size = 15
    end
    object Qr_EtiquetaCGE_NR_COLUNA: TBCDField
      FieldName = 'CGE_NR_COLUNA'
      Origin = 'TB_CFG_ETIQUETA.CGE_NR_COLUNA'
      Precision = 18
      Size = 2
    end
  end
  object Ds_Etiqueta: TDataSource
    DataSet = Qr_Etiqueta
    Left = 536
    Top = 41
  end
  object Qr_DestinatarioPedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    Constraints = <
      item
        FromDictionary = True
      end>
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      ' PED_DATA,'
      ' PED_CODEMP,'
      ' PED_CODVDO,'
      ' CDD_DESCRICAO ,'
      ' UFE_SIGLA,'
      ' END_CEP,'
      ' EMP_NOME,'
      ' NFL_NUMERO'
      ' FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '   INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      '   INNER  JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      'WHERE PED_CODIGO=:PED_CODIGO')
    Left = 496
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_DestinatarioPedidoPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = 'TB_PEDIDO.PED_DATA'
      Required = True
    end
    object Qr_DestinatarioPedidoPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = 'TB_PEDIDO.PED_CODEMP'
      Required = True
    end
    object Qr_DestinatarioPedidoPED_CODVDO: TIntegerField
      FieldName = 'PED_CODVDO'
      Origin = 'TB_PEDIDO.PED_CODVDO'
      Required = True
    end
    object Qr_DestinatarioPedidoCDD_DESCRICAO: TStringField
      FieldName = 'CDD_DESCRICAO'
      Origin = 'TB_CIDADE.CDD_DESCRICAO'
      Size = 60
    end
    object Qr_DestinatarioPedidoUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = 'TB_UF.UFE_SIGLA'
      FixedChar = True
      Size = 2
    end
    object Qr_DestinatarioPedidoEND_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'TB_ENDERECO.END_CEP'
      Size = 8
    end
    object Qr_DestinatarioPedidoEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_DestinatarioPedidoNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = 'TB_NOTA_FISCAL.NFL_NUMERO'
      Size = 10
    end
  end
end
