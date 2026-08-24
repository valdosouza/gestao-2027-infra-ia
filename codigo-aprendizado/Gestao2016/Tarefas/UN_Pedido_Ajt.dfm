object Fr_Pedido_Ajt: TFr_Pedido_Ajt
  Left = 160
  Top = 56
  BorderStyle = bsSingle
  Caption = 'Pedido de Ajuste de Estoque'
  ClientHeight = 584
  ClientWidth = 699
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
  object Pg_Pedido_Ajt: TPageControl
    Left = 0
    Top = 0
    Width = 699
    Height = 584
    ActivePage = tbs_pedido
    Align = alClient
    Anchors = [akTop, akBottom]
    TabOrder = 0
    ExplicitHeight = 559
    object tbs_pedido: TTabSheet
      Caption = 'tbs_pedido'
      OnShow = tbs_pedidoShow
      ExplicitHeight = 531
      object Pnl_fundo: TPanel
        Left = 0
        Top = 0
        Width = 691
        Height = 490
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 465
        object Label1: TLabel
          Left = 8
          Top = 4
          Width = 33
          Height = 14
          Caption = 'Codigo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 90
          Top = 4
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
          Left = 491
          Top = 46
          Width = 47
          Height = 14
          Caption = 'Vendedor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lc_fornecedor: TLabel
          Left = 8
          Top = 45
          Width = 187
          Height = 14
          Caption = 'C'#243'digo / Nome do Emitente/Destinat'#225'rio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Sb_Pesq_Cliente: TSpeedButton
          Left = 464
          Top = 61
          Width = 22
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
        object SB_Cliente: TSpeedButton
          Left = 440
          Top = 61
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SB_ClienteClick
        end
        object DBLCB_Empresa: TDBLookupComboBox
          Left = 69
          Top = 62
          Width = 372
          Height = 21
          KeyField = 'EMP_CODIGO'
          ListField = 'EMP_NOME'
          ListSource = DM_ListaConsultas.Ds_ListaEmpresa
          TabOrder = 3
          OnExit = DBLCB_EmpresaExit
        end
        object E_Cd_Empresa: TEdit
          Left = 4
          Top = 61
          Width = 59
          Height = 21
          TabOrder = 2
          OnExit = E_Cd_EmpresaExit
          OnKeyPress = E_Cd_EmpresaKeyPress
        end
        object E_Data: TDateTimePicker
          Left = 87
          Top = 19
          Width = 89
          Height = 21
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 1
        end
        object Panel2: TPanel
          Left = 2
          Top = 325
          Width = 687
          Height = 51
          Align = alBottom
          BevelInner = bvLowered
          TabOrder = 4
          ExplicitTop = 308
          DesignSize = (
            687
            51)
          object Label22: TLabel
            Left = 8
            Top = 7
            Width = 67
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
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
            Top = 7
            Width = 78
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
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
            Top = 7
            Width = 29
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Frete'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 575
            Top = 7
            Width = 48
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
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
            Top = 7
            Width = 43
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
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
            Top = 7
            Width = 62
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Base ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 243
            Top = 7
            Width = 67
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Valor ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 436
            Top = 7
            Width = 55
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Taxa'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 497
            Top = 7
            Width = 75
            Height = 14
            Anchors = [akTop, akRight]
            AutoSize = False
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
            Top = 22
            Width = 69
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            Color = clMenu
            DragMode = dmAutomatic
            TabOrder = 0
            Text = '0,00'
          end
          object E_VL_IPI: TEdit_Setes
            Left = 316
            Top = 22
            Width = 48
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            Color = clMenu
            DragMode = dmAutomatic
            TabOrder = 3
            Text = '0,00'
          end
          object E_VL_Frete: TEdit_Setes
            Left = 367
            Top = 22
            Width = 65
            Height = 21
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            TabOrder = 4
            Text = '0,00'
            OnExit = E_VL_FreteExit
          end
          object E_VL_ICMS: TEdit_Setes
            Left = 242
            Top = 22
            Width = 69
            Height = 21
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            TabOrder = 2
            Text = '0,00'
          end
          object E_VL_Bs_ICMS: TEdit_Setes
            Left = 173
            Top = 22
            Width = 64
            Height = 21
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            TabOrder = 1
            Text = '0,00'
          end
          object E_VL_Produto: TPanel
            Left = 81
            Top = 21
            Width = 89
            Height = 24
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Locked = True
            ParentBackground = False
            ParentFont = False
            TabOrder = 5
          end
          object E_Aq_Desconto: TEdit_Setes
            Left = 437
            Top = 22
            Width = 55
            Height = 21
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            TabOrder = 6
            Text = '0,00'
            OnExit = E_Aq_DescontoExit
          end
          object E_VL_Desconto: TEdit_Setes
            Left = 497
            Top = 22
            Width = 73
            Height = 21
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            TabOrder = 7
            Text = '0,00'
            OnExit = E_VL_DescontoExit
          end
          object E_VL_Pedido: TPanel
            Left = 574
            Top = 21
            Width = 105
            Height = 24
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Locked = True
            ParentBackground = False
            ParentFont = False
            TabOrder = 8
          end
        end
        object chbx_Nome: TCheckBox
          Left = 204
          Top = 46
          Width = 120
          Height = 13
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 5
          OnClick = chbx_NomeClick
        end
        object chbx_fantasia: TCheckBox
          Left = 321
          Top = 46
          Width = 104
          Height = 13
          Caption = 'Apelido/Fantasia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = chbx_fantasiaClick
        end
        object E_Nr_Pedido: TEdit_Setes
          Left = 6
          Top = 19
          Width = 78
          Height = 21
          TabStop = False
          TabOrder = 0
          Text = ''
        end
        object DBLCB_Vendedor: TDBLookupComboBox
          Left = 492
          Top = 62
          Width = 190
          Height = 21
          KeyField = 'CLB_CODIGO'
          ListField = 'CLB_NOME'
          ListSource = DM_ListaConsultas.DS_ListaVendedor
          TabOrder = 7
        end
        object Pg_Observacao: TPageControl
          Left = 2
          Top = 376
          Width = 687
          Height = 112
          ActivePage = TabSheet1
          Align = alBottom
          TabOrder = 8
          ExplicitTop = 368
          object tbs_obs: TTabSheet
            Caption = 'Observa'#231#245'es'
            object Pnl_Observacao: TPanel
              Left = 0
              Top = 0
              Width = 679
              Height = 84
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object E_Observ: TMemo
                Left = 2
                Top = 2
                Width = 675
                Height = 80
                Align = alClient
                TabOrder = 0
              end
            end
          end
          object tbs_dado_entrega: TTabSheet
            Caption = 'Dados de Entrega'
            ImageIndex = 1
            ExplicitHeight = 76
            object Pnl_entrega: TPanel
              Left = 0
              Top = 0
              Width = 679
              Height = 84
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              ExplicitHeight = 76
              object Label20: TLabel
                Left = 3
                Top = 2
                Width = 155
                Height = 14
                Caption = 'Endere'#231'o relacionado ao pedido'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object DBLCB_End_Entrega: TDBLookupComboBox
                Left = 6
                Top = 22
                Width = 562
                Height = 21
                KeyField = 'END_CODIGO'
                ListField = 'END_COMPLETO'
                ListSource = Ds_Endereco
                TabOrder = 0
              end
            end
          end
          object TabSheet1: TTabSheet
            Caption = 'Outras Infomra'#231#245'es'
            ImageIndex = 2
            ExplicitHeight = 76
            object Pnl_Informacoes: TPanel
              Left = 0
              Top = 0
              Width = 679
              Height = 84
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              ExplicitHeight = 76
              object Sb_Negocio: TSpeedButton
                Left = 493
                Top = 19
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
              object Label29: TLabel
                Left = 5
                Top = 41
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
                Left = 5
                Top = 58
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
            end
          end
        end
        object PG_Itens: TPageControl
          Left = 2
          Top = 89
          Width = 687
          Height = 236
          ActivePage = TS_Produto
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          MultiLine = True
          TabOrder = 9
          object TS_Produto: TTabSheet
            Caption = '&Produtos'
            DragMode = dmAutomatic
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitHeight = 191
            object Pnl_Produto: TPanel
              Left = 0
              Top = 0
              Width = 679
              Height = 208
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              ExplicitHeight = 191
              object Sb_Ins_Produto: TSpeedButton
                AlignWithMargins = True
                Left = 304
                Top = 170
                Width = 113
                Height = 33
                Align = alRight
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
                ExplicitLeft = 311
                ExplicitTop = 156
                ExplicitHeight = 32
              end
              object Sb_Alt_Produto: TSpeedButton
                AlignWithMargins = True
                Left = 423
                Top = 170
                Width = 124
                Height = 33
                Align = alRight
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
                ExplicitLeft = 430
                ExplicitTop = 157
                ExplicitHeight = 32
              end
              object Sb_Exc_Produto: TSpeedButton
                AlignWithMargins = True
                Left = 553
                Top = 170
                Width = 121
                Height = 33
                Align = alRight
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
                ExplicitLeft = 560
                ExplicitTop = 157
                ExplicitHeight = 32
              end
              object DBG_Produtos: TDBGrid
                Left = 2
                Top = 2
                Width = 675
                Height = 165
                Align = alTop
                Anchors = [akLeft, akTop, akRight, akBottom]
                DataSource = ds_itens_ajt
                Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
                PopupMenu = Pop_lote
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
                    FieldName = 'PRO_CODIGOFAB'
                    Title.Caption = 'C'#243'digo de F'#225'brica'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PRO_DESCRICAO'
                    Title.Caption = 'Descri'#231#227'o do Produto'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'MED_ABREVIATURA'
                    Title.Caption = 'Unidade'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ITF_QTDE'
                    Title.Caption = 'Quantidade'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ITF_VL_UNIT'
                    Title.Caption = 'Valor Unit'#225'rio'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ITF_VL_SUBTOTAL'
                    Title.Caption = 'Subtotal'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ITF_VL_DESC'
                    Title.Caption = 'Desconto'
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
                  end>
              end
            end
          end
        end
      end
      object Pnl_botao: TPanel
        Left = 0
        Top = 490
        Width = 691
        Height = 66
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        ExplicitTop = 465
        object SB_Inserir: TSpeedButton
          AlignWithMargins = True
          Left = 12
          Top = 3
          Width = 75
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
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
          ExplicitLeft = 4
          ExplicitTop = 7
          ExplicitHeight = 54
        end
        object SB_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 87
          Top = 3
          Width = 75
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
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
          ExplicitLeft = 79
          ExplicitTop = 7
          ExplicitHeight = 54
        end
        object SB_Excluir: TSpeedButton
          AlignWithMargins = True
          Left = 162
          Top = 3
          Width = 75
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
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
          ExplicitTop = 4
        end
        object SB_Gravar: TSpeedButton
          AlignWithMargins = True
          Left = 237
          Top = 3
          Width = 75
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
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
          ExplicitTop = 4
        end
        object SB_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 312
          Top = 3
          Width = 75
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
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
          ExplicitLeft = 304
          ExplicitTop = 7
          ExplicitHeight = 54
        end
        object SB_Faturar: TSpeedButton
          AlignWithMargins = True
          Left = 464
          Top = 3
          Width = 75
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alRight
          Caption = 'Baixar - F10'
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
          ExplicitLeft = 454
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Imprimir: TSpeedButton
          AlignWithMargins = True
          Left = 539
          Top = 3
          Width = 75
          Height = 60
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
          ExplicitLeft = 535
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Pesquisar: TSpeedButton
          AlignWithMargins = True
          Left = 387
          Top = 3
          Width = 77
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
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
          ExplicitLeft = 379
          ExplicitTop = 7
          ExplicitHeight = 54
        end
        object Sb_Sair_0: TSpeedButton
          AlignWithMargins = True
          Left = 614
          Top = 3
          Width = 75
          Height = 60
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
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
          ExplicitLeft = 606
          ExplicitTop = 7
          ExplicitHeight = 54
        end
      end
    end
    object tbs_pesquisa: TTabSheet
      Caption = 'tbs_pesquisa'
      ImageIndex = 1
      OnShow = tbs_pesquisaShow
      ExplicitHeight = 531
      object GroupBox1: TGroupBox
        Left = 0
        Top = 57
        Width = 691
        Height = 65
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
          Top = 21
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
          Left = 247
          Top = 37
          Width = 434
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
        object E_BuscaPedido: TEdit
          Left = 4
          Top = 37
          Width = 79
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
        end
        object ChBx_Busca_Nome: TCheckBox
          Left = 248
          Top = 21
          Width = 121
          Height = 13
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = ChBx_Busca_NomeClick
        end
        object ChBx_Busca_Fantasia: TCheckBox
          Left = 375
          Top = 21
          Width = 121
          Height = 13
          Caption = 'Apelido/Fantasia'
          TabOrder = 5
          OnClick = ChBx_Busca_FantasiaClick
        end
        object E_Data_Ini: TDateTimePicker
          Left = 85
          Top = 37
          Width = 80
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 1
        end
        object E_Data_Fim: TDateTimePicker
          Left = 166
          Top = 37
          Width = 80
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 2
        end
        object ChBx_Periodo: TCheckBox
          Left = 87
          Top = 21
          Width = 128
          Height = 13
          Caption = 'Data Inicial    Data Final'
          TabOrder = 6
          OnClick = ChBx_PeriodoClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 122
        Width = 691
        Height = 434
        Align = alClient
        TabOrder = 1
        ExplicitHeight = 409
        object DBG_Pesquisa: TDBGrid
          Left = 2
          Top = 15
          Width = 595
          Height = 417
          Align = alClient
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
              Title.Caption = 'Nome do Cliente'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 424
              Visible = True
            end>
        end
        object pnl_pesq_right: TPanel
          Left = 597
          Top = 15
          Width = 92
          Height = 417
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitHeight = 392
          object Sb_Sair_1: TSpeedButton
            Left = 0
            Top = 363
            Width = 92
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
            ExplicitLeft = 450
            ExplicitTop = 333
          end
          object SB_Visualizar: TSpeedButton
            Left = 0
            Top = 309
            Width = 92
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
            ExplicitLeft = 6
            ExplicitTop = 278
          end
          object SB_Buscar: TSpeedButton
            Left = 0
            Top = 255
            Width = 92
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
            ExplicitLeft = 450
            ExplicitTop = 227
          end
          object SB_Cadastrar: TSpeedButton
            Left = 0
            Top = 147
            Width = 92
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
            ExplicitLeft = 6
            ExplicitTop = 170
          end
          object Sb_Transferir: TSpeedButton
            Left = 0
            Top = 201
            Width = 92
            Height = 54
            Align = alBottom
            Caption = 'Transferir - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000074120000741200000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1E3E3E3FEFE
              FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFEFEFEF9F9F9FDFDFDFAFAFAE3E4E4DCDDDDC3C5C5B2B4
              B4EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFEAEBEBD8D9D9D0D1D1C6C8C8D7D8D8DBDCDCDADCDBD3D6D5C5C7
              C7B1B4B4C0C1C1FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFAFAFAE1E1E1E2E3E3E2E2E2DDDEDEDDDEDED9DADAD3D6D5CBCECDA8AA
              A9B4B5B5B6B9B9A5A7A7DDDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFDFDFDE1E1E1E1E1E1DFE0E0DCDDDDDADBDBD7D8D8D4D6D6CCCFCEA6A8
              A8A8A9A9B9BBBBB8BABAACAFAFAEAFAFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F3F4F4DADCDCDEDFDFDFDFDFDDDEDEDBDCDCD7D8D8B7BFC2D0D4D3CCCFCEA7A8
              A8ABACACB9BBBBB9BBBBB8BABAB1B4B49C9F9FB8B8B8F8F8F8FFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9
              DBDCDCDADBDBD7D9D8D8D9D9DADBDBC7CDCE82959C414A4ED0D4D3CCCFCEA7A9
              A9AAABABB9BBBBB9BBBBB9BBBBB9BBBBB6B8B8A7A9A9A4A4A4E4E4E4FDFDFDFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F6F6F6D7D9D9CBCECDACADADB9BABA71808547575D323638D1D5D4CCCFCEA8A9
              A9ADAFAFB9BABABABBBBBABCBCB9BBBBB9BBBB959696CBCBCBEAEAEAFDFDFDFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFDBDDDDCFD2D1B6B7B6ABADAD6D7B8045555A3D4243D2D5D4CBCFCEABAD
              ADAFB1B1B8BABABABBBBB9BBBBB9BBBBB9BBBBBFBFBFFCFCFCFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFD8DBDAD0D2D1BABBBBACADAD76898E7B8D92A8B3B6C9CCCBB3B7B6A9AA
              AAAAACACB6B7B7BABCBCB9BBBBB9BBBBB9BBBBD7D8D8FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFD7DAD9D0D3D2BCBDBCABADADB8BDBDC7C8C8CFD0D08C91903D49465C64
              627E82819A9C9CA8AAAAB3B5B5B9BBBBBABBBBD4D6D6EEEFEFFAFAFAFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FEFEFED7DAD9D4D7D6C4C5C5C7C8C8D9DADAD4D5D59B9F9F434F4C3F4B483945
              42374240454E4D6C7170939594A5A6A6B1B2B2BEBFBFC6C8C8A9ACACCACBCBFD
              FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FBFBFBD2D4D4D9DBDADDDEDED4D5D4CDCFCEA9ADAC4D595645524F424E4B3C48
              4537424034403D2F3B38353F3D59605E888A8AA5A7A7C2C5C4ADAFAFA5A6A6A1
              A3A3D4D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F8F8
              EBECECDDDEDED5D6D6D4D6D5D1D2D2B6B9B856625F4E5A574A5754424E4B3F4B
              483A454336413E323D3B2E38362B35332A35324D5452A7ABAAAFB1B18C8D8DA5
              A6A69FA1A19EA0A0DEDEDEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
              F3F3F3E2E3E3D5D6D6D4D5D5C3C5C5606B69586562505D5A4C5955465350414D
              4A3D4846374340333F3C2F3A382C3734293431495150B5B9B8B0B3B28E8F8FA5
              A7A7A5A6A6A3A5A59A9C9C969797E3E3E3FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFF4F5F5DFE0E07D8684606D6A59666354615E4D5956475350434F
              4C3F4B483A454335413E313D3A2E3936515958464F52B1B5B5B0B3B2919292A4
              A6A6A5A7A7A5A7A7A4A6A6909191B0B0B0EAEAEAFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAECECC0C5C48F96954C54513038363D48
              45414C493D494637424035413E79807F3E474A465559AFB4B3B0B3B2959696A4
              A6A6A4A5A5A5A6A6A5A7A7A7A8A8FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F5DDDAD6B7B9
              B789918F56605E3F4A489396959A9C9C7D898DA3AAACA7A8A96C6B7484858694
              95959FA1A1A4A6A6A4A6A6B6B7B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCB18EB7855BFEFD
              FCFFFFFFD8DADAB5B8B7D2D2D2B0B1B1C3C5C5B9BABB463F522D233B2A213840
              3B4965646A8A8B8B9A9B9BA9A9A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFAF7C67D36C17226CDAC
              8AFFFFFFE1E2E2C7C8C8CFD0D0C3C4C4B2B3B450495C352B442F263D2B223926
              1D3421192F261F3248444F747377F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9CDACC9822DC9822DC580
              2EDCCDBADEDDDCC2C3C3C0C1C1BABABB5A52663D324C382D473329422C233B27
              1E35231B311F172D1C14281C1528ABA9AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5A660CF953FD09135CDA1
              5FF1E8DAFFFFFFF4F4F4DADADB8C86944A3E5A4136523A304A3329422E253D2A
              2138251D3321192E292235ADABB0FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF7F1E7E7C993D6A03CCD9E
              46FDFBF9FFFFFFFFFFFFFFFFFFFFFFFFF9F9FAD3D1D7A5A0AB726C753B34442B
              2239271E35413B4DCCCBCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F1E0DDB044DCAE
              43EBDBB8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDE8DAE0D7C6E8
              E6E6B7B4BCE4E3E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECD289E2BC
              49DEBC60FDFCF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0C371D5B25BFF
              FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFAF0E9CC
              61E6C64EE9D494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EFE1D0A64BD4B169F9
              F5EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF6
              E0EBD25FE9CD51EFDEA3FFFFFFFFFFFFFFFFFFFFFFFFFDFCF9C89442E2CFB0FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFCF9E9F0DB7AEBD153ECD885FBF7E8FFFFFFFFFEFED6B086B98648FCFAF8FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFEF8EFC5EFD97DE7CA55E9D181D5AB61D2A972F7F1EBFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFEFCF7FBF5E4FDFBF5FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            Layout = blGlyphTop
            ParentFont = False
            OnClick = Sb_TransferirClick
            ExplicitLeft = 450
            ExplicitTop = 227
          end
        end
      end
      inline Fm_LME: TFm_ListaMultiEmpresa
        Left = 0
        Top = 0
        Width = 691
        Height = 57
        Align = alTop
        TabOrder = 2
        ExplicitWidth = 691
        ExplicitHeight = 57
        inherited pnl_linha_1: TPanel
          Width = 691
          ExplicitWidth = 691
          inherited Sb_open: TSpeedButton
            Left = 667
            ExplicitLeft = 667
          end
          inherited Dblcb_Lista: TDBLookupComboBox
            Width = 667
            ExplicitWidth = 667
          end
        end
        inherited pnl_top: TPanel
          Width = 691
          ExplicitWidth = 691
          inherited L_name_list: TLabel
            Width = 668
            Height = 16
          end
        end
      end
    end
    object tbs_Config_Global: TTabSheet
      Caption = 'Configura'#231#245'es Globais'
      ImageIndex = 2
      ExplicitHeight = 531
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 691
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 531
        DesignSize = (
          691
          556)
        object Label15: TLabel
          Left = 2
          Top = 2
          Width = 687
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
          ExplicitWidth = 183
        end
        object Chbx_controle_ajuste: TCheckBox
          Left = 7
          Top = 25
          Width = 328
          Height = 17
          Caption = 'Controlar a seq'#252#234'ncia do n'#250'mero de pedido de Ajuste'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object Btn_Ok_Local: TButton
          Left = 453
          Top = 525
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 1
          OnClick = Btn_Ok_LocalClick
          ExplicitTop = 500
        end
        object Btn_Cn_Local: TButton
          Left = 532
          Top = 525
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 2
          OnClick = Btn_Cn_LocalClick
          ExplicitTop = 500
        end
        object Btn_Ap_Local: TButton
          Left = 607
          Top = 525
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 3
          OnClick = Btn_Ap_LocalClick
          ExplicitTop = 500
        end
        object Chbx_controle_estoque: TCheckBox
          Left = 7
          Top = 41
          Width = 328
          Height = 17
          Caption = 'Na tela de baixa manter o padr'#227'o n'#227'o atualizar o estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
      end
    end
    object tbs_Config_Local: TTabSheet
      Caption = 'Configura'#231#245'es Locais'
      ImageIndex = 3
      ExplicitHeight = 531
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 691
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitHeight = 531
        DesignSize = (
          691
          556)
        object Label16: TLabel
          Left = 2
          Top = 2
          Width = 687
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
        object Label4: TLabel
          Left = 7
          Top = 108
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
        object Label7: TLabel
          Left = 8
          Top = 73
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
        object cbx_modeloLaser_ajt: TComboBox
          Left = 7
          Top = 122
          Width = 466
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          Items.Strings = (
            'Modelo 1 - Simples')
        end
        object rdg_PedAjt_Imp: TRadioGroup
          Left = 4
          Top = 25
          Width = 270
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
          TabOrder = 1
        end
        object GroupBox2: TGroupBox
          Left = 277
          Top = 25
          Width = 295
          Height = 46
          Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object e_porta_ImpAjt: TEdit
            Left = 7
            Top = 19
            Width = 227
            Height = 21
            TabOrder = 0
          end
          object e_salto_ajt: TEdit_Setes
            Left = 237
            Top = 19
            Width = 52
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
        end
        object cbx_modeloMat_Ajt: TComboBox
          Left = 6
          Top = 86
          Width = 466
          Height = 21
          Style = csDropDownList
          TabOrder = 3
          Items.Strings = (
            'MODELO 1 - NORMAL')
        end
        object GroupBox18: TGroupBox
          Left = 482
          Top = 81
          Width = 87
          Height = 60
          Caption = 'Itens por Folha'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          object e_itens_ajt: TEdit_Setes
            Left = 7
            Top = 19
            Width = 74
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
        end
        object Button1: TButton
          Left = 453
          Top = 525
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 5
          OnClick = Button1Click
          ExplicitTop = 500
        end
        object Button2: TButton
          Left = 532
          Top = 525
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 6
          OnClick = Button2Click
          ExplicitTop = 500
        end
        object Button3: TButton
          Left = 607
          Top = 525
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 7
          OnClick = Button3Click
          ExplicitTop = 500
        end
      end
    end
  end
  object ds_itens_ajt: TDataSource
    DataSet = cds_itens_ajt
    Left = 400
    Top = 224
  end
  object PrintDialog: TPrintDialog
    Left = 600
    Top = 8
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA , EMP_NOME'
      'FROM TB_PEDIDO tb_pedido '
      '  INNER JOIN TB_EMPRESA tb_empresa '
      '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP ) '
      'WHERE (PED_CODIGO IS NOT NULL) ')
    Left = 536
    Top = 232
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 536
    Top = 280
  end
  object Qr_Endereco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_EnderecoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT tb_endereco.end_codigo,'
      
        'tb_endereco.end_ender || '#39', '#39'|| tb_endereco.end_numero || '#39'  '#39' |' +
        '| coalesce(tb_endereco.end_complem,'#39#39')  END_Completo,'
      'tb_endereco.end_cep'
      ', END_CODUFE'
      ',END_PRINCIPAL'
      'FROM TB_ENDERECO'
      '         INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)'
      'and (END_PRINCIPAL <> '#39'I'#39')'
      'ORDER BY END_ENDER')
    Left = 227
    Top = 217
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
    Left = 227
    Top = 265
  end
  object Pop_lote: TPopupMenu
    Left = 516
    Top = 180
    object Corrigirsequnciadositens1: TMenuItem
      Caption = 'Corrigir sequ'#234'ncia dos itens'
      OnClick = Corrigirsequnciadositens1Click
    end
    object RegistraNmerodeSerie: TMenuItem
      Caption = 'Registrar o N'#250'mero de S'#233'rie'
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
    object InformarNmerodeCompra: TMenuItem
      Caption = 'Informar N'#250'mero de Compra'
      OnClick = InformarNmerodeCompraClick
    end
    object InformaoCombustivel1: TMenuItem
      Caption = 'Informa'#231#227'o Combustivel'
      OnClick = InformaoCombustivel1Click
    end
  end
  object Mnu_Controle: TMainMenu
    Left = 196
    Top = 156
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
      object PopAjustarRetornocomVendas: TMenuItem
        Caption = 'Ajustar retorno com vendas'
        OnClick = PopAjustarRetornocomVendasClick
      end
    end
  end
  object cds_itens_ajt: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cds_itens_ajtAfterOpen
    Left = 404
    Top = 168
    object cds_itens_ajtITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cds_itens_ajtITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object cds_itens_ajtITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
    end
    object cds_itens_ajtITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object cds_itens_ajtPRO_CODIGOFAB: TWideStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object cds_itens_ajtPRO_CODIGOFOR: TWideStringField
      FieldName = 'PRO_CODIGOFOR'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFOR"'
      Size = 50
    end
    object cds_itens_ajtPRO_DESCRICAO: TWideStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object cds_itens_ajtPRO_SERIE: TWideStringField
      FieldName = 'PRO_SERIE'
      Origin = '"TB_PRODUTO"."PRO_SERIE"'
      Size = 1
    end
    object cds_itens_ajtITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object cds_itens_ajtITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object cds_itens_ajtITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      DisplayFormat = '0.00######'
      Precision = 18
      Size = 2
    end
    object cds_itens_ajtITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object cds_itens_ajtEMB_ABREVIATURA: TWideStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object cds_itens_ajtITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object cds_itens_ajtITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object cds_itens_ajtITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object cds_itens_ajtMED_ABREVIATURA: TWideStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object cds_itens_ajtITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object cds_itens_ajtITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      DisplayFormat = '0.00######'
      Precision = 18
      Size = 2
    end
    object cds_itens_ajtITF_ESTOQUE: TWideStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      FixedChar = True
      Size = 1
    end
    object cds_itens_ajtITF_VL_IPI: TFMTBCDField
      FieldName = 'ITF_VL_IPI'
      ProviderFlags = []
      Precision = 18
      Size = 11
    end
    object cds_itens_ajtITF_ALTURA: TBCDField
      FieldName = 'ITF_ALTURA'
      Origin = '"TB_ITENS_NFL"."ITF_ALTURA"'
      Precision = 18
      Size = 2
    end
    object cds_itens_ajtITF_VL_TOTAL: TFloatField
      FieldName = 'ITF_VL_TOTAL'
      DisplayFormat = '0.00######'
    end
    object cds_itens_ajtITF_LARGURA: TBCDField
      FieldName = 'ITF_LARGURA'
      Origin = '"TB_ITENS_NFL"."ITF_LARGURA"'
      Precision = 18
      Size = 2
    end
    object cds_itens_ajtITF_VL_SUBTOTAL: TFloatField
      FieldName = 'ITF_VL_SUBTOTAL'
      DisplayFormat = '0.00######'
    end
    object cds_itens_ajtITF_VL_UNIT: TExtendedField
      FieldName = 'ITF_VL_UNIT'
      Precision = 19
    end
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    OnCalcFields = Qr_ItensCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_SEQUENCIA,'
      'PRO_CODIGOFOR,'
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
      '  '
      '')
    Left = 129
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ItensITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_ItensITF_CODNFL: TIntegerField
      FieldName = 'ITF_CODNFL'
      Origin = '"TB_ITENS_NFL"."ITF_CODNFL"'
    end
    object Qr_ItensITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensPRO_CODIGOFOR: TStringField
      FieldName = 'PRO_CODIGOFOR'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFOR"'
      Size = 50
    end
    object Qr_ItensPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensPRO_SERIE: TStringField
      FieldName = 'PRO_SERIE'
      Origin = '"TB_PRODUTO"."PRO_SERIE"'
      Size = 1
    end
    object Qr_ItensITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensITF_AQ_COM: TBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensITF_AQ_IPI: TBCDField
      FieldName = 'ITF_AQ_IPI'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensEMB_ABREVIATURA: TStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensITF_AQ_ICMS: TBCDField
      FieldName = 'ITF_AQ_ICMS'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensITF_CODEST: TIntegerField
      FieldName = 'ITF_CODEST'
      Origin = '"TB_ITENS_NFL"."ITF_CODEST"'
    end
    object Qr_ItensITF_CODTPR: TIntegerField
      FieldName = 'ITF_CODTPR'
      Origin = '"TB_ITENS_NFL"."ITF_CODTPR"'
    end
    object Qr_ItensMED_ABREVIATURA: TStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      FixedChar = True
      Size = 1
    end
    object Qr_ItensITF_VL_IPI: TFloatField
      FieldName = 'ITF_VL_IPI'
      ProviderFlags = []
    end
    object Qr_ItensITF_ALTURA: TBCDField
      FieldName = 'ITF_ALTURA'
      Origin = '"TB_ITENS_NFL"."ITF_ALTURA"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensITF_LARGURA: TBCDField
      FieldName = 'ITF_LARGURA'
      Origin = '"TB_ITENS_NFL"."ITF_LARGURA"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensITF_VL_SUBTOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_SUBTOTAL'
      Calculated = True
    end
    object Qr_ItensITF_VL_TOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_TOTAL'
      Calculated = True
    end
    object Qr_ItensITF_SEQUENCIA: TIntegerField
      FieldName = 'ITF_SEQUENCIA'
      Origin = '"TB_ITENS_NFL"."ITF_SEQUENCIA"'
    end
    object Qr_ItensPRO_CODIGONCM: TStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = '"TB_PRODUTO"."PRO_CODIGONCM"'
      Size = 50
    end
    object Qr_ItensPRO_TIPO: TStringField
      FieldName = 'PRO_TIPO'
      Origin = '"TB_PRODUTO"."PRO_TIPO"'
      Size = 1
    end
    object Qr_ItensTPR_MODALIDADE: TStringField
      FieldName = 'TPR_MODALIDADE'
      Origin = '"TB_TABELA_PRECO"."TPR_MODALIDADE"'
      Size = 1
    end
    object Qr_ItensTPR_NOME: TStringField
      FieldName = 'TPR_NOME'
      Origin = '"TB_TABELA_PRECO"."TPR_NOME"'
      Size = 50
    end
    object Qr_ItensPRO_ORIGEM: TStringField
      FieldName = 'PRO_ORIGEM'
      Origin = '"TB_PRODUTO"."PRO_ORIGEM"'
      Size = 1
    end
    object Qr_ItensITF_NR_PECAS: TBCDField
      FieldName = 'ITF_NR_PECAS'
      Origin = '"TB_ITENS_NFL"."ITF_NR_PECAS"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
  end
end
