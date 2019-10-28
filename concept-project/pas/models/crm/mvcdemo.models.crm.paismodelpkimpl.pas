unit MVCDemo.Models.CRM.PaisModelPKImpl;

interface

uses
  Spring.Persistence.Mapping.Attributes,
  Spring.Container.Common,
  Framework.MVC.Model.BaseModelImpl,
  MVCDemo.Models.CRM.PaisModel,
  Framework.Libraries.Validation.ValidatorImpl;

type

  [Entity]
  [Table('tb_pais')]
  [Sequence('gen_pais', 1, 1)]
  TPaisModelPKImpl = class(TMVCBaseModelImpl, IPaisModel)
  private
    FCodigo: Integer;
  private
    procedure SetCodigo(const Value: Integer);
  public
    [Column('id_pais', [cpRequired, cpPrimaryKey, cpNotNull], 0, 0, 0, 'C�DIGO DO PA�S')]
    [ColumnTitle('C�digo')]
    [IsNaturalNoZero]
    // [AutoGenerated]
    property Codigo: Integer read FCodigo write SetCodigo;
  end;

implementation

uses
  DSharp.Bindings;

{ TPaisModelPKImpl }



procedure TPaisModelPKImpl.SetCodigo(const Value: Integer);
begin
  if (FCodigo <> Value) then
  begin
    FCodigo := Value;
    NotifyPropertyChanged(Self, 'Codigo');
  end;
end;

end.
