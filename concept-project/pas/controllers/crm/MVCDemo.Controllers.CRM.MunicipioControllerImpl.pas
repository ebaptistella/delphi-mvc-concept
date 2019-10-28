unit MVCDemo.Controllers.CRM.MunicipioControllerImpl;

interface

uses
  System.Rtti,
  Vcl.ExtCtrls,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.MVC.Controller.ORMCRUDControllerImpl,
  MVCDemo.Models.CRM.MunicipioModelImpl,
  MVCDemo.Views.CRM.MunicipioView,
  MVCDemo.Controllers.CRM.MunicipioController;

type
  TMunicipioControllerImpl = class(TMVCORMCRUDControllerImpl<TMunicipioModelImpl, TFrmMunicipioView>, IMunicipioController)
  protected
    procedure Initialize; override;
  public
    function FindOne(const AId: TValue): Boolean; override;

    [IsNotified([byView])]
    procedure FndMunicipioConsult(const AEdtMunicipio: TLabeledEdit);

    [IsNotified([byView])]
    procedure FndEstadoConsult(const AEdtEstado: TLabeledEdit);
  end;

implementation

uses
  MVCDemo.Models.CRM.MunicipioModel, System.SysUtils;

{ TMunicipioControllerImpl }



procedure TMunicipioControllerImpl.Initialize;
begin
  inherited;

  NotificationService.Subscribe(Self, ['FndMunicipioConsult', 'FndEstadoConsult']).Observer(TFrmMunicipioView);
end;



function TMunicipioControllerImpl.FindOne(const AId: TValue): Boolean;
var
  iId: Integer;
  oModel: IMunicipioModel;
begin
  Result := inherited;

  iId := StrToIntDef(AId.AsString, 0);
  if (iId > 0) then
  begin
    oModel := DAO.Session.FindOne<TMunicipioModelImpl>(iId);
    Result := Assigned(oModel);

    if (Result) then
      FModel.CopyValuesFrom(oModel);
  end;
end;



procedure TMunicipioControllerImpl.FndEstadoConsult(const AEdtEstado: TLabeledEdit);
begin
  Logger.Track(Self, 'FndEstadoConsult');

end;



procedure TMunicipioControllerImpl.FndMunicipioConsult(const AEdtMunicipio: TLabeledEdit);
begin
  Logger.Track(Self, 'FndMunicipioConsult');

  Self.FindOne(AEdtMunicipio.Text);
end;

end.
