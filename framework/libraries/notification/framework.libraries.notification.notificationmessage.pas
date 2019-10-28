unit Framework.Libraries.Notification.NotificationMessage;

interface

uses
  System.Rtti;

type
  TNotificationMessageStatus = (nmsUnknown, nmsSuccess, nmsWarning);
  TNotificationMessageType = (nmtUnknown, nmtMessage, nmtException);

  INotificationMessage = interface(IInvokable)
    ['{CC7ECAF2-7C4B-4A6F-86BB-4A5632CAF8E8}']
    function GetMsgStatus: TNotificationMessageStatus;
    function GetMsgType: TNotificationMessageType;
    function GetMsgText: string;

    property MsgStatus: TNotificationMessageStatus read GetMsgStatus;
    property MsgType: TNotificationMessageType read GetMsgType;
    property MsgText: string read GetMsgText;
  end;

implementation

end.
