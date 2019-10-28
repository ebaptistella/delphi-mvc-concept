unit Framework.Libraries.Persistence.ORMPersistenceImpl;

interface

uses
  Framework.Libraries.Persistence.ORMPersistence,
  Framework.Libraries.InterfacedObjectLoggableImpl,
  Framework.Libraries.Connection.ConnectionFactoryImpl,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.MVC.Model.BaseModel,
  Framework.MVC.Model.BaseModelImpl,
  Spring.Logging,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Core.Interfaces,
  Spring.Container.Common;

type
  TORMPersistenceImpl<TModel: IMVCBaseModel> = class(TInterfacedObjectLoggableImpl, IORMPersistence<TModel>)
  private
    FConnectionFactory: TConnectionFactoryImpl;
    FSession: TSession;
  private
    function GetSession: TSession;
  public
    constructor Create(const AConnectionFactory: TConnectionFactoryImpl); reintroduce;

    procedure Save(const AModel: TModel); virtual; abstract;

    procedure Delete(const AModel: TModel); virtual;
    procedure DeleteList(const AEntities: IEnumerable<TModel>); virtual; abstract;

    procedure Insert(const AModel: TModel); virtual;
    procedure InsertList(const AEntities: IEnumerable<TModel>); virtual; abstract;

    procedure Update(const AModel: TModel); virtual;
    procedure UpdateList(const AEntities: IEnumerable<TModel>); virtual; abstract;

    property Session: TSession read GetSession;
  end;

implementation

uses
  System.SysUtils,
  System.Rtti;

{ TORMPersistenceImpl }



constructor TORMPersistenceImpl<TModel>.Create(const AConnectionFactory: TConnectionFactoryImpl);
begin
  inherited Create;

  FConnectionFactory := AConnectionFactory;
  FSession           := FConnectionFactory.Session;
end;



function TORMPersistenceImpl<TModel>.GetSession: TSession;
begin
  Result := FSession;
end;



procedure TORMPersistenceImpl<TModel>.Insert(const AModel: TModel);
var
  oDBTransaction: IDBTransaction;
begin
  Logger.Track(self.ClassType, 'Insert');

  oDBTransaction := Session.BeginTransaction;
  try
    Session.Insert(TValue.From<TModel>(AModel).AsObject);
    oDBTransaction.Commit;
  except
    on E: Exception do
    begin
      oDBTransaction.Rollback;
      raise;
    end;
  end;
end;



procedure TORMPersistenceImpl<TModel>.Update(const AModel: TModel);
var
  oDBTransaction: IDBTransaction;
begin
  Logger.Track(self.ClassType, 'Update');

  oDBTransaction := Session.BeginTransaction;
  try
    Session.Update(TValue.From<TModel>(AModel).AsObject);
    oDBTransaction.Commit;
  except
    on E: Exception do
    begin
      oDBTransaction.Rollback;
      raise;
    end;
  end;
end;



procedure TORMPersistenceImpl<TModel>.Delete(const AModel: TModel);
var
  oDBTransaction: IDBTransaction;
begin
  Logger.Track(self.ClassType, 'Delete');

  oDBTransaction := Session.BeginTransaction;
  try
    Session.Delete(TValue.From<TModel>(AModel).AsObject);
    oDBTransaction.Commit;
  except
    on E: Exception do
    begin
      oDBTransaction.Rollback;
      raise;
    end;
  end;
end;

end.
