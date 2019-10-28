inherited FrmEstadoView: TFrmEstadoView
  Caption = 'Cadastro de Estados'
  FormStyle = fsMDIChild
  Visible = True
  ExplicitWidth = 320
  ExplicitHeight = 313
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    object EdtCodigo: TLabeledEdit
      Left = 29
      Top = 25
      Width = 57
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo:'
      MaxLength = 2
      TabOrder = 0
    end
    object EdtDescricao: TLabeledEdit
      Left = 29
      Top = 80
      Width = 313
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o:'
      MaxLength = 30
      TabOrder = 1
    end
    object EdtCodigoPais: TLabeledEdit
      Left = 29
      Top = 136
      Width = 161
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'Pa'#237's:'
      TabOrder = 2
      Text = ' '
    end
    object Button1: TButton
      Left = 95
      Top = 25
      Width = 75
      Height = 21
      Caption = 'Consultar'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  inherited PnlBotao: TPanel
    inherited BtnRelatorio: TBitBtn
      Visible = True
    end
  end
end
