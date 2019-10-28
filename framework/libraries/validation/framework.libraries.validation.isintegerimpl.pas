unit Framework.Libraries.Validation.IsIntegerImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ResourceStrings;

type
  TIsIntegerImpl = class(TValidateCustomAttributeImpl, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_IsInteger;
  public
    constructor Create(const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  IsInteger = TIsIntegerImpl;

implementation

uses
  System.SysUtils,
  System.StrUtils;

{ TIsIntegerImpl }



constructor TIsIntegerImpl.Create(const ACustomErrorMessage: String);
begin
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsIntegerImpl.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TIsIntegerImpl.isValid(const AValue: TValue): Boolean;
var
  iInteger: Integer;
begin
  try
    iInteger := AValue.AsInteger;
    Result   := iInteger = AValue.AsInteger;
  except
    Result := False;
  end;
end;

end.
