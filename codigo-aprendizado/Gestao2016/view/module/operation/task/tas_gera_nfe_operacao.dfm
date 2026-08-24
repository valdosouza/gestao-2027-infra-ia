inherited TasGeraNfeOperacao: TTasGeraNfeOperacao
  Caption = 'TasGeraNfeOperacao'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    ActivePage = tbs_Oper_Nfe
    object tbs_Oper_Nfe: TTabSheet
      Caption = 'Opera'#231#245'es NF-e'
      ImageIndex = 8
      object Panel9: TPanel
        Left = 0
        Top = 434
        Width = 578
        Height = 62
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Sb_Clta_NFe_Confirmar: TSpeedButton
          AlignWithMargins = True
          Left = 403
          Top = 5
          Width = 82
          Height = 52
          Align = alRight
          Caption = 'Consultar - F10'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 1
          OnClick = Sb_Clta_NFe_ConfirmarClick
          ExplicitLeft = 407
          ExplicitTop = 6
        end
        object Sb_Clta_Nfe_Voltar: TSpeedButton
          AlignWithMargins = True
          Left = 491
          Top = 5
          Width = 82
          Height = 52
          Align = alRight
          Caption = 'Sair - Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Clta_Nfe_VoltarClick
          ExplicitLeft = 495
          ExplicitTop = 6
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 578
        Height = 434
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Label1: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Opera'#231#245'es em Lote de Nota Fiscal Eletr'#244'nica '
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 320
        end
        object Lb_6_Inicio: TLabel
          Left = 197
          Top = 20
          Width = 53
          Height = 13
          Caption = 'Nota Inicial'
        end
        object Lb_6_Fim: TLabel
          Left = 286
          Top = 20
          Width = 48
          Height = 13
          Caption = 'Nota Final'
        end
        object MM_Clta_NFe_Retorno: TMemo
          Left = 2
          Top = 62
          Width = 574
          Height = 370
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object Ed_6_Inicio: TEdit
          Left = 199
          Top = 35
          Width = 83
          Height = 21
          TabOrder = 1
        end
        object Ed_6_Fim: TEdit
          Left = 284
          Top = 35
          Width = 83
          Height = 21
          TabOrder = 2
        end
        object RG_6_Tipo_Pesquisa: TRadioGroup
          Left = 5
          Top = 19
          Width = 188
          Height = 37
          Caption = 'Tipo Pesquisa'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Numero N.F'
            'Data')
          TabOrder = 3
          OnClick = RG_6_Tipo_PesquisaClick
        end
        object chbx_oper_Nfe_CAnceladas: TCheckBox
          Left = 373
          Top = 39
          Width = 164
          Height = 17
          Caption = 'Somente as Canceladas'
          TabOrder = 4
        end
        object Chbx_NFe_Pendente: TCheckBox
          Left = 373
          Top = 22
          Width = 127
          Height = 17
          Caption = 'Somente as Pendentes'
          TabOrder = 5
        end
      end
    end
  end
  inherited Qr_lote: TSTQuery
    Left = 524
  end
end
