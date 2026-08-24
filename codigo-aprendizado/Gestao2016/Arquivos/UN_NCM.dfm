object Fr_ncm: TFr_ncm
  Left = 303
  Top = 232
  Anchors = [akTop, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Ncm'
  ClientHeight = 182
  ClientWidth = 565
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_fundos: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 118
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 3
      Width = 198
      Height = 13
      Caption = 'Nomenclatura Comum do Mercosul - NCM'
      FocusControl = E_ncm
    end
    object Label2: TLabel
      Left = 5
      Top = 38
      Width = 48
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = E_Descricao
    end
    object Label5: TLabel
      Left = 5
      Top = 75
      Width = 120
      Height = 13
      Caption = 'Imposto Federal Nacional'
      FocusControl = E_Aliq_Nacional
    end
    object Label6: TLabel
      Left = 146
      Top = 75
      Width = 125
      Height = 13
      Caption = 'Imposto Federal Importado'
      FocusControl = E_Aliq_Importado
    end
    object Label3: TLabel
      Left = 282
      Top = 75
      Width = 81
      Height = 13
      Caption = 'Imposto Estadual'
      FocusControl = E_Aliq_Importado
    end
    object Label4: TLabel
      Left = 422
      Top = 75
      Width = 85
      Height = 13
      Caption = 'Imposto Municipal'
      FocusControl = E_Aliq_Importado
    end
    object E_ncm: TEdit_Setes
      Left = 5
      Top = 16
      Width = 134
      Height = 21
      TabStop = False
      TabOrder = 0
      Text = ''
    end
    object E_Descricao: TEdit
      Left = 5
      Top = 53
      Width = 554
      Height = 21
      TabOrder = 1
    end
    object E_Aliq_Nacional: TEdit_Setes
      Left = 5
      Top = 91
      Width = 138
      Height = 21
      TabOrder = 2
      Text = ''
    end
    object E_Aliq_Importado: TEdit_Setes
      Left = 143
      Top = 91
      Width = 138
      Height = 21
      TabOrder = 3
      Text = ''
    end
    object E_Aliq_Estadual: TEdit_Setes
      Left = 283
      Top = 91
      Width = 138
      Height = 21
      TabOrder = 4
      Text = ''
    end
    object E_Aliq_Municipal: TEdit_Setes
      Left = 421
      Top = 91
      Width = 138
      Height = 21
      TabOrder = 5
      Text = ''
    end
  end
  object pnl_botoes: TPanel
    Left = 0
    Top = 118
    Width = 565
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      565
      64)
    object SB_Gravar: TSpeedButton
      Left = 396
      Top = 6
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
    object Sb_Sair_0: TSpeedButton
      Left = 480
      Top = 5
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
    end
  end
  object Qr_Atualiza: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'UPDATE OR INSERT INTO TB_NCM (NCM_N_NCM, NCM_DESCRICAO, NCM_AQ_N' +
        'AC, NCM_AQ_IMP, NCM_AQ_ESTADUAL, NCM_AQ_MUNICIPAL)'
      
        '                      VALUES (:NCM_N_NCM, :NCM_DESCRICAO, :NCM_A' +
        'Q_NAC, :NCM_AQ_IMP, :NCM_AQ_ESTADUAL, :NCM_AQ_MUNICIPAL)'
      '                    MATCHING (NCM_N_NCM);')
    Left = 232
    Top = 18
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NCM_N_NCM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NCM_DESCRICAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NCM_AQ_NAC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NCM_AQ_IMP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NCM_AQ_ESTADUAL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NCM_AQ_MUNICIPAL'
        ParamType = ptUnknown
      end>
  end
  object Qr_Ncm: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select *'
      'From tb_NCM'
      'where NCM_N_NCM=:NCM_N_NCM')
    Left = 152
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NCM_N_NCM'
        ParamType = ptUnknown
      end>
  end
end
