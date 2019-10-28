unit Framework.Libraries.Validation.IsNaturalNoZeroImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TIsNaturalNoZeroImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_IsNaturalNoZero;
  public
    constructor Create(const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  IsNaturalNoZero = TIsNaturalNoZeroImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo,
  System.RegularExpressions;

{ TIsNaturalNoZeroImpl }



constructor TIsNaturalNoZeroImpl.Create(const ACustomErrorMessage: String);
begin
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsNaturalNoZeroImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TIsNaturalNoZeroImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger > 0;
    tkInt64:
      Result := AValue.AsInt64 > 0;
    tkString, tkUString:
      begin
        Result := TRegEx.IsMatch(AValue.AsString, '^([0-9])*$');
        if (Result) then
          Result := StrToInt(AValue.AsString) > -1;
      end
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
