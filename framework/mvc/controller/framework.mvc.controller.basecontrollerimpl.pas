unit Framework.MVC.Controller.BaseControllerImpl;

interface

uses
  System.SysUtils,
  Framework.Libraries.InterfacedObjectLoggableImpl,
  Framework.Libraries.Security.SecurityController,
  Framework.MVC.Controller.BaseController,
  Framework.MVC.Controller.Initializable,
  Framework.MVC.Model.BaseModel,
  Spring,
  Spring.Container.Common;

type
  TMVCBaseControllerImpl<TModel: IMVCBaseModel> = class(TInterfacedObjectLoggableImpl, IMVCInitializable, IMVCBaseController<TModel>)
  private
    function GetModel: TModel;
    function GetSecurityController: ISecurityController;
  protected
    procedure Initialize; virtual; abstract;
  public
    FModel: TModel;
    FSecurityController: ISecurityController;

    constructor Create(const AModel: TModel; const ASecurityController: ISecurityController); reintroduce; overload;
    procedure AfterConstruction; override;

    property Model: TModel read GetModel;
    property SecurityController: ISecurityController read GetSecurityController;
  end;

implementation


{ TBaseControllerImpl<TModel> }



constructor TMVCBaseControllerImpl<TModel>.Create(const AModel: TModel; const ASecurityController: ISecurityController);
begin
  inherited Create;

  FModel              := AModel;
  FSecurityController := ASecurityController;
end;



procedure TMVCBaseControllerImpl<TModel>.AfterConstruction;
begin
  inherited;

  Initialize();
end;



function TMVCBaseControllerImpl<TModel>.GetModel: TModel;
begin
  Result := FModel;
end;



function TMVCBaseControllerImpl<TModel>.GetSecurityController: ISecurityController;
begin
  Result := FSecurityController;
end;

end.
