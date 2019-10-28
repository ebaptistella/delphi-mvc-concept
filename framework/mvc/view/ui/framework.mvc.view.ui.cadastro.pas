unit Framework.MVC.View.UI.Cadastro;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Buttons,
  Classes,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Framework.MVC.View.UI.Consulta;

type

  TFormCadastro = class(TFormConsulta)
    BtnSalvar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnRelatorio: TBitBtn;
    BtnEfetivar: TBitBtn;
    BtnEditar: TBitBtn;

    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  end;

implementation


{$R *.dfm}

{ TFormCadastro }



procedure TFormCadastro.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  // DoUpdateModel;
  // (Controller as ICRUDController).Delete;
end;



procedure TFormCadastro.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  // DoUpdateModel;
  // (Controller as ICRUDController).Save;
end;

end.
