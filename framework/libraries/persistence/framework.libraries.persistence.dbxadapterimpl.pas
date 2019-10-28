unit Framework.Libraries.Persistence.DBXAdapterImpl;

interface

uses
  Data.SqlExpr,
  DBXCommon,
  SysUtils,
  Spring.Collections,
  Spring.Persistence.Core.Base,
  Spring.Persistence.Core.Exceptions,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.SQL.Params;

type
  EDBXAdapterException = class(EORMAdapterException);

  /// <summary>
  /// Represents DBX resultset.
  /// </summary>
  TDBXResultSetAdapter = class(TDriverResultSetAdapter<TSQLQuery>);

  /// <summary>
  /// Represents DBX statement.
  /// </summary>
  TDBXStatementAdapter = class(TDriverStatementAdapter<TSQLQuery>)
  public
    destructor Destroy; override;
    procedure SetSQLCommand(const commandText: string); override;
    procedure SetParam(const param: TDBParam); virtual;
    procedure SetParams(const Params: IEnumerable<TDBParam>); override;
    function Execute: NativeUInt; override;
    function ExecuteQuery(serverSideCursor: Boolean = True): IDBResultSet; override;
  end;

  /// <summary>
  /// Represents DBX connection.
  /// </summary>
  TDBXConnectionAdapter = class(TDriverConnectionAdapter<TSQLConnection>)
  protected
    constructor Create(const connection: TSQLConnection; const exceptionHandler: IORMExceptionHandler); override;
  public
    constructor Create(const connection: TSQLConnection); override;

    procedure Connect; override;
    procedure Disconnect; override;
    function IsConnected: Boolean; override;
    function CreateStatement: IDBStatement; override;
    function BeginTransaction: IDBTransaction; override;
  end;

  /// <summary>
  /// Represents DBX transaction.
  /// </summary>
  TDBXTransactionAdapter = class(TDriverTransactionAdapter<TDBXTransaction>)
  private
    FConnection: TSQLConnection;
  protected
    function InTransaction: Boolean; override;
  public
    constructor Create(const AConnection: TSQLConnection; const ATransaction: TDBXTransaction; const AExceptionHandler: IORMExceptionHandler); reintroduce;
    destructor Destroy; override;

    procedure Commit; override;
    procedure Rollback; override;
  end;

  TDBXExceptionHandler = class(TORMExceptionHandler)
  protected
    function GetAdapterException(const exc: Exception; const defaultMsg: string): Exception; override;
    function GetDriverException(const exc: TDBXError; const defaultMsg: string): Exception; virtual;
  end;

implementation

uses
  DB,
  SysConst,
  StrUtils,
  Spring.Persistence.Core.ConnectionFactory,
  Spring.Persistence.Core.ResourceStrings;

{$REGION 'TDBXStatementAdapter'}
{ TDBXStatementAdapter }



destructor TDBXStatementAdapter.Destroy;
begin
  Statement.Free;
  inherited Destroy;
end;



function TDBXStatementAdapter.Execute: NativeUInt;
begin
  inherited;
  try
    Result := Statement.ExecSQL;
  except
    raise HandleException;
  end;
end;



function TDBXStatementAdapter.ExecuteQuery(
  serverSideCursor: Boolean): IDBResultSet;
var
  query: TSQLQuery;
begin
  inherited;
  query               := TSQLQuery.Create(nil);
  query.SQLConnection := Statement.SQLConnection;
  query.SQL.Text      := ReplaceText(Statement.SQL.Text, '"', EmptyStr);
  query.Params.AssignValues(Statement.Params);
  query.DisableControls;
  try
    query.Open;
    Result := TDBXResultSetAdapter.Create(query, exceptionHandler);
  except
    on E: Exception do
    begin
      query.Free;
      raise HandleException(Format(SCannotOpenQuery, [E.Message]));
    end;
  end;
end;



procedure TDBXStatementAdapter.SetParam(const param: TDBParam);
var
  paramName: string;
  parameter: TParam;
begin
  paramName       := param.GetNormalizedParamName;
  parameter       := Statement.ParamByName(paramName);
  parameter.Value := param.ToVariant;
  if parameter.IsNull then
    parameter.DataType := param.ParamType;
end;



