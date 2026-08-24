inherited RegCustoPedido: TRegCustoPedido
  Caption = 'Rela'#231#227'o de Custos e Despesas Logisticas'
  ClientWidth = 718
  ExplicitWidth = 724
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Width = 718
    ExplicitWidth = 718
    inherited SB_Inserir: TSpeedButton
      Left = 91
      ExplicitLeft = 91
    end
    inherited SB_Alterar: TSpeedButton
      Left = 195
      ExplicitLeft = 195
    end
    inherited SB_Excluir: TSpeedButton
      Left = 299
      ExplicitLeft = 299
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 507
      ExplicitLeft = 507
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 611
      ExplicitLeft = 611
    end
    inherited SB_Gravar: TSpeedButton
      Left = 403
      ExplicitLeft = 403
    end
  end
  inherited pnl_fundo: TPanel
    Width = 718
    Height = 49
    Align = alTop
    ExplicitWidth = 718
    ExplicitHeight = 49
    object Lb_Vl_Unit_Orig: TLabel
      Left = 484
      Top = 7
      Width = 64
      Height = 13
      Caption = 'Valor Unit. ($)'
      FocusControl = E_Vl_Unit_Orig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 7
      Width = 102
      Height = 13
      Caption = 'Descri'#231#227'o dos custos'
      FocusControl = E_Descricao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 630
      Top = 7
      Width = 75
      Height = 13
      Caption = 'Valor Unit.  (R$)'
      FocusControl = E_Vl_Unit_Real
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 575
      Top = 7
      Width = 40
      Height = 13
      Caption = 'Cota'#231#227'o'
      FocusControl = E_Vl_Cotacao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 386
      Top = 7
      Width = 77
      Height = 13
      Caption = 'Base de Calculo'
      FocusControl = E_Vl_Unit_Orig
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Vl_Unit_Orig: TEdit
      Left = 484
      Top = 23
      Width = 89
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnExit = E_Vl_Unit_OrigExit
    end
    object E_Descricao: TEdit
      Left = 6
      Top = 23
      Width = 374
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Vl_Unit_Real: TEdit
      Left = 622
      Top = 23
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object E_bs_Calculo: TEdit
      Left = 384
      Top = 23
      Width = 99
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnExit = E_bs_CalculoExit
    end
    object E_Vl_Cotacao: TEdit
      Left = 575
      Top = 23
      Width = 46
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnExit = E_Vl_CotacaoExit
    end
  end
  object DBG_Custos: TDBGrid [2]
    Left = 0
    Top = 49
    Width = 718
    Height = 302
    Align = alClient
    Color = clMoneyGreen
    DataSource = Ds_Lista
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    Options = [dgTitles, dgColLines, dgRowSelect, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnDblClick = DBG_CustosDblClick
    Columns = <
      item
        Expanded = False
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CTP_DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 357
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_BS_CALCULO'
        Title.Caption = 'Base Calculo'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_VL_ORIG'
        Title.Caption = 'Valor Original'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_COTACAO'
        Title.Caption = 'Cota'#231#227'o'
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_VL_REAL'
        Title.Caption = 'Valor Real'
        Width = 89
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    Left = 56
    Top = 40
  end
  object Ds_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 124
    Top = 232
  end
  object Qr_Lista: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    AfterOpen = Qr_ListaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CUSTO_PEDIDO'
      'WHERE CTP_CODPED=:CTP_CODPED')
    Left = 124
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTP_CODPED'
        ParamType = ptUnknown
      end>
  end
end
