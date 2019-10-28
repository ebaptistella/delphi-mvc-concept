unit Framework.Libraries.InterceptorLogger.VirtualMethodLoggerImpl;

interface

uses
  Framework.Libraries.VirtualMethodLogger,
  System.Rtti,
  System.Classes;

type
  TVirtualMethodLoggerImpl = class(TInterfacedObject, IVirtualMethodLogger)
  strict private
    FInterceptor: TVirtualMethodInterceptor;
    FObject: TObject;
    FOwnOutput: Boolean;
    FOutput: TTextWriter;
  public
    constructor Create(Obj: TObject; Output: TTextWriter; OwnOutput: Boolean); overload;
    constructor Create(Obj: TObject); overload;
    destructor Destroy; override;
    procedure StopLogging(ObjectStillAlive: Boolean = True);
  end;

function LogVirtualMethodCalls(Obj: TObject; Output: TTextWriter; OwnOutput: Boolean = False): IVirtualMethodLogger; overload;
function LogVirtualMethodCalls(Obj: TObject; const LogFile: string; Append: Boolean = True): IVirtualMethodLogger; overload;
function LogVirtualMethodCalls(Obj: TObject): IVirtualMethodLogger; overload;

implementation

uses

  { TODO : must adapt to use log4d }

  System.SysUtils,
  Spring,
  Spring.Container,
  Spring.Container.Core,
  Spring.Container.Resolvers,
  MVCDemo.Registers.RegisterTypes;

const
  OWN_OUTPUT_TRUE = True;

  { TVirtualMethodLoggerImpl }



function LogVirtualMethodCalls(Obj: TObject; Output: TTextWriter;
  OwnOutput: Boolean = False): IVirtualMethodLogger; overload;
begin
  Result := Container.Resolve<IVirtualMethodLogger>([
    TNamedValue.Create('Obj', Obj),
    TNamedValue.Create('Output', Output),
    TNamedValue.Create('OwnOutput', OwnOutput)
    ]);
end;



function LogVirtualMethodCalls(Obj: TObject; const LogFile: string;
  Append: Boolean = True): IVirtualMethodLogger; overload;
begin
  Result := Container.Resolve<IVirtualMethodLogger>([
    TNamedValue.Create('Obj', Obj),
    TNamedValue.Create('Output', TStreamWriter.Create(LogFile, Append)),
    TNamedValue.Create('OwnOutput', OWN_OUTPUT_TRUE)
    ]);
end;



function LogVirtualMethodCalls(Obj: TObject): IVirtualMethodLogger; overload;
begin
//  Result := ServiceLocator.GetService<IVirtualMethodLogger>([TNamedValue.Create('Obj', Obj)]);
  Result := Container.Resolve<IVirtualMethodLogger>([TNamedValue.Create('Obj', Obj)]);
end;



constructor TVirtualMethodLoggerImpl.Create(Obj: TObject; Output: TTextWriter;
  OwnOutput: Boolean);
begin
  inherited Create;
  FObject               := Obj;
  FOutput               := Output;
  FOwnOutput            := OwnOutput;
  FInterceptor          := TVirtualMethodInterceptor.Create(Obj.ClassType);
  FInterceptor.OnBefore := procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out DoInvoke: Boolean; out Result: TValue)
    begin
      Output.Write(DateTimeToStr(Now));
      Output.WriteLine('%s.%s called with %d argument(s)', [Obj.ClassName, Method.Name, Length(Args)]);
    end;
  FInterceptor.OnException := procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out RaiseException: Boolean; AException: Exception; out Result: TValue)
    begin
      Output.WriteLine('Exception raised (' + AException.ClassName + '): ' + AException.Message);
    end;
  FInterceptor.Proxify(Obj);
end;



constructor TVirtualMethodLoggerImpl.Create(Obj: TObject);
begin
  inherited Create;

  FObject := Obj;
  FOwnOutput := False;

  FInterceptor          := TVirtualMethodInterceptor.Create(Obj.ClassType);
  FInterceptor.OnBefore := procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out DoInvoke: Boolean; out Result: TValue)
    begin
      TLogLogger.GetLogger(LOG4D_FWKMVC_SECTION).Trace(Format('%s.%s called with %d argument(s)', [Obj.ClassName, Method.Name, Length(Args)]));
    end;
  FInterceptor.OnAfter := procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; var Result: TValue)
    begin
      TLogLogger.GetLogger(LOG4D_FWKMVC_SECTION).Trace(Format('%s.%s finished', [Obj.ClassName, Method.Name]));
    end;
  FInterceptor.OnException := procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out RaiseException: Boolean; AException: Exception; out Result: TValue)
    begin
      TLogLogger.GetLogger(LOG4D_FWKMVC_SECTION).Error('Exception raised (' + AException.ClassName + ')' + Format(' %s.%s: %s', [Obj.ClassName, Method.Name, AException.Message]), AException);
    end;
  FInterceptor.Proxify(Obj);
end;



destructor TVirtualMethodLoggerImpl.Destroy;
begin
  StopLogging;
  inherited Destroy;
end;



procedure TVirtualMethodLoggerImpl.StopLogging(ObjectStillAlive: Boolean);
begin
  if FInterceptor = nil then
    Exit;
  try
    if ObjectStillAlive then
{$IF RTLVersion >= 23}
      FInterceptor.Unproxify(FObject);
{$ELSE}
      PPointer(FObject)^ := FInterceptor.OriginalClass;
{$IFEND}
    FreeAndNil(FInterceptor);
    if (Assigned(FOutput)) then
      FOutput.Flush;
  finally
    if FOwnOutput then
      FOutput.Free;
  end;
end;

end.
