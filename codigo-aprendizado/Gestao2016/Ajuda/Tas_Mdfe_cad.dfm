inherited TasMdfeCad: TTasMdfeCad
  Caption = 'TasMdfeCad'
  ClientHeight = 560
  ClientWidth = 811
  ExplicitWidth = 817
  ExplicitHeight = 609
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 496
    Width = 811
    ExplicitTop = 496
    ExplicitWidth = 811
    inherited SB_Inserir: TSpeedButton
      Left = 184
      ExplicitLeft = 191
    end
    inherited SB_Alterar: TSpeedButton
      Left = 288
      ExplicitLeft = 293
    end
    inherited SB_Excluir: TSpeedButton
      Left = 392
      ExplicitLeft = 395
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 600
      ExplicitLeft = 599
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 704
      ExplicitLeft = 703
    end
    inherited SB_Gravar: TSpeedButton
      Left = 496
      ExplicitLeft = 497
    end
  end
  inherited pnl_fundo: TPanel
    Width = 811
    Height = 496
    ExplicitWidth = 811
    ExplicitHeight = 496
    object pg_mdfe: TPageControl
      Left = 2
      Top = 2
      Width = 807
      Height = 492
      ActivePage = tbs_mdfe
      Align = alClient
      TabOrder = 0
      object tbs_mdfe: TTabSheet
        Caption = 'tbs_mdfe'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnl_mdfe: TPanel
          Left = 0
          Top = 0
          Width = 799
          Height = 464
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = 'Panel1'
          TabOrder = 0
          object modelo: TLabel
            Left = 3
            Top = 22
            Width = 34
            Height = 13
            Caption = 'Modelo'
          end
          object serie: TLabel
            Left = 56
            Top = 22
            Width = 24
            Height = 13
            Caption = 'S'#233'rie'
          end
          object numero: TLabel
            Left = 107
            Top = 22
            Width = 37
            Height = 13
            Caption = 'Numero'
          end
          object dt_emissao: TLabel
            Left = 191
            Top = 22
            Width = 114
            Height = 13
            Caption = 'Data e Hora de Emiss'#227'o'
          end
          object dt_viagem: TLabel
            Left = 347
            Top = 22
            Width = 153
            Height = 13
            Caption = 'Data e Hora de Inicio de Viagem'
          end
          object tipo_emitente: TLabel
            Left = 91
            Top = 64
            Width = 80
            Height = 13
            Caption = 'Tipo de Emitente'
          end
          object tipo_transp: TLabel
            Left = 211
            Top = 64
            Width = 107
            Height = 13
            Caption = 'Tipo de Transportador'
          end
          object modalidade: TLabel
            Left = 324
            Top = 64
            Width = 54
            Height = 13
            Caption = 'Modalidade'
          end
          object forma_emissao: TLabel
            Left = 441
            Top = 64
            Width = 86
            Height = 13
            Caption = 'Forma de Emiss'#227'o'
          end
          object E_modelo: TEdit
            Left = 3
            Top = 37
            Width = 47
            Height = 21
            TabOrder = 0
          end
          object E_serie: TEdit
            Left = 53
            Top = 37
            Width = 45
            Height = 21
            TabOrder = 1
          end
          object E_numero: TEdit
            Left = 107
            Top = 37
            Width = 78
            Height = 21
            TabOrder = 2
          end
          object E_data_hora_emissao: TEdit
            Left = 191
            Top = 37
            Width = 150
            Height = 21
            TabOrder = 3
          end
          object E_data_hora_viagem: TEdit
            Left = 347
            Top = 37
            Width = 207
            Height = 21
            TabOrder = 4
          end
          object Cb_tipo_de_emitente: TComboBox
            Left = 91
            Top = 83
            Width = 114
            Height = 21
            TabOrder = 5
          end
          object Cb_tipo_de_transportador: TComboBox
            Left = 211
            Top = 83
            Width = 107
            Height = 21
            TabOrder = 6
          end
          object Cb_modalidade: TComboBox
            Left = 324
            Top = 83
            Width = 111
            Height = 21
            TabOrder = 7
          end
          object Cb_forma_de_emissao: TComboBox
            Left = 441
            Top = 83
            Width = 161
            Height = 21
            TabOrder = 8
          end
          object Grp_local_load: TGroupBox
            Left = 3
            Top = 110
            Width = 281
            Height = 281
            Caption = 'Local de Carregamento'
            TabOrder = 9
            object tirar: TLabel
              Left = 125
              Top = 14
              Width = 108
              Height = 13
              Caption = 'trocar_por_Fm_cidade'
            end
            object Grp_city_load: TGroupBox
              Left = 13
              Top = 60
              Width = 289
              Height = 183
              Caption = 'Munic'#237'pio ( 50 no max'#237'mo )'
              TabOrder = 0
            end
            object Dbg_city_load: TDBGrid
              Left = 16
              Top = 80
              Width = 265
              Height = 153
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'Munic'#237'pio'
                  Width = 172
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UF'
                  Width = 69
                  Visible = True
                end>
            end
            object Bt_ins_localload: TButton
              Left = 29
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Incluir'
              TabOrder = 2
            end
            object Bt_exc_localload: TButton
              Left = 110
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Excluir'
              TabOrder = 3
            end
          end
          object Grp_route: TGroupBox
            Left = 287
            Top = 110
            Width = 179
            Height = 281
            Caption = 'UF do Percurso'
            TabOrder = 10
            object Grp_uf_route: TGroupBox
              Left = 11
              Top = 60
              Width = 165
              Height = 183
              Caption = 'UF'#39's ( 25 no max'#237'mo )'
              TabOrder = 0
            end
            object Dbg_uf_route: TDBGrid
              Left = 21
              Top = 80
              Width = 148
              Height = 153
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'UF'
                  Width = 126
                  Visible = True
                end>
            end
            object Bt_ins_uf_route: TButton
              Left = 16
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Incluir'
              TabOrder = 2
            end
            object Bt_exc_uf_route: TButton
              Left = 97
              Top = 249
              Width = 75
              Height = 25
              Caption = 'Excluir'
              TabOrder = 3
            end
          end
          object Grp_unload: TGroupBox
            Left = 472
            Top = 110
            Width = 141
            Height = 281
            Caption = 'Local de Descarregamento'
            TabOrder = 11
            inline Fm_Listauf_unload: TFm_ListaEstados
              Left = 19
              Top = 19
              Width = 82
              Height = 41
              TabOrder = 0
              ExplicitLeft = 19
              ExplicitTop = 19
              ExplicitWidth = 82
              ExplicitHeight = 41
              inherited pnl_linha_1: TPanel
                Width = 82
                ExplicitWidth = 82
                inherited Sb_open: TSpeedButton
                  Left = 58
                  ExplicitLeft = 58
                end
                inherited Dblcb_Lista: TDBLookupComboBox
                  Width = 58
                  ExplicitWidth = 58
                end
              end
              inherited pnl_top: TPanel
                Width = 82
              end
            end
          end
          inline Fm_Listauf_mdfe: TFm_ListaEstados
            Left = 3
            Top = 64
            Width = 82
            Height = 41
            TabOrder = 12
            ExplicitLeft = 3
            ExplicitTop = 64
            ExplicitWidth = 82
            ExplicitHeight = 41
            inherited pnl_linha_1: TPanel
              Width = 82
              ExplicitWidth = 82
              inherited Sb_open: TSpeedButton
                Left = 58
                ExplicitLeft = 58
              end
              inherited Dblcb_Lista: TDBLookupComboBox
                Width = 58
                ExplicitWidth = 58
              end
            end
            inherited pnl_top: TPanel
              Width = 82
            end
          end
          inline Fm_Listauf_route: TFm_ListaEstados
            Left = 298
            Top = 129
            Width = 82
            Height = 41
            TabOrder = 13
            ExplicitLeft = 298
            ExplicitTop = 129
            ExplicitWidth = 82
            ExplicitHeight = 41
            inherited pnl_linha_1: TPanel
              Width = 82
              ExplicitWidth = 82
              inherited Sb_open: TSpeedButton
                Left = 58
                ExplicitLeft = 58
              end
              inherited Dblcb_Lista: TDBLookupComboBox
                Width = 58
                ExplicitWidth = 58
              end
            end
            inherited pnl_top: TPanel
              Width = 82
            end
          end
          inline Fm_Listauf_local_load: TFm_ListaEstados
            Left = 16
            Top = 133
            Width = 82
            Height = 41
            TabOrder = 14
            ExplicitLeft = 16
            ExplicitTop = 133
            ExplicitWidth = 82
            ExplicitHeight = 41
            inherited pnl_linha_1: TPanel
              Width = 82
              ExplicitWidth = 82
              inherited Sb_open: TSpeedButton
                Left = 58
                ExplicitLeft = 58
              end
              inherited Dblcb_Lista: TDBLookupComboBox
                Width = 58
                ExplicitWidth = 58
              end
            end
            inherited pnl_top: TPanel
              Width = 82
            end
          end
        end
      end
      object tbs_mdfe_road: TTabSheet
        Caption = 'tbs_mdfe_road'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnl_mdfe_road: TPanel
          Left = 0
          Top = 0
          Width = 799
          Height = 464
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = 'pnl_mdfe_road'
          TabOrder = 0
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'TabSheet3'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 104
    Top = 64
  end
end
