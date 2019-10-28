unit Framework.Libraries.Validation.ValidEmailImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TValidEmailImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_ValidEmail;
  public
    constructor Create(ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  ValidEmail = TValidEmailImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.RegularExpressions;

{ TValidEmailImpl }



constructor TValidEmailImpl.Create(ACustomErrorMessage: String);
begin
  CustomErrorMessage := ACustomErrorMessage;
end;



function TValidEmailImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TValidEmailImpl.isValid(const AValue: TValue): Boolean;
const
  EMAIL_REGEX: String = '^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[\w-\.]*[a-zA-Z0-9]\.[a-zA-Z]{2,7}$';
begin
  try
    if (AValue.AsString.Equals(EmptyStr)) then
      Exit(True);

    Result := TRegEx.IsMatch(AValue.AsString, EMAIL_REGEX);
  Except
    Result := False;
  end;
end;

end.
