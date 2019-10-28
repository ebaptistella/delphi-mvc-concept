unit Framework.Libraries.Notification.NotificationMessageImpl;

interface

uses
  Framework.Libraries.InterfacedObjectLoggableImpl,
  Framework.Libraries.Notification.NotificationMessage,
  System.Rtti;

type
  TNotificationMessageStatus = Framework.Libraries.Notification.NotificationMessage.TNotificationMessageStatus;
  TNotificationMessageType = Framework.Libraries.Notification.NotificationMessage.TNotificationMessageType;

  TNotificationMessageImpl = class(TInterfacedObjectLoggableImpl, INotificationMessage)
  strict private
    class var FMsgStatus: TNotificationMessageStatus;
    class var FMsgType: TNotificationMessageType;
    class var FMsgText: string;
  private
    function GetMsgStatus: TNotificationMessageStatus;
    function GetMsgType: TNotificationMessageType;
    function GetMsgText: string;
  public
    class function Construct(const AMsgType: TNotificationMessageType; const AMsgStatus: TNotificationMessageStatus; const AMsgText: String): INotificationMessage; overload;
    class function Construct(const AMsgStatus: TNotificationMessageStatus; const AMsgText: String): INotificationMessage; overload;
    class function Construct(const AMsgText: String): INotificationMessage; overload;

    property MsgStatus: TNotificationMessageStatus read GetMsgStatus;
    property MsgType: TNotificationMessageType read GetMsgType;
    property MsgText: string read GetMsgText;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo;

{ TNotificationMessageImpl }



class function TNotificationMessageImpl.Construct(const AMsgType: TNotificationMessageType; const AMsgStatus: TNotificationMessageStatus; const AMsgText: String)
  : INotificationMessage;
begin
  Result := Inherited Create;

  FMsgType   := AMsgType;
  FMsgStatus := AMsgStatus;
  FMsgText   := AMsgText;
end;



class function TNotificationMessageImpl.Construct(const AMsgStatus: TNotificationMessageStatus; const AMsgText: String): INotificationMessage;
begin
  Result := Construct(nmtMessage, AMsgStatus, AMsgText);
end;



class function TNotificationMessageImpl.Construct(const AMsgText: String): INotificationMessage;
begin
  Result := Construct(nmtMessage, nmsSuccess, AMsgText);
end;



function TNotificationMessageImpl.GetMsgStatus: TNotificationMessageStatus;
begin
  Result := FMsgStatus;
end;



function TNotificationMessageImpl.GetMsgType: TNotificationMessageType;
begin
  Result := FMsgType;
end;



function TNotificationMessageImpl.GetMsgText: String;
begin
  Result := FMsgText;
end;

end.
