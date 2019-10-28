unit MVCDemo.Models.Comercial.MarcaModelImpl;

interface

uses
  Spring.Persistence.Mapping.Attributes,
  Spring.Container.Common,
  Framework.Libraries.Validation.ValidatorImpl,
  MVCDemo.Models.Comercial.MarcaModelPKImpl,
  MVCDemo.Models.Comercial.MarcaModel;

type
  TMarcaModelImpl = class(TMarcaModelPKImpl, IMarcaModel)
  private
    FDescricao: string;
    FDataCadastro: TDateTime;
    FDataManutencao: TDateTime;
    FCodigoUsuarioAlt: Integer;
    FDescricaoReduzida: string;
    FDataExclusao: TDateTime;
  private
    procedure SetDescricao(const Value: string);
    procedure SetDescricaoReduzida(const Value: string);
  protected
    procedure AddCustomValidation; override;
  public
    [Column('tx_marcanome', [cpNotNull, cpRequired], 40, 0, 0, 'DESCRIÇÃO DA MARCA')]
    [ColumnTitle('Descrição')]
    [Required, MinLength(3), MaxLength(40)]
    property Descricao: string read FDescricao write SetDescricao;

    [Column('tx_nomereduzido', [cpNotNull, cpRequired], 10, 0, 0, 'DESCRIÇÃO REDUZIDA')]
    [ColumnTitle('Descrição reduzida')]
    [Required, MinLength(3), MaxLength(10)]
    property DescricaoReduzida: string read FDescricaoReduzida write SetDescricaoReduzida;

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

{ TMarcaModelImpl }



procedure TMarcaModelImpl.SetDescricao(const Value: string);
begin
  if (FDescricao <> Value) then
  begin
    FDescricao := Value;
    NotifyPropertyChanged(Self, 'Descricao');
  end;
end;



procedure TMarcaModelImpl.SetDescricaoReduzida(const Value: string);
begin
  if (FDescricaoReduzida <> Value) then
  begin
    FDescricaoReduzida := Value;
    NotifyPropertyChanged(Self, 'DescricaoReduzida');
  end;
end;



procedure TMarcaModelImpl.AddCustomValidation;
begin
  inherited;
  //
end;

end.
