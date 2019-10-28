unit Framework.Libraries.DAO.GenericDAOImpl;

interface

uses
  Framework.Libraries.Persistence.ORMPersistenceImpl,
  Framework.Libraries.DAO.GenericDAO,
  Framework.MVC.Model.BaseModel;

type
  TGenericDAOImpl<TModel: IMVCBaseModel> = class(TORMPersistenceImpl<TModel>, IGenericDAO<TModel>)
  end;

implementation

end.
