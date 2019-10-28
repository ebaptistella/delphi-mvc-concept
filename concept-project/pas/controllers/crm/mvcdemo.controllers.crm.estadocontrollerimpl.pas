unit MVCDemo.Controllers.CRM.EstadoControllerImpl;

interface

uses
  Vcl.Forms,
  System.Rtti,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.MVC.Model.BaseModel,
  Framework.MVC.Controller.Initializable,
  Framework.MVC.Controller.ORMCRUDControllerImpl,
  MVCDemo.Controllers.CRM.EstadoController,
  Framework.MVC.Model.BaseModelImpl,
  Vcl.ExtCtrls;

resourcestring
  R_MODELO_NAO_IDENTIFICADO = 'Modelo %s não identificado para realizar a consulta';

type
  TEstadoControllerImpl<TModel: IMVCBaseModel; TView: TForm> = class(TMVCORMCRUDControllerImpl<TModel, TView>, IMVCInitializable, IEstadoController<TModel, TView>)
  protected
    procedure Initialize; override;
  public
    function FindOne(const AId: TValue): Boolean; override;

    [IsNotified([byView])]
    procedure FndEstadoConsult(const AEdtEstado: TLabeledEdit);

    [IsNotified([byView])]
    procedure FndPaisConsult(const AEdtPais: TLabeledEdit);
  end;

implementation

uses
  System.SysUtils,
  Framework.Libraries.Exceptions.ExceptionsClass,
  MVCDemo.Models.CRM.EstadoModelImpl,
  MVCDemo.Views.CRM.EstadoView;

{ TEstadoControllerImpl<TModel, TView> }



procedure TEstadoControllerImpl<TModel, TView>.Initialize;
begin
  inherited;

  NotificationService.Subscribe(Self, ['FndEstadoConsult', 'FndPaisConsult']).Observer(TFrmEstadoView);
end;



function TEstadoControllerImpl<TModel, TView>.FindOne(const AId: TValue): Boolean;
var
  oModel: TModel;
begin
  Result := inherited;

  if (AId.ToString <> EmptyStr) then
  begin
    try
      if (FModel is TEstadoModelImpl) then
        oModel := DAO.Session.FindOne<TEstadoModelImpl>(AId.AsString)
      else
        raise TControllerException.CreateResFmt(@R_MODELO_NAO_IDENTIFICADO, [TValue.From<TModel>(Model).AsObject.ClassName]);

      Result := Assigned(oModel);

      if (Result) then
        FModel.CopyValuesFrom(oModel);
    finally
      FreeAndNil(oModel);
    end;
  end;
end;



procedure TEstadoControllerImpl<TModel, TView>.FndEstadoConsult(const AEdtEstado: TLabeledEdit);
begin
  Logger.Track(Self, 'FndEstadoConsult');

  Self.FindOne(AEdtEstado.Text);
end;



procedure TEstadoControllerImpl<TModel, TView>.FndPaisConsult(
  const AEdtPais: TLabeledEdit);
begin
  Logger.Track(Self, 'FndPaisConsult');

end;

end.
