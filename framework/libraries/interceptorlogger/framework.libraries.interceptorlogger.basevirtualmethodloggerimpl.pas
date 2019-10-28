unit Framework.Libraries.InterceptorLogger.BaseVirtualMethodLoggerImpl;

interface

uses
  Framework.Libraries.BaseVirtualMethodLogger,
  Framework.Libraries.VirtualMethodLogger,
  Framework.Libraries.VirtualMethodLoggerImpl,
  Spring.Container.Common;

type
  TBaseVirtualMethodLoggerImpl = class(TInterfacedObject, IBaseVirtualMethodLogger)
  strict private
    [Inject]
    FLogger: IVirtualMethodLogger;
  public
    constructor Create; virtual;
  end;

implementation

{ TBaseVirtualMethodLoggerImpl }



constructor TBaseVirtualMethodLoggerImpl.Create;
begin
  FLogger := LogVirtualMethodCalls(Self);
  inherited Create;
end;

end.
