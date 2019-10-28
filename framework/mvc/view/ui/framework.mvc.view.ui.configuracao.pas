unit Framework.MVC.View.UI.Configuracao;

interface

uses
  Vcl.Buttons,
  System.Classes,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Framework.MVC.View.UI.Consulta;

type
  TFormConfiguracao = class(TFormConsulta)
    BtnOk: TBitBtn;
    BtnPadrao: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnPadraoClick(Sender: TObject);
  end;

implementation


{$R *.dfm}




procedure TFormConfiguracao.BtnOkClick(Sender: TObject);
begin
  // oControlador.Executar;
end;



procedure TFormConfiguracao.BtnPadraoClick(Sender: TObject);
begin
  // oControlador.UtilizarPadrao;
end;

end.
