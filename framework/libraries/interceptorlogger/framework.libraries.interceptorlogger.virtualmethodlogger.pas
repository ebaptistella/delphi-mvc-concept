unit Framework.Libraries.InterceptorLogger.VirtualMethodLogger;

interface

uses
  SysUtils,
  Classes,
  TypInfo,
  RTTI;

type
  IVirtualMethodLogger = interface(IInvokable)
    ['{6A7813CB-A41F-4186-94A0-E83440AB5A1F}']
    procedure StopLogging(ObjectStillAlive: Boolean = True);
  end;

implementation

end.
