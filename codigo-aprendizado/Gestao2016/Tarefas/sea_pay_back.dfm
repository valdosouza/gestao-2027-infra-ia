inherited SeaPayBack: TSeaPayBack
  Caption = 'Pesquisa de Movimento PAYBACK'
  ClientHeight = 563
  ClientWidth = 1062
  ExplicitWidth = 1068
  ExplicitHeight = 612
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 109
    Width = 1056
    Height = 451
    ExplicitTop = 109
    ExplicitWidth = 1056
    ExplicitHeight = 451
    inherited DBG_Pesquisa: TDBGrid
      Width = 962
      Height = 433
      PopupMenu = PopupMenu
      Columns = <
        item
          Expanded = False
          FieldName = 'DT_RECORD'
          Title.Caption = 'Data'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'END_FONE'
          Title.Caption = 'Fone'
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_FANTASIA'
          Title.Caption = 'Apelido/Fantasia'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'EMP_NOME'
          Title.Caption = 'Nome/Raz'#227'o Social'
          Width = 335
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CREDIT_VALUE'
          Title.Caption = 'Valor Cr'#233'dito'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DEBIT_VALUE'
          Title.Caption = 'Valor D'#233'bito'
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_EXPIRE'
          Title.Caption = 'Expira em '
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS'
          Title.Caption = 'Situa'#231#227'o'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HISTORY'
          Title.Caption = 'Hist'#243'tico'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_CNPJ'
          Title.Caption = 'CPF/CNPJ'
          Width = 107
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 964
      Width = 90
      Height = 433
      ExplicitLeft = 964
      ExplicitWidth = 90
      ExplicitHeight = 433
      inherited Sb_Sair_0: TSpeedButton
        Top = 370
        Width = 84
        ExplicitTop = 328
        ExplicitWidth = 84
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 307
        Width = 84
        Visible = False
        ExplicitLeft = 6
        ExplicitTop = 274
        ExplicitWidth = 84
      end
      inherited SB_Buscar: TSpeedButton
        Top = 244
        Width = 84
        ExplicitTop = 208
        ExplicitWidth = 84
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 181
        Width = 84
        Visible = False
        ExplicitLeft = 0
        ExplicitTop = 142
        ExplicitWidth = 84
      end
      object Lb_TotalCredito: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 1
        Width = 82
        Height = 14
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Cr'#233'dito Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitWidth = 86
      end
      object E_CreditoTotal: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 17
        Width = 82
        Height = 17
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
      end
      object Lb_TotalDebito: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 36
        Width = 82
        Height = 14
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Cr'#233'dito Expirado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitWidth = 86
      end
      object E_CreditoExpirado: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 52
        Width = 82
        Height = 17
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitWidth = 86
      end
      object Lb_Saldo: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 106
        Width = 82
        Height = 14
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Saldo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitTop = 71
        ExplicitWidth = 86
      end
      object E_Saldo: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 122
        Width = 82
        Height = 17
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitTop = 87
        ExplicitWidth = 86
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 71
        Width = 82
        Height = 14
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Cr'#233'dito Utilizado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitWidth = 84
      end
      object E_CreditoUtilizado: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 87
        Width = 82
        Height = 17
        Margins.Top = 1
        Margins.Right = 5
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitWidth = 86
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 1056
    Height = 100
    ExplicitWidth = 1056
    ExplicitHeight = 100
    object Label42: TLabel
      Left = 178
      Top = 1
      Width = 24
      Height = 14
      Caption = 'Fone'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_CodigoCliente: TLabel
      Left = 274
      Top = 7
      Width = 69
      Height = 13
      Caption = 'C'#243'digo Cliente'
    end
    object Sb_Pesq_Empresa: TSpeedButton
      Left = 582
      Top = 21
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
    object Label3: TLabel
      Left = 611
      Top = 4
      Width = 46
      Height = 14
      Caption = 'Endere'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 3
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 7
    end
    object E_Data_Fim: TDateTimePicker
      Left = 92
      Top = 21
      Width = 84
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_Data_Ini: TDateTimePicker
      Left = 5
      Top = 21
      Width = 84
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object Rg_Tipo_Valor: TRadioGroup
      Left = 6
      Top = 49
      Width = 194
      Height = 45
      Caption = 'Tipo Valor'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Cr'#233'dito'
        'D'#233'bito'
        'Todos')
      TabOrder = 6
    end
    object E_BuscaFone: TEdit_Setes
      Left = 178
      Top = 21
      Width = 93
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnExit = E_BuscaFoneExit
      IsFone = True
    end
    object E_Busca_Cliente: TEdit
      Left = 337
      Top = 21
      Width = 241
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
    object ChBx_Nome: TCheckBox
      Left = 348
      Top = 3
      Width = 121
      Height = 17
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 464
      Top = 3
      Width = 102
      Height = 17
      Caption = 'Apelido/Fantasia'
      TabOrder = 9
      OnClick = ChBx_FantasiaClick
    end
    object E_Busca_Cd_Cliente: TEdit
      Left = 274
      Top = 21
      Width = 61
      Height = 21
      TabOrder = 3
      OnExit = E_Busca_Cd_ClienteExit
    end
    object E_BuscaEndereco: TEdit
      Left = 611
      Top = 21
      Width = 438
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 112
    inherited arefas1: TMenuItem
      object MnuConfigurao: TMenuItem [0]
        Caption = 'Configura'#231#227'o'
        OnClick = MnuConfiguraoClick
      end
      object RegistrarCrditosExpirados1: TMenuItem [1]
        Caption = 'Registrar Cr'#233'ditos Expirados'
        OnClick = RegistrarCrditosExpirados1Click
      end
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = '"TB_PAY_BACK"."DT_RECORD"'
    end
    object cds_searchCREDIT_VALUE: TBCDField
      FieldName = 'CREDIT_VALUE'
      Origin = '"TB_PAY_BACK"."CREDIT_VALUE"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_searchDEBIT_VALUE: TBCDField
      FieldName = 'DEBIT_VALUE'
      Origin = '"TB_PAY_BACK"."DEBIT_VALUE"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_searchHISTORY: TWideStringField
      FieldName = 'HISTORY'
      Origin = '"TB_PAY_BACK"."HISTORY"'
      Size = 100
    end
    object cds_searchEMP_FANTASIA: TWideStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object cds_searchEMP_NOME: TWideStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object cds_searchEMP_CNPJ: TWideStringField
      FieldName = 'EMP_CNPJ'
      Origin = '"TB_EMPRESA"."EMP_CNPJ"'
      Size = 14
    end
    object cds_searchEND_FONE: TWideStringField
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
    object cds_searchTB_ORDER_ID: TIntegerField
      FieldName = 'TB_ORDER_ID'
      Origin = '"TB_PAY_BACK"."TB_ORDER_ID"'
    end
    object cds_searchSTATUS: TWideStringField
      FieldName = 'STATUS'
      Size = 10
    end
    object cds_searchDT_EXPIRE: TDateField
      FieldName = 'DT_EXPIRE'
    end
  end
  object PopupMenu: TPopupMenu
    Left = 664
    Top = 225
    object VisualizarPedido1: TMenuItem
      Caption = 'Visualizar Pedido'
      OnClick = VisualizarPedido1Click
    end
    object CadastrodeCliente1: TMenuItem
      Caption = 'Cadastro de Cliente'
      OnClick = CadastrodeCliente1Click
    end
  end
end
