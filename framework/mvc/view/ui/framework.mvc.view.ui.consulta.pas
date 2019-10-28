unit Framework.MVC.View.UI.Consulta;

interface

uses
  SysUtils,
  Vcl.Forms,

  Vcl.Buttons,
  Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Framework.MVC.View.UI.BaseForm, Vcl.StdCtrls;

type
  TFormConsulta = class(TBaseFormView)
    PnlArea: TPanel;
    PnlBotao: TPanel;
    BtnFechar: TBitBtn;
    BtnConfigurar: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
  end;

implementation

{$R *.dfm}




procedure TFormConsulta.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
