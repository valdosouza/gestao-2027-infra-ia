inherited Fr_Cliente: TFr_Cliente
  Caption = 'Cadastro de Clientes'
  ClientHeight = 553
  ClientWidth = 675
  ExplicitWidth = 681
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 675
    Height = 284
    ExplicitWidth = 675
    ExplicitHeight = 284
    inherited PG_Informacoes: TPageControl
      Width = 671
      Height = 280
      ActivePage = TabSheet2
      ExplicitWidth = 671
      ExplicitHeight = 280
      inherited TabSheet3: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 663
        ExplicitHeight = 249
        inherited pg_fiscal: TPageControl
          Width = 663
          Height = 249
          ActivePage = tbs_obs_nota
          ExplicitWidth = 663
          ExplicitHeight = 249
          inherited TabSheet6: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 655
            ExplicitHeight = 221
            inherited Pnl_Observacao: TPanel
              Width = 655
              Height = 221
              ExplicitWidth = 655
              ExplicitHeight = 221
              inherited obs_Geral: TMemo
                Width = 651
                Height = 217
                ExplicitWidth = 651
                ExplicitHeight = 217
              end
            end
          end
          inherited TabSheet8: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 655
            ExplicitHeight = 221
            inherited Obs_Fiscal: TMemo
              Width = 655
              Height = 221
              ExplicitWidth = 655
              ExplicitHeight = 221
            end
          end
          object tbs_obs_nota: TTabSheet
            Caption = 'Nota Fiscal'
            ImageIndex = 2
            object Panel5: TPanel
              Left = 0
              Top = 0
              Width = 655
              Height = 221
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object Obs_Nota: TMemo
                Left = 2
                Top = 2
                Width = 651
                Height = 217
                Align = alClient
                TabOrder = 0
              end
            end
          end
        end
      end
      inherited Contato: TTabSheet
        ExplicitWidth = 663
        ExplicitHeight = 249
        inherited Pnl_Contato: TPanel
          Width = 663
          Height = 249
          ExplicitWidth = 663
          ExplicitHeight = 249
          inherited Sb_Exc_Contato: TSpeedButton
            Top = 206
            ExplicitTop = 206
          end
          inherited Sb_Alt_Contato: TSpeedButton
            Top = 206
            ExplicitTop = 206
          end
          inherited Sb_Ins_Contato: TSpeedButton
            Top = 206
            ExplicitTop = 206
          end
          inherited DBG_Socios: TDBGrid
            Width = 659
            Height = 200
          end
        end
      end
      inherited tbs_Endereco: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 663
        ExplicitHeight = 249
        inherited Pnl_Endereco: TPanel
          Width = 663
          Height = 206
          ExplicitWidth = 663
          ExplicitHeight = 206
        end
        inherited Pnl_Navegacao: TPanel
          Top = 206
          Width = 663
          ExplicitTop = 206
          ExplicitWidth = 663
          inherited Label32: TLabel
            Left = 2
            Width = 659
            ExplicitLeft = 1063
          end
          inherited SB_Ins_Ender: TSpeedButton
            Left = 581
            ExplicitLeft = 570
          end
          inherited Sb_Next_end: TSpeedButton
            Left = 481
            ExplicitLeft = 462
          end
          inherited Sb_Last_end: TSpeedButton
            Left = 531
            ExplicitLeft = 514
          end
          inherited Sb_First_end: TSpeedButton
            Left = 456
            ExplicitLeft = 437
          end
          inherited Sb_Prior_end: TSpeedButton
            Left = 506
            ExplicitLeft = 488
          end
          inherited Sb_Exc_Ender: TSpeedButton
            Left = 556
            ExplicitLeft = 539
          end
        end
      end
      inherited TabSheet1: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 663
        ExplicitHeight = 249
        inherited Pnl_Tributacao: TPanel
          Width = 431
          Height = 249
          ExplicitWidth = 431
          ExplicitHeight = 249
          inherited Label58: TLabel
            Top = 123
            Width = 421
            ExplicitTop = 123
          end
          object Label67: TLabel [1]
            Left = 231
            Top = 160
            Width = 98
            Height = 13
            Hint = 
              'N'#250'mero do processo judicial ou administrativo de suspens'#227'o da ex' +
              'igibilidade'
            Caption = 'N'#250'mero do processo'
            ParentShowHint = False
            ShowHint = True
            WordWrap = True
          end
          object Label59: TLabel [2]
            Left = 7
            Top = 158
            Width = 170
            Height = 13
            Caption = 'Indicador da exigibilidade do ISSQN'
          end
          inherited Cb_Ind_IE_Dest: TComboBox
            Top = 139
            Width = 421
            ExplicitTop = 139
            ExplicitWidth = 421
          end
          inherited ChBx_Consumidor: TCheckBox
            Width = 421
            ExplicitWidth = 421
          end
          inherited ChBx_MicroEmpresa: TCheckBox
            Width = 421
            ExplicitWidth = 421
          end
          inherited Chbx_IgnoraST: TCheckBox
            Width = 421
            TabOrder = 9
            ExplicitWidth = 421
          end
          object chbx_Just_Xml: TCheckBox [7]
            AlignWithMargins = True
            Left = 5
            Top = 95
            Width = 421
            Height = 26
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 
              'Enviar somente o Arquivo XML para o cliente, nos casos em que a ' +
              'recep'#231#227'o do arquivo seja feita por meio eletr'#244'nico'
            TabOrder = 8
            WordWrap = True
          end
          object RG_ISS_RET: TRadioGroup [8]
            Left = 6
            Top = 201
            Width = 134
            Height = 42
            Caption = 'Reten'#231#227'o do ISSQN'
            Columns = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'N'#195'O'
              'SIM')
            ParentFont = False
            TabOrder = 4
          end
          object E_ISS_Nr_Processo: TEdit [9]
            Left = 231
            Top = 174
            Width = 121
            Height = 21
            TabOrder = 5
          end
          object Cb_ISS_EXIGIB: TComboBox [10]
            Left = 7
            Top = 173
            Width = 218
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 6
            Text = '01 - Exig'#237'vel.'
            Items.Strings = (
              '01 - Exig'#237'vel.'
              '02 - N'#227'o incid'#234'ncia.'
              '03 - Isen'#231#227'o.'
              '04 - Exporta'#231#227'o.'
              '05 - Imunidade.'
              '06 - Exigibilidade Suspensa por Decis'#227'o Judicial.'
              '07 - Exigibilidade Suspensa por Processo Administrativo.')
          end
          object Rg_ISS_IND_INC_FISCAL: TRadioGroup [11]
            Left = 144
            Top = 201
            Width = 133
            Height = 42
            Caption = 'Incentivo Fiscal - ISSQN'
            Columns = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'N'#195'O'
              'SIM')
            ParentFont = False
            TabOrder = 7
          end
          inherited ChBx_Ativa: TCheckBox
            Left = 332
            Top = 204
            Width = 93
            TabOrder = 3
            Visible = False
            ExplicitLeft = 332
            ExplicitTop = 204
            ExplicitWidth = 93
          end
          object ChBx_ClienteAtivo: TCheckBox
            Left = 333
            Top = 227
            Width = 93
            Height = 17
            Caption = 'Cliente Ativo'
            TabOrder = 10
          end
          object chbx_send_email_auto: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 76
            Width = 421
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Enviar email autom'#225'tico ap'#243's a autoriza'#231#227'o'
            TabOrder = 11
          end
        end
        inherited pnl_regra_tributacao: TPanel
          Left = 431
          Height = 249
          ExplicitLeft = 431
          ExplicitHeight = 249
          inherited SB_Impostos: TSpeedButton
            Top = 217
            ExplicitTop = 217
          end
          inherited DBG_Impostos: TDBGrid
            Height = 188
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Par'#226'metros'
        ImageIndex = 4
        object Pnl_Parametro: TPanel
          Left = 0
          Top = 0
          Width = 663
          Height = 249
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label4: TLabel
            Left = 119
            Top = 4
            Width = 66
            Height = 14
            Caption = 'Limite cr'#233'dito:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 6
            Top = 4
            Width = 70
            Height = 14
            Caption = 'Status cr'#233'dito:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 205
            Top = 4
            Width = 53
            Height = 14
            Caption = 'Mala Direta'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 270
            Top = 4
            Width = 120
            Height = 14
            Caption = 'Nome da Transportadora'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 6
            Top = 45
            Width = 115
            Height = 13
            Caption = 'Codigo/Nome do Banco'
          end
          object Label38: TLabel
            Left = 345
            Top = 45
            Width = 39
            Height = 13
            Caption = 'Ag'#234'ncia'
            FocusControl = E_Agencia
          end
          object Label39: TLabel
            Left = 507
            Top = 45
            Width = 73
            Height = 13
            Caption = 'Conta Banc'#225'ria'
            FocusControl = E_ContaBanc
          end
          object Label6: TLabel
            Left = 6
            Top = 87
            Width = 110
            Height = 13
            Caption = 'Multiplicador de Pre'#231'os'
            FocusControl = E_Multiplicador
          end
          object Label14: TLabel
            Left = 121
            Top = 87
            Width = 102
            Height = 13
            Caption = 'Redu'#231#227'o de Contrato'
            FocusControl = E_Red_Ctro
          end
          object E_VL_Credito: TEdit
            Left = 118
            Top = 20
            Width = 81
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Cb_mala_direta: TComboBox
            Left = 204
            Top = 20
            Width = 55
            Height = 22
            AutoDropDown = True
            Style = csDropDownList
            CharCase = ecUpperCase
            DragMode = dmAutomatic
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemIndex = 1
            ParentFont = False
            TabOrder = 2
            Text = 'N'#195'O'
            Items.Strings = (
              'SIM'
              'N'#195'O')
          end
          object DBLCB_Transportadora: TDBLookupComboBox
            Left = 262
            Top = 19
            Width = 384
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'EMP_CODIGO'
            ListField = 'EMP_NOME'
            ListSource = DM_ListaConsultas.Ds_ListaTransportadora
            ParentFont = False
            TabOrder = 3
          end
          object E_Agencia: TEdit
            Left = 342
            Top = 60
            Width = 159
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object E_ContaBanc: TEdit
            Left = 507
            Top = 60
            Width = 142
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object E_Multiplicador: TEdit
            Left = 6
            Top = 102
            Width = 113
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object DBLCB_Banco: TDBLookupComboBox
            Left = 6
            Top = 60
            Width = 334
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'EMP_NUMBCO'
            ListField = 'EMP_FANTASIA'
            ListSource = DM_ListaConsultas.Ds_ListaBancos
            ParentFont = False
            TabOrder = 4
          end
          object E_Red_Ctro: TEdit
            Left = 121
            Top = 102
            Width = 104
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object bb_status: TBitBtn
            Left = 6
            Top = 20
            Width = 109
            Height = 22
            Caption = 'Status'
            TabOrder = 0
            OnClick = bb_statusClick
          end
          object gp_carteira: TGroupBox
            Left = 6
            Top = 126
            Width = 117
            Height = 36
            Caption = 'Habilitar Carteira'
            TabOrder = 10
            object rdb_Hab_Cart0: TRadioButton
              Left = 8
              Top = 13
              Width = 48
              Height = 17
              Caption = 'N'#227'o'
              TabOrder = 0
            end
            object rdb_Hab_Cart1: TRadioButton
              Left = 61
              Top = 12
              Width = 48
              Height = 17
              Caption = 'SIM'
              TabOrder = 1
            end
          end
          object Rg_Lojista: TRadioGroup
            Left = 126
            Top = 126
            Width = 246
            Height = 36
            Caption = 'Cadastro de Lojista'
            Columns = 3
            Items.Strings = (
              'SIM'
              'N'#227'o'
              'Aprova'#231#227'o')
            TabOrder = 11
          end
          inline Fm_ListaTabelaPreco: TFm_ListaTabelaPreco
            Left = 231
            Top = 90
            Width = 270
            Height = 36
            TabOrder = 9
            ExplicitLeft = 231
            ExplicitTop = 90
            ExplicitWidth = 270
            ExplicitHeight = 36
            inherited Label53: TLabel
              Font.Color = clBlack
            end
            inherited Sb_Preco: TSpeedButton
              Left = 243
              ExplicitLeft = 478
            end
            inherited Dblcb_Lista: TDBLookupComboBox
              Width = 241
              ExplicitWidth = 241
            end
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = 'Ficha Cadastral'
        ImageIndex = 6
        OnShow = TabSheet5Show
        object Pnl_Ficha: TPanel
          Left = 0
          Top = 0
          Width = 663
          Height = 249
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            663
            249)
          object Sb_Exc_FichaCadastral: TSpeedButton
            Left = 196
            Top = 206
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Exc_FichaCadastralClick
            ExplicitTop = 168
          end
          object Sb_Alt_FichaCadastral: TSpeedButton
            Left = 99
            Top = 206
            Width = 97
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Alt_FichaCadastralClick
            ExplicitTop = 168
          end
          object Sb_Ins_FichaCadastral: TSpeedButton
            Left = 5
            Top = 206
            Width = 94
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Ins_FichaCadastralClick
            ExplicitTop = 168
          end
          object Sb_Imp_FichaCadastral: TSpeedButton
            Left = 296
            Top = 206
            Width = 104
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Imprimir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFF9F9F9E3E3E3E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFBCBCBC9999999393939393939393939393939393939292
              929191919090908F8F8F8E8E8E8E8E8E8C8C8C8B8B8B8A8A8A8A8A8A89898989
              8989828282D3D3D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFD5D5D5F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFDFDFDF8F8F8F3F3F3F0F0F0EBEBEBE6E6E6E2E2E2DEDEDED9D9D9DE
              DEDEA0A0A0F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFE6E6E6C0C0C0ABABABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFBFBFBF6F6F6F3F3F3EEEEEEE9E9E9E5E5E5E1E1E1DCDCDCD8D8D8D5D5D5D4
              D4D47F7F7FC8C8C8E5E5E5FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9
              B5B5B58989898989899E9E9EA6A6A6F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFCFCFCF7F7F7F3F3F3EFEFEFEAEAEAE6E6E6E2E2E2DDDDDDDCDCDCC1
              C1C19F9F9F9393937D7D7D848484B6B6B6F4F4F4FFFFFFFFFFFFFFFFFF9D9D9D
              A1A1A1B9B9B9B4B4B4A9A9A9959595C5C5C5FFFFFFFDFDFDFDFDFDFDFDFDFDFD
              FDFDFDFDFCFCFCF8F8F8F4F4F4F0F0F0ECECECE6E6E6E3E3E3DFDFDFDEDEDEA1
              A1A1A0A0A0A7A7A7B1B1B1B3B3B3888888A3A3A3FFFFFFFFFFFFE5E5E5A1A1A1
              BFBFBFC1C1C1666666000000000000535353E0E0E0DADADAD9D9D9D9D9D9D9D9
              D9D9D9D9D9D9D9D9D9D9D6D6D6D2D2D2CECECECBCBCBC7C7C7C5C5C5BFBFBF32
              32320000000909099C9C9CBCBCBCC1C1C17E7E7EF2F2F2FFFFFFB2B2B2BCBCBC
              BDBDBDC7C7C76565650000000000000000002626262626262626262626262626
              2626262626262626262626262625252525252524242424242424242421212100
              0000000000000000A8A8A8C0C0C0C3C3C3929292C9C9C9FFFFFF9B9B9BCACACA
              C3C3C3CBCBCB8383833333333333333131312B2B2B2B2B2B2B2B2B2B2B2B2B2B
              2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C2C2C31
              31313333333C3C3CB7B7B7C5C5C5C6C6C6B2B2B2A3A3A3FAFAFA9F9F9FD1D1D1
              C9C9C9C9C9C9CCCCCCD0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
              D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
              D0D0D0D0D0D0D0D0CACACAC9C9C9CBCBCBC6C6C6919191EBEBEBAEAEAED6D6D6
              D0D0D0D0D0D0D0D0D0D1D1D1D1D1D1D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
              D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
              D0D0D1D1D1D1D1D1D0D0D0D0D0D0D2D2D2D3D3D38C8C8CE3E3E3B2B2B2DEDEDE
              D7D7D7D7D7D7D6D6D6D6D6D6D7D7D7D8D8D8DADADADBDBDBDCDCDCDDDDDDDEDE
              DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDDDDDDDCDCDCDBDBDBD9D9D9D8
              D8D8D7D7D7D6D6D6D6D6D6D7D7D7D8D8D8DADADA8D8D8DE3E3E3B0B0B0E4E4E4
              DDDDDDDFDFDFE3E3E3E6E6E6E8E8E8EAEAEAEBEBEBEBEBEBEBEBEBEBEBEBEBEB
              EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAEA
              EAEAE8E8E8E6E6E6E2E2E2DFDFDFDFDFDFDDDDDD909090EAEAEAA0A0A0F0F0F0
              EEEEEEF1F1F1F3F2F3F2F2F2F2F2F2F2F2F2F1F1F1F1F1F1F1F1F1F1F1F1F1F1
              F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F2
              F2F2F2F2F2F2F2F2F2F2F2F0F0F0F0F0F0D9D9D99F9F9FFAFAFAA3A3A3F3F3F3
              FAFAFAFFF8FFFFF7FFFAF9FAF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
              F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
              F7F7F7F7F7F7F7F7F7F7F7F7F7F7FEFEFEC3C3C3C1C1C1FFFFFFC3C3C3DFDEDF
              FEFDFE78CE784DC34DE3EEE3FDFDFDFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB
              FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB
              FBFBFBFBFBFBFBFBFBFBFBFCFCFCFFFFFF9B9B9BF0F0F0FFFFFFF7F7F7ADACAD
              FFFFFF75CF7555CA55D1E7D1FFFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFEFEFEFFFFFFF9F9F9979797FFFFFFFFFFFFFFFFFFB1B1B1
              D7D7D7F6F7F6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFF6F6F6A7A7A7E2E2E2FFFFFFFFFFFFFFFFFFFFFFFF
              D9D9D9B6B5B6C1C0C1E2E2E2FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
              FEFDFDFDFCFCFCFBFBFBFAFAFAF9F9F9F8F8F8F7F7F7F6F6F6F5F5F5F4F4F4F3
              F3F3EDEDEDCFCFCFAAAAAAB2B2B2EAEAEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFF9F9F9B7B7B7E6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFAFAFAF5F5F5EFEFEFEBEBEBE6E6E6E0E0E0DCDCDCD7D7D7D0D0D0D0
              D0D08B8B8BD6D6D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFEEEEEED6D6D6EAEAEAD3D3D3D3D3D3D3D3D3D3D3D3D4D4
              D4D2D2D2CECECECACACAC6C6C6C1C1C1BEBEBEBABABAB5B5B5B2B2B2BABABAD8
              D8D8949494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFBBBBBB9494947E7E7E9898989292929090908E8E
              8E8C8C8C8989898787878585858282827F7F7F7C7C7C7B7B7B6B6B6B6F6F6FCE
              CECEC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D9D9D9D9D9D9FFFFFFFEFEFEFAFAFAF7F7
              F7F2F2F2EEEEEEEAEAEAE6E6E6E2E2E2DDDDDDD8D8D8D7D7D7C0C0C0A6A6A6E8
              E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3D1D1D1FFFFFFF9F9F9F4F4F4F0F0
              F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDD9D9D9D4D4D4D3D3D3BABABAB7B7B7FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD2D2D2FFFFFFFDFDFDF9F9F9F4F4
              F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDD9D9D9D8D8D8BCBCBCB3B3B3FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD0D0D0FFFFFFFFFFFFFDFDFDF9F9
              F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDDDDDDDBEBEBEB2B2B2FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACECECEFFFFFFFFFFFFFFFFFFFDFD
              FDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1E2E2E2BFBFBFB1B1B1FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACDCDCDFFFFFFFFFFFFFFFFFFFFFF
              FFFDFDFDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E6E6E6C1C1C1B1B1B1FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACBCBCBFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFDFDFDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9EAEAEAC2C2C2B0B0B0FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACBCBCBFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFEFEFEFAFAFAF5F5F5F1F1F1EEEEEEF0F0F0C4C4C4AFAFAFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9C7C7C7FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAF5F5F5F2F2F2F4F4F4C7C7C7B2B2B2FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B4B4B4BEBEBEBCBCBCBCBCBCBCBC
              BCBCBCBCBCBCBCBCBCBCBCBCBCBBBBBBBABABAB9B9B9BABABAB3B3B3E0E0E0FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            ParentFont = False
            Transparent = False
            OnClick = Sb_Imp_FichaCadastralClick
            ExplicitTop = 168
          end
          object Dbg_FichaCadastral: TDBGrid
            Left = 2
            Top = 2
            Width = 659
            Height = 200
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataSource = Ds_FichaCadastral
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'FCT_CODIGO'
                Title.Caption = 'C'#243'digo'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FCT_DATA'
                Title.Caption = 'Data Registro'
                Width = 97
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'EMP_NOME'
                Title.Caption = 'Nome'
                Width = 444
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited Panel1: TPanel
    Top = 488
    Width = 675
    ExplicitTop = 488
    ExplicitWidth = 675
    inherited SB_Excluir: TSpeedButton
      Left = 298
      ExplicitLeft = 298
    end
  end
  inherited Pnl_Cliente: TPanel
    Width = 675
    ExplicitWidth = 675
    inherited Label2: TLabel
      Left = 230
      ExplicitLeft = 230
    end
    inherited Label3: TLabel
      Left = 150
      ExplicitLeft = 150
    end
    inherited Lb_IncEstadual: TLabel
      Left = 369
      ExplicitLeft = 369
    end
    inherited Lb_IncMunicipal: TLabel
      Left = 518
      ExplicitLeft = 518
    end
    inherited Sb_CNPJ: TSpeedButton
      Left = 340
      ExplicitLeft = 340
    end
    inherited E_Insc_Est: TEdit
      Left = 367
      ExplicitLeft = 367
    end
    inherited CB_TpPessoa: TComboBox
      Left = 148
      ExplicitLeft = 148
    end
    inherited E_Fundacao: TMaskEdit
      Width = 91
      ExplicitWidth = 91
    end
    inherited E_Data: TDateTimePicker
      Width = 88
      ExplicitWidth = 88
    end
    inherited E_Insc_Mun: TEdit
      Left = 517
      Width = 140
      ExplicitLeft = 517
      ExplicitWidth = 140
    end
    inherited E_CpfCnpj: TMaskEdit
      Left = 228
      ExplicitLeft = 228
    end
  end
  inherited Menu: TMainMenu
    Left = 530
    Top = 305
    inherited Mnu_Tarefas: TMenuItem
      object FichaFinanceira1: TMenuItem
        Caption = 'Ficha Financeira'
        OnClick = FichaFinanceira1Click
      end
      object Contratos1: TMenuItem
        Caption = 'Contratos'
        object rocabrech1: TMenuItem
          Caption = 'Troca Brech'#243
          OnClick = rocabrech1Click
        end
      end
    end
  end
  inherited Qr_BuscaFone: TSTQuery
    Top = 112
  end
  inherited Qr_BuscaEmail: TSTQuery
    Left = 296
    Top = 112
  end
  inherited Qr_Contato: TSTQuery
    Left = 357
    Top = 99
  end
  inherited Ds_Contato: TDataSource
    Left = 357
    Top = 147
  end
  object Qr_FichaCadastral: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'select'
      ' FCT_CODIGO,'
      '  FCT_CODEMP,'
      '  FCT_DATA,'
      '  EMP_NOME'
      'FROM tb_empresa EMP'
      '   INNER join tb_ficha_cadastral FCH'
      '   ON (EMP.emp_codigo = FCH.fct_codemp)'
      'WHERE FCT_CODEMP=:EMP_CODIGO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 415
    Top = 99
    ParamData = <
      item
        Name = 'EMP_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
  end
  object Ds_FichaCadastral: TDataSource
    DataSet = Qr_FichaCadastral
    Left = 415
    Top = 146
  end
  object Qr_Cliente: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CLIENTE'
      'WHERE CLI_CODEMP =:EMP_CODIGO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 588
    Top = 92
    ParamData = <
      item
        Name = 'EMP_CODIGO'
      end>
  end
end
