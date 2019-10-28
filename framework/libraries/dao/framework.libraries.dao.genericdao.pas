unit Framework.Libraries.DAO.GenericDAO;

interface

uses
  Framework.MVC.Model.BaseModel,
  Framework.Libraries.Persistence.ORMPersistence,
  Spring.Persistence.Core.Session;

type
  IGenericDAO<TModel: IMVCBaseModel> = interface(IORMPersistence<TModel>)
    ['{7C33F1DC-8F47-4FC7-8DFB-692698712C11}']
  end;

implementation

end.
