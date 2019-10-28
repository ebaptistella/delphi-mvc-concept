unit MVCDemo.Controllers.CRM.PaisController;

interface

uses
  Framework.MVC.Controller.ORMCRUDController,
  MVCDemo.Models.CRM.PaisModelImpl,
  MVCDemo.Views.CRM.PaisView,
  Vcl.ExtCtrls;

type
  IPaisController = interface(IMVCORMCRUDController<TPaisModelImpl, TFrmPaisView>)
    ['{B1D835AB-4E4B-4150-8F23-5750E4A36D3A}']
    procedure FndPaisConsult(const AEdtPais: TLabeledEdit);
  end;

implementation

end.
