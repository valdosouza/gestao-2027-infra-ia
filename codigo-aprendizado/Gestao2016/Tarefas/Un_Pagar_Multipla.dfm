object Fr_Pagar_Multipla: TFr_Pagar_Multipla
  Left = 333
  Top = 40
  BorderStyle = bsSingle
  Caption = 'Controle de Lan'#231'amentos e Baixas no Contas a Pagar'
  ClientHeight = 614
  ClientWidth = 936
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
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
    Width = 936
    Height = 312
    ActivePage = tbs_boleto
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Busca'
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 928
        Height = 94
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          928
          94)
        object Label12: TLabel
          Left = 172
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
          Left = 255
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
          Left = 343
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
        object L_CodigoFornecedor: TLabel
          Left = 423
          Top = 15
          Width = 61
          Height = 14
          Caption = 'C'#243'digo Forn.'
        end
        object Sb_Resumo: TSpeedButton
          Left = 784
          Top = 60
          Width = 140
          Height = 28
          Anchors = [akTop, akRight]
          Caption = 'Resumo Contas '#224' Pagar'
          OnClick = Sb_ResumoClick
          ExplicitLeft = 814
        end
        object Label36: TLabel
          Left = 178
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
        object Sb_Pesq_Empresa: TSpeedButton
          Left = 757
          Top = 28
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
        inline Fm_TipoCobranca: TFm_FormaPagto
          Left = 350
          Top = 51
          Width = 209
          Height = 39
          TabOrder = 12
          ExplicitLeft = 350
          ExplicitTop = 51
          ExplicitWidth = 209
          ExplicitHeight = 39
          inherited Lb_FormaPagamento: TLabel
            Width = 203
          end
          inherited pnl_Forma: TPanel
            Width = 209
            Height = 25
            ExplicitWidth = 209
            ExplicitHeight = 25
            inherited SB_FormaPag: TSpeedButton
              Left = 183
              Height = 22
              ExplicitLeft = 184
              ExplicitHeight = 22
            end
            inherited DBLCB_FormaPagto: TDBLookupComboBox
              Width = 174
              Height = 22
              ExplicitWidth = 174
              ExplicitHeight = 22
            end
          end
        end
        object E_BuscaPedido: TEdit_Setes
          Left = 170
          Top = 28
          Width = 84
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = ''
        end
        object E_Busca_Empresa: TEdit
          Left = 487
          Top = 28
          Width = 268
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
          Left = 255
          Top = 28
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 8
          ParentFont = False
          TabOrder = 4
        end
        object E_BuscaFinanceiro: TEdit
          Left = 343
          Top = 28
          Width = 80
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object ChBx_Nome: TCheckBox
          Left = 487
          Top = 9
          Width = 121
          Height = 17
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = ChBx_NomeClick
        end
        object ChBx_Fantasia: TCheckBox
          Left = 617
          Top = 9
          Width = 121
          Height = 17
          Caption = 'Apelido/Fantasia'
          TabOrder = 8
          OnClick = ChBx_FantasiaClick
        end
        object Rg_Data: TRadioGroup
          Left = 4
          Top = 50
          Width = 167
          Height = 35
          Caption = 'Tipo de Data'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Vencimento'
            'Pagamento')
          TabOrder = 9
          OnClick = Rg_DataClick
        end
        object E_Data_Ini: TDateTimePicker
          Left = 4
          Top = 28
          Width = 79
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 0
        end
        object E_Data_Fim: TDateTimePicker
          Left = 85
          Top = 28
          Width = 81
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 1
        end
        object ChBx_Periodo: TCheckBox
          Left = 7
          Top = 15
          Width = 128
          Height = 12
          Caption = 'Data Inicial    Data Final'
          Checked = True
          State = cbChecked
          TabOrder = 10
          OnClick = ChBx_PeriodoClick
        end
        object E_Busca_Cd_Empresa: TEdit
          Left = 423
          Top = 28
          Width = 63
          Height = 22
          TabOrder = 2
          OnExit = E_Busca_Cd_EmpresaExit
        end
        object Cb_Situacao: TComboBox
          Left = 177
          Top = 64
          Width = 169
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 11
          Text = 'Normais'
          OnChange = Cb_SituacaoChange
          Items.Strings = (
            'Normais'
            'Destinadas'
            'Baixadas'
            'Inativas'
            'Todas')
        end
        object Rg_Doc_Authorization: TRadioGroup
          Left = 565
          Top = 53
          Width = 215
          Height = 35
          Caption = 'Documento Autorizado'
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'SIM'
            'N'#227'o'
            'Todos')
          TabOrder = 13
          OnClick = Rg_Doc_AuthorizationClick
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 230
        Width = 928
        Height = 54
        Align = alBottom
        TabOrder = 1
        object SB_Add_Tudo: TSpeedButton
          AlignWithMargins = True
          Left = 463
          Top = 4
          Width = 116
          Height = 46
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
          Caption = 'Adicionar Todos'
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
          Spacing = 13
          OnClick = SB_Add_TudoClick
          ExplicitLeft = 313
          ExplicitTop = -2
          ExplicitHeight = 54
        end
        object SB_Adicionar: TSpeedButton
          AlignWithMargins = True
          Left = 579
          Top = 4
          Width = 116
          Height = 46
          Margins.Left = 0
          Margins.Right = 0
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
          ExplicitLeft = 525
          ExplicitTop = 6
        end
        object SB_Retirar: TSpeedButton
          AlignWithMargins = True
          Left = 695
          Top = 4
          Width = 116
          Height = 46
          Margins.Left = 0
          Margins.Right = 0
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
          ExplicitLeft = 551
          ExplicitTop = 6
        end
        object SB_Retirar_Tudo: TSpeedButton
          AlignWithMargins = True
          Left = 811
          Top = 4
          Width = 116
          Height = 46
          Margins.Left = 0
          Margins.Right = 0
          Align = alRight
          Caption = 'Retirar Todos'
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
          Spacing = 13
          OnClick = SB_Retirar_TudoClick
          ExplicitLeft = 757
          ExplicitTop = 6
        end
        object Sb_Inserir: TSpeedButton
          AlignWithMargins = True
          Left = 151
          Top = 4
          Width = 77
          Height = 46
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
          Spacing = 0
          OnClick = Sb_InserirClick
          ExplicitLeft = 1
          ExplicitTop = -2
          ExplicitHeight = 54
        end
        object SB_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 228
          Top = 4
          Width = 77
          Height = 46
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
          Spacing = 0
          OnClick = SB_AlterarClick
          ExplicitLeft = 87
          ExplicitTop = 20
          ExplicitHeight = 54
        end
        object SB_Excluir: TSpeedButton
          AlignWithMargins = True
          Left = 305
          Top = 4
          Width = 79
          Height = 46
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
          Spacing = 0
          OnClick = SB_ExcluirClick
          ExplicitLeft = 158
          ExplicitTop = 132
          ExplicitHeight = 54
        end
        object SB_Buscar: TSpeedButton
          AlignWithMargins = True
          Left = 384
          Top = 4
          Width = 79
          Height = 46
          Margins.Left = 0
          Margins.Right = 0
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
          ExplicitLeft = 330
          ExplicitTop = 6
        end
      end
      object Dbg_Parcela: TDBGrid
        Left = 0
        Top = 94
        Width = 928
        Height = 136
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
        OnDblClick = SB_AdicionarClick
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
            FieldName = 'PLC_DESCRICAO'
            Title.Caption = 'Conta Gerencial'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'FIN_AUTORIZADO'
            Title.Caption = 'Autroizado'
            Visible = True
          end>
      end
      object Pg_Observacao: TPageControl
        Left = 80
        Top = 95
        Width = 658
        Height = 95
        ActivePage = TabSheet5
        TabOrder = 3
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
            object Panel6: TPanel
              Left = 2
              Top = 19
              Width = 156
              Height = 46
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object Label2: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 150
                Height = 14
                Align = alTop
                Caption = 'Valor Total Contas '#224' Pagar'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 127
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
                Caption = 'Valor Total Cr'#233'ditos a Cobrar'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 138
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
                Caption = 'Saldo Total do Contas '#224' Pagar'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 144
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
                Caption = 'Valor Total Pago'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 77
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
    end
    object TabSheet4: TTabSheet
      Caption = 'Cheque'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 928
        Height = 284
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          928
          284)
        object Label35: TLabel
          Left = 738
          Top = 204
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
          ExplicitLeft = 594
          ExplicitTop = 206
        end
        object Sb_Terceiro: TSpeedButton
          Left = 766
          Top = 225
          Width = 77
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Terceiro - F11'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_TerceiroClick
          ExplicitLeft = 622
          ExplicitTop = 227
        end
        object Sb_GravaCheque: TSpeedButton
          Left = 612
          Top = 225
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
          ExplicitLeft = 468
          ExplicitTop = 227
        end
        object Sb_ExcluiCheque: TSpeedButton
          Left = 535
          Top = 225
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
          ExplicitLeft = 391
          ExplicitTop = 227
        end
        object Sb_InsereCheque: TSpeedButton
          Left = 380
          Top = 225
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
          ExplicitTop = 227
        end
        object Sb_AlteraCheque: TSpeedButton
          Left = 457
          Top = 225
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
          ExplicitTop = 227
        end
        object Sb_VoltaCheque: TSpeedButton
          Left = 843
          Top = 225
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
          ExplicitLeft = 699
          ExplicitTop = 227
        end
        object Sb_CancelaCheque: TSpeedButton
          Left = 689
          Top = 225
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
          ExplicitLeft = 545
          ExplicitTop = 227
        end
        object Label18: TLabel
          Left = 9
          Top = 4
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
          Left = 379
          Top = 4
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
          Left = 416
          Top = 4
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
          Top = 4
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
          Top = 4
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
          Top = 4
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
        object Label9: TLabel
          Left = 465
          Top = 4
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
          Left = 839
          Top = 200
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
        object StrGrd_Cheque: TStringGrid
          Left = 6
          Top = 46
          Width = 913
          Height = 149
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
        object E_Banco: TEdit_Setes
          Left = 377
          Top = 18
          Width = 36
          Height = 21
          TabOrder = 1
          Text = ''
        end
        object E_Agencia: TEdit_Setes
          Left = 415
          Top = 18
          Width = 48
          Height = 21
          MaxLength = 7
          TabOrder = 2
          Text = ''
        end
        object E_NumChq: TEdit_Setes
          Left = 555
          Top = 18
          Width = 59
          Height = 21
          MaxLength = 7
          TabOrder = 4
          Text = ''
        end
        object E_VL_Cheque: TEdit_Setes
          Left = 702
          Top = 18
          Width = 73
          Height = 21
          Alignment = taRightJustify
          TabOrder = 6
          Text = ''
          OnExit = E_VL_ChequeExit
        end
        object E_Emitente: TEdit
          Left = 6
          Top = 18
          Width = 369
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 40
          TabOrder = 0
        end
        object E_DataCheque: TDateTimePicker
          Left = 615
          Top = 18
          Width = 86
          Height = 21
          Date = 39552.349847175920000000
          Time = 39552.349847175920000000
          TabOrder = 5
        end
        object E_ContaCorrente: TEdit
          Left = 463
          Top = 18
          Width = 91
          Height = 21
          MaxLength = 7
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
        Width = 928
        Height = 176
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object GroupBox4: TGroupBox
          Left = 2
          Top = 2
          Width = 924
          Height = 172
          Align = alClient
          Caption = ' Digite sua op'#231#227'o de busca '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            924
            172)
          object Label5: TLabel
            Left = 178
            Top = 18
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
            Left = 360
            Top = 18
            Width = 56
            Height = 14
            Caption = 'Fornecedor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_BuscaBoleto: TEdit
            Left = 172
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
          object E_BuscaBoletoEmpresa: TEdit
            Left = 358
            Top = 32
            Width = 404
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
            TabOrder = 4
            OnClick = ChBx_Periodo_bClick
          end
          object DBG_Boleto: TDBGrid
            Left = 3
            Top = 60
            Width = 906
            Height = 108
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
      end
      object pnl_boleto_bottom: TPanel
        Left = 0
        Top = 224
        Width = 928
        Height = 60
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_GravaBoleto: TSpeedButton
          Left = 618
          Top = 2
          Width = 77
          Height = 56
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
          ExplicitLeft = 612
          ExplicitTop = 30
          ExplicitHeight = 54
        end
        object Sb_ExcluiBoleto: TSpeedButton
          Left = 541
          Top = 2
          Width = 77
          Height = 56
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
          ExplicitLeft = 535
          ExplicitTop = 30
          ExplicitHeight = 54
        end
        object Sb_InsereBoleto: TSpeedButton
          Left = 387
          Top = 2
          Width = 77
          Height = 56
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
          ExplicitLeft = 375
          ExplicitTop = 30
          ExplicitHeight = 54
        end
        object Sb_AlteraBoleto: TSpeedButton
          Left = 464
          Top = 2
          Width = 77
          Height = 56
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
          ExplicitLeft = 458
          ExplicitTop = 30
          ExplicitHeight = 54
        end
        object Sb_CancelaBoleto: TSpeedButton
          Left = 695
          Top = 2
          Width = 77
          Height = 56
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
          ExplicitLeft = 689
          ExplicitTop = 30
          ExplicitHeight = 54
        end
        object Sb_BuscaBoleto: TSpeedButton
          Left = 772
          Top = 2
          Width = 77
          Height = 56
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
          ExplicitLeft = 766
          ExplicitTop = 30
          ExplicitHeight = 54
        end
        object Sb_VoltaBoleto: TSpeedButton
          Left = 849
          Top = 2
          Width = 77
          Height = 56
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
          Spacing = 13
          OnClick = Sb_VoltaBoletoClick
          ExplicitLeft = 843
          ExplicitTop = 30
          ExplicitHeight = 54
        end
      end
      object pnl_boleto_fundo: TPanel
        Left = 0
        Top = 176
        Width = 928
        Height = 48
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        DesignSize = (
          928
          48)
        object Label25: TLabel
          Left = 637
          Top = 5
          Width = 23
          Height = 14
          Anchors = [akRight, akBottom]
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
          Left = 708
          Top = 5
          Width = 70
          Height = 14
          Anchors = [akRight, akBottom]
          Caption = 'N'#250'mero Boleto'
          FocusControl = E_NumBoleto
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BDesconto: TEdit
          Left = 635
          Top = 21
          Width = 68
          Height = 21
          Anchors = [akRight, akBottom]
          TabOrder = 0
        end
        object E_NumBoleto: TEdit
          Left = 707
          Top = 21
          Width = 211
          Height = 21
          Anchors = [akRight, akBottom]
          TabOrder = 1
        end
        object DBRG_Descontada: TRadioGroup
          Left = 538
          Top = 6
          Width = 93
          Height = 36
          Anchors = [akRight, akBottom]
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
          TabOrder = 2
          OnClick = DBRG_DescontadaClick
        end
        inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 387
          Height = 38
          Align = alLeft
          TabOrder = 3
          ExplicitLeft = 5
          ExplicitTop = 5
          ExplicitWidth = 387
          ExplicitHeight = 38
          inherited L_ContaBancaria: TLabel
            Width = 387
          end
          inherited Sb_ContaBancaria: TSpeedButton
            Left = 360
            Height = 23
            ExplicitLeft = 359
            ExplicitHeight = 24
          end
          inherited DBLCB_ContaBancaria: TDBLookupComboBox
            Width = 351
            DataField = 'BLT_CODCTB'
            ExplicitWidth = 351
          end
        end
      end
    end
    object tb_pesq_ChequeTerceiro: TTabSheet
      Caption = 'Pesquisa Cheque Terceiro'
      ImageIndex = 3
      OnShow = tb_pesq_ChequeTerceiroShow
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 928
        Height = 284
        Align = alClient
        Caption = 'Rela'#231#227'o de Cheques de Terceiros Dispon'#237'veis no Sistema'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          928
          284)
        object Label28: TLabel
          Left = 10
          Top = 15
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
        object Label29: TLabel
          Left = 321
          Top = 15
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
        object Label30: TLabel
          Left = 371
          Top = 15
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
        object Label31: TLabel
          Left = 440
          Top = 15
          Width = 47
          Height = 14
          Caption = 'N Cheque'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label32: TLabel
          Left = 684
          Top = 15
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
        object Sb_VoltarChq_Terc: TSpeedButton
          Left = 839
          Top = 226
          Width = 83
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
          Spacing = 0
          OnClick = Sb_VoltarChq_TercClick
          ExplicitLeft = 695
          ExplicitTop = 228
        end
        object Sb_Rela_Cheque: TSpeedButton
          Left = 756
          Top = 226
          Width = 83
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Relacionar - F8'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_Rela_ChequeClick
          ExplicitLeft = 612
          ExplicitTop = 228
        end
        object Sb_BuscarCheque: TSpeedButton
          Left = 673
          Top = 226
          Width = 83
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
          Spacing = 0
          OnClick = Sb_BuscarChequeClick
          ExplicitLeft = 529
          ExplicitTop = 228
        end
        object E_BuscaBanco: TEdit_Setes
          Left = 317
          Top = 29
          Width = 50
          Height = 21
          TabOrder = 1
          Text = ''
        end
        object E_BuscaAgencia: TEdit
          Left = 371
          Top = 29
          Width = 67
          Height = 21
          MaxLength = 7
          TabOrder = 2
        end
        object E_BuscaCheque: TEdit_Setes
          Left = 441
          Top = 29
          Width = 68
          Height = 21
          MaxLength = 7
          TabOrder = 3
          Text = ''
        end
        object E_BuscaValor: TEdit_Setes
          Left = 681
          Top = 29
          Width = 95
          Height = 21
          Alignment = taRightJustify
          TabOrder = 4
          Text = ''
          OnExit = E_VL_ChequeExit
        end
        object E_BuscaEmitente: TEdit
          Left = 7
          Top = 29
          Width = 307
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
        end
        object DBGrid3: TDBGrid
          Left = 6
          Top = 55
          Width = 914
          Height = 167
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          DataSource = Ds_Qr_MostraSemDestino
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 5
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clNavy
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CHQ_EMITENTE'
              Title.Caption = 'Emitente'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CHQ_NR_BANCO'
              Title.Alignment = taCenter
              Title.Caption = 'Banco'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Width = 56
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'CHQ_AGENCIA'
              Title.Alignment = taCenter
              Title.Caption = 'Ag'#234'ncia'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Width = 72
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'CHQ_NUMERO'
              Title.Alignment = taCenter
              Title.Caption = 'Cheque n'#186
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CHQ_DATA'
              Title.Alignment = taCenter
              Title.Caption = 'Pr'#233'-Datado'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CHQ_VALOR'
              Title.Alignment = taCenter
              Title.Caption = 'Valor'
              Width = 84
              Visible = True
            end>
        end
        object E_Dt_Ini_Chq: TDateTimePicker
          Left = 511
          Top = 29
          Width = 85
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 6
        end
        object E_Dt_Fim_Chq: TDateTimePicker
          Left = 596
          Top = 29
          Width = 85
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 7
        end
        object Chbx_Periodo_C: TCheckBox
          Left = 512
          Top = 14
          Width = 135
          Height = 12
          Caption = 'Data Inicial     Data Final'
          Checked = True
          State = cbChecked
          TabOrder = 8
          OnClick = Chbx_Periodo_CClick
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 362
    Width = 936
    Height = 147
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 1
    object Dbg_Duplicatas: TDBGrid
      Left = 2
      Top = 2
      Width = 932
      Height = 143
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
          FieldName = 'FIN_DT_PAGTO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'FIN_VL_PAGO'
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
    Top = 509
    Width = 936
    Height = 43
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      936
      43)
    object Label23: TLabel
      Left = 549
      Top = 4
      Width = 48
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Valor total'
      FocusControl = E_VL_Pagar
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 405
      ExplicitTop = 2
    end
    object Label14: TLabel
      Left = 343
      Top = 4
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
      ExplicitLeft = 199
      ExplicitTop = 2
    end
    object Label6: TLabel
      Left = 404
      Top = 4
      Width = 24
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Mora'
      FocusControl = E_VL_Juros
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 260
      ExplicitTop = 2
    end
    object Label15: TLabel
      Left = 471
      Top = 4
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
      ExplicitLeft = 327
      ExplicitTop = 2
    end
    object Label16: TLabel
      Left = 717
      Top = 4
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
      ExplicitLeft = 573
      ExplicitTop = 2
    end
    object Label24: TLabel
      Left = 630
      Top = 4
      Width = 52
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Data Pagto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 486
      ExplicitTop = 2
    end
    object Lb_Saldo_Parcial: TLabel
      Left = 802
      Top = 4
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
      ExplicitLeft = 658
      ExplicitTop = 2
    end
    object E_Vl_Saldo: TLabel
      Left = 829
      Top = 18
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
      ExplicitLeft = 685
      ExplicitTop = 16
    end
    object E_VL_Pagar: TEdit_Setes
      Left = 548
      Top = 17
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
      Left = 342
      Top = 17
      Width = 59
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      TabOrder = 0
      Text = ''
      OnEnter = E_VL_JurosEnter
      OnExit = E_VL_JurosExit
    end
    object E_VL_Mora: TEdit_Setes
      Left = 403
      Top = 17
      Width = 63
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      TabOrder = 1
      Text = ''
      OnEnter = E_VL_MoraEnter
      OnExit = E_VL_MoraExit
    end
    object E_VL_Desconto: TEdit_Setes
      Left = 468
      Top = 17
      Width = 77
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      TabOrder = 2
      Text = ''
      OnEnter = E_VL_DescontoEnter
      OnExit = E_VL_DescontoExit
    end
    object E_VL_Pago: TEdit_Setes
      Left = 715
      Top = 17
      Width = 77
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Color = clHighlightText
      TabOrder = 4
      Text = ''
      OnChange = E_VL_PagoChange
      OnExit = E_VL_PagoExit
    end
    object E_Dt_Pagto: TDateTimePicker
      Left = 628
      Top = 17
      Width = 85
      Height = 22
      Anchors = [akRight, akBottom]
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 5
    end
    inline Fm_TipoPagamento: TFm_FormaPagto
      Left = 0
      Top = 2
      Width = 259
      Height = 38
      TabOrder = 6
      ExplicitTop = 2
      ExplicitWidth = 259
      ExplicitHeight = 38
      inherited Lb_FormaPagamento: TLabel
        Width = 253
      end
      inherited pnl_Forma: TPanel
        Width = 259
        Height = 24
        ExplicitWidth = 259
        ExplicitHeight = 24
        inherited SB_FormaPag: TSpeedButton
          Left = 233
          Height = 21
          ExplicitLeft = 233
          ExplicitHeight = 16
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 224
          OnClick = Fm_TipoPagamentoDBLCB_FormaPagtoClick
          ExplicitWidth = 224
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 552
    Width = 936
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 854
      Top = 5
      Width = 77
      Height = 52
      Margins.Left = 1
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
      ExplicitLeft = 709
      ExplicitTop = 4
      ExplicitHeight = 54
    end
    object Sb_Baixar: TSpeedButton
      AlignWithMargins = True
      Left = 696
      Top = 5
      Width = 77
      Height = 52
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitLeft = 651
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Boleto: TSpeedButton
      AlignWithMargins = True
      Left = 538
      Top = 5
      Width = 77
      Height = 52
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitLeft = 489
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Cheque: TSpeedButton
      AlignWithMargins = True
      Left = 459
      Top = 5
      Width = 77
      Height = 52
      Margins.Left = 1
      Margins.Right = 1
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
      Left = 617
      Top = 5
      Width = 77
      Height = 52
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitLeft = 568
      ExplicitTop = 1
      ExplicitHeight = 54
    end
    object Sb_Negociar: TSpeedButton
      AlignWithMargins = True
      Left = 775
      Top = 5
      Width = 77
      Height = 52
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitLeft = 626
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object Grb_MnhaEmpresa: TGroupBox
    Left = 0
    Top = 0
    Width = 936
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
      936
      50)
    object chbx_Empresas: TCheckBox
      Left = 7
      Top = 8
      Width = 165
      Height = 14
      Caption = 'Selecionar todas as Empresas'
      TabOrder = 0
    end
    object Dblcb_Mha_Empresa: TDBLookupComboBox
      Left = 5
      Top = 24
      Width = 924
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
      'SELECT DISTINCT'
      '   FIN_CODIGO,'
      '   NFL_NUMERO,'
      '   PED_NUMERO,'
      '   FIN_NUMERO,'
      '   FIN_DT_VENCIMENTO,'
      '   FIN_NR_PARCELA,'
      '   FIN_CODEMP,'
      '   EMP_FANTASIA,'
      '   EMP_NOME,'
      '   FIN_VL_PARCELA,'
      '   FIN_BAIXA,'
      '   FIN_SITUACAO,'
      '   FIN_VL_PAGO,'
      '   FIN_CODQTC,'
      '   FIN_CODFPG,'
      '   PED_CODIGO,'
      '   NFL_CODIGO,'
      '   FIN_TIPO,'
      '   FIN_DT_PAGTO,'
      '   FIN_OPERACAO,'
      '   FIN_ETAPA,'
      '   FIN_CODMHA,'
      '   FIN_CODCHQ,'
      '   tb_plc_Creditos.PLC_DESCRICAO PLC_Debito,           '
      '   tb_plc_Creditos.PLC_DESCRICAO PLC_Credito'
      ' FROM TB_FINANCEIRO tb_financeiro'
      '   INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal'
      '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '
      '   LEFT OUTER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED)'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)'
      '   LEFT OUTER JOIN TB_PLANOCONTAS tb_plc_Debito'
      '   ON (tb_plc_Debito.PLC_CODIGO = tb_financeiro.FIN_PLC_DEBITO)'
      '   LEFT OUTER JOIN TB_PLANOCONTAS tb_plc_Creditos'
      
        '   ON (tb_plc_Creditos.PLC_CODIGO = tb_financeiro.FIN_PLC_CREDIT' +
        'O)')
    Left = 40
    Top = 400
  end
  object Ds_Parcelas: TDataSource
    DataSet = cds_Parcelas
    Left = 560
    Top = 192
  end
  object Qr_Boleto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
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
    Left = 128
    Top = 408
  end
  object Ds_Qr_Boleto: TDataSource
    DataSet = Qr_Boleto
    Left = 128
    Top = 456
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
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
    Left = 456
    Top = 408
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
  object PpM_Duplicata: TPopupMenu
    Left = 260
    Top = 155
    object RetiraDestinao1: TMenuItem
      Caption = 'Retira Destina'#231#227'o'
      OnClick = RetiraDestinao1Click
    end
    object DetalhesdoPedido1: TMenuItem
      Caption = 'Visualizar Pedido'
      OnClick = DetalhesdoPedido1Click
    end
    object Observaes1: TMenuItem
      Caption = 'Observa'#231#245'es'
      OnClick = Observaes1Click
    end
    object AplicarPlanoContas1: TMenuItem
      Caption = 'Aplicar Plano Contas'
      OnClick = AplicarPlanoContas1Click
    end
    object AtivarInativar1: TMenuItem
      Caption = 'Ativar/Inativar'
      OnClick = AtivarInativar1Click
    end
    object Autorizarselecionado1: TMenuItem
      Caption = 'Autoriza'#231#227'o'
      OnClick = Autorizarselecionado1Click
    end
  end
  object Ds_ContaBancaria: TDataSource
    Left = 288
    Top = 447
  end
  object Qr_Cheques: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      
        'CHQ_AGENCIA, CHQ_CODIGO, CHQ_QT_REC,CHQ_QT_PAG, CHQ_CODFOR, CHQ_' +
        'DATA, CHQ_DEVOLVIDO, CHQ_DT_QUITACAO, CHQ_EMITENTE, CHQ_ESTADO, ' +
        'CHQ_NR_BANCO, CHQ_NUMERO, CHQ_RETORNO, CHQ_TIPO, CHQ_VALOR'
      'FROM TB_CHEQUES Tb_cheques'
      'WHERE (CHQ_QT_PAG = 0)  OR  (CHQ_QT_PAG IS NULL)  ')
    Left = 352
    Top = 400
  end
  object Ds_Cheque: TDataSource
    DataSet = Qr_Cheques
    Left = 360
    Top = 448
  end
  object Qr_MostraSemDestino: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT *'
      'FROM TB_CHEQUES Tb_cheques '
      
        'WHERE ((CHQ_QT_PAG IS NULL) OR (CHQ_QT_PAG =0)) AND (CHQ_TIPO = ' +
        #39'T'#39') AND '
      '            ((CHQ_ESTADO= '#39'N'#39') OR (CHQ_ESTADO= '#39'R'#39')) ')
    Left = 608
    Top = 392
  end
  object Ds_Qr_MostraSemDestino: TDataSource
    DataSet = Qr_MostraSemDestino
    OnStateChange = Ds_Qr_MostraSemDestinoStateChange
    Left = 608
    Top = 440
  end
  object Up_Financerio: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE TB_FINANCEIRO '
      'SET '
      '     FIN_DT_VENCIMENTO=:FIN_DT_VENCIMENTO,'
      '    FIN_NUMERO=:FIN_NUMERO,'
      '   FIN_VL_PARCELA=:FIN_VL_PARCELA'
      ' WHERE FIN_CODIGO=:FIN_CODIGO')
    Left = 696
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIN_DT_VENCIMENTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FIN_NUMERO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FIN_VL_PARCELA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FIN_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object cds_Parcelas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 564
    Top = 138
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
    object cds_ParcelasFIN_AUTORIZADO: TStringField
      FieldName = 'FIN_AUTORIZADO'
    end
  end
  object cds_duplicatas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 660
    Top = 138
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
    object cds_duplicatasFIN_AUTORIZADO: TStringField
      FieldName = 'FIN_AUTORIZADO'
    end
  end
  object ds_duplicatas: TDataSource
    DataSet = cds_duplicatas
    Left = 664
    Top = 186
  end
end
