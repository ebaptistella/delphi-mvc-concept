unit MVCDemo.Models.CRM.EstadoModelPKImpl;

interface

uses
  Framework.MVC.Model.BaseModelImpl,
  MVCDemo.Models.CRM.EstadoModel,
  Framework.Libraries.Validation.ValidatorImpl,
  Spring.Persistence.Mapping.Attributes;

type

  [Entity]
  [Table('tb_estado')]
  TEstadoModelPKImpl = class(TMVCBaseModelImpl, IEstadoModel)
  private
    FCodigo: string;
  private
    procedure SetCodigo(const Value: string);
  public
    [Column('id_estado', [cpRequired, cpPrimaryKey, cpNotNull], 0, 0, 0, 'CÓDIGO DO ESTADO')]
    [ColumnTitle('Código')]
    [Required, ExactLength(2)]
    property Codigo: string read FCodigo write SetCodigo;
  end;

implementation

uses
  DSharp.Bindings;

{ TEstadoModelPKImpl }



procedure TEstadoModelPKImpl.SetCodigo(const Value: string);
begin
  if (FCodigo <> Value) then
  begin
    FCodigo := Value;
    NotifyPropertyChanged(Self, 'Codigo');
  end;
end;

end.
