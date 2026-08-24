object Fr_Corte_Chapa: TFr_Corte_Chapa
  Left = 367
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Controle de Corte de Chapas'
  ClientHeight = 312
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 519
    Height = 312
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Formato Quadrado'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 284
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          511
          284)
        object SB_Aplicar: TSpeedButton
          Left = 349
          Top = 225
          Width = 78
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar '
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
            33333333373F33333333333330B03333333333337F7F33333333333330F03333
            333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
            333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
            333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
            3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
            33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
            33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
            03333337777777F7F33333330000000003333337777777773333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          OnClick = SB_AplicarClick
        end
        object Sb_Sair_0: TSpeedButton
          Left = 428
          Top = 225
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
        object Sb_Calcular: TSpeedButton
          Left = 270
          Top = 225
          Width = 78
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Calcular'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF993300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993300993300FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            993300993300993300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF993300A7591A993300993300FF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993300A85C1CA85C1C99
            3300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF993300A95C1DAF6929AA5B22993300FF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF993300B26D35BC824DBE8554B06434993300FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993300BD8253CA9D73
            CFA57ECC9E79AE5F33993300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FF993300C99772D9B799DDBFA4E1C7AFD3A98E993300FF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF993300C7906FE7D2BEEBDACAEFE2D5F4EAE1CF
            A087993300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993300CFA186F5EC
            E4F9F4EFFCFAF8FDFAF8F6E9E0C38563993300FF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF993300D7B09BFDF9F6FBF4EDF9EEE3F7E8DAF5E3D0E2BDA1993300FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF993300DCB59EF9ECE0F6E6D6F5E1CDF3DBC3993300
            993300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF993300E1BFABF8EADDF6E4D3F4DFCAF2D9C0EA
            C9ABA44716FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993300F3DDC7F1D7
            BDEFD1B4EDCCAAEBC6A1E4B78D993300FF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF993300EDCAA7EBC49EE9BE94E7B88BE5B381E3AD78993300FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FF993300E6B687E4B17EE2AB75E0A56BDEA062
            DC9A58993300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993300DB9C62DD
            9E5FDB9855D9924BD88D44D78B40993300FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FF993300993300993300993300993300993300993300993300FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_CalcularClick
        end
        object GroupBox1: TGroupBox
          Left = 4
          Top = 1
          Width = 161
          Height = 99
          Caption = 'Dimens'#245'es da Chapa Inteira'
          TabOrder = 0
          object Label1: TLabel
            Left = 11
            Top = 16
            Width = 81
            Height = 13
            Caption = 'Altura (milimetros)'
          end
          object Label2: TLabel
            Left = 11
            Top = 53
            Width = 92
            Height = 13
            Caption = 'Largura (m'#237'limetros)'
          end
          object Label6: TLabel
            Left = 137
            Top = 35
            Width = 16
            Height = 13
            Caption = 'mm'
          end
          object Label7: TLabel
            Left = 138
            Top = 74
            Width = 16
            Height = 13
            Caption = 'mm'
          end
          object E_Altura_total: TEdit_Setes
            Left = 10
            Top = 31
            Width = 121
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
          object E_Largura_Total: TEdit_Setes
            Left = 10
            Top = 68
            Width = 121
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
        end
        object GroupBox2: TGroupBox
          Left = 166
          Top = 1
          Width = 161
          Height = 99
          Caption = 'Dimens'#245'es da Pe'#231'a Cortada'
          TabOrder = 1
          object Label3: TLabel
            Left = 11
            Top = 16
            Width = 81
            Height = 13
            Caption = 'Altura (milimetros)'
          end
          object Label4: TLabel
            Left = 11
            Top = 53
            Width = 92
            Height = 13
            Caption = 'Largura (m'#237'limetros)'
          end
          object Label8: TLabel
            Left = 136
            Top = 34
            Width = 16
            Height = 13
            Caption = 'mm'
          end
          object Label9: TLabel
            Left = 137
            Top = 73
            Width = 16
            Height = 13
            Caption = 'mm'
          end
          object E_Altura_Peca: TEdit_Setes
            Left = 10
            Top = 31
            Width = 121
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
          object E_Largura_Peca: TEdit_Setes
            Left = 10
            Top = 68
            Width = 121
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
        end
        object GroupBox4: TGroupBox
          Left = 328
          Top = 2
          Width = 165
          Height = 42
          Caption = 'Espessura da Serra'
          TabOrder = 2
          object Label5: TLabel
            Left = 130
            Top = 18
            Width = 16
            Height = 13
            Caption = 'mm'
          end
          object E_Espessura: TEdit_Setes
            Left = 10
            Top = 15
            Width = 115
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
        end
        object StrGrd_Informacao: TStringGrid
          Left = 2
          Top = 100
          Width = 503
          Height = 119
          Color = clCream
          ColCount = 3
          DefaultColWidth = 40
          DefaultRowHeight = 18
          RowCount = 6
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
          ParentFont = False
          TabOrder = 3
          OnDrawCell = StrGrd_InformacaoDrawCell
          ColWidths = (
            40
            40
            40)
          RowHeights = (
            18
            18
            18
            18
            18
            18)
        end
      end
    end
  end
end
