unit Framework.Libraries.Notification.NotificationServiceImpl;

interface

uses
  System.Rtti,
  System.Generics.Collections,
  Framework.Libraries.Notification.NotificationService,
  Framework.Libraries.InterfacedObjectLoggableImpl;

type

  TNotifiedBy = (byView, byModel, byController);
  TSetOfNotifiedBy = set of TNotifiedBy;

  TIsNotified = class(TCustomAttribute)
  private
    FNotifiedBy: TSetOfNotifiedBy;
  protected
    function GetNotified: TSetOfNotifiedBy;
  public
    constructor Create(const ANotifiedBy: TSetOfNotifiedBy); overload;
  end;

  IsNotified = TIsNotified;

  PNotifyClass = ^TNotifyClass;

  TNotifyClass = record
    InstanceInvoked: TObject;
    ObservedClass: TClass;
    MethodName: String;
  end;

  TNotificationServiceImpl = class(TInterfacedObjectLoggableImpl, INotificationService, IObserverNotification)
  private
    FListNotifyClass: TList<PNotifyClass>;
    FSubscribers: TObjectDictionary<TClass, TList<PNotifyClass>>;

    function RttiInvoke(const AObservedClass: TClass; const AMethodName: String; const AArgs: array of TValue): TValue;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  public
    procedure Subscribe(const AInstance: TObject); overload;
    function Subscribe(const AInstance: TObject; const AMethods: array of String): IObserverNotification; overload;
    function UnSubscribe(const AInstance: TObject; const AMethods: array of String): INotificationService;
    function Observer(const AObservedClass: TClass): IObserverNotification;
    procedure NotifyObservers(const AObservedClass: TClass; const AMethodName: String; const AArgs: array of TValue); overload;
    procedure NotifyObservers(const AObservedClass: TClass; const AMethodName: String); overload;

    function NotifyObservers<T>(const AObservedClass: TClass; const AMethodName: String; const AArgs: array of TValue): T; overload;
    function NotifyObservers<T>(const AObservedClass: TClass; const AMethodName: String): T; overload;
  end;

implementation

uses
  Framework.Libraries.Exceptions.ExceptionsClass,
  System.SysUtils,
  System.Generics.Defaults,
  Vcl.Forms,
  System.TypInfo;

{ TNotificationServiceImpl }



procedure TNotificationServiceImpl.AfterConstruction;
begin
  inherited;

  FSubscribers := TObjectDictionary < TClass, TList < PNotifyClass >>.Create([doOwnsValues]);
end;



procedure TNotificationServiceImpl.BeforeDestruction;
var
  oPair: TPair<TClass, TList<PNotifyClass>>;
  oNotifyClass: PNotifyClass;
begin
  if ((Assigned(FSubscribers)) and (FSubscribers.Count > 0)) then
  begin
    for oPair in FSubscribers do
      for oNotifyClass in oPair.Value do
        Dispose(oNotifyClass);

    FSubscribers.Free;
  end;

  inherited;
end;



procedure TNotificationServiceImpl.NotifyObservers(const AObservedClass: TClass; const AMethodName: String);
begin
  RttiInvoke(AObservedClass, AMethodName, []);
end;



function TNotificationServiceImpl.NotifyObservers<T>(const AObservedClass: TClass; const AMethodName: String; const AArgs: array of TValue): T;
begin
  Result := RttiInvoke(AObservedClass, AMethodName, AArgs).AsType<T>;
end;



function TNotificationServiceImpl.NotifyObservers<T>(const AObservedClass: TClass; const AMethodName: String): T;
begin
  Result := RttiInvoke(AObservedClass, AMethodName, []).AsType<T>;
end;



procedure TNotificationServiceImpl.NotifyObservers(const AObservedClass: TClass; const AMethodName: String; const AArgs: array of TValue);
begin
  RttiInvoke(AObservedClass, AMethodName, AArgs);
