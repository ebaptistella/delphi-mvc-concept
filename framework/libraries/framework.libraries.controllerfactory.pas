unit Framework.Libraries.ControllerFactory;

interface

uses
  Vcl.Forms,
  Framework.MVC.Model.BaseModel;

type
  IControllerFactory<TModel: IMVCBaseModel; TView: TForm> = interface(IInvokable)
    ['{31097B85-C2C8-4529-8CF1-AC8BA8A83DCD}']
  end;

implementation

end.
