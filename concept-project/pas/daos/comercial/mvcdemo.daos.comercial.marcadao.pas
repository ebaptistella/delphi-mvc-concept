unit MVCDemo.DAOs.Comercial.MarcaDAO;

interface

uses
  Framework.Libraries.DAO.GenericDAO,
  MVCDemo.Models.Comercial.MarcaModelImpl;

type
  IMarcaDAO = interface(IGenericDAO<TMarcaModelImpl>)
    ['{F817FA29-9F41-4C2F-9FA5-78D357CBCA19}']
  end;

implementation

end.
