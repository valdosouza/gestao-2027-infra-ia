object Fr_Vei_OrdemServico: TFr_Vei_OrdemServico
  Left = 259
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ordem de Servi'#231'o'
  ClientHeight = 689
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1012
    Height = 56
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
      1012
      56)
    object Label36: TLabel
      Left = 168
      Top = 12
      Width = 60
      Height = 12
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Ordem'
      FocusControl = E_Busca_Ordem
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Placa: TLabel
      Left = 248
      Top = 12
      Width = 60
      Height = 12
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Placa'
      FocusControl = E_Busca_Ordem
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 320
      Top = 12
      Width = 60
      Height = 12
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Prisma'
      FocusControl = E_Busca_Ordem
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 755
      Top = 13
      Width = 70
      Height = 14
      Caption = 'Cor do Ve'#237'culo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Busca_Cliente: TEdit
      Left = 391
      Top = 28
      Width = 358
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
    object E_Busca_Ordem: TEdit_Setes
      Left = 166
      Top = 28
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
      TabOrder = 2
      Text = ''
    end
    object ChBx_Busca_Nome: TCheckBox
      Left = 393
      Top = 12
      Width = 121
      Height = 12
      Anchors = [akLeft, akBottom]
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object E_Busca_Placa: TEdit
      Left = 246
      Top = 28
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
      MaxLength = 7
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
    end
    object E_Busca_Prisma: TEdit
      Left = 318
      Top = 28
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
      TabOrder = 4
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
      Left = 83
      Top = 28
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 4
      Top = 12
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object ChBx_Busca_Fantasia: TCheckBox
      Left = 509
      Top = 12
      Width = 120
      Height = 12
      Anchors = [akLeft, akBottom]
      Caption = 'Apelido/Fantasia'
      TabOrder = 9
    end
    object Dblcb_CorVeiculo: TDBLookupComboBox
      Left = 755
      Top = 28
      Width = 232
      Height = 22
      KeyField = 'ID'
      ListField = 'DESCRIPTION'
      ListSource = DM.Ds_Color
      TabOrder = 6
    end
  end
  object Pnl_Busca: TGroupBox
    Left = 0
    Top = 56
    Width = 1012
    Height = 276
    Align = alTop
    Caption = 'Resultados da Pesquisa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object DBG_Pesquisa: TDBGrid
      Left = 2
      Top = 15
      Width = 1005
      Height = 259
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clCream
      DataSource = Ds_OrdemServico
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
      OnDblClick = DBG_PesquisaDblClick
      OnTitleClick = DBG_PesquisaTitleClick
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NUMERO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Ordem'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PLACA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Placa'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 97
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRISMA'
          Title.Caption = 'Prisma'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Cliente'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 336
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MARCA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Marca'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 215
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MODELO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Title.Caption = 'Modelo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 188
          Visible = True
        end>
    end
  end
  object Grb_Edicao_Ordem: TPanel
    Left = 0
    Top = 625
    Width = 1012
    Height = 64
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 927
      Top = 4
      Width = 81
      Height = 56
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 926
      ExplicitTop = 11
      ExplicitHeight = 54
    end
    object SB_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 743
      Top = 4
      Width = 90
      Height = 56
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
      OnClick = SB_BuscarClick
      ExplicitLeft = 755
    end
    object SB_Visualizar: TSpeedButton
      AlignWithMargins = True
      Left = 834
      Top = 4
      Width = 92
      Height = 56
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
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
      ExplicitLeft = 669
      ExplicitTop = 10
      ExplicitHeight = 54
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 332
    Width = 1012
    Height = 293
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object Pg_OrdemServico: TPageControl
      Left = 2
      Top = 2
      Width = 1008
      Height = 289
      ActivePage = TabSheet5
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Dados do Ve'#237'culo'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Controle: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 261
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            1000
            261)
          object Label4: TLabel
            Left = 242
            Top = 3
            Width = 32
            Height = 14
            Caption = 'Ordem'
            FocusControl = E_Ors_Numero
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 340
            Top = 3
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
          object Label6: TLabel
            Left = 296
            Top = 46
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
          object Lb_Km: TLabel
            Left = 527
            Top = 3
            Width = 64
            Height = 14
            Caption = 'Kilometragem'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 10
            Top = 84
            Width = 60
            Height = 14
            Caption = 'Observa'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 7
            Top = 46
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
          object Label10: TLabel
            Left = 7
            Top = 3
            Width = 62
            Height = 14
            Caption = 'Data Servi'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Lb_ANo: TLabel
            Left = 667
            Top = 3
            Width = 20
            Height = 14
            Caption = 'Ano'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 532
            Top = 46
            Width = 20
            Height = 14
            Caption = 'Tipo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 345
            Top = 211
            Width = 52
            Height = 14
            Caption = 'Data Sa'#237'da'
            FocusControl = E_Dt_Saida
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 419
            Top = 3
            Width = 25
            Height = 14
            Caption = 'Frota'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 183
            Top = 3
            Width = 23
            Height = 14
            Caption = 'Hora'
            FocusControl = E_Ors_Hora_Entrada
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label16: TLabel
            Left = 433
            Top = 211
            Width = 53
            Height = 14
            Caption = 'Hora Sa'#237'da'
            FocusControl = E_Hr_Saida
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 763
            Top = 46
            Width = 17
            Height = 14
            Caption = 'Cor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Lb_Cilindrada: TLabel
            Left = 733
            Top = 3
            Width = 47
            Height = 14
            Caption = 'Cilindrada'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Servico: TSpeedButton
            Left = 7
            Top = 220
            Width = 102
            Height = 34
            Anchors = [akRight, akBottom]
            Caption = 'Editar - F3'
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
              3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
              700077337F3333373777887007333337007733F773F333337733700070333333
              077037773733333F7F37703707333300080737F373333377737F003333333307
              78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
              078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
              70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
              3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
              33337F73FF737773333307800077033333337337773373333333}
            NumGlyphs = 2
            ParentFont = False
            Transparent = False
            OnClick = Sb_ServicoClick
            ExplicitTop = 214
          end
          object Label24: TLabel
            Left = 112
            Top = 3
            Width = 32
            Height = 14
            Caption = 'Prisma'
            FocusControl = E_Ors_Prisma
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_CheckList: TSpeedButton
            Left = 109
            Top = 220
            Width = 124
            Height = 34
            Anchors = [akRight, akBottom]
            Caption = 'Check-List - F8'
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
            ParentFont = False
            Transparent = False
            OnClick = Sb_CheckListClick
            ExplicitTop = 214
          end
          object E_Ors_Numero: TEdit
            Left = 238
            Top = 19
            Width = 95
            Height = 22
            Color = clHighlightText
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object E_Ors_Obs: TDBMemo
            Left = 7
            Top = 100
            Width = 490
            Height = 107
            DataField = 'OBS'
            DataSource = Ds_OrdemServico
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 13
          end
          object E_Dt_Saida: TEdit
            Left = 344
            Top = 227
            Width = 84
            Height = 22
            Color = clHighlightText
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object E_Vei_Placa: TMaskEdit
            Left = 336
            Top = 19
            Width = 79
            Height = 22
            EditMask = '>LLL-0000;0;_'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            Text = ''
          end
          object E_Vei_Frota: TMaskEdit
            Left = 417
            Top = 19
            Width = 106
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
            Text = ''
          end
          object E_Vei_Ano: TEdit_Setes
            Left = 665
            Top = 19
            Width = 64
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            Text = ''
          end
          object E_Ors_Hora_Entrada: TEdit
            Left = 179
            Top = 19
            Width = 56
            Height = 22
            Color = clHighlightText
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object E_Hr_Saida: TEdit
            Left = 432
            Top = 227
            Width = 66
            Height = 22
            Color = clHighlightText
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 15
          end
          object E_Ors_Km: TEdit
            Left = 526
            Top = 19
            Width = 136
            Height = 22
            Color = clHighlightText
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object E_Vei_Cilindrada: TEdit_Setes
            Left = 730
            Top = 19
            Width = 76
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Text = ''
          end
          object E_Vei_Marca: TEdit
            Left = 8
            Top = 61
            Width = 288
            Height = 21
            ReadOnly = True
            TabOrder = 9
          end
          object E_Vei_Modelo: TEdit
            Left = 298
            Top = 61
            Width = 233
            Height = 21
            ReadOnly = True
            TabOrder = 10
          end
          object E_Vei_Tipo: TEdit
            Left = 532
            Top = 61
            Width = 229
            Height = 21
            ReadOnly = True
            TabOrder = 11
          end
          object E_Ors_Data: TMaskEdit
            Left = 5
            Top = 19
            Width = 102
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = ''
          end
          object E_Vei_Cor: TEdit
            Left = 762
            Top = 61
            Width = 232
            Height = 21
            ReadOnly = True
            TabOrder = 12
          end
          object Grb_Cientes: TGroupBox
            Left = 500
            Top = 86
            Width = 496
            Height = 165
            Caption = 'Contatos do Cliente'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
            object Label19: TLabel
              Left = 7
              Top = 15
              Width = 77
              Height = 14
              Caption = 'Nome do Cliente'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label25: TLabel
              Left = 7
              Top = 52
              Width = 67
              Height = 14
              Caption = 'Nome Contato'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label20: TLabel
              Left = 7
              Top = 123
              Width = 24
              Height = 14
              Caption = 'Fone'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label26: TLabel
              Left = 105
              Top = 123
              Width = 48
              Height = 14
              Caption = 'Fax/Outro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label21: TLabel
              Left = 203
              Top = 123
              Width = 33
              Height = 14
              Caption = 'Celular'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label50: TLabel
              Left = 299
              Top = 123
              Width = 47
              Height = 14
              Caption = 'Comercial'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label53: TLabel
              Left = 397
              Top = 123
              Width = 37
              Height = 14
              Caption = 'Portaria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label22: TLabel
              Left = 7
              Top = 88
              Width = 71
              Height = 14
              Caption = 'E-mail Principal'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Cli_Nome: TEdit
              Left = 7
              Top = 30
              Width = 482
              Height = 22
              ReadOnly = True
              TabOrder = 0
            end
            object E_Cli_Contato: TMaskEdit
              Left = 7
              Top = 67
              Width = 482
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              Text = ''
            end
            object E_Cli_Fax: TEdit_Setes
              Left = 104
              Top = 138
              Width = 96
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
              Text = ''
            end
            object E_Cli_Fone: TEdit_Setes
              Left = 7
              Top = 138
              Width = 96
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              Text = ''
            end
            object E_Cli_Celular: TEdit_Setes
              Left = 203
              Top = 138
              Width = 94
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
              Text = ''
            end
            object E_Cli_Comercial: TEdit_Setes
              Left = 299
              Top = 138
              Width = 94
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 6
              Text = ''
            end
            object E_Cli_Portaria: TEdit_Setes
              Left = 396
              Top = 138
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 7
              Text = ''
            end
            object E_Cli_Email: TEdit
              Left = 7
              Top = 102
              Width = 482
              Height = 22
              CharCase = ecLowerCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 2
            end
          end
          object E_Ors_Prisma: TEdit
            Left = 108
            Top = 19
            Width = 69
            Height = 22
            Color = clHighlightText
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Pe'#231'as Trocadas'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Produto: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 261
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            1000
            261)
          object Sb_Ins_Produto: TSpeedButton
            Left = 6
            Top = 217
            Width = 102
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Inserir - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            OnClick = Sb_Ins_ProdutoClick
            ExplicitTop = 211
          end
          object DBG_Produtos: TDBGrid
            Left = 2
            Top = 2
            Width = 996
            Height = 211
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_ItensProdutos
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
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'Codigo F'#225'brica'
                Width = 157
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o Produto'
                Width = 475
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MED_ABREVIATURA'
                Title.Caption = 'Unidade'
                Width = 66
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'ITF_QTDE'
                Title.Alignment = taCenter
                Title.Caption = 'Qtde'
                Width = 66
                Visible = True
              end>
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Servi'#231'os Executados'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Servico: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 261
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            1000
            261)
          object Sb_Tecnico: TSpeedButton
            Left = 111
            Top = 217
            Width = 102
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'T'#233'cnicos - F9'
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
            ExplicitTop = 211
          end
          object Sb_Ins_Servico: TSpeedButton
            Left = 6
            Top = 217
            Width = 102
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Inserir - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            OnClick = Sb_Ins_ServicoClick
            ExplicitTop = 211
          end
          object DBG_Servicos: TDBGrid
            Left = 2
            Top = 2
            Width = 996
            Height = 211
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_ItensServicos
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
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'Codigo Servi'#231'o'
                Width = 155
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o Servi'#231'o'
                Width = 510
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
              end>
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = 'Anota'#231#245'es'
        ImageIndex = 4
        OnShow = TabSheet5Show
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Annotation: TPanel
          Left = 0
          Top = 0
          Width = 575
          Height = 205
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label2: TLabel
            Left = 7
            Top = 4
            Width = 60
            Height = 12
            AutoSize = False
            Caption = 'Refer'#234'ncia'
            FocusControl = E_Busca_Ordem
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 9
            Top = 39
            Width = 60
            Height = 12
            AutoSize = False
            Caption = 'Anota'#231#227'o'
            FocusControl = E_Busca_Ordem
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Ann_Reference: TEdit
            Left = 7
            Top = 17
            Width = 560
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
          object E_Ann_Obs: TMemo
            Left = 6
            Top = 56
            Width = 563
            Height = 143
            TabOrder = 1
          end
        end
        object Dbg_ListAnnotation: TDBGrid
          Left = 575
          Top = 0
          Width = 425
          Height = 261
          Align = alRight
          Color = clCream
          DataSource = Ds_Annotation
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnTitleClick = DBG_PesquisaTitleClick
          Columns = <
            item
              Expanded = False
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'DT_RECORD'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Title.Caption = 'Data'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 88
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'REFERENCE'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Title.Caption = 'Refer'#234'ncia'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 291
              Visible = True
            end>
        end
        object Pnl_Botao_Annotation: TPanel
          Left = 0
          Top = 208
          Width = 573
          Height = 48
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 2
          DesignSize = (
            573
            48)
          object Sb_Alt_Anotacao: TSpeedButton
            Left = 107
            Top = 5
            Width = 102
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
            OnClick = Sb_Alt_AnotacaoClick
          end
          object Sb_Exc_Anotacao: TSpeedButton
            Left = 209
            Top = 5
            Width = 102
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
            OnClick = Sb_Exc_AnotacaoClick
          end
          object Sb_Ins_Anotacao: TSpeedButton
            Left = 5
            Top = 5
            Width = 102
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Inserir - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            OnClick = Sb_Ins_AnotacaoClick
          end
          object Sb_Grv_Anotacao: TSpeedButton
            Left = 311
            Top = 5
            Width = 102
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Gravar - F5'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            OnClick = Sb_Grv_AnotacaoClick
          end
          object Sb_Can_Anotacao: TSpeedButton
            Left = 414
            Top = 5
            Width = 102
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Cancelar - F6'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            OnClick = Sb_Can_AnotacaoClick
          end
        end
      end
    end
  end
  object Qr_OrdemServico: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterScroll = Qr_OrdemServicoAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'CTC_CODIGO,'
      'CTC_CODPED,'
      'CTC_DATA,'
      'CTC_NUMERO,'
      'CTC_CODEMP,'
      'CTC_CODVDO,'
      'CTC_PRAZO,'
      'PRISMA,'
      'ENTRANCE_DATE,'
      'ENTRANCE_HOUR,'
      'VEI_PLACA, '
      'KM,'
      'tb_vehicle_so.OBS,'
      'EMP_NOME, '
      'EMP_EMAIL, '
      'EMP_MULTIPLICADOR, '
      'CTC_CONTATO,'
      'MRC_DESCRICAO, '
      'MOD_DESCRICAO, '
      'TPV_DESCRICAO, '
      'tb_color.DESCRIPTION, '
      'VEI_FROTA, '
      'VEI_ANO, '
      'VEI_KM, '
      'VEI_CILINDRADA, '
      'EXIT_DATE,'
      'EXIT_HOUR'
      'FROM tb_cotacao'
      '  INNER JOIN tb_empresa '
      '  ON (tb_empresa.emp_codigo = tb_cotacao.ctc_codemp)'
      '  INNER JOIN tb_vehicle_so '
      '  on (tb_vehicle_so.tb_order_id = tb_cotacao.ctc_codped)'
      ''
      '  INNER JOIN tb_vehicle_checklist'
      '  ON (tb_vehicle_checklist.tb_order_id = tb_cotacao.ctc_codped)'
      '  '
      '  INNER JOIN tb_veiculo '
      '  ON (tb_veiculo.vei_placa = tb_vehicle_so.tb_vehicle_id)'
      '  INNER JOIN tb_marca_veiculo '
      '  ON (tb_marca_veiculo.mrc_codigo = tb_veiculo.vei_codmrc) '
      '  INNER JOIN tb_modelo '
      '  ON (tb_modelo.mod_codigo = tb_veiculo.vei_codmod) '
      '  INNER JOIN tb_tp_veiculo '
      '  ON (tb_tp_veiculo.tpv_codigo = tb_veiculo.vei_codtpv) '
      '  INNER JOIN tb_color '
      '  ON (tb_color.id = tb_veiculo.vei_codcor) ')
    Left = 112
    Top = 128
  end
  object Qr_ItensProdutos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  ICT_QTDE'
      'FROM TB_ITENS_CTC ic'
      '   INNER JOIN TB_PRODUTO pr'
      '   ON  (pr.PRO_CODIGO = ic.ICT_CODVCL)'
      '   INNER JOIN TB_MEDIDA m'
      '   ON  (m.MED_CODIGO = pr.PRO_CODMED)'
      '   inner join tb_cotacao c'
      '   on (c.ctc_codigo = ic.ict_codctc)'
      '   left outer join tb_pedido pe'
      '   on (pe.ped_codigo = c.ctc_codped)'
      
        'WHERE (ICT_CODPED =:PED_CODIGO) AND (PRO_TIPO <> '#39'S'#39') and (PED_C' +
        'ODIGO IS NULL)'
      'union'
      'SELECT'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  ITF_QTDE'
      'FROM TB_ITENS_NFL if'
      '   INNER JOIN TB_PRODUTO pr'
      '   ON  (pr.PRO_CODIGO = if.itf_codpro)'
      '   INNER JOIN TB_MEDIDA m'
      '   ON  (m.MED_CODIGO = pr.PRO_CODMED)'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO <> '#39'S'#39')'
      'ORDER BY 2')
    Left = 225
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_ItensServicos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  ICT_QTDE'
      'FROM TB_ITENS_CTC ic'
      '   INNER JOIN TB_PRODUTO pr'
      '   ON  (pr.PRO_CODIGO = ic.ICT_CODVCL)'
      '   INNER JOIN TB_MEDIDA m'
      '   ON  (m.MED_CODIGO = pr.PRO_CODMED)'
      '   inner join tb_cotacao c'
      '   on (c.ctc_codigo = ic.ict_codctc)'
      '   left outer join tb_pedido pe'
      '   on (pe.ped_codigo = c.ctc_codped)'
      
        'WHERE (ICT_CODPED =:PED_CODIGO) AND (PRO_TIPO = '#39'S'#39') and (PED_CO' +
        'DIGO IS NULL)'
      'union'
      'SELECT'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  MED_ABREVIATURA,'
      '  ITF_QTDE'
      'FROM TB_ITENS_NFL if'
      '   INNER JOIN TB_PRODUTO pr'
      '   ON  (pr.PRO_CODIGO = if.itf_codpro)'
      '   INNER JOIN TB_MEDIDA m'
      '   ON  (m.MED_CODIGO = pr.PRO_CODMED)'
      'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = '#39'S'#39')'
      'ORDER BY 2')
    Left = 361
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_ItensProdutos: TDataSource
    DataSet = Qr_ItensProdutos
    Left = 224
    Top = 200
  end
  object Ds_ItensServicos: TDataSource
    DataSet = Qr_ItensServicos
    Left = 328
    Top = 200
  end
  object Ds_OrdemServico: TDataSource
    DataSet = Qr_OrdemServico
    Left = 104
    Top = 208
  end
  object Qr_Annotation: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterScroll = Qr_AnnotationAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select *'
      'from tb_annotation'
      'where (link_id1 = :link_id1) ')
    Left = 625
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'link_id1'
        ParamType = ptUnknown
      end>
  end
  object Ds_Annotation: TDataSource
    DataSet = Qr_Annotation
    Left = 600
    Top = 208
  end
end
