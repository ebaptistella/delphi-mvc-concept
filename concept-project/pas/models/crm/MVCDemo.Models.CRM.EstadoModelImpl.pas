unit MVCDemo.Models.CRM.EstadoModelImpl;

interface

uses
  MVCDemo.Models.CRM.EstadoModel,
  MVCDemo.Models.CRM.EstadoModelPKImpl,
  Spring.Persistence.Mapping.Attributes,
  Framework.Libraries.Validation.ValidatorImpl;

type
  TEstadoModelImpl = class(TEstadoModelPKImpl, IEstadoModel)
  private
    FDescricao: String;
    FDataExclusao: TDateTime;
    FDataManutencao: TDateTime;
    FDataCadastro: TDateTime;
    FCodigoUsuarioAlt: Integer;
    FCodigoPais: String;
  private
    procedure SetDescricao(const Value: String);
    procedure SetCodigoPais(const Value: String);
  protected
    procedure AddCustomValidation; override;
  public
    [Column('tx_estadonome', [cpNotNull, cpRequired], 30, 0, 0, 'NOME DO ESTADO')]
    [ColumnTitle('Descrição')]
    [Required, MinLength(3), MaxLength(40)]
    property Descricao: String read FDescricao write SetDescricao;

    [Column('cd_pais', [cpNotNull, cpRequired], 0, 'CÓDIGO DO PAÍS')]
    [ColumnTitle('País')]
    // [Required]
    property CodigoPais: String read FCodigoPais write SetCodigoPais;

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
  Spring.Persistence.Core.Session,
  Spring,
  System.SysUtils,
  Framework.Libraries.Validation.ResourceStrings,
  MVCDemo.Models.Base.UsuarioModel,
  MVCDemo.Models.Base.UsuarioModelPkImpl,
  MVCDemo.Models.CRM.PaisModel,
  MVCDemo.Models.CRM.PaisModelPkImpl;

{ TEstadoModelImpl }



procedure TEstadoModelImpl.SetCodigoPais(const Value: String);
begin
  if (FCodigoPais <> Value) then
  begin
    FCodigoPais := Value;
    NotifyPropertyChanged(Self, 'CodigoPais');
  end;
end;



procedure TEstadoModelImpl.SetDescricao(const Value: String);
begin
  if (FDescricao <> Value) then
  begin
    FDescricao := Value;
    NotifyPropertyChanged(Self, 'Descricao');
  end;
end;



procedure TEstadoModelImpl.AddCustomValidation;
begin
  inherited;

  Validate.AddExtend('CodigoPais', FCodigoPais, TResourceStringsValidator.RSValidation_DB_ValorNaoExiste,
    function(const AValue: TValue; const ASession: TSession): Boolean
    var
      oModel: IPaisModel;
    begin
      Result := True;

      if (AValue.AsString <> EmptyStr) then
      begin
        oModel := ASession.FindOne<TPaisModelPKImpl>(StrToIntDef(AValue.AsString, 0));
        Result := Assigned(oModel);
      end;
    end);
end;

end.
