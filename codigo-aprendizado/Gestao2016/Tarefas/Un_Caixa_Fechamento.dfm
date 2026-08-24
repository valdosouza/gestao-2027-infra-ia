object Fr_Caixa_Fechamento: TFr_Caixa_Fechamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Fechamento de Caixa'
  ClientHeight = 569
  ClientWidth = 912
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 502
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      912
      502)
    object Label1: TLabel
      Left = 5
      Top = 3
      Width = 68
      Height = 13
      Caption = 'Data do Caixa'
    end
    object Label2: TLabel
      Left = 96
      Top = 3
      Width = 81
      Height = 13
      Caption = 'Nome do Usu'#225'rio'
    end
    object Label3: TLabel
      Left = 455
      Top = 43
      Width = 450
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Resumo das Vendas'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label4: TLabel
      Left = 1
      Top = 44
      Width = 450
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Resumo de Cr'#233'ditos no Caixa'
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label5: TLabel
      Left = 1
      Top = 243
      Width = 450
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Resumo de D'#233'bitos no Caixa'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label6: TLabel
      Left = 457
      Top = 242
      Width = 450
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Informe os valores do Caixa'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label8: TLabel
      Left = 218
      Top = 219
      Width = 107
      Height = 13
      Caption = 'Valor total de Cr'#233'ditos'
    end
    object Label9: TLabel
      Left = 674
      Top = 218
      Width = 102
      Height = 13
      Caption = 'Valor total de Vendas'
    end
    object Label10: TLabel
      Left = 219
      Top = 420
      Width = 103
      Height = 13
      Caption = 'Valor total de D'#233'bitos'
    end
    object Label11: TLabel
      Left = 671
      Top = 423
      Width = 104
      Height = 13
      Caption = 'Valor total Registrado'
    end
    object Label12: TLabel
      Left = 671
      Top = 450
      Width = 102
      Height = 13
      Caption = 'Valor total Informado'
    end
    object Label13: TLabel
      Left = 461
      Top = 3
      Width = 161
      Height = 13
      Caption = 'Data Inicial e Data Final da Venda'
    end
    object E_Dt_Caixa: TMaskEdit
      Left = 4
      Top = 19
      Width = 88
      Height = 21
      Alignment = taCenter
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 0
      Text = '  /  /    '
    end
    object E_Nome_Usuario: TMaskEdit
      Left = 95
      Top = 19
      Width = 354
      Height = 21
      ReadOnly = True
      TabOrder = 1
      Text = ''
    end
    object Dbg_Vendas: TDBGrid
      Left = 455
      Top = 62
      Width = 450
      Height = 153
      DataSource = Ds_Venda
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'FPT_DESCRICAO'
          Width = 284
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Total'
          Width = 103
          Visible = True
        end>
    end
    object Dbg_Creditos: TDBGrid
      Left = 4
      Top = 62
      Width = 450
      Height = 153
      DataSource = Ds_Credito
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'FPT_DESCRICAO'
          Width = 279
          Visible = True
        end
        item
          ButtonStyle = cbsNone
          Expanded = False
          FieldName = 'TOTAL'
          Visible = True
        end>
    end
    object Dbg_Debitos: TDBGrid
      Left = 4
      Top = 261
      Width = 450
      Height = 153
      DataSource = Ds_Debito
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'FPT_DESCRICAO'
          Width = 262
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTAL'
          Width = 130
          Visible = True
        end>
    end
    object Grp_Transferencia: TGroupBox
      Left = 5
      Top = 439
      Width = 268
      Height = 59
      Anchors = [akLeft, akBottom]
      Caption = 'Transfer'#234'ncia de Valores'
      TabOrder = 5
      object Label7: TLabel
        Left = 8
        Top = 16
        Width = 82
        Height = 14
        Caption = 'Nome do Usu'#225'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object DBLCB_Usuario: TDBLookupComboBox
        Left = 6
        Top = 32
        Width = 259
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        KeyField = 'USU_CODIGO'
        ListField = 'USU_LOGIN'
        ListSource = Fr_Caixa.Ds_Usuario
        ParentFont = False
        TabOrder = 0
      end
    end
    object E_TL_VL_Credito: TEdit
      Left = 331
      Top = 216
      Width = 121
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 6
      Text = '0,00'
    end
    object E_TL_VL_Vendas: TEdit
      Left = 787
      Top = 215
      Width = 121
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 7
      Text = '0,00'
    end
    object E_TL_VL_Debito: TEdit
      Left = 332
      Top = 417
      Width = 121
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 8
      Text = '0,00'
    end
    object E_TL_VL_Registrado: TEdit
      Left = 784
      Top = 420
      Width = 121
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 9
      Text = '0,00'
    end
    object E_TL_VL_Digitado: TEdit
      Left = 784
      Top = 447
      Width = 121
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 10
      Text = '0,00'
    end
    object StrGrd_Valores: TStringGrid
      Left = 457
      Top = 261
      Width = 451
      Height = 151
      Color = clMoneyGreen
      ColCount = 2
      DefaultRowHeight = 20
      RowCount = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 11
      OnDrawCell = StrGrd_ValoresDrawCell
      OnSelectCell = StrGrd_ValoresSelectCell
      OnSetEditText = StrGrd_ValoresSetEditText
      ColWidths = (
        64
        64)
      RowHeights = (
        20
        20)
    end
    object E_Data_Ini: TDateTimePicker
      Left = 460
      Top = 19
      Width = 90
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 12
    end
    object E_Data_Fim: TDateTimePicker
      Left = 554
      Top = 19
      Width = 90
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 13
    end
    object bt_AtualizaResumoVendas: TButton
      Left = 649
      Top = 18
      Width = 75
      Height = 22
      Caption = 'Atualizar'
      TabOrder = 14
      OnClick = bt_AtualizaResumoVendasClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 502
    Width = 912
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      912
      67)
    object SB_Confirmar: TSpeedButton
      Left = 721
      Top = 6
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
    end
    object SB_Sair_0: TSpeedButton
      Left = 817
      Top = 6
      Width = 89
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 624
      ExplicitTop = 17
    end
  end
  object Qr_Vendas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    OnCalcFields = Qr_VendasCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select ped_codvdo, fp.fpt_descricao, Sum(fnc.fin_vl_pago) TotalP' +
        'ago, CAST(Sum(fnc.fin_vl_parcela) AS NUMERIC(18, 2)) TotalPagar'
      'from tb_nota_fiscal nf '
      '  inner join tb_pedido '
      '  on (ped_codigo = nfl_codped) '
      '  inner join tb_financeiro fnc '
      '  on (fnc.fin_codnfl = nfl_codigo) '
      '  inner join tb_formapagto fp '
      '  on (fp.fpt_codigo = fnc.fin_codfpg) '
      
        'where ( nf.nfl_dt_emissao ='#39'10/26/2017'#39' ) and fnc.fin_tipo = '#39'RA' +
        #39
      '--and ( ped_codvdo =:ped_codvdo )'
      'group by 1,2'
      'order by 2 ')
    Left = 720
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ped_codvdo'
        ParamType = ptUnknown
      end>
    object Qr_VendasPED_CODVDO: TIntegerField
      FieldName = 'PED_CODVDO'
      Origin = '"TB_PEDIDO"."PED_CODVDO"'
      Required = True
    end
    object Qr_VendasFPT_DESCRICAO: TStringField
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'FPT_DESCRICAO'
      Origin = '"TB_FORMAPAGTO"."FPT_DESCRICAO"'
      Required = True
      Size = 51
    end
    object Qr_VendasTotal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Total'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object Qr_VendasTOTALPAGO: TBCDField
      FieldName = 'TOTALPAGO'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object Qr_VendasTOTALPAGAR: TBCDField
      FieldName = 'TOTALPAGAR'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
  end
  object Ds_Venda: TDataSource
    DataSet = Qr_Vendas
    Left = 720
    Top = 152
  end
  object Qr_Creditos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select cx.mvf_codusu, fp.fpt_descricao, sum(cx.mvf_vl_credito) t' +
        'otal'
      'from tb_movim_financeiro cx'
      '  inner join tb_formapagto fp'
      '  on (fp.fpt_codigo = cx.mvf_codfpt)'
      'where cx.mvf_codctb = 0'
      'and ( cx.mvf_data =:mvf_data )'
      'and ( cx.mvf_codusu =:mvf_codusu )'
      'and ( cx.mvf_vl_credito > 0 )'
      'and ( cx.mvf_codmha =:mvf_codmha )'
      'group by 1,2'
      'order by 2')
    Left = 384
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'mvf_data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mvf_codusu'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mvf_codmha'
        ParamType = ptUnknown
      end>
    object Qr_CreditosMVF_CODUSU: TIntegerField
      FieldName = 'MVF_CODUSU'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODUSU"'
    end
    object Qr_CreditosFPT_DESCRICAO: TStringField
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'FPT_DESCRICAO'
      Origin = '"TB_FORMAPAGTO"."FPT_DESCRICAO"'
      Required = True
      Size = 51
    end
    object Qr_CreditosTOTAL: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'TOTAL'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object Ds_Credito: TDataSource
    DataSet = Qr_Creditos
    Left = 384
    Top = 144
  end
  object Qr_Debitos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select cx.mvf_codusu, fp.fpt_descricao, sum(cx.mvf_vl_debito) to' +
        'tal'
      'from tb_movim_financeiro cx'
      '  inner join tb_formapagto fp'
      '  on (fp.fpt_codigo = cx.mvf_codfpt)'
      'where cx.mvf_codctb = 0'
      'and ( cx.mvf_data =:mvf_data )'
      'and ( cx.mvf_codusu =:mvf_codusu )'
      'and ( cx.mvf_vl_debito > 0 )'
      'and ( cx.mvf_codmha =:mvf_codmha )'
      'group by 1,2'
      'order by 2')
    Left = 392
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'mvf_data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mvf_codusu'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mvf_codmha'
        ParamType = ptUnknown
      end>
    object IntegerField1: TIntegerField
      FieldName = 'MVF_CODUSU'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODUSU"'
    end
    object IBStringField1: TStringField
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'FPT_DESCRICAO'
      Origin = '"TB_FORMAPAGTO"."FPT_DESCRICAO"'
      Required = True
      Size = 51
    end
    object IBBCDField1: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'TOTAL'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object Ds_Debito: TDataSource
    DataSet = Qr_Debitos
    Left = 392
    Top = 328
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select cx.mvf_codusu, fp.fpt_descricao, sum(cx.mvf_vl_credito) t' +
        'otal'
      'from tb_movim_financeiro cx'
      '  inner join tb_formapagto fp'
      '  on (fp.fpt_codigo = cx.mvf_codfpt)'
      'where cx.mvf_codctb = 0'
      'and ( cx.mvf_data =:mvf_data )'
      'and ( cx.mvf_codusu =:mvf_codusu )'
      'and ( cx.mvf_vl_credito > 0 )'
      'and ( cx.mvf_codmha =:mvf_codmha )'
      'group by 1,2'
      'order by 2')
    Left = 552
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'mvf_data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mvf_codusu'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mvf_codmha'
        ParamType = ptUnknown
      end>
  end
  object Qr_ValoresCaixa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT MVF_CODFPT, fpt_descricao, SUM (MVF_VL_CREDITO - MVF_VL_D' +
        'EBITO) as MVF_VALOR'
      'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro'
      '  LEFT JOIN tb_formapagto'
      '  ON (tb_formapagto.fpt_codigo = tb_movim_financeiro.mvf_codfpt)'
      'WHERE (MVF_CODCTB = 0)'
      ' AND (MVF_CODMHA =:MVF_CODMHA)'
      ' AND (MVF_CODUSU =:MVF_CODUSU)'
      'GROUP BY MVF_CODFPT,fpt_descricao'
      'having SUM (MVF_VL_CREDITO - MVF_VL_DEBITO) <>0')
    Left = 508
    Top = 275
    ParamData = <
      item
        DataType = ftString
        Name = 'MVF_CODMHA'
        ParamType = ptUnknown
        Value = '1'
      end
      item
        DataType = ftUnknown
        Name = 'MVF_CODUSU'
        ParamType = ptUnknown
      end>
    object Qr_ValoresCaixaMVF_CODFPT: TIntegerField
      Tag = -1
      FieldName = 'MVF_CODFPT'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODFPT"'
    end
    object Qr_ValoresCaixaFPT_DESCRICAO: TStringField
      Tag = 174
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'FPT_DESCRICAO'
      Origin = '"TB_FORMAPAGTO"."FPT_DESCRICAO"'
      Size = 51
    end
    object Qr_ValoresCaixaMVF_VALOR: TBCDField
      Tag = 103
      DisplayLabel = 'Valor Registrado'
      FieldName = 'MVF_VALOR'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object Qr_ValoresCaixaMVL_DIGITADO: TStringField
      Tag = 103
      DisplayLabel = 'Valor Informado'
      FieldKind = fkCalculated
      FieldName = 'MVL_DIGITADO'
      Calculated = True
    end
  end
  object Ds_ValoresCaixa: TDataSource
    DataSet = Qr_ValoresCaixa
    Left = 512
    Top = 320
  end
end
