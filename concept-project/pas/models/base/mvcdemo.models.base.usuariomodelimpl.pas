unit MVCDemo.Models.Base.UsuarioModelImpl;

interface

uses
  Spring.Persistence.Mapping.Attributes,
  Spring.Container.Common,
  Framework.Libraries.Validation.ValidatorImpl,
  MVCDemo.Models.Base.UsuarioModelPKImpl,
  MVCDemo.Models.Base.UsuarioModel;

type
  TUsuarioModelImpl = class(TUsuarioModelPKImpl, IUsuarioModel)
  private
    FNome: string;
    FEmail: string;
    FDataCadastro: TDateTime;
    FDataManutencao: TDateTime;
    FCodigoUsuarioAlt: Integer;
  private
    procedure SetNome(const Value: string);
    procedure SetEmail(const Value: string);
  protected
    procedure AddCustomValidation; override;
  public
    [Column('tx_usuarionome', [cpNotNull, cpRequired], 40, 0, 0, 'NOME DO USUÁRIO')]
    [ColumnTitle('Nome')]
    [Required, MinLength(3), MaxLength(40)]
    property Nome: string read FNome write SetNome;

    [Column('tx_email', [cpNotNull, cpRequired], 100, 0, 0, 'E-MAIL')]
    [ColumnTitle('E-Mail')]
    [Required, MinLength(3), MaxLength(100)]
    property Email: string read FEmail write SetEmail;

    [Column('dt_cadastro', [cpNotNull, cpRequired, cpDontUpdate, cpHidden], 0, 'DATA DE CADASTRO')]
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;

    [Column('dt_manutencao', [cpNotNull, cpRequired, cpHidden], 0, 'DATA DE MANUTENÇÃO')]
    property DataManutencao: TDateTime read FDataManutencao write FDataManutencao;

    [Column('cd_usuarioalt', [cpHidden], 0, 'USUÁRIO RESPONSÁVEL PELA ALTERAÇÃO')]
    property CodigoUsuarioAlt: Integer read FCodigoUsuarioAlt write FCodigoUsuarioAlt;
  end;

implementation

uses
  DSharp.Bindings;

{ TUsuarioModelImpl }



procedure TUsuarioModelImpl.SetNome(const Value: string);
begin
  if (FNome <> Value) then
  begin
    FNome := Value;
    NotifyPropertyChanged(Self, 'Nome');
  end;
end;



procedure TUsuarioModelImpl.SetEmail(const Value: string);
begin
  if (FEmail <> Value) then
  begin
    FEmail := Value;
    NotifyPropertyChanged(Self, 'Email');
  end;
end;



procedure TUsuarioModelImpl.AddCustomValidation;
begin
  inherited;

end;

end.
