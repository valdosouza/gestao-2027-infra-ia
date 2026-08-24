object Fr_Despacho: TFr_Despacho
  Left = 277
  Top = 23
  Anchors = [akTop, akBottom]
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Controle de Despacho de Mercadorias'
  ClientHeight = 614
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 857
    Height = 102
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label11: TLabel
      Left = 8
      Top = 14
      Width = 67
      Height = 14
      Caption = 'Ordem/Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_CodigoCliente: TLabel
      Left = 289
      Top = 14
      Width = 68
      Height = 14
      Caption = 'C'#243'digo Cliente'
    end
    object Sb_Pesq_Empresa: TSpeedButton
      Left = 769
      Top = 30
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
    object E_CodPed: TMaskEdit
      Left = 6
      Top = 30
      Width = 114
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object Rg_Filtro: TRadioGroup
      Left = 502
      Top = 56
      Width = 248
      Height = 40
      Caption = 'Filtro'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Pendentes'
        'Entregues'
        'Todos')
      ParentFont = False
      TabOrder = 5
      OnClick = Rg_FiltroClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 123
      Top = 30
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 205
      Top = 30
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 125
      Top = 14
      Width = 128
      Height = 13
      Caption = 'Data Inicial    Data Final'
      TabOrder = 6
      OnClick = ChBx_PeriodoClick
    end
    object ChBx_Nome: TCheckBox
      Left = 370
      Top = 12
      Width = 121
      Height = 17
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 7
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 486
      Top = 14
      Width = 102
      Height = 13
      Caption = 'Apelido/Fantasia'
      TabOrder = 8
      OnClick = ChBx_FantasiaClick
    end
    object E_cd_Empresa: TEdit
      Left = 289
      Top = 30
      Width = 77
      Height = 22
      TabOrder = 3
      OnExit = E_cd_EmpresaExit
    end
    object Cb_Busca_Empresa: TComboBox
      Left = 370
      Top = 30
      Width = 397
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 4
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 4
      Top = 54
      Width = 499
      Height = 43
      TabOrder = 9
      ExplicitLeft = 4
      ExplicitTop = 54
    end
  end
  object DBG_Pesquisa: TDBGrid
    Left = 0
    Top = 102
    Width = 857
    Height = 199
    Align = alClient
    Color = clCream
    DataSource = Ds_Vendas
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
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
        FieldName = 'EMP_NOME'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Title.Caption = 'Nome do Cliente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 405
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_NUMERO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Title.Caption = 'Pedido'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 105
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PED_DATA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Title.Caption = 'Data Pedido'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_VL_PEDIDO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Title.Caption = 'Valor Pedido'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 110
        Visible = True
      end>
  end
  object Pg_Info: TPageControl
    Left = 0
    Top = 301
    Width = 857
    Height = 249
    ActivePage = Tbs_Pendente
    Align = alBottom
    TabOrder = 2
    OnChange = Pg_InfoChange
    object Tbs_Pendente: TTabSheet
      Caption = 'Pendendes'
      ImageIndex = 2
      object Pnl_despachar: TPanel
        Left = 0
        Top = 41
        Width = 849
        Height = 180
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Lb_DetalhePendente: TLabel
          Left = 2
          Top = 2
          Width = 845
          Height = 19
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Detalhes dos itens  para despachar'
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 788
        end
        object Dbg_Pendente: TDBGrid
          Left = 2
          Top = 21
          Width = 845
          Height = 157
          Align = alClient
          BorderStyle = bsNone
          DataSource = Ds_Pendente
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnTitleClick = Dbg_PendenteTitleClick
          Columns = <
            item
              Expanded = False
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'PRO_CODIGOFAB'
              Title.Caption = 'C'#243'd. F'#225'brica'
              Width = 113
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o do Produto'
              Width = 438
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DSP_DT_PREVISTA'
              Title.Alignment = taCenter
              Title.Caption = 'Data Prevista'
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DSP_QTDE'
              Title.Alignment = taCenter
              Title.Caption = 'Qtde Pendente'
              Width = 80
              Visible = True
            end>
        end
      end
      object Pnl_Top_Despachar: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 41
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        Visible = False
        object Lb_Item_lancado: TLabel
          AlignWithMargins = True
          Left = 209
          Top = 10
          Width = 635
          Height = 22
          Margins.Top = 8
          Margins.Bottom = 7
          Align = alClient
          AutoSize = False
          Caption = 'Lan'#231'ar item'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          ExplicitTop = 6
          ExplicitHeight = 31
        end
        object Label30: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 10
          Width = 22
          Height = 26
          Margins.Top = 8
          Align = alLeft
          Alignment = taCenter
          Caption = 'F2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 20
        end
        object E_BuscaCodigo: TEdit_Setes
          AlignWithMargins = True
          Left = 33
          Top = 5
          Width = 170
          Height = 31
          TabStop = False
          Align = alLeft
          CharCase = ecUpperCase
          Color = clScrollBar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnKeyPress = E_BuscaCodigoKeyPress
          IsCodigo = True
          ExplicitHeight = 28
        end
      end
    end
    object Tbs_Despachado: TTabSheet
      Caption = 'Despachados'
      ImageIndex = 1
      object Pn_Fundo2: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 221
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          849
          221)
        object Lb_detalheDepacho: TLabel
          Left = 2
          Top = 2
          Width = 845
          Height = 19
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Detalhes dos itens  despachados'
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 788
        end
        object SB_Add_Tudo_Despachados: TSpeedButton
          Left = 9
          Top = 192
          Width = 109
          Height = 24
          Anchors = [akTop, akBottom]
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
          OnClick = SB_Add_Tudo_DespachadosClick
          ExplicitLeft = 5
        end
        object SB_Retirar_Tudo_Despachados: TSpeedButton
          Left = 127
          Top = 192
          Width = 107
          Height = 24
          Anchors = [akTop, akBottom]
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
          OnClick = SB_Retirar_Tudo_DespachadosClick
          ExplicitLeft = 115
        end
        object StrGrd_Despachados: TStringGrid
          Left = 2
          Top = 21
          Width = 845
          Height = 166
          Align = alTop
          Color = clCream
          ColCount = 9
          DefaultColWidth = 40
          DefaultRowHeight = 18
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          ParentFont = False
          TabOrder = 0
          OnClick = StrGrd_DespachadosClick
          OnDrawCell = StrGrd_DespachadosDrawCell
          ColWidths = (
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
      end
    end
    object Tbs_ItensPedido: TTabSheet
      Caption = 'Itens do Pedido'
      object Pn_Fundo1: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 221
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Lb_DetalhePedido: TLabel
          Left = 2
          Top = 2
          Width = 845
          Height = 19
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Detalhes do Pedido'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 788
        end
        object Dbg_ItensVda: TDBGrid
          Left = 2
          Top = 21
          Width = 845
          Height = 198
          Align = alClient
          BorderStyle = bsNone
          DataSource = Ds_ItensVda
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnTitleClick = Dbg_ItensVdaTitleClick
          Columns = <
            item
              Expanded = False
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'PRO_CODIGOFAB'
              Title.Caption = 'C'#243'd. F'#225'brica'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 112
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o do Produto'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 380
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_QTDE'
              Title.Caption = 'Qtde'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_UNIT'
              Title.Caption = 'Vl. Unit'#225'rio'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 84
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_SB_TOTAL'
              Title.Caption = 'Sub Total'
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
    end
    object Tbs_Devolucao: TTabSheet
      Caption = 'Controle de Devolu'#231#227'o na separa'#231#227'o'
      ImageIndex = 3
      object Pnl_devolucao: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 221
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          849
          221)
        object Label1: TLabel
          Left = 2
          Top = 2
          Width = 845
          Height = 19
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Detalhes dos itens separados que devem ser devolvidos '
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 788
        end
        object SB_Add_Tudo_Devolucao: TSpeedButton
          Left = 9
          Top = 192
          Width = 109
          Height = 24
          Anchors = [akTop, akBottom]
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
          OnClick = SB_Add_Tudo_DevolucaoClick
          ExplicitLeft = 5
        end
        object SB_Retirar_Tudo_Devolucao: TSpeedButton
          Left = 127
          Top = 192
          Width = 107
          Height = 24
          Anchors = [akTop, akBottom]
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
          OnClick = SB_Retirar_Tudo_DevolucaoClick
          ExplicitLeft = 115
        end
        object Sb_Exc_ItensSelecionados: TSpeedButton
          Left = 244
          Top = 192
          Width = 158
          Height = 24
          Anchors = [akBottom]
          Caption = 'Excluir Itens Selecionados'
          Enabled = False
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
          OnClick = Sb_Exc_ItensSelecionadosClick
          ExplicitLeft = 222
        end
        object StrGrd_Devolucao: TStringGrid
          Left = 2
          Top = 21
          Width = 845
          Height = 166
          Align = alTop
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
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          ParentFont = False
          TabOrder = 0
          OnClick = StrGrd_DevolucaoClick
          OnDrawCell = StrGrd_DevolucaoDrawCell
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
      end
    end
  end
  object Pnl_botao: TPanel
    Left = 0
    Top = 550
    Width = 857
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    DesignSize = (
      857
      64)
    object SB_Imprimir: TSpeedButton
      Left = 676
      Top = 5
      Width = 87
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Imprimir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitLeft = 619
    end
    object SB_Sair_0: TSpeedButton
      Left = 764
      Top = 5
      Width = 87
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 707
    end
    object SB_Despachar: TSpeedButton
      Left = 414
      Top = 5
      Width = 87
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Despacho - F3'
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
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
        77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
        07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_DespacharClick
      ExplicitLeft = 357
    end
    object Sb_Retornar: TSpeedButton
      Left = 507
      Top = 6
      Width = 87
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Retornar - F4'
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
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880F9F9F07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F0091100F
        77037F3737333737FF7F08090919110907037F737F3333737F7F0F0F0999910F
        07037F737F3333737F7F0F090F99190908037F737FF33373737F0F7F00FF900F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80F9F9F08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_RetornarClick
    end
    object SB_Buscar: TSpeedButton
      Left = 589
      Top = 5
      Width = 87
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
      ExplicitLeft = 532
    end
  end
  object Ds_Vendas: TDataSource
    DataSet = Qr_Vendas
    Left = 81
    Top = 186
  end
  object Ds_ItensVda: TDataSource
    DataSet = Qr_ItensVda
    Left = 309
    Top = 186
  end
  object Qr_Vendas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_VendasAfterOpen
    AfterScroll = Qr_VendasAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT '
      'PED_CODIGO, '
      'EMP_NOME, '
      'EMP_FANTASIA, '
      'PED_DATA, '
      'PED_NUMERO, '
      'PED_VL_PEDIDO'
      'FROM tb_despacho tb_despacho '
      '  INNER JOIN TB_PEDIDO Tb_pedido '
      '  ON  (Tb_pedido.PED_codigo = tb_despacho.DSP_CODPED)   '
      '  inner JOIN tb_empresa tb_empresa ON '
      ' (tb_empresa.emp_codigo = Tb_pedido.PED_codemp)'
      'WHERE (PED_TIPO = 1)')
    Left = 83
    Top = 136
  end
  object Qr_ItensVda: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ItensVdaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT ITF_CODIGO, PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO, GRP' +
        '_DESCRICAO, ITF_QTDE, ITF_VL_UNIT, ITF_CODPRO, (ITF_QTDE* ITF_VL' +
        '_UNIT) ITF_VL_SB_TOTAL, PRO_CODIGOFOR,ITF_ESTOQUE, ITF_DESPACHO'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_GRUPOS Tb_grupos'
      '   ON  (Tb_grupos.GRP_CODIGO = Tb_produto.PRO_CODGRP)'
      'WHERE (ITF_CODPED=:PED_CODIGO)  AND PRO_TIPO <> '#39'S'#39)
    Left = 311
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Cliente: TDataSource
    DataSet = Qr_Clientes
    Left = 477
    Top = 186
  end
  object Ds_Produto: TDataSource
    DataSet = Qr_Produtos
    Left = 549
    Top = 186
  end
  object Qr_Produtos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CODIGOFAB, PRO_CODIGOFOR'
      'FROM TB_PRODUTO'
      'ORDER BY PRO_DESCRICAO')
    Left = 551
    Top = 136
  end
  object Qr_Clientes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT EMP_CODIGO, EMP_FANTASIA, EMP_NOME'
      'FROM TB_EMPRESA'
      'ORDER BY EMP_FANTASIA')
    Left = 478
    Top = 136
  end
  object Qr_Despachados: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_DespachadosAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    DSP_CODIGO,'
      '    PRO_CODIGO,'
      '   PRO_CODIGOFAB,'
      '    PRO_DESCRICAO,'
      '    DSP_DT_PREVISTA,'
      '    DSP_QTDE,'
      '   ITF_CODPED,'
      '    ITF.ITF_CODIGO,'
      '    ITF.ITF_QTDE,'
      '   ITF_CODEST,'
      '    DSP_DT_REALIZADA,'
      '   DSP_IMPRESSO'
      'FROM TB_DESPACHO DSP'
      '  INNER JOIN TB_ITENS_NFL ITF'
      '  ON (DSP.DSP_CODITF = ITF.ITF_CODIGO)'
      '  INNER JOIN TB_PRODUTO PRO'
      '  ON (ITF.ITF_CODPRO = PRO.PRO_CODIGO)'
      'WHERE (ITF_CODPED =:PED_CODIGO) '
      '      AND DSP_SITUACAO = '#39'S'#39' '
      '     AND PRO_TIPO <> '#39'S'#39
      'order by PRO_DESCRICAO,DSP_DT_REALIZADA')
    Left = 234
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Despacho: TDataSource
    DataSet = Qr_Despachados
    Left = 240
    Top = 186
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 616
    Top = 136
  end
  object Qr_Pendente: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_PendenteAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT distinct'
      '  DSP.DSP_CODIGO,'
      '  ITF.ITF_CODIGO,'
      '  PRO_CODIGO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  DSP_DT_PREVISTA,'
      '  ITF_CODPED,'
      '  DSP.DSP_QTDE,'
      '  ITF_CODEST,'
      'PRO_CODIGOBAR'
      'FROM TB_ITENS_NFL ITF'
      '  inner JOIN TB_DESPACHO DSP'
      '  ON (DSP.DSP_CODITF = ITF.ITF_CODIGO)'
      '  INNER JOIN TB_PRODUTO PRO'
      '  ON (ITF.ITF_CODPRO = PRO.PRO_CODIGO)'
      'WHERE ITF_CODPED =:PED_CODIGO '
      '      AND DSP_SITUACAO = '#39'P'#39
      '      AND PRO_TIPO <> '#39'S'#39
      'order by PRO_DESCRICAO,  DSP_DT_PREVISTA')
    Left = 152
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Pendente: TDataSource
    DataSet = Qr_Pendente
    Left = 150
    Top = 186
  end
  object Qr_Itens_Despachados: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT SUM(DSP_QTDE) DSP_SALDO'
      'FROM TB_ITENS_NFL ITF'
      '  inner JOIN TB_DESPACHO DSP'
      '  ON (DSP.DSP_CODITF = ITF.ITF_CODIGO)'
      'WHERE ITF_CODPED =:PED_CODIGO and ITF_CODPRO=:PRO_CODIGO')
    Left = 698
    Top = 135
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Devolvidos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    DSP_CODIGO,'
      '    PRO_CODIGO,'
      '    PRO_CODIGOFAB,'
      '    PRO_DESCRICAO,'
      '    DSP_DT_PREVISTA,'
      '    DSP_QTDE,'
      '    DSP_DT_REALIZADA'
      'FROM TB_DESPACHO DSP'
      '  INNER JOIN TB_PRODUTO PRO'
      '  ON (DSP.DSP_CODPRO = PRO.PRO_CODIGO)'
      'WHERE DSP_QTDE >0 '
      '        and DSP_SITUACAO = '#39'D'#39
      '       AND PRO_TIPO <> '#39'S'#39
      'order by PRO_DESCRICAO,DSP_DT_REALIZADA')
    Left = 400
    Top = 136
  end
  object Ds_Devolvidos: TDataSource
    DataSet = Qr_Devolvidos
    Left = 390
    Top = 186
  end
  object Ac_Funcoes: TActionList
    Left = 110
    Top = 506
    object Liberacao: TAction
      Caption = 'Liberacao'
      ShortCut = 16449
      OnExecute = LiberacaoExecute
    end
  end
end
