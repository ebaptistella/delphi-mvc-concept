inherited FormConsulta: TFormConsulta
  Caption = 'FormConsulta'
  ClientHeight = 274
  ClientWidth = 460
  OldCreateOrder = True
  ExplicitWidth = 476
  ExplicitHeight = 312
  PixelsPerInch = 96
  TextHeight = 13
  object PnlArea: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 454
    Height = 227
    Align = alClient
    BevelKind = bkTile
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 0
  end
  object PnlBotao: TPanel
    Left = 0
    Top = 233
    Width = 460
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnFechar: TBitBtn
      AlignWithMargins = True
      Left = 377
      Top = 8
      Width = 80
      Height = 25
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
      Caption = '&Fechar'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BtnFecharClick
    end
    object BtnConfigurar: TBitBtn
      AlignWithMargins = True
      Left = 291
      Top = 8
      Width = 80
      Height = 25
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
      Caption = '&Configurar'
      Enabled = False
      NumGlyphs = 2
      TabOrder = 0
      Visible = False
    end
  end
end
