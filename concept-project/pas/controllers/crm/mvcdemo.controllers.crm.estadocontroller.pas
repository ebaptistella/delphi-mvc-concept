unit MVCDemo.Controllers.CRM.EstadoController;

interface

uses
  Vcl.Forms,
  Framework.MVC.Model.BaseModel,
  Framework.MVC.Controller.ORMCRUDController,
  Vcl.ExtCtrls;

type
  IEstadoController<TModel: IMVCBaseModel; TView: TForm> = interface(IMVCORMCRUDController<TModel, TView>)
    ['{1EA8C8A2-F590-4AE7-BB03-8DE7CEDF6A91}']

    procedure FndEstadoConsult(const AEdtEstado: TLabeledEdit);
    procedure FndPaisConsult(const AEdtPais: TLabeledEdit);
  end;

implementation

end.
