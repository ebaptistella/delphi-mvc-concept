unit Framework.Libraries.InterfacedObjectInjectedAttrImpl;

interface

uses
  Spring,
  Spring.Logging,
  Spring.Container.Common,
  Framework.Libraries.UI.ViewFactoryImpl,
  Framework.Libraries.Notification.NotificationServiceImpl;

type
  TInterfacedObjectInjectedAttrImpl = class(TInterfacedObject, IInvokable)
  private
    function GetLogger: ILogger;
    function GetViewFactory: TViewFactoryImpl;
    function GetNotificationService: TNotificationServiceImpl;

  protected
    [Inject]
    FLogger: ILogger;

    // [Inject]
    FViewFactory: TViewFactoryImpl;

    // [Inject]
    FNotificationService: TNotificationServiceImpl;
  public
    property Logger: ILogger read GetLogger;
    property ViewFactory: TViewFactoryImpl read GetViewFactory;
    property NotificationService: TNotificationServiceImpl read GetNotificationService;
  end;

implementation

{ TInterfacedObjectInjectedAttrImpl }



function TInterfacedObjectInjectedAttrImpl.GetLogger: ILogger;
begin
  Result := FLogger;
end;



function TInterfacedObjectInjectedAttrImpl.GetNotificationService: TNotificationServiceImpl;
begin
  Result := FNotificationService;
end;



function TInterfacedObjectInjectedAttrImpl.GetViewFactory: TViewFactoryImpl;
begin
  Result := FViewFactory;
end;

end.
