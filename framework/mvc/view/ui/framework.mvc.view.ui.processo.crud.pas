unit Framework.MVC.View.UI.Processo.CRUD;

interface

uses
  SysUtils,
  Vcl.Forms,

  Vcl.Buttons,
  Classes,
  Vcl.Controls,

  Framework.MVC.View.UI.Consulta, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormProcessoCRUD = class(TFormConsulta)
    BtnSalvar: TBitBtn;
    BtnAgendar: TBitBtn;
    BtnRelatorio: TBitBtn;
    BtnExcluir: TBitBtn;

    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnAgendarClick(Sender: TObject);
    procedure BtnRelatorioClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  end;

implementation

uses
  System.Rtti,
  Winapi.Windows,
  Vcl.Dialogs,
  System.UITypes;

{$R *.dfm}




procedure TFormProcessoCRUD.BtnAgendarClick(Sender: TObject);
begin
  NotificationService.NotifyObservers(self.ClassType, 'Schedule');
end;



procedure TFormProcessoCRUD.BtnExcluirClick(Sender: TObject);
begin
  SysUtils.Beep;
  if (messagedlg('Excluir registro?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes) then
  begin
    NotificationService.NotifyObservers(self.ClassType, 'Delete');
    BtnExcluir.Enabled := False;
  end;
end;



procedure TFormProcessoCRUD.BtnSalvarClick(Sender: TObject);
begin
  if (DoControlCheck(nil)) then
  begin
    NotificationService.NotifyObservers(self.ClassType, 'Save');
    BtnExcluir.Enabled := False;
  end;
end;



procedure TFormProcessoCRUD.BtnRelatorioClick(Sender: TObject);
begin
  NotificationService.NotifyObservers(self.ClassType, 'ShowReport');
end;

end.
