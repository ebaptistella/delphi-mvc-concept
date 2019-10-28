unit MVCDemo.Views.CRM.PaisView;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  SvBindings,
  DSharp.Bindings.VCLControls,
  Framework.MVC.View.UI.Processo.CRUD;

type
  TFrmPaisView = class(TFormProcessoCRUD)
    [Bind('Descricao', 'Text')]
    EdtDescricao: TLabeledEdit;

    [Bind('Codigo', 'Text')]
    EdtCodigo: TLabeledEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  protected
    procedure DoInitializeForm; override;
    function DoControlCheck(const AControl: TWinControl = nil): Boolean; override;
  public
    procedure DoUpdateView; override;
    procedure DoUpdateModel; override;
  end;

implementation

uses
  System.Rtti,
  System.SysUtils,
  MVCDemo.Models.CRM.PaisModelImpl,
  Vcl.Dialogs,
  System.UITypes;

{$R *.dfm}

{ TFrmPaisView }



procedure TFrmPaisView.Button1Click(Sender: TObject);
begin
  inherited;

  NotificationService.NotifyObservers(self.ClassType, 'FndPaisConsult', [TValue.From<TLabeledEdit>(EdtCodigo)]);
end;



function TFrmPaisView.DoControlCheck(const AControl: TWinControl): Boolean;
begin
  Result := inherited;
  if (not(Result)) then
    Exit(Result);

  if (AControl = EdtCodigo) then
  begin
    if (StrToIntDef(EdtCodigo.Text, 0) > 0) then
    begin
      Result             := NotificationService.NotifyObservers<Boolean>(self.ClassType, 'FindOne', [TValue(EdtCodigo.Text)]);
      BtnExcluir.Enabled := Result;
    end;

    if ((not(Result)) or (StrToIntDef(EdtCodigo.Text, 0) = 0)) then
    begin
      Result := True;
      MessageDlg('Registro novo!', mtCustom, [mbOK], 0);
    end;
  end;
end;



procedure TFrmPaisView.DoInitializeForm;
begin
  inherited;

  EdtCodigo.SetFocus;
end;



procedure TFrmPaisView.DoUpdateModel;
begin
  inherited;
  // implementar esse código se não usar bindings

  // TPaisModelImpl(Model).Codigo    := Trunc(EdtCodigo.Value);
  // TPaisModelImpl(Model).Descricao := EdtDescricao.Text;
end;



procedure TFrmPaisView.DoUpdateView;
begin
  inherited;
  // implementar esse código se não usar bindings

  // EdtCodigo.Text    := IntToStr(TPaisModelImpl(Model).Codigo);
  // EdtDescricao.Text := TPaisModelImpl(Model).Descricao;
end;

end.
