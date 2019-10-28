unit Framework.Libraries.Connection.ConnectionFactoryImpl;

interface

uses
  Framework.Libraries.InterfacedObjectLoggableImpl,
  Framework.Libraries.Connection.ConnectionFactory,
  Spring.Persistence.Core.ConnectionFactory,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Core.Interfaces,
  Data.SqlExpr;

type
  TConnectionFactoryImpl = class(TInterfacedObjectLoggableImpl, IConnectionFactory)
  private
    FOwnerOfConnection: Boolean;

    FDBXConnection: TSQLConnection;
    FDBConnection: IDBConnection;
    FSession: TSession;
  private
    procedure CreateConnection;

    function GetDBXConnection: TSQLConnection;
    function GetDBConnection: IDBConnection;
    function GetSession: TSession;
  public
    constructor Create(const ADBXConnection: TSQLConnection); overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property DBXConnection: TSQLConnection read GetDBXConnection;
    property DBConnection: IDBConnection read GetDBConnection;
    property Session: TSession read GetSession;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  Framework.Libraries.Exceptions.ExceptionsClass,
  Framework.Libraries.Persistence.DBXAdapterImpl,
  Spring.Persistence.SQL.Interfaces;

{ TConnectionFactoryImpl }



procedure TConnectionFactoryImpl.AfterConstruction;
begin
  inherited;

  if (FDBXConnection = nil) then
  begin
    CreateConnection;
  end;

  if not(FDBXConnection.Connected) then
    FDBXConnection.Open;

  if not(FDBXConnection.Connected) then
    raise TConnectionFactoryException.Create('ADBXConnection can not get a connection!');

  FDBConnection                    := TConnectionFactory.GetInstance(dtDBX, FDBXConnection);
  FDBConnection.AutoFreeConnection := False;

  { TODO -oOwner -cGeneral : Ajustar conforme o banco de dados }
  FDBConnection.QueryLanguage := qlPostgreSQL;

  FSession := TSession.Create(FDBConnection);
end;



procedure TConnectionFactoryImpl.BeforeDestruction;
begin
  FSession.Free;

  if (FOwnerOfConnection) then
    FDBXConnection.Free;

  inherited;
end;



constructor TConnectionFactoryImpl.Create(const ADBXConnection: TSQLConnection);
begin
  FOwnerOfConnection := False;
  FDBXConnection     := ADBXConnection;
end;



function TConnectionFactoryImpl.GetDBConnection: IDBConnection;
begin
  Result := FDBConnection;
end;



function TConnectionFactoryImpl.GetDBXConnection: TSQLConnection;
begin
  Result := FDBXConnection;
end;



function TConnectionFactoryImpl.GetSession: TSession;
begin
  Result := FSession;
end;



procedure TConnectionFactoryImpl.CreateConnection;
begin
  FOwnerOfConnection := True;
  FDBXConnection     := TSQLConnection.Create(nil);

  { TODO -oOwner -cGeneral : Ajustar conexão, neste caso utilizando DBExpress }
  {
    FDBXConnection.LoginPrompt := False;
    FDBXConnection.DriverName := 'SQLite';
    FDBXConnection.Params.Values['Database'] := 'test.s3db';
    FDBXConnection.Params.Values['ColumnMetaDataSupported'] := 'True';
    FDBXConnection.Params.Values['FailIsMissing'] := 'False';
  }

  FDBXConnection.Open;

end;

end.
