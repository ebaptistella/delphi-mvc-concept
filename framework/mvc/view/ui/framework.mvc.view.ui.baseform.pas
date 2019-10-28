unit Framework.MVC.View.UI.BaseForm;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.Forms,
  Spring.Container.Common,
  Framework.Libraries.Notification.NotificationServiceImpl,
  Framework.Libraries.Notification.NotificationMessage,
  Framework.MVC.Model.BaseModel;

type
  THackCustomEdit = class(TCustomEdit);

  TBaseFormView = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FModel: IMVCBaseModel;
  private
    function GetNotificationService: TNotificationServiceImpl;
  protected
    [Inject]
    FNotificationService: TNotificationServiceImpl;

    procedure DoUserNotify(const ANotificationMessage: INotificationMessage); virtual;
    procedure DoFormEvents(const ANotificationMessage: INotificationMessage); virtual;
    procedure DoInitializeForm; virtual;

    procedure DoInitialize; virtual;
    procedure DoControlChange(ASender: TObject); virtual;
    function DoControlCheck(const AControl: TWinControl = nil): Boolean; virtual;

    procedure DoUpdateView; virtual;
    procedure DoUpdateModel; virtual;
    procedure DoClearForm; virtual;
  public
    procedure AfterConstruction; override;
    procedure ReceiveNotifications(var ANotificationMessage: INotificationMessage); virtual;

    property NotificationService: TNotificationServiceImpl read GetNotificationService;
    property Model: IMVCBaseModel read FModel write FModel;
  end;

  TBaseFormViewClass = class of TBaseFormView;

implementation

uses
  System.Rtti,
  System.StrUtils,
  Vcl.Mask,
  Vcl.CheckLst,
  Vcl.Dialogs,
  System.UITypes;

{$R *.dfm}

{ TBaseFormView }



procedure TBaseFormView.AfterConstruction;
begin
  inherited;

  DoClearForm;
end;



procedure TBaseFormView.DoClearForm;
var
  i: integer;
  ii: integer;
begin

  if (AnsiContainsText(Self.ClassParent.ClassName, 'TView')) then
    raise Exception.Create
      ('Para limpar formulários da classe "TView", utilize o método "ClearView" em vez do comando "ClearForm"');

  for i := 0 to ((Self as TForm).ComponentCount - 1) do
  begin
    // limpa os tags dos componentes
    if ((Self as TForm).Components[i] is TWinControl) then
    begin
      (Self as TForm).Components[i].Tag := 0;
    end;
    if (Self as TForm).Components[i] is TMaskEdit then
    begin
      TMaskEdit((Self as TForm).Components[i]).Text := '';
    end
    else if (Self as TForm).Components[i] is TEdit then
    begin
      TEdit((Self as TForm).Components[i]).Text := '';
    end
    else if (Self as TForm).Components[i] is TComboBox then
    begin
      TComboBox((Self as TForm).Components[i]).Text      := '';
      TComboBox((Self as TForm).Components[i]).ItemIndex := -1;
    end
    else if (Self as TForm).Components[i] is TCheckBox then
    begin
      TCheckBox((Self as TForm).Components[i]).Checked := False;
    end
    else if (Self as TForm).Components[i] is TMemo then
    begin
      TMemo((Self as TForm).Components[i]).Text := '';
    end
    else if (Self as TForm).Components[i] is TCheckListBox then
    begin
      if TCheckListBox((Self as TForm).Components[i]).Items.Count > 0 then
      begin
        for ii := 0 to TCheckListBox((Self as TForm).Components[i]).Count - 1 do
          TCheckListBox((Self as TForm).Components[i]).State[ii] := cbUnchecked;
      end;
    end
  end;
end;



procedure TBaseFormView.DoControlChange(ASender: TObject);
begin
  DoUpdateModel;
end;



function TBaseFormView.DoControlCheck(const AControl: TWinControl): Boolean;
begin
  if (AControl = nil) then
    Result := NotificationService.NotifyObservers<Boolean>(Self.ClassType, 'ControlCheck', [nil])
  else
    Result := NotificationService.NotifyObservers<Boolean>(Self.ClassType, 'ControlCheck', [TValue.From(AControl).AsType<TWinControl>]);
end;



procedure TBaseFormView.DoFormEvents(const ANotificationMessage: INotificationMessage);
begin
  if ((ANotificationMessage.MsgType = nmtMessage) and (ANotificationMessage.MsgStatus = nmsSuccess)) then
    DoInitializeForm;
end;



procedure TBaseFormView.DoInitialize;
var
  i: SmallInt;
  oRttiProp: TRttiProperty;
  oRttiCtx: TRttiContext;
begin
  oRttiCtx := TRttiContext.Create.Create;
  try
    for i := 0 to pred(Self.ComponentCount) do
    begin
      oRttiProp := oRttiCtx.GetType(Self.Components[i].ClassType).GetProperty('OnChange');
      if (oRttiProp <> nil) then
        oRttiProp.SetValue(Self.Components[i], TValue.From<TNotifyEvent>(DoControlChange));
    end;
  finally
    oRttiCtx.Free;
  end;
end;



procedure TBaseFormView.DoInitializeForm;
begin
  DoClearForm;
end;



procedure TBaseFormView.DoUpdateModel;
begin
  // Depende da utilização pode receber implementações
  // modelo.Atributo := Edit.Text
end;



procedure TBaseFormView.DoUpdateView;
begin
  // Depende da utilização pode receber implementações
  // Edit.Text := modelo.Atributo
end;



procedure TBaseFormView.DoUserNotify(const ANotificationMessage: INotificationMessage);
begin
  case ANotificationMessage.MsgType of
    nmtMessage:
      case ANotificationMessage.MsgStatus of
        nmsSuccess:
          messagedlg(ANotificationMessage.MsgText, mtInformation, [mbOk], 0);
        nmsWarning:
          messagedlg(ANotificationMessage.MsgText, mtWarning, [mbOk], 0);
      end;

    nmtException:
      raise Exception.Create(ANotificationMessage.MsgText);
  end;
end;



procedure TBaseFormView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;



procedure TBaseFormView.FormCreate(Sender: TObject);
begin
  DoInitialize;
end;



procedure TBaseFormView.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key = #13) and (DoControlCheck(ActiveControl))) then
  begin
    SelectNext(ActiveControl, True, True);
    Key := #0;
  end
end;



function TBaseFormView.GetNotificationService: TNotificationServiceImpl;
begin
  Result := FNotificationService;
end;



procedure TBaseFormView.ReceiveNotifications(var ANotificationMessage: INotificationMessage);
begin
  DoUserNotify(ANotificationMessage);
  DoFormEvents(ANotificationMessage);

  ANotificationMessage := nil;
end;

end.
