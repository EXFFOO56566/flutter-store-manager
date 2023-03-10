import 'package:formz/formz.dart';

enum ExternalUrlValidationError { empty }

class ExternalUrl extends FormzInput<String, ExternalUrlValidationError> {
  const ExternalUrl.pure([String value = '']) : super.pure(value);
  const ExternalUrl.dirty([String value = '']) : super.dirty(value);

  @override
  ExternalUrlValidationError? validator(String? value) {
    return null;
  }
}
