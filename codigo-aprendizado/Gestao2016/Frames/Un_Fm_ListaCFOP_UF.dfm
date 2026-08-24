object Fm_ListaCFOP_UF: TFm_ListaCFOP_UF
  Left = 0
  Top = 0
  Width = 567
  Height = 45
  TabOrder = 0
  DesignSize = (
    567
    45)
  object Label25: TLabel
    Left = 214
    Top = 5
    Width = 94
    Height = 14
    Caption = 'Descri'#231#227'o do CFOP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object RG_Tipo_S_E: TRadioGroup
    Left = 0
    Top = 0
    Width = 128
    Height = 45
    Align = alLeft
    Caption = 'Tipo da Opera'#231#227'o'
    Columns = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Sa'#237'da'
      'Entrada')
    ParentFont = False
    TabOrder = 0
    OnClick = RG_Tipo_S_EClick
    ExplicitLeft = 4
  end
  object Dblcb_Lista: TDBLookupComboBox
    Left = 214
    Top = 20
    Width = 350
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    KeyField = 'NAT_CODIGO'
    ListField = 'CFOP'
    ListSource = Ds_Filtra_CFOP
    TabOrder = 1
    OnKeyDown = Dblcb_ListaKeyDown
  end
  inline Fm_ListaBuscaEstado: TFm_ListaEstados
    AlignWithMargins = True
    Left = 131
    Top = 3
    Width = 82
    Height = 39
    Align = alLeft
    TabOrder = 2
    ExplicitLeft = 128
    ExplicitWidth = 82
    ExplicitHeight = 45
    inherited pnl_linha_1: TPanel
      Width = 82
      ExplicitWidth = 67
      inherited Sb_open: TSpeedButton
        Left = 58
        ExplicitLeft = 44
        ExplicitTop = 0
        ExplicitHeight = 21
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 58
        OnClick = Fm_ListaBuscaEstadoDblcb_ListaClick
        OnKeyDown = Fm_ListaBuscaEstadoDblcb_ListaKeyDown
        ExplicitWidth = 44
      end
    end
    inherited pnl_top: TPanel
      Width = 82
      ExplicitWidth = 67
      inherited L_name_list: TLabel
        Width = 76
      end
    end
  end
  object Qr_Filtra_CFOP: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Lista
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'NAT_CODIGO,'
      'NAT_CFOP,'
      'NAT_DESCRICAO,'
      'NAT_CFOP || '#39' - '#39' || NAT_DESCRICAO CFOP,'
      'NAT_RESUMIDO'
      'FROM TB_NATUREZA'
      'WHERE NAT_ATIVO = '#39'S'#39
      '  AND NAT_SENTIDO =:NAT_SENTIDO'
      '  AND NAT_ALCADA=:NAT_ALCADA'
      'ORDER BY NAT_CFOP')
    Left = 214
    Top = 92
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NAT_SENTIDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NAT_ALCADA'
        ParamType = ptUnknown
      end>
  end
  object Ds_Filtra_CFOP: TDataSource
    DataSet = Qr_Filtra_CFOP
    Left = 214
    Top = 148
  end
  object IBT_Lista: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 324
    Top = 129
  end
end
