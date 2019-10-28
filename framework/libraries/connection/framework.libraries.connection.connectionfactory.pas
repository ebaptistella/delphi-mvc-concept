unit Framework.Libraries.Connection.ConnectionFactory;

interface

uses
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,
  Data.SqlExpr;

type
  IConnectionFactory = interface(IInvokable)
    ['{0F9FABE3-E37D-404A-8DC4-723394170D65}']
    function GetDBXConnection: TSQLConnection;
    function GetDBConnection: IDBConnection;
    function GetSession: TSession;

    property DBXConnection: TSQLConnection read GetDBXConnection;
    property DBConnection: IDBConnection read GetDBConnection;
    property Session: TSession read GetSession;
  end;

implementation

end.
