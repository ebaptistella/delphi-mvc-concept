unit MVCDemo.Models.CRM.MunicipioModelImpl;

interface

uses
  Spring.Persistence.Mapping.Attributes,
  MVCDemo.Models.CRM.MunicipioModelPKImpl,
  MVCDemo.Models.CRM.MunicipioModel,
  Framework.Libraries.Validation.ValidatorImpl;

type
  TMunicipioModelImpl = class(TMunicipioModelPKImpl, IMunicipioModel)
  private
    FDescricao: String;
    FDescricaoReduzida: string;
    FCodigoEstado: string;
    FDataExclusao: TDateTime;
    FDataManutencao: TDateTime;
    FDataCadastro: TDateTime;
    FCodigoUsuarioAlt: Integer;
  private
    procedure SetDescricao(const Value: String);
    procedure SetDescricaoReduzida(const Value: string);
    procedure SetCodigoEstado(const Value: string);
  protected
    procedure AddCustomValidation; override;
  public
    [Column('tx_municipionome', [cpNotNull, cpRequired], 30, 0, 0, 'NOME DO MUNICÍPIO')]
    [ColumnTitle('Descrição')]
    [Required, MinLength(3), MaxLength(30)]
    property Descricao: String read FDescricao write SetDescricao;

    [Column('tx_nomereduzido', [], 10, 0, 0, 'NOME REDUZIDO DO MUNICÍPIO')]
    [ColumnTitle('Descrição reduzida')]
    [MaxLength(10)]
    property DescricaoReduzida: string read FDescricaoReduzida write SetDescricaoReduzida;

    [Column('cd_estado', [], 0, 0, 0, 'ESTADO')]
    [ColumnTitle('Estado')]
    [ExactLength(2)]
    property CodigoEstado: string read FCodigoEstado write SetCodigoEstado;

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
  DSharp.Bindings,
  System.RegularExpressions,
  System.SysUtils,
  Spring,
  Framework.Libraries.Validation.ResourceStrings,
  Spring.Persistence.Core.Session,
  MVCDemo.Models.CRM.EstadoModel,
  MVCDemo.Models.CRM.EstadoModelPKImpl,
  MVCDemo.Models.CRM.PaisModel,
  MVCDemo.Models.CRM.PaisModelPKImpl;

{ TMunicipioModelImpl }



procedure TMunicipioModelImpl.SetDescricao(const Value: String);
begin
  if (FDescricao <> Value) then
  begin
    FDescricao := Value;
    NotifyPropertyChanged(Self, 'Descricao');
  end;
end;



procedure TMunicipioModelImpl.SetDescricaoReduzida(const Value: string);
begin
  if (FDescricaoReduzida <> Value) then
  begin
    FDescricaoReduzida := Value;
    NotifyPropertyChanged(Self, 'DescricaoReduzida');
  end;
end;



procedure TMunicipioModelImpl.SetCodigoEstado(const Value: string);
begin
  if (FCodigoEstado <> Value) then
  begin
    FCodigoEstado := Value;
    NotifyPropertyChanged(Self, 'CodigoEstado');
  end;
end;



procedure TMunicipioModelImpl.AddCustomValidation;
begin
  inherited;

  Validate.AddExtend('CodigoEstado', FCodigoEstado, TResourceStringsValidator.RSValidation_DB_ValorNaoExiste,
    function(const AValue: TValue; const ASession: TSession): Boolean
    var
      oModel: IEstadoModel;
    begin
      Result := True;

      if (AValue.AsString <> EmptyStr) then
      begin
        oModel := ASession.FindOne<TEstadoModelPKImpl>(AValue.AsString);
        Result := Assigned(oModel);
      end;
    end);

end;

end.
