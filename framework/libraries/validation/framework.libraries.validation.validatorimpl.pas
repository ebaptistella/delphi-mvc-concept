unit Framework.Libraries.Validation.ValidatorImpl;

interface

uses
  System.Generics.Collections,
  System.Classes,
  System.Rtti,
  Vcl.Controls,
  Vcl.Forms,

  Framework.Libraries.Connection.ConnectionFactory,
  Spring.Persistence.Core.Session,

  Framework.Libraries.Validation.Validator,
  Framework.Libraries.Validation.ExtendValidationImpl,
  Framework.Libraries.Validation.Validate,
  Framework.Libraries.Validation.ColumnTitleImpl,
  Framework.Libraries.Validation.ValidateCustomAttributeImpl,

  Framework.Libraries.Validation.ModelMappingImpl,

  Framework.Libraries.Validation.MinLengthImpl,
  Framework.Libraries.Validation.MaxLengthImpl,
  Framework.Libraries.Validation.MinValueImpl,
  Framework.Libraries.Validation.MaxValueImpl,
  Framework.Libraries.Validation.ExactLengthImpl,
  Framework.Libraries.Validation.RequiredImpl,
  Framework.Libraries.Validation.IsNaturalImpl,
  Framework.Libraries.Validation.IsNaturalNoZeroImpl,
  Framework.Libraries.Validation.IsIntegerImpl,
  Framework.Libraries.Validation.RegexValidateImpl,
  Framework.Libraries.Validation.ValidEmailImpl;

type
  ColumnTitle = Framework.Libraries.Validation.ColumnTitleImpl.ColumnTitle;

  TExtendValidationImpl = Framework.Libraries.Validation.ExtendValidationImpl.TExtendValidationImpl;
  IValidate = Framework.Libraries.Validation.Validate.IValidate;

  TValidatorCustomAttribute = Framework.Libraries.Validation.ValidateCustomAttributeImpl.TValidateCustomAttribute;

  ModelMapping = Framework.Libraries.Validation.ModelMappingImpl.ModelMapping;

  MinLength = Framework.Libraries.Validation.MinLengthImpl.MinLength;
  MaxLength = Framework.Libraries.Validation.MaxLengthImpl.MaxLength;
  MinValue = Framework.Libraries.Validation.MinValueImpl.MinValue;
  MaxValue = Framework.Libraries.Validation.MaxValueImpl.MaxValue;
  ExactLength = Framework.Libraries.Validation.ExactLengthImpl.ExactLength;
  Required = Framework.Libraries.Validation.RequiredImpl.Required;
  IsNatural = Framework.Libraries.Validation.IsNaturalImpl.IsNatural;
  IsNaturalNoZero = Framework.Libraries.Validation.IsNaturalNoZeroImpl.IsNaturalNoZero;
  IsInteger = Framework.Libraries.Validation.IsIntegerImpl.IsInteger;
  RegexValidate = Framework.Libraries.Validation.RegexValidateImpl.RegexValidate;
  ValidEmail = Framework.Libraries.Validation.ValidEmailImpl.ValidEmail;

  TAnonymousEV = record
    AnonymousExtendValidator: TAnonymousExtendValidator;
    AnonymousExtendValidatorWithSession: TAnonymousExtendValidatorWithSession;

    constructor Create(const AValidator: TAnonymousExtendValidator); overload;
    constructor Create(const AValidator: TAnonymousExtendValidatorWithSession); overload;
  end;

  TValidatorImpl = class(TInterfacedObject, IValidator)
  private
    FExtendValidationList: TDictionary<TExtendValidationImpl, TAnonymousEV>;
    FErrorList: TStringList;
    FFails: Boolean;
    FConnectionFactory: IConnectionFactory;

    function GetSession: TSession;

    procedure SetColumnTitle(const AColumnTitle: string);

    procedure InternalMake(const AModel: TObject; const AAttributeName: String; const AExitOnFirstError: Boolean = False);
    procedure InternalValidateModel(const AModel: TObject; const AExitOnFirstError: Boolean; const AAttributeName: String = '');
    procedure InternalValidateExtend(const AExitOnFirstError: Boolean; const AAttributeName: String = '');
  public
    constructor Create(const AConnectionFactory: IConnectionFactory); reintroduce;
    destructor Destroy; override;

    function MakeAttribute(const AModel: TObject; const AView: TForm; const AAttribute: TWinControl; const AExitOnFirstError: Boolean = False): IValidator; overload;
    function MakeAttribute(const AModel: TObject; const AAttributeName: String; const AExitOnFirstError: Boolean = False): IValidator; overload;
    function MakeAll(const AModel: TObject; const AExitOnFirstError: Boolean = False): IValidator;
    function Fails: Boolean;
    function ErrorMessages: TStringList;
    procedure AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator); overload;
    procedure AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidatorWithSession); overload;

    property Session: TSession read GetSession;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  Generics.Defaults,
  Framework.Libraries.Exceptions.ExceptionsClass,
  Framework.Libraries.Validation.ResourceStrings,
  System.Hash;

