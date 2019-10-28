unit MVCDemo.Models.CRM.SPEDECFPaisesModelImpl;

interface

uses
  MVCDemo.Models.CRM.SpedECFPaisesModel,
  MVCDemo.Models.CRM.SPEDECFPaisesModelPKImpl,
  Framework.Libraries.Validation.ValidatorImpl,
  Spring.Persistence.Mapping.Attributes;

type
  TSPEDECFPaisesModelImpl = class(TSPEDECFPaisesModelPKImpl, ISPEDECFPaisesModel)
  private
    FDescricao: string;
    FDataFinal: TDateTime;
    FDataInicial: TDateTime;
  private
    procedure SetDescricao(const Value: string);
  public
    [Column('TX_DESCRICAO', [], 50, 0, 0, 'DESCRIÇÃO DO PAÍS SPED ECF')]
    [ColumnTitle('Descrição')]
    [MaxLength(50)]
    property Descricao: string read FDescricao write SetDescricao;

    [Column('DT_INICIAL', [cpHidden], 0, 'DATA INICIAL')]
    property DataInicial: TDateTime read FDataInicial write FDataInicial;

    [Column('DT_FINAL', [cpHidden], 0, 'DATA FINAL')]
    property DataFinal: TDateTime read FDataFinal write FDataFinal;
  end;

implementation

uses
  DSharp.Bindings;

{ TSPEDECFPaisesModelImpl }



procedure TSPEDECFPaisesModelImpl.SetDescricao(const Value: string);
begin
  if (FDescricao <> Value) then
  begin
    FDescricao := Value;
    NotifyPropertyChanged(Self, 'Descricao');
  end;
end;

end.
