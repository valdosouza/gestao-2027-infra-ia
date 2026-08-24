object TasNotificationItem: TTasNotificationItem
  Left = 0
  Top = 0
  Width = 270
  Height = 107
  TabOrder = 0
  object Panel3: TCustomCaptionPanel
    Left = 0
    Top = 0
    Width = 269
    Height = 105
    BorderColor = clMoneyGreen
    DesignSize = (
      269
      105)
    object Lb_Message: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 18
      Width = 249
      Height = 45
      Margins.Left = 10
      Margins.Right = 10
      Align = alTop
      AutoSize = False
      WordWrap = True
      ExplicitLeft = 4
      ExplicitTop = -1
      ExplicitWidth = 337
    end
    object Sb_ChangeStatus: TSpeedButton
      Left = 128
      Top = 69
      Width = 137
      Height = 32
      Anchors = [akRight, akBottom]
      Caption = 'Marcar como N'#194'O lido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
    end
    object Lb_Tittle: TLabel
      AlignWithMargins = True
      Left = 15
      Top = 1
      Width = 239
      Height = 13
      Margins.Left = 15
      Margins.Top = 1
      Margins.Right = 15
      Margins.Bottom = 1
      ParentCustomHint = False
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Estoque'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Transparent = False
      WordWrap = True
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitWidth = 337
    end
  end
end
