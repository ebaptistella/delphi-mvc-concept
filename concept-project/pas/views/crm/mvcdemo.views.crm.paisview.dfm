inherited FrmPaisView: TFrmPaisView
  Caption = 'Cadastro de Pa'#237'ses'
  FormStyle = fsMDIChild
  Position = poOwnerFormCenter
  Visible = True
  ExplicitWidth = 320
  ExplicitHeight = 313
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    object EdtDescricao: TLabeledEdit
      Left = 29
      Top = 76
      Width = 300
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o:'
      MaxLength = 40
      TabOrder = 1
    end
    object EdtCodigo: TLabeledEdit
      Left = 29
      Top = 25
      Width = 65
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo:'
      MaxLength = 6
      TabOrder = 0
      Text = ' '
    end
    object Button1: TButton
      Left = 100
      Top = 25
      Width = 75
      Height = 21
      Caption = 'Consultar'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  inherited PnlBotao: TPanel
    inherited BtnRelatorio: TBitBtn
      Visible = True
    end
  end
end
