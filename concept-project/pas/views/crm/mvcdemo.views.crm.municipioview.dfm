inherited FrmMunicipioView: TFrmMunicipioView
  Caption = 'Cadastro de Munic'#237'pios'
  ClientHeight = 385
  ClientWidth = 749
  ExplicitWidth = 755
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    Width = 743
    Height = 338
    ExplicitWidth = 743
    ExplicitHeight = 338
    object EdtCodigo: TLabeledEdit
      Left = 28
      Top = 25
      Width = 57
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo:'
      MaxLength = 6
      TabOrder = 0
      Text = ' '
    end
    object EdtDescricao: TLabeledEdit
      Left = 28
      Top = 76
      Width = 270
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o:'
      MaxLength = 30
      TabOrder = 1
      OnExit = EdtDescricaoExit
    end
    object EdtDescrReduz: TLabeledEdit
      Left = 28
      Top = 133
      Width = 110
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 97
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o Reduzida:'
      MaxLength = 10
      TabOrder = 2
    end
    object EdtCodigoEstado: TLabeledEdit
      Left = 28
      Top = 183
      Width = 80
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'Estado:'
      MaxLength = 4
      TabOrder = 3
    end
    object Button1: TButton
      Left = 95
      Top = 25
      Width = 75
      Height = 21
      Caption = 'Consultar'
      TabOrder = 4
      OnClick = Button1Click
    end
  end
  inherited PnlBotao: TPanel
    Top = 344
    Width = 749
    ExplicitTop = 344
    ExplicitWidth = 749
    inherited BtnFechar: TBitBtn
      Left = 666
      ExplicitLeft = 666
    end
    inherited BtnConfigurar: TBitBtn
      Left = 580
      ExplicitLeft = 580
    end
    inherited BtnSalvar: TBitBtn
      Left = 226
      ExplicitLeft = 226
    end
    inherited BtnAgendar: TBitBtn
      Left = 312
      ExplicitLeft = 312
    end
    inherited BtnRelatorio: TBitBtn
      Left = 484
      ExplicitLeft = 484
    end
    inherited BtnExcluir: TBitBtn
      Left = 398
      ExplicitLeft = 398
    end
  end
end
