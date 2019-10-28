unit Framework.Libraries.Validation.MaxLengthImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TMaxLengthImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_MaxLength;
  private
    FMaxLength: Integer;
  public
    constructor Create(const AMaxLength: Integer); overload;
    constructor Create(const AMaxLength: Integer; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  MaxLength = TMaxLengthImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TMaxLengthImpl }



constructor TMaxLengthImpl.Create(const AMaxLength: Integer);
begin
  FMaxLength := AMaxLength;
end;



constructor TMaxLengthImpl.Create(const AMaxLength: Integer; const ACustomErrorMessage: String);
begin
  FMaxLength         := AMaxLength;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMaxLengthImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE, FMaxLength.ToString]);
end;



function TMaxLengthImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      begin
        if (AValue.AsString.Equals(EmptyStr)) then
          Exit(True);

        Result := Length(AValue.AsString) <= FMaxLength;
      end
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