end;



function TNotificationServiceImpl.Observer(const AObservedClass: TClass): IObserverNotification;
var
  oNotifyClass: PNotifyClass;
begin
  if (not(Assigned(FListNotifyClass))) then
    raise TNotificationServiceException.Create('First call "Subscribe" method.');

  for oNotifyClass in FListNotifyClass do
    if (oNotifyClass.ObservedClass = nil) then
      oNotifyClass.ObservedClass := AObservedClass;

  Result := Self;
end;



function TNotificationServiceImpl.RttiInvoke(const AObservedClass: TClass; const AMethodName: String; const AArgs: array of TValue): TValue;
var
  oPair: TPair<TClass, TList<PNotifyClass>>;
  oNotifyClass: PNotifyClass;
  bMethodFound: Boolean;
  bParamsFound: Boolean;

  oRttiContext: TRttiContext;
  oRttiType: TRttiType;
  oRttiMethod: TRttiMethod;
  oParams: TArray<TRttiParameter>;
  iParam: Integer;
begin
  Result       := nil;
  bMethodFound := False;
  bParamsFound := False;

  for oPair in FSubscribers do
  begin
    for oNotifyClass in oPair.Value do
    begin
      if ((oNotifyClass.ObservedClass.ClassName = AObservedClass.ClassName) and
        (oNotifyClass.MethodName = AMethodName)) then
      begin
        oRttiType   := oRttiContext.GetType(oNotifyClass.InstanceInvoked.ClassType);
        oRttiMethod := oRttiType.GetMethod(AMethodName);
        if (oRttiMethod = nil) then
          Continue;

        for oRttiMethod in oRttiType.GetMethods do
        begin
          bMethodFound := Assigned(oRttiMethod) and (oRttiMethod.Name = AMethodName);
          if (not(bMethodFound)) then
            Continue;

          oParams      := oRttiMethod.GetParameters;
          bParamsFound := Length(AArgs) = Length(oParams);

          if (bParamsFound) then
          begin
            for iParam := 0 to Length(oParams) - 1 do
            begin
              bParamsFound :=
                ((oParams[iParam].ParamType.Handle.Kind = AArgs[iParam].Kind) and
                (oParams[iParam].ParamType.Handle.Name = AArgs[iParam].TypeInfo.Name))
                or
                ((oParams[iParam].ParamType.Handle.Kind = tkClass) and
                (oParams[iParam].ParamType.Handle.Kind = AArgs[iParam].Kind))
                or
                ((oParams[iParam].ParamType.Handle.Kind = tkRecord) and
                (oParams[iParam].ParamType.Handle.Name = 'TValue'))
                or
                ((AArgs[iParam].TypeInfo = nil));
              if not(bParamsFound) then
                Break;
            end;
          end;

          if ((bMethodFound) and (bParamsFound)) then
          begin
            Result := oRttiMethod.Invoke(oNotifyClass.InstanceInvoked, AArgs);
            Break;
          end;
        end;
      end;
    end;
  end;

  if not(bMethodFound) then
    raise TNotificationServiceException.CreateFmt('Method "%s" not registered in the observed class.', [AMethodName])
  else if not(bParamsFound) then
    raise TNotificationServiceException.CreateFmt('Method "%s" does not contain overload for parameters.', [AMethodName]);
end;



procedure TNotificationServiceImpl.Subscribe(const AInstance: TObject);
var
  oRttiContext: TRttiContext;
  oRttiType: TRttiType;
  oRttiMethod: TRttiMethod;
  oCstAttr: TCustomAttribute;
  oRttiProperty: TRttiProperty;
