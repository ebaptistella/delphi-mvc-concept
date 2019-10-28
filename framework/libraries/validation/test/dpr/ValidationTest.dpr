program ValidationTest;

{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}


uses
  DUnitTestRunner,
  Framework.Libraries.Connection.ConnectionFactory in '..\..\..\Connection\Framework.Libraries.Connection.ConnectionFactory.pas',
  Framework.Libraries.Exceptions.ExceptionsClass in '..\..\..\Exceptions\Framework.Libraries.Exceptions.ExceptionsClass.pas',
  Framework.Libraries.Validation.ResourceStrings in '..\..\Framework.Libraries.Validation.ResourceStrings.pas',
  Framework.Libraries.Validation.Validate in '..\..\Framework.Libraries.Validation.Validate.pas',
  Framework.Libraries.Validation.ValidateCustomAttributeImpl in '..\..\Framework.Libraries.Validation.ValidateCustomAttributeImpl.pas',
  Framework.Libraries.Validation.ModelMappingImpl in '..\..\Framework.Libraries.Validation.ModelMappingImpl.pas',
  Framework.Libraries.Validation.ExactLengthImpl.Test in '..\pas\Framework.Libraries.Validation.ExactLengthImpl.Test.pas',
  Framework.Libraries.Validation.IsIntegerImpl.Test in '..\pas\Framework.Libraries.Validation.IsIntegerImpl.Test.pas',
  Framework.Libraries.Validation.IsNaturalImpl.Test in '..\pas\Framework.Libraries.Validation.IsNaturalImpl.Test.pas',
  Framework.Libraries.Validation.IsNaturalNoZeroImpl.Test in '..\pas\Framework.Libraries.Validation.IsNaturalNoZeroImpl.Test.pas',
  Framework.Libraries.Validation.MaxLengthImpl.Test in '..\pas\Framework.Libraries.Validation.MaxLengthImpl.Test.pas',
  Framework.Libraries.Validation.MaxValueImpl.Test in '..\pas\Framework.Libraries.Validation.MaxValueImpl.Test.pas',
  Framework.Libraries.Validation.MinLengthImpl.Test in '..\pas\Framework.Libraries.Validation.MinLengthImpl.Test.pas',
  Framework.Libraries.Validation.MinValueImpl.Test in '..\pas\Framework.Libraries.Validation.MinValueImpl.Test.pas',
  Framework.Libraries.Validation.RegexValidateImpl.Test in '..\pas\Framework.Libraries.Validation.RegexValidateImpl.Test.pas',
  Framework.Libraries.Validation.RequiredImpl.Test in '..\pas\Framework.Libraries.Validation.RequiredImpl.Test.pas',
  Framework.Libraries.Validation.ValidatorImpl.Test in '..\pas\Framework.Libraries.Validation.ValidatorImpl.Test.pas',
  Framework.Libraries.Validation.ValidEmailImpl.Test in '..\pas\Framework.Libraries.Validation.ValidEmailImpl.Test.pas',
  Framework.Libraries.Validation.ExactLengthImpl in '..\..\Framework.Libraries.Validation.ExactLengthImpl.pas',
  Framework.Libraries.Validation.ExtendValidationImpl in '..\..\Framework.Libraries.Validation.ExtendValidationImpl.pas',
  Framework.Libraries.Validation.IsIntegerImpl in '..\..\Framework.Libraries.Validation.IsIntegerImpl.pas',
  Framework.Libraries.Validation.IsNaturalImpl in '..\..\Framework.Libraries.Validation.IsNaturalImpl.pas',
  Framework.Libraries.Validation.IsNaturalNoZeroImpl in '..\..\Framework.Libraries.Validation.IsNaturalNoZeroImpl.pas',
  Framework.Libraries.Validation.MaxLengthImpl in '..\..\Framework.Libraries.Validation.MaxLengthImpl.pas',
  Framework.Libraries.Validation.MaxValueImpl in '..\..\Framework.Libraries.Validation.MaxValueImpl.pas',
  Framework.Libraries.Validation.MinLengthImpl in '..\..\Framework.Libraries.Validation.MinLengthImpl.pas',
  Framework.Libraries.Validation.MinValueImpl in '..\..\Framework.Libraries.Validation.MinValueImpl.pas',
  Framework.Libraries.Validation.RegexValidateImpl in '..\..\Framework.Libraries.Validation.RegexValidateImpl.pas',
  Framework.Libraries.Validation.RequiredImpl in '..\..\Framework.Libraries.Validation.RequiredImpl.pas',
  Framework.Libraries.Validation.Validator in '..\..\Framework.Libraries.Validation.Validator.pas',
  Framework.Libraries.Validation.ValidatorImpl in '..\..\Framework.Libraries.Validation.ValidatorImpl.pas',
  Framework.Libraries.Validation.ColumnTitleImpl in '..\..\Framework.Libraries.Validation.ColumnTitleImpl.pas',
  Framework.Libraries.Validation.ValidEmailImpl in '..\..\Framework.Libraries.Validation.ValidEmailImpl.pas';

{R *.RES }



begin
  DUnitTestRunner.RunRegisteredTests;

end.
