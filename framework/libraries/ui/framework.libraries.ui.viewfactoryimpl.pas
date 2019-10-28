unit Framework.Libraries.UI.ViewFactoryImpl;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  spring.Container.Common,
  System.Generics.Collections,
  Framework.MVC.Model.BaseModel,
  Framework.Libraries.InterfacedObjectLoggableImpl,
  Framework.Libraries.UI.ViewRegistryImpl,
  Framework.Libraries.Notification.NotificationServiceImpl;

type
  TAfterNotificationProc = reference to procedure(const AView: TForm);

  TViewFactoryImpl = class(TInterfacedObjectLoggableImpl, IInvokable)
  private
    [Inject]
    FViewRegistryImpl: TViewRegistryImpl;

    [Inject]
    FNotificationService: TNotificationServiceImpl;
  private
    function GetViewInfo(const AClassName: String): TViewInfo;
    function IsDashBoard(const AClassName: String): Boolean;
    function ViewIsInitialized(const AClassName: String): Boolean;
    procedure RegisterObservers(const AViewInstance: TForm; const AModelObserver: TClass);
    procedure BindingViewModel(const AViewInstance: TForm; const AModelInstance: TObject);
  public
    procedure InvokeCreateView<TView: class; TModel: IMVCBaseModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String);
    procedure InvokeShow<TView: class; TModel: IMVCBaseModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String); overload;
    procedure InvokeShow<TView: class; TModel: IMVCBaseModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String;
      const AAfterNotificationProc: TAfterNotificationProc); overload;
    function InvokeShowModal<TView: class; TModel: IMVCBaseModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String): TModalResult;
  end;

implementation

uses
  System.SysUtils,
  SvBindings,
  DSharp.Core.DataConversion,
  Framework.MVC.View.UI.BaseForm,
  Framework.Libraries.Exceptions.ExceptionsClass;

{ TViewFactoryImpl }



function TViewFactoryImpl.IsDashBoard(const AClassName: String): Boolean;
begin
  Result := AClassName = FViewRegistryImpl.DashboardClassName;
end;



procedure TViewFactoryImpl.RegisterObservers(const AViewInstance: TForm; const AModelObserver: TClass);
begin
  {
    Atenção, nao pode ser utilizado anotação [IsNotified([byModel])] ou [IsNotified([byController])]
    na view pois a view não conhece quem é o modelo, isso equivale ao modelo para o modelo
    Nesse caso o mapeamento deve ser manual, como abaixo.
  }
  FNotificationService.Subscribe(AViewInstance, ['ReceiveNotifications']).Observer(AModelObserver);
end;



procedure TViewFactoryImpl.BindingViewModel(const AViewInstance: TForm; const AModelInstance: TObject);
begin
  TDataBindManager.BindView(AViewInstance, AModelInstance);
end;



function TViewFactoryImpl.ViewIsInitialized(const AClassName: String): Boolean;
var
  iMdiChield: Integer;
begin
  Result         := False;
  for iMdiChield := 0 to Pred(Application.MainForm.MDIChildCount) do
    if (Application.MainForm.MDIChildren[iMdiChield].ClassName = AClassName) then
      Exit(True);
end;



function TViewFactoryImpl.GetViewInfo(const AClassName: String): TViewInfo;
begin
  try
    Result := FViewRegistryImpl.Items[AClassName];
  except
    on E: Exception do
      raise TViewFactoryException.CreateFmt('A view "%s" não foi registrada!', [AClassName]);
  end;
end;



procedure TViewFactoryImpl.InvokeCreateView<TView, TModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String);
var
  oViewinfo: TViewInfo;
begin
  oViewinfo := GetViewInfo(TView.ClassName);

  if ((ViewIsInitialized(TView.ClassName)) and (oViewinfo.Unique)) then
    Exit;

  if IsDashBoard(oViewinfo.ViewClass.ClassName) then
    AView := TView(oViewinfo.ResolveView())
  else
  begin
    if oViewinfo.ViewClass.InheritsFrom(TForm) then
    begin
      if Assigned(FViewRegistryImpl.OnCreateForm) then
        AView := TView(FViewRegistryImpl.OnCreateForm(TFormClass(oViewinfo.ViewClass)))
      else
        AView := TView(oViewinfo.ResolveView());
    end;
  end;

  if (AView = nil) then
    raise TViewFactoryException.CreateFmt('View %s not created!', [TView.ClassName]);

  TForm(AView).Caption := AUnitName + '-' + AUnitVersion + ' - ' + TForm(AView).Caption;

  BindingViewModel(TForm(AView), TValue.From<TModel>(AModel).AsObject);
  RegisterObservers(TForm(AView), TValue.From<TModel>(AModel).AsObject.ClassType);

  if (AView <> nil) and Assigned(FViewRegistryImpl.OnAfterCreateView) then
  begin
    FViewRegistryImpl.OnAfterCreateView(TForm(AView), TView.ClassName);
  end;
end;



procedure TViewFactoryImpl.InvokeShow<TView, TModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String;
  const AAfterNotificationProc: TAfterNotificationProc);
begin
  InvokeShow<TView, TModel>(AView, AModel, AUnitName, AUnitVersion);

  if Assigned(AAfterNotificationProc) then
    AAfterNotificationProc(TForm(AView));
end;



procedure TViewFactoryImpl.InvokeShow<TView, TModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String);
begin
  InvokeCreateView<TView, TModel>(AView, AModel, AUnitName, AUnitVersion);
  if (AView is TBaseFormView) then
    TBaseFormView(AView).Model := AModel;

  TForm(AView).Show;
end;



function TViewFactoryImpl.InvokeShowModal<TView, TModel>(var AView: TView; const AModel: TModel; const AUnitName, AUnitVersion: String): TModalResult;
begin
  InvokeCreateView<TView, TModel>(AView, AModel, AUnitName, AUnitVersion);
  try
    if (AView.InheritsFrom(TForm)) then
      Result := TForm(AView).ShowModal
    else
      Result := mrNone;
  finally
    AView.Free;
  end;
end;

end.
