inherited Fr_Fornecedor: TFr_Fornecedor
  Caption = 'Cadastro de Fornecedor'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited PG_Informacoes: TPageControl
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
            Left = 314
            Top = 184
            Visible = False
            ExplicitLeft = 314
            ExplicitTop = 184
          end
          object ChBx_FornecedorAtivo: TCheckBox
            Left = 315
            Top = 202
            Width = 104
            Height = 17
            Caption = 'Fornecedor Ativo'
            TabOrder = 5
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Par'#226'metros'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Parametro: TPanel
          Left = 0
          Top = 0
          Width = 656
          Height = 224
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label10: TLabel
            Left = 7
            Top = 4
            Width = 53
            Height = 14
            Caption = 'Mala Direta'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 72
            Top = 4
            Width = 120
            Height = 14
            Caption = 'Nome da Transportadora'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBComboBox2: TDBComboBox
            Left = 6
            Top = 20
            Width = 55
            Height = 22
            AutoDropDown = True
            CharCase = ecUpperCase
            DataField = 'EMP_ML_DRT'
            DragMode = dmAutomatic
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Items.Strings = (
              'SIM'
              'N'#195#401'O')
            ParentFont = False
            TabOrder = 0
          end
          object DBLCB_Transportes: TDBLookupComboBox
            Left = 64
            Top = 19
            Width = 383
            Height = 22
            DataField = 'EMP_CODTRANSP'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'EMP_CODIGO'
            ListField = 'EMP_NOME'
            ListSource = DM_ListaConsultas.Ds_ListaTransportadora
            ParentFont = False
            TabOrder = 1
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
      object MovimentaoCompras1: TMenuItem
        Caption = 'Movimenta'#231#227'o Compras'
      end
    end
  end
  inherited Ds_Contato: TDataSource
    Top = 195
  end
  inherited Qr_Endereco: TSTQuery
    Left = 533
  end
  object Qr_Fornecedor: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_FORNECEDOR'
      'WHERE (FOR_CODEMP =:EMP_CODIGO)')
    Left = 597
    Top = 147
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
end
