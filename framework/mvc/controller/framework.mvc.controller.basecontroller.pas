unit Framework.MVC.Controller.BaseController;

interface

uses
  Framework.MVC.Model.BaseModel,
  Framework.Libraries.Security.SecurityController;

type
  IMVCBaseController<TModel: IMVCBaseModel> = interface(IInvokable)
    ['{333160CF-0943-4B57-8992-C3921473B1E5}']
    function GetModel: TModel;
    function GetSecurityController: ISecurityController;

    property Model: TModel read GetModel;
    property SecurityController: ISecurityController read GetSecurityController;
  end;

implementation

end.
