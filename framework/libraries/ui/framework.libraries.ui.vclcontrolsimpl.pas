unit Framework.Libraries.UI.VCLControlsImpl;

interface

uses
  editnum,
  DSharp.Bindings.Notifications,
  Winapi.Messages,
  Vcl.Controls,
  System.Classes,
  Vcl.Mask;

type
  TEditText = class(editnum.TEditText, INotifyPropertyChanged)
  private
    FNotifyPropertyChanged: INotifyPropertyChanged;
    property NotifyPropertyChanged: INotifyPropertyChanged
      read FNotifyPropertyChanged implements INotifyPropertyChanged;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
  protected
    procedure Change; override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TEditNum = class(editnum.TEditNum, INotifyPropertyChanged)
  private
    FNotifyPropertyChanged: INotifyPropertyChanged;
    property NotifyPropertyChanged: INotifyPropertyChanged
      read FNotifyPropertyChanged implements INotifyPropertyChanged;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
  protected
    procedure Change; override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TEditDate = class(editnum.TEditDate, INotifyPropertyChanged)
  private
    FNotifyPropertyChanged: INotifyPropertyChanged;
    property NotifyPropertyChanged: INotifyPropertyChanged read FNotifyPropertyChanged implements INotifyPropertyChanged;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
  protected
    procedure Change; override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TMaskEdit = class(Vcl.Mask.TMaskEdit, INotifyPropertyChanged)
  private
    FNotifyPropertyChanged: INotifyPropertyChanged;
    property NotifyPropertyChanged: INotifyPropertyChanged read FNotifyPropertyChanged implements INotifyPropertyChanged;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
  protected
    procedure Change; override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  DSharp.Bindings.Exceptions,
  Winapi.Windows;

{ TEditText }



procedure TEditText.Change;
begin
  inherited;
  NotifyPropertyChanged.DoPropertyChanged('Text');
end;



procedure TEditText.CMExit(var Message: TCMExit);
begin
  try
    NotifyPropertyChanged.DoPropertyChanged('Text', utLostFocus);
    inherited;
  except
    on EValidationError do
    begin
      SetFocus;
    end;
  end;
end;



constructor TEditText.Create(AOwner: TComponent);
begin
  inherited;
  FNotifyPropertyChanged := TNotifyPropertyChanged.Create(Self);
end;



procedure TEditText.WMChar(var Message: TWMChar);
begin
  inherited;
  if Message.CharCode = VK_RETURN then
  begin
    NotifyPropertyChanged.DoPropertyChanged('Text', utExplicit);
  end;
end;

{ TEditNum }



procedure TEditNum.Change;
begin
  inherited;
  NotifyPropertyChanged.DoPropertyChanged('Text');
end;



procedure TEditNum.CMExit(var Message: TCMExit);
begin
  try
    NotifyPropertyChanged.DoPropertyChanged('Text', utLostFocus);
    inherited;
  except
    on EValidationError do
    begin
      SetFocus;
    end;
  end;
end;



constructor TEditNum.Create(AOwner: TComponent);
begin
  inherited;
  FNotifyPropertyChanged := TNotifyPropertyChanged.Create(Self);
end;



procedure TEditNum.WMChar(var Message: TWMChar);
begin
  inherited;
  if Message.CharCode = VK_RETURN then
  begin
    NotifyPropertyChanged.DoPropertyChanged('Text', utExplicit);
  end;
end;

{ TEditDate }



procedure TEditDate.Change;
begin
  inherited;
  NotifyPropertyChanged.DoPropertyChanged('Text');
end;



procedure TEditDate.CMExit(var Message: TCMExit);
begin
  try
    NotifyPropertyChanged.DoPropertyChanged('Text', utLostFocus);
    inherited;
  except
    on EValidationError do
    begin
      SetFocus;
    end;
  end;
end;



constructor TEditDate.Create(AOwner: TComponent);
begin
  inherited;
  FNotifyPropertyChanged := TNotifyPropertyChanged.Create(Self);
end;



procedure TEditDate.WMChar(var Message: TWMChar);
begin
  inherited;
  if Message.CharCode = VK_RETURN then
  begin
    NotifyPropertyChanged.DoPropertyChanged('Text', utExplicit);
  end;
end;

{ TMaskEdit }



procedure TMaskEdit.Change;
begin
  inherited;
  NotifyPropertyChanged.DoPropertyChanged('Text');
end;



procedure TMaskEdit.CMExit(var Message: TCMExit);
begin
  try
    NotifyPropertyChanged.DoPropertyChanged('Text', utLostFocus);
    inherited;
  except
    on EValidationError do
    begin
      SetFocus;
    end;
  end;
end;



constructor TMaskEdit.Create(AOwner: TComponent);
begin
  inherited;
  FNotifyPropertyChanged := TNotifyPropertyChanged.Create(Self);
end;



procedure TMaskEdit.WMChar(var Message: TWMChar);
begin
  inherited;
  if Message.CharCode = VK_RETURN then
  begin
    NotifyPropertyChanged.DoPropertyChanged('Text', utExplicit);
  end;
end;

end.
