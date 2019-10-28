unit Framework.Libraries.Logging.LoggingInitializeImpl;

interface

uses
  Spring.Container;

type
  TFrameworkLoggingInitializeImpl = class(TInterfacedObject, IInvokable)
  private
    procedure LogDirectory;
    procedure LogDefaultConfiguration;
  public
    constructor Create(const AContainer: TContainer); reintroduce;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  Spring.Logging,
  Spring.Logging.Appenders,
  Spring.Logging.Configuration,
  Spring.Logging.Configuration.Builder,
  Framework.Libraries.Logging.Appenders.ConsoleAppenderImpl;

const
  LOG_CONFIGURE = 'logconfiguration.cfg';
  LOG_PATH = 'AppLogs';
  LOG_FORMAT_DATE = 'yyyy-mm-dd hh:MM:ss-zzz';

  { TFrameworkLoggingInitializeImpl }



constructor TFrameworkLoggingInitializeImpl.Create(const AContainer: TContainer);
begin
  Self.LogDirectory;
  Self.LogDefaultConfiguration;
  TLoggingConfiguration.LoadFromFile(AContainer, ExtractFilePath(ParamStr(0)) + PathDelim + LOG_PATH + PathDelim + LOG_CONFIGURE);
  AContainer.Build;
end;



procedure TFrameworkLoggingInitializeImpl.LogDefaultConfiguration;
var
  sConfig: String;
begin
  if not(FileExists(ExtractFilePath(ParamStr(0)) + PathDelim + LOG_PATH + PathDelim + LOG_CONFIGURE)) then
  begin
    sConfig := TLoggingConfigurationBuilder.Create
      .BeginController
      .AddAppender('file')
    // .AddAppender('console')
      .EndController
      .BeginAppender('file', TFileLogAppender)
      .Enabled(True)
      .Levels([TLogLevel.Warn, TLogLevel.Error, TLogLevel.Fatal])
    // .EntryTypes([TLogEntryType.Text, TLogEntryType.Value, TLogEntryType.CallStack, TLogEntryType.SerializedData, TLogEntryType.Entering, TLogEntryType.Leaving])
      .Prop('Format', LOG_FORMAT_DATE)
      .Prop('FileName', LOG_PATH + PathDelim + ReplaceText(ExtractFileName(ParamStr(0)), ExtractFileExt(ParamStr(0)), EmptyStr).ToLower + '-logfile.log')
      .EndAppender
      .BeginAppender('console', TFrameworkLoggingConsoleAppenderImpl)
      .Enabled(False)
      .Levels([TLogLevel.Warn, TLogLevel.Error, TLogLevel.Fatal])
    // .EntryTypes([TLogEntryType.Text, TLogEntryType.Value, TLogEntryType.CallStack, TLogEntryType.SerializedData, TLogEntryType.Entering, TLogEntryType.Leaving])
      .Prop('Format', LOG_FORMAT_DATE)
      .EndAppender.ToString;

    with TStringStream.Create do
      try
        WriteString(sConfig);
        SaveToFile(ExtractFilePath(ParamStr(0)) + PathDelim + LOG_PATH + PathDelim + LOG_CONFIGURE);
      finally
        Free;
      end;
  end;

end;



procedure TFrameworkLoggingInitializeImpl.LogDirectory;
begin
  if (not(DirectoryExists(ExtractFilePath(ParamStr(0)) + PathDelim + LOG_PATH))) then
    CreateDir(ExtractFilePath(ParamStr(0)) + PathDelim + LOG_PATH);
end;

end.
