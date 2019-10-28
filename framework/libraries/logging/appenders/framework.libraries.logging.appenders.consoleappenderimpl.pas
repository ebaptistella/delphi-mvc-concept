unit Framework.Libraries.Logging.Appenders.ConsoleAppenderImpl;

interface

uses
  Spring.Logging.Appenders;

type
  TFrameworkLoggingConsoleAppenderImpl = class(TTextLogAppender)
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Winapi.Windows;

{ TFrameworkLoggingConsoleAppenderImpl }



procedure TFrameworkLoggingConsoleAppenderImpl.AfterConstruction;
begin
  inherited;
  AllocConsole;
end;

end.