{ TValidatorImpl }



constructor TValidatorImpl.Create(const AConnectionFactory: IConnectionFactory);
begin
  FConnectionFactory    := AConnectionFactory;
  FExtendValidationList := TDictionary<TExtendValidationImpl, TAnonymousEV>.Create(
    TDelegatedEqualityComparer<TExtendValidationImpl>.Create(
    function(const Left, Right: TExtendValidationImpl): Boolean
    begin
      Result := (Left.AttributeName = Right.AttributeName) and (Left.ErrorMessage = Right.ErrorMessage);
    end,
    function(const Value: TExtendValidationImpl): Integer
    begin
      Result := THashBobJenkins.GetHashValue(Value.AttributeName[1], Length(Value.AttributeName) * SizeOf(Char), 0);
      Result := THashBobJenkins.GetHashValue(Value.ErrorMessage[1], Length(Value.ErrorMessage) * SizeOf(Char), Result);
    end));
  FErrorList := TStringList.Create;
end;



destructor TValidatorImpl.Destroy;
begin
  FExtendValidationList.Free;
  FErrorList.Free;

  inherited;
end;



procedure TValidatorImpl.AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
begin
  FExtendValidationList.Remove(TExtendValidationImpl.Create(AAttributeName, AValue, AErrorMessage));
  FExtendValidationList.AddOrSetValue(TExtendValidationImpl.Create(AAttributeName, AValue, AErrorMessage), TAnonymousEV.Create(AValidator));
end;



procedure TValidatorImpl.AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidatorWithSession);
begin
  FExtendValidationList.Remove(TExtendValidationImpl.Create(AAttributeName, AValue, AErrorMessage));
  FExtendValidationList.AddOrSetValue(TExtendValidationImpl.Create(AAttributeName, AValue, AErrorMessage), TAnonymousEV.Create(AValidator));
end;



function TValidatorImpl.ErrorMessages: TStringList;
begin
  Result := FErrorList;
end;



function TValidatorImpl.Fails: Boolean;
begin
  Result := FFails;
end;



procedure TValidatorImpl.InternalMake(const AModel: TObject; const AAttributeName: String; const AExitOnFirstError: Boolean);
begin
  FFails := False;
  FErrorList.Clear;

  InternalValidateModel(AModel, AExitOnFirstError, AAttributeName);
  FFails := FErrorList.Count > 0;

  if ((AExitOnFirstError) and (FFails)) then
    Exit;

  InternalValidateExtend(AExitOnFirstError, AAttributeName);
  FFails := FErrorList.Count > 0;
end;



procedure TValidatorImpl.InternalValidateExtend(const AExitOnFirstError: Boolean; const AAttributeName: String);
var
  oExtendValidation: TExtendValidationImpl;
  oSuccess: Boolean;
begin
  for oExtendValidation in FExtendValidationList.Keys do
  begin
    if ((AAttributeName <> EmptyStr) and (oExtendValidation.AttributeName.ToLower.Trim <> AAttributeName.ToLower.Trim)) then
      Continue;

    oSuccess := False;
    if (FExtendValidationList.Items[oExtendValidation].AnonymousExtendValidator <> nil) then
      oSuccess := FExtendValidationList.Items[oExtendValidation].AnonymousExtendValidator(oExtendValidation.Value)
    else if (FExtendValidationList.Items[oExtendValidation].AnonymousExtendValidatorWithSession <> nil) then
      oSuccess := FExtendValidationList.Items[oExtendValidation].AnonymousExtendValidatorWithSession(oExtendValidation.Value, Session);

    if (not(oSuccess)) then
    begin
      FErrorList.Add(Format(oExtendValidation.ErrorMessage, [oExtendValidation.Value.AsVariant]));
      if (AExitOnFirstError) then
        Exit;
    end;
  end;

end;



procedure TValidatorImpl.InternalValidateModel(const AModel: TObject; const AExitOnFirstError: Boolean; const AAttributeName: String);
var
  oRttiCtx: TRttiContext;
  oRttiTp: TRttiType;
  oRttiProp: TRttiProperty;
  oCstAttr: TCustomAttribute;
  oValidate: IValidate;
  bAttrFound: Boolean;
  sColumnTitle: String;
