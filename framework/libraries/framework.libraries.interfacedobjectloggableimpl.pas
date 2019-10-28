unit Framework.Libraries.InterfacedObjectLoggableImpl;

interface

uses
  Spring,
  Spring.Logging,
  Spring.Container.Common;

type
  TInterfacedObjectLoggableImpl = class(TInterfacedObject, IInvokable)
  private
    function GetLogger: ILogger;
  protected
    [Inject]
    FLogger: ILogger;
  public
    property Logger: ILogger read GetLogger;
  end;

implementation

{ TInterfacedObjectLoggableImpl }



function TInterfacedObjectLoggableImpl.GetLogger: ILogger;
begin
  Result := FLogger;
end;

end.
