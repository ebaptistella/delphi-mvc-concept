unit MVCDemo.DAOs.CRM.PaisDAOImpl;

interface

uses
  Framework.Libraries.DAO.GenericDAOImpl,
  MVCDemo.Models.CRM.PaisModelImpl,
  MVCDemo.DAOs.CRM.PaisDAO;

type
  TPaisDAOImpl = class(TGenericDAOImpl<TPaisModelImpl>, IPaisDAO)
  public
    procedure Save(const AModel: TPaisModelImpl); override;
  end;

implementation

uses
  System.SysUtils,
  MVCDemo.Models.CRM.PaisModel;

{ TPaisDAOImpl }



procedure TPaisDAOImpl.Save(const AModel: TPaisModelImpl);
var
  oPaisModelImpl: IPaisModel;
begin
  Logger.Track(self.ClassType, 'Save');
  inherited;

  oPaisModelImpl          := Session.FindOne<TPaisModelImpl>(AModel.Codigo);
  AModel.CodigoUsuarioAlt := 1;
  if (not(Assigned(oPaisModelImpl))) then
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
