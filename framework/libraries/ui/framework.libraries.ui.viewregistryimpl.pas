unit Framework.Libraries.UI.ViewRegistryImpl;

interface

uses
  Vcl.Forms,
  System.SysUtils,
  System.Generics.Collections,
  Framework.Libraries.InterfacedObjectLoggableImpl;

type
  TResolveView = TFunc<TForm>;
  TCreateViewEvent = procedure(const AView: TForm; const AClassName: String) of object;
  TCreateFormEvent = function(const AFormClass: TFormClass): TForm of object;

  TViewInfo = record
    ViewClass: TFormClass;
    ResolveView: TResolveView;
    Unique: Boolean;

    constructor Create(const AViewClass: TFormClass; const AResolveView: TResolveView; const AUnique: Boolean = True);
  end;

  PViewInfo = ^TViewInfo;

  TViewRegistryImpl = class(TInterfacedObjectLoggableImpl, IInvokable)
  private
    type
    TViewInfoList = TDictionary<String, TViewInfo>;
  private
    FDashboardClassName: String;
    FItems: TViewInfoList;
    FOnAfterCreateView: TCreateViewEvent;
    FOnCreateForm: TCreateFormEvent;

    function GetItems(const AClassName: String): TViewInfo;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Add(const AViewClass: TFormClass; const AResolveView: TResolveView; const AUnique: Boolean = False); overload;

    property DashboardClassName: String read FDashboardClassName write FDashboardClassName;
    property Items[const AClassName: String]: TViewInfo read GetItems; default;
    property OnAfterCreateView: TCreateViewEvent read FOnAfterCreateView write FOnAfterCreateView;
    property OnCreateForm: TCreateFormEvent read FOnCreateForm write FOnCreateForm;
  end;

implementation

{ TViewRegistryImpl }



procedure TViewRegistryImpl.Add(const AViewClass: TFormClass; const AResolveView: TResolveView; const AUnique: Boolean);
begin
  FItems.AddOrSetValue(AViewClass.ClassName, TViewInfo.Create(AViewClass, AResolveView, AUnique));
end;



procedure TViewRegistryImpl.AfterConstruction;
begin
  inherited;

  FItems := TViewInfoList.Create;
end;



procedure TViewRegistryImpl.BeforeDestruction;
begin
  inherited;

  FItems.Free;
end;



function TViewRegistryImpl.GetItems(const AClassName: String): TViewInfo;
begin
  Result := FItems[AClassName];
end;



{ TViewInfo }
constructor TViewInfo.Create(const AViewClass: TFormClass; const AResolveView: TResolveView; const AUnique: Boolean);
begin
  ViewClass   := AViewClass;
  ResolveView := AResolveView;
  Unique      := AUnique;
end;

end.
