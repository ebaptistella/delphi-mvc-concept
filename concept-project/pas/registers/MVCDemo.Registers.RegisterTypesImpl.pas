unit MVCDemo.Registers.RegisterTypesImpl;

interface

uses
  Spring.Container;

procedure RegisterTypes;
procedure UnregisterTypes;

var
  Container: TContainer;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  Spring.Logging,
  Spring.Container.Common,
  Spring.Logging.Appenders,
  Spring.Interception,

  Framework.Libraries.Logging.LoggingInitializeImpl,
  Framework.Libraries.InterceptorLogger.MethodLoggerInterceptorImpl,
  Framework.Libraries.Security.SecurityController,
  Framework.Libraries.Security.SecurityControllerImpl,
  Framework.Libraries.InterfacedObjectInjectedAttrImpl,
  Framework.Libraries.Logging.Appenders.ConsoleAppenderImpl,
  Framework.Libraries.Notification.NotificationService,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.Libraries.UI.ViewRegistryImpl,
  Framework.Libraries.UI.ViewFactoryImpl,
  Framework.Libraries.Connection.ConnectionFactory,
  Framework.Libraries.Connection.ConnectionFactoryImpl,
  Framework.Libraries.Validation.ValidatorImpl,
  Framework.Libraries.Validation.Validator,

  MVCDemo.Registers.RegisterViewsImpl,

  MVCDemo.Models.CRM.PaisModel,
  MVCDemo.Models.CRM.PaisModelPKImpl,
  MVCDemo.Models.CRM.PaisModelImpl,
  MVCDemo.Models.CRM.EstadoModel,
  MVCDemo.Models.CRM.EstadoModelPKImpl,
  MVCDemo.Models.CRM.EstadoModelImpl,
  MVCDemo.Models.CRM.MunicipioModel,
  MVCDemo.Models.CRM.MunicipioModelPKImpl,
  MVCDemo.Models.CRM.MunicipioModelImpl,
  MVCDemo.Models.Comercial.MarcaModel,
  MVCDemo.Models.Comercial.MarcaModelPKImpl,
  MVCDemo.Models.Comercial.MarcaModelImpl,

  MVCDemo.DAOs.CRM.PaisDAO,
  MVCDemo.DAOs.CRM.PaisDAOImpl,
  MVCDemo.DAOs.CRM.EstadoDAO,
  MVCDemo.DAOs.CRM.EstadoDAOImpl,
  MVCDemo.DAOs.CRM.MunicipioDAO,
  MVCDemo.DAOs.CRM.MunicipioDAOImpl,
  MVCDemo.DAOs.Comercial.MarcaDAO,
  MVCDemo.DAOs.Comercial.MarcaDAOImpl,

  MVCDemo.Controllers.CRM.PaisController,
  MVCDemo.Controllers.CRM.PaisControllerImpl,
  MVCDemo.Controllers.CRM.EstadoController,
  MVCDemo.Controllers.CRM.EstadoControllerImpl,
  MVCDemo.Controllers.CRM.MunicipioController,
  MVCDemo.Controllers.CRM.MunicipioControllerImpl,
  MVCDemo.Controllers.Comercial.MarcaController,
  MVCDemo.Controllers.Comercial.MarcaControllerImpl,

  MVCDemo.Views.CRM.PaisView,
  MVCDemo.Views.CRM.EstadoView,
  MVCDemo.Views.CRM.MunicipioView,
  MVCDemo.Views.Comercial.MarcaView;



