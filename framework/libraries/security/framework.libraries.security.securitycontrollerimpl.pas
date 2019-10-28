unit Framework.Libraries.Security.SecurityControllerImpl;

interface

uses
  Spring.Logging,
  Spring.Interception,
  Spring.Container.Common,
  Framework.Libraries.Security.SecurityController;

type
  TSecurityControllerImpl = class(TInterfacedObject, IInterceptor, ISecurityController)
  private
    [Inject]
    FLogger: ILogger;
  private
    function DoIsAllowed(const AMethodName: String): Boolean;

    function GetNewMethodName: String;
    function GetSaveMethodName: String;
    function GetDeleteMethodName: String;
    function GetScheduleMethodName: String;
    function GetConfigureMethodName: String;
  public
    function isAllowed(const AController: TObject; const AMethod: Pointer): Boolean;
    procedure Intercept(const invocation: IInvocation);
  end;

implementation

uses
  System.SysUtils,
  Framework.MVC.Model.BaseModelImpl,
  Framework.MVC.Controller.CRUDControllerImpl,
  Framework.MVC.View.UI.BaseForm;

{ TSecurityControllerImpl }



procedure TSecurityControllerImpl.Intercept(const invocation: IInvocation);
begin
  FLogger.Track(Self, 'Intercept');
  if DoIsAllowed(invocation.Method.Name) then
    invocation.Proceed;
end;



function TSecurityControllerImpl.isAllowed(const AController: TObject; const AMethod: Pointer): Boolean;
begin
  FLogger.Track(Self, 'isAllowed');
  Result := DoIsAllowed(AController.MethodName(AMethod));
end;



function TSecurityControllerImpl.DoIsAllowed(const AMethodName: String): Boolean;
begin
  Result := True;

  if (AMethodName = GetNewMethodName) then
    Result := True
  else if (AMethodName = GetSaveMethodName) then
    Result := True
  else if (AMethodName = GetDeleteMethodName) then
    Result := True
  else if (AMethodName = GetScheduleMethodName) then
    Result := True
  else if (AMethodName = GetConfigureMethodName) then
    Result := True;
end;



function TSecurityControllerImpl.GetDeleteMethodName: String;
begin
  Result := TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.MethodName(@TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.Delete);
end;



function TSecurityControllerImpl.GetNewMethodName: String;
begin
  Result := TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.MethodName(@TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.New);
end;



function TSecurityControllerImpl.GetSaveMethodName: String;
begin
  Result := TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.MethodName(@TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.Save);
end;



function TSecurityControllerImpl.GetScheduleMethodName: String;
begin
  Result := TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.MethodName(@TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.Schedule);
end;



function TSecurityControllerImpl.GetConfigureMethodName: String;
begin
  Result := TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.MethodName(@TMVCCRUDControllerImpl<TMVCBaseModelImpl, TBaseFormView>.Configure);
end;

end.
