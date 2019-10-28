unit Framework.Libraries.Validation.ExactLengthImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TExactLengthImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_ExactLength;
  private
    FExactLength: Integer;
  public
    constructor Create(const AExactLength: Integer); overload;
    constructor Create(const AExactLength: Integer; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  ExactLength = TExactLengthImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TExactLengthImpl }



constructor TExactLengthImpl.Create(const AExactLength: Integer);
begin
  FExactLength := AExactLength;
end;



constructor TExactLengthImpl.Create(const AExactLength: Integer; const ACustomErrorMessage: String);
begin
  FExactLength       := AExactLength;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TExactLengthImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE, FExactLength.ToString]);
end;



function TExactLengthImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      begin
        if (AValue.AsString.Equals(EmptyStr)) then
          Exit(True);

        Result := Length(AValue.AsString) = FExactLength;
      end
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
