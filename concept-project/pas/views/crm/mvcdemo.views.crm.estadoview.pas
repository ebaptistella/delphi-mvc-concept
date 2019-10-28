unit MVCDemo.Views.CRM.EstadoView;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Framework.MVC.View.UI.Processo.CRUD,
  SvBindings,
  DSharp.Bindings.VCLControls;

type
  TFrmEstadoView = class(TFormProcessoCRUD)
    [Bind('Codigo', 'Text')]
    EdtCodigo: TLabeledEdit;

    [Bind('Descricao', 'Text')]
    EdtDescricao: TLabeledEdit;

    [Bind('CodigoPais', 'Text')]
    EdtCodigoPais: TLabeledEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoInitializeForm; override;
    function DoControlCheck(const AControl: TWinControl = nil): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  System.SysUtils,
  System.Rtti,
  Vcl.Dialogs,
  System.UITypes;

{$R *.dfm}

{ TFrmEstadoView }



procedure TFrmEstadoView.Button1Click(Sender: TObject);
begin
  inherited;

  NotificationService.NotifyObservers(self.ClassType, 'FndEstadoConsult', [TValue.From<TLabeledEdit>(EdtCodigo)]);
end;



function TFrmEstadoView.DoControlCheck(const AControl: TWinControl): Boolean;
begin
  Result := inherited;
  if (not(Result)) then
    Exit(Result);

  if (AControl = EdtCodigo) then
  begin
    if (Trim(EdtCodigo.Text) <> EmptyStr) then
    begin
      Result             := NotificationService.NotifyObservers<Boolean>(self.ClassType, 'FindOne', [TValue(EdtCodigo.Text)]);
      BtnExcluir.Enabled := Result;
    end;

    if ((not(Result)) or (Trim(EdtCodigo.Text) = EmptyStr)) then
    begin
      Result := True;
      MessageDlg('Registro novo!', mtCustom, [mbOK], 0);
    end;
  end;
end;



procedure TFrmEstadoView.DoInitializeForm;
begin
  inherited;

  EdtCodigo.SetFocus;
end;

end.
