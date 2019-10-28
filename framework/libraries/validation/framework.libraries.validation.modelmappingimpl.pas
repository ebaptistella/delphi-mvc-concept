unit Framework.Libraries.Validation.ModelMappingImpl;

interface

type
  TModelMappingImpl = class(TCustomAttribute)
  private
    FModelPropertyName: String;
  public
    function GetModelPropertyName: String;

    constructor Create(const AModelPropertyName: String);

    property ModelPropertyName: String read GetModelPropertyName;
  end;

  ModelMapping = TModelMappingImpl;

implementation

{ TModelMappingImpl }



constructor TModelMappingImpl.Create(const AModelPropertyName: String);
begin
  FModelPropertyName := AModelPropertyName;
end;



function TModelMappingImpl.GetModelPropertyName: String;
begin
  Result := FModelPropertyName;
end;

end.
