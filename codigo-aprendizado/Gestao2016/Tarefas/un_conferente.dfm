object Fr_Conferente: TFr_Conferente
  Left = 283
  Top = 115
  AutoSize = True
  Caption = 'Confer'#234'ncia Venda'
  ClientHeight = 547
  ClientWidth = 908
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Conferente: TPageControl
    Left = 0
    Top = 0
    Width = 908
    Height = 547
    ActivePage = tbs_Confere
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tbs_Confere: TTabSheet
      Caption = 'tbs_Confere'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pnl_Fundo: TPanel
        Left = 0
        Top = 0
        Width = 900
        Height = 49
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label2: TLabel
          Left = 101
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
        object Label4: TLabel
          Left = 187
          Top = 4
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
        object Label1: TLabel
          Left = 9
          Top = 4
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
        object Label3: TLabel
          Left = 577
          Top = 4
          Width = 92
          Height = 14
          Caption = 'Nome do Vendedor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Sb_Pesq_Empresa: TSpeedButton
          Left = 550
          Top = 18
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
        object E_Cliente: TEdit_Setes
          Left = 187
          Top = 18
          Width = 360
          Height = 21
          TabOrder = 1
          Text = ''
        end
        object E_Nr_Pedido: TEdit_Setes
          Left = 7
          Top = 18
          Width = 87
          Height = 21
          TabStop = False
          TabOrder = 0
          Text = ''
        end
        object E_Vendedor: TEdit_Setes
          Left = 577
          Top = 18
          Width = 326
          Height = 21
          TabOrder = 2
          Text = ''
        end
        object E_Data: TEdit_Setes
          Left = 96
          Top = 18
          Width = 89
          Height = 21
          TabStop = False
          TabOrder = 3
          Text = ''
        end
      end
      object Pnl_Botao: TPanel
        Left = 0
        Top = 450
        Width = 900
        Height = 66
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          900
          66)
        object SB_Faturar: TSpeedButton
          Left = 668
          Top = 6
          Width = 75
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 676
        end
        object SB_Imprimir: TSpeedButton
          Left = 743
          Top = 6
          Width = 75
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 751
        end
        object Sb_Pesquisar: TSpeedButton
          Left = 591
          Top = 6
          Width = 77
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 599
        end
        object Sb_Sair_0: TSpeedButton
          Left = 818
          Top = 6
          Width = 75
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
          OnClick = Sb_Sair_0Click
          ExplicitLeft = 826
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 402
        Width = 900
        Height = 48
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object Label5: TLabel
          Left = 338
          Top = 4
          Width = 81
          Height = 13
          Caption = 'C'#243'digo de Barras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 253
          Top = 4
          Width = 78
          Height = 13
          Caption = 'Confer'#234'ncia - F2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Rg_Filtro: TRadioGroup
          Left = 2
          Top = 2
          Width = 248
          Height = 44
          Align = alLeft
          Caption = 'Filtro'
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Pendentes'
            'Conferidos'
            'Todos')
          ParentFont = False
          TabOrder = 2
          OnClick = Rg_FiltroClick
        end
        object E_Conferencia: TEdit_Setes
          Left = 252
          Top = 18
          Width = 82
          Height = 24
          TabStop = False
          Alignment = taCenter
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '1'
          OnEnter = E_ConferenciaEnter
        end
        object E_Cd_Barras: TEdit
          Left = 337
          Top = 18
          Width = 253
          Height = 24
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 1
          OnKeyPress = E_Cd_BarrasKeyPress
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 49
        Width = 900
        Height = 353
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 3
        object DBG_Produtos: TDBGrid
          Left = 2
          Top = 2
          Width = 896
          Height = 349
          Align = alClient
          Color = clMoneyGreen
          DataSource = Ds_Itens
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
          OnDrawColumnCell = DBG_ProdutosDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'PRO_CODIGOFAB'
              Title.Caption = 'C'#243'digo'
              Width = 133
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 326
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_QTDE'
              Title.Caption = 'Quantidade'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_UNIT'
              Title.Caption = 'Valor Unit'#225'rio'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_TOTAL'
              Title.Caption = 'Subtotal'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DSP_CONFERIDO'
              Title.Caption = 'Conferido'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SALDO'
              Title.Caption = 'Saldo'
              Width = 90
              Visible = True
            end>
        end
      end
    end
    object tbs_Pesquisa: TTabSheet
      Caption = 'tbs_Pesquisa'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pnl_Busca: TGroupBox
        Left = 0
        Top = 60
        Width = 900
        Height = 456
        Align = alClient
        Caption = 'Resultados da Pesquisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          900
          456)
        object SB_Buscar: TSpeedButton
          Left = 810
          Top = 293
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
        end
        object SB_Visualizar: TSpeedButton
          Left = 810
          Top = 347
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
        end
        object Sb_Sair_1: TSpeedButton
          Left = 810
          Top = 401
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
        end
        object DBG_Pesquisa: TDBGrid
          Left = 2
          Top = 15
          Width = 803
          Height = 439
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
          OnDblClick = DBG_PesquisaDblClick
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
              Title.Caption = 'N'#250'mero'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 108
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMP_FANTASIA'
              Title.Caption = 'Nome/Raz'#227'o Social'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 422
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
              Visible = True
            end>
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 900
        Height = 60
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
          900
          60)
        object Label36: TLabel
          Left = 7
          Top = 16
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
        end
        object Label10: TLabel
          Left = 612
          Top = 16
          Width = 56
          Height = 11
          Anchors = [akLeft, akBottom]
          AutoSize = False
          Caption = 'Vendedor'
          FocusControl = E_BuscaPedido
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BuscaCliente: TEdit
          Left = 250
          Top = 32
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
          TabOrder = 3
        end
        object E_BuscaPedido: TEdit_Setes
          Left = 5
          Top = 32
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
        end
        object E_Data_Ini: TDateTimePicker
          Left = 87
          Top = 32
          Width = 79
          Height = 22
          Anchors = [akLeft, akBottom]
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 1
        end
        object E_Data_Fim: TDateTimePicker
          Left = 167
          Top = 32
          Width = 82
          Height = 22
          Anchors = [akLeft, akBottom]
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 2
        end
        object ChBx_Busca_Nome: TCheckBox
          Left = 251
          Top = 16
          Width = 121
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = ChBx_Busca_NomeClick
        end
        object ChBx_Busca_Fantasia: TCheckBox
          Left = 376
          Top = 16
          Width = 120
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Apelido/Fantasia'
          TabOrder = 5
          OnClick = ChBx_Busca_FantasiaClick
        end
        object ChBx_Periodo: TCheckBox
          Left = 89
          Top = 16
          Width = 128
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Data Inicial    Data Final'
          TabOrder = 6
          OnClick = ChBx_PeriodoClick
        end
        object Dblcb_Busca_Vendedor: TDBLookupComboBox
          Left = 614
          Top = 32
          Width = 291
          Height = 22
          Anchors = [akLeft, akBottom]
          KeyField = 'CLB_CODIGO'
          ListField = 'CLB_NOME'
          ListSource = DM_ListaConsultas.DS_ListaVendedor
          TabOrder = 7
        end
      end
    end
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 384
    Top = 208
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 384
    Top = 240
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ItensAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT distinct'
      '  DSP.DSP_CODIGO,'
      '  PRO_CODIGO,'
      '  PRO_CODIGOFAB,'
      '  PRO_CODIGOBAR,'
      '  PRO_DESCRICAO,'
      '  DSP_DT_PREVISTA,'
      '  DSP.DSP_CONFERIDO,'
      '  ITF.ITF_CODIGO,'
      '  ITF.ITF_CODPED,'
      '  ITF.ITF_CODPRO,'
      '  ITF.ITF_QTDE,'
      '  ITF.ITF_VL_UNIT,'
      
        '  ((ITF.ITF_QTDE * ITF.ITF_VL_UNIT) - ITF.ITF_VL_DESC) ITF_VL_TO' +
        'TAL,'
      ' ( ITF.ITF_QTDE - DSP.DSP_CONFERIDO) Saldo'
      ''
      'FROM TB_ITENS_NFL ITF'
      '  LEFT OUTER JOIN TB_DESPACHO DSP'
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
        DataType = ftString
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Value = '2'
      end>
  end
  object Ds_Itens: TDataSource
    DataSet = Qr_Itens
    Left = 150
    Top = 166
  end
  object Qr_Conferir: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE TB_DESPACHO SET'
      '    DSP_CONFERIDO = DSP_CONFERIDO + :DSP_CONFERIDO'
      'WHERE '
      '    DSP_CODIGO =:DSP_CODIGO')
    Left = 108
    Top = 311
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DSP_CONFERIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DSP_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
