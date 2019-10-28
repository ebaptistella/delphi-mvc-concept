unit Framework.Libraries.Validation.ExtendValidationImpl;

interface

uses
  System.Rtti;

type
  TExtendValidationImpl = record
    AttributeName: String;
    Value: TValue;
    ErrorMessage: string;

    constructor Create(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String);
  end;

  ExtendValidation = TExtendValidationImpl;

implementation

{ TExtendValidationImpl }



constructor TExtendValidationImpl.Create(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String);
begin
  AttributeName := AAttributeName;
  Value         := AValue;
  ErrorMessage  := AErrorMessage
end;

end.
