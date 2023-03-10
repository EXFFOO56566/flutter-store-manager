import 'package:formz/formz.dart';

enum StatusValidationError { empty }

class Status extends FormzInput<String, StatusValidationError> {
  const Status.pure([String value = 'publish']) : super.pure(value);
  const Status.dirty([String value = 'publish']) : super.dirty(value);

  @override
  StatusValidationError? validator(String? value) {
    return null;
  }
}
