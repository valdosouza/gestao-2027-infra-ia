inherited TasMenuFiscalPaf: TTasMenuFiscalPaf
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Menu Fiscal - PAF - NFC-e'
  ClientHeight = 491
  ClientWidth = 619
  ExplicitWidth = 625
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 613
    Height = 485
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 1
  end
  object pg_principal: TPageControl [1]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 613
    Height = 485
    ActivePage = tbs_fechamento
    Align = alClient
    TabOrder = 0
    object tbs_identificacao: TTabSheet
      Caption = 'Identifica'#231#227'o'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        605
        457)
      object pnl_identificacao: TPanel
        AlignWithMargins = True
        Left = 49
        Top = 26
        Width = 509
        Height = 408
        Anchors = []
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Lb_Identifica_empresa: TLabel
          Left = 2
          Top = 32
          Width = 473
          Height = 19
          Alignment = taCenter
          AutoSize = False
          Caption = 'Identifica'#231#227'o da empresa desenvolvedora'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lb_CNPJ: TLabel
          Left = 15
          Top = 72
          Width = 110
          Height = 16
          AutoSize = False
          Caption = 'CNPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object E_CNPJ: TLabel
          Left = 145
          Top = 72
          Width = 109
          Height = 16
          AutoSize = False
          Caption = '07.72.094/0001-13'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Lb_nome_razao: TLabel
          Left = 15
          Top = 94
          Width = 110
          Height = 16
          AutoSize = False
          Caption = 'Raz'#227'o social'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lb_endereco: TLabel
          Left = 15
          Top = 121
          Width = 110
          Height = 16
          AutoSize = False
          Caption = 'Endere'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object E_nome_razao: TLabel
          Left = 145
          Top = 94
          Width = 282
          Height = 16
          AutoSize = False
          Caption = 'F. D. SOUZA DESENV. E LICENC. DE PROGRAMAS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object E_Endereco_1: TLabel
          Left = 145
          Top = 121
          Width = 206
          Height = 16
          AutoSize = False
          Caption = 'R FAUSTINO JACOB STOFELLA, 28A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object E_Endereco_2: TLabel
          Left = 145
          Top = 137
          Width = 309
          Height = 16
          AutoSize = False
          Caption = 'CEP: 81.770-090 - ALTO BOQUEIR'#195'O - CURITIBA - PR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Lb_telefone: TLabel
          Left = 15
          Top = 167
          Width = 110
          Height = 16
          AutoSize = False
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object E_telefone: TLabel
          Left = 145
          Top = 167
          Width = 207
          Height = 16
          AutoSize = False
          Caption = ' (41) 4042-3825 / (41) 9-9911-2072'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Contato: TLabel
          Left = 15
          Top = 194
          Width = 110
          Height = 16
          AutoSize = False
          Caption = 'Contato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object E_nome_contato: TLabel
          Left = 145
          Top = 194
          Width = 71
          Height = 16
          AutoSize = False
          Caption = 'Valdo Souza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Identificacao_PAF_NFE_e: TLabel
          Left = 2
          Top = 240
          Width = 473
          Height = 19
          Alignment = taCenter
          AutoSize = False
          Caption = 'Identifica'#231#227'o do PAF-NFC-e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lb_nome_comercial: TLabel
          Left = 15
          Top = 269
          Width = 110
          Height = 16
          AutoSize = False
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object E_nome_comercial: TLabel
          Left = 145
          Top = 269
          Width = 251
          Height = 16
          AutoSize = False
          Caption = 'Sistema Gest'#227'o Setes  - 112130540000495 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Versao_PAF: TLabel
          Left = 15
          Top = 291
          Width = 124
          Height = 16
          AutoSize = False
          Caption = 'Vers'#227'o PAF-NFC-e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object E_Versao_PAF: TLabel
          Left = 145
          Top = 291
          Width = 18
          Height = 16
          AutoSize = False
          Caption = '2.0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object tbs_fechamento: TTabSheet
      Caption = 'tbs_fechamento'
      ImageIndex = 2
      OnShow = tbs_fechamentoShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 385
        Width = 599
        Height = 69
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Sb_Encerramento: TSpeedButton
          AlignWithMargins = True
          Left = 488
          Top = 5
          Width = 106
          Height = 59
          Align = alRight
          Caption = 'Encerramento - F10'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFCFDFDFDFEFEFEFEFEFEFEFFFFFFFFFF
            FFFEFEFEFEFEFEFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFEFEFEFE
            FEFEFBFBFDFDFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F5F8F8FAFBFDFDFDFDFDFDFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFBFBFBFBFCFCFCFCFCFCFB
            FBFBF1F4F8F9FBFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8EEF3F2F5F7FCFCFBFBFBFBFBFBFBFBFB
            FBFBFBFBFBFBFBFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAF9F9F9F9F9F9F9
            F9F9E7ECF1F6F8FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E7EFF0F3F5FBFBFBFAFAFAFAFAFAFAFA
            FAF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F8F8F8F8F8F8F8F8F8F8F8F8F7F7F7F8
            F7F7DEE5EDF3F6F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD4DEE8E7EBF0FDFBFBFBFAFAFAFAF9FAFA
            F9FAF9F9F9F9F8F9F9F8F9F8F7F9F8F7F8F8F7F8F7F6F8F7F6F7F6F6F7F6F6F4
            F4F4CFDAE5EFF3F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD4DDE7C5D2DFD8DFE8D8E0E8D8DFE8D8DF
            E8D8DFE8D7DFE7D7DFE7D7DEE6D7DEE7D7DEE7D6DEE6D6DEE6D6DEE6D6DEE6CF
            D9E2C1CFDDF3F5F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFECDD8E3BCCADABDCBDBBDCBDBBDCB
            DBBDCBDBBDCBDBBECBDBBECBDBBECBDBBECBDBBECBDBBECBDBBECBDBBECBDBBF
            CCDBE7EDF2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFC0D2436B99426A95466C97466B97466B
            97466B97466B96466B97466B97466B96466B96466B96456B96466B96466B963F
            66966585A9EDF1F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5177A17191B5C3CCD7C1CAD5BFC9D4BEC8
            D3BEC7D2BDC6D1BCC6D0BAC4CFB9C3CEB8C2CDB7C1CCB6C0CBB4BEC9B6BFC99B
            ABBD366598C2D0DEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5379A4AFBFCFF2EEEBEBE8E6EAE7E5E9E6
            E4E7E5E3E6E4E2E5E2E0E3E1DFE2E0DEE0DEDCDFDDDBDEDCD9DCDAD7DBD9D6D8
            D6D44D75A0BDCDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF547CA6ABBCCDEAE9E7E3E3E3E3E3E3E2E2
            E2E0E0E0DFDFDFDEDEDEDDDDDDDBDBDBDADADAD9D9D9D7D7D7D6D6D6D5D5D5D2
            D3D34D77A1BFCEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF547FA8ABBECFEBEAE8E4E4E4DDDDDDDBDB
            DBE1E1E1E1E1E1E0E0E0DFDFDFDEDEDEDDDDDDDCDCDCDADADAD8D8D8D7D7D7D4
            D5D54E79A3BFCFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5481A9ACBFD1EDEBEADEDEDEEBEBEBECEC
            ECDDDDDDDEDEDECFCFCFD0D0D0CFCFCFCFCFCFCFCFCFCECECED4D4D4D9D9D9D6
            D6D64E7BA6BFD0DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5482ACADC1D2EEECEBE0E0E0EBEBEBECEC
            ECDEDEDEE1E1E1DBDBDBDADADAD9D9D9D8D8D8D7D7D7D6D6D6D8D8D8DADADAD7
            D7D84E7EA8BED0E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5484AEADC2D4EEECEBE7E7E7DFDFDFDEDE
            DEE4E4E4E5E5E5E5E5E5E4E4E4E2E2E2E1E1E1E0E0E0DFDFDFDDDDDDDCDCDCD9
            D9DA4F80AABED1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5485AFAEC3D5EFEDECE9E9E9E8E8E8EFEF
            E7E9E9E6E6E6E6E6E6E6E5E5E5E4E4E4E3E3E3E2E2E2E1E1E1DFDFDFDDDDDDDB
            DBDB5082ADBFD2E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5488B2AFC5D6F1EFEDE4E4E5E7E7E2B6B6
            E3DEDEE4E7E7E3D9D9D9D9D9D9D9D9D9D8D8D8D8D8D8D7D7D7DBDBDBE0DFDFDC
            DCDD5084AFBFD2E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5489B3AFC6D8F2F0EEE6E6E1ACACED3D3D
            F88383EFE9E9E2D5D5D5D4D4D4D4D4D4D4D4D4D3D3D3D2D2D2D9D9D9E1E1E0DE
            DEDE5187B1BFD3E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF548CB6AFC7D9F2F0EEEAEAE8C4C4E4C2C2
            E65454F38686F1EFEFE9E9E9E9E8E8E8E7E7E7E6E6E6E5E5E5E3E3E3E2E2E2DF
            E0E05189B4BFD4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF548EB8B0C8DAF2F0EEECECEDF2F2ECFAFA
            EBCCCCED8B8BF1ECECE9E8E8E8E7E7E7E7E7E7E6E6E6E5E5E5E3E3E3E3E3E3E0
            E1E1518BB6BED4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF558FB9B0CADBF3F1EFE9E9EAEAEAE4E1E1
            E2F1F1E7EDEDEAE6E6E7E6E6E6E6E6E6E5E5E5E4E4E4E3E3E3E4E4E4E4E4E4E2
            E2E2528DB8BFD5E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5591BCB0CADCF4F2F0E7E7E4C4C4EA5555
            F1B1B1EDF2F2E3CDCDCECECECECECECECECECECDCDCDCCCCCCD9D9D9E6E6E6E3
            E3E4538FBBBFD5E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5592BDB0CBDDF4F2F0ECECE8A8A8E68181
            EC4C4CF4B8B8EFEEEEEBEAEAEAE9E9E9E9E9E9E8E8E8E7E7E7E6E6E6E7E6E6E4
            E4E55391BDBFD7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5595BFB0CCDEF3F1EFEDEDEDF2F2EDFCFC
            EC9E9EF16A6AF4F1F1EBEBEBEBEBEBEBEAEAEAEAEAE9E9E8E8E8E8E8E8E7E7E5
            E5E55394BFBFD7E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5595C0B4CFE0F4F1EFEFEEEDF9F3EEFCF4
            EEFFF8EEE6DFEFFAF2EDFAF2EDF9F1EDF9F1ECF8F0EBF7F0EAF0ECE9E9E8E8E9
            E8E75596C2BFD7E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5799C4A5C7DCFCF6F1EFEFEEAFD0E6A1C9
            E4A4CBE4A8CFE4A3CAE4A2C9E3A2C9E3A2C9E3A1C8E29FC7E2C9DBE7F5EFECE4
            E5E64D95C3C0D9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF65A3CA52A0D17FB6D975B2D90988D90080
            DA0080D90080D90084DF0087E40081DB0080D90081DA007FDA3A9BD983B7D86A
            ABD33B90C6CBE0EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCE1EE6EAACE66A4CB5EA3CE098EDD008D
            E3008CE1008EE41C99E33CA7E6028FE1008DE1008DE1008FE52E97D568A6CC66
            A7CE92BFDAF7FBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4BB7EF0AAB
            FC0AA8F70EA0ECD0EDFBFFFFFF60C0F107A8F90AA7F60DA9F6A7DDF8FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6F6FEB6E6
            FBB1E4FB2DB7F1AEDEF6EAF1F847BDF178D2FAB6E5FBC2E9FAFAFEFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF82DBFC0DB4F620B9F422BCF7E8F8FEFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF92E4FF61D9FED9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_EncerramentoClick
          ExplicitTop = 0
        end
      end
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 599
        Height = 376
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object dbg_fechamento: TDBGrid
          AlignWithMargins = True
          Left = 5
          Top = 47
          Width = 589
          Height = 324
          Align = alClient
          Color = clMoneyGreen
          DataSource = ds_paf_aberto
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
          Columns = <
            item
              Expanded = False
              FieldName = 'Data'
              Width = 92
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Tempo'
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Situacao'
              Title.Caption = 'Situa'#231#227'o'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AberturaUsuario'
              Title.Caption = 'Usu'#225'rio'
              Width = 178
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'HaMovimentacao'
              Title.Caption = 'Tem Movimento'
              Width = 92
              Visible = True
            end>
        end
        object RG_controle_paf_nfce: TRadioGroup
          Left = 2
          Top = 2
          Width = 595
          Height = 42
          Align = alTop
          Caption = 'Situa'#231#227'o do Controle PAF NFce'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Aberto'
            'Fechado'
            'Todos')
          TabOrder = 1
          OnClick = RG_controle_paf_nfceClick
        end
      end
    end
    object tbs_PAF_NFC_e: TTabSheet
      Caption = 'Registro do PAF-NFC-e'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnl_registro_paf_nfc_e_body: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 599
        Height = 329
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object pnl_registro_paf_nfc_e_body_top: TPanel
          Left = 2
          Top = 2
          Width = 595
          Height = 48
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 6
            Top = 5
            Width = 51
            Height = 14
            Caption = 'Data Inicial'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 91
            Top = 5
            Width = 45
            Height = 14
            Caption = 'Data final'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Data_Ini: TDateTimePicker
            Left = 4
            Top = 22
            Width = 85
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            TabOrder = 0
          end
          object E_Data_Fim: TDateTimePicker
            Left = 91
            Top = 22
            Width = 85
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            TabOrder = 1
          end
          object Rg_tipo_estoque: TRadioGroup
            Left = 182
            Top = 4
            Width = 139
            Height = 42
            Caption = 'Estoque'
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              'Parcial'
              'Total')
            TabOrder = 2
            OnClick = Rg_tipo_estoqueClick
          end
        end
        object pnl_estoque_parcial: TPanel
          Left = 2
          Top = 50
          Width = 595
          Height = 277
          Align = alClient
          BevelOuter = bvNone
          Enabled = False
          TabOrder = 1
          inline Fm_ListaProdutos: TFm_ListaProdutos
            Left = 0
            Top = 0
            Width = 595
            Height = 43
            Align = alTop
            TabOrder = 0
            ExplicitWidth = 595
            inherited Sb_Produto: TSpeedButton
              Left = 564
              ExplicitLeft = 487
            end
            inherited E_Busca_Produto: TEdit
              Width = 458
              ExplicitWidth = 458
            end
          end
          object pnl_row_2: TPanel
            Left = 0
            Top = 43
            Width = 595
            Height = 43
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Sb_Ins_Produto: TBitBtn
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 131
              Height = 37
              Align = alLeft
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
            object Sb_Exc_Produto: TBitBtn
              AlignWithMargins = True
              Left = 140
              Top = 3
              Width = 131
              Height = 37
              Align = alLeft
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
              TabOrder = 1
              OnClick = Sb_Exc_ProdutoClick
            end
            object Sb_Clear_Produto: TBitBtn
              AlignWithMargins = True
              Left = 277
              Top = 3
              Width = 131
              Height = 37
              Align = alLeft
              Caption = 'Limpar Lista  - F5'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Glyph.Data = {
                360C0000424D360C000000000000360000002800000020000000200000000100
                180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
                FEFDFDFDFDFDFDFCFCFCFCFCFCFDFDFDFDFDFDFEFEFEFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF6F6F6F2F2F2EFEFEFEDEDEDEBEB
                EBEAEAEAEAEAEAEAEAEAEBEBEBECECECEEEEEEEFEFEFF1F1F1F3F3F3F6F6F6F8
                F8F8FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFF7F7F7F0F0F0EAEAEAE5E5E5E0E0E0DDDDDDD7DADB74BC
                CB1DA3BF0D9AB829A1BC169CBA3FBFD42EA7C2E4E5E5E8E8E8EBEBEBEDEDEDF0
                F0F0F3F3F3F6F6F6F9F9F9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFEFEFEF5F5F5EDEDEDE4E4E4DCDCDCD5D5D584C1CB0DA9C452CBDF86E7
                F369DDED4DD4E631BDD5159AB82CD1E67FE4F030A5BDE2E2E2E5E5E5E9E9E9EC
                ECECEFEFEFF2F2F2F5F5F5F9F9F9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFDFDFDF4F4F4EBEBEBE2E2E291CDD518B5CD8AEAF60DABC659D0E327CE
                E421D1E712CAE161D6E70D99B74BD3E62BD2E61EA5BFE1E1E1E5E5E5E8E8E8EB
                EBEBEEEEEEF2F2F2F5F5F5F8F8F8FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFBFBFBF3F3F31DBDD473DDED6DDFF058E6F686EAF60DABC552CF
                E328D5E91ACEE40EC5DE51CEE15FD3E50BCBE263D8E7C2D8DDE8E8E8EBEBEBEE
                EEEEF1F1F1F4F4F4F7F7F7FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF88E0EA39CEDF6DDFF14FD8EC5FE7F75BE5F55CD7E76ED8
                E82ED5EA23D2E814C9E13BCDE15CD2E40BCBE280E4F059B5C8F0F0F0F3F3F3F5
                F5F5F8F8F8FAFAFAFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF11C2D775E6F40EBFD586E8F555D9EE4DD8EC5BE7F76DE7F53AC5
                D935C9E02BD6EA1DCFE50FC5DE57D0E30BCBE25FDDEC0E97B6FBFBFBFDFDFDFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFDFF7FA29CBDFA0F4FE8FEFFA0EBFD48CE7F451D9ED61E8F856E5F581EA
                F66AD6E832D8EC26D3E817C9E112C4DC0BCBE238D5E70D97B6FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFF3FCFD21C9DC9AF4FE9DF3FC34CDE16DDFF150D9ED5EE8F752E3
                F47EE4F22CCCE32DD7EB1ECEE311C5DE0BCBE225D1E51BA2BFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFE8F9FB35D1E38EF2FD9FF4FE8CECF854D9ED64E9F859E6
                F653E3F36DD7E835D9ED29D5E919C9E011CDE31BCEE421AAC5FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFB9EDF36AE3F27BF0FD99F3FE97EEF853DAEE61E9
                F854E4F53FD7EC36D6EB30D8EB21CFE518CFE524D0E514A3BFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF59D6E394F1FB72EFFD96F3FE7EE9F765E9
                F85CE7F750E3F428C3DD38DAED2BD6EA1FD2E73ED7E90DA1BEFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1AC6D9A0F4FE72EFFD72EFFD68E9
                F863EAF957E5F643DAED3FDDEF33D9EC27D4E965DFEE52BDD1FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12C2D69EF4FE72EFFD72EF
                FD6BECFB5FE8F853E4F438D3E83ADBEE26B3C34F7A92D9D5DDFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF17C4D89FF4FE6BEA
                FA71EEFC66EBFA38CBE341C1D04E718C67385FA178A567395DFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF12C2D694F1
                FB89EEFA4D8AA3673B607A4F76A981AE9E73A067375E337D9DFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C49
                6D957190C7AFC9C2A6C5885E8566365E4CAEC61DBED96CE1EF2EB7CEFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9777
                91764D7167375E5B89A663EAF93ACFE54CE1F36BE5F35CDAE912AEC8FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFD5F4F891EFF95FDEF085EFFC78E1F060DBEA0EB6CE1D6E8EFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFC8F1F637D0E230CCDF0FC2D719ACD0117FC1117DC11D7DBA82A1B5FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFD4E1E9338AC21982C4157FC21881C31C6797EBF0F4FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF1D6B993090CD258AC92187C82F8ECA12547EFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF19649458A7D93594D03192CF2D8FCD3E95CE5C
                8AA8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFC1D6E461AAD8469FD7429CD63E9AD4409AD324
                71A1F8FAFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11649868B3E252A7DD4EA4DB4AA2D960
                ADDD1C6490FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EA0BF88C3EA63B1E41B6A9B1A679958
                A9DF3280B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0B5F938AC6ED136597FFFFFF20
                73A780BFE991B6CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9E6EE3481B26DAED62873A138
                89BC8DC8EE5791B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE0EA0F62977BB8DF94
                CBEF3784B4E7EFF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8E6EEA6
                C4D7FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              ParentFont = False
              TabOrder = 2
              OnClick = Sb_Clear_ProdutoClick
            end
          end
          object DBG_Produtos: TDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 89
            Width = 589
            Height = 185
            Align = alClient
            Color = clMoneyGreen
            DataSource = Ds_Items
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Lucida Console'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect]
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clNavy
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'PRO_CODIGO'
                ReadOnly = False
                Title.Caption = 'C'#243'digo Produto'
                Width = 94
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                ReadOnly = False
                Title.Caption = 'Descri'#231#227'o do Produto'
                Width = 445
                Visible = True
              end>
          end
        end
      end
      object pnl_registro_paf_nfc_e_bottom: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 385
        Width = 599
        Height = 69
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_Arquivos: TSpeedButton
          AlignWithMargins = True
          Left = 514
          Top = 5
          Width = 80
          Height = 59
          Align = alRight
          Caption = 'Arquivos - F10'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_ArquivosClick
          ExplicitLeft = 374
          ExplicitTop = 0
        end
      end
      object pnl_local_gracacao: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 338
        Width = 599
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object Sb_local_gravacao: TSpeedButton
          Left = 531
          Top = 13
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = Sb_local_gravacaoClick
        end
        object Label8: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 2
          Width = 156
          Height = 14
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Local de grava'#231#227'o dos arquivos'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_path_diretorio: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 16
          Width = 522
          Height = 20
          Margins.Top = 0
          Align = alLeft
          TabOrder = 0
          Text = 'C:\Sistema\PAF_NFC_E\'
          ExplicitHeight = 21
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 320
    inherited arefas1: TMenuItem
      object Identificao1: TMenuItem [0]
        Caption = 'Identifica'#231#227'o'
        OnClick = Identificao1Click
      end
      object Fechamento1: TMenuItem [1]
        Caption = 'Fechamento'
        OnClick = Fechamento1Click
      end
      object RegistrosdoPAFNFCe1: TMenuItem [2]
        Caption = 'Registros do PAF-NFC-e'
        OnClick = RegistrosdoPAFNFCe1Click
      end
    end
  end
  object cds_Items: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 314
    Top = 189
    object cds_ItemsPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
    end
    object cds_ItemsPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Size = 100
    end
  end
  object Ds_Items: TDataSource
    DataSet = cds_Items
    Left = 314
    Top = 245
  end
  object cds_paf_aberto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 410
    Top = 189
    object cds_paf_abertoData: TStringField
      FieldName = 'Data'
      Size = 10
    end
    object cds_paf_abertoTempo: TStringField
      FieldName = 'Tempo'
      Size = 10
    end
    object cds_paf_abertoSituacao: TStringField
      FieldName = 'Situacao'
      Size = 1
    end
    object cds_paf_abertoAberturaUsuario: TStringField
      FieldName = 'AberturaUsuario'
      Size = 100
    end
    object cds_paf_abertoHaMovimentacao: TStringField
      FieldName = 'HaMovimentacao'
      Size = 1
    end
  end
  object ds_paf_aberto: TDataSource
    DataSet = cds_paf_aberto
    Left = 410
    Top = 245
  end
end
