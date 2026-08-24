object Fr_Prod_Confeccao: TFr_Prod_Confeccao
  Left = 260
  Top = 84
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Produ'#231#227'o'
  ClientHeight = 573
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnDblClick = FormDblClick
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Tarefas: TPageControl
    Left = 0
    Top = 0
    Width = 857
    Height = 573
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object tbs_producao: TTabSheet
      Caption = 'Rela'#231#227'o de itens para Produ'#231#227'o'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 545
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          849
          545)
        object Sb_Buscar_0: TSpeedButton
          Left = 664
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Buscar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_Buscar_0Click
        end
        object Sb_Sair_0: TSpeedButton
          Left = 754
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Sair - ESC'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Sair_1Click
        end
        object SB_Ins_Tarefa_0: TSpeedButton
          Left = 575
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Inserir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_Ins_Tarefa_0Click
        end
        object DBG_Itens_Prd: TDBGrid
          Left = 4
          Top = 47
          Width = 841
          Height = 431
          Color = clMoneyGreen
          Ctl3D = True
          DataSource = Ds_ItensPrd
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowSelect]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clNavy
          TitleFont.Height = -11
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          OnCellClick = DBG_Itens_PrdCellClick
          Columns = <
            item
              Expanded = False
              FieldName = 'PED_NUMERO'
              Title.Caption = 'Pedido'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o do Produto'
              Width = 537
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GRT_QTDE'
              Title.Caption = 'Qtde'
              Width = 83
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GRT_TAMANHO'
              Title.Alignment = taCenter
              Title.Caption = 'Tamanho'
              Width = 77
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMP_NOME'
              Title.Caption = 'Raz'#227'o Social'
              Visible = True
            end>
        end
        object E_Data_Ped_Ini: TDateTimePicker
          Left = 5
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 1
        end
        object E_Data_Ped_Fim: TDateTimePicker
          Left = 98
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 2
        end
        object ChBx_Data_Pedido: TCheckBox
          Left = 7
          Top = 6
          Width = 154
          Height = 13
          Caption = 'Per'#237'odo Data do Pedido'
          TabOrder = 3
          OnClick = ChBx_Data_PedidoClick
        end
        object E_BuscaCliente: TMaskEdit
          Left = 192
          Top = 22
          Width = 469
          Height = 21
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 4
          Text = ''
        end
        object ChBx_Nome_Cli: TCheckBox
          Left = 193
          Top = 6
          Width = 125
          Height = 13
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = ChBx_Nome_CliClick
        end
        object ChBx_Fantasia_Cli: TCheckBox
          Left = 321
          Top = 6
          Width = 124
          Height = 13
          Caption = 'Apelido/Fantasia'
          TabOrder = 6
          OnClick = ChBx_Fantasia_CliClick
        end
        object E_Data_Ent_Ini: TDateTimePicker
          Left = 664
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 7
        end
        object E_Data_Ent_Fim: TDateTimePicker
          Left = 759
          Top = 22
          Width = 87
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 8
        end
        object ChBx_Data_Entrega: TCheckBox
          Left = 664
          Top = 6
          Width = 178
          Height = 13
          Caption = 'Per'#237'odo de Entrega'
          TabOrder = 9
          OnClick = ChBx_Data_EntregaClick
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Tarefas da Produ'#231#227'o'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 545
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          849
          545)
        object SB_Ins_Tarefa_1: TSpeedButton
          Left = 218
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Inserir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_Ins_Tarefa_1Click
        end
        object SB_Alt_Tarefa: TSpeedButton
          Left = 308
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Alterar - F3'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_Alt_TarefaClick
        end
        object SB_Exc_Tarefa: TSpeedButton
          Left = 397
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Excluir - F4'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_Exc_TarefaClick
        end
        object SB_Ret_Tarefa: TSpeedButton
          Left = 486
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Retorno - F10'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            D60B0000424DD60B00000000000036000000280000001F0000001F0000000100
            180000000000A00B0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7E9E7E7EEEAEAF5F0F0F6F1F1F5F1
            F1F5F1F1F4EFEFEFEBEBE3E2E2F6F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFE2E1E1CFC8C8A193935C4242815D5DA98484B38C8CAE87
            87AF8585A47A7A825D5D371B1B938383D9D4D4E7E8E8FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFF2EEEE8E7777725353BAA2A2E0D3D3E7E1E1E0DCDCDED2D2DDCF
            CFDCCCCCD5BBBBD6B3B3E1B7B7AA7E7E8A6363746161DADBDBFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFEFEAEAB39797B7A0A0E4E2E2E6E9E9DEE1E1DBD9D9D9D4D4D9CECED7CA
            CACDB2B2B49292A98989B59191CDA6A6D4A7A7A27070745A5AD0D1D1FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            F9F7F7BFA5A5B59B9BEAEEEEE8EAEAE6E6E6E4E5E5DFE0E0DBDCDCDAD4D4D6CA
            CAC7A6A6C9BCBCA19A9A947C7C9F7A7AC49C9CDFB3B3AC7575453434FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            F5EFEFC8ACACD7D0D0EBEFEFECECECEEEEEEEEEEEEE7E8E8DFE0E0DCDBDBD5C9
            C9C5A2A2D4C8C8A59191A38C8CA28282BE9797D1A8A8D8A4A4563131FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            F7F1F1D4BABADFDBDBEEEFEFF5F5F5F8F8F8F5F4F4ECECECE5E5E5DBDCDCD2C3
            C3C7A0A0CDB5B5AB8383AC8383AD8181C49A9AD0A9A9D8A6A6623737FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            F7F2F2C7A4A4D1C0C0F3FAFAFAFDFDFFFFFFFCFFFFEDEEEEE7E7E7DADDDDCBB0
            B0CDA6A6C69E9EB17B7BB57C7CB47878C69999D3AEAEC68D8DBDA8A8FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFF0E5E5CCAAAAE4DDDDF0EEEEDAB9B8E6D2D1EFF8F7E9F4F4D9D8D8C7A2
            A2D0A6A6BF8484B87272BC7373BD6F6FD0A4A4EAB9B9683F3FE0E1E1FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0E4E4CCA7A7C69695BF8189BC7684BB7179D0B3B6D8D8D9C897
            97CA9796C27272C16C6CC46C6CC96D6DCF9090401818EFF2F2FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFCFADB7D0845CFFCF6BF9DFC1D08D8BC07177C57C
            81C66768C96363CC6767D06666C05353988A8AFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFD2BDBDB58996D68C5AFB9700FFA102FDC34DF2C085DAA8
            9BCA8083C5696EC45F63BC5255B65053FFF1F3FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFDFCECFC59CA4DE9450FFAB1BE49619B06F03B2730BB47E
            1DA986519B77658F595089433E672621C6B6ABFFFBF0FDF6EBFCF5EAFCF5EAFC
            F5EAFCF5EAFCF5E8FEFBF6FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFF6F5F5C6AEB0BC8D93E79E4AFFB224DF9B38BA8A3AB98737BB87
            32BD8628BF8826BC8C36BA8738B07727B47D2CF9C575F8C474F7C77DF7C881F7
            C880F8CA83F6BE6AFAE1BBFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFEFEBEBC0A5A7B9898CEEA843FFB52BF0B05DFFD686FFD27EFFD2
            7EFFD384FFE3A9FFECBDFFECBAFFEFBDFFE9B8FDDBAAFCDDAEFCC575FCC067FC
            C26BFDC571F7AC3BF8D399FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFBF9F9D9C4C8BE8F89F1B042FFBC38EAAE5CFFD189FFCC81FFC7
            76FFC878FFDBA8FFE5C1FFE3BCFFE5C0FFE3BAFFE8C6FFE4BBFFCF8AFFC470FF
            CA7BFFD18BF8B753F8D6A2FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFD7CDCDB4979FD09F82F5B846FFC147EBB05CFFD086FFCA7CFFE0
            B3FFE6C3FFDEAEFFE1B5FFE5C1FFD9A0FFEBD2FFCD84FFF5E6FFCE88FFEACEFF
            D8A0FFCC80F8B651F8D6A1FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFD0C0C0AB8A97DBAE82F9BE4EFFC756EBB05FFFC975FFC570FFD2
            94FFD598FFD18FFFD391FFD598FFCF88FFD8A0FFC97BFFDCA9FFCB7DFFD89EFF
            CF87FFC772F8B249F8D7A2FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFE6DAD9AE92A3E3B377FFC757FFCC61EBA94EFFF5E1FFE2BBFFDE
            AEFFEACDFFE2B8FFE4BFFFEDD3FFDDABFFF2E0FFCE87FFFCF9FFCE8AFFEFD6FF
            E0B2FFEDD4F8C476F8D299FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFC7C3C38B7778CBB0B9E7B771FFCF61FFD36DEBAE58FFDA9EFFCF8CFFCE
            88FFD493FFCF8AFFD28EFFD495FFCF87FFD69AFFCA7CFFD9A2FFCA7DFFD496FF
            CF89FFD799F8B959F8D49EFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFDED8D8B3A1A5D0B9B2EABE70FFD36BFFD87BEBAA53FFF0D4FFE1B3FFDE
            ABFFE8C8FFE0B4FFE3B9FFE9CAFFDBA7FFEFD7FFCE87FFF8EDFFD08AFFECD0FF
            DDADFFEACBF8C372F8D49AFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFE0DADAC1B2B8D7C0ADECC26EFFD878FFDC86ECAD55FFE1AEFFD79BFFD5
            95FFDCA4FFD799FFD99DFFDDA6FFD694FFE0AEFFCE83FFE5B9FFCE85FFDEA8FF
            D696FFDFA9F9BB5DF9D39AFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            F7F7F7C3BDBDC0B4BCD8BEA4F1C971FFDB80FFE697EB9622EA8714EA8B17EA8C
            17EA8A15EA8B16EA8A17EA8A15EA8B19EA8A16EA8F1CF09216ED9019EA8A11EA
            8B14EA8A13EA8507F8CF9CFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            F3F2F2BCB5B6C4BABFDBC097FAD476FFE087FFE89BF5CC76D98B39DD9640DD95
            43DD9544DD9543DD9540DD953EDD923ADD9036E29B35B4521DD28B4DDF9856DD
            9554DB8F4FE6AE82FCF3EAFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            E4E5E4B7B4B5D3CDCEC2AC8AEBCB80FBDD8DFFED99FFFDB1FFFFC8FFFFD0FFFF
            D7FFFFD8FFFFD5FFFFCEFFFFC3FFFCBAFFF8ACFFFFA8864060D6DCEBFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            D2D2D2A2A1A1E3E0E09D9391A9988BB39E87BCA88CCEBE97DFD0A3F5EDB9FFFC
            C6FFFFCAFFFFCAFFFFC2FFF7B4FFEEA9FFE99BFFE2957F3D49C6C4C3FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            D2D1D1858686D6D6D6D3CFD0CEC7CBC6BDC2B5A7AEAB989BA8908DA68C84B59D
            91C8B49FD8CAACE7DBB3F5EAB0FFF3ADFFFFA5FDDB99632A35A9ACABFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            F3F3F3DDDEDEC4C5C5959292A7A1A1B4ABABC4BAB9C9BDBEDAC9CBD4BFC2CBB2
            B5BCA0A1AF8D8EAE8A87B59086BB9485C9A687C7987FA9797EEEF7F7FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFAFAFAF0F0F0F6F5F5E2DFDFB3ACACB2A8A8B7ADADBDADADA58B
            8CBAA0A0C5A9AAD0B3B5D1B3B5CDABAEC39CA1B17F80B49292FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDE2DD
            DDE6E2E2F0EEEECCB8B8A17F7FB09191C1A0A1B48888AA8B8BFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_Ret_TarefaClick
        end
        object Sb_Buscar_1: TSpeedButton
          Left = 664
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Buscar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_Buscar_1Click
        end
        object Sb_Sair_1: TSpeedButton
          Left = 754
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Sair - ESC'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Sair_1Click
        end
        object SB_Imp_Romaneio: TSpeedButton
          Left = 575
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Imprimir - F11'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFF9F9F9E3E3E3E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
            E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
            E1E1E1E1E1F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFBCBCBC9999999393939393939393939393939393939292
            929191919090908F8F8F8E8E8E8E8E8E8C8C8C8B8B8B8A8A8A8A8A8A89898989
            8989828282D3D3D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFD5D5D5F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFDFDFDF8F8F8F3F3F3F0F0F0EBEBEBE6E6E6E2E2E2DEDEDED9D9D9DE
            DEDEA0A0A0F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFE6E6E6C0C0C0ABABABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFBFBFBF6F6F6F3F3F3EEEEEEE9E9E9E5E5E5E1E1E1DCDCDCD8D8D8D5D5D5D4
            D4D47F7F7FC8C8C8E5E5E5FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9
            B5B5B58989898989899E9E9EA6A6A6F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFCFCFCF7F7F7F3F3F3EFEFEFEAEAEAE6E6E6E2E2E2DDDDDDDCDCDCC1
            C1C19F9F9F9393937D7D7D848484B6B6B6F4F4F4FFFFFFFFFFFFFFFFFF9D9D9D
            A1A1A1B9B9B9B4B4B4A9A9A9959595C5C5C5FFFFFFFDFDFDFDFDFDFDFDFDFDFD
            FDFDFDFDFCFCFCF8F8F8F4F4F4F0F0F0ECECECE6E6E6E3E3E3DFDFDFDEDEDEA1
            A1A1A0A0A0A7A7A7B1B1B1B3B3B3888888A3A3A3FFFFFFFFFFFFE5E5E5A1A1A1
            BFBFBFC1C1C1666666000000000000535353E0E0E0DADADAD9D9D9D9D9D9D9D9
            D9D9D9D9D9D9D9D9D9D9D6D6D6D2D2D2CECECECBCBCBC7C7C7C5C5C5BFBFBF32
            32320000000909099C9C9CBCBCBCC1C1C17E7E7EF2F2F2FFFFFFB2B2B2BCBCBC
            BDBDBDC7C7C76565650000000000000000002626262626262626262626262626
            2626262626262626262626262625252525252524242424242424242421212100
            0000000000000000A8A8A8C0C0C0C3C3C3929292C9C9C9FFFFFF9B9B9BCACACA
            C3C3C3CBCBCB8383833333333333333131312B2B2B2B2B2B2B2B2B2B2B2B2B2B
            2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C2C2C31
            31313333333C3C3CB7B7B7C5C5C5C6C6C6B2B2B2A3A3A3FAFAFA9F9F9FD1D1D1
            C9C9C9C9C9C9CCCCCCD0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D0D0D0D0D0D0CACACAC9C9C9CBCBCBC6C6C6919191EBEBEBAEAEAED6D6D6
            D0D0D0D0D0D0D0D0D0D1D1D1D1D1D1D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D1D1D1D1D1D1D0D0D0D0D0D0D2D2D2D3D3D38C8C8CE3E3E3B2B2B2DEDEDE
            D7D7D7D7D7D7D6D6D6D6D6D6D7D7D7D8D8D8DADADADBDBDBDCDCDCDDDDDDDEDE
            DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDDDDDDDCDCDCDBDBDBD9D9D9D8
            D8D8D7D7D7D6D6D6D6D6D6D7D7D7D8D8D8DADADA8D8D8DE3E3E3B0B0B0E4E4E4
            DDDDDDDFDFDFE3E3E3E6E6E6E8E8E8EAEAEAEBEBEBEBEBEBEBEBEBEBEBEBEBEB
            EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAEA
            EAEAE8E8E8E6E6E6E2E2E2DFDFDFDFDFDFDDDDDD909090EAEAEAA0A0A0F0F0F0
            EEEEEEF1F1F1F3F2F3F2F2F2F2F2F2F2F2F2F1F1F1F1F1F1F1F1F1F1F1F1F1F1
            F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F2
            F2F2F2F2F2F2F2F2F2F2F2F0F0F0F0F0F0D9D9D99F9F9FFAFAFAA3A3A3F3F3F3
            FAFAFAFFF8FFFFF7FFFAF9FAF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
            F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
            F7F7F7F7F7F7F7F7F7F7F7F7F7F7FEFEFEC3C3C3C1C1C1FFFFFFC3C3C3DFDEDF
            FEFDFE78CE784DC34DE3EEE3FDFDFDFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB
            FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB
            FBFBFBFBFBFBFBFBFBFBFBFCFCFCFFFFFF9B9B9BF0F0F0FFFFFFF7F7F7ADACAD
            FFFFFF75CF7555CA55D1E7D1FFFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFFFFFFF9F9F9979797FFFFFFFFFFFFFFFFFFB1B1B1
            D7D7D7F6F7F6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFF6F6F6A7A7A7E2E2E2FFFFFFFFFFFFFFFFFFFFFFFF
            D9D9D9B6B5B6C1C0C1E2E2E2FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
            FEFDFDFDFCFCFCFBFBFBFAFAFAF9F9F9F8F8F8F7F7F7F6F6F6F5F5F5F4F4F4F3
            F3F3EDEDEDCFCFCFAAAAAAB2B2B2EAEAEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFF9F9F9B7B7B7E6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFAFAFAF5F5F5EFEFEFEBEBEBE6E6E6E0E0E0DCDCDCD7D7D7D0D0D0D0
            D0D08B8B8BD6D6D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFEEEEEED6D6D6EAEAEAD3D3D3D3D3D3D3D3D3D3D3D3D4D4
            D4D2D2D2CECECECACACAC6C6C6C1C1C1BEBEBEBABABAB5B5B5B2B2B2BABABAD8
            D8D8949494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFBBBBBB9494947E7E7E9898989292929090908E8E
            8E8C8C8C8989898787878585858282827F7F7F7C7C7C7B7B7B6B6B6B6F6F6FCE
            CECEC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D9D9D9D9D9D9FFFFFFFEFEFEFAFAFAF7F7
            F7F2F2F2EEEEEEEAEAEAE6E6E6E2E2E2DDDDDDD8D8D8D7D7D7C0C0C0A6A6A6E8
            E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3D1D1D1FFFFFFF9F9F9F4F4F4F0F0
            F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDD9D9D9D4D4D4D3D3D3BABABAB7B7B7FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD2D2D2FFFFFFFDFDFDF9F9F9F4F4
            F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDD9D9D9D8D8D8BCBCBCB3B3B3FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD0D0D0FFFFFFFFFFFFFDFDFDF9F9
            F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDDDDDDDBEBEBEB2B2B2FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACECECEFFFFFFFFFFFFFFFFFFFDFD
            FDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1E2E2E2BFBFBFB1B1B1FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACDCDCDFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E6E6E6C1C1C1B1B1B1FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACBCBCBFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFDFDFDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9EAEAEAC2C2C2B0B0B0FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACBCBCBFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFEFEFEFAFAFAF5F5F5F1F1F1EEEEEEF0F0F0C4C4C4AFAFAFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9C7C7C7FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAF5F5F5F2F2F2F4F4F4C7C7C7B2B2B2FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B4B4B4BEBEBEBCBCBCBCBCBCBCBC
            BCBCBCBCBCBCBCBCBCBCBCBCBCBBBBBBBABABAB9B9B9BABABAB3B3B3E0E0E0FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ParentFont = False
        end
        object DBG_Producao: TDBGrid
          Left = 5
          Top = 67
          Width = 839
          Height = 408
          Color = clMoneyGreen
          Ctl3D = True
          DataSource = Ds_Producao
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowSelect]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clNavy
          TitleFont.Height = -11
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          OnCellClick = DBG_ProducaoCellClick
          OnDblClick = DBG_ProducaoDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'EMP_NOME'
              Title.Caption = 'fornecedor'
              Width = 370
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PCF_DT_ENTREGA'
              Title.Caption = 'Prazo de entrega'
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PCF_QTDE'
              Title.Caption = 'Qtde'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PCF_VL_UNIT'
              Title.Caption = 'Vl. Unit'#225'rio'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PCF_QT_RETORNO'
              Title.Caption = 'Retorno'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PCF_VL_SUBTOTAL'
              Title.Caption = 'Vl. Subtotal'
              Width = 92
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o do Servi'#231'o'
              Visible = True
            end>
        end
        object E_Data_Prd_Ini: TDateTimePicker
          Left = 5
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 0
        end
        object E_Data_Prd_fim: TDateTimePicker
          Left = 98
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 1
        end
        object ChBx_Data_Producao: TCheckBox
          Left = 7
          Top = 6
          Width = 154
          Height = 13
          Caption = 'Per'#237'odo Data da Produ'#231#227'o'
          TabOrder = 6
          OnClick = ChBx_Data_ProducaoClick
        end
        object E_BuscaFornecedor: TMaskEdit
          Left = 191
          Top = 22
          Width = 471
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          Text = ''
        end
        object ChBx_Nome_For: TCheckBox
          Left = 192
          Top = 6
          Width = 127
          Height = 13
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = ChBx_Nome_ForClick
        end
        object ChBx_Fantasia_For: TCheckBox
          Left = 320
          Top = 6
          Width = 126
          Height = 13
          Caption = 'Apelido/Fantasia'
          TabOrder = 8
          OnClick = ChBx_Fantasia_ForClick
        end
        object E_Data_Prz_Ini: TDateTimePicker
          Left = 664
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 3
        end
        object E_Data_Prz_Fim: TDateTimePicker
          Left = 759
          Top = 22
          Width = 87
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 4
        end
        object ChBx_Data_Prazo: TCheckBox
          Left = 664
          Top = 6
          Width = 178
          Height = 13
          Caption = 'Per'#237'odo de Prazo de Produ'#231#227'o'
          TabOrder = 9
          OnClick = ChBx_Data_PrazoClick
        end
        object Chbx_ProdutoParaProducao: TCheckBox
          Left = 8
          Top = 48
          Width = 825
          Height = 17
          Caption = 'Produto n'#227'o selecionado'
          Enabled = False
          TabOrder = 5
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Registro de Retorno das Tarefas de Produ'#231#227'o'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 545
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          849
          545)
        object Sb_Ins_Retorno: TSpeedButton
          Left = 307
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Inserir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_Ins_RetornoClick
        end
        object Sb_Alt_Retorno: TSpeedButton
          Left = 396
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Alterar - F3'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_Alt_RetornoClick
        end
        object Sb_Exc_Retorno: TSpeedButton
          Left = 485
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Excluir - F4'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_Exc_RetornoClick
        end
        object Sb_Buscar_2: TSpeedButton
          Left = 665
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Buscar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_Buscar_2Click
        end
        object Sb_Sair_2: TSpeedButton
          Left = 755
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Sair - ESC'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Sair_2Click
        end
        object SB_Imp_Retorno: TSpeedButton
          Left = 575
          Top = 485
          Width = 89
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Imprimir - F11'
          Enabled = False
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFF9F9F9E3E3E3E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
            E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
            E1E1E1E1E1F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFBCBCBC9999999393939393939393939393939393939292
            929191919090908F8F8F8E8E8E8E8E8E8C8C8C8B8B8B8A8A8A8A8A8A89898989
            8989828282D3D3D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFD5D5D5F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFDFDFDF8F8F8F3F3F3F0F0F0EBEBEBE6E6E6E2E2E2DEDEDED9D9D9DE
            DEDEA0A0A0F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFE6E6E6C0C0C0ABABABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFBFBFBF6F6F6F3F3F3EEEEEEE9E9E9E5E5E5E1E1E1DCDCDCD8D8D8D5D5D5D4
            D4D47F7F7FC8C8C8E5E5E5FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9
            B5B5B58989898989899E9E9EA6A6A6F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFCFCFCF7F7F7F3F3F3EFEFEFEAEAEAE6E6E6E2E2E2DDDDDDDCDCDCC1
            C1C19F9F9F9393937D7D7D848484B6B6B6F4F4F4FFFFFFFFFFFFFFFFFF9D9D9D
            A1A1A1B9B9B9B4B4B4A9A9A9959595C5C5C5FFFFFFFDFDFDFDFDFDFDFDFDFDFD
            FDFDFDFDFCFCFCF8F8F8F4F4F4F0F0F0ECECECE6E6E6E3E3E3DFDFDFDEDEDEA1
            A1A1A0A0A0A7A7A7B1B1B1B3B3B3888888A3A3A3FFFFFFFFFFFFE5E5E5A1A1A1
            BFBFBFC1C1C1666666000000000000535353E0E0E0DADADAD9D9D9D9D9D9D9D9
            D9D9D9D9D9D9D9D9D9D9D6D6D6D2D2D2CECECECBCBCBC7C7C7C5C5C5BFBFBF32
            32320000000909099C9C9CBCBCBCC1C1C17E7E7EF2F2F2FFFFFFB2B2B2BCBCBC
            BDBDBDC7C7C76565650000000000000000002626262626262626262626262626
            2626262626262626262626262625252525252524242424242424242421212100
            0000000000000000A8A8A8C0C0C0C3C3C3929292C9C9C9FFFFFF9B9B9BCACACA
            C3C3C3CBCBCB8383833333333333333131312B2B2B2B2B2B2B2B2B2B2B2B2B2B
            2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C2C2C31
            31313333333C3C3CB7B7B7C5C5C5C6C6C6B2B2B2A3A3A3FAFAFA9F9F9FD1D1D1
            C9C9C9C9C9C9CCCCCCD0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D0D0D0D0D0D0CACACAC9C9C9CBCBCBC6C6C6919191EBEBEBAEAEAED6D6D6
            D0D0D0D0D0D0D0D0D0D1D1D1D1D1D1D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D1D1D1D1D1D1D0D0D0D0D0D0D2D2D2D3D3D38C8C8CE3E3E3B2B2B2DEDEDE
            D7D7D7D7D7D7D6D6D6D6D6D6D7D7D7D8D8D8DADADADBDBDBDCDCDCDDDDDDDEDE
            DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDDDDDDDCDCDCDBDBDBD9D9D9D8
            D8D8D7D7D7D6D6D6D6D6D6D7D7D7D8D8D8DADADA8D8D8DE3E3E3B0B0B0E4E4E4
            DDDDDDDFDFDFE3E3E3E6E6E6E8E8E8EAEAEAEBEBEBEBEBEBEBEBEBEBEBEBEBEB
            EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAEA
            EAEAE8E8E8E6E6E6E2E2E2DFDFDFDFDFDFDDDDDD909090EAEAEAA0A0A0F0F0F0
            EEEEEEF1F1F1F3F2F3F2F2F2F2F2F2F2F2F2F1F1F1F1F1F1F1F1F1F1F1F1F1F1
            F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F2
            F2F2F2F2F2F2F2F2F2F2F2F0F0F0F0F0F0D9D9D99F9F9FFAFAFAA3A3A3F3F3F3
            FAFAFAFFF8FFFFF7FFFAF9FAF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
            F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
            F7F7F7F7F7F7F7F7F7F7F7F7F7F7FEFEFEC3C3C3C1C1C1FFFFFFC3C3C3DFDEDF
            FEFDFE78CE784DC34DE3EEE3FDFDFDFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB
            FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB
            FBFBFBFBFBFBFBFBFBFBFBFCFCFCFFFFFF9B9B9BF0F0F0FFFFFFF7F7F7ADACAD
            FFFFFF75CF7555CA55D1E7D1FFFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFEFEFEFEFEFEFFFFFFF9F9F9979797FFFFFFFFFFFFFFFFFFB1B1B1
            D7D7D7F6F7F6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFF6F6F6A7A7A7E2E2E2FFFFFFFFFFFFFFFFFFFFFFFF
            D9D9D9B6B5B6C1C0C1E2E2E2FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
            FEFDFDFDFCFCFCFBFBFBFAFAFAF9F9F9F8F8F8F7F7F7F6F6F6F5F5F5F4F4F4F3
            F3F3EDEDEDCFCFCFAAAAAAB2B2B2EAEAEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFF9F9F9B7B7B7E6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFAFAFAF5F5F5EFEFEFEBEBEBE6E6E6E0E0E0DCDCDCD7D7D7D0D0D0D0
            D0D08B8B8BD6D6D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFEEEEEED6D6D6EAEAEAD3D3D3D3D3D3D3D3D3D3D3D3D4D4
            D4D2D2D2CECECECACACAC6C6C6C1C1C1BEBEBEBABABAB5B5B5B2B2B2BABABAD8
            D8D8949494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFBBBBBB9494947E7E7E9898989292929090908E8E
            8E8C8C8C8989898787878585858282827F7F7F7C7C7C7B7B7B6B6B6B6F6F6FCE
            CECEC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D9D9D9D9D9D9FFFFFFFEFEFEFAFAFAF7F7
            F7F2F2F2EEEEEEEAEAEAE6E6E6E2E2E2DDDDDDD8D8D8D7D7D7C0C0C0A6A6A6E8
            E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3D1D1D1FFFFFFF9F9F9F4F4F4F0F0
            F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDD9D9D9D4D4D4D3D3D3BABABAB7B7B7FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD2D2D2FFFFFFFDFDFDF9F9F9F4F4
            F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDD9D9D9D8D8D8BCBCBCB3B3B3FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD0D0D0FFFFFFFFFFFFFDFDFDF9F9
            F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1DDDDDDDDDDDDBEBEBEB2B2B2FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACECECEFFFFFFFFFFFFFFFFFFFDFD
            FDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E1E1E1E2E2E2BFBFBFB1B1B1FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACDCDCDFFFFFFFFFFFFFFFFFFFFFF
            FFFDFDFDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9E5E5E5E6E6E6C1C1C1B1B1B1FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACBCBCBFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFDFDFDF9F9F9F4F4F4F0F0F0EDEDEDE9E9E9EAEAEAC2C2C2B0B0B0FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEACBCBCBFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFEFEFEFAFAFAF5F5F5F1F1F1EEEEEEF0F0F0C4C4C4AFAFAFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9C7C7C7FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAF5F5F5F2F2F2F4F4F4C7C7C7B2B2B2FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B4B4B4BEBEBEBCBCBCBCBCBCBCBC
            BCBCBCBCBCBCBCBCBCBCBCBCBCBBBBBBBABABAB9B9B9BABABAB3B3B3E0E0E0FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ParentFont = False
        end
        object DBG_Retorno: TDBGrid
          Left = 5
          Top = 67
          Width = 839
          Height = 408
          Color = clMoneyGreen
          Ctl3D = True
          DataSource = Ds_Retorno_Prd
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Lucida Console'
          Font.Style = []
          Options = [dgTitles, dgColLines, dgRowSelect]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clNavy
          TitleFont.Height = -11
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'PCF_ROMANEIO'
              Title.Caption = 'Romaneio'
              Width = 77
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Servi'#231'os'
              Width = 370
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PCF_DT_ENTREGA'
              Title.Caption = 'Prazo de entrega'
              Width = 108
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RPC_QTDE'
              Title.Caption = 'Qtde'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RPC_DT_RETORNO'
              Title.Caption = 'Data Retorno'
              Width = 99
              Visible = True
            end>
        end
        object E_Data_Env_Ini: TDateTimePicker
          Left = 5
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 0
        end
        object E_Data_Env_Fim: TDateTimePicker
          Left = 98
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 1
        end
        object ChBx_Data_Envio: TCheckBox
          Left = 7
          Top = 6
          Width = 154
          Height = 13
          Caption = 'Per'#237'odo de Entrega'
          TabOrder = 6
          OnClick = ChBx_Data_EnvioClick
        end
        object E_BuscaFornecedor_2: TMaskEdit
          Left = 191
          Top = 22
          Width = 471
          Height = 21
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          Text = ''
        end
        object ChBx_Nome_For_2: TCheckBox
          Left = 192
          Top = 6
          Width = 127
          Height = 13
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = ChBx_Nome_For_2Click
        end
        object ChBx_Fantasia_For_2: TCheckBox
          Left = 320
          Top = 6
          Width = 126
          Height = 13
          Caption = 'Apelido/Fantasia'
          TabOrder = 8
          OnClick = ChBx_Fantasia_ForClick
        end
        object E_Data_Ret_Ini: TDateTimePicker
          Left = 664
          Top = 22
          Width = 92
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 3
        end
        object E_Data_Ret_Fim: TDateTimePicker
          Left = 759
          Top = 22
          Width = 87
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          TabOrder = 4
        end
        object ChBx_Data_Retorno: TCheckBox
          Left = 664
          Top = 6
          Width = 178
          Height = 13
          Caption = 'Per'#237'odo de Retorno'
          TabOrder = 9
          OnClick = ChBx_Data_RetornoClick
        end
        object Chbx_FornecedorParaRetorno: TCheckBox
          Left = 8
          Top = 48
          Width = 825
          Height = 17
          Caption = 'Fornecedor n'#227'o selecionado'
          Enabled = False
          TabOrder = 5
        end
      end
    end
  end
  object Ds_ItensPrd: TDataSource
    DataSet = Qr_ItensPrd
    Left = 208
    Top = 160
  end
  object Ds_Producao: TDataSource
    DataSet = Qr_Producao
    Left = 240
    Top = 160
  end
  object Ds_Retorno_Prd: TDataSource
    DataSet = Qr_Retorno_Prd
    Left = 280
    Top = 160
  end
  object Qr_ItensPrd: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      'PED_NUMERO, '
      'PRO_DESCRICAO, '
      'ITF_QTDE, '
      'GRT_TAMANHO, '
      'GRT_QTDE,'
      'EMP_NOME, '
      'EMP_FANTASIA,'
      'PED_CODIGO, '
      'GRT_CODIGO, '
      'PED_DT_ENTREGA'
      'FROM TB_PEDIDO tb_pedido'
      '  INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      '  ON(tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO)'
      '  INNER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_GRADETAMANHO tb_gradetamanho'
      '   ON (tb_gradetamanho.GRT_CODITF = tb_itens_nfl.ITF_CODIGO)'
      '  INNER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO =  tb_pedido.PED_CODEMP)')
    Left = 208
    Top = 128
    object Qr_ItensPrdPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_ItensPrdPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensPrdITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensPrdGRT_TAMANHO: TStringField
      FieldName = 'GRT_TAMANHO'
      Origin = '"TB_GRADETAMANHO"."GRT_TAMANHO"'
      Size = 5
    end
    object Qr_ItensPrdGRT_QTDE: TBCDField
      FieldName = 'GRT_QTDE'
      Origin = '"TB_GRADETAMANHO"."GRT_QTDE"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensPrdEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_ItensPrdEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object Qr_ItensPrdPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensPrdGRT_CODIGO: TIntegerField
      FieldName = 'GRT_CODIGO'
      Origin = '"TB_GRADETAMANHO"."GRT_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensPrdPED_DT_ENTREGA: TDateField
      FieldName = 'PED_DT_ENTREGA'
      Origin = '"TB_PEDIDO"."PED_DT_ENTREGA"'
    end
  end
  object Qr_Producao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ProducaoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  PCF_CODIGO ,'
      '  PCF_ROMANEIO,'
      '  PCF_DATA,'
      '  PCF_CODFOR,'
      '  tb_fornecedor.EMP_NOME,'
      '  PCF_CODSRV,'
      '  tb_servico.PRO_DESCRICAO,'
      '  PCF_VL_UNIT,'
      '  PCF_QTDE,'
      '  CAST((PCF_VL_UNIT *  PCF_QTDE) AS NUMERIC(18, 9)) PCF_VL_SUBTOTAL,'
      '  PCF_DT_ENTREGA '
      'FROM TB_PROD_CONFECCAO tb_producao'
      '   INNER JOIN TB_EMPRESA tb_fornecedor'
      '   ON (tb_fornecedor.EMP_CODIGO =  tb_producao.PCF_CODFOR)'
      '   INNER JOIN TB_PRODUTO tb_servico'
      '   ON (tb_servico.PRO_CODIGO = tb_producao.PCF_CODSRV)')
    Left = 239
    Top = 128
    object Qr_ProducaoPCF_CODIGO: TIntegerField
      FieldName = 'PCF_CODIGO'
      Origin = '"TB_PROD_CONFECCAO"."PCF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ProducaoPCF_ROMANEIO: TStringField
      FieldName = 'PCF_ROMANEIO'
      Origin = '"TB_PROD_CONFECCAO"."PCF_ROMANEIO"'
    end
    object Qr_ProducaoPCF_DATA: TDateField
      FieldName = 'PCF_DATA'
      Origin = '"TB_PROD_CONFECCAO"."PCF_DATA"'
    end
    object Qr_ProducaoPCF_CODFOR: TIntegerField
      FieldName = 'PCF_CODFOR'
      Origin = '"TB_PROD_CONFECCAO"."PCF_CODFOR"'
    end
    object Qr_ProducaoEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_ProducaoPCF_CODSRV: TIntegerField
      FieldName = 'PCF_CODSRV'
      Origin = '"TB_PROD_CONFECCAO"."PCF_CODSRV"'
    end
    object Qr_ProducaoPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ProducaoPCF_VL_UNIT: TFMTBCDField
      FieldName = 'PCF_VL_UNIT'
      Origin = '"TB_PROD_CONFECCAO"."PCF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ProducaoPCF_QTDE: TBCDField
      FieldName = 'PCF_QTDE'
      Origin = '"TB_PROD_CONFECCAO"."PCF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ProducaoPCF_VL_SUBTOTAL: TFMTBCDField
      FieldName = 'PCF_VL_SUBTOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 9
    end
    object Qr_ProducaoPCF_DT_ENTREGA: TDateField
      FieldName = 'PCF_DT_ENTREGA'
      Origin = '"TB_PROD_CONFECCAO"."PCF_DT_ENTREGA"'
    end
  end
  object Qr_Retorno_Prd: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_Retorno_PrdAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  RPC_CODIGO,'
      '  PCF_CODIGO,'
      '  PCF_ROMANEIO,'
      '  PRO_DESCRICAO,'
      '  PCF_DT_ENTREGA,'
      '  RPC_QTDE,'
      '  RPC_DT_RETORNO'
      'FROM TB_PROD_CONFECCAO tb_producao'
      '   INNER JOIN TB_RET_PROD_CONFECCAO tb_retorno'
      '   ON (tb_retorno.RPC_CODPCF = tb_producao.PCF_CODIGO)'
      ''
      '   INNER JOIN TB_PRODUTO tb_servico'
      '   ON (tb_servico.PRO_CODIGO = tb_producao.PCF_CODSRV)'
      ''
      '   INNER JOIN TB_EMPRESA tb_fornecedor'
      '   ON (tb_fornecedor.EMP_CODIGO = tb_producao.PCF_CODFOR)'
      'WHERE PCF_CODIGO IS NOT NULL'
      '')
    Left = 280
    Top = 128
    object Qr_Retorno_PrdRPC_CODIGO: TIntegerField
      FieldName = 'RPC_CODIGO'
      Origin = 'TB_RET_PROD_CONFECCAO.RPC_CODIGO'
      Required = True
    end
    object Qr_Retorno_PrdPCF_CODIGO: TIntegerField
      FieldName = 'PCF_CODIGO'
      Origin = 'TB_PROD_CONFECCAO.PCF_CODIGO'
      Required = True
    end
    object Qr_Retorno_PrdPCF_ROMANEIO: TStringField
      FieldName = 'PCF_ROMANEIO'
      Origin = 'TB_PROD_CONFECCAO.PCF_ROMANEIO'
    end
    object Qr_Retorno_PrdPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_Retorno_PrdPCF_DT_ENTREGA: TDateField
      FieldName = 'PCF_DT_ENTREGA'
      Origin = 'TB_PROD_CONFECCAO.PCF_DT_ENTREGA'
    end
    object Qr_Retorno_PrdRPC_QTDE: TBCDField
      FieldName = 'RPC_QTDE'
      Origin = 'TB_RET_PROD_CONFECCAO.RPC_QTDE'
      Precision = 18
      Size = 3
    end
    object Qr_Retorno_PrdRPC_DT_RETORNO: TDateField
      FieldName = 'RPC_DT_RETORNO'
      Origin = 'TB_RET_PROD_CONFECCAO.RPC_DT_RETORNO'
    end
  end
  object Qr_Retorno: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CAST(sum(RPC_QTDE) AS NUMERIC(18, 2)) RPC_TOTAL'
      'FROM TB_PROD_CONFECCAO tb_producao'
      '   INNER JOIN TB_RET_PROD_CONFECCAO tb_retorno'
      '   ON (tb_retorno.RPC_CODPCF = tb_producao.PCF_CODIGO)'
      'WHERE RPC_CODPCF=:RPC_CODPCF')
    Left = 316
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RPC_CODPCF'
        ParamType = ptUnknown
      end>
    object Qr_RetornoRPC_TOTAL: TBCDField
      FieldName = 'RPC_TOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
  end
end
