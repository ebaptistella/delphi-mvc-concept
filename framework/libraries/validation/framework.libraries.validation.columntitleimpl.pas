unit Framework.Libraries.Validation.ColumnTitleImpl;

interface

type
  TColumnTitleImpl = class(TCustomAttribute)
  private
    FColumnTitle: String;
  public
    constructor Create(const AColumnTitle: String);
    function GetColumnTitle: String;
  end;

  ColumnTitle = TColumnTitleImpl;

implementation

{ TColumnTitleImpl }



constructor TColumnTitleImpl.Create(const AColumnTitle: String);
begin
  FColumnTitle := AColumnTitle;
end;



function TColumnTitleImpl.GetColumnTitle: String;
begin
  Result := FColumnTitle
end;

end.