begin
  oRttiType := oRttiContext.GetType(AInstance.ClassType);
  for oRttiMethod in oRttiType.GetMethods do
  begin
    for oCstAttr in oRttiMethod.GetAttributes() do
    begin
      if (oCstAttr is TIsNotified) then
      begin
        if (byView in TIsNotified(oCstAttr).GetNotified) then
        begin
          oRttiProperty := oRttiType.GetProperty('View');
          if (oRttiProperty = nil) then
            raise TNotificationServiceException.CreateFmt('Class "%s" does not have a property "%s"', [AInstance.ClassName, 'View']);

          Self.Subscribe(AInstance, [oRttiMethod.Name]).Observer(TRttiInstanceType(oRttiContext.findType(oRttiProperty.propertytype.QualifiedName)).MetaClassType);
        end
        else if (byModel in TIsNotified(oCstAttr).GetNotified) then
        begin
          oRttiProperty := oRttiType.GetProperty('Model');
          if (oRttiProperty = nil) then
            raise TNotificationServiceException.CreateFmt('Class "%s" does not have a property "%s"', [AInstance.ClassName, 'Model']);

          Self.Subscribe(AInstance, [oRttiMethod.Name]).Observer(TRttiInstanceType(oRttiContext.findType(oRttiProperty.propertytype.QualifiedName)).MetaClassType);
        end
        else if (byController in TIsNotified(oCstAttr).GetNotified) then
        begin
          oRttiProperty := oRttiType.GetProperty('Controller');
          if (oRttiProperty = nil) then
            raise TNotificationServiceException.CreateFmt('Class "%s" does not have a property "%s"', [AInstance.ClassName, 'Controller']);

          Self.Subscribe(AInstance, [oRttiMethod.Name]).Observer(TRttiInstanceType(oRttiContext.findType(oRttiProperty.propertytype.QualifiedName)).MetaClassType);
        end
      end;
    end;
  end;
end;



function TNotificationServiceImpl.Subscribe(const AInstance: TObject; const AMethods: array of String): IObserverNotification;
var
  sMethod: string;
begin
  if (Length(AMethods) < 1) then
    raise TNotificationServiceException.Create('Method not defined.');

  if not(FSubscribers.TryGetValue(AInstance.ClassType, FListNotifyClass)) then
    FSubscribers.Add(AInstance.ClassType, TList<PNotifyClass>.Create);

  FSubscribers.TryGetValue(AInstance.ClassType, FListNotifyClass);

  for sMethod in AMethods do
  begin
    FListNotifyClass.Add(New(PNotifyClass));
    FListNotifyClass.Last.InstanceInvoked := AInstance;
    FListNotifyClass.Last.ObservedClass   := nil;
    FListNotifyClass.Last.MethodName      := sMethod;
  end;

  Result := Self;
end;



function TNotificationServiceImpl.UnSubscribe(const AInstance: TObject; const AMethods: array of String): INotificationService;
var
  oPair: TPair<TClass, TList<PNotifyClass>>;
  oNotifyClass: PNotifyClass;
  iFoundIndex: Integer;
begin
  if (not(Assigned(FSubscribers)) or (FSubscribers.Count < 1)) then
    Exit(Self);

  if (Length(AMethods) > 0) then
  begin
    for oPair in FSubscribers do
      for oNotifyClass in oPair.Value do
      begin
        if (oNotifyClass.InstanceInvoked.ClassType = AInstance.ClassType) and
          (TArray.BinarySearch<String>(AMethods, oNotifyClass.MethodName, iFoundIndex, TStringComparer.Ordinal)) then
          oPair.Value.Remove(oNotifyClass);
      end;
  end;

  if (FSubscribers.Items[AInstance.ClassType].Count < 1) then
    FSubscribers.Remove(AInstance.ClassType);

  Result := Self;
end;

{ TIsNotified }



constructor TIsNotified.Create(const ANotifiedBy: TSetOfNotifiedBy);
begin
  inherited Create;

  FNotifiedBy := ANotifiedBy;
end;



function TIsNotified.GetNotified: TSetOfNotifiedBy;
begin
  Result := FNotifiedBy;
end;

end.
