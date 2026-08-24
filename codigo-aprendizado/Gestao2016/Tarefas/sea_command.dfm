inherited SeaCommand: TSeaCommand
  Caption = 'Pesquisar Comanda'
  ClientHeight = 548
  ClientWidth = 769
  Menu = nil
  ExplicitWidth = 775
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 13
  inherited GrB_Parametros: TGroupBox
    Width = 769
    Height = 105
    ExplicitWidth = 769
    ExplicitHeight = 105
    object Label2: TLabel
      Left = 8
      Top = 18
      Width = 151
      Height = 19
      Caption = 'N'#250'mero da Comanda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 221
      Top = 18
      Width = 118
      Height = 19
      Caption = 'Nome do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 597
      Top = 18
      Width = 146
      Height = 19
      Caption = 'N'#250'mero do Telefone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object e_Numero_Comanda: TEdit
      Left = 6
      Top = 40
      Width = 211
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Nome_Cliente: TEdit
      Left = 219
      Top = 40
      Width = 374
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Numero_Telefone: TEdit
      Left = 595
      Top = 40
      Width = 163
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object chbx_Agrupada: TCheckBox
      Left = 8
      Top = 80
      Width = 257
      Height = 17
      Caption = 'Mostrar somente as Comandas Agrupadas'
      TabOrder = 3
    end
  end
  inherited Pnl_Resultado: TPanel
    Top = 105
    Width = 769
    Height = 443
    ExplicitTop = 105
    ExplicitWidth = 769
    ExplicitHeight = 443
    inherited Grd_Pesquisa: TStringGrid
      Width = 664
      Height = 425
      DefaultRowHeight = 25
      Font.Height = -16
      ExplicitWidth = 664
      ExplicitHeight = 425
      RowHeights = (
        25
        25)
    end
    inherited pnl_botao: TPanel
      Left = 666
      Height = 425
      ExplicitLeft = 666
      ExplicitHeight = 425
      inherited Sb_Sair: TSpeedButton
        Top = 370
        ExplicitTop = 370
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 315
        ExplicitTop = 315
      end
      inherited SB_Buscar: TSpeedButton
        Top = 260
        ExplicitTop = 260
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 205
        ExplicitLeft = 6
        ExplicitTop = 229
        ExplicitWidth = 95
      end
      object Sb_Agrupar: TSpeedButton
        Left = 0
        Top = 151
        Width = 101
        Height = 54
        Align = alBottom
        Caption = 'Agrupar - F2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_CadastrarClick
        ExplicitTop = 148
      end
    end
  end
  inherited Qr_Pesquisa: TSTQuery
    SQL.Strings = (
      
        'SELECT  c.DT_RECORD, TB_ORDER_ID, CONTROL_ID,CONTROL_NAME,CONTRO' +
        'L_PHONE'
      'FROM TB_COMMAND c'
      '  INNER JOIN TB_PEDIDO p'
      '  ON (PED_CODIGO = TB_ORDER_ID)'
      'order by c.DT_RECORD desc')
    object Qr_PesquisaDT_RECORD: TSQLTimeStampField
      Tag = -1
      DisplayLabel = 'Data'
      FieldName = 'DT_RECORD'
      Origin = '"TB_COMMAND"."DT_RECORD"'
    end
    object Qr_PesquisaTB_ORDER_ID: TIntegerField
      Tag = -1
      DisplayLabel = 'Pedido'
      FieldName = 'TB_ORDER_ID'
      Origin = '"TB_COMMAND"."TB_ORDER_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PesquisaCONTROL_ID: TStringField
      Tag = 200
      DisplayLabel = 'N'#250'mero Comanda'
      DisplayWidth = 50
      FieldName = 'CONTROL_ID'
      Origin = '"TB_COMMAND"."CONTROL_ID"'
      Size = 50
    end
    object Qr_PesquisaCONTROL_NAME: TStringField
      Tag = 180
      DisplayLabel = 'Nome Cliente'
      FieldName = 'CONTROL_NAME'
      Origin = '"TB_COMMAND"."CONTROL_NAME"'
      Size = 50
    end
    object Qr_PesquisaCONTROL_PHONE: TStringField
      Tag = 180
      DisplayLabel = 'N'#250'mero Telefone'
      FieldName = 'CONTROL_PHONE'
      Origin = '"TB_COMMAND"."CONTROL_PHONE"'
      Size = 150
    end
  end
end
