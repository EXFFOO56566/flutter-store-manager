import 'package:formz/formz.dart';

enum TaxClassValidationError { empty }

class TaxClass extends FormzInput<String, TaxClassValidationError> {
  const TaxClass.pure([String value = '']) : super.pure(value);
  const TaxClass.dirty([String value = '']) : super.dirty(value);

  @override
  TaxClassValidationError? validator(String? value) {
    return null;
  }
}
