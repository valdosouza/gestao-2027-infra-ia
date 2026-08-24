object Fr_Receber_Multipla: TFr_Receber_Multipla
  Left = 180
  Top = 0
  Anchors = [akTop, akBottom]
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Controle de Baixas no Contas a Receber'
  ClientHeight = 680
  ClientWidth = 1002
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Controle: TPageControl
    Left = 0
    Top = 50
    Width = 1002
    Height = 381
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Busca'
      object Dbg_Parcela: TDBGrid
        Left = 0
        Top = 92
        Width = 994
        Height = 201
        Align = alClient
        DataSource = Ds_Parcelas
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = PpM_Duplicata
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = Dbg_ParcelaDrawColumnCell
        OnDblClick = Dbg_ParcelaDblClick
        OnTitleClick = Dbg_ParcelaTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PED_NUMERO'
            Title.Caption = 'Pedido'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NFL_NUMERO'
            Title.Caption = 'Nota Fiscal'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_NUMERO'
            Title.Caption = 'Duplicata'
            Width = 129
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_DT_VENCIMENTO'
            Title.Caption = 'Vencimento'
            Width = 86
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_VL_PARCELA'
            Title.Caption = 'Valor Parcela'
            Width = 114
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_VL_PAGO'
            Title.Caption = 'Valor Pago'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_DT_PAGTO'
            Title.Caption = 'Data Pagto'
            Width = 102
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMP_FANTASIA'
            Title.Caption = 'Fantasia'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'EMP_NOME'
            Title.Caption = 'Nome/Raz'#227'o Social'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PED_DT_ALTERA'
            Title.Caption = 'Data/Hora Pedido'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PLC_DESCRICAO'
            Title.Caption = 'Conta Gerencial'
            Visible = True
          end>
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 994
        Height = 92
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label12: TLabel
          Left = 169
          Top = 13
          Width = 47
          Height = 14
          Caption = 'N'#186' Pedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 227
          Top = 13
          Width = 68
          Height = 14
          Caption = 'N'#186' Nota Fiscal'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 303
          Top = 13
          Width = 59
          Height = 14
          Caption = 'N'#186' Duplicata'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object L_CodigoCliente: TLabel
          Left = 378
          Top = 13
          Width = 68
          Height = 14
          Caption = 'C'#243'digo Cliente'
        end
        object Sb_Resumo: TSpeedButton
          Left = 796
          Top = 20
          Width = 113
          Height = 28
          Caption = 'Totalizador Valores'
          OnClick = Sb_ResumoClick
        end
        object Label36: TLabel
          Left = 231
          Top = 51
          Width = 45
          Height = 14
          Caption = 'Situa'#231#227'o '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 712
          Top = 9
          Width = 64
          Height = 14
          Caption = 'Valor Parcela'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Sb_Pesq_Empresa: TSpeedButton
          Left = 686
          Top = 27
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
          OnClick = Sb_Pesq_EmpresaClick
        end
        object Label2: TLabel
          Left = 8
          Top = 50
          Width = 60
          Height = 14
          Caption = 'Tipo de Data'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BuscaPedido: TEdit_Setes
          Left = 169
          Top = 27
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = ''
        end
        object E_Busca_Empresa: TEdit
          Left = 441
          Top = 27
          Width = 241
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object E_BuscaNota: TEdit
          Left = 227
          Top = 27
          Width = 74
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 8
          ParentFont = False
          TabOrder = 3
        end
        object E_BuscaFinanceiro: TEdit
          Left = 303
          Top = 27
          Width = 72
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object ChBx_Nome: TCheckBox
          Left = 452
          Top = 9
          Width = 121
          Height = 17
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 12
          OnClick = ChBx_NomeClick
        end
        object ChBx_Fantasia: TCheckBox
          Left = 568
          Top = 9
          Width = 102
          Height = 17
          Caption = 'Apelido/Fantasia'
          TabOrder = 13
          OnClick = ChBx_FantasiaClick
        end
        object E_Data_Ini: TDateTimePicker
          Left = 7
          Top = 27
          Width = 79
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 0
        end
        object E_Data_Fim: TDateTimePicker
          Left = 88
          Top = 27
          Width = 79
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 1
        end
        object ChBx_Periodo: TCheckBox
          Left = 7
          Top = 13
          Width = 128
          Height = 12
          Caption = 'Data Inicial    Data Final'
          Checked = True
          State = cbChecked
          TabOrder = 14
          OnClick = ChBx_PeriodoClick
        end
        object E_Busca_Cd_Empresa: TEdit
          Left = 378
          Top = 27
          Width = 61
          Height = 22
          TabOrder = 5
          OnExit = E_Busca_Cd_EmpresaExit
        end
        object Cb_Situacao: TComboBox
          Left = 231
          Top = 64
          Width = 169
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 9
          Text = 'Normais'
          OnChange = Cb_SituacaoChange
          Items.Strings = (
            'Normais'
            'Destinadas'
            'Baixadas'
            'Inativas'
            'Todas')
        end
        object E_BuscaVl_Parcela: TEdit_Setes
          Left = 711
          Top = 26
          Width = 67
          Height = 22
          Alignment = taRightJustify
          TabOrder = 7
          Text = ''
          OnExit = E_VL_ChequeExit
        end
        inline Fm_TipoCobranca: TFm_FormaPagto
          Left = 400
          Top = 47
          Width = 243
          Height = 42
          TabOrder = 10
          ExplicitLeft = 400
          ExplicitTop = 47
          ExplicitWidth = 243
          ExplicitHeight = 42
          inherited Lb_FormaPagamento: TLabel
            Width = 237
            Caption = 'Tipo de Cobran'#231'a'
            ExplicitWidth = 85
          end
          inherited pnl_Forma: TPanel
            Width = 243
            Height = 28
            ExplicitWidth = 243
            ExplicitHeight = 28
            inherited SB_FormaPag: TSpeedButton
              Left = 217
              Height = 25
              ExplicitLeft = 216
              ExplicitHeight = 28
            end
            inherited DBLCB_FormaPagto: TDBLookupComboBox
              Width = 208
              Height = 22
              ExplicitWidth = 208
              ExplicitHeight = 22
            end
          end
        end
        object Cb_TipoData: TComboBox
          Left = 8
          Top = 65
          Width = 217
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 8
          Text = 'VENCIMENTO'
          OnClick = Cb_TipoDataClick
          Items.Strings = (
            'VENCIMENTO'
            'PAGAMENTO'
            'LAN'#199'AMENTO'
            'REPROGRAMA'#199#195'O')
        end
        inline Fm_ListaVendedores: TFm_ListaColaboradores
          Left = 650
          Top = 51
          Width = 315
          Height = 36
          TabOrder = 11
          ExplicitLeft = 650
          ExplicitTop = 51
          ExplicitWidth = 315
          ExplicitHeight = 36
          inherited Label19: TLabel
            Width = 315
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 289
            Height = 19
            ExplicitLeft = 289
            ExplicitHeight = 19
          end
          inherited Dblcb_Vendedor: TDBLookupComboBox
            Width = 286
            ExplicitWidth = 286
          end
        end
      end
      object Pg_Observacao: TPageControl
        Left = 166
        Top = 93
        Width = 658
        Height = 95
        ActivePage = TabSheet5
        TabOrder = 1
        Visible = False
        object TabSheet5: TTabSheet
          Caption = 'tb_resumo'
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 650
            Height = 67
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Panel2: TPanel
              Left = 2
              Top = 19
              Width = 156
              Height = 46
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object Label28: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 150
                Height = 14
                Align = alTop
                Caption = 'Valor Total Contas '#224' Receber'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 140
              end
              object E_Vl_Receber: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 23
                Width = 150
                Height = 16
                Align = alTop
                Alignment = taRightJustify
                AutoSize = False
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                ExplicitLeft = 47
                ExplicitTop = 49
                ExplicitWidth = 101
              end
            end
            object Panel11: TPanel
              Left = 158
              Top = 19
              Width = 147
              Height = 46
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 1
              object Label13: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 141
                Height = 14
                Align = alTop
                Caption = 'Cr'#233'ditos a Ceder/Cedido'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 117
              end
              object E_Vl_Cred_Ceder: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 23
                Width = 141
                Height = 16
                Align = alTop
                Alignment = taRightJustify
                AutoSize = False
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clRed
                Font.Height = -15
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                ExplicitLeft = -89
                ExplicitTop = 24
                ExplicitWidth = 101
              end
            end
            object Panel12: TPanel
              Left = 461
              Top = 19
              Width = 187
              Height = 46
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 2
              object Label37: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 181
                Height = 14
                Align = alTop
                Caption = 'Saldo Total do Contas '#224' Receber'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 157
              end
              object E_Vl_Total_Receber: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 23
                Width = 181
                Height = 16
                Align = alTop
                Alignment = taRightJustify
                AutoSize = False
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                ExplicitLeft = 305
                ExplicitTop = 48
                ExplicitWidth = 158
              end
            end
            object Panel13: TPanel
              Left = 305
              Top = 19
              Width = 156
              Height = 46
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 3
              object Label10: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 150
                Height = 14
                Align = alTop
                Caption = 'Valor Total Recebido'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 98
              end
              object E_Vl_Recebido: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 23
                Width = 150
                Height = 16
                Align = alTop
                Alignment = taRightJustify
                AutoSize = False
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                ExplicitLeft = 47
                ExplicitTop = 49
                ExplicitWidth = 101
              end
            end
            object Panel14: TPanel
              Left = 2
              Top = 2
              Width = 646
              Height = 17
              Align = alTop
              TabOrder = 4
              object Lb_Close_totalizador: TLabel
                Left = 636
                Top = 1
                Width = 9
                Height = 15
                Align = alRight
                Alignment = taCenter
                Caption = 'X'
                Color = clNavy
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -13
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = False
                OnClick = Lb_Close_totalizadorClick
                ExplicitHeight = 16
              end
              object Lb_Titulo_totalizador: TLabel
                Left = 1
                Top = 1
                Width = 635
                Height = 15
                Align = alClient
                AutoSize = False
                Caption = ' Totalizador do Contas '#224' Receber'
                Color = clNavy
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = False
                ExplicitWidth = 625
              end
            end
          end
        end
      end
      object Panel10: TPanel
        Left = 0
        Top = 293
        Width = 994
        Height = 60
        Align = alBottom
        TabOrder = 3
        object SB_Add_Tudo: TSpeedButton
          AlignWithMargins = True
          Left = 693
          Top = 4
          Width = 74
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Adicionar '#13'Todos'
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
            333333333333333333333333333333333333333333333333FFF3333333333333
            00333333333333FF77F3333333333300903333333333FF773733333333330099
            0333333333FF77337F3333333300999903333333FF7733337333333700999990
            3333333777333337F3333333099999903333333373F333373333333330999903
            33333333F7F3337F33333333709999033333333F773FF3733333333709009033
            333333F7737737F3333333709073003333333F77377377F33333370907333733
            33333773773337333333309073333333333337F7733333333333370733333333
            3333377733333333333333333333333333333333333333333333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          Spacing = 5
          OnClick = SB_Add_TudoClick
          ExplicitLeft = 642
          ExplicitTop = 6
        end
        object SB_Adicionar: TSpeedButton
          AlignWithMargins = True
          Left = 768
          Top = 4
          Width = 74
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Adicionar '
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
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
            333333333337F33333333333333033333333333333373F333333333333090333
            33333333337F7F33333333333309033333333333337373F33333333330999033
            3333333337F337F33333333330999033333333333733373F3333333309999903
            333333337F33337F33333333099999033333333373333373F333333099999990
            33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
            33333333337F7F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333300033333333333337773333333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          Spacing = 13
          OnClick = SB_AdicionarClick
          ExplicitLeft = 717
          ExplicitTop = 6
        end
        object SB_Retirar: TSpeedButton
          AlignWithMargins = True
          Left = 843
          Top = 4
          Width = 74
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Retirar'
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
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
            3333333333777F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
            3333333777737777F333333099999990333333373F3333373333333309999903
            333333337F33337F33333333099999033333333373F333733333333330999033
            3333333337F337F3333333333099903333333333373F37333333333333090333
            33333333337F7F33333333333309033333333333337373333333333333303333
            333333333337F333333333333330333333333333333733333333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          Spacing = 13
          OnClick = SB_RetirarClick
          ExplicitLeft = 792
          ExplicitTop = 6
        end
        object SB_Retirar_Tudo: TSpeedButton
          AlignWithMargins = True
          Left = 918
          Top = 4
          Width = 74
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Retirar '#13'Todos'
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
            333333333333333FFF3333333333333707333333333333F777F3333333333370
            9033333333F33F7737F33333373337090733333337F3F7737733333330037090
            73333333377F7737733333333090090733333333373773773333333309999073
            333333337F333773333333330999903333333333733337F33333333099999903
            33333337F3333F7FF33333309999900733333337333FF7773333330999900333
            3333337F3FF7733333333309900333333333337FF77333333333309003333333
            333337F773333333333330033333333333333773333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          Spacing = 5
          OnClick = SB_Retirar_TudoClick
          ExplicitLeft = 867
          ExplicitTop = 6
        end
        object SB_Inserir: TSpeedButton
          AlignWithMargins = True
          Left = 217
          Top = 4
          Width = 77
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
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
          Spacing = 0
          OnClick = Sb_InserirClick
          ExplicitLeft = 166
          ExplicitTop = 6
        end
        object SB_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 295
          Top = 4
          Width = 77
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Alterar - F3'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = SB_AlterarClick
          ExplicitLeft = 244
          ExplicitTop = 6
        end
        object Sb_Duplicata: TSpeedButton
          AlignWithMargins = True
          Left = 453
          Top = 4
          Width = 79
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Duplicata - F3'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_DuplicataClick
          ExplicitLeft = 402
          ExplicitTop = 6
        end
        object SB_Excluir: TSpeedButton
          AlignWithMargins = True
          Left = 373
          Top = 4
          Width = 79
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Excluir - F4'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = SB_ExcluirClick
          ExplicitLeft = 322
          ExplicitTop = 6
        end
        object SB_Buscar: TSpeedButton
          AlignWithMargins = True
          Left = 533
          Top = 4
          Width = 79
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Buscar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = SB_BuscarClick
          ExplicitTop = 6
        end
        object sb_RECIBO: TSpeedButton
          AlignWithMargins = True
          Left = 613
          Top = 4
          Width = 79
          Height = 52
          Margins.Left = 0
          Margins.Right = 1
          Align = alRight
          Caption = 'Recibo'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = sb_RECIBOClick
          ExplicitLeft = 402
          ExplicitTop = 136
          ExplicitHeight = 54
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Cheque'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 994
        Height = 353
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          994
          353)
        object Label35: TLabel
          Left = 808
          Top = 268
          Width = 88
          Height = 14
          Anchors = [akRight, akBottom]
          Caption = 'Total em Cheques:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 598
          ExplicitTop = 199
        end
        object Label18: TLabel
          Left = 9
          Top = 23
          Width = 85
          Height = 14
          Caption = 'Nome do Emitente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 330
          Top = 23
          Width = 31
          Height = 14
          Caption = 'Banco'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 367
          Top = 23
          Width = 40
          Height = 14
          Caption = 'Ag'#234'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 557
          Top = 23
          Width = 52
          Height = 14
          Caption = 'N'#186' Cheque'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 703
          Top = 23
          Width = 25
          Height = 14
          Caption = 'Valor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 617
          Top = 23
          Width = 54
          Height = 14
          Caption = 'Pr'#233'-Datado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 2
          Top = 2
          Width = 990
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'INFORMA'#199#213'ES SOBRE O PAGAMENTO COM CHEQUES'
          Color = clMenuHighlight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 467
        end
        object Label9: TLabel
          Left = 416
          Top = 23
          Width = 87
          Height = 14
          Caption = 'N'#186' conta-corrente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_VLT_Cheque: TEdit_Setes
          Left = 909
          Top = 264
          Width = 80
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          Anchors = [akRight, akBottom]
          Color = clBtnFace
          DragMode = dmAutomatic
          TabOrder = 7
          Text = '0,00'
        end
        object E_Banco: TEdit_Setes
          Left = 328
          Top = 37
          Width = 36
          Height = 21
          TabOrder = 1
          Text = ''
        end
        object E_Agencia: TEdit
          Left = 366
          Top = 37
          Width = 48
          Height = 21
          MaxLength = 7
          TabOrder = 2
        end
        object E_NumChq: TEdit_Setes
          Left = 555
          Top = 37
          Width = 59
          Height = 21
          MaxLength = 7
          TabOrder = 4
          Text = ''
        end
        object E_VL_Cheque: TEdit_Setes
          Left = 702
          Top = 37
          Width = 73
          Height = 21
          Alignment = taRightJustify
          TabOrder = 6
          Text = ''
          OnExit = E_VL_ChequeExit
        end
        object E_Emitente: TEdit
          Left = 6
          Top = 37
          Width = 321
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 40
          TabOrder = 0
        end
        object StrGrd_Cheque: TStringGrid
          Left = 5
          Top = 61
          Width = 984
          Height = 198
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clMoneyGreen
          ColCount = 17
          DefaultRowHeight = 18
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          ParentFont = False
          TabOrder = 8
          OnDrawCell = StrGrd_ChequeDrawCell
          OnKeyDown = StrGrd_ChequeKeyDown
          ColWidths = (
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64)
          RowHeights = (
            18
            18)
        end
        object Panel8: TPanel
          Left = 2
          Top = 289
          Width = 990
          Height = 62
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 9
          DesignSize = (
            990
            62)
          object Sb_GravaCheque: TSpeedButton
            Left = 677
            Top = 4
            Width = 77
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Gravar - F5'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_GravaChequeClick
            ExplicitLeft = 467
          end
          object Sb_ExcluiCheque: TSpeedButton
            Left = 600
            Top = 4
            Width = 77
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Excluir - F4'
            Enabled = False
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_ExcluiChequeClick
            ExplicitLeft = 390
          end
          object Sb_InsereCheque: TSpeedButton
            Left = 446
            Top = 4
            Width = 77
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Inserir- F2'
            Enabled = False
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_InsereChequeClick
            ExplicitLeft = 236
          end
          object Sb_AlteraCheque: TSpeedButton
            Left = 523
            Top = 4
            Width = 77
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Alterar - F3'
            Enabled = False
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_AlteraChequeClick
            ExplicitLeft = 313
          end
          object Sb_VoltaCheque: TSpeedButton
            Left = 908
            Top = 4
            Width = 77
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Voltar - ESC'
            Enabled = False
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_VoltaChequeClick
            ExplicitLeft = 698
          end
          object Sb_CancelaCheque: TSpeedButton
            Left = 754
            Top = 4
            Width = 77
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Cancelar - F6'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_CancelaChequeClick
            ExplicitLeft = 544
          end
          object Sb_leitor: TSpeedButton
            Left = 831
            Top = 4
            Width = 77
            Height = 54
            Anchors = [akRight, akBottom]
            Caption = 'Leitor'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_leitorClick
            ExplicitLeft = 621
          end
        end
        object E_DataCheque: TDateTimePicker
          Left = 615
          Top = 37
          Width = 86
          Height = 21
          Date = 39552.349847175920000000
          Time = 39552.349847175920000000
          TabOrder = 5
        end
        object E_ContaCorrente: TEdit
          Left = 414
          Top = 37
          Width = 140
          Height = 21
          MaxLength = 30
          TabOrder = 3
        end
      end
    end
    object tbs_boleto: TTabSheet
      Caption = 'Boleto'
      ImageIndex = 2
      OnShow = tbs_boletoShow
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 994
        Height = 353
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label33: TLabel
          Left = 2
          Top = 2
          Width = 990
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'INFORMA'#199#213'ES SOBRE O PAGAMENTO COM BOLETO BANC'#193'RIO'
          Color = clMenuHighlight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 381
        end
        object grb_busca_boleto: TGroupBox
          Left = 2
          Top = 15
          Width = 990
          Height = 194
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = ' Digite sua op'#231#227'o de busca '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          DesignSize = (
            990
            194)
          object Label5: TLabel
            Left = 177
            Top = 16
            Width = 45
            Height = 14
            Caption = 'N'#186' Boleto'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 364
            Top = 16
            Width = 32
            Height = 14
            Caption = 'Cliente'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_BuscaBoleto: TEdit
            Left = 173
            Top = 32
            Width = 182
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object E_Busca_Boleto_Empresa: TEdit
            Left = 359
            Top = 32
            Width = 410
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object E_Dt_Ini_Bol: TDateTimePicker
            Left = 8
            Top = 32
            Width = 80
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            Enabled = False
            TabOrder = 2
          end
          object E_Dt_Fim_Bol: TDateTimePicker
            Left = 89
            Top = 32
            Width = 82
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            Enabled = False
            TabOrder = 3
          end
          object ChBx_Periodo_b: TCheckBox
            Left = 9
            Top = 17
            Width = 128
            Height = 12
            Caption = 'Data Inicial    Data Final'
            Checked = True
            State = cbChecked
            TabOrder = 4
            OnClick = ChBx_Periodo_bClick
          end
          object DBG_Boleto: TDBGrid
            Left = 6
            Top = 56
            Width = 979
            Height = 135
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_Qr_Boleto
            Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 5
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clNavy
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            OnDblClick = DBG_BoletoDblClick
            Columns = <
              item
                Expanded = False
                FieldName = 'BLT_DATA'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
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
                FieldName = 'EMP_FANTASIA'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Title.Caption = 'Cliente'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 270
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'BLT_NUMERO'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Title.Caption = 'N'#250'mero'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 110
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CTB_COMPLETO'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Title.Caption = 'Conta Corrente'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 204
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'BLT_VALOR'
                Title.Caption = 'Valor'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 81
                Visible = True
              end>
          end
        end
        object Panel7: TPanel
          Left = 2
          Top = 289
          Width = 990
          Height = 62
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Sb_GravaBoleto: TSpeedButton
            Left = 526
            Top = 2
            Width = 77
            Height = 58
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
            Spacing = 0
            OnClick = Sb_GravaBoletoClick
            ExplicitLeft = 520
            ExplicitTop = 4
          end
          object Sb_ExcluiBoleto: TSpeedButton
            Left = 449
            Top = 2
            Width = 77
            Height = 58
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
            Spacing = 0
            OnClick = Sb_ExcluiBoletoClick
            ExplicitLeft = 448
            ExplicitTop = 8
            ExplicitHeight = 54
          end
          object Sb_InsereBoleto: TSpeedButton
            Left = 295
            Top = 2
            Width = 77
            Height = 58
            Align = alRight
            Caption = 'Inserir- F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_InsereBoletoClick
            ExplicitLeft = 294
            ExplicitTop = 1
          end
          object Sb_AlteraBoleto: TSpeedButton
            Left = 372
            Top = 2
            Width = 77
            Height = 58
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
            Spacing = 0
            OnClick = Sb_AlteraBoletoClick
            ExplicitLeft = 365
            ExplicitTop = 8
            ExplicitHeight = 54
          end
          object Sb_CancelaBoleto: TSpeedButton
            Left = 603
            Top = 2
            Width = 77
            Height = 58
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
            Spacing = 0
            OnClick = Sb_CancelaBoletoClick
            ExplicitLeft = 598
            ExplicitTop = 10
            ExplicitHeight = 54
          end
          object Sb_BuscaBoleto: TSpeedButton
            Left = 680
            Top = 2
            Width = 77
            Height = 58
            Align = alRight
            Caption = 'Buscar - F7'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_BuscaBoletoClick
            ExplicitLeft = 670
            ExplicitTop = 6
            ExplicitHeight = 54
          end
          object Sb_VoltaBoleto: TSpeedButton
            Left = 911
            Top = 2
            Width = 77
            Height = 58
            Align = alRight
            Caption = 'Voltar - ESC'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_VoltaBoletoClick
            ExplicitLeft = 913
            ExplicitTop = 6
            ExplicitHeight = 54
          end
          object Sb_Imprimir: TSpeedButton
            Left = 757
            Top = 2
            Width = 77
            Height = 58
            Align = alRight
            Caption = 'Imprimir'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_ImprimirClick
            ExplicitLeft = 751
            ExplicitTop = 6
            ExplicitHeight = 54
          end
          object Sb_BoletoPDF: TSpeedButton
            Left = 834
            Top = 2
            Width = 77
            Height = 58
            Align = alRight
            Caption = 'Gerar PDF'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFEFEFE9999993939392020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020393939999999FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF5D5D5D0C0B0B6866638987838987838987838987838987838987
              8389878389878389878389878389878389878389878389878389878389878389
              87838987836866630C0B0B5D5D5DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFB3B3B3060605B7B4B0E4E1DDEBE9E6EBE9E6EBE9E6EBE9E6EBE9E6EBE9
              E6EBE9E6EBE9E6EBE9E6EBE9E6EBE9E6EBE9E6EBE9E6EBE9E6EBE9E6EBE9E6EB
              E9E6EBE9E6E4E1DDB6B4B0060605B3B3B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF6262624D4C4BE7E4E0FDFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFDFCFCE7E4E04D4C4B626262FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF505050666563EEECE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFEEECE9666563505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF505050676765F1EFEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFECD
              C8FAF9F8FEFFFFFFF1EFED676765505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF505050696867F3F2F0D8D5FB9C94F6867CF4D3CFFBFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9C5FA8F86F5DE
              DBFCC5C0F9FFFFFFF3F2F0696867505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506A6969F5F4F3F1F0FD857BF4EAE8FD9A92F69F97F6FEFEFEFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA69EF7958BF5A8A1F787
              7CF4EDECFDFFFFFFF5F4F36A6969505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506B6A6AF7F6F5FFFFFFF8F7FEB1ABF8C8C4FAB6AFF88378F4FBFA
              FEFFFFFFFFFFFFFFFFFFFDFDFEE5E3FCBFBAF9857BF45C4EF1938AF5D8D4FBFF
              FFFFFFFFFFFFFFFFF7F6F56B6A6A505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506C6B6BF8F8F7FFFFFFFFFFFFFFFFFFFFFFFFF9F9FECBC6FA7063
              F2DBD8FBD2CFFBC1BBF9B3ACF8BEB9F9A7A0F78A80F4FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFF8F8F76C6B6B505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506C6C6CFAF9F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCC7
              FA7367F3F9F8FEFFFFFFFFFFFFFDFDFE7266F2F9F9FEFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFAF9F86C6C6C505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506D6D6CFBFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFC5C1FA766BF3FCFCFEFFFFFFCAC5FAAEA7F8FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFBFAFA6D6D6C505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506D6D6DFCFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFB5AFF8887EF4FFFFFF8E84F5EFEDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFCFBFB6D6D6D505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506E6E6EFCFCFCFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFE948AF5B4AEF88277F3FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFCFCFC6E6E6E505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506E6E6EFDFDFCFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFCFBFD7165F2776BF2FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFDFDFC6E6E6E505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506E6E6EFDFDFDFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFEFEE6E4FC6F63F2FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFDFDFD6E6E6E505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506F6F6FFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFD5748F0E8E5FBFDFDFDFDFDFDFDFDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFD6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506F6F6FFDFDFDFDFDFCFDFDFCFDFDFCFDFDFCFDFDFCFDFDFCFDFD
              FCFDFDFCFDFDFCFDFDFCFDFDFC8B81F4B7B1F7FDFDFCFDFDFCFDFDFCFDFDFCFD
              FDFCFDFDFCFDFDFCFDFDFD6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5050506F6F6FFEFDFDFCFCFBFCFCFBFCFCFBFCFCFBFCFCFBFCFCFBFCFC
              FBFCFCFBFCFCFBFCFCFBFCFCFB9288F4D2CEF8FCFCFBFCFCFBFCFCFBFCFCFBFC
              FCFBFCFCFBFCFCFBFEFDFD6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFFD3D3D3
              D0D0D04141416D6D6CFAF9F8F7F7F5F8F7F6F8F7F6F8F8F7F9F8F7F9F8F7F9F9
              F8FAF9F8FAFAF9FBFAFAFBFBFAB8B1F6D2CEF7F3F1FAFBFBFAFBFBFAFBFBFAFB
              FBFAFBFBFAFBFBFAFEFEFE6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              0000000000005F5E5BDCD8D2DBD7D0DCD9D3DEDBD6E1DED9E3E1DDE6E4E0E9E7
              E4EDEBE8F0EFECF4F3F1F7F7F5F3F2F98F85F2C6C1F6FAFAF9FAFAF9FAFAF9FA
              FAF9FAFAF9FAFAF9FEFEFD6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              00009D0000E50505EB0D0DF20D0DF20D0DF20D0DF30D0DF30D0DF30E0DF30E0E
              F40E0EF40E0EF4403FF2F3F1EFF9F8F8E6E4F6F6F5F7F9F8F8F9F8F8F9F8F8F9
              F8F8F9F8F8F9F8F8FDFDFD6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              00009B0000E13636E84141EA0000E13131E7A5A5F69191F41212E47878F00000
              E10000E10000E13332E2EEECEAF7F7F6F7F7F6F7F7F6F7F7F6F7F7F6F7F7F6F7
              F7F6F7F7F6F7F7F6FDFDFD6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              00008D0202CE5151DDC5C5F49090EB4E4EDC6969E23F3FD98D8DE9BABAF27777
              E73232D80303CE3231D1E9E7E4F6F5F3F6F5F3F6F5F3F6F5F3F6F5F3F6F5F3F6
              F5F3F6F5F3F6F5F3FDFDFC6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              00007E2222C26F6FD88F8FE1B7B7EC8787DE9494E28484DF9191E0C3C3EE6F6F
              D74F4FCF2828C43130BFE5E2DDF3F2F0F3F2F0F3F2F0F3F2F0F3F2F0F3F2F0F3
              F2F0F3F2F0F3F2F0FCFCFC6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              0000704343BC7474CDAEAEE09696D87272CCAEAEE09A9ADA5C5CC59B9BDAAEAE
              E08E8ED64F4FC0302FAEDFDCD7F1EFEDF1EFEDF1EFEDF1EFEDF1EFEDF1EFEDF1
              EFEDF1EFEDF1EFEDFCFCFB6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              0000632727A03434A63434A63434A63434A63434A63434A63434A63434A63434
              A63434A62E2EA33333A3EDEBE8EEECE9EEECE9EEECE9EEECE9EEECE9EEECE9EE
              ECE9EEECE9EEECE9FBFBFA6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF101010
              000016000020535374BCBBDCAFADCCAFADCCAFADCCAFADCCAFADCCAFADCCAFAD
              CCAFADCCAFADCCBCBAD1EAE8E4EAE8E4EAE8E4EAE8E4EAE8E4EAE8E4EAE8E4EA
              E8E4EAE8E4EAE8E4FBFAFA6F6F6F505050FFFFFFFFFFFFFFFFFFFFFFFF888888
              808080373737555555FDFDFDE8E5E1E6E3DFE6E3DFE6E3DFE6E3DFE6E3DFE6E3
              DFE6E3DFE6E3DFE6E3DFE6E3DFE6E3DFE6E3DFE6E3DFE6E3DFE6E3DFE6E3DFE6
              E3DFE6E3DFE8E5E1FDFDFD555555626262FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFB3B3B3060606CFCFCFFBFBFAF4F3F1F4F3F1F4F3F1F4F3F1F4F3F1F4F3
              F1F4F3F1F4F3F1F4F3F1F4F3F1F4F3F1F4F3F1F4F3F1F4F3F1F4F3F1F4F3F1F4
              F3F1F4F3F1FBFBFACFCFCF060606B3B3B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF5D5D5D0D0D0D7878789F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
              9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
              9F9F9F9F9F7878780D0D0D5D5D5DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFEFEFE9999993939392020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020393939999999FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF}
            Layout = blGlyphTop
            ParentFont = False
            Spacing = 0
            OnClick = Sb_BoletoPDFClick
            ExplicitLeft = 620
            ExplicitTop = 5
            ExplicitHeight = 54
          end
        end
        object Pnl_Boleto: TPanel
          Left = 2
          Top = 209
          Width = 990
          Height = 80
          Align = alClient
          Anchors = []
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 2
          object Label25: TLabel
            Left = 113
            Top = 39
            Width = 23
            Height = 14
            Caption = 'Taxa'
            FocusControl = E_BDesconto
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 162
            Top = 39
            Width = 70
            Height = 14
            Caption = 'N'#250'mero Boleto'
            FocusControl = E_NumBoleto
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 377
            Top = 39
            Width = 55
            Height = 14
            Caption = 'Valor Tarifa'
            FocusControl = E_Vl_Tarifa
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 6
            Top = 4
            Width = 187
            Height = 14
            Caption = 'Conta Banc'#225'ria - Carteira de Cobran'#231'a'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_BoletoEletronico: TSpeedButton
            Left = 751
            Top = 18
            Width = 24
            Height = 22
            Caption = '...'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            OnClick = Sb_BoletoEletronicoClick
          end
          object Label27: TLabel
            Left = 449
            Top = 39
            Width = 81
            Height = 14
            Caption = 'Data Vencimento'
            FocusControl = E_Vl_Tarifa
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_BDesconto: TEdit
            Left = 111
            Top = 54
            Width = 46
            Height = 21
            TabOrder = 2
          end
          object E_NumBoleto: TEdit
            Left = 161
            Top = 52
            Width = 210
            Height = 21
            TabOrder = 3
          end
          object E_Vl_Tarifa: TEdit
            Left = 375
            Top = 54
            Width = 67
            Height = 21
            TabOrder = 4
          end
          object RG_Descontada: TRadioGroup
            Left = 2
            Top = 38
            Width = 103
            Height = 36
            Caption = ' Descontada '
            Columns = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Items.Strings = (
              'SIM'
              'N'#195'O')
            ParentFont = False
            TabOrder = 1
          end
          object E_Blt_Vencimento: TDateTimePicker
            Left = 448
            Top = 53
            Width = 94
            Height = 21
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            TabOrder = 5
          end
          object DBLCB_CarteiraCobranca: TDBLookupComboBox
            Left = 3
            Top = 17
            Width = 742
            Height = 21
            DataField = 'BLT_CODBLE'
            KeyField = 'BLE_CODIGO'
            ListField = 'CTB_COMPLETO'
            ListSource = DM.Ds_Carteiras
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cartao'
      ImageIndex = 3
      object pnl_cartao: TPanel
        Left = 0
        Top = 0
        Width = 994
        Height = 289
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label32: TLabel
          Left = 2
          Top = 2
          Width = 990
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'INFORMA'#199#213'ES SOBRE O PAGAMENTO COM CART'#195'O DE CR'#201'DITO/DEBITO'
          Color = clMenuHighlight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 637
        end
        object pnl_cartao_dados: TPanel
          Left = 2
          Top = 22
          Width = 346
          Height = 265
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Label29: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 38
            Width = 193
            Height = 14
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Identifica'#231#227'o do Cart'#227'o'
            FocusControl = E_Identifica
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 111
          end
          object Label30: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 112
            Width = 193
            Height = 14
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Validade'
            FocusControl = E_Validade
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 41
          end
          object Label31: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 1
            Width = 340
            Height = 14
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Bandeira do Cart'#227'o'
            FocusControl = E_Validade
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 93
          end
          object Label39: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 75
            Width = 193
            Height = 14
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            Caption = 'C'#243'digo de Autoriza'#231#227'o'
            FocusControl = E_Autoriza
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 109
          end
          object Label40: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 149
            Width = 193
            Height = 14
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            Caption = 'N'#250'mero de Parcelas'
            FocusControl = E_Parcelas
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 97
          end
          object E_Identifica: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 53
            Width = 193
            Height = 21
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            TabOrder = 1
          end
          object DBLCB_Cartao: TDBLookupComboBox
            AlignWithMargins = True
            Left = 3
            Top = 16
            Width = 340
            Height = 21
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            KeyField = 'CTE_CODIGO'
            ListField = 'CTE_DESCRICAO'
            ListSource = Ds_DM_Cartao
            NullValueKey = 46
            TabOrder = 0
          end
          object E_Validade: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 127
            Width = 193
            Height = 21
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            TabOrder = 3
          end
          object E_Autoriza: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 90
            Width = 193
            Height = 21
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            TabOrder = 2
          end
          object E_Parcelas: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 164
            Width = 193
            Height = 21
            Margins.Top = 1
            Margins.Right = 150
            Margins.Bottom = 0
            Align = alTop
            TabOrder = 4
          end
        end
      end
      object pnl_cartao_botton: TPanel
        Left = 0
        Top = 289
        Width = 994
        Height = 64
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_GravarCartao: TSpeedButton
          Left = 686
          Top = 2
          Width = 77
          Height = 60
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
          Spacing = 0
          OnClick = Sb_GravarCartaoClick
          ExplicitLeft = 467
          ExplicitTop = 5
          ExplicitHeight = 54
        end
        object Sb_ExcluiCartao: TSpeedButton
          Left = 609
          Top = 2
          Width = 77
          Height = 60
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
          Spacing = 0
          OnClick = Sb_ExcluiCartaoClick
          ExplicitLeft = 547
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_InsereCartao: TSpeedButton
          Left = 455
          Top = 2
          Width = 77
          Height = 60
          Align = alRight
          Caption = 'Inserir- F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_InsereCartaoClick
          ExplicitLeft = 398
          ExplicitTop = 4
        end
        object Sb_AlteraCartao: TSpeedButton
          Left = 532
          Top = 2
          Width = 77
          Height = 60
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
          Spacing = 0
          OnClick = Sb_AlteraCartaoClick
          ExplicitLeft = 482
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_CancelarCartao: TSpeedButton
          Left = 763
          Top = 2
          Width = 77
          Height = 60
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
          Spacing = 0
          OnClick = Sb_CancelarCartaoClick
          ExplicitLeft = 544
          ExplicitTop = 5
          ExplicitHeight = 54
        end
        object Sb_VoltarCartao: TSpeedButton
          Left = 915
          Top = 2
          Width = 77
          Height = 60
          Align = alRight
          Caption = 'Voltar - ESC'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_VoltarCartaoClick
          ExplicitLeft = 696
          ExplicitTop = 5
          ExplicitHeight = 54
        end
        object Sb_ImprimirCartao: TSpeedButton
          Left = 840
          Top = 2
          Width = 75
          Height = 60
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
          OnClick = Sb_ImprimirCartaoClick
          ExplicitLeft = 621
          ExplicitTop = 5
          ExplicitHeight = 54
        end
      end
    end
  end
  object Pnl_Duplicatas: TPanel
    Left = 0
    Top = 431
    Width = 1002
    Height = 145
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Dbg_Duplicatas: TDBGrid
      Left = 2
      Top = 2
      Width = 998
      Height = 141
      Align = alClient
      DataSource = ds_duplicatas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = Dbg_DuplicatasDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'PED_NUMERO'
          Title.Caption = 'Pedido'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NFL_NUMERO'
          Title.Caption = 'Nota Fiscal'
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FIN_NUMERO'
          Title.Caption = 'Duplicata'
          Width = 129
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FIN_DT_VENCIMENTO'
          Title.Caption = 'Vencimento'
          Width = 86
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FIN_VL_PARCELA'
          Title.Caption = 'Valor Parcela'
          Width = 114
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FIN_VL_PAGO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'FIN_DT_PAGTO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'EMP_FANTASIA'
          Title.Caption = 'Fantasia'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'EMP_NOME'
          Title.Caption = 'Nome/Raz'#227'o Social'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PLC_DESCRICAO'
          Title.Caption = 'Conta Gerencial'
          Visible = True
        end>
    end
  end
  object Pnl_Total: TPanel
    Left = 0
    Top = 576
    Width = 1002
    Height = 42
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      1002
      42)
    object Label23: TLabel
      Left = 611
      Top = 2
      Width = 78
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Valor '#224' Receber'
      FocusControl = E_VL_Pagar
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 401
    end
    object Label14: TLabel
      Left = 412
      Top = 2
      Width = 27
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Juros'
      FocusControl = E_VL_Juros
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 202
    end
    object Label6: TLabel
      Left = 487
      Top = 2
      Width = 52
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Multa/Mora'
      FocusControl = E_VL_Juros
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 277
    end
    object Label15: TLabel
      Left = 551
      Top = 2
      Width = 46
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Desconto'
      FocusControl = E_VL_Desconto
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 341
    end
    object Label16: TLabel
      Left = 780
      Top = 2
      Width = 52
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Valor Pago'
      FocusControl = E_VL_Pago
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 570
    end
    object Label24: TLabel
      Left = 694
      Top = 2
      Width = 78
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Data Pagamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 484
    end
    object Lb_Saldo_Parcial: TLabel
      Left = 866
      Top = 2
      Width = 127
      Height = 14
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Saldo para Baixa Parcial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 656
    end
    object E_Vl_Saldo: TLabel
      Left = 893
      Top = 16
      Width = 100
      Height = 19
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 683
    end
    object E_VL_Pagar: TEdit_Setes
      Left = 612
      Top = 15
      Width = 77
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Color = clMenu
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = '0,00'
    end
    object E_VL_Juros: TEdit_Setes
      Left = 410
      Top = 15
      Width = 73
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      TabOrder = 0
      Text = ''
      OnEnter = E_VL_JurosEnter
      OnExit = E_VL_JurosExit
    end
    object E_VL_Mora: TEdit_Setes
      Left = 485
      Top = 15
      Width = 64
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      TabOrder = 1
      Text = ''
      OnEnter = E_VL_MoraEnter
      OnExit = E_VL_MoraExit
    end
    object E_VL_Desconto: TEdit_Setes
      Left = 548
      Top = 15
      Width = 63
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      TabOrder = 2
      Text = ''
      OnEnter = E_VL_DescontoEnter
      OnExit = E_VL_DescontoExit
    end
    object E_VL_Pago: TEdit_Setes
      Left = 779
      Top = 15
      Width = 77
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      TabOrder = 4
      Text = ''
      OnChange = E_VL_PagoChange
      OnExit = E_VL_PagoExit
    end
    object E_Dt_Pagto: TDateTimePicker
      Left = 692
      Top = 15
      Width = 85
      Height = 22
      Anchors = [akRight, akBottom]
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 5
    end
    inline Fm_TipoRecebimento: TFm_FormaPagto
      Left = 4
      Top = 1
      Width = 191
      Height = 38
      TabOrder = 6
      ExplicitLeft = 4
      ExplicitTop = 1
      ExplicitWidth = 191
      ExplicitHeight = 38
      inherited Lb_FormaPagamento: TLabel
        Width = 185
        Caption = 'Tipo de Recebimento'
        ExplicitWidth = 100
      end
      inherited pnl_Forma: TPanel
        Width = 191
        Height = 24
        ExplicitWidth = 191
        ExplicitHeight = 24
        inherited SB_FormaPag: TSpeedButton
          Left = 165
          Height = 21
          OnClick = Fm_TipoRecebimentoSB_FormaPagClick
          ExplicitLeft = 200
          ExplicitTop = 13
          ExplicitHeight = 21
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 156
          OnClick = Fm_TipoRecebimentoDBLCB_FormaPagtoClick
          ExplicitWidth = 156
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 618
    Width = 1002
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 920
      Top = 3
      Width = 77
      Height = 56
      Margins.Left = 1
      Margins.Top = 1
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
      Spacing = 0
      OnClick = SB_Sair_0Click
      ExplicitLeft = 932
      ExplicitTop = 4
    end
    object Sb_Baixar: TSpeedButton
      AlignWithMargins = True
      Left = 762
      Top = 3
      Width = 77
      Height = 56
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Baixar - F9'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_BaixarClick
      ExplicitLeft = 772
      ExplicitTop = 4
    end
    object SB_Boleto: TSpeedButton
      AlignWithMargins = True
      Left = 604
      Top = 3
      Width = 77
      Height = 56
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Boleto - F6'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = SB_BoletoClick
      ExplicitTop = 4
    end
    object Sb_Cheque: TSpeedButton
      AlignWithMargins = True
      Left = 525
      Top = 3
      Width = 77
      Height = 56
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Cheque - F5'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_ChequeClick
      ExplicitLeft = 324
      ExplicitTop = 4
      ExplicitHeight = 54
    end
    object Sb_Destinar: TSpeedButton
      AlignWithMargins = True
      Left = 683
      Top = 3
      Width = 77
      Height = 56
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Destinar - F8'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_DestinarClick
      ExplicitTop = 4
    end
    object Sb_Cartao: TSpeedButton
      AlignWithMargins = True
      Left = 446
      Top = 3
      Width = 77
      Height = 56
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Cart'#227'o - F4'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_CartaoClick
      ExplicitLeft = 472
      ExplicitTop = 0
      ExplicitHeight = 58
    end
    object Sb_Negociar: TSpeedButton
      AlignWithMargins = True
      Left = 841
      Top = 3
      Width = 77
      Height = 56
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Negociar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_NegociarClick
      ExplicitLeft = 785
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 1002
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      1002
      50)
    object chbx_Empresas: TCheckBox
      Left = 7
      Top = 8
      Width = 165
      Height = 14
      Caption = 'Selecionar todas as Empresas'
      TabOrder = 0
      OnClick = chbx_EmpresasClick
    end
    object Dblcb_Mha_Empresa: TDBLookupComboBox
      Left = 5
      Top = 24
      Width = 990
      Height = 21
      Anchors = [akLeft, akRight]
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
      TabOrder = 1
    end
  end
  object Qr_Parcelas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT '
      '   FIN_CODIGO, '
      '   NFL_NUMERO, '
      '   NFL_MODELO, '
      '   PED_NUMERO, '
      '   FIN_NUMERO, '
      '   FIN_DT_VENCIMENTO, '
      '   FIN_NR_PARCELA, '
      '   FIN_CODEMP, '
      '   EMP_FANTASIA, '
      '   EMP_NOME, '
      '   FIN_VL_PARCELA, '
      '   FIN_BAIXA, '
      '   FIN_SITUACAO, '
      '   FIN_VL_PAGO, '
      '   FIN_CODQTC, '
      '   FIN_CODFPG, '
      '   PED_CODIGO, '
      '   NFL_CODIGO, '
      '   FIN_TIPO, '
      '   FIN_DT_PAGTO, '
      '   FIN_OPERACAO, '
      '   FIN_ETAPA, '
      '   FIN_CODMHA, '
      '   FIN_CODCHQ, '
      '   PLC_CODIGO, '
      '   PLC_DESCRICAO, '
      '   FIN_DT_REPROGRAMADA '
      ' FROM TB_FINANCEIRO tb_financeiro '
      '   INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '
      '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)  '
      '   LEFT OUTER JOIN TB_PEDIDO tb_pedido '
      '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '
      '   INNER JOIN TB_EMPRESA tb_empresa '
      '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '
      '   LEFT OUTER JOIN TB_PLANOCONTAS '
      '   ON (PLC_CODIGO = tb_financeiro.FIN_PLC_DEBITO) '
      'where fin_codigo = 1')
    Left = 15
    Top = 399
  end
  object Ds_Parcelas: TDataSource
    DataSet = cds_Parcelas
    OnDataChange = Ds_ParcelasDataChange
    Left = 584
    Top = 458
  end
  object Qr_Boleto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_BoletoAfterOpen
    AfterScroll = Qr_BoletoAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT BLT_CODIGO, BLT_CODEMP,   BLT_NUMERO, BLT_DATA, BLT_CODCT' +
        'B, '
      
        'BLT_DESCONTO, BLT_TX_DESCONTO, BLT_BAIXA, BLT_VALOR, BLT_CODQTC ' +
        ','
      
        ' (tb_banco.EMP_FANTASIA || '#39' - '#39' || CTB_AGENCIA || '#39' - '#39' || CTB_' +
        'CONTA) CTB_COMPLETO,tb_empresa.EMP_FANTASIA'
      'FROM  TB_BOLETO Tb_boleto '
      '    INNER JOIN TB_CONTABANCARIA tb_contabancaria'
      '    ON (tb_contabancaria.CTB_CODIGO = tb_boleto.BLT_CODCTB)'
      '    INNER JOIN TB_EMPRESA tb_banco'
      '   ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO)'
      '    INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_boleto.BLT_CODEMP)'
      '  WHERE (BLT_CODIGO IS NOT NULL ) ')
    Left = 440
    Top = 402
  end
  object Ds_Qr_Boleto: TDataSource
    DataSet = Qr_Boleto
    Left = 440
    Top = 450
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'INSERT INTO TB_CHQ_ORIG ('
      '  CHO_CODCHQ, '
      '  CHO_CODCLI, '
      '  CHO_CODOVS,'
      '  CHO_CODDUP, '
      '  CHO_NR_PARC,'
      '  CHO_VL_DOC)'
      'VALUES ('
      '  :CHO_CODCHQ, '
      '  :CHO_CODCLI, '
      '  :CHO_CODOVS,'
      '  :CHO_CODDUP, '
      '  :CHO_NR_PARC,'
      '  :CHO_VL_DOC)')
    Left = 104
    Top = 402
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CHO_CODCHQ'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CHO_CODCLI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CHO_CODOVS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CHO_CODDUP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CHO_NR_PARC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CHO_VL_DOC'
        ParamType = ptUnknown
      end>
  end
  object Ds_ContaBancaria: TDataSource
    Left = 64
    Top = 449
  end
  object Qr_Cheques: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM  TB_CHEQUES Tb_cheques'
      '  WHERE (CHQ_CODIGO IS NOT NULL ) ')
    Left = 368
    Top = 402
  end
  object Ds_Cheque: TDataSource
    DataSet = Qr_Cheques
    Left = 368
    Top = 450
  end
  object PpM_Duplicata: TPopupMenu
    Left = 100
    Top = 259
    object RetirarDestinao1: TMenuItem
      Caption = 'Retirar Destina'#231#227'o'
      OnClick = RetirarDestinao1Click
    end
    object VisualizarPedido1: TMenuItem
      Caption = 'Visualizar Pedido'
      OnClick = VisualizarPedido1Click
    end
    object Observaes1: TMenuItem
      Caption = 'Observa'#231#245'es'
      OnClick = Observaes1Click
    end
    object AplicarPlanoContas1: TMenuItem
      Caption = 'Aplicar Plano Contas'
      OnClick = AplicarPlanoContas1Click
    end
    object InativarInativar1: TMenuItem
      Caption = 'Ativar/Inativar'
      OnClick = InativarInativar1Click
    end
    object CalcularComissao1: TMenuItem
      Caption = 'Calcular Comissao'
      OnClick = CalcularComissao1Click
    end
  end
  object Ds_DM_Cartao: TDataSource
    DataSet = DM.Qr_Cartao
    Left = 240
    Top = 458
  end
  object Qr_Empresa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_CNPJ,'
      '  EMP_INSC_EST,'
      '  EMP_EMAIL,'
      '  END_ENDER,'
      '  END_COMPLEM,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_NUMERO,'
      '  CDD_DESCRICAO,'
      '  END_CONTATO,'
      '  END_FONE,'
      '  END_FAX,'
      '   UFE_SIGLA'
      'FROM TB_EMPRESA tb_empresa'
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '         INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '   WHERE (EMP_CODIGO =:EMP_CODIGO)')
    Left = 296
    Top = 403
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object cheque: TACBrCMC7
    Left = 728
    Top = 425
  end
  object cds_Parcelas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 588
    Top = 410
    object cds_ParcelasFIN_CODIGO: TIntegerField
      FieldName = 'FIN_CODIGO'
      Origin = '"TB_FINANCEIRO"."FIN_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_ParcelasNFL_NUMERO: TWideStringField
      FieldName = 'NFL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_NUMERO"'
      Size = 10
    end
    object cds_ParcelasNFL_MODELO: TWideStringField
      FieldName = 'NFL_MODELO'
      Origin = '"TB_NOTA_FISCAL"."NFL_MODELO"'
      Size = 2
    end
    object cds_ParcelasPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object cds_ParcelasFIN_NUMERO: TWideStringField
      FieldName = 'FIN_NUMERO'
      Origin = '"TB_FINANCEIRO"."FIN_NUMERO"'
    end
    object cds_ParcelasFIN_DT_VENCIMENTO: TDateField
      FieldName = 'FIN_DT_VENCIMENTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_VENCIMENTO"'
    end
    object cds_ParcelasFIN_NR_PARCELA: TIntegerField
      FieldName = 'FIN_NR_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_NR_PARCELA"'
    end
    object cds_ParcelasFIN_CODEMP: TIntegerField
      FieldName = 'FIN_CODEMP'
      Origin = '"TB_FINANCEIRO"."FIN_CODEMP"'
    end
    object cds_ParcelasEMP_FANTASIA: TWideStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object cds_ParcelasEMP_NOME: TWideStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object cds_ParcelasFIN_VL_PARCELA: TBCDField
      FieldName = 'FIN_VL_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PARCELA"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_ParcelasFIN_BAIXA: TWideStringField
      FieldName = 'FIN_BAIXA'
      Origin = '"TB_FINANCEIRO"."FIN_BAIXA"'
      Size = 1
    end
    object cds_ParcelasFIN_SITUACAO: TWideStringField
      FieldName = 'FIN_SITUACAO'
      Origin = '"TB_FINANCEIRO"."FIN_SITUACAO"'
      Size = 1
    end
    object cds_ParcelasFIN_VL_PAGO: TBCDField
      FieldName = 'FIN_VL_PAGO'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PAGO"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_ParcelasFIN_CODQTC: TIntegerField
      FieldName = 'FIN_CODQTC'
      Origin = '"TB_FINANCEIRO"."FIN_CODQTC"'
    end
    object cds_ParcelasFIN_CODFPG: TIntegerField
      FieldName = 'FIN_CODFPG'
      Origin = '"TB_FINANCEIRO"."FIN_CODFPG"'
    end
    object cds_ParcelasPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cds_ParcelasNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_ParcelasFIN_TIPO: TWideStringField
      FieldName = 'FIN_TIPO'
      Origin = '"TB_FINANCEIRO"."FIN_TIPO"'
      Size = 2
    end
    object cds_ParcelasFIN_DT_PAGTO: TDateField
      FieldName = 'FIN_DT_PAGTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_PAGTO"'
    end
    object cds_ParcelasFIN_OPERACAO: TWideStringField
      FieldName = 'FIN_OPERACAO'
      Origin = '"TB_FINANCEIRO"."FIN_OPERACAO"'
      Size = 1
    end
    object cds_ParcelasFIN_ETAPA: TWideStringField
      FieldName = 'FIN_ETAPA'
      Origin = '"TB_FINANCEIRO"."FIN_ETAPA"'
      Size = 1
    end
    object cds_ParcelasFIN_CODMHA: TIntegerField
      FieldName = 'FIN_CODMHA'
      Origin = '"TB_FINANCEIRO"."FIN_CODMHA"'
    end
    object cds_ParcelasFIN_CODCHQ: TIntegerField
      FieldName = 'FIN_CODCHQ'
      Origin = '"TB_FINANCEIRO"."FIN_CODCHQ"'
    end
    object cds_ParcelasPLC_CODIGO: TIntegerField
      FieldName = 'PLC_CODIGO'
      Origin = '"TB_PLANOCONTAS"."PLC_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cds_ParcelasPLC_DESCRICAO: TWideStringField
      FieldName = 'PLC_DESCRICAO'
      Origin = '"TB_PLANOCONTAS"."PLC_DESCRICAO"'
      Size = 100
    end
    object cds_ParcelasFIN_DT_REPROGRAMADA: TDateField
      FieldName = 'FIN_DT_REPROGRAMADA'
      Origin = '"TB_FINANCEIRO"."FIN_DT_REPROGRAMADA"'
    end
    object cds_ParcelasPED_DT_ALTERA: TDateTimeField
      FieldName = 'PED_DT_ALTERA'
    end
  end
  object cds_duplicatas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 668
    Top = 410
    object cds_duplicatasFIN_CODIGO: TIntegerField
      FieldName = 'FIN_CODIGO'
      Origin = '"TB_FINANCEIRO"."FIN_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_duplicatasNFL_NUMERO: TWideStringField
      FieldName = 'NFL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_NUMERO"'
      Size = 10
    end
    object cds_duplicatasNFL_MODELO: TWideStringField
      FieldName = 'NFL_MODELO'
      Origin = '"TB_NOTA_FISCAL"."NFL_MODELO"'
      Size = 2
    end
    object cds_duplicatasPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object cds_duplicatasFIN_NUMERO: TWideStringField
      FieldName = 'FIN_NUMERO'
      Origin = '"TB_FINANCEIRO"."FIN_NUMERO"'
    end
    object cds_duplicatasFIN_DT_VENCIMENTO: TDateField
      FieldName = 'FIN_DT_VENCIMENTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_VENCIMENTO"'
    end
    object cds_duplicatasFIN_NR_PARCELA: TIntegerField
      FieldName = 'FIN_NR_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_NR_PARCELA"'
    end
    object cds_duplicatasFIN_CODEMP: TIntegerField
      FieldName = 'FIN_CODEMP'
      Origin = '"TB_FINANCEIRO"."FIN_CODEMP"'
    end
    object cds_duplicatasEMP_FANTASIA: TWideStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object cds_duplicatasEMP_NOME: TWideStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object cds_duplicatasFIN_VL_PARCELA: TBCDField
      FieldName = 'FIN_VL_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PARCELA"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_duplicatasFIN_BAIXA: TWideStringField
      FieldName = 'FIN_BAIXA'
      Origin = '"TB_FINANCEIRO"."FIN_BAIXA"'
      Size = 1
    end
    object cds_duplicatasFIN_SITUACAO: TWideStringField
      FieldName = 'FIN_SITUACAO'
      Origin = '"TB_FINANCEIRO"."FIN_SITUACAO"'
      Size = 1
    end
    object cds_duplicatasFIN_VL_PAGO: TBCDField
      FieldName = 'FIN_VL_PAGO'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PAGO"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_duplicatasFIN_CODQTC: TIntegerField
      FieldName = 'FIN_CODQTC'
      Origin = '"TB_FINANCEIRO"."FIN_CODQTC"'
    end
    object cds_duplicatasFIN_CODFPG: TIntegerField
      FieldName = 'FIN_CODFPG'
      Origin = '"TB_FINANCEIRO"."FIN_CODFPG"'
    end
    object cds_duplicatasPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cds_duplicatasNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_duplicatasFIN_TIPO: TWideStringField
      FieldName = 'FIN_TIPO'
      Origin = '"TB_FINANCEIRO"."FIN_TIPO"'
      Size = 2
    end
    object cds_duplicatasFIN_DT_PAGTO: TDateField
      FieldName = 'FIN_DT_PAGTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_PAGTO"'
    end
    object cds_duplicatasFIN_OPERACAO: TWideStringField
      FieldName = 'FIN_OPERACAO'
      Origin = '"TB_FINANCEIRO"."FIN_OPERACAO"'
      Size = 1
    end
    object cds_duplicatasFIN_ETAPA: TWideStringField
      FieldName = 'FIN_ETAPA'
      Origin = '"TB_FINANCEIRO"."FIN_ETAPA"'
      Size = 1
    end
    object cds_duplicatasFIN_CODMHA: TIntegerField
      FieldName = 'FIN_CODMHA'
      Origin = '"TB_FINANCEIRO"."FIN_CODMHA"'
    end
    object cds_duplicatasFIN_CODCHQ: TIntegerField
      FieldName = 'FIN_CODCHQ'
      Origin = '"TB_FINANCEIRO"."FIN_CODCHQ"'
    end
    object cds_duplicatasPLC_CODIGO: TIntegerField
      FieldName = 'PLC_CODIGO'
      Origin = '"TB_PLANOCONTAS"."PLC_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cds_duplicatasPLC_DESCRICAO: TWideStringField
      FieldName = 'PLC_DESCRICAO'
      Origin = '"TB_PLANOCONTAS"."PLC_DESCRICAO"'
      Size = 100
    end
    object cds_duplicatasFIN_DT_REPROGRAMADA: TDateField
      FieldName = 'FIN_DT_REPROGRAMADA'
      Origin = '"TB_FINANCEIRO"."FIN_DT_REPROGRAMADA"'
    end
    object cds_duplicatasPED_DT_ALTERA: TDateTimeField
      FieldName = 'PED_DT_ALTERA'
    end
  end
  object ds_duplicatas: TDataSource
    DataSet = cds_duplicatas
    OnDataChange = Ds_ParcelasDataChange
    Left = 664
    Top = 458
  end
end
