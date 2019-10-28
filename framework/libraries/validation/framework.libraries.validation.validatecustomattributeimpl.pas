unit Framework.Libraries.Validation.ValidateCustomAttributeImpl;

interface

uses
  System.Rtti;

type
  TValidateCustomAttributeImpl = class(TCustomAttribute, IInvokable)
  private
    FCustomErrorMessage: String;
    FValue: TValue;
  protected
    const
    FORMAT_COLUMN_TITLE: String = '%s';
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    property CustomErrorMessage: String read FCustomErrorMessage write FCustomErrorMessage;
    property Value: TValue read FValue write FValue;
  end;

  TValidateCustomAttribute = TValidateCustomAttributeImpl;

implementation

{ TValidateCustomAttributeImpl }



function TValidateCustomAttributeImpl.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;



function TValidateCustomAttributeImpl._AddRef: Integer;
begin
  Result := +1;
end;



function TValidateCustomAttributeImpl._Release: Integer;
begin
  Result := -1;
end;

end.
