inherited SeaAssistance: TSeaAssistance
  Caption = 'Pesquisa Assist'#234'ncia'
  ClientWidth = 956
  ExplicitWidth = 962
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 950
    Height = 424
    ExplicitTop = 79
    ExplicitWidth = 950
    ExplicitHeight = 424
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 946
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 854
      Height = 406
      Columns = <
        item
          Expanded = False
          FieldName = 'ASS_CODIGO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ASS_NUMERO'
          Title.Caption = 'N'#250'mero'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_FANTASIA'
          Title.Caption = 'Apellido / Fantasia'
          Width = 364
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIT_DESCRICAO'
          Title.Caption = 'Situa'#231#227'o'
          Width = 265
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_NOME'
          Title.Caption = 'Nome / Raz'#227'o'
          Width = 378
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 856
      Height = 406
      ExplicitLeft = 856
      ExplicitHeight = 406
      inherited Sb_Sair_0: TSpeedButton
        Top = 343
        ExplicitTop = 343
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 280
        ExplicitTop = 280
      end
      inherited SB_Buscar: TSpeedButton
        Top = 217
        ExplicitTop = 217
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 154
        ExplicitTop = 154
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 950
    Height = 70
    ExplicitWidth = 950
    ExplicitHeight = 70
    object GroupBox3: TGroupBox
      Left = 2
      Top = 2
      Width = 946
      Height = 63
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        946
        63)
      object Label11: TLabel
        Left = 167
        Top = 17
        Width = 77
        Height = 14
        AutoSize = False
        Caption = 'N'#250'mero Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object ChBx_Busca_Nome: TCheckBox
        Left = 250
        Top = 9
        Width = 121
        Height = 17
        Caption = 'Nome/Raz'#227'o Social'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object E_Cliente: TMaskEdit
        Left = 246
        Top = 32
        Width = 341
        Height = 22
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
        Text = ''
      end
      object ChBx_Busca_Fantasia: TCheckBox
        Left = 380
        Top = 14
        Width = 120
        Height = 17
        Caption = 'Apelido/Fantasia'
        TabOrder = 6
      end
      object E_Numero: TMaskEdit
        Left = 166
        Top = 31
        Width = 79
        Height = 22
        CharCase = ecUpperCase
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Text = ''
      end
      inline Fm_ListaSituacao: TFm_ListaSituacao
        Left = 591
        Top = 18
        Width = 357
        Height = 39
        TabOrder = 4
        ExplicitLeft = 591
        ExplicitTop = 18
        inherited DBLCB_Situacao: TDBLookupComboBox
          Height = 22
          ExplicitHeight = 22
        end
      end
      object E_Data_Ini: TDateTimePicker
        Left = 2
        Top = 31
        Width = 79
        Height = 22
        Anchors = [akLeft, akBottom]
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 0
      end
      object E_Data_Fim: TDateTimePicker
        Left = 83
        Top = 31
        Width = 82
        Height = 22
        Anchors = [akLeft, akBottom]
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object ChBx_Periodo: TCheckBox
        Left = 5
        Top = 15
        Width = 128
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Data Inicial    Data Final'
        TabOrder = 7
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 88
    Top = 80
    inherited arefas1: TMenuItem
      object Configurao1: TMenuItem [0]
        Caption = 'Configura'#231#227'o'
        OnClick = Configurao1Click
      end
    end
  end
  inherited cds_search: TClientDataSet
    ProviderName = ''
    object cds_searchASS_CODIGO: TIntegerField
      FieldName = 'ASS_CODIGO'
    end
    object cds_searchASS_NUMERO: TIntegerField
      FieldName = 'ASS_NUMERO'
    end
    object cds_searchEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Size = 100
    end
    object cds_searchEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Size = 100
    end
    object cds_searchSIT_DESCRICAO: TStringField
      FieldName = 'SIT_DESCRICAO'
      Size = 100
    end
  end
end
