unit MVCDemo.Controllers.CRM.MunicipioController;

interface

uses
  Framework.MVC.Controller.ORMCRUDController,
  MVCDemo.Models.CRM.MunicipioModelImpl,
  MVCDemo.Views.CRM.MunicipioView,
  Vcl.ExtCtrls;

type
  IMunicipioController = interface(IMVCORMCRUDController<TMunicipioModelImpl, TFrmMunicipioView>)
    ['{B1D835AB-4E4B-4150-8F23-5750E4A36D3A}']
    procedure FndMunicipioConsult(const AEdtMunicipio: TLabeledEdit);
    procedure FndEstadoConsult(const AEdtEstado: TLabeledEdit);
  end;

implementation

end.
