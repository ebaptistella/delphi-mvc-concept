unit Framework.Libraries.Validation.RegexValidateImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TRegexValidateImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_RegexValidate;
  private
    FRegex: String;
  public
    constructor Create(const ARegex: String); overload;
    constructor Create(const ARegex: String; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  RegexValidate = TRegexValidateImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.RegularExpressions;

{ TRegexValidateImpl }



constructor TRegexValidateImpl.Create(const ARegex: String);
begin
  FRegex := ARegex;
end;



constructor TRegexValidateImpl.Create(const ARegex, ACustomErrorMessage: String);
begin
  FRegex             := ARegex;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TRegexValidateImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TRegexValidateImpl.isValid(const AValue: TValue): Boolean;
begin
  try
    if (AValue.AsString.Equals(EmptyStr)) then
      Exit(True);

    Result := TRegEx.IsMatch(AValue.AsString, FRegex);
  Except
    Result := False;
  end;
end;

end.
