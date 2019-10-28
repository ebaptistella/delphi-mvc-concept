unit MVCDemo.Views.CRM.MunicipioView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Framework.MVC.View.UI.Processo.CRUD,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Mask,
  SvBindings,
  DSharp.Bindings.VCLControls;

type
  TFrmMunicipioView = class(TFormProcessoCRUD)
    [Bind('Codigo', 'Text')]
    EdtCodigo: TLabeledEdit;

    [Bind('Descricao', 'Text')]
    EdtDescricao: TLabeledEdit;

    [Bind('DescricaoReduzida', 'Text')]
    EdtDescrReduz: TLabeledEdit;

    [Bind('CodigoEstado', 'Text')]
    EdtCodigoEstado: TLabeledEdit;
    Button1: TButton;

    procedure EdtDescricaoExit(Sender: TObject);
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
  System.Rtti,
  System.StrUtils,
  System.UITypes;

{$R *.dfm}

{ TFrmMunicipioView }



procedure TFrmMunicipioView.Button1Click(Sender: TObject);
begin
  inherited;

  NotificationService.NotifyObservers(self.ClassType, 'FndMunicipioConsult', [TValue.From<TLabeledEdit>(EdtCodigo)]);
end;



function TFrmMunicipioView.DoControlCheck(const AControl: TWinControl): Boolean;
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



procedure TFrmMunicipioView.DoInitializeForm;
begin
  inherited;

  EdtCodigo.SetFocus;
end;



procedure TFrmMunicipioView.EdtDescricaoExit(Sender: TObject);
begin
  inherited;

  EdtDescrReduz.Text := LeftStr(EdtDescricao.Text, 10);
  EdtDescrReduz.SelectAll;
end;

end.
