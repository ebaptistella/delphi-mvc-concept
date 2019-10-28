unit Framework.MVC.View.UI.Relatorio;

interface

uses
  SysUtils,
  Vcl.Forms,
  Vcl.Buttons,
  Classes,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Framework.MVC.View.UI.Consulta;

type
  TFormRelatorio = class(TFormConsulta)
    BtnOk: TBitBtn;
    BtnAgendar: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnAgendarClick(Sender: TObject);
  end;

implementation


{$R *.dfm}




procedure TFormRelatorio.BtnAgendarClick(Sender: TObject);
begin
  // oControlador.Agendar;
end;



procedure TFormRelatorio.BtnOkClick(Sender: TObject);
begin
  // oControlador.Executar;
end;

end.
