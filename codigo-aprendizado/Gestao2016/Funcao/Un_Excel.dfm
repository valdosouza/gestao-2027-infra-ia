object Fr_Excel: TFr_Excel
  Left = 361
  Top = 291
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Exporta'#231#227'o para o Excel'
  ClientHeight = 148
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    327
    148)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 3
    Top = 2
    Width = 152
    Height = 13
    Caption = 'Local de Destino da Exporta'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Gg_Progresso: TGauge
    Left = 3
    Top = 55
    Width = 320
    Height = 25
    Progress = 0
  end
  object Lb_Processo: TLabel
    Left = 3
    Top = 40
    Width = 74
    Height = 13
    Caption = 'Processando....'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object SB_Sair_0: TSpeedButton
    Left = 241
    Top = 89
    Width = 81
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
    OnClick = SB_Sair_0Click
  end
  object Sb_Abrir: TSpeedButton
    Left = 160
    Top = 89
    Width = 81
    Height = 54
    Anchors = [akRight, akBottom]
    Caption = 'Abrir - F2'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Layout = blGlyphTop
    ParentFont = False
    OnClick = Sb_AbrirClick
  end
  object E_NomeArquivo: TEdit
    Left = 3
    Top = 18
    Width = 320
    Height = 21
    TabStop = False
    DragMode = dmAutomatic
    TabOrder = 0
  end
end
