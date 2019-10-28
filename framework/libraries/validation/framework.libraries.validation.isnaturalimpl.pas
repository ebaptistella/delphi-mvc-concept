unit Framework.Libraries.Validation.IsNaturalImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TIsNaturalImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_IsNatural;
  public
    constructor Create(const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  IsNatural = TIsNaturalImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo,
  System.Variants,
  System.RegularExpressions;

{ TIsNaturalImpl }



constructor TIsNaturalImpl.Create(const ACustomErrorMessage: String);
begin
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsNaturalImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TIsNaturalImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger > -1;
    tkInt64:
      Result := AValue.AsInt64 > -1;
    tkString, tkUString:
      begin
        // considera EmptyStr como Zero
        Result := AValue.AsString = EmptyStr;
        if (not(Result)) then
        begin
          Result := TRegEx.IsMatch(AValue.AsString, '^([0-9])*$');
          if (Result) then
            Result := StrToInt(AValue.AsString) > -1;
        end;
      end
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
