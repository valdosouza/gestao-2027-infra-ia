inherited FR_Fecha_Financeiro: TFR_Fecha_Financeiro
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Fechamento Financeiro'
  ClientHeight = 328
  ClientWidth = 496
  ExplicitWidth = 502
  ExplicitHeight = 376
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 496
    Height = 328
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      496
      328)
    object Label6: TLabel
      Left = 6
      Top = 47
      Width = 484
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Valores do Fechamento - Resultado'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 353
      Top = 20
      Width = 136
      Height = 22
      Caption = 'Atualizar Lista'
      OnClick = SpeedButton1Click
    end
    object Label3: TLabel
      Left = 8
      Top = 5
      Width = 123
      Height = 13
      Caption = 'Per'#237'odo para Fechamento'
    end
    object SB_Confirmar: TSpeedButton
      Left = 310
      Top = 269
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
      ExplicitTop = 509
    end
    object SB_Sair: TSpeedButton
      Left = 400
      Top = 269
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
      OnClick = SB_SairClick
      ExplicitTop = 509
    end
    object E_Data_Ini: TDateTimePicker
      Left = 6
      Top = 20
      Width = 85
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 92
      Top = 20
      Width = 85
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object StrGrd_Valores: TStringGrid
      Left = 5
      Top = 66
      Width = 486
      Height = 199
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
      TabOrder = 2
      OnDrawCell = StrGrd_ValoresDrawCell
      OnSelectCell = StrGrd_ValoresSelectCell
      ColWidths = (
        64
        64)
      RowHeights = (
        20
        20)
    end
  end
  object Qr_Valores: TSTQuery
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
    Left = 284
    Top = 123
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
  end
  object Ds_Valores: TDataSource
    DataSet = Qr_Valores
    Left = 288
    Top = 168
  end
end
