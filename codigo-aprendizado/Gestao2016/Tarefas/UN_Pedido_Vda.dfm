object Fr_Pedido_Vda: TFr_Pedido_Vda
  Left = 565
  Top = 26
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Pedido de Venda'
  ClientHeight = 601
  ClientWidth = 860
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
  DesignSize = (
    860
    601)
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Pedido_Vda: TPageControl
    Left = 0
    Top = 0
    Width = 860
    Height = 601
    ActivePage = tbs_pedido
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tbs_pedido: TTabSheet
      Caption = 'Pedido'
      OnShow = tbs_pedidoShow
      DesignSize = (
        852
        570)
      object Pnl_Fundo: TPanel
        Left = 0
        Top = 0
        Width = 852
        Height = 504
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          852
          504)
        object Label2: TLabel
          Left = 101
          Top = 3
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
          Left = 465
          Top = 40
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
        object Label4: TLabel
          Left = 187
          Top = 3
          Width = 119
          Height = 14
          Caption = 'C'#243'digo / Nome do Cliente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object SB_Cliente: TSpeedButton
          Left = 740
          Top = 17
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SB_ClienteClick
        end
        object Label1: TLabel
          Left = 9
          Top = 3
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
        object Sb_Parcelamento: TSpeedButton
          Left = 763
          Top = 53
          Width = 24
          Height = 21
          Caption = '...'
          OnClick = Sb_ParcelamentoClick
        end
        object Sb_Pesq_Cliente: TSpeedButton
          Left = 764
          Top = 17
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
        object ChBx_Fantasia: TCheckBox
          Left = 437
          Top = 2
          Width = 121
          Height = 17
          Caption = 'Apelido/Fantasia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          OnClick = ChBx_FantasiaClick
        end
        object ChBx_Nome: TCheckBox
          Left = 310
          Top = 2
          Width = 121
          Height = 17
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 11
          OnClick = ChBx_NomeClick
        end
        object DBLCB_Empresa: TDBLookupComboBox
          Left = 289
          Top = 17
          Width = 447
          Height = 21
          KeyField = 'EMP_CODIGO'
          ListField = 'EMP_NOME'
          ListSource = DM_ListaConsultas.Ds_ListaCliente
          TabOrder = 3
          OnExit = DBLCB_EmpresaExit
          OnKeyDown = DBLCB_EmpresaKeyDown
        end
        object Pnl_totalizador: TPanel
          Left = 6
          Top = 312
          Width = 840
          Height = 44
          Anchors = [akLeft, akRight, akBottom]
          BevelInner = bvLowered
          TabOrder = 9
          DesignSize = (
            840
            44)
          object Label22: TLabel
            Left = 65
            Top = 3
            Width = 55
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Quantidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 5
          end
          object Label11: TLabel
            Left = 124
            Top = 3
            Width = 43
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Produtos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 64
          end
          object Label12: TLabel
            Left = 496
            Top = 3
            Width = 25
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Frete'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 436
          end
          object Label8: TLabel
            Left = 742
            Top = 3
            Width = 50
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Valor Total'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 603
          end
          object Label23: TLabel
            Left = 380
            Top = 3
            Width = 10
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'IPI'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 320
          end
          object Lb_Servico: TLabel
            Left = 195
            Top = 3
            Width = 43
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Servi'#231'os'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 135
          end
          object Label26: TLabel
            Left = 609
            Top = 3
            Width = 43
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Tx Desc.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 549
          end
          object Label5: TLabel
            Left = 663
            Top = 3
            Width = 77
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Valor Desconto '
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 603
          end
          object lbl: TLabel
            Left = 552
            Top = 3
            Width = 49
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Despesas'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 492
          end
          object Lb_Vl_Devolucao: TLabel
            Left = 267
            Top = 3
            Width = 51
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Devolu'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 207
          end
          object Lb_troca: TLabel
            Left = 323
            Top = 3
            Width = 28
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Troca'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 263
          end
          object Label3: TLabel
            Left = 433
            Top = 3
            Width = 43
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Sub. Trib'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 373
          end
          object E_VL_Frete: TEdit_Setes
            Left = 491
            Top = 19
            Width = 59
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '0,00'
            OnExit = E_VL_FreteExit
          end
          object E_VL_Produto: TPanel
            Left = 123
            Top = 19
            Width = 71
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
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
          object E_Vl_Devolucao: TPanel
            Left = 265
            Top = 19
            Width = 57
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
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
            TabOrder = 7
          end
          object E_Vl_Servico: TPanel
            Left = 194
            Top = 19
            Width = 71
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
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
            TabOrder = 6
          end
          object E_Aq_Desconto: TEdit_Setes
            Left = 607
            Top = 19
            Width = 53
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = '0,00'
            OnExit = E_Aq_DescontoExit
          end
          object E_VL_Desconto: TEdit_Setes
            Left = 662
            Top = 19
            Width = 77
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Text = '0,00'
            OnExit = E_VL_DescontoExit
          end
          object E_Vl_Despesa: TEdit_Setes
            Left = 551
            Top = 19
            Width = 52
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = '0,00'
            OnExit = E_Vl_DespesaExit
          end
          object E_VL_Pedido: TPanel
            Left = 740
            Top = 19
            Width = 93
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
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
          object E_Vl_Troca: TPanel
            Left = 322
            Top = 19
            Width = 55
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
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
          object E_Qt_Produto: TPanel
            Left = 65
            Top = 19
            Width = 57
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
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
            TabOrder = 10
          end
          object E_VL_IPI: TPanel
            Left = 377
            Top = 19
            Width = 55
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
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
            TabOrder = 11
          end
          object E_VL_St: TEdit_Setes
            Left = 431
            Top = 19
            Width = 59
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,00'
            OnExit = E_VL_StExit
          end
        end
        object E_Cd_Empresa: TEdit_Setes
          Left = 187
          Top = 17
          Width = 98
          Height = 21
          TabOrder = 2
          Text = ''
          OnExit = E_Cd_EmpresaExit
        end
        object E_Nr_Parcelas: TEdit_Setes
          Left = 463
          Top = 53
          Width = 37
          Height = 21
          EditMask = '000;1;_'
          MaxLength = 3
          TabOrder = 7
          Text = '000'
          OnExit = E_Nr_ParcelasExit
        end
        object E_Prazo: TMaskEdit
          Left = 502
          Top = 53
          Width = 257
          Height = 21
          MaxLength = 200
          TabOrder = 8
          Text = #192' VISTA'
        end
        object GroupBox3: TGroupBox
          Left = 679
          Top = 356
          Width = 161
          Height = 142
          Anchors = [akRight, akBottom]
          Caption = 'Financeiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          DesignSize = (
            161
            142)
          object Label24: TLabel
            Left = 4
            Top = 39
            Width = 79
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Saldo Devedor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label18: TLabel
            Left = 4
            Top = 77
            Width = 47
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Devolvido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 4
            Top = 57
            Width = 54
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = 'Pr'#233'-Datado'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Lb_Vl_Devedor: TLabel
            Left = 84
            Top = 39
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_predatado: TLabel
            Left = 84
            Top = 57
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_Devolvido: TLabel
            Left = 84
            Top = 77
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_Credito: TLabel
            Left = 84
            Top = 20
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Sb_Fich_Fin: TSpeedButton
            Left = 40
            Top = 96
            Width = 87
            Height = 41
            Anchors = [akRight, akBottom]
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
        end
        object E_Data: TDateTimePicker
          Left = 98
          Top = 17
          Width = 87
          Height = 21
          Date = 39580.000000000000000000
          Time = 39580.000000000000000000
          TabOrder = 1
        end
        object DBLCB_Prazo: TDBLookupComboBox
          Left = 465
          Top = 84
          Width = 322
          Height = 21
          KeyField = 'PRZ_PRAZO'
          ListField = 'PRZ_PRAZO'
          ListSource = dts_PrazoControlado
          TabOrder = 6
          OnClick = DBLCB_PrazoClick
        end
        object E_Nr_Pedido: TEdit_Setes
          Left = 7
          Top = 17
          Width = 87
          Height = 21
          TabStop = False
          TabOrder = 0
          Text = ''
          OnExit = E_Vl_DespesaExit
        end
        inline Fm_FormaPagto: TFm_FormaPagto
          Left = 223
          Top = 38
          Width = 236
          Height = 37
          TabOrder = 5
          OnExit = Fm_FormaPagtoExit
          ExplicitLeft = 223
          ExplicitTop = 38
          ExplicitWidth = 236
          ExplicitHeight = 37
          inherited Lb_FormaPagamento: TLabel
            Width = 230
          end
          inherited pnl_Forma: TPanel
            Width = 236
            Height = 23
            ExplicitWidth = 236
            ExplicitHeight = 23
            inherited SB_FormaPag: TSpeedButton
              Left = 210
              Height = 20
              OnClick = Fm_FormaPagto1SB_FormaPagClick
              ExplicitLeft = 210
              ExplicitTop = 14
              ExplicitHeight = 20
            end
            inherited DBLCB_FormaPagto: TDBLookupComboBox
              Width = 201
              OnClick = Fm_FormaPagto1DBLCB_FormaPagtoClick
              ExplicitWidth = 201
            end
          end
        end
        inline Fm_VendedorPedido: TFm_ListaColaboradores
          Left = 7
          Top = 39
          Width = 214
          Height = 37
          TabOrder = 4
          ExplicitLeft = 7
          ExplicitTop = 39
          ExplicitWidth = 214
          ExplicitHeight = 37
          inherited Label19: TLabel
            Width = 214
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 188
            Height = 20
            ExplicitLeft = 188
            ExplicitHeight = 46
          end
          inherited Dblcb_Vendedor: TDBLookupComboBox
            Width = 187
            ExplicitWidth = 187
          end
        end
      end
      object Pnl_Botao: TPanel
        Left = 0
        Top = 504
        Width = 852
        Height = 66
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object SB_Inserir: TSpeedButton
          AlignWithMargins = True
          Left = 122
          Top = 5
          Width = 80
          Height = 56
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
          OnClick = SB_InserirClick
          ExplicitLeft = 120
          ExplicitTop = 2
          ExplicitHeight = 62
        end
        object SB_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 202
          Top = 5
          Width = 80
          Height = 56
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
          OnClick = SB_AlterarClick
          ExplicitLeft = 207
          ExplicitTop = 6
        end
        object SB_Excluir: TSpeedButton
          AlignWithMargins = True
          Left = 282
          Top = 5
          Width = 80
          Height = 56
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
          OnClick = SB_ExcluirClick
          ExplicitLeft = 287
          ExplicitTop = 6
        end
        object SB_Gravar: TSpeedButton
          AlignWithMargins = True
          Left = 362
          Top = 5
          Width = 80
          Height = 56
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
          OnClick = SB_GravarClick
          ExplicitLeft = 367
          ExplicitTop = 6
        end
        object SB_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 442
          Top = 5
          Width = 80
          Height = 56
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
          OnClick = SB_CancelarClick
          ExplicitLeft = 420
          ExplicitTop = 2
          ExplicitHeight = 62
        end
        object SB_Faturar: TSpeedButton
          AlignWithMargins = True
          Left = 602
          Top = 5
          Width = 80
          Height = 56
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
          OnClick = SB_FaturarClick
          ExplicitLeft = 607
          ExplicitTop = 6
        end
        object Sb_Pesquisar: TSpeedButton
          AlignWithMargins = True
          Left = 522
          Top = 5
          Width = 80
          Height = 56
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
          OnClick = Sb_PesquisarClick
          ExplicitLeft = 495
          ExplicitTop = 2
          ExplicitHeight = 62
        end
        object Sb_Sair_0: TSpeedButton
          AlignWithMargins = True
          Left = 767
          Top = 5
          Width = 80
          Height = 56
          Margins.Left = 0
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
          ExplicitLeft = 720
          ExplicitTop = 2
          ExplicitHeight = 62
        end
        object Sb_Enviar: TSpeedButton
          Left = 682
          Top = 2
          Width = 85
          Height = 62
          Align = alRight
          Caption = 'Enviar - F11'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000C40E0000C40E00000000000000000000FFFFFFCFB8AF
            AFA6A3E3E3E3FFFFFFFFFFFFFFFFFFFFFFFFFDFCFCCDC0C0AC9C9CAC9D9DAC9D
            9DAC9D9DAC9D9DAC9D9DAC9D9DAC9D9DAC9D9DAC9D9DAC9D9DAD9E9EAD9E9EAD
            9E9EAD9E9EAD9E9EAD9E9EAD9E9EAD9E9EAD9E9EAD9D9DC1BEBEE3B4A1DA713A
            C368389E7260ACAAAAECECECFFFFFFFFFFFFF6EEEECEB0B0EAD7D7E5D1D1E4D0
            D0E4CFCEE3CDCDE2CCCCE2CACAE0C9C9E0C7C8DEC7C6DEC5C5DDC4C4DCC3C3DC
            C2C2DBC1C1DAC0C0DABEBED9BEBED9BCBDDBC0C0DAB5B5AA9A9AD46D41FFB17F
            FDA970EB8347BA69409B796EBABABAF7F7F7FAF3F3DCC8C8F5F3F3EFECEBEEEA
            EAEDE8E8ECE6E6EBE5E5EAE3E3E9E1E1E8DFDFE6DDDDE5DBDCE4D9D9E3D8D8E2
            D6D6E0D4D4E0D2D2DFD1D1DED0D0DDCECEDFD2D2DAC0C0AD9E9EF3D7CDEBB49C
            F7BD9CFFBD8FF99D62E27B42AF67459B867EB5B3B6CEBCBDF7F2F2EEE9E8EBE4
            E5ECE4E5ECE4E4E9E1E1E6DEDEE6DCDCE7DCDCE6DBDBE4D8D8E3D7D7E1D4D4E2
            D4D4DFD1D1DDCFCEDCCDCDDBCCCCDBCBCADDCECED8BCBCAD9E9EFFFFFFFCFCFC
            F1D0C2ECB69CFBC19DFDB685F79759D4723BA3614589726EBEC0C2EAE5E4F0EA
            EADCD6D6C0BABAB3ADACC4BDBDB6AFAFB5AEAEAFA8A8AFA7A7B8AFAFB4A9AAA9
            A0A0D7CBCAE1D3D3DFD1D1DCCCCDDBCCCCDDCFCFD9BDBDAD9E9EFFFFFFFFFFFF
            FFFFFFFBF2F2F0CBBCECB59BFFC29DFCAF7AF48F50CC6E3B8F6251989696E4DF
            DEDAD5D5B2AEADCAC4C4D0C9C9C1BABACDC5C5C2BABACAC1C1C5BBBBCDC2C2BF
            B4B4D0C3C3D2C4C4D2C4C4DCCDCDDCCCCCDED0D0D9BEBEAD9E9EFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFF9EBE7EEC5B3EEB89BFFC097FAA166C86B404E596D9B9B
            9DCBC6C7BAB6B5BCB7B7B4ADAECDC6C6B9B2B2B8B0B0B4ACADB6AEAEB4ABABB9
            AFAFC0B5B5B5AAAAA69B9BD8CACADDCECEDFD1D1DABFBEAD9E9EFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E4DCE9BDAAE198758F68623A66953E4F
            63979392D4CFCFD4CFCFD1CBCBCFC8C8C1BABACDC5C5BDB5B6C1B8B8BDB4B4BD
            B3B3CABFBFC2B7B7D3C6C6D9CCCCDDCFCFDFD2D2DBBFBFAD9E9EFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3ECECCCAAA6B7BECB9AABC26671
            7E868385B6B2B2B3AFAFB2ADADACA7A7B2ACACC1BABAC6BDBDB6AFAFC0B6B7AF
            A6A6B4ABABBDB3B3E2D6D6E0D4D4DED1D1E0D5D5DBC0C0AD9E9EFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF4F4E3D0D3FFFFFFFFFAF9FDF6
            F6F3EEEFF1EDEDF1EBECEEE8E8ECE5E5E8E0E0E4DCDDE7DEDFE3DADAE6DCDCE8
            DCDDE6DBDBE3D6D6DDCECEDCD2D3DCCED1DDD1D2D9BDBCAD9F9FFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCD2D4B19FA1BABEB9AFB4AEB2B4
            AFBEB8BBCBC3C8DFD4DAEFE5E9F1EBEBEDE7E7EAE3E3E8E1E1E8E0E0E7DDDDE5
            DBDBE5DADADDCECEDAB2A9DA7A64D6866BCD9A8FD8BDBDAD9FA0FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFEBEBEBA8BFA97DAD8162A5665AA35E5CAC635BAB625AAA
            6158A25E58955D678C688A9389C5BABFEAE1E3EEE7E6E9E1E1E8DFDFE7DDDDE5
            DCDCE5DCDBDCCFCFEEC9C1D76B54CB7D64E8977FDBC3C4AD9F9FFFFFFFFFFFFF
            FFFFFFFFFFFFABC8AD68B16D65C56D7CE2857AE08365CE7068C9716BC97367C9
            6F63CA6C69CE725FC66954AC5B5486568F908CDBD0D4EDE6E6E8E1E1E7DFDFE6
            DDDEE6DDDDE2D2D2ADA5A22137641F4BACBBB9C7E5C6C2AD9F9FFFFFFFFFFFFF
            FCFCFC8BC1905DC26678E2816AC67288CD8EA9D1A8B0C0A4CDE5CFCADFCBC6DE
            C7BBDBBC9BD09F7AC88065C96D5FC9684999507A8479D8CFD2ECE5E4E8E0E1E7
            DFDFE7DEDEE4D4D4958C8924466D1D6CC7A7B7CEE8C6C1AD9F9FFFFFFFFFFFFF
            93C79761CF6B63CB6C87C68CE0EEE0FFFFFFFFF5F8E7C7D1FFFFFFFFFFFFFFF7
            FFFEEEFBFCEEF8F2EFF0BDDEBF71CA7B5ACF663F9B488B928AE8E2E3EEEAE9EC
            E6E7ECE6E6E4D7D6DFD3D39993908E8A8EE2D8D9E1C3C4AA9C9CFFFFFFCAE2CB
            4CBF5657C66193C297FFFFFFF5F5F5A6BEA87F9D7D75816CACA3A5D0C2C49EB4
            9D7C9C7E7F957E9E9997D0B6C3CCC6BC6CB1664AAB4A729869DCC5C8E5D0D0E3
            CECEE3CDCDE0C8C8DFC2C2E4C8C8E6C8C6DFC2C2DBB7B7BFB0B0FFFFFF71C277
            54D86067AD6EFFFFFFD9E7D959AE603EB64845CA5139B543357E34497E4539AD
            413BB8463BB344329235476F43A08E91DED3D2DDDFD5E1E0D7EADBDBE9DADAEA
            DADAEADADAEADBDBEADCDCEBDCDCEBDCDCEBDDDDEDDEDEF9F5F5EAF2EA3FB94A
            38AF43BBC9BCF8FBF854B35A4ACF5548C5535DBB656AC6723AB9453FC34C4FCB
            5C4EC85B4DB8553CBC4835BE43408F49B5B5B5FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAED8B133C43F
            479C4EF1F1F1B5DEB834BD403FC54B56A55CF2F2F2FFFFFFBBE1BE3DB74642C8
            4F36B942799B7CBDDEC04CBD5634C441408345C3C3C3FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF70C07626BD32
            5D9C61FDFDFD84CB892FC03C29B63685A588FFFFFFFFFFFFFFFFFF87CC8C2FC0
            3C2BBA38649068FFFFFFD6ECD737B64222AE2F6C8A6FEFEFEFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5EB9663DC248
            6B9B6FFEFEFE78C77E1FBC2D19AC2685A087FEFEFEFFFFFFFFFFFFD6ECD928B0
            3423BE323D8D44DCDCDCFFFFFF98D29D1FBA2C318C38CACACAFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EC0756AD473
            69986DF8F8F89CD6A13EC44A23B63068926BF4F4F4FFFFFFFFFFFFFAFCFA40B3
            4919BE2824912DC1C2C1FFFFFFE9F4EA28AE3314981FA0ABA1FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF92CE9671DA7A
            59965EE7E7E7CDEAD067C96F6CD57553925ADADADAFFFFFFFFFFFFFFFFFF52B9
            5B0AB81A0E97199CA99DFFFFFFFFFFFF44B54F07A31489A38BFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCBE6CC71D77A
            56A15CBBBBBBF7FCF777C77E82E08B5CAE62979A97FCFCFCFFFFFFFFFFFF61BC
            694CCC584EBE58819A83F9F9F9FFFFFF6DC47427B33488A68BFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F9F77DCD84
            76CF7E7B917DFEFEFEC0E4C37DD48487DE8F5E9663A2A2A2E0E0E0B4CCB67ECE
            848EE09685DA8D6B976EEBEBEBFFFFFF86CC8C72C7799EB5A0FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FD6A4
            9EF2A5629A67C0C0C0FFFFFFA5D9AA91E19898E79F69AD716CA77178C17E8ADB
            9190DD97A0EDA7619E66DCDCDCE0EFE186D18C73BB79C7CEC7FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0F1E1
            8FD79694DA9A6B8A6ED8D8D8FFFFFFB5E0B991D69790E09792E4998BD192A2D0
            A68DCD9293D99A7EBF84E7E7E79ECFA3A3EBA97EB483F5F5F5FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            B6DDBAACEBB190CE956D8C6FC4C4C4FFFFFFF1F7F1D8F0DAD7F0D9EAF5EAFFFF
            FFF2F9F2EDF2EDE7E8E7AACCAD9EDDA38FD095BED0BFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB0DCB4B8F1BCA9E3AE709F747F9481BFBFBFE9E9E9F8F8F8F8F8F8EEEE
            EEE5E5E5B9C8BB99C09CAAE3AFB2EBB7A5CAA8FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFBCE1BFA9E1AFCCFFD0A8DEAD86B68877A87C77A27A7BA67E7FAC
            8288BA8D9DD3A2C9FFCEA7DFADB2D5B5FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFDCEEDDB2DFB7B1E2B6B8EEBDCAFACED5FDD8D7FDDACFFB
            D3BFF5C3B0E1B3ACD9B0D0E5D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9D1EAD4B2DDB695D09A91CD96A3D6
            A7C6E3C9EBEFEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_EnviarClick
          ExplicitLeft = 679
          ExplicitTop = 0
        end
      end
      object ChBx_UsarCredito: TCheckBox
        Left = 685
        Top = 376
        Width = 77
        Height = 14
        Anchors = [akRight, akBottom]
        Caption = 'Usar Cr'#233'dito'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object Pg_Observacao: TPageControl
        Left = 6
        Top = 356
        Width = 667
        Height = 142
        ActivePage = TabSheet6
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 3
        object tbs_obs: TTabSheet
          Caption = 'Observa'#231#245'es'
          object Pnl_Observacao: TPanel
            Left = 0
            Top = 0
            Width = 659
            Height = 114
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object E_Observ: TMemo
              Left = 2
              Top = 2
              Width = 655
              Height = 110
              Align = alClient
              TabOrder = 0
            end
          end
        end
        object tbs_dado_entrega: TTabSheet
          Caption = 'Dados de Entrega'
          ImageIndex = 1
          object Pnl_entrega: TPanel
            Left = 0
            Top = 0
            Width = 659
            Height = 114
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label20: TLabel
              Left = 4
              Top = 2
              Width = 101
              Height = 14
              Caption = 'Endere'#231'o de Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label27: TLabel
              Left = 424
              Top = 37
              Width = 91
              Height = 14
              AutoSize = False
              Caption = 'Prazo de Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label7: TLabel
              Left = 4
              Top = 36
              Width = 101
              Height = 14
              AutoSize = False
              Caption = 'Retirada Mercadoria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label14: TLabel
              Left = 6
              Top = 72
              Width = 101
              Height = 14
              AutoSize = False
              Caption = 'Sobre a Garantia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object DBLCB_End_Entrega: TDBLookupComboBox
              Left = 4
              Top = 16
              Width = 511
              Height = 21
              KeyField = 'END_CODIGO'
              ListField = 'END_COMPLETO'
              ListSource = Ds_Endereco
              TabOrder = 0
            end
            object Cb_Retirada: TComboBox
              Left = 4
              Top = 50
              Width = 413
              Height = 21
              TabOrder = 1
              Items.Strings = (
                '01 - Retira total'
                '02 - Retira parcial - Saldo Entregaremos _____ dias '#250'teis'
                '03 - Retira parcial - Saldo Retira _____ dias '#250'teis'
                '04 - Retira parcial - Saldo transportadora ____ dias '#250'teis'
                '05 - Retira parcial - Saldo correios _____ dias '#250'teis'
                '06 - Entregamos em _____ dias '#250'teis'
                '07 - Retira em _____ dias '#250'teis'
                '08 - Colocar na entrega conforme programa'#231#227'o'
                '09 - Correios _____ dias '#250'teis'
                '10 - Transportadora _____ dias '#250'teis'
                '11 - Motoboy')
            end
            object Cb_Garantia: TComboBox
              Left = 4
              Top = 87
              Width = 413
              Height = 21
              TabOrder = 2
              Items.Strings = (
                '01 - Produto usado ou semi-novo sem garantia'
                '02 - Produto sem garantia'
                '03 - Garantia 3 meses'
                '04 - Garantia 6 meses'
                '05 - Garantia 9 meses'
                '06 - Garantia 12 meses'
                '07 - Garantia 18 meses')
            end
            object E_Data_Entrega: TDateTimePicker
              Left = 423
              Top = 53
              Width = 90
              Height = 21
              Date = 39580.000000000000000000
              Time = 39580.000000000000000000
              TabOrder = 3
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'Outras Informa'#231#245'es'
          ImageIndex = 2
          object Pnl_Informacoes: TPanel
            Left = 0
            Top = 0
            Width = 659
            Height = 114
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Sb_Negocio: TSpeedButton
              Left = 493
              Top = 17
              Width = 23
              Height = 22
              Caption = '...'
              OnClick = Sb_NegocioClick
            end
            object Label13: TLabel
              Left = 5
              Top = 3
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
            object SpeedButton1: TSpeedButton
              Left = 5
              Top = 84
              Width = 133
              Height = 25
              Caption = 'Informe Origem da Venda'
              OnClick = SpeedButton1Click
            end
            object SpeedButton2: TSpeedButton
              Left = 137
              Top = 84
              Width = 133
              Height = 25
              Caption = 'Informe Origem do Cliente'
              OnClick = SpeedButton2Click
            end
            object Label29: TLabel
              Left = 6
              Top = 40
              Width = 448
              Height = 14
              Caption = 
                'Indicador de presen'#231'a do comprador no estabelecimento comercial ' +
                'no momento da opera'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Dblcb_Negocio: TDBLookupComboBox
              Left = 3
              Top = 18
              Width = 484
              Height = 21
              KeyField = 'NEG_CODIGO'
              ListField = 'NEG_DESCRICAO'
              ListSource = DM.Ds_Negocio
              TabOrder = 0
            end
            object Cb_IndPresComprador: TComboBox
              Left = 6
              Top = 56
              Width = 480
              Height = 21
              Style = csDropDownList
              TabOrder = 1
              Items.Strings = (
                'Opera'#231#227'o presencial.'
                'Opera'#231#227'o n'#227'o presencial, pela Internet.'
                'Opera'#231#227'o n'#227'o presencial, Teleatendimento.'
                'NFC-e em opera'#231#227'o com entrega a domic'#237'lio.'
                'Opera'#231#227'o presencial, fora do estabelecimento.'
                'Opera'#231#227'o n'#227'o presencial, outros.')
            end
            object chbx_aprovados: TCheckBox
              Left = 279
              Top = 89
              Width = 67
              Height = 17
              Caption = 'Aprovado'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object ChBx_Pecas: TCheckBox
              Left = 351
              Top = 89
              Width = 64
              Height = 17
              Caption = 'S/ Pe'#231'as'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object ChBx_Status: TCheckBox
              Left = 417
              Top = 90
              Width = 64
              Height = 17
              Caption = 'Rejeitado'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
          end
        end
      end
      object PG_Itens: TPageControl
        Left = 3
        Top = 76
        Width = 841
        Height = 233
        ActivePage = Tbs_Servico
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiLine = True
        TabOrder = 4
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
            Top = 165
            Width = 833
            Height = 40
            Align = alBottom
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Sb_Ins_Produto: TBitBtn
              AlignWithMargins = True
              Left = 300
              Top = 3
              Width = 131
              Height = 34
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Caption = 'Novo Produto - F2'
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
              OnClick = Sb_Ins_ProdutoClick
            end
            object Sb_Alt_Produto: TBitBtn
              AlignWithMargins = True
              Left = 433
              Top = 3
              Width = 131
              Height = 34
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Caption = 'Alterar Produto - F3'
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
              TabOrder = 1
              OnClick = Sb_Alt_ProdutoClick
            end
            object Sb_Exc_Produto: TBitBtn
              AlignWithMargins = True
              Left = 566
              Top = 3
              Width = 131
              Height = 34
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Caption = 'Excluir Produto - F4'
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
              TabOrder = 2
              OnClick = Sb_Exc_ProdutoClick
            end
            object Sb_Vend_Comissao: TBitBtn
              AlignWithMargins = True
              Left = 699
              Top = 3
              Width = 131
              Height = 34
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Caption = 'Vendedores - F9'
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
              TabOrder = 3
              OnClick = Sb_Vend_ComissaoClick
            end
            object Sb_InclusaoRapido: TBitBtn
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 131
              Height = 34
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alLeft
              Caption = 'Incus'#227'o R'#225'pida'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Glyph.Data = {
                06030000424D06030000000000003600000028000000100000000F0000000100
                180000000000D0020000C30E0000C30E00000000000000000000F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0FCF9F6F4F4
                F5F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0FBF9F57A9AEBF8F8F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F5F5F595ADEEE2E7F4F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0EFEFEFD3DEF22C69E9FAF9F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EFEFEFF6F5F51569E9DDE5F3EFEFEFF0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EFEFEFFF
                FCF62688EC2E88EBFCF9F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0FFFBF648A7EF1A8DEDD5E5F4EFEFEFF0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F7F4F37FCAF216
                9EF02DA2EFFFFEF6FAF6F3F3F3F3F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F3F2F2B8E4F40CAAF116A9F021A8F14DB5F182C7F2E0ECF5F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0E6F2F500B8F505B6F50B
                B3F315AFF117ABF10DA2F1F4F5F5F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F8F5F5F5F6F5C4EAF569D2F40EB9F511B5F435BAF1F7F5F4F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EFEFF0FEF7F60F
                C7F50EC4F50BBFF5CDEBF5F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F1F1F182E4F60ED2FA0ECDF809C8F6FFF8F6F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F3F5F618D8F822
                DAF822D9FA80E3F7F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F7F6F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0}
              ParentFont = False
              TabOrder = 4
              OnClick = Sb_InclusaoRapidoClick
            end
          end
          object DBG_Produtos: TDBGrid
            Left = 0
            Top = 0
            Width = 833
            Height = 165
            Align = alClient
            Color = clMoneyGreen
            DataSource = Ds_ItensVda
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Lucida Console'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick, dgTitleHotTrack]
            ParentFont = False
            PopupMenu = Pop_Produto
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clNavy
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            OnDblClick = DBG_ProdutosDblClick
            OnKeyDown = DBG_ProdutosKeyDown
            OnTitleClick = DBG_ProdutosTitleClick
            Columns = <
              item
                Expanded = False
                FieldName = 'ITF_SEQUENCIA'
                Title.Caption = 'Sequencia'
                Visible = True
              end
              item
                ButtonStyle = cbsNone
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'Codigo F'#225'brica'
                Width = 94
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o Produto'
                Width = 234
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MED_ABREVIATURA'
                Title.Caption = 'Unidade'
                Width = 55
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'ITF_QTDE'
                Title.Alignment = taCenter
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
                FieldName = 'ITF_VL_DESC'
                Title.Alignment = taCenter
                Title.Caption = 'Desconto'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_SUBTOTAL'
                Title.Caption = 'SubTotal'
                Width = 67
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_TOTAL'
                Title.Caption = 'Total'
                Width = 85
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
                FieldName = 'ITF_VL_IPI'
                Title.Caption = 'Valor IPI'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TPR_NOME'
                Title.Caption = 'Tabela de Pre'#231'o'
                Width = 350
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CFOP'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SET_FINANCIAL'
                Title.Caption = 'Financeiro'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_LOCAL'
                Title.Caption = 'Localiza'#231#227'o no Estoque'
                Width = 300
                Visible = True
              end>
          end
        end
        object Tbs_Servico: TTabSheet
          Caption = 'Servi'#231'os'
          ImageIndex = 1
          OnShow = Tbs_ServicoShow
          object Pnl_Servico: TPanel
            Left = 0
            Top = 0
            Width = 833
            Height = 205
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Sb_Ins_Servico: TSpeedButton
              AlignWithMargins = True
              Left = 237
              Top = 163
              Width = 117
              Height = 37
              Margins.Left = 1
              Margins.Right = 1
              Align = alRight
              Caption = 'Novo Servi'#231'o - F2'
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
              OnClick = Sb_Ins_ServicoClick
              ExplicitLeft = 243
              ExplicitTop = 170
              ExplicitHeight = 32
            end
            object Sb_Alt_Servico: TSpeedButton
              AlignWithMargins = True
              Left = 356
              Top = 163
              Width = 123
              Height = 37
              Margins.Left = 1
              Margins.Right = 1
              Align = alRight
              Caption = 'Alterar Servi'#231'o - F3'
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
              OnClick = Sb_Alt_ServicoClick
              ExplicitLeft = 222
              ExplicitTop = 169
              ExplicitHeight = 32
            end
            object Sb_Exc_Servico: TSpeedButton
              AlignWithMargins = True
              Left = 481
              Top = 163
              Width = 120
              Height = 37
              Margins.Left = 1
              Margins.Right = 1
              Align = alRight
              Caption = 'Excluir Servi'#231'o - F4'
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
              OnClick = Sb_Exc_ServicoClick
              ExplicitLeft = 345
              ExplicitTop = 169
              ExplicitHeight = 32
            end
            object Sb_Servico: TSpeedButton
              AlignWithMargins = True
              Left = 603
              Top = 163
              Width = 127
              Height = 37
              Margins.Left = 1
              Margins.Right = 1
              Align = alRight
              Caption = 'Detalhe Servi'#231'o - F8'
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
              ExplicitLeft = 465
              ExplicitTop = 169
              ExplicitHeight = 32
            end
            object Sb_Tecnico: TSpeedButton
              AlignWithMargins = True
              Left = 732
              Top = 163
              Width = 96
              Height = 37
              Margins.Left = 1
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
              ExplicitLeft = 592
              ExplicitTop = 169
              ExplicitHeight = 32
            end
            object DBG_Servicos: TDBGrid
              Left = 2
              Top = 2
              Width = 829
              Height = 158
              Align = alTop
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_ItensSrv
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
              OnDblClick = DBG_ServicosDblClick
              OnKeyDown = DBG_ServicosKeyDown
              Columns = <
                item
                  Expanded = False
                  Visible = False
                end
                item
                  Expanded = False
                  FieldName = 'ITF_CODPRO'
                  Title.Caption = 'Codigo Servi'#231'o'
                  Width = 87
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
                  Width = 77
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ITF_VL_DESC'
                  Title.Caption = 'Desconto'
                  Width = 72
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
        end
        object Tbs_Devolucao: TTabSheet
          Caption = 'Devolu'#231#227'o'
          ImageIndex = 3
          OnShow = Tbs_DevolucaoShow
          DesignSize = (
            833
            205)
          object DBG_Devolucao: TDBGrid
            Left = 0
            Top = 0
            Width = 833
            Height = 165
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_ItensDev
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
            OnDblClick = DBG_ProdutosDblClick
            OnKeyDown = DBG_DevolucaoKeyDown
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                ButtonStyle = cbsNone
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'Codigo F'#225'brica'
                Width = 83
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
                Width = 88
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_SUBTOTAL'
                Title.Caption = 'SubTotal'
                Width = 92
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_ALIQ_COM'
                Title.Caption = 'Aliq Com'
                Width = 49
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
                FieldName = 'ITF_VL_DESC'
                Title.Caption = 'Desconto'
                Width = 85
                Visible = True
              end>
          end
          object Sb_Ins_Devolucao: TBitBtn
            Left = 431
            Top = 170
            Width = 131
            Height = 32
            Anchors = [akRight, akBottom]
            Caption = 'Novo Produto - F2'
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
            OnClick = Sb_Ins_DevolucaoClick
          end
          object Sb_Alt_Devolucao: TBitBtn
            Left = 564
            Top = 170
            Width = 131
            Height = 32
            Anchors = [akRight, akBottom]
            Caption = 'Alterar Produto - F3'
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
            TabOrder = 2
            OnClick = Sb_Alt_DevolucaoClick
          end
          object Sb_Exc_Devolucao: TBitBtn
            Left = 697
            Top = 170
            Width = 131
            Height = 32
            Anchors = [akRight, akBottom]
            Caption = 'Excluir Produto - F4'
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
            TabOrder = 3
            OnClick = Sb_Exc_DevolucaoClick
          end
        end
        object Tbs_Troca: TTabSheet
          Caption = 'Troca'
          ImageIndex = 3
          OnShow = Tbs_TrocaShow
          DesignSize = (
            833
            205)
          object DBG_Troca: TDBGrid
            Left = 0
            Top = 0
            Width = 833
            Height = 165
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_ItensTro
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Lucida Console'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect]
            ParentFont = False
            PopupMenu = pop_troca
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
                ButtonStyle = cbsNone
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'Codigo F'#225'brica'
                Width = 105
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
                Width = 76
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
                FieldName = 'ITF_ALIQ_COM'
                Title.Caption = 'Aliq Com'
                Width = 49
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
                FieldName = 'ITF_VL_DESC'
                Title.Caption = 'Desconto'
                Width = 85
                Visible = True
              end>
          end
          object Sb_Ins_Troca: TBitBtn
            Left = 433
            Top = 170
            Width = 131
            Height = 32
            Anchors = [akRight, akBottom]
            Caption = 'Novo Produto - F2'
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
            OnClick = Sb_Ins_TrocaClick
          end
          object Sb_Alt_Troca: TBitBtn
            Left = 568
            Top = 170
            Width = 131
            Height = 32
            Anchors = [akRight, akBottom]
            Caption = 'Alterar Produto - F3'
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
            TabOrder = 2
            OnClick = Sb_Alt_TrocaClick
          end
          object Sb_Exc_Troca: TBitBtn
            Left = 699
            Top = 170
            Width = 131
            Height = 32
            Anchors = [akRight, akBottom]
            Caption = 'Excluir Produto - F4'
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
            TabOrder = 3
            OnClick = Sb_Exc_TrocaClick
          end
        end
      end
    end
    object tbs_Pesquisa: TTabSheet
      Caption = 'tbs_Pesquisa'
      ImageIndex = 1
      OnShow = tbs_PesquisaShow
      object Pnl_Busca: TGroupBox
        Left = 0
        Top = 149
        Width = 852
        Height = 421
        Align = alClient
        Caption = 'Resultados da Pesquisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object DBG_Pesquisa: TDBGrid
          Left = 2
          Top = 15
          Width = 747
          Height = 404
          Align = alLeft
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          DataSource = Ds_Pesquisa
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick]
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
        end
        object Panel4: TPanel
          Left = 744
          Top = 15
          Width = 106
          Height = 404
          Align = alRight
          TabOrder = 1
          object Sb_Sair_1: TSpeedButton
            AlignWithMargins = True
            Left = 4
            Top = 346
            Width = 98
            Height = 54
            Align = alBottom
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
            ExplicitLeft = 612
            ExplicitTop = 370
            ExplicitWidth = 92
          end
          object SB_Visualizar: TSpeedButton
            AlignWithMargins = True
            Left = 4
            Top = 286
            Width = 98
            Height = 54
            Align = alBottom
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
            ExplicitLeft = 755
            ExplicitTop = 314
            ExplicitWidth = 92
          end
          object SB_Buscar: TSpeedButton
            AlignWithMargins = True
            Left = 4
            Top = 226
            Width = 98
            Height = 54
            Align = alBottom
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
            ExplicitLeft = 11
          end
          object SB_Cadastrar: TSpeedButton
            AlignWithMargins = True
            Left = 4
            Top = 166
            Width = 98
            Height = 54
            Align = alBottom
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
            ExplicitLeft = 612
            ExplicitTop = 208
            ExplicitWidth = 92
          end
          object Lb_TotalVenda: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 98
            Height = 14
            Align = alTop
            Caption = 'Valor Total Pedidos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 91
          end
          object E_TotalVenda: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 24
            Width = 98
            Height = 17
            Align = alTop
            Alignment = taRightJustify
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 74
            ExplicitWidth = 28
          end
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 57
        Width = 852
        Height = 92
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          852
          92)
        object Label36: TLabel
          Left = 7
          Top = 13
          Width = 60
          Height = 13
          Anchors = [akLeft, akBottom]
          AutoSize = False
          Caption = 'Pedido'
          FocusControl = E_BuscaPedido
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitTop = 12
        end
        object Lb_Placa: TLabel
          Left = 87
          Top = 13
          Width = 60
          Height = 13
          Anchors = [akLeft, akBottom]
          AutoSize = False
          Caption = 'Placa'
          FocusControl = E_BuscaPedido
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitTop = 12
        end
        object L_CodigoCliente: TLabel
          Left = 323
          Top = 13
          Width = 68
          Height = 14
          Caption = 'C'#243'digo Cliente'
        end
        object E_BuscaCliente: TEdit
          Left = 402
          Top = 29
          Width = 383
          Height = 22
          Anchors = [akLeft, akBottom]
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 5
        end
        object E_BuscaPedido: TEdit_Setes
          Left = 5
          Top = 29
          Width = 79
          Height = 22
          Anchors = [akLeft, akBottom]
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
          IsCodigo = True
        end
        object E_Data_Ini: TDateTimePicker
          Left = 159
          Top = 29
          Width = 79
          Height = 22
          Anchors = [akLeft, akBottom]
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 2
        end
        object E_Data_Fim: TDateTimePicker
          Left = 239
          Top = 29
          Width = 82
          Height = 22
          Anchors = [akLeft, akBottom]
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 3
        end
        object ChBx_Busca_Nome: TCheckBox
          Left = 403
          Top = 13
          Width = 121
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 6
          OnClick = ChBx_Busca_NomeClick
        end
        object ChBx_Busca_Fantasia: TCheckBox
          Left = 519
          Top = 13
          Width = 120
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Apelido/Fantasia'
          TabOrder = 7
          OnClick = ChBx_Busca_FantasiaClick
        end
        object ChBx_Periodo: TCheckBox
          Left = 161
          Top = 13
          Width = 128
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Data Inicial    Data Final'
          TabOrder = 8
          OnClick = ChBx_PeriodoClick
        end
        object E_BuscaNumero: TEdit
          Left = 85
          Top = 29
          Width = 71
          Height = 22
          Anchors = [akLeft, akBottom]
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
        end
        object ChBx_BuscaPedidoAndroid: TCheckBox
          Left = 324
          Top = 56
          Width = 374
          Height = 17
          Caption = 'Baixar pedidos efetuados na internet ou dispositivo Android'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object E_Cd_Busca_Empresa: TEdit
          Left = 323
          Top = 29
          Width = 77
          Height = 22
          TabOrder = 4
        end
        inline Fm_ListaVendedores: TFm_ListaColaboradores
          Left = 7
          Top = 50
          Width = 315
          Height = 36
          TabOrder = 10
          ExplicitLeft = 7
          ExplicitTop = 50
          ExplicitWidth = 315
          ExplicitHeight = 36
          inherited Label19: TLabel
            Width = 315
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 289
            Height = 19
            ExplicitLeft = 285
            ExplicitHeight = 17
          end
          inherited Dblcb_Vendedor: TDBLookupComboBox
            Width = 283
            ExplicitWidth = 283
          end
        end
      end
      inline Fm_LME: TFm_ListaMultiEmpresa
        Left = 0
        Top = 0
        Width = 852
        Height = 57
        Align = alTop
        TabOrder = 2
        ExplicitWidth = 852
        ExplicitHeight = 57
        inherited pnl_linha_1: TPanel
          Width = 852
          ExplicitWidth = 852
          inherited Sb_open: TSpeedButton
            Left = 828
            ExplicitLeft = 828
          end
          inherited Dblcb_Lista: TDBLookupComboBox
            Width = 828
            ExplicitWidth = 828
          end
        end
        inherited pnl_top: TPanel
          Width = 852
          ExplicitWidth = 852
          inherited L_name_list: TLabel
            Width = 829
            Height = 16
          end
        end
      end
    end
    object tbs_Config_Global: TTabSheet
      Caption = 'Configura'#231#245'es Globais'
      ImageIndex = 2
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 852
        Height = 570
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          852
          570)
        object Label15: TLabel
          Left = 2
          Top = 2
          Width = 848
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'Configura'#231#245'es Globais'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 183
        end
        object chbx_Ctrl_Tabela_Prazo: TCheckBox
          Left = 2
          Top = 98
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Controlar o uso das Tabelas de Pre'#231'o em rela'#231#227'o ao prazo e '#225' Vis' +
            'ta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object Chbx_controle_venda: TCheckBox
          Left = 2
          Top = 132
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Controlar a seq'#252#234'ncia do n'#250'mero de pedido de venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ChBx_Libera_Comissao: TCheckBox
          Left = 2
          Top = 149
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Liberar o aliquota de comiss'#227'o para digita'#231#227'o na inclus'#227'o do ite' +
            'm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ChBx_Libera_Valor: TCheckBox
          Left = 2
          Top = 166
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Liberar o campo Valor Unit'#225'rio de Venda mesmo para Usu'#225'rio n'#227'o a' +
            'dministrador'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object chk_contr_vendedor: TCheckBox
          Left = 2
          Top = 115
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Controlar a edi'#231#227'o do Vendedor ap'#243's a gera'#231#227'o do N'#250'mero do Pedid' +
            'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Chbx_Qtde_Venda_Promocao: TCheckBox
          Left = 2
          Top = 183
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Controlar a venda de produtos em promo'#231#227'o pela Quantidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object chbx_M2: TCheckBox
          Left = 2
          Top = 200
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Utilizar Calculo de Metros Quadrado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object chbx_mostra_vendedor: TCheckBox
          Left = 2
          Top = 217
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Mostrar Vendedor no Pedido de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object ChBx_LancaLoteAuto: TCheckBox
          Left = 2
          Top = 234
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Lan'#231'amento de lote autom'#225'tico conforme vencimento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object ChBx_Ctrl_Estoque_Pedido: TCheckBox
          Left = 2
          Top = 251
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Controlar o estoque pelo Lan'#231'amento do Item no Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object Btn_Ok_Global: TButton
          Left = 613
          Top = 538
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 10
          OnClick = Btn_Ok_GlobalClick
        end
        object Btn_Cn_Global: TButton
          Left = 692
          Top = 538
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 11
          OnClick = Btn_Cn_GlobalClick
        end
        object Btn_Ap_Global: TButton
          Left = 767
          Top = 538
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 12
          OnClick = Btn_Ap_GlobalClick
        end
        object chbx_copiapedidovenda: TCheckBox
          Left = 2
          Top = 268
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Ativar a op'#231#227'o de c'#243'pia de pedido de venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object Chbx_Emite_Boleto: TCheckBox
          Left = 2
          Top = 285
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Ativar emiss'#227'o de boleto no faturamento quando esta for a forma ' +
            'de pagamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object ChBx_BaixaAutomaticaPedido: TCheckBox
          Left = 2
          Top = 302
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Ativa a baixa de pedidos efetuados na internet ou dispositivo An' +
            'droid'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object ChBx_ComissaoProduto: TCheckBox
          Left = 2
          Top = 319
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Tornar obrigat'#243'rio o prenchimento da al'#237'quota de comiss'#227'o no pro' +
            'duto para os casos em que '#233' pago comiss'#227'o por produto ao vendedo' +
            'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object ChBx_Ctrl_Preco_Tipo_Cliente: TCheckBox
          Left = 2
          Top = 336
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Controlar Tabela de Pre'#231'o por Consumidor e Revenda [ Revenda pre' +
            'cisa ser Pessoa Juridica | Determina'#231#227'o do tipo na Tabela de pre' +
            #231'o]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object ChBx_preco_acima: TCheckBox
          Left = 2
          Top = 353
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Permitir a altera'#231#227'o do pre'#231'o de venda de tabela apenas para val' +
            'ores superiores (Exceto Administrador)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object pnl_cfg_g_top: TPanel
          Left = 2
          Top = 22
          Width = 848
          Height = 59
          Align = alTop
          TabOrder = 19
          object RG_TIPOPARCELAMENTO: TRadioGroup
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 160
            Height = 51
            Align = alLeft
            Caption = 'Tipo de Parcelamento:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Aberto'
              'Controlado')
            ParentFont = False
            TabOrder = 0
          end
          object GroupBox5: TGroupBox
            AlignWithMargins = True
            Left = 170
            Top = 4
            Width = 160
            Height = 51
            Align = alLeft
            Caption = 'Desconto M'#225'ximo no Pedido'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            object Label25: TLabel
              Left = 81
              Top = 27
              Width = 8
              Height = 13
              Caption = '%'
            end
            object E_Aliq_Desconto: TEdit_Setes
              Left = 9
              Top = 20
              Width = 67
              Height = 21
              TabOrder = 0
              Text = ''
            end
          end
          object grp_desc_vista: TGroupBox
            AlignWithMargins = True
            Left = 336
            Top = 4
            Width = 160
            Height = 51
            Align = alLeft
            Caption = 'Desconto Pagamento '#225' Vista'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            object Label28: TLabel
              Left = 81
              Top = 24
              Width = 8
              Height = 13
              Caption = '%'
            end
            object ed_desc_avista: TEdit_Setes
              Left = 9
              Top = 18
              Width = 67
              Height = 21
              TabOrder = 0
              Text = ''
            end
          end
          object GroupBox4: TGroupBox
            AlignWithMargins = True
            Left = 502
            Top = 4
            Width = 160
            Height = 51
            Align = alLeft
            Caption = 'Validar Lucratividade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            object Label30: TLabel
              Left = 81
              Top = 24
              Width = 8
              Height = 13
              Caption = '%'
            end
            object e_Valida_Lucratividade: TEdit_Setes
              Left = 9
              Top = 18
              Width = 67
              Height = 21
              TabOrder = 0
              Text = ''
            end
          end
        end
        object chk_contr_cliente: TCheckBox
          Left = 2
          Top = 81
          Width = 848
          Height = 17
          Align = alTop
          Caption = 'Controlar a edi'#231#227'o do cliente no pedido de venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
        end
        object chbx_nao_mostra_valor_usuario: TCheckBox
          Left = 2
          Top = 370
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'N'#227'o mostrar valores na tela de consulta para usu'#225'rios n'#227'o Admini' +
            'stradores'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
        end
        object chbx_somente_vendedor_visualiza: TCheckBox
          Left = 2
          Top = 387
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Controlar a visualiza'#231#227'o completa do pedido apenas pelo pr'#243'prio ' +
            'vendedor ou Administrador'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
        end
        object Chbx_Vendedor_Cliente: TCheckBox
          Left = 2
          Top = 404
          Width = 848
          Height = 17
          Align = alTop
          Caption = 
            'Preencher o campo vendedor com o Vendedor que esta no cadastro d' +
            'o cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 23
        end
      end
    end
    object tbs_Config_Local: TTabSheet
      Caption = 'Configura'#231#245'es Locais'
      ImageIndex = 3
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 852
        Height = 570
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          852
          570)
        object Label16: TLabel
          Left = 2
          Top = 2
          Width = 848
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'Configura'#231#245'es Locais'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 174
        end
        object Label17: TLabel
          Left = 5
          Top = 72
          Width = 185
          Height = 14
          Caption = 'Modelos de Impress'#227'o - Estilo Matricial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 5
          Top = 107
          Width = 203
          Height = 14
          Caption = 'Modelos de Impress'#227'o - Estilo Laser / Jato'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object GrBx_Ped_Imp: TRadioGroup
          Left = 4
          Top = 24
          Width = 264
          Height = 46
          Caption = 'Imprimir Pedido em Impressora'
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Matricial'
            'Jato / Laser'
            'Ambos')
          ParentFont = False
          TabOrder = 0
        end
        object GroupBox10: TGroupBox
          Left = 474
          Top = 80
          Width = 87
          Height = 60
          Caption = 'Itens por Folha'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object E_ItensPP: TEdit_Setes
            Left = 10
            Top = 19
            Width = 74
            Height = 21
            TabOrder = 0
            Text = ''
          end
        end
        object GroupBox6: TGroupBox
          Left = 261
          Top = 24
          Width = 300
          Height = 46
          Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object E_PortaImpressao_vda: TEdit
            Left = 7
            Top = 19
            Width = 227
            Height = 21
            TabOrder = 0
          end
          object E_SaltoImpressao_vda: TEdit_Setes
            Left = 237
            Top = 19
            Width = 52
            Height = 21
            TabOrder = 1
            Text = ''
          end
        end
        object Cbx_TipoComp: TComboBox
          Left = 5
          Top = 86
          Width = 463
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = 'MODELO 1  - NORMAL'
          Items.Strings = (
            'MODELO 1  - NORMAL'
            'MODELO 2  - CLARA LUA'
            'MODELO 3  - DENTAL'
            'MODELO 4  - COMPRIMIDO'
            'MODELO 5  - GENIO'
            'MODELO 6  - GENIO - 2'
            'MODELO 6  - MAC BATERIAS')
        end
        object cbx_estliloLase: TComboBox
          Left = 3
          Top = 127
          Width = 465
          Height = 21
          Style = csDropDownList
          TabOrder = 4
          Items.Strings = (
            'MODELO 1  - Nornal'
            'MODELO 2  - Extforma'
            'MODELO 3  - Extimplas'
            'MODELO 4 - G'#234'nio Ferramentas'
            'MODELO 5 - S'#227'o Luiz Extintores'
            'MODELO 6 - G'#234'nio Ferramentas - 2'
            'MODELO 7 - Choconix'
            'MODELO 8 - Face a Face'
            'MODELO 9 - YU-MI'
            'MODELO 10 - EXTERMINACHAMA'
            'MODELO 11 - Brasil Sacolas/Gr'#225'ficaImperial (Com Valores)'
            'MODELO 12 - Mac Baterias'
            'MODELO 13 - Brasil Sacolas/Gr'#225'ficaImperial (Sem Valores)')
        end
        object Btn_Ok_Local: TButton
          Left = 614
          Top = 539
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 5
          OnClick = Btn_Ok_LocalClick
        end
        object Btn_Cn_Local: TButton
          Left = 693
          Top = 539
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 6
          OnClick = Btn_Cn_LocalClick
        end
        object Btn_Ap_Local: TButton
          Left = 768
          Top = 539
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 7
          OnClick = Btn_Ap_LocalClick
        end
      end
    end
    object tbs_oper_Grupo: TTabSheet
      Caption = 'Opera'#231#227'o Grupo'
      ImageIndex = 4
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 852
        Height = 570
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Caption = 'Panel3'
        TabOrder = 0
        DesignSize = (
          852
          570)
        object Lb_DetalhePedido: TLabel
          Left = 2
          Top = 2
          Width = 848
          Height = 19
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'OPERA'#199#213'ES EM GRUPO'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 706
        end
        object Sb_VoltaGrupo: TSpeedButton
          Left = 770
          Top = 510
          Width = 75
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Voltar - ESC'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_VoltaGrupoClick
          ExplicitLeft = 628
        end
        object Sb_Grp_Atualizar: TSpeedButton
          Left = 695
          Top = 510
          Width = 75
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Atualizar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEBEBAFBB
            B7789890548779457E6E447D6E5182756D8C8398A4A0C7C8C8E5E5E5EDEDEDF4
            F4F4FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4ECEA7A9F96217E66057B
            5C047B5C047A5B047A5B047A5B047B5B047C5C05795A1D765F67887FC6C7C7F3
            F3F3F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1CABF208C70088464088061097E
            60097E60087E5F087D5F077D5E077D5F087E60097E6008826209866528836CAA
            B7B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFF9FCFB72B4A20C88680E88680F88690E87680F87
            68118869138A6B158D6E188E70188B6E0F85660883630D87670F88690F8C6C0F
            8B6B8CB4AAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFCFDFD6EB7A4129372169373169373129070199475159A
            78129D782CAE8C43BE9E49C6A641C7A849C4A847B1971B94750F8F6E16937316
            937316987793CABCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF90C9BA1B9E7D1E9E7E1D9E7D1C9C7B3FB29653C8AB8CD7
            C3D0EDE5F2FAF7FBFEFDFAFDFCF1FAF8D9F6EFC4F5EBA2E4D643B095199B7A1E
            9E7E1E9E7E1B9E7DB5D9D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFD0E8E226AA8926AA8926AA8825A88756C4A9B9EFE2F0FAF8FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FDFAB0F0E242BDA025
            A88627AA8926AA8937AE90E8F3F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFDFEFE66C4AC2DB69430B5932FB59336BC9BC3EEE3FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFE94E8D533
            BC9B2FB59230B6942DB6938AD0BEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFD4EEE738C19E39C19F3AC29F34BF9C8ED7C4FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFE73
            D6BE38C29F39C19F38C19F43C3A3EEF8F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF96DECC3FCCA942CCA845CFAC48C09FF7FCFAFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
            F9F749CBAA42CDA942CCA940CCA8ADE4D6E7F7F3F4FBF9FFFFFFFFFFFFFFFFFF
            FCFEFD6EDDC14AD8B54CD8B54AD6B29FD9C8FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF7F390
            E1CC56D6B64AD6B34AD6B34AD6B34ED7B54CD4B1B6E2D5FFFFFFFFFFFFFFFFFF
            F3FCFA52D7B64DDAB754E0BD4ED4B2E7F5F1FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDF7F448
            C7A756E4C152DFBC52E0BC52DFBC57E4C148C8A5EEF8F5FFFFFFFFFFFFFFFFFF
            F9FDFC70C7AF53BC9E43B8976DC7AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBE
            E3D950D9B75CECC85AE8C45BE9C659E6C393D5C2FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFDCDCD1E6EAE4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF82CFBB62EFCB62F1CD67F6D250D2AFEFF8F5FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFEFEFEA26534AC7A51FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFEEF8F562D4B76CFCD867F6D28CD4BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFDFD1C4924C07924C07D6C3B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFBDE6DB6DF3D257DDB9E9F6F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB386569B560C9B560DA36728F4EFEBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF86DFCA7DD4BEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            E7DCCFA56216A56215A56216A66113C0996EFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFF2ECE5E1E8DEE4ECE4FBF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            C39B69AF6D1CAE6D1EAE6D1EAE6D1EAE6D1DDECDB9FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFF9F6F2B67B37B77328BA7A35C08B51FBF8F5FFFFFFFFFFFFFFFFFFEBE1D4
            BA7C2DB97B2BB87A29B87A29B87929BD7C2AC5904BFCFBF9FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFEADECFB97A28B97A28B97A28C48A44FEFCFAFFFFFFFFFFFFFFFFFFEFDECC
            CD9252C78A41C28735C28634C38633CE9B59EED9C0FEFEFDFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFD3B285C38632C28634C38735D6A872FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFE4C39FCD9441CC9340CD933FCE9C52F8F4EEFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1
            E9DDCD9644CC933FCC9340CD9341E7CBADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFF7EEE4D2984AD6A14DD59F4BD69F4ADBB57AFDFBF9FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F5D9
            AF70D69F4AD59E4BD7A14ED29A4EF9F3ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFDDB384DEAB58DEAA56DEAA56DFAA54E5C38DFCF9F5FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7F0E3BF84DF
            AA54DEAA56DFAB56DDAA57E0BB91FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFF9F1E9D9A258E8B864E6B460E6B460E6B45FE8C07EF4E9D4FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDF4E6CFE7BE78E6B45FE6
            B460E6B561E9B965D69F5AFAF5EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFEDD9C1E0AC57EFC26FECBE6AECBE6AEDBE69ECBE69EECC
            91F3E0C1F8EEDDFAF3E8FAF3E8F8EDDCF2DFBDEDCA8CECBE69EDBE69ECBE6AED
            BE6AEFC36FDAA253EEDBC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFECD3B4E7B965F5C979F3C671F3C672F3C673F3C6
            72F3C671F3C672F2C674F2C674F3C672F3C671F3C672F3C673F3C672F3C671F4
            C875E0AB57E8CEB1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0DCBEEAC370F8D285F8CE7BF8CC77F8CE
            7AF8CE7BF8CE7BF8CE7BF8CE7BF8CE7BF8CE7BF8CE7BF9CF7BF9CF7DF8D388EA
            C47FEFDCC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0E1F2DCA8FAE3A9FCDE9BFCD6
            88FDD684FDD684FDD784FED785FED986FFDA87FDD785F7D07FF3D390F4E3C0FB
            F5ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF4EBF9F0D9F7E3
            AEF4D487F4CE7BF4CC7AF1C775EBBC6AE1AC59DBA65AE5C594F8EFE3FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFA
            F7F8EEDFF1DFC0ECD3AAE9CEA7EAD1B4F1E0CEFBF6F1FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Grp_AtualizarClick
          ExplicitLeft = 553
        end
        object SB_Add_Tudo: TSpeedButton
          Left = 4
          Top = 510
          Width = 109
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Marcar todos'
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
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          ParentFont = False
          OnClick = SB_Add_TudoClick
        end
        object SB_Retirar_Tudo: TSpeedButton
          Left = 115
          Top = 510
          Width = 107
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Desmarcar todos'
          Enabled = False
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
            333333333333333333333333333333333333333FFF33FF333FFF339993370733
            999333777FF37FF377733339993000399933333777F777F77733333399970799
            93333333777F7377733333333999399933333333377737773333333333990993
            3333333333737F73333333333331013333333333333777FF3333333333910193
            333333333337773FF3333333399000993333333337377737FF33333399900099
            93333333773777377FF333399930003999333337773777F777FF339993370733
            9993337773337333777333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          ParentFont = False
          OnClick = SB_Retirar_TudoClick
        end
        object StrGrd_Pedido: TStringGrid
          Left = 4
          Top = 24
          Width = 842
          Height = 484
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          ColCount = 8
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
          OnClick = StrGrd_PedidoClick
          OnDrawCell = StrGrd_PedidoDrawCell
          ColWidths = (
            40
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
        object GroupBox2: TGroupBox
          Left = 228
          Top = 509
          Width = 99
          Height = 41
          Caption = 'Alterar Data'
          TabOrder = 1
          object E_DataAlteraGRupo: TDateTimePicker
            Left = 5
            Top = 15
            Width = 87
            Height = 21
            Date = 39580.000000000000000000
            Time = 39580.000000000000000000
            TabOrder = 0
          end
        end
      end
    end
  end
  object Pnl_TabelaPreco: TPanel
    Left = 805
    Top = 408
    Width = 421
    Height = 97
    Anchors = []
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Visible = False
    DesignSize = (
      419
      95)
    object Sb_Confirma_TabelaPreco: TButton
      Left = 168
      Top = 62
      Width = 122
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = '&Confirma - F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Sb_Confirma_TabelaPrecoClick
    end
    object Sb_Cancela_TabelaPreco: TButton
      Left = 290
      Top = 62
      Width = 122
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Cance&la - ESC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Sb_Cancela_TabelaPrecoClick
    end
    inline Fm_ListaTabelaPreco: TFm_ListaTabelaPreco
      Left = 3
      Top = 3
      Width = 414
      Height = 56
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitWidth = 414
      ExplicitHeight = 56
      inherited Label53: TLabel
        Width = 414
        Height = 24
        Align = alTop
        Caption = 'Informe qual Tabela de Pre'#231'o Ser'#225' Utilizada'
        Color = clNavy
        Font.Color = clWhite
        Font.Height = -21
        ParentColor = False
        ExplicitWidth = 407
        ExplicitHeight = 24
      end
      inherited Sb_Preco: TSpeedButton
        Left = 405
        Top = 30
        Visible = False
        ExplicitLeft = 405
        ExplicitTop = 30
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Left = 2
        Top = 25
        Width = 411
        Height = 31
        Anchors = [akRight, akBottom]
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        ParentFont = False
        ExplicitLeft = 2
        ExplicitTop = 25
        ExplicitWidth = 411
        ExplicitHeight = 31
      end
      inherited Qr_Tabelas: TSTQuery
        Top = 27
      end
      inherited Ds_Tabelas: TDataSource
        Left = 179
        Top = 27
      end
    end
  end
  object Ds_ItensVda: TDataSource
    DataSet = Qr_ItensVda
    Left = 80
    Top = 224
  end
  object Qr_Pesquisa: TSTQuery
    AfterOpen = Qr_PesquisaAfterOpen
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    UpdateTransaction = DM.IBT_Consulta
    SQL.Strings = (
      'SELECT distinct PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA, '
      'PED_VL_PEDIDO, EMP_NOME, PED_CODMHA, PED_NUMWEB '
      'FROM TB_PEDIDO '
      '  INNER JOIN TB_EMPRESA tb_empresa '
      '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP ) '
      'WHERE (PED_FATURADO = '#39'N'#39') ')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 440
    Top = 128
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 440
    Top = 168
  end
  object Qr_Endereco: TSTQuery
    AfterOpen = Qr_EnderecoAfterOpen
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT tb_endereco.end_codigo,'
      
        'tb_endereco.end_ender || '#39', '#39'|| tb_endereco.end_numero || '#39'  '#39' |' +
        '| coalesce(tb_endereco.end_complem,'#39#39')  END_Completo,'
      'tb_endereco.end_cep'
      ', END_CODUFE'
      ''
      'FROM TB_ENDERECO'
      '         INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)'
      'ORDER BY END_PRINCIPAL DESC')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 547
    Top = 113
    ParamData = <
      item
        Name = 'EMP_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
  end
  object Ds_Endereco: TDataSource
    AutoEdit = False
    DataSet = Qr_Endereco
    Left = 515
    Top = 177
  end
  object Qr_ItensVda: TSTQuery
    AfterOpen = Qr_ItensVdaAfterOpen
    OnCalcFields = Qr_ItensVdaCalcFields
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
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
      '  PRO_LOCAL,'
      '  TPR_MODALIDADE,'
      '  EMB_ABREVIATURA,'
      '  TPR_NOME,'
      '  PRO_ORIGEM,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
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
      
        '  CAST((((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) * ITF_AQ_IPI) /' +
        ' 100 AS DOUBLE PRECISION) ITF_VL_IPI,'
      '  itb.cfop,'
      '  itb.set_financial'
      'FROM TB_ITENS_NFL it'
      '   INNER JOIN TB_PRODUTO pr'
      '   ON  (pr.PRO_CODIGO = it.ITF_CODPRO)'
      ''
      '   LEFT OUTER JOIN TB_TABELA_PRECO tpr'
      '  ON(tpr.TPR_CODIGO =  it.ITF_CODTPR)'
      ''
      '   INNER JOIN TB_MEDIDA md'
      '   ON  (md.MED_CODIGO = pr.PRO_CODMED)'
      '   left join tb_embalagem em'
      '     on em.emb_codigo = pr.pro_codemb'
      '   left join tb_itens_nfl_tributacao itb'
      '   on (itb.tb_order_itens_id = it.itf_codigo)'
      
        'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO <> '#39'S'#39') AND (ITF_O' +
        'PER = '#39'V'#39')'
      'ORDER BY PRO_DESCRICAO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 83
    Top = 168
    ParamData = <
      item
        Name = 'PED_CODIGO'
      end>
    object Qr_ItensVdaITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensVdaITF_SEQUENCIA: TIntegerField
      FieldName = 'ITF_SEQUENCIA'
      Origin = '"TB_ITENS_NFL"."ITF_SEQUENCIA"'
    end
    object Qr_ItensVdaITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensVdaITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
      Required = True
    end
    object Qr_ItensVdaITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensVdaPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensVdaPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = '"TB_PRODUTO"."PRO_CODIGONCM"'
      Size = 50
    end
    object Qr_ItensVdaPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensVdaPRO_SERIE: TStringField
      FieldName = 'PRO_SERIE'
      Origin = '"TB_PRODUTO"."PRO_SERIE"'
      Size = 1
    end
    object Qr_ItensVdaPRO_TIPO: TStringField
      FieldName = 'PRO_TIPO'
      Origin = '"TB_PRODUTO"."PRO_TIPO"'
      Size = 1
    end
    object Qr_ItensVdaTPR_MODALIDADE: TStringField
      FieldName = 'TPR_MODALIDADE'
      Origin = '"TB_TABELA_PRECO"."TPR_MODALIDADE"'
      Size = 1
    end
    object Qr_ItensVdaEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensVdaTPR_NOME: TStringField
      FieldName = 'TPR_NOME'
      Origin = '"TB_TABELA_PRECO"."TPR_NOME"'
      Size = 50
    end
    object Qr_ItensVdaPRO_ORIGEM: TStringField
      FieldName = 'PRO_ORIGEM'
      Origin = '"TB_PRODUTO"."PRO_ORIGEM"'
      Size = 1
    end
    object Qr_ItensVdaITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensVdaITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensVdaITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensVdaITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensVdaITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensVdaITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensVdaITF_ALTURA: TBCDField
      FieldName = 'ITF_ALTURA'
      Origin = '"TB_ITENS_NFL"."ITF_ALTURA"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_LARGURA: TBCDField
      FieldName = 'ITF_LARGURA'
      Origin = '"TB_ITENS_NFL"."ITF_LARGURA"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaITF_NR_PECAS: TBCDField
      FieldName = 'ITF_NR_PECAS'
      Origin = '"TB_ITENS_NFL"."ITF_NR_PECAS"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensVdaITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      Size = 1
    end
    object Qr_ItensVdaITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensVdaPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensVdaITF_VL_IPI: TFloatField
      FieldName = 'ITF_VL_IPI'
      ProviderFlags = []
    end
    object Qr_ItensVdaITF_VL_SUBTOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_SUBTOTAL'
      Calculated = True
    end
    object Qr_ItensVdaITF_VL_TOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_TOTAL'
      Calculated = True
    end
    object Qr_ItensVdaCFOP: TStringField
      FieldName = 'CFOP'
      Origin = '"TB_ITENS_NFL_TRIBUTACAO"."CFOP"'
      Size = 10
    end
    object Qr_ItensVdaSET_FINANCIAL: TStringField
      FieldName = 'SET_FINANCIAL'
      Origin = '"TB_ITENS_NFL_TRIBUTACAO"."SET_FINANCIAL"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensVdaTEMFINANCEIRO: TStringField
      FieldKind = fkCalculated
      FieldName = 'TEMFINANCEIRO'
      Calculated = True
    end
    object Qr_ItensVdaPRO_LOCAL: TStringField
      FieldName = 'PRO_LOCAL'
      Origin = '"TB_PRODUTO"."PRO_LOCAL"'
      Size = 100
    end
  end
  object Qr_ItensSrv: TSTQuery
    AfterOpen = Qr_ItensSrvAfterOpen
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
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
      '  ITF_VL_UNIT,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '   ITF_AQ_DESC,'
      '   ITF_VL_DESC,'
      
        '  CAST((ITF_QTDE * ITF_VL_UNIT) AS NUMERIC(18, 9)) ITF_VL_SUBTOT' +
        'AL,'
      
        '  CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) AS NUMERIC(18, 9' +
        ')) ITF_VL_TOTAL,'
      '   ITF_CODTPR'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      ' INNER JOIN tb_medida tb_medida'
      '   ON  (tb_medida.med_codigo = tb_produto.pro_codmed)'
      '   left join tb_embalagem tb_embalagem'
      '     on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      
        'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = '#39'S'#39') AND (ITF_OP' +
        'ER = '#39'V'#39')'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 25
    Top = 160
    ParamData = <
      item
        Name = 'PED_CODIGO'
        DataType = ftInteger
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
    object Qr_ItensSrvITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensSrvITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensSrvITF_VL_SUBTOTAL: TFMTBCDField
      FieldName = 'ITF_VL_SUBTOTAL'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 9
    end
    object Qr_ItensSrvITF_VL_TOTAL: TFMTBCDField
      FieldName = 'ITF_VL_TOTAL'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 9
    end
    object Qr_ItensSrvITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
  end
  object Ds_ItensSrv: TDataSource
    DataSet = Qr_ItensSrv
    Left = 32
    Top = 216
  end
  object Qr_Ordem: TSTQuery
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT os.tb_order_id'
      'FROM tb_vehicle_so os'
      '   INNER JOIN TB_VEICULO vei'
      '   ON (vei.vei_placa = os.tb_vehicle_id)'
      '   INNER JOIN TB_MARCA_VEICULO mrc'
      '   ON (mrc.MRC_CODIGO = vei.VEI_CODMRC)'
      '   INNER JOIN TB_MODELO mo'
      '   ON (mo.MOD_CODIGO = vei.VEI_CODMOD)'
      '   INNER JOIN TB_TP_VEICULO tpv'
      '   ON (tpv.TPV_CODIGO = vei.VEI_CODTPV)'
      'WHERE'
      '  os.tb_order_id =:PED_CODIGO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 144
    Top = 168
    ParamData = <
      item
        Name = 'PED_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
  end
  object Timer_deve: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer_deveTimer
    Left = 756
    Top = 338
  end
  object Qr_Tecnicos: TSTQuery
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      '  TEC_CODIGO,'
      '  TEC_CODITF,'
      '  TEC_CODPED,'
      '  TEC_CODCLB,'
      '  TEC_PROPORCAO'
      'FROM TB_TECNICO'
      'WHERE TEC_CODITF=:TEC_CODITF')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 152
    Top = 224
    ParamData = <
      item
        Name = 'TEC_CODITF'
      end>
  end
  object Ds_ItensDev: TDataSource
    DataSet = Qr_ItensDev
    OnStateChange = Ds_ItensDevStateChange
    Left = 656
    Top = 184
  end
  object Qr_ItensDev: TSTQuery
    AfterOpen = Qr_ItensDevAfterOpen
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_ESTOQUE,'
      '  ITF_CODEST,'
      '  ITF_CODTPR,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '   ITF_AQ_DESC,'
      '   ITF_VL_DESC,'
      '  PRO_VL_CUSTOMED,'
      
        '  CAST(((((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) * ITF_AQ_IPI) ' +
        '/ 100) AS DOUBLE PRECISION) ITF_VL_IPI,'
      
        '  CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) AS NUMERIC(18, 9' +
        ')) ITF_VL_SUBTOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   inner join tb_medida tb_medida'
      '   on tb_medida.med_codigo = tb_produto.pro_codmed'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (ITF_OPER = '#39'D'#39')'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 625
    Top = 72
    ParamData = <
      item
        Name = 'PED_CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Size = 4
      end>
    object Qr_ItensDevITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensDevITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensDevITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
    end
    object Qr_ItensDevITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensDevPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensDevPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensDevITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensDevITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
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
      Size = 1
    end
    object Qr_ItensDevITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensDevITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensDevITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensDevMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensDevITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
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
    object Qr_ItensDevITF_VL_IPI: TFloatField
      FieldName = 'ITF_VL_IPI'
      ProviderFlags = []
      ReadOnly = True
    end
    object Qr_ItensDevITF_VL_SUBTOTAL: TFMTBCDField
      FieldName = 'ITF_VL_SUBTOTAL'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 9
    end
  end
  object qr_prazo_controlado: TSTQuery
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo'
      'where'
      'prz_vl_minimo <= :prz_vl_minimo'
      'order BY prz_prazo')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 564
    Top = 12
    ParamData = <
      item
        Name = 'prz_vl_minimo'
      end>
  end
  object dts_PrazoControlado: TDataSource
    AutoEdit = False
    DataSet = qr_prazo_controlado
    Left = 620
    Top = 12
  end
  object Pop_Produto: TPopupMenu
    Left = 756
    Top = 220
    object Corrigirsequnciadositens1: TMenuItem
      Caption = 'Corrigir sequ'#234'ncia dos itens'
      OnClick = Corrigirsequnciadositens1Click
    end
    object RegistraNmerodeSerie: TMenuItem
      Caption = 'Registrar o N'#250'mero de S'#233'rie'
      OnClick = RegistraroNmerodeSrie1Click
    end
    object RegistraNmerodeLote: TMenuItem
      Caption = 'Registra N'#250'mero de Lote'
      OnClick = RegistraNmerodeLoteClick
    end
    object InformarNmerodeCompra: TMenuItem
      Caption = 'Informar N'#250'mero de Compra'
      OnClick = InformarNmerodeCompraClick
    end
    object InformaoCombustivel1: TMenuItem
      Caption = 'Informa'#231#227'o Combustivel'
      OnClick = InformaoCombustivel1Click
    end
    object CadastrodoProduto: TMenuItem
      Caption = 'Cadastro do Produto'
      OnClick = CadastrodoProdutoClick
    end
    object DadosdoNCM1: TMenuItem
      Caption = 'Dados do NCM'
      OnClick = DadosdoNCM1Click
    end
    object Lucratividade1: TMenuItem
      Caption = 'Lucratividade'
      OnClick = Lucratividade1Click
    end
  end
  object Mnu_Controle: TMainMenu
    Left = 756
    Top = 276
    object Mnu_Tarefas: TMenuItem
      Caption = 'Tarefas'
      object Pop_ConfigLocal: TMenuItem
        Caption = 'Configura'#231#245'es Locais'
        OnClick = Pop_ConfigLocalClick
      end
      object Pop_ConfigGlobal: TMenuItem
        Caption = 'Configura'#231#245'es Globais'
        OnClick = Pop_ConfigGlobalClick
      end
      object MnuLucratividade: TMenuItem
        Caption = 'Lucratividade'
        OnClick = MnuLucratividadeClick
      end
      object MnuSeparao: TMenuItem
        Caption = 'Separa'#231#227'o'
        OnClick = MnuSeparaoClick
      end
      object MnuOperaesemGrupo: TMenuItem
        Caption = 'Opera'#231#245'es em Grupo'
        OnClick = MnuOperaesemGrupoClick
      end
      object MnuEnviaPedido: TMenuItem
        Caption = 'Envia Pedido'
        OnClick = MnuEnviaPedidoClick
      end
      object MnuCustodoPedido: TMenuItem
        Caption = 'Custo do Pedido'
        OnClick = MnuCustodoPedidoClick
      end
      object ConsollidarCustoLucratividade1: TMenuItem
        Caption = 'Consolidar Custo/Lucratividade'
        OnClick = ConsollidarCustoLucratividade1Click
      end
      object AplicarLote1: TMenuItem
        Caption = 'Aplicar Lote'
        OnClick = AplicarLote1Click
      end
      object AlteraTabeladePreo1: TMenuItem
        Caption = 'Altera Tabela de Pre'#231'o'
        OnClick = AlteraTabeladePreo1Click
      end
      object InclusodeItemFormarpido1: TMenuItem
        Caption = 'Inclus'#227'o R'#225'pia de Produtos'
        ShortCut = 49225
        OnClick = ActInclusaoRapidoProdutoExecute
      end
      object MnuAcompanhamento: TMenuItem
        Caption = 'Acompanhamento'
        OnClick = MnuAcompanhamentoClick
      end
      object AuditoriadeEstoque: TMenuItem
        Caption = 'Auditoria de Estoque'
        OnClick = AuditoriadeEstoqueClick
      end
      object InformarContrato1: TMenuItem
        Caption = 'Informar Contrato'
        OnClick = InformarContrato1Click
      end
      object MnuLiberarItensparaDespacho: TMenuItem
        Caption = 'Liberar Itens para Despacho'
        OnClick = MnuLiberarItensparaDespachoClick
      end
      object MnuCancelarDespacho: TMenuItem
        Caption = 'Cancelar Despacho'
        OnClick = MnuCancelarDespachoClick
      end
    end
  end
  object Pop_Servico: TPopupMenu
    Left = 708
    Top = 172
    object MenuItem3: TMenuItem
      Caption = 'Cadastro do Servi'#231'o'
      OnClick = MenuItem3Click
    end
  end
  object Qr_ItensTro: TSTQuery
    AfterOpen = Qr_ItensTroAfterOpen
    CachedUpdates = False
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODNFL,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_ESTOQUE,'
      '  ITF_CODEST,'
      '  ITF_CODTPR,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '   ITF_AQ_DESC,'
      '   ITF_VL_DESC,'
      '  PRO_VL_CUSTOMED,'
      
        '  CAST(((((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) * ITF_AQ_IPI) ' +
        '/ 100) AS DOUBLE PRECISION) ITF_VL_IPI,'
      
        '  CAST(((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) AS NUMERIC(18, 9' +
        ')) ITF_VL_SUBTOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PEDIDO Tb_pedido'
      '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   inner join tb_medida tb_medida'
      '   on tb_medida.med_codigo = tb_produto.pro_codmed'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (ITF_OPER = '#39'T'#39')'
      'ORDER BY PRO_DESCRICAO'
      '  ')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 585
    Top = 120
    ParamData = <
      item
        Name = 'PED_CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Size = 4
      end>
    object Qr_ItensTroITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensTroITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensTroITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
    end
    object Qr_ItensTroITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensTroPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensTroPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensTroITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensTroITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensTroITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensTroITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      Size = 1
    end
    object Qr_ItensTroITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensTroITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensTroITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensTroMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensTroITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensTroITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensTroPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensTroITF_VL_IPI: TFloatField
      FieldName = 'ITF_VL_IPI'
      ProviderFlags = []
      ReadOnly = True
    end
    object Qr_ItensTroITF_VL_SUBTOTAL: TFMTBCDField
      FieldName = 'ITF_VL_SUBTOTAL'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 9
    end
  end
  object Ds_ItensTro: TDataSource
    DataSet = Qr_ItensTro
    Left = 584
    Top = 184
  end
  object ActionList1: TActionList
    Left = 28
    Top = 465
    object Action1: TAction
      Caption = 'Permissao'
      ShortCut = 16496
      OnExecute = Action1Execute
    end
    object ActInclusaoRapidoProduto: TAction
      Caption = 'ActInclusaoRapidoProduto'
      ShortCut = 49225
      OnExecute = ActInclusaoRapidoProdutoExecute
    end
  end
  object pop_troca: TPopupMenu
    Left = 684
    Top = 76
    object MenuItem2: TMenuItem
      Caption = 'Registra N'#250'mero de Lote'
      OnClick = MenuItem2Click
    end
    object MenuItem5: TMenuItem
      Caption = 'Cadastro do Produto'
      OnClick = MenuItem5Click
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 556
    Top = 467
  end
end
