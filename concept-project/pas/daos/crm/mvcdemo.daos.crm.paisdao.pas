unit MVCDemo.DAOs.CRM.PaisDAO;

interface

uses
  Framework.Libraries.DAO.GenericDAO,
  MVCDemo.Models.CRM.PaisModelImpl;

type
  IPaisDAO = interface(IGenericDAO<TPaisModelImpl>)
    ['{2510A833-DC93-4EA9-B48C-C4962C553134}']
  end;

implementation

end.
