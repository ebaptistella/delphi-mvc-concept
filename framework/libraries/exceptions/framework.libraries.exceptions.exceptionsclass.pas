unit Framework.Libraries.Exceptions.ExceptionsClass;

interface

uses
  System.SysUtils;

type
  TMVCBaseModelException = class(Exception);
  TControllerException = class(Exception);
  TValidatorImplException = class(Exception);
  TViewFactoryException = class(Exception);
  TConnectionFactoryException = class(Exception);
  TNotificationServiceException = class(Exception);

implementation

end.
