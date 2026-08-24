inherited TasRetaguardaWeb: TTasRetaguardaWeb
  BorderIcons = [biSystemMenu]
  Caption = 'Controle de Retaguarda - WEB'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_geral: TPanel [0]
    Left = 0
    Top = 0
    Width = 636
    Height = 332
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object chbx_Retaguarda_ativa: TCheckBox
      AlignWithMargins = True
      Left = 9
      Top = 5
      Width = 622
      Height = 17
      Margins.Left = 7
      Align = alTop
      Caption = 'Ativar conex'#227'o com a retaguarda na WEB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object pnl_row_01: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 71
      Width = 626
      Height = 37
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label1: TLabel
        Left = 5
        Top = -3
        Width = 40
        Height = 13
        Caption = 'Terminal'
      end
      object Label2: TLabel
        Left = 89
        Top = -3
        Width = 136
        Height = 13
        Caption = 'Caminho do Banco de Dados'
      end
      object e_terminal: TEdit
        Left = 4
        Top = 12
        Width = 81
        Height = 21
        TabOrder = 0
      end
      object e_path_bd: TEdit
        AlignWithMargins = True
        Left = 88
        Top = 12
        Width = 532
        Height = 21
        TabOrder = 1
      end
    end
    object dbg_reta_sync: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 157
      Width = 626
      Height = 170
      Align = alClient
      DataSource = ds_retaguarda_sync
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Width = 299
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DataTempo'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WAY'
          Width = 80
          Visible = True
        end>
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 28
      Width = 626
      Height = 37
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 4
        Top = -3
        Width = 40
        Height = 13
        Caption = 'Servidor'
      end
      object Label4: TLabel
        Left = 520
        Top = -3
        Width = 26
        Height = 13
        Caption = 'Porta'
      end
      object E_Path_server: TEdit
        Left = 4
        Top = 12
        Width = 514
        Height = 21
        TabOrder = 0
      end
      object E_Porta_server: TEdit
        AlignWithMargins = True
        Left = 520
        Top = 12
        Width = 100
        Height = 21
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 114
      Width = 626
      Height = 37
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Label5: TLabel
        Left = 5
        Top = -3
        Width = 83
        Height = 13
        Caption = 'Usuario do Banco'
      end
      object Label6: TLabel
        Left = 288
        Top = -3
        Width = 77
        Height = 13
        Caption = 'Senha do Banco'
      end
      object E_User_name: TEdit
        Left = 2
        Top = 12
        Width = 280
        Height = 21
        TabOrder = 0
      end
      object E_User_phrase: TEdit
        AlignWithMargins = True
        Left = 288
        Top = 12
        Width = 332
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
      end
    end
  end
  object pnl_botoes: TPanel [1]
    Left = 0
    Top = 332
    Width = 636
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 446
      Top = 5
      Width = 90
      Height = 57
      Align = alRight
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
      ExplicitLeft = 489
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 542
      Top = 5
      Width = 89
      Height = 57
      Align = alRight
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
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
  end
  inherited MnuBase: TMainMenu
    Left = 16
    Top = 296
    inherited arefas1: TMenuItem
      object PreparaBancoLocal1: TMenuItem [0]
        Caption = 'Prepara Banco Local'
        OnClick = PreparaBancoLocal1Click
      end
      object PreparabancoRetaguarda1: TMenuItem [1]
        Caption = 'Prepara banco Retaguarda'
        OnClick = PreparabancoRetaguarda1Click
      end
    end
  end
  object cds_retaguarda_sync: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 16
    object cds_retaguarda_syncID: TWideStringField
      DisplayLabel = 'Identificador'
      DisplayWidth = 48
      FieldName = 'ID'
      Origin = '"TB_RETAGUARDA_SYNC"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 100
    end
    object cds_retaguarda_syncDataTempo: TDateTimeField
      DisplayLabel = #218'ltima Atualiza'#231#227'o'
      FieldName = 'DataTempo'
    end
    object cds_retaguarda_syncWAY: TWideStringField
      DisplayLabel = 'Sentido'
      DisplayWidth = 7
      FieldName = 'WAY'
      Origin = '"TB_RETAGUARDA_SYNC"."WAY"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object ds_retaguarda_sync: TDataSource
    DataSet = cds_retaguarda_sync
    Left = 288
    Top = 16
  end
end
