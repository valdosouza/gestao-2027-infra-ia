inherited TasGeraNfeInutiliza: TTasGeraNfeInutiliza
  Caption = 'Inutiliza'#231#227'o de NFe'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    ActivePage = tbs_inutiliza
    object tbs_inutiliza: TTabSheet
      Caption = 'tbs_inutiliza'
      ImageIndex = 7
      object pnl_Inutil_nfe: TPanel
        Left = 0
        Top = 0
        Width = 578
        Height = 510
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          578
          510)
        object Label8: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Processo de inutiliza'#231#227'o de numera'#231#227'o de Nota Fiscal'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 379
        end
        object Label9: TLabel
          Left = 6
          Top = 21
          Width = 22
          Height = 13
          Caption = 'Ano '
        end
        object Label10: TLabel
          Left = 6
          Top = 61
          Width = 67
          Height = 13
          Caption = 'N'#250'mero Inicial'
        end
        object Label11: TLabel
          Left = 6
          Top = 101
          Width = 62
          Height = 13
          Caption = 'N'#250'mero Final'
        end
        object Label12: TLabel
          Left = 6
          Top = 141
          Width = 167
          Height = 13
          Caption = 'Justificativa (M'#237'nimo 15 caracteres)'
        end
        object Label13: TLabel
          Left = 8
          Top = 179
          Width = 45
          Height = 13
          Caption = 'Resposta'
        end
        object Label14: TLabel
          Left = 7
          Top = 491
          Width = 340
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 
            'Observa'#231#227'o: Nota Fiscal Consumidor Eletr'#244'nica n'#227'o pode ser Inuti' +
            'lizada'
          ExplicitTop = 462
        end
        object E_Inut_Ano: TEdit
          Left = 6
          Top = 37
          Width = 43
          Height = 21
          MaxLength = 4
          TabOrder = 0
        end
        object E_Inut_Numero_Ini: TEdit
          Left = 6
          Top = 77
          Width = 80
          Height = 21
          MaxLength = 6
          TabOrder = 1
        end
        object E_Inut_Numero_Fim: TEdit
          Left = 6
          Top = 117
          Width = 80
          Height = 21
          MaxLength = 6
          TabOrder = 2
        end
        object E_Inut_Justificativa: TEdit
          Left = 6
          Top = 157
          Width = 572
          Height = 21
          TabOrder = 3
        end
        object MM_Inut_Reposta: TMemo
          Left = 6
          Top = 192
          Width = 567
          Height = 293
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object Rg_Inut_TipoNfe: TRadioGroup
          Left = 95
          Top = 24
          Width = 307
          Height = 57
          Caption = 'Tipo NF Eletr'#244'nica'
          ItemIndex = 0
          Items.Strings = (
            'Modelo 55 - NF-e - Nota Fiscal Eletr'#244'nica'
            'Modelo 65 - NFC-e - Nota Fiscal Consumidor Eletr'#244'nica')
          TabOrder = 5
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 510
        Width = 578
        Height = 62
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_Inut_nfe_Confirmar: TSpeedButton
          AlignWithMargins = True
          Left = 403
          Top = 5
          Width = 82
          Height = 52
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
          Spacing = 1
          OnClick = Sb_Inut_nfe_ConfirmarClick
          ExplicitLeft = 426
          ExplicitTop = 6
          ExplicitHeight = 58
        end
        object Sb_Inut_nfe_Volta: TSpeedButton
          AlignWithMargins = True
          Left = 491
          Top = 5
          Width = 82
          Height = 52
          Align = alRight
          Caption = 'Voltar - Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Inut_nfe_VoltaClick
          ExplicitLeft = 511
          ExplicitTop = 6
          ExplicitHeight = 54
        end
      end
    end
  end
end
