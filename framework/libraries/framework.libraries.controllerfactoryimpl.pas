unit Framework.Libraries.ControllerFactoryImpl;

interface

uses
  Vcl.forms,
  System.Generics.Collections,
  Framework.Libraries.ControllerFactory,
  Framework.MVC.Controller.BaseController,
  Framework.MVC.Model.BaseModel;

type
  TCreateViewFunc<TModel: IMVCBaseModel; TView: TForm> = reference to function: IMVCBaseController<TModel, TView>;

  TControllerFactoryImpl<TModel: IMVCBaseModel; TView: TForm> = class(TInterfacedObject, IControllerFactory<TModel, TView>)
  private
    class var FControllers: TDictionary<TClass, TCreateViewFunc<TModel, TView>>;
  protected
    class constructor Create;
    class destructor Destroy;
  public
    class procedure RegisterFactoryMethod(const AViewClass: TClass; const AMethod: TCreateViewFunc<TModel, TView>); virtual;
    class function GetInstance(const AViewClass: TClass): IMVCBaseController<TModel, TView>; virtual;
  end;

implementation

uses
  System.SysUtils;

type
  TControllerFactoryException = Exception;

  { TControllerFactoryImpl<TModel, TView> }



class constructor TControllerFactoryImpl<TModel, TView>.Create;
begin
  FControllers := TDictionary<TClass, TCreateViewFunc<TModel, TView>>.Create();
end;



class destructor TControllerFactoryImpl<TModel, TView>.Destroy;
begin
  FControllers.Free;
end;



class function TControllerFactoryImpl<TModel, TView>.GetInstance(const AViewClass: TClass): IMVCBaseController<TModel, TView>;
var
  oResult: TCreateViewFunc<TModel, TView>;
begin
  if not FControllers.TryGetValue(AViewClass, oResult) then
    raise TControllerFactoryException.CreateFmt('Controller class "%S" not registered', [AViewClass.ClassName]);

  Result := oResult();
end;



class procedure TControllerFactoryImpl<TModel, TView>.RegisterFactoryMethod(const AViewClass: TClass;
  const AMethod: TCreateViewFunc<TModel, TView>);
begin
  FControllers.AddOrSetValue(AViewClass, AMethod);
end;

end.
