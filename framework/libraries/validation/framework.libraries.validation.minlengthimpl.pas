unit Framework.Libraries.Validation.MinLengthImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TMinLengthImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_MinLength;
  private
    FMinLength: Integer;
  public
    constructor Create(const AMinLength: Integer); overload;
    constructor Create(const AMinLength: Integer; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  MinLength = TMinLengthImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TMinLengthImpl }



constructor TMinLengthImpl.Create(const AMinLength: Integer);
begin
  FMinLength := AMinLength;
end;



constructor TMinLengthImpl.Create(const AMinLength: Integer; const ACustomErrorMessage: String);
begin
  FMinLength         := AMinLength;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMinLengthImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE, FMinLength.ToString]);
end;



function TMinLengthImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      begin
        if (AValue.AsString.Equals(EmptyStr)) then
          Exit(True);

        Result := Length(AValue.AsString) >= FMinLength;
      end
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
