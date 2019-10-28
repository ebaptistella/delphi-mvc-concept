unit Framework.Libraries.Validation.MinValueImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TMinValueImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_MinValue;
  private
    FMinValue: Integer;
  public
    constructor Create(const AMinValue: Integer); overload;
    constructor Create(const AMinValue: Integer; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  MinValue = TMinValueImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TMinValueImpl }



constructor TMinValueImpl.Create(const AMinValue: Integer);
begin
  FMinValue := AMinValue;
end;



constructor TMinValueImpl.Create(const AMinValue: Integer; const ACustomErrorMessage: String);
begin
  FMinValue          := AMinValue;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMinValueImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE, FMinValue.ToString]);
end;



function TMinValueImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger >= FMinValue;
    tkInt64:
      Result := AValue.AsInt64 >= FMinValue;
    tkFloat:
      Result := AValue.AsExtended >= FMinValue;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
