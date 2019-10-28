unit MVCDemo.DAOs.CRM.MunicipioDAOImpl;

interface

uses
  Framework.Libraries.DAO.GenericDAOImpl,
  MVCDemo.Models.CRM.MunicipioModelImpl,
  MVCDemo.DAOs.CRM.MunicipioDAO;

type
  TMunicipioDAOImpl = class(TGenericDAOImpl<TMunicipioModelImpl>, IMunicipioDAO)
  public
    procedure Save(const AModel: TMunicipioModelImpl); override;
  end;

implementation

uses
  MVCDemo.Models.CRM.MunicipioModel,
  System.SysUtils;

{ TMunicipioDAOImpl }



procedure TMunicipioDAOImpl.Save(const AModel: TMunicipioModelImpl);
var
  oMunicipioModelImpl: IMunicipioModel;
begin
  Logger.Track(self.ClassType, 'Save');
  inherited;

  oMunicipioModelImpl     := Session.FindOne<TMunicipioModelImpl>(AModel.Codigo);
  AModel.CodigoUsuarioAlt := 1;
  if (not(Assigned(oMunicipioModelImpl))) then
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
