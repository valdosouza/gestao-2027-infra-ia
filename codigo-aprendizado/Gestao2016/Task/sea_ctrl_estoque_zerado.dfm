inherited SeaCtrlEstoqueZerado: TSeaCtrlEstoqueZerado
  Caption = 'Controle Estoque Zerado'
  ClientWidth = 969
  ExplicitWidth = 975
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 69
    Width = 963
    Height = 434
    ExplicitTop = 69
    ExplicitWidth = 963
    ExplicitHeight = 434
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 959
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 867
      Height = 416
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DT_RECORD'
          Title.Caption = 'Data do Registro'
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TB_ESTOQUE_ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TB_PRODUCT_ID'
          Title.Caption = 'C'#243'digo Produto'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 470
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_FOUND'
          Title.Caption = 'Saldo Evento'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EST_QTDE'
          Title.Caption = 'Saldo Atual'
          Width = 65
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 869
      Height = 416
      ExplicitLeft = 869
      ExplicitHeight = 416
      inherited Sb_Sair_0: TSpeedButton
        Top = 353
        ExplicitTop = 359
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 290
        ExplicitTop = 296
      end
      inherited SB_Buscar: TSpeedButton
        Top = 227
        ExplicitTop = 233
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 164
        Visible = False
        ExplicitTop = 170
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 963
    Height = 60
    ExplicitWidth = 963
    ExplicitHeight = 60
    object E_Data_Ini: TDateTimePicker
      Left = 4
      Top = 25
      Width = 90
      Height = 22
      Date = 39580.000000000000000000
      Time = 39580.000000000000000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 96
      Top = 25
      Width = 90
      Height = 22
      Date = 39580.999988425920000000
      Time = 39580.999988425920000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 7
      Top = 7
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 186
      Top = 10
      Width = 514
      Height = 43
      TabOrder = 3
      ExplicitLeft = 186
      ExplicitTop = 10
      ExplicitWidth = 514
      inherited Sb_Produto: TSpeedButton
        Left = 483
        ExplicitLeft = 487
      end
      inherited E_Busca_Produto: TEdit
        Width = 377
        ExplicitWidth = 377
      end
    end
    inline Fm_ListaEstoques: TFm_ListaEstoques
      Left = 694
      Top = 12
      Width = 260
      Height = 36
      TabOrder = 4
      ExplicitLeft = 694
      ExplicitTop = 12
      ExplicitWidth = 260
      inherited Label1: TLabel
        Width = 255
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 237
        Visible = False
        ExplicitLeft = 234
        ExplicitHeight = 13
      end
      inherited Dblcb_Estoque: TDBLookupComboBox
        Width = 256
        ExplicitWidth = 256
      end
      inherited ChBx_Estoques: TCheckBox
        Left = 154
        Visible = False
        OnClick = nil
        ExplicitLeft = 154
      end
    end
  end
  inherited DSP: TDataSetProvider
    Top = 152
  end
end
