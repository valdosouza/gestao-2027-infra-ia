inherited Fr_Transportadora: TFr_Transportadora
  Caption = 'Cadastro de Transportadora'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited PG_Informacoes: TPageControl
      ActivePage = TabSheet2
      inherited TabSheet3: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 656
        ExplicitHeight = 224
        inherited pg_fiscal: TPageControl
          inherited TabSheet6: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 648
            ExplicitHeight = 196
          end
          inherited TabSheet8: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 648
            ExplicitHeight = 196
          end
        end
      end
      inherited Contato: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      inherited TabSheet1: TTabSheet
        inherited Pnl_Tributacao: TPanel
          inherited ChBx_Ativa: TCheckBox
            Left = 302
            Top = 180
            Anchors = [akLeft]
            Visible = False
            ExplicitLeft = 302
            ExplicitTop = 180
          end
          object ChBx_TransportadoraAtiva: TCheckBox
            Left = 301
            Top = 200
            Width = 117
            Height = 17
            Caption = 'Transportador Ativa'
            TabOrder = 5
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Tabela de Frete'
        ImageIndex = 4
        OnShow = TabSheet2Show
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Frete: TPanel
          Left = 0
          Top = 0
          Width = 656
          Height = 224
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            656
            224)
          object Sb_Exc_Frete: TSpeedButton
            Left = 197
            Top = 181
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Exc_FreteClick
            ExplicitTop = 168
          end
          object Sb_Alt_Frete: TSpeedButton
            Left = 106
            Top = 183
            Width = 97
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Alt_FreteClick
          end
          object Sb_Ins_Frete: TSpeedButton
            Left = 6
            Top = 183
            Width = 94
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Ins_FreteClick
          end
          object DBGrid1: TDBGrid
            Left = 2
            Top = 2
            Width = 652
            Height = 175
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataSource = Ds_Frete
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'FRT_CODIGO'
                Title.Caption = 'C'#243'digo'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FRT_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o da Tabela de Frete'
                Width = 523
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited Menu: TMainMenu
    inherited Mnu_Tarefas: TMenuItem
      object FichaFinanceira1: TMenuItem
        Caption = 'Ficha Financeira'
        OnClick = FichaFinanceira1Click
      end
    end
  end
  inherited Qr_BuscaFone: TSTQuery
    Left = 240
    Top = 128
  end
  inherited Qr_BuscaEmail: TSTQuery
    Left = 352
    Top = 152
  end
  inherited Ds_Contato: TDataSource
    Left = 469
  end
  inherited Qr_Endereco: TSTQuery
    Left = 525
  end
  object Qr_Frete: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT FRT_CODIGO, FRT_DESCRICAO'
      'FROM TB_FRETE'
      'WHERE FRT_CODEMP=:EMP_CODIGO'
      'ORDER BY FRT_DESCRICAO')
    Left = 573
    Top = 3
    ParamData = <
      item
        DataType = ftInteger
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_Frete: TDataSource
    DataSet = Qr_Frete
    Left = 573
    Top = 35
  end
  object Qr_Transportadora: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_TRANSPORTADORA'
      'WHERE (TRP_CODEMP =:EMP_CODIGO)')
    Left = 589
    Top = 147
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
