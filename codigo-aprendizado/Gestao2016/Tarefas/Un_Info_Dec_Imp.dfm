object Fr_Info_Dec_Imp: TFr_Info_Dec_Imp
  Left = 401
  Top = 177
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Declara'#231#227'o de Importa'#231#227'o - D.I.'
  ClientHeight = 426
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Fundos: TPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 362
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 64
      Top = 5
      Width = 148
      Height = 14
      Caption = 'N'#250'mero DI/DSI/DA/DRI-E/DUIMP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 5
      Top = 47
      Width = 193
      Height = 14
      Caption = 'Local do Desembara'#231'o/Armazenamento'
      FocusControl = E_Local
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 97
      Top = 88
      Width = 16
      Height = 14
      Caption = 'U.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 264
      Top = 5
      Width = 80
      Height = 14
      Caption = 'Data do Registro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 88
      Width = 67
      Height = 14
      Caption = 'Data Desemb.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Ins_Adicao: TSpeedButton
      Left = 5
      Top = 303
      Width = 94
      Height = 38
      Caption = 'Novo - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      OnClick = Sb_Ins_AdicaoClick
    end
    object Sb_Alt_Adicao: TSpeedButton
      Left = 99
      Top = 303
      Width = 97
      Height = 38
      Caption = 'Alterar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      OnClick = Sb_Alt_AdicaoClick
    end
    object Sb_Exc_Adicao: TSpeedButton
      Left = 196
      Top = 303
      Width = 100
      Height = 38
      Caption = 'Excluir - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      OnClick = Sb_Exc_AdicaoClick
    end
    object Label6: TLabel
      Left = 234
      Top = 5
      Width = 15
      Height = 14
      Caption = 'DV'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Codigo: TEdit
      Left = 5
      Top = 21
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object E_Local: TEdit
      Left = 5
      Top = 63
      Width = 522
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object DBLCB_UF: TDBLookupComboBox
      Left = 93
      Top = 102
      Width = 51
      Height = 21
      KeyField = 'UFE_CODIGO'
      ListField = 'UFE_SIGLA'
      ListSource = DM.Ds_UF
      TabOrder = 6
    end
    object E_Data: TDateTimePicker
      Left = 261
      Top = 21
      Width = 88
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object E_Dt_Desemb: TDateTimePicker
      Left = 5
      Top = 102
      Width = 87
      Height = 21
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 5
    end
    object DBG_Produtos: TDBGrid
      Left = 6
      Top = 127
      Width = 521
      Height = 173
      Color = clMoneyGreen
      DataSource = Ds_Adicao
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowSelect, dgTitleClick]
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clNavy
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ADC_NUMERO'
          Title.Caption = 'N'#250'mero'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ADC_SEQUENCIA'
          Title.Caption = 'Sequ'#234'ncia'
          Width = 108
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ADC_PEDCPA'
          Title.Caption = 'Pedido Compra'
          Width = 131
          Visible = True
        end>
    end
    object E_Numero: TEdit
      Left = 63
      Top = 21
      Width = 165
      Height = 21
      TabOrder = 1
    end
    object chbx_Todos: TCheckBox
      Left = 4
      Top = 342
      Width = 350
      Height = 17
      Caption = 'Aplicar esta informa'#231#227'o a todos os itens do pedido'
      TabOrder = 9
    end
    inline Fm_ListaFornecedores: TFm_ListaFornecedores
      Left = 148
      Top = 86
      Width = 385
      Height = 39
      TabOrder = 7
      ExplicitLeft = 148
      ExplicitTop = 86
      ExplicitWidth = 385
      inherited pnl_01: TPanel
        Width = 385
        ExplicitWidth = 385
        inherited ChBx_Nome: TCheckBox
          Left = 42
          ExplicitLeft = 42
          ExplicitTop = 1
          ExplicitHeight = 14
        end
        inherited ChBx_Fantasia: TCheckBox
          Left = 168
          ExplicitLeft = 168
          ExplicitTop = 1
          ExplicitHeight = 14
        end
      end
      inherited pnl_02: TPanel
        Width = 385
        ExplicitWidth = 385
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 357
          ExplicitLeft = 357
        end
        inherited SB_Empresas: TSpeedButton
          Left = 332
          ExplicitLeft = 332
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitLeft = 1
          ExplicitTop = 1
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 264
          ExplicitLeft = 66
          ExplicitTop = 1
          ExplicitWidth = 264
        end
      end
    end
    object E_Div: TEdit
      Left = 231
      Top = 21
      Width = 24
      Height = 21
      TabOrder = 2
    end
  end
  object pnl_botoes: TPanel
    Left = 0
    Top = 362
    Width = 537
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Alterar: TSpeedButton
      AlignWithMargins = True
      Left = 74
      Top = 5
      Width = 90
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Alterar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_AlterarClick
      ExplicitLeft = 15
    end
    object SB_Excluir: TSpeedButton
      AlignWithMargins = True
      Left = 166
      Top = 5
      Width = 90
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Excluir - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ExcluirClick
      ExplicitLeft = 107
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 258
      Top = 5
      Width = 90
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GravarClick
      ExplicitTop = 6
    end
    object SB_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 350
      Top = 5
      Width = 90
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 291
    end
    object SB_Sair: TSpeedButton
      AlignWithMargins = True
      Left = 442
      Top = 5
      Width = 90
      Height = 54
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_SairClick
      ExplicitLeft = 383
    end
  end
  object Qr_Adicao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Atualiza
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  ADC_CODIGO,'
      '  ADC_CODDIM,'
      '  ADC_NUMERO,'
      '  ADC_SEQUENCIA,'
      '  ADC_CODFAB,'
      '  ADC_VL_DESC,'
      '  ADC_PEDCPA,'
      '  ADC_ITMCPA'
      'FROM TB_ADIC_IMP'
      'WHERE ADC_CODDIM =:ADC_CODDIM')
    Left = 368
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADC_CODDIM'
        ParamType = ptUnknown
      end>
  end
  object Ds_Adicao: TDataSource
    DataSet = Qr_Adicao
    Left = 370
    Top = 224
  end
  object IBT_Atualiza: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 444
    Top = 177
  end
end
