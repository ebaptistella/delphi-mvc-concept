unit Framework.MVC.Controller.CRUDController;

interface

uses
  Vcl.Forms,
  Framework.MVC.Controller.BaseController,
  Framework.MVC.Model.BaseModel,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.Libraries.UI.ViewFactoryImpl;

type
  IMVCCRUDController<TModel: IMVCBaseModel; TView: TForm> = interface(IMVCBaseController<TModel>)
    ['{266C6132-0C03-43B8-A0B3-473D3692F551}']
    function GetView: TView;
    function GetNotificationService: TNotificationServiceImpl;
    function GetViewFactory: TViewFactoryImpl;

    procedure New;
    procedure Save;
    procedure Delete;
    procedure Schedule;
    procedure ShowReport;

    property View: TView read GetView;
    property ViewFactory: TViewFactoryImpl read GetViewFactory;
    property NotificationService: TNotificationServiceImpl read GetNotificationService;
  end;

implementation

end.
