unit MVCDemo.DAOs.CRM.MunicipioDAO;

interface

uses
  Framework.Libraries.DAO.GenericDAO,
  MVCDemo.Models.CRM.MunicipioModelImpl;

type
  IMunicipioDAO = interface(IGenericDAO<TMunicipioModelImpl>)
    ['{2510A833-DC93-4EA9-B48C-C4962C553134}']
  end;

implementation

end.
