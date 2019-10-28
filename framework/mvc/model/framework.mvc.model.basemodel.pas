unit Framework.MVC.Model.BaseModel;

interface

uses
  Vcl.Controls,
  Vcl.Forms,
  Framework.Libraries.Validation.Validator;

type
  IMVCBaseModel = interface(IInvokable)
    ['{8B4D8469-DF79-4593-A987-E3F7E7A8FE97}']
    procedure CopyValuesFrom(const AModel: IMVCBaseModel);
    function GetValidate: IValidator;
    function IsValid(const AView: TForm; const AControl: TWinControl): Boolean;
    procedure AddCustomValidation;

    property Validate: IValidator read GetValidate;
  end;

implementation

end.
