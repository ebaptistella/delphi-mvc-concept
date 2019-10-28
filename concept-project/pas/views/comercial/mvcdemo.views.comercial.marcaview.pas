unit MVCDemo.Views.Comercial.MarcaView;

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
  SvBindings,
  DSharp.Bindings.VCLControls;

type
  TFrmMarcaView = class(TFormProcessoCRUD)
    [Bind('Codigo', 'Text')]
    EdtCodigo: TLabeledEdit;

    [Bind('Descricao', 'Text')]
    EdtDescricao: TLabeledEdit;

    [Bind('DescricaoReduzida', 'Text')]
    EdtDescrReduz: TLabeledEdit;
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

var
  FrmMarcaView: TFrmMarcaView;

implementation

uses
  System.Rtti,
  System.UITypes;

{$R *.dfm}

{ TFrmMarcaView }



procedure TFrmMarcaView.Button1Click(Sender: TObject);
begin
  inherited;

  NotificationService.NotifyObservers(self.ClassType, 'FndMarcaConsult', [TValue.From<TLabeledEdit>(EdtCodigo)]);
end;



function TFrmMarcaView.DoControlCheck(const AControl: TWinControl): Boolean;
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



procedure TFrmMarcaView.DoInitializeForm;
begin
  inherited;

  EdtCodigo.SetFocus;
end;

end.
