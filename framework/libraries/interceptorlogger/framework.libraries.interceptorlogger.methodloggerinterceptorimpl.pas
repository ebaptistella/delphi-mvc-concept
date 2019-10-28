unit Framework.Libraries.InterceptorLogger.MethodLoggerInterceptorImpl;

interface

uses
  Spring.Container.Common,
  Spring.Interception,
  Spring.Logging;

type
  TMethodLoggerInterceptorImpl = class(TInterfacedObject, IInterceptor)
  private
    [Inject]
    FLogger: ILogger;
  public
    procedure Intercept(const invocation: IInvocation);
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo;

{ TMethodLoggerInterceptorImpl }



procedure TMethodLoggerInterceptorImpl.Intercept(const invocation: IInvocation);
var
  InstanceName: String;
begin
  case invocation.Target.Kind of
    tkInterface:
      InstanceName := invocation.Method.Parent.Name;
    tkClass:
      InstanceName := invocation.Method.ReturnType.AsInstance.ClassName;
  end;

  FLogger.Info(Format('%s.%s is called with %s argument(s)', [InstanceName, invocation.Method.Name, Length(invocation.Arguments).ToString]));
  try
    invocation.Proceed;
  except
    on E: Exception do
    begin
      FLogger.Error(Format('%s.%s', [InstanceName, invocation.Method.Name, E.Message]), E);
      raise;
    end;
  end;
  FLogger.Info(Format('%s.%s Finished', [InstanceName, invocation.Method.Name]));
end;

end.
