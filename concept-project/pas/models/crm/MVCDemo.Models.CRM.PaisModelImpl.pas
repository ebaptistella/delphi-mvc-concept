unit MVCDemo.Models.CRM.PaisModelImpl;

interface

uses
  Spring.Persistence.Mapping.Attributes,
  Spring.Container.Common,
  Framework.Libraries.Validation.ValidatorImpl,
  MVCDemo.Models.CRM.PaisModel,
  MVCDemo.Models.CRM.PaisModelPKImpl;

type
  TPaisModelImpl = class(TPaisModelPKImpl, IPaisModel)
  private
    FDescricao: string;
    FDataCadastro: TDateTime;
    FDataManutencao: TDateTime;
    FDataExclusao: TDateTime;
    FCodigoUsuarioAlt: Integer;
  private
    procedure SetDescricao(const Value: string);
  protected
    procedure AddCustomValidation; override;
  public
    [Column('tx_paisnome', [cpNotNull, cpRequired], 40, 0, 0, 'NOME DO PAÍS')]
    [ColumnTitle('Descrição')]
    [Required, MinLength(3), MaxLength(40)]
    property Descricao: string read FDescricao write SetDescricao;

    [Column('dt_cadastro', [cpNotNull, cpRequired, cpDontUpdate, cpHidden], 0, 'DATA DE CADASTRO')]
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;

    [Column('dt_manutencao', [cpNotNull, cpRequired, cpHidden], 0, 'DATA DE MANUTENÇÃO')]
    property DataManutencao: TDateTime read FDataManutencao write FDataManutencao;

    [Column('dt_exclusao', [cpHidden], 0, 'DATA DE EXCLUSÃO')]
    property DataExclusao: TDateTime read FDataExclusao write FDataExclusao;

    [Column('cd_usuarioalt', [cpHidden], 0, 'USUÁRIO RESPONSÁVEL PELA ALTERAÇÃO')]
    property CodigoUsuarioAlt: Integer read FCodigoUsuarioAlt write FCodigoUsuarioAlt;
  end;

implementation

uses
  DSharp.Bindings;

{ TPaisModelImpl }



procedure TPaisModelImpl.SetDescricao(const Value: string);
begin
  if (FDescricao <> Value) then
  begin
    FDescricao := Value;
    NotifyPropertyChanged(Self, 'Descricao');
  end;
end;



procedure TPaisModelImpl.AddCustomValidation;
begin
  inherited;
  //
end;

end.