procedure RegisterTypes;

  procedure RegisterSpringComponents;
  begin
    Container.RegisterType<ILogAppender, TFrameworkLoggingConsoleAppenderImpl>('console');
    Container.RegisterType<ILogAppender, TFileLogAppender>('file');
  end;

  procedure RegisterLibraryContainer;
  begin
    Container.RegisterType<TConnectionFactoryImpl, TConnectionFactoryImpl>
      .Implements<IConnectionFactory>
      .AsSingleton;

    Container.RegisterType<TFrameworkLoggingInitializeImpl>
      .Implements<TFrameworkLoggingInitializeImpl>
      .InjectConstructor([Container])
      .AsSingleton;

    Container.RegisterType<TNotificationServiceImpl, TNotificationServiceImpl>
      .Implements<INotificationService>
      .AsSingleton;

    Container.RegisterType<TMethodLoggerInterceptorImpl, TMethodLoggerInterceptorImpl>
      .Implements<IInterceptor>;

    Container.RegisterType<TSecurityControllerImpl, TSecurityControllerImpl>
      .Implements<IInterceptor>
      .Implements<ISecurityController>;

    Container.RegisterType<TInterfacedObjectInjectedAttrImpl>
      .Implements<TInterfacedObjectInjectedAttrImpl>;

    Container.RegisterType<TViewRegistryImpl, TViewRegistryImpl>
      .AsSingleton;

    Container.RegisterType<TViewFactoryImpl, TViewFactoryImpl>
      .InjectField('FViewRegistryImpl')
      .InjectField('FNotificationService')
      .AsSingleton;

    Container.RegisterType<TValidatorImpl, TValidatorImpl>
      .Implements<IValidator>
      .InjectConstructor([TypeInfo(TConnectionFactoryImpl)]);
  end;

  procedure RegisterModelContainer;
  begin

    Container.RegisterType<TPaisModelPKImpl, TPaisModelPKImpl>
      .Implements<IPaisModel>
      .AsSingleton;

    Container.RegisterType<TPaisModelImpl, TPaisModelImpl>
      .Implements<IPaisModel>
      .AsSingleton;

    Container.RegisterType<TEstadoModelPKImpl, TEstadoModelPKImpl>
      .Implements<IEstadoModel>
      .AsSingleton;

    Container.RegisterType<TEstadoModelImpl, TEstadoModelImpl>
      .Implements<IEstadoModel>
      .AsSingleton;

    Container.RegisterType<TMunicipioModelPKImpl, TMunicipioModelPKImpl>
      .Implements<IMunicipioModel>
      .AsSingleton;

    Container.RegisterType<TMunicipioModelImpl, TMunicipioModelImpl>
      .Implements<IMunicipioModel>
      .AsSingleton;

    Container.RegisterType<TMarcaModelPKImpl, TMarcaModelPKImpl>
      .Implements<IMarcaModel>
      .AsSingleton;

    Container.RegisterType<TMarcaModelImpl, TMarcaModelImpl>
      .Implements<IMarcaModel>
      .AsSingleton;
  end;

  procedure RegisterDAOContainer;
  begin
    Container.RegisterType<TPaisDAOImpl, TPaisDAOImpl>
      .Implements<IPaisDAO>
      .InjectConstructor([TypeInfo(TConnectionFactoryImpl)])
      .AsSingleton;

    Container.RegisterType<TEstadoDAOImpl, TEstadoDAOImpl>
      .Implements<IEstadoDAO>
      .InjectConstructor([TypeInfo(TConnectionFactoryImpl)])
      .AsSingleton;

    Container.RegisterType<TMunicipioDAOImpl, TMunicipioDAOImpl>
      .Implements<IMunicipioDAO>
      .InjectConstructor([TypeInfo(TConnectionFactoryImpl)])
      .AsSingleton;

    Container.RegisterType<TMarcaDAOImpl, TMarcaDAOImpl>
      .Implements<IMarcaDAO>
      .InjectConstructor([TypeInfo(TConnectionFactoryImpl)])
      .AsSingleton;
  end;

  procedure RegisterControllerContainer;
  begin
    Container.RegisterType<TPaisControllerImpl>
      .Implements<IPaisController>
      .InjectConstructor([
        TypeInfo(TPaisDAOImpl),
        TypeInfo(TPaisModelImpl),
        TypeInfo(TViewFactoryImpl),
        TypeInfo(TNotificationServiceImpl),
        TypeInfo(TSecurityControllerImpl)])
      .InterceptedBy(TypeInfo(TMethodLoggerInterceptorImpl))
      .AsSingleton;

    Container.RegisterType<TEstadoControllerImpl<TEstadoModelImpl, TFrmEstadoView>>
      .Implements<IEstadoController<TEstadoModelImpl, TFrmEstadoView>>
      .InjectConstructor([
        TypeInfo(TEstadoDAOImpl),
        TypeInfo(TEstadoModelImpl),
        TypeInfo(TViewFactoryImpl),
        TypeInfo(TNotificationServiceImpl),
        TypeInfo(TSecurityControllerImpl)])
      .InterceptedBy(TypeInfo(TMethodLoggerInterceptorImpl))
      .AsSingleton;

    Container.RegisterType<TMunicipioControllerImpl>
      .Implements<IMunicipioController>
      .InjectConstructor([
        TypeInfo(TMunicipioDAOImpl),
        TypeInfo(TMunicipioModelImpl),
        TypeInfo(TViewFactoryImpl),
        TypeInfo(TNotificationServiceImpl),
        TypeInfo(TSecurityControllerImpl)])
      .InterceptedBy(TypeInfo(TMethodLoggerInterceptorImpl))
      .AsSingleton;

    Container.RegisterType<TMarcaControllerImpl>
      .Implements<IMarcaController>
      .InjectConstructor([
        TypeInfo(TMarcaDAOImpl),
        TypeInfo(TMarcaModelImpl),
        TypeInfo(TViewFactoryImpl),
        TypeInfo(TNotificationServiceImpl),
        TypeInfo(TSecurityControllerImpl)])
      .InterceptedBy(TypeInfo(TMethodLoggerInterceptorImpl))
      .AsSingleton;
  end;

  procedure RegisterViewContainer;
  begin
    Container.RegisterType<TFrmPaisView>
      .Implements<TFrmPaisView>
      .DelegateTo(
      function: TFrmPaisView
      begin
        Application.CreateForm(TFrmPaisView, Result);
      end);

    Container.RegisterType<TFrmEstadoView>
      .Implements<TFrmEstadoView>
      .DelegateTo(
      function: TFrmEstadoView
      begin
        Application.CreateForm(TFrmEstadoView, Result);
      end);

    Container.RegisterType<TFrmMunicipioView>
      .Implements<TFrmMunicipioView>
      .DelegateTo(
      function: TFrmMunicipioView
      begin
        Application.CreateForm(TFrmMunicipioView, Result);
      end);

    Container.RegisterType<TFrmMarcaView>
      .Implements<TFrmMarcaView>
      .DelegateTo(
      function: TFrmMarcaView
      begin
        Application.CreateForm(TFrmMarcaView, Result);
      end);
  end;

  procedure RegisterRegisters;
  begin
    Container.RegisterType<TRegisterViewsImpl, TRegisterViewsImpl>
      .InjectField('FViewRegistryImpl')
      .AsSingleton;
  end;



begin
  Container := TContainer.Create;

  RegisterSpringComponents;
  RegisterLibraryContainer;
  RegisterViewContainer;
  RegisterModelContainer;
  RegisterDAOContainer;
  RegisterControllerContainer;
  RegisterRegisters;

  Container.Build;

  Container.Resolve<TFrameworkLoggingInitializeImpl>;
  Container.Resolve<TRegisterViewsImpl>.Registry;
end;



procedure UnregisterTypes;
begin
  FreeAndNil(Container);
end;

initialization

//

finalization

UnregisterTypes();

end.
