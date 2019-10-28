unit Framework.MVC.View.UI.FormularioInterno;

interface

uses
  SysUtils,
  Vcl.Forms,
  Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Framework.MVC.View.UI.BaseForm;

type
  TFormFormularioInterno = class(TBaseFormView)
    PnlArea: TPanel;
  public
    constructor Create(AOwner: TComponent; AComponentePai: TWinControl); reintroduce;
  end;

implementation

{$R *.dfm}

{ TFormularioInternoFormView }



constructor TFormFormularioInterno.Create(AOwner: TComponent;
  AComponentePai: TWinControl);
begin
  inherited Create(AOwner);
  Constraints.MaxHeight := 0;
  Constraints.MaxWidth  := 0;
  Constraints.MinHeight := 0;
  Constraints.MinWidth  := 0;
  Self.Top              := 0;
  Self.Left             := 0;
  Self.Height           := AComponentePai.Height;
  Self.Width            := AComponentePai.Width;
  Self.Parent           := AComponentePai;
end;

end.
