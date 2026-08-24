object Fr_Pedido_Cpa: TFr_Pedido_Cpa
  Left = 491
  Top = 26
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Pedido de Compra'
  ClientHeight = 624
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Controle
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Pedido_Cpa: TPageControl
    Left = 0
    Top = 0
    Width = 747
    Height = 624
    ActivePage = tbs_cadastro
    Align = alClient
    TabOrder = 0
    object tbs_cadastro: TTabSheet
      Caption = 'tbs_cadastro'
      OnShow = tbs_cadastroShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        739
        596)
      object Pnl_fundo: TPanel
        Left = 0
        Top = 0
        Width = 739
        Height = 531
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          739
          531)
        object Label2: TLabel
          Left = 86
          Top = 7
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
        object Label6: TLabel
          Left = 224
          Top = 46
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
        object lc_fornecedor: TLabel
          Left = 187
          Top = 7
          Width = 143
          Height = 14
          Caption = 'C'#243'digo / Nome do Fornecedor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object SB_fornecedor: TSpeedButton
          Left = 679
          Top = 19
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SB_fornecedorClick
        end
        object Sb_Fich_Fin: TSpeedButton
          Left = 636
          Top = 46
          Width = 89
          Height = 43
          Caption = 'Ficha Financeira'
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
            33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
            FFF07F3FF3FF3FFF3FF70F00F00F000F00F07F773773777377370FFFFFFFFFFF
            FFF07F3FF3FF33FFFFF70F00F00FF00000F07F773773377777F70FEEEEEFF0F9
            FCF07F33333337F7F7F70FFFFFFFF0F9FCF07F3FFFF337F737F70F0000FFF0FF
            FCF07F7777F337F337370F0000FFF0FFFFF07F777733373333370FFFFFFFFFFF
            FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
            C880733777777777733700000000000000007777777777777777333333333333
            3333333333333333333333333333333333333333333333333333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          Transparent = False
          OnClick = Sb_Fich_FinClick
        end
        object Sb_Parcelamento: TSpeedButton
          Left = 610
          Top = 60
          Width = 24
          Height = 22
          Caption = '...'
          OnClick = Sb_ParcelamentoClick
        end
        object Label27: TLabel
          Left = 590
          Top = 457
          Width = 100
          Height = 14
          Anchors = [akRight, akBottom]
          AutoSize = False
          Caption = 'Prazo de Entrega'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 545
          ExplicitTop = 431
        end
        object Sb_Pesq_Cliente: TSpeedButton
          Left = 705
          Top = 19
          Width = 23
          Height = 22
          Glyph.Data = {
            E6010000424DE60100000000000036000000280000000C0000000C0000000100
            180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF285A9F626F8DFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2963AC7EE3FA18
            79DEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF296CBA7FE3FA
            177FE4C9D5E9FFFFFFFFFFFFFFFFFFF7F6F7E6E5E6FFFFFFFFFFFF447DC57EE3
            FA177FE4C9D8ECFFFFFFFFFFFFEFEEEF66574AFBDCACFFEECDC0C8A6483C489C
            A1B62372CBC9DBF1FFFFFFFFFFFFFFFFFF8D734FF5BC91FFD8B6FFEED2FFF9E0
            FFFEF0463C49FFFFFFFFFFFFFFFFFFFFFFFF8F8792E1A87DDDA479FFD7B5FFED
            D4FFF7E1FFFDEDCCD6C0FFFFFFFFFFFFFFFFFFFFFFFF7C6A78DAA176DAA176FD
            C498FFEFE0FFEED6FFF4DAFFF2CFD6D5D8FFFFFFFFFFFFFFFFFF827788D0976C
            FFE1CBFFF9F5FFCBA3FFE4CBFFE7CDFFECC2F1F1F2FFFFFFFFFFFFFFFFFFDFDC
            E0BF8656FCC398FFE5D2FBC297ECB388FFC99E8C8171FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF9C929FBF8857D69D72DBA277EAB186AB976FE9E8EBFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFE4E0E49D91A0A1939DA69FABFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF}
          OnClick = Sb_Pesq_ClienteClick
        end
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
        object DBLCB_Empresa: TDBLookupComboBox
          Left = 283
          Top = 19
          Width = 392
          Height = 21
          KeyField = 'EMP_CODIGO'
          ListField = 'EMP_NOME'
          ListSource = DM_ListaConsultas.Ds_ListaFornecedor
          TabOrder = 3
          OnExit = DBLCB_EmpresaExit
        end
        object Panel2: TPanel
          Left = 8
          Top = 349
          Width = 720
          Height = 51
          Anchors = [akLeft, akRight, akBottom]
          BevelInner = bvLowered
          TabOrder = 7
          object Label22: TLabel
            Left = 8
            Top = 6
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
          object Label11: TLabel
            Left = 84
            Top = 6
            Width = 43
            Height = 14
            Caption = 'Produtos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 369
            Top = 6
            Width = 25
            Height = 14
            Caption = 'Frete'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 577
            Top = 6
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
          object Label23: TLabel
            Left = 318
            Top = 6
            Width = 10
            Height = 14
            Caption = 'IPI'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 175
            Top = 6
            Width = 52
            Height = 14
            Caption = 'Base ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 243
            Top = 6
            Width = 52
            Height = 14
            Caption = 'Valor ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 440
            Top = 6
            Width = 23
            Height = 14
            Caption = 'Taxa'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 492
            Top = 6
            Width = 77
            Height = 14
            Caption = 'Valor Desconto '
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Qt_Produto: TEdit_Setes
            Left = 8
            Top = 21
            Width = 71
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Color = clMenu
            DragMode = dmAutomatic
            TabOrder = 0
            Text = '0,00'
          end
          object E_VL_IPI: TEdit_Setes
            Left = 316
            Top = 21
            Width = 50
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Color = clMenu
            DragMode = dmAutomatic
            TabOrder = 3
            Text = '0,00'
          end
          object E_VL_Frete: TEdit_Setes
            Left = 367
            Top = 21
            Width = 67
            Height = 21
            Alignment = taRightJustify
            TabOrder = 4
            Text = '0,00'
            OnExit = E_VL_FreteExit
          end
          object E_VL_ICMS: TEdit_Setes
            Left = 242
            Top = 21
            Width = 71
            Height = 21
            Alignment = taRightJustify
            TabOrder = 2
            Text = '0,00'
          end
          object E_VL_Bs_ICMS: TEdit_Setes
            Left = 173
            Top = 21
            Width = 66
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = '0,00'
          end
          object E_VL_Produto: TPanel
            Left = 81
            Top = 21
            Width = 91
            Height = 21
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
            TabOrder = 5
          end
          object E_Aq_Desconto: TEdit_Setes
            Left = 438
            Top = 21
            Width = 53
            Height = 21
            Alignment = taRightJustify
            TabOrder = 6
            Text = '0,00'
            OnExit = E_Aq_DescontoExit
          end
          object E_VL_Desconto: TEdit_Setes
            Left = 493
            Top = 21
            Width = 77
            Height = 21
            Alignment = taRightJustify
            TabOrder = 7
            Text = '0,00'
            OnExit = E_VL_DescontoExit
          end
          object E_VL_Pedido: TPanel
            Left = 571
            Top = 21
            Width = 97
            Height = 21
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
            TabOrder = 8
          end
        end
        object E_Cd_Empresa: TEdit
          Left = 187
          Top = 21
          Width = 90
          Height = 21
          TabOrder = 2
          OnExit = E_Cd_EmpresaExit
          OnKeyPress = E_Cd_EmpresaKeyPress
        end
        object E_Nr_Parcelas: TEdit_Setes
          Left = 223
          Top = 61
          Width = 37
          Height = 21
          EditMask = '000;1;_'
          MaxLength = 3
          TabOrder = 5
          Text = '   '
          OnExit = E_Nr_ParcelasExit
        end
        object E_Prazo: TMaskEdit
          Left = 262
          Top = 61
          Width = 347
          Height = 21
          TabOrder = 6
          Text = ''
        end
        object E_Data: TDateTimePicker
          Left = 83
          Top = 21
          Width = 103
          Height = 21
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 1
        end
        object E_Dt_Entrega: TEdit
          Left = 591
          Top = 470
          Width = 94
          Height = 21
          Anchors = [akRight, akBottom]
          AutoSize = False
          TabOrder = 8
        end
        object RG_frete: TRadioGroup
          Left = 589
          Top = 409
          Width = 139
          Height = 47
          Anchors = [akRight, akBottom]
          Caption = ' Frete por Conta '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'REMETENTE / CIF'
            'DESTINAT'#193'RIO / FOB')
          ParentFont = False
          TabOrder = 9
        end
        object chbx_NomeFornecedor: TCheckBox
          Left = 339
          Top = 5
          Width = 120
          Height = 15
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 10
          OnClick = chbx_NomeFornecedorClick
        end
        object chbx_fantasiaFornecedor: TCheckBox
          Left = 460
          Top = 5
          Width = 104
          Height = 15
          Caption = 'Apelido/Fantasia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          OnClick = chbx_fantasiaFornecedorClick
        end
        object E_Nr_Pedido: TEdit_Setes
          Left = 7
          Top = 21
          Width = 74
          Height = 21
          TabStop = False
          TabOrder = 0
          Text = ''
        end
        object chbx_aprovados: TCheckBox
          Left = 592
          Top = 492
          Width = 97
          Height = 17
          Anchors = [akRight, akBottom]
          Caption = 'Aprovado'
          TabOrder = 12
        end
        inline Fm_FormaPagto: TFm_FormaPagto
          Left = 3
          Top = 44
          Width = 213
          Height = 42
          TabOrder = 4
          ExplicitLeft = 3
          ExplicitTop = 44
          ExplicitWidth = 213
          ExplicitHeight = 42
          inherited Lb_FormaPagamento: TLabel
            Width = 207
          end
          inherited pnl_Forma: TPanel
            Width = 213
            Height = 28
            ExplicitWidth = 213
            ExplicitHeight = 28
            inherited SB_FormaPag: TSpeedButton
              Left = 187
              Height = 25
              ExplicitLeft = 188
              ExplicitHeight = 28
            end
            inherited DBLCB_FormaPagto: TDBLookupComboBox
              Width = 178
              DataField = 'PED_CODFPG'
              ExplicitWidth = 178
            end
          end
        end
      end
      object Pnl_botao: TPanel
        Left = 0
        Top = 531
        Width = 739
        Height = 65
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object SB_Inserir: TSpeedButton
          AlignWithMargins = True
          Left = 55
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
          Caption = 'Inserir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_InserirClick
          ExplicitLeft = 2
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 130
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_AlterarClick
          ExplicitLeft = 77
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Excluir: TSpeedButton
          AlignWithMargins = True
          Left = 205
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
          Caption = 'Excluir - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_ExcluirClick
          ExplicitLeft = 152
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Gravar: TSpeedButton
          AlignWithMargins = True
          Left = 280
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
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
          ExplicitLeft = 227
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 355
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
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
          ExplicitLeft = 302
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Faturar: TSpeedButton
          AlignWithMargins = True
          Left = 507
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
          Caption = 'Faturar - F10'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_FaturarClick
          ExplicitLeft = 460
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Imprimir: TSpeedButton
          AlignWithMargins = True
          Left = 582
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
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
          ExplicitLeft = 529
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Pesquisar: TSpeedButton
          AlignWithMargins = True
          Left = 430
          Top = 5
          Width = 77
          Height = 55
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
          Caption = 'Pesquisar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_PesquisarClick
          ExplicitLeft = 377
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Sair_0: TSpeedButton
          AlignWithMargins = True
          Left = 657
          Top = 5
          Width = 75
          Height = 55
          Margins.Left = 0
          Margins.Right = 5
          Align = alRight
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
          ExplicitLeft = 604
          ExplicitTop = 6
          ExplicitHeight = 54
        end
      end
      object PG_Itens: TPageControl
        Left = 4
        Top = 88
        Width = 731
        Height = 259
        ActivePage = TS_Produto
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiLine = True
        TabOrder = 2
        object TS_Produto: TTabSheet
          Caption = '&Produtos'
          DragMode = dmAutomatic
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Produto: TPanel
            Left = 0
            Top = 0
            Width = 723
            Height = 231
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              723
              231)
            object Sb_Ins_Produto: TSpeedButton
              Left = 337
              Top = 194
              Width = 113
              Height = 32
              Anchors = [akRight, akBottom]
              Caption = 'Novo Produto - F2'
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
              Transparent = False
              OnClick = Sb_Ins_ProdutoClick
            end
            object Sb_Alt_Produto: TSpeedButton
              Left = 456
              Top = 195
              Width = 124
              Height = 32
              Anchors = [akRight, akBottom]
              Caption = 'Alterar Produto - F3'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
                5555555500005577777777777777777500005000000000000000007500005088
                80FFFFFF0FFFF0750000508180F4444F0F44F0750000508880FFFFFF0FFFF075
                0000508180F4444F0F44F0750000508880FFFFFF0FFFF0750000508180F4444F
                0F44F0750000508880FF0078088880750000508180F400007844807500005088
                80FF7008007880750000508180F4408FF80080750000508880FFF70FFF800075
                0000500000000008FF803007000050EEEEEEEE70880B43000000500000000000
                00FBB43000005555555555550BFFBB43000055555555555550BFFBB400005555
                55555555550BFFBB0000}
              ParentFont = False
              Transparent = False
              OnClick = Sb_Alt_ProdutoClick
              ExplicitLeft = 419
              ExplicitTop = 169
            end
            object Sb_Exc_Produto: TSpeedButton
              Left = 586
              Top = 194
              Width = 121
              Height = 32
              Anchors = [akRight, akBottom]
              Caption = 'Excluir Produto - F4'
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Glyph.Data = {
                DE010000424DDE01000000000000760000002800000024000000120000000100
                0400000000006801000000000000000000001000000010000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
                6666666666666666666666660000666666666666666666666666666666666666
                0000666666666666661F66666666666666668F66000066661F66666666666666
                668F6666666666660000666111F6666661F666666888F6666668F66600006661
                11F666661F6666666888F666668F666600006666111F66611F66666666888F66
                688F6666000066666111F611F6666666666888F688F66666000066666611111F
                66666666666688888F66666600006666666111F66666666666666888F6666666
                000066666611111F66666666666688888F666666000066666111F61F66666666
                666888F68F66666600006661111F66611F66666668888F66688F666600006611
                11F6666611F666668888F6666688F66600006611F6666666611F666688F66666
                66688F6600006666666666666666666666666666666666660000666666666666
                6666666666666666666666660000666666666666666666666666666666666666
                0000}
              NumGlyphs = 2
              ParentFont = False
              Transparent = False
              OnClick = Sb_Exc_ProdutoClick
            end
            object DBG_Produtos: TDBGrid
              Left = 2
              Top = 2
              Width = 719
              Height = 186
              Align = alTop
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_ItensVda
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Lucida Console'
              Font.Style = []
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick]
              ParentFont = False
              PopupMenu = Pop_Serie
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clNavy
              TitleFont.Height = -11
              TitleFont.Name = 'Arial'
              TitleFont.Style = []
              OnDblClick = DBG_ProdutosDblClick
              OnKeyDown = DBG_ProdutosKeyDown
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
                  Width = 241
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'MED_ABREVIATURA'
                  Title.Caption = 'Unidade'
                  Width = 50
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
                  Width = 69
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
                  Width = 66
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
                  FieldName = 'ITF_VL_IPI'
                  Title.Caption = 'Valor IPI'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRO_VL_CUSTO'
                  Title.Caption = 'Valor Custo'
                  Width = 105
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'TX_DIF_CUSTO'
                  Title.Caption = 'TX Difer. Custo'
                  Width = 82
                  Visible = True
                end>
            end
          end
        end
      end
      object Pg_Observacao: TPageControl
        Left = 7
        Top = 403
        Width = 577
        Height = 121
        ActivePage = tbs_despesa
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 3
        object TabSheet4: TTabSheet
          Caption = 'Observa'#231#245'es'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Observacao: TPanel
            Left = 0
            Top = 0
            Width = 569
            Height = 93
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object E_Observ: TMemo
              Left = 2
              Top = 2
              Width = 565
              Height = 89
              Align = alClient
              TabOrder = 0
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Transporte/Entrega'
          OnShow = TabSheet5Show
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Entrega: TPanel
            Left = 0
            Top = 0
            Width = 569
            Height = 93
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label4: TLabel
              Left = 6
              Top = 5
              Width = 162
              Height = 14
              Caption = 'C'#243'digo / Nome do Transportadora'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Transportadora: TSpeedButton
              Left = 490
              Top = 20
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
            object DBLCB_Transportadora: TDBLookupComboBox
              Left = 57
              Top = 22
              Width = 431
              Height = 21
              KeyField = 'EMP_CODIGO'
              ListField = 'EMP_FANTASIA'
              ListSource = DM_ListaConsultas.Ds_ListaTransportadora
              TabOrder = 1
              OnKeyDown = DBLCB_TransportadoraKeyDown
            end
            object E_CodTransp: TEdit
              Left = 4
              Top = 22
              Width = 52
              Height = 21
              TabOrder = 0
            end
            inline Fm_EndEntrega: TFm_ListaEmpresaEndereco
              Left = 2
              Top = 44
              Width = 487
              Height = 41
              TabOrder = 2
              ExplicitLeft = 2
              ExplicitTop = 44
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'Faturamento/Cobran'#231'a'
          ImageIndex = 2
          OnShow = TabSheet6Show
          object Pnl_Faturamento: TPanel
            Left = 0
            Top = 0
            Width = 569
            Height = 93
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            inline Fm_EndFaturamento: TFm_ListaEmpresaEndereco
              Left = 1
              Top = 4
              Width = 487
              Height = 41
              TabOrder = 0
              ExplicitLeft = 1
              ExplicitTop = 4
              inherited Label10: TLabel
                Width = 217
                Caption = 'C'#243'digo / Nome da Empresa para Faturamento'
                ExplicitWidth = 217
              end
            end
            inline Fm_EndCobranca: TFm_ListaEmpresaEndereco
              Left = 2
              Top = 45
              Width = 487
              Height = 41
              TabOrder = 1
              ExplicitLeft = 2
              ExplicitTop = 45
              inherited Label10: TLabel
                Width = 204
                Caption = 'C'#243'digo / Nome da empresa para Cobran'#231'a'
                ExplicitWidth = 204
              end
            end
          end
        end
        object tbs_despesa: TTabSheet
          Caption = 'Despesas'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Pnl_Despesa: TPanel
            Left = 0
            Top = 0
            Width = 569
            Height = 93
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              569
              93)
            object Label20: TLabel
              Left = 4
              Top = 4
              Width = 64
              Height = 16
              Caption = 'Valor FOB'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label21: TLabel
              Left = 4
              Top = 20
              Width = 89
              Height = 16
              Caption = 'Total Despesas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label24: TLabel
              Left = 6
              Top = 38
              Width = 124
              Height = 16
              Caption = 'Percentual Despesas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Lb_Vl_Fob: TLabel
              Left = 144
              Top = 4
              Width = 120
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Lb_vl_Despesas: TLabel
              Left = 144
              Top = 20
              Width = 120
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Lb_aliq_Depesas: TLabel
              Left = 144
              Top = 38
              Width = 120
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label30: TLabel
              Left = 265
              Top = 38
              Width = 16
              Height = 16
              Alignment = taRightJustify
              Caption = ' %'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Custo_Pedido: TSpeedButton
              Left = 474
              Top = 46
              Width = 89
              Height = 41
              Anchors = [akRight, akBottom]
              Caption = 'Detalhes'
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
                33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
                FFF07F3FF3FF3FFF3FF70F00F00F000F00F07F773773777377370FFFFFFFFFFF
                FFF07F3FF3FF33FFFFF70F00F00FF00000F07F773773377777F70FEEEEEFF0F9
                FCF07F33333337F7F7F70FFFFFFFF0F9FCF07F3FFFF337F737F70F0000FFF0FF
                FCF07F7777F337F337370F0000FFF0FFFFF07F777733373333370FFFFFFFFFFF
                FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
                C880733777777777733700000000000000007777777777777777333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              NumGlyphs = 2
              ParentFont = False
              Transparent = False
              OnClick = Sb_Custo_PedidoClick
              ExplicitLeft = 429
            end
          end
        end
        object TabSheet1: TTabSheet
          Caption = 'Outras Infomra'#231#245'es'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 569
            Height = 93
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Sb_Negocio: TSpeedButton
              Left = 494
              Top = 19
              Width = 23
              Height = 22
              Caption = '...'
              OnClick = Sb_NegocioClick
            end
            object Label13: TLabel
              Left = 7
              Top = 5
              Width = 187
              Height = 14
              Caption = 'Pedido Vinculado '#224' Neg'#243'cio espec'#237'fico'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Dblcb_Negocio: TDBLookupComboBox
              Left = 7
              Top = 21
              Width = 482
              Height = 21
              KeyField = 'NEG_CODIGO'
              ListField = 'NEG_DESCRICAO'
              ListSource = DM.Ds_Negocio
              TabOrder = 0
              OnKeyDown = Dblcb_NegocioKeyDown
            end
          end
        end
      end
    end
    object tbs_pesquisa: TTabSheet
      Caption = 'tbs_pesquisa'
      ImageIndex = 1
      OnShow = tbs_pesquisaShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 57
        Width = 739
        Height = 101
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label36: TLabel
          Left = 6
          Top = 22
          Width = 60
          Height = 13
          AutoSize = False
          Caption = 'Ordem'
          FocusControl = E_BuscaPedido
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BuscaCliente: TEdit
          Left = 251
          Top = 37
          Width = 429
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 3
        end
        object E_BuscaPedido: TEdit_Setes
          Left = 4
          Top = 37
          Width = 78
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          Text = ''
        end
        object ChBx_bUSCA_Nome: TCheckBox
          Left = 261
          Top = 20
          Width = 121
          Height = 17
          Caption = 'Nome/Raz'#227'o Social'
          TabOrder = 4
          OnClick = ChBx_bUSCA_NomeClick
        end
        object ChBx_busca_Fantasia: TCheckBox
          Left = 381
          Top = 20
          Width = 121
          Height = 17
          Caption = 'Apelido/Fantasia'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = ChBx_busca_FantasiaClick
        end
        object E_Data_Ini: TDateTimePicker
          Left = 86
          Top = 37
          Width = 82
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 1
        end
        object E_Data_Fim: TDateTimePicker
          Left = 167
          Top = 37
          Width = 85
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 2
        end
        object ChBx_Periodo: TCheckBox
          Left = 88
          Top = 22
          Width = 128
          Height = 12
          Caption = 'Data Inicial    Data Final'
          TabOrder = 6
          OnClick = ChBx_PeriodoClick
        end
        object rdg_pedido: TRadioGroup
          Left = 6
          Top = 59
          Width = 246
          Height = 36
          Caption = 'Situa'#231#227'o do Pedido'
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 2
          Items.Strings = (
            'Aprovados'
            'Pendentes'
            'Todos')
          ParentFont = False
          TabOrder = 7
        end
      end
      object Pnl_busca: TGroupBox
        Left = 0
        Top = 158
        Width = 739
        Height = 438
        Align = alClient
        Caption = 'Resultados da Pesquisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          739
          438)
        object SB_Buscar: TSpeedButton
          Left = 641
          Top = 272
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Buscar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_BuscarClick
          ExplicitLeft = 589
          ExplicitTop = 254
        end
        object SB_Visualizar: TSpeedButton
          Left = 641
          Top = 326
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Visualizar - F8'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_VisualizarClick
          ExplicitLeft = 589
          ExplicitTop = 308
        end
        object SB_Cadastrar: TSpeedButton
          Left = 641
          Top = 218
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Cadastrar - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_CadastrarClick
          ExplicitLeft = 589
          ExplicitTop = 200
        end
        object Sb_Sair_1: TSpeedButton
          Left = 641
          Top = 380
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Sair- Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Sair_1Click
          ExplicitLeft = 589
          ExplicitTop = 362
        end
        object DBG_Pesquisa: TDBGrid
          Left = 2
          Top = 15
          Width = 633
          Height = 421
          Align = alLeft
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          DataSource = Ds_Pesquisa
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = SB_VisualizarClick
          OnTitleClick = DBG_PesquisaTitleClick
          Columns = <
            item
              Expanded = False
              FieldName = 'PED_DATA'
              Title.Caption = 'Data'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PED_NUMERO'
              Title.Caption = 'Pedido'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMP_NOME'
              Title.Caption = 'Nome do Fornecedor'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 332
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PED_VL_PEDIDO'
              Title.Caption = 'Valor'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 85
              Visible = True
            end>
        end
      end
      inline Fm_LME: TFm_ListaMultiEmpresa
        Left = 0
        Top = 0
        Width = 739
        Height = 57
        Align = alTop
        TabOrder = 2
        ExplicitWidth = 739
        ExplicitHeight = 57
        inherited pnl_linha_1: TPanel
          Width = 739
          ExplicitWidth = 739
          inherited Sb_open: TSpeedButton
            Left = 715
            ExplicitLeft = 715
          end
          inherited Dblcb_Lista: TDBLookupComboBox
            Width = 715
            ExplicitWidth = 715
          end
        end
        inherited pnl_top: TPanel
          Width = 739
          ExplicitWidth = 739
        end
      end
    end
  end
  object Ds_ItensVda: TDataSource
    DataSet = Qr_ItensCpa
    Left = 88
    Top = 248
  end
  object PrintDialog: TPrintDialog
    Left = 504
    Top = 65528
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA, PED_VL_PE' +
        'DIDO, EMP_NOME'
      'FROM TB_PEDIDO tb_pedido '
      '  INNER JOIN TB_EMPRESA tb_empresa '
      '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP ) '
      'WHERE (PED_CODIGO IS NOT NULL) ')
    Left = 592
    Top = 240
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 592
    Top = 288
  end
  object Qr_Endereco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_ENDERECO'
      '    INNER JOIN TB_CIDADE tb_cidade'
      '    ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '    INNER JOIN TB_UF tb_uf'
      '    ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)'
      'ORDER BY END_ENDER')
    Left = 272
    Top = 222
    ParamData = <
      item
        DataType = ftInteger
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_Endereco: TDataSource
    AutoEdit = False
    DataSet = Qr_Endereco
    Left = 275
    Top = 273
  end
  object Qr_ItensCpa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ItensCpaAfterOpen
    OnCalcFields = Qr_ItensCpaCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_SEQUENCIA,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_CODIGONCM,'
      '  PRO_DESCRICAO,'
      '  PRO_SERIE,'
      '  PRO_TIPO,'
      '  TPR_MODALIDADE,'
      '  EMB_ABREVIATURA,'
      '  TPR_NOME,'
      '  PRO_ORIGEM,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  PRO_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '  ITF_AQ_DESC,'
      '  ITF_VL_DESC,'
      '  ITF_AQ_IPI,'
      '  ITF_CODEST,'
      '  ITF_CODTPR,'
      '  ITF_ALTURA,'
      '  ITF_LARGURA,'
      '  ITF_NR_PECAS,'
      '  ITF_ESTOQUE,'
      '  ITF_AQ_ICMS,'
      '  PRO_VL_CUSTOMED,'
      
        '  CAST((((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) * ITF_AQ_IPI) ' +
        '/ 100 AS DOUBLE PRECISION) ITF_VL_IPI'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      ''
      '   LEFT OUTER JOIN TB_TABELA_PRECO tb_tabela_preco'
      '  ON(tb_tabela_preco.TPR_CODIGO =  Tb_itens_nfl.ITF_CODTPR)'
      ''
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   left join tb_embalagem tb_embalagem'
      '     on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      'WHERE (ITF_CODPED =:PED_CODIGO)'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    Left = 90
    Top = 215
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensCpaITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensCpaITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensCpaITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
      Required = True
    end
    object Qr_ItensCpaITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensCpaPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensCpaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensCpaPRO_SERIE: TStringField
      FieldName = 'PRO_SERIE'
      Origin = '"TB_PRODUTO"."PRO_SERIE"'
      Size = 1
    end
    object Qr_ItensCpaEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensCpaITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensCpaITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensCpaITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensCpaITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensCpaITF_LARGURA: TBCDField
      FieldName = 'ITF_LARGURA'
      Origin = '"TB_ITENS_NFL"."ITF_LARGURA"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensCpaITF_ALTURA: TBCDField
      FieldName = 'ITF_ALTURA'
      Origin = '"TB_ITENS_NFL"."ITF_ALTURA"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensCpaMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensCpaITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensCpaITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensCpaITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensCpaITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensCpaITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensCpaITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensCpaPRO_VL_CUSTO: TFMTBCDField
      FieldName = 'PRO_VL_CUSTO'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensCpaITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensCpaITF_VL_IPI: TFloatField
      FieldName = 'ITF_VL_IPI'
      ProviderFlags = []
    end
    object Qr_ItensCpaITF_VL_SUBTOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_SUBTOTAL'
      Calculated = True
    end
    object Qr_ItensCpaITF_VL_TOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_TOTAL'
      Calculated = True
    end
    object Qr_ItensCpaTX_DIF_CUSTO: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TX_DIF_CUSTO'
      Calculated = True
    end
    object Qr_ItensCpaITF_SEQUENCIA: TIntegerField
      FieldName = 'ITF_SEQUENCIA'
      Origin = '"TB_ITENS_NFL"."ITF_SEQUENCIA"'
    end
    object Qr_ItensCpaPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = '"TB_PRODUTO"."PRO_CODIGONCM"'
      Size = 50
    end
    object Qr_ItensCpaPRO_TIPO: TStringField
      FieldName = 'PRO_TIPO'
      Origin = '"TB_PRODUTO"."PRO_TIPO"'
      Size = 1
    end
    object Qr_ItensCpaTPR_MODALIDADE: TStringField
      FieldName = 'TPR_MODALIDADE'
      Origin = '"TB_TABELA_PRECO"."TPR_MODALIDADE"'
      Size = 1
    end
    object Qr_ItensCpaTPR_NOME: TStringField
      FieldName = 'TPR_NOME'
      Origin = '"TB_TABELA_PRECO"."TPR_NOME"'
      Size = 50
    end
    object Qr_ItensCpaPRO_ORIGEM: TStringField
      FieldName = 'PRO_ORIGEM'
      Origin = '"TB_PRODUTO"."PRO_ORIGEM"'
      Size = 1
    end
    object Qr_ItensCpaITF_NR_PECAS: TBCDField
      FieldName = 'ITF_NR_PECAS'
      Origin = '"TB_ITENS_NFL"."ITF_NR_PECAS"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensCpaPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 344
    Top = 199
  end
  object Qr_Cp_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  DISTINCT'
      '   PRO_CODIGO,'
      '   MED_ABREVIATURA,'
      '   PRO_VL_CUSTO,'
      '   EST_QTDE,'
      '   PRO_QTDE_MIN,'
      '   EMP_CODIGO'
      'FROM TB_PRODUTO tb_produto'
      '   INNER JOIN TB_ESTOQUE tb_estoque'
      '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO)'
      '     INNER JOIN  TB_PROD_FORN tb_prod_forn'
      '     ON (tb_prod_forn.PFR_CODPRO = tb_produto.PRO_CODIGO)'
      '    INNER JOIN TB_EMPRESA tb_fornecedor'
      '    ON (tb_fornecedor.EMP_CODIGO = tb_prod_forn.PFR_CODFOR)'
      '  INNER JOIN tb_medida tb_medida'
      '    ON (tb_medida.med_codigo = tb_produto.pro_codmed)'
      
        'WHERE (EST_QTDE < PRO_QTDE_MIN) AND (PRO_ATIVO = '#39'S'#39') AND (EST_C' +
        'ODETS =:ETS_CODIGO)'
      'AND (EMP_CODIGO=:EMP_CODIGO)'
      '  ')
    Left = 425
    Top = 185
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ETS_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_adicao: TDataSource
    Left = 160
    Top = 248
  end
  object Qr_Itens_Ajuste: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Itens_AjusteAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  PRO_TIPO_EMBAL,'
      '  ITF_UNIDADE,'
      '  ITF_ST_TRIB,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_ALIQ_IPI,'
      '  ITF_AQ_COM,'
      '  ITF_ALIQ_ICMS,'
      '  ITF_RED_BASE,'
      '  PRO_UNIDADE,'
      '  ITF_DIFERIDO,'
      '  PRO_SUB_TRIB,'
      '  ITF_ESTOQUE,'
      '  ITF_DESPACHO,'
      '  (ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL,'
      
        '   ((ITF_QTDE * ITF_VL_UNIT)  * ITF_ALIQ_IPI) / 100 AS ITF_VL_IP' +
        'I,'
      '  PRO_VL_CUSTO,'
      '  PRO_VL_CUSTOREAL,'
      '  PRO_VL_CUSTOMED,'
      '  PRO_QTDE'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      'WHERE (ITF_CODPED =:PED_CODIGO)'
      'ORDER BY ITF_CODIGO'
      ''
      '  ')
    Left = 632
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Qr_Entrega: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT '
      '    END_CODIGO, '
      '    EMP_CODIGO,'
      '    (EMP_FANTASIA || '#39' - '#39' || END_ENDER) AS ENDERECO'
      'FROM TB_EMPRESA tb_empresa'
      '    INNER JOIN TB_ENDERECO tb_endereco'
      '    ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'ORDER BY EMP_FANTASIA')
    Left = 383
    Top = 242
    object Qr_EntregaEND_CODIGO: TIntegerField
      FieldName = 'END_CODIGO'
      Origin = 'TB_ENDERECO.END_CODIGO'
      Required = True
    end
    object Qr_EntregaENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 203
    end
    object Qr_EntregaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
  end
  object Ds_Entrega: TDataSource
    DataSet = Qr_Entrega
    Left = 431
    Top = 242
  end
  object Pop_Serie: TPopupMenu
    Left = 508
    Top = 244
    object Corrigirsequnciadositens1: TMenuItem
      Caption = 'Corrigir sequ'#234'ncia dos itens'
      OnClick = Corrigirsequnciadositens1Click
    end
    object RegistraNmerodeSerie: TMenuItem
      Caption = 'Registra N'#250'mero de S'#233'rie'
      OnClick = RegistraNmerodeSerieClick
    end
    object RegistraNmerodeLote: TMenuItem
      Caption = 'Registra N'#250'mero do lote'
      OnClick = RegistraNmerodeLoteClick
    end
    object CadastrodoProduto: TMenuItem
      Caption = 'Cadastro do Produto'
      OnClick = CadastrodoProdutoClick
    end
    object InformaesdaDI1: TMenuItem
      Caption = 'Informa'#231#245'es da D.I.'
      OnClick = InformaesdaDI1Click
    end
  end
  object Mnu_Controle: TMainMenu
    Left = 68
    Top = 168
    object Mnu_tarefas: TMenuItem
      Caption = 'Tarefas'
      object Importao1: TMenuItem
        Caption = 'Importa'#231#227'o'
        OnClick = Importao1Click
      end
    end
  end
end
