inherited FrmMarcaView: TFrmMarcaView
  Caption = 'Cadastro de Marcas'
  ExplicitWidth = 320
  ExplicitHeight = 313
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    object EdtCodigo: TLabeledEdit
      Left = 26
      Top = 25
      Width = 57
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo:'
      MaxLength = 4
      TabOrder = 0
      Text = ' '
    end
    object EdtDescricao: TLabeledEdit
      Left = 26
      Top = 76
      Width = 264
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o:'
      MaxLength = 30
      TabOrder = 1
    end
    object EdtDescrReduz: TLabeledEdit
      Left = 26
      Top = 123
      Width = 104
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 97
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o Reduzida:'
      MaxLength = 10
      TabOrder = 2
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
end
