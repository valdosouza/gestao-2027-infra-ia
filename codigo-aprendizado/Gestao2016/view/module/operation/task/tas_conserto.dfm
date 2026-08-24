inherited TasConserto: TTasConserto
  Caption = 'TasConserto'
  ClientHeight = 517
  ClientWidth = 761
  ExplicitWidth = 767
  ExplicitHeight = 566
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 453
    Width = 761
    ExplicitTop = 453
    ExplicitWidth = 761
    inherited SB_Inserir: TSpeedButton
      Left = 3
      Width = 30
      Align = alLeft
      Visible = False
      ExplicitLeft = 4
      ExplicitWidth = 30
    end
    inherited SB_Alterar: TSpeedButton
      Left = 66
      ExplicitLeft = 66
    end
    inherited SB_Excluir: TSpeedButton
      Left = 170
      ExplicitLeft = 224
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 378
      ExplicitLeft = 378
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 654
      ExplicitLeft = 654
    end
    inherited SB_Gravar: TSpeedButton
      Left = 274
      ExplicitLeft = 274
    end
    object Sb_Encerrar: TSpeedButton
      AlignWithMargins = True
      Left = 481
      Top = 3
      Width = 86
      Height = 58
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Encerrar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 12
      OnClick = Sb_EncerrarClick
      ExplicitTop = 4
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 567
      Top = 3
      Width = 86
      Height = 58
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Imprimir - F11'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitTop = 2
    end
  end
  inherited pnl_fundo: TPanel
    Width = 761
    Height = 453
    ExplicitWidth = 761
    ExplicitHeight = 453
    object Pnl_Cabecalho: TPanel
      Left = 2
      Top = 2
      Width = 757
      Height = 122
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 9
        Top = 6
        Width = 44
        Height = 14
        Caption = 'N'#250'mero'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 128
        Top = 6
        Width = 22
        Height = 14
        Caption = 'Data'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 232
        Top = 45
        Width = 112
        Height = 14
        Caption = 'Telefones para Contato'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Numero: TLabel
        Left = 6
        Top = 22
        Width = 107
        Height = 19
        Caption = 'ORC - 0000/07'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 232
        Top = 82
        Width = 137
        Height = 14
        Caption = 'N'#250'mero de Parcelas/ Prazos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Parcelamento: TSpeedButton
        Left = 473
        Top = 93
        Width = 22
        Height = 22
        Caption = '...'
        OnClick = Sb_ParcelamentoClick
      end
      object Label10: TLabel
        Left = 504
        Top = 45
        Width = 68
        Height = 14
        Caption = 'Email de envio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Contato: TEdit
        Left = 229
        Top = 60
        Width = 269
        Height = 21
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object E_Data: TDateTimePicker
        Left = 124
        Top = 20
        Width = 91
        Height = 22
        Date = 39583.726933773150000000
        Time = 39583.726933773150000000
        TabOrder = 0
      end
      object E_Nr_Parcelas: TMaskEdit
        Left = 232
        Top = 95
        Width = 37
        Height = 21
        EditMask = '000;1;_'
        MaxLength = 3
        TabOrder = 5
        Text = '000'
        OnExit = E_Nr_ParcelasExit
      end
      object E_Prazo: TMaskEdit
        Left = 271
        Top = 95
        Width = 199
        Height = 21
        MaxLength = 200
        TabOrder = 6
        Text = #192' VISTA'
      end
      object E_email: TEdit
        Left = 502
        Top = 60
        Width = 244
        Height = 21
        CharCase = ecLowerCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object DBLCB_Prazo: TDBLookupComboBox
        Left = 233
        Top = 113
        Width = 266
        Height = 21
        KeyField = 'PRZ_PRAZO'
        ListField = 'PRZ_PRAZO'
        TabOrder = 7
      end
      inline Fm_FormaPagto: TFm_FormaPagto
        Left = 2
        Top = 78
        Width = 228
        Height = 42
        TabOrder = 4
        TabStop = True
        ExplicitLeft = 2
        ExplicitTop = 78
        ExplicitWidth = 228
        ExplicitHeight = 42
        inherited Lb_FormaPagamento: TLabel
          Width = 222
        end
        inherited pnl_Forma: TPanel
          Width = 228
          Height = 28
          ExplicitWidth = 228
          ExplicitHeight = 28
          inherited SB_FormaPag: TSpeedButton
            Left = 202
            Height = 25
            ExplicitLeft = 202
            ExplicitHeight = 28
          end
          inherited DBLCB_FormaPagto: TDBLookupComboBox
            Width = 193
            OnClick = Fm_FormaPagtoDBLCB_FormaPagtoClick
            ExplicitWidth = 193
          end
        end
      end
      inline Fm_VendedorPedido: TFm_ListaColaboradores
        Left = 5
        Top = 45
        Width = 225
        Height = 36
        TabOrder = 1
        ExplicitLeft = 5
        ExplicitTop = 45
        ExplicitWidth = 225
        ExplicitHeight = 36
        inherited Label19: TLabel
          Width = 225
        end
        inherited Sb_Cadastro: TSpeedButton
          Left = 199
          Height = 19
          ExplicitLeft = 199
          ExplicitHeight = 19
        end
        inherited Dblcb_Vendedor: TDBLookupComboBox
          Width = 196
          ExplicitWidth = 196
        end
        inherited Qr_ListaVendedor: TSTQuery
          Transaction = DM.IB_Transacao
        end
      end
      inline Fm_ListaClientes: TFm_ListaClientes
        Left = 218
        Top = 4
        Width = 535
        Height = 39
        TabOrder = 8
        ExplicitLeft = 218
        ExplicitTop = 4
        ExplicitWidth = 535
        inherited pnl_01: TPanel
          Width = 535
          ExplicitWidth = 535
        end
        inherited pnl_02: TPanel
          Width = 535
          ExplicitWidth = 535
          inherited Sb_Pesq_Empresa: TSpeedButton
            Left = 507
            ExplicitLeft = 507
          end
          inherited SB_Empresas: TSpeedButton
            Left = 482
            ExplicitLeft = 482
          end
          inherited DBLCB_Empresa: TDBLookupComboBox
            Width = 414
            OnExit = Fm_ListaClientesDBLCB_EmpresaExit
            ExplicitWidth = 414
          end
        end
      end
    end
    object Pnl_Conserto: TPanel
      Left = 2
      Top = 124
      Width = 757
      Height = 278
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      DesignSize = (
        757
        278)
      object Label32: TLabel
        Left = 7
        Top = 105
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
      object Label33: TLabel
        Left = 4
        Top = 184
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
      object Label34: TLabel
        Left = 482
        Top = 42
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
      object Label38: TLabel
        Left = 573
        Top = 42
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
      object Label45: TLabel
        Left = 664
        Top = 42
        Width = 69
        Height = 14
        BiDiMode = bdLeftToRight
        Caption = 'Data Conserto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label47: TLabel
        Left = 390
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
      object Label3: TLabel
        Left = 608
        Top = 3
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
      object Label15: TLabel
        Left = 8
        Top = 3
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
      object Label30: TLabel
        Left = 207
        Top = 3
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
      object Label31: TLabel
        Left = 405
        Top = 3
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
      object Label5: TLabel
        Left = 6
        Top = 42
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
      object Lb_Final_Data: TLabel
        Left = 358
        Top = 241
        Width = 177
        Height = 16
        Anchors = [akTop]
        Caption = 'ENTREGUE REPARADO.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 390
      end
      object MM_Relatado: TMemo
        Left = 5
        Top = 119
        Width = 378
        Height = 62
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
      object MM_Constatado: TMemo
        Left = 5
        Top = 200
        Width = 378
        Height = 67
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
      end
      object E_VL_MObra: TEdit_Setes
        Left = 572
        Top = 57
        Width = 89
        Height = 21
        Alignment = taRightJustify
        TabOrder = 9
        Text = ''
        OnEnter = E_VL_MObraEnter
        OnExit = E_VL_MObraExit
      end
      object E_VL_Peca: TEdit_Setes
        Left = 481
        Top = 57
        Width = 89
        Height = 21
        Alignment = taRightJustify
        Color = clWhite
        TabOrder = 8
        Text = ''
        OnEnter = E_VL_PecaEnter
        OnExit = E_VL_PecaExit
      end
      object E_VL_Custo: TEdit_Setes
        Left = 389
        Top = 57
        Width = 92
        Height = 21
        Alignment = taRightJustify
        BiDiMode = bdRightToLeftNoAlign
        Color = clWhite
        ParentBiDiMode = False
        TabOrder = 7
        Text = ''
        OnEnter = E_VL_CustoEnter
        OnExit = E_VL_CustoExit
      end
      object E_NumSerie: TEdit
        Left = 606
        Top = 18
        Width = 142
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 3
      end
      object E_Aparelho: TEdit
        Left = 5
        Top = 18
        Width = 197
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object E_Marca: TEdit
        Left = 203
        Top = 18
        Width = 194
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object E_Modelo: TEdit
        Left = 398
        Top = 18
        Width = 206
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object MM_Acessorios: TMemo
        Left = 5
        Top = 57
        Width = 378
        Height = 51
        TabOrder = 4
      end
      object GroupBox1: TGroupBox
        Left = 388
        Top = 79
        Width = 360
        Height = 121
        Caption = 'Opera'#231#227'o com T'#233'cnico Externo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        DesignSize = (
          360
          121)
        object Sb_EnviaEmail: TSpeedButton
          Left = 145
          Top = 62
          Width = 105
          Height = 53
          Anchors = [akRight, akBottom]
          Caption = 'Enviar E-mail'
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
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
            0000377777777777777707FFFFFFFFFFFF70773FF33333333F770F77FFFFFFFF
            77F07F773FFFFFFF77F70FFF7700000000007F337777777777770FFFFF0FFFFF
            FFF07F333F7F3FFFF3370FFF700F0000FFF07F3F777F777733370F707F0FFFFF
            FFF07F77337F3FFFFFF7007EEE0F000000F077FFFF7F777777370777770FFFFF
            FFF07777777F3FFFFFF7307EEE0F000000F03773FF7F7777773733707F0FFFFF
            FFF03337737F3FFF33373333700F000FFFF03333377F77733FF73333330FFFFF
            00003333337F3FF377773333330F00FF0F033333337F77337F733333330FFFFF
            00333333337FFFFF773333333300000003333333337777777333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          OnClick = Sb_EnviaEmailClick
        end
        object Sb_Ctas_Pagar: TSpeedButton
          Left = 252
          Top = 62
          Width = 105
          Height = 53
          Anchors = [akRight, akBottom]
          Caption = 'Contas '#224' Pagar - F4'
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
            3333333333FFFFF3333333333700000733333333F777773FF3333333007F0F70
            0333333773373377FF3333300FFF7FFF003333773F3333377FF33300F0FFFFF0
            F00337737333F37377F33707FFFF0FFFF70737F33337F33337FF300FFFFF0FFF
            FF00773F3337F333377F30707FFF0FFF70707F733337F333737F300FFFF09FFF
            FF0077F33377F33337733707FF0F9FFFF70737FF3737F33F37F33300F0FF9FF0
            F003377F7337F373773333300FFF9FFF00333377FF37F3377FF33300007F9F70
            000337777FF7FF77773333703070007030733373777777737333333333330333
            333333333337FF33333333333330003333333333337773333333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          Transparent = False
          OnClick = Sb_Ctas_PagarClick
        end
        object Label17: TLabel
          Left = 5
          Top = 84
          Width = 120
          Height = 14
          Anchors = [akRight, akBottom]
          AutoSize = False
          Caption = #218'ltimo Envio de Email'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lbl_ult_atualizacao: TLabel
          Left = 5
          Top = 99
          Width = 120
          Height = 15
          Anchors = [akRight, akBottom]
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label44: TLabel
          Left = 10
          Top = 17
          Width = 83
          Height = 14
          Anchors = [akTop]
          Caption = 'Nome do T'#233'cnico'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBLCB_Fornecedor: TDBLookupComboBox
          Left = 3
          Top = 35
          Width = 339
          Height = 21
          KeyField = 'EMP_CODIGO'
          ListField = 'EMP_NOME'
          ListSource = Ds_Fornecedor
          TabOrder = 0
          OnKeyDown = DBLCB_FornecedorKeyDown
        end
      end
      inline Fm_ListaSituacao: TFm_ListaSituacao
        Left = 389
        Top = 200
        Width = 357
        Height = 38
        TabOrder = 12
        ExplicitLeft = 389
        ExplicitTop = 200
        ExplicitHeight = 38
        inherited Sb_Cadastro: TSpeedButton
          Height = 21
          ExplicitHeight = 21
        end
        inherited DBLCB_Situacao: TDBLookupComboBox
          OnClick = Fm_ListaSituacaoDBLCB_SituacaoClick
          OnExit = Fm_ListaSituacaoDBLCB_SituacaoExit
        end
      end
      object E_Dt_Conserto: TMaskEdit
        Left = 663
        Top = 57
        Width = 83
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 10
        Text = '  /  /    '
      end
    end
    object Pnl_Totalizador: TPanel
      Left = 2
      Top = 402
      Width = 757
      Height = 49
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      DesignSize = (
        757
        49)
      object Label12: TLabel
        Left = 334
        Top = 4
        Width = 25
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Frete'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 514
        Top = 4
        Width = 46
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Desconto'
        FocusControl = E_VL_Desconto
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 621
        Top = 4
        Width = 50
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 434
        Top = 6
        Width = 46
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Aliq Desc'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_VL_Desconto: TEdit_Setes
        Left = 508
        Top = 21
        Width = 107
        Height = 24
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0,00'
        OnExit = E_VL_DescontoExit
      end
      object E_Aliq_Desconto: TEdit_Setes
        Left = 432
        Top = 21
        Width = 76
        Height = 24
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0,00'
        OnExit = E_Aliq_DescontoExit
      end
      object E_VL_Frete: TEdit_Setes
        Left = 330
        Top = 21
        Width = 101
        Height = 24
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '0,00'
        OnExit = E_VL_FreteExit
      end
      object E_VL_Cotacao: TPanel
        Left = 620
        Top = 21
        Width = 128
        Height = 24
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
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
        TabOrder = 3
      end
    end
  end
  object Pnl_Encerra: TPanel [2]
    Left = 146
    Top = 2
    Width = 456
    Height = 158
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    Visible = False
    DesignSize = (
      456
      158)
    object Label11: TLabel
      Left = 10
      Top = 53
      Width = 72
      Height = 14
      Anchors = [akTop]
      Caption = 'Encerrar Como'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label46: TLabel
      Left = 371
      Top = 52
      Width = 62
      Height = 14
      Anchors = [akTop]
      BiDiMode = bdLeftToRight
      Caption = 'Data Entrega'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object Sb_confirma: TSpeedButton
      Left = 265
      Top = 97
      Width = 92
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Continuar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_confirmaClick
    end
    object Lb_Tipo: TLabel
      Left = 8
      Top = 24
      Width = 148
      Height = 20
      Caption = 'Numero do Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Lb_Valor: TLabel
      Left = 288
      Top = 24
      Width = 160
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor : 1000,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 2
      Top = 2
      Width = 452
      Height = 17
      Align = alTop
      AutoSize = False
      Caption = '  Encerramento do Conserto'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label18: TLabel
      Left = 433
      Top = 2
      Width = 20
      Height = 16
      Caption = '[X]'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      OnClick = Label18Click
    end
    object Sb_Voltar: TSpeedButton
      Left = 357
      Top = 97
      Width = 92
      Height = 54
      Anchors = [akBottom]
      Caption = 'Voltar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 13
      OnClick = Sb_VoltarClick
    end
    object DBLCB_Sit_encerra: TDBLookupComboBox
      Left = 5
      Top = 69
      Width = 360
      Height = 21
      KeyField = 'SIT_CODIGO'
      ListField = 'SIT_DESCRICAO'
      ListSource = Ds_Sit_Encerra
      TabOrder = 0
    end
    object E_DataEntrega: TDateTimePicker
      Left = 367
      Top = 68
      Width = 84
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
  end
  object qr_prazo_controlado: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo'
      'where'
      'prz_vl_minimo <= :prz_vl_minimo')
    Left = 116
    Top = 329
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prz_vl_minimo'
        ParamType = ptUnknown
      end>
  end
  object Qr_Ord_Max: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    MAX(CTC_NUMERO)'
      'FROM'
      '   TB_COTACAO'
      'WHERE (CTC_DATA>=:CTC_DATA) AND'
      '               (CTC_TIPO=:CTC_TIPO)')
    Left = 192
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_DATA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CTC_TIPO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 248
    Top = 328
  end
  object Qr_Ins_Ordem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'INSERT INTO TB_PEDIDO ('
      '  PED_CODIGO,'
      '  PED_CODMHA,'
      '  PED_NUMERO,'
      '  PED_TIPO,'
      '  PED_CODUSU,'
      '  PED_DATA,'
      '  PED_CODEMP,'
      '  PED_CODVDO,'
      '  PED_CODFPG,'
      '  PED_PRAZO,'
      '  PED_CODEND,'
      '  PED_QT_PRODUTO,'
      '  PED_VL_PRODUTO,'
      '  PED_VL_SERVICO,'
      '  PED_VL_IPI,'
      '  PED_VL_FRETE,'
      '  PED_ALIQ_DESCONTO,'
      '  PED_VL_DESCONTO,'
      '  PED_VL_PEDIDO,'
      '  PED_FATURADO,'
      '  PED_TP_CONTATO,'
      '  PED_OBS,'
      '  PED_DT_ENTREGA)'
      'VALUES ('
      '  :PED_CODIGO,'
      '  :PED_CODMHA,'
      '  :PED_NUMERO,'
      '  1,'
      '  :PED_CODUSU,'
      '  :PED_DATA,'
      '  :PED_CODEMP,'
      '  :PED_CODVDO,'
      '  :PED_CODFPG,'
      '  :PED_PRAZO,'
      '  :PED_CODEND,'
      '  :PED_QT_PRODUTO,'
      '  :PED_VL_PRODUTO,'
      '  :PED_VL_SERVICO,'
      '  :PED_VL_IPI,'
      '  :PED_VL_FRETE,'
      '  :PED_ALIQ_DESCONTO,'
      '  :PED_VL_DESCONTO,'
      '  :PED_VL_PEDIDO,'
      '   '#39'N'#39','
      '  :PED_TP_CONTATO,'
      '  :PED_OBS,'
      '  :PED_DT_ENTREGA)')
    Left = 328
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODMHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_NUMERO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODUSU'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_DATA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODEMP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODVDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODFPG'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_PRAZO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODEND'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_QT_PRODUTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_PRODUTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_SERVICO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_IPI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_FRETE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_ALIQ_DESCONTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_DESCONTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_VL_PEDIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_TP_CONTATO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_OBS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_DT_ENTREGA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Sit_Encerra: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Sit_EncerraAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_SITUACAO'
      'WHERE (SIT_FLAG02 IS NOT NULL)'
      'ORDER BY SIT_FLAG02')
    Left = 402
    Top = 323
  end
  object Ds_Sit_Encerra: TDataSource
    DataSet = Qr_Sit_Encerra
    Left = 400
    Top = 360
  end
  object dts_PrazoControlado: TDataSource
    DataSet = qr_prazo_controlado
    Left = 156
    Top = 393
  end
  object Ds_Fornecedor: TDataSource
    DataSet = Qr_Fornecedor
    Left = 618
    Top = 272
  end
  object Qr_Fornecedor: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_FornecedorAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  EMP_CODIGO,'
      '  EMP_NOME,'
      '  EMP_EMAIL'
      'FROM TB_EMPRESA'
      '   INNER JOIN TB_FORNECEDOR'
      '  ON (FOR_CODEMP = EMP_CODIGO)'
      'ORDER BY EMP_FANTASIA')
    Left = 618
    Top = 220
  end
  object Qr_Ordem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT ORD_CODIGO'
      'FROM TB_ORDEMSERVICO tb_ordemservico'
      '   INNER JOIN TB_VEICULO tb_veiculo'
      '   ON (tb_veiculo.VEI_CODIGO = tb_ordemservico.ORD_CODVEI)'
      '   INNER JOIN TB_MARCA tb_marca'
      '   ON (tb_marca.MRC_CODIGO = tb_veiculo.VEI_CODMRC)'
      '   INNER JOIN TB_MODELO tb_modelo'
      '   ON (tb_modelo.MOD_CODIGO = tb_veiculo.VEI_CODMOD)'
      '   INNER JOIN TB_TP_VEICULO tb_tp_veiculo'
      '   ON (tb_tp_veiculo.TPV_CODIGO = tb_veiculo.VEI_CODTPV)'
      'WHERE'
      '  ORD_CODPED =:CTC_CODPED')
    Left = 440
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODPED'
        ParamType = ptUnknown
      end>
  end
  object ActionList1: TActionList
    Left = 664
    Top = 64
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 16496
      OnExecute = Action1Execute
    end
  end
end
