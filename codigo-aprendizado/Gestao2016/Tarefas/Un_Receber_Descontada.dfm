object Fr_Receber_Descontada: TFr_Receber_Descontada
  Left = 485
  Top = 56
  Anchors = [akTop, akBottom]
  BorderStyle = bsDialog
  Caption = 'Controle para Descontar Duplicatas'
  ClientHeight = 578
  ClientWidth = 796
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Total: TPanel
    Left = 0
    Top = 427
    Width = 796
    Height = 89
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object lc_fornecedor: TLabel
      Left = 107
      Top = 4
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
      Left = 579
      Top = 17
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SB_fornecedorClick
    end
    object Label2: TLabel
      Left = 7
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
    object Label14: TLabel
      Left = 8
      Top = 42
      Width = 64
      Height = 14
      Caption = 'Valor Original'
      FocusControl = E_VL_Original
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 189
      Top = 42
      Width = 76
      Height = 14
      Caption = 'Valor Opera'#231#227'o'
      FocusControl = E_VL_Original
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 280
      Top = 42
      Width = 62
      Height = 14
      Caption = 'Valor Liquido'
      FocusControl = E_VL_Liquido
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 97
      Top = 43
      Width = 74
      Height = 14
      Caption = 'Taxa Opera'#231#227'o'
      FocusControl = E_VL_Original
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Pesq_Cliente: TSpeedButton
      Left = 602
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
    object DBLCB_Fornecedor: TDBLookupComboBox
      Left = 199
      Top = 18
      Width = 377
      Height = 21
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_NOME'
      ListSource = Ds_Fornecedor
      TabOrder = 2
      OnExit = DBLCB_FornecedorExit
    end
    object chbx_NomeFornecedor: TCheckBox
      Left = 259
      Top = 2
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
      TabOrder = 7
      OnClick = chbx_NomeFornecedorClick
    end
    object chbx_fantasiaFornecedor: TCheckBox
      Left = 380
      Top = 2
      Width = 104
      Height = 15
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = chbx_fantasiaFornecedorClick
    end
    object E_Cd_Fornecedor: TDBEdit
      Left = 107
      Top = 18
      Width = 90
      Height = 21
      DataField = 'PED_CODEMP'
      TabOrder = 1
      OnExit = E_Cd_FornecedorExit
      OnKeyPress = E_Cd_FornecedorKeyPress
    end
    object E_Data: TDateTimePicker
      Left = 4
      Top = 18
      Width = 103
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_VL_Original: TEdit_Setes
      Left = 5
      Top = 55
      Width = 90
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 3
      Text = ''
    end
    object E_VL_Operacao: TEdit_Setes
      Left = 187
      Top = 55
      Width = 90
      Height = 21
      Alignment = taRightJustify
      TabOrder = 5
      Text = ''
      OnExit = E_VL_OperacaoExit
    end
    object E_VL_Liquido: TEdit_Setes
      Left = 278
      Top = 55
      Width = 90
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 6
      Text = ''
    end
    object E_Tx_Operacao: TEdit_Setes
      Left = 95
      Top = 55
      Width = 90
      Height = 21
      Alignment = taRightJustify
      TabOrder = 4
      Text = ''
      OnExit = E_Tx_OperacaoExit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 516
    Width = 796
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      796
      62)
    object SB_Sair_0: TSpeedButton
      Left = 705
      Top = 4
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 701
    end
    object Sb_Descontar: TSpeedButton
      Left = 619
      Top = 4
      Width = 85
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Descontar - F9'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = Sb_DescontarClick
      ExplicitLeft = 615
    end
  end
  object pnl_Busca: TPanel
    Left = 0
    Top = 0
    Width = 796
    Height = 291
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object GroupBox3: TGroupBox
      Left = 2
      Top = 2
      Width = 792
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
        Left = 236
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
        Left = 320
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
        Left = 406
        Top = 13
        Width = 68
        Height = 14
        Caption = 'C'#243'digo Cliente'
      end
      object Sb_Pesq_Empresa: TSpeedButton
        Left = 759
        Top = 25
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
      object E_BuscaPedido: TEdit_Setes
        Left = 169
        Top = 27
        Width = 65
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
        Left = 485
        Top = 27
        Width = 269
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
        Left = 236
        Top = 27
        Width = 82
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object E_BuscaFinanceiro: TEdit
        Left = 320
        Top = 27
        Width = 84
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
      object Rg_Situacao: TRadioGroup
        Left = 175
        Top = 49
        Width = 193
        Height = 38
        Caption = 'Situa'#231#227'o '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #192' Receber'
          'Descontadas')
        TabOrder = 7
        OnClick = SB_BuscarClick
      end
      object ChBx_Nome: TCheckBox
        Left = 485
        Top = 9
        Width = 121
        Height = 17
        Caption = 'Nome/Raz'#227'o Social'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 8
        OnClick = ChBx_NomeClick
      end
      object ChBx_Fantasia: TCheckBox
        Left = 606
        Top = 9
        Width = 102
        Height = 17
        Caption = 'Apelido/Fantasia'
        TabOrder = 9
        OnClick = ChBx_FantasiaClick
      end
      object Rg_Data: TRadioGroup
        Left = 3
        Top = 50
        Width = 167
        Height = 38
        Caption = 'Tipo de Data'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Emiss'#227'o'
          'Vencimento')
        TabOrder = 10
        OnClick = Rg_DataClick
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
        TabOrder = 11
        OnClick = ChBx_PeriodoClick
      end
      object E_Busca_Cd_Empresa: TEdit
        Left = 406
        Top = 27
        Width = 77
        Height = 22
        TabOrder = 5
        OnExit = E_Busca_Cd_EmpresaExit
      end
      inline Fm_TipoCobranca: TFm_FormaPagto
        Left = 488
        Top = 50
        Width = 247
        Height = 37
        TabOrder = 12
        ExplicitLeft = 488
        ExplicitTop = 50
        ExplicitWidth = 247
        ExplicitHeight = 37
        inherited Lb_FormaPagamento: TLabel
          Width = 241
          Caption = 'Tipo de Cobran'#231'a'
          ExplicitWidth = 85
        end
        inherited pnl_Forma: TPanel
          Width = 247
          Height = 23
          ExplicitWidth = 247
          ExplicitHeight = 23
          inherited SB_FormaPag: TSpeedButton
            Left = 221
            Height = 20
            ExplicitLeft = 219
            ExplicitTop = 13
            ExplicitHeight = 29
          end
          inherited DBLCB_FormaPagto: TDBLookupComboBox
            Width = 212
            Height = 22
            ExplicitWidth = 212
            ExplicitHeight = 22
          end
        end
      end
      object Rg_Baixa: TRadioGroup
        Left = 368
        Top = 50
        Width = 118
        Height = 38
        Caption = 'Documento Baixado'
        Columns = 2
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          'N'#227'o'
          'SIM')
        TabOrder = 13
        OnClick = Rg_BaixaClick
      end
    end
    object StrGrd_Parcela: TStringGrid
      Left = 2
      Top = 94
      Width = 792
      Height = 135
      Align = alClient
      Color = clCream
      ColCount = 24
      DefaultColWidth = 40
      DefaultRowHeight = 18
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ParentFont = False
      TabOrder = 1
      OnDblClick = SB_AdicionarClick
      OnDrawCell = StrGrd_ParcelaDrawCell
      OnMouseMove = StrGrd_ParcelaMouseMove
      ColWidths = (
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
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
    object pnl_botao: TPanel
      Left = 2
      Top = 229
      Width = 792
      Height = 60
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      object Sb_Duplicata: TSpeedButton
        AlignWithMargins = True
        Left = 163
        Top = 5
        Width = 79
        Height = 50
        Margins.Left = 1
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
        ExplicitLeft = 176
        ExplicitTop = 206
        ExplicitHeight = 54
      end
      object SB_Buscar: TSpeedButton
        AlignWithMargins = True
        Left = 404
        Top = 5
        Width = 79
        Height = 50
        Margins.Left = 1
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
        ExplicitLeft = 410
        ExplicitTop = 206
        ExplicitHeight = 54
      end
      object SB_Add_Tudo: TSpeedButton
        AlignWithMargins = True
        Left = 485
        Top = 5
        Width = 74
        Height = 50
        Margins.Left = 1
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
        ExplicitLeft = 489
        ExplicitTop = 206
        ExplicitHeight = 54
      end
      object SB_Adicionar: TSpeedButton
        AlignWithMargins = True
        Left = 561
        Top = 5
        Width = 74
        Height = 50
        Margins.Left = 1
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
        ExplicitLeft = 563
        ExplicitTop = 206
        ExplicitHeight = 54
      end
      object SB_Retirar: TSpeedButton
        AlignWithMargins = True
        Left = 637
        Top = 5
        Width = 74
        Height = 50
        Margins.Left = 1
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
        ExplicitLeft = 643
        ExplicitTop = 0
        ExplicitHeight = 54
      end
      object SB_Retirar_Tudo: TSpeedButton
        AlignWithMargins = True
        Left = 713
        Top = 5
        Width = 74
        Height = 50
        Margins.Left = 1
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
        ExplicitLeft = 703
        ExplicitTop = 0
        ExplicitHeight = 54
      end
      object Sb_Cancelar: TSpeedButton
        AlignWithMargins = True
        Left = 244
        Top = 5
        Width = 79
        Height = 50
        Margins.Left = 1
        Margins.Right = 1
        Align = alRight
        Caption = 'Cancelar - F5'
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
        OnClick = Sb_CancelarClick
        ExplicitLeft = 261
        ExplicitTop = 206
        ExplicitHeight = 54
      end
      object Sb_Baixa: TSpeedButton
        AlignWithMargins = True
        Left = 325
        Top = 5
        Width = 77
        Height = 50
        Margins.Left = 1
        Margins.Right = 1
        Align = alRight
        Caption = 'Baixar - F6'
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
        OnClick = Sb_BaixaClick
        ExplicitLeft = 327
        ExplicitTop = 206
        ExplicitHeight = 54
      end
    end
  end
  object StrGrd_Duplicata: TStringGrid
    Left = 0
    Top = 291
    Width = 796
    Height = 136
    Align = alClient
    Color = clMoneyGreen
    ColCount = 19
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
    TabOrder = 3
    OnDblClick = StrGrd_DuplicataDblClick
    OnDrawCell = StrGrd_DuplicataDrawCell
    ColWidths = (
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
      40
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
    Left = 47
    Top = 379
  end
  object Ds_Parcelas: TDataSource
    DataSet = Qr_Parcelas
    OnDataChange = Ds_ParcelasDataChange
    Left = 48
    Top = 410
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
    Left = 88
    Top = 380
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
    Left = 128
    Top = 380
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
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
      '  EMP_FANTASIA,'
      'EMP_CODVDOR'
      'FROM TB_EMPRESA'
      'WHERE EMP_ATIVA = '#39'S'#39
      'ORDER BY EMP_NOME')
    Left = 164
    Top = 378
  end
  object Ds_Fornecedor: TDataSource
    DataSet = Qr_Fornecedor
    Left = 164
    Top = 409
  end
  object Pop_Menu: TPopupMenu
    Left = 456
    Top = 120
  end
end
