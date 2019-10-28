unit Framework.Libraries.Validation.Validator;

interface

uses
  System.Rtti,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Spring.Persistence.Core.Session;

type
  TAnonymousExtendValidator = reference to function(const AValue: TValue): Boolean;
  TAnonymousExtendValidatorWithSession = reference to function(const AValue: TValue; const ASession: TSession): Boolean;

  IValidator = interface(IInvokable)
    ['{A3A5A5A9-899D-4D1D-BD29-CC2FE3A50585}']
    function MakeAttribute(const AModel: TObject; const AView: TForm; const AAttribute: TWinControl; const AExitOnFirstError: Boolean = False): IValidator; overload;
    function MakeAttribute(const AModel: TObject; const AAttributeName: String; const AExitOnFirstError: Boolean = False): IValidator; overload;
    function MakeAll(const AModel: TObject; const AExitOnFirstError: Boolean = False): IValidator;
    function Fails: Boolean;
    function ErrorMessages: TStringList;
    procedure AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator); overload;
    procedure AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidatorWithSession); overload;

    function GetSession: TSession;

    property Session: TSession read GetSession;
  end;

implementation

end.
