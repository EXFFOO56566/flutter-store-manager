import 'package:formz/formz.dart';

enum DescriptionValidationError { empty }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure([String value = '']) : super.pure(value);
  const Description.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String? value) {
    return null;
  }
}
