unit MVCDemo.DAOs.CRM.EstadoDAO;

interface

uses
  Framework.Libraries.DAO.GenericDAO,
  MVCDemo.Models.CRM.EstadoModelImpl;

type
  IEstadoDAO = interface(IGenericDAO<TEstadoModelImpl>)
    ['{33C6D0BC-9D08-401E-8287-85229B8A9715}']
  end;

implementation

end.
