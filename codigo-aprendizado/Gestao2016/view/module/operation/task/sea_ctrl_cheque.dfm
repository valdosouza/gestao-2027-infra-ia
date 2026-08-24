inherited SeaCtrlCheque: TSeaCtrlCheque
  Caption = 'Pesquisa Controle de cheque'
  ClientHeight = 553
  ClientWidth = 736
  ExplicitWidth = 742
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 143
    Width = 730
    Height = 407
    ExplicitTop = 143
    ExplicitWidth = 730
    ExplicitHeight = 407
    inherited DBG_Pesquisa: TDBGrid
      Width = 634
      Height = 389
      Columns = <
        item
          Expanded = False
          FieldName = 'CHQ_DATA'
          Title.Caption = 'Data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_AGENCIA'
          Title.Caption = 'Ag'#234'ncia'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_NR_BANCO'
          Title.Caption = 'N'#250'mero Banco'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_NUMERO'
          Title.Caption = 'N'#250'mero'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_EMITENTE'
          Title.Caption = 'Emitente'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_VALOR'
          Title.Caption = 'Valor'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_VL_AMORT'
          Title.Caption = 'Valor Amortizado'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_CODIGO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CHQ_VL_SALDO'
          Title.Caption = 'Saldo'
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 636
      Height = 389
      ExplicitLeft = 636
      ExplicitHeight = 389
      inherited Sb_Sair_0: TSpeedButton
        Top = 326
        ExplicitTop = 326
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 263
        ExplicitTop = 263
      end
      inherited SB_Buscar: TSpeedButton
        Top = 200
        ExplicitTop = 200
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 137
        ExplicitTop = 137
      end
      object RG_Destino: TRadioGroup
        Left = 0
        Top = 0
        Width = 92
        Height = 63
        Align = alTop
        Caption = 'Destino'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemIndex = 2
        Items.Strings = (
          'N'#195'O'
          'SIM'
          'TODOS')
        ParentFont = False
        TabOrder = 0
      end
      object RG_Devolvido: TRadioGroup
        Left = 0
        Top = 63
        Width = 92
        Height = 63
        Align = alTop
        Caption = 'Devolvido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemIndex = 2
        Items.Strings = (
          'N'#195'O'
          'SIM'
          'TODOS')
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 730
    Height = 134
    ExplicitWidth = 730
    ExplicitHeight = 134
    object Label27: TLabel
      Left = 168
      Top = 54
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
    object Label28: TLabel
      Left = 232
      Top = 53
      Width = 40
      Height = 14
      Caption = 'Emitente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 575
      Top = 53
      Width = 37
      Height = 14
      Caption = 'N'#250'mero'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 647
      Top = 53
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
    object Label13: TLabel
      Left = 7
      Top = 88
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
    object Lb_Total: TLabel
      Left = 681
      Top = 98
      Width = 38
      Height = 22
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_NR_Banco: TMaskEdit
      Left = 165
      Top = 66
      Width = 59
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object E_Emitente: TMaskEdit
      Left = 228
      Top = 66
      Width = 343
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
    object E_Numero: TMaskEdit
      Left = 573
      Top = 66
      Width = 70
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
    object E_Valor: TMaskEdit
      Left = 644
      Top = 66
      Width = 78
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
    object E_Data_Ini: TDateTimePicker
      Left = 4
      Top = 66
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Checked = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_Data_Fim: TDateTimePicker
      Left = 85
      Top = 66
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Checked = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 53
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      TabOrder = 6
      OnClick = ChBx_PeriodoClick
    end
    object E_Cliente: TMaskEdit
      Left = 4
      Top = 102
      Width = 517
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    inline Fm_ListaMultiEmpresa: TFm_ListaMultiEmpresa
      Left = 2
      Top = 2
      Width = 726
      Height = 46
      Align = alTop
      TabOrder = 8
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 726
      ExplicitHeight = 46
      inherited pnl_linha_1: TPanel
        Width = 726
        ExplicitWidth = 726
        inherited Sb_open: TSpeedButton
          Left = 702
          ExplicitLeft = 702
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 702
          ExplicitWidth = 702
        end
      end
      inherited pnl_top: TPanel
        Width = 726
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 208
    inherited arefas1: TMenuItem
      object OperaesemLote1: TMenuItem [0]
        Caption = 'Opera'#231#245'es em Lote'
        OnClick = OperaesemLote1Click
      end
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchCHQ_DATA: TDateField
      FieldName = 'CHQ_DATA'
      Origin = '"TB_CHEQUES"."CHQ_DATA"'
    end
    object cds_searchCHQ_AGENCIA: TStringField
      FieldName = 'CHQ_AGENCIA'
      Origin = '"TB_CHEQUES"."CHQ_AGENCIA"'
      Size = 7
    end
    object cds_searchCHQ_NR_BANCO: TIntegerField
      FieldName = 'CHQ_NR_BANCO'
      Origin = '"TB_CHEQUES"."CHQ_NR_BANCO"'
    end
    object cds_searchCHQ_NUMERO: TStringField
      FieldName = 'CHQ_NUMERO'
      Origin = '"TB_CHEQUES"."CHQ_NUMERO"'
    end
    object cds_searchCHQ_VALOR: TBCDField
      FieldName = 'CHQ_VALOR'
      Origin = '"TB_CHEQUES"."CHQ_VALOR"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object cds_searchCHQ_VL_AMORT: TBCDField
      FieldName = 'CHQ_VL_AMORT'
      Origin = '"TB_CHEQUES"."CHQ_VL_AMORT"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object cds_searchCHQ_CODIGO: TIntegerField
      FieldName = 'CHQ_CODIGO'
      Origin = '"TB_CHEQUES"."CHQ_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchCHQ_EMITENTE: TStringField
      FieldName = 'CHQ_EMITENTE'
      Origin = '"TB_CHEQUES"."CHQ_EMITENTE"'
      Size = 100
    end
    object cds_searchCHQ_VL_SALDO: TBCDField
      FieldName = 'CHQ_VL_SALDO'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
  end
end
