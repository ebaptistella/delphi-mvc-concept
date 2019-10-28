unit Framework.Libraries.Persistence.ORMPersistence;

interface

uses
  Framework.MVC.Model.BaseModel,
  Spring.Persistence.Core.Session,
  Framework.Libraries.Notification.NotificationServiceImpl;

type
  IORMPersistence<TModel: IMVCBaseModel> = interface(IInvokable)
    ['{DDDB6219-C3AF-4180-BE62-6412997CA89A}']
    function GetSession: TSession;

    procedure Save(const AModel: TModel);

    procedure Delete(const AModel: TModel);
    procedure DeleteList(const AEntities: IEnumerable<TModel>);

    procedure Insert(const AModel: TModel);
    procedure InsertList(const AEntities: IEnumerable<TModel>);

    procedure Update(const AModel: TModel);
    procedure UpdateList(const AEntities: IEnumerable<TModel>);

    property Session: TSession read GetSession;
  end;

implementation

end.
