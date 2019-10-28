unit MVCDemo.Controllers.CRM.PaisControllerImpl;

interface

uses
  Framework.MVC.Controller.ORMCRUDControllerImpl,
  Framework.Libraries.Notification.NotificationServiceImpl,
  MVCDemo.Controllers.CRM.PaisController,
  MVCDemo.Models.CRM.PaisModelImpl,
  MVCDemo.Views.CRM.PaisView,
  Vcl.ExtCtrls,
  System.Rtti;

type
  TPaisControllerImpl = class(TMVCORMCRUDControllerImpl<TPaisModelImpl, TFrmPaisView>, IPaisController)
  protected
    procedure Initialize; override;
  public
    function FindOne(const AId: TValue): Boolean; override;

    [IsNotified([byView])]
    procedure FndPaisConsult(const AEdtPais: TLabeledEdit);
  end;

implementation

uses
  MVCDemo.Models.CRM.PaisModel,
  System.SysUtils;

{ TPaisControllerImpl }



procedure TPaisControllerImpl.Initialize;
begin
  inherited;

  NotificationService.Subscribe(Self, ['FndPaisConsult']).Observer(TFrmPaisView);
end;



function TPaisControllerImpl.FindOne(const AId: TValue): Boolean;
var
  iId: Integer;
  oModel: IPaisModel;
begin
  Result := inherited;

  iId := StrToIntDef(AId.AsString, 0);
  if (iId > 0) then
  begin
    oModel := DAO.Session.FindOne<TPaisModelImpl>(iId);
    Result := Assigned(oModel);

    if (Result) then
    begin
      FModel.CopyValuesFrom(oModel);

      // ou faço de forma manual se não usar bindings
      // FModel.Codigo    := TPaisModelImpl(oModel).Codigo;
      // FModel.Descricao := TPaisModelImpl(oModel).Descricao;
      // FModel.CodigoRFB := TPaisModelImpl(oModel).CodigoRFB;
      // TFrmPaisView(View).DoUpdateView;
    end
    {
      // caso queira notificar a view de que o registro não foi encontrado
      else
      NotifyModelObservers(nmsWarning, 'Registro não encontrado!');
    }
  end;
end;



procedure TPaisControllerImpl.FndPaisConsult(const AEdtPais: TLabeledEdit);
begin
  Logger.Track(Self, 'FndPaisConsult');

  Self.FindOne(AEdtPais.Text);
end;

end.
