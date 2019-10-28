unit MVCDemo.Controllers.Comercial.MarcaControllerImpl;

interface

uses
  System.Rtti,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.MVC.Controller.ORMCRUDControllerImpl,
  MVCDemo.Models.Comercial.MarcaModelImpl,
  MVCDemo.Views.Comercial.MarcaView,
  MVCDemo.Controllers.Comercial.MarcaController,
  Vcl.ExtCtrls;

type
  TMarcaControllerImpl = class(TMVCORMCRUDControllerImpl<TMarcaModelImpl, TFrmMarcaView>, IMarcaController)
  protected
    procedure Initialize; override;
  public
    function FindOne(const AId: TValue): Boolean; override;

    [IsNotified([byView])]
    procedure FndMarcaConsult(const AEdtMarca: TLabeledEdit);
  end;

implementation

uses
  MVCDemo.Models.Comercial.MarcaModel,
  System.SysUtils;

{ TMarcaControllerImpl }



procedure TMarcaControllerImpl.Initialize;
begin
  inherited;

  NotificationService.Subscribe(Self, ['FndMarcaConsult']).Observer(TFrmMarcaView);
end;



function TMarcaControllerImpl.FindOne(const AId: TValue): Boolean;
var
  iId: Integer;
  oModel: IMarcaModel;
begin
  Result := inherited;

  iId := StrToIntDef(AId.AsString, 0);
  if (iId > 0) then
  begin
    oModel := DAO.Session.FindOne<TMarcaModelImpl>(iId);
    Result := Assigned(oModel);

    if (Result) then
    begin
      FModel.CopyValuesFrom(oModel);
    end
  end;
end;



procedure TMarcaControllerImpl.FndMarcaConsult(const AEdtMarca: TLabeledEdit);
begin
  Logger.Track(Self, 'FndMarcaConsult');

  Self.FindOne(AEdtMarca.Text);
end;

end.
