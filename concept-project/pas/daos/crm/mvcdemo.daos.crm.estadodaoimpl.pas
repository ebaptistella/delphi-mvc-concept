unit MVCDemo.DAOs.CRM.EstadoDAOImpl;

interface

uses
  Framework.Libraries.DAO.GenericDAOImpl,
  MVCDemo.Models.CRM.EstadoModelImpl,
  MVCDemo.DAOs.CRM.EstadoDAO;

type
  TEstadoDAOImpl = class(TGenericDAOImpl<TEstadoModelImpl>, IEstadoDAO)
  public
    procedure Save(const AModel: TEstadoModelImpl); override;
  end;

implementation

uses
  MVCDemo.Models.CRM.EstadoModel,
  System.SysUtils;

{ TEstadoDAOImpl }



procedure TEstadoDAOImpl.Save(const AModel: TEstadoModelImpl);
var
  oEstadoModelImpl: IEstadoModel;
begin
  Logger.Track(self.ClassType, 'Save');
  inherited;

  oEstadoModelImpl        := Session.FindOne<TEstadoModelImpl>(AModel.Codigo);
  AModel.CodigoUsuarioAlt := 1;
  if (not(Assigned(oEstadoModelImpl))) then
  begin
    AModel.DataCadastro   := now;
    AModel.DataManutencao := now;
    self.Insert(AModel);
  end
  else
  begin
    AModel.DataManutencao := now;
    self.Update(AModel);
  end;
end;

end.
