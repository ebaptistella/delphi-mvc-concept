unit Framework.Libraries.Notification.NotificationService;

interface

uses
  System.Rtti;

type
  IObserverNotification = interface(IInvokable)
    ['{B18DA11E-CAAB-4619-9490-EE0AE8203752}']
    function Observer(const AObservedClass: TClass): IObserverNotification;
  end;

  INotificationService = interface(IInvokable)
    ['{FDA5B1B5-BE4E-42C2-8E33-FC6ED9B85F1B}']
    procedure Subscribe(const AInstance: TObject); overload;
    function Subscribe(const AInstance: TObject; const AMethods: array of String): IObserverNotification; overload;
    function UnSubscribe(const AInstance: TObject; const AMethods: array of String): INotificationService;
    procedure NotifyObservers(const AObservedClass: TClass; const AMethodName: String; const AArgs: array of TValue); overload;
    procedure NotifyObservers(const AObservedClass: TClass; const AMethodName: String); overload;
  end;

implementation

end.
