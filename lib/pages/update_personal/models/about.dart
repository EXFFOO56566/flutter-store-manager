import 'package:formz/formz.dart';

enum AboutModelValidationError { empty }

class About extends FormzInput<String, AboutModelValidationError> {
  const About.pure([String value = '']) : super.pure(value);
  const About.dirty([String value = '']) : super.dirty(value);

  @override
  AboutModelValidationError? validator(String? value) {
    return null;
  }
}
