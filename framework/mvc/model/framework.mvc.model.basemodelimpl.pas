unit Framework.MVC.Model.BaseModelImpl;

interface

uses
  Vcl.Controls,
  Vcl.Forms,
  Spring.Container.Common,
  Framework.MVC.Model.BaseModel,
  Framework.Libraries.Validation.Validator;

type
  PMVCBaseModelImpl = ^TMVCBaseModelImpl;

  TMVCBaseModelImpl = class(TInterfacedObject, IMVCBaseModel)
  private
    [Inject]
    FValidate: IValidator;
  private
    procedure DoInternalCopyValues(const AFrom: TMVCBaseModelImpl; const ATo: IMVCBaseModel);
    function GetValidate: IValidator;
  protected
    procedure AddCustomValidation; virtual;
  public
    procedure CopyValuesFrom(const AModel: IMVCBaseModel);
    function IsValid(const AView: TForm; const AControl: TWinControl): Boolean;

    property Validate: IValidator read GetValidate;
  end;

implementation

uses
  Framework.Libraries.Exceptions.ExceptionsClass,
  System.Rtti,
  System.SysUtils,
  System.TypInfo;

{ TMVCBaseModelImpl }



procedure TMVCBaseModelImpl.DoInternalCopyValues(const AFrom: TMVCBaseModelImpl; const ATo: IMVCBaseModel);
var
  oRttiContext: TRttiContext;

  oRttiTypeFrom: TRttiType;
  oRttiTypeTo: TRttiType;

  oRttiPropertyFrom: TRttiProperty;
  oRttiPropertyTo: TRttiProperty;
begin
  if (AFrom.ClassType <> (ATo as TObject).ClassType) then
    raise TMVCBaseModelException.CreateFmt('From class (%s) is different of the To class (%s)', [(ATo as TObject).ClassName, AFrom.ClassName]);

  oRttiTypeFrom := oRttiContext.GetType((ATo as TObject).ClassType);
  oRttiTypeTo   := oRttiContext.GetType(AFrom.ClassType);

  for oRttiPropertyFrom in oRttiTypeFrom.GetProperties do
  begin
    if (oRttiPropertyFrom.PropertyType.TypeKind in [tkClass, tkRecord]) then
      raise TMVCBaseModelException.CreateFmt('Copy value from %s not implemented!', [oRttiPropertyFrom.PropertyType.QualifiedName]);

    if ((oRttiPropertyFrom.IsWritable) and (oRttiPropertyFrom.IsReadable)) then
    begin
      oRttiPropertyTo := oRttiTypeTo.GetProperty(oRttiPropertyFrom.Name);
      if (Assigned(oRttiPropertyTo)) then
        oRttiPropertyTo.SetValue(Pointer(AFrom), oRttiPropertyFrom.GetValue(Pointer((ATo as TObject))));
    end;
  end;
end;



procedure TMVCBaseModelImpl.AddCustomValidation;
begin
  // Pode não precisar implementação
end;



procedure TMVCBaseModelImpl.CopyValuesFrom(const AModel: IMVCBaseModel);
begin
  self.DoInternalCopyValues(self, AModel);
end;



function TMVCBaseModelImpl.GetValidate: IValidator;
begin
  Result := FValidate;
end;



function TMVCBaseModelImpl.IsValid(const AView: TForm; const AControl: TWinControl): Boolean;
begin
  if (AControl = nil) then
    Result := not Validate.MakeAll(self).Fails
  else
    Result := not Validate.MakeAttribute(self, AView, AControl).Fails;
end;

end.
