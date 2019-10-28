unit MVCDemo.DAOs.Comercial.MarcaDAOImpl;

interface

uses
  Framework.Libraries.DAO.GenericDAOImpl,
  MVCDemo.Models.Comercial.MarcaModelImpl,
  MVCDemo.DAOs.Comercial.MarcaDAO;

type
  TMarcaDAOImpl = class(TGenericDAOImpl<TMarcaModelImpl>, IMarcaDAO)
  public
    procedure Save(const AModel: TMarcaModelImpl); override;
  end;

implementation

uses
  System.SysUtils,
  MVCDemo.Models.Comercial.MarcaModel;

{ TMarcaDAOImpl }



procedure TMarcaDAOImpl.Save(const AModel: TMarcaModelImpl);
var
  oMarcaModelImpl: IMarcaModel;
begin
  Logger.Track(self.ClassType, 'Save');
  inherited;

  oMarcaModelImpl         := Session.FindOne<TMarcaModelImpl>(AModel.Codigo);
  AModel.CodigoUsuarioAlt := 1;
  if (not(Assigned(oMarcaModelImpl))) then
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
