unit Framework.MVC.Controller.ORMCRUDController;

interface

uses
  Vcl.Forms,
  Framework.MVC.Controller.CRUDController,
  Framework.MVC.Model.BaseModel,
  Framework.Libraries.DAO.GenericDAO;

type
  IMVCORMCRUDController<TModel: IMVCBaseModel; TView: TForm> = interface(IMVCCRUDController<TModel, TView>)
    ['{266C6132-0C03-43B8-A0B3-473D3692F551}']
    function GetDAO: IGenericDAO<TModel>;

    property DAO: IGenericDAO<TModel> read GetDAO;
  end;

implementation

end.