begin
  if (AModel = nil) then
    raise TValidatorImplException.Create(TResourceStringsValidator.RSValidator_ModelIsNil);

  bAttrFound := False;
  oRttiCtx   := TRttiContext.Create;
  try
    oRttiTp := oRttiCtx.GetType(AModel.ClassType);
    for oRttiProp in oRttiTp.GetProperties do
    begin
      if (oRttiProp.propertytype.typekind in [tkClass, tkRecord]) then
      begin
        InternalValidateModel(oRttiProp.GetValue(TObject(AModel)).AsObject, AExitOnFirstError, AAttributeName);
        Continue;
      end;

      if ((AAttributeName <> EmptyStr) and (oRttiProp.Name.ToLower.Trim <> AAttributeName.ToLower.Trim)) then
        Continue;

      bAttrFound := True;
      try
        sColumnTitle := EmptyStr;
        for oCstAttr in oRttiProp.GetAttributes do
        begin
          if (oCstAttr is ColumnTitle) then
            sColumnTitle := (oCstAttr as ColumnTitle).GetColumnTitle;

          if not(Supports(oCstAttr, IValidate, oValidate)) then
            Continue;

          if (not(oValidate.isValid(oRttiProp.GetValue(Pointer(AModel))))) then
          begin
            FErrorList.Add(oValidate.GetErrorMessage);
            if (AExitOnFirstError) then
              Exit;
          end;
        end;
      finally
        if (FErrorList.Count > 0) then
          SetColumnTitle(sColumnTitle);
      end;
    end;

    if ((AAttributeName <> EmptyStr) and not(bAttrFound)) then
      FErrorList.Add(Format(TResourceStringsValidator.RSValidator_AttrNotFound, [AModel.ClassName, AAttributeName]));
  finally
    oRttiCtx.Free;
  end;
end;



function TValidatorImpl.MakeAll(const AModel: TObject; const AExitOnFirstError: Boolean): IValidator;
begin
  InternalMake(AModel, EmptyStr, AExitOnFirstError);
  Result := Self;
end;



function TValidatorImpl.MakeAttribute(const AModel: TObject; const AView: TForm; const AAttribute: TWinControl; const AExitOnFirstError: Boolean): IValidator;
var
  oRttiCtx: TRttiContext;
  oRttiCtxCst: TRttiContext;

  oRttiTp: TRttiType;
  oRttiTpCst: TRttiType;

  oRttiField: TRttiField;
  oCstAttr: TCustomAttribute;

  oAttributeName: TValue;
begin
  oRttiTp := oRttiCtx.GetType(AView.ClassType);
  for oRttiField in oRttiTp.GetFields do
  begin
    if (oRttiField.Name.ToLower.Trim <> Trim(AnsiLowerCase(AAttribute.Name))) then
      Continue;

    for oCstAttr in oRttiField.GetAttributes do
    begin
      oRttiTpCst := oRttiCtxCst.GetType(oCstAttr.ClassType);

      if (oCstAttr.ClassName = 'BindAttribute') then
        oAttributeName := oRttiTpCst.GetProperty('SourcePropertyName').GetValue(oCstAttr)
      else if (oCstAttr.ClassName = 'TModelMappingImpl') then
        oAttributeName := oRttiTpCst.GetProperty('ModelPropertyName').GetValue(oCstAttr);

      if (oAttributeName.ToString = EmptyStr) then
        raise TValidatorImplException.CreateFmt(TResourceStringsValidator.RSValidator_MappingNotFound, [AModel.ClassName, AAttribute.Name]);

      Exit(MakeAttribute(AModel, oAttributeName.ToString, AExitOnFirstError));
    end;
  end;
end;



function TValidatorImpl.MakeAttribute(const AModel: TObject; const AAttributeName: String; const AExitOnFirstError: Boolean): IValidator;
begin
  InternalMake(AModel, AAttributeName, AExitOnFirstError);
  Result := Self;
end;



procedure TValidatorImpl.SetColumnTitle(const AColumnTitle: string);
var
  iIndex: Integer;
begin
  for iIndex           := 0 to Pred(FErrorList.Count) do
    FErrorList[iIndex] := Format(FErrorList[iIndex], [AColumnTitle]);
end;



function TValidatorImpl.GetSession: TSession;
begin
  Result := FConnectionFactory.Session;
end;

{ TAnonymousEV }



constructor TAnonymousEV.Create(const AValidator: TAnonymousExtendValidator);
begin
  AnonymousExtendValidator := AValidator;
end;



constructor TAnonymousEV.Create(const AValidator: TAnonymousExtendValidatorWithSession);
begin
  AnonymousExtendValidatorWithSession := AValidator;
end;

end.
