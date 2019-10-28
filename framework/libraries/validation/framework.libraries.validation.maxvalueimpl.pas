unit Framework.Libraries.Validation.MaxValueImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TMaxValueImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_MaxValue;
  private
    FMaxValue: Integer;
  public
    constructor Create(const AMaxValue: Integer); overload;
    constructor Create(const AMaxValue: Integer; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  MaxValue = TMaxValueImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TMaxValueImpl }



constructor TMaxValueImpl.Create(const AMaxValue: Integer);
begin
  FMaxValue := AMaxValue
end;



constructor TMaxValueImpl.Create(const AMaxValue: Integer; const ACustomErrorMessage: String);
begin
  FMaxValue          := AMaxValue;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMaxValueImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE, FMaxValue.ToString]);
end;



function TMaxValueImpl.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger <= FMaxValue;
    tkInt64:
      Result := AValue.AsInt64 <= FMaxValue;
    tkFloat:
      Result := AValue.AsExtended <= FMaxValue;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
