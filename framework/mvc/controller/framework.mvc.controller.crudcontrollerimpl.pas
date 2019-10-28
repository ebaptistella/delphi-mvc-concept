unit Framework.MVC.Controller.CRUDControllerImpl;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  Spring,
  Framework.Libraries.UI.ViewFactoryImpl,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.Libraries.Notification.NotificationMessage,
  Framework.Libraries.Notification.NotificationMessageImpl,
  Framework.Libraries.Security.SecurityController,
  Framework.MVC.Controller.BaseControllerImpl,
  Framework.MVC.Controller.CRUDController,
  Framework.MVC.Controller.Initializable,
  Framework.MVC.Model.BaseModel;

type
{$M+}
  TMVCCRUDControllerImpl<TModel: IMVCBaseModel; TView: TForm> = class(TMVCBaseControllerImpl<TModel>, IMVCCRUDController<TModel, TView>, IMVCInitializable)
  private
    FView: TView;
    FViewFactory: TViewFactoryImpl;
    FNotificationService: TNotificationServiceImpl;

    function GetView: TView;
    function GetNotificationService: TNotificationServiceImpl;
    function GetViewFactory: TViewFactoryImpl;
  protected
    FUnitName: string;
    FUnitVersion: String;

    procedure Initialize; override;
    procedure NotifyModelObservers(const AStatus: TNotificationMessageStatus; const AMessage: String);
  published
    [IsNotified([byView])]
    procedure New; virtual;

    [IsNotified([byView])]
    procedure Save; virtual;

    [IsNotified([byView])]
    procedure Delete; virtual;

    [IsNotified([byView])]
    procedure Schedule; virtual;

    [IsNotified([byView])]
    procedure Configure; virtual;

    [IsNotified([byView])]
    procedure ShowReport; virtual;

    [IsNotified([byView])]
    function ControlCheck(const AControl: TWinControl): Boolean; virtual;

    [IsNotified([byView])]
    function FindOne(const AId: TValue): Boolean; virtual;
  public
    constructor Create(const AModel: TModel; const AViewFactory: TViewFactoryImpl; const ANotificationService: TNotificationServiceImpl;
      const ASecurityController: ISecurityController); overload;

    property View: TView read GetView;
    property ViewFactory: TViewFactoryImpl read GetViewFactory;
    property NotificationService: TNotificationServiceImpl read GetNotificationService;
  end;
{$M-}

implementation

uses
  System.SysUtils;

{ TMVCCRUDControllerImpl<TModel, TView> }



constructor TMVCCRUDControllerImpl<TModel, TView>.Create(const AModel: TModel; const AViewFactory: TViewFactoryImpl; const ANotificationService: TNotificationServiceImpl;
  const ASecurityController: ISecurityController);
begin
  inherited Create(AModel, ASecurityController);

  FViewFactory         := AViewFactory;
  FNotificationService := ANotificationService;
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.Initialize;
begin
  inherited;

{$IFDEF VER300}
  NotificationService.Subscribe(Self);
{$ELSE}
  NotificationService.Subscribe(Self, ['New', 'Save', 'Delete', 'Schedule', 'Configure', 'ShowReport', 'ControlCheck', 'FindOne']).Observer(TView);
{$ENDIF}
  FUnitName    := EmptyStr;
  FUnitVersion := EmptyStr;
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.New;
begin
  Logger.Track(Self.ClassType, 'New');
  if not(SecurityController.isAllowed(Self, @TMVCCRUDControllerImpl<TModel, TView>.New)) then
    Abort;

  ViewFactory.InvokeShow<TView, TModel>(FView, Model, FUnitName, FUnitVersion);
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.Save;
begin
  Logger.Track(Self.ClassType, 'Save');
  if not(SecurityController.isAllowed(Self, @TMVCCRUDControllerImpl<TModel, TView>.Save)) then
    Abort;
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.Delete;
begin
  Logger.Track(Self.ClassType, 'Delete');
  if not(SecurityController.isAllowed(Self, @TMVCCRUDControllerImpl<TModel, TView>.Delete)) then
    Abort;
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.Schedule;
begin
  Logger.Track(Self.ClassType, 'Schedule');
  if not(SecurityController.isAllowed(Self, @TMVCCRUDControllerImpl<TModel, TView>.Schedule)) then
    Abort;
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.Configure;
begin
  Logger.Track(Self.ClassType, 'Configure');
  if not(SecurityController.isAllowed(Self, @TMVCCRUDControllerImpl<TModel, TView>.Configure)) then
    Abort;
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.ShowReport;
begin
  Logger.Track(Self.ClassType, 'ShowReport');
end;



function TMVCCRUDControllerImpl<TModel, TView>.ControlCheck(const AControl: TWinControl): Boolean;
begin
  Logger.Track(Self.ClassType, 'ControlCheck');

  Model.AddCustomValidation;
  Result := Model.IsValid(View, AControl);
  if (not(Result)) then
    NotifyModelObservers(nmsWarning, Model.Validate.ErrorMessages.Text);
end;



function TMVCCRUDControllerImpl<TModel, TView>.FindOne(const AId: TValue): Boolean;
begin
  Logger.Track(Self.ClassType, 'FindOne');
  Result := False;
end;



procedure TMVCCRUDControllerImpl<TModel, TView>.NotifyModelObservers(const AStatus: TNotificationMessageStatus; const AMessage: String);
begin
  NotificationService.NotifyObservers(
    TValue.From<TModel>(Model).AsObject.ClassType,
    'ReceiveNotifications',
    [TValue.From<INotificationMessage>(TNotificationMessageImpl.Construct(AStatus, AMessage))]
    );
end;



function TMVCCRUDControllerImpl<TModel, TView>.GetNotificationService: TNotificationServiceImpl;
begin
  Result := FNotificationService;
end;



function TMVCCRUDControllerImpl<TModel, TView>.GetView: TView;
begin
  Result := FView;
end;



function TMVCCRUDControllerImpl<TModel, TView>.GetViewFactory: TViewFactoryImpl;
begin
  Result := FViewFactory;
end;

end.
