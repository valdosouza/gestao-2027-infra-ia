inherited SeaConsignment: TSeaConsignment
  Caption = 'Consigna'#231#227'o de Mercadorias'
  ClientHeight = 534
  ClientWidth = 892
  ExplicitWidth = 898
  ExplicitHeight = 583
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Fundo: TPanel [0]
    Left = 0
    Top = 55
    Width = 892
    Height = 479
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object pnl_pesq_right: TPanel
      Left = 798
      Top = 2
      Width = 92
      Height = 475
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Sb_Sair_0: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 412
        Width = 86
        Height = 60
        Align = alBottom
        Caption = 'Fechar - ESC'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Sair_0Click
        ExplicitLeft = 6
        ExplicitTop = 411
        ExplicitWidth = 84
      end
      object SB_Visualizar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 349
        Width = 86
        Height = 60
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Visualizar - F8'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        Visible = False
        ExplicitLeft = 835
        ExplicitTop = 312
        ExplicitWidth = 92
      end
      object SB_Buscar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 289
        Width = 86
        Height = 60
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Buscar - F7'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_BuscarClick
        ExplicitLeft = 6
      end
      object SB_Cadastrar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 229
        Width = 86
        Height = 60
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Cadastrar - F2'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        Visible = False
        ExplicitLeft = 835
        ExplicitTop = 192
        ExplicitWidth = 92
      end
    end
    object Pg_Search: TPageControl
      Left = 2
      Top = 2
      Width = 796
      Height = 475
      ActivePage = tbs_Consolidado
      Align = alClient
      TabOrder = 1
      OnChange = Pg_SearchChange
      object tbs_clientes: TTabSheet
        Caption = 'Clientes'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 116
          Height = 14
          Align = alTop
          Caption = 'Resultado da pesquisa :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBGrid1: TDBGrid
          Left = 0
          Top = 14
          Width = 788
          Height = 433
          Align = alClient
          Color = clCream
          DataSource = Ds_Clientes
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
          Columns = <
            item
              Expanded = False
              FieldName = 'EMP_CODIGO'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMP_NOME'
              Title.Caption = 'Nome/Raz'#227'o Social'
              Width = 415
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMP_FANTASIA'
              Title.Caption = 'Apelido/Fantasia'
              Visible = True
            end>
        end
      end
      object tbs_Consolidado: TTabSheet
        Caption = 'Consolidado'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Lb_ResultadoConsolidado: TLabel
          Left = 0
          Top = 0
          Width = 116
          Height = 14
          Align = alTop
          Caption = 'Resultado da pesquisa :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBG_Consolidado: TDBGrid
          Left = 0
          Top = 14
          Width = 788
          Height = 433
          Align = alClient
          Color = clCream
          DataSource = Ds_Consolidado
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
          Columns = <
            item
              Expanded = False
              FieldName = 'PRO_CODIGO'
              Title.Alignment = taCenter
              Title.Caption = 'C'#243'digo'
              Width = 71
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 462
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TOT_QTDE'
              Title.Caption = 'Quantidade'
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TOT_VALUE'
              Title.Caption = 'Valor Total'
              Width = 92
              Visible = True
            end>
        end
      end
      object tbs_Detalhamento: TTabSheet
        Caption = 'Detalhado'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Lb_DescricaoProduto: TLabel
          Left = 0
          Top = 0
          Width = 166
          Height = 19
          Align = alTop
          Alignment = taCenter
          Caption = 'Descri'#231#227'o da Produto'
          Color = clNavy
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object DBG_Detalhado: TDBGrid
          Left = 0
          Top = 19
          Width = 788
          Height = 428
          Align = alClient
          Color = clCream
          DataSource = Ds_Detalhado
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
          Columns = <
            item
              Expanded = False
              FieldName = 'DT_RECORD'
              Title.Caption = 'Data'
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'KIND'
              Title.Caption = 'Tipo Opera'#231#227'o'
              Width = 94
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_QTDE'
              Title.Caption = 'Quantidade'
              Width = 74
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITF_VL_UNIT'
              Title.Caption = 'Valor Unit'#225'rio'
              Width = 94
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SUBTOTAL'
              Title.Caption = 'Valor Subtotal'
              Visible = True
            end>
        end
      end
    end
  end
  object Pnl_Parametros: TPanel [1]
    Left = 0
    Top = 0
    Width = 892
    Height = 55
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object L_CodigoCliente: TLabel
      Left = 170
      Top = 6
      Width = 69
      Height = 13
      Caption = 'C'#243'digo Cliente'
    end
    object Sb_Pesq_Empresa: TSpeedButton
      Left = 600
      Top = 20
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
    object E_Data_Ini: TDateTimePicker
      Left = 6
      Top = 20
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 85
      Top = 20
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 5
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = ChBx_PeriodoClick
    end
    object E_Busca_Empresa: TEdit
      Left = 234
      Top = 20
      Width = 360
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object ChBx_Nome: TCheckBox
      Left = 242
      Top = 2
      Width = 121
      Height = 17
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 4
    end
    object ChBx_Fantasia: TCheckBox
      Left = 360
      Top = 2
      Width = 102
      Height = 17
      Caption = 'Apelido/Fantasia'
      TabOrder = 5
    end
    object E_Busca_Cd_Empresa: TEdit
      Left = 170
      Top = 20
      Width = 61
      Height = 21
      TabOrder = 6
      OnExit = E_Busca_Cd_EmpresaExit
    end
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 160
  end
  object Qr_Consolidado: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    OnCalcFields = Qr_ConsolidadoCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select DISTINCT'
      'pr.pro_codigo, '
      'pr.pro_descricao'
      'from tb_itens_nfl it '
      '  inner join tb_order_consignment_operation oco '
      '  on (oco.tb_order_item_id = it.itf_sequencia) '
      '      and  (oco.tb_itens_nfl_id = it.itf_codigo)'
      '  inner join tb_order_consignment orc'
      '  on (oco.tb_order_id = orc.id)'
      '    and  (oco.tb_institution_id = orc.tb_institution_id)'
      '  INNER JOIN tb_empresa ep '
      '  on (orc.tb_customer_id = ep.emp_codigo)'
      ' inner join tb_produto pr '
      ' on (it.itf_codpro = pr.pro_codigo) ')
    Left = 200
    Top = 159
    object Qr_ConsolidadoPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = '"TB_PRODUTO"."PRO_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ConsolidadoPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ConsolidadoTOT_QTDE: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TOT_QTDE'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object Qr_ConsolidadoTOT_VALUE: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TOT_VALUE'
      DisplayFormat = '0.00'
      Calculated = True
    end
  end
  object Ds_Consolidado: TDataSource
    DataSet = Qr_Consolidado
    Left = 200
    Top = 223
  end
  object Qr_Detalhado: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    AutoCalcFields = False
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      'it.itf_codigo,'
      'it.itf_codped,'
      'it.itf_codpro,'
      'pr.pro_descricao,'
      'it.itf_qtde,'
      'it.itf_vl_unit,'
      'it.itf_aq_desc,'
      'it.itf_vl_desc,'
      'CAST(( ( it.itf_qtde * it.itf_vl_unit ) - it.itf_vl_desc ) AS NUMERIC(18, 9)) subtotal,'
      'oco.dt_record, '
      'oco.kind '
      'from tb_itens_nfl it'
      '  inner join tb_pedido pd'
      '  on (pd.ped_codigo = it.itf_codped)'
      '  inner join tb_produto pr'
      '  on (it.itf_codpro = pr.pro_codigo)'
      ''
      '  inner join tb_order_consignment_operation oco'
      '  on (oco.tb_order_item_id = it.itf_sequencia)'
      '      and  (oco.tb_order_id = pd.ped_codweb)'
      '      and  (pd.ped_codmha = oco.tb_institution_id)')
    Left = 328
    Top = 159
    object Qr_DetalhadoITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_DetalhadoITF_CODPED: TIntegerField
      FieldName = 'ITF_CODPED'
      Origin = '"TB_ITENS_NFL"."ITF_CODPED"'
    end
    object Qr_DetalhadoITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_DetalhadoPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_DetalhadoITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 3
    end
    object Qr_DetalhadoITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object Qr_DetalhadoITF_AQ_DESC: TBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_DetalhadoITF_VL_DESC: TBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_DetalhadoSUBTOTAL: TFMTBCDField
      FieldName = 'SUBTOTAL'
      ProviderFlags = []
      DisplayFormat = '0.00'
      Precision = 18
      Size = 9
    end
    object Qr_DetalhadoDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = '"TB_ORDER_CONSIGNMENT_OPERATION"."DT_RECORD"'
    end
    object Qr_DetalhadoKIND: TStringField
      FieldName = 'KIND'
      Origin = '"TB_ORDER_CONSIGNMENT_OPERATION"."KIND"'
      Size = 2
    end
  end
  object Ds_Detalhado: TDataSource
    DataSet = Qr_Detalhado
    Left = 328
    Top = 231
  end
  object Qr_Clientes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT distinct ep.emp_codigo, ep.emp_nome, ep.emp_fantasia'
      'FROM tb_pedido pd'
      '  inner join tb_order_consignment orc '
      
        '  on (pd.ped_codigo = orc.id) and  (pd.ped_codmha = orc.tb_insti' +
        'tution_id)'
      '  INNER JOIN tb_empresa ep'
      '  on (orc.tb_customer_id = ep.emp_codigo)'
      'where (pd.ped_codigo > 0)')
    Left = 88
    Top = 151
  end
  object Ds_Clientes: TDataSource
    DataSet = Qr_Clientes
    Left = 88
    Top = 215
  end
end
