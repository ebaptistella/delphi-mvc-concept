unit Framework.MVC.View.UI.Processo;

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
  TFormProcesso = class(TFormConsulta)
    BtnOk: TBitBtn;
    BtnAgendar: TBitBtn;
    BtnRelatorio: TBitBtn;
    BtnEfetivar: TBitBtn;
    BtnImportar: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnAgendarClick(Sender: TObject);
    procedure BtnRelatorioClick(Sender: TObject);
    procedure BtnEfetivarClick(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
  end;

implementation

{$R *.dfm}




procedure TFormProcesso.BtnAgendarClick(Sender: TObject);
begin
  // oControlador.Agendar;
end;



procedure TFormProcesso.BtnEfetivarClick(Sender: TObject);
begin
  // oControlador.Efetivar;
end;



procedure TFormProcesso.BtnImportarClick(Sender: TObject);
begin
  // oControlador.Importar;
end;



procedure TFormProcesso.BtnOkClick(Sender: TObject);
begin
  // oControlador.Executar;
end;



procedure TFormProcesso.BtnRelatorioClick(Sender: TObject);
begin
  // oControlador.ImprimirRelatorio;
end;

end.
