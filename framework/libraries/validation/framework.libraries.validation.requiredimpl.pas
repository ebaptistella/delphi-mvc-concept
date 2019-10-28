unit Framework.Libraries.Validation.RequiredImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TRequiredImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_Required;
  public
    constructor Create(const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  Required = TRequiredImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TRequiredImpl }



constructor TRequiredImpl.Create(const ACustomErrorMessage: String);
begin
  CustomErrorMessage := ACustomErrorMessage;
end;



function TRequiredImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TRequiredImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := trim(AValue.AsString) <> EmptyStr;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
