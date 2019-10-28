unit UFrmPrincipal;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.ActnList,
  Vcl.StdCtrls,
  System.Actions;

type
  TFrmPrincipal = class(TForm)
    mmPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    Estados1: TMenuItem;
    Municpios1: TMenuItem;
    ActionList1: TActionList;
    actCadastroEstados: TAction;
    actCadastroMunicipios: TAction;
    actCadastroPais: TAction;
    N1CadastrodePases1: TMenuItem;
    Exemplos1: TMenuItem;
    Exemplos2: TMenuItem;
    N1CadastrodeMarcas1: TMenuItem;
    actCadastroMarca: TAction;

    procedure actCadastroPaisExecute(Sender: TObject);
    procedure actCadastroEstadosExecute(Sender: TObject);
    procedure actCadastroMunicipiosExecute(Sender: TObject);
    procedure actCadastroMarcaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  Spring,
  MVCDemo.Registers.RegisterTypesImpl,
  Framework.MVC.Controller.BaseController,
  MVCDemo.Models.CRM.EstadoModelImpl,
  MVCDemo.Views.CRM.EstadoView,
  MVCDemo.Controllers.CRM.EstadoController,
  MVCDemo.Controllers.CRM.PaisController,
  MVCDemo.Controllers.CRM.MunicipioController,
  MVCDemo.Controllers.Comercial.MarcaController;

{$R *.dfm}




procedure TFrmPrincipal.actCadastroPaisExecute(Sender: TObject);
begin
  Container.Resolve<IPaisController>.New;
end;



procedure TFrmPrincipal.actCadastroEstadosExecute(Sender: TObject);
begin
  Container.Resolve < IEstadoController < TEstadoModelImpl, TFrmEstadoView >>.New;
end;



procedure TFrmPrincipal.actCadastroMarcaExecute(Sender: TObject);
begin
  Container.Resolve<IMarcaController>.New;
end;



procedure TFrmPrincipal.actCadastroMunicipiosExecute(Sender: TObject);
begin
  Container.Resolve<IMunicipioController>.New;
end;

end.
