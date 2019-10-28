unit Framework.Libraries.Validation.ResourceStrings;

interface

type
  TResourceStringsValidator = class
  public
    const
    RSValidator_ModelIsNil = 'O modelo não instanciado.';
    RSValidator_AttrNotFound = 'A validação não pode ser aplicada ao modelo "%s". ' + #13#10 + 'O atributo "%s" não foi encontrado no modelo indicado.';
    RSValidator_MappingNotFound = 'A validação não pode ser aplicada ao modelo "%s" pois não foi encontrado o mapeamento do objeto "%s"';
    RSValidation_Required = '* O campo %s é requerido.';
    RSValidation_IsNatural = '* O campo %s deve conter somente números positivos.';
    RSValidation_IsInteger = '* O campo %s deve conter um número inteiro.';
    RSValidation_IsNaturalNoZero = '* O campo %s deve conter um número positivo diferente de zero.';
    RSValidation_ExactLength = '* O campo %s deve ter exatamente %s caracteres.';
    RSValidation_MaxValue = '* O campo %s deve conter um número menor que %s.';
    RSValidation_MinValue = '* O campo %s deve conter um número maior que %s.';
    RSValidation_MaxLength = '* O campo %s deve ter no máximo %s caracteres.';
    RSValidation_MinLength = '* O campo %s deve ter no mínimo %s caracteres.';
    RSValidation_RegexValidate = '* O formato do valor para o campo %s é inválido.';
    RSValidation_ValidEmail = '* O campo %s deve conter um email válido.';
    RSValidation_DB_ValorNaoExiste = '* O valor informado %s não existe na base de dados.';
  end;

implementation

end.
