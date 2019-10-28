unit MVCDemo.Models.CRM.IBGEModelPKImpl;

interface

uses
  Framework.MVC.Model.BaseModelImpl,
  MVCDemo.Models.CRM.IBGEModel,
  Framework.Libraries.Validation.ValidatorImpl,
  Spring.Persistence.Mapping.Attributes;

type

  [Entity]
  [Table('TRSIBG01')]
  TIBGEModelPKImpl = class(TMVCBaseModelImpl, IIBGEModel)
  private
    FCodigo: Integer;
  private
    procedure SetCodigo(const Value: Integer);
  public
    [Column('cod', [cpRequired, cpPrimaryKey, cpNotNull], 0, 0, 0, 'CÓDIGO DO IBGE')]
    [ColumnTitle('Código')]
    [MaxValue(999999999)]
    property Codigo: Integer read FCodigo write SetCodigo;
  end;

implementation

uses
  DSharp.Bindings;

{ TIBGEModelPKImpl }



procedure TIBGEModelPKImpl.SetCodigo(const Value: Integer);
begin
  if (FCodigo <> Value) then
  begin
    FCodigo := Value;
    NotifyPropertyChanged(Self, 'Codigo');
  end;
end;

end.
