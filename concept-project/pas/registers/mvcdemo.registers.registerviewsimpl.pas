unit MVCDemo.Registers.RegisterViewsImpl;

interface

uses
  Spring.Container.Common,
  Framework.Libraries.InterfacedObjectLoggableImpl,
  Framework.Libraries.UI.ViewRegistryImpl;

type
  TRegisterViewsImpl = class(TInterfacedObjectLoggableImpl, IInvokable)
  private
    [Inject]
    FViewRegistryImpl: TViewRegistryImpl;
  public
    procedure Registry;
  end;

implementation

uses
  Vcl.Forms,
  MVCDemo.Registers.RegisterTypesImpl,
  MVCDemo.Views.CRM.PaisView,
  MVCDemo.Views.CRM.EstadoView,
  MVCDemo.Views.CRM.MunicipioView,
  MVCDemo.Views.Comercial.MarcaView;

{ TRegisterViewsImpl }



procedure TRegisterViewsImpl.Registry;
begin
  FViewRegistryImpl.Add(TFrmPaisView,
    function: TForm
    begin
      Result := Container.Resolve<TFrmPaisView>;
    end, True);

  FViewRegistryImpl.Add(TFrmEstadoView,
    function: TForm
    begin
      Result := Container.Resolve<TFrmEstadoView>;
    end, True);

  FViewRegistryImpl.Add(TFrmMunicipioView,
    function: TForm
    begin
      Result := Container.Resolve<TFrmMunicipioView>;
    end, True);

  FViewRegistryImpl.Add(TFrmMarcaView,
    function: TForm
    begin
      Result := Container.Resolve<TFrmMarcaView>;
    end, True);
end;

end.
