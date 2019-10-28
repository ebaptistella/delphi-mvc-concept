unit MVCDemo.Controllers.Comercial.MarcaController;

interface

uses
  Framework.MVC.Controller.ORMCRUDController,
  MVCDemo.Models.Comercial.MarcaModelImpl,
  MVCDemo.Views.Comercial.MarcaView,
  Vcl.ExtCtrls;

type
  IMarcaController = interface(IMVCORMCRUDController<TMarcaModelImpl, TFrmMarcaView>)
    ['{73C9D5F8-56D7-4B3C-8406-C0383C001C81}']

    procedure FndMarcaConsult(const AEdtMarca: TLabeledEdit);
  end;

implementation

end.
