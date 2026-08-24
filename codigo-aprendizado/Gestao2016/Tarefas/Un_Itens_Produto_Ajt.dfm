inherited Fr_Itens_Produto_Ajt: TFr_Itens_Produto_Ajt
  Caption = 'Itens do Ajuste de Estoque'
  ClientHeight = 645
  ExplicitHeight = 674
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBG_Produtos: TDBGrid
    Top = 316
    Height = 282
  end
  inherited pnl_botao_lista: TPanel
    Top = 601
    ExplicitTop = 601
  end
  inherited Pg_Main: TPageControl
    Height = 313
    ExplicitHeight = 313
    inherited tbs_item: TTabSheet
      ExplicitHeight = 285
      inherited pnl_dados_items: TPanel
        Height = 168
        ExplicitHeight = 168
        inherited Label14: TLabel
          Left = 247
          Top = 48
          ExplicitLeft = 247
          ExplicitTop = 48
        end
        inherited Label15: TLabel
          Top = 4
          ExplicitTop = 4
        end
        inherited Label16: TLabel
          Left = 595
          Top = 48
          ExplicitLeft = 595
          ExplicitTop = 48
        end
        inherited lb_Aq_com: TLabel
          Left = 95
          Top = 108
          Visible = False
          ExplicitLeft = 95
          ExplicitTop = 108
        end
        inherited Lb_DescricaoProduto: TLabel
          Top = 5
          ExplicitTop = 5
        end
        inherited Label2: TLabel
          Left = 316
          Top = 48
          ExplicitLeft = 316
          ExplicitTop = 48
        end
        inherited Label13: TLabel
          Top = 4
          ExplicitTop = 4
        end
        inherited Label3: TLabel
          Top = 48
          ExplicitTop = 48
        end
        inherited Label4: TLabel
          Left = 530
          Top = 48
          ExplicitLeft = 530
          ExplicitTop = 48
        end
        inherited Label7: TLabel
          Left = 460
          Top = 48
          ExplicitLeft = 460
          ExplicitTop = 48
        end
        inherited Label10: TLabel
          Left = 663
          Top = 48
          ExplicitLeft = 663
          ExplicitTop = 48
        end
        inherited Label11: TLabel
          Left = 365
          Top = 46
          ExplicitLeft = 365
          ExplicitTop = 46
        end
        inherited Lb_Largura: TLabel
          Top = 48
          ExplicitTop = 48
        end
        inherited Lb_Altura: TLabel
          Top = 48
          ExplicitTop = 48
        end
        inherited Lb_Nr_Pecas: TLabel
          Top = 48
          ExplicitTop = 48
        end
        inherited Label9: TLabel
          Left = 6
          Top = 108
          Visible = False
          ExplicitLeft = 6
          ExplicitTop = 108
        end
        inherited E_CodPro: TEdit
          Top = 20
          ExplicitTop = 20
        end
        inherited E_Qt_Produto: TEdit_Setes
          Left = 247
          Top = 64
          ExplicitLeft = 247
          ExplicitTop = 64
        end
        inherited E_Vl_Unitario: TEdit_Setes
          Top = 20
          ExplicitTop = 20
        end
        inherited E_Aq_IPI: TEdit_Setes
          Left = 595
          Top = 64
          ExplicitLeft = 595
          ExplicitTop = 64
        end
        inherited E_Aq_Com: TEdit_Setes
          Left = 93
          Top = 124
          Visible = False
          ExplicitLeft = 93
          ExplicitTop = 124
        end
        inherited E_Descricao: TEdit
          Top = 20
          ExplicitTop = 20
        end
        inherited E_Unidade: TEdit
          Left = 314
          Top = 64
          ExplicitLeft = 314
          ExplicitTop = 64
        end
        inherited E_VL_Desconto: TEdit_Setes
          Left = 528
          Top = 64
          ExplicitLeft = 528
          ExplicitTop = 64
        end
        inherited E_Aq_Desconto: TEdit_Setes
          Left = 458
          Top = 64
          ExplicitLeft = 458
          ExplicitTop = 64
        end
        inherited E_Aq_Icms: TEdit_Setes
          Left = 663
          Top = 64
          ExplicitLeft = 663
          ExplicitTop = 64
        end
        inherited E_VL_Produto: TPanel
          Left = 363
          Top = 64
          Width = 91
          ExplicitLeft = 363
          ExplicitTop = 64
          ExplicitWidth = 91
        end
        inherited E_Vl_SubTotal: TPanel
          Left = 730
          Top = 64
          Width = 119
          ExplicitLeft = 730
          ExplicitTop = 64
          ExplicitWidth = 119
        end
        inherited e_Largura: TEdit_Setes
          Top = 64
          ExplicitTop = 64
        end
        inherited E_Altura: TEdit_Setes
          Top = 64
          ExplicitTop = 64
        end
        inherited E_Nr_Peca: TEdit_Setes
          Top = 64
          ExplicitTop = 64
        end
        inherited Dblcb_Tabelas: TDBLookupComboBox
          Top = 125
          Width = 85
          Visible = False
          ExplicitTop = 125
          ExplicitWidth = 85
        end
        object grp_devIPI: TGroupBox
          Left = 595
          Top = 94
          Width = 247
          Height = 64
          Caption = 'Devolu'#231#227'o de IPI (apenas para  N.F. Devolu'#231#227'o)'
          TabOrder = 16
          object Label5: TLabel
            Left = 76
            Top = 17
            Width = 40
            Height = 13
            Caption = 'Valor IPI'
            FocusControl = E_vIpi
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 9
            Top = 16
            Width = 40
            Height = 13
            Caption = 'Taxa IPI'
            FocusControl = E_vIpi
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object e_pIpi: TEdit_Setes
            Left = 6
            Top = 33
            Width = 64
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,00'
            OnExit = e_pIpiExit
          end
          object E_vIpi: TEdit_Setes
            Left = 75
            Top = 33
            Width = 74
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
            Text = '0,00'
          end
        end
      end
      inherited pnl_rodape: TPanel
        Top = 216
        ExplicitTop = 216
        inherited pnl_estoque: TPanel
          inherited Lb_Tipo: TLabel
            Top = 18
            ExplicitTop = 18
          end
          inherited Lb_CustoUnitario: TLabel
            Left = 88
            Top = 18
            ExplicitLeft = 88
            ExplicitTop = 18
          end
          inherited Sb_Corte: TSpeedButton
            Left = 151
            Top = 37
            ExplicitLeft = 151
            ExplicitTop = 37
          end
          inherited E_CustoUnitario: TEdit_Setes
            Left = 86
            ExplicitLeft = 86
          end
          inherited E_Qtde_Disp: TPanel
            Left = 3
            ExplicitLeft = 3
          end
        end
      end
    end
    inherited tbs_tributacao: TTabSheet
      ExplicitHeight = 285
      inherited pnl_tributacao: TPanel
        Height = 285
        ExplicitHeight = 285
        inherited Label1: TLabel
          Top = 260
          ExplicitTop = 260
        end
        inherited Lb_Tipo_Regra: TLabel
          Top = 234
          ExplicitTop = 234
        end
        inherited LB_cst_csosn: TLabel
          Top = 208
          ExplicitTop = 208
        end
      end
      object RG_Tipo_S_E: TRadioGroup
        Left = 6
        Top = 44
        Width = 147
        Height = 53
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
        TabOrder = 1
        OnClick = RG_Tipo_S_EClick
      end
    end
  end
  inherited AcaoMostra: TActionList
    Left = 556
    Top = 8
  end
end
