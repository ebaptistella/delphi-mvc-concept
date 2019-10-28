unit Framework.MVC.Controller.ORMCRUDControllerImpl;

interface

uses
  Vcl.Forms,
  Framework.Libraries.DAO.GenericDAO,
  Framework.Libraries.UI.ViewFactoryImpl,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.Libraries.Security.SecurityController,
  Framework.MVC.Controller.ORMCRUDController,
  Framework.MVC.Controller.CRUDControllerImpl,
  Framework.MVC.Model.BaseModel;

type
  TMVCORMCRUDControllerImpl<TModel: IMVCBaseModel; TView: TForm> = class(TMVCCRUDControllerImpl<TModel, TView>, IMVCORMCRUDController<TModel, TView>)
  private
    FDAO: IGenericDAO<TModel>;
  private
    function GetDAO: IGenericDAO<TModel>;
  public
    constructor Create(const ADAO: IGenericDAO<TModel>; const AModel: TModel; const AViewFactory: TViewFactoryImpl; const ANotificationService: TNotificationServiceImpl;
      const ASecurityController: ISecurityController); overload;

    procedure Save; override;
    procedure Delete; override;

    property DAO: IGenericDAO<TModel> read GetDAO;
  end;

implementation

uses
  System.SysUtils,
  System.Rtti,
  Framework.Libraries.Notification.NotificationMessage;

{ TMVCORMCRUDControllerImpl<TModel, TView> }



constructor TMVCORMCRUDControllerImpl<TModel, TView>.Create(const ADAO: IGenericDAO<TModel>; const AModel: TModel; const AViewFactory: TViewFactoryImpl;
  const ANotificationService: TNotificationServiceImpl; const ASecurityController: ISecurityController);
begin
  inherited Create(AModel, AViewFactory, ANotificationService, ASecurityController);
  FDAO := ADAO;
end;



procedure TMVCORMCRUDControllerImpl<TModel, TView>.Delete;
begin
  inherited;

  DAO.Delete(Model);
  NotifyModelObservers(nmsSuccess, 'Registro excluído com sucesso!');
end;



procedure TMVCORMCRUDControllerImpl<TModel, TView>.Save;
begin
  inherited;

  DAO.Save(Model);
  NotifyModelObservers(nmsSuccess, 'Registro salvo com sucesso!');
end;



function TMVCORMCRUDControllerImpl<TModel, TView>.GetDAO: IGenericDAO<TModel>;
begin
  Result := FDAO;
end;

end.
