object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = '...:: Concept ::...'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmPrincipal
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object mmPrincipal: TMainMenu
    Left = 280
    Top = 88
    object Cadastros1: TMenuItem
      Caption = '&Exemplos'
      object Exemplos1: TMenuItem
        Caption = 'Exemplos &1'
        object N1CadastrodePases1: TMenuItem
          Action = actCadastroPais
        end
        object Estados1: TMenuItem
          Action = actCadastroEstados
        end
        object Municpios1: TMenuItem
          Action = actCadastroMunicipios
        end
      end
      object Exemplos2: TMenuItem
        Caption = 'Exemplos &2'
        object N1CadastrodeMarcas1: TMenuItem
          Action = actCadastroMarca
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 248
    Top = 168
    object actCadastroPais: TAction
      Caption = '&1 - Cadastro de Pa'#237'ses'
      OnExecute = actCadastroPaisExecute
    end
    object actCadastroEstados: TAction
      Caption = '&2 - Cadastro de Estados'
      OnExecute = actCadastroEstadosExecute
    end
    object actCadastroMunicipios: TAction
      Caption = '&3 - Cadastro de Munic'#237'pios'
      OnExecute = actCadastroMunicipiosExecute
    end
    object actCadastroMarca: TAction
      Caption = '&4 - Cadastro de Marcas'
      OnExecute = actCadastroMarcaExecute
    end
  end
end