procedure TDBXStatementAdapter.SetParams(const Params: IEnumerable<TDBParam>);
begin
  inherited;
  Params.ForEach(SetParam);
end;



procedure TDBXStatementAdapter.SetSQLCommand(const commandText: string);
begin
  inherited;
  Statement.SQL.Text := ReplaceText(commandText, '"', EmptyStr);
end;

{$ENDREGION}

{$REGION 'TDBXConnectionAdapter'}
{ TDBXConnectionAdapter }



function TDBXConnectionAdapter.BeginTransaction: IDBTransaction;
begin
  if Assigned(connection) then
    try
      connection.Connected := True;

      Result := TDBXTransactionAdapter.Create(connection, connection.BeginTransaction, exceptionHandler);
    except
      raise HandleException;
    end
  else
    Result := nil;
end;



procedure TDBXConnectionAdapter.Connect;
begin
  if Assigned(connection) then
    try
      connection.Connected := True;
    except
      raise HandleException;
    end;
end;



constructor TDBXConnectionAdapter.Create(
  const connection: TSQLConnection);
begin
  Create(connection, TDBXExceptionHandler.Create);
end;



constructor TDBXConnectionAdapter.Create(const connection: TSQLConnection;
  const exceptionHandler: IORMExceptionHandler);
begin
  inherited Create(connection, exceptionHandler);
  connection.LoginPrompt := False;
end;



function TDBXConnectionAdapter.CreateStatement: IDBStatement;
var
  Statement: TSQLQuery;
  adapter: TDBXStatementAdapter;
begin
  if Assigned(connection) then
  begin
    Statement               := TSQLQuery.Create(nil);
    Statement.SQLConnection := connection;

    adapter                    := TDBXStatementAdapter.Create(Statement, exceptionHandler);
    adapter.ExecutionListeners := ExecutionListeners;
    Result                     := adapter;
  end
  else
    Result := nil;
end;



procedure TDBXConnectionAdapter.Disconnect;
begin
  if Assigned(connection) then
    try
      connection.Connected := False;
    except
      raise HandleException;
    end;
end;



function TDBXConnectionAdapter.IsConnected: Boolean;
begin
  if Assigned(connection) then
    Result := connection.Connected
  else
    Result := False;
end;

{$ENDREGION}

{$REGION 'TDBXTransactionAdapter'}
{ TDBXTransactionAdapter }



procedure TDBXTransactionAdapter.Commit;
begin
  if InTransaction then
    try
      FConnection.CommitFreeAndNil(fTransaction);
    except
      raise HandleException;
    end;
end;



constructor TDBXTransactionAdapter.Create(
  const AConnection: TSQLConnection; const ATransaction: TDBXTransaction;
  const AExceptionHandler: IORMExceptionHandler);
begin
  FConnection := AConnection;

  if (not(AConnection.InTransaction)) then
    inherited Create(ATransaction, AExceptionHandler);
end;



destructor TDBXTransactionAdapter.Destroy;
begin
  if InTransaction then
    FConnection.RollbackIncompleteFreeAndNil(fTransaction);

  inherited;
end;



function TDBXTransactionAdapter.InTransaction: Boolean;
begin
  Result := FConnection.InTransaction;
end;



procedure TDBXTransactionAdapter.Rollback;
begin
  if InTransaction then
    try
      FConnection.RollbackIncompleteFreeAndNil(fTransaction);
    except
      raise HandleException;
    end;
end;

{$ENDREGION}

{$REGION 'TDBXExceptionHandler'}
{ TDBXExceptionHandler }



function TDBXExceptionHandler.GetAdapterException(const exc: Exception;
  const defaultMsg: string): Exception;
begin
  if exc is TDBXError then
  begin
    Result := GetDriverException(TDBXError(exc), defaultMsg);
    if not Assigned(Result) then
      Result := EDBXAdapterException.Create(defaultMsg,
        TDBXError(exc).ErrorCode);
  end
  else if exc is EDatabaseError then
    Result := EDBXAdapterException.Create(defaultMsg)
  else
    Result := nil;
end;



function TDBXExceptionHandler.GetDriverException(const exc: TDBXError;
  const defaultMsg: string): Exception;
begin
  Result := nil;
end;

{$ENDREGION}


initialization

TConnectionFactory.RegisterConnection<TDBXConnectionAdapter>(dtDBX);

end.
